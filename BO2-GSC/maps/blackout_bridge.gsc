/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_bridge.gsc
**************************************/

#include common_scripts\utility;
#include maps\_drones;
#include maps\_dialog;
#include maps\_utility;
#include maps\_objectives;
#include maps\_scene;
#include maps\_cic_turret;
#include maps\_vehicle;
#include maps\createart\blackout_art;
#include maps\blackout_util;
#include maps\blackout_anim;
#include maps\blackout_security;
#include maps\_rusher;
#include maps\_turret;
#include maps\_fxanim;
#include maps\_spawn_manager;
#include maps\_jetpack_ai;

skipto_mason_salazar_exit() {
  maps\blackout_anim::scene_wakeup();
  maps\blackout_anim::scene_hallway_devestation();
  skipto_teleport_players("player_skipto_mason_salazar_exit");
  run_scene_first_frame("stairfall", 1);
  level.salazar = init_hero_startstruct("salazar", "skipto_salazar_exit_salazar");
  run_scene_first_frame("salazar_exit", 1);
}

skipto_mason_bridge() {
  maps\blackout_anim::scene_bridge_entry();
  skipto_teleport_players("player_skipto_mason_bridge");
}

skipto_mason_catwalk() {
  maps\blackout_anim::scene_bridge();
  skipto_teleport_players("player_skipto_mason_catwalk");
  level thread spawn_deck_spec_ops_battle();
  level thread open_catwalk_door(1);
}

run_mason_salazar_exit() {
  maps\blackout_anim::scene_bridge_entry();
  level thread mason_salazar_exit_ambience();
  scene_salazar_exit();
  level thread dialog_deck_reveal();
  run_scene_first_frame("familiar_face", 1);
  level thread breadcrumb_and_flag("bridge_breadcrumb", level.obj_restore_control, "at_bridge_entry");
  trigger_wait("bridge_breadcrumb");
  flag_set("tanker_hit_start");
  trigger_wait_facing("bridge_entry_trigger", 60);
  flag_set("entered_bridge");
  clean_up_mason_salazar_exit();
}

clean_up_mason_salazar_exit() {
  a_stuff_to_delete = array("stairfall_door", "stairfall_door_clip", "masons_door", "masons_door_clip", "mason_personal_effects", "interrogation_hallway_door", "salazar_exit_door");
  level thread clean_up_ent_array(a_stuff_to_delete);
}

dialog_deck_reveal() {
  flag_wait("deck_reveal_start");
  flag_wait("salazar_exit_dialog_done");

  if(level.is_harper_alive) {
    level.player queue_dialog("harp_we_got_another_wave_0");
    level.player queue_dialog("sect_stay_on_it_i_m_hea_0");
  } else {
    level.player queue_dialog("brig_we_have_another_wave_0");
    level.player queue_dialog("sect_i_m_headed_to_the_br_0");
  }

  level thread deck_reveal_combat_vo_start();
}

deck_reveal_combat_vo_start() {
  level endon("familiar_face_started");
  a_generic_enemy = [];
  a_generic_enemy[a_generic_enemy.size] = "cub1_hold_the_hallway_0";
  a_generic_enemy[a_generic_enemy.size] = "cub2_don_t_let_them_throu_0";
  level thread start_combat_vo_group_enemy(a_generic_enemy, "familiar_face_done");
  a_generic_friendly = [];
  a_generic_friendly[a_generic_friendly.size] = "nav0_return_fire_0";
  level thread start_combat_vo_group_friendly(a_generic_friendly, "familiar_face_done");
  waittill_ai_group_ai_count("pre_bridge_ai", 0);
  queue_dialog_ally("nav1_hallway_s_clear_0", 0, undefined, "familiar_face_done");
}

run_mason_bridge() {
  init_doors();
  maps\blackout_anim::scene_bridge();
  trigger_off("cic_custom_entrances_trigger", "script_noteworthy");
  set_light_flicker_fx_area(70200);
  level thread play_idle_bink_on_bridge_console();
  m_console_bink = get_ent("bridge_console_bink", "targetname", 1);
  m_console_bink hide();
  trigger_off("harrier_flyover_trigger");
  level thread mason_bridge_ambience();
  level thread add_posed_corpses("bridge_corpses", "spec_ops_passed");
  hackable_turret_enable("bridge_turret");
  level thread bridge_break_windows();
  level thread bridge_turret_reveal();
  scene_familiar_face();
  level thread alt_bridge_breadcrumb();
  level thread breadcrumb_and_flag("bridge_front_trigger", level.obj_restore_control, "at_bridge", 0);
  level thread scene_cic_hackers();
  level thread scene_front_bridge_hackers();
  level thread scene_cic_custom_entrances();
  bridge_turret = getent("bridge_turret", "targetname");
  bridge_turret thread bridge_turret_spawns();
  bridge_turret thread bridge_turret_death();
  flag_wait("start_bridge_friendlies");
  delay_thread(20, ::flag_set, "play_bridge_arrivals");
  spawn_manager_enable("sm_bridge");
  flag_wait("at_bridge");
  hack_trigger = getent("bridge_hack_trigger", "targetname");
  hack_trigger setcursorhint("HINT_NOICON");
  hack_trigger sethintstring(&"BLACKOUT_ACCESS_TERMINAL");
  set_objective(level.obj_restore_control, hack_trigger, "use", undefined, 0);
  hack_trigger waittill("trigger");
  hack_trigger delete();
  level thread dialog_server_offline();
  level thread run_scene_and_delete("bridge_hacker");
  level thread kill_all_living_enemies();
  level thread open_catwalk_door(1);
  flag_set("bridge_combat_done");
  level thread maps\_drones::drones_delete("pmc_deck_drones_port_01");
  level thread maps\_drones::drones_delete("navy_deck_drones_port_01");
  bridge_turret = getent("bridge_turret", "targetname");

  if(isDefined(bridge_turret)) {
    bridge_turret.delete_on_death = 1;
    bridge_turret notify("death");

    if(!isalive(bridge_turret))
      bridge_turret delete();
  }

  flag_set("holo_table_off");
  scene_wait("bridge_hacker");
  spawn_manager_kill("sm_bridge");
  checkpoint_respawn_safe_spot_clear();
  autosave_by_name("bridge_complete");
  level thread breadcrumb_and_flag("catwalk_breadcrumb", level.obj_restore_control, "at_catwalk", 0);
  level thread spawn_deck_spec_ops_battle();
  trigger_use("after_hack_advance_trigger", "targetname");
  trigger_on("harrier_flyover_trigger");
  flag_wait("at_catwalk");
  clean_up_mason_bridge();
}

