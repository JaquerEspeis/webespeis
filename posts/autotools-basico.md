.. title: Autotools básico
.. slug: autotools-basico
.. date: 2016-05-03 15:28:43 UTC-06:00
.. tags: autotools, autoconf, automake
.. link: 
.. description: Crear paquetes de código fuente ("tarballs") usando el GNU Build System
.. type: text

# Propósito

Crear paquetes de código fuente utilizando las herramientas de construcción
de GNU (Autoconf, Automake y Libtool) a partir de uno o más ficheros de código
fuente y los ficheros `configure.ac` y `Makefile.am`.

Esta guía muestra cómo a partir de un fichero fuente `holamundo.c` y el par de
ficheros mencionados anteriormente se generará un archivo llamado
`holamundo-1.0.0.tar.gz` que una vez desempaquetado se pueda compilar e
instalar con el típico "`./configure && make && sudo make install`".

## Ventajas

- Portabilidad, permite generar makefiles compatibles con diferentes
  implementaciones de Make, múltiples compiladores e intérpretes y generar
  scripts compatibles con múltiples shell.
  
- Multiplataforma, los scripts generados facilitan las comprobaciones y
  configuraciones necesarias para generar una compilación cruzada, por ejemplo
  generar binarios para otra arquitectura agregando pocos parámetros.

# Herramientas

- `autoconf`, se encarga de generar el script `configure` a partir del fichero
  `configure.ac`.

- `automake`, genera el fichero `Makefile.in` a partir del fichero
  `Makefile.am`.

- `libtool`, gestiona la creación de librerías estáticas y dinámicas,
  y también la _carga_ (en tiempo de ejecución) de librerías dinámicas.

Dentro del paquete `autoconf` hay otras herramientas relevantes como `aclocal`
y `autoheader`. En este ejemplo básico se ejecutan de forma automática todas
las herramientas mencionadas utilizando la herramienta `autoreconf`.

## Herramientas relacionadas

- `make`, procesa archivos `Makefile`. Existen varias implementaciones (GNU
  Make, BSD Make...) con algunas incompatibilidades que autotools solventa.

- `pkg-config`, facilita información sobre la mayoría de las librerías
  instaladas en el sistema (ubicación, dependencias, versión, etc.).

# ¡Hola, Autotools!

Para crear el ejemplo básico de paquete es conveniente disponer de una carpeta
de trabajo para tenerlo mejor organizado.

- Crear una carpeta `holamundo` con una subcarpeta `src` para el código fuente
  y a continuación ubicarse en la carpeta de trabajo:

```bash
mkdir -p holamundo/src
cd holamundo
```

## src/holamundo.c

- Crear un fichero de código fuente C en `src/holamundo.c`:

```c
#include <stdio.h>

int main() {
	printf("Hola Mundo!\n");

	return 0;
}
```

## Makefile.am

- Crear un fichero `Makefile.am`:

```Makefile
bin_PROGRAMS = holamundo
holamundo_SOURCES = src/holamundo.c
```

## configure.ac

- Ejecutar la herramienta `autoscan` en la carpeta de trabajo. Creará
  un fichero llamado `configure.scan` que hay que renombrar a `configure.ac`:

```bash
autoscan
mv configure.scan configure.ac
```

Nos habrá generado un fichero `configure.ac` parecido al siguiente:

```bash
#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AC_CONFIG_SRCDIR([src/holamundo.c])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
```

- Modificar la macro `AC_INIT` del fichero `configure.ac` para mostrar el
  nombre del paquete, versión y dirección para avisar sobre errores (correo
  electrónico o web):

```
AC_INIT([holamundo], [1.0.0], [https://github.com/JaquerEspeis/webespeis/issues])
```

- Agregar la macro `AM_INIT_AUTOMAKE` en el fichero `configure.ac` para poder
generar los Makefiles. Un buen lugar sería después de la línea de
`AC_CONFIG_HEADERS`:

```
AM_INIT_AUTOMAKE([foreign subdir-objects])
```

Una vez modificado el fichero `configure.ac` debería ser parecido al siguiente:

```bash
#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([holamundo], [1.0.0], [fran@fran.cr])
AC_CONFIG_SRCDIR([src/holamundo.c])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE([foreign subdir-objects])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.

# Checks for header files.

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
```

## Generar configure y Makefile.in

- Ejecutar:

```bash
autoreconf -i
```

## Generar Makefile

```bash
./configure
```

## Generar paquete ("tarball")

```bash
make dist
```

Se habrá generado `holamundo-1.0.0.tar.gz`

# Instalación genérica del paquete

- Descomprimir:

