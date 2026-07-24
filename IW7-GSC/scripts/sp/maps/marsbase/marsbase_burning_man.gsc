/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_burning_man.gsc
*************************************************************/

_id_10BC4() {
  var_0 = ["salter", "griff", "ethan", "brooks"];
  level._id_1493 = scripts\sp\maps\marsbase\marsbase_util::_id_10626(var_0, "ally_start_caves", 1);
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("player_start_caves", "targetname"));
  scripts\sp\maps\marsbase\marsbase_util::_id_B3AA("fxanim_sp_mars_crane");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3AB("aa2_destruction");
  scripts\sp\maps\marsbase\marsbase_util::_id_B3AB("aa2_rubble");
  scripts\sp\maps\marsbase\marsbase_caves::_id_14D5(1);
  thread scripts\sp\maps\marsbase\marsbase_code::_id_14E8("aa_gun_2", 1);
  level notify("aagun_destroyed", "aa_gun_2");
  scripts\sp\utility::_id_15F5("orbit_canyon1");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("aa2_complete");
}

_id_B19A() {
  scripts\engine\utility::flag_init("flag_burning_man_door_closed");
  scripts\engine\utility::flag_init("flag_airlock_door_open");
  scripts\engine\utility::flag_init("flag_burning_man_allies_move");
  scripts\engine\utility::flag_init("flag_airlock_door_open_clear");
  scripts\sp\utility::_id_2669("Caves");
  thread scripts\sp\maps\marsbase\marsbase_caves::_id_14C6();
  scripts\sp\maps\marsbase\marsbase_util::_id_F3B6();
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7();
  thread _id_A5B2();
  level.player thread _id_329B();
  level.player thread _id_11779();
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_53F9();
  wait 0.1;
  scripts\engine\utility::flag_wait("player_and_heroes_in_aa2");
  level thread scripts\sp\utility::_id_12641("marsbase_tunnel_airlock_tr");
  level thread scripts\sp\utility::_id_12641("marsbase_combat_elevator_tr");
  level thread scripts\sp\utility::_id_12641("marsbase_combat_pre_elevator_tr");
  _id_3BA3();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  _id_5150();
  level notify("burning_man_done");
  scripts\sp\utility::_id_10FEC("vfx_exp_tunnel_explosion");
}

_id_3B44() {
  _id_5150();
  thread scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_2");
}

_id_5150() {
  var_0 = getEntArray("burning_man_ents", "script_noteworthy");
  scripts\sp\utility::_id_228A(var_0);
}

_id_A5B2() {
  scripts\engine\utility::flag_wait("flag_burning_man_airlock_approached");
  var_0 = getEnt("trig_burning_tunnel", "targetname");
  var_1 = getaiarray("axis");

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3) && !var_3 istouching(var_0)) {
        var_3 delete();
      }
    }
  }
}

_id_329B() {
  childthread _id_329C();
  scripts\engine\utility::flag_wait("flag_enter_burning_tunnel");

  while(!scripts\engine\utility::flag("flag_airlock_door_open")) {
    scripts\engine\utility::flag_wait_any("player_in_mars_killstreak", "flag_airlock_door_open");

    if(scripts\engine\utility::flag("flag_enter_burning_tunnel") && !scripts\engine\utility::flag("flag_airlock_door_open")) {
      scripts\sp\maps\marsbase\marsbase_util::_id_F47B(1);
      scripts\engine\utility::flag_waitopen("player_in_mars_killstreak");
      continue;
    }

    scripts\sp\maps\marsbase\marsbase_util::_id_F47C();
    scripts\engine\utility::flag_wait_any("flag_enter_burning_tunnel", "flag_airlock_door_open");
  }
}

_id_329C() {
  while(!scripts\engine\utility::flag("flag_airlock_door_open")) {
    scripts\engine\utility::flag_wait("flag_enter_burning_tunnel");
    scripts\engine\utility::flag_clear("flag_exit_burning_tunnel");
    scripts\engine\utility::flag_wait("flag_exit_burning_tunnel");
    scripts\engine\utility::flag_clear("flag_enter_burning_tunnel");
  }
}

