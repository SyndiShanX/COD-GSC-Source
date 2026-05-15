/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\carrier_deck_transition.gsc
********************************************/

deck_transition_pre_load() {
  common_scripts\utility::flag_init("deck_transition");
  common_scripts\utility::flag_init("deck_transition_finished");
  common_scripts\utility::flag_init("rear_elevator_raised");
  common_scripts\utility::flag_init("deck_clear");
  common_scripts\utility::flag_init("hesh_talk_kick");
  common_scripts\utility::flag_init("player_rush");
  common_scripts\utility::flag_init("enemy_running");
  common_scripts\utility::flag_init("hesh_talking_finished");
  common_scripts\utility::flag_init("picked_up_control_pad");
  common_scripts\utility::flag_init("attack_heli_death1");
  common_scripts\utility::flag_init("activate_riders");
  common_scripts\utility::flag_init("attack_heli_death2");
  common_scripts\utility::flag_init("attack_heli_exit");
  common_scripts\utility::flag_init("run_carry_anim");
  common_scripts\utility::flag_init("carrier_anim_start");
  common_scripts\utility::flag_init("aud_osprey_taxi");
  common_scripts\utility::flag_init("aud_osprey_takeoff");
  common_scripts\utility::flag_init("cannon_fodder");
  common_scripts\utility::flag_init("taxing_osprey_move_start");
  common_scripts\utility::flag_init("control_pad_objective");
  common_scripts\utility::flag_init("hesh_run");
  common_scripts\utility::flag_init("trans_boom");
  common_scripts\utility::flag_init("trans_talker_run");
  common_scripts\utility::flag_init("grape_ready_for_deck_trans");
  common_scripts\utility::flag_init("grape_jumped_off_cart");
  common_scripts\utility::flag_init("dt_osprey_go");
  common_scripts\utility::flag_init("dt_osprey_can_delete");
  precachestring(&"CARRIER_TAKE_DATAPAD_CONSOLE");
  precachestring(&"CARRIER_TAKE_DATAPAD");
  precachemodel("weapon_remote_tablet_obj");
  precachemodel("weapon_remote_tablet");
  precachemodel("viewmodel_remote_tablet_crr");
  thread maps\carrier_code::setup_rear_elevator();
  level.deck_transition_cleanup_vol = getent("deck_transition_cleanup_vol", "targetname");
  var_0 = getent("heli_elevator_fake", "script_noteworthy");
  var_0 maps\_utility::hide_entity();
}

setup_deck_transition() {
  level.start_point = "deck_transition";
  maps\carrier_code::setup_common();
  maps\carrier_code::spawn_allies();
  thread maps\carrier_audio::aud_check("deck_transition");
  maps\_utility::set_team_bcvoice("allies", "delta");
  maps\_utility::battlechatter_on("allies");
  maps\_utility::flavorbursts_on("allies");
  level.hesh maps\_utility::set_ignoreme(1);
  level.hesh maps\_utility::set_ignoreall(1);
  common_scripts\utility::flag_set("deck_combat_finished");
  common_scripts\utility::flag_set("enemy_running");
  thread carried_grape();
  thread carrier_grape();
  var_0 = getent("heli_elevator_fake", "script_noteworthy");
  var_0 maps\_utility::show_entity();
  thread checkpoint_osprey();
  thread taxing_osprey_cart_drone_anims();
  thread trans_talker();
  var_1 = getent("water_wake_intro", "targetname");
  var_1 delete();
  var_2 = getent("blast_shield1_clip", "targetname");
  var_2 maps\_utility::show_entity();
  var_3 = getent("blast_shield2_clip", "targetname");
  var_3 maps\_utility::show_entity();
  var_4 = maps\carrier_code::array_spawn_targetname_allow_fail("trans_orange_allies", 1);

  foreach(var_6 in var_4) {
    var_6 thread maps\_utility::replace_on_death();
  }

  var_8 = maps\carrier_code::array_spawn_targetname_allow_fail("trans_red_allies", 1);

  foreach(var_6 in var_8) {
    var_6 thread maps\_utility::replace_on_death();
  }

  var_11 = maps\carrier_code::array_spawn_targetname_allow_fail("trans_purple_allies", 1);

  foreach(var_6 in var_11) {
    var_6 thread maps\_utility::replace_on_death();
  }

  maps\_utility::activate_trigger_with_targetname("ally_transition_pos_move");
}

