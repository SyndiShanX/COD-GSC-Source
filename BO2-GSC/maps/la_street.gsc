/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_street.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_glasses;
#include maps\_music;
#include maps\_objectives;
#include maps\_scene;
#include maps\_turret;
#include maps\_vehicle;
#include maps\la_utility;
#include animscripts\anims;
#include animscripts\utility;
#include maps\_audio;
#include maps\la_1b_amb;
#include maps\_anim;
#include maps\_ammo_refill;
#include maps\_fire_direction;
#include maps\_quadrotor;

skipto_street() {
  if(!flag("harper_dead"))
    init_hero("harper");

  skipto_teleport("skipto_street");
  exploder(56);
  exploder(57);
  exploder(58);
  exploder(59);
  level.player.overrideplayerdamage = ::drone_player_damage_override;
}

main() {
  level.n_bdogs_killed = 0;

  if(!flag("harper_dead")) {
    init_hero("harper");
    level.harper.disable_blindfire = 1;
    level.harper thread street_harper_logic();
    level.obj_big_dogs = level.obj_big_dogs_harper;
  } else {
    level.obj_big_dogs = level.obj_big_dogs_noharper;
    level thread watch_bigdog_objective_noharper();
  }

  level.player.overrideplayerdamage = ::drone_player_damage_override;
  level thread spawn_ambient_drones("trig_street_flyby_1", "trig_street_flyby_4", "avenger_street_flyby_3", "f38_street_flyby_3", "start_street_flyby_3", 4, 1, 8, 9, 500);
  level thread spawn_ambient_drones("trig_street_flyby_4", undefined, "avenger_street_flyby_4", "f38_street_flyby_4", "start_street_flyby_4", 4, 1, 8, 10, 500);
  level thread spawn_ambient_drones(undefined, undefined, "avenger_street_flyby_4", "f38_street_flyby_4", "start_street_flyby_4", 1, 1, 8, 10, 500, 0, 1);
  level thread brute_force();
  level thread street_objectives();
  level thread street_ais();
  level thread street_vo();
  level thread street_elec_on_ground();
  level thread fxanim_debris();
  level thread semi_ammo_cache_think();
  level.supportspistolanimations = 1;
  add_spawn_function_veh("street_truck", ::street_veh_unload);
  level thread setup_street_middle();
  level thread street_fire_hydrant();
  level thread cougar_exit();
  level thread street_run_ahead_check();
  level thread player_out_of_bound();
  level thread player_skipped_claws();
  level thread street_quadrotors();
  level thread street_opitimizations();
  clear_the_street();
}

street_opitimizations() {
  a_cell_structs = getstructarray("plaza_cell", "targetname");

  foreach(struct in a_cell_structs)
  setcellinvisibleatpos(struct.origin);

  flag_wait("player_moved_down_the_street");

  foreach(struct in a_cell_structs)
  setcellvisibleatpos(struct.origin);
}

street_deathposes() {
  run_scene_first_frame("streetbody_01");
  run_scene_first_frame("streetbody_02");
  run_scene_first_frame("streetbody_06");
  run_scene_first_frame("streetbody_08");
  run_scene_first_frame("streetbody_14");
}

brute_force() {
  level thread brute_force_use();
  level.player waittill_player_has_brute_force_perk();
  level thread brute_force_fail();
}

street_objectives() {
  set_objective(level.obj_prom_night);
  set_objective(level.obj_prom_night, undefined, "deactivate");
  set_objective(level.obj_potus);
  set_objective(level.obj_potus, undefined, "deactivate");
  scene_wait("cougar_exit_player");
  set_objective(level.obj_street_regroup);
  wait 2.0;

  if(!flag("harper_dead"))
    set_objective(level.obj_follow, level.harper, "follow");

  flag_wait("bdog_front_spawned");
  set_objective(level.obj_follow, undefined, "delete");
  set_objective(level.obj_street_regroup, undefined, "deactivate");
  assert(isDefined(level.street_bdog_front));

  if(!flag("harper_dead"))
    set_objective(level.obj_big_dogs, undefined, undefined, level.n_bdogs_killed);

  set_objective(level.obj_big_dogs, level.street_bdog_front, "destroy", -1);
  flag_wait("bdog_back_spawned");
  delete_scene_all("cougar_exit");
  wait 5.0;
  set_objective(level.obj_big_dogs, level.street_bdog_back, "destroy", -1);
  level waittill("street_bdogs_killed");
  level thread turn_on_quad_sounds();
  setmusicstate("LA_1B_CLAW");
  set_objective(level.obj_big_dogs, undefined, "done");
  set_objective(level.obj_big_dogs, undefined, "delete");
  set_objective(level.obj_street_regroup, undefined, "reactivate");
  objective_breadcrumb(level.obj_street_regroup, "street_breadcrumb");
  set_objective(level.obj_street_regroup, undefined, "done");
}

street_harper_logic() {
  self.grenadeawareness = 0;
  trigger_wait("color_street_start_out");
  level notify("street_battle_started");
  waittill_ai_group_amount_killed("street_bdog", 1);
  level thread autosave_by_name("street_1_bdog_killed");
  level notify("street_1_bdog_killed");
  level notify("stop_street_anim_entries");
  flag_clear("police_in_hotel");
  waittill_ai_group_amount_killed("street_bdog", 2);
  level thread autosave_by_name("street_2_bdogs_killed");
  level notify("street_bdogs_killed");
  level thread street_kill_extra_enemies();
  self.perfectaim = 1;
  self street_harper_finish();
  self.goalradius = 64;
  self.fixednode = 1;
  self enable_ai_color();
  self.perfectaim = 0;
  trigger_use("plaza_color_start");
}

street_harper_finish() {
  a_street_ais = getaiarray("axis");

  while(a_street_ais.size > 0) {
    a_street_ais = getaiarray("axis");

    if(flag("fl_player_entered_plaza") && ai_group_get_num_killed("street_bdog") >= 2) {
      break;
    }

    wait 0.05;
  }

  level notify("street_cleared");
}

street_move_remaining_ais() {
  e_street_volume = getent("street_volume", "targetname");
  a_street_ais = getaiarray("axis");

  foreach(ai_street in a_street_ais) {
    if(ai_street.weapon != "dsr50_sp" && !ai_street is_rusher())
      ai_street setgoalvolumeauto(e_street_volume);
  }
}

