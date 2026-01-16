/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_last_final_battle.gsc
**************************************************/

init_final_battle() {
  common_scripts\utility::flag_init("outpost_gas_station_done");
  common_scripts\utility::flag_init("outpost_garage_done");
  common_scripts\utility::flag_init("outpost_rooftops_done");
  common_scripts\utility::flag_init("all_outposts_completed");
  common_scripts\utility::flag_init("start_cross_vignette");
  common_scripts\utility::flag_init("cross_vignette_complete");
  common_scripts\utility::flag_init("cortex_started");
  common_scripts\utility::flag_init("cortex_detonated");
  common_scripts\utility::flag_init("start_last_stand");
  common_scripts\utility::flag_init("disable_all_traps");
  common_scripts\utility::flag_init("final_battle_start_vo_over");
  common_scripts\utility::flag_init("outpost_encounter_running");
  level.cortex_charge = 0;
  level.cortex_charge_per_player_scalar = [];
  level.cortex_charge_per_player_scalar[1] = 0.7;
  level.cortex_charge_per_player_scalar[2] = 1.0;
  level.cortex_charge_per_player_scalar[3] = 1.5;
  level.cortex_charge_per_player_scalar[4] = 1.75;
  level.final_battle_stage = 1;
  level.num_cortex_players = 1;
  level.left_gate_destroyed = 0;
  level.middle_gate_destroyed = 0;
  level.right_gate_destroyed = 0;
  level.left_generator_destroyed = 0;
  level.add_cortex_charge_func = ::add_cortex_charge;
  level.ancestor_music_played = 0;
  thread maps\mp\alien\_nuke::init();
}

setup_final_battle() {
  init_final_battle();
  level waittill("enable_encounters");
  level thread initial_entity_setup();
  common_scripts\utility::flag_wait_all("outpost_gas_station_done", "outpost_garage_done", "outpost_rooftops_done");
  level do_return_to_base();
  common_scripts\utility::flag_wait("start_cross_vignette");
  level thread do_cross_vignette();
  level common_scripts\utility::flag_wait("cross_vignette_complete");
  level thread run_cortex_logic();
  level thread final_battle_vo();
  common_scripts\utility::flag_wait("cortex_started");
  thread medusa_on_state_fx();
  level thread start_final_battle();
  level.should_use_custom_death_func = 1;
  common_scripts\utility::flag_wait("start_last_stand");
  level thread start_last_stand();
  common_scripts\utility::flag_wait("cortex_detonated");
  level do_ending();
}

do_return_to_base() {
  if(common_scripts\utility::flag("start_cross_vignette")) {
    return;
  }
  common_scripts\utility::flag_set("all_outposts_completed");
  var_0 = common_scripts\utility::getstruct("ancestor_dr_cross", "targetname");
  level.dr_cross = spawn("script_model", var_0.origin);
  level.dr_cross setModel("body_cross_a");
  level.dr_cross.angles = (0, 0, 0);
  level.dr_cross.crosshead = spawn_model("head_cross_a", level.dr_cross, "J_spine4", (0, 0, 0));
  level.dr_cross.shield = spawn("script_model", level.dr_cross.origin + (0, 0, 100));
  level.dr_cross.shield setModel("alien_shield_bubble_ancestor_col");
  level.dr_cross.shield linkto(level.dr_cross, "tag_origin", (0, 0, 100), (0, 0, 0));
  thread sfx_cross_shield_lp();
  level.canister = getent("cortex_canister", "targetname");
  level.canister.origin = (390, -542, 17);
  level.canister.angles = (0, 180, 0);
  level.core = getent("cortex_core", "targetname");
  level.core.origin = (400, -664, 16);
  level.core.angles = (0, 0, 0);
  level.dr_cross scriptmodelplayanimdeltamotion("alien_last_cross_vignette_idle");
  level.dr_cross.crosshead scriptmodelplayanim("alien_last_cross_vignette_idle");
  level.canister scriptmodelplayanimdeltamotion("alien_last_cross_vignette_cannister_idle");
  level.core scriptmodelplayanim("alien_last_cross_vignette_core_idle");
  level.dr_cross thread cross_loop_delay();
  level thread handle_cross_vignette_aliens();
  level thread wait_for_very_close_player();
  level thread wait_for_all_close_players();
  level.dr_cross thread show_return_to_base_objective();
  wait 0.1;
  playFXOnTag(level._effect["cross_ff_1"], level.dr_cross.shield, "tag_origin");
  playFXOnTag(level._effect["cross_teleport"], level.dr_cross, "j_spine4");
  playFXOnTag(level._effect["cortex_glow_1"], level.canister, "tag_origin");
}

cross_loop_delay() {
  self endon("death");

  for(;;) {
    wait 3.0;
    self notify("ok_to_start_anim");
  }
}

do_cross_vignette() {
  if(common_scripts\utility::flag("cortex_started")) {
    return;
  }
  wait 3.0;
  level.dr_cross waittill("ok_to_start_anim");
  level notify("shield_down");

  foreach(var_1 in level.players)
  var_1 thread cross_vignette_unstuck();

  level.dr_cross scriptmodelplayanimdeltamotion("alien_last_cross_vignette_scene");
  level.dr_cross.crosshead scriptmodelplayanim("alien_last_cross_vignette_scene");
  level.canister scriptmodelplayanimdeltamotion("alien_last_cross_vignette_cannister_scene");
  level.core scriptmodelplayanim("alien_last_cross_vignette_core_scene");
  thread cross_vignette_vo();
  thread turn_off_cortex_fx();
  thread sfx_cross_cortex();
  thread sfx_cross_land();
  wait 0.5;
  level notify("cross_landing");
  playFX(level._effect["cross_blast"], level.dr_cross.origin);
  stopFXOnTag(level._effect["cross_ff_1"], level.dr_cross.shield, "tag_origin");
  level.dr_cross.shield delete();
  thread sfx_cross_teleport();
  wait 33.8;
  playFXOnTag(level._effect["cross_teleport"], level.dr_cross, "j_spine4");
  wait 0.76;
  level.dr_cross scriptmodelplayanimdeltamotion("alien_last_cross_vignette_scene_pt2");
  level.dr_cross.crosshead scriptmodelplayanim("alien_last_cross_vignette_scene_pt2");
  wait 0.2;
  playFXOnTag(level._effect["cross_teleport"], level.dr_cross, "j_spine4");
  wait 19.2;
  playFXOnTag(level._effect["cross_teleport"], level.dr_cross, "j_spine4");
  common_scripts\utility::flag_set("cross_vignette_complete");
  wait 0.1;
  level.dr_cross.crosshead delete();
  level.dr_cross delete();
}

cross_vignette_unstuck() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  level endon("cross_vignette_complete");
  var_0 = (532, -516, 16);
  self waittill("unresolved_collision");
  self setorigin(var_0);
}

turn_off_cortex_fx() {
  wait 12.66;
  stopFXOnTag(level._effect["cortex_glow_1"], level.canister, "tag_origin");
}

handle_cross_vignette_aliens() {
  var_0 = common_scripts\utility::getstructarray("cross_vignette_spawners", "targetname");
  level.cross_aliens = [];

  foreach(var_2 in var_0)
  thread spawn_single_vignette_alien(var_2);

  level waittill("cross_landing");

  foreach(var_5 in level.cross_aliens) {
    if(isDefined(var_5) && isalive(var_5)) {
      var_5.fauxdead = undefined;
      var_5.ignoreall = 0;
      var_5 dodamage(1000, level.dr_cross.origin, level.dr_cross);
    }
  }

  wait 0.2;
  physicsexplosionsphere(level.dr_cross.origin, 768, 512, 5);
}