begin_deck_transition() {
  common_scripts\utility::flag_set("deck_transition");
  thread wait_for_deck_transition_cleanup();
  common_scripts\utility::flag_wait("rear_elevator_raised");
  thread heli_attack1();
  thread enemy_final_wave_run();
  thread enemies_final_move();
  common_scripts\utility::flag_wait("enemy_running");
  wait 1;
  common_scripts\utility::flag_set("deck_clear");
  level.player_trans_repulsor = missile_createrepulsorent(level.player, 5000, 2000);
  wait 0.5;
  common_scripts\utility::flag_set("obj_deck_combat_complete");
  thread maps\carrier::obj_regroup_with_hesh();
  thread run_deck_transition();
  wait 0.5;
  thread ally_color_node_movement();
  wait 2;
  maps\_utility::activate_trigger_with_targetname("ally_transition_pos_move");
  maps\_utility::activate_trigger_with_targetname("blue_ally_move_trigger");
  common_scripts\utility::flag_wait("picked_up_control_pad");
  missile_deleteattractor(level.player_trans_repulsor);
  var_0 = common_scripts\utility::array_combine(maps\_utility::get_force_color_guys("allies", "r"), maps\_utility::get_force_color_guys("allies", "p"));
  common_scripts\utility::array_add(maps\_utility::get_force_color_guys("allies", "o"), var_0);

  foreach(var_2 in var_0) {
    var_2 maps\_utility::set_ignoreall(1);
  }

  common_scripts\utility::flag_set("obj_regroup_with_hesh_complete");
}

enemies_final_move() {
  common_scripts\utility::flag_wait("wave3_heli2_unloaded");
  var_0 = getent("final_enemy_vol", "targetname");
  var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");
  thread maps\carrier_code::ai_array_killcount_flag_set(var_1, var_1.size - 3, "player_rush");
}

enemy_final_wave_run() {
  common_scripts\utility::flag_wait("player_rush");
  var_0 = getent("final_enemy_vol", "targetname");
  var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");
  var_2 = getent("run_to_vol", "targetname");

  foreach(var_4 in var_1) {
    if(issubstr(var_4.model, "shotgun")) {
      return;
    }
    var_4 maps\_utility::set_ignoresuppression(1);
    var_4 thread maps\carrier_code::ignore_everything(1);
    var_4 setgoalvolumeauto(var_2);
  }

  common_scripts\utility::flag_set("enemy_running");
}

random_enemy_kill() {
  common_scripts\utility::flag_wait("enemy_running");
  var_0 = getent("final_enemy_vol", "targetname");
  var_1 = var_0 maps\_utility::get_ai_touching_volume("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_3 thread maps\ss_util::fake_death_bullet();
      wait(randomintrange(2, 4));
    }
  }
}

catchup_deck_transition() {
  thread deck_combat_cleanup();
  thread deck_transition_cleanup();
  var_0 = getent("heli_elevator_fake", "script_noteworthy");
  var_0 delete();
  var_1 = getent("osrpey_control_pad", "targetname");
  var_1 delete();
}

run_deck_transition() {
  level.hesh maps\_utility::enable_cqbwalk();
  level.hesh maps\_utility::set_ignoreme(1);
  level.hesh maps\_utility::set_ignoreall(1);
  level.hesh maps\_utility::set_ignoresuppression(0);
  level.player maps\_utility::set_ignoreme(1);
  thread hesh_talking_to_grape();
  thread background_event_setup();
  level.hesh maps\_utility::smart_dialogue("carrier_hsh_regrouponme");
}

deck_combat_cleanup() {
  var_0 = getEntArray("wave1_dropoff_guys1", "script_noteworthy");
  var_1 = getEntArray("wave1_dropoff_guys2", "script_noteworthy");
  var_2 = getEntArray("wave2_dropoff_guys1", "script_noteworthy");
  var_3 = getEntArray("wave2_dropoff_guys3", "script_noteworthy");
  var_4 = getEntArray("final_wave_guys2", "script_noteworthy");
  var_5 = getEntArray("final_wave_guys4", "script_noteworthy");
  var_6 = getEntArray("wave1_heli1", "targetname");
  var_7 = getEntArray("wave1_heli2", "targetname");
  var_8 = getEntArray("wave1_heli_death", "targetname");
  var_9 = getEntArray("wave2_heli1", "targetname");
  var_10 = getEntArray("wave2_heli2", "targetname");
  var_11 = getEntArray("wave3_heli1", "targetname");
  maps\_utility::array_delete(var_0);
  maps\_utility::array_delete(var_1);
  maps\_utility::array_delete(var_2);
  maps\_utility::array_delete(var_3);
  maps\_utility::array_delete(var_4);
  maps\_utility::array_delete(var_5);
  maps\_utility::array_delete(var_6);
  maps\_utility::array_delete(var_7);
  maps\_utility::array_delete(var_8);
  maps\_utility::array_delete(var_9);
  maps\_utility::array_delete(var_10);
  maps\_utility::array_delete(var_11);

  foreach(var_13 in getEntArray("deck_combat_ally", "script_noteworthy")) {
    if(isspawner(var_13)) {
      var_13 delete();
    }
  }

  foreach(var_13 in getEntArray("deck_combat_ally", "script_noteworthy")) {
    if(isspawner(var_13)) {
      var_13 delete();
    }
  }

  getent("low_flyby_ally", "targetname") delete();
  maps\_utility::array_delete(getEntArray("jet_dogfighters_flyby", "targetname"));
}