street_kill_extra_enemies() {
  ai_stair_sniper = getent("street_sniper_stair_ai", "targetname");

  if(isalive(ai_stair_sniper))
    ai_stair_sniper bloody_death();

  a_generic_ai = getentarray("street_generic_ai", "targetname");

  foreach(ai_generic in a_generic_ai) {
    if(isalive(ai_generic))
      ai_generic bloody_death();
  }

  a_enemy_ais = getaiarray("axis");

  while(a_enemy_ais.size > 6)
    wait 0.05;

  level notify("end_enemy_street_vo");
}

street_ais() {
  level thread enemy_on_top_of_metro();
  level thread street_ai_begin();
  level thread street_ai_spawn_funcs();
  level thread street_train_surprise();
  level thread street_snipers();
  level thread street_anim_entries();
  level thread street_bdogs();
}

street_ai_begin() {
  trigger_wait("color_street_start_out");
  trigger_use("sm_street_cross_1");
  ai_sniper_stair = simple_spawn_single("street_sniper_stair");
  ai_sniper_stair force_goal(undefined, 16, 0);
  ai_cross_0 = simple_spawn_single("street_cross_0");
  ai_cross_0 force_goal(undefined, 16);
  ai_dive = simple_spawn_single("street_dive");
  ai_dive force_goal(undefined, 16, 0);
}

watch_bigdog_objective_noharper() {
  flag_wait("bdog_noharper_dead");
  flag_wait("bdog_back_dead");
  flag_wait("bdog_front_dead");
  level thread autosave_by_name("street_3_bdogs_killed");
  level notify("street_bdogs_killed");
}

street_bdogs() {
  sp_street_bdog_front = getent("bdog_front", "targetname");
  sp_street_bdog_front add_spawn_function(::street_claw, ::street_claw_front, 1);
  sp_street_bdog_back = getent("bdog_back", "targetname");
  sp_street_bdog_back add_spawn_function(::street_claw, ::street_claw_back, 1);
}

street_claw(func_logic, attack_player) {
  wait_network_frame();
  self thread street_claw_vo_grenade();

  if(isDefined(attack_player) && attack_player)
    self.favoriteenemy = level.player;

  if(isDefined(func_logic))
    self thread[[func_logic]]();

  self waittill("death");
  level.n_bdogs_killed++;
  set_objective(level.obj_big_dogs, self, "remove");
  set_objective(level.obj_big_dogs, undefined, undefined, level.n_bdogs_killed);
}

cougar_exit_claw_noharper() {
  s_moveto_1 = getstruct("claw_harper_dead_pos_1", "targetname");
  s_moveto_2 = getstruct("claw_harper_dead_pos_2", "targetname");
  wait 12;
  ai_claw = simple_spawn_single("claw_harper_dead");
  ai_claw.goalradius = 32;
  ai_claw.fixednode = 0;
  ai_claw.deathfunction = ::claw_noharper_track_death;
  ai_claw thread cougar_exit_claw_noharper_obj();
  level thread claw_noharper_lapd_cop_logic();
  ai_claw endon("death");
  flag_set("bdog_noharper_spawned");
  ai_claw thread street_claw();
  self.favoriteenemy = undefined;
  ai_claw setgoalpos(s_moveto_1.origin);
  ai_claw waittill("goal");
  ai_claw setgoalpos(s_moveto_2.origin);
  ai_claw waittill("goal");
  flag_set("bdog_noharper_moved_down_street");
  level.cop_1 disable_ai_color();
  level.cop_2 disable_ai_color();
  e_front_volume = getent("bdog_noharper_cover_front_volume_1", "targetname");
  ai_claw setgoalvolumeauto(e_front_volume);
  flag_wait("bdog_cover_back");
  e_front_volume = getent("bdog_cover_front_volume_1", "targetname");
  ai_claw setgoalvolumeauto(e_front_volume);
}

cougar_exit_claw_noharper_obj() {
  scene_wait("cougar_exit_player");
  wait 3.5;
  set_objective(level.obj_big_dogs, undefined, undefined, level.n_bdogs_killed);
  set_objective(level.obj_big_dogs, self, "destroy", -1);
}

claw_noharper_lapd_cop_logic() {
  flag_wait("street_cops_arrived");
  level thread claw_noharper_lapd_cop_logic_color();
  wait 2.5;
  level.cop_2 queue_dialog("lpd3_they_ve_got_combat_r_0");
  wait 2.5;
  level.cop_1 queue_dialog("lpd3_how_do_you_stop_that_0");
}

claw_noharper_lapd_cop_logic_color() {
  level.cop_1.color_before_noharper_claw = level.cop_1 get_force_color();
  level.cop_2.color_before_noharper_claw = level.cop_2 get_force_color();
  level.cop_1 set_force_color("p");
  level.cop_2 set_force_color("p");
  trigger_use("claw_no_harper_lapd_trig");
  flag_wait("bdog_noharper_moved_down_street");
  level.cop_1 set_force_color(level.cop_1.color_before_noharper_claw);
  level.cop_2 set_force_color(level.cop_2.color_before_noharper_claw);
}

claw_noharper_track_death() {
  flag_set("bdog_noharper_dead");
  flag_set("bdog_noharper_moved_down_street");
  level thread autosave_by_name("claw_noharper_death");
}

street_claw_front() {
  self endon("death");
  self thread set_flag_on_notify("wounded", "bdog_front_wounded");
  self thread set_flag_on_notify("immobilized", "bdog_front_immobilized");
  self thread set_flag_on_notify("death", "bdog_front_dead");
  level thread street_claw_front_vo();
  level.street_bdog_front = self;
  self.deathfunction = ::claw_front_track_death;
  flag_set("bdog_front_spawned");
  self.goalradius = 32;
  self.fixednode = 0;
  nd_street_middle = getnode("street_middle", "targetname");
  self setgoalnode(nd_street_middle);
  self waittill("goal");
  e_bdog_front_volume_1 = getent("bdog_cover_front_volume_1", "targetname");
  e_bdog_front_volume_2 = getent("bdog_cover_front_volume_2", "targetname");
  e_bdog_move_back = getent("bdog_cover_back", "targetname");
  self setgoalvolumeauto(e_bdog_front_volume_1);
  flag_wait("bdog_cover_back");
  self setgoalvolumeauto(e_bdog_front_volume_2);
}

claw_front_track_death() {
  flag_set("bdog_front_dead");
  setmusicstate("LA_1B_STREET_CLAW_DEAD");

  if(!flag("bdog_front_dead_friendlies_moved") && flag("bdog_front_claw_friendlies_moved"))
    trigger_use("bdog_front_dead_friendlies_move");

  level thread autosave_by_name("claw_front_death");
}

