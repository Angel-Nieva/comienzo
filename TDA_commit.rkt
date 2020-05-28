#lang racket
(require "TDA_otros.rkt")
(provide commit? lista_commit?)
(provide cons_commit)
;TDA commit
;Los commit seran representado como una lista de 6 elementos, cada elemento representara una parte del commic:
; nombre del autor, identificador, fecha y hora, mensaje descriptivo, cambios almacenados(lista con los nombres de los archivos) y el identificador del commit anterior
;Ej: '("Angel",432,"Monday, May 18th, 2020 7:30:18pm", "mi primer commit", '("str1"), null)


;-------------------------------------------------------------------CONSTRUCTORES----------------------------------------------------------------------------------;

;Funcion que construye un commit con los datatos ingresados
;Entrada: nombre del crador, comentario del commit, lista con los archivos, identificador del commit anterior
;Salida: si los datos son correctos retorna un commit, en caso contrario retorna null
(define cons_commit (lambda (nombre comentario lista_archivos id_anterior)
                    (if (and (string? nombre) (string? comentario) (lista_string? lista_archivos) (integer? id_anterior))
                       (list nombre (random 10000) (date->string (current-date) second) comentario lista_archivos id_anterior)
                       null
                    )   
           )
)
;--------------------------------------------------------------------PERTENENCIA------------------------------------------------------------------------------------;
;Funcion que verifica que sea un commit revisando los elementos del commit
;Entrada: commit
;Salida: #t si corresponde a un commit, #f en caso contrario
(define commit? (lambda (commit)
    (if (and (list? commit)(string? (list-ref commit 0))(integer? (list-ref commit 1))(string? (list-ref commit 2))(string? (list-ref commit 3))
             (lista_string? (list-ref commit 4))(integer? (list-ref commit 5)))
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
;-------------------------------------------------------------------SELECTORES---------------------------------------------------------------------------------------;
(define com_get_archivos (lambda (commit)(if (commit? commit) (list-ref commit 4) null)))
(define com_get_id (lambda (commit)(if (commit? commit) (list-ref commit 1) null)))

;(define a (list "Angel" 432 "Monday, May 18th, 2020 7:30:18pm" "mi primer commit" '("str1") 0) )
;(define b (list "Marcelo" 432 "Monday, May 18th, 2020 7:30:18pm" "mi primer commit" '("str1") 0))
(define commit1 (cons_commit "Angel" "Mi primer commit" '("str1" "str2" "str3") 0))