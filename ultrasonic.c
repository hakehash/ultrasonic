#include <wiringPi.h>
#include <stdio.h>
#include <math.h>
#define TRIG 6
#define ECHO 5

void main(){
  int i,start,end;
  double c,temp;
  temp=20.0;
//scanf("%f",&temp);
  c=331.5+0.61*temp;
  wiringPiSetupGpio();
  pinMode(TRIG,OUTPUT);
  pinMode(ECHO,INPUT);
//while(1){
    digitalWrite(TRIG,1);
    delayMicroseconds(10);
    digitalWrite(TRIG,0);
    while(digitalRead(ECHO)==0) start=micros();
    while(digitalRead(ECHO)==1) end=micros();
    printf("%.0f\n",(end-start)*c/2000);
//}
}
