# Warmup Questions

1.  What is the clone url of this repository?
    >   https://github.com/jsanchez679/lab_vision.git

2.  What is the output of the ``cal`` command?

       La salida del comando ''cal'' es un calendario con el mes actual como salida predeterminada. 

# Homework Questions

1.  What is the ``grep``command?
    >   ''grep'' es un comando que busca dentro de un archivo dado, una palabra on un patrón que es especificado. Por ejemplo grep hello hola.tx, busca la palabra hello dentro del archivo hola.txt

2.  What is a *makefile*?
    >   Un "makefile" es un archivo que le da instrucciones al comando ''make'' sobre qué debe hacer para compilar y link un programa. 

3.  What is *git*?
    >   "git" es un comando que activa un sistema de control lleno de comandos y operaciones de alto y bajo  nivel. Los commandos git se encuentran clasificados de acuerdo al nivel de control que poseen, en high y low level. 

4.  What does the ``-prune`` option of ``find`` do? Give an example
    >   La opción ''prune'' dentro del comando ''find'', es buscar los archivos con el nombre especificado en todos los directorios, excepto en aquellos que se especifican antes de escribir -prune. Por ejemplo: si se quiere buscar todos los archivos .txt dentro del directorio .casa, pero sin buscar en el directorio .apto se escribe: 
    find . -name .apto -prune -o -name '*.txt' -print

5.  Where is the file ``xxxxxx``
    >   find /-name 'xxxxxx' 2>/dev/null

6.  How many files with ``gnu`` in its name are in ``/usr/src``
    >   [vision@guitaca src]$ find / -name '*gnu*' 2>/dev/null | wc -l
    >   Rta: 656

7.  How many files contain ``gpl`` inside in ``/usr/src``
    >   [vision@guitaca src]$ grep -rnw 'gpl' | wc -l
    >   Rta: 51

8.  What does the ``cut`` command do?
    >   El comando ''cut'' es un comando utilizado para porcesar texto, y se utiliza para extraer una porcion de texto de un archivo seleccionando las columnas.

9.  What does the ``wget`` command do?
    >   ''wget'' es un comando libre que permite descargar archivos de la web que se especifican en la línea de comando. Soporta archivos de tipo http, https, y protocolos ftp. 

10.  What does the ``diff`` command do?
    >   ''diff'' es un comando que encuentra diferencias entre dos archivos que se especifican en la línea de comando. Por ejemplo diff file1 file2 busca diferencias entre los archivos file1 y file2

11.  How many users exist in *Guitaca*?
    >   [vision@guitaca home]$ cut -d: -f1 /etc/passwd | wc -l
    >   Rta: 48 usuarios 

12. What command will produce a table of Users and Shells sorted by shell (tip: using ``cut`` and ``sort``)
    >   [vision@guitaca ~]$ cut -d':' -f 1,7 /etc/passwd > table.txt
    >   [vision@guitaca ~]$ cat table.txt
    >   [vision@guitaca ~]$ sort -k 2 -t':' table.txt

13. What command will produce the number of users with shell ``/sbin/nologin`` (tip: using ``grep`` and ``wc``)
    >   [vision@guitaca ~]$ grep -rnw '/sbin/nologin'  table.txt | wc -l
    >   Rta: 41

14.  What is the name of the linux distribution running on *Guitaca*?
    >   [vision@guitaca ~]$ cat /proc/version
    >   Linux version 3.17.8-200.fc20.x86_64 (mockbuild@bkernel02.phx2.fedoraproject.org) (gcc version 4.8.3 20140911 (Red Hat 4.8.3-7) (GCC) ) #1 SMP Thu Jan 8 23:26:57 UTC 2015

15. Create a script for finding duplicate images based on their content (tip: hash or checksum)
    You may look in the internet for ideas, but please indicate the source of any code you use
    Save this script as ``find_duplicates.sh`` in this directory and commit your changes to github

16. What is the meaning of ``#! /bin/bash`` at the start of scripts?
    >   El significado de ``#! /bin/bash`` al comienzo de los scripts corresponde al programa que el shell debe utilizar para interpretar el script al ser éste ejecutado. 

17. How many unique images are in the ``sipi_images`` folder?
    >   answer
    
