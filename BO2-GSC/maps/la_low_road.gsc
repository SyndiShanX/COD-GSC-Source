/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_low_road.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\la_utility;
#include maps\_scene;
#include maps\_vehicle;
#include maps\_dialog;
#include maps\_objectives;
#include maps\_music;
#include maps\_rusher;
#include maps\_turret;
#include maps\_anim;
#include maps\_audio;

autoexec init_low_road() {
  add_spawn_function_group("g20_attackers", "targetname", ::g20_attackers_spawn_func);
  add_spawn_function_group("low_road_choke_group2_rpg", "script_noteworthy", ::low_road_first_rpg);
  add_spawn_function_group("gl_first_rpgs", "targetname", ::low_road_first_rpg);
  getent("low_road_bus_rpg", "targetname") delete();
  sp_semi_driver = getent("semi_driver", "targetname");
  sp_semi_driver add_spawn_function(::set_ignoreme, 1);
  add_spawn_function_ai_group("low_road_snipers", ::spawn_func_low_road_sniper);
  add_spawn_function_group("g20_group1_ss1", "script_noteworthy", ::g20_group1_ss1);
  add_spawn_function_ai_group("ai_group_low_road_left_side_flood", ::attack_potus);
  add_spawn_function_ai_group("ai_group_low_road_right_side_flood", ::attack_potus);
  add_spawn_function_ai_group("low_road_choke_group1b", ::attack_potus);
  add_spawn_function_ai_group("ai_group_low_road_first_guys", ::attack_potus);
  add_flag_function("player_reached_sniper_rappel", ::sniper_rappel_options);
  add_spawn_function_veh("g20_attack_drone", ::g20_attack_drone);
  add_spawn_function_veh("sniper_van", ::spawn_fun_sniper_van);
  add_spawn_function_veh("left_side_truck", ::left_side_truck);
  level.disablelongdeaths = 1;
  array_thread(getentarray("crater_trigger", "targetname"), ::crater_trigger);
  a_big_rig_ents = getentarray("freeway_bigrig_entry_guys", "targetname");
  array_thread(a_big_rig_ents, ::add_spawn_function, ::spawn_func_bug_rig_ai);
  m_platform = getent("sniper_platform", "targetname");

  foreach(m_piece in getentarray("sniper_platform_linked", "targetname"))
  m_piece linkto(m_platform);

  maps\_rusher::init_rusher();
  vh_cougar2 = getent("g20_group1_cougar2", "targetname");
  vh_cougar2 setteam("allies");
}

crater_trigger() {
  self endon("death");

  while(true) {
    self waittill("trigger", ent);

    if(isDefined(ent.chargeshotlevel) && ent.chargeshotlevel > 0) {
      exploder(self.script_int);
      self delete();
    }
  }
}

g20_attackers_spawn_func() {
  self.overrideactordamage = ::g20_attackers_damage;
}

g20_attackers_damage(einflictor, e_attacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(!isDefined(smeansofdeath) || smeansofdeath == "MOD_UNKNOWN")
    return 0;
  else if(smeansofdeath == "MOD_CRUSH") {
    if(isplayer(e_attacker) && !isDefined(self.alreadylaunched)) {
      self.alreadylaunched = 1;
      self startragdoll(1);
      v_launch = vectorscale((0, 0, 1), 100.0);

      if(randomint(100) < 40)
        v_launch = v_launch + anglestoforward(einflictor.angles) * 300;

      self launchragdoll(v_launch, "J_SpineUpper");
    }
  }

  return idamage;
}

skipto_sniper_rappel() {
  a_heroes = array("hillary", "sam", "jones");

  if(!flag("harper_dead"))
    a_heroes[a_heroes.size] = "harper";

  init_heroes(a_heroes);
  skipto_teleport("skipto_sniper_rappel", "squad");
  spawn_vehicle_from_targetname("after_sam_police_car");
}

#using_animtree("vehicles");

skipto_g20() {
  init_low_road_heroes();
  skipto_teleport("skipto_g20_group1", "squad");
  get_player_cougar();
  run_scene_and_delete("grouprappel_tbone");
  level.veh_player_cougar setanimknob( % v_la_03_12_entercougar_cougar, 1, 0, 0);
  spawn_vehicles_from_targetname("low_road_vehicles");
  simple_spawn("g20_group1_ss");
  kill_spawnernum(101);
  flag_set("player_reached_sniper_rappel");
  flag_set("rappel_option");
  flag_set("low_road_choke_group2_cleared");
  flag_set("low_road_snipers_cleared");
  flag_set("done_rappelling");
  level thread cover_convoy();
  noharper_open_cougar_door();
  a_av_allies_spawner_targetnames = array("f35_fast");
  a_av_axis_spawner_targetnames = array("avenger_fast");
}

skipto_sniper_exit() {
  cleanup_kvp("sm_low_road_first_guys");
  cleanup_kvp("low_road_bigrig_entry");
  cleanup_kvp("trig_low_road_rappel_left_enemies");
  cleanup_kvp("low_road_debris_fall");
  noharper_open_cougar_door();
  skipto_g20();
  skipto_teleport_players("skipto_sniper_exit");
  flag_clear("rappel_option");
  flag_set("sniper_option");
}

init_low_road_heroes() {
  init_hero("harper");
  init_hero("hillary", ::hillary_think);
  init_hero("sam");
  init_hero("jones");
}

main() {
  level thread intro_scene();
  level thread regroup();
  load_gump_c();
  setthreatbias("potus", "potus_rushers", 90000);
  spawn_vehicles_from_targetname("low_road_vehicles");
  level thread simple_spawn("g20_group1_ss");
  get_player_cougar();
  init_low_road_heroes();
  init_damage_fxanims();
  level thread remove_sight_blocker();
  level thread pre_rappel_backtrack_check();
  level thread post_rappel_backtrack_check();
  clientnotify("dl");
  a_av_allies_spawner_targetnames = array("f35_fast");
  a_av_axis_spawner_targetnames = array("avenger_fast");
  level thread attack_convoy();
  level thread play_rappel_ambient_fx();
  flag_wait("player_approaches_low_road");
  level thread sniper_rappel_choice_fail();
  exploder(300);
  stop_exploder(55);
  stop_exploder(60);
  battle_flow();
  flag_set("low_road_complete");
}

load_gump_c() {
  load_gump("la_1_gump_1c");
  m_cougar_destroyed = getent("cougar_destroyed", "targetname");

  if(isDefined(m_cougar_destroyed))
    m_cougar_destroyed setmodel("veh_t6_mil_cougar_destroyed_low");

  level thread autosave_by_name("after_sam");
}

init_damage_fxanims() {
  a_fxanims = [];
  a_fxanims[a_fxanims.size] = getent("fxanim_road_sign_snipe_01", "targetname");
  a_fxanims[a_fxanims.size] = getent("fxanim_road_sign_snipe_02", "targetname");
  a_fxanims[a_fxanims.size] = getent("fxanim_road_sign_snipe_03", "targetname");
  a_fxanims[a_fxanims.size] = getent("fxanim_road_sign_snipe_04", "targetname");
  exploder(360);
  exploder(361);
  exploder(362);
  exploder(363);
  a_fxanims[a_fxanims.size] = getent("sniper_bus", "targetname");
  a_fxanims[a_fxanims.size] = getent("sniper_train_middle", "targetname");
  a_fxanims[a_fxanims.size] = getent("sniper_train_front", "targetname");
  a_fxanims[a_fxanims.size] = getent("fxanim_sniper_freeway", "targetname");
  array_thread(a_fxanims, ::trigger_damage_fxanim);
}

