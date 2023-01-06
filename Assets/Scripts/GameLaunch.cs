using System;
using Framework;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;

public class GameLaunch : MonoBehaviour
{
    private void Start()
    {
        XLuaManager.Instance.StartGame();
    }
    
    
}