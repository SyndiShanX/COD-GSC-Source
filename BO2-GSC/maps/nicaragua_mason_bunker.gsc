/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_mason_bunker.gsc
*******************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_music;
#include maps\_fxanim;
#include maps\createart\nicaragua_art;
#include maps\_mortar;

skipto_mason_bunker() {
  level.woods = init_hero("woods");
  level.hudson = init_hero("hudson");
  skipto_teleport("player_skipto_mason_bunker", get_heroes());
  sp_redshirt = getent("redshirt_pdf", "script_noteworthy");
  ai_redshirt = simple_spawn_single(sp_redshirt);
  ai_redshirt.takedamage = 0;
  wait 0.1;
  exploder(101);
  exploder(10);
  skipto_teleport_ai("player_skipto_mason_bunker_redshirt", "redshirt_pdf");
  trigger_off("begin_mason_mission_courtyard");
  trigger_off("mason_mission_begin_precourtyard_trigger");
  trigger_use("mason_mission_courtyard_end_colortrigger2");
  flame_vision_enabled();
  flag_init("woods_split_up_enter_started");
  flag_init("pdf_split_up_enter_started");
  setsaveddvar("cg_aggressiveCullRadius", "500");
  model_restore_area("mason_hill_1");
  model_restore_area("mason_hill_2");
  model_restore_area("mason_mission");
  maps\_fxanim::fxanim_reconstruct("fxanim_archway");
  maps\_fxanim::fxanim_reconstruct("fxanim_fountain");
  battlechatter_on("axis");
  level thread load_bunker_gump();
}

init_flags() {
  flag_init("nicaragua_mason_bunker_complete");
  flag_init("bunker_1stroom_alerted");
  flag_init("bunker_2ndroom_alerted");
  flag_init("bunker_2nd_room_clear");
  flag_init("bunker_fire_started");
  flag_init("cocaine_overlay_active");
  flag_init("bunker_table_01_flipped");
  flag_init("bunker_table_03_flipped");
  flag_init("civilian_run_01_begin_anim");
  flag_init("civilian_run_02_begin_anim");
  flag_init("civilian_run_03_begin_anim");
  flag_init("woods_entered_bunker");
  flag_init("pdf_redshirt_entered_bunker");
  flag_init("bunker_woods_initial_VO_complete");
  flag_init("split_up_enter_woods_complete");
  flag_init("split_up_enter_pdf_complete");
  flag_init("bunker_entry_objective");
  flag_init("bunker_entry_objective_remove");
}

main() {
  init_flags();
  level thread nicaragua_mason_bunker_objectives();
  level thread bunker_splitup_anims();
  bunker_setup();
  level thread mason_mission_lockbreaker_perk();
  level thread cia_easter_egg();
  level waittill("mason_entered_bunker");
  bunker_civilian_runs();
  bunker_table_watchers();
  bunker_coke_workers();
  bunker_paper_burners();
  level thread bunker_1stroom_fight();
  level thread bunker_2ndroom_fight();
  bunker_2ndroom_alert_paper_burners();
  flag_wait("bunker_2nd_room_clear");
  flag_set("nicaragua_mason_bunker_complete");
  level notify("nicaragua_mason_bunker_complete");
  flag_wait("nicaragua_mason_bunker_complete");
  bunker_cleanup();
}

load_bunker_gump() {
  load_gump("nicaragua_gump_bunker");
}

nicaragua_mason_bunker_objectives() {
  set_objective(level.obj_mason_bunker);
  flag_wait("bunker_entry_objective");
  set_objective(level.obj_mason_bunker, getstruct("enter_bunker_objective"), "");
  flag_set("player_near_bunker_entrance");
  flag_wait("bunker_entry_objective_remove");
  set_objective(level.obj_mason_bunker, undefined, "remove");
  trigger_wait("mason_bunker_down_hatch");
  set_objective(level.obj_mason_bunker, getstruct("bunker_objective_1"), "");
  trigger_wait("bunker_2ndroom_start_trigger");
  set_objective(level.obj_mason_bunker, undefined, "remove");
  flag_wait("nicaragua_mason_bunker_complete");
  set_objective(level.obj_mason_bunker, undefined, "delete");
  autosave_by_name("Bunker_Complete");
}

mason_mission_lockbreaker_perk() {
  t_open = getent("lockbreaker_perk_trigger", "targetname");
  t_open sethintstring(&"SCRIPT_HINT_LOCK_BREAKER");
  t_open setcursorhint("HINT_NOICON");
  t_open trigger_off();
  level.player waittill_player_has_lock_breaker_perk();
  t_open trigger_on();
  e_volume = getent("lockbreaker_volume", "targetname");
  add_cleanup_ent("mason_bunker_cleanup", e_volume);
  set_objective_perk(level.obj_mason_lockbreaker_perk, t_open, 1024, e_volume);
  t_open waittill("trigger");
  t_open delete();
  remove_objective_perk(level.obj_mason_lockbreaker_perk);
  level thread run_scene("lockbreaker_perk");
  flag_wait("lockbreaker_perk_started");
  e_lockpick = get_model_or_models_from_scene("lockbreaker_perk", "lock_pick");
  e_lockpick setforcenocull();
  scene_wait("lockbreaker_perk");
  level.player giveweapon("machete_sp");
  level.player notify("player_got_machete");
  delete_scene("lockbreaker_perk", 1);
  autosave_by_name("Bunker_Post_Lockbreaker");
}

lockbreaker_door_open() {
  flag_wait("lockbreaker_door_open");
}

lockbreaker_machete_picked_up() {
  flag_wait("lockbreaker_machete_picked_up");
}

