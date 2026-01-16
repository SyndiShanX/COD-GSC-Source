/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\monsoon_ruins.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_objectives;
#include maps\_vehicle;
#include maps\_scene;
#include maps\_dialog;
#include maps\monsoon_util;
#include maps\_music;
#include maps\_stealth_logic;
#include maps\_patrol;
#include maps\_titus;
#include maps\_camo_suit;
#include maps\_vehicle_death;
#include maps\_cic_turret;
#include maps\createart\monsoon_art;

init_ruins_flags() {
  flag_init("ruins_stealth_over");
  flag_init("player_reached_switchback");
  flag_init("player_reached_helipad");
  flag_init("squad_reached_helipad");
  flag_init("helicopter_destroyed_early");
  flag_init("salazar_destroyed_heli");
  flag_init("heli_retreat_to_ruins");
  flag_init("helipad_battle_intro_vo_done");
  flag_init("player_reached_outer_ruins");
  flag_init("squad_reached_outer_ruins");
  flag_init("squad_reached_temple_entrance");
  flag_init("player_reached_temple_entrance");
  flag_init("ruins_door_destroyed");
  flag_init("ruins_door_destroyed_safe");
  flag_init("player_in_ruins_interior");
  flag_init("seal_ruins");
  flag_init("player_off_turret");
  flag_init("spawn_helipad_gaz");
  flag_init("player_past_turrets");
  flag_init("fx_light_fall");
  flag_init("ammo_carry_right");
  flag_init("plant_turret");
  flag_init("helipad_fx_tarp");
  flag_init("start_helipad_vo");
}

skipto_camo_battle() {
  level.harper = init_hero("harper", ::skipto_teleport_single_ai, getstruct("harper_skipto_camo_battle", "targetname"));
  level.salazar = init_hero("salazar", ::skipto_teleport_single_ai, getstruct("salazar_skipto_camo_battle", "targetname"));
  level.crosby = init_hero("crosby", ::skipto_teleport_single_ai, getstruct("crosby_skipto_camo_battle", "targetname"));
  skipto_teleport_players("player_skipto_camo_battle");
  trigger_use("camo_intro_squad_color");
  array_thread(get_heroes(), ::set_ignoreme, 1);
  array_thread(get_heroes(), ::set_ignoreall, 1);
  level.player set_ignoreme(1);
  level.player allowstand(0);
  level.player allowcrouch(0);
  wait 0.5;
  level.player allowstand(1);
  level.player allowcrouch(1);
  run_scene("camo_intro_enemy_1");
  run_scene("camo_intro_enemy_2");
  run_scene("camo_intro_enemy_3");
  level.player set_ignoreme(0);
}

skipto_helipad_battle() {
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  skipto_teleport("player_skipto_helipad_battle", get_heroes());
  veh_gaz = spawn_vehicle_from_targetname("camo_battle_gaz");
  veh_gaz.drivepath = 0;
  veh_gaz thread go_path(getvehiclenode("skipto_gaz_path", "targetname"));
}

skipto_outer_ruins() {
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  skipto_teleport("player_skipto_outer_ruins", get_heroes());
  setmusicstate("MONSOON_BATTLE_1");
}

skipto_inner_ruins() {
  setcellinvisibleatpos(getent("obj_ruins_interior", "targetname").origin);
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  skipto_teleport("player_skipto_inner_ruins", get_heroes());
  spawn_manager_enable("sm_heli_battle");
  delay_thread(2, ::spawn_manager_kill, "sm_heli_battle");
  level thread outer_ruins_ammo_carry_right();
  level thread outer_ruins_plant_turret();
}

skipto_ruins_interior() {
  set_rain_level(3);
  level.harper = init_hero("harper");
  level.salazar = init_hero("salazar");
  level.crosby = init_hero("crosby");
  skipto_teleport("player_skipto_ruins_interior", get_heroes());
  trigger_use("trigger_color_ruins_interior");
}

challenge_sentryemp(str_notify) {
  while(true) {
    level waittill("sentry_emp_kill");
    self notify(str_notify);
  }
}

challenge_turretkills(str_notify) {
  while(true) {
    level waittill("turret_death");
    self notify(str_notify);
  }
}

challenge_helikill(str_notify) {
  level waittill("helicopter_destroyed_early");
  self notify(str_notify);
}

camo_battle_main() {
  setsaveddvar("cg_aggressiveCullRadius", "300");
  camo_battle_cleanup_anims();
  camo_intro_stealth_settings();
  add_spawn_function_group("camo_battle_loop", "script_noteworthy", ::camo_stealth_loop);
  level thread camo_battle_stealth_watch();
  level thread camo_mighty_mason();
  level thread camo_battle_fx_boxes();
  level thread camo_battle_fx_light();
  spawn_manager_enable("sm_camo_battle");
  level.player thread maps\_stealth_logic::stealth_ai();
  array_thread(get_heroes(), ::camo_battle_friendly_stealth);
  set_rain_level(5);
  level thread camo_battle_lift();
  flag_wait("predator_intro_scene_done");
  array_thread(get_heroes(), ::hero_rain_thread);
  autosave_by_name("camo_battle");
  camo_patrol("lz_patroller_2", "intro_patrol_left");
  camo_patrol("lz_patroller_1", "intro_patrol_right");
  camo_patrol("lz_invisible_patroller", "intro_patrol_left_camo");
  level thread camo_battle_friendly_stealth_move();
  n_camo_aigroup_size = get_ai_group_count("camo_battle_main");
  use_trigger_on_group_count("camo_battle_main", "camo_harper_jump_down", n_camo_aigroup_size - 2);
  use_trigger_on_group_count("camo_battle_main", "lift_patrol_start", n_camo_aigroup_size - 3);
  use_trigger_on_group_count("camo_battle_main", "camo_salazar_jump_down", n_camo_aigroup_size - 5);
  use_trigger_on_group_count("camo_battle_main", "camo_battle_middle", n_camo_aigroup_size - 7);
  level thread camo_battle_move_up_final();
  wait 2;
  array_thread(getaiarray("axis"), ::camo_battle_stealth_assist);
  level thread camo_stealth_positive_listener();
  delay_thread(3, ::camo_battle_stealth_settings);
  enemy_vo[0] = "cub0_we_re_under_attack_0";
  enemy_vo[1] = "cub1_sound_the_alarm_0";
  enemy_vo[2] = "cub2_there_at_the_front_0";
  enemy_vo[3] = "cub3_return_fire_0";
  enemy_vo[4] = "cub0_multiple_targets_0";
  enemy_vo[5] = "cub1_they_re_coming_up_th_0";
  enemy_vo[6] = "cub2_multiple_targets_by_0";
  enemy_vo[7] = "cub3_begin_the_evacuation_0";
  enemy_vo[8] = "cub0_get_those_charges_se_0";
  add_flag_function("ruins_stealth_over", ::enemy_dialog_zone, enemy_vo, "player_reached_switchback", 8, 10);
  flag_wait("player_reached_switchback");
  level thread camo_battle_gaz_retreat();
  use_trigger_on_group_count("lift_top", "obj_helipad", 1, 1);

  if(!flag("ruins_stealth_over")) {
    spawn_manager_kill("sm_camo_break_stealth");
    level notify("stealth_successful");
    flag_set("ruins_stealth_over");
    level thread camo_battle_stealth_success_vo();
  }

  level notify("_stealth_stop_stealth_logic");
}

