/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_deck.gsc
**************************************/

#include maps\blackout_util;
#include maps\blackout_anim;
#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_objectives;
#include maps\_dialog;
#include maps\_scene;
#include maps\_music;
#include maps\_jetpack_ai;
#include maps\_rusher;
#include maps\_fxanim;
#include maps\_audio;
#include maps\_turret;
#include maps\createart\blackout_art;
#include maps\_fire_direction;

skipto_mason_deck() {
  mason_part_2_animations();
  level.is_briggs_alive = 1;
  level.harper = init_hero("harper", ::set_force_color, "r");
  level.ai_redshirt1 = init_hero("redshirt1", ::set_force_color, "r");
  level.ai_redshirt2 = init_hero("redshirt2", ::set_force_color, "r");
  m_mason_elevator = getent("mason_elevator", "targetname");
  m_mason_elevator setmovingplatformenabled(1);
  m_mason_elevator movez(576, 0.05);
  level.num_seals_saved = 3;
  maps\blackout_util::init_phalanx_cannons("hackable_phalanx_cannon_spot");
  maps\blackout_util::disable_phalanx_cannons("hackable_phalanx_cannon_spot");
  skipto_teleport("player_skipto_mason_deck", get_heroes());

  if(-1)
    level thread setup_claw_bigdog();

  level thread play_pip("blackout_dradis", 0);
}

skipto_mason_deck_final() {
  mason_part_2_animations();
  skipto_teleport_players("player_skipto_mason_deck_final");
  level thread sky_cowbell();
  level thread ambient_drone_manager();
  level thread run_missile_firing_drones_around_player();
  level thread sea_cowbell();
}

dev_skipto_drones() {
  skipto_teleport_players("player_skipto_mason_deck_final");
}

init_flags() {
  flag_init("start_deck_spawners");
  flag_init("menendez_escaped");
  flag_init("drones_at_deck");
  flag_init("create_falling_debris_cover");
  flag_init("player_boarded_vtol");
  flag_init("player_used_brute_force");
  flag_init("vtol_ready_for_liftoff");
}

run_mason_deck() {
  level.player.overrideplayerdamage = ::player_deck_callback;
  set_light_flicker_fx_area(undefined);
  stop_exploder(125);
  level thread setup_deck_phalanx_cannon_targets(5);
  drone_cover_toggle(0);
  blow_up_remaining_deck_vtols();
  setup_deck_ai();
  level thread deck_event_menendez_takeoff();
  level thread deck_event_f38_crash();
  level.player thread deck_danger_zone();
  flag_wait("start_deck_spawners");
  spawn_manager_enable("sm_protect_takeoff");
  level thread jetpack_respawners();
  trigger_wait("move_allies_off_elevator");
  spawn_manager_enable("sm_drones_attack");
  level thread deck_event_jetpack_ai();
  set_objective(level.obj_find_menen, undefined, "delete");
  set_objective(level.obj_stop_menen, level.v_menendez_f38);
  autosave_by_name("after_elevator");
  level thread brute_force_perk();
  flag_wait("menendez_escaped");
  level thread move_wave_1_towards_vtol();
  level thread start_aggressive_ai("deck_aggressive");
  delay_thread(5, ::set_objective, level.obj_stop_menen, undefined, "done");
  autosave_by_name("menendez_took_off");
  level thread spawn_seals_from_optional_objective();
  obj_struct = get_struct("vtol_elevator_breadcrumb_struct", "targetname", 1);
  delay_thread(5, ::set_objective, level.obj_evac, obj_struct.origin, "breadcrumb");
  level thread deck_event_crashed_drone_cover();
  flag_wait_all("create_falling_debris_cover", "drones_at_deck");
  autosave_by_name("drone_crashed");
}

blow_up_remaining_deck_vtols() {
  level notify("fxanim_deck_vtol_1_start");
  level notify("fxanim_deck_vtol_2_start");
  level notify("fxanim_deck_vtol_3_start");
  level notify("fxanim_deck_vtol_4_start");
}

move_wave_1_towards_vtol() {
  a_guys = weaken_ai_group("deck_wave_1");
  e_volume_fallback = get_ent("gv_drones_attack", "targetname");
  n_half_group_count = int(a_guys.size * 0.5);

  for(i = 0; i < i < a_guys.size; i++) {
    wait(randomfloatrange(0.5, 1.5));

    if(isalive(a_guys[i]))
      a_guys[i] setgoalvolumeauto(e_volume_fallback);

    if(i == n_half_group_count)
      wait 5;
  }
}

player_deck_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
  if(!isai(eattacker) && smeansofdeath != "MOD_TRIGGER_HURT" && smeansofdeath != "MOD_FALLING")
    idamage = 1;

  return idamage;
}

jetpack_respawners() {
  a_structs_mid_deck = get_struct_array("jetpack_mid_deck_struct", "targetname");
  n_jetpack_mid_spawned = 0;

  while(!flag("stop_spawning_jetpack_respawners_mid_deck") && n_jetpack_mid_spawned < 6) {
    foreach(s_align in a_structs_mid_deck) {
      if(getaicount() < 18) {
        level thread maps\_jetpack_ai::create_jetpack_ai(s_align, "pmc_assault_guy", 0, ::func_jetpack_live_to_deck);
        n_jetpack_mid_spawned++;
      }

      wait(randomfloatrange(3.0, 5.0));
    }
  }

  a_structs_far_deck = get_struct_array("jetpack_far_deck_struct", "targetname");
  n_jetpack_far_spawned = 0;

  while(!flag("stop_spawning_jetpack_respawners_far_deck") && n_jetpack_far_spawned < 5) {
    foreach(s_align in a_structs_far_deck) {
      if(getaicount() < 18) {
        level thread maps\_jetpack_ai::create_jetpack_ai(s_align, "pmc_assault_guy", 0, ::func_jetpack_live_to_deck);

        if(flag("vtol_ready_for_liftoff"))
          n_jetpack_far_spawned++;
      }

      wait(randomfloatrange(3.0, 5.0));
    }
  }
}

func_jetpack_live_to_deck() {
  self endon("death");
  self.overrideactordamage = ::callback_player_damage_only;
  self waittill("landed");
  self.overrideactordamage = undefined;
  self set_goal_pos(self.origin);
  self func_ai_make_aggressive();
}

setup_deck_ai() {
  a_aggressive_guys = add_spawn_function_group("deck_aggressive", "script_noteworthy", ::func_ai_make_aggressive);
  level thread setup_deck_friendly_moveup();
}

setup_deck_friendly_moveup() {
  waittill_ai_group_cleared("deck_wave_1");
  t_moveup_initial = get_ent("deck_moveup_initial", "targetname");

  if(isDefined(t_moveup_initial)) {
    t_moveup_initial notify("trigger");
    waittillframeend;
  }

  t_moveup_1 = get_ent("deck_moveup_wave_1_clear", "targetname");

  if(isDefined(t_moveup_1))
    t_moveup_1 notify("trigger");

  waittill_ai_group_cleared("deck_wave_2");
  t_moveup_2 = get_ent("deck_moveup_wave_2_clear", "targetname");

  if(isDefined(t_moveup_2))
    t_moveup_2 notify("trigger");

  waittill_ai_group_amount_killed("deck_wave_3", 6);
  t_moveup_3 = get_ent("deck_moveup_wave_3_clear", "targetname");

  if(isDefined(t_moveup_3)) {
    t_moveup_3 notify("trigger");
    waittillframeend;
  }

  t_moveup_final = get_ent("deck_moveup_final", "targetname");

  if(isDefined(t_moveup_final))
    t_moveup_final notify("trigger");
}

