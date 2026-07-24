/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\yard\yard_elevator.gsc
**************************************************/

_id_6072() {
  scripts\engine\utility::flag_init("elevator_arrival_end");
  scripts\engine\utility::flag_init("elevator_airlock_end");
  scripts\engine\utility::flag_init("elevator_zero_g_combat_end");
  scripts\engine\utility::flag_init("salter_intro_done");
  scripts\engine\utility::flag_init("mac_intro_done");
  scripts\engine\utility::flag_init("stop_elevator");
  scripts\engine\utility::flag_init("fl_hall_go_loud");
  scripts\engine\utility::flag_init("mac_in_mac_death_airlock");
  scripts\engine\utility::flag_init("salter_in_mac_death_airlock");
  scripts\engine\utility::flag_init("salter_airlock_nag");
  scripts\engine\utility::flag_init("salter_airlock_nag_done");
  scripts\engine\utility::flag_init("load_scripted_drop_pod");
  scripts\engine\utility::flag_init("catwalk_to_console_start");
  scripts\engine\utility::flag_init("mac_death_tappy_started");
  scripts\engine\utility::flag_init("mac_death_tappy_done");
  scripts\engine\utility::flag_init("elevator_mac_death_end");
  scripts\engine\utility::flag_init("mac_death_scene_c_start");
  scripts\engine\utility::flag_init("mac_death_scene_d_start");
  scripts\engine\utility::flag_init("mac_death_scene_e_start");
  scripts\engine\utility::flag_init("mac_death_scene_end");
  scripts\engine\utility::flag_init("salter_goto_airlock");
  scripts\engine\utility::flag_init("salter_at_ambush_door");
  scripts\engine\utility::flag_init("salter_at_ambush_overlook");
  scripts\engine\utility::flag_init("guy_01_in_place");
  scripts\engine\utility::flag_init("guy_02_in_place");
  scripts\engine\utility::flag_init("ambush_combat_started");
  scripts\engine\utility::flag_init("no_more_ambush_jumpers");
  scripts\engine\utility::flag_init("ambush_done");
  scripts\engine\utility::flag_init("elevator_top_end");
  scripts\engine\utility::flag_init("post_ambush_vo_done");
  scripts\engine\utility::flag_init("ambush_elevator_done_moving");
  scripts\engine\utility::flag_init("junction_bink_finished");
}

_id_60BB() {}

_id_60CA(var_0) {
  if(!isDefined(level._id_EA2C)) {
    scripts\sp\maps\yard\yard_util::_id_1065E("seat_elevator_brooks");
    scripts\sp\maps\yard\yard_util::_id_106D9("seat_elevator_ethan");

    if(!isDefined(var_0)) {
      scripts\sp\maps\yard\yard_util::_id_107BE("seat_elevator_salter");
      scripts\sp\maps\yard\yard_util::_id_10766("seat_elevator_mccallum");
      level.player scripts\sp\utility::_id_11633(getEnt("seat_elevator_player", "targetname"));
    } else {
      scripts\sp\maps\yard\yard_util::_id_107BE("seat_elevator_salter");
      scripts\sp\maps\yard\yard_util::_id_10766("seat_elevator_mccallum");
      level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("elevator_airlock_mccallum_pre_teleport", "targetname"));
    }

    thread _id_604C("elevator_crew04", "seat_elevator_gator", undefined, 1, var_0);
    thread _id_604C("elevator_crew02", "seat_elevator_marine02", 0.73, undefined, var_0);
    thread _id_604C("elevator_crew03", "seat_elevator_marine03", 0.15, undefined, var_0);
    thread _id_604C("elevator_crew01", "seat_elevator_marine04", 0.47, undefined, var_0);
    thread _id_604C("elevator_crew05", "seat_elevator_marine06", 0.59, 1, var_0);
    thread _id_604C("elevator_crew06", "seat_elevator_marine12", 0.23, undefined, var_0);
    thread _id_604C("elevator_crew07", "seat_elevator_marine13", 0.36, undefined, var_0);
  }
}

_id_604C(var_0, var_1, var_2, var_3, var_4) {
  if(!isent(var_0)) {
    var_5 = scripts\engine\utility::get_target_ent(var_0);
    var_5.count = 1;
    var_6 = var_5 scripts\sp\utility::_id_10619(1);
    var_6._id_1FBB = "generic";
  } else
    var_6 = var_0;

  _id_604A(var_6, var_1, var_2, var_3, var_4);
}

#using_animtree("generic_human");

_id_604A(var_0, var_1, var_2, var_3, var_4) {
  var_1 = _id_604B(var_1);

  if(isDefined(var_0)) {
    var_0 scripts\sp\maps\yard\yard_util::_id_B399(var_1);
    var_0 scripts\sp\utility::_id_86E4();
  }

  var_1 thread scripts\sp\anim::_id_1EEA(var_1, "elevator_npc01_idle");
  var_5 = getanimlength(%mars_elevator_dropseat_idle_female);
  var_6 = getanimlength(%mars_elevator_dropseat_idle_male);

  if(scripts\engine\utility::is_true(var_3)) {
    if(isDefined(var_2) &!isDefined(var_4))
      wait(var_5 * var_2);

    if(isDefined(var_0)) {
      if(isDefined(var_0._id_EDB8) && var_0._id_EDB8 == "Boats")
        var_1 thread scripts\sp\anim::_id_1EEA(var_0, "elevator_end_idle");
      else
        var_1 thread scripts\sp\anim::_id_1EEA(var_0, "elevator_npc01_idle_female");
    }
  } else {
    if(isDefined(var_2) &!isDefined(var_4))
      wait(var_6 * var_2);

    if(isDefined(var_0))
      var_1 thread scripts\sp\anim::_id_1EEA(var_0, "elevator_npc01_idle_male");
  }

  scripts\engine\utility::flag_wait("close_space_elevator");

  if(isDefined(var_0) && isalive(var_0))
    var_0 delete();

  var_1 delete();
}

_id_604B(var_0) {
  if(!isent(var_0))
    var_0 = getEnt(var_0, "targetname");

  if(!isDefined(var_0._id_9C9A)) {
    var_0._id_1FBB = "elevator_seat";
    var_0 scripts\sp\utility::_id_23B7();
    var_0._id_9C9A = 1;
  }

  return var_0;
}

_id_10C2B() {
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_arrival", "start");

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_8E06();
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  scripts\engine\utility::flag_set("yard_start_objectives");
}

_id_B1CA() {
  _id_0F35::main();
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_arrival", "main");
  setmusicstate("mx_273_yard_intro_elevator");
  _id_60CA();
  var_0 = getEnt("space_elevator_door_closed", "targetname");
  var_1 = getEnt("space_elevator_door_closed_clip", "targetname");
  scripts\engine\utility::waitframe();
  var_1 connectpaths();
  var_0 scripts\sp\utility::_id_8E9A();
  var_1 scripts\sp\utility::_id_8E9A();
  scripts\sp\utility::_id_2669("yard_elevator_arrival");
  scripts\sp\maps\yard\yard_fx::_id_132CD(1);
  var_2 = getEntArray("fake_elevator_pod", "targetname");
  scripts\engine\utility::array_call(var_2, ::hide);
  thread _id_6039();
  scripts\engine\utility::flag_wait("elevator_arrival_end");
}

_id_3B5A() {
  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_8E06();
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  _id_0F35::main();
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_arrival", "catchup");
}

_id_6039() {
  level._id_6037 = getEnt("elevator_animnode", "targetname");
  level._id_EA2C thread _id_60B0("seat_elevator_salter", "seat_salter", "mount_elevator_salter", "mount_salter");
  level._id_6754 thread _id_60B0("seat_elevator_ethan", "seat_ethan", "mount_elevator_ethan", "mount_ethan", 1);
  level._id_30F6 thread _id_60B0("seat_elevator_brooks", "seat_brooks", "mount_elevator_brooks", "mount_brooks", 1);
  level._id_B4F1 thread _id_60B0("seat_elevator_mccallum", "seat_mccallum", "mount_elevator_mccallum", "mount_mccallum");
  level._id_EA2C thread scripts\sp\utility::_id_DC45("raise");
  level._id_B4F1 thread scripts\sp\utility::_id_DC45("raise");
  level._id_30F6 thread scripts\sp\utility::_id_DC45("raise");
  level thread _id_0E4B::_id_1348D(1);
  thread _id_60DD();
  thread elevator_zoom();
  thread scripts\sp\maps\yard\yard_audio::_id_259F();
  var_0 = undefined;
  var_1 = level.player scripts\sp\utility::_id_7D74();

  if(isDefined(var_1[0]))
    var_0 = var_1[0];

  level.player disableweapons();
  scripts\sp\player_rig::_id_AD09(25, 32, 25, 25);
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level._id_6037 scripts\sp\anim::_id_1EC3(level._id_D267, "elevator_player_idle");
  var_2 = spawn("script_model", level.player.origin);

  if(isDefined(var_0))
    var_2 setModel(getweaponmodel(var_0));
  else
    var_2 setModel("tag_origin");

  var_2.origin = level._id_D267 gettagorigin("tag_weapon");
  var_2.angles = level._id_D267 gettagangles("tag_weapon");
  var_2 linkTo(level._id_D267, "tag_weapon");
  var_3 = getEnt("seat_elevator_player", "targetname");
  var_3._id_1FBB = "elevator_seat";
  var_3 scripts\sp\utility::_id_23B7();
  var_4 = getEnt("mount_elevator_player", "targetname");
  var_4._id_1FBB = "elevator_mount";
  var_4 scripts\sp\utility::_id_23B7();
  level._id_6037 thread scripts\sp\anim::_id_1F35(level._id_D267, "elevator_player_idle");
  level._id_6037 thread scripts\sp\anim::_id_1F35(var_3, "seat_player_idle");
  wait 0.05;
  thread _id_ADB3();
  var_5 = getanimlength(level._id_D267 scripts\sp\utility::_id_7DC1("elevator_player_idle"));
  wait(var_5 - 2);
  level.player lerpviewangleclamp(1.5, 0.5, 0.5, 5, 5, 5, 5);
  level._id_D267 waittillmatch("single anim", "end");
  thread scripts\sp\utility::_id_12641("yard_vista_tr");
  thread scripts\sp\utility::_id_12641("yard_vista_ring_tr");
  level._id_6037 thread scripts\sp\anim::_id_1F35(var_3, "seat_player_get_out");
  level._id_6037 thread scripts\sp\anim::_id_1F35(var_4, "mount_player_get_out");
  level._id_6037 scripts\sp\anim::_id_1F35(level._id_D267, "elevator_player_exit");
  var_2 delete();
  level.player unlink();
  level._id_D267 delete();
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player enableweapons();
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\engine\utility::flag_set("elevator_arrival_end");
}

_id_ADB3() {
  wait 2;
  thread scripts\sp\utility::_id_12641("yard_base_tr");
}

_id_60B0(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = getEnt(var_0, "targetname");
  var_6._id_1FBB = "elevator_seat";
  var_6 scripts\sp\utility::_id_23B7();
  var_7 = getEnt(var_2, "targetname");
  var_7._id_1FBB = "elevator_mount";
  var_7 scripts\sp\utility::_id_23B7();

  if(!isDefined(var_5)) {
    level._id_6037 thread scripts\sp\anim::_id_1F35(self, "elevator_scene");
    level._id_6037 thread scripts\sp\anim::_id_1F35(var_6, var_1);
    level._id_6037 thread scripts\sp\anim::_id_1F35(var_7, var_3);
    self waittillmatch("single anim", "end");

    if(self == level._id_EA2C)
      scripts\engine\utility::flag_set("salter_intro_done");

    if(self == level._id_B4F1)
      scripts\engine\utility::flag_set("mac_intro_done");
  } else {
    level._id_6037 thread scripts\sp\anim::_id_1EE0(var_6, var_1);
    level._id_6037 thread scripts\sp\anim::_id_1EE0(var_7, var_3);
    scripts\engine\utility::waitframe();
  }

  if(isDefined(var_4)) {
    level._id_6037 thread scripts\sp\anim::_id_1EEA(self, "elevator_end_idle");
    level waittill("airlock_kiosk_used");
  }
}

elevator_zoom() {
  var_0 = getEntArray("space_elevator_window_slats", "targetname");
  scripts\engine\utility::array_call(var_0, ::rotatepitch, -73.8, 0.05);
  wait 7;
  scripts\engine\utility::array_call(var_0, ::rotatepitch, -73.8, 4, 1, 1);
  var_0[3] thread scripts\sp\maps\yard\yard_audio::_id_25A6(4);
  scripts\engine\utility::flag_wait("close_space_elevator");
  scripts\sp\utility::_id_228A(var_0);
}

