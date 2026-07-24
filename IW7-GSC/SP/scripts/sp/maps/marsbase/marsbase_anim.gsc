/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_anim.gsc
******************************************************/

main() {
  precachemodel("engineer_blowtorch_pmars");
  precachemodel("weapon_erad_mag_pmars");
  _id_775B();
  script_model();
  player();
  _id_3353();
  _id_341D();
  _id_3508();
  vehicle();
  _id_A056();
}

#using_animtree("generic_human");

_id_775B() {
  level._id_EC85["dropship_redshirt1"]["dropship_exit"] = % mars_10_16_ally01_dropship_exit;
  level._id_EC85["dropship_redshirt2"]["dropship_exit"] = % mars_10_16_ally02_dropship_exit;
  level._id_EC85["dropship_redshirt3"]["dropship_exit"] = % mars_10_16_ally03_dropship_exit;
  level._id_EC85["dropship_redshirt4"]["dropship_exit"] = % mars_10_16_ally04_dropship_exit;
  level._id_EC85["dropship_redshirt5"]["dropship_exit"] = % mars_10_16_ally05_dropship_exit;
  level._id_EC85["dropship_redshirt6"]["dropship_exit"] = % mars_10_16_ally06_dropship_exit;
  level._id_EC85["commo"]["dropship_exit"] = % mars_10_16_comm_dropship_exit;
  level._id_EC85["dropoff"]["dropship_exit"] = % mars_10_16_do_dropship_exit;
  level._id_EC85["griff"]["dropship_exit"] = % mars_10_16_arm_dropship_exit;
  level._id_EC85["dropship_redshirt7"]["dropship_exit"] = % mars_10_16_eng_dropship_exit;
  level._id_EC85["gator"]["dropship_exit"] = % mars_10_16_nav_dropship_exit;
  level._id_EC85["sahora"]["dropship_exit"] = % mars_10_16_mr1_dropship_exit;
  level._id_EC85["salter"]["dropship_exit"] = % mars_10_16_xo_dropship_exit;
  level._id_EC85["ethan"]["dropship_exit"] = % mars_10_16_c6i_dropship_exit;
  scripts\sp\anim::_id_17FC("dropship_redshirt5", "open_door", "dropship_open_door");
  scripts\sp\anim::_id_17F6("commo", "female_shot", ::_id_5DDD);
  scripts\sp\anim::_id_17F6("dropoff", "officer_shot", ::_id_5DDD);
  scripts\sp\anim::_id_17F6("dropship_redshirt3", "redshirt_shot", ::_id_5DDD);
  level._id_EC89["dropship_redshirt1"]["dropship_exit"] = 0;
  level._id_EC89["dropship_redshirt2"]["dropship_exit"] = 0;
  level._id_EC89["dropship_redshirt3"]["dropship_exit"] = 0;
  level._id_EC89["dropship_redshirt4"]["dropship_exit"] = 0;
  level._id_EC89["dropship_redshirt5"]["dropship_exit"] = 0;
  level._id_EC89["dropship_redshirt6"]["dropship_exit"] = 0;
  level._id_EC89["dropship_redshirt7"]["dropship_exit"] = 0;
  level._id_EC89["commo"]["dropship_exit"] = 0;
  level._id_EC89["dropoff"]["dropship_exit"] = 0;
  level._id_EC89["griff"]["dropship_exit"] = 0;
  level._id_EC89["mccallum"]["dropship_exit"] = 0;
  level._id_EC89["gator"]["dropship_exit"] = 0;
  level._id_EC89["sahora"]["dropship_exit"] = 0;
  level._id_EC89["salter"]["dropship_exit"] = 0;
  level._id_EC89["ethan"]["dropship_exit"] = 0;
  level._id_EC85["salter"]["salter_takedown"] = % mars_base_exit_dropship_xo_attack_xo;
  level._id_EC85["salter_victim"]["salter_takedown"] = % mars_base_exit_dropship_xo_attack_enemy;
  level._id_EC85["jackal_pilot_pip"]["jackal_pilot_idle"][0] = % mars_base_jackal_pilot_pip;
  level._id_EC85["mccallum"]["ihaveasupport"] = % mars_base_mccallum_pip;
  level._id_EC85["jackal_pilot_pip"]["inboundforgun"] = % mars_jack_pip_rogerinboundforgun;
  level._id_EC85["jackal_pilot_pip"]["timetotarget5"] = % mars_jack_pip_timetotarget5;
  level._id_EC85["jackal_pilot_pip"]["jackalsareweaponsloose"] = % mars_jack_pip_jackalsareweaponsloose;
  level._id_EC85["jackal_pilot_pip"]["captainbeadvisedaa"] = % mars_jack_pip_captainbeadvisedaa;
  level._id_EC85["jackal_pilot_pip"]["negativetwo-fiveisweapons"] = % mars_jack_pip_negativetwo_fiveisweapons;
  level._id_EC85["jackal_pilot_pip"]["understoodcommanderillram"] = % mars_jack_pip_understoodcommanderillram;
  level._id_EC85["jackal_pilot_pip"]["kamikaze"] = % mars_jack_pip_kamikaze;
  level._id_EC89["jackal_pilot_pip"]["timetotarget5"] = 0.0;
  level._id_EC89["jackal_pilot_pip"]["jackalsareweaponsloose"] = 0.0;
  level._id_EC89["jackal_pilot_pip"]["captainbeadvisedaa"] = 0.0;
  level._id_EC89["jackal_pilot_pip"]["negativetwo"] = 0.0;
  level._id_EC85["engineer1"]["engineer_gate_arrive"] = % mars_gate_support_1_ally01_arrive;
  level._id_EC85["engineer2"]["engineer_gate_arrive"] = % mars_gate_support_1_ally02_arrive;
  level._id_EC85["engineer3"]["engineer_gate_arrive"] = % mars_gate_support_1_ally03_arrive;
  level._id_EC85["engineer1"]["engineer_gate_arrive_idle"][0] = % mars_gate_support_1_ally01_arrive_idle;
  level._id_EC85["engineer2"]["engineer_gate_arrive_idle"][0] = % mars_gate_support_1_ally02_arrive_idle;
  level._id_EC85["engineer3"]["engineer_gate_arrive_idle"][0] = % mars_gate_support_1_ally03_arrive_idle;
  level._id_EC85["engineer1"]["engineer_gate_open"] = % mars_gate_support_1_ally01_open_gate;
  level._id_EC85["engineer2"]["engineer_gate_open"] = % mars_gate_support_1_ally02_open_gate;
  level._id_EC85["engineer3"]["engineer_gate_open"] = % mars_gate_support_1_ally03_open_gate;
  scripts\sp\anim::_id_17FC("engineer2", "open_gate", "open_gate");
  scripts\sp\anim::_id_17FC("engineer2", "start_ally01_anim", "start_ally01_anim");
  scripts\sp\anim::_id_17FC("engineer3", "start_blowtorch", "start_blowtorch");
  scripts\sp\anim::_id_17FC("engineer3", "stop_blowtorch", "stop_blowtorch");
  level._id_EC85["engineer1"]["engineer_gate_open_idle"][0] = % mars_gate_support_1_ally01_idle;
  level._id_EC85["engineer2"]["engineer_gate_open_idle"][0] = % mars_gate_support_1_ally02_idle;
  level._id_EC85["engineer3"]["engineer_gate_open_idle"][0] = % mars_gate_support_1_ally03_idle;
  level._id_EC85["engineer1"]["engineer_gate_enter"] = % mars_gate_support_1_ally01_enter_gate;
  level._id_EC85["engineer2"]["engineer_gate_enter"] = % mars_gate_support_1_ally02_enter_gate;
  level._id_EC85["engineer3"]["engineer_gate_enter"] = % mars_gate_support_1_ally03_enter_gate;
  level._id_EC85["generic"]["greenhouse_gate_enemy_slide_in"] = % mars_gate_support_1_enemy_slide_in;
  level._id_EC85["generic"]["turret_aim_idle"][0] = % humvee_turret_aim_2;
  level._id_EC85["greenhouse_enemy1"]["greenhouse_enemy_retreat"] = % mars_gate_support_1_enemy01_enemy_activity;
  level._id_EC85["greenhouse_enemy2"]["greenhouse_enemy_retreat"] = % mars_gate_support_1_enemy02_enemy_activity;
  level._id_EC85["greenhouse_enemy3"]["greenhouse_enemy_retreat"] = % mars_gate_support_1_enemy03_enemy_activity;
  level._id_EC85["greenhouse_enemy4"]["greenhouse_enemy_retreat"] = % mars_gate_support_1_enemy04_enemy_activity;
  level._id_EC85["greenhouse_enemy5"]["greenhouse_enemy_retreat"] = % mars_gate_support_1_enemy05_enemy_activity;
  level._id_EC85["greenhouse_enemy6"]["greenhouse_enemy_retreat"] = % mars_gate_support_1_enemy06_enemy_activity;
  level._id_EC85["greenhouse_enemy7"]["greenhouse_enemy_retreat"] = % mars_gate_support_1_enemy07_enemy_activity;
  level._id_EC85["greenhouse_enemy8"]["greenhouse_enemy_retreat"] = % mars_gate_support_1_enemy08_enemy_activity;
  level._id_EC85["generic"]["dropship3_burning_marine_01"] = % mars_base_greenhouse_dropship_crash_burning1;
  level._id_EC85["generic"]["dropship3_burning_marine_02"] = % mars_base_greenhouse_dropship_crash_burning2;
  level._id_EC85["salter"]["exitdoor_intro"] = % mars_10_19_gator_door_xo_door_intro;
  level._id_EC85["salter"]["exitdoor_idle"][0] = % mars_10_19_gator_door_xo_door_idle;
  level._id_EC85["salter"]["exitdoor_react_intro"] = % mars_10_19_gator_door_xo_react_to_plr_intro;
  level._id_EC85["salter"]["exitdoor_react_idle"][0] = % mars_10_19_gator_door_xo_react_to_plr_idle;
  level._id_EC85["salter"]["exitdoor_react_to_pull"] = % mars_10_19_gator_door_xo_door_react;
  level._id_EC85["salter"]["exitdoor_pull"][0] = % mars_10_19_gator_door_xo_door_pull;
  level._id_EC85["salter"]["exitdoor_outro"] = % mars_10_19_gator_door_xo_react_nav_death;
  level._id_EC85["salter"]["exitdoor_outro_idle"][0] = % mars_10_19_gator_door_xo_door_outtro_idle;
  level._id_EC85["exitengineer"]["exitengineer_idle"][0] = % mars_gator_death_engineer_killed_ally01_idle;
  level._id_EC85["exitengineer"]["exitsniper_kill"] = % mars_gator_death_engineer_killed_ally01_death;
  level._id_EC85["exitsniper"]["exitsniper_kill_shoot"] = % mars_gator_death_engineer_killed_enemy01_shot;
  scripts\sp\anim::_id_17FC("exitsniper", "exitsniper_fire", "exitsniper_shoot");
  level._id_EC85["generic"]["aa2_signaling_soldier"] = % mars_aa2_signaling_soldier;
  level._id_EC85["ethan"]["aa2_start_kill"] = % mars_base_greenhouse_eth3n_kill;
  level._id_EC85["generic"]["aa2_start_kill"] = % mars_base_greenhouse_eth3n_kill_enemy;
  level._id_EC85["greenhouse_fallguy1"]["greenhouse_fallguy"] = % mars_greenhouse_chasm_fall_guy01;
  level._id_EC85["greenhouse_fallguy2"]["greenhouse_fallguy"] = % mars_greenhouse_chasm_fall_guy02;
  level._id_EC85["generic"]["burning_man"] = % mars_6_1_burningman;
  level._id_EC85["generic"]["burning_man_crawling"] = % mars_6_1_burningman_crawling;
  level._id_EC85["generic"]["burning_man_top"] = % mars_6_1_burningman_top;
  level._id_EC85["uphill_commander_left"]["uphill_battle_left"] = % mars_uphill_battle_left_hill_enemy01;
  level._id_EC85["uphill_commander_middle"]["uphill_battle_middle"] = % mars_uphill_battle_middle_hill_enemy01;
  level._id_EC85["uphill_commander_right"]["uphill_battle_right"] = % mars_uphill_battle_right_hill_enemy01;
  level._id_EC85["hill_hero_redshirt"]["anim_hill_intro_eng_kill_c12"] = % mars_base_hill_intro_eng_kill_c12;
  scripts\sp\anim::_id_17FC("hill_hero_redshirt", "Fspar_on", "Fspar_on");
  scripts\sp\anim::_id_17FC("hill_hero_redshirt", "Fspar_off", "Fspar_off");
  scripts\sp\anim::_id_17FC("hill_hero_redshirt", "fspar_land", "fspar_land");
  level._id_EC85["executed"]["bridge_execution"] = % mars_base_elevator_shoot_enemy;
  level._id_EC85["executioner"]["bridge_execution"] = % mars_base_elevator_shoot_enemy_ally;
  scripts\sp\anim::_id_17FC("executioner", "fire", "execution_fire");
  level._id_EC85["elevator_igc_engineer_0"]["elevator_gate_enter"] = % mar_10_21_base_ally01_through_gate;
  level._id_EC85["elevator_igc_engineer_1"]["elevator_gate_enter"] = % mar_10_21_base_ally02_through_gate;
  level._id_EC85["elevator_igc_engineer_2"]["elevator_gate_enter"] = % mar_10_21_base_ally03_through_gate;
  level._id_EC85["elevator_fscm"]["elevator_gate_enter"] = % mar_10_21_base_ally04_through_gate;
  level._id_EC85["elevator_mscm"]["elevator_gate_enter"] = % mar_10_21_base_ally05_through_gate;
  level._id_EC85["elevator_mfcm"]["elevator_gate_enter"] = % mar_10_21_base_ally06_through_gate;
  level._id_EC85["boats"]["elevator_gate_enter"] = % mar_10_21_base_ally07_through_gate;
  level._id_EC85["kloos"]["elevator_gate_enter"] = % mar_10_21_base_ally08_through_gate;
  level._id_EC85["griff"]["elevator_gate_enter"] = % mar_10_21_base_arm_through_gate;
  level._id_EC85["ethan"]["elevator_gate_enter"] = % mar_10_21_base_c6i_through_gate;
  level._id_EC85["mccallum"]["elevator_gate_enter"] = % mar_10_21_base_eng_through_gate;
  level._id_EC85["brooks"]["elevator_gate_enter"] = % mar_10_21_base_mr1_through_gate;
  level._id_EC85["salter"]["elevator_gate_enter"] = % mar_10_21_base_xo_through_gate;
  level._id_EC85["generic"]["elevator_hall_director_idle"][0] = % mars_base_elev_allies_directing_nag_idle_ally01;
  level._id_EC85["generic"]["elevator_hall_director_enter"] = % mars_base_elev_allies_directing_enter_ally01;
  level._id_EC85["generic"]["elevator_npc01_get_in"] = % mars_elevator_enter_ally01_get_in;
  level._id_EC85["generic"]["elevator_npc01_get_out"] = % mars_elevator_enter_ally01_get_out;
  level._id_EC85["generic"]["elevator_npc01_idle"][0] = % mars_elevator_enter_ally01_idle;
  level._id_EC85["boats"]["elevator_npc01_get_in"] = % mars_elevator_enter_ally01_get_in;
  level._id_EC85["boats"]["elevator_npc01_get_out"] = % mars_elevator_enter_ally01_get_out;
  level._id_EC85["boats"]["elevator_npc01_idle"][0] = % mars_elevator_enter_ally01_idle;
  level._id_EC85["generic"]["elevator_npc02_get_in"] = % mars_elevator_enter_ally02_get_in;
  level._id_EC85["generic"]["elevator_npc02_get_out"] = % mars_elevator_enter_ally02_get_out;
  level._id_EC85["generic"]["elevator_npc02_idle"][0] = % mars_elevator_enter_ally02_idle;
  level._id_EC85["generic"]["elevator_ride_wait_idle"][0] = % mars_10_22_elev_ally01_dropseat_idle;
  level._id_EC85["generic"]["elevator_ride_wait_get_in"] = % mars_10_22_elev_ally01_dropseat_get_in;
  level._id_EC85["boats"]["elevator_ride_wait_get_in"] = % mars_10_22_elev_ally01_dropseat_get_in;
  level._id_EC85["brooks"]["elevator_ride_wait_get_in"] = % mars_10_22_elev_mr1_dropseat_get_in;
  level._id_EC85["brooks"]["elevator_ride_wait_idle"][0] = % mars_10_22_elev_mr1_dropseat_idle;
  level._id_EC85["ethan"]["elevator_ride_wait_idle"][0] = % mars_10_22_elev_c6i_dropseat_idle;
  level._id_EC85["griff"]["elevator_ride_wait_idle"][0] = % mars_10_22_elev_arm_idle;
  level._id_EC85["mccallum"]["elevator_ride_wait_idle"][0] = % mars_10_22_elev_eng_dropseat_idle;
  level._id_EC85["salter"]["elevator_ride_wait_idle"][0] = % mars_10_22_elev_xo_dropseat_idle;
  level._id_EC85["salter"]["elevator_ride_wait_nag"] = % mars_10_22_elev_xo_dropseat_nag;
  level._id_EC85["boats"]["elevator_ride_wait_idle"][0] = % mars_10_22_elev_ally01_scene_end_idle;
  level._id_EC85["griff"]["elevator_rideup"] = % mars_10_22_elev_start_scene_arm;
  level._id_EC85["brooks"]["elevator_rideup"] = % mars_10_22_elev_start_scene_mr1;
  level._id_EC85["salter"]["elevator_rideup"] = % mars_10_22_elev_start_scene_xo;
  level._id_EC85["ethan"]["elevator_rideup"] = % mars_10_22_elev_start_scene_c6i;
  level._id_EC85["mccallum"]["elevator_rideup"] = % mars_10_22_elev_start_scene_eng;
  level._id_EC85["generic"]["elevator_rideup"] = % mars_10_22_elev_start_scene_ally01;
  level._id_EC85["boats"]["elevator_rideup"] = % mars_10_22_elev_start_scene_ally01;
  level._id_EC85["brooks"]["elevator_npc01_idle"][0] = % mars_elevator_enter_ally01_idle;
  level._id_EC85["ethan"]["elevator_npc01_idle"][0] = % mars_elevator_enter_ally01_idle;
  level._id_EC85["mccallum"]["elevator_npc01_idle"][0] = % mars_elevator_enter_ally01_idle;
  level._id_EC85["salter"]["elevator_npc01_idle"][0] = % mars_elevator_enter_ally01_idle;
  level._id_EC85["boats"]["elevator_npc01_idle"][0] = % mars_elevator_enter_ally01_idle;
  level._id_EC85["dead_body"]["generic_dead_civ_01"][0] = % generic_dead_civ_01;
  level._id_EC85["dead_body"]["generic_dead_civ_02"][0] = % generic_dead_civ_02;
  level._id_EC85["dead_body"]["generic_dead_civ_03"][0] = % generic_dead_civ_03;
  level._id_EC85["dead_body"]["generic_dead_civ_04"][0] = % generic_dead_civ_04;
  level._id_EC85["dead_body"]["generic_dead_civ_05"][0] = % generic_dead_civ_05;
  level._id_EC85["dead_body"]["generic_dead_civ_06"][0] = % generic_dead_civ_06;
  level._id_EC85["dead_body"]["generic_dead_civ_07"][0] = % generic_dead_civ_07;
  level._id_EC85["dead_body"]["generic_dead_civ_fem_01"][0] = % generic_dead_civ_fem_01;
  level._id_EC85["dead_body"]["generic_dead_civ_fem_02"][0] = % generic_dead_civ_fem_02;
  level._id_EC85["dead_body"]["generic_dead_civ_fem_03"][0] = % generic_dead_civ_fem_03;
  level._id_EC85["dead_body"]["generic_dead_civ_fem_04"][0] = % generic_dead_civ_fem_04;
  level._id_EC85["dead_body"]["generic_dead_civ_fem_05"][0] = % generic_dead_civ_fem_05;
  level._id_EC85["dead_body"]["generic_dead_civ_fem_06"][0] = % generic_dead_civ_fem_06;
  level._id_EC85["dead_body"]["generic_dead_civ_fem_07"][0] = % generic_dead_civ_fem_07;
  level._id_EC85["dead_body"]["generic_dead_wall_lean_civ_01"][0] = % generic_dead_wall_lean_civ_01;
  level._id_EC85["dead_body"]["generic_dead_wall_lean_civ_02"][0] = % generic_dead_wall_lean_civ_02;
  level._id_EC85["dead_body"]["generic_dead_wall_lean_civ_03"][0] = % generic_dead_wall_lean_civ_03;
}