func_ai_make_aggressive() {
  self.canflank = 1;
  self.aggressivemode = 1;
}

start_aggressive_ai(str_script_noteworthy) {
  while(true) {
    a_aggressive_guys = get_ai_array(str_script_noteworthy);

    if(a_aggressive_guys.size > 0) {
      ai_aggressive = arraysort(a_aggressive_guys, level.player.origin, 1)[0];
      ai_aggressive thread maps\_rusher::rush();
      ai_aggressive waittill("death");
    }

    wait(randomfloatrange(4.0, 8.0));
  }
}

deck_danger_zone() {
  self endon("death");
  e_danger_zone = getent("deck_danger_zone", "targetname");
  e_kill_zone = getent("deck_kill_zone", "targetname");

  while(isalive(self)) {
    if(self istouching(e_danger_zone)) {
    } else if(self istouching(e_kill_zone)) {
      level.player.overrideplayerdamage = undefined;
      screen_message_delete();
      magicbullet("avenger_missile_turret_blackout", self.origin + vectorscale((0, 0, 1), 1000.0), self.origin);
      wait 0.3;
      self dodamage(1000, self.origin);
    } else {
    }

    wait 0.25;
  }
}

spawn_seals_from_optional_objective() {
  if(level.num_seals_saved > 0) {
    for(i = 0; i < 3; i++)
      simple_spawn_single("support_seal", ::magic_bullet_shield);
  } else
    spawn_manager_enable("sm_mason_deck_allies");
}

deck_event_jetpack_ai() {
  level thread deck_event_jetpack_drones("deck_jetpack_takeoff_drone", "menendez_escaped");
  a_s_landing = getstructarray("menendez_protect_jetpack", "targetname");

  foreach(s_align in a_s_landing) {
    level thread maps\_jetpack_ai::create_jetpack_ai(s_align, "pmc_assault_guy", 0, ::func_jetpack_run_to_cover);
    wait(randomfloatrange(3.0, 5.0));
  }

  flag_wait("menendez_escaped");
  level thread deck_event_jetpack_drones("deck_jetpack_debris_drone", "create_falling_debris_cover");
  flag_wait("create_falling_debris_cover");
  a_s_landing = getstructarray("vtol_fight_jetpack", "targetname");

  foreach(s_align in a_s_landing) {
    level thread maps\_jetpack_ai::create_jetpack_ai(s_align, "pmc_assault_guy", 0, ::func_jetpack_run_to_cover);
    wait(randomfloatrange(4.0, 6.0));
  }
}

func_jetpack_run_to_cover() {
  self endon("death");
  self waittill("landed");
  self set_goal_pos(self.origin);
  self func_ai_make_aggressive();
}

deck_event_jetpack_drones(str_struct, str_flag, n_wait_min, n_wait_max) {
  if(!isDefined(n_wait_min))
    n_wait_min = 2;

  if(!isDefined(n_wait_max))
    n_wait_max = 4;

  level endon(str_flag);
  level thread deck_event_jetpack_drones_cleanup(str_struct, str_flag);
  a_s_landing = getstructarray(str_struct, "targetname");

  if(a_s_landing.size > 0) {
    while(true) {
      foreach(s_landing in a_s_landing) {
        level thread maps\_jetpack_ai::create_jetpack_ai(s_landing, "pmc_assault_guy", 1);
        wait(randomfloatrange(n_wait_min, n_wait_max));
      }

      a_s_landing = array_randomize(a_s_landing);
    }
  }
}

deck_event_jetpack_drones_cleanup(str_struct, str_flag) {
  flag_wait(str_flag);
  cleanup_structs(str_struct, "targetname");
}

deck_event_menendez_takeoff() {
  level thread dialog_combat_menendez_takeoff();
  level.v_menendez_f38 = spawn_vehicle_from_targetname("F35");
  level.v_menendez_f38 attach("veh_t6_air_fa38_landing_gear", "tag_landing_gear_down");
  level.v_menendez_f38.takedamage = 0;
  level.v_menendez_f38 thread go_path(getvehiclenode("menendez_deck_start", "targetname"));
  level.v_menendez_f38 setspeed(0);
  flag_wait("reached_top_elevator");
  level.v_menendez_f38 resumespeed(3);
  level.v_menendez_f38 waittill("resume_speed");
  level thread dialog_menendez_escaping();
  level thread play_drone_swarm();
  level.v_menendez_f38 thread deck_event_menendez_takeoff_sound();
  level.v_menendez_f38 thread deck_event_menendez_takeoff_vo();
  self waittill("take_off");
  flag_set("menendez_escaped");
  level.v_menendez_f38 waittill("reached_end_node");
  level.v_menendez_f38.delete_on_death = 1;
  level.v_menendez_f38 notify("death");

  if(!isalive(level.v_menendez_f38))
    level.v_menendez_f38 delete();
}

dialog_combat_menendez_takeoff() {
  level thread queue_dialog_enemy("cub0_protect_menendez_0", 0, "reached_top_elevator", "menendez_escaped");
  level thread queue_dialog_enemy("cub2_make_sure_his_plane_0", 0, "reached_top_elevator", "menendez_escaped");
  level thread queue_dialog_ally("nav0_target_the_fighter_0", 0, "reached_top_elevator", "menendez_escaped");
  level thread queue_dialog_ally("nav1_we_can_t_let_it_take_0", 0, "reached_top_elevator", "menendez_escaped");
  flag_wait("menendez_escaped");
  queue_dialog_ally("nav2_we_re_too_late_0", 0);
  queue_dialog_enemy("cub1_menendez_is_clear_0", 0);
  level thread dialog_combat_deck();
  flag_wait("create_falling_debris_cover");
  queue_dialog_ally("nav3_clear_the_area_it_0", 2);
  queue_dialog_ally("nav0_watch_the_debris_0", 3);
}

dialog_combat_deck() {
  a_enemy_generic = [];
  a_enemy_generic[a_enemy_generic.size] = "cub1_keep_them_back_0";
  a_enemy_generic[a_enemy_generic.size] = "cub3_destroy_their_aircra_0";
  a_enemy_generic[a_enemy_generic.size] = "cub0_don_t_let_them_off_t_0";
  a_enemy_generic[a_enemy_generic.size] = "cub2_don_t_let_them_throu_0";
  a_enemy_generic[a_enemy_generic.size] = "cub1_they_re_pushing_forw_0";
  a_enemy_generic[a_enemy_generic.size] = "cub1_hold_them_back_0";
  a_enemy_generic[a_enemy_generic.size] = "cub0_cut_them_down_0";
  level thread start_combat_vo_group_enemy(a_enemy_generic, "player_boarded_vtol");
  a_friendly_generic = [];
  a_friendly_generic[a_friendly_generic.size] = "nav0_return_fire_0";
  a_friendly_generic[a_friendly_generic.size] = "nav2_hold_the_area_0";
  a_friendly_generic[a_friendly_generic.size] = "nav3_protect_the_remainin_0";
  a_friendly_generic[a_friendly_generic.size] = "nav1_engaging_0";
  a_friendly_generic[a_friendly_generic.size] = "nav0_moving_up_0";
  level thread start_combat_vo_group_friendly(a_friendly_generic, "player_boarded_vtol");
}

