/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_elevator.gsc
**********************************************************/

_id_60A6() {
  var_0 = scripts\engine\utility::getStructArray("spaceelevator_modelspawn", "targetname");

  foreach(var_2 in var_0)
  precachemodel(var_2.script_noteworthy);
}

_id_6E6C() {
  scripts\engine\utility::flag_init("elevator_enter_end");
  scripts\engine\utility::flag_init("elevator_load_end");
  scripts\engine\utility::flag_init("elevator_launch_end");
}

_id_60CA() {
  level._id_603C = getEnt("elevator_cab_clip", "targetname");
  var_0 = scripts\engine\utility::getStruct("elevator_ring_spot", "targetname");
  level._id_603F = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_6040 = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_603F linkTo(level._id_603C);
  level._id_B512 = getEnt("fxanim_elevator_shutters", "targetname");
  level._id_B512 linkTo(level._id_603C);
  level._id_B512._id_1FBB = "elevator_louvers";
  level._id_B512 scripts\sp\utility::_id_23B7();
  level._id_B512 scripts\sp\anim::_id_1EC1([level._id_B512], "elevator_louvers_anim");
  level._id_113D5 = scripts\engine\utility::getStruct("tag_align_spaceelevator", "targetname");
  thread _id_60CE();
  var_1 = scripts\engine\utility::getStruct("elevator_cloud_spawn", "targetname");
  level._id_603D = var_1 scripts\engine\utility::spawn_tag_origin();
  level._id_603D linkTo(level._id_603C);
  thread _id_60C7();
  thread _id_6096();
  level thread _id_608E();
}

_id_608E() {
  var_0 = scripts\engine\utility::getStruct("elevator_lights_tag_origin", "targetname");
  var_1 = scripts\engine\utility::getStruct("elevator_floor_tag_origin", "targetname");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  level._id_6090 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  level._id_149C = getEntArray("elevator_lights_reflection_linked", "script_noteworthy");
  scripts\engine\utility::array_call(level._id_149C, ::linkto, level._id_6090);
  level._id_6073 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  level._id_6090.origin = level._id_6073.origin;
  level._id_6090.angles = level._id_6073.angles;
  level._id_6090 linkTo(level._id_6073);
  level._id_6073 linkTo(level._id_603C);
  level._id_149D = getEntArray("elevator_lights_main_linked", "script_noteworthy");
  scripts\engine\utility::array_call(level._id_149D, ::linkto, level._id_6073);
}

_id_60CE() {
  if(!scripts\engine\utility::is_true(level._id_270A)) {
    level._id_270A = 1;
    var_0 = [];
    level._id_B38D = [];
    var_1 = scripts\engine\utility::getStructArray("spaceelevator_modelspawn", "targetname");

    if(var_1.size > 0) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3.script_noteworthy)) {
          var_4 = scripts\sp\maps\marsbase\marsbase_util::_id_107D0(var_3.script_noteworthy, var_3.origin, var_3.angles);
          var_4 linkTo(level._id_603C);
          level._id_B38D = scripts\engine\utility::array_add(level._id_B38D, var_4);
          continue;
        }

        var_0 = scripts\engine\utility::array_add(var_0, var_3);
      }
    }
  }
}

_id_6096() {
  var_0 = getEntArray("mdl_elevator_louver", "targetname");

  if(var_0.size > 0) {
    foreach(var_2 in var_0)
    var_2 delete();
  }
}

_id_608C(var_0) {
  level notify(var_0);
}

_id_6094(var_0) {
  if(!isDefined(var_0))
    var_0 = 4;

  var_1 = getdvarfloat("r_tonemapexposure");
  level thread scripts\sp\utility::_id_AB9A("r_tonemapExposure", 7, var_0);
  level._id_B512 playSound("mars_base_elevator_shutters_start");
  level._id_B512 playLoopSound("mars_base_elevator_shutters_loop");
  level._id_B512 scripts\sp\utility::_id_23B7("elevator_louvers");
  level._id_B512 scripts\sp\anim::_id_1F35(level._id_B512, "elevator_louvers_anim");
  thread _id_6095();
  var_1 = getdvarfloat("r_tonemapexposure");
  _id_608C("running_red_on");
  _id_608C("elevator_sunfake_off");
  level._id_B512 playSound("mars_base_elevator_shutters_stop");
  wait 0.2;
  level._id_B512 stoploopsound();
  level notify("elevators_louvers_closed");
  setsuncolorandintensity(0);
  wait 2.0;
  level notify("anim_done_elevator_rideup");
}

