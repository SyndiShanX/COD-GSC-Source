/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\clientmatchdata.gsc
***********************************************/

init() {
  if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") != 0 && !isDefined(game["_encstr_934B13B1C6D22BDC3AA62C1D1B434458A31688CACC"])) {
    game["_encstr_934B13B1C6D22BDC3AA62C1D1B434458A31688CACC"] = "_encstr_8F3B1B3BBFF93F2DC0364E45E188DD41573AEBF17851B9AC57EE12D81B";
    setclientmatchdatadef(game["_encstr_934B13B1C6D22BDC3AA62C1D1B434458A31688CACC"]);
    setclientmatchdata("_encstr_AB1904852B68", level.script);
  }

  level.heavydamageawardlaunchonly = ::logplayerdeath;
}

canlogclient(var_0) {
  if(isagent(var_0))
    return 0;

  return var_0.clientid < level.maxlogclients;
}

canlogdeath(var_0) {
  return var_0 < 300;
}

logplayerdeath(var_0) {
  if(getdvarint("_encstr_82B60B391184FF772B3949D2CE") == 0) {
    return;
  }
  var_1 = getclientmatchdata("_encstr_96320B57CB037330A5CF2BC8DB");

  if(!canlogclient(self) || !canlogdeath(var_1)) {
    return;
  }
  if(isPlayer(var_0) && canlogclient(var_0))
    self logclientmatchdatadeath(var_1, self.clientid, var_0, var_0.clientid);
  else
    self logclientmatchdatadeath(var_1, self.clientid, undefined, undefined);
}