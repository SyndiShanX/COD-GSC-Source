/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_little_bird.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_ai_rappel;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_objectives;
#include maps\_scene;
#include maps\karma_util;
#include maps\createart\karma_2_art;
#include maps\karma_enter_mall;
#include maps\karma_2_anim;
#include maps\_vehicle;
#include maps\_metal_storm;
#include maps\karma_exit_club;

karma_init_rusher_distances() {
  level.player_rusher_jumper_dist = 252;
  level.player_rusher_vclose_dist = 294;
  level.player_rusher_fight_dist = 504;
  level.player_rusher_medium_dist = 630;
  level.player_rusher_player_busy_dist = 924;
}

init_flags() {
  flag_init("asd_intro_done");
  flag_init("reached_the_rocks_objective");
  flag_init("flag_use_left_bunker_spawners");
  flag_init("flag_use_right_bunker_spawners");
  flag_init("upper_left_stairs_spawners_active");
  flag_init("flag_bunker_snipers_active");
  flag_init("flag_reached_metal_storm");
}

init_spawn_funcs() {
  getent("asd_runner_vocal", "script_noteworthy") add_spawn_function(::pmc_asd_alert);
  add_spawn_function_ai_group("vol_sundeck_mall", ::fighting_withdrawl);
  add_spawn_function_ai_group("vol_sundeck_west_1f", ::fighting_withdrawl);
  add_spawn_function_ai_group("vol_sundeck_west_2f", ::fighting_withdrawl);
  add_spawn_function_ai_group("vol_north_cliff_west_1f", ::fighting_withdrawl);
  add_spawn_function_ai_group("vol_north_cliff_west_2f", ::fighting_withdrawl);
  add_spawn_function_ai_group("vol_south_cliff_west", ::fighting_withdrawl);
  add_spawn_function_ai_group("vol_cliffs_east", ::fighting_withdrawl);
}

spawn_funcs() {
  add_global_spawn_function("axis", ::die_behind_player, get_struct("little_bird_exit"));
  add_global_spawn_function("allies", ::die_behind_player, get_struct("little_bird_exit"));
}

skipto_sundeck() {
  skip_scene("intruder", 1);
  skip_scene("intruder_knuckles", 1);
  skip_scene("brute", 1);
  skip_scene("brute_doors", 1);
  skip_scene("intro_explosion_aftermath", 1);
  skip_scene("scene_e7_couple_run_to_titanic_area", 1);
  skip_scene("scene_e7_couple_run_to_titanic_area_loop", 1);
  skip_scene("scene_e7_couple_a_run_from_mall_to_titanic", 1);
  skip_scene("scene_e7_couple_a_run_from_mall_to_titanic_loop", 1);
  skip_scene("scene_e7_couple_b_run_from_mall_to_titanic", 1);
  skip_scene("scene_e7_couple_b_run_from_mall_to_titanic_loop", 1);
  skip_scene("scene_e7_wounded_group1", 1);
  skip_scene("scene_e7_wounded_group2", 1);
  skip_scene("scene_e7_doctor_and_nurse_loop", 1);
  skip_scene("scene_e7_couple_approach_window_part1", 1);
  skip_scene("scene_e7_couple_approach_window_part2_loop", 1);
  skip_scene("scene_e7_single_approach_window_part1", 1);
  skip_scene("scene_e7_single_approach_window_part2_loop", 1);
  skip_scene("scene_e7_titanic_moment_docka_loop", 1);
  skip_scene("scene_e7_titanic_moment_dockb_loop", 1);
  skip_scene("deathpose1", 1);
  skip_scene("deathpose2", 1);
  skip_scene("deathpose3", 1);
  skip_scene("deathpose4", 1);
  skip_scene("deathpose5", 1);
  skip_scene("deathpose6", 1);
  skip_scene("deathpose7", 1);
  skip_scene("deathpose8", 1);
  skip_scene("deathpose9", 1);
  skip_scene("deathpose10", 1);
  skip_scene("deathpose11", 1);
  skip_scene("scene_e8_intro_civ_couple_1", 1);
  skip_scene("scene_e8_intro_civ_couple_2", 1);
  skip_scene("scene_e8_intro_civ_single_1", 1);
  skip_scene("scene_e8_intro_civ_single_2", 1);
  skip_scene("scene_e8_intro_civ_single_3", 1);
  skip_scene("terrorist_rappel_left1", 1);
  skip_scene("terrorist_rappel_left2", 1);
  level.ai_harper = init_hero("harper");
  level.ai_salazar = init_hero("salazar");
  level.ai_redshirt1 = simple_spawn_single("redshirt1");
  level.ai_redshirt1 magic_bullet_shield();
  level.ai_redshirt2 = simple_spawn_single("redshirt2");
  level.ai_redshirt2 magic_bullet_shield();
  trigger_use("trig_mall_wounded_5");
  skipto_teleport("skipto_little_bird");
  level.player thread maps\createart\karma_2_art::vision_set_change("sp_karma2_mall_interior");
  maps\karma_enter_mall::mall_ambient_effects();
  trigger_use("e8_color_11");
  level.vh_friendly_asd = spawn_vehicle_from_targetname("specialty_asd");
  flag_set("friendly_asd_activated");
  s_teleport = getstruct("skipto_sundeck_asd", "targetname");
  level.vh_friendly_asd.origin = s_teleport.origin;
  level.vh_friendly_asd thread friendly_asd_think();
  flag_set("scene_event8_door_breach_done");
  level.player set_temp_stat(1, 1);
  level thread defalco_marker_think();
  level thread maps\karma_enter_mall::sec_chatter_dialog();
  level thread maps\karma_enter_mall::pmc_chatter_dialog();
}

