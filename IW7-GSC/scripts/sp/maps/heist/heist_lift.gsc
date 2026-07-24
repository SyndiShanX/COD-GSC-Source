/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_lift.gsc
************************************************/

_id_BAC9() {
  _id_3A73();

  if(getdvarint("debug_lift_top", 0) == 1) {
    scripts\sp\utility::_id_F5AF("start_mons_lift", [level.player]);
    level._id_AC77 _meth_83C9(undefined);
    level._id_AC77 moveTo(level._id_AC77._id_119F3.origin, 2, 1, 1);
    thread scripts\sp\maps\heist\heist_util::_id_C5F0("door_lift_upper_left", "door_lift_upper_right", 0.05);

    for(;;) {
      scripts\engine\utility::exploder("mons_lift_sparks_1");
      wait 3;
      scripts\engine\utility::exploder("mons_lift_sparks_2");
      wait 3;
    }

    level waittill("forever");
  }

  scripts\sp\maps\heist\heist_util::_id_957C();
  scripts\sp\maps\heist\heist_util::_id_968E();
  scripts\sp\maps\heist\heist_util::_id_1065E();
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\sp\maps\heist\heist_util::_id_107BE();
  scripts\sp\maps\heist\heist_util::_id_1074D();
  scripts\sp\utility::_id_F5AF("start_mons_lift", [level.player, level._id_6754, level._id_30F6, level._id_EA2C, level._id_A54E]);
  thread scripts\sp\maps\heist\heist_util::_id_FD33("hangar");
  thread scripts\sp\maps\heist\heist_util::_id_C5F0("door_lift_lower_left", "door_lift_lower_right", 0.05);
  thread scripts\sp\maps\heist\heist_util::_id_C5F0("door_lift_lower_outer_left", "door_lift_lower_outer_right", 0.05);
  thread scripts\sp\maps\heist\heist_util::_id_968F("hangar_shift_1", "start_hangar_shift_1", 0.05);
  thread scripts\sp\maps\heist\heist_util::_id_968F("hangar_shift_2", "start_hangar_shift_2", 0.05);
  scripts\engine\utility::delaythread(0.1, scripts\sp\maps\heist\heist_hangar::_id_426F, 1);
  thread scripts\sp\maps\heist\heist_util::_id_10D16(1);
}

