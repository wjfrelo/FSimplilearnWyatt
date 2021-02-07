package jenkinsDemo;

public class Calculator {

    public int multiply(int a, int b) {
        if (a == 0 || b == 0)
            return 0;
        else {
            return a * b;
        }

    }

    public int add (int a, int b) {
        return a + b;
    }
}