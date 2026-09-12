/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_skydive_protection.gsc
**********************************************************/

function init() {
  var_0 = isDefined(level.modifyplayerdamage) && level.modifyplayerdamage == &scripts\mp\gametypes\br::brmodifyplayerdamage;

  if(var_0) {
    level.modifyplayerdamage = &endmatchcamerastriggered;
    level.ref_133EF = getdvarint("scr_skydiveSpawnProtection", 1) == 1;
    level.ref_133F1 = getdvarfloat("scr_skydiveSpawnProtectionModifier", 0.1);
    level.ref_133EE = getdvarfloat("scr_skydiveSpawnLauncherDamage", 0.1);
    level.ref_133F5 = getdvarint("scr_skydiveSpawnProtectionScaleHeightTop", 2500);
    level.ref_133F4 = getdvarint("scr_skydiveSpawnProtectionScaleHeightBottom", 750);
    level.ref_133F3 = getdvarfloat("scr_skydiveSpawnProtectionModifierTop", 0.25);
    level.ref_133F2 = getdvarfloat("scr_skydiveSpawnProtectionModifierBottom", 0.25);
    level.skydive_spawnprotectionsafetydistance = getdvarfloat("scr_skydiveSpawnProtectionSafetyDistance", 750);
    return;
  }
}

function toma_strike_munitionused(var_0) {
  if(!istrue(level.ref_133EF)) {
    return;
  }

  thread endingpropspecate();
  thread ending_zplanes();
  thread ending_winning_players_setup();

  if(var_0) {
    thread endingph();
    return;
  }

  self.ref_133F1 = level.ref_133F1;
}

function ending_zplanes() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_spawn_protection");
  self.ref_133EF = 1;

  for(var_0 = brskydive_getdistancetoclosestgroundedplayer(); !self isonground() && brskydive_getdistanceoffground() >= level.ref_133F4 && (!isDefined(var_0) || var_0 >= level.skydive_spawnprotectionsafetydistance); var_0 = brskydive_getdistancetoclosestgroundedplayer()) {
    waitframe();
  }

  self.ref_133EF = undefined;
  self notify("skydive_remove_spawn_protection");
}

function brskydive_getdistancetoclosestgroundedplayer() {
  var_0 = getdvarint("scr_skydiveSpawnProtectionSafetyDistanceIgnoreAi", 0);
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(!isDefined(var_3) || !isalive(var_3)) {
      continue;
    }

    if(!isDefined(var_3.team) || var_3.team == self.team) {
      continue;
    }

    if(var_0 && isai(var_3)) {
      continue;
    }

    if(var_3 isonground()) {
      var_4 = abs(distance(self.origin, var_3.origin));

      if(isDefined(var_1)) {
        var_1 = min(var_4, var_1);
      } else {
        var_1 = var_4;
      }
    }
  }

  return var_1;
}

function ending_winning_players_setup() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_launcher_protection");
  self.ref_133ED = 1;

  while(!self isonground()) {
    waitframe();
  }

  self.ref_133ED = undefined;
  self notify("skydive_remove_launcher_protection");
}

function endingpropspecate() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_spawn_protection");
  self.ref_133EF = 1;
  self waittill("weapon_fired");
  self.ref_133EF = undefined;
  self notify("skydive_remove_spawn_protection");
}

function endingph() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_spawn_protection");
  self.ref_133F0 = 1;
  self.ref_133F1 = 1;

  while(istrue(self.ref_133EF)) {
    var_0 = brskydive_getdistanceoffground();
    var_1 = level.ref_133F5 - level.ref_133F4;
    self.ref_133F0 = clamp(var_0 / var_1, 0, 1);
    var_2 = level.ref_133F3 - level.ref_133F2;
    self.ref_133F1 = self.ref_133F0 * var_2 + level.ref_133F2;
    waitframe();
  }

  self.ref_133F1 = undefined;
}

function brskydive_isbrgasdamage(var_0) {
  return isDefined(var_0) && scripts\mp\damage::trial_vehicle_outline_id(var_0.basename);
}

function endmatchcamerastriggered(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(istrue(level.ref_133EF)) {
    if(istrue(var_1.ref_133EF) && isDefined(self.ref_133F1) && !brskydive_isbrgasdamage(var_5)) {
      var_3 *= self.ref_133F1;
    }

    if(isDefined(var_2) && istrue(var_2.ref_133ED)) {
      switch (var_4) {
        case "MOD_EXPLOSIVE":
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
        case "MOD_PROJECTILE_SPLASH":
          var_3 *= level.ref_133EE;
          break;
      }
    }
  }

  var_3 = scripts\mp\gametypes\br::brmodifyplayerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  return var_3;
}

function brskydive_getdistanceoffground() {
  var_0 = scripts\mp\gametypes\br_public::modifyplayer_damage(self.origin, 0, -100000);
  var_1 = self.origin[2] - var_0[2];
  return var_1;
}