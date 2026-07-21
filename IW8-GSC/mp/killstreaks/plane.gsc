/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\plane.gsc
***********************************************/

init() {
  if(!isDefined(level.planes))
    level.planes = [];

  if(!isDefined(level.planeconfigs))
    level.planeconfigs = [];

  level.fighter_deathfx = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  level.fx_airstrike_afterburner = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  level.fx_airstrike_contrail = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  level.fx_airstrike_wingtip_light_green = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
  level.fx_airstrike_wingtip_light_red = loadfx("_encstr_B6F42B9E9FCBAE0CD8C23829EBC1635B8797C0FF2802D7C77BD340067187115D803184BE9535896889EA9B0AC3");
}

getflightpath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_0 + var_1 * (-1 * var_2);
  var_9 = var_0 + var_1 * var_2;

  if(var_3) {
    var_8 = var_8 * (1, 1, 0);
    var_9 = var_9 * (1, 1, 0);
  }

  var_8 = var_8 + (0, 0, var_4);
  var_9 = var_9 + (0, 0, var_4);
  var_10 = length(var_8 - var_9);
  var_11 = var_10 / var_5;
  var_10 = abs(0.5 * var_10 + var_6);
  var_12 = var_10 / var_5;
  var_13["_encstr_B18C0B5E9C6FA319E20A487853"] = var_8;
  var_13["_encstr_ACB7092280809AF7F8F8DB"] = var_9;
  var_13["_encstr_8D490B85D11D1636B6A2B4DA59"] = var_12;
  var_13["_encstr_B602088CA52B1198DD3F"] = var_11;
  return var_13;
}

doflyby(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = planespawn(var_0, var_1, var_3, var_7, var_8);
  var_9 endon("_encstr_AD75063D571AE108");
  var_10 = 150;
  var_11 = var_4 + ((randomfloat(2) - 1) * var_10, (randomfloat(2) - 1) * var_10, 0);
  var_9 planemove(var_11, var_6, var_5, var_8);
  var_9 planecleanup();
}

planespawn(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1)) {
    return;
  }
  var_5 = 100;
  var_6 = var_2 + ((randomfloat(2) - 1) * var_5, (randomfloat(2) - 1) * var_5, 0);
  var_7 = level.planeconfigs[var_4];
  var_8 = undefined;
  var_8 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_6);
  var_8.team = var_1.team;
  var_8.origin = var_6;
  var_8.angles = vectortoangles(var_3);
  var_8.lifeid = var_0;
  var_8.streakname = var_4;
  var_8.owner = var_1;
  var_8 setModel(var_7.modelnames[var_1.team]);

  if(isDefined(var_7.compassiconfriendly))
    var_8 setobjectiveicons(var_7.compassiconfriendly, var_7.compassiconenemy);

  var_8 thread handledamage();
  var_8 thread handledeath();
  starttrackingplane(var_8);

  if(!isDefined(var_7.nolightfx))
    var_8 thread playplanefx();

  var_8 playLoopSound(var_7.inboundsfx);
  var_8 createkillcam(var_4);
  return var_8;
}

planemove(var_0, var_1, var_2, var_3) {
  var_4 = level.planeconfigs[var_3];
  self moveTo(var_0, var_1, 0, 0);

  if(isDefined(var_4.onattackdelegate))
    self thread[[var_4.onattackdelegate]](var_0, var_1, var_2, self.owner, var_3);

  if(isDefined(var_4.sonicboomsfx))
    thread playsonicboom(var_4.sonicboomsfx, 0.5 * var_1);

  wait(0.65 * var_1);

  if(isDefined(var_4.outboundsfx)) {
    self stoploopsound();
    self playLoopSound(var_4.outboundsfx);
  }

  if(isDefined(var_4.outboundflightanim))
    self scriptmodelplayanimdeltamotion(var_4.outboundflightanim);

  wait(0.35 * var_1);
}

planecleanup() {
  var_0 = level.planeconfigs[self.streakname];

  if(isDefined(var_0.onflybycompletedelegate))
    thread[[var_0.onflybycompletedelegate]](self.owner, self, self.streakname);

  if(isDefined(self.friendlyteamid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.friendlyteamid);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.enemyteamid);
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  stoptrackingplane(self);
  self notify("_encstr_A25F0710622DF3B3D7");
  self delete();
}

handledeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_A25F0710622DF3B3D7");
  self waittill("_encstr_AD75063D571AE108");
  var_0 = anglesToForward(self.angles) * 200;
  playFX(level.fighter_deathfx, self.origin, var_0);
  thread planecleanup();
}