wait_for_deck_transition_cleanup() {
  common_scripts\utility::flag_wait("defend_zodiac_wave_01");
  wait 1;
  thread deck_transition_cleanup();
}

deck_transition_cleanup() {
  maps\_utility::array_delete(getEntArray("trans_purple_allies", "targetname"));
  maps\_utility::array_delete(getEntArray("fast_flyby_jets", "targetname"));
  var_0 = ["flyby_missile_attack1", "flyby_missile_attack2", "trans_gun_run_heli1", "trans_attack_heli1", "trans_attack_heli2", "trans_attack_heli3"];

  foreach(var_2 in var_0) {
    getent(var_2, "targetname") delete();
  }

  maps\_utility::array_delete(getEntArray("trans_attack_heli_riders", "script_noteworthy"));
}

hesh_regroup_nag_vo() {
  level endon("hesh_talk_kick");
  level.player endon("hesh_talk_kick");
  wait 15;
  var_0 = ["carrier_hsh_logangetoverhere", "carrier_hsh_moveyourasslogan"];
  var_1 = randomint(var_0.size);

  for(;;) {
    level.hesh maps\_utility::smart_dialogue(var_0[var_1]);
    var_1++;

    if(var_1 >= var_0.size) {
      var_1 = 0;
    }

    wait(randomfloatrange(6, 10));
  }
}

bring_up_osprey() {
  if(level.start_point != "deck_transition") {
    level.elevator_guys = maps\carrier_code::array_spawn_targetname_allow_fail("redshirts_elevator_rear", 1);

    foreach(var_1 in level.elevator_guys) {
      if(isDefined(var_1) && isalive(var_1)) {
        var_1 thread maps\_utility::magic_bullet_shield();
        var_1 thread maps\_utility::replace_on_death();
      }
    }

    wait 0.5;
  }

  if(level.start_point != "deck_transition") {
    thread maps\carrier_code::raise_rear_elevator();
  }

  common_scripts\utility::flag_wait("rear_elevator_raised");
  level.elevator_osprey_clip disconnectpaths();
  thread taxing_osprey();
  common_scripts\utility::flag_wait("dc_wave2_start");

  if(level.start_point != "deck_transition") {
    foreach(var_1 in level.elevator_guys) {
      if(isalive(var_1) && isDefined(var_1.magic_bullet_shield)) {
        var_1 thread maps\_utility::stop_magic_bullet_shield();
      }
    }
  }
}

setup_taxing_osprey() {
  var_0 = common_scripts\utility::getstruct("taxing_osprey_ref", "targetname");
  var_1 = getent("heli_elevator_fake", "script_noteworthy");
  var_1 maps\_utility::show_entity();
  var_1.animname = "taxing_osprey";
  var_1 maps\_anim::setanimtree();
  var_0 maps\_anim::anim_first_frame_solo(var_1, "taxing_osprey_move_start");

  if(level.rear_elevator.lowered) {
    var_1.origin = (var_1.origin[0], var_1.origin[1], var_1.origin[2] - level.rear_elevator.height);
  }

  common_scripts\utility::waitframe();
  common_scripts\utility::waitframe();
  var_1 linkto(level.rear_elevator);
}

taxing_osprey() {
  common_scripts\utility::flag_set("cannon_fodder");
  var_0 = common_scripts\utility::getstruct("taxing_osprey_ref", "targetname");
  var_1 = getent("heli_elevator_fake", "script_noteworthy");
  var_1.animname = "taxing_osprey";
  var_1 maps\_anim::setanimtree();
  var_2 = getent("taxing_osprey_clip", "targetname");
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  var_2 linkto(var_1, "tag_body", (-75, 0, -125), (0, 0, 0));
  level.elevator_osprey_clip = var_2;
  var_0 maps\_anim::anim_single_solo(var_1, "taxing_osprey_move_start");
  common_scripts\utility::flag_set("aud_osprey_taxi");
  thread random_enemy_kill();
  thread jet_attack();
  badplace_delete("badplace_rear_elevator");

  if(!common_scripts\utility::flag("hesh_talk_kick")) {
    var_0 thread maps\_anim::anim_loop_solo(var_1, "taxing_osprey_move_loop");
  }

  common_scripts\utility::flag_wait("hesh_talk_kick");
  common_scripts\utility::flag_set("taxing_osprey_move_start");
  var_0 notify("stop_loop");
  level.elevator_osprey_clip connectpaths();
  var_3 = [];
  var_3[0] = maps\_utility::spawn_targetname("taxing_grape_osprey1");
  var_3[0].animname = "taxi_grape_3";
  var_3[0] maps\_utility::gun_remove();
  var_3[0] thread maps\_utility::magic_bullet_shield();
  var_3[1] = maps\_utility::spawn_targetname("taxing_grape_osprey2");
  var_3[1].animname = "taxi_grape_4";
  var_3[1] maps\_utility::gun_remove();
  var_3[1] thread maps\_utility::magic_bullet_shield();
  thread run_osprey_takeoff();
  var_0 thread maps\_anim::anim_single(var_3, "taxing_osprey_move");
  var_0 maps\_anim::anim_single_solo(var_1, "taxing_osprey_move_finish");
  common_scripts\utility::flag_set("dt_osprey_go");

  if(isDefined(var_3[0]) && isalive(var_3[0])) {
    var_3[0] maps\_utility::stop_magic_bullet_shield();
    var_3[0] delete();
  }

  if(isDefined(var_3[1]) && isalive(var_3[1])) {
    var_3[1] maps\_utility::stop_magic_bullet_shield();
    var_3[1] delete();
  }
}