_id_11779() {
  var_0 = 150;
  var_1 = 60;
  self._id_116C8 = 60;
  var_2 = -250;
  var_3 = 350;
  var_4 = 1;
  var_5 = 1;
  var_6 = 0;
  var_7 = 0.05;
  var_8 = 10;
  var_9 = 5;
  var_10 = 10;
  var_11 = 20;
  level._id_11695 = 0;

  if(!isDefined(self.burning)) {
    self.burning = 0;
  }

  var_12 = getEnt("trig_burning_tunnel", "targetname");
  var_13 = getEntArray("trig_burning_man_flamejet", "targetname");

  if(!scripts\engine\utility::flag_exist("burning_tunnel_heat_gesture")) {
    scripts\engine\utility::flag_init("burning_tunnel_heat_gesture");
  }

  if(!scripts\engine\utility::flag_exist("heat_gesture_lock")) {
    scripts\engine\utility::flag_init("heat_gesture_lock");
  }

  while(!scripts\engine\utility::flag("flag_airlock_door_open")) {
    if(self istouching(var_12)) {
      if(!level._id_11695) {
        _id_12992();
        thread _id_1885(var_2, var_3);
        level._id_11695 = 1;
      }

      if(var_6 == 0) {
        var_6 = 1;
        var_5 = 0;
      }

      var_14 = var_0;
      var_15 = var_14 + var_11;
      var_16 = var_14 - var_11;

      if(self._id_116C8 < var_15) {
        self._id_116C8 = self._id_116C8 + var_8;
      } else if(self._id_116C8 > var_16) {
        self._id_116C8 = self._id_116C8 - var_9;
      } else {
        var_17 = randomintrange(-1, 1);
        self._id_116C8 = self._id_116C8 + var_17;
      }
    } else {
      if(var_6) {
        var_6 = 0;
        var_5 = 0;
      }

      if(self._id_116C8 > var_1) {
        self._id_116C8 = self._id_116C8 - var_10;
      }
    }

    wait 0.1;
  }

  _id_12970();
}

_id_1885(var_0, var_1) {
  level notify("temp_gauge_on");
  level endon("temp_gauge_on");
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    var_4 = scripts\sp\math::_id_6A8E(-250, 350, scripts\sp\math::_id_C097(var_0, var_1, self._id_116C8));
    level.player setclientomnvar("ui_helmet_meter_temperature", int(var_4));
    scripts\engine\utility::waitframe();

    if(var_4 > 100 && !var_3) {
      var_3 = 1;
    } else if(var_4 < 100 && !var_2 && var_3) {
      level.player notify("stop_temperature_sfx");
      var_2 = 1;
    } else if(var_4 >= 100 && var_2 && var_3) {
      thread _id_B3AC();
      var_2 = 0;
    }

    if(self._id_116C8 == var_0) {
      break;
    }
  }

  wait 1;
  _id_12970();
}

_id_12992() {
  level.player setclientomnvar("ui_show_temperature_gauge", 1);
  level._id_11695 = 1;
  thread _id_B3AC();
}

_id_12970() {
  level.player setclientomnvar("ui_show_temperature_gauge", 0);
  level._id_11695 = 0;
  level.player notify("stop_temperature_sfx");
}

_id_8CD1(var_0, var_1, var_2, var_3) {
  var_4 = self._id_116C8 + var_2 * var_3;

  if(var_4 > var_0) {
    return var_0;
  }

  if(var_4 < var_1) {
    return var_1;
  }

  return var_4;
}

_id_B3AC() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkTo(level.player);
  wait 0.05;
  var_0 playSound("ui_mars_base_temperature_warning_lp_start");
  var_0 thread marsbase_temperature_sfx_lp();
  wait 0.5;
  level.player scripts\engine\utility::waittill_any("stop_temperature_sfx", "death");
  var_0 stoploopsound("ui_mars_base_temperature_warning_lp");
  var_0 delete();
  level.player playSound("ui_mars_base_temperature_warning_lp_end");
}

