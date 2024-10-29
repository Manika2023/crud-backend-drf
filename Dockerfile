# Use an official Python image as a base
FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y gcc default-libmysqlclient-dev build-essential

# Set up a virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy project files to the Docker image
WORKDIR /app
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose port (e.g., 8000 for Django)
EXPOSE 8000

# Start the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
