/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\proxywar\proxywar_warehouse.gsc
***************************************************/

proxywar_warehouse_precache() {
  precacheshader("gasmask_overlay_delta2");
  precachemodel("hat_usmc_raiders_ar_1_gasmask");
  precachemodel("hat_usmc_raiders_ar_3_gasmask");
  precachemodel("hat_usmc_raiders_ar_4_gasmask");
  precachemodel("hat_usmc_raiders_ar_5_gasmask");
  precachemodel("offhand_wm_c4_bomb");
  precachemodel("helmet_ai_nvg_london_militarize_police");
  precachemodel("uk_industrial_light_01_on");
  precachemodel("uk_industrial_light_01");
  precachemodel("ee_light_mounted_exterior_industrial_caged_02_on");
  precachemodel("ee_light_mounted_exterior_industrial_caged_02");
}

proxywar_warehouse_flags() {
  scripts\engine\utility::flag_init("reached_warehouse_foyer");
  scripts\engine\utility::flag_init("allies_ready_to_approach_gate");
  scripts\engine\utility::flag_init("allies_ready_at_gate");
  scripts\engine\utility::flag_init("displayed_early_objective_hint");
  scripts\engine\utility::flag_init("lights_out");
  scripts\engine\utility::flag_init("reached_warehouse_interior");
  scripts\engine\utility::flag_init("reached_warehouse_metal_clang");
  scripts\engine\utility::flag_init("reached_warehouse_first_run");
  scripts\engine\utility::flag_init("reached_warehouse_branch");
  scripts\engine\utility::flag_init("warehouse_went_left");
  scripts\engine\utility::flag_init("warehouse_went_right");
  scripts\engine\utility::flag_init("reached_warehouse_mid");
  scripts\engine\utility::flag_init("reached_warehouse_stack_loop");
  scripts\engine\utility::flag_init("reached_warehouse_forklift");
  scripts\engine\utility::flag_init("reached_warehouse_catwalk_failsafe");
  scripts\engine\utility::flag_init("final_defender_killed");
  scripts\engine\utility::flag_init("catwalk_defender_visible");
  scripts\engine\utility::flag_init("reached_warehouse_shelves");
  scripts\engine\utility::flag_init("reached_warehouse_shelf_mid");
  scripts\engine\utility::flag_init("reached_warehouse_end");
  scripts\engine\utility::flag_init("warehouse_backtracking");
  scripts\engine\utility::flag_init("killed_runner1");
  scripts\engine\utility::flag_init("killed_runner2");
  scripts\engine\utility::flag_init("failsafe_kill_defender");
  scripts\engine\utility::flag_init("near_power_lever");
  scripts\engine\utility::flag_init("find_power_vo_done");
  scripts\engine\utility::flag_init("warehouse_power_on");
  scripts\engine\utility::flag_init("done_objective_hint");
  scripts\engine\utility::flag_init("facing_russian_scene");
  scripts\engine\utility::flag_init("start_inspect_body");
  scripts\engine\utility::flag_init("pointed_out_gas");
  scripts\engine\utility::flag_init("found_chemical_weapons");
  scripts\engine\utility::flag_init("player_mask_on");
  scripts\engine\utility::flag_init("started_swabbing");
  scripts\engine\utility::flag_init("finished_swabbing");
  scripts\engine\utility::flag_init("player_occupied");
  scripts\engine\utility::flag_init("aimed_flashbang");
  scripts\engine\utility::flag_init("threw_flashbang");
}

proxywar_warehouse_hints() {
  scripts\engine\sp\utility::add_hint_string("flashlight_equip", &"PROXYWAR/TUT_FLASHLIGHT", ::flashlight_equip_hint_check);
  scripts\engine\sp\utility::add_hint_string("objective_tutorial", &"PROXYWAR/TUT_OBJECTIVE", ::objective_tutorial_hint_check);
  scripts\engine\sp\utility::add_hint_string("aim_flashbang", &"PROXYWAR/AIM_FLASHBANG", ::has_aimed_flashbang);
  scripts\engine\sp\utility::add_hint_string("aim_flashbang_toggle", &"PROXYWAR/AIM_FLASHBANG_TOGGLE", ::has_aimed_flashbang);
  scripts\engine\sp\utility::add_hint_string("throw_flashbang", &"PROXYWAR/THROW_FLASHBANG", ::has_thrown_flashbang);
  scripts\engine\sp\utility::add_hint_string("throw_flashbang_toggle", &"PROXYWAR/THROW_FLASHBANG_TOGGLE", ::has_thrown_flashbang);
}

proxywar_warehouse_spawn_func() {
  scripts\engine\sp\utility::array_spawn_function_targetname("warehouse_laststand_group", ::warehouse_laststand_spawn_func);
}

proxywar_warehouse_init() {
  level.ap_power_lever = scripts\engine\utility::getStruct("ap_power_lever", "targetname");
  level.power_lever = scripts\engine\sp\utility::spawn_anim_model("power_lever");

  if(!scripts\sp\starts::is_after_start("warehouse_discover_gas"))
    level.ap_power_lever scripts\common\anim::anim_first_frame_solo(level.power_lever, "turn_on_power");

  level.player notifyonplayercommand("secondary_offhand_pressed", "+smoke");
}

warehouse_enter_start() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams(0);
  scripts\engine\sp\utility::set_start_location("start_warehouse_combat", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));

  foreach(var_1 in level.alpha_and_bravo_team)
  var_1 scripts\asm\shared\utility::toggle_poiauto(1);
}

