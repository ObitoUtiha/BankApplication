using BankApp.Entities;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Security.Cryptography.Xml;
using System.Text;
using System.Threading.Tasks;

namespace BankApp.Classes
{
    public class Operation
    {

        public void exceptionCheck(Person sender)
        {
            if (sender != Appdata.currentPerson)
                throw new Exception("Ошибка сервера");

        }

        /// <summary>
        /// Метод обработки перевода с одного счёта на другой
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="recipientId"></param>
        /// <param name="currency"></param>
        /// <param name="value"></param>
        /// <exception cref="Exception"></exception>
        public async void moneyTransfer(Person sender, int recipientId, Currency currency, float value)
        {
            exceptionCheck(sender);

            try
            {
                //Счета пользователя в разных валютах
                UserMoney userBankAccount = Appdata.Context.UserMoney.ToList().Where(p=>p.PersonId == sender.PersonId).Where(p=>p.Currency == currency).FirstOrDefault();
                

                // Блок проверки пользователя для перевода
                if (Appdata.Context.Person.Where(p => p.PersonId == recipientId).Any() == false)
                {
                    Console.WriteLine("Пользователь с таким идентификатором не найден");
                    return;
                }

                bool isCurrency = false;
                Person recipient = Appdata.Context.Person.Where(p => p.PersonId == recipientId).FirstOrDefault();

                foreach (UserMoney userMoney in Appdata.Context.UserMoney.ToList().Where(p => p.Person == recipient).ToList())
                {
                    if(userMoney.Currency == currency)
                        isCurrency = true;
                }

                if (isCurrency == false)
                {
                    Console.WriteLine($"Пользователь не зарегистрировал счёт с валютой {currency}");
                    return;
                }

                //Операция перевода
                if (value <= userBankAccount.Value)
                {
                    userBankAccount.Value -= value;
                    Appdata.Context.UserMoney.ToList().Where(p => p.Person == recipient && p.Currency == currency).FirstOrDefault().Value += value;
                    Appdata.Context.SaveChanges();

                    Appdata.Context.Transaction.Add(new Transaction
                    {
                        Person = sender,
                        Value = value,
                        TransactionType = Appdata.Context.TransactionType.Where(p=>p.TransactionTypeId == 1).FirstOrDefault(),
                        Date = DateTime.Now,
                        //Получатель
                        Person1 = recipient,
                        Currency1 = currency
                    });
                    Appdata.Context.SaveChanges();
                    Console.Clear();
                    Console.WriteLine("Перевод выполнен!");
                    Console.ReadKey();
                }
                else
                {
                    Console.WriteLine("Проверьте количество средств на балансе");
                }
            }
            catch (DbException)
            {
                Console.WriteLine("Ошибка подключения к базе данных");
                return;
            }
            catch (Exception)
            {
                throw new Exception("Обратитесь к системному администратору");
            }
        }


        /// <summary>
        /// Метод обработки траты
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="currency"></param>
        /// <param name="value"></param>
        public async void moneyTransfer(Person sender, Currency currency, float value)
        {
            exceptionCheck(sender);

            try
            {
                //Счета пользователя в разных валютах
                UserMoney userBankAccount = Appdata.Context.UserMoney.ToList().Where(p => p.PersonId == sender.PersonId).Where(p => p.Currency == currency).FirstOrDefault();

                if (value <= userBankAccount.Value)
                {
                    userBankAccount.Value -= value;

                    Random rnd = new Random();
                    

                    Appdata.Context.SaveChanges();

                    Appdata.Context.Transaction.Add(new Transaction
                    {
                        Person = sender,
                        Value = value,
                        TransactionType = Appdata.Context.TransactionType.Where(p => p.TransactionTypeId == 2).FirstOrDefault(),
                        Date = DateTime.Now,
                        Currency1 = currency
                    });
                    Appdata.Context.SaveChanges();
                    Console.Clear();
                    Console.WriteLine($"Вы потратиили {value} {currency.CurrencyCode} на {Resources.paymentTypes[rnd.Next(0, Resources.paymentTypes.Length)]}");
                    Console.ReadKey();
                }
                else
                {
                    Console.WriteLine("Проверьте количество средств на балансе");
                }
            }
            catch (DbException)
            {
                Console.WriteLine("Ошибка подключения к базе данных");
                return;
            }
            catch (Exception)
            {
                throw new Exception("Обратитесь к системному администратору");
            }
        }

        /// <summary>
        /// Получение информации о счёте пользователя
        /// </summary>
        /// <param name="person"></param>
        public void getUserAccountInfo(Person person)
        {
            List<UserMoney> userBankAccount = Appdata.Context.UserMoney.ToList().Where(p => p.Person == person).ToList();
            Console.WriteLine($"Номер вашего банковского счёта: {person.PersonId}");
            foreach (var currency in userBankAccount)
                Console.WriteLine($"Валюта: {currency.Currency.CurrencyName} | Количество: {currency.Value.ToString()}");

        }


        /// <summary>
        /// Вывод статистики пользователя
        /// </summary>
        /// <param name="person"></param>
        public void getUserStats(Person person)
        {
            Console.Clear();
            Console.WriteLine($"Статистика по банковскому счёту {person.PersonId} на {DateTime.Now.ToString("dd MMMM yyyy")}\n");
            getUserAccountInfo(person);

            List<Transaction> userTransations = Appdata.Context.Transaction.ToList().Where(p=>p.Person == person).ToList();
            
            string transactions = userTransations.Where(p => p.TransactionTypeId == 1).Count() > 0  ? Math.Round((Convert.ToDouble(userTransations.Where(p => p.TransactionTypeId == 1).Count())
                / userTransations.Count * 100), 2).ToString() + "%" : "Операций не было";
            string payemnt = userTransations.Where(p => p.TransactionTypeId == 2).Count() > 0 ? Math.Round((Convert.ToDouble(userTransations.Where(p => p.TransactionTypeId == 2).Count())
                / userTransations.Count * 100), 2).ToString() + "%" : "Операций не было";

            Console.WriteLine($"Общее количество операциий: {userTransations.Count}" +
                $"\nПереводы: {userTransations.Where(p => p.TransactionTypeId == 1).Count()} - {transactions}" +
                $"\nПлатежи: {userTransations.Where(p => p.TransactionTypeId == 2).Count()} - {payemnt}");
            Console.ReadKey();
        }

    }
}
