#!/bin/sh

IN1=23
IN2=24
PI=`awk 'BEGIN{print atan2(0,-0)}'`
PI_2=`awk 'BEGIN{print atan2(0,-0)/2}'`
pcos(){
  awk -v "p=$p" -v "pi=$PI" -v "d=$DIFF" 'BEGIN{print (1-cos(p/1000*pi))/2*d}'
}
accele(){
  DIFF=`expr $TARG - $CURR`
  for p in `seq 0 1000`; do
    gpio -g pwm 18 `pcos | awk -v "c=$CURR" '{print c+$1}'`
    sleep 0.0001
  done
  CURR=$TARG
}
mcos(){
  awk -v "p=$p" -v "pi=$PI" -v "d=$DIFF" 'BEGIN{print (1+cos(p/1000*pi))/2*d}'
}
decele(){
  for p in `seq 0 1000`; do
    gpio -g pwm 18 `mcos | awk -v "t=$TARG" '{print $1+t}'`
    sleep 0.001
  done
}
fin(){
  TARG=0
  echo $TARG
  accele
  gpio -g pwm 18 0
  gpio -g write $IN1 0
  gpio -g write $IN2 0
}

gpio -g mode $IN1 out
gpio -g mode $IN2 out
gpio -g mode 18 pwm
gpio pwmr 256

gpio -g write $IN1 1
gpio -g write $IN2 0
CURR=0

#TARG=55
#echo $TARG
#accele
TARG=70
echo $TARG
accele
#TARG=100
#echo $TARG
#accele
#TARG=85
#echo $TARG
#accele
#TARG=110
#echo $TARG
#accele
#TARG=90
#echo $TARG
#accele
#TARG=110
#echo $TARG
#accele
#TARG=160
#echo $TARG
#accele
#TARG=100
#echo $TARG
#accele
TARG=210
echo $TARG
accele
TARG=160
echo $TARG
accele
TARG=70
echo $TARG
accele
TARG=30
echo $TARG
accele

fin

