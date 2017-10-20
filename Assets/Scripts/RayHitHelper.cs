using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using XLua;

[LuaCallCSharp]
public class RayHitHelper {

    private RayHitHelper() { }
    public static readonly RayHitHelper instance = new RayHitHelper();

    public string GetHit(Vector3 pos)
    {
        
        Ray ray = Camera.main.ScreenPointToRay(pos);
        Debug.Log(ray);
        RaycastHit hit;
        if (Physics.Raycast(ray,out hit))
        {
            return hit.transform.gameObject.name;
        }
        return null;
    }
}
