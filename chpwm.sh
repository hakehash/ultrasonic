#!/bin/sh

IN1=23
IN2=24
PI=`awk 'BEGIN{print atan2(0,-0)}'`
pcos(){
  awk -v "p=$p" -v "pi=$PI" -v "d=$DIFF" 'BEGIN{print (1-cos(p/1000*pi))/2*d}'
}
accele(){
  DIFF=`expr $TARG - $CURR`
  for p in `seq 0 1000`; do
    NOW=`pcos | awk -v "c=$CURR" '{print c+$1}'`
    gpio -g pwm 18 $NOW
    sleep 0.001
  done
  CURR=$NOW
}
fin(){
  TARG=0
  CURR=`echo $NOW | sed s/\.[0-9]*$//g`
  accele
  gpio -g pwm 18 0
  gpio -g write $IN1 0
  gpio -g write $IN2 0
}

trap 'fin; exit 1' 2

gpio -g mode $IN1 out
gpio -g mode $IN2 out
gpio -g mode 18 pwm
gpio pwmr 256

gpio -g write $IN1 1
gpio -g write $IN2 0

CURR=0
TARG=`./ultrasonic`
echo $TARG
accele
while : ; do
  TARG=`./ultrasonic`
  echo $TARG
  accele
done