main() {
  set_level_goal("ref_delete_sundeck");
  level thread mall_cleanup_trigger();
  level thread cabana_fx_init();

  iprintln("Exit Club");

  setsaveddvar("wind_global_vector", "213 148 -56");
  level thread little_bird_objectives();
  add_trigger_function("player_reached_rocks", ::defalco_karma_exiting_pool_area_pip);
  karma_init_rusher_distances();
  setup_fallback_monitors();
  maps\karma_2_anim::sundeck_anims();
  level thread civilians_injured_from_battle_anim();
  level thread squad_sundeck_fight();
  load_gump("karma_2_gump_sundeck");
  flag_wait("scene_event8_door_breach_done");
  maps\_vehicle::spawn_vehicle_from_targetname("defalco_osprey");
  spawn_funcs();
  level thread metal_storm_intro_dialog();
  level thread e9_civilian_spawning();
  level thread e9_wave_spawning();
  level thread pmc_defalco_extract_init();
  level thread asd_intro();
  level thread sundeck_save();
  trigger_wait("e9_player_enters_sundeck");
  autosave_by_name("sundeck_start");
  level clientnotify("aS_on");
  level notify("e9_player_in_pool_area");
  wait 10;
  exploder(899);
}

sundeck_save() {
  flag_wait("close_sundeck_door");
  wait 1;
  autosave_by_name("sundeck");
}

spawn_floating_bodies() {
  sp = getent("rich_male_shot", "targetname");
  a_pos = getstructarray("floating_body", "targetname");

  foreach(s_pos in a_pos) {
    m_body = sp spawn_drone();
    m_body.origin = s_pos.origin;
    m_body.angles = s_pos.angles;
    m_body setclientflag(15);
    m_body startragdoll(1);
  }
}

cabana_fx_init() {
  foreach(e_cabana in getentarray("fxanim_cabana_02", "targetname")) {
    n_exploder = e_cabana.script_int * 10;
    e_cabana thread cabana_fx_think(n_exploder);
  }
}

cabana_fx_think(n_exploder) {
  self waittill("damage");
  exploder(n_exploder);
}

e9_civilian_spawning() {
  str_category_startup = "e9_wave_1_startup";
  level thread civilian_group4_waiting_to_escape_anim(4);
  level thread civilian_left_stairs_group1_anim(0.1);
  level thread civilian_left_stairs_group2_anim(2);
  level thread civilian_balcony_fling_anim(2, str_category_startup);
}

e9_wave_spawning() {
  str_category_startup = "e9_wave_1_startup";
  level thread e9_start_player_rushers(str_category_startup);
  level thread e9_bridge_runners(1.5, str_category_startup);
  level thread e9_start_balcony_death_event(0.5, 8);
  level thread e9_keep_player_busy_at_start_trigger(0.5, str_category_startup);
  level thread e9_sundeck_west_rpg(1, str_category_startup);
  level thread e9_manager_upper_left_stairs(str_category_startup);
  level thread e9_stairs_by_blockage_trigger(8, str_category_startup);
  level thread e9_player_reaches_bottom_left_stairs_trigger(6, str_category_startup);
  level thread e9_left_staircase_climbing_trigger(7, str_category_startup);
  level thread e9_civ_rocks_right_trigger();
  level thread e9_civs_left_pre_metal_storm_trigger(0.1);
  wait 0.5;
  str_category_snipers = "e9_wave_2_snipers";
  level thread e9_bunker_right_begin_trigger(str_category_snipers);
  level thread e9_cliffs_trigger(str_category_snipers);
  level thread e9_left_upper_tunnel_spawner(str_category_snipers);
  level thread e9_setup_balcony_explosion_blocker_triggers();
  level thread little_bird_attack_drinks_area();
  level thread e9_bunker_enemy_management(str_category_snipers);
  flag_wait("reached_the_rocks_objective");
  level thread e9_civ_left_end_trigger();
  level thread e9_civ_right_end_trigger();
  level thread e9_civ_middle_end_trigger();
  str_category = "e9_wave_3_begins";
  level thread e9_post_ms_left_begin_trigger(str_category);
  level thread e9_post_ms_right_begin_trigger(str_category);
  str_category = "e9_wave_3_ongoing";
}

intro_asd_think() {
  self endon("death");
  self thread maps\_metal_storm::metalstorm_set_team("team3");
  self setthreatbiasgroup("ship_drones");
  s_dest = getstruct("asd_intro_start", "targetname");
  self thread maps\_vehicle::defend(s_dest.origin, 64);
  wait 2.5;
  flag_wait("do_asd_intro");
  s_shot_start = getstruct("asd_missile_hit", "targetname");
  s_shot_dest = getstruct(s_shot_start.target, "targetname");
  magicbullet("metalstorm_launcher", s_shot_start.origin, s_shot_dest.origin, self);
  wait 0.4;
  level notify("fxanim_column_explode_start");
  exploder(799);
  wait 0.05;
  radiusdamage(s_shot_dest.origin, 140, 500, 500, self);
  wait 4.0;
  self waittill_any("near_goal");
  flag_set("asd_intro_done");
  s_dest = getstruct(s_dest.target, "targetname");
  self thread maps\_vehicle::defend(s_dest.origin);
  self waittill_any("goal", "near_goal", "damage");
  self thread maps\_vehicle::defend(s_dest.origin, s_dest.radius);
}

asd_intro() {
  a_ai_guards = simple_spawn("e9_asd_intro_runner");
  vh_asd = spawn_vehicle_from_targetname("metal_storm_intro");
  vh_asd thread intro_asd_think();

  foreach(ai_guard in a_ai_guards)
  ai_guard thread asd_intro_guard_think(vh_asd);
}

asd_intro_guard_think(vh_asd) {
  self setthreatbiasgroup("tacitus");
  self thread shoot_at_target(vh_asd);
}

little_bird_objectives() {
  level waittill("start_sniper_objective");
  event9_save("e9_snipers");
  trigger_wait("objective_advance_past_rocks_trigger");
  flag_set("reached_the_rocks_objective");
  level notify("str_cleanup_civs_groupa");
  event9_save("e9_player_past_rocks");
  trigger_wait("objective_advance_stop_defalco_trigger");
  cleanup_ents("e9_wave_1_startup");
  cleanup_ents("e9_wave_2_snipers");
  flag_set("flag_reached_metal_storm");
  level thread e9_post_ms_background_enemy_rusher_control("post_ms_rushers");
  trigger_wait("trigger_end_event9_2");
  level notify("str_cleanup_civs_groupb");
  trigger_wait("trigger_end_event9_3");
  cleanup_ents("e9_wave_3_begins");
  event9_save("karma_little_bird");
}