marsbase_temperature_sfx_lp() {
  level.player endon("stop_temperature_sfx");
  level.player endon("death");
  wait 1.7;
  self playLoopSound("ui_mars_base_temperature_warning_lp");
}

_id_3BA3() {
  scripts\sp\utility::_id_15F5("burning_man_allies_intro_colortrig");
  level thread _id_3BA2();
  level thread _id_CCBD();
  level thread _id_CC7A();
  scripts\engine\utility::flag_wait("flag_burning_man_cave_approach_reached");
  scripts\sp\utility::_id_15F5("burning_man_allies_approach_colortrig");
  scripts\engine\utility::flag_set("flag_burning_man_cave_interior_reached");
  scripts\engine\utility::flag_wait("flag_burning_man_cave_entrance_reached");
  scripts\sp\utility::_id_15F5("burning_man_allies_enter_colortrig");
  scripts\engine\utility::flag_wait_all("flag_burning_man_allies_move", "flag_burning_man_scene_start");
  scripts\sp\utility::_id_15F5("burning_man_allies_inside_colortrig");
  scripts\engine\utility::flag_wait("flag_burning_man_airlock_approached");

  if(!level.console) {
    waitfortransient("marsbase_tunnel_airlock_tr");
  }

  scripts\sp\utility::_id_15F5("burning_man_allies_wait_door_colortrig");
  scripts\engine\utility::flag_wait("flag_airlock_door_open");
}

_id_CC7A() {
  var_0 = getEnt("mdl_airlock_klaxon", "script_noteworthy");
  var_1 = getEntArray("mdl_airlock_klaxon_lights", "script_noteworthy");

  if(isDefined(var_0) && isDefined(var_1)) {
    scripts\sp\maps\marsbase\marsbase_util::_id_A6E3(var_0, var_1, 1);
    level waittill("stop_airlock_klaxon");
    scripts\sp\maps\marsbase\marsbase_util::_id_A6E3(var_0, var_1, 0);
    scripts\sp\utility::_id_228A(var_1);
    var_0 delete();
  }
}

_id_CCBD() {
  scripts\sp\maps\marsbase\marsbase_util::_id_1069C("burning_man_dead_bodies", "cleanup_dead_bodies_burning_man");
  thread _id_10660();
  var_0 = scripts\engine\utility::getStruct("tag_align_burning_guy", "targetname");
  var_0.angles = (0, 0, 0);
  var_1 = getEnt("burning_man", "script_noteworthy");
  var_2 = getEnt("burning_crawling", "script_noteworthy");
  var_3 = getEnt("burning_unaligned", "script_noteworthy");
  var_1 scripts\sp\utility::_id_1747(::_id_3296, "burning_man", var_0);
  var_2 scripts\sp\utility::_id_1747(::_id_3296, "burning_man_crawling", var_0);
  var_3 scripts\sp\utility::_id_1747(::_id_3296, "burning_man_top", var_0);
  scripts\engine\utility::flag_wait("flag_burning_man_scene_start");
  level thread _id_C0C6();
  var_4 = var_1 scripts\sp\utility::_id_10619(1);
  level._id_3297 = var_4;
  level notify("burning_man");
  scripts\engine\utility::flag_wait("flag_burning_man_crawling");
  var_5 = var_2 scripts\sp\utility::_id_10619(1);
  scripts\engine\utility::flag_wait("flag_burning_man_airlock_start_unaligned");
  var_6 = var_3 scripts\sp\utility::_id_10619(1);
}