bunker_setup() {
  model_restore_area("mason_bunker");
  model_restore_area("mason_final_push");
  trigger_on("mason_mission_end_trigger");
  level thread cocaine_vision_setup();
  level.woods set_ignoreme(1);
  level.woods set_ignoreall(1);
  ai_pdf_redshirt = get_ai("redshirt_pdf", "script_noteworthy");

  if(isalive(ai_pdf_redshirt)) {
    ai_pdf_redshirt set_ignoreme(1);
    ai_pdf_redshirt set_ignoreall(1);
  }

  level.player set_ignoreme(1);
  a_sp_spawners1 = getentarray("bunker_1st_room_coke_worker", "script_noteworthy");
  a_sp_spawners2 = getentarray("bunker_civilian_runner", "script_noteworthy");
  a_sp_spawners = arraycombine(a_sp_spawners1, a_sp_spawners2, 0, 0);

  foreach(spawner in a_sp_spawners)
  spawner add_spawn_function(::ai_set_allow_friendly_fire);

  level thread bunker_cocaine_fog();
  level thread run_scene("bunker_tables_idle");
  bunker_table_clip_setup();
  add_spawn_function_ai_group("bunker_1st_room", ::bunker_waittill_player_near);
  add_spawn_function_ai_group("bunker_1st_room", ::bunker_waittill_enemy_alerted);
  level thread bunker_ambient_mortars();
  level thread fake_destructible_blue_bowl();
  a_e_lights = getentarray("firelight_bunker", "targetname");

  foreach(light in a_e_lights)
  light setlightintensity(5.0);

  a_nd_table1 = getnodearray("post_table1_kick", "script_noteworthy");

  foreach(node in a_nd_table1)
  setenablenode(node, 0);

  a_nd_table3 = getnodearray("post_table3_kick", "script_noteworthy");

  foreach(node in a_nd_table3)
  setenablenode(node, 0);

  e_trigger = getent("mason_bunker_firetrigger", "targetname");

  if(isDefined(e_trigger))
    e_trigger trigger_off();

  add_cleanup_ent("mason_bunker_cleanup", undefined);
  clientnotify("bunker_lightflares_on");
}

bunker_table_clip_setup() {
  e_clip1 = getent("cartel_tabel_clip_01", "targetname");
  e_table1 = getent("bunker_cartel_tabel_01", "targetname");
  e_clip1 linkto(e_table1);
  e_clip3 = getent("cartel_tabel_clip_03", "targetname");
  e_table3 = getent("bunker_cartel_tabel_03", "targetname");
  e_clip3 linkto(e_table3);
}

bunker_cocaine_fog() {
  level endon("player_left_bunker");
  n_count = 0;

  while(true) {
    level waittill("cocaine_fog");
    n_count++;

    if(n_count >= 1) {
      exploder(660);
      return;
    }
  }
}

fake_destructible_blue_bowl() {
  level endon("player_left_bunker");
  e_bowl = getent("cocaine_bowl", "targetname");
  add_cleanup_ent("mason_bunker_cleanup", e_bowl);
  e_cocaine = getent("cocaine_bowl_cocaine", "targetname");
  s_origin = getstruct("cocaine_bowl_struct", "targetname");
  trigger_wait("cocaine_bowl_damage_trigger");
  n_x = randomfloatrange(-2.5, 2.5);
  n_y = randomfloatrange(-2.5, 2.5);
  n_z = randomfloatrange(1.0, 2.5);
  e_bowl physicslaunch(e_bowl.origin, (n_x, n_y, n_z));
  physicsexplosioncylinder(e_bowl.origin, 16, 1, 1);
  play_fx("cocaine_powder", s_origin.origin);
  level notify("cocaine_fog");
  e_cocaine delete();
}

bunker_splitup_anims() {
  ai_redshirt = get_ai("redshirt_pdf", "script_noteworthy");
  level thread splitup_start_objective();

  if(!flag("woods_split_up_enter_started"))
    level.woods thread run_split_up_woods_enter_scene();

  if(!flag("pdf_split_up_enter_started"))
    ai_redshirt thread run_split_up_pdf_enter_scene();

  scene_wait("split_up_enter_woods");
  scene_wait("split_up_enter_pdf");
  flag_wait("split_up_start_idle_woods_started");
  flag_wait("split_up_start_idle_pdf_started");
  flag_wait("nicaragua_gump_bunker");
  level notify("begin_split_up_climb_down");
  level thread run_scene("split_up_climb_down");
  ai_redshirt set_force_color("o");
  trigger_use("mason_bunker_start_colortrigger");
  scene_wait("split_up_climb_down");
  ai_redshirt thread ai_buddies_enter_bunker();
  level.woods thread ai_buddies_enter_bunker();

  for(n_count = 0; n_count < 2; n_count++)
    level waittill("buddy_down_hatch");

  e_clip = getent("bunker_entrance_clip", "targetname");
  e_clip delete();
  flag_set("bunker_entry_objective");
  trigger_wait("bunker_entry_trigger");
  flag_set("bunker_entry_objective_remove");
  level.hudson lookatentity();
  run_scene("bunker_enter");
  level notify("mason_entered_bunker");

  if(!flag("player_got_mortars"))
    remove_objective_perk(level.obj_mason_bruteforce_perk);

  level thread run_scene("close_hatch");
  level thread mason_bunker_point_of_no_return_cleanup();
  autosave_by_name("Bunker_Post_Dropdown");
  trigger_wait("mason_bunker_down_hatch");
  level thread bunker_vo();
}

run_split_up_woods_enter_scene() {
  flag_set("woods_split_up_enter_started");
  run_scene("split_up_enter_woods");
  level thread run_scene("split_up_start_idle_woods");
  scene_wait("split_up_start_idle_woods");
  flag_set("split_up_enter_woods_complete");

  while(!flag("nicaragua_gump_bunker"))
    run_scene("split_up_start_idle_woods");
}

