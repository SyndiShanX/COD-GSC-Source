/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titanjackal\titanjackal_anim.gsc
************************************************************/

main() {
  _id_CF61();
  _id_A056();
  _id_13267();
  _id_EE25();
  _id_775B();
}

#using_animtree("player");

_id_CF61() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7_desert";
  level._id_EC85["player_rig"]["turbine_button_push"] = % titan_turbinelockrelease_plr_pushbutton;
  level._id_EC87["player_rig_torn"] = #animtree;
  level._id_EC8C["player_rig_torn"] = "vm_hero_protagonist_arms_torn";
  level._id_EC85["player_rig_torn"]["titan_ending"] = % titan_ending_plr;
  scripts\sp\anim::_id_17FC("player_rig_torn", "fade_out", "notify_player_fade_out");
}

#using_animtree("generic_human");

_id_775B() {
  level._id_EC87["turbine_eth3n"] = #animtree;
  level._id_EC85["turbine_eth3n"]["mount_turbine_jackal"] = % titan_jackal_c6i_board;
}

#using_animtree("jackal");

_id_A056() {
  level._id_EC85["salter_ship"]["turbine_attack"] = % ph_hill400_jackal_support_jackal;
  level._id_EC87["salter"] = #animtree;
  level._id_EC85["salter"]["ow_ally_arrival"] = % titan_jackal_reveal_salter;
  scripts\sp\anim::_id_17F6("salter", "hover", ::_id_F431);
  level._id_EC87["player_jackal"] = #animtree;
  level._id_EC85["player_jackal"]["ow_ally_arrival"] = % titan_jackal_reveal_vehicle;
  scripts\sp\anim::_id_17F6("player_jackal", "hover", ::_id_F431);
  level._id_EC85["player_jackal"]["ow_ally_arrival_idle"][0] = % titan_jackal_reveal_vehicle_idle;
  level._id_EC85["player_jackal"]["titan_ending"] = % titan_ending_jackal;
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC87["salter_mons_arrival"] = #animtree;
  level._id_EC8C["salter_mons_arrival"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["salter_mons_arrival"]["salter_arrival"] = % titan_bringinjackal_sltjackal_arrival;
  level._id_EC87["plyr_jackal_mons_arrival"] = #animtree;
  level._id_EC8C["plyr_jackal_mons_arrival"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["plyr_jackal_mons_arrival"]["salter_arrival"] = % titan_bringinjackal_plrjackal_arrival;
  level._id_EC87["hot_landing_friendlies"] = #animtree;
  level._id_EC8C["hot_landing_friendlies"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["hot_landing_friendlies"]["intro_1"] = % titan_hot_landing_allyjackals_jkl01_intro;
  level._id_EC85["hot_landing_friendlies"]["intro_2"] = % titan_hot_landing_allyjackals_jkl02_intro;
  level._id_EC85["hot_landing_friendlies"]["intro_3"] = % titan_hot_landing_allyjackals_jkl03_intro;
  level._id_EC85["hot_landing_friendlies"]["intro_4"] = % titan_hot_landing_allyjackals_jkl04_intro;
  level._id_EC85["hot_landing_friendlies"]["idle_1"] = % titan_hot_landing_allyjackals_jkl01_idle;
  level._id_EC85["hot_landing_friendlies"]["idle_2"] = % titan_hot_landing_allyjackals_jkl02_idle;
  level._id_EC85["hot_landing_friendlies"]["idle_3"] = % titan_hot_landing_allyjackals_jkl03_idle;
  level._id_EC85["hot_landing_friendlies"]["idle_4"] = % titan_hot_landing_allyjackals_jkl04_idle;
  level._id_EC85["hot_landing_friendlies"]["exit_1"] = % titan_hot_landing_allyjackals_jkl01_exit;
  level._id_EC85["hot_landing_friendlies"]["exit_2"] = % titan_hot_landing_allyjackals_jkl02_exit;
  level._id_EC85["hot_landing_friendlies"]["exit_3"] = % titan_hot_landing_allyjackals_jkl03_exit;
  level._id_EC85["hot_landing_friendlies"]["exit_4"] = % titan_hot_landing_allyjackals_jkl04_exit;
  level._id_EC87["crash"] = #animtree;
  level._id_EC85["crash"]["hl_jackal_mover"] = % titan_hot_landing_player_jackal_mover;
  scripts\sp\anim::_id_17F6("crash", "jackal_hit_1", scripts\sp\maps\titan\titan_hot_landing::_id_D0DC, "hl_jackal_mover");
  scripts\sp\anim::_id_17F6("crash", "jackal_hit_2", scripts\sp\maps\titan\titan_hot_landing::_id_D0DD, "hl_jackal_mover");
  scripts\sp\anim::_id_17F6("crash", "skid_hit", scripts\sp\maps\titan\titan_hot_landing::_id_1023C, "hl_jackal_mover");
  scripts\sp\anim::_id_17F6("crash", "end_left_hand", scripts\sp\maps\titan\titan_hot_landing::_id_62DE, "hl_jackal_mover");
  level._id_EC85["crash"]["hl_sled"] = % titan_hot_landing_player_jackal_skid;
  level._id_EC85["crash"]["hl_sled_enter"] = % titan_hot_landing_player_jackal_skid_enter;
  level._id_EC85["crash"]["hl_sled_idle"][0] = % titan_hot_landing_player_jackal_skid_idle;
  level._id_EC87["mons_intro_jackal"] = #animtree;
  level._id_EC8C["mons_intro_jackal"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["mons_intro_jackal"]["door_crash"] = % titan_bunker_bombardment_jackal_getin;
  level._id_EC87["salter_ship_stub"] = #animtree;
  level._id_EC8C["salter_ship_stub"] = "veh_mil_air_un_jackal_02";
  level._id_EC85["salter_ship_stub"]["turbine_attack"] = % titan_turbinelockrelease_salter_jackal;
  level._id_EC87["retribution"] = #animtree;
  level._id_EC85["retribution"]["titan_ending"] = % titan_ending_ret;
  scripts\sp\anim::_id_17F6("retribution", "begin_ftl_jump", ::_id_1196D, "titan_ending");
  level._id_EC87["mons"] = #animtree;
  level._id_EC85["mons"]["titan_ending_intro"] = % titan_ending_mons_intro;
  level._id_EC85["mons"]["titan_ending"] = % titan_ending_mons;
  scripts\sp\anim::_id_17F6("mons", "begin_ftl_jump", ::_id_11969, "titan_ending");
}

#using_animtree("script_model");

_id_EE25() {
  level._id_EC87["turbine_flaps"] = #animtree;
  level._id_EC8C["turbine_flaps"] = "vfx_destr_titan_turbine_door_before";
  level._id_EC85["turbine_flaps"]["open"] = % vfx_destr_titan_turbine_door_before;
  level._id_EC87["turbine_console"] = #animtree;
  level._id_EC8C["turbine_console"] = "sdf_console_control_panel_08_rig";
  level._id_EC85["turbine_console"]["turbine_button_push"] = % titan_turbinelockrelease_console;
  level._id_EC87["retribution"] = #animtree;
  level._id_EC85["retribution"]["ow_arrival"] = % titan_exit_the_bunker_retribution;
  level._id_EC87["refinery_destroy_bridge"] = #animtree;
  level._id_EC8C["refinery_destroy_bridge"] = "veh_mil_air_un_dropship_seat";
  level._id_EC85["refinery_destroy_bridge"]["refinery_bridge_destruction"] = % titan_catwalk_crash_bridge_1;
  level._id_EC87["ending_player_jackal"] = #animtree;
  level._id_EC8C["ending_player_jackal"] = "veh_mil_air_un_jackal_01_cockpit_glass_dmg_02";
  level._id_EC85["ending_player_jackal"]["titan_ending"] = % titan_ending_jackal;
  level._id_EC85["ending_player_jackal"]["titan_ending_crash"] = % titan_ending_jackal_crash;
  scripts\sp\anim::_id_17F6("ending_player_jackal", "swap_jackal_model", ::_id_11974, "titan_ending");
  scripts\sp\anim::_id_17F6("ending_player_jackal", "swap_jackal_canopy", ::_id_11972, "titan_ending");
  scripts\sp\anim::_id_17F6("ending_player_jackal", "jackal_canopy_open", ::_id_1196B, "titan_ending");
  scripts\sp\anim::_id_17F6("ending_player_jackal", "jackal_crash", ::_id_1196C, "titan_ending");
  level._id_EC87["ending_eth3n"] = #animtree;
  level._id_EC8C["ending_eth3n"] = "fullbody_hero_eth3n";
  level._id_EC85["ending_eth3n"]["titan_ending"] = % titan_ending_eth3n;
  level._id_EC87["moving_origin"] = #animtree;
  level._id_EC8C["moving_origin"] = "tag_origin_animate";
  level._id_EC85["moving_origin"]["titan_ending"] = % titan_ending_moving_node;
  level._id_EC87["debris"] = #animtree;
  level._id_EC8C["debris"] = "debris_gravity_module_01_part_00";
  level._id_EC85["debris"]["titan_ending"] = % titan_ending_debris;
}

_id_F431(var_0) {
  var_0 thread _id_0C1A::_id_A3B6("hover", 1.0);
  var_0 thread _id_0C20::_id_A3B7("hover");
}

_id_6FFC(var_0) {
  wait 1;
  var_1 = 1000;
  var_2 = 2.6;
  screenshake(self.origin, var_2 * 0.5, var_2, var_2 * 0.5, 0.5, 0, -1, var_1, 5, 0.2, 2);
}

_id_11972(var_0) {
  level._id_6346 thread scripts\sp\maps\titan\titan_hot_landing::_id_11966(1);
  level._id_6346 setModel("veh_mil_air_un_jackal_01_cockpit_glass_dmg_03");
}

_id_11974(var_0) {
  level.player scripts\engine\utility::delaycall(0.3, ::playsound, "scn_titan_jackal_collision_engine");
  level._id_633E setModel("veh_mil_air_un_jackal_02");
  level._id_633E show();
  level._id_6346 hide();
  thread scripts\sp\hud::_id_8DF9("suit");
  setomnvar("ui_helmet_meter_forceVisible", 1);
  wait 5;
  setomnvar("ui_helmet_meter_forceVisible", 1);
  thread scripts\sp\hud::_id_8DFD(randomfloatrange(75, 85), 3, 0);
  wait 10;
  thread scripts\sp\hud::_id_8DFD(randomfloatrange(55, 65), 3, 0);
  wait 10;
  thread scripts\sp\hud::_id_8DFD(randomfloatrange(35, 45), 3, 0);
  wait 10;
  thread scripts\sp\hud::_id_8DFD(randomfloatrange(15, 25), 3, 0);
  wait 10;
  thread scripts\sp\hud::_id_8DFD(10, 3, 0);
  wait 10;
  thread scripts\sp\hud::_id_8DFD(0, 3, 0);
}

_id_1196B(var_0) {
  level.player notify("canopy_off");
  thread scripts\sp\maps\titan\titan_hot_landing::_id_FB84();
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(level.player._id_1E9C, "J_Elbow_LE", (0, 0, 0), (0, 0, 90));
  playFXOnTag(scripts\engine\utility::getfx("vfx_hms_air_release_small"), var_1, "tag_origin");
}

_id_1196C(var_0) {
  level.player notify("plr_jackal_crash");
  thread scripts\engine\utility::play_sound_in_space("scn_titan_jackal_collision_expl", level._id_6346.origin);
  playFXOnTag(scripts\engine\utility::getfx("zerog_exp_1"), level._id_6346, "tag_origin");
  earthquake(1, 1, level._id_6346.origin, 5000);
  wait 1.5;
  level._id_633E hide();
  level._id_6348 _id_0B51::_id_C5FC(1);
}

_id_1196D(var_0) {
  level._id_6348 thread _id_FBF9();
  level._id_6348 _meth_83A1();
  level._id_6348 thread _id_0BB8::_id_3991(1);
  wait 3;
  level._id_6348 _id_0B51::stop_func();
  level._id_6348 waittill("ftl_complete");
  level._id_6348 _id_0B51::_id_5155();
}

_id_11969(var_0) {
  level._id_BA43 thread _id_FBC4();
  wait 1.75;
  level._id_BA43 _meth_83A1();
  level._id_BA43 thread _id_0BB8::_id_3991(1);
  level._id_BA43 waittill("ftl_complete");
  level._id_BA43 _id_0BB6::_id_39C0();
  level._id_BA43 _id_0BA9::_id_397B();
}

_id_FBF9() {
  thread scripts\engine\utility::play_sound_in_space("scn_titan_ret_ftl_buildup", self.origin);
  scripts\engine\utility::delaythread(3.0, scripts\engine\utility::play_sound_in_space, "scn_titan_ret_ftl_out", self.origin);
}

_id_FBC4() {
  wait 1.25;
  thread scripts\engine\utility::play_sound_in_space("scn_titan_mons_ftl_buildup", self.origin);
  wait 0.5;
  scripts\engine\utility::delaythread(2.9, scripts\engine\utility::play_sound_in_space, "scn_titan_mons_ftl_out", self.origin);
  level.player notify("mons_ftl");
}

_id_11962(var_0) {
  var_1 = 5;
  var_2 = scripts\sp\hud_util::_id_48B7("black", 0, level.player);
  var_2 fadeovertime(var_1);
  var_2.alpha = 1;
}