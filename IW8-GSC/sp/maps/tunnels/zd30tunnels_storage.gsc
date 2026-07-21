/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\zd30tunnels_storage.gsc
***************************************************/

precache_storage() {}

storage_setup() {
  thread storage_runner_cleared_detector();
}

storage_runner_cleared_detector() {
  var_0 = getEnt("storage_runner_passed", "targetname");
  var_1 = 4;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isDefined(var_2) && isalive(var_2) && istrue(var_2.storage_runner) && !istrue(var_2.cleared_storage)) {
      var_1++;
      var_2.cleared_storage = 1;
    }
  }
}

storage_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::set_start_location("storage", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::farah_teleport_and_reset("storage_farah");
}

storage_catchup() {
  setomnvar("ai_fulllight", 0.0000001);
  scripts\engine\utility::flag_set("storage_reached");
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
  thread storage_3rd_room_propane_tripwire();
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_storage);
}

storage() {
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_storage);
  thread storage_enemy_hold_fire();
  thread storage_flank_weapon_watch();
  thread storage_surprise();
  thread storage_lmg_room_propane_detonation_think();
  thread storage_ambush_kickoff();
  thread storage_3rd_room_propane_tripwire();
  thread storage_tripwire_chain_defuse();
  scripts\engine\utility::flag_wait("storage_reached");
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
  level.farah scripts\common\utility::demeanor_override("combat");
  thread storage_room_2_lmg_buddy();
  scripts\engine\utility::flag_wait("storage_teapot_passed");
  thread scripts\sp\analytics::analytics_kleenex_update("Basement to Crates");
  thread scripts\engine\sp\utility::autosave_now();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::checkpoint_loop(25, "storage_final_room_reached");
  setomnvar("ai_fulllight", 0.0000001);
  thread storage_first_room_enemy_whisper();
  thread storage_farah_combat_behavior();
  scripts\engine\utility::flag_wait("storage_ambush");
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  wait 3;
}

storage_lmg_room_propane_detonation_think() {
  var_0 = getEnt("storage_lmg_propane_detonator", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      break;
    }
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::set_off_storage_propane_tanks();
}

storage_flank_weapon_watch() {
  var_0 = getEnt("storage_flank_weapon_watch", "targetname");
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("storage_player_flanking");

  for(;;) {
    level.player waittill("weapon_fired");

    if(level.player istouching(var_0)) {
      wait 0.5;
      scripts\engine\utility::flag_set("storage_flank_weapon_fired");
      var_1 = scripts\engine\utility::getStruct("storage_room_2_enemy_vo_struct", "targetname").origin;
      playworldsound("dx_vom_aq2_tunnels_search_145", var_1);
      return;
    }
  }
}

storage_ambush_kickoff() {
  var_0 = getEnt("storage_ambush_runner_trig", "targetname");
  var_1 = getEnt("storage_ambush_runner_trig2", "targetname");
  var_2 = getEnt(var_0.target, "targetname");
  var_0 waittill("trigger");

  if(isDefined(level.storage_ambush_runner) && isalive(level.storage_ambush_runner))
    level.storage_ambush_runner thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_playSound("dx_vom_aq1_tunnels_hunt_66");

  var_2 scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_player_lookat, 0.9, 0.25);
  var_1 scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "trigger");
  scripts\engine\sp\utility::do_wait_any();
  level.storage_ambush_runner notify("run_now");
}

storage_enemy_hold_fire() {
  var_0 = scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::get_alive_enemies();

  foreach(var_2 in var_0)
  var_2 scripts\engine\sp\utility::enable_dontevershoot();

  scripts\engine\utility::flag_wait("storage_ambush");
  var_0 = scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::get_alive_enemies();

  foreach(var_2 in var_0)
  var_2 scripts\engine\sp\utility::disable_dontevershoot();
}

storage_propane_toss_scene() {
  storage_propane_toss();
}

storage_propane_toss() {
  var_0 = getEnt("storage_lmg_propane_trig", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_ambush");
  scripts\engine\sp\utility::do_wait_any();
  var_3 = getscriptablearray("storage_toss_propane", "targetname")[0];
  var_4 = spawn("script_model", var_1.origin);
  var_4.angles = var_1.angles;
  var_5 = 7500;
  var_6 = vectorNormalize(anglesToForward(var_4.angles)) * var_5;
  var_4 setModel("decor_propane_tank_01_en_d1");
  waitframe();
  var_7 = var_4.origin + 10 * anglestoup(var_4.angles) - 10 * anglesToForward(var_4.angles);
  var_4 physicslaunchserver(var_7, var_6);
  wait 1.25;
  var_3 setscriptablepartstate("base", "fire");
  var_3.origin = var_4.origin;
  var_3.angles = var_4.angles;
  var_4 delete();
  level notify("storage_propane_tossed");
}

storage_surprise() {
  thread storage_surprise_vo();
  thread storage_surprise_propane_exploder();
  var_0 = getEnt("storage_surprise_trig", "targetname");
  var_1 = scripts\engine\sp\utility::spawn_targetname("storage_surprise_spawner", 1);
  var_1.allowdeath = 1;
  var_1.health = 50;
  var_1.forcelongdeath = 4;
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1.animname = "storage_surprise_guy";
  var_2 = 1.25;
  thread skip_ambush_if_ambusher_died(var_1);
  var_1 scripts\common\ai::disable_exits();
  var_1 scripts\common\ai::disable_turnanims();
  scripts\engine\sp\utility::set_grenadeammo(0);
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::battlechatter_off_spawn_func();
  level.storage_surprise_guy = var_1;
  var_3 = "storage_surprise";
  var_4 = scripts\engine\utility::getStruct(var_3, "targetname");
  var_4 scripts\common\anim::anim_first_frame_solo(var_1, var_3);
  var_1 storage_surprise_wait(var_0);
  var_4 thread scripts\common\anim::anim_single_solo(var_1, var_3);
  waitframe();
  var_1 setanimrate(var_1 scripts\engine\utility::getanim(var_3), var_2);
  var_1 thread storage_surprise_shoot_on_notetrack(var_2);
  wait(1.6 / var_2);
  var_1 stopanimScripted();
  var_1 scripts\engine\sp\utility::set_maxfaceenemydist(8);
  var_5 = getnode("storage_room_2_goto_delete_node", "targetname");
  var_1 scripts\engine\sp\utility::set_goal_radius(32);
  var_1 scripts\engine\sp\utility::set_goal_pos(var_5.origin);
  var_1.ignoreall = 0;
  var_1.ignoreme = 0;
  var_1 childthread respond_if_player_chases("chased");
  var_1 scripts\engine\utility::waittill_any_timeout(2, "goal");
  var_1 thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, 300, "chased");
}

skip_ambush_if_ambusher_died(var_0) {
  level endon("storage_ambush");
  var_0 waittill("death");
  scripts\engine\utility::flag_set("storage_ambush");
}

respond_if_player_chases(var_0) {
  var_1 = 160;

  for(;;) {
    if(scripts\engine\utility::distance_2d_squared(level.player.origin, self.origin) < var_1 * var_1) {
      break;
    }

    wait 0.1;
  }

  self notify(var_0);
  waitframe();
  scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::zdt_rush_guy();
}

storage_surprise_vo() {
  level endon("spawned_storage_3rd_room");
  level waittill("storage_surprise_happened");

  if(isDefined(level.farah)) {
    wait 1.3;
    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_storage_hub_100", 1);
  }
}