run_split_up_pdf_enter_scene() {
  flag_set("pdf_split_up_enter_started");
  run_scene("split_up_enter_pdf");
  level thread run_scene("split_up_start_idle_pdf");
  scene_wait("split_up_start_idle_pdf");
  flag_set("split_up_enter_pdf_complete");

  while(!flag("nicaragua_gump_bunker"))
    run_scene("split_up_start_idle_pdf");
}

splitup_start_objective() {
  s_struct = getstruct("bunker_entrance_struct", "targetname");
  set_objective(level.obj_mason_bunker_entrance, s_struct, "");
  flag_wait("player_near_bunker_entrance");
  set_objective(level.obj_mason_bunker_entrance, undefined, "delete");
  s_struct structdelete();
}

split_up_door_kick(e_redshirt) {
  level.player rumble_loop(2, 0.5, "damage_light");
  e_clip = getent("bunker_entry_clip", "targetname");
  e_clip trigger_off();
  e_clip connectpaths();
  e_clip delete();
}

ai_buddies_enter_bunker() {
  self endon("death");
  trigger_wait("ai_buddies_down_hatch", "targetname", self);
  level notify("buddy_down_hatch");
}

bunker_civilian_runs() {
  level thread bunker_civilian_run_01();
  level thread bunker_civilian_run_02();
  level thread bunker_civilian_run_03();
}

bunker_civilian_run_01() {
  e_brick = getent("bunker_cocaine_run_brick01", "targetname");
  add_cleanup_ent("mason_bunker_cleanup", e_brick);
  sp_spawner = getent("bunker_civilian_run_01", "targetname");

  while(!flag("bunker_1stroom_alerted")) {
    wait(randomfloatrange(1.0, 3.0));
    level thread run_scene("bunker_civilian_run_01");
    flag_wait("civilian_run_01_begin_anim");
    ai_civ = get_ais_from_scene("bunker_civilian_run_01", "bunker_civilian_run_01");
    ai_civ.cocaine_brick = e_brick;
    wait 0.1;
    e_brick linkto(ai_civ, "TAG_WEAPON_LEFT", (0, 0, 0), (0, 0, 0));
    e_brick show();
    ai_civ.deathfunction = ::bunker_civilian_run_drops_cocaine;
    scene_wait("bunker_civilian_run_01");

    if(flag("bunker_1stroom_alerted")) {
      ai_civ bloody_death();
      return;
    }

    e_brick unlink();
    e_brick hide();
    ai_civ.deathfunction = undefined;
    flag_clear("civilian_run_01_begin_anim");
    ai_civ notify("civilian_deleted");
    ai_civ delete_ais_from_scene("bunker_civilian_run_01");
    sp_spawner.count++;
    ai_civ = undefined;
  }
}

bunker_table_civilian_run_01_begin_anim(e_guy) {
  flag_set("civilian_run_01_begin_anim");
}

bunker_civilian_run_02() {
  sp_spawner = getent("bunker_civilian_run_02", "targetname");

  while(!flag("bunker_1stroom_alerted")) {
    level thread run_scene("bunker_civilian_run_02");
    flag_wait("civilian_run_02_begin_anim");
    ai_civ = get_ais_from_scene("bunker_civilian_run_02", "bunker_civilian_run_02");
    scene_wait("bunker_civilian_run_02");

    if(flag("bunker_1stroom_alerted")) {
      ai_civ bloody_death();
      return;
    }

    flag_clear("civilian_run_02_begin_anim");
    ai_civ notify("civilian_deleted");
    ai_civ delete();
    wait(randomfloatrange(1.0, 3.0));
    sp_spawner.count++;
    ai_civ = undefined;
  }
}

bunker_table_civilian_run_02_begin_anim(e_guy) {
  flag_set("civilian_run_02_begin_anim");
}

bunker_civilian_run_03() {
  e_brick = getent("bunker_cocaine_run_brick03", "targetname");
  sp_spawner = getent("bunker_civilian_run_03", "targetname");

  while(!flag("bunker_1stroom_alerted")) {
    level thread run_scene("bunker_civilian_run_03");
    flag_wait("civilian_run_03_begin_anim");
    ai_civ = get_ais_from_scene("bunker_civilian_run_03", "bunker_civilian_run_03");
    ai_civ.cocaine_brick = e_brick;
    scene_wait("bunker_civilian_run_03");

    if(flag("bunker_1stroom_alerted")) {
      ai_civ bloody_death();
      return;
    }

    e_brick unlink();
    e_brick hide();
    ai_civ.deathfunction = undefined;
    flag_clear("civilian_run_03_begin_anim");
    ai_civ notify("civilian_deleted");
    ai_civ delete();
    sp_spawner.count++;
    ai_civ = undefined;
    wait(randomfloatrange(0.5, 4.0));
  }
}

bunker_table_civilian_run_03_begin_anim(e_guy) {
  flag_set("civilian_run_03_begin_anim");
}

bunker_table_civilian_run_03_attach_cocaine(e_guy) {
  e_guy.cocaine_brick linkto(e_guy, "TAG_WEAPON_LEFT", (0, 0, 0), (0, 0, 0));
  e_guy.cocaine_brick show();
  e_guy.deathfunction = ::bunker_civilian_run_drops_cocaine;
}

bunker_civilian_run_drops_cocaine() {
  self.cocaine_brick stopanimscripted();
  self.cocaine_brick unlink();
  self.cocaine_brick physicslaunch(self.cocaine_brick.origin, (0, 0, 1));
  self.cocaine_brick = undefined;
  return false;
}

