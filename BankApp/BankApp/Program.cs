using BankApp.Classes;
using BankApp.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankApp
{
    internal class Program
    {
        static void Main(string[] args)
        {
           
            while (true) 
            {
                Console.WriteLine("Добро пожаловать в приложение банка");
                Console.WriteLine("Выберите в списке то, что вы хотите сделать");
                Console.WriteLine("1 - Войти в аккаунт\n2 - Выйти из приложения");
                switch (Console.ReadLine())
                {
                    case "1":
                        {
                            Console.WriteLine("Введите логин:");
                            string login = Console.ReadLine();
                            Console.WriteLine("Введите пароль:");
                            string password = Console.ReadLine();
                            try
                            {
                               if(Authorization(login, password) == true)
                                {
                                    Person currentPerson = Appdata.Context.Person.ToList().Where(p => p.User.Password == password && p.User.Login == login).FirstOrDefault();
                                    Appdata.currentPerson = currentPerson;

                                    MainMenu(currentPerson);
                                    Console.Clear();
                                }
                                else
                                {
                                    Console.WriteLine("Проверьте корректность заполнения данных");
                                    break;
                                }
                            }
                            catch (Exception ex)
                            {
                                Console.WriteLine($"Возникла следующая ошибка: {ex.ToString()}");
                                return;
                            }
                            break;
                        }
                    case "2":
                        {
                            Console.WriteLine("Вы вышли из приложения");
                            
                            return;
                        }
                }

            }
        }

        static private bool Authorization(string login, string password)
        {
            try
            {
                if(Appdata.Context.Person.ToList().Where(p => p.User.Password == password && p.User.Login == login).Any() == true)
                {
                    Console.WriteLine("Вы успешно вошли в систему");
                    return true;
                }
                return false;
            }
            catch (Exception)
            {
                Console.WriteLine("Ошибка подключения к базе данных");
                return false;
            }
        }

        static private void MainMenu(Person person)
        {
            bool checkCycle = true;

            Console.Clear();
            Console.WriteLine($"Добро пожаловать {person.Name}!");
            while (checkCycle)
            {
                Console.Clear();
                Console.WriteLine("Выберите из списка действие, которое хотите совершить:");
                Console.WriteLine("1 - Проверить баланс\n2 - Потратить бабосики\n3 - Просмотреть статистику\n4 - Выйти в главное меню");
                switch (Console.ReadLine())
                {
                    case "1":
                        {
                            Console.Clear();
                            List<UserMoney> userBankAccount = Appdata.Context.UserMoney.ToList().Where(p=>p.Person == person).ToList();
                            foreach (var currency in userBankAccount)
                                Console.WriteLine($"Валюта: {currency.Currency.CurrencyName} | Количество: {currency.Value.ToString()}");

                            Console.WriteLine("Для выхода в главное меню нажмите Enter");
                            if (Console.ReadKey().Key == ConsoleKey.Enter)
                                break;
                            break;
                        }
                    case "2":
                        {
                            Console.Clear();
                            //Создаём экземпляр класса для работы с данными о балансе
                            Operation operation = new Operation();

                            Console.WriteLine("Выберите куда потратить деньги");
                            Console.WriteLine("1 - Переводы\n2 - Оплата покупок");
                            switch (Console.ReadLine())
                            {
                                case "1":
                                    {
                                        Console.WriteLine("Введите следующие параметры:");
                                        Console.WriteLine("Номер аккаунта получателя:");
                                        int accountId = Convert.ToInt32(Console.ReadLine());
                                        Console.WriteLine("Выберите доступную валюту для перевода:");

                                        List<UserMoney> userMoney = Appdata.Context.UserMoney.ToList().Where(p => p.Person == person).ToList();
                                        for (int i = 0; i < userMoney.Count; i++)
                                            Console.WriteLine($"{i+1}. {userMoney[i].Currency.CurrencyName}");
                                        
                                        int currencyType = Convert.ToInt32(Console.ReadLine())-1;
                                        if (currencyType > userMoney.Count)
                                        {
                                            Console.WriteLine("Ошибка выбора валюты");
                                            break;
                                        }

                                        Console.WriteLine("Введите количество валюты для перевода: ");
                                        float value = float.Parse(Console.ReadLine());

                                        Console.WriteLine($"Подвердить следующую операцию?\n{Appdata.currentPerson.Name} {accountId} {userMoney[currencyType].Currency.CurrencyName} {value}");
                                        Console.ReadKey();

                                        operation.moneyTransfer(Appdata.currentPerson, accountId, userMoney[currencyType].Currency, value);
                                        break;
                                    }
                                case "2":
                                    {

                                        break;
                                    }
                            }
                            break;
                        }
                    default:
                        break;
                }
            }
        }

    }
}