_id_60DD() {
  var_0 = _id_318D(getEntArray("elevator_tube_01", "targetname"));
  var_1 = _id_318D(getEntArray("elevator_tube_02", "targetname"));
  var_2 = _id_318D(getEntArray("elevator_tube_03", "targetname"));
  wait 0.05;
  var_0 thread _id_60DE("mid2");
  var_1 thread _id_60DE("mid1");
  var_2 thread _id_60DE("start");
  thread scripts\sp\maps\yard\yard_audio::_id_25A4(var_0, var_1, var_2);
  var_3 = scripts\sp\utility::_id_7C23();
  var_3 scripts\sp\utility::_id_F581(0.65);
  wait 0.05;
  var_3 thread _id_DC74();
  scripts\engine\utility::flag_wait("stop_elevator");
  wait 0.25;
  screenshake(level.player.origin, 0.2, 0, 0, 7.0, 0, 5.0, 0, 15);
  var_3 thread scripts\sp\utility::_id_E7C9(0.05, 7.0);
  wait 7.0;
  var_3._id_99E5 = 0;
  scripts\engine\utility::flag_wait("close_space_elevator");
  var_0 thread _id_406E();
  var_1 thread _id_406E();
  var_2 thread _id_406E();
}

_id_DC74() {
  while(!scripts\engine\utility::flag("stop_elevator")) {
    var_0 = randomfloatrange(2.0, 4.5);
    scripts\sp\utility::_id_E7C9(0.15, var_0);
    wait(randomfloatrange(1.0, 5.0));
    var_0 = randomfloatrange(0.25, 1.0);
    scripts\sp\utility::_id_E7C9(0.65, var_0);
    screenshake(level.player.origin, 0.2, 0, 0, var_0, 0, var_0 * 0.5, 0, 15);
    wait(randomfloatrange(1.0, 2.0));
  }
}

_id_60DE(var_0) {
  var_1 = 2;
  var_2 = scripts\engine\utility::getStruct("elevator_tube_spot_1", "targetname");
  var_3 = scripts\engine\utility::getStruct("elevator_tube_spot_2", "targetname");
  var_4 = scripts\engine\utility::getStruct("elevator_tube_spot_3", "targetname");
  var_5 = scripts\engine\utility::getStruct("elevator_tube_spot_4", "targetname");
  var_6 = undefined;
  self._id_C6EA dontinterpolate();

  if(var_0 == "start") {
    self._id_C6EA.origin = var_2.origin;
    var_6 = var_3;
  } else if(var_0 == "mid1") {
    self._id_C6EA.origin = var_3.origin;
    var_6 = var_4;
  }

  if(var_0 == "mid2") {
    self._id_C6EA.origin = var_4.origin;
    var_6 = var_5;
  }

  waittillframeend;

  for(;;) {
    if(isDefined(var_6)) {
      self._id_C6EA moveTo(var_6.origin, var_1, 0, 0);
      wait(var_1);
    } else {
      foreach(var_8 in self._id_ACFC)
      var_8 dontinterpolate();

      self._id_60DC dontinterpolate();
      self._id_C6EA dontinterpolate();
      self._id_C6EA.origin = var_2.origin;
      var_6 = var_3;
      waittillframeend;
      self._id_C6EA moveTo(var_6.origin, var_1, 0, 0);
      wait(var_1);
    }

    if(isDefined(var_6.target))
      var_6 = scripts\engine\utility::getStruct(var_6.target, "targetname");
    else
      var_6 = undefined;

    if(scripts\engine\utility::flag("stop_elevator")) {
      break;
    }
  }

  var_1 = 4.0;

  if(isDefined(var_6)) {
    self._id_C6EA moveTo(var_6.origin, var_1, 0, var_1);
    wait(var_1);
  } else {
    foreach(var_8 in self._id_ACFC)
    var_8 dontinterpolate();

    self._id_60DC dontinterpolate();
    self._id_C6EA dontinterpolate();
    self._id_C6EA.origin = var_2.origin;
    var_6 = var_3;
    waittillframeend;
    self._id_C6EA moveTo(var_6.origin, var_1, 0, var_1);
    wait(var_1);
  }
}

_id_318D(var_0) {
  var_1 = spawnStruct();
  var_1._id_ACFC = [];

  foreach(var_3 in var_0) {
    var_3._id_124E = var_1;

    if(!isDefined(var_3.script_type)) {
      continue;
    }
    if(var_3.script_type == "link") {
      var_1._id_ACFC[var_1._id_ACFC.size] = var_3;
      continue;
    }

    if(var_3.script_type == "elevator_tube")
      var_1._id_60DC = var_3;
  }

  foreach(var_6 in var_1._id_ACFC)
  var_6 linkTo(var_1._id_60DC);

  var_1._id_C6EA = var_1._id_60DC scripts\engine\utility::spawn_tag_origin();
  var_1._id_60DC linkTo(var_1._id_C6EA);
  return var_1;
}

_id_406E() {
  foreach(var_1 in self._id_ACFC) {
    if(isDefined(var_1))
      var_1 delete();
  }

  if(isDefined(self._id_60DC))
    self._id_60DC delete();

  if(isDefined(self._id_C6EA))
    self._id_C6EA delete();
}

_id_406F() {
  var_0 = getEntArray("elevator_tube_01", "targetname");
  var_1 = getEntArray("elevator_tube_02", "targetname");
  var_2 = getEntArray("elevator_tube_03", "targetname");
  scripts\sp\utility::_id_228A(var_0);
  scripts\sp\utility::_id_228A(var_1);
  scripts\sp\utility::_id_228A(var_2);
  var_3 = getEntArray("elevator_seats_mounts", "script_noteworthy");

  foreach(var_5 in var_3) {
    if(isDefined(var_5))
      var_5 delete();
  }

  var_7 = getEntArray("space_elevator_window_slats", "targetname");
  scripts\sp\utility::_id_228A(var_7);
}

_id_406D() {
  var_0 = getEnt("space_elevator_door_closed", "targetname");
  var_1 = getEnt("space_elevator_door_closed_clip", "targetname");
  var_2 = getEntArray("elevator_hall_ents", "script_noteworthy");
  scripts\sp\utility::_id_228A(var_2);
}

_id_10C2C() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_combat", "start");
  level._id_6037 = getEnt("elevator_animnode", "targetname");
  _id_60CA(1);
  level._id_6754 thread _id_60B0("seat_elevator_ethan", "seat_ethan", "mount_elevator_ethan", "mount_ethan", 1, 1);
  level._id_30F6 thread _id_60B0("seat_elevator_brooks", "seat_brooks", "mount_elevator_brooks", "mount_brooks", 1, 1);
  scripts\engine\utility::flag_set("salter_intro_done");
  scripts\engine\utility::flag_set("mac_intro_done");
  var_0 = getEnt("space_elevator_door_closed", "targetname");
  var_1 = getEnt("space_elevator_door_closed_clip", "targetname");
  scripts\engine\utility::waitframe();
  level._id_EA2C thread scripts\sp\utility::_id_DC45("raise");
  level._id_B4F1 thread scripts\sp\utility::_id_DC45("raise");
  level._id_30F6 thread scripts\sp\utility::_id_DC45("raise");
  level thread _id_0E4B::_id_1348D(1);
  var_1 connectpaths();
  var_0 scripts\sp\utility::_id_8E9A();
  var_1 scripts\sp\utility::_id_8E9A();
  var_2 = getEntArray("fake_elevator_pod", "targetname");
  scripts\engine\utility::array_call(var_2, ::hide);
}

_id_B1CB() {
  scripts\sp\utility::_id_2669("yard_elevator_airlock");
  scripts\sp\maps\yard\yard_fx::_id_132CD(1);
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_combat", "main");
  scripts\sp\maps\yard\yard_util::_id_13E3B();
  scripts\sp\maps\yard\yard_util::_id_D2E0();
  scripts\sp\utility::_id_22CA("pod_hall_fl_enemies", ::_id_6080);
  scripts\sp\utility::_id_22C9("pod_storage_enemies", ::_id_60B7);
  level.player scripts\sp\utility::_id_F526("relaxed");
  thread _id_B124();
  thread _id_60B9();
  thread _id_104D2();
  var_0 = getEnt("airlock_end_trigger", "targetname");
  var_0 scripts\engine\utility::trigger_off();
  level._id_EA2C thread _id_6047();
  level._id_B4F1 thread _id_6046();
  level thread _id_60B8();
  level thread _id_6083();
  level thread _id_60BA();
  scripts\engine\utility::flag_wait("start_elev_hall_guys");

  while(!istransientloaded("yard_base_tr") || !istransientloaded("yard_vista_tr") || !istransientloaded("yard_vista_ring_tr")) {
    wait 0.05;
    waitforalltransients();
  }

  wait 0.75;
  level._id_B4F1 thread scripts\sp\utility::_id_10346("yard_mac_targetsabove");
  level.player scripts\sp\utility::_id_F526("normal");
  var_1 = scripts\sp\utility::_id_22CD("pod_hall_fl_enemies", 1);
  level._id_EA2C scripts\engine\utility::delaythread(1.5, scripts\sp\utility::_id_10346, "yard_slt_onyoureyes");
  level._id_EA2C thread _id_6081();
  scripts\engine\utility::flag_wait("fl_hall_go_loud");
  scripts\engine\utility::delaythread(1.5, scripts\sp\utility::_id_28D8, "axis");
  scripts\engine\utility::flag_wait("pod_hall_enemies_dead");
  thread scripts\sp\utility::_id_2679();

  if(!scripts\engine\utility::flag("start_pod_chamber_enemies"))
    scripts\engine\utility::flag_clear("stealth_spotted");

  scripts\sp\utility::_id_28D7("axis");
  wait 1.25;

  if(!scripts\engine\utility::flag("start_pod_chamber_pods"))
    scripts\sp\utility::_id_15F5("fl_hall_move_up2");

  scripts\engine\utility::flag_wait("pod_storage_enemies_dead");
  thread scripts\sp\maps\yard\yard_util::_id_10180();
  scripts\sp\maps\yard\yard_util::_id_D2DF();
  var_0 scripts\engine\utility::trigger_on();
  scripts\sp\utility::_id_15F5("move_outside_airlock_exit");
  scripts\engine\utility::flag_wait("elevator_airlock_end");
}

_id_3B5B() {
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_combat", "catchup");
  scripts\engine\utility::flag_set("start_pod_chamber_pods");
  level thread _id_406F();
}

_id_6047() {
  scripts\engine\utility::flag_wait("salter_intro_done");
  var_0 = getEnt("elevator_animnode", "targetname");
  scripts\sp\utility::_id_F3B5("b");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "airlock_idle", "stop_idle");
  var_0 thread _id_602A();
  scripts\engine\utility::flag_wait("elevator_airlock_trigger");

  if(scripts\engine\utility::flag("salter_airlock_nag")) {
    scripts\engine\utility::flag_wait("salter_airlock_nag_done");
    wait 0.1;
  }

  level notify("in_airlock");
  var_0 notify("stop_idle");
  scripts\sp\utility::_id_61E7();
  var_0 scripts\sp\anim::_id_1F35(self, "airlock_door_close");
  scripts\sp\utility::_id_61C7();
  scripts\sp\maps\yard\yard_util::_id_8E36();
  scripts\engine\utility::flag_wait("pod_hall_enemies_dead");
  _id_0F18::_id_10E8B("hidden");
  scripts\sp\utility::_id_61E7();
  scripts\engine\utility::flag_wait("pod_storage_enemies_dead");
  scripts\sp\utility::_id_61E7();
}

_id_6046() {
  scripts\engine\utility::flag_wait("mac_intro_done");
  scripts\sp\utility::_id_61E7();
  self _meth_82EE(getnode("exit_elevator_mccallum", "targetname"));
  scripts\sp\utility::_id_F3B5("o");
  scripts\sp\utility::_id_61C7();
  scripts\sp\maps\yard\yard_util::_id_8E36();
  scripts\engine\utility::flag_wait("pod_hall_enemies_dead");
  _id_0F18::_id_10E8B("hidden");
  scripts\sp\utility::_id_61E7();
  scripts\engine\utility::flag_wait("pod_storage_enemies_dead");
  scripts\sp\utility::_id_61E7();
}

_id_602A() {
  level endon("in_airlock");
  wait 10.0;
  scripts\engine\utility::flag_set("salter_airlock_nag");
  self notify("stop_idle");
  scripts\sp\anim::_id_1F35(level._id_EA2C, "airlock_nag");
  thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "airlock_idle", "stop_idle");
  scripts\engine\utility::flag_set("salter_airlock_nag_done");
}

