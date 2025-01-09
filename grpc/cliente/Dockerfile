FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY client.py .
COPY example_pb2.py .
COPY example_pb2_grpc.py .
COPY protos/example.proto ./protos/

CMD ["python", "client.py"]
