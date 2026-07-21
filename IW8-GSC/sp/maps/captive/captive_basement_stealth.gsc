/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_basement_stealth.gsc
********************************************************/

basement_stealth_flags() {
  scripts\engine\utility::flag_init("escaped_cell_block");
  scripts\engine\utility::flag_init("near_grate");
  scripts\engine\utility::flag_init("opened_grate");
  scripts\engine\utility::flag_init("killed_guard_2");
  scripts\engine\utility::flag_init("vo_alert_done");
  scripts\engine\utility::flag_init("reached_wait_point");
  scripts\engine\utility::flag_init("basement_alert_raised");
  scripts\engine\utility::flag_init("spotted_player");
  scripts\engine\utility::flag_init("got_gun");
  scripts\engine\utility::flag_init("in_guard_1_defend_zone");
  scripts\engine\utility::flag_init("check_accelerate_cell_search");
  scripts\engine\utility::flag_init("cell_search_complete");
  scripts\engine\utility::flag_init("player_reached_exit_door");
  scripts\engine\utility::flag_init("reached_upstairs");
  scripts\engine\utility::flag_init("in_drain");
  scripts\engine\utility::flag_init("drain_rat_1");
}

basement_stealth_start() {
  level.player setstance("crouch");
  scripts\engine\sp\utility::set_start_location("player_spawn_basement_stealth", [level.player]);
  scripts\sp\player\teenagefarah::teenage_farah_stealth_setup();
  scripts\sp\maps\captive\captive_util.gsc::setup_noisemaker_pickups();
  scripts\engine\utility::flag_set("used_vent");
  thread scripts\sp\maps\captive\captive_vo.gsc::vo_walla_guards_alert();
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("hadir_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("main_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("break_final");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("pre_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("post_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("fallen_grate");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("upstairs");
}

basement_stealth_main() {
  level thread scripts\sp\maps\captive\captive_util.gsc::notetrack_listener_open_cellblock_door();
  level thread scripts\sp\maps\captive\captive_util.gsc::notetrack_listener_close_cellblock_door();
  scripts\sp\utility::context_melee_set_silent_kill(0);
  scripts\sp\utility::context_melee_set_weapon("weapon_wm_me_spoonshank");
  var_0 = getEnt("grate", "targetname");
  var_0 thread check_use_grate_cover();
  level thread check_rat_run(var_0);
  level thread vent_crawl_presentation();
  level.player scripts\sp\player::set_player_max_health(30);
  level.player scripts\sp\player::scale_player_death_shield_duration(0.1);
  level thread basement_stealth_eventdists();
  level thread basement_stealth_melee_counter_monitor();
  scripts\sp\maps\captive\captive_util.gsc::enable_context_melee();
  setaudiotriggerstate("cap_battle", "", 3.0);
  scripts\engine\utility::flag_wait("escaped_cell_block");
  level.player thread check_got_gun();
  level.basementguards = scripts\engine\sp\utility::array_spawn_targetname("basement_guards");
  level thread check_in_drain();
  level thread check_sprinting();
  level thread check_rush_past_guards();
  level notify("end_window_view");

  if(isDefined(level.windowguys)) {
    foreach(var_2 in level.windowguys) {
      if(isDefined(var_2))
        var_2 delete();
    }
  }

  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_bs_guards_enter();
  level.guard1 thread guard_1_patrol_unaware();
  level.guard1 thread check_swipe_melee_dmg();
  level.guard2 thread check_swipe_melee_dmg();
  level.guard2 thread guard_2_patrol_unaware();
  level.guard2 scripts\engine\utility::thread_on_notify("start_context_melee", scripts\engine\utility::delaythread, 1, scripts\common\ai::gun_remove);
  level.guard2.aggressivelowcovermode = 1;
  level.stealth.bstayincombatoncealerted = 1;
  scripts\engine\utility::flag_wait("opened_grate");
  setomnvar("ui_hud_hidden_by_timer", 1);
  setomnvar("ui_hide_hud", 0);
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("obj_reach_stairs_1", "targetname").origin, &"CAPTIVE/OBJ_REACH_STAIRS_DESC", &"CAPTIVE/OBJ_REACH_STAIRS");
  scripts\engine\utility::flag_wait("reached_upstairs");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_reach_stairs_2", "targetname").origin);

  if(isalive(level.guard1)) {
    level.special_autosavecondition = ::dontsave;
    level.player scripts\engine\sp\utility::add_damage_function(::kill_on_damage);
    thread basement_stealth_stairwell_cleanup();

    if(!level.guard1[[level.guard1.fnisinstealthcombat]]())
      level.guard1[[level.guard1.fnsetstealthstate]]("combat");

    level.guard1 cleargoalvolume();
  } else {
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_bs_climbing_stairs();
    level thread scripts\sp\maps\captive\captive_vo.gsc::mus_far_sister_infil();
  }

  level notify("kill_listeners");
  level.player notify("kill_checks");

  if(isDefined(level.guard1))
    level.guard1 notify("kill_checks");

  thread scripts\sp\analytics::analytics_kleenex_update("Exit grate to top of stairs");

  if(scripts\engine\utility::flag("got_gun"))
    level thread scripts\engine\sp\utility::autosave_by_name("free_prisoners");
}

vent_crawl_presentation() {
  level.player endon("death");
  level endon("reached_upstairs");
  var_0 = level.player scripts\engine\sp\utility::get_rumble_ent("steady_rumble");
  var_0 thread scripts\engine\sp\utility::rumble_ramp_to(0, 0.05);
  var_1 = 0.6;
  var_2 = 0.3;
  var_3 = 1.6;
  var_4 = 0.45;
  thread audio_player_spawn_mud_loop();

  for(;;) {
    if(scripts\engine\utility::flag("in_drain") && level.player getstance() == "prone") {
      var_0.intensity = 0;
      var_5 = abs(level.player getnormalizedmovement()[0]);

      if(var_5 < 0.13) {
        waitframe();
        continue;
      }

      var_6 = scripts\engine\math::factor_value(var_2, var_1, var_5);
      var_7 = scripts\engine\math::factor_value(var_3, var_4, var_5);
      var_0 thread do_vent_rumble(var_6, var_7);
      var_8 = gettime() + var_7 * 1000;
      thread audio_player_start_mud_loop();

      while(gettime() < var_8) {
        if(!abs(level.player getnormalizedmovement()[0])) {
          level notify("interupt_rumble");
          var_0.intensity = 0;
          thread audio_player_stop_mud_loop();
          break;
        }

        waitframe();
      }

      wait 0.1;
    }

    thread audio_player_stop_mud_loop();
    waitframe();
  }

  thread audio_player_delete_mud_loop();
}

audio_player_spawn_mud_loop() {
  level.mud_sfx = spawn("script_origin", level.player.origin);
  level.mud_sfx linkTo(level.player);
  level.mud_sfx scalevolume(0, 0);
  wait 0.05;
  level.mud_sfx playLoopSound("slide_loop_mud_plr");
}

audio_player_start_mud_loop() {
  if(isDefined(level.mud_sfx))
    level.mud_sfx scalevolume(1.0, 0.5);
}

audio_player_stop_mud_loop() {
  if(isDefined(level.mud_sfx))
    level.mud_sfx scalevolume(0.0, 0.75);
}

audio_player_delete_mud_loop() {
  if(isDefined(level.mud_sfx))
    level.mud_sfx delete();
}

do_vent_rumble(var_0, var_1) {
  level endon("interupt_rumble");
  scripts\engine\sp\utility::rumble_ramp_to(var_0, var_1 * 0.5);
  scripts\engine\sp\utility::rumble_ramp_to(0, var_1 * 0.5);
}

check_swipe_melee_dmg() {
  self endon("death");
  self endon("start_context_melee");

  for(;;) {
    self waittill("damage", var_0, var_1, var_0, var_0, var_2, var_0, var_0, var_0, var_0, var_0);

    if(scripts\engine\utility::is_equal(var_1, level.player) && scripts\engine\utility::is_equal(var_2, "MOD_MELEE")) {
      wait 1;
      scripts\engine\utility::disable_pain();
      wait 10;
      scripts\engine\utility::enable_pain();
    }
  }
}

basement_stealth_catchup() {
  if(scripts\sp\starts::is_after_start("bunker")) {
    return;
  }
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("obj_reach_stairs_1", "targetname").origin, &"CAPTIVE/OBJ_REACH_STAIRS_DESC", &"CAPTIVE/OBJ_REACH_STAIRS");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("obj_reach_stairs_2", "targetname").origin);
  setaudiotriggerstate("cap_battle", "", 3.0);
}