_id_6081() {
  level endon("pod_hall_enemies_dead");
  scripts\engine\utility::flag_wait("fl_hall_go_loud");
  wait 0.5;

  if(!level.player _meth_819F())
    level._id_EA2C scripts\sp\utility::_id_10346("yard_slt_ivegotem");
}

_id_6083() {
  level endon("start_pod_chamber_enemies");
  scripts\engine\utility::flag_wait("pod_hall_enemies_dead");
  wait 0.75;
  scripts\sp\utility::_id_1034D("yard_plr_weneedtokeepthe");
  scripts\sp\utility::_id_1034D("yard_plr_letsmove");
}

_id_60BA() {
  level endon("end_pod_chamber");
  scripts\engine\utility::flag_wait("close_space_elevator");
  wait 2.5;

  if(scripts\engine\utility::flag("pod_hall_enemies_dead") && !scripts\engine\utility::flag("stealth_spotted"))
    level._id_EA2C scripts\sp\utility::_id_10346("yard_slt_thenoiseshouldc");

  scripts\engine\utility::flag_wait("stealth_spotted");
  wait 0.5;

  if(scripts\engine\utility::flag("pod_hall_enemies_dead") && isalive(level._id_B4F1))
    level._id_B4F1 scripts\sp\utility::_id_10346("yard_mac_theyvespottedus");

  scripts\engine\utility::flag_wait_all("pod_storage_enemies_dead", "pod_hall_enemies_dead");
  wait 1.5;
  level._id_EA2C scripts\sp\utility::_id_10346("yard_slt_targetsdown");
}

_id_6080() {
  self endon("death");
  scripts\sp\utility::_id_61E7();
  self.goalradius = 16;
  self.fixednode = 1;
  self.allowdeath = 1;
  thread _id_607E();
  thread _id_607C();
  thread _id_607F();

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fl_guy") {
    self._id_1FBB = "generic";
    thread scripts\sp\maps\yard\yard_anim::_id_E9A9(self);
    thread _id_6082();
  }

  scripts\engine\utility::flag_wait("fl_hall_go_loud");
  self.fixednode = 0;
  scripts\sp\utility::_id_5514();
  var_0 = getEnt("fl_hall_enemy_vol", "targetname");
  self _meth_82F1(var_0);
}

_id_607E() {
  self endon("death");
  self waittill("damage", var_0, var_1);

  if(var_1 == level.player) {
    scripts\engine\utility::flag_set("fl_hall_go_loud");

    if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fl_guy") {
      self notify("end_anim");
      thread scripts\sp\maps\yard\yard_anim::_id_E9A8(self);
      scripts\sp\utility::anim_stopanimScripted();
    }
  }
}

_id_607F() {
  self waittill("death");
  scripts\engine\utility::flag_set("fl_hall_go_loud");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fl_guy") {
    self notify("end_anim");
    thread scripts\sp\maps\yard\yard_anim::_id_E9A8(self);
  }
}

_id_607C() {
  self endon("death");
  scripts\engine\utility::flag_wait("stealth_spotted");
  scripts\engine\utility::flag_set("fl_hall_go_loud");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fl_guy") {
    self notify("end_anim");
    thread scripts\sp\maps\yard\yard_anim::_id_E9A8(self);
    scripts\sp\utility::anim_stopanimScripted();
  }
}

_id_6082() {
  self endon("death");
  self endon("end_anim");
  var_0 = scripts\engine\utility::getStruct("fl_nav_01", "targetname");
  self setgoalpos(var_0.origin);
  self waittill("goal");
  thread scripts\sp\anim::_id_1F35(self, var_0.animation);
  wait 5.15;
  thread scripts\sp\maps\yard\yard_anim::_id_E9A8(self);
  scripts\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::flag_set("fl_hall_go_loud");
  _id_0F18::_id_10E8A("broadcast", "attack", level._id_EA2C getEye(), 800);
}

_id_60B8() {
  scripts\engine\utility::flag_wait("start_pod_chamber_enemies");
  level._id_D626 = scripts\sp\utility::_id_22CD("pod_storage_enemies", 1);
  var_0 = getEnt("pod_storage_room_center", "targetname");
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_13754(level._id_D626, 5);

  foreach(var_2 in level._id_D626) {
    if(isalive(var_2))
      var_2 _meth_82F1(var_0);
  }
}

_id_60B7() {
  self endon("death");
  self._id_1FBB = "generic";
  self.allowdeath = 1;
  thread _id_D60E();

  if(isDefined(self.script_animation) && (self.script_animation == "pod_chamber_sdf01" || self.script_animation == "pod_chamber_sdf02" || self.script_animation == "pod_chamber_sdf03")) {
    self._id_10E6D._id_C813 = 80;
    self._id_10E6D._id_C810 = 80;
    self._id_10E6D._id_C80F = 80;
  }

  if(isDefined(self._id_EE52)) {
    var_0 = scripts\engine\utility::getStruct(self._id_EE52, "targetname");
    var_0 scripts\sp\anim::_id_1F17(self, self.script_animation);
    var_0 thread scripts\sp\anim::_id_1EEA(self, self.script_animation, "stop_idle");
    scripts\engine\utility::flag_wait("stealth_spotted");
    var_0 notify("stop_idle");
  } else {
    var_0 = scripts\engine\utility::getStruct("pod_chamber_animnode", "targetname");

    if(isDefined(self.script_index))
      var_0 scripts\sp\anim::_id_1F35(self, self.script_animation + "_start");

    var_0 thread scripts\sp\anim::_id_1EEA(self, self.script_animation + "_loop", "stop_idle");

    if(isDefined(self.script_animation) && self.script_animation == "pod_chamber_sdf02")
      scripts\sp\maps\yard\yard_fx::_id_13364();

    scripts\engine\utility::flag_wait("stealth_spotted");
    var_0 notify("stop_idle");
    var_0 scripts\sp\anim::_id_1F35(self, self.script_animation + "_react");
  }

  self.goalradius = 96;
}

_id_D60E() {
  self waittill("damage");

  if(isDefined(self._id_939E) && self._id_939E == 1)
    return;
  else
    _id_0F18::_id_10E8A("broadcast", "attack", level.player getEye(), 800);
}

_id_D60F() {
  var_0 = getEntArray("phys_barrel_destructible", "targetname");
  var_1 = getEnt("pod_storage_room_center", "targetname");
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4) && var_4 istouching(var_1))
      var_2 = scripts\engine\utility::add_to_array(var_2, var_4);
  }

  scripts\engine\utility::array_thread(var_2, ::_id_D605);
}

_id_D605() {
  self endon("death");
  self waittill("damage", var_0, var_1, var_2, var_3, var_4);
  var_5 = scripts\engine\utility::getclosest(self.origin, level._id_D626);
  var_5 _id_0F18::_id_10E8A("broadcast", "attack", level.player getEye(), 800);
}

_id_104D2() {
  scripts\engine\utility::flag_wait("close_space_elevator");
  var_0 = getEnt("space_elevator_door_closed", "targetname");
  var_1 = getEnt("space_elevator_door_closed_clip", "targetname");
  scripts\engine\utility::waitframe();
  var_1 disconnectPaths();
  var_0 scripts\sp\utility::_id_100FC();
  var_1 scripts\sp\utility::_id_100FC();
  var_2 = getEnt("space_elevator_door_open", "targetname");
  var_3 = getEnt("space_elevator_door_open_clip", "targetname");
  var_3 connectpaths();
  scripts\engine\utility::waitframe();
  var_2 delete();
  var_3 delete();

  if(isDefined(level._id_6754))
    level._id_6754 delete();

  if(isDefined(level._id_30F6))
    level._id_30F6 delete();

  var_4 = getEntArray("elevator_seats_mounts", "script_noteworthy");

  foreach(var_6 in var_4) {
    if(isDefined(var_6))
      var_6 delete();
  }
}

_id_60B9() {
  var_0 = _id_31B1(getEntArray("cargo_pod_caddy_01", "targetname"));
  var_1 = _id_31B1(getEntArray("cargo_pod_caddy_02", "targetname"));
  var_2 = scripts\engine\utility::getStruct("pod_chamber_pos_05", "targetname");
  var_3 = scripts\engine\utility::getStruct("pod_chamber_pos_02", "targetname");
  var_0.origin = var_2.origin;
  var_1.origin = var_3.origin;
  level._id_D606 = var_0._id_215D;
  level._id_D607 = var_1._id_215D;
  var_4 = scripts\engine\utility::getStruct("pod_chamber_arm_01_top", "targetname");
  var_5 = scripts\engine\utility::getStruct("pod_chamber_arm_02_bottom", "targetname");
  level._id_D606.origin = var_4.origin;
  level._id_D607.origin = var_5.origin;
  var_6 = getEnt("pod_chamber_garage_door_2", "targetname");
  var_6 movez(144, 2.5, 1, 1);
  scripts\engine\utility::flag_wait("start_pod_chamber_pods");
  var_1 thread _id_BC58("pod_chamber_pos_03");
  wait 12.5;
  var_0 thread _id_BC58("pod_chamber_pos_06");
}

_id_31B1(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = [];
  var_4 = undefined;

  foreach(var_6 in var_0) {
    if(!isDefined(var_6.script_type)) {
      continue;
    }
    if(var_6.script_type == "link")
      var_3[var_3.size] = var_6;
    else if(var_6.script_type == "platform")
      var_1 = var_6;
    else if(var_6.script_type == "arm")
      var_2 = var_6;

    if(issubstr(var_6.model, "drop_pod") == 1)
      var_4 = var_6;
  }

  foreach(var_9 in var_3)
  var_9 linkTo(var_1);

  var_1._id_215D = var_2;
  var_1._id_D615 = var_4;
  return var_1;
}

_id_BC58(var_0) {
  level endon("end_pod_chamber");
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = getEnt("pod_chamber_garage_door_1", "targetname");
  var_3 = getEnt("pod_chamber_garage_door_2", "targetname");
  var_4 = scripts\engine\utility::getStruct("pod_chamber_arm_01_top", "targetname");
  var_5 = scripts\engine\utility::getStruct("pod_chamber_arm_01_bottom", "targetname");
  var_6 = scripts\engine\utility::getStruct("pod_chamber_arm_02_top", "targetname");
  var_7 = scripts\engine\utility::getStruct("pod_chamber_arm_02_bottom", "targetname");

  for(;;) {
    if(!isDefined(var_1.script_delay))
      var_1.script_delay = 10;

    if(isDefined(var_1.script_parameters)) {
      switch (var_1.script_parameters) {
        case "arm01_up":
          level._id_D606 moveTo(var_4.origin, 3.5, 1, 1);
          break;
        case "arm01_down":
          level._id_D606 moveTo(var_5.origin, var_1.script_delay, var_1.script_delay * 0.25, var_1.script_delay * 0.25);
          break;
        case "arm02_up":
          level._id_D607 moveTo(var_6.origin, var_1.script_delay, var_1.script_delay * 0.25, var_1.script_delay * 0.25);
          break;
        case "arm02_down":
          level._id_D607 moveTo(var_7.origin, 3.5, 1, 1);
          break;
        default:
          break;
      }
    }

    self moveTo(var_1.origin, var_1.script_delay, var_1.script_delay * 0.25, var_1.script_delay * 0.25);
    thread scripts\sp\maps\yard\yard_audio::_id_25DA(var_1.script_delay, var_1.script_delay * 0.25);
    wait(var_1.script_delay);

    if(isDefined(var_1.script_noteworthy)) {
      switch (var_1.script_noteworthy) {
        case "open_door1":
          var_2 movez(144, 2.5, 1, 1);
          break;
        case "close_door1":
          var_2 movez(-144, 2.5, 1, 1);
          break;
        case "open_door2":
          var_3 movez(144, 2.5, 1, 1);
          break;
        case "close_door2":
          var_3 movez(-144, 2.5, 1, 1);
          break;
        default:
          break;
      }
    }

    if(isDefined(var_1.target))
      var_1 = scripts\engine\utility::getStruct(var_1.target, "targetname");
    else
      var_1 = scripts\engine\utility::getStruct("pod_chamber_pos_01", "targetname");

    wait 5;
  }
}

_id_40A9() {
  level notify("end_pod_chamber");
  scripts\engine\utility::waitframe();
  var_0 = getEntArray("cargo_pod_caddy_01", "targetname");
  var_1 = getEntArray("cargo_pod_caddy_02", "targetname");
  scripts\sp\utility::_id_228A(var_0);
  scripts\sp\utility::_id_228A(var_1);
  level notify("pod_chamber_ammo_cleanup");
}

