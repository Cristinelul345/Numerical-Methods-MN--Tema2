function R = Algebraic(nume, d)
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
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
  
  
  M = (PR_Inv(K) * A)';
  R = PR_Inv(eye(N) - d * M) * (1 - d) / N * ones(N, 1);
  fclose(f);
end