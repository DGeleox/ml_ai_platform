# ML AI Platform

ML AI Platform is a Python service template for building machine learning and
AI-backed APIs. The current application exposes a FastAPI service with a health
check endpoint and provides a foundation for training, evaluation, LLM, and
pipeline modules.

## Stack

- Python 3.13+
- FastAPI
- Pydantic
- Uvicorn
- uv for dependency management
- Ruff, mypy, and pytest for code quality and tests

## Project Structure

```text
app/          FastAPI application, API routes, schemas, and services
training/     Training entrypoints and training-related code
evaluation/   Evaluation-related code
llm/          LLM integration code
pipelines/    Pipeline orchestration code
tests/        Automated tests
configs/      Configuration files
docs/         Project documentation
docker/       Docker-related files
```

## Setup

Install dependencies from the lock file:

```bash
uv sync --locked --all-groups
```

Create a local environment file if needed:

```bash
cp .env.example .env
```

## Run the API

Start the FastAPI application locally:

```bash
uv run uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

The service exposes:

- `GET /health` - returns the application health status.

## Quality Checks

Run linting:

```bash
uv run ruff check .
```

Run type checking:

```bash
uv run mypy app training evaluation llm pipelines tests
```

Run tests:

```bash
uv run pytest
```

## Continuous Integration

GitHub Actions runs the same quality checks and tests for pull requests to
`main`:

- Ruff linting
- mypy type checking
- pytest test suite

Configure the `Quality and tests` check as a required status check in GitHub
branch protection settings to block merging until CI passes.