_id_6095() {
  for(var_0 = 1; var_0 <= 6; var_0++) {
    var_1 = getEnt("elevator_droppod_0" + var_0, "targetname");

    if(isDefined(var_1._id_A90E)) {
      if(isDefined(var_1._id_A90E._id_226D)) {
        foreach(var_3 in var_1._id_A90E._id_226D) {
          if(isDefined(var_3))
            var_3 delete();
        }
      }

      var_1._id_A90E delete();
    }

    var_1 delete();
  }

  _id_0B77::_id_A67F(60);
  wait 0.1;
  var_5 = getaiarray("axis");

  foreach(var_7 in var_5) {
    if(isDefined(var_7) && isalive(var_7))
      var_7 delete();
  }

  foreach(var_10 in level._id_6067) {
    if(isDefined(var_10) && isalive(var_10))
      var_10 delete();
  }

  foreach(var_10 in level._id_76E5) {
    if(isDefined(var_10) && isalive(var_10))
      var_10 delete();
  }

  level._id_8604 delete();
}

_id_6091() {
  if(!isDefined(level._id_EA2C)) {
    scripts\sp\player_rig::_id_AD09(20, 20, 10, 10);
    scripts\sp\maps\marsbase\marsbase_util::_id_107BE("seat_elevator_salter");
    scripts\sp\maps\marsbase\marsbase_util::_id_1065E("seat_elevator_brooks");
    scripts\sp\maps\marsbase\marsbase_util::_id_106D9("seat_elevator_ethan");
    scripts\sp\maps\marsbase\marsbase_util::_id_10766("seat_elevator_mccallum");
    scripts\sp\maps\marsbase\marsbase_util::_id_10722("s_elevator_griff_pos");
    level.player scripts\sp\utility::_id_11633(getEnt("seat_elevator_player", "targetname"));
    level thread _id_F086();
  }

  if(!scripts\engine\utility::is_true(level._id_2712))
    level thread _id_60CB();

  level._id_113D5 thread scripts\sp\anim::_id_1EE0(level._id_60C5, "elevator_player_get_in");
  level._id_60C5 thread scripts\sp\anim::_id_1EE0(level._id_D267, "elevator_player_get_in");
  level.player playerlinktodelta(level._id_D267, "TAG_PLAYER", 1, 25, 25, 25, 25, 0);
  level.player _meth_823F(level._id_603C);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  level.player scripts\sp\utility::_id_2B76(0.3, 0.05);
  level._id_D267 linkTo(level._id_603C);
}

_id_604C(var_0, var_1) {
  if(!isent(var_0)) {
    var_2 = scripts\engine\utility::get_target_ent(var_0);
    var_2.count = 1;
    var_3 = var_2 scripts\sp\utility::_id_10619(1);
    var_3._id_1FBB = "generic";
  } else
    var_3 = var_0;

  _id_604A(var_3, var_1);
}

_id_604A(var_0, var_1) {
  var_1 = _id_604B(var_1);
  var_0 scripts\sp\maps\marsbase\marsbase_util::_id_B399(var_1);
  var_0 linkTo(level._id_603C);
  var_1 thread scripts\sp\anim::_id_1EEA(var_0, "elevator_npc01_idle");
  var_1 thread scripts\sp\anim::_id_1EEA(var_1, "elevator_npc01_idle");
  var_0.seat = var_1;
  level._id_6048 = scripts\engine\utility::array_add(level._id_6048, var_0);
  var_0 scripts\sp\utility::_id_F415(1);
  var_0 scripts\sp\utility::_id_F416(1);
  var_0 scripts\sp\utility::_id_51E1("combat");
  var_2 = randomfloatrange(1, 3);
  var_0 scripts\sp\utility::_id_7799(level.player, var_2, var_2);
}