camo_mighty_mason() {
  t_use = getent("trigger_mighty", "targetname");
  t_use sethintstring(&"SCRIPT_HOLD_TO_USE");
  t_use setcursorhint("HINT_NOICON");
  t_use trigger_off();
  level waittill("stealth_successful");

  while(isDefined(level.lightning_strike) && level.lightning_strike)
    wait 0.05;

  clientnotify("where_is_the_light");
  lightning_strike();
  lightning_strike();
  lightning_strike();
  t_use trigger_on();
  level thread camo_mighty_mason_fx();
  t_use waittill("trigger", player);
  level thread run_scene("mighty_mason");
  player thread camo_titus_replenish();
  n_period = 0.1;
  n_duration = 2.5;
  n_start_time = gettime();
  saved_vision = player getvisionsetnaked();
  toggle = 1;
  n_duration_ms = n_duration * 1000;
  wait 0.5;

  while(true) {
    if(gettime() > n_start_time + n_duration_ms) {
      break;
    }

    if(toggle)
      player visionsetnaked("taser_mine_shock", 0);
    else
      player visionsetnaked(saved_vision, 0);

    toggle = !toggle;
    earthquake(0.2, 0.1, player.origin, 256, player);
    wait(n_period);
  }

  player visionsetnaked(saved_vision, 1);
  screen_message_create(&"MONSOON_NOT_WORTHY");
  wait 3;
  screen_message_delete();
}

camo_mighty_mason_fx() {
  s_fx = getstruct("mighty_fx", "targetname");

  while(!flag("mighty_mason_done")) {
    playfx(getfx("mighty_fx"), s_fx.origin);
    wait 3;
  }
}

camo_titus_replenish() {
  self endon("death");

  while(true) {
    foreach(str_weapon in self getweaponslist()) {
      if(issubstr(str_weapon, "titus")) {
        self givemaxammo(str_weapon);
        self setweaponammoclip(str_weapon, weaponclipsize(str_weapon));
      }
    }

    wait 1;
  }
}

camo_battle_fx_boxes() {
  wait 14;
  level notify("fxanim_wind_crates_start");
}

camo_battle_fx_light() {
  m_light = getent("fxanim_wind_light", "targetname");
  m_light attach("p6_container_yard_light_on", "tag_origin");
  m_light play_fx("light_yard", undefined, undefined, "turn_off", 1, "tag_light1");
  m_light play_fx("light_yard", undefined, undefined, "turn_off", 1, "tag_light2");

  while(!flag("fx_light_fall"))
    m_light _sway_model(2, 0.5);

  level notify("fxanim_wind_light_start");
  level waittill("fx_light_fall");
  earthquake(1.0, 0.5, m_light.origin, 500);
  playrumbleonposition("artillery_rumble", m_light.origin);
  m_light notify("turn_off");
  m_light detach("p6_container_yard_light_on", "tag_origin");
}

camo_battle_gaz_retreat() {
  veh_gaz = spawn_vehicle_from_targetname("camo_battle_gaz");
  veh_gaz godon();
  t_start = trigger_wait("start_camo_battle_gaz");
  t_start delete();
  veh_gaz thread go_path(getvehiclenode("camo_battle_gaz_path", "targetname"));
  fx_anim = getent("fxanim_wind_barrel_01", "targetname");

  while(distance2d(level.player.origin, fx_anim.origin) > 700)
    wait 0.05;

  level notify("fxanim_wind_barrel_01_start");
}

camo_battle_stealth_success_vo() {
  level.salazar say_dialog("sala_something_triggered_1");
  wait 1;
  level.player say_dialog("sect_the_pmcs_must_have_b_1");
}

camo_battle_cleanup_anims() {
  delete_scene("cliff_intro", 1);
  delete_scene("cliff_swing_1_idle", 1);
  delete_scene("cliff_swing_1", 1);
  delete_scene("cliff_swing_1_fail", 1);
  delete_scene("cliff_swing_2_idle", 1);
  delete_scene("cliff_swing_2", 1);
  delete_scene("cliff_swing_2_fail", 1);
  delete_scene("cliff_swing_3_idle", 1);
  delete_scene("cliff_swing_3", 1);
  delete_scene("cliff_swing_3_fail", 1);
  delete_scene("cliff_swing_4_idle", 1);
  delete_scene("cliff_swing_4", 1);
  delete_scene("cliff_swing_4_fail", 1);
  delete_scene("cliff_swing_5_idle", 1);
  delete_scene("cliff_swing_5", 1);
  delete_scene("cliff_swing_5_fail", 1);
  delete_scene("cliff_swing_6_idle", 1);
  delete_scene("cliff_swing_6_player", 1);
  delete_scene("cliff_swing_6", 1);
}

camo_battle_move_up_final() {
  waittill_ai_group_cleared("camo_battle_main");

  if(flag("ruins_stealth_over"))
    waittill_ai_group_count("camo_broke_stealth", 1);

  trigger_use("camo_battle_switchbacks");
}

camo_battle_stealth_assist() {
  level endon("ruins_stealth_over");
  self endon("assisted_kill");
  self waittill("death", attacker);

  if(isplayer(attacker) & !flag("ruins_stealth_over")) {
    ai_close = get_closest_ai(self.origin, "axis");

    if(isDefined(ai_close) && distancesquared(self.origin, ai_close.origin) < 62500) {
      wait(randomfloatrange(0.4, 0.8));
      magicbullet("scar_silencer_sp", ai_close.origin + vectorscale((0, 0, 1), 80.0), ai_close geteye(), level.harper);
      ai_close notify("assisted_kill");

      if(cointoss())
        level.harper thread say_dialog("harp_other_one_s_mine_0", 0.5);
      else
        level.salazar thread say_dialog("sala_i_ll_take_the_other_0", 0.5);
    } else
      level notify("positive_kill");
  }
}

camo_stealth_positive_listener() {
  level endon("ruins_stealth_over");

  while(true) {
    level waittill("positive_kill");

    if(cointoss())
      level.harper thread say_dialog("harp_good_kill_0", 0.5);
    else
      level.salazar thread say_dialog("sala_well_done_section_0", 0.5);

    wait 1;
  }
}

camo_stealth_loop() {
  s_align = getstruct("camo_battle_intro", "targetname");
  n_index = self.script_int;
  s_align maps\_stealth_logic::stealth_ai_idle_and_react(self, "camo_stealth_loop_" + n_index, "camo_stealth_react_" + n_index);
}

camo_patrol(str_targetname, str_patrol_name) {
  ai_guy = get_ai(str_targetname + "_ai", "targetname");
  ai_guy.health = 100;

  if(isDefined(ai_guy) && isalive(ai_guy)) {
    ai_guy set_ignoreall(0);
    ai_guy thread maps\_patrol::patrol(str_patrol_name);
  }
}

