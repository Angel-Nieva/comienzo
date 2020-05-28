#lang racket
(require "TDA_otros.rkt")
(require "TDA_commit.rkt")
(provide repository? cons_repositorio) ;Usados en el programa en general
(provide rep_get_workspace rep_set_workspace) ;Usados en funcion ADD
(provide rep_get_index rep_set_index);Usados en funcion ADD
(provide rep_get_funciones rep_set_funciones)

;TDA REPOSITORIO: Lista compuesta por las 4 zonas de trabajo, rama actual (master rama origen) y un listado con las funciones usadas sobre la rama.
;Ej: (list master workspace index local_repository remote_repository (push add pull))

;TDA WORKSPACE: Lista conformada unicamente por strings, que representaran los nombres de los archivos.
;Ej: (list "archivo1" "archivo2" ....."archivoN")

;TDA INDEX: Lista conformada unicamente por strings, que representaran los nombres de los archivos.
;Ej: (list "archivo1" "archivo2" ....."archivoN")

;TDA LOCAL REPOSITORY: Lista conformada unicamente por commits, el tda commit estara mas detallado en un archivo aparte
;Ej: (list commit1 commit2 .... commitN)

;TDA REMOTE REPOSITORY: Lista conformada unicamente por commits, el tda commit estara mas detallado en un archivo aparte
;Ej: (list commit1 commit2 .... commitN)

;----------------------------------------------------------------CONSTRUCTORES------------------------------------------------------------------------------------
;Funcion que construye un repositorio
;Entrada: workspace,index,local repository,remote repository,rama,lista funciones
;Salida: lista con los datos ingresados si son todos correctos, null en caso contrario
(define cons_repositorio (lambda (rama workspace index local_repository remote_repository funciones)
            (if (and (string? rama)(lista_string? workspace)(lista_string? index)(lista_commit? local_repository)(lista_commit? remote_repository)(lista_string? funciones))
                (list rama workspace index local_repository remote_repository funciones)
                null
            )
       )
)

;----------------------------------------------------------------PERTENENCIA---------------------------------------------------------------------------;

;Funciones que verifican si un dato ingresado corresponde a un workspace,index,local repository,remote repository,rama,lista funciones o repositorio
;Entrada: workspace,index,repositorio local o repositorio remoto en la funcion correspondiente
;Salida: #t si el dato ingresado es correcto, #f en caso contrario
(define rama? (lambda (rama)(string? rama)))
(define workspace? (lambda (workspace)(lista_string? workspace)))
(define index? (lambda (index)(lista_string? index)))
(define local_repository? (lambda (repositorio_local)(lista_commit? repositorio_local)))
(define remote_repository? (lambda (repositorio_remoto)(lista_commit? repositorio_remoto)))
(define funciones? (lambda (funciones)(lista_string? funciones)))

(define repository? (lambda (repositorio)
            (if (and (list? repositorio)(rama? (list-ref repositorio 0))(workspace? (list-ref repositorio 1))(index? (list-ref repositorio 2))(local_repository? (list-ref repositorio 3))
                     (remote_repository? (list-ref repositorio 4))(funciones? (list-ref repositorio 5)))
                #t
                #f
            )
      )
)

;----------------------------------------------------------------SELECTORES-------------------------------------------------------------------------------;
;Funciones que nos retornan un elemento del repositorio
;Entrada: repositorio
;Salida: ramificacion,workspace,repositorio local,repositorio remoto o funciones, null en caso de que la entrada no corresponda a un repositorio
(define rep_get_ramificacion (lambda (repositorio)(if (repository? repositorio) (list-ref repositorio 0) null)))
(define rep_get_workspace (lambda (repositorio) (if (repository? repositorio) (list-ref repositorio 1) null)))
(define rep_get_index (lambda (repositorio)(if (repository? repositorio) (list-ref repositorio 2) null)))
(define rep_get_local_rep (lambda (repositorio)(if (repository? repositorio) (list-ref repositorio 3) null)))
(define rep_get_remote_rep (lambda (repositorio)(if (repository? repositorio) (list-ref repositorio 4) null)))
(define rep_get_funciones (lambda (repositorio)(if (repository? repositorio) (list-ref repositorio 5) null)))

;----------------------------------------------------------------MODIFICADORES----------------------------------------------------------------------------;
;Funciones que crean un nuevo repositorio con un elemento cambiado, ya sea ramificacion,workspace,index,repositorio local,repositorio remoto o lista de funciones.
;Entrada: nueva ramificacion,workspace,index,repositorio local,repositorio remoto o lista de funciones
;Salida: Nuevo repositorio actualizado, null en caso de que la entrada no corresponda a un repositorio

(define rep_set_ramificacion (lambda (repo new_rami)
               (if (repository? repo)
                   (cons_repositorio new_rami(rep_get_workspace repo)(rep_get_index repo)(rep_get_local_rep repo)(rep_get_remote_rep repo)(rep_get_funciones repo) )
                   null
                )                          
        )
)

(define rep_set_workspace (lambda (repo new_works)
               (if (repository? repo)
                   (cons_repositorio (rep_get_ramificacion repo) new_works (rep_get_index repo)(rep_get_local_rep repo)(rep_get_remote_rep repo)(rep_get_funciones repo) )
                   null
                )                          
        )
)

(define rep_set_index (lambda (repo new_index)
               (if (repository? repo)
                   (cons_repositorio (rep_get_ramificacion repo)(rep_get_workspace repo) new_index (rep_get_local_rep repo)(rep_get_remote_rep repo)(rep_get_funciones repo))
                   null
                )                          
        )
)

(define rep_set_local_rep (lambda (repo new_local)
               (if (repository? repo)
                   (cons_repositorio (rep_get_ramificacion repo)(rep_get_workspace repo)(rep_get_index repo) new_local (rep_get_remote_rep repo)(rep_get_funciones repo))
                   null
                )                          
        )
)

(define rep_set_remote_rep (lambda (repo new_remote)
               (if (repository? repo)
                   (cons_repositorio (rep_get_ramificacion repo)(rep_get_workspace repo)(rep_get_index repo)(rep_get_local_rep repo) new_remote (rep_get_funciones repo))
                   null
                )                          
        )
)

(define rep_set_funciones (lambda (repo new_funciones)
               (if (repository? repo)
                   (cons_repositorio (rep_get_ramificacion repo)(rep_get_workspace repo)(rep_get_index repo)(rep_get_local_rep repo)(rep_get_remote_rep repo) new_funciones)
                   null
                )                          
        )
)





(define repo1 (cons_repositorio "master" '("asd" "asd") '() '() '() '("add" "push" "commit")))


                              
