/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_2.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_stealth_logic;
#include maps\angola_2_util;
#include maps\angola_2_fx;
#include maps\_pbr;
#include maps\_heatseekingmissile;
#include maps\_load;
#include maps\_stealth_behavior;
#include maps\_patrol;
#include maps\_drones;
#include maps\angola_2_anim;
#include maps\angola_2_amb;
#include maps\_challenges_sp;
#include maps\angola_river;
#include maps\angola_barge;
#include maps\angola_jungle_stealth;
#include maps\angola_jungle_stealth_house;
#include maps\angola_village;
#include maps\angola_jungle_escape;
#include maps\angola_jungle_ending;

main() {
  maps\angola_2_fx::main();
  maps\angola_2_util::setup_objectives();
  maps\_pbr::init();
  maps\_heatseekingmissile::init();
  level_precache();
  init_flags();
  init_spawn_funcs();
  setup_skiptos();
  maps\_load::main();
  stealth_init();
  maps\_stealth_behavior::main();
  maps\_patrol::patrol_init();
  maps\_drones::init();
  maps\angola_2_anim::main();
  maps\angola_2_amb::main();
  setsaveddvar("phys_buoyancy", 1);
  setsaveddvar("phys_ragdoll_buoyancy", 0);
  level thread maps\_objectives::objectives();
  onplayerconnect_callback(::on_player_connect);
  level.callbackactorkilled = ::global_actor_killed_callback;
}

on_player_connect() {
  self thread setup_challenges();
  wait 0.15;
  level thread check_mortar_count();
}

setup_challenges() {
  self thread maps\_challenges_sp::register_challenge("nodeath", ::nodeath_challenge);
  self thread maps\_challenges_sp::register_challenge("beartrap", ::enemy_kills_with_beartrap_challenge);
  self thread maps\_challenges_sp::register_challenge("grenadedive", ::grenade_dive_challenge);
  self thread maps\_challenges_sp::register_challenge("snipertreekill", ::enemy_kills_using_sniper_tree_challenge);
  self thread maps\_challenges_sp::register_challenge("hmgboatkill", ::escort_boat_kills);
  self thread maps\_challenges_sp::register_challenge("threemortartraps", ::kill_three_enemies_with_motar_beartrap_challenge);
  self thread maps\_challenges_sp::register_challenge("machetegib", ::challenge_machete_gibs);
  self thread maps\_challenges_sp::register_challenge("mortarkills", ::challenge_mortar_kills);
}

nodeath_challenge(str_notify) {
  self waittill("mission_finished");
  n_deaths = get_player_stat("deaths");

  if(n_deaths == 0)
    self notify(str_notify);
}

enemy_kills_with_beartrap_challenge(str_notify) {
  self waittill("mission_finished");

  if(isDefined(level.num_beartrap_catches) && level.num_beartrap_catches >= level.num_beartrap_challenge_kills)
    self notify(str_notify);
}

kill_three_enemies_with_motar_beartrap_challenge(str_notify) {
  level waittill("three_ai_hit_by_mortar_beartrap_explosion");
  self notify(str_notify);
}

escort_boat_kills(str_notify) {
  level waittill("barge_defend_start");

  while(!flag("barge_defend_done")) {
    level waittill("boarding_boat_death");
    self notify(str_notify);
  }
}

grenade_dive_challenge(str_notify) {
  flag_wait("all_players_connected");
  wait 1;
  level.player thread grenade_dive_divetoprone_watcher();
  level.player.overrideplayerdamage = ::player_flakjacket_damage_override;

  while(true) {
    level.player waittill("damage", amount, attacker, direction_vec, damage_ori, type);

    if(isDefined(attacker) && isDefined(attacker.team) && attacker.team == "axis") {
      if((type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH") && isDefined(level.player.just_used_dtp) && level.player.just_used_dtp) {
        if(distance2d(damage_ori, level.player.origin) < 128 && level.player hasperk("specialty_flakjacket") && level.player.health > 0) {
          self notify(str_notify);
          break;
        }
      }
    }
  }
}

player_flakjacket_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  if(isDefined(e_attacker) && isDefined(e_attacker.team) && e_attacker.team == "axis") {
    if((str_means_of_death == "MOD_GRENADE" || str_means_of_death == "MOD_GRENADE_SPLASH") && isDefined(level.player.just_used_dtp) && level.player.just_used_dtp) {
      if(level.player hasperk("specialty_flakjacket"))
        n_damage = 10;
    }
  }

  return n_damage;
}

