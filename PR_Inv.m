function B = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
	% Se va inlocui aceasta linie cu descrierea algoritmului de inversare 
    n = size(A,1);
    k = size(A,2);
    U = zeros(n,k);
    U(:,1) = A(:,1)/sqrt(A(:,1)'*A(:,1));
    for i = 2:k
      U(:,i) = A(:,i);
      for j = 1:i-1
        U(:,i) = U(:,i) - ( U(:,j)'*U(:,i) )/( U(:,j)'*U(:,j) )*U(:,j);
      endfor
       U(:,i) = U(:,i)/sqrt(U(:,i)'*U(:,i));
    endfor
      B = zeros(n,k);
      R = U' * A;
      for k = 1:n
        x = zeros(1,n);
        b = U' * eye(n)(:, k);
        for i =n:-1:1
          s = 0;
          for j =(i+1):n
           s = s + R(i,j) * x(j);
         endfor
         x(i) = (b(i) - s) / R(i,i);
       endfor
       B(:,k) = x;
       endfor
    end
   