trigger_damage_fxanim() {
  self setmodel(self.model);

  if(self.targetname != "fxanim_sniper_freeway")
    self setcandamage(1);

  b_played_bus_fx = 0;

  while(true) {
    self waittill("damage", n_ammount, e_attacker, v_direction, v_point, str_type, str_tag, str_model, str_part, str_weapon, n_flags);

    if(is_charged_shot(e_attacker) || weaponissniperweapon(str_weapon) || isDefined(e_attacker.classname) && e_attacker.classname == "script_vehicle" && str_type == "MOD_EXPLOSIVE") {
      switch (self.targetname) {
        case "fxanim_road_sign_snipe_01":
          level notify("fxanim_road_sign_snipe_01_start");
          stop_exploder(360);
          return;
        case "fxanim_road_sign_snipe_02":
          level notify("fxanim_road_sign_snipe_02_start");
          stop_exploder(361);
          return;
        case "fxanim_road_sign_snipe_03":
          level notify("fxanim_road_sign_snipe_03_start");
          stop_exploder(362);
          return;
        case "fxanim_road_sign_snipe_04":
          level notify("fxanim_road_sign_snipe_04_start");
          stop_exploder(363);
          return;
        case "fxanim_sniper_freeway":
          if(flag("grouprappel_done")) {
            level thread run_scene_and_delete("low_road_car_fall");
            level notify("fxanim_sniper_freeway_start");
          }

          return;
        case "sniper_bus":
          if(flag("sniper_option") && !flag("exit_sniper_player_done")) {
            if(!(isDefined(b_played_bus_fx) && b_played_bus_fx)) {
              b_played_bus_fx = 1;
              level notify("bus_rock");
              run_scene("sniper_bus_rock");
              getent("sniper_bus", "targetname") play_fx("sniper_bus_window_shatter", undefined, undefined, -1, 1, "bus_rock_jnt");
              self hidepart("tag_windows");
            }
          }

          break;
        case "sniper_train_front":
          run_scene("sniper_train_rock_front");
          break;
        case "sniper_train_middle":
          run_scene("sniper_train_rock_middle");
          break;
      }
    }
  }
}

is_charged_shot(e_attacker) {
  return isDefined(e_attacker.chargeshotlevel) && e_attacker.chargeshotlevel > 0;
}

intro_scene() {
  level thread run_scene("low_road_car_fall_loop");
  load_gump("la_1_gump_1c");
  run_scene_first_frame("low_road_bodies");
  run_scene_first_frame("low_road_intro");
  run_scene_first_frame("low_road_intro_cars");
  run_scene_first_frame("low_road_intro_policecars");
  run_scene_first_frame("low_road_intro_police1");
  run_scene_first_frame("low_road_intro_police2");
  run_scene_first_frame("low_road_intro_police3");
  run_scene_first_frame("low_road_intro_police4");
  run_scene_first_frame("grouprappel_tbone");
  m_bigrig = get_model_or_models_from_scene("grouprappel_tbone", "g20_group1_bigrig");
  m_bigrig.targetname = "grouprappel_tbone_bigrig";
  run_scene_first_frame("freeway_bigrig_entry", 1);
  flag_wait("player_approaches_low_road");
  level.player setlowready(1);
  level.player playsound("evt_drone_group_flyby");
  level thread run_scene_and_delete("low_road_intro");
  level thread run_scene_and_delete("low_road_intro_cars");
  level thread run_scene_and_delete("low_road_intro_policecars");
  level thread intro_cop1();
  level thread intro_cop2();
  level thread intro_cop3();
  level thread intro_cop4();
  level thread delay_police_car_damage();
  scene_wait("low_road_intro");
  wait_network_frame();
  level.veh_player_cougar setanimknob( % v_la_03_12_entercougar_cougar, 1, 0, 0);
}

intro_cop1() {
  run_scene_and_delete("low_road_intro_police1");
  run_scene_and_delete("low_road_intro_police1_loop");
}

intro_cop2() {
  run_scene_and_delete("low_road_intro_police2");
  run_scene_and_delete("low_road_intro_police2_loop");
}

intro_cop3() {
  run_scene_and_delete("low_road_intro_police3");
}

intro_cop4() {
  run_scene_and_delete("low_road_intro_police4");
  run_scene_and_delete("low_road_intro_police4_loop");
}

delay_police_car_damage() {
  flag_wait("low_road_intro_policecars_started");
  police_car1 = get_model_or_models_from_scene("low_road_intro_policecars", "g20_group1_policecar1");
  police_car1.takedamage = 0;
  police_car2 = get_model_or_models_from_scene("low_road_intro_policecars", "g20_group1_policecar2");
  police_car2.takedamage = 0;
  trigger_wait("low_road_debris_fall");
  police_car1.takedamage = 1;
  police_car2.takedamage = 1;
}

g20_attack_drone() {
  self endon("death");
  e_target = getent("g20_attack_drone_target", "targetname");
  self thread maps\_turret::shoot_turret_at_target(e_target, 4, undefined, 1);
  self thread maps\_turret::shoot_turret_at_target(e_target, 4, undefined, 2);
  wait 2;
  level.player playsound("evt_avenger_explo");
  exploder(520);
  wait 1;
  spawn_func_scripted_flyby();
  wait 1;
  spawn_func_scripted_flyby();
}

attack_convoy() {
  scene_wait("low_road_intro");
  level thread attack_convoy_random_explosions(level.veh_player_cougar.origin);
}

attack_convoy_random_explosions(v_pos) {
  a_magic_rpg_orgs = get_struct_array("convoy_attack_magic_rpg_orgs");

  while(!flag("start_last_stand")) {
    v_random_pos = v_pos + (random_vector(300)[0], random_vector(300)[1], 0);
    play_fx("ambush_explosion", v_random_pos);
    wait 1;
    v_random_pos = v_pos + (random_vector(300)[0], random_vector(300)[1], 0);
    magicbullet("usrpg_sp", a_magic_rpg_orgs[getarraykeys(a_magic_rpg_orgs)[randomint(getarraykeys(a_magic_rpg_orgs).size)]].origin, v_random_pos);
    wait(randomintrange(3, 5));
  }
}

regroup() {
  run_scene_first_frame("groupcover_approach");

  if(!flag("harper_dead"))
    run_scene_first_frame("groupcover_approach_harper");

  set_objective(level.obj_regroup, level.harper, "breadcrumb");
  level thread regroup_vo();
  level thread regroup_anim();
  flag_wait("player_reached_sniper_rappel");
  set_objective(level.obj_regroup, undefined, "delete");
}

regroup_anim() {
  if(!flag("harper_dead"))
    level thread run_scene_and_delete("groupcover_approach_harper");

  run_scene_and_delete("groupcover_approach");

  if(!flag("harper_dead"))
    level thread run_scene("groupcover_harper");

  run_scene_and_delete("groupcover");
}

regroup_vo() {
  level endon("rappel_option");
  level endon("sniper_option");

  if(!flag("harper_dead")) {
    level.player queue_dialog("sect_harper_sitrep_0", 2);
    level.harper queue_dialog("harp_we_got_mercs_all_aro_0");
    flag_wait("player_reached_sniper_rappel");
    wait 1;
    end_scene("groupcover_harper");
    level thread run_scene("groupcover_harper_rpg");
    wait 4;
    end_scene("groupcover_harper_rpg");
    level thread run_scene("groupcover_harper");
    wait 2;

    if(level.player player_has_sniper_weapon()) {
      end_scene("groupcover_harper");
      level thread run_scene("groupcover_harper_thecall");
      wait 2;
      level thread run_scene("groupcover_harper");
    }
  } else {
    level.player queue_dialog("sect_agent_samuels_are_0", 3);
    level.sam queue_dialog("samu_they_re_pinned_on_th_0", 1);
    flag_wait("player_reached_sniper_rappel");
    level.sam queue_dialog("samu_i_don_t_know_if_we_c_0");
    level.sam queue_dialog("samu_what_do_we_do_0");
  }

  level.player queue_dialog("sect_we_need_those_vehicl_0", 0);
}

