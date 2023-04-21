# tema-asc
Tema pentru laboratorul de la materia Arhitectura Sistemelor de Calcul realizata in decembrie 2022

In aceasta tema am implementat urmatoarele cerinte:

Cerinta 1:
  Se citesc de la tastatura (STDIN) listele de adiacenta ale grafului orientat G si se cere sa se afiseze matricea de adiacenta. Astfel, se vor citi, cate o valoare pe linie:
    • 1 reprezentand numarul cerintei; pentru cerintele 2 si 3, aceasta valoare va fi 2, respectiv 3;
    • N <= 100 numarul de noduri ale grafului;
    • N linii pe care se vor afla valorile M0, M1, ..., MN−1, reprezentand numarul de legaturi pentru fiecare nod in parte;
    • M0 linii pe care se vor afla vecinii nodului 0, apoi M1 linii pe care se vor afla vecinii nodului 1, ..., apoi MN−1 linii pe care se vor afla vecinii nodului N-1.

Cerinta 2:
  Pentru aceasta cerinta, se vor citi de la STDIN listele de adiacenta exact ca la Cerinta 1, se va construi in spate matricea de adiacenta si se va calcula numarul de drumuri de lungime
k dintre doua noduri date, unde k = lungimea, i = nodul sursa, respectiv j = nodul destinatie vor fi specificate in input.
  Pentru rezolvarea acestei cerinte trebuie sa implementati o procedura care sa respecte toate conventiile prezentate la laborator si in suportul de laborator, cu numele matrix_mult, 
care sa primeasca doua matrici ca input, patratice si de aceeasi dimensiune, si sa calculeze produsul, stocandu-l intr-un spatiu definit anterior in sectiunea .data. Signatura acestei proceduri va fi
  matrix_mult(m1, m2, mres, n) unde m1 si m2 sunt adresele matricelor in memorie, mres este adresa matricei in care se va completa rezultatul, iar n reprezinta dimensiunea acestora.
