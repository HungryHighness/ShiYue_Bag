using System;
using System.IO;
using Framework.Base;
using UnityEngine;
using XLua;

namespace Framework
{
    public class XLuaManager : SingletonAutoMono<XLuaManager>
    {
        private LuaEnv _luaEnv = null;

        private Action _luaStart;
        private Action _luaUpdate;
        private Action _luaOnDestroy;

        private const string _gameMainScriptName = "GameMain";
        private const string _luaScriptsFolder = "LuaScripts";

        public LuaTable Global => _luaEnv.Global;
        protected override void Init()
        {
            base.Init();
            //TODO 加载LuaAB包
            InitLuaEnv();
        }

        private void InitLuaEnv()
        {
            _luaEnv = new LuaEnv();
            _luaEnv.AddLoader(CustomLoader);
        }

        private byte[] CustomLoader(ref string filepath)
        {
            if (filepath.Equals("emmy_core"))
            {
                return null;
            }

            string scriptPath = string.Empty;
            filepath = filepath.Replace(".", "/") + ".lua";
            Debug.Log(filepath);
            scriptPath = $"{Application.dataPath}/{_luaScriptsFolder}/{filepath}";
            // Debug.Log(scriptPath);
            if (File.Exists(scriptPath))
            {
                return File.ReadAllBytes(scriptPath);
            }

            Debug.LogError("CustomLoader重定向失败:" + scriptPath);
            return null;
        }

        public void StartGame()
        {
            if (_luaEnv == null)
                return;
            LoadScript(_gameMainScriptName);
            DoString("GameMain.Start()");
        }

        public void DoString(string scriptContent)
        {
            if (_luaEnv != null)
            {
                try
                {
                    _luaEnv.DoString(scriptContent);
                }
                catch (Exception ex)
                {
                    string msg = $"xLua exception : {ex.Message}\n {ex.StackTrace}";
                    Debug.LogError(msg);
                }
            }
        }

        public void ReloadScript(string scriptName)
        {
            DoString($"package.loaded['{scriptName}'] = nil");
            LoadScript(scriptName);
        }

        private void LoadScript(string scriptName)
        {
            DoString($"require('{scriptName}')");
        }

        private void Update()
        {
            if (_luaEnv != null)
            {
                _luaEnv.Tick();

                if (Time.frameCount % 100 == 0)
                {
                    _luaEnv.FullGc();
                }
            }
        }

        public override void Dispose()
        {
            base.Dispose();
            if (_luaEnv != null)
            {
                try
                {
                    _luaEnv.Dispose();
                    _luaEnv = null;
                }
                catch (Exception ex)
                {
                    string msg = $"xLua exception : {ex.Message}\n {ex.StackTrace}";
                    Debug.LogError(msg);
                }
            }
        }
    }
}