/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3033.gsc
***************************************/

func_622B() {
  func_968C();
  thread func_0BDC::func_1985();
  thread func_0C20::func_7598();
  thread func_0C1A::func_25C5();
  thread func_0C18::func_1EDC();
  thread func_0C24::func_10A49();
  thread func_1049A();
  thread func_104A1();
  thread func_A628();
  func_DEDD();
  self.func_D161 = 1;
  self _meth_8455(self.origin, 1);
}

func_556E() {
  thread func_10493();
  func_0BDC::func_104A6(0);
  self.func_D161 = undefined;
}

func_DEDD() {
  level.func_A056.func_12F96 = scripts\engine\utility::array_add(level.func_A056.func_12F96, self);
}

func_D161(var_00) {
  level.func_D127 = self;
  level.player scripts\sp\utility::func_65E1("jackal_enemy_homing_missile_allowed");
  level.func_A056.func_432C = [];
  func_D17F();
  thread func_D133();
  thread func_0BDC::func_10749();
  thread func_104A9();
  thread func_0BD5::func_D139();
  thread func_0BDD::func_D1A2();
  thread func_0BDB::func_D18D();
  thread func_D175(var_00);
  thread func_D18C();
  thread func_D18B();
  thread func_D174();
  thread func_D128();
  thread func_D19E();
  thread func_D19A();
  thread func_D199();
  thread func_D14F();
  thread func_D19B();
  thread func_D14C();
  thread func_DBA4();
  thread func_D189();
  level.player thread func_D148();
  thread func_0BD1::func_686A();
  func_F381();
  thread func_F5F7();
  func_A318(level.func_A056.func_9B6F);

  if(getdvarint("jackalHandbrakeMode"))
    thread func_D15A();
  else
    thread func_D185();

  level.player scripts\sp\utility::func_65E1("flag_player_has_jackal");
  level.player thread func_58B4();
}

func_F5F7() {
  func_0BDC::func_137DA();
  func_0BDC::func_12DCD(func_0A2F::func_DA02());
}

func_11ABD() {
  for(;;)
    wait 0.1;
}

func_A323() {
  func_F384();

  foreach(var_01 in level.func_A056.func_12F96)
  var_01 _meth_84A1("jackal_un_landing");
}

func_A318(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  level.func_A056.func_9B6F = var_00;

  if(!var_00)
    setomnvar("ui_jackal_show_horizon", 0);
  else
    setomnvar("ui_jackal_show_horizon", 1);

  if(scripts\sp\utility::func_D123())
    level.func_D127 func_A31B();

  func_F383();
}

func_A31B() {
  var_00 = func_A1E7();
  self _meth_84A1(var_00);
}

func_A1E7() {
  var_00 = func_A1E6();
  var_01 = level.vehicle.func_116CE.func_2427[level.func_D127.classname][var_00];

  if(!isDefined(level.func_D127))
    return var_01;

  if(isDefined(level.func_D127.func_5F0D) && level.func_D127.func_5F0D)
    var_02 = "_dualfire";
  else
    var_02 = "";

  if(scripts\sp\utility::func_D15B("thrusters"))
    var_03 = "_thrustperk";
  else
    var_03 = "";

  var_04 = var_01 + var_03 + var_02;
  return var_04;
}

func_A1E6() {
  if(level.func_A056.func_9B6F)
    var_00 = "atmo";
  else
    var_00 = "space";

  return var_00;
}

func_F381() {
  _setsaveddvar("spaceshipLockOnMaxAngleOverride", -1);
  _setsaveddvar("spaceshipHoldTurnSpeedScale", 1);
  _setsaveddvar("trackTrajectory1", 0.1);
  _setsaveddvar("trackTrajectory2", 0.2);
  _setsaveddvar("trackTrajectory3", 0.4);
  _setsaveddvar("trackTrajectory4", 0.7);
  _setsaveddvar("trackTrajectory5", 0.95);
  _setsaveddvar("spaceshipRollOnRightStick", 0);
  _setsaveddvar("spaceshipHoverToFlyPhysicsBlendTime", 2.5);
  _setsaveddvar("spaceshipAllowBoostInHoverMode", 1);
  _setsaveddvar("spaceshipmodeswitchcommand", 3);
  _setsaveddvar("spaceshipBoostStopAngle", 45);
  _setsaveddvar("spaceshipHandBrakeFrictionHover", 0);
  _setsaveddvar("spaceshipHandBrakeFrictionFly", 400);
  _setsaveddvar("spaceshipAim", 1);
  level.func_A056.func_4FEB["spaceshipSpringCameraMaxAngle"] = 25;
  level.func_A056.func_4FEB["spaceshipSpringCameraSpringStrength"] = 5;
  level.func_A056.func_4FEB["spaceshipSpringCameraSpringStrengthOut"] = 5;
  _setsaveddvar("spaceshipSpringCameraMaxAngle", level.func_A056.func_4FEB["spaceshipSpringCameraMaxAngle"]);
  _setsaveddvar("spaceshipSpringCameraSpringStrength", level.func_A056.func_4FEB["spaceshipSpringCameraSpringStrength"]);
  _setsaveddvar("spaceshipSpringCameraSpringStrengthOut", level.func_A056.func_4FEB["spaceshipSpringCameraSpringStrengthOut"]);
  _setsaveddvar("spaceshipUseCodeCameraShakes", 0);
  _setsaveddvar("spaceshipAnalogPhysics", 1);
  _setsaveddvar("spaceshipAutoFlyForward", 0);
  _setsaveddvar("spaceshipBankRollFlyParams", (50, 3, 0.4));
  _setsaveddvar("spaceshipBankRollFlySlowParams", (50, 3, 0.4));
  _setsaveddvar("spaceshipBankRollHoverParams", (25, 3, 0.4));
  _setsaveddvar("spaceshipHoverRollWhileTurningScale", 0);
  _setsaveddvar("spaceshipFlyRollWhileTurningScale", 0);
  _setsaveddvar("spaceshipHeadTranslationOffsets", (5, 5, 2));
  _setsaveddvar("spaceshipHeadTranslationSpringIn", "4.5 0.4");
  _setsaveddvar("spaceshipHeadTranslationSpringOut", "5.0 0.4");
  _setsaveddvar("spaceshipHeadTranslationLinearContribution", 1.0);
  _setsaveddvar("spaceshipHeadTranslationAngularContribution", 0.5);
}

func_F384() {
  _setsaveddvar("spaceshipcollisionEventThreshold", 0);
  _setsaveddvar("spaceshipcollisionflymaxviewkickangle", 40);
  _setsaveddvar("spaceshipcollisionflyminspeedtokickviewMPH", 0);
  _setsaveddvar("spaceshipcollisionminnormalVelocityMPH", 10);
  _setsaveddvar("spaceshipcollisionminspeedtoReboundMPH", 0);
  _setsaveddvar("spaceshipCollisionRestitutionNormal", 1.0);
  _setsaveddvar("spaceshipcollisionrotatetimems", 1100);
  _setsaveddvar("spaceshipCollisionRestitutionInPlane", 1.0);
  _setsaveddvar("spaceshiproll", 2);
  _setsaveddvar("spaceshipModulateRedirectWithDesires", 0);
  _setsaveddvar("spaceshipAutoLevelDelayTime", 0);
}

func_F383() {
  _setsaveddvar("spaceshipAutoLevelDelayTime", 1.2);
  _setsaveddvar("spaceshipcollisionEventThreshold", level.func_A056.func_105E7);
  _setsaveddvar("spaceshipcollisionflymaxviewkickangle", 40);
  _setsaveddvar("spaceshipcollisionflyminspeedtokickviewMPH", 50);
  _setsaveddvar("spaceshipcollisionminnormalVelocityMPH", 30);
  _setsaveddvar("spaceshipcollisionminspeedtoReboundMPH", 20);
  _setsaveddvar("spaceshipCollisionRestitutionNormal", 0.2);
  _setsaveddvar("spaceshipcollisionrotatetimems", 1000);
  _setsaveddvar("spaceshipCollisionRestitutionInPlane", 0.9);
  func_F380();
}

func_F380() {
  var_00 = (1, 3, 0.4);

  if(level.func_A056.func_9B6F) {
    _setsaveddvar("spaceshipMinPhysicsBlendSpeed", 100.0);
    _setsaveddvar("spaceshipMaxPhysicsBlendSpeed", 600.0);
    _setsaveddvar("spaceshipScaleHoverPitchClampForce", 1.0);
    _setsaveddvar("spaceshipScaleFlyPitchClampForce", 0.0);

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_roll")) {
      _setsaveddvar("spaceshipAutoLevelHoverParams", var_00);
      _setsaveddvar("spaceshipAutoLevelFlyParams", var_00);
    } else {
      _setsaveddvar("spaceshipAutoLevelHoverParams", (1, 3, 0.4));
      _setsaveddvar("spaceshipAutoLevelFlyParams", (1, 3, 0.4));
    }

    _setsaveddvar("spaceshipflyRedirectStrafeScale", 0.6);
    _setsaveddvar("spaceshipHoverRedirectStrafeScale", 0.6);
    _setsaveddvar("spaceshipModulateRedirectWithDesires", 0);
  } else {
    _setsaveddvar("spaceshipMinPhysicsBlendSpeed", 67.0);
    _setsaveddvar("spaceshipMaxPhysicsBlendSpeed", 400.0);
    _setsaveddvar("spaceshipScaleHoverPitchClampForce", 0.0);
    _setsaveddvar("spaceshipScaleFlyPitchClampForce", 0.0);

    if(level.player scripts\sp\utility::func_65DB("disable_jackal_roll")) {
      _setsaveddvar("spaceshipAutoLevelHoverParams", var_00);
      _setsaveddvar("spaceshipAutoLevelFlyParams", var_00);
    } else {
      _setsaveddvar("spaceshipAutoLevelFlyParams", (0.3, 0.7, 0.4));
      _setsaveddvar("spaceshipAutoLevelHoverParams", (2, 1, 1));
    }

    _setsaveddvar("spaceshipflyRedirectStrafeScale", 1.0);
    _setsaveddvar("spaceshipHoverRedirectStrafeScale", 1.0);
    _setsaveddvar("spaceshipModulateRedirectWithDesires", 1);
  }

  if(isDefined(level.func_D127) && level.func_D127.spaceship_mode == "hover")
    func_A1D8("hover");
  else
    func_A1D8("fly");

  if(isDefined(level.func_A056.func_BBB9)) {
    level.func_A056.func_BBB9["speed"].func_90F9 = getdvarfloat("spaceshipMinPhysicsBlendSpeed");
    level.func_A056.func_BBB9["speed"].func_90F8 = getdvarfloat("spaceshipMaxPhysicsBlendSpeed");
  }
}

func_D185() {
  self endon("player_exit_jackal");
  var_00 = self.spaceship_mode;
  var_01 = 0.3;
  var_02 = 0.0;
  setdvarifuninitialized("spacehship_mode_swich_speed", 275);
  setdvarifuninitialized("spacehship_mode_swich_speed_space", 113);

  for(;;) {
    var_03 = 0;
    var_04 = 0;
    var_05 = 0;
    var_06 = self.spaceship_mode;

    if(level.func_241D)
      var_07 = getdvarint("spacehship_mode_swich_speed");
    else
      var_07 = getdvarint("spacehship_mode_swich_speed_space");

    var_07 = var_07 * level.func_A056.func_EBAD;
    var_08 = rotatevectorinverted(self.spaceship_vel, self.angles);
    var_09 = var_8[0];

    if(!level.player scripts\sp\utility::func_65DB("jackal_force_mode")) {
      if(!self.spaceship_boosting) {
        if(!level.player scripts\sp\utility::func_65DB("disable_jackal_mode_switch")) {
          if(var_06 == "hover") {
            if(var_09 > var_07 && var_02 == 0)
              var_03 = 1;

            if(var_00 != var_06 && !var_03)
              var_04 = 1;
          } else {
            if(var_09 < var_07 && var_02 == 0)
              var_04 = 1;

            if(var_00 != var_06 && !var_04)
              var_03 = 1;
          }
        }
      } else {
        var_03 = 1;
        var_04 = 0;
      }
    } else if(self.func_72A8 == "fly" && var_06 != self.func_72A8)
      var_03 = 1;
    else if(self.func_72A8 == "hover" && var_06 != self.func_72A8)
      var_04 = 1;
    else if(self.func_72A8 == "land" && var_06 != self.func_72A8)
      var_05 = 1;

    var_02 = var_02 - 0.05;

    if(var_02 < 0)
      var_02 = 0;

    if(var_03) {
      self _meth_8491("fly");
      var_00 = "fly";
      var_02 = var_01;
      func_A1D8("fly");
    }

    if(var_04) {
      self _meth_8491("hover");
      var_00 = "hover";
      var_02 = var_01;
      func_A1D8("hover");
    }

    if(var_05) {
      self _meth_8491("land");
      var_00 = "land";
      var_02 = var_01;
    }

    wait 0.05;
  }
}

func_A1D8(var_00) {
  if(level.player scripts\sp\utility::func_65DB("disable_jackal_roll")) {
    _setsaveddvar("spaceshipAutoLevelDelayTime", 0);
    _setsaveddvar("spaceshiproll", 2);
  } else if(var_00 == "fly") {
    _setsaveddvar("spaceshipAutoLevelDelayTime", 1.2);
    _setsaveddvar("spaceshiproll", 7);
  } else if(level.func_A056.func_9B6F) {
    _setsaveddvar("spaceshipAutoLevelDelayTime", 0);
    _setsaveddvar("spaceshiproll", 2);
  } else {
    _setsaveddvar("spaceshipAutoLevelDelayTime", 1.2);
    _setsaveddvar("spaceshiproll", 7);
  }
}

