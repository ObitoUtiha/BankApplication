using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BankApp.Classes
{
    public static class Resources
    {
        //Строки для генерации рандомной операции
        public static string[] paymentTypes = { "Покупка еды", "Покупка автозапчастей", "Оплата ЖКХ", "Оплата подписки" };


        // Список сообщений для консоли 
        // Пример использования:  Console.WriteLine(Resources.messagesToConsole[Resources.messages.Continue].ToString());
        public enum messages {
            Exit = 1,
            Continue,
            Sure
        }

        public static Dictionary<messages, string> messagesToConsole = new Dictionary<messages, string>{
            { messages.Exit, "Для выхода из программы нажмите Esc"},
            { messages.Continue, "Для перехода на предыдущую страницу нажмите Enter" },
            { messages.Sure, "Вы уверены, что хотите продолжить?" }
        };

    }
}