_id_5DDD(var_0) {
  var_1 = scripts\engine\utility::getStruct("struct_murder_ci", "targetname");
  var_2 = var_1.origin;
  var_3 = var_0 gettagorigin("j_head");

  for(var_4 = 0; var_4 < 4; var_4++) {
    magicbullet("iw7_ar57", var_2, var_3);
    bullettracer(var_2, var_3, "iw7_ar57", 1);
    wait(randomfloatrange(0, 0.15));
  }
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["klaxon"] = #animtree;
  level._id_EC85["klaxon"]["klaxon_spin"][0] = % claxon_spin_loop;
  level._id_EC87["tarp"] = #animtree;
  level._id_EC85["tarp"]["fxanim_tarp_wall_lrg_01"][0] = % iw7_fxanim_gp_tarp_wall_lrg_01_anim;
  level._id_EC85["tarp"]["fxanim_tarp_wall_lrg_02"][0] = % iw7_fxanim_gp_tarp_wall_lrg_02_anim;
  level._id_EC85["tarp"]["fxanim_tarp_wall_lrg_03"][0] = % iw7_fxanim_gp_tarp_wall_lrg_03_anim;
  level._id_EC85["tarp"]["fxanim_tarp_billow_lrg_01"][0] = % iw7_fxanim_gp_tarp_billow_lrg_01_anim;
  level._id_EC87["dropship_intro_wires"] = #animtree;
  level._id_EC85["dropship_intro_wires"]["fxanim_dropship_intro_wires_slow"][0] = % iw7_fxanim_sp_mars_dropship_wire_loop_anim;
  level._id_EC85["dropship_intro_wires"]["fxanim_dropship_intro_wires_fast"][0] = % iw7_fxanim_sp_mars_dropship_damage_parts_wire_loop_anim;
  level._id_EC87["dropship_intro_damage_parts"] = #animtree;
  level._id_EC85["dropship_intro_damage_parts"]["fxanim_dropship_intro_damage"] = % iw7_fxanim_sp_mars_dropship_damage_parts_anim;
  level._id_EC87["fxanim_platform_debris"] = #animtree;
  level._id_EC85["fxanim_platform_debris"]["dropship_exit_platform_debris"] = % iw7_fxanim_sp_mars_platform_debris_01_anim;
  level._id_EC87["fxanim_rockslide"] = #animtree;
  level._id_EC85["fxanim_rockslide"]["jackal_crash_rockslide"] = % iw7_fxanim_sp_mars_rockslide_anim;
  level._id_EC87["aa1_jackal_debris"] = #animtree;
  level._id_EC85["aa1_jackal_debris"]["fxanim_aa1_jackal_debris"] = % iw7_fxanim_sp_mars_jackal_crash_debris_anim;
  level._id_EC87["animname_aa_gun_1_1"] = #animtree;
  level._id_EC87["animname_aa_gun_1_2"] = #animtree;
  level._id_EC87["animname_aa_gun_2"] = #animtree;
  level._id_EC87["animname_aa_gun_3"] = #animtree;
  level._id_EC87["animname_aa_gun_4"] = #animtree;
  level._id_EC85["animname_aa_gun_1_1"]["fxanim_aa_gun_fire"][0] = % iw7_fxanim_sp_mars_aa_turret_gun_loop_anim;
  level._id_EC85["animname_aa_gun_1_2"]["fxanim_aa_gun_fire"][0] = % iw7_fxanim_sp_mars_aa_turret_gun_loop_anim;
  level._id_EC85["animname_aa_gun_2"]["fxanim_aa_gun_fire"][0] = % iw7_fxanim_sp_mars_aa_turret_gun_loop_anim;
  level._id_EC85["animname_aa_gun_3"]["fxanim_aa_gun_fire"][0] = % iw7_fxanim_sp_mars_aa_turret_gun_loop_anim;
  level._id_EC85["animname_aa_gun_4"]["fxanim_aa_gun_fire"][0] = % iw7_fxanim_sp_mars_aa_turret_gun_loop_anim;
  level._id_EC89["animname_aa_gun_1_1"]["fxanim_aa_gun_fire"] = 1.0;
  level._id_EC89["animname_aa_gun_1_2"]["fxanim_aa_gun_fire"] = 1.0;
  level._id_EC89["animname_aa_gun_2"]["fxanim_aa_gun_fire"] = 1.0;
  level._id_EC89["animname_aa_gun_3"]["fxanim_aa_gun_fire"] = 1.0;
  level._id_EC89["animname_aa_gun_4"]["fxanim_aa_gun_fire"] = 1.0;
  scripts\sp\anim::_id_17F6("animname_aa_gun_1_1", "fire_top_barrels", scripts\sp\maps\marsbase\marsbase_code::_id_14E6);
  scripts\sp\anim::_id_17F6("animname_aa_gun_1_1", "fire_bottom_barrels", scripts\sp\maps\marsbase\marsbase_code::_id_14E5);
  scripts\sp\anim::_id_17F6("animname_aa_gun_1_2", "fire_top_barrels", scripts\sp\maps\marsbase\marsbase_code::_id_14E6);
  scripts\sp\anim::_id_17F6("animname_aa_gun_1_2", "fire_bottom_barrels", scripts\sp\maps\marsbase\marsbase_code::_id_14E5);
  scripts\sp\anim::_id_17F6("animname_aa_gun_2", "fire_top_barrels", scripts\sp\maps\marsbase\marsbase_code::_id_14E6);
  scripts\sp\anim::_id_17F6("animname_aa_gun_2", "fire_bottom_barrels", scripts\sp\maps\marsbase\marsbase_code::_id_14E5);
  scripts\sp\anim::_id_17F6("animname_aa_gun_3", "fire_top_barrels", scripts\sp\maps\marsbase\marsbase_code::_id_14E6);
  scripts\sp\anim::_id_17F6("animname_aa_gun_3", "fire_bottom_barrels", scripts\sp\maps\marsbase\marsbase_code::_id_14E5);
  scripts\sp\anim::_id_17F6("animname_aa_gun_4", "fire_top_barrels", scripts\sp\maps\marsbase\marsbase_code::_id_14E6);
  scripts\sp\anim::_id_17F6("animname_aa_gun_4", "fire_bottom_barrels", scripts\sp\maps\marsbase\marsbase_code::_id_14E5);
  scripts\sp\anim::_id_1800("animname_aa_gun_1_1", "fire_top_barrels", "fxanim_aa_gun_fire", "vfx_mars_aa_muzzle_flash", "fx_barrel_1_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_1_1", "fire_bottom_barrels", "fxanim_aa_gun_fire", "vfx_mars_aa_muzzle_flash", "fx_barrel_2_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_1_2", "fire_top_barrels", "fxanim_aa_gun_fire", "vfx_mars_aa_muzzle_flash", "fx_barrel_1_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_1_2", "fire_bottom_barrels", "fxanim_aa_gun_fire", "vfx_mars_aa_muzzle_flash", "fx_barrel_2_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_2", "fire_top_barrels", "fxanim_aa_gun_fire", "vfx_mars_aa_muzzle_flash", "fx_barrel_1_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_2", "fire_bottom_barrels", "fxanim_aa_gun_fire", "vfx_mars_aa_muzzle_flash", "fx_barrel_2_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_3", "fire_top_barrels", "fxanim_aa_gun_fire", "vfx_mars_aa_muzzle_flash", "fx_barrel_1_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_3", "fire_bottom_barrels", "fxanim_aa_gun_fire", "vfx_mars_aa_muzzle_flash", "fx_barrel_2_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_4", "fire_top_barrels", "fxanim_aa_gun_fire", "vfx_mars_aa_muzzle_flash", "fx_barrel_1_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_4", "fire_bottom_barrels", "fxanim_aa_gun_fire", "vfx_mars_aa_muzzle_flash", "fx_barrel_2_jnt");
  level._id_EC85["animname_aa_gun_1_1"]["fxanim_aa_gun_pre_death"] = % iw7_fxanim_sp_mars_aa_turret_gun_loop_end_01_anim;
  level._id_EC85["animname_aa_gun_1_2"]["fxanim_aa_gun_pre_death"] = % iw7_fxanim_sp_mars_aa_turret_gun_loop_end_02_anim;
  level._id_EC85["animname_aa_gun_2"]["fxanim_aa_gun_pre_death"] = % iw7_fxanim_sp_mars_aa_turret_gun_loop_end_03_anim;
  level._id_EC85["animname_aa_gun_3"]["fxanim_aa_gun_pre_death"] = % iw7_fxanim_sp_mars_aa_turret_gun_loop_end_01_anim;
  level._id_EC85["animname_aa_gun_4"]["fxanim_aa_gun_pre_death"] = % iw7_fxanim_sp_mars_aa_turret_gun_loop_end_01_anim;
  scripts\sp\anim::_id_1800("animname_aa_gun_1_1", "fire_top_barrels", "fxanim_aa_gun_pre_death", "vfx_mars_aa_muzzle_flash", "fx_barrel_1_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_1_1", "fire_bottom_barrels", "fxanim_aa_gun_pre_death", "vfx_mars_aa_muzzle_flash", "fx_barrel_2_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_1_2", "fire_top_barrels", "fxanim_aa_gun_pre_death", "vfx_mars_aa_muzzle_flash", "fx_barrel_1_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_1_2", "fire_bottom_barrels", "fxanim_aa_gun_pre_death", "vfx_mars_aa_muzzle_flash", "fx_barrel_2_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_2", "fire_top_barrels", "fxanim_aa_gun_pre_death", "vfx_mars_aa_muzzle_flash", "fx_barrel_1_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_2", "fire_bottom_barrels", "fxanim_aa_gun_pre_death", "vfx_mars_aa_muzzle_flash", "fx_barrel_2_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_3", "fire_top_barrels", "fxanim_aa_gun_pre_death", "vfx_mars_aa_muzzle_flash", "fx_barrel_1_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_3", "fire_bottom_barrels", "fxanim_aa_gun_pre_death", "vfx_mars_aa_muzzle_flash", "fx_barrel_2_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_4", "fire_top_barrels", "fxanim_aa_gun_pre_death", "vfx_mars_aa_muzzle_flash", "fx_barrel_1_jnt");
  scripts\sp\anim::_id_1800("animname_aa_gun_4", "fire_bottom_barrels", "fxanim_aa_gun_pre_death", "vfx_mars_aa_muzzle_flash", "fx_barrel_2_jnt");
  level._id_EC87["animname_aa_gun_1_1_death"] = #animtree;
  level._id_EC87["animname_aa_gun_1_2_death"] = #animtree;
  level._id_EC87["animname_aa_gun_2_death"] = #animtree;
  level._id_EC87["animname_aa_gun_3_death"] = #animtree;
  level._id_EC87["animname_aa_gun_4_death"] = #animtree;
  level._id_EC85["animname_aa_gun_1_1_death"]["fxanim_aa_gun_1_1"] = % iw7_fxanim_sp_mars_aa_turret_explosion_01_anim;
  level._id_EC85["animname_aa_gun_1_2_death"]["fxanim_aa_gun_1_2"] = % iw7_fxanim_sp_mars_aa_turret_explosion_02_anim;
  level._id_EC85["animname_aa_gun_2_death"]["fxanim_aa_gun_2"] = % iw7_fxanim_sp_mars_aa_turret_explosion_03_anim;
  level._id_EC85["animname_aa_gun_3_death"]["fxanim_aa_gun_3"] = % iw7_fxanim_sp_mars_aagun_04_anim;
  level._id_EC85["animname_aa_gun_4_death"]["fxanim_aa_gun_4"] = % iw7_fxanim_sp_mars_aagun_05_anim;
  level._id_EC87["animname_aa_gun_kamikazi"] = #animtree;
  level._id_EC85["animname_aa_gun_kamikazi"]["fxanim_aa_gun_strike"] = % iw7_fxanim_sp_mars_kamikaze_strike_turret_anim;
  level._id_EC85["animname_aa_gun_kamikazi"]["fxanim_aa_gun_strike_turret_blend"] = % iw7_fxanim_sp_mars_kamikaze_strike_turret_blend_anim;
  level._id_EC85["animname_aa_gun_kamikazi"]["fxanim_aa_gun_strike_turret_idle"][0] = % iw7_fxanim_sp_mars_kamikaze_strike_turret_idle_anim;
  level._id_EC87["animname_aa_kamikazi_debris"] = #animtree;
  level._id_EC87["animname_aa_kamikazi_scraps"] = #animtree;
  level._id_EC87["animname_aa_kamikazi_playspace"] = #animtree;
  level._id_EC85["animname_aa_kamikazi_debris"]["fxanim_aa_gun_strike"] = % iw7_fxanim_sp_mars_kamikaze_strike_playspace_debris_anim;
  level._id_EC85["animname_aa_kamikazi_scraps"]["fxanim_aa_gun_strike"] = % iw7_fxanim_sp_mars_kamikaze_strike_scraps_anim;
  level._id_EC85["animname_aa_kamikazi_turret"]["fxanim_aa_gun_strike"] = % iw7_fxanim_sp_mars_kamikaze_strike_turret_anim;
  level._id_EC87["engineer_gate_open_torch"] = #animtree;
  level._id_EC8C["engineer_gate_open_torch"] = "engineer_blowtorch_pmars";
  level._id_EC85["engineer_gate_open_torch"]["engineer_gate_open"] = % mars_gate_support_1_torch;
  scripts\sp\anim::_id_1800("engineer_gate_open_torch", "start_blowtorch", "engineer_gate_open", "vfx_blowtorch_active", "tag_flame");
  scripts\sp\anim::_id_1801("engineer_gate_open_torch", "stop_blowtorch", "engineer_gate_open", "vfx_blowtorch_active", "tag_flame");
  level._id_EC87["fxanim_gate_c8_wall"] = #animtree;
  level._id_EC85["fxanim_gate_c8_wall"]["explode"] = % iw7_fxanim_sp_mars_wall_explode_01_anim;
  level._id_EC87["dropship3_crash"] = #animtree;
  level._id_EC85["dropship3_crash"]["impact"] = % iw7_fxanim_sp_mars_dropship_crash_anim;
  level._id_EC87["fxanim_wires_hanging_01"] = #animtree;
  level._id_EC85["fxanim_wires_hanging_01"]["wire_idle"][0] = % iw7_fxanim_gp_wires_hanging_01_s3_anim;
  level._id_EC87["fxanim_wires_sparking_xlong_thick"] = #animtree;
  level._id_EC85["fxanim_wires_sparking_xlong_thick"]["wire_idle"][0] = % iw7_fxanim_gp_wire_sparking_xlong_thick_anim;
  scripts\sp\anim::_id_1800("fxanim_wires_sparking_xlong_thick", "wire_spark", "wire_idle", "sparks_burst_wire_runner", "spark_fx_01_jnt");
  level._id_EC87["fxanim_wires_sparking_ground_01"] = #animtree;
  level._id_EC85["fxanim_wires_sparking_ground_01"]["wire_idle"][0] = % iw7_fxanim_gp_wire_sparking_ground_01_anim;
  scripts\sp\anim::_id_1800("fxanim_wires_sparking_ground_01", "wire_spark", "wire_idle", "sparks_burst_wire_runner", "spark_fx_01_jnt");
  level._id_EC87["fxanim_aa2_crane"] = #animtree;
  level._id_EC85["fxanim_aa2_crane"]["crane_idle"][0] = % iw7_fxanim_sp_mars_crane;
  level._id_EC87["fxanim_aa2_airlock"] = #animtree;
  level._id_EC85["fxanim_aa2_airlock"]["explode"] = % iw7_fxanim_sp_mars_airlock_door_explosion_anim;
  level._id_EC87["fxanim_aa2_debris01"] = #animtree;
  level._id_EC85["fxanim_aa2_debris01"]["explode"] = % iw7_fxanim_sp_mars_burning_tunnel_debris_01_anim;
  level._id_EC87["fxanim_aa2_debris02"] = #animtree;
  level._id_EC85["fxanim_aa2_debris02"]["explode"] = % iw7_fxanim_sp_mars_burning_tunnel_debris_02_anim;
  level._id_EC87["elevator_gate"] = #animtree;
  level._id_EC85["elevator_gate"]["elevator_gate_enter"] = % mar_10_21_base_gate_through_gate;
  level._id_EC87["elevator_torch"] = #animtree;
  level._id_EC85["elevator_torch"]["elevator_gate_enter"] = % mar_10_21_base_ally02_through_gate_torch;
  scripts\sp\anim::_id_1800("elevator_torch", "torch_on", "elevator_gate_enter", "vfx_mars_torch_cutting_elevator", "tag_flame");
  scripts\sp\anim::_id_1801("elevator_torch", "torch_off", "elevator_gate_enter", "vfx_mars_torch_cutting_elevator", "tag_flame");
  scripts\sp\anim::_id_17FC("elevator_torch", "torch_off", "torch_off");
  level._id_EC87["elevator_mag"] = #animtree;
  level._id_EC8C["elevator_mag"] = "weapon_erad_mag_pmars";
  level._id_EC85["elevator_mag"]["elevator_gate_enter"] = % mar_10_21_base_gate_clip_through_gate;
  level._id_EC87["elevator_louvers"] = #animtree;
  level._id_EC85["elevator_louvers"]["elevator_louvers_anim"] = % iw7_fxanim_sp_mars_elevator_shutters_close_anim;
  level._id_EC87["elevator_seat"] = #animtree;
  level._id_EC8C["elevator_seat"] = "veh_mil_air_un_dropship_seat";
  level._id_EC85["elevator_seat"]["elevator_player_get_in"] = % mars_elevator_enter_plr_seat01_get_in;
  level._id_EC85["elevator_seat"]["elevator_player_get_out"] = % mars_elevator_enter_plr_seat01_get_out;
  level._id_EC85["elevator_seat"]["elevator_npc01_get_in"] = % mars_elevator_enter_ally01_seat02_get_in;
  level._id_EC85["elevator_seat"]["elevator_npc01_get_out"] = % mars_elevator_enter_ally01_seat02_get_out;
  level._id_EC85["elevator_seat"]["elevator_npc01_idle"][0] = % mars_elevator_enter_ally01_seat02_idle;
  level._id_EC85["elevator_seat"]["elevator_npc02_get_in"] = % mars_elevator_enter_ally02_seat03_get_in;
  level._id_EC85["elevator_seat"]["elevator_npc02_get_out"] = % mars_elevator_enter_ally02_seat03_get_out;
  level._id_EC85["elevator_seat"]["elevator_npc02_idle"][0] = % mars_elevator_enter_ally02_seat03_idle;
  level._id_EC85["elevator_seat"]["getin_mr1"] = % mars_10_22_elev_dropseat_get_in_for_mr1;
  level._id_EC85["elevator_seat"]["getin_ally01"] = % mars_10_22_elev_dropseat_get_in_for_ally01;
  level._id_EC85["elevator_seat"]["idle_mr1"][0] = % mars_10_22_elev_dropseat_idle_for_mr1;
  level._id_EC85["elevator_seat"]["idle_xo"][0] = % mars_10_22_elev_dropseat_idle_for_xo;
  level._id_EC85["elevator_seat"]["idle_c6i"][0] = % mars_10_22_elev_dropseat_idle_for_c6i;
  level._id_EC85["elevator_seat"]["idle_eng"][0] = % mars_10_22_elev_dropseat_idle_for_eng;
  level._id_EC85["elevator_seat"]["idle_ally01"][0] = % mars_10_22_elev_dropseat_idle_for_ally01;
  level._id_EC85["elevator_seat"]["nag_xo"] = % mars_10_22_elev_dropseat_nag_for_xo;
  level._id_EC85["elevator_seat"]["rideup_mr1"] = % mars_10_22_dropseat_elev_start_scene_for_mr1;
  level._id_EC85["elevator_seat"]["rideup_xo"] = % mars_10_22_dropseat_elev_start_scene_for_xo;
  level._id_EC85["elevator_seat"]["rideup_c6i"] = % mars_10_22_dropseat_elev_start_scene_for_c6i;
  level._id_EC85["elevator_seat"]["rideup_eng"] = % mars_10_22_dropseat_elev_start_scene_for_eng;
  level._id_EC85["elevator_seat"]["rideup_ally01"] = % mars_10_22_dropseat_elev_start_scene_for_ally01;
  level._id_EC87["elevator_mount"] = #animtree;
  level._id_EC8C["elevator_mount"] = "equipment_industrial_weapon_mount_01";
  level._id_EC85["elevator_mount"]["getin_mr1"] = % mars_10_22_elev_mount_get_in_for_mr1;
  level._id_EC85["elevator_mount"]["getin_ally01"] = % mars_10_22_elev_mount_get_in_for_ally01;
  level._id_EC85["elevator_mount"]["idle_mr1"][0] = % mars_10_22_elev_mount_idle_for_mr1;
  level._id_EC85["elevator_mount"]["idle_xo"][0] = % mars_10_22_elev_mount_idle_for_xo;
  level._id_EC85["elevator_mount"]["idle_c6i"][0] = % mars_10_22_elev_mount_idle_for_c6i;
  level._id_EC85["elevator_mount"]["idle_eng"][0] = % mars_10_22_elev_mount_idle_for_eng;
  level._id_EC85["elevator_mount"]["idle_ally01"][0] = % mars_10_22_elev_mount_idle_for_ally01;
  level._id_EC85["elevator_mount"]["nag_xo"] = % mars_10_22_elev_mount_nag_for_xo;
  level._id_EC85["elevator_mount"]["rideup_mr1"] = % mars_10_22_mount_elev_start_scene_for_mr1;
  level._id_EC85["elevator_mount"]["rideup_xo"] = % mars_10_22_mount_elev_start_scene_for_xo;
  level._id_EC85["elevator_mount"]["rideup_c6i"] = % mars_10_22_mount_elev_start_scene_for_c6i;
  level._id_EC85["elevator_mount"]["rideup_eng"] = % mars_10_22_mount_elev_start_scene_for_eng;
  level._id_EC85["elevator_mount"]["rideup_ally01"] = % mars_10_22_mount_elev_start_scene_for_ally01;
  level._id_EC87["airlock_door"] = #animtree;
  level._id_EC85["airlock_door"]["open_airlock"] = % airlock_open_door;
  level._id_EC85["airlock_door"]["close_airlock"] = % europa_airlock_door_close;
  level._id_EC87["c8_droppod"] = #animtree;
  level._id_EC8C["c8_droppod"] = "veh_mil_lnd_ca_droppod_c8";
  level._id_EC85["c8_droppod"]["c8_droppod_intro"] = % moon_c8_intro_pod;
  scripts\sp\anim::_id_17FC("c8_droppod", "thrust_on", "droppod_c8_spawn");
  scripts\sp\anim::_id_17FC("c8_droppod", "explode", "droppod_c8_land");
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["dropship_exit"] = % mars_10_16_player_dropship_exit;
  level._id_EC89["player_rig"]["dropship_exit"] = 0;
  scripts\sp\anim::_id_17FC("player_rig", "player_pain", "dropship_player_pain");
  level._id_EC85["player_rig"]["elevator_gate_enter"] = % mar_10_21_base_plr_through_gate;
  level._id_EC85["player_rig"]["elevator_player_get_in"] = % mars_elevator_enter_plr_get_in;
  level._id_EC89["player_rig"]["elevator_player_get_in"] = 1.0;
  level._id_EC85["player_rig"]["elevator_player_get_out"] = % mars_elevator_enter_plr_get_out;
  scripts\sp\anim::_id_17FC("player_rig", "plr_seat_lock", "plr_seat_lock");
  level._id_EC85["player_rig"]["open_airlock"] = % airlock_open_player;
  level._id_EC89["player_rig"]["open_airlock"] = 0.5;
}