_id_6049(var_0, var_1) {
  var_1 = _id_604B(var_1);
  var_1 thread scripts\sp\anim::_id_1F35(var_0, "elevator_npc01_get_in");
  var_1 scripts\sp\anim::_id_1F35(var_1, "elevator_npc01_get_in");
  var_1 thread scripts\sp\anim::_id_1EEA(var_0, "elevator_npc01_idle");
  var_1 thread scripts\sp\anim::_id_1EEA(var_1, "elevator_npc01_idle");
  var_0 linkTo(level._id_603C);
  level._id_6048 = scripts\engine\utility::array_add(level._id_6048, var_0);
  var_0.seat = var_1;
  var_0 scripts\sp\utility::_id_F415(1);
  var_0 scripts\sp\utility::_id_F416(1);
  var_0 scripts\sp\utility::_id_51E1("combat");
  var_2 = randomfloatrange(1, 3);
  var_0 scripts\sp\utility::_id_7799(level.player, var_2, var_2);
}

_id_604B(var_0) {
  if(!isent(var_0))
    var_0 = getEnt(var_0, "targetname");

  if(!isDefined(var_0._id_9C9A)) {
    var_0._id_1FBB = "elevator_seat";
    var_0 scripts\sp\utility::_id_23B7();
    var_0._id_9C9A = 1;
  }

  if(!isDefined(level._id_6048))
    level._id_6048 = [];

  return var_0;
}

_id_5198() {
  var_0 = getEntArray("temp_elevator_defend_soldiers", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 delete();
  }
}

_id_10C2E() {
  _id_60CA();
  scripts\sp\maps\marsbase\marsbase_util::_id_107BE("seat_elevator_salter");
  scripts\sp\maps\marsbase\marsbase_util::_id_1065E("seat_elevator_brooks");
  scripts\sp\maps\marsbase\marsbase_util::_id_106D9("seat_elevator_ethan");
  scripts\sp\maps\marsbase\marsbase_util::_id_10766("seat_elevator_mccallum");
  scripts\sp\maps\marsbase\marsbase_util::_id_10722("s_elevator_griff_pos");
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_elevator_enter_player", "targetname"));
  level._id_2709 = 1;
  level thread _id_60D4();
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_4");
  level notify("loot_crate_aa1_cleanup");
  level notify("loot_crate_greenhouse_cleanup");
  level notify("loot_crate_aa2_cleanup");
  level notify("loot_crate_gate_cleanup");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("gain_access_complete");
}

_id_B1CD() {
  scripts\sp\utility::_id_2669("mars_elevator_enter");
  level thread _id_D847();
  thread _id_606C(level._id_2709);
  thread _id_60B2();
  scripts\engine\utility::flag_wait("elevator_enter_end");
}

_id_3B5E() {}

_id_60B2(var_0) {
  level endon("anim_done_elevator_rideup");
  var_1 = scripts\sp\utility::_id_107EA("spawner_elevator_outside_enemy_c8");
  var_1 scripts\sp\utility::_id_F3DD(48);
  var_1 scripts\sp\utility::_id_F3D5(var_1);
  scripts\sp\utility::_id_15F3("spawner_elevator_outside_enemy");
}

_id_607D() {
  var_0 = self;
  var_0._id_1FBB = "generic";
  level._id_19F0 = self;
  var_1 = "seat_elevator_gator";
  var_2 = "mount_elevator_gator";
  var_3 = "elevator_ride_wait_get_in";
  var_4 = "elevator_ride_wait_idle";
  var_5 = "getin_ally01";
  var_6 = "idle_ally01";
  var_1 = _id_604B(var_1);
  var_0 scripts\sp\maps\marsbase\marsbase_util::_id_B399(var_1);
  var_0.seat = var_1;
  var_0._id_BBC7 = getEnt(var_2, "targetname");
  var_0._id_BBC7._id_1FBB = "elevator_mount";
  var_0._id_BBC7 scripts\sp\utility::_id_23B7();
  var_0._id_BBC7._id_9C9A = 1;
  var_7 = [var_0.seat, var_0._id_BBC7];
  level._id_113D5 thread scripts\sp\anim::_id_1F2C(var_7, var_5);
  wait 0.1;

  foreach(var_9 in var_7)
  var_9 _meth_83A1();

  level._id_113D5 thread scripts\sp\anim::_id_1EC1(var_7, var_5);
  var_11 = scripts\engine\utility::getStruct("s_sceneref_elevator_hall_director", "targetname");
  var_11 scripts\sp\anim::_id_1EC3(var_0, "elevator_hall_director_enter");
  wait 0.1;
  var_11 thread scripts\sp\anim::_id_1EEA(var_0, "elevator_hall_director_idle");
  scripts\sp\utility::_id_127B3("trig_elevator_hall_director_enter");
  var_11 notify("stop_loop");
  var_0 notify("stop_loop");
  var_11 scripts\sp\anim::_id_1F35(self, "elevator_hall_director_enter");

  while(level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(var_0, 0.45, 1) || level.player scripts\sp\maps\marsbase\marsbase_util::_id_9BDD(var_0._id_BBC7, 0.45, 1))
    wait 0.1;

  level._id_113D5 thread scripts\sp\anim::_id_1F2C(var_7, var_5);
  level._id_113D5 scripts\sp\anim::_id_1F35(var_0, var_3);
  level._id_113D5 thread scripts\sp\anim::_id_1EE7(var_7, var_6);
  level._id_113D5 thread scripts\sp\anim::_id_1EEA(var_0, var_4);
  var_0 linkTo(level._id_603C);
}

