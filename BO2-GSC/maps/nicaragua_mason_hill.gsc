/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_mason_hill.gsc
*****************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_music;
#include maps\_fxanim;
#include maps\_drones;
#include maps\_turret;
#include maps\_mortar;

skipto_mason_hill() {
  level.hudson = init_hero("hudson");
  level.woods = init_hero("woods");
  skipto_teleport("player_skipto_mason_hill", get_heroes());
  level thread mason_intro_mortars();
  exploder(10);
  set_objective(level.obj_mason_up_hill);
  setsaveddvar("cg_aggressiveCullRadius", "500");
  model_restore_area("mason_hill_1");
  model_restore_area("mason_hill_2");
  model_restore_area("mason_mission");
  maps\_fxanim::fxanim_reconstruct("fxanim_watertower_river");
  maps\_fxanim::fxanim_reconstruct("fxanim_hut_river");
  maps\_fxanim::fxanim_reconstruct("fxanim_porch_explode");
  maps\_fxanim::fxanim_reconstruct("fxanim_hut_explode");
  maps\_fxanim::fxanim_reconstruct("fxanim_hut_explode_watertower");
  maps\_fxanim::fxanim_reconstruct("fxanim_trough_break_1");
  maps\_fxanim::fxanim_reconstruct("fxanim_trough_break_2");
  maps\_fxanim::fxanim_reconstruct("fxanim_truck_fence");
  maps\_fxanim::fxanim_reconstruct("fxanim_archway");
  maps\_fxanim::fxanim_reconstruct("fxanim_fountain");
  battlechatter_on("axis");
}

init_flags() {
  flag_init("mason_hill_part_two_skipto_used");
  flag_init("cartel_begin_using_mg");
  flag_init("wave2_rockguy_dead");
  flag_init("red_barrel_porch_triggered");
  flag_init("wave1_civilians_all_dead");
  flag_init("wave2_molotov_house_destroyed");
  flag_init("cartel_begin_using_mg_wave2");
  flag_init("wave1_civilians2_spawned");
}

main() {
  init_flags();
  level thread nicaragua_mason_hill_objectives();
  level thread intruder_perk();
  level thread mason_hill_chicken_setup();
  mason_hill_setup();
  mason_hill_first_wave();
  mason_hill_second_wave();
  flag_wait("nicaragua_mason_hill_complete");
  level notify("nicaragua_mason_hill_complete");
  level thread mason_hill_cleanup();
}

nicaragua_mason_hill_objectives() {
  flag_wait("mason_intro_objective_breadcrumb_complete");
  set_objective(level.obj_mason_up_hill, undefined, "remove");
  level thread objective_breadcrumb(level.obj_mason_up_hill, "mason_hill_objective_breadcrumb");
  trigger_wait("mason_hill_end_trigger");
  autosave_by_name("Mason_Up_Hill_complete");
}

intruder_perk() {
  t_open = getent("intruder_perk_trigger", "targetname");
  t_open sethintstring(&"SCRIPT_HINT_INTRUDER");
  t_open setcursorhint("HINT_NOICON");
  t_open trigger_off();
  level.player waittill_player_has_intruder_perk();
  t_open trigger_on();
  set_objective_perk(level.obj_mason_intruder_perk, t_open, 1408);
  t_open waittill("trigger");
  t_open delete();
  remove_objective_perk(level.obj_mason_intruder_perk);
  run_scene("intruder_perk");
  a_weapons = get_ent_array("intruder_molotovs", "targetname");
  level.player giveweapon("molotov_dpad_sp");
  level.player setactionslot(1, "weapon", "molotov_dpad_sp");
  level.player givemaxammo("molotov_dpad_sp");
  flag_set("player_got_molotovs");
  array_delete(a_weapons);
  screen_message_create(&"NICARAGUA_MOLOTOV_TUTORIAL");
  wait 4;
  screen_message_delete();
}

mason_hill_chicken_setup() {
  a_e_chickens = getentarray("mason_hill_chicken", "script_noteworthy");

  foreach(chicken in a_e_chickens)
  chicken thread chicken_anim_loop();
}

mason_hill_setup() {
  level thread red_barrel_porch();
  flame_vision_enabled();

  if(level.currentdifficulty == "easy") {
    add_spawn_function_group("mason_hill_wave1_lookout", "script_noteworthy", ::thin_out_for_recruit);
    add_global_spawn_function("axis", ::make_it_easy);
  }

  a_sp_shotgunners = getentarray("masonhill_cartel_shotgunners", "script_noteworthy");

  foreach(spawner in a_sp_shotgunners)
  spawner add_spawn_function(::make_ai_aggressive);

  e_trigger = getent("mason_river_trigger", "targetname");
  level.mason_hill_river_trigger = e_trigger;
  level.mason_hill_blood_pools = 0;
  add_spawn_function_ai_group("mason_hill_start_pdf", ::mason_hill_blood_pool_deathfunction_setup);
  add_spawn_function_ai_group("mason_hill_wave1_reinforcements", ::mason_hill_blood_pool_deathfunction_setup);
  level.player thread river_corpse_manager();
  level.woods make_friendlies_ignore_grenades();
  level.hudson make_friendlies_ignore_grenades();
  add_spawn_function_ai_group("mason_hill_start_pdf", ::make_friendlies_ignore_grenades);
  add_spawn_function_ai_group("mason_hill_wave1_reinforcements", ::make_friendlies_ignore_grenades);
  add_spawn_function_ai_group("mason_wave2_pdf", ::make_friendlies_ignore_grenades);
  level clientnotify("trn_off_walla");
}

make_it_easy() {
  self.script_accuracy = 0.5;
}

thin_out_for_recruit() {
  if(!isDefined(level.__thin_out_for_recruit_kill_count))
    level.__thin_out_for_recruit_kill_count = 0;

  if(!isDefined(level.__thin_out_for_recruit_spawn_count))
    level.__thin_out_for_recruit_spawn_count = 0;

  level.__thin_out_for_recruit_spawn_count++;

  if(level.__thin_out_for_recruit_kill_count < 2) {
    if(level.__thin_out_for_recruit_spawn_count % 2) {
      level.__thin_out_for_recruit_kill_count++;
      self delete();
    }
  }
}

mason_hill_blood_pool_deathfunction_setup() {
  self.deathfunction = ::mason_hill_blood_pool_deathfunction;
}

