# Dockerfile en grpc/cliente

# Imagen base
FROM python:3.9-slim

# Establecer directorio de trabajo
WORKDIR /app

# Copiar dependencias y el código fuente del cliente
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el archivo .proto desde la ruta relativa
COPY ../protos/example.proto ./protos/

# Instalar protobuf y grpc-tools, y compilar el archivo .proto
RUN apt-get update && apt-get install -y protobuf-compiler && \
    pip install grpcio grpcio-tools && \
    python -m grpc_tools.protoc -I./protos --python_out=. --grpc_python_out=. ./protos/example.proto && \
    apt-get remove -y protobuf-compiler && apt-get autoremove -y && apt-get clean

# Copiar el script del cliente
COPY client.py .

# Comando de inicio
CMD ["python", "client.py"]
