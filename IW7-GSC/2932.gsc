/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2932.gsc
**************************************/

_id_10547(var_0) {
  if(!isDefined(level._id_10534)) {
    level._id_10534 = spawnStruct();
    level._id_10534._id_A7B8 = scripts\engine\utility::spawn_tag_origin();
    level._effect["vfx_magboot_light_green"] = loadfx("vfx/iw7/_requests/airlock/vfx_light_green.vfx");
    level._effect["vfx_magboot_light_orange"] = loadfx("vfx/iw7/_requests/magboots/vfx_light_orange.vfx");
    level._effect["vfx_magboot_light_red"] = loadfx("vfx/iw7/_requests/airlock/vfx_light_red.vfx");
    setsaveddvar("spaceJumpTimerTakeoff", 0.5);
    setsaveddvar("spaceJumpTimerTakeoffUseAnimTime", 0);
    setsaveddvar("spaceJumpLandGestureTimeOffset", 0.2);
    level._id_10534._id_10561 = getdvarfloat("spaceJumpCoverTraceRadius");
    level._id_10534._id_10560 = getdvarfloat("spaceJumpCoverTraceDist");
    level._id_10534._id_1056A = getdvarfloat("spaceJumpFlatNormalCheck");
    level._id_10534._id_10569 = getdvarfloat("spaceJumpFlatDistCheck");
    level._id_10534._id_1056B = getdvarfloat("spaceJumpHeightCheck");
    setsaveddvar("spaceJumpFlatDistCheck", 150);
    setsaveddvar("spaceJumpHeightCheck", 24);
    level._id_10534._id_11183 = 3;
    level._id_10534._id_A4C4 = 0;
    level._id_10534._id_B755 = 150;
    level._id_10534._id_B46D = 650;
    level._id_10534._id_B740 = 350;
    level._id_10534._id_B42D = 3000;
    level._id_10534._id_B6E4 = 200;
    level._id_10534._id_B6E5 = 50;
    level._id_10534._id_8EFB = [];
    level._id_10534._id_A98E = undefined;
    _id_10552("land_anim", ::_id_10535);
  }

  if(!isDefined(self._id_10547)) {
    self._id_10547 = 1;
    thread _id_10553();
    thread _id_10557();
    thread _id_10539();

    if(isDefined(var_0)) {
      return;
    }
  }
}

_id_10551() {
  precacheshader("reticle_center_dot");
  precacheshader("reticle_center_circle");
}

_id_1053A() {
  scripts\engine\utility::flag_init("used_spacejump");
  scripts\engine\utility::flag_init("enable_space_jump");
  scripts\engine\utility::flag_init("spacejump_gunless");
  scripts\engine\utility::flag_init("hide_spacejump_visor");
}

_id_1054E() {
  var_0 = ["j_ball_le", "j_ball_le", "j_ball_ri", "j_ball_ri"];
  var_1 = [(0, 0.1, 2.5), (0, 0.1, -2.5), (0, 0.1, 2.5), (0, 0.1, -2.5)];
  var_2 = ["left", "left", "right", "right"];
  self._id_AB46 = [];
  self._id_E521 = [];

  foreach(var_6, var_4 in var_0) {
    var_5 = scripts\engine\utility::spawn_tag_origin();
    var_5 linkTo(self, var_0[var_6], var_1[var_6], (0, 0, 0));
    var_5 thread scripts\engine\utility::draw_ent_axis_forever((1, 0, 0));

    if(var_2[var_6] == "left") {
      self._id_AB46 = scripts\engine\utility::array_add(self._id_AB46, var_5);
      continue;
    }

    self._id_E521 = scripts\engine\utility::array_add(self._id_E521, var_5);
  }

  _id_1054F("left", "off");
  _id_1054F("right", "off");
  thread _id_1054A();
}

_id_1054D(var_0) {
  if(var_0 == "attach") {
    return "vfx_magboot_light_green";
  } else if(var_0 == "detach") {
    return "vfx_magboot_light_red";
  } else if(var_0 == "off") {
    return "vfx_magboot_light_orange";
  }
}