warehouse_enter_main() {
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::battlechatter_off);
  scripts\engine\utility::exploder("warehouse_camcentr");
  scripts\engine\utility::stop_exploder("factory_ext_camcentr");
  scripts\engine\utility::stop_exploder("begin_amb_fx");
  level.warehousegate = scripts\sp\maps\proxywar\proxywar_util.gsc::setup_scripted_door("warehouse_sliding_door");
  level.warehousegateopenref = scripts\engine\utility::getStruct("ref_open_warehouse_gate", "targetname");
  level.doorarrivalcount = 0;
  level.doorgatecount = 0;
  scripts\sp\maps\proxywar\proxywar_util.gsc::disable_allies_firing();
  level.alpha1 thread alpha1_move_into_warehouse();
  level.bravo1 thread bravo1_move_into_warehouse();
  level.bravo2 thread bravo2_move_into_warehouse();
  level.bravo3 thread bravo3_move_into_warehouse();
  scripts\engine\utility::flag_wait("allies_ready_to_approach_gate");
  var_0 = [level.alpha1, level.bravo1, level.bravo2];
  scripts\engine\utility::flag_wait("reached_warehouse_foyer");
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_we_door_approach();
  level thread scripts\sp\player::player_movement_state("cqb");
  level.alpha1 thread gate_team_approach_and_mask_up("gasmask1");
  level.bravo1 thread gate_team_approach_and_mask_up("gasmask2");
  level.bravo2 thread gate_team_approach_and_mask_up("gasmask3");
  level.bravo3 thread bravo3_approach_and_mask_up();
  scripts\engine\utility::flag_wait("allies_ready_at_gate");
  level thread check_nag_to_warehouse_door();
  scripts\engine\utility::flag_wait("near_warehouse_door");

  if(scripts\engine\utility::flag("displayed_early_objective_hint"))
    scripts\engine\utility::flag_set("done_objective_hint");

  scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_we_open_door();
  level thread wait_turn_off_lights();
  level.warehousegate.animname = "warehouse_gate";
  level.warehousegate scripts\common\anim::setanimtree();
  level.warehousegateopenref notify("end_open_idle");

  foreach(var_2 in level.alpha_and_bravo_team)
  var_2 scripts\common\utility::demeanor_override("cqb");

  level.alpha1 thread gate_team_open_and_enter();
  level.bravo1 thread gate_team_open_and_enter();
  level.bravo2 thread gate_team_open_and_enter();
  level.bravo3 scripts\engine\utility::set_movement_speed(50);
  level.warehousegateopenref thread scripts\common\anim::anim_single_solo(level.warehousegate, "warehouse_gate_open_start");
  level.warehousegate.clip connectpaths();
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_clear_warehouse", "targetname").origin);
  scripts\engine\utility::flag_wait("reached_warehouse_interior");
  scripts\engine\utility::flag_clear("done_objective_hint");
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_entered_main_warehouse();
  scripts\engine\utility::flag_wait("reached_warehouse_metal_clang");
  thread scripts\engine\utility::play_sound_in_space("emt_metal_fall_impact", scripts\engine\utility::getStruct("sfx_metal_clang", "targetname").origin);
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_hear_enemies();
  level thread scripts\engine\sp\utility::autosave_by_name("warehouse_combat");
  scripts\engine\utility::flag_wait("reached_warehouse_first_run");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_2");
  var_4 = scripts\engine\sp\utility::array_spawn_targetname("warehouse_laststand_group", 1);
  var_5 = getEnt("runner1", "script_noteworthy");
  var_5 thread runner1_behavior();
  var_6 = getEnt("catwalk_defender", "script_noteworthy");
  var_6 thread catwalk_defender_behavior();
  var_7 = getEnt("runner2", "script_noteworthy");
  var_7 thread runner2_behavior();
  level.finaldefender = getEnt("final_defender", "script_noteworthy");
  level.finaldefender thread final_defender_behavior();
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_first_contact();
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_first_runner();
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_kill_runner1(var_5);
  scripts\engine\utility::flag_wait("reached_warehouse_branch");
  scripts\sp\maps\proxywar\proxywar_util.gsc::enable_allies_firing();
  scripts\engine\utility::flag_wait_either("warehouse_went_left", "warehouse_went_right");

  foreach(var_2 in level.alpha_and_bravo_team)
  var_2 scripts\engine\utility::set_movement_speed(60);

  level.bravo3 scripts\asm\shared\utility::toggle_poiauto(1);

  if(scripts\engine\utility::flag("warehouse_went_left")) {
    scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_branch_right_1");
    scripts\engine\utility::flag_wait_all("reached_warehouse_stack_loop");
    scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_branch_right_2");
    scripts\engine\utility::flag_wait_all("reached_warehouse_forklift");
    scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_branch_right_3");
  } else {
    scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_branch_left_1");
    scripts\engine\utility::flag_wait_all("reached_warehouse_stack_loop", "killed_runner1");
    scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_branch_left_2");
    wait 3;
    scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_branch_left_3");
    scripts\engine\utility::flag_wait_all("reached_warehouse_forklift");
    scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_branch_left_4");
  }

  scripts\engine\utility::flag_wait_all("reached_warehouse_forklift", "killed_runner1");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_3");
  scripts\engine\utility::flag_wait("killed_runner2");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_4");
  scripts\engine\utility::flag_wait("reached_warehouse_shelves");
  level.warehousegate.origin = scripts\engine\utility::getStruct("warehouse_sliding_door_closed", "targetname").origin;
  level thread scripts\engine\sp\utility::transient_unload_array(["pw_storage_room_interior_tr", "pw_control_room_interior_tr", "pw_shack_interior_tr", "pw_trainyard_main_detail_tr", "pw_trainyard_track_detail_tr", "pw_railyard_rear_detail_tr", "pw_courtyard_top_detail_tr"]);
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_5");
  scripts\engine\utility::flag_wait("reached_warehouse_shelf_mid");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_6");
  scripts\engine\sp\utility::waittill_ai_group_dead("warehouse_laststand_group");
  scripts\engine\utility::flag_wait("final_defender_killed");
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_in_warehouse_7");
  scripts\sp\maps\proxywar\proxywar_util.gsc::disable_allies_firing();
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_all_dead();
}

