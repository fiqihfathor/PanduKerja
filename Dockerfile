FROM python:3.12-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:0.6.0 /uv /uvx /bin/

WORKDIR /app

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project --no-editable
    

ADD . /app

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen

CMD ["uv", "run", "hello.py"]