camo_battle_stealth_watch() {
  level endon("stealth_successful");
  flag_wait("_stealth_spotted");
  flag_set("ruins_stealth_over");
  battlechatter_on("axis");
  wait 8;
  level clientnotify("stlth_x");
  spawn_manager_enable("sm_camo_break_stealth");
}

camo_battle_friendly_stealth() {
  self set_ignoreme(1);
  self set_ignoreall(1);
  self change_movemode("cqb");
  self disable_ai_color();
  self gun_switchto("scar_silencer_sp", "right");
  flag_wait("ruins_stealth_over");
  self reset_movemode();
  self set_ignoreme(0);
  self set_ignoreall(0);
  self enable_ai_color();
  self gun_switchto(self.primaryweapon, "right");
  self monsoon_hero_rampage(1);
}

camo_battle_friendly_stealth_move() {
  level endon("_stealth_spotted");
  level endon("_stealth_alert");
  wait 9;
  nd_goal = getnode("stealth_harper_move", "targetname");
  level.harper setgoalnode(nd_goal);
  level.harper waittill("goal");
  ai_guy = get_ai("lz_patroller_1_ai", "targetname");

  if(isDefined(ai_guy) && isalive(ai_guy)) {
    level.harper delay_thread(5, ::stop_shoot_at_target);
    level.harper shoot_and_kill(ai_guy, 1);
  }

  wait 20;
  ai_guy = get_ai("lz_invisible_patroller_ai", "targetname");

  if(isDefined(ai_guy) && isalive(ai_guy)) {
    level.crosby delay_thread(5, ::stop_shoot_at_target);
    level.crosby shoot_and_kill(ai_guy);
  }

  wait 10;
  nd_goal = getnode("stealth_salazar_move", "targetname");
  level.salazar setgoalnode(nd_goal);
  wait 5;
  nd_goal = getnode("stealth_crosby_move", "targetname");
  level.crosby setgoalnode(nd_goal);
}

camo_intro_stealth_settings() {
  hidden = [];
  hidden["prone"] = 2;
  hidden["crouch"] = 2;
  hidden["stand"] = 2;
  alert = [];
  alert["prone"] = 140;
  alert["crouch"] = 900;
  alert["stand"] = 1500;
  spotted = [];
  spotted["prone"] = 512;
  spotted["crouch"] = 5000;
  spotted["stand"] = 8000;
  maps\_stealth_logic::system_set_detect_ranges(hidden, alert, spotted);
}

camo_battle_stealth_settings() {
  hidden = [];
  hidden["prone"] = 50;
  hidden["crouch"] = 240;
  hidden["stand"] = 600;
  alert = [];
  alert["prone"] = 140;
  alert["crouch"] = 600;
  alert["stand"] = 800;
  spotted = [];
  spotted["prone"] = 512;
  spotted["crouch"] = 5000;
  spotted["stand"] = 8000;
  maps\_stealth_logic::system_set_detect_ranges(hidden, alert, spotted);
  level._stealth.logic.ai_event["ai_eventDistDeath"]["hidden"] = 128;
}

camo_battle_lift() {
  trigger_wait("lift_patrol_start");
  ai_lift_guard = getent("lift_guard", "targetname") spawn_ai(1);
  ai_lift_guard thread camo_battle_stealth_assist();

  if(flag("ruins_stealth_over")) {
    wait 0.05;
    ai_lift_guard force_goal(getnode("lift_patrol_goal", "targetname"), 32, 0);
  } else
    ai_lift_guard maps\_patrol::patrol("lift_patrol_goal");

  if(flag("ruins_stealth_over"))
    level.salazar thread say_dialog("sala_enemies_in_the_eleva_0", 4);
  else
    level.salazar thread say_dialog("sala_elevator_descending_0", 4);

  outside_lift_move_down();

  if(!flag("ruins_stealth_over"))
    ai_lift_guard patrol("lift_patrol_end");

  level notify("player_used_outside_lift");
  spawn_manager_enable("sm_lift_top");
}

helipad_battle_main() {
  setcellinvisibleatpos(getent("obj_ruins_interior", "targetname").origin);
  add_spawn_function_veh("heli_turret", ::heli_turret_think);
  add_spawn_function_veh("heli_killed", ::heli_killed_think);
  trigger_use("trigger_spawn_helicopters");
  spawn_manager_enable("sm_heli_guards");
  level thread helipad_destroy_lion_statue();
  level thread helipad_battle_spawn_gaz();
  level thread helipad_fx_tarp();
  level thread helipad_shield_plants();
  stop_exploder(34);
  set_rain_level(3);
  flag_wait("player_reached_helipad");
  enemy_vo[0] = "cub0_enemy_forces_moving_0";
  enemy_vo[1] = "cub1_they_re_by_the_helip_0";
  enemy_vo[2] = "cub2_spread_out_secure_0";
  enemy_vo[3] = "cub3_they_took_down_the_d_0";
  enemy_vo[4] = "cub0_by_the_south_wall_0";
  enemy_vo[5] = "cub1_flank_around_them_0";
  enemy_vo[6] = "cub2_we_can_t_hold_them_0";
  enemy_vo[7] = "cub3_we_need_to_secure_th_0";
  enemy_vo[8] = "cub0_fall_back_arm_the_0";
  enemy_vo[9] = "cub1_we_need_to_prep_for_0";
  enemy_vo[10] = "cub2_hold_them_at_the_gat_0";
  level thread enemy_dialog_zone(enemy_vo, "player_reached_outer_ruins");
  level thread helipad_battle_intro_vo();
  autosave_by_name("helipad");
  level thread helipad_squad_destroy_helicopter();
  level thread helipad_clean_up();
}

helipad_clean_up() {
  flag_wait("squad_reached_outer_ruins");
  a_t_color = getentarray("helipad_color_trigger", "script_noteworthy");

  foreach(color in a_t_color)
  color delete();

  flag_set("helipad_fx_tarp");
  wait 0.05;
  trigger_use("move_squad_outer_ruins");
  flag_wait("player_reached_outer_ruins");
  t_cleanup = getent("obj_ruins", "targetname");
  a_axis = getaiarray("axis");

  foreach(ai in a_axis) {
    if(ai.origin[0] < t_cleanup.origin[0])
      ai thread bloody_death(undefined, 5);
  }

  t_cleanup delete();
}

helipad_fx_tarp() {
  flag_wait("helipad_fx_tarp");
  level notify("fxanim_tarp_tree_start");
  level thread helipad_midway_cleanup();
  wait 5;
  level notify("fxanim_lion_statue_02_start");
}

helipad_midway_cleanup() {
  s_cleanup = getstruct("helipad_midway_cleanup", "targetname");
  a_axis = getaiarray("axis");

  foreach(ai in a_axis) {
    if(ai.origin[0] < s_cleanup.origin[0] || ai.origin[1] < s_cleanup.origin[1])
      ai thread bloody_death(undefined, 5);
  }
}

