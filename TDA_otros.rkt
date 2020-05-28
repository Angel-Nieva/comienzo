#lang racket
(provide lista_string? current-date date->string comparar_archivo_lista comparar_archivos_lista)



;=================================================== OTRAS FUNCIONES===============================================================================;

;Funcion que verifica recursivamente(normal) si una lista esta compuesta unicamente por string o esta vacia
(define lista_string? (lambda (lista)
               (if (null? lista)  ;Si el primer elemento de la lista es null retorna #t
                   #t
                   (and (list? lista) (string? (car lista)) (lista_string? (cdr lista)))
               ) 
        )
)

;Funcion para construir la fecha y hora como un string
(require racket/date) ; =====> (date->string (current-date) second)

;Funcion que recorre recursivamente(normal) una lista y compara cada elemento con un string
;Entrada: workspace, string
;Salida: #t si se encuentra el string en el workspace, #f en caso contrario
(define comparar_archivo_lista (lambda (archivo lista)
                        (if (null? lista)
                            #f
                            (or (equal? archivo (car lista))(comparar_archivo_lista archivo (cdr lista)))
                         )
           )
)

;Funcion que compara si los elementos de una lista se encuentran en otra recorriendo la lista recursivamente(normal)
;Entrada: listas
;Salida: #t si los elementos de una lista se encuentran en la otra, #f en caso contrario
(define comparar_archivos_lista (lambda (lista_archivos lista)
                       (if (null? lista_archivos)
                           #t
                           (and (comparar_archivos_lista (cdr lista_archivos) lista)(comparar_archivo_lista (car lista_archivos) lista))
                       )
           )
)






(define a (list "a" "b" "d" "asd" "asd"))

(define lis (list "d"))