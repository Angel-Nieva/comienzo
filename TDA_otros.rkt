#lang racket
(provide lista_string? current-date date->string get-n-lista)
(provide comparar_archivos_lista get-last-lista)



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

;Funcion para obtener un elemento de una lista de manera recursiva(recursion de cola)
;Entrada: lista con elementos, entero que representa la posicion del elemento a buscar(hasta), contador que contiene la posicion actual revisada en la lista(voyEn)
;Salida: elemento n-esimo de una lista
(define obtener_elemento_lista (lambda (lista hasta voyEn)
                        (if (= hasta voyEn)
                            (car lista)
                            (obtener_elemento_lista (cdr lista) hasta (+ voyEn 1))
                        )
           )
)
(define get-n-lista (lambda (lista n)(obtener_elemento_lista lista n 0))); Se encapsula la funcion anterior fijando el contador en 0

(define get-last-lista-no-encapsulada (lambda (lista)(if (null? (cdr lista)) (car lista) (get-last-lista-no-encapsulada(cdr lista)))))

(define get-last-lista (lambda (lista) (if (null? lista) '() (get-last-lista-no-encapsulada lista))))

;Funcion que recorre recursivamente(normal) una lista y compara cada elemento con un string
;Entrada: workspace, string
;Salida: #t si se encuentra el string en el workspace, #f en caso contrario
(define buscar_archivo_lista (lambda (archivo lista)
                        (if (null? lista)
                            #f
                            (or (equal? archivo (car lista))(buscar_archivo_lista archivo (cdr lista)))
                         )
           )
)

;Funcion que compara si los elementos de una lista se encuentran en otra recorriendo la lista recursivamente(normal)
;Entrada: listas
;Salida: #t si los elementos de una lista se encuentran en la otra, #f en caso contrario
(define comparar_archivos_lista (lambda (lista_archivos lista)
                       (if (null? lista_archivos)
                           #t
                           (and (comparar_archivos_lista (cdr lista_archivos) lista)(buscar_archivo_lista (car lista_archivos) lista))
                       )
           )
)



(define a (list "a" "b" "d" "asd" "asd"))

(define lis (list "d"))