helipad_battle_spawn_gaz() {
  flag_wait("spawn_helipad_gaz");
  spawn_vehicle_from_targetname_and_drive("helipad_battle_gaz");
}

helipad_squad_destroy_helicopter() {
  array_func(get_heroes(), ::disable_ai_color);
  set_squad_blood_impact("none");
  level.salazar idle_at_cover(1);
  level.harper idle_at_cover(1);
  level.salazar thread force_goal(getnode("helipad_goal_salazar", "targetname"), 32, 1);
  wait 0.5;
  level.harper thread force_goal(getnode("helipad_goal_harper", "targetname"), 32, 1);
  wait 1.5;
  level.crosby thread force_goal(getnode("helipad_goal_crosby", "targetname"));
  waittill_multiple_ents(level.harper, "goal", level.salazar, "goal");
  flag_set("squad_reached_helipad");
  flag_wait("helipad_battle_intro_vo_done");
  wait 1;

  if(!flag("helicopter_destroyed_early")) {
    level thread run_scene("salazar_shoots_heli");
    level thread helipad_squad_destroy_helicopter_vo();
    wait 8;
  }

  level thread helipad_squad_vo();
  level.salazar helipad_salazar_crouch();
  array_func(get_heroes(), ::enable_ai_color);
  level.salazar notify("moving_cover");
  set_squad_blood_impact("hero");
  level.salazar idle_at_cover(0);
  level.harper idle_at_cover(0);
  use_trigger_on_group_count("group_helipad_front", "color_helipad_front", 1, 1);
  use_trigger_on_group_count("group_helipad_final", "color_helipad_final", 2, 1);
  use_trigger_on_group_count("group_helipad_chokepoint", "move_squad_outer_ruins", 1, 1);
}

helipad_salazar_crouch() {
  self allowedstances("crouch");
  self force_goal(getnode("helipad_post_titus_salazar", "targetname"), 16);
  wait 0.5;
  self allowedstances("stand", "crouch");
}

helipad_squad_vo() {
  level endon("player_reached_outer_ruins");
  wait 2;
  level.player say_dialog("sect_okay_let_s_get_mo_1");
  heli_vo[0] = "harp_push_forward_don_t_0";
  heli_vo[1] = "sala_moving_in_0";
  heli_vo[2] = "harp_move_in_clear_em_o_0";
  heli_vo[3] = "sala_they_re_falling_back_0";
  heli_vo[4] = "cros_engaging_0";
  heli_vo[5] = "harp_come_on_we_got_em_0";
  heli_vo[6] = "sect_go_go_0";

  foreach(line in heli_vo) {
    wait(randomfloatrange(10, 14));
    say_squad_dialog(line);
  }
}

helipad_squad_destroy_helicopter_vo() {
  level endon("helicopter_destroyed_early");
  level.harper say_dialog("harp_salazar_take_it_out_0");
}

helipad_destroy_lion_statue() {
  t_start = trigger_wait("helipad_lion_rpg");
  s_start = getstruct(t_start.target, "targetname");
  s_end = getstruct(s_start.target, "targetname");
  e_rpg = magicbullet("metalstorm_launcher", s_start.origin, s_end.origin);
  e_rpg waittill("death");
  level notify("fxanim_lion_statue_01_start");
  m_lion = getent("lion_statue_collision", "targetname");
  m_lion solid();
}

helipad_battle_intro_vo() {
  flag_wait("start_helipad_vo");
  level.harper say_dialog("harp_dead_ahead_chopper_0");
  wait 0.8;
  level.player say_dialog("sect_shit_we_can_t_let_1");
  wait 0.4;
  flag_set("helipad_battle_intro_vo_done");
}

helipad_shield_plants() {
  flag_wait("spawn_helipad_gaz");
  level thread helipad_ai_plant_shield(1);
  wait 4;
  level thread helipad_ai_plant_shield(2);
}

helipad_ai_plant_shield(n_plant) {
  ai = simple_spawn_single("shield_plant");
  ai endon("death");
  ai set_ignoreall(1);
  ai.animname = "shield_plant_" + n_plant;
  ai set_generic_run_anim("shield_run", 1);
  ai attach("t6_wpn_shield_carry_world", "tag_weapon_left");
  ai thread helipad_ai_detach_shield_early();
  level thread run_scene_and_delete("shield_plant_" + n_plant);
  flag_wait("shield_plant_" + n_plant + "_started");
  ai notify("early_check_over");
  ai thread helipad_ai_plant_shield_early();
  ai.shield = spawn_model("t6_wpn_shield_carry_world", ai gettagorigin("tag_weapon_left"), ai gettagangles("tag_weapon_left"));
  ai.shield setscriptmoverflag(0);
  ai.shield linkto(ai, "tag_weapon_left");
  ai detach("t6_wpn_shield_carry_world", "tag_weapon_left");
  ai.shield thread deploy_shield();
  ai set_ignoreall(0);
  ai set_goalradius(32);
  ai setgoalnode(getnode("shield_plant_cover_" + n_plant, "targetname"));
  ai clear_run_anim();
}

#using_animtree("animated_props");

