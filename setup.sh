#!/bin/bash

# Función para mostrar una barra de progreso
function show_progress() {
    local progress=$1
    local max=$2
    local width=50
    local bar_length=$((progress * width / max))
    local bar=$(printf "%${bar_length}s" | tr ' ' '#')
    local percentage=$((progress * 100 / max))
    printf "\r[%-${width}s] %d%%" "$bar" "$percentage"
}

# Instalar Docker
function install_docker() {
    # Verificar si Docker está instalado
    if ! command -v docker &> /dev/null; then
        echo "Instalando Docker..."
        curl -fsSL https://get.docker.com | sh
        echo "Docker instalado correctamente."
    else
        echo "Docker ya está instalado."
    fi
}

# Configurar permisos de usuario para Docker
function configure_docker_permissions() {
    echo "Configurando permisos de usuario para Docker..."
    sudo usermod -aG docker $USER
    echo "Permisos de usuario configurados correctamente."
}

# Instalar dependencias de npm
function install_npm_dependencies() {
    echo "Instalando dependencias de npm..."
    npm install
    echo "Dependencias de npm instaladas correctamente."
}

# Crear archivo package.json y carpeta /app
function create_package_json() {
    echo "Creando archivo package.json y carpeta /app..."
    echo '{ "name": "it-support-web", "version": "1.0.0", "main": "server.js" }' > package.json
    mkdir app
    echo "Archivo package.json y carpeta /app creados correctamente."
}

# Ejecutar el proceso de creación del contenedor
function create_container() {
    echo "Creando contenedor de it-support-web..."
    docker-compose up -d
    echo "Contenedor creado correctamente."
}

# Obtener la dirección IP del contenedor
function get_container_ip() {
    local container_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' it-support-web_app)
    echo "Puede acceder al proyecto it-support-web en el siguiente enlace: http://$container_ip"
}

# Menú principal
function main_menu() {
    clear
    echo "=== Instalación y configuración de it-support-web ==="
    echo ""
    echo "Seleccione una opción:"
    echo "1. Instalar Docker"
    echo "2. Configurar permisos de usuario para Docker"
    echo "3. Instalar dependencias de npm"
    echo "4. Crear archivo package.json y carpeta /app"
    echo "5. Ejecutar el proceso de creación del contenedor"
    echo "6. Obtener la dirección IP del contenedor"
    echo "7. Salir"
    echo ""

    while true; do
        read -p "Ingrese su elección [1-7]: " choice

        case $choice in
            1)
                install_docker
                show_progress 1 7
                sleep 1
                ;;
            2)
                configure_docker_permissions
                show_progress 2 7
                sleep 1
                ;;
            3)
                install_npm_dependencies
                show_progress 3 7
                sleep 1
                ;;
            4)
                create_package_json
                show_progress 4 7
                sleep 1
                ;;
            5)
                create_container
                show_progress 5 7
                sleep 1
                ;;
            6)
                get_container_ip
                show_progress 6 7
                sleep 1
                ;;
            7)
                echo "Saliendo..."
                exit 0
                ;;
            *)
                echo "Opción inválida. Por favor, seleccione una opción válida."
                ;;
        esac

        show_progress 0 7
        echo ""
    done
}

# Ejecutar el menú principal
main_menu