sniper_rappel_vo() {
  if(flag("sniper_option"))
    level.player queue_dialog("get_the_president_004");
  else
    level.player queue_dialog("rappel_down__go_001");

  if(!flag("harper_dead")) {
    level.harper queue_dialog("harp_come_on_come_on_g_0", 1.5);
    level.player queue_dialog("sect_we_gotta_make_quick_0", 0.5);
    flag_wait_any("grouprappel_sniper_started", "grouprappel_started");
    level.harper queue_dialog("harp_we_re_on_ground_fu_0", 1);
    level.harper queue_dialog("harp_we_got_more_mg_truck_0", 1, "truck_right");
  } else {
    if(!flag("sniper_option"))
      flag_wait("grouprappel_player_done");

    level.player queue_dialog("sect_we_gotta_make_quick_0", 0.5);
    flag_wait_any("grouprappel_sniper_started", "grouprappel_started");
    level.sam queue_dialog("samu_we_ve_got_groundtroo_0", 6.5);
  }

  if(!flag("harper_dead")) {
    flag_wait("grouprappel_done");

    if(flag("sniper_option"))
      level.player queue_dialog("take_cover_by_the_010", 0.5);
  } else {
    level.player queue_dialog("sect_i_see_them_0", 0.5);
    level.player queue_dialog("protect_the_presid_001", 1);
    level.sam queue_dialog("samu_they_re_all_over_us_0", 1);
  }

  if(!flag("harper_dead")) {
    level.harper priority_dialog("harp_moving_0");
    level.harper queue_dialog("harp_dead_ahead_we_got_0", 1);
    level.player queue_dialog("sect_stay_in_cover_i_ll_0", 0.5);
    level.harper queue_dialog("harp_we_re_taking_heavy_e_0", 3, undefined, "low_road_complete");

    if(flag("sniper_option"))
      level.harper queue_dialog("harp_they_re_right_on_us_0", 1, undefined, "low_road_complete");

    level.harper queue_dialog("harp_dammit_keep_them_o_0", 1, undefined, "low_road_complete");

    if(flag("sniper_option") && level.player player_has_charge_weapon()) {
      level.harper queue_dialog("harp_use_your_scope_sect_0", 1, undefined, "low_road_complete");
      level.harper queue_dialog("harp_charge_each_round_an_0", 0.5, undefined, "low_road_complete");
    }
  } else {
    flag_wait("low_road_move_up_2");
    wait 2;
    level.player queue_dialog("take_cover_by_the_010", 0, undefined, "low_road_complete");
    level.sam queue_dialog("samu_roger_that_0", 0.5, undefined, "low_road_complete");
    level.sam queue_dialog("samu_we_re_taking_fire_fr_0", 1, undefined, "low_road_complete");
    level.player queue_dialog("stay_in_cover_003", 1, undefined, "low_road_complete");
    level.sam queue_dialog("samu_we_got_enemies_dead_0", 0.5, undefined, "low_road_complete");
    level.player queue_dialog("samu_you_gotta_keep_them_0", 1, undefined, "low_road_complete");
  }

  level.player queue_dialog("keep_covering_the_002", 1, undefined, "low_road_complete");

  if(!flag("sniper_option"))
    level.player queue_dialog("stay_down_011", 1, undefined, "low_road_complete");

  waittill_enemies_by_bus();
  flag_wait("objective_g20_check");
  wait 1;

  if(flag("objective_g20_failed"))
    level.jones queue_dialog("jone_we_re_too_late_th_0", 2);

  waittill_snipers_on_overpass();
}

harper_sniper_nag() {
  level endon("low_road_snipers_cleared");

  if(flag("sniper_option"))
    wait 0.5;
  else
    wait 2;

  level.harper queue_dialog("harp_dammit_taking_fire_0");
  level.harper queue_dialog("harp_they_ve_got_fucking_0", 0.5);
  wait 4;
  level.harper queue_dialog("harp_behind_the_signs_0", 0, undefined, "low_road_snipers_cleared");
  wait 4;
  level.harper queue_dialog("harp_section_take_out_th_0", 0, undefined, "low_road_snipers_cleared");
  wait 4;
  level.harper queue_dialog("harp_target_their_rifleme_0", 0, undefined, "low_road_snipers_cleared");
  wait 2;
  level.harper queue_dialog("harp_target_the_snipers_0", 0, undefined, "low_road_snipers_cleared");
  wait 3;
  level.harper queue_dialog("harp_neutralize_those_sni_0", 0, undefined, "low_road_snipers_cleared");
}

samu_sniper_nag() {
  level endon("low_road_snipers_cleared");

  if(flag("sniper_option"))
    wait 0.5;
  else
    wait 2;

  level.sam queue_dialog("samu_taking_fire_from_sni_0", 0, undefined, "low_road_snipers_cleared");
  level.sam queue_dialog("samu_section_we_need_cov_0", 3, undefined, "low_road_snipers_cleared");
  level.sam queue_dialog("samu_we_re_dead_if_you_do_0", 4, undefined, "low_road_snipers_cleared");
  level.sam queue_dialog("samu_come_on_man_we_nee_0", 4, undefined, "low_road_snipers_cleared");
  level.sam queue_dialog("samu_section_take_out_th_0", 3, undefined, "low_road_snipers_cleared");
}

sniper_exit_vo() {
  kill_all_pending_dialog();
  level.player thread priority_dialog("sect_clear_get_to_the_v_0");
  level.player disableweapons();
  flag_set("allow_sniper_exit");

  if(!flag("harper_dead"))
    level.harper priority_dialog("harp_get_outta_there_sec_0", 0);
  else
    wait 2;

  flag_wait("exit_sniper_player_started");

  if(!flag("harper_dead"))
    level.player priority_dialog("sect_shiiiiit_0", 0);
  else
    level.player priority_dialog("sect_shiiiiit_0", 2.5);
}

last_stand_vo() {
  if(flag("sniper_option"))
    flag_wait("exit_sniper_player_done");
  else
    flag_wait("low_road_move_up_4");

  level.player queue_dialog("sect_get_on_the_radio_and_0", 2);
  level.jones queue_dialog("jone_the_rear_vehicles_di_0", 1);
  level.jones queue_dialog("jone_secdef_petraeus_is_s_0", 1);
  level.player queue_dialog("good_work_people_012", 1);
  flag_wait("player_approaches_convoy");
  level.player queue_dialog("sect_we_need_to_get_this_0", 1);

  if(!flag("harper_dead")) {
    level.harper queue_dialog("were_gonna_be_fig_002", 1);
    level.harper queue_dialog("harp_pmcs_are_setting_up_0", 2);
    level.player queue_dialog("sect_clear_em_out_0", 0.5);
  } else
    level.player queue_dialog("sect_we_re_gonna_be_fight_0", 2);

  if(!flag("harper_dead"))
    flag_wait("g20_group1_greet_harper_started");

  if(!flag("harper_dead")) {
    level.harper queue_dialog("we_gotta_go_now_005");
    level.player queue_dialog("sect_i_ll_take_the_lead_v_0", 0.5);
  } else
    level.sam queue_dialog("last_stand_enemies_sm", 1);

  trigger_wait("trig_cougar_enter");
  level.player queue_dialog("sect_update_all_blue_ro_0", 1);

  if(flag("harper_dead"))
    level.player queue_dialog("sect_on_my_lead_110_nor_0");
}

vo_rpg_nag() {
  flag_wait("sm_sm_low_road_launcher_enabled");

  if(!is_spawn_manager_cleared("sm_low_road_launcher"))
    level.harper queue_dialog("we_got_rpgs_on_the_003", 0);

  wait 3;

  if(!is_spawn_manager_cleared("sm_low_road_launcher"))
    level.harper queue_dialog("take_out_those_dam_004", 0);
}

waittill_player_looking_at_me(str_flag) {
  self endon("death");

  while(!level.player is_ads() || !level.player is_looking_at(self, 0.98))
    wait 0.2;

  flag_set(str_flag);
}

g20_group1_ss1() {
  level.ai_g20_ss1 = self;
  self.takedamage = 0;
  self maps\_anim::anim_set_blend_in_time(0.3);
  self maps\_anim::anim_set_blend_out_time(0.3);
}

remove_sight_blocker() {
  m_blocker = getent("sniper_rappel_sight_blocker", "targetname");
  m_blocker delete();
}