deploy_shield() {
  self useanimtree(#animtree);
  self setanim( % o_mon_04_06_riot_shield_plant, 1.0, 0.0, 1.0);
  wait 0.8;
  playfxontag(getfx("shield_lights"), self, "tag_fx");
}

helipad_ai_detach_shield_early() {
  self endon("early_check_over");
  self waittill("death");
  m_shield = spawn_model("t6_wpn_shield_carry_world", self gettagorigin("tag_weapon_left"), self gettagangles("tag_weapon_left"));
  self detach("t6_wpn_shield_carry_world", "tag_weapon_left");
  m_shield physicslaunch();
}

helipad_ai_plant_shield_early() {
  self endon("shield_planted");
  self waittill("death");
  self.shield unlink();
  self.shield physicslaunch();
}

helipad_plant_shield(ai_actor) {
  wait 0.05;
  ai_actor notify("shield_planted");
  ai_actor.shield unlink();
}

helipad_battle_salazar_titus(ai_salazar) {
  vh_heli = getent("heli_killed", "targetname");
  ai_salazar maps\_titus::magic_bullet_titus(vh_heli.origin + vectorscale((0, 0, -1), 70.0));
  wait 2;
  flag_set("salazar_destroyed_heli");
  autosave_by_name("outer_ruins");
}

heli_turret_think() {
  level endon("seal_ruins");
  b_after_hack = 0;
  self setrotorspeed(0);
  self hidepart("tag_main_rotor_static");
  self heli_weapons_bay_close();
  self veh_toggle_tread_fx(0);
  self veh_magic_bullet_shield(1);
  self setteam("allies");
  wait 0.05;
  self veh_toggle_exhaust_fx(0);
  t_use = getent("helicopter_use_trigger", "targetname");
  t_use sethintstring(&"SCRIPT_HINT_INTRUDER");
  t_use setcursorhint("HINT_NOICON");
  t_use trigger_off();
  level.player waittill_player_has_intruder_perk();
  t_use trigger_on();
  set_objective_perk(level.obj_intruder, t_use, 1500);
  t_use thread heli_turret_vo();
  t_use waittill("trigger", player);
  t_use sethintstring("");
  self linkto(t_use);
  flag_clear("player_off_turret");
  v_player_origin = player.origin;
  v_player_angles = player getplayerangles();

  if(isDefined(b_after_hack) && !b_after_hack) {
    b_after_hack = 1;
    player set_ignoreme(1);
    remove_objective_perk(level.obj_intruder);
    flag_set("intruder_perk_used");
    run_scene_first_frame("heli_turret_retreat");
    delay_thread(0.05, maps\_camo_suit::data_glove_on, "intruder_perk");
    delay_thread(0.05, ::heli_weapons_bay_close);
    run_scene("intruder_perk");
    player set_ignoreme(0);
    level thread heli_turret_events();
  }

  n_objective_dist = getdvar(#"_id_D96CB2B0");
  player setclientdvar("cg_objectiveIndicatorNearFadeDist", 10000);
  level.weather_wind_shake = 0;
  set_rain_level(1);
  level notify("_rain_drops");
  level.player clearclientflag(6);
  setcellinvisibleatpos((3944, 53494, -782));
  screen_fade_out(0, undefined, 1);
  self hidepart("body_animate_jnt");
  self settargetentity(getent("heli_retreat", "targetname"), vectorscale((0, 0, 1), 70.0), 0);
  wait 0.2;
  self makevehicleusable();
  self usevehicle(player, 0);
  luinotifyevent(&"hud_shrink_ammo");
  player.overrideplayerdamage = ::heli_player_damage_override;
  player cleardamageindicator();
  player stopshellshock();
  player disableusability();
  setsaveddvar("cg_forceInfrared", 1);
  luinotifyevent(&"hud_update_vehicle");
  self thread heli_turret_damage_watch();
  self thread maps\_vehicle_death::vehicle_damage_filter("firestorm_turret");
  screen_fade_in(1.3, undefined, 1);
  level thread heli_turret_challenge_watch();
  player thread heli_turret_early_exit();
  player thread heli_turret_watch_overheat();
  player waittill_either("early_exit", "vehicle_destroyed");

  if(isDefined(self.disabled) && self.disabled)
    screen_fade_out(0, "compass_static", 1);
  else
    screen_fade_out(0, undefined, 1);

  player enableusability();
  self useby(player);
  self makevehicleunusable();
  self unlink();
  level.player playsound("evt_static");
  luinotifyevent(&"hud_expand_ammo");
  player.overrideplayerdamage = undefined;
  self showpart("body_animate_jnt");
  wait 0.2;
  player setorigin(v_player_origin);
  player setplayerangles(v_player_angles);
  luinotifyevent(&"hud_update_vehicle");
  setsaveddvar("cg_forceInfrared", 0);

  if(isDefined(self.disabled) && self.disabled) {
    wait 0.5;
    screen_fade_in(0, "compass_static", 1);
  } else
    screen_fade_in(1.3, undefined, 1);

  flag_set("player_off_turret");
  level.weather_wind_shake = 1;
  set_rain_level(3);
  level thread _rain_drops();
  setcellvisibleatpos((3944, 53494, -782));
  player setclientdvar("cg_objectiveIndicatorNearFadeDist", n_objective_dist);
  autosave_by_name("after_using_turret");
  t_use delete();
}

heli_player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  level.player cleardamageindicator();
  return false;
}

heli_turret_damage_watch() {
  self endon("early_exit");
  wait 5;
  self veh_magic_bullet_shield(0);

  while(self.health > self.healthmax - 500) {
    wait(randomfloatrange(0.5, 1.5));
    self dodamage(randomintrange(10, 25), self.origin);
  }

  self.disabled = 1;
  level.player notify("vehicle_destroyed");
}

heli_turret_vo() {
  level endon("player_off_turret");
  b_hint_vo = 1;

  while(!flag("intruder_perk_used")) {
    if(distance2d(self.origin, level.player.origin) < 500) {
      if(flag("helipad_battle_intro_vo_done") && b_hint_vo) {
        b_hint_vo = 0;
        level.harper say_dialog("harp_section_hack_the_w_1");
      }
    }

    wait 0.05;
  }

  wait 5;

  if(flag("helipad_battle_intro_vo_done"))
    level.harper say_dialog("harp_give_these_bastards_1");
}

heli_turret_events() {
  run_scene("heli_turret_retreat");
  trigger_use("sm_heli_turret");
  flag_set("spawn_helipad_gaz");
  flag_wait("player_off_turret");
  spawn_manager_kill("sm_heli_turret");
}

heli_turret_challenge_watch() {
  while(!flag("player_off_turret")) {
    a_enemies = getaiarray("axis");

    foreach(enemy in a_enemies) {
      if(!isDefined(enemy.watched)) {
        enemy.watched = 1;
        enemy thread heli_turret_challenge_watch_think();
      }
    }

    wait 1;
  }
}

heli_turret_challenge_watch_think() {
  level endon("player_off_turret");
  self waittill("death", blah1, blah2, str_weapon);

  if(isDefined(str_weapon) && str_weapon == "future_minigun_enemy_pilot")
    level notify("turret_death");
}

heli_turret_early_exit() {
  self endon("vehicle_destroyed");
  wait 0.05;

  while(isalive(self)) {
    if(self use_button_held()) {
      self notify("early_exit");
      return;
    }

    wait 0.05;
  }
}

heli_turret_watch_overheat() {
  self endon("vehicle_destroyed");
  level endon("player_off_turret");
  heat = 0;
  overheat = 0;

  while(true) {
    if(isDefined(self.viewlockedentity)) {
      old_heat = heat;
      heat = self.viewlockedentity getturretheatvalue(0);
      old_overheat = overheat;
      overheat = self.viewlockedentity isvehicleturretoverheating(0);

      if(old_heat != heat || old_overheat != overheat)
        luinotifyevent(&"hud_weapon_cg_heat", 2, int(heat), overheat);
    }

    wait 0.05;
  }
}

heli_turret_zap_start(player_body) {
  m_cutter = get_model_or_models_from_scene("intruder_perk", "intruder_cutter");
  m_cutter play_fx("laser_cutter_sparking", undefined, undefined, "stop_fx", 1, "tag_fx");
  level.player playrumblelooponentity("tank_rumble");
}

heli_turret_zap_end(m_cutter) {
  m_cutter = get_model_or_models_from_scene("intruder_perk", "intruder_cutter");
  m_cutter notify("stop_fx");
  level.player stoprumble("tank_rumble");
}

heli_killed_think() {
  self setrotorspeed(0);
  self heli_landing_gear_down();
  self veh_toggle_tread_fx(0);
  self thread heli_killed_damage_watch();
  self thread heli_killed_death_watch();
  flag_wait("player_reached_helipad");
  wait 0.05;
  self thread helipad_startup_sound();
  self setrotorspeed(0.8);
  wait 5;
  self veh_toggle_tread_fx(1);
}

helipad_startup_sound() {
  wait 1;
  snd_ent = spawn("script_origin", self.origin);
  snd_ent playsound("evt_helipad_startup");
  snd_ent playloopsound("evt_helipad_startup_lfe", 10);
  flag_wait_either("salazar_destroyed_heli", "helicopter_destroyed_early");
  snd_ent stopsound("evt_helipad_startup");
  snd_ent stoploopsound(0.5);
  wait 1;
  snd_ent delete();
}

heli_killed_death_watch() {
  m_fake = spawn_model("veh_t6_air_future_attack_heli_drone", self.origin, self.angles);
  m_fake.targetname = "heli_killed_fake";
  m_fake hide();
  m_fake notsolid();
  clip_living = getent("heli_alive", "targetname");
  clip_dead = getent("heli_dead", "targetname");
  clip_dead notsolid();
  clip_dead connectpaths();
  flag_wait_either("salazar_destroyed_heli", "helicopter_destroyed_early");
  clip_living delete();
  clip_dead solid();
  clip_dead disconnectpaths();
  level notify("fxanim_heli_explode_start");
  earthquake(0.8, 1.0, level.player.origin, 800, level.player);
  level.player playrumbleonentity("artillery_rumble");
  self.script_nocorpse = 1;
  self notify("death");
  self setteam("none");
  self setrotorspeed(0);
  self veh_toggle_tread_fx(0);
  self veh_toggle_exhaust_fx(0);
  self hide();
  m_fake show();
  m_fake solid();
  m_fake thread heli_killed_fake();
  a_nearby_enemies = get_ai_group_ai("helipad_near");

  foreach(enemy in a_nearby_enemies)
  enemy die();

  wait 1;
  self delete();
}

#using_animtree("vehicles");

heli_killed_fake() {
  self useanimtree(#animtree);
  self setflaggedanim("notetrack", % fxanim_monsoon_heli_explode_anim, 1.0, 0.0, 1.0);
  wait 0.05;
  self setmodel("veh_t6_air_future_attack_heli_drone_dead");

  while(true) {
    self waittill("notetrack", note);

    switch (note) {
      case "sparks_large":
        exploder(242);
        break;
      case "sparks_small":
        exploder(243);
        break;
      case "end":
        return;
    }
  }
}

heli_killed_damage_watch() {
  level endon("salazar_destroyed_heli");
  self.health = 30000;
  n_damage_needed = 800;

  while(n_damage_needed > 0) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weaponname);

    if(attacker == level.player) {
      if(weaponname == "titus_explosive_dart_sp")
        n_damage_needed = 0;
      else
        n_damage_needed = n_damage_needed - damage;
    }
  }

  flag_set("helicopter_destroyed_early");
}