bunker_table_watchers() {
  ai_cartel_frantic = simple_spawn_single("bunker_cartel_frantic");

  while(!isDefined(ai_cartel_frantic))
    wait 0.05;

  ai_cartel_frantic thread bunker_cartel_frantic();
  ai_table_watch_01 = simple_spawn_single("bunker_cartel_table_watch01");

  while(!isDefined(ai_table_watch_01))
    wait 0.05;

  ai_table_watch_01 thread bunker_cartel_table_watch01();
  ai_table_watch_02 = simple_spawn_single("bunker_cartel_table_watch02");

  while(!isDefined(ai_table_watch_02))
    wait 0.05;

  ai_table_watch_02 thread bunker_cartel_table_watch02();
  ai_table_watch_03 = simple_spawn_single("bunker_cartel_table_watch03");

  while(!isDefined(ai_table_watch_03))
    wait 0.05;

  ai_table_watch_03 thread bunker_cartel_table_watch03();
}

bunker_cartel_frantic() {
  self endon("death");
  wait(randomfloatrange(0.0, 2.0));

  while(!flag("bunker_1stroom_alerted")) {
    add_generic_ai_to_scene(self, "bunker_cartel_frantic");
    run_scene("bunker_cartel_frantic");
  }

  add_generic_ai_to_scene(self, "bunker_cartel_frantic_reaction");
  run_scene("bunker_cartel_frantic_reaction");
  self notify("table_watch_reaction_complete");
}

bunker_cartel_table_watch01() {
  self endon("death");
  wait(randomfloatrange(0.0, 2.0));

  while(!flag("bunker_1stroom_alerted")) {
    add_generic_ai_to_scene(self, "bunker_cartel_table_watch01");
    run_scene("bunker_cartel_table_watch01");
  }

  add_generic_ai_to_scene(self, "bunker_cartel_table_watch01_reaction");
  run_scene("bunker_cartel_table_watch01_reaction");
  self notify("table_watch_reaction_complete");
}

bunker_cartel_table_watch02() {
  self endon("death");
  wait(randomfloatrange(0.0, 2.0));

  while(!flag("bunker_1stroom_alerted")) {
    add_generic_ai_to_scene(self, "bunker_cartel_table_watch02");
    run_scene("bunker_cartel_table_watch02");
  }

  add_generic_ai_to_scene(self, "bunker_cartel_table_watch02_reaction");
  run_scene("bunker_cartel_table_watch02_reaction");
  self notify("table_watch_reaction_complete");
}

bunker_cartel_table_watch03() {
  self endon("death");
  wait(randomfloatrange(0.0, 2.0));

  while(!flag("bunker_1stroom_alerted")) {
    add_generic_ai_to_scene(self, "bunker_cartel_table_watch03");
    run_scene("bunker_cartel_table_watch03");
  }

  add_generic_ai_to_scene(self, "bunker_cartel_table_watch03_reaction");
  run_scene("bunker_cartel_table_watch03_reaction");
  self notify("table_watch_reaction_complete");
}

bunker_coke_workers() {
  for(i = 1; i < 6; i++) {
    if(i == 3) {
      continue;
    }
    level thread run_scene("bunker_coke_worker_" + i);
  }
}

bunker_waittill_player_near() {
  self endon("death");
  level endon("player_left_bunker");
  level waittill_any("bunker_player_near", "bunker_1stroom_alerted");
  self notify("bunker_player_near");
}

bunker_waittill_enemy_alerted() {
  self endon("civilian_deleted");
  self waittill_any("damage", "death", "bulletwhizby", "bunker_player_near", "bunker_alerted");

  if(!flag("bunker_1stroom_alerted")) {
    flag_set("bunker_1stroom_alerted");
    level notify("bunker_1stroom_alerted");
    a_ai_cartel = getaiarray("axis", "neutral");

    foreach(guy in a_ai_cartel)
    guy notify("bunker_alerted");

    level.woods thread woods_kicks_off_coke_fog();
  }

  self bunker_enemy_alerted();
}

bunker_enemy_alerted() {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  self set_ignoreme(0);

  if(self.script_noteworthy == "bunker_1st_room_coke_worker")
    self thread coke_worker_run_away_and_die();
  else if(self.script_noteworthy == "cartel_table_watcher")
    self thread bunker_patroller_play_table_kick();
}

coke_worker_run_away_and_die() {
  self endon("death");
  self.deathfunction = ::coke_worker_died;
  wait(randomfloatrange(0.2, 1.25));
  run_scene(self.animname + "_react");
  self.goalradius = 48;
  self thread timebomb(5.0, 10.0);
}

coke_worker_died() {
  level notify("civilian_coke_worker_died");
  return false;
}

bunker_patroller_play_table_kick() {
  self endon("death");
  self set_ignoreall(0);
  self.goalradius = 1536;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "cartel_table_watcher") {
    self waittill("table_watch_reaction_complete");
    wait(randomfloatrange(0.1, 3.0));
  }

  self.animname = self.targetname;

  if(issubstr(self.targetname, "1")) {
    self.goalradius = 32;
    nd_goal = getnode("bunker_table_node_1", "targetname");
    self setgoalnode(nd_goal);
    self waittill_any("goal", "near_goal");
    level thread run_scene("bunker_table_kick_1");
  } else if(issubstr(self.targetname, "2"))
    return;
  else if(issubstr(self.targetname, "3")) {
    self.goalradius = 32;
    nd_goal = getnode("bunker_table_node_3", "targetname");
    self setgoalnode(nd_goal);
    self waittill_any("goal", "near_goal");
    level thread run_scene("bunker_table_kick_2");
  }
}

bunker_table_kick_1_deathfunction() {
  if(!flag("bunker_table_01_flipped")) {
  }

  return false;
}

bunker_table_kick_2_deathfunction() {
  if(!flag("bunker_table_03_flipped")) {
  }

  return false;
}