storage_surprise_shoot_on_notetrack(var_0) {
  level notify("storage_surprise_started");
  var_1 = getscriptablearray("storage_1st_room_propane", "targetname");
  var_2 = 0.5;
  wait(var_2 / var_0);
  level notify("storage_surprise_happened");
  var_3 = (0, 0, 32);
  var_4 = 5;
  var_5 = 0;

  while(var_5 <= var_4) {
    if(isDefined(self) && isalive(self))
      self shoot();

    if(!isDefined(var_1[var_5])) {
      break;
    }

    if(!isDefined(var_1[var_5].model) || var_1[var_5].model == "") {
      var_5++;
      continue;
    }

    var_6 = "smoke";
    var_1[var_5] setscriptablepartstate("base", var_6);
    wait(randomfloatrange(0.15, 0.25));
    var_5++;
  }

  scripts\engine\utility::flag_set("storage_ambush");
  var_1 = getscriptablearray("storage_1st_room_propane_group2", "targetname");

  foreach(var_8 in var_1) {
    var_8 setscriptablepartstate("base", "smoke");
    wait(randomfloatrange(0.25, 0.5));
  }
}

waittill_propanes_exploded(var_0) {
  wait 3.5;
}

storage_surprise_propane_exploder() {
  wait 0.25;
  var_0 = getscriptablearray("storage_1st_room_propane", "targetname");
  var_1 = getscriptablearray("storage_1st_room_propane_group2", "targetname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  for(;;) {
    var_3 = 0;

    foreach(var_5 in var_2) {
      if(isDefined(var_5) && isDefined(var_5.model) && var_5.model == "") {
        var_3 = 1;
        var_5 thread do_additional_damage();
        break;
      }

      wait 0.05;
    }

    wait 0.05;

    if(istrue(var_3)) {
      break;
    }
  }

  thread scripts\engine\utility::exploder("propane_bois");
}

do_additional_damage() {
  self radiusdamage(self.origin + (0, 0, 4), 100, 150, 20);
}

storage_surprise_wait(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = getEnt(var_1.target, "targetname");
  var_0 waittill("trigger");
  var_3 = 0;
  var_4 = 5;
  var_5 = 0.05;

  for(;;) {
    if(level.player istouching(var_0)) {
      var_3 = var_3 + var_5;

      if(scripts\engine\sp\utility::player_looking_at(var_1.origin, 0.9)) {
        break;
      }

      if(var_3 >= var_4) {
        break;
      }
    }

    if(level.player istouching(var_2)) {
      break;
    }

    wait(var_5);
  }

  if(isDefined(level.storage_ambush_runner) && isalive(level.storage_ambush_runner)) {
    var_6 = 70;

    while(isDefined(self) && isalive(self) && scripts\engine\utility::distance_2d_squared(level.storage_ambush_runner.origin, self.origin) < var_6 * var_6)
      wait 0.05;
  }
}

storage_room_2_lmg_buddy() {
  scripts\engine\utility::flag_wait("storage_room_2_entered");
  var_0 = scripts\engine\utility::getStruct("storage_lmg_buddy_look_at", "targetname").origin;

  while(!scripts\engine\sp\utility::player_looking_at(var_0))
    wait 0.05;

  var_1 = getEnt("storage_lmg_buddy", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  var_1 notify("trigger");
}

storage_tripwire_chain_defuse() {
  wait 1;
  scripts\engine\utility::array_thread(getEntArray("storage_tripwire_detector", "targetname"), ::storage_tripwire_chain_defuse_think);
}

storage_tripwire_chain_defuse_think() {
  var_0 = [];

  foreach(var_2 in level.tripwires.traps) {
    if(isDefined(var_2) && var_2 istouching(self)) {
      var_0[var_0.size] = var_2;
      thread storage_tripwire_chain_defuse_single(var_2);
    }
  }

  self waittill("storage_tripwire_defused", var_4);

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isDefined(var_2.defusehintstruct)) {
      if(isDefined(var_4) && var_2 == var_4) {
        continue;
      }
      var_6 = level.player;

      if(isDefined(level.farah))
        var_6 = level.farah;

      var_2.defusehintstruct notify("trigger", level.farah);
      var_2.defusehintstruct scripts\sp\player\cursor_hint::remove_cursor_hint();
      wait 0.2;
    }
  }
}

storage_tripwire_chain_defuse_single(var_0) {
  var_0 endon("trigger");
  level endon("storage_tripwire_defused");

  if(!isDefined(var_0.defusehintstruct)) {
    return;
  }
  var_0.defusehintstruct waittill("trigger");
  self notify("storage_tripwire_defused", var_0);
}

storage_3rd_room_propane_tripwire() {
  wait 2;
  level.storage_3rd_room_propanes = getscriptablearray("storage_3rd_room_propane", "targetname");
  scripts\engine\utility::array_thread(level.storage_3rd_room_propanes, ::storage_3rd_room_propane_set_exploder);
  scripts\engine\utility::array_thread(level.storage_3rd_room_propanes, ::storage_3rd_room_propane_tripwire_think);
}

storage_3rd_room_propane_set_exploder() {
  level endon("storage_3rd_room_propane_set_exploder");

  while(isDefined(self) && isDefined(self.model) && self.model != "")
    wait 0.1;

  thread scripts\engine\utility::exploder("propane_bois_2");
  level notify("storage_3rd_room_propane_set_exploder");
}

storage_3rd_room_propane_tripwire_think() {
  while(isDefined(self) && isDefined(self.model) && self.model != "")
    wait 0.1;

  storage_3rd_room_setoff_tripwires();
}

storage_farah_combat_behavior() {
  level.farah endon("death");
  scripts\engine\utility::flag_wait("farah_battlechatter_on");
  level.farah scripts\engine\utility::delaythread(2, scripts\common\utility::demeanor_override, "combat");
}

storage_first_room_enemy_whisper() {
  level.player endon("death");
  level endon("storage_surprise_started");
  var_0 = getEnt("storage_vo_whisper", "targetname");
  var_1 = getEnt(var_0.target, "targetname");
  var_0 waittill("trigger");
  var_1 scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_aq1_tunnels_hunt_02");
  var_1 scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_aq2_tunnels_hunt_04");
  wait 0.5;

  if(isDefined(level.farah) && isalive(level.farah))
    wait 1;
}

storage_oil_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::set_start_location("storage_oil", [level.player]);
  level.storage_do_not_spawn_runner = 1;
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::farah_teleport_and_reset("storage_oil_farah");
}

storage_oil_catchup() {
  scripts\engine\utility::flag_set("storage_final_room_entered");
}

storage_oil() {
  scripts\engine\utility::flag_init("storage_oilfire_puzzle_fire_on");
  thread storage_oil_final_room_nags();
  scripts\engine\utility::flag_wait("storage_final_room_reached");
  thread storage_retreat_on_look_at();
  level.farah scripts\common\utility::demeanor_override("combat");
  thread storage_death_hint_think();
  level.storage_mg_shoot_zone = getEnt("mg_shoot_zone", "targetname");
  level.storage_mg_no_shoot_zone = getEnt("mg_no_shoot_zone", "targetname");
  level.storage_mg_shoot_wall_zone = getEnt("mg_shoot_wall_zone", "targetname");
  level.storage_mg_slow_reaction_zone = getEnt("mg_slow_reaction_zone", "targetname");
  var_0 = getEnt("storage_room_1", "targetname");
  var_1 = getEnt("storage_room_2a", "targetname");
  var_2 = getEnt("storage_room_2b", "targetname");
  var_3 = getEnt("storage_room_2c", "targetname");
  var_4 = getEnt("storage_room_3", "targetname");
  thread monitor_player_deaths("storage_MG", var_3, var_4);
  thread magic_flash_enemy_vo(var_4);
  var_5 = scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::get_alive_enemies();
  var_6 = [];
  var_7 = 0;

  foreach(var_9 in var_5) {
    if(issubstr(var_9.classname, "_lmg") || isDefined(level.storage_lmg) && var_9 == level.storage_lmg) {
      var_7 = 1;
      continue;
    }

    if(isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == "storage_ambusher") {
      continue;
    }
    if(isDefined(var_9.script_noteworthy) && var_9.script_noteworthy == "storage_ambusher_blind_fire") {
      continue;
    }
    if(var_9 istouching(var_1) || var_9 istouching(var_2))
      var_6[var_6.size] = var_9;
  }

  if(!istrue(level.storage_do_not_spawn_runner)) {
    var_6[var_6.size] = scripts\engine\sp\utility::spawn_targetname("storage_retreater", 1);
    var_6[var_6.size] = scripts\engine\sp\utility::spawn_targetname("storage_retreater_2", 1);
  }

  wait 0.1;

  foreach(var_12, var_9 in var_6) {
    if(var_12 == 0) {}

    if(isalive(var_9))
      var_9 thread storage_redirect_enemies(var_3, var_4, 1);
  }

  thread start_mg_nags();
  thread storage_3rd_room_spawn(var_4);
  thread storage_oil_player_clear_vo();
  thread storage_mg_farah_behavior();
  thread storage_oilfire_puzzle();
  thread storage_mg_guy();
  thread storage_mg_coward();
  thread storage_mg_hint_objective();
  thread storage_mg_oilfire_scriptable_detonation();
  thread storage_mg_oilfire_setoff_other_propane_tanks();
}

