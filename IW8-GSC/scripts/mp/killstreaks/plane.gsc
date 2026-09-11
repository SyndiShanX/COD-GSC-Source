/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\plane.gsc
***********************************************/

function init() {
  if(!isDefined(level.planes)) {
    level.planes = [];
  }

  if(!isDefined(level.planeconfigs)) {
    level.planeconfigs = [];
  }

  level.fighter_deathfx = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_afterburner = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_contrail = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_wingtip_light_green = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_wingtip_light_red = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

function getflightpath(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = var0 + var1 * -1 * var2;
  var9 = var0 + var1 * var2;

  if(var3) {
    var8 *= (1, 1, 0);
    var9 *= (1, 1, 0);
  }

  var8 += (0, 0, var4);
  var9 += (0, 0, var4);
  var10 = length(var8 - var9);
  var11 = var10 / var5;
  var10 = abs(0.5 * var10 + var6);
  var12 = var10 / var5;
  GscBinSkip1(0x45, "startPoint", var8);
}

function doflyby(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = planespawn(var0, var1, var3, var7, var8);
  var9 endon("death");
  var10 = 150;
  var11 = var4 + ((randomfloat(2) - 1) * var10, (randomfloat(2) - 1) * var10, 0);
  planemove(var9, var11, var6, var5, var8);
  planecleanup(var9);
}

function planespawn(var0, var1, var2, var3, var4) {
  if(!isDefined(var1)) {
    return;
  }

  var5 = 100;
  var6 = var2 + ((randomfloat(2) - 1) * var5, (randomfloat(2) - 1) * var5, 0);
  var7 = level.planeconfigs[var4];
  var8 = undefined;
  var8 = spawn("script_model", var6);
  var8.team = var1.team;
  var8.origin = var6;
  var8.angles = vectortoangles(var3);
  var8.lifeid = var0;
  var8.streakname = var4;
  var8.owner = var1;
  var8 setModel(var7.modelnames[var1.team]);

  if(isDefined(var7.compassiconfriendly)) {
    setobjectiveicons(var8, var7.compassiconfriendly, var7.compassiconenemy);
  }

  thread handledamage();
  thread handledeath();
  starttrackingplane(var8);

  if(!isDefined(var7.nolightfx)) {
    thread playplanefx();
  }

  var8 playLoopSound(var7.inboundsfx);
  createkillcam(var8, var4);
  return var8;
}

function planemove(var0, var1, var2, var3) {
  var4 = level.planeconfigs[var3];
  self moveTo(var0, var1, 0, 0);

  if(isDefined(var4.onattackdelegate)) {
    self thread[[var4.onattackdelegate]](var0, var1, var2, self.owner, var3);
  }

  if(isDefined(var4.sonicboomsfx)) {
    thread playsonicboom(var4.sonicboomsfx, 0.5 * var1);
  }

  wait 0.65 * var1;

  if(isDefined(var4.outboundsfx)) {
    self stoploopsound();
    self playLoopSound(var4.outboundsfx);
  }

  if(isDefined(var4.outboundflightanim)) {
    self scriptmodelplayanimdeltamotion(var4.outboundflightanim);
  }

  wait 0.35 * var1;
}

function planecleanup() {
  var0 = level.planeconfigs[self.streakname];

  if(isDefined(var0.onflybycompletedelegate)) {
    GscBinSkip1(0x74, var0.onflybycompletedelegate, self.owner, self, self.streakname);
  }

  if(isDefined(self.friendlyteamid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.friendlyteamid);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.enemyteamid);
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  stoptrackingplane(self);
  self notify("delete");
  self delete();
}

function handledeath() {
  level endon("game_ended");
  self endon("delete");
  self waittill("death");
  var0 = anglesToForward(self.angles) * 200;
  playFX(level.fighter_deathfx, self.origin, var0);
  thread planecleanup();
}

function handledamage() {
  self endon("end_remote");
  scripts\mp\damage::monitordamage(800, "helicopter", &handledeathdamage, &modifydamage, 1);
}

function modifydamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = var0.idflags;
  var6 = var4;
  var6 = scripts\mp\damage::handlemissiledamage(var2, var3, var6);
  var6 = scripts\mp\damage::handleapdamage(var2, var3, var6);
  return var6;
}

