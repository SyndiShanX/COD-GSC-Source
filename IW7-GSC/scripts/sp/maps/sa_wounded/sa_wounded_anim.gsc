/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_wounded\sa_wounded_anim.gsc
**********************************************************/

main() {
  player();
  _id_E5BD();
  _id_13267();
  _id_91DC();
  _id_A056();
  script_model();
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC85["player_rig"]["use_med_console"] = % sa_wounded_medbay_use_console_plr;
  scripts\sp\anim::_id_17FA("player_rig", "notetrack_start_hack_bink", "do_medbay_bink", "use_med_console");
  level._id_EC85["player_rig"]["armory_charge_plant"] = % sa_wounded_armory_charge_plant_plr;
  level._id_EC85["player_rig"]["armory_pickup_chemical"] = % sa_wounded_armory_gas_bomb_plr;
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["generic"]["ph_streets_civi_bump_stumble_left_01"] = % ph_streets_civi_bump_stumble_left_01;
  level._id_EC85["generic"]["hm_grnd_yel_patrol_react_to_combat_8_ar"] = % hm_grnd_yel_patrol_react_to_combat_8_ar;
  level._id_EC85["generic"]["hm_grnd_yel_patrol_react_to_combat_2_ar"] = % hm_grnd_yel_patrol_react_to_combat_2_ar;
  level._id_EC85["generic"]["europa_gunrange_sdf03_react"] = % europa_gunrange_sdf03_react;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_A"][0] = % shipcrib_moon_injured_table_01_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_B"][0] = % shipcrib_moon_injured_table_01_b;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded03"][0] = % shipcrib_moon_wall_wounded03;
  level._id_EC85["generic"]["shipcrib_moon_injured_guyA_idle_01"][0] = % shipcrib_moon_injured_guya_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_J"][0] = % shipcrib_moon_lying_down_j;
  level._id_EC85["generic"]["shipcrib_moon_lying_down_B"][0] = % shipcrib_moon_lying_down_b;
  level._id_EC85["generic"]["sa_wounded_medbay_injured_drag02_guyA"] = % sa_wounded_medbay_injured_drag02_guya;
  level._id_EC85["generic"]["sa_wounded_medbay_injured_drag02_idle_guyA"][0] = % sa_wounded_medbay_injured_drag02_idle_guya;
  level._id_EC85["generic"]["sa_wounded_medbay_injured_drag02_guyB"] = % sa_wounded_medbay_injured_drag02_guyb;
  level._id_EC85["generic"]["sa_wounded_medbay_injured_drag01_guyA"] = % sa_wounded_medbay_injured_drag01_guya;
  level._id_EC85["generic"]["sa_wounded_medbay_injured_drag01_idle_guyA"][0] = % sa_wounded_medbay_injured_drag01_idle_guya;
  level._id_EC85["generic"]["sa_wounded_medbay_injured_drag01_guyB"] = % sa_wounded_medbay_injured_drag01_guyb;
  level._id_EC85["generic"]["hm_grnd_run_lowready_twitch_stumble_forward01_ar"] = % hm_grnd_run_lowready_twitch_stumble_forward01_ar;
  level._id_EC85["generic"]["hm_grnd_run_lowready_twitch_stumble_forward02_ar"] = % hm_grnd_run_lowready_twitch_stumble_forward02_ar;
  level._id_EC85["generic"]["run_pain_fallonknee_02"] = % run_pain_fallonknee_02;
  level._id_EC85["generic"]["run_pain_fallonknee"] = % run_pain_fallonknee;
  level._id_EC85["generic"]["hm_grnd_run_lowready_twitch_stumble_right01_ar"] = % hm_grnd_run_lowready_twitch_stumble_right01_ar;
  level._id_EC85["generic"]["hm_grnd_run_lowready_twitch_stumble_right01_ar"] = % hm_grnd_run_lowready_twitch_stumble_right01_ar;
  level._id_EC85["generic"]["run_react_stumble"] = % run_react_stumble;
  level._id_EC85["generic"]["hm_grnd_yel_patrol_creepwalk_console_twitch_type1"] = % hm_grnd_yel_patrol_creepwalk_console_twitch_type1;
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["armory_charge"] = #animtree;
  level._id_EC8C["armory_charge"] = "weapon_handheld_hacking_device_vm";
  level._id_EC85["armory_charge"]["armory_charge_plant"] = % sa_wounded_armory_charge_plant_charge;
  level._id_EC87["chemical_weapon"] = #animtree;
  level._id_EC8C["chemical_weapon"] = "weapon_gas_bomb_vm";
  level._id_EC85["chemical_weapon"]["armory_pickup_chemical"] = % sa_wounded_armory_gas_bomb_canister;
  level._id_EC87["missile_hatch"] = #animtree;
  level._id_EC8C["missile_hatch"] = "ship_exterior_ca_missile_hatch_a_rig_190p";
  level._id_EC85["missile_hatch"]["sa_moon_deck_missilebaydoors_open"] = % sa_moon_deck_missilebaydoors_open;
  level._id_EC87["chemical_doors"] = #animtree;
  level._id_EC8C["chemical_doors"] = "generic_prop_x3";
  level._id_EC85["chemical_doors"]["armory_pickup_chemical"] = % sa_wounded_armory_gas_bomb_jpropcabinet;
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC87["player_jackal"] = #animtree;
  level._id_EC85["player_jackal"]["outro"] = % sa_wounded_outro_jackal_plr;
}

#using_animtree("c6");

_id_E5BD() {
  level._id_EC87["robot"] = #animtree;
  level._id_EC85["robot"]["robot_burn1"] = % c6_grnd_red_exposed_crouch_poweron_ar;
  level._id_EC85["robot"]["robot_burn2"] = % c6_grnd_red_pain_back_to_stand_ar;
  level._id_EC85["robot"]["robot_burn3"] = % c6_grnd_red_exposed_dismember_fast_crawl_melee01_ar;
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC87["jackal_ally"] = #animtree;
  level._id_EC85["jackal_ally"]["jackal_land_idle"][0] = % jackal_vehicle_landed_state_idle;
  level._id_EC85["jackal_ally"]["outro"] = % sa_wounded_outro_jackal_ally;
}