last_stand_main() {
  set_ai_group_cleared_count("low_road_last_stand", 2);
  level.harper = init_hero("harper");

  if(flag("sniper_option")) {
    cleanup_array(getentarray("low_road_bigrig_entry", "targetname"));
    exit_sniper();
  }

  trigger_on("start_last_stand");
  trigger_use("start_last_stand");

  if(flag("sniper_option"))
    delay_thread(4, ::trigger_use, "last_stand_enemies_sm");
  else {
    getent("last_stand_enemies_sm", "targetname") delete();
    getent("last_stand_enemies", "targetname") delete();
  }

  set_objective(level.obj_potus, undefined, "done");
  spawn_manager_enable("sm_low_road_launcher");
  waittill_ai_group_cleared("low_road_last_stand");
  kill_rpgs();
  flag_set("g20_group1_greet_harper_started");
  level.disable_straffing_drone_shooting = undefined;
  set_straffing_drones("straffing_drone", "last_stand_drone_strafe_org", 1000, undefined, 0.4, 1.8);
  wait 3;
  array_thread(getaiarray("axis"), ::bloody_death);
  level thread autosave_now("entering_courgar");
  level thread g20_group_meetup();
  set_objective(level.obj_highway, undefined, "done");
  set_objective(level.obj_highway, undefined, "delete");
  level delay_thread(3, ::trigger_use, "gl_rpgs_trig");
  level delay_thread(6, ::g20_attackers);

  if(!flag("harper_dead"))
    wait 8;

  enter_cougar();
  freeway_cleanup();
  set_straffing_drones("off");
  set_objective(level.obj_drive);
  spawn_manager_kill("sm_g20_attackers");
}

kill_rpgs() {
  spawn_manager_kill("sm_low_road_launcher");
  a_rpgs = get_ai_group_ai("low_road_last_stand_rpg");
  array_thread(a_rpgs, ::bloody_death, undefined, 2);
}

g20_attackers() {
  level waittill("first_drone_strike");
  spawn_manager_kill("sm_g20_attackers");
  array_thread(getentarray("g20_attackers_ai", "targetname"), ::bloody_death);
}

help_kill_dudes() {
  level.ai_g20_ss1.perfectaim = 1;
  level.harper.perfectaim = 1;
  wait 20;
  level.ai_g20_ss1.perfectaim = 0;
  level.harper.perfectaim = 0;
}

freeway_cleanup() {
  cleanup_array(level.heroes);
  cleanup(level.ai_g20_ss1);
  level notify("spawn_aerial_vehicles");
  a_vehicles = getvehiclearray();

  foreach(veh in a_vehicles) {
    if(issubstr(veh.model, "drone") || issubstr(veh.model, "f35"))
      veh thread delete_when_not_looking_at();
  }
}

enter_cougar() {
  set_objective(level.obj_drive, level.veh_player_cougar gettagorigin("tag_player") + vectorscale((0, 0, 1), 40.0), & "LA_SHARED_OBJ_DRIVE");
  enter_dist = 10000;
  v_tag_pos = level.veh_player_cougar gettagorigin("tag_enter_driver");
  v_tag_ang = level.veh_player_cougar gettagangles("tag_enter_driver");
  v_enter = anglestoright(v_tag_ang);
  level thread toggle_trig_cougar_enter();
  trigger_wait("trig_cougar_enter");
  level thread load_gump("la_1_gump_1d");
  trigger_use("drive_start_vehicles_trig");
  level.player magic_bullet_shield();
  level thread run_scene_and_delete("enter_cougar_potus");
  run_scene_and_delete("enter_cougar");
  flag_set("player_in_cougar");
  level thread drive_save_game();
  clientnotify("ssd");
  level thread maps\_audio::switch_music_wait("LA_1_DRIVE", 2);
  level.player setclientdvar("player_sprintUnlimited", 0);
  level.player stop_magic_bullet_shield();
}

drive_save_game() {
  flag_wait("la_1_gump_1d");
  autosave_by_name("drive");
}

toggle_trig_cougar_enter() {
  level endon("entered_cougar");

  while(true) {
    trigger_on("trig_cougar_enter");
    level.player waittill("grenade_pullback");
    trigger_off("trig_cougar_enter");
    level.player waittill("grenade_fire", grenade);
  }
}

low_road_first_rpg() {
  self endon("death");

  if(isDefined(self.script_string)) {
    self custom_ai_weapon_loadout("usrpg_magic_bullet_sp");
    self waittill("goal");
    e_target = get_ent(self.script_string);
    self shoot_at_target(e_target);
    self.a.allow_shooting = 0;
    self custom_ai_weapon_loadout("usrpg_sp");
    wait 5;
    self.a.allow_shooting = 1;
  }

  flag_wait("enter_cougar_started");
  bloody_death();
}

low_road_bus_rpg() {
  self thread waittill_bus_rpg_fire();
  delay_thread(2, ::flag_set, "bus_rpg_guy_spawned");
  self waittill("death");
  flag_set("bus_rpg_guy_dead");
}

waittill_bus_rpg_fire() {
  self endon("death");
  self waittill("shoot");
  flag_set("bus_rpg_guy_fired");
  self thread waittill_player_looking_at_me("player_looking_at_rpg_bus_guy");
}

left_side_truck() {
  self endon("death");
  self waittill("unload");
  ai1 = getent("terrorist_rappel_left1_ai", "targetname");
  ai1 thread left_rappel(1);
  ai2 = getent("terrorist_rappel_left2_ai", "targetname");
  ai2 thread left_rappel(2);
  ai3 = getent("terrorist_rappel_left3_ai", "targetname");
  ai3 thread left_rappel(3);
  ai4 = getent("terrorist_rappel_left4_ai", "targetname");
  ai4 thread left_rappel(4);
  array_wait(array(ai1, ai2, ai3, ai4), "death");
  flag_set("left_side_rappel_guys_dead");
}

low_road_truck_1() {
  self waittill("death");
  level thread drop_car(randomintrange(3, 5));
}

drop_car(delay) {
  if(isDefined(delay))
    wait(delay);

  level.player playsound("evt_sniper_freeway_debris_explo");
  level.player playsound("evt_sniper_car_fall_start");
  level thread run_scene_and_delete("low_road_car_fall");
  level notify("fxanim_sniper_freeway_start");
}

left_rappel(num) {
  self endon("death");
  self waittill("jumpedout");
  self thread waittill_player_looking_at_me("player_looking_at_rappel_guy");
  self thread run_scene_and_delete("terrorist_rappel_left" + num);
  self waittill("goal");
  flag_set("left_side_rappel_started");
  scene_wait("terrorist_rappel_left" + num);
  self set_spawner_targets("low_road_attack_nodes01");
}

spawn_func_low_road_sniper() {
  self endon("death");
  trigger_wait("trig_player_approaches_convoy");
  self delete();
}

spawn_func_bug_rig_ai() {
  self.attackeraccuracy = 100;
  self.health = 1;

  if(self.animname == "freeway_bigrig_entry_guy4")
    self.a.deathforceragdoll = 1;
}

spawn_func_rappel() {
  self cleargoalvolume();
}

hillary_think() {
  self endon("death");
  self setthreatbiasgroup("potus");
  self set_ignoreme(1);
  scene_wait("grouprappel");
  self set_ignoreme(0);
  self.allowdeath = 1;

  level endon("stop_god_mode_potus_protection");

  while(true) {
    if(isgodmode(level.player))
      self magic_bullet_shield();
    else {
    }

    wait 1;
  }

}

pre_rappel_backtrack_check() {
  level endon("grouprappel_done");
  trigger_wait("pre_rappel_backtrack_trig");
  missionfailedwrapper(&"LA_SHARED_FAIL_ABANDON");
}

post_rappel_backtrack_check() {
  level endon("player_driving");
  trigger_wait("post_rappel_backtrack_trig");
  missionfailedwrapper(&"LA_SHARED_FAIL_ABANDON");
}

waittill_player_choice() {
  str_option = level waittill_any_return("sniper_option", "rappel_option");
  spawner_delete(str_option);
}