check_rat_run(var_0) {
  scripts\engine\utility::flag_wait("in_drain");
  scripts\engine\utility::exploder("sewer_rat_static");
  scripts\engine\utility::exploder("sewer_rat_static_1");
  scripts\engine\utility::exploder("sewer_rat_static_2");

  while(level.player getstance() != "prone")
    waitframe();

  level.scr_model["player_rig"] = "viewhands_farah_55inch_prisoner_dirt";
  scripts\sp\player\teenagefarah::set_player_viewmodel("viewhands_farah_55inch_prisoner_dirt", undefined, "default_character_shadow");
  scripts\engine\utility::exploder("sewer_rat");
  scripts\engine\utility::kill_exploder("sewer_rat_static");
  scripts\engine\utility::flag_wait_or_timeout("drain_rat_1", 1);
  scripts\engine\utility::exploder("sewer_rat_1");
  scripts\engine\utility::kill_exploder("sewer_rat_static_1");
  wait 0.75;
  scripts\engine\utility::exploder("sewer_rat_2");
  scripts\engine\utility::kill_exploder("sewer_rat_static_2");
}

check_use_grate_cover() {
  self.animname = "grate";
  scripts\engine\sp\utility::assign_animtree();
  var_0 = undefined;
  var_1 = scripts\engine\utility::get_linked_structs();

  foreach(var_3 in var_1) {
    if(var_3.script_parameters == "grate_interact")
      var_0 = var_3;
  }

  var_0 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_OPEN", 180, 80, 64);
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("opened_grate");
  var_5 = scripts\engine\utility::get_linked_ents();

  foreach(var_7 in var_5) {
    if(var_7.script_parameters == "collision")
      var_7 delete();
  }

  thread scripts\sp\player_rig::link_player_to_rig("grate_open", "prone", 1, 0.5, 20, 20, 20, 20, 1);
  level thread scripts\engine\sp\utility::autosave_by_name("basement_stealth_grate_open");
  level.player_rig attach("weapon_wm_me_spoonshank", "tag_accessory_right");
  level.player playSound("cap_vm_grate_bottom_plr_lr");
  scripts\common\anim::anim_single([level.player_rig, self], "grate_open");
  level.player_rig detach("weapon_wm_me_spoonshank", "tag_accessory_right");
  scripts\sp\player_rig::unlink_player_from_rig(0, "crouch", 1);
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
}