_id_60C7() {
  level._id_60C5 = getEnt("seat_elevator_player", "targetname");
  level._id_60C5._id_1FBB = "elevator_seat";
  level._id_60C5 scripts\sp\utility::_id_23B7();
  level._id_113D5 thread scripts\sp\anim::_id_1F35(level._id_60C5, "elevator_player_get_in");
  level._id_60C2 = getEnt("seat_elevator_gator", "targetname");
  level._id_60C2._id_1FBB = "elevator_seat";
  level._id_60C2 scripts\sp\utility::_id_23B7();
  level._id_60A8 = getEnt("mount_elevator_gator", "targetname");
  level._id_60A8._id_1FBB = "elevator_mount";
  level._id_60A8 scripts\sp\utility::_id_23B7();
  level._id_113D5 thread scripts\sp\anim::_id_1F35(level._id_60A8, "getin_ally01");
  level._id_113D5 thread scripts\sp\anim::_id_1F35(level._id_60C2, "getin_ally01");
  wait 0.1;
  level._id_60C5 _meth_83A1();
  level._id_60A8 _meth_83A1();
  level._id_60C2 _meth_83A1();
  level._id_113D5 thread scripts\sp\anim::_id_1EC3(level._id_60C5, "elevator_player_get_in");
  level._id_113D5 thread scripts\sp\anim::_id_1EC3(level._id_60A8, "getin_ally01");
  level._id_113D5 thread scripts\sp\anim::_id_1EC3(level._id_60C2, "getin_ally01");
}

_id_F086() {
  thread _id_604C("kloos", "seat_elevator_marine02");
  thread _id_604C("elevator_crew03", "seat_elevator_marine03");
}

_id_606C(var_0) {
  if(!scripts\engine\utility::is_true(level._id_2712))
    level thread _id_60CB(1);

  level thread _id_F086();
  thread elevator_enter_sequence_sun_monitor();
  thread _id_604C("elevator_crew12", "seat_elevator_marine12");
  thread _id_604C("elevator_igc_crew_ship_mal", "seat_elevator_marine13");
  var_1 = scripts\sp\maps\marsbase\marsbase_util::_id_10711("elevator_igc_flight_deck_director", "continue_elevator_enter_marine04");
  var_2 = scripts\sp\maps\marsbase\marsbase_util::_id_10711("elevator_igc_crew_ship_fem", "continue_elevator_enter_marine06");
  var_3 = getEnt("seat_elevator_marine04", "targetname");
  var_4 = getEnt("seat_elevator_marine06", "targetname");
  var_3 scripts\sp\anim::_id_1EC3(var_1, "elevator_npc01_get_in");
  var_4 scripts\sp\anim::_id_1EC3(var_2, "elevator_npc01_get_in");
  var_5 = getEnt("elevator_crew_get_in_seats", "targetname");
  var_5 waittill("trigger");
  _id_608C("elevator_sunfake_on");

  foreach(var_7 in level._id_B38D) {
    if(var_7.model == "space_elev_ext_pmars_wall_window") {
      var_7 delete();
      break;
    }
  }

  thread _id_6049(var_1, "seat_elevator_marine04");
  wait 1.0;
  thread _id_6049(var_2, "seat_elevator_marine06");
  var_9 = scripts\engine\utility::getStruct("interact_seat_player", "targetname");
  thread _id_60C4();
  var_9 _id_0E46::_id_48C4(undefined, undefined, &"MARSBASE_ELEVATOR_SEAT", 30, 1600, 48, 0, 0);
  var_9 waittill("trigger");
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("space_elevator_complete");
  level notify("player_get_in_seat");
  level thread _id_607B();
  level thread _id_5D4D();
  settransientvisibility("marsbase_combat_pre_elevator_tr", 0);
  thread scripts\sp\utility::_id_1264E("marsbase_combat_pre_elevator_tr");
  setsuncolorandintensity(0);
  level.player disableweapons();
  scripts\sp\player_rig::get_player_score();
  level._id_D267 hide();
  level._id_D267 dontinterpolate();
  level._id_60C5 scripts\sp\anim::_id_1EC3(level._id_D267, "elevator_player_get_in");
  level.player _meth_823C(level._id_D267, "TAG_PLAYER", 1.0, 0.5, 0.5);
  wait 1.0;
  level._id_D267 show();
  level._id_60C5 thread scripts\sp\anim::_id_1F35(level._id_D267, "elevator_player_get_in");
  level thread _id_60C6();
  level._id_113D5 scripts\sp\anim::_id_1F35(level._id_60C5, "elevator_player_get_in");
  level notify("salter_clear_nag_idle");
  _id_6091();
  wait 2.0;

  foreach(var_11 in level._id_6048) {
    if(isDefined(var_11) && isalive(var_11))
      var_11 delete();
  }

  scripts\engine\utility::flag_set("elevator_enter_end");
}