battle_flow() {
  set_ai_group_cleared_count("ai_group_low_road_left_side_flood", 2);
  set_ai_group_cleared_count("low_road_choke_group2", 2);
  set_ai_group_cleared_count("ai_group_low_road_right_side_flood", 1);
  waittill_player_choice();
  cleanup_array(getentarray("terrorist_rappel_left1", "targetname"));
  cleanup_array(getentarray("terrorist_rappel_left2", "targetname"));
  cleanup_array(getentarray("terrorist_rappel_left3", "targetname"));
  cleanup_array(getentarray("terrorist_rappel_left4", "targetname"));
  level thread change_cougar_team();
  level thread sniper_rappel_vo();
  level thread last_stand_vo();
  level thread first_sniper_guy();
  level thread freeway_chunks_fall();
  setmusicstate("LA_1_SNIPER_RAPEL");
  level.disable_straffing_drone_shooting = 1;
  delay_thread(10, ::trigger_use, "low_road_move_up_1");

  if(flag("rappel_option"))
    delay_thread(8, ::drop_car);

  if(flag("sniper_option")) {
    add_spawn_function_veh("low_road_truck_1", ::low_road_truck_1);
    right_side_flood_trigger = getent("sm_low_road_right_side_flood", "targetname");

    if(isDefined(right_side_flood_trigger))
      trigger_use("sm_low_road_right_side_flood");
  } else {
  }

  delay_thread(5, ::fxanim_sniper_drone_crash_start);
  level.hillary.ignoreme = 1;
  level.harper.a.movement = "run";
  level thread spawn_first_truck();
  grouprappel();
  level thread monitor_bigrig_guys();
  level.hillary.ignoreme = 0;
  level thread potus_cover();
  level thread monitor_truck_gunners();
  level thread monitor_trucks();
  level thread monitor_low_road_group();
  level thread kill_truck_gunners();
  level thread g20_cougar();
  level thread low_road_fail_logic(120, "low_road_snipers_cleared", 30.0);
  flag_set("low_road_move_up_2");
  level thread show_charged_shot_hint();

  if(flag("rappel_option"))
    wait 1.5;

  trigger_use("low_road_move_up_2");
  level thread noharper_open_cougar_door();
  trigger_use("low_road_move_up_3");
  level thread spawn_terrorist_rappel_guys();
  waittill_enemies_by_bus();
  trigger_use("low_road_move_up_3c");
  trigger_use("low_road_move_up_3b");

  if(!flag("harper_dead"))
    level thread harper_sniper_nag();
  else
    level thread samu_sniper_nag();

  if(flag("rappel_option"))
    delay_thread(3, ::rappel_drop_signs);

  waittill_enemies_under_overpass();
  waittill_snipers_on_overpass();
  level thread player_approach_convoy_fail_logic(100, "player_approaches_convoy");
  level thread clean_up_group2();
  level thread finish_potus_objective();
  level thread run_to_convoy();
  wait 2;
}

change_cougar_team() {
  flag_wait_any("grouprappel_tbone_started", "grouprappel_sniper_tbone_started");

  if(flag("grouprappel_tbone_started"))
    vh_cougar = get_model_or_models_from_scene("grouprappel_tbone", "g20_group1_cougar4");
  else if(flag("grouprappel_sniper_tbone_started"))
    vh_cougar = get_model_or_models_from_scene("grouprappel_sniper_tbone", "g20_group1_cougar4");

  if(isDefined(vh_cougar))
    vh_cougar setteam("allies");
}

spawn_first_truck() {
  flag_wait_any("grouprappel_sniper_started", "grouprappel_started");
  wait 18;

  if(flag("rappel_option")) {
    delay_thread(2, ::trigger_use, "low_road_spawn_truck_on_right");
    level thread lower_freeway_jeep_moveup(4);
    wait 3;
    flag_set("truck_right");
  } else {
    trigger_use("low_road_spawn_truck_on_right");
    level thread lower_freeway_jeep_moveup();
    wait 1;
    flag_set("truck_right");
  }
}

show_charged_shot_hint() {
  level endon("player_in_cougar");
  wait 1.5;

  while(true) {
    current_weapon = level.player getcurrentweapon();

    if(weaponischargeshot(current_weapon) && weaponissniperweapon(current_weapon)) {
      break;
    }

    level.player waittill("weapon_change");
  }

  screen_message_create(&"LA_SHARED_HINT_CHARGE_WEAPON", undefined, undefined, undefined, 4.5);
}

first_sniper_guy() {
  sniper_guy = simple_spawn_single("first_sniper_bigrig");
  sniper_guy endon("death");
  waittill_enemies_bigrig();
  wait 2;
  sniper_guy bloody_death();
}

spawn_terrorist_rappel_guys() {
  level thread run_scene("terrorist_rappel1");
  level thread run_scene("terrorist_rappel2");
  level thread run_scene("terrorist_rappel3");
  scene_wait("terrorist_rappel3");
  rappel_ai = get_ais_from_scene("terrorist_rappel1");
  rappel_ai[rappel_ai.size] = get_ais_from_scene("terrorist_rappel2")[0];
  rappel_ai[rappel_ai.size] = get_ais_from_scene("terrorist_rappel3")[0];
  array_thread(rappel_ai, ::rappel_ai_move_around_underpass);
}

rappel_ai_move_around_underpass() {
  self endon("death");

  if(isalive(self)) {
    self.goalradius = 1024;
    self.aggressivemode = 1;
    self setgoalpos(self.origin);
  }
}

waittill_enemies_bigrig() {
  waittill_ai_group_cleared("low_road_choke_group1");
}

waittill_enemies_by_bus() {
  while(get_ai_group_count("low_road_choke_group1b") + get_ai_group_count("ai_group_low_road_left_side_flood") > 3)
    wait 0.5;

  flag_set("low_road_choke_group1b_cleared");
}

waittill_enemies_under_overpass() {
  waittill_ai_group_cleared("low_road_choke_group2");
  flag_set("low_road_choke_group2_cleared");
}

waittill_snipers_on_overpass() {
  while(get_ai_group_count("low_road_snipers") > 0 || get_ai_group_count("ai_group_low_road_right_side_flood") > 3)
    wait 0.5;

  level notify("low_road_snipers_cleared");
  flag_set("low_road_snipers_cleared");
  level notify("low_road_group_2_cleared");
}

low_road_clear_vo() {
  wait 1;

  if(flag("harper_dead")) {
    level.sam say_dialog("clear_006");
    level.sam say_dialog("everyone_h_get_to_013");
  }
}

lower_freeway_jeep_moveup(wait_time) {
  if(isDefined(wait_time))
    wait(wait_time);

  wait 0.1;
  vh_jeep = getent("lower_freeway_jeep1", "targetname");
  vh_jeep endon("death");
  vh_jeep stop_magic_bullet_shield();
  vh_jeep.script_unload = "all";
  vh_jeep waittill("goal");
  vh_jeep vehicle_unload();
}

rappel_drop_signs() {
  level notify("fxanim_road_sign_snipe_03_start");
  wait(randomfloatrange(0.5, 1.5));
  level notify("fxanim_road_sign_snipe_04_start");
}

low_road_fail_logic(n_time, str_ender, n_warn_time_step) {
  level endon(str_ender);

  thread test_timer(str_ender);

  level thread low_road_warning(str_ender, n_time, n_warn_time_step);
  wait(n_time);

  if(!flag("start_last_stand"))
    missionfailedwrapper(&"LA_SHARED_OBJ_PROTECT_FAIL");
}

player_approach_convoy_fail_logic(n_time, str_ender) {
  level endon(str_ender);

  thread test_timer(str_ender);

  level thread player_approach_convoy_vo(n_time, str_ender);
  wait(n_time);
  missionfailedwrapper(&"LA_SHARED_OBJ_PROTECT_FAIL");
}

player_approach_convoy_vo(time, str_ender) {
  level endon(str_ender);

  if(!flag("harper_dead")) {
    wait(time / 2);
    level.harper priority_dialog("harp_section_get_over_he_0");
    wait(time / 2);
    level.harper priority_dialog("harp_move_up_to_the_lead_0");
  } else {
    wait(time / 2);
    level.sam priority_dialog("samu_section_get_over_he_0");
    wait(time / 2);
    level.sam priority_dialog("samu_move_up_to_the_lead_0");
  }
}