_id_BAC8() {
  while(!isDefined(level._id_AC77)) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("obj_getonlift");

  if(getdvarint("debug_lift_top", 0) == 1) {
    level waittill("forever");
  }

  thread _id_3A75();
  thread scripts\sp\maps\heist\heist_util::_id_968F("lift_moving_cover", "lift_moving_cover_state_1");
  thread _id_A710();
  thread _id_D08B();
  thread scripts\sp\maps\heist\heist_util::_id_9686();
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_414F);
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  scripts\engine\utility::flag_wait("elevator_ready");
  wait 0.1;
  scripts\sp\maps\heist\heist_util::_id_EAFA();
  level._id_AC79 = 0;
  level._id_92DA = 0;
  var_0 = getEnt("origin_lift_scene", "targetname");

  foreach(var_2 in level.allies) {
    var_0 thread _id_EBEE(var_2);
  }

  while(level._id_AC79 < 4) {
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_wait("mons_landed_end");
  setomnvar("ui_hide_hud", 1);
  scripts\sp\maps\heist\heist_util::_id_5569(["prone", "offhandweapons", "offhandprimaryweapons", "offhandsecondaryweapons"]);
  scripts\engine\utility::delaythread(1, scripts\sp\maps\heist\heist_util::_id_6229, "prone");
  scripts\sp\utility::_id_E006();
  level.player scripts\sp\utility::_id_F526("safe");

  while(!scripts\engine\utility::flag("elevator_safe_flag")) {
    wait 0.05;
  }

  var_4 = getEnt("lift_filler_clip_1", "targetname");
  var_4.origin = var_4.origin + (0, 0, -112);
  var_4 linkTo(level._id_AC77);
  scripts\sp\maps\heist\heist_util::_id_4264("door_lift_lower_left", "door_lift_lower_right", 1);
  scripts\engine\utility::flag_clear("obj_getonlift");

  while(level._id_92DA < 4) {
    scripts\engine\utility::waitframe();
  }

  var_0 notify("stop_loop_salter");
  var_0 notify("stop_loop_ethan");
  var_0 notify("stop_loop_brooks");
  var_0 notify("stop_loop_kashima");
  level notify("stop_all_nags");
  wait 0.1;
  level scripts\engine\utility::delaythread(6, ::_id_68A9);
  level scripts\engine\utility::delaythread(10, ::_id_68A9);
  level scripts\engine\utility::delaythread(17, ::_id_68A9);
  level thread scripts\sp\maps\heist\heist_util::_id_C152("shake", ::_id_6899);
  level thread scripts\sp\maps\heist\heist_util::_id_C152("bank_left", ::_id_67F7);
  level thread scripts\sp\maps\heist\heist_util::_id_C152("bank_right", ::_id_67F8);
  scripts\engine\utility::array_call(level.allies, ::linkto, var_0);
  var_0 thread scripts\sp\anim::_id_1F2C(level.allies, "elevator");
  level notify("start_bink");
  level.player scripts\engine\utility::delaycall(2.75, ::_meth_8291, 0.5, 0.5, 0.5, 0.25, 0, 0, 0, 15, 15, 15);
  level.player scripts\engine\utility::delaycall(2.75, ::playsound, "heist_mons_elevator_rattle_2");
  level.player scripts\engine\utility::delaycall(3.75, ::playrumbleonentity, "light_1s");
  level.player scripts\engine\utility::delaycall(2.75, ::playsound, "heist_mons_elevator_rattle_1");
  wait 3;
  scripts\engine\utility::flag_set("lift_start_move");
  wait 35.1;
  level._id_6754 scripts\sp\utility::_id_51E1("combat");
  level._id_6754.moveplaybackrate = 1.0;
  scripts\engine\utility::waitframe();
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_F3B5, "r");
  scripts\engine\utility::waitframe();
  wait 0.5;
  scripts\engine\utility::array_call(level.allies, ::unlink);
  scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_2669, "lift_ended");
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_61C7);
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_51E1, "combat");
  level.player scripts\sp\utility::_id_F526("normal");
  scripts\sp\maps\heist\heist_util::_id_6229(["offhandweapons", "offhandprimaryweapons", "offhandsecondaryweapons"]);
  setomnvar("ui_hide_hud", 0);
  scripts\engine\utility::flag_set("obj_gettobridge");
  thread _id_C60D();
  thread _id_1AD2();
  thread _id_548C();
  thread _id_969B();
  level waittill("lift_end");
  thread scripts\sp\maps\heist\heist_util::_id_1103D();
}

cleanup_lift() {
  if(isDefined(level._id_AC77)) {
    if(isDefined(level._id_AC77._id_B926)) {
      scripts\sp\utility::_id_228A(level._id_AC77._id_B926);
      level._id_AC77._id_B926 = scripts\engine\utility::array_removeundefined(level._id_AC77._id_B926);
    }

    level._id_AC77 delete();
  }
}

_id_C60D() {
  thread scripts\sp\maps\heist\heist_util::_id_F363("door_lift_hall_right", "unlock");
  scripts\engine\utility::flag_wait("lift_end");
  thread scripts\sp\maps\heist\heist_util::_id_C5F0("door_lift_hall_left", "door_lift_hall_right", 0.75);
}

_id_1AD2() {
  scripts\engine\utility::flag_wait("lift_end");
  var_0 = scripts\sp\utility::_id_107EA("airlock_runner_1", 1);
  var_0 _id_108C5();
  wait 0.5;
  var_1 = scripts\sp\utility::_id_107EA("airlock_runner_2", 1);
  var_1 _id_108C5();
  wait 1;
  var_2 = scripts\sp\utility::_id_107EA("airlock_runner_0", 1);
  var_0 thread _id_A613();
  var_1 thread _id_A613();
}

_id_108C5() {
  self.moveplaybackrate = 1.2;
  self.ignoreall = 1;
  self.ignoreme = 1;
  scripts\sp\utility::_id_5564();
}

