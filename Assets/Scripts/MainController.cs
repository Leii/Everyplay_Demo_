using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class MainController : MonoBehaviour {

    public Button btn_play;
    public Button btn_stop;
    public Button btn_replay;
    public Text stateTxt;
	private float pos_x;
	private float pos_y;
    private float pos_z;
;
    bool isMove;

	// Use this for initialization
	void Start () {
        isMove = true;
		pos_x = this.transform.position.x;
		pos_y = this.transform.position.
        pos_z = this.transform.position.z;
      
        if (Everyplay.IsSupported()&&Everyplay.IsRecordingSupported())
        {
            stateTxt.text = "is supported";
        }

        btn_play.onClick.AddListener(delegate()
        {
            Debug.Log("Start Recording!");
            Everyplay.SetMetadata("score",pos_z);
            if (Everyplay.IsRecording())
            {
                stateTxt.text = "is recording";
            }else
                stateTxt.text = "error";
            
            Everyplay.StartRecording();
        });
        btn_stop.onClick.AddListener(delegate()
        {
            stateTxt.text = "stop recording";
            Everyplay.StopRecording();
            Debug.Log("Stop Recording!");
        });
        btn_replay.onClick.AddListener(delegate()
        {
            Everyplay.PlayLastRecording();
            isMove = false;
            Debug.Log("play last recording");
           
        });

	}
   
	// Update is called once per frame
	void Update () {
        if (isMove)
        {
            this.transform.Translate(new Vector3(0, 0, -0.01f));
        }
       
	}
}
