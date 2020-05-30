#lang racket
(require "TDA_otros.rkt")
(provide commit? lista_commit?)
(provide cons_commit com_get_id_anterior com_get_archivos)
;TDA commit
;Los commit seran representado como una lista de 6 elementos, cada elemento representara una parte del commic:
; nombre del autor, identificador, fecha y hora, mensaje descriptivo, cambios almacenados(lista con los nombres de los archivos) y el identificador del commit anterior
;Ej: '("Angel" 432 "Monday, May 18th, 2020 7:30:18pm" "mi primer commit" '("holaMundo.c") 0) ,Id anterior = 0 cuando es el commit inicial


;-------------------------------------------------------------------CONSTRUCTORES---------------------------------------------------------------------------------;

;Funcion que construye un commit con los datatos ingresados
;Entrada: nombre del crador, comentario del commit, lista con los archivos, identificador del commit anterior
;Salida: si los datos son correctos retorna un commit, en caso contrario retorna null
(define cons_commit (lambda (nombre mensaje lista_archivos id_anterior)
                    (if (and (string? nombre) (string? mensaje) (lista_string? lista_archivos) (integer? id_anterior))
                       (list nombre (random 10000) (date->string (current-date) second) mensaje lista_archivos id_anterior)
                       null
                    )   
           )
)
;------------------------------------------------------------------PERTENENCIA------------------------------------------------------------------------------------;
;Funcion que verifica que sea un commit revisando los elementos del commit
;Entrada: commit
;Salida: #t si corresponde a un commit, #f en caso contrario
(define commit? (lambda (commit)
    (if (and (list? commit)(string? (get-n-lista commit 0))(integer? (get-n-lista commit 1))(string? (get-n-lista commit 2))(string? (get-n-lista commit 3))
             (lista_string? (get-n-lista commit 4))(integer? (get-n-lista commit 5)))
      #t
      #f
    )  
  )
)

;Funcion verifica recursivamente(normal) si una lista esta compuesta unicamente por commit o esta vacia
;Entrada: lista de commit
;Salida: #t si corresponder a lista de commit, #f en caso contrario
(define lista_commit? (lambda (lista)
               (if (null? lista)
                   #t
                   (and (list? lista) (commit? (car lista)) (lista_commit? (cdr lista)))
               )         
        )
)

;Funcion que verifica que el primer elemento de una lista sea una lista de string y el resto una lista de commits o sea una lista vacia
(define lista_string_commit? (lambda (lista)(if (or (null? lista)(and (lista_string? (car lista)) (lista_commit? (cdr lista)))) #t #f)))
;-------------------------------------------------------------------SELECTORES------------------------------------------------------------------------------------;
;Fucniones que retornan cierto elemento dentro de un commit
;Entrada: commit
;Salida: identificador, lista con archivos o identificador del comit anterior,null en caso de que no se entregara un commit
(define com_get_nombre (lambda (commit)(if (commit? commit) (get-n-lista commit 0) null)))
(define com_get_id (lambda (commit)(if (commit? commit) (get-n-lista commit 1) null)))
(define com_get_fecha (lambda (commit)(if (commit? commit) (get-n-lista commit 2) null)))
(define com_get_mensaje (lambda (commit)(if (commit? commit) (get-n-lista commit 3) null)))
(define com_get_archivos (lambda (commit)(if (commit? commit) (get-n-lista commit 4) null)))
(define com_get_id_anterior (lambda (commit)(if (commit? commit) (get-n-lista commit 5) null)))




;(define a (list "Angel" 432 "Monday, May 18th, 2020 7:30:18pm" "mi primer commit" '("str1") 0) )
;(define b (list "Marcelo" 432 "Monday, May 18th, 2020 7:30:18pm" "mi primer commit" '("str1") 0))
(define commit1 (cons_commit "Angel" "Mi primer commit" '("str1" "str2" "str3") 0))
(define p (list '("str1") commit1))