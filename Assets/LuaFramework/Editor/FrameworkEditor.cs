using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

public static class FrameworkEditor
{
    public static string lua_path = Application.dataPath + "/LuaFramework/Lua/";
    public static string res_path = Application.dataPath + "/Resources/Lua/";

    [MenuItem("LuaFramework/CopyLuaToResources", false, 1)]
    public static void copy()
    {
        if (!Directory.Exists(res_path)) Directory.CreateDirectory(res_path);

        copy_files(lua_path, res_path);
        var dirs = Directory.GetDirectories(lua_path);
        foreach(string dir0 in dirs)
        {
            var tmp = dir0.Split('/');
            string dir = tmp[tmp.Length - 1];
            Debug.Log(dir);
            copy_files(lua_path + dir + "/", res_path + dir + "/");
        }
    }

    public static void copy_files(string src, string des)
    {
        var lua_files = Directory.GetFiles(src);
        if (!Directory.Exists(des)) Directory.CreateDirectory(des);
        foreach (string file0 in lua_files)
        {
            Debug.Log(file0);
            if (file0.Contains("meta") || file0.Contains("vscode")) continue;
            var tmp = file0.Split('/');
            string file = tmp[tmp.Length - 1];
            File.Copy(src + file, des + file + ".txt");
        }
    }
    /*
    [MenuItem("LuaFramework/ClearLuaResources", false, 1)]
    public static void clear()
    {
        Debug.Log("Clear:" + res_path);
        Directory.Delete(res_path);
        Directory.CreateDirectory(res_path);
    }
    */
}