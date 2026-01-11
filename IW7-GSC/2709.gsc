/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2709.gsc
***************************************/

shouldlogcodcasterclientmatchdata() {
  return getdvarint("com_codcasterEnabled", 0) == 1 && getdvarint("systemlink");
}

canlogclient(var_00) {
  if(isagent(var_00)) {
    return 0;
  }

  return var_0.clientid < level.maxlogclients;
}

createcodcastermatchdataforplayer(var_00) {
  var_01 = [];

  foreach(var_03 in level.codcastermatchdata.playerfields) {
  var_1[var_3[0]] = var_3[1];
  }

  return var_01;
}

removeplayerdataafterleavinggame(var_00) {
  level endon("game_ended");
  var_00 waittill("disconnect");

  if(!isDefined(level.codcastermatchdata.players[var_0.clientid])) {
    return;
  }
  level.codcastermatchdata.players[var_0.clientid] = undefined;
}

checkcodcasterplayerdataexists(var_00) {
  if(!isDefined(level.codcastermatchdata.players[var_0.clientid])) {
    var_01 = createcodcastermatchdataforplayer(var_00);
    level.codcastermatchdata.players[var_0.clientid] = var_01;
    thread removeplayerdataafterleavinggame(var_00);
  }
}

init() {
  setcodcasterclientmatchdata("map", level.script);
  var_00 = spawnStruct();
  var_0.playerfields = [
    ["damageDone", 0],
    ["longestKillstreak", 0],
    ["shutdowns", 0],
    ["gametypePoints", 0]
  ];
  var_0.players = [];
  level.codcastermatchdata = var_00;
}

setddlfieldsforplayer(var_00) {
  foreach(var_02 in level.codcastermatchdata.playerfields) {
  setcodcasterclientmatchdata("players", var_0.codcastermatchdataid, var_2[0], level.codcastermatchdata.players[var_0.clientid][var_2[0]]);
  }

  setcodcasterclientmatchdata("players", var_0.codcastermatchdataid, "username", var_0.name);
}

sendcodcastermatchdata() {
  var_00 = 0;

  foreach(var_02 in level.players) {
    checkcodcasterplayerdataexists(var_02);
    var_2.codcastermatchdataid = var_00;
    setddlfieldsforplayer(var_02);
    var_0++;
  }

  sendcodcasterclientmatchdata();
}

setcodcasterplayervalue(var_00, var_01, var_02) {
  if(!canlogclient(var_00)) {
    return;
  }
  checkcodcasterplayerdataexists(var_00);
  var_03 = level.codcastermatchdata.players[var_0.clientid];

  if(!isDefined(var_03) || !isDefined(var_3[var_01])) {
    return;
  }
  level.codcastermatchdata.players[var_0.clientid][var_01] = var_02;
}

getcodcasterplayervalue(var_00, var_01) {
  if(!canlogclient(var_00)) {
    return;
  }
  checkcodcasterplayerdataexists(var_00);
  var_02 = level.codcastermatchdata.players[var_0.clientid];

  if(!isDefined(var_02) || !isDefined(var_2[var_01])) {
    return;
  }
  return var_2[var_01];
}