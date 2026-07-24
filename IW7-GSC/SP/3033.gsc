/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3033.gsc
**************************************/

_id_622B() {
  _id_968C();
  thread _id_0BDC::_id_1985();
  thread _id_0C20::_id_7598();
  thread _id_0C1A::_id_25C5();
  thread _id_0C18::_id_1EDC();
  thread _id_0C24::_id_10A49();
  thread _id_1049A();
  thread _id_104A1();
  thread _id_A628();
  _id_DEDD();
  self._id_D161 = 1;
  self _meth_8455(self.origin, 1);
}

_id_556E() {
  thread _id_10493();
  _id_0BDC::_id_104A6(0);
  self._id_D161 = undefined;
}

_id_DEDD() {
  level._id_A056._id_12F96 = scripts\engine\utility::array_add(level._id_A056._id_12F96, self);
}

_id_D161(var_0) {
  level._id_D127 = self;
  level.player scripts\sp\utility::_id_65E1("jackal_enemy_homing_missile_allowed");
  level._id_A056._id_432C = [];
  _id_D17F();
  thread _id_D133();
  thread _id_0BDC::_id_10749();
  thread _id_104A9();
  thread _id_0BD5::_id_D139();
  thread _id_0BDD::_id_D1A2();
  thread _id_0BDB::_id_D18D();
  thread _id_D175(var_0);
  thread _id_D18C();
  thread _id_D18B();
  thread _id_D174();
  thread _id_D128();
  thread _id_D19E();
  thread _id_D19A();
  thread _id_D199();
  thread _id_D14F();
  thread _id_D19B();
  thread _id_D14C();
  thread _id_DBA4();
  thread _id_D189();
  level.player thread _id_D148();
  thread _id_0BD1::_id_686A();
  _id_F381();
  thread _id_F5F7();
  _id_A318(level._id_A056._id_9B6F);

  if(getdvarint("jackalHandbrakeMode"))
    thread _id_D15A();
  else
    thread _id_D185();

  level.player scripts\sp\utility::_id_65E1("flag_player_has_jackal");
  level.player thread _id_58B4();
}

_id_F5F7() {
  _id_0BDC::_id_137DA();
  _id_0BDC::_id_12DCD(_id_0A2F::_id_DA02());
}

_id_11ABD() {
  for(;;)
    wait 0.1;
}

_id_A323() {
  _id_F384();

  foreach(var_1 in level._id_A056._id_12F96)
  var_1 _meth_84A1("jackal_un_landing");
}

_id_A318(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  level._id_A056._id_9B6F = var_0;

  if(!var_0)
    setomnvar("ui_jackal_show_horizon", 0);
  else
    setomnvar("ui_jackal_show_horizon", 1);

  if(scripts\sp\utility::_id_D123())
    level._id_D127 _id_A31B();

  _id_F383();
}

_id_A31B() {
  var_0 = _id_A1E7();
  self _meth_84A1(var_0);
}

_id_A1E7() {
  var_0 = _id_A1E6();
  var_1 = level.vehicle._id_116CE._id_2427[level._id_D127.classname][var_0];

  if(!isDefined(level._id_D127))
    return var_1;

  if(isDefined(level._id_D127._id_5F0D) && level._id_D127._id_5F0D)
    var_2 = "_dualfire";
  else
    var_2 = "";

  if(scripts\sp\utility::_id_D15B("thrusters"))
    var_3 = "_thrustperk";
  else
    var_3 = "";

  var_4 = var_1 + var_3 + var_2;
  return var_4;
}

_id_A1E6() {
  if(level._id_A056._id_9B6F)
    var_0 = "atmo";
  else
    var_0 = "space";

  return var_0;
}

_id_F381() {
  setsaveddvar("spaceshipLockOnMaxAngleOverride", -1);
  setsaveddvar("spaceshipHoldTurnSpeedScale", 1);
  setsaveddvar("trackTrajectory1", 0.1);
  setsaveddvar("trackTrajectory2", 0.2);
  setsaveddvar("trackTrajectory3", 0.4);
  setsaveddvar("trackTrajectory4", 0.7);
  setsaveddvar("trackTrajectory5", 0.95);
  setsaveddvar("spaceshipRollOnRightStick", 0);
  setsaveddvar("spaceshipHoverToFlyPhysicsBlendTime", 2.5);
  setsaveddvar("spaceshipAllowBoostInHoverMode", 1);
  setsaveddvar("spaceshipmodeswitchcommand", 3);
  setsaveddvar("spaceshipBoostStopAngle", 45);
  setsaveddvar("spaceshipHandBrakeFrictionHover", 0);
  setsaveddvar("spaceshipHandBrakeFrictionFly", 400);
  setsaveddvar("spaceshipAim", 1);
  level._id_A056._id_4FEB["spaceshipSpringCameraMaxAngle"] = 25;
  level._id_A056._id_4FEB["spaceshipSpringCameraSpringStrength"] = 5;
  level._id_A056._id_4FEB["spaceshipSpringCameraSpringStrengthOut"] = 5;
  setsaveddvar("spaceshipSpringCameraMaxAngle", level._id_A056._id_4FEB["spaceshipSpringCameraMaxAngle"]);
  setsaveddvar("spaceshipSpringCameraSpringStrength", level._id_A056._id_4FEB["spaceshipSpringCameraSpringStrength"]);
  setsaveddvar("spaceshipSpringCameraSpringStrengthOut", level._id_A056._id_4FEB["spaceshipSpringCameraSpringStrengthOut"]);
  setsaveddvar("spaceshipUseCodeCameraShakes", 0);
  setsaveddvar("spaceshipAnalogPhysics", 1);
  setsaveddvar("spaceshipAutoFlyForward", 0);
  setsaveddvar("spaceshipBankRollFlyParams", (50, 3, 0.4));
  setsaveddvar("spaceshipBankRollFlySlowParams", (50, 3, 0.4));
  setsaveddvar("spaceshipBankRollHoverParams", (25, 3, 0.4));
  setsaveddvar("spaceshipHoverRollWhileTurningScale", 0);
  setsaveddvar("spaceshipFlyRollWhileTurningScale", 0);
  setsaveddvar("spaceshipHeadTranslationOffsets", (5, 5, 2));
  setsaveddvar("spaceshipHeadTranslationSpringIn", "4.5 0.4");
  setsaveddvar("spaceshipHeadTranslationSpringOut", "5.0 0.4");
  setsaveddvar("spaceshipHeadTranslationLinearContribution", 1.0);
  setsaveddvar("spaceshipHeadTranslationAngularContribution", 0.5);
}

_id_F384() {
  setsaveddvar("spaceshipcollisionEventThreshold", 0);
  setsaveddvar("spaceshipcollisionflymaxviewkickangle", 40);
  setsaveddvar("spaceshipcollisionflyminspeedtokickviewMPH", 0);
  setsaveddvar("spaceshipcollisionminnormalVelocityMPH", 10);
  setsaveddvar("spaceshipcollisionminspeedtoReboundMPH", 0);
  setsaveddvar("spaceshipCollisionRestitutionNormal", 1.0);
  setsaveddvar("spaceshipcollisionrotatetimems", 1100);
  setsaveddvar("spaceshipCollisionRestitutionInPlane", 1.0);
  setsaveddvar("spaceshiproll", 2);
  setsaveddvar("spaceshipModulateRedirectWithDesires", 0);
  setsaveddvar("spaceshipAutoLevelDelayTime", 0);
}

_id_F383() {
  setsaveddvar("spaceshipAutoLevelDelayTime", 1.2);
  setsaveddvar("spaceshipcollisionEventThreshold", level._id_A056._id_105E7);
  setsaveddvar("spaceshipcollisionflymaxviewkickangle", 40);
  setsaveddvar("spaceshipcollisionflyminspeedtokickviewMPH", 50);
  setsaveddvar("spaceshipcollisionminnormalVelocityMPH", 30);
  setsaveddvar("spaceshipcollisionminspeedtoReboundMPH", 20);
  setsaveddvar("spaceshipCollisionRestitutionNormal", 0.2);
  setsaveddvar("spaceshipcollisionrotatetimems", 1000);
  setsaveddvar("spaceshipCollisionRestitutionInPlane", 0.9);
  _id_F380();
}

_id_F380() {
  var_0 = (1, 3, 0.4);

  if(level._id_A056._id_9B6F) {
    setsaveddvar("spaceshipMinPhysicsBlendSpeed", 100.0);
    setsaveddvar("spaceshipMaxPhysicsBlendSpeed", 600.0);
    setsaveddvar("spaceshipScaleHoverPitchClampForce", 1.0);
    setsaveddvar("spaceshipScaleFlyPitchClampForce", 0.0);

    if(level.player scripts\sp\utility::_id_65DB("disable_jackal_roll")) {
      setsaveddvar("spaceshipAutoLevelHoverParams", var_0);
      setsaveddvar("spaceshipAutoLevelFlyParams", var_0);
    } else {
      setsaveddvar("spaceshipAutoLevelHoverParams", (1, 3, 0.4));
      setsaveddvar("spaceshipAutoLevelFlyParams", (1, 3, 0.4));
    }

    setsaveddvar("spaceshipflyRedirectStrafeScale", 0.6);
    setsaveddvar("spaceshipHoverRedirectStrafeScale", 0.6);
    setsaveddvar("spaceshipModulateRedirectWithDesires", 0);
  } else {
    setsaveddvar("spaceshipMinPhysicsBlendSpeed", 67.0);
    setsaveddvar("spaceshipMaxPhysicsBlendSpeed", 400.0);
    setsaveddvar("spaceshipScaleHoverPitchClampForce", 0.0);
    setsaveddvar("spaceshipScaleFlyPitchClampForce", 0.0);

    if(level.player scripts\sp\utility::_id_65DB("disable_jackal_roll")) {
      setsaveddvar("spaceshipAutoLevelHoverParams", var_0);
      setsaveddvar("spaceshipAutoLevelFlyParams", var_0);
    } else {
      setsaveddvar("spaceshipAutoLevelFlyParams", (0.3, 0.7, 0.4));
      setsaveddvar("spaceshipAutoLevelHoverParams", (2, 1, 1));
    }

    setsaveddvar("spaceshipflyRedirectStrafeScale", 1.0);
    setsaveddvar("spaceshipHoverRedirectStrafeScale", 1.0);
    setsaveddvar("spaceshipModulateRedirectWithDesires", 1);
  }

  if(isDefined(level._id_D127) && level._id_D127.spaceship_mode == "hover")
    _id_A1D8("hover");
  else
    _id_A1D8("fly");

  if(isDefined(level._id_A056._id_BBB9)) {
    level._id_A056._id_BBB9["speed"]._id_90F9 = getdvarfloat("spaceshipMinPhysicsBlendSpeed");
    level._id_A056._id_BBB9["speed"]._id_90F8 = getdvarfloat("spaceshipMaxPhysicsBlendSpeed");
  }
}

_id_D185() {
  self endon("player_exit_jackal");
  var_0 = self.spaceship_mode;
  var_1 = 0.3;
  var_2 = 0.0;
  setdvarifuninitialized("spacehship_mode_swich_speed", 275);
  setdvarifuninitialized("spacehship_mode_swich_speed_space", 113);

  for(;;) {
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;
    var_6 = self.spaceship_mode;

    if(level._id_241D)
      var_7 = getdvarint("spacehship_mode_swich_speed");
    else
      var_7 = getdvarint("spacehship_mode_swich_speed_space");

    var_7 = var_7 * level._id_A056._id_EBAD;
    var_8 = rotatevectorinverted(self.spaceship_vel, self.angles);
    var_9 = var_8[0];

    if(!level.player scripts\sp\utility::_id_65DB("jackal_force_mode")) {
      if(!self.spaceship_boosting) {
        if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_mode_switch")) {
          if(var_6 == "hover") {
            if(var_9 > var_7 && var_2 == 0)
              var_3 = 1;

            if(var_0 != var_6 && !var_3)
              var_4 = 1;
          } else {
            if(var_9 < var_7 && var_2 == 0)
              var_4 = 1;

            if(var_0 != var_6 && !var_4)
              var_3 = 1;
          }
        }
      } else {
        var_3 = 1;
        var_4 = 0;
      }
    } else if(self._id_72A8 == "fly" && var_6 != self._id_72A8)
      var_3 = 1;
    else if(self._id_72A8 == "hover" && var_6 != self._id_72A8)
      var_4 = 1;
    else if(self._id_72A8 == "land" && var_6 != self._id_72A8)
      var_5 = 1;

    var_2 = var_2 - 0.05;

    if(var_2 < 0)
      var_2 = 0;

    if(var_3) {
      self _meth_8491("fly");
      var_0 = "fly";
      var_2 = var_1;
      _id_A1D8("fly");
    }

    if(var_4) {
      self _meth_8491("hover");
      var_0 = "hover";
      var_2 = var_1;
      _id_A1D8("hover");
    }

    if(var_5) {
      self _meth_8491("land");
      var_0 = "land";
      var_2 = var_1;
    }

    wait 0.05;
  }
}

_id_A1D8(var_0) {
  if(level.player scripts\sp\utility::_id_65DB("disable_jackal_roll")) {
    setsaveddvar("spaceshipAutoLevelDelayTime", 0);
    setsaveddvar("spaceshiproll", 2);
  } else if(var_0 == "fly") {
    setsaveddvar("spaceshipAutoLevelDelayTime", 1.2);
    setsaveddvar("spaceshiproll", 7);
  } else if(level._id_A056._id_9B6F) {
    setsaveddvar("spaceshipAutoLevelDelayTime", 0);
    setsaveddvar("spaceshiproll", 2);
  } else {
    setsaveddvar("spaceshipAutoLevelDelayTime", 1.2);
    setsaveddvar("spaceshiproll", 7);
  }
}