_id_10C33() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_mac_death", "start");
  scripts\sp\maps\yard\yard_util::_id_107BE("continue_salter_mac_death");
  level._id_EA2C scripts\sp\utility::_id_F3B5("b");
  level._id_EA2C scripts\sp\utility::_id_61C7();
  level._id_EA2C scripts\sp\utility::_id_61E7();
  level._id_EA2C scripts\sp\utility::_id_51E1("cqb");
  level._id_EA2C scripts\sp\maps\yard\yard_util::_id_8E36();
  scripts\sp\maps\yard\yard_util::_id_10766("continue_mccallum_mac_death");
  level._id_B4F1 scripts\sp\utility::_id_F3B5("o");
  level._id_B4F1 scripts\sp\utility::_id_61C7();
  level._id_B4F1 scripts\sp\utility::_id_61E7();
  level._id_B4F1 scripts\sp\maps\yard\yard_util::_id_8E36();
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_player_mac_death", "targetname"));
  level._id_EA2C thread scripts\sp\utility::_id_DC45("raise");
  level._id_B4F1 thread scripts\sp\utility::_id_DC45("raise");
  level thread _id_0E4B::_id_1348D(1);
  thread _id_60B9();
  thread _id_B124();
  var_0 = getEnt("space_elevator_door_open", "targetname");
  var_1 = getEnt("space_elevator_door_open_clip", "targetname");
  var_1 connectpaths();
  scripts\engine\utility::waitframe();
  var_0 delete();
  var_1 delete();
  var_2 = getEntArray("fake_elevator_pod", "targetname");
  scripts\engine\utility::array_call(var_2, ::hide);
}

_id_B1D2() {
  scripts\sp\utility::_id_2669("yard_elevator_mac_death");
  scripts\sp\maps\yard\yard_fx::_id_132CD(1);
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_mac_death", "main");
  var_0 = getEnt("ambush_airlock_exit_blocker", "targetname");
  var_0 scripts\sp\utility::_id_8E9A();
  thread scripts\sp\maps\yard\yard_lighting::_id_B130();
  thread _id_132A7();
  scripts\sp\player_rig::_id_96EA("viewmodel_base_viewhands_iw7");
  thread _id_B132();
  thread _id_B133();
  thread _id_B125();
  scripts\engine\utility::waitframe();

  if(isDefined(level._id_10E6D)) {
    thread scripts\sp\maps\yard\yard_util::_id_10180();
    scripts\sp\maps\yard\yard_util::_id_D2DF();
  }

  scripts\engine\utility::flag_wait("elevator_mac_death_end");
}

_id_3B62() {
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_mac_death", "catchup");
  level thread _id_406D();

  if(isDefined(level._id_EA2C))
    level._id_EA2C thread scripts\sp\utility::_id_DC45("raise");

  level thread _id_0E4B::_id_1348D(1);
}

_id_B124() {
  thread _id_B123();
  var_0 = getEnt("drop_chamber_door_inner_left", "targetname");
  var_0.clip = getEnt("drop_chamber_door_inner_left_clip", "targetname");
  var_0._id_5288 = scripts\engine\utility::getStruct("drop_chamber_door_inner_left_dest", "targetname");
  var_1 = getEnt("drop_chamber_door_inner_right", "targetname");
  var_1.clip = getEnt("drop_chamber_door_inner_right_clip", "targetname");
  var_1._id_5288 = scripts\engine\utility::getStruct("drop_chamber_door_inner_right_dest", "targetname");
  var_2 = getEnt("drop_chamber_door_outer_left", "targetname");
  var_2.clip = getEnt("drop_chamber_door_outer_left_clip", "targetname");
  var_2._id_5288 = scripts\engine\utility::getStruct("drop_chamber_door_outer_left_dest", "targetname");
  var_3 = getEnt("drop_chamber_door_outer_right", "targetname");
  var_3.clip = getEnt("drop_chamber_door_outer_right_clip", "targetname");
  var_3._id_5288 = scripts\engine\utility::getStruct("drop_chamber_door_outer_right_dest", "targetname");
  thread _id_1AB8(1, var_0, var_1, var_2, var_3);
  scripts\engine\utility::flag_wait("elevator_airlock_end");
  level thread _id_B11E();
  var_4 = scripts\engine\utility::getStruct("mac_death_airlock_interact", "targetname");
  var_4 _id_0E46::_id_48C4(undefined, undefined, &"YARD_HINT_CYCLE", undefined, 256);
  var_4 waittill("trigger");
  level notify("airlock_kiosk_used");
  var_5 = getEnt("airlock_to_mac_death_player_blocker", "targetname");

  if(isDefined(var_5))
    var_5 scripts\sp\utility::_id_8E9A();

  level waittill("cycle_airlock_special");
  _id_1AAC("pod_chamber_entry_airlock", 1, var_0, var_1, var_2, var_3, 1);
  scripts\sp\utility::_id_1264E("yard_elevator_tr");
  scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_12641, "yard_base_capitalship_tr");
}

_id_B123() {
  scripts\sp\player_rig::get_player_score();
  level._id_D267 hide();
  level waittill("airlock_kiosk_used");
  var_0 = scripts\engine\utility::getStruct("airlock_console_animnode2", "targetname");
  var_0 scripts\sp\anim::_id_1EC3(level._id_D267, "airlock_console_interact");
  scripts\engine\utility::waitframe();
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_sprint(0);
  level.player scripts\engine\utility::allow_melee(0);
  level.player scripts\sp\utility::_id_2B76(0.44, 0.5);
  level.player _meth_823C(level._id_D267, "tag_player", 0.35);
  _id_0B2A::_id_11429();
  wait 0.35;
  level._id_D267 show();
  level.player playerlinktodelta(level._id_D267, "tag_player", 1, 20, 20, 10, 10, 1);
  clearallcorpses();
  var_0 thread scripts\sp\anim::_id_1F35(level._id_D267, "airlock_console_interact");
  scripts\engine\utility::delaythread(0.2, scripts\sp\utility::_id_1034D, "yard_plr_keepyoureyesope");
  wait 2.33333;
  level notify("cycle_airlock_special");
  level._id_D267 waittillmatch("single anim", "end");
  level.player unlink();
  level._id_D267 delete();
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_doublejump(1);
  scripts\engine\utility::delaythread(2.0, _id_0E4B::_id_13485);
  scripts\engine\utility::delaythread(2.0, _id_0B0B::_id_25C2);
  level thread _id_406D();
}

_id_B11E() {
  level endon("airlock_kiosk_used");
  wait 10;
  level._id_B4F1 scripts\sp\utility::_id_10346("yard_mac_letskeepmoving");
  wait 15;
  level._id_EA2C scripts\sp\utility::_id_10346("yard_slt_onyoureyes");
}

_id_1AB8(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [var_1, var_2, var_3, var_4];

  foreach(var_7 in var_5) {
    if(isDefined(var_7) && !isDefined(var_7._id_ACD5)) {
      var_7._id_ACD5 = [];
      var_8 = var_7 scripts\engine\utility::spawn_tag_origin();
      var_8.angles = var_8.angles + (0, 90, 0);
      var_9 = anglesToForward(var_7.angles);
      var_10 = anglestoright(var_7.angles);
      var_11 = (var_10[0] * 5, var_9[1] * -1.2, 54);
      var_8.origin = var_7.origin + var_11;
      var_8 linkTo(var_7);
      var_7._id_ACD5[var_7._id_ACD5.size] = var_8;
    }

    if(isDefined(var_7) && isDefined(var_7.clip))
      var_7.clip linkTo(var_7);
  }

  var_13 = "back";

  if(var_0)
    var_13 = "front";

  if(var_13 == "front") {
    if(isDefined(var_1)) {
      var_1 _id_0B1F::_id_1AB6("unlocked");

      if(!isDefined(var_1._id_C71D))
        var_1._id_C71D = var_1 scripts\engine\utility::spawn_tag_origin();

      var_1 moveTo(var_1._id_5288.origin, 0.05);
      var_1.clip connectpaths();
    }

    if(isDefined(var_2)) {
      var_2 _id_0B1F::_id_1AB6("unlocked");

      if(!isDefined(var_2._id_C71D))
        var_2._id_C71D = var_2 scripts\engine\utility::spawn_tag_origin();

      var_2 moveTo(var_2._id_5288.origin, 0.05);
      var_2.clip connectpaths();
    }

    if(isDefined(var_3))
      var_3 _id_0B1F::_id_1AB6("locked");

    if(isDefined(var_4))
      var_4 _id_0B1F::_id_1AB6("locked");
  } else {
    if(isDefined(var_1))
      var_1 _id_0B1F::_id_1AB6("locked");

    if(isDefined(var_2))
      var_2 _id_0B1F::_id_1AB6("locked");

    if(isDefined(var_3)) {
      var_3 _id_0B1F::_id_1AB6("unlocked");

      if(!isDefined(var_3._id_C71D))
        var_3._id_C71D = var_3 scripts\engine\utility::spawn_tag_origin();

      var_3 moveTo(var_3._id_5288.origin, 0.05);
      var_3.clip connectpaths();
    }

    if(isDefined(var_4)) {
      var_4 _id_0B1F::_id_1AB6("unlocked");

      if(!isDefined(var_4._id_C71D))
        var_4._id_C71D = var_4 scripts\engine\utility::spawn_tag_origin();

      var_4 moveTo(var_4._id_5288.origin, 0.05);
      var_4.clip connectpaths();
    }
  }
}

_id_1AAC(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = "generic_door_open";
  var_8 = "generic_door_close";
  var_9 = 0.666;
  var_10 = 0.05;
  var_11 = 0.45;
  var_12 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_12 scripts\sp\utility::_id_65DD("cycling_complete");
  var_12 scripts\sp\utility::_id_65E1("cycling");
  var_13 = [var_2, var_3, var_4, var_5];

  foreach(var_15 in var_13) {
    if(isDefined(var_15) && !isDefined(var_15._id_ACD5)) {
      var_15._id_ACD5 = [];
      var_16 = var_15 scripts\engine\utility::spawn_tag_origin();
      var_16.angles = var_16.angles + (0, 90, 0);
      var_17 = anglesToForward(var_15.angles);
      var_18 = anglestoright(var_15.angles);
      var_19 = (var_18[0] * 5, var_17[1] * -1.2, 54);
      var_16.origin = var_15.origin + var_19;
      var_16 linkTo(var_15);
      var_15._id_ACD5[var_15._id_ACD5.size] = var_16;
    }
  }

  var_21 = "back";

  if(var_1)
    var_21 = "front";

  if(var_21 == "front") {
    if(isDefined(var_2)) {
      var_2 thread scripts\sp\utility::play_sound_on_entity(var_8);
      var_2 moveTo(var_2._id_C71D.origin, var_9, var_10, var_11);
      var_2.clip scripts\engine\utility::delaycall(1.5, ::disconnectpaths);
    }

    if(isDefined(var_3)) {
      var_3 thread scripts\sp\utility::play_sound_on_entity(var_8);
      var_3 moveTo(var_3._id_C71D.origin, var_9, var_10, var_11);
      var_3.clip scripts\engine\utility::delaycall(1.5, ::disconnectpaths);
    }
  } else {
    if(isDefined(var_4)) {
      var_4 thread scripts\sp\utility::play_sound_on_entity(var_8);
      var_4 moveTo(var_4._id_C71D.origin, var_9, var_10, var_11);
      var_4.clip scripts\engine\utility::delaycall(1.5, ::disconnectpaths);
    }

    if(isDefined(var_5)) {
      var_5 thread scripts\sp\utility::play_sound_on_entity(var_8);
      var_5 moveTo(var_5._id_C71D.origin, var_9, var_10, var_11);
      var_5.clip scripts\engine\utility::delaycall(1.5, ::disconnectpaths);
    }
  }

  var_22 = "airlock_pressurize_lr";

  if(!isDefined(var_6) || var_6)
    setglobalsoundcontext("atmosphere", "", 2);
  else {
    var_22 = "airlock_depressurize_lr";
    setglobalsoundcontext("atmosphere", "space", 2);
  }

  var_23 = lookupsoundlength(var_22);
  var_12._id_4CD5 = 1;
  var_12 thread _id_0B1F::_id_1AD7(var_23);
  scripts\engine\utility::array_thread(var_13, _id_0B1F::_id_1AB1, var_12, "cycling");

  if(!isDefined(var_6))
    var_6 = 1;

  var_12 thread _id_0B1F::_id_1AAD(var_6);
  level.player scripts\sp\utility::play_sound_on_entity(var_22);
  var_12._id_4CD5 = 0;
  var_21 = "back";

  if(var_1)
    var_21 = "front";

  var_24 = ["front", "back"];

  foreach(var_26 in var_24) {
    if(var_26 == var_21) {
      foreach(var_28 in var_12._id_ECCE[var_26])
      var_28 setscriptablepartstate("root", 12);

      continue;
    }

    foreach(var_28 in var_12._id_ECCE[var_26])
    var_28 setscriptablepartstate("root", 0);
  }

  if(var_21 == "front") {
    if(isDefined(var_2))
      var_2 _id_0B1F::_id_1AB6("locked");

    if(isDefined(var_3))
      var_3 _id_0B1F::_id_1AB6("locked");

    if(isDefined(var_4)) {
      var_4 _id_0B1F::_id_1AB6("unlocked");
      var_4 thread scripts\sp\utility::play_sound_on_entity(var_7);
      var_4 moveTo(var_4._id_5288.origin, var_9, var_10, var_11);
      var_4.clip scripts\engine\utility::delaycall(1.5, ::connectpaths);
    }

    if(isDefined(var_5)) {
      var_5 _id_0B1F::_id_1AB6("unlocked");
      var_5 thread scripts\sp\utility::play_sound_on_entity(var_7);
      var_5 moveTo(var_5._id_5288.origin, var_9, var_10, var_11);
      var_5.clip scripts\engine\utility::delaycall(1.5, ::connectpaths);
    }
  } else {
    if(isDefined(var_2)) {
      var_2 _id_0B1F::_id_1AB6("unlocked");
      var_2 thread scripts\sp\utility::play_sound_on_entity(var_7);
      var_2 moveTo(var_2._id_5288.origin, var_9, var_10, var_11);
      var_2.clip scripts\engine\utility::delaycall(1.5, ::connectpaths);
    }

    if(isDefined(var_3)) {
      var_3 _id_0B1F::_id_1AB6("unlocked");
      var_3 thread scripts\sp\utility::play_sound_on_entity(var_7);
      var_3 moveTo(var_3._id_5288.origin, var_9, var_10, var_11);
      var_3.clip scripts\engine\utility::delaycall(1.5, ::connectpaths);
    }

    if(isDefined(var_4))
      var_4 _id_0B1F::_id_1AB6("locked");

    if(isDefined(var_5))
      var_5 _id_0B1F::_id_1AB6("locked");
  }

  var_12 scripts\sp\utility::_id_65E1("cycling_complete");
  var_12 scripts\sp\utility::_id_65DD("cycling");
  level notify("airlock_special_cycle_done");
  _id_0F35::_id_FB24(1, level.player);
  _id_0F35::_id_FB25(0, 0);
  _id_0A2F::_id_13E80(1, 1);
  setsaveddvar("player_zeroGravDisableWalk", 0);
  level.player allowmantle(0);
  level.player allowwallrun(0);
  level.player scripts\engine\utility::allow_melee(1);
}