spawn_single_vignette_alien(var_0) {
  var_1 = "wave goon";
  var_2 = var_0.angles;

  if(!isDefined(var_2))
    var_2 = (0, 270, 0);

  wait(randomfloatrange(0.2, 1.0));
  var_3 = maps\mp\alien\_spawnlogic::spawnalien(var_0.origin, var_2, var_1);
  var_3.spawner = var_0;
  var_3 maps\mp\alien\_utility::enable_alien_scripted();
  var_3 scragentsetscripted(1);
  var_3.ignoreall = 1;
  var_3.pet = 1;
  var_3.fauxdead = 1;
  wait 0.1;
  var_3 thread maps\mp\agents\alien\_alien_idle::main();
  var_3 maps\mp\alien\_utility::set_alien_emissive(0.5, 0.0);
  maps\mp\alien\_outline_proto::enable_outline(var_3, 3, 1);
  playFXOnTag(level._effect["alien_uncloaking"], var_3, "j_neck");

  if(isDefined(var_3.enemy))
    var_3.enemy.current_attackers = [];

  level.cross_aliens[level.cross_aliens.size] = var_3;
  return var_3;
}

spawn_model(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", (0, 0, 0));
  var_4 setModel(var_0);
  var_4.origin = var_1 gettagorigin(var_2);
  var_4.angles = var_1 gettagangles(var_2) + var_3;
  var_4 linkto(var_1, var_2);
  return var_4;
}

wait_for_very_close_player() {
  level endon("start_cross_vignette");
  var_0 = 16384;

  for(;;) {
    foreach(var_2 in level.players) {
      if(distancesquared(var_2.origin, level.dr_cross.origin) < var_0) {
        common_scripts\utility::flag_set("start_cross_vignette");
        return;
      }

      wait 1.0;
    }

    wait 0.1;
  }
}

wait_for_all_close_players() {
  level endon("start_cross_vignette");
  var_0 = getent("main_base", "targetname");

  for(;;) {
    var_1 = 0;

    foreach(var_3 in level.players) {
      if(var_3 istouching(var_0))
        var_1++;
    }

    if(var_1 >= level.players.size) {
      common_scripts\utility::flag_set("start_cross_vignette");
      return;
    }

    wait 1.0;
  }
}

start_final_battle() {
  level endon("cortex_detonated");

  if(common_scripts\utility::flag("start_last_stand")) {
    return;
  }
  level.current_area_name = "main_base";
  level.final_battle_start_time = gettime();

  if(!maps\mp\alien\_utility::is_true(level.jump_to_final_battle)) {
    thread shut_base_gates();
    wait 2.0;
  }

  wait 3.0;

  if(!isDefined(level.final_battle_lane_order)) {
    level.final_battle_lane_order = [::final_battle_left_ancestor, ::final_battle_middle_ancestor, ::final_battle_right_ancestor];
    level.final_battle_lane_order = common_scripts\utility::array_randomize(level.final_battle_lane_order);
  } else
    wait 5.0;

  level thread play_vo_on_final_ancestors_death();
  level.current_encounter_info = spawnStruct();
  thread play_end_ancestor_music();
  level thread check_for_room_exploit();

  foreach(var_1 in level.final_battle_lane_order) {
    maps\mp\alien\_gamescore::reset_encounter_performance();
    level.current_encounter_info.force_end_func = ::debug_beat_ancestor_encounter;
    [
      [var_1]
    ]();
    level.final_battle_stage = level.final_battle_stage + 1;
    wait 8;
  }

  common_scripts\utility::flag_set("start_last_stand");
}

final_battle_left_ancestor() {
  level.current_area_name = "ancestor_lane_left";
  wait 5.0;
  setup_final_battle_encounter("main_base", "ancestor_left", 24);
  var_0 = common_scripts\utility::getstruct("ancestor_left_lane", "targetname");
  level.left_ancestor = maps\mp\agents\alien\alien_ancestor\_alien_ancestor::addancestoragent("axis", var_0.origin, level.players[0].angles);

  if(level.left_ancestor maps\mp\alien\_utility::ent_flag_exist("activate_shield_health_check"))
    level.left_ancestor maps\mp\alien\_utility::ent_flag_set("activate_shield_health_check");

  level thread left_ancestor_event();
  level thread start_trap_gen_sfx();

  if(!common_scripts\utility::flag("final_battle_start_vo_over"))
    level thread play_godfather_vo("last_gdf_inc_westgate", 5);
  else
    level thread play_godfather_vo("last_gdf_inc_westgate");

  common_scripts\utility::waittill_any_timeout(240, "debug_beat_current_encounter");
  end_final_battle_encounter();
}

left_ancestor_event() {
  level.left_ancestor endon("death");
  wait 5;
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();

  if(!level.left_generator_destroyed) {
    level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_left_attack_generator");
    var_0 = getent("ancestor_left_generator_pos", "targetname");
    level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_align_to_angles(var_0.angles);
    level.left_ancestor thread maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::force_blast_attack(var_0.origin);
    level.left_ancestor maps\mp\alien\_utility::disable_alien_scripted();
    wait 0.5;
    level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
    wait 2.7;
    thread maps\mp\mp_alien_last_fx::conduit_fx_destroyed();
    common_scripts\utility::flag_set("disable_all_traps");
    level thread dmg_trap_gen_sfx();
    level.left_generator_destroyed = 1;
    level thread play_godfather_vo("last_gdf_lostpowerwest", 5);
    level thread left_ancestor_restore_traps();
  }

  var_1 = getent("ancestor_left_gate_grab_pos", "targetname");
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_left_traverse_1");
  var_2 = getnode("ancestor_left_resume_path_1", "targetname");
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::assign_path_node(var_2);
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_play_traversal(var_1.angles, "traverse_down");
  wait 0.2;
  level.left_ancestor maps\mp\alien\_utility::disable_alien_scripted();
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::assign_path_node(var_2);
  wait 0.1;
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  wait 3.0;
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_left_traverse_2");
  var_3 = getnode("ancestor_left_resume_path_2", "targetname");
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::assign_path_node(var_3);
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_play_traversal(var_1.angles, "traverse_down");
  wait 0.5;
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::assign_path_node(var_3);
  level.left_ancestor maps\mp\alien\_utility::disable_alien_scripted();
  wait 5;
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_left_gate_traverse");
  level thread play_godfather_vo("last_gdf_westgate");

  if(!level.left_gate_destroyed) {
    level.left_ancestor thread maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_do_forced_grab("ancestor_left_gate_grab_pos");
    thread sfx_gate_left_bend();
    level.left_ancestor waittill("forced_grab_damage_start");
    left_destruction();
  }

  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_play_traversal(var_1.angles, "traverse_gate");
  wait 4.0;
  level.left_ancestor maps\mp\alien\_utility::disable_alien_scripted();
  var_4 = getnode("ancestor_left_gate_inside", "targetname");
  level.left_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::assign_path_node(var_4);
}

left_ancestor_restore_traps() {
  var_0 = level.cycle_data.cycle_drill_layers[level.cycle_count - 1];
  wait(var_0[0] - 5);
  common_scripts\utility::flag_clear("disable_all_traps");
  level thread stop_trap_gen_sfx();
}