elevator_enter_sequence_sun_monitor() {
  level endon("player_get_in_seat");
  var_0 = 1;

  for(;;) {
    if(level.player.origin[1] > 28992) {
      if(var_0) {
        var_0 = 0;
        setsuncolorandintensity(0);
      }
    } else if(!var_0) {
      var_0 = 1;
      setsuncolorandintensity(1);
    }

    wait 1.0;
  }
}

_id_60C4() {
  level endon("player_get_in_seat");
  wait 7.0;
  level._id_EA2C scripts\sp\utility::_id_10346("marsbase_slt_buckleupreyeswe");
}

_id_60C6() {
  level waittill("plr_seat_lock");
  level.player playRumbleOnEntity("damage_heavy");
}

_id_606B(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct("elevator_runner_goal_new", "targetname");
  var_0 scripts\sp\utility::_id_F3DD(64);
  var_0 scripts\sp\utility::_id_F3DC(var_2.origin);
  var_0 waittill("goal");
  thread _id_604A(var_0, var_1);
}

_id_60CB(var_0) {
  if(!scripts\engine\utility::is_true(level._id_2712)) {
    level._id_2712 = 1;

    if(!isDefined(level._id_603C))
      level._id_603C = getEnt("elevator_cab_clip", "targetname");

    if(!isDefined(level._id_EA2C)) {
      scripts\sp\maps\marsbase\marsbase_util::_id_107BE("seat_elevator_salter");
      scripts\sp\maps\marsbase\marsbase_util::_id_1065E("seat_elevator_brooks");
      scripts\sp\maps\marsbase\marsbase_util::_id_106D9("seat_elevator_ethan");
      scripts\sp\maps\marsbase\marsbase_util::_id_10766("seat_elevator_mccallum");
      scripts\sp\maps\marsbase\marsbase_util::_id_10722("s_elevator_griff_pos");
    }

    scripts\sp\maps\marsbase\marsbase_util::_id_10652("seat_elevator_gator");
    level._id_1915 = level._id_2BFF;
    level._id_1915._id_1FBB = "generic";
    var_1 = scripts\engine\utility::getStruct("s_exitdoor_ref", "targetname");

    if(isDefined(var_1))
      var_1 notify("stop_loop");

    level._id_EA2C notify("stop_loop");
    thread _id_60C3(level._id_EA2C, "seat_elevator_salter", "mount_elevator_salter", undefined, "elevator_ride_wait_idle", undefined, "idle_xo");
    thread _id_60C3(level._id_6754, "seat_elevator_ethan", "mount_elevator_ethan", undefined, "elevator_ride_wait_idle", undefined, "idle_c6i");
    thread _id_60C3(level._id_B4F1, "seat_elevator_mccallum", "mount_elevator_mccallum", undefined, "elevator_ride_wait_idle", undefined, "idle_eng");

    if(!scripts\engine\utility::is_true(var_0)) {
      thread _id_60C3(level._id_30F6, "seat_elevator_brooks", "mount_elevator_brooks", undefined, "elevator_ride_wait_idle", undefined, "idle_mr1");
      thread _id_60C3(level._id_1915, "seat_elevator_gator", "mount_elevator_gator", undefined, "elevator_ride_wait_idle", undefined, "idle_ally01");
    } else {
      thread _id_60C3(level._id_30F6, "seat_elevator_brooks", "mount_elevator_brooks", "elevator_ride_wait_get_in", "elevator_ride_wait_idle", "getin_mr1", "idle_mr1");
      thread _id_60C3(level._id_1915, "seat_elevator_gator", "mount_elevator_gator", "elevator_ride_wait_get_in", "elevator_ride_wait_idle", "getin_ally01", "idle_ally01");
    }

    level._id_EA2C linkTo(level._id_603C);
    level._id_6754 linkTo(level._id_603C);
    level._id_30F6 linkTo(level._id_603C);
    level._id_B4F1 linkTo(level._id_603C);
    level._id_1915 linkTo(level._id_603C);
    scripts\sp\utility::_id_127AE("elevator_crew_get_in_seats", "targetname");
  }
}

