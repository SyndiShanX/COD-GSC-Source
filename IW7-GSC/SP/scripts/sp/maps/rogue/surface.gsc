/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\surface.gsc
*********************************************/

_id_112DB() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("surface_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("surface_start");
  scripts\sp\maps\rogue\rogue_util::_id_111E8(7.5, 15, 1);
  scripts\sp\maps\rogue\rogue_util::_id_111E7(17.5, 20, 20, 50, 100);
  thread _id_112D8();
  var_0 = scripts\engine\utility::getStruct("hangar_animnode", "targetname");
  var_0 thread scripts\sp\anim::_id_1F2C(level.allies, "hangar_vignette_exit");
  var_0 scripts\sp\anim::_id_1F2A(level.allies, "hangar_vignette_exit", 0.99);
  thread scripts\sp\maps\rogue\hangar::_id_DD1A();
}

_id_F0D1() {
  scripts\sp\utility::_id_16EB("sprint", &"ROGUE_SPRINT", scripts\sp\maps\rogue\rogue::_id_D428);
}

_id_F0CB() {
  scripts\engine\utility::flag_init("array1_nag");
  scripts\engine\utility::flag_init("array2_nag");
  scripts\engine\utility::flag_init("player_at_array2_scene");
  scripts\engine\utility::flag_init("lava_moment_over");
  scripts\engine\utility::flag_init("fake_array_burn");
  scripts\engine\utility::flag_init("flag_array2_enter_done_mco");
  scripts\engine\utility::flag_init("flag_array2_enter_done_xo");
  scripts\engine\utility::flag_init("flag_array2_enter_done_marine1");
  scripts\engine\utility::flag_init("flag_array2_enter_done_marine2");
  scripts\engine\utility::flag_init("player_still_in_hangar");
  scripts\engine\utility::flag_init("hangar_door_open");
}

_id_F0D2() {}

_id_112D7() {
  scripts\engine\utility::flag_set("player_at_array2_scene");
}

_id_112DA() {
  scripts\engine\utility::flag_set("hangar_door_open");
  scripts\engine\utility::flag_clear("interior_quakes");
  thread _id_D1B2();
  thread _id_22C0();
  thread _id_F947();
  thread _id_2293();
  level.player scripts\sp\utility::_id_F526("normal");
  thread scripts\sp\maps\rogue\rogue_util::_id_E64A(600, 800, 400, 200);
  setsaveddvar("player_sprintunlimited", 1);
  thread _id_1881();
  thread _id_112DD();
  thread _id_112DE();
  thread _id_10ABC();
  thread _id_112D6();
  scripts\engine\utility::flag_set("flag_lgt_hangar_start");
  scripts\engine\utility::flag_clear("player_is_inside");
  var_0 = getEntArray("gravity_dir_trig", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_84D7);
  thread _id_8526();
  thread _id_112D5();
  setglobalsoundcontext("atmosphere", "helmet", 1);
  _id_2277();
  _id_F0CA();
}

_id_1102A() {
  thread _id_E1E4();
  level endon("stumbled");
  var_0 = 1;

  for(;;) {
    if(isDefined(level.player.burning) && level.player.burning == 1 && !scripts\engine\utility::flag("fake_array_burn")) {
      level.player thread scripts\sp\utility::_id_D2CD(25, 1);
      var_0 = 0;

      while(isDefined(level.player.burning) && level.player.burning == 1) {
        level.player dodamage(5, level._id_111C3.ent.origin * -1);
        wait 0.25;
      }
    } else if(var_0 == 0) {
      level.player thread scripts\sp\utility::_id_D2CD(100, 4);
      var_0 = 1;
    }

    wait 0.25;
  }
}

_id_E1E4() {
  level waittill("stumbled");
  level.player thread scripts\sp\utility::_id_D2CD(100, 1);
}

_id_10ABC() {
  scripts\engine\utility::flag_wait("player_is_outside");
  scripts\sp\utility::_id_56BE("sprint", 10);
}

