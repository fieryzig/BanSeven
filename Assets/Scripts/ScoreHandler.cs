using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreHandler {

    private ScoreHandler() { }
    public static readonly ScoreHandler instance = new ScoreHandler();

    private int[] score = new int[4];
    public void setScore(int id, int sc)
    {
        score[id] = sc;
    }

    public void modScore(int id, int sc)
    {
        score[id] -= sc;
    }

    public void getScore()
    {
        for(int i=0; i < 4; i++)
        {
            GameObject go = GameObject.Find("GuiCamera/OverCanvas(Clone)/ScorePanel/Player" + i.ToString());
            go.GetComponent<Text>().text = go.GetComponent<Text>().text + score[i].ToString();
        }
    }
}