_id_3B45() {
  scripts\sp\maps\marsbase\marsbase_util::_id_1069C("burning_man_dead_bodies", "cleanup_dead_bodies_burning_man");
  thread _id_10660();
  var_0 = scripts\engine\utility::getStruct("tag_align_burning_guy", "targetname");
  var_0.angles = (0, 0, 0);
  var_1 = getEnt("burning_man", "script_noteworthy");
  var_2 = getEnt("burning_crawling", "script_noteworthy");
  var_3 = getEnt("burning_unaligned", "script_noteworthy");
  var_1 scripts\sp\utility::_id_1747(::_id_3296, "burning_man", var_0, 1);
  var_2 scripts\sp\utility::_id_1747(::_id_3296, "burning_man_crawling", var_0, 1);
  var_3 scripts\sp\utility::_id_1747(::_id_3296, "burning_man_top", var_0, 1);
  var_4 = var_2 scripts\sp\utility::_id_10619(1);
  var_5 = var_1 scripts\sp\utility::_id_10619(1);
  var_6 = var_3 scripts\sp\utility::_id_10619(1);
}

_id_3296(var_0, var_1, var_2) {
  self endon("death");
  self._id_2708 = 1;
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, self);
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0);
  var_3 = "j_spinelower";
  self._id_1FBB = "generic";
  self._id_10265 = 1;
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  self _meth_84AE();
  self setcontents(0);
  scripts\sp\utility::_id_16B7(scripts\sp\maps\marsbase\marsbase_util::_id_1916);
  self playLoopSound("emt_fire_small_lp_02");
  scripts\sp\utility::_id_75C4("burning_arm_left", "j_shoulder_le");
  scripts\sp\utility::_id_75C4("burning_arm_right", "j_shoulder_ri");
  scripts\sp\utility::_id_75C4("burning_chest", "j_chest");
  scripts\sp\utility::_id_75C4("burning_legs", "j_hip_le");
  scripts\sp\utility::_id_75C4("burning_legs", "j_hip_ri");
  self._id_EE5F = 1;
  scripts\sp\utility::_id_F2A8(1);
  self._id_10265 = 1;

  if(!var_2) {
    var_1 scripts\sp\anim::_id_1F35(self, var_0);
  }

  scripts\sp\utility::_id_54C6();
  scripts\engine\utility::flag_wait("flag_airlock_door_open");
  stopFXOnTag(scripts\engine\utility::getfx("burning_arm_left"), self, "j_shoulder_le");
  stopFXOnTag(scripts\engine\utility::getfx("burning_arm_right"), self, "j_shoulder_ri");
  stopFXOnTag(scripts\engine\utility::getfx("burning_chest"), self, "j_chest");
  stopFXOnTag(scripts\engine\utility::getfx("burning_legs"), self, "j_hip_le");
  stopFXOnTag(scripts\engine\utility::getfx("burning_legs"), self, "j_hip_ri");
  self stoploopsound();
}

_id_C0C6() {
  wait 2.2;
  scripts\engine\utility::flag_set("flag_burning_man_allies_move");
}

_id_4035(var_0) {
  scripts\engine\utility::flag_wait("flag_burning_man_door_closed");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_pr_fire_medium"), self, "tag_origin");
  self delete();

  if(isalive(var_0)) {
    var_0 delete();
  }
}

_id_10660() {
  var_0 = getEntArray("dead_body", "targetname");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_75C4("burning_arm_left", "j_shoulder_le");
    var_2 scripts\sp\utility::_id_75C4("burning_arm_right", "j_shoulder_ri");
    var_2 scripts\sp\utility::_id_75C4("burning_chest", "j_chest");
    var_2 scripts\sp\utility::_id_75C4("burning_legs", "j_hip_le");
    var_2 scripts\sp\utility::_id_75C4("burning_legs", "j_hip_ri");
    level thread _id_3295(var_2.origin);
  }

  level waittill("cleanup_dead_bodies_burning_man");

  foreach(var_2 in var_0) {
    stopFXOnTag(scripts\engine\utility::getfx("burning_arm_left"), var_2, "j_shoulder_le");
    stopFXOnTag(scripts\engine\utility::getfx("burning_arm_right"), var_2, "j_shoulder_ri");
    stopFXOnTag(scripts\engine\utility::getfx("burning_chest"), var_2, "j_chest");
    stopFXOnTag(scripts\engine\utility::getfx("burning_legs"), var_2, "j_hip_le");
    stopFXOnTag(scripts\engine\utility::getfx("burning_legs"), var_2, "j_hip_ri");
    level notify("stop_burn_snd");
  }
}