_id_10548() {
  _id_1054F("left", "attach");
}

_id_1054B() {
  _id_1054F("left", "detach");
}

_id_10549() {
  _id_1054F("right", "attach");
}

_id_1054C() {
  _id_1054F("right", "detach");
}

_id_1054F(var_0, var_1) {
  self endon("death");
  self endon("delete_magboot_lights");

  if(var_0 == "left") {
    if(isDefined(self._id_AB40)) {
      foreach(var_3 in self._id_AB46) {
        var_4 = _id_1054D(self._id_AB40);

        if(isDefined(var_4)) {
          killfxontag(scripts\engine\utility::getfx(var_4), var_3, "tag_origin");
        }
      }
    }

    foreach(var_3 in self._id_AB46) {
      var_4 = _id_1054D(var_1);

      if(isDefined(var_4)) {
        playFXOnTag(scripts\engine\utility::getfx(var_4), var_3, "tag_origin");
      }
    }

    self._id_AB40 = var_1;
  } else {
    if(isDefined(self._id_E51B)) {
      foreach(var_3 in self._id_E521) {
        var_4 = _id_1054D(self._id_E51B);

        if(isDefined(var_4)) {
          killfxontag(scripts\engine\utility::getfx(var_4), var_3, "tag_origin");
        }
      }
    }

    foreach(var_3 in self._id_E521) {
      var_4 = _id_1054D(var_1);

      if(isDefined(var_4)) {
        playFXOnTag(scripts\engine\utility::getfx(var_4), var_3, "tag_origin");
      }
    }

    self._id_E51B = var_1;
  }
}

_id_1054A() {
  scripts\engine\utility::waittill_either("death", "delete_magboot_lights");

  foreach(var_1 in self._id_AB46) {
    var_1 delete();
  }

  foreach(var_1 in self._id_E521) {
    var_1 delete();
  }
}

_id_1306D() {
  return scripts\engine\utility::flag("used_spacejump");
}

_id_10538(var_0, var_1) {
  setsaveddvar("spaceJumpSpringCamActive", 1);
  setsaveddvar("spaceJumpSpringCamMaxAngle", var_0);
  setsaveddvar("spaceJumpSpringCamStrength", var_1);
}

_id_10537() {
  setsaveddvar("spaceJumpSpringCamActive", 0);
}

#using_animtree("player");

_id_10550() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["stumble_1_legs"] = % vm_grav_jump_1st_out_legs;
  level._id_EC85["player_rig"]["stumble_2_legs"] = % vm_grav_jump_2nd_out_legs;
  level._id_EC85["player_rig"]["stumble_3_legs"] = % vm_grav_jump_3rd_out_legs;
  level._id_EC85["player_rig"]["gunless_00_legs"] = % vm_grav_jump_gunless_out_00_legs;
  level._id_EC85["player_rig"]["gunless_30_legs"] = % vm_grav_jump_gunless_out_30_legs;
  level._id_EC85["player_rig"]["gunless_60_legs"] = % vm_grav_jump_gunless_out_60_legs;
  level._id_EC85["player_rig"]["gunless_90_legs"] = % vm_grav_jump_gunless_out_90_legs;
}

_id_1C66(var_0, var_1) {
  if(var_0) {
    scripts\engine\utility::flag_set("enable_space_jump");
    self _meth_84EC(1);

    if(var_1) {
      self _meth_84DE("ges_grav_jump_gunless_90", "ges_grav_jump_gunless_fail", "ges_grav_jump_gunless_90_up", "ges_grav_jump_gunless_90_down", "ges_grav_jump_gunless_90_left", "ges_grav_jump_gunless_90_right", level._id_10534._id_A7B8);
      scripts\engine\utility::flag_set("spacejump_gunless");
      _id_10538(10, 0.15);
      _id_10555("ges_grav_jump_gunless_90");
    } else {
      self _meth_84DE("ges_grav_jump_combat", "ges_grav_jump_combat_fail", "ges_grav_jump_combat_up", "ges_grav_jump_combat_down", "ges_grav_jump_combat_left", "ges_grav_jump_combat_right", level._id_10534._id_A7B8);
      scripts\engine\utility::flag_clear("spacejump_gunless");
      _id_10537();
      _id_10555("ges_grav_jump_combat");
    }
  } else {
    scripts\engine\utility::flag_clear("enable_space_jump");
    self _meth_84EC(0);
    self _meth_84DF();
  }
}

