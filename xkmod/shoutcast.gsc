ShoutCastOverlay_Update()
{
	self endon("disconnect");
	wait 5;
	a3["axis"] = [];
	a3["allies"] = [];
	for(;;)
	{
		if(self.pers["team"] == "spectator" && isDefined(self.pers["team"]))
		{
			a1["axis"] = [];
			a1["allies"] = [];
			a2["axis"] = [];
			a2["allies"] = [];
			for ( i = 0; i < level.players.size; i++ )
			{	
				if(isDefined(level.players[i].pers["team"]))
				{
					if(level.players[i].pers["team"] == "axis") a1["axis"][a1["axis"].size] = level.players[i];
					else if(level.players[i].pers["team"] == "allies") a1["allies"][a1["allies"].size] = level.players[i];
				}
			}
			if(a1["axis"].size)
			{
				for(i=0; i<a1["axis"].size; i++)
				{
					if(isAlive(a1["axis"][i])) a2["axis"][i] = "^7"+a1["axis"][i].name;
					//else a2["axis"][i] = "^0"+a1["axis"][i].name;
					else a2["axis"][i] = "";
				}
			}
			if(a1["axis"].size < 10) 
			{
				for(i=a1["axis"].size; i<10; i++) a2["axis"][i] = "";
			}
			for(i=0; i<a2["axis"].size; i++)
			{
				if(a2["axis"][i] != a3["axis"][i])
				{ 
					self setclientdvar("ui_shoutcast_ax"+i, a2["axis"][i]);
					waittillframeend;
				}
			}			
			a3["axis"] = a2["axis"];
			if(a1["allies"].size)
			{
				for(i=0; i<a1["allies"].size; i++)
				{
					if(isAlive(a1["allies"][i])) a2["allies"][i] = "^7"+a1["allies"][i].name;
					//else a2["allies"][i] = "^0"+a1["allies"][i].name;
					else a2["allies"][i] = "";
				}
			}
			if(a1["allies"].size < 10) 
			{
				for(i=a1["allies"].size; i<10; i++) a2["allies"][i] = "";
			}
			for(i=0; i<a2["allies"].size; i++)
			{
				if(a2["allies"][i] != a3["allies"][i]) 
				{ 
					self setclientdvar("ui_shoutcast_al"+i, a2["allies"][i]);
					waittillframeend;
				}
			}
			a3["allies"] = a2["allies"];
		}
		wait .3;
	}
}