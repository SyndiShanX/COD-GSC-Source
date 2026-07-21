/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\proxywar\proxywar_forest.gsc
************************************************/

proxywar_forest_precache() {
  precachemodel("lighting_fixtures_security_lamp_01");
}

proxywar_forest_flags() {
  scripts\engine\utility::flag_init("alpha_forest_2");
  scripts\engine\utility::flag_init("bravo_forest_2");
  scripts\engine\utility::flag_init("alpha_forest_3");
  scripts\engine\utility::flag_init("bravo_forest_3");
  scripts\engine\utility::flag_init("reached_overlook_patrol");
  scripts\engine\utility::flag_init("alerted_patrol");
  scripts\engine\utility::flag_init("overlook_patrol_reached_end");
  scripts\engine\utility::flag_init("killed_overlook_patrol");
  scripts\engine\utility::flag_init("reached_overlook");
  scripts\engine\utility::flag_init("trigger_drop_down");
  scripts\engine\utility::flag_init("alpha_group_reached_edge");
  scripts\engine\utility::flag_init("alpha1_completed_reach_edge");
  scripts\engine\utility::flag_init("alpha2_completed_reach_edge");
  scripts\engine\utility::flag_init("overlook_patrol_noise_made");
  scripts\engine\utility::flag_init("played_go_hot_admonishment");
  scripts\engine\utility::flag_init("admonishment_done");
  scripts\engine\utility::flag_init("near_ridge_edge");
  scripts\engine\utility::flag_init("start_suv");
  scripts\engine\utility::flag_init("done_overlook_radio_callin");
  scripts\engine\utility::flag_init("spotter_actively_tracking");
  scripts\engine\utility::flag_init("truck_moved_on");
  scripts\engine\utility::flag_init("alpha1_callin_strike");
  scripts\engine\utility::flag_init("done_suv_patrol_callout");
  scripts\engine\utility::flag_init("done_checkpoint_spot");
  scripts\engine\utility::flag_init("done_suv_spot");
  scripts\engine\utility::flag_init("done_tower_spot");
  scripts\engine\utility::flag_init("done_suv_patrol_spot");
  scripts\engine\utility::flag_init("suv_patrol_complete");
  scripts\engine\utility::flag_init("done_railyard_spot");
  scripts\engine\utility::flag_init("suv_patrol_started");
  scripts\engine\utility::flag_init("added_suv_patrol");
  scripts\engine\utility::flag_init("spotter_laser_on");
  scripts\engine\utility::flag_init("truck_moving");
  scripts\engine\utility::flag_init("equipped_spotter_scope");
  scripts\engine\utility::flag_init("allow_target_marking");
  scripts\engine\utility::flag_init("displaying_callin_hint");
  scripts\engine\utility::flag_init("disabled_firing");
  scripts\engine\utility::flag_init("disabled_non_ads_firing");
  scripts\engine\utility::flag_init("called_in_strike");
  scripts\engine\utility::flag_init("done_aim_look");
  scripts\engine\utility::flag_init("begin_airstrike");
  scripts\engine\utility::flag_init("spotted_vehicle");
  scripts\engine\utility::flag_init("added_vehicle_look");
  scripts\engine\utility::flag_init("done_facility_scan");
  scripts\engine\utility::flag_init("overlook_went_hot");
  scripts\engine\utility::flag_init("phosphorus_done");
  scripts\engine\utility::flag_init("phosphorus_vo_done");
  scripts\engine\utility::flag_init("started_alarm");
  scripts\engine\utility::flag_init("proxywar_lights_overlook_fire");
  scripts\engine\utility::flag_init("start_halligan_open");
  scripts\engine\utility::flag_init("alpha1_ready_for_move_to_patrol");
  scripts\engine\utility::flag_init("alpha2_ready_for_move_to_patrol");
  scripts\engine\utility::flag_init("start_patrol_anim");
  scripts\engine\utility::flag_init("move_to_patrol");
  scripts\engine\utility::flag_init("player_fired_at_patrol");
  scripts\engine\utility::flag_init("player_too_close_to_patroller");
  scripts\engine\utility::flag_init("player_prompted_for_patrol");
  scripts\engine\utility::flag_init("eliminate_patrol_1");
  scripts\engine\utility::flag_init("eliminate_patrol_2");
  scripts\engine\utility::flag_init("eliminate_patrol_3");
  scripts\engine\utility::flag_init("eliminate_patrol_4");
  scripts\engine\utility::flag_init("player_skipping_patrol");
  scripts\engine\utility::flag_init("reached_railyard_entrance");
  scripts\engine\utility::flag_init("burning_guy_spawned");
}

proxywar_forest_hints() {
  scripts\engine\sp\utility::add_hint_string("spotterscope_equip", &"PROXYWAR/TUT_SPOTTERSCOPE_EQUIP", ::spotterscope_equip_hint_check);
  scripts\engine\sp\utility::add_hint_string("spotterscope_aim", &"PROXYWAR/TUT_SPOTTERSCOPE_AIM", ::spotterscope_aim_hint_check);
  scripts\engine\sp\utility::add_hint_string("spotterscope_aim_toggle", &"PROXYWAR/TUT_SPOTTERSCOPE_AIM_TOGGLE", ::spotterscope_aim_hint_check);
  scripts\engine\sp\utility::add_hint_string("call_in_strike", &"PROXYWAR/TUT_SPOTTERSCOPE_FIRE", ::spotterscope_fire_hint_check);
  scripts\engine\sp\utility::add_hint_string("tut_crouch_hint", &"PROXYWAR/TUT_CROUCH", ::check_crouch);
  scripts\engine\sp\utility::add_hint_string("tut_crouch_hint_hold", &"PROXYWAR/TUT_CROUCH_HOLD", ::check_crouch);
}

check_crouch() {
  return level.player_crouched;
}

