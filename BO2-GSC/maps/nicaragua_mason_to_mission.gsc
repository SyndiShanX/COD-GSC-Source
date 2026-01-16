/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_mason_to_mission.gsc
***********************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\nicaragua_util;
#include maps\_anim;
#include maps\_music;
#include maps\_fxanim;
#include maps\_turret;
#include maps\nicaragua_mason_bunker;

skipto_mason_to_mission() {
  level.hudson = init_hero("hudson");
  level.woods = init_hero("woods");
  skipto_teleport("player_skipto_mason_to_mission", get_heroes());
  set_objective(level.obj_mason_clear_the_mission);
  exploder(101);
  exploder(10);
  flag_init("mason_woods_freakout_complete");
  flag_set("mason_woods_freakout_complete");
  flag_set("mason_dropped_off_balcony");
  setsaveddvar("cg_aggressiveCullRadius", "500");
  model_restore_area("mason_hill_1");
  model_restore_area("mason_hill_2");
  model_restore_area("mason_mission");
  maps\_fxanim::fxanim_reconstruct("fxanim_archway");
  maps\_fxanim::fxanim_reconstruct("fxanim_fountain");
  level thread fxanim_archway_debug();
}

fxanim_archway_debug() {
  level waittill("destroy_arch");
  level notify("fxanim_archway_start");
  flag_set("mason_courtyard_arch_hit");
}

init_flags() {
  flag_init("nicaragua_mason_to_mission_complete");
  flag_init("mason_in_snipertower");
  flag_init("mason_precourtyard_enemies_dead");
  flag_init("mason_courtyard_enemies_spawned");
  flag_init("mason_courtyard_fight_complete");
  flag_init("mason_courtyard_friendlies_moved_up");
  flag_init("founain_hit_by_rocket");
  flag_init("mason_courtyard_arch_hit");
  flag_init("mission_turret_in_use");
  flag_init("courtyard_extra_turret_gunner_sent");
  flag_init("mason_mission_rocket_guy_alive");
  flag_init("mason_mission_gunner_alive");
}

main() {
  init_flags();
  level thread nicaragua_mason_to_mission_objectives();
  level thread mason_mission_bruteforce_perk();
  mason_mission_setup();
  level thread mason_mission_vo();
  mason_mission_precourtyard();
  level thread mission_precourtyard_rightside();
  level thread mission_guard_rightside();
  flag_wait("begin_mason_mission_courtyard");
  autosave_by_name("mason_precourtyard_complete");
  level thread mason_mission_main_vo();
  level thread mission_sniper_tower();
  level thread precourtyard_enemies_retreat();
  level thread mission_pdf_reinforcements();
  trigger_use("fxanim_archway_trigger");
  level thread mason_mission_courtyard();
  level thread friendlies_move_into_courtyard();
  flag_wait("mason_courtyard_enemies_spawned");
  level thread check_courtyard_enemies_dead();
  flag_wait("mason_courtyard_fight_complete");
  level thread mason_courtyard_splitup();
  flag_wait("nicaragua_mason_to_mission_complete");
  level notify("mason_mission_complete");
  level thread mason_mission_cleanup();
}

nicaragua_mason_to_mission_objectives() {
  flag_wait("mason_dropped_off_balcony");
  set_objective(level.obj_mason_clear_the_mission, getstruct("mission_start_obj"), "");
  trigger_wait("mason_mission_begin_precourtyard_trigger");
  s_struct = getstruct("mission_gate_struct", "targetname");
  set_objective(level.obj_mason_clear_the_mission, s_struct, "");
  wait 1.0;
  level clientnotify("chc_bls");
  level waittill("player_entered_mission_courtyard");
  set_objective(level.obj_mason_clear_the_mission, undefined, "remove");
  flag_wait("mason_courtyard_fight_complete");
  set_objective(level.obj_mason_clear_the_mission, undefined, "delete");
}

mason_mission_bruteforce_perk() {
  level endon("mason_entered_bunker");
  flag_wait("mason_dropped_off_balcony");
  t_open = getent("bruteforce_perk_trigger", "targetname");
  t_open sethintstring(&"SCRIPT_HINT_BRUTE_FORCE");
  t_open setcursorhint("HINT_NOICON");
  t_open trigger_off();
  level.player waittill_player_has_brute_force_perk();
  t_open trigger_on();
  set_objective_perk(level.obj_mason_bruteforce_perk, t_open);
  t_open waittill("trigger");
  t_open delete();
  remove_objective_perk(level.obj_mason_bruteforce_perk);
  level thread nocull_for_3d();
  run_scene("bruteforce_perk");
  m_garage_clip = getent("garage_clip", "targetname");
  m_garage_clip trigger_off();
  m_garage_clip connectpaths();
  m_garage_clip delete();
  level.player giveweapon("mortar_shell_dpad_sp");
  level.player setactionslot(4, "weapon", "mortar_shell_dpad_sp");
  level.player givemaxammo("mortar_shell_dpad_sp");
  flag_set("player_got_mortars");
  screen_message_create(&"NICARAGUA_MORTAR_TUTORIAL");
  wait 4;
  screen_message_delete();
}

