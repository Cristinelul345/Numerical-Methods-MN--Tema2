function R = Iterative(nume, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eruarea care apare in algoritm.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina. 
  f = fopen(nume, 'r');
  N = fscanf(f, '%d', 1);
  A = zeros(N);
  K = zeros(N);
  for i = 1:N
    nod = fscanf(f, '%d', 1);
		nr_links = fscanf(f, '%d', 1);
		links = fscanf(f, '%d', nr_links);
    
    for j = 1:nr_links
      if nod != links(j)
        A(nod, links(j)) = 1;
      endif
    endfor
    
    K(nod, nod) = nr_links;
  endfor
  
  R1 = 1 / N * ones(N, 1);
  M = (inv(K) * A)';
  R2 = d * M * R1 + (1 - d) / N * ones(N, 1);
  
  while sum(abs(R2 - R1) < eps) < N
    R1 = R2;
    R2 = d * M * R1 + (1 - d) / N * ones(N, 1);
  endwhile
  
  R = R1;
  fclose(f);
end
 
 