#using_animtree("c6");

_id_3353() {
  level._id_EC85["c6"]["dead_robot_01"][0] = % mars_base_greenhouse_dead_robots_01;
  level._id_EC85["c6"]["dead_robot_02"][0] = % mars_base_greenhouse_dead_robots_02;
  level._id_EC85["c6"]["dead_robot_03"][0] = % mars_base_greenhouse_dead_robots_03;
  level._id_EC87["c6_idle"] = #animtree;
  level._id_EC85["c6_idle"]["c6_idle_1"][0] = % c6_grnd_red_exposed_casual_idle_ar;
  level._id_EC85["c6_idle"]["c6_ready_1"] = % c6_grnd_red_exposed_casual_exit_ar;
}

#using_animtree("c8");

_id_341D() {
  level._id_EC85["c8"]["greenhouse_c8_jumpdown_01"] = % mars_engineer_gate_c8_jumpdown_01;
  level._id_EC85["c8"]["greenhouse_c8_jumpdown_02"] = % mars_engineer_gate_c8_jumpdown_02;
  scripts\sp\anim::_id_17FC("c8", "hit_ground", "c8_hit_ground", "greenhouse_c8_jumpdown_01");
  scripts\sp\anim::_id_17FC("c8", "hit_ground", "c8_hit_ground", "greenhouse_c8_jumpdown_02");
  level._id_EC85["c8"]["aa2_c8_jumpdown_01"] = % mars_aa2_c8_jumpdown_01;
  level._id_EC85["c8"]["aa2_c8_jumpdown_02"] = % mars_aa2_c8_jumpdown_02;
  scripts\sp\anim::_id_17FC("c8", "hit_ground", "c8_hit_ground", "aa2_c8_jumpdown_01");
  scripts\sp\anim::_id_17FC("c8", "hit_ground", "c8_hit_ground", "aa2_c8_jumpdown_02");
  level._id_EC85["c8"]["c8_droppod_intro"] = % moon_c8_intro_c8;
  level._id_EC85["c8"]["droppod_c8_fall"] = % mars_droppod_c8_fall;
  level._id_EC85["c8"]["c8_hill_intro"] = % c8_grnd_org_traversals_moon_stair_up_short;
}

