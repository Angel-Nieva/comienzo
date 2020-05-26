#lang racket
(require "TDA_otros.rkt")
(provide commit?)
;TDA commit
;Los commit seran representado como una lista de 6 elementos, cada elemento representara una parte del commic:
; nombre del autor, identificador, fecha y hora, mensaje descriptivo, cambios almacenados(lista con los nombres de los archivos) y el identificador del commit anterior
;Ej: '("Angel",432,"Monday, May 18th, 2020 7:30:18pm", "mi primer commit", '("str1"), 0)


;-------------------------------------------------------------------CONSTRUCTORES----------------------------------------------------------------------------------;

;Funcion para construir un commit
(define cons_commit (lambda (nombre comentario lista_archivos id_anterior)
                    (if (and (string? nombre) (string? comentario) (lista_string? lista_archivos) (integer? id_anterior))
                       (list nombre (random 10000) (date->string (current-date) second) comentario lista_archivos id_anterior)
                       null
                    )   
           )
);EJ: (cons_commic "Angel" "Mi primer commit" '("str1" "str2" "str3") 0)

;--------------------------------------------------------------------PERTENENCIA------------------------------------------------------------------------------------;
(define commit? (lambda (commit)
    (if (and (list? commit)(string? (list-ref commit 0))(integer? (list-ref commit 1))(string? (list-ref commit 2))(string? (list-ref commit 3))(lista_string? (list-ref commit 4))(integer? (list-ref commit 5)))
      #t
      #f
    )  
  )
)


