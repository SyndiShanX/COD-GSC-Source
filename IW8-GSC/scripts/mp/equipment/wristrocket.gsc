/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\wristrocket.gsc
************************************************/

function wristrocketinit() {
  level._effect["wristrocket_explode"] = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_exp.vfx");
  level._effect["wristrocket_thruster"] = loadfx("vfx/iw7/_requests/mp/power/vfx_wrist_rocket_thruster");
}

function wristrocket_set() {
  thread wristrocket_watcheffects();
}

function wristrocket_unset() {
  self notify("wristRocket_unset");
}

function wristrocketused(var_0) {
  if(var_0.tickpercent == 1) {
    return;
  }

  var_1 = wristrocket_createrocket(var_0);
  var_1.grenade = var_0;
  var_0 = scripts\mp\utility\weapon::_launchgrenade("pop_rocket_mp", self.origin, (0, 0, 0), 100, 1, var_0);
  var_0 forcehidegrenadehudwarning(1);
  var_0 linkTo(var_1);
  thread wristrocket_cleanuponparentdeath(var_0);
  thread wristrocket_cleanuponownerdisconnect(var_0);
  var_1 setscriptablepartstate("launch", "active", 0);
  thread wristrocket_watchfuse(var_1);
  thread wristrocket_watchstuck();
}

function wristrocket_watchfuse(var_0) {
  self endon("death");
  self.owner endon("disconnect");
  self notify("wristRocket_watchFuse");
  self endon("wristRocket_watchFuse");
  wait var_0;
  thread wristrocket_explode();
}

function wristrocket_watchstuck() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("missile_stuck", var_0);

  if(isPlayer(var_0)) {
    self.owner scripts\mp\weapons::grenadestuckto(self, var_0);
  }

  self stoploopsound();
  self setscriptablepartstate("stuck", "active", 0);
  self setscriptablepartstate("beacon", "active", 0);
  self.grenade forcehidegrenadehudwarning(0);
  thread wristrocket_watchfuse(1.35);
}

function wristrocket_explode() {
  self setscriptablepartstate("stuck", "neutral", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);
  thread wristrocket_delete();
}

function wristrocket_delete() {
  self notify("death");
  self.exploding = 1;
  wait 0.1;
  self delete();
}

function wristrocket_createrocket(var_0) {
  var_1 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("pop_rocket_proj_mp"), var_0.origin, var_0.origin + anglesToForward(self getgunangles()), self);
  var_1.owner = self;
  var_1.team = self.team;
  var_1.weapon_name = "pop_rocket_proj_mp";
  var_1.power = "power_wristrocket";
  var_1 setotherent(self);
  var_1 setentityowner(self);
  thread wristrocket_cleanuponownerdisconnect(var_1);
  return var_1;
}

function wristrocket_watcheffects() {
  self endon("disconnect");
  self notify("wristRocket_watchEffects");
  self endon("wristRocket_watchEffects");
  var_0 = 0;
  var_1 = spawnStruct();

  if(var_0) {
    GscBinSkip4(0x35, var_1);
  }

  GscBinSkip4(0x35, var_1);
}

function wristrocket_watcheffectsracegrenadepullback(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");

  for(;;) {
    self waittill("grenade_pullback", var_1);

    if(var_1.basename == "pop_rocket_mp") {
      break;
    }
  }

  var_0.grenadepullback = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsracegrenadefired(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");

  for(;;) {
    self waittill("grenade_fire", var_1, var_2);

    if(var_2.basename == "pop_rocket_mp") {
      break;
    }
  }

  var_0.grenadefire = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsracesuperstarted(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("super_started");
  var_0.superstarted = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsracedeath(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("death");
  var_0.death = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsraceunset(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("wristRocket_unset");
  var_0.unset = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsraceheldoffhandbreak(var_0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  waitframe();
  var_1 = getcompleteweaponname("pop_rocket_mp");

  while(self getheldoffhand() == var_1) {
    waitframe();
  }

  var_0.heldoffhandbreak = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_begineffects() {
  self notify("wristRocket_beginEffects");
  self endon("wristRocket_beginEffects");
  self endon("wristRocket_endEffects");
  self setscriptablepartstate("wristRocketWorld", "neutral", 0);
  wait 0.15;
  self setscriptablepartstate("wristRocketWorld", "active", 0);
}

function wristrocket_endeffects() {
  self notify("wristRocket_endEffects");
  self setscriptablepartstate("wristRocketWorld", "neutral", 0);
}

function wristrocketcooksuicideexplodecheck(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 != var_2) {
    return;
  }

  if(var_3 != "MOD_SUICIDE") {
    return;
  }

  if(!isDefined(var_0) || var_0 != var_1) {
    return;
  }

  if(!isDefined(var_4) || var_4.basename != "pop_rocket_mp") {
    return;
  }

  var_5 = var_2 gettagorigin("tag_weapon_left");
  radiusdamage(var_5, 175, 200, 70, var_1, "MOD_EXPLOSIVE", "pop_rocket_mp");
  scripts\mp\shellshock::grenade_earthquakeatposition(var_5, 0.6);
  playFX(scripts\engine\utility::getfx("wristrocket_explode"), var_5);
}

function wristrocket_cleanuponparentdeath(var_0, var_1) {
  self endon("death");
  self notify("cleanupOnParentDeath");
  self endon("cleanupOnParentDeath");

  if(isDefined(var_0)) {
    var_0 waittill("death");
  }

  if(isDefined(var_1)) {
    wait var_1;
  }

  self delete();
}

function wristrocket_cleanuponownerdisconnect(var_0) {
  self endon("death");
  var_0 waittill("disconnect");

  if(isDefined(self)) {
    self delete();
    return;
  }
}