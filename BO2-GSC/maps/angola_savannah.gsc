/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_savannah.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_objectives;
#include maps\angola_utility;
#include maps\_drones;
#include maps\_music;
#include maps\createart\angola_art;
#include maps\_mpla_unita;
#include maps\_vehicle;
#include maps\_mortar;
#include maps\_audio;
#include maps\_turret;
#include maps\_anim;
#include maps\_gameskill;
#include maps\_damagefeedback;
#include maps\angola_anim;

skipto_savannah_start() {
  skipto_teleport_players("player_skipto_savannah_start");
  level thread maps\createart\angola_art::savannah_start();
  level.savimbi = init_hero("savimbi", ::savimbi_setup);
  level thread run_scene("savimbi_ride_idle");
  blocker = getent("buffel_start_blocker", "targetname");
  blocker hide();
  blocker notsolid();
  a_vh = getentarray("convoy", "script_noteworthy");

  foreach(vh in a_vh) {
    if(isDefined(vh.targetname) && vh.targetname == "riverbed_convoy_eland") {
      vh.drivepath = 1;
      vh thread go_path();
    }

    vh setspeed(20);
  }

  level thread show_victory_vehicles(0);
  level thread hide_victory_grass();
  level thread riverbed_fail_watch();

  for(x = 1; x < 4; x++)
    level thread run_scene("unita_wait_runners" + x);

  level thread run_scene("player_ride_buffel_intro");
  wait 0.5;
  flag_set("savimbi_reached_savannah");
  flag_set("clash_runners_ready");
  flag_set("savannah_base_reached");
  level thread skipto_setup_blocker();
}

skipto_setup_blocker() {
  eland = getent("riverbed_convoy_eland", "targetname");
  eland waittill("riverbed_convoy_buffel_savannah_start");
  blocker = getent("buffel_start_blocker", "targetname");
  blocker show();
  blocker solid();
}

skipto_savannah_hill() {
  cleanup_riverbed_scenes();
  cleanup_savannah_start();
  flag_set("hill_fights_ready");
  skipto_teleport_players("player_skipto_savannah_hill");
  level thread maps\createart\angola_art::savannah_start();
  savannah_drone_setup();
  level thread animate_grass(1);
  level thread hide_victory_grass();
  level.savimbi = init_hero("savimbi", ::savimbi_setup);
  level thread run_scene("savimbi_ride_idle");
  blocker = getent("buffel_start_blocker", "targetname");
  blocker hide();
  blocker notsolid();
  a_vh = getentarray("convoy", "script_noteworthy");
  array_thread(a_vh, ::load_buffel);

  foreach(vh in a_vh) {
    vh veh_magic_bullet_shield(1);

    if(isDefined(vh.targetname) && vh.targetname == "savimbi_buffel") {
      nd_start = getvehiclenode("savimbi_buffel_brim_path", "targetname");
      vh thread go_path(nd_start);
      vh thread savimbi_buffel();
      vh delay_thread(10, ::player_convoy_watch, "savannah_final_warp");
    } else if(isDefined(vh.targetname) && (vh.targetname == "riverbed_convoy_buffel" || vh.targetname == "convoy_destroy_2" || vh.targetname == "riverbed_convoy_eland")) {
      vh thread go_path();
      vh setspeed(20);
      flag_set("convoy_continue_path");
    } else
      vh thread go_path();

    vh setspeed(20);
  }

  level thread mortar_buffel_blocker();
  level thread setup_threat_bias_group();
  level.player.overrideplayerdamage = ::savannah_player_damage_override;
  level thread show_victory_vehicles(0);
  level thread riverbed_lockbreaker_perk();
  level thread savannah_hill_deform_terrain(1);
  level thread savannah_hill_deform_terrain(2);
  level thread skipto_setup_blocker();
  level thread prep_savimbi_nag_array();
}

skipto_debug_heli_strafe() {
  cleanup_riverbed_scenes();
  skipto_teleport_players("player_skipto_savannah_hill");
  flag_set("skipto_debug_heli_strafe");
  savannah_drone_setup();
  level.savimbi = init_hero("savimbi", ::savimbi_setup);
  level thread run_scene("savimbi_ride_idle");
  a_vh = getentarray("convoy", "script_noteworthy");
  array_thread(a_vh, ::load_buffel);

  foreach(vh in a_vh) {
    vh veh_magic_bullet_shield(1);

    if(isDefined(vh.targetname) && vh.targetname == "savimbi_buffel") {
      nd_start = getvehiclenode("savimbi_buffel_brim_path", "targetname");
      vh thread go_path(nd_start);
      vh thread savimbi_buffel();
      vh delay_thread(10, ::player_convoy_watch, "savannah_final_warp");
    } else
      vh thread go_path();

    vh setspeed(20);
  }

  level.player.overrideplayerdamage = ::savannah_player_damage_override;
}

skipto_savannah_finish() {
  cleanup_riverbed_scenes();
  cleanup_savannah_start();
  level thread maps\createart\angola_art::savannah_finish();
  flag_set("savannah_done");
  level thread hide_victory_grass();
  level thread hide_savannah_rocks();
  e_buffel_tip_blocker = getent("buffel_tip_blocker", "targetname");
  e_buffel_tip_blocker connectpaths();
  e_buffel_tip_blocker notsolid();
  level thread show_static_push_models();
}

challenge_heli_runs(str_notify) {
  level.num_heli_runs = 0;
  flag_wait("savannah_final_push_success");

  if(level.num_heli_runs < 4)
    self notify(str_notify);
}

challenge_machete_gibs(str_notify) {
  level.machete_notify = str_notify;
}

challenge_tank_kills(str_notify) {
  level.tank_notify = str_notify;
}

challenge_mortar_kills(str_notify) {
  level.mortar_kills = 0;
  level waittill("mortar_challenge_complete");
  self notify(str_notify);
}

init_flags() {
  flag_init("savannah_base_reached");
  flag_init("savannah_brim_reached");
  flag_init("savannah_final_push");
  flag_init("savannah_final_push_success");
  flag_init("savannah_final_warp");
  flag_init("savannah_player_boarded_buffel");
  flag_init("savannah_done");
  flag_init("savannah_start_hudson");
  flag_init("player_in_helicopter");
  flag_init("skipto_debug_heli_strafe");
  flag_init("buffel2_continue_path");
  flag_init("buffel1_continue_path");
  flag_init("savannah_convoy_start");
  flag_init("mortar_challenge_complete");
  flag_init("final_push");
  flag_init("wave_one_done");
  flag_init("wave_two_done");
  flag_init("pause_fire");
  flag_init("fail_mortars");
  flag_init("savimbi_rally_done");
  flag_init("clash_runners_ready");
  flag_init("savannah_start_fire");
  flag_init("cleanup_victory_shots");
  flag_init("mortar_crew_destroyed");
  flag_init("tank_vo_finished");
  flag_init("technical_gunners_destroyed");
  flag_init("hill_fights_ready");
  flag_init("stop_convoy_fire");
  flag_init("fail_stop_protection");
  flag_init("victory_start");
  flag_init("stop_strafe_quake");
  flag_init("reset_distance_fail");
  flag_init("strafe_hint_active");
  flag_init("stop_drone_kill");
  flag_init("savimbi_stop_mgl");
  flag_init("savimbi_boarded");
  flag_init("mg_objective_ready");
}

savannah_drone_setup() {
  level.disable_drone_explosive_deaths = 1;
  level.drones.max_drones = 300;
  maps\_drones::drones_set_impact_effect(level._effect["drone_impact_fx"]);
  sp_drone_mpla_high = getent("mpla_drone_high", "targetname");
  drones_assign_spawner("mpla_drones", sp_drone_mpla_high);
}

draw_team_targetname() {
  self endon("death");

  while(true) {
    recordenttext(self.team + self.targetname, self, (1, 1, 1), "Script");
    wait 0.05;
  }

}

savannah_start() {
  setailimit(24);
  spawn_manager_set_global_active_count(22);
  level.stop_mortar_if_player_nearby = 1;
  level.friendlyfiredisabled = 1;
  level thread riverbed_lockbreaker_perk();
  level.mortar_fail = 0;
  level thread prep_savimbi_nag_array();
  level.player.overrideplayerdamage = ::savannah_player_damage_override;
  savannah_drone_setup();
  level thread setup_threat_bias_group();
  level thread savannah_start_mortars();
  sp_unita = getent("savannah_start_unita", "targetname");
  sp_mpla = getent("savannah_start_mpla", "targetname");
  brim_ally_initial_spawners = getentarray("brim_ally_initial", "targetname");
  array_thread(brim_ally_initial_spawners, ::add_spawn_function, ::brim_ally_initial_wait);
  trigger_use("sm_brim_initial");
  level thread run_scene("unita_wait");
  a_veh_buffels = getentarray("convoy", "script_noteworthy");
  array_thread(a_veh_buffels, ::load_buffel);
  flag_wait_all("clash_runners_ready", "savimbi_reached_savannah");
  level thread maps\createart\angola_art::savannah_start();
  level thread cleanup_riverbed_fail_triggers();
  savimbi_buffel = getent("savimbi_buffel", "targetname");
  savimbi_buffel thread player_convoy_watch("savannah_final_warp");
  stop_exploder(1000);
  level thread cleanup_riverbed_scenes();
  level.savimbi vo_play_savannah_start();
  wait 1.5;
  maps\_drones::drones_speed_modifier("brim_mpla_drones", 0.2, 0.4);
  drones_start("brim_mpla_drones");
  playsoundatposition("evt_enemy_charge", (1243, 1625, 210));
  setmusicstate("ANGOLA_SAVANNAH_BATTLE");
  level clientnotify("pgw");
  level thread fake_battle_loop();
  trigger_use("sm_brim_shooters");
  wait 2.7;
  flag_set("savannah_start_fire");
  level thread set_pre_melee_mortars();
  wait 6.2;
  level thread set_melee_mortars();
  ai_mpla_array = [];

  for(i = 1; i < 9; i++) {
    ai_mpla = sp_mpla spawn_ai(1);
    ai_mpla magic_bullet_shield();
    ai_mpla_array[ai_mpla_array.size] = ai_mpla;
    ai_mpla.animname = "mpla_0" + i;
    ai_mpla.script_noteworthy = "initial_brim";
    ai_mpla.a.deathforceragdoll = 1;
    ai_mpla.ignoreme = 1;

    if(i != 8) {
      ai_mpla.script_string = "machete_scripted";
      ai_mpla maps\_mpla_unita::setup_mpla();
    }
  }

  end_scene("unita_wait");
  end_scene("unita_wait_runners1");
  end_scene("unita_wait_runners2");
  end_scene("unita_wait_runners3");

  for(i = 1; i <= 5; i++)
    level thread do_melee_scene("initial_charge_" + i);

  level thread savimbi_shoot();

  foreach(ai_enemy in ai_mpla_array)
  ai_enemy stop_magic_bullet_shield();

  level thread savannah_brim_fights();
  a_ai_initial = getentarray("initial_brim", "script_noteworthy");
  level thread watch_savannah_short_warn();
  autosave_by_name("savannah_start");
  level thread savannah_start_savimbi_buffel_go();
  a_vh = getentarray("convoy", "script_noteworthy");

  foreach(vh in a_vh) {
    if(vh.targetname != "savimbi_buffel") {
      vh veh_magic_bullet_shield(1);
      vh.drivepath = 1;
      vh thread maps\_vehicle::disconnect_paths_while_moving(0.5);

      switch (vh.targetname) {
        case "convoy_destroy_1":
          vh setspeed(3.8);
          break;
        case "riverbed_convoy_eland":
          vh setspeed(3.2);
          break;
        case "convoy_destroy_2":
          vh setspeed(3.4);
          break;
        case "final_push_eland":
          vh setspeed(3.1);
          break;
        case "riverbed_convoy_buffel":
          vh setspeed(3.1);
          break;
        default:
          vh setspeed(3);
          break;
      }

      flag_set("convoy_continue_path");
      vh thread go_path();
      wait(randomfloatrange(0.1, 0.3));
    }
  }

  vh_lead = getent("savimbi_buffel", "targetname");
  vh_lead thread savimbi_buffel();
  level thread mortar_buffel_blocker();
  a_veh_elands = getentarray("convoy", "script_noteworthy");
  array_thread(a_veh_elands, ::eland_think);
  array_thread(a_veh_elands, ::buffel_gunner_think);
  level thread stop_convoy_hill_fire();
  flag_wait("savannah_brim_reached");
  delay_thread(2, ::savannah_hill_deform_terrain, 1);
  delay_thread(5, ::savannah_hill_deform_terrain, 2);
  level thread animate_grass(1);
  level thread cleanup_savannah_start();
}

enable_friendly_fire() {
  level.friendlyfiredisabled = 0;
}

stop_convoy_hill_fire() {
  flag_wait("savannah_start_hudson");
  level notify("stop_convoy_fire");
}

