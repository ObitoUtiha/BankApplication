using BankApp.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankApp.Classes
{
     static class Interface
    {
        public static void MainMenu(Person person)
        {
            bool checkCycle = true;

            Console.Clear();
            Console.WriteLine($"Добро пожаловать {person.Name}!");
            while (checkCycle)
            {
                Operation operation = new Operation();

                Console.Clear();
                Console.WriteLine("Выберите из списка действие, которое хотите совершить:");
                Console.WriteLine("1 - Проверить баланс\n2 - Потратить бабосики\n3 - Просмотреть статистику\n4 - Выйти в главное меню");
                switch (Console.ReadLine())
                {
                    case "1":
                        {
                            Console.Clear();
                            operation.getUserAccountInfo(person);
                            Console.ReadKey();
                            Console.WriteLine(Resources.messagesToConsole[Resources.messages.Continue]);
                            break;
                        }
                    case "2":
                        {
                            Console.Clear();
                            //Создаём экземпляр класса для работы с данными о балансе
                            Console.WriteLine("Выберите куда потратить деньги");
                            Console.WriteLine("1 - Переводы\n2 - Оплата покупок");
                            switch (Console.ReadLine())
                            {
                                case "1": //Перевод
                                    {
                                        Console.WriteLine("Введите следующие параметры:");
                                        Console.WriteLine("Номер аккаунта получателя:");
                                        int accountId = Convert.ToInt32(Console.ReadLine());
                                        Console.WriteLine("Выберите доступную валюту для перевода:");

                                        List<UserMoney> userMoney = Appdata.Context.UserMoney.ToList().Where(p => p.Person == person).ToList();
                                        for (int i = 0; i < userMoney.Count; i++)
                                            Console.WriteLine($"{i + 1}. {userMoney[i].Currency.CurrencyName}");

                                        int currencyType = Convert.ToInt32(Console.ReadLine()) - 1;
                                        if (currencyType > userMoney.Count)
                                        {
                                            Console.WriteLine("Ошибка выбора валюты");
                                            break;
                                        }

                                        Console.WriteLine("Введите количество валюты для перевода: ");
                                        float value = float.Parse(Console.ReadLine());

                                        Console.WriteLine($"Подвердить следующую операцию?\n" +
                                            $"\nВаш аккаунт: {Appdata.currentPerson.PersonId} " +
                                            $"\nНомер банвоского счёта для перевода: {accountId} " +
                                            $"\nВалюта: {userMoney[currencyType].Currency.CurrencyName} " +
                                            $"\nКоличество: {value}");
                                        Console.ReadKey();

                                        operation.moneyTransfer(Appdata.currentPerson, accountId, userMoney[currencyType].Currency, value);
                                        Console.ReadKey();
                                        Console.WriteLine(Resources.messagesToConsole[Resources.messages.Continue]);
                                        break;
                                    }
                                case "2": //Обычная трата
                                    {
                                        Console.WriteLine("Выберите доступную валюту для траты:");

                                        List<UserMoney> userMoney = Appdata.Context.UserMoney.ToList().Where(p => p.Person == person).ToList();
                                        for (int i = 0; i < userMoney.Count; i++)
                                            Console.WriteLine($"{i + 1}. {userMoney[i].Currency.CurrencyName}");

                                        int currencyType = Convert.ToInt32(Console.ReadLine()) - 1;
                                        if (currencyType > userMoney.Count)
                                        {
                                            Console.WriteLine("Ошибка выбора валюты");
                                            break;
                                        }

                                        Console.WriteLine("Введите количество валюты для траты: ");
                                        float value = float.Parse(Console.ReadLine());

                                        operation.moneyTransfer(Appdata.currentPerson, userMoney[currencyType].Currency, value);
                                        Console.WriteLine(Resources.messagesToConsole[Resources.messages.Continue]);
                                        break;
                                    }
                            }
                            break;
                        }
                    case "3":
                        {
                            operation.getUserStats(person);
                            Console.WriteLine(Resources.messagesToConsole[Resources.messages.Continue]);
                            break;
                        }
                    case "4":
                        return;
                    default:
                        break;
                }
            }
        }
    }
}