proxywar_forest_spawn_funcs() {
  scripts\engine\sp\utility::array_spawn_function_targetname("rus_overlook_patrol", ::rus_overlook_patrol_spawnfunc);
  scripts\engine\sp\utility::array_spawn_function_targetname("overlook_group", ::overlook_group_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("overlook_car_group", ::overlook_group_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_targetname("rus_return_pmcs", ::forest_patrol_enemy_return);
}

proxywar_forest_init() {
  var_0 = getEnt("forest_patrol_fov_lerp", "targetname");
  var_0 thread scripts\sp\maps\proxywar\proxywar_util.gsc::lerp_fov_over_distance_trigger();

  if(!scripts\sp\starts::is_after_start("forest_overlook")) {
    var_1 = getEntArray("burning_truck", "targetname");

    foreach(var_3 in var_1)
    var_3 hide();

    var_5 = getEnt("burning_truck_col", "targetname");
    var_5 notsolid();
  } else {
    var_6 = getEntArray("burning_truck_pre", "targetname");

    foreach(var_3 in var_6)
    var_3 hide();
  }

  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("truck_b_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("truck_b_tail_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_c_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_c_tail_lights");
}

forest_trees_start() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams();
  scripts\engine\sp\utility::set_start_location("start_forest_trees", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  thread scripts\sp\player::player_movement_state("creep");
  scripts\engine\utility::flag_set("heli_vo_complete");
  level.player modifybasefov(50, 0.05);
  level.forestmoveref = scripts\engine\utility::getStruct("forest_move_ref", "targetname");
  level.forestmoveref thread scripts\common\anim::anim_loop(level.bravo_team, "forest_move_enter_idle", "end_forest_enter_idle");
  level thread forest_trees_ally_alpha();
}

forest_trees_main() {
  scripts\engine\sp\utility::autosave_by_name("forest_trees");
  setsaveddvar("MNSOQLKMT", "3.2 0.0006 1 1");
  scripts\engine\utility::exploder("begin_amb_fx");
  scripts\engine\utility::exploder("begin_flares");
  thread forest_overlook_door();
  level.forestmoveref = scripts\engine\utility::getStruct("forest_move_ref", "targetname");
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_forest_walk();
  level thread forest_trees_ally_bravo();
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::mus_forest_overlook();
  level thread check_throw_grenade_during_patrol();
  scripts\engine\utility::flag_wait("reached_overlook_patrol");

  if(scripts\engine\utility::flag("alerted_patrol"))
    scripts\engine\utility::delaythread(5, ::check_kill_overlook);

  level thread setup_overlook_scene();
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_spot_patrol();
  var_0 = scripts\engine\utility::getStruct("overlook_patrol_ref", "targetname");
  var_1 = scripts\engine\sp\utility::array_spawn_targetname("rus_overlook_patrol", 1);
  level.overlookpatrol1 = getEnt("rus_overlook_patrol_1", "script_noteworthy");
  level.overlookpatrol1.animname = "enemy1";
  level.overlookpatrol1 thread overlook_patrol_animate(var_0);
  level.overlookpatrol2 = getEnt("rus_overlook_patrol_2", "script_noteworthy");
  level.overlookpatrol2.animname = "enemy2";
  level.overlookpatrol2 thread overlook_patrol_animate(var_0);
  level thread check_overlook_patrol(var_1);
  level thread check_player_visibility_to_patrol(var_1);
  level thread check_player_flashlight_visible_to_patrol();
  scripts\engine\utility::flag_wait("killed_overlook_patrol");

  while(!scripts\engine\utility::flag("reached_overlook") && !scripts\engine\utility::flag("overlook_patrol_noise_made"))
    waitframe();

  if(scripts\engine\utility::flag("overlook_patrol_noise_made")) {
    level notify("kill_all_anim_instructions");
    scripts\engine\utility::flag_set("overlook_went_hot");
  }
}

overlook_patrol_animate(var_0) {
  level endon("alerted_patrol");
  self.allowdeath = 1;
  var_1 = getstartorigin(var_0.origin, (0, 0, 0), scripts\engine\utility::getanim("overlook_patrol"));
  var_2 = getstartangles(var_0.origin, (0, 0, 0), scripts\engine\utility::getanim("overlook_patrol"));
  var_3 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self linkTo(var_3);
  var_3 moveTo(var_1, 2, 0, 1);
  var_3 rotateTo(var_2, 2);
  wait 2;
  self unlink();
  var_3 delete();

  if(!scripts\engine\utility::flag("alerted_patrol")) {
    var_0 thread scripts\common\anim::anim_single_solo(self, "overlook_patrol");
    var_4 = getanimlength(scripts\engine\utility::getanim("overlook_patrol"));
    var_5 = lookupsoundlength("dx_vom_h72_forest_trees_patrol_150") / 1000;
    scripts\engine\utility::flag_set_delayed("overlook_patrol_reached_end", var_4 - var_5 - 4);
  } else
    scripts\common\utility::demeanor_override("combat");
}

check_player_visibility_to_patrol(var_0) {
  level endon("overlook_patrol_reached_end");
  level endon("stop_check_player_visibility_to_patrol");
  var_1 = 1;

  while(var_1) {
    if(scripts\engine\utility::flag("visible_to_patrol")) {
      foreach(var_3 in var_0) {
        if(distance(var_3.origin, level.player.origin) < 600 && var_3 cansee(level.player)) {
          var_1 = 0;
          scripts\engine\utility::flag_set("alerted_patrol");
          scripts\engine\utility::flag_set("overlook_patrol_reached_end");
          break;
        }
      }
    }

    waitframe();
  }
}

check_player_flashlight_visible_to_patrol() {
  level endon("overlook_patrol_reached_end");
  level endon("alerted_patrol");
  wait 4;

  for(;;) {
    if(level.player.flashlighton) {
      scripts\engine\utility::flag_set("alerted_patrol");
      scripts\engine\utility::flag_set("overlook_patrol_reached_end");
    }

    waitframe();
  }
}

check_throw_grenade_during_patrol() {
  level endon("near_ridge_edge");
  level.player waittill("grenade_fire", var_0);
  var_0 waittill("explode");
  scripts\engine\utility::flag_set("overlook_patrol_noise_made");
  scripts\engine\utility::flag_set("alerted_patrol");

  if(!scripts\engine\utility::flag("played_go_hot_admonishment"))
    level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_go_hot_admonishment();
}

check_overlook_patrol(var_0) {
  wait_flag_or_ai_death("overlook_patrol_reached_end", var_0);
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  level thread check_kill_overlook(var_0);
  scripts\engine\sp\utility::waittill_dead_or_dying(var_0);
  level notify("stop_check_player_visibility_to_patrol");
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_overlook_killed_patrol();
  scripts\engine\utility::flag_set("killed_overlook_patrol");
}

wait_flag_or_ai_death(var_0, var_1) {
  foreach(var_3 in var_1)
  var_3 endon("death");

  scripts\engine\utility::flag_wait(var_0);
}

check_kill_overlook(var_0) {
  level notify("start_check_kill_overlook");

  if(!scripts\engine\utility::flag("overlook_patrol_noise_made")) {
    if(var_0.size > 1)
      level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_overlook_kill_patrol(var_0);
    else
      level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_overlook_player_kill_patrol();

    var_1 = gettime();
    var_2 = 2;

    if(scripts\engine\utility::flag("alerted_patrol"))
      var_2 = 3.5;

    while(!scripts\engine\utility::time_has_passed(var_1, var_2) && isalive(level.overlookpatrol1) && isalive(level.overlookpatrol2))
      waitframe();
  }

  if(isalive(level.overlookpatrol1)) {
    wait 0.25;
    shoot_patrol_guy(level.overlookpatrol1);
  }

  wait 0.25;
  shoot_patrol_guy(level.overlookpatrol2);
}

shoot_patrol_guy(var_0) {
  var_1 = 0;

  if(isalive(var_0)) {
    foreach(var_3 in level.alpha_and_bravo_team) {
      var_4 = scripts\engine\trace::ray_trace(var_3 getEye(), var_0 getEye(), [var_3, var_0]);

      if(var_4["hittype"] == "hittype_none") {
        var_3 scripts\sp\maps\proxywar\proxywar_util.gsc::shoot_and_kill(var_0);
        var_1 = 1;
        break;
      }
    }

    if(!var_1) {
      foreach(var_3 in level.alpha_and_bravo_team) {
        var_4 = scripts\engine\trace::ray_trace(var_3 getEye(), var_0 getEye(), [var_3, var_0]);

        if(!(isDefined(var_4["entity"]) && isPlayer(var_4["entity"]))) {
          var_3 scripts\sp\maps\proxywar\proxywar_util.gsc::shoot_and_kill(var_0);
          break;
        }
      }
    }
  }
}

forest_trees_ally_alpha() {
  level thread check_forest_walk_anim_speed();
  level.forestmoveref scripts\common\anim::anim_single(level.alpha_team, "forest_move_enter");
  level notify("start_forest_move_a");
  level.forestmoveref scripts\common\anim::anim_single(level.alpha_team, "forest_move_a");
  level notify("end_anim_scale");
  level.forestmoveref thread scripts\common\anim::anim_loop(level.alpha_team, "forest_move_a_idle", "end_forest_idle_a");
  scripts\engine\utility::flag_wait("killed_overlook_patrol");
  waitframe();
  level.forestmoveref notify("end_forest_idle_a");

  foreach(var_1 in level.alpha_team)
  var_1 thread forest_trees_alpha_to_ridge();
}

forest_trees_alpha_to_ridge() {
  level.forestmoveref scripts\common\anim::anim_single_solo(self, "forest_move_b");
  level notify("end_anim_scale");

  if(self == level.alpha1)
    thread forest_overlook_alpha1();
  else
    thread forest_overlook_alpha2();
}

forest_trees_ally_bravo() {
  level waittill("start_forest_move_a");
  level.forestmoveref notify("end_forest_enter_idle");
  level.forestmoveref scripts\common\anim::anim_single(level.bravo_team, "forest_move_a");
  level.forestmoveref thread scripts\common\anim::anim_loop(level.bravo_team, "forest_move_a_idle", "end_forest_idle_a");
  scripts\engine\utility::flag_wait("killed_overlook_patrol");
  waitframe();
  level.forestmoveref notify("end_forest_idle_a");
  level.bravo_team scripts\sp\maps\proxywar\proxywar_util.gsc::play_group_single_anim_into_idle_anim(level.forestmoveref, "forest_move_b", "forest_move_b_idle", "end_forest_idle_b");
}

rus_overlook_patrol_spawnfunc() {
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.dontevershoot = 1;
  scripts\sp\utility::enable_flashlight(1);
  scripts\engine\utility::set_movement_speed(50);
  self.health = 10;
  self.diequietly = 1;
  scripts\common\utility::demeanor_override("patrol");
  scripts\engine\utility::waittill_any_ents(self, "bulletwhizby", level, "alerted_patrol");
  scripts\engine\utility::flag_set("alerted_patrol");
  self.ignoreall = 0;
  self stopanimScripted();
  scripts\common\utility::clear_demeanor_override();
  scripts\engine\utility::flag_set("overlook_patrol_reached_end");
}

check_forest_walk_anim_speed() {
  var_0 = scripts\engine\utility::getStruct("overlook_ridge_target", "targetname");
  level.alpha_team thread scale_anim_on_player_speed("forest_move_enter", var_0);
  level waittill("start_forest_move_a");
  level notify("end_anim_scale");
  level.alpha_and_bravo_team thread scale_anim_on_player_speed("forest_move_a", var_0);
  level waittill("start_forest_move_b");
  level.alpha_team thread scale_anim_on_player_speed("forest_move_b", var_0);
}

scale_anim_on_player_speed(var_0, var_1) {
  level endon("end_anim_scale");
  waitframe();
  var_2 = 1;

  for(;;) {
    var_3 = distance(level.player.origin, var_1.origin) - distance(level.alpha1.origin, var_1.origin);

    if(var_3 > 300) {
      var_2 = var_2 - 0.01;

      if(var_2 < 0.5)
        var_2 = 0.5;
    } else if(var_3 < 50) {
      var_2 = var_2 + 0.01;

      if(var_2 > 1.2)
        var_2 = 1.2;
    } else if(var_2 != 1) {
      if(var_2 > 1)
        var_2 = var_2 - 0.01;
      else
        var_2 = var_2 + 0.01;
    }

    foreach(var_5 in self)
    var_5 setanimrate(var_5 scripts\engine\utility::getanim(var_0), var_2);

    waitframe();
  }
}

forest_trees_catchup() {
  scripts\engine\utility::exploder("begin_amb_fx");
}

forest_overlook_start() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams();
  scripts\engine\sp\utility::set_start_location("start_forest_overlook", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  thread scripts\sp\player::player_movement_state("creep");
  level.player modifybasefov(50, 0.05);
  thread forest_overlook_door();
  level.alpha1 thread forest_overlook_alpha1();
  level.alpha2 thread forest_overlook_alpha2();
  level.forestmoveref = scripts\engine\utility::getStruct("forest_move_ref", "targetname");
  level.forestmoveref thread scripts\common\anim::anim_loop(level.bravo_team, "forest_move_b_idle", "end_forest_idle_b");
  level thread setup_overlook_scene();
}

forest_overlook_main() {
  scripts\engine\sp\utility::autosave_by_name("forest_overlook");
  level.fakelaser = spawn("script_model", scripts\engine\utility::getStruct("laser_source", "targetname").origin);
  level.fakelaser setModel("tag_laser");
  level.fakelaser thread setup_laser_pointer_fsm();

  if(!scripts\engine\utility::flag("overlook_went_hot"))
    level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_overlook_reached_edge();

  level thread test_go_hot();
  var_0 = 1;

  while(var_0) {
    if(scripts\engine\utility::flag("overlook_went_hot"))
      var_0 = 0;
    else if(scripts\engine\utility::flag("done_overlook_radio_callin"))
      var_0 = 0;

    waitframe();
  }

  if(!scripts\engine\utility::flag("overlook_went_hot"))
    level.player thread spotter_scope_check();

  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_recon_scout_facility", "targetname").origin);
  scripts\engine\utility::flag_wait("begin_airstrike");
  scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_target_calledin();
}

forest_overlook_alpha1() {
  level.ap_overlook_reveal scripts\common\anim::anim_single_solo(self, "overlook_reveal");

  if(!scripts\engine\utility::flag("overlook_went_hot"))
    level.ap_overlook_reveal scripts\common\anim::anim_single_solo(self, "overlook_reveal_point");

  level.ap_overlook_reveal thread scripts\common\anim::anim_loop_solo(self, "overlook_reveal_idle", "stop_loop_" + self.script_noteworthy);
  scripts\engine\utility::flag_set("alpha1_completed_reach_edge");
  scripts\engine\utility::flag_wait("near_ridge_edge");
  scripts\engine\utility::flag_wait("done_facility_scan");
  level.fakelaser notify("complete");
}

forest_overlook_alpha2() {
  level.ap_overlook_reveal scripts\common\anim::anim_single_solo(self, "overlook_reveal");
  level.ap_overlook_reveal thread scripts\common\anim::anim_loop_solo(self, "overlook_reveal_idle", "stop_loop_" + self.script_noteworthy);
  waitframe();
  scripts\engine\utility::flag_set("alpha_group_reached_edge");
  scripts\engine\utility::flag_set("alpha2_completed_reach_edge");
}

overlook_group_spawn_func() {
  level endon("death");
  self endon("remove");
  self.ignoreall = 1;
  self.goal_radius = 0;
  self.combatmode = "no_cover";
  self.enttargetjoint = "j_head";
  scripts\common\utility::demeanor_override("casual_gun");

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "front_gate_guard_left") {
      if(isDefined(self.hatmodel)) {
        self detach(self.hatmodel);
        self.hatmodel = undefined;
      }

      self setModel("body_russian_weapon_smugglers_1");
      self detach(self.headmodel);
      self.headmodel = "head_russian_army_balaclava_1";
      self attach(self.headmodel);
    } else if(self.script_noteworthy == "front_gate_guard_right") {
      if(isDefined(self.hatmodel)) {
        self detach(self.hatmodel);
        self.hatmodel = undefined;
      }

      self setModel("body_russian_weapon_smugglers_3");
      self detach(self.headmodel);
      self.headmodel = "head_russian_army_balaclava_2";
      self attach(self.headmodel);
    }
  }

  var_0 = 1;

  while(var_0) {
    var_1 = scripts\engine\utility::waittill_any_return("damage", "bulletwhizby");

    if(isDefined(var_1) && var_1 == "bulletwhizby") {
      if(level.player getcurrentweapon().basename != "iw8_spotter_scope")
        var_0 = 0;
    } else
      var_0 = 0;

    waitframe();
  }

  if(!scripts\engine\utility::flag("called_in_strike")) {
    level notify("kill_all_anim_instructions");
    scripts\engine\utility::flag_set("overlook_went_hot");

    if(isDefined(level.fakelaser))
      level.fakelaser notify("complete");
  }
}

setup_overlook_scene() {
  setsaveddvar("LKOLRONRNQ", 3000.0);
  var_0 = getEnt("watchtower_searchlight_source", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, (0, 0, 0));
  var_0 linkTo(var_1);
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2 linkTo(var_1, "tag_origin", (5, 0, 3), (0, 0, 0));
  var_1.searchlightmodel = var_0;
  var_1.tagoffset = var_2;
  playFXOnTag(scripts\engine\utility::getfx("vfx_proxywar_searchlight"), var_2, "tag_origin");
  var_1 thread searchlight_sweep();
  var_1 thread wait_searchlight_destroyed();
  level.overlookenemies = scripts\engine\sp\utility::array_spawn_targetname("overlook_group", 1);
  level.enemyactionsref = scripts\engine\utility::getStruct("enemy_actions_ref", "targetname");
  level thread overlook_truck_behavior();
  level thread overlook_suv_behavior();
  level thread check_tower_guard();
}

overlook_truck_behavior() {
  level.overlooktruck = scripts\engine\sp\utility::spawn_anim_model("overlook_truck", scripts\engine\utility::getStruct("overlook_truck_start", "targetname").origin, scripts\engine\utility::getStruct("overlook_truck_start", "targetname").angles);
  level.overlooktruck.enttargetjoint = "tag_accessory_02";
  level.overlooktruck.script_noteworthy = "overlook_truck";
  level.overlooktruck.headlights = getEntArray("truck_b_head_lights", "targetname");

  foreach(var_1 in level.overlooktruck.headlights)
  var_1 linkTo(level.overlooktruck);

  level.overlooktruck.taillights = getEntArray("truck_b_tail_lights", "targetname");

  foreach(var_1 in level.overlooktruck.taillights)
  var_1 linkTo(level.overlooktruck);

  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("truck_b_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("truck_b_tail_lights");
  level.overlooktruck playLoopSound("scn_proxy_overwatch_truck_idle_lp");
  level.enemyactionsref thread scripts\common\anim::anim_first_frame_solo(level.overlooktruck, "truck_enter");
  scripts\engine\utility::flag_wait_any("near_ridge_edge", "overlook_went_hot", "done_checkpoint_spot");
  scripts\engine\utility::flag_wait_any_timeout(20, "done_aim_look", "overlook_went_hot");
  scripts\engine\utility::flag_wait_or_timeout("overlook_went_hot", 5);
  scripts\engine\utility::flag_set("truck_moving");
  level thread truck_move_on();
  wait 4;
  scripts\engine\utility::flag_set("truck_moved_on");

  if(!scripts\engine\utility::flag("overlook_went_hot"))
    level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, level.overlooktruck);
}

truck_move_on() {
  level.overlooktruck stoploopsound();
  level.overlooktruck playSound("scn_proxy_overwatch_truck_drivein");
  level.enemyactionsref scripts\common\anim::anim_single_solo(level.overlooktruck, "truck_enter");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("truck_b_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("truck_b_tail_lights");
}

clear_all_vehicle_lights() {
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("truck_b_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("truck_b_tail_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_c_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_c_tail_lights");
}

overlook_suv_behavior() {
  var_0 = getEnt("front_gate_guard_left", "script_noteworthy");
  var_0.animname = "enemy1";
  var_1 = getEnt("front_gate_guard_right", "script_noteworthy");
  var_1.animname = "enemy2";
  var_2 = [var_0, var_1];
  level.enemyactionsref thread scripts\common\anim::anim_loop(var_2, "idle_a", "end_idle_a");
  level thread check_front_guards_go_hot(var_2);
  scripts\engine\utility::flag_wait("start_suv");
  scripts\engine\utility::flag_wait("truck_moved_on");
  var_3 = scripts\sp\door::get_interactive_door("breach_door");
  var_3 hide();
  level.overlooksuv = scripts\engine\sp\utility::spawn_anim_model("suv");
  level.overlooksuv.script_noteworthy = "overlook_suv";
  level.overlooksuv.enttargetjoint = "tag_body";
  level.enemyactionsref thread scripts\common\anim::anim_first_frame_solo(level.overlooksuv, "suv_enter_compound");
  level.overlooksuv.headlights = getEntArray("suv_c_head_lights", "targetname");

  foreach(var_5 in level.overlooksuv.headlights)
  var_5 linkTo(level.overlooksuv);

  level.overlooksuv.taillights = getEntArray("suv_c_tail_lights", "targetname");

  foreach(var_5 in level.overlooksuv.taillights)
  var_5 linkTo(level.overlooksuv);

  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("suv_c_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("suv_c_tail_lights");
  level.suvdriver = scripts\engine\sp\utility::spawn_script_noteworthy("suv_driver", 1);
  level.suvdriver.animname = "enemy3";
  level.suvpassenger = scripts\engine\sp\utility::spawn_script_noteworthy("suv_passenger", 1);
  level.suvpassenger.animname = "enemy4";
  var_9 = scripts\engine\sp\utility::spawn_anim_model("fake_door");
  level.enemyactionsref thread scripts\common\anim::anim_first_frame_solo(level.overlooksuv.fakebreachdoor, "suv_enter_compound");
  level.enemyactionsref notify("end_idle_a");
  level thread suv_enter_compound(var_2, var_9, var_3);
  level.overlooksuv playSound("scn_proxy_overwatch_suv_drivein");
  var_10 = 1;

  while(!scripts\engine\utility::flag("suv_patrol_complete") && var_10) {
    if(scripts\engine\utility::flag("overlook_went_hot")) {
      scripts\engine\utility::flag_wait("suv_patrol_started");
      level.suvdriver stopanimScripted();
      level.suvpassenger stopanimScripted();
      level.suvdriver.ignoreall = 0;
      level.suvdriver scripts\common\utility::clear_demeanor_override();
      level.suvdriver scripts\common\utility::clear_movement_speed();
      level.suvpassenger.ignoreall = 0;
      level.suvpassenger scripts\common\utility::clear_demeanor_override();
      level.suvpassenger scripts\common\utility::clear_movement_speed();

      if(isDefined(var_9)) {
        var_9 delete();
        var_3 show();
      }

      var_10 = 0;
    }

    waitframe();
  }
}

check_front_guards_go_hot(var_0) {
  level endon("phosphorus_done");
  scripts\engine\utility::flag_wait("overlook_went_hot");
  level.enemyactionsref notify("end_idle_a");

  foreach(var_2 in var_0) {
    var_2 stopanimScripted();
    var_2.ignoreall = 0;
    var_2 scripts\common\utility::clear_demeanor_override();
    var_2 scripts\common\utility::clear_movement_speed();
  }
}

suv_enter_compound(var_0, var_1, var_2) {
  level endon("overlook_went_hot");
  var_3 = [level.suvdriver, level.suvpassenger];
  level.enemyactionsref thread scripts\common\anim::anim_single_solo(level.overlooksuv, "suv_enter_compound");
  level.enemyactionsref thread scripts\common\anim::anim_single(var_3, "suv_enter_compound");
  var_0 thread scripts\sp\maps\proxywar\proxywar_util.gsc::play_group_single_anim_into_idle_anim(level.enemyactionsref, "suv_enter_compound", "idle_b", "end_idle_b");
  level.enemyactionsref scripts\common\anim::anim_single_solo(var_1, "suv_enter_compound");

  if(!scripts\engine\utility::flag("done_suv_patrol_spot"))
    scripts\engine\utility::flag_set("done_suv_patrol_spot");

  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, level.suvdriver);
  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, level.suvpassenger);

  if(isDefined(level.suvdriver)) {
    level.suvdriver notify("remove");
    level.suvdriver delete();
  }

  if(isDefined(level.suvpassenger)) {
    level.suvpassenger notify("remove");
    level.suvpassenger delete();
  }

  var_1 delete();
  var_2 show();
  scripts\engine\utility::flag_set("suv_patrol_complete");
}

check_tower_guard() {
  level endon("phosphorus_done");
  level endon("searchlight_destroyed");
  var_0 = getEnt("overlook_tower_guard", "script_noteworthy");

  while(isalive(var_0))
    wait 0.2;

  level notify("searchlight_destroyed");
}

spotter_scope_check() {
  level endon("overlook_went_hot");
  level thread spotterscope_check_lookat();

  while(!scripts\engine\utility::flag("done_facility_scan")) {
    scripts\engine\sp\utility::display_hint_forced("spotterscope_equip");
    scripts\engine\utility::flag_wait("equipped_spotter_scope");
    wait 1;

    if(scripts\engine\utility::flag("equipped_spotter_scope")) {
      if(!scripts\engine\utility::flag("done_aim_look")) {
        var_0 = "spotterscope_aim";

        if(level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledGamepad"))
          var_0 = "spotterscope_aim_toggle";
        else if(!level.player usinggamepad() && level.player getlocalplayerprofiledata("toggleADSEnabledKeyboard"))
          var_0 = "spotterscope_aim_toggle";

        scripts\engine\sp\utility::display_hint_forced(var_0);

        while(!scripts\engine\utility::flag("done_aim_look") && scripts\engine\utility::flag("equipped_spotter_scope"))
          waitframe();
      }
    }

    waitframe();
  }

  scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_callin_strike();
  level thread check_callin_strike();
}

check_callin_strike() {
  if(scripts\engine\utility::flag("equipped_spotter_scope") && scripts\engine\utility::flag("disabled_firing")) {
    scripts\engine\utility::flag_clear("disabled_firing");
    level.player scripts\common\utility::allow_fire(1, "spotter");
  }

  while(!scripts\engine\utility::flag("called_in_strike")) {
    if(scripts\engine\utility::flag("equipped_spotter_scope") && !scripts\engine\utility::flag("displaying_callin_hint")) {
      scripts\engine\sp\utility::display_hint_forced("call_in_strike");
      scripts\engine\utility::flag_set("displaying_callin_hint");
    }

    if(scripts\engine\utility::flag("equipped_spotter_scope") && level.player attackButtonPressed())
      scripts\engine\utility::flag_set("called_in_strike");

    if(!scripts\engine\utility::flag("equipped_spotter_scope")) {
      scripts\engine\utility::flag_set("alpha1_callin_strike");
      scripts\engine\utility::flag_set("called_in_strike");
    }

    waitframe();
  }

  if(scripts\engine\utility::flag("disabled_firing")) {
    scripts\engine\utility::flag_clear("disabled_firing");
    level.player scripts\common\utility::allow_fire(1, "spotter");
  }

  var_0 = level.player getcurrentweapon();

  if(!nullweapon(var_0) && var_0.basename == "iw8_spotter_scope") {
    var_1 = level.player.lastusedweapon getaltweapon();

    if(level.player.lastusedweaponisalt && !nullweapon(var_1))
      level.player switchtoweapon(var_1);
    else
      level.player switchtoweapon(level.player.lastusedweapon);
  }

  scripts\engine\utility::flag_set("begin_airstrike");
  scripts\engine\utility::flag_clear("allow_target_marking");
}

spotterscope_check_lookat() {
  level endon("overlook_went_hot");
  var_0 = undefined;
  var_1 = ["spotterscope_look_2", "spotterscope_look_3", "spotterscope_look_4"];
  var_2 = cos(2);
  level.spotterlookatents = [level.overlooktruck];
  level.spotterlookatents = scripts\engine\utility::array_combine(level.spotterlookatents, level.overlookenemies);
  level.timeinads = 0;
  level.idlespottertime = 0;
  level childthread check_time_in_ads();
  level childthread check_spotter_idle_time();
  level.currentlookatents = level.spotterlookatents;
  level.totalspottercount = 0;
  var_3 = [];
  scripts\engine\utility::flag_wait("done_aim_look");
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_overlook_scope_around_linger();
  var_4 = gettime();

  while(!scripts\engine\utility::flag("suv_patrol_started") && !scripts\engine\utility::flag("done_suv_spot") || (gettime() - var_4) / 1000 < 15 && level.totalspottercount < 1) {
    if(!scripts\engine\utility::flag("spotter_actively_tracking") && scripts\engine\utility::flag("truck_moved_on") && !scripts\engine\utility::flag("start_suv") && level.totalspottercount >= 1) {
      scripts\engine\utility::flag_set("spotter_actively_tracking");
      scripts\engine\utility::flag_set("start_suv");
      wait 1;
      level.fakelaser notify("track", [level.overlooksuv]);
      level.spotterlookatents[level.spotterlookatents.size] = level.overlooksuv;
      level.currentlookatents = level.spotterlookatents;
      scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_callout_suv();
      scripts\engine\utility::flag_clear("spotter_actively_tracking");
    }

    if(scripts\engine\utility::flag("start_suv") && !scripts\engine\utility::flag("done_suv_patrol_spot") && scripts\engine\utility::flag("suv_patrol_started") && !scripts\engine\utility::flag("added_suv_patrol")) {
      scripts\engine\utility::flag_set("added_suv_patrol");
      level.spotterlookatents[level.spotterlookatents.size] = getEnt("suv_driver", "script_noteworthy");
      level.spotterlookatents[level.spotterlookatents.size] = getEnt("suv_passenger", "script_noteworthy");
      level.currentlookatents = level.spotterlookatents;
    }

    if(scripts\engine\utility::flag("equipped_spotter_scope") && level.player scripts\engine\sp\utility::isads() && level.timeinads > 2) {
      var_5 = undefined;
      var_6 = 0;
      var_7 = undefined;
      var_8 = anglesToForward(level.player getplayerangles());

      foreach(var_10 in level.currentlookatents) {
        if(isDefined(var_10)) {
          var_11 = 0;

          if(var_10 scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_10 gettagorigin(var_10.enttargetjoint), var_2)) {
            var_12 = scripts\engine\trace::ray_trace(level.player getEye(), var_10 gettagorigin(var_10.enttargetjoint), [var_10, level.player]);

            if(var_12["fraction"] >= 0.99 && !scripts\engine\utility::array_contains(var_3, var_10))
              var_11 = 1;
          }

          if(var_11) {
            if(!isDefined(var_10.visibletime))
              var_10.visibletime = 0.15;
            else
              var_10.visibletime = var_10.visibletime + 0.15;

            if(var_10.visibletime >= 1) {
              var_7 = var_10;
              break;
            }
          } else
            var_10.visibletime = 0;
        }
      }

      if(isDefined(var_7)) {
        if(!scripts\engine\utility::flag("spotter_actively_tracking")) {
          switch (var_7.script_noteworthy) {
            case "overlook_railyard_enemy3":
            case "overlook_railyard_enemy2":
            case "overlook_railyard_enemy1":
              if(!scripts\engine\utility::flag("done_railyard_spot")) {
                scripts\engine\utility::flag_set("done_railyard_spot");
                scripts\engine\utility::flag_set("spotter_actively_tracking");
                railyard_guards_comment(var_7);
              }

              break;
            case "overlook_tower_guard":
              if(level.totalspottercount == 0) {
                if(!scripts\engine\utility::flag("done_checkpoint_spot")) {
                  scripts\engine\utility::flag_set("done_checkpoint_spot");
                  scripts\engine\utility::flag_set("spotter_actively_tracking");
                  checkpoint_comment(var_7);
                }
              } else if(!scripts\engine\utility::flag("done_tower_spot")) {
                scripts\engine\utility::flag_set("done_tower_spot");
                scripts\engine\utility::flag_set("spotter_actively_tracking");
                tower_comment(var_7);
              }

              break;
            case "front_gate_guard_right":
            case "front_gate_guard_left":
            case "overlook_truck":
              if(!scripts\engine\utility::flag("done_checkpoint_spot")) {
                scripts\engine\utility::flag_set("done_checkpoint_spot");
                scripts\engine\utility::flag_set("spotter_actively_tracking");
                checkpoint_comment(var_7);
              }

              break;
            case "overlook_suv":
              if(!scripts\engine\utility::flag("done_suv_spot")) {
                scripts\engine\utility::flag_set("done_suv_spot");
                scripts\engine\utility::flag_set("spotter_actively_tracking");
                overlook_suv_comment(var_7);
              }

              break;
            case "suv_passenger":
            case "suv_driver":
              if(!scripts\engine\utility::flag("done_suv_patrol_spot")) {
                scripts\engine\utility::flag_set("done_suv_patrol_spot");
                scripts\engine\utility::flag_set("spotter_actively_tracking");
                suv_patrol_comment(var_7);
              }

              break;
          }
        }
      }
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("done_facility_scan");
}

check_time_in_ads() {
  level endon("done_facilty_scan");
  var_0 = gettime();

  for(;;) {
    if(level.player scripts\engine\sp\utility::isads() && scripts\engine\utility::flag("equipped_spotter_scope"))
      level.timeinads = (gettime() - var_0) / 1000;
    else {
      level.timeinads = 0;
      var_0 = gettime();
    }

    waitframe();
  }
}

check_spotter_idle_time() {
  level endon("done_facility_scan");
  var_0 = gettime();
  scripts\engine\utility::flag_wait("done_aim_look");

  for(;;) {
    if(scripts\engine\utility::flag("spotter_actively_tracking")) {
      level.idlespottertime = 0;
      var_0 = gettime();
    } else
      level.idlespottertime = (gettime() - var_0) / 1000;

    waitframe();
  }
}

railyard_guards_comment(var_0) {
  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, getEnt("overlook_railyard_enemy1", "script_noteworthy"));
  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, getEnt("overlook_railyard_enemy2", "script_noteworthy"));
  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, getEnt("overlook_railyard_enemy3", "script_noteworthy"));
  scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_railyard();
  clean_up_post_spotter_comment();
}

checkpoint_comment(var_0) {
  if(var_0.script_noteworthy == "overlook_tower_guard")
    level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, getEnt("overlook_tower_guard", "script_noteworthy"));

  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, getEnt("front_gate_guard_left", "script_noteworthy"));
  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, getEnt("front_gate_guard_right", "script_noteworthy"));
  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, getEnt("overlook_truck", "script_noteworthy"));
  scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_checkpoint(var_0.script_noteworthy);
  clean_up_post_spotter_comment();
}