pick_new_ai_table_kick_1() {
  level endon("bunker_midpoint_set");
  wait(randomfloatrange(3.0, 5.0));
  a_ai = get_ai_group_ai("bunker_1st_room_reinforcements");

  while(true) {
    a_ai = array_removedead(a_ai);

    if(a_ai.size > 1)
      n_index = randomintrange(0, a_ai.size - 1);
    else if(a_ai.size == 1)
      n_index = 0;
    else
      return;

    ai_guy = a_ai[n_index];

    if(isalive(ai_guy)) {
      break;
    }

    wait 0.05;
  }

  ai_guy.targetname = "bunker_cartel_table_watch01_ai";
  ai_guy thread bunker_patroller_play_table_kick();
}

pick_new_ai_table_kick_2() {
  level endon("bunker_midpoint_set");
  wait(randomfloatrange(3.0, 5.0));
  a_ai = get_ai_group_ai("bunker_1st_room_reinforcements");

  while(true) {
    a_ai = array_removedead(a_ai);

    if(a_ai.size > 1)
      n_index = randomintrange(0, a_ai.size - 1);
    else if(a_ai.size == 1)
      n_index = 0;
    else
      return;

    ai_guy = a_ai[n_index];

    if(isalive(ai_guy)) {
      break;
    }

    wait 0.05;
  }

  ai_guy.targetname = "bunker_cartel_table_watch03_ai";
  ai_guy thread bunker_patroller_play_table_kick();
}

bunker_table_flipped_01(e_table) {
  flag_set("bunker_table_01_flipped");
  s_org = getstruct("bunker_tabel_01_physics_pulse", "targetname");
  physicsjolt(s_org.origin, 40, 8, (-1, 0.01, 1));
  a_nd_table1 = getnodearray("post_table1_kick", "script_noteworthy");

  foreach(node in a_nd_table1)
  setenablenode(node, 1);

  nd_old = getnode("bunker_table_node_1", "targetname");
  setenablenode(nd_old, 0);
}

bunker_table_flipped_03(e_table) {
  flag_set("bunker_table_03_flipped");
  e_coke = getent("cokepile", "targetname");
  add_cleanup_ent("mason_bunker_cleanup", e_coke);
  s_org = getstruct("bunker_tabel_03_physics_pulse", "targetname");
  physicsjolt(s_org.origin, 46, 8, (-1, 0.01, 1));
  play_fx("cocaine_powder", e_coke.origin);
  level notify("cocaine_fog");
  e_coke delete();
  a_nd_table3 = getnodearray("post_table3_kick", "script_noteworthy");

  foreach(node in a_nd_table3)
  setenablenode(node, 1);

  nd_old = getnode("bunker_table_node_3", "targetname");
  setenablenode(nd_old, 0);
}

woods_kicks_off_coke_fog() {
  e_origin = getent("fake_coke_shot", "targetname");
  e_origin.health = 100;
  add_cleanup_ent("mason_bunker_cleanup", e_origin);
  self shoot_at_target(e_origin, undefined, undefined, 2.0);
  radiusdamage(e_origin.origin, 8, 100, 90);
}

bunker_1stroom_fight() {
  trigger_off("bunker_1stroom_rightside_trigger");
  flag_wait("bunker_1stroom_alerted");
  level thread bunker_1stroom_sidepassage_near();
  level thread bunker_1stroom_sidepassage();
  level thread clear_bunker_1st_room_enemies();
  level thread replace_coke_worker_with_enemy();
  level.woods set_ignoreme(0);
  level.woods set_ignoreall(0);
  ai_pdf_redshirt = get_ai("redshirt_pdf", "script_noteworthy");

  if(isalive(ai_pdf_redshirt)) {
    ai_pdf_redshirt set_ignoreme(0);
    ai_pdf_redshirt set_ignoreall(0);
    ai_pdf_redshirt.takedamage = 1;
  }

  level.player set_ignoreme(0);
  simple_spawn("bunker_1stroom_reinforcements");
  wait 0.1;
  spawn_manager_enable("bunker_1stroom_reinforcements_sm2");
  waittill_spawn_manager_complete("bunker_1stroom_reinforcements_sm2");
  spawn_manager_enable("bunker_1stroom_reinforcements_sm");
  mason_bunker_make_shotgunners_agressive();
  level thread check_bunker_1st_room_enemies();
  level thread move_friendlies_up_to_mid_bunker();
  trigger_use("mason_bunker_colortrigger1");
  trigger_wait("bunker_mid_trigger");
  a_sp_midguys = getentarray("bunker_1stroom_end_reinforcements", "targetname");
  simple_spawn(a_sp_midguys);
}

bunker_1stroom_sidepassage_near() {
  level endon("bunker_midpoint_set");
  trigger_wait("bunker_sidepassage_near");
  simple_spawn("bunker_1stroom_sidepassage_near_reinforcements");
  level thread check_bunker_1st_room_enemies();
}

bunker_1stroom_sidepassage() {
  level endon("bunker_midpoint_set");
  trigger_on("bunker_1stroom_rightside_trigger");
  trigger_wait("bunker_1stroom_rightside_trigger");
  simple_spawn("bunker_1stroom_sidepassage_reinforcements");
  level thread check_bunker_1st_room_enemies();
}

bunker_1stroom_retreat() {
  trigger_wait("mason_bunker_first_room_retreat_trigger");

  if(!flag("bunker_midpoint"))
    trigger_use("mason_bunker_colortrigger2");

  e_goalvolume = getent("bunker_1stroom_back_goalvolume", "targetname");
  a_ai_enemies = getaiarray("axis");

  foreach(guy in a_ai_enemies) {
    if(isDefined(guy.script_aigroup) && issubstr(guy.script_aigroup, "1st_room"))
      guy setgoalvolumeauto(e_goalvolume);
  }
}

move_friendlies_up_to_mid_bunker() {
  flag_wait("bunker_midpoint");
  trigger_use("mason_bunker_colortrigger3");
}