#using_animtree("c12");

_id_3508() {
  level._id_EC87["c12"] = #animtree;
  level._id_EC85["c12"]["c12_dropoff"] = % titan_c12_fight_enemyc12_dropoff;
  level._id_EC85["c12"]["c12_poweron"] = % c12_grnd_org_unfold_01;
}

#using_animtree("vehicles");

vehicle() {
  level._id_EC87["dropship"] = #animtree;
  level._id_EC85["dropship"]["c12_dropoff"] = % titan_c12_fight_dropship_dropoff;
  level._id_EC89["dropship"]["c12_dropoff"] = 1.2;
  level._id_EC87["base_intro_atv"] = #animtree;
  level._id_EC85["base_intro_atv"]["fxanim_base_intro_atv"] = % iw7_fxanim_sp_mars_truck_01_anim;
  level._id_EC87["dropship_intro"] = #animtree;
  level._id_EC85["dropship_intro"]["dropship_exit"] = % mars_10_16_dropship_exit;
  level._id_EC89["dropship_intro"]["dropship_exit"] = 0;
  scripts\sp\anim::_id_1800("dropship_intro", "first_shake", "dropship_exit", "dropship_interior_shakes", "tag_origin");
  scripts\sp\anim::_id_1800("dropship_intro", "second_shake", "dropship_exit", "dropship_interior_shakes", "tag_origin");
  scripts\sp\anim::_id_1800("dropship_intro", "third_shake", "dropship_exit", "dropship_interior_shakes", "tag_origin");
  scripts\sp\anim::_id_17FC("dropship_intro", "first_shake", "dropship_first_shake", "dropship_exit");
  scripts\sp\anim::_id_17FC("dropship_intro", "second_shake", "dropship_second_shake", "dropship_exit");
  scripts\sp\anim::_id_17FC("dropship_intro", "third_shake", "dropship_third_shake", "dropship_exit");
  scripts\sp\anim::_id_17FC("dropship_intro", "big_explosion", "dropship_big_explosion", "dropship_exit");
  level._id_EC87["dropship_gate"] = #animtree;
  level._id_EC89["dropship_gate"]["gate_support_flyout"] = 1.0;
  level._id_EC85["dropship_gate"]["gate_support_flyin"] = % mars_gate_support_dropship_flyin;
  level._id_EC85["dropship_gate"]["gate_support_idle"] = % mars_gate_support_dropship_resupport;
  level._id_EC85["dropship_gate"]["gate_support_flyout"] = % mars_gate_support_dropship_flyout;
  level._id_EC87["dropship3"] = #animtree;
  level._id_EC85["dropship3"]["flyin"] = % mars_base_greenhouse_dropship_crash_flyin;
  level._id_EC85["dropship3"]["idle"][0] = % mars_base_greenhouse_dropship_crash_idle;
  level._id_EC85["dropship3"]["dropship_crash"] = % mars_base_greenhouse_dropship_crash;
  scripts\sp\anim::_id_17FC("dropship3", "open_door", "dropship3_open_door", "flyin");
  scripts\sp\anim::_id_17FC("dropship3", "loop_end", "dropship3_loop_end", "idle");
  scripts\sp\anim::_id_17FC("dropship3", "impact", "impact", "dropship_crash");
  scripts\sp\anim::_id_17FC("dropship3", "start_fx", "dropship3_start_fx", "dropship_crash");
  level._id_EC87["dropship_elevator"] = #animtree;
  level._id_EC85["dropship_elevator"]["elevator_retreat_flyin"] = % mars_base_elevator_dropship_flyin;
  level._id_EC85["dropship_elevator"]["elevator_retreat_idle"][0] = % mars_base_elevator_dropship_resupply;
  level._id_EC85["dropship_elevator"]["elevator_retreat_flyout"] = % mars_base_elevator_dropship_flyout;
  level._id_EC89["dropship_elevator"]["elevator_retreat_flyout"] = 1;
  scripts\sp\anim::_id_17FC("dropship_elevator", "open_door", "open_door");
  scripts\sp\anim::_id_17FC("dropship_elevator", "loop_end", "loop_end");
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC87["jackal_run_01"] = #animtree;
  level._id_EC87["jackal_run_02"] = #animtree;
  level._id_EC87["jackal_run_03"] = #animtree;
  level._id_EC85["jackal_run_01"]["jackal_run_initial"] = % iw7_fxanim_sp_mars_jackal_run_01_anim;
  level._id_EC85["jackal_run_02"]["jackal_run_initial"] = % iw7_fxanim_sp_mars_jackal_run_02_anim;
  level._id_EC85["jackal_run_03"]["jackal_run_initial"] = % iw7_fxanim_sp_mars_jackal_run_03_anim;
  level._id_EC85["jackal_run_01"]["jackal_run_gun"] = % iw7_fxanim_sp_mars_jackal_bomb_run_01_anim;
  scripts\sp\anim::_id_17FA("jackal_run_01", "jackal_01_hit", "flag_hill_gate_jackal_01_hit", "jackal_run_gun");
  level._id_EC85["jackal_run_02"]["jackal_run_gun"] = % iw7_fxanim_sp_mars_jackal_bomb_run_02_anim;
  level._id_EC85["jackal_run_03"]["jackal_run_gun"] = % iw7_fxanim_sp_mars_jackal_bomb_run_03_anim;
  level._id_EC85["jackal_run_02"]["jackal_run_kamakazi"] = % iw7_fxanim_sp_mars_jackal_bomb_run_04_anim;
  scripts\sp\anim::_id_17FA("jackal_run_02", "jackal_hits_turret", "flag_hill_gate_jackal_ram_gun", "jackal_run_kamakazi");
}

