using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class CardController : MonoBehaviour, IPointerDownHandler{

    public bool locked = false;
	// Use this for initialization
	void Start () {
        locked = false;
	}
	
	// Update is called once per frame
	void Update () {
        
	}

    public void OnPointerDown(PointerEventData eventData)
    {
        Debug.Log("hit: " + this.gameObject.name);
        if (locked) return;
        var cards = GameObject.FindGameObjectsWithTag("card");
        foreach(GameObject card in cards)
        {
            float x = card.transform.localPosition.x;
            card.transform.localPosition = new Vector3(x,-150,0);
        }
        if (transform.localPosition.y == -150) transform.localPosition += new Vector3(0, 20, 0);
        else transform.localPosition -= new Vector3(0, 20, 0);
    }
}
