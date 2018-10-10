
######################################################################################
##
## @utor - 08-08-2018
##      funcion que valida y carga los paquetes
##      necesarios para el proyecto
##
######################################################################################

#' @title validación y carga de paquetes
#' @description funcion que valida y carga los paquetes ecesarios para el proyecto.
#' @pkg vector que contiene los paqutes que seran cargados en el proyecto.
#' @name install_pkg
#' @export

install_pkg <- function(pkg){
        new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
        if (length(new.pkg))
                install.packages(new.pkg, dependencies = TRUE)
        sapply(pkg, require, character.only = TRUE)
}