_id_B132() {
  level._id_B4F1 thread _id_9A94("mac_pre_mac_airlock_node", 1, "mac_in_mac_death_airlock");
  level._id_EA2C thread _id_9A94("salter_pre_mac_airlock_node", undefined, "salter_in_mac_death_airlock");
  setmusicstate("mx_274_yard_mac_dies");
  level waittill("airlock_special_cycle_done");
  wait 1.5;
  level notify("mac_death_go");
}

_id_9A94(var_0, var_1, var_2) {
  scripts\sp\utility::_id_54F7();
  var_3 = getnode(var_0, "targetname");
  self _meth_82EE(var_3);
  level waittill("airlock_kiosk_used");
  wait 0.35;
  scripts\sp\utility::_id_1160F(var_3);
  scripts\engine\utility::flag_set(var_2);

  if(isDefined(var_1))
    scripts\sp\utility::_id_5514();

  thread scripts\sp\utility::_id_DC45("lower");
}

_id_B133() {
  level waittill("mac_death_go");
  thread scripts\sp\maps\yard\yard_audio::_id_25D7();
  thread scripts\sp\utility::_id_12641("yard_tram_tr");
  thread scripts\sp\utility::_id_12641("yard_airlock_tr");
  level._id_B11F = scripts\engine\utility::getStruct("mac_death_ap", "targetname");
  level._id_B11F._id_CF7D = 0;
  level._id_B11F.abort = 0;
  level._id_D267 = scripts\sp\utility::_id_10639("player_rig");
  level._id_D267 dontcastshadows();
  level._id_D267 hide();
  level._id_B11F thread scripts\sp\anim::_id_1EC3(level._id_D267, "mac_death_scene_c");
  level._id_D61B = scripts\sp\utility::_id_10639("mac_charge");
  level._id_D61B scripts\sp\utility::_id_8E9A();
  level._id_B11F thread scripts\sp\anim::_id_1EC3(level._id_D61B, "mac_death_scene_c");
  level._id_B12A = scripts\sp\utility::_id_10639("mac_knife");
  level._id_B12A scripts\sp\utility::_id_8E9A();
  level._id_B11F thread scripts\sp\anim::_id_1EC3(level._id_B12A, "mac_death_scene_c");
  level._id_D616 = scripts\sp\utility::_id_10639("pod_arm");
  level._id_D616 scripts\sp\utility::_id_8E9A();
  level._id_B11F thread scripts\sp\anim::_id_1EC3(level._id_D616, "mac_death_scene_c");
  level._id_B126 = scripts\sp\utility::_id_10639("mac_kiosk");
  level._id_B11F thread scripts\sp\anim::_id_1EC3(level._id_B126, "mac_death_scene_e");
  var_0 = getEnt("pod_of_death_c6", "targetname");
  var_0 scripts\sp\utility::_id_1747(::_id_B121);
  var_1 = getEntArray("pod_of_death_c6_extras", "targetname");
  scripts\sp\utility::_id_22C7(var_1, ::_id_B121);
  level._id_D617 = getEnt("pod_of_death_base", "targetname");
  level._id_D617._id_1FBB = "pod_base";
  level._id_D617 scripts\sp\utility::_id_23B7();
  var_2 = getEnt("drop_pod_launch", "targetname");
  var_2 hide();
  scripts\engine\utility::waitframe();
  level._id_B126 thread _id_A6DE();
  level._id_B128 = spawn("script_model", level._id_B12A.origin);
  level._id_B128 setModel("tactical_knife_iw7_vm");
  level._id_B128 scripts\sp\utility::_id_8E9A();
  level._id_B128.origin = level._id_B12A gettagorigin("j_prop_1");
  level._id_B128.angles = level._id_B12A gettagangles("j_prop_1");
  level._id_B128 linkTo(level._id_B12A, "j_prop_1");
  level._id_5D06 = scripts\engine\utility::getStruct("drop_chamber_start_loc", "targetname");
  level._id_D617.origin = level._id_5D06.origin;
  level._id_D617.angles = level._id_5D06.angles;
  level._id_EA2C scripts\sp\utility::_id_5514();
  var_3 = scripts\engine\utility::getStruct("mac_death_land_ap", "targetname");
  var_4 = var_3 scripts\engine\utility::spawn_tag_origin();
  var_4.angles = (0, 0, 0);
  var_5 = [level._id_EA2C, level._id_B4F1];
  scripts\engine\utility::delaythread(5.0, ::_id_B136);
  scripts\engine\utility::delaythread(5.0, ::_id_B134);
  var_4 scripts\sp\anim::_id_1F2C(var_5, "md_airlock_to_catwalk");

  if(!scripts\engine\utility::flag("md_catwalk_idle")) {
    var_4 scripts\sp\anim::_id_1F2C(var_5, "md_catwalk_enter_to_idle");
    var_4 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "md_catwalk_idle", "stop_catwalk_idle");
    var_4 thread scripts\sp\anim::_id_1EEA(level._id_B4F1, "md_catwalk_idle", "stop_catwalk_idle");
    wait 0.5;
    scripts\engine\utility::flag_wait("md_catwalk_continue");
    var_4 notify("stop_catwalk_idle");
    var_4 scripts\sp\anim::_id_1F2C(var_5, "md_catwalk_idle_to_exit");
  } else
    level._id_B11F scripts\sp\anim::_id_1F2C(var_5, "md_catwalk");

  scripts\engine\utility::flag_set("catwalk_to_console_start");
  level thread _id_EAF5();
  level._id_B11F scripts\sp\anim::_id_1F35(level._id_B4F1, "md_catwalk_to_console");
  var_4 delete();
  level._id_B11F thread scripts\sp\anim::_id_1EEA(level._id_B4F1, "mac_death_scene_b", "stop_b_loop");
  wait 1;
  thread _id_B12F();
  level.player waittill("ready_for_scene_c");
  thread _id_B122();
  scripts\engine\utility::flag_set("mac_death_scene_c_start");
  level._id_B11F notify("stop_b_loop");
  level._id_D618 = scripts\sp\utility::_id_107EA("pod_of_death_c6", 1);
  level._id_D619 = scripts\sp\utility::_id_22CD("pod_of_death_c6_extras", 1);
  level._id_D616 show();
  var_5 = [level._id_EA2C, level._id_B4F1, level._id_D267, level._id_D617, level._id_D61B, level._id_D618, level._id_B12A];
  level._id_D61B show();
  level._id_EA2C thread scripts\sp\maps\yard\yard_fx::_id_1333A();
  level._id_D617 thread scripts\sp\maps\yard\yard_fx::_id_13339();
  level._id_D61B thread scripts\sp\maps\yard\yard_fx::_id_13337();
  level._id_B12A thread scripts\sp\maps\yard\yard_fx::_id_13338();
  level._id_B11F thread scripts\sp\anim::_id_1EE7(level._id_D619, "mac_death_scene_c");
  level._id_B11F scripts\sp\anim::_id_1F2C(var_5, "mac_death_scene_c");
  scripts\engine\utility::flag_set("mac_death_scene_d_start");
  level._id_B11F thread scripts\sp\anim::_id_1F2C(var_5, "mac_death_scene_d");
  thread _id_B12E();
  scripts\engine\utility::flag_wait("mac_death_tappy_done");
  scripts\engine\utility::flag_set("mac_death_scene_e_start");
  var_5 = scripts\engine\utility::add_to_array(var_5, level._id_B126);
  level._id_B11F thread scripts\sp\anim::_id_1F2C(var_5, "mac_death_scene_e");
  scripts\engine\utility::delaythread(2.85, scripts\sp\utility::_id_228A, level._id_D619);
  level._id_D616 scripts\engine\utility::delaycall(2.85, ::delete);
  level._id_B4F1 thread _id_B12B();
  level.player thread _id_B12C();
  level._id_D61B hide();
  level._id_D617 thread _id_B12D();
  level._id_D618 thread _id_B12D();
  level._id_B12A thread _id_B129();
  scripts\engine\utility::delaythread(7.0, scripts\engine\utility::flag_set, "mac_death_scene_end");
  level._id_D61B scripts\engine\utility::delaycall(32.1, ::delete);
  level._id_EA2C waittillmatch("single anim", "end");
  level._id_EA2C notify("vfx_mac_death_ended");
  scripts\engine\utility::flag_set("salter_goto_airlock");
  scripts\engine\utility::flag_wait("elevator_mac_death_end");
  level._id_B126 delete();
}

_id_B13C(var_0) {
  level._id_B128 show();
}

_id_EAF5() {
  thread _id_B127();
  level._id_B11F scripts\sp\anim::_id_1F35(level._id_EA2C, "md_catwalk_to_console");
  level._id_B11F thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "mac_death_scene_b", "stop_b_loop");
}

_id_B127() {
  var_0 = getEnt("mac_death_kiosk_blocker", "targetname");
  var_1 = scripts\engine\utility::getStruct("mac_death_kiosk_blocker_end", "targetname");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  wait 16.0;
  var_0 moveTo(var_1.origin, 2.5);
  level._id_D267 waittill("vfx_mac_death_ended");
  var_0 delete();
}

_id_B121() {
  self._id_1FBB = self.script_noteworthy;
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  scripts\sp\utility::_id_86E4();
}

_id_A6DE() {
  level waittill("kiosk_swap");
  self setModel("equipment_sdf_kiosk_01_red_off");
}

_id_B134() {
  var_0 = getEnt("drop_pod_launch", "targetname");
  var_0 scripts\sp\utility::_id_65E0("pod_done");
  thread _id_B135();
  var_0 scripts\sp\utility::_id_65E3("pod_done");
  wait 1.5;
  var_0 scripts\sp\utility::_id_65DD("pod_done");
  thread _id_B135(1);
  var_0 scripts\sp\utility::_id_65E3("pod_done");
  scripts\engine\utility::flag_set("load_scripted_drop_pod");
}