spawn_func_asd() {
  if(self.team == "axis") {
    if(!isDefined(self.radius))
      self.radius = 800;

    self thread maps\_metal_storm::metalstorm_set_team("team3");
    self setthreatbiasgroup("ship_drones");

    if(isDefined(self.target)) {
      nd_target = getnode(self.target, "targetname");
      n_radius = self.radius;

      if(isDefined(nd_target.radius))
        n_radius = nd_target.radius;

      self thread maps\_vehicle::defend(nd_target.origin, n_radius);
    } else
      self thread maps\_vehicle::defend(self.origin, self.radius);
  }
}

cleanup_ents_for_defalco_escape_animation() {
  cleanup_ents("e9_wave_3_ongoing");
  cleanup_ents("e9_wave_4_begins");
}

event9_save(str_save_name) {
  autosave_by_name(str_save_name);
}

squad_sundeck_fight() {
  level.ai_harper setup_squad_member("g", "navy_seals");
  level.ai_salazar setup_squad_member("g", "navy_seals");
  level.ai_redshirt1 setup_squad_member("r", "ship_security");
  level.ai_redshirt2 setup_squad_member("r", "ship_security");
}

setup_squad_member(str_color, str_threat_bias_group) {
  self set_force_color(str_color);
  self setthreatbiasgroup(str_threat_bias_group);
}

e9_bunker_right_begin_trigger(str_category) {
  t_trigger = getent("e9_bunker_right_begin_trigger", "targetname");
  t_trigger waittill("trigger");
  a_ents = getentarray("e9_bunker_rpg_spawner", "targetname");

  if(isDefined(a_ents))
    simple_spawn_script_delay(a_ents);

  level thread civilian_rocks_execution_anim(0.01, str_category);
}

e9_bunker_enemy_management(str_category) {
  level thread wait_for_linker_bunker_trigger("e9_trigger_bunker_enemy_left_side", "flag_use_left_bunker_spawners", "bunker_spawnwers_triggered");
  level thread wait_for_linker_bunker_trigger("e9_bunker_right_begin_trigger", "flag_use_right_bunker_spawners", "bunker_spawnwers_triggered");
  level waittill("bunker_spawnwers_triggered");
  a_sp_ents = getentarray("e9_bunker_enemy", "targetname");

  if(isDefined(a_sp_ents)) {
    a_ents = simple_spawn(a_sp_ents);

    for(i = 0; i < a_ents.size; i++) {
      a_ents[i] setup_bunker_enemy_params();
      a_ents[i] add_cleanup_ent(str_category);
    }
  }

  level.ai_sniper1 = a_ents[0];
  level.ai_sniper2 = a_ents[1];
  level.ai_sniper3 = a_ents[2];
  level.ai_sniper4 = a_ents[3];
  level notify("start_sniper_objective");
  flag_set("flag_bunker_snipers_active");

  if(flag("flag_use_left_bunker_spawners")) {
    a_ents = getentarray("e9_bunker_left_flank_spawner", "targetname");

    if(isDefined(a_ents))
      simple_spawn_script_delay(a_ents);
  }

  if(flag("flag_use_right_bunker_spawners")) {
    a_ents = getentarray("e9_right_rocks_wave1_spawner", "targetname");

    if(isDefined(a_ents))
      simple_spawn_script_delay(a_ents);
  }
}

setup_bunker_enemy_params() {
  self.favoriteenemy = level.player;
  self.attackeraccuracy = 1.0;
}

wait_for_linker_bunker_trigger(str_trigger_name, str_spawner_flag, str_level_notify) {
  level endon(str_level_notify);
  t_trigger = getent(str_trigger_name, "targetname");
  t_trigger waittill("trigger");
  flag_set(str_spawner_flag);
  level notify(str_level_notify);
}

e9_cliffs_trigger(str_category) {
  level endon("metal_storm_cleanup");
  e_trigger = getent("e9_cliffs_trigger", "targetname");
  e_trigger waittill("trigger");
  level thread civ_run_from_node_to_node(0.3, "rich_female", "e9_civ_rocks_mid_start");
  level thread civ_run_from_node_to_node(0.1, "rich_male", "e9_civ_rocks_mid_2_start");
  simple_spawn("e9_cliffs_rusher_spawner", ::aggressive_runner, str_category);
  simple_spawn("e9_cliffs_spawner");
}