warehouse_enter_catchup() {
  scripts\engine\utility::exploder("warehouse_camcentr");
  scripts\engine\utility::stop_exploder("factory_ext_camcentr");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_clear_warehouse", "targetname").origin);
  scripts\sp\maps\proxywar\proxywar_util.gsc::gasmask_on(1);

  foreach(var_1 in level.alpha_and_bravo_team) {
    var_1 detach(var_1.hatmodel);
    var_1.hatmodel = var_1.hatmodel + "_gasmask";
    var_1 attach(var_1.hatmodel);
  }
}

check_nag_to_warehouse_door() {
  level endon("near_warehouse_door");
  level endon("reached_warehouse_interior");
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_we_nag_enter_warehouse();
  wait 10;

  if(scripts\engine\utility::flag("near_warehouse_door") || scripts\engine\utility::flag("reached_warehouse_interior")) {
    return;
  }
  scripts\engine\utility::flag_set("displayed_early_objective_hint");
  scripts\engine\sp\utility::display_hint_forced("objective_tutorial");
  level.player notifyonplayercommand("objective_pressed", "+focus");
  level.player waittill("objective_pressed");
  scripts\engine\utility::flag_set("done_objective_hint");
}

alpha1_move_into_warehouse() {
  scripts\common\ai::set_gunpose("disable", 1);
  scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();
  thread scripts\sp\maps\proxywar\proxywar_util.gsc::teleport_if_clear(getnode("warehouse_foyer_corridor_right", "targetname"), "a1_safe_teleport", "a1_reached_node", (0, 0, 60));
  scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_node_targetname("warehouse_foyer_corridor_right");
  level notify("a1_reached_node");
  scripts\engine\utility::set_movement_speed(randomintrange(80, 110));
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_we_alpha1_enter_warehouse();
  level thread entered_foyer_timer();
  door_team_member_arrived();
}

entered_foyer_timer() {
  wait 3;
  scripts\engine\utility::flag_set("reached_warehouse_foyer");
}

bravo1_move_into_warehouse() {
  scripts\common\ai::set_gunpose("disable", 1);
  scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();
  thread scripts\sp\maps\proxywar\proxywar_util.gsc::teleport_if_clear(getnode("warehouse_foyer_corridor_rear", "targetname"), "b1_safe_teleport", "b1_reached_node", (0, 0, 60));
  scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_node_targetname("warehouse_foyer_corridor_rear");
  level notify("b1_reached_node");
  scripts\engine\utility::set_movement_speed(randomintrange(80, 110));
  door_team_member_arrived();
}

bravo2_move_into_warehouse() {
  scripts\common\ai::set_gunpose("disable", 1);
  scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();
  thread scripts\sp\maps\proxywar\proxywar_util.gsc::teleport_if_clear(getnode("warehouse_foyer_enter_left", "targetname"), "b2_safe_teleport", "b2_reached_node", (0, 0, 60));
  scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_node_targetname("warehouse_foyer_enter_left");
  level notify("b2_reached_node");
  scripts\engine\utility::set_movement_speed(randomintrange(80, 110));
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_we_bravo2_enter_warehouse();
  scripts\engine\utility::flag_wait("reached_warehouse_foyer");
  door_team_member_arrived();
}

bravo3_move_into_warehouse() {
  scripts\common\ai::set_gunpose("ready");
  scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_courtyard();
  thread scripts\sp\maps\proxywar\proxywar_util.gsc::teleport_if_clear(getnode("warehouse_foyer_enter_right", "targetname"), "b3_safe_teleport", "b3_reached_node", (0, 0, 60));
  scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_node_targetname("warehouse_foyer_enter_right");
  level notify("b3_reached_node");
  scripts\engine\utility::set_movement_speed(randomintrange(80, 110));
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_we_bravo3_enter_warehouse();
  scripts\asm\shared\utility::toggle_poiauto(0);
  wait 3;
  scripts\common\ai::set_gunpose("disable", 1);
}

door_team_member_arrived() {
  level.doorarrivalcount++;

  if(level.doorarrivalcount > 2)
    scripts\engine\utility::flag_set("allies_ready_to_approach_gate");
}

gate_team_approach_and_mask_up(var_0) {
  level.warehousegateopenref scripts\sp\anim::anim_reach_solo(self, "warehouse_gate_open_enter");
  thread mask_anim(var_0);
  level.warehousegateopenref scripts\common\anim::anim_single_solo(self, "warehouse_gate_open_enter");
  level.warehousegateopenref thread scripts\common\anim::anim_loop_solo(self, "warehouse_gate_open_idle", "end_open_idle");
  door_team_member_at_gate();
}

mask_anim(var_0) {
  var_1 = scripts\engine\sp\utility::spawn_anim_model(var_0);
  level.warehousegateopenref scripts\common\anim::anim_single_solo(var_1, "warehouse_gate_open_enter");
  var_1 delete();
}

bravo3_approach_and_mask_up() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_node_targetname("warehouse_foyer_gate_right");
}

gate_team_open_and_enter() {
  scripts\asm\shared\utility::toggle_poiauto(0);
  level.warehousegateopenref scripts\common\anim::anim_single_solo(self, "warehouse_gate_open_start");
  level.warehousegateopenref thread scripts\common\anim::anim_loop_solo(self, "warehouse_gate_open_cover_idle", "end_cover_idle");
  scripts\engine\utility::flag_wait_either("warehouse_went_left", "warehouse_went_right");
  level.warehousegateopenref notify("end_cover_idle");
  level.warehousegateopenref scripts\common\anim::anim_single_solo(self, "warehouse_gate_open_cover_exit");
  scripts\engine\utility::set_movement_speed(50);
  scripts\engine\sp\utility::enable_ai_color();
  scripts\asm\shared\utility::toggle_poiauto(1);
}

