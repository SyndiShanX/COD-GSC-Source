/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_factory_floor.gsc
*****************************************************/

factory_floor_flags() {
  scripts\engine\utility::flag_init("near_ff_door");
  scripts\engine\utility::flag_init("approaching_factor_floor_exit");
  scripts\engine\utility::flag_init("looking_at_exit_door");
  scripts\engine\utility::flag_init("door_opener_past_threshold");
  scripts\engine\utility::flag_init("door_scene_done");
  scripts\engine\utility::flag_init("entered_factory_floor");
  scripts\engine\utility::flag_init("ff_initial_group_dead");
  scripts\engine\utility::flag_init("ff_factory_group_dead");
  scripts\engine\utility::flag_init("ff_alley_group_dead");
  scripts\engine\utility::flag_init("reached_factory_move_1");
  scripts\engine\utility::flag_init("reached_factory_move_2");
  scripts\engine\utility::flag_init("reached_factory_move_3");
  scripts\engine\utility::flag_init("reached_factory_move_4");
  scripts\engine\utility::flag_init("reached_factory_move_5");
  scripts\engine\utility::flag_init("reached_factory_move_6");
  scripts\engine\utility::flag_init("reached_factory_move_7");
  scripts\engine\utility::flag_init("reached_factory_move_8");
  scripts\engine\utility::flag_init("reached_factory_move_9");
  scripts\engine\utility::flag_init("reached_factory_move_10");
  scripts\engine\utility::flag_init("reached_halfway");
  scripts\engine\utility::flag_init("reached_alley_end");
  scripts\engine\utility::flag_init("reached_exterior_start");
  scripts\engine\utility::flag_init("at_factory_floor_exit");
}

