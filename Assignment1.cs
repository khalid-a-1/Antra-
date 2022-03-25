using System;

namespace Assignment1
{
    class Play
    {
        public void weplay()
        {
            Console.WriteLine("Enter your age:");
            int age = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Your age is: " + age);

        }

        public void UnderstandingTypes()
        {
            Console.WriteLine("| Type \t|\tBytes of Memory \t|\t Min \t\t\t\t\t|\tMax \t\t\t\t\t|");
            Console.WriteLine($"| sbyte\t|\t {sizeof(sbyte)}\t\t\t|\t {sbyte.MinValue}\t\t\t\t\t|\t{sbyte.MaxValue} \t\t\t\t\t|");
            Console.WriteLine($"| byte \t|\t {sizeof(byte)} \t\t\t|\t {byte.MinValue} \t\t\t\t\t|\t {byte.MaxValue} \t\t\t\t\t|");
            Console.WriteLine($"| short\t|\t {sizeof(short)}\t\t\t|\t{short.MinValue}  \t\t\t\t|\t {short.MaxValue} \t\t\t\t\t|");
            Console.WriteLine($"| ushort|\t {sizeof(ushort)} \t\t\t|\t {ushort.MinValue} \t\t\t\t\t|\t {ushort.MaxValue} \t\t\t\t\t|");
            Console.WriteLine($"| int \t|\t {sizeof(int)} \t\t\t|\t {int.MinValue} \t\t\t\t|\t {int.MaxValue} \t\t\t\t|");
            Console.WriteLine($"| uint \t|\t {sizeof(uint)} \t\t\t|\t {uint.MinValue} \t\t\t\t\t|\t {uint.MaxValue} \t\t\t\t|");
            Console.WriteLine($"| long \t|\t {sizeof(long)} \t\t\t|\t {long.MinValue} \t\t\t|\t {long.MaxValue} \t\t\t|");
            Console.WriteLine($"| ulong\t|\t {sizeof(ulong)} \t\t\t|\t {ulong.MinValue} \t\t\t\t\t|\t {ulong.MaxValue} \t\t\t|");
            Console.WriteLine($"| float\t|\t {sizeof(float)} \t\t\t|\t {float.MinValue} \t\t\t\t|\t {float.MaxValue} \t\t\t\t|");
            Console.WriteLine($"| double|\t {sizeof(double)} \t\t\t|\t {double.MinValue} \t\t|\t{double.MaxValue} \t\t\t|");
            Console.WriteLine($"| decimal|\t {sizeof(decimal)} \t\t\t|\t {decimal.MinValue} \t|\t{decimal.MaxValue} \t\t|");
        }

        public void Centuriestomins()
        {
            Console.Write("Centuries = ");
            int centuries = int.Parse(Console.ReadLine());
            int years = centuries * 100;
            int days = (int)(years * 365.2422);
            int hours = 24 * days;
            int minutes = 60 * hours;
            Console.WriteLine("{0} centuries = {1} years = {2} days = {3} hours = {4} minutes", centuries, years, days, hours, minutes);
        }

        public void fizzbuzz()
        {
            for (int i = 1; i <= 100; i++)
            {
                if (i % 3 == 0 && i % 5 == 0)
                {
                    Console.Write("FizzBuzz, ");
                }
                else if (i % 3 == 0)
                {
                    Console.Write("Fizz, ");
                }
                else if (i % 5 == 0)
                {
                    Console.Write("Buzz, ");
                }
                else
                {
                    Console.Write(i + ", ");
                }
            }
        }

        public void guess()
        {
            int correct = new Random().Next(3) + 1;
            Console.WriteLine("Guess what number I'm thinking of (1-3)?");
            int inp = Convert.ToInt32(Console.ReadLine());

            if (correct.Equals(inp))
            {
                Console.WriteLine("ThAT IS CORRECT!");
            }

            else if (correct > inp)
            {
                Console.WriteLine("Too low!");
                if (inp < 1)
                {
                    Console.WriteLine("Outside valid range (1-3)!");
                }
            }

            else if (correct < inp)
            {
                Console.WriteLine("Too high!");

                if (inp > 3)
                {
                    Console.WriteLine("Outside valid range (1-3)!");
                }
            }
        }

        public void pyramid()
        {
            int i, j, n;

            Console.Write("Input rows for this pattern: ");
            n = Convert.ToInt32(Console.ReadLine());
            for (i = 0; i < n; i++)
            {
                for (j = 1; j <= n - i; j++)
                    Console.Write(" ");
                for (j = 1; j <= 2 * i - 1; j++)
                    Console.Write("*");
                Console.Write("\n");
            }
        }

    static public void Main(String[] args)
        {

            Play p = new Play();
            //p.weplay();
            //p.UnderstandingTypes();
            //p.Centuriestomins();
            //p.fizzbuzz();
            //p.guess();
            p.pyramid();
        }
    }
}