street_claw_front_vo() {
  if(!flag("harper_dead")) {
    level.harper priority_dialog("harp_finish_it_0", 0, "bdog_front_immobilized", "bdog_front_dead");
    level.harper priority_dialog("harp_another_explosive_ro_0", 0, "bdog_front_immobilized", "bdog_front_dead");
    level.player priority_dialog("fuck_you_042", 1, "bdog_front_dead");
  }
}

street_claw_back(takes_in_route) {
  self endon("death");
  self thread set_flag_on_notify("wounded", "bdog_back_wounded");
  self thread set_flag_on_notify("immobilized", "bdog_back_immobilized");
  self thread set_flag_on_notify("death", "bdog_back_dead");
  level thread street_claw_back_vo();
  level.street_bdog_back = self;
  self.deathfunction = ::claw_back_track_death;
  flag_set("bdog_back_spawned");
  self.goalradius = 32;
  self.fixednode = 0;
  nd_street_middle = getnode("claw_back_start_node", "targetname");
  self setgoalnode(nd_street_middle);
  self waittill("goal");
  e_bdog_back_volume = getent("bdog_back_cover_back_vol", "targetname");
  self setgoalvolumeauto(e_bdog_back_volume);
}

claw_back_track_death() {
  flag_set("bdog_back_dead");
  flag_wait("bdog_front_claw_friendlies_moved");

  if(!flag("bdog_back_dead_friendlies_moved_to_plaza"))
    trigger_use("bdog_back_dead_move_friendlies_to_plaza");

  level thread autosave_by_name("claw_back_death");
}

street_claw_back_vo() {
  if(!flag("harper_dead")) {
    level.harper priority_dialog("harp_stay_on_him_section_0", 1, "bdog_back_wounded", array("bdog_back_immobilized", "bdog_back_dead"));
    level.player priority_dialog("these_bastards_are_018", 1, "bdog_back_wounded", array("bdog_back_immobilized", "bdog_back_dead"));
    level.harper priority_dialog("its_damaged_h_fin_020", 1, "bdog_back_immobilized", "bdog_back_dead");
    level.player priority_dialog("go_down_dammit_021", 0, "bdog_back_immobilized", "bdog_back_dead");
    level.player priority_dialog("fuck_yeah_022", 1, "bdog_back_dead");
    level.player priority_dialog("nice_work_023", 0, "bdog_back_dead");
  }
}

street_snipers() {
  trigger_wait("sm_street_back");
  ai_sniper = simple_spawn_single("street_snipers");
}

street_train_surprise() {
  t_sm_street_back = getent("sm_street_back", "targetname");
  t_sm_street_back endon("trigger");
  trigger_wait("trig_street_train_surprise");
  run_scene("train_surprise_attack");
}

street_anim_entries() {
  add_spawn_function_group("guy_pipe_1", "targetname", ::set_force_ragdoll);
  add_spawn_function_group("guy_ladder_2", "targetname", ::set_force_ragdoll);
  level endon("stop_street_anim_entries");
  trigger_wait("color_street_start_out");
  level thread street_hotdog_cart();
  level thread run_scene("pipe_entry_1");
  level thread run_scene("ladder_entry_2");
  wait 0.05;
  scene_wait("ladder_entry_2");
  sp_generic = getent("street_generic", "targetname");
  a_str_scenes = array("ladder_entry_1", "pipe_entry_2");

  while(sp_generic.count > 0) {
    n_rand_wait = randomintrange(1, 3);
    wait(n_rand_wait);
    str_scene = random(a_str_scenes);
    ai_generic = simple_spawn_single("street_generic", ::set_force_ragdoll);
    ai_generic endon("death");
    add_generic_ai_to_scene(ai_generic, str_scene);
    flag_set("someone_near_hotel");

    if(randomint(2) == 0)
      ai_generic thread queue_dialog("pmc0_they_re_in_the_killz_0");

    run_scene(str_scene);
    flag_clear("someone_near_hotel");

    if(isalive(ai_generic))
      ai_generic force_goal(undefined, 16);
  }
}

set_force_ragdoll() {
  self.a.deathforceragdoll = 1;
}

street_hotdog_cart() {
  m_cart = getent("hot_dog_cart_push", "script_noteworthy");
  m_cart_dyn_path = getent("cart_dynamic_path", "targetname");
  m_cart_dyn_path linkto(m_cart);
  m_cart thread street_cart_listener();
  level thread run_scene("cart_push");
  flag_wait("cart_push_started");
  m_cart_dyn_path connectpaths();
  ai_cart_1 = getent("guy_push_cart_1_ai", "targetname");
  ai_cart_1 thread street_cart_vo();
  ai_cart_1 waittill("death");
  level notify("street_cart_guy_died");
  end_scene("cart_push");
  m_cart_dyn_path disconnectpaths();
  ai_cart_2 = getent("guy_push_cart_2_ai", "targetname");

  if(isalive(ai_cart_2))
    ai_cart_2 queue_dialog("pmc0_they_re_in_the_killz_0");
}

street_cart_listener() {
  level endon("street_cart_guy_died");
  scene_wait("cart_push");
  m_cart_dyn_path = getent("cart_dynamic_path", "targetname");
  m_cart_dyn_path disconnectpaths();
}

street_cart_vo() {
  self endon("death");
  level waittill("street_battle_start_vo_done");
  level.cop_2 queue_dialog("pmc0_they_re_in_the_killz_0");
}

street_ai_spawn_funcs() {
  a_street_truck_guys = getentarray("street_truck_guy", "targetname");
  array_thread(a_street_truck_guys, ::add_spawn_function, ::force_goal, undefined, 16);
  a_street_cross_1 = getentarray("sm_street_cross_1", "targetname");
  array_thread(a_street_cross_1, ::add_spawn_function, ::force_goal, undefined, 16);
  a_street_inside = getentarray("street_inside", "targetname");
  array_thread(a_street_inside, ::add_spawn_function, ::force_goal, undefined, 16);
  a_street_back = getentarray("street_back", "targetname");
  array_thread(a_street_back, ::add_spawn_function, ::force_goal, undefined, 16);
  a_street_train_inside = getentarray("street_train_inside", "targetname");
  array_thread(a_street_train_inside, ::add_spawn_function, ::force_goal, undefined, 16);
  a_street_cross_inside = getentarray("street_cross_inside", "targetname");
  array_thread(a_street_cross_inside, ::add_spawn_function, ::force_goal, undefined, 16, 0);
  trigger_use("sm_street_ambush_outside");
}