tower_comment(var_0) {
  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, getEnt("overlook_tower_guard", "script_noteworthy"));
  scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_tower_only();
  clean_up_post_spotter_comment();
}

overlook_suv_comment(var_0) {
  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, getEnt("suv_driver", "script_noteworthy"));
  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, getEnt("suv_passenger", "script_noteworthy"));
  scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_suv_moving();
  clean_up_post_spotter_comment();
}

suv_patrol_comment(var_0) {
  level.spotterlookatents = scripts\engine\utility::array_remove(level.spotterlookatents, var_0);
  scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_suv_patrol();
  clean_up_post_spotter_comment();
}

clean_up_post_spotter_comment() {
  wait 1;
  level.totalspottercount++;
  level.currentlookatents = level.spotterlookatents;
  scripts\engine\utility::flag_clear("spotter_actively_tracking");
}

spotterscope_equip_hint_check() {
  if(level.player getcurrentweapon().basename == "iw8_spotter_scope" || scripts\engine\utility::flag("begin_airstrike"))
    return 1;

  return 0;
}

spotterscope_aim_hint_check() {
  if(level.player scripts\engine\sp\utility::isads()) {
    scripts\engine\utility::flag_set("done_aim_look");
    return 1;
  }

  return 0;
}

spotterscope_fire_hint_check() {
  if(scripts\engine\utility::flag("called_in_strike") || !scripts\engine\utility::flag("equipped_spotter_scope") || scripts\engine\utility::flag("begin_airstrike")) {
    scripts\engine\utility::flag_clear("displaying_callin_hint");
    return 1;
  }

  return 0;
}

