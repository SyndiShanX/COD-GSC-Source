/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\codcasterclientmatchdata.gsc
***********************************************/

shouldlogcodcasterclientmatchdata() {
  return level.codcasterenabled;
}

canlogclient(var_0) {
  if(isagent(var_0))
    return 0;

  return var_0.clientid < level.maxlogclients;
}

createcodcastermatchdataforplayer(var_0) {
  var_1 = [];

  foreach(var_3 in level.codcastermatchdata.playerfields)
  var_1[var_3[0]] = var_3[1];

  return var_1;
}

removeplayerdataafterleavinggame(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 waittill("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(level.codcastermatchdata.players[var_0.clientid])) {
    return;
  }
  level.codcastermatchdata.players[var_0.clientid] = undefined;
}

checkcodcasterplayerdataexists(var_0) {
  if(!isDefined(level.codcastermatchdata.players[var_0.clientid])) {
    var_1 = createcodcastermatchdataforplayer(var_0);
    level.codcastermatchdata.players[var_0.clientid] = var_1;
    thread removeplayerdataafterleavinggame(var_0);
  }
}

init() {
  setcodcasterclientmatchdata("_encstr_AB1904852B68", level.script);
  var_0 = spawnStruct();
  var_0.playerfields = [["_encstr_99F30B8C2CB50B7695887BB9CA", 0], ["_encstr_9B4F125CEF40EFAF86CBF8C2D051BF631853C9D3", 0], ["_encstr_92C90ACD0DBAA391B7BBB96E", 0], ["_encstr_88A90F174EDD1A194AF98F7B2F49DD292B", 0]];
  var_0.players = [];
  level.codcastermatchdata = var_0;
}

setddlfieldsforplayer(var_0) {
  foreach(var_2 in level.codcastermatchdata.playerfields)
  setcodcasterclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.codcastermatchdataid, var_2[0], level.codcastermatchdata.players[var_0.clientid][var_2[0]]);

  setcodcasterclientmatchdata("_encstr_9775086022BE1B413B8B", var_0.codcastermatchdataid, "_encstr_9BB5094F0EC73D22DE5BBA", var_0.name);
}

sendcodcastermatchdata() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    checkcodcasterplayerdataexists(var_2);
    var_2.codcastermatchdataid = var_0;
    setddlfieldsforplayer(var_2);
    var_0++;
  }

  sendcodcasterclientmatchdata();
}

setcodcasterplayervalue(var_0, var_1, var_2) {
  if(!canlogclient(var_0)) {
    return;
  }
  checkcodcasterplayerdataexists(var_0);
  var_3 = level.codcastermatchdata.players[var_0.clientid];

  if(!isDefined(var_3) || !isDefined(var_3[var_1])) {
    return;
  }
  level.codcastermatchdata.players[var_0.clientid][var_1] = var_2;

  if(var_1 == "_encstr_99F30B8C2CB50B7695887BB9CA")
    var_0 getplayergpadenabled(var_2);
}

getcodcasterplayervalue(var_0, var_1) {
  if(!canlogclient(var_0))
    return 0;

  checkcodcasterplayerdataexists(var_0);
  var_2 = level.codcastermatchdata.players[var_0.clientid];

  if(!isDefined(var_2) || !isDefined(var_2[var_1]))
    return 0;

  return var_2[var_1];
}