heli_landing_gear_down() {
  self setanim( % veh_anim_future_heli_geardown, 1.0, 0.0, 1.0);
}

heli_weapons_bay_close() {
  self setanim( % veh_anim_future_heli_bay_closed, 1.0, 0.0, 1.0);
}

heli_weapons_bay_open() {
  self setanimknob( % veh_anim_future_heli_bay_open, 1.0, 0.0, 1.0);
}

outer_ruins_main() {
  add_spawn_function_veh("outer_ruins_turret", ::outer_ruins_turret_think);
  a_turrets = spawn_vehicles_from_targetname("outer_ruins_turret");
  array_thread(a_turrets, ::outer_ruins_turret_lasers);
  level.n_outer_ruins_turrets = a_turrets.size;
  level thread outer_ruins_advance_destroy_turrets();
  flag_wait("player_reached_outer_ruins");
  autosave_by_name("outer_ruins");
  set_rain_level(3);
  level notify("fxanim_mudslide_debris_start");
  t_color = trigger_use("move_squad_outer_ruins");
  level thread outer_ruins_vo();
  level notify("fxanim_wind_barrel_02_start");
  delay_thread(1, ::run_scene_and_delete, "ammo_carry_left");
  level thread outer_ruins_ammo_carry_right();
  level thread outer_ruins_plant_turret();
  array_thread(get_heroes(), ::disable_pain);
  set_squad_blood_impact("none");
  autosave_by_name("inner_ruins_start");
  spawn_manager_enable("sm_heli_battle");

  while(level.n_outer_ruins_turrets > 1)
    wait 0.25;

  if(!flag("player_past_turrets")) {
    level.player thread queue_dialog("sect_turret_s_down_0", 2);
    level.harper thread queue_dialog("harp_nice_going_man_0", 4);
  }

  flag_set("player_past_turrets");
  array_thread(get_heroes(), ::enable_pain);
  set_squad_blood_impact("hero");
  autosave_by_name("sentry_turrets_destroyed");
  t_color delete();
}

outer_ruins_vo() {
  level endon("player_past_turrets");
  enemy_vo[0] = "cub0_let_the_turrets_deal_0";
  enemy_vo[1] = "cub2_we_ve_lost_a_turret_0";
  enemy_vo[2] = "cub3_they_ve_broken_throu_0";
  enemy_vo[3] = "cub1_they_re_flanking_aro_0";
  enemy_vo[4] = "cub0_by_the_south_wall_1";
  enemy_vo[5] = "cub1_north_side_0";
  enemy_vo[6] = "cub3_we_can_t_hold_them_0";
  enemy_vo[7] = "cub0_we_have_them_outnumb_0";
  enemy_vo[8] = "cub1_stand_your_ground_0";
  level thread enemy_dialog_zone(enemy_vo, "player_reached_temple_entrance");
  wait 4;
  level.harper queue_dialog("harp_shit_fucking_turre_0");
  wait 10;

  if(level.player hasweapon("emp_grenade_sp")) {
    level.harper queue_dialog("harp_emps_will_fry_em_0");
    wait 15;
    level.harper queue_dialog("harp_hit_em_with_emps_0");
  }
}

outer_ruins_ammo_carry_right() {
  level endon("player_reached_temple_entrance");
  flag_wait("ammo_carry_right");
  wait 0.5;
  run_scene_and_delete("ammo_carry_right");
}

outer_ruins_turret_think() {
  self waittill("death");

  if(isDefined(self.emped) && self.emped)
    level notify("sentry_emp_kill");

  level.n_outer_ruins_turrets--;

  if(!flag("player_past_turrets")) {
    if(level.n_outer_ruins_turrets == 2)
      level.harper thread queue_dialog("harp_hell_yeah_1");
    else if(level.n_outer_ruins_turrets == 1)
      level.harper thread queue_dialog("harp_you_fried_his_ass_s_0");
  }
}

outer_ruins_turret_lasers() {
  self endon("death");
  self maps\_cic_turret::cic_turret_off();
  flag_wait_either("player_reached_outer_ruins", "squad_reached_outer_ruins");
  self maps\_cic_turret::cic_turret_on();
}

outer_ruins_advance_destroy_turrets() {
  flag_wait("player_past_turrets");
  a_turrets = get_vehicle_array("outer_ruins_turret");

  foreach(turret in a_turrets) {
    if(isalive(turret)) {
      turret notify("death");
      wait(randomfloatrange(0.5, 1.0));
    }
  }
}