left_destruction() {
  thread sfx_gate_left_expl();
  var_0 = getEntArray("main_base_left_gate", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters) && var_2.script_parameters == "exploder") {
      var_2 show();
      var_2 solid();
      continue;
    }

    var_2 notsolid();
    var_2 delete();
  }

  common_scripts\utility::exploder(101);
  level.left_gate_destroyed = 1;
  wait 0.2;
  var_4 = getent("left_connector", "targetname");
  var_4 connectpaths();
  var_4 delete();
}

start_trap_gen_sfx() {
  var_0 = getent("ancestor_left_generator_scriptable", "targetname");
  level.trap_gen_sfx_lp = spawn("script_origin", var_0.origin);
  level.trap_gen_sfx_lp linkto(var_0);
  wait 0.1;

  if(isDefined(level.trap_gen_sfx_lp))
    level.trap_gen_sfx_lp playLoopSound("alien_conduit_on_lp");
}

dmg_trap_gen_sfx() {
  level.trap_gen_sfx_lp stoploopsound("alien_conduit_on_lp");
  var_0 = getent("ancestor_left_generator_scriptable", "targetname");
  level.trap_gen_dmg_sfx_lp = spawn("script_origin", var_0.origin);
  level.trap_gen_dmg_sfx_lp linkto(var_0);
  wait 0.1;

  if(isDefined(level.trap_gen_dmg_sfx_lp))
    level.trap_gen_dmg_sfx_lp playLoopSound("alien_conduit_damaged_lp");
}

repair_trap_gen_sfx() {
  if(isDefined(level.trap_gen_dmg_sfx_lp)) {
    level.trap_gen_dmg_sfx_lp stoploopsound("alien_conduit_damaged_lp");
    level.trap_gen_dmg_sfx_lp delete();
  }

  if(isDefined(level.trap_gen_sfx_lp))
    level.trap_gen_sfx_lp playLoopSound("alien_conduit_on_lp");
}

stop_trap_gen_sfx() {
  if(isDefined(level.trap_gen_sfx_lp)) {
    level.trap_gen_sfx_lp stoploopsound("alien_conduit_on_lp");
    level.trap_gen_sfx_lp playLoopSound("alien_conduit_powered_lp");
  }

  if(isDefined(level.trap_gen_dmg_sfx_lp)) {
    level.trap_gen_dmg_sfx_lp stoploopsound("alien_conduit_damaged_lp");
    level.trap_gen_dmg_sfx_lp delete();
  }
}

final_battle_middle_ancestor() {
  level.current_area_name = "ancestor_lane_middle";
  wait 5.0;
  setup_final_battle_encounter("main_base", "ancestor_middle", 25);
  var_0 = common_scripts\utility::getstruct("ancestor_middle_lane", "targetname");
  level.middle_ancestor = maps\mp\agents\alien\alien_ancestor\_alien_ancestor::addancestoragent("axis", var_0.origin, level.players[0].angles);

  if(level.middle_ancestor maps\mp\alien\_utility::ent_flag_exist("activate_shield_health_check"))
    level.middle_ancestor maps\mp\alien\_utility::ent_flag_set("activate_shield_health_check");

  level thread middle_ancestor_event();

  if(!common_scripts\utility::flag("final_battle_start_vo_over"))
    level thread play_godfather_vo("last_gdf_inc_northgate", 5);
  else
    level thread play_godfather_vo("last_gdf_inc_northgate");

  common_scripts\utility::waittill_any_timeout(240, "debug_beat_current_encounter");
  end_final_battle_encounter();
}

middle_ancestor_event() {
  level.middle_ancestor endon("death");

  if(!isDefined(level.middle_ancestor)) {
    return;
  }
  level.middle_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  level.middle_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_front_gate_teleport");

  if(!level.middle_gate_destroyed) {
    level thread play_godfather_vo("last_gdf_northgate");
    level.middle_ancestor thread maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_do_forced_grab("ancestor_front_gate_grab_pos");
    thread sfx_gate_middle_bend();
    level.middle_ancestor waittill("forced_grab_damage_start");
    middle_destruction();
    wait 2.0;
    level.middle_ancestor maps\mp\alien\_utility::disable_alien_scripted();
    level thread play_godfather_vo("last_gdf_br_northgate", 5);
    var_0 = getnode("ancestor_front_gate_return", "targetname");
    level.middle_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::assign_path_node(var_0);
    level.middle_ancestor waittill("at_attack_node");
  }

  level.middle_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  level.middle_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_front_gate_traverse");
  var_1 = getent("ancestor_front_gate_grab_pos", "targetname");
  level.middle_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_play_traversal(var_1.angles, "traverse_gate");
  level.middle_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  wait 0.5;
  var_2 = getnode("ancestor_front_gate_inside", "targetname");
  level.middle_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::assign_path_node(var_2);
  level.middle_ancestor maps\mp\alien\_utility::disable_alien_scripted();
}

middle_destruction() {
  var_0 = level.outposts["main_base"].outpost_encounters["transition_middle"];
  thread sfx_gate_middle_expl();
  common_scripts\utility::exploder("main_base_front_gate");
  common_scripts\utility::exploder(102);
  level.middle_gate_destroyed = 1;
  var_0.gate_models[0] delete();
  level notify("main_base_front_gate");
  wait 0.2;
  var_0.gate_clip delete();
  var_1 = getent("front_gate_mantle", "targetname");
  var_1 movez(200, 0.1);
}

final_battle_right_ancestor() {
  level.current_area_name = "ancestor_lane_right";
  wait 5.0;
  setup_final_battle_encounter("main_base", "ancestor_right", 26);
  var_0 = common_scripts\utility::getstruct("ancestor_right_lane", "targetname");
  level.right_ancestor = maps\mp\agents\alien\alien_ancestor\_alien_ancestor::addancestoragent("axis", var_0.origin, level.players[0].angles);

  if(level.right_ancestor maps\mp\alien\_utility::ent_flag_exist("activate_shield_health_check"))
    level.right_ancestor maps\mp\alien\_utility::ent_flag_set("activate_shield_health_check");

  level thread right_ancestor_event();

  if(!common_scripts\utility::flag("final_battle_start_vo_over"))
    level thread play_godfather_vo("last_gdf_inc_eastgate", 4);
  else
    level thread play_godfather_vo("last_gdf_inc_eastgate");

  common_scripts\utility::waittill_any_timeout(240, "debug_beat_current_encounter");
  end_final_battle_encounter();
}

right_ancestor_event() {
  level.right_ancestor endon("death");
  wait 5;
  level thread play_godfather_vo("last_gdf_airbornecryptids", 5);
  level.right_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  level thread play_godfather_vo("last_gdf_eastgate");

  if(!level.right_gate_destroyed) {
    level.right_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_right_gate_freedom");
    level.right_ancestor maps\mp\alien\_utility::disable_alien_scripted();
    wait 20.0;
    level.right_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
    level.right_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_right_gate_traverse");
    level.right_ancestor thread maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_do_forced_grab("ancestor_right_gate_grab_pos");
    thread sfx_gate_right_bend();
    level.right_ancestor waittill("forced_grab_damage_start");
    right_destruction();
    wait 0.5;
  } else
    level.right_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_path_to_node("ancestor_right_gate_traverse");

  level.right_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  level.right_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_play_traversal(level.right_ancestor.angles, "traverse_gate");
  level.right_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::ancestor_enter_scripted();
  wait 0.5;
  var_0 = getnode("ancestor_right_gate_inside", "targetname");
  level.right_ancestor maps\mp\agents\alien\alien_ancestor\_alien_ancestor_think::assign_path_node(var_0);
  level.right_ancestor maps\mp\alien\_utility::disable_alien_scripted();
}

