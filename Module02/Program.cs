using System;
using System.Collections;
using System.Text;

namespace Assignment2
{
    class AS2
    {

        public void copyArray()
        {
            int[] arr1 = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
            int[] arr2 = new int[arr1.Length];

            for (int i = 0; i < arr1.Length; i++)
            {
                arr2[i] = arr1[i];
            }

            Console.Write("arr1: ");

            for (int i = 0; i < arr1.Length; i++)
            {
                Console.Write(arr1[i] + " ");
            }

            Console.Write("\n");

            Console.Write("arr2: ");

            for (int i = 0; i < arr1.Length; i++)
            {
                Console.Write(arr2[i] + " ");
            }
        }

        public void ToDo()
        {
            ArrayList Arr1 = new ArrayList();
            StringBuilder str1 = new StringBuilder();

            while (true)
            {
                Console.WriteLine("Enter command (+ item, - item, or -- to clear)):");
                String inp = Console.ReadLine();

                if (inp[0] == '+')
                {
                    str1.Append(inp);
                    str1[0] = ' ';
                    Arr1.Add(str1.ToString().ToLower());
                    str1.Clear();
                    Console.Write("\n");

                    foreach (String i in Arr1)
                    {
                        Console.Write(" " + i + " ");
                    }

                    Console.Write("\n");
                }

                else if (inp[0] == 'c' || inp[0] == 'C')
                {
                    Arr1.Clear();
                    Console.Write("\n");
                }

                else if (inp[0] == '-')
                {
                    str1.Append(inp);
                    str1[0] = ' ';
                    Arr1.Remove(str1.ToString());
                    str1.Clear();
                    Console.Write("\n");

                    foreach (String i in Arr1)
                    {
                        Console.Write(" " + i + " ");
                    }

                    Console.Write("\n");
                }

                else
                {
                    Console.WriteLine("Format not accepted");
                }

            }
        }

        public void FindPrimes(int start, int end)
        {
            int i, j, x;

            for (i = start; i <= end; i++)
            {
                if (i == 1 || i == 0)
                    continue;

                x = 1;
                for (j = 2; j <= i / 2; ++j)
                {
                    if (i % j == 0)
                    {
                        x = 0;
                        break;
                    }
                }

                if (x == 1)
                    Console.WriteLine(i);
            }
        }

        public void ReverseStr()
        {

            string str, str1 = "";
            int i, len;

            Console.Write("Input string: ");
            str = Console.ReadLine();

            len = str.Length - 1;

            for (i = len; i >= 0; i--)
            {
                str1 = str1 + str[i];
            }

            Console.WriteLine("Reversed string: {0}", str1);
            Console.Write("\n");
        }

        public void URL()
        {
            string input = "https://www.apple.com/iphone";
            string[] x = input.Split("://");
            string protocol = x[0];
            int serverEndIndex = x[1].IndexOf("/");
            string server = x[1].Substring(0, serverEndIndex);
            string resource = x[1].Substring(serverEndIndex + 1);
            Console.WriteLine("Protocol: {0} \nServer: {1} \nResource: {2}", protocol, server, resource);
        }


        static void Main(String[] args)
        {

            AS2 p = new AS2();
            //p.copyArray();
            //p.ToDo();
            //p.FindPrimes(1, 10);
            //p.ReverseStr();
            //p.URL();


        }
    }
}