func_D15A() {
  func_0BDC::func_137DB();
  level.player _meth_8490("disable_mode_switching", 1);
  func_1023D();
  func_0BDC::func_137DB();
  self endon("player_exit_jackal");
  var_00 = self.spaceship_mode;

  for(;;) {
    if(!level.player scripts\sp\utility::func_65DB("disable_jackal_mode_switch") && !level.player scripts\sp\utility::func_65DB("jackal_force_mode")) {
      if(!level.player buttonpressed("button_ltrig")) {
        if(var_00 != "fly") {
          self notify("switchmode");
          thread func_1023A();
          thread func_0BDC::func_DBA5(1, 1);
          var_00 = "fly";
          level.func_D127 _meth_8491("fly");

          if(!level.player scripts\sp\utility::func_65DB("disable_jackal_pilot_assist"))
            level.player _meth_8490("disable_pilot_aim_assist", 0);
        }
      } else if(var_00 != "hover") {
        thread func_0BDC::func_DBA5(0, 1);
        thread func_10239();
        var_00 = "hover";
        level.func_D127 _meth_8491("hover");
        level.player _meth_8490("disable_pilot_aim_assist", 1);
      }
    }

    wait 0.05;
  }
}

func_D12A() {
  self endon("player_exit_jackal");
  func_0BDC::func_A0BE(1);
  wait 1;
  func_0BDC::func_A0BE(0);
}

func_D14F() {
  self endon("player_exit_jackal");
  self.func_6E9C = spawnStruct();
  self.func_6E9C.func_B417 = 3;
  self.func_6E9C.count = self.func_6E9C.func_B417;
  self.func_6E9C.func_12B86 = [];
  self.func_6E9C.func_B88A = 0;
  self.func_6E9C.func_A989 = -999999;
  func_0BDC::func_137DB();
  thread func_B8A7();

  for(;;) {
    while(!level.player secondaryoffhandbuttonpressed() || level.player scripts\sp\utility::func_65DB("disable_jackal_guns") || level.player scripts\sp\utility::func_65DB("disable_jackal_flares"))
      wait 0.05;

    if(self.func_6E9C.count == self.func_6E9C.func_B417) {
      func_D183();
      wait 0.3;
      thread func_D177();
    } else
      func_D150();

    while(level.player secondaryoffhandbuttonpressed())
      wait 0.05;
  }
}

func_D150() {
  level.func_D127 playSound("jackal_flare_empty_plr");
  level.player playrumbleonentity("damage_light");
  wait 0.1;
}

func_D183() {
  self endon("player_exit_jackal");
  self endon("stop_shooting_flares");
  self.func_6E9C.func_A989 = gettime();
  var_00 = self.func_6E9C.func_B88A;

  while(self.func_6E9C.count > 0) {
    thread func_D182(var_00);
    self.func_6E9C.count--;
    wait 0.3;
  }

  self notify("stop_shooting_flares");
}

func_D177() {
  self endon("player_exit_jackal");
  var_00 = self.func_6E9C.func_B417 - self.func_6E9C.count;
  func_D152(var_00);
  func_D151();
  self.func_6E9C.count = self.func_6E9C.func_B417;
}

func_D152(var_00) {
  for(var_01 = 0; var_01 < var_00; var_1++) {
    level.func_D127 playSound("jackal_flares_depleted");
    setomnvar("ui_jackal_flares_recharging", 1);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_jackal_flares_recharging", 0);
    wait 0.7;
  }
}

func_D151() {
  level.func_D127 playSound("jackal_flares_ready");
  setomnvar("ui_jackal_flares_ready", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_jackal_flares_ready", 0);
}

func_D182(var_00) {
  earthquake(0.25, 0.9, level.func_D127.origin, 10000);
  level.player playrumbleonentity("damage_heavy");
  level.func_D127 playSound("jackal_flare_deploy_plr");
  thread func_D181(var_00, -1);
  thread func_D181(var_00, 1);
}

func_106FA(var_00) {
  var_01 = scripts\engine\utility::spawn_tag_origin();
  var_01 func_0BDC::func_F2FF();
  var_1.func_1A89 = 1;
  var_1.active = 1;
  var_1.fx = scripts\engine\utility::getfx("jackal_flare_decoy_plr");
  var_01 thread func_6E91();
  var_01 playLoopSound("jackal_flare_solo_npc");
  var_01 thread func_0BDC::func_6E8C(self);
  var_02 = self gettagorigin("j_mainroot_ship");
  var_03 = self gettagangles("j_mainroot_ship");
  var_04 = (150, 150 * var_00, -200);
  var_05 = anglesToForward(var_03);
  var_06 = anglestoright(var_03);
  var_07 = anglestoup(var_03);
  var_1.origin = var_02 + var_05 * var_4[0] + var_06 * var_4[1] + var_07 * var_4[2];
  var_05 = var_1.origin - var_02;
  var_1.angles = _axistoangles(var_05, var_06, var_07);
  self.func_6E9C.func_12B86 = scripts\engine\utility::array_add(self.func_6E9C.func_12B86, var_01);
  var_1.func_AEBD = var_04;
  return var_01;
}

func_6E91() {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  playFXOnTag(self.fx, self, "tag_origin");
}

func_D181(var_00, var_01) {
  var_02 = 1.7;
  var_03 = var_02;
  var_04 = func_106FA(var_01);
  var_04 endon("death");
  var_05 = var_4.origin;
  var_04 endon("death");
  var_06 = (0, 0, 0);

  if(isDefined(level.func_D127.func_6E97))
    var_07 = level.func_D127.func_6E97;
  else
    var_07 = 1;

  if(isDefined(level.func_D127.func_6E93))
    var_08 = level.func_D127.func_6E93 * var_07;
  else
    var_08 = var_07;

  var_09 = randomfloatrange(0.85, 1.15);
  var_10 = randomfloatrange(0.85, 1.15);
  var_11 = randomfloatrange(0.85, 1.15);

  if(var_00)
    var_12 = (550 * var_09 * var_07, 85 * var_01 * var_10 * var_08, 130 * var_11 * var_07);
  else
    var_12 = (400 * var_09 * var_07, 120 * var_01 * var_10 * var_08, 150 * var_11 * var_07);

  var_13 = 1;
  var_14 = 0;
  var_15 = -5 * var_07;
  var_16 = -50 * var_07;
  var_17 = [self, var_04];
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
    var_4.func_AEBD = var_4.func_AEBD + (var_12 + var_25);
    var_26 = var_19 + var_21 * var_4.func_AEBD[0] + var_23 * var_4.func_AEBD[1] + var_22 * var_4.func_AEBD[2];
    var_27 = var_4.origin - self.spaceship_vel;
    var_28 = self.spaceship_rotvel * 0.05;
    var_29 = rotatevectorinverted(var_4.origin - self.origin, self.angles);
    var_30 = rotatevector(var_29, var_28);
    var_31 = var_30 - var_29;
    var_32 = rotatevector(var_31, self.angles);
    var_27 = var_27 - var_32;
    var_27 = var_27 + var_24;
    var_33 = scripts\sp\math::func_C097(0, var_02, var_03);
    var_33 = scripts\sp\math::func_C09A(var_33);
    var_33 = scripts\sp\math::func_6A8E(0.1, 1, var_33);
    var_34 = scripts\sp\math::func_6A8E(var_27, var_26, var_33);

    if(isDefined(level.func_D127.func_6E8A) && level.func_D127.func_6E8A)
      var_18["fraction"] = 1;
    else
      var_18 = scripts\engine\trace::ray_trace(var_4.origin, var_34, var_17, undefined, 1);

    if(var_18["fraction"] < 1) {
      if(isDefined(var_18["normal"]))
        var_35 = vectortoangles(var_18["normal"]);
      else
        var_35 = var_4.angles;

      var_36 = var_18["position"];
      var_4.origin = var_36;
      var_04 func_0BDC::func_413B();
      stopFXOnTag(var_4.fx, var_04, "tag_origin");
      playFX(scripts\engine\utility::getfx("jackal_flare_impact_plr"), var_36, anglesToForward(var_35), anglestoup(var_35));
      _playworldsound("jackal_flare_impact_plr", var_36);

      for(var_37 = 0; var_37 < 0.5; var_37 = var_37 + 0.05) {
        var_04 notify("pos_updated");
        wait 0.05;
      }

      var_04 notify("burnt_out");
      return;
    }

    var_05 = var_4.origin;
    var_4.origin = var_34;
    var_38 = vectornormalize(var_4.origin - var_05);
    var_39 = anglestoright(var_4.angles);
    var_40 = anglestoup(var_4.angles);
    var_4.angles = _axistoangles(var_38, var_39, var_40);
    var_03 = var_03 - 0.05;
    var_04 notify("pos_updated");

    if(var_03 <= 0) {
      if(var_13 > 0) {
        var_13--;
        playFXOnTag(scripts\engine\utility::getfx("jackal_flare_fizzle_plr"), var_04, "tag_origin");
        continue;
      }

      break;
    }
  }

  var_04 notify("burnt_out");
}

func_13984() {
  self endon("player_exit_jackal");
  self endon("stop_shooting_flares");

  while(level.player secondaryoffhandbuttonpressed())
    wait 0.05;

  self notify("stop_shooting_flares");
}

func_B8A7() {
  self endon("player_exit_jackal");
  self.func_93D2 = [];
  self.func_93D1 = 0;

  for(;;) {
    self waittill("homing_missile_incoming", var_00);
    self.func_93D2 = scripts\engine\utility::array_add(self.func_93D2, var_00);
    thread func_0B76::func_B840();

    if(!self.func_93D1)
      thread func_B8A6();

    self.func_6E9C.func_12B86 = scripts\engine\utility::array_removeundefined(self.func_6E9C.func_12B86);
  }
}

func_B8A5() {
  self notify("new_flare_hint");
  self endon("new_flare_hint");

  if(scripts\engine\utility::flag("jackal_lose_lock_hint")) {
    scripts\engine\utility::flag_clear("jackal_lose_lock_hint");
    wait 0.1;
  }

  while(scripts\engine\utility::flag("jackal_noflare_hint"))
    wait 0.05;

  scripts\engine\utility::flag_set("jackal_flare_hint");
  scripts\sp\utility::func_56BA("jackal_flare_hint");

  while(self.func_6E9C.func_12B86.size == 0 && self.func_93D2.size > 0)
    wait 0.05;

  scripts\engine\utility::flag_clear("jackal_flare_hint");
}

func_B8A6() {
  func_B809();
  thread func_B8A5();

  for(;;) {
    self.func_93D2 = scripts\engine\utility::array_removeundefined(self.func_93D2);

    if(self.func_93D2.size == 0) {
      break;
    }
    wait 0.05;
  }

  self notify("new_flare_hint");

  if(scripts\engine\utility::flag("jackal_flare_hint"))
    scripts\engine\utility::flag_clear("jackal_flare_hint");

  func_B808();
}

func_B809() {
  func_0BDC::func_A112("jackal_hud_incomingmissile", 0.5, 10);
  self.func_93D1 = 1;

  if(!isDefined(level.func_B8B8))
    level.func_B8B8 = thread scripts\engine\utility::play_loopsound_in_space("jackal_missile_incoming", (0, 0, 0));

  setomnvar("ui_jackal_missile_incoming", 1);
  func_0BDC::func_A10C("incoming_missile");
}

func_B808() {
  self.func_93D1 = 0;

  if(isDefined(level.func_B8B8)) {
    level.func_B8B8 stoploopsound("jackal_missile_incoming");
    level.func_B8B8 delete();
  }

  setomnvar("ui_jackal_missile_incoming", 0);
  func_0BDC::func_A10A();
}

func_D14C() {
  self endon("player_exit_jackal");
  level.func_A056.func_67D9 = 0;
  var_00 = (0, 0, 0);
  var_01 = (0, 0, 0);
  var_02 = 0.5;
  var_03 = 1.0;
  var_04 = 0.8;
  var_05 = 0;
  var_06 = 0;
  var_07 = 0;
  var_08 = 0.35;
  var_09 = 0.05;
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

  while(!isDefined(level.func_A056.func_BBB9["speed"].func_6FE8))
    wait 0.05;

  for(;;) {
    waittillframeend;
    var_22 = self.spaceship_rotvel;
    var_23 = self.spaceship_vel;
    var_24 = length(var_23);

    if(length(var_22) > length(var_00))
      var_25 = 1;
    else
      var_25 = 0.3;

    var_14 = scripts\sp\math::func_AB6F(var_14, var_22, var_15);

    if(self.spaceship_mode == "fly") {
      var_26 = length(var_14 - var_22);
      var_26 = scripts\sp\math::func_C097(10, 80, var_26);
      var_26 = var_26 * var_04 * var_25;
    } else
      var_26 = 0;

    if(var_26 > var_05)
      var_27 = var_08;
    else
      var_27 = var_09;

    var_05 = scripts\sp\math::func_AB6F(var_05, var_26, var_27);
    var_28 = anglesToForward(level.func_D127.angles);
    var_29 = vectornormalize(var_23);
    var_30 = 1 - scripts\sp\math::func_C097(0.5, 1, vectordot(var_28, var_29));
    var_30 = var_30 * var_03;

    if(var_30 > var_06)
      var_27 = var_10;
    else
      var_27 = var_11;

    var_06 = scripts\sp\math::func_AB6F(var_06, var_30, var_27);
    var_31 = length(var_01);

    if(var_24 > var_31)
      var_32 = 1.4;
    else
      var_32 = 0.8;

    var_33 = abs(var_24 - var_31);
    var_34 = scripts\sp\math::func_C097(2 * level.func_A056.func_EBAD, 30 * level.func_A056.func_EBAD, var_33);
    var_34 = var_34 * var_02;
    var_34 = var_34 * var_32;

    if(level.func_241D)
      var_34 = var_34 * 1.8;

    if(var_34 > var_07)
      var_27 = var_12;
    else
      var_27 = var_13;

    var_07 = scripts\sp\math::func_AB6F(var_07, var_34, var_27);
    var_35 = scripts\sp\math::func_C097(100 * level.func_A056.func_EBAD, 500 * level.func_A056.func_EBAD, var_24);
    var_35 = scripts\sp\math::func_6A8E(0.2, 1.3, var_35);

    if(var_35 > var_18)
      var_27 = var_16;
    else
      var_27 = var_17;

    var_18 = scripts\sp\math::func_AB6F(var_18, var_35, var_27);

    if(level.func_D127.spaceship_mode == "fly")
      var_36 = 1;
    else
      var_36 = 0.2;

    if(var_36 > var_19)
      var_27 = var_20;
    else
      var_27 = var_21;

    var_19 = scripts\sp\math::func_AB6F(var_19, var_36, var_27);
    var_37 = scripts\sp\math::func_C09B(var_19);
    level.func_A056.func_67D9 = clamp(var_07 + (var_06 + var_05) * var_18, 0, 1) * var_37;
    level.func_A056.func_67D9 = scripts\sp\math::func_6A8E(-1, 1, level.func_A056.func_67D9);
    var_00 = var_22;
    var_01 = var_23;
    wait 0.05;
  }
}