deck_event_menendez_takeoff_vo() {
  self waittill("take_off");
  level thread deck_event_pip_drones();
}

deck_event_menendez_takeoff_sound() {
  sound_ent = spawn("script_origin", self.origin);
  sound_ent linkto(self, "tag_canopy");
  sound_ent playloopsound("evt_menendez_takeoff");
  wait 27;
  sound_ent delete();
}

deck_event_pip_drones() {
  if(level.is_briggs_alive) {
    level.fire_at_drones = 1;
    level thread randomly_destroy_drone();
  }

  s_planes = get_struct("struct_ambient_planes", "targetname");
  play_fx("fx_la_drones_above_city", s_planes.origin, s_planes.angles);
  autosave_by_name("drone_attack");
  wait 5;
  playsoundatposition("evt_deck_fake_flyby", (0, 0, 0));
  flag_set("drones_at_deck");
}

dialog_menendez_escaping() {
  level.player queue_dialog("sect_we_re_too_late_0");
  level.player queue_dialog("sect_menendez_is_already_0");
  level.player queue_dialog("sect_he_s_taken_control_o_0");
  level.player queue_dialog("sect_tac_command_i_need_0", 2);
  level.player queue_dialog("nav3_confirmed_security_0");
}

deck_event_crashed_drone_cover() {
  m_cover = getent("deck_drone_debris_cover", "targetname");
  m_cover trigger_off();
  drone_cover_show();
  flag_wait("create_falling_debris_cover");
  level notify("fxanim_drone_cover_start");
  wait 8.2;
  m_cover trigger_on();

  if(level.player istouching(m_cover))
    level.player dodamage(1000, level.player.origin, m_cover);

  drone_cover_toggle(1);
}

drone_cover_toggle(b_enabled) {
  a_nodes = getnodearray("drone_cover_node", "script_noteworthy");

  foreach(node in a_nodes)
  setenablenode(node, b_enabled);
}

deck_event_f38_crash() {
  maps\_fxanim::fxanim_reconstruct("fxanim_f38_launch_fail");
  maps\_fxanim::fxanim_reconstruct("fxanim_f38_failed_landing_gear");
  flag_wait("menendez_escaped");
  level notify("fxanim_f38_launch_fail_start");
  level.player thread deck_event_f38_crash_rumble();
  wait 1.5;
  explosion_launch(getstruct("jet_crash_kill_1", "targetname").origin, 400);
  wait 0.5;
  explosion_launch(getstruct("jet_crash_kill_2", "targetname").origin, 400);
  wait 0.5;
  explosion_launch(getstruct("jet_crash_kill_3", "targetname").origin, 400);
}

deck_event_f38_crash_rumble() {
  wait 1.5;
  self playrumbleonentity("damage_heavy");
  earthquake(0.8, 0.5, self.origin, 256, self);
  wait 0.2;
  self playrumblelooponentity("tank_rumble");
  earthquake(0.4, 2, self.origin, 256, self);
  wait 1.2;
  self stoprumble("tank_rumble");
  self playrumbleonentity("damage_light");
  earthquake(0.6, 0.3, self.origin, 256, self);
}

drones_firing_at_the_player() {
  level endon("player_in_vtol");
  player_last_pos = level.player.origin;
  wait 3;

  while(true) {
    player_last_pos = level.player.origin;
    wait 5;
    bullet = magicbullet("avenger_missile_turret_blackout", player_last_pos + vectorscale((0, 0, 1), 300.0), player_last_pos);
    bullet thread drone_missile_earthquake();
  }
}

drone_missile_earthquake() {
  wait 0.2;
  earthquake(0.5, 1, level.player.origin, 100);
}

run_mason_deck_final() {
  maps\blackout_anim::vtol_escape();
  m_vtol_elevator = getent("vtol_elevator", "targetname");
  m_vtol_elevator setmovingplatformenabled(1);
  sp_crosby = get_ent("crosby", "targetname");
  sp_crosby add_spawn_function(::crosby_setup);
  veh_player_vtol = spawn_vehicle_from_targetname("player_vtol");
  veh_player_vtol veh_magic_bullet_shield();
  veh_player_vtol hidepart("tag_autopilot_off");
  veh_player_vtol linkto(m_vtol_elevator);
  veh_player_vtol notsolid();
  t_player_board = getent("player_board_vtol", "targetname");
  veh_player_vtol thread board_vtol_audio();
  level thread run_scene_and_delete("exit_vtol_crosby_wait");
  m_vtol_elevator movez(576, 15, 3, 3);
  m_vtol_elevator playsound("evt_elev_start_3d");
  m_vtol_elevator playloopsound("evt_elev_loop_3d", 3);
  m_vtol_elevator waittill("movedone");
  flag_set("vtol_ready_for_liftoff");
  level thread fail_condition_all_enemies_dead();
  earthquake(0.3, 0.5, m_vtol_elevator.origin, 1000, level.player);
  m_vtol_elevator stoploopsound(2);
  m_vtol_elevator playsound("evt_elev_stop_3d");
  veh_player_vtol unlink();
  run_scene_first_frame("exit_vtol");
  flag_wait("player_boarded_vtol");
  level thread maps\_audio::switch_music_wait("BLACKOUT_FLY_AWAY", 7);
  delay_thread(0.5, ::set_objective, level.obj_evac, undefined, "done");
  level.player.overrideplayerdamage = ::vtol_player_override;
  level thread drones_firing_at_the_player();
  level thread trigger_carrier_explosions();
  rpc("clientscripts/blackout_amb", "set_ending_vtol_snap");
  level thread outro_launchers_fire();
  level thread run_mason_deck_final_player();
  level thread run_scene_and_delete("exit_vtol");
  level thread run_scene_and_delete("exit_vtol_enemy");
  run_scene_and_delete("exit_vtol_crosby");
  run_scene_and_delete("exit_vtol_crosby_death");
}

fail_condition_all_enemies_dead() {
  level endon("player_boarded_vtol");
  s_evac = get_struct("vtol_elevator_breadcrumb_struct", "targetname");

  while(getaiarray("axis").size > 0)
    wait 5;

  set_objective(level.obj_evac, s_evac.origin, "", undefined, undefined, 30);
  wait 30;
  set_objective(level.obj_evac, s_evac.origin, "failed");
  level.player.overrideplayerdamage = undefined;
  magicbullet("avenger_missile_turret_blackout", level.player.origin + vectorscale((0, 0, 1), 1000.0), level.player.origin);
  wait 0.3;
  level.player dodamage(1000, level.player.origin);

  if(!isgodmode(level.player))
    missionfailedwrapper(&"BLACKOUT_VTOL_FAIL");
}

outro_launchers_fire() {
  a_launchers = get_ent_array("outro_launcher", "script_noteworthy");
  array_thread(a_launchers, ::outro_launcher_logic);
}

outro_launcher_logic() {
}