clean_up_mason_bridge() {
  level thread kill_spawnernum(2);
  delete_emergency_light("intro_hallway_light");
}

play_idle_bink_on_bridge_console() {
  flag_wait("reached_bridge_windows");
  m_console_dark = get_ent("bridge_console_dark", "targetname", 1);
  m_console_bink = get_ent("bridge_console_bink", "targetname", 1);
  m_console_dark hide();
  m_console_bink show();
  m_console_bink.n_bink_id = play_movie_on_surface_async("blackout_virus", 1, 0);
}

play_lockout_bink(m_player_body) {
  m_console_dark = get_ent("bridge_console_dark", "targetname", 1);
  m_console_bink = get_ent("bridge_console_bink", "targetname", 1);
  m_console_dark hide();
  m_console_bink show();

  if(isDefined(m_console_bink.n_bink_id))
    stop3dcinematic(m_console_bink.n_bink_id);

  play_movie_on_surface("blackout_lockout", 0, 0);
  m_console_dark show();
  m_console_bink delete();
}

run_mason_catwalk() {
  maps\blackout_anim::scene_security_level();
  level thread sniper_plane_takeoff();
  level thread breadcrumb_and_flag("security_breadcrumb", level.obj_restore_control, "at_defend_objective", 0);
  trigger_wait("catwalk_enter_trigger");
  flag_set("entered_catwalk");
  level thread scene_catwalk();
  level thread catwalk_random_shooting();
  level thread catwalk_kill_friendlies();
  level thread maps\blackout_security::lower_level_entry_battle();
  trigger_wait("catwalk_exit_trigger");
  clean_up_mason_catwalk();
}

clean_up_mason_catwalk() {
}

scene_salazar_exit() {
  level.salazar change_movemode("cqb_sprint");
  level.salazar set_goalradius(16);
  level.salazar set_goal_node(getnode("salazar_exit_reach_setup", "targetname"));
  level.salazar waittill("goal");
  level.salazar change_movemode("cqb_walk");
  flag_wait("salazar_exit_ready");
  level thread dialog_deck_exit();
  level thread run_scene_and_delete("salazar_exit", 0.3);
  flag_wait("salazar_exit_started");
  level waittill("salazar_exit_update_objective");
  level thread moment_stairfall();
}

dialog_deck_exit() {
  flag_wait("salazar_exit_dialog_done");
  level.player queue_dialog("sect_we_gotta_fight_our_w_0", 2, undefined, undefined, 1, 1);
  level.player queue_dialog("sect_on_me_0", 0, undefined, undefined, 1, 1);
}

moment_stairfall() {
  m_door = get_model_or_models_from_scene("stairfall", "stairfall_door");
  m_clip = getent("stairfall_door_clip", "targetname");
  m_clip linkto(m_door, "tag_animate");
  t_stairfall = trigger_wait("stairfall_trigger");
  t_stairfall delete();
  m_door playsound("evt_deck_door_open");
  level thread run_scene_and_delete("stairfall");
  scene_wait("stairfall");
  m_clip connectpaths();
  m_clip disconnectpaths();
  trigger = getent("reveal_color_trigger", "targetname");

  if(isDefined(trigger))
    trigger trigger_use();
}

moment_stairfall_die(ai_navy) {
  ai_enemy = simple_spawn_single("stairfall_enemy");
  ai_navy magic_bullet_shield();
  ai_enemy thread shoot_at_target(ai_navy, "J_Head");
  ai_navy bloody_death("head");
  ai_navy stop_magic_bullet_shield();
}

dialog_radio_turrets() {
  wait 2;
  ai_ronnie = get_ai("ronnie", "script_noteworthy");
  ai_ronnie thread disable_melee_until_flag("bridge_hallway_turret_dead");
  ai_ronnie thread magic_bullet_shield_for_time(10);
  ai_ronnie say_dialog("nav2_turret_s_spinning_up_0");
  ai_ronnie say_dialog("nav3_move_come_on_0");
  flag_wait_either("turret_reveal_start", "turret_bridge_intro_first_done");
  level.player queue_dialog("sect_dammit_4");
  level.player queue_dialog("sect_admiral_briggs_the_0");

  if(level.player hasperk("specialty_trespasser")) {
    level.player queue_dialog("brig_the_techs_identified_0");
    level.player queue_dialog("brig_use_them_to_isolate_0");
    level.player queue_dialog("sect_got_it_1", 1);
  } else {
    level.player queue_dialog("sect_we_need_a_solution_0");
    level.player queue_dialog("brig_tech_team_s_working_0");
  }

  level thread dialog_bridge_combat();
  flag_wait("bridge_turret_disabled");
  queue_dialog_ally("nav0_turret_s_down_move_0", 0);
  waittill_ai_group_cleared("bridge_computer_room_guys");
  flag_set("bridge_combat_done");
  queue_dialog_ally("nav1_okay_we_re_clear_0", 0);
  level.player thread queue_dialog("sect_secure_the_bridge_0", 3, undefined, "bridge_hacker_started");
}