mason_hill_blood_pool_deathfunction() {
  if(level.mason_hill_blood_pools < 10) {
    if(self istouching(level.mason_hill_river_trigger)) {
      self thread wait_then_play_blood_pool_fx();
      level.mason_hill_blood_pools++;
    }
  }

  return false;
}

wait_then_play_blood_pool_fx() {
  wait 2.0;

  if(isDefined(self)) {
    v_origin = self gettagorigin("J_SpineLower");
    v_angles = (0, 0, 0);
    v_adjusted = (v_origin[0], v_origin[1], 684.5);
    level thread play_fx("blood_water_surface", v_adjusted, v_angles, 15);
  }
}

river_corpse_manager() {
  level endon("mason_hill_wave2_start");

  while(true) {
    a_corpses = [];
    a_river_corpses = [];
    a_corpses = getcorpsearray();

    foreach(corpse in a_corpses) {
      if(corpse istouching(level.mason_hill_river_trigger))
        a_river_corpses[a_river_corpses.size] = corpse;
    }

    if(a_river_corpses.size > 3) {
      n_corpses_to_delete = a_river_corpses.size - 3;
      a_river_corpses = arraysort(a_river_corpses, self.origin, 0);

      for(i = 0; i < n_corpses_to_delete; i++)
        a_river_corpses[i] thread corpse_sink_and_delete(0.9, 0.5);
    }

    wait 1.0;
  }
}

delete_river_corpses() {
  a_river_corpses = [];
  a_corpses = getcorpsearray();

  foreach(corpse in a_corpses) {
    if(corpse istouching(level.mason_hill_river_trigger))
      a_river_corpses[a_river_corpses.size] = corpse;
  }

  for(i = 0; i < a_river_corpses.size; i++)
    a_river_corpses[i] thread corpse_sink_and_delete(0.9, 0.5);
}

corpse_sink_and_delete(n_buoyancy, n_time) {
  if(isDefined(self))
    self scalebuoyancy(n_buoyancy);

  wait(n_time);

  if(isDefined(self))
    self delete();
}

mason_hill_first_wave() {
  mason_hill_initial_colorgroup();
  level thread kill_mason_intro_pdf();
  level thread mason_hill_wave1_vo();
  e_runon = getent("mason_hill_magicgrenade_entity", "targetname");
  add_cleanup_ent("mason_hill_cleanup", e_runon);
  e_runon thread mason_hill_magic_grenades();
  e_runon thread mason_hill_magic_grenade_scripted();
  level thread water_tower_fx_anim();
  level thread mason_hill_end_infinite_sprint();
  level thread spawn_mason_hill_initial_pdf();
  level thread setup_mason_hill_initial_mg_gunners();
  level thread mason_hill_wave1_scripted_mg_kill();
  level thread mason_hill_spawn_molotov_toss_guy();
  level thread mason_hill_civilians();
  level thread mason_hill_civilian_executions();
  level thread mason_hill_wave1_start_cleanup();
  trigger_wait("mason_hill_wave1_mid_spawntrigger");
  level thread mason_hill_wave1_mid_spawnmanagers();
  level thread mason_hill_wave1_lasthouse_shotgunners();
  level thread mason_hill_wave1_mid_cleanup();
}

mason_hill_initial_colorgroup() {
  trigger_use("mason_hill_initial_color_trigger", "targetname");
}

civilian_drones() {
  sp_drone_civilian_1 = getent("civilian_drone_spawner_1", "targetname");
  maps\_drones::drones_assign_spawner("civilian_drones_1", sp_drone_civilian_1);
  maps\_drones::drones_start("civilian_drones_1");
}

mason_hill_initial_lookat_trigger_watcher() {
  level endon("initial_cartel_spawned");
  flag_wait("mason_hill_player_looking_at_start");
  trigger_off("mason_hill_start_lookat_trigger");
  trigger_use("mason_hill_start_trigger");
  trigger_off("mason_hill_start_trigger");
}

kill_mason_intro_pdf() {
  flag_wait("cartel_begin_using_mg");
  a_ai_pdf = get_ai_group_ai("mason_intro_pdf");

  foreach(guy in a_ai_pdf)
  guy thread timebomb(5.0, 10.0);

  e_target = getent("mason_intro_pdf_snipers_target", "targetname");
  add_cleanup_ent("mason_hill_cleanup", e_target);
}

mason_hill_end_infinite_sprint() {
  trigger_wait("mason_hill_player_near_river");
  level.woods reset_movemode();
  level.hudson reset_movemode();
  level.player setmovespeedscale(1.0);
  setsaveddvar("player_sprintUnlimited", 0);
}

mason_hill_magic_grenades() {
  flag_wait("mason_hill_player_looking_at_start");
  wait 1.0;
  a_s_origins = getstructarray("mason_hill_magicgrenade_origin", "script_noteworthy");
  a_s_origins = array_randomize(a_s_origins);

  for(i = 0; i < a_s_origins.size; i++) {
    self fake_grenade_toss(a_s_origins[i].targetname);
    wait(randomfloatrange(1.5, 3.0));
  }

  foreach(origin in a_s_origins) {
    temp = get_struct(origin.target, "targetname");
    temp structdelete();
    origin structdelete();
  }
}

mason_hill_magic_grenade_scripted() {
  ai_redshirt = simple_spawn_single("mason_hill_magicgrenade_redshirt");
  wait 0.1;

  if(isalive(ai_redshirt)) {
    ai_redshirt.takedamage = 0;
    ai_redshirt set_ignoreme(1);
  }

  trigger_wait("mason_hill_magicgrenade_scripted_trigger");
  s_origin = get_struct("mason_hill_magicgrenade_scripted", "targetname");
  ai_redshirt thread run_to_fake_grenade();
  self magicgrenadetype("frag_grenade_sp", s_origin.origin, (0, 0, 0), 3.0);
}

run_to_fake_grenade() {
  self endon("death");
  self set_ignoreall(1);
  nd_goal = getnode("magic_grenade_goalpos", "targetname");
  self.takedamage = 1;
  self.goalradius = 128;
  self.grenadeawareness = 0;
  self.grenadethrowback = 0;
  self set_ignoresuppression(1);
  self set_goal_node(nd_goal);
  self thread fake_grenade_guy_damage_think();
  self waittill("goal");
  self notify("escaped_fake_grenade");
  self set_ignoreall(0);
  self set_ignoreme(0);
  self set_force_color("g");
  self reset_movemode();
  self set_ignoresuppression(0);
}

