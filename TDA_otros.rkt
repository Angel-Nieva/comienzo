#lang racket
(provide lista_string? current-date date->string )



;=================================================== OTRAS FUNCIONES===============================================================================;

;Funcion que verifica recursivamente si una lista esta compuesta unicamente por string o esta vacia
(define lista_string? (lambda (lista)
               (if (null? lista)  ;Si el primer elemento de la lista es null retorna #t
                   #t
                   (and (list? lista) (string? (car lista)) (lista_string? (cdr lista)))
               ) 
        )
)

;Funcion para construir la fecha y hora como un string
(require racket/date) ; =====> (date->string (current-date) second)