right_destruction() {
  thread sfx_gate_right_expl();
  var_0 = getEntArray("main_base_right_gate", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters) && var_2.script_parameters == "exploder") {
      var_2 show();
      var_2 solid();
      continue;
    }

    var_2 notsolid();
    var_2 delete();
  }

  common_scripts\utility::exploder(100);
  level.right_gate_destroyed = 1;
  wait 0.2;
  var_4 = getent("right_connector", "targetname");
  var_4 connectpaths();
  var_4 delete();
}

start_last_stand() {
  if(common_scripts\utility::flag("cortex_detonated")) {
    return;
  }
  if(isDefined(level.jump_to_final_battle) && level.jump_to_final_battle)
    wait 8;

  maps\mp\alien\_gamescore::reset_encounter_performance();
  wait 2.0;
  thread left_ancestor_respawn();
  wait 0.2;
  thread middle_ancestor_respawn();
  wait 0.2;
  thread right_ancestor_respawn();
  wait 0.2;
  setup_final_battle_encounter("main_base", "final_battle", 27);
  common_scripts\utility::flag_wait("cortex_detonated");
  end_final_battle_encounter();
}

setup_final_battle_encounter(var_0, var_1, var_2) {
  level thread maps\mp\mp_alien_last_progression::set_area_index_for_encounter(var_0);
  maps\mp\_utility::delaythread(2, maps\mp\alien\_challenge::spawn_challenge);
  maps\mp\alien\_gamescore::reset_encounter_performance();
  level.encounter_name = var_1;
  level.current_hive_name = var_1;
  level.current_area_name = var_0;
  level.cycle_count = var_2;
  maps\mp\alien\_spawn_director::start_cycle(var_2);
  level.cycle_count = level.cycle_count + 1;
  var_3 = 0.4;
  var_4 = 1.75;
  thread maps\mp\alien\_hive::warn_all_players(var_4, var_3);
}

end_final_battle_encounter() {
  maps\mp\alien\_spawn_director::end_cycle();
  maps\mp\alien\_challenge::end_current_challenge();
  maps\mp\alien\_challenge::remove_all_challenge_cases();
  maps\mp\alien\_gamescore_last::update_cortex_charge_bonus(level.final_battle_stage);
  maps\mp\alien\_gamescore::calculate_encounter_scores(level.players, ["cortex"]);
  maps\mp\mp_alien_last_progression::give_players_rewards(undefined, 1, 0);
}

left_ancestor_respawn() {
  var_0 = 0;

  while(isDefined(level.left_ancestor) && isalive(level.left_ancestor) && !isDefined(level.jump_to_final_battle)) {
    wait 20;
    var_0++;

    if(var_0 >= 2)
      return;
  }

  var_1 = common_scripts\utility::getstruct("ancestor_left_lane", "targetname");
  level.left_ancestor = maps\mp\agents\alien\alien_ancestor\_alien_ancestor::addancestoragent("axis", var_1.origin, (0, 0, 0));
  level thread left_ancestor_event();
}

middle_ancestor_respawn() {
  var_0 = 0;

  while(isDefined(level.middle_ancestor) && isalive(level.middle_ancestor) && !isDefined(level.jump_to_final_battle)) {
    wait 20;
    var_0++;

    if(var_0 >= 2)
      return;
  }

  var_1 = common_scripts\utility::getstruct("ancestor_middle_lane", "targetname");
  level.middle_ancestor = maps\mp\agents\alien\alien_ancestor\_alien_ancestor::addancestoragent("axis", var_1.origin, (0, 0, 0));
  level thread middle_ancestor_event();
}

right_ancestor_respawn() {
  var_0 = 0;

  while(isDefined(level.right_ancestor) && isalive(level.right_ancestor) && !isDefined(level.jump_to_final_battle)) {
    wait 20;
    var_0++;

    if(var_0 >= 2)
      return;
  }

  var_1 = common_scripts\utility::getstruct("ancestor_right_lane", "targetname");
  level.right_ancestor = maps\mp\agents\alien\alien_ancestor\_alien_ancestor::addancestoragent("axis", var_1.origin, (0, 0, 0));
  level thread right_ancestor_event();
}

do_ending() {
  thread last_end_music_sfx();

  foreach(var_1 in level.players) {
    var_1.ignoreme = 1;
    var_1 thread mp_alien_last_camera_fly();
  }

  foreach(var_4 in level.agentarray) {
    if(isDefined(var_4) && isalive(var_4))
      var_4 dodamage(100000, level.cortex_base_origin);
  }

  level.nuketimer = 3.35;
  level.players[0] thread maps\mp\alien\_nuke::donukesimple();
  thread medusa_100_state_fx();

  foreach(var_1 in level.players)
  var_1 playrumbleonentity("heavy_3s");

  var_8 = gettime() - level.final_battle_start_time;
  level waittill("nuke_death");
  update_lb_aliensession_last_escape(var_8);
  set_players_escaped();
  give_players_completion_awards();
  maps\mp\alien\_unlock::update_escape_item_unlock(level.players);
  var_9 = maps\mp\alien\_hud::get_end_game_string_index("all_escape");
  level maps\mp\_utility::delaythread(3, maps\mp\gametypes\aliens::alienendgame, "allies", var_9);
}

update_lb_aliensession_last_escape(var_0) {
  var_1 = get_lb_final_battle_rank(var_0);

  foreach(var_3 in level.players) {
    var_3 maps\mp\alien\_persistence::lb_player_update_stat("escapedRank" + var_1, 1, 1);
    var_3 maps\mp\alien\_persistence::lb_player_update_stat("hits", 1, 1);
  }
}

get_lb_final_battle_rank(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo())
    return solo_final_battle_rank(var_0);
  else
    return coop_final_battle_rank(var_0);
}

solo_final_battle_rank(var_0) {
  var_1 = 840000;
  var_2 = 960000;
  var_3 = 1080000;

  if(var_0 <= var_1)
    return 0;
  else if(var_0 <= var_2)
    return 1;
  else if(var_0 <= var_3)
    return 2;
  else
    return 3;
}

coop_final_battle_rank(var_0) {
  var_1 = 750000;
  var_2 = 810000;
  var_3 = 870000;

  if(var_0 <= var_1)
    return 0;
  else if(var_0 <= var_2)
    return 1;
  else if(var_0 <= var_3)
    return 2;
  else
    return 3;
}