_id_B135(var_0) {
  var_1 = getEnt("drop_pod_launch", "targetname");
  var_1 dontinterpolate();
  var_1.origin = level._id_5D06.origin;
  var_1.angles = level._id_5D06.angles;
  wait 0.1;
  var_1 show();
  level._id_5D06 thread scripts\sp\maps\yard\yard_audio::_id_2599();
  var_2 = level._id_5D06;
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");

  while(isDefined(var_3)) {
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;

    if(isDefined(var_3._id_ED75))
      var_4 = var_3._id_ED75;
    else
      var_4 = 1.0;

    if(isDefined(var_3.script_accel))
      var_5 = var_3.script_accel;
    else
      var_5 = 0;

    if(isDefined(var_3._id_ED4C))
      var_6 = var_3._id_ED4C;
    else
      var_6 = 0;

    var_1 moveTo(var_3.origin, var_4, var_5, var_6);
    var_1 rotateTo(var_3.angles, var_4, var_5, var_6);
    wait(var_4);
    var_2 = var_3;

    if(isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
      continue;
    }

    var_3 = undefined;
  }

  if(!isDefined(var_0)) {
    if(!scripts\engine\utility::flag("md_catwalk_idle")) {
      scripts\engine\utility::flag_wait("md_catwalk_continue");
      wait 2.6;
    } else {
      scripts\engine\utility::flag_wait("md_catwalk_continue");
      wait 0.1;
    }
  } else
    wait 1.0;

  var_1 thread scripts\sp\maps\yard\yard_audio::_id_2595(-2500, 2.0, 0.1);
  var_1 movez(-2500, 2.0, 0.1, 0);
  var_1 waittill("movedone");
  var_1 hide();
  wait 0.1;
  var_1 scripts\sp\utility::_id_65E1("pod_done");

  if(scripts\engine\utility::is_true(var_0))
    var_1 delete();
}

_id_B136() {
  level._id_B11F scripts\sp\anim::_id_1EC3(level._id_D617, "mac_death_pod_arrival");
  level._id_B4F1 waittillmatch("single anim", "start_pod");
  level._id_5D06 thread scripts\sp\maps\yard\yard_audio::_id_2599();
  level._id_B11F scripts\sp\anim::_id_1F35(level._id_D617, "mac_death_pod_arrival");
}

_id_B12F() {
  level._id_D617 _id_0E46::_id_48C4(undefined, (65, 50, 114), &"YARD_PLANT_CHARGE", undefined, 1000, 64, undefined, 0);
  level._id_D617 waittill("trigger");
  level._id_D617 _id_0E46::_id_DFE3();
  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player _meth_823C(level._id_D267, "tag_player", 0.6);
  wait 0.6;
  level.player notify("ready_for_scene_c");
  level._id_D267 show();
  level.player _meth_8580();
}

_id_B12E() {
  var_0 = scripts\engine\utility::getStruct("pod_door_interact", "targetname");
  var_0 _id_0E46::_id_48C4(undefined, (0, -8, 0), "", undefined, 160, 128, 1, 1);
  var_0 thread _id_B138();
  level.player notifyonplayercommand("tappy_pressed", "+usereload");
  level.player notifyonplayercommand("tappy_pressed", "+activate");
  wait 1.5;
  level thread _id_B13B();
  level thread scripts\engine\utility::waittill_notify_or_timeout_return("tappy_pressed", 0.8);
  thread _id_B13D();

  while(!scripts\engine\utility::flag("mac_death_tappy_done")) {
    var_1 = _id_B139(0.5);

    if(isDefined(var_1)) {
      level notify("mac_tappy_complete");
      scripts\engine\utility::flag_set("mac_death_tappy_done");
    }

    level.player waittill("tappy_pressed");
  }
}

_id_B13D() {
  wait 3;
  setmusicstate("");
}

_id_B138() {
  scripts\engine\utility::flag_wait("mac_death_tappy_done");
  _id_0E46::_id_DFE3();
}

_id_B13B() {
  level endon("mac_tappy_failed");
  scripts\engine\utility::flag_set("mac_death_tappy_started");
  level._id_B4F1 waittillmatch("single anim", "end");
  level notify("mac_tappy_complete");
  scripts\engine\utility::flag_set("mac_death_tappy_done");
}

_id_B139(var_0, var_1) {
  level endon("mac_tappy_complete");

  if(!isDefined(var_1))
    level.player thread _id_B13A();

  var_2 = var_0 * 1000;
  var_3 = gettime();

  for(;;) {
    if(gettime() - var_3 > var_2) {
      return;
    }
    var_4 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("tappy_pressed", var_0);

    if(isDefined(var_4)) {
      break;
    }
  }

  return 1;
}

_id_B13A() {
  level endon("mac_tappy_complete");
  level endon("mac_tappy_failed");

  for(;;) {
    level.player playRumbleOnEntity("damage_light");
    earthquake(0.15, 0.1, level.player.origin, 5000);
    wait 0.05;
  }
}

_id_B12B() {
  level._id_B4F1 waittillmatch("single anim", "end");
  level._id_B4F1 notify("vfx_mac_death_ended");
  level._id_B4F1 scripts\sp\utility::_id_1101B();
  level._id_B4F1 delete();
}

_id_B12D() {
  self waittillmatch("single anim", "end");
  self notify("vfx_mac_death_ended");
  self delete();
}

_id_B129() {
  self waittillmatch("single anim", "end");
  self delete();
  level._id_B128 delete();
}

_id_B12C() {
  level._id_D267 waittillmatch("single anim", "end");
  level._id_D267 notify("vfx_mac_death_ended");

  if(level.player islinked())
    level.player unlink();

  if(isent(level._id_D267))
    level._id_D267 delete();

  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player scripts\engine\utility::allow_offhand_secondary_weapons(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_sprint(1);
  level.player scripts\sp\utility::_id_2B76(1.0, 1.5);
  level.player _meth_857F();
  level.player scripts\sp\utility::_id_F526("relaxed");
  level thread scripts\sp\utility::_id_2670();
}

_id_B122() {
  wait 3.25;
  _id_0B0A::_id_583F(0, 0.3, 3.9, 0, 741.62, 5.1, 2.0);
  scripts\engine\utility::flag_wait("mac_death_scene_e_start");
  wait 2.25;
  _id_0B0A::_id_583F(0, 726.5, 4.25, 3000, 7500, 0.0, 0.6);
  level waittill("clear_mac_death_dof");
  _id_0B0A::_id_583D(0.5);
}

_id_B125() {
  level thread _id_8941();
  level._id_D7C7 = getEnt("pod_airlock_pre_door_inner", "targetname");
  level._id_D7C7 scripts\sp\utility::_id_23B7("door");
  level._id_D7C7.clip = getEnt(level._id_D7C7.target, "targetname");
  level._id_D7C7.clip linkTo(level._id_D7C7, "door_jnt");
  level._id_D7D8 = level.doors["pod_airlock_pre_door_outer"];
  thread _id_0B1F::_id_1AB7(1, level._id_D7C7, level._id_D7D8);
  level._id_D7C7.clip connectpaths();
  wait 1.5;
  var_0 = scripts\engine\utility::getStruct("mac_death_ap", "targetname");
  var_0 thread scripts\sp\anim::_id_1EC3(level._id_D7C7, "airlock_to_ambush_close");
  level._id_D7C7.clip disconnectPaths();
  scripts\engine\utility::flag_wait("salter_goto_airlock");

  if(!scripts\engine\utility::flag("player_inside_ambush_airlock")) {
    var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "airlock_to_ambush_idle", "stop_salter_airlock_idle");
    scripts\engine\utility::flag_wait("player_inside_ambush_airlock");
  }

  var_1 = getEnt("ambush_airlock_exit_blocker", "targetname");
  var_1 scripts\sp\utility::_id_100FC();
  wait 0.25;
  var_0 notify("stop_salter_airlock_idle");
  level._id_D7C7.clip connectpaths();
  var_2 = [level._id_EA2C, level._id_D7C7];
  level._id_EA2C thread _id_EA2F();
  level._id_D7C7 thread scripts\sp\maps\yard\yard_audio::_id_25D2("pod_airlock_pre");
  var_0 thread scripts\sp\anim::_id_1F2C(var_2, "airlock_to_ambush_close");
  var_3 = getEnt("airlock_player_blocker", "targetname");

  if(isDefined(var_3))
    var_3 scripts\engine\utility::delaythread(3.0, ::_id_1ACD);

  wait 7.25;
  var_1 scripts\sp\utility::_id_8E9A();
  level._id_D7C7.clip disconnectPaths();
  scripts\sp\maps\yard\yard_fx::_id_132CD(0);
  scripts\sp\maps\yard\yard_fx::_id_132AE(1);
  vertical_hall_worldup_end();
  level.player scripts\engine\utility::allow_melee(0);
  thread ship_hack_bring_player_to_up(6.448, 2.0, (-1448, 568, 1322), (-1258, 728, 1435));
  level._id_D7C7 thread scripts\sp\maps\yard\yard_audio::_id_2579("pod_airlock_pre");
  _id_0B1F::_id_1AA9("pod_airlock_pre", 1, level._id_D7C7, level._id_D7D8, 1);
  _id_0F35::_id_FB24(0, level.player);
  _id_0F35::_id_FB25(0, 0);
  _id_0A2F::_id_13E80(0, 1);
  _id_0B2A::_id_E2C0();
  setsaveddvar("player_zeroGravWorldUp", (0, 0, 0));
  setsaveddvar("player_zeroGravDisableWalk", 1);
  level.player allowmantle(1);
  level.player allowwallrun(1);
  level.player scripts\engine\utility::allow_melee(1);
  level.player _id_0F35::_id_D3CD("ges_samoon_bridge_gravity_land");

  if(isDefined(var_3))
    var_3 delete();

  level._id_EA2C thread scripts\sp\utility::_id_DC45("raise");
  scripts\engine\utility::delaythread(1.0, _id_0E4B::_id_1348D);
  scripts\engine\utility::delaythread(1.0, _id_0B0B::_id_25C3);
  scripts\engine\utility::waitframe();

  while(!istransientloaded("yard_base_capitalship_tr")) {
    wait 0.05;
    waitforalltransients();
  }

  scripts\engine\utility::flag_set("elevator_mac_death_end");
  wait 0.5;
  level._id_D7D8 scripts\sp\utility::_id_65E1("ambush_airlock_exit_door_enable");
}

ship_hack_bring_player_to_up(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  var_4 = 16;
  var_5 = 71;
  var_6 = 0.1;
  var_7 = var_2[0] + var_4;
  var_8 = var_3[0] - var_4;
  var_9 = var_2[1] + var_4;
  var_10 = var_3[1] - var_4;
  var_11 = var_2[2] + var_6;
  var_12 = var_3[2] - var_5;
  var_13 = clamp(level.player.origin[0], var_7, var_8);
  var_14 = clamp(level.player.origin[1], var_9, var_10);
  var_15 = clamp(level.player.origin[2], var_11, var_12);
  var_16 = (var_13, var_14, var_15);
  var_17 = anglesToForward(level.player getplayerangles());
  var_17 = vectorNormalize((var_17[0], var_17[1], 0));
  var_18 = 0;

  if(lengthsquared(var_17) > 0)
    var_18 = vectortoyaw(var_17);

  var_19 = scripts\engine\utility::spawn_tag_origin(var_16, (0, var_18, 0));
  level.player setvelocity((0, 0, 0));
  level.player _meth_823C(var_19, "tag_origin", var_1, var_1 * 0.25, var_1 * 0.25);
  wait(var_1);
  level.player unlink();
  var_19 delete();
  setsaveddvar("player_zeroGravWorldUp", (0, 0, 1));
  setsaveddvar("player_zeroGravDisableWalk", 1);
}