_id_A613() {
  self endon("death");
  wait 6;
  self waittill("goal");
  self delete();
}

_id_969B() {
  var_0 = getEntArray("nitro_1", "targetname");
  var_1 = getEntArray("nitro_2", "targetname");
  var_2 = getEntArray("nitro_3", "targetname");
  var_3 = getEntArray("nitro_4", "targetname");
  var_4 = getEntArray("nitro_5", "targetname");
  var_5 = getEntArray("nitro_6", "targetname");
  var_6 = getEntArray("nitro_7", "targetname");
  var_7 = getEntArray("nitro_8", "targetname");
  var_8 = [var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7];
  scripts\engine\utility::array_thread(var_8, ::_id_AD16);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::array_thread(var_8, ::_id_9773);
  scripts\engine\utility::flag_wait("lift_end");
  var_0 thread _id_BC76();
  wait 0.5;
  var_1 thread _id_BC76();
  wait 0.4;
  var_2 thread _id_BC76();
  wait 0.4;
  var_3 thread _id_BC76();
  wait 0.5;
  var_4 thread _id_BC76();
  wait 0.5;
  var_5 thread _id_BC76();
  wait 0.5;
  var_6 thread _id_BC76();
  wait 0.5;
  var_7 thread _id_BC76(1, 3);
}

_id_AD16() {
  level endon("start_slide");
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in self) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "clip") {
      var_0 = var_3;
    }
  }

  foreach(var_3 in self) {
    if(isDefined(var_3.classname) && var_3.classname == "script_model") {
      var_1 = var_3;
    }
  }

  var_0 linkTo(var_1);
  var_0 disconnectPaths();
  level waittill("tank_down");
  var_0 connectpaths();
}

_id_9773() {
  var_0 = undefined;

  foreach(var_2 in self) {
    if(isDefined(var_2.classname) && var_2.classname == "script_model") {
      var_0 = var_2;
    }
  }

  var_0 movez(76, 0.05);
}

_id_BC76(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 3.5;
  }

  foreach(var_3 in self) {
    if(isDefined(var_3.classname) && var_3.classname == "script_model") {
      var_4 = scripts\engine\utility::spawn_tag_origin(var_3.origin + (0, 0, 50), var_3.angles + (0, 0, 90));
      var_3 playSound("heist_nitrogen_move_start");
      var_3 movez(-76 * var_0, var_1);
      playFXOnTag(scripts\engine\utility::getfx("vfx_heist_nitrogen_ground"), var_4, "tag_origin");
      var_3 playLoopSound("heist_nitrogen_move_lp");
      var_3 waittill("movedone");
      var_3 playSound("heist_nitrogen_move_stop");
      level notify("tank_down");
      var_3 stoploopsound("heist_nitrogen_move_lp");
      wait 1;
      stopFXOnTag(scripts\engine\utility::getfx("vfx_heist_nitrogen_ground"), var_4, "tag_origin");
      var_4 delete();
    }
  }
}

_id_EBEE(var_0) {
  var_1 = var_0 scripts\sp\utility::_id_7DC1("elevator_idle");
  var_2 = getstartorigin(self.origin, self.angles, var_1[0]);

  if(var_0 != level._id_A54E) {
    var_0 thread _id_3B1C(var_2);
  }

  if(var_0 == level._id_A54E) {
    wait 2;
  }

  var_0 thread _id_AC7A();
  var_0 thread _id_92DB();
  scripts\sp\anim::_id_1F0D(var_0, "elevator_idle");
  thread _id_EBED(var_0);
  var_0 notify("in_lift");
}

_id_AC7A() {
  scripts\engine\utility::waittill_either("anim_reach_complete", "arrived");
  level._id_AC79++;
}

_id_92DB() {
  self waittill("idle_start");
  level._id_92DA++;
}

_id_3B1C(var_0) {
  var_1 = distance2dsquared(self.origin, var_0);
  var_2 = squared(150);

  while(var_1 > var_2) {
    var_1 = distance2dsquared(self.origin, var_0);
    wait 0.05;
  }

  self notify("arrived");
  scripts\sp\utility::_id_51E1("casual_gun");
}

