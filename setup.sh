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

# Ejecutar el proyecto it-support-web
function run_it_support_web() {
    echo "Ejecutando it-support-web..."
    docker build -t it-support-app .
    docker run -d --name app-container -p 80:80 --link mysql-container:mysql it-support-app
    echo "it-support-web ejecutado correctamente."
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
    echo "4. Ejecutar it-support-web"
    echo "5. Salir"
    echo ""

    while true; do
        read -p "Ingrese su elección [1-5]: " choice

        case $choice in
            1)
                install_docker
                show_progress 1 5
                sleep 1
                ;;
            2)
                configure_docker_permissions
                show_progress 2 5
                sleep 1
                ;;
            3)
                install_npm_dependencies
                show_progress 3 5
                sleep 1
                ;;
            4)
                run_it_support_web
                show_progress 4 5
                sleep 1
                ;;
            5)
                echo "Saliendo..."
                exit 0
                ;;
            *)
                echo "Opción inválida. Por favor, seleccione una opción válida."
                ;;
        esac

        show_progress 0 5
        echo ""
    done
}

# Ejecutar el menú principal
main_menu