nocull_for_3d() {
  flag_wait("bruteforce_perk_started");
  m_body = get_model_or_models_from_scene("bruteforce_perk", "player_body");
  m_body setforcenocull();
}

bruteforce_rumble_light(m_body) {
  level.player rumble_loop(1, 0.25, "damage_light");
}

bruteforce_rumble_med(m_body) {
  level.player rumble_loop(1, 0.25, "damage_heavy");
}

bruteforce_mortar_pickup(m_body) {
}

mason_mission_setup() {
  add_spawn_function_group("mason_mission_cartel_shotgunners", "script_noteworthy", ::make_ai_aggressive);
  trigger_off("mason_mission_splitup_trigger");
  trigger_off("mason_mission_end_trigger");
  e_archway_collision = getent("arch_rubble_collision", "targetname");
  e_archway_collision trigger_off();
  e_archway_collision connectpaths();
  a_nd_archway = getnodearray("mission_archway_cover", "script_noteworthy");

  foreach(node in a_nd_archway)
  setenablenode(node, 0);

  a_e_entrance_clip = getentarray("mission_entrance_clip", "targetname");

  foreach(clip in a_e_entrance_clip) {
    clip trigger_off();
    add_cleanup_ent("mason_mission_cleanup", clip);
  }

  a_nd_nodes = getnodearray("mission_lockdown_nodes", "script_noteworthy");

  foreach(node in a_nd_nodes)
  setenablenode(node, 0);

  m_clip = getent("traversal_to_other_side_clip", "targetname");

  if(isDefined(m_clip)) {
    m_clip trigger_off();
    m_clip connectpaths();
    m_clip delete();
  }
}

mason_mission_precourtyard() {
  trigger_use("mason_mission_precourtyard_enemies_spawned", "targetname");
  trigger_off("mason_mission_precourtyard_enemies_spawned", "targetname");
  wait 0.1;
  spawn_manager_enable("mason_mission_precourtyard_balcony_sm");
  level thread check_precourtyard_balcony_guys_kill();
  wait 0.1;
  ai_sniper = simple_spawn_single("mason_mission_precourtyard_balcony");
  ai_sniper thread check_kill_sniper();
  ai_sniper.deathfunction = ::mission_precourtyard_sniper_dead;
  wait 0.1;
  ai_rocket = simple_spawn_single("mason_mission_balcony_rocket_guy");
  flag_set("mason_mission_rocket_guy_alive");
  ai_rocket.deathfunction = ::ai_rocket_deathfunction;
  ai_rocket thread fountain_fxanim();
  level thread archway_fxanim();
  wait 0.1;
  a_ai_cartel = get_ai_array("mason_mission_precourtyard_cartel_ai", "targetname");
  e_goalvolume = getent("mason_mission_precourtyard_goalvolume", "targetname");

  foreach(guy in a_ai_cartel)
  guy setgoalvolumeauto(e_goalvolume);

  a_ai_cartel[a_ai_cartel.size] = ai_sniper;
  level thread check_precourtyard_enemies_dead(a_ai_cartel);
  level thread precourtyard_spawn_manager(a_ai_cartel);
  trigger_use("spawn_mason_precourtyard_pdf");
  wait 0.1;
  level thread precourtyard_guys_invulnerable();
  level thread precourtyard_enemy_movement();
  ai_sniper thread sniper_intro_kill();
  level thread move_squad_into_precourtyard();
  level thread precourtyard_pdf_reinforcements();
}

ai_rocket_deathfunction() {
  flag_clear("mason_mission_rocket_guy_alive");
  return false;
}

precourtyard_guys_invulnerable() {
  a_ai = getaiarray("allies", "axis");

  foreach(guy in a_ai) {
    if(isalive(guy))
      guy.takedamage = 0;
  }

  trigger_wait("mason_mission_begin_precourtyard_trigger");
  level.player disableinvulnerability();

  foreach(guy in a_ai) {
    if(isalive(guy))
      guy.takedamage = 1;
  }
}

