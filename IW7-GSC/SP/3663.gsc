/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3663.gsc
**************************************/

_id_9755(var_0) {
  if(!level.player scripts\sp\utility::_id_65DF("pressurized"))
    level.player scripts\sp\utility::_id_65E0("pressurized");

  if(!level.player scripts\sp\utility::_id_65DF("player_gravity_off"))
    level.player scripts\sp\utility::_id_65E0("player_gravity_off");

  if(!level.player scripts\sp\utility::_id_65DF("player_space_override_off"))
    level.player scripts\sp\utility::_id_65E0("player_space_override_off");

  if(!isDefined(var_0) || !var_0) {
    setsaveddvar("player_spaceViewHeight", 60);
    setsaveddvar("player_spaceCapsuleHeight", 70);
  }

  if(!isDefined(level.player.space))
    level.player.space = spawnStruct();

  level.player.space._id_6F43 = 0;
}

_id_9756() {
  _id_0E4A::_id_84BB();
}

_id_5570(var_0) {
  _id_9755(1);

  if(var_0 == 1)
    level.player scripts\sp\utility::_id_65E1("player_space_override_off");
  else
    level.player scripts\sp\utility::_id_65DD("player_space_override_off");
}

_id_9C7B() {
  _id_9755(1);

  if(level.player scripts\sp\utility::_id_65DB("player_space_override_off"))
    return 0;

  if(!level.player scripts\sp\utility::_id_65DB("player_gravity_off"))
    return 0;

  return 1;
}

_id_622C(var_0, var_1) {
  _id_9755();

  if(level.player scripts\sp\utility::_id_65DB("player_space_override_off")) {
    return;
  }
  level.player.space._id_6F43 = 1;
  level.player scripts\sp\utility::_id_65E1("player_gravity_off");
  level._id_7684 = _id_0E50::pain;

  if(!isDefined(var_0) || var_0)
    level.player thread _id_0E47::_id_4D8A();

  if(!isDefined(var_1) || var_1)
    level.player thread _id_0E4A::_id_84BA();

  level.player thread _id_0E50::_id_CF84();
  level.player thread _id_853A();
}

_id_556F() {
  level.player scripts\sp\utility::_id_65DD("player_gravity_off");
}

_id_40A6() {
  level notify("disable_space");
  level.player notify("disable_space");
  level.player _id_552C();
  level._id_7684 = undefined;
}

_id_6251() {
  setsaveddvar("bg_viewBobAmplitudeDucked", 0.0);
  setsaveddvar("bg_viewBobAmplitudeDuckedAds", 0.0);
  setsaveddvar("bg_viewBobAmplitudeSprinting", 0.0);
  setsaveddvar("bg_viewBobAmplitudeStanding", 0.0);
  setsaveddvar("bg_viewBobAmplitudeStandingAds", 0.0);
  setsaveddvar("bg_viewBobMax", 0);
  setsaveddvar("bg_weaponBobAmplitudeBase", 0.0);
  setsaveddvar("bg_weaponBobAmplitudeDucked", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeSprinting", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeStanding", "0.0 0.0");
  setsaveddvar("bg_sprintLoopTimeScale", 4);
  self _meth_82B5(5);
}

_id_559D() {
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
  self _meth_82B5(1);
}

_id_621C(var_0) {
  setsaveddvar("cg_footsteps", 0);
  setsaveddvar("cg_equipmentSounds", 0);
  setsaveddvar("cg_landingSounds", 0);
  setsaveddvar("player_spaceEnabled", "1");
  level.player scripts\engine\utility::allow_doublejump(0);
  level._id_104DA = 500;
  level._id_104D9 = 500;
  level._id_1050D = 125;
  level._id_1050E = 125;
  level._id_104AE = 750;
  level._id_104AF = 750;
  level._id_10514 = 500;
  level._id_10515 = 125;
  level._id_10516 = 125;
  level._id_10513 = 750;
  level._id_10510 = 1.6;
  setsaveddvar("player_swimFriction", level._id_104DA);
  setsaveddvar("player_swimAcceleration", level._id_104AE);
  setsaveddvar("player_swimVerticalFriction", level._id_10514);
  setsaveddvar("player_swimVerticalSpeed", level._id_10515);
  setsaveddvar("player_swimVerticalAcceleration", level._id_10513);
  setsaveddvar("player_swimSpeed", level._id_1050D);
  setsaveddvar("player_sprintSpeedScale", level._id_10510);
  self allowlean(0);
  self allowswim(1);
  self setviewkickscale(0.6);
  thread _id_8B3A();
  thread _id_93E9();
  thread _id_13E97();
}

_id_5558() {
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
  self allowswim(0);
  scripts\engine\utility::allow_doublejump(1);

  if(isDefined(self._id_286F))
    self.attackeraccuracy = self._id_286F;

  if(isDefined(self._id_13E97))
    self._id_13E97 delete();
}

_id_853A() {
  self.space._id_6F43 = 0;
  self.space._id_6F43 = 1;
  _id_61FA();

  while(_id_9C7B())
    wait 0.05;

  _id_40A6();

  if(isDefined(level.player._id_9BF5)) {
    while(level.player._id_9BF5 == 1)
      scripts\engine\utility::waitframe();
  }

  if(isDefined(self._id_849A))
    level.player thread _id_0E4A::_id_84B9();
}

