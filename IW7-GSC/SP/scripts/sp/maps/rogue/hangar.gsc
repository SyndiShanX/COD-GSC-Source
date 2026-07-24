/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\hangar.gsc
********************************************/

_id_8AC7() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("hangar_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("hangar_start");

  foreach(var_1 in level._id_10AC8)
  var_1 thread _id_F567();
}

_id_F0D1() {}

_id_F0CB() {
  scripts\engine\utility::flag_init("anim_hangar_vin_done");
  scripts\engine\utility::flag_init("anim_hangar_vin_goto");
  scripts\engine\utility::flag_init("outdoor_surface_physics_on");
  scripts\engine\utility::flag_init("kill_array_chatter");
}

_id_F0D2() {}

_id_9614() {
  level._id_8A36 = getEnt("model_door_hangar", "targetname");
  level._id_8A36._id_4348 = level._id_8A36 scripts\engine\utility::get_target_ent();
  level._id_8A36 scripts\sp\utility::_id_23B7("hangar_door");
  scripts\engine\utility::getStruct("hangar_animnode", "targetname") scripts\sp\anim::_id_1EC3(level._id_8A36, "hangar_vignette_exit");
}

_id_3B6D() {
  var_0 = scripts\engine\utility::getStruct("hangar_animnode", "targetname");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_8A36, "hangar_vignette_exit");
  var_0 scripts\sp\anim::_id_1F2A([level._id_8A36], "hangar_vignette_exit", 0.99);
  level._id_8A36._id_4348 delete();
}

_id_8AA0() {
  scripts\engine\utility::flag_set("outdoor_surface_physics_on");
  scripts\engine\utility::flag_set("interior_quakes");
  scripts\engine\utility::flag_set("flag_lgt_hangar_start");
  scripts\engine\utility::flag_set("player_is_inside");
  level.player clearclienttriggeraudiozone(2);
  level.player scripts\engine\utility::delaycall(4, ::setclienttriggeraudiozonepartialwithfade, "rogue_no_wind", 2, "mix");
  thread _id_BD3D();
  thread _id_5B91();
  thread _id_8AD6();
  thread _id_8A3C();
  var_0 = [1, 0.25, 0.09];
  level._id_111C3.light = 30 * vectorNormalize((var_0[0], var_0[1], var_0[2]));
  setsunlight(level._id_111C3.light[0], level._id_111C3.light[1], level._id_111C3.light[2]);
  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\sp\maps\rogue\rogue_util::_id_111E8(7.5, 15, 1);
  thread scripts\sp\maps\rogue\surface::_id_112D8();
  _id_8AD8();
  level thread _id_8ACE();
  setglobalsoundcontext("atmosphere", "helmet", 1);
  _id_F0CA();
}

_id_8A3C() {
  level._id_8A3B = spawn("script_origin", (17113, 39326, -788));
  level._id_8A3B _meth_8278(0);
  wait 0.05;
  level._id_8A3B playLoopSound("rogue_hangar_door_shake");
  level._id_8A3B _meth_8278(1, 2);
  level._id_8A3B waittill("door_opened");
  wait 0.5;
  level._id_8A3B _meth_8278(0, 0.2);
  wait 0.25;
  level._id_8A3B delete();
}

_id_8AC0() {
  wait 0.15;
  var_0 = getscriptablearray("hangar_scriptable_onoff", "script_noteworthy");
  thread scripts\sp\maps\rogue\rogue_util::_id_EF3D(var_0, "screen", "on", "off");
}

