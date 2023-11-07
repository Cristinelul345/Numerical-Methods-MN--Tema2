function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out 
  f = fopen(nume, 'r');
  N = fscanf(f, '%d', 1);
  for i = 1:N
    nod = fscanf(f, '%d', 1);
    nr_links = fscanf(f, '%d', 1);
	  links = fscanf(f, '%d', nr_links);
  endfor
  val1 = fscanf(f, '%f', 1);
  val2 = fscanf(f, '%f', 1);
  fclose(f);
  
  R1 = Iterative(nume, d, eps);
  R2 = Algebraic(nume, d);
  f = fopen(strcat(nume, '.out'), 'w');
  fprintf(f, '%d\n\n', N);
  
  for i = 1:N
		fprintf(f, '%.*f\n', 6, R1(i));
	endfor
  
	fprintf(f, '\n');
  
	for i=1:N
		fprintf(f, '%.*f\n', 6, R2(i));
	endfor
  
	fprintf(f,'\n');
  [PR1, indices] = sort(R2, mode='descend');
  a = 1 / (val2 - val1);
  b = -a * val1;
  
  for i = 1:N
    if PR1(i) < val1
      u = 0;
    elseif PR1(i) <= val2
      u = a * PR1(i) + b;
    else
      u = 1;
    endif
    fprintf(f, '%d %d %.*f\n', i, indices(i), 6, u);
  endfor
  
  
  fclose(f);
end