run_mason_deck_final_deck_attackers() {
  s_goalpos = get_struct("outro_pmc_goal", "targetname");
  e_target = get_outro_ai_target();
  sp_assault = get_ent("outro_pmc_assault", "targetname");
  sp_rpg = get_ent("outro_pmc_rpg", "targetname");
  sp_assault add_spawn_function(::func_outro_enemy_attacker, s_goalpos, e_target);
  sp_rpg add_spawn_function(::func_outro_enemy_attacker, s_goalpos, e_target);
  a_enemies = getaiarray("axis");

  foreach(guy in a_enemies)
  guy thread func_outro_enemy_attacker(s_goalpos, e_target);

  n_spawned = 0;
  a_warp_structs = get_struct_array("outro_rail_spawner_warp", "targetname", 1);
  n_index_max = a_warp_structs.size;

  while(getaicount() < 18) {
    n_index = n_spawned % n_index_max;

    if(n_index == 4)
      simple_spawn_single(sp_rpg, ::func_outro_warp_to_deck_struct, a_warp_structs[n_index]);
    else
      simple_spawn_single(sp_assault, ::func_outro_warp_to_deck_struct, a_warp_structs[n_index]);

    n_spawned++;
    wait 0.2;
  }
}

get_outro_ai_target() {
  vh_vtol = get_ent("player_vtol");
  v_origin = vh_vtol gettagorigin("tag_barrel");
  v_angles = anglestoforward(vh_vtol gettagangles("tag_barrel")) * 450;
  v_offset = (0, 0, 0);
  v_fire = v_origin + v_angles + v_offset;
  e_target = spawn("script_origin", v_fire);
  e_target.health = 99999;
  e_target setcandamage(1);
  e_target linkto(vh_vtol);
  return e_target;
}

debug_shot_target(e_target) {
  while(true) {
    self thread draw_line_for_time(self.origin, e_target.origin, 1, 1, 1, 0.05);
    wait 0.05;
  }
}

func_outro_warp_to_deck_struct(s_warp) {
  self forceteleport(s_warp.origin, s_warp.angles);
}

func_outro_enemy_attacker(s_goalpos, e_target) {
  self endon("death");

  if(self.targetname != "exit_enemy_ai") {
    self set_goalradius(512);
    self set_goal_pos(s_goalpos.origin);
    self thread magic_bullet_shield();
    self thread shoot_at_target_untill_dead(e_target);
  }
}

run_mason_deck_final_player() {
  level thread run_scene_and_delete("exit_vtol_player");
  wait 0.05;
  m_player_body = get_model_or_models_from_scene("exit_vtol_player", "player_body");
  m_player_body attach("t6_wpn_pistol_fiveseven_prop", "tag_weapon");
}

run_mason_deck_final_fire(player_body) {
  v_start = player_body gettagorigin("tag_fx");
  v_angles = player_body gettagangles("tag_fx");
  v_end = v_start + anglestoforward(v_angles) * 200;
  magicbullet("fiveseven_sp", v_start, v_end);
  playfxontag(level._effect["crosby_shot_muzzleflash"], player_body, "tag_fx");
  ai_enemy = get_ent("exit_enemy_ai", "targetname");
  ai_enemy stop_magic_bullet_shield();
}

run_mason_deck_final_fadeout(player_body) {
  level clientnotify("fade_out");

  if(isDefined(level.is_briggs_alive) && level.is_briggs_alive && (isDefined(level.player get_story_stat("CHINA_IS_ALLY")) && level.player get_story_stat("CHINA_IS_ALLY"))) {
    level.player giveachievement_wrapper("SP_STORY_OBAMA_SURVIVES");

    if(isDefined(level.is_karma_alive) && level.is_karma_alive)
      level.player giveachievement_wrapper("SP_STORY_CHLOE_LIVES");
  }

  if(isDefined(level.is_briggs_alive) && !level.is_briggs_alive || isDefined(level.player get_story_stat("CHINA_IS_ALLY")) && !level.player get_story_stat("CHINA_IS_ALLY"))
    level.player set_story_stat("KARMA_DEAD_IN_COMMAND_CENTER", 1);

  level.player notify("mission_finished");
  screen_fade_out(0.25);
  wait 0.5;
  nextmission();
}

run_mason_deck_final_manual(player_body) {
  veh_player_vtol = getent("player_vtol", "targetname");
  veh_player_vtol hidepart("tag_autopilot_on");
  veh_player_vtol showpart("tag_autopilot_off");
}

board_vtol_audio() {
  sound_ent_1 = spawn("script_origin", self.origin);
  sound_ent_2 = spawn("script_origin", self.origin);
  sound_ent_1 linkto(self, "tag_origin", (-75, 300, 0));
  sound_ent_2 linkto(self, "tag_origin", (75, -300, 0));
  sound_ent_1 playloopsound("veh_side_engine");
  sound_ent_2 playloopsound("veh_side_engine");
}

vtol_player_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  if(self.health < 50) {
    if(str_weapon != "avenger_missile_turret_blackout")
      n_damage = 0;
  }

  return n_damage;
}

trigger_carrier_explosions() {
  earthquake(0.3, 2.0, level.player.origin, 100);
}

ambient_drone_manager() {
  previous_drone_index = 0;
  random_drone_index = 0;

  while(true) {
    while(previous_drone_index == random_drone_index) {
      random_drone_index = randomintrange(1, 6);
      wait 0.05;
    }

    previous_drone_index = random_drone_index;
    level thread spawn_drone_to_fire(random_drone_index);
    wait 3;
  }
}

spawn_drone_to_fire(index) {
  drone = spawn_vehicle_from_targetname("veh_drone_deck_" + index);
  drone thread go_path(getvehiclenode("drone_path_" + index, "targetname"));
  drone thread delete_at_end_node();
  level waittill("drone_fire_" + index);

  if(drone.vehicletype == "drone_pegasus") {
    tag_origin = drone gettagorigin("TAG_MISSILE_LEFT");
    end_missile = getstruct("drone_fire_missiles_end_" + index, "targetname");
    magicbullet("avenger_missile_turret_blackout", tag_origin, end_missile.origin);

    if(index == 5) {
      tag_origin = drone gettagorigin("TAG_MISSILE_Right");
      end_missile = getstruct("drone_fire_missiles_end_" + index + "_2", "targetname");
      magicbullet("avenger_missile_turret_blackout", tag_origin, end_missile.origin);
    }
  } else
    drone thread drone_fire_squibs(index);
}

drone_fire_squibs(index) {
  level endon("drone_stop_fire_" + index);
  self endon("delete");
  self endon("death");

  while(true) {
    fire_at_target = anglestoforward(self.angles + (randomintrange(-45, 45), randomintrange(-45, 45), 0)) * 300 + vectorscale((0, 0, -1), 1000.0);
    magicbullet("f35_side_minigun", self.origin, self.origin + fire_at_target);
    wait 0.1;
  }
}

delete_at_end_node() {
  self endon("delete");
  self waittill("reached_end_node");
  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();

  level notify("start_ambient");
}