fake_grenade_guy_damage_think() {
  self endon("escaped_fake_grenade");

  while(true) {
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weaponname);

    if(!isplayer(attacker) && (weaponname == "frag_grenade_sp" || weaponname == "frag_grenade_80s_sp")) {
      self magicgreande_scripted_death();
      break;
    }
  }
}

magicgreande_scripted_death() {
  self ragdoll_death();
  self launchragdoll(vectorscale((0, 0, 1), 100.0));
}

water_tower_fx_anim() {
  flag_wait("mason_hill_fxanim_water_tower");
  s_origin = get_struct("masonhill_wave1_water_tower_fx", "targetname");
  play_fx("mason_intro_mortar", s_origin.origin, s_origin.angles);
  level notify("fxanim_watertower_river_start");
  earthquake(0.5, 0.5, level.player.origin, 1024);
  level.player thread rumble_loop(4, 0.05, "artillery_rumble");
}

setup_mason_hill_initial_mg_gunners() {
  trigger_wait("mason_hill_start_trigger");
  wait 0.1;
  level notify("initial_cartel_spawned");
  a_ai_initial_cartel = getentarray("mason_hill_initial_cartel_soldiers_ai", "targetname");
  a_ai_gunners = [];

  foreach(guy in a_ai_initial_cartel) {
    if(isDefined(guy.script_noteworthy)) {
      if(guy.script_noteworthy == "turret_gunner") {
        e_turret = getent(guy.target, "targetname");
        t_trigger = getent(guy.script_string, "targetname");
        e_turret thread wait_for_ai_to_use_turret();
        guy thread _ai_use_turret(e_turret, 0, t_trigger);
        a_ai_gunners[a_ai_gunners.size] = guy;
      }
    }
  }

  level thread check_for_initial_mg_gunners_dead(a_ai_gunners);
}

mason_hill_wave1_scripted_mg_kill() {
  trigger_wait("mason_hill_player_near_river");
  e_turret = getent("mason_hill_right_building_turret", "targetname");

  if(e_turret maps\_turret::does_turret_have_user()) {
    s_target = get_struct("mason_hill_wave1_scripted_mgdeath_target", "targetname");
    a_ai_pdf = getmasonallies();
    a_closest = arraysort(a_ai_pdf, s_target.origin);
    ai_redshirt = a_closest[0];

    if(isalive(ai_redshirt)) {
      ai_redshirt thread send_wave1_scripted_mg_kill_target();
      ai_redshirt.deathfunction = ::mason_hill_scripted_mg_kill_complete;
      e_turret maps\_turret::set_turret_target(ai_redshirt);
      level waittill("mason_hill_scripted_mg_kill_complete");
      e_turret maps\_turret::clear_turret_target();
    }
  }
}

send_wave1_scripted_mg_kill_target() {
  self endon("death");
  nd_goal = getnode("wave1_scripted_mg_kill_goal", "targetname");
  self set_ignoreall(1);
  self.goalradius = 32;
  self.grenadeawareness = 0;
  self.grenadethrowback = 0;
  self set_ignoresuppression(1);
  self set_goal_node(nd_goal);
  self waittill("goal");
  self set_ignoreall(0);
  self.grenadeawareness = 1;
  self.grenadethrowback = 1;
  self set_ignoresuppression(0);
}

mason_hill_scripted_mg_kill_complete() {
  level notify("mason_hill_scripted_mg_kill_complete");
  return false;
}

wait_for_ai_to_use_turret() {
  level endon("mason_hill_mg_turrets_started");
  self waittill("user_using_turret");
  flag_set("cartel_begin_using_mg");
  level notify("mason_hill_mg_turrets_started");
}

check_for_initial_mg_gunners_dead(a_ai_gunners) {
  waittill_dead(a_ai_gunners);
  level notify("mason_hill_wave1_mg_gunners_dead");
}

spawn_mason_hill_initial_pdf() {
  trigger_use("mason_hill_highside_pdf");
  a_ai_pdf_right = simple_spawn("mason_hill_start_pdf_right");
  flag_wait("cartel_begin_using_mg");
  level thread wave1_pdf_spawnmanager();
}

wave1_pdf_spawnmanager() {
  level endon("mason_hill_wave2_pdf_reinforcements");
  level endon("nicaragua_mason_hill_complete");
  a_ai_pdf = get_ai_group_ai("mason_hill_start_pdf");
  waittill_dead_or_dying(a_ai_pdf, a_ai_pdf.size - 3);
  spawn_manager_enable("mason_hill_wave1_pdf_GREEN_spawn_manager");
  spawn_manager_enable("mason_hill_wave1_pdf_YELLOW_spawn_manager");
  a_ai_pdf = array_removedead(a_ai_pdf);
  wait 3.0;

  foreach(guy in a_ai_pdf) {
    if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == "civilian_executioner") {
      guy thread wait_then_kill_civilian_executioner();
      continue;
    }

    guy thread timebomb(3.0, 7.5);
  }
}

wait_then_kill_civilian_executioner() {
  self endon("death");
  flag_wait("wave1_civilians_all_dead");
  self thread timebomb(3.0, 7.5);
}

mason_hill_spawn_molotov_toss_guy() {
  a_t_hurtriggers = getentarray("mason_hill_firebuilding1_hurttrigger", "targetname");

  foreach(trig in a_t_hurtriggers)
  trig trigger_off();

  ai_molotov_guy = simple_spawn_single("mason_hill_pdf_molotov_guy");
  wait 0.1;
  ai_molotov_guy thread mason_hill_initial_molotov_toss(a_t_hurtriggers);
}

mason_hill_initial_molotov_toss(a_t_hurtriggers) {
  self endon("death");
  assert(isalive(self), "Molotov guy failed to spawn in correctly!");
  self.takedamage = 0;
  self set_ignoreall(1);
  self set_ignoreme(1);
  self clear_force_color();
  self.grenadeawareness = 0;
  self.grenadethrowback = 0;
  self set_ignoresuppression(1);
  trigger_wait("mason_hill_initial_molotov_toss");
  flag_wait("cartel_begin_using_mg");
  self change_movemode("sprint");
  add_generic_ai_to_scene(self, "molotov_toss_1");
  level thread run_scene("molotov_toss_1");
  level waittill("molotov_1_explodes");
  self reset_movemode();
  level thread mason_hill_initial_building_fire();

  foreach(trig in a_t_hurtriggers)
  trig trigger_on();

  self set_ignoreall(0);
  self set_ignoreme(0);
  self.takedamage = 1;
  self.grenadeawareness = 1;
  self.grenadethrowback = 1;
  self set_ignoresuppression(0);
  self set_force_color("g");
}

