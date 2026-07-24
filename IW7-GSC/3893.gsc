/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3893.gsc
**************************************/

main() {
  _id_0F32::main();
  _id_0F31::main();
  _id_0F34::main();
  setsaveddvar("player_zeroGravDisableWalk", 1);
  level thread _id_13AA();
  level thread _id_13AB();
  setomnvar("ui_hud_in_space", 1);
}

_id_FB24(var_0, var_1) {
  if(!var_1 scripts\sp\utility::_id_65DF("zero_gravity")) {
    var_1 scripts\sp\utility::_id_65E0("zero_gravity");
  }

  if(var_0 == var_1 scripts\sp\utility::_id_65DB("zero_gravity")) {
    return;
  }
  if(var_0) {
    var_1 scripts\sp\utility::_id_65E1("zero_gravity");
  } else {
    var_1 scripts\sp\utility::_id_65DD("zero_gravity");
  }

  var_1 _meth_84F0(var_0);
  var_1 allowprone(!var_0);
  scripts\sp\utility::_id_F44E(!var_0);

  if(var_0) {
    physics_setgravity((0, 0, 0));
    var_1 thread _id_13A5();
    setsaveddvar("xanim_physicsGravity", 0);

    if(scripts\engine\utility::flag_exist("highlight_zero_g_ai") && scripts\engine\utility::flag("highlight_zero_g_ai")) {
      var_1 thread _id_12D3();
    }
  } else {
    physics_setgravity((0, 0, -386.09));
    var_1 thread _id_13A4();
    setsaveddvar("xanim_physicsGravity", 800);

    if(scripts\engine\utility::flag_exist("highlight_zero_g_ai") && scripts\engine\utility::flag("highlight_zero_g_ai")) {
      var_1 thread _id_125D();
    }

    _id_FB25(0, 0);
    var_1 allowmantle(1);
    var_1 _meth_8512(1);
    var_1 allowwallrun(1);
  }

  _id_FB27();
}

_id_13EF1(var_0) {
  if(issubstr(self getcurrentprimaryweapon(), "none")) {
    return;
  }
  _id_0A2F::_id_13E80(var_0, 0);
}

_id_FB25(var_0, var_1, var_2, var_3) {
  level.player notify("zeroGravityEquipmentWait");

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(scripts\engine\utility::is_true(level.player._id_13EEF) && !var_0 && !var_1) {
    _id_0F31::_id_F84E(0, level.player);
    level.player thread _id_0F32::_id_D434();
    level.player _id_0B2A::_id_E2C0();
    level.player._id_13EEF = undefined;

    if(var_3) {
      level.player _id_13EF1(0);
    }

    return;
  } else if(var_0 || var_1) {
    if(scripts\engine\utility::is_true(var_2)) {
      level.player _id_13EF0(var_0, var_1, var_3);
    } else {
      level.player thread _id_13EF0(var_0, var_1, var_3);
    }
  }
}

_id_13EF0(var_0, var_1, var_2) {
  if(scripts\engine\utility::is_true(self._id_13EEF)) {
    return;
  }
  self notify("zeroGravityEquipmentWait");
  self endon("zeroGravityEquipmentWait");
  var_3 = 0;

  for(;;) {
    if(self getweaponslistall().size > 0 || var_3 >= 0.1) {
      while(self getweaponslistall().size > 2) {
        scripts\engine\utility::waitframe();
      }

      self._id_13EEF = 1;
      _id_0B2A::_id_11429();

      if(var_0) {
        _id_0F31::_id_F84E(1, self);
      }

      if(var_1) {
        thread _id_0F32::_id_D393();
      }

      scripts\engine\utility::waitframe();

      if(var_2) {
        level.player _id_13EF1(1);
      }

      return;
    }

    var_3 = var_3 + 0.05;
    wait 0.05;
  }
}