_id_112DD() {
  scripts\engine\utility::flag_wait("player_is_outside");
  level endon("sun_safe_zone");

  for(;;) {
    scripts\engine\utility::flag_wait("power_off");
    scripts\engine\utility::exploder("101");
    level scripts\engine\utility::delaythread(1.6, scripts\engine\utility::play_sound_in_space, "emt_rogue_lava_burst", (17465, 40984, -1091));
    scripts\engine\utility::flag_wait("power_on");
    scripts\engine\utility::exploder("100");
  }
}

_id_112DE() {
  level notify("stop_surface_vfx_helmet");
  var_0 = anglesToForward(scripts\engine\utility::getStruct("struct_surface_wind_vector", "targetname").angles);
  wait 0.1;

  while(!scripts\engine\utility::flag("dorm_run_over")) {
    scripts\engine\utility::flag_waitopen("sun_safe_zone");
    var_1 = scripts\engine\utility::anglebetweenvectorssigned(var_0, anglesToForward(level.player.angles), (0, 0, 1));

    if(var_1 >= -45 && var_1 <= 45)
      scripts\engine\utility::exploder(69);
    else if(var_1 < -45 && var_1 > -135)
      scripts\engine\utility::exploder(70);
    else if(var_1 > 45 && var_1 < 135)
      scripts\engine\utility::exploder(68);

    wait 0.5;
    scripts\sp\utility::_id_10FEC(69);
    scripts\sp\utility::_id_10FEC(70);
    scripts\sp\utility::_id_10FEC(68);
  }
}

_id_112D8() {
  var_0 = getEntArray("rogue_drill", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_E647, "surface_player_stairs_exit");
}

_id_8526() {
  scripts\engine\utility::flag_wait("surface_player_stairs_exit");
  level notify("stop_grabage_hurling");
  physics_setgravity((0, 0, -386.09));
}

_id_84D7() {
  self waittill("trigger");
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_1 = vectorNormalize(var_0.origin - self.origin);
  var_1 = var_1 * 800;
  var_2 = (0, 0, -1);
  var_2 = var_2 * 400;
  var_3 = var_1 + var_2;
  physics_setgravity(var_3);
}

_id_E647(var_0) {
  level endon(var_0);
  self endon("death");
  var_1 = self.origin;
  var_2 = spawn("script_origin", self.origin);
  var_3 = spawn("script_origin", self.origin);
  var_2 _meth_8278(0);
  var_3 _meth_8278(0);
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    var_6 = 2;

    if(var_5 == 0) {
      var_5 = 1;
      var_4 = 0;
      var_3 playLoopSound("emt_rogue_drill_fast");
      var_3 _meth_8278(1, 0.5);
      var_2 _meth_8278(0, 0.5);
      var_2 _meth_8277(1.5, 0.5);
      var_2 scripts\engine\utility::delaycall(1, ::stoploopsound, "emt_rogue_drill_slow");
    }

    self moveTo(var_1, var_6 / 2, var_6 / 2);
    _id_5BB0();
    wait 0.25;

    while(scripts\engine\utility::flag("power_on")) {
      childthread _id_5BAC();
      wait 0.2;
      var_6 = 0.3;
      self movez(-140, var_6);
      wait(var_6);
      earthquake(1.5, 0.6, (self.origin[0], self.origin[1], level.player.origin[2]), 575);
      wait 1;
      var_6 = 2;
      self moveTo(var_1, var_6 / 2, var_6 / 2);
      var_3 scripts\engine\utility::delaycall(1, ::_meth_8278, 0, 1);
      _id_5BB0();
      wait 0.25;
      var_3 _meth_8278(1, 0.1);
    }

    if(var_4 == 0) {
      var_5 = 0;
      var_4 = 1;
      var_2 playLoopSound("emt_rogue_drill_slow");
      var_3 _meth_8278(0, 0.5);
      var_3 _meth_8277(0.5, 0.5);
      var_2 _meth_8278(1, 0.5);
      var_3 scripts\engine\utility::delaycall(1, ::stoploopsound, "emt_rogue_drill_fast");
    }

    _id_10313(var_1);
  }
}