_id_EBED(var_0) {
  level endon("lift_start_move");
  level endon("stop_all_nags");
  var_0 notify("idle_start");
  thread scripts\sp\anim::_id_1EEA(var_0, "elevator_idle", "stop_loop_" + var_0._id_1FBB);

  if(var_0 != level._id_EA2C && var_0 != level._id_30F6) {
    return;
  }
  var_1 = 5;

  for(;;) {
    scripts\engine\utility::flag_waitopen("mons_landed_end");
    wait(var_1);

    if(!scripts\engine\utility::flag("lift_nag_active")) {
      scripts\engine\utility::flag_set("lift_nag_active");
      self notify("stop_loop_" + var_0._id_1FBB);
      var_0 notify("stop_loop_" + var_0._id_1FBB);
      var_0 notify("stop_loop");
      scripts\sp\anim::_id_1F35(var_0, "elevator_nag");
      thread scripts\sp\anim::_id_1EEA(var_0, "elevator_idle", "stop_loop_" + var_0._id_1FBB);
      scripts\engine\utility::flag_clear("lift_nag_active");
      break;
    } else {
      var_1 = 15;
      continue;
    }
  }
}

_id_A710() {
  scripts\sp\maps\heist\heist_util::_id_10751();
  level._id_AC7E hide();
  level._id_AC7F hide();
  level._id_AC80 hide();
  setomnvar("ui_show_bink", 0);
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingameloopresident("heist_hud_quad_loop", 1);
  level waittill("start_bink");
  level._id_A711 = spawn("script_origin", level._id_AC7E.origin);
  wait 0.5;
  level._id_AC7E show();
  stopcinematicingame();
  thread _id_6F15();
  setomnvar("ui_show_bink", 0);
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  level._id_A711 playSound("heist_lift_kotch_bink");
  cinematicingame("heist_hud_kotch_pip");
  scripts\engine\utility::waitframe();
  pausecinematicingame(1);
  wait 1;
  level._id_A711 moveTo((-13636, 15606, -85554), 26, 1, 1);
  level.player setclienttriggeraudiozonepartialwithfade("heist_kotch_bink", 0.5, "mix");
  thread _id_8D19();
  level._id_AC7E hide();
  pausecinematicingame(0);
  wait 26.0;
  stopcinematicingame();
  level._id_A711 stopsounds();
  scripts\engine\utility::waitframe();
  level._id_A711 delete();
  level._id_AC7F show();
  setomnvar("ui_show_bink", 0);
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingameloopresident("heist_hud_quad_loop", 1);
  pausecinematicingame(1);
  thread _id_6F15();
  wait 1;
  pausecinematicingame(0);
}

_id_8D19() {
  setmusicstate("mx_190_heist_post_c12");
  wait 31;
  setmusicstate("");
  level.player clearclienttriggeraudiozone(1.0);
  wait 4.75;
  setmusicstate("mx_417_heist_slide");
}

_id_6F15() {
  wait 0.1;
  level._id_AC7F show();
  wait 0.1;
  level._id_AC7F hide();
  wait 0.1;
  level._id_AC7F show();
  wait 0.1;
  level._id_AC7F hide();
  wait 0.1;
  level._id_AC7F show();
  wait 0.1;
  level._id_AC7F hide();
  wait 0.1;
  level._id_AC7F show();
  wait 0.1;
  level._id_AC7F hide();
  wait 0.1;
  level._id_AC7F show();
  wait 0.1;
  level._id_AC7F hide();
}

_id_D08B() {
  wait 2;
  level._id_EA2C waittillmatch("single anim", "pvo_heist_plr_comeandgetmekot");
  level.player thread scripts\sp\utility::_id_D090("ges_scripted_pickupandfight");
}

_id_68A9() {
  var_0 = randomfloatrange(0.1, 0.3);
  var_1 = randomfloatrange(0.1, 0.3);
  var_2 = randomfloatrange(0.1, 0.3);
  var_3 = randomfloatrange(2, 3);
  var_4 = randomfloatrange(5, 15);
  var_5 = randomfloatrange(5, 15);
  var_6 = randomfloatrange(5, 15);
  level.player _meth_8291(var_0, var_1, var_2, var_3, var_3 * -0.25, var_3 * -0.5, 0, var_4, var_5, var_6);
  level.player playRumbleOnEntity("light_2s");
}