play_drone_swarm(b_earthquake) {
  a_start_nodes = getvehiclenodearray("drone_swarm_spline_start", "script_noteworthy");

  for(flybys = 0; flybys < 3; flybys++) {
    for(i = 0; i < a_start_nodes.size; i++) {
      b_use_pegasus = cointoss();
      str_spawner_name = b_use_pegasus ? "drone_swarm_0" : "drone_swarm_1";
      vh_temp = spawn_vehicle_from_targetname(str_spawner_name);
      vh_temp.origin = a_start_nodes[i].origin;
      vh_temp.angles = a_start_nodes[i].angles;
      vh_temp.drivepath = 1;
      vh_temp thread go_path(a_start_nodes[i]);
      vh_temp thread delete_at_end_node();
      vh_temp thread fire_at_carrier();
      wait 0.05;
    }

    wait 1.5;
  }

  if(!isDefined(b_earthquake) || b_earthquake == 1)
    level thread drone_earthquake();

  level waittill("start_ambient");
  level thread sky_cowbell();
  level thread ambient_drone_manager();
  level thread run_missile_firing_drones_around_player();
}

fire_at_carrier() {
  self endon("death");

  while(is_alive(self)) {
    self waittill("fire_at_carrier");

    if(isDefined(self.currentnode.script_string)) {
      s_target = get_struct(self.currentnode.script_string, "targetname");
      self thread drone_fake_fire_at_target(s_target);
    }
  }
}

drone_fake_fire_at_target(s_target) {
  v_start = self gettagorigin("tag_flash");
  v_end = s_target.origin;
  v_to_target = v_end - v_start;
  playfx(level._effect["drone_swarm_fake_missile"], v_start, v_to_target);
}

play_drone_swarm_old(b_earthquake) {
  drone = spawn_vehicle_from_targetname("drone_swarm_1");
  drone thread go_path(getvehiclenode("drone_start_path_1", "targetname"));
  drone thread drone_swarm_fire_missile(1);
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_1");
  drone thread go_path(getvehiclenode("drone_start_path_2", "targetname"));
  drone thread drone_swarm_fire_missile(2);
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_0");
  drone thread go_path(getvehiclenode("drone_start_path_3", "targetname"));
  drone thread drone_swarm_fire_squibs(3);
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_1");
  drone thread go_path(getvehiclenode("drone_start_path_4", "targetname"));
  drone thread drone_swarm_fire_missile(4);
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_1");
  drone thread go_path(getvehiclenode("drone_start_path_5", "targetname"));
  drone thread drone_swarm_fire_missile(5);
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_0");
  drone thread go_path(getvehiclenode("drone_start_path_6", "targetname"));
  drone thread drone_swarm_fire_squibs(6);
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_1");
  drone thread go_path(getvehiclenode("drone_start_path_7", "targetname"));
  drone thread drone_swarm_fire_missile(2);
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_1");
  drone thread go_path(getvehiclenode("drone_start_path_8", "targetname"));
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_1");
  drone thread go_path(getvehiclenode("drone_start_path_9", "targetname"));
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_1");
  drone thread go_path(getvehiclenode("drone_start_path_10", "targetname"));
  drone thread drone_swarm_fire_missile(5);
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_1");
  drone thread go_path(getvehiclenode("drone_start_path_11", "targetname"));
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_1");
  drone thread go_path(getvehiclenode("drone_start_path_12", "targetname"));
  drone thread delete_at_end_node();
  drone = spawn_vehicle_from_targetname("drone_swarm_0");
  drone thread go_path(getvehiclenode("drone_start_path_13", "targetname"));
  drone thread drone_swarm_fire_squibs(3);
  drone thread delete_at_end_node();

  if(!isDefined(b_earthquake) || b_earthquake == 1)
    level thread drone_earthquake();

  level waittill("start_ambient");
  level thread sky_cowbell();
  level thread ambient_drone_manager();
  level thread run_missile_firing_drones_around_player();
}

drone_earthquake() {
  level waittill("drone_swarm_start_fire_2");
  level.player playrumblelooponentity("damage_light");
  earthquake(0.2, 2, level.player.origin, 1000, level.player);
  wait 0.9;
  level.player playrumblelooponentity("damage_heavy");
  earthquake(0.3, 3, level.player.origin, 1000, level.player);
  wait 1.9;
  earthquake(0.4, 2.5, level.player.origin, 1000, level.player);
  wait 1.4;
  level.player playrumblelooponentity("damage_light");
  earthquake(0.3, 2, level.player.origin, 1000, level.player);
  wait 1.9;
  stopallrumbles();
}

drone_swarm_fire_missile(index) {
  level waittill("drone_swarm_start_fire_" + index);
  tag_origin = self gettagorigin("TAG_MISSILE_Right");
  fire_at_target = anglestoforward(self.angles) * 500;
  magicbullet("avenger_missile_turret_blackout", tag_origin + fire_at_target, tag_origin + fire_at_target * 10);
}

drone_swarm_fire_squibs(index) {
  level endon("drone_swarm_stop_fire_" + index);
  level waittill("drone_swarm_start_fire_" + index);

  while(true) {
    tag_origin = self gettagorigin("tag_gear_nose");
    fire_at_target = anglestoforward(self.angles + (randomintrange(-45, 45), randomintrange(-45, 45), 0)) * 300 + vectorscale((0, 0, -1), 1000.0);
    magicbullet("f35_side_minigun", tag_origin, tag_origin + fire_at_target);
    wait 0.1;
  }
}

sky_cowbell() {
  level endon("sky_cowbell_stop");
  s_sky_cowbell = get_struct("sky_cowbell", "targetname");

  if(isDefined(s_sky_cowbell)) {
    level.sky_cowbell = spawnstruct();
    sky_cowbell_set_max_drones(10);
    sky_cowbell_set_ratio();
    level.sky_cowbell.avenger_count = 0;
    level.sky_cowbell.pegasus_count = 0;
    level.sky_cowbell.drones = [];
    sp_avenger = get_vehicle_spawner("avenger_ambient");
    sp_pegasus = get_vehicle_spawner("pegasus_ambient");
    a_spawn_points = get_struct_array("sky_cowbell_spawn_point", "targetname", 1);
    a_flight_structs = get_struct_array("sky_cowbell_flight_struct", "targetname", 1);
    a_valid_targets = get_ent_array("sky_cowbell_targets", "targetname", 1);
    a_valid_targets = arraycombine(a_valid_targets, getentarray("sky_cowbell_targets", "script_noteworthy"), 1, 0);
    add_spawn_function_veh("avenger_ambient", ::sky_cowbell_drone_spawn_func, a_flight_structs);
    add_spawn_function_veh("avenger_ambient", ::sky_cowbell_drone_tracker);
    add_spawn_function_veh("avenger_ambient", ::sky_cowbell_firing_func, a_valid_targets);
    add_spawn_function_veh("avenger_ambient", ::delete_corpse);
    add_spawn_function_veh("pegasus_ambient", ::sky_cowbell_drone_spawn_func, a_flight_structs);
    add_spawn_function_veh("pegasus_ambient", ::sky_cowbell_drone_tracker);
    add_spawn_function_veh("pegasus_ambient", ::sky_cowbell_firing_func, a_valid_targets);
    add_spawn_function_veh("pegasus_ambient", ::delete_corpse);

    while(true) {
      n_delay = 0.25;
      n_active = level.sky_cowbell.drones.size;
      n_active_max = level.sky_cowbell.max_count;

      if(n_active < n_active_max) {
        n_drones_total = level.sky_cowbell.max_count;
        n_avengers_ideal = int(level.sky_cowbell.ratio_pegasus_percent * n_drones_total);
        n_avengers_active = level.sky_cowbell.avenger_count;
        b_should_spawn_avenger = n_avengers_active < n_avengers_ideal;

        if(b_should_spawn_avenger) {
          sp_drone = sp_avenger;
          str_spawner = "avenger_ambient";
        } else {
          sp_drone = sp_pegasus;
          str_spawner = "pegasus_ambient";
        }

        s_spawner_position = _get_random_element_player_cant_see(a_spawn_points);
        sp_drone.origin = s_spawner_position.origin;
        spawn_vehicle_from_targetname(str_spawner);
      } else
        n_delay = 3;

      wait(n_delay);
    }
  }
}

