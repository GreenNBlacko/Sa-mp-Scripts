#define FILTERSCRIPT

#include <a_samp>
#include <YSI\y_ini>
#include <zcmd>
#include <sscanf2>
#include <streamer>

#define PATH1 "/Users/Vehicles/%s_Car1.ini"
#define PATH2 "/Users/Vehicles/%s_Car2.ini"

enum
{
	CarBuy,
	CarBuyCol1,
	CarBuyCol2,
	CarBuyConfirm
}

enum CarBuyInfo{Price,ModelID,Col1,Col2}
new CBI[MAX_PLAYERS][CarBuyInfo];

enum vInfo
{
    bool:VehicleOwned,
    CarID,
    car,
    Float:CarPosX,
    Float:CarPosY,
    Float:CarPosZ,
    Float:CarZAngle,
    CarCol1,
    CarCol2
}
new VehicleInfo1[MAX_PLAYERS][vInfo];
new VehicleInfo2[MAX_PLAYERS][vInfo];

new VehNum;

forward LoadVehicle_data(playerid,name[],value[]);
public LoadVehicle_data(playerid,name[],value[])
{
	if(VehNum == 1){
		INI_Bool("VehicleOwned",VehicleInfo1[playerid][VehicleOwned]);
 		INI_Int("CarID",VehicleInfo1[playerid][CarID]);
	 	INI_Int("car",VehicleInfo1[playerid][car]);
	 	INI_Float("CarPosX",VehicleInfo1[playerid][CarPosX]);
	 	INI_Float("CarPosY",VehicleInfo1[playerid][CarPosY]);
	 	INI_Float("CarPosZ",VehicleInfo1[playerid][CarPosZ]);
	 	INI_Float("CarZAngle",VehicleInfo1[playerid][CarZAngle]);
	 	INI_Int("CarCol1",VehicleInfo1[playerid][CarCol1]);
	 	INI_Int("CarCol2",VehicleInfo1[playerid][CarCol2]);
	 	return 0;
 	}
	else if(VehNum == 2){
		INI_Bool("VehicleOwned",VehicleInfo2[playerid][VehicleOwned]);
	 	INI_Int("CarID",VehicleInfo2[playerid][CarID]);
 	 	INI_Int("car",VehicleInfo2[playerid][car]);
 	 	INI_Float("CarPosX",VehicleInfo2[playerid][CarPosX]);
 	 	INI_Float("CarPosY",VehicleInfo2[playerid][CarPosY]);
 	 	INI_Float("CarPosZ",VehicleInfo2[playerid][CarPosZ]);
 		INI_Float("CarZAngle",VehicleInfo2[playerid][CarZAngle]);
	 	INI_Int("CarCol1",VehicleInfo2[playerid][CarCol1]);
	 	INI_Int("CarCol2",VehicleInfo2[playerid][CarCol2]);
	 	return 0;
	}
    return 1;
}

stock VehPath(playerid,VehicleNumber)
{
    new string[128],playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,playername,sizeof(playername));
	if(VehicleNumber == 1) { format(string,sizeof(string),PATH1,playername); }
	else if(VehicleNumber == 2) { format(string,sizeof(string),PATH2,playername); }
	return string;
}