door_team_member_at_gate() {
  level.doorgatecount++;

  if(level.doorgatecount > 2)
    scripts\engine\utility::flag_set("allies_ready_at_gate");
}

wait_turn_off_lights() {
  level waittill("turn_off_lights");
  scripts\engine\utility::flag_set("lights_out");
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::mus_lightsout();
  turn_off_lights();
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_we_power_off();
  wait 1;
  level.alpha1 scripts\sp\utility::enable_flashlight(1);
  wait 1;
  level.bravo1 scripts\sp\utility::enable_flashlight(1);
  wait 0.5;
  level.bravo2 scripts\sp\utility::enable_flashlight(1);
  wait 0.25;
  level.bravo3 scripts\sp\utility::enable_flashlight(1);
  level thread flashlight_tutorial();
}

warehouse_laststand_spawn_func() {
  self endon("death");
  scripts\engine\sp\utility::set_grenadeammo(0);
  self.accuracy = 0.05;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.dontevershoot = 1;
}

enable_firing() {
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.dontevershoot = 0;
}

disable_firing() {
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.dontevershoot = 1;
}

runner1_behavior() {
  self endon("death");
  self endon("stop_running");
  self.maxfaceenemydist = 0;
  scripts\common\utility::demeanor_override("sprint");
  self waittill("reached_path_end");
  scripts\engine\utility::flag_wait_either("warehouse_went_left", "warehouse_went_right");
  self.maxfaceenemydist = 512;

  if(scripts\engine\utility::flag("warehouse_went_left")) {
    if(!level.player scripts\engine\trace::can_see_origin(self gettagorigin("j_spine4"), 0))
      scripts\engine\sp\utility::teleport_ai(getnode("run_1_4", "targetname"));

    self setgoalvolumeauto(getEnt("cover_left_path", "targetname"));
  } else
    self setgoalvolumeauto(getEnt("cover_right_path", "targetname"));

  enable_firing();
  scripts\common\utility::demeanor_override("cqb");
}

runner2_behavior() {
  self endon("death");
  self.deathfunction = ::runner2_deathfunc;
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_shelf_runner_killed(self);
  scripts\engine\utility::flag_wait("reached_warehouse_forklift");
  enable_firing();
  wait 3;
  scripts\common\utility::demeanor_override("sprint");
  self setgoalvolumeauto(getEnt("rear_mid_cover", "targetname"));
}

runner2_deathfunc() {
  if(!scripts\engine\utility::flag("reached_warehouse_shelves"))
    level thread scripts\engine\sp\utility::autosave_by_name("warehouse_combat_mid");

  return 0;
}

check_defender_damaged() {
  self waittill("damage");
  enable_firing();
  scripts\common\utility::clear_demeanor_override();
}

catwalk_defender_behavior() {
  self endon("death");
  thread check_is_visible();
  self.ignoreme = 1;
  self.a.disablelongdeath = 1;
  scripts\common\utility::demeanor_override("sprint");
  childthread check_defender_damaged();
  scripts\engine\utility::flag_wait_either("reached_warehouse_catwalk_failsafe", "catwalk_defender_visible");
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_catwalk_defender();
  self setgoalvolumeauto(getEnt("catwalk_mid", "targetname"));
  wait 2;
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_catwalk_defender_moved();
  scripts\engine\utility::flag_wait_either("reached_warehouse_shelves", "warehouse_backtracking");

  if(scripts\engine\utility::flag("reached_warehouse_shelves")) {
    self.maxfaceenemydist = 0;
    self setgoalvolumeauto(getEnt("catwalk_end", "targetname"));
    enable_firing();
    wait 5;
    self.ignoreme = 0;
    self.maxfaceenemydist = 512;
  } else {
    self.maxfaceenemydist = 0;
    self setgoalvolumeauto(getEnt("catwalk_end_backtrack", "targetname"));
    enable_firing();
    wait 5;
    self.ignoreme = 0;
    self.maxfaceenemydist = 512;
  }
}

check_is_visible() {
  level endon("reached_warehouse_catwalk_failsafe");
  scripts\engine\utility::flag_wait("reached_warehouse_mid");

  while(!scripts\engine\utility::flag("catwalk_defender_visible")) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, 0.86602))
      scripts\engine\utility::flag_set("catwalk_defender_visible");

    waitframe();
  }
}

final_defender_behavior() {
  self endon("death");
  thread check_kill_final_defender();
  self.animname = "final_defender";
  self.noragdoll = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  scripts\common\ai::magic_bullet_shield();
  scripts\sp\utility::context_melee_allow(0);
  self.dontmelee = 1;
  self.disablegrenaderesponse = 1;
  thread final_defender_check_damage();
  scripts\engine\utility::flag_wait_either("reached_warehouse_catwalk_failsafe", "catwalk_defender_visible");
  level thread flashbang_tutorial();
  self.sweepfiretarget = scripts\engine\utility::spawn_script_origin();
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_laststand();
  enable_firing();

  if(!scripts\engine\utility::flag("reached_warehouse_shelf_mid")) {
    thread sweep_fire_target();
    self.ignoreall = 0;
    self setentitytarget(self.sweepfiretarget);
  }

  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wc_shelf_runner();
  scripts\engine\utility::flag_wait_or_timeout("reached_warehouse_shelf_mid", 15);
  self notify("end_sweep");
  self clearentitytarget();
  self.sweepfiretarget delete();
  self.ignoreme = 0;
}

check_kill_final_defender() {
  level endon("final_defender_killed");
  scripts\engine\utility::flag_wait("failsafe_kill_defender");
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_mike4", ["reflex_west01", "silencer04", "taclight"]);
  var_1 = scripts\engine\utility::getStruct("mb_kill_defender_1", "targetname");

  if(ispointinvolume(level.player.origin, getEnt("near_defender_left", "targetname")))
    var_1 = scripts\engine\utility::getStruct("mb_kill_defender_2", "targetname");

  magicbullet(var_0, var_1.origin, self getEye());
  self notify("damage", 100.0);
}