molotov_1_light(e_guy) {
  v_org = e_guy gettagorigin("tag_flash");
  v_angles = e_guy gettagorigin("tag_flash");
  e_guy play_fx("mortar_wick", v_org, v_angles, "molotov_1_detach", 1, "tag_flash");
}

molotov_1_detach(e_guy) {
  level notify("molotov_1_explodes");
  level notify("molotov_1_detach");
  e_guy detach("t6_wpn_molotov_cocktail_prop_world", "tag_inhand");
}

mason_hill_initial_building_fire() {
  exploder(610);
  clientnotify("firelight");
  level notify("mason_hill_first_molotov_building_on_fire");
  s_origin = get_struct("mason_hill_first_building_left", "targetname");
  a_enemies = getaiarray("axis");
  a_enemies_in_range = get_within_range(s_origin.origin, a_enemies, 320);
  level thread turn_nodes_off_inside_burning_house(a_enemies_in_range);
  n_firerunners = 0;

  if(a_enemies_in_range.size > 0) {
    for(i = 0; i < a_enemies_in_range.size; i++) {
      guy = a_enemies_in_range[i];

      if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == "turret_gunner") {
        guy kill();
        continue;
      }

      if(n_firerunners == 0)
        guy thread mason_hill_wave1_fire_window();
      else if(n_firerunners == 1)
        guy thread mason_hill_wave1_enemy_on_fire("masonhill_firerunner2");
      else if(n_firerunners == 2)
        guy thread mason_hill_wave1_enemy_on_fire("masonhill_firerunner3");
      else {
        wait(randomfloatrange(1.5, 3));
        guy thread mason_hill_wave1_enemy_on_fire("masonhill_firerunner1");
      }

      n_firerunners++;
    }
  }

  s_origin structdelete();
}

mason_hill_wave1_fire_window() {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  self.takedamage = 0;
  self cleargoalvolume();
  self thread mason_hill_guy_on_fire_fx();
  self set_ignoreall(1);
  self change_movemode("sprint");
  nd_runto = getnode("mason_hill_wave1_fire_window", "targetname");
  self.goalradius = 8;
  add_generic_ai_to_scene(self, "wave1_fire_window");
  nd_runto anim_generic_reach(self, "wave1_fire_window");
  level thread run_scene("wave1_fire_window");
  wait 1.1;
  self ragdoll_death();
}

turn_nodes_off_inside_burning_house(a_enemies) {
  if(isDefined(a_enemies) && a_enemies.size > 0)
    waittill_dead(a_enemies);

  a_nd_building = getnodearray("mason_hill_initial_burning_building_nodes", "script_noteworthy");

  foreach(node in a_nd_building)
  setenablenode(node, 0);
}

mason_hill_wave1_enemy_on_fire(str_node) {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  self thread mason_hill_guy_on_fire_fx();
  self set_ignoreall(1);
  self change_movemode("sprint");
  nd_runto = getnode(str_node, "targetname");
  self cleargoalvolume();
  self.goalradius = 32;
  self setgoalnode(nd_runto);
  self waittill_any("goal", "near_goal");
  self ragdoll_death();
}

mason_hill_civilians() {
  trigger_wait("mason_hill_civilian2_trigger");
  simple_spawn("mason_hill_execution1_civ1", ::timebomb, 10, 15);
  flag_set("wave1_civilians2_spawned");
}

mason_hill_civilian_executions() {
  waittill_any("mason_hill_wave1_player_push_past_river", "mason_hill_wave1_mg_gunners_dead");
  a_ai_civ = simple_spawn("mason_hill_execution2_civ1", ::timebomb, 15, 20);
  wait 0.1;
  level thread move_squad_up_when_civiliians_dead(a_ai_civ);
  level.player thread mason_hill_kill_civs_with_magicbullets(a_ai_civ);
  s_target = getstruct("mason_hill_executions2_location", "targetname");
  a_ai_pdf = getmasonallies();
  a_ai_sorted = arraysort(a_ai_pdf, s_target.origin);
  a_nd_nodes = getnodearray("mason_hill_execution2_nodes", "script_noteworthy");
  n_guys_sent = 0;

  for(i = 0; i < a_ai_sorted.size; i++) {
    if(isalive(a_ai_sorted[i])) {
      a_ai_sorted[i] thread shoot_at_civilian_group(a_ai_civ, a_nd_nodes[n_guys_sent]);
      n_guys_sent++;
    }

    if(n_guys_sent == 2) {
      break;
    }
  }
}

shoot_at_civilian_group(a_civilians, nd_goal) {
  if(!isDefined(nd_goal))
    nd_goal = undefined;

  self endon("death");
  self endon("civ_shoot_at_timeout");
  self set_ignoreall(1);
  self set_ignoreme(1);
  self.script_noteworthy = "civilian_executioner";

  if(isDefined(nd_goal)) {
    self disable_ai_color();
    self change_movemode("sprint");
    self.goalradius = 32;
    self setgoalnode(nd_goal);
  }

  flag_wait("civilian_execution_civs_in_range");
  self.perfectaim = 1;
  self thread civ_shoot_at_timeout();

  while(a_civilians.size > 0) {
    if(a_civilians.size == 1)
      ai_target = a_civilians[0];
    else {
      a_ai_sorted = arraysort(a_civilians, self.origin);
      ai_target = a_ai_sorted[0];
    }

    if(!isalive(ai_target)) {
      a_civilians = array_removedead(a_civilians);
      continue;
    }

    self setentitytarget(ai_target);

    if(isalive(ai_target))
      ai_target waittill("death");

    a_civilians = array_removedead(a_civilians);
  }

  level notify("civs_all_dead");
  self stop_shoot_at_target();
  self.perfectaim = 0;
  self.script_noteworthy = "";
  self set_force_color("g");
  self set_ignoreall(0);
  self set_ignoreme(0);
  self reset_movemode();
}

civ_shoot_at_timeout() {
  self endon("death");
  level endon("civs_all_dead");
  wait(randomfloatrange(7.5, 10));
  self notify("civ_shoot_at_timeout");
  level notify("civ_shoot_at_timeout");
  self stop_shoot_at_target();
  self.perfectaim = 0;
  self.script_noteworthy = "";
  self set_force_color("g");
  self set_ignoreall(0);
  self set_ignoreme(0);
  self reset_movemode();
}