mason_bunker_make_shotgunners_agressive() {
  a_ai_enemies = getaiarray("axis");

  foreach(guy in a_ai_enemies) {
    if(issubstr(guy.classname, "Shotgun"))
      self make_ai_aggressive();
  }
}

check_bunker_1st_room_enemies() {
  level notify("checking_mason_bunker_1st_room_enemies");
  self endon("checking_mason_bunker_1st_room_enemies");
  a_ai_1 = get_ai_group_ai("bunker_1st_room");
  a_ai_2 = get_ai_group_ai("bunker_1st_room_reinforcements");
  a_ai = arraycombine(a_ai_1, a_ai_2, 0, 0);
  waittill_dead_or_dying(a_ai, a_ai.size - 1);
  flag_set("bunker_midpoint");
  level notify("bunker_midpoint_set");
}

clear_bunker_1st_room_enemies() {
  trigger_wait("bunker_2ndroom_start_trigger");
  a_ai_cartel = getaiarray("axis");

  foreach(guy in a_ai_cartel) {
    if(isDefined(guy.script_aigroup) && !issubstr(guy.script_aigroup, "2nd_room"))
      guy thread timebomb(0.25, 3.0);
  }
}

replace_coke_worker_with_enemy() {
  level endon("nicaragua_mason_bunker_complete");

  for(i = 0; i < 6; i++) {
    level waittill("civilian_coke_worker_died");
    simple_spawn_single("bunker_1stroom_civilian_replacements");
  }
}

bunker_2ndroom_fight() {
  trigger_wait("bunker_mid_trigger");
  autosave_by_name("Mason_Bunker_MidPoint");
  spawn_manager_enable("bunker_2ndroom_reinforcements_sm");
  waittill_spawn_manager_complete("bunker_2ndroom_reinforcements_sm");
  level thread check_bunker_clear();
  trigger_wait("bunker_2ndroom_buddies_moveup");
  trigger_use("mason_bunker_colortrigger4");
}

bunker_2ndroom_alert_paper_burners() {
  trigger_wait("bunker_2ndroom_start_trigger");

  for(i = 1; i < 3; i++) {
    ai_guy = get_ais_from_scene("bunker_paper_burner_" + i, "bunker_paper_burner_" + i);

    if(isDefined(ai_guy) && isalive(ai_guy))
      ai_guy thread end_bunker_paper_burner_scenes(i);
  }

  level notify("paper_burners_react");
  flag_set("bunker_2ndroom_alerted");
}

bunker_paper_burners() {
  level thread run_scene("bunker_paper_burner_1");
  level thread run_scene("bunker_paper_burner_2");
  flag_wait("bunker_paper_burner_1_started");
  flag_wait("bunker_paper_burner_2_started");
  ai_paper_burner_1 = get_ais_from_scene("bunker_paper_burner_1", "bunker_paper_burner_1");
  ai_paper_burner_1.deathfunction = ::paper_burner_1_deathfunction;
  ai_paper_burner_2 = get_ais_from_scene("bunker_paper_burner_2", "bunker_paper_burner_2");
  ai_paper_burner_2.deathfunction = ::paper_burner_2_deathfunction;
  a_ai_paperburners[0] = ai_paper_burner_1;
  a_ai_paperburners[1] = ai_paper_burner_2;
  level thread bunker_2ndroom_fire_failsafe(a_ai_paperburners);
  level thread paper_burner_gas_can_fx();
}

paper_burner_1_deathfunction() {
  e_box = get_model_or_models_from_scene("bunker_paper_burner_1", "evidence_box");
  e_box stopanimscripted();
  e_box physicslaunch(e_box.origin, vectorscale((0, 0, 1), 0.5));
  level notify("bunker_1stroom_alerted");
  return false;
}

paper_burner_2_deathfunction() {
  gascan_drop(self);
  match_flame(undefined);
  level notify("bunker_1stroom_alerted");
  return false;
}

bunker_2ndroom_fire_failsafe(a_ai_guys) {
  level endon("paper_burners_react");
  waittill_dead(a_ai_guys, 1);
  match_flame(undefined);
}

paper_toss(e_guy) {
  m_box = get_model_or_models_from_scene("bunker_paper_burner_1", "evidence_box");
  m_box play_fx("fx_paper_spill_os", m_box.origin);
}

paper_burner_gas_can_fx() {
  level endon("paper_burner_dropped_gascan");
  m_gascan = get_model_or_models_from_scene("bunker_paper_burner_2", "evidence_gascan");

  while(true) {
    v_org = m_gascan gettagorigin("tag_origin");
    v_ang = m_gascan gettagangles("tag_origin");
    m_gascan play_fx("fx_gas_can_spill", v_org, v_ang, 2.0);
    wait 0.1;
  }
}

end_bunker_paper_burner_scenes(n_index) {
  self endon("death");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  run_scene("bunker_paper_burner_" + n_index + "_react");
  self set_ignoreme(0);
  self set_ignoreall(0);
}

gascan_drop(e_guy) {
  level notify("paper_burner_dropped_gascan");
  e_gascan = get_model_or_models_from_scene("bunker_paper_burner_2", "evidence_gascan");
  e_gascan stopanimscripted();
  e_gascan physicslaunch(e_gascan.origin, vectorscale((0, 0, 1), 0.5));
}

match_flame(e_guy) {
  if(!flag("bunker_fire_started")) {
    exploder(668);
    level clientnotify("frs_on");
    flag_set("bunker_fire_started");
    level thread bunker_fire_timer();
    e_trigger = getent("mason_bunker_firetrigger", "targetname");

    if(isDefined(e_trigger))
      e_trigger trigger_on();
  }
}