_id_D15A() {
  _id_0BDC::_id_137DB();
  level.player _meth_8490("disable_mode_switching", 1);
  _id_1023D();
  _id_0BDC::_id_137DB();
  self endon("player_exit_jackal");
  var_0 = self.spaceship_mode;

  for(;;) {
    if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_mode_switch") && !level.player scripts\sp\utility::_id_65DB("jackal_force_mode")) {
      if(!level.player buttonPressed("button_ltrig")) {
        if(var_0 != "fly") {
          self notify("switchmode");
          thread _id_1023A();
          thread _id_0BDC::_id_DBA5(1, 1);
          var_0 = "fly";
          level._id_D127 _meth_8491("fly");

          if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_pilot_assist"))
            level.player _meth_8490("disable_pilot_aim_assist", 0);
        }
      } else if(var_0 != "hover") {
        thread _id_0BDC::_id_DBA5(0, 1);
        thread _id_10239();
        var_0 = "hover";
        level._id_D127 _meth_8491("hover");
        level.player _meth_8490("disable_pilot_aim_assist", 1);
      }
    }

    wait 0.05;
  }
}

_id_D12A() {
  self endon("player_exit_jackal");
  _id_0BDC::_id_A0BE(1);
  wait 1;
  _id_0BDC::_id_A0BE(0);
}

_id_D14F() {
  self endon("player_exit_jackal");
  self._id_6E9C = spawnStruct();
  self._id_6E9C._id_B417 = 3;
  self._id_6E9C.count = self._id_6E9C._id_B417;
  self._id_6E9C._id_12B86 = [];
  self._id_6E9C._id_B88A = 0;
  self._id_6E9C._id_A989 = -999999;
  _id_0BDC::_id_137DB();
  thread _id_B8A7();

  for(;;) {
    while(!level.player secondaryoffhandbuttonPressed() || level.player scripts\sp\utility::_id_65DB("disable_jackal_guns") || level.player scripts\sp\utility::_id_65DB("disable_jackal_flares"))
      wait 0.05;

    if(self._id_6E9C.count == self._id_6E9C._id_B417) {
      _id_D183();
      wait 0.3;
      thread _id_D177();
    } else
      _id_D150();

    while(level.player secondaryoffhandbuttonPressed())
      wait 0.05;
  }
}

_id_D150() {
  level._id_D127 playSound("jackal_flare_empty_plr");
  level.player playRumbleOnEntity("damage_light");
  wait 0.1;
}

_id_D183() {
  self endon("player_exit_jackal");
  self endon("stop_shooting_flares");
  self._id_6E9C._id_A989 = gettime();
  var_0 = self._id_6E9C._id_B88A;

  while(self._id_6E9C.count > 0) {
    thread _id_D182(var_0);
    self._id_6E9C.count--;
    wait 0.3;
  }

  self notify("stop_shooting_flares");
}

_id_D177() {
  self endon("player_exit_jackal");
  var_0 = self._id_6E9C._id_B417 - self._id_6E9C.count;
  _id_D152(var_0);
  _id_D151();
  self._id_6E9C.count = self._id_6E9C._id_B417;
}

_id_D152(var_0) {
  for(var_1 = 0; var_1 < var_0; var_1++) {
    level._id_D127 playSound("jackal_flares_depleted");
    setomnvar("ui_jackal_flares_recharging", 1);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_jackal_flares_recharging", 0);
    wait 0.7;
  }
}

_id_D151() {
  level._id_D127 playSound("jackal_flares_ready");
  setomnvar("ui_jackal_flares_ready", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_jackal_flares_ready", 0);
}

_id_D182(var_0) {
  earthquake(0.25, 0.9, level._id_D127.origin, 10000);
  level.player playRumbleOnEntity("damage_heavy");
  level._id_D127 playSound("jackal_flare_deploy_plr");
  thread _id_D181(var_0, -1);
  thread _id_D181(var_0, 1);
}

_id_106FA(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1 _id_0BDC::_id_F2FF();
  var_1._id_1A89 = 1;
  var_1.active = 1;
  var_1.fx = scripts\engine\utility::getfx("jackal_flare_decoy_plr");
  var_1 thread _id_6E91();
  var_1 playLoopSound("jackal_flare_solo_npc");
  var_1 thread _id_0BDC::_id_6E8C(self);
  var_2 = self gettagorigin("j_mainroot_ship");
  var_3 = self gettagangles("j_mainroot_ship");
  var_4 = (150, 150 * var_0, -200);
  var_5 = anglesToForward(var_3);
  var_6 = anglestoright(var_3);
  var_7 = anglestoup(var_3);
  var_1.origin = var_2 + var_5 * var_4[0] + var_6 * var_4[1] + var_7 * var_4[2];
  var_5 = var_1.origin - var_2;
  var_1.angles = axistoangles(var_5, var_6, var_7);
  self._id_6E9C._id_12B86 = scripts\engine\utility::array_add(self._id_6E9C._id_12B86, var_1);
  var_1._id_AEBD = var_4;
  return var_1;
}

_id_6E91() {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(self.fx, self, "tag_origin");
}

_id_D181(var_0, var_1) {
  var_2 = 1.7;
  var_3 = var_2;
  var_4 = _id_106FA(var_1);
  var_4 endon("death");
  var_5 = var_4.origin;
  var_4 endon("death");
  var_6 = (0, 0, 0);

  if(isDefined(level._id_D127._id_6E97))
    var_7 = level._id_D127._id_6E97;
  else
    var_7 = 1;

  if(isDefined(level._id_D127._id_6E93))
    var_8 = level._id_D127._id_6E93 * var_7;
  else
    var_8 = var_7;

  var_9 = randomfloatrange(0.85, 1.15);
  var_10 = randomfloatrange(0.85, 1.15);
  var_11 = randomfloatrange(0.85, 1.15);

  if(var_0)
    var_12 = (550 * var_9 * var_7, 85 * var_1 * var_10 * var_8, 130 * var_11 * var_7);
  else
    var_12 = (400 * var_9 * var_7, 120 * var_1 * var_10 * var_8, 150 * var_11 * var_7);

  var_13 = 1;
  var_14 = 0;
  var_15 = -5 * var_7;
  var_16 = -50 * var_7;
  var_17 = [self, var_4];
  var_18 = [];

  for(;;) {
    level.player waittill("on_player_update");
    var_19 = self.origin;
    var_20 = self.angles;
    var_21 = anglesToForward(self.angles);
    var_22 = anglestoup(self.angles);
    var_23 = anglestoright(self.angles);
    var_14 = var_14 + var_15;
    clamp(var_14, var_16, 0);
    var_24 = (0, 0, var_14);
    var_25 = rotatevectorinverted(var_24, self.angles);
    var_4._id_AEBD = var_4._id_AEBD + (var_12 + var_25);
    var_26 = var_19 + var_21 * var_4._id_AEBD[0] + var_23 * var_4._id_AEBD[1] + var_22 * var_4._id_AEBD[2];
    var_27 = var_4.origin - self.spaceship_vel;
    var_28 = self.spaceship_rotvel * 0.05;
    var_29 = rotatevectorinverted(var_4.origin - self.origin, self.angles);
    var_30 = rotatevector(var_29, var_28);
    var_31 = var_30 - var_29;
    var_32 = rotatevector(var_31, self.angles);
    var_27 = var_27 - var_32;
    var_27 = var_27 + var_24;
    var_33 = scripts\sp\math::_id_C097(0, var_2, var_3);
    var_33 = scripts\sp\math::_id_C09A(var_33);
    var_33 = scripts\sp\math::_id_6A8E(0.1, 1, var_33);
    var_34 = scripts\sp\math::_id_6A8E(var_27, var_26, var_33);

    if(isDefined(level._id_D127._id_6E8A) && level._id_D127._id_6E8A)
      var_18["fraction"] = 1;
    else
      var_18 = scripts\common\trace::ray_trace(var_4.origin, var_34, var_17, undefined, 1);

    if(var_18["fraction"] < 1) {
      if(isDefined(var_18["normal"]))
        var_35 = vectortoangles(var_18["normal"]);
      else
        var_35 = var_4.angles;

      var_36 = var_18["position"];
      var_4.origin = var_36;
      var_4 _id_0BDC::_id_413B();
      stopFXOnTag(var_4.fx, var_4, "tag_origin");
      playFX(scripts\engine\utility::getfx("jackal_flare_impact_plr"), var_36, anglesToForward(var_35), anglestoup(var_35));
      playworldsound("jackal_flare_impact_plr", var_36);

      for(var_37 = 0; var_37 < 0.5; var_37 = var_37 + 0.05) {
        var_4 notify("pos_updated");
        wait 0.05;
      }

      var_4 notify("burnt_out");
      return;
    }

    var_5 = var_4.origin;
    var_4.origin = var_34;
    var_38 = vectorNormalize(var_4.origin - var_5);
    var_39 = anglestoright(var_4.angles);
    var_40 = anglestoup(var_4.angles);
    var_4.angles = axistoangles(var_38, var_39, var_40);
    var_3 = var_3 - 0.05;
    var_4 notify("pos_updated");

    if(var_3 <= 0) {
      if(var_13 > 0) {
        var_13--;
        playFXOnTag(scripts\engine\utility::getfx("jackal_flare_fizzle_plr"), var_4, "tag_origin");
        continue;
      }

      break;
    }
  }

  var_4 notify("burnt_out");
}

_id_13984() {
  self endon("player_exit_jackal");
  self endon("stop_shooting_flares");

  while(level.player secondaryoffhandbuttonPressed())
    wait 0.05;

  self notify("stop_shooting_flares");
}

_id_B8A7() {
  self endon("player_exit_jackal");
  self._id_93D2 = [];
  self._id_93D1 = 0;

  for(;;) {
    self waittill("homing_missile_incoming", var_0);
    self._id_93D2 = scripts\engine\utility::array_add(self._id_93D2, var_0);
    thread _id_0B76::_id_B840();

    if(!self._id_93D1)
      thread _id_B8A6();

    self._id_6E9C._id_12B86 = scripts\engine\utility::array_removeundefined(self._id_6E9C._id_12B86);
  }
}

_id_B8A5() {
  self notify("new_flare_hint");
  self endon("new_flare_hint");

  if(scripts\engine\utility::flag("jackal_lose_lock_hint")) {
    scripts\engine\utility::flag_clear("jackal_lose_lock_hint");
    wait 0.1;
  }

  while(scripts\engine\utility::flag("jackal_noflare_hint"))
    wait 0.05;

  scripts\engine\utility::flag_set("jackal_flare_hint");
  scripts\sp\utility::_id_56BA("jackal_flare_hint");

  while(self._id_6E9C._id_12B86.size == 0 && self._id_93D2.size > 0)
    wait 0.05;

  scripts\engine\utility::flag_clear("jackal_flare_hint");
}

_id_B8A6() {
  _id_B809();
  thread _id_B8A5();

  for(;;) {
    self._id_93D2 = scripts\engine\utility::array_removeundefined(self._id_93D2);

    if(self._id_93D2.size == 0) {
      break;
    }

    wait 0.05;
  }

  self notify("new_flare_hint");

  if(scripts\engine\utility::flag("jackal_flare_hint"))
    scripts\engine\utility::flag_clear("jackal_flare_hint");

  _id_B808();
}

_id_B809() {
  _id_0BDC::_id_A112("jackal_hud_incomingmissile", 0.5, 10);
  self._id_93D1 = 1;

  if(!isDefined(level._id_B8B8))
    level._id_B8B8 = thread scripts\engine\utility::play_loopsound_in_space("jackal_missile_incoming", (0, 0, 0));

  setomnvar("ui_jackal_missile_incoming", 1);
  _id_0BDC::_id_A10C("incoming_missile");
}

_id_B808() {
  self._id_93D1 = 0;

  if(isDefined(level._id_B8B8)) {
    level._id_B8B8 stoploopsound("jackal_missile_incoming");
    level._id_B8B8 delete();
  }

  setomnvar("ui_jackal_missile_incoming", 0);
  _id_0BDC::_id_A10A();
}

_id_D14C() {
  self endon("player_exit_jackal");
  level._id_A056._id_67D9 = 0;
  var_0 = (0, 0, 0);
  var_1 = (0, 0, 0);
  var_2 = 0.5;
  var_3 = 1.0;
  var_4 = 0.8;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0.35;
  var_9 = 0.05;
  var_10 = 0.35;
  var_11 = 0.035;
  var_12 = 0.35;
  var_13 = 0.03;
  var_14 = (0, 0, 0);
  var_15 = 0.012;
  var_16 = 0.35;
  var_17 = 0.04;
  var_18 = 0;
  var_19 = 1;
  var_20 = 0.075;
  var_21 = 0.065;

  while(!isDefined(level._id_A056._id_BBB9["speed"]._id_6FE8))
    wait 0.05;

  for(;;) {
    waittillframeend;
    var_22 = self.spaceship_rotvel;
    var_23 = self.spaceship_vel;
    var_24 = length(var_23);

    if(length(var_22) > length(var_0))
      var_25 = 1;
    else
      var_25 = 0.3;

    var_14 = scripts\sp\math::_id_AB6F(var_14, var_22, var_15);

    if(self.spaceship_mode == "fly") {
      var_26 = length(var_14 - var_22);
      var_26 = scripts\sp\math::_id_C097(10, 80, var_26);
      var_26 = var_26 * var_4 * var_25;
    } else
      var_26 = 0;

    if(var_26 > var_5)
      var_27 = var_8;
    else
      var_27 = var_9;

    var_5 = scripts\sp\math::_id_AB6F(var_5, var_26, var_27);
    var_28 = anglesToForward(level._id_D127.angles);
    var_29 = vectorNormalize(var_23);
    var_30 = 1 - scripts\sp\math::_id_C097(0.5, 1, vectordot(var_28, var_29));
    var_30 = var_30 * var_3;

    if(var_30 > var_6)
      var_27 = var_10;
    else
      var_27 = var_11;

    var_6 = scripts\sp\math::_id_AB6F(var_6, var_30, var_27);
    var_31 = length(var_1);

    if(var_24 > var_31)
      var_32 = 1.4;
    else
      var_32 = 0.8;

    var_33 = abs(var_24 - var_31);
    var_34 = scripts\sp\math::_id_C097(2 * level._id_A056._id_EBAD, 30 * level._id_A056._id_EBAD, var_33);
    var_34 = var_34 * var_2;
    var_34 = var_34 * var_32;

    if(level._id_241D)
      var_34 = var_34 * 1.8;

    if(var_34 > var_7)
      var_27 = var_12;
    else
      var_27 = var_13;

    var_7 = scripts\sp\math::_id_AB6F(var_7, var_34, var_27);
    var_35 = scripts\sp\math::_id_C097(100 * level._id_A056._id_EBAD, 500 * level._id_A056._id_EBAD, var_24);
    var_35 = scripts\sp\math::_id_6A8E(0.2, 1.3, var_35);

    if(var_35 > var_18)
      var_27 = var_16;
    else
      var_27 = var_17;

    var_18 = scripts\sp\math::_id_AB6F(var_18, var_35, var_27);

    if(level._id_D127.spaceship_mode == "fly")
      var_36 = 1;
    else
      var_36 = 0.2;

    if(var_36 > var_19)
      var_27 = var_20;
    else
      var_27 = var_21;

    var_19 = scripts\sp\math::_id_AB6F(var_19, var_36, var_27);
    var_37 = scripts\sp\math::_id_C09B(var_19);
    level._id_A056._id_67D9 = clamp(var_7 + (var_6 + var_5) * var_18, 0, 1) * var_37;
    level._id_A056._id_67D9 = scripts\sp\math::_id_6A8E(-1, 1, level._id_A056._id_67D9);
    var_0 = var_22;
    var_1 = var_23;
    wait 0.05;
  }
}

_id_D148() {
  self endon("player_exit_jackal");
  level._id_D127._id_58B5 = 0;

  for(;;) {
    self waittill("fd_notify_ace_mode_engaged", var_0);
    self._id_A178 = playFXOnTag(scripts\engine\utility::getfx("jackal_dogfight_cam"), self, "tag_origin");
    self waittill("fd_notify_ace_mode_disengaged");
    var_0 _id_F360(0);
    stopFXOnTag(scripts\engine\utility::getfx("jackal_dogfight_cam"), self, "tag_origin");
    self._id_A178 = undefined;
  }
}

_id_F360(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.bt))
    self.bt._id_5870 = var_0;

  if(isDefined(self._blackboard))
    self._blackboard._id_9DC2 = var_0;
}