func_D148() {
  self endon("player_exit_jackal");
  level.func_D127.func_58B5 = 0;

  for(;;) {
    self waittill("fd_notify_ace_mode_engaged", var_00);
    self.func_A178 = playFXOnTag(scripts\engine\utility::getfx("jackal_dogfight_cam"), self, "tag_origin");
    self waittill("fd_notify_ace_mode_disengaged");
    var_00 func_F360(0);
    stopFXOnTag(scripts\engine\utility::getfx("jackal_dogfight_cam"), self, "tag_origin");
    self.func_A178 = undefined;
  }
}

func_F360(var_00) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.bt))
    self.var_3135.func_5870 = var_00;

  if(isDefined(self.var_1198))
    self.var_1198.func_9DC2 = var_00;
}

func_D17D() {
  setomnvar("ui_jackal_current_weapon", self.func_4C15.func_13CDF);
  func_D17E();
  self.func_4C15 thread[[self.func_4C15.func_13C1D]]();
}

func_D17E() {
  if(scripts\sp\utility::func_D15B("weapons"))
    var_00 = "_weapupgrade";
  else
    var_00 = "";

  self _meth_849E(self.func_4C15.weapon + var_00);
}

func_D178() {
  self.func_4C15 thread[[self.func_4C15.func_13C08]]();
  self.func_4C15.func_C7F8 = 0;
}

func_D1A0() {
  self playSound(self.func_4C15.func_1136A);
  thread func_D1A1();
}

func_D1A1() {
  self notify("new_cockpit_vo");
  self endon("new_cockpit_vo");
  wait(self.func_4C15.func_134C7);
  func_0BDC::func_A112(self.func_4C15.func_134AE, 0.5);
}

func_4EED() {
  self endon("player_exit_jackal");
  setdvar("scr_givejackal", "none");
  setdvar("scr_jackalDemigod", 0);
  var_00 = getdvar("scr_givejackal");

  for(;;) {
    wait 0.5;

    if(!scripts\sp\utility::func_D123()) {
      continue;
    }
    var_01 = getdvar("scr_givejackal");
    var_01 = tolower(var_01);

    if(var_01 == var_00) {
      continue;
    }
    var_00 = var_01;

    switch (var_00) {
      case "gren":
        func_D157("primary_default");
        break;
      case "dragonfly":
        func_D157("primary_upgrade_1");
        break;
      case "microlite":
        func_D157("primary_upgrade_2");
        break;
      case "pathfinder":
        func_D157("secondary_default");
        break;
      case "cleaver":
        func_D157("secondary_upgrade_1");
        break;
      case "anvil":
        func_D157("secondary_upgrade_2");
        break;
      case "noperk":
        func_0BDC::func_12DCD("none");
        break;
      case "weaponperk":
        func_0BDC::func_12DCD("weapons");
        break;
      case "thrusterperk":
        func_0BDC::func_12DCD("thrusters");
        break;
      case "hullperk":
        func_0BDC::func_12DCD("hull");
        break;
      case "missiles":
        level.func_D127 func_0BDD::func_A2D5();
        break;
    }
  }
}

func_D17F() {
  func_F43C();
  func_F43E();
}

func_F43C() {
  if(!isDefined(self.func_13BF7))
    self.func_13BF7 = func_0BDD::func_A1F8(func_0A2F::func_D9FE());

  setomnvar("ui_jackal_equipped_primary_index", self.func_13BF7.func_12B2A);
}

func_F43E() {
  if(!isDefined(self.func_13BF8))
    self.func_13BF8 = func_0BDD::func_A1F8(func_0A2F::func_DA00());

  setomnvar("ui_jackal_equipped_secondary_index", self.func_13BF8.func_12B2A);
}

func_D19E() {
  self endon("player_exit_jackal");
  level.func_D127.func_5F0D = 0;
  func_0BDC::func_137DB();
  self.func_4C15 = self.func_13BF7;
  self.func_110CA = self.func_13BF8;
  func_1136F();
  func_D17D();
  level.player notifyonplayercommand("jackal_switch_weapons", "+weapnext");

  for(;;) {
    level.player waittill("jackal_switch_weapons");

    if(!level.player scripts\sp\utility::func_65DB("disable_jackal_guns") && !level.player scripts\sp\utility::func_65DB("disable_jackal_weapon_switch")) {
      func_D178();

      if(self.func_4C15 == self.func_13BF7) {
        self.func_4C15 = self.func_13BF8;
        self.func_110CA = self.func_13BF7;

        if(!level.player scripts\sp\utility::func_65DB("disable_jackal_overheat"))
          setomnvar("ui_jackal_weapon_secondary", 1);

        thread func_5D09(0, 1.15);
      } else {
        self.func_4C15 = self.func_13BF7;
        self.func_110CA = self.func_13BF8;

        if(!level.player scripts\sp\utility::func_65DB("disable_jackal_overheat"))
          setomnvar("ui_jackal_weapon_secondary", 0);

        thread func_5D09(0, 1.0);
      }

      func_1136F();
      func_D17D();
      func_D1A0();
      thread func_D19F();
    }
  }
}

func_D19A() {
  self endon("player_exit_jackal");

  for(;;) {
    self waittill("spaceship_weapon_state_change", var_00);

    switch (var_00) {
      case "weapon_drop":
        self playSound("jackal_wpn_mvmt_takeoff");
        thread func_5D09(0, 1.35);
        break;
      case "weapon_raise":
        self playSound("jackal_wpns_up");
        thread func_5D09(0, 1.5);
        break;
      case "silent":
        self waittill("spaceship_weapon_state_change");
    }
  }
}

func_5D09(var_00, var_01) {
  wait(var_00);
  level.player playrumbleonentity("damage_light");
  earthquake(0.1, 0.75, level.func_D127.origin, 20000);
  wait(var_01);
  earthquake(0.13, 0.75, level.func_D127.origin, 20000);
  level.player playrumbleonentity("damage_light");
}

func_D157(var_00) {
  if(!scripts\engine\utility::player_is_in_jackal()) {
    return;
  }
  if(issubstr(var_00, "primary"))
    var_01 = 1;
  else
    var_01 = 0;

  if(level.func_D127.func_4C15.class == "primary") {
    if(var_01) {
      level.func_D127.func_13BF7 = func_0BDD::func_A1F8(var_00);
      level.func_D127 func_729D(level.func_D127.func_13BF7);
    } else {
      level.func_D127.func_13BF8 = func_0BDD::func_A1F8(var_00);
      level.func_D127.func_110CA = level.func_D127.func_13BF8;
    }
  } else if(var_01) {
    level.func_D127.func_13BF7 = func_0BDD::func_A1F8(var_00);
    level.func_D127.func_110CA = level.func_D127.func_13BF7;
  } else {
    level.func_D127.func_13BF8 = func_0BDD::func_A1F8(var_00);
    level.func_D127 func_729D(level.func_D127.func_13BF8);
  }
}

func_729D(var_00) {
  func_D178();
  self.func_4C15 = var_00;
  func_1136F();
  func_D17D();
}

func_1136F() {
  if(isDefined(self.func_4C15.func_105EF))
    _setsaveddvar("spaceshipTargetLockDistanceScale", self.func_4C15.func_105EF);
  else
    _setsaveddvar("spaceshipTargetLockDistanceScale", 1);

  if(isDefined(self.func_4C15.func_105EE))
    _setsaveddvar("spaceshipTargetLockAnglesScale", self.func_4C15.func_105EE * level.func_A48E.func_D3B9);
  else
    _setsaveddvar("spaceshipTargetLockAnglesScale", 1 * level.func_A48E.func_D3B9);

  if(isDefined(self.func_4C15.func_105F0))
    _setsaveddvar("spaceshipTargetLockTimeScale", self.func_4C15.func_105F0);
  else
    _setsaveddvar("spaceshipTargetLockTimeScale", 1);

  if(isDefined(self.func_4C15.func_5F0D) && self.func_4C15.func_5F0D)
    level.func_D127.func_5F0D = 1;
  else
    level.func_D127.func_5F0D = 0;

  level.func_D127 func_A31B();
}

func_D199() {
  self endon("player_exit_jackal");
  func_0BDC::func_137DB();

  while(!isDefined(self.func_110CA))
    wait 0.05;

  var_00 = 0.9;

  for(;;) {
    if(self.func_4C15.func_C7F8)
      self.func_4C15 func_D198(self.func_4C15.func_1167E);
    else
      self.func_4C15 func_D198(self.func_4C15.func_1167C);

    self.func_110CA func_D198(self.func_110CA.func_11680);
    self.func_4C15 func_D197(self.func_4C15.func_A5A3);
    wait 0.05;
  }
}

func_D198(var_00) {
  self.func_2841 = self.func_2841 - var_00;

  if(self.func_2841 < 0)
    self.func_2841 = 0;

  self.func_2844 = self.func_2844 - var_00;

  if(self.func_2844 < 0)
    self.func_2844 = 0;

  setomnvar(self.func_2842, self.func_2841);
  setomnvar(self.func_2843, self.func_2844);

  if(self.func_2841 < 0.55 && self.func_2846 && !self.func_283A)
    func_D193(0);

  if(self.func_2844 < 0.55 && self.func_2849 && !self.func_283D)
    func_D194(0);

  if(self.func_2841 < 0.3 && self.func_283A)
    func_D171(0);

  if(self.func_2844 < 0.3 && self.func_283D)
    func_D172(0);
}

func_D197(var_00) {
  self.func_A5A2 = self.func_A5A2 + var_00;
  self.func_A5A2 = clamp(self.func_A5A2, 0, 1);
}

func_D19F() {
  self endon("jackal_switch_weapons");
  self endon("player_exit_jackal");
  level.player allowads(0);

  while(!level.player _meth_853A())
    wait 0.05;

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_ads"))
    level.player allowads(1);
}

func_D19B() {
  self endon("player_exit_jackal");
  func_0BDC::func_137DB();
  self.func_A929 = -99999;

  for(;;) {
    self waittill("vehicle_turret_fire", var_00);
    var_01 = 1;

    if(isDefined(self.func_4C15.func_5F0D) && self.func_4C15.func_5F0D)
      var_01 = 0;

    self notify("vehicle_turret_fire_passed");
    self.func_4C15 func_D197(self.func_4C15.func_A5A6);
    self.func_4C15 thread[[self.func_4C15.func_6CF8]](var_00);

    if(!self.func_4C15.func_9DF4) {
      self.func_4C15.func_9DF4 = 1;
      thread func_D19C();
    }

    childthread func_D137();
    var_00 = -1 * var_00 + 1;

    if(!level.player scripts\sp\utility::func_65DB("disable_jackal_overheat")) {
      if(var_01) {
        if(var_00) {
          self.func_4C15.func_2841 = self.func_4C15.func_2841 + func_7CF0();

          if(self.func_4C15.func_2841 > 1)
            self.func_4C15.func_2841 = 1;
        } else {
          self.func_4C15.func_2844 = self.func_4C15.func_2844 + func_7CF0();

          if(self.func_4C15.func_2844 > 1)
            self.func_4C15.func_2844 = 1;
        }
      } else {
        self.func_4C15.func_2841 = self.func_4C15.func_2841 + func_7CF0();

        if(self.func_4C15.func_2841 > 1)
          self.func_4C15.func_2841 = 1;

        self.func_4C15.func_2844 = self.func_4C15.func_2844 + func_7CF0();

        if(self.func_4C15.func_2844 > 1)
          self.func_4C15.func_2844 = 1;
      }

      func_D132();
    }
  }
}

func_7CF0() {
  if(scripts\sp\utility::func_D15B("weapons"))
    return self.func_4C15.func_116B3 * 0.8;
  else
    return self.func_4C15.func_116B3;
}

