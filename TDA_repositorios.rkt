#lang racket
;TDA Repositorios:
;Esta compuesta por las 4 zonas de trabajo: Workspace,Index,Local Repository y Remote Repository donde basicamente cada zona es una lista de listas.
;Tambien contiene el nombre del repositorio, que correspondera a la ramificacion actual de los commits
;Ej:  '(master,workspace,index,local_rep,remote_rep)



;(define constructor_repositorio (lambda ("master" workspace index local_repository remote_repository)(list "master" workspace index local_repository remote_repository)))

;TDA

;----------------------------------------------------------------CONSTRUCTORES------------------------------------------------------------------------------------
;Funciones que in
(define cons_workspace (lambda (workspace) (if (workspace? workspace) workspace (display "Datos no corresponden a un workspace\n")  )))
(define cons_index (lambda (index) (if (index? index) index (display "Datos no corresponden a un index\n")  )))

;----------------------------------------------------------------PERTENENCIA---------------------------------------------------------------------------;

;Funcion que verifica recursivamente si una lista esta compuesta unicamente por string o esta vacia
(define lista_string? (lambda (lista)
               (if (null? lista)  ;Si el primer elemento de la lista es null retorna #t
                   #t
                   (and (list? lista) (string? (car lista)) (lista_string? (cdr lista)))
               ) 
        )
)
;Funciones que verifican si un dato ingresado corresponde a un workspace o index
(define workspace? (lambda (lista)(lista_string? lista)))
(define index? (lambda (lista)(lista_string?)))

;----------------------------------------------------------------SELECTORES-------------------------------------------------------------------------;
(define get_ramificacion (lambda (zonas)(list-ref zonas 0)))
(define get_workspace (lambda (zonas)(cadr (list-ref zonas 1))))
(define get_index (lambda (zonas)(cadr (list-ref zonas 2))))
(define get_local_rep (lambda (zonas)(cadr (list-ref zonas 3))))
(define get_remote_rep (lambda (zonas)(cadr (list-ref zonas 4))))












;(define constructor_local_repository(lambda (commit)(list commit)))
;(define constructor_remote_repository(lambda (commit)(list commit)))

                              