start_mg_nags() {
  level endon("spawned_storage_3rd_room");

  while(getaiarray("axis").size > 1)
    level waittill("ai_killed");

  wait 20;
  var_0 = ["dx_vom_far_storage_hub_140", "dx_vom_far_storage_hub_150", "dx_vom_far_storage_hub_160"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  var_0 = ["dx_vom_far_storage_hub_210", "dx_vom_far_storage_hub_220", "dx_vom_far_storage_hub_230"];
  var_2 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_2.autoshuffle = 1;
  var_3 = 15;
  var_4 = 5;
  var_5 = 1.2;
  var_6 = 1.2;
  var_7 = 45;
  var_8 = 10;
  var_9 = getEnt("storage_farah_nag_trig", "targetname");

  for(;;) {
    if(level.farah istouching(var_9))
      var_10 = var_2 scripts\engine\sp\utility::deck_draw();
    else
      var_10 = var_1 scripts\engine\sp\utility::deck_draw();

    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter(var_10);
    wait(randomfloatrange(var_3 - var_4, var_3 + var_4));
    var_3 = min(var_3 * var_5, var_7);
    var_4 = min(var_4 * var_6, var_8);
  }
}

storage_oil_final_room_nags() {
  if(scripts\engine\utility::flag("storage_final_room_reached")) {
    return;
  }
  level endon("storage_final_room_reached");
  wait 15;
  var_0 = ["dx_vom_far_storage_hub_140", "dx_vom_far_storage_hub_150", "dx_vom_far_storage_hub_160"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_2 = 15;
  var_3 = 5;
  var_4 = 1.2;
  var_5 = 1.2;
  var_6 = 45;
  var_7 = 10;
  var_8 = getEnt("storage_room_2a", "targetname");

  for(;;) {
    var_9 = getaiarray("axis");
    var_10 = 0;

    foreach(var_12 in var_9) {
      if(var_12 istouching(var_8)) {
        var_10 = 1;
        break;
      }
    }

    if(var_10) {
      wait 0.1;
      continue;
    }

    wait 0.8;
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_combat_cooldown(0.8);
    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw());

    if(var_1 scripts\engine\sp\utility::deck_is_empty()) {
      break;
    }

    wait(randomfloatrange(var_2 - var_3, var_2 + var_3));
    var_2 = min(var_2 * var_4, var_6);
    var_3 = min(var_3 * var_5, var_7);
  }
}

storage_oil_player_clear_vo() {
  level endon("storage_split_player_jumped");
  scripts\engine\utility::flag_wait("in_storage_mg_nest");

  while(getaiarray("axis").size > 0)
    level waittill("ai_killed");

  wait 0.4;
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_combat_cooldown(0.4, 1);
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_alx_storage_oil_mgnest_310");
}

storage_retreat_on_look_at() {
  var_0 = scripts\engine\utility::getStruct("storage_lmg_room_look_at", "targetname").origin;

  for(;;) {
    if(scripts\engine\sp\utility::player_looking_at(var_0, 0.88)) {
      break;
    }

    if(scripts\engine\utility::flag("storage_final_room_reached_failsafe")) {
      break;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_set("storage_retreat_now");
}

storage_mg_oilfire_scriptable_detonation() {
  wait 0.25;
  level.storage_mg_room_propanes = getscriptablearray("storage_MG_room_propane", "targetname");
  scripts\engine\utility::array_thread(level.storage_mg_room_propanes, ::storage_mg_oilfire_scriptable_detonation_think);
}

storage_mg_oilfire_scriptable_detonation_think() {
  level endon("storage_MG_room_oilfire_detonated");
  self endon("entitydeleted");

  while(isDefined(self) && isDefined(self.model) && self.model != "")
    wait 0.1;

  if(isDefined(level.storage_oil_fire) && !istrue(level.storage_oil_fire.fire_exploder_on)) {
    level.storage_oil_fire thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::oilfire_run(0.05);
    level notify("storage_MG_room_oilfire_detonated");
  }
}

storage_mg_oilfire_setoff_other_propane_tanks() {
  wait 0.25;

  for(;;) {
    if(istrue(level.storage_oil_fire.fire_exploder_on)) {
      break;
    }

    wait 0.05;
  }

  wait 0.5;

  foreach(var_1 in level.storage_mg_room_propanes) {
    if(!isDefined(var_1)) {
      continue;
    }
    radiusdamage(var_1.origin, 50, 100, 90);
  }
}

monitor_player_deaths(var_0, var_1, var_2, var_3) {
  level.player waittill("death");
  var_4 = 0;

  if(level.player istouching(var_1))
    var_4 = 1;

  if(isDefined(var_2) && level.player istouching(var_2))
    var_4 = 1;

  if(isDefined(var_3) && level.player istouching(var_3))
    var_4 = 1;

  if(var_4)
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::register_player_deaths(var_0);
}

storage_mg_hint_objective() {
  scripts\engine\utility::flag_wait("storage_final_room_entered");
  wait 0.5;

  if(!isDefined(level.storage_mg_guy) || !isalive(level.storage_mg_guy)) {
    return;
  }
  var_0 = getEnt("mg_shield", "targetname");
  var_1 = var_0.origin + (0, -24, 42);
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_FLANKMG");
  scripts\engine\sp\objectives::objective_add_location_position("tunnels_search", "mg_nest", var_1);
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait_any, "storage_mg_passed", "in_storage_mg_nest");
  level.storage_mg_guy scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "death");
  scripts\engine\sp\utility::do_wait_any();
  wait 1;
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  var_2 = getnode("storage_mg_farah_idle_node", "targetname");
  var_1 = var_2.origin;
  scripts\engine\sp\objectives::objective_add_location_position("tunnels_search", "mines", var_1);
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
}

storage_death_hint_think() {
  scripts\engine\utility::flag_wait("storage_final_room_entered");
  var_0 = getEnt("storage_room_3", "targetname");

  while(!level.player istouching(var_0))
    wait 0.05;

  var_1 = scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::get_player_deaths("storage_MG");
  var_2 = 71;

  if(var_1 == 0)
    return;
  else if(var_1 <= 1)
    var_2 = 71;
  else if(var_1 == 2)
    var_2 = 69;
  else if(var_1 == 3)
    var_2 = 67;
  else if(var_1 == 4)
    var_2 = 63;
  else
    var_2 = scripts\engine\utility::random([63, 67, 69, 71]);

  if(var_2 == 69 && !level.player hasweapon("flash"))
    var_2 = scripts\engine\utility::random([63, 67, 71]);

  scripts\sp\player_death::set_custom_death_quote(var_2);
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "player_already_at_split");
  level scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "oil_fire_ignited");
  scripts\engine\sp\utility::do_wait_any();
  scripts\sp\player_death::clear_custom_death_quote();
}