func_D132() {
  var_00 = 0.7;

  if(self.func_4C15.func_2841 > 0.98 && !self.func_4C15.func_283A)
    self.func_4C15 func_D171(1);

  if(self.func_4C15.func_2844 > 0.98 && !self.func_4C15.func_283D)
    self.func_4C15 func_D172(1);

  if(self.func_4C15.func_2841 > 0.55 && !self.func_4C15.func_2846)
    self.func_4C15 func_D193(1);

  if(self.func_4C15.func_2844 > 0.55 && !self.func_4C15.func_2849)
    self.func_4C15 func_D194(1);

  if(self.func_4C15.func_283D && self.func_4C15.func_283A)
    func_D170();
}

func_D193(var_00) {
  self.func_2846 = var_00;
  setomnvar(self.func_2847, var_00);

  if(var_00)
    func_D18F();
}

func_D194(var_00) {
  self.func_2849 = var_00;
  setomnvar(self.func_2848, var_00);

  if(var_00)
    func_D18F();
}

func_D171(var_00) {
  self.func_283A = var_00;
  setomnvar(self.func_283B, var_00);
}

func_D172(var_00) {
  self.func_283D = var_00;
  setomnvar(self.func_283C, var_00);
}

func_D18F() {
  var_00 = gettime();

  if(var_00 - level.func_D127.func_A929 > 16000) {
    func_0BDC::func_A112("jackal_hud_overheating_barrels", 0.5);
    level.func_D127.func_A929 = var_00;
  }
}

func_D170() {
  level.player allowfire(0);
  level.player notify("jackal_stop_firing");
  setomnvar("ui_jackal_weapon_overheat", 1);
  level.func_D127.func_C7FA = scripts\engine\utility::spawn_tag_origin();
  level.func_D127.func_C7FA linkto(level.func_D127, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
  level.func_D127.func_C7FA playLoopSound("jackal_overheat_lp");
  func_0BDC::func_A112("jackal_hud_overheated_generic", 0.5);
  level.func_D127.func_A929 = gettime();
  thread func_D173();
  self.func_4C15.func_C7F8 = 1;

  while(self.func_4C15.func_2841 > 0.3 || self.func_4C15.func_2844 > 0.3)
    wait 0.05;

  scripts\engine\utility::flag_clear("jackal_weapon_switch_hint");
  self notify("self_weapons_cooled");
  level.player allowfire(1);
  setomnvar("ui_jackal_weapon_overheat", 0);
  level.func_D127.func_C7FA stoploopsound("jackal_overheat_lp");
  level.func_D127.func_C7FA delete();
  self.func_4C15.func_C7F8 = 0;
}

func_D173() {
  self endon("self_weapons_cooled");

  while(level.player attackbuttonpressed())
    wait 0.05;

  while(!level.player attackbuttonpressed())
    wait 0.05;

  scripts\engine\utility::flag_set("jackal_weapon_switch_hint");
  scripts\sp\utility::func_56BA("jackal_weapon_switch");
}

func_D137() {
  self endon("vehicle_turret_fire_passed");
  self endon("jackal_switch_weapons");
  self.func_4C15.func_1167C = 0;
  var_00 = self.func_4C15.func_1167F;
  var_01 = self.func_4C15.func_1167D;
  var_02 = var_01 * (0.05 / self.func_4C15.func_1167F);

  while(self.func_4C15.func_1167C < self.func_4C15.func_1167D) {
    self.func_4C15.func_1167C = self.func_4C15.func_1167C + var_02;
    wait 0.05;
  }

  self.func_4C15.func_1167C = self.func_4C15.func_1167D;
}

func_D19C() {
  self endon("player_exit_jackal");
  func_D19D();
  self.func_4C15 thread[[self.func_4C15.func_1106F]]();
  self.func_4C15.func_9DF4 = 0;
}

func_D19D() {
  level.player endon("jackal_switch_weapons");

  while(level.player attackbuttonpressed() && !level.player scripts\sp\utility::func_65DB("disable_jackal_guns"))
    wait 0.05;
}

func_D128() {
  self endon("player_exit_jackal");
  func_0BDC::func_137DB();
  var_00 = 0;
  var_01 = 0.0;
  var_02 = 0.1;
  var_03 = var_02;
  var_04 = 1;

  for(;;) {
    var_05 = level.player playerads();

    if(var_05 > var_01 && !var_00) {
      var_04 = 0.75;
      var_03 = (1 - var_05) * var_02;
      func_0BDC::func_A302(var_04, var_03, "ads");
      var_00 = 1;
    }

    if(var_05 < var_01 && var_00) {
      var_04 = 1.0;
      var_03 = var_05 * var_02;
      func_0BDC::func_A302(var_04, var_03, "ads");
      var_00 = 0;
    }

    var_01 = var_05;
    wait 0.05;
  }
}

func_13C51() {
  wait 0.8;
  level.player playrumbleonentity("damage_light");
  earthquake(0.12, 1, level.func_D127.origin, 5000);
}

func_13C52() {
  wait 1.0;
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.18, 1, level.func_D127.origin, 5000);
}