_id_FB26(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  setsaveddvar("grapple_max_distance", 512);
  setsaveddvar("grapple_min_distance", 128);
  setsaveddvar("spacejumpspeed", 400);
  setsaveddvar("player_zeroGravSpeed", 188);
  setsaveddvar("player_zeroGravAcceleration", 175);
  setsaveddvar("player_zeroGravFriction", 150);
  setsaveddvar("player_zeroGravBoostScalar", 1.4);
  setsaveddvar("player_zeroGravRollAcceleration", 360);
  setsaveddvar("player_zeroGravRollVelocityMax", 90);
  setsaveddvar("player_zeroGravRollFriction", 180);
  _id_EB7A(1);

  if(!var_0) {
    level.player _id_1398();
    level.player allowmantle(0);
    level.player _meth_8512(0);
    level.player allowwallrun(0);
  }

  if(scripts\engine\utility::is_true(var_1)) {
    setsaveddvar("player_zeroGravWorldUp", (0, 0, 1));
  }
}

_id_FB27() {
  setsaveddvar("grapple_max_distance", 1024);
  setsaveddvar("grapple_min_distance", 128);
  setsaveddvar("spacejumpspeed", 1200);
  setsaveddvar("player_zeroGravSpeed", 190);
  setsaveddvar("player_zeroGravAcceleration", 350);
  setsaveddvar("player_zeroGravFriction", 100);
  setsaveddvar("player_zeroGravBoostScalar", 1.5);
  setsaveddvar("player_zeroGravRollAcceleration", 360);
  setsaveddvar("player_zeroGravRollVelocityMax", 90);
  setsaveddvar("player_zeroGravRollFriction", 180);
  setsaveddvar("player_zeroGravWorldUp", (0, 0, 0));
  _id_EB7A(1);
}

_id_D3CD(var_0) {
  var_1 = 15;
  var_2 = 120;
  var_3 = 10;

  if(self islinked()) {
    return;
  }
  if(isDefined(self _meth_845B()) && vectordot((0, 0, 1), anglestoup(self getworldupreferenceangles())) > 0.9) {
    self normalizeworldupreferenceangles();
    return;
  }

  var_4 = ["ges_grav_jump_combat", "ges_grav_jump_combat_fail", "ges_grav_jump_combat_up", "ges_grav_jump_combat_down", "ges_grav_jump_combat_left", "ges_grav_jump_combat_right"];

  if(isDefined(var_0)) {
    var_4 = [var_0, var_0, var_0, var_0, var_0, var_0];
  }

  var_5 = 1;
  var_6 = self getEye();
  var_7 = 0;
  var_8 = vectortoangles((0, 0, 1));
  var_9 = undefined;
  var_10 = self getEye();
  var_11 = (0, 0, -1);

  for(var_12 = var_10 + var_11 * var_2; var_5 < var_3; var_5++) {
    var_13 = _id_11A3(var_10, var_12, var_8, self);

    if(var_13["fraction"] == 0) {
      var_14 = var_13["position"];
      var_15 = var_10;
      var_16 = vectorNormalize(var_10 - var_14);
      var_10 = var_10 + var_16 * var_1;
      var_12 = var_10 + var_11 * var_2;
      continue;
    }

    if(var_13["fraction"] == 1) {
      var_10 = var_12;
      var_12 = var_10 + var_11 * var_2;
      continue;
    }

    var_18 = var_2 * var_13["fraction"];
    var_9 = var_10 + var_11 * var_18;
    break;
  }

  if(!isDefined(var_9)) {
    var_9 = self.origin;
  }

  if(isDefined(var_9)) {
    var_19 = scripts\engine\utility::spawn_tag_origin(var_9, var_8);
    self._id_13EE6 = 1;
    self _meth_8507();
    self _meth_84DE(var_4[0], var_4[1], var_4[2], var_4[3], var_4[4], var_4[5]);
    self _meth_8516(var_19);
    self waittill("spacejump_land");
    self _meth_84DF();
    self normalizeworldupreferenceangles();
    self._id_13EE6 = undefined;
    var_19 delete();
  }
}

_id_D380() {
  setsaveddvar("player_zerogravAutoLevel", (0, 0, 0));
}

_id_D385(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = (0, 0, 1);
  }

  setsaveddvar("player_zeroGravAutoLevel", var_0);

  if(isDefined(var_1)) {
    setsaveddvar("player_zeroGravAutoLevelDeadZone", var_1);
  } else {
    setsaveddvar("player_zeroGravAutoLevelDeadZone", 0.1);
  }
}