factory_floor_start() {
  scripts\engine\utility::flag_set("saved_azadeh");
  thread scripts\sp\maps\captive\captive_lighting.gsc::factory_cascade();
  scripts\engine\sp\utility::set_start_location("player_spawn_factory_floor", [level.player]);
  scripts\sp\maps\captive\captive_util.gsc::setup_noisemaker_pickups();
  scripts\sp\maps\captive\captive_util.gsc::enable_context_melee();
  scripts\sp\player\teenagefarah::teenage_farah_combat_setup();
  scripts\sp\maps\captive\captive_util.gsc::spawn_prisoners();
  scripts\engine\sp\utility::set_start_location("factory_floor_ayah_start", [level.ayah]);
  scripts\engine\sp\utility::set_start_location("factory_floor_nadia_start", [level.nadia]);

  if(isDefined(level.azadeh))
    scripts\engine\sp\utility::set_start_location("factory_floor_azadeh_start", [level.azadeh]);

  scripts\engine\sp\utility::set_start_location("factory_floor_darine_start", [level.darine]);
  scripts\engine\sp\utility::set_start_location("factory_floor_ghalia_start", [level.ghalia]);
  level.factoryfloordoor = scripts\sp\maps\captive\captive_util.gsc::get_prefab_base_ent("factory_floor_door", "script_noteworthy");
  level.factoryfloordoor.animname = "factory_floor_door";
  level.factoryfloordoor scripts\engine\sp\utility::assign_animtree("factory_floor_door");
  level.player scripts\engine\sp\utility::give_offhand("frag_farah", 2);
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("hadir_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("main_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("break_final");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("pre_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("post_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("fallen_grate");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("upstairs");
}

factory_floor_main() {
  thread scripts\sp\maps\captive\captive_lighting.gsc::factory_cascade();
  scripts\engine\sp\utility::add_global_spawn_function("axis", scripts\sp\maps\captive\captive_util.gsc::always_win_melee);
  level.nadia scripts\engine\utility::set_movement_speed(130);
  level.ayah scripts\engine\utility::set_movement_speed(128);
  level.ghalia scripts\engine\utility::set_movement_speed(120);
  level.darine scripts\engine\utility::set_movement_speed(125);
  scripts\engine\sp\utility::flagwaitthread("entered_factory_floor", ::factory_floor_enter);
  scripts\engine\sp\utility::flagwaitthread("reached_halfway", ::reached_halfway);

  if(isDefined(level.azadeh))
    level.azadeh scripts\engine\utility::set_movement_speed(75);

  scripts\engine\sp\utility::activate_trigger("prisoners_start_ambush", "targetname");
  level.player scripts\sp\player::set_player_max_health(60);
  level.player scripts\sp\player::scale_player_death_shield_duration(0.1);
  level thread scripts\sp\maps\captive\captive_util.gsc::bad_ak_monitor();
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("escape_labor_camp_objective_1", "targetname").origin, &"CAPTIVE/OBJ_FIND_HADIR_DESC", &"CAPTIVE/OBJ_FIND_HADIR");
  var_0 = scripts\common\utility::getvehiclespawner("barkov_chopper", "targetname");
  level.barkovchopper = var_0 scripts\common\utility::spawn_vehicle();
  level.barkovchopper scripts\common\vehicle::godon();
  level.barkovchopper vehicle_turnengineoff();
  override_vehicle_fx();
  scripts\sp\maps\captive\captive_vo.gsc::vo_ff_guards_at_door();
  wait 1;
  var_1 = scripts\engine\utility::getStruct("door_ambush_ref", "targetname");
  var_1 scripts\sp\anim::anim_reach_solo(level.nadia, "factory_door_exit_arrival");
  var_1 scripts\common\anim::anim_single_solo(level.nadia, "factory_door_exit_arrival");
  var_1 thread scripts\common\anim::anim_loop_solo(level.nadia, "factory_door_exit_idle", "end_door_kick_idle");
  scripts\engine\utility::flag_wait_or_timeout("looking_at_exit_door", 5);
  scripts\engine\utility::flag_waitopen("near_ff_door");

  foreach(var_3 in level.allprisoners)
  var_3 scripts\engine\sp\utility::enable_dontevershoot();

  level.player scripts\engine\sp\utility::set_player_demeanor("normal");
  level thread door_kick_scene(var_1);
  scripts\engine\utility::exploder("factory_door_open");
  wait 2;
  var_5 = scripts\engine\sp\utility::array_spawn_targetname("factory_floor_initial_guards_reinforce", 1);
  scripts\engine\utility::array_thread(var_5, ::initial_guard_logic);
  var_6 = var_5;
  scripts\engine\utility::flag_wait("door_scene_done");

  foreach(var_3 in level.allprisoners)
  var_3.ignoreme = 0;

  foreach(var_3 in level.allprisoners) {
    var_3 scripts\common\utility::clear_movement_speed();
    var_3 scripts\engine\sp\utility::disable_dontevershoot();
  }

  scripts\sp\maps\captive\captive_vo.gsc::vo_ff_exit_cellblock();
  thread scripts\sp\maps\captive\captive_vo.gsc::mus_factory_exit_battle();
  level thread allies_move_through_factory();
  scripts\engine\utility::flag_wait("reached_alley_end");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("escape_labor_camp_objective_2", "targetname").origin);
  level thread scripts\engine\sp\utility::autosave_by_name("factory_floor_end");
  scripts\engine\utility::flag_wait("reached_exterior_start");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("open_gate_objective", "targetname").origin);
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ex_barkov_escapes();
  level.barkovchopper thread scripts\common\vehicle::vehicle_paths(scripts\engine\utility::getStruct("barkov_chopper_path_1", "targetname"));
  level.barkovchopper thread sfx_barkov_heli_flyover();
  level thread scripts\engine\sp\utility::autosave_by_name("exterior_fight");
}

sfx_barkov_heli_flyover() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkTo(self);
  var_0 playSound("scn_captive_barkov_heli_flyover", "sounddone");
  wait 4.5;
  var_1 = spawn("script_origin", (6795, 1372, -16));
  var_1 playSound("scn_captive_heli_dust");
  var_0 waittill("sounddone");
  var_0 delete();
  var_1 delete();
}