#using_animtree("generic_human");

taxing_osprey_cart_drone_anims() {
  var_0 = maps\_utility::spawn_targetname("taxing_grape_cart_driver");
  var_0.animname = "taxi_grape_2";
  var_0 thread maps\_utility::magic_bullet_shield(1);
  var_0 maps\_utility::gun_remove();
  var_1 = common_scripts\utility::getstruct("taxing_osprey_ref", "targetname");
  var_2 = getent("depth_charge_cart", "targetname");
  var_3 = getent("depth_charge_cart_clip", "targetname");
  var_4 = getent("taxing_depth_charge_barrels", "targetname");
  var_5 = getent("taxing_depth_charge_barrels_clip", "targetname");
  var_5 linkto(var_4);
  var_3 linkto(var_2);
  var_6 = maps\_utility::spawn_anim_model("taxing_cart");
  var_7 = var_6 gettagorigin("j_prop_1");
  var_8 = var_6 gettagangles("j_prop_1");
  var_2.origin = var_7;
  var_2.angles = var_8;
  var_9 = var_6 gettagorigin("j_prop_2");
  var_10 = var_6 gettagangles("j_prop_2");
  var_4.origin = var_9;
  var_4.angles = var_10;
  var_2 linkto(var_6, "j_prop_1");
  var_4 linkto(var_6, "j_prop_2");
  var_11 = [var_6];
  var_1 thread maps\_anim::anim_loop_solo(var_0, "taxing_cart_move_loop", "stop_grape_loop");
  var_1 thread maps\_anim::anim_first_frame(var_11, "taxing_cart_move");
  common_scripts\utility::flag_wait("taxing_osprey_move_start");
  var_1 notify("stop_grape_loop");
  var_1 notify("stop_loop");
  thread maps\carrier_audio::aud_carr_osprey_doors();
  thread maps\carrier_audio::aud_carr_osprey_loader(var_2);
  var_11 = [var_0, var_6];
  var_1 thread maps\_anim::anim_single(var_11, "taxing_cart_move");
  thread cart_player_kill_volume();
  var_6 waittillmatch("single anim", "end");
  var_3 disconnectpaths();
  var_0.animname = "generic";
  var_0.runanim = maps\_utility::getgenericanim("unarmed_run");
  var_0.target = "taxing_cart_driver_path";
  var_0 thread maps\_drone::drone_move();
  var_0.idleanim = % unarmed_cowercrouch_idle;
  var_0 thread maps\carrier_code::safe_delete_drone(1500);
}

osprey_control_pad() {
  var_0 = getent("osrpey_control_pad", "targetname");
  var_0 maps\_utility::glow();
  var_1 = getent("osprey_pad_player_trigger", "targetname");
  var_1 setcursorhint("HINT_NOICON");

  if(level.player common_scripts\utility::is_player_gamepad_enabled()) {
    var_1 sethintstring(&"CARRIER_TAKE_DATAPAD_CONSOLE");
  } else {
    var_1 sethintstring(&"CARRIER_TAKE_DATAPAD");
  }

  maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_1, var_0, cos(25), 0, 1);
  thread maps\carrier_defend_zodiac::run_jet_takeoff();
  var_0 maps\_utility::stopglow();
  common_scripts\utility::flag_set("picked_up_control_pad");
  thread maps\carrier_audio::aud_carr_pickup_osprey_control();
  var_0 delete();
  level.player thread maps\carrier_depth_charge::depth_charge_give_device();
}

opsrey_control_nag_vo() {
  level endon("picked_up_control_pad");
  level.player endon("picked_up_control_pad");
  wait 20;
  var_0 = ["carrier_hsh_pickupthecontrol", "carrier_hsh_grabthatcontrolrig"];
  var_1 = randomint(var_0.size);

  for(;;) {
    level.hesh maps\_utility::smart_dialogue(var_0[var_1]);
    var_1++;

    if(var_1 >= var_0.size) {
      var_1 = 0;
    }

    wait(randomfloatrange(5, 8));
  }
}

