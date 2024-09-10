using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BankApp.Entities;

namespace BankApp.Classes
{
    public static class Appdata
    {
       public static BankDbEntities1 Context = new BankDbEntities1();

       //public static User currentUser = new User();

       public static Person currentPerson = new Person();
    }
}