mason_hill_kill_civs_with_magicbullets(a_civilians) {
  flag_wait("civilian_execution_civs_in_range");
  wait 2.0;
  a_civilians = array_removedead(a_civilians);

  while(a_civilians.size > 0) {
    if(a_civilians.size == 1)
      ai_target = a_civilians[0];
    else {
      a_ai_sorted = arraysort(a_civilians, self.origin);
      ai_target = a_ai_sorted[0];
    }

    for(i = 0; i < 10; i++) {
      if(!isalive(ai_target)) {
        break;
      }

      if(cointoss() > 50)
        v_start = self.origin + (36, 0, 64);
      else
        v_start = self.origin + (-36, 0, 64);

      v_end = ai_target gettagorigin("J_SpineLower");
      magicbullet("saw_bipod_stand", v_start, v_end);
      wait 0.05;
    }

    a_civilians = array_removedead(a_civilians);
    wait 0.1;
  }
}

move_squad_up_when_civiliians_dead(a_ai_civ) {
  waittill_dead(a_ai_civ);
  trigger_use("mason_hill_initial_colortrigger2");
  trigger_off("mason_hill_initial_colortrigger2");
  flag_set("wave1_civilians_all_dead");
}

mason_hill_wave1_start_cleanup() {
  trigger_wait("mason_hill_cartel_wave1_start_cleanup");
  ai_cartel = get_ai_group_ai("mason_hill_cartel_wave1_start");

  foreach(guy in ai_cartel) {
    if(isalive(guy))
      guy bloody_death();

    wait(randomfloatrange(0.1, 0.5));
  }
}

mason_hill_wave1_mid_spawnmanagers() {
  level endon("mason_hill_wave2_start");
  spawn_manager_enable("masonhill_wave1_mid_lower_sm");
  waittill_spawn_manager_complete("masonhill_wave1_mid_lower_sm");
  spawn_manager_enable("masonhill_wave1_mid_last_house_sm");
  spawn_manager_enable("masonhill_wave1_mid_last_house2_sm");
  simple_spawn_single("masonhill_wave1_single_uproad_guy");
  spawn_manager_enable("masonhill_wave1_mid_uproad_sm");
}

mason_hill_wave1_lasthouse_shotgunners() {
  level endon("mason_hill_wave2_start");
  trigger_wait("mason_hill_wave1_lasthouse_shotgunners");
  spawn_manager_enable("masonhill_wave1_mid_last_house_shotgunner_sm");
}

mason_hill_wave1_mid_cleanup() {
  flag_wait("begin_mason_hill_second_wave");
  wait 2.0;
  ai_cartel = get_ai_group_ai("mason_hill_cartel_wave1_mid");

  foreach(guy in ai_cartel) {
    if(isalive(guy))
      guy bloody_death();

    wait(randomfloatrange(0.1, 0.5));
  }
}

mason_hill_second_wave() {
  flag_wait("begin_mason_hill_second_wave");
  level notify("mason_hill_wave2_start");
  spawn_manager_disable("masonhill_wave1_mid_lower_sm");
  spawn_manager_disable("masonhill_wave1_mid_last_house_sm");
  spawn_manager_disable("masonhill_wave1_mid_last_house2_sm");
  spawn_manager_disable("masonhill_wave1_mid_uproad_sm");
  autosave_by_name("Mason_Hill_part_2");
  level thread delete_river_corpses();
  level thread mason_hill_wave2_vo();
  level thread mason_hill_wave2_start();
  level.player thread check_if_second_building_hit_by_molotov();
  level thread mason_hill_pdf_reinforcements();
  level thread mason_hill_wave2_early_enemies_dieoff();
  level thread wave2_rock_guys();
  level thread move_friendlies_to_upper_house_left();
  level thread move_upper_path_cartel_into_house();
  level thread player_takes_wave2_sidepath();
  level thread kill_upper_house_enemies();
  level thread player_approaches_porch_house();
  level thread end_mason_hill_wave2();
  level thread mason_hill_wave2_molotov_toss_prep();
}

red_barrel_porch() {
  level thread red_barrel_porch_failsafe();
  a_destructibles = getentarray("mason_hill_porch_fxanim", "script_noteworthy");

  foreach(barrel in a_destructibles)
  barrel thread barrel_destroy_think();

  flag_wait("red_barrel_porch_triggered");
  level notify("fxanim_porch_explode_start");
  earthquake(0.5, 0.5, level.player.origin, 1024);
  level.player thread rumble_loop(4, 0.05, "artillery_rumble");
  a_nd_pathnodes = getnodearray("mason_hill_porch_house_nodes", "script_noteworthy");

  foreach(node in a_nd_pathnodes)
  setenablenode(node, 0);

  s_target = getstruct("porch_struct", "targetname");
  a_ai_cartel = getaiarray("axis");
  a_ai_cartel = get_within_range(s_target.origin, a_ai_cartel, 320);

  foreach(guy in a_ai_cartel) {
    if(isalive(guy)) {
      guy ragdoll_death();
      v_x = randomfloatrange(10.0, 75.0);
      v_y = randomfloatrange(-20.0, 20.0);
      v_z = randomfloatrange(0.0, 100.0);
      guy launchragdoll((v_x, v_y, v_z));
    }
  }

  e_clip = getent("porch_clip", "targetname");
  e_clip delete();
  a_ai_cartel = getaiarray("axis");
  e_goalvolume = getent("masonhill_wave2_upperhouse_goalvolume", "targetname");

  foreach(guy in a_ai_cartel) {
    if(isalive(guy)) {
      if(isDefined(guy.script_goalvolume) && guy.script_goalvolume == "mason_hill_wave2_porchhouse_goalvolume")
        guy setgoalvolumeauto(e_goalvolume);
    }
  }

  foreach(barrel in a_destructibles) {
    if(isDefined(barrel))
      radiusdamage(barrel.origin, 64, 100, 100);
  }
}

barrel_destroy_think() {
  self waittill("death");
  flag_set("red_barrel_porch_triggered");
}

red_barrel_porch_failsafe() {
  level endon("fxanim_porch_explode_start");
  trigger_wait("mason_hill_porch_fxanim_failsafe");
  s_origin = get_struct("masonhill_wave2_redbarrelporch_fx", "targetname");
  s_origin maps\_mortar::explosion_boom("mason_hill_porchhouse_mortar", 0.5, undefined, undefined, 1);
  a_destructibles = getentarray("mason_hill_porch_fxanim", "script_noteworthy");

  foreach(barrel in a_destructibles) {
    if(isDefined(barrel))
      radiusdamage(barrel.origin, 64, 100, 100);
  }
}