_id_6899() {
  level.player playSound("heist_mons_quakes");
  earthquake(0.5, 1.5, level.player.origin, 360);
  level.player playRumbleOnEntity("heavy_3s");
  wait 3;
  thread _id_68A9();
}

_id_67F7() {
  var_0 = randomfloatrange(2.0, 2.5);
  scripts\sp\maps\heist\heist_util::_id_CB09(1, 300, var_0);
  level.player playSound("heist_mons_quakes");
  level.player playSound("pnr_elm_metalstress01");
  level._id_8632 rotateTo((0, 0, -8), var_0, 0.75, 0.75);
  scripts\engine\utility::exploder("mons_lift_sparks_1");
  level.player _meth_8291(0.25, 0.25, 0.25, var_0, 0, -1, 0, 30, 30, 30);
  level.player playRumbleOnEntity("heavy_3s");
  level.player thread scripts\sp\utility::_id_D090("ges_safe_stumble_1");
  var_1 = vectorNormalize((0, -500, 0));
  var_1 = var_1 * 10;
  thread scripts\sp\maps\heist\heist_util::_id_4D77(var_1, var_0);
  wait(var_0);
  level._id_8632 rotateTo((0, 0, 0), 3, 0.75, 0.75);
  var_0 = randomfloatrange(1.5, 2.0);
  level.player _meth_8291(0.25, 0.25, 0.25, var_0, 0, -1, 0, 30, 30, 30);
  level.player playRumbleOnEntity("heavy_3s");
}

_id_67F8() {
  var_0 = randomfloatrange(2.0, 2.5);
  scripts\sp\maps\heist\heist_util::_id_CB09(-1, 300, var_0);
  scripts\engine\utility::flag_set("lift_moving_cover_state_1");
  level.player playSound("heist_mons_quakes");
  level.player playSound("pnr_elm_metalstress01");
  level._id_8632 rotateTo((0, 0, 8), 3, 0.75, 0.75);
  scripts\engine\utility::exploder("mons_lift_sparks_2");
  level.player _meth_8291(0.25, 0.25, 0.25, var_0, 0, -1, 0, 30, 30, 30);
  level.player playRumbleOnEntity("heavy_3s");
  level.player thread scripts\sp\utility::_id_D090("ges_safe_stumble_2");
  var_1 = vectorNormalize((0, 500, 0));
  var_1 = var_1 * 10;
  thread scripts\sp\maps\heist\heist_util::_id_4D77(var_1, var_0);
  wait(var_0);
  level._id_8632 rotateTo((0, 0, 0), 3, 0.75, 0.75);
  var_0 = randomfloatrange(2.0, 2.5);
  level.player _meth_8291(0.25, 0.25, 0.25, var_0, 0, -1, 0, 30, 30, 30);
  level.player playRumbleOnEntity("heavy_3s");
  wait(var_0);
  thread scripts\sp\maps\heist\heist_util::_id_10D16();
}

cargo_lift_preinit() {
  var_0 = scripts\engine\utility::get_target_ent("mover_lift");
  var_0.model_structs = [];

  foreach(var_2 in getEntArray("lift_models", "script_noteworthy")) {
    var_3 = spawnStruct();
    var_3.model = var_2.model;
    var_3.origin = var_2.origin;
    var_3.angles = var_2.angles;
    var_2 delete();
    var_0.model_structs[var_0.model_structs.size] = var_3;
  }

  level._id_AC77 = var_0;
}