_id_8941() {
  var_0 = getEnt("inside_teleport_airlock", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  while(!scripts\engine\utility::flag("elevator_mac_death_end")) {
    if(!level.player istouching(var_0))
      scripts\engine\utility::flag_clear("player_inside_ambush_airlock");

    wait 0.05;
  }
}

_id_1ACD() {
  var_0 = scripts\engine\utility::getStruct("airlock_player_blocker_start", "targetname");
  var_1 = scripts\engine\utility::getStruct("airlock_player_blocker_end", "targetname");
  self.origin = var_0.origin;
  self moveTo(var_1.origin, 1.5);
}

_id_EA2F() {
  wait 0.25;
  self waittillmatch("single anim", "end");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  self setgoalpos(var_0.origin);
  scripts\engine\utility::flag_wait("salter_move_to_ambush_door");
  var_0 delete();
}

get_min_ally_dist_sq() {
  var_0 = getaiarray("allies");
  var_1 = 10000000.0;

  foreach(var_3 in var_0) {
    var_4 = distancesquared(var_3.origin, self.origin);

    if(var_4 < var_1)
      var_1 = var_4;
  }

  return var_1;
}

_id_132A7() {
  level endon("vertical_hall_worldUp");
  var_0 = getEnt("vertical_hall_volume", "targetname");
  var_1 = scripts\engine\utility::getStruct("vertical_hall_struct", "targetname");
  setdvarifuninitialized("yard_override_snap", 0);
  level.player.vertical_hall_state = 0;

  if(isDefined(var_0) && isDefined(var_1)) {
    while(!scripts\engine\utility::flag("elevator_mac_death_end")) {
      if(level.player istouching(var_0)) {
        if(!level.player.vertical_hall_state) {
          setsaveddvar("player_zeroGravWorldUp", anglesToForward(var_1.angles));
          _id_0F31::_id_17A5();
          scripts\engine\utility::waitframe();
          setsaveddvar("player_zeroGravDisableWalk", 1);
          level.player.vertical_hall_state = 1;
        }

        if(isDefined(level.player _meth_845B()) && !getdvarint("yard_override_snap") && level.player get_min_ally_dist_sq() < 3600)
          setsaveddvar("pmove_snap_world_up", 0.9);
        else
          setsaveddvar("pmove_snap_world_up", 0);
      } else if(level.player.vertical_hall_state) {
        setsaveddvar("player_zeroGravWorldUp", (0, 0, 0));
        setsaveddvar("player_zeroGravDisableWalk", 0);
        setsaveddvar("pmove_snap_world_up", 0);
        _id_0F31::_id_E0CE();
        level.player.vertical_hall_state = 0;
      }

      scripts\engine\utility::waitframe();
    }

    vertical_hall_worldup_end();
  }
}

vertical_hall_worldup_end() {
  setsaveddvar("player_zeroGravWorldUp", (0, 0, 0));
  setsaveddvar("player_zeroGravDisableWalk", 0);
  _id_0F31::_id_E0CE();
  setsaveddvar("pmove_snap_world_up", 0);
  level.player.vertical_hall_state = 0;
  level notify("vertical_hall_worldUp");
}

_id_10C2A() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_ambush", "start");
  scripts\sp\maps\yard\yard_util::_id_107BE("continue_salter_elevator_top");
  level._id_EA2C scripts\sp\utility::_id_F3B5("b");
  level._id_EA2C scripts\sp\maps\yard\yard_util::_id_8E36();
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_player_elevator_top", "targetname"));
  level.player scripts\sp\utility::_id_F526("relaxed");
  level._id_D7C8 = scripts\engine\utility::getStruct("pod_airlock_door_pre_struct", "targetname");
  level._id_D7C7 = getEnt("pod_airlock_pre_door_inner", "targetname");
  level._id_D7C7 scripts\sp\utility::_id_23B7("door");
  level._id_D7C7.clip = getEnt(level._id_D7C7.target, "targetname");
  level._id_D7C7.clip linkTo(level._id_D7C7);
  level._id_D7C7.clip disconnectPaths();
  level._id_D7D8 = level.doors["pod_airlock_pre_door_outer"];
  thread _id_0B1F::_id_1AB7(0, level._id_D7C7, level._id_D7D8);
  level._id_D7C7 thread scripts\sp\maps\yard\yard_audio::_id_2579("pod_airlock_pre");
  _id_0B1F::_id_1AA9("pod_airlock_pre", 1, level._id_D7C7, level._id_D7D8, 1);
  level._id_D7D8 scripts\sp\utility::_id_65E1("ambush_airlock_exit_door_enable");
  level._id_D7D8 thread scripts\sp\maps\yard\yard_util::_id_F595();
  var_0 = getEntArray("fake_elevator_pod", "targetname");
  scripts\engine\utility::array_call(var_0, ::hide);
}

_id_B1C9() {
  scripts\sp\utility::_id_2669("yard_elevator_top");

  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_ambush", "main");
  scripts\sp\maps\yard\yard_fx::_id_132CD(0);
  scripts\sp\maps\yard\yard_fx::_id_132AE(1);
  scripts\engine\utility::delaythread(10.0, ::_id_11B4D);
  scripts\sp\maps\yard\yard_util::_id_13E2E();
  level._id_EA2C _id_0F18::_id_10E8B("hidden");
  scripts\sp\maps\yard\yard_util::_id_D2E0();
  level._id_1E25 = _id_0B6C::_id_FA2A("ambush_rss");
  scripts\sp\player_rig::_id_96EA("viewmodel_base_viewhands_iw7");
  thread _id_6033();
  thread _id_6035();
  thread scripts\sp\utility::_id_12641("yard_tram_central_tr");
  thread _id_13493();
  scripts\engine\utility::flag_wait("elevator_top_end");
  scripts\engine\utility::waitframe();
  thread scripts\sp\maps\yard\yard_util::_id_10180();
  _id_0F27::_id_558C();
  wait 0.25;
  level.player unlink();
  level.player enableweapons();
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_doublejump(1);
  level.player scripts\engine\utility::allow_sprint(1);
  thread scripts\sp\utility::_id_12641("yard_central_hallway_tr");
  scripts\sp\maps\yard\yard_fx::_id_132AE(0);
  level._id_EA2C scripts\sp\utility::_id_5514();
}

_id_3B59() {
  scripts\sp\maps\yard\yard_audio::_id_25EE("elevator_ambush", "catchup");
  level thread _id_40A9();
  var_0 = getEntArray("fake_elevator_pod", "targetname");
  scripts\sp\utility::_id_228A(var_0);
}

_id_6033() {
  level thread _id_1E24();
  level._id_D7D8 scripts\sp\utility::_id_65E3("begin_opening");
  level._id_D7D8._id_DF3A = undefined;
  level thread _id_40A9();
  var_0 = scripts\engine\utility::getStruct("pod_airlock_pre_relative", "targetname") scripts\engine\utility::spawn_tag_origin();
  var_1 = scripts\engine\utility::getStruct("pod_airlock_actual_relative", "targetname") scripts\engine\utility::spawn_tag_origin();
  level._id_EA2C thread _id_6031();
  level._id_D7C7 _meth_83BA(var_0, var_1);
  level._id_D7C7 dontinterpolate();
  wait 1.0;
  scripts\engine\utility::flag_wait("spawn_ambush");
  level.player scripts\sp\utility::_id_F526("normal");
  level.player thread _id_3D59();
  level.player thread _id_3D5A();
  var_2 = getEntArray("fake_elevator_pod", "targetname");
  scripts\engine\utility::array_call(var_2, ::show);
  level._id_1E17 = undefined;
  level._id_1E18 = undefined;
  scripts\sp\utility::_id_22C9("console_guy", ::_id_1E0F);
  scripts\sp\utility::_id_22C9("console_guy", ::_id_602D);
  scripts\sp\utility::_id_22C9("console_guy", ::_id_602E);
  scripts\sp\utility::_id_22CA("sdf_control_room", ::_id_602D);
  scripts\sp\utility::_id_22CA("sdf_control_room", ::_id_602E);
  level._id_F02E = scripts\sp\utility::_id_22CD("sdf_control_room", 1, 1);
  scripts\sp\utility::_id_28D7("axis");

  foreach(var_4 in level.players)
  var_4 thread _id_0F24::_id_1DD2();

  thread _id_1E11();

  if(!scripts\engine\utility::flag("ambush_combat_started"))
    scripts\engine\utility::flag_wait("ambush_combat_started");

  level._id_F02E = scripts\engine\utility::array_removeundefined(level._id_F02E);
  scripts\sp\utility::_id_13754(level._id_F02E, level._id_F02E.size);
  var_6 = getEnt("ambush_room", "targetname");
  var_7 = var_6 scripts\sp\utility::_id_77E3("axis");

  if(isDefined(var_7) && var_7.size > 0)
    scripts\sp\utility::_id_13754(var_7, var_7.size);

  scripts\engine\utility::flag_set("ambush_done");
  scripts\engine\utility::flag_set("yard_obj_ambush_done");
  scripts\sp\utility::_id_28D7("axis");
  level.player scripts\engine\utility::delaythread(3.5, scripts\sp\utility::_id_F526, "relaxed");
  wait 4.0;
  thread _id_6030();
  thread scripts\sp\utility::_id_2679();
  scripts\engine\utility::flag_wait("post_ambush_vo_done");
  var_8 = scripts\engine\utility::getStruct("elevator_top_call_interact", "targetname");
  var_8 _id_0E46::_id_48C4(undefined, undefined, &"YARD_HINT_OPEN", undefined, 5000, 128);
  var_8 waittill("trigger");

  if(isDefined(level._id_6754))
    level._id_6754 delete();

  level.player freezecontrols(1);
  level.player disableweapons();
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_sprint(0);
  level.player scripts\sp\utility::_id_F526("normal");
  scripts\engine\utility::flag_set("elevator_top_end");
  wait 1.0;
  level notify("ambush_ammo_cleanup");
}

_id_1E24() {
  level._id_D6C8 = getEnt("pod_airlock_post_door_outer", "targetname");
  level._id_D6C8._id_1FBB = "door";
  level._id_D6C8 scripts\sp\anim::_id_F64A();
  level._id_D6C8 thread scripts\sp\maps\yard\yard_util::_id_F595();
  level._id_D7D8 = level.doors["pod_airlock_pre_door_outer"];
  var_0 = level._id_D6C8 scripts\sp\utility::_id_7A8F();
  scripts\engine\utility::array_call(var_0, ::linkto, level._id_D6C8, "door_jnt");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "player_clip") {
      continue;
    }
    level._id_D6C8._id_C969 = var_2;
  }

  var_4 = scripts\sp\utility::_id_10639("player_rig");
  level.player._id_59F6 = var_4;
  var_5 = [level._id_D6C8, var_4];
  level._id_D6C8 thread scripts\sp\anim::_id_1EC3(var_4, "airlock_open_start");
  level._id_D6C8 thread scripts\sp\anim::_id_1EC3(level._id_D6C8, "airlock_open_start");
  level._id_D7D8 scripts\sp\utility::_id_65E3("begin_opening");
  level thread scripts\sp\utility::_id_2670();
  level._id_D6C8 thread scripts\sp\anim::_id_1F2C(var_5, "airlock_open_start");
  level.player lerpviewangleclamp(0.6, 0.2, 0.2, 0, 0, 0, 0);
  wait 0.6;
  level.player dontinterpolate();
  level.player playerlinktodelta(var_4, "tag_player", 1, 5, 0, 5, 5, 1);
  level.player setviewangleresistance(30, 0, 30, 30);
  level._id_D6C8._id_C969 scripts\engine\utility::delaycall(3.2, ::connectpaths);
  var_4 waittillmatch("single anim", "end");
  level._id_D6C8 thread scripts\sp\anim::_id_1EE7(var_5, "airlock_open_end", "end_airlock_loop");
  scripts\sp\utility::_id_127B3("salter_into_ambush_hall");
  level._id_D6C8 notify("end_airlock_loop");
  level.player _id_0B1F::_id_5990();
  level.player unlink();
  var_4 delete();
  level._id_D6C8._id_C969 disconnectPaths();
  wait 2;
  thread scripts\sp\utility::_id_1264E("yard_pod_chamber_tr");
}

_id_1E11() {
  scripts\engine\utility::flag_wait_all("guy_01_in_place", "guy_02_in_place");
}