factory_floor_enter() {
  thread scripts\sp\maps\captive\captive_vo.gsc::vo_ff_combat();
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("factory_floor_secondary_guards", 1);
  level thread scripts\engine\sp\utility::autosave_by_name("factory_floor_entrance");
}

reached_halfway() {
  var_0 = scripts\engine\sp\utility::array_spawn_targetname("factory_floor_tertiary_guards");
  level thread scripts\engine\sp\utility::autosave_by_name("factory_floor_mid");
}

initial_guard_logic() {
  self endon("death");
  self.dontevershoot = 1;
  self.grenadeammo = 0;
  scripts\engine\utility::flag_wait("door_scene_done");
  self.dontevershoot = 0;
}

factory_floor_catchup() {
  if(level.start_point == "bink_speech") {
    return;
  }
  var_0 = scripts\sp\maps\captive\captive_util.gsc::get_prefab_base_ent("factory_floor_door", "script_noteworthy");
  var_0.animname = "factory_floor_door";
  var_0 scripts\engine\sp\utility::assign_animtree("factory_floor_door");
  var_1 = scripts\engine\utility::getStruct("door_ambush_ref", "targetname");
  var_1 scripts\common\anim::anim_last_frame_solo(var_0, "factory_door_exit_open");
  level.player scripts\sp\player::set_player_max_health(60);
  level.player scripts\sp\player::scale_player_death_shield_duration(0.1);
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("escape_labor_camp_objective_1", "targetname").origin, &"CAPTIVE/OBJ_FIND_HADIR_DESC", &"CAPTIVE/OBJ_FIND_HADIR");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("open_gate_objective", "targetname").origin);
}

override_vehicle_fx() {
  scripts\common\vehicle_build::build_treadfx(level.barkovchopper.classname, "default", "vfx/iw8/level/captive/vfx_cpt_heli_dust.vfx");
}

door_kick_player_push() {
  if(scripts\engine\utility::flag("near_ff_door")) {
    var_0 = scripts\engine\utility::getStruct("factory_floor_door_interact", "targetname");
    level.player thread scripts\sp\utility::do_damage(10, var_0.origin);
    earthquake(1, 0.3, level.player.origin, 100);
    level.player playRumbleOnEntity("light_1s");
    var_1 = vectorNormalize(level.player.origin - var_0.origin) * 1000;
    level.player setvelocity(var_1);
  }
}

door_kick_scene(var_0) {
  var_1 = scripts\sp\maps\captive\captive_util.gsc::get_prefab_base_ent("factory_floor_door", "script_noteworthy");
  var_1.animname = "factory_floor_door";
  var_1 scripts\engine\sp\utility::assign_animtree();
  var_2 = scripts\engine\sp\utility::spawn_targetname("factory_floor_door_opener", 1);
  var_2 scripts\sp\utility::context_melee_allow(0);
  var_2 scripts\engine\sp\utility::set_grenadeammo(0);
  var_2.animname = "enemy1";
  var_2.ignoreme = 1;
  level thread door_opener_check_for_damage(var_0, var_2, var_1);
  level thread check_interrupt_threshold();
  level thread play_dooropener_kill(var_0, var_2, var_1);
  level notify("vo_stop_guard_walla");
}

play_dooropener_kill(var_0, var_1, var_2) {
  level endon("stop_nadia_kill");
  var_0 notify("end_door_kick_idle");
  var_3 = [level.nadia, var_1, var_2];
  var_1 scripts\engine\utility::delaythread(3.5, scripts\anim\shared.gsc::dropallaiweapons);
  level.nadia scripts\engine\utility::delaythread(5, scripts\engine\sp\utility::enable_ai_color);
  level scripts\engine\utility::delaythread(6, scripts\engine\sp\utility::autosave_by_name, "blah");
  level scripts\engine\utility::delaythread(7, scripts\engine\utility::flag_set, "door_scene_done");
  level scripts\engine\utility::delaythread(0.95, ::door_kick_player_push);
  level thread prisoners_react_to_enemy();
  var_0 scripts\common\anim::anim_single(var_3, "factory_door_exit_open");
  var_2.collision connectpaths();
}

