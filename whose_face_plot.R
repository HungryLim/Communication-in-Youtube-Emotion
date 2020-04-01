
setwd("C:/Users/wooki/Desktop/examples")
dat<-read.csv('some.csv',header=T)

library(stringr)

# prepare regular expression
regexp <- "[[:digit:]]+"

dat$num<-str_extract(dat$framenum, regexp)
dat$num
write.csv(dat, 'amata.csv')

#####################################
setwd("C:/Users/wooki/Desktop/examples")
dat<-read.csv('some2.csv',header=T)

library(stringr)

# prepare regular expression
regexp <- "[[:digit:]]+"

dat$num<-str_extract(dat$framenum, regexp)
dat$num
#write.csv(dat, 'buck.csv')


dat<-read.csv('buck.csv',header=T)


library(ggplot2)
ggplot(dat, na.rm = FALSE) +
  geom_histogram(aes(x = confidence),alpha = 0.6, position = "identity",na.rm = FALSE)+
  geom_histogram(aes(x=human.conf),alpha = 0.2, position = "identity",na.rm = FALSE)

library(ggplot2)
ggplot(data = dat) +
  geom_point(aes(x = num, y=confidence*100), 
             alpha=0.3, col ="red") +
  geom_point(aes(x = num, y=human.conf), 
             alpha=0.3, col ="green")

library(ggplot2)
ggplot(data = dat) +
  geom_point(aes(x = human.conf, y=confidence*100), 
             alpha=0.3, col ="red") 





library(ggplot2)
ggplot(dat, aes(x = confidence),na.rm = FALSE) +
  geom_histogram(alpha = 0.6, position = "identity",na.rm = FALSE)+
  
  table(dat$confidence)







library(ggplot2)
ggplot(dat, aes(x = confidence),na.rm = FALSE) +
  geom_histogram(alpha = 0.6, position = "identity",na.rm = FALSE)
table(dat$confidence)


ggplot(dat, aes(x=num, y=identical))+ geom_point()+geom_point(aes(y=human),col='red')
dat<-dat[complete.cases(dat), ]



dat<-read.csv('amata.csv',header=T)
ggplot(dat)+ geom_point(aes(x=num, y=confidence))
+geom_point(aes(y=human.conf),col='red')


library(dplyr)
datt<-dat %>%
  group_by(num) %>%
  summarise(max.conf=max(confidence),
            max.human.conf=max(human.conf))

plot(datt$num,datt$max.human.conf, col='red',type="l", xlab='time', ylab='confidence', main= 'Amata')
lines( datt$num,datt$max.conf*100, cex=0.5)
abline(h=50,lty='dotted')


dat<-read.csv('buck.csv',header=T)
dat<-read.csv('amata.csv',header=T)
dat<-dat[complete.cases(dat), ]
plot(0,100, xlim = c(0,50), ylim=c(0,100),xlab="threshold", ylab="percent of matched faces",main="Buck")
a<-matrix(,nrow=nrow(dat),ncol=1)
for (i in 0:50) {
  
  for (j in 1:nrow(dat)){
    
    if ((dat$confidence[j]*100) >i){ 
      a[j,1]<-1}
    else {a[j,1]<-0}}
  total<-sum(a[,1])
  final<-total/nrow(dat)*100
  points(i,final)
}
abline(h=(sum(dat$human.conf))/nrow(dat),col="red")