guard_1_patrol_unaware() {
  self endon("death");
  self.ignoreall = 1;
  scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("basement_guard_1_meeting_point", "targetname"));
  wait 2;
  level notify("start_patrol");
  thread search_cells();
  scripts\engine\utility::flag_wait("cell_search_complete");
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_bs_guards_sounds_alert();
  self.ignoreall = 0;
  self.target = "wait_at_stairbase";
  scripts\sp\spawner::go_to_node();
  scripts\engine\utility::flag_set("reached_wait_point");
  self.combat_volume = getEnt("stairwell_base_volume", "targetname");
  scripts\engine\utility::flag_wait("killed_guard_2");
  self cleargoalvolume();
  self.stealth.funcs["event_investigate"] = ::basement_guard_stealth_filter;
  self.stealth.funcs["event_cover_blown"] = ::basement_guard_stealth_filter;
  self.stealth.funcs["event_combat"] = ::basement_guard_combat_stealth_filter;
  self.ignoreall = 0;
  self.target = "stairwell_guard_cover_node";
  thread scripts\sp\spawner::go_to_node();
  scripts\stealth\enemy::trigger_cover_blown();
  self.combat_volume = getEnt("stairwell_guard_cover_volume", "targetname");
  wait 1;
  thread scripts\sp\maps\captive\captive_vo.gsc::vo_bs_callout_to_guard_2();
}