run_osprey_takeoff() {
  level.heli_elevator = maps\_vehicle::spawn_vehicle_from_targetname("heli_elevator");
  level.heli_elevator.godmode = 1;
  level.heli_elevator hide();
  level.heli_elevator thread osprey_delete_watcher();
  var_0 = getent("heli_elevator_fake", "script_noteworthy");
  common_scripts\utility::flag_wait("dt_osprey_go");

  if(isDefined(level.heli_elevator)) {
    level.heli_elevator.origin = var_0.origin;
    level.heli_elevator.angles = var_0.angles;
  }

  common_scripts\utility::waitframe();

  if(isDefined(level.heli_elevator)) {
    thread maps\_vehicle::gopath(level.heli_elevator);
  }

  var_1 = getent("taxing_depth_charge_barrels", "targetname");
  var_2 = getent("taxing_depth_charge_barrels_clip", "targetname");
  var_1 delete();
  var_2 delete();
  common_scripts\utility::flag_set("aud_osprey_takeoff");

  if(isDefined(level.heli_elevator)) {
    level.heli_elevator show();
  }

  var_0 delete();
  wait 0.5;
  var_3 = getent("taxing_osprey_clip", "targetname");
  var_3 unlink();
  var_3 delete();
}

osprey_props() {
  thread maps\_anim::anim_loop_solo(self, "taxing_osprey_move_props");
}

osprey_delete_watcher() {
  self endon("death");
  common_scripts\utility::flag_wait("dt_osprey_can_delete");

  for(;;) {
    if(!level.player maps\_utility::player_looking_at(self.origin, undefined, 1)) {
      self delete();
    }

    wait 0.05;
  }
}

trans_talker() {
  var_0 = common_scripts\utility::getstruct("taxing_osprey_ref", "targetname");
  level.trans_talker = maps\_utility::spawn_targetname("transtion_talker", 1);
  level.trans_talker maps\_utility::set_archetype("unarmed_grape");
  level.trans_talker.animname = "trans_grape";
  level.trans_talker.ignoreme = 1;
  level.trans_talker.goalradius = 16;
  level.trans_talker.alertlevel = "alert";
  level.trans_talker maps\_utility::gun_remove();
  level.trans_talker thread maps\_utility::magic_bullet_shield(1);
  level.trans_talker.a.bdisablemovetwitch = 1;
  level.trans_talker maps\_utility::disable_arrivals();
  level.trans_talker maps\_utility::disable_exits();
  level.trans_talker thread maps\_anim::anim_loop_solo(level.trans_talker, "taxing_osprey_move_start", "stop_loop");
  common_scripts\utility::flag_wait("deck_clear");
  level.trans_talker notify("stop_loop");
  var_1 = getnode("talking_grape_start", "targetname");
  var_0 maps\_anim::anim_reach_solo(level.trans_talker, "trans_talk_runin");
  var_0 maps\_anim::anim_single_solo(level.trans_talker, "trans_talk_runin");
  common_scripts\utility::flag_set("grape_ready_for_deck_trans");

  if(!common_scripts\utility::flag("hesh_talk_kick")) {
    var_0 thread maps\_anim::anim_loop_solo(level.trans_talker, "trans_talk_wait", "stop_loop");
    common_scripts\utility::flag_wait("hesh_talk_kick");
  }

  var_0 notify("stop_loop");
  var_0 maps\_anim::anim_single_solo(level.trans_talker, "trans_talk");
  level.trans_talker thread trans_talker_runoff();
}

trans_talker_runoff() {
  self endon("death");
  maps\_utility::stop_magic_bullet_shield();
  thread maps\carrier_code::ignore_everything(20);
  thread maps\carrier_code::run_to_volume_and_delete("deck_transition_cleanup_vol");
  thread maps\carrier_code::safe_delete_drone(1500);
}