e9_start_player_rushers(str_category) {
  level endon("e9_player_in_pool_area");
  player_wait = 10.0;
  wait(player_wait);
  sp_rusher = getent("e9_start_player_hurryup_1", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread aggressive_runner(str_category);

  wait 12;
  sp_rusher = getent("e9_start_player_hurryup_2", "targetname");
  e_ai = simple_spawn_single(sp_rusher);

  if(isDefined(e_ai))
    e_ai thread aggressive_runner(str_category);
}

e9_bridge_runners(delay, str_category) {
  if(isDefined(delay))
    wait(delay);

  a_runners = getentarray("e9_bridge_runner", "targetname");

  if(isDefined(a_runners))
    simple_spawn_script_delay(a_runners);
}

e9_start_balcony_death_event(start_delay, battle_time) {
  if(isDefined(start_delay) && start_delay > 0)
    wait(start_delay);

  a_sp_friendlys = getentarray("e9_start_friendly_balcony_victim", "targetname");
  a_ai_friendlys = simple_spawn(a_sp_friendlys);
  a_sp_enemys = getentarray("e9_start_enemy_balcony_killer", "targetname");

  if(isDefined(a_sp_enemys)) {
    for(i = 0; i < a_sp_enemys.size; i++) {
      ai_enemy = simple_spawn_single(a_sp_enemys[i]);

      if(isDefined(ai_enemy) && isalive(ai_enemy))
        ai_enemy thread force_fire_at_balcony_friendly(a_ai_friendlys[i], a_sp_friendlys[0].target, a_sp_friendlys[1].target);
    }
  }

  for(i = 0; i < a_ai_friendlys.size; i++) {
    a_ai_friendlys[i].health = 11111;
    a_ai_friendlys[i].grenadeawareness = 0;
  }

  if(!isalive(a_ai_friendlys[0])) {
    return;
  }
  nd_explosion = getnode(a_ai_friendlys[0].target, "targetname");
  wait(battle_time);

  for(i = 0; i < a_ai_friendlys.size; i++) {
    if(isalive(a_ai_friendlys[i])) {
      alive_time = randomfloatrange(8, 11);
      a_ai_friendlys[i] thread entity_death_in_pose_after_time(alive_time, "stand");
    }
  }

  alive_time = randomfloatrange(8, 11);
  time = gettime();
  explode_0_time = time + alive_time * 1000 / 100;
  explode_1_time = time + alive_time * 1000 / 2.5;
  explode_2_time = time + (alive_time * 1000 + 1000);

  while(time < explode_0_time) {
    time = gettime();
    wait 0.01;
  }

  pos = nd_explosion.origin;
  dir = anglestoforward(nd_explosion.angles);
  right = anglestoright(nd_explosion.angles);
  pos = pos - dir * 4.2 - right * 168;
  playfx(level._effect["def_explosion"], pos);

  while(time < explode_1_time) {
    time = gettime();
    wait 0.01;
  }

  pos = nd_explosion.origin;
  dir = anglestoforward(nd_explosion.angles);
  right = anglestoright(nd_explosion.angles);
  pos = pos - dir * 4.2 - right * 63.0;
  playfx(level._effect["def_explosion"], pos);
  exploder(840);

  while(time < explode_2_time) {
    time = gettime();
    wait 0.01;
  }

  pos = nd_explosion.origin;
  dir = anglestoforward(nd_explosion.angles);
  right = anglestoright(nd_explosion.angles);
  pos = pos - dir * 4.2 - right * 21.0;
  playfx(level._effect["def_explosion"], pos);
  exploder(841);
}

force_fire_at_balcony_friendly(ai_target, str_nd_target0, str_nd_target1) {
  self endon("death");
  nd_node = getnode(str_nd_target0, "targetname");
  nd_next_node = getnode(str_nd_target1, "targetname");
  self.ignoreall = 1;
  self.goalradius = 48;
  self.health = 300;
  self.allowpain = 0;
  self setgoalnode(nd_node);
  self waittill("goal");

  if(isalive(ai_target)) {
    self thread entity_fake_tracers(ai_target);

    while(isDefined(ai_target) && ai_target.health > 0) {
      self.lastgrenadetime = gettime();
      self thread shoot_at_target(ai_target, "J_head");
      delay = randomfloatrange(0.3, 0.6);
      wait(delay);
    }
  }

  self.allowpain = 1;
  self.ignoreall = 0;
  self setgoalnode(nd_next_node);
  self.goalradius = 48;
  self waittill("goal");
  self.goalradius = 2048;
}

e9_keep_player_busy_at_start_trigger(delay, str_category) {
  wait(delay);
  start_time = gettime();
  last_ai_spawn_time = start_time;
  min_axis_alive = 3;
  min_spawn_wait_time = 20;
  volume = getent("vol_sundeck_mall", "targetname");

  if(isDefined(volume)) {
    while(true) {
      time = gettime();
      dt = (time - last_ai_spawn_time) / 1000;

      if(level.player istouching(volume)) {
        num_axis = 0;
        a_axis = getaiarray("axis");

        if(isDefined(a_axis))
          num_axis = a_axis.size;

        if(num_axis <= min_axis_alive) {
          if(dt > min_spawn_wait_time) {
            last_ai_spawn_time = time;
            sp_rusher = getentarray("e9_keep_player_busy_at_sundeck_mall", "targetname");
            a_ai = simple_spawn(sp_rusher);

            if(isDefined(a_ai)) {
              a_ai = array_randomize(a_ai);
              size = a_ai.size;

              if(size > 4)
                size = 4;

              for(i = 0; i < size; i++)
                a_ai[i] thread aggressive_runner(str_category);
            }
          }
        }

        if(flag("flag_bunker_snipers_active"))
          return;
      }

      if(dt < min_spawn_wait_time)
        delay = min_spawn_wait_time - dt;
      else
        delay = randomfloatrange(1.0, 3.0);

      wait(delay);
    }
  }
}

e9_left_staircase_climbing_trigger(delay, str_category_startup) {
  level endon("metal_storm_cleanup");
  wait(delay);
  t_trigger = getent("e9_stairs_start_left_climbing_trigger", "targetname");
  t_trigger waittill("trigger");
  a_ents = getentarray("e9_stairs_start_left_climbing_spawner", "targetname");

  if(isDefined(a_ents))
    simple_spawn_script_delay(a_ents, ::spawn_fn_ai_run_to_target, 0, str_category_startup, 0, 0, 0);
}

e9_sundeck_west_rpg(delay, str_category) {
  level endon("metal_storm_cleanup");
  wait(delay);
  t_trigger = getent("e9_player_enters_sundeck", "targetname");
  t_trigger waittill("trigger");
  a_spawners = getentarray("e9_left_stairs_rpg_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners);
}

e9_manager_upper_left_stairs(str_category) {
  trigger_wait("e9_manager_upper_left_stairs_trigger");
  event9_save("e9_upper_left_stairs");
  flag_set("upper_left_stairs_spawners_active");
  level thread e9_civ_bridge_to_stairs();
  a_spawners = getentarray("e9_left_staircase_begins_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners);

  str_spawn_manager = "e9_manager_upper_left_stairs";
  level.stairs_spawn_manager = str_spawn_manager;
  spawn_manager_enable(str_spawn_manager);
  e_spawner = getent("e9_bridge_rusher_spawner", "targetname");
  e_ai = simple_spawn_single(e_spawner, ::aggressive_runner, str_category);
  a_spawners = getentarray("e9_start_staircase_sniper_spawner", "targetname");
  simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 1, str_category, 0, 1, 0);
}

e9_left_upper_tunnel_spawner(str_category) {
  level endon("metal_storm_cleanup");
  t_trigger = getent("e9_left_stairs_enter_tunnel_trigger", "targetname");
  t_trigger waittill("trigger");
  a_runners = getentarray("e9_left_stairs_enter_tunnel_spawner", "targetname");

  if(isDefined(a_runners))
    simple_spawn_script_delay(a_runners, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 0, 0);
}

entity_fake_tracers(ent_target) {
  self endon("death");
  ent_target endon("death");

  while(true) {
    base_height = 55;
    target_height = base_height + randomintrange(15, 40);
    start_pos = (self.origin[0], self.origin[1], self.origin[2] + base_height);
    end_pos = (ent_target.origin[0], ent_target.origin[1], ent_target.origin[2] + target_height);
    dir = vectornormalize(end_pos - start_pos);
    end_pos = end_pos - dir * 84;
    right = anglestoright(ent_target.angles);
    adj = randomfloatrange(63.0 * -1, 63.0);
    end_pos = end_pos + right * adj;
    time = randomfloatrange(0.45, 0.48);
    level thread karma_fake_tracer(start_pos, end_pos, time);
    delay = randomfloatrange(0.2, 0.26);
    wait(delay);
  }
}

karma_fake_tracer(start_pos, end_pos, alive_time) {
  e_mover = spawn("script_model", start_pos);
  e_mover setmodel("tag_origin");
  dir = end_pos - start_pos;
  dir = vectornormalize(dir);
  e_mover.angles = vectortoangles(dir);
  playfxontag(level._effect["fake_tracer"], e_mover, "tag_origin");
  e_mover moveto(end_pos, alive_time);
  wait(alive_time);
  e_mover delete();
}

make_ent_ignore_battle(str_targetname, use_magic_shield, delay) {
  if(isDefined(delay))
    wait(delay);

  e_ent = getent(str_targetname, "targetname");

  if(isDefined(e_ent)) {
    e_ent.takedamage = 0;
    e_ent.allowdeath = 0;
    e_ent.ignoreme = 1;
    e_ent.saved_health = e_ent.health;
    e_ent.health = 99999;

    if(isDefined(use_magic_shield)) {
    }
  } else {
    iprintlnbold("Ent " + str_targetname + " is missing and cannot be set to ignore.");

  }
}

make_ent_a_battle_target(str_targetname, magic_bullet_shield, delay) {
  if(isDefined(delay))
    wait(delay);

  e_ent = getent(str_targetname, "targetname");
  e_ent.takedamage = 1;
  e_ent.allowdeath = 1;
  e_ent.ignoreme = 0;
  e_ent.health = e_ent.saved_health;

  if(isDefined(magic_bullet_shield)) {
  }
}

little_bird_attack_drinks_area() {
  trigger_wait("trig_pagoda_explode");
  maps\_anim::addnotetrack_customfunction("fxanim_props", "pillar_01_explode", ::bar_exploder1, "circle_bar");
  maps\_anim::addnotetrack_customfunction("fxanim_props", "pillar_02_explode", ::bar_exploder2, "circle_bar");
  maps\_anim::addnotetrack_customfunction("fxanim_props", "rotunda_impact", ::bar_exploder3, "circle_bar");
  playsoundatposition("evt_dome_explo_main", (501, 609, -2979));
  level notify("fxanim_circle_bar_start");
  getent("circle_bar_dome", "targetname") delete();
  level.ai_redshirt1 queue_dialog("sec0_it_s_coming_down_0");
}

lb_missile(target_pos, move_time) {
  start_pos = self.origin;
  e_mover = spawn("script_model", start_pos);
  e_mover setmodel("tag_origin");
  e_mover.angles = self.angles;
  playfxontag(level._effect["heli_missile_tracer"], e_mover, "tag_origin");
  e_mover playsound("wpn_little_bird_rocket_fire_npc");
  e_mover moveto(target_pos, move_time);
  wait(move_time);
  v_dir = anglestoforward(e_mover.angles);
  v_pos = e_mover.origin + v_dir * 126;
  playfx(level._effect["def_explosion"], v_pos);
  playsoundatposition("exp_little_bird_missile_explo", v_pos);
  e_mover delete();
}

bar_exploder1(e_ent) {
  exploder(913);
}

bar_exploder2(e_ent) {
  exploder(914);
}

bar_exploder3(e_ent) {
  exploder(915);
}

e9_setup_balcony_explosion_blocker_triggers() {
  e_triggers = getentarray("e9_balcony_explosion_blocker_trigger", "targetname");

  if(isDefined(e_triggers)) {
    for(i = 0; i < e_triggers.size; i++)
      e_triggers[i] thread e9_balcony_blocker_trigger();
  }
}

e9_balcony_blocker_trigger() {
  level endon("balcony_blocker_away");
  self waittill("trigger");
  delay = 0.01;

  if(isDefined(self.script_delay))
    delay = self.script_delay;

  level thread defalco_blows_up_building(delay);
  wait 1.5;
  level notify("balcony_blocker_away");
}

e9_player_reaches_bottom_left_stairs_trigger(delay, str_category) {
  level endon("metal_storm_cleanup");
  wait(delay);
  e_trigger = getent("e9_player_reaches_bottom_left_stairs_trigger", "targetname");
  e_trigger waittill("trigger");

  if(isDefined(level.stairs_spawn_manager)) {
    if(is_spawn_manager_enabled(level.stairs_spawn_manager))
      spawn_manager_kill(level.stairs_spawn_manager);
  }
}

e9_stairs_by_blockage_trigger(delay, str_category) {
  level endon("metal_storm_cleanup");
  wait(delay);
  e_trigger = getent("e9_stairs_by_blockage_trigger", "targetname");
  e_trigger waittill("trigger");
  event9_save("e9_upper_left_stairs");
  a_spawners = getentarray("e9_north_cliff_west_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners);

  simple_spawn("e9_north_cliff_west_rusher", ::aggressive_runner, str_category);
}

defalco_blows_up_building(delay) {
  level thread e9_balcony_blowup_stairs_stumble_anim();
  level notify("fxanim_balcony_block_start");
  level thread balcony_blowup_effects();
  m_pristine = getent("sundeck_deck_explosion", "targetname");

  if(isDefined(m_pristine))
    m_pristine delete();

  v_pos = (-777, 1501, -3068);
  scale = 0.45;
  duration = 1.5;
  radius = 2520;
  earthquake_delay(0.1, scale, duration, v_pos, radius);
  level thread sec_explosion();
}

balcony_blowup_effects() {
  exploder(844);
  exploder(845);
  playsoundatposition("exp_veh_large", (-990, 1601, -2872));
  exploder(846);
}

ai_rappel_run_away(str_exit_node, delete_at_goal) {
  self endon("death");
  self.b_rappelling = 1;
  self waittill("rappel_done");
  self.b_rappelling = undefined;
  self change_movemode("sprint");
  nd_node = getnode(str_exit_node, "targetname");
  self setgoalnode(nd_node);
  self.goalradius = 50;
  self waittill("goal");

  if(isDefined(delete_at_goal)) {
    self delete();
    return;
  }

  self.goalradius = 2048;
}

e9_post_ms_left_begin_trigger(str_category) {
  t_trigger = getent("e9_post_ms_left_begin_trigger", "targetname");
  t_trigger waittill("trigger");
  level notify("metal_storm_cleanup");
  event9_save("e9_post_metal_storm");
  a_holders = getentarray("e9_post_ms_left_begin_hold_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn(a_holders, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 0, 0);

  a_spawners = getentarray("e9_post_ms_left_begin_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn(a_spawners, ::spawn_fn_ai_run_to_target, 0, str_category, 0, 0, 0);

  sp_rushers = getentarray("e9_post_ms_left_begin_rusher_spawner", "targetname");
  a_ai = simple_spawn(sp_rushers);

  if(isDefined(a_ai)) {
    for(i = 0; i < a_ai.size; i++)
      a_ai[i] thread aggressive_runner(str_category);
  }

  a_holders = getentarray("e9_post_ms_left_begin_prone_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn(a_holders, ::spawn_fn_ai_run_to_prone_node, 1, str_category, 0, 0);
}

e9_post_ms_right_begin_trigger(str_category) {
  t_trigger = getent("e9_post_ms_right_begin_trigger", "targetname");
  t_trigger waittill("trigger");
  level notify("metal_storm_cleanup");
  event9_save("e9_post_metal_storm");
  a_holders = getentarray("e9_post_ms_right_begin_hold_spawner", "targetname");

  if(isDefined(a_holders))
    simple_spawn_script_delay(a_holders, ::spawn_fn_ai_run_to_holding_node, 1, str_category, 0, 0);

  a_spawners = getentarray("e9_post_ms_right_begin_regular_spawner", "targetname");

  if(isDefined(a_spawners))
    simple_spawn_script_delay(a_spawners, ::spawn_fn_ai_run_to_target, 0, str_category, 0, 0, 0);

  sp_rushers = getentarray("e9_post_ms_right_begin_rusher_spawner", "targetname");
  a_ai = simple_spawn(sp_rushers);

  if(isDefined(a_ai)) {
    for(i = 0; i < a_ai.size; i++)
      a_ai[i] thread aggressive_runner(str_category);
  }
}

civilians_injured_from_battle_anim() {
  level thread run_scene("sundeck_civ_injured_and_helper_idle");
  a_ais = get_model_or_models_from_scene("sundeck_civ_injured_and_helper_idle");

  foreach(ai in a_ais)
  ai add_cleanup_ent("sundeck_intro");
}

civilians_running_from_battle_anim() {
  thread run_scene("sundeck_civ_injured_and_helper");
  flag_wait("sundeck_civ_injured_and_helper_started");
  a_ais = get_ais_from_scene("sundeck_civ_injured_and_helper");

  foreach(ai in a_ais)
  ai add_cleanup_ent("sundeck_intro");
}

civilian_group4_waiting_to_escape_anim(delay) {
  if(isDefined(delay))
    wait(delay);

  flag_wait("karma_2_gump_sundeck");
  level thread run_scene_and_delete("scene_civilian_group4_escape_begin_loop");
  trigger_wait("e9_player_enters_sundeck");
  run_scene_and_delete("scene_civilian_group4_escape_running");
  level thread run_scene_and_delete("scene_civilian_group4_escape_end_loop");
  a_civs = get_model_or_models_from_scene("scene_civilian_group4_escape_end_loop");
  array_thread(a_civs, ::auto_delete_with_ref);
}

civilian_left_stairs_group1_anim(delay) {
  if(isDefined(delay))
    wait(delay);

  flag_wait("karma_2_gump_sundeck");
  level thread run_scene_and_delete("scene_civilian_left_stairs_group1_begin_loop");

  while(true) {
    dist = can_see_position((-3905, 1752, -3278), 0.9);

    if(dist > 0.0 && dist < 2450) {
      break;
    }

    wait 0.25;
  }

  level notify("civilian_left_stairs_group1_anim_starting");
  run_scene_and_delete("scene_civilian_left_stairs_group1_run");
  level thread run_scene_and_delete("scene_civilian_left_stairs_group1_begin_loop_mid");
  wait 1;
  max_wait_time = 120;
  start_time = gettime();

  while(true) {
    time = gettime();
    dt = (time - start_time) / 1000;

    if(dt > max_wait_time) {
      break;
    }

    if(flag("upper_left_stairs_spawners_active")) {
      break;
    }

    wait 0.5;
  }

  level thread run_scene_and_delete("scene_civilian_left_stairs_group1_run_and_exit");
  wait 1.5;
  level notify("civilian_left_stairs_group1_anim_ending");
}

civilian_left_stairs_group2_anim(delay) {
  if(isDefined(delay))
    wait(delay);

  flag_wait("karma_2_gump_sundeck");
  level thread run_scene_and_delete("scene_civilian_left_stairs_group2_begin_loop");
  level waittill("civilian_left_stairs_group1_anim_starting");
  wait 1.6;
  end_scene("scene_civilian_left_stairs_group2_begin_loop");
  run_scene_and_delete("scene_civilian_left_stairs_group2_run");
  level thread run_scene_and_delete("scene_civilian_left_stairs_group2_begin_loop_mid");
  level waittill("civilian_left_stairs_group1_anim_ending");
  end_scene("scene_civilian_left_stairs_group2_begin_loop_mid");
  run_scene_and_delete("scene_civilian_left_stairs_group2_run_and_exit");
}

civilian_balcony_fling_anim(delay, str_category) {
  if(isDefined(delay))
    wait(delay);

  flag_wait("karma_2_gump_sundeck");
  str_scene_name = "scene_e9_start_balcony_fling";
  level thread run_scene(str_scene_name);
  wait 1;
  add_category_to_ai_in_scene(str_scene_name, str_category);
}

civilian_rocks_execution_anim(delay, str_category_snipers) {
  if(isDefined(delay))
    wait(delay);

  str_civilian_killed_targetname = "civ_executed_on_rocks_ai";
  str_executioner_targetname = "guard_rocks_executioner_ai";
  level thread make_ent_ignore_battle(str_executioner_targetname, undefined, 0.1);
  run_scene("sundeck_rocks_execution");
  e_dead_civ = getent(str_civilian_killed_targetname, "targetname");

  if(isalive(e_dead_civ))
    e_dead_civ ragdoll_death();

  nd_node = getnode("executioner_cover_node", "targetname");
  e_executioner = getent("guard_rocks_executioner_ai", "targetname");

  if(isalive(e_executioner)) {
    e_executioner endon("death");
    e_executioner setup_bunker_enemy_params();
    e_executioner setgoalpos(e_executioner.origin);
    e_executioner thread spawn_fn_ai_run_to_target(undefined, undefined, 0, 0, 0);
    e_executioner add_cleanup_ent(str_category_snipers);
    level make_ent_a_battle_target(str_executioner_targetname, undefined, undefined);
    e_executioner setup_bunker_enemy_params();
  }
}

e9_balcony_blowup_stairs_stumble_anim(delay) {
  if(isDefined(delay))
    wait(delay);

  flag_wait("karma_2_gump_sundeck");
  run_scene("scene_e9_balcony_blowup_stairs_stumble");
}

e9_civ_rocks_right_trigger(delay) {
  trigger_wait("e9_civ_rocks_right_trigger", "targetname");
  simple_spawn_single("rich_male_1", ::follow_path, "e9_civ_rocks_right_a", 1);
  simple_spawn_single("rich_male_2", ::follow_path, "e9_civ_rocks_right_b", 1);
}

e9_civ_bridge_to_stairs(delay) {
  wait 0.8;
  simple_spawn_single("rich_male_1", ::follow_path, "e9_civ_bridge_stairs_b", 1);
  wait 1;
  simple_spawn_single("rich_male_3", ::follow_path, "e9_civ_bridge_stairs_a", 1);
}

e9_civs_left_pre_metal_storm_trigger(delay) {
  trigger_wait("e9_civs_left_pre_metal_storm_trigger", "targetname");
  wait 1;
  simple_spawn_single("rich_male_1", ::follow_path, "e9_civ_left_ms_b", 1);
}

e9_civ_left_end_trigger() {
  trigger_wait("e9_civ_left_end_trigger", "targetname");
  simple_spawn_single("rich_male_1", ::follow_path, "e9_civ_left_end_a", 1);
  wait 0.7;
  simple_spawn_single("rich_male_2", ::follow_path, "e9_civ_left_end_b", 1);
  wait 2.0;
  simple_spawn_single("rich_male_3", ::follow_path, "e9_civ_left_end_a", 1);
}

e9_civ_right_end_trigger() {
  trigger_wait("e9_civ_right_end_trigger", "targetname");
  simple_spawn_single("rich_male_1", ::follow_path, "e9_civ_right_end_a", 1);
  wait 0.5;
  simple_spawn_single("rich_female_1", ::follow_path, "e9_civ_right_end_b", 1);
}

e9_civ_middle_end_trigger() {
  trigger_wait("e9_civ_middle_end_trigger", "targetname");
  simple_spawn_single("rich_male_2", ::follow_path, "e9_civ_middle_end_a", 1);
  wait 0.6;
  simple_spawn_single("rich_female_2", ::follow_path, "e9_civ_middle_end_b1", 1);
}

defalco_karma_exiting_pool_area_pip() {
  dialog_start_convo();
  level thread pip_karma_event("pip_stairs");
  flag_wait("glasses_bink_playing");
  level.player priority_dialog("fari_it_s_the_cell_phone_0");
  level.player priority_dialog("sect_block_the_signal_0");
  level.player priority_dialog("fari_working_on_it_0");
  dialog_end_convo();
  level thread nag_move_forward(20.0, 30.0);
}

metal_storm_intro_dialog() {
  flag_wait("vol_sundeck_mall_spawning");
  queue_dialog_enemy("pmc0_we_have_orders_do_0");
  queue_dialog_enemy("pmc0_the_americans_are_pr_0");
  dialog_start_convo();
  level.player priority_dialog("fari_al_jinan_s_defenses_0");
  level.player priority_dialog("fari_without_your_id_aut_0");
  level.ai_harper priority_dialog("harp_that_include_the_ene_1");
  level.player priority_dialog("fari_any_armed_personnel_0");
  level.ai_harper priority_dialog("harp_least_it_s_not_all_b_0");
  dialog_end_convo();
  queue_dialog_enemy("pmc0_there_s_a_small_numb_0");
  queue_dialog_enemy("pmc0_take_them_out_0");
  level thread sec_asd_alert();
  level thread nag_move_forward(20.0, 30.0);
}

nag_move_forward(n_wait_min, n_wait_max) {
  level endon("stop_naglines");
  level notify("nag_move_forward");
  level endon("nag_move_forward");
  a_harper_nag = [];
  a_harper_nag[0] = "harp_briggs_ain_t_gonna_b_0";
  a_harper_nag[1] = "harp_keep_moving_section_0";
  a_harper_nag[2] = "harp_we_gotta_move_we_re_0";
  a_salazar_nag = [];
  a_salazar_nag[0] = "sala_we_re_going_to_lose_0";
  a_salazar_nag[1] = "sala_we_have_to_move_fast_0";
  a_salazar_nag[2] = "sala_don_t_slow_down_0";
  a_salazar_nag[3] = "sala_we_re_losing_him_0";
  a_salazar_nag[4] = "sala_hurry_section_0";
  a_salazar_nag[5] = "sala_defalco_s_getting_aw_0";

  while(true) {
    if(cointoss())
      level.ai_harper queue_dialog(a_harper_nag[randomint(a_harper_nag.size)], 0, undefined, undefined, 0);
    else
      level.ai_salazar queue_dialog(a_salazar_nag[randomint(a_salazar_nag.size)], 0, undefined, undefined, 0);

    wait(randomfloatrange(n_wait_min, n_wait_max));
  }
}

e9_post_ms_background_enemy_rusher_control(str_category) {
  a_ents = getentarray("e9_post_ms_background_enemy_rusher_spawner", "targetname");

  if(isDefined(a_ents)) {
    a_enemy_spawners = array_randomize(a_ents);

    for(i = 0; i < a_enemy_spawners.size; i++) {
      e_ai = simple_spawn_single(a_enemy_spawners[i]);

      if(isDefined(e_ai))
        e_ai thread aggressive_runner(str_category);

      delay = randomfloatrange(0.1, 0.4);
      wait(delay);
    }
  }
}

fighting_withdrawl() {
  self endon("death");

  if(!isDefined(self.script_string)) {
    return;
  }
  self waittill("goal");
  self.fixednode = 0;
  self.canflank = 1;
  e_goalvolume = level.goalvolumes[self.script_string];

  while(isDefined(e_goalvolume)) {
    self setgoalvolumeauto(e_goalvolume);
    self waittill("goal");
    flag_wait(e_goalvolume.script_goalvolume + "_fallback");
    wait(randomfloat(2.0));

    if(isDefined(e_goalvolume.target)) {
      a_e_goalvolume = getentarray(e_goalvolume.target, "targetname");

      if(a_e_goalvolume.size > 1) {
        e_goalvolume = random(a_e_goalvolume);
        a_e_goalvolume = undefined;
      } else
        break;
    } else
      break;
  }
}

setup_fallback_monitors() {
  level thread fallback_monitor("vol_sundeck_mall", 5);
  level thread fallback_monitor("vol_sundeck_west_1f", 5, "vol_south_cliff_west");
  level thread fallback_monitor("vol_sundeck_west_2f", 2);
  level thread fallback_monitor("vol_north_cliff_west_1f", 5);
  level thread fallback_monitor("vol_north_cliff_west_2f", 4, "vol_cliffs_east");
  level thread fallback_monitor("vol_south_cliff_west", 7, "vol_sundeck_west_1f", "vol_sundeck_west_2f");
  level thread fallback_monitor("vol_cliffs_east", 2, "vol_north_cliff_west_1f", "vol_north_cliff_west_2f");
}

fallback_monitor(str_aigroup, n_kill_limit, str_fallback_extra1, str_fallback_extra2) {
  str_fallback = str_aigroup + "_fallback";
  level endon(str_fallback);
  flag_init(str_fallback);
  waittill_ai_group_amount_killed(str_aigroup, n_kill_limit);
  flag_set(str_fallback);

  if(isDefined(str_fallback_extra1))
    flag_set(str_fallback_extra1 + "_fallback");

  if(isDefined(str_fallback_extra2))
    flag_set(str_fallback_extra2 + "_fallback");
}

pmc_asd_alert() {
  self queue_dialog("pmc0_asds_are_hostile_0");
}

sec_asd_alert() {
  wait 1.0;
  level.ai_redshirt1 queue_dialog("sec0_the_asds_are_out_of_0");
  level.ai_redshirt2 queue_dialog("sec0_can_t_we_turn_them_o_0");
}

sec_explosion() {
  dialog_start_convo();
  priority_dialog_ally("sec0_they_just_set_off_an_0");
  priority_dialog_ally("sec1_it_s_a_terrorist_att_0");
  priority_dialog_ally("sec2_no_they_re_private_0");
  dialog_end_convo();
}

pmc_defalco_extract_init() {
  foreach(e_trig in getentarray("pmc_defalco_extract_trigger", "targetname"))
  e_trig thread pmc_defalco_extract_think();
}

pmc_defalco_extract_think() {
  level endon("pmc_defalco_extract");
  self waittill("trigger");
  level thread pmc_defalco_extract_vocal();
  level notify("pmc_defalco_extract");
}

pmc_defalco_extract_vocal() {
  queue_dialog_enemy("pmc0_chopper_s_inbound_0");
  queue_dialog_enemy("pmc0_prepare_for_emergenc_0");
  queue_dialog_enemy("pmc0_ensure_defalco_gets_0");
}

#using_animtree("animated_props");

show_geo_models_trigger() {
  maps\karma_exit_club::karma2_hide_tower_and_shell();
  flag_wait("close_sundeck_door");
  m_door = getent("security_gate", "targetname");
  m_door useanimtree(#animtree);
  m_door clearanim( % root, 0);
  stop_exploder(666);
  stop_exploder(10700);
  stop_exploder(10710);
  stop_exploder(10711);
  door_collision = getent("e7_door_clip", "targetname");
  door_collision disconnectpaths();
  maps\karma_exit_club::karma2_show_tower_and_shell();
}

mall_cleanup_trigger() {
  t_cleanup = getent("clean_up_mall", "targetname");

  while(true) {
    t_cleanup trigger_wait();

    if(level.ai_harper istouching(t_cleanup) && level.ai_salazar istouching(t_cleanup)) {
      if(!flag("brute_done") || level.vh_friendly_asd istouching(t_cleanup)) {
        break;
      }
    }
  }

  t_cleanup delete();
  flag_set("close_sundeck_door");
}