_id_10313(var_0) {
  level endon("power_on");
  childthread _id_5BAC(1);

  while(scripts\engine\utility::flag("power_off")) {
    wait 0.2;
    var_1 = 2.3;
    self movez(-140, var_1);
    wait(var_1);
    wait 1;
    var_1 = 10;
    self moveTo(var_0, var_1 / 2, var_1 / 2);
    wait(var_1);
  }
}

_id_5BAC(var_0) {
  self endon("spindown");

  if(isDefined(var_0)) {
    var_1 = 2.25;
    var_2 = 2.15;
  } else {
    var_1 = 0.25;
    var_2 = 0.15;
  }

  for(;;) {
    self rotateYaw(360, var_1);
    wait(var_2);
  }
}

_id_5BB0() {
  self notify("spindown");
  var_0 = 0.25;

  for(var_1 = 0; var_1 < 4; var_1++) {
    self rotateYaw(360, var_0);
    wait(var_0);
    var_0 = var_0 + 0.15;
  }
}

_id_7697() {
  level endon("stop_grabage_hurling");

  for(;;) {
    var_0 = level.player _id_7C15(350, 1);
    var_1 = spawn("script_origin", var_0);
    var_1.angles = level.player.angles;
    var_2 = var_1 _id_79D8(450);
    var_3 = var_2 + (0, 0, 100);
    var_1 delete();
    var_4 = anglestoright(level.player.angles);
    playFX(scripts\engine\utility::getfx("vfx_ra_trash_debris"), var_3, var_4);
    wait 4;
  }
}

_id_7C15(var_0, var_1) {
  var_2 = anglestoright(self.angles);

  if(isDefined(var_1))
    var_2 = var_2 * -1;

  var_3 = self.origin;
  return var_3 + var_2 * var_0;
}

_id_79D8(var_0, var_1) {
  var_2 = anglesToForward(self.angles);

  if(isDefined(var_1))
    var_2 = var_2 * -1;

  var_3 = self.origin;
  return var_3 + var_2 * var_0;
}

_id_2277() {
  level._id_2270 = 0;
  var_0 = getEnt("array_2_animNode", "targetname");
  setdvarifuninitialized("debug_array", 0);
  var_0._id_466C = scripts\sp\utility::_id_10639("solar_corpse", var_0.origin);
  level._id_B4F9._id_5978 = scripts\sp\utility::_id_10639("array_door", var_0.origin);
  thread _id_467A(var_0._id_466C);
  thread _id_AABC();
  var_0 scripts\sp\anim::_id_1EC1([level._id_B4F9._id_5978], "array_2_enter");
  var_0 scripts\sp\anim::_id_1EC1([var_0._id_466C], "array_2_scene");
  playFXOnTag(scripts\engine\utility::getfx("vfx_rogue_dead_body_steam"), var_0._id_466C, "j_spine4");
  thread scripts\sp\maps\rogue\rogue_util::_id_517F([level._id_B4F9._id_5978, var_0._id_466C], "dorm_airlock_door_shut");
  scripts\engine\utility::array_thread(level._id_10AC8, ::_id_226F, var_0);

  while(!isDefined(level._id_13E12._id_2272) && !isDefined(level._id_B33B._id_2272) && !isDefined(level._id_B33E._id_2272))
    wait 0.05;

  var_1 = getEnt("player_stuck_fixer_array", "targetname");

  if(isDefined(var_1))
    var_1 scripts\engine\utility::delaycall(2, ::delete);

  foreach(var_3 in level._id_10AC8) {
    wait 0.1;
    var_3 scripts\sp\maps\rogue\rogue_util::_id_12984();
  }

  var_5 = spawn("trigger_radius", level._id_B33E.origin - (0, 0, 100), 0, 500, 300);
  var_5 waittill("trigger");
  thread _id_1102A();
  scripts\engine\utility::flag_set("player_at_array2_scene");
  scripts\sp\utility::_id_2669("array_scene");
  thread _id_5A6B(1);
  thread _id_7569();
  var_5 delete();
  wait 5;
  thread scripts\sp\maps\rogue\rogue_util::_id_E669(1, 0.5, "rogue_quake");
  thread scripts\sp\maps\rogue\rogue_util::_id_E66C(0.5, 0.5);
  scripts\sp\maps\rogue\rogue_util::_id_111E7(10, 50);
  scripts\sp\maps\rogue\rogue_util::_id_1120C(15, 1);
  level._id_B4F9 thread scripts\sp\utility::_id_10346("asteroid_omr_onyoucorporal");

  while(level._id_2270 != 4)
    wait 0.05;

  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();

  foreach(var_3 in level._id_10AC8) {
    wait 0.1;
    var_3 scripts\sp\maps\rogue\rogue_util::_id_12958();
  }

  thread scripts\sp\utility::_id_2670();

  foreach(var_3 in level._id_10AC8) {
    var_3._id_2271 notify("stop_array_idle");

    if(getdvarint("debug_array"))
      var_3 notify("stop_print3d");
  }
}

