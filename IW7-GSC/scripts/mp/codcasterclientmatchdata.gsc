/***************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\codcasterclientmatchdata.gsc
***************************************************/

shouldlogcodcasterclientmatchdata() {
  return getdvarint("com_codcasterEnabled", 0) == 1 && getdvarint("systemlink");
}

canlogclient(param_00) {
  if(isagent(param_00)) {
    return 0;
  }

  return param_00.clientid < level.maxlogclients;
}

createcodcastermatchdataforplayer(param_00) {
  var_01 = [];
  foreach(var_03 in level.codcastermatchdata.playerfields) {
    var_01[var_03[0]] = var_03[1];
  }

  return var_01;
}

removeplayerdataafterleavinggame(param_00) {
  level endon("game_ended");
  param_00 waittill("disconnect");
  if(!isDefined(level.codcastermatchdata.players[param_00.clientid])) {
    return;
  }

  level.codcastermatchdata.players[param_00.clientid] = undefined;
}

checkcodcasterplayerdataexists(param_00) {
  if(!isDefined(level.codcastermatchdata.players[param_00.clientid])) {
    var_01 = createcodcastermatchdataforplayer(param_00);
    level.codcastermatchdata.players[param_00.clientid] = var_01;
    thread removeplayerdataafterleavinggame(param_00);
  }
}

init() {
  setcodcasterclientmatchdata("map", level.script);
  var_00 = spawnStruct();
  var_00.playerfields = [["damageDone", 0],
    ["longestKillstreak", 0],
    ["shutdowns", 0],
    ["gametypePoints", 0]];
  var_00.players = [];
  level.codcastermatchdata = var_00;
}

setddlfieldsforplayer(param_00) {
  foreach(var_02 in level.codcastermatchdata.playerfields) {
    setcodcasterclientmatchdata("players", param_00.codcastermatchdataid, var_02[0], level.codcastermatchdata.players[param_00.clientid][var_02[0]]);
  }

  setcodcasterclientmatchdata("players", param_00.codcastermatchdataid, "username", param_00.name);
}

sendcodcastermatchdata() {
  var_00 = 0;
  foreach(var_02 in level.players) {
    checkcodcasterplayerdataexists(var_02);
    var_02.codcastermatchdataid = var_00;
    setddlfieldsforplayer(var_02);
    var_00++;
  }

  sendcodcasterclientmatchdata();
}

setcodcasterplayervalue(param_00, param_01, param_02) {
  if(!canlogclient(param_00)) {
    return;
  }

  checkcodcasterplayerdataexists(param_00);
  var_03 = level.codcastermatchdata.players[param_00.clientid];
  if(!isDefined(var_03) || !isDefined(var_03[param_01])) {
    return;
  }

  level.codcastermatchdata.players[param_00.clientid][param_01] = param_02;
}

getcodcasterplayervalue(param_00, param_01) {
  if(!canlogclient(param_00)) {
    return;
  }

  checkcodcasterplayerdataexists(param_00);
  var_02 = level.codcastermatchdata.players[param_00.clientid];
  if(!isDefined(var_02) || !isDefined(var_02[param_01])) {
    return;
  }

  return var_02[param_01];
}