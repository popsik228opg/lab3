Ниже рабочие решения на Java. Формулировки задач неполные (нет формата ввода), поэтому у первых двух даны функции, у остальных — программы с обычным вводом с консоли.

### 1. Удалить все вхождения числа из массива

Пропусков не остаётся: элементы сдвигаются влево, лишний хвост отбрасывается.

public static int[] removeAll(int[] a, int x) {
    int write = 0;
    for (int v : a) {
        if (v != x) {
            a[write++] = v;
        }
    }
    int[] result = new int[write];
    System.arraycopy(a, 0, result, 0, write);
    return result;
}
Исходный массив меняется на префиксе длины write. Если мутировать исходный массив нельзя, копируйте его заранее.

### 2. Факториал рекурсией

Для \(n < 0\) факториал не определён. Для \(n \ge 13\) int переполняется, для \(n \ge 21\) — long.

public static long factorial(int n) {
    if (n < 0) {
        throw new IllegalArgumentException("n must be >= 0");
    }
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}
### 3. Простое или составное

\(n > 1\). Простое — YES, составное — NO.

import java.util.Scanner;

public class Prime {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        System.out.println(isPrime(n) ? "YES" : "NO");
    }

    static boolean isPrime(int n) {
        if (n < 2) return false;
        if (n % 2 == 0) return n == 2;
        for (int d = 3; (long) d * d <= n; d += 2) {
            if (n % d == 0) return false;
        }
        return true;
    }
}
Проверка до \(\sqrt n\) достаточна: если есть делитель больше \(\sqrt n\), парный ему меньше \(\sqrt n\).

### 4. Палиндром

Только строчные латинские буквы. Сравнение с обоих концов, без разворота строки.

import java.util.Scanner;

public class Palindrome {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        String s = in.next();
        System.out.println(isPalindrome(s) ? "YES" : "NO");
    }

    static boolean isPalindrome(String s) {
        int i = 0, j = s.length() - 1;
        while (i < j) {
            if (s.charAt(i) != s.charAt(j)) return false;
            i++;
            j--;
        }
        return true;
    }
}
Пустая строка и строка из одного символа — палиндромы.

### 5. Функция Аккермана

Стандартное определение:

\[
A(m,n)=\begin{cases}
n+1 & m=0\\
A(m-1,1) & m>0,\ n=0\\
A(m-1,A(m,n-1)) & m>0,\ n>0
\end{cases}
\]

import java.util.Scanner;

public class Ackermann {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int m = in.nextInt();
        int n = in.nextInt();
        System.out.println(ackermann(m, n));
    }

    static int ackermann(int m, int n) {
        if (m == 0) return n + 1;
        if (n == 0) return ackermann(m - 1, 1);
        return ackermann(m - 1, ackermann(m, n - 1));
    }
}
Рекурсия растёт очень быстро. Практически считаются только маленькие значения: \(A(4,1) = 65533\), \(A(4,2)\) уже не помещается в int/long и почти наверняка даст StackOverflowError. Для учебных тестов обычно берут \(m \le 3\).