grenade_dive_divetoprone_watcher() {
  while(true) {
    while(!self.divetoprone)
      wait 0.05;

    self.just_used_dtp = 1;
    self thread grenade_dive_watch_standup();
    self waittill_any_or_timeout(4, "not_prone");
    self notify("stop_watching_standup");
    self.just_used_dtp = 0;
  }
}

grenade_dive_watch_standup() {
  self endon("stop_watching_standup");

  while(self getstance() == "prone")
    wait 0.5;

  self notify("not_prone");
}

destroy_heli_using_bullets(str_notify) {
  level.hind_bullet_only_used = 1;
  level waittill("hind_crash");

  if(!level.hind_bullet_only_used)
    self notify(str_notify);
}

enemy_kills_using_sniper_tree_challenge(str_notify) {
  level endon("end_of_jungle_escape");

  while(true) {
    level waittill("sniper_tree_kill");
    self notify(str_notify);
  }
}

challenge_machete_gibs(str_notify) {
  level.machete_notify = str_notify;
}

challenge_mortar_kills(str_notify) {
  level.mortar_kills = 0;
  flag_init("mortar_challenge_complete");
  flag_wait("mortar_challenge_complete");
  self notify(str_notify);
}

check_mortar_killcount() {
  self waittill("death");
  wait 0.25;
  a_enemies = getaiarray("axis");
  a_drones = drones_get_array("axis");
  a_enemies_and_drones = arraycombine(a_enemies, a_drones, 1, 0);
  a_enemies_in_range = get_within_range(self.origin, a_enemies_and_drones, 512);
  n_killcount = 0;

  foreach(guy in a_enemies_in_range) {
    if(!is_alive(guy)) {
      n_killcount++;
      continue;
    }

    if(guy.targetname == "drone" && isDefined(guy.dead))
      n_killcount++;
  }

  if(n_killcount >= 5)
    flag_set("mortar_challenge_complete");
}

level_precache() {
  precacheitem("huey_rockets");
  precacheitem("m16_sp");
  precacheitem("dragunov_sp");
  precacheitem("rpg_player_sp");
  precacheitem("rpg_magic_bullet_sp");
  precacheitem("m220_tow_sp");
  precacheitem("rpg_magic_bullet_sp_angola");
  precacheitem("beartrap_sp");
  precacheitem("mortar_shell_dpad_sp");
  precacheitem("huey_rockets_angola_lockon");
  precachemodel("viewmodel_knife");
  precachemodel("t5_weapon_strela_world_obj");
  precachemodel("p6_container_dead_bodies_clump01");
  precachemodel("p6_container_dead_bodies_clump02");
  precachemodel("p6_container_dead_bodies_clump03");
  precachemodel("p6_container_dead_bodies_clump04");
  precachemodel("p6_container_dead_bodies_clump05");
  precachemodel("c_usa_angola_corpse1_fb");
  precachemodel("c_usa_angola_corpse2_fb");
  precachemodel("c_usa_angola_hudson_wet_fb");
  precachemodel("t6_wpn_mortar_shell_prop_view");
  precachemodel("t6_wpn_bear_trap_prop");
  precachemodel("t6_wpn_machete_prop");
  precachemodel("veh_t6_mil_gaz66_cargo");
  precachemodel("veh_t6_air_alouette_dmg_att");
  precachemodel("c_usa_jungmar_barechest_fb");
  precachemodel("fxanim_angola_barge_wheelhouse_mod");
  precachemodel("fxanim_angola_barge_aft_debris_mod");
  precachemodel("fxanim_angola_barge_side_debris_mod");
  precachemodel("fxanim_angola_barge_cables_mod");
  precachemodel("t6_wpn_pistol_browninghp_prop_view");
  precachemodel("veh_t6_sea_gunboat_medium_waterbox");
  precachemodel("veh_t6_sea_barge_rear_dmg_destroyed");
  precachemodel("veh_t6_sea_barge_side_dmg_destroyed");
  precachemodel("veh_t6_mil_gaz66_cargo_door_left");
  precachemodel("veh_t6_mil_gaz66_cargo_door_right");
  precachemodel("t6_wpn_grenade_m67_prop_view");
  precachemodel("fxanim_angola_heli_gear_mod");
  precachemodel("fxanim_angola_barge_crane_mod");
  precachemodel("fxanim_angola_barge_side_panel_mod");
  precachemodel("p6_barge_crane_top");
  precachemodel("t6_wpn_knife_sog_view");
  precachemodel("c_mul_menendez_young_head_shot");
  precachemodel("fxanim_angola_barge_barrels_mod");
  precachemodel("fxanim_angola_barge_tarp_rpg_mod");
  precachemodel("fxanim_angola_barge_barrels_side_mod");
  precachemodel("veh_t6_turret_dshk_dead_no_base");
  precachemodel("fxanim_angola_hind_interior_mod");
  precacherumble("tank_damage_light_mp");
  precacherumble("buzz_high");
  precacherumble("la_1_fa38_intro_rumble");
  precacherumble("explosion_generic");
  precacherumble("angola_hind_ride");
}