_id_60D4() {
  thread _id_60D3(level._id_30F6, "seat_elevator_brooks", "mount_elevator_brooks");
  thread _id_60D3(level._id_6754, "seat_elevator_ethan", "mount_elevator_ethan");
  thread _id_60D3(level._id_B4F1, "seat_elevator_mccallum", "mount_elevator_mccallum");
  thread _id_60D3(level._id_EA2C, "seat_elevator_salter", "mount_elevator_salter");
}

_id_60D3(var_0, var_1, var_2) {
  var_1 = _id_604B(var_1);
  var_0 scripts\sp\maps\marsbase\marsbase_util::_id_B399(var_1);
  var_0.seat = var_1;
  var_0._id_BBC7 = getEnt(var_2, "targetname");
  var_0._id_BBC7._id_1FBB = "elevator_mount";
  var_0._id_BBC7 scripts\sp\utility::_id_23B7();
  var_0._id_BBC7._id_9C9A = 1;
  level._id_113D5 thread scripts\sp\anim::_id_1EC3(var_0, "elevator_rideup");
}

_id_60C3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_1)) {
    _id_60D3(var_0, var_1, var_2);
    var_0 linkTo(level._id_603C);
  }

  if(!isDefined(var_4))
    level._id_113D5 thread scripts\sp\anim::_id_1EC3(var_0, "elevator_rideup");
  else {
    var_7 = [var_0.seat, var_0._id_BBC7];

    if(isDefined(var_3)) {
      level._id_113D5 thread scripts\sp\anim::_id_1EC1(var_7, var_5);
      level._id_113D5 thread scripts\sp\anim::_id_1EC3(var_0, var_3);
      scripts\sp\utility::_id_127B3("elevator_heros_get_in_seats");
      level._id_113D5 thread scripts\sp\anim::_id_1F2C(var_7, var_5);
      level._id_113D5 scripts\sp\anim::_id_1F35(var_0, var_3);
      level._id_113D5 thread scripts\sp\anim::_id_1EE7(var_7, var_6);
      level._id_113D5 thread scripts\sp\anim::_id_1EEA(var_0, var_4);
    } else {
      level._id_113D5 thread scripts\sp\anim::_id_1EC3(var_0, "elevator_rideup");
      scripts\sp\utility::_id_127B3("elevator_heros_get_in_seats");

      if(var_0 != level._id_EA2C) {
        level._id_113D5 thread scripts\sp\anim::_id_1EEA(var_0, var_4);

        if(isDefined(var_6))
          level._id_113D5 thread scripts\sp\anim::_id_1EE7(var_7, var_6);
      } else
        level._id_EA2C thread _id_60C8();
    }
  }

  var_0 scripts\sp\utility::_id_F415(1);
  var_0 scripts\sp\utility::_id_F416(1);
}

_id_60C8() {
  level endon("salter_clear_nag_idle");
  var_0 = 19;
  var_1 = spawnStruct();
  var_1.origin = level._id_113D5.origin;
  var_1.angles = level._id_113D5.angles;
  var_2 = "elevator_ride_wait_idle";
  var_3 = "idle_xo";
  var_4 = "elevator_ride_wait_nag";
  var_5 = "nag_xo";
  var_6 = [self.seat, self._id_BBC7];

  while(!scripts\engine\utility::flag("elevator_enter_end")) {
    var_1 notify("stop_loop");
    level notify("xo_nag");
    level._id_113D5 thread scripts\sp\anim::_id_1F2C(var_6, var_5);
    level._id_113D5 scripts\sp\anim::_id_1F35(self, var_4);
    var_1 thread scripts\sp\anim::_id_1EE7(var_6, var_3);
    var_1 thread scripts\sp\anim::_id_1EEA(self, var_2);
    wait(var_0);
  }
}