dialog_bridge_combat() {
  a_generic_friendly = [];
  a_generic_friendly[a_generic_friendly.size] = "nav0_on_your_six_0";
  a_generic_friendly[a_generic_friendly.size] = "nav1_get_out_of_there_0";
  a_generic_friendly[a_generic_friendly.size] = "nav0_right_behind_you_0";
  a_generic_friendly[a_generic_friendly.size] = "nav1_engaging_0";
  a_generic_friendly[a_generic_friendly.size] = "nav0_moving_up_0";
  a_generic_friendly[a_generic_friendly.size] = "nav1_more_mercs_0";
  a_conditional_friendly = [];
  a_conditional_friendly[a_conditional_friendly.size] = "nav0_another_turret_mid_0";
  level thread start_combat_vo_group_friendly(a_generic_friendly, "bridge_combat_done", a_conditional_friendly, "bridge_turret_disabled");
  a_generic_enemy = [];
  a_generic_enemy[a_generic_enemy.size] = "cub1_they_re_pushing_forw_0";
  a_generic_enemy[a_generic_enemy.size] = "cub1_hold_them_back_0";
  a_conditional_enemy = [];
  a_conditional_enemy[a_conditional_enemy.size] = "cub2_stay_behind_the_auto_0";
  level thread start_combat_vo_group_enemy(a_generic_enemy, "bridge_combat_done", a_conditional_enemy, "bridge_turret_disabled");
}

dialog_server_offline() {
  kill_all_pending_dialog(level.player);
  wait 2.5;
  level.player say_dialog("sect_come_on_come_on_2");
  wait 1.0;
  level.player say_dialog("sect_admiral_briggs_bri_0");
  level.player say_dialog("brig_we_re_trying_to_gain_0");
  level.player say_dialog("sect_menendez_always_on_0");
  level.player say_dialog("brig_head_to_the_security_0");
  level.player say_dialog("sect_i_m_on_my_way_0");
}

sniper_plane_takeoff() {
  plane = spawn_vehicle_from_targetname("sniping_plane");
  path = getvehiclenode(plane.target, "targetname");
  plane thread fa38_init_fx(0);
  plane.m_landing_gear = spawn_model("veh_t6_air_fa38_landing_gear", plane gettagorigin("tag_landing_gear_down"), plane gettagangles("tag_landing_gear_down"));
  plane.m_landing_gear linkto(plane, "tag_landing_gear_down");
  plane endon("death");
  plane veh_magic_bullet_shield(1);
  trigger_wait("catwalk_enter_trigger");
  wait 4.0;
  plane go_path(path);
  level.player waittill_player_not_looking_at(plane.origin, 0.5, 0);
  plane.m_landing_gear delete();
  plane delete();
}

bridge_break_windows() {
  a_s_bullets = getstructarray("bridge_magic_bullet", "targetname");

  foreach(s_bullet in a_s_bullets) {
    s_bullet_end = getstruct(s_bullet.target, "targetname");
    magicbullet("xm8_sp", s_bullet.origin, s_bullet_end.origin);
    wait 0.05;
    magicbullet("xm8_sp", s_bullet.origin, s_bullet_end.origin);
    wait 0.05;
    magicbullet("xm8_sp", s_bullet.origin, s_bullet_end.origin);
  }
}

catwalk_kill_friendlies() {
  trigger_wait("catwalk_exit_trigger");
  targets = get_catwalk_ally_victims(1);
  array_func(targets, ::bloody_death);
}

kill_remaining_enemies() {
  enemies = get_ai_group_ai("deck_reveal_enemies");

  foreach(enemy in enemies) {
    if(!isalive(enemy)) {
      continue;
    }
    ally = get_closest_ai(enemy.origin, "allies");

    if(isDefined(ally)) {
      ally.perfectaim = 1;
      ally shoot_at_target(enemy, "J_head", 0.0, 1.0);
    }

    if(isalive(enemy))
      enemy bloody_death();
  }
}

catwalk_random_rockets() {
  self endon("spec_ops_completed");
  self endon("spec_ops_failed");
  self endon("random_rockets_stop");
  done_trigger = getent("catwalk_exit_trigger", "targetname");
  done_trigger endon("trigger");
  structs = getstructarray("catwalk_magic_bullet_target", "targetname");
  assert(structs.size > 0);
  sources = getstructarray("catwalk_magic_bullet_source", "targetname");

  for(wait_time = 5.0; 1; wait_time = wait_time + randomfloatrange(5.0, 10.0)) {
    wait(wait_time);
    closest_5 = get_array_of_closest(level.player.origin, structs, undefined, 5);
    s_furthest = get_furthest(level.player.origin, closest_5);
    s_start = get_furthest_offscreen(sources);
    e_rpg = magicbullet("usrpg_magic_bullet_nodrop_sp", s_start.origin, s_furthest.origin);
    e_rpg waittill("death");
  }
}

get_catwalk_ally_victims(force_all) {
  color_friendlies = get_all_force_color_friendlies();
  other_friendlies = [];

  if(is_true(force_all) || flag("spec_ops_line_delivered"))
    other_friendlies = get_ai_group_ai("catwalk_snipers");

  all_friendlies = arraycombine(color_friendlies, other_friendlies, 1, 0);
  return all_friendlies;
}