mp_alien_last_camera_fly() {
  self endon("disconnect");
  level endon("game_ended");
  self playerhide();
  maps\mp\_utility::freezecontrolswrapper(1);
  maps\mp\_utility::clearkillcamstate();
  self.friendlydamage = undefined;
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
  self.anchor = spawn("script_model", self getEye());
  self.anchor.angles = self.angles;
  self.anchor setModel("tag_origin");
  self cameralinkto(self.anchor, "tag_origin");
  var_0 = getent("cortex_base", "targetname");
  var_1 = 1;

  if(self getEye()[0] > var_0.origin[0])
    var_1 = -1;

  var_2 = common_scripts\utility::getstruct("fly_cam_init", "targetname");
  var_2.angles = (angleclamp180(var_2.angles[0]), angleclamp180(var_2.angles[1]), angleclamp180(var_2.angles[2]));
  self playerlinkweaponviewtodelta(self.anchor, "tag_player", 1.0, 10, 10, 10, 10, 1);
  var_3 = spawnStruct();
  var_3.origin = var_2.origin + (500 * var_1, 800, 500);
  var_3.angles = vectortoangles(var_0.origin + (0, 0, 300) - var_3.origin);
  var_3.angles = (angleclamp180(var_3.angles[0]), angleclamp180(var_3.angles[1]), angleclamp180(var_3.angles[2]));
  var_4 = spawnStruct();
  var_4.origin = var_2.origin + (800 * var_1, -300, 800);
  var_4.angles = vectortoangles(var_0.origin + (0, 0, 500) - var_4.origin);
  var_4.angles = (angleclamp180(var_4.angles[0]), angleclamp180(var_4.angles[1]), angleclamp180(var_4.angles[2]));
  var_5 = 120;
  var_6 = 0.05;
  var_7 = cubic_bezier_curve(self getEye(), var_2.origin, var_3.origin, var_4.origin, var_5);
  var_8 = cubic_bezier_curve(self.angles, var_2.angles, var_3.angles, var_4.angles, var_5);

  for(var_9 = 0; var_9 < var_5; var_9++) {
    self.anchor.origin = var_7[var_9];
    self.anchor.angles = var_8[var_9];
    wait(var_6);
  }
}

cubic_bezier_curve(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = 0;
  var_7 = 1 / var_4;

  for(var_8 = 0; var_8 < var_4; var_8++) {
    var_9 = pow(1 - var_6, 3) * var_0[0] + 3 * pow(1 - var_6, 2) * var_6 * var_1[0] + 3 * (1 - var_6) * pow(var_6, 2) * var_2[0] + pow(var_6, 3) * var_3[0];
    var_10 = pow(1 - var_6, 3) * var_0[1] + 3 * pow(1 - var_6, 2) * var_6 * var_1[1] + 3 * (1 - var_6) * pow(var_6, 2) * var_2[1] + pow(var_6, 3) * var_3[1];
    var_11 = pow(1 - var_6, 3) * var_0[2] + 3 * pow(1 - var_6, 2) * var_6 * var_1[2] + 3 * (1 - var_6) * pow(var_6, 2) * var_2[2] + pow(var_6, 3) * var_3[2];
    var_5[var_8] = (var_9, var_10, var_11);
    var_6 = var_6 + var_7;
  }

  return var_5;
}

set_players_escaped() {
  foreach(var_1 in level.players) {
    if(!maps\mp\alien\_utility::is_casual_mode())
      var_1 maps\mp\alien\_persistence::set_player_escaped();

    var_1.dlc4_escaped = 1;
  }

  maps\mp\alien\_achievement_dlc4::update_progression_achievements("last_completed");
}

give_players_completion_awards() {
  foreach(var_1 in level.players)
  var_1 maps\mp\alien\_persistence::award_completion_tokens();
}

run_cortex_logic() {
  level.cortex_sfx1 = spawn("script_origin", (398, -622, 77));
  level.cortex_sfx2 = spawn("script_origin", (398, -622, 77));
  level.cortex_sfx3 = spawn("script_origin", (398, -622, 77));
  level endon("game_ended");

  while(common_scripts\utility::flag("outpost_encounter_running"))
    wait 1.0;

  var_0 = getent("cortex_use_trigger", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level.jump_to_final_battle) || !level.jump_to_final_battle) {
    var_0 thread maps\mp\alien\_hive::set_hive_icon("waypoint_alien_cortex_activate", 1300);
    var_1 = getent("cortex_canister", "targetname");

    if(isDefined(var_1))
      maps\mp\alien\_outline_proto::add_to_outline_hive_watch_list(var_1);

    level thread players_use_cortex_monitor(var_0, "cortex_start_hint");
    wait_for_all_player_use();

    foreach(var_3 in level.players)
    var_3 forceusehintoff(&"MP_ALIEN_LAST_CORTEX_START_HINT");

    common_scripts\utility::flag_set("cortex_started");
    thread cortex_sfx_on();
    var_0 maps\mp\alien\_hive::destroy_hive_icon();

    if(isDefined(var_1))
      maps\mp\alien\_outline_proto::remove_from_outline_hive_watch_list(var_1);

    wait 0.1;
    var_0 thread maps\mp\alien\_hive::set_hive_icon("waypoint_alien_defend", 1300);
  }

  setomnvar("ui_alien_boss_status", 2);
  setomnvar("ui_alien_boss_icon", 5);
  setomnvar("ui_alien_boss_progression", 100);
  var_5 = getent("cortex_base", "targetname");
  var_5 cortex_attack_point_logic();
  level.cortex_base_origin = var_5.origin;
  level.num_cortex_players = level.players.size;
  var_6 = 0;

  while(get_cortex_charge_percent() < 100) {
    var_7 = get_cortex_charge_percent();

    if(var_7 > 25 && var_6 < 25) {
      level notify("cortex_25_percent");
      thread medusa_25_state_fx();
    } else if(var_7 > 40 && var_6 < 40)
      level notify("dlc_vo_notify", "last_vo", "cortex_damaged");
    else if(var_7 > 50 && var_6 < 50) {
      level notify("cortex_50_percent");
      thread medusa_50_state_fx();
      level notify("dlc_vo_notify", "last_vo", "cortex_halfway");
    } else if(var_7 > 60 && var_6 < 60)
      level notify("dlc_vo_notify", "last_vo", "cortex_damaged");
    else if(var_7 > 75 && var_6 < 75) {
      thread medusa_75_state_fx();
      level notify("dlc_vo_notify", "last_vo", "cortex_almost");
      level thread medusa_shock_behavior();
    }

    var_6 = var_7;
    setomnvar("ui_alien_boss_progression", 100 - var_7);
    wait 0.2;
  }

  level notify("cortex_100_percent");
  setomnvar("ui_alien_boss_progression", 0);
  var_5.ignoreme = 1;
  level notify("dlc_vo_notify", "last_vo", "cortex_full");
  var_0 maps\mp\alien\_hive::destroy_hive_icon();
  var_0 thread maps\mp\alien\_hive::set_hive_icon("waypoint_alien_cortex_detonate", 1300);
  var_1 = getent("cortex_canister", "targetname");

  if(isDefined(var_1))
    maps\mp\alien\_outline_proto::add_to_outline_hive_watch_list(var_1);

  level thread play_godfather_vo("last_gdf_detonatethecortex");
  var_8 = ["last_gdf_detonatethecortex"];
  level thread maps\mp\mp_alien_last::last_nag_vo_until_flag(var_8, "cortex_detonated");
  level thread players_use_cortex_monitor(var_0, "cortex_detonate_hint");
  wait_for_all_player_use();

  foreach(var_3 in level.players)
  var_3 forceusehintoff(&"MP_ALIEN_LAST_CORTEX_DETONATE_HINT");

  setomnvar("ui_alien_boss_status", 0);
  setomnvar("ui_alien_boss_progression", 0);

  if(isDefined(level.current_encounter_info) && isDefined(level.current_encounter_info.force_end_func))
    [[level.current_encounter_info.force_end_func]]();

  if(!common_scripts\utility::flag("start_last_stand"))
    common_scripts\utility::flag_set("start_last_stand");

  common_scripts\utility::flag_set("cortex_detonated");
  var_0 maps\mp\alien\_hive::destroy_hive_icon();
  var_0 sethintstring("");

  if(isDefined(var_1))
    maps\mp\alien\_outline_proto::remove_from_outline_hive_watch_list(var_1);
}