precourtyard_enemy_movement() {
  trigger_wait("mason_mission_player_approaching_precourtyard");
  a_ai_enemy = getaiarray("axis");
  e_goalvolume_backright = getent("precourtyard_back_right_goalvolume", "targetname");
  e_goalvolume_frontleft = getent("precourtyard_front_left_goalvolume", "targetname");

  foreach(guy in a_ai_enemy) {
    if(isDefined(guy.script_goalvolume) && issubstr(guy.script_goalvolume, "front_right")) {
      guy thread waitandsetgoalvolume(e_goalvolume_backright);
      continue;
    }

    if(isDefined(guy.script_goalvolume) && issubstr(guy.script_goalvolume, "back_left"))
      guy thread waitandsetgoalvolume(e_goalvolume_frontleft);
  }
}

waitandsetgoalvolume(e_goalvolume) {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  wait(randomfloatrange(2.0, 7.0));
  self setgoalvolumeauto(e_goalvolume);
}

sniper_tower_destruction() {
  self endon("death");
  flag_wait("mission_sniper_tower_destroyed");
  self ragdoll_death();
  self launchragdoll((0, 45, 65));
}

sniper_intro_kill() {
  self endon("death");
  level endon("mason_courtyard_fight_complete");
  flag_wait("founain_hit_by_rocket");
  ai_redshirt = get_ai("courtyard_sniper_redshirt", "script_noteworthy");

  if(isDefined(ai_redshirt))
    ai_redshirt endon("death");
  else
    return;

  flag_wait("mason_mission_near_fountain");

  if(isalive(ai_redshirt))
    level.player waittill_player_looking_at(ai_redshirt.origin, 75, 0);

  if(isalive(ai_redshirt) && isalive(self))
    self thread sniper_aims_and_shoots(ai_redshirt);
}

sniper_aims_and_shoots(ai_redshirt) {
  self endon("death");
  self aimatpos(ai_redshirt gettagorigin("j_head"));
  magicbullet(self.weapon, self gettagorigin("tag_flash"), ai_redshirt gettagorigin("j_head"));
}

fountain_fxanim() {
  trigger_wait("fxanim_fountain_trigger");
  s_start = getstruct("archway_fxanim_fountain_start", "targetname");
  s_target = getstruct("fountain_target", "targetname");
  e_rocket = magicbullet("rpg_magic_bullet_sp", s_start.origin, s_target.origin);
  e_rocket waittill("death");
  level notify("fxanim_fountain_start");
  earthquake(0.5, 0.5, level.player.origin, 1024);
  level.player thread rumble_loop(4, 0.05, "artillery_rumble");
  wait 2.0;
  flag_set("founain_hit_by_rocket");

  if(isDefined(self) && isalive(self))
    self set_ignoreall(0);
}

archway_fxanim() {
  trigger_wait("fxanim_archway_trigger");
  s_start = getstruct("archway_fxanim_rocket_start", "targetname");
  s_target = getstruct("mission_arch_target", "targetname");
  e_rocket = magicbullet("rpg_magic_bullet_sp", s_start.origin, s_target.origin);
  e_rocket waittill("death");
  level notify("fxanim_archway_start");
  earthquake(0.5, 0.5, level.player.origin, 1024);
  level.player thread rumble_loop(4, 0.05, "artillery_rumble");
  flag_set("mason_courtyard_arch_hit");
}

arch_impacts_ground(e_chunks) {
  a_s_structs = getstructarray("archway_fxanim_rubble_spots", "targetname");

  foreach(struct in a_s_structs)
  radiusdamage(struct.origin, 56, 100, 100);

  e_archway_collision = getent("arch_rubble_collision", "targetname");
  e_archway_collision trigger_on();
  e_archway_collision disconnectpaths();
  a_nd_archway = getnodearray("mission_archway_cover", "script_noteworthy");

  foreach(node in a_nd_archway)
  setenablenode(node, 1);
}

move_squad_into_precourtyard() {
  level thread move_squad_outside_precourtyard();
  trigger_wait("mason_mission_begin_precourtyard_trigger");
  flag_wait("mason_woods_freakout_complete");
  trigger_use("mason_mission_squad_into_precourtyard");
}

precourtyard_pdf_reinforcements() {
  level endon("player_entered_mission_courtyard");
  a_ai_pdf = get_ai_group_ai("mason_pdf");

  if(a_ai_pdf.size > 3)
    waittill_dead_or_dying(a_ai_pdf, a_ai_pdf.size - 2);

  a_sp_spawn = get_ent_array("mason_pdf_precourtyard_reinforcements", "targetname");

  foreach(spawner in a_sp_spawn)
  spawner add_spawn_function(::mission_pdf_reinforcements_sprint);

  spawn_manager_enable("mason_pdf_precourtyard_reinforcements_sm");
}

