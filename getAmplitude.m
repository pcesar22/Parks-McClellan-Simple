% Function that measures the amplitude of a sequence b. Amplitude
% is the sign-sensitive magnitude, and this function 
% makes it simpler to view it (couldn't find any useful
% MATLAB functions)
% wresp is simply the frequency values vector being used
% h is the amplitude response of b
function [h,wresp] = getAmplitude(b)



wresp = 0:0.001:pi;

% BEWARE - careful bookkeeping here!
% b is a sequence, as an example of length 25 (M=24, L=12)
% he[n], from the book, has the correspondence:
% he[0] = b[13]
% he[1] = b[14]
% ...
% he[12] = b[25]

% LENGTH OF B MUST BE ODD! (Type I filter only here)

M = length(b); % Corresponds to M+1 in the course. M is even.
L = (M-1)/2;

h = zeros([1,length(wresp)]); %b(L) is he(0)
for i = 2:L+1
   h = h + 2*b(L+i)*cos(wresp*(i-1));
end
h = h + b(L+1);
h = h';
wresp = wresp';
    

end