catwalk_random_shooting() {
  self endon("spec_ops_completed");
  self endon("spec_ops_failed");
  done_trigger = getent("catwalk_exit_trigger", "targetname");
  done_trigger endon("trigger");
  structs = getstructarray("catwalk_magic_bullet_target", "targetname");
  assert(structs.size > 0);
  sources = getstructarray("catwalk_magic_bullet_source", "targetname");

  while(true) {
    nearest = get_array_of_closest(level.player.origin, structs, undefined, 2);
    assert(nearest.size >= 2);
    enemies = get_ai_group_ai("deck_reveal_enemies");
    num_enemies = enemies.size;
    f_scale = num_enemies / 10.0;

    if(f_scale > 1.0)
      f_scale = 1.0;

    wait_min = lerpfloat(0.05, 0.3, 1.0 - f_scale);
    wait_max = wait_min * 1.25;

    for(i = 0; i < 10; i++) {
      ai_target = undefined;
      hit_pos = undefined;

      if(rand_chance(0.1)) {
        friendlies = get_catwalk_ally_victims();

        if(friendlies.size > 0)
          ai_target = random(friendlies);
      }

      if(isalive(ai_target))
        hit_pos = ai_target gettagorigin("J_head");
      else {
        rand_pct = randomfloat(1.0);
        hit_pos = lerpvector(nearest[0].origin, nearest[1].origin, rand_pct);
        hit_pos = hit_pos + (0, 0, randomfloatrange(-12, 12));
      }

      s_source = get_furthest_offscreen(sources);
      magicbullet("hk416_sp", s_source.origin, hit_pos);

      if(i % 2 == 0)
        wait(randomfloatrange(wait_min, wait_max));
    }
  }
}

bridge_turret_spawns() {
  self endon("death");
  self waittill("turret_hacked");
  delay_thread(8, ::trigger_on, "cic_custom_entrances_trigger", "script_noteworthy");
  e_target = getstruct("bridge_turret_goal", "targetname");
  self setturrettargetvec(e_target.origin);
  self waittill("turret_entered");
  self clearturrettarget();
  a_spawn_triggers = getentarray("bridge_turret_trigger", "script_noteworthy");

  foreach(trigger in a_spawn_triggers) {
    trigger useby(level.player);
    wait 0.5;
  }
}

bridge_turret_death() {
  self waittill_any("death", "turret_hacked");
  flag_set("bridge_turret_disabled");
  level thread bridge_send_rushers();
}

bridge_send_rushers() {
  while(!flag("at_bridge")) {
    a_rushers = get_ai_array("bridge_aggressive", "script_noteworthy");

    if(a_rushers.size > 0) {
      foreach(enemy in a_rushers) {
        enemy.canflank = 1;
        enemy.aggressivemode = 1;
      }

      ai_rusher = a_rushers[randomint(a_rushers.size)];
      ai_rusher maps\_rusher::rush();
      ai_rusher waittill("death");
    }

    wait(randomfloatrange(2, 4));
  }
}

catwalk_spawn_snipers() {
  sp_snipers = getentarray("catwalk_sniper_spawn", "targetname");
  level.catwalk_snipers = simple_spawn(sp_snipers, ::magic_bullet_shield);
  simple_spawn("catwalk_rocket_fodder");
  trigger_wait("double_stairs_mid");
  a_guys = get_ent_array("catwalk_sniper_spawn_ai", "targetname");

  foreach(guy in a_guys) {
    guy stop_magic_bullet_shield();
    guy die();
  }
}

bridge_chair_pulses() {
  a_pulses = getstructarray("cic_chair_pulse", "targetname");

  while(true) {
    foreach(pulse in a_pulses) {
      physicsjolt(pulse.origin, 100, 50, (1, 1, 1));
      wait 1;
    }
  }
}

bridge_turret_reveal() {
  add_spawn_function_veh("reveal_turret", ::reveal_turret_think);
  veh_turret = spawn_vehicle_from_targetname("reveal_turret");
  delay_thread(3, ::run_scene_and_delete, "turret_bridge_intro_first");
  run_scene_first_frame("turret_bridge_intro");
  level thread dialog_radio_turrets();
  run_scene_and_delete("turret_bridge_intro");
  flag_wait("bridge_hallway_turret_dead");
}

reveal_turret_think() {
  flag_wait("turret_bridge_intro_started");
  self thread _turret_reveal_firing();
  self waittill("death");
  flag_set("bridge_hallway_turret_dead");
}

_turret_reveal_firing() {
  self endon("death");
  ai_target = get_ent("turret_intro_guy_1_ai", "targetname");
  wait 2;
  self thread maps\_turret::shoot_turret_at_target(ai_target, 3, (0, 0, 0), 0);
  wait 4;
  ai_target_2 = get_ent("turret_intro_guy_3_ai", "targetname");
  self clear_turret_target(0);
  self thread maps\_turret::shoot_turret_at_target(ai_target_2, 3, (0, 0, 0), 0);
}

bridge_turret_fate(ai_sailor) {
  level thread run_scene_and_delete("turret_bridge_fail");
}

bridge_turret_bloodbath_setup(ai_guy) {
  ai_guy.overrideactordamage = ::override_bridge_bloodbath;
  ai_guy.ignoreme = 0;
  wait 7;
  ai_guy.ignoreme = 1;

  if(isalive(ai_guy)) {
    ai_guy.overrideactordamage = undefined;
    ai_guy.a.nodeath = 1;
    ai_guy ragdoll_death();
  }
}

