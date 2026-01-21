/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3663.gsc
*********************************************/

func_9755(var_0) {
  if(!level.player scripts\sp\utility::func_65DF("pressurized")) {
    level.player scripts\sp\utility::func_65E0("pressurized");
  }

  if(!level.player scripts\sp\utility::func_65DF("player_gravity_off")) {
    level.player scripts\sp\utility::func_65E0("player_gravity_off");
  }

  if(!level.player scripts\sp\utility::func_65DF("player_space_override_off")) {
    level.player scripts\sp\utility::func_65E0("player_space_override_off");
  }

  if(!isDefined(var_0) || !var_0) {
    setsaveddvar("player_spaceViewHeight", 60);
    setsaveddvar("player_spaceCapsuleHeight", 70);
  }

  if(!isDefined(level.player.isent)) {
    level.player.isent = spawnStruct();
  }

  level.player.isent.var_6F43 = 0;
}

func_9756() {
  lib_0E4A::func_84BB();
}

func_5570(var_0) {
  func_9755(1);
  if(var_0 == 1) {
    level.player scripts\sp\utility::func_65E1("player_space_override_off");
    return;
  }

  level.player scripts\sp\utility::func_65DD("player_space_override_off");
}

func_9C7B() {
  func_9755(1);
  if(level.player scripts\sp\utility::func_65DB("player_space_override_off")) {
    return 0;
  }

  if(!level.player scripts\sp\utility::func_65DB("player_gravity_off")) {
    return 0;
  }

  return 1;
}

func_622C(var_0, var_1) {
  func_9755();
  if(level.player scripts\sp\utility::func_65DB("player_space_override_off")) {
    return;
  }

  level.player.isent.var_6F43 = 1;
  level.player scripts\sp\utility::func_65E1("player_gravity_off");
  level.var_7684 = lib_0E50::unloadalltransients;
  if(!isDefined(var_0) || var_0) {
    level.player thread lib_0E47::func_4D8A();
  }

  if(!isDefined(var_1) || var_1) {
    level.player thread lib_0E4A::func_84BA();
  }

  level.player thread lib_0E50::func_CF84();
  level.player thread func_853A();
}

func_556F() {
  level.player scripts\sp\utility::func_65DD("player_gravity_off");
}

func_40A6() {
  level notify("disable_space");
  level.player notify("disable_space");
  level.player func_552C();
  level.var_7684 = undefined;
}

func_6251() {
  setsaveddvar("bg_viewBobAmplitudeDucked", 0);
  setsaveddvar("bg_viewBobAmplitudeDuckedAds", 0);
  setsaveddvar("bg_viewBobAmplitudeSprinting", 0);
  setsaveddvar("bg_viewBobAmplitudeStanding", 0);
  setsaveddvar("bg_viewBobAmplitudeStandingAds", 0);
  setsaveddvar("bg_viewBobMax", 0);
  setsaveddvar("bg_weaponBobAmplitudeBase", 0);
  setsaveddvar("bg_weaponBobAmplitudeDucked", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeSprinting", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeStanding", "0.0 0.0");
  setsaveddvar("bg_sprintLoopTimeScale", 4);
  self give_crafted_fireworks_trap(5);
}

func_559D() {
  setsaveddvar("bg_viewBobAmplitudeDucked", 0.0075);
  setsaveddvar("bg_viewBobAmplitudeDuckedAds", 0.0075);
  setsaveddvar("bg_viewBobAmplitudeSprinting", 0.014);
  setsaveddvar("bg_viewBobAmplitudeStanding", 0.007);
  setsaveddvar("bg_viewBobAmplitudeStandingAds", 0.0075);
  setsaveddvar("bg_viewBobMax", 8);
  setsaveddvar("bg_weaponBobAmplitudeBase", 0.16);
  setsaveddvar("bg_weaponBobAmplitudeDucked", "0.045 0.025");
  setsaveddvar("bg_weaponBobAmplitudeSprinting", "0.02 0.014");
  setsaveddvar("bg_weaponBobAmplitudeStanding", "0.055 0.025");
  setsaveddvar("bg_sprintLoopTimeScale", 1);
  self give_crafted_fireworks_trap(1);
}

