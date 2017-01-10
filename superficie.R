####Borrar todas las variables y gráficos previos#####
rm(list = setdiff(ls(), lsf.str()))
graphics.off()
#######################################################

setwd('/home/erasmo//Escritorio/algoritmos_evolutivos/JEBatta_final/codigos/')
x<-read.csv(file = 'GA_ABM_2.csv')
names(x)<-c('Met','Th','cone','pop','lfrac')
y<-subset(x,pop>0)
library(scatterplot3d)
scatterplot3d(y$Met,y$Th,y$pop,pch=16,highlight.3d=TRUE,
              type="h",xlab = 'metabolismo base', ylab = 'angulo de vision',
              zlab = 'población',main="AG: población de MBA")

scatterplot3d(y$Met,y$cone,y$pop,pch=16,highlight.3d=TRUE,
              type="h",xlab = 'metabolismo base', ylab = 'cono de vision',
              zlab = 'población',main="AG: población de MBA")

scatterplot3d(y$Th,y$cone,y$pop,pch=16,highlight.3d=TRUE,
              type="h",xlab = 'angulo de vision', ylab = 'cono de vision',
              zlab = 'población',main="AG: población de MBA")

scatterplot3d(y$Met,0.5*(y$cone^2)*y$Th,y$pop,pch=16,highlight.3d=TRUE,
              type="h",xlab = 'metabolismo', ylab = 'Area',
              zlab = 'población',main="AG: población de MBA")

library(ggplot2)
ggplot(z, aes(x = 0.5*(cone^2)*Th , y = pop, colour = Met))+
  geom_smooth() +
  geom_point(aes(size=Met))+
  xlab("Área de percepción") + ylab("población")