_get_random_element_player_cant_see(a_elements) {
  assert(isDefined(a_elements), "a_elements is a required parameter for _get_random_element_player_cant_see");
  assert(a_elements.size > 0, "a_elements needs to contain at least one element in _get_random_element_player_cant_see");
  b_found_element = 0;
  e_player = level.player;
  b_do_trace = 0;

  while(!b_found_element) {
    s_element = random(a_elements);

    if(!isDefined(s_element)) {
      wait 0.1;
      continue;
    }

    b_can_player_see_point = e_player is_looking_at(s_element.origin, 0.3, b_do_trace);

    if(!b_can_player_see_point)
      b_found_element = 1;

    wait 0.1;
  }

  return s_element;
}

sky_cowbell_stop() {
  level notify("sky_cowbell_stop");
}

sky_cowbell_drone_spawn_func(a_flight_structs) {
  self endon("death");
  n_notify_dist = 1000;
  self setneargoalnotifydist(n_notify_dist);
  self.script_noteworthy = "deck_drone";

  while(is_alive(self)) {
    s_flight_goal = random(a_flight_structs);
    self setvehgoalpos(s_flight_goal.origin, 0);
    self waittill("near_goal");
  }
}

sky_cowbell_drone_tracker() {
  if(!isDefined(level.sky_cowbell.drones))
    level.sky_cowbell.drones = [];

  level.sky_cowbell.drones[level.sky_cowbell.drones.size] = self;
  b_is_avenger = issubstr(self.vehicletype, "avenger");

  if(b_is_avenger)
    level.sky_cowbell.avenger_count++;
  else
    level.sky_cowbell.pegasus_count++;

  self waittill("death");
  arrayremovevalue(level.sky_cowbell.drones, undefined);

  if(b_is_avenger)
    level.sky_cowbell.avenger_count--;
  else
    level.sky_cowbell.pegasus_count--;
}

sky_cowbell_firing_func(a_valid_targets) {
  self endon("death");
  self maps\_turret::set_turret_burst_parameters(1, 3, 4, 5, 0);
  self maps\_turret::set_turret_burst_parameters(0.5, 1.5, 4, 6, 1);
  self maps\_turret::set_turret_burst_parameters(0.5, 1.5, 4, 6, 2);
  self maps\_turret::set_turret_target_ent_array(a_valid_targets, 0);
  self maps\_turret::set_turret_target_ent_array(a_valid_targets, 1);
  self maps\_turret::set_turret_target_ent_array(a_valid_targets, 2);

  while(is_alive(self)) {
    b_use_guns = cointoss();
    n_fire_time = randomfloatrange(3, 5);
    b_has_target = 0;

    while(!b_has_target) {
      e_target = random(a_valid_targets);
      b_has_target = self maps\_turret::can_turret_hit_target(e_target, b_use_guns);
      wait 0.05;
    }

    if(b_use_guns) {
      self maps\_turret::set_turret_target(e_target, (0, 0, 0), 0);
      self maps\_turret::fire_turret_for_time(n_fire_time, 0);
    } else {
      self maps\_turret::set_turret_target(e_target, (0, 0, 0), 1);
      self maps\_turret::set_turret_target(e_target, (0, 0, 0), 2);
      self thread maps\_turret::fire_turret_for_time(n_fire_time, 1);
      self maps\_turret::fire_turret_for_time(n_fire_time, 1);
    }
  }
}

sky_cowbell_set_max_drones(n_count) {
  if(!isDefined(level.sky_cowbell.max_count))
    level.sky_cowbell.max_count = 20;

  if(isDefined(n_count))
    level.sky_cowbell.max_count = n_count;
}

sky_cowbell_set_ratio(n_ratio_avenger, n_ratio_pegasus) {
  if(!isDefined(level.sky_cowbell.ratio_avenger))
    level.sky_cowbell.ratio_avenger = 2;

  if(!isDefined(level.sky_cowbell.ratio_pegasus))
    level.sky_cowbell.ratio_pegasus = 1;

  if(isDefined(n_ratio_avenger))
    level.sky_cowbell.ratio_avenger = n_ratio_avenger;

  if(isDefined(n_ratio_pegasus))
    level.sky_cowbell.ratio_pegasus = n_ratio_pegasus;

  n_total = sky_cowbell_get_ratio_total();
  n_pegasus_count = level.sky_cowbell.ratio_pegasus;
  n_avenger_count = level.sky_cowbell.ratio_avenger;
  level.sky_cowbell.ratio_pegasus_percent = n_pegasus_count / n_total;
  level.sky_cowbell.ratio_avenger_percent = n_avenger_count / n_total;
}

sky_cowbell_get_ratio_total() {
  return level.sky_cowbell.ratio_avenger + level.sky_cowbell.ratio_pegasus;
}

brute_force_perk() {
  t_brute_force = getent("brute_force_debris_trigger", "targetname");
  t_brute_force setcursorhint("HINT_NOICON");
  t_brute_force sethintstring(&"SCRIPT_HINT_BRUTE_FORCE");
  t_brute_force trigger_off();
  t_console = getent("brute_force_computer", "targetname");
  t_console setcursorhint("HINT_NOICON");
  t_console sethintstring(&"BLACKOUT_PHALANX_TERMINAL");
  t_console trigger_off();
  m_debris = getent("brute_force_debris", "targetname");
  m_debris_clip = getent("brute_force_debris_clip", "targetname");
  level.player waittill_player_has_brute_force_perk();
  t_brute_force trigger_on();
  set_objective(level.obj_interact, t_brute_force, "interact");
  t_brute_force waittill("trigger");
  set_objective(level.obj_interact, t_brute_force, "remove");
  t_brute_force delete();
  level thread clip_off_brute_force_debris(0.5);
  level.player thread brute_force_rumble();
  run_scene_and_delete("brute_force_move");
  m_debris_clip delete();
  flag_set("player_used_brute_force");
  level notify("boot_up_claw");
}

clip_off_brute_force_debris(delay) {
  wait(delay);
  e_clip = getent("brute_force_moved_player_clip", "targetname");
  v_new_pos = (e_clip.origin[0], e_clip.origin[1], e_clip.origin[2] + 50);
  e_clip moveto(v_new_pos, 0.1);
}

brute_force_kill_jetpacks() {
  self endon("death");
  wait(randomfloatrange(2.0, 6.0));

  if(isDefined(self.m_jetpack)) {
    self dodamage(10, self.origin);
    level notify("phalanx_kill");
  }
}

