FROM python:3.12-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV TESSDATA_PREFIX=/usr/share/tesseract-ocr/5/tessdata

RUN apt-get update && apt-get install -y --no-install-recommends \
	ffmpeg \
	tesseract-ocr \
	tesseract-ocr-por \
	libleptonica-dev \
	libtesseract-dev \
	&& rm -rf /var/lib/apt/lists/*

COPY pyproject.toml README.md ./
COPY __init__.py ./
COPY *.py ./
COPY modules ./modules
COPY training ./training
COPY tests ./tests
COPY docs ./docs

RUN pip install --no-cache-dir python-multipart && \
    pip install --no-cache-dir -e . && \
    pip install --no-cache-dir pytest

EXPOSE 8000

CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]