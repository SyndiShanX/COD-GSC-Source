/********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\agents\karatemaster\karatemaster_tunedata.gsc
********************************************************************/

setuptunedata() {
  if(!isDefined(level.agenttunedata)) {
    level.agenttunedata = [];
  }

  level.agenttunedata["karatemaster"] = spawnStruct();
  setupkaratemastertunedata(level.agenttunedata["karatemaster"]);
}

setupkaratemastertunedata(var_0) {
  var_0.cteleportthisclosetoplayer = 60;
  var_0.cmeleemaxstanddistsq = 4096;
  var_0.cmeleemaxzdiff = 60;
  var_0.cteleportmindist = 400;
  var_0.cteleportmintimebetween = 1000;
  var_0.cteleportmintimebetween_global = 1000;
  var_0.cwiggleroom = 30;
  var_0.cstandattackwiggleroom = 30;
  var_0.crethinkmovemeleetime = 3000;
  var_0.cpunchmeleedamage = 45;
  var_0.ckickmeleedamage = 55;
  var_0.cpunchandkickmeleeradiussq = 1600;
  var_0.cmaxmeleeflexscale = 5;
  var_0.ballowteleportinfrontofsprinter = 1;
  var_0.cfastteleportduetodamagechance = 100;
  var_0.cfastteleportdamagepct = 0.001;
  var_0.cdamageaccumulationcleartimems = 750;
  var_1 = spawnStruct();
  var_1.cfastteleportmindisttoenemytoteleport = 200;
  var_1.cfastteleportcloseindistpctmin = 0.7;
  var_1.cfastteleportcloseindistpctmax = 0.8;
  var_1.cfastteleportminangledelta = 40;
  var_1.cfastteleportmaxangledelta = 45;
  var_0.fastteleportparams = var_1;
  var_2 = spawnStruct();
  var_2.cfastteleportmindisttoenemytoteleport = 200;
  var_2.cfastteleportcloseindistpctmin = 0.4;
  var_2.cfastteleportcloseindistpctmax = 0.6;
  var_2.cfastteleportminangledelta = 40;
  var_2.cfastteleportmaxangledelta = 45;
  var_0.bunchedupteleportparams = var_2;
  var_0.cplayerfacingawayfrommedot = 0.258;
  var_0.cminenemydistforlongpathteleport = 250;
  var_0.cfastteleportduetolongpathmultiplier = 4;
  var_0.cminteleportwaittimeaftermelee = 500;
  var_3 = spawnStruct();
  var_3.csprinterteleportminangledelta = 5;
  var_3.csprinterteleportmaxangledelta = 15;
  var_3.csprinterteleportmindist = 500;
  var_3.csprinterteleportmaxdist = 700;
  var_0.sprinterteleportparams = var_3;
  var_4 = spawnStruct();
  var_4.csprinterteleportminangledelta = 5;
  var_4.csprinterteleportmaxangledelta = 15;
  var_4.csprinterteleportmindist = 300;
  var_4.csprinterteleportmaxdist = 500;
  var_0.runnerteleportparams = var_4;
  var_0.ccrowdedcount = 2;
  var_0.ccrowdedradiussq = 5625;
  var_0.cmaxteleportsnappeddistsq = 64;
}

gettunedata() {
  return level.agenttunedata["karatemaster"];
}