search_cells() {
  level endon("check_accelerate_cell_search");
  thread check_interrupt_search();
  level.breakanimref = scripts\engine\utility::getStruct("cell_center", "targetname");
  level.breakanimref scripts\sp\anim::anim_reach_solo(self, "investigate_check_cell");
  level.breakanimref scripts\common\anim::anim_single_solo(self, "investigate_check_cell");
  scripts\engine\utility::flag_set("cell_search_complete");
}

#using_animtree("generic_human");

check_interrupt_search() {
  level endon("cell_search_complete");
  scripts\engine\utility::flag_wait("check_accelerate_cell_search");
  self aisetanimtime(%cap_cb_020_cellcheck_enter_enemy01, 0.99);
  scripts\engine\utility::flag_set("cell_search_complete");
}

guard_2_patrol_unaware() {
  level endon("spotted_player");
  thread scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("basement_guard_2_meeting_point", "targetname"));
  level waittill("start_patrol");

  if(!scripts\engine\utility::flag("opened_grate")) {
    self notify("stop_going_to_node");
    thread scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("basement_guard_2_patrol_1_1", "targetname"));
  }

  scripts\engine\utility::flag_wait("opened_grate");
  self notify("stop_going_to_node");
  scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct("basement_guard_2_patrol_2_1", "targetname"));
  scripts\engine\utility::flag_wait("vo_alert_done");
  scripts\engine\utility::flag_set("basement_alert_raised");
  self[[self.fnsetstealthstate]]("hunt", undefined);
}

basement_stealth_eventdists() {
  scripts\engine\utility::flag_wait("stealth_enabled");
  var_0 = level.stealth.ai_event;
  var_1["ai_eventDistFootstepSprint"]["spotted"] = 200;
  var_1["ai_eventDistFootstepSprint"]["hidden"] = 200;
  scripts\stealth\manager::set_custom_distances(var_1);
  var_2 = [level.advancetoenemyinterval, level.advancetoenemygroupmax];
  scripts\engine\sp\utility::set_group_advance_to_enemy_parameters(500, 1);
  scripts\engine\utility::flag_wait("reached_upstairs");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("upstairs");
  scripts\stealth\manager::set_custom_distances(var_0);
  scripts\engine\sp\utility::set_group_advance_to_enemy_parameters(var_2[0], var_2[1]);
}

basement_stealth_melee_counter_monitor() {
  var_0 = level scripts\engine\utility::waittill_any_return("got_gun", "melee_fail");

  if(var_0 == "melee_fail") {
    var_1 = 1.5;
    thread counter_black_fade(var_1);
    level.player enabledeathshield(0);
    level.player disableinvulnerability();
    wait(var_1);
    level.player scripts\sp\utility::do_damage(2000, level.player.origin, level.player, undefined, "MOD_PISTOL_BULLET");
    return;
  }
}

counter_black_fade(var_0) {
  level.counterblackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  waitframe();
  level.counterblackoverlay fadeovertime(var_0);
  level.counterblackoverlay.alpha = 1.0;
}

kill_on_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self kill(var_3, var_1, var_6, var_4);
}

dontsave() {
  return 0;
}

basement_stealth_stairwell_cleanup() {
  level.player endon("death");
  level.guard1 waittill("death");
  level.player scripts\engine\sp\utility::remove_damage_function(::kill_on_damage);
  level.special_autosavecondition = undefined;
}

