#lang racket
(require "TDA_repositorios.rkt")
(require "TDA_otros.rkt")
(require "TDA_commit.rkt")
(provide git add commit push pull zonas->string)

;-----------------------------------------------------------------------GIT---------------------------------------------------------------------------------------;
;Funcion currificada que recive una funcion(comando) con los parametros propios de esta funcion
;Entrada: parametro de entrada del comando, repositorio en donde se aplican las funciones
;Salida: funcion con los parametros ingresados
(define git (lambda (funcion)
              (lambda (parametros)
                (funcion parametros)    
              )    
       )
)

;------------------------------------------------------------------------ADD-------------------------------------------------------------------------------------;

;Funcion que modifica un repositorio para ingresar una funcion "add" dentro de la sub-lista funciones y copiar los archivos del workspace al index
;Entrada: lista con archivos, repositorio
;Salida: nuevo repositorio con los cambios registrados del workspace al index y la funcion utilizada
(define add-repository (lambda (archivos zonas)
    (rep_set_funciones (rep_set_index zonas archivos) (append (rep_get_funciones zonas) '("add")) ) )
)

;Funcion que compara dos listas (archivos ingresados y workspace) y entrega un repositorio con los archivos ingresados
;Entrada: lista de archivos, repositorio
;Salida: si los archivos se encuentran en el workspace entrega un nuevo repositorio con los archivos ingresados en el index, sino se despliega un mensaje
(define add-no-curry (lambda (archivos zonas)
                 (if (null? archivos)
                     (rep_set_funciones zonas '("add"))
                     (if (comparar_archivos_lista archivos (rep_get_workspace zonas))
                         (add-repository archivos zonas)
                         "Un archivo no fue encontrado en el workspace"
                         )
                  )      
          )
)

;Funcion que encapsula la funcion anterior y pregunta si los datos ingresados son correctos
;Entrada: lista archivos, repositorio
;Salida: si los archivos son correctos entrega un nuevo repositorio con los archivos ingresados en el index, sino se despliega un mensaje
(define add (lambda (archivos)
              (lambda (zonas)
                    (if (and (lista_string? archivos)(repository? zonas))
                          (add-no-curry archivos zonas)
                          "Error en el ingreso de datos"
                    )
              )     
       )
)
;--------------------------------------------------------------------COMMIT-------------------------------------------------------------------------------------;
;Funcion que retorna el ultimo commit en el repositorio local
;Entrada: repositorio local
;Salida: commit
(define get-last-commit (lambda (local-rep)(if (null? (cdr local-rep)) (car local-rep) (get-last-commit(cdr local-rep)))))

;Funcion que crea un commit con un mensaje descriptivo, los archivos guardados en index y el identificador del ultimo commit guardado en el repositorio local
;Entrada: mensaje descriptivo y repositorio con las zonas de trabajo
;Salida: Si el repositorio local esta vacio crea el primer commit (Id anterior = 0), si no retorna un nuevo commit con el id del commit anterior
(define crear_commit (lambda (mensaje zonas)
                  (if (null? (rep_get_local_rep zonas)) ;Si el repositorio local esta vacio
                      (cons_commit "Angel" mensaje (rep_get_index zonas) 0) ;Se crea el commit inicial (id anterior = 0)
                      (cons_commit "Angel" mensaje (rep_get_index zonas) (com_get_id_anterior (get-last-commit (rep_get_local_rep zonas))))
                  )
         )              
)             

;Funcion que crea un repositorio con un nuevo commit agregado al repositorio local y el index vacio
;Entrada: mensaje descriptivo y repositorio con las zonas de trabajo
;Salida: nuevo repositorio con index vacio y cambios guardados en repositorio local
(define commit-no-curry (lambda (mensaje zonas)
        (rep_set_index (rep_set_local_rep zonas (append (rep_get_local_rep zonas) (list (crear_commit mensaje zonas)) )) '( ) ) ;Se vacia el index 
    )
) 

;Funcion que crea un repositorio aplicando la funcion commit dejando registro de la funcion "commit"
;Entrada: mensaje descriptivo, repositorio con las zonas de trabajo 
;Salida: si los datos de entrada son correctos pregunta si el index esta vacio. Si se encuentra vacio retorna zonas sin cambios, sino retorna una nueva version del repositorio.
;        si los datos de entrada no son correctos retorna un mensaje
(define commit (lambda (mensaje)
                  (lambda (zonas)
                      (if (and (string? mensaje)(repository? zonas))
                            (if (null? (rep_get_index zonas)) ;Si el index esta vacio se retorna las zonas como estaba
                                zonas
                               (rep_set_funciones (commit-no-curry mensaje zonas) (append (rep_get_funciones zonas) '("commit")) );Se deja registro de la funcion "commit"
                            )
                            "Error en el ingreso de datos"
                      )     
              )
      ) 
)
;-----------------------------------------------------------------------PUSH-------------------------------------------------------------------------------------;
;Funcion que envia todos los commits en el repositorio local al repositorio remoto dejando un registro de la funcion
;Entrada: repositorio con las zonas de trabajo
;Salida: zonas con los cambios guardados y un registro de la funcion "push"
(define push (lambda (zonas)
               (if (repository? zonas)
                     (rep_set_funciones (rep_set_remote_rep zonas (rep_get_local_rep zonas)) (append (rep_get_funciones zonas)'("push")));Se deja registro de la funcion
                     "Error en el ingreso de datos"
               )
       )
)
;--------------------------------------------------------------------PULL----------------------------------------------------------------------------------------;
;Funcion que revisa todos los archivos recursivamente en un commit y los compara con los archivos en una lista,
;  si el archivo no se encuentra en la lista se ingresa en esta. Se utiliza recursion con cola
;Entrada: archivos de un commit, lista con archivos sin repetir
;Salida: lista con los archivos del commit que no se encontraban en esta
(define sacar_archivos (lambda (archivos_commit lista_archivos)
                       (if (null? archivos_commit) ;Si se revisaron todos los archivos en el commit
                             lista_archivos ;Retorna la lista con archivos
                             (sacar_archivos (cdr archivos_commit)(ingresar_archivo_lista (car archivos_commit) lista_archivos))
                       )
           )
)

;Funcion que revisa cada commit y busca todos los archivos que esten en el repositorio remoto sin repeticiones
;Entrada: repositorio remoto (commits) y lista que contendra todos los archivos
;Salida: lista con los archivos sin repeticion
(define sacar_archivos_commit (lambda (commits lista_archivos)
               (if (null? commits) ;Si se revisaron todos los commits
                       lista_archivos
                      (sacar_archivos_commit (cdr commits)(sacar_archivos (com_get_archivos (car commits)) lista_archivos))
                )        
       )
)

;Funcion que crea un repositorio nuevo, mandando los archivos guardados en el repositorio remoto al workspace
;   ademas de mandar todos los commits guardados en el repositorio remoto al repositorio local
;Entrada: repositorio con las zonas de trabajo
;Salida: nuevo repositorio con archivos ingresados al workspace y commits en el repositorio local
(define pull_archivos (lambda (zonas)
                (rep_set_local_rep (rep_set_workspace zonas (sacar_archivos_commit (rep_get_remote_rep zonas) '() ) ) (rep_get_remote_rep zonas))      
       )
)

;Funcion que crea un repositorio aplicando la funcion pull dejando registro de la funcion
;Entrada: repositorio con las zonas de trabajo
;Salida: si los datos de entrada son correctos pregunta si el repositorio remoto esta vacio. Si se encuentra vacio retorna zonas sin cambios, sino retorna una nueva version del repositorio.
;        si los datos de entrada no son correctos retorna un mensaje 
(define pull (lambda (zonas)
               (if (repository? zonas) ;Pregunta si el dato ingresado es un repositorio
                       (if (null? (rep_get_remote_rep zonas)) ;Si el repositorio remoto esta vacio retorna las zonas sin cambios
                           zonas
                           (rep_set_funciones (pull_archivos zonas) (append (rep_get_funciones zonas)'("pull"))) ;Se deja registro de la funcion
                       )
                       "Error en el ingreso de datos"
                )
        )
)
;------------------------------------------------------------------ZONAS->STRING---------------------------------------------------------------------------------;
;Funcion que transforma los archivos dentro del workspace/index en un string posible de visualizar. Utiliza recursion de cola para recorrer y guardar los archivos.
;Entrada: workspace o index, string donde guardar los archivos 
;Salida: string con los archivos separados por una linea
(define mostrar_archivos (lambda (zona string)
             (if (null? zona)
                 string
                 (mostrar_archivos (cdr zona) (string-append string (car zona) " \n"))
              )
        )
)

;Funcion que transforma los commits dentro del repositorio local/remoto en un string posible de visualizar. Utiliza recursion de cola para recorrer y guardar los commits.
;Entrada: repositorio local o remoto, string donde guardar los commits 
;Salida: string con los commits separados por una linea
(define mostrar_commits (lambda (zona string)
             (if (null? zona)
                 string
                 (mostrar_commits (cdr zona) (string-append string (commit->string (car zona)) "\n"))
              )
        )
)

;Funcion que transforma un commit en un string posible de visualizar
;Entrada: repositorio
;Salida: string
(define mostrar_zonas (lambda (zonas)
             (string-append "====================================================================================================================================================================" 
                     "\nWORKSPACE:\n" (mostrar_archivos (rep_get_workspace zonas) "")
                     "\nINDEX:\n" (mostrar_archivos (rep_get_index zonas) "")
                     "\nREPOSITORIO LOCAL:\n" (mostrar_commits (rep_get_local_rep zonas) "")
                     "\nREPOSITORIO REMOTO:\n" (mostrar_commits (rep_get_local_rep zonas) "")
                     "\n=====================================================================================================================================================================" 
              )    
      )
)

;Funcion que entrega por pantalla una representacion de un repositorio
;Entrada: repositorio
;salida: string que pasa por la funcion display para ser visualizado 
(define zonas->string (lambda (zonas)
               (if (repository? zonas)         
                 (display (mostrar_zonas zonas))
                  "Error en el ingreso de datos"
               )  
        )
)

(define repo1 (list "master" '("hola.c") '("hola.c") '() '() '("add")))
(define repo2 '("master" ("hola.c") () (("Angel" 3447 "Saturday, May 30th, 2020 12:13:24am" "Micom" ("hola.c") 0)) () ("add" "commit")))
(define repo3 '("master"
  ("hola.c")
  ()
  (("Angel" 3447 "Saturday, May 30th, 2020 12:13:24am" "Micom" ("hola.c") 0))
  (("Angel" 3447 "Saturday, May 30th, 2020 12:13:24am" "Micom" ("hola.c") 0))
  ("add" "commit" "push")))

(define repo4 '("master"
  ("hola.c" "chao.c" "mundo.c" "saul.c")
  ()
  (("Angel" 3447 "Saturday, May 30th, 2020 12:13:24am" "Micom" ("hola.c") 0)("Angel" 3447 "Saturday, May 30th, 2020 12:13:24am" "Micom" ("hola.c") 0)("Angel" 3447 "Saturday, May 30th, 2020 12:13:24am" "Micom" ("hola.c") 0)("Angel" 3447 "Saturday, May 30th, 2020 12:13:24am" "Micom" ("hola.c") 0))
  (("Angel" 3447 "Saturday, May 30th, 2020 12:13:24am" "Micom" ("hola.c") 0)("Angel" 3447 "Saturday, May 30th, 2020 12:13:24am" "Micom" ("hola.c") 0))
  ("add" "commit" "push" "pull")))


(define a (list "asdasd" "\n" "sadad"))