check_bunker_clear() {
  a_ai_rearbunker = get_ai_group_ai("bunker_2nd_room");
  level thread check_bunker_near_clear(a_ai_rearbunker);
  waittill_dead_or_dying(a_ai_rearbunker);
  wait 2.0;
  flag_set("bunker_2nd_room_clear");
}

check_bunker_near_clear(a_ai_rearbunker) {
  if(a_ai_rearbunker.size <= 2) {
    return;
  }
  waittill_dead_or_dying(a_ai_rearbunker, a_ai_rearbunker.size - 2);
  a_ai_rearbunker = array_removedead(a_ai_rearbunker);

  foreach(guy in a_ai_rearbunker) {
    if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == "bunker_2nd_room_end")
      continue;
    else
      return;
  }

  trigger_use("mason_bunker_colortrigger5");
}

cia_easter_egg() {
  level endon("player_left_bunker");
  e_cia_card = getent("easteregg_cia_card", "targetname");
  t_cia = getent("bunker_CIA_pickup", "targetname");
  level endon("cia_easter_egg_timer_expired");
  t_cia sethintstring(&"NICARAGUA_CIA");
  t_cia waittill("trigger");
  level notify("cia_easter_egg_success");
  level.player set_story_stat("FOUND_NICARAGUA_EASTEREGG", 1);
  level.player thread cia_easter_egg_vo();
  e_cia_card delete();
  t_cia end_cia_easter_egg();
}

bunker_fire_timer() {
  level endon("player_left_bunker");
  level endon("cia_easter_egg_success");
  wait 60.0;
  level notify("cia_easter_egg_timer_expired");
  t_cia = getent("bunker_CIA_pickup", "targetname");
  t_cia end_cia_easter_egg();
  exploder(669);
  wait 0.1;
  e_cia_card = getent("easteregg_cia_card", "targetname");
  e_cia_card delete();
}

end_cia_easter_egg() {
  self trigger_off();
  set_objective(level.obj_cia_easter_egg, self, "remove");
  self delete();
}

bunker_vo() {
  level thread bunker_combat_started_vo();
  level.woods queue_dialog("wood_let_s_make_this_quic_0");
  flag_set("bunker_woods_initial_VO_complete");
  level thread bunker_coke_worker_vo();
}

bunker_coke_worker_vo() {
  level endon("bunker_1stroom_alerted");
  queue_dialog_enemy("crt0_pack_up_we_re_leav_0", 0, undefined, "bunker_1stroom_alerted");
  queue_dialog_enemy("crt1_we_heard_gunfire_w_0", 0, undefined, "bunker_1stroom_alerted");
  queue_dialog_enemy("crt0_foreign_soldiers_are_0", 0, undefined, "bunker_1stroom_alerted");
  queue_dialog_enemy("crt2_we_can_t_carry_it_al_0", 0, undefined, "bunker_1stroom_alerted");
  queue_dialog_enemy("crt0_what_we_can_t_carry_0", 0, undefined, "bunker_1stroom_alerted");
  queue_dialog_enemy("crt1_quickly_0", 0, undefined, "bunker_1stroom_alerted");
}

bunker_combat_started_vo() {
  a_start_flags = [];
  a_start_flags[0] = "bunker_woods_initial_VO_complete";
  a_start_flags[1] = "bunker_1stroom_alerted";
  queue_dialog_enemy("crt0_enemy_soldiers_0", 0, a_start_flags);
  queue_dialog_enemy("crt1_return_fire_0", 0, a_start_flags);
  queue_dialog_enemy("crt2_get_out_of_here_mo_0", 0, a_start_flags);
  level thread bunker_2ndroom_vo();
}

bunker_2ndroom_vo() {
  trigger_wait("bunker_2ndroom_start_trigger");
  level.woods queue_dialog("wood_hurry_it_up_mason_0");
}

cia_easter_egg_vo() {
  if(is_mature())
    self queue_dialog("maso_what_the_fuck_ci_0");
  else
    self queue_dialog("maso_what_the_cia_0");
}

mason_bunker_point_of_no_return_cleanup() {
  fxanim_deconstructions_for_mason_side2();
  delete_exploder(10326);
  model_delete_area("mason_hill_1");
  model_delete_area("mason_hill_2");
  model_delete_area("mason_mission");
  level notify("mason_fire_damage_OFF");
}

bunker_cleanup() {
  delete_scene("split_up_hudson_idle", 1);
  delete_scene("split_up_pdf_02_idle", 1);
  delete_scene("split_up_pdf_03_idle", 1);
  delete_scene("split_up_enter_woods", 1);
  delete_scene("split_up_enter_pdf", 1);
  delete_scene("split_up_start_idle_woods", 1);
  delete_scene("split_up_start_idle_pdf", 1);
  delete_scene("split_up_climb_down", 1);
  delete_scene("bunker_enter", 1);
  delete_scene("close_hatch", 1);
  delete_scene("bunker_coke_worker_1", 1);
  delete_scene("bunker_coke_worker_2", 1);
  delete_scene("bunker_coke_worker_4", 1);
  delete_scene("bunker_coke_worker_5", 1);
  delete_scene("bunker_coke_worker_1_react", 1);
  delete_scene("bunker_coke_worker_2_react", 1);
  delete_scene("bunker_coke_worker_4_react", 1);
  delete_scene("bunker_coke_worker_5_react", 1);
  delete_scene("bunker_table_kick_1", 1);
  delete_scene("bunker_table_kick_2", 1);
  delete_scene("bunker_civilian_run_01", 1);
  delete_scene("bunker_civilian_run_02", 1);
  delete_scene("bunker_civilian_run_03", 1);
  delete_scene("bunker_cartel_frantic", 1);
  delete_scene("bunker_cartel_frantic_reaction", 1);
  delete_scene("bunker_cartel_table_watch01", 1);
  delete_scene("bunker_cartel_table_watch01_reaction", 1);
  delete_scene("bunker_cartel_table_watch02", 1);
  delete_scene("bunker_cartel_table_watch02_reaction", 1);
  delete_scene("bunker_cartel_table_watch03", 1);
  delete_scene("bunker_cartel_table_watch03_reaction", 1);
  delete_scene("bunker_paper_burner_1", 1);
  delete_scene("bunker_paper_burner_2", 1);
  delete_scene("bunker_paper_burner_1_react", 1);
  delete_scene("bunker_paper_burner_2_react", 1);
  kill_spawnernum(16);
  cleanup_ents("mason_bunker_cleanup");
}