override_bridge_bloodbath(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(!self.ignoreme)
    playfx(level._effect["cic_turret_bloodbath"], vpoint, vdir);

  return true;
}

bridge_turret_initial_fire() {
  wait 0.05;
  self cic_turret_start_scripted();
  ai_array = get_ais_from_scene("turret_bridge_intro_first");
  self maps\_turret::set_turret_target(ai_array[0], undefined, 0);

  while(isalive(ai_array[0])) {
    self maps\_turret::fire_turret_for_time(1, 0);
    wait 1;
  }

  self maps\_turret::clear_turret_target(0);
  self cic_turret_start_ai();
}

fa38_fire_weapon(fire_time) {
  fire_time_base = 0.1;

  for(total_fire_time = 0.0; total_fire_time < fire_time; total_fire_time = total_fire_time + fire_time_base) {
    self firegunnerweapon(0);
    wait(fire_time_base * 0.5);
    self firegunnerweapon(1);
    wait(fire_time_base * 0.5);
  }
}

hacker_wait_trigger_or_damage(str_trigger_name) {
  if(isDefined(str_trigger_name)) {
    trig = getent(str_trigger_name, "targetname");
    trig endon("trigger");
  }

  self endon("damage");
  self endon("death");
  vh_turret = get_ent("bridge_turret", "targetname");
  level.player waittill_player_looking_at(self.origin + vectorscale((0, 0, 1), 72.0), 90, 1, vh_turret);
  wait(randomfloatrange(0.5, 2.0));
}

hacker_wait_and_react(str_react_scene, str_trigger_name) {
  self endon("death");
  self hacker_wait_trigger_or_damage(str_trigger_name);
  run_scene_and_delete(str_react_scene);
}

scene_cic_hackers() {
  level thread run_scene_and_delete("cic_hacker_01_loop");
  level thread run_scene_and_delete("cic_hacker_02_loop");
  wait 1;
  set1 = get_ais_from_scene("cic_hacker_01_loop");
  set2 = get_ais_from_scene("cic_hacker_02_loop");
  set1[0] thread hacker_wait_and_react("cic_hacker_01_react");
  set2[0] thread hacker_wait_and_react("cic_hacker_02_react");
}

scene_front_bridge_hackers() {
  trigger_wait("start_front_bridge");
  a_positions = getstructarray("front_bridge_hack", "targetname");

  foreach(s_align in a_positions) {
    simple_spawn_single("bridge_hacker", ::start_hacking, s_align, s_align.script_noteworthy);
    wait_network_frame();
  }
}

scene_cic_custom_entrances() {
  run_scene_first_frame("cic_custom_entrances");
  flag_wait("play_bridge_arrivals");
  run_scene_and_delete("cic_custom_entrances");
}

scene_cic_bodies() {
  level thread run_scene_and_delete("cic_body_01");
  level thread run_scene_and_delete("cic_body_02");
  level thread run_scene_and_delete("cic_body_03");
  trigger_wait("catwalk_exit_trigger");
  end_scene("cic_body_01");
  end_scene("cic_body_02");
  end_scene("cic_body_03");
}

scene_familiar_face() {
  enemies = get_ai_group_ai("pre_bridge_ai");
  array_func(enemies, ::die);
  maps\createart\blackout_art::vision_set_bridge();
  level clientnotify("stop_Bwalla");
  level notify("start_bridge_fxanims");
  level thread run_scene_and_delete("familiar_face");
  trigger_on("downstairs_light_trig", "script_noteworthy");
  level.player thread scene_familiar_face_rumble();
  level thread maps\_drones::drones_delete("port_deck_reveal_drones");
  level.player startcameratween(0.2);
  run_scene_and_delete("familiar_face_player", 0.2);
  array_delete(get_ai_group_ai("pre_bridge_friendly"));
  maps\_fxanim::fxanim_delete("intro_hallway_pipes");
  level thread autosave_by_name("bridge_start");
}

scene_familiar_face_rumble() {
  wait 0.5;

  for(i = 0; i < 10; i++) {
    self playrumbleonentity("tank_rumble");
    earthquake(0.1, 0.1, self.origin, 1000, self);
    wait 0.1;
  }
}

alt_bridge_breadcrumb() {
  wait_for_either_trigger("bridge_front_trigger", "bridge_front_trigger_alt");
  trigger_use("bridge_front_trigger");
  e_trigger = getent("bridge_front_trigger_alt", "targetname");
  e_trigger delete();
}

open_catwalk_door(do_open) {
  if(!isDefined(do_open))
    do_open = 1;

  catwalk_door = getent("catwalk_door_collision", "targetname");

  if(!isDefined(catwalk_door.is_open))
    catwalk_door.is_open = 0;

  if(catwalk_door.is_open == do_open) {
    return;
  }
  if(!do_open) {
    catwalk_door rotateyaw(-110 * -1, 0.5, 0, 0);
    catwalk_door disconnectpaths();
  } else {
    catwalk_door rotateyaw(-110, 0.5, 0, 0);
    catwalk_door connectpaths();
  }

  catwalk_door.is_open = do_open;
}

init_doors() {
  catwalk_door = getent("catwalk_door", "targetname");
  catwalk_door_collision = getent(catwalk_door.target, "targetname");
  catwalk_door linkto(catwalk_door_collision);
  catwalk_door_collision.is_open = 0;
}