low_road_warning(str_ender, n_time, n_warn_time_step) {
  level endon(str_ender);
  level thread low_road_warning_sniper_vo(30.0);
  level.playersniperkillsafterbigrig = 0;
  wait 30.0;

  if(flag("sniper_option")) {
    if(level.playersniperkillsafterbigrig < 1)
      missionfailedwrapper(&"LA_SHARED_OVERWATCH_FAIL");
  }

  wait 30.0;
  level autosave_by_name("low_road");
  set_objective(level.obj_potus, level.hillary, "protect", undefined, 0, 60.0);
}

low_road_warning_sniper_vo(time) {
  if(flag("sniper_option")) {
    if(!flag("harper_dead")) {
      wait(time / 3);

      if(!weaponissniperweapon(level.player getcurrentweapon()))
        level.harper queue_dialog("harp_use_the_rifle_secti_0");
    } else {
      wait(time / 3);

      if(!weaponissniperweapon(level.player getcurrentweapon()))
        level.sam queue_dialog("samu_use_the_rifle_secti_0");
    }
  }
}

test_timer(str_ender) {
  level endon(str_ender);
  n_count = 0;

  while(true) {
    wait 1;
    n_count++;
    iprintln(n_count);
  }
}

clean_up_group2() {
  a_ai = get_ai_group_ai("low_road_choke_group2");
  array_thread(a_ai, ::clean_up_group2_ai);
}

clean_up_group2_ai() {
  self endon("death");
  wait(randomfloatrange(0.5, 3.0));
  self bloody_death();
}

low_road_bigrig_enter() {
  level thread run_scene_and_delete("freeway_bigrig_entry");
  flag_wait("freeway_bigrig_entry_started");
  a_ai_guys = get_ais_from_scene("freeway_bigrig_entry");

  foreach(ai_guy in a_ai_guys)
  ai_guy.aigroup = "group_bigrig";

  waittill_ai_group_ai_count("group_bigrig", 1);
}

identify_low_road_snipers() {
  s_start = getstruct("identifier_bullet_start", "targetname");
  createthreatbiasgroup("player");
  createthreatbiasgroup("sniper");
  setthreatbias("player", "sniper", 15000);
  wait 10;
  level.player setthreatbiasgroup("player");
  a_ai = get_ai_group_ai("low_road_snipers");

  foreach(ai_sniper in a_ai)
  ai_sniper setthreatbiasgroup("sniper");

  while(get_ai_group_count("low_road_snipers")) {
    a_ai = array_randomize(get_ai_group_ai("low_road_snipers"));
    n_shots = randomintrange(4, 7);

    for(i = 0; i < n_shots; i++) {
      v_end_point = a_ai[0].origin;
      v_end_point = (v_end_point[0] + randomintrange(-128, 128), v_end_point[1], v_end_point[2] - randomintrange(-24, 48));
      magicbullet("avenger_side_minigun", s_start.origin, v_end_point);
      wait(randomfloatrange(0.1, 0.4));
    }

    wait(randomintrange(2, 5));
  }
}

grouprappel() {
  if(flag("sniper_option")) {
    if(!flag("harper_dead"))
      level thread run_scene_and_delete("grouprappel_sniper_jack");

    level thread run_scene_and_delete("grouprappel_sniper_tbone");
    level thread run_scene("grouprappel_sniper_ter01");
    level thread run_scene("grouprappel_sniper_ter02");
    level thread run_scene("grouprappel_sniper_ter03");
    level thread run_scene_and_delete("grouprappel_sniper");
    wait 1;
    a_trailer_ai[0] = get_ais_from_scene("grouprappel_sniper_ter01")[0];
    a_trailer_ai[1] = get_ais_from_scene("grouprappel_sniper_ter02")[0];
    a_trailer_ai[2] = get_ais_from_scene("grouprappel_sniper_ter03")[0];
    array_thread(a_trailer_ai, ::grouprappel_ignore_until_doors);
    level thread bigrig_trailer_ai_nag_vo(a_trailer_ai);
    scene_wait("grouprappel_sniper");
  } else {
    if(!flag("harper_dead"))
      level thread run_scene_and_delete("grouprappel_jack");

    level thread run_scene_and_delete("grouprappel_tbone");
    level thread run_scene_and_delete("grouprappel_ter01");
    level thread run_scene_and_delete("grouprappel_ter02");
    level thread run_scene_and_delete("grouprappel_ter03");
    level thread run_scene_and_delete("grouprappel");
    wait 1;
    a_trailer_ai[0] = get_ais_from_scene("grouprappel_ter01")[0];
    a_trailer_ai[1] = get_ais_from_scene("grouprappel_ter02")[0];
    a_trailer_ai[2] = get_ais_from_scene("grouprappel_ter03")[0];
    array_thread(a_trailer_ai, ::grouprappel_ignore_until_doors);
    level thread bigrig_trailer_ai_nag_vo(a_trailer_ai);
    scene_wait("grouprappel");
  }

  flag_set("grouprappel_done");
}

bigrig_trailer_ai_nag_vo(ai_list) {
  level waittill("bigrig_trailer_doors_open");

  if(flag("harper_dead")) {
  } else
    level.harper say_dialog("harp_several_mercs_inside_0");

  wait 2.0;
  m_door_clip = getent("truck_door", "targetname");
  m_door_clip delete();

  while(!flag("low_road_choke_group1_cleared"))
    wait 8.0;
}

grouprappel_ignore_until_doors() {
  self set_ignoreme(1);
  self disableaimassist();
  self magic_bullet_shield();
  level waittill("bigrig_trailer_doors_open");
  self set_ignoreme(0);
  self enableaimassist();
  self stop_magic_bullet_shield();
}

run_to_convoy() {
  level thread turn_off_breadcrumb_obj();
  set_objective(level.obj_highway, getent("g20_objective_trigger", "targetname"));
  trigger_use("low_road_move_up_4");
  level thread maps\_audio::switch_music_wait("LA_1_BRIDGE_SCENE", 1);
}

fakey_dude() {
  self.overrideactordamage = ::fakey_dude_damage;
}

fakey_dude_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, modelindex, psoffsettime, bonename) {
  if(isplayer(eattacker))
    return idamage;

  return 0;
}

fxanim_sniper_drone_crash_start() {
  s_look = get_struct("low_road_lookat_pos_right");

  while(!level.player is_player_looking_at(s_look.origin, 0.7, 0) || level.player is_ads())
    wait 0.05;

  level notify("fxanim_sniper_drone_crash_start");
  wait 0.2;
  drone = getent("fxanim_sniper_drone_crash_drone", "targetname");
  playfxontag(level._effect["drone_trail"], drone, "tag_origin");
  wait 0.9;
  level.player playrumbleonentity("artillery_rumble");
  earthquake(0.5, 2.0, level.player.origin, 100);
  wait 3;

  if(flag("sniper_option")) {
    flag_wait("group_cover_idle1_started");
    level notify("fxanim_sniper_freeway_start");
    level thread run_scene_and_delete("low_road_car_fall");
    wait 2;
    level.player playrumbleonentity("grenade_rumble");
    earthquake(0.3, 1.0, level.player.origin, 100);
  }
}

finish_potus_objective() {
  level notify("stop_god_mode_potus_protection");
  level.hillary magic_bullet_shield();
  level thread autosave_by_name("low_road_cleared");
  set_objective(level.obj_potus, undefined, "done");
}

freeway_chunks_fall() {
  trigger_wait("trigger_freeway_chunks");
  level thread delete_rappel_rope();
  level notify("fxanim_freeway_chunks_fall_start");
  level.player playsound("evt_sniper_freeway_debris_explo");
  s_rumble = get_struct("low_road_debris_fall_rumble_spot");
  playrumbleonposition("flyby", s_rumble.origin);
  earthquake(0.4, 3, s_rumble.origin, 5000);
  t_clip = getent("clip_freeway_debris_pile", "targetname");
  radiusdamage((8132.9, -51382, -191), 100, 1000, 1000);
  t_clip trigger_on();
  t_clip disconnectpaths();
  a_ai_guys = getaiarray("axis");

  foreach(ai_guy in a_ai_guys) {
    if(ai_guy istouching(getent("trigger_freeway_debris_pile", "targetname")))
      ai_guy die();
  }
}

