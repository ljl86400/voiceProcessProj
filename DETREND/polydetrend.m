function y = polydetrend(x,fs,polynomialOrder)
if nargin == 2
    polynomialOrder = 3;
end
x = x(:);
N = length(x);
t = (0:N-1)'/fs;
a = polyfit(t,x,polynomialOrder);
xtrend = polyval(a,t);
y = x - xtrend;
end