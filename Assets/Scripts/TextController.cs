using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using XLua;

[LuaCallCSharp]
public class TextController {

    public static void SubmitCard(string card, string color, int num, int turn)
    {
        if (num == 7)
        {
            GameObject.Find("GuiCamera/MainCanvas(Clone)/" + color + "_up").GetComponent<Text>().text = "8";
            GameObject.Find("GuiCamera/MainCanvas(Clone)/" + color + "_down").GetComponent<Text>().text = "6";
        }
        else if (num > 7)
        {
            GameObject.Find("GuiCamera/MainCanvas(Clone)/" + color + "_up").GetComponent<Text>().text = (num + 1).ToString();
        }
        else
        {
            GameObject.Find("GuiCamera/MainCanvas(Clone)/" + color + "_down").GetComponent<Text>().text = (num - 1).ToString();
        }
    }
}