add_cortex_charge(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = get_cortex_charge_max(level.players.size);
    var_0 = int(var_1 / 100.0 * var_2);
  }

  level.cortex_charge = level.cortex_charge + var_0;
}

subtract_cortex_charge(var_0) {
  add_cortex_charge(var_0 * -1);
}

get_cortex_charge_max(var_0) {
  if(!isDefined(var_0))
    var_0 = level.players.size;

  if(var_0 == 0)
    var_0 = 1;

  var_1 = 55000;

  if(var_0 == 1)
    var_1 = 38000;
  else if(var_0 == 2)
    var_1 = 55000;
  else if(var_0 == 3)
    var_1 = 88000;
  else if(var_0 == 4)
    var_1 = 115000;

  if(maps\mp\alien\_utility::is_hardcore_mode())
    return var_1 * 1.15;
  else
    return var_1;
}

get_cortex_charge_percent() {
  cortex_scale_current_charge();
  return level.cortex_charge / get_cortex_charge_max() * 100.0;
}

cortex_scale_current_charge() {
  if(level.num_cortex_players != level.players.size) {
    var_0 = get_cortex_charge_max(level.players.size) / get_cortex_charge_max(level.num_cortex_players);
    level.cortex_charge = level.cortex_charge * var_0;
    level.num_cortex_players = level.players.size;
  }
}

cortex_attack_point_logic() {
  self makeentitysentient("allies");
  self.maxhealth = 100000;
  self.health = 99999;
  thread cortex_threat_think(self);
  self setCanDamage(1);
  thread cortex_monitor_health();
}

cortex_threat_think(var_0) {
  level endon("game_ended");
  level endon("cortex_100_percent");
  var_1 = 1;

  for(;;) {
    if(level.final_battle_stage == 1 && get_cortex_charge_percent() < 10 || level.final_battle_stage == 2 && get_cortex_charge_percent() < 22 || level.final_battle_stage == 3 && get_cortex_charge_percent() < 50 || level.final_battle_stage == 4 && get_cortex_charge_percent() < 78) {
      var_0.ignoreme = 1;
      var_0.threatbias = -5000;
      wait(var_1);
      continue;
    }

    var_0.ignoreme = 0;
    var_2 = 0;
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(isDefined(var_5) && isalive(var_5)) {
        var_3++;
        var_2 = var_2 + distance2d(var_5.origin, var_0.origin);
      }
    }

    if(var_3 == 0) {
      var_0.threatbias = int(-3000);
      wait(var_1);
      continue;
    }

    var_7 = var_2 / max(1, var_3);

    if(maps\mp\alien\_utility::is_true(level.room_exploit_threat_active))
      var_0.threatbias = int(-8000);
    else if(var_7 < 2500)
      var_0.threatbias = int(-3000);
    else if(var_7 > 5000)
      var_0.threatbias = int(-1200);
    else {
      var_8 = 2500;
      var_9 = 1800;
      var_10 = (var_7 - 2500) / var_8;
      var_11 = var_10 * var_9;
      var_0.threatbias = int(-3000 + var_11);
    }

    wait(var_1);
  }
}

cortex_monitor_health() {
  level endon("game_ended");
  level endon("cortex_100_percent");

  for(;;) {
    var_0 = 0;
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_2.team) && var_2.team == "allies")
      var_0 = 1;

    if(!var_0 && level.cortex_charge > 0) {
      level notify("dlc_vo_notify", "cortex_attack");
      self playSound("scn_dscnt_alien_pod_hit");
      var_6 = int(var_1 * 3.5);
      maps\mp\alien\_gamescore::update_team_encounter_performance("cortex", "damage_done_on_cortex", var_6);
      subtract_cortex_charge(var_6);
    }
  }
}

players_use_cortex_monitor(var_0, var_1) {
  level endon("all_players_using_cortex");

  foreach(var_3 in level.players)
  var_3 thread watch_for_use_cortex_trigger(var_0, var_1);

  for(;;) {
    level waittill("connected", var_3);
    var_3 thread watch_for_use_cortex_trigger(var_0, var_1);
  }
}

wait_for_all_player_use() {
  level endon("game_ended");

  while(!are_all_players_using_cortex())
    wait 0.05;

  level notify("all_players_using_cortex");
}

are_all_players_using_cortex() {
  var_0 = 1;

  foreach(var_2 in level.players) {
    if(!isDefined(var_2.player_using_cortex) || !var_2.player_using_cortex)
      var_0 = 0;
  }

  return var_0;
}

watch_for_use_cortex_trigger(var_0, var_1) {
  level endon("game_ended");
  level endon("all_players_using_cortex");
  self endon("disconnect");
  self notify("watch_for_use_cortex");
  self endon("watch_for_use_cortex");
  self.player_using_cortex = 0;
  var_2 = & "MP_ALIEN_LAST_CORTEX_START_HINT";

  if(var_1 == "cortex_detonate_hint")
    var_2 = & "MP_ALIEN_LAST_CORTEX_DETONATE_HINT";

  var_3 = 16900;

  for(;;) {
    if(self ismeleeing() || self isthrowinggrenade() || !self isonground() || self getstance() == "prone")
      self forceusehintoff(var_2);
    else if(player_looking_at(var_0.origin, 0.7) && player_in_front_of(var_0.origin)) {
      if(distancesquared(self getEye(), var_0.origin) < var_3) {
        self forceusehinton(var_2);

        if(self usebuttonpressed()) {
          self.player_using_cortex = 1;
          self notify("using_cortex");
          thread reset_cortex_usage();
        }
      } else
        self forceusehintoff(var_2);
    } else
      self forceusehintoff(var_2);

    wait 0.05;
  }
}

reset_cortex_usage() {
  level endon("game_ended");
  level endon("all_players_using_cortex");
  self endon("death");
  self endon("disconnect");
  self endon("using_cortex");
  wait 0.5;
  self.player_using_cortex = 0;
}

player_looking_at(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0.8;

  var_2 = self getEye();
  var_3 = vectortoangles(var_0 - var_2);
  var_4 = anglesToForward(var_3);
  var_5 = self getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = vectordot(var_4, var_6);

  if(var_7 < var_1)
    return 0;

  var_8 = bulletTrace(var_0, var_2, 0);
  return var_8["fraction"] == 1;
}

player_in_front_of(var_0) {
  return self.origin[1] > var_0[1];
}

jump_to_return_to_base() {}

jump_to_final_left() {}

jump_to_final_middle() {}

jump_to_final_right() {
  wait 2.0;
}

jump_to_final_battle() {}

jump_to_ending() {}