init_flags() {
  flag_init("at_bridge_entry");
  flag_init("at_bridge");
  flag_init("at_catwalk");
  flag_init("spec_ops_started");
  flag_init("spec_ops_line_delivered");
  flag_init("spec_ops_failed");
  flag_init("spec_ops_completed");
  flag_init("zipties_scene_started");
  flag_init("turret_reveal_start");
  flag_init("start_bridge_friendlies");
  flag_init("holo_table_off");
  flag_init("bridge_turret_disabled");
  flag_init("bridge_hallway_turret_dead");
  flag_init("bridge_combat_done");
  flag_init("spec_ops_event_done");
  flag_init("tanker_hit_start");
  flag_init("tanker_hit_done");
  flag_init("start_osprey_crash");
  flag_init("starboard_side_reveal");
  flag_init("entered_bridge");
  flag_init("entered_catwalk");
  flag_init("reached_bridge_windows");
  flag_init("reached_bridge_bow_windows");
  flag_init("saw_left_most_vtol_explode");
  flag_init("entered_lower_decks");
}

scene_catwalk() {
  trigger_wait("catwalk_explosion_trigger");
  maps\createart\blackout_art::vision_set_catwalk();
  level thread scene_ziptied_pmcs();
}

scene_ziptied_pmcs() {
  add_posed_corpses("lower_deck_corpses", "at_defend_objective");
  level thread ziptie_intro_then_loop("ziptied_sailor_01");
  level thread ziptie_intro_then_loop("ziptied_sailor_02");
  level thread ziptie_intro_then_loop("ziptied_pmc_01");
  level thread run_scene("ziptied_pmc_02_loop");
  level thread run_scene("ziptied_pmc_03_loop");
  level thread ziptie_guard_ai();
  flag_set("zipties_scene_started");
  level thread dialog_ziptie_room();
  trigger_wait("double_stairs_mid");
  level notify("kill_ziptie_scene_threads");
  end_scene("ziptied_pmc_02_loop");
  end_scene("ziptied_pmc_03_loop");
  delete_scene_all("ziptied_pmc_02_loop", 1, 1, 1);
  delete_scene_all("ziptied_pmc_03_loop", 1, 1, 1);
  delete_scene_all("ziptied_pmc_01_loop", 1, 1, 1);
  flag_wait("at_defend_objective");
  level notify("delete_security_wounded");
}

ziptie_guard_ai() {
  nd_guard = getnode("ziptie_guard", "targetname");

  if(isDefined(nd_guard)) {
    ai_guard = simple_spawn_single("navy_assault_guy", ::func_ziptie_guard);
    ai_guard forceteleport(nd_guard.origin, nd_guard.angles);
    ai_guard set_goal_node(nd_guard);
  }
}

func_ziptie_guard() {
  self endon("death");
  self set_ignoreall(1);
  self set_ignoreme(1);
  level waittill("kill_ziptie_scene_threads");
  self set_ignoreall(0);
  self set_ignoreme(0);
  self set_force_color("o");
}

dialog_ziptie_room() {
  level endon("window_throw_started");
  queue_dialog_ally("nav2_stay_down_or_i_swea_0", 1);
  queue_dialog_ally("nav3_eyes_front_0", 5);
  queue_dialog_ally("nav2_section_you_re_cle_0", 8);
}

ziptie_intro_then_loop(str_scene) {
  level endon("kill_ziptie_scene_threads");
  run_scene_and_delete(str_scene + "_intro");
  level thread run_scene(str_scene + "_loop");
  trigger_wait("double_stairs_mid");
  e_model = get_model_or_models_from_scene(str_scene + "_loop", str_scene);

  if(isDefined(e_model))
    e_model delete();

  end_scene(str_scene + "_loop");
}

ziptie_enemy_think(ai_guy) {
}

ziptie_friendly_think(ai_guy) {
  ai_guy attach("t6_wpn_ar_xm8_world", "tag_weapon_right");
}

setup_deck_battle_ally() {
  self.attackeraccuracy = 0.1;
}

spawn_deck_spec_ops_battle() {
  level thread catwalk_spawn_snipers();
  add_spawn_function_ai_group("deck_reveal_allies", ::setup_deck_battle_ally);
  spawn_manager_enable("deck_reveal_allies_sm");
  spawn_manager_enable("deck_reveal_enemies_sm");
  trigger_wait("catwalk_enter_trigger");
  array_func(level.catwalk_snipers, ::stop_magic_bullet_shield);

  while(!flag("spec_ops_passed") && !flag("spec_ops_started")) {
    if(player_has_sniper_weapon()) {
      s_snipe_obj = get_struct("struct_spec_op_obj", "targetname");
      set_objective(level.obj_help_seals, s_snipe_obj.origin, & "BLACKOUT_OBJ_SNIPE");
      flag_set("spec_ops_started");
      level thread spec_ops_killed();
      level thread spec_ops_battle_finish();
      flag_set("spec_ops_line_delivered");
    }

    wait 0.15;
  }

  if(flag("spec_ops_started"))
    level thread dialog_seal_support_objective();

  trigger_wait("security_breadcrumb");

  if(!flag("spec_ops_completed")) {
    if(flag("spec_ops_started") && !flag("spec_ops_failed")) {
      set_objective(level.obj_help_seals, undefined, "failed");
      flag_set("spec_ops_event_done");
      level notify("clear_old_breadcrumb");
      level thread breadcrumb_and_flag("security_breadcrumb", level.obj_restore_control, "at_defend_objective", 0);
    }

    flag_set("spec_ops_failed");
    spawn_manager_kill("deck_reveal_allies_sm");
    spawn_manager_kill("deck_reveal_enemies_sm");
    a_ai = arraycombine(get_ai_group_ai("deck_reveal_enemies"), get_ai_group_ai("deck_reveal_allies"), 1, 0);
    array_thread(a_ai, ::spec_ops_kill_clear_battle);
  } else
    autosave_by_name("seals_saved");
}