func_1023D() {
  self.func_10239 = spawnStruct();
  self.func_10239.func_10240 = 0;
  self.func_10239.func_FB87 = scripts\engine\utility::spawn_tag_origin();
  self.func_10239.func_FB87 linkto(self, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
  self.func_FB88 = scripts\engine\utility::array_add(self.func_FB88, self.func_10239.func_FB87);
}

func_DBA4() {
  self.func_DBA2 = spawnStruct();
  self.func_DBA2.func_FB87 = scripts\engine\utility::spawn_tag_origin();
  self.func_DBA2.func_FB87 linkto(self, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
  self.func_DBA2.func_FB87 ghostattack(0, 0);
  self.func_DBA2.func_FB87 playLoopSound("jackal_airbrake_lp");
  self.func_DBA2.func_E7BA = scripts\engine\utility::spawn_tag_origin((100000, 100000, 100000));
  self.func_DBA2.func_E7BA _meth_8244("steady_rumble");
  self.func_DBA2.func_E7BA func_0BDC::func_F2FF();
  self.func_DBA2.func_2B8D = 0;
  self.func_FB88 = scripts\engine\utility::array_add(self.func_FB88, self.func_DBA2.func_FB87);
  self.func_4074 = scripts\engine\utility::array_add(self.func_4074, self.func_DBA2.func_E7BA);
  self.func_74BD = spawnStruct();
  self.func_74BD.func_FB87 = scripts\engine\utility::spawn_tag_origin();
  self.func_74BD.func_FB87 linkto(self, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
  self.func_74BD.func_FB87 ghostattack(0, 0);
  self.func_74BD.func_FB87 playLoopSound("jackal_plr_full_throttle");
  self.engine_master_volume = 0;
  self.func_FB88 = scripts\engine\utility::array_add(self.func_FB88, self.func_74BD.func_FB87);

  if(level.player scripts\sp\utility::func_65DB("disable_jackal_quickturn"))
    self.func_DBA2.func_B3D1 = 0;
  else
    self.func_DBA2.func_B3D1 = 1;

  if(!isDefined(self.func_5509))
    self.func_5509 = 0;

  thread func_DBA3();
}

func_10239() {
  self endon("stop_skid");
  self endon("player_exit_jackal");
  var_00 = 2.2;

  if(!self.func_10239.func_10240) {
    self.func_10239.func_10240 = 1;
    self.func_10239.func_E7BA = scripts\engine\utility::spawn_tag_origin((100000, 100000, 100000));
    self.func_4074 = scripts\engine\utility::array_add(self.func_4074, self.func_10239.func_E7BA);
    self.func_10239.func_E7BA _meth_8244("steady_rumble");
    self.func_10239.func_E7BA func_0BDC::func_F2FF();
  }

  var_01 = scripts\sp\math::func_C097(100, 500, length(self.spaceship_vel));
  var_02 = level.player getsplashtablename();
  var_03 = scripts\sp\math::func_6A8E(0.35, 1, abs(var_2[1]));
  var_04 = var_01 * var_03;
  var_05 = 0.6;
  var_06 = 0.9;
  thread func_1023E(var_04, var_05, var_06);
  thread func_1023F(var_04, var_05, var_06);
  var_07 = scripts\sp\math::func_6A8E(1, var_00, var_01 * var_03);
  func_0BDC::func_A302(var_07, var_05, "skid");
  wait(var_05);
  func_0BDC::func_A302(1, var_06, "skid");
  wait(var_06);
  func_1023B();
}

func_DBA3() {
  self endon("player_exit_jackal");
  var_00 = 2.55;
  var_01 = 0.2;
  var_02 = 0.2;
  var_03 = 0.155;
  var_04 = 0.07;
  var_05 = 0.65;
  var_06 = 0.15;
  var_07 = 1.9;
  var_08 = 1.6;
  var_09 = 0;
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

    var_25 = level.player getsplashtablename();
    var_26 = level.player getnormalizedmovement();
    var_27 = rotatevectorinverted(self.spaceship_vel, self.angles);
    var_27 = var_27[0];

    if(var_27 < 0)
      var_27 = 0;

    var_28 = var_26[0];

    if(var_28 > 0)
      var_29 = scripts\sp\math::func_6A8E(0.5, 0, var_28);
    else
      var_29 = scripts\sp\math::func_6A8E(0.5, 1, abs(var_28));

    var_30 = abs(var_25[1] - var_26[1]) * 0.5;
    var_30 = var_30 * abs(var_25[1]);
    var_18 = scripts\sp\math::func_AB6F(var_18, var_30, var_20);
    var_19 = scripts\sp\math::func_AB6F(var_19, var_29, var_20);
    var_31 = scripts\sp\math::func_C097(150 * var_24, 450 * var_24, var_27);

    if(var_31 > var_14)
      var_14 = scripts\sp\math::func_AB6F(var_14, var_31, 0.35);
    else
      var_14 = scripts\sp\math::func_AB6F(var_14, var_31, 0.1);

    var_32 = var_19 * self.func_DBA2.func_B3D1 * abs(var_18) * var_14 * var_24;
    var_33 = scripts\sp\math::func_6A8E(1, var_00, var_32);
    level.func_A056.func_BBB9["turn"].func_3C66["quickturn_scale"] = var_33;
    var_34 = var_27;
    var_35 = var_32;
    var_35 = clamp(var_35, 0, 1) * self.func_DBA2.func_B3D1;
    var_36 = scripts\sp\math::func_6A8E(0, var_07, var_35);
    var_37 = scripts\sp\math::func_6A8E(1.1, 0.8, var_35);
    var_38 = scripts\sp\math::func_6A8E(0.0, var_03, var_35);
    var_39 = var_35 * var_05;
    var_36 = var_36 * self.engine_master_volume;

    if(var_36 > 0.25) {
      if(var_23 == 0) {
        level.player playSound("jackal_airbrake_init");
        var_23 = 1;
      }

      self.func_DBA2.func_FB87 ghostattack(var_36, 0.05);
    } else {
      var_23 = 0;
      self.func_DBA2.func_FB87 ghostattack(0, 0.05);
    }

    self.func_DBA2.func_FB87 _meth_8277(var_37, 0.05);
    var_40 = scripts\sp\math::func_C097(0, 1, var_26[0]);

    if(var_10 < var_40)
      var_41 = var_01;
    else
      var_41 = var_02;

    var_10 = scripts\sp\math::func_AB6F(var_10, var_40, var_41);
    var_11 = scripts\sp\math::func_AB6F(var_11, var_34, 0.1);
    var_31 = scripts\sp\math::func_C097(175, 330, var_11);
    var_31 = scripts\sp\math::func_6A8E(1, 0.4, var_31);
    var_42 = var_10 * var_31 * self.func_DBA2.func_B3D1;
    var_36 = scripts\sp\math::func_6A8E(0, var_08, var_42);
    var_37 = scripts\sp\math::func_6A8E(0.8, 1.4, var_42);
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

    self.func_74BD.func_FB87 ghostattack(var_36, 0.05);
    self.func_74BD.func_FB87 _meth_8277(var_37, 0.05);
    var_43 = var_42 * var_04 * self.func_DBA2.func_B3D1;
    var_44 = var_42 * var_06 * self.func_DBA2.func_B3D1;

    if(self.spaceship_boosting || isDefined(self.func_6ADB)) {
      var_45 = 0.6;
      var_46 = 0.0;

      if(!var_17 && !self.func_5509) {
        var_17 = 1;
        thread func_D12D();
        func_0BDC::func_A302(0.85, 0.3, "boost");
      }
    } else {
      var_46 = clamp(var_38 + var_43, 0.0, 1);
      var_45 = clamp(var_39 + var_44, 0, 1);

      if(var_17) {
        var_17 = 0;
        thread func_D12C();
        func_0BDC::func_A302(1.0, 0.5, "boost");
      }
    }

    var_47 = scripts\sp\math::func_6A8E(1000, 0, var_45);
    self.func_DBA2.func_E7BA.origin = level.func_D127.origin + (0, 0, var_47);

    if(isDefined(self.func_2CD0))
      var_46 = self.func_2CD0;

    if(var_46 > 0)
      earthquake(var_46, 0.1, level.func_D127.origin, 5000);

    if(self.func_DBA2.func_2B8D) {
      self waittill("quickturn_master_blend_complete");
      continue;
    }

    level.player waittill("on_player_update");
  }
}

func_D176(var_00, var_01, var_02, var_03, var_04) {
  self notify("jackalradialBlurLerp");
  self endon("jackalradialBlurLerp");
  self endon("player_exit_jackal");

  if(!isDefined(var_03))
    var_03 = 0.05;

  if(!isDefined(var_04))
    var_04 = 0.1;

  var_05 = 0.05;
  var_00 = clamp(var_00, 0.0, 1.0);

  if(!isDefined(self.func_DBE5))
    self.func_DBE5 = 0.0;

  var_06 = abs(self.func_DBE5 - var_00);
  var_07 = int(var_02 / var_05);

  if(var_07 == 0)
    var_07 = 1;

  var_08 = var_06 / var_07;
  wait(var_01);

  while(self.func_DBE5 != var_00) {
    var_7--;

    if(!var_07)
      self.func_DBE5 = var_00;

    if(self.func_DBE5 < var_00)
      self.func_DBE5 = min(var_00, self.func_DBE5 + var_08);
    else
      self.func_DBE5 = max(var_00, self.func_DBE5 - var_08);

    _setsaveddvar("r_mbRadialOverrideStrength", var_03 * self.func_DBE5);
    _setsaveddvar("r_mbRadialOverrideRadius", 1.0 - 0.8 * self.func_DBE5);
    _setsaveddvar("r_mbRadialOverrideDistortion", var_04 * self.func_DBE5);
    wait(var_05);
  }
}

func_D12D() {
  self endon("boost_fx_off");
  self notify("boost_fx_on");
  self endon("player_exit_jackal");
  scripts\sp\utility::func_75C4("jackal_boost_speed", "tag_origin");
  thread func_DC5E();

  if(!scripts\engine\utility::is_true(level.func_D127.func_6ADB))
    level.player thread func_D176(0.8, 0, 0.4, 0.01, 0.3);
}

func_DC5E() {
  self endon("boost_fx_off");
  self.func_2CD0 = 0.34;
  var_00 = 0.15;

  while(self.func_2CD0 > var_00) {
    self.func_2CD0 = self.func_2CD0 - 0.02;
    wait 0.05;
  }

  self.func_2CD0 = var_00;
}

func_D12C() {
  self endon("boost_fx_on");
  self notify("boost_fx_off");
  scripts\sp\utility::func_75F8("jackal_boost_speed", "tag_origin");
  self.func_2CD0 = undefined;

  if(!scripts\engine\utility::is_true(level.func_D127.func_6ADB))
    level.player func_D176(0.0, 0, 0.2, 0.01, 0.3);

  _setsaveddvar("spaceshipRadialMotionBlurMaxStrength", 0.0);
  _setsaveddvar("spaceshipRadialMotionBlurMaxRadius", 0.0);
}

func_1023A() {
  self endon("start_skid");
  self notify("stop_skid");

  if(!self.func_10239.func_10240) {
    return;
  }
  var_00 = 0.25;
  func_0BDC::func_A302(1, var_00, "skid");
  self.func_10239.func_FB87 ghostattack(0, var_00);

  for(var_01 = var_00; var_01 > 0; var_01 = var_01 - 0.05) {
    var_02 = scripts\sp\math::func_6A8E(0, 1, var_01 / var_00);
    var_03 = 1 - var_02;
    var_03 = var_03 * 1000;
    self.func_10239.func_E7BA.origin = level.func_D127.origin + (0, 0, var_03);
    wait 0.05;
  }

  func_1023B();
}

func_1023B() {
  self.func_10239.func_10240 = 0;
  self.func_4074 = scripts\engine\utility::array_remove(self.func_4074, self.func_10239.func_E7BA);
  self stoprumble("steady_rumble");
  self.func_10239.func_E7BA delete();
}

func_1023E(var_00, var_01, var_02) {
  var_01 = var_01 * 0.7;
  var_02 = var_02 * 0.7;
  self notify("start_skid");
  self endon("stop_skid");
  self endon("player_exit_jackal");
  var_03 = scripts\sp\math::func_6A8E(0.08, 0.32, var_00);
  var_04 = var_00;
  var_05 = var_01 + var_02;

  for(var_06 = 0.05; var_05 > 0; var_05 = var_05 - var_06) {
    if(var_05 > var_02)
      var_07 = 1 - scripts\sp\math::func_C097(0, var_01, var_05 - var_02);
    else
      var_07 = scripts\sp\math::func_C097(0, var_02, var_05);

    var_08 = scripts\sp\math::func_6A8E(0, var_03, var_07);
    var_09 = scripts\sp\math::func_6A8E(0, var_04, var_07);
    earthquake(var_08, 0.1, level.func_D127.origin, 5000);
    var_10 = 1 - var_09;
    var_10 = var_10 * 1000;
    self.func_10239.func_E7BA.origin = level.func_D127.origin + (0, 0, var_10);
    level.player waittill("on_player_update");
  }
}

func_1023F(var_00, var_01, var_02) {
  var_03 = 0.3;
  var_04 = scripts\sp\math::func_6A8E(0.2, 1.0, var_00);
  var_05 = scripts\sp\math::func_6A8E(0.6, 1.1, var_00);
  self.func_10239.func_FB87 ghostattack(var_04, 0.1);
  self.func_10239.func_FB87 _meth_8277(var_05, 0.1);
  self.func_10239.func_FB87 playSound("jackal_skid");
  wait(var_01 + var_02 - var_03);

  if(isDefined(self) && isDefined(self.func_10239) && isDefined(self.func_10239.func_FB87))
    self.func_10239.func_FB87 ghostattack(0, 1);
}

func_968C() {
  if(!isDefined(self.func_11488))
    func_0BDC::func_F5BD("vtol");

  if(!isDefined(self.func_A7C1))
    func_0BDC::func_F448("instant");

  if(!isDefined(self.func_BBEB))
    func_0BDC::func_F48D("default_landed");

  if(!isDefined(self.func_56A4))
    func_0BDC::func_F358("default_landed");
}

func_A382() {
  self endon("player_exit_jackal");
  level.func_A056.func_10991 = [];

  for(;;) {
    level waittill("notify_new_jackal_speed_zone");

    if(level.func_A056.func_10991.size > 0 && level.func_A056.func_1C6C) {
      func_0BDC::func_A301(level.func_A056.func_10991[0].func_EEBF, level.func_A056.func_10991[0].func_ED75, "triggered");
      continue;
    }

    func_0BDC::func_A301(1, 2, "triggered");
  }
}

func_7D0B(var_00) {
  var_01 = 1;

  foreach(var_04, var_03 in var_00)
  var_01 = var_01 * var_03;

  return var_01;
}

func_7D0C(var_00) {
  var_01 = (0, 0, 0);

  foreach(var_03 in var_00)
  var_01 = var_01 + var_03;

  return var_01;
}

func_104A9() {
  self endon("player_exit_jackal");
  thread func_A382();

  if(!isDefined(level.func_A056.func_BBB9)) {
    level.func_A056.func_BBB9 = [];
    level.func_A056.func_BBB9["speed"] = spawnStruct();
    level.func_A056.func_BBB9["turn"] = spawnStruct();
    level.func_A056.func_BBB9["boost"] = spawnStruct();
    level.func_A056.func_BBB9["weapKick"] = spawnStruct();
    level.func_A056.func_BBB9["force"] = spawnStruct();
    level.func_A056.func_BBB9["ship_rotate"] = spawnStruct();
    level.func_A056.func_BBB9["view_rotate"] = spawnStruct();
    level.func_A056.func_BBB9["speed"].func_6FE8 = getdvarfloat("spaceshipFlySpeedScale");
    level.func_A056.func_BBB9["speed"].func_90CA = getdvarfloat("spaceshipHoverSpeedScale");
    level.func_A056.func_BBB9["speed"].func_A4B7 = getdvarfloat("spaceshipJukeStrengthScale");
    level.func_A056.func_BBB9["speed"].func_90F9 = getdvarfloat("spaceshipMinPhysicsBlendSpeed");
    level.func_A056.func_BBB9["speed"].func_90F8 = getdvarfloat("spaceshipMaxPhysicsBlendSpeed");
    level.func_A056.func_BBB9["turn"].func_12996 = getdvarfloat("spaceshipTurnSpeedScale");
    level.func_A056.func_BBB9["boost"].func_2CB3 = getdvarfloat("spaceshipBoostSpeedScale");
    level.func_A056.func_BBB9["force"].func_729A = _getdvarvector("spaceshipAddVelocity");
    level.func_A056.func_BBB9["force"].func_1189B = 0;
    level.func_A056.func_BBB9["ship_rotate"].func_E748 = _getdvarvector("spaceshipAddViewRotVelocity");
    level.func_A056.func_BBB9["ship_rotate"].func_1189B = 0;
    level.func_A056.func_BBB9["view_rotate"].func_E748 = _getdvarvector("spaceshipAddshipRotVelocity");
    level.func_A056.func_BBB9["view_rotate"].func_1189B = 0;
    level.func_A056.func_BBB9["weapKick"].func_3C66 = [];
    level.func_A056.func_BBB9["weapKick"].func_3C66["weapKick"] = 1;
  } else {
    _setsaveddvar("spaceshipHoverSpeedScale", level.func_A056.func_BBB9["speed"].func_90CA);
    _setsaveddvar("spaceshipFlySpeedScale", level.func_A056.func_BBB9["speed"].func_6FE8);
    _setsaveddvar("spaceshipJukeStrengthScale", level.func_A056.func_BBB9["speed"].func_A4B7);
    _setsaveddvar("spaceshipMinPhysicsBlendSpeed", level.func_A056.func_BBB9["speed"].func_90F9);
    _setsaveddvar("spaceshipMaxPhysicsBlendSpeed", level.func_A056.func_BBB9["speed"].func_90F8);
    _setsaveddvar("spaceshipTurnSpeedScale", level.func_A056.func_BBB9["turn"].func_12996);
    _setsaveddvar("spaceshipBoostSpeedScale", level.func_A056.func_BBB9["boost"].func_2CB3);
    _setsaveddvar("spaceshipAddVelocity", level.func_A056.func_BBB9["force"].func_729A);
    _setsaveddvar("spaceshipAddViewRotVelocity", level.func_A056.func_BBB9["ship_rotate"].func_E748);
    _setsaveddvar("spaceshipAddshipRotVelocity", level.func_A056.func_BBB9["view_rotate"].func_E748);
  }

  level.func_A056.func_BBB9["speed"].func_3C66 = [];
  level.func_A056.func_BBB9["turn"].func_3C66 = [];
  level.func_A056.func_BBB9["boost"].func_3C66 = [];
  level.func_A056.func_BBB9["force"].func_3C66 = [];
  level.func_A056.func_BBB9["ship_rotate"].func_3C66 = [];
  level.func_A056.func_BBB9["view_rotate"].func_3C66 = [];
  var_00 = level.func_A056.func_BBB9["speed"].func_90CA;
  var_01 = level.func_A056.func_BBB9["speed"].func_6FE8;
  var_02 = level.func_A056.func_BBB9["speed"].func_A4B7;
  var_03 = level.func_A056.func_BBB9["speed"].func_90F9;
  var_04 = level.func_A056.func_BBB9["speed"].func_90F8;
  var_05 = level.func_A056.func_BBB9["turn"].func_12996;
  var_06 = level.func_A056.func_BBB9["boost"].func_2CB3;
  var_07 = level.func_A056.func_BBB9["force"].func_729A;
  var_08 = level.func_A056.func_BBB9["ship_rotate"].func_E748;
  var_09 = level.func_A056.func_BBB9["view_rotate"].func_E748;
  var_10 = level.func_A056.func_2CAD;
  var_11 = level.func_A056.func_6F90;
  var_12 = var_11;

  for(;;) {
    wait 0.05;
    waittillframeend;
    var_13 = func_7D0B(level.func_A056.func_BBB9["speed"].func_3C66);
    var_14 = func_7D0B(level.func_A056.func_BBB9["turn"].func_3C66);
    var_15 = func_7D0B(level.func_A056.func_BBB9["boost"].func_3C66);
    var_16 = level.func_A056.func_BBB9["speed"].func_90CA;
    var_17 = level.func_A056.func_BBB9["speed"].func_6FE8;
    var_18 = level.func_A056.func_BBB9["speed"].func_A4B7;
    var_19 = level.func_A056.func_BBB9["turn"].func_12996;
    var_20 = level.func_A056.func_BBB9["boost"].func_2CB3;
    var_21 = level.func_A056.func_BBB9["speed"].func_90F9;
    var_22 = level.func_A056.func_BBB9["speed"].func_90F8;

    if(level.func_A056.func_1C54) {
      var_16 = var_16 * var_13;
      var_17 = var_17 * var_13;
      var_18 = var_18 * var_13;
      var_21 = var_21 * var_13;
      var_22 = var_22 * var_13;
      level.func_A056.func_EBAD = var_13;
    } else
      level.func_A056.func_EBAD = 1;

    if(level.func_A056.func_1C6D) {
      var_19 = var_19 * var_14;
      level.func_A056.func_EBAE = var_14;
    }

    if(level.func_A056.func_1C3C)
      var_20 = var_20 * var_15;

    var_11 = var_13 * level.func_A056.func_6F90;
    var_10 = var_15 * level.func_A056.func_2CAD;

    if(var_10 > var_11)
      var_23 = var_10;
    else
      var_23 = var_11;

    var_24 = func_7D0C(level.func_A056.func_BBB9["force"].func_3C66);
    var_25 = func_7D0C(level.func_A056.func_BBB9["ship_rotate"].func_3C66);
    var_26 = func_7D0C(level.func_A056.func_BBB9["view_rotate"].func_3C66);

    if(var_00 != var_16) {
      _setsaveddvar("spaceshipHoverSpeedScale", var_16);
      var_00 = var_16;
    }

    if(var_01 != var_17) {
      _setsaveddvar("spaceshipFlySpeedScale", var_17);
      var_01 = var_17;
    }

    if(var_06 != var_20) {
      _setsaveddvar("spaceshipBoostSpeedScale", var_20);
      var_06 = var_20;
    }

    if(var_03 != var_21) {
      _setsaveddvar("spaceshipMinPhysicsBlendSpeed", var_21);
      var_03 = var_21;
    }

    if(var_04 != var_22) {
      _setsaveddvar("spaceshipMaxPhysicsBlendSpeed", var_22);
      var_04 = var_22;
    }

    if(var_02 != var_18) {
      _setsaveddvar("spaceshipJukeStrengthScale", var_18);
      var_02 = var_18;
    }

    if(var_05 != var_19) {
      _setsaveddvar("spaceshipTurnSpeedScale", var_19);
      var_05 = var_19;
    }

    if(var_07 != var_24) {
      _setsaveddvar("spaceshipAddVelocity", var_24);
      var_07 = var_24;
    }

    if(var_08 != var_25) {
      _setsaveddvar("spaceshipAddViewRotVelocity", var_25);
      var_08 = var_25;
    }

    if(var_09 != var_26) {
      _setsaveddvar("spaceshipAddshipRotVelocity", var_26);
      var_09 = var_26;
    }

    if(var_12 != var_23) {
      _setsaveddvar("spaceshipForceMinForwardSpeed", var_23);
      var_12 = var_23;
    }
  }
}

func_D133() {
  self.func_4074 = [];
  self.func_FB88 = [];
  wait 0.05;
  func_0BDC::func_137DB();
  func_0BDC::func_137D9();

  foreach(var_01 in self.func_4074)
  var_01 delete();

  objective_delete(scripts\sp\utility::func_C264("jackal_dogfight"));

  if(isDefined(level.player.func_A178)) {
    stopFXOnTag(scripts\engine\utility::getfx("jackal_dogfight_cam"), level.player, "tag_origin");
    level.player.func_A178 = undefined;
  }

  foreach(var_04 in self.func_FB88)
  var_04 thread func_6A96();
}

func_6A96() {
  self endon("death");
  var_00 = 1;
  self ghostattack(0, var_00);
  wait(var_00);
  self delete();
}

func_A628() {
  wait 0.1;
  self notify("nodeath_thread");
}

func_104A1() {
  func_0BDC::func_F420();
  func_0BDC::func_104A6(1);
}

func_1049C() {
  self notify("end_jackal_interact");
  thread func_1049F();

  if(!self.func_99F5.func_AB4B && !self.func_99F5.func_E526) {
    return;
  }
  if(self.func_99F5.func_AB4B && self.func_99F5.func_E526)
    func_1049D();
  else
    func_1049E();
}

func_1049D() {
  self endon("end_jackal_interact");
  self endon("entitydeleted");
  self endon("player_exit_jackal");
  self.func_99F5.func_BBE7 = "";
  var_00 = 0;
  var_01 = var_00;

  for(;;) {
    var_02 = rotatevectorinverted(vectornormalize(level.player.origin - self.origin), self.angles);

    if(var_2[1] > 0) {
      if(self.func_99F5.func_AB4B)
        var_03 = "left";
      else
        var_03 = "";

      var_04 = 48;
    } else {
      var_03 = "right";
      var_04 = -48;
    }

    var_05 = level.player.origin[2] - (self.origin[2] + self.func_99F5.height);

    if(var_05 > 40 || level.player getstance() == "prone")
      var_00 = 1;
    else
      var_00 = 0;

    if(self.func_99F5.func_BBE7 != var_03 || var_01 != var_00) {
      func_104AA(var_04, var_00);
      self.func_99F5.func_BBE7 = var_03;
      var_01 = var_00;
    }

    wait 0.3;
  }
}

func_1049E() {
  if(self.func_99F5.func_AB4B) {
    var_00 = "left";
    var_01 = 48;
  } else {
    var_00 = "right";
    var_01 = -48;
  }

  func_104AA(var_01);
  self.func_99F5.func_BBE7 = var_00;
}

func_104AA(var_00, var_01) {
  if(isDefined(var_01) && var_01)
    var_02 = 1;
  else
    var_02 = self.func_99F5.func_12FC3;

  func_0E46::func_DFE3();
  func_0E46::func_48C4("tag_body", (230, var_00, self.func_99F5.height), undefined, self.func_99F5.func_56B6, self.func_99F5.draw_distance, var_02);
}

func_1049B() {
  self notify("end_jackal_interact");
  func_0E46::func_DFE3();
}

func_1049F() {
  self notify("new_interact_trigger");
  self endon("new_interact_trigger");
  self endon("end_jackal_interact");
  self endon("player_exit_jackal");
  self waittill("trigger");
  thread func_0BDB::func_F51F();
}

#using_animtree("jackal");

func_1049A() {
  self endon("death");
  func_0BDC::func_A144();
  self _meth_848E(1);
  wait 0.05;
  func_0BDC::func_A208();
  func_0BDC::func_A2DE();
  self give_attacker_kill_rewards( % jackal_vehicle_strike_state_idle, 1, 0);
  self give_attacker_kill_rewards( % jackal_vehicle_weap_primary_raise, 1, 0);
  self give_attacker_kill_rewards( % jackal_vehicle_weap_primary_drop, 0, 0);
  self _meth_82B0( % jackal_vehicle_weap_primary_raise, 0);
  self _meth_82B1( % jackal_vehicle_weap_primary_raise, 0);

  if(!isDefined(self.func_6B4E))
    func_0BDC::func_6B4C("landed_mode");
  else {
    var_00 = self.func_6B4E;
    func_0BDC::func_6B4D();
    func_0BDC::func_6B4C(var_00);
  }

  func_0BDC::func_A0AF();
}

func_10493() {
  self _meth_848E(0);
  wait 0.05;

  if(isDefined(self.func_6B4E)) {
    func_0C18::func_1EDC();
    self.anims.state = "none";
    func_0BDC::func_6B4C(self.func_6B4E);
  }
}

func_7DB4() {
  var_00 = func_0BCE::func_7DB5();
  var_01 = level.func_90E2.func_5084;

  foreach(var_03 in var_01) {
    if(_isaircraft(var_03)) {
      continue;
    }
    var_0[var_0.size] = var_03;
  }

  return var_00;
}

func_D16E() {
  self endon("player_exit_jackal");

  if(!isDefined(level.func_A056.func_E1A6)) {
    level.func_A056.func_E1A6 = [];
    level.func_A056.func_E1A5 = 0;
  }

  var_00 = 5000;

  for(;;) {
    if(level.func_A056.func_E1A6.size > 0) {
      var_01 = self.origin;
      var_02 = self.spaceship_vel;

      if(length(var_02) > 5) {
        var_03 = vectornormalize(var_02);
        var_04 = self.origin + var_03 * var_00;
        var_05 = bulletTrace(var_01, var_04, 1, self);

        if(var_5["fraction"] < 1)
          level.func_D127.func_C2CB = 1;
        else
          level.func_D127.func_C2CB = 0;
      } else
        level.func_D127.func_C2CB = 0;
    }

    wait 0.05;
  }
}

func_D175(var_00) {
  self endon("script_death");
  self endon("player_exit_jackal");
  self.func_DB07 = spawnStruct();
  self.func_DB07.func_DCE9 = 0;
  self.func_DB07.target = undefined;
  self.func_DB07.starttime = gettime();
  var_01 = 0.0341;

  for(;;) {
    var_02 = anglesToForward(self.angles);
    var_03 = func_7DB4();
    var_04 = undefined;
    var_05 = 0;

    foreach(var_07 in var_03) {
      if(!isalive(var_07) || !issentient(var_07) || !isenemyteam(var_00, var_7.team)) {
        continue;
      }
      if(!isDefined(var_7.func_DB08))
        var_7.func_DB08 = 0;

      var_08 = var_7.origin - self.origin;
      var_08 = vectornormalize(var_08);
      var_09 = vectordot(var_02, var_08);
      var_10 = distance(var_7.origin, self.origin);

      if(var_09 < 0.9659 || var_10 > 30000) {
        var_7.func_DB08 = max(var_7.func_DB08 - 1.0, 0.0);
        continue;
      }

      var_7.func_DB08 = var_7.func_DB08 + (var_09 - 0.9659) / var_01;
      var_7.func_DB08 = var_7.func_DB08 + (1 - var_10 / 30000);
      var_7.func_DB08 = min(40.0, var_7.func_DB08);
    }

    foreach(var_07 in var_03) {
      if(!isalive(var_07) || !issentient(var_07) || !isenemyteam(var_00, var_7.team)) {
        continue;
      }
      if(var_7.func_DB08 > var_05) {
        var_04 = var_07;
        var_05 = var_7.func_DB08;
      }
    }

    if(var_05 > 10.0) {
      if(!isDefined(self.func_DB07.target) || self.func_DB07.target != var_04) {
        self.func_DB07.starttime = gettime();
        var_4.func_DB08 = var_4.func_DB08 + 10.0;
      }

      self.func_DB07.target = var_04;
      self.func_DB07.func_DCE9 = var_05;
    } else {
      self.func_DB07.starttime = 0;
      self.func_DB07.target = undefined;
      self.func_DB07.func_DCE9 = 0;
    }

    wait 0.05;
  }
}

func_E061(var_00) {
  self.func_AEDF.targeting = 0;
  self.func_AEDF.func_AF21 = 0;
  self.func_AEDF.locked = 0;
  self.func_AEDF.func_11567 = 0;
  self.func_AEDF.func_2A93 = 0;

  if(self.func_AEDF.func_38A4 && self.func_AEDF.func_9405)
    self notify("not_inDogfightRange");

  self _meth_84A0(0);

  if(self.func_AEDF.func_3A5B)
    func_0B76::func_F42C(var_00);
}

func_D18C() {
  self endon("script_death");
  self endon("player_exit_jackal");
  func_0BDC::func_137D6();
  self.func_D41F = -99999999;
  var_00 = 0;
  var_01 = 0;
  var_02 = [];

  for(;;) {
    level.func_A056.func_933B = scripts\engine\utility::array_removeundefined(level.func_A056.func_933B);
    var_02 = scripts\engine\utility::array_removeundefined(var_02);
    var_03 = func_7A32(var_02);

    foreach(var_05 in var_03) {
      if(!scripts\engine\utility::array_contains(var_02, var_05))
        var_05 func_0BDC::func_A36B();
    }

    foreach(var_05 in var_02) {
      if(!scripts\engine\utility::array_contains(var_03, var_05))
        var_05 func_0BDC::func_A368();
    }

    if(var_3.size > 3) {
      if(!var_01) {
        thread func_90E8();
        var_01 = 1;
      }
    } else if(var_3.size > 0 && scripts\sp\utility::func_7B9D() < 0.5) {
      if(!var_01) {
        thread func_90E7();
        var_01 = 1;
      }
    } else {
      if(var_01) {
        self notify("stop_evade_warning_vo");
        var_01 = 0;
      }

      foreach(var_05 in var_03) {
        var_05 func_90E9();
        break;
      }
    }

    var_02 = var_03;
    wait 0.25;
  }
}

func_7A32(var_00) {
  level.func_A056.func_90E3 = scripts\engine\utility::array_removeundefined(level.func_A056.func_90E3);

  foreach(var_02 in var_00) {
    if(!scripts\engine\utility::array_contains(level.func_A056.func_90E3, var_02))
      var_00 = scripts\engine\utility::array_remove(var_00, var_02);

    var_03 = level.func_D127.origin - var_2.origin;

    if(length(var_03) > 25000)
      var_00 = scripts\engine\utility::array_remove(var_00, var_02);
  }

  foreach(var_02 in level.func_A056.func_90E3) {
    if(scripts\engine\utility::array_contains(var_00, var_02)) {
      continue;
    }
    var_03 = level.func_D127.origin - var_2.origin;

    if(length(var_03) > 12000) {
      continue;
    }
    var_06 = vectordot(vectornormalize(var_03), anglesToForward(var_2.angles));

    if(var_06 < 0.1) {
      continue;
    }
    var_00 = scripts\engine\utility::array_add(var_00, var_02);
  }

  return var_00;
}

func_90E8() {
  self endon("script_death");
  self endon("player_exit_jackal");
  self endon("stop_evade_warning_vo");
  func_0BDC::func_A112("jackal_hud_enemy_threat_multiple", 2, 10);
  wait 4;
  thread func_90E7();
}

func_90E7() {
  self endon("script_death");
  self endon("player_exit_jackal");
  self endon("stop_evade_warning_vo");
  wait 2;

  for(;;) {
    func_0BDC::func_A112("jackal_hud_evade", 3, 15, 0.1);
    wait 3;
  }
}

func_90E9() {
  if(gettime() - self.var_1198.func_90ED > 3000) {
    var_00 = self.origin - level.func_D127.origin;
    var_01 = vectornormalize(var_00);
    var_02 = rotatevectorinverted(var_01, level.func_D127.angles);

    if(var_2[0] > 0)
      var_02 = (var_2[0] * 0.8, var_2[1], var_2[2]);

    if(abs(var_2[0]) > abs(var_2[1])) {
      if(var_2[0] > 0) {
        var_01 = "front";

        if(gettime() - level.func_D127.func_D41F > 5000)
          func_90E6(var_01);
      } else {
        var_01 = "rear";

        if(self.var_1198.func_90EC != var_01)
          func_90E6(var_01);
      }
    } else if(var_2[1] < 0) {
      var_01 = "right";

      if(self.var_1198.func_90EC != var_01)
        func_90E6(var_01);
    } else {
      var_01 = "left";

      if(self.var_1198.func_90EC != var_01)
        func_90E6(var_01);
    }
  }
}

func_90E6(var_00) {
  switch (var_00) {
    case "front":
      var_01 = "jackal_hud_enemy_threat_12";
      break;
    case "rear":
      var_01 = "jackal_hud_enemy_threat_6";
      break;
    case "left":
      var_01 = "jackal_hud_enemy_threat_9";
      break;
    case "right":
      var_01 = "jackal_hud_enemy_threat_3";
      break;
    default:
      var_01 = "jackal_hud_enemy_threat";
  }

  func_0BDC::func_A112(var_01, 1);
  var_02 = gettime();
  self.var_1198.func_90EC = var_00;
  self.var_1198.func_90ED = var_02;
  level.func_D127.func_D41F = var_02;
}

func_9B0D() {
  if(isDefined(self.var_1198)) {
    self.var_1198.func_90EE = undefined;
    self.var_1198.func_A9D1 = gettime();
  }
}

func_D18B() {
  self endon("script_death");
  self endon("player_exit_jackal");
  func_0BDC::func_137D6();
  var_00 = undefined;
  var_01 = 0;

  for(;;) {
    if(!isDefined(level.player _meth_8473())) {
      return;
    }
    level.func_A056.func_D92C = scripts\engine\utility::array_removeundefined(level.func_A056.func_D92C);
    var_02 = level.player _meth_848A();

    if(!isDefined(var_02) || !isDefined(var_2[0])) {
      self.func_4BC7 = undefined;
      self.func_4BC8 = 0;

      if(isDefined(var_00)) {
        if(isDefined(var_0.func_AEDF) && var_0.func_AEDF.func_2A93) {
          if(_isaircraft(var_00)) {
            if(level.func_A056.func_D92C.size == 0) {
              var_03 = var_0.func_AEDF.func_3A5C;
              var_01 = 1;
            } else {
              var_03 = var_0.func_AEDF.func_3A5C;
              var_01 = 0;
            }

            var_00 func_E061(var_03);
          } else
            var_00 func_E061(var_0.func_AEDF.func_3A5C);
        } else if(var_01) {
          if(isDefined(var_0.func_AEDF))
            var_00 func_E061(var_0.func_AEDF.func_3A5C);

          var_01 = 0;
        }

        var_00 = undefined;
      }

      wait 0.05;
      continue;
    } else {
      self.func_4BC7 = var_2[0];
      self.func_4BC8 = var_2[1];

      if(isDefined(var_2[0].func_AEDF)) {
        if(!var_2[0].func_AEDF.func_2A93)
          var_2[0].func_AEDF.func_2A93 = 1;

        if(!var_2[0].func_AEDF.func_11567) {
          var_2[0].func_AEDF.func_11567 = 1;
          var_2[0] func_0B76::func_F42B(var_2[0].func_AEDF.func_3782);

          if(!var_2[0].func_AEDF.func_933E)
            var_2[0] _meth_8558();
        }
      }
    }

    if(isDefined(var_00) && isDefined(var_0.func_AEDF) && var_00 != var_2[0]) {
      var_00 func_E061(var_0.func_AEDF.func_3A5C);
      var_01 = 0;
    }

    if(var_2[1] == 0) {
      if(isDefined(var_2[0]) && isDefined(var_2[0].func_AEDF) && !var_2[0].func_AEDF.targeting) {
        var_2[0] notify("player_is_targeting");
        var_2[0].func_AEDF.targeting = 1;
        var_2[0].func_AEDF.func_AF21 = 0;
        var_2[0].func_AEDF.locked = 0;
      }
    } else if(var_2[1] < 1) {
      if(isDefined(var_2[0]) && isDefined(var_2[0].func_AEDF) && !var_2[0].func_AEDF.func_AF21) {
        var_2[0] notify("player_is_locking");
        var_2[0].func_AEDF.targeting = 0;
        var_2[0].func_AEDF.func_AF21 = 1;
        var_2[0].func_AEDF.locked = 0;
      }
    } else if(var_2[1] == 1) {
      if(isDefined(var_2[0]) && isDefined(var_2[0].func_AEDF) && !var_2[0].func_AEDF.locked) {
        var_2[0] notify("player_is_locked");
        var_2[0].func_AEDF.targeting = 0;
        var_2[0].func_AEDF.func_AF21 = 0;
        var_2[0].func_AEDF.locked = 1;
      }
    }

    var_00 = var_2[0];
    wait 0.05;
  }
}

func_D174() {
  self endon("script_death");
  self endon("player_exit_jackal");
  func_0BDC::func_137D6();
  var_00 = undefined;
  self.func_C942 = undefined;
  var_01 = 0.04;

  for(;;) {
    while(level.player scripts\sp\utility::func_65DB("disable_jackal_lockon"))
      wait 0.05;

    level.func_A056.func_C93E = scripts\engine\utility::array_removeundefined(level.func_A056.func_C93E);

    if(isDefined(self.func_C942) && !scripts\engine\utility::array_contains(level.func_A056.func_C93E, self.func_C942))
      self.func_C942 = undefined;

    var_02 = anglesToForward(level.func_D127 gettagangles("tag_camera"));
    var_03 = level.func_A056.func_C93E;
    var_04 = undefined;
    var_05 = 0;

    foreach(var_07 in var_03) {
      var_08 = var_7.origin - self.origin;
      var_09 = length(var_08);
      var_08 = vectornormalize(var_08);
      var_10 = vectordot(var_02, var_08);

      if(var_10 > 0.96 && var_09 < 30000) {
        var_11 = scripts\sp\math::func_C097(0.96, 0.995, var_10);
        var_12 = 1 - scripts\sp\math::func_C097(0, 30000, var_09);
        var_7.func_377E = var_11 * var_12;
      } else
        var_7.func_377E = 0;

      if(var_7.func_377E > var_05) {
        var_04 = var_07;
        var_05 = var_7.func_377E;
      }
    }

    if(isDefined(var_04)) {
      if(isDefined(self.func_C942)) {
        if(self.func_C942 != var_04) {
          self.func_C942 func_E06A();
          self.func_C942 = var_04;
          self.func_C942 func_F4B6();
        }
      } else {
        self.func_C942 = var_04;
        self.func_C942 func_F4B6();
      }
    } else if(isDefined(self.func_C942)) {
      self.func_C942 func_E06A();
      self.func_C942 = undefined;
    }

    wait 0.05;
  }
}

func_F4B6() {
  func_0B76::func_F42B(self.func_AEDF.func_3782);

  if(self.func_AEDF.func_3A5B)
    self _meth_8558();
}

func_E06A() {
  self _meth_84A0(0);

  if(self.func_AEDF.func_3A5B)
    func_0B76::func_F42C(self.func_AEDF.func_3A5C);
}

waittill_near_struct() {
  self endon("death");

  for(;;) {
    if(!self.func_AEDF.locked) {
      break;
    }
    wait 0.05;
  }
}

func_13930(var_00) {
  self endon("fd_notify_ace_mode_disengaged");
  var_00 endon("death");

  while(self adsbuttonpressed() && !level.player scripts\sp\utility::func_65DB("disable_jackal_dogfight"))
    wait 0.05;

  self _meth_8464(undefined);
  var_00 notify("dogfight_ads_released");
}

func_F80C() {
  _setsaveddvar("spaceshipLockOnMaxAngleOverride", -1);
}

func_F6D0() {
  _setsaveddvar("spaceshipLockOnMaxAngleOverride", 360);
}

func_E0EE() {
  _setsaveddvar("spaceshipLockOnMaxAngleOverride", -1);
}

func_58B2(var_00, var_01) {
  level.player.func_58B7 = var_01;
  self notify("fd_notify_ace_mode_engaged", var_01);
  self _meth_8464(var_01);
  var_02 = 0.25;
  var_03 = 0.5;
  var_04 = 1;
  var_05 = 0.0;
  self _meth_8462(var_00, "orient", "time", var_03, 0.0);
  self _meth_8462(var_00, "orient", "time_player", var_05, var_02);
  self _meth_8462(var_00, "moveto", "time", var_04, 0.0);
  self _meth_8462(var_00, "moveto", "time_player", var_05, var_02);
  thread stuck_sled_failsafe(var_01, var_00);
  thread func_13930(var_01);
  var_06 = var_01 scripts\engine\utility::waittill_any_return("death", "dogfight_disengaged", "dogfight_ads_released", "dogfight_blocked");
  self notify("fd_notify_ace_mode_disengaged");
  level.player.func_58B7 = undefined;
  return var_06;
}

stuck_sled_failsafe(var_00, var_01) {
  self notify("stop_stuck_sled_failsafe");
  self endon("stop_stuck_sled_failsafe");
  self endon("fd_notify_ace_mode_disengaged");
  var_00 endon("death");
  var_01 endon("death");
  wait 0.5;
  var_02 = gettime();

  for(;;) {
    if(isDefined(level.func_D127) && isDefined(level.func_D127.spaceship_vel)) {
      var_03 = length(level.func_D127.spaceship_vel);

      if(var_03 > 30)
        var_02 = gettime();
      else if(gettime() - var_02 > 1000)
        var_00 notify("dogfight_disengaged");
    }

    wait 0.05;
  }
}

func_87A5(var_00, var_01) {
  var_00 endon("death");
  var_01 endon("death");

  for(;;) {
    var_0.angles = (var_0.angles[0], var_0.angles[1], var_1.angles[2]);
    scripts\engine\utility::waitframe();
  }
}

func_5879() {
  self endon("fd_notify_ace_mode_disengaged");
  var_00 = 1.35;
  level.player _meth_8291(1, 0.1, 0.1, var_00, 0.35, 0.6, 0, 20, 30, 30);
  wait(var_00 + 0.5);

  for(;;) {
    level.player _meth_8291(0.2, 0.05, 0.05, 1, 0, 0, 0, 20, 30, 30);

    if(!randomint(5))
      level.player _meth_8291(1.2, 1.1, 1.1, 0.2, 0, 0, 0, 40, 30, 30);

    wait 1;
  }
}

func_5883(var_00) {
  level.func_D127 endon("script_death");
  var_01 = 65;
  var_02 = 0.75;
  var_03 = 22;
  var_04 = 95;
  var_05 = 2.55;
  var_06 = 1.25;
  var_07 = 0.4;
  thread func_5879();
  _setsaveddvar("spaceshipForceSetFovBlendStrength", var_05 / 2);
  _setsaveddvar("spaceshipForceSetFov", var_04);
  wait(var_07);
  level.func_D127 playrumbleonentity("heavy_3s");
  _setsaveddvar("spaceshipForceSetFov", var_03);
  _setsaveddvar("spaceshipForceSetFovBlendStrength", var_05);
  wait(var_02 / 2);
  _setsaveddvar("spaceshipForceSetFovBlendStrength", var_05 * 2);
  wait(var_02 / 2);
  wait 0.4;
  _setsaveddvar("spaceshipForceSetFovBlendStrength", var_05 / 2);
  _setsaveddvar("spaceshipForceSetFov", var_01);
}

func_F41A() {
  self _meth_8339(1);
  self.func_AEDF.func_9405 = 1;
  thread func_1396C();
}

func_F558() {
  func_F360(1);
  self.func_AEDF.func_D826 = 1;
  thread func_1396D();
}

func_1396D() {
  scripts\engine\utility::waittill_either("not_inDogfightRange", "predogfight_disengage");
  func_F360(0);
  self.func_AEDF.func_D826 = 0;
}

func_F559(var_00) {
  func_DFF8();

  if(self.func_D827) {
    return;
  }
  self.func_D827 = 1;
  earthquake(0.22, 0.55, level.func_D127.origin, 5000);
  level.player playrumbleonentity("damage_light");
  func_5894(1);
  func_F80C();
  var_01 = 0.3;
  var_02 = 3;
  level.player _meth_8462(self.func_4BE7, "lookat", "desires", 1, var_01);
  func_0BDC::func_A302(var_02, var_01, "predogfight");
}

func_E079(var_00) {
  if(!self.func_D827) {
    return;
  }
  self.func_D827 = 0;
  level.player _meth_8462(self, "lookat", "desires", 0, 0);
  level.player _meth_8463("lookat");
  func_0BDC::func_A302(1, 0, "predogfight");
  func_E0EE();
  func_5894(0);

  if(isDefined(var_00) && var_00)
    func_588F();
}

func_1396C() {
  self waittill("not_inDogfightRange");
  self _meth_8339(0);
  self.func_AEDF.func_9405 = 0;
}

func_58B4() {
  level.func_D127 endon("script_death");
  level.func_D127 endon("player_exit_jackal");
  self.func_4BE7 = undefined;
  self.func_D827 = 0;
  var_00 = getdvarint("spaceshipSpringCameraMaxAngle");
  var_01 = 12000;
  var_01 = var_01 * var_01;
  var_02 = undefined;
  var_03 = 0.0;
  var_04 = [];
  var_4["initial_lockon"] = 0.25;
  var_4["active_lockon"] = 0;
  var_05 = [];
  var_5["initial_lockon"] = 0.766;
  var_5["active_lockon"] = 0.64;
  var_06 = [];
  var_6["initial_lockon"] = var_01;
  var_6["active_lockon"] = var_01 * 1.25;
  var_07 = "initial_lockon";
  var_08 = 0;
  var_09 = 0;
  var_10 = 0;
  level.func_58C6 = 0;
  var_11 = undefined;

  for(;;) {
    var_12 = self _meth_8473();

    if(isDefined(var_12)) {
      var_10 = gettime();

      if(!level.player scripts\sp\utility::func_65DB("disable_jackal_dogfight")) {
        var_13 = self _meth_848A();

        if(isDefined(var_13) && var_13[0] func_3815()) {
          var_11 = var_13[0];
          var_14 = 0;
          var_15 = anglesToForward(level.func_D127.angles);
          var_16 = vectordot(var_15, anglesToForward(var_11.angles));
          var_17 = vectordot(var_15, vectornormalize(var_11.origin - level.func_D127.origin));

          if(!var_11.func_AEDF.func_9405)
            var_11 func_F41A();

          if(isDefined(self.func_4BE7) && self.func_4BE7 != var_11) {
            if(self.func_4BE7.func_AEDF.func_D826)
              self.func_4BE7 notify("predogfight_disengage");
          }

          func_F2F0(var_11, "enemy_dogfight");
          self.func_4BE7 = var_11;

          if(var_13[1] >= 1.0) {
            if(!self.func_4BE7.func_AEDF.func_D826)
              self.func_4BE7 func_F558();

            func_F559();
          } else {
            if(self.func_4BE7.func_AEDF.func_D826)
              self.func_4BE7 notify("predogfight_disengage");

            var_18 = level.player adsbuttonpressed();
            func_E079(var_18);
          }

          if(var_16 > 0.5 && var_17 > 0.8)
            var_14 = 1;

          if(var_14 && var_11.func_AEDF.func_D826 && !var_11 func_0BDC::func_9C06()) {
            if(scripts\engine\utility::is_true(level.func_A18A))
              thread func_5883(var_11);
            else {
              var_19 = 65;
              var_20 = 2.55;
              _setsaveddvar("spaceshipForceSetFovBlendStrength", var_20 / 2);
              _setsaveddvar("spaceshipForceSetFov", var_19);
            }

            var_21 = spawn("script_model", var_12.origin);
            var_21 setModel("tag_origin");
            var_21.angles = var_12.angles;
            level.func_D127.func_58B5 = 1;
            func_F6D0();

            if(getdvarint("spaceshipDogfightModeUsingPhysics") == 0)
              thread func_87A5(var_21, var_11);

            _setsaveddvar("spaceshipSpringCameraMaxAngle", 10);

            if(!isDefined(level.func_D127.func_58B6)) {
              level.func_D127.func_58B6 = spawn("script_origin", level.func_D127.origin);
              level.func_D127.func_58B6 linkto(level.func_D127);
              level.func_D127.func_58B6 ghostattack(0);
            }

            level.player notify("engage boost");
            level.func_D127.func_6ADB = 1;
            func_0BDC::func_A0BE();
            thread func_589E();
            earthquake(0.33, 0.75, level.func_D127.origin, 5000);
            level.player playrumbleonentity("damage_heavy");
            var_11 playLoopSound("jackal_sdf_locked_lp");
            level.func_D127.func_58B6 playLoopSound("jackal_plr_locked_lp");
            level.player setsoundsubmix("jackal_dogfight");
            level.func_D127.func_58B6 ghostattack(1, 1);
            func_0BDC::func_A302(0.4, 0.5, "dogfight");
            var_22 = func_58B2(var_21, var_11);
            func_0BDC::func_A302(1, 0.5, "dogfight");
            level.func_A056.func_A976 = gettime();
            self notify("fd_notify_ace_mode_disengaged");
            level.player notify("disengage boost");
            func_0BDC::func_A0BE(0);
            level.func_D127.func_6ADB = undefined;
            level.player thread func_D176(0.0, 0, 0.3, 0.03, 0.3);
            level.func_D127.func_58B6 ghostattack(0, 1);
            level.player clearsoundsubmix();
            level.func_D127.func_58B6 scripts\engine\utility::delaycall(1, ::stoploopsound, "jackal_plr_locked_lp");

            if(isDefined(var_11)) {
              var_11 stoploopsound("jackal_sdf_locked_lp");
              var_11 notify("predogfight_disengage");
            }

            _setsaveddvar("spaceshipForceSetFovBlendStrength", 2);
            _setsaveddvar("spaceshipForceSetFov", 0);
            func_E079();
            _setsaveddvar("spaceshipSpringCameraMaxAngle", var_00);
            self _meth_8464(undefined);
            self _meth_8463("moveto");
            self _meth_8463("orient");
            level.func_D127.func_58B5 = 0;

            if(var_22 == "dogfight_disengaged" || var_22 == "dogfight_blocked") {
              func_588F();

              if(isDefined(var_11))
                var_11 playSound("jackal_sdf_lock_broke");
            }

            func_587B();
          }
        } else {
          if(isDefined(self.func_4BE7)) {
            self.func_4BE7 notify("not_inDogfightRange");
            self.func_4BE7 notify("predogfight_disengage");
            func_4146();
          }

          func_E079();
        }
      }
    }

    wait 0.05;
    var_09 = var_10;
  }
}

func_589E() {
  self endon("fd_notify_ace_mode_disengaged");
  var_00 = 0.7;
  var_01 = 0.35;
  level.player thread func_D176(1.0, 0.1, var_00, 0.03, 0.3);
  wait(var_00 + 0.4);
  level.player thread func_D176(0.33, 0.1, var_00, 0.03, 0.3);
}

func_588F() {
  setomnvar("ui_jackal_lock_broke", gettime());
  level.player playSound("jackal_dogfight_lockbroke");
  earthquake(0.23, 0.75, level.func_D127.origin, 5000);
  level.player playrumbleonentity("damage_light");
}

func_587B() {
  level.player allowads(0);
  level.player _meth_8490("disable_ads", 1);
  level.player _meth_8490("disable_lockon", 1);
  var_00 = 0;
  var_01 = level.player adsbuttonpressed();
  var_02 = 0.2;
  var_03 = 1.6;

  for(;;) {
    var_00 = var_00 + 0.05;

    if(var_01) {
      if(var_00 > var_03) {
        break;
      }
    } else if(var_00 > var_02) {
      break;
    }
    if(!level.player adsbuttonpressed() && var_01)
      var_04 = 0;

    wait 0.05;
  }

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_ads")) {
    level.player _meth_8490("disable_ads", 0);
    level.player allowads(1);
  }

  if(!level.player scripts\sp\utility::func_65DB("disable_jackal_lockon"))
    level.player _meth_8490("disable_lockon", 0);
}

func_5894(var_00) {
  if(!isDefined(var_00))
    var_01 = 1;

  if(var_00 == 1)
    level.player playSound("jackal_dogfight_lockon");

  setomnvar("ui_jackal_dogfight", var_00);
}

func_3815() {
  if(isDefined(self.func_AEDF) && self.func_AEDF.func_38A4)
    return 1;
  else
    return 0;
}

func_F2F0(var_00, var_01) {
  if(!isDefined(var_00)) {
    return;
  }
  if(var_0.func_AEDF.func_3782 == var_01) {
    return;
  }
  if(var_01 == "enemy_dogfight")
    thread func_1396B(var_00);

  var_0.func_AEDF.func_3782 = var_01;
  var_02 = level.player _meth_848A();

  if(isDefined(var_02) && isDefined(var_2[0]) && var_2[0] == var_00)
    var_00 func_0B76::func_F42B(var_0.func_AEDF.func_3782);
}

func_1396B(var_00) {
  var_00 endon("death");
  self waittill("remove_dogfight_callout_from_targets");
  func_F2F0(var_00, "enemy_jackal");
}

func_DFF8() {
  self notify("remove_dogfight_callout_from_targets");
}

func_4146() {
  if(!isDefined(self.func_4BE7)) {
    return;
  }
  self notify("remove_dogfight_callout_from_targets");
  self.func_4BE7 = undefined;
}

func_D189() {
  self endon("player_exit_jackal");
  level.func_D127 endon("script_death");
  func_0BDC::func_137DA();
  level.func_A056.func_A91D = -99999;
  level.func_A056.func_118DF = randomfloatrange(level.func_A48E.func_A425, level.func_A48E.func_A424);

  for(;;) {
    wait 0.05;

    if(removeteamheadicononnotify(level.player scripts\sp\utility::func_65DB("disable_jackal_lockon"))) {
      continue;
    }
    if(removeteamheadicononnotify(level.player scripts\sp\utility::func_65DB("disable_jackal_guns"))) {
      continue;
    }
    if(removeteamheadicononnotify(level.player scripts\sp\utility::func_65DB("disable_jackal_targetAid"))) {
      continue;
    }
    if(removeteamheadicononnotify(level.func_A056.func_933B.size > 0)) {
      continue;
    }
    if(removeteamheadicononnotify(func_EF45())) {
      continue;
    }
    if(removeteamheadicononnotify(func_D39E())) {
      continue;
    }
    if(gettime() - level.func_A056.func_A91D < level.func_A056.func_118DF) {
      continue;
    }
    if(scripts\sp\utility::func_7B9D() <= 0.5) {
      continue;
    }
    func_114F4();
  }
}

func_114F4() {
  if(level.player scripts\sp\utility::func_65DB("disable_jackal_targetAid_update")) {
    return;
  }
  if(isDefined(level.func_A056.func_4C2C) && isDefined(level.func_A056.func_4C2C[0]))
    level notify("jackal_target_aid_callout", level.func_A056.func_4C2C[1]);
  else {
    var_00 = func_1423();

    if(isDefined(var_00)) {
      if(isDefined(var_0[1])) {
        level.func_A056.func_4C2C = var_00;
        var_0[0] thread func_1422();
        level notify("jackal_target_aid_callout", var_0[1]);
      }
    }
  }
}

func_EF45() {
  if(isDefined(level.func_A056.func_4C2C) && isDefined(level.func_A056.func_4C2C[0]))
    var_00 = 1;
  else
    var_00 = 0;

  return level.func_A056.func_D92C.size > var_00;
}

removeteamheadicononnotify(var_00) {
  if(var_00) {
    func_1424();
    func_DAFB();
  }

  return var_00;
}

func_DAFB(var_00) {
  level.func_A056.func_A91D = gettime();
  level.func_A056.func_118DF = randomfloatrange(level.func_A48E.func_A425, level.func_A48E.func_A424) * 1000;
}

func_1423() {
  var_00 = 0.9;
  var_01 = 0.74;
  var_02 = 60000;
  var_03 = 120000;
  var_04 = 3;
  var_05 = 2;
  var_06 = 1;
  var_07 = 0;
  var_08 = 100;
  var_09 = 75;
  var_10 = 75;
  var_11 = 30;

  if(isDefined(level.func_A056.func_EF83)) {
    level.func_A056.func_EF83 = scripts\engine\utility::array_removeundefined(level.func_A056.func_EF83);
    var_12 = level.func_A056.func_EF83;
  } else {
    var_12 = level.func_A056.targets;

    foreach(var_14 in var_12) {
      if(!isDefined(var_14) || !isDefined(var_14.script_team) || !isalive(var_14)) {
        var_12 = scripts\engine\utility::array_remove(var_12, var_14);
        continue;
      }

      if(isDefined(var_14.func_C841)) {
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
    var_22 = func_0B76::func_7A60(var_14.origin);

    if(var_22 >= var_00)
      var_20 = var_20 + var_08;
    else if(var_22 >= var_01)
      var_20 = var_20 + var_09;

    var_23 = distance(level.func_D127.origin, var_14.origin);

    if(var_23 <= var_02)
      var_20 = var_20 + var_10;
    else if(var_23 <= var_03)
      var_20 = var_20 + var_11;

    if(issubstr(var_14.classname, "ace")) {
      var_21 = "ace";
      var_20 = var_20 + var_04;
    } else if(issubstr(var_14.classname, "jackal")) {
      var_21 = "skelter";
      var_20 = var_20 + var_05;
    } else if(issubstr(var_14.classname, "missileboat")) {
      var_21 = "missileboat";
      var_20 = var_20 + var_06;
    } else if(issubstr(var_14.classname, "destroyer")) {
      var_21 = "destroyer";
      var_20 = var_20 + var_07;
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
      var_23 = distance(level.func_D127.origin, var_14.origin);

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

func_1422() {
  func_0BDC::func_A36D();
}

func_1424() {
  if(!isDefined(level.func_A056.func_4C2C)) {
    return;
  }
  if(!isDefined(level.func_A056.func_4C2C[0])) {
    level.func_A056.func_4C2C = undefined;
    return;
  }

  level.func_A056.func_4C2C[0] func_0BDC::func_A36A();
  level.func_A056.func_4C2C[0] notify("jackal_target_aid_callout_removed");
  level.func_A056.func_4C2C = undefined;
}

func_D39E() {
  var_00 = level.player _meth_848A();

  if(isDefined(var_00) && isDefined(var_0[0]))
    return 1;

  return 0;
}

func_FA4F() {
  level.func_D127.func_10A0D = 0;
  func_1095F();
  thread scripts\sp\specialist_MAYBE::func_F530(1);
}

func_10960() {
  level.player notify("jackal_note_hud_off");
  level.player endon("jackal_note_hud_on");
  level.player endon("jackal_note_hud_off");
  level.player scripts\sp\utility::func_65DD("jackal_hud_on");
  setomnvar("ui_jackal_bootup", 0);
  setomnvar("ui_jackal_callouts_enabled", 0);
  setomnvar("ui_hide_hud", 0);
  setomnvar("ui_active_hud", "infantry");
}

func_1095F() {
  level.func_A056.targets = scripts\engine\utility::array_removeundefined(level.func_A056.targets);
  level.player scripts\sp\utility::func_65E1("disable_jackal_lockon");

  foreach(var_01 in level.func_A056.targets)
  var_01 func_0BDC::func_105D9();

  setomnvar("ui_jackal_callouts_enabled", 0);

  if(scripts\engine\utility::player_is_in_jackal())
    level.player _meth_8490("disable_lockon", 1);
}