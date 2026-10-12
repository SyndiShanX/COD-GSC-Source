/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\clientmatchdata.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#namespace clientmatchdata;

function init() {
  if(getdvarint(@ "online_mp_clientmatchdata_enabled") != 0 && !isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "ddl/mp/clientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level.clientmatchdata_logplayerdeath = &logplayerdeath;
}

function canlogclient(client) {
  if(isagent(client)) {
    return false;
  }

  assertex(isPlayer(client), "<dev string:x1c>" + client.code_classname);
  return client.clientid < level.maxlogclients;
}

function canlogdeath(deathid) {
  return deathid < 300;
}

function logplayerdeath(attacker) {
  if(getdvarint(@ "online_mp_clientmatchdata_enabled") == 0) {
    return;
  }

  deathid = getclientmatchdata("deathCount");

  if(!canlogclient(self) || !canlogdeath(deathid)) {
    return;
  }

  if(isPlayer(attacker) && canlogclient(attacker)) {
    self logclientmatchdatadeath(deathid, self.clientid, attacker, attacker.clientid);
    return;
  }

  self logclientmatchdatadeath(deathid, self.clientid, undefined, undefined);
}