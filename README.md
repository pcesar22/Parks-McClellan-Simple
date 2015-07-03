# Parks-McClellan-Simple

## Introduction
Simple Parks-McClellan equiripple filter design based around the "firpm" function in MATLAB.
This program illustrates the design procedure of a simple FIR equiripple design. Specify the normalized frequencies you want to limit, specify the tolerance, and the script will run and plot the results of your design.
 
#####Bandpass example:

![](http://s5.postimg.org/khnviqn4n/bandpass1.png)

#####Low Pass example:

![](http://s5.postimg.org/5cwcyyobb/lowpass1.png)

The code is very simplified, you don't need to learn all the requirements of the _firpm_ function, and it also guarantees the design specifications are met, which isn't the case when you estimate the order of the filter via the _firpmord_ function. Simply play around with these to make the design:

![](http://s5.postimg.org/nbvm9xeon/codedemo2.png)

The actual filter response is stored inside the 'b' vector.

## File description

The files I've used can still be useful for other applications. The main filter files are **parksLowPass.m** and **parksBandPass.m**. These contain the entire code for generating the response and plotting it. They are not _exactly_ analogous, however. The lowpass version uses the **parksFIR.m** file, which has a scaling step that allows you to specify the maximum and minimum passband gain desired, while the bandpass version only allows for a single deviation. 

**getAmplitude.m** calculates the amplitude response of the filter. Note that this is different from the _magnitude_ respons, as the amplitude response can assume negative values.

**makePlot.m** is a pretty simple, self-explanatory function that plots the amplitude response.

**bandPassCheckLimits.m** and **lowPassCheckLimits.m** are functions that verify if the filter response meets the design requirements.