test_go_hot() {
  level endon("called_in_strike");
  childthread check_overlook_grenades();
  childthread check_loud_weapon_fire();

  if(!scripts\engine\utility::flag("overlook_went_hot") && !scripts\engine\utility::flag("overlook_patrol_noise_made"))
    level waittill("overlook_went_hot");

  wait 2;
  level.overlookenemies = scripts\engine\utility::array_removedead_or_dying(level.overlookenemies);

  foreach(var_1 in level.overlookenemies) {
    var_1.ignoreall = 0;
    var_1 scripts\common\utility::clear_demeanor_override();
    var_1 scripts\common\utility::clear_movement_speed();
  }

  scripts\engine\utility::flag_set("begin_airstrike");
  wait 2;
  level thread scripts\sp\maps\proxywar\proxywar_util.gsc::alarm_sound();

  if(!scripts\engine\utility::flag("near_ridge_edge") && !scripts\engine\utility::flag("played_go_hot_admonishment"))
    level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_go_hot_admonishment();
}

check_overlook_grenades() {
  level endon("overlook_went_hot");
  level.player waittill("grenade_fire", var_0);
  var_0 waittill("explode");
  level notify("kill_all_anim_instructions");
  scripts\engine\utility::flag_set("overlook_went_hot");

  if(isDefined(level.fakelaser))
    level.fakelaser notify("complete");
}

check_loud_weapon_fire() {
  level endon("overlook_went_hot");

  for(;;) {
    level.player waittill("weapon_fired", var_0);

    if(!(var_0.basename == "iw8_ar_mike4" || var_0.basename == "iw8_pi_golf21" || scripts\engine\utility::flag("equipped_spotter_scope"))) {
      level notify("kill_all_anim_instructions");
      scripts\engine\utility::flag_set("overlook_went_hot");

      if(isDefined(level.fakelaser))
        level.fakelaser notify("complete");
    }
  }
}

searchlight_sweep() {
  self endon("end_sweep");
  self.aimtarget = scripts\engine\utility::spawn_script_origin();
  var_0 = [scripts\engine\utility::getStruct("searchlight_sweep_1", "targetname"), scripts\engine\utility::getStruct("searchlight_sweep_2", "targetname"), scripts\engine\utility::getStruct("searchlight_sweep_3", "targetname")];
  self.aimtarget.origin = var_0[0].origin;
  childthread update_searchlight_facing();
  var_1 = 1;

  while(!scripts\engine\utility::flag("overlook_went_hot")) {
    self.aimtarget moveTo(var_0[var_1].origin, 5, 3, 2);
    wait 5;
    var_1++;

    if(var_1 > var_0.size - 1)
      var_1 = 0;
  }

  var_1 = 0;
  var_0 = [scripts\engine\utility::getStruct("searchlight_sweep_top_1", "targetname"), scripts\engine\utility::getStruct("searchlight_sweep_top_2", "targetname")];
  self.aimtarget moveTo(var_0[var_1].origin, 2, 1, 0.5);
  wait 2;

  for(;;) {
    var_1++;

    if(var_1 > var_0.size - 1)
      var_1 = 0;

    self.aimtarget moveTo(var_0[var_1].origin, 5, 3, 2);
    wait 5;
  }
}

update_searchlight_facing() {
  for(;;) {
    self.angles = vectortoangles(vectorNormalize(self.aimtarget.origin - self.origin));
    waitframe();
  }
}

wait_searchlight_destroyed() {
  level waittill("searchlight_destroyed");
  self notify("end_sweep");
  self.aimtarget delete();
  stopFXOnTag(level._effect["vfx_proxywar_searchlight"], self, "tag_origin");
  self.tagoffset delete();
  self.searchlightmodel delete();
  self delete();
  setsaveddvar("LKOLRONRNQ", 1000.0);
}