_id_7569() {
  wait 8;
  scripts\engine\utility::exploder("rockland_05");
}

_id_5A6B(var_0) {
  var_1 = 1;

  if(var_1) {
    return;
  }
  if(var_0 && !isDefined(level._id_5A6B)) {
    var_2 = scripts\engine\utility::getStruct("dorm_entrance_siren", "targetname");
    level._id_5A6B = spawnfx(scripts\engine\utility::getfx("vfx_spinning_red_light"), var_2.origin, anglesToForward(var_2.angles), anglestoup(var_2.angles));
    triggerfx(level._id_5A6B);
  } else if(!var_0 && isDefined(level._id_5A6B))
    level._id_5A6B delete();
}

_id_AABC() {
  var_0 = scripts\engine\utility::getStruct("lava_moment_fx", "targetname");
  var_1 = getnode("marine1_array_stop", "targetname");

  while(distance2d(var_0.origin, level.player.origin) > 700)
    wait 0.05;

  scripts\sp\utility::_id_10FEC("100");
  scripts\sp\utility::_id_10FEC("101");
  scripts\engine\utility::exploder("lavaburst_01");
  var_0 = scripts\engine\utility::getStruct("lava_moment_fx", "targetname");
  thread _id_AABD(var_0);
  var_2 = getEnt("vol_solar_lavamoment", "targetname");
  var_3 = [];
  var_4 = 0;
  var_5 = anglesToForward(var_0.angles) * -1;

  foreach(var_9, var_7 in level.allies) {
    if(var_9 == "xo" || var_9 == "Omar") {
      continue;
    }
    if(level.allies[var_9] istouching(var_2)) {
      var_8 = vectordot(var_5, anglesToForward(level.allies[var_9].angles));

      if(var_8 > 0.8 && var_8 > var_4)
        var_3[var_3.size] = level.allies[var_9];
    }
  }

  var_10 = 0;
  scripts\engine\utility::flag_set("lava_moment_over");
  level._id_B33B._id_54B1 = 1;
}

_id_AABD(var_0) {
  if(scripts\sp\utility::_id_13D91(level.player.origin, level.player.angles, var_0.origin + (0, 0, 128), cos(55))) {
    var_1 = level.player scripts\sp\utility::_id_D091("ges_block_heat_left");
    thread scripts\engine\utility::exploder("player_hands_smoke");
    wait 1.5;
    level._id_B33B scripts\sp\utility::_id_10346("asteroid_slt_whoa");

    if(var_1)
      level.player stopgestureviewmodel("ges_block_heat_left", 0.3);
  }
}

_id_AABF(var_0) {
  self endon("timeout");
  thread scripts\sp\utility::_id_C12D("timeout", 3.5);

  for(;;) {
    if(self.a.pose == "stand") {
      if(isDefined(self.node) && self.node == var_0) {
        while(distance2d(self.origin, var_0.origin) > 40)
          wait 0.05;

        return 1;
      }
    }

    wait 0.05;
  }
}