_id_3A73() {
  while(!isDefined(level._id_AC77)) {
    scripts\engine\utility::waitframe();
  }

  level._id_AC77._id_119F3 = scripts\engine\utility::get_target_ent("ref_top_lift");
  getEnt("origin_lift_scene", "targetname") linkTo(level._id_AC77);
  level._id_AC7E = getEnt("lift_screen_1", "targetname");
  level._id_AC7E linkTo(level._id_AC77);
  level._id_AC7F = getEnt("lift_screen_2", "targetname");
  level._id_AC7F linkTo(level._id_AC77);
  level._id_AC80 = getEnt("lift_screen_3", "targetname");
  level._id_AC80 linkTo(level._id_AC77);
  level._id_AC77._id_B926 = [];

  foreach(var_1 in level._id_AC77.model_structs) {
    var_2 = spawn("script_model", var_1.origin);
    var_2 setModel(var_1.model);
    var_2.angles = var_1.angles;
    var_2 linkTo(level._id_AC77);
    level._id_AC77._id_B926[level._id_AC77._id_B926.size] = var_2;
  }

  var_4 = getEntArray("light_mons_lift_screen", "script_noteworthy");

  if(isDefined(var_4)) {
    scripts\engine\utility::array_call(var_4, ::linkto, level._id_AC77);
  }

  scripts\engine\utility::waitframe();
  level._id_AC77 _meth_80AF(undefined);
  scripts\engine\utility::flag_set("elevator_ready");
}

_id_3A75() {
  scripts\engine\utility::flag_wait("lift_start_move");
  level._id_AC77 playSound("heist_mons_elevator_start");
  level.player playSound("heist_mons_elevator_rattle_1");
  scripts\engine\utility::flag_set("transient_mons_lift");
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 4);
  scripts\sp\maps\heist\heist_hangar::_id_4085();
  level._id_AC77 _meth_83C9(undefined);
  level._id_AC77 moveTo(level._id_AC77._id_119F3.origin, 25, 1, 1);
  level._id_AC77 playLoopSound("heist_mons_elevator_lp");
  scripts\engine\utility::flag_set("transient_mons_deck");
  wait 30;
  level._id_AC77 _meth_80AF(undefined);
  level._id_AC77 playSound("heist_mons_elevator_stop");
  wait 3.5;
  thread scripts\sp\maps\heist\heist_util::_id_FD33("deck");
  thread scripts\sp\maps\heist\heist_util::_id_C5F0("door_lift_upper_left", "door_lift_upper_right", 1);
  scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_15F3, "top_of_lift_color");
  wait 3;
  level notify("lift_end");
}

_id_3A60() {
  self waittill("trigger", var_0);
  var_1 = getEnt("cargo_area_exit_phy_volume", "targetname");
  var_1 physics_volumesetactivator(1);
  var_2 = vectorNormalize((0, -500, 0));
  var_1 physics_volumesetasdirectionalforce(1, var_2, 100);
  var_1 physics_volumeenable(1);
  level.player playSound("heist_mons_quakes");
  level._id_8632 rotateTo((0, 0, -5), 3, 0.75, 0.75);
  level._id_3F8E rotateTo((0, 0, -5), 3, 0.75, 0.75);
  var_3 = randomfloatrange(1.0, 1.5);
  level.player _meth_8291(0.25, 0.25, 0.25, var_3, 0, -1, 0, 30, 30, 30);
  level.player playRumbleOnEntity("heavy_3s");
  var_4 = vectorNormalize((0, -500, 0));
  var_4 = var_4 * 10;
  thread scripts\sp\maps\heist\heist_util::_id_4D77(var_4, 2.9);
  wait 3.1;
  var_1 physics_volumesetactivator(0);
  var_1 physics_volumeenable(0);
  level.player playSound("heist_mons_quakes");
  level._id_8632 rotateTo((0, 0, 0), 3, 0.75, 0.75);
  level._id_3F8E rotateTo((0, 0, 0), 3, 0.75, 0.75);
  var_3 = randomfloatrange(2.0, 2.5);
  level.player _meth_8291(0.25, 0.25, 0.25, var_3, 0, -1, 0, 30, 30, 30);
  level.player playRumbleOnEntity("heavy_3s");
}

_id_16DD(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_2 thread[[var_1]]();
  return;
}

_id_548C() {
  wait 2;
  level._id_30F6 scripts\sp\utility::_id_10346("heist_brk_olympusispoweri");
  level.player scripts\sp\utility::_id_1034D("heist_plr_theycanscuttlen");
  scripts\engine\utility::flag_wait("lift_end");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("heist_plr_wheretoethan");
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_airlockouttothe");
}