brute_force_rumble() {
  wait 1;
  self playrumbleonentity("damage_light");
  wait 1;
  self playrumbleonentity("damage_heavy");
  earthquake(0.3, 0.5, self.origin, 1000, self);
  wait 0.5;
  self playrumbleonentity("tank_rumble");
  earthquake(0.1, 1, self.origin, 1000, self);
  wait 1.5;
  self playrumbleonentity("damage_heavy");
  earthquake(0.3, 0.5, self.origin, 1000, self);
}

drone_barrage() {
  self endon("death");
  fire_at_array = getstructarray("drone_strike_at", "targetname");
  index = randomint(fire_at_array.size);
  level waittill("drone_barrage");
  rand_wait = randomint(10);
  wait(rand_wait / 10);
  missile_right = self gettagorigin("TAG_MISSILE_Right");
  missile_left = self gettagorigin("TAG_MISSILE_Left");
  magicbullet("avenger_missile_turret_blackout", missile_right, fire_at_array[index].origin);
  magicbullet("avenger_missile_turret_blackout", missile_left, fire_at_array[index].origin);
}

randomly_destroy_drone() {
  while(true) {
    if(randomint(4) == 0) {
      a_drone_vehicles = getentarray("drone_turret_targets", "script_noteworthy");

      if(a_drone_vehicles.size > 0) {
        index = randomint(a_drone_vehicles.size);
        radiusdamage(a_drone_vehicles[index].origin, 1028, a_drone_vehicles[index].health * 2, a_drone_vehicles[index].health * 2);
      }
    }

    wait 5;
  }
}

delete_corpse() {
  self endon("delete");
  self waittill("death");

  while(self.origin[2] < -1028)
    wait 0.5;

  self.delete_on_death = 1;
  self notify("death");

  if(!isalive(self))
    self delete();
}

run_missile_firing_drones_around_player() {
  while(true) {
    level thread fire_missile_from_behind_the_player();
    wait(randomintrange(3, 6));
  }
}

fire_missile_from_behind_the_player() {
  n_spawn_yaw = absangleclamp360(level.player.angles[1] + randomintrange(90, 270));
  v_missile_spawn_org = level.player.origin + anglestoforward((0, n_spawn_yaw, 0)) * 3000;
  v_missile_spawn_org = (v_missile_spawn_org[0], v_missile_spawn_org[1], randomintrange(2000, 3000));
  s_fire_missile_target = find_missile_fire_at_target_the_player_is_looking_at();
  magicbullet("avenger_missile_turret_blackout", v_missile_spawn_org, s_fire_missile_target.origin);
}

find_missile_fire_at_target_the_player_is_looking_at() {
  a_elements = getstructarray("drone_fire_missles_target", "targetname");
  b_found_element = 0;
  e_player = level.player;
  b_do_trace = 0;

  while(!b_found_element) {
    s_element = random(a_elements);

    if(!isDefined(s_element)) {
      wait 0.1;
      continue;
    }

    b_can_player_see_point = e_player is_looking_at(s_element.origin, 0.3, b_do_trace);

    if(distance(e_player.origin, s_element.origin) < 1500) {
      wait 0.1;
      continue;
    }

    if(b_can_player_see_point)
      b_found_element = 1;

    wait 0.1;
  }

  return s_element;
}

run_dev_drones() {
  level.player set_ignoreme(1);
  o_link_spot = getent("menendez_plane_pip_org", "targetname");
  level.player playerlinktodelta(o_link_spot, undefined, 1, 90, 90, 90, 90);
  level thread dev_drones_ambience();

  while(true) {
    if(level.player usebuttonpressed()) {
      break;
    }

    wait 0.1;
  }

  screen_message_delete();

  while(true) {
    maps\blackout_util::spawn_drone_v_formation(randomintrange(5, 15), "ambient_drone_formation_spline", randomfloatrange(300, 600));
    wait 1;
    vh_menendez_f38 = menendez_fly_into_sunset();
    level waittill("part");
    maps\blackout_util::spawn_drone_stack_formation(randomintrange(2, 6), "ambient_drone_formation_spline2", randomfloatrange(300, 600));
    maps\blackout_util::spawn_drone_stack_formation(randomintrange(4, 6), "ambient_drone_formation_spline2", randomfloatrange(300, 600));
    maps\blackout_util::spawn_drone_stack_formation(randomintrange(4, 6), "ambient_drone_formation_spline3", randomfloatrange(300, 600));
    maps\blackout_util::spawn_drone_v_formation(randomintrange(3, 6), "ambient_drone_formation_spline_right_tendril", randomfloatrange(300, 600));
    maps\blackout_util::spawn_drone_v_formation(randomintrange(3, 6), "ambient_drone_formation_spline_right_tendril", randomfloatrange(300, 600));
    maps\blackout_util::spawn_drone_v_formation(randomintrange(3, 6), "ambient_drone_formation_spline_right_tendril", randomfloatrange(300, 600));
    maps\blackout_util::spawn_drone_v_formation(randomintrange(3, 6), "ambient_drone_formation_spline_right_tendril", randomfloatrange(300, 600));
    vh_menendez_f38 waittill("reached_end_node");
    vh_menendez_f38.delete_on_death = 1;
    vh_menendez_f38 notify("death");

    if(!isalive(vh_menendez_f38))
      vh_menendez_f38 delete();

    wait_network_frame();
  }
}

menendez_fly_into_sunset() {
  vh_menendez_f38 = spawn_vehicle_from_targetname("F35");
  vh_menendez_f38 setspeed(randomfloatrange(400, 700), randomfloatrange(250, 350), randomfloatrange(250, 350));
  vh_menendez_f38 thread go_path(getvehiclenode("menendez_f38_sunset", "targetname"));
  return vh_menendez_f38;
}

dev_drones_ambience() {
  sea_cowbell();
  init_ambient_models();
  maps\blackout_util::init_ambient_oneoff_models("oneoff_ambient_ship_spot");
  maps\blackout_util::init_ambient_oneoff_models("drifting_ambient_ship_spot");
  maps\createart\blackout_art::vision_set_exterior_01();
}

setup_deck_phalanx_cannon_targets(delay) {
  if(isDefined(delay) && delay > 0)
    wait(delay);

  if(isDefined(level.is_briggs_alive) && level.is_briggs_alive) {
    add_global_spawn_function("axis", ::brute_force_kill_jetpacks);
    level thread maps\blackout_util::enable_phalanx_cannons("hackable_phalanx_cannon_spot", 1);
  }
}

setup_claw_bigdog() {
  ai_claw_1 = init_hero("claw_1");
  ai_claw_1.ignoreme = 1;
  wait 0.1;
  ai_claw_1.turretindependent = 1;
  level waittill("boot_up_claw");
  ai_claw_1.ignoreme = 0;
  ai_claw_1.turretindependent = 0;
  level.player maps\_fire_direction::init_fire_direction();
  level.player maps\_fire_direction::add_fire_direction_func(::claw_fire_direction_func);
  maps\_fire_direction::add_fire_direction_shooter(ai_claw_1);
  ai_claw_1 thread claw_pathing();
}

claw_fire_direction_func() {
  v_origin = self geteye();
  v_angles = anglestoforward(self getplayerangles());
  v_aim_pos = v_origin + v_angles * 8000;
  a_trace = bullettrace(v_origin, v_aim_pos, 0, self);
  v_shoot_pos = a_trace["position"];
  a_shooters = maps\_fire_direction::get_fire_direction_shooters();
  a_enemies = getaiarray("axis");

  foreach(ai_guy in a_enemies)
  ai_guy._fire_direction_targeted = undefined;

  if(a_shooters.size > 0)
    array_thread(a_shooters, ::_claw_fire_direction_grenades, v_shoot_pos);
}

