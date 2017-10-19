using System.Collections;
using System.Collections.Generic;
using System.Net;
using System.Net.Sockets;
using System.Text;
using UnityEngine;
using XLua;

[LuaCallCSharp]
public class Network {

	private Network() { }
    public static readonly Network instance = new Network();
    public int connected = 0;

    private Socket clientSocket;
    public int Connect(string raw_ip = "127.0.0.1", int port = 7788)
    {
        IPAddress ip = IPAddress.Parse(raw_ip);
        clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
        try
        {
            clientSocket.Connect(new IPEndPoint(ip, port));
            connected = 1;
            Debug.Log("Network Connected Successfully.");
        }
        catch
        {
            Debug.Log("Failed to connect.");
            return -1;
        }

        clientSocket.ReceiveTimeout = 10;
        clientSocket.Blocking = false;
        return 0;
    }

    public void Close()
    {
        clientSocket.Close();
    }

    public string Recv()
    {
        byte[] result = new byte[1024];
        int length = 0;
        try
        {
            length = clientSocket.Receive(result);
        }
        catch
        {
            return null;
        }
        if (length == 0) return null;
        string s = Encoding.UTF8.GetString(result, 0, length);
        Debug.Log("Recv: " + s);
        return s;
    }

    public void Send(string s)
    {
        s = s + ";";
        clientSocket.Send(Encoding.UTF8.GetBytes(s));
        Debug.Log("Send: " + s);
    }
}