_id_3295(var_0) {
  var_1 = spawn("script_origin", var_0);
  var_1 playLoopSound("emt_fire_med_lp_01");
  var_1 waittill("stop_burn_snd");
  var_1 stoploopsound();
}

_id_3BA2() {
  var_0 = scripts\engine\utility::getStruct("burning_man_airlock_door_kit", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("burning_man_airlock_door_exterior_kit", "script_noteworthy");
  var_2 = getEntArray("burning_man_airlock_door_kit", "script_noteworthy");
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(var_5.classname == "script_model") {
      var_3 = var_5;
      continue;
    }

    var_3.clip = var_5;
  }

  var_2 = getEntArray("burning_man_airlock_door_exterior_kit", "script_noteworthy");
  var_7 = undefined;

  foreach(var_5 in var_2) {
    if(var_5.classname == "script_model") {
      var_7 = var_5;
      continue;
    }

    var_7.clip = var_5;
  }

  var_3.clip linkTo(var_3, "door_JNT");
  var_7.clip linkTo(var_7, "door_JNT");
  var_3.clip connectpaths();
  var_3 scripts\sp\utility::_id_23B7("airlock_door");
  var_7 scripts\sp\utility::_id_23B7("airlock_door");
  var_0 thread scripts\sp\anim::_id_1EC3(var_3, "close_airlock");
  var_1 thread scripts\sp\anim::_id_1EC3(var_7, "open_airlock");
  scripts\engine\utility::flag_wait_all("flag_burning_man_allies_move", "flag_burning_man_scene_start", "flag_burning_man_airlock_approached");
  level._id_EA2C thread scripts\sp\coverwall::_id_596D();
  level._id_6754 thread scripts\sp\coverwall::_id_596D();
  level._id_30F6 thread scripts\sp\coverwall::_id_596D();
  level._id_8604 thread scripts\sp\coverwall::_id_596D();
  var_7 _id_13743();

  if(!isDefined(level._id_1493)) {
    level._id_1493 = [level._id_6754, level._id_30F6, level._id_EA2C, level._id_8604];
  }

  var_10 = getcorpsearray();
  clearallcorpses();
  _id_3BA1();
  var_7.clip connectpaths();
  level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig");
  level.player._id_E505 hide();
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player _meth_823C(level.player._id_E505, "tag_player", 0.5);
  var_1 scripts\sp\anim::_id_1EC3(level.player._id_E505, "open_airlock");
  wait 0.75;
  var_0 scripts\engine\utility::delaythread(2, scripts\sp\anim::_id_1F35, var_3, "close_airlock");
  var_1 thread scripts\sp\anim::_id_1F35(var_7, "open_airlock");
  level.player playSound("mars_burningman_airlock_open");
  thread scripts\engine\utility::flag_set_delayed("flag_airlock_door_open_clear", 3.5);
  var_7 thread _id_E7BC();
  var_1 _id_D215();
  var_11 = getEnt("burning_man_squad_clear_vol", "targetname");
  var_12 = scripts\engine\utility::array_add(level._id_1493, level.player);
  var_11 scripts\sp\maps\marsbase\marsbase_util::_id_13828(var_12);
  var_1 thread scripts\sp\anim::_id_1F35(var_7, "close_airlock");
  var_7 thread _id_4251();
  var_11 delete();
  scripts\engine\utility::flag_set("flag_burning_man_door_closed");
  level._id_EA2C thread scripts\sp\coverwall::_id_551C();
  level._id_6754 thread scripts\sp\coverwall::_id_551C();
  level._id_30F6 thread scripts\sp\coverwall::_id_551C();
  level._id_8604 thread scripts\sp\coverwall::_id_551C();
  level notify("cleanup_dead_bodies_burning_man");
  level notify("stop_airlock_klaxon");
  var_13 = getEntArray("aa2_dyn_models", "targetname");
  var_14 = getEntArray("aa2_barrels", "script_noteworthy");
  var_15 = scripts\engine\utility::array_combine(var_14, var_13);

  foreach(var_17 in var_15) {
    if(isDefined(var_17)) {
      scripts\sp\utility::_id_16AE(var_17, "aa2");
    }
  }

  scripts\sp\utility::_id_4074("aa2");
  thread scripts\sp\utility::_id_1264E("marsbase_combat_to_grinder_tr");
  thread scripts\sp\utility::_id_1264E("marsbase_elevator_lowres_tr");
  thread scripts\sp\utility::_id_1264E("marsbase_combat_meatgrinder_tr");
}

