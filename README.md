# Webespeis

Sitio web del JáquerEspeis de Costa Rica.

Para agregar contenido al sitio es necesario formar parte de la organización
del JáquerEspeis en github, instalar las dependencias, obtener el repositorio,
instalar nikola, crear un nueva rama, escribir la entrada, subir la rama y
hacer una solicitud de pull. Abajo se describe cada paso.

(Probado solo en Ubuntu 15.04 y 15.10)

## Formar parte del jaquerespeis

Si no forma parte de la organización del JáquerEspeis en github, solicite el
acceso a [alguno o alguna de los miembros]
(https://github.com/orgs/JaquerEspeis/people).

## Dependencias

Para instalar todos los requerimientos para obtener y construir el sitio web:

    sudo apt-get install git python3-virtualenv python3-pip python3-dev \
    libxml2-dev libxslt1-dev

## Código fuente

Los archivos fuente están hospedados en github. Para obtener el repositorio por
primera vez:

    mkdir ~/workspace
    cd ~/workspace
    git clone https://github.com/jaquerespeis/webespeis.git
    cd webespeis

Si ya había descargado el código antes, entre al directorio del proyecto y
sincronice la rama `master`:

    cd ~/workspace/webespeis
    git checkout master
    git pull

## Instalar Nikola

Este es un sitio web estático generado con [Nikola](https://getnikola.com/). La
mejor forma para instalar Nikola es usar pip en un virtualenv:

    virtualenv --python=python3 .env
    source .env/bin/activate
    pip install --upgrade "Nikola[extras]"

El primer comando crea el virtualenv dentro del directorio del repositorio.
Solo es necesario hacerlo una vez. Para proponer cambios las veces siguientes
solo active el .env con el segundo comando.

## Instalar complementos de Nikola

    nikola plugin -i import_feed

## Crear una nueva rama

La rama `master` tiene el contenido que se publica en el sitio web. Las ramas
locales adicionales simplifican el control de cambios y permiten mantener
`master` limpia y sincronizada. Sus cambios estarán en esta rama local, y
`master` solo será modificada hasta que alguien más revise y apruebe sus
cambios.

Para crear una nueva rama:

    git checkout -b nueva-entrada

Las ramas deben tener un nombre único, entonces cambie `nueva-entrada` por un
identificador que describa los cambios que quiere realizar.

## Publicar

Para escribir una nueva entrada en el blog:

    nikola new_post

Ingrese el título de la nueva entrada. Nikola generará dos archivos con ese
título como nombre, uno para los metadatos y el otro para el texto de la
entrada.

## Escribir

Las entradas se escriben con el formato de markdown. Puede encontrar la
sintaxis de este formato en http://daringfireball.net/projects/markdown/syntax

Abra el archivo con la extensión .md en un editor de texto. Por ejemplo, si
el título de la entrada es `prueba`, el archivo sería `posts/prueba.md`. El
archivo con la entrada sería algo como:

    Esta es una entrada de prueba.

    1. Este es el primer elemento de una lista numerada.
    1. Este es el segundo elemento de una lista numerada.
    1. Este es el tercer elemento de una lista numerada.

    # Este es un título

    Más texto...

## Importar posts desde canales de redifusión

Para agregar una fuente de redifusión, agregue la dirección del canal RSS o
Atom al archivo `feeds.list`.

Para importar las entradas de todas las fuentes:

    <feeds.list xargs -I % nikola import_feed --url=% -o .

## Construir

Construya los archivos del sitio web con:

    nikola build

## Probar

Puede ver el sitio web generado con:

    nikola serve -b

## Agregar sus cambios al repositorio

Todos los archivos que agregó y modificó con sus cambios deben ser agregados
al repositorio. Por ejemplo, para agregar la entrada de prueba:

    git add posts/prueba.md
    git add posts/prueba.meta

Después de esto:

    git commit -m 'Agregué una entrada de prueba.'

Cambiando el texto entre comillas por un mensaje descriptivo del cambio que
acaba de realizar.

## Subir la rama a github

Una vez que haya probado sus cambios y esté satisfecho, suba la rama a github:

    git push --set-upstream origin nueva-entrada

Cambiando `nueva-entrada` por el nombre de la rama que escogió en uno de los
pasos anteriores.

## Solicitud de pull

Una solicitud de pull permite que otros miembros del proyecto revisen sus
cambios antes de que sean publicados en el sitio web. Ningún cambio por pequeño
y trivial que sea debería ser publicado sin ser revisado por alguna otra
persona.

Para solicitar el pull debe ir a la página de github del proyecto, seleccionar
la rama que subió en el paso anterior, comparar las ramas y hacer clic en
`Create pull request`.

Las instrucciones están en la [ayuda de github]
(https://help.github.com/articles/creating-a-pull-request/).

Luego de esto, los y las demás miembros del proyecto serán notificados de que
hay una revisión pendiente.

## Salir del virtualenv

Para salir del virtualenv:

    deactivate

## Licencia

Usted es libre de usar, mezclar y distribuir todo siempre que siga los términos
de la licencia Creative Commons Attribution-ShareAlike. Vea el archivo LICENSE.