_id_467A(var_0) {
  var_0 endon("death");
  level endon("stop_beacon");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_ra_corpse_beacon"), var_0, "j_shoulder_le");
    playworldsound("corpse_beacon_beep", var_0.origin);
    wait 1.85;
  }
}

_id_226F(var_0) {
  self._id_2271 = spawnStruct();
  self._id_2271.origin = var_0.origin;
  self._id_2271.angles = var_0.angles;
  thread _id_2276();
  self.target = tolower(self._id_1FBB) + "_array_spline";
  _id_0B77::_id_8409(undefined, undefined, undefined, undefined, ::_id_22BE);

  if(getdvarint("debug_array"))
    thread scripts\sp\maps\rogue\rogue_util::_id_D8E9("reaching");

  self._id_2271 scripts\sp\anim::_id_1F17(self, "array_2_enter");

  if(getdvarint("debug_array"))
    thread scripts\sp\maps\rogue\rogue_util::_id_D8E9("arrive single");

  if(self == level._id_B4F9) {
    self._id_2271 scripts\sp\anim::_id_1F2C([self, self._id_5978], "array_2_enter");
    scripts\engine\utility::flag_set("flag_array2_enter_done_mco");
  } else {
    if(self == level._id_13E12)
      var_0 thread scripts\sp\anim::_id_1F35(var_0._id_466C, "array_2_scene");

    self._id_2271 scripts\sp\anim::_id_1F35(self, "array_2_enter");

    if(self == level._id_13E12)
      scripts\engine\utility::flag_set("flag_array2_enter_done_xo");
    else if(self == level._id_B33B)
      scripts\engine\utility::flag_set("flag_array2_enter_done_marine1");
    else if(self == level._id_B33E)
      scripts\engine\utility::flag_set("flag_array2_enter_done_marine2");
  }

  if(getdvarint("debug_array"))
    thread scripts\sp\maps\rogue\rogue_util::_id_D8E9("idle");

  self._id_2271 thread scripts\sp\anim::_id_1EEA(self, "array_2_enter_idle", "stop_array_enter_idle");
  self._id_2272 = 1;
  scripts\engine\utility::flag_wait("player_at_array2_scene");
  scripts\engine\utility::flag_wait("flag_array2_enter_done_mco");
  scripts\engine\utility::flag_wait("flag_array2_enter_done_xo");
  scripts\engine\utility::flag_wait("flag_array2_enter_done_marine1");
  scripts\engine\utility::flag_wait("flag_array2_enter_done_marine2");

  if(self == level._id_13E12) {
    if(getdvarint("debug_array"))
      thread scripts\sp\maps\rogue\rogue_util::_id_D8E9("corpse scene");

    self._id_2271 notify("stop_array_enter_idle");
    self._id_2271 scripts\sp\anim::_id_1F35(self, "array_2_scene");
  } else if(self == level._id_B4F9) {
    if(getdvarint("debug_array"))
      thread scripts\sp\maps\rogue\rogue_util::_id_D8E9("waiting for notify");

    level waittill("start_mco");

    if(getdvarint("debug_array"))
      thread scripts\sp\maps\rogue\rogue_util::_id_D8E9("corpse scene");

    self._id_2271 notify("stop_array_enter_idle");
    self._id_2271 scripts\sp\anim::_id_1F35(self, "array_2_scene");
  } else {
    if(getdvarint("debug_array"))
      thread scripts\sp\maps\rogue\rogue_util::_id_D8E9("corpse scene");

    self._id_2271 notify("stop_array_enter_idle");
    self._id_2271 scripts\sp\anim::_id_1F35(self, "array_2_scene");
  }

  if(getdvarint("debug_array"))
    thread scripts\sp\maps\rogue\rogue_util::_id_D8E9("idle");

  self._id_2271 thread scripts\sp\anim::_id_1EEA(self, "array_2_idle", "stop_array_idle");
  level._id_2270++;
}

_id_22BE(var_0) {
  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "stairs_start")
    _id_10B4C();
}