_id_D17D() {
  setomnvar("ui_jackal_current_weapon", self._id_4C15._id_13CDF);
  _id_D17E();
  self._id_4C15 thread[[self._id_4C15._id_13C1D]]();
}

_id_D17E() {
  if(scripts\sp\utility::_id_D15B("weapons"))
    var_0 = "_weapupgrade";
  else
    var_0 = "";

  self _meth_849E(self._id_4C15.weapon + var_0);
}

_id_D178() {
  self._id_4C15 thread[[self._id_4C15._id_13C08]]();
  self._id_4C15._id_C7F8 = 0;
}

_id_D1A0() {
  self playSound(self._id_4C15._id_1136A);
  thread _id_D1A1();
}

_id_D1A1() {
  self notify("new_cockpit_vo");
  self endon("new_cockpit_vo");
  wait(self._id_4C15._id_134C7);
  _id_0BDC::_id_A112(self._id_4C15._id_134AE, 0.5);
}

_id_4EED() {
  self endon("player_exit_jackal");
  setDvar("scr_givejackal", "none");
  setDvar("scr_jackalDemigod", 0);
  var_0 = getDvar("scr_givejackal");

  for(;;) {
    wait 0.5;

    if(!scripts\sp\utility::_id_D123()) {
      continue;
    }
    var_1 = getDvar("scr_givejackal");
    var_1 = tolower(var_1);

    if(var_1 == var_0) {
      continue;
    }
    var_0 = var_1;

    switch (var_0) {
      case "gren":
        _id_D157("primary_default");
        break;
      case "dragonfly":
        _id_D157("primary_upgrade_1");
        break;
      case "microlite":
        _id_D157("primary_upgrade_2");
        break;
      case "pathfinder":
        _id_D157("secondary_default");
        break;
      case "cleaver":
        _id_D157("secondary_upgrade_1");
        break;
      case "anvil":
        _id_D157("secondary_upgrade_2");
        break;
      case "noperk":
        _id_0BDC::_id_12DCD("none");
        break;
      case "weaponperk":
        _id_0BDC::_id_12DCD("weapons");
        break;
      case "thrusterperk":
        _id_0BDC::_id_12DCD("thrusters");
        break;
      case "hullperk":
        _id_0BDC::_id_12DCD("hull");
        break;
      case "missiles":
        level._id_D127 _id_0BDD::_id_A2D5();
        break;
    }
  }
}

_id_D17F() {
  _id_F43C();
  _id_F43E();
}

_id_F43C() {
  if(!isDefined(self._id_13BF7))
    self._id_13BF7 = _id_0BDD::_id_A1F8(_id_0A2F::_id_D9FE());

  setomnvar("ui_jackal_equipped_primary_index", self._id_13BF7._id_12B2A);
}

_id_F43E() {
  if(!isDefined(self._id_13BF8))
    self._id_13BF8 = _id_0BDD::_id_A1F8(_id_0A2F::_id_DA00());

  setomnvar("ui_jackal_equipped_secondary_index", self._id_13BF8._id_12B2A);
}

_id_D19E() {
  self endon("player_exit_jackal");
  level._id_D127._id_5F0D = 0;
  _id_0BDC::_id_137DB();
  self._id_4C15 = self._id_13BF7;
  self._id_110CA = self._id_13BF8;
  _id_1136F();
  _id_D17D();
  level.player notifyonplayercommand("jackal_switch_weapons", "+weapnext");

  for(;;) {
    level.player waittill("jackal_switch_weapons");

    if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_guns") && !level.player scripts\sp\utility::_id_65DB("disable_jackal_weapon_switch")) {
      _id_D178();

      if(self._id_4C15 == self._id_13BF7) {
        self._id_4C15 = self._id_13BF8;
        self._id_110CA = self._id_13BF7;

        if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_overheat"))
          setomnvar("ui_jackal_weapon_secondary", 1);

        thread _id_5D09(0, 1.15);
      } else {
        self._id_4C15 = self._id_13BF7;
        self._id_110CA = self._id_13BF8;

        if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_overheat"))
          setomnvar("ui_jackal_weapon_secondary", 0);

        thread _id_5D09(0, 1.0);
      }

      _id_1136F();
      _id_D17D();
      _id_D1A0();
      thread _id_D19F();
    }
  }
}

_id_D19A() {
  self endon("player_exit_jackal");

  for(;;) {
    self waittill("spaceship_weapon_state_change", var_0);

    switch (var_0) {
      case "weapon_drop":
        self playSound("jackal_wpn_mvmt_takeoff");
        thread _id_5D09(0, 1.35);
        break;
      case "weapon_raise":
        self playSound("jackal_wpns_up");
        thread _id_5D09(0, 1.5);
        break;
      case "silent":
        self waittill("spaceship_weapon_state_change");
    }
  }
}

_id_5D09(var_0, var_1) {
  wait(var_0);
  level.player playRumbleOnEntity("damage_light");
  earthquake(0.1, 0.75, level._id_D127.origin, 20000);
  wait(var_1);
  earthquake(0.13, 0.75, level._id_D127.origin, 20000);
  level.player playRumbleOnEntity("damage_light");
}

_id_D157(var_0) {
  if(!scripts\engine\utility::player_is_in_jackal()) {
    return;
  }
  if(issubstr(var_0, "primary"))
    var_1 = 1;
  else
    var_1 = 0;

  if(level._id_D127._id_4C15.class == "primary") {
    if(var_1) {
      level._id_D127._id_13BF7 = _id_0BDD::_id_A1F8(var_0);
      level._id_D127 _id_729D(level._id_D127._id_13BF7);
    } else {
      level._id_D127._id_13BF8 = _id_0BDD::_id_A1F8(var_0);
      level._id_D127._id_110CA = level._id_D127._id_13BF8;
    }
  } else if(var_1) {
    level._id_D127._id_13BF7 = _id_0BDD::_id_A1F8(var_0);
    level._id_D127._id_110CA = level._id_D127._id_13BF7;
  } else {
    level._id_D127._id_13BF8 = _id_0BDD::_id_A1F8(var_0);
    level._id_D127 _id_729D(level._id_D127._id_13BF8);
  }
}

_id_729D(var_0) {
  _id_D178();
  self._id_4C15 = var_0;
  _id_1136F();
  _id_D17D();
}

_id_1136F() {
  if(isDefined(self._id_4C15._id_105EF))
    setsaveddvar("spaceshipTargetLockDistanceScale", self._id_4C15._id_105EF);
  else
    setsaveddvar("spaceshipTargetLockDistanceScale", 1);

  if(isDefined(self._id_4C15._id_105EE))
    setsaveddvar("spaceshipTargetLockAnglesScale", self._id_4C15._id_105EE * level._id_A48E._id_D3B9);
  else
    setsaveddvar("spaceshipTargetLockAnglesScale", 1 * level._id_A48E._id_D3B9);

  if(isDefined(self._id_4C15._id_105F0))
    setsaveddvar("spaceshipTargetLockTimeScale", self._id_4C15._id_105F0);
  else
    setsaveddvar("spaceshipTargetLockTimeScale", 1);

  if(isDefined(self._id_4C15._id_5F0D) && self._id_4C15._id_5F0D)
    level._id_D127._id_5F0D = 1;
  else
    level._id_D127._id_5F0D = 0;

  level._id_D127 _id_A31B();
}

_id_D199() {
  self endon("player_exit_jackal");
  _id_0BDC::_id_137DB();

  while(!isDefined(self._id_110CA))
    wait 0.05;

  var_0 = 0.9;

  for(;;) {
    if(self._id_4C15._id_C7F8)
      self._id_4C15 _id_D198(self._id_4C15._id_1167E);
    else
      self._id_4C15 _id_D198(self._id_4C15._id_1167C);

    self._id_110CA _id_D198(self._id_110CA._id_11680);
    self._id_4C15 _id_D197(self._id_4C15._id_A5A3);
    wait 0.05;
  }
}

_id_D198(var_0) {
  self._id_2841 = self._id_2841 - var_0;

  if(self._id_2841 < 0)
    self._id_2841 = 0;

  self._id_2844 = self._id_2844 - var_0;

  if(self._id_2844 < 0)
    self._id_2844 = 0;

  setomnvar(self._id_2842, self._id_2841);
  setomnvar(self._id_2843, self._id_2844);

  if(self._id_2841 < 0.55 && self._id_2846 && !self._id_283A)
    _id_D193(0);

  if(self._id_2844 < 0.55 && self._id_2849 && !self._id_283D)
    _id_D194(0);

  if(self._id_2841 < 0.3 && self._id_283A)
    _id_D171(0);

  if(self._id_2844 < 0.3 && self._id_283D)
    _id_D172(0);
}

_id_D197(var_0) {
  self._id_A5A2 = self._id_A5A2 + var_0;
  self._id_A5A2 = clamp(self._id_A5A2, 0, 1);
}

_id_D19F() {
  self endon("jackal_switch_weapons");
  self endon("player_exit_jackal");
  level.player allowads(0);

  while(!level.player _meth_853A())
    wait 0.05;

  if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_ads"))
    level.player allowads(1);
}

_id_D19B() {
  self endon("player_exit_jackal");
  _id_0BDC::_id_137DB();
  self._id_A929 = -99999;

  for(;;) {
    self waittill("vehicle_turret_fire", var_0);
    var_1 = 1;

    if(isDefined(self._id_4C15._id_5F0D) && self._id_4C15._id_5F0D)
      var_1 = 0;

    self notify("vehicle_turret_fire_passed");
    self._id_4C15 _id_D197(self._id_4C15._id_A5A6);
    self._id_4C15 thread[[self._id_4C15._id_6CF8]](var_0);

    if(!self._id_4C15._id_9DF4) {
      self._id_4C15._id_9DF4 = 1;
      thread _id_D19C();
    }

    childthread _id_D137();
    var_0 = -1 * var_0 + 1;

    if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_overheat")) {
      if(var_1) {
        if(var_0) {
          self._id_4C15._id_2841 = self._id_4C15._id_2841 + _id_7CF0();

          if(self._id_4C15._id_2841 > 1)
            self._id_4C15._id_2841 = 1;
        } else {
          self._id_4C15._id_2844 = self._id_4C15._id_2844 + _id_7CF0();

          if(self._id_4C15._id_2844 > 1)
            self._id_4C15._id_2844 = 1;
        }
      } else {
        self._id_4C15._id_2841 = self._id_4C15._id_2841 + _id_7CF0();

        if(self._id_4C15._id_2841 > 1)
          self._id_4C15._id_2841 = 1;

        self._id_4C15._id_2844 = self._id_4C15._id_2844 + _id_7CF0();

        if(self._id_4C15._id_2844 > 1)
          self._id_4C15._id_2844 = 1;
      }

      _id_D132();
    }
  }
}

_id_7CF0() {
  if(scripts\sp\utility::_id_D15B("weapons"))
    return self._id_4C15._id_116B3 * 0.8;
  else
    return self._id_4C15._id_116B3;
}

_id_D132() {
  var_0 = 0.7;

  if(self._id_4C15._id_2841 > 0.98 && !self._id_4C15._id_283A)
    self._id_4C15 _id_D171(1);

  if(self._id_4C15._id_2844 > 0.98 && !self._id_4C15._id_283D)
    self._id_4C15 _id_D172(1);

  if(self._id_4C15._id_2841 > 0.55 && !self._id_4C15._id_2846)
    self._id_4C15 _id_D193(1);

  if(self._id_4C15._id_2844 > 0.55 && !self._id_4C15._id_2849)
    self._id_4C15 _id_D194(1);

  if(self._id_4C15._id_283D && self._id_4C15._id_283A)
    _id_D170();
}