end_scene_if_i_die(scene_name) {
  self endon("_scene_stopped");
  self waittill("death");
  self notify("_scene_stopped");
}

kill_me_if_i_live(scene_name) {
  self endon("death");
  scene_wait(scene_name);

  if(self.team == "allies") {
    self.goalradius = 64;
    nd_goal = level.a_nd_engage[randomint(level.a_nd_engage.size)];
    self setgoalpos(nd_goal.origin);
  }

  self thread _random_death(undefined, 1);
}

do_melee_scene(scene_name) {
  level thread run_scene(scene_name);
  combatants = get_ais_from_scene(scene_name);

  for(i = 0; i < combatants.size; i++) {
    combatants[i] thread end_scene_if_i_die(scene_name);
    combatants[i] thread kill_me_if_i_live(scene_name);
  }
}

savannah_start_savimbi_buffel_go() {
  vh = getent("savimbi_buffel", "targetname");
  vh veh_magic_bullet_shield(1);
  vh.drivepath = 1;
  vh thread maps\_vehicle::disconnect_paths_while_moving(0.5);
  vh setspeed(3);
  nd_start = getvehiclenode("savimbi_buffel_brim_path", "targetname");
  vh thread go_path(nd_start);
}

set_pre_melee_mortars() {
  for(x = 1; x < 6; x++) {
    str_mortar = "start_melee_mortar" + x;
    s_mortar = getstruct(str_mortar, "script_noteworthy");
    playfx(getfx("mortar_savannah"), s_mortar.origin);
    playsoundatposition("exp_mortar", s_mortar.origin);
    wait 1.1;
  }
}

set_melee_mortars() {
  melee_pos1 = getent("start_melee_mortar1", "targetname");
  melee_pos2 = getent("start_melee_mortar2", "targetname");
  melee_pos3 = getent("start_melee_mortar3", "targetname");
  playfx(getfx("mortar_savannah"), melee_pos1.origin);
  melee_pos1 playsound("exp_mortar");
  wait 0.25;
  playfx(getfx("mortar_savannah"), melee_pos2.origin);
  melee_pos2 playsound("exp_mortar");
  wait 0.25;
  playfx(getfx("mortar_savannah"), melee_pos3.origin);
  melee_pos3 playsound("exp_mortar");
}

vo_play_savannah_start() {
  level thread savimbi_rally();
  wait 1.5;
}

savimbi_rally() {
  player_body = getent("player_body", "targetname");
  player_body anim_set_blend_in_time(0.0);
  level thread savimbi_riders_rally();
  end_scene("player_ride_buffel_intro");
  end_scene("savimbi_ride_idle");
  level.savimbi anim_set_blend_in_time(0.0);
  level.savimbi anim_set_blend_out_time(0.0);
  run_scene_and_delete("savimbi_charge_rally");
  level.player player_enable_weapons();
  level.player setlowready(0);
  level.savimbi detach("t6_wpn_launch_mm1_world", "tag_weapon_left");
  level.savimbi attach("t6_wpn_launch_mm1_world", "tag_weapon_right");
  level thread run_scene("savimbi_ride_idle");
  wait 0.15;
  level flag_set("savimbi_rally_done");
  delay_thread(0.5, ::unita_say, "uni0_charge_0");
  delay_thread(0.3, ::unita_say, "uni2_now_0");
  delay_thread(1, ::unita_say, "uni3_unita_0");
  delay_thread(3, ::unita_say, "uni1_may_our_blades_find_0");
}

rally_stop_rumble(m_body) {
  level.player stoprumble("tank_rumble");
}

savimbi_riders_rally() {
  savimbi_buffel = getent("savimbi_buffel", "targetname");
  savimbi_buffel remove_buffel_riders();
  level thread run_scene("savimbi_buffel_shooters_idle");
  level thread savimbi_riders_rally_prep();
  flag_wait("savimbi_rally_done");
  run_scene("savimbi_buffel_shooters_trans");
  level thread run_scene("savimbi_buffel_shooters_attack");
}

savimbi_riders_rally_prep() {
  wait 0.05;
  savimbi_riders = get_model_or_models_from_scene("savimbi_buffel_shooters_idle");

  foreach(rider in savimbi_riders)
  rider attach("t6_wpn_ar_fal_prop_world", "tag_weapon_right");
}

cleanup_savannah_start() {
  ai_sweepers = getentarray("convoy_trailers", "script_noteworthy");

  foreach(sweeper in ai_sweepers) {
    sweeper stop_magic_bullet_shield();
    sweeper bloody_death();
  }

  delete_scene_all("unita_wait", 1);
  delete_scene_all("initial_charge_1", 1);
  delete_scene_all("initial_charge_2", 1);
  delete_scene_all("initial_charge_3", 1);
  delete_scene_all("initial_charge_4", 1);
  delete_scene_all("initial_charge_5", 1);
  delete_scene_all("brim_start_loop1", 1);
  delete_scene_all("brim_start_loop2", 1);
  delete_scene_all("brim_start_unload1", 1);
  delete_scene_all("brim_start_unload2", 1);
  delete_scene_all("brim_start_unload3", 1);
  delete_scene_all("brim_start_unload4", 1);
  delete_scene_all("unita_wait_runners_intro1", 1);
  delete_scene_all("unita_wait_runners_intro2", 1);
  delete_scene_all("unita_wait_runners_intro3", 1);
  delete_scene_all("unita_wait_runners1", 1);
  delete_scene_all("unita_wait_runners2", 1);
  delete_scene_all("unita_wait_runners3", 1);
  delete_scene_all("player_ride_buffel_intro", 1);
  delete_array("savannah_start_unita", "targetname");
  delete_array("savannah_start_mpla", "targetname");
  delete_array("brim_ally_initial", "targetname");
  delete_array("sm_brim_initial", "targetname");
}

savannah_start_mortars() {
  level._explosion_stopnotify["mortar_savannah_start"] = "stop_savannah_start_mortars";
  level thread maps\_mortar::set_mortar_delays("mortar_savannah_start", 1, 3);
  level thread maps\_mortar::set_mortar_damage("mortar_savannah_start", 256, 1001, 1003);
  level thread maps\_mortar::mortar_loop("mortar_savannah_start");
  flag_wait_all("clash_runners_ready", "savimbi_reached_savannah");
  level notify("stop_savannah_start_mortars");
}

mortar_buffel_blocker() {
  flag_wait("fire_eland_mortar");
  vh_buffel_mortar = getent("buffel_mortar", "targetname");
  playfx(getfx("mortar_savannah"), vh_buffel_mortar.origin);
  playsoundatposition("exp_mortar", vh_buffel_mortar.origin);
  vh_buffel_mortar thread destroy_buffel();
  vh_buffel_mortar waittill("reached_end_node");
  vh_buffel_mortar notify("death");
}

savimbi_buffel() {
  drones_delete("brim_mpla_drones");
  self waittill("stop_brim_fights");
  flag_set("savannah_brim_reached");
  spawn_manager_kill("sm_brim_shooters");
  self waittill("reached_end_node");
  flag_set("savimbi_stop_mgl");
  self setspeedimmediate(0);
  level.savimbi setup_savimbi_for_battle();
  self.takedamage = 0;
  run_scene("savimbi_join_battle");
  level.savimbi unequip_savimbi_machete_battle();
  level.savimbi set_ignoreme(0);
  level.savimbi setgoalpos(level.savimbi.origin);
  self.takedamage = 1;
  self anim_set_blend_in_time(0.2);
}

setup_savimbi_for_battle() {
  self gun_recall();
  self detach("t6_wpn_launch_mm1_world", "tag_weapon_right");
  self set_ignoreme(1);
  self anim_set_blend_in_time(0.0);
  self anim_set_blend_out_time(0.0);
}

savimbi_buffel_drop_mgl(savimbi) {
  model_origin = savimbi gettagorigin("tag_weapon_left");
  model_angles = savimbi gettagangles("tag_weapon_left");
  mgl = spawn("script_model", model_origin);
  mgl.angles = model_angles;
  mgl setmodel("t6_wpn_launch_mm1_world");
  savimbi detach("t6_wpn_launch_mm1_world", "tag_weapon_left");
}

#using_animtree("generic_human");