steet_ambush_outside_spawn_func() {
  self endon("death");
  self force_goal(undefined, 16, 1);
  n_old_goalradius = self.goalradius;
  e_cougar_window = getent("target_window", "targetname");
  wait 0.05;
  self.perfectaim = 1;
  self.goalradius = 16;
  self thread shoot_at_target(e_cougar_window, undefined, undefined, -1);
  level waittill("street_battle_started");
  self.goalradius = n_old_goalradius;
  self.perfectaim = 0;
  self stop_shoot_at_target();
}

enemy_on_top_of_metro() {
  level endon("street_bdogs_killed");
  trigger_wait("color_street_start_out");
  ai_climber = simple_spawn_single("street_traverse_first");
  total_metro_guys = 0;

  while(total_metro_guys < 4) {
    ai_climber = find_metro_climber();
    total_metro_guys++;

    if(isDefined(ai_climber))
      ai_climber thread move_on_top_of_metro();

    wait 3;
  }
}

find_metro_climber() {
  ai_climber = undefined;
  a_enemy_ais = getaiarray("axis");

  foreach(n_key, ai_enemy in a_enemy_ais) {
    if(isDefined(ai_enemy.aigroup) && ai_enemy.aigroup == "street_bdog") {
      a_enemy_ais[n_key] = undefined;
      continue;
    }

    if(ai_enemy is_rusher()) {
      a_enemy_ais[n_key] = undefined;
      continue;
    }

    if(ai_enemy.weapon == "dsr50_sp")
      a_enemy_ais[n_key] = undefined;
  }

  arrayremovevalue(a_enemy_ais, undefined);

  if(a_enemy_ais.size > 0) {
    n_dist_sq_longest = distancesquared(level.player.origin, a_enemy_ais[0].origin);
    ai_climber = a_enemy_ais[0];

    foreach(ai_potential_climber in a_enemy_ais) {
      if(ai_potential_climber.origin[2] < 100) {
        n_dist_sq_between = distancesquared(level.player.origin, ai_potential_climber.origin);

        if(n_dist_sq_between > n_dist_sq_longest) {
          n_dist_sq_longest = n_dist_sq_between;
          ai_climber = ai_potential_climber;
        }
      }
    }
  }

  return ai_climber;
}

move_on_top_of_metro() {
  self endon("death");
  self.goalradius = 128;
  nd_train_top = getnodearray("node_train_top", "script_noteworthy");
  current_node = nd_train_top[randomintrange(0, nd_train_top.size)];
  next_node = nd_train_top[randomintrange(0, nd_train_top.size)];

  while(true) {
    self setgoalnode(current_node);
    self waittill("goal");
    wait(randomintrange(2, 4));
    self setgoalnode(next_node);
    self waittill("goal");
  }
}

cougar_exit() {
  screen_fade_out(0);
  run_scene_first_frame("cougar_exit_player");
  level thread do_pip1();
  level thread street_shellshock_and_visionset();
  setmusicstate("LA_1B_INTRO");
  level thread maps\_audio::switch_music_wait("LA_1B_INTRO_B", 22);
  clientnotify("int_st");
  level notify("force_verb");
  level.enable_cover_warning = 0;
  wait 6;
  level thread cougar_exit_player();
  level thread cougar_exit_cop_car();
  cougar_exit_everything_else();
  level thread autosave_by_name("street_start");
  level.enable_cover_warning = 1;
}

do_pip1() {
  flag_set("pip_playing");
  thread maps\_glasses::play_bink_on_hud("la_pip_seq_1", 0, 0);
  flag_wait("glasses_bink_playing");
  level.player priority_dialog("samu_g_units_blue_route_0");
  level.player priority_dialog("samu_all_convoys_need_to_0");
  level.player priority_dialog("sect_we_ll_find_a_way_thr_0");
  flag_clear("pip_playing");
}

cougar_exit_player() {
  level notify("radio_start_wakeup");
  level.player playsound("evt_cougar_exit");
  level thread run_scene("cougar_exit_player");
  flag_wait("cougar_exit_player_started");
  m_18_wheeler_clip = getent("street_truck_collision", "targetname");
  m_18_wheeler_clip connectpaths();
  m_18_wheeler_clip notsolid();
  level thread maps\la_1b_amb::force_snapshot_wait();
  wait 16;
  wait 18.4;
}

cougar_exit_cop_car() {
  level thread street_spawn_scripted_cop_car();
  m_ce_cop_car = getent("ce_cop_car", "script_noteworthy");
  m_ce_cop_car thread police_car();
  level thread run_scene("cougar_exit_cop_car");
  level waittill("cop_car_skid_done");
  wait 3;
  m_ce_cop_car play_fx("ce_dest_cop_car_fx", m_ce_cop_car.origin, m_ce_cop_car.angles, 4.5, 1, "body_animate_jnt");
  run_scene("ce_fxanim_cop_car");
  level thread run_scene("ce_fxanim_cop_car_explode");
  m_ce_cop_car setmodel("veh_t6_police_car_destroyed");
  playfxontag(getfx("car_explosion"), m_ce_cop_car, "tag_origin");
  m_ce_cop_car notify("death");
}

cop_car_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  m_ce_cop_car = getent("ce_cop_car", "script_noteworthy");

  if(isDefined(e_inflictor) && isDefined(m_ce_cop_car) && m_ce_cop_car == e_inflictor)
    return 50;

  return n_damage;
}

street_spawn_scripted_cop_car() {
  wait 28;
  trigger_use("street_cop_car_entry");
  wait 1;
  vh_cop_car = getent("street_police_car", "targetname");
  vh_cop_car thread police_car();
  vh_cop_car thread play_police_pullup();
  vh_cop_car veh_magic_bullet_shield(1);
  level.cop_1 = simple_spawn_single("street_cop_1");
  level.cop_1.grenadeawareness = 0;
  level.cop_1 magic_bullet_shield();
  level.cop_1.name = "Officer Janssen";
  level.cop_2 = simple_spawn_single("street_cop_2");
  level.cop_2.grenadeawareness = 0;
  level.cop_2 magic_bullet_shield();
  level.cop_2.name = "Officer Barnes";
  trigger_wait("player_moved_down_the_street");
  vh_cop_car veh_magic_bullet_shield(0);
  vh_cop_car dodamage(vh_cop_car.health, vh_cop_car.origin, undefined, undefined, "riflebullet");
}

play_police_pullup() {
  self thread play_pullup_arrival_sound();
  self waittill("reached_end_node");
  flag_set("street_cops_arrived");
}