move_squad_outside_precourtyard() {
  flag_wait("mason_woods_freakout_complete");

  if(!flag("player_entered_mission_precourtyard"))
    trigger_use("mason_mission_initial_colortrigger");
}

precourtyard_spawn_manager(a_enemies) {
  level endon("mason_mission_complete");
  level endon("mason_near_courtyard_gate");
  waittill_dead_or_dying(a_enemies, 4);
  spawn_manager_enable("mason_mission_precourtyard_sm");
}

mission_precourtyard_spawnmanager_goalvolume(a_spawners) {
  foreach(spawner in a_spawners)
  spawner.script_goalvolume = "mason_mission_precourtyard_goalvolume";

  flag_wait("begin_mason_mission_courtyard");

  foreach(spawner in a_spawners)
  spawner.script_goalvolume = "mason_mission_precourtyard_goalvolume";
}

check_precourtyard_enemies_dead(a_enemies) {
  level endon("mason_near_courtyard_gate");
  waittill_dead_or_dying(a_enemies);
  flag_set("mason_precourtyard_enemies_dead");
  trigger_use("begin_mason_mission_courtyard");
}

friendlies_move_into_courtyard() {
  if(flag("mason_courtyard_friendlies_moved_up")) {
    return;
  }
  trigger_use("mason_mission_precourtyard_end_colortrigger");
  flag_set("mason_courtyard_friendlies_moved_up");
  a_ai_pdf = get_ai_group_ai("mason_pdf");

  foreach(guy in a_ai_pdf) {
    wait(randomfloatrange(0.5, 2.0));

    if(isalive(guy))
      guy set_force_color("g");
  }

  a_sp_pdf_reinforcements = getentarray("mason_pdf_precourtyard_reinforcements", "targetname");

  foreach(spawner in a_sp_pdf_reinforcements)
  spawner set_force_color_spawner("g");

  flag_waitopen("mason_mission_gunner_alive");
  trigger_use("mason_mission_courtyard_colortrigger");
}

mission_precourtyard_rightside() {
  level endon("mason_near_courtyard_gate");
  trigger_wait("mason_mission_rightside_look_trigger");
  simple_spawn("mason_mission_rightside_precourtyard_spawners");
}

mission_guard_rightside() {
  level endon("player_entered_mission_courtyard");
  trigger_wait("mission_guard_sniper_tower_entrance");
  ai_cartel = simple_spawn_single("mason_mission_precourtyard_guard_rightside_cartel");
  flag_wait("mason_in_snipertower");

  if(isalive(ai_cartel))
    ai_cartel bloody_death();
}

check_precourtyard_balcony_guys_kill() {
  level waittill("mason_near_courtyard_gate");
  waittill_notify_or_timeout("player_entered_mission_courtyard", 10);
  a_ai = get_ai_array("mason_mission_precourtyard_balcony_cartel", "script_noteworthy");

  if(a_ai.size > 0) {
    foreach(guy in a_ai)
    guy timebomb(3.0, 5.0);
  }
}

check_kill_sniper() {
  self endon("death");
  level waittill("mason_near_courtyard_gate");
  waittill_notify_or_timeout("player_entered_mission_courtyard", 10);

  if(isalive(self))
    self bloody_death();
}

mission_precourtyard_sniper_dead() {
  level notify("mission_precourtyard_sniper_dead");
  return false;
}

mason_mission_courtyard() {
  if(flag("mason_courtyard_enemies_spawned")) {
    return;
  }
  spawn_mission_courtyard_turret_gunner();
  respawn_mission_courtyard_rocket_soldier();
  spawn_manager_enable("begin_mason_mission_courtyard_sm");
  waittill_spawn_manager_complete("begin_mason_mission_courtyard_sm");
  flag_set("mason_courtyard_enemies_spawned");
  trigger_off("begin_mason_mission_courtyard");
}

spawn_mission_courtyard_turret_gunner() {
  sp_spawner = getent("mason_courtyard_turret_gunner", "script_noteworthy");
  ai_gunner = simple_spawn_single(sp_spawner);
  flag_set("mason_mission_gunner_alive");
  e_turret = getent("mason_courtyard_turret", "targetname");
  e_turret thread wait_for_ai_to_use_turret();
  t_trigger = getent("mission_courtyard_turret_trigger", "targetname");

  if(isalive(ai_gunner))
    ai_gunner thread _ai_use_turret(e_turret, 0, t_trigger);

  ai_gunner.deathfunction = ::ai_gunner_deathfunction;
}

