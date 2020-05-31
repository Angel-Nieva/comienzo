#lang racket
(provide lista_string? current-date date->string get-n-lista)
(provide comparar_archivos_lista get-last-lista ingresar_archivo_lista buscar_archivo_lista listra_string->string)

;=========================================================== OTRAS FUNCIONES======================================================================================;

;Funcion que verifica recursivamente(normal) si una lista esta compuesta unicamente por string o esta vacia
;Entrada: lista de string
;Salida: booleano
(define lista_string? (lambda (lista)
               (if (null? lista)  ;Si el primer elemento de la lista es null retorna #t
                   #t
                   (and (list? lista) (string? (car lista)) (lista_string? (cdr lista)))
               ) 
        )
)

;Funcion que transforma la lista en un string posible de visualizar recorriendo la lista de manera recursiva(cola)
;Entrada: lista de string
;Salida: string
(define listra_string->string (lambda (lista string)
                (if (null? lista)
                    string
                    (listra_string->string (cdr lista) (string-append string (car lista) " "))
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

;Funcion para obtener el ultimo elemento de una lista
;Entrada: lista
;Salida: ultimo elemento de una lista
(define get-last-lista-no-encapsulada (lambda (lista)(if (null? (cdr lista)) (car lista) (get-last-lista-no-encapsulada(cdr lista)))))

;Funcion para obtener el ultimo elemento de una lista, en caso de que la lista este vacia retorna una lista vacia
;Entrada: lista
;Salida: ultimo elemento de una lista, si la lista entregada esta vacia, retorna una lista vacia
(define get-last-lista (lambda (lista) (if (null? lista) '() (get-last-lista-no-encapsulada lista)))) 

;Funcion que recorre recursivamente(normal) una lista y compara cada elemento con un string
;Entrada: string, lista
;Salida: booleano
(define buscar_archivo_lista (lambda (archivo lista)
                        (if (null? lista)
                            #f
                            (or (equal? archivo (car lista))(buscar_archivo_lista archivo (cdr lista)))
                         )
           )
)

;Funcion que compara si los elementos de una lista se encuentran en otra recorriendo la lista recursivamente(normal)
;Entrada: listas de archivos
;Salida: booleano
(define comparar_archivos_lista (lambda (lista_archivos lista)
                       (if (null? lista_archivos)
                           #t
                           (and (comparar_archivos_lista (cdr lista_archivos) lista)(buscar_archivo_lista (car lista_archivos) lista))
                       )
           )
)

;Funcion que ingresa un archivo en una lista de archivos siempre que este no se encuentre dentro
;Entrada: archivo(string), lista con archivos
;Salida: nueva lista con archivos ingresados
(define ingresar_archivo_lista (lambda (archivo lista)
                       (if (buscar_archivo_lista archivo lista) ;Si el archivo se encuentra en la lista o el archivo es null
                           lista ;Retorna la lisa sin cambios
                           (append lista (list archivo)) ;Agrega el archivo a la lista
                       )                    
          )
)