play_pullup_arrival_sound() {
  self endon("death");
  self waittill("play_arrive_sound");
  playsoundatposition("evt_la_1_police_drive_up", (0, 0, 0));
}

cougar_exit_everything_else() {
  m_cougar_shadow_prop = getent("cougar_shadow_prop", "targetname");
  m_cougar_shadow_prop delete();
  m_cougar_interior = getent("interior_cougar_exit", "targetname");
  m_cougar_interior attach("veh_t6_mil_cougar");
  m_cougar_interior hidepart("tag_windshield");
  m_cougar_interior showpart("tag_windshield_d2");
  m_cougar_interior play_fx("cougar_monitor", undefined, undefined, -1, 1, "tag_fx_monitor");
  level thread run_scene("cougar_exit");
  level thread run_scene("cougar_exit_bigrig");

  if(!flag("harper_dead")) {
    level.harper attach("t6_wpn_special_storm_world", "tag_weapon_left");
    level.harper maps\_anim::anim_set_blend_out_time(0.3);
    level thread run_scene("cougar_exit_interior");
    level thread run_scene("cougar_exit_claw");
    level thread run_scene("cougar_exit_harper");
    flag_set("bdog_noharper_dead");
  } else {
    level thread run_scene("cougar_exit_interior_noharper");
    level thread cougar_exit_claw_noharper();
    level.player enableinvulnerability();
  }

  flag_wait("cougar_exit_started");
  vh_wheeler = get_model_or_models_from_scene("cougar_exit_bigrig", "wheeler_cougar_exit");
  vh_wheeler ignorecheapentityflag(1);
  vh_f35_cougar_exit = get_model_or_models_from_scene("cougar_exit", "f35_cougar_exit");
  vh_f35_cougar_exit veh_magic_bullet_shield(1);
  vh_f35_cougar_exit thread f35_vtol_spawn_func();
  m_cop_car_1 = get_model_or_models_from_scene("cougar_exit", "ce_car_1");
  m_cop_car_1 thread police_car();
  m_cop_car_2 = get_model_or_models_from_scene("cougar_exit", "ce_car_2");
  m_cop_car_2 thread police_car();
  m_ce_bike_1 = get_model_or_models_from_scene("cougar_exit", "ce_bike_1");
  m_ce_bike_1 thread police_motorcycle();
  m_ce_bike_2 = get_model_or_models_from_scene("cougar_exit", "ce_bike_2");
  m_ce_bike_2 thread police_motorcycle();
  m_ce_bike_3 = get_model_or_models_from_scene("cougar_exit", "ce_bike_3");
  m_ce_bike_3 thread police_motorcycle();
  ai_ce_cop_2 = getent("ce_cop_2_ai", "targetname");
  ai_ce_cop_2.name = "";
  level thread maps\_audio::switch_music_wait("LA_1B_STREET", 30);

  if(!flag("harper_dead")) {
    scene_wait("cougar_exit_harper");
    end_scene("cougar_exit_harper");
    level.harper detach("t6_wpn_special_storm_world", "tag_weapon_left");
  } else {
    scene_wait("cougar_exit_player");
    level.player disableinvulnerability();
  }

  spawn_model("veh_t6_mil_cougar", m_cougar_interior.origin, m_cougar_interior.angles);
  m_cougar_interior delete();
}

harper_fire_sniperstorm(ai_harper) {
  playfxontag(getfx("ce_harper_muzflash"), ai_harper, "tag_weapon_left");
}

intersection_osprey() {
  trigger_wait("intersection_osprey_trig");
  wait 0.2;
  intersection_osprey = getent("intersection_osprey", "targetname");
  intersection_osprey veh_magic_bullet_shield();
  intersection_osprey waittill("reached_end_node");
  intersection_osprey veh_magic_bullet_shield(0);
  intersection_osprey.delete_on_death = 1;
  intersection_osprey notify("death");

  if(!isalive(intersection_osprey))
    intersection_osprey delete();
}

clear_the_street() {
  m_clip = getent("street_truck_collision", "targetname");
  m_car_clip = getent("street_police_collision", "targetname");
  m_clip connectpaths();
  m_clip notsolid();
  m_car_clip solid();
  m_car_clip disconnectpaths();
  run_scene_first_frame("clear_the_street", 1);
  flag_wait("fl_clear_the_street");
  clientnotify("fbsoff");
  m_car_clip connectpaths();
  m_car_clip notsolid();
  level thread run_scene("clear_the_street_ter");
  level thread run_scene("clear_street_ter_semi");
  level thread setup_clear_the_street_ai();
  level thread run_scene("clear_the_street");
  m_clip solid();
  m_clip disconnectpaths();
  simple_spawn_single("bdog_back");
}

setup_clear_the_street_ai() {
  wait 0.1;
  e_clear_street1 = get_ais_from_scene("clear_the_street_ter", "ter_clear_the_street");

  if(isalive(e_clear_street1))
    e_clear_street1 disable_long_death();

  a_clear_street = get_ais_from_scene("clear_street_ter_semi");

  foreach(clear_guy in a_clear_street) {
    if(isalive(clear_guy)) {
      self.goalradius = 512;

      if(isDefined(self.target))
        clear_guy setgoalnode(getnode(self.target, "targetname"));

      clear_guy disable_long_death();
    }
  }
}

brute_force_use() {
  level endon("brute_force_fail");
  run_scene_first_frame("brute_force_cougar");
  m_bruteforce_cougar = getent("bruteforce_cougar", "targetname");
  m_bruteforce_cougar setmodel("veh_t6_mil_cougar_low_dead");
  trigger_off("t_brute_force_use", "targetname");
  level.player waittill_player_has_brute_force_perk();
  t_perk_use = getent("t_brute_force_use", "targetname");
  t_perk_use setcursorhint("HINT_NOICON");
  t_perk_use sethintstring(&"SCRIPT_HINT_BRUTE_FORCE");
  trigger_on("t_brute_force_use", "targetname");
  s_brute_force_pos = getstruct("brute_force_use_pos", "targetname");
  set_objective_perk(level.obj_brute_perk, s_brute_force_pos);
  trigger_wait("t_brute_force_use");
  remove_objective_perk(level.obj_brute_perk);
  level notify("brute_force_done");
  level thread run_scene_and_delete("brute_force_player");
  level thread run_scene_and_delete("brute_force_cougar");
}

