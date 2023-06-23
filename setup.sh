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

# Instalar Docker Compose
function install_docker_compose() {
    # Verificar si Docker Compose está instalado
    if ! command -v docker-compose &> /dev/null; then
        echo "Instalando Docker Compose..."
        sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
        echo "Docker Compose instalado correctamente."
    else
        echo "Docker Compose ya está instalado."
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
    docker-compose up -d
    echo "it-support-web ejecutado correctamente."
}

# Menú principal
function main_menu() {
    clear
    echo "=== Instalación y configuración de it-support-web ==="
    echo ""
    echo "Seleccione una opción:"
    echo "1. Instalar Docker"
    echo "2. Instalar Docker Compose"
    echo "3. Configurar permisos de usuario para Docker"
    echo "4. Instalar dependencias de npm"
    echo "5. Ejecutar it-support-web"
    echo "6. Salir"
    echo ""

    while true; do
        read -p "Ingrese su elección [1-6]: " choice

        case $choice in
            1)
                install_docker
                show_progress 1 6
                sleep 1
                ;;
            2)
                install_docker_compose
                show_progress 2 6
                sleep 1
                ;;
            3)
                configure_docker_permissions
                show_progress 3 6
                sleep 1
                ;;
            4)
                install_npm_dependencies
                show_progress 4 6
                sleep 1
                ;;
            5)
                run_it_support_web
                show_progress 5 6
                sleep 1
                ;;
            6)
                echo "Saliendo..."
                exit 0
                ;;
            *)
                echo "Opción inválida. Por favor, seleccione una opción válida."
                ;;
        esac

        show_progress 0 6
        echo ""
    done
}

# Ejecutar el menú principal
main_menu