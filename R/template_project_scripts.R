
########################################################
##
## @utor - 07-08-2018
##      funcion que crea estructura carpeta para el
##      el proyecto
##
########################################################

#' @title crear templates de scripts para proyectos de ciencia de datos
#' @description esta funcion crea scripts de ejemplo para proyectos de ciencia de datos.
#' @path ruta donde se creara el proyecto.
#' @name template_project_scripts.
#' @export


template_project_scripts<- function(project_path){

        ## create file config.
        project_path_config<-paste0(project_path,"/Main_Project/Scripts/Config/")

        file.create(paste0(project_path_config,"Config.R"))
        fileConn<-file(paste0(project_path_config,"Config.R"))

        head_comment_doc <- c("\n##############################################################################################\n")

        comment_doc <-c("##
## nombre de usuari@ - 'fecha de modificaci?n' (formato de fecha dd-mm-yyyy).
##      se debe documentar todos los cambios realizados en el c?digo
##
## Config.R debe ser usado para configurar las rutas (path) que seran usadas en el proyecto,
##      esto es para que estas configuraciones previas esten centralizadas.
##
##")

        foo_comment_doc <- c("############################################################################################\n")

        body_file <- c('library(FrameworkIg)

packages<-c("bit64", "readxl", "data.table", "dplyr", "lubridate", "tidyr", "ggplot2","xlsx",
"Metrics", "class", "FNN", "randomForest","RevoScaleR","doParallel") ## vector con los paquetes a instalar. \n
install_pkg(packages)\n
log_file<-"log.txt"
log_path<-paste0("ruta donde ira el archivo log",log_file,sep="")

## root_path (es la ruta ppal del proyecto).
##      debe ser configurado en el archivo main que controlara la ejecuci?n del modelo
##      o en el archivo de Config.R si es que no se cuenta con un archivo main de ejecuci?n.

input_path <- paste0(root_path,"/Data/Input/")
output_path <- paste0(root_path,"/Data/Output/")
                       ')

        space_comment_doc<- c('\n')

        writeLines(paste0(head_comment_doc,
                          comment_doc,
                          foo_comment_doc,
                          space_comment_doc,
                          body_file
        ),
        fileConn)

        close(fileConn)
        

        ## create file DataTreatment.
        project_path_dta_t<-paste0(project_path,"/DataTreatment/")
        
        file.create(paste0(project_path_dta_t,"DataTreatment.R"))
        fileConn<-file(paste0(project_path_dta_t,"DataTreatment.R"))
        
        head_comment_doc <- c("\n###################################################################################################\n")
        
        comment_doc <-c("##
## nombre de usuari@ - 'fecha de modificaci?n' (formato de fecha dd-mm-yyyy).
##      se debe documentar todos los cambios realizados en el c?digo
##
## DataTreatment.R ->>> el proposito de este Script es ayudar con funciones basicas 
##      que pueden ser usadas para el proceso de limpieza de datos y exploración de los mismos.
##
##")
        
        foo_comment_doc <- c("#################################################################################################\n")
        
        body_file <- c('rm(list = ls())
gc()

library(DataExplorer)

## se debe cambiar el WD.
setwd(paste0(project_path,"Main_Project/Data/"))

## listar los archivos de rawdata si se desea hacer la lectura general desde una ruta especifica.
rawdata <- list.files(paste0(project_path,"Main_Project/Data/Rawdata/"))

## proceso de lectura paralelizado.
cl <- makeCluster(detectCores())
registerDoParallel(cl)
clusterEvalQ(cl , c(library(data.table),library(foreach),library(dplyr)))

rawdata_files<-list()

rawdata_files= 
foreach(i=1:length(rawdata),.combine=rbind)%dopar%{

path_rawdata_file<- paste0(project_path,"Main_Project/Data/Rawdata/", rawdata[1], sep = "")

raw_file <- fread(path_rawdata_file)

raw_file <- raw_file[,-"V1"]

}

rawdata_files<- na.omit(rawdata_files)           

stopCluster(cl)

## cargar de manera individual la información.
rawdata_1 <- fread(paste0(project_path,"Main_Project/Data/Rawdata/","nombre_archivo_1",".csv"))
rawdata_2 <- fread(paste0(project_path,"Main_Project/Data/Rawdata/","nombre_archivo_2",".csv"))

## merge entre archivos.

### merge sintanxis.
###     merge(base1, base2, by.x="nombre variable base 1", by.y="nombre variable base 2").
rawdata_union <-merge(rawdata_1, rawdata_2, by= "campo seleccionado", all=TRUE)

## data exploration.

str(rawdata_union)
dim(rawdata_union)

head(rawdata_union)
tail(rawdata_union)

## selecccionar variables para analisis.
### select sintaxis.
###     select(dataframe, col1, col2).
select(rawdata_union, "columna 1", "columna 2", "columna 2",-"columna 2")

## cambiar formato del data frame de formato ancho a formato largo <- recomendable.
##
### sintaxis gather(data, key, value, columnas) o data %>% gather(key, value, columnas)
###     data: es la tabla o el data frame
###     key: es el nombre que le voy a dar a la variable que voy a "fundir".
###     value: nombre de la variable que va a guardar los valores.
###     columna: las columnas que quiero fundir. Podemos ponerlas separadas por coma, 
###             o pondemos usar el operador - para seleccionar todas las columnas menos una.

rawdata_union_long <- gather(rawdata_union, key, value, -columna)
rawdata_union_long


## valores faltantes y cual es su perfil
plot_missing(rawdata_union) 

## Cómo se ve la frecuencia categórica para cada variable discreta
plot_bar(rawdata_union) 

## Cuál es la distribución de cada variable continua
plot_histogram(rawdata_union) 

plot_density(rawdata_union)

plot_boxplot(rawdata_union, by = "se agrupa por la variable de interes")  

plot_scatterplot(
subset(rawdata_union, select = -c("vector con las variables de interes")), 
by = "variable por la cual se desea agrupar", size = 0.5)

plot_correlation(rawdata_union)
                       
                       ')
        
        space_comment_doc<- c('\n')
        
        writeLines(paste0(head_comment_doc,
                          comment_doc,
                          foo_comment_doc,
                          space_comment_doc,
                          body_file
        ),
        fileConn)
        
        close(fileConn)                
}