_id_D193(var_0) {
  self._id_2846 = var_0;
  setomnvar(self._id_2847, var_0);

  if(var_0)
    _id_D18F();
}

_id_D194(var_0) {
  self._id_2849 = var_0;
  setomnvar(self._id_2848, var_0);

  if(var_0)
    _id_D18F();
}

_id_D171(var_0) {
  self._id_283A = var_0;
  setomnvar(self._id_283B, var_0);
}

_id_D172(var_0) {
  self._id_283D = var_0;
  setomnvar(self._id_283C, var_0);
}

_id_D18F() {
  var_0 = gettime();

  if(var_0 - level._id_D127._id_A929 > 16000) {
    _id_0BDC::_id_A112("jackal_hud_overheating_barrels", 0.5);
    level._id_D127._id_A929 = var_0;
  }
}

_id_D170() {
  level.player allowfire(0);
  level.player notify("jackal_stop_firing");
  setomnvar("ui_jackal_weapon_overheat", 1);
  level._id_D127._id_C7FA = scripts\engine\utility::spawn_tag_origin();
  level._id_D127._id_C7FA linkTo(level._id_D127, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
  level._id_D127._id_C7FA playLoopSound("jackal_overheat_lp");
  _id_0BDC::_id_A112("jackal_hud_overheated_generic", 0.5);
  level._id_D127._id_A929 = gettime();
  thread _id_D173();
  self._id_4C15._id_C7F8 = 1;

  while(self._id_4C15._id_2841 > 0.3 || self._id_4C15._id_2844 > 0.3)
    wait 0.05;

  scripts\engine\utility::flag_clear("jackal_weapon_switch_hint");
  self notify("self_weapons_cooled");
  level.player allowfire(1);
  setomnvar("ui_jackal_weapon_overheat", 0);
  level._id_D127._id_C7FA stoploopsound("jackal_overheat_lp");
  level._id_D127._id_C7FA delete();
  self._id_4C15._id_C7F8 = 0;
}

_id_D173() {
  self endon("self_weapons_cooled");

  while(level.player attackButtonPressed())
    wait 0.05;

  while(!level.player attackButtonPressed())
    wait 0.05;

  scripts\engine\utility::flag_set("jackal_weapon_switch_hint");
  scripts\sp\utility::_id_56BA("jackal_weapon_switch");
}

_id_D137() {
  self endon("vehicle_turret_fire_passed");
  self endon("jackal_switch_weapons");
  self._id_4C15._id_1167C = 0;
  var_0 = self._id_4C15._id_1167F;
  var_1 = self._id_4C15._id_1167D;
  var_2 = var_1 * (0.05 / self._id_4C15._id_1167F);

  while(self._id_4C15._id_1167C < self._id_4C15._id_1167D) {
    self._id_4C15._id_1167C = self._id_4C15._id_1167C + var_2;
    wait 0.05;
  }

  self._id_4C15._id_1167C = self._id_4C15._id_1167D;
}

_id_D19C() {
  self endon("player_exit_jackal");
  _id_D19D();
  self._id_4C15 thread[[self._id_4C15._id_1106F]]();
  self._id_4C15._id_9DF4 = 0;
}

_id_D19D() {
  level.player endon("jackal_switch_weapons");

  while(level.player attackButtonPressed() && !level.player scripts\sp\utility::_id_65DB("disable_jackal_guns"))
    wait 0.05;
}

_id_D128() {
  self endon("player_exit_jackal");
  _id_0BDC::_id_137DB();
  var_0 = 0;
  var_1 = 0.0;
  var_2 = 0.1;
  var_3 = var_2;
  var_4 = 1;

  for(;;) {
    var_5 = level.player playerads();

    if(var_5 > var_1 && !var_0) {
      var_4 = 0.75;
      var_3 = (1 - var_5) * var_2;
      _id_0BDC::_id_A302(var_4, var_3, "ads");
      var_0 = 1;
    }

    if(var_5 < var_1 && var_0) {
      var_4 = 1.0;
      var_3 = var_5 * var_2;
      _id_0BDC::_id_A302(var_4, var_3, "ads");
      var_0 = 0;
    }

    var_1 = var_5;
    wait 0.05;
  }
}

_id_13C51() {
  wait 0.8;
  level.player playRumbleOnEntity("damage_light");
  earthquake(0.12, 1, level._id_D127.origin, 5000);
}

_id_13C52() {
  wait 1.0;
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.18, 1, level._id_D127.origin, 5000);
}

