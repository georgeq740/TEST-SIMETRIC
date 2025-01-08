FROM python:3.9-slim
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y protobuf-compiler && \
    pip install grpcio grpcio-tools && \
    python -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=. example.proto && \
    apt-get remove -y protobuf-compiler && apt-get autoremove -y && apt-get clean
RUN pip install -r requirements.txt

CMD ["python", "client.py"]
