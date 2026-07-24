/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phstreets\phstreets_anim.gsc
********************************************************/

main() {
  _id_91DC();
  _id_3353();
  player();
  _id_13267();
  _id_EF3C();
  script_model();
  _id_A056();
  anim.notetracks["start_death"] = ::_id_C11B;
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["generic"]["frantic_run_twitches"][0] = % hm_grnd_red_run_wizby05_ar;
  level._id_EC85["generic"]["frantic_run_twitches"][1] = % hm_grnd_red_run_wizby06_ar;
  level._id_EC85["generic"]["frantic_run_twitches"][2] = % hm_grnd_red_run_twitch_stumble01_ar;
  level._id_EC85["generic"]["frantic_run_twitches"][3] = % hm_grnd_red_run_twitch_stumble02_ar;
  level._id_EC85["generic"]["frantic_run_twitches"][4] = % hm_grnd_red_run_twitch_look_behind02_ar;
  level._id_EC85["generic"]["generic_dead_wall_lean_civ_01"][0] = % generic_dead_wall_lean_civ_01;
  level._id_EC85["generic"]["generic_dead_wall_lean_civ_02"][0] = % generic_dead_wall_lean_civ_02;
  level._id_EC85["generic"]["generic_dead_wall_lean_civ_03"][0] = % generic_dead_wall_lean_civ_03;
  level._id_EC85["generic"]["generic_dead_civ_01"][0] = % generic_dead_civ_01;
  level._id_EC85["generic"]["generic_dead_civ_02"][0] = % generic_dead_civ_02;
  level._id_EC85["generic"]["generic_dead_civ_03"][0] = % generic_dead_civ_03;
  level._id_EC85["generic"]["generic_dead_civ_04"][0] = % generic_dead_civ_04;
  level._id_EC85["generic"]["generic_dead_civ_05"][0] = % generic_dead_civ_05;
  level._id_EC85["generic"]["generic_dead_civ_06"][0] = % generic_dead_civ_06;
  level._id_EC85["generic"]["generic_dead_civ_07"][0] = % generic_dead_civ_07;
  level._id_EC85["generic"]["generic_dead_civ_01_fem"][0] = % generic_dead_civ_fem_01;
  level._id_EC85["generic"]["generic_dead_civ_02_fem"][0] = % generic_dead_civ_fem_02;
  level._id_EC85["generic"]["generic_dead_civ_03_fem"][0] = % generic_dead_civ_fem_03;
  level._id_EC85["generic"]["generic_dead_civ_04_fem"][0] = % generic_dead_civ_fem_04;
  level._id_EC85["generic"]["generic_dead_civ_05_fem"][0] = % generic_dead_civ_fem_05;
  level._id_EC85["generic"]["generic_dead_civ_06_fem"][0] = % generic_dead_civ_fem_06;
  level._id_EC85["generic"]["generic_dead_civ_07_fem"][0] = % generic_dead_civ_fem_07;
  level._id_EC85["generic"]["generic_dead_civ_fem_01"][0] = % generic_dead_civ_fem_01;
  level._id_EC85["generic"]["generic_dead_civ_fem_02"][0] = % generic_dead_civ_fem_02;
  level._id_EC85["generic"]["generic_dead_civ_fem_03"][0] = % generic_dead_civ_fem_03;
  level._id_EC85["generic"]["generic_dead_civ_fem_04"][0] = % generic_dead_civ_fem_04;
  level._id_EC85["generic"]["generic_dead_civ_fem_05"][0] = % generic_dead_civ_fem_05;
  level._id_EC85["generic"]["generic_dead_civ_fem_06"][0] = % generic_dead_civ_fem_06;
  level._id_EC85["generic"]["generic_dead_civ_fem_07"][0] = % generic_dead_civ_fem_07;
  level._id_EC85["generic"]["ph_dust_civi_run_01"] = % ph_dust_civi_run_01;
  level._id_EC85["generic"]["ph_dust_civi_run_02"] = % ph_dust_civi_run_02;
  level._id_EC85["generic"]["ph_dust_civi_run_03"] = % ph_dust_civi_run_03;
  level._id_EC85["generic"]["ph_dust_civi_run_04"] = % ph_dust_civi_run_04;
  level._id_EC85["generic"]["ph_dust_civi_run_05"] = % ph_dust_civi_run_05;
  level._id_EC85["generic"]["ph_dust_civi_run_06"] = % ph_dust_civi_run_06;
  level._id_EC85["generic"]["ph_dust_civi_run_07"] = % ph_dust_civi_run_07;
  level._id_EC85["generic"]["ph_dust_civi_run_08"] = % ph_dust_civi_run_08;
  level._id_EC85["generic"]["ph_dust_civi_run_09"] = % ph_dust_civi_run_09;
  level._id_EC85["generic"]["ph_dust_civi_run_10"] = % ph_dust_civi_run_10;
  level._id_EC85["generic"]["ph_dust_civi_run_11"] = % ph_dust_civi_run_11;
  level._id_EC85["generic"]["ph_dust_civi_run_12"] = % ph_dust_civi_run_12;
  level._id_EC85["generic"]["ph_dust_civi_run_13"] = % ph_dust_civi_run_13;
  level._id_EC85["generic"]["ph_dust_civi_run_14"] = % ph_dust_civi_run_14;
  level._id_EC85["lover_male"]["ph_lovers"] = % ph_mall_kiosk_injured_civi;
  scripts\sp\anim::_id_17F6("lover_male", "shotted", ::_id_B0C7, "ph_lovers");
  level._id_EC85["lover_female"]["ph_lovers"] = % ph_mall_kiosk_injured_civi_fem;
  scripts\sp\anim::_id_17F6("lover_female", "shotted", ::_id_B0C7, "ph_lovers");
  level._id_EC85["generic"]["dead_car_civi_driverwindow"] = % ph_dead_civi_car_driver_01;
  level._id_EC85["generic"]["dead_car_civi_driverdoor"] = % ph_dead_civi_car_driver_02;
  level._id_EC85["generic"]["dead_car_civi_trunk"] = % ph_dead_civi_car_trunk;
  level._id_EC85["generic"]["dead_car_civi_passengerwindow"] = % ph_dead_civi_car_passenger_01;
  level._id_EC85["generic"]["dead_car_civi_passengerdoor"] = % ph_dead_civi_car_passenger_02;
  level._id_EC85["generic"]["dead_car_civi_passengerback"] = % ph_dead_civi_car_passenger_03;
  level._id_EC85["generic"]["hm_grnd_org_lmg_reload_stand"] = % hm_grnd_org_lmg_reload_stand;
  level._id_EC85["generic"]["hm_grnd_org_lmg_reload_crouch"] = % hm_grnd_org_lmg_reload_crouch;
  level._id_EC85["slaughter_civ"]["ph_civi_run_death_01"] = % ph_civi_run_death_01;
  level._id_EC85["slaughter_civ"]["ph_civi_run_death_02"] = % ph_civi_run_death_02;
  level._id_EC85["slaughter_civ"]["ph_civi_run_death_03"] = % ph_civi_run_death_03;
  level._id_EC85["slaughter_civ"]["ph_civi_run_death_04"] = % ph_civi_run_death_04;
  level._id_EC85["slaughter_civ"]["ph_civi_run_death_05"] = % ph_civi_run_death_05;
  level._id_EC85["slaughter_civ"]["ph_civi_run_death_06"] = % ph_civi_run_death_06;
  scripts\sp\anim::_id_17F6("slaughter_civ", "shotted", ::_id_102D0);
  level._id_EC85["generic"]["patrol_jog_orders_once"] = % patrol_jog_orders_once;
  level._id_EC85["generic"]["hm_grnd_red_civ_run_twitch04"] = % hm_grnd_red_civ_run_twitch04;
  level._id_EC85["civilian_0"]["dropship_wakeup_civilians"] = % ph_crash_dropship_wakeup_civ01;
  level._id_EC85["civilian_1"]["dropship_wakeup_civilians"] = % ph_crash_dropship_wakeup_civ02;
  level._id_EC85["civilian_2"]["dropship_wakeup_civilians"] = % ph_crash_dropship_wakeup_civ03;
  level._id_EC85["civilian_3"]["dropship_wakeup_civilians"] = % ph_crash_dropship_wakeup_civ04;
  level._id_EC85["civilian_4"]["dropship_wakeup_civilians"] = % ph_crash_dropship_wakeup_civ05;
  level._id_EC85["eth3n"]["dropship_wakeup"] = % ph_crash_dropship_wakeup_eth3n;
  level._id_EC85["salter"]["dropship_wakeup"] = % ph_crash_dropship_wakeup_slt;
  scripts\sp\anim::_id_17F6("salter", "phstreets_adm_lieutenantreyes", ::_id_CE8F, "dropship_wakeup");
  scripts\sp\anim::_id_17FC("salter", "phstreets_eth_sir1", "phstreets_eth_sir1", "dropship_wakeup");
  scripts\sp\anim::_id_17FC("salter", "phstreets_eth_wegottangosmovi", "phstreets_eth_wegottangosmovi", "dropship_wakeup");
  scripts\sp\anim::_id_17FC("salter", "phstreets_adm_theyreshootingc", "phstreets_adm_theyreshootingc", "dropship_wakeup");
  scripts\sp\anim::_id_17F6("salter", "mayhem1_thefirst", ::_id_1385A, "dropship_wakeup");
  scripts\sp\anim::_id_17F6("salter", "mayhem2_electricboogaloo", ::_id_1385B, "dropship_wakeup");
  scripts\sp\anim::_id_17FC("salter", "mayhem_end", "mayhem_end", "dropship_wakeup");
  level._id_EC85["salter"]["dropship_wakeup_struggle"][0] = % ph_crash_dropship_wakeup_fire_loop_slt;
  level._id_EC85["salter"]["dropship_wakeup_takedown"] = % ph_crash_dropship_wakeup_takedown_slt;
  level._id_EC89["salter"]["dropship_wakeup_takedown"] = 0.2;
  level._id_EC85["salter"]["dropship_wakeup_tmout_takedown"] = % ph_crash_dropship_wakeup_takedown_tmout_slt;
  level._id_EC89["salter"]["dropship_wakeup_tmout_takedown"] = 0.2;
  scripts\sp\anim::_id_17F6("salter", "start_fire", ::_id_C0DD, "dropship_wakeup_takedown");
  scripts\sp\anim::_id_17FC("salter", "stop_fire", "notetrack_fire_stop", "dropship_wakeup_takedown");
  scripts\sp\anim::_id_17FC("salter", "player_jumpout", "cockpit_player_jumpout", "dropship_wakeup_takedown");
  level._id_EC85["salter"]["dropship_wakeup_jumpout"] = % ph_crash_dropship_jumpout_slt;
  level._id_EC85["jumper_0"]["dropship_wakeup"] = % ph_crash_dropship_wakeup_enemy01;
  level._id_EC85["jumper_0"]["dropship_wakeup_struggle"][0] = % ph_crash_dropship_wakeup_enemy01_idle;
  scripts\sp\anim::_id_17FC("jumper_0", "fire", "timeToFail", "dropship_wakeup_struggle");
  level._id_EC85["jumper_0"]["dropship_wakeup_takedown"] = % ph_crash_dropship_wakeup_takedown_enemy01;
  level._id_EC85["jumper_1"]["dropship_wakeup"] = % ph_crash_dropship_wakeup_enemy02;
  scripts\sp\anim::_id_17FC("jumper_1", "allow_death", "player_jumper_allow_death", "dropship_wakeup");
  level._id_EC85["jumper_1"]["dropship_wakeup_struggle"][0] = % ph_crash_dropship_wakeup_enemy02_idle;
  level._id_EC85["jumper_1"]["dropship_wakeup_takedown"] = % ph_crash_dropship_wakeup_takedown_enemy02;
  level._id_EC89["jumper_1"]["dropship_wakeup_takedown"] = 0.2;
  scripts\sp\anim::_id_17F6("jumper_1", "start_death", ::_id_C0C7, "dropship_wakeup_takedown");
  level._id_EC85["jumper_1"]["dropship_wakeup_tmout_takedown"] = % ph_crash_dropship_wakeup_takedown_tmout_enemy02;
  level._id_EC89["jumper_1"]["dropship_wakeup_tmout_takedown"] = 0.2;
  scripts\sp\anim::_id_17F6("jumper_1", "start_death", ::_id_C0C7, "dropship_wakeup_tmout_takedown");
  level._id_EC85["eth3n"]["dropship_jumpout"] = % ph_crash_dropship_jumpout_eth3n;
  level._id_EC85["salter"]["dropship_jumpout"] = % ph_crash_dropship_jumpout_slt;
  level._id_EC89["salter"]["dropship_jumpout"] = 0;
  level._id_EC85["admiral"]["bar_stairs_run"] = % ph_grenade_stairs_adm;
  level._id_EC85["salter"]["bar_stairs_run"] = % ph_grenade_stairs_xo;
  level._id_EC85["eth3n"]["bar_stairs_run"] = % ph_grenade_stairs_c6i;
  level._id_EC85["salter"]["grenade_give"] = % ph_coast_give_plr_grenades_xo;
  scripts\sp\anim::_id_17FC("salter", "give_grenade_vo", "give_grenade_vo", "grenade_give");
  scripts\sp\anim::_id_17FC("salter", "give_grenades", "give_grenades", "grenade_give");
  scripts\sp\anim::_id_17F6("salter", "mayhem_grenades", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_8593, "grenade_give");
  level._id_EC85["salter"]["grenade_throw"] = % hm_grnd_org_cover_crouch_grenade02_ar;
  level._id_EC85["sdf1"]["grenade_dropship_unload"] = % ph_grenade_sdf_unload_sdf1;
  scripts\sp\anim::_id_17FC("sdf1", "allow_interrupt", "sdf1_allow_interrupt", "grenade_dropship_unload");
  level._id_EC85["sdf2"]["grenade_dropship_unload"] = % ph_grenade_sdf_unload_sdf2;
  scripts\sp\anim::_id_17FC("sdf2", "allow_interrupt", "sdf2_allow_interrupt", "grenade_dropship_unload");
  level._id_EC85["sdf3"]["grenade_dropship_unload"] = % ph_grenade_sdf_unload_sdf3;
  scripts\sp\anim::_id_17FC("sdf3", "allow_interrupt", "sdf3_allow_interrupt", "grenade_dropship_unload");
  level._id_EC85["sdf4"]["grenade_dropship_unload"] = % ph_grenade_sdf_unload_sdf4;
  scripts\sp\anim::_id_17FC("sdf4", "allow_interrupt", "sdf4_allow_interrupt", "grenade_dropship_unload");
  level._id_EC85["sdf5"]["grenade_dropship_unload"] = % ph_grenade_sdf_unload_sdf5;
  scripts\sp\anim::_id_17FC("sdf5", "allow_interrupt", "sdf5_allow_interrupt", "grenade_dropship_unload");
  scripts\sp\anim::_id_17FA("sdf5", "dropship_leave", "grenade_dropship_leave", "grenade_dropship_unload");
  scripts\sp\anim::_id_17FA("sdf5", "enemies1_moveup", "grenade_tut_enemies1_moveup", "grenade_dropship_unload");
  scripts\sp\anim::_id_17FA("sdf5", "enemies2_moveup", "grenade_tut_enemies2_moveup", "grenade_dropship_unload");
  level._id_EC85["generic"]["hm_grnd_red_civilianB_idle_02"][0] = % hm_grnd_red_civilianb_idle_02;
  level._id_EC85["generic"]["ph_hill400_dropship_dead_body_02"][0] = % ph_hill400_dropship_dead_body_02;
  level._id_EC85["generic"]["generic_dead_wall_lean_civ_01"][0] = % generic_dead_wall_lean_civ_01;
  level._id_EC85["generic"]["generic_dead_wall_lean_civ_02"][0] = % generic_dead_wall_lean_civ_02;
  level._id_EC85["generic"]["generic_dead_wall_lean_civ_03"][0] = % generic_dead_wall_lean_civ_03;
  level._id_EC85["generic"]["generic_dead_civ_01"][0] = % generic_dead_civ_01;
  level._id_EC85["generic"]["generic_dead_civ_02"][0] = % generic_dead_civ_02;
  level._id_EC85["generic"]["generic_dead_civ_03"][0] = % generic_dead_civ_03;
  level._id_EC85["generic"]["generic_dead_civ_04"][0] = % generic_dead_civ_04;
  level._id_EC85["generic"]["generic_dead_civ_05"][0] = % generic_dead_civ_05;
  level._id_EC85["generic"]["generic_dead_civ_06"][0] = % generic_dead_civ_06;
  level._id_EC85["generic"]["generic_dead_civ_07"][0] = % generic_dead_civ_07;
  level._id_EC85["crash_civ"]["blCiv0"] = % ph_mall_injured_civi_01;
  level._id_EC85["crash_civ"]["blCiv1"] = % ph_mall_injured_civi_02;
  level._id_EC85["crash_civ"]["blCiv1_idle"][0] = % ph_mall_injured_civi_02_idle;
  level._id_EC85["crash_civ_0"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ01;
  level._id_EC85["crash_civ_1"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ02;
  level._id_EC85["crash_civ_2"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ03;
  level._id_EC85["crash_civ_3"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ04;
  level._id_EC85["crash_civ_4"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ05;
  level._id_EC85["crash_civ_5"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ06;
  level._id_EC85["crash_civ_6"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ07;
  level._id_EC85["crash_civ_7"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ08;
  level._id_EC85["crash_civ_8"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ09;
  level._id_EC85["crash_civ_9"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ10;
  level._id_EC85["crash_civ_10"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ11;
  level._id_EC85["crash_civ_11"]["wake_up_civs"] = % ph_crash_dropship_wakeup_civ12;
  level._id_EC85["crash_sdf_0"]["wake_up_civs"] = % ph_crash_dropship_wakeup_enemy03;
  level._id_EC85["crash_sdf_1"]["wake_up_civs"] = % ph_crash_dropship_wakeup_enemy04;
  scripts\sp\anim::_id_17F6("crash_civ_0", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_1", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_2", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_3", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_4", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_5", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_6", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_7", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_8", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_9", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_10", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  scripts\sp\anim::_id_17F6("crash_civ_11", "civ_shot", scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_3FBA);
  level._id_EC85["generic"]["ph_streets_civi_jump_over_car_left_01"] = % ph_streets_civi_jump_over_car_left_01;
  level._id_EC85["generic"]["ph_streets_civi_jump_over_car_left_02"] = % ph_streets_civi_jump_over_car_left_02;
  level._id_EC85["generic"]["ph_streets_civi_jump_over_car_right_01"] = % ph_streets_civi_jump_over_car_right_01;
  level._id_EC85["generic"]["ph_streets_civi_jump_over_car_right_02"] = % ph_streets_civi_jump_over_car_right_02;
  level._id_EC85["generic"]["ph_streets_civi_jump_over_car_right_03"] = % ph_streets_civi_jump_over_car_right_03;
  level._id_EC85["generic"]["ph_streets_civi_jump_over_car_right_04"] = % ph_streets_civi_jump_over_car_right_04;
  level._id_EC85["generic"]["ph_streets_civi_jump_over_car_front_01"] = % ph_streets_civi_jump_over_car_front_01;
  level._id_EC85["generic"]["ph_streets_civi_jump_over_car_front_02"] = % ph_streets_civi_jump_over_car_front_02;
  level._id_EC85["generic"]["ph_streets_civi_bump_stumble_left_01"] = % ph_streets_civi_bump_stumble_left_01;
  level._id_EC85["generic"]["ph_streets_civi_bump_stumble_right_01"] = % ph_streets_civi_bump_stumble_right_01;
  level._id_EC85["generic"]["ph_streets_civi_bump_stumble_right_02"] = % ph_streets_civi_bump_stumble_right_02;
  level._id_EC85["generic"]["ph_streets_civi_bump_stumble_right_03"] = % ph_streets_civi_bump_stumble_right_03;
  level._id_EC85["generic"]["hack_forced_civ"] = % ph_cafe_robot_hack_civilian;
  level._id_EC85["generic"]["ph_dead_civi_car_passenger_02"][0] = % ph_dead_civi_car_passenger_02;
  level._id_EC85["generic"]["ph_dead_civi_car_driver_02"][0] = % ph_dead_civi_car_driver_02;
  level._id_EC85["enemy"]["civ_execution"] = % ph_streets_civis_execution_grpa_sdf;
  level._id_EC85["civ_0"]["civ_execution"] = % ph_streets_civis_execution_grpa_civ01;
  level._id_EC85["civ_1"]["civ_execution"] = % ph_streets_civis_execution_grpa_civ02;
  level._id_EC85["civ_2"]["civ_execution"] = % ph_streets_civis_execution_grpa_civ03;
  level._id_EC85["generic"]["hm_grnd_org_jump_to_mantle_over"] = % hm_grnd_org_jump_to_mantle_over;
  level._id_EC85["generic"]["ph_ccd_sdf01_stair_jump"] = % ph_ccd_sdf01_stair_jump;
  level._id_EC85["generic"]["ph_ccd_sdf02_stair_jump"] = % ph_ccd_sdf02_stair_jump;
  level._id_EC85["eth3n"]["ethan_boost_jump"] = % ph_ccd_jump_over_wall_c6i_intro;
  level._id_EC85["eth3n"]["ethan_boost_idle"][0] = % ph_ccd_jump_over_wall_c6i_idle;
  level._id_EC85["eth3n"]["ethan_boost_pull"] = % ph_ccd_jump_over_wall_c6i;
  level._id_EC85["admiral"]["ethan_boost_pull"] = % ph_ccd_jump_over_wall_adm;
  level._id_EC85["salter"]["ethan_boost_pull"] = % ph_ccd_jump_over_wall_xo;
  level._id_EC85["civ_0"]["dust_lookers"] = % ph_streets_civil_looky_loos_civ01;
  level._id_EC85["civ_1"]["dust_lookers"] = % ph_streets_civil_looky_loos_civ02;
  level._id_EC85["civ_2"]["dust_lookers"] = % ph_streets_civil_looky_loos_civ03;
  level._id_EC85["civ_3"]["dust_lookers"] = % ph_streets_civil_looky_loos_civ04;
  level._id_EC85["salter"]["salter_dust_react"] = % ph_dust_moment_slt_dust_react;
  level._id_EC85["admiral"]["admiral_dust_react"] = % ph_dust_moment_adm_dust_react;
  level._id_EC85["salter"]["dust_cough"] = % ph_ccd_cqb_cough;
  level._id_EC85["salter"]["dust_stairs"] = % ph_911stairs_guy_middle;
  level._id_EC85["admiral"]["dust_stairs"] = % ph_911stairs_guy_left;
  level._id_EC85["eth3n"]["dust_stairs"] = % ph_911stairs_guy_right;
  level._id_EC85["eth3n"]["ethan_dust_idle_1"][0] = % ph_dust_walkby_c6i_idle_01;
  level._id_EC85["eth3n"]["ethan_dust_idle_2"][0] = % ph_dust_walkby_c6i_idle_02;
  level._id_EC85["eth3n"]["ethan_dust_walk_1"] = % ph_dust_walkby_c6i_walk_01;
  level._id_EC85["eth3n"]["ethan_dust_walk_2"] = % ph_dust_walkby_c6i_walk_02;
  level._id_EC85["civ"]["ethan_civ_pre_dust_idle_1"][0] = % ph_dust_walkby_civ_idle_03;
  level._id_EC85["civ"]["ethan_civ_pre_dust_idle_2"][0] = % ph_dust_walkby_civ_idle_04;
  level._id_EC85["civ"]["ethan_civ_dust_idle"][0] = % ph_dust_walkby_civ_idle_01;
  level._id_EC85["civ"]["ethan_dust_walk_1"] = % ph_dust_walkby_civ_walk_01;
  level._id_EC85["civ"]["ethan_dust_walk_2"] = % ph_dust_walkby_civ_walk_02;
  level._id_EC85["civ"]["stun_walk_1"] = % ph_dust_civi_stun_walk_01;
  level._id_EC85["civ"]["stun_walk_1_loop"][0] = % ph_dust_civi_stun_walk_01_loop;
  level._id_EC85["civ"]["stun_walk_2"] = % ph_dust_civi_stun_walk_02;
  level._id_EC85["civ"]["stun_walk_2_loop"][0] = % ph_dust_civi_stun_walk_02_loop;
  level._id_EC85["civ"]["stun_walk_3_loop"][0] = % ph_dust_civi_stun_walk_03_loop;
  level._id_EC85["civ"]["stun_walk_3"] = % ph_dust_civi_stun_walk_03;
  level._id_EC85["civ"]["stun_walk_4"] = % ph_dust_civi_stun_walk_04;
  level._id_EC85["civ"]["stun_walk_5"] = % ph_dust_civi_stun_walk_05;
  level._id_EC85["civ"]["stun_walk_6"] = % ph_dust_civi_stun_walk_06;
  level._id_EC85["civ"]["stun_car_stand"][0] = % ph_dust_civi_stun_car_lean_stand;
  level._id_EC85["civ"]["stun_car_kneel"][0] = % ph_dust_civi_stun_car_lean_kneel;
  level._id_EC85["civ1"]["dust_help_walk"] = % ph_dust_civi_help_walk_civia;
  level._id_EC85["civ2"]["dust_help_walk"] = % ph_dust_civi_help_walk_civib;
  level._id_EC85["civ1"]["dust_help_walk_loop"][0] = % ph_dust_civi_help_walk_civia_loop;
  level._id_EC85["civ2"]["dust_help_walk_loop"][0] = % ph_dust_civi_help_walk_civib_loop;
  level._id_EC85["generic"]["ph_ccd_wall_wounded_01"][0] = % ph_ccd_wall_wounded_01;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded02"][0] = % shipcrib_moon_wall_wounded02;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded03"][0] = % shipcrib_moon_wall_wounded03;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded04"][0] = % shipcrib_moon_wall_wounded04;
  level._id_EC85["generic"]["shipcrib_moon_coughing"][0] = % shipcrib_moon_coughing_civi;
  level._id_EC85["generic"]["ph_c6_intro_civi01_ambient"] = % ph_c6_intro_civi01_ambient;
  level._id_EC85["generic"]["ph_c6_intro_civi02_ambient"] = % ph_c6_intro_civi02_ambient;
  level._id_EC85["stumbler"]["c6_alley_stumble"] = % ph_hill400_allied_injured_ambient_intro_02;
  level._id_EC85["stumbler"]["c6_alley_stumble_idle"][0] = % ph_hill400_allied_injured_ambient_loop_02;
  level._id_EC85["salter"]["c6_reveal"] = % ph_c6_intro_slt_openpod_open;
  scripts\sp\anim::_id_17F6("salter", "start_fire", ::_id_C0DD, "c6_reveal");
  scripts\sp\anim::_id_17FC("salter", "stop_fire", "notetrack_fire_stop", "c6_reveal");
  scripts\sp\anim::_id_17F9("salter", "ntt_effort", "c6_reveal", "phstreets_slt_effort1");
  scripts\sp\anim::_id_17F9("salter", "ntt_gotoh", "c6_reveal", "phstreets_slt_gotohell");
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ01"][0] = % ph_cafe_civis_ambient_civ01;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ02"][0] = % ph_cafe_civis_ambient_civ02;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ03"][0] = % ph_cafe_civis_ambient_civ03;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ04"][0] = % ph_cafe_civis_ambient_civ04;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ05"][0] = % ph_cafe_civis_ambient_civ05;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ06"][0] = % ph_cafe_civis_ambient_civ06;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ07"][0] = % ph_cafe_civis_ambient_civ07;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ05_intro"] = % ph_cafe_civis_ambient_civ05_intro;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ06_intro"] = % ph_cafe_civis_ambient_civ06_intro;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ08_idle_01"][0] = % ph_cafe_civis_ambient_civ08_idle_01;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ08_idle_02"][0] = % ph_cafe_civis_ambient_civ08_idle_02;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ09_idle01"][0] = % ph_cafe_civis_ambient_civ09_idle01;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ09_idle02"][0] = % ph_cafe_civis_ambient_civ09_idle02;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ10"][0] = % ph_cafe_civis_ambient_civ10;
  level._id_EC85["cafe_civ"]["ph_cafe_civis_ambient_civ11"][0] = % ph_cafe_civis_ambient_civ11;
  level._id_EC85["eth3n"]["cafe_table_intro"] = % ph_cafe_table_wall_eth3n_intro;
  level._id_EC89["eth3n"]["cafe_table_intro"] = 0.7;
  level._id_EC85["eth3n"]["cafe_table_intro_idle"][0] = % ph_cafe_table_wall_eth3n_intro_idle;
  level._id_EC85["eth3n"]["cafe_table"] = % ph_cafe_table_wall_eth3n;
  level._id_EC85["eth3n"]["cafe_table_idle"][0] = % ph_cafe_table_wall_eth3n_idle;
  level._id_EC85["eth3n"]["cafe_table_outro"] = % ph_cafe_table_wall_eth3n_outro;
  level._id_EC85["eth3n"]["right_anim"] = % ph_cafe_table_wall_eth3n_intro_idle;
  level._id_EC85["eth3n"]["forward_anim"] = % ph_cafe_table_wall_eth3n_intro_idle_left;
  level._id_EC85["eth3n"]["rightback_anim"] = % ph_cafe_table_wall_eth3n_intro_idle_right;
  level._id_EC85["eth3n"]["right_anim_out"] = % ph_cafe_table_wall_eth3n;
  level._id_EC85["eth3n"]["forward_anim_out"] = % ph_cafe_table_wall_eth3n_left;
  level._id_EC85["eth3n"]["rightback_anim_out"] = % ph_cafe_table_wall_eth3n_right;
  level._id_EC85["peek_civ_1"]["peek_execution"] = % ph_cafe_execution_civ01;
  level._id_EC85["peek_civ_2"]["peek_execution"] = % ph_cafe_execution_civ02;
  level._id_EC85["peek_civ_3"]["peek_execution"] = % ph_cafe_execution_civ03;
  level._id_EC85["peek_civ_2"]["peek_execution_save"] = % ph_cafe_execution_civ02_saved;
  level._id_EC85["peek_civ_3"]["peek_execution_save"][0] = % ph_cafe_execution_civ03_saved;
  level._id_EC85["peek_civ_2"]["peek_execution_death"] = % ph_cafe_execution_civ02_death;
  level._id_EC85["peek_civ_2"]["peek_execution_save_loop"][0] = % hm_grnd_red_civ_hide_idle04_female;
  level._id_EC85["peek_civ_3"]["peek_execution_death"] = % ph_cafe_execution_civ03_death;
  level._id_EC85["peek_sdf_1"]["peek_execution"] = % ph_cafe_execution_sdf01;
  level._id_EC85["peek_sdf_2"]["peek_execution"] = % ph_cafe_execution_sdf02;
  level._id_EC85["peek_sdf_1"]["peek_execution_react"] = % ph_cafe_execution_sdf01_react;
  level._id_EC85["peek_sdf_2"]["peek_execution_react"] = % ph_cafe_execution_sdf02_react;
  level._id_EC85["corpse"]["civ_death_1"] = % cornercrr_alert_death_back;
  level._id_EC85["corpse"]["civ_death_2"] = % covercrouch_death_1;
  level._id_EC85["corpse"]["civ_death_3"] = % corner_standl_deathb;
  level._id_EC85["civilian"]["generic_dead_wall_lean_civ_01"][0] = % generic_dead_wall_lean_civ_01;
  level._id_EC85["civilian"]["generic_dead_civ_03"][0] = % generic_dead_civ_03;
  level._id_EC85["civilian"]["generic_dead_wall_lean_civ_02"][0] = % generic_dead_wall_lean_civ_02;
  level._id_EC85["civilian"]["ph_cafe_civis_ambient_civ09_idle02"][0] = % ph_cafe_civis_ambient_civ09_idle02;
  level._id_EC85["civilian"]["ph_cafe_civis_ambient_civ08_idle_02"][0] = % ph_cafe_civis_ambient_civ08_idle_02;
  level._id_EC85["civilian"]["ph_cafe_civis_ambient_civ06"][0] = % ph_cafe_civis_ambient_civ06;
  level._id_EC85["generic"]["civ_flood_01"] = % ph_dust_moment_civi_flood_01;
  level._id_EC85["generic"]["civ_flood_02"] = % ph_dust_moment_civi_flood_02;
  level._id_EC85["generic"]["civ_flood_03"] = % ph_dust_moment_civi_flood_03;
  level._id_EC85["generic"]["civ_flood_04"] = % ph_dust_moment_civi_flood_04;
  level._id_EC85["generic"]["civ_flood_05"] = % ph_dust_moment_civi_flood_05;
  level._id_EC85["generic"]["civ_flood_06"] = % ph_dust_moment_civi_flood_06;
  level._id_EC85["generic"]["civ_flood_07"] = % ph_dust_moment_civi_flood_07;
  level._id_EC85["generic"]["civ_flood_08"] = % ph_dust_moment_civi_flood_08;
  level._id_EC85["generic"]["civ_flood_09"] = % ph_dust_moment_civi_flood_09;
  level._id_EC85["generic"]["civ_flood_10"] = % ph_dust_moment_civi_flood_10;
  level._id_EC85["sdf"]["window_kill"] = % ph_civi_sq_kicked_over_railing_sdf;
  level._id_EC85["civ"]["window_kill"] = % ph_civi_sq_kicked_over_railing_civi;
  level._id_EC85["eth3n"]["rocket_wall_climb"] = % ph_cqbcombat_eth3n_wall_climb_eth3n;
  level._id_EC85["eth3n"]["take_cover"] = % ph_streets_c6i_take_cover;
  level._id_EC85["generic"]["take_cover"] = % ph_streets_c6i_take_cover_civ;
  level._id_EC85["generic"]["table_flip"] = % ph_cafe_flip_table_sdf;
  level._id_EC85["generic"]["hc_wounded_a"][0] = % hc_wounded_a;
  level._id_EC85["generic"]["hc_wounded_b"][0] = % hc_wounded_b;
  level._id_EC85["generic"]["hc_wounded_c"][0] = % hc_wounded_c;
  level._id_EC85["generic"]["hc_wounded_d"][0] = % hc_wounded_d;
  level._id_EC85["stumbler02"]["hill_basement_stumble"] = % ph_hill400_triage_ambient_injured_guya;
  level._id_EC85["stumbler02"]["hill_basement_stumble_idle"][0] = % ph_hill400_triage_ambient_injured_guya_idle;
  level._id_EC85["stumbler01"]["hill_basement_stumble"] = % ph_hill400_allied_injured_ambient_intro_01;
  level._id_EC85["stumbler01"]["hill_basement_stumble_idle"][0] = % ph_hill400_allied_injured_ambient_loop_01;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_01"][0] = % shipcribmoon_elevator_injured_loop_01;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_02"][0] = % shipcribmoon_elevator_injured_loop_02;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_03"][0] = % shipcribmoon_elevator_injured_loop_03;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_04"][0] = % shipcribmoon_elevator_injured_loop_04;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_05"][0] = % shipcribmoon_elevator_injured_loop_05;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_A"][0] = % shipcrib_moon_injured_table_01_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_B"][0] = % shipcrib_moon_injured_table_01_b;
  level._id_EC85["injured"]["basement_carry_intro"] = % shipcrib_moon_injured_grnd_01_enter_a;
  level._id_EC85["helper"]["basement_carry_intro"] = % shipcrib_moon_injured_grnd_01_enter_b;
  level._id_EC85["injured"]["basement_carry_idle"][0] = % shipcrib_moon_injured_grnd_01_idle_injured_a;
  level._id_EC85["helper"]["basement_carry_idle"][0] = % shipcrib_moon_injured_grnd_01_idle_injured_b;
  level._id_EC85["salter"]["basement_debris_nag"] = % ph_hill400_building_debris_lift_slt_nag;
  level._id_EC85["salter"]["basement_debris_lift"] = % ph_hill400_building_debris_lift_slt_lift;
  level._id_EC85["eth3n"]["basement_debris_enter"] = % ph_hill400_building_debris_lift_ethn_intro;
  level._id_EC85["ally01"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_ally01_exit;
  level._id_EC85["ally01"]["basement_debris_lift_exit_idle"][0] = % ph_hill400_building_debris_lift_ally01_exit_loop;
  level._id_EC85["ally02"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_ally02_exit;
  level._id_EC85["ally02"]["basement_debris_lift_exit_idle"][0] = % ph_hill400_building_debris_lift_ally02_exit_loop;
  level._id_EC85["ally03"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_ally03_exit;
  level._id_EC85["ally03"]["basement_debris_lift_exit_idle"][0] = % ph_hill400_building_debris_lift_ally03_exit_loop;
  level._id_EC85["ally04"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_ally04_exit;
  level._id_EC85["ally05"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_ally05_exit;
  level._id_EC85["ally05"]["basement_debris_lift_exit_idle"][0] = % ph_hill400_building_debris_lift_ally05_exit_loop;
  level._id_EC85["ally05"]["basement_ally_player_salute"] = % ph_hill400_building_debris_lift_ally05_exit_salute;
  level._id_EC85["helper"]["basement_fireman_carry"] = % ph_hill400_triage_ambient_fireman_carry_guya;
  level._id_EC85["helper"]["basement_fireman_carry_idle"][0] = % ph_hill400_triage_ambient_fireman_carry_guya_idle;
  level._id_EC85["wounded"]["basement_fireman_carry"] = % ph_hill400_triage_ambient_fireman_carry_guyb;
  level._id_EC85["wounded"]["basement_fireman_carry_idle"][0] = % ph_hill400_triage_ambient_fireman_carry_guyb_idle;
  level._id_EC85["soldier"]["hill_trench_robot_punch"] = % ph_hill400_frontline_robot_punch_ally;
  level._id_EC85["soldier"]["hill_trench_robot_stomp"] = % ph_hill400_frontline_robot_stomp_ally;
  level._id_EC85["soldier"]["hill_combat_robot_necksnap"] = % ph_hill400_frontline_robot_necksnap_ally;
  level._id_EC85["generic"]["moon_wounded_loop_01"][0] = % moon_wounded_loop_01;
  level._id_EC85["generic"]["moon_wounded_loop_02"][0] = % moon_wounded_loop_02;
  level._id_EC85["hitguy"]["hitguy_hit"] = % moon_outerfob_help_1_a_hit;
  level._id_EC85["hitguy"]["hitguy_idle"][0] = % moon_outerfob_help_1_a_hit_idle;
  level._id_EC85["hitguy"]["hitguy_rescue"] = % moon_outerfob_help_1_a_rescue;
  level._id_EC85["hitguy"]["hitguy_rescue_idle"][0] = % moon_outerfob_help_1_a_rescue_idle;
  level._id_EC85["rescuer"]["hitguy_rescue"] = % moon_outerfob_help_1_b_rescue;
  level._id_EC85["rescuer"]["hitguy_rescue_idle"][0] = % moon_outerfob_help_1_b_rescue_idle;
  level._id_EC85["generic"]["multihit_death_01"] = % ph_hill400_multihit_death_soldier01;
  level._id_EC85["generic"]["multihit_death_02"] = % ph_hill400_multihit_death_soldier02;
  scripts\sp\anim::_id_17F6("generic", "start_ragdoll", ::_id_C0C7, "multihit_death_02");
  level._id_EC85["admiral"]["hill_trench_speech_intro"] = % ph_hill400_allies_start_adm_intro;
  level._id_EC85["admiral"]["hill_trench_speech_idle"][0] = % hm_grnd_red_cover_right_stand_hide_idle_ar;
  level._id_EC85["admiral"]["hill_trench_speech"] = % ph_hill400_allies_start_adm_speech;
  level._id_EC85["generic"]["hill_trench_speech_exit"] = % ph_hill400_allies_start_adm_exit;
  level._id_EC85["ally01"]["hill_trench_ally_intro"] = % ph_hill400_allies_start_ally01_intro;
  level._id_EC85["ally01"]["hill_trench_ally_idle"][0] = % ph_hill400_allies_start_ally01_idle;
  level._id_EC85["ally01"]["hill_trench_ally_exit"] = % ph_hill400_allies_start_ally01_exit;
  level._id_EC85["ally02"]["hill_trench_ally_intro"] = % ph_hill400_allies_start_ally02_intro;
  level._id_EC85["ally02"]["hill_trench_ally_idle"][0] = % ph_hill400_allies_start_ally02_idle;
  level._id_EC85["ally02"]["hill_trench_ally_exit"] = % ph_hill400_allies_start_ally02_exit;
  level._id_EC85["ally03"]["hill_trench_ally_intro"] = % ph_hill400_allies_start_ally03_intro;
  level._id_EC85["ally03"]["hill_trench_ally_idle"][0] = % ph_hill400_allies_start_ally03_idle;
  level._id_EC85["ally03"]["hill_trench_ally_exit"] = % ph_hill400_allies_start_ally03_exit;
  level._id_EC85["ally04"]["hill_trench_ally_intro"] = % ph_hill400_allies_start_ally04_intro;
  level._id_EC85["ally04"]["hill_trench_ally_idle"][0] = % ph_hill400_allies_start_ally04_idle;
  level._id_EC85["ally04"]["hill_trench_ally_exit"] = % ph_hill400_allies_start_ally04_exit;
  level._id_EC85["generic"]["turret_aim_idle"][0] = % humvee_turret_aim_2;
  level._id_EC85["generic"]["civilian_run_hunched_turnl90_slide"] = % civilian_run_hunched_turnl90_slide;
  level._id_EC85["generic"]["ph_hill400_allies_adm_berm_run"] = % ph_hill400_allies_adm_berm_run;
  level._id_EC85["generic"]["ph_hill400_allies_eth3n_berm_run"] = % ph_hill400_allies_eth3n_berm_run;
  level._id_EC85["generic"]["ph_hill400_allies_sltr_berm_run"] = % ph_hill400_allies_sltr_berm_run;
  level._id_EC85["generic"]["ph_hill400_mortar_stumble_right01"] = % ph_hill400_mortar_stumble_right01;
  level._id_EC85["generic"]["ph_hill400_mortar_stumble_left02"] = % ph_hill400_mortar_stumble_left02;
  level._id_EC85["failure"]["hill_cockpit_roll"] = % ph_hill400_cockpit_roll_death;
  scripts\sp\anim::_id_17FA("failure", "admiral_dodge_start", "hill_admiral_cockpit_dodge", "hill_cockpit_roll");
  level._id_EC85["redshirt1"]["hill_cockpit_roll"] = % ph_hill400_cockpit_roll_dodge_left;
  scripts\sp\anim::_id_17FC("redshirt1", "apc_start", "apc_cockpit_roll", "hill_cockpit_roll");
  level._id_EC85["redshirt2"]["hill_cockpit_roll"] = % ph_hill400_cockpit_roll_dodge_right;
  scripts\sp\anim::_id_17FC("redshirt2", "soldier1_start", "failure_cockpit_roll", "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("redshirt2", "droppod_start", "droppod_cockpit_roll", "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("redshirt2", "cockpit_start", "tail_cockpit_roll", "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("redshirt2", "cockpit_start", "cockpit_cockpit_roll", "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("redshirt2", "soldier02_start", "redshirt1_cockpit_roll", "hill_cockpit_roll");
  level._id_EC85["soldier01"]["hill_pair_cover_death"] = % ph_hill400_pair_death_cover_soldier01;
  scripts\sp\anim::_id_17F6("soldier01", "start_death", ::_id_C0C7, "hill_pair_cover_death");
  level._id_EC85["soldier02"]["hill_pair_cover_death"] = % ph_hill400_pair_death_cover_soldier02;
  scripts\sp\anim::_id_17F6("soldier02", "start_death", ::_id_C0C7, "hill_pair_cover_death");
  level._id_EC85["generic"]["ph_hill400_death_soldier03"] = % ph_hill400_death_soldier03;
  level._id_EC85["generic"]["ph_hill400_death_soldier04"] = % ph_hill400_death_soldier04;
  level._id_EC85["generic"]["ph_hill400_lookback_wave_death01"] = % ph_hill400_lookback_wave_death01;
  level._id_EC85["generic"]["ph_hill400_lookback_wave_death02"] = % ph_hill400_lookback_wave_death02;
  scripts\sp\anim::_id_17FF("generic", "vo", "ph_hill400_lookback_wave_death02", "phstreets_unm_keepmoving");
  level._id_EC85["generic"]["run_death_fallonback"] = % run_death_fallonback;
  level._id_EC85["generic"]["run_death_facedown"] = % run_death_facedown;
  level._id_EC85["generic"]["run_death_roll"] = % run_death_roll;
  level._id_EC85["generic"]["run_death_flop"] = % run_death_facedown;
  level._id_EC85["generic"]["exposed_death_falltoknees"] = % exposed_death_falltoknees;
  level._id_EC85["generic"]["death_explosion_stand_f_v1"] = % death_explosion_stand_f_v1;
  level._id_EC85["generic"]["death_explosion_stand_b_v1"] = % death_explosion_stand_b_v1;
  level._id_EC85["generic"]["death_explosion_stand_r_v1"] = % death_explosion_stand_r_v1;
  level._id_EC85["generic"]["ph_hill400_ally_jump_down_from_wall"] = % ph_hill400_ally_jump_down_from_wall;
  level._id_EC85["generic"]["ph_hill400_ally_lamp_death"] = % ph_hill400_ally_lamp_death;
  scripts\sp\anim::_id_17F6("generic", "first_bullet_impact", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_A7B4, "ph_hill400_ally_lamp_death");
  scripts\sp\anim::_id_17FC("generic", "second_bullet_impact", "lamp_death_bullet_impact", "ph_hill400_ally_lamp_death");
  level._id_EC85["generic"]["ph_hill400_apc_jump_a"] = % ph_hill400_apc_jump_a;
  level._id_EC85["generic"]["ph_hill400_apc_jump_b"] = % ph_hill400_apc_jump_b;
  level._id_EC85["generic"]["ph_hill400_apc_jump_c"] = % ph_hill400_apc_jump_c;
  level._id_EC85["generic"]["ph_hill400_apc_jump_d"] = % ph_hill400_apc_jump_d;
  level._id_EC85["generic"]["ph_hill400_apc_jump_death"] = % ph_hill400_apc_jump_death;
  level._id_EC85["generic"]["ph_hill400_allied_shellshock_left_01"] = % ph_hill400_allied_shellshock_left_01;
  level._id_EC85["generic"]["ph_hill400_allied_shellshock_right_01"] = % ph_hill400_allied_shellshock_right_01;
  level._id_EC85["generic"]["ph_hill400_allied_shellshock_right_03"] = % ph_hill400_allied_shellshock_right_03;
  level._id_EC85["generic"]["ph_hill400_allied_shellshock_right_04"] = % ph_hill400_allied_shellshock_right_04;
  level._id_EC85["generic"]["ph_hill400_allied_shellshock_right_06"] = % ph_hill400_allied_shellshock_right_06;
  level._id_EC85["generic"]["ph_hill400_allies_hill_slide_death_01"] = % ph_hill400_allies_hill_slide_death_01;
  level._id_EC85["generic"]["ph_hill400_allies_hill_slide_death_05"] = % ph_hill400_allies_hill_slide_death_05;
  level._id_EC85["generic"]["ph_hill400_sdf_dropship_deatha"] = % ph_hill400_sdf_dropship_deatha;
  scripts\sp\anim::_id_17F6("generic", "start_ragdoll", ::_id_C0C7, "ph_hill400_sdf_dropship_deatha");
  level._id_EC85["generic"]["ph_hill400_sdf_dropship_deathb"] = % ph_hill400_sdf_dropship_deathb;
  scripts\sp\anim::_id_17F6("generic", "start_ragdoll", ::_id_C0C7, "ph_hill400_sdf_dropship_deathb");
  level._id_EC85["soldier"]["hill_robot_kick"] = % ph_hill400_robot_wall_kick_soldier;
  scripts\sp\anim::_id_17F6("soldier", "start_death", ::_id_C0C7, "hill_robot_kick");
  scripts\sp\anim::_id_17F6("soldier", "wall_impact", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8F48, "hill_robot_kick");
  level._id_EC85["soldier"]["hill_robot_pulldown"] = % ph_hill400_c6_ledge_pulldown_ally;
  level._id_EC85["generic"]["ph_hill400_dropship_dead_body_01"][0] = % ph_hill400_dropship_dead_body_01;
  level._id_EC85["generic"]["ph_hill400_dropship_dead_body_02"][0] = % ph_hill400_dropship_dead_body_02;
  level._id_EC85["generic"]["ph_hill400_dropship_dead_body_03"][0] = % ph_hill400_dropship_dead_body_03;
  level._id_EC85["generic"]["ph_hill400_dropship_dead_body_04"][0] = % ph_hill400_dropship_dead_body_04;
  level._id_EC85["generic"]["ph_hill400_dropship_dead_body_05"][0] = % ph_hill400_dropship_dead_body_05;
  level._id_EC85["hvt"]["ph_hvt_pip_speech"][0] = % ph_tower_hvt_pip_hvt;
  level._id_EC85["hvt_guard"]["ph_hvt_pip_speech01"][0] = % ph_tower_hvt_pip_sdf01;
  level._id_EC85["hvt_guard"]["ph_hvt_pip_speech02"][0] = % ph_tower_hvt_pip_sdf02;
  level._id_EC85["hvt_guard"]["ph_hvt_pip_speech03"][0] = % ph_tower_hvt_pip_sdf03;
  level._id_EC85["hvt_guard"]["ph_hvt_pip_speech04"][0] = % ph_tower_hvt_pip_sdf04;
  level._id_EC85["hvt_guard"]["ph_hvt_pip_speech05"][0] = % ph_tower_hvt_pip_sdf05;
  level._id_EC85["eth3n"]["ph_hvt_breach"] = % ph_tower_break_in_c6i;
  scripts\sp\anim::_id_17FC("eth3n", "slow_time", "slow_time", "ph_hvt_breach");
  level._id_EC85["hvt"]["ph_hvt_breach"] = % ph_tower_break_in_hvt;
  level._id_EC85["hvt_guard"]["ph_hvt_breach01"] = % ph_tower_break_in_sdf01;
  level._id_EC85["hvt_guard"]["ph_hvt_breach02"] = % ph_tower_break_in_sdf02;
  level._id_EC85["hvt_guard"]["ph_hvt_breach03"] = % ph_tower_break_in_sdf03;
  level._id_EC85["hvt_guard"]["ph_hvt_breach04"] = % ph_tower_break_in_sdf04;
  level._id_EC85["hvt_guard"]["ph_hvt_breach05"] = % ph_tower_break_in_sdf05;
  level._id_EC85["eth3n"]["ph_hvt_breach_idle"][0] = % ph_tower_break_in_c6i_idle;
  level._id_EC85["hvt"]["ph_hvt_breach_idle"][0] = % ph_tower_break_in_hvt_idle;
  level._id_EC85["salter"]["ph_hvt_breach"] = % ph_tower_break_in_xo;
  level._id_EC88["salter"]["phstreets_slt_reyesopenitillc"] = % phstreets_slt_reyesopenitillc_face;
  level._id_EC88["salter"]["phstreets_slt_letsgetgoing"] = % phstreets_slt_letsgetgoing_face;
  level._id_EC88["salter"]["dust_cough_face"] = % ph_ccd_cqb_cough_face;
  level._id_EC88["admiral"]["dps_adm_eclipseyouarefree"] = % dps_adm_eclipseyouarefree_face;
  level._id_EC88["admiral"]["dust_cough_face"] = % ph_ccd_cqb_cough_face;
}

#using_animtree("c6");

_id_3353() {
  level._id_EC85["generic"]["c6_turret_aim_idle"][0] = % humvee_turret_aim_2;
  level._id_EC85["generic"]["c6_red_walk"] = % c6_grnd_red_walk_forward_ar;
  level._id_EC85["c6_reveal_01"]["root"] = % root;
  level._id_EC85["c6_reveal_01"]["c6_reveal"] = % ph_c6_intro_c6_01_openpod_open;
  scripts\sp\anim::_id_17FC("c6_reveal_01", "plr_start_anim", "c6_reveal_plr_start", "c6_reveal");
  scripts\sp\anim::_id_17F6("c6_reveal_01", "start_death", ::_id_C0C7, "c6_reveal");
  level._id_EC85["c6_reveal_01"]["c6_reveal_counter"] = % c6_grnd_red_melee_choke_counter;
  level._id_EC85["c6_reveal_02"]["c6_reveal"] = % ph_c6_intro_c6_02_openpod_open;
  level._id_EC85["c6_reveal_02"]["c6_reveal_loop"][0] = % ph_c6_intro_c6_02_openpod_open_loop;
  level._id_EC85["c6_reveal_03"]["c6_reveal"] = % ph_c6_intro_c6_03_openpod_open;
  level._id_EC85["c6_reveal_04"]["c6_reveal"] = % ph_c6_intro_c6_04_openpod_open;
  level._id_EC85["generic"]["hack_punch_table"][0] = % ph_cafe_c6_punch_table;
  level._id_EC85["c6"]["hill_trench_robot_punch"] = % ph_hill400_frontline_robot_punch_c6;
  scripts\sp\anim::_id_17F6("c6", "allow_death", ::_id_C0C3, "hill_trench_robot_punch");
  level._id_EC85["c6"]["hill_trench_robot_stomp"] = % ph_hill400_frontline_robot_stomp_c6;
  scripts\sp\anim::_id_17F6("c6", "allow_death", ::_id_C0C3, "hill_trench_robot_stomp");
  level._id_EC85["c6"]["hill_combat_robot_necksnap"] = % ph_hill400_frontline_robot_necksnap_c6;
  scripts\sp\anim::_id_17F6("c6", "allow_death", ::_id_C0C3, "hill_combat_robot_necksnap");
  level._id_EC85["c6"]["hill_robot_kick"] = % ph_hill400_robot_wall_kick_c6;
  scripts\sp\anim::_id_17F6("c6", "allow_death", ::_id_C0C3, "hill_robot_kick");
  scripts\sp\anim::_id_17FC("c6", "allow_death", "kick_c6_allow_death", "hill_robot_kick");
  level._id_EC85["c6"]["hill_robot_pulldown"] = % ph_hill400_c6_ledge_pulldown_c6;
  scripts\sp\anim::_id_17F6("c6", "allow_death", ::_id_C0C3, "hill_robot_pulldown");
  level._id_EC85["c6"]["hill_robot_ledge_pulldown"] = % ph_hill400_c6_ledge_pulldown_c6;
  level._id_EC85["generic"]["ph_hill400_c6_ledge_pulldown_c6"] = % ph_c6_intro_hop_over_railing_c6;
  level._id_EC85["generic"]["ph_c6_intro_hop_over_railing_c6"] = % ph_c6_intro_hop_over_railing_c6;
  level._id_EC85["c6"]["boss_dropship_c6_idle"][0] = % vh_red_air_ca_dropship_drop_idle_c6;
  level._id_EC85["c6"]["boss_dropship_c6_release"] = % vh_red_air_ca_dropship_drop_release_c6;
  level._id_EC85["c6"]["boss_dropship_c6_fall"][0] = % vh_red_air_ca_dropship_drop_fall_c6;
  level._id_EC85["c6"]["boss_dropship_c6_land"] = % vh_red_air_ca_dropship_drop_land_c6;
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7_naval";
  level._id_EC85["player_rig"]["dropship_wakeup"] = % ph_crash_dropship_wakeup_plr;
  scripts\sp\anim::_id_17F6("player_rig", "plr_ctrl_shake_sml", ::_id_D276, "dropship_wakeup");
  scripts\sp\anim::_id_17F6("player_rig", "plr_ctrl_shake_lrg", ::_id_D274, "dropship_wakeup");
  level._id_EC85["player_rig"]["dropship_wakeup_jumpout"] = % ph_crash_dropship_jumpout_plr;
  level._id_EC85["player_rig"]["dropship_wakeup_death"] = % ph_crash_dropship_death_plr;
  level._id_EC85["player_rig"]["grenade_give"] = % ph_coast_give_plr_grenades_plr;
  scripts\sp\anim::_id_17FA("player_rig", "dropship_unload", "grenade_tut_dropship_unload", "grenade_give");
  level._id_EC85["player_rig"]["c6_reveal"] = % ph_c6_intro_plr_openpod_open;
  scripts\sp\anim::_id_17FC("player_rig", "interact_start", "c6_reveal_player_interact_start", "c6_reveal");
  scripts\sp\anim::_id_17FC("player_rig", "interact_end", "c6_reveal_player_interact_end", "c6_reveal");
  scripts\sp\anim::_id_17F6("player_rig", "enable_plr_weapon", scripts\sp\maps\pearlharbor\pearlharbor_robots::_id_33A1, "c6_reveal");
  level._id_EC85["player_rig"]["c6_reveal_save"] = % ph_c6_intro_plr_openpod_slt_save;
  level._id_EC85["player_rig"]["c6_reveal_counter"] = % vm_grnd_red_melee_choke_counter;
  scripts\sp\anim::_id_17F5("player_rig", "attach_knife", level._id_EC8C["asm_viewmodel_knife"], "tag_accessory_right", "c6_reveal_counter");
  scripts\sp\anim::_id_17F7("player_rig", "detach_knife", level._id_EC8C["asm_viewmodel_knife"], "tag_accessory_right", "c6_reveal_counter");
  scripts\sp\anim::_id_1800("player_rig", "knife_stab", "c6_reveal_counter", "bt_c6_knife_counter_stab", "tag_knife_fx");
  level._id_EC85["player_rig"]["cafe_pod_slam"] = % ph_cafe_front_door_droppods_plr;
  level._id_EC85["player_rig"]["ethan_boost_pull"] = % ph_ccd_jump_over_wall_plr;
  scripts\sp\anim::_id_17FA("door_player_rig", "spawn_carry_scene", "hill_basement_carry_scene", "hill_basement_door_outro");
  level._id_EC85["player_rig"]["ph_hvt_breach"] = % ph_tower_break_in_plr;
  level._id_EC85["player_rig"]["ph_hvt_laptop"] = % ph_tower_plr_laptop;
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["g18"] = #animtree;
  level._id_EC8C["g18"] = "weapon_g18_rare_wm";
  level._id_EC87["grenade"] = #animtree;
  level._id_EC8C["grenade"] = "frag_grenade_prop";
  level._id_EC85["grenade"]["grenade_give"] = % ph_coast_give_plr_grenades_grenade;
  level._id_EC87["grenade_gate"] = #animtree;
  level._id_EC85["grenade_gate_left"]["grenade_give"] = % ph_coast_give_plr_grenades_gate;
  level._id_EC85["grenade_gate_right"]["grenade_give"] = % ph_coast_give_plr_grenades_gate_right;
  level._id_EC87["boat_rig"] = #animtree;
  level._id_EC8C["boat_rig"] = "ph_tsunami_boat_rig";
  level._id_EC85["boat_rig"]["lake_ship_crash"] = % ph_tsunami_boat_surf;
  level._id_EC87["yacht"] = #animtree;
  level._id_EC8C["yacht"] = "veh_civ_sea_yacht_01_dmg";
  level._id_EC85["yacht"]["lake_ship_crash"] = % ph_lake_crash_boat;
  scripts\sp\anim::_id_17FC("yacht", "watersheeting", "lake_crash_watersheeting", "lake_ship_crash");
  scripts\sp\anim::_id_17FC("yacht", "start_slide", "lake_ship_crash_slide_start", "lake_ship_crash");
  scripts\sp\anim::_id_17FC("yacht", "stop_slide", "lake_ship_crash_slide_stop", "lake_ship_crash");
  level._id_EC87["aatis"] = #animtree;
  level._id_EC8C["aatis"] = "building_aatis_planetary_defense_gun";
  level._id_EC85["aatis"]["lake_ship_crash"] = % ph_lake_crash_aatis_gun;
  level._id_EC85["aatis"]["lake_ship_crash_loop"][0] = % ph_lake_crash_aatis_gun_loop;
  scripts\sp\anim::_id_17FC("aatis", "start_cruiser", "lake_crash_cruiser_start", "lake_ship_crash");
  scripts\sp\anim::_id_17FC("aatis", "aatis_fire", "aatis_fire", "lake_ship_crash");
  level._id_EC87["droppod"] = #animtree;
  level._id_EC8C["droppod"] = "veh_mil_air_ca_drop_pod_large_base";
  level._id_EC85["droppod"]["c6_reveal_land"] = % ph_c6_intro_droppod_land;
  scripts\sp\anim::_id_17FC("droppod", "impact", "c6_reveal_droppod_impact", "c6_reveal_land");
  level._id_EC87["droppod_door"] = #animtree;
  level._id_EC85["droppod_door"]["c6_reveal_land"] = % ph_c6_intro_droppod_door_land;
  level._id_EC85["droppod_door"]["c6_reveal"] = % ph_c6_intro_droppod_door_open;
  level._id_EC8C["droppod_door"] = "veh_mil_air_ca_drop_pod_doors";
  level._id_EC85["droppod_arm_0"]["c6_reveal"] = % ph_c6_intro_droppod_arm01_open;
  level._id_EC85["droppod_arm_1"]["c6_reveal"] = % ph_c6_intro_droppod_arm02_open;
  level._id_EC85["droppod_arm_1"]["c6_reveal_loop"][0] = % ph_c6_intro_droppod_arm02_open_loop;
  level._id_EC85["droppod_arm_2"]["c6_reveal"] = % ph_c6_intro_droppod_arm03_open;
  level._id_EC85["droppod_arm_3"]["c6_reveal"] = % ph_c6_intro_droppod_arm04_open;
  level._id_EC85["dumpster"]["c6_reveal"] = % ph_c6_intro_dumpster_droppod_open;
  level._id_EC87["dumpster"] = #animtree;
  level._id_EC87["trash0"] = #animtree;
  level._id_EC8C["trash0"] = "rp_dumpster_lid_01";
  level._id_EC85["trash0"]["c6_reveal"] = % ph_c6_intro_dumpster_lid01_droppod_open;
  level._id_EC87["trash1"] = #animtree;
  level._id_EC8C["trash1"] = "rp_dumpster_lid_01";
  level._id_EC85["trash1"]["c6_reveal"] = % ph_c6_intro_dumpster_lid02_droppod_open;
  level._id_EC87["trash2"] = #animtree;
  level._id_EC8C["trash2"] = "com_trashbag1_black";
  level._id_EC85["trash2"]["c6_reveal"] = % ph_c6_intro_dumpster_bag01_droppod_open;
  level._id_EC87["trash3"] = #animtree;
  level._id_EC8C["trash3"] = "com_trashbag2_green";
  level._id_EC85["trash3"]["c6_reveal"] = % ph_c6_intro_dumpster_bag02_droppod_open;
  level._id_EC87["trash4"] = #animtree;
  level._id_EC8C["trash4"] = "rp_dumpster_garbage_01";
  level._id_EC85["trash4"]["c6_reveal"] = % ph_c6_intro_dumpster_trash_droppod_open;
  level._id_EC87["table_flip_moment"] = #animtree;
  level._id_EC85["table_flip_moment"]["table_flip"] = % ph_cafe_flip_table_table;
  level._id_EC8C["table_flip_moment"] = "bike_shop_clothing_table_01";
  level._id_EC87["umbrella"] = #animtree;
  level._id_EC8C["umbrella"] = "furniture_parasol_open_grey_dustable";
  level._id_EC85["umbrella"]["dust_umbrella"] = % ph_ccd_dust_parasol_01;
  level._id_EC87["cafe_table"] = #animtree;
  level._id_EC8C["cafe_table"] = "lobby_table_02";
  level._id_EC85["cafe_table"]["cafe_table_intro"] = % ph_cafe_table_wall_table_intro;
  level._id_EC85["cafe_table"]["cafe_table_intro_idle"][0] = % ph_cafe_table_wall_table_intro_idle;
  level._id_EC85["cafe_table"]["cafe_table"] = % ph_cafe_table_wall_table;
  level._id_EC85["cafe_table"]["cafe_table_idle"][0] = % ph_cafe_table_wall_table_idle;
  level._id_EC85["cafe_table"]["cafe_table_outro"] = % ph_cafe_table_wall_table_outro;
  level._id_EC87["cafe_door"] = #animtree;
  level._id_EC85["cafe_door"]["cafe_pod_slam"] = % ph_cafe_front_door_droppods_door;
  level._id_EC85["door"]["basement_lift_idle"] = % ph_hill400_building_debris_lift_beam_idle;
  level._id_EC87["basement_box"] = #animtree;
  level._id_EC8C["basement_box"] = "container_lag_cardboard_box_03";
  level._id_EC85["basement_box"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_box_exit;
  level._id_EC87["basement_book"] = #animtree;
  level._id_EC8C["basement_book"] = "com_office_book_red_flat";
  level._id_EC85["basement_book"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_book_exit;
  level._id_EC87["basement_pot"] = #animtree;
  level._id_EC8C["basement_pot"] = "p7_pot_metal_stock";
  level._id_EC85["basement_pot"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_pot_exit;
  level._id_EC87["basement_btl"] = #animtree;
  level._id_EC8C["basement_btl"] = "p7_bottle_plastic_16oz_water";
  level._id_EC85["basement_btl"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_wtrbtl_exit;
  level._id_EC87["basement_cup"] = #animtree;
  level._id_EC8C["basement_cup"] = "cup_paper_open_iw6";
  level._id_EC85["basement_cup"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_cup_exit;
  level._id_EC87["basement_wine"] = #animtree;
  level._id_EC8C["basement_wine"] = "misc_bottle_wine_01";
  level._id_EC85["basement_wine"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_wine_exit;
  level._id_EC87["basement_wall"] = #animtree;
  level._id_EC8C["basement_wall"] = "building_cellar_cafe_wall_animated_pieces";
  level._id_EC85["basement_wall"]["basement_debris_lift_exit"] = % ph_hill400_building_debris_lift_wall_lift;
  level._id_EC87["dropship_seat"] = #animtree;
  level._id_EC8C["dropship_seat"] = "veh_mil_air_un_dropship_seat_wm";
  level._id_EC85["dropship_seat"]["ph_hill400_dropship_dead_body_seat_01"][0] = % ph_hill400_dropship_dead_body_seat_01;
  level._id_EC85["dropship_seat"]["ph_hill400_dropship_dead_body_seat_02"][0] = % ph_hill400_dropship_dead_body_seat_02;
  level._id_EC85["dropship_seat"]["ph_hill400_dropship_dead_body_seat_03"][0] = % ph_hill400_dropship_dead_body_seat_03;
  level._id_EC85["dropship_seat"]["ph_hill400_dropship_dead_body_seat_04"][0] = % ph_hill400_dropship_dead_body_seat_04;
  level._id_EC85["dropship_seat"]["ph_hill400_dropship_dead_body_seat_05"][0] = % ph_hill400_dropship_dead_body_seat_05;
  level._id_EC85["cockpit"]["hill_cockpit_roll"] = % ph_hill400_dropship_cockpit_roll_cockpit;
  scripts\sp\anim::_id_17F6("cockpit", "earthquake", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_430A, "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("cockpit", "staircase_01_vase_impact", "staircase_01_vase_impact", "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("cockpit", "staircase_01_impact", "staircase_01_impact", "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("cockpit", "staircase_02_vase_impact", "staircase_02_vase_impact", "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("cockpit", "staircase_02_impact", "staircase_02_impact", "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("cockpit", "staircase_03_vase_impact", "staircase_03_vase_impact", "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("cockpit", "staircase_03_impact", "staircase_03_impact", "hill_cockpit_roll");
  scripts\sp\anim::_id_17FC("cockpit", "staircase_04_impact", "staircase_04_impact", "hill_cockpit_roll");
  level._id_EC85["apc"]["hill_cockpit_roll"] = % ph_hill400_dropship_cockpit_roll_apc;
  level._id_EC85["generic"]["sign_exterior_flag_tallx2_loop_01"][0] = % sign_exterior_flag_tallx2_loop_01;
  level._id_EC85["arm"]["boss_dropship_c6_idle"][0] = % vh_red_air_ca_dropship_drop_idle_arm;
  level._id_EC85["arm"]["boss_dropship_c6_release"] = % vh_red_air_ca_dropship_drop_release_arm;
  level._id_EC85["arm"]["boss_dropship_c6_fall"] = % vh_red_air_ca_dropship_drop_fall_arm;
  level._id_EC87["lot_statue"] = #animtree;
  level._id_EC85["lot_statue"]["statue_collapse"] = % ph_tower_entrance_statue_fall;
  level._id_EC87["lot_crate_1"] = #animtree;
  level._id_EC85["lot_crate_1"]["crate_explode"] = % ph_tower_entrance_crate_explode_crate01;
  level._id_EC87["lot_crate_2"] = #animtree;
  level._id_EC85["lot_crate_2"]["crate_explode"] = % ph_tower_entrance_crate_explode_crate02;
  level._id_EC87["lot_crate_3"] = #animtree;
  level._id_EC85["lot_crate_3"]["crate_explode"] = % ph_tower_entrance_crate_explode_crate03;
  level._id_EC87["lot_crate_4"] = #animtree;
  level._id_EC85["lot_crate_4"]["crate_explode"] = % ph_tower_entrance_crate_explode_crate04;
  level._id_EC87["lot_crate_5"] = #animtree;
  level._id_EC85["lot_crate_5"]["crate_explode"] = % ph_tower_entrance_crate_explode_crate05;
  level._id_EC87["right_door"] = #animtree;
  level._id_EC85["right_door"]["ph_hvt_breach"] = % ph_tower_break_in_door_r;
  level._id_EC87["right_door_dest"] = #animtree;
  level._id_EC85["right_door_dest"]["ph_hvt_breach"] = % ph_tower_break_in_door_r_dest;
  level._id_EC87["left_door"] = #animtree;
  level._id_EC85["left_door"]["ph_hvt_breach"] = % ph_tower_break_in_door_l;
  level._id_EC87["left_door_dest"] = #animtree;
  level._id_EC85["left_door_dest"]["ph_hvt_breach"] = % ph_tower_break_in_door_l_dest;
  _id_F926();
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC87["dropship_rear"] = #animtree;
  level._id_EC8C["dropship_rear"] = "veh_mil_air_ca_dropship_severed_rear";
  level._id_EC85["dropship_rear"]["rear_crash"] = % ph_hill400_sdf_dropship_crash_part_b;
  level._id_EC87["dropship"] = #animtree;
  level._id_EC8C["dropship"] = "veh_mil_air_un_dropship_hero_crash";
  level._id_EC85["dropship"]["dropship_wakeup"] = % ph_crash_dropship_wakeup_dropship;
  scripts\sp\anim::_id_17F6("dropship", "wake_up_drop", ::_id_5F05, "dropship_wakeup");
  level._id_EC87["dropship_turret"] = #animtree;
  level._id_EC8C["dropship_turret"] = "veh_mil_air_ca_dropship_turret";
  level._id_EC85["dropship_turret"]["dropship_turret_0"] = % ph_crash_dropship_wakeup_sdf_dropship_01_turret;
  level._id_EC85["dropship_turret"]["dropship_turret_1"] = % ph_crash_dropship_wakeup_sdf_dropship_02_turret;
  scripts\sp\anim::_id_17FC("dropship_turret", "start_fire", "start_fire", "dropship_turret_1");
  scripts\sp\anim::_id_17FC("dropship_turret", "stop_fire", "stop_fire", "dropship_turret_1");
  level._id_EC85["cruiser"]["lake_ship_crash"] = % ph_lake_crash_cruiser;
  scripts\sp\anim::_id_17FC("cruiser", "start_boat", "lake_crash_yacht_start", "lake_ship_crash");
  level._id_EC85["destroyer"]["ethan_boost_pull"] = % ph_ccd_jump_over_wall_un_dest;
  level._id_EC85["generic"]["hill_dropship_crash_idle"][0] = % ph_hill400_dropship_crash_idle;
  level._id_EC85["generic"]["hill_dropship_crash"] = % ph_hill400_dropship_crash;
  scripts\sp\anim::_id_17F6("generic", "impact", ::_id_5E13, "hill_dropship_crash");
  level._id_EC85["droppod"]["hill_cockpit_roll"] = % ph_hill400_dropship_cockpit_roll_droppod;
  level._id_EC85["hacked_dropship"]["custom_death"] = % ph_hill400_sdf_dropship_crash;
  scripts\sp\anim::_id_17F6("hacked_dropship", "break_up", ::_id_880D, "custom_death");

  if(getdvarint("E3", 0)) {
    level._id_EC87["retribution"] = #animtree;
    level._id_EC85["retribution"]["jackal_callin_dps"] = % ph_jackals_landing_retribution_dps;
  }

  level._id_EC87["sdf_dropship"] = #animtree;
  level._id_EC85["sdf_dropship"]["mall_sdf_dropship_1"] = % ph_crash_dropship_wakeup_sdf_dropship_01;
  level._id_EC85["sdf_dropship"]["mall_sdf_dropship_2"] = % ph_crash_dropship_wakeup_sdf_dropship_02;
}

#using_animtree("scriptables");

_id_EF3C() {
  level._id_EC85["generic"]["ph_veh_hatchback_opendoor_driver"] = % ph_veh_hatchback_opendoor_driver;
  level._id_EC85["generic"]["ph_veh_hatchback_opendoor_both"] = % ph_veh_hatchback_opendoor_both;
  level._id_EC85["generic"]["ph_veh_hatchback_opendoor_all"] = % ph_veh_hatchback_opendoor_all;
  level._id_EC85["generic"]["ph_veh_hatchback_opendoor_passenger"] = % ph_veh_hatchback_opendoor_passenger;
  level._id_EC85["car"]["dust_push"] = % ph_ccd_dust_car_front;
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC85["generic"]["death_roll_right"] = % jackal_death_01;
  level._id_EC85["generic"]["death_roll_left"] = % jackal_death_02;
  level._id_EC85["generic"]["death_roll_center"] = % jackal_death_04;
  level._id_EC85["jackal_1"]["ethan_boost_pull"] = % ph_ccd_jump_over_wall_jackal01;
  level._id_EC85["jackal_2"]["ethan_boost_pull"] = % ph_ccd_jump_over_wall_jackal02;

  if(getdvarint("E3", 0)) {
    level._id_EC87["player_jackal"] = #animtree;
    level._id_EC85["player_jackal"]["jackal_callin_dps"] = % ph_jackals_landing_jackal01_dps;
    level._id_EC87["salter_jackal"] = #animtree;
    level._id_EC85["salter_jackal"]["jackal_callin_dps"] = % ph_jackals_landing_jackal02_dps;
    level._id_EC85["salter_jackal"]["jackal_callin_dps_idle"][0] = % ph_jackals_landing_jackal02_idle_dps;
  }
}

_id_36AB(var_0) {
  playFX(level._effect["vfx_ph_hill_capship_missile_impact"], var_0.origin);
  var_0 playSound("dropship_helicopter_crash");
}

_id_D609(var_0) {}

_id_C0C7(var_0) {
  if(isDefined(var_0._id_B14F))
    var_0 scripts\sp\utility::_id_1101B();

  if(!isDefined(var_0._id_EE5F) || !var_0._id_EE5F)
    var_0.forceragdollimmediate = 1;

  var_0 scripts\sp\utility::_id_F2A8(1);
  var_0._id_10265 = 1;
  var_0._id_4E46 = _id_0C60::_id_58CB;
  var_0 scripts\sp\utility::_id_54C6();
}

_id_C11B(var_0, var_1) {
  if(isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();

  if(!isDefined(self._id_EE5F) || !self._id_EE5F)
    self.forceragdollimmediate = 1;

  self._id_10265 = 1;
  self._id_4E46 = _id_0C60::_id_58CB;
  scripts\sp\utility::_id_54C6();
}

_id_5E13(var_0) {
  var_0 thread scripts\sp\vehicle::_id_A5DF(var_0.model, 0);
}

_id_C0C3(var_0) {
  if(isDefined(var_0._id_B14F))
    var_0 scripts\sp\utility::_id_1101B();

  var_0 scripts\sp\utility::_id_F2A8(1);
  var_0 setCanDamage(1);
}

_id_C0DD(var_0) {
  level endon("notetrack_fire_stop");
  level notify(var_0._id_1FBB + "_firing");

  for(;;) {
    var_0 shoot();
    wait 0.1;
  }
}

#using_animtree("generic_human");

_id_8F2C() {
  var_0 = [];
  var_0["admiral"]["idle"] = % ph_hill400_building_debris_lift_adm_idle;
  var_0["admiral"]["pull"] = % ph_hill400_building_debris_lift_adm_lift;
  var_0["admiral"]["outro"] = % ph_hill400_building_debris_lift_adm_exit;
  scripts\sp\anim::_id_17F6("admiral", "mayhem_start", scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8F10);
  scripts\sp\anim::_id_17FC("admiral", "mayhem_end", "beam_lift_mayhem_end");
  var_0["salter"]["intro"] = % ph_hill400_building_debris_lift_slt_intro;
  var_0["salter"]["idle"] = % ph_hill400_building_debris_lift_slt_idle;
  var_0["salter"]["outro"] = % ph_hill400_building_debris_lift_slt_exit;
  var_0["eth3n"]["idle"] = % ph_hill400_building_debris_lift_ethn_idle;
  var_0["eth3n"]["pull"] = % ph_hill400_building_debris_lift_ethn_lift;
  var_0["eth3n"]["outro"] = % ph_hill400_building_debris_lift_ethn_exit;
  var_0["ally01"]["outro"] = % ph_hill400_building_debris_lift_ally01_exit;
  var_0["ally02"]["outro"] = % ph_hill400_building_debris_lift_ally02_exit;
  var_0["ally03"]["outro"] = % ph_hill400_building_debris_lift_ally03_exit;
  var_0["ally04"]["outro"] = % ph_hill400_building_debris_lift_ally04_exit;
  var_0["ally05"]["outro"] = % ph_hill400_building_debris_lift_ally05_exit;
  return var_0;
}

#using_animtree("player");

_id_8F2D() {
  var_0 = [];
  var_0["door_player_rig"]["intro"] = % ph_hill400_building_debris_lift_plr_intro;
  var_0["door_player_rig"]["idle"] = % ph_hill400_building_debris_lift_plr_idle;
  var_0["door_player_rig"]["pull"] = % ph_hill400_building_debris_lift_plr_lift;
  var_0["door_player_rig"]["outro"] = % ph_hill400_building_debris_lift_plr_exit;
  return var_0;
}

#using_animtree("script_model");

_id_8F2B() {
  var_0 = [];
  var_0["door"]["idle"] = % ph_hill400_building_debris_lift_beam_idle;
  var_0["door"]["pull"] = % ph_hill400_building_debris_lift_beam_lift;
  var_0["basement_wall"]["pull"] = % ph_hill400_building_debris_lift_wall_lift;
  var_0["door"]["outro"] = % ph_hill400_building_debris_lift_beam_exit;
  var_0["basement_box"]["outro"] = % ph_hill400_building_debris_lift_box_exit;
  var_0["basement_book"]["outro"] = % ph_hill400_building_debris_lift_book_exit;
  var_0["basement_pot"]["outro"] = % ph_hill400_building_debris_lift_pot_exit;
  var_0["basement_btl"]["outro"] = % ph_hill400_building_debris_lift_wtrbtl_exit;
  var_0["basement_cup"]["outro"] = % ph_hill400_building_debris_lift_cup_exit;
  var_0["basement_wine"]["outro"] = % ph_hill400_building_debris_lift_wine_exit;
  var_0["basement_wall"]["outro"] = % ph_hill400_building_debris_lift_wall_exit;
  return var_0;
}

_id_F926() {
  level._id_EC87["crash_umbrella"] = #animtree;
  level._id_EC8C["crash_umbrella"] = "decor_modern_metal_table_umbrella_02";
  level._id_EC85["crash_umbrella"]["umbrella_0"] = % ph_crash_dropship_wakeup_umbrella01;
  level._id_EC85["crash_umbrella"]["umbrella_1"] = % ph_crash_dropship_wakeup_umbrella02;
  level._id_EC85["crash_umbrella"]["umbrella_2"] = % ph_crash_dropship_wakeup_umbrella03;
  level._id_EC85["crash_umbrella"]["umbrella_3"] = % ph_crash_dropship_wakeup_umbrella04;
  level._id_EC85["crash_umbrella"]["umbrella_4"] = % ph_crash_dropship_wakeup_umbrella05;
  level._id_EC85["crash_umbrella"]["umbrella_5"] = % ph_crash_dropship_wakeup_umbrella06;
  level._id_EC85["crash_umbrella"]["umbrella_6"] = % ph_crash_dropship_wakeup_umbrella07;
  level._id_EC85["crash_umbrella"]["umbrella_7"] = % ph_crash_dropship_wakeup_umbrella08;
  level._id_EC85["crash_umbrella"]["umbrella_8"] = % ph_crash_dropship_wakeup_umbrella09;
  level._id_EC85["crash_umbrella"]["umbrella_9"] = % ph_crash_dropship_wakeup_umbrella10;
  level._id_EC85["crash_umbrella"]["umbrella_10"] = % ph_crash_dropship_wakeup_umbrella11;
  level._id_EC85["crash_umbrella"]["umbrella_11"] = % ph_crash_dropship_wakeup_umbrella12;
  level._id_EC87["crash_chair"] = #animtree;
  level._id_EC8C["crash_chair"] = "furniture_restaurant_chair_03";
  level._id_EC85["crash_chair"]["chair_0"] = % ph_crash_dropship_wakeup_chair01;
  level._id_EC85["crash_chair"]["chair_1"] = % ph_crash_dropship_wakeup_chair02;
  level._id_EC85["crash_chair"]["chair_2"] = % ph_crash_dropship_wakeup_chair03;
  level._id_EC85["crash_chair"]["chair_3"] = % ph_crash_dropship_wakeup_chair04;
  level._id_EC85["crash_chair"]["chair_4"] = % ph_crash_dropship_wakeup_chair05;
  level._id_EC85["crash_chair"]["chair_5"] = % ph_crash_dropship_wakeup_chair06;
  level._id_EC85["crash_chair"]["chair_6"] = % ph_crash_dropship_wakeup_chair07;
  level._id_EC85["crash_chair"]["chair_7"] = % ph_crash_dropship_wakeup_chair08;
  level._id_EC85["crash_chair"]["chair_8"] = % ph_crash_dropship_wakeup_chair09;
  level._id_EC85["crash_chair"]["chair_9"] = % ph_crash_dropship_wakeup_chair10;
  level._id_EC85["crash_chair"]["chair_10"] = % ph_crash_dropship_wakeup_chair11;
  level._id_EC85["crash_chair"]["chair_11"] = % ph_crash_dropship_wakeup_chair12;
  level._id_EC85["crash_chair"]["chair_12"] = % ph_crash_dropship_wakeup_chair13;
  level._id_EC85["crash_chair"]["chair_13"] = % ph_crash_dropship_wakeup_chair14;
  level._id_EC85["crash_chair"]["chair_14"] = % ph_crash_dropship_wakeup_chair15;
  level._id_EC85["crash_chair"]["chair_15"] = % ph_crash_dropship_wakeup_chair16;
  level._id_EC85["crash_chair"]["chair_16"] = % ph_crash_dropship_wakeup_chair17;
  level._id_EC85["crash_chair"]["chair_17"] = % ph_crash_dropship_wakeup_chair18;
  level._id_EC85["crash_chair"]["chair_18"] = % ph_crash_dropship_wakeup_chair19;
  level._id_EC85["crash_chair"]["chair_19"] = % ph_crash_dropship_wakeup_chair20;
  level._id_EC85["crash_chair"]["chair_20"] = % ph_crash_dropship_wakeup_chair21;
  level._id_EC85["crash_chair"]["chair_21"] = % ph_crash_dropship_wakeup_chair22;
  level._id_EC85["crash_chair"]["chair_22"] = % ph_crash_dropship_wakeup_chair23;
  level._id_EC85["crash_chair"]["chair_23"] = % ph_crash_dropship_wakeup_chair24;
  level._id_EC85["crash_chair"]["chair_24"] = % ph_crash_dropship_wakeup_chair25;
  level._id_EC85["crash_chair"]["chair_25"] = % ph_crash_dropship_wakeup_chair26;
  level._id_EC85["crash_chair"]["chair_26"] = % ph_crash_dropship_wakeup_chair27;
  level._id_EC85["crash_chair"]["chair_27"] = % ph_crash_dropship_wakeup_chair28;
  level._id_EC85["crash_chair"]["chair_28"] = % ph_crash_dropship_wakeup_chair29;
  level._id_EC85["crash_chair"]["chair_29"] = % ph_crash_dropship_wakeup_chair30;
  level._id_EC85["crash_chair"]["chair_30"] = % ph_crash_dropship_wakeup_chair31;
  level._id_EC85["crash_chair"]["chair_31"] = % ph_crash_dropship_wakeup_chair32;
  level._id_EC85["crash_chair"]["chair_32"] = % ph_crash_dropship_wakeup_chair33;
  level._id_EC87["crash_table"] = #animtree;
  level._id_EC8C["crash_table"] = "furniture_restaurant_table_01";
}

_id_880D(var_0) {
  playworldsound("scn_phstreets_hill_dropship_horizon_explo", var_0.origin);
  var_0._id_7441 show();
  var_0 hide();
  var_0 notify("break_up");
}

_id_D276(var_0) {
  earthquake(0.3, 1.05, level.player.origin, 500);
  var_1 = scripts\sp\utility::_id_7C23();
  var_1.origin = level.player.origin;
  var_1 scripts\sp\utility::_id_E7C9(0.5, 0.05);
  wait 0.75;
  var_1 scripts\sp\utility::_id_E7C9(0, 0.5);
  wait 1;
  var_1 delete();
}

_id_D274(var_0) {
  earthquake(0.6, 1.05, level.player.origin, 500);
  var_1 = scripts\sp\utility::_id_7C23();
  var_1.origin = level.player.origin;
  var_1 scripts\sp\utility::_id_E7C9(2, 0.05);
  wait 1.25;
  var_1 scripts\sp\utility::_id_E7C9(0, 0.5);
  wait 1;
  var_1 delete();
}

_id_5F05(var_0) {
  level endon("crash_player_jumper_dead");
  level notify("ds_falling");
  thread scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_10743();
  level.player giveweapon("iw7_g18+elopstl");
  level.player switchtoweaponimmediate("iw7_g18+elopstl");
  level.player enableweapons();
  thread _id_5F06();
  scripts\engine\utility::exploder("dscrash");
  thread scripts\sp\maps\pearlharbor\pearlharbor_crash::_id_AD0E();
  wait 1.25;
  thread _id_4807();
  setslowmotion(1, 0.15, 0.5);
  level waittill("timeToFail");
  wait 0.05;
  level waittill("timeToFail");
  wait 0.05;
  level waittill("timeToFail");
  wait 0.05;
  level waittill("timeToFail");
  wait 0.05;
  level waittill("timeToFail");
  level.player freezecontrols(1);
  setslowmotion(0.15, 1, 2);
  level.player _meth_81D0();
}

_id_5F06() {
  level.player scripts\engine\utility::allow_ads(0);
  wait 1.25;
  level.player scripts\engine\utility::allow_ads(1);
}

_id_4807() {
  level.player allowads(0);
  thread _id_0B0A::_id_583F(0, 15, 6, 0, 789.381, 4.3, 0.75);
  wait 0.3;
  setsaveddvar("scr_dof_enable", "0");
  level.player allowads(1);
  scripts\engine\utility::flag_wait("crash_player_jumper_dead");

  while(level.player scripts\sp\utility::_id_9D27())
    wait 0.05;

  setsaveddvar("scr_dof_enable", 1);
  thread _id_0B0A::_id_583D(1);
}

_id_CE8F(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = level.player.origin + anglesToForward(level.player getplayerangles()) * -75;
  level waittill("phstreets_eth_sir1");
  var_1 playSound("phstreets_eth_sir1");
  level waittill("phstreets_adm_theyreshootingc");
  wait 1.5;
  var_1 playSound("phstreets_adm_theyreshootingc");
  level waittill("phstreets_eth_wegottangosmovi");
  wait 3;
  var_1 delete();
}

#using_animtree("generic_human");

_id_1385A(var_0) {
  var_1 = level.allies["salter"];
  var_1 detach(var_1.headmodel);
  var_1 _meth_82A2(%mayhem_ph_crash_dropship_wakeup_slt_1, 1.0, 0.0, 1.0);
  level waittill("mayhem_end");
  var_1 _meth_82A2(%mayhem_ph_crash_dropship_wakeup_slt_1, 0.0, 0.0, 1.0);
  var_1 attach(var_1.headmodel);
}

_id_1385B(var_0) {
  var_1 = level.allies["salter"];
  var_1 detach(var_1.headmodel);
  var_1 _meth_82A2(%mayhem_ph_crash_dropship_wakeup_slt_2, 1.0, 0.0, 1.0);
  level waittill("mayhem_end");
  var_1 _meth_82A2(%mayhem_ph_crash_dropship_wakeup_slt_2, 0.0, 0.0, 1.0);
  var_1 attach(var_1.headmodel);
}

_id_102D0(var_0) {
  var_1 = ["tag_eye", "j_clavicle_le", "j_clavicle_ri", "j_hip_ri"];
  var_1 = scripts\engine\utility::array_randomize(var_1);

  switch (var_0.animation) {
    case "ph_civi_run_death_01":
      var_0 playSound("phstreets_mcv5_cryscream3");
      break;
    case "ph_civi_run_death_02":
      var_0 playSound("phstreets_mcv4_cryscream1");
      break;
    case "ph_civi_run_death_03":
      var_0 playSound("phstreets_mcv1_cryscream1");
      break;
    case "ph_civi_run_death_04":
      var_0 playSound("phstreets_fcv2_cryscream1");
      break;
    case "ph_civi_run_death_05":
      var_0 playSound("phstreets_fcv3_cryscream3");
      break;
    case "ph_civi_run_death_06":
      var_0 playSound("phstreets_fcv3_cryscream6");
      break;
    default:
      break;
  }

  foreach(var_3 in var_1) {
    var_4 = var_0 gettagorigin("j_spine4") + anglesToForward(var_0.angles) * -200;
    var_5 = var_0 gettagorigin(var_3);
    magicbullet("iw7_ar57", var_4, var_5);
    bullettracer(var_4, var_5, "iw7_ar57", 1);
    playFX(level._effect["vfx_ph_hvt_blood_spurt"], var_5, anglesToForward(var_0.angles) * 10);
    wait 0.1;
  }
}

_id_B0C7(var_0) {
  var_1 = ["tag_eye", "j_clavicle_le", "j_clavicle_ri", "j_hip_ri"];
  var_1 = scripts\engine\utility::array_randomize(var_1);

  if(var_0._id_1FBB == "lover_male")
    var_0 playSound("phstreets_mcv5_cryscream3");
  else
    var_0 playSound("phstreets_fcv3_cryscream6");

  foreach(var_3 in var_1) {
    var_4 = var_0 gettagorigin("j_spine4") + anglesToForward(var_0.angles) * -200;
    var_5 = var_0 gettagorigin(var_3);
    magicbullet("iw7_ar57", var_4, var_5);
    bullettracer(var_4, var_5, "iw7_ar57", 1);
    playFX(level._effect["vfx_ph_hvt_blood_spurt"], var_5, anglesToForward(var_0.angles) * 10);
    wait 0.1;
  }
}