% Natural Cubic Spline.
% S(i)(x) = a(i) + b(i)(x-xi) + c(i)(x-xi)^2 + d(i)(x-xi)^3 , where A*c(i) = q

% h(i) = x(i+1) - x(i)

% A is a (nxn) matrix where:
% A(1,1) = 1, A(1,2) = 0, A(2,1) = h(0), A(2,2) = 2(h(0) + h(1)), A(2,3) = h(1),A(3,2) = h(1),
% A(3,3) = 2(h(1) + h(2)), A(3,4) = h(2) and it continues diagonicaly until the last row has A(n,n-1) = 0 and A(n,n) = 1

% q is also a matrix where:
% q = [0, ((3/h(1))*(f(2)-f(1)) - (3/h(0))*(f(1)-f(0))),....,((3/h(n-1))(f(n)-f(n-1))-(3/h(n-2))*(f(n-1)-f(n-2))),0]

% Inputs
x_input = input("Enter the x values in order and in format [v1,v2,...] here: ");
x = x_input';
f = input("Enter the polynomial values in order and in format [p1,p2,...] here: ");
input_size = size(x,1);

% Making matrixes for the a,b,d
a = b = d = zeros(input_size-1,1);

% Calculating the matrix "a"
for i = 1:(input_size-1)
  a(i) = f(i);
endfor

% Creating the matrix "A"
matrixA = zeros(input_size);
matrixA(1,1) = 1;                       % First line
matrixA(input_size,input_size) = 1;     % Last line
for i = 2: (input_size-1)
  matrixA(i,i-1) = x(i) - x(i-1);       % Starting from h0
  matrixA(i,i+1) = x(i+1) - x(i);       % Starting from h1
  matrixA(i,i) = 2 * (x(i+1) - x(i-1)); % Diagonally
endfor

% Creating the matrix "q"
matrixq = zeros(input_size,1);
matrixq(1) = 0;                  % First row
matrixq(input_size) = 0;         % Last row
for i = 2:(input_size-1)
  matrixq(i) = 3*((f(i+1)-f(i))/(x(i+1)-x(i))-(f(i)-f(i-1))/(x(i)-x(i-1)));
endfor

% Calculating the matrix "c"
g = rref ([matrixA matrixq]); %gaussian elimination matrix
c = g(:,end); %rref gives us in the last row of g where the solutions that were calculated appear.

% Calculating the matrix "b"
for i = 1:(input_size-1)
  b(i) = (f(i+1)-f(i))/(x(i+1)-x(i))-(x(i+1)-x(i))/3*(c(i+1)+2*c(i));
endfor

% Calculating the matrix "d"
for i = 1:(input_size-1)
  d(i) = (c(i+1)-c(i))/(3*(x(i+1)-x(i)));
endfor

% Printing
display("\nThe a's are:\n"); display(a);
display("\nThe b's are:\n"); display(b);
display("\nThe c's are:\n"); display(c);
display("\nThe d's are:\n"); display(d);

printf("The splines are as follows:\n");
for i = 0:input_size-2
  printf("S(x%d)= (%f) +",i,a(i+1));
  printf("(%f) * (x-(%f))",b(i+1),x(i+1));
  printf(" + (%f) * (x-(%f))^2", c(i+1),x(i+1));
  printf("+ (%f) * (x-(%f))^3",d(i+1),x(i+1));
  printf(" for x in [%d,%d]\n", x(i+1),x(i+2));
endfor