function handledeathdamage(var0) {
  var1 = var0.attacker;
  var2 = var0.objweapon;
  var3 = var0.meansofdeath;
  var4 = var0.damage;
  var5 = level.planeconfigs[self.streakname];
  scripts\mp\damage::onkillstreakkilled(self.streakname, var1, var2, var3, var4, var5.scorepopup, var5.destroyedvo, var5.callout);
}

function playplanefx() {
  self endon("death");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_wingtip_light_red, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_wingtip_light_green, self, "tag_left_wingtip");
}

function getplaneflyheight() {
  var0 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var0)) {
    return var0.origin[2];
  }

  var1 = 950;
  return var1;
}

function getplaneflightplan(var0) {
  var1 = spawnStruct();
  var1.height = getplaneflyheight();
  var2 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();

  if(isDefined(var2) && isDefined(var2.script_noteworthy) && var2.script_noteworthy == "fixedposition") {
    var1.targetpos = var2.origin;
    var1.flightdir = anglesToForward(var2.angles);

    if(randomint(2) == 0) {
      var1.flightdir *= -1;
    }
  } else {
    var3 = anglesToForward(self.angles);
    var4 = anglestoright(self.angles);
    var1.targetpos = self.origin + var0 * var3;
    var1.flightdir = -1 * var4;
  }

  return var1;
}

function getexplodedistance(var0) {
  var1 = 850;
  var2 = 1500;
  var3 = var1 / var0;
  var4 = var3 * var2;
  return var4;
}

function starttrackingplane(var0) {
  var1 = var0 getentitynumber();
  level.planes[var1] = var0;
}

function stoptrackingplane(var0) {
  var1 = var0 getentitynumber();
  level.planes[var1] = undefined;
}

function selectairstrikelocation(var0, var1, var2) {
  var3 = level.mapsize / 6.46875;

  if(level.splitscreen) {
    var3 *= 1.5;
  }

  var4 = level.planeconfigs[var1];

  if(isDefined(var4.selectlocationvo)) {
    self playlocalsound(game["voice"][self.team] + var4.selectlocationvo);
  }

  scripts\mp\utility\killstreak::_beginlocationselection(var1, "map_artillery_selector", var4.choosedirection, var3);
  self endon("stop_location_selection");
  self waittill("confirm_location", var5, var6);

  if(!var4.choosedirection) {
    var6 = randomint(360);
  }

  self setblurforplayer(0, 0.3);

  if(isDefined(var4.inboundvo)) {
    self playlocalsound(game["voice"][self.team] + var4.inboundvo);
  }

  self thread[[var2]](var0, var5, var6, var1);
  return true;
}

function setobjectiveicons(var0, var1) {
  var2 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var2 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var2, "active", (0, 0, 0), var0);
    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(var2, self);
  }

  self.friendlyteamid = var2;
  var3 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var3 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var3, "active", (0, 0, 0), var1);
    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(var3, self);
  }

  self.enemyteamid = var3;

  if(level.teambased) {
    if(var2 != -1) {
      scripts\mp\objidpoolmanager::objective_teammask_single(var2, self.team);
    }

    if(var3 != -1) {
      scripts\mp\objidpoolmanager::objective_teammask_single(var3, scripts\mp\utility\game::getotherteam(self.team)[0]);
      return;
    }

    return;
  }

  if(var2 != -1) {
    scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var2, self.owner);
  }

  if(var3 != -1) {
    scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(var3, self.owner);
    return;
  }
}

function playsonicboom(var0, var1) {
  self endon("death");
  wait var1;
  self playsoundonmovingent(var0);
}

function createkillcam(var0) {
  var1 = level.planeconfigs[var0];

  if(isDefined(var1.killcamoffset)) {
    var2 = anglesToForward(self.angles);
    var3 = spawn("script_model", self.origin + (0, 0, 100) - var2 * 200);
    var3.starttime = gettime();
    var3 setscriptmoverkillcam("airstrike");
    var3 linkTo(self, "tag_origin", var1.killcamoffset, (0, 0, 0));
    self.killcament = var3;
    return;
  }
}