dialog_seal_support_objective() {
  a_generic_friendly = [];
  a_generic_friendly[a_generic_friendly.size] = "nav2_the_seals_are_pinned_0";
  a_generic_friendly[a_generic_friendly.size] = "nav3_give_em_covering_fi_0";
  a_generic_friendly[a_generic_friendly.size] = "nav3_pmcs_advancing_0";
  a_generic_friendly[a_generic_friendly.size] = "nav2_don_t_let_the_pmcs_m_0";
  a_generic_friendly[a_generic_friendly.size] = "nav3_maintain_fire_0";
  level thread start_combat_vo_group_friendly(a_generic_friendly, "spec_ops_event_done");
}

waittill_spawn_manager_spawns_x_more(str_spawn_manager, num_extra_spawns) {
  spawn_managers = maps\_spawn_manager::get_spawn_manager_array(str_spawn_manager);
  prev_count = spawn_managers[0].spawncount;

  while(spawn_managers[0].spawncount < prev_count + num_extra_spawns)
    wait 0.25;
}

spec_ops_battle_finish() {
  level thread spec_ops_process_advancement();
  level endon("spec_ops_failed");
  spawn_manager_kill("deck_reveal_allies_sm");
  waittill_spawn_manager_spawns_x_more("deck_reveal_enemies_sm", 6);
  spec_ops_advance();
  waittill_spawn_manager_spawns_x_more("deck_reveal_enemies_sm", 6);
  spawn_manager_kill("deck_reveal_enemies_sm");
  level notify("random_rockets_stop");
  spec_ops_advance();
  waittill_ai_group_ai_count("deck_reveal_enemies", 3);
  flag_set("spec_ops_completed");
  flag_set("spec_ops_event_done");
  level thread delay_notify("seal_overwatch_complete", 3);
  autosave_by_name("seals_saved");
  set_objective(level.obj_help_seals, undefined, "done");
  level thread spec_ops_exit();
  level notify("clear_old_breadcrumb");
  level thread breadcrumb_and_flag("security_breadcrumb", level.obj_restore_control, "at_defend_objective", 0);
}

spec_ops_advance_to_node_set(str_node_set) {
  allies = get_ai_group_ai("deck_reveal_allies");
  nodes = getnodearray(str_node_set, "targetname");

  for(i = 0; i < allies.size && i < nodes.size; i++) {
    allies[i] change_movemode("cqb_sprint");
    allies[i].fixednode = 1;
    allies[i] setgoalnode(nodes[i]);
  }
}

spec_ops_process_advancement() {
  level endon("spec_ops_completed");
  level waittill("spec_ops_advance");
  spec_ops_advance_to_node_set("spec_ops_advance_01");
  level waittill("spec_ops_advance");
  spec_ops_advance_to_node_set("spec_ops_advance_02");
}

spec_ops_advance() {
  level notify("spec_ops_advance");
}

spec_ops_exit() {
  kill_remaining_enemies();
  allies = get_ai_group_ai("deck_reveal_allies");

  foreach(ally in allies) {
    ally.fixednode = 0;
    ally change_movemode("run");
    ally thread spec_ops_ally_exit();
    wait(randomfloatrange(0.5, 1.5));
  }
}

spec_ops_ally_exit() {
  self endon("death");
  self.fixednode = 0;
  wait(randomfloat(15.0));
  self force_goal(getstruct("deck_reveal_end", "targetname").origin, 32, 0);
  level.num_seals_saved++;
  level notify("seal_saved");
  self delete();
}

spec_ops_killed() {
  level endon("spec_ops_completed");
  level endon("spec_ops_failed");
  waittill_ai_group_cleared("deck_reveal_allies");
  set_objective(level.obj_help_seals, undefined, "failed");
  flag_set("spec_ops_failed");
  flag_set("spec_ops_event_done");
}

spec_ops_kill_clear_battle() {
  self endon("death");
  wait(randomfloat(20.0));
  self die();
}

holo_table_flicker_out() {
  m_image = getent("P6_hologram_city_buildings", "targetname");
  m_table = getent("war_holo_table", "targetname");
  time_elapsed = 0.0;
  flicker_on = 1;
  flag_wait("holo_table_off");
  exploder(111);

  while(time_elapsed < 8.0) {
    flick_time = 0.1;

    if(flicker_on) {
      flick_time = randomfloatrange(0.1, 0.2);
      m_image hide();
      m_table setclientflag(13);
    } else {
      flick_time = randomfloatrange(0.1, 1.0);
      m_image show();
      m_table clearclientflag(13);
    }

    flicker_on = !flicker_on;
    wait(flick_time);
    time_elapsed = time_elapsed + flick_time;
  }

  m_image delete();
  wait 2.0;
  stop_exploder(111);
}

mason_salazar_exit_ambience() {
  deck_vtols_show();
  maps\blackout_util::start_cowbell();
  maps\blackout_util::init_persist_ambience(1, "tanker_hit_react_spot");
  maps\blackout_util::init_ambient_oneoff_models("oneoff_ambient_ship_spot");
  maps\blackout_util::init_ambient_oneoff_models("drifting_ambient_ship_spot");
  maps\blackout_util::init_ambient_oneoff_models("oneoff_starboard_ambient_ship_spot");
  level thread bridge_drone_spawning();
  exploder(1111);
  flag_wait("tanker_hit_start");
  maps\blackout_util::init_ambient_oneoff_vehicles("mason_elevator_f38_spline");
  maps\createart\blackout_art::vision_set_exterior_01();
  level thread bridge_catwalk_jetpack_drones("entered_bridge");
  maps\blackout_util::init_ambient_oneoff_vehicles("bridge_bow_window_spline");
  flag_wait("entered_bridge");
  level notify("stop_spawning_jetpack_ai");
  kill_bridge_ambience("tanker_hit_react_spot_model");
  cleanup_deck_allies();
  cleanup_deck();
}