_id_1E0F() {
  self endon("death");
  scripts\sp\utility::_id_22CA("c6_rss_spawner", ::_id_3356);
  scripts\sp\utility::_id_22CA("c6_rss_spawner", ::_id_602D);
  var_0 = scripts\engine\utility::getStruct("ambush_rss_console", "targetname");
  self._id_1FBB = "generic";
  self.allowdeath = 1;
  var_0 scripts\sp\anim::_id_1F17(self, "console_enter");
  var_0 scripts\sp\anim::_id_1F35(self, "console_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "console_loop", "stop_idle");
  wait 1.5;
  level._id_1E25 thread _id_0B6C::_id_8953();
  wait 1.5;
  var_1 = getEnt("c6_rss_spawner", "targetname");
  var_1 scripts\sp\utility::_id_E08B(::_id_3356);
  var_1 scripts\sp\utility::_id_E08B(::_id_602D);
  var_0 notify("stop_idle");
  var_0 scripts\sp\anim::_id_1F35(self, "console_exit");
  var_2 = getnode(var_0.target, "targetname");
  self _meth_82EE(var_2);
}

_id_3356() {
  wait 0.1;
  self.allowdeath = 1;
  var_0 = scripts\engine\utility::getStruct("ambush_animnode", "targetname");

  if(isDefined(self.script_parameters)) {
    self waittillmatch("single anim", "end");
    self._id_1FBB = "generic";

    if(self.script_parameters == "rss_robot_2") {
      var_0 scripts\sp\anim::_id_1F35(self, "ambush_stand_enter");
      var_1 = getnode("ambush_robot_1_node", "targetname");

      if(isDefined(var_1))
        self _meth_82EE(var_1);
    }

    if(self.script_parameters == "rss_robot_1") {
      self allowedstances("crouch");
      var_0 scripts\sp\anim::_id_1F35(self, "ambush_crouch_enter");
      var_1 = getnode("ambush_robot_2_node", "targetname");

      if(isDefined(var_1))
        self _meth_82EE(var_1);

      scripts\engine\utility::flag_wait_any("stealth_spotted", "ambush_combat_started");
      self allowedstances("crouch", "stand", "prone");
    }
  }
}

_id_6030() {
  var_0 = getEntArray("fake_elevator_pod", "targetname");

  foreach(var_2 in var_0)
  var_2 movez(512, 3, 0, 2);

  wait 1.5;
  var_4 = getEnt("scripted_light_precinematic", "targetname");
  var_4 setlightintensity(11);
  scripts\engine\utility::flag_set("ambush_elevator_done_moving");
  var_5 = getEntArray("gangway", "targetname");

  foreach(var_2 in var_5)
  var_2 movex(68, 3, 0, 0);

  scripts\engine\utility::flag_wait("elevator_top_end");
  wait 1.25;
  scripts\sp\utility::_id_228A(var_0);
}

_id_6031() {
  var_0 = getnode("salter_ambush_airlock_node", "targetname");
  level._id_EA2C scripts\sp\utility::_id_1160F(var_0);
  level._id_EA2C dontinterpolate();
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_61E7();
  scripts\sp\utility::_id_61C8();
  level._id_D7D8 scripts\sp\utility::_id_65E3("begin_opening");
  scripts\sp\utility::_id_15F5("exit_ambush_airlock");
  scripts\engine\utility::delaythread(5.5, scripts\sp\utility::_id_10346, "yard_slt_wereclearthroug");
  scripts\engine\utility::flag_wait("salter_move_to_ambush_door");
  scripts\sp\utility::_id_54F7();
  self.goalradius = 32;
  thread _id_840E();
  thread _id_6032();
  scripts\engine\utility::flag_wait("ambush_player_behind_salter");
  var_1 = scripts\engine\utility::getStruct("ambush_animnode", "targetname");
  var_2 = level.player getweaponslistall();
  var_3 = 0;

  foreach(var_5 in var_2) {
    if(issubstr(var_5, "wall"))
      var_3 = 1;
  }

  if(scripts\engine\utility::flag("salter_at_ambush_door")) {
    wait 0.45;
    scripts\sp\utility::_id_5514();

    if(!scripts\engine\utility::flag("ambush_combat_started") && !var_3)
      var_1 scripts\sp\anim::_id_1F35(self, "salt_ambush_cover_enter");
  } else {
    if(!scripts\engine\utility::flag("ambush_combat_started") && !var_3)
      var_1 scripts\sp\anim::_id_1F17(self, "salt_ambush_cqb_enter");

    scripts\sp\utility::_id_5514();

    if(!scripts\engine\utility::flag("ambush_combat_started") && !var_3)
      var_1 scripts\sp\anim::_id_1F35(self, "salt_ambush_cqb_enter");
  }

  scripts\engine\utility::flag_set("salter_at_ambush_overlook");

  if(!scripts\engine\utility::flag("ambush_combat_started")) {
    var_7 = getnode("salter_overlook_ambush", "targetname");
    self _meth_82EE(var_7);
  }

  scripts\engine\utility::flag_wait("ambush_done");
  self.fixednode = 1;
  self.ignoresuppression = 0;
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_61E7();
  scripts\sp\utility::_id_54F7();
  self.goalradius = 16;
  scripts\sp\utility::_id_5504();
  wait 1.5;
  var_0 = getnode("salter_post_ambush_node", "targetname");
  self _meth_82EE(var_0);
  self waittill("goal");
  var_1 = scripts\engine\utility::getStruct("ambush_animnode", "targetname");
  var_1 scripts\sp\anim::_id_1F17(self, "salt_ambush_entry");
  scripts\sp\utility::_id_61DB();
  var_1 scripts\sp\anim::_id_1F35(self, "salt_ambush_entry");
  scripts\sp\utility::_id_F3DC(self.origin);
  scripts\sp\utility::_id_51E1("casual_gun");
}

_id_6032() {
  scripts\engine\utility::flag_wait_any("stealth_spotted", "ambush_combat_started");
  self.ignoresuppression = 1;
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_F415(0);
  self.fixednode = 0;
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_15F5("salter_ambush_combat");
}

_id_3D59() {
  while(!scripts\engine\utility::flag("ambush_done")) {
    if(self attackButtonPressed()) {
      scripts\engine\utility::flag_set("ambush_combat_started");
      _id_0F18::_id_10E8A("broadcast", "attack", level.player getEye(), 800);
    }

    wait 0.25;
  }
}

_id_3D5A() {
  var_0 = getEnt("ambush_floor", "targetname");

  while(isDefined(var_0) && !scripts\engine\utility::flag("ambush_done")) {
    if(level.player istouching(var_0)) {
      scripts\engine\utility::flag_set("ambush_combat_started");
      _id_0F18::_id_10E8A("broadcast", "attack", level.player getEye(), 800);
    }

    wait 0.25;
  }
}

_id_840E() {
  var_0 = getnode("salter_ambush_door_node", "targetname");
  self _meth_82EE(var_0);
  self waittill("goal");
  scripts\engine\utility::flag_set("salter_at_ambush_door");
}

_id_6034(var_0) {
  var_0 scripts\sp\anim::_id_1F35(level._id_D267, "bridge_lever_pull");
  var_0 thread scripts\sp\anim::_id_1EE0(level._id_D267, "bridge_lever_pull");
}

_id_602D() {
  self endon("death");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ambush_guy_01") {
    self._id_1FBB = "generic";
    level._id_1E17 = self;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ambush_guy_02") {
    self._id_1FBB = "generic";
    level._id_1E18 = self;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "door_guy_01")
    thread _id_6E42("guy_01_in_place");

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "door_guy_02")
    thread _id_6E42("guy_02_in_place");

  while(!scripts\sp\utility::_id_65DF("stealth_enabled"))
    wait 0.05;

  while(!scripts\sp\utility::_id_65DB("stealth_enabled"))
    wait 0.05;

  _id_0F1B::_id_F299("warning1");
  scripts\sp\utility::_id_61E7();
  self waittill("damage");
  scripts\engine\utility::flag_set("ambush_combat_started");
  _id_0F18::_id_10E8A("broadcast", "attack", level.player getEye(), 800);
}

_id_6E42(var_0) {
  self waittill("goal");
  scripts\engine\utility::flag_set(var_0);
}

_id_602E() {
  self endon("death");
  self endon("did_boost_jump");
  var_0 = getEnt("ambush_floor_2", "targetname");

  if(!isDefined(var_0))
    var_0 = getEnt("ambush_floor", "targetname");

  var_1 = scripts\engine\utility::getStructArray("ambush_grenade_target", "targetname");
  var_2 = scripts\engine\utility::getStructArray("ambush_shoot_target", "targetname");
  scripts\engine\utility::flag_wait_any("stealth_spotted", "ambush_combat_started");
  self._id_117F4 = gettime();
  self.goalradius = 128;

  if(isDefined(var_0))
    self _meth_82F1(var_0);

  for(;;) {
    var_3 = randomint(100);

    if(var_3 > 75 && !scripts\engine\utility::flag("no_more_ambush_jumpers"))
      thread _id_602C();

    if(var_3 > 55 && !level.player scripts\sp\utility::_id_CFAC(self) && gettime() > self._id_117F4 + 10000) {
      var_4 = scripts\engine\utility::random(var_1);
      magicgrenade(self.grenadeweapon, self.origin + (0, 0, 40), var_4.origin, 3.0, 1);
      self._id_117F4 = gettime();
    } else if(!level.player scripts\sp\utility::_id_CFAC(self)) {
      var_5 = scripts\engine\utility::random(var_2);

      if(isDefined(var_5)) {
        var_6 = scripts\engine\utility::spawn_tag_origin(var_5.origin);

        if(isDefined(self.enemy) && !self canshootenemy()) {
          self _meth_8306(var_6);
          self _meth_82DE(var_6);
          wait 0.5;
          var_7 = randomintrange(3, 5);

          for(var_8 = 0; var_8 < var_7; var_8++) {
            self shoot();
            wait 0.15;
          }
        }

        var_6 delete();
      } else {}
    } else {
      self _meth_8306();
      self clearentitytarget();
    }

    wait 1.0;
  }
}

_id_602C() {
  self endon("death");
  var_0 = getEnt("ambush_balcony", "targetname");

  if(isDefined(var_0)) {
    self _meth_82F1(var_0);
    scripts\engine\utility::flag_set("no_more_ambush_jumpers");
    self notify("did_boost_jump");

    if(level.player istouching(var_0))
      scripts\sp\utility::_id_F39C(level.player);
    else
      scripts\sp\utility::_id_F39C(level._id_EA2C);
  } else {}
}

_id_6035() {
  scripts\engine\utility::flag_wait("spawn_ambush");
  thread ambush_enemies();

  if(!scripts\engine\utility::flag("ambush_combat_started"))
    level._id_EA2C scripts\sp\utility::_id_10346("yard_slt_enemiesupaheads");

  scripts\engine\utility::flag_wait("salter_at_ambush_overlook");
  wait 1.0;

  if(!scripts\engine\utility::flag("ambush_combat_started"))
    scripts\sp\utility::_id_1034D("yard_plr_thatstheshuttle");

  wait 1.0;

  if(!scripts\engine\utility::flag("ambush_combat_started")) {
    level._id_EA2C scripts\sp\utility::_id_10346("yard_slt_wevegotthedropo");
    level._id_EA2C thread _id_1E1E();
  }

  scripts\engine\utility::flag_wait("ambush_done");
  wait 2.0;
  scripts\sp\utility::_id_1034D("yard_plr_clear2");
  wait 1.5;
  level._id_EA2C scripts\sp\utility::_id_10346("yard_slt_letsgettheother");
  scripts\sp\utility::_id_1034D("yard_plr_rog");
  wait 1.0;

  if(!level.player isgestureplaying()) {
    level.player scripts\sp\utility::_id_D08C("ges_radio");
    level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  }

  if(level.player isgestureplaying("ges_radio")) {
    level.player playSound("ges_plr_radio_off");
    level.player stopgestureviewmodel("ges_radio");
  }

  scripts\engine\utility::flag_wait("ambush_elevator_done_moving");
  scripts\sp\utility::_id_10350("yard_eth_captainthedoorsjamm");
  scripts\engine\utility::flag_set("post_ambush_vo_done");
  level._id_EA2C thread _id_1E13();
}

_id_1E1E() {
  level endon("stealth_spotted");
  level endon("ambush_combat_started");
  wait 10;
  level._id_EA2C scripts\sp\utility::_id_10346("yard_slt_equipmentoverth");
}

_id_1E13() {
  level endon("elevator_top_end");
  wait 10;
  level._id_EA2C scripts\sp\utility::_id_10346("yard_slt_getemoutillcover");
}

ambush_enemies() {
  level endon("stealth_spotted");
  wait 1.5;

  if(isDefined(level._id_1E17))
    level._id_1E17 scripts\sp\utility::_id_10346("yard_sf1_wethinksatoista");

  if(isDefined(level._id_1E18))
    level._id_1E18 scripts\sp\utility::_id_10346("yard_sdf1_shuttleguardsge");

  if(isDefined(level._id_1E17))
    level._id_1E17 scripts\sp\utility::_id_10346("yard_sf1_deployc6s");

  if(isDefined(level._id_1E18))
    level._id_1E18 scripts\sp\utility::_id_10346("yard_sf2_dowehaveanycoun");

  if(isDefined(level._id_1E17))
    level._id_1E17 scripts\sp\utility::_id_10346("yard_sf1_doesntmatterthe");
}

_id_11B4D() {
  setsaveddvar("bg_cinematicfullscreen", 0);
  cinematicingameloopresident("yard_pod_bay_idle_screens");
  scripts\engine\utility::flag_wait("elevator_top_end");
  stopcinematicingame();
}

_id_13493() {
  var_0 = getEntArray("control_room_vista_dome_01", "targetname");

  if(isDefined(var_0) && var_0.size) {
    foreach(var_2 in var_0)
    var_2 show();
  }
}