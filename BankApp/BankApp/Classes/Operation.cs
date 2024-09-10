using BankApp.Entities;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankApp.Classes
{
    public class Operation
    {
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
            if (sender != Appdata.currentPerson)
                throw new Exception("Ошибка сервера");
            try
            {
                //Счета пользователя в разных валютах
                UserMoney userBankAccount = Appdata.Context.UserMoney.ToList().Where(p=>p.PersonId == sender.PersonId).Where(p=>p.Currency == currency).FirstOrDefault();

                // Блок проверки пользователя
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

                //Операция
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

        }
    }
}
