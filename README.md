# Webespeis

Sitio web del JaquerEspeis de Costa Rica.

## Dependencias

Para instalar todos los requerimientos para obtener y construir el sitio web:

    sudo apt-get install git python3-virtualenv python3-pip python3-dev \
    libxml2-dev libxslt1-dev

(Probado solo en Ubuntu 15.04)

## Código fuente

Los archivos fuente están hospedados en github. Para obtener el repositorio:

    git clone https://github.com/jaquerespeis/webespeis.git

## Obtener Nikola

Este es un sitio web estático generado con [Nikola](https://getnikola.com/). La
mejor forma para instalar Nikola es usar pip en un virtualenv:

    virtualenv --python=python3 .env
    source .env/bin/activate
    pip install --upgrade "Nikola[extras]"

## Publicar

Para escribir una nueva entrada en el blog:

    cd webespeis
    nikola new_post

Ingrese el título de la nueva entrada. Nikola generará dos archivos con ese
título como nombre, uno para los metadatos y el otro para el texto de la
entrada. Abra los archivos y llénelos.

## Construir

Construya los archivos del sitio web con:

    nikola build

## Probar

Puede ver el sitio web generado con:

    nikola serve -b

## Licencia

Usted es libre de usar, mezclar y distribuir todo siempre que siga los términos
de la licencia Creative Commons Attribution-ShareAlike. Vea el archivo LICENSE.