forest_overlook_catchup() {
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_recon_scout_facility", "targetname").origin);
}

forest_phosphorus_start() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams();
  scripts\engine\sp\utility::set_start_location("start_forest_phosphorus", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  thread scripts\sp\player::player_movement_state("creep");
  thread forest_overlook_door();
  level.enemyactionsref = scripts\engine\utility::getStruct("enemy_actions_ref", "targetname");
  level.ap_overlook_reveal thread scripts\common\anim::anim_loop_solo(level.alpha1, "overlook_reveal_idle", "stop_loop_" + level.alpha1.script_noteworthy);
  level.ap_overlook_reveal thread scripts\common\anim::anim_loop_solo(level.alpha2, "overlook_reveal_idle", "stop_loop_" + level.alpha2.script_noteworthy);
  level.player modifybasefov(50, 0.05);
  level.forestmoveref = scripts\engine\utility::getStruct("forest_move_ref", "targetname");
  level.forestmoveref thread scripts\common\anim::anim_loop(level.bravo_team, "forest_move_b_idle", "end_forest_idle_b");
  level.overlookenemies = [];
}

forest_phosphorus_main() {
  scripts\engine\utility::array_thread(level.alpha_team, ::forest_phosphorus_alpha);
  scripts\engine\utility::array_thread(level.bravo_team, ::forest_phosphorus_bravo);
  level.enemyactionsref notify("end_idle_b");
  level.player setsoundsubmix("sp_npc_steps_down", 3.0, 1.0);
  jets_drop_phosphorus();
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fa_post_phosphorus();
  scripts\engine\utility::flag_set("phosphorus_done");
  scripts\engine\utility::flag_wait("start_halligan_open");
  forest_phosphorus_freeze_offscreen();
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("obj_infil_1", "targetname").origin, &"PROXYWAR/OBJ_LOCATE_DSC", &"PROXYWAR/OBJ_LOCATE_LBL");
  scripts\engine\utility::flag_wait("trigger_drop_down");
  scripts\engine\sp\utility::autosave_by_name("drop_down");
  scripts\engine\utility::flag_wait("move_to_patrol");
}

forest_phosphorus_freeze_offscreen() {
  scripts\engine\utility::flag_wait("start_halligan_open");
  wait 10.0;

  if(!scripts\sp\maps\proxywar\proxywar_util.gsc::within_player_fov(level.alpha1.origin) && !scripts\sp\maps\proxywar\proxywar_util.gsc::within_player_fov(level.alpha2.origin)) {
    foreach(var_1 in level.alpha_team)
    var_1 setanimrate(var_1 scripts\engine\utility::getanim("overlook_door_bust"), 0.0);

    level.overlookdoor setanimrate(level.overlookdoor scripts\engine\utility::getanim("overlook_door_bust"), 0.0);

    while(!scripts\sp\maps\proxywar\proxywar_util.gsc::within_player_fov(level.alpha1.origin) && !scripts\sp\maps\proxywar\proxywar_util.gsc::within_player_fov(level.alpha2.origin))
      waitframe();

    foreach(var_1 in level.alpha_team)
    var_1 setanimrate(var_1 scripts\engine\utility::getanim("overlook_door_bust"), 1.0);

    level.overlookdoor setanimrate(level.overlookdoor scripts\engine\utility::getanim("overlook_door_bust"), 1.0);
  }
}

forest_phosphorus_alpha() {
  scripts\engine\utility::flag_wait("start_halligan_open");

  if(self.script_noteworthy == "alpha1")
    level.alpha1 thread scripts\sp\maps\proxywar\proxywar_util.gsc::halligan_draw();

  level.ap_overlook_reveal notify("stop_loop_" + self.script_noteworthy);
  level.ap_overlook_reveal scripts\common\anim::anim_single_solo(self, "overlook_door_bust");

  if(self.script_noteworthy == "alpha1")
    level.alpha1 thread scripts\sp\maps\proxywar\proxywar_util.gsc::halligan_stow();

  if(!scripts\engine\utility::flag("trigger_drop_down")) {
    if(self.script_noteworthy == "alpha1") {
      var_0 = ["dx_vom_h71_forest_phosphorus_house_50", "dx_vom_h71_forest_phosphorus_house_60", "dx_vom_h71_forest_phosphorus_house_70"];
      level thread show_objective_tutorial();
      level.alpha1 thread scripts\sp\maps\proxywar\proxywar_vo.gsc::nagtill_delayed(12, "trigger_drop_down", var_0, 15);
    }

    level.ap_overlook_reveal thread scripts\common\anim::anim_loop_solo(self, "overlook_door_bust_idle", "stop_loop_" + self.script_noteworthy);
  }

  scripts\engine\utility::flag_wait("trigger_drop_down");

  if(scripts\engine\utility::flag("displayed_early_objective_hint"))
    scripts\engine\utility::flag_set("done_objective_hint");

  level.ap_overlook_reveal notify("stop_loop_" + self.script_noteworthy);
  level.ap_overlook_reveal scripts\common\anim::anim_single_solo(self, "overlook_drop_down");
  scripts\engine\utility::flag_set(self.script_noteworthy + "_ready_for_move_to_patrol");

  if(!scripts\engine\utility::flag("move_to_patrol")) {
    if(self.script_noteworthy == "alpha1") {
      var_0 = ["dx_vom_h71_forest_phosphorus_contact_20", "dx_vom_h71_forest_phosphorus_contact_30", "dx_vom_h71_forest_phosphorus_contact_40"];
      level.alpha1 thread scripts\sp\maps\proxywar\proxywar_vo.gsc::nagtill_delayed(12, "move_to_patrol", var_0, 15);
    }

    level.ap_overlook_reveal thread scripts\common\anim::anim_loop_solo(self, "overlook_drop_down_idle", "stop_loop_" + self.script_noteworthy);
  }
}

show_objective_tutorial() {
  level endon("trigger_drop_down");
  wait 10;

  if(scripts\engine\utility::flag("trigger_drop_down")) {
    return;
  }
  scripts\engine\utility::flag_set("displayed_early_objective_hint");
  scripts\engine\sp\utility::display_hint_forced("objective_tutorial");
  level.player notifyonplayercommand("objective_pressed", "+focus");
  level.player waittill("objective_pressed");
  scripts\engine\utility::flag_set("done_objective_hint");
}

forest_phosphorus_bravo() {
  scripts\engine\utility::flag_wait("trigger_drop_down");
  level.forestmoveref notify("end_forest_idle_b");
  scripts\engine\sp\utility::disable_dynamic_run_speed(75);
  scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_targetname("abandoned_house_" + self.script_noteworthy);
}

jet_fly(var_0) {
  var_0 scripts\common\anim::anim_single_solo(self, "fly");
  self delete();
}

jets_drop_phosphorus() {
  var_0 = scripts\engine\utility::getStruct("jet_fly_ref", "targetname");
  var_1 = getEnt("wp_jet_1", "targetname");
  var_1.animname = "jet1";
  var_1 scripts\common\anim::setanimtree();
  var_2 = getEnt("wp_jet_2", "targetname");
  var_2.animname = "jet2";
  var_2 scripts\common\anim::setanimtree();
  level.activewpzones = [];
  level.activewpflares = [];
  level.activewpfires = [];
  level thread guys_react_to_jets();
  var_1 playSound("jet_flyover_a");
  var_2 scripts\engine\utility::delaycall(2.5, ::playsound, "jet_flyover_b");
  wait 2;
  wait 0.2;
  wait 1;
  level thread enemies_look_at_jets();
  var_1 thread jet_fly(var_0);
  var_2 thread jet_fly(var_0);
  scripts\engine\utility::exploder("wp_launch_02");
  level thread burn_enemies();
  thread wp_explosions();
  wait 5.5;
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.1, 0.7, level.player.origin, 400);
  wait 3;
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.3, 1, level.player.origin, 400);
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_c_head_lights");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("suv_c_tail_lights");
  level thread clear_all_vehicle_lights();

  if(isDefined(level.overlooksuv))
    level.overlooksuv delete();

  var_3 = getEntArray("burning_truck", "targetname");

  foreach(var_5 in var_3)
  var_5 show();

  if(isDefined(level.overlookvehicle))
    level.overlookvehicle delete();

  var_7 = getEntArray("burning_truck_pre", "targetname");

  foreach(var_5 in var_7)
  var_5 hide();

  var_10 = getEnt("burning_truck_col", "targetname");
  var_10 solid();
  level notify("searchlight_destroyed");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("proxywar_lights_overlook");
  level thread switch_light_fixtures();
  scripts\engine\utility::flag_set("proxywar_lights_overlook_fire");
  scripts\engine\utility::delaythread(6, scripts\sp\maps\proxywar\proxywar_util.gsc::alarm_sound);
}

wp_explosions() {
  thread audio_wp_explosions();
  wait 6;
  level notify("audio_wp_explo_1");
  scripts\engine\utility::exploder("wp_explo");
  scripts\engine\utility::stop_exploder("begin_flares");
  scripts\engine\utility::stop_exploder("begin_amb_fx");
  scripts\engine\utility::exploder("towerfire_start");
  visionsetnaked("proxywar_forest_overlook_wp", 0.2);
  wait 1;
  scripts\engine\utility::exploder("wp_explo_aftermath_forest");
  scripts\engine\utility::exploder("big_smokes");
  scripts\engine\utility::exploder("aftermath_big_light");
  wait 1;
  level notify("audio_wp_explo_2");
  wait 2;
  visionsetnaked("", 3);
  scripts\engine\utility::exploder("mid_amb_fx");
  wait 3;
  level notify("audio_wp_explo_3");
  scripts\engine\utility::exploder("small_explo_01");
}

audio_wp_explosions() {
  thread audio_wp_sizzle();
  level waittill("audio_wp_explo_1");
  thread scripts\engine\utility::play_sound_in_space("scn_wp_ground_explo_01_lr", (2900, 139, 386));
  level waittill("audio_wp_explo_2");
  thread scripts\engine\utility::play_sound_in_space("scn_wp_ground_explo_02_lr", (945, -252, 650));
  wait 0.35;
  thread scripts\engine\utility::play_sound_in_space("scn_wp_ground_explo_03_lr", (-36, 1592, 649));
  level waittill("audio_wp_explo_3");
  wait 1;
  thread scripts\engine\utility::play_sound_in_space("scn_wp_ground_explo_04_lr", (1499, 358, 414));
  wait 2.5;
  thread scripts\engine\utility::play_sound_in_space("scn_wp_ground_explo_05_lr", (-640, 1267, 597));
}

audio_wp_sizzle() {
  level.sfx_wp_01 = spawn("script_origin", (5090.72, 455.085, 2987.61));
  level.sfx_wp_02 = spawn("script_origin", (1967.43, 446.992, 2441.66));
  level.sfx_wp_01 playSound("scn_wp_explo_travel_01");
  level.sfx_wp_02 scripts\engine\utility::delaycall(2.0, ::playsound, "scn_wp_explo_travel_02");
  level.sfx_wp_01 moveTo((2332, 587, 397), 6, 0, 0);
  level.sfx_wp_02 scripts\engine\utility::delaycall(2.0, ::moveto, (-182, -166, 858), 6, 0, 0);
  wait 20;
  level.sfx_wp_01 delete();
  level.sfx_wp_02 delete();
}