_id_10B4C() {
  for(var_0 = 1; var_0 < 5; var_0++) {
    var_1 = scripts\engine\utility::getStruct("stair_node" + var_0, "targetname");
    var_1 scripts\sp\anim::_id_1F17(self, "fast_stairs");
    var_1 scripts\sp\anim::_id_1F35(self, "fast_stairs");
  }
}

_id_846B(var_0, var_1) {
  level endon("array_vignette_approach");

  if(isDefined(var_0.radius))
    self.goalradius = var_0.radius;

  self _meth_82EE(var_0);
  self waittill("goal");
}

_id_2276() {
  var_0 = undefined;

  if(self == level._id_B33B)
    var_0 = 2100;
  else if(self == level._id_B33E)
    var_0 = 1800;
  else if(self == level._id_B4F9)
    var_0 = 1500;
  else
    var_0 = 1200;

  while(distance2d(self.origin, self._id_2271.origin) > var_0)
    wait 0.05;

  scripts\sp\utility::_id_5522();
  scripts\sp\utility::_id_51E1("combat");
  scripts\engine\utility::flag_wait("array_vignette_approach");
  scripts\sp\utility::_id_51E1("combat");
}

_id_1881() {
  level.player._id_2C08 = level.player _meth_810B();
  level.player scripts\sp\utility::_id_D2D1(180, 1);
}

_id_F0CA() {
  scripts\sp\maps\rogue\rogue_util::_id_40BF();
}

_id_112D5() {
  scripts\engine\utility::flag_wait("surface_player_stairs_exit");
  level waittill("time_8");
  scripts\sp\maps\rogue\rogue_util::_id_11206();
  wait 1;
  thread scripts\sp\maps\rogue\rogue_util::_id_E669(1, 0.5, "rogue_quake");
  thread scripts\sp\maps\rogue\rogue_util::_id_E66C(0.5, 0.5);
  scripts\engine\utility::flag_wait("player_at_array2_scene");
  scripts\engine\utility::flag_wait("flag_array2_enter_done_mco");
  scripts\engine\utility::flag_wait("flag_array2_enter_done_xo");
  scripts\engine\utility::flag_wait("flag_array2_enter_done_marine1");
  scripts\engine\utility::flag_wait("flag_array2_enter_done_marine2");
}

_id_2293() {
  var_0 = getEnt("fake_array_burner_trig", "targetname");
  var_1 = var_0 scripts\engine\utility::get_target_ent();
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_3 = var_1.origin;
  var_0 enablelinkTo();
  var_0 linkTo(var_1);
  var_1 thread _id_227C(var_3, var_2.origin, var_0);
}

_id_227C(var_0, var_1, var_2) {
  thread _id_227B(var_2);
  scripts\engine\utility::flag_wait("power_on");

  while(!scripts\engine\utility::flag("dorm_run_over")) {
    scripts\engine\utility::flag_wait("power_on");

    while(level._id_111C3.time <= 12.5)
      wait 0.05;

    self moveTo(var_1, 15, 0, 0);

    while(level._id_111C3.time <= 15.5)
      wait 0.05;

    self moveTo(var_0, 0.1, 0, 0);
    scripts\engine\utility::flag_waitopen("power_on");
  }
}

_id_227B(var_0) {
  while(!scripts\engine\utility::flag("dorm_run_over")) {
    if(level.player istouching(var_0))
      scripts\engine\utility::flag_set("fake_array_burn");
    else
      scripts\engine\utility::flag_clear("fake_array_burn");

    wait 0.05;
  }
}

_id_22CF(var_0) {
  while(!scripts\engine\utility::flag("dorm_run_over"))
    wait 0.15;
}

_id_22C0() {
  var_0 = getEntArray("array_battery_mover", "targetname");

  foreach(var_2 in var_0) {
    switch (var_2.script_parameters) {
      case "slider":
        var_2 thread _id_22BF();
        break;
      case "bouncer":
        var_2 thread _id_227A();
        break;
      case "slider_small":
        var_2 thread _id_22BF(1);
        break;
      default:
        break;
    }
  }

  scripts\engine\utility::flag_wait("dorm_run_over");

  foreach(var_2 in var_0) {
    var_2 notify("stop_surface_mover");

    if(isDefined(var_2._id_AD34))
      var_2._id_AD34 delete();

    var_2 delete();
  }
}