_id_8AD8() {
  foreach(var_1 in level._id_10AC8) {
    wait 0.1;
    var_1 scripts\sp\maps\rogue\rogue_util::_id_12984();
  }

  var_3 = scripts\engine\utility::getStruct("hangar_animnode", "targetname");
  var_4 = [level._id_B4F9, level._id_13E12, level._id_B33E, level._id_B33B];
  var_3._id_162F = 0;
  thread _id_134DE();
  scripts\sp\utility::_id_15F5("hangar_initial_colors");

  foreach(var_6 in var_4)
  var_6 scripts\sp\utility::_id_51E1("cqb");

  scripts\engine\utility::flag_wait("anim_hangar_vin_goto");
  scripts\engine\utility::exploder("hangar_power_on");
  thread scripts\sp\maps\rogue\rogue_util::_id_111E7(6, 100, 5, 0, 0);

  foreach(var_6 in var_4) {
    var_6 scripts\sp\utility::_id_51E1("combat");
    var_6 thread _id_8A54(var_3);
  }

  while(var_3._id_162F != 4)
    wait 0.05;

  scripts\engine\utility::flag_set("sun_vision_blend");

  while(level._id_111C3.time < 12)
    wait 0.05;

  var_3 notify("stop_loop");
  scripts\engine\utility::exploder("rockland_00");
  var_3 scripts\sp\anim::_id_1F2C(var_4, "hangar_vignette_scene");
  var_3 thread scripts\sp\anim::_id_1EE7(var_4, "hangar_vignette_ready", "stop_loop");
  wait 0.05;

  while(level._id_111C3.time < 17)
    wait 0.05;

  var_4[var_4.size] = level._id_8A36;
  var_3 notify("stop_loop");
  level._id_8A36 playSound("rogue_hangar_door_02");

  if(isDefined(level._id_8A3B))
    level._id_8A3B notify("door_opened");

  level.player clearclienttriggeraudiozone(1);
  var_3 thread scripts\sp\anim::_id_1F2C(var_4, "hangar_vignette_exit");
  scripts\engine\utility::exploder("rockland_04");
  scripts\engine\utility::exploder("gate_open_wind");
  thread _id_75D2();
  var_10 = [1, 0.775, 0.385];
  level._id_111C3.light = 60 * vectorNormalize((var_10[0], var_10[1], var_10[2]));
  setsunlight(level._id_111C3.light[0], level._id_111C3.light[1], level._id_111C3.light[2]);
  scripts\engine\utility::flag_clear("flashlight_desired");
  thread scripts\sp\maps\rogue\rogue_util::_id_54FF();

  foreach(var_1 in level._id_10AC8) {
    wait 0.1;
    var_1 scripts\sp\maps\rogue\rogue_util::_id_12958();
  }

  thread scripts\sp\utility::_id_266F();
  level._id_8A36._id_4348 thread _id_5158();

  if(!level.console)
    waitforalltransients();
}

_id_5158() {
  wait 0.9;
  self delete();
}

_id_75D2() {
  wait 2.2;
  scripts\engine\utility::exploder("rockland_01");
  wait 3;
  scripts\engine\utility::exploder("rockland_02");
  wait 1.85;
  scripts\engine\utility::exploder("junkspawner");
  wait 2.85;
  scripts\engine\utility::exploder("rockland_03");
  wait 7;
  scripts\engine\utility::exploder("rockland_04");
}

_id_5792() {
  self._id_8A74 scripts\sp\anim::_id_1F35(self, "hangar_vignette_scene");
  self._id_8A74 thread scripts\sp\anim::_id_1EEA(self, "hangar_vignette_ready");
}

_id_6954() {
  self._id_8A74 notify("stop_loop");
  self._id_8A74 scripts\sp\anim::_id_1F35(self, "hangar_vignette_exit");
}

_id_8A56() {
  level endon("stop_hangar_exploders");

  for(;;) {
    wait(randomfloatrange(1, 8));
    playFX(level._effect["vfx_rogue_astroid_big"], (randomintrange(18000, 22110), randomintrange(44000, 48020), 0), (1, 0, 0));
  }
}

_id_134DE() {
  _id_8ADC();
  scripts\engine\utility::flag_wait("player_left_hangar");
  wait 4;
  _id_8ADD();
  thread _id_DD1A();
}

_id_8ADC() {
  wait 1.5;
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_gogo");
  wait 0.1;
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_sweepandclear");
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_torchesup");
  level._id_B33E thread scripts\sp\utility::_id_10346("rogue_ksh_check");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_check");
  level waittill("play_extra_hangar_vo");
  wait 2;
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_powersgoingonand");
  wait 0.1;
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_generatorsmustbebaked");
}

_id_8ADD() {}