guys_react_to_jets() {
  wait 1;

  if(!scripts\engine\utility::flag("alpha1_completed_reach_edge") || !scripts\engine\utility::flag("alpha2_completed_reach_edge")) {
    return;
  }
  level.ap_overlook_reveal notify("stop_loop_" + level.alpha1.script_noteworthy);
  level.ap_overlook_reveal notify("stop_loop_" + level.alpha2.script_noteworthy);
  level.alpha1 thread play_jet_look();
  level.alpha2 thread play_jet_look();
}

play_jet_look() {
  level.ap_overlook_reveal scripts\common\anim::anim_single_solo(self, "overlook_reveal_react");
  level.ap_overlook_reveal thread scripts\common\anim::anim_loop_solo(self, "overlook_reveal_idle", "stop_loop_" + self.script_noteworthy);
}

enemies_look_at_jets() {
  level.overlookenemies = scripts\engine\utility::array_removedead_or_dying(level.overlookenemies);

  foreach(var_1 in level.overlookenemies) {
    if(isalive(var_1)) {
      switch (var_1.script_noteworthy) {
        case "front_gate_guard_right":
        case "front_gate_guard_left":
        case "overlook_tower_guard":
          var_1 thread look_at_jets();
          break;
      }
    }
  }
}

burn_enemies() {
  level.overlookenemies = scripts\engine\utility::array_removedead_or_dying(level.overlookenemies);

  foreach(var_1 in level.overlookenemies) {
    if(isalive(var_1)) {
      switch (var_1.script_noteworthy) {
        case "overlook_railyard_enemy1":
          var_1.burndelaytime = 7.5;
          var_1 thread wp_death_quick();
          break;
        case "overlook_railyard_enemy2":
          var_1.burndelaytime = 7.1;
          var_1 thread wp_death_quick();
          break;
        case "overlook_railyard_enemy3":
          var_1.burndelaytime = 7;
          var_1 thread wp_death_quick();
          break;
        case "overlook_tower_guard":
          var_1 thread phosphorus_aim();
          var_1 scripts\engine\utility::delaycall(6, ::stopanimscripted);
          var_1 scripts\engine\utility::delaythread(6, scripts\sp\utility::do_damage, var_1.health + 9999, var_1.origin, level.player, level.player, "MOD_RIFLE_BULLET", "iw8_ar_akilo47");
          break;
        case "front_gate_guard_left":
          var_1 thread phosphorus_run_react("left_guard_run", 4.5);
          var_1.burndelaytime = 6.2;
          var_1 thread wp_death();
          break;
        case "front_gate_guard_right":
          var_1 thread phosphorus_run_react("right_guard_run", 4);
          var_1.burndelaytime = 6.6;
          var_1 thread wp_death();
          break;
      }
    }
  }

  if(isDefined(level.suvdriver)) {
    if(isalive(level.suvdriver)) {
      level.suvdriver.burndelaytime = 7.3;
      level.suvdriver thread wp_death();
    }
  }

  if(isDefined(level.suvpassenger)) {
    if(isalive(level.suvpassenger)) {
      level.suvpassenger.burndelaytime = 8;
      level.suvpassenger thread wp_death();
    }
  }
}

look_at_jets() {
  var_0 = scripts\engine\utility::spawn_script_origin(self.origin + (0, 0, 300), (0, 0, 0));
  self setlookatentity(var_0, 0);
  wait 3;
  var_0.origin = var_0.origin + (60, 0, 0);
  scripts\engine\utility::flag_wait("phosphorus_done");
  var_0 delete();
}

phosphorus_aim() {
  self endon("death");
  self.dontevershoot = 1;
  scripts\common\utility::demeanor_override("combat");
  scripts\sp\utility::aim_at(self.origin + (60, 0, 300));
}

phosphorus_run_react(var_0, var_1) {
  self endon("death");
  self.dontevershoot = 1;
  wait(var_1);
  thread scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_targetname(var_0);
  scripts\common\utility::demeanor_override("combat");
  self stopanimScripted();
}

forest_phosphorus_catchup() {
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_off("proxywar_lights_overlook");
  thread scripts\sp\maps\proxywar\proxywar_lighting.gsc::lights_on("proxywar_lights_overlook_fire");
  level thread switch_light_fixtures();
  var_0 = getEnt("wp_jet_1", "targetname");
  var_1 = getEnt("wp_jet_2", "targetname");
  var_0 delete();
  var_1 delete();

  if(!scripts\sp\starts::is_after_start("railyard_entrance"))
    scripts\engine\utility::exploder("towerfire_start");

  if(!scripts\sp\starts::is_after_start("warehouse_enter"))
    scripts\engine\utility::exploder("mid_amb_fx");

  if(!scripts\sp\starts::is_after_start("railyard_combat_intro")) {
    scripts\engine\utility::exploder("wp_explo_aftermath_forest");
    scripts\engine\utility::exploder("aftermath_big_light");
  }

  scripts\engine\utility::flag_set("alpha1_ready_for_move_to_patrol");
  scripts\engine\utility::flag_set("alpha2_ready_for_move_to_patrol");
  scripts\engine\utility::flag_set("proxywar_lights_overlook_fire");
  level thread clear_all_vehicle_lights();
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("obj_infil_1", "targetname").origin, &"PROXYWAR/OBJ_LOCATE_DSC", &"PROXYWAR/OBJ_LOCATE_LBL");
}

wp_death() {
  if(isalive(self))
    wait(self.burndelaytime);

  if(isalive(self)) {
    self stopanimScripted();
    self._blackboard.isburning = 1;
    self.burningtodeath = 1;
    self.burningdirection = undefined;
    scripts\sp\utility::do_damage(self.health + 9999, self.origin, level.player, level.player, "MOD_FIRE", "molotov");
    thread molotov_burn_sfx();
    level thread remove_blackboard_isburning(self);
  }
}

wp_death_quick() {
  if(isalive(self))
    wait(self.burndelaytime);

  self kill();
}

molotov_burn_sfx(var_0) {
  if(isDefined(var_0))
    var_1 = 1;
  else
    var_1 = 0.5;

  if(!isDefined(self.burnsfxenabled))
    self.burnsfxenabled = 0;

  if(!isDefined(self.burnsfx)) {
    self.burnsfx = spawn("script_origin", self.origin);
    self.burnsfx linkTo(self);
    wait 0.05;
  }

  if(self.burnsfxenabled == 0) {
    self.burnsfxenabled = 1;
    wait(var_1);
    wait 0.15;

    if(isDefined(self.burnsfx)) {
      self.burnsfx delete();
      self.burnsfxenabled = 0;
    }
  }
}

remove_blackboard_isburning(var_0) {
  waitframe();

  if(!isDefined(var_0)) {
    return;
  }
  var_0._blackboard.isburning = undefined;
}

forest_overlook_door() {
  if(!isDefined(level.ap_overlook_reveal))
    level.ap_overlook_reveal = scripts\engine\utility::getStruct("ap_overlook_reveal", "targetname");

  level.overlookdoor = scripts\sp\maps\proxywar\proxywar_util.gsc::setup_scripted_door("overlook_door");
  level.overlookdoor scripts\engine\sp\utility::assign_animtree("overlook_door");
  level.ap_overlook_reveal thread scripts\common\anim::anim_first_frame_solo(level.overlookdoor, "overlook_door_bust");
  scripts\engine\utility::flag_wait("start_halligan_open");
  level.overlookdoor.clip connectpaths();
  level.ap_overlook_reveal scripts\common\anim::anim_single_solo(level.overlookdoor, "overlook_door_bust");
}

switch_light_fixtures() {
  var_0 = getEntArray("railyard_light_fixture", "targetname");

  foreach(var_2 in var_0)
  var_2 setModel("lighting_fixtures_security_lamp_01");
}

forest_patrol_start() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams();
  scripts\engine\sp\utility::set_start_location("start_forest_patrol", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  level.player modifybasefov(50, 0.05);
  thread scripts\sp\player::player_movement_state("creep");
}

forest_patrol_main() {
  level scripts\engine\utility::delaythread(0.1, scripts\engine\sp\utility::transient_load_array, ["pw_storage_room_interior_tr", "pw_trainyard_front_detail_tr", "pw_shack_interior_tr", "pw_trainyard_main_detail_tr"]);
  var_0 = getEnt("opaque_glass_panel", "targetname");
  var_0 delete();
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fp_flashlight_nag();
  setsaveddvar("MNSOQLKMT", "2.8 0.0006 1 1");
  scripts\engine\utility::stop_exploder("begin_amb_fx");
  scripts\engine\utility::stop_exploder("begin_flares");
  scripts\engine\sp\utility::autosave_by_name("forest_patrol");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_infil_2", "targetname").origin);
  clearallcorpses();
  scripts\engine\utility::array_thread(level.alpha_and_bravo_team, ::forest_patrol_ally);
  level.ap_patrol = scripts\engine\utility::getStruct("ap_patrol", "targetname");
  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname("rus_veh_forest_patrol");
  var_1 scripts\common\vehicle_build::build_light("script_vehicle_iw8_decho_black", "custom_headlight_truck_left", "tag_light_front_left", "vfx/iw8/level/proxywar/vfx_pw_veh_sys_headlight_decho_left", "custom_headlights");
  var_1 scripts\common\vehicle_build::build_light("script_vehicle_iw8_decho_black", "custom_headlight_truck_right", "tag_light_front_right", "vfx/iw8/level/proxywar/vfx_pw_veh_sys_headlight_decho_right", "custom_headlights");
  var_1 scripts\common\vehicle_build::build_light("script_vehicle_iw8_decho_black", "custom_taillight_truck_left", "tag_light_back_left", "vfx/iw8/level/proxywar/vfx_pw_veh_sys_taillight_decho_left", "custom_brakelights");
  var_1 scripts\common\vehicle_build::build_light("script_vehicle_iw8_decho_black", "custom_taillight_truck_right", "tag_light_back_right", "vfx/iw8/level/proxywar/vfx_pw_veh_sys_taillight_decho_right", "custom_brakelights");
  var_1 scripts\common\vehicle::vehicle_lights_on("custom_headlights");
  var_1 scripts\common\vehicle::vehicle_lights_on("custom_brakelights");
  var_1 scripts\engine\sp\utility::assign_animtree("rus_forest_patrol_truck");
  var_1 connectpaths();
  var_2 = scripts\engine\sp\utility::array_spawn_targetname("rus_forest_patrol", 1);
  scripts\engine\utility::array_thread(var_2, ::forest_patrol_enemy_approach, var_1);
  level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fp_patrol_incoming(var_2);
  level.player setsoundsubmix("sp_npc_body_ragdoll_down", 2.0);
  var_3 = scripts\engine\sp\utility::array_spawn_targetname("rus_return_pmcs");
  thread forest_patrol_player_fire_checker();
  thread forest_patrol_player_visible_checker(var_2);
  thread forest_patrol_eliminate_speed_runner(scripts\engine\utility::array_combine(var_2, var_3));
  level.alpha1 thread scripts\sp\maps\proxywar\proxywar_util.gsc::ally_track_and_kill_noteworthy("rus_forest_patrol_2", "eliminate_patrol_1");
  level.alpha2 thread scripts\sp\maps\proxywar\proxywar_util.gsc::ally_track_and_kill_noteworthy("rus_forest_patrol_4", "eliminate_patrol_2");
  level.bravo1 thread scripts\sp\maps\proxywar\proxywar_util.gsc::ally_track_and_kill_noteworthy("rus_forest_patrol_3", "eliminate_patrol_3");
  level.bravo2 thread scripts\sp\maps\proxywar\proxywar_util.gsc::ally_track_and_kill_noteworthy("rus_forest_patrol_1", "eliminate_patrol_4");
  var_1 scripts\engine\utility::delaycall(1.0, ::disconnectpaths);
  level.ap_patrol thread scripts\common\anim::anim_single_solo(var_1, "patrol_arrive");
  scripts\engine\utility::flag_wait("start_patrol_anim");
  scripts\engine\utility::flag_clear("done_objective_hint");
  scripts\engine\utility::flag_clear("displayed_early_objective_hint");

  if(!scripts\engine\utility::flag("player_skipping_patrol"))
    scripts\engine\utility::flag_wait_any("player_prompted_for_patrol", "player_fired_at_patrol", "player_too_close_to_patroller", "player_skipping_patrol");

  var_4 = scripts\engine\utility::flag("player_fired_at_patrol") || scripts\engine\utility::flag("player_too_close_to_patroller") || scripts\engine\utility::flag("player_skipping_patrol");
  var_5 = "";

  if(var_4) {
    level notify("end_flashlight_nag");

    if(scripts\engine\utility::flag("player_fired_at_patrol"))
      var_5 = "fired";
    else if(scripts\engine\utility::flag("player_too_close_to_patroller"))
      var_5 = "spotted";
    else
      var_5 = "skipped";
  }

  if(!scripts\engine\utility::flag("player_skipping_patrol"))
    scripts\engine\utility::flag_wait_any_timeout(3.0, "player_fired_at_patrol", "player_too_close_to_patroller", "player_skipping_patrol");

  scripts\engine\utility::flag_set("eliminate_patrol_1");

  if(var_4)
    wait 1.0;
  else
    wait 0.1;

  scripts\engine\utility::flag_set("eliminate_patrol_2");

  if(var_4)
    wait 1.5;
  else
    wait 0.3;

  scripts\engine\utility::flag_set("eliminate_patrol_3");

  if(var_4)
    wait 1.0;
  else
    wait 0.1;

  scripts\engine\utility::flag_set("eliminate_patrol_4");
  scripts\engine\sp\utility::waittill_dead_or_dying(var_2);

  foreach(var_7 in var_3) {
    if(isalive(var_7))
      wait(randomfloatrange(0.5, 1.0));

    if(isalive(var_7)) {
      var_8 = scripts\engine\utility::random(level.alpha_and_bravo_team);
      var_8 scripts\sp\maps\proxywar\proxywar_util.gsc::shoot_and_kill(var_7);
    }
  }

  level notify("stop_checking_skip");
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fp_patrol_eliminated();
  level.player clearsoundsubmix("sp_npc_body_ragdoll_down", 6.0);

  if(var_4 && var_5 == "fired")
    thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fp_going_hot();
}