outer_ruins_plant_turret() {
  level endon("turret_plant");
  add_spawn_function_veh("inner_ruins_turret", maps\_cic_turret::cic_turret_start_scripted);
  flag_wait("plant_turret");
  level thread run_scene("plant_turret");
  flag_wait("plant_turret_started");
  turret = getent("inner_ruins_turret", "targetname");
  a_ai = get_ais_from_scene("plant_turret");
  array_wait(a_ai, "death");
  end_scene("plant_turret");
  trace_start = turret.origin + vectorscale((0, 0, 1), 100.0);
  trace_end = turret.origin + vectorscale((0, 0, -1), 100.0);
  turret_trace = bullettrace(trace_start, trace_end, 0, turret);
  anchor = spawn("script_origin", turret.origin);
  anchor.angles = turret.angles;
  turret linkto(anchor);
  anchor moveto(turret_trace["position"], 0.3);
  anchor rotateto((0, turret.angles[1], 0), 0.2);
  anchor waittill("movedone");
  anchor delete();
  turret notify("death");
}

outer_ruins_turret_activate(v_turret) {
  level notify("turret_plant");
  v_turret maps\_cic_turret::cic_turret_start_ai();
}

inner_ruins_main() {
  set_rain_level(3);
  delay_thread(1.0, ::trigger_use, "post_heli_colors");
  add_flag_function("player_reached_temple_entrance", ::inner_ruins_kill_spawners);
  array_func(get_heroes(), ::monsoon_hero_rampage, 1);
  level thread inner_ruins_destruction_right();
  level thread inner_ruins_destruction_left();
  use_trigger_on_group_clear("harper_move_inner_ruins_1", "harper_move_inner_ruins_1");
  use_trigger_on_group_count("harper_move_inner_ruins_2", "harper_move_inner_ruins_2", 1);
  use_trigger_on_group_count("salazar_move_inner_ruins_1", "salazar_move_inner_ruins_1", 2);
  use_trigger_on_group_count("salazar_move_inner_ruins_2", "salazar_move_inner_ruins_2", 1);
  use_trigger_on_group_clear("salazar_move_inner_ruins_3", "salazar_move_inner_ruins_3");
  use_trigger_on_group_clear("move_inner_ruins_final", "move_inner_ruins_final");
  flag_wait("squad_reached_temple_entrance");
  level thread inner_ruins_destroy_message();
  array_thread(getaiarray("axis"), ::die);
  setmusicstate("MONSOON_BATTLE_1_END");
  autosave_by_name("at_temple_door");
  t_door_damage = getent("temple_doors_trigger", "targetname");
  t_door_damage thread inner_ruins_door_think();
  level.crosby thread inner_ruins_crosby();
  level.salazar thread inner_ruins_salazar();
  level.harper thread inner_ruins_harper();
  array_wait(get_heroes(), "in_position");
  flag_wait("player_reached_temple_entrance");

  if(!flag("ruins_door_destroyed"))
    level thread inner_ruins_destroy_choice();

  flag_wait("ruins_door_destroyed");
  array_func(get_heroes(), ::monsoon_hero_rampage, 0);
}

inner_ruins_kill_spawners() {
  a_triggers = getentarray("inner_ruins_spawn_trigger", "targetname");
  array_delete(a_triggers);
  a_t_color = getentarray("inner_ruins_color_trigger", "script_noteworthy");

  foreach(color in a_t_color)
  color delete();
}

inner_ruins_destroy_choice() {
  level endon("ruins_door_destroyed");

  if(level.player player_has_explosive_weapon_equipped()) {
    level.player thread queue_dialog("sect_everyone_clear_0");
    wait 10;
    level notify("harper_shooting");
  }

  level thread inner_ruins_harper_shoot_door();
}

inner_ruins_destroy_message() {
  if(!level.player player_has_explosive_weapon_equipped()) {
    set_objective(level.obj_destroy_door, getent("temple_doors", "targetname"), "breadcrumb");

    while(!flag("ruins_door_destroyed")) {
      if(level.player player_has_explosive_weapon_equipped()) {
        break;
      }

      wait 0.05;
    }
  }

  if(!flag("ruins_door_destroyed")) {
    set_objective(level.obj_destroy_door, getent("temple_doors", "targetname"), "destroy");
    screen_message_create(&"MONSOON_TEMPLE_TUTORIAL");
    level waittill_either("ruins_door_destroyed", "harper_shooting");
    screen_message_delete();
  }

  flag_wait("ruins_door_destroyed");
  set_objective(level.obj_destroy_door, undefined, "delete");
}

inner_ruins_harper_shoot_door() {
  level endon("ruins_door_destroyed");
  run_scene("harper_door_shoots");
  level thread run_scene("harper_door_loop");
}

inner_ruins_harper_titus(ai_harper) {
  if(!flag("ruins_door_destroyed")) {
    m_doors_trigger = getent("temple_doors_trigger", "targetname");
    m_doors = getent("temple_doors", "targetname");
    ai_harper maps\_titus::magic_bullet_titus(m_doors.origin);
    flag_wait("ruins_door_destroyed");

    if(isDefined(m_doors_trigger))
      m_doors_trigger dodamage(50, m_doors_trigger.origin, ai_harper, undefined, "explosive");
  }
}

inner_ruins_player_vo(ai_harper) {
  level.player say_dialog("sect_kraken_this_is_sec_0");
}

inner_ruins_door_think() {
  b_destroy = 0;

  while(isDefined(b_destroy) && !b_destroy) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, weaponname);

    if(isDefined(type) && damage >= 50) {
      if(type == "MOD_EXPLOSIVE" || type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_PROJECTILE")
        b_destroy = 1;
    }
  }

  setcellvisibleatpos(getent("obj_ruins_interior", "targetname").origin);
  flag_set("ruins_door_destroyed");
  level.friendlyfiredisabled = 1;
  level notify("_rain_lightning");
  trigger_use("trigger_color_ruins_interior");
  exploder(1000);
  level notify("fxanim_temple_door_start");
  earthquake(0.8, 0.5, level.player.origin, 500);
  level.player playrumbleonentity("artillery_rumble");
  m_door_clip = getent("temple_doors", "targetname");
  m_door_pristine = getent("temple_door_left", "targetname");
  m_door_destroyed = getent("temple_doors_destroyed", "targetname");
  m_door_clip notsolid();
  m_door_clip connectpaths();
  m_door_clip delete();
  m_door_destroyed show();
  m_door_pristine delete();
  self delete();
  wait 3;
  flag_set("ruins_door_destroyed_safe");
  level.friendlyfiredisabled = 0;
}

inner_ruins_salazar() {
  self disable_ai_color();
  self change_movemode("cqb");
  self setgoalnode(getnode("salazar_start_temple_door", "targetname"));
  self waittill("goal");
  self notify("in_position");
  wait 0.5;

  if(!flag("ruins_door_destroyed")) {
    flag_wait("ruins_door_destroyed");
    self enable_ai_color();
    run_scene("salazar_enter_door");
  } else {
    flag_wait("ruins_door_destroyed_safe");
    self enable_ai_color();
  }
}