handledamage() {
  self endon("_encstr_920E0BE7880931BA61B86733C0");
  scripts\mp\damage::monitordamage(800, "_encstr_8F010BD0591B4B36B7831D5693", ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = var_0.idflags;
  var_6 = var_4;
  var_6 = scripts\mp\damage::handlemissiledamage(var_2, var_3, var_6);
  var_6 = scripts\mp\damage::handleapdamage(var_2, var_3, var_6);
  return var_6;
}

handledeathdamage(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0.meansofdeath;
  var_4 = var_0.damage;
  var_5 = level.planeconfigs[self.streakname];
  scripts\mp\damage::onkillstreakkilled(self.streakname, var_1, var_2, var_3, var_4, var_5.scorepopup, var_5.destroyedvo, var_5.callout);
}

playplanefx() {
  self endon("_encstr_AD75063D571AE108");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "_encstr_A32511E37AF7C848C53F839525E1B8AB8F827B");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "_encstr_BE48103A2C3BFA95733B4BE62BD7B1CA333A");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "_encstr_8FEA127C88BF0F5051E7639CC1EFCA4AD098F4B8");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "_encstr_A19311CC0759CFB56390DB613053EDF7D3FB30");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_wingtip_light_red, self, "_encstr_8FEA127C88BF0F5051E7639CC1EFCA4AD098F4B8");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_wingtip_light_green, self, "_encstr_A19311CC0759CFB56390DB613053EDF7D3FB30");
}

getplaneflyheight() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var_0))
    return var_0.origin[2];
  else {
    var_1 = 950;
    return var_1;
  }
}

getplaneflightplan(var_0) {
  var_1 = spawnStruct();
  var_1.height = getplaneflyheight();
  var_2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var_2) && isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "_encstr_B45D0E06B3A03FFB57984B1203231F35") {
    var_1.targetpos = var_2.origin;
    var_1.flightdir = anglesToForward(var_2.angles);

    if(randomint(2) == 0)
      var_1.flightdir = var_1.flightdir * -1;
  } else {
    var_3 = anglesToForward(self.angles);
    var_4 = anglestoright(self.angles);
    var_1.targetpos = self.origin + var_0 * var_3;
    var_1.flightdir = -1 * var_4;
  }

  return var_1;
}

getexplodedistance(var_0) {
  var_1 = 850;
  var_2 = 1500;
  var_3 = var_1 / var_0;
  var_4 = var_3 * var_2;
  return var_4;
}

starttrackingplane(var_0) {
  var_1 = var_0 getentitynumber();
  level.planes[var_1] = var_0;
}

stoptrackingplane(var_0) {
  var_1 = var_0 getentitynumber();
  level.planes[var_1] = undefined;
}

selectairstrikelocation(var_0, var_1, var_2) {
  var_3 = level.mapsize / 6.46875;

  if(level.splitscreen)
    var_3 = var_3 * 1.5;

  var_4 = level.planeconfigs[var_1];

  if(isDefined(var_4.selectlocationvo))
    self playlocalsound(game["_encstr_8F8206ACFA5A81B5"][self.team] + var_4.selectlocationvo);

  scripts\mp\utility\killstreak::_beginlocationselection(var_1, "_encstr_867417B51B580967DE63623A88BDD378C9A7350CBB988B1786", var_4.choosedirection, var_3);
  self endon("_encstr_887F1837A3BDC1D763F636161DA5F6CDF5CDB2B1568DE8A5BD37");
  self waittill("_encstr_9179111BB7DC334BE4B5BE1BDB36853A5AB773", var_5, var_6);

  if(!var_4.choosedirection)
    var_6 = randomint(360);

  self setblurforplayer(0, 0.3);

  if(isDefined(var_4.inboundvo))
    self playlocalsound(game["_encstr_8F8206ACFA5A81B5"][self.team] + var_4.inboundvo);

  self thread[[var_2]](var_0, var_5, var_6, var_1);
  return 1;
}

setobjectiveicons(var_0, var_1) {
  var_2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_2 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_2, "_encstr_930B07BB1B6B3854FF", (0, 0, 0), var_0);
    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(var_2, self);
  }

  self.friendlyteamid = var_2;
  var_3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_3 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_3, "_encstr_930B07BB1B6B3854FF", (0, 0, 0), var_1);
    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(var_3, self);
  }

  self.enemyteamid = var_3;

  if(level.teambased) {
    if(var_2 != -1)
      scripts\mp\objidpoolmanager::objective_teammask_single(var_2, self.team);

    if(var_3 != -1)
      scripts\mp\objidpoolmanager::objective_teammask_single(var_3, scripts\mp\utility\game::getotherteam(self.team)[0]);
  } else {
    if(var_2 != -1)
      scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var_2, self.owner);

    if(var_3 != -1)
      scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var_3, self.owner);
  }
}

playsonicboom(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_1);
  self playsoundonmovingent(var_0);
}

createkillcam(var_0) {
  var_1 = level.planeconfigs[var_0];

  if(isDefined(var_1.killcamoffset)) {
    var_2 = anglesToForward(self.angles);
    var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin + (0, 0, 100) - var_2 * 200);
    var_3.starttime = gettime();
    var_3 setscriptmoverkillcam("_encstr_84D20A3A60CDFAF353A37B6D");
    var_3 linkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_1.killcamoffset, (0, 0, 0));
    self.killcament = var_3;
  }
}