_id_4251() {
  self playLoopSound("mars_burningman_airlock_move");
  wait 2.5;
  self playSound("mars_burningman_airlock_close");
  wait 0.5;
  self stoploopsound();
}

_id_E7BC() {
  wait 0.6;
  level.player playRumbleOnEntity("damage_light");
  wait 0.1;
  level.player _meth_8244("light_steady");
  wait 0.4;
  level.player stoprumble("light_steady");
  level.player playRumbleOnEntity("damage_light");
  wait 0.2;
  self playRumbleOnEntity("damage_light");
  wait 0.81;
  self playRumbleOnEntity("damage_light");
  wait 0.1;
  self _meth_8244("tank_rumble");
  wait 1.2;
  self stoprumble("tank_rumble");
  wait 0.1;
  level.player playRumbleOnEntity("damage_light");
}

_id_3BA1() {
  var_0 = getnodearray("cave_airlock_squad_node", "script_noteworthy");

  foreach(var_3, var_2 in var_0) {
    level._id_1493[var_3] _meth_80F1(var_2.origin, var_2.angles);
    level._id_1493[var_3] _meth_82EE(var_2);
  }
}

_id_3B46() {
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_burning_man_allies_move");
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_burning_man_scene_start");
  scripts\sp\maps\marsbase\marsbase_util::_id_7271("flag_burning_man_airlock_approached");
  _id_3BA2();
}

_id_D215() {
  level.player._id_E505 scripts\engine\utility::delaycall(0.05, ::show);
  scripts\sp\anim::_id_1F35(level.player._id_E505, "open_airlock");
  level.player unlink();
  level.player._id_E505 delete();
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
}

_id_13743() {
  _id_0E46::_id_48C4("tag_ui_front", undefined, &"MARSBASE_OPEN_DOOR_HILL", 30, 1600, 48, 0, 0);
  self waittill("trigger");
  level thread scripts\engine\utility::flag_set_delayed("flag_airlock_door_open", 1.5);
  level notify("hill_airlock_opened");
}

_id_C5DD(var_0, var_1, var_2, var_3, var_4) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 90);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 3);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, var_1 / 2);
  var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, var_1 / 2);
  var_5 = getEntArray(var_0, "script_noteworthy");
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in var_5) {
    if(var_9.classname == "script_brushmodel") {
      var_6 = var_9;
      continue;
    }

    var_7 = var_9;
  }

  var_7._id_13127 = var_7.angles;
  var_6 linkTo(var_7);
  var_6 connectpaths();
  var_7 rotateYaw(var_2, var_1, var_3, var_4);
  var_7 waittill("rotatedone");
  var_6 disconnectPaths();
}

_id_4255(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(var_5.classname == "script_brushmodel") {
      var_2 = var_5;
      continue;
    }

    var_3 = var_5;
  }

  var_2 connectpaths();
  var_3 rotateTo(var_3._id_13127, 1, 0.5, 0.25);
  var_3 waittill("rotatedone");
  var_2 unlink();
  var_2 disconnectPaths();
}

delete_door() {
  scripts\sp\utility::_id_228A(getEntArray("burning_man_airlock_door_kit", "targetname"));
  scripts\sp\utility::_id_228A(getEntArray("burning_man_airlock_door_exterior_kit", "targetname"));
  var_0 = getEnt("burning_man_squad_cave_clear_vol", "targetname");
  var_1 = getEnt("burning_man_squad_clear_vol", "targetname");
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_0);
  scripts\sp\maps\marsbase\marsbase_util::_id_EA01(var_1);
}