inner_ruins_crosby() {
  self disable_ai_color();
  self change_movemode("cqb");
  self setgoalnode(getnode("crosby_start_temple_door", "targetname"));
  self waittill("goal");
  self notify("in_position");
  wait 0.5;

  if(!flag("ruins_door_destroyed")) {
    flag_wait("ruins_door_destroyed");
    self enable_ai_color();
    run_scene("crosby_enter_door");
  } else {
    flag_wait("ruins_door_destroyed_safe");
    self enable_ai_color();
  }
}

inner_ruins_harper() {
  self disable_ai_color();
  self change_movemode("cqb");
  self setgoalnode(getnode("harper_start_temple_door", "targetname"));
  self waittill("goal");
  wait 0.5;
  run_scene("harper_door_intro");
  self notify("in_position");

  if(!flag("ruins_door_destroyed")) {
    level thread run_scene("harper_door_loop");
    flag_wait("ruins_door_destroyed");

    if(!flag("harper_door_shoots_started")) {
      end_scene("harper_door_loop");
      run_scene("player_door_shoots");
    }

    self enable_ai_color();
  } else {
    self setgoalpos(self.origin);
    flag_wait("ruins_door_destroyed_safe");
    self enable_ai_color();
    end_scene("harper_door_loop");
  }
}

inner_ruins_destruction_right() {
  t_event = getent("trigger_ruins_right_destroyed", "targetname");
  t_event waittill("trigger");
  t_event delete();
  level notify("fxanim_tree_fall_rt_start");
}

inner_ruins_destruction_left() {
  t_event = getent("trigger_ruins_left_destroyed", "targetname");
  a_c4_pos = getstructarray(t_event.target, "targetname");
  a_c4 = [];

  for(i = 0; i < a_c4_pos.size; i++) {
    a_c4[i] = plant_c4_spawn(a_c4_pos[i]);
    a_c4[i] thread inner_ruins_destroy_c4_watch(t_event);
  }

  t_event waittill("trigger");
  t_event delete();
  exploder(750);
  level notify("fxanim_shrine_lft_mudslide_start");
  a_c4 = remove_undefined_from_array(a_c4);

  foreach(c4 in a_c4) {
    if(isDefined(c4)) {
      c4 dodamage(10, c4.origin);
      wait(randomfloatrange(0.1, 0.2));
    }
  }

  earthquake(0.8, 0.5, level.player.origin, 500);
  level.player playrumbleonentity("artillery_rumble");
  ai_in_ruin = get_ai("ruin_collapse_left", "script_noteworthy");

  if(isDefined(ai_in_ruin) && isalive(ai_in_ruin)) {
    add_generic_ai_to_scene(ai_in_ruin, "ruin_collapse_death_left");
    run_scene("ruin_collapse_death_left");
  }

  wait 3;
  pos = getstruct("ruin_corpse_delete", "targetname");
  a_corpses = getcorpsearray();

  foreach(corpse in a_corpses) {
    if(distance2d(pos.origin, corpse.origin) < 200)
      corpse delete();
  }
}

inner_ruins_destroy_left_temple(m_terrain) {
  level notify("fxanim_shrine_lft_start");
  earthquake(0.4, 3, level.player.origin, 500);
  level.player playrumblelooponentity("damage_light");
  wait 3;
  level.player stoprumble("damage_light");
}

inner_ruins_destroy_c4_watch(t_destroy) {
  t_destroy endon("death");
  self waittill("damage");
  wait(randomfloatrange(0.1, 0.2));
  t_destroy useby(level.player);
}

ruins_interior_main() {
  array_thread(get_heroes(), ::change_movemode, "cqb");
  level thread ruins_interior_seal();
  level thread ruins_interior_vo();
  flag_wait("player_in_ruins_interior");
  trigger_use("trig_salazar_lab_entrance");
  flag_wait("monsoon_gump_interior");
  autosave_by_name("sealed_in_temple");
}

ruins_interior_vo() {
  level endon("player_at_clean_room");
  m_destroyed_door = getent("temple_doors_destroyed", "targetname");

  while(level.player.origin[0] < m_destroyed_door.origin[0])
    wait 0.05;

  level thread maps\createart\monsoon_art::interior_ruins_vision();
  wait 2;
  level.player say_dialog("sect_watch_your_step_fl_1");
  flag_wait("seal_ruins");
  wait 0.05;
  array_notify(get_heroes(), "stop_hero_rain");
  m_collapse_clip = getent("look_at", "script_noteworthy");
  level.player waittill_player_looking_at(m_collapse_clip.origin);
  wait 0.5;
  level.harper say_dialog("harp_no_turning_back_now_1");
}

ruins_interior_seal() {
  flag_wait("seal_ruins");
  setmusicstate("MONSOON_IN_RUINS");
  s_safety = getstruct("seal_ruins_safety", "targetname");

  while(level.player.origin[0] < s_safety.origin[0] || level.player.origin[1] < s_safety.origin[1])
    wait 0.05;

  a_heroes = get_heroes();

  foreach(hero in a_heroes) {
    s_pos = getstruct("safety_temple_" + hero.script_animname, "targetname");

    if(hero.origin[0] < s_pos.origin[0]) {
      hero anim_stopanimscripted();
      hero forceteleport(s_pos.origin, s_pos.angles);
    }
  }

  set_rain_level(0);
  setsaveddvar("wind_global_vector", "-180 -180 40");
  a_turrets = getentarray("outer_ruins_turret", "targetname");
  a_turrets = add_to_array(a_turrets, getent("inner_ruins_turret", "targetname"), 0);
  array_delete(a_turrets);
  veh_heli_turret = getent("heli_turret", "targetname");

  if(isDefined(veh_heli_turret)) {
    veh_heli_turret.delete_on_death = 1;
    veh_heli_turret notify("death");

    if(!isalive(veh_heli_turret))
      veh_heli_turret delete();
  }

  veh_heli_killed = getent("heli_killed_fake", "targetname");

  if(isDefined(veh_heli_killed)) {
    veh_heli_killed.delete_on_death = 1;
    veh_heli_killed notify("death");

    if(!isalive(veh_heli_killed))
      veh_heli_killed delete();
  }

  level notify("remove_c4");
  a_c4 = getentarray("planted_c4", "targetname");
  array_delete(a_c4);
  m_collapse = getent("ruins_blocker", "targetname");
  m_collapse solid();
  m_collapse disconnectpaths();
  m_collapse show();
  earthquake(0.4, 2, level.player.origin, 500);
  level.player playrumblelooponentity("damage_light");
  playsoundatposition("evt_ruin_collapse", (6545, 53569, -493));
  level.player playsound("evt_ruin_shake");
  level clientnotify("snoff");
  wait 2;
  level.player stoprumble("damage_light");
  trigger_use("lift_use_trigger");
  level thread load_gump("monsoon_gump_interior");
}