/*Credits to Dracoblue*/
stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new Float:PosX1,
		Float:PosY1,
		Float:PosZ1,
		Float:ZAngle1,
		Float:PosX2,
		Float:PosY2,
		Float:PosZ2,
		Float:ZAngle2;
	GetVehiclePos(VehicleInfo1[playerid][car],PosX1,PosY1,PosZ1);
	GetVehicleZAngle(VehicleInfo1[playerid][car],ZAngle1);
	GetVehiclePos(VehicleInfo2[playerid][car],PosX2,PosY2,PosZ2);
	GetVehicleZAngle(VehicleInfo2[playerid][car],ZAngle2);
    new INI:File1 = INI_Open(VehPath(playerid,1));
    INI_SetTag(File1,"data");
    INI_WriteBool(File1,"VehicleOwned",VehicleInfo1[playerid][VehicleOwned]);
    INI_WriteInt(File1,"CarID",VehicleInfo1[playerid][CarID]);
    INI_WriteInt(File1,"car",VehicleInfo1[playerid][car]);
    INI_WriteFloat(File1,"CarPosX",PosX1);
    INI_WriteFloat(File1,"CarPosY",PosY1);
    INI_WriteFloat(File1,"CarPosZ",PosZ1);
    INI_WriteFloat(File1,"CarZAngle",ZAngle1);
    INI_WriteInt(File1,"CarCol1",VehicleInfo1[playerid][CarCol1]);
    INI_WriteInt(File1,"CarCol2",VehicleInfo1[playerid][CarCol2]);
    INI_Close(File1);
	DestroyVehicle(VehicleInfo1[playerid][car]);
	
    new INI:File2 = INI_Open(VehPath(playerid,2));
    INI_SetTag(File2,"data");
    INI_WriteBool(File2,"VehicleOwned",VehicleInfo2[playerid][VehicleOwned]);
    INI_WriteInt(File2,"CarID",VehicleInfo2[playerid][CarID]);
    INI_WriteInt(File1,"car",VehicleInfo2[playerid][car]);
    INI_WriteFloat(File2,"CarPosX",PosX2);
    INI_WriteFloat(File2,"CarPosY",PosY2);
    INI_WriteFloat(File2,"CarPosZ",PosZ2);
    INI_WriteFloat(File2,"CarZAngle",ZAngle2);
    INI_WriteInt(File2,"CarCol1",VehicleInfo2[playerid][CarCol1]);
    INI_WriteInt(File2,"CarCol2",VehicleInfo2[playerid][CarCol2]);
    INI_Close(File2);
    DestroyVehicle(VehicleInfo2[playerid][car]);
	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(fexist(VehPath(playerid,1)))
    {
        VehNum = 1;
        INI_ParseFile(VehPath(playerid,1), "LoadVehicle_%s", .bExtra = true, .extra = playerid);
        //if(VehicleInfo1[playerid][VehicleOwned] == true) {
        new VehicleID,Float:VehPosX,Float:VehPosY,Float:VehPosZ,VehCol1,VehCol2;
        VehicleID = VehicleInfo1[playerid][CarID];
        VehPosX = VehicleInfo1[playerid][CarPosX];
        VehPosY = VehicleInfo1[playerid][CarPosY];
        VehPosZ = VehicleInfo1[playerid][CarPosZ];
        VehCol1 = VehicleInfo1[playerid][CarCol1];
        VehCol2 = VehicleInfo1[playerid][CarCol2];
		VehicleInfo1[playerid][car] = AddStaticVehicleEx(VehicleID,VehPosX,VehPosY,VehPosZ,0,VehCol1,VehCol2,-1,0);
		if(VehicleInfo1[playerid][car] != INVALID_VEHICLE_ID) {printf("Spawned car ID:%i,Pos:X:%f,Y:%f,Z:%f, successfuly",VehicleID,VehPosX,VehPosY,VehPosZ);}
		//}
    }
    else if(!fexist(VehPath(playerid,1)))
    {
        new INI:File1 = INI_Open(VehPath(playerid, 1));
        INI_SetTag(File1,"data");
        INI_WriteBool(File1,"VehicleOwned",false);
        INI_WriteInt(File1,"CarID",0);
        INI_WriteInt(File1,"car",0);
        INI_WriteFloat(File1,"CarPosX",0);
        INI_WriteFloat(File1,"CarPosY",0);
        INI_WriteFloat(File1,"CarPosZ",0);
        INI_WriteFloat(File1,"CarZAngle",0);
        INI_WriteInt(File1,"CarCol1",0);
        INI_WriteInt(File1,"CarCol2",0);
        INI_Close(File1);
    }
    else if(fexist(VehPath(playerid,2)))
    {
        VehNum = 2;
        INI_ParseFile(VehPath(playerid,2), "LoadVehicle_%s", .bExtra = true, .extra = playerid);
        if(VehicleInfo2[playerid][VehicleOwned] == true) {
 	 		VehicleInfo2[playerid][car] = AddStaticVehicleEx(VehicleInfo2[playerid][CarID],VehicleInfo2[playerid][CarPosX],VehicleInfo2[playerid][CarPosY],VehicleInfo2[playerid][CarPosZ],0,VehicleInfo2[playerid][CarCol1],VehicleInfo2[playerid][CarCol2],-1,0);
		}
	}
    else if(!fexist(VehPath(playerid,2)))
    {
        new INI:File2 = INI_Open(VehPath(playerid, 2));
        INI_SetTag(File2,"data");
        INI_WriteBool(File2,"VehicleOwned",false);
        INI_WriteInt(File2,"CarID",0);
        INI_WriteInt(File2,"car",0);
        INI_WriteFloat(File2,"CarPosX",0);
        INI_WriteFloat(File2,"CarPosY",0);
        INI_WriteFloat(File2,"CarPosZ",0);
        INI_WriteFloat(File2,"CarZAngle",0);
        INI_WriteInt(File2,"CarCol1",0);
        INI_WriteInt(File2,"CarCol2",0);
        INI_Close(File2);
    }
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/someting", cmdtext, true, 10) == 0)
	{
		
		return 1;
	}
	return 0;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid){
		case CarBuy: {
			if(response){
				ShowPlayerDialog(playerid,CarBuyCol1,2,"Select color 1","Black\n\
				White\n\
 				Red\n\
 				Green\n\
	 			Blue","Next","Back");
 	 			switch(listitem) {
 					case 0:{CBI[playerid][ModelID] = 496;
					 		CBI[playerid][Price] = 7600;}
 					case 1:{CBI[playerid][ModelID] = 560;
					 		CBI[playerid][Price] = 18500;}
 					case 2:{CBI[playerid][ModelID] = 522;
					 		CBI[playerid][Price] = 14500;}
				}
			}
			return 1;
		}
		case CarBuyCol1: {
			if(response){
				ShowPlayerDialog(playerid,CarBuyCol2,2,"Select color 2","Black\n\
				White\n\
 				Red\n\
 				Green\n\
	 			Blue","Next","Back");
 	 			switch(listitem) {
 					case 0:{CBI[playerid][Col1] = 0;}
 					case 1:{CBI[playerid][Col1] = 1;}
 					case 2:{CBI[playerid][Col1] = 3;}
 					case 3:{CBI[playerid][Col1] = 16;}
 					case 4:{CBI[playerid][Col1] = 7;}
				}
			} else {
   				ShowPlayerDialog(playerid,CarBuy,5,"Buy vehicle","Vehicle Name\tPrice\n\
				   Blista Compact\t7600$\n\
				   Sultan\t18500$\n\
				   NRG-500\t14500$","Buy","Cancel");
			}
			return 1;
		}
		case CarBuyCol2: {
			if(response){
				ShowPlayerDialog(playerid,CarBuyConfirm,0,"Confirm purchase","Are you sure you want to buy this vehicle?","Buy","Back");
				switch(listitem) {
 					case 0:{CBI[playerid][Col2] = 0;}
 					case 1:{CBI[playerid][Col2] = 1;}
 					case 2:{CBI[playerid][Col2] = 3;}
 					case 3:{CBI[playerid][Col2] = 16;}
 					case 4:{CBI[playerid][Col2] = 7;}
				}
			} else {
			    ShowPlayerDialog(playerid,CarBuyCol1,2,"Select color 1","Black\n\
				White\n\
 				Red\n\
 				Green\n\
	 			Blue","Next","Back");
			}
			return 1;
		}
		case CarBuyConfirm: {
			if(response){
		        new Float:PosX,Float:PosY,Float:PosZ;
		        GetPlayerPos(playerid,PosX,PosY,PosZ);
				if(VehicleInfo1[playerid][VehicleOwned] == false) {
				    if(GetPlayerMoney(playerid) >= CBI[playerid][Price]) {
                        GivePlayerMoney(playerid,-CBI[playerid][Price]);
						VehicleInfo1[playerid][car] = AddStaticVehicleEx(CBI[playerid][ModelID],PosX+5,PosY,PosZ,0,CBI[playerid][Col1],CBI[playerid][Col2],-1,0);
						new INI:File1 = INI_Open(VehPath(playerid,1));
    					INI_SetTag(File1,"data");
    					INI_WriteBool(File1,"VehicleOwned",true);
    					INI_WriteInt(File1,"CarID",CBI[playerid][ModelID]);
    					INI_WriteInt(File1,"car",VehicleInfo1[playerid][car]);
    					INI_WriteFloat(File1,"CarPosX",PosX+5);
    					INI_WriteFloat(File1,"CarPosY",PosY);
    					INI_WriteFloat(File1,"CarPosZ",PosZ);
    					INI_WriteFloat(File1,"CarZAngle",0);
    					INI_WriteInt(File1,"CarCol1",CBI[playerid][Col1]);
    					INI_WriteInt(File1,"CarCol2",CBI[playerid][Col2]);
    					INI_Close(File1);
						print("Bought car on slot 1");
					} else {
						SendClientMessage(playerid,0xD80000FF,"You don't have enough money to buy this vehicle");
						ShowPlayerDialog(playerid,CarBuy,5,"Buy vehicle","{FFFFFF}Vehicle Name\tPrice\n\
						Blista Compact\t7600$\n\
						Sultan\t18500$\n\
						NRG-500\t14500$","Buy","Cancel");
					}
				} else {
					if(VehicleInfo2[playerid][VehicleOwned] == false) {
                        if(GetPlayerMoney(playerid) >= CBI[playerid][Price]) {
                        	GivePlayerMoney(playerid,-CBI[playerid][Price]);
                        	VehicleInfo2[playerid][VehicleOwned] = true;
							VehicleInfo1[playerid][car] = AddStaticVehicleEx(CBI[playerid][ModelID],PosX+5,PosY,PosZ,0,CBI[playerid][Col1],CBI[playerid][Col2],-1,0);
							new INI:File2 = INI_Open(VehPath(playerid,1));
    						INI_SetTag(File2,"data");
    						INI_WriteBool(File2,"VehicleOwned",VehicleInfo2[playerid][VehicleOwned]);
    						INI_WriteInt(File2,"CarID",CBI[playerid][ModelID]);
    						INI_WriteInt(File2,"car",VehicleInfo2[playerid][car]);
    						INI_WriteFloat(File2,"CarPosX",PosX+5);
    						INI_WriteFloat(File2,"CarPosY",PosY);
    						INI_WriteFloat(File2,"CarPosZ",PosZ);
    						INI_WriteFloat(File2,"CarZAngle",0);
    						INI_WriteInt(File2,"CarCol1",CBI[playerid][Col1]);
    						INI_WriteInt(File2,"CarCol2",CBI[playerid][Col2]);
    						INI_Close(File2);
    						print("Bought car on slot 2");
						} else {
							SendClientMessage(playerid,0xD80000FF,"You don't have enough money to buy this vehicle");
							ShowPlayerDialog(playerid,CarBuy,5,"Buy vehicle","{FFFFFF}Vehicle Name\tPrice\n\
							Blista Compact\t7600$\n\
							Sultan\t18500$\n\
							NRG-500\t14500$","Buy","Cancel");
						}
					}
				}
			}
			return 1;
		}
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

CMD:vehbuy(playerid, params[]) {
    ShowPlayerDialog(playerid,CarBuy,5,"Buy vehicle","Vehicle Name\tPrice\n\
	Blista Compact\t7600$\n\
	Sultan\t18500$\n\
	NRG-500\t14500$","Buy","Cancel");
	return 1;
}