hesh_talking_to_grape() {
  var_0 = common_scripts\utility::getstruct("taxing_osprey_ref", "targetname");
  var_1 = getnode("trans_hesh_run_node", "targetname");
  level.hesh maps\_utility::set_forcegoal();
  level.hesh setgoalnode(var_1);
  level.hesh.ignorerandombulletdamage = 1;
  level.hesh.ignoresuppression = 1;
  level.hesh.ignoreexplosionevents = 1;
  level.hesh.ignoreall = 1;
  level.hesh maps\_utility::disable_bulletwhizbyreaction();
  var_0 maps\_anim::anim_reach_solo(level.hesh, "trans_talk_runin");
  var_0 maps\_anim::anim_single_solo(level.hesh, "trans_talk_runin");
  common_scripts\utility::flag_set("hesh_talk_kick");

  if(!common_scripts\utility::flag("grape_ready_for_deck_trans")) {
    var_0 thread maps\_anim::anim_loop_solo(level.hesh, "trans_talk_wait", "stop_loop");
    common_scripts\utility::flag_wait("grape_ready_for_deck_trans");
  }

  var_0 notify("stop_loop");
  var_0 thread maps\_anim::anim_single_solo(level.hesh, "trans_talk");
  thread hesh_dialogue_pacing();
  level.hesh waittillmatch("single anim", "hesh_loop_start");
  common_scripts\utility::flag_set("trans_talker_run");
  level.hesh maps\_utility::disable_exits();

  if(!common_scripts\utility::flag("picked_up_control_pad")) {
    var_0 thread maps\_anim::anim_loop_solo(level.hesh, "trans_talk_loop");
    common_scripts\utility::flag_wait("picked_up_control_pad");
    var_0 notify("stop_loop");
    maps\_utility::delaythread(4.7, common_scripts\utility::flag_set, "hesh_talking_finished");
    var_0 maps\_anim::anim_single_solo(level.hesh, "trans_talk_exit");
  } else {
    maps\_utility::delaythread(3.8, common_scripts\utility::flag_set, "hesh_talking_finished");
    level.hesh waittillmatch("single anim", "end");
  }

  common_scripts\utility::flag_set("hesh_run");
  level.hesh maps\_utility::set_ignoreme(0);
  level.hesh.ignorerandombulletdamage = 0;
  level.hesh.ignoresuppression = 0;
  level.hesh.ignoreexplosionevents = 0;
  level.hesh.ignoreall = 0;
  level.hesh maps\_utility::enable_bulletwhizbyreaction();
  common_scripts\utility::flag_set("deck_transition_finished");
}

hesh_dialogue_pacing() {
  wait 2.75;
  thread maps\carrier_audio::aud_carr_hesh_talk_explode();
  wait 3.5;
  thread explosion_during_hesh_talk();
  wait 2.5;
  thread osprey_control_pad();
  common_scripts\utility::flag_set("control_pad_objective");

  if(!common_scripts\utility::flag("picked_up_control_pad")) {
    thread opsrey_control_nag_vo();
  }

  common_scripts\utility::flag_wait("picked_up_control_pad");
  common_scripts\utility::flag_wait("hesh_talking_finished");
  thread maps\_utility::smart_radio_dialogue("carrier_ttn_allsquadswevegot");
  maps\_utility::delaythread(2, ::run_allies_to_edge);
  wait 4.2;
  thread maps\carrier::obj_defend_carrier();
  level.player maps\_utility::set_ignoreme(0);
  level.hesh maps\_utility::smart_dialogue("carrier_mrk_changeofplanshaul");
}

explosion_during_hesh_talk() {
  var_0 = common_scripts\utility::getstruct("trans_deck_explosion", "targetname");
  playFX(common_scripts\utility::getfx("vfx_missile_death_deck"), var_0.origin);
  radiusdamage(var_0.origin, var_0.radius, 800, 600, undefined, "MOD_EXPLOSIVE");
  physicsexplosionsphere(var_0.origin, var_0.radius * 2, var_0.radius, 100);
  screenshake(var_0.origin, 3, 2, 2, 0.8, 0, 0.8, 2000, 4, 6, 5);
  common_scripts\utility::flag_set("trans_boom");
}

background_vo() {
  wait 5;
  thread maps\_utility::smart_radio_dialogue("carrier_us1_keepbombardingthecoast");
  wait 5;
  thread maps\_utility::smart_radio_dialogue("carrier_com_thecarolinaisout");
  wait 7;
  thread maps\_utility::smart_radio_dialogue("carrier_us4_directfireonthose");
  wait 4;
  thread maps\_utility::smart_radio_dialogue("carrier_us2_multiplesortiesinboundair");
}

background_event_setup() {
  common_scripts\utility::flag_wait("hesh_talk_kick");
  thread cart_runner();
  wait 4;
  thread deck_combat_cleanup();
}

cart_runner() {
  wait 3;
  maps\_utility::array_spawn_function_targetname("trans_ally_cart_runner", ::cart_runner_behavior);
  var_0 = maps\_utility::spawn_targetname("trans_ally_cart_runner");
}

cart_runner_behavior() {
  self endon("death");
  self.animname = "generic";
  maps\_utility::set_ignoreall(1);

  if(isalive(self)) {
    var_0 = common_scripts\utility::getstruct("ally_wave_cart_runner2", "targetname");
    var_0 maps\_anim::anim_reach_solo(self, "forward_wave_back");
    var_0 maps\_anim::anim_single_solo(self, "forward_wave_back");
  }

  if(isalive(self)) {
    var_0 = common_scripts\utility::getstruct("ally_wave_cart_runner3", "targetname");
    var_0 maps\_anim::anim_reach_solo(self, "forward_wave_back");
    var_0 maps\_anim::anim_single_solo(self, "forward_wave_back");
    maps\_utility::set_ignoreall(0);
  }

  common_scripts\utility::flag_wait("defend_zodiac_wave_01");

  if(isalive(self)) {
    self delete();
  }
}