delete_rappel_rope() {
  flag_wait("terrorist_rappel1_done");
  e_rope = get_model_or_models_from_scene("terrorist_rappel1", "terrorist_rappel_rope4");

  if(isDefined(e_rope))
    e_rope delete();
}

g20_cougar() {
  vh_cougar = getent("g20_group1_cougar3", "targetname");
  vh_cougar setcandamage(0);

  debug_timer();

  set_objective(level.obj_g20_cougar, vh_cougar gettagorigin("tag_player") + vectorscale((0, 0, 1), 100.0), "", undefined, 1, 60.0);
  wait 60.0;
  level notify("g20_cougar_wait_done");
  flag_set("objective_g20_check");

  if(flag("low_road_snipers_cleared")) {
    level notify("low_road_g20_saved");
    set_objective(level.obj_g20_cougar, undefined, "done");
    set_objective(level.obj_g20_cougar, undefined, "delete");
    setdvar("la_G20_1_saved", 1);
  } else {
    exploder(330);
    flag_set("objective_g20_failed");
    vh_cougar = getent("g20_group1_cougar3", "targetname");
    vh_cougar setcandamage(1);
    radiusdamage(vh_cougar.origin, 64, vh_cougar.health * 2, vh_cougar.health * 2);
    set_objective(level.obj_g20_cougar, undefined, "failed");
    set_objective(level.obj_g20_cougar, undefined, "delete");
    level thread run_scene_and_delete("g20_fail");
    wait 2;
  }
}

spawner_delete(str_option) {
  str_disable = str_option == "sniper_option" ? "rappel_option" : "sniper_option";
  a_spawners = getspawnerarray();

  foreach(sp in a_spawners) {
    if(!isDefined(sp.groupname) && !isDefined(str_disable) || isDefined(sp.groupname) && isDefined(str_disable) && sp.groupname == str_disable)
      sp delete();
  }

  a_spawners = getvehiclespawnerarray();

  foreach(sp in a_spawners) {
    if(!isDefined(sp.groupname) && !isDefined(str_disable) || isDefined(sp.groupname) && isDefined(str_disable) && sp.groupname == str_disable)
      sp delete();
  }

  a_nodes = getnodearray(str_disable, "script_noteworthy");

  foreach(node in a_nodes)
  setenablenode(node, 0);
}

monitor_trucks() {
  trigger_wait("low_road_bigrig_entry");
  wait 4;
  vh_truck1 = getent("truck_03", "targetname");

  for(vh_truck2 = getent("truck_07", "targetname"); isalive(vh_truck1) || isalive(vh_truck2); vh_truck2 = getent("truck_07", "targetname")) {
    wait 0.5;
    vh_truck1 = getent("truck_03", "targetname");
  }

  flag_set("move_to_pillar");
}

monitor_truck_gunners() {
  trigger_wait("low_road_bigrig_entry");
  wait 2;
  vh_truck1 = getent("truck_03", "targetname");
  vh_truck2 = getent("truck_07", "targetname");
  ai_gunner1 = vh_truck1.riders[2];

  for(ai_gunner2 = vh_truck2.riders[2]; isalive(ai_gunner1) || isalive(ai_gunner2); ai_gunner2 = vh_truck2.riders[2]) {
    wait 0.5;
    vh_truck1 = getent("truck_03", "targetname");
    vh_truck2 = getent("truck_07", "targetname");
    ai_gunner1 = vh_truck1.riders[2];
  }

  flag_set("move_to_pillar");
}

monitor_low_road_group() {
  trigger_wait("low_road_bigrig_entry");
  wait 1;

  while(get_ai_group_count("low_road_choke_group1b") + get_ai_group_count("ai_group_low_road_left_side_flood") > 5)
    wait 0.5;

  flag_set("move_to_pillar");
}

kill_truck_gunners() {
  flag_wait("move_to_pillar");
  vh_truck1 = getent("truck_03", "targetname");
  array_thread(vh_truck1.riders, ::bloody_death);
  wait 2;
  vh_truck2 = getent("truck_07", "targetname");
  array_thread(vh_truck2.riders, ::bloody_death);
}

potus_cover() {
  level.hillary endon("death");
  cover_1();
  flag_wait("low_road_move_up_2");
  wait 4;
  cover_2();
  flag_wait("move_to_pillar");
  level.player queue_dialog("sect_push_through_the_g2_0", 2);
  wait 1;
  cover_3();
  flag_wait("low_road_move_up_4");
  cover_convoy();
}

cover_1() {
  level thread run_scene_and_delete("group_cover_idle1");
}

cover_2() {
  level.hillary.ignoreme = 1;
  run_scene_and_delete("group_cover_go2");
  level thread run_scene_and_delete("group_cover_idle2");
  level.hillary.ignoreme = 0;
  level thread bus_react();
}

cover_2_optional_vo() {
  if(flag("harper_dead") && !flag("low_road_complete"))
    level.sam say_dialog("stay_down_011");
}

bus_react() {
  level endon("group_cover_go3_started");

  while(true) {
    level waittill("bus_rock");
    run_scene("group_cover_bus_react");
  }
}

cover_3() {
  level.hillary.ignoreme = 1;

  if(!flag("harper_dead"))
    level.harper.perfectaim = 1;

  run_scene_and_delete("group_cover_go3");
  level thread run_scene_and_delete("group_cover_idle3");
  level.hillary.ignoreme = 0;
  trigger_on("low_road_debris_fall");
  trigger_wait("low_road_debris_fall");
}

cover_3_optional_vo() {
  level endon("low_road_snipers_cleared");

  if(flag("harper_dead") && !flag("low_road_complete")) {
  }
}

monitor_bigrig_guys() {
  waittill_ai_group_ai_count("low_road_choke_group1", 2);
  a_ai_guys = get_ai_group_ai("low_road_choke_group1");

  foreach(ai_guy in a_ai_guys)
  ai_guy die();
}

spawn_fun_sniper_van() {
  self endon("death");
  self waittill("unload");
  set_turret_burst_parameters(3, 4.5, 1, 1.5, 1);
  self set_turret_target(level.player, undefined, 1);
}

cover_convoy() {
  level.hillary.ignoreme = 1;
  run_scene_and_delete("group_to_convoy");
  level thread run_scene_and_delete("group_convoy_loop");
}

rush_potus() {
  a_enemies = get_rush_enemies();

  while(a_enemies.size > 0) {
    a_enemies = remove_dead_from_array(a_enemies);

    if(a_enemies.size > 0) {
      enemy = a_enemies[getarraykeys(a_enemies)[randomint(getarraykeys(a_enemies).size)]];
      a_rush_goal_nodes = getnodearray("low_road_rush_node", "targetname");
      nd_goal = getclosest(level.hillary.origin, a_rush_goal_nodes);
      enemy.goalradius = 300;
      enemy setgoalnode(nd_goal);
      wait(randomfloatrange(4, 4 + a_enemies.size));
    }
  }
}

get_rush_enemies() {
  e_volume1 = level.goalvolumes["goal_volume_left_side"];
  e_volume2 = level.goalvolumes["goal_volume_right_side"];
  a_rush_enemies = [];
  a_enemies = getaiarray("axis");

  foreach(enemy in a_enemies) {
    if(isDefined(enemy.targetname) && issubstr(enemy.targetname, "fakey_dude") || issubstr(enemy.classname, "rpg")) {
      continue;
    }
    if(enemy istouching(e_volume1) || enemy istouching(e_volume2)) {
      a_rush_enemies[a_rush_enemies.size] = enemy;
      continue;
    }

    if(!isDefined(enemy.script_aigroup) && !isDefined("ai_group_low_road_left_side_flood") || isDefined(enemy.script_aigroup) && isDefined("ai_group_low_road_left_side_flood") && enemy.script_aigroup == "ai_group_low_road_left_side_flood") {
      a_rush_enemies[a_rush_enemies.size] = enemy;
      continue;
    }

    if(!isDefined(enemy.script_aigroup) && !isDefined("ai_group_low_road_right_side_flood") || isDefined(enemy.script_aigroup) && isDefined("ai_group_low_road_right_side_flood") && enemy.script_aigroup == "ai_group_low_road_right_side_flood")
      a_rush_enemies[a_rush_enemies.size] = enemy;
  }

  return a_rush_enemies;
}