_id_DD1A() {
  level endon("kill_array_chatter");
  var_0 = scripts\engine\utility::getStruct("lava_moment_fx", "targetname");
  var_1 = getnode("marine1_array_stop", "targetname");
  scripts\engine\utility::flag_wait("surface_player_stairs_exit");
  wait 2;
  level._id_B33B _id_11002("asteroid_brk_Shitthatwasclose");
  level.player setclienttriggeraudiozonepartialwithfade("rogue_solararray_mix", 4, "mix");
  level._id_B4F9 _id_11002("asteroid_omr_kashimayoucalle");
  level._id_B33E _id_11002("asteroid_brk_wegotpowerwitht");
  level.player _id_11002("asteroid_plr_letskeepoureyes");
  level._id_B33E _id_11002("asteroid_brk_thisisnuts");
  level._id_B33B _id_11002("asteroid_ksh_everybodyhearth");
}

_id_11002(var_0) {
  if(self == level.player && !scripts\engine\utility::flag("kill_array_chatter"))
    scripts\sp\utility::_id_10350(var_0);
  else if(!scripts\engine\utility::flag("kill_array_chatter"))
    scripts\sp\utility::_id_10346(var_0);
}

_id_8AD6() {
  level endon("stop_hangar_exploders");
  scripts\engine\utility::exploder("dropship_smk_on");
  scripts\engine\utility::exploder("201");

  for(;;) {
    scripts\engine\utility::flag_wait("power_on");
    scripts\sp\utility::_id_10FEC("201");
    scripts\engine\utility::exploder("200");
    scripts\engine\utility::flag_wait("power_off");
    scripts\sp\utility::_id_10FEC("200");
    scripts\engine\utility::exploder("201");
  }
}

