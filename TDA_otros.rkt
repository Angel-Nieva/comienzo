#lang racket
(provide lista_string? current-date date->string)



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
(define comparar_archivo_workspace (lambda (archivo workspace)
                        (if (null? workspace)
                            #f
                            (or (equal? archivo (car workspace))(comparar_archivo_workspace archivo (cdr workspace)))
                         )
           )
)

;Funcion que compara si los elementos de una lista se encuentran en otra
;Entrada: listas
;Salida: #t si los elementos de una lista se encuentran en la otra, #f en caso contrario
(define comparar_archivos_workspace (lambda (lista_archivos workspace)
                       (if (null? lista_archivos)
                           #t
                           (and (comparar_archivo_workspace (car lista_archivos) workspace)(comparar_archivos_workspace (cdr lista_archivos) workspace))
                       )
           )
)









(define lis (list "b" "a" "c"))