#lang racket
(require "TDA_funciones.rkt")
(require "TDA_repositorios.rkt")
(require "TDA_otros.rkt")
(require "TDA_commit.rkt")

;==================================================================== MAIN =======================================================================================;

;Se define el repositorio inicial al cual aplicaremos todos los comandos, el cual sera inicializado unicamente con archivos en el workspace.

(define repositorio (cons_repositorio "master" '("holaMundo.c" "archivo1.c" "archivo2.c" "archivo3.c" "archivoN.c") '() '() '() '()))

;Seguir los pasos a continuacion para probar los comandos:
;   *Probar los comandos copiando los ejemplos de mas abajo, estos deben ser aplicados en el orden especificado.
;   *Despues de aplicar un comando al repositorio se debe copiar el resultado y utilizarlo como un nuevo repositorio,
;       que llamaremos por conveniencia new_repository

; 1) (((git add) '("holaMundo.c" "archivo1.c" "archivo2.c" "archivo3.c"))repositorio)
;             * si se usa add usando una lista vacia se retorna el repositorio sin cambios. Ej: (((git add) '())repositorio)
;             * tambien se puede usar add ingresando una lista de archivos que esten en el workspace, si algun archivo no mostrara un mensaje de error
; 2) (((git commit) "Mi primer commit") new_repository)

; 3) ((git push) new_repository)

; 4) ((git pull) new_repository)

; 5) ((git zonas->string) new_repository)