mason_hill_wave2_start() {
  trigger_use("mason_hill_wave2_enemies");
  trigger_use("mason_hill_wave2_colotrigger");
  e_goalvolume = getent("mason_hill_wave2_lowerhouse_goalvolume", "targetname");
  a_ai_cartel = get_ai_array("masonhill_wave1_uproad_guys", "script_noteworthy");

  foreach(guy in a_ai_cartel)
  guy thread wave1_uproad_cartel_retreat(e_goalvolume);

  lower_house_gunner();
  spawn_manager_enable("mason_hill_wave2_start_lower_house_sm");
  waittill_spawn_manager_complete("mason_hill_wave2_start_lower_house_sm");
  wait 0.1;
  spawn_manager_enable("mason_hill_wave2_start_cartel_corner_sm");
  waittill_spawn_manager_complete("mason_hill_wave2_start_cartel_corner_sm");
  wait 0.1;
  spawn_manager_enable("mason_hill_wave2_house_rooftop_sm");
  waittill_spawn_manager_complete("mason_hill_wave2_house_rooftop_sm");
  wait 0.1;
  upper_house_gunner();
  spawn_manager_enable("mason_hill_wave2_start_porch_house_sm");
  waittill_spawn_manager_complete("mason_hill_wave2_start_porch_house_sm");
  wait 0.1;
  spawn_manager_enable("mason_hill_wave2_start_upper_path_sm");
  waittill_spawn_manager_complete("mason_hill_wave2_start_upper_path_sm");
  wait 0.1;
  flag_wait("spawn_upperhouse_enemies");
  spawn_manager_enable("mason_hill_wave2_start_upper_house_sm");
}

wave1_uproad_cartel_retreat(e_goalvolume) {
  self endon("death");
  wait(randomfloatrange(0.1, 3.0));
  self.goalradius = 32;
  self change_movemode("sprint");
  self setgoalvolumeauto(e_goalvolume);
  self waittill("goal");
  self.goalradius = 256;
  self reset_movemode();
}

lower_house_gunner() {
  ai_gunner = simple_spawn_single("lower_building_gunner");
  e_turret = getent("mason_hill_lower_building_turret", "targetname");
  e_turret thread wait_for_wave2_ai_to_use_turret();
  wait 0.1;
  ai_gunner thread _ai_use_turret(e_turret, 0);
  ai_gunner.deathfunction = ::wave2_lower_house_gunner_dies;
}

wait_for_wave2_ai_to_use_turret() {
  level endon("nicaragua_mason_hill_complete");
  self waittill("user_using_turret");
  flag_set("cartel_begin_using_mg_wave2");
}

wave2_lower_house_gunner_dies() {
  trigger_use("mason_hill_wave2_lowerhouse_colortrigger");
  trigger_off("mason_hill_wave2_lowerhouse_colortrigger");
  flag_set("mason_hill_wave2_lowerhouse_gunner_died");
  return false;
}

upper_house_gunner() {
  ai_gunner = simple_spawn_single("upper_building_gunner");
  e_turret = getent("mason_hill_upper_turret", "targetname");
  wait 0.1;

  if(isDefined(ai_gunner)) {
    ai_gunner thread _ai_use_turret(e_turret, 0);
    ai_gunner.deathfunction = ::wave2_upper_house_gunner_dies;
  }
}

move_upper_path_cartel_into_house() {
  trigger_wait("mason_hill_player_pushed_past_lower_house");
  a_ai_cartel = get_ai_array("mason_hill_wave2_start_upper_path_ai", "targetname");
  e_goalvolume = getent("masonhill_wave2_upperhouse_goalvolume", "targetname");

  foreach(guy in a_ai_cartel) {
    if(isalive(guy))
      guy setgoalvolumeauto(e_goalvolume);
  }
}

player_takes_wave2_sidepath() {
  level endon("nicaragua_mason_hill_complete");
  trigger_wait("mason_hill_wave2_sidepath");
  level notify("wave2_player_takes_sidepath");
  level thread wave2_sidepath_vo();
  trigger_use("mason_hill_rightpath_upperhouse_colortrigger");
  a_ai_enemies = getaiarray("axis");
  e_goalvolume = getent("mason_hill_wave2_porchhouse_goalvolume", "targetname");

  foreach(guy in a_ai_enemies) {
    if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == "mason_hill_wave2_rock_guys" && isalive(guy)) {
      guy change_movemode("sprint");
      guy setgoalvolumeauto(e_goalvolume);
    }
  }
}

move_friendlies_to_upper_house_left() {
  level endon("nicaragua_mason_hill_complete");
  trigger_wait("mason_hill_player_pushed_past_lower_house");
  trigger_use("mason_hill_leftpath_upperhouse_colortrigger");
}

wave2_upper_house_gunner_dies() {
  flag_set("mason_hill_wave2_upperhouse_gunner_died");
  return false;
}

kill_upper_house_enemies() {
  level endon("nicaragua_mason_hill_complete");
  trigger_wait("mason_hill_porchhouse_kill_upper_house_enemies");

  if(!flag("mason_hill_wave2_upperhouse_gunner_died")) {
    ai_gunner = getent("upper_building_gunner_ai", "targetname");
    ai_gunner bloody_death();
  }

  s_struct = getstruct("mason_hill_upper_house_struct", "targetname");
  a_ai_enemies = getaiarray("axis");
  a_ai_enemies = get_within_range(s_struct.origin, a_ai_enemies, 512);

  foreach(guy in a_ai_enemies)
  guy thread timebomb(0.1, 5.0);
}

wave2_rock_guys() {
  level endon("wave2_player_takes_sidepath");
  level endon("nicaragua_mason_hill_complete");
  flag_wait("begin_mason_hill_second_wave");
  wait 0.1;
  a_ai_enemies = get_ai_array("mason_hill_wave2_rock_guys", "script_noteworthy");

  if(a_ai_enemies.size > 0) {
    foreach(guy in a_ai_enemies)
    guy.deathfunction = ::wave2_rockguy_dies;
  }

  e_goalvolume = getent("masonhill_wave2_upperhouse_goalvolume", "targetname");
  flag_wait("wave2_rockguy_dead");

  foreach(guy in a_ai_enemies) {
    if(isalive(guy))
      guy setgoalvolumeauto(e_goalvolume);
  }
}

wave2_rockguy_dies() {
  flag_set("wave2_rockguy_dead");
  return false;
}