carrier_grape() {
  var_0 = common_scripts\utility::getstruct("pickup_wounded_ref", "targetname");
  var_1 = maps\_utility::spawn_targetname("trans_grape_carrier_wounded", 1);
  var_1.animname = "generic";
  var_1.runanim = maps\_utility::getgenericanim("unarmed_run");
  var_1 maps\_utility::gun_remove();
  var_1.goalradius = 16;
  var_1 endon("death");
  var_1.dontdonotetracks = 1;
  var_1 maps\_utility::battlechatter_off();
  var_1 thread maps\_anim::anim_loop_solo(var_1, "unarmed_cowercrouch_idle", "stop_loop");
  common_scripts\utility::flag_wait("hesh_talk_kick");
  wait 1.25;
  var_1 notify("stop_loop");
  var_1.target = "carrier_grape_goalnode";
  var_1 thread maps\_drone::drone_move();
  var_1 waittill("goal");
  common_scripts\utility::flag_set("run_carry_anim");
  var_0 maps\_anim::anim_generic(var_1, "carrier_guy");
  common_scripts\utility::flag_wait("trans_boom");

  if(isalive(var_1)) {
    var_1 kill();
  }
}

carried_grape() {
  var_0 = common_scripts\utility::getstruct("trans_redshirt_injured_ref", "targetname");
  var_1 = common_scripts\utility::getstruct("pickup_wounded_ref", "targetname");
  var_2 = getent("trans_grape_carried_wounded", "targetname");
  var_3 = var_2 maps\_utility::spawn_ai(1, 0);
  var_3.animname = "generic";
  var_3.damageshield = 1;
  var_3 maps\_utility::gun_remove();
  var_3.dontdonotetracks = 1;
  var_3 endon("death");
  common_scripts\utility::waitframe();
  var_0 thread maps\carrier_code::anim_fake_loop_endon(var_3, "injured", "run_carry_anim");
  common_scripts\utility::flag_wait("run_carry_anim");
  var_1 thread maps\_anim::anim_single_solo(var_3, "carried_guy");
  common_scripts\utility::flag_wait("trans_boom");
  var_3.damageshield = 0;

  if(isalive(var_3)) {
    var_3 kill();
  }
}

ally_color_node_movement() {
  var_0 = thread maps\_utility::get_force_color_guys("allies", "r");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 maps\_utility::ignoreallenemies(1);
      var_2 thread color_ally_jog_guys_logic();
    }
  }

  var_4 = maps\_utility::get_force_color_guys("allies", "o");

  foreach(var_2 in var_4) {
    if(isalive(var_2)) {
      var_2 maps\_utility::ignoreallenemies(1);
      var_2 thread color_ally_jog_guys_logic();
    }
  }

  var_7 = maps\_utility::get_force_color_guys("allies", "p");

  foreach(var_2 in var_7) {
    if(isalive(var_2)) {
      var_2 maps\_utility::ignoreallenemies(1);
      var_2 thread color_ally_jog_guys_logic();
    }
  }

  wait 6;
  var_10 = maps\_utility::get_force_color_guys("allies", "b");

  foreach(var_2 in var_10) {
    if(isalive(var_2)) {
      var_2 maps\_utility::ignoreallenemies(1);
    }
  }

  common_scripts\utility::flag_wait("defend_zodiac_wave_01");
  level notify("kill_color_replacements");
  wait 5;

  foreach(var_2 in var_7) {
    if(isalive(var_2)) {
      var_2 thread maps\carrier_code::safe_delete_drone(500);
    }
  }

  var_10 = getEntArray("ambient_trans_drones", "script_noteworthy");

  foreach(var_2 in var_10) {
    if(isalive(var_2)) {
      var_2 thread maps\carrier_code::safe_delete_drone(500);
    }
  }
}

add_in_more_allies() {
  var_0 = maps\carrier_code::array_spawn_targetname_allow_fail("trans_blue_allies", 1);

  foreach(var_2 in var_0) {
    var_2 thread ally_jog_guys_logic();
    var_2 maps\_utility::set_moveplaybackrate(randomfloatrange(0.9, 1.1));
  }
}

ally_jog_guys_logic() {
  self endon("deleted");
  self.animname = "generic";

  if(common_scripts\utility::cointoss()) {
    var_0 = "run_gun_up";
  } else {
    var_0 = "patrol_jog";
  }

  self.runanim = maps\_utility::getgenericanim(var_0);
}