_id_61FA() {
  self _meth_80D8(0.8, 0.8);
  _id_6251();
  _id_621C();
  _id_0E50::_id_6247();
}

_id_552C() {
  self _meth_80A6();
  _id_559D();
  _id_5558();
  _id_0E50::_id_5593();
}

_id_37FE() {
  if(self isonground())
    return 1;

  return 0;
}

_id_9399() {
  return level.player scripts\sp\utility::_id_65DB("in_gravity");
}

_id_8B3A() {
  self endon("death");
  self endon("disable_space");
  self._id_286F = self.attackeraccuracy;

  for(;;) {
    var_0 = getdvarfloat("player_sprintSpeedScale", 1.4);
    var_1 = getdvarfloat("player_swimSpeed", level._id_1050D);
    var_2 = length(self getvelocity());
    self.attackeraccuracy = self._id_286F;

    if(var_2 >= var_1 * 0.99) {
      self.attackeraccuracy = 0.4 * self._id_286F;

      if(var_2 >= var_1 * var_0)
        self.attackeraccuracy = 0.15 * self._id_286F;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_93E9() {
  self endon("death");
  self endon("disable_space");

  for(;;) {
    var_0 = level.player.origin + (0, 0, 25);
    var_1 = !scripts\common\trace::sphere_trace_passed(level.player.origin, level.player.origin, 60, level.player);

    if(var_1) {
      thread scripts\sp\utility::_id_AB9A("player_swimFriction", level._id_104D9, 0.1);
      thread scripts\sp\utility::_id_AB9A("player_swimSpeed", level._id_1050D, 1);
      thread scripts\sp\utility::_id_AB9A("player_swimAcceleration", level._id_104AE, 0.1);
      thread scripts\sp\utility::_id_AB9A("player_swimVerticalSpeed", level._id_10515, 0.1);
    } else {
      thread scripts\sp\utility::_id_AB9A("player_swimFriction", level._id_104DA, 0.1);
      thread scripts\sp\utility::_id_AB9A("player_swimSpeed", level._id_1050E, 1);
      thread scripts\sp\utility::_id_AB9A("player_swimAcceleration", level._id_104AF, 0.1);
      thread scripts\sp\utility::_id_AB9A("player_swimVerticalSpeed", level._id_10516, 0.1);
    }

    wait 0.25;
  }
}

#using_animtree("generic_human");

_id_13E97() {
  self endon("disable_space");

  if(!isDefined(level._id_EC8C["player_body"])) {
    return;
  }
  self._id_13E97 = scripts\sp\player_rig::_id_7B88();
  self._id_13E97 _meth_81E4(self, "tag_origin", (-12, 0, -58), (-4, 0, 0), 1, 0, 0, 0);

  for(;;) {
    var_0 = self getnormalizedmovement();
    var_1 = 0.75;
    var_2 = 0.5;

    if(var_0[0] >= 0) {
      var_3 = var_0[0];
      var_3 = var_3 * var_3;
      self._id_13E97 clearanim(%space_playerbody_idle_b, var_1);
      self._id_13E97 _meth_82A2(%space_playerbody_idle_f, var_3, var_1);
      self._id_13E97 _meth_82A2(%space_playerbody_idle, 1 - var_3, var_1);
    } else {
      var_3 = abs(var_0[0]);
      var_3 = var_3 * var_3;
      var_4 = _id_EBAB();
      var_5 = max(var_2, var_4);
      var_3 = var_4 * var_3;
      self._id_13E97 clearanim(%space_playerbody_idle_f, var_1 * var_5);
      self._id_13E97 _meth_82A2(%space_playerbody_idle_b, var_3, var_1 * var_5);
      self._id_13E97 _meth_82A2(%space_playerbody_idle, 1 - var_3, var_1 * var_5);
    }

    if(var_0[1] >= 0) {
      var_3 = var_0[1];
      var_3 = var_3 * var_3;
      var_4 = _id_EBAB();
      var_5 = max(var_2, var_4);
      var_3 = var_4 * var_3;
      self._id_13E97 clearanim(%space_playerbody_idle_r, var_1 * var_5);
      self._id_13E97 _meth_82A2(%space_playerbody_idle_l, var_3, var_1 * var_5);
    } else {
      var_3 = abs(var_0[1]);
      var_3 = var_3 * var_3;
      var_4 = _id_EBAB();
      var_5 = max(var_2, var_4);
      var_3 = var_4 * var_3;
      self._id_13E97 clearanim(%space_playerbody_idle_l, var_1 * var_5);
      self._id_13E97 _meth_82A2(%space_playerbody_idle_r, var_3, var_1 * var_5);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_EBAB(var_0) {
  var_1 = self getplayerangles();
  var_2 = var_1[0];

  if(var_2 > 0) {
    if(!isDefined(var_0))
      var_0 = 75.0;

    var_3 = 1 - min(var_0, var_2) / var_0;
    return max(var_3, 0.1);
  }

  return 1;
}