sweep_fire_target() {
  self endon("death");
  self endon("end_sweep");
  level endon("reached_warehouse_shelf_mid");
  var_0 = scripts\engine\utility::getStruct("sweep_fire_target_start", "targetname");
  var_1 = scripts\engine\utility::getStruct("sweep_fire_mid", "targetname");
  var_2 = scripts\engine\utility::getStruct("sweep_fire_mid_2", "targetname");
  var_3 = scripts\engine\utility::getStruct("sweep_fire_end", "targetname");
  self.sweepfiretarget.origin = var_0.origin;

  for(;;) {
    self.sweepfiretarget moveTo(var_1.origin, 2);
    wait 2;
    self.sweepfiretarget moveTo(var_2.origin, 1);
    wait 1;
    self.sweepfiretarget moveTo(var_3.origin, 2);
    wait 2;
    self.sweepfiretarget moveTo(var_2.origin, 2);
    wait 2;
    self.sweepfiretarget moveTo(var_1.origin, 1);
    wait 1;
    self.sweepfiretarget moveTo(var_0.origin, 2);
    wait 2;
  }
}

final_defender_check_damage() {
  level endon("end_check_damage");
  self.damageapplied = 0;

  for(;;) {
    self waittill("damage", var_0);
    self.damageapplied = self.damageapplied + var_0;

    if(var_0 >= self.health / 4) {
      scripts\engine\utility::flag_set("final_defender_killed");
      thread final_defender_death_anim();
      level notify("end_check_damage");
    }
  }
}

final_defender_death_anim() {
  self.ignoreme = 1;
  self dropweapon(self.weapon, "right", 10.0);
  self stopsounds();
  var_0 = scripts\engine\utility::spawn_script_origin(self.origin, (0, -90, 0));
  var_0 scripts\common\anim::anim_single_solo(self, "final_defender_death");
  var_0 thread scripts\common\anim::anim_last_frame_solo(self, "final_defender_death");
  scripts\common\ai::stop_magic_bullet_shield();
  scripts\engine\sp\utility::die();
  scripts\engine\utility::flag_set("final_defender_killed");
  level.dummydefender = create_dummy_defender();
  level.dummydefender thread play_defender_death(var_0);
  self delete();
}

play_defender_death(var_0) {
  var_0 scripts\common\anim::anim_last_frame_solo(self, "final_defender_death");
}

create_dummy_defender() {
  var_0 = scripts\engine\sp\utility::spawn_anim_model("final_defender");
  var_0 attach("head_spetsnaz_cqc");
  var_0 attach("hat_spetsnaz_helmet_cloth_a_nvg");
  var_0 scriptmoverdistancefade();
  return var_0;
}

final_defender_setup_from_start() {
  level.dummydefender = create_dummy_defender();
  var_0 = scripts\engine\utility::spawn_script_origin(getspawner("final_defender", "script_noteworthy").origin, (0, -90, 0));
  var_0 thread scripts\common\anim::anim_last_frame_solo(level.dummydefender, "final_defender_death");
}

flashlight_tutorial() {
  if(!level.player.flashlighton)
    scripts\engine\sp\utility::display_hint_forced("flashlight_equip");
}

flashlight_equip_hint_check() {
  if(level.player.flashlighton)
    return 1;

  return 0;
}

objective_tutorial_hint_check() {
  if(scripts\engine\utility::flag("done_objective_hint") || scripts\engine\utility::flag("warehouse_power_on"))
    return 1;

  return 0;
}

turn_off_lights() {
  var_0 = getEntArray("warehouse_light", "targetname");
  visionsetnaked("proxywar_warehouse_dark", 0.5);
  thread sfx_lights_off();
  level.warehouselighttable = [];

  foreach(var_2 in var_0) {
    var_3 = [var_2, var_2 getlightintensity()];
    level.warehouselighttable[level.warehouselighttable.size] = var_3;
  }

  foreach(var_2 in var_0) {
    var_2 setlightintensity(0);
    var_2.active = 0;
  }

  var_7 = getEntArray("warehouse_large_light", "targetname");

  foreach(var_9 in var_7)
  var_9 setModel("uk_industrial_light_01");

  var_11 = getEntArray("warehouse_small_light", "targetname");

  foreach(var_9 in var_11)
  var_9 setModel("ee_light_mounted_exterior_industrial_caged_02");
}

turn_on_lights() {
  visionsetnaked("", 0.5);
  thread sfx_lights_on();

  foreach(var_1 in level.warehouselighttable) {
    var_1[0] setlightintensity(var_1[1]);
    var_1[0].active = 1;
  }

  var_3 = getEntArray("warehouse_large_light", "targetname");

  foreach(var_5 in var_3)
  var_5 setModel("uk_industrial_light_01_on");

  var_7 = getEntArray("warehouse_small_light", "targetname");

  foreach(var_5 in var_7)
  var_5 setModel("ee_light_mounted_exterior_industrial_caged_02_on");
}

sfx_lights_on() {
  level.player playSound("proxy_fusebox_power_on");
  wait 0.05;
  thread scripts\engine\utility::play_sound_in_space("proxy_light_turn_on", (-2030, 478, 435));
  wait 0.4;
  thread scripts\engine\utility::play_sound_in_space("proxy_light_turn_on", (-2030, 48, 435));
  wait 0.3;
  thread scripts\engine\utility::play_sound_in_space("proxy_light_turn_on", (-2030, -327, 435));
  wait 0.2;
  thread scripts\engine\utility::play_sound_in_space("proxy_light_turn_on", (-1886, -388, 435));
}