func_621C(var_0) {
  setsaveddvar("cg_footsteps", 0);
  setsaveddvar("cg_equipmentSounds", 0);
  setsaveddvar("cg_landingSounds", 0);
  setsaveddvar("player_spaceEnabled", "1");
  level.player scripts\engine\utility::allow_doublejump(0);
  level.var_104DA = 500;
  level.var_104D9 = 500;
  level.var_1050D = 125;
  level.var_1050E = 125;
  level.var_104AE = 750;
  level.var_104AF = 750;
  level.var_10514 = 500;
  level.var_10515 = 125;
  level.var_10516 = 125;
  level.var_10513 = 750;
  level.var_10510 = 1.6;
  setsaveddvar("player_swimFriction", level.var_104DA);
  setsaveddvar("player_swimAcceleration", level.var_104AE);
  setsaveddvar("player_swimVerticalFriction", level.var_10514);
  setsaveddvar("player_swimVerticalSpeed", level.var_10515);
  setsaveddvar("player_swimVerticalAcceleration", level.var_10513);
  setsaveddvar("player_swimSpeed", level.var_1050D);
  setsaveddvar("player_sprintSpeedScale", level.var_10510);
  self allowlean(0);
  self func_8014(1);
  self setviewkickscale(0.6);
  thread func_8B3A();
  thread func_93E9();
  thread func_13E97();
}

func_5558() {
  level notify("disable_space");
  self notify("disable_space");
  setsaveddvar("cg_footsteps", 1);
  setsaveddvar("cg_equipmentSounds", 1);
  setsaveddvar("cg_landingSounds", 1);
  setsaveddvar("player_spaceEnabled", "0");
  setsaveddvar("player_sprintSpeedScale", 1.4);
  setsaveddvar("player_swimFriction", 30);
  setsaveddvar("player_swimAcceleration", 100);
  setsaveddvar("player_swimVerticalFriction", 40);
  setsaveddvar("player_swimVerticalSpeed", 120);
  setsaveddvar("player_swimVerticalAcceleration", 160);
  setsaveddvar("player_swimSpeed", 80);
  setsaveddvar("player_sprintUnlimited", "1");
  setsaveddvar("player_swimWaterCurrent", (0, 0, 0));
  self allowlean(1);
  self func_8014(0);
  scripts\engine\utility::allow_doublejump(1);
  if(isDefined(self.var_286F)) {
    self.var_50 = self.var_286F;
  }

  if(isDefined(self.var_13E97)) {
    self.var_13E97 delete();
  }
}

func_853A() {
  self.isent.var_6F43 = 0;
  self.isent.var_6F43 = 1;
  func_61FA();
  while(func_9C7B()) {
    wait(0.05);
  }

  func_40A6();
  if(isDefined(level.player.var_9BF5)) {
    while(level.player.var_9BF5 == 1) {
      scripts\engine\utility::waitframe();
    }
  }

  if(isDefined(self.func_849A)) {
    level.player thread lib_0E4A::func_84B9();
  }
}

func_61FA() {
  self getrawbaseweaponname(0.8, 0.8);
  func_6251();
  func_621C();
  lib_0E50::func_6247();
}

func_552C() {
  self func_80A6();
  func_559D();
  func_5558();
  lib_0E50::func_5593();
}

func_37FE() {
  if(self isonground()) {
    return 1;
  }

  return 0;
}

func_9399() {
  return level.player scripts\sp\utility::func_65DB("in_gravity");
}

