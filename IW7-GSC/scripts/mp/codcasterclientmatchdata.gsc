/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\codcasterclientmatchdata.gsc
***************************************************/

shouldlogcodcasterclientmatchdata() {
  return getdvarint("com_codcasterEnabled", 0) == 1 && getdvarint("systemlink");
}

canlogclient(var_0) {
  if(isagent(var_0)) {
    return 0;
  }

  return var_0.clientid < level.maxlogclients;
}

createcodcastermatchdataforplayer(var_0) {
  var_1 = [];
  foreach(var_3 in level.codcastermatchdata.playerfields) {
    var_1[var_3[0]] = var_3[1];
  }

  return var_1;
}

removeplayerdataafterleavinggame(var_0) {
  level endon("game_ended");
  var_0 waittill("disconnect");
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
  setcodcasterclientmatchdata("map", level.script);
  var_0 = spawnStruct();
  var_0.playerfields = [["damageDone", 0],
    ["longestKillstreak", 0],
    ["shutdowns", 0],
    ["gametypePoints", 0]];
  var_0.players = [];
  level.codcastermatchdata = var_0;
}

setddlfieldsforplayer(var_0) {
  foreach(var_2 in level.codcastermatchdata.playerfields) {
    setcodcasterclientmatchdata("players", var_0.codcastermatchdataid, var_2[0], level.codcastermatchdata.players[var_0.clientid][var_2[0]]);
  }

  setcodcasterclientmatchdata("players", var_0.codcastermatchdataid, "username", var_0.name);
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
}

getcodcasterplayervalue(var_0, var_1) {
  if(!canlogclient(var_0)) {
    return;
  }

  checkcodcasterplayerdataexists(var_0);
  var_2 = level.codcastermatchdata.players[var_0.clientid];
  if(!isDefined(var_2) || !isDefined(var_2[var_1])) {
    return;
  }

  return var_2[var_1];
}