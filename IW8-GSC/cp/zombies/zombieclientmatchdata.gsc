/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\zombies\zombieclientmatchdata.gsc
************************************************/

init() {
  if(!isDefined(game["_encstr_934B13B1C6D22BDC3AA62C1D1B434458A31688CACC"])) {
    game["_encstr_934B13B1C6D22BDC3AA62C1D1B434458A31688CACC"] = "_encstr_833C21DF3FBB8DE1D0262D28C7FBDABD798CB4EA80CC1381130EE0602FA87175ECCDF1";
    setclientmatchdatadef(game["_encstr_934B13B1C6D22BDC3AA62C1D1B434458A31688CACC"]);
    setclientmatchdata("_encstr_AB1904852B68", level.script);
  }

  level.maxdeaths = 50;
}

canlogclient(var_0) {
  if(isagent(var_0))
    return 0;

  return var_0.clientid < level.maxlogclients;
}

canlogdeath(var_0) {
  return var_0 < level.maxdeaths;
}

logplayerdeath() {
  var_0 = getclientmatchdata("_encstr_96320B57CB037330A5CF2BC8DB");

  if(!canlogclient(self) || !canlogdeath(var_0))
    return;
}