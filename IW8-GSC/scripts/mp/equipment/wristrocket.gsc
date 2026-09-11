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

function wristrocketused(var0) {
  if(var0.tickpercent == 1) {
    return;
  }

  var1 = wristrocket_createrocket(var0);
  var1.grenade = var0;
  var0 = scripts\mp\utility\weapon::_launchgrenade("pop_rocket_mp", self.origin, (0, 0, 0), 100, 1, var0);
  var0 forcehidegrenadehudwarning(1);
  var0 linkTo(var1);
  thread wristrocket_cleanuponparentdeath(var0);
  thread wristrocket_cleanuponownerdisconnect(var0);
  var1 setscriptablepartstate("launch", "active", 0);
  thread wristrocket_watchfuse(var1);
  thread wristrocket_watchstuck();
}

function wristrocket_watchfuse(var0) {
  self endon("death");
  self.owner endon("disconnect");
  self notify("wristRocket_watchFuse");
  self endon("wristRocket_watchFuse");
  wait var0;
  thread wristrocket_explode();
}

function wristrocket_watchstuck() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("missile_stuck", var0);

  if(isPlayer(var0)) {
    self.owner scripts\mp\weapons::grenadestuckto(self, var0);
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

function wristrocket_createrocket(var0) {
  var1 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("pop_rocket_proj_mp"), var0.origin, var0.origin + anglesToForward(self getgunangles()), self);
  var1.owner = self;
  var1.team = self.team;
  var1.weapon_name = "pop_rocket_proj_mp";
  var1.power = "power_wristrocket";
  var1 setotherent(self);
  var1 setentityowner(self);
  thread wristrocket_cleanuponownerdisconnect(var1);
  return var1;
}

function wristrocket_watcheffects() {
  self endon("disconnect");
  self notify("wristRocket_watchEffects");
  self endon("wristRocket_watchEffects");
  var0 = 0;
  var1 = spawnStruct();

  if(var0) {
    GscBinSkip4(0x35, var1);
  }

  GscBinSkip4(0x35, var1);
}

function wristrocket_watcheffectsracegrenadepullback(var0) {
  self endon("wristRocket_watchEffectsRaceEnd");

  for(;;) {
    self waittill("grenade_pullback", var1);

    if(var1.basename == "pop_rocket_mp") {
      break;
    }
  }

  var0.grenadepullback = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsracegrenadefired(var0) {
  self endon("wristRocket_watchEffectsRaceEnd");

  for(;;) {
    self waittill("grenade_fire", var1, var2);

    if(var2.basename == "pop_rocket_mp") {
      break;
    }
  }

  var0.grenadefire = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsracesuperstarted(var0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("super_started");
  var0.superstarted = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsracedeath(var0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("death");
  var0.death = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsraceunset(var0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  self waittill("wristRocket_unset");
  var0.unset = 1;
  self notify("wristRocket_watchEffectsRaceStart");
}

function wristrocket_watcheffectsraceheldoffhandbreak(var0) {
  self endon("wristRocket_watchEffectsRaceEnd");
  waitframe();
  var1 = getcompleteweaponname("pop_rocket_mp");

  while(self getheldoffhand() == var1) {
    waitframe();
  }

  var0.heldoffhandbreak = 1;
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

function wristrocketcooksuicideexplodecheck(var0, var1, var2, var3, var4) {
  if(var1 != var2) {
    return;
  }

  if(var3 != "MOD_SUICIDE") {
    return;
  }

  if(!isDefined(var0) || var0 != var1) {
    return;
  }

  if(!isDefined(var4) || var4.basename != "pop_rocket_mp") {
    return;
  }

  var5 = var2 gettagorigin("tag_weapon_left");
  radiusdamage(var5, 175, 200, 70, var1, "MOD_EXPLOSIVE", "pop_rocket_mp");
  scripts\mp\shellshock::grenade_earthquakeatposition(var5, 0.6);
  playFX(scripts\engine\utility::getfx("wristrocket_explode"), var5);
}

function wristrocket_cleanuponparentdeath(var0, var1) {
  self endon("death");
  self notify("cleanupOnParentDeath");
  self endon("cleanupOnParentDeath");

  if(isDefined(var0)) {
    var0 waittill("death");
  }

  if(isDefined(var1)) {
    wait var1;
  }

  self delete();
}

function wristrocket_cleanuponownerdisconnect(var0) {
  self endon("death");
  var0 waittill("disconnect");

  if(isDefined(self)) {
    self delete();
    return;
  }
}