forest_patrol_eliminate_speed_runner(var_0) {
  level endon("stop_checking_skip");
  scripts\engine\utility::flag_wait("player_skipping_patrol");
  var_1 = 0;

  while(var_1 < 3) {
    var_2 = scripts\engine\sp\utility::get_closest_living(level.player.origin, var_0, 100000);
    var_3 = level.player getEye();
    var_4 = vectorNormalize(var_2 gettagorigin("tag_flash") - var_3) * 100;
    magicbullet(var_2.weapon.basename, var_3 + var_4, var_3, var_2);
    var_1++;
    wait(randomfloatrange(0.1, 0.3));
  }

  level.player kill();
}

forest_patrol_ally() {
  self notify("stop_previous_logic");
  self endon("stop_previous_logic");
  scripts\engine\utility::flag_wait("move_to_patrol");
  scripts\engine\sp\utility::disable_dynamic_run_speed(randomintrange(80, 110));
  var_0 = scripts\engine\utility::getStruct("ap_approach", "targetname");

  if(scripts\engine\utility::array_contains(level.bravo_team, self))
    var_0 scripts\sp\anim::anim_reach_solo(self, "patrol_approach");
  else {
    if(isDefined(level.ap_overlook_reveal))
      level.ap_overlook_reveal notify("stop_loop_" + self.script_noteworthy);

    scripts\engine\utility::flag_wait(self.script_noteworthy + "_ready_for_move_to_patrol");
  }

  var_0 scripts\common\anim::anim_single_solo(self, "patrol_approach");
  scripts\engine\utility::flag_set("start_patrol_anim");
  var_0 thread scripts\common\anim::anim_loop_solo(self, "patrol_approach_idle", "stop_loop_" + self.script_noteworthy);
}

forest_patrol_enemy_return() {
  self endon("death");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.goalradius = 1;
  scripts\engine\utility::flag_wait_any("start_patrol_anim", "player_fired_at_patrol", "player_too_close_to_patroller", "player_skipping_patrol");

  if(scripts\engine\utility::flag("start_patrol_anim")) {
    if(!isDefined(level.patrol_return_offset))
      level.patrol_return_offset = 0.25;
    else
      level.patrol_return_offset = level.patrol_return_offset + 0.25;

    wait(randomfloatrange(1.5, 2.0) + level.patrol_return_offset);
  }

  if(!scripts\engine\utility::flag("player_fired_at_patrol") && !scripts\engine\utility::flag("player_too_close_to_patroller") && !scripts\engine\utility::flag("player_skipping_patrol"))
    scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_targetname("return_pmcs_end_" + self.script_noteworthy);
  else {
    self.ignoreall = 0;
    self.ignoreme = 0;
    self.favoriteenemy = level.player;
    self.goalradius = 10000;
    scripts\sp\utility::enable_flashlight();
    self.health = int(self.health / 2);
  }
}

forest_patrol_enemy_approach(var_0) {
  self endon("death");
  self.animname = self.script_noteworthy;
  self.ignoreall = 1;
  self.dontevershoot = 1;
  scripts\engine\utility::set_movement_speed(50);
  self.diequietly = 1;
  self.allowdeath = 1;
  level.ap_patrol thread scripts\common\anim::anim_first_frame_solo(self, "patrol_arrive");
  scripts\engine\utility::flag_wait_any("start_patrol_anim", "player_fired_at_patrol", "player_too_close_to_patroller", "player_skipping_patrol");
  scripts\engine\utility::flag_wait_any_timeout(1.5, "player_fired_at_patrol", "player_too_close_to_patroller", "player_skipping_patrol");

  if(!scripts\engine\utility::flag("player_fired_at_patrol") && !scripts\engine\utility::flag("player_too_close_to_patroller") && !scripts\engine\utility::flag("player_skipping_patrol")) {
    thread forest_patrol_enemy_approach_flashlight();
    scripts\common\ai::set_gunpose("disable");
    level.ap_patrol thread scripts\sp\maps\proxywar\proxywar_util.gsc::anim_single_solo_end_notify("arrived", self, "patrol_arrive");
    var_1 = scripts\engine\utility::waittill_any_ents_return(self, "arrived", level, "player_fired_at_patrol", level, "player_too_close_to_patroller", level, "player_skipping_patrol");
  } else {
    scripts\sp\utility::enable_flashlight();
    level.ap_patrol thread scripts\common\anim::anim_single_solo(self, "patrol_arrive");
    waitframe();
    var_1 = "player_fired_at_patrol";
  }

  if(var_1 == "arrived") {
    thread forest_patrol_enemy_light_sweep();
    thread scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_targetname("search_" + self.script_noteworthy);
  }

  scripts\engine\utility::flag_wait_any("player_fired_at_patrol", "player_too_close_to_patroller", "player_skipping_patrol");

  if(var_1 == "arrived" && scripts\engine\utility::flag("player_prompted_for_patrol"))
    wait 1.0;

  self stopanimScripted();
  scripts\common\ai::set_gunpose("automatic");
  scripts\sp\utility::stop_aiming();
  self notify("stop_going_to_node");
  scripts\common\utility::clear_movement_speed();
  self.diequietly = 0;
  self.ignoreall = 0;
  self.dontevershoot = 0;
  wait 0.1;
  scripts\engine\sp\utility::set_goal_pos(self.origin);
}

forest_patrol_enemy_approach_flashlight() {
  scripts\engine\utility::flag_wait_any_timeout(2.4, "player_fired_at_patrol", "player_too_close_to_patroller", "player_skipping_patrol");
  scripts\sp\utility::enable_flashlight();
}

forest_patrol_enemy_light_sweep() {
  self endon("death");
  self endon("damage");
  self endon("stop_aiming");
  wait(randomfloatrange(0.5, 1.5));
  var_0 = scripts\engine\utility::getStruct("light_" + self.script_noteworthy, "targetname");
  self.ignoreall = 0;

  if(isalive(self)) {
    scripts\sp\utility::aim_at(var_0.origin);
    scripts\sp\utility::move_aim_along_spline(var_0, randomfloatrange(3.0, 6.0));
  }
}

forest_patrol_player_fire_checker() {
  level endon("eliminate_patrol_1");
  level.player scripts\engine\utility::waittill_any("weapon_fired", "grenade_fire");
  scripts\engine\utility::flag_set("player_fired_at_patrol");
}

forest_patrol_player_visible_checker(var_0) {
  level endon("eliminate_patrol_1");
  var_1 = 0;

  while(!var_1) {
    foreach(var_3 in var_0) {
      if(var_3 scripts\sp\maps\proxywar\proxywar_util.gsc::can_flashlight_ai_see_player(1) || scripts\sp\maps\proxywar\proxywar_util.gsc::player_shining_light_at(var_3)) {
        var_1 = 1;
        break;
      }
    }

    waitframe();
  }

  scripts\engine\utility::flag_set("player_too_close_to_patroller");
}

forest_patrol_catchup() {
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_infil_2", "targetname").origin);
  level.ap_patrol = scripts\engine\utility::getStruct("ap_patrol", "targetname");
  var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname("rus_veh_forest_patrol");
  var_0 scripts\common\vehicle_build::build_light("script_vehicle_iw8_decho_black", "custom_headlight_truck_left", "tag_light_front_left", "vfx/iw8/level/proxywar/vfx_pw_veh_sys_headlight_decho_left", "custom_headlights");
  var_0 scripts\common\vehicle_build::build_light("script_vehicle_iw8_decho_black", "custom_headlight_truck_right", "tag_light_front_right", "vfx/iw8/level/proxywar/vfx_pw_veh_sys_headlight_decho_right", "custom_headlights");
  var_0 scripts\common\vehicle_build::build_light("script_vehicle_iw8_decho_black", "custom_taillight_truck_left", "tag_light_back_left", "vfx/iw8/level/proxywar/vfx_pw_veh_sys_taillight_decho_left", "custom_brakelights");
  var_0 scripts\common\vehicle_build::build_light("script_vehicle_iw8_decho_black", "custom_taillight_truck_right", "tag_light_back_right", "vfx/iw8/level/proxywar/vfx_pw_veh_sys_taillight_decho_right", "custom_brakelights");
  var_0 scripts\common\vehicle::vehicle_lights_on("custom_headlights");
  var_0 scripts\common\vehicle::vehicle_lights_on("custom_brakelights");
  var_0 scripts\engine\sp\utility::assign_animtree("rus_forest_patrol_truck");
  var_0 connectpaths();
  var_0 scripts\engine\utility::delaycall(1.0, ::disconnectpaths);
  level.ap_patrol scripts\common\anim::anim_last_frame_solo(var_0, "patrol_arrive");
}

forest_exit_start() {
  scripts\sp\maps\proxywar\proxywar_util.gsc::spawn_ally_teams();
  scripts\engine\sp\utility::set_start_location("start_forest_exit", scripts\engine\utility::array_combine([level.player], level.alpha_and_bravo_team));
  thread scripts\sp\player::player_movement_state("creep");
}

