% compute the fibonacci number in matlab
function [ fnum ] = fibonacci( n )

if (n<2)
    fnum = n;
else
    fnum = fibonacci(n-1) + fibonacci(n-2);
end

end