_id_8A54(var_0) {
  while(scripts\sp\utility::_id_65DF("ready_for_Hangar") == 0 || scripts\sp\utility::_id_65DB("ready_for_Hangar") == 0)
    wait 0.05;

  var_0 scripts\sp\anim::_id_1F17(self, "hangar_vignette_enter");
  level._id_8AD7 = 1;
  level notify("interrupt_hangar_vo");
  var_0 scripts\sp\anim::_id_1F35(self, "hangar_vignette_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "hangar_vignette_idle");
  var_0._id_162F++;
}

_id_F567() {
  scripts\sp\utility::_id_65E0("ready_for_Hangar");
  scripts\sp\utility::_id_65E1("ready_for_Hangar");
}

_id_F3E1() {
  foreach(var_1 in level._id_10AC8) {
    var_2 = "dormitory_start" + var_1._id_111B7;
    var_3 = getnode(var_2, "targetname");
    var_1 _meth_82EE(var_3);
  }
}

_id_BD3D() {
  var_0 = getEntArray("solar_array_mover", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_C895();
}

_id_C893() {
  while(!scripts\engine\utility::flag("flag_dorm_start")) {
    scripts\engine\utility::flag_wait("power_on");
    var_0 = scripts\engine\utility::spawn_tag_origin();
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0 linkTo(self);
    playFXOnTag(level._effect["panel_glow"], var_0, "tag_origin");
    scripts\engine\utility::flag_waitopen("power_on");
    var_0 delete();
  }
}

_id_C895() {
  var_0 = 0;

  while(!scripts\engine\utility::flag("flag_dorm_start")) {
    if(scripts\engine\utility::flag("power_on")) {
      var_1 = randomfloatrange(3, 7);

      if(var_0 == 0) {
        var_2 = 30;
        var_0 = 1;
      } else {
        var_2 = -30;
        var_0 = 0;
      }

      self rotateYaw(var_2, var_1, var_1 / 2, var_1 / 2);
      wait(var_1 + randomfloatrange(3, 5));
      continue;
    }

    wait 2;
  }
}

_id_6F48() {
  scripts\sp\utility::_id_75C4("vfx_ra_spinning_debris_field", "tag_origin");
  var_0 = 15;

  while(!scripts\engine\utility::flag("flag_dorm_start")) {
    self rotateYaw(-96, var_0, 0, 0);
    scripts\engine\utility::wait_for_flag_or_time_elapses("flag_dorm_start", var_0);
  }

  scripts\sp\utility::_id_75F8("vfx_ra_spinning_debris_field", "tag_origin");
}

_id_5B91() {
  var_0 = scripts\engine\utility::getStructArray("asteroid_drill_mover", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_9E12 = 1;
    var_3 = scripts\sp\utility::_id_10639("drill");
    var_3.origin = var_2.origin;
    var_3.angles = var_2.angles;
    var_2._id_5B90 = var_3;
    var_2 thread _id_5BA6();
  }

  while(!scripts\engine\utility::flag("flag_dorm_start")) {
    scripts\engine\utility::flag_wait("power_on");

    foreach(var_2 in var_0) {
      if(var_2._id_9E12 == 1) {
        scripts\sp\anim::_id_1F29(var_2._id_5B90, "drill_down", 1);
        continue;
      }

      scripts\sp\anim::_id_1F29(var_2._id_5B90, "drill_up", 1);
    }

    scripts\engine\utility::flag_waitopen("power_on");

    foreach(var_2 in var_0) {
      if(var_2._id_9E12 == 1) {
        scripts\sp\anim::_id_1F29(var_2._id_5B90, "drill_down", 0);
        continue;
      }

      scripts\sp\anim::_id_1F29(var_2._id_5B90, "drill_up", 0);
    }
  }

  level notify("kill_drill_anims");
}

_id_5BA6() {
  level endon("kill_drill_anims");

  while(!scripts\engine\utility::flag("flag_dorm_start")) {
    wait(randomfloatrange(1, 2.5));
    self._id_9E12 = 1;
    scripts\sp\anim::_id_1F35(self._id_5B90, "drill_down");
    wait(randomfloatrange(1, 2.5));
    self._id_9E12 = 0;
    scripts\sp\anim::_id_1F35(self._id_5B90, "drill_up");
  }
}

_id_AC85() {
  var_0 = getEntArray("hangar_bay_light_row_0", "targetname");
  var_1 = getEntArray("hangar_bay_light_row_1", "targetname");
  var_2 = getEntArray("hangar_bay_light_row_2", "targetname");
  var_3 = getEntArray("hangar_bay_light_row_3", "targetname");
  var_4 = getEntArray("hangar_bay_light_row_4", "targetname");
  thread _id_AC9F(var_0, 0.5);
  thread _id_AC9F(var_1, 1.5);
  thread _id_AC9F(var_2, 2.5);
  thread _id_AC9F(var_3, 3.5);
  thread _id_AC9F(var_4, 4.5);
  var_5 = getEntArray("hangar_room_light_row_0", "targetname");
  var_6 = getEntArray("hangar_room_light_row_1", "targetname");
  var_7 = getEntArray("hangar_room_light_row_2", "targetname");
  thread _id_AC9F(var_5, 0.5);
  thread _id_AC9F(var_6, 2);
  thread _id_AC9F(var_7, 3.5);
}

_id_AC9F(var_0, var_1) {
  foreach(var_3 in var_0)
  var_3._id_99E8 = var_3 _meth_8134();

  while(!scripts\engine\utility::flag("player_left_hangar")) {
    foreach(var_3 in var_0) {
      var_3 setlightintensity(0);
      var_3 notify("off");
    }

    scripts\engine\utility::flag_wait("power_on");
    wait(var_1);

    foreach(var_3 in var_0) {
      var_3 setlightintensity(var_3._id_99E8);
      var_3 notify("on");
    }

    scripts\engine\utility::flag_waitopen("power_on");
    wait(var_1 / 4);
  }

  var_0[0] notify("perm_off");

  foreach(var_3 in var_0)
  var_3 delete();
}

_id_ACA0() {
  self endon("perm_off");
  self playLoopSound("rogue_interior_light_hum");
}

_id_8ACE() {
  scripts\sp\maps\rogue\rogue_util::_id_1120C(18, 4);

  while(!scripts\engine\utility::flag("player_is_outside") || !scripts\engine\utility::flag("power_off"))
    wait 0.05;

  level notify("stop_hangar_exploders");

  if(scripts\engine\utility::flag("power_on"))
    scripts\sp\utility::_id_10FEC("200");
  else
    scripts\sp\utility::_id_10FEC("201");

  scripts\sp\maps\rogue\rogue_util::_id_111E8(6.5, 16, 1);
}

_id_F0CA() {
  scripts\sp\maps\rogue\rogue_util::_id_40BF();
}