sfx_lights_off() {
  thread scripts\engine\utility::play_sound_in_space("proxy_fusebox_power_down", (-2114, 561, 268));
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("proxy_light_turn_off", (-2030, 478, 435));
  wait 0.3;
  thread scripts\engine\utility::play_sound_in_space("proxy_light_turn_off", (-2030, 48, 435));
  wait 0.2;
  thread scripts\engine\utility::play_sound_in_space("proxy_light_turn_off", (-2030, -327, 435));
  wait 0.1;
  thread scripts\engine\utility::play_sound_in_space("proxy_light_turn_off", (-1200, 417, 435));
}

flashbang_tutorial() {
  level endon("clear_flashbang_tutorial");
  wait 3;
  var_0 = level.player getammocount("flash");

  if(var_0 > 0) {
    level thread tutorial_timeout_check();

    if(level.player getlocalplayerprofiledata("grenadeHold"))
      thread scripts\engine\sp\utility::display_hint("aim_flashbang");
    else
      thread scripts\engine\sp\utility::display_hint("aim_flashbang_toggle");

    childthread check_aiming_flashbang();
    childthread check_threw_flashbang();
    scripts\engine\utility::flag_wait("aimed_flashbang");

    if(level.player getlocalplayerprofiledata("grenadeHold"))
      thread scripts\engine\sp\utility::display_hint("throw_flashbang");
    else
      thread scripts\engine\sp\utility::display_hint("throw_flashbang_toggle");
  }
}

check_aiming_flashbang() {
  level.player waittill("secondary_offhand_pressed");
  var_0 = level.player getcurrentoffhand("secondaryoffhand");
  scripts\engine\utility::flag_clear("threw_flashbang");

  if(isDefined(var_0)) {
    if(var_0.basename == "flash")
      scripts\engine\utility::flag_set("aimed_flashbang");
  }
}

tutorial_timeout_check() {
  wait 10;

  if(!scripts\engine\utility::flag("aimed_flashbang")) {
    scripts\engine\utility::flag_set("aimed_flashbang");
    scripts\engine\utility::flag_set("threw_flashbang");
    level notify("clear_flashbang_tutorial");
  }
}

check_threw_flashbang() {
  level endon("hit_celldoor_button");
  level.player waittill("offhand_fired");
  scripts\engine\utility::flag_set("threw_flashbang");
}

has_aimed_flashbang() {
  if(scripts\engine\utility::flag("aimed_flashbang"))
    return 1;

  return 0;
}

has_thrown_flashbang() {
  if(scripts\engine\utility::flag("threw_flashbang"))
    return 1;

  return 0;
}

warehouse_discover_gas_start() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams(0);
  scripts\engine\sp\utility::set_start_location("start_warehouse_discover_gas", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  turn_off_lights();
  scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::battlechatter_off);
  level thread final_defender_setup_from_start();

  foreach(var_1 in level.alpha_and_bravo_team) {
    var_1 scripts\engine\utility::delaythread(1, scripts\sp\utility::enable_flashlight, 1);
    var_1 scripts\engine\utility::set_movement_speed(50);
  }

  scripts\engine\utility::flag_set("find_power_vo_done");
}

warehouse_discover_gas_main() {
  level thread scripts\engine\sp\utility::autosave_by_name("warehouse_discover_gas");
  scripts\engine\utility::stop_exploder("begin_amb_fx");
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("obj_power_on", "targetname").origin, &"PROXYWAR/OBJ_POWER_D", &"PROXYWAR/OBJ_POWER_L");
  scripts\sp\maps\proxywar\proxywar_util.gsc::disable_allies_firing();
  scripts\engine\utility::flag_set("aimed_flashbang");
  scripts\engine\utility::flag_set("threw_flashbang");
  level notify("clear_flashbang_tutorial");
  level.alpha1 thread alpha1_gas_search();
  level.bravo1 thread bravo1_gas_search();
  level.bravo2 thread bravo2_gas_search();
  level.bravo3 thread bravo3_gas_search();
  level.doorbuttoninteract = scripts\engine\utility::getStruct("door_open_button", "targetname");
  level.doorbuttoninteract thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"PROXYWAR/CURSOR_USE", undefined, 100, 50, 1);
  level.doorbuttoninteract thread check_door_button_interact();
  level thread check_objective_button_pressed();
  level.powerleverinteract = scripts\engine\utility::getStruct("power_lever_interact", "targetname");
  level.powerleverinteract scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"PROXYWAR/CURSOR_POWER", undefined, 100, 50);
  level.powerleverinteract waittill("trigger");
  scripts\engine\utility::flag_set("warehouse_power_on");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("tower_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("warehouse_light_gas");
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("obj_warehouse", "targetname").origin, &"PROXYWAR/OBJ_LOCATE_DSC", &"PROXYWAR/OBJ_LOCATE_LBL");
  level.doorbuttoninteract scripts\sp\player\cursor_hint::remove_cursor_hint();
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wdg_found_button();
  level scripts\engine\utility::delaythread(2.25, ::turn_on_lights);
  level.ap_power_lever thread scripts\sp\player_rig::link_player_to_rig("turn_on_power", "stand", 1, 0.5, undefined, 15, 15, 15, 15);
  level.alpha1 thread alpha1_move_to_chem_truck();
  level.discovergasref thread scripts\common\anim::anim_first_frame_solo(level.bravo1, "warehouse_check_body");
  level.discovergasref thread scripts\common\anim::anim_first_frame_solo(level.dummydefender, "warehouse_check_body");
  level.bravo1 scripts\engine\utility::set_movement_speed(60);
  level.bravo2 scripts\engine\utility::set_movement_speed(80);
  level.bravo3 scripts\engine\utility::set_movement_speed(100);
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_out_of_warehouse_1");
  level.ap_power_lever thread scripts\common\anim::anim_single_solo(level.power_lever, "turn_on_power");
  level.ap_power_lever scripts\common\anim::anim_single_solo(level.player_rig, "turn_on_power");
  scripts\sp\player_rig::unlink_player_from_rig();
  level thread check_facing_russian_scene();

  foreach(var_1 in level.alpha_and_bravo_team) {
    var_1 scripts\sp\utility::enable_flashlight(0);
    var_1 scripts\asm\shared\utility::toggle_poiauto(0);
  }

  scripts\engine\utility::flag_wait_or_timeout("facing_russian_scene", 4);
  scripts\engine\utility::flag_set("start_inspect_body");
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::mus_discover_russians();
  var_3 = getEnt("body_clip", "targetname");
  var_3.origin = var_3.origin + (0, 0, 128);
  createnavobstaclebyent(var_3);
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wdg_discover_russians_callout();
  level thread inspect_dead_russians();
  level.bravo1 scripts\common\ai::set_gunpose("gun_down");
  level.discovergasref scripts\common\anim::anim_single_solo(level.bravo1, "warehouse_check_body");
  level.bravo1 scripts\common\ai::set_gunpose("automatic");
  level.bravo1 setgoalpos(level.bravo1.origin);
  level thread allies_move_to_trucks();
  level thread scripts\engine\sp\utility::autosave_by_name("warehouse_swab_truck");
  wait 4;
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_chem_truck", "targetname").origin);
  var_4 = scripts\engine\utility::getStruct("swab_container_interact", "targetname");
  var_4 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"PROXYWAR/SWAB", 180, 256);
  var_4 waittill("trigger");
  scripts\engine\utility::flag_set("started_swabbing");
  var_5 = scripts\engine\utility::getStruct("swab_container_ref", "targetname");
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wdg_found_gas();
  thread warehouse_discover_gas_exit_door();
  thread warehouse_discover_gas_teleport_allies(var_5);
  var_5 thread scripts\sp\player_rig::link_player_to_rig("swab", "stand", 1, 0.5, undefined, 15, 15, 15, 15);
  var_6 = scripts\engine\sp\utility::spawn_anim_model("swab", level.player.origin, level.player.angles);
  playFXOnTag(scripts\engine\utility::getfx("vfx_proxywar_chemical_swab"), var_6, "j_swab");
  level thread scripts\sp\maps\proxywar\proxywar_trucks.gsc::alpha1_wait_for_player();
  level thread bravo3_head_to_convoy(var_5);
  var_5 scripts\common\anim::anim_single([level.player_rig, var_6], "swab");
  var_6 delete();
  scripts\sp\player_rig::unlink_player_from_rig();
  scripts\engine\utility::flag_set("finished_swabbing");
}