wait_for_ai_to_use_turret() {
  level endon("mason_courtyard_fight_complete");
  self waittill("user_using_turret");
  flag_set("mission_turret_in_use");
}

ai_gunner_deathfunction() {
  if(!flag("courtyard_extra_turret_gunner_sent"))
    level thread wait_and_find_new_gunner();

  flag_clear("mission_turret_in_use");
  flag_clear("mason_mission_gunner_alive");
  return false;
}

wait_and_find_new_gunner() {
  level endon("mason_courtyard_fight_complete");
  wait 20;
  flag_set("courtyard_extra_turret_gunner_sent");
  e_turret = getent("mason_courtyard_turret", "targetname");
  e_turret thread wait_for_ai_to_use_turret();
  t_trigger = getent("mission_courtyard_turret_trigger", "targetname");
  a_ai_enemies = getaiarray("axis");
  a_ai_sorted = get_array_of_closest(e_turret.origin, a_ai_enemies);

  if(a_ai_sorted.size <= 0) {
    return;
  }
  for(i = 0; i < a_ai_sorted.size; i++) {
    if(!issubstr(a_ai_sorted[i].targetname, "balcony") && !issubstr(a_ai_sorted[i].targetname, "sniper")) {
      ai_gunner = a_ai_sorted[i];
      break;
    }
  }

  if(isDefined(ai_gunner) && isalive(ai_gunner)) {
    ai_gunner.script_noteworthy = "mason_courtyard_turret_gunner";
    ai_gunner thread _ai_use_turret(e_turret, 0, t_trigger);
    flag_set("mason_mission_gunner_alive");
    ai_gunner.deathfunction = ::ai_gunner_deathfunction;
  }
}

respawn_mission_courtyard_rocket_soldier() {
  ai_rocket = get_ai("mason_mission_balcony_rocket_guy_ai", "targetname");

  if(!isalive(ai_rocket)) {
    ai_rocket = simple_spawn_single("mason_mission_balcony_rocket_guy");
    ai_rocket.deathfunction = ::ai_rocket_deathfunction;
    flag_set("mason_mission_rocket_guy_alive");
  }
}

mission_sniper_tower() {
  level endon("mason_courtyard_fight_complete");
  level.player thread mason_mission_sniper_tower_vo();
  trigger_wait("mason_sniper_tower_trigger");
  flag_set("mason_in_snipertower");
  level notify("mason_in_snipertower");
  trigger_use("mason_mission_snipertower_enemy_trigger");
  trigger_use("mason_mission_snipertower_enemy_trigger2");

  if(!flag("begin_mason_mission_courtyard")) {
    trigger_use("begin_mason_mission_courtyard");
    trigger_off("begin_mason_mission_courtyard");
  }

  wait 0.1;
  a_ai_balcony = get_ai_array("mason_courtyard_balcony", "script_noteworthy");

  if(a_ai_balcony.size > 3) {
    a_ai_balcony = array_randomize(a_ai_balcony);
    n_guys_chosen = 0;

    for(i = 0; i < a_ai_balcony.size; i++) {
      guy = a_ai_balcony[i];

      if(isalive(guy)) {
        guy thread shoot_at_target(level.player);
        n_guys_chosen++;

        if(n_guys_chosen >= 3) {
          break;
        }
      }
    }
  }

  level thread check_courtyard_enemies_dead();
}

precourtyard_enemies_retreat() {
  a_ai_enemies = getaiarray("axis");
  e_goalvolume = getent("mason_mission_courtyard_fallback_goalvolume", "targetname");

  foreach(guy in a_ai_enemies) {
    if(!issubstr(guy.classname, "Sniper"))
      guy thread precourtyard_guy_wait_and_retreat(e_goalvolume);
  }

  add_spawn_function_group("mason_mission_precourtyard_spawnmanager_guys", "targetname", ::missiongoalvolumedummyfunction, e_goalvolume);
}

missiongoalvolumedummyfunction(e_goalvolume) {
  self endon("death");
  self setgoalvolumeauto(e_goalvolume);
}

precourtyard_guy_wait_and_retreat(e_goalvolume) {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  wait(randomfloatrange(0.1, 3.0));

  if(cointoss() > 50)
    self change_movemode("sprint");

  self setgoalvolumeauto(e_goalvolume);
  self waittill("goal");
  self reset_movemode();
}