basement_guard_spawn_func() {
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\sp\nvg\nvg_ai::flashlight_on();

  switch (self.script_noteworthy) {
    case "basement_guard_1":
      level.guard1 = self;
      self.stealth.funcs["event_investigate"] = ::basement_guard_pre_stealth_filter;
      self.stealth.funcs["event_cover_blown"] = ::basement_guard_pre_stealth_filter;
      self.stealth.funcs["event_combat"] = ::basement_guard_pre_combat_stealth_filter;
      self.pushable = 0;
      self.meleechargedistvsplayer = 60;
      scripts\sp\utility::context_melee_allow(0);
      scripts\stealth\utility::set_stealth_func("should_hunt", ::stairwell_guard_should_hunt);
      break;
    case "basement_guard_2":
      level.guard2 = self;
      self.stealth.funcs["event_investigate"] = ::basement_guard_stealth_filter;
      self.stealth.funcs["event_cover_blown"] = ::basement_guard_stealth_filter;
      self.stealth.funcs["event_combat"] = ::basement_guard_combat_stealth_filter;
      self.combatmode = "no_cover";
      self.script_combatmode = "no_cover";
      self.stealth.funcs["has_lost_enemy"] = ::basement_guard_has_lost_enemy;
      level.radio = spawn("script_origin", level.guard2 gettagorigin("tag_stowed_hip_rear"));
      level.radio linkTo(self, "tag_stowed_hip_rear");
      break;
  }

  if(!isDefined(level.basement_guards))
    level.basement_guards = [];

  level.basement_guards[level.basement_guards.size] = self;
  self.aggressivemode = 1;
  self.disablegrenaderesponse = 1;
  self.limitstealthturning = 1;
  self.baseaccuracy = 3;
  self.deathfunction = ::basement_guard_death_func;
  thread scripts\sp\maps\captive\captive_vo.gsc::vo_bs_stab_guard();
  scripts\sp\utility::context_melee_override_anim("melee_stealth_kill_front", "front");
  scripts\sp\utility::context_melee_override_anim("melee_stealth_kill_left", "left");
  scripts\sp\utility::context_melee_override_anim("melee_stealth_kill_right", "right");
  scripts\sp\utility::context_melee_override_anim("melee_stealth_kill_back", "back");
  self.proximity_bump_dist_sqr_override = 80;
  scripts\sp\maps\captive\captive_util.gsc::pistol_weapon_user();
}

basement_guard_death_func() {
  if(self.script_noteworthy == "basement_guard_2") {
    scripts\engine\utility::flag_set("killed_guard_2");
    scripts\sp\utility::nvidiaansel_scriptdisable(0);
    var_0 = 1;

    foreach(var_2 in level.player.primaryweapons) {
      if(issubstr(var_2.basename, "_pi_"))
        var_0 = 0;
    }

    if(var_0) {
      var_4 = scripts\sp\utility::make_weapon("iw8_pi_golf21_tfarah");
      level.player scripts\sp\utility::give_weapon(var_4);
      level.player switchtoweapon(var_4);
    }

    level.player scripts\sp\utility::take_weapon("iw8_farahspoon_sp");
    wait 0.5;
  } else if(!scripts\engine\utility::flag("started_bs_radio_conversation"))
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_bs_radio_convo();

  level.basement_guards = scripts\engine\utility::array_remove(level.basement_guards, self);

  if(!level.basement_guards.size) {
    level.basement_guards = undefined;
    return 0;
  }

  if(self.combatmode == "cover")
    return 0;

  foreach(var_6 in level.basement_guards) {
    if(scripts\engine\utility::is_equal(var_6, level.guard3)) {
      var_6.target = "stairwell_guard_cover_node";
      var_6.combat_volume = getEnt("stairwell_guard_cover_volume", "targetname");

      if(var_6[[var_6.fnisinstealthcombat]]())
        var_6 setgoalvolumeauto(var_6.combat_volume);
    }
  }

  return 0;
}

stairwell_guard_should_hunt() {
  return 0;
}

check_got_gun() {
  self endon("kill_gun_check");

  while(!scripts\engine\utility::flag("got_gun")) {
    self waittill("weapon_change", var_0);

    if(var_0.basename != "none" && var_0.basename != "iw8_farahspoon_sp") {
      thread scripts\engine\sp\utility::autosave_by_name("basement_stealth_got_gun");
      scripts\engine\utility::flag_set("got_gun");
    }
  }
}

basement_guard_stealth_filter(var_0) {
  var_1 = ["grenade danger"];

  if(scripts\engine\utility::array_contains(var_1, var_0.typeorig))
    return 1;

  scripts\sp\nvg\nvg_ai::flashlight_on();

  if(var_0.type == "combat") {
    if(scripts\engine\utility::is_equal(self, level.guard1))
      thread stairwell_guard_combat_think();
    else
      thread basement_guard_combat_think();
  }

  return 0;
}

basement_guard_pre_stealth_filter(var_0) {
  var_1 = ["grenade danger"];

  if(scripts\engine\utility::array_contains(var_1, var_0.typeorig))
    return 1;

  scripts\sp\nvg\nvg_ai::flashlight_on();
  return 0;
}

