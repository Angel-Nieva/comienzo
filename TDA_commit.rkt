#lang racket
(require "TDA_otros.rkt")
(provide commit? lista_commit?)
(provide cons_commit com_get_id_anterior com_get_archivos commit->string)
;TDA commit
;Los commit seran representado como una lista de 6 elementos, cada elemento representara una parte del commic:
; nombre del autor, identificador, fecha y hora, mensaje descriptivo, cambios almacenados(lista con los nombres de los archivos) y el identificador del commit anterior
;Ej: '("Angel" 432 "Monday, May 18th, 2020 7:30:18pm" "mi primer commit" '("holaMundo.c") 0) ,Id anterior = 0 cuando es el commit inicial


;-------------------------------------------------------------------CONSTRUCTORES---------------------------------------------------------------------------------;

;Funcion que construye un commit con los datatos ingresados
;Entrada: nombre del creador, comentario del commit, lista con los archivos, identificador del commit anterior
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
;Salida: booleano
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
;Salida: booleano
(define lista_commit? (lambda (lista)
               (if (null? lista)
                   #t
                   (and (list? lista) (commit? (car lista)) (lista_commit? (cdr lista)))
               )         
        )
)

;-------------------------------------------------------------------SELECTORES------------------------------------------------------------------------------------;
;Fucniones que retornan cierto elemento dentro de un commit
;Entrada: commit
;Salida: identificador, fecha, mensaje descriptivo, lista con archivos, identificador anterior si se ingresa un commit, null en caso contrario
(define com_get_id (lambda (commit)(if (commit? commit) (get-n-lista commit 1) null)))
(define com_get_fecha (lambda (commit)(if (commit? commit) (get-n-lista commit 2) null)))
(define com_get_mensaje (lambda (commit)(if (commit? commit) (get-n-lista commit 3) null)))
(define com_get_archivos (lambda (commit)(if (commit? commit) (get-n-lista commit 4) null)))
(define com_get_id_anterior (lambda (commit)(if (commit? commit) (get-n-lista commit 5) null)))
;----------------------------------------------------------------------OTRAS--------------------------------------------------------------------------------------;
;Funciones que transforman un commit en un string posible de visualizar
;Entrad: commit
;Salida: string 
(define commit->string (lambda (commit)
                 (if (commit? commit)
                     (string-append "| " (com_get_mensaje commit) " | Fecha: " (com_get_fecha commit) " | Archivos: " (listra_string->string (com_get_archivos commit) "")
                             " | Id: " (number->string (com_get_id commit)) " | Id anterior: " (number->string (com_get_id_anterior commit)) " |")
                     ""
                 )
         )
)



;(define a (list "Angel" 432 "Monday, May 18th, 2020 7:30:18pm" "mi primer commit" '("str1") 0) )
;(define b (list "Marcelo" 432 "Monday, May 18th, 2020 7:30:18pm" "mi primer commit" '("str1") 0))
(define commit1 (cons_commit "Angel" "Mi primer commit" '("str1" "str2" "str3") 0))
(define p (list '("str1") commit1))