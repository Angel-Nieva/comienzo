#lang racket
(require "TDA_otros.rkt")
(require "TDA_commit.rkt")
;TDA REPOSITORIO: Lista compuesta por las 4 zonas de trabajo, rama actual (master rama origen) y un listado con las funciones usadas sobre la rama.
;Ej: '(master,workspace,index,local_repository,remote_repository,(push add pull))

;TDA WORKSPACE: Lista conformada unicamente por strings, que representaran los nombres de los archivos.
;Ej: '( "archivo1" "archivo2" ....."archivoN")

;TDA INDEX: Lista conformada unicamente por strings, que representaran los nombres de los archivos.
;Ej: '( "archivo1" "archivo2" ....."archivoN")

;TDA LOCAL REPOSITORY: Lista conformada unicamente por commits, el tda commit estara mas detallado en un archivo aparte
;Ej: '( commit1 commit2 .... commitN)

;TDA REMOTE REPOSITORY: Lista conformada unicamente por commits, el tda commit estara mas detallado en un archivo aparte
;Ej: '( commit1 commit2 .... commitN)

;----------------------------------------------------------------CONSTRUCTORES------------------------------------------------------------------------------------
;Funciones que construyen un workspace,index,local repository,remote repository, implementando funciones de pertenencia
(define cons_workspace (lambda (workspace) (if (workspace? workspace) workspace null )))
(define cons_index (lambda (index) (if (index? index) index null )))
(define cons_local_rep (lambda (local_rep)(if (local_repository? local_rep) local_rep null)))
(define cons_remote_rep (lambda (remote_rep)(if (remote_repository? remote_rep) remote_rep null)))
;Funcion que construye un repositorio
(define constructor_repositorio (lambda (rama workspace index local_repository remote_repository funciones)(list rama workspace index local_repository remote_repository funciones)))

;----------------------------------------------------------------PERTENENCIA---------------------------------------------------------------------------;

;Funciones que verifican si un dato ingresado corresponde a un workspace o index
(define workspace? (lambda (lista)(lista_string? lista)))
(define index? (lambda (lista)(lista_string? lista)))
(define local_repository? (lambda (lista)(commit? lista)))
(define remote_repository? (lambda (lista)(commit? lista)))

;----------------------------------------------------------------SELECTORES-------------------------------------------------------------------------;
(define get_ramificacion (lambda (zonas)(list-ref zonas 0)))
(define get_workspace (lambda (zonas) (list-ref zonas 1)))
(define get_index (lambda (zonas)(list-ref zonas 2)))
(define get_local_rep (lambda (zonas)(list-ref zonas 3)))
(define get_remote_rep (lambda (zonas)(list-ref zonas 4)))












;(define constructor_local_repository(lambda (commit)(list commit)))
;(define constructor_remote_repository(lambda (commit)(list commit)))


                              