forest_exit_main() {
  scripts\engine\sp\utility::autosave_by_name("forest_exit");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_infil_3", "targetname").origin);
  thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fe_burning_woods();
  scripts\engine\utility::array_thread(level.alpha_and_bravo_team, ::forest_exit_ally);
  scripts\engine\utility::flag_wait("reached_railyard_entrance");
}

forest_exit_ally() {
  self notify("stop_previous_logic");
  self endon("stop_previous_logic");
  var_0 = scripts\engine\utility::getStruct("ap_approach", "targetname");
  var_0 notify("stop_loop_" + self.script_noteworthy);

  if(scripts\sp\maps\proxywar\proxywar_util.gsc::within_distance2d(level.player.origin, self.origin, 300) || !scripts\engine\math::is_point_in_front(level.player.origin))
    var_0 scripts\common\anim::anim_single_solo(self, "patrol_approach_exit");
  else
    self stopanimScripted();

  scripts\asm\shared\utility::toggle_poiauto(1);
  thread scripts\sp\maps\proxywar\proxywar_util.gsc::set_ally_movement_pre_breach(1);
  scripts\sp\maps\proxywar\proxywar_util.gsc::go_to_targetname("patrol_exit_" + self.script_noteworthy);
  self.arrived_at_patrol_exit = 1;
}

forest_exit_catchup() {
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_infil_3", "targetname").origin);
  var_0 = getEnt("opaque_glass_panel", "targetname");
  var_0 delete();
}

setup_laser_pointer_fsm() {
  var_0 = [["off", ::laser_off_enter, ::laser_off_update], ["idle", ::laser_idle_enter, ::laser_idle_update], ["track", ::laser_track_enter, ::laser_track_update], ["move_to", ::laser_move_to_enter, ::laser_move_to_update], ["complete", ::laser_complete_enter]];
  self setmoverlaserweapon("iw8_green_beam_bright");
  self.aimtarget = scripts\engine\utility::spawn_script_origin();
  self.aimtarget.origin = getEnt("front_gate_guard_left", "script_noteworthy").origin;
  self.pulsesinx = 0;
  self.pulsesinxrate = 5;
  self.wobblemagnitude = 10;
  self.fovtest = cos(8);
  self.fronttest = scripts\engine\utility::getStruct("overlook_ridge_target", "targetname");
  self.wobbleoffset = 0;
  self.newtarget = undefined;
  self.tracktotime = 3;
  self.tracktoaccel = 1;
  self.tracktodecel = 1;
  self.targetoffset = (0, 0, 32);
  self.trackduration = 10;
  self.endactionflag = undefined;
  self.minidletime = 3;
  self.startmonitoring = 0;
  scripts\sp\statemachine::begin_fsm(var_0, "off");
}

laser_off_enter() {
  scripts\sp\statemachine::set_notify_handlers([["track", ::laser_track_handler], ["move_to", ::laser_move_to_handler], ["complete", ::laser_complete_handler]]);

  if(scripts\engine\utility::flag("spotter_laser_on")) {
    scripts\engine\utility::flag_clear("spotter_laser_on");
    self laserforceoff();
  }

  self.pulsesinx = 0;

  if(!isDefined(level.idlespottertime))
    level.idlespottertime = 0;

  scripts\engine\utility::flag_wait("near_ridge_edge");
  self.startmonitoring = 1;
}

laser_off_update() {
  if(self.startmonitoring && level.player scripts\engine\math::is_point_in_front(scripts\engine\utility::getStruct("overlook_ridge_target", "targetname").origin)) {
    if(level.idlespottertime > 6 && !scripts\engine\utility::flag("spotter_actively_tracking") && !scripts\engine\utility::flag("done_facility_scan")) {
      var_0 = [];

      if(!scripts\engine\utility::flag("truck_moving") && !scripts\engine\utility::flag("done_checkpoint_spot"))
        var_0[var_0.size] = "overlook_truck";

      if(scripts\engine\utility::flag("truck_moving") && !scripts\engine\utility::flag("done_checkpoint_spot")) {
        var_0[var_0.size] = "front_gate_guard_left";
        var_0[var_0.size] = "front_gate_guard_right";
      }

      if(!scripts\engine\utility::flag("done_railyard_spot")) {
        var_0[var_0.size] = "overlook_railyard_enemy1";
        var_0[var_0.size] = "overlook_railyard_enemy2";
        var_0[var_0.size] = "overlook_railyard_enemy3";
      }

      if(var_0.size > 0) {
        scripts\engine\utility::flag_set("spotter_actively_tracking");
        var_1 = [];

        foreach(var_3 in var_0)
        var_1[var_1.size] = getEnt(var_3, "script_noteworthy");

        var_5 = level.player getEye() + anglesToForward(level.player getplayerangles()) * 4000;
        var_6 = scripts\engine\trace::ray_trace(level.player getEye(), var_5, level.player);
        var_7 = scripts\engine\utility::getclosest(var_6["position"], var_1);

        switch (var_7.script_noteworthy) {
          case "overlook_railyard_enemy3":
          case "overlook_railyard_enemy2":
          case "overlook_railyard_enemy1":
            level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_callout_railway();
            self.endactionflag = "done_railyard_spot";
            self.newtarget = scripts\engine\utility::getStruct("laser_aim_railyard", "targetname");
            scripts\sp\statemachine::goto_state("move_to");
            break;
          case "overlook_truck":
            level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_callout_truck();
            self.newtarget = level.overlooktruck;
            self.targetoffset = (0, 0, 64);
            self.endactionflag = "done_checkpoint_spot";
            self.trackduration = 5;
            scripts\sp\statemachine::goto_state("track");
            break;
          case "front_gate_guard_right":
          case "front_gate_guard_left":
            level thread scripts\sp\maps\proxywar\proxywar_vo.gsc::vo_fo_callout_checkpoint();
            self.endactionflag = "done_checkpoint_spot";
            self.newtarget = scripts\engine\utility::getStruct("laser_aim_checkpoint", "targetname");
            scripts\sp\statemachine::goto_state("move_to");
            break;
        }
      }
    }
  }
}

laser_idle_enter() {
  scripts\sp\statemachine::set_notify_handlers([["track", ::laser_track_handler], ["move_to", ::laser_move_to_handler], ["complete", ::laser_complete_handler]]);
  self.idlestarttime = gettime();
}

laser_idle_update() {
  check_show_laser();

  if(scripts\engine\utility::flag(self.endactionflag) && (gettime() - self.idlestarttime) / 1000 > self.minidletime)
    scripts\sp\statemachine::goto_state("off");

  self.pulsesin = sin(self.pulsesinx);
  self.pulsesinx = scripts\engine\math::wrap(0, 360, self.pulsesinx + self.pulsesinxrate);
  self.wobbleoffset = (self.pulsesin * self.wobblemagnitude, self.pulsesin * self.wobblemagnitude, self.pulsesin * self.wobblemagnitude);
  self.angles = vectortoangles(self.aimtarget.origin + self.wobbleoffset - self.origin);
}

laser_track_handler(var_0) {
  self.newtarget = var_0[0];
  scripts\sp\statemachine::goto_state("track");
}

laser_move_to_handler(var_0) {
  self.newtarget = var_0[0];
  scripts\sp\statemachine::goto_state("move_to");
}

laser_complete_handler() {
  scripts\sp\statemachine::goto_state("complete");
}

laser_track_enter() {
  self endon("changed_state");
  var_0 = gettime();
  var_1 = level.player getEye() + anglesToForward(level.player getplayerangles()) * 4000;
  var_2 = scripts\engine\trace::ray_trace(level.player getEye(), var_1, level.player);
  var_3 = distance(self.aimtarget.origin, var_2["position"]);
  var_4 = scripts\engine\math::normalize_value(0, 500, var_3);
  var_5 = scripts\engine\math::factor_value(0.5, 1, var_4);
  self.aimtarget moveTo(var_2["position"], var_5, var_5 / 3, var_5 / 3);
  wait(var_5);

  while(isDefined(self.newtarget) && (gettime() - var_0) / 1000 < self.trackduration) {
    var_6 = 37.5;
    var_7 = self.newtarget.origin + self.targetoffset - self.aimtarget.origin;

    if(length(var_7) <= var_6)
      var_8 = var_7 / 2;
    else
      var_8 = vectorNormalize(var_7) * var_6;

    self.aimtarget moveTo(self.aimtarget.origin + var_8, 0.05, 0, 0);
    wait 0.05;
  }

  scripts\sp\statemachine::goto_state("off");
}

laser_track_update() {
  check_show_laser();
  self.pulsesin = sin(self.pulsesinx);
  self.pulsesinx = scripts\engine\math::wrap(0, 360, self.pulsesinx + self.pulsesinxrate);
  self.wobbleoffset = (self.pulsesin * self.wobblemagnitude, self.pulsesin * self.wobblemagnitude, self.pulsesin * self.wobblemagnitude);
  self.angles = vectortoangles(self.aimtarget.origin + self.wobbleoffset - self.origin);
}

laser_move_to_enter() {
  self endon("changed_state");
  scripts\sp\statemachine::set_notify_handlers([["move_to", ::laser_move_to_handler], ["complete", ::laser_complete_handler]]);
  var_0 = level.player getEye() + anglesToForward(level.player getplayerangles()) * 4000;
  var_1 = scripts\engine\trace::ray_trace(level.player getEye(), var_0, level.player);
  var_2 = distance(self.aimtarget.origin, var_1["position"]);
  var_3 = scripts\engine\math::normalize_value(0, 2000, var_2);
  var_4 = scripts\engine\math::factor_value(0.75, 1, var_3);
  self.aimtarget moveTo(var_1["position"], var_4, var_4 / 3, var_4 / 3);
  wait(var_4);
  self.aimtarget moveTo(self.newtarget.origin, self.tracktotime, self.tracktoaccel, self.tracktodecel);
  wait(self.tracktotime);
  scripts\sp\statemachine::goto_state("idle");
}

laser_move_to_update() {
  check_show_laser();
  self.pulsesin = sin(self.pulsesinx);
  self.pulsesinx = scripts\engine\math::wrap(0, 360, self.pulsesinx + self.pulsesinxrate);
  self.wobbleoffset = (self.pulsesin * self.wobblemagnitude, self.pulsesin * self.wobblemagnitude, self.pulsesin * self.wobblemagnitude);
  self.angles = vectortoangles(self.aimtarget.origin + self.wobbleoffset - self.origin);
}

laser_complete_enter() {
  if(scripts\engine\utility::flag("spotter_laser_on")) {
    scripts\engine\utility::flag_clear("spotter_laser_on");
    self laserforceoff();
  }
}

check_show_laser() {
  if(scripts\engine\utility::flag("equipped_spotter_scope") && level.player playerads() == 1) {
    if(!level.player scripts\engine\math::is_point_in_front(self.fronttest.origin) || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, self.fovtest)) {
      if(scripts\engine\utility::flag("spotter_laser_on")) {
        scripts\engine\utility::flag_clear("spotter_laser_on");
        self laserforceoff();
      }
    } else if(!scripts\engine\utility::flag("spotter_laser_on")) {
      scripts\engine\utility::flag_set("spotter_laser_on");
      self laserforceon();
    }
  } else if(scripts\engine\utility::flag("spotter_laser_on")) {
    scripts\engine\utility::flag_clear("spotter_laser_on");
    self laserforceoff();
  }
}