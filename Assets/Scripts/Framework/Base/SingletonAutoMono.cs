using UnityEngine;

namespace Framework.Base
{
    public abstract class SingletonAutoMono<T> : MonoBehaviour where T : SingletonAutoMono<T>
    {
        private static T _instance;

        public static T Instance
        {
            get
            {
                if (_instance != null) return _instance;
                _instance = FindObjectOfType<T>();

                if (_instance != null) return _instance;
                GameObject go = new GameObject(typeof(T).Name);
                _instance = go.AddComponent<T>();

                GameObject parent = GameObject.Find("Root");
                if (parent == null)
                {
                    parent = new GameObject("Root");
                    DontDestroyOnLoad(parent);
                }

                go.transform.SetParent(parent.transform);

                return _instance;
            }
        }
        public static T GetInstance()
        {
            if (_instance != null) return _instance;
            _instance = FindObjectOfType<T>();

            if (_instance != null) return _instance;
            GameObject go = new GameObject(typeof(T).Name);
            _instance = go.AddComponent<T>();

            GameObject parent = GameObject.Find("Root");
            if (parent == null)
            {
                parent = new GameObject("Root");
                DontDestroyOnLoad(parent);
            }

            go.transform.SetParent(parent.transform);

            return _instance;
        }
        private void Awake()
        {
            if (_instance == null)
            {
                _instance = this as T;
            }

            DontDestroyOnLoad(gameObject);
            Init();
        }

        protected virtual void Init()
        {
        }

        public void DestroySelf()
        {
            Dispose();
            _instance = null;
            Destroy(gameObject);
        }

        public virtual void Dispose()
        {
        }
    }
}