magic_flash_enemy_vo(var_0) {
  scripts\engine\utility::flag_wait("enemy_magic_flash_vo");
  var_1 = scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::get_alive_enemies();

  if(!isDefined(var_1) || var_1.size == 0) {
    return;
  }
  var_2 = sortbydistance(var_1, level.player.origin);
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = var_2[var_4];

    if(var_5 istouching(var_0))
      var_3 = var_5;
  }

  if(isDefined(var_3))
    return;
}

storage_mg_farah_behavior() {
  level.farah endon("death");
  scripts\engine\utility::flag_wait("storage_final_room_entered");
  level.farah scripts\engine\utility::set_movement_speed(150);
  level.farah thread nag_storage_mg_nest_vo();
  wait 5;
  thread storage_mg_farah_suppression();
  var_0 = getnode("storage_mg_farah_prep_node", "targetname");
  level.farah scripts\common\utility::demeanor_override("sprint");
  scripts\engine\utility::flag_wait("in_storage_mg_nest");

  if(!scripts\engine\sp\utility::player_looking_at(level.farah getEye(), 0.7) && !scripts\engine\sp\utility::player_looking_at(var_0.origin, 0.7)) {
    level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_storage_oil_mgnest_320");
    level.farah teleport(var_0.origin, var_0.angles);
    level.farah scripts\engine\sp\utility::set_goalRadius(32);
    level.farah setgoalnode(var_0);
    thread storage_mg_putout_fire(1);
    return;
  }

  storage_mg_putout_fire();
  level.farah scripts\engine\sp\utility::set_goalRadius(32);
  level.farah setgoalnode(var_0);
}

nag_while_near(var_0, var_1) {}

storage_mg_putout_fire(var_0) {
  if(isDefined(level.storage_oil_fire) && istrue(level.storage_oil_fire.fire_exploder_on)) {
    level.storage_oil_fire.kill_oilfire = 1;
    level.storage_oil_fire.fire_hp = 0;

    if(!istrue(var_0))
      level.storage_oil_fire waittill("oil_fire_out");

    if(isDefined(level.storage_oil_fire.puzzle_clip))
      level.storage_oil_fire.puzzle_clip waittill("puzzle_clip_off");
  }
}

storage_mg_farah_suppression() {
  level.farah thread scripts\engine\sp\utility::set_force_cover(1);
  level.storage_mg_guy scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittill_any, "death", "entitydeleted");
  level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "player_already_at_split");
  scripts\engine\sp\utility::do_wait_any();
  level.farah thread scripts\engine\sp\utility::set_force_cover(0);
}

nag_storage_mg_nest_vo() {
  level.player endon("death");
  level endon("storage_mg_crawl_discover");
  level endon("in_storage_mg_nest");

  if(scripts\engine\utility::flag("storage_mg_crawl_discover") || scripts\engine\utility::flag("in_storage_mg_nest")) {
    return;
  }
  if(!isDefined(level.storage_mg_guy) || !isalive(level.storage_mg_guy)) {
    return;
  }
  level endon("storage_mg_crawl_discover");
  level endon("in_storage_mg_nest");
  level.storage_mg_guy endon("death");
  level.player endon("death");
  level.storage_mg_guy waittill("weapon_fired");
  wait 0.7;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_storage_oil_mgnest_10");
  wait 0.1;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_storage_oil_mgnest_20");
  level waittill("break_in_turret_fire");
  level waittill("break_in_turret_fire");
  wait 0.8;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_storage_oil_mgnest_60");
  var_0 = ["dx_vom_far_storage_oil_mgnest_80", "dx_vom_far_storage_oil_mgnest_90"];
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  var_0 = ["dx_vom_far_storage_oil_mgnest_100", "dx_vom_far_storage_oil_mgnest_110", "dx_vom_far_storage_oil_mgnest_120"];
  var_2 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_far_storage_oil_mgnest_140", "dx_vom_far_storage_oil_mgnest_160", "dx_vom_far_storage_oil_mgnest_180"];
  var_3 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_far_storage_oil_mgnest_130";
  var_0[var_0.size] = "dx_vom_far_storage_oil_mgnest_150";
  var_0[var_0.size] = "dx_vom_far_storage_oil_mgnest_190";
  var_0[var_0.size] = "dx_vom_far_storage_oil_mgnest_200";
  var_0[var_0.size] = "dx_vom_far_storage_oil_mgnest_210";
  var_4 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = ["dx_vom_far_storage_oil_mgnest_220", "dx_vom_far_storage_oil_mgnest_230"];
  var_5 = scripts\engine\sp\utility::create_deck(var_0);
  var_6 = scripts\engine\sp\utility::create_deck(["use_flash", "use_molotov", "flank"], 0);

  for(;;) {
    level waittill("break_in_turret_fire");
    level waittill("break_in_turret_fire");
    level waittill("break_in_turret_fire");
    wait 0.8;

    if(istrue(level.storage_mg_guy.zd30_is_flashed))
      level.farah scripts\engine\sp\utility::smart_dialogue(var_5 scripts\engine\sp\utility::deck_draw());
    else {
      var_7 = var_6 scripts\engine\sp\utility::deck_draw();

      switch (var_7) {
        case "flank":
          level.farah scripts\engine\sp\utility::smart_dialogue(var_1 scripts\engine\sp\utility::deck_draw());
          break;
        case "use_flash":
          if(say_offhand_nag(var_2, "flash")) {
            break;
          }

          var_6 scripts\engine\sp\utility::deck_draw_specific("use_molotov");
        case "use_molotov":
          if(say_offhand_nag(var_4, "molotov")) {
            break;
          }
        case "get_molotov":
          level.farah scripts\engine\sp\utility::smart_dialogue(var_3 scripts\engine\sp\utility::deck_draw());
          break;
        default:
          break;
      }
    }

    wait 2;
  }
}

say_offhand_nag(var_0, var_1) {
  var_2 = level.player getammocount(var_1) > 0;

  if(var_2)
    level.farah scripts\engine\sp\utility::smart_dialogue(var_0 scripts\engine\sp\utility::deck_draw());

  return var_2;
}

storage_redirect_enemies(var_0, var_1, var_2) {
  self endon("death");
  storage_enemy_waittill_seen_or_hurt(2, 0.05);
  thread storage_enemy_temp_ignore(2.5);
  scripts\common\utility::demeanor_override("sprint");
  self.dontshootwhilemoving = 1;
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  self cleargoalvolume();
  self clearentitytarget();
  waitframe();
  self setgoalvolumeauto(var_0);
  self waittill("goal");
  storage_enemy_waittill_seen_or_hurt(5, 0.05);
  thread storage_enemy_temp_ignore(1.5);
  self cleargoalvolume();
  self clearentitytarget();
  waitframe();
  self setgoalvolumeauto(var_1);

  if(istrue(var_2)) {
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, 400);
    return;
  }

  self waittill("goal");
  self.dontshootwhilemoving = 0;
  scripts\engine\sp\utility::set_maxfaceenemydist(512);
  scripts\common\utility::clear_demeanor_override();
  thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::storage_advancer_mg_aware();
}

storage_enemy_waittill_seen_or_hurt(var_0, var_1) {
  self endon("death");
  level endon("storage_retreat_now");

  if(scripts\engine\utility::flag("storage_retreat_now")) {
    wait(randomfloatrange(0.05, 1));
    return;
  }

  var_0 = randomfloatrange(0.75, 1.25) * var_0;
  var_2 = self.health;
  var_1 = int(var_1 * 1000);

  while(!self hasenemybeenseen(var_1)) {
    var_0 = var_0 - 0.05;

    if(var_0 <= 0) {
      break;
    }

    if(var_2 != self.health) {
      break;
    }

    wait 0.05;
  }
}