_claw_fire_direction_grenades(v_position) {
  self endon("death");
  e_temp = spawn("script_origin", v_position);
  self.scripted_target = e_temp;
  self thread _claw_fire_guns_at_targets_in_range(v_position);

  for(i = 0; i < 3; i++) {
    v_start_pos = self gettagorigin("tag_turret");
    b_can_fire_safely = self _can_hit_target_safely(v_position, v_start_pos);

    if(b_can_fire_safely) {
      v_grenade_velocity = vectornormalize(v_position - v_start_pos) * 2000;
      self magicgrenadetype("claw_grenade_impact_explode_sp", v_start_pos, v_grenade_velocity);
    }

    wait 0.5;
  }

  self.turret maps\_turret::clear_turret_target();
  self.scripted_target = undefined;
  e_temp delete();
}

_claw_fire_guns_at_targets_in_range(v_position) {
  if(isDefined(level.vh_market_drone)) {
    if(level.player is_player_looking_at(level.vh_market_drone.origin, undefined, 0)) {
      self set_ignoreall(1);
      self thread _intro_claw_fire_turret(level.vh_market_drone, randomfloatrange(4.5, 6));
      wait 6;
      self set_ignoreall(0);

      if(isDefined(level.vh_market_drone))
        radiusdamage(level.vh_market_drone.origin, 500, 15000, 12000);
    }
  }

  a_enemies = getaiarray("axis");
  a_guys_within_range = get_within_range(v_position, a_enemies, 256);

  foreach(ai_guy in a_guys_within_range)
  ai_guy._fire_direction_targeted = 1;

  n_time = gettime();

  if(a_guys_within_range.size == 0) {
    e_temp = spawn("script_origin", v_position);
    self.turret maps\_turret::shoot_turret_at_target(e_temp, 5, (0, 0, 0));
    e_temp delete();
  } else {
    n_enemies_max = 3;
    n_cycles = 0;

    for(b_should_fire = 1; b_should_fire; b_should_fire = a_enemies.size > 0 && n_cycles < n_enemies_max) {
      ai_enemy = random(a_enemies);
      self.turret thread maps\_turret::shoot_turret_at_target(ai_enemy, 2, (0, 0, 0));
      ai_enemies = array_removedead(a_enemies);
      n_cycles++;
    }
  }
}

_intro_claw_fire_turret(e_target, n_time_to_fire, b_spinup) {
  str_turret = self.turret.weaponinfo;
  n_fire_time = weaponfiretime(str_turret);
  self.turret setturretspinning(1);

  if(!isDefined(b_spinup) || b_spinup == 1)
    wait 1.5;

  n_shots = int(n_time_to_fire / n_fire_time);

  for(i = 0; i < n_shots; i++) {
    if(isDefined(e_target)) {
      self.turret settargetentity(e_target);
      self.turret shootturret();

      level thread draw_line_for_time(self.turret.origin, e_target.origin, 1, 1, 1, n_fire_time);

    }

    wait(n_fire_time);
  }

  self.turret setturretspinning(0);
  self.turret maps\_turret::enable_turret();
}

_can_hit_target_safely(v_position, v_start_pos) {
  assert(isDefined(v_position), "v_position missing for _get_closest_unit_to_fire");
  a_shooters = maps\_fire_direction::get_fire_direction_shooters();
  assert(isDefined(a_shooters.size > 0), "no valid shooters found to use in _get_closest_unit_to_fire. Add these with add_fire_direction_shooter( <ent_that_can_shoot> ) first.");
  a_trace = bullettrace(v_start_pos, v_position, 0, self);
  b_can_hit_target = 1;
  b_will_hit_player = distance(a_trace["position"], level.player.origin) < 256;
  b_will_hit_self = distance(a_trace["position"], v_start_pos) < 256;
  b_will_hit_friendly = 0;
  a_friendlies = getaiarray("allies");

  for(j = 0; j < a_friendlies.size; j++) {
    b_could_hit_friendly = distance(a_trace["position"], a_friendlies[j].origin) < 256;

    if(b_could_hit_friendly)
      b_will_hit_friendly = 1;
  }

  v_to_player = vectornormalize(level.player.origin - v_start_pos);
  v_to_target = vectornormalize(v_position - v_start_pos);
  n_dot = vectordot(v_to_player, v_to_target);
  b_player_in_grenade_path = n_dot > 0.9;
  b_should_fire_grenades = b_can_hit_target && !b_will_hit_player && !b_will_hit_self && !b_will_hit_friendly && !b_player_in_grenade_path;
  return b_should_fire_grenades;
}

claw_shutdown() {
  level.player maps\_fire_direction::_fire_direction_kill();
}

claw_pathing() {
  self endon("death");
  nd_node = getnode("dt_node_1", "targetname");
  self.goalradius = 128;
  self setgoalnode(nd_node);
  self waittill("goal");

  while(isDefined(nd_node.target)) {
    while(true) {
      v_player_dir = vectornormalize(level.player.origin - self.origin);
      v_forward = anglestoforward(self.angles);
      dp = vectordot(v_player_dir, v_forward);

      if(dp > 0.1) {
        wait 0.01;
        break;
      }

      wait 0.1;
    }

    nd_node = getnode(nd_node.target, "targetname");
    self setgoalnode(nd_node);
    self waittill("goal");
    wait 0.5;
  }

}

notetrack_give_exit_enemy_weapon(ai_enemy) {
  ai_enemy custom_ai_weapon_loadout("xm8_sp", undefined, "fiveseven_sp");
  ai_enemy gun_switchto(ai_enemy.sidearm, "right");
  ai_enemy pmc_give_headmodel_without_mask();
}

notetrack_enemy_fires_at_crosby(ai_enemy) {
  ai_crosby = get_ent("crosby_ai", "targetname");
  v_start = ai_enemy gettagorigin("tag_flash");
  v_end = ai_crosby gettagorigin("J_Shoulder_LE");
  magicbullet("fiveseven_sp", v_start, v_end);
}

notetrack_crosby_gets_shot(ai_crosby) {
  playfxontag(level._effect["crosby_shot"], ai_crosby, "J_Shoulder_LE");
}

notetrack_outro_spawn_deck_enemies(m_player_body) {
  run_mason_deck_final_deck_attackers();
}

notetrack_outro_lookat_ship_1(m_player_body) {
  wait 6.5;
  _fire_outro_magic_bullet_at_bridge();
}

notetrack_outro_lookat_ship_2(m_player_body) {
}

notetrack_outro_lookat_ship_3(m_player_body) {
  wait 4.5;
  _fire_outro_magic_bullet_at_bridge();
}

_fire_outro_magic_bullet_at_bridge() {
  s_start = get_struct("outro_bridge_fire_struct", "targetname");
  s_end = get_struct("outro_bridge_fire_struct_target", "targetname");
  e_missile = magicbullet("avenger_missile_turret_blackout", s_start.origin, s_end.origin);
  e_missile waittill("death");
  earthquake(0.3, 0.5, s_end.origin, 1024);
  level.player playrumbleonentity("artillery_rumble");
}