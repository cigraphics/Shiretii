using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PiOTTCommon.CustomExceptions
{
    public class DALException : Exception
    {
        public DALException()
            : base("Record not found.")
        {
        }

        public DALException(string message)
            : base(message)
        {
        }

        public DALException(string message, Exception innerException)
            : base(message, innerException)
        {
        }
    }
}
