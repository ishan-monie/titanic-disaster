FROM python:3.10-slim

# Set working directory
WORKDIR /app/src/code

# Copy only requirements first (so dependencies are cached)
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Now copy the rest of your code and data
COPY src/code/ ./
COPY data/ ../../data/

# Run your script
CMD ["python", "main.py"]