basement_guard_combat_stealth_filter(var_0) {
  scripts\common\utility::enable_cqbwalk(1);
  self.combatmode = "cover";
  scripts\engine\utility::flag_set("spotted_player");
  return basement_guard_stealth_filter(var_0);
}

basement_guard_pre_combat_stealth_filter(var_0) {
  scripts\common\utility::enable_cqbwalk(1);
  self setgoalvolumeauto(self.combat_volume);
  scripts\engine\utility::flag_set("spotted_player");
  return basement_guard_stealth_filter(var_0);
}

basement_guard_has_lost_enemy() {
  var_0 = 10000;
  var_1 = 10000;
  var_2 = 8000;
  var_3 = gettime();
  var_4 = self.enemy;

  if(isDefined(var_4) && issentient(var_4) && isalive(var_4)) {
    if(var_4.team != "allies")
      return 0;

    var_5 = self lastknowntime(var_4);

    if(var_3 < var_5 + var_0)
      return 0;

    var_6 = self lastknownpos(var_4);

    if(var_5 > 0 && distancesquared(var_4.origin, var_6) < var_1 && self cansee(var_4) && self canshootenemy())
      return 0;

    if(isDefined(self.benemyinlowcover))
      return 0;
  }

  return 1;
}

basement_guard_combat_think() {
  scripts\sp\nvg\nvg_ai::flashlight_off();
}

stairwell_guard_combat_think() {
  if(isDefined(self.combat_volume))
    self setgoalvolumeauto(self.combat_volume);
}

check_in_drain() {
  level endon("reached_upstairs");

  for(;;) {
    scripts\engine\utility::flag_wait("in_drain");

    foreach(var_1 in level.basementguards) {
      if(isalive(var_1))
        var_1 enableavoidance(0);
    }

    scripts\engine\utility::flag_waitopen("in_drain");

    foreach(var_1 in level.basementguards) {
      if(isalive(var_1))
        var_1 enableavoidance(1);
    }
  }
}

check_sprinting() {
  level endon("reached_upstairs");

  for(;;) {
    if(level.player issprinting()) {
      if(isalive(level.guard1) && level.guard1.stealth.bsmstate < 3) {
        if(level.player istouching(getEnt("check_near_guard_1", "targetname")))
          level.guard1 aieventlistenerevent("cover_blown", level.player, level.player.origin);
      }

      if(isalive(level.guard2) && level.guard2.stealth.bsmstate < 3)
        level.guard2 aieventlistenerevent("cover_blown", level.player, level.player.origin);
    }

    waitframe();
  }
}

check_rush_past_guards() {
  scripts\engine\utility::flag_wait("in_guard_1_defend_zone");

  if(!scripts\engine\utility::flag("killed_guard_2") && isalive(level.guard1) && ispointinvolume(level.guard1.origin, getEnt("stairwell_base_volume", "targetname"))) {
    scripts\engine\utility::flag_wait("reached_wait_point");
    var_0 = scripts\engine\utility::getStruct("stairwell_guard_melee_kill_ref", "targetname");
    var_0 scripts\sp\player_rig::link_player_to_rig("melee_fail_front", "stand", 1, 0.3);
    var_0 thread scripts\common\anim::anim_single([level.guard1, level.player_rig], "melee_fail_front");
    level waittill("first_shot");
    level.player scripts\sp\utility::do_damage(level.player.health / 2, level.guard1.origin);
    level waittill("kill_player");
    level.player kill();
  } else {
    var_1 = scripts\sp\door::get_interactive_door("basement_door");
    var_1 scripts\engine\utility::waittill_any("first_interact", "bashed");
    var_2 = undefined;

    if(isalive(level.guard1))
      var_2 = level.guard1;

    if(!isDefined(var_2) && isalive(level.guard2))
      var_2 = level.guard2;

    if(isDefined(var_2)) {
      magicbullet("iw8_pi_golf21", level.player getEye() + (0, 0, 30), level.player.origin);
      wait 0.1;
      magicbullet("iw8_pi_golf21", level.player getEye() + (0, 0, 30), level.player.origin);

      if(isalive(level.player))
        level.player scripts\sp\utility::do_damage(level.player.health + 100, level.player getEye(), var_2);

      waitframe();

      if(isalive(level.player))
        level.player kill();

      return;
    }
  }
}