shut_base_gates() {
  var_0 = level.outposts["main_base"].outpost_encounters["transition_left"];

  if(maps\mp\alien\_utility::is_true(var_0.completed))
    thread maps\mp\mp_alien_last_progression::opener_slide(var_0, 1);

  var_1 = level.outposts["main_base"].outpost_encounters["transition_middle"];

  if(maps\mp\alien\_utility::is_true(var_1.completed))
    thread maps\mp\mp_alien_last_progression::opener_slide(var_1, 1, 1);

  var_2 = level.outposts["main_base"].outpost_encounters["transition_right"];

  if(maps\mp\alien\_utility::is_true(var_2.completed))
    thread maps\mp\mp_alien_last_progression::opener_slide(var_2, 1);

  destroy_equipment_near_base_gates();
  var_3 = getEntArray("garage_front_gate_model", "targetname");
  var_4 = getent("garage_front_gate_clip", "targetname");

  foreach(var_6 in var_3)
  var_6 movez(-101, 2.0, 0.3, 0.1);

  var_4 movez(-101, 2.0, 0.3, 0.1);
  wait 2.2;
  var_4 disconnectpaths();
}

show_return_to_base_objective() {
  var_0 = "waypoint_alien_blocker";
  var_1 = 14;
  var_2 = 14;
  var_3 = 0.75;
  var_4 = self.origin + (0, 0, 75);
  var_5 = maps\mp\alien\_hud::make_waypoint(var_0, var_1, var_2, var_3, var_4);
  level waittill("start_cross_vignette");
  var_5 destroy();
}

debug_beat_ancestor_encounter() {
  level notify("debug_beat_current_encounter");
  wait 1.0;
}

cross_vignette_vo() {
  maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
  wait 3.6;
  thread maps\mp\mp_alien_last::play_cross_vo("last_crs_efforts1");
  wait 3.5;
  thread maps\mp\mp_alien_last::play_cross_vignette_vo("last_crs_sugarcoatit");
  wait 4.733;
  thread maps\mp\mp_alien_last::play_cross_vignette_vo("last_crs_efforts2");
  wait 2.933;
  thread maps\mp\mp_alien_last::play_cross_vignette_vo("last_crs_sugarcoatit2");
  wait 6.334;
  thread maps\mp\mp_alien_last::play_cross_vignette_vo("last_crs_cametothis");
  wait 8.233;
  var_0 = ["last_gdf_pickedaside"];
  thread maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
  wait 3;
  thread maps\mp\mp_alien_last::play_cross_vignette_vo("last_crs_dontbother");
  wait 10.86;
  var_0 = ["last_crs_thefate_r"];
  thread maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
  thread cross_gate_sfx();
  wait 6.93;
  var_0 = ["last_crs_thefate2_r"];
  thread maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
}

final_battle_vo() {
  wait 5;
  var_0 = ["last_gdf_righttoyou"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
  var_0 = ["last_gdf_powerupthecortex"];
  level thread maps\mp\mp_alien_last::last_nag_vo_until_flag(var_0, "cortex_started");
  common_scripts\utility::flag_wait("cortex_started");
  wait 2;
  var_0 = ["last_gdf_gametime"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
  common_scripts\utility::flag_set("final_battle_start_vo_over");

  while(get_cortex_charge_percent() < 25)
    wait 0.1;

  var_0 = ["last_gdf_powercellcharged"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);

  while(get_cortex_charge_percent() < 50)
    wait 0.1;

  var_0 = ["last_gdf_onyourgo"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);

  while(get_cortex_charge_percent() < 75)
    wait 0.1;

  var_0 = ["last_gdf_autosequence"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);

  while(get_cortex_charge_percent() < 95)
    wait 0.1;

  var_0 = ["last_gdf_medusadetonation"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
  common_scripts\utility::flag_wait("cortex_detonated");
  var_0 = ["last_spa_stage1ignition"];
  maps\mp\mp_alien_last::play_last_vignette_vo(var_0);
}

play_vo_on_final_ancestors_death() {
  level.dead_ancestors = 0;

  for(;;) {
    level waittill("ancestor_died");

    if(level.dead_ancestors == 1) {
      thread play_godfather_vo("last_gdf_still2more");
      continue;
    }

    if(level.dead_ancestors == 2) {
      thread play_godfather_vo("last_gdf_2down");
      continue;
    }

    if(level.dead_ancestors == 3)
      thread play_godfather_vo("last_gdf_allthreedown");
  }
}

play_godfather_vo(var_0, var_1) {
  level endon("debug_beat_current_encounter");
  level endon("game_ended");

  if(isDefined(var_1))
    wait(var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(!soundexists(var_0)) {
    return;
  }
  while(maps\mp\mp_alien_last::vo_system_is_paused())
    wait 0.1;

  maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);

  while(maps\mp\alien\_music_and_dialog_dlc::is_vo_system_playing())
    wait 0.1;

  wait 0.25;
  var_2 = lookupsoundlength(var_0) / 1000;
  thread maps\mp\mp_alien_last::play_global_vo(var_0);
  wait(var_2);
  maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

medusa_on_state_fx() {
  var_0 = getent("medusa_scriptable", "targetname");
  var_0 setscriptablepartstate("base", "on");
}

medusa_25_state_fx() {
  thread cortex_sfx_25per();
  var_0 = getent("medusa_scriptable", "targetname");
  var_0 setscriptablepartstate("base", "25percent");
}

medusa_50_state_fx() {
  thread cortex_sfx_50per();
  var_0 = getent("medusa_scriptable", "targetname");
  var_0 setscriptablepartstate("base", "50percent");
}

medusa_75_state_fx() {
  thread cortex_sfx_75per();
  var_0 = getent("medusa_scriptable", "targetname");
  var_0 setscriptablepartstate("base", "75percent");
}

medusa_100_state_fx() {
  thread cortex_sfx_100per();
  var_0 = getent("medusa_scriptable", "targetname");
  var_0 setscriptablepartstate("base", "100percent");
}

cortex_sfx_on() {
  level.cortex_sfx1 playSound("scn_medusa_power_on");
  level.cortex_sfx2 playLoopSound("scn_medusa_thrum_lp");
  wait 4;
  level.cortex_sfx3 playLoopSound("scn_medusa_running_lp");
}

cortex_sfx_25per() {
  level.cortex_sfx1 playSound("scn_medusa_25per");
  level.cortex_sfx3 stoploopsound("scn_medusa_running_lp");
  wait 2.5;
  level.cortex_sfx3 playLoopSound("scn_medusa_25_lp");
}

cortex_sfx_50per() {
  level.cortex_sfx1 playSound("scn_medusa_50per");
  level.cortex_sfx3 stoploopsound("scn_medusa_25_lp");
  wait 2.5;
  level.cortex_sfx3 playLoopSound("scn_medusa_50_lp");
}

cortex_sfx_75per() {
  level.cortex_sfx1 playSound("scn_medusa_75per");
  level.cortex_sfx3 stoploopsound("scn_medusa_50_lp");
  wait 2.5;
  level.cortex_sfx3 playLoopSound("scn_medusa_75_lp");
}

cortex_sfx_100per() {
  level.cortex_sfx1 playSound("scn_medusa_100per");
  level.cortex_sfx3 stoploopsound("scn_medusa_75_lp");
}

medusa_shock_behavior() {
  var_0 = 0;
  var_1 = 5;
  var_2 = 10;
  var_3 = (400, -656, 1203.5);
  var_4 = getent("cortex_base", "targetname");
  var_4.attack_bolt = spawn("script_model", var_3);
  var_4.attack_bolt setModel("tag_origin");
  var_5 = 2250000;
  var_4.damage_amount = 750;

  for(;;) {
    foreach(var_7 in level.agentarray) {
      if(!isDefined(var_7.alien_type)) {
        continue;
      }
      if(!maps\mp\alien\_utility::is_true(var_7.isactive) || !isalive(var_7)) {
        continue;
      }
      if(maps\mp\alien\_utility::is_true(var_7.pet)) {
        continue;
      }
      if(maps\mp\alien\_utility::is_true(var_7.is_electrified)) {
        continue;
      }
      if(var_7.alien_type == "ancestor") {
        continue;
      }
      var_8 = var_7.origin + (0, 0, 30);

      if(var_7.alien_type == "elite")
        var_8 = var_7 gettagorigin("tag_eye");

      if(distancesquared(var_3, var_8) > var_5) {
        continue;
      }
      if(bullettracepassed(var_8, var_3, 0, var_4)) {
        var_7.is_electrified = 1;
        var_7 thread maps\mp\mp_alien_last_traps::tesla_trap_attack(var_4, var_8);
        var_4 maps\mp\mp_alien_last_traps::reset_attack_bolt(var_3);
        wait(randomfloatrange(var_1, var_2));
        break;
      }
    }

    wait 0.05;
  }
}

destroy_equipment_near_base_gates() {
  var_0 = (-682, -96, 63);
  var_1 = (1470, -84, 63);
  var_2 = (339, 493, 21);
  var_3 = (468, 493, 21);
  destroy_all_equipment_near(var_0);
  destroy_all_equipment_near(var_1);
  destroy_all_equipment_near(var_2);
  destroy_all_equipment_near(var_3);
}

destroy_all_equipment_near(var_0) {
  destroy_equipment_near(var_0, level.turrets);
  destroy_equipment_near(var_0, level.placedims);
}

destroy_equipment_near(var_0, var_1) {
  var_2 = 6400;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(!isDefined(var_4.origin)) {
      continue;
    }
    if(isDefined(var_4.carriedby)) {
      continue;
    }
    if(distancesquared(var_0, var_4.origin) <= var_2)
      var_4 notify("death");
  }
}

sfx_gate_left_bend() {
  playsoundatpos((-556, -751, 104), "scn_gate_mtl_01");
}

sfx_gate_left_expl() {
  playsoundatpos((-556, -751, 104), "scn_gate_expl_01");
}

sfx_gate_middle_bend() {
  wait 3;
  playsoundatpos((426, 474, 73), "scn_gate_mtl_02");
}

sfx_gate_middle_expl() {
  playsoundatpos((426, 474, 73), "scn_gate_expl_02");
}

sfx_gate_right_bend() {
  playsoundatpos((1348, -775, 132), "scn_gate_mtl_03");
}

sfx_gate_right_expl() {
  playsoundatpos((1348, -775, 132), "scn_gate_expl_03");
}

sfx_cross_shield_lp() {
  var_0 = spawn("script_origin", level.dr_cross.origin);
  var_0 playLoopSound("cross_shield_lp");
  level waittill("shield_down");
  var_0 stoploopsound();
  var_0 playSound("cross_shield_down");
  wait 3;
  var_0 delete();
}

sfx_cross_land() {
  wait 0.1;
  playsoundatpos(level.dr_cross.origin, "scn_cross_end_01");
  thread play_cross_music();
  thread sfx_cross_foley_01();
}

play_cross_music() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    wait 0.1;

    if(!common_scripts\utility::flag("exfil_music_playing"))
      level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc4_cross_scene");
  }
}

sfx_cross_cortex() {
  wait 11.66;
  playsoundatpos(level.dr_cross.origin, "scn_cross_end_02");
  thread sfx_cross_foley_02();
}

sfx_cross_teleport() {
  wait 33.4;
  playsoundatpos(level.dr_cross.origin, "scn_cross_end_03");
}

sfx_cross_foley_01() {
  wait 3.457;
  playsoundatpos(level.dr_cross.origin, "scn_cross_end_foley_01");
}

sfx_cross_foley_02() {
  wait 7.594;
  playsoundatpos(level.dr_cross.origin, "scn_cross_end_foley_02");
  thread sfx_cross_foley_03();
}

sfx_cross_foley_03() {
  wait 10.597;
  playsoundatpos(level.dr_cross.origin, "scn_cross_end_foley_03");
}

last_end_music_sfx() {
  playsoundatpos((0, 0, 0), "scn_last_end");
  level.cortex_sfx3 stoploopsound("scn_medusa_75_lp");
  level.cortex_sfx2 stoploopsound("scn_medusa_thrum_lp");

  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    wait 0.1;

    if(!common_scripts\utility::flag("exfil_music_playing"))
      level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc4_end");
  }
}