storage_enemy_temp_ignore(var_0) {
  self endon("death");
  self endon("beenshot");
  level.player endon("death");
  childthread storage_enemy_temp_ignore_shot();
  self.ignoreall = 1;

  while(var_0 > 0) {
    var_0 = var_0 - 0.05;
    wait 0.05;

    if(distance2dsquared(level.player.origin, self.origin) < 6400) {
      break;
    }
  }

  self.ignoreall = 0;
}

storage_enemy_temp_ignore_shot() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && var_1 == level.player) {
      break;
    }
  }

  self notify("beenshot");
  self.ignoreall = 0;
}

storage_3rd_room_spawn(var_0) {
  var_1 = 4;
  var_2 = getEnt("storage_3rd_room_spawn_trig", "targetname");
  var_2 waittill("trigger");
  level notify("spawned_storage_3rd_room");
  var_3 = scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::get_alive_enemies();
  var_4 = 0;

  foreach(var_6 in var_3) {
    if(var_6 istouching(var_0)) {
      if(!isDefined(var_6.targetname) || var_6.targetname != "storage_mg_guy" && var_6.targetname != "storage_mg_coward")
        var_4++;
    }
  }

  if(var_4 < var_1) {
    var_8 = getEnt(var_2.target, "targetname");
    var_8 notify("trigger", level.player);
  }
}

storage_oilfire_puzzle() {
  var_0 = getEnt("storage_oilfire_puzzle", "targetname");
  var_1 = getEnt(var_0.target, "targetname");
  var_1.original_origin = var_1.origin;
  var_1 connectpaths();
  var_1.origin = var_1.origin - (0, 0, 10000);
  level.storage_oil_fire = undefined;

  foreach(var_3 in level.oil_fires) {
    if(var_0 istouching(var_3)) {
      level.storage_oil_fire = var_3;

      while(!istrue(var_3.fire_exploder_on))
        wait 0.05;

      break;
    }
  }

  if(!isDefined(level.storage_oil_fire)) {
    return;
  }
  scripts\engine\utility::exploder("mg_nest_fire_stay");
  var_5 = scripts\engine\utility::getStruct("storage_MG_linger_fire_dmg_struct", "targetname");
  var_6 = var_5.radius;
  var_7 = var_5.origin;
  var_8 = 128;
  var_9 = spawn("trigger_radius_fire", var_7, 0, var_6, var_8);
  var_9.script_multiplier = 5;
  var_9.script_radius = var_6;
  thread scripts\sp\trigger::trigger_fire(var_9);
  level.storage_oil_fire.puzzle_clip = var_1;

  while(isDefined(level.storage_oil_fire)) {
    var_1 notify("puzzle_clip_on");
    scripts\engine\utility::flag_set("storage_oilfire_puzzle_fire_on");
    var_1.origin = var_1.original_origin;

    while(isDefined(level.storage_oil_fire) && istrue(level.storage_oil_fire.fire_exploder_on))
      wait 0.05;

    var_1.origin = var_1.origin - (0, 0, 10000);
    waitframe();
    var_1 notify("puzzle_clip_off");
    scripts\engine\utility::flag_clear("storage_oilfire_puzzle_fire_on");

    while(!isDefined(level.storage_oil_fire) || !istrue(level.storage_oil_fire.fire_exploder_on))
      wait 0.05;
  }
}

storage_mg_guy() {
  var_0 = scripts\engine\sp\utility::spawn_targetname("storage_mg_guy", 1);
  level.storage_mg_guy = var_0;
  var_0 endon("death");
  var_0 childthread storage_mg_guy_health_management();
  var_0 thread storage_mg_guy_molotov_death();
  var_0 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::flashbang_immunity(10, "storage_final_room_entered");
  var_0 thread turret_operator();
  var_0 thread storage_mg_guy_flashbang_detector();
  var_0.ignoreme = 1;
  var_0 thread storage_mg_guy_monitor_shot_by_player_near_mg_nest();
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "in_storage_mg_nest");
  var_0 scripts\engine\sp\utility::add_wait(scripts\engine\utility::ent_flag_wait, "shot_near_mg_nest");
  scripts\engine\sp\utility::do_wait_any();
  var_0 notify("off_of_MG");
  var_0.health = 50;
  var_0.ignoreme = 0;
  var_0 setgoalentity(level.player, 50);
  var_0 scripts\engine\sp\utility::set_goal_radius(32);

  if(scripts\engine\utility::flag("storage_mg_passed") && !scripts\engine\utility::flag("storage_mg_crawl")) {
    return;
  }
  waitframe();
  var_0.animname = "storage_mg_guy";
  var_0.allowdeath = 1;
  var_1 = scripts\engine\utility::getStruct("storage_mg_dismount", "targetname");
  var_1 scripts\common\anim::anim_single_solo(var_0, "dismount");
}

storage_mg_guy_molotov_death() {
  thread storage_mg_guy_molotov_crawl("mg_crawl_1", 1);
  thread storage_mg_guy_molotov_crawl("mg_crawl_2", 1);
  level endon("player_entered_molotov_crawl_trigs");
  level endon("storage_mg_crawl");

  for(;;) {
    if(isDefined(self)) {
      if(istrue(self.burningtodeath) || scripts\engine\utility::flag("storage_oilfire_puzzle_fire_on")) {
        scripts\engine\utility::flag_set("mg_gunner_died_from_fire");
        self.nocorpse = 1;
        self delete();
        return;
      }
    } else
      return;

    wait 0.05;
  }
}

storage_mg_guy_molotov_crawl(var_0, var_1) {
  level endon("player_entered_molotov_crawl_trigs");
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = getEnt(var_2.target, "targetname");
  var_2.angles = var_2.angles + (0, 180, 0);
  var_3 waittill("trigger");
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::cleanup_corpses_in_radius(var_2.origin, 128);

  if(!scripts\engine\utility::flag("mg_gunner_died_from_fire")) {
    return;
  }
  thread storage_mg_guy_molotov_crawl_anim(var_2, var_1);
  level notify("player_entered_molotov_crawl_trigs");
}

storage_mg_guy_molotov_crawl_anim(var_0, var_1) {
  var_2 = "storage_mg_guy";
  var_3 = scripts\engine\sp\utility::spawn_targetname(var_2 + "_burn", 1);
  var_3.animname = var_2;
  var_3.allowdeath = 1;
  var_3.noragdoll = 1;
  var_3.ignoreme = 1;
  var_3.ignoreall = 1;
  var_3.disabledeathorient = 1;
  var_3 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::battlechatter_off_spawn_func();
  var_3 thread scripts\engine\sp\utility::name_hide();
  var_3 thread scripts\asm\soldier\death::handleburndeathmodelswap();
  var_3 thread scripts\asm\soldier\death::handleburndeathvfx();
  var_3 scripts\engine\sp\utility::set_deathanim("burn_crawl_death");
  var_0 scripts\common\anim::anim_single_solo(var_3, "burn_crawl");
  var_3 kill();
}

storage_mg_guy_health_management() {
  self endon("death");
  self.health = 300;
  scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_mg_guy_health_reset");
  scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "off_of_MG");
  scripts\engine\sp\utility::do_wait_any();
  self.health = 50;
}

storage_mg_guy_monitor_shot_by_player_near_mg_nest() {
  self endon("death");
  self endon("off_of_MG");
  scripts\engine\utility::ent_flag_init("shot_near_mg_nest");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && isPlayer(var_1) && level.player istouching(level.storage_mg_no_shoot_zone)) {
      scripts\engine\utility::ent_flag_set("shot_near_mg_nest");
      return;
    }
  }
}