mission_pdf_reinforcements() {
  level endon("mason_courtyard_fight_complete");
  level waittill("player_entered_mission_courtyard");
  a_ai_pdf = get_ai_group_ai("mason_pdf");

  if(a_ai_pdf.size > 3)
    waittill_dead_or_dying(a_ai_pdf, a_ai_pdf.size - 2);

  a_sp_spawn = get_ent_array("mason_pdf_mission_reinforcements", "targetname");

  foreach(spawner in a_sp_spawn)
  spawner add_spawn_function(::mission_pdf_reinforcements_sprint);

  spawn_manager_enable("mason_pdf_mission_reinforcements_sm");
  level thread disable_mission_spawn_manager();
}

disable_mission_spawn_manager() {
  flag_wait("nicaragua_mason_to_mission_complete");
  spawn_manager_disable("mason_pdf_mission_reinforcements_sm");
}

mission_pdf_reinforcements_sprint() {
  self endon("death");
  self change_movemode("sprint");
  self waittill("goal");
  self reset_movemode();
}

check_courtyard_enemies_dead() {
  level notify("checking_mason_courtyard_enemies");
  self endon("checking_mason_courtyard_enemies");
  a_ai_enemies = getaiarray("axis");
  level thread check_courtyard_almost_clear(a_ai_enemies);
  waittill_dead(a_ai_enemies);
  flag_set("mason_courtyard_fight_complete");
  setmusicstate("NIC_COURTYARD_COMPLETE");
  level notify("mason_courtyard_fight_complete");
  trigger_off("mason_sniper_tower_trigger");
}

check_courtyard_almost_clear(a_ai_enemies) {
  level notify("checking_courtyard_almost_clear");
  level endon("checking_courtyard_almost_clear");

  if(flag("mason_in_snipertower"))
    waittill_dead(a_ai_enemies, a_ai_enemies.size - 5);
  else
    waittill_dead(a_ai_enemies, a_ai_enemies.size - 2);

  a_ai_enemies = remove_dead_from_array(a_ai_enemies);
  e_goalvolume = getent("mason_mission_courtyard_open", "targetname");

  foreach(guy in a_ai_enemies) {
    if(!isalive(guy)) {
      continue;
    }
    if(issubstr(guy.classname, "Sniper")) {
      guy thread timebomb(2.0, 10.0);
      continue;
    }

    if(issubstr(guy.classname, "Launcher")) {
      guy thread timebomb(2.0, 15.0);
      continue;
    }

    guy send_to_middle_of_courtyard(e_goalvolume);
  }
}

send_to_middle_of_courtyard(e_goalvolume) {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.script_noteworthy)) {
    if(issubstr(self.script_noteworthy, "balcony") || issubstr(self.script_noteworthy, "turret"))
      return;
    else if(issubstr(self.script_noteworthy, "sniper")) {
      self thread timebomb(3.0, 5.0);
      return;
    }
  }

  self change_movemode("sprint");
  self setgoalvolumeauto(e_goalvolume);
  self waittill("goal");
  self reset_movemode();
}

mason_courtyard_splitup() {
  trigger_use("mason_mission_courtyard_end_colortrigger");
  autosave_by_name("Mason_Courtyard_Complete");
  wait 2.0;
  e_turret = getent("mason_courtyard_turret", "targetname");

  if(isDefined(e_turret)) {
    e_turret maps\_turret::disable_turret();
    e_turret maps\_turret::stop_turret();
  }

  level thread splitup_objective_marker();
  level thread split_up_start_vo();
  level thread run_scene("split_up_start_woods_START");
  level thread run_scene("split_up_start_hudson_START");
  a_pdf_ai = getmasonallies();

  for(i = 1; i < 4; i++) {
    s_org = getstruct("split_up_pdf_0" + i + "_origin", "targetname");

    if(a_pdf_ai.size > 0) {
      a_ai_guy = get_array_of_closest(s_org.origin, a_pdf_ai, undefined, 1, 2000);

      if(a_ai_guy.size) {
        ai_guy = a_ai_guy[0];
        arrayremovevalue(a_pdf_ai, ai_guy);
      }
    }

    if(!isalive(ai_guy))
      ai_guy = simple_spawn_single("split_up_pdf_0" + i);

    ai_guy magic_bullet_shield();

    if(i == 1) {
      ai_guy.takedamage = 0;
      ai_guy.animname = "bunker_redshirt_pdf";
      ai_guy.script_noteworthy = "redshirt_pdf";
      level.redshirt = ai_guy;
    } else {
      ai_guy.animname = "split_up_pdf_0" + i;
      ai_guy.takedamage = 0;
    }

    ai_guy thread begin_split_up_scene(i);
  }

  level thread hudson_split_up_loop();
  level thread woods_split_up_loop();
  level thread pdf_01_split_up_loop();
  level thread pdf_02_split_up_loop();
  level thread pdf_03_split_up_loop();
  flag_wait("split_up_start_woods_LOOP_started");
  flag_wait("split_up_start_hudson_LOOP_started");
  flag_wait("split_up_start_pdf_01_LOOP_started");
  flag_wait("split_up_start_pdf_02_LOOP_started");
  flag_wait("split_up_start_pdf_03_LOOP_started");
  trigger_on("mason_mission_splitup_trigger");
  level.hudson lookatentity(level.player);
  relax_ik_headtracking_limits();
  level notify("split_up_scene_begin");
  level thread run_split_up_hudson_scenes();
  level thread run_split_up_woods_scenes();
  level thread run_split_up_pdf_01_scenes();
  level thread run_split_up_pdf_02_scenes();
  level thread run_split_up_pdf_03_scenes();
  wait 1.0;
  level thread maps\nicaragua_mason_bunker::load_bunker_gump();
  flag_wait("split_up_start_woods_done");
  flag_wait("split_up_start_hudson_done");
  flag_wait("split_up_start_pdf_01_done");
  flag_wait("split_up_start_pdf_02_done");
  flag_wait("split_up_start_pdf_03_done");
  trigger_use("spawn_post_courtyard_pdf");
  restore_ik_headtracking_limits();
  flag_set("nicaragua_mason_to_mission_complete");
}