color_ally_jog_guys_logic() {
  self endon("deleted");
  self.animname = "generic";

  if(common_scripts\utility::cointoss()) {
    var_0 = "run_gun_up";
  } else {
    var_0 = "patrol_jog";
  }

  maps\_utility::set_run_anim(var_0);
}

run_allies_rear_ship() {
  var_0 = getEntArray("ambient_trans_drones", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 maps\_utility::set_force_color("b");
    }
  }

  common_scripts\utility::flag_wait("defend_zodiac_wave_01");

  foreach(var_5 in var_0) {
    if(isDefined(var_5) && isalive(var_5)) {
      var_5 thread maps\ss_util::fake_death_bullet();
      wait(randomintrange(4, 10));
    }
  }
}

heli_attack1() {
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("trans_gun_run_heli1");
  thread enemy_heli_respawner();
  common_scripts\utility::flag_wait("defend_zodiac_wave_01");

  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_1 = getEntArray("attack_heli1", "targetname");
  maps\_utility::array_delete(var_1);
}

enemy_heli_respawner() {
  wait 4;
  var_0 = ["trans_attack_heli1", "trans_attack_heli2", "trans_attack_heli3"];

  while(!common_scripts\utility::flag("picked_up_control_pad")) {
    var_0 = common_scripts\utility::array_randomize(var_0);
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0[0]);
    var_2 = [var_1];
    thread maps\_utility::ai_delete_when_out_of_sight(var_2, 15000);

    if(common_scripts\utility::cointoss()) {
      var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0[1]);
      var_3 = [var_1];
      thread maps\_utility::ai_delete_when_out_of_sight(var_3, 15000);
    }

    wait(randomfloatrange(7, 18));
  }
}

activate_riders() {
  maps\_utility::ent_flag_wait("activate_enemies");
}

jet_attack() {
  thread maps\carrier_audio::aud_jet_attack();
  var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("flyby_missile_attack1");
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("flyby_missile_attack2");
}

jet_fast_flyby() {
  maps\_vehicle::spawn_vehicles_from_targetname_and_drive("fast_flyby_jets");
}

kill_heli_engine_sounds() {
  foreach(var_1 in self) {
    if(isDefined(var_1.script_noteworthy) && var_1.script_noteworthy == "kill_engine_sound") {
      var_1 vehicle_turnengineoff();
    }
  }
}

cart_player_kill_volume() {
  wait 21.5;
  var_0 = gettime() + 500;
  var_1 = getent("cart_player_push_vol", "targetname");

  while(gettime() < var_0) {
    if(var_1 istouching(level.player)) {
      level.player kill();
      level.player maps\_hud_util::fade_out(0.9, "black");
      return;
    }

    common_scripts\utility::waitframe();
  }
}

checkpoint_osprey() {
  var_0 = common_scripts\utility::getstruct("taxing_osprey_ref", "targetname");
  var_1 = getent("heli_elevator_fake", "script_noteworthy");
  var_1.animname = "taxing_osprey";
  var_1 maps\_anim::setanimtree();
  var_2 = getent("taxing_osprey_clip", "targetname");
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  var_2 linkto(var_1, "tag_body", (-75, 0, -125), (0, 0, 0));
  level.elevator_osprey_clip = var_2;
  common_scripts\utility::flag_set("aud_osprey_taxi");
  thread jet_attack();
  badplace_delete("badplace_rear_elevator");
  var_0 thread maps\_anim::anim_loop_solo(var_1, "taxing_osprey_move_loop");
  common_scripts\utility::flag_wait("hesh_talk_kick");
  common_scripts\utility::flag_set("taxing_osprey_move_start");
  var_0 notify("stop_loop");
  var_3 = [];
  var_3[0] = maps\_utility::spawn_targetname("taxing_grape_osprey1");
  var_3[0].animname = "taxi_grape_3";
  var_3[0] maps\_utility::gun_remove();
  var_3[0] thread maps\_utility::magic_bullet_shield();
  var_3[1] = maps\_utility::spawn_targetname("taxing_grape_osprey2");
  var_3[1].animname = "taxi_grape_4";
  var_3[1] maps\_utility::gun_remove();
  var_3[1] thread maps\_utility::magic_bullet_shield();
  thread run_osprey_takeoff();
  var_0 thread maps\_anim::anim_single(var_3, "taxing_osprey_move");
  var_0 maps\_anim::anim_single_solo(var_1, "taxing_osprey_move_finish");
  common_scripts\utility::flag_set("dt_osprey_go");

  if(isDefined(var_3[0]) && isalive(var_3[0])) {
    var_3[0] maps\_utility::stop_magic_bullet_shield();
    var_3[0] delete();
  }

  if(isDefined(var_3[1]) && isalive(var_3[1])) {
    var_3[1] maps\_utility::stop_magic_bullet_shield();
    var_3[1] delete();
  }
}

run_allies_to_edge() {
  maps\carrier_defend_zodiac::run_allies();
}