prisoners_react_to_enemy() {
  var_0 = scripts\engine\utility::array_remove(level.allprisoners, level.nadia);
  var_0 = sortbydistance(var_0, level.nadia.origin);
  var_1 = 0.8;
  var_2 = "large";

  foreach(var_4 in var_0) {
    if(var_4.currentpose == "stand") {
      var_4 scripts\engine\utility::delaythread(var_1, ::door_react, var_2);
      var_1 = var_1 + 0.25;

      if(var_2 == "large") {
        var_2 = "med";
        continue;
      }

      if(var_2 == "med") {
        var_2 = "small";
        continue;
      }

      return;
    }
  }
}

door_react(var_0) {
  thread scripts\common\anim::anim_generic(self, "door_react_" + var_0);
}

check_interrupt_threshold() {
  level waittill("interrupt_threshold");
  scripts\engine\utility::flag_set("door_opener_past_threshold");
}

door_opener_check_for_damage(var_0, var_1, var_2) {
  var_1 waittill("damage", var_3, var_4);

  if(!scripts\engine\utility::flag("door_opener_past_threshold")) {
    level waittill("interrupt_threshold");
    level notify("stop_nadia_kill");
    var_5 = [level.nadia];
    var_1 thread scripts\anim\shared.gsc::dropallaiweapons();
    level scripts\engine\utility::delaythread(5, scripts\engine\utility::flag_set, "door_scene_done");
    level.nadia scripts\engine\utility::delaythread(4, scripts\engine\sp\utility::enable_ai_color);
    level scripts\engine\utility::delaythread(4, scripts\engine\sp\utility::autosave_by_name, "blah");
    var_1 thread scripts\common\anim::anim_single_solo(var_1, "factory_door_exit_interrupt");
    var_0 scripts\common\anim::anim_single(var_5, "factory_door_exit_interrupt");
    level.nadia scripts\engine\sp\utility::enable_ai_color();
    var_2.collision connectpaths();
  }
}

allies_move_through_factory() {
  scripts\engine\sp\utility::activate_trigger_with_targetname("post_ambush_positions");
  scripts\engine\utility::flag_wait_either("door_scene_done", "approaching_factor_floor_exit");
  scripts\engine\sp\utility::activate_trigger_with_targetname("intiial_advance_into_factory");
  scripts\engine\utility::flag_wait("reached_factory_move_6");
  level thread check_factory_group_dead();
  scripts\engine\utility::flag_wait_either("reached_factory_move_7", "ff_factory_group_dead");
  var_0 = getEntArray("not_hallway2", "script_noteworthy");
  scripts\engine\utility::array_delete(var_0);
  waitframe();
  scripts\engine\sp\utility::activate_trigger_with_targetname("move_into_factory_7");
  scripts\engine\sp\utility::array_spawn_targetname("alley_guards", 1);
  scripts\engine\utility::flag_wait_any("reached_factory_move_8", "reached_factory_move_9");
  scripts\engine\sp\utility::activate_trigger_with_targetname("move_into_factory_8");
}

check_initial_group_dead() {
  scripts\engine\sp\utility::waittill_ai_group_dead("factory_floor_initial_guards");
  scripts\engine\utility::flag_set("ff_initial_group_dead");
}

check_factory_group_dead() {
  var_0 = getEnt("ff_guard_exit", "targetname");

  while(var_0 scripts\engine\sp\utility::get_ai_touching_volume("axis").size)
    wait 0.25;

  scripts\engine\utility::flag_set("ff_factory_group_dead");
}

check_alley_group_dead() {
  scripts\engine\sp\utility::waittill_ai_group_dead("factory_floor_alley_guards");
  scripts\engine\utility::flag_set("ff_alley_group_dead");
}