_id_22BF(var_0) {
  self endon("stop_surface_mover");
  var_1 = self.origin;

  if(isDefined(var_0)) {
    var_2 = 2;
    var_3 = -2;
  } else {
    var_2 = 4;
    var_3 = -4;
  }

  for(;;) {
    level waittill("rogue_quake");
    wait(randomfloatrange(0.25, 0.5));
    var_4 = 0.05;
    var_5 = randomintrange(8, 10);
    var_6 = scripts\engine\utility::cointoss();
    var_7 = 0;

    for(var_8 = 0; var_8 < var_5; var_8++) {
      if(var_6) {
        var_6 = 0;
        self movey(var_2, var_4, 0, var_7);
      } else {
        var_6 = 1;
        self movey(var_3, var_4, 0, var_7);
      }

      wait(var_4);
      var_4 = var_4 + 0.1;

      if(var_4 > 0.5)
        var_7 = var_4 * 0.5;
    }

    self moveTo(var_1, 1, 0, 1);
  }
}

_id_227A() {
  self endon("stop_surface_mover");
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_2 = var_1.angles;
  self._id_AD34 = var_1;
  self linkTo(var_1);
  var_3 = 2;
  var_4 = -2;

  for(;;) {
    level waittill("rogue_quake");
    wait(randomfloatrange(0.25, 0.5));
    var_5 = 0.05;
    var_6 = randomintrange(8, 10);
    var_7 = 0;
    var_8 = 1;

    for(var_9 = 0; var_9 < var_6; var_9++) {
      if(var_8) {
        var_8 = 0;
        var_1 rotatepitch(var_3, var_5, 0, var_7);
      } else {
        var_8 = 1;
        var_1 rotatepitch(var_4, var_5, 0, var_7);
        wait 0.1;
      }

      wait(var_5);
      var_5 = var_5 + 0.1;

      if(var_5 > 0.5)
        var_7 = var_5 * 0.5;
    }
  }
}

_id_D1B2() {
  scripts\engine\utility::flag_wait("power_on");

  if(scripts\engine\utility::flag("player_still_in_hangar"))
    level._id_B4F9 scripts\sp\utility::_id_10350("rogue_omr_tryandgettouson");
}

_id_112D6() {
  thread _id_5A7B();

  while(!scripts\engine\utility::flag("fake_burn_player")) {
    if(level.player issprinting() || scripts\engine\utility::flag("player_jumped_chasm"))
      var_0 = randomfloatrange(0.75, 1.15);
    else
      var_0 = randomfloatrange(1.5, 1.75);

    if(!scripts\engine\utility::flag("sun_safe_zone")) {
      level.player playSound("rogue_surface_inhale_fast");
      wait(var_0);
      level.player playSound("rogue_surface_exhale_fast");
      continue;
    }

    scripts\engine\utility::flag_wait_any("sun_safe_zone", "fake_burn_player");
    wait 0.05;
  }

  var_0 = 0.4;

  for(var_1 = 0; var_1 < 3; var_1++) {
    level.player playSound("rogue_surface_inhale_fast");
    wait(var_0);
    level.player playSound("rogue_surface_exhale_fast");
    var_0 = var_0 + 0.3;
  }
}

_id_5A7B() {
  scripts\engine\utility::flag_wait("player_in_scene");
  level.player playSound("rogue_plr_effort1");
  level waittill("player_efforts");
  level.player playSound("rogue_plr_struggle");
}

_id_F947() {
  scripts\sp\maps\rogue\dormitory::_id_4527();
  var_0 = getEnt("dorm_animnode", "targetname");
  var_1 = getEnt("dorm_airlock_door", "targetname");
  var_1._id_1FBB = "airlock_door";
  var_1 scripts\sp\anim::_id_F64A();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "dorm_airlock_entrance_player");
}