bunker_ambient_mortars() {
  level endon("player_left_bunker");
  level waittill("mason_entered_bunker");
  level.player thread bunker_mortar_swinging_lights();
  level thread maps\createart\nicaragua_art::bunker_exposure_scale();
  level thread setup_bunker_lookat_physics_pulses();
  t_room1 = getent("bunker_mortars_room1", "targetname");
  t_room2 = getent("bunker_mortars_room2", "targetname");
  level.player thread bunker_mortar_dust_fx(t_room1, t_room2);
  a_s_mortarspots = getstructarray("mason_bunker_mortar", "targetname");

  while(true) {
    wait(randomfloatrange(5.0, 17.5));
    n_index = randomintrange(0, a_s_mortarspots.size - 1);
    s_spot = a_s_mortarspots[n_index];
    s_spot maps\_mortar::explosion_boom("mason_bunker_mortar", 0.25, undefined, 1536, 1);
    level notify("mason_bunker_fake_mortar");
  }
}

bunker_mortar_swinging_lights() {
  level endon("player_left_bunker");
  a_s_lights = getstructarray("mason_bunker_light", "targetname");

  while(true) {
    level waittill("mason_bunker_fake_mortar");

    foreach(light in a_s_lights) {
      if(self is_looking_at(light.origin)) {
        n_x = randomfloatrange(-0.25, 0.25);
        n_y = randomfloatrange(-0.25, 0.25);
        n_z = randomfloatrange(-0.25, 0.25);
        physicsjolt(light.origin, 16, 1, (n_x, n_y, n_z));
      }
    }
  }
}

bunker_mortar_dust_fx(t_room1, t_room2) {
  level endon("player_left_bunker");

  while(true) {
    level waittill("mason_bunker_fake_mortar");

    if(self istouching(t_room1))
      exploder(665);
    else if(self istouching(t_room2))
      exploder(666);
  }
}

setup_bunker_lookat_physics_pulses() {
  for(i = 1; i < 18; i++)
    level thread bunker_lookat_physics_pulse("mason_bunker_physics_lookat_" + i);
}

bunker_lookat_physics_pulse(str_flag) {
  level endon("player_left_bunker");

  while(true) {
    level waittill("mason_bunker_fake_mortar");

    if(flag(str_flag)) {
      s_struct = getstruct(str_flag, "targetname");
      n_x = randomfloatrange(-0.15, 0.15);
      n_y = randomfloatrange(-0.15, 0.15);
      n_z = randomfloatrange(0.0, 0.15);
      physicsjolt(s_struct.origin, 32, 0.1, (n_x, n_y, n_z));
    }
  }
}

cocaine_vision_setup() {
  a_destructibles = getentarray("destructible", "targetname");

  foreach(object in a_destructibles) {
    if(object.destructibledef == "fxdest_accessories_cocaine")
      object thread coke_bundle_destroyed();
  }

  level.player thread cocaine_vision_think();
}

coke_bundle_destroyed() {
  level endon("player_left_bunker");
  self waittill("broken");
  level notify("cocaine_fog");
  level notify("coke_bundle_destroyed", self.origin);
}

cocaine_vision_think() {
  level endon("player_left_bunker");
  n_full_fadein_time = 1;
  n_fadeout_time = 2;
  n_wait_time = 4;
  hud = undefined;

  while(true) {
    level waittill("coke_bundle_destroyed", n_coke_origin);
    n_dist = distance2d(self.origin, n_coke_origin);
    n_alpha = linear_map(n_dist, 384, 1, 0, 1);

    if(n_dist > 384) {
      continue;
    }
    if(!flag("cocaine_overlay_active"))
      flag_set("cocaine_overlay_active");
    else if(n_alpha > level.fade_hud.alpha) {
      level.fade_hud notify("coke_vision_retrigger");
      n_partial_fadein_time = (n_alpha - level.fade_hud.alpha) * n_full_fadein_time;
      level.fade_hud thread coke_vision_fade_in_and_out(n_partial_fadein_time, n_fadeout_time, n_wait_time, n_alpha);
      continue;
    }

    if(!isDefined(hud)) {
      hud = get_fade_hud("overlay_cocaine");
      hud.alpha = 0;
      hud.foreground = 0;
      n_fadein_time = n_alpha * n_full_fadein_time;
      hud thread coke_vision_fade_in_and_out(n_fadein_time, n_fadeout_time, n_wait_time, n_alpha);
    }
  }
}

coke_vision_fade_in_and_out(n_fadein_time, n_fadeout_time, n_wait_time, n_alpha) {
  self endon("coke_vision_retrigger");

  if(isDefined(n_fadein_time) && n_fadein_time > 0) {
    self fadeovertime(n_fadein_time);
    self.alpha = n_alpha;
    wait(n_fadein_time);
  } else
    self.alpha = 1;

  wait(n_wait_time);

  if(n_fadeout_time > 0) {
    self fadeovertime(n_fadeout_time);
    self.alpha = 0;
    wait(n_fadeout_time);
  }

  if(isDefined(level.fade_hud))
    self destroy();

  flag_clear("cocaine_overlay_active");
}