savimbi_buffel_spawn_enemy(savimbi) {
  v_buffel = getent("savimbi_buffel", "targetname");
  v_origin = getstartorigin(v_buffel gettagorigin("tag_rear_door_l"), v_buffel gettagangles("tag_rear_door_l"), % ch_ang_03_01_savimbi_joins_enemy);
  playfx(getfx("mortar_savannah"), v_origin);
  playsoundatposition("exp_mortar", v_origin);
  ai_savimbi_enemy = simple_spawn_single("post_heli_enemy", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  ai_savimbi_enemy.animname = "savimbi_enemy";
  run_scene("savimbi_join_battle_enemy", undefined, 1);
}

savannah_destroy_buffel1() {
  vh_buffel_1 = getent("convoy_destroy_1", "targetname");
  vh_buffel_1 destroy_buffel();
  vh_buffel_1 notify("death");
}

savannah_destroy_buffel2() {
  self destroy_buffel();
  self setspeed(15);
  delay_thread(0.5, ::unita_say, "uni1_we_re_losing_vehicle_0");
  self waittill("reached_end_node");
  self notify("death");
}

savannah_destroy_eland_fight() {
  level thread run_scene("post_heli_run_fight");
  level thread savannah_destroy_eland();
  level thread cleanup_post_heli_fight();
}

savannah_destroy_eland(e_enemy) {
  v_eland = getent("eland_hero", "targetname");
  v_eland veh_magic_bullet_shield(0);
  wait 0.05;
  v_eland playsound("exp_veh_large");
  v_eland playsound("exp_mortar");
  playfx(getfx("mortar_savannah"), v_eland.origin);
  v_eland notify("death");
  radiusdamage(v_eland.origin, 100, 20, 10, undefined, "MOD_PROJECTILE_SPLASH");
  run_scene_and_delete("destroy_eland");
  delay_thread(0.5, ::unita_say, "uni0_the_convoy_is_under_0");
}

savimbi_shoot() {
  level endon("savimbi_stop_mgl");
  level waittill("savimbi_rally_done");

  while(true) {
    end_scene("savimbi_ride_idle");
    run_scene("savimbi_fire_mgl");

    for(x = 0; x < 2; x++)
      run_scene("savimbi_ride_idle_hill");
  }
}

brim_ally_initial_wait() {
  self endon("death");
  self.ignoreall = 1;
  flag_wait("savannah_start_fire");
  self.ignoreall = 0;
}

savannah_brim_fights() {
  wait 1;
  init_fight("brim_fight_start", "brim_ally", "brim_axis");
  a_ai_initial = getentarray("brim_ally_initial_ai", "targetname");

  foreach(ai in a_ai_initial) {
    if(isDefined(ai) && isalive(ai))
      create_fight(ai, undefined, 1);
  }

  while(!flag("stop_brim_start_fights") && !flag("savannah_brim_reached")) {
    create_fight(undefined, undefined, 1, "brim_fight_start");
    wait(randomfloatrange(0.1, 0.5));
  }

  init_fight("brim_fight", "brim_ally", "brim_axis");
  level thread cleanup_fight("brim_fight_start", "script_noteworthy", 2);

  while(!flag("savannah_brim_reached")) {
    create_fight(undefined, undefined, 1);
    wait(randomfloatrange(0.1, 0.3));
  }

  flag_set("hill_fights_ready");
}

savannah_hill() {
  setailimit(24);
  spawn_manager_set_global_active_count(22);
  level.savannah_tank_kills = 0;
  level.savannah_final_push_kills = 0;
  level.savannah_first_wave_kills = 0;
  level.savannah_second_wave_kills = 0;
  level.savannah_final_wave_kills = 0;
  level.savannah_first_wave_rpg_kills = 0;
  level.savannah_second_wave_rpg_kills = 0;
  level.mortar_fail = 1;
  level.friendlyfiredisabled = 0;
  level thread maps\createart\angola_art::savannah_hill();
  path_blocker = getent("push_path_blocker", "targetname");
  path_blocker notsolid();
  path_blocker connectpaths();
  e_buffel_tip_blocker = getent("buffel_tip_blocker", "targetname");
  e_buffel_tip_blocker connectpaths();
  e_buffel_tip_blocker notsolid();
  level.player thread drone_killer();
  level thread savannah_mortar_team();
  trigger_use("first_wave");
  level thread setup_wave_one_launchers();
  level thread wave_one_tank_fire();
  level.player thread heli_strafing_watch();
  level thread savannah_mortars();
  level thread set_water_dvars_strafe();
  sp_wave_one_shooters = getentarray("wave_one_shooter", "targetname");

  foreach(shooter in sp_wave_one_shooters)
  shooter add_spawn_function(::init_hill_shooter);

  sp_hill_shooters = getentarray("hill_shooter", "targetname");

  foreach(shooter in sp_hill_shooters)
  shooter add_spawn_function(::init_hill_shooter, 0.9);

  sp_brim_shooters = getentarray("brim_shooter", "targetname");

  foreach(shooter in sp_brim_shooters)
  shooter add_spawn_function(::init_hill_shooter);

  sp_hill_machete = getentarray("hill_machete", "targetname");

  foreach(machete_guy in sp_hill_machete)
  machete_guy add_spawn_function(::init_hill_shooter);

  trigger_use("sm_hill_shooters");
  t_use = getent("trigger_board_buffel", "targetname");
  t_use trigger_off();
  a_veh_elands = getentarray("convoy", "script_noteworthy");
  array_thread(a_veh_elands, ::eland_think, 1);
  array_thread(a_veh_elands, ::buffel_gunner_think, 1);
  add_spawn_function_veh_by_type("tank_t62_nophysics", ::tank_think);
  level.player setclientdvar("cg_objectiveIndicatorFarFadeDist", 3000);
  exploder(2000);
  drones_start("mpla_drones");
  drones_set_cheap_flag("mpla_drones", 1);
  drones_start("mpla_drones_high");
  drones_set_cheap_flag("mpla_drones_high", 1);
  level thread savannah_hill_fights();
  autosave_by_name("savannah_hill");
  level thread cleanup_hill();

  while(level.savannah_first_wave_kills < 4)
    wait 1;

  flag_set("wave_one_done");

  while(level.savannah_second_wave_kills < 9)
    wait 1;

  flag_set("savannah_final_push");
  spawn_manager_kill("sm_hill_shooters");
  flag_waitopen("player_in_helicopter");
  level thread savannah_board_buffel();
  flag_wait("savannah_player_boarded_buffel");
  level notify("stop_fire");
  set_objective(level.obj_get_to_buffel, undefined, "delete");
  stop_exploder(2000);
  flag_wait("final_push_fade");
  flag_set("savannah_final_push_success");
  level thread maps\_audio::switch_music_wait("ANGOLA_SAVIMBI_SALUTE", 0.25);
  drones_delete("mpla_drones_push");
  wait 0.05;
  level thread maps\_drones::drones_delete_spawned();
  flag_set("savannah_done");
}

vo_play_savannah_hill() {
  self say_dialog("maso_dammit_hudson_they_0");
  self say_dialog("maso_we_need_you_to_take_0");
  set_objective(level.obj_destroy_first_wave, undefined, undefined, -1);
  flag_set("tank_vo_finished");
}

savannah_hill_deform_terrain(n_topper, b_move) {
  str_name = "mortar_top_" + n_topper;
  m_terrain = getent(str_name, "targetname");

  if(isDefined(b_move) && b_move)
    m_terrain.origin = m_terrain.origin + vectorscale((0, 0, -1), 50.0);
  else {
    m_terrain maps\_mortar::explosion_boom("mortar_savannah");
    m_terrain delete();
  }
}

savannah_hill_fights() {
  flag_wait("hill_fights_ready");
  level thread cleanup_fight("brim_axis_ai", "targetname", 5);
  init_fight("hill_fight", "hill_ally", "hill_axis");

  for(n_fight_counter = 0; !flag("wave_one"); n_fight_counter++) {
    if(n_fight_counter >= 6) {
      create_fight(undefined, undefined, undefined, "hill_fight");
      n_fight_counter = 0;
    } else
      create_fight(undefined, undefined, undefined, "hill_fight");

    wait(randomfloatrange(2.0, 3.0));
  }
}

savannah_wave_one_fights() {
  level thread cleanup_fight("hill_fight", "script_noteworthy");
  init_fight("wave_one_fight", "wave_one_ally", "wave_one_axis");

  for(n_fight_counter = 0; !flag("savannah_player_boarded_buffel"); n_fight_counter++) {
    if(n_fight_counter >= 6) {
      create_fight();
      n_fight_counter = 0;
    } else
      create_fight();

    wait(randomfloatrange(2.0, 3.0));
  }
}

savannah_board_buffel() {
  veh_buffel = getent("savimbi_buffel", "targetname");
  veh_buffel veh_magic_bullet_shield(1);
  veh_buffel hidepart("tag_mirror");
  level thread savannah_board_buffel_savimbi();
  level thread ready_to_mount_buffel();
  t_use = getent("trigger_board_buffel", "targetname");
  t_use waittill("trigger");
  t_use delete();
  level.player enableinvulnerability();
  flag_set("savannah_player_boarded_buffel");
  level thread setup_final_launchers();
  veh_buffel thread warp_buffel();
  run_scene("player_board_buffel");
  delay_thread(0.2, ::run_retreat_scene, 1);
  delay_thread(1.1, ::run_retreat_scene, 2);
  delay_thread(0.9, ::run_retreat_scene, 3);
  delay_thread(0.6, ::run_retreat_scene, 4);
  level.savimbi detach("t6_wpn_ar_fal_prop_world", "tag_weapon_left");
  level clientnotify("pobws");
  delay_thread(1, ::unita_say, "uni1_they_are_retreating_0");
  delay_thread(1.5, ::unita_say, "uni2_kill_them_all_0");
  level thread run_scene("savimbi_ride_idle");
  level thread run_scene("player_ride_buffel");
  level thread refill_player_clip();
  level.player player_enable_weapons();
  level.player showviewmodel();
  level.player allowsprint(0);
  wait 1;
  e_mortar1 = getent("final_push_mortar1", "targetname");
  e_mortar2 = getent("final_push_mortar2", "targetname");
  e_mortar3 = getent("final_push_mortar3", "targetname");
  delay_thread(0.1, ::savannah_hill_deform_terrain, 5);
  flag_set("final_push");
  wait 0.05;
  veh_buffel setspeed(7);
  wait 0.5;
  wait 0.1;
  playsoundatposition("exp_mortar", e_mortar2.origin);
  playfx(getfx("mortar_savannah"), e_mortar2.origin);
  wait 0.35;
  playsoundatposition("exp_mortar", e_mortar3.origin);
  playfx(getfx("mortar_savannah"), e_mortar3.origin);
}

run_retreat_scene(n_scene) {
  ai_retreat = get_ais_from_scene("push_retreat" + n_scene);
  level thread run_scene("push_retreat" + n_scene);
  ai_retreat[0] thread stop_magic_bullet_shield();
  ai_retreat[0] delay_thread(randomfloatrange(13, 15), ::kill_fighter);
}

ready_to_mount_buffel() {
  wait 14;
  set_objective(level.obj_get_to_buffel, getent("trigger_board_buffel", "targetname"), "use", undefined, undefined, 12);
  t_use = getent("trigger_board_buffel", "targetname");
  t_use trigger_on();
  level thread savannah_board_buffel_fail();
}

setup_final_launchers() {
  flag_wait("push_forward_ready");
}

savannah_board_buffel_savimbi() {
  level endon("savannah_player_boarded_buffel");
  level thread run_scene("savimbi_climb_on_again");
  wait 0.05;
  e_savimbi_enemy = get_ais_from_scene("savimbi_climb_on_again", "climb_enemy");
  e_savimbi_enemy.ignoreme = 1;
  e_savimbi_enemy disableaimassist();
  scene_wait("savimbi_climb_on_again");
  flag_set("savimbi_boarded");
  level thread run_scene("savimbi_climb_idle");
  level thread run_scene("savimbi_climb_enemy_loop");
}

savannah_board_buffel_fail() {
  level endon("savannah_player_boarded_buffel");
  wait 10;
  level.savimbi say_dialog("savi_mason_get_on_the_b_0");
  wait 15;
  level.savimbi say_dialog("savi_we_re_ready_to_move_0");
}

savannah_mortars() {
  level._explosion_stopnotify["mortar_savannah"] = "stop_mortars";
  level thread maps\_mortar::set_mortar_delays("mortar_savannah", 3, 6);
  level thread maps\_mortar::set_mortar_damage("mortar_savannah", 256, 1001, 1003);
  level thread maps\_mortar::mortar_loop("mortar_savannah");
  flag_wait("savannah_done");
  level notify("stop_mortars");
}

savannah_finish() {
  flag_wait("savannah_done");
  setailimit(24);
  spawn_manager_set_global_active_count(22);
  s_buffel_target = getstruct("victory_shots_target", "targetname");
  level thread prep_victory_shots();
  drones_set_max_ragdolls(0);
  fx_node = getvehiclenode("victory_fx", "targetname");
  playfx(getfx("fx_ango_smoke_distant_lrg"), fx_node.origin);
  savimbi_start_node = getvehiclenode("victory_shots_start", "targetname");
  savimbi_buffel = getent("savimbi_buffel", "targetname");
  savimbi_buffel veh_magic_bullet_shield(1);
  savimbi_buffel hidepart("tag_mirror");
  buffel2 = spawn_vehicle_from_targetname("victory_buffel");
  buffel2 veh_magic_bullet_shield(1);
  buffel2.drivepath = 1;
  buffel2 thread load_buffel();
  buffel2 thread victory_buffel_fire();
  end_scene("player_ride_buffel");
  level thread run_scene("return_to_buffel");
  flag_wait("victory_start");
  savimbi_buffel thread go_path(savimbi_start_node);
  buffel2 thread go_path();
  savimbi_buffel setspeed(10);
  e_target = spawn("script_origin", s_buffel_target.origin);
  savimbi_buffel maps\_turret::set_turret_target(e_target, undefined, 1);
  tank = spawn_vehicle_from_targetname("victory_tank");
  wait 0.3;
  tank notify("death");
  maps\_drones::drones_speed_modifier("victory_mpla_drones", -0.4, -0.2);
  delay_thread(4.5, ::drones_start, "victory_mpla_drones");
  level thread run_scene_first_frame("savannah_kill_shots_enemy");
  level thread victory_shot_friendlies();
  prep_victory_shot();
  wait 0.05;
  level thread run_scene("return_to_buffel_enemies");
  level.player playrumblelooponentity("tank_rumble");
  level thread maps\createart\angola_art::savimbi_ride_along_on();
  autosave_by_name("savannah_victory_shots");
  scene_wait("return_to_buffel");
  level thread run_scene("buffel_ride_end");
  level thread refill_player_clip();
  level.player player_enable_weapons();
  level.player showviewmodel();
  level.player allowsprint(0);
  level.player notsolid();
  savimbi_buffel notsolid();
  savimbi_buffel waittill("reached_end_node");
  rpc("clientscripts/angola_amb", "sndSetEndSnapshot");
  level thread maps\createart\angola_art::savimbi_ride_along_off();
  flag_set("cleanup_victory_shots");
  end_scene("buffel_ride_end");
  level.player stoprumble("tank_rumble");
  wait 0.05;
  level thread run_scene("savannah_ending", 1);
  level thread run_scene("savannah_kill_shots_enemy");
  level thread run_scene("savannah_kill_shots_friendly");
  level thread run_scene("savannah_kill_shots_friendly2");
  level thread prep_scene_heli();
  level.player disableweapons();
  level.player hideviewmodel();
  wait 0.1;
  level thread run_scene("savannah_ending_fx");
  level thread finish_background_vehicles();
  flag_wait("end_angola");
  screen_fade_out(0.95);
  wait 0.95;
  clientnotify("end_fade");
  nextmission();
}

prep_scene_heli() {
  wait 0.1;
  scene_heli = get_model_or_models_from_scene("savannah_ending", "hudson_helicopter_end");
  level.player playloopsound("veh_helo_idle_swt", 1);
  scene_heli hidepart("Tag_gunner_barrel2");
  scene_heli hidepart("Tag_gunner_barrel4");
  scene_heli hidepart("Tag_gunner_barrel1");
  scene_heli hidepart("Tag_gunner_barrel3");
  scene_heli setrotorspeed(0.7);
}

prep_victory_shot() {
  vh_end_buffel = getent("savimbi_buffel", "targetname");
  victory_align = spawn("script_origin", vh_end_buffel.origin);
  victory_align.targetname = "savimbi_buffel_end_enemies";
}

place_victory_bodies() {
  index = 0;
  death_node_array = getstructarray("deathpose", "targetname");

  for(x = 0; x < death_node_array.size; x++) {
    death_struct = death_node_array[x];
    dead_drone = create_enemy_model_actor();
    index++;

    if(index > 6)
      index = 1;

    str_scene = "deathanim_" + index;
    death_struct thread maps\_anim::anim_loop_aligned(dead_drone, str_scene, undefined, undefined, "generic");
    wait 0.05;
  }
}

victory_buffel_fire() {
  flag_wait("victory_buffel_fire");
  wait 0.05;
  self thread victory_buffel_target();
  self maps\_turret::fire_turret_for_time(1, 1);
  wait 1;
  self maps\_turret::fire_turret_for_time(5, 1);
}

victory_buffel_target() {
  temp_target_model = spawn_model("tag_origin");

  for(x = 3; x < 8; x++) {
    temp_target = getstruct("victory_target" + x, "script_noteworthy");
    temp_target_model.origin = temp_target.origin + vectorscale((0, -1, 0), 5.0);
    self maps\_turret::set_turret_target(temp_target_model, undefined, 1);
    wait 1.5;
  }

  temp_target_model delete();
}

finish_background_vehicles() {
  vh_hill_eland = spawn_vehicle_from_targetname("start_convoy_eland");
  nd_hill_eland = getvehiclenode("victory_eland_extra", "targetname");
  vh_hill_eland veh_magic_bullet_shield(1);
  vh_hill_buffel = spawn_vehicle_from_targetname("start_convoy_buffel_turret");
  nd_hill_buffel = getvehiclenode("victory_buffel_extra1", "targetname");
  vh_hill_buffel thread load_buffel();
  vh_hill_buffel veh_magic_bullet_shield(1);
  vh_hill_buffel2 = spawn_vehicle_from_targetname("start_convoy_buffel_turret");
  nd_hill_buffel2 = getvehiclenode("victory_buffel_extra2", "targetname");
  vh_hill_buffel2 thread load_buffel();
  vh_hill_buffel2 veh_magic_bullet_shield(1);
  wait 10;
  vh_hill_eland thread go_path(nd_hill_eland);
  vh_hill_buffel thread go_path(nd_hill_buffel);
  vh_hill_buffel2 thread go_path(nd_hill_buffel2);
}

cleanup_hill_ai() {
  delete_array("hill_shooter_ai", "targetname");
  delete_array("hill_axis_ai", "targetname");
  delete_array("hill_machete_ai", "targetname");
}

heli_custom_flyby() {
  wait 2.5;
  self playsound("veh_hudson_heli_flyby");
}

heli_strafing_watch() {
  if(!flag("skipto_debug_heli_strafe"))
    flag_wait_or_timeout("savannah_start_hudson", 15);

  veh_hudson_heli = spawn_vehicle_from_targetname("hudson_helicopter");
  veh_hudson_heli setforcenocull();
  veh_hudson_heli veh_magic_bullet_shield(1);
  level.veh_hudson_heli = veh_hudson_heli;
  nd_start = getvehiclenode("heli_strafe_path", "targetname");
  nd_start2 = getvehiclenode("heli_strafe_path2", "targetname");
  nd_start3 = getvehiclenode("heli_strafe_path3", "targetname");
  nd_start_first_wave = getvehiclenode("heli_first_wave_path", "targetname");
  nd_end = getvehiclenode("heli_return_path", "targetname");
  nd_end2 = getvehiclenode("heli_return_path2", "targetname");
  nd_end3 = getvehiclenode("heli_return_path3", "targetname");
  nd_intro = getvehiclenode("heli_intro_path", "targetname");
  level thread run_scene("hudson_ride_idle");
  wait 0.05;
  level.hudson = get_model_or_models_from_scene("hudson_ride_idle", "hudson");
  veh_hudson_heli.drivepath = 1;
  veh_hudson_heli thread go_path(nd_intro);
  veh_hudson_heli thread heli_intro_fire();
  veh_hudson_heli thread heli_custom_flyby();
  veh_hudson_heli waittill("shoot_up");
  level thread mpla_shoot_hudson();
  level thread animate_grass(0);

  if(!flag("skipto_debug_heli_strafe"))
    wait 25;

  while(!flag("savannah_final_push")) {
    switch (level.num_heli_runs) {
      case 0:
        flag_wait("tank_vo_finished");
        aim_node = getvehiclenode("heli_first_wave_path", "targetname");
        break;
      default:
        flag_wait("technical_gunners_destroyed");
        aim_node = getvehiclenode("heli_strafe_path2", "targetname");
        break;
    }

    veh_hudson_heli settargetorigin(aim_node.origin);
    wait 0.2;
    level.player vo_strafing_run_ready();
    self waittill_call_strafe_run(1);
    veh_hudson_heli thread heli_strafe_check_fail();

    switch (level.num_heli_runs) {
      case 0:
        self heli_strafe_run(veh_hudson_heli, nd_start_first_wave, nd_end2);
        break;
      case 1:
        level thread wait_for_wave3_spawn();
        self heli_strafe_run(veh_hudson_heli, nd_start2, nd_end3);
        break;
      case 2:
        self heli_strafe_run(veh_hudson_heli, nd_start, nd_end2);
        break;
      default:
        self heli_strafe_run(veh_hudson_heli, nd_start, nd_end2);
        break;
    }

    if(!flag("savannah_final_push")) {
      switch (level.num_heli_runs) {
        case 1:
          wait 35;
          break;
        default:
          wait 35;
          break;
      }
    }
  }
}

force_heli_turret_forward() {
  level endon("player_in_helicopter");

  while(true) {
    self settargetorigin(anglestoforward(self.angles) * 100);
    wait 0.05;
  }
}

heli_intro_fire() {
  flag_wait("heli_flyby_shoot");
  heli_target_array = getentarray("heli_fire_spots", "script_noteworthy");

  for(x = 0; x < 4; x++) {
    self firegunnerweapon(2);
    wait 0.3;
  }
}

mpla_shoot_hudson() {
  level thread mpla_rpg_hudson();
  flag_wait("savannah_done");
  ai = getentarray("chopper_guy_ai", "targetname");

  for(i = 0; i < ai.size; i++)
    ai[i] delete();
}

mpla_rpg_hudson() {
  rpg1 = getstruct("hill_launcher_fire_pos", "targetname");
  rpg2 = getent("hill_launcher4", "targetname");
  rpg3 = getent("hill_launcher3", "targetname");
  heli = getent("hudson_helicopter", "targetname");
  wait 2.5;
  level thread fire_magic_rpg(rpg1.origin, heli.origin, 0);
  wait 0.3;
  level thread fire_magic_rpg(rpg1.origin, heli.origin, 0);
  wait 0.5;
  level thread fire_magic_rpg(rpg3.origin, heli.origin, 0);
}

heli_final_call_fail() {
  level endon("strafe_run_called");
}

heli_strafe_check_fail() {
  self waittill("start_fade");

  switch (level.num_heli_runs) {
    case 1:
      if(1)
        level thread kill_off_tanks("wave_one_tank", "targetname");
      else
        missionfailedwrapper(&"ANGOLA_STRAFE_FAIL");

      break;
    case 2:
      if(1) {
        level thread kill_off_tanks("wave_two_tank", "targetname");
        level thread kill_off_tanks("final_push_tank", "script_noteworthy");
      } else
        missionfailedwrapper(&"ANGOLA_STRAFE_FAIL");

      break;
  }
}

kill_off_tanks(str_name, str_key) {
  a_veh_tanks = getentarray(str_name, str_key);

  foreach(veh_tank in a_veh_tanks) {
    if(isalive(veh_tank)) {
      playsoundatposition("exp_mortar", veh_tank.origin);
      playfx(getfx("mortar_savannah"), veh_tank.origin);
      veh_tank notify("death");
    }
  }
}

waittill_call_strafe_run(b_fail_watch) {
  if(!isDefined(b_fail_watch))
    b_fail_watch = 0;

  flag_set("strafe_hint_active");
  wait 0.05;
  screen_message_create(&"ANGOLA_STRAFE_HINT");
  level thread toggle_player_radio(1);
  level thread call_strafe_nag();
  level thread stream_hint_radio_model();

  if(b_fail_watch)
    level thread watch_strafe_call_fail();

  while(level.player getcurrentweapon() != "air_support_radio_sp")
    wait 0.05;

  level.player playsound("evt_switch_button");
  level.player thread say_dialog("maso_take_out_the_tanks_0");
  level.player enableinvulnerability();
  wait 1;
  level notify("strafe_run_called");
  level.player playsound("evt_to_heli_transition_f");
  screen_message_delete();
  flag_clear("strafe_hint_active");
}

stream_hint_radio_model() {
  level endon("strafe_run_called");

  while(true) {
    createstreamermodelhint("prop_mp_handheld_radio", 5.0);
    wait 1;
  }
}

watch_strafe_call_fail() {
  level endon("strafe_run_called");
}

call_strafe_nag() {
  level endon("strafe_run_called");
  wait 5;

  switch (level.num_heli_runs) {
    case 0:
      level.player thread say_dialog("huds_mason_i_ll_provide_0");
      break;
    default:
      level.player thread say_dialog("huds_waiting_on_your_go_0");
      break;
  }
}

heli_strafe_run(veh_hudson_heli, nd_start, nd_end) {
  v_player_origin = self.origin;
  v_player_angles = self getplayerangles();
  freeze_player_controls(1);
  level.player setclientdvar("r_lodScaleRigid", 0.1);
  flag_set("player_in_helicopter");
  level clientnotify("heli_int");

  if(level.num_heli_runs == 0)
    level thread heli_strafe_run_controls();

  level.num_heli_runs++;
  level.drones.death_func = ::drone_helideath;
  rpc("clientscripts/angola", "fade_in_static");

  if(level.player.health > 0)
    level.player.health = 100;

  maps\_gameskill::toggle_health_overlay(0);
  level.player hide_hud();
  wait 0.2;
  veh_hudson_heli.origin = nd_start.origin;
  veh_hudson_heli.angles = nd_start.angles;
  aim_node = getvehiclenode(nd_start.target, "targetname");
  veh_hudson_heli settargetorigin(aim_node.origin);
  wait 0.25;
  n_default_fov = getdvarfloat(#"cg_fov");
  self setclientdvar("cg_fov", 60);
  self setclientdvar("scr_damagefeedback", 0);
  level heli_run_dof_on();
  level thread return_prep();
  level.friendlyfiredisabled = 1;

  if(flag("savannah_final_push")) {
    end_scene("player_ride_buffel");
    level.player unlink();
    wait 0.05;
  }

  veh_hudson_heli makevehicleusable();
  veh_hudson_heli usevehicle(self, 0);
  self playrumblelooponentity("angola_hind_ride");
  self disableusability();
  self enableinvulnerability();
  self stopshellshock();
  veh_hudson_heli.drivepath = 0;
  veh_hudson_heli cleartargetyaw();
  veh_hudson_heli thread go_path(nd_start);
  veh_hudson_heli thread heli_strafe_controls();
  wait 0.9;
  freeze_player_controls(0);
  wait 1.5;
  self setclientdvar("cg_objectiveIndicatorFarFadeDist", 8000);
  veh_hudson_heli thread vo_strafing_run_start();
  veh_hudson_heli waittill("start_fade");
  level.player playsound("evt_from_heli_transition_f");
  self setclientdvar("cg_objectiveIndicatorFarFadeDist", 3000);
  rpc("clientscripts/angola", "fade_out_static");
  wait 0.5;
  freeze_player_controls(1);
  wait 0.5;
  flag_set("stop_strafe_quake");
  screen_message_delete();
  veh_hudson_heli makevehicleunusable();
  veh_hudson_heli useby(self);
  veh_hudson_heli thread go_path(nd_end);
  veh_hudson_heli setdefaultpitch(10);
  veh_hudson_heli thread hover_at_end();
  level.friendlyfiredisabled = 0;

  if(isDefined(veh_hudson_heli.target_reticule))
    veh_hudson_heli.target_reticule delete();

  level.drones.death_func = ::drone_savannahdeath;

  if(!level.console)
    level.dont_save_now = 1;

  switch (level.num_heli_runs) {
    case 1:
      autosave_by_name("savannah_first_strafe");
      level thread savimbi_return_fight();
      level thread buffel_riders_fight();
      level thread spawn_technicals();
      level thread reset_ai_limit();
      break;
    case 2:
      break;
  }

  if(flag("savannah_final_push")) {
    autosave_by_name("savannah_final_push");
    s_player_pos = getstruct("player_board_start", "targetname");
    v_player_origin = s_player_pos.origin;
    v_player_angles = s_player_pos.angles;
  }

  if(flag("wave_one_done"))
    delay_thread(1, ::prep_wave_two);

  self setorigin(v_player_origin);
  self setplayerangles(v_player_angles);
  flag_clear("stop_strafe_quake");
  flag_clear("player_in_helicopter");
  self stoprumble("angola_hind_ride");
  level clientnotify("heli_done");

  if(flag("savannah_final_push_success")) {
    end_scene("savimbi_ride_idle");
    end_scene("player_ride_buffel");
    delay_thread(2.5, ::vo_strafing_run_stop);
    flag_set("savannah_done");
  } else {
    create_after_strafe_fights(level.num_heli_runs);
    delay_thread(2.0, ::vo_strafing_run_stop);
  }

  self setclientdvar("cg_fov", n_default_fov);
  self setclientdvar("scr_damagefeedback", 1);
  heli_run_dof_off();
  level.player setclientdvar("r_lodScaleRigid", 1.0);
  level thread screen_fade_in(2);
  wait 0.8;
  level.player show_hud();
  maps\_gameskill::toggle_health_overlay(1);
  freeze_player_controls(0);

  if(!level.console)
    level.dont_save_now = undefined;

  wait 1.2;
  self thread heli_lingering_invincibility();
}

reset_ai_limit() {
}

hover_at_end() {
  self waittill("reached_end_node");
  self setvehgoalpos(self.origin, 1);
}

vo_strafing_run_start() {
  if(!flag("savannah_final_push")) {
    switch (level.num_heli_runs) {
      case 1:
        level.player say_dialog("huds_beginning_strafing_r_0");
        wait 2;
        level.player say_dialog("huds_bastards_are_taking_0");
        wait 0.1;
        level.player say_dialog("huds_sooner_or_later_on_0");
        break;
      case 2:
        level.player say_dialog("huds_okay_coming_round_a_0");
        break;
      case 3:
        level.player say_dialog("huds_okay_coming_round_a_0");
        break;
    }
  } else
    level.player say_dialog("maso_bring_down_the_rain_0");
}

vo_strafing_run_stop() {
  if(!flag("savannah_final_push")) {
    switch (level.num_heli_runs) {
      case 1:
        level.player say_dialog("maso_nice_work_hudson_0");
        wait 0.1;
        level.player say_dialog("maso_there_s_an_mg_truck_0");
        wait 0.3;
        level.player say_dialog("huds_i_can_t_make_another_0");
        wait 0.3;
        level.player say_dialog("maso_i_ll_deal_with_it_0");
        flag_set("mg_objective_ready");
        delay_thread(1, ::unita_say, "uni2_enemy_mg_truck_incom_0");
        delay_thread(2, ::unita_say, "uni2_enemy_tanks_on_the_h_0");
        delay_thread(3, ::unita_say, "uni1_push_forward_0");
        delay_thread(4, ::unita_say, "uni3_keep_fighting_our_0");
        delay_thread(5, ::unita_say, "uni1_hold_your_ground_no_0");
        delay_thread(6, ::unita_say, "uni1_protect_the_convoy_0");
        delay_thread(6.5, ::unita_say, "uni1_come_on_hurry_0");
        break;
      case 2:
        delay_thread(1, ::unita_say, "uni0_the_tanks_are_down_0");
        break;
    }
  } else {
    level.player say_dialog("huds_shit_mason_stray_0");
    level.player say_dialog("huds_i_can_t_make_another_1");
  }
}

vo_strafing_run_ready() {
  switch (level.num_heli_runs) {
    case 1:
      break;
    case 2:
      level.player say_dialog("maso_damn_i_think_you_m_0");
      break;
    case 3:
      level.player say_dialog("huds_one_more_run_let_s_0");
      break;
  }
}

heli_strafe_run_controls() {
  level endon("stop_strafe_quake");
  wait 1;
  screen_message_create(&"ANGOLA_HELI_MG", & "ANGOLA_HELI_ROCKET");
  level.player waittill_ads_button_pressed();
  screen_message_delete();
}

heli_lingering_invincibility() {
  wait 3;
  self enableusability();
  self disableinvulnerability();
}

heli_strafe_controls() {
  self endon("start_fade");
  self thread heli_aim_update();
  self thread heli_weapon_controls();
  self thread heli_missile_controls();
  self thread heli_screen_shake(level.num_heli_runs);
}

heli_weapon_controls() {
  self endon("start_fade");
  fire_time = weaponfiretime(self seatgetweapon(1));

  while(true) {
    if(level.player attackbuttonpressed()) {
      self firegunnerweapon(0);
      self firegunnerweapon(1);
      wait(fire_time);
    } else
      wait 0.05;
  }
}

heli_missile_controls() {
  self endon("start_fade");
  fire_time = weaponfiretime(self seatgetweapon(3));

  while(true) {
    if(level.player throwbuttonpressed()) {
      self firegunnerweapon(2);
      self firegunnerweapon(3);
      wait(fire_time);
    } else
      wait 0.05;
  }
}

heli_aim_update() {
  self endon("start_fade");

  while(true) {
    angles = self gettagangles("tag_flash");
    angles = (angles[0], angles[1], 0);
    dir = anglestoforward(angles);
    start_point = level.player geteye();
    target_point = level.player.origin + dir * 15000;
    trace = bullettrace(start_point, target_point, 0, self, 0);

    if(trace["fraction"] != 1)
      target_point = trace["position"];

    self setgunnertargetvec(target_point, 0);
    self setgunnertargetvec(target_point, 1);
    self setgunnertargetvec(target_point, 2);
    self setgunnertargetvec(target_point, 3);
    wait 0.05;
  }
}

heli_screen_shake(n_num_heli_runs) {
  level endon("stop_strafe_quake");

  while(true) {
    switch (n_num_heli_runs) {
      case 1:
        earthquake(0.15, 0.05, level.player.origin, 100);
        break;
      default:
        earthquake(0.2, 0.05, level.player.origin, 100);
        break;
    }

    wait 0.05;
  }
}

tank_think() {
  self.overridevehicledamage = ::tank_damage_callback;
  self thread tank_fire();
  self thread tank_objective_display();
  self waittill("death");

  if(isDefined(self.targetname) && self.targetname == "wave_one_tank") {
    if(level.savannah_first_wave_kills < 4) {
      level.savannah_first_wave_kills++;

      if(level.savannah_first_wave_kills == 4)
        set_objective(level.obj_destroy_first_wave, undefined, "delete");
    }
  } else if(isDefined(self.targetname) && self.targetname == "wave_two_tank" || isDefined(self.script_noteworthy) && self.script_noteworthy == "final_push_tank") {
    if(level.savannah_second_wave_kills < 9) {
      level.savannah_second_wave_kills++;

      if(level.savannah_second_wave_kills == 9)
        set_objective(level.obj_destroy_second_wave, undefined, "delete");
    }
  }

  playfxontag(getfx("fx_ango_smoke_distant_lrg_2"), self, "tag_origin");
}

tank_objective_display() {
  n_x_objective = getvehiclenode("heli_strafe_path", "targetname").origin[0] + 750;

  if(isDefined(self.targetname) && self.targetname == "wave_one_tank") {
    flag_wait("player_in_helicopter");
    wait 1;

    if(self.health > 0) {
      set_objective(level.obj_destroy_first_wave, self, & "SP_OBJECTIVES_DESTROY", -1);
      self waittill("death");
      set_objective(level.obj_destroy_first_wave, self, "remove");
    }
  } else if(isDefined(self.targetname) && self.targetname == "wave_two_tank" || isDefined(self.script_noteworthy) && self.script_noteworthy == "final_push_tank") {
    flag_wait("player_in_helicopter");
    wait 1;
    set_objective(level.obj_destroy_second_wave, self, & "SP_OBJECTIVES_DESTROY", -1);
    self waittill("death");
    set_objective(level.obj_destroy_second_wave, self, "remove");
  }
}

tank_fire() {
  switch (level.num_heli_runs) {
    case 0:
      a_target_pos = getentarray("savannah_tank_target", "targetname");
      break;
    default:
      a_target_pos = getentarray("savannah_tank_target2", "targetname");
      break;
  }

  e_target = spawn("script_origin", a_target_pos[0].origin);

  while(isalive(self) && !flag("savannah_final_push_success")) {
    wait(randomfloatrange(1.0, 2.0));

    if(!flag("pause_fire")) {
      if(isalive(self) && !flag("pause_fire"))
        self setturrettargetent(e_target);

      e_target moveto(a_target_pos[randomint(a_target_pos.size)].origin, randomfloatrange(2.0, 4.0), 1.0, 1.0);
      e_target waittill("movedone");

      if(isalive(self) && !flag("pause_fire"))
        self fireweapon();
    }
  }

  e_target delete();
}

tank_fire_target(e_target, b_scene, n_wait) {
  if(!isDefined(b_scene))
    b_scene = 0;

  self notify("pause_fire");

  if(isDefined(self))
    self setturrettargetent(e_target);

  if(isDefined(n_wait) && n_wait)
    wait(n_wait);
  else
    wait 1.5;

  if(isDefined(self))
    self fireweapon();

  flag_clear("pause_fire");

  if(b_scene)
    level thread savannah_destroy_eland();
}

tank_fire_position(v_target, n_wait) {
  self notify("pause_fire");
  self setturrettargetvec(v_target);

  if(isDefined(n_wait) && n_wait)
    wait(n_wait);
  else
    wait 1.5;

  self fireweapon();
  flag_clear("pause_fire");
  self clearturrettarget();
}

tank_finish_path() {
  self endon("death");
  self waittill("reached_end_node");
  level.savannah_tank_safety--;
  self notify("death");
}

tank_damage_callback(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(isDefined(sweapon)) {
    if(sweapon == "alouette_missile_turret" && level.num_heli_runs > 0) {
      level.tank_kill_count++;

      if(level.tank_kill_count == 13)
        level.player notify(level.tank_notify);

      return 9999;
    } else
      return 0;
  }

  return 0;
}

#using_animtree("fakeshooters");

drone_helideath() {
  self endon("delete");
  self endon("drone_death");
  explosivedeath = 0;
  explosion_ori = (0, 0, 0);
  bone[0] = "J_Knee_LE";
  bone[1] = "J_Ankle_LE";
  bone[2] = "J_Clavicle_LE";
  bone[3] = "J_Shoulder_LE";
  bone[4] = "J_Elbow_LE";

  while(isDefined(self)) {
    self setcandamage(1);
    self waittill("damage", amount, attacker, direction_vec, damage_ori, type);

    if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_EXPLOSIVE" || type == "MOD_EXPLOSIVE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
      self.damageweapon = "none";
      explosivedeath = 1;
      explosion_ori = damage_ori;
    }

    self death_notify_wrapper(attacker, type);

    if(self.team == "axis" && (isplayer(attacker) || attacker == level.playervehicle)) {
      level notify("player killed drone");
      n_impacts = 1 + randomint(2);

      for(i = 0; i < n_impacts; i++) {
        playfxontag(getfx("drone_impact"), self, bone[randomint(bone.size)]);
        wait 0.05;
      }

      attacker thread maps\_damagefeedback::updatedamagefeedback();
    }

    if(!isDefined(self)) {
      return;
    }
    self notify("stop_shooting");
    self.dontdelete = 1;
    self useanimtree(#animtree);

    if(isDefined(self.running)) {
      deaths[0] = % run_death_facedown;
      deaths[1] = % run_death_fallonback;
      deaths[2] = % run_death_roll;
      deaths[3] = % run_death_flop;
    } else {
      deaths[0] = % ai_death_collapse_in_place;
      deaths[1] = % ai_death_faceplant;
      deaths[2] = % ai_death_fallforward;
      deaths[3] = % ai_death_fallforward_b;
    }

    self thread drone_dodeath(deaths[randomint(deaths.size)]);
    return;
  }
}

drone_savannahdeath(instant, flamedeath) {
  if(!isDefined(instant))
    instant = 0;

  self endon("delete");
  self endon("drone_death");

  while(isDefined(self)) {
    if(!instant) {
      self setcandamage(1);
      self waittill("damage", damage, attacker, direction_vec, damage_ori, type, tagname, modelname, partname, weaponname);

      if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_EXPLOSIVE" || type == "MOD_EXPLOSIVE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH") {
        if(damage == 1) {
          self thread drone_fakedeath();
          return;
        }

        if(attacker == level.player && weaponname == "mortar_shell_dpad_sp") {
          level.mortar_kills++;

          if(level.mortar_kills == 1)
            level thread mortar_kill_timer();
        }

        self.damageweapon = "none";
        explosivedeath = 1;
      } else if(type == "MOD_BURNED")
        flamedeath = 1;

      self death_notify_wrapper(attacker, type);

      if(self.team == "axis" && (isplayer(attacker) || attacker == level.playervehicle)) {
        level notify("player killed drone");
        attacker thread maps\_damagefeedback::updatedamagefeedback();
      }
    }

    if(!isDefined(self)) {
      return;
    }
    self notify("stop_shooting");
    self.dontdelete = 1;
    self useanimtree(#animtree);

    if(isDefined(explosivedeath) && explosivedeath && !(isDefined(level.disable_drone_explosive_deaths) && level.disable_drone_explosive_deaths)) {
      direction = drone_get_explosion_death_dir(self.origin, self.angles, damage_ori, 50);
      self thread drone_mortardeath(direction);
      return;
    } else if(isDefined(flamedeath) && flamedeath) {
      deaths[0] = % ai_flame_death_a;
      deaths[1] = % ai_flame_death_b;
      deaths[2] = % ai_flame_death_c;
      deaths[3] = % ai_flame_death_d;
    } else if(isDefined(self.running)) {
      deaths[0] = % run_death_facedown;
      deaths[1] = % run_death_fallonback;
      deaths[2] = % run_death_roll;
      deaths[3] = % run_death_flop;
    } else {
      deaths[0] = % ai_death_collapse_in_place;
      deaths[1] = % ai_death_faceplant;
      deaths[2] = % ai_death_fallforward;
      deaths[3] = % ai_death_fallforward_b;
    }

    self thread drone_dodeath(deaths[randomint(deaths.size)]);
    return;
  }
}

eland_think(b_reach) {
  level endon("stop_fire");
  level endon("death");

  if(self.vehicletype != "tank_eland") {
    return;
  }
  if(isDefined(b_reach) && b_reach) {
    self waittill_any("reached_end_node", "begin_firing");
    self setspeedimmediate(0);
  } else if(self.targetname == "riverbed_convoy_eland")
    return;
  else
    level endon("stop_convoy_fire");

  switch (self.targetname) {
    case "eland_hero":
    case "riverbed_convoy_eland":
      a_target_pos1 = getstructarray("left_side", "script_noteworthy");
      a_target_pos2 = getstructarray("left_center", "script_noteworthy");
      a_target_pos = arraycombine(a_target_pos1, a_target_pos2, 1, 0);
      break;
    default:
      a_target_pos = getstructarray("right_side", "script_noteworthy");
      break;
  }

  e_target = spawn("script_origin", a_target_pos[0].origin);
  self setturrettargetent(e_target);

  while(isalive(self) && !flag("savannah_final_push_success")) {
    wait(randomfloatrange(3.0, 6.0));
    e_target moveto(a_target_pos[randomint(a_target_pos.size)].origin, randomfloatrange(2.0, 4.0), 1.0, 1.0);
    e_target waittill("movedone");

    if(isalive(self)) {
      self fireweapon();
      playrumbleonposition("grenade_rumble", self.origin);
    }
  }

  e_target delete();
}

return_prep() {
  switch (level.num_heli_runs) {
    case 1:
      level thread kill_hill_rpgs();
      vh_buffel = getent("savimbi_buffel", "targetname");
      v_origin = vh_buffel gettagorigin("tag_origin");
      v_angles = vh_buffel gettagangles("tag_origin");
      level.savimbi_strafe1 = spawn("script_origin", v_origin);
      level.savimbi_strafe1.angles = v_angles;
      level.savimbi_strafe1.targetname = "savimbi_buffel_strafe1";
      break;
    case 2:
      m_buffel_flipper = getent("buffel_flip_guy1_drone", "targetname");
      delete_scene_all("buffel_tip_guys", 1);
      level thread protect_convoy();
      delete_scene_all("savimbi_buffel_shooters_attack", 1);
      level thread kill_wave_one_rpgs();
      flag_set("savannah_final_warp");
      vh_old_buffel = getent("savimbi_buffel", "targetname");
      vh_old_buffel unload_buffel();
      wait 0.05;
      vh_old_buffel delete();
      vh_new_buffel = spawn_vehicle_from_targetname("savimbi_buffel2");
      vh_new_buffel thread veh_magic_bullet_shield(1);
      wait 0.05;
      vh_new_buffel.targetname = "savimbi_buffel";
      vh_new_buffel load_buffel();
      vh_new_buffel thread buffel_gunner_think();
      wait 0.1;
      vh_new_buffel thread player_convoy_watch("savannah_final_push_success");
      break;
  }

  level thread toggle_player_radio(0);
}

hero_eland_scene() {
  level thread run_scene("eland_hero_fire");
}

eland_hero_shoot() {
  vh_hero_eland = getent("eland_hero", "targetname");
  vh_hero_eland fireweapon();
  playrumbleonposition("grenade_rumble", vh_hero_eland.origin);
}

savannah_buffel_tip() {
  self maps\_vehicle::getoffpath();
  wait 0.1;
  playsoundatposition("exp_mortar", self.origin);
  playfx(getfx("mortar_savannah"), self.origin);

  foreach(rider in self.riders)
  rider delete();

  self.fire_turret = 0;
  self.takedamage = 0;
  fake_buffel = spawn_model("veh_t6_mil_buffelapc", self.origin, self.angles);
  fake_buffel.targetname = "fake_convoy_buffel";
  playfxontag(getfx("fx_ango_buffel_smoke"), fake_buffel, "tag_origin");
  level thread run_scene("buffel_tip");
  level thread run_scene("buffel_tip_guys");
  self delete();
  scene_wait("buffel_tip");
  e_buffel_tip_blocker = getent("buffel_tip_blocker", "targetname");
  e_buffel_tip_blocker solid();
  e_buffel_tip_blocker disconnectpaths();
  level run_scene("buffel_tip_idle");
}

buffel_gunner_think(b_reach, a_fire_nodes) {
  if(!isDefined(b_reach))
    b_reach = 0;

  level endon("stop_fire");
  self endon("stop_fire");
  self endon("death");
  self.fire_turret = 1;

  if(!issubstr(self.vehicletype, "buffel") || self.targetname == "buffel_mortar") {
    return;
  }
  if(b_reach) {
    self waittill_any("reached_end_node", "begin_firing");
    self setspeedimmediate(0);
  } else if(!isDefined(a_fire_nodes)) {
    if(self.targetname == "convoy_destroy_1" || self.targetname == "convoy_destroy_2")
      return;
    else
      level endon("stop_convoy_fire");
  }

  n_vehicle_gun_index = 1;
  n_fire_min = 3;
  n_fire_max = 6;
  n_wait_min = 0.5;
  n_wait_max = 1;
  n_fire_time = 6;
  self maps\_turret::enable_turret(n_vehicle_gun_index);

  if(isDefined(a_fire_nodes))
    a_target_pos = a_fire_nodes;
  else {
    switch (self.targetname) {
      case "convoy_destroy_1":
        a_target_pos = getstructarray("right_side", "script_noteworthy");
        break;
      case "savimbi_buffel":
        a_target_pos = getstructarray("center", "script_noteworthy");
        break;
      case "riverbed_convoy_buffel":
        a_target_pos = getstructarray("left_center", "script_noteworthy");
        break;
      case "convoy_destroy_2":
        a_target_pos = getstructarray("mortar_help", "targetname");
        break;
      case "push_buffel":
        a_target_pos = getstructarray("push_buffel_fire", "targetname");
        break;
      default:
        a_target_pos = getstructarray("right_side", "script_noteworthy");
        break;
    }
  }

  e_target = spawn("script_origin", a_target_pos[0].origin);
  self maps\_turret::set_turret_target(e_target, undefined, n_vehicle_gun_index);
  wait 0.05;
  self maps\_turret::fire_turret_for_time(n_fire_time, n_vehicle_gun_index);
  self thread fire_buffel_think();

  while(isalive(self) && !flag("savannah_done") && self.fire_turret) {
    e_target moveto(a_target_pos[randomint(a_target_pos.size)].origin, randomfloatrange(2.0, 4.0), 1.0, 1.0);
    n_time = randomfloatrange(3.0, 6.0);
    wait(n_time);
  }

  e_target delete();
}

fire_buffel_think() {
  self endon("death");
  self endon("stop_fire");

  while(isalive(self) && !flag("savannah_done") && self.fire_turret) {
    n_time = randomfloatrange(9.0, 15.0);

    if(isalive(self))
      self maps\_turret::fire_turret_for_time(n_time, 1);

    wait(randomfloatrange(1.0, 2.0));
  }
}

fake_battle_loop() {
  battle_walla_loop = spawn("script_origin", (5783, 1929, 219));
  battle_walla_loop playloopsound("amb_sav_battle_line");
  level waittill("turn_off_walla_loop");
  battle_walla_loop stoploopsound(4);
  wait 10;
  battle_walla_loop delete();
}

start_heli_fire(guy) {
  hudson_heli = getent("hudson_helicopter", "targetname");
  guy shoot_at_target(hudson_heli, undefined, undefined, -1);
}

stop_heli_fire(guy) {
  guy stop_shoot_at_target();
}

init_hill_shooter(n_accuracy) {
  if(!isDefined(n_accuracy))
    n_accuracy = 1;

  self.a.disablelongdeath = 1;

  if(issubstr(self.targetname, "machete"))
    self setthreatbiasgroup("machete_guy");
  else {
    self set_goalradius(50);
    self setthreatbiasgroup("axis_shooters");
    self.script_accuracy = n_accuracy;
  }
}

cleanup_riverbed_scenes() {
  a_soldiers = getentarray("intro_mpla_shooter", "script_noteworthy");

  foreach(soldier in a_soldiers)
  soldier bloody_death();

  a_soldiers = getentarray("intro_soldier", "script_noteworthy");

  foreach(soldier in a_soldiers)
  soldier bloody_death();

  delete_scene("level_intro_chopper", 1);
  delete_scene("level_intro_savimbi_buffel", 1);
  delete_scene("level_intro_savimbi", 1);
  delete_scene("savimbi_ride_rally", 1);
  delete_scene("level_intro_soldier_1", 1);
  delete_scene("level_intro_soldier_2", 1);
  delete_scene("level_intro_soldier_3", 1);
  delete_scene("level_intro_soldier_4", 1);
  delete_scene("level_intro_soldier_5", 1);
  delete_scene("level_intro_soldier_6", 1);
  delete_scene("level_intro_soldier_7", 1);
  delete_scene_all("riverbed_ambience_1", 1);
  delete_scene_all("riverbed_ambience_2", 1);
  delete_scene_all("riverbed_corpses_driver", 1);
  delete_scene_all("riverbed_corpses_1", 1);
  delete_scene_all("riverbed_corpses_2", 1);
  delete_scene_all("riverbed_corpses_3", 1);
  delete_scene_all("riverbed_corpses_4", 1);
  delete_scene_all("riverbed_corpses_5", 1);
  delete_scene_all("riverbed_corpses_6", 1);
  delete_scene_all("riverbed_corpses_7", 1);
  delete_scene_all("riverbed_corpses_8", 1);
  delete_scene_all("riverbed_mortar_react_loop", 1);
  delete_scene_all("riverbed_mortar_react", 1);
  delete_scene_all("riverbed_mortar_react_end", 1);
  delete_scene_all("riverbed_lower_loop", 1);
  delete_scene_all("riverbed_lower", 1);
  delete_scene_all("riverbed_upper_loop", 1);
  delete_scene_all("riverbed_upper", 1);
  delete_scene_all("level_intro_fx", 1);
  delete_scene_all("level_intro_shovel", 1);
  wait 5;
  cleanup_riverbed();
}

cleanup_riverbed() {
  array_delete(getstructarray("mortar_intro", "targetname"), 1);
  array_delete(getstructarray("mortar_riverbed", "targetname"), 1);
  array_delete(getentarray("intro_soldier", "targetname"));
  array_delete(getentarray("intro_soldier", "script_noteworthy"));
  delete_array("burning_man", "targetname");
  delete_array("riverbed_ambience", "targetname");
  array_delete(getentarray("intro_mpla_shooter", "script_noteworthy"));
  delete_array("intro_unita_shooter", "targetname");
  delete_array("intro_mpla_shooter", "targetname");
}

cleanup_post_heli_fight() {
  scene_wait("post_heli_run_fight");
  wait 1;
  delete_scene("post_heli_run_fight", 1);
  wait 1;
  enemy = getent("eland_destroy_enemy", "targetname");
  enemy delete();
}

setup_threat_bias_group() {
  createthreatbiasgroup("player");
  createthreatbiasgroup("savimbi");
  createthreatbiasgroup("axis_shooters");
  createthreatbiasgroup("enemy_dancer");
  createthreatbiasgroup("friendly_dancer");
  createthreatbiasgroup("machete_guy");
  createthreatbiasgroup("rpg_guy");
  createthreatbiasgroup("player_killer");
  createthreatbiasgroup("push_allies");
  createthreatbiasgroup("push_runners");
  level.player setthreatbiasgroup("player");
  level.savimbi setthreatbiasgroup("savimbi");
  setignoremegroup("savimbi", "enemy_dancer");
  setignoremegroup("machete_guy", "savimbi");
  setignoremegroup("savimbi", "machete_guy");
  setignoremegroup("friendly_dancer", "axis_shooters");
  setignoremegroup("friendly_dancer", "machete_guy");
  setignoremegroup("savimbi", "player_killer");
  setignoremegroup("friendly_dancer", "player_killer");
  setignoremegroup("push_allies", "push_runners");
}

setup_wave_one_launchers() {
  add_spawn_function_group("hill_launcher", "script_noteworthy", ::init_hill_launcher, 1);
  trigger_use("sm_wave_one_rpgs");
}

setup_wave_two_launchers() {
  wait 3;
  sp_left = getent("hill_launcher3", "targetname");
  sp_right = getent("hill_launcher4", "targetname");

  for(x = 0; x < 2; x++)
    tmp_ent = simple_spawn_single(sp_left, ::init_hill_launcher, 2, undefined, undefined, undefined, undefined, 1);

  for(x = 0; x < 2; x++)
    tmp_ent = simple_spawn_single(sp_right, ::init_hill_launcher, 2, undefined, undefined, undefined, undefined, 1);

  spawn_manager_kill("sm_hill_shooters");
  trigger_use("sm_wave_one_shooters");
}

init_hill_launcher(n_wave) {
  self endon("death");
  self thread magic_bullet_shield();
  self set_goalradius(50);
  self.health = self.health + 25;
  self.a.disablelongdeath = 1;
  self setthreatbiasgroup("rpg_guy");
  wait 5;
  self thread stop_magic_bullet_shield();
  self.overrideactordamage = ::enemy_rpg_damage_override;
  self waittill("death");
}

init_final_launcher() {
  self.dropweapon = 0;
  self set_goalradius(50);
  self.health = self.health + 25;
  self.a.disablelongdeath = 1;
  self setthreatbiasgroup("axis_shooters");
}

kill_hill_rpgs() {
  spawn_manager_kill("sm_wave_one_rpgs");
  target_node1 = getvehiclenode("fire_pos_11", "script_noteworthy");
  target_node2 = getvehiclenode("fire_pos_12", "script_noteworthy");
  fire_nodes = getnodearray("hill_rpg_nodes", "script_noteworthy");
  wait 5;
  ai_rpgs = getentarray("hill_launcher1_ai", "targetname");

  foreach(rpg_guy in ai_rpgs) {
    level thread fire_magic_rpg(rpg_guy.origin);
    rpg_guy delete();
  }

  ai_rpgs = getentarray("hill_launcher2_ai", "targetname");

  foreach(rpg_guy in ai_rpgs) {
    level thread fire_magic_rpg(rpg_guy.origin);
    rpg_guy delete();
  }

  delay_thread(1.5, ::fire_magic_rpd, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node1.origin);
  delay_thread(2, ::fire_magic_rpg, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node1.origin, 0);
  delay_thread(2.5, ::fire_magic_rpd, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node1.origin);
  delay_thread(3.0, ::fire_magic_rpd, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node2.origin);
  delay_thread(3.5, ::fire_magic_rpg, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node2.origin, 0);
  delay_thread(2.1, ::fire_magic_rpg, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node1.origin, 0, 1);
  delay_thread(4, ::fire_magic_rpg, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node2.origin, 0, 1);
}

kill_wave_one_rpgs() {
  target_node1 = getvehiclenode("fire_pos_21", "script_noteworthy");
  target_node2 = getvehiclenode("fire_pos_22", "script_noteworthy");
  fire_nodes = getnodearray("wave_two_rpg_nodes", "script_noteworthy");
  ai_rpgs = getentarray("hill_launcher3_ai", "targetname");

  foreach(rpg_guy in ai_rpgs) {
    level thread fire_magic_rpg(rpg_guy.origin);
    rpg_guy delete();
  }

  ai_rpgs = getentarray("hill_launcher4_ai", "targetname");

  foreach(rpg_guy in ai_rpgs) {
    level thread fire_magic_rpg(rpg_guy.origin);
    rpg_guy delete();
  }

  delay_thread(2, ::fire_magic_rpg, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node1.origin, 0);
  delay_thread(2.5, ::fire_magic_rpd, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node1.origin);
  delay_thread(3.5, ::fire_magic_rpg, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node2.origin, 0);
  delay_thread(3.3, ::fire_magic_rpd, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node1.origin);
  delay_thread(2.1, ::fire_magic_rpg, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node1.origin, 0, 1);
  delay_thread(3.8, ::fire_magic_rpd, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node2.origin);
  delay_thread(4, ::fire_magic_rpg, fire_nodes[randomintrange(0, fire_nodes.size)].origin, target_node2.origin, 0, 1);
}

fire_magic_rpg(v_fire_pos, v_target_pos, b_wait_fire, b_fire_check) {
  if(!isDefined(b_wait_fire))
    b_wait_fire = 1;

  if(!isDefined(b_fire_check))
    b_fire_check = 0;

  if(b_fire_check) {
    if(randomint(100) < 50)
      return;
  }

  if(b_wait_fire)
    wait(randomfloatrange(1.5, 2.5));

  if(isDefined(v_target_pos))
    magicbullet("rpg_sp_angola", v_fire_pos, v_target_pos);
  else
    magicbullet("rpg_sp_angola", v_fire_pos, level.player.origin);
}

fire_magic_rpd(v_fire_pos, v_target_pos) {
  for(x = 0; x < 20; x++) {
    if(isDefined(v_target_pos))
      magicbullet("rpd_sp", v_fire_pos, v_target_pos);
    else
      magicbullet("rpd_sp", v_fire_pos, level.player.origin);

    wait 0.01;
  }
}

wave_one_tank_fire() {
  vh_target = getent("eland_hero", "targetname");
  vh_target waittill("reached_end_node");
  vh_tank = getent("wave_one_fire", "script_noteworthy");
  wait 5;
  vh_tank thread tank_fire_target(vh_target, 1);
  wait 5;
  level thread savannah_attack_mortars();
}

cleanup_hill() {
  s_mortars = getstructarray("mortar_savannah_start", "targetname");

  foreach(mortar in s_mortars)
  mortar structdelete();

  delete_struct_array("mortar_savannah_start_left", "targetname");
  delete_struct_array("mortar_savannah_start_right", "targetname");
  delete_array("brim_shooter", "targetname");
  flag_wait("hill_fights_ready");
  wait 0.5;
  delete_array("brim_ally", "targetname");
  delete_array("brim_axis", "targetname");
}

cleanup_wave_one() {
  delete_array("hill_launcher1", "targetname");
  delete_array("hill_launcher2", "targetname");
  flag_clear("fail_mortars");
  delete_struct_array("mortar_savannah_hill_left", "targetname");
  delete_struct_array("mortar_savannah_hill_right", "targetname");
  wait 7;
  delete_array("savannah_tank_target", "targetname");
  delete_array("mortar_unit", "script_noteworthy");
}

cleanup_wave_one_shooters() {
  spawn_manager_kill("sm_wave_one_shooters");
  delete_array("wave_one_shooter_ai", "targetname");
  delete_array("wave_one_machete_ai", "targetname");
  delete_array("wave_one_axis_ai", "targetname");
  delete_array("wave_one_ally_ai", "targetname");
}

cleanup_final_push() {
  end_scene("hudson_ride_idle");
  delete_array("final_launcher1_ai", "targetname");
  delete_array("final_launcher2_ai", "targetname");
  delete_array("push_launcher_ai", "targetname");
  delete_array("hudson_helicopter", "targetname");
  delete_array("technical_push", "script_noteworthy");
  delete_array("truck_push", "targetname");
  delete_array("push_allies_ai", "targetname");
  wait 0.1;
  delete_array("push_shooter_ai", "targetname");
  delete_array("push_fighter_ai", "targetname");
  delete_array("extra_runners_ai", "targetname");
  delete_array("extra_forward_runners_ai", "targetname");
  delete_array("mpla_retreat1_ai", "targetname");
  delete_array("mpla_retreat2_ai", "targetname");
  delete_array("mpla_retreat3_ai", "targetname");
  delete_array("mpla_retreat4_ai", "targetname");
  delete_array("mpla_retreat5_ai", "targetname");
  delete_array("mpla_retreat6_ai", "targetname");
}

prep_wave_two() {
  flag_clear("wave_one_done");
  axis_drone_array = getstructarray("drone_axis_wave_one_cut", "script_noteworthy");

  foreach(new_end in axis_drone_array) {
    new_end.dr_death_timer = 0;
    new_end.target = undefined;
    new_end.a_targeted = undefined;
  }

  wait 1;
  level thread go_wave_two();
  level thread cleanup_wave_one();
}

go_wave_two() {
  flag_set("wave_one");
  level.mortar_fail = 2;
  level thread watch_savannah_deep_warn();
  level thread savannah_wave_one_fights();
  savimbi_goal_pos = getnode("savimbi_wave_one_pos", "targetname");
  level.savimbi.goalradius = 32;
  level.savimbi setgoalpos(savimbi_goal_pos.origin);
  trigger_use("second_wave");
  level thread setup_wave_two_launchers();
  vh_buffel = getent("riverbed_convoy_buffel", "targetname");
  vh_buffel waittill("buffel_tip");
  vh_buffel thread savannah_buffel_tip();
  wait 2;
  level thread savannah_destroy_buffel1();
}

savimbi_return_fight() {
  vh_lead_buffel = getent("savimbi_buffel", "targetname");
  level.savimbi equip_savimbi_machete();

  for(x = 1; x < 4; x++) {
    temp_guy = simple_spawn_single("generic_machete", undefined, undefined, undefined, undefined, undefined, undefined, 1);
    temp_guy.animname = "mpla_fight_enemy_0" + x;
  }

  n_player_y = level.player.origin[1];
  n_buffel_y = vh_lead_buffel.origin[1];

  if(n_player_y > n_buffel_y) {
    run_scene("savimbi_strafe_return_left");
    delete_scene_all("savimbi_strafe_return_right");
  } else {
    run_scene("savimbi_strafe_return_right");
    delete_scene_all("savimbi_strafe_return_left");
  }

  level.savimbi unequip_savimbi_machete();
}

buffel_riders_fight() {
  wait 0.5;
  flag_set("wave_one_fight");
}

cleanup_riverbed_fail_triggers() {
  fail_triggers = getentarray("riverbed_fail", "targetname");
  warn_triggers = getentarray("riverbed_warning", "targetname");
  all_watch_triggers = arraycombine(fail_triggers, warn_triggers, 0, 0);

  foreach(trig in all_watch_triggers)
  trig delete();
}

savannah_mortar_team() {
  level.savannah_mortar_team_kills = 0;
  add_spawn_function_group("mortar_unit", "script_noteworthy", ::init_mortar_guy);
  mortar_team_trig = getentarray("mortar_team", "targetname");

  foreach(team_trig in mortar_team_trig) {
    team_trig useby(level.player);
    wait(randomfloatrange(0.2, 0.5));
  }

  mortar_team_trig2 = getentarray("mortar_team", "targetname");
  level thread mortars_nag();
  flag_wait_any("tank_vo_finished", "savannah_start_hudson");
  wait 0.5;
  level.player say_dialog("savi_mason_target_the_m_0");
  delay_thread(1, ::unita_say, "uni2_enemy_rpgs_0");
}

mortars_nag() {
  level endon("mortar_crew_destroyed");
  flag_wait_any("tank_vo_finished", "savannah_start_hill");
  wait 3;
  level thread unita_say("uni3_we_need_to_stop_thos_0");
  wait 10.0;
  mortar_guys1 = getentarray("mortar_team_guy_ai", "targetname");
  mortar_guys2 = getentarray("mortar_team_guy2_ai", "targetname");
  mortar_guys3 = getentarray("mortar_team_guy3_ai", "targetname");

  if(isDefined(mortar_guys1.size) && mortar_guys1.size || isDefined(mortar_guys2.size) && mortar_guys2.size || isDefined(mortar_guys3.size) && mortar_guys3.size)
    level.player say_dialog("savi_they_are_behind_the_0");
}

init_mortar_guy() {
  self thread magic_bullet_shield();
  self.overrideactordamage = ::mortar_guy_damage;
  flag_wait("savannah_start_hudson");
  self thread stop_magic_bullet_shield();
  set_objective(level.obj_destroy_mortar_crew, self, & "SP_OBJECTIVES_TARGET", -1);
  self waittill("death");
  level.savannah_mortar_team_kills++;
  set_objective(level.obj_destroy_mortar_crew, self, "remove");

  if(level.savannah_mortar_team_kills == 4) {
    set_objective(level.obj_destroy_mortar_crew, self, "delete");
    level.player say_dialog("maso_the_mortar_crews_are_0");
    flag_set("mortar_crew_destroyed");
    autosave_by_name("savannah_mortars");
    wait 1;
    level.player thread vo_play_savannah_hill();
  }
}

mortar_guy_damage(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime, str_bone_name) {
  if(str_means_of_death == "MOD_GRENADE_SPLASH" && n_damage == 1)
    return 0;

  if(isDefined(e_attacker) && e_attacker == level.player)
    return n_damage;
  else
    return 0;
}

savannah_attack_mortars() {
  vh_buffel_helper = getent("convoy_destroy_2", "targetname");
  a_fire_nodes = getstructarray("mortar_help", "targetname");
  flag_set("buffel2_continue_path");
  vh_buffel_helper waittill("buffel_helper_explode");
  vh_buffel_helper thread savannah_destroy_buffel2();
}

cleanup_mortar_models() {
  node1 = getnode("mortar_team_node", "targetname");

  if(isDefined(node1.mortar))
    node1.mortar delete();

  node2 = getnode("mortar_team_node2", "targetname");

  if(isDefined(node2.mortar))
    node2.mortar delete();

  node3 = getnode("mortar_team_node3", "targetname");

  if(isDefined(node3.mortar))
    node3.mortar delete();

  node4 = getnode("mortar_team_node4", "targetname");

  if(isDefined(node4.mortar))
    node4.mortar delete();
}

spawn_technicals() {
  level.savannah_technical_gunner_kills = 0;
  add_spawn_function_group("technical_gunner", "script_noteworthy", ::init_technical_gunner);
  add_spawn_function_veh_by_type("civ_pickup_wturret_angola", ::init_technical);
  technical_trig = getent("trig_trucks", "targetname");
  technical_trig useby(level.player);
  wait 0.1;
  extra_trig = getent("trig_extra_trucks", "targetname");
  extra_trig useby(level.player);
}

init_technical() {
  self.overridevehicledamage = ::technical_damage_callback;
  self maps\_vehicle::lights_off();
  self enable_turret(1);
  wait 0.15;
  self thread track_and_shoot_heli();
}

track_and_shoot_heli() {
  self endon("death");
  self.riders[0] endon("death");
  hud_heli = getent("hudson_helicopter", "targetname");
  self set_turret_target(hud_heli, vectorscale((0, 0, 1), 150.0), 1);
  self lights_off();

  while(!flag("stop_tracking_heli")) {
    self fire_turret_for_time(5, 1);
    wait 2;
  }

  self set_turret_target(level.player, vectorscale((0, 0, 1), 40.0), 1);
}

init_technical_gunner() {
  self.overrideactordamage = ::mortar_guy_damage;
  set_objective(level.obj_destroy_technical, self, & "SP_OBJECTIVES_TARGET", -1);
  self.dropweapon = 0;
  self waittill("death");
  level.savannah_technical_gunner_kills++;
  set_objective(level.obj_destroy_technical, self, "remove");

  if(level.savannah_technical_gunner_kills == 2) {
    set_objective(level.obj_destroy_technical, self, "delete");
    flag_wait("mg_objective_ready");
    level.player say_dialog("maso_mg_truck_s_down_yo_0");
    autosave_by_name("savannah_technicals");
    wait 2;
    flag_set("technical_gunners_destroyed");
  }
}

killer_fail_init() {
  self setthreatbiasgroup("player_killer");
  self.health = 200;
  self settargetentity(level.player);
  self setgoalentity(level.player);
  self.goalradius = 256;
  flag_set("fail_stop_protection");
}

technical_damage_callback(einflictor, eattacker, idamage, idflags, type, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(eattacker == level.player) {
    if(self.health - idamage <= 0) {
      if(isDefined(self.riders[0]))
        self.riders[0] notify("death");
    }

    return idamage;
  }

  return 0;
}

wait_for_wave3_spawn() {
  flag_wait("start_wave3");
  trigger_use("final_push_tanks");
  level.player say_dialog("maso_there_s_a_lot_of_arm_0");
}

protect_convoy() {
  eland1 = getent("final_push_eland", "targetname");
  eland1.takedamage = 0;
  eland2 = getent("eland_destroy", "targetname");
  eland2.takedamage = 0;
}

warp_buffel() {
  level thread maps\angola_anim::final_push_anims();
  spawn_manager_set_global_active_count(24);
  wait 0.5;
  level thread delete_swap_vehicles();
  level thread warp_convoy();
  level thread show_static_push_models();
  level thread prep_push();
  delete_scene_all("savimbi_climb_enemy_loop");
  delete_array("climb_enemy_ai", "targetname");
  delete_array("post_heli_enemy_ai", "targetname");
  delete_array("post_heli_friendly_ai", "targetname");
  add_spawn_function_group("push_runners", "script_noteworthy", ::init_push_runners);
  add_spawn_function_group("push_fighter", "targetname", ::init_fighter, 0.2);
  add_spawn_function_group("push_driver", "targetname", ::init_final_launcher);

  for(x = 1; x < 5; x++) {
    level thread run_scene_first_frame("push_retreat" + x);
    ai_retreater = get_ais_from_scene("push_retreat" + x);
    ai_retreater[0] thread magic_bullet_shield();
  }

  flag_wait("push_warp_ready");
  nd_final_push = getvehiclenode("final_push_start", "targetname");
  self thread go_path(nd_final_push);
  level.player playrumblelooponentity("tank_rumble");
  wait 2.6;
  maps\_drones::drones_speed_modifier("mpla_drones_push", -0.3, -0.2);
  drones_start("mpla_drones_push");
  wait 0.4;
  simple_spawn("push_shooter");
  simple_spawn("push_fighter");
  simple_spawn("push_allies", ::init_push_allies);
  add_spawn_function_group("push_gunner", "targetname", ::init_push_gunner);
  push_technical_trig = getent("trig_push_technical", "targetname");
  push_technical_trig useby(level.player);
  level thread spawn_extra_runners();
  flag_wait("technical_explode");
  vh_eland = getent("technical_shoot_eland", "targetname");
  vh_truck_push = getent("truck_push", "targetname");
  vh_eland thread tank_fire_target(vh_truck_push, 0, 0.1);
  wait 0.1;

  if(isDefined(vh_truck_push))
    vh_truck_push notify("death");
}

delete_swap_vehicles() {
  delete_array("wave_one_tank", "targetname");
  delete_array("wave_two_tank", "targetname");
  delete_array("final_push_tank", "targetname");
  delete_array("fake_convoy_buffel", "targetname");
  delete_array("technical_gunner", "script_noteworthy");
  delete_array("savannah_technical", "script_noteworthy");
  delete_array("convoy_destroy_1", "targetname");
  delete_array("convoy_destroy_2", "targetname");
  delete_array("riverbed_convoy_buffel", "targetname");
  e_buffel_tip_blocker = getent("buffel_tip_blocker", "targetname");
  e_buffel_tip_blocker connectpaths();
  e_buffel_tip_blocker notsolid();
  level thread cleanup_mortar_models();
}

warp_convoy() {
  eland1 = getent("riverbed_convoy_eland", "targetname");
  eland1 delete();
  eland1 = spawn_vehicle_from_targetname("start_convoy_buffel_turret");
  eland1 veh_magic_bullet_shield(1);
  eland1.targetname = "push_buffel";
  eland1 load_buffel(1);
  wait 0.05;
  eland2 = getent("eland_destroy", "targetname");
  eland2 delete();
  eland2 = spawn_vehicle_from_targetname("start_convoy_eland");
  eland2 veh_magic_bullet_shield(1);
  wait 0.05;
  eland3 = getent("final_push_eland", "targetname");
  eland3 delete();
  eland3 = spawn_vehicle_from_targetname("start_convoy_eland");
  eland3 veh_magic_bullet_shield(1);
  eland3.targetname = "technical_shoot_eland";
  nd_final_push_eland1 = getvehiclenode("riverbed_convoy_eland_start", "targetname");
  nd_final_push_eland2 = getvehiclenode("eland_destroy_start", "targetname");
  nd_final_push_eland3 = getvehiclenode("final_push_eland2_start", "targetname");
  eland1 thread go_path(nd_final_push_eland1);
  eland2 thread go_path(nd_final_push_eland2);
  eland3 thread go_path(nd_final_push_eland3);
  target_node = getnode("final_launcher1_node", "targetname");
  target_node2 = getnode("final_launcher2_node", "targetname");
  eland3 delay_thread(9, ::tank_fire_position, target_node.origin, 0.2);
  eland3 delay_thread(10, ::tank_fire_position, target_node2.origin, 0.2);
  eland1 thread buffel_gunner_think();
  wait 12;
  target_ent = getent("truck_push", "targetname");
  eland3 setturrettargetent(target_ent);
}

show_static_push_models() {
  warp_tank_array = spawn_vehicles_from_targetname("final_push_model");

  foreach(tank in warp_tank_array) {
    playfxontag(getfx("fx_ango_smoke_distant_lrg_2"), tank, "tag_origin");
    tank notify("death");
    wait 0.05;
  }

  warp_buffel_array = spawn_vehicles_from_targetname("final_push_buffel");

  foreach(buffel in warp_buffel_array) {
    playfxontag(getfx("buffel_explode"), buffel, "tag_body");
    buffel notify("death");
    wait 0.05;
  }

  path_blocker = getent("push_path_blocker", "targetname");
  path_blocker solid();
  path_blocker disconnectpaths();
}

prep_push() {
  drones_delete("mpla_drones");
  drones_delete("mpla_drones_high");
  level thread cleanup_wave_one_shooters();
  level thread cleanup_hill_ai();
  wait 0.05;
  level thread maps\_drones::drones_delete_spawned();
  level thread hide_savannah_rocks();
  flag_wait("push_forward_ready");
}

init_push_runners() {
  self setthreatbiasgroup("push_runners");
}

init_push_allies() {
  self setthreatbiasgroup("push_allies");
  self thread magic_bullet_shield();
  self thread disable_pain();
  self set_goalradius(50);
  self.script_accuracy = 0.5;
}

init_push_gunner() {
  self.overrideactordamage = ::mortar_guy_damage;
}

init_fighter(n_accuracy) {
  if(!isDefined(n_accuracy))
    n_accuracy = 1;

  self.a.disablelongdeath = 1;
  self set_goalradius(50);
  self.script_accuracy = n_accuracy;
  self.health = 200;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "fight_player")
    self setthreatbiasgroup("player_killer");

  delay_thread(randomfloatrange(10, 11), ::kill_fighter);
}

kill_fighter() {
  if(isDefined(self))
    self kill();
}

spawn_extra_runners() {
  flag_wait("spawn_extra_runners");
  wait 0.5;

  for(x = 0; x < 10; x++) {
    extra_runner = simple_spawn_single("extra_runners");
    wait 0.05;
  }
}

spawn_forward_runners() {
  flag_wait("spawn_extra_runners");

  for(x = 0; x < 10; x++) {
    extra_runner = simple_spawn_single("extra_forward_runners");
    wait 0.05;
  }
}

victory_shot_friendlies() {
  wait 3.7;
  victory_shot_enemy = getent("victory_shot_enemy", "targetname");

  for(x = 0; x < 3; x++) {
    enemy_ent = simple_spawn_single(victory_shot_enemy, ::init_victory_enemy, undefined, undefined, undefined, undefined, undefined, 1);
    wait 0.05;
  }

  wait 1;
  victory_shot_friendly = getent("victory_shot_friendly", "targetname");

  for(x = 0; x < 2; x++) {
    victory_ent = simple_spawn_single(victory_shot_friendly, ::init_victory_friendly, undefined, undefined, undefined, undefined, undefined, 1);
    wait 0.05;
  }

  victory_shot_friendly2 = getent("victory_shot_friendly2", "targetname");

  for(x = 0; x < 2; x++) {
    victory_ent = simple_spawn_single(victory_shot_friendly2, ::init_victory_friendly, undefined, undefined, undefined, undefined, undefined, 1);
    wait 0.05;
  }
}

init_victory_friendly() {
  self endon("death");
  self.goalradius = 12;
  self thread magic_bullet_shield();
  wait 1.1;
  flag_wait("cleanup_victory_shots");
  self delete();
}

init_victory_enemy() {
  self.goalradius = 12;
  self.ignoreall = 1;
  self.health = 300;
  self.dropweapon = 0;
  self waittill("goal");
  self dodamage(self.health + 100, (0, 0, 0));
}

show_savannah_rocks() {
  mortar_rocks = getentarray("mortar_rocks", "targetname");

  foreach(rock in mortar_rocks) {
    if(isDefined(rock.script_float))
      rock setscale(rock.script_float);
  }

  technical_rocks = getentarray("technical_rocks", "targetname");

  foreach(rock in technical_rocks) {
    if(isDefined(rock.script_float))
      rock setscale(rock.script_float);
  }
}

hide_savannah_rocks() {
  mortar_rocks_clips = getentarray("mortar_rocks_clip", "targetname");

  foreach(clip in mortar_rocks_clips)
  clip delete();

  technical_rocks_clips = getentarray("technical_rocks_clip", "targetname");

  foreach(clip in technical_rocks_clips)
  clip delete();

  mortar_rocks = getentarray("mortar_rocks", "targetname");

  foreach(rock in mortar_rocks)
  rock delete();

  technical_rocks = getentarray("technical_rocks", "targetname");

  foreach(rock in technical_rocks)
  rock delete();
}

victory_shots_warp(m_body) {
  flag_set("victory_start");
  end_scene("savimbi_climb_idle");

  if(isDefined(level.savimbi))
    level.savimbi delete();

  delete_array("delete_for_victory", "script_noteworthy");
  level thread show_victory_vehicles(1);
  level clientnotify("sgw");
  level notify("turn_off_walla_loop");
  level thread stop_savannah_grass();
  level thread maps\createart\angola_art::savannah_finish();
  level thread cleanup_final_push();
  level thread place_victory_bodies();
  exploder(3000);
  level.player set_ignoreme(1);
  level.player enableinvulnerability();
}

prep_victory_shots() {
  level thread maps\angola_anim::savannah_end_anims();
  level thread maps\angola_anim::generic_dead();
}

set_player_low_ready(m_model) {
  level.player setlowready(1);
}

set_player_weapon_disabled(m_model) {
  level.player player_disable_weapons();
  level thread check_player_weapons();
}