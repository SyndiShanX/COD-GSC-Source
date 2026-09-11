/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\codcasterclientmatchdata.gsc
***************************************************/

function shouldlogcodcasterclientmatchdata() {
  return level.codcasterenabled;
}

function canlogclient(var_0) {
  if(isagent(var_0)) {
    return false;
  }

  return var_0.clientid < level.maxlogclients;
}

function createcodcastermatchdataforplayer(var_0) {
  var_1 = [];

  foreach(var_3 in level.codcastermatchdata.playerfields) {
    var_1 = var_3[1];
  }

  return var_1;
}

function removeplayerdataafterleavinggame(var_0) {
  level endon("game_ended");
  var_0 waittill("disconnect");

  if(!isDefined(level.codcastermatchdata.players[var_0.clientid])) {
    return;
  }

  level.codcastermatchdata.players[var_0.clientid] = undefined;
}

function checkcodcasterplayerdataexists(var_0) {
  if(!isDefined(level.codcastermatchdata.players[var_0.clientid])) {
    var_1 = createcodcastermatchdataforplayer(var_0);
    level.codcastermatchdata.players[var_0.clientid] = var_1;
    thread removeplayerdataafterleavinggame(var_0);
    return;
  }
}

function init() {
  setcodcasterclientmatchdata("map", level.script);
  var_0 = spawnStruct();
  var_0.playerfields = [["damageDone", 0], ["longestKillstreak", 0], ["shutdowns", 0], ["gametypePoints", 0]];
  var_0.players = [];
  level.codcastermatchdata = var_0;
}

function setddlfieldsforplayer(var_0) {
  foreach(var_2 in level.codcastermatchdata.playerfields) {
    setcodcasterclientmatchdata("players", var_0.codcastermatchdataid, var_2[0], level.codcastermatchdata.players[var_0.clientid][var_2[0]]);
  }

  setcodcasterclientmatchdata("players", var_0.codcastermatchdataid, "username", var_0.name);
}

function sendcodcastermatchdata() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    checkcodcasterplayerdataexists(var_2);
    var_2.codcastermatchdataid = var_0;
    setddlfieldsforplayer(var_2);
    var_0++;
  }

  sendcodcasterclientmatchdata();
}

function setcodcasterplayervalue(var_0, var_1, var_2) {
  if(!canlogclient(var_0)) {
    return;
  }

  checkcodcasterplayerdataexists(var_0);
  var_3 = level.codcastermatchdata.players[var_0.clientid];

  if(!isDefined(var_3) || !isDefined(var_3[var_1])) {
    return;
  }

  level.codcastermatchdata.players[var_0.clientid][var_1] = var_2;

  if(var_1 == "damageDone") {
    var_0 getplayergpadenabled(var_2);
    return;
  }
}

function getcodcasterplayervalue(var_0, var_1) {
  if(!canlogclient(var_0)) {
    return 0;
  }

  checkcodcasterplayerdataexists(var_0);
  var_2 = level.codcastermatchdata.players[var_0.clientid];

  if(!isDefined(var_2) || !isDefined(var_2[var_1])) {
    return 0;
  }

  return var_2[var_1];
}