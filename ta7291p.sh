#!/bin/sh

PWM_MAX=511
IN1=23
IN2=24

gpio -g mode $IN1 out
gpio -g mode $IN2 out
gpio -g mode 18 pwm

gpio -g write $IN1 1
gpio -g write $IN2 0

for p in `seq 0 $PWM_MAX`; do
  gpio -g pwm 18 $p
  sleep 0.01
done
sleep 2
for p in `seq $PWM_MAX -1 0`; do
  gpio -g pwm 18 $p
  sleep 0.01
done

gpio -g write $IN1 0
gpio -g write $IN2 0