test_kill_allies() {
  spawn_manager_disable("mason_pdf_mission_reinforcements_sm");
  a_ai_pdf = getmasonallies();

  for(i = 0; i < a_ai_pdf.size - 1; i++)
    a_ai_pdf[i] bloody_death();
}

begin_split_up_scene(n_index) {
  nd_goal = getnode("pdf_0" + n_index + "_covernode", "script_noteworthy");
  self change_movemode("cqb");
  self.goaldradius = 2;
  self setgoalnode(nd_goal);
  self waittill("goal");
  level thread run_scene("split_up_start_pdf_0" + n_index + "_START");
  flag_wait("split_up_start_pdf_0" + n_index + "_START_done");
  self stop_magic_bullet_shield();
}

splitup_objective_marker() {
  s_struct = getstruct("mason_splitup_start_struct", "targetname");
  set_objective(level.obj_mason_splitup_start, s_struct, "");
  flag_wait_any("nicaragua_mason_to_mission_complete", "mason_joined_splitup_scene");
  set_objective(level.obj_mason_splitup_start, undefined, "delete");
  s_struct structdelete();
}

hudson_split_up_loop() {
  level endon("split_up_scene_begin");
  scene_wait("split_up_start_hudson_START");
  level thread run_scene("split_up_start_hudson_LOOP");
}

woods_split_up_loop() {
  level endon("split_up_scene_begin");
  scene_wait("split_up_start_woods_START");
  level thread run_scene("split_up_start_woods_LOOP");
}

pdf_01_split_up_loop() {
  level endon("split_up_scene_begin");
  scene_wait("split_up_start_pdf_01_START");
  level thread run_scene("split_up_start_pdf_01_LOOP");
}

pdf_02_split_up_loop() {
  level endon("split_up_scene_begin");
  scene_wait("split_up_start_pdf_02_START");
  level thread run_scene("split_up_start_pdf_02_LOOP");
}

pdf_03_split_up_loop() {
  level endon("split_up_scene_begin");
  scene_wait("split_up_start_pdf_03_START");
  level thread run_scene("split_up_start_pdf_03_LOOP");
}

run_split_up_hudson_scenes() {
  run_scene("split_up_start_hudson");
  level thread run_scene("split_up_hudson_idle");
}

run_split_up_woods_scenes() {
  run_scene("split_up_start_woods");
  flag_init("woods_split_up_enter_started");
  level.woods change_movemode("cqb");
  level.woods thread maps\nicaragua_mason_bunker::run_split_up_woods_enter_scene();
}

run_split_up_pdf_01_scenes() {
  run_scene("split_up_start_pdf_01");
  flag_init("pdf_split_up_enter_started");
  level.redshirt change_movemode("cqb");
  level.redshirt thread maps\nicaragua_mason_bunker::run_split_up_pdf_enter_scene();
}

run_split_up_pdf_02_scenes() {
  run_scene("split_up_start_pdf_02");
  level thread run_scene("split_up_pdf_02_idle");
}

run_split_up_pdf_03_scenes() {
  run_scene("split_up_start_pdf_03");
  level thread run_scene("split_up_pdf_03_idle");
}