brute_force_fail() {
  level endon("brute_force_done");
  flag_wait("plaza_enter");
  flag_set("brute_force_fail");
  remove_objective_perk(level.obj_brute_perk);
  trigger_off("t_brute_force_use", "targetname");
  m_brute_force_cougar = getent("bruteforce_cougar", "targetname");
  m_brute_force_cougar playsound("exp_armor_vehicle");
  playfxontag(level._effect["brute_force_explosion"], m_brute_force_cougar, "tag_origin");
}

semi_ammo_cache_think() {
  a_semi_caches = getentarray("semi_ammo_cache", "script_noteworthy");

  foreach(m_cache in a_semi_caches)
  m_cache hide();

  flag_wait("fl_clear_the_street");
  wait 5;

  foreach(m_cache in a_semi_caches) {
    m_cache show();
    m_cache maps\_ammo_refill::_setup_ammo_cache();
  }
}

street_spawn_bdog_middle(delay_s) {
  wait(delay_s);
  simple_spawn_single("bdog_front");
}

street_veh_unload() {
  self endon("death");
  self waittill_notify_or_timeout("brake", 6);
  self playsound("evt_van_incoming");
  level notify("white_truck");

  while(self getspeedmph() > 0)
    wait 0.05;

  m_fire_hydrant = getent("truck_hydrant", "script_noteworthy");
  m_fire_hydrant dodamage(m_fire_hydrant.health, m_fire_hydrant.origin, undefined, undefined, "riflebullet");
  m_fire_hydrant dodamage(m_fire_hydrant.health, m_fire_hydrant.origin, undefined, undefined, "riflebullet");
}

setup_street_middle() {
  street_trigger = getent("street_truck_entry", "targetname");
  street_trigger waittill("trigger");
  level thread street_spawn_bdog_middle(2.5);
  wait 6;
  m_18_wheeler_clip = getent("street_truck_collision", "targetname");
  m_18_wheeler_clip solid();
  m_18_wheeler_clip disconnectpaths();
}

delete_vehicle_on_notify(str_notify) {
  self endon("death");
  self waittill(str_notify);
  self delete();
}

street_elec_on_ground() {
  t_street_push_back = getent("street_push_back", "targetname");

  while(true) {
    if(level.player istouching(t_street_push_back)) {
      v_velocity = level.player getvelocity();
      level.player setvelocity(v_velocity + vectorscale((-1, 0, 0), 600.0));
      level.player dodamage(40, t_street_push_back.origin);
    }

    wait 0.05;
  }
}

street_fire_hydrant() {
  m_fire_hydrant = getent("street_hydrant", "script_noteworthy");
  n_player_fov = getdvarfloat(#"cg_fov");
  n_cos_player_fov = cos(n_player_fov);
  level waittill("street_battle_started");

  for(n_fh_dist_from_player = distance2dsquared(m_fire_hydrant.origin, level.player.origin); !level.player is_player_looking_at(m_fire_hydrant.origin, 1) && n_fh_dist_from_player > 65536; n_fh_dist_from_player = distance2dsquared(m_fire_hydrant.origin, level.player.origin))
    wait 0.05;

  m_fire_hydrant dodamage(m_fire_hydrant.health, m_fire_hydrant.origin, undefined, undefined, "riflebullet");

  while(!level.player is_player_looking_at(m_fire_hydrant.origin, 0.01) && n_fh_dist_from_player > 65536)
    wait 0.05;

  m_fire_hydrant dodamage(m_fire_hydrant.health, m_fire_hydrant.origin, undefined, undefined, "riflebullet");
}

fxanim_debris() {
  trigger_wait("fxanim_debris_1");
  level notify("fxanim_debris_layer_2_start");
  trigger_wait("fxanim_debris_2");
  level notify("fxanim_debris_layer_1_start");
  level notify("fxanim_debris_layer_3_start");
  trigger_wait("t_street_done");
  level notify("fxanim_drone_chunks_start");
}

street_run_ahead_check() {
  level endon("street_bdogs_killed");
  trigger_wait("t_street_done");
  drone_shoot_at_player();
}

player_skipped_claws() {
  trigger_wait("player_near_plaza");

  if(!flag("bdog_noharper_dead") || !flag("bdog_front_dead") || !flag("bdog_back_dead"))
    drone_shoot_at_player_skipped_claws();
}

drone_shoot_at_player_skipped_claws() {
  level.player disableinvulnerability();
  level.player enablehealthshield(0);
  nd_start = getvehiclenode("drone_kill_player_path_claw", "targetname");
  vh_drone = spawn_vehicle_from_targetname("avenger_fast");
  vh_drone.origin = nd_start.origin;
  vh_drone.angles = nd_start.angles;
  vh_drone setforcenocull();
  vh_drone thread delete_vehicle_on_notify("delete_vehicle");
  vh_drone thread go_path(nd_start);
  vh_drone thread shoot_turret_at_target(level.player, -1, undefined, 0);
  vh_drone waittill("shoot_player");
  vh_drone thread shoot_turret_at_target(level.player, -1, undefined, 1);
  vh_drone thread shoot_turret_at_target(level.player, -1, undefined, 2);
}

player_out_of_bound() {
  trigger_wait("out_of_bound");
  drone_shoot_at_player();
}

drone_shoot_at_player() {
  level.player disableinvulnerability();
  level.player enablehealthshield(0);
  nd_start = getvehiclenode("drone_kill_player_path", "targetname");
  vh_drone = spawn_vehicle_from_targetname("avenger_fast");
  vh_drone.origin = nd_start.origin;
  vh_drone.angles = nd_start.angles;
  vh_drone setforcenocull();
  vh_drone thread delete_vehicle_on_notify("delete_vehicle");
  vh_drone thread go_path(nd_start);
  vh_drone thread shoot_turret_at_target(level.player, -1, undefined, 0);
  vh_drone waittill("shoot_player");
  vh_drone thread shoot_turret_at_target(level.player, -1, undefined, 1);
  vh_drone thread shoot_turret_at_target(level.player, -1, undefined, 2);
  wait 1;
  level.player suicide();
}

drone_player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  if(isDefined(e_inflictor.classname) && e_inflictor.classname == "script_vehicle") {
    if(e_inflictor.vehicletype == "heli_quadrotor") {
      if(isDefined(e_inflictor.team) && e_inflictor.team == "allies")
        n_damage = 0;
      else
        n_damage = n_damage * 2;
    }
  }

  return n_damage;
}