mason_hill_pdf_reinforcements() {
  level endon("nicaragua_mason_hill_complete");
  flag_wait("begin_mason_hill_second_wave");
  level notify("mason_hill_wave2_pdf_reinforcements");
  a_ai_pdf = getmasonallies();

  if(a_ai_pdf.size > 3)
    waittill_dead_or_dying(a_ai_pdf, a_ai_pdf.size - 3);

  spawn_manager_enable("mason_hill_wave2_pdf_spawn_manager_GREEN");
  spawn_manager_enable("mason_hill_wave2_pdf_spawn_manager_YELLOW");
  a_ai_pdf = array_removedead(a_ai_pdf);

  foreach(guy in a_ai_pdf)
  guy thread timebomb(3.0, 7.5);
}

mason_hill_wave2_early_enemies_dieoff() {
  level endon("nicaragua_mason_hill_complete");
  trigger_wait("mason_hill_wave2_early_enemies_dieoff");
  a_ai_cartel = get_ai_group_ai("mason_hill_wave2_lower_house");

  foreach(guy in a_ai_cartel)
  guy thread timebomb(1.0, 5.0);
}

player_approaches_porch_house() {
  level endon("nicaragua_mason_hill_complete");
  trigger_wait("mason_hill_wave2_player_approaches_porch_house");
  waittill_spawn_manager_complete("mason_hill_wave2_player_approaches_porch_house");
  waittill_ai_group_ai_count("wave2_porch_house_cartel", 1);
  flag_set("mason_hill_wave2_porch_house_clear");
}

porch_house_move_near_barrels() {
  self endon("death");
  nd_goal = getnode("porch_house_front_node", "script_noteworthy");
  self change_movemode("sprint");
  self.goalradius = 32;
  self setgoalnode(nd_goal);
  self waittill("goal");
  self reset_movemode();
}

end_mason_hill_wave2() {
  trigger_wait("mason_hill_wave2_lasthill");
  trigger_use("mason_truck_color_trigger");
}

mason_hill_wave2_molotov_toss_prep() {
  level thread wave2_molotov_instant_trigger();
  level thread spawn_last_house_enemies();
  trigger_wait("mason_hill_wave2_molotov_prep");
  s_target = get_struct("mason_hill_wave2_molotov_target", "targetname");
  ai_molotov = simple_spawn_single("mason_hill_wave2_molotov");
  ai_molotov thread mason_hill_wave2_molotov_toss(s_target);
}

wave2_molotov_instant_trigger() {
  if(flag("player_got_molotovs")) {
    return;
  }
  trigger_wait("mason_hill_wave2_molotov_instant_trigger");
  mason_hill_second_building_fire();
  ai_molotov = get_ai("mason_hill_wave2_molotov_guy", "script_noteworthy");

  if(isalive(ai_molotov))
    ai_molotov bloody_death();
}

spawn_last_house_enemies() {
  level endon("nicaragua_mason_hill_complete");
  trigger_wait("mason_hill_wave2_lasthill");

  if(!flag("wave2_molotov_house_destroyed"))
    simple_spawn("mason_hill_wave2_lasthouse");
}

mason_hill_wave2_molotov_toss(s_target) {
  self endon("death");
  self.takedamage = 0;
  self change_movemode("sprint");
  trigger_wait("mason_hill_wave2_lasthill");
  self clear_force_color();
  add_generic_ai_to_scene(self, "molotov_toss_2");
  level thread run_scene("molotov_toss_2");
  level waittill("molotov_2_explodes");
  level thread mason_hill_second_building_fire();
  self.takedamage = 1;
  self set_ignoreme(0);
  self set_ignoreall(0);
  self reset_movemode();
}

molotov_2_light(e_guy) {
  v_org = e_guy gettagorigin("tag_flash");
  v_angles = e_guy gettagorigin("tag_flash");
  e_guy play_fx("mortar_wick", v_org, v_angles, "molotov_2_detach", 1, "tag_flash");
}

molotov_2_detach(e_guy) {
  level notify("molotov_2_explodes");
  level notify("molotov_2_detach");
  e_guy detach("t6_wpn_molotov_cocktail_prop_world", "tag_inhand");
}

check_if_second_building_hit_by_molotov() {
  s_origin = get_struct("mason_hill_second_molotov_building", "targetname");

  while(true) {
    self waittill("grenade_fire", e_grenade, str_weapon_name);

    if(str_weapon_name == "molotov_dpad_sp") {
      e_grenade waittill("death");

      if(distance2d(e_grenade.origin, s_origin.origin) <= 384) {
        mason_hill_second_building_fire();
        return;
      }

      n_ammo = level.player getammocount("molotov_dpad_sp");

      if(n_ammo <= 0)
        return;
    }
  }
}

mason_hill_second_building_fire() {
  if(flag("wave2_molotov_house_destroyed")) {
    return;
  }
  flag_set("wave2_molotov_house_destroyed");
  exploder(620);
  level notify("fxanim_hut_explode_start");
  level notify("fxanim_hut_explode_watertower_start");
  earthquake(0.5, 0.5, level.player.origin, 1024);
  level.player thread rumble_loop(4, 0.05, "explosion_generic");
  a_ai_cartel = get_ai_group_ai("mason_hill_wave2_molotov_house_cartel");

  foreach(guy in a_ai_cartel)
  guy mason_hill_wave2_enemy_on_fire();

  s_explosion = get_struct("mason_hill_second_molotov_building_explosion", "targetname");
  physicsexplosioncylinder(s_explosion.origin, 448, 1, 4);
  s_explosion structdelete();
}

mason_hill_wave2_enemy_on_fire() {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  self thread mason_hill_guy_on_fire_fx();
  self ragdoll_death();
}

mason_hill_wave1_vo() {
  flag_wait("cartel_begin_using_mg");
  wait 1.0;
  level.hudson queue_dialog("huds_mg_in_the_window_b_0");
  level.woods queue_dialog("wood_guys_posted_on_the_r_0", 1.0);
  level waittill("mason_hill_wave1_player_push_past_river");
  level.player queue_dialog("maso_on_me_1", 0.5);
  level.woods queue_dialog("wood_right_behind_you_br_0", 1.0);
  flag_wait("wave1_civilians2_spawned");
  wait 2.0;
  level.woods queue_dialog("wood_check_your_fire_we_0");
  level.hudson queue_dialog("huds_watch_the_balconies_0", 1.0);
}

