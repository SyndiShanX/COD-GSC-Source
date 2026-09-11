/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\codcasterclientmatchdata.gsc
***************************************************/

function shouldlogcodcasterclientmatchdata() {
  return level.codcasterenabled;
}

function canlogclient(var0) {
  if(isagent(var0)) {
    return false;
  }

  return var0.clientid < level.maxlogclients;
}

function createcodcastermatchdataforplayer(var0) {
  var1 = [];

  foreach(var3 in level.codcastermatchdata.playerfields) {
    var1 = var3[1];
  }

  return var1;
}

function removeplayerdataafterleavinggame(var0) {
  level endon("game_ended");
  var0 waittill("disconnect");

  if(!isDefined(level.codcastermatchdata.players[var0.clientid])) {
    return;
  }

  level.codcastermatchdata.players[var0.clientid] = undefined;
}

function checkcodcasterplayerdataexists(var0) {
  if(!isDefined(level.codcastermatchdata.players[var0.clientid])) {
    var1 = createcodcastermatchdataforplayer(var0);
    level.codcastermatchdata.players[var0.clientid] = var1;
    thread removeplayerdataafterleavinggame(var0);
    return;
  }
}

function init() {
  setcodcasterclientmatchdata("map", level.script);
  var0 = spawnStruct();
  var0.playerfields = [["damageDone", 0], ["longestKillstreak", 0], ["shutdowns", 0], ["gametypePoints", 0]];
  var0.players = [];
  level.codcastermatchdata = var0;
}

function setddlfieldsforplayer(var0) {
  foreach(var2 in level.codcastermatchdata.playerfields) {
    setcodcasterclientmatchdata("players", var0.codcastermatchdataid, var2[0], level.codcastermatchdata.players[var0.clientid][var2[0]]);
  }

  setcodcasterclientmatchdata("players", var0.codcastermatchdataid, "username", var0.name);
}

function sendcodcastermatchdata() {
  var0 = 0;

  foreach(var2 in level.players) {
    checkcodcasterplayerdataexists(var2);
    var2.codcastermatchdataid = var0;
    setddlfieldsforplayer(var2);
    var0++;
  }

  sendcodcasterclientmatchdata();
}

function setcodcasterplayervalue(var0, var1, var2) {
  if(!canlogclient(var0)) {
    return;
  }

  checkcodcasterplayerdataexists(var0);
  var3 = level.codcastermatchdata.players[var0.clientid];

  if(!isDefined(var3) || !isDefined(var3[var1])) {
    return;
  }

  level.codcastermatchdata.players[var0.clientid][var1] = var2;

  if(var1 == "damageDone") {
    var0 getplayergpadenabled(var2);
    return;
  }
}

function getcodcasterplayervalue(var0, var1) {
  if(!canlogclient(var0)) {
    return 0;
  }

  checkcodcasterplayerdataexists(var0);
  var2 = level.codcastermatchdata.players[var0.clientid];

  if(!isDefined(var2) || !isDefined(var2[var1])) {
    return 0;
  }

  return var2[var1];
}