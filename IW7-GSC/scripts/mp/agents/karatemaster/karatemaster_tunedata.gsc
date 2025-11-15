/********************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\agents\karatemaster\karatemaster_tunedata.gsc
********************************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["karatemaster"] = spawnStruct();
  setupkaratemastertunedata(level.agenttunedata["karatemaster"]);
}

setupkaratemastertunedata(param_00) {
  param_00.cteleportthisclosetoplayer = 60;
  param_00.cmeleemaxstanddistsq = 4096;
  param_00.cmeleemaxzdiff = 60;
  param_00.cteleportmindist = 400;
  param_00.cteleportmintimebetween = 1000;
  param_00.cteleportmintimebetween_global = 1000;
  param_00.cwiggleroom = 30;
  param_00.cstandattackwiggleroom = 30;
  param_00.crethinkmovemeleetime = 3000;
  param_00.cpunchmeleedamage = 45;
  param_00.ckickmeleedamage = 55;
  param_00.cpunchandkickmeleeradiussq = 1600;
  param_00.cmaxmeleeflexscale = 5;
  param_00.ballowteleportinfrontofsprinter = 1;
  param_00.cfastteleportduetodamagechance = 100;
  param_00.cfastteleportdamagepct = 0.001;
  param_00.cdamageaccumulationcleartimems = 750;
  var_01 = spawnStruct();
  var_01.cfastteleportmindisttoenemytoteleport = 200;
  var_01.cfastteleportcloseindistpctmin = 0.7;
  var_01.cfastteleportcloseindistpctmax = 0.8;
  var_01.cfastteleportminangledelta = 40;
  var_01.cfastteleportmaxangledelta = 45;
  param_00.fastteleportparams = var_01;
  var_02 = spawnStruct();
  var_02.cfastteleportmindisttoenemytoteleport = 200;
  var_02.cfastteleportcloseindistpctmin = 0.4;
  var_02.cfastteleportcloseindistpctmax = 0.6;
  var_02.cfastteleportminangledelta = 40;
  var_02.cfastteleportmaxangledelta = 45;
  param_00.bunchedupteleportparams = var_02;
  param_00.cplayerfacingawayfrommedot = 0.258;
  param_00.cminenemydistforlongpathteleport = 250;
  param_00.cfastteleportduetolongpathmultiplier = 4;
  param_00.cminteleportwaittimeaftermelee = 500;
  var_03 = spawnStruct();
  var_03.csprinterteleportminangledelta = 5;
  var_03.csprinterteleportmaxangledelta = 15;
  var_03.csprinterteleportmindist = 500;
  var_03.csprinterteleportmaxdist = 700;
  param_00.sprinterteleportparams = var_03;
  var_04 = spawnStruct();
  var_04.csprinterteleportminangledelta = 5;
  var_04.csprinterteleportmaxangledelta = 15;
  var_04.csprinterteleportmindist = 300;
  var_04.csprinterteleportmaxdist = 500;
  param_00.runnerteleportparams = var_04;
  param_00.ccrowdedcount = 2;
  param_00.ccrowdedradiussq = 5625;
  param_00.cmaxteleportsnappeddistsq = 64;
}

gettunedata() {
  return level.agenttunedata["karatemaster"];
}