init_flags() {
  flag_init("player_on_sniper_tree");
}

init_spawn_funcs() {
}

setup_skiptos() {
  add_skipto("riverbed_intro", ::angola_skipto);
  add_skipto("riverbed", ::angola_skipto);
  add_skipto("savannah_start", ::angola_skipto);
  add_skipto("savannah_hill", ::angola_skipto);
  add_skipto("savannah_finish", ::angola_skipto);
  add_skipto("river", maps\angola_river::skipto_river, "River", maps\angola_river::river_main);
  add_skipto("heli_jump", maps\angola_river::skipto_heli_jump, "Heli_jumpdown", maps\angola_river::heli_jump_main);
  add_skipto("barge_defend", maps\angola_barge::skipto_barge_defend, "Barge Defend", maps\angola_barge::barge_defend_main);
  add_skipto("container", maps\angola_barge::skipto_container, "Open Container", maps\angola_barge::container_main);
  add_skipto("jungle_stealth", maps\angola_jungle_stealth::skipto_jungle_stealth, "Jungle Stealth", maps\angola_jungle_stealth::main);
  add_skipto("jungle_stealth_log", maps\angola_jungle_stealth::skipto_jungle_stealth_log, "Jungle Stealth Log", maps\angola_jungle_stealth::jungle_stealth_log_main);
  add_skipto("jungle_stealth_house", maps\angola_jungle_stealth_house::skipto_jungle_stealth_house, "Jungle Stealth House", maps\angola_jungle_stealth_house::main);
  add_skipto("village", maps\angola_village::skipto_village, "Village", maps\angola_village::main);
  add_skipto("jungle_escape", maps\angola_jungle_escape::skipto_jungle_escape, "Jungle Escape", maps\angola_jungle_escape::main);
  add_skipto("jungle_ending", maps\angola_jungle_ending::skipto_jungle_ending, "Jungle Ending", maps\angola_jungle_ending::main);
  default_skipto("river");
}

angola_skipto() {
  changelevel("angola", 1);
}

skipto_cleanup() {
  skipto = level.skipto_point;

  if(skipto == "eventname") {
    return;
  }
  if(skipto == "eventname2")
    return;
}

level_fade_out(m_player_body) {
  level thread maps\angola_jungle_ending::play_outro_vo();
}

check_mortar_count() {
  b_has_mortars = level.player get_temp_stat(3);
  n_clip = level.player get_temp_stat(1);
  n_stock = level.player get_temp_stat(2);

  if(b_has_mortars) {
    level.player giveweapon("mortar_shell_dpad_sp");
    level.player setactionslot(4, "weapon", "mortar_shell_dpad_sp");
    level.player setweaponammoclip("mortar_shell_dpad_sp", n_clip);
    level.player setweaponammostock("mortar_shell_dpad_sp", n_stock);
    level.player_has_mortars = 1;
    level.player thread monitor_mortar_ammo();
  }
}