bravo3_head_to_convoy(var_0) {
  level endon("approaching_rear_exit_door");
  var_0 scripts\common\anim::anim_single_solo(level.bravo3, "swab");
  var_0 thread scripts\common\anim::anim_last_frame_solo(level.bravo3, "swab");
}

check_objective_button_pressed() {
  level endon("warehouse_power_on");
  scripts\engine\utility::flag_wait("find_power_vo_done");
  scripts\engine\sp\utility::display_hint_forced("objective_tutorial");
  level.player notifyonplayercommand("objective_pressed", "+focus");
  level.player waittill("objective_pressed");
  scripts\engine\utility::flag_set("done_objective_hint");
}

check_facing_russian_scene() {
  scripts\engine\utility::flag_waitopen("facing_power_lever");
  scripts\engine\utility::flag_set("facing_russian_scene");
}

setup_search_points() {
  level.search_points = scripts\engine\utility::getStructArray("search_point", "targetname");

  foreach(var_1 in level.search_points) {
    var_1.aim_search_spline = scripts\engine\utility::getStruct(var_1.target, "targetname");
    var_1.target = undefined;
    var_1.radius = 50;
  }
}

get_search_point(var_0) {
  if(!isDefined(level.search_points))
    setup_search_points();

  foreach(var_2 in level.search_points) {
    if(var_2.script_noteworthy == var_0)
      return var_2;
  }

  return undefined;
}

inspect_dead_russians() {
  level.discovergasref scripts\common\anim::anim_single_solo(level.dummydefender, "warehouse_check_body");
  level.discovergasref thread scripts\common\anim::anim_last_frame_solo(level.dummydefender, "warehouse_check_body");
}

alpha1_gas_search() {
  level endon("warehouse_power_on");
  thread warehouse_discover_gas_ally_cleanup();
  scripts\asm\shared\utility::toggle_poiauto(1);
  scripts\engine\utility::set_movement_speed(50);
  self.ignoreall = 0;
  scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("search_point_alpha1_1", "targetname"));
}

bravo1_gas_search() {
  level endon("warehouse_power_on");
  thread warehouse_discover_gas_ally_cleanup();
  scripts\asm\shared\utility::toggle_poiauto(1);
  scripts\engine\utility::set_movement_speed(50);
  self.ignoreall = 0;
  var_0 = ["search_point_bravo2_1", "search_point_bravo2_2", "search_point_bravo2_3"];

  for(;;) {
    ally_search_array(var_0);
    waitframe();
  }
}

bravo2_gas_search() {
  level endon("warehouse_power_on");
  thread warehouse_discover_gas_ally_cleanup();
  scripts\asm\shared\utility::toggle_poiauto(1);
  scripts\engine\utility::set_movement_speed(50);
  self.ignoreall = 0;
  var_0 = ["search_point_bravo1_1", "search_point_bravo1_2", "search_point_bravo1_3"];
  ally_search_array(var_0);

  for(;;) {
    ally_search_array(var_0);
    waitframe();
  }
}

bravo3_gas_search() {
  level endon("warehouse_power_on");
  thread warehouse_discover_gas_ally_cleanup();
  scripts\asm\shared\utility::toggle_poiauto(1);
  scripts\engine\utility::set_movement_speed(50);
  self.ignoreall = 0;
  var_0 = ["search_point_bravo3_1", "search_point_bravo3_2", "search_point_bravo3_3"];

  for(;;) {
    ally_search_array(var_0);
    waitframe();
  }
}

