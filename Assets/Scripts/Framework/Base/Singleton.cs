using System;

namespace Framework.Base
{
    public abstract class Singleton<T> where T : class, new()
    {
        private static T _instance;

        public static T Instance
        {
            get
            {
                if (_instance != null) return _instance;

                _instance = Activator.CreateInstance<T>();
                (_instance as Singleton<T>)?.Init();
                return _instance;
            }
        }

        public virtual void Init()
        {
        }

        public static void Release()
        {
            _instance = null;
        }

        public abstract void Dispose();
    }
}