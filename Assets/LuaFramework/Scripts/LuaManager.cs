using UnityEngine;
using System.Collections;
using XLua;
using System.IO;

namespace LuaFramework
{
    public class LuaManager : MonoBehaviour
    {
        private LuaEnv lua;

        // Use this for initialization
        void Awake()
        {
            lua = new LuaEnv();
            lua.AddLoader((ref string filename) => {
                filename = filename + ".lua";
                if (File.Exists(Application.dataPath + "/LuaFramework/Lua/" + filename))
                {
                    string script = File.ReadAllText(Application.dataPath + "/LuaFramework/Lua/" + filename);
                    return System.Text.Encoding.UTF8.GetBytes(script);
                }
                return null;           
            });
            lua.AddLoader((ref string filename) => {
                filename = filename + ".lua";
                TextAsset script = Resources.Load<TextAsset>("/Lua/" + filename);
                if (script != null) return script.bytes;
                return null;
            });
        }

        public void InitStart()
        {
            lua.DoString("require 'main'");
            CallFunction("Main");
        }
        /*
        public object[] DoFile(string filename)
        {
            return lua.DoString("require '" + filename + "'");
        }
        */
        public object[] CallFunction(string funcName, params object[] args)
        {
            LuaFunction func = lua.Global.Get<LuaFunction>(funcName);
            if (func != null)
            {
                return func.Call(args);
            }
            return null;
        }

        public void LuaGC()
        {
            lua.GC();
        }

        public void Close()
        {
            lua.Dispose();
            lua = null;
        }
    }
}