storage_mg_coward() {
  var_0 = scripts\engine\utility::flag_wait_any_return("storage_mg_passed", "storage_mg_crawl");
  var_1 = scripts\engine\sp\utility::spawn_targetname("storage_mg_coward", 1);
  var_1 endon("death");
  var_1 scripts\engine\sp\utility::set_grenadeammo(0);

  if(var_0 == "storage_mg_crawl") {
    var_1 scripts\common\utility::demeanor_override("sprint");
    var_1 scripts\engine\utility::delaythread(0.75, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_playsound, "dx_vom_aq2_tunnels_ambusher_10");
    var_1 thread storage_mg_coward_monitor_death();
    var_1 scripts\engine\sp\utility::set_goal_radius(32);
    var_1 waittill("goal");
    var_1 scripts\common\utility::clear_demeanor_override();
    wait 3;
    var_1 scripts\engine\sp\utility::set_goal_radius(1024);
    var_1 setgoalentity(level.player, 500);
  } else
    var_1 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::zdt_rush_guy();
}

storage_mg_coward_monitor_death() {
  if(!isDefined(self) || !isalive(self) || !isDefined(level.storage_mg_guy) || !isalive(level.storage_mg_guy)) {
    return;
  }
  level.storage_mg_guy endon("off_of_MG");
  level.storage_mg_guy endon("death");

  for(;;) {
    self waittill("death", var_0);

    if(isDefined(var_0) && isPlayer(var_0) && level.player istouching(level.storage_mg_no_shoot_zone)) {
      wait 1;
      level notify("coward_killed_near_mg_nest");
      return;
    }
  }
}

turret_operator() {
  self endon("death");
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_0 = self getturret();
    waitframe();
  }

  self notify("stop_using_built_in_burst_fire");
  var_0 setturretteam("axis");
  var_0 setrightarc(120);
  var_0 setleftarc(120);
  var_0 setbottomarc(45);
  var_0 settoparc(30);
  var_0 setconvergencetime(0.05, "yaw");
  var_0 setconvergencetime(0.05, "pitch");
  var_0.accuracy = 0.9;
  var_0.maxrange = 50000;
  var_0.aispread = 0;
  var_0 setmode("manual_ai");
  var_0.health = 99999;
  var_0 makeunusable();
  var_1 = scripts\sp\utility::make_weapon("iw8_lm_pkilo");
  var_2 = spawn("weapon_" + createheadicon(var_1), var_0.origin + (-1, -15, 9));
  var_2.angles = var_0.angles;
  var_2 linkTo(var_0, "tag_flash");
  var_2 thread unlink_on_use();
  var_0.turret_weapon = var_2;
  var_3 = getEnt("mg_shield", "targetname");
  var_3 linkTo(var_0, "tag_flash");
  var_0 childthread turret_logic(self);
  thread storage_mg_tracer_remove_on_death(var_0);
}

unlink_on_use() {
  self waittill("trigger_progress");
  self unlink();
}

turret_logic(var_0) {
  var_0 endon("death");
  level endon("in_storage_mg_nest");
  setup_overheat_sound_orgs();
  level.idle_target_trigs = getEntArray("mg_idle_target_trig", "targetname");

  foreach(var_2 in level.idle_target_trigs) {
    var_2.targets = getEntArray(var_2.target, "targetname");

    foreach(var_4 in var_2.targets)
    var_4.use_count = 0;
  }

  scripts\engine\utility::flag_wait("storage_final_room_entered");

  if(isDefined(level.farah))
    level.farah thread farah_monitor_mg_shot();

  var_7 = 3;
  var_8 = 25;
  var_9 = 35;
  var_10 = 2.5;
  var_11 = 1;
  var_12 = 2;
  var_13 = 0.25;
  var_14 = 0.15;

  switch (scripts\common\utility::getdifficulty()) {
    case "easy":
      var_8 = 25;
      var_9 = 35;
      var_10 = 2.5;
      var_11 = 1;
      var_12 = 2;
      var_13 = 0.25;
      break;
    case "hard":
      var_8 = 25;
      var_9 = 35;
      var_10 = 2.5;
      var_11 = 1;
      var_12 = 2;
      var_13 = 0.25;
      break;
    case "fu":
      var_8 = 25;
      var_9 = 35;
      var_10 = 2;
      var_11 = 1;
      var_12 = 2;
      var_13 = 0.25;
      break;
    default:
      break;
  }

  thread storage_mg_player_lag(var_13);

  for(;;) {
    var_15 = randomintrange(var_8, var_9);
    playFXOnTag(scripts\engine\utility::getfx("vfx_storage_mg_tracer"), self.turret_weapon, "tag_flash");
    self.isshooting = 1;

    for(var_16 = 0; var_16 < var_15; var_16++) {
      var_17 = get_storage_mg_target(var_0);

      if(!isDefined(var_17)) {
        wait 0.05;
        break;
      }

      if(istrue(var_0.zd30_is_flashed)) {
        break;
      }

      self settargetentity(var_17);

      if(isPlayer(var_17) || isai(var_17))
        var_18 = (0, 0, 20);
      else
        var_18 = (0, 0, 0);

      if(isPlayer(var_17) && isDefined(level.player.lagged_position)) {
        var_19 = level.player.lagged_position - level.player.origin;
        var_19 = (var_19[0], var_19[1], 0);
        var_18 = var_18 + var_19;
      }

      var_20 = self gettagorigin("tag_flash");
      var_21 = self gettagangles("tag_flash");
      var_22 = anglesToForward(var_21);
      var_23 = distance(level.player.origin, var_20);
      var_24 = var_18 + var_20 + var_22 * var_23 + scripts\engine\utility::randomvectorrange(var_11, var_12);
      var_25 = (0, 0, -24);

      if(isPlayer(var_17) || isai(var_17))
        var_24 = var_24 + var_25;

      magicbullet("iw8_ar_akilo47_tunnels_mg", var_20, var_24, var_0);
      playFXOnTag(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), self.turret_weapon, "tag_flash");
      wait(var_14);
    }

    stopFXOnTag(scripts\engine\utility::getfx("vfx_storage_mg_tracer"), self.turret_weapon, "tag_flash");
    self.isshooting = 0;
    var_26 = self.turret_weapon gettagorigin("tag_flash");
    var_27 = anglesToForward(self.turret_weapon gettagangles("tag_flash"));
    var_28 = anglestoup(self.turret_weapon gettagangles("tag_flash"));
    playFX(level._effect["vfx_mg_overheat"], var_26, var_27, var_28);
    thread scripts\engine\utility::play_sound_in_space("turret_overheat", get_overheat_org());
    level notify("break_in_turret_fire");

    if(istrue(var_0.zd30_is_flashed)) {
      wait(var_7);
      continue;
    }

    wait(var_10);
  }
}

get_overheat_org() {
  return level.turret_overheat_org;
}

setup_overheat_sound_orgs() {
  var_0 = getEntArray("turret_overheat_trig", "targetname");
  level.turret_overheat_org = scripts\engine\utility::getStruct(var_0[0].target, "targetname").origin;
  scripts\engine\utility::array_thread(var_0, ::setup_overheat_sound_org);
}

setup_overheat_sound_org() {
  level endon("in_storage_mg_nest");

  for(;;) {
    self waittill("trigger");
    level.turret_overheat_org = scripts\engine\utility::getStruct(self.target, "targetname").origin;
    wait 0.05;
  }
}

storage_mg_tracer_remove_on_death(var_0) {
  self waittill("death");

  if(!isDefined(var_0)) {
    return;
  }
  if(!istrue(var_0.isshooting)) {
    return;
  }
  stopFXOnTag(scripts\engine\utility::getfx("vfx_storage_mg_tracer"), var_0, "tag_flash");
}

storage_mg_player_lag(var_0) {
  level.player endon("death");

  for(;;) {
    if(level.player istouching(level.storage_mg_shoot_zone))
      wait 0.1;
    else
      wait(var_0);

    level.player.lagged_position = level.player.origin;
  }
}