_id_10C32() {
  _id_60CA();
  _id_6091();
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_4");
  thread _id_60B2(1);
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("space_elevator_complete");
}

_id_B1D1() {
  scripts\sp\utility::_id_2669("mars_elevator_load");
  thread _id_6092();
  level notify("dropship_takeoff");
  scripts\engine\utility::flag_wait("elevator_load_end");
}

_id_D847() {
  wait 1;
}

_id_3B61() {}

_id_6053() {}

_id_BE0E(var_0, var_1) {
  if(isDefined(var_1))
    thread scripts\sp\utility::_id_E7C9(var_1, var_0);
  else
    thread scripts\sp\utility::_id_E7C9(1, var_0);

  wait(var_0);
  thread scripts\sp\utility::_id_E7C7(var_0);
  wait 0.1;
}

_id_6092() {
  level thread _id_60C1();
  var_0 = scripts\sp\utility::_id_7C23();
  var_0 scripts\sp\utility::_id_F581(1);
  var_1 = scripts\engine\utility::getStruct("elevator_cab_launch01", "targetname");
  var_2 = scripts\engine\utility::getStruct("elevator_cab_launch02", "targetname");
  screenshake(level.player.origin, 3.5, 3.5, 1.5, 0.5, -1, -1, 0, 12);
  var_0 thread _id_BE0E(0.5, 1.5);
  level._id_603C playSound("mars_base_elevator_start");
  level._id_603C playLoopSound("mars_base_elevator_loop");
  level._id_603C moveTo(var_2.origin, 7.5, 4.5, 2);
  level._id_603C waittill("movedone");
  level._id_603C playSound("mars_base_elevator_stop");
  screenshake(level.player.origin, 5, 5, 2.5, 1, -1, -1, 0, 12);
  var_0 thread _id_BE0E(0.5, 3);
  wait 1.0;
  level._id_603C stoploopsound();
  scripts\engine\utility::flag_set("elevator_load_end");
}

_id_608D() {
  var_0 = scripts\engine\utility::getStructArray("elevator_fx_active", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
    var_3 linkTo(level._id_603C);

    if(var_2._id_EE52 == "corner_blue") {
      playFXOnTag(level._effect["vfx_mars_elevator_interior_light_blue"], var_3, "tag_origin");
      var_3 thread _id_603B();
    }
  }
}

_id_603B() {
  level waittill("kill_elevator_light");
  self delete();
}

_id_608F() {
  level notify("kill_elevator_light");
  var_0 = scripts\engine\utility::getStructArray("elevator_fx_active", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
    var_3 linkTo(level._id_603C);

    if(var_2._id_EE52 == "corner_red")
      var_3 thread _id_60BD();
  }
}

_id_60BD() {
  playFXOnTag(level._effect["vfx_mars_elevator_interior_light_red_flash"], self, "tag_origin");
  level._id_603C waittill("movedone");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_mars_elevator_interior_light_red_flash"), self, "tag_origin");
  playFXOnTag(level._effect["vfx_mars_elevator_interior_light_red"], self, "tag_origin");
}

_id_10C31() {
  _id_60CA();
  _id_6091();
  _id_60CB();
  level thread _id_5D4D();
  var_0 = scripts\engine\utility::getStruct("elevator_cab_launch02", "targetname");
  level._id_113D5._id_13126 = level._id_113D5.origin - level._id_603C.origin;
  level._id_603C moveTo(var_0.origin, 0.1, 0.05, 0.05);
  level._id_603C waittill("movedone");
  level._id_113D5.origin = level._id_603C.origin + level._id_113D5._id_13126;
  level thread _id_60C1(1);
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5435();
  level notify("dropship_takeoff");
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_3");
  scripts\sp\maps\marsbase\marsbase_code::_id_DFB4("aa_gun_4");
  thread _id_60B2(1);
  scripts\sp\maps\marsbase\marsbase_code::_id_C2AC("space_elevator_complete");
}

_id_B1D0() {
  scripts\sp\utility::_id_2669("mars_elevator_launch");
  thread _id_608B();
  level waittill("anim_done_elevator_rideup");
  scripts\sp\utility::_id_BF95();
}