#using_animtree("generic_human");

_id_8558() {
  level._id_EC88["gator"]["marsbase_nav_itsgoodtobeinthefight"] = % marsbase_nav_itsgoodtobeinthefight_face;
  var_0 = [];
  var_0["gator"]["intro"] = % mars_10_19_gator_door_nav_door_intro;
  var_0["gator"]["idle"] = % mars_10_19_gator_door_nav_door_idle;
  var_0["gator"]["idle_nag"] = % mars_10_19_gator_door_nav_react_to_plr_intro;
  var_0["gator"]["pull"] = % mars_10_19_gator_door_nav_door_pull;
  level._id_EC89["gator"]["pull"] = 0.5;
  var_0["gator"]["outro"] = % mars_10_19_gator_door_nav_death;
  var_0["salter"]["outro"] = % mars_10_19_gator_door_xo_react_nav_death;
  return var_0;
}

#using_animtree("player");

_id_855A() {
  var_0 = [];
  var_0["door_player_rig"]["intro"] = % mars_10_19_gator_door_plr_door_intro;
  var_0["door_player_rig"]["idle"] = % mars_10_19_gator_door_plr_door_idle;
  var_0["door_player_rig"]["pull"] = % mars_10_19_gator_door_plr_door_pull;
  level._id_EC89["door_player_rig"]["pull"] = 0.5;
  var_0["door_player_rig"]["outro"] = % mars_10_19_gator_door_plr_react_nav_death;
  scripts\sp\anim::_id_17FC("door_player_rig", "player_at_exitdoor", "player_at_exitdoor", "intro");
  return var_0;
}

#using_animtree("script_model");

_id_8559() {
  var_0 = [];
  var_0["door"]["pull"] = % mars_10_19_gator_door_buddy_door_pull;
  var_0["door"]["outro"] = % mars_10_19_gator_door_buddy_door_nav_death;
  return var_0;
}

#using_animtree("generic_human");

_id_606F() {
  var_0 = [];
  var_0["griff"]["outro"] = % mars_elevator_open_arm_rollup_gate;
  var_0["brooks"]["outro"] = % mars_elevator_open_mr1_rollup_gate;
  return var_0;
}

#using_animtree("player");

_id_6071() {
  var_0 = [];
  var_0["door_player_rig"]["outro"] = % mars_elevator_open_plr_rollup_gate;
  return var_0;
}

_id_6070() {
  var_0 = [];
  return var_0;
}