mason_hill_wave2_vo() {
  level endon("nicaragua_mason_hill_complete");
  level.hudson queue_dialog("huds_we_got_more_incoming_0");
  flag_wait("cartel_begin_using_mg_wave2");
  level.woods queue_dialog("wood_got_another_mg_0");
  level.player queue_dialog("maso_spread_out_0", 0.5);
  flag_wait("mason_hill_wave2_lowerhouse_gunner_died");
  level.hudson queue_dialog("huds_they_re_down_move_0", 1.0);
  trigger_wait("mason_hill_player_pushed_past_lower_house");
  level.woods queue_dialog("wood_in_the_window_0");
}

wave2_sidepath_vo() {
  level endon("nicaragua_mason_hill_complete");
  level.player queue_dialog("maso_flanking_right_0");
  trigger_wait("mason_hill_wave2_early_enemies_dieoff");
  level.hudson queue_dialog("huds_multiple_enemies_in_0");
  level.woods queue_dialog("wood_get_a_grenade_in_the_0", 0.5);
}

mason_hill_cleanup() {
  trigger_wait("mason_hill_end_trigger");
  a_ai_pdf = get_ai_group_ai("mason_wave2_pdf");

  foreach(guy in a_ai_pdf) {
    if(isalive(guy))
      guy thread timebomb(1.0, 10.0);
  }

  a_ai_enemies = getaiarray("axis");

  if(a_ai_enemies.size > 0) {
    foreach(guy in a_ai_enemies) {
      if(isalive(guy)) {
        if(isDefined(guy.script_aigroup) && issubstr(guy.script_aigroup, "mason_truck"))
          continue;
        else
          guy thread timebomb(0.1, 3.0);
      }
    }
  }

  trigger_wait("mason_truck_begin");
  delete_scene_all("wave1_fire_window", 1);
  delete_scene("molotov_toss_1", 1);
  delete_scene("molotov_toss_2", 1);
  spawn_manager_disable("masonhill_wave1_mid_lower_sm");
  spawn_manager_disable("masonhill_wave1_mid_last_house_sm");
  spawn_manager_disable("masonhill_wave1_mid_last_house2_sm");
  spawn_manager_disable("masonhill_wave1_mid_last_house_shotgunner_sm");
  spawn_manager_disable("masonhill_wave1_mid_uproad_sm");
  spawn_manager_disable("mason_hill_wave2_start_lower_house_sm");
  spawn_manager_disable("mason_hill_wave2_start_cartel_corner_sm");
  spawn_manager_disable("mason_hill_wave2_start_upper_house_sm");
  spawn_manager_disable("mason_hill_wave2_upperhouse_spawnmanager");
  spawn_manager_disable("mason_hill_wave2_player_approaches_porch_house");
  spawn_manager_disable("mason_hill_wave2_start_porch_house_sm");
  spawn_manager_disable("mason_hill_wave2_start_upper_path_sm");
  spawn_manager_disable("mason_hill_wave2_player_in_porch_house");
  e_upper_house_spawner = getent("mason_hill_wave2_start_upper_house", "targetname");

  if(isDefined(e_upper_house_spawner) && isDefined(e_upper_house_spawner.script_killspawner))
    e_upper_house_spawner.script_killspawner = undefined;

  kill_spawnernum(11);
  cleanup_ents("mason_hill_cleanup");
  a_e_chickens = getentarray("mason_hill_chicken", "script_noteworthy");

  foreach(chicken in a_e_chickens)
  chicken chicken_cleanup();
}

mason_hill_stop_exploders() {
  delete_exploder(610);
  delete_exploder(620);
  delete_exploder(50);
}

fake_grenade_toss(str_targetname, v_start, v_end) {
  assert(isDefined(str_targetname) || (isDefined(v_start) || isDefined(v_end)), "either str_targetname or v_start and v_end are required for molotov_throw function");

  if(isDefined(str_targetname))
    s_start = get_struct(str_targetname, "targetname", 1);

  if(!isDefined(v_start) && isDefined(s_start))
    v_start = s_start.origin;
  else if(!isDefined(v_start) && !isDefined(s_start))
    v_start = self.origin;

  if(!isDefined(v_end)) {
    s_end = get_struct(s_start.target, "targetname", 1);
    v_end = s_end.origin;
  }

  n_gravity = abs(getdvarint(#"bg_gravity")) * -1;
  v_throw = vectornormalize(v_end - v_start) * 500;
  n_dist = distance(v_start, v_end);
  n_time = n_dist / 500;
  v_delta = v_end - v_start;
  n_drop_from_gravity = 0.5 * n_gravity * (n_time * n_time);
  v_launch = (v_delta[0] / n_time, v_delta[1] / n_time, (v_delta[2] - n_drop_from_gravity) / n_time);
  e_grenade = self magicgrenadetype("frag_grenade_sp", v_start, v_launch);
}

mason_hill_guy_on_fire_fx() {
  playfxontag(getfx("fire_ai_torso"), self, "J_Spine4");
  playfxontag(getfx("fire_ai_leg_left"), self, "J_Hip_LE");
  playfxontag(getfx("fire_ai_leg_right"), self, "J_Hip_RI");
  playfxontag(getfx("fire_ai_arm_left"), self, "J_Elbow_LE");
  playfxontag(getfx("fire_ai_arm_right"), self, "J_Elbow_RI");
}

mason_intro_mortars() {
  exploder(50);
  level._explosion_stopnotify["mason_intro_mortar"] = "stop_mason_intro_mortar";
  level thread maps\_mortar::set_mortar_range("mason_intro_mortar", 300, 15360);
  level thread maps\_mortar::set_mortar_delays("mason_intro_mortar", 1.5, 2.5);
  level thread maps\_mortar::set_mortar_quake("mason_intro_mortar", 0.25, 2.0, 850);
  level thread maps\_mortar::mortar_loop("mason_intro_mortar");
  flag_wait("begin_mason_hill_second_wave");
  level notify("stop_mason_intro_mortar");
  level thread mason_hill_wave_mortars();
}

mason_hill_wave_mortars() {
  level._explosion_stopnotify["mason_hill_wave2_mortar"] = "stop_mason_hill_wave2_mortar";
  level thread maps\_mortar::set_mortar_range("mason_hill_wave2_mortar", 300, 15360);
  level thread maps\_mortar::set_mortar_delays("mason_hill_wave2_mortar", 1.5, 2.5);
  level thread maps\_mortar::set_mortar_quake("mason_hill_wave2_mortar", 0.25, 2.0, 850);
  level thread maps\_mortar::mortar_loop("mason_hill_wave2_mortar");
  flag_wait("nicaragua_mason_hill_complete");
  level notify("stop_mason_hill_wave2_mortar");
}