_id_3B60() {}

_id_60C1(var_0) {
  if(!scripts\engine\utility::is_true(level._id_270B)) {
    level._id_270B = 1;
    level._id_113D5 notify("stop_loop");
    level._id_113D5 thread scripts\sp\anim::_id_1F2C([level._id_30F6.seat, level._id_30F6._id_BBC7], "rideup_mr1");
    level._id_113D5 thread scripts\sp\anim::_id_1F2C([level._id_EA2C.seat, level._id_EA2C._id_BBC7], "rideup_xo");
    level._id_113D5 thread scripts\sp\anim::_id_1F2C([level._id_B4F1.seat, level._id_B4F1._id_BBC7], "rideup_eng");
    level._id_113D5 thread scripts\sp\anim::_id_1F2C([level._id_6754.seat, level._id_6754._id_BBC7], "rideup_c6i");

    if(isDefined(level._id_1915)) {
      level._id_113D5 thread scripts\sp\anim::_id_1F35(level._id_6754.seat, "rideup_c6i");
      level._id_113D5 thread scripts\sp\anim::_id_1F35(level._id_1915, "elevator_rideup");
    }

    if(!scripts\engine\utility::is_true(level._id_8604._id_2707))
      var_1 = [level._id_30F6, level._id_EA2C, level._id_B4F1, level._id_6754, level._id_8604];
    else
      var_1 = [level._id_30F6, level._id_EA2C, level._id_B4F1, level._id_6754];

    level._id_113D5 scripts\sp\anim::_id_1F2C(var_1, "elevator_rideup");
  }
}

_id_607B() {
  level._id_8604 notify("stop_loop");
  level._id_8604._id_2707 = 1;
  level thread scripts\sp\maps\marsbase\marsbase_dialogue::_id_5435();
  level._id_113D5 scripts\sp\anim::_id_1F35(level._id_8604, "elevator_rideup");
  var_0 = getnodearray("hill_gate_c12_walk_nodes", "targetname");
  level._id_8604 _meth_82EE(scripts\engine\utility::random(var_0));
  level._id_8604 scripts\sp\utility::_id_F3BC();
  level._id_8604 scripts\sp\utility::_id_F3DD(128);
}

_id_608B() {
  level.player playSound("marsbase_grf_death");
  level._id_603C playSound("mars_base_elevator_change");
  level._id_603C playLoopSound("mars_base_elevator_loop");
  wait 0.25;
  var_0 = scripts\sp\utility::_id_7C23();
  var_0 scripts\sp\utility::_id_F581(1);
  var_0 thread _id_BE0E(2.0);
  level._id_603C movez(15000, 15, 8, 0);
  level thread _id_6094();
  level.player _meth_82C0("marsbase_elevator_fadeout_gunfire", 2.0);
  wait 2.0;
  level.player playSound("scn_ship_launch_impt_shake");
  var_0 scripts\sp\utility::_id_E7C9(0.4, 3.0);
  thread _id_608A();
  level.player scripts\engine\utility::delaycall(2.0, ::_meth_82C0, "marsbase_elevator_fadeout_all", 1.0);
  wait 5.0;
  playFX(level._effect["elevator_clouds"], level._id_603D.origin, anglesToForward(level._id_603D.angles), anglestoup(level._id_603D.angles));
  var_0 scripts\sp\utility::_id_E7C7(0.1);
  level waittill("anim_done_elevator_rideup");
  level._id_603C stoploopsound();
  scripts\engine\utility::flag_set("elevator_launch_end");
}

_id_608A() {
  level._id_6040.origin = level._id_603F.origin;

  for(;;) {
    level._id_6040 dontinterpolate();
    level._id_6040.origin = level._id_603F.origin;
    wait 0.1;
    level._id_6040 movez(-500, 0.75, 0.05, 0.05);
    wait 0.75;
  }
}

_id_5D4D() {
  wait 2.0;

  for(var_0 = 1; var_0 <= 6; var_0++) {
    var_1 = "trig_elevator_droppod_0" + var_0;
    scripts\sp\utility::_id_15F5(var_1);
    wait(randomfloatrange(0.9, 1.75));
  }
}

_id_5D48(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    if(issubstr(var_3.classname, "droppod"))
      var_3 scripts\engine\utility::delaythread(randomfloatrange(0, 2), scripts\sp\utility::_id_10808);
  }
}

_id_11673() {}