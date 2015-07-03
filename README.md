# Parks-McClellan-Simple

## Introduction
Simple Parks-McClellan equiripple filter design based around the "firpm" function in MATLAB.
This program illustrates the design procedure of a simple FIR equiripple design. Specify the normalized frequencies you want to limit, specify the tolerance, and the script will run and plot the results of your design.
 
#####Bandpass example:

![](http://s5.postimg.org/khnviqn4n/bandpass1.png)

#####Low Pass example:

![](http://s5.postimg.org/5cwcyyobb/lowpass1.png)

The code is very simplified, you don't need to learn all the requirements of the _firpm_ function, and it also guarantees the design specifications are met, which isn't the case when you estimate the order of the filter via the _firpmord_ function. Simply play around with these to make the design:

![](http://s5.postimg.org/njj96fpnb/codedemo2.png)

The actual filter response is stored inside the 'b' vector.

## File description