```bash
tar xf holamundo-1.0.0.tar.gz
```

- Entrar en la carpeta comprimida:

```bash
cd holamundo-1.0.0
```

- Generar Makefile:

```bash
./configure
```

- Construir:

```bash
make
```

- Instalar:

```bash
sudo make install
```

# Detalles de los ficheros creados

## Makefile.am

`bin_PROGRAMS` indica la lista de programas (binarios en este caso) que va
a crearse. En este caso se va a crear un binario llamado `holamundo`.

`holamundo_SOURCES` indica que nuestro `holamundo` tiene un listado de
`_SOURCES` (ficheros fuente). En este ejemplo solamente hay uno
(`src/holamundo.c`). Si el proyecto tuviera más ficheros de código fuente para
crear el programa se separan con espacios. Si se desea poner un fichero por
línea para hacer el mantenimiento de `Makefile.am` más limpio se puede utilizar
`\` al final de la línea para indicar que continúa en la siguiente, por lo
tanto:

    holamundo_SOURCES = \
    	fichero1.c \
    	fichero2.c \
    	fichero3.c

es lo mismo que:

    holamundo_SOURCES = fichero1.c fichero2.c fichero3.c

## configure.ac

`foreign` indica que se está creando un paquete GNU estándar (no exigirá la
existencia de los ficheros `ChangeLog`, `COPYING`, `NEWS` y `README` para
funcionar).

`subdir-objects` indica que se está usando el modo recursivo, es decir, no se
van a usar múltiples ficheros Makefile.am para cada carpeta con objetivos a
procesar.

`AC_PREREQ` indica la versión mínima de autoconf requerida para funcionar con
el archivo de configuración.

`AC_CONFIG_SRCDIR` comprueba que el código fuente existe en la carpeta indicada
mediante la comprobación de algún fichero fuente de la misma.

`AC_CONFIG_HEADERS` indica el nombre que tendrá el archivo de configuración
de código fuente generado. Esto permite crear definiciones (por ejemplo,
`#define LOQUESEA 1`) en el archivo indicado (por defecto, `config.h`) que
podrá ser incluido en el código fuente. Estas definiciones podrían variar
según lo que compruebe el script `configure`, resultando muy útil por ejemplo
para verificar si el programa se ha compilado con o sin soporte de una
característica en particular, por ejemplo para dependencias opcionales de
librerías o comprobaciones de funcionalidad del compilador o de un sistema
operativo en tiempo de compilación.

`AC_PROG_CC` comprueba la existencia de un compilador de C. Como autoscan ha
detectado código fuente en C se ha agregado esta macro automáticamente.

`AC_CONFIG_FILES` recibe en el primer parámetro una lista de ficheros separados
con espacios. (en este caso solo `Makefile`, que generará a partir de
`Makefile.in`). Los ficheros con extensión .in se utilizan para sustituir los
valores de las variables que contienen y generar el archivo de salida,
normalmente con el mismo nombre sin el `.in`. Este proceso lo realiza la macro
`AC_OUTPUT`.

## Algunos parámetros del script configure

El parámetro `--prefix` permite indicar el directorio base de instalación, que
por defecto suele ser `/usr/local`. Por ejemplo el programa `holamundo` se
copiaría por defecto a la carpeta `/usr/local/bin` si no se cambia el
`--prefix`. Las distribuciones suelen usar en sus paquetes `--prefix=/usr`.
Si se quiere instalar un paquete y no se tienen permisos de superusuario se
podría indicar una ruta dentro de la $HOME donde usualmente se suelen tener
permisos de escritura.

`./configure --help` muestra información detallada de los parámetros.

### Compilación cruzada con el script configure

El parámetro `--host` permite utilizar de forma sencilla toolchains para
compilación cruzada, por ejemplo en una máquina Intel con Ubuntu e instalando
el paquete `gcc-arm-linux-gnueabihf` proporciona el toolchain para ARMv7 (hard
float) y puede realizarse esto:

```bash
./configure --host=arm-linux-gnueabihf
make
```

A continuación podemos verificar que el ejecutable `holamundo` es un ELF para
arquitectura ARM y no para Intel mediante:

```bash
file holamundo
```

por lo que podremos comprobar que efectivamente se utilizaron las herramientas
del toolchain sin tener que prefijar individualmente compilador, enlazador y
demás ejecutables.

# Más información

* [GNU Autoconf manual](https://www.gnu.org/software/autoconf/manual/)
* [GNU Automake manual](https://www.gnu.org/software/automake/manual/)
* [GNU Libtool manual](https://www.gnu.org/software/libtool/manual/)
* [Autotools Mythbuster](https://autotools.io/)