mason_bridge_ambience() {
  flag_wait("reached_bridge_windows");
  drones_start("pmc_deck_drones_port_01");
  drones_start("navy_deck_drones_port_01");
  level thread bridge_catwalk_jetpack_drones("entered_lower_decks");
  level thread init_deck_ambient_oneoffs();
  maps\blackout_util::init_persist_ambience(2, "tanker_second_state_low_spot");
  maps\blackout_util::start_cowbell();
  maps\blackout_util::init_phalanx_cannons("hackable_phalanx_cannon_spot");
  bridge_drone_spawning();
  flag_wait("entered_catwalk");
  flag_wait("spec_ops_passed");
  wait_network_frame();
  maps\blackout_util::kill_phalanx_cannons("hackable_phalanx_cannon_spot");
  flag_wait("entered_lower_decks");
  level notify("stop_spawning_jetpack_ai");
  maps\createart\blackout_art::vision_set_lowerlevel();
  kill_bridge_ambience("tanker_second_state_low_spot_model");
  cleanup_deck();
  wait_network_frame();
  maps\blackout_util::cleanup_structs("salazar_exit_structs", "script_noteworthy");
}

init_deck_ambient_oneoffs() {
  level endon("entered_lower_decks");
  flag_wait("reached_bridge_bow_windows");
  set_light_flicker_fx_area(70300);
  maps\blackout_util::init_ambient_oneoff_vehicles("bridge_bow_window_spline");
}

kill_bridge_ambience(str_tanker_model) {
  maps\blackout_util::stop_cowbell();
  maps\blackout_util::kill_persist_damaged_tanker(str_tanker_model);
}

start_catwalk_allies() {
  a_ai_allies = simple_spawn("catwalk_rocket_fodder");
  a_nd_goals = getnodearray("vista_balcony_node", "script_noteworthy");
  i = 0;

  foreach(ai_ally in a_ai_allies) {
    ai_ally set_goalradius(64);
    ai_ally thread force_goal(a_nd_goals[i]);
    i++;
  }
}

cleanup_deck_allies() {
  a_ai_enemies = getentarray("deck_reveal_enemy_ai", "targetname");
  a_ai_allies = getentarray("deck_reveal_ally_ai", "targetname");
  a_ai_balcony_allies = getentarray("catwalk_rocket_fodder_ai", "targetname");
  maps\blackout_util::kill_guys(a_ai_enemies);
  maps\blackout_util::kill_guys(a_ai_allies);
  maps\blackout_util::kill_guys(a_ai_balcony_allies);
}

cleanup_deck() {
  cleanup_ents("pmc_jetpack_guy_ai", "targetname");
  drones_delete("pmc_deck_drones_bow_01");
}

bridge_catwalk_jetpack_ai(str_flag) {
  a_s_landing_spot = getstructarray("bridge_catwalk_jetpack_spot", "targetname");

  while(!flag(str_flag)) {
    for(i = 0; i < 3; i++) {
      foreach(s_align in a_s_landing_spot) {
        if(flag(str_flag)) {
          break;
        }

        a_ai = getaiarray("axis", "allies");

        if(a_ai.size < 20)
          level thread maps\_jetpack_ai::create_jetpack_ai(s_align, "pmc_jetpack_guy");

        wait(randomfloatrange(2, 3));
      }

      wait(randomfloatrange(4, 5));
    }

    wait 20;
    kill_guys("pmc_jetpack_guy_ai", "targetname");
  }

  a_ai_jetpack_guys = get_ai_array("pmc_jetpack_guy_ai", "targetname");
  array_delete(a_ai_jetpack_guys);
}

bridge_catwalk_jetpack_drones(str_flag, str_targetname) {
  if(!isDefined(str_targetname))
    str_targetname = "port_vista_drone_jetpack_spot";

  a_s_landing_spot = getstructarray(str_targetname, "targetname");

  while(!flag(str_flag)) {
    for(i = 0; i < a_s_landing_spot.size; i++) {
      foreach(s_align in a_s_landing_spot) {
        if(flag(str_flag)) {
          break;
        }

        a_ai = getaiarray("axis", "allies");

        if(a_ai.size < 10)
          level thread maps\_jetpack_ai::create_jetpack_ai(s_align, "pmc_jetpack_guy", 1);

        wait(randomfloatrange(1, 3));
      }

      wait(randomfloatrange(1, 3));
    }
  }
}

bridge_drone_spawning() {
  sp_pmc_spawner = getent("pmc_drone_guy", "targetname");
  drones_assign_spawner("pmc_deck_drones_bow_01", sp_pmc_spawner);
  drones_assign_spawner("pmc_deck_drones_port_01", sp_pmc_spawner);
  drones_assign_spawner("port_deck_reveal_drones", sp_pmc_spawner);
  sp_sailor_spawner = getent("navy_assault_guy", "targetname");
  drones_assign_spawner("navy_deck_drones_port_01", sp_sailor_spawner);
  wait_network_frame();
  drones_start("pmc_deck_drones_bow_01");
}