mission_lockdown() {
  a_e_entrance_clip = getentarray("mission_entrance_clip", "targetname");

  foreach(clip in a_e_entrance_clip)
  clip trigger_on();

  a_nd_nodes = getnodearray("mission_lockdown_nodes", "script_noteworthy");

  foreach(node in a_nd_nodes)
  setenablenode(node, 1);

  sp_lockdown = getent("mason_mission_lockdown_pdf", "targetname");
  sp_lockdown add_spawn_function(::mission_lockdown_guys_impervious);
  spawn_manager_enable("mason_mission_lockdown_pdf_sm");
}

mission_lockdown_guys_impervious() {
  self endon("death");
  self set_ignoreall(1);
  self magic_bullet_shield();
  self.grenadeawareness = 0;
  self.grenadethrowback = 0;
  self set_ignoresuppression(1);
}

mason_mission_vo() {
  level endon("player_entered_mission_courtyard");
  level endon("mason_sniper_tower_VO");
  flag_wait_all("player_entered_mission_precourtyard", "mason_woods_freakout_complete");
  level.hudson queue_dialog("huds_main_building_up_ahe_0", 0, undefined, "begin_mason_mission_courtyard");
  level.hudson queue_dialog("huds_fight_your_way_up_th_0", 1, undefined, "begin_mason_mission_courtyard");

  if(is_mature())
    level.woods queue_dialog("wood_let_s_fucking_go_0", 1, undefined, "begin_mason_mission_courtyard");
  else
    level.woods queue_dialog("wood_let_s_go_0", 1, undefined, "begin_mason_mission_courtyard");

  level.hudson queue_dialog("huds_snipers_on_the_roof_0", 1, undefined, "begin_mason_mission_courtyard");
}

mason_mission_rpg_vo() {
  flag_wait("mason_woods_freakout_complete");
  self queue_dialog("maso_rpgs_0");
}

mason_mission_sniper_tower_vo() {
  level endon("mason_courtyard_fight_complete");
  flag_wait("mason_woods_freakout_complete");
  trigger_wait("mason_sniper_tower_VO");
  level notify("mason_sniper_tower_VO");
  self queue_dialog("maso_i_ll_provide_cover_f_0");
  flag_wait("mason_in_snipertower");
  self queue_dialog("maso_i_m_in_position_mo_0", 0.5);
  wait 2.0;
  level.hudson queue_dialog("huds_rpgs_main_balcony_0");
  level.woods queue_dialog("wood_snipers_in_the_tower_0", 2.0);
  wait 2.0;
  flag_wait("mission_turret_in_use");
  level.woods queue_dialog("wood_mg_nest_front_entra_0");
}

mason_mission_main_vo() {
  level endon("mason_in_snipertower");
  flag_wait("mason_woods_freakout_complete");
  trigger_wait("player_entered_mission_courtyard");
  flag_wait("mission_turret_in_use");
  level.woods queue_dialog("wood_mg_nest_front_entra_0");
  wait 2.0;
  flag_wait("mason_mission_rocket_guy_alive");
  level.hudson queue_dialog("huds_rpgs_main_balcony_0");
}

split_up_start_vo() {
  level.hudson queue_dialog("huds_that_s_the_last_of_t_0");
}

mason_mission_cleanup() {
  a_ai_enemies = getaiarray("axis");

  foreach(guy in a_ai_enemies)
  guy bloody_death();

  level waittill("mason_entered_bunker");
  setmusicstate("NIC_RAID_BUNKER_AMBIENCE");
  a_ai_pdf = get_ai_group_ai("mason_pdf");

  foreach(guy in a_ai_pdf) {
    if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == "redshirt_pdf") {
      continue;
    }
    guy delete();
  }

  if(isalive(level.hudson))
    level.hudson delete();

  delete_scene_all("bruteforce_perk", 1);
  delete_scene("split_up_start_woods_START", 1);
  delete_scene_all("split_up_start_hudson_START", 1);
  delete_scene("split_up_start_pdf_01_START", 1);
  delete_scene_all("split_up_start_pdf_02_START", 1);
  delete_scene_all("split_up_start_pdf_03_START", 1);
  delete_scene("split_up_start_woods_LOOP", 1);
  delete_scene_all("split_up_start_hudson_LOOP", 1);
  delete_scene("split_up_start_pdf_01_LOOP", 1);
  delete_scene_all("split_up_start_pdf_02_LOOP", 1);
  delete_scene_all("split_up_start_pdf_03_LOOP", 1);
  delete_scene("split_up_start_woods", 1);
  delete_scene_all("split_up_start_hudson", 1);
  delete_scene("split_up_start_pdf_01", 1);
  delete_scene_all("split_up_start_pdf_02", 1);
  delete_scene_all("split_up_start_pdf_03", 1);
  kill_spawnernum(15);
  cleanup_ents("mason_mission_cleanup");
}