using UnityEngine;
using System.Collections.Generic;
using System.Reflection;
using XLua;
using System;
using UnityEngine.UI;

namespace LuaFramework
{
    public static class LuaHelper
    {

        /// <summary>
        /// getType
        /// </summary>
        /// <param name="classname"></param>
        /// <returns></returns>
        public static System.Type GetType(string classname)
        {
            Assembly assb = Assembly.GetExecutingAssembly();  //.GetExecutingAssembly();
            System.Type t = null;
            t = assb.GetType(classname); ;
            if (t == null)
            {
                t = assb.GetType(classname);
            }
            return t;
        }

        /// <summary>
        /// 面板管理器
        /// </summary>
        public static PanelManager GetPanelManager()
        {
            return AppFacade.GetManager<PanelManager>();
        }

        /// <summary>
        /// 资源管理器
        /// </summary>
        public static ResourceManager GetResManager()
        {
            return AppFacade.GetManager<ResourceManager>();
        }

        /******************************************************************/

        public static void ChangeColor(GameObject obj, Color color)
        {
            obj.GetComponent<Image>().color = color;
        }

        public static void SubmitCard(string card, string color, int num, int turn)
        {
            Debug.Log("Player" + turn + "submits: " + card);
            TextController.SubmitCard(card, color, num, turn);
            int score = num;
            if (color == "d") score *= 2;
            else if (color == "h") score *= 3;
            else if (color == "s") score *= 4;
            ScoreHandler.instance.modScore(turn, score); 
        }
        
        public static void SetScore(int id, int score)
        {
            ScoreHandler.instance.setScore(id, score);
        }

        public static void GetScore()
        {
            ScoreHandler.instance.getScore();
        }

        public static void Init()
        {
            
        }
    }
}