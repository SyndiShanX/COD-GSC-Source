/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_skydive_protection.gsc
**********************************************************/

function init() {
  var0 = isDefined(level.modifyplayerdamage) && level.modifyplayerdamage == &scripts\mp\gametypes\br::brmodifyplayerdamage;

  if(var0) {
    level.modifyplayerdamage = &endmatchcamerastriggered;
    level.ref_133ef = getdvarint("scr_skydiveSpawnProtection", 1) == 1;
    level.ref_133f1 = getdvarfloat("scr_skydiveSpawnProtectionModifier", 0.1);
    level.ref_133ee = getdvarfloat("scr_skydiveSpawnLauncherDamage", 0.1);
    level.ref_133f5 = getdvarint("scr_skydiveSpawnProtectionScaleHeightTop", 2500);
    level.ref_133f4 = getdvarint("scr_skydiveSpawnProtectionScaleHeightBottom", 750);
    level.ref_133f3 = getdvarfloat("scr_skydiveSpawnProtectionModifierTop", 0.25);
    level.ref_133f2 = getdvarfloat("scr_skydiveSpawnProtectionModifierBottom", 0.25);
    level.›p &Üµ— Œ–;
    V
  }›
  Á° îæ8 'íG¬±–Þ¹ÍÂ™•G—‘-›°¹±V = getdvarfloat( "scr_skydiveSpawnProtectionSafetyDistance", 750 );
  return;
}
}

function toma_strike_munitionused(var0) {
  if(!istrue(level.ref_133ef)) {
    return;
  }

  thread endingpropspecate();
  thread ending_zplanes();
  thread ending_winning_players_setup();

  if(var0) {
    thread endingph();
    return;
  }

  self.ref_133f1 = level.ref_133f1;
}

function ending_zplanes() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_spawn_protection");
  self.ref_133ef = 1;

  for(var0 = brskydive_getdistancetoclosestgroundedplayer(); !self isonground() && brskydive_getdistanceoffground() >= level.ref_133f4 && (!isDefined(var0) || var0 >= level.›p &Üµ— Œ–; V
    }›
    Á° îæ8 'íG¬±–Þ¹ÍÂ™•G—‘-›°¹±V ) ; var0 = brskydive_getdistancetoclosestgroundedplayer() ) {
    waitframe();
  }

  self.ref_133ef = undefined;
  self notify("skydive_remove_spawn_protection");
}

function brskydive_getdistancetoclosestgroundedplayer() {
  var0 = getdvarint("scr_skydiveSpawnProtectionSafetyDistanceIgnoreAi", 0);
  var1 = undefined;

  foreach(var3 in level.players) {
    if(!isDefined(var3) || !isalive(var3)) {
      continue;
    }

    if(!isDefined(var3.team) || var3.team == self.team) {
      continue;
    }

    if(var0 && isai(var3)) {
      continue;
    }

    if(var3 isonground()) {
      var4 = abs(distance(self.origin, var3.origin));

      if(isDefined(var1)) {
        var1 = min(var4, var1);
      } else {
        var1 = var4;
      }
    }
  }

  return var1;
}

function ending_winning_players_setup() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_launcher_protection");
  self.ref_133ed = 1;

  while(!self isonground()) {
    waitframe();
  }

  self.ref_133ed = undefined;
  self notify("skydive_remove_launcher_protection");
}

function endingpropspecate() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_spawn_protection");
  self.ref_133ef = 1;
  self waittill("weapon_fired");
  self.ref_133ef = undefined;
  self notify("skydive_remove_spawn_protection");
}

function endingph() {
  self endon("death_or_disconnect");
  self endon("skydive_remove_spawn_protection");
  self.ref_133f0 = 1;
  self.ref_133f1 = 1;

  while(istrue(self.ref_133ef)) {
    var0 = brskydive_getdistanceoffground();
    var1 = level.ref_133f5 - level.ref_133f4;
    self.ref_133f0 = clamp(var0 / var1, 0, 1);
    var2 = level.ref_133f3 - level.ref_133f2;
    self.ref_133f1 = self.ref_133f0 * var2 + level.ref_133f2;
    waitframe();
  }

  self.ref_133f1 = undefined;
}

function brskydive_isbrgasdamage(var0) {
  return isDefined(var0) && scripts\mp\damage::trial_vehicle_outline_id(var0.basename);
}

function endmatchcamerastriggered(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(istrue(level.ref_133ef)) {
    if(istrue(var1.ref_133ef) && isDefined(self.ref_133f1) && !brskydive_isbrgasdamage(var5)) {
      var3 *= self.ref_133f1;
    }

    if(isDefined(var2) && istrue(var2.ref_133ed)) {
      switch (var4) {
        case "MOD_EXPLOSIVE":
        case "MOD_GRENADE_SPLASH":
        case "MOD_GRENADE":
        case "MOD_PROJECTILE_SPLASH":
          var3 *= level.ref_133ee;
          break;
      }
    }
  }

  var3 = scripts\mp\gametypes\br::brmodifyplayerdamage(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
  return var3;
}

function brskydive_getdistanceoffground() {
  var0 = scripts\mp\gametypes\br_public::modifyplayer_damage(self.origin, 0, -100000);
  var1 = self.origin[2] - var0[2];
  return var1;
}