ally_search_array(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = scripts\engine\utility::getStruct(var_0[var_1], "targetname");
    scripts\sp\spawner::go_to_node(var_2);
    wait(randomfloatrange(2, 5));
  }
}

check_door_button_interact() {
  level endon("warehouse_power_on");
  level endon("end_button_check");
  self waittill("trigger");
  level.discovergasref = scripts\engine\utility::getStruct("discover_gas_ref", "targetname");
  var_0 = getEnt("gas_door_button", "targetname");
  var_0.animname = "door_button";
  var_0 scripts\common\anim::setanimtree();
  level.player playSound("proxy_button_push_plr");
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_wdg_tried_door_button();
  level.discovergasref scripts\sp\player_rig::link_player_to_rig("try_door_button", undefined, undefined, undefined, undefined, 15, 15, 15, 15);
  level.discovergasref scripts\common\anim::anim_single([level.player_rig, var_0], "try_door_button");
  level.discovergasref scripts\sp\player_rig::unlink_player_from_rig();
}

warehouse_discover_gas_ally_cleanup() {
  scripts\engine\utility::flag_wait("warehouse_power_on");
  self.ignoreall = 1;
  scripts\engine\sp\utility::enable_ai_color();
}

alpha1_move_to_chem_truck() {
  level endon("started_swabbing");
  level.discovergasref = scripts\engine\utility::getStruct("discover_gas_ref", "targetname");
  level.discovergasref thread scripts\common\anim::anim_loop_solo(self, "warehouse_button_idle", "end_button_idle");
  scripts\engine\utility::flag_wait("start_inspect_body");
  level.discovergasref notify("end_button_idle");
  var_0 = getEnt("gas_door_button", "targetname");
  var_0.animname = "door_button";
  var_0 scripts\common\anim::setanimtree();
  var_1 = getEnt("truck_door", "targetname");
  var_1.animname = "warehouse_roller_door";
  var_1 scripts\common\anim::setanimtree();
  var_1.clip = getEnt("truck_door_clip", "targetname");
  var_1.clip linkTo(var_1);
  level.discovergasref thread scripts\common\anim::anim_single([var_0, var_1], "warehouse_discover_gas");
  var_1.clip scripts\engine\utility::delaycall(5, ::connectpaths);
  var_1 thread warehouse_audio_rolling_door_open();
  level.discovergasref scripts\common\anim::anim_single_solo(self, "warehouse_discover_gas");
  level.discovergasref thread scripts\common\anim::anim_loop_solo(self, "warehouse_discover_gas_idle", "end_discover_idle");
  scripts\engine\utility::flag_set("found_chemical_weapons");

  while(!scripts\engine\utility::flag("started_swabbing")) {
    wait 8;

    if(!scripts\engine\utility::flag("started_swabbing")) {
      level.discovergasref notify("end_discover_idle");
      level.discovergasref scripts\common\anim::anim_single_solo(self, "warehouse_discover_gas_nag");
      level.discovergasref thread scripts\common\anim::anim_loop_solo(self, "warehouse_discover_gas_idle", "end_discover_idle");
    }
  }
}

warehouse_audio_rolling_door_open() {
  wait 7.25;
  self playSound("pw_garage_open_start");
  self playLoopSound("pw_garage_open_lp");
  wait 7.65;
  self playSound("pw_garage_open_stop");
  wait 0.25;
  self stoploopsound();
}

warehouse_discover_gas_exit_door() {
  var_0 = scripts\sp\door::get_interactive_door("warehouse_side_exit_door");
  var_0 notify("stop_open_ability");
  var_0 scripts\sp\door::remove_open_ability();
  var_0 scripts\game\sp\door::remove_door_snake_cam_ability();
  var_0 scripts\sp\door::door_open_completely();
  var_0 scripts\sp\door::clear_navobstacle();
}

allies_move_to_trucks() {
  level endon("started_swabbing");
  wait 3;
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_out_of_warehouse_2");
  level.bravo3 scripts\common\ai::set_gunpose("disable", 1);
  wait 7.5;
  scripts\engine\utility::flag_wait("found_chemical_weapons");

  foreach(var_1 in level.bravo_team)
  var_1 scripts\common\ai::set_gunpose("gun_down");

  level.bravo1 scripts\engine\utility::set_movement_speed(100);
  level.bravo2 scripts\engine\utility::set_movement_speed(60);
  scripts\engine\sp\utility::activate_trigger_with_targetname("allies_move_out_of_warehouse_3");
  wait 3;
  level.bravo1 scripts\asm\shared\utility::toggle_poiauto(1);
  level.bravo2 scripts\asm\shared\utility::toggle_poiauto(1);
  level.bravo3 scripts\common\ai::set_gunpose("disable", 1);
}

warehouse_discover_gas_teleport_allies(var_0) {
  wait 0.5;

  foreach(var_2 in level.bravo_team)
  var_2 notify("stop_going_to_node");

  var_4 = scripts\engine\utility::getStruct("convoy_ref", "targetname");
  var_4 thread scripts\common\anim::anim_first_frame([level.bravo1, level.bravo2], "convoy_rollout");
}

warehouse_discover_gas_catchup() {
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_chem_truck", "targetname").origin);
  var_0 = getEnt("truck_door", "targetname");
  var_0 moveTo(var_0.origin + (0, 0, 115), 0.05, 0.001, 0.001);
  thread warehouse_discover_gas_exit_door();
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("tower_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("warehouse_light_gas");
  level.ap_power_lever = scripts\engine\utility::getStruct("ap_power_lever", "targetname");
  level.power_lever = scripts\engine\sp\utility::spawn_anim_model("power_lever");
  level.ap_power_lever thread scripts\common\anim::anim_last_frame_solo(level.power_lever, "turn_on_power");
}