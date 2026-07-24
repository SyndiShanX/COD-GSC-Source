/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phspace\phspace_anim.gsc
****************************************************/

main() {
  _id_91DC();
  _id_3353();
  player();
  _id_13267();
  _id_A056();
  script_model();
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["soldier01"]["hvt_handoff"] = % ph_aatis_tower_hvt_handoff_ally01;
  level._id_EC85["soldier02"]["hvt_handoff"] = % ph_aatis_tower_hvt_handoff_ally02;
  level._id_EC85["soldier03"]["hvt_handoff"] = % ph_aatis_tower_hvt_handoff_ally03;
  level._id_EC85["hvt"]["hvt_handoff"] = % ph_aatis_tower_hvt_handoff_hvt;
  level._id_EC85["soldier01"]["hvt_handoff_idle"][0] = % ph_aatis_tower_hvt_handoff_ally01_idle;
  level._id_EC85["soldier02"]["hvt_handoff_idle"][0] = % ph_aatis_tower_hvt_handoff_ally02_idle;
  level._id_EC85["soldier03"]["hvt_handoff_idle"][0] = % ph_aatis_tower_hvt_handoff_ally03_idle;
  level._id_EC85["hvt"]["hvt_handoff_idle"][0] = % ph_aatis_tower_hvt_handoff_hvt_idle;
  level._id_EC85["eth3n"]["eth3n_mount"] = % ph_jackals_c6i_climb_back_seat_c6i;
  level._id_EC85["eth3n"]["eth3n_sitting"] = % heist_mons_intro_lookback_ethan;
  level._id_EC85["eth3n"]["eth3n_mount_idle"][0] = % ph_jackals_c6i_climb_back_seat_c6i_ilde;
  level._id_EC85["eth3n"]["eth3n_mount_2"] = % ph_tower_jackal_c6i_board;
  level._id_EC88["admiral"]["phspace_adm_lieutenantsimor"] = % phspace_adm_lieutenantsimor_face;
  level._id_EC88["admiral"]["phspace_adm_getyourselfwinged"] = % phspace_adm_getyourselfwinged_face;
}

_id_3353() {}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7_naval";
}

#using_animtree("script_model");