_id_384E() {
  return scripts\engine\utility::flag("enable_space_jump");
}

_id_650E() {
  self endon("death");

  for(;;) {
    level waittill("spacejump_takeoff");
    var_0 = self._id_2894;
    self._id_2894 = 0.1;
    level waittill("spacejump_land");
    self._id_2894 = var_0;
  }
}

_id_9CC6() {
  return self _meth_84F4() != "none";
}

_id_1055C(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    scripts\engine\utility::array_thread(var_2, ::_id_1055D);
  } else
    _id_1055C();
}

_id_1055D() {
  self _meth_84C0(1);
  scripts\engine\utility::trigger_on();
}

_id_1055A(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = getEntArray(var_0, var_1);
    scripts\engine\utility::array_thread(var_2, ::_id_1055B);
  } else
    _id_1055A();
}

_id_1055B() {
  self _meth_84C0(0);
  scripts\engine\utility::trigger_off();
}

_id_1C51(var_0) {
  if(var_0) {
    scripts\engine\utility::allow_jump(0);
    scripts\engine\utility::allow_slide(0);
    scripts\engine\utility::allow_prone(0);
    scripts\engine\utility::allow_wallrun(0);
    scripts\engine\utility::allow_doublejump(0);
    self setmovespeedscale(0.7);
    setsaveddvar("mantle_enable", 0);
    setsaveddvar("player_sprintSpeedScale", 1.3);
  } else {
    scripts\engine\utility::allow_jump(1);
    scripts\engine\utility::allow_slide(1);
    scripts\engine\utility::allow_prone(1);
    scripts\engine\utility::allow_wallrun(1);
    scripts\engine\utility::allow_doublejump(1);
    self setmovespeedscale(1.0);
    setsaveddvar("mantle_enable", 1);
    setsaveddvar("player_sprintSpeedScale", 1.4);
  }
}