street_vo() {
  level thread vo_first_claw();
  level thread vo_claw_grenade();
  level thread vo_white_truck();
  level thread vo_semi_truck();
  level thread vo_more_enemies();
  scene_wait("cougar_exit");
  level thread vo_lapd_street();
  level thread street_vo_lapd_callouts();
  level thread street_vo_pmc_callouts();

  if(!flag("harper_dead")) {
    level.harper queue_dialog("it_was_a_fucking_a_013");
    level.harper queue_dialog("harp_we_got_mercs_moving_0");
  }

  flag_wait("bdog_front_spawned");
  level thread vo_second_claw();
  level.player queue_dialog("dammit_theyve_go_014", 0);

  if(!flag("harper_dead")) {
    level.harper queue_dialog("harp_it_s_armor_s_tough_0", 0, undefined, "bdog_front_dead");
    level.harper queue_dialog("harp_if_you_ve_got_an_exp_0", 0, undefined, "bdog_front_dead");
    level.harper queue_dialog("harp_watch_the_grenades_0", 1, undefined, "bdog_front_dead");
  }
}

vo_first_claw() {
  flag_wait("start_claw_vo");
  queue_dialog_ally("lpd2_get_down_it_s_got_0", 1);
  queue_dialog_ally("lpd3_they_ve_got_combat_r_0", 2);
  queue_dialog_ally("lpd2_go_for_the_legs_0", 2);
}

vo_second_claw() {
  queue_dialog_ally("lpd2_stay_down_those_ro_0", 1);
  queue_dialog_ally("lpd1_where_the_hell_did_t_0", 2);
}

vo_third_claw() {
  queue_dialog_ally("lpd3_where_the_hell_are_t_0", 1);
}

vo_claw_grenade() {
  flag_wait("claw_grenade");
  queue_dialog_ally("lpd2_watch_it_grenades_0", 2);
  flag_clear("claw_grenade");
  flag_wait("claw_grenade");
  queue_dialog_ally("stay_back_h_its_f_035", 2);
  flag_clear("claw_grenade");
  flag_wait("claw_grenade");
  queue_dialog_ally("lpd3_stay_back_it_s_fir_0", 2);
}

vo_semi_truck() {
  level waittill("white_truck");
  queue_dialog_ally("lpd1_we_re_outnumbered_0", 1);
}

vo_white_truck() {
  trigger_wait("street_truck_entry");
  level.cop_1 say_dialog("lpd1_white_truck_end_of_0", 2);
}

vo_more_enemies() {
  flag_wait("bdog_cover_back");
  queue_dialog_ally("lpd1_dammit_we_re_compl_0", 2);
}

vo_lapd_street() {
  add_vo_to_nag_group("lapd_street", level.cop_1, "lpd1_dammit_i_m_nearly_0");
  add_vo_to_nag_group("lapd_street", level.cop_2, "get_in_cover_h_ret_005");
  add_vo_to_nag_group("lapd_street", level.cop_1, "lpd3_get_me_out_of_here_0");
  add_vo_to_nag_group("lapd_street", level.cop_2, "hold_them_back_006");
  add_vo_to_nag_group("lapd_street", level.cop_1, "lpd1_how_the_hell_do_we_c_0");
  add_vo_to_nag_group("lapd_street", level.cop_2, "lpd2_call_it_in_0");
  add_vo_to_nag_group("lapd_street", level.cop_1, "lpd2_get_in_cover_retur_0");
  add_vo_to_nag_group("lapd_street", level.cop_2, "lpd3_watch_your_zone_wa_0");
  add_vo_to_nag_group("lapd_street", level.cop_1, "lpd2_give_them_cover_0");
  add_vo_to_nag_group("lapd_street", level.cop_2, "lpd1_reloading_0");
  add_vo_to_nag_group("lapd_street", level.cop_1, "lpd1_they_re_comin_at_us_0");
  level thread start_vo_nag_group_flag("lapd_street", "ok_to_drop_building", randomfloatrange(3.0, 6.0));
}

street_vo_lapd_callouts() {
  a_vo_callouts = [];
  a_vo_callouts["bus_stop"] = array("lpd1_behind_the_bus_stop_0");
  a_vo_callouts["food_cart"] = array("lpd3_behind_the_cart_0");
  a_vo_callouts["van"] = array("by_the_van_018");
  a_vo_callouts["in_hotel"] = array("lpd1_ground_floor_they_r_0", "lpd3_left_side_left_sid_0", "lpd1_watch_the_hotel_0");
  a_vo_callouts["above_hotel"] = array("lpd3_look_out_on_the_roo_0", "lpd3_they_re_coming_down_0");
  a_vo_callouts["window"] = array("in_the_window_040");
  a_vo_callouts["train_top"] = array("lpd2_guy_on_the_train_if_0", "theyre_on_top_of_041", "lpd2_watch_out_sharpshoo_0");
  a_vo_callouts["generic"] = array("lpd1_they_re_slaughtering_0");
  level thread vo_callouts("street_lapd", "allies", a_vo_callouts, "ok_to_drop_building1");
}

street_vo_pmc_callouts() {
  a_vo_callouts = [];
  a_vo_callouts["in_hotel"] = array("pmc1_they_re_in_the_hotel_0", "pmc3_get_in_the_hotel_w_0");
  a_vo_callouts["in_train"] = array("pmc3_inside_the_train_0");
  a_vo_callouts["near_cars"] = array("pmc3_get_that_motherfucke_0", "pmc2_fuckers_are_hiding_b_0");
  a_vo_callouts["generic"] = array("pmc0_get_the_hell_away_0", "pmc0_hit_and_move_hit_a_0", "pmc0_keep_shooting_you_f_0", "pmc1_keep_them_on_the_str_0", "pmc1_we_re_taking_you_dow_0", "pmc1_i_got_that_fucker_0", "pmc1_i_bagged_another_0", "pmc1_i_m_three_for_three_0", "pmc1_eat_lead_and_die_mo_0", "pmc1_i_m_hit_0", "pmc1_bastards_0", "pmc1_we_re_losing_men_0", "pmc1_run_get_the_fuck_o_0", "pmc1_dammit_weapon_s_ja_0", "pmc2_die_american_0", "pmc2_fuck_you_0", "pmc2_this_is_payback_0", "pmc2_keep_them_back_0", "pmc2_get_me_a_clip_0", "pmc2_i_need_ammo_0", "pmc2_we_need_more_men_dow_0", "pmc2_hold_the_blockade_0", "pmc3_hit_em_now_0", "pmc3_stay_on_them_0", "pmc3_i_got_him_0", "pmc3_fuck_man_they_shot_0", "pmc3_come_on_keep_push_0", "pmc3_i_m_out_0", "pmc3_keep_it_together_0", "pmc3_keep_your_heads_down_0", "pmc3_get_down_there_0", "pmc3_that_was_close_0");
  level thread vo_callouts(undefined, "axis", a_vo_callouts, "ok_to_drop_building1");
}