attack_potus() {
  if(flag("sniper_option")) {
  }

  self setthreatbiasgroup("potus_rushers");
  self.aggressivemode = 1;
  self.canflank = 1;
}

g20_group_meetup() {
  level endon("player_in_cougar");
  level thread run_scene("cougar_drive_wires");

  if(!flag("harper_dead")) {
    level thread run_scene_and_delete("g20_group1_greet_harper");
    level delay_thread(0.5, ::run_scene_and_delete, "g20_group1_greet", 0.5);
    level.harper waittill("goal");
    level.veh_player_cougar setanim( % v_la_03_12_entercougar_cougar, 1, 0, 1);
    scene_wait("g20_group1_greet_harper");
    level thread harper_set_friendly_fire();
    run_scene_and_delete("harper_wait_in_cougar");
  } else {
  }
}

harper_set_friendly_fire() {
  flag_wait("harper_wait_in_cougar_started");
  level.harper setcandamage(1);
}

noharper_open_cougar_door() {
  if(flag("harper_dead")) {
    veh_player_cougar = get_player_cougar();
    veh_player_cougar setanim( % v_la_03_12_entercougar_cougar, 1, 0, 1);
  }
}

sniper_rappel_options() {
  level thread rappel_option();
  level thread sniper_option();
  flag_wait_any("rappel_option", "sniper_option");
  stop_exploder(1001);
  level.player enablehealthshield(1);
  level.enable_straffing_drone_missiles = undefined;
  set_objective(level.obj_snipe, undefined, "delete");
  set_objective(level.obj_rappel, undefined, "delete");
  set_objective(level.obj_potus, level.hillary, "protect");
  level.player setlowready(0);
}

sniper_rappel_choice_fail() {
  level endon("sniper_option");
  level endon("rappel_option");
  wait 15;
  level.player enablehealthshield(0);
  level.enable_straffing_drone_missiles = 1;
}

sniper_option() {
  level endon("rappel_option");
  level.player waittill_player_has_sniper_weapon();
  flag_set("player_has_sniper_weapon");
  t_sniper = getent("sniper_trigger", "targetname");
  set_objective(level.obj_snipe, t_sniper.origin, & "LA_SHARED_OBJ_SNIPE");
  t_sniper trigger_wait();
  level.player switch_player_to_sniper_weapon();
  flag_wait("grouprappel_done");
  waittill_ai_group_cleared("low_road_choke_group2");
  waittill_ai_group_cleared("low_road_snipers");
}

exit_sniper() {
  level thread sniper_exit_vo();
  set_objective(level.obj_rappel2, get_scene_start_pos("exit_sniper_player", "player_body"), & "LA_SHARED_OBJ_RAPPEL_3D");
  trigger_on("sniper_fastrope_trigger");
  trigger_wait("sniper_fastrope_trigger");
  exploder(311);
  trigger = getent("kill_trigger_rappel", "targetname");
  trigger delete();
  flag_set("started_rappelling");
  level.player magic_bullet_shield();
  set_objective(level.obj_rappel2, undefined, "delete");
  level thread run_scene_and_delete("exit_sniper_player", 0.5);
  level thread player_rumble_exit_sniper();
  run_scene_and_delete("exit_sniper");
  flag_set("done_rappelling");
  level thread autosave_by_name("after_exit_sniper");
  level.player setclientdvar("player_sprintUnlimited", 1);
  level thread pause_rpg_guys();
  level.player stop_magic_bullet_shield();

  if(flag("player_brought_shield")) {
    if(!level.player hasweapon("riotshield_sp"))
      level.player giveweapon("riotshield_sp");
  }
}

turn_off_breadcrumb_obj() {
  trigger_wait("g20_objective_trigger");
  set_objective(level.obj_highway, undefined, "remove");
}

pause_rpg_guys() {
  a_rpg_guys = getentarray("exit_sniper_rpg_guy_ai", "targetname");

  foreach(ai_rpg in a_rpg_guys) {
    if(isalive(ai_rpg))
      ai_rpg.a.allow_shooting = 0;
  }

  wait 4;

  foreach(ai_rpg in a_rpg_guys) {
    if(isalive(ai_rpg))
      ai_rpg.a.allow_shooting = 1;
  }
}

rappel_option() {
  level endon("sniper_option");
  s_align = get_struct("align_rappel", "targetname", 1);
  s_align.angles = (0, 0, 0);
  t_rappel = getent("rappel_trigger", "targetname");

  if(level.player player_has_sniper_weapon())
    set_objective(level.obj_rappel, t_rappel.origin, & "LA_SHARED_OBJ_RAPPEL");
  else
    set_objective(level.obj_rappel, t_rappel.origin, & "LA_SHARED_RAPPEL");

  t_rappel trigger_wait();
  level.player magic_bullet_shield();
  set_objective(level.obj_rappel);
  level.player delay_thread(3, ::switch_player_scene_to_delta);
  exploder(310);
  trigger = getent("kill_trigger_rappel", "targetname");
  trigger delete();
  flag_set("started_rappelling");
  level thread player_rappel_rumble();
  run_scene_and_delete("grouprappel_player");
  flag_set("done_rappelling");
  level.player stop_magic_bullet_shield();
}

player_rumble_exit_sniper() {
  flag_wait("exit_sniper_player_started");
  wait 5;
  level.player playrumbleonentity("rappel_falling");
  wait 2;
  level.player stoprumble("rappel_falling");
  flag_wait("car_fall");
  wait 0.1;
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.3, 2.0, level.player.origin, 100);
}

player_rappel_rumble() {
  flag_wait("grouprappel_player_started");
  flag_wait("start_rappel_rumble");
  wait 2;
  level.player playrumbleonentity("rappel_falling");
  flag_wait("stop_rappel_rumble");
  level.player stoprumble("rappel_falling");
  wait 0.1;
  level.player playrumbleonentity("damage_heavy");
}

switch_player_to_delta() {
  wait 4;
  level.player switch_player_scene_to_delta();
}

return_true() {
  return true;
}

play_rappel_ambient_fx() {
  level endon("rappel_option");
  level endon("sniper_option");
  flag_wait("player_approaches_low_road");
  level thread play_random_gun_shots();
  level thread drone_squibs();

  while(true) {
    n_index = randomintrange(1, 4);
    rpg_start = getstruct("rpg_ambient_shot_start_" + n_index, "targetname");
    rpg_end = getstruct("rpg_ambient_shot_end_" + n_index, "targetname");
    wait(randomfloatrange(3, 6));
  }
}

drone_squibs() {
  level endon("rappel_option");
  level endon("sniper_option");
  trigger_wait("trigger_drone_squibs");
  squibs_start = getstruct("drone_squibs_1", "targetname");
  squibs_end = getstruct("rpg_ambient_shot_end_2", "targetname");

  for(i = 0; i < 10; i++) {
    magicbullet("f35_side_minigun", squibs_start.origin, squibs_end.origin + (0, 500 - i * 50, 0));
    wait 0.25;
  }
}

play_random_gun_shots() {
  level endon("rappel_option");
  level endon("sniper_option");

  while(true) {
    squibs_start = getstruct("squibs_start_" + randomintrange(1, 6), "targetname");
    squibs_end = getstruct("squibs_target_" + randomintrange(1, 6), "targetname");

    for(i = 0; i < 6; i++) {
      magicbullet("xm8_sp", squibs_start.origin, squibs_end.origin);
      wait 0.05;
    }

    wait(randomfloatrange(0.15, 0.25));
  }
}