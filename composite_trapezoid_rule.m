% Composite Trapezoid rule for approximations for definite integrals.

% Inputs
f_input = input("Enter the function f in the form of 'f' here:");
vector = input("Enter the vector in the form of [a,b] here: ");
m = input("Enter the arithmetic precision number m here: ");

f = inline(f_input);
a = vector(1);
b = vector(2);

h = b - a;               % Step length
difference = 0;          % The difference of the previous and the current result.
times_run_counter = 0;   % Is our counter for how many times we will run our program.
step = 1;                % The steps each time, we will add +2 in the creation of our matrix for fa and fb, because this doesn't count them.
wanted_difference = 0;   % The wanted difference. Once we find this, then we have our final result.
current_result = previous_result = 0;

while(difference >= wanted_difference)
  wanted_difference = (1/2)*(10^(-m)); % Initializing our wanted difference (stays the same).

  h = h/2;              % Subduplication
  step = step * 2;

  matrix = zeros(1,step+2);  % Matrix in the size of our fs each time.
  matrix(1)= a;              % Adding to the matrix as first element the a.
  matrix(step+2)= b;         % Adding to the matrix as last element the b.
  for i = 1:step+1
    matrix(i+1) = a + (i*(h));
  endfor

  f2 = 0;                    % Sum counter
  for i = 2:step+1
    f2 = f2 + f(matrix(i));
  endfor

  current_result = (h/2)*(f(a) + 2*f2 + f(b));
  difference = abs(previous_result - current_result);
  previous_result = current_result;
  times_run_counter = times_run_counter + 1;

  printf("The result this time is: %f , and the difference with the last one is: %f \n",current_result,difference);
endwhile

times_run_counter = times_run_counter - 1;
printf("The solution therefore is %f and it took %d times to be solved.\n",current_result,times_run_counter);

