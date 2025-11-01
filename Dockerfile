FROM python:3.10-slim

WORKDIR /app/src/code

COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

COPY src/code/ ./
COPY data/ ../../data/

CMD ["python", "main.py"]
