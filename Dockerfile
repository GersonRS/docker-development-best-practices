FROM python:3.8-alpine AS builder

WORKDIR /app

RUN python -m venv .venv && .venv/bin/pip install --no-cache-dir -U pip setuptools
COPY requirements.txt .
RUN .venv/bin/pip install --no-cache-dir -r requirements.txt
COPY app.py .

FROM python:3.8-alpine

WORKDIR /app

COPY --from=builder /app /app
COPY app.py .
ENV PATH="/app/.venv/bin:$PATH"
CMD [ "python", "app.py" ]