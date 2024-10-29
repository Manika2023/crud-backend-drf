# Use an official Python image as a base
FROM python:3.10-slim

# Install system dependencies needed for building packages
RUN apt-get update && \
    apt-get install -y gcc default-libmysqlclient-dev build-essential pkg-config && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /crud

# Copy only requirements.txt first to leverage Docker's cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copy the rest of the project files to the Docker image
COPY . .

# Expose port (e.g., 8000 for Django)
EXPOSE 8000

# Start the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