func_8B3A() {
  self endon("death");
  self endon("disable_space");
  self.var_286F = self.var_50;
  for(;;) {
    var_0 = getdvarfloat("player_sprintSpeedScale", 1.4);
    var_1 = getdvarfloat("player_swimSpeed", level.var_1050D);
    var_2 = length(self getvelocity());
    self.var_50 = self.var_286F;
    if(var_2 >= var_1 * 0.99) {
      self.var_50 = 0.4 * self.var_286F;
      if(var_2 >= var_1 * var_0) {
        self.var_50 = 0.15 * self.var_286F;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_93E9() {
  self endon("death");
  self endon("disable_space");
  for(;;) {
    var_0 = level.player.origin + (0, 0, 25);
    var_1 = !scripts\common\trace::sphere_trace_passed(level.player.origin, level.player.origin, 60, level.player);
    if(var_1) {
      thread scripts\sp\utility::func_AB9A("player_swimFriction", level.var_104D9, 0.1);
      thread scripts\sp\utility::func_AB9A("player_swimSpeed", level.var_1050D, 1);
      thread scripts\sp\utility::func_AB9A("player_swimAcceleration", level.var_104AE, 0.1);
      thread scripts\sp\utility::func_AB9A("player_swimVerticalSpeed", level.var_10515, 0.1);
    } else {
      thread scripts\sp\utility::func_AB9A("player_swimFriction", level.var_104DA, 0.1);
      thread scripts\sp\utility::func_AB9A("player_swimSpeed", level.var_1050E, 1);
      thread scripts\sp\utility::func_AB9A("player_swimAcceleration", level.var_104AF, 0.1);
      thread scripts\sp\utility::func_AB9A("player_swimVerticalSpeed", level.var_10516, 0.1);
    }

    wait(0.25);
  }
}

func_13E97() {
  self endon("disable_space");
  if(!isDefined(level.var_EC8C["player_body"])) {
    return;
  }

  self.var_13E97 = scripts\sp\player_rig::func_7B88();
  self.var_13E97 func_81E4(self, "tag_origin", (-12, 0, -58), (-4, 0, 0), 1, 0, 0, 0);
  for(;;) {
    var_0 = self getnormalizedmovement();
    var_1 = 0.75;
    var_2 = 0.5;
    if(var_0[0] >= 0) {
      var_3 = var_0[0];
      var_3 = var_3 * var_3;
      self.var_13E97 clearanim(%space_playerbody_idle_b, var_1);
      self.var_13E97 give_attacker_kill_rewards(%space_playerbody_idle_f, var_3, var_1);
      self.var_13E97 give_attacker_kill_rewards(%space_playerbody_idle, 1 - var_3, var_1);
    } else {
      var_3 = abs(var_0[0]);
      var_3 = var_3 * var_3;
      var_4 = func_EBAB();
      var_5 = max(var_2, var_4);
      var_3 = var_4 * var_3;
      self.var_13E97 clearanim(%space_playerbody_idle_f, var_1 * var_5);
      self.var_13E97 give_attacker_kill_rewards(%space_playerbody_idle_b, var_3, var_1 * var_5);
      self.var_13E97 give_attacker_kill_rewards(%space_playerbody_idle, 1 - var_3, var_1 * var_5);
    }

    if(var_0[1] >= 0) {
      var_3 = var_0[1];
      var_3 = var_3 * var_3;
      var_4 = func_EBAB();
      var_5 = max(var_2, var_4);
      var_3 = var_4 * var_3;
      self.var_13E97 clearanim(%space_playerbody_idle_r, var_1 * var_5);
      self.var_13E97 give_attacker_kill_rewards(%space_playerbody_idle_l, var_3, var_1 * var_5);
    } else {
      var_3 = abs(var_0[1]);
      var_3 = var_3 * var_3;
      var_4 = func_EBAB();
      var_5 = max(var_2, var_4);
      var_3 = var_4 * var_3;
      self.var_13E97 clearanim(%space_playerbody_idle_l, var_1 * var_5);
      self.var_13E97 give_attacker_kill_rewards(%space_playerbody_idle_r, var_3, var_1 * var_5);
    }

    scripts\engine\utility::waitframe();
  }
}

func_EBAB(var_0) {
  var_1 = self getplayerangles();
  var_2 = var_1[0];
  if(var_2 > 0) {
    if(!isDefined(var_0)) {
      var_0 = 75;
    }

    var_3 = 1 - min(var_0, var_2) / var_0;
    return max(var_3, 0.1);
  }

  return 1;
}