using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Vatas_Common
{
    public sealed class BLSecurity
    {
        private static string PASS_PHRASE = "h0st31syst3M!";
        private static string SALT = "verysalty";
        private static string HASH = "SHA1";
        private static int PASSWORD_ITERATIONS = 2;
        private static string INIT_VECTOR = "0123456789012345";
        private static int KEY_SIZE = 256;

        public static string Encrypt(string sText)
        {
            byte[] initVectorBytes = Encoding.ASCII.GetBytes(INIT_VECTOR);
            byte[] saltValueBytes = Encoding.ASCII.GetBytes(SALT);
            byte[] plainTextBytes = Encoding.UTF8.GetBytes(sText);

            PasswordDeriveBytes password = new PasswordDeriveBytes(PASS_PHRASE, saltValueBytes, HASH, PASSWORD_ITERATIONS);
            byte[] keyBytes = password.GetBytes(KEY_SIZE / 8);

            RijndaelManaged symmetricKey = new RijndaelManaged();
            symmetricKey.Mode = CipherMode.CBC;

            ICryptoTransform encryptor = symmetricKey.CreateEncryptor(keyBytes, initVectorBytes);

            MemoryStream memoryStream = new MemoryStream();

            CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write);
            cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);
            cryptoStream.FlushFinalBlock();

            byte[] cipherTextBytes = memoryStream.ToArray();

            memoryStream.Close();
            cryptoStream.Close();

            return Convert.ToBase64String(cipherTextBytes);
        }

        public static string Decrypt(string sText)
        {
            byte[] initVectorBytes = Encoding.ASCII.GetBytes(INIT_VECTOR);
            byte[] saltValueBytes = Encoding.ASCII.GetBytes(SALT);

            byte[] cipherTextBytes;
            try { cipherTextBytes = Convert.FromBase64String(sText); }
            catch { return ""; }

            PasswordDeriveBytes password = new PasswordDeriveBytes(PASS_PHRASE, saltValueBytes, HASH, PASSWORD_ITERATIONS);

            byte[] keyBytes = password.GetBytes(KEY_SIZE / 8);

            RijndaelManaged symmetricKey = new RijndaelManaged();
            symmetricKey.Mode = CipherMode.CBC;

            ICryptoTransform decryptor = symmetricKey.CreateDecryptor(keyBytes, initVectorBytes);

            MemoryStream memoryStream = new MemoryStream(cipherTextBytes);
            CryptoStream cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read);

            byte[] plainTextBytes = new byte[cipherTextBytes.Length];
            string plainText = "";

            try
            {
                int decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length);

                memoryStream.Close();
                cryptoStream.Close();

                plainText = Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount);
            }
            catch { return ""; }

            return plainText;
        }
    }
}