_id_10553() {
  self endon("death");
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "center";
  var_0.aligny = "middle";
  var_0.horzalign = "center";
  var_0.vertalign = "middle";
  var_0 setshader("reticle_center_dot", 24, 24);
  var_1 = newhudelem();
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "middle";
  var_1 setshader("reticle_center_circle", 24, 24);

  for(;;) {
    if(!scripts\engine\utility::flag("enable_space_jump") || scripts\engine\utility::flag("hide_spacejump_visor") || !scripts\engine\utility::flag("spacejump_gunless")) {
      var_0.alpha = 0.0;
      var_1.alpha = 0.0;
    } else {
      var_0.alpha = 1.0;
      var_1.alpha = 0.25;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_FC16() {
  var_0 = "";
  var_1 = "";

  if(level._id_10534._id_A4C4 == 0) {
    var_0 = "scn_gravity_jump_detach_01";
    var_1 = "scn_gravity_jump_travel_01";
  } else if(level._id_10534._id_A4C4 == 1) {
    var_0 = "scn_gravity_jump_detach_02";
    var_1 = "scn_gravity_jump_travel_02";
  } else if(level._id_10534._id_A4C4 == 3) {
    var_0 = "scn_gravity_jump_detach_04";
    var_1 = "scn_gravity_jump_travel_04";
  } else if(level._id_10534._id_A4C4 == 4) {
    var_0 = "scn_gravity_jump_detach_05";
    var_1 = "scn_gravity_jump_travel_05";
  } else {
    var_0 = "scn_gravity_jump_detach_03";
    var_1 = "scn_gravity_jump_travel_03";
  }

  self playSound(var_0);
  thread scripts\engine\utility::play_loop_sound_on_entity(var_1);
  self waittill("spacejump_land");
  thread scripts\engine\utility::stop_loop_sound_on_entity(var_1);
}

_id_FC17(var_0) {
  if(level._id_10534._id_A4C4 == 1) {
    var_0 = "scn_gravity_jump_land_01";
  } else if(level._id_10534._id_A4C4 == 2) {
    var_0 = "scn_gravity_jump_land_02";
  } else if(level._id_10534._id_A4C4 == 3) {
    var_0 = "scn_gravity_jump_land_03";
  } else if(level._id_10534._id_A4C4 == 4) {
    var_0 = "scn_gravity_jump_land_04";
  } else if(level._id_10534._id_A4C4 == 5) {
    var_0 = "scn_gravity_jump_land_05";
  }

  self waittill("spacejump_land");
  self playSound(var_0);
}

_id_10557() {
  for(;;) {
    self waittill("spacejump_takeoff", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    level.player thread _id_FC16();
    level._id_10534._id_A7B8.origin = var_0;

    if(isDefined(var_4)) {
      level._id_4B9B = var_4 getlinkedparent();
    }

    if(var_6) {
      self waittill("spacejump_movertakeoff", var_0, var_1, var_2, var_3, var_4, var_5, var_6);
    }

    var_7 = distance(self.origin, var_0);
    _id_10554(var_7, var_4);
    scripts\engine\utility::flag_clear("can_save");
    scripts\engine\utility::flag_set("used_spacejump");
    setglobalsoundcontext("spacejump", "jump", 2);
    level._id_10534._id_A4C4++;

    if(scripts\engine\utility::flag("spacejump_gunless")) {
      scripts\engine\utility::allow_ads(0);
    }

    scripts\engine\utility::allow_usability(0);
    scripts\engine\utility::allow_weapon_switch(0);
    scripts\engine\utility::allow_reload(0);
    self _meth_80CB(1);
    self _meth_84FE();
    thread _id_10536();
    var_8 = 0;

    if(isDefined(var_3) && isDefined(var_3.script_parameters)) {
      var_8 = 1;
      self thread[[level._id_10534._id_8EFB[var_3.script_parameters]]](var_0, var_1, var_2, var_3, var_4, var_5);
    } else if(scripts\engine\utility::flag("spacejump_gunless")) {
      var_8 = 1;
      thread _id_10541(var_0, var_1, var_2, var_3, var_4, var_5);
    }

    var_9 = self physics_getcharactercollisioncapsule();
    level._id_10534._id_A7B8.origin = var_0;
    createnavrepulsor("spacejump_repulsor", -1, var_0, var_9["radius"] * 1.5, 1, "all");
    level._id_10534._id_A7B8 _meth_8444(var_9["half_height"] * 2.5);
    self waittill("spacejump_land");
    setglobalsoundcontext("spacejump", "", 2);
    destroynavrepulsor("spacejump_repulsor");
    level._id_10534._id_A7B8 _meth_8445();

    if(var_8) {
      level waittill("vignette_land_end");
    }

    if(scripts\engine\utility::flag("spacejump_gunless")) {
      scripts\engine\utility::allow_ads(1);
    }

    scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::allow_weapon_switch(1);
    scripts\engine\utility::allow_reload(1);
    self _meth_80CB(0);
    self _meth_84FD();
    scripts\engine\utility::flag_set("can_save");
    level._id_4B9B = undefined;
  }
}

_id_10554(var_0, var_1) {
  if(isai(var_1) || var_1 scripts\sp\fakeactor::_id_9BDF()) {
    var_2 = scripts\sp\math::_id_DF68(var_0 * 2.0, level._id_10534._id_B740, level._id_10534._id_B42D, level._id_10534._id_B755, level._id_10534._id_B46D);
    setsaveddvar("spaceJumpSpeed", var_2);
  } else if(var_0 < level._id_10534._id_B6E4) {
    var_2 = level._id_10534._id_B6E5;
    setsaveddvar("spaceJumpSpeed", var_2);
  } else {
    var_2 = scripts\sp\math::_id_DF68(var_0, level._id_10534._id_B740, level._id_10534._id_B42D, level._id_10534._id_B755, level._id_10534._id_B46D);
    setsaveddvar("spaceJumpSpeed", var_2);
  }
}

_id_10539() {
  for(;;) {
    self waittill("spacejump_fail", var_0, var_1, var_2, var_3, var_4, var_5, var_6);

    while(self isgestureplaying("ges_grav_jump_gunless_fail") || self isgestureplaying("ges_grav_jump_combat_fail")) {
      scripts\engine\utility::waitframe();
    }
  }
}

_id_10552(var_0, var_1) {
  level._id_10534._id_8EFB[var_0] = var_1;
}

_id_10555(var_0) {
  level._id_10534._id_A98E = var_0;
}

_id_1053F() {
  return level._id_10534._id_A98E;
}

_id_10536() {
  self endon("spacejump_land");
  self waittill("deathshield", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  setDvar("player_death_animated", 0);

  if(isDefined(level._id_10534._id_4E21)) {
    self _meth_84EB("ges_grav_jump_death_jackal_left", 0.2, level._id_10534._id_4E21);
  } else {
    self _meth_84EB("ges_grav_jump_gunless_death", 0.2);
  }

  scripts\sp\utility::_id_B8D1();
}

_id_10535(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\sp\utility::_id_10639("player_rig", var_0, var_1);
  var_6 dontinterpolate();
  var_6 hide();
  var_7 = var_3.script_animation + "_legs";
  var_8 = "ges_grav_jump_" + var_3.script_animation;

  if(var_5 != "none") {
    var_8 = var_8 + ("_" + var_5);
  }

  _id_10555(var_8);
  _id_10556(var_0, var_1, var_6, var_7, var_8);
}

_id_10556(var_0, var_1, var_2, var_3, var_4) {
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_2 scripts\sp\anim::_id_1EC3(var_2, var_3);
  var_5 = var_2 gettagorigin("tag_player");
  var_6 = var_2 gettagangles("tag_player");
  self _meth_84E7(var_5, var_6, var_4, 0.2, 0, 1);
  self waittill("spacejump_land");
  wait 0.1;
  self _meth_823C(var_2, "tag_player", 0.1);
  var_2 show();
  var_2 scripts\sp\anim::_id_1F35(var_2, var_3);
  self unlink();
  var_2 delete();
  level notify("vignette_land_end");
}

_id_10541(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\sp\utility::_id_10639("player_rig", var_0, var_1);
  var_6 dontinterpolate();
  var_6 hide();
  var_7 = "";
  var_8 = "scn_gravity_jump_land_generic";

  if(level._id_10534._id_A4C4 <= level._id_10534._id_11183) {
    var_7 = "stumble_" + level._id_10534._id_A4C4;
  } else {
    var_9 = vectorNormalize(var_0 - self.origin);
    var_10 = anglestoup(var_1);
    var_11 = vectordot(var_9, var_10);
    var_12 = acos(var_11);
    var_13 = acos(var_11) - 90;

    if(var_13 >= 75) {
      var_7 = "gunless_90";
      var_8 = "scn_gravity_jump_land_90";
    } else if(var_13 > 45 && var_13 < 75) {
      var_7 = "gunless_60";
      var_8 = "scn_gravity_jump_land_60";
    } else if(var_13 > 15 && var_13 <= 45) {
      var_7 = "gunless_30";
      var_8 = "scn_gravity_jump_land_30";
    } else if(var_13 <= 15) {
      var_7 = "gunless_00";
      var_8 = "scn_gravity_jump_land_00";
    }
  }

  var_14 = var_7 + "_legs";
  var_15 = "ges_grav_jump_" + var_7;

  if(var_5 != "none") {
    var_15 = var_15 + ("_" + var_5);
  }

  _id_10555(var_15);
  thread _id_FC17(var_8);
  _id_10556(var_0, var_1, var_6, var_14, var_15);
}