_id_13A5() {
  thread _id_0F33::_id_260B();
  self setactionslot(1, "autolevel");
  self setactionslot(3, "rollleft");
  self setactionslot(4, "rollright");
  thread _id_1399();
  thread _id_1370();
  self notify("playerZeroGravityEnabled");
  thread _id_136E();
  thread _id_139B();
  thread _id_13A6();
  thread _id_13A2();
}

_id_13A4() {
  self setactionslot(3, "");
  self setactionslot(4, "");
  _id_1398();
  thread _id_136F();
  self notify("playerZeroGravityDisabled");
  thread _id_0F33::_id_260C();
  _id_136D();
  _id_13A1();
  _id_D380();
}

_id_139B() {
  self endon("playerZeroGravityDisabled");
  var_0 = 0.15;
  var_1 = 45;

  for(;;) {
    var_2 = self getvelocity();
    var_3 = length(var_2);

    if(var_3 == 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_4 = self getplayerangles();
    var_5 = anglestoup(var_4);
    var_6 = self.origin + var_5 * 60;
    physicsexplosionsphere(var_6, var_1, 1, var_0);
    scripts\engine\utility::waitframe();
  }
}

_id_13A6() {
  self endon("playerZeroGravityDisabled");

  for(;;) {
    while(!self issprinting() || self isonground()) {
      scripts\engine\utility::waitframe();
    }

    self playRumbleOnEntity("damage_light");
    self _meth_8291(0.6, 0.6, 0.6, 0.5, 0, 0.5, 0, 5, 5, 5);

    while(self issprinting() && !self isonground()) {
      scripts\engine\utility::waitframe();
    }

    while(self adsButtonPressed() && !self isonground()) {
      scripts\engine\utility::waitframe();
    }
  }
}

_id_11A3(var_0, var_1, var_2, var_3) {
  var_4 = 15;
  var_5 = 15;
  var_6 = physics_capsulecast(var_0, var_1, var_5, var_4, var_2, _id_12B7(), var_3, "physicsquery_closest");

  if(var_6.size) {
    var_6 = var_6[0];
  } else {
    var_6 = scripts\common\trace::internal_pack_default_trace(var_1);
  }

  return var_6;
}

_id_12B7() {
  return scripts\common\trace::create_contents(1, 1, 1, 1, 0, 0, 1);
}

_id_13AA() {
  level._effect["grapple_cam"] = loadfx("vfx/iw7/core/equipment/grapple_hook/vfx_grapple_hook_speed_cam.vfx");
  level._effect["zero_g_cam"] = loadfx("vfx/iw7/levels/sa_vips/vfx_sa_vip_cam_ice_particles.vfx");
  level._effect["zerog_grapple_launch"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_grapple_launch.vfx");
  level._effect["zerog_grapple_impact"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_grapple_impact.vfx");
  level._effect["zerog_grapple_kill"] = loadfx("vfx/iw7/core/mechanics/zerog/zerog_grapple_kill.vfx");
  precachemodel("fx_org_view");
}

_id_13AB() {
  precacheshader("hud_zero_g_enemy_highlight");
}

_id_1370() {
  self._id_37C7 = spawn("script_model", (0, 0, 0));
  self._id_37C7 setModel("fx_org_view");
  self._id_37C7 _meth_81E2(level.player, "tag_origin", (11, 0, 0), (180, 0, 0), 1);
  playFXOnTag(scripts\engine\utility::getfx("zero_g_cam"), self._id_37C7, "tag_origin");
}

_id_136F() {
  if(isDefined(self._id_37C7)) {
    self._id_37C7 delete();
  }
}

_id_1398() {
  self notify("mag_boots_effects_off");
}

_id_1399() {
  self endon("mag_boots_effects_off");
  var_0 = 0;

  for(;;) {
    if(self isonground() && (self _meth_84F4() == "none" || self _meth_84F4() == "land")) {
      if(!var_0) {
        if(!self iswallrunning()) {
          self playlocalsound("zg_grapple_stop_land_magboots");
        }

        var_0 = 1;
      }
    } else if(var_0) {
      self playlocalsound("zero_g_mvmt_start");
      var_0 = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_136D() {
  self notify("auto_release_off");
}

_id_136E() {
  self endon("auto_release_off");
  var_0 = cos(60);

  for(;;) {
    var_1 = 1;

    if(!var_1 || !self isonground() || self iswallrunning() || self islinked()) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_2 = length(self getnormalizedmovement());

    if(var_2 < 0.1) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_3 = self getworldupreferenceangles();
    var_4 = anglestoup(var_3);
    var_5 = -1 * var_4;
    var_6 = self.origin + var_4 * 2;
    var_7 = self.origin + var_5 * 100;
    var_8 = scripts\common\trace::player_trace(var_6, var_7, self.angles, self, _id_12B7());

    if(var_8["fraction"] == 1) {
      scripts\engine\utility::waitframe();
      continue;
    }

    var_9 = self getplayerangles();
    var_10 = var_8["normal"];
    var_11 = anglesToForward(var_9);
    var_13 = vectordot(var_10, var_11);

    if(var_13 > var_0) {
      self setvelocity(var_11 * 50);
      wait 1;
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_1396() {
  var_0 = "ges_zg_boost";
  var_1 = self _meth_846E();

  if(var_1.size == 0) {
    return 0;
  }

  foreach(var_3 in var_1) {
    if(!issubstr(var_3, var_0) && var_3 != "ges_zg_sprint") {
      return 1;
    }
  }

  return 0;
}

_id_1375(var_0) {
  if(self _meth_843B()) {
    return "back";
  } else if(self _meth_81CE()) {
    return "forward";
  }

  if(abs(var_0[0]) < 0.1 && abs(var_0[1]) < 0.1) {
    return "none";
  }

  var_1 = cos(60);
  var_2 = vectorNormalize((var_0[0], var_0[1], 0));
  var_3 = vectordot(var_2, (1, 0, 0));

  if(var_3 > var_1) {
    return "forward";
  } else if(var_3 < var_1 * -1) {
    return "back";
  } else if(var_0[1] > 0) {
    return "right";
  } else {
    return "left";
  }
}

_id_13A1() {
  self notify("view_dips_disabled");
}

_id_13A2() {
  self endon("view_dips_disabled");
  var_0 = "ges_zg_boost_forward_up";
  var_1 = "ges_zg_boost_back_down";
  var_2 = "ges_zg_boost_left";
  var_3 = "ges_zg_boost_right";
  var_4 = "ges_zg_sprint";

  for(;;) {
    var_5 = "";
    var_6 = self isonground() || self islinked();

    if(!var_6) {
      var_6 = _id_0F31::_id_9E14() || _id_1396();
    }

    if(!var_6) {
      var_6 = self playerads() > 0 || self _meth_819F() || self isthrowinggrenade() || self isreloading() || self isswitchingweapon();
    }

    if(!var_6) {
      var_6 = issubstr(self getcurrentweapon(), "akimbo") && issubstr(self getcurrentweapon(), "alt_");
    }

    if(!var_6) {
      var_6 = issubstr(self getcurrentweapon(), "+grip") || issubstr(self getcurrentweapon(), "+zeroggrip");
    }

    if(var_6) {
      thread _id_13A3("none_quick");
    } else {
      var_7 = self getnormalizedmovement();
      var_8 = _id_1375(var_7);

      switch (var_8) {
        case "forward":
          var_9 = getdvarfloat("player_zeroGravSpeed");
          var_10 = var_9 * getdvarfloat("player_zeroGravBoostScalar");
          var_11 = var_9 + (var_10 - var_9) * 0.05;

          if(lengthsquared(self getvelocity()) > squared(var_11)) {
            thread _id_13A3(var_4 + var_5);
          } else {
            thread _id_13A3(var_0 + var_5);
          }

          break;
        case "back":
          thread _id_13A3(var_1 + var_5);
          break;
        case "right":
          thread _id_13A3(var_3 + var_5);
          break;
        case "left":
          thread _id_13A3(var_2 + var_5);
          break;
        default:
          thread _id_13A3("none");
          break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

_id_13A3(var_0) {
  if(isDefined(level.player._id_13EEC) && level.player._id_13EEC == var_0) {
    return;
  }
  var_1 = getdvarfloat("scr_zerog_view_dip_blend_time", 0.3);

  if(var_0 == "none_quick") {
    var_1 = min(0.2, var_1);
  }

  self notify("_playerViewDipSet");
  self endon("_playerViewDipSet");
  self endon("view_dips_disabled");

  if(isDefined(level.player._id_13EEC) && !issubstr(level.player._id_13EEC, "none")) {
    var_2 = var_1;

    if(isDefined(level.player._id_13EED)) {
      var_2 = var_1 - (gettime() - level.player._id_13EED) / 1000.0;
    } else {
      level.player._id_13EED = gettime();
    }

    var_2 = max(0.0, var_2);
    level.player stopgestureviewmodel(level.player._id_13EEC, var_2);
    wait(var_2);
    level.player._id_13EED = undefined;
  }

  level.player._id_13EEC = var_0;

  if(!issubstr(level.player._id_13EEC, "none")) {
    level.player forceplaygestureviewmodel(level.player._id_13EEC, undefined, var_1);
  }
}

_id_12D3() {
  level notify("handle_zero_g_highlighting");
  level endon("handle_zero_g_highlighting");
  level endon("end_zero_g_highlighting");
  var_0 = 2048;

  if(isDefined(level._id_13E75)) {
    var_0 = level._id_13E75;
  }

  var_0 = var_0 * var_0;
  var_1 = [];
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].team = "axis";
  var_1[var_1.size - 1]._id_B742 = 16384;
  var_1[var_1.size - 1]._id_B42E = var_0;
  var_1[var_1.size - 1]._id_B743 = cos(65);
  var_1[var_1.size - 1]._id_B42F = cos(0);
  var_1[var_1.size - 1].color = (1, 0.5, 0);
  var_1[var_1.size] = spawnStruct();
  var_1[var_1.size - 1].team = "allies";
  var_1[var_1.size - 1]._id_B742 = 262144;
  var_1[var_1.size - 1]._id_B42E = var_0;
  var_1[var_1.size - 1]._id_B743 = cos(65);
  var_1[var_1.size - 1]._id_B42F = cos(0);
  var_1[var_1.size - 1].color = (0, 1, 1);

  for(;;) {
    foreach(var_3 in var_1) {
      thread _id_146A(var_3.team, var_3._id_B742, var_3._id_B42E, var_3._id_B743, var_3._id_B42F, var_3.color);
    }

    wait 0.05;
  }
}

_id_146A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = anglesToForward(self getplayerangles());

  foreach(var_8 in getaiarray(var_0)) {
    var_9 = 0;

    if(!scripts\sp\utility::_id_9D27() && !scripts\engine\utility::is_true(var_8._id_9320)) {
      var_10 = var_8.origin - self.origin;
      var_11 = lengthsquared(var_10);

      if(var_11 >= var_1 && var_11 < var_2) {
        var_12 = vectordot(vectorNormalize(var_10), var_6);

        if(var_12 > var_3 && var_12 <= var_4) {
          var_13 = var_8.origin;

          if(isDefined(var_8.model) && scripts\sp\utility::hastag(var_8.model, "j_mainroot")) {
            var_13 = var_8 gettagorigin("j_mainroot");
          }

          if(sighttracepassed(self getEye(), var_13, 1, var_8, self)) {
            var_9 = 1;
          }
        }
      }
    }

    if(isDefined(var_8._id_8EEF) != var_9) {
      if(var_9) {
        var_8 thread _id_11B6(var_5);
        continue;
      }

      var_8 notify("zero_g_remove_highlight");
    }
  }
}

_id_11B6(var_0) {
  if(isDefined(self.model) && scripts\sp\utility::hastag(self.model, "j_mainroot")) {
    self._id_8EEF = scripts\engine\utility::spawn_tag_origin(self gettagorigin("j_mainroot"), self.angles);
    self._id_8EEF linkTo(self, "j_mainroot", (10, 0, 0), (0, 0, 0));
    target_alloc(self._id_8EEF);
    target_setshader(self._id_8EEF, "hud_zero_g_enemy_highlight");
    target_drawsquare(self._id_8EEF, 25.0);
    target_setminsize(self._id_8EEF, 20, 0);
    target_setmaxsize(self._id_8EEF, 25);
    target_setscaledrendermode(self._id_8EEF, 0);
    target_showtoplayer(self._id_8EEF, level.player);
    target_setcolor(self._id_8EEF, var_0, 1.0);
    target_flush(self._id_8EEF);
    thread _id_13B4();
  }
}

_id_13B4() {
  var_0 = self._id_8EEF;
  scripts\engine\utility::waittill_any("death", "zero_g_remove_highlight");

  if(isDefined(var_0)) {
    if(target_istarget(var_0)) {
      target_remove(var_0);
    }

    var_0 delete();
  }

  if(isDefined(self)) {
    self._id_8EEF = undefined;
  }
}

_id_125D() {
  level notify("end_zero_g_highlighting");

  foreach(var_1 in getaiarray("axis", "allies")) {
    var_1 notify("zero_g_remove_highlight");
  }
}

_id_FAFC(var_0, var_1) {
  _id_FB24(1, level.player);
  _id_FB25(1, 1);
  _id_0F31::_id_17A0();
  thread _id_FAFD();
  var_2 = [];

  if(!isDefined(var_0)) {
    var_2 = _id_0F31::_id_7EE1();
  } else {
    var_2 = getEntArray(var_0, "targetname");
  }

  if(var_2.size > 0) {
    scripts\engine\utility::array_thread(var_2, _id_0F31::_id_13544, 1);
  }

  var_2 = [];

  if(!isDefined(var_1)) {
    var_2 = _id_0F31::_id_7EE0();
  } else {
    var_2 = getEntArray(var_1, "targetname");
  }

  if(var_2.size > 0) {
    scripts\engine\utility::array_thread(var_2, _id_0F31::_id_1353F, 1);
  }
}

_id_FAFD() {
  level._id_13E85 = 0;
  var_0 = getEntArray("zerog_speed_adjustment", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_89FD);
}

_id_89FD() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isDefined(self.script_parameters)) {
      self.script_parameters = 0.6;
    }

    level._id_13E85++;
    var_1 = level._id_13ED3;
    thread _id_EBB0(self.script_parameters, 1);

    while(isalive(var_0) && isDefined(self) && var_0 istouching(self)) {
      wait 0.25;
    }

    level._id_13E85--;

    if(level._id_13E85 <= 0 || !isDefined(var_1)) {
      thread _id_EBB0(1.0, 1);
      continue;
    }

    thread _id_EBB0(var_1, 1);
  }
}

_id_EB7A(var_0) {
  if(scripts\engine\utility::is_true(var_0) || !isDefined(level._id_13EC5)) {
    level._id_13EC5 = getdvarint("player_zeroGravSpeed");
    level._id_13EC3 = getdvarint("player_zeroGravAcceleration");
    level._id_13EC4 = getdvarint("player_zeroGravFriction");
  }
}

_id_EBB0(var_0, var_1) {
  _id_EB7A();
  level._id_13ED3 = var_0;
  _id_1888(level._id_13EC5 * var_0, level._id_13EC3 * var_0, level._id_13EC4 * (1 / var_0), var_1);
}

_id_1888(var_0, var_1, var_2, var_3) {
  self notify("zerog_parm_adjust");
  _id_EB7A();
  self endon("zerog_parm_adjust");
  var_4 = 0.05;
  var_5 = int(var_3 / var_4);
  var_6 = getdvarint("player_zeroGravSpeed");
  var_7 = getdvarint("player_zeroGravAcceleration");
  var_8 = getdvarint("player_zeroGravFriction");
  var_9 = (var_0 - var_6) / var_5;
  var_10 = (var_1 - var_7) / var_5;
  var_11 = (var_2 - var_8) / var_5;

  for(var_12 = 0; var_12 < var_5; var_12++) {
    var_6 = var_6 + var_9;
    setsaveddvar("player_zeroGravSpeed", var_6);
    var_7 = var_7 + var_10;
    setsaveddvar("player_zeroGravAcceleration", var_7);
    var_8 = var_8 + var_11;
    setsaveddvar("player_zeroGravFriction", var_8);
    wait(var_4);
  }

  setsaveddvar("player_zeroGravSpeed", var_0);
  setsaveddvar("player_zeroGravAcceleration", var_1);
  setsaveddvar("player_zeroGravFriction", var_2);
}