_id_1023D() {
  self._id_10239 = spawnStruct();
  self._id_10239._id_10240 = 0;
  self._id_10239._id_FB87 = scripts\engine\utility::spawn_tag_origin();
  self._id_10239._id_FB87 linkTo(self, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
  self._id_FB88 = scripts\engine\utility::array_add(self._id_FB88, self._id_10239._id_FB87);
}

_id_DBA4() {
  self._id_DBA2 = spawnStruct();
  self._id_DBA2._id_FB87 = scripts\engine\utility::spawn_tag_origin();
  self._id_DBA2._id_FB87 linkTo(self, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
  self._id_DBA2._id_FB87 _meth_8278(0, 0);
  self._id_DBA2._id_FB87 playLoopSound("jackal_airbrake_lp");
  self._id_DBA2._id_E7BA = scripts\engine\utility::spawn_tag_origin((100000, 100000, 100000));
  self._id_DBA2._id_E7BA _meth_8244("steady_rumble");
  self._id_DBA2._id_E7BA _id_0BDC::_id_F2FF();
  self._id_DBA2._id_2B8D = 0;
  self._id_FB88 = scripts\engine\utility::array_add(self._id_FB88, self._id_DBA2._id_FB87);
  self._id_4074 = scripts\engine\utility::array_add(self._id_4074, self._id_DBA2._id_E7BA);
  self._id_74BD = spawnStruct();
  self._id_74BD._id_FB87 = scripts\engine\utility::spawn_tag_origin();
  self._id_74BD._id_FB87 linkTo(self, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
  self._id_74BD._id_FB87 _meth_8278(0, 0);
  self._id_74BD._id_FB87 playLoopSound("jackal_plr_full_throttle");
  self.engine_master_volume = 0;
  self._id_FB88 = scripts\engine\utility::array_add(self._id_FB88, self._id_74BD._id_FB87);

  if(level.player scripts\sp\utility::_id_65DB("disable_jackal_quickturn"))
    self._id_DBA2._id_B3D1 = 0;
  else
    self._id_DBA2._id_B3D1 = 1;

  if(!isDefined(self._id_5509))
    self._id_5509 = 0;

  thread _id_DBA3();
}

_id_10239() {
  self endon("stop_skid");
  self endon("player_exit_jackal");
  var_0 = 2.2;

  if(!self._id_10239._id_10240) {
    self._id_10239._id_10240 = 1;
    self._id_10239._id_E7BA = scripts\engine\utility::spawn_tag_origin((100000, 100000, 100000));
    self._id_4074 = scripts\engine\utility::array_add(self._id_4074, self._id_10239._id_E7BA);
    self._id_10239._id_E7BA _meth_8244("steady_rumble");
    self._id_10239._id_E7BA _id_0BDC::_id_F2FF();
  }

  var_1 = scripts\sp\math::_id_C097(100, 500, length(self.spaceship_vel));
  var_2 = level.player _meth_814B();
  var_3 = scripts\sp\math::_id_6A8E(0.35, 1, abs(var_2[1]));
  var_4 = var_1 * var_3;
  var_5 = 0.6;
  var_6 = 0.9;
  thread _id_1023E(var_4, var_5, var_6);
  thread _id_1023F(var_4, var_5, var_6);
  var_7 = scripts\sp\math::_id_6A8E(1, var_0, var_1 * var_3);
  _id_0BDC::_id_A302(var_7, var_5, "skid");
  wait(var_5);
  _id_0BDC::_id_A302(1, var_6, "skid");
  wait(var_6);
  _id_1023B();
}

_id_DBA3() {
  self endon("player_exit_jackal");
  var_0 = 2.55;
  var_1 = 0.2;
  var_2 = 0.2;
  var_3 = 0.155;
  var_4 = 0.07;
  var_5 = 0.65;
  var_6 = 0.15;
  var_7 = 1.9;
  var_8 = 1.6;
  var_9 = 0;
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = 0;
  var_14 = 0;
  var_15 = 0.0;
  var_16 = 0;
  var_17 = 0;
  var_18 = 0;
  var_19 = 0;
  var_20 = 0.15;
  var_21 = 1;
  var_22 = 0;
  var_23 = 0;

  for(;;) {
    var_24 = getdvarint("spaceshipFlySpeedScale");

    if(var_24 == 0)
      var_24 = 0.01;

    var_25 = level.player _meth_814B();
    var_26 = level.player getnormalizedmovement();
    var_27 = rotatevectorinverted(self.spaceship_vel, self.angles);
    var_27 = var_27[0];

    if(var_27 < 0)
      var_27 = 0;

    var_28 = var_26[0];

    if(var_28 > 0)
      var_29 = scripts\sp\math::_id_6A8E(0.5, 0, var_28);
    else
      var_29 = scripts\sp\math::_id_6A8E(0.5, 1, abs(var_28));

    var_30 = abs(var_25[1] - var_26[1]) * 0.5;
    var_30 = var_30 * abs(var_25[1]);
    var_18 = scripts\sp\math::_id_AB6F(var_18, var_30, var_20);
    var_19 = scripts\sp\math::_id_AB6F(var_19, var_29, var_20);
    var_31 = scripts\sp\math::_id_C097(150 * var_24, 450 * var_24, var_27);

    if(var_31 > var_14)
      var_14 = scripts\sp\math::_id_AB6F(var_14, var_31, 0.35);
    else
      var_14 = scripts\sp\math::_id_AB6F(var_14, var_31, 0.1);

    var_32 = var_19 * self._id_DBA2._id_B3D1 * abs(var_18) * var_14 * var_24;
    var_33 = scripts\sp\math::_id_6A8E(1, var_0, var_32);
    level._id_A056._id_BBB9["turn"]._id_3C66["quickturn_scale"] = var_33;
    var_34 = var_27;
    var_35 = var_32;
    var_35 = clamp(var_35, 0, 1) * self._id_DBA2._id_B3D1;
    var_36 = scripts\sp\math::_id_6A8E(0, var_7, var_35);
    var_37 = scripts\sp\math::_id_6A8E(1.1, 0.8, var_35);
    var_38 = scripts\sp\math::_id_6A8E(0.0, var_3, var_35);
    var_39 = var_35 * var_5;
    var_36 = var_36 * self.engine_master_volume;

    if(var_36 > 0.25) {
      if(var_23 == 0) {
        level.player playSound("jackal_airbrake_init");
        var_23 = 1;
      }

      self._id_DBA2._id_FB87 _meth_8278(var_36, 0.05);
    } else {
      var_23 = 0;
      self._id_DBA2._id_FB87 _meth_8278(0, 0.05);
    }

    self._id_DBA2._id_FB87 _meth_8277(var_37, 0.05);
    var_40 = scripts\sp\math::_id_C097(0, 1, var_26[0]);

    if(var_10 < var_40)
      var_41 = var_1;
    else
      var_41 = var_2;

    var_10 = scripts\sp\math::_id_AB6F(var_10, var_40, var_41);
    var_11 = scripts\sp\math::_id_AB6F(var_11, var_34, 0.1);
    var_31 = scripts\sp\math::_id_C097(175, 330, var_11);
    var_31 = scripts\sp\math::_id_6A8E(1, 0.4, var_31);
    var_42 = var_10 * var_31 * self._id_DBA2._id_B3D1;
    var_36 = scripts\sp\math::_id_6A8E(0, var_8, var_42);
    var_37 = scripts\sp\math::_id_6A8E(0.8, 1.4, var_42);
    var_36 = var_36 * self.engine_master_volume;

    if(var_22 == 1) {
      if(var_36 > 0.1) {
        var_22 = 0;
        level.player playSound("jackal_plr_throttle_on");
      }
    }

    if(var_22 == 0) {
      if(var_36 < 0.1) {
        var_22 = 1;
        level.player playSound("jackal_plr_throttle_off");
      }
    }

    self._id_74BD._id_FB87 _meth_8278(var_36, 0.05);
    self._id_74BD._id_FB87 _meth_8277(var_37, 0.05);
    var_43 = var_42 * var_4 * self._id_DBA2._id_B3D1;
    var_44 = var_42 * var_6 * self._id_DBA2._id_B3D1;

    if(self.spaceship_boosting || isDefined(self._id_6ADB)) {
      var_45 = 0.6;
      var_46 = 0.0;

      if(!var_17 && !self._id_5509) {
        var_17 = 1;
        thread _id_D12D();
        _id_0BDC::_id_A302(0.85, 0.3, "boost");
      }
    } else {
      var_46 = clamp(var_38 + var_43, 0.0, 1);
      var_45 = clamp(var_39 + var_44, 0, 1);

      if(var_17) {
        var_17 = 0;
        thread _id_D12C();
        _id_0BDC::_id_A302(1.0, 0.5, "boost");
      }
    }

    var_47 = scripts\sp\math::_id_6A8E(1000, 0, var_45);
    self._id_DBA2._id_E7BA.origin = level._id_D127.origin + (0, 0, var_47);

    if(isDefined(self._id_2CD0))
      var_46 = self._id_2CD0;

    if(var_46 > 0)
      earthquake(var_46, 0.1, level._id_D127.origin, 5000);

    if(self._id_DBA2._id_2B8D) {
      self waittill("quickturn_master_blend_complete");
      continue;
    }

    level.player waittill("on_player_update");
  }
}

_id_D176(var_0, var_1, var_2, var_3, var_4) {
  self notify("jackalradialBlurLerp");
  self endon("jackalradialBlurLerp");
  self endon("player_exit_jackal");

  if(!isDefined(var_3))
    var_3 = 0.05;

  if(!isDefined(var_4))
    var_4 = 0.1;

  var_5 = 0.05;
  var_0 = clamp(var_0, 0.0, 1.0);

  if(!isDefined(self._id_DBE5))
    self._id_DBE5 = 0.0;

  var_6 = abs(self._id_DBE5 - var_0);
  var_7 = int(var_2 / var_5);

  if(var_7 == 0)
    var_7 = 1;

  var_8 = var_6 / var_7;
  wait(var_1);

  while(self._id_DBE5 != var_0) {
    var_7--;

    if(!var_7)
      self._id_DBE5 = var_0;

    if(self._id_DBE5 < var_0)
      self._id_DBE5 = min(var_0, self._id_DBE5 + var_8);
    else
      self._id_DBE5 = max(var_0, self._id_DBE5 - var_8);

    setsaveddvar("r_mbRadialOverrideStrength", var_3 * self._id_DBE5);
    setsaveddvar("r_mbRadialOverrideRadius", 1.0 - 0.8 * self._id_DBE5);
    setsaveddvar("r_mbRadialOverrideDistortion", var_4 * self._id_DBE5);
    wait(var_5);
  }
}

_id_D12D() {
  self endon("boost_fx_off");
  self notify("boost_fx_on");
  self endon("player_exit_jackal");
  scripts\sp\utility::_id_75C4("jackal_boost_speed", "tag_origin");
  thread _id_DC5E();

  if(!scripts\engine\utility::is_true(level._id_D127._id_6ADB))
    level.player thread _id_D176(0.8, 0, 0.4, 0.01, 0.3);
}

_id_DC5E() {
  self endon("boost_fx_off");
  self._id_2CD0 = 0.34;
  var_0 = 0.15;

  while(self._id_2CD0 > var_0) {
    self._id_2CD0 = self._id_2CD0 - 0.02;
    wait 0.05;
  }

  self._id_2CD0 = var_0;
}

_id_D12C() {
  self endon("boost_fx_on");
  self notify("boost_fx_off");
  scripts\sp\utility::_id_75F8("jackal_boost_speed", "tag_origin");
  self._id_2CD0 = undefined;

  if(!scripts\engine\utility::is_true(level._id_D127._id_6ADB))
    level.player _id_D176(0.0, 0, 0.2, 0.01, 0.3);

  setsaveddvar("spaceshipRadialMotionBlurMaxStrength", 0.0);
  setsaveddvar("spaceshipRadialMotionBlurMaxRadius", 0.0);
}

_id_1023A() {
  self endon("start_skid");
  self notify("stop_skid");

  if(!self._id_10239._id_10240) {
    return;
  }
  var_0 = 0.25;
  _id_0BDC::_id_A302(1, var_0, "skid");
  self._id_10239._id_FB87 _meth_8278(0, var_0);

  for(var_1 = var_0; var_1 > 0; var_1 = var_1 - 0.05) {
    var_2 = scripts\sp\math::_id_6A8E(0, 1, var_1 / var_0);
    var_3 = 1 - var_2;
    var_3 = var_3 * 1000;
    self._id_10239._id_E7BA.origin = level._id_D127.origin + (0, 0, var_3);
    wait 0.05;
  }

  _id_1023B();
}

_id_1023B() {
  self._id_10239._id_10240 = 0;
  self._id_4074 = scripts\engine\utility::array_remove(self._id_4074, self._id_10239._id_E7BA);
  self stoprumble("steady_rumble");
  self._id_10239._id_E7BA delete();
}

_id_1023E(var_0, var_1, var_2) {
  var_1 = var_1 * 0.7;
  var_2 = var_2 * 0.7;
  self notify("start_skid");
  self endon("stop_skid");
  self endon("player_exit_jackal");
  var_3 = scripts\sp\math::_id_6A8E(0.08, 0.32, var_0);
  var_4 = var_0;
  var_5 = var_1 + var_2;

  for(var_6 = 0.05; var_5 > 0; var_5 = var_5 - var_6) {
    if(var_5 > var_2)
      var_7 = 1 - scripts\sp\math::_id_C097(0, var_1, var_5 - var_2);
    else
      var_7 = scripts\sp\math::_id_C097(0, var_2, var_5);

    var_8 = scripts\sp\math::_id_6A8E(0, var_3, var_7);
    var_9 = scripts\sp\math::_id_6A8E(0, var_4, var_7);
    earthquake(var_8, 0.1, level._id_D127.origin, 5000);
    var_10 = 1 - var_9;
    var_10 = var_10 * 1000;
    self._id_10239._id_E7BA.origin = level._id_D127.origin + (0, 0, var_10);
    level.player waittill("on_player_update");
  }
}

_id_1023F(var_0, var_1, var_2) {
  var_3 = 0.3;
  var_4 = scripts\sp\math::_id_6A8E(0.2, 1.0, var_0);
  var_5 = scripts\sp\math::_id_6A8E(0.6, 1.1, var_0);
  self._id_10239._id_FB87 _meth_8278(var_4, 0.1);
  self._id_10239._id_FB87 _meth_8277(var_5, 0.1);
  self._id_10239._id_FB87 playSound("jackal_skid");
  wait(var_1 + var_2 - var_3);

  if(isDefined(self) && isDefined(self._id_10239) && isDefined(self._id_10239._id_FB87))
    self._id_10239._id_FB87 _meth_8278(0, 1);
}

_id_968C() {
  if(!isDefined(self._id_11488))
    _id_0BDC::_id_F5BD("vtol");

  if(!isDefined(self._id_A7C1))
    _id_0BDC::_id_F448("instant");

  if(!isDefined(self._id_BBEB))
    _id_0BDC::_id_F48D("default_landed");

  if(!isDefined(self._id_56A4))
    _id_0BDC::_id_F358("default_landed");
}

_id_A382() {
  self endon("player_exit_jackal");
  level._id_A056._id_10991 = [];

  for(;;) {
    level waittill("notify_new_jackal_speed_zone");

    if(level._id_A056._id_10991.size > 0 && level._id_A056._id_1C6C) {
      _id_0BDC::_id_A301(level._id_A056._id_10991[0]._id_EEBF, level._id_A056._id_10991[0]._id_ED75, "triggered");
      continue;
    }

    _id_0BDC::_id_A301(1, 2, "triggered");
  }
}

_id_7D0B(var_0) {
  var_1 = 1;

  foreach(var_4, var_3 in var_0)
  var_1 = var_1 * var_3;

  return var_1;
}

_id_7D0C(var_0) {
  var_1 = (0, 0, 0);

  foreach(var_3 in var_0)
  var_1 = var_1 + var_3;

  return var_1;
}

_id_104A9() {
  self endon("player_exit_jackal");
  thread _id_A382();

  if(!isDefined(level._id_A056._id_BBB9)) {
    level._id_A056._id_BBB9 = [];
    level._id_A056._id_BBB9["speed"] = spawnStruct();
    level._id_A056._id_BBB9["turn"] = spawnStruct();
    level._id_A056._id_BBB9["boost"] = spawnStruct();
    level._id_A056._id_BBB9["weapKick"] = spawnStruct();
    level._id_A056._id_BBB9["force"] = spawnStruct();
    level._id_A056._id_BBB9["ship_rotate"] = spawnStruct();
    level._id_A056._id_BBB9["view_rotate"] = spawnStruct();
    level._id_A056._id_BBB9["speed"]._id_6FE8 = getdvarfloat("spaceshipFlySpeedScale");
    level._id_A056._id_BBB9["speed"]._id_90CA = getdvarfloat("spaceshipHoverSpeedScale");
    level._id_A056._id_BBB9["speed"]._id_A4B7 = getdvarfloat("spaceshipJukeStrengthScale");
    level._id_A056._id_BBB9["speed"]._id_90F9 = getdvarfloat("spaceshipMinPhysicsBlendSpeed");
    level._id_A056._id_BBB9["speed"]._id_90F8 = getdvarfloat("spaceshipMaxPhysicsBlendSpeed");
    level._id_A056._id_BBB9["turn"]._id_12996 = getdvarfloat("spaceshipTurnSpeedScale");
    level._id_A056._id_BBB9["boost"]._id_2CB3 = getdvarfloat("spaceshipBoostSpeedScale");
    level._id_A056._id_BBB9["force"]._id_729A = getdvarvector("spaceshipAddVelocity");
    level._id_A056._id_BBB9["force"]._id_1189B = 0;
    level._id_A056._id_BBB9["ship_rotate"]._id_E748 = getdvarvector("spaceshipAddViewRotVelocity");
    level._id_A056._id_BBB9["ship_rotate"]._id_1189B = 0;
    level._id_A056._id_BBB9["view_rotate"]._id_E748 = getdvarvector("spaceshipAddshipRotVelocity");
    level._id_A056._id_BBB9["view_rotate"]._id_1189B = 0;
    level._id_A056._id_BBB9["weapKick"]._id_3C66 = [];
    level._id_A056._id_BBB9["weapKick"]._id_3C66["weapKick"] = 1;
  } else {
    setsaveddvar("spaceshipHoverSpeedScale", level._id_A056._id_BBB9["speed"]._id_90CA);
    setsaveddvar("spaceshipFlySpeedScale", level._id_A056._id_BBB9["speed"]._id_6FE8);
    setsaveddvar("spaceshipJukeStrengthScale", level._id_A056._id_BBB9["speed"]._id_A4B7);
    setsaveddvar("spaceshipMinPhysicsBlendSpeed", level._id_A056._id_BBB9["speed"]._id_90F9);
    setsaveddvar("spaceshipMaxPhysicsBlendSpeed", level._id_A056._id_BBB9["speed"]._id_90F8);
    setsaveddvar("spaceshipTurnSpeedScale", level._id_A056._id_BBB9["turn"]._id_12996);
    setsaveddvar("spaceshipBoostSpeedScale", level._id_A056._id_BBB9["boost"]._id_2CB3);
    setsaveddvar("spaceshipAddVelocity", level._id_A056._id_BBB9["force"]._id_729A);
    setsaveddvar("spaceshipAddViewRotVelocity", level._id_A056._id_BBB9["ship_rotate"]._id_E748);
    setsaveddvar("spaceshipAddshipRotVelocity", level._id_A056._id_BBB9["view_rotate"]._id_E748);
  }

  level._id_A056._id_BBB9["speed"]._id_3C66 = [];
  level._id_A056._id_BBB9["turn"]._id_3C66 = [];
  level._id_A056._id_BBB9["boost"]._id_3C66 = [];
  level._id_A056._id_BBB9["force"]._id_3C66 = [];
  level._id_A056._id_BBB9["ship_rotate"]._id_3C66 = [];
  level._id_A056._id_BBB9["view_rotate"]._id_3C66 = [];
  var_0 = level._id_A056._id_BBB9["speed"]._id_90CA;
  var_1 = level._id_A056._id_BBB9["speed"]._id_6FE8;
  var_2 = level._id_A056._id_BBB9["speed"]._id_A4B7;
  var_3 = level._id_A056._id_BBB9["speed"]._id_90F9;
  var_4 = level._id_A056._id_BBB9["speed"]._id_90F8;
  var_5 = level._id_A056._id_BBB9["turn"]._id_12996;
  var_6 = level._id_A056._id_BBB9["boost"]._id_2CB3;
  var_7 = level._id_A056._id_BBB9["force"]._id_729A;
  var_8 = level._id_A056._id_BBB9["ship_rotate"]._id_E748;
  var_9 = level._id_A056._id_BBB9["view_rotate"]._id_E748;
  var_10 = level._id_A056._id_2CAD;
  var_11 = level._id_A056._id_6F90;
  var_12 = var_11;

  for(;;) {
    wait 0.05;
    waittillframeend;
    var_13 = _id_7D0B(level._id_A056._id_BBB9["speed"]._id_3C66);
    var_14 = _id_7D0B(level._id_A056._id_BBB9["turn"]._id_3C66);
    var_15 = _id_7D0B(level._id_A056._id_BBB9["boost"]._id_3C66);
    var_16 = level._id_A056._id_BBB9["speed"]._id_90CA;
    var_17 = level._id_A056._id_BBB9["speed"]._id_6FE8;
    var_18 = level._id_A056._id_BBB9["speed"]._id_A4B7;
    var_19 = level._id_A056._id_BBB9["turn"]._id_12996;
    var_20 = level._id_A056._id_BBB9["boost"]._id_2CB3;
    var_21 = level._id_A056._id_BBB9["speed"]._id_90F9;
    var_22 = level._id_A056._id_BBB9["speed"]._id_90F8;

    if(level._id_A056._id_1C54) {
      var_16 = var_16 * var_13;
      var_17 = var_17 * var_13;
      var_18 = var_18 * var_13;
      var_21 = var_21 * var_13;
      var_22 = var_22 * var_13;
      level._id_A056._id_EBAD = var_13;
    } else
      level._id_A056._id_EBAD = 1;

    if(level._id_A056._id_1C6D) {
      var_19 = var_19 * var_14;
      level._id_A056._id_EBAE = var_14;
    }

    if(level._id_A056._id_1C3C)
      var_20 = var_20 * var_15;

    var_11 = var_13 * level._id_A056._id_6F90;
    var_10 = var_15 * level._id_A056._id_2CAD;

    if(var_10 > var_11)
      var_23 = var_10;
    else
      var_23 = var_11;

    var_24 = _id_7D0C(level._id_A056._id_BBB9["force"]._id_3C66);
    var_25 = _id_7D0C(level._id_A056._id_BBB9["ship_rotate"]._id_3C66);
    var_26 = _id_7D0C(level._id_A056._id_BBB9["view_rotate"]._id_3C66);

    if(var_0 != var_16) {
      setsaveddvar("spaceshipHoverSpeedScale", var_16);
      var_0 = var_16;
    }

    if(var_1 != var_17) {
      setsaveddvar("spaceshipFlySpeedScale", var_17);
      var_1 = var_17;
    }

    if(var_6 != var_20) {
      setsaveddvar("spaceshipBoostSpeedScale", var_20);
      var_6 = var_20;
    }

    if(var_3 != var_21) {
      setsaveddvar("spaceshipMinPhysicsBlendSpeed", var_21);
      var_3 = var_21;
    }

    if(var_4 != var_22) {
      setsaveddvar("spaceshipMaxPhysicsBlendSpeed", var_22);
      var_4 = var_22;
    }

    if(var_2 != var_18) {
      setsaveddvar("spaceshipJukeStrengthScale", var_18);
      var_2 = var_18;
    }

    if(var_5 != var_19) {
      setsaveddvar("spaceshipTurnSpeedScale", var_19);
      var_5 = var_19;
    }

    if(var_7 != var_24) {
      setsaveddvar("spaceshipAddVelocity", var_24);
      var_7 = var_24;
    }

    if(var_8 != var_25) {
      setsaveddvar("spaceshipAddViewRotVelocity", var_25);
      var_8 = var_25;
    }

    if(var_9 != var_26) {
      setsaveddvar("spaceshipAddshipRotVelocity", var_26);
      var_9 = var_26;
    }

    if(var_12 != var_23) {
      setsaveddvar("spaceshipForceMinForwardSpeed", var_23);
      var_12 = var_23;
    }
  }
}

_id_D133() {
  self._id_4074 = [];
  self._id_FB88 = [];
  wait 0.05;
  _id_0BDC::_id_137DB();
  _id_0BDC::_id_137D9();

  foreach(var_1 in self._id_4074)
  var_1 delete();

  objective_delete(scripts\sp\utility::_id_C264("jackal_dogfight"));

  if(isDefined(level.player._id_A178)) {
    stopFXOnTag(scripts\engine\utility::getfx("jackal_dogfight_cam"), level.player, "tag_origin");
    level.player._id_A178 = undefined;
  }

  foreach(var_4 in self._id_FB88)
  var_4 thread _id_6A96();
}

_id_6A96() {
  self endon("death");
  var_0 = 1;
  self _meth_8278(0, var_0);
  wait(var_0);
  self delete();
}

_id_A628() {
  wait 0.1;
  self notify("nodeath_thread");
}

_id_104A1() {
  _id_0BDC::_id_F420();
  _id_0BDC::_id_104A6(1);
}

_id_1049C() {
  self notify("end_jackal_interact");
  thread _id_1049F();

  if(!self._id_99F5._id_AB4B && !self._id_99F5._id_E526) {
    return;
  }
  if(self._id_99F5._id_AB4B && self._id_99F5._id_E526)
    _id_1049D();
  else
    _id_1049E();
}

_id_1049D() {
  self endon("end_jackal_interact");
  self endon("entitydeleted");
  self endon("player_exit_jackal");
  self._id_99F5._id_BBE7 = "";
  var_0 = 0;
  var_1 = var_0;

  for(;;) {
    var_2 = rotatevectorinverted(vectorNormalize(level.player.origin - self.origin), self.angles);

    if(var_2[1] > 0) {
      if(self._id_99F5._id_AB4B)
        var_3 = "left";
      else
        var_3 = "";

      var_4 = 48;
    } else {
      var_3 = "right";
      var_4 = -48;
    }

    var_5 = level.player.origin[2] - (self.origin[2] + self._id_99F5.height);

    if(var_5 > 40 || level.player getstance() == "prone")
      var_0 = 1;
    else
      var_0 = 0;

    if(self._id_99F5._id_BBE7 != var_3 || var_1 != var_0) {
      _id_104AA(var_4, var_0);
      self._id_99F5._id_BBE7 = var_3;
      var_1 = var_0;
    }

    wait 0.3;
  }
}

_id_1049E() {
  if(self._id_99F5._id_AB4B) {
    var_0 = "left";
    var_1 = 48;
  } else {
    var_0 = "right";
    var_1 = -48;
  }

  _id_104AA(var_1);
  self._id_99F5._id_BBE7 = var_0;
}

_id_104AA(var_0, var_1) {
  if(isDefined(var_1) && var_1)
    var_2 = 1;
  else
    var_2 = self._id_99F5._id_12FC3;

  _id_0E46::_id_DFE3();
  _id_0E46::_id_48C4("tag_body", (230, var_0, self._id_99F5.height), undefined, self._id_99F5._id_56B6, self._id_99F5.draw_distance, var_2);
}

_id_1049B() {
  self notify("end_jackal_interact");
  _id_0E46::_id_DFE3();
}

_id_1049F() {
  self notify("new_interact_trigger");
  self endon("new_interact_trigger");
  self endon("end_jackal_interact");
  self endon("player_exit_jackal");
  self waittill("trigger");
  thread _id_0BDB::_id_F51F();
}

#using_animtree("jackal");

_id_1049A() {
  self endon("death");
  _id_0BDC::_id_A144();
  self _meth_848E(1);
  wait 0.05;
  _id_0BDC::_id_A208();
  _id_0BDC::_id_A2DE();
  self _meth_82A2(%jackal_vehicle_strike_state_idle, 1, 0);
  self _meth_82A2(%jackal_vehicle_weap_primary_raise, 1, 0);
  self _meth_82A2(%jackal_vehicle_weap_primary_drop, 0, 0);
  self _meth_82B0(%jackal_vehicle_weap_primary_raise, 0);
  self _meth_82B1(%jackal_vehicle_weap_primary_raise, 0);

  if(!isDefined(self._id_6B4E))
    _id_0BDC::_id_6B4C("landed_mode");
  else {
    var_0 = self._id_6B4E;
    _id_0BDC::_id_6B4D();
    _id_0BDC::_id_6B4C(var_0);
  }

  _id_0BDC::_id_A0AF();
}

_id_10493() {
  self _meth_848E(0);
  wait 0.05;

  if(isDefined(self._id_6B4E)) {
    _id_0C18::_id_1EDC();
    self.anims.state = "none";
    _id_0BDC::_id_6B4C(self._id_6B4E);
  }
}

_id_7DB4() {
  var_0 = _id_0BCE::_id_7DB5();
  var_1 = level._id_90E2._id_5084;

  foreach(var_3 in var_1) {
    if(isaircraft(var_3)) {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_D16E() {
  self endon("player_exit_jackal");

  if(!isDefined(level._id_A056._id_E1A6)) {
    level._id_A056._id_E1A6 = [];
    level._id_A056._id_E1A5 = 0;
  }

  var_0 = 5000;

  for(;;) {
    if(level._id_A056._id_E1A6.size > 0) {
      var_1 = self.origin;
      var_2 = self.spaceship_vel;

      if(length(var_2) > 5) {
        var_3 = vectorNormalize(var_2);
        var_4 = self.origin + var_3 * var_0;
        var_5 = bulletTrace(var_1, var_4, 1, self);

        if(var_5["fraction"] < 1)
          level._id_D127._id_C2CB = 1;
        else
          level._id_D127._id_C2CB = 0;
      } else
        level._id_D127._id_C2CB = 0;
    }

    wait 0.05;
  }
}

_id_D175(var_0) {
  self endon("script_death");
  self endon("player_exit_jackal");
  self._id_DB07 = spawnStruct();
  self._id_DB07._id_DCE9 = 0;
  self._id_DB07.target = undefined;
  self._id_DB07.starttime = gettime();
  var_1 = 0.0341;

  for(;;) {
    var_2 = anglesToForward(self.angles);
    var_3 = _id_7DB4();
    var_4 = undefined;
    var_5 = 0;

    foreach(var_7 in var_3) {
      if(!isalive(var_7) || !issentient(var_7) || !isenemyteam(var_0, var_7.team)) {
        continue;
      }
      if(!isDefined(var_7._id_DB08))
        var_7._id_DB08 = 0;

      var_8 = var_7.origin - self.origin;
      var_8 = vectorNormalize(var_8);
      var_9 = vectordot(var_2, var_8);
      var_10 = distance(var_7.origin, self.origin);

      if(var_9 < 0.9659 || var_10 > 30000) {
        var_7._id_DB08 = max(var_7._id_DB08 - 1.0, 0.0);
        continue;
      }

      var_7._id_DB08 = var_7._id_DB08 + (var_9 - 0.9659) / var_1;
      var_7._id_DB08 = var_7._id_DB08 + (1 - var_10 / 30000);
      var_7._id_DB08 = min(40.0, var_7._id_DB08);
    }

    foreach(var_7 in var_3) {
      if(!isalive(var_7) || !issentient(var_7) || !isenemyteam(var_0, var_7.team)) {
        continue;
      }
      if(var_7._id_DB08 > var_5) {
        var_4 = var_7;
        var_5 = var_7._id_DB08;
      }
    }

    if(var_5 > 10.0) {
      if(!isDefined(self._id_DB07.target) || self._id_DB07.target != var_4) {
        self._id_DB07.starttime = gettime();
        var_4._id_DB08 = var_4._id_DB08 + 10.0;
      }

      self._id_DB07.target = var_4;
      self._id_DB07._id_DCE9 = var_5;
    } else {
      self._id_DB07.starttime = 0;
      self._id_DB07.target = undefined;
      self._id_DB07._id_DCE9 = 0;
    }

    wait 0.05;
  }
}

_id_E061(var_0) {
  self._id_AEDF.targeting = 0;
  self._id_AEDF._id_AF21 = 0;
  self._id_AEDF.locked = 0;
  self._id_AEDF._id_11567 = 0;
  self._id_AEDF._id_2A93 = 0;

  if(self._id_AEDF._id_38A4 && self._id_AEDF._id_9405)
    self notify("not_inDogfightRange");

  self _meth_84A0(0);

  if(self._id_AEDF._id_3A5B)
    _id_0B76::_id_F42C(var_0);
}

_id_D18C() {
  self endon("script_death");
  self endon("player_exit_jackal");
  _id_0BDC::_id_137D6();
  self._id_D41F = -99999999;
  var_0 = 0;
  var_1 = 0;
  var_2 = [];

  for(;;) {
    level._id_A056._id_933B = scripts\engine\utility::array_removeundefined(level._id_A056._id_933B);
    var_2 = scripts\engine\utility::array_removeundefined(var_2);
    var_3 = _id_7A32(var_2);

    foreach(var_5 in var_3) {
      if(!scripts\engine\utility::array_contains(var_2, var_5))
        var_5 _id_0BDC::_id_A36B();
    }

    foreach(var_5 in var_2) {
      if(!scripts\engine\utility::array_contains(var_3, var_5))
        var_5 _id_0BDC::_id_A368();
    }

    if(var_3.size > 3) {
      if(!var_1) {
        thread _id_90E8();
        var_1 = 1;
      }
    } else if(var_3.size > 0 && scripts\sp\utility::_id_7B9D() < 0.5) {
      if(!var_1) {
        thread _id_90E7();
        var_1 = 1;
      }
    } else {
      if(var_1) {
        self notify("stop_evade_warning_vo");
        var_1 = 0;
      }

      foreach(var_5 in var_3) {
        var_5 _id_90E9();
        break;
      }
    }

    var_2 = var_3;
    wait 0.25;
  }
}

_id_7A32(var_0) {
  level._id_A056._id_90E3 = scripts\engine\utility::array_removeundefined(level._id_A056._id_90E3);

  foreach(var_2 in var_0) {
    if(!scripts\engine\utility::array_contains(level._id_A056._id_90E3, var_2))
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);

    var_3 = level._id_D127.origin - var_2.origin;

    if(length(var_3) > 25000)
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
  }

  foreach(var_2 in level._id_A056._id_90E3) {
    if(scripts\engine\utility::array_contains(var_0, var_2)) {
      continue;
    }
    var_3 = level._id_D127.origin - var_2.origin;

    if(length(var_3) > 12000) {
      continue;
    }
    var_6 = vectordot(vectorNormalize(var_3), anglesToForward(var_2.angles));

    if(var_6 < 0.1) {
      continue;
    }
    var_0 = scripts\engine\utility::array_add(var_0, var_2);
  }

  return var_0;
}

_id_90E8() {
  self endon("script_death");
  self endon("player_exit_jackal");
  self endon("stop_evade_warning_vo");
  _id_0BDC::_id_A112("jackal_hud_enemy_threat_multiple", 2, 10);
  wait 4;
  thread _id_90E7();
}

_id_90E7() {
  self endon("script_death");
  self endon("player_exit_jackal");
  self endon("stop_evade_warning_vo");
  wait 2;

  for(;;) {
    _id_0BDC::_id_A112("jackal_hud_evade", 3, 15, 0.1);
    wait 3;
  }
}

_id_90E9() {
  if(gettime() - self._blackboard._id_90ED > 3000) {
    var_0 = self.origin - level._id_D127.origin;
    var_1 = vectorNormalize(var_0);
    var_2 = rotatevectorinverted(var_1, level._id_D127.angles);

    if(var_2[0] > 0)
      var_2 = (var_2[0] * 0.8, var_2[1], var_2[2]);

    if(abs(var_2[0]) > abs(var_2[1])) {
      if(var_2[0] > 0) {
        var_1 = "front";

        if(gettime() - level._id_D127._id_D41F > 5000)
          _id_90E6(var_1);
      } else {
        var_1 = "rear";

        if(self._blackboard._id_90EC != var_1)
          _id_90E6(var_1);
      }
    } else if(var_2[1] < 0) {
      var_1 = "right";

      if(self._blackboard._id_90EC != var_1)
        _id_90E6(var_1);
    } else {
      var_1 = "left";

      if(self._blackboard._id_90EC != var_1)
        _id_90E6(var_1);
    }
  }
}

_id_90E6(var_0) {
  switch (var_0) {
    case "front":
      var_1 = "jackal_hud_enemy_threat_12";
      break;
    case "rear":
      var_1 = "jackal_hud_enemy_threat_6";
      break;
    case "left":
      var_1 = "jackal_hud_enemy_threat_9";
      break;
    case "right":
      var_1 = "jackal_hud_enemy_threat_3";
      break;
    default:
      var_1 = "jackal_hud_enemy_threat";
  }

  _id_0BDC::_id_A112(var_1, 1);
  var_2 = gettime();
  self._blackboard._id_90EC = var_0;
  self._blackboard._id_90ED = var_2;
  level._id_D127._id_D41F = var_2;
}

_id_9B0D() {
  if(isDefined(self._blackboard)) {
    self._blackboard._id_90EE = undefined;
    self._blackboard._id_A9D1 = gettime();
  }
}

_id_D18B() {
  self endon("script_death");
  self endon("player_exit_jackal");
  _id_0BDC::_id_137D6();
  var_0 = undefined;
  var_1 = 0;

  for(;;) {
    if(!isDefined(level.player _meth_8473())) {
      return;
    }
    level._id_A056._id_D92C = scripts\engine\utility::array_removeundefined(level._id_A056._id_D92C);
    var_2 = level.player _meth_848A();

    if(!isDefined(var_2) || !isDefined(var_2[0])) {
      self._id_4BC7 = undefined;
      self._id_4BC8 = 0;

      if(isDefined(var_0)) {
        if(isDefined(var_0._id_AEDF) && var_0._id_AEDF._id_2A93) {
          if(isaircraft(var_0)) {
            if(level._id_A056._id_D92C.size == 0) {
              var_3 = var_0._id_AEDF._id_3A5C;
              var_1 = 1;
            } else {
              var_3 = var_0._id_AEDF._id_3A5C;
              var_1 = 0;
            }

            var_0 _id_E061(var_3);
          } else
            var_0 _id_E061(var_0._id_AEDF._id_3A5C);
        } else if(var_1) {
          if(isDefined(var_0._id_AEDF))
            var_0 _id_E061(var_0._id_AEDF._id_3A5C);

          var_1 = 0;
        }

        var_0 = undefined;
      }

      wait 0.05;
      continue;
    } else {
      self._id_4BC7 = var_2[0];
      self._id_4BC8 = var_2[1];

      if(isDefined(var_2[0]._id_AEDF)) {
        if(!var_2[0]._id_AEDF._id_2A93)
          var_2[0]._id_AEDF._id_2A93 = 1;

        if(!var_2[0]._id_AEDF._id_11567) {
          var_2[0]._id_AEDF._id_11567 = 1;
          var_2[0] _id_0B76::_id_F42B(var_2[0]._id_AEDF._id_3782);

          if(!var_2[0]._id_AEDF._id_933E)
            var_2[0] _meth_8558();
        }
      }
    }

    if(isDefined(var_0) && isDefined(var_0._id_AEDF) && var_0 != var_2[0]) {
      var_0 _id_E061(var_0._id_AEDF._id_3A5C);
      var_1 = 0;
    }

    if(var_2[1] == 0) {
      if(isDefined(var_2[0]) && isDefined(var_2[0]._id_AEDF) && !var_2[0]._id_AEDF.targeting) {
        var_2[0] notify("player_is_targeting");
        var_2[0]._id_AEDF.targeting = 1;
        var_2[0]._id_AEDF._id_AF21 = 0;
        var_2[0]._id_AEDF.locked = 0;
      }
    } else if(var_2[1] < 1) {
      if(isDefined(var_2[0]) && isDefined(var_2[0]._id_AEDF) && !var_2[0]._id_AEDF._id_AF21) {
        var_2[0] notify("player_is_locking");
        var_2[0]._id_AEDF.targeting = 0;
        var_2[0]._id_AEDF._id_AF21 = 1;
        var_2[0]._id_AEDF.locked = 0;
      }
    } else if(var_2[1] == 1) {
      if(isDefined(var_2[0]) && isDefined(var_2[0]._id_AEDF) && !var_2[0]._id_AEDF.locked) {
        var_2[0] notify("player_is_locked");
        var_2[0]._id_AEDF.targeting = 0;
        var_2[0]._id_AEDF._id_AF21 = 0;
        var_2[0]._id_AEDF.locked = 1;
      }
    }

    var_0 = var_2[0];
    wait 0.05;
  }
}

_id_D174() {
  self endon("script_death");
  self endon("player_exit_jackal");
  _id_0BDC::_id_137D6();
  var_0 = undefined;
  self._id_C942 = undefined;
  var_1 = 0.04;

  for(;;) {
    while(level.player scripts\sp\utility::_id_65DB("disable_jackal_lockon"))
      wait 0.05;

    level._id_A056._id_C93E = scripts\engine\utility::array_removeundefined(level._id_A056._id_C93E);

    if(isDefined(self._id_C942) && !scripts\engine\utility::array_contains(level._id_A056._id_C93E, self._id_C942))
      self._id_C942 = undefined;

    var_2 = anglesToForward(level._id_D127 gettagangles("tag_camera"));
    var_3 = level._id_A056._id_C93E;
    var_4 = undefined;
    var_5 = 0;

    foreach(var_7 in var_3) {
      var_8 = var_7.origin - self.origin;
      var_9 = length(var_8);
      var_8 = vectorNormalize(var_8);
      var_10 = vectordot(var_2, var_8);

      if(var_10 > 0.96 && var_9 < 30000) {
        var_11 = scripts\sp\math::_id_C097(0.96, 0.995, var_10);
        var_12 = 1 - scripts\sp\math::_id_C097(0, 30000, var_9);
        var_7._id_377E = var_11 * var_12;
      } else
        var_7._id_377E = 0;

      if(var_7._id_377E > var_5) {
        var_4 = var_7;
        var_5 = var_7._id_377E;
      }
    }

    if(isDefined(var_4)) {
      if(isDefined(self._id_C942)) {
        if(self._id_C942 != var_4) {
          self._id_C942 _id_E06A();
          self._id_C942 = var_4;
          self._id_C942 _id_F4B6();
        }
      } else {
        self._id_C942 = var_4;
        self._id_C942 _id_F4B6();
      }
    } else if(isDefined(self._id_C942)) {
      self._id_C942 _id_E06A();
      self._id_C942 = undefined;
    }

    wait 0.05;
  }
}

_id_F4B6() {
  _id_0B76::_id_F42B(self._id_AEDF._id_3782);

  if(self._id_AEDF._id_3A5B)
    self _meth_8558();
}

_id_E06A() {
  self _meth_84A0(0);

  if(self._id_AEDF._id_3A5B)
    _id_0B76::_id_F42C(self._id_AEDF._id_3A5C);
}

waittill_near_struct() {
  self endon("death");

  for(;;) {
    if(!self._id_AEDF.locked) {
      break;
    }

    wait 0.05;
  }
}

_id_13930(var_0) {
  self endon("fd_notify_ace_mode_disengaged");
  var_0 endon("death");

  while(self adsButtonPressed() && !level.player scripts\sp\utility::_id_65DB("disable_jackal_dogfight"))
    wait 0.05;

  self _meth_8464(undefined);
  var_0 notify("dogfight_ads_released");
}

_id_F80C() {
  setsaveddvar("spaceshipLockOnMaxAngleOverride", -1);
}

_id_F6D0() {
  setsaveddvar("spaceshipLockOnMaxAngleOverride", 360);
}

_id_E0EE() {
  setsaveddvar("spaceshipLockOnMaxAngleOverride", -1);
}

_id_58B2(var_0, var_1) {
  level.player._id_58B7 = var_1;
  self notify("fd_notify_ace_mode_engaged", var_1);
  self _meth_8464(var_1);
  var_2 = 0.25;
  var_3 = 0.5;
  var_4 = 1;
  var_5 = 0.0;
  self _meth_8462(var_0, "orient", "time", var_3, 0.0);
  self _meth_8462(var_0, "orient", "time_player", var_5, var_2);
  self _meth_8462(var_0, "moveto", "time", var_4, 0.0);
  self _meth_8462(var_0, "moveto", "time_player", var_5, var_2);
  thread stuck_sled_failsafe(var_1, var_0);
  thread _id_13930(var_1);
  var_6 = var_1 scripts\engine\utility::waittill_any_return("death", "dogfight_disengaged", "dogfight_ads_released", "dogfight_blocked");
  self notify("fd_notify_ace_mode_disengaged");
  level.player._id_58B7 = undefined;
  return var_6;
}

stuck_sled_failsafe(var_0, var_1) {
  self notify("stop_stuck_sled_failsafe");
  self endon("stop_stuck_sled_failsafe");
  self endon("fd_notify_ace_mode_disengaged");
  var_0 endon("death");
  var_1 endon("death");
  wait 0.5;
  var_2 = gettime();

  for(;;) {
    if(isDefined(level._id_D127) && isDefined(level._id_D127.spaceship_vel)) {
      var_3 = length(level._id_D127.spaceship_vel);

      if(var_3 > 30)
        var_2 = gettime();
      else if(gettime() - var_2 > 1000)
        var_0 notify("dogfight_disengaged");
    }

    wait 0.05;
  }
}

_id_87A5(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");

  for(;;) {
    var_0.angles = (var_0.angles[0], var_0.angles[1], var_1.angles[2]);
    scripts\engine\utility::waitframe();
  }
}

_id_5879() {
  self endon("fd_notify_ace_mode_disengaged");
  var_0 = 1.35;
  level.player _meth_8291(1, 0.1, 0.1, var_0, 0.35, 0.6, 0, 20, 30, 30);
  wait(var_0 + 0.5);

  for(;;) {
    level.player _meth_8291(0.2, 0.05, 0.05, 1, 0, 0, 0, 20, 30, 30);

    if(!randomint(5))
      level.player _meth_8291(1.2, 1.1, 1.1, 0.2, 0, 0, 0, 40, 30, 30);

    wait 1;
  }
}

_id_5883(var_0) {
  level._id_D127 endon("script_death");
  var_1 = 65;
  var_2 = 0.75;
  var_3 = 22;
  var_4 = 95;
  var_5 = 2.55;
  var_6 = 1.25;
  var_7 = 0.4;
  thread _id_5879();
  setsaveddvar("spaceshipForceSetFovBlendStrength", var_5 / 2);
  setsaveddvar("spaceshipForceSetFov", var_4);
  wait(var_7);
  level._id_D127 playRumbleOnEntity("heavy_3s");
  setsaveddvar("spaceshipForceSetFov", var_3);
  setsaveddvar("spaceshipForceSetFovBlendStrength", var_5);
  wait(var_2 / 2);
  setsaveddvar("spaceshipForceSetFovBlendStrength", var_5 * 2);
  wait(var_2 / 2);
  wait 0.4;
  setsaveddvar("spaceshipForceSetFovBlendStrength", var_5 / 2);
  setsaveddvar("spaceshipForceSetFov", var_1);
}

_id_F41A() {
  self _meth_8339(1);
  self._id_AEDF._id_9405 = 1;
  thread _id_1396C();
}

_id_F558() {
  _id_F360(1);
  self._id_AEDF._id_D826 = 1;
  thread _id_1396D();
}

_id_1396D() {
  scripts\engine\utility::waittill_either("not_inDogfightRange", "predogfight_disengage");
  _id_F360(0);
  self._id_AEDF._id_D826 = 0;
}

_id_F559(var_0) {
  _id_DFF8();

  if(self._id_D827) {
    return;
  }
  self._id_D827 = 1;
  earthquake(0.22, 0.55, level._id_D127.origin, 5000);
  level.player playRumbleOnEntity("damage_light");
  _id_5894(1);
  _id_F80C();
  var_1 = 0.3;
  var_2 = 3;
  level.player _meth_8462(self._id_4BE7, "lookat", "desires", 1, var_1);
  _id_0BDC::_id_A302(var_2, var_1, "predogfight");
}

_id_E079(var_0) {
  if(!self._id_D827) {
    return;
  }
  self._id_D827 = 0;
  level.player _meth_8462(self, "lookat", "desires", 0, 0);
  level.player _meth_8463("lookat");
  _id_0BDC::_id_A302(1, 0, "predogfight");
  _id_E0EE();
  _id_5894(0);

  if(isDefined(var_0) && var_0)
    _id_588F();
}

_id_1396C() {
  self waittill("not_inDogfightRange");
  self _meth_8339(0);
  self._id_AEDF._id_9405 = 0;
}

_id_58B4() {
  level._id_D127 endon("script_death");
  level._id_D127 endon("player_exit_jackal");
  self._id_4BE7 = undefined;
  self._id_D827 = 0;
  var_0 = getdvarint("spaceshipSpringCameraMaxAngle");
  var_1 = 12000;
  var_1 = var_1 * var_1;
  var_2 = undefined;
  var_3 = 0.0;
  var_4 = [];
  var_4["initial_lockon"] = 0.25;
  var_4["active_lockon"] = 0;
  var_5 = [];
  var_5["initial_lockon"] = 0.766;
  var_5["active_lockon"] = 0.64;
  var_6 = [];
  var_6["initial_lockon"] = var_1;
  var_6["active_lockon"] = var_1 * 1.25;
  var_7 = "initial_lockon";
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  level._id_58C6 = 0;
  var_11 = undefined;

  for(;;) {
    var_12 = self _meth_8473();

    if(isDefined(var_12)) {
      var_10 = gettime();

      if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_dogfight")) {
        var_13 = self _meth_848A();

        if(isDefined(var_13) && var_13[0] _id_3815()) {
          var_11 = var_13[0];
          var_14 = 0;
          var_15 = anglesToForward(level._id_D127.angles);
          var_16 = vectordot(var_15, anglesToForward(var_11.angles));
          var_17 = vectordot(var_15, vectorNormalize(var_11.origin - level._id_D127.origin));

          if(!var_11._id_AEDF._id_9405)
            var_11 _id_F41A();

          if(isDefined(self._id_4BE7) && self._id_4BE7 != var_11) {
            if(self._id_4BE7._id_AEDF._id_D826)
              self._id_4BE7 notify("predogfight_disengage");
          }

          _id_F2F0(var_11, "enemy_dogfight");
          self._id_4BE7 = var_11;

          if(var_13[1] >= 1.0) {
            if(!self._id_4BE7._id_AEDF._id_D826)
              self._id_4BE7 _id_F558();

            _id_F559();
          } else {
            if(self._id_4BE7._id_AEDF._id_D826)
              self._id_4BE7 notify("predogfight_disengage");

            var_18 = level.player adsButtonPressed();
            _id_E079(var_18);
          }

          if(var_16 > 0.5 && var_17 > 0.8)
            var_14 = 1;

          if(var_14 && var_11._id_AEDF._id_D826 && !var_11 _id_0BDC::_id_9C06()) {
            if(scripts\engine\utility::is_true(level._id_A18A))
              thread _id_5883(var_11);
            else {
              var_19 = 65;
              var_20 = 2.55;
              setsaveddvar("spaceshipForceSetFovBlendStrength", var_20 / 2);
              setsaveddvar("spaceshipForceSetFov", var_19);
            }

            var_21 = spawn("script_model", var_12.origin);
            var_21 setModel("tag_origin");
            var_21.angles = var_12.angles;
            level._id_D127._id_58B5 = 1;
            _id_F6D0();

            if(getdvarint("spaceshipDogfightModeUsingPhysics") == 0)
              thread _id_87A5(var_21, var_11);

            setsaveddvar("spaceshipSpringCameraMaxAngle", 10);

            if(!isDefined(level._id_D127._id_58B6)) {
              level._id_D127._id_58B6 = spawn("script_origin", level._id_D127.origin);
              level._id_D127._id_58B6 linkTo(level._id_D127);
              level._id_D127._id_58B6 _meth_8278(0);
            }

            level.player notify("engage boost");
            level._id_D127._id_6ADB = 1;
            _id_0BDC::_id_A0BE();
            thread _id_589E();
            earthquake(0.33, 0.75, level._id_D127.origin, 5000);
            level.player playRumbleOnEntity("damage_heavy");
            var_11 playLoopSound("jackal_sdf_locked_lp");
            level._id_D127._id_58B6 playLoopSound("jackal_plr_locked_lp");
            level.player setsoundsubmix("jackal_dogfight");
            level._id_D127._id_58B6 _meth_8278(1, 1);
            _id_0BDC::_id_A302(0.4, 0.5, "dogfight");
            var_22 = _id_58B2(var_21, var_11);
            _id_0BDC::_id_A302(1, 0.5, "dogfight");
            level._id_A056._id_A976 = gettime();
            self notify("fd_notify_ace_mode_disengaged");
            level.player notify("disengage boost");
            _id_0BDC::_id_A0BE(0);
            level._id_D127._id_6ADB = undefined;
            level.player thread _id_D176(0.0, 0, 0.3, 0.03, 0.3);
            level._id_D127._id_58B6 _meth_8278(0, 1);
            level.player clearsoundsubmix();
            level._id_D127._id_58B6 scripts\engine\utility::delaycall(1, ::stoploopsound, "jackal_plr_locked_lp");

            if(isDefined(var_11)) {
              var_11 stoploopsound("jackal_sdf_locked_lp");
              var_11 notify("predogfight_disengage");
            }

            setsaveddvar("spaceshipForceSetFovBlendStrength", 2);
            setsaveddvar("spaceshipForceSetFov", 0);
            _id_E079();
            setsaveddvar("spaceshipSpringCameraMaxAngle", var_0);
            self _meth_8464(undefined);
            self _meth_8463("moveto");
            self _meth_8463("orient");
            level._id_D127._id_58B5 = 0;

            if(var_22 == "dogfight_disengaged" || var_22 == "dogfight_blocked") {
              _id_588F();

              if(isDefined(var_11))
                var_11 playSound("jackal_sdf_lock_broke");
            }

            _id_587B();
          }
        } else {
          if(isDefined(self._id_4BE7)) {
            self._id_4BE7 notify("not_inDogfightRange");
            self._id_4BE7 notify("predogfight_disengage");
            _id_4146();
          }

          _id_E079();
        }
      }
    }

    wait 0.05;
    var_9 = var_10;
  }
}

_id_589E() {
  self endon("fd_notify_ace_mode_disengaged");
  var_0 = 0.7;
  var_1 = 0.35;
  level.player thread _id_D176(1.0, 0.1, var_0, 0.03, 0.3);
  wait(var_0 + 0.4);
  level.player thread _id_D176(0.33, 0.1, var_0, 0.03, 0.3);
}

_id_588F() {
  setomnvar("ui_jackal_lock_broke", gettime());
  level.player playSound("jackal_dogfight_lockbroke");
  earthquake(0.23, 0.75, level._id_D127.origin, 5000);
  level.player playRumbleOnEntity("damage_light");
}

_id_587B() {
  level.player allowads(0);
  level.player _meth_8490("disable_ads", 1);
  level.player _meth_8490("disable_lockon", 1);
  var_0 = 0;
  var_1 = level.player adsButtonPressed();
  var_2 = 0.2;
  var_3 = 1.6;

  for(;;) {
    var_0 = var_0 + 0.05;

    if(var_1) {
      if(var_0 > var_3) {
        break;
      }
    } else if(var_0 > var_2) {
      break;
    }

    if(!level.player adsButtonPressed() && var_1)
      var_4 = 0;

    wait 0.05;
  }

  if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_ads")) {
    level.player _meth_8490("disable_ads", 0);
    level.player allowads(1);
  }

  if(!level.player scripts\sp\utility::_id_65DB("disable_jackal_lockon"))
    level.player _meth_8490("disable_lockon", 0);
}

_id_5894(var_0) {
  if(!isDefined(var_0))
    var_1 = 1;

  if(var_0 == 1)
    level.player playSound("jackal_dogfight_lockon");

  setomnvar("ui_jackal_dogfight", var_0);
}

_id_3815() {
  if(isDefined(self._id_AEDF) && self._id_AEDF._id_38A4)
    return 1;
  else
    return 0;
}

_id_F2F0(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  if(var_0._id_AEDF._id_3782 == var_1) {
    return;
  }
  if(var_1 == "enemy_dogfight")
    thread _id_1396B(var_0);

  var_0._id_AEDF._id_3782 = var_1;
  var_2 = level.player _meth_848A();

  if(isDefined(var_2) && isDefined(var_2[0]) && var_2[0] == var_0)
    var_0 _id_0B76::_id_F42B(var_0._id_AEDF._id_3782);
}

_id_1396B(var_0) {
  var_0 endon("death");
  self waittill("remove_dogfight_callout_from_targets");
  _id_F2F0(var_0, "enemy_jackal");
}

_id_DFF8() {
  self notify("remove_dogfight_callout_from_targets");
}

_id_4146() {
  if(!isDefined(self._id_4BE7)) {
    return;
  }
  self notify("remove_dogfight_callout_from_targets");
  self._id_4BE7 = undefined;
}

_id_D189() {
  self endon("player_exit_jackal");
  level._id_D127 endon("script_death");
  _id_0BDC::_id_137DA();
  level._id_A056._id_A91D = -99999;
  level._id_A056._id_118DF = randomfloatrange(level._id_A48E._id_A425, level._id_A48E._id_A424);

  for(;;) {
    wait 0.05;

    if(removeteamheadicononnotify(level.player scripts\sp\utility::_id_65DB("disable_jackal_lockon"))) {
      continue;
    }
    if(removeteamheadicononnotify(level.player scripts\sp\utility::_id_65DB("disable_jackal_guns"))) {
      continue;
    }
    if(removeteamheadicononnotify(level.player scripts\sp\utility::_id_65DB("disable_jackal_targetAid"))) {
      continue;
    }
    if(removeteamheadicononnotify(level._id_A056._id_933B.size > 0)) {
      continue;
    }
    if(removeteamheadicononnotify(_id_EF45())) {
      continue;
    }
    if(removeteamheadicononnotify(_id_D39E())) {
      continue;
    }
    if(gettime() - level._id_A056._id_A91D < level._id_A056._id_118DF) {
      continue;
    }
    if(scripts\sp\utility::_id_7B9D() <= 0.5) {
      continue;
    }
    _id_114F4();
  }
}

_id_114F4() {
  if(level.player scripts\sp\utility::_id_65DB("disable_jackal_targetAid_update")) {
    return;
  }
  if(isDefined(level._id_A056._id_4C2C) && isDefined(level._id_A056._id_4C2C[0]))
    level notify("jackal_target_aid_callout", level._id_A056._id_4C2C[1]);
  else {
    var_0 = _id_1423();

    if(isDefined(var_0)) {
      if(isDefined(var_0[1])) {
        level._id_A056._id_4C2C = var_0;
        var_0[0] thread _id_1422();
        level notify("jackal_target_aid_callout", var_0[1]);
      }
    }
  }
}

_id_EF45() {
  if(isDefined(level._id_A056._id_4C2C) && isDefined(level._id_A056._id_4C2C[0]))
    var_0 = 1;
  else
    var_0 = 0;

  return level._id_A056._id_D92C.size > var_0;
}

removeteamheadicononnotify(var_0) {
  if(var_0) {
    _id_1424();
    _id_DAFB();
  }

  return var_0;
}

_id_DAFB(var_0) {
  level._id_A056._id_A91D = gettime();
  level._id_A056._id_118DF = randomfloatrange(level._id_A48E._id_A425, level._id_A48E._id_A424) * 1000;
}

_id_1423() {
  var_0 = 0.9;
  var_1 = 0.74;
  var_2 = 60000;
  var_3 = 120000;
  var_4 = 3;
  var_5 = 2;
  var_6 = 1;
  var_7 = 0;
  var_8 = 100;
  var_9 = 75;
  var_10 = 75;
  var_11 = 30;

  if(isDefined(level._id_A056._id_EF83)) {
    level._id_A056._id_EF83 = scripts\engine\utility::array_removeundefined(level._id_A056._id_EF83);
    var_12 = level._id_A056._id_EF83;
  } else {
    var_12 = level._id_A056.targets;

    foreach(var_14 in var_12) {
      if(!isDefined(var_14) || !isDefined(var_14.script_team) || !isalive(var_14)) {
        var_12 = scripts\engine\utility::array_remove(var_12, var_14);
        continue;
      }

      if(isDefined(var_14._id_C841)) {
        var_12 = scripts\engine\utility::array_remove(var_12, var_14);
        continue;
      }

      if(isDefined(var_14.script_team) && var_14.script_team != "axis")
        var_12 = scripts\engine\utility::array_remove(var_12, var_14);
    }
  }

  if(var_12.size == 0)
    return undefined;

  var_16 = 0;
  var_17 = [];
  var_18 = [];

  foreach(var_14 in var_12) {
    if(var_14.script_team != "axis") {}

    var_20 = 0;
    var_21 = undefined;
    var_22 = _id_0B76::_id_7A60(var_14.origin);

    if(var_22 >= var_0)
      var_20 = var_20 + var_8;
    else if(var_22 >= var_1)
      var_20 = var_20 + var_9;

    var_23 = distance(level._id_D127.origin, var_14.origin);

    if(var_23 <= var_2)
      var_20 = var_20 + var_10;
    else if(var_23 <= var_3)
      var_20 = var_20 + var_11;

    if(issubstr(var_14.classname, "ace")) {
      var_21 = "ace";
      var_20 = var_20 + var_4;
    } else if(issubstr(var_14.classname, "jackal")) {
      var_21 = "skelter";
      var_20 = var_20 + var_5;
    } else if(issubstr(var_14.classname, "missileboat")) {
      var_21 = "missileboat";
      var_20 = var_20 + var_6;
    } else if(issubstr(var_14.classname, "destroyer")) {
      var_21 = "destroyer";
      var_20 = var_20 + var_7;
    }

    if(var_17.size == 0 || var_20 > var_16) {
      var_16 = var_20;
      var_17 = [var_14];
      var_18 = [var_21];
      continue;
    }

    if(var_20 == var_16) {
      var_17[var_17.size] = var_14;
      var_18[var_18.size] = var_21;
    }
  }

  if(var_17.size > 1) {
    var_25 = undefined;
    var_26 = undefined;
    var_27 = undefined;

    foreach(var_29, var_14 in var_17) {
      var_23 = distance(level._id_D127.origin, var_14.origin);

      if(!isDefined(var_25) || var_23 < var_27) {
        var_25 = var_14;
        var_27 = var_23;
        var_26 = var_18[var_29];
      }
    }

    return [var_25, var_26];
  } else
    return [var_17[0], var_18[0]];
}

_id_1422() {
  _id_0BDC::_id_A36D();
}

_id_1424() {
  if(!isDefined(level._id_A056._id_4C2C)) {
    return;
  }
  if(!isDefined(level._id_A056._id_4C2C[0])) {
    level._id_A056._id_4C2C = undefined;
    return;
  }

  level._id_A056._id_4C2C[0] _id_0BDC::_id_A36A();
  level._id_A056._id_4C2C[0] notify("jackal_target_aid_callout_removed");
  level._id_A056._id_4C2C = undefined;
}

_id_D39E() {
  var_0 = level.player _meth_848A();

  if(isDefined(var_0) && isDefined(var_0[0]))
    return 1;

  return 0;
}

_id_FA4F() {
  level._id_D127._id_10A0D = 0;
  _id_1095F();
  thread scripts\sp\specialist_MAYBE::_id_F530(1);
}

_id_10960() {
  level.player notify("jackal_note_hud_off");
  level.player endon("jackal_note_hud_on");
  level.player endon("jackal_note_hud_off");
  level.player scripts\sp\utility::_id_65DD("jackal_hud_on");
  setomnvar("ui_jackal_bootup", 0);
  setomnvar("ui_jackal_callouts_enabled", 0);
  setomnvar("ui_hide_hud", 0);
  setomnvar("ui_active_hud", "infantry");
}

_id_1095F() {
  level._id_A056.targets = scripts\engine\utility::array_removeundefined(level._id_A056.targets);
  level.player scripts\sp\utility::_id_65E1("disable_jackal_lockon");

  foreach(var_1 in level._id_A056.targets)
  var_1 _id_0BDC::_id_105D9();

  setomnvar("ui_jackal_callouts_enabled", 0);

  if(scripts\engine\utility::player_is_in_jackal())
    level.player _meth_8490("disable_lockon", 1);
}