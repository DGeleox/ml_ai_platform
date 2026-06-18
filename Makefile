UV ?= uv
PYTHON ?= $(UV) run python
APP ?= app.main:app
HOST ?= 0.0.0.0
PORT ?= 8000
IMAGE ?= ml-ai-platform
MYPY_PATHS ?= app training evaluation llm pipelines tests
COMPOSE ?= docker compose

.PHONY: help test lint format typecheck train serve docker-build docker-up docker-down

help:
	@echo Available targets:
	@echo   test          Run pytest
	@echo   lint          Run Ruff lint checks
	@echo   format        Fix Ruff lint issues and format code
	@echo   typecheck     Run mypy
	@echo   train         Run the training entrypoint
	@echo   serve         Start the FastAPI app with uvicorn
	@echo   docker-build  Build the application Docker image
	@echo   docker-up     Start services with Docker Compose
	@echo   docker-down   Stop services with Docker Compose

test:
	$(UV) run pytest

lint:
	$(UV) run ruff check .

format:
	$(UV) run ruff check --fix .
	$(UV) run ruff format .

typecheck:
	$(UV) run mypy $(MYPY_PATHS)

train:
	$(PYTHON) -m training.train

serve:
	$(UV) run uvicorn $(APP) --host $(HOST) --port $(PORT) --reload

docker-build:
	docker build -t $(IMAGE) .

docker-up:
	$(COMPOSE) up --build

docker-down:
	$(COMPOSE) down