play_end_ancestor_music() {
  if(level.ancestor_music_played == 0) {
    foreach(var_1 in level.players) {
      if(common_scripts\utility::flag("alien_music_playing")) {
        var_1 stoplocalsound("mp_suspense_01");
        var_1 stoplocalsound("mp_suspense_02");
        var_1 stoplocalsound("mp_suspense_03");
        var_1 stoplocalsound("mp_suspense_04");
        var_1 stoplocalsound("mp_suspense_05");
        var_1 stoplocalsound("mp_suspense_06");
        var_1 stoplocalsound("mus_alien_newwave");
        common_scripts\utility::flag_clear("alien_music_playing");
      }

      if(maps\mp\_utility::isreallyalive(var_1))
        var_1 thread ancestor_music();
    }
  }
}

ancestor_music() {
  wait 1;
  common_scripts\utility::flag_set("alien_music_playing");
  wait 15.5;
  self playlocalsound("mus_alien_dlc4_ancestor_gate");
  level.ancestor_music_played = 1;
  wait 50;
  self playlocalsound("mus_alien_dlc4_ancestor_fight");
}

cross_gate_sfx() {
  wait 3.8;
  level.dr_cross playSound("scn_cross_gate");
}

check_for_room_exploit() {
  level endon("game_ended");
  level endon("cortex_detonated");
  var_0 = 0;
  var_1 = 5000;
  level.room_exploit_threat_active = 0;
  var_2 = getent("main_base_threat_volume", "targetname");

  if(!isDefined(var_2)) {
    return;
  }
  for(;;) {
    var_3 = 0;

    foreach(var_5 in level.players) {
      if(var_5 istouching(var_2))
        var_3++;
    }

    if(var_0 == 0 && var_3 >= level.players.size * 0.75)
      var_0 = gettime();
    else if(var_3 < level.players.size * 0.75)
      var_0 = 0;

    if(var_0 != 0 && gettime() - var_0 > var_1)
      level.room_exploit_threat_active = 1;
    else
      level.room_exploit_threat_active = 0;

    wait 0.5;
  }
}

initial_entity_setup() {
  var_0 = getent("front_gate_mantle", "targetname");
  var_0 movez(-200, 0.1);
  var_1 = getent("node_shelf", "targetname");
  var_1 delete();
  var_2 = getEntArray("main_base_right_gate", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_parameters) && var_4.script_parameters == "exploder") {
      var_4 notsolid();
      var_4 hide();
    }
  }

  var_2 = getEntArray("main_base_left_gate", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_parameters) && var_4.script_parameters == "exploder") {
      var_4 notsolid();
      var_4 hide();
    }
  }

  var_8 = getnodearray("main_gate_ramp_nodes", "targetname");

  foreach(var_10 in var_8)
  var_10 disconnectnode();
}