# Guía para el Despliegue de la Aplicación en AWS utilizando Terraform y CodeBuild

Esta guía tiene como objetivo proporcionar los pasos necesarios para desplegar una aplicación basada en gRPC utilizando el servicio de CodeBuild de AWS. El despliegue está diseñado para ejecutarse cada vez que se realiza un merge en la rama `master`, asegurando un flujo de integración y despliegue continuo.

---

## Configuración del Repositorio

El código fuente y la configuración están alojados en el repositorio público de GitHub:  
**[https://github.com/georgeq740/TEST-SIMETRIC](https://github.com/georgeq740/TEST-SIMETRIC)**

### Estructura del Repositorio

#### **Carpetas**
- **grpc/**: Contiene los archivos fuente para implementar la aplicación con el protocolo gRPC para los servicios cliente y servidor.
- **app/**: Directorio de Terraform con los módulos de infraestructura reutilizables.
- **modules/**: Carpeta que almacena los módulos reutilizables de infraestructura como código (IaC) para Terraform. Estos módulos encapsulan configuraciones de networking y clústeres EKS, para facilitar su uso en otros proyectos.

#### **Archivos**
- **buildspec.yml**: Define las fases de construcción, prueba y despliegue para ser ejecutado en CodeBuild.
- **docker-compose.yml**: Archivo que define los servicios de Docker.

---

## Pipeline Automatizado con AWS CodeBuild

El archivo `buildspec.yml` controla el flujo de construcción e implementación:

### **Fases de Ejecución**

1. **Instalación**:
   - Configura dependencias necesarias, como Docker y Terraform.

2. **Preconstrucción**:
   - Inicia sesión en Amazon ECR para subir imágenes Docker.

3. **Construcción**:
   - Compila los archivos `.proto` necesarios para gRPC.
   - Construye las imágenes Docker para los servicios cliente y servidor.
   - Publica las imágenes Docker en Amazon ECR.

4. **Postconstrucción**:
   - Configura y valida el acceso a Kubernetes (EKS).
   - Aplica cambios de infraestructura utilizando Terraform.
   - Verifica que los recursos en Kubernetes estén funcionando correctamente (nodos, pods, servicios e ingress).

---

## Configuración de Terraform

Se usan dos módulos principales definidos en el directorio `app/`:

### **Módulo de Configuraciones Globales**
Este módulo contiene una configuración centralizada para gestionar los entornos usando la funcionalidad de **workspace** de Terraform. Su objetivo es permitir despliegues consistentes y preconfigurados en entornos como `dev`, `qa`, `staging` y `prod`, ajustando automáticamente las configuraciones necesarias según el workspace activo.

### **Módulo de Networking**
- Configura las subredes públicas y privadas.
- Configura tablas de ruteo para el tráfico público y privado.

### **Módulo de EKS**
- Despliega el clúster de EKS.
- Define los recursos de Kubernetes necesarios para ejecutar las aplicaciones gRPC.

---

## Estado Remoto

El estado de Terraform se almacena en un bucket S3 para garantizar la consistencia en el despliegue. También utiliza una tabla de DynamoDB (`terraform-lock-table`) para gestionar los bloqueos de estado y evitar conflictos cuando múltiples usuarios intentan modificar la infraestructura al mismo tiempo.

---

## Proceso de Despliegue

### **1. Configuración Inicial**

1. **Clonar el repositorio desde GitHub:**
   ```bash
   git clone https://github.com/georgeq740/TEST-SIMETRIC.git