script_model() {
  level._id_EC85["generic"]["sign_exterior_flag_tallx2_loop_01"][0] = % sign_exterior_flag_tallx2_loop_01;
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
  level._id_EC87["generic_mover"] = #animtree;
  level._id_EC8C["generic_mover"] = "generic_mover";
  level._id_EC85["generic_mover"]["trenchrun_salter"] = % ph_trenchrun_salter;
  level._id_EC85["generic_mover"]["trenchrun_player"] = % ph_trenchrun_player;
  level._id_EC85["generic_mover"]["trenchrun_tigris"] = % ph_trenchrun_tigris;
  level._id_EC85["generic_mover"]["trenchrun_mons"] = % ph_trenchrun_mons;
  level._id_EC85["generic_mover"]["trenchrun_ret"] = % ph_trenchrun_ret;
  level._id_EC85["generic_mover"]["trenchrun_convoy_00"] = % ph_trenchrun_convoy_00;
  level._id_EC85["generic_mover"]["trenchrun_convoy_01"] = % ph_trenchrun_convoy_01;
  level._id_EC85["generic_mover"]["trenchrun_convoy_02"] = % ph_trenchrun_convoy_02;
  level._id_EC85["generic_mover"]["trenchrun_convoy_03"] = % ph_trenchrun_convoy_03;
  level._id_EC85["generic_mover"]["trenchrun_convoy_04"] = % ph_trenchrun_convoy_04;
  level._id_EC85["generic_mover"]["trenchrun_convoy_05"] = % ph_trenchrun_convoy_05;
  level._id_EC85["generic_mover"]["trenchrun_salter_bullet_target"] = % ph_trenchrun_salter_bullet_target;
  level._id_EC85["generic_mover"]["trenchrun_salter_missile_target"] = % ph_trenchrun_salter_missile_target;
  level._id_EC85["generic_mover"]["trenchrun_mons_tower"] = % ph_trenchrun_mons_tower;
  level._id_EC85["generic_mover"]["trenchrun_ram_vfx"] = % ph_trenchrun_ram_vfx;
  level._id_EC87["handcuffs"] = #animtree;
  level._id_EC8C["handcuffs"] = "s1_handcuffs";
  level._id_EC85["handcuffs"]["hvt_handoff"] = % ph_aatis_tower_hvt_handoff_handcuffs;
  level._id_EC85["handcuffs"]["hvt_handoff_idle"][0] = % ph_aatis_tower_hvt_handoff_handcuffs_idle;
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC87["retribution"] = #animtree;
  level._id_EC85["retribution"]["jackal_callin"] = % ph_jackals_landing_retribution;
  level._id_EC85["retribution"]["space_launch_old"] = % ph_jackals_launch_space_ret;
  level._id_EC85["retribution"]["space_launch"] = % ph_jackals_launch_space_ret_dps;
  level._id_EC87["tigris"] = #animtree;
  level._id_EC85["tigris"]["space_launch"] = % ph_jackals_launch_space_un_dest;
  level._id_EC85["tigris"]["space_launch_dps"] = % ph_jackals_launch_space_un_dest;
  level._id_EC87["launch_ca_destroyer_1"] = #animtree;
  level._id_EC85["launch_ca_destroyer_1"]["space_launch"] = % ph_jackals_launch_space_ca_dest;
  level._id_EC85["launch_ca_destroyer_1"]["space_launch_dps"] = % ph_jackals_launch_space_ca_dest;
  level._id_EC87["launch_ca_destroyer_2"] = #animtree;
  level._id_EC85["launch_ca_destroyer_2"]["space_launch"] = % ph_jackals_launch_space_ca_dest_2;
  level._id_EC85["launch_ca_destroyer_2"]["space_launch_dps"] = % ph_jackals_launch_space_ca_dest_2;
  level._id_EC87["launch_ca_destroyer_3"] = #animtree;
  level._id_EC85["launch_ca_destroyer_3"]["space_launch"] = % ph_jackals_launch_space_ca_dest_3;
  level._id_EC85["launch_ca_destroyer_3"]["space_launch_dps"] = % ph_jackals_launch_space_ca_dest_3;
  level._id_EC87["sled_jackal"] = #animtree;

  if(getdvarint("e3", 0)) {
    level._id_EC85["sled_jackal"]["space_launch"] = % ph_jackals_launch_space_plr_jackal_dps;
    level._id_EC85["sled_jackal"]["space_launch_boost"] = % ph_jackals_launch_space_plr_jackal_boost_dps;
  } else {
    level._id_EC85["sled_jackal"]["space_launch"] = % ph_jackals_launch_space_plr_jackal;
    level._id_EC85["sled_jackal"]["space_launch_boost"] = % ph_jackals_launch_space_plr_jackal_boost_dps;
  }
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC87["player_jackal"] = #animtree;
  level._id_EC85["player_jackal"]["jackal_callin"] = % ph_jackals_landing_jackal01;
  scripts\sp\anim::_id_17FF("player_jackal", "ladder_door_sfx", "jackal_callin", "jackal_ladder_panel_open", 1, "j_stepladder_door_left");
  scripts\sp\anim::_id_17FF("player_jackal", "ladder_sfx", "jackal_callin", "jackal_ladder_down", 1, "j_stepladder_door_left");
  level._id_EC85["player_jackal"]["eth3n_mount"] = % ph_jackals_c6i_climb_back_seat_jackal;
  level._id_EC85["player_jackal"]["eth3n_mount_2"] = % ph_tower_jackal_jackal_board;
  level._id_EC85["player_rig"]["ph_player_mount"] = % ph_tower_jackal_plr_board;
  level._id_EC87["salter_jackal"] = #animtree;
  level._id_EC85["salter_jackal"]["jackal_callin"] = % ph_jackals_landing_jackal02;
  level._id_EC85["salter_jackal"]["jackal_callin_idle"][0] = % ph_jackals_landing_jackal02_idle;
  level._id_EC85["salter_jackal"]["space_launch"] = % ph_jackals_launch_space_salter_jackal;
  level._id_EC87["jackal_ally1"] = #animtree;
  level._id_EC85["jackal_ally1"]["space_launch"] = % ph_jackals_launch_space_3rd_jackal;
}

_id_F431(var_0) {
  var_0 thread _id_0C1A::_id_A3B6("hover", 1.0);
  var_0 thread _id_0C20::_id_A3B7("hover");
}