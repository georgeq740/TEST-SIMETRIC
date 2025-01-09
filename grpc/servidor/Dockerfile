# Usar la imagen base
FROM python:3.9-slim

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos necesarios
COPY requirements.txt .
COPY server.py .
COPY ../protos/example.proto ./protos/

# Instalar las dependencias necesarias
RUN apt-get update && apt-get install -y protobuf-compiler && \
    pip install grpcio grpcio-tools && \
    python -m grpc_tools.protoc -I./protos --python_out=. --grpc_python_out=. ./protos/example.proto && \
    apt-get remove -y protobuf-compiler && apt-get autoremove -y && apt-get clean

# Instalar las dependencias del servidor
RUN pip install --no-cache-dir -r requirements.txt

# Comando para iniciar el servidor
CMD ["python", "server.py"]
