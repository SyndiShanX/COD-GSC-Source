/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\clientmatchdata.gsc
***********************************************/

init() {
  if(getdvarint("online_mp_clientmatchdata_enabled") != 0 && !isDefined(game["clientMatchDataDef"])) {
    game["clientMatchDataDef"] = "ddl/mp/clientmatchdata.ddl";
    setclientmatchdatadef(game["clientMatchDataDef"]);
    setclientmatchdata("map", level.script);
  }

  level.clientmatchdata_logplayerdeath = ::logplayerdeath;
}

canlogclient(_id_2C6CA80E296FED3A) {
  if(isagent(_id_2C6CA80E296FED3A))
    return 0;

  return _id_2C6CA80E296FED3A.clientid < level.maxlogclients;
}

canlogdeath(_id_79F00192DD16D2AC) {
  return _id_79F00192DD16D2AC < 300;
}

logplayerdeath(attacker) {
  if(getdvarint("online_mp_clientmatchdata_enabled") == 0) {
    return;
  }
  _id_79F00192DD16D2AC = getclientmatchdata("deathCount");

  if(!canlogclient(self) || !canlogdeath(_id_79F00192DD16D2AC)) {
    return;
  }
  if(isPlayer(attacker) && canlogclient(attacker))
    self logclientmatchdatadeath(_id_79F00192DD16D2AC, self.clientid, attacker, attacker.clientid);
  else
    self logclientmatchdatadeath(_id_79F00192DD16D2AC, self.clientid, undefined, undefined);
}