harper_waittill_not_talking() {
  do_talk = 1;

  if(isDefined(level.harper.is_talking) && level.harper.is_talking)
    do_talk = 0;

  return do_talk;
}

street_claw_vo_player() {
  self waittill("claw_starting_vo_done");

  if(!flag("got_hit_by_claw")) {
    flag_set("got_hit_by_claw");

    if(!flag("harper_dead"))
      level.harper queue_dialog("pmc0_they_re_in_the_killz_0");
    else
      level.cop_1 queue_dialog("pmc0_they_re_in_the_killz_0");

    flag_clear("got_hit_by_claw");
  }
}

claw_vo_player_damage_override(e_inflictor, e_attacker, n_damage, n_flags, str_means_of_death, str_weapon, v_point, v_dir, str_hit_loc, n_model_index, psoffsettime) {
  if(isDefined(e_attacker.weaponinfo) && isstring(e_attacker.weaponinfo) && e_attacker.weaponinfo == "bigdog_dual_turret")
    level thread street_claw_vo_player();

  return n_damage;
}

street_claw_vo_grenade() {
  self endon("death");

  while(true) {
    self waittill("grenade_fire_bigdog", v_grenade_target);
    flag_set("claw_grenade");
    n_dist_sq_range = distancesquared(level.player.origin, v_grenade_target);

    if(n_dist_sq_range < 16384) {
      n_random = randomint(3);

      if(n_random == 0) {
        if(!flag("harper_dead"))
          level.harper priority_dialog("grenade_026");
      } else if(n_random == 1) {
        if(!flag("harper_dead"))
          level.harper priority_dialog("harp_move_section_0");
      } else if(n_random == 2) {
        if(!flag("harper_dead"))
          level.harper priority_dialog("get_outta_there_028");
      } else if(n_random == 3) {
        if(!flag("harper_dead"))
          level.harper priority_dialog("throw_it_back_029");
      }
    }
  }
}

street_shellshock_and_visionset() {
  current_vision_set = level.player getvisionsetnaked();

  if(current_vision_set == "")
    current_vision_set = "default";

  visionsetnaked("sp_la_1b_crash_exit");
  wait 1;
  screen_fade_in(9);
  visionsetnaked(current_vision_set, 10);
}

intruder_gatecrash(m_player) {
}

intruder_zap(m_player) {
}

intruder_zap_start(m_cutter) {
  m_cutter play_fx("laser_cutter_sparking", undefined, undefined, "stop_fx", 1, "tag_fx");
}

intruder_zap_end(m_cutter) {
  m_cutter notify("stop_fx");
}

intruder_cutter_on(m_cutter) {
  m_cutter play_fx("laser_cutter_on", undefined, undefined, undefined, 1, "tag_fx");
}

intruder_hide_bolts(m_cage) {
  m_cage hidepart("tag_bolts");
}

autoexec init_attackdrones() {
  t_use = getent("trig_attackdrone", "targetname");
  t_use sethintstring(&"SCRIPT_HINT_INTRUDER");
  t_use setcursorhint("HINT_NOICON");
  t_use trigger_off();
  flag_wait("level.player");
  level.player waittill_player_has_intruder_perk();
  t_use trigger_on();
  str_objective = getstruct("intruder_perk_use_pos", "targetname");
  set_objective_perk(level.obj_intruder_perk, str_objective, 850);
  t_use waittill("trigger");
  a_drones = spawn_vehicles_from_targetname("attackdrone");
  remove_objective_perk(level.obj_intruder_perk);
  level.player thread intruder_rumble();
  run_scene_and_delete("intruder");
  level.la_fire_direction_inited = 1;
  level.player maps\_fire_direction::init_fire_direction();
  level.player playsound("veh_qrdrone_boot_qr");
  level thread turn_on_quad_sounds();
  nd_exit_path = getvehiclenode("quad_rotors_exit_path", "targetname");

  foreach(vh_drone in a_drones) {
    vh_drone setvehweapon("quadrotor_turret_explosive");
    vh_drone maps\_quadrotor::quadrotor_on();
    wait 0.05;
    vh_drone disableaimassist();
    vh_drone maps\_quadrotor::quadrotor_start_scripted();
    vh_drone drivepath(nd_exit_path);
    vh_drone thread init_attackdrones_start_ai();
    wait 0.5;
  }
}

intruder_rumble() {
  self playrumbleonentity("damage_light");
  self rumble_loop(6, 0.75, "reload_clipout");
  self playrumbleonentity("damage_light");
  self playrumbleonentity("damage_light");
  earthquake(0.08, 1, self.origin, 1000, self);
}

init_attackdrones_start_ai() {
  self waittill("reached_end_node");
  self maps\_quadrotor::quadrotor_start_ai();
  maps\_fire_direction::add_fire_direction_shooter(self);
  self thread follow_player();
}

follow_player(follow_close) {
  if(!isDefined(follow_close))
    follow_close = 0;

  self endon("death");
  self endon("stop_follow");

  while(true) {
    v_goal = level.player.origin + vectornormalize(anglestoforward(level.player.angles)) * 300;
    self defend(v_goal, 300);

    if(follow_close)
      wait 0.5;
    else
      wait 3;
  }
}

street_quadrotors() {
  trigger_wait("fxanim_debris_2");
  a_press_drones = spawn_vehicles_from_targetname("press_demo_drone");
  a_press_drones = getentarray("press_demo_drone", "targetname");
  nd_exit_path = getvehiclenode("street_quads_start", "targetname");

  foreach(vh_drone in a_press_drones) {
    vh_drone maps\_quadrotor::quadrotor_on();
    wait 0.05;
    vh_drone disableaimassist();
    vh_drone maps\_quadrotor::quadrotor_start_scripted();
    vh_drone drivepath(nd_exit_path);
    vh_drone thread init_attackdrones_start_ai();
    playsoundatposition("evt_drone_flyby_swt", level.player.origin);
    wait 1;
  }

  scene_wait("cougar_exit_player");

  if(!(isDefined(level.la_fire_direction_inited) && level.la_fire_direction_inited))
    level.player maps\_fire_direction::init_fire_direction();
}

turn_on_quad_sounds() {
  level thread maps\la_1b_amb::la_drone_control_tones(0);
  wait 0.1;
  level thread maps\la_1b_amb::la_drone_control_tones(1);
}