storage_mg_guy_flashbang_detector() {
  self endon("death");
  self endon("off_of_MG");
  scripts\common\utility::setflashbangimmunity(1);
  var_0 = 3;
  var_1 = getEnt("flashbang_detector", "targetname");

  for(;;) {
    var_1 waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(scripts\engine\utility::isflashed() || isDefined(var_11) && (var_11.basename == "flash" || var_11.basename == "flash_grenade")) {
      var_12 = "Flashed !";

      if(int(getDvar("zd30_debug")) > 0)
        var_13 = int(var_0 * 20);

      self.zd30_is_flashed = 1;
      wait(var_0);
      self.zd30_is_flashed = 0;
    }
  }
}

turret_owner_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && var_1 == level.player) {
    if(isDefined(self.magic_bullet_shield))
      scripts\common\ai::stop_magic_bullet_shield();
  }
}

farah_monitor_mg_shot() {
  level.farah endon("death");
  level.farah.last_shot_by_mg = gettime();

  for(;;) {
    level.farah waittill("damage", var_0, var_1);

    if(isDefined(var_1) && isai(var_1) && isDefined(level.storage_mg_guy) && level.storage_mg_guy == var_1)
      level.farah.last_shot_by_mg = gettime();

    wait 0.1;
  }
}

get_storage_mg_target(var_0) {
  var_1 = undefined;
  var_2 = 3;

  if(isDefined(level.farah) && isalive(level.farah) && isDefined(level.farah.last_shot_by_mg)) {
    if(level.player istouching(level.storage_mg_no_shoot_zone) || gettime() - level.farah.last_shot_by_mg > var_2 * 1000)
      var_1 = level.farah;
  }

  if(shouldshootplayer(var_0) && should_shoot_if_player_mounted())
    var_1 = level.player;
  else {
    var_3 = undefined;

    foreach(var_5 in level.idle_target_trigs) {
      if(level.player istouching(var_5))
        var_3 = var_5;
    }

    if(!isDefined(var_3) && isDefined(level.farah) && isalive(level.farah)) {
      foreach(var_5 in level.idle_target_trigs) {
        if(level.farah istouching(var_5))
          var_3 = var_5;
      }
    }

    if(!isDefined(var_3))
      var_3 = sortbydistance(level.idle_target_trigs, level.player.origin)[0];

    var_9 = "MG idle target trig and targets setup incorrectly";
    var_1 = scripts\engine\utility::random(var_3.targets);

    foreach(var_11 in var_3.targets) {
      if(var_1.use_count > var_11.use_count)
        var_1 = var_11;
    }

    var_1.use_count++;
  }

  if(int(getDvar("zd30_debug")) >= 1 && isDefined(var_0) && isai(var_0)) {
    if(!isDefined(var_1))
      var_9 = "Target: NONE";
    else if(var_1 == level.farah)
      var_9 = "Target: Farah";
    else if(var_1 == level.player)
      var_9 = "Target: Player";
    else
      var_9 = "Target: Idle";

    var_13 = 0.5;

    if(!isDefined(level.zd30_debug_mg_last_target_print_time) || gettime() - level.zd30_debug_mg_last_target_print_time > var_13 * 1000) {
      level.zd30_debug_mg_last_target_print_time = gettime();
      var_14 = int(var_13 * 20);
    }
  }

  return var_1;
}

shouldshootplayer(var_0) {
  if(level.player istouching(level.storage_mg_no_shoot_zone))
    return 0;

  if(var_0 cansee(level.player))
    return 1;

  if(isDefined(level.storage_oil_fire) && istrue(level.storage_oil_fire.fire_exploder_on))
    return 0;
  else if(level.player istouching(level.storage_mg_shoot_zone))
    return 1;

  return 0;
}

should_shoot_if_player_mounted() {
  var_0 = scripts\engine\utility::getStruct("mg_hole", "targetname").origin;

  if(level.player playermount() > 0.5) {
    if(!scripts\engine\sp\utility::player_looking_at(var_0, 0.993, 1))
      return 0;
  }

  return 1;
}

storage_split_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::set_start_location("storage_split", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::farah_teleport("storage_split_farah");
}

storage_split_catchup() {
  level.player modifybasefov(level.fov_mine, 0.05);
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_tunnels);
  level.scr_model["player_rig"] = "viewhands_alex_fullbody";
  scripts\sp\maps\tunnels\tunnels.gsc::farah();
  store_farah();
}

storage_split() {
  thread analytics_storage();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::remove_hadir();
  var_0 = "storage_split_scene";
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_1.trig = getEnt(var_1.target, "targetname");
  var_1.trig waittill("trigger");
  level.farah scripts\common\utility::clear_demeanor_override();
  waitframe();
  level.farah scripts\common\utility::demeanor_override("sprint");
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::waittill_player_lookat_failsafe(level.farah getEye(), 0.8, undefined, level.farah, 0.05, undefined, undefined, 250, "player_already_at_split");
  var_2 = 0;

  if(!level.farah istouching(var_1.trig))
    var_2 = 1;

  scripts\engine\utility::flag_set("farah_storage_split_scene_start");
  thread storage_split_scene_farah(var_1, var_0, var_2);
  thread storage_split_scene_player(var_1, var_0);

  while(isDefined(level.storage_mg_guy) && isalive(level.storage_mg_guy)) {
    if(scripts\engine\utility::flag("player_already_at_split") && isDefined(level.storage_mg_guy.magic_bullet_shield)) {
      level.storage_mg_guy scripts\common\ai::stop_magic_bullet_shield();
      break;
    }

    wait 0.25;
  }
}

storage_split_scene_farah(var_0, var_1, var_2) {
  if(var_2 || scripts\engine\utility::flag("storage_split_player_jumped")) {
    var_3 = getnode("storage_mg_farah_prep_node", "targetname");
    level.farah scripts\engine\sp\utility::set_goal_node(var_3);
    wait 1;
    level.farah scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "goal");
    level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_split_player_jumped");
    scripts\engine\sp\utility::do_wait_any();

    if(!scripts\engine\utility::flag("player_already_at_split")) {
      thread storage_split_scene_farah(var_0, var_1, 0);
      waitframe();
      return;
    }

    var_0 = scripts\engine\utility::getStruct("storage_split_scene_branch", "targetname");
  } else {
    var_3 = getnode("storage_mg_farah_final_node", "targetname");
    var_0 scripts\sp\anim::anim_reach_solo(level.farah, var_1 + "_enter");
    level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter("dx_vom_far_storage_split_fall_50");
    var_0 scripts\common\anim::anim_single_solo(level.farah, var_1 + "_enter");
    level.farah setanimrate(level.farah scripts\engine\utility::getanim(var_1 + "_enter"), 1.5);
    var_0 thread scripts\common\anim::anim_loop_solo(level.farah, var_1 + "_enter_idle");
    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::waittill_player_lookat_failsafe(level.farah getEye(), 0.8, undefined, level.farah, 0.05, undefined, undefined, 170, "storage_split_player_jumped");
    level.farah scripts\engine\sp\utility::anim_stopanimScripted();
    var_0 notify("stop_loop");
    level.farah notify("stop_nag");
    level.farah scripts\engine\sp\utility::name_hide();
    level.farah.script_pushable = 0;

    if(scripts\engine\utility::flag("storage_split_player_legs_hide")) {
      thread storage_split_scene_farah(var_0, var_1, 1);
      waitframe();
      return;
    }

    var_0 thread scripts\common\anim::anim_single_solo(level.farah, var_1 + "_intro");
    var_4 = "storage_split_skip_to_jump_monitor_kill";
    thread storage_split_skip_to_jump_monitor(var_4);
    level scripts\engine\sp\utility::add_wait(scripts\engine\utility::flag_wait, "storage_split_player_jumped");
    level.farah scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "storage_split_skip_to_jump");
    level.farah scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittillmatch_any_return, "single anim", "end");
    scripts\engine\sp\utility::do_wait_any();
    level notify(var_4);
    thread storage_split_scene_farah_vo(var_0, var_1);
  }

  scripts\engine\utility::flag_wait("storage_split_player_jumped");
  level.farah notify("stop_nag");
  thread storage_split_scene_farah_jump(var_0, var_1, var_3);
}

storage_split_scene_farah_vo(var_0, var_1) {
  var_2 = ["dx_vom_far_storage_split_fall_20", "dx_vom_far_storage_split_fall_30", "dx_vom_far_storage_split_fall_40"];
  level.farah nag_interval(var_0, var_1 + "_intro", 2, 3, var_2, undefined, 25);

  if(!scripts\engine\utility::flag("storage_split_player_jumped"))
    var_0 thread scripts\common\anim::anim_loop_solo(level.farah, var_1 + "_intro_idle");
}

nag_interval(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_nag");
  var_7 = var_1 + "_idleonce";
  var_8 = var_1 + "_idle";
  var_9 = var_1 + "_nag";

  if(isDefined(var_5)) {
    var_0 endon(var_5);
    level endon(var_5);
    self endon(var_5);
  }

  if(isarray(var_4))
    var_4 = scripts\engine\sp\utility::create_deck(var_4);

  if(!isDefined(var_6))
    var_6 = 100000;

  var_10 = randomintrange(var_2, var_3);
  var_11 = 0;
  var_12 = 0;

  while(var_12 < var_6) {
    var_0 scripts\common\anim::anim_single_solo(self, var_7);
    var_11++;

    if(var_11 == var_10) {
      var_12++;

      if(isDefined(var_4))
        scripts\engine\utility::delaythread(1, scripts\engine\sp\utility::smart_dialogue, var_4 scripts\engine\sp\utility::deck_draw());

      var_0 scripts\common\anim::anim_single_solo(self, var_9);
      var_10 = randomintrange(var_2, var_3);
      var_11 = 0;
    }
  }
}

storage_split_skip_to_jump_monitor(var_0) {
  level endon(var_0);
  var_1 = 0;

  while(!var_1) {
    if(scripts\engine\utility::flag("storage_split_player_jumped"))
      var_1 = 1;

    if(var_1)
      level.farah notify("storage_split_skip_to_jump");

    wait 0.05;
  }
}

storage_split_scene_farah_jump(var_0, var_1, var_2) {
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 notify("stop_loop");
  waitframe();
  var_0 scripts\common\anim::anim_single_solo(level.farah, var_1 + "_jump");
  var_0 thread scripts\common\anim::anim_loop_solo(level.farah, var_1 + "_jump_idle");
  wait 5;
  var_0 notify("stop_loop");
  var_0 scripts\common\anim::anim_single_solo(level.farah, var_1 + "_jump_exit");
  level.farah scripts\engine\sp\utility::set_goal_node(var_2);
  level.farah scripts\engine\sp\utility::set_goal_radius(28);
  level.farah scripts\engine\utility::waittill_any_timeout(5, "goal");
  store_farah();
}

storage_split_scene_player(var_0, var_1) {
  scripts\engine\utility::flag_wait("storage_split_player_legs_hide");
  level.player hidelegs();
  scripts\engine\utility::flag_wait("storage_split_player_jumped");
  level.player playSound("ZD30T_basement_split_jump_land_plr_lr");
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::pitch_up_set(88);

  if(isDefined(level.player_rig))
    level.player_rig delete();

  level.scr_model["player_rig"] = "viewhands_alex_fullbody";
  var_2 = level.player getplayerangles();
  var_3 = scripts\engine\utility::getStruct("storage_split_player_orient", "targetname");
  var_4 = anglesToForward(var_2);
  var_5 = vectorNormalize(scripts\engine\utility::flatten_vector(var_3.origin - level.player.origin));
  var_6 = vectordot(var_4, var_5);

  if(var_6 > 0) {
    var_7 = var_1 + "_jump";
    var_8 = 1.85;
    var_9 = 0.05;
    var_10 = 3.15;
    var_11 = 4.9;
  } else {
    var_7 = var_1 + "_jump_back";
    var_8 = 0.5;
    var_9 = 0;
    var_10 = 1.7;
    var_11 = 2.7;
  }

  level.player lerpfovscalefactor(0, 0.8);
  var_12 = 20;
  var_0 scripts\sp\player_rig::link_player_to_rig(var_7, "crouch", undefined, undefined, undefined, var_12, var_12, var_12, var_12, 1);
  waitframe();
  level.player setworldupreferenceangles((274.096, 98.4461, -99.8986));
  scripts\engine\utility::delaythread(var_8, scripts\engine\utility::exploder, "jump_collapse");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::fake_player_damage(var_10, 2);
  level.player scripts\engine\utility::delaycall(var_10, ::playsound, "plr_breath_pain_init");
  level.player scripts\engine\utility::delaycall(var_11, ::playsound, "breathing_better");
  level.player scripts\engine\utility::delaycall(var_9, ::playrumbleonentity, "heavy_1s");
  level.player scripts\engine\utility::delaycall(var_10, ::playrumbleonentity, "heavy_1s");
  playmayhem("mayh_zd30_jump_down");
  thread storage_split_fall_vo();
  var_0 scripts\common\anim::anim_single_solo(level.player_rig, var_7);
  var_0 thread scripts\common\anim::anim_loop_solo(level.player_rig, var_1 + "_jump_idle", "time_to_getup");
  thread hint_to_move();
  var_13 = 18;
  var_14 = 0;

  for(;;) {
    if(level.player getnormalizedmovement()[0] > 0.1) {
      break;
    }

    if(level.player getnormalizedmovement()[1] > 0.1) {
      break;
    }

    if(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::any_input()) {
      break;
    }

    if(var_14 > var_13 && !scripts\engine\utility::flag("storage_split_hint"))
      scripts\engine\utility::flag_set("storage_split_hint");

    var_14 = var_14 + 0.05;
    wait 0.05;
  }

  level notify("storage_split_hint_cancel");
  level.player setworldupreferenceangles((0, 0, 0));
  level.player_rig scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 notify("time_to_getup");
  var_0 scripts\common\anim::anim_single_solo(level.player_rig, var_1 + "_getup");
  level.player_rig hide();
  scripts\sp\player_rig::unlink_player_from_rig(0, "crouch", 1);
  level.player showlegs();
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
}

hint_to_move() {
  level endon("storage_split_hint_cancel");
  scripts\engine\utility::flag_wait("storage_split_hint");
  scripts\engine\sp\utility::display_hint("storage_split_hint", undefined, undefined, level, "storage_split_hint_cancel");
}

storage_split_fall_vo() {
  wait 0.35;
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_far_storage_split_fall_60");
  wait 4;
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_alx_storage_split_fall_70");
  wait 0.3;
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_far_storage_split_fall_80");
  wait 0.25;
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_alx_storage_split_fall_90");
  wait 0.2;
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_far_storage_split_fall_100");
  scripts\engine\utility::flag_set("shaft_split_vo_done");
}

storage_3rd_room_setoff_tripwires() {
  var_0 = getEnt("storage_3rd_room_tripwire_setoff_trig", "script_noteworthy");

  if(isDefined(var_0))
    var_0 notify("trigger", level.player);

  var_1 = getEnt("storage_lmg_buddy", "targetname");

  if(isDefined(var_1))
    var_1 delete();
}

analytics_storage() {
  scripts\engine\utility::flag_wait("player_already_at_split");
  thread scripts\sp\analytics::analytics_kleenex_update("Crates to Ladder Drop");
}

store_farah() {
  var_0 = scripts\engine\utility::getStruct("storage_split_farah", "targetname");
  level.farah forceteleport(var_0.origin, var_0.angles);
  level.farah setgoalpos(level.farah.origin);
  level.farah scripts\common\ai::gun_recall();
  level.farah.ignoreme = 1;
  level.farah.ignoreall = 1;
}