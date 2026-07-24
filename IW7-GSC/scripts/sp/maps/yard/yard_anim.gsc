/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\yard\yard_anim.gsc
**********************************************/

main() {
  _id_91DC();
  _id_3353();
  _id_341D();
  _id_3508();
  player();
  _id_13267();
  _id_A056();
  script_model();
}

#using_animtree("generic_human");

_id_91DC() {
  level._id_EC85["brooks"]["elevator_scene"] = % mars_10_22_elev_mr1_scene;
  level._id_EC85["salter"]["elevator_scene"] = % mars_10_22_elev_xo_scene;
  level._id_EC85["ethan"]["elevator_scene"] = % mars_10_22_elev_c6i_scene;
  level._id_EC85["mccallum"]["elevator_scene"] = % mars_10_22_elev_eng_scene;
  level._id_EC85["brooks"]["elevator_end_idle"][0] = % mars_10_22_elev_mr1_scene_end_idle;
  level._id_EC85["ethan"]["elevator_end_idle"][0] = % mars_10_22_elev_c6i_scene_end_idle;
  level._id_EC85["generic"]["elevator_end_idle"][0] = % mars_10_22_elev_ally01_scene_end_idle;
  level._id_EC85["generic"]["elevator_npc01_idle_male"][0] = % mars_elevator_dropseat_idle_male;
  level._id_EC85["generic"]["elevator_npc01_idle_female"][0] = % mars_elevator_dropseat_idle_female;
  level._id_EC85["salter"]["airlock_idle"][0] = % mars_10_22_elev_xo_airlock_idle;
  level._id_EC85["salter"]["airlock_nag"] = % mars_10_22_elev_xo_airlock_nag;
  level._id_EC85["salter"]["airlock_door_close"] = % mars_10_22_elev_xo_airlock_close;
  level._id_EC85["salter"]["generic_airlock_door_close"] = % airlock_close_in_2_ai;
  level._id_EC85["generic"]["titan_stealth_street_enemy01_convo_idle"][0] = % titan_stealth_street_enemy01_convo_idle;
  level._id_EC85["generic"]["titan_stealth_street_enemy02_convo_idle"][0] = % titan_stealth_street_enemy02_convo_idle;
  level._id_EC85["generic"]["patrol_bored_idle"][0] = % patrol_bored_idle;
  level._id_EC85["generic"]["pod_chamber_sdf01_loop"][0] = % yard_pod_chamber_sdf01_loop;
  level._id_EC85["generic"]["pod_chamber_sdf01_react"] = % yard_pod_chamber_sdf01_react;
  level._id_EC85["generic"]["pod_chamber_sdf02_loop"][0] = % yard_pod_chamber_sdf02_loop;
  scripts\sp\anim::_id_17F6("generic", "weld_on", scripts\sp\maps\yard\yard_fx::_id_13366, "pod_chamber_sdf02_loop");
  scripts\sp\anim::_id_17F6("generic", "weld_off", scripts\sp\maps\yard\yard_fx::_id_13365, "pod_chamber_sdf02_loop");
  level._id_EC85["generic"]["pod_chamber_sdf02_react"] = % yard_pod_chamber_sdf02_react;
  level._id_EC85["generic"]["pod_chamber_sdf03_loop"][0] = % yard_pod_chamber_sdf03_loop;
  level._id_EC85["generic"]["pod_chamber_sdf03_react"] = % yard_pod_chamber_sdf03_react;
  level._id_EC85["generic"]["pod_chamber_sdf04_loop"][0] = % yard_pod_chamber_sdf04_loop;
  level._id_EC85["generic"]["pod_chamber_sdf04_react"] = % yard_pod_chamber_sdf04_react;
  level._id_EC85["generic"]["pod_chamber_sdf05_start"] = % yard_pod_chamber_sdf05_start;
  level._id_EC85["generic"]["pod_chamber_sdf05_loop"][0] = % yard_pod_chamber_sdf05_loop;
  level._id_EC85["generic"]["pod_chamber_sdf05_react"] = % yard_pod_chamber_sdf05_react;
  level._id_EC85["salter"]["md_airlock_to_catwalk"] = % mars_mac_death_a_airlock_to_catwalk_xo;
  level._id_EC85["salter"]["md_catwalk"] = % mars_mac_death_a_catwalk_xo;
  level._id_EC85["salter"]["md_catwalk_to_console"] = % mars_mac_death_a_catwalk_to_console_xo;
  scripts\sp\anim::_id_17FD("salter", "yard_plr_justkeepusmovingsal", "md_catwalk_to_console", "yard_plr_justkeepusmovingsalt");
  level._id_EC85["mccallum"]["md_airlock_to_catwalk"] = % mars_mac_death_a_airlock_to_catwalk_mco;
  level._id_EC85["mccallum"]["md_catwalk"] = % mars_mac_death_a_catwalk_mco;
  level._id_EC85["mccallum"]["md_catwalk_to_console"] = % mars_mac_death_a_catwalk_to_console_mco;
  level._id_EC85["salter"]["md_catwalk_enter_to_idle"] = % mars_mac_death_a_airlock_to_catwalk_wait_enter_xo;
  level._id_EC85["salter"]["md_catwalk_idle"][0] = % mars_mac_death_a_airlock_to_catwalk_wait_loop_xo;
  level._id_EC85["salter"]["md_catwalk_idle_to_exit"] = % mars_mac_death_a_airlock_to_catwalk_wait_exit_xo;
  level._id_EC85["mccallum"]["md_catwalk_enter_to_idle"] = % mars_mac_death_a_airlock_to_catwalk_wait_enter_mco;
  level._id_EC85["mccallum"]["md_catwalk_idle"][0] = % mars_mac_death_a_airlock_to_catwalk_wait_loop_mco;
  level._id_EC85["mccallum"]["md_catwalk_idle_to_exit"] = % mars_mac_death_a_airlock_to_catwalk_wait_exit_mco;
  level._id_EC85["salter"]["mac_death_scene_b"][0] = % mars_mac_death_b_console_loop_xo;
  level._id_EC85["salter"]["mac_death_scene_c"] = % mars_mac_death_c_plant_charge_xo;
  level._id_EC85["salter"]["mac_death_scene_d"] = % mars_mac_death_d_hold_door_loop_xo;
  level._id_EC85["salter"]["mac_death_scene_e"] = % mars_mac_death_e_exit_xo;
  scripts\sp\anim::_id_17FD("salter", "yard_plr_shedidthatsowed", "mac_death_scene_e", "yard_plr_shedidthatsowed");
  scripts\sp\anim::_id_17FD("salter", "yard_plr_stopthatambush", "mac_death_scene_e", "yard_plr_stopthatambush");
  scripts\sp\anim::_id_17FD("salter", "yard_plr_saltmacundersto", "mac_death_scene_e", "yard_plr_saltmacundersto");
  scripts\sp\anim::_id_17FD("salter", "yard_plr_theothersaresti", "mac_death_scene_e", "yard_plr_theothersaresti");
  scripts\sp\anim::_id_17FD("salter", "yard_plr_gogetem", "mac_death_scene_e", "yard_plr_gogetem");
  scripts\sp\anim::_id_17FC("salter", "punch", "kiosk_swap", "mac_death_scene_e");
  level._id_EC85["mccallum"]["mac_death_scene_b"][0] = % mars_mac_death_b_console_loop_mco;
  level._id_EC85["mccallum"]["mac_death_scene_c"] = % mars_mac_death_c_plant_charge_mco;
  scripts\sp\anim::_id_17F6("mccallum", "attach_knife", scripts\sp\maps\yard\yard_elevator::_id_B13C, "mac_death_scene_c");
  level._id_EC85["mccallum"]["mac_death_scene_d"] = % mars_mac_death_d_hold_door_loop_mco;
  level._id_EC85["mccallum"]["mac_death_scene_e"] = % mars_mac_death_e_exit_mco;
  level._id_EC85["salter"]["airlock_to_ambush_idle"][0] = % mars_mac_death_f_exit_airlock_idle_xo;
  level._id_EC85["salter"]["airlock_to_ambush_close"] = % mars_mac_death_f_exit_airlock_close_xo;
  level._id_EC85["salter"]["salt_ambush_cover_enter"] = % mars_elevator_ambush_cover_enter_xo;
  level._id_EC85["salter"]["salt_ambush_cqb_enter"] = % mars_elevator_ambush_cqb_enter_xo;
  level._id_EC85["generic"]["console_enter"] = % hm_grnd_yel_standingconsole_enter;
  level._id_EC85["generic"]["console_loop"][0] = % hm_grnd_yel_standingconsole_loop;
  level._id_EC85["generic"]["console_exit"] = % hm_grnd_yel_standingconsole_exit;
  level._id_EC85["salter"]["salt_ambush_entry"] = % yard_elevator_ambush_salter;
  level._id_EC85["salter"]["tram_scene"] = % mars_10_28b_pod_xo_goodbye;
  level._id_EC85["brooks"]["tram_scene"] = % mars_10_28b_pod_mr1_goodbye;
  level._id_EC85["gator"]["tram_scene"] = % mars_10_28b_pod_ally06_goodbye;
  level._id_EC85["ally1"]["tram_scene"] = % mars_10_28b_pod_ally01_goodbye;
  level._id_EC85["ally2"]["tram_scene"] = % mars_10_28b_pod_ally02_goodbye;
  level._id_EC85["ally3"]["tram_scene"] = % mars_10_28b_pod_ally03_goodbye;
  level._id_EC85["ally4"]["tram_scene"] = % mars_10_28b_pod_ally04_goodbye;
  level._id_EC85["ally5"]["tram_scene"] = % mars_10_28b_pod_ally05_goodbye;
  level._id_EC85["ally6"]["tram_scene"] = % mars_10_28b_pod_ally07_goodbye;
  level._id_EC85["ally7"]["tram_scene"] = % mars_10_28b_pod_ally08_goodbye;
  level._id_EC85["enemy"]["server_hit"] = % mars_yard_server_corridor_sdf01_knockdown;
  level._id_EC85["spaced_guy_01"]["spaced_scene"] = % yard_spaced_airlock_sdf01;
  level._id_EC85["spaced_guy_02"]["spaced_scene"] = % yard_spaced_airlock_sdf02;
  level._id_EC85["spaced_guy_03"]["spaced_scene"] = % yard_spaced_airlock_sdf03;
  level._id_EC85["generic"]["idle_console"][0] = % shipcrib_standing_console_idle_17;
  level._id_EC85["generic"]["hm_zg_org_grav_grenade_loop01_ar"][0] = % hm_zg_org_grav_grenade_loop01_ar;
  level._id_EC85["generic"]["hm_zg_org_grav_grenade_loop02_ar"][0] = % hm_zg_org_grav_grenade_loop02_ar;
  level._id_EC85["generic"]["hm_zg_org_grav_grenade_loop03_ar"][0] = % hm_zg_org_grav_grenade_loop03_ar;
  level._id_EC85["sdf_1"]["destroy_core"] = % mars_yard_power_relay_sdf01_electrocuted;
  level._id_EC85["sdf_2"]["destroy_core"] = % mars_yard_power_relay_sdf02_electrocuted;
  level._id_EC85["generic"]["hm_grnd_yel_flashlightsearch_left"] = % hm_grnd_yel_flashlightsearch_left;
  level._id_EC85["generic"]["hm_grnd_yel_flashlightsearch_right"] = % hm_grnd_yel_flashlightsearch_right;
  level._id_EC85["generic"]["hm_grnd_yel_patrol_creepwalk_flashlightsearch_left"] = % hm_grnd_yel_patrol_creepwalk_flashlightsearch_left;
  level._id_EC85["generic"]["hm_grnd_yel_patrol_creepwalk_flashlightsearch_right"] = % hm_grnd_yel_patrol_creepwalk_flashlightsearch_right;
  level._id_EC85["generic"]["guy_1"][0] = % yard_pod_chamber_sdf01_loop;
  level._id_EC85["generic"]["guy_2"][0] = % yard_pod_chamber_sdf02_loop;
  level._id_EC85["generic"]["guy_3"][0] = % yard_pod_chamber_sdf03_loop;
  level._id_EC85["generic"]["guy_4"][0] = % yard_pod_chamber_sdf04_loop;
  level._id_EC85["generic"]["guy_5"][0] = % yard_pod_chamber_sdf05_loop;
  level._id_EC85["generic"]["guy_6"][0] = % casual_stand_idle;
  scripts\sp\anim::_id_17F6("generic", "flashlight_on", ::_id_E9A9, "hm_grnd_yel_flashlightsearch_left");
  scripts\sp\anim::_id_17F6("generic", "flashlight_off", ::_id_E9A8, "hm_grnd_yel_flashlightsearch_left");
  scripts\sp\anim::_id_17F6("generic", "flashlight_on", ::_id_E9A9, "hm_grnd_yel_flashlightsearch_right");
  scripts\sp\anim::_id_17F6("generic", "flashlight_off", ::_id_E9A8, "hm_grnd_yel_flashlightsearch_right");
  scripts\sp\anim::_id_17F6("generic", "flashlight_on", ::_id_E9A9, "hm_grnd_yel_patrol_creepwalk_flashlightsearch_left");
  scripts\sp\anim::_id_17F6("generic", "flashlight_off", ::_id_E9A8, "hm_grnd_yel_patrol_creepwalk_flashlightsearch_left");
  scripts\sp\anim::_id_17F6("generic", "flashlight_on", ::_id_E9A9, "hm_grnd_yel_patrol_creepwalk_flashlightsearch_right");
  scripts\sp\anim::_id_17F6("generic", "flashlight_off", ::_id_E9A8, "hm_grnd_yel_patrol_creepwalk_flashlightsearch_right");
}

_id_E9A9(var_0) {
  if(!isDefined(level._id_E9AA)) {
    level._id_E9AA = var_0 scripts\engine\utility::spawn_tag_origin();
    level._id_E9AA linkTo(var_0, "tag_flash", (0, 0, 0), (0, 0, 0));
    playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), level._id_E9AA, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), level._id_E9AA, "tag_origin");
    wait 0.25;
    var_0 thread _id_E9A7();
  }
}

_id_E9A8(var_0) {
  if(isDefined(level._id_E9AA)) {
    var_0 notify("stop_sa_flashlight_monitor");
    killfxontag(scripts\engine\utility::getfx("sa_flashlight"), level._id_E9AA, "tag_origin");
    killfxontag(scripts\engine\utility::getfx("sa_flashlight_flare"), level._id_E9AA, "tag_origin");
    wait 0.05;

    if(isDefined(level._id_E9AA)) {
      level._id_E9AA delete();
      level._id_E9AA = undefined;
    }
  }
}

_id_E9A7() {
  self endon("stop_sa_flashlight_monitor");
  scripts\engine\utility::waittill_either("stealth_alertlevel_change", "death");

  if(isDefined(level._id_E9AA)) {
    killfxontag(scripts\engine\utility::getfx("sa_flashlight"), level._id_E9AA, "tag_origin");
    killfxontag(scripts\engine\utility::getfx("sa_flashlight_flare"), level._id_E9AA, "tag_origin");
    wait 0.05;

    if(isDefined(level._id_E9AA)) {
      level._id_E9AA delete();
      level._id_E9AA = undefined;
    }
  }
}

#using_animtree("c6");

_id_3353() {
  level._id_EC85["c6"]["mac_death_scene_c"] = % mars_mac_death_c_plant_charge_c6;
  level._id_EC85["c6_1"]["mac_death_scene_c"][0] = % mars_mac_death_c_plant_charge_c6_1;
  level._id_EC85["c6_2"]["mac_death_scene_c"][0] = % mars_mac_death_c_plant_charge_c6_2;
  level._id_EC85["c6"]["mac_death_scene_d"] = % mars_mac_death_d_hold_door_loop_c6;
  level._id_EC85["c6"]["mac_death_scene_e"] = % mars_mac_death_e_exit_c6;
  level._id_EC85["generic"]["ambush_stand_enter"] = % mars_elevator_ambush_stand_enter_c6;
  level._id_EC85["generic"]["ambush_crouch_enter"] = % mars_elevator_ambush_crouch_enter_c6;
  level._id_EC85["generic"]["c6_idle_console"][0] = % shipcrib_standing_console_idle_02;
  level._id_EC85["generic"]["table_flip"] = % ph_streets_c6_flipping_car_c61;
}

#using_animtree("c8");

_id_341D() {
  level._id_EC87["c8"] = #animtree;
  level._id_EC85["c8"]["c8_shield_bash"] = % c8_grnd_org_exposed_shield_plant_lower;
}

#using_animtree("c12");

_id_3508() {
  level._id_EC87["c12"] = #animtree;
  level._id_EC85["c12"]["spaced_scene"] = % yard_spaced_airlock_c12;
}

#using_animtree("player");

player() {
  level._id_EC87["player_rig"] = #animtree;
  level._id_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
  level._id_EC87["ethan_rig"] = #animtree;
  level._id_EC8C["ethan_rig"] = "vm_eth3n_arms";
  level._id_EC87["ethan_legs"] = #animtree;
  level._id_EC8C["ethan_legs"] = "fullbody_hero_eth3n_vm_legs";
  level._id_EC85["player_rig"]["airlock_console_interact"] = % yard_airlock_console_use_plr;
  level._id_EC85["player_rig"]["mac_death_scene_c"] = % mars_mac_death_c_plant_charge_plr;
  level._id_EC85["player_rig"]["mac_death_scene_d"] = % mars_mac_death_d_hold_door_loop_plr;
  level._id_EC85["player_rig"]["mac_death_scene_e"] = % mars_mac_death_e_exit_plr;
  scripts\sp\anim::_id_17FC("player_rig", "pod_detonate", "clear_mac_death_dof", "mac_death_scene_e");
  level._id_EC85["player_rig"]["bridge_lever_pull"] = % mars_yard_elevator_plr_lever_pulldown;
  level._id_EC85["player_rig"]["elevator_player_idle"] = % mars_10_22_elev_plr_dropseat_idle;
  scripts\sp\anim::_id_17FA("player_rig", "elevator_stop", "stop_elevator", "elevator_player_idle");
  level._id_EC85["player_rig"]["elevator_player_exit"] = % mars_10_22_elev_plr_dropseat_exit;
  level._id_EC85["player_rig"]["airlock_open_start"] = % airlock_open_player_start;
  level._id_EC85["player_rig"]["airlock_open_end"][0] = % airlock_open_player_end;
  level._id_EC85["player_rig"]["spaced_scene"] = % yard_spaced_airlock_plr;
  level._id_EC85["player_rig"]["hack_command"] = % yard_command_central_console_plr;
  level._id_EC85["player_rig"]["hack_iff"] = % mars_yard_control_room_plr_button_press;
  level._id_EC85["player_rig"]["hack_idle"][0] = % mars_yard_control_room_plr_idle;
  level._id_EC85["player_rig"]["explo_chain"] = % mars_yard_control_room_plr_explosion_chain;
  level._id_EC85["player_rig"]["target_designated"] = % mars_yard_control_room_plr_target_designation;
  level._id_EC85["player_rig"]["player_spaced"] = % mars_yard_control_room_plr_sucked_out;
  level._id_EC85["ethan_rig"]["ethan_hack"] = % yard_hack_ethan_plr;
  level._id_EC85["ethan_rig"]["destroy_core"] = % mars_yard_power_relay_plr_pull_fuses;
  level._id_EC85["ethan_rig"]["hatch_pull"] = % yard_power_relay_ethan_grate_rip;
  level._id_EC85["ethan_rig"]["hatch_fall"] = % yard_power_relay_ethan_drop_land;
  level._id_EC85["ethan_rig"]["panel_start_01"] = % yard_power_relay_ethan_panel_rip_start01;
  level._id_EC85["ethan_rig"]["panel_idle_01"][0] = % yard_power_relay_ethan_panel_rip_idle01;
  level._id_EC85["ethan_rig"]["panel_start_02"] = % yard_power_relay_ethan_panel_rip_start02;
  level._id_EC85["ethan_rig"]["panel_idle_02"][0] = % yard_power_relay_ethan_panel_rip_idle02;
  level._id_EC85["ethan_rig"]["panel_end"] = % yard_power_relay_ethan_panel_rip_end;
  scripts\sp\anim::_id_17F6("ethan_rig", "impact", scripts\sp\maps\yard\yard_central::_id_6781, "panel_end");
  level._id_EC85["ethan_legs"]["hatch_fall"] = % yard_power_relay_ethanfoot_drop_land;
  level._id_EC85["player_rig"]["escape_landing"] = % yard_control_center_outro_plr;
  level._id_EC85["player_rig"]["escape_suck_out"] = % yard_control_center_extraction_plr;
  level._id_EC85["player_rig"]["escape_explosion_chain"] = % mars_yard_control_room_plr_explosion_chain;
  level._id_EC85["player_rig"]["escape_idle"][0] = % mars_yard_control_room_plr_idle;
  level._id_EC85["player_rig"]["escape_target_des"] = % mars_yard_control_room_plr_target_designation;
  level._id_EC85["player_rig"]["hack_terminal"] = % vm_gauntlet_hack_control_end;
  scripts\sp\anim::_id_17FC("ethan_rig", "beam", "core_zap", "destroy_core");
  level._id_EC85["player_rig"]["escape_button_press"] = % yard_control_center_intro_plr_new;
  scripts\sp\anim::_id_17FC("player_rig", "start_xo_turn", "end_scene_salter", "escape_button_press");
  scripts\sp\anim::_id_17FC("player_rig", "start_salter_pip", "ending_salter_pip", "escape_button_press");
  level._id_EC85["player_rig"]["end_scene"] = % yard_control_center_extraction_new_plr;
  scripts\sp\anim::_id_17FC("player_rig", "hit_debris_1", "hit_debris_1", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "hit_debris_2", "hit_debris_2", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "hit_ship_1", "hit_ship_1", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "grab_ship", "player_grab_ship", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "capital_ship_explode_1", "capital_ship_explode_1", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "capital_ship_explode_2", "capital_ship_explode_2", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "ring_explode_1", "ring_l_1_explode", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "ring_explode_2", "ring_l_2_explode", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "ring_explode_3", "ring_l_3_explode", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "crack_spread_1", "crack_glass_1", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "crack_spread_2", "crack_glass_2", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "crack_spread_3", "crack_glass_3", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "crack_spread_4", "crack_glass_4", "end_scene");
  scripts\sp\anim::_id_17FC("player_rig", "glass_shatter", "ending_glass_shatter", "end_scene");
}

#using_animtree("script_model");

script_model() {
  level._id_EC87["elevator_seat"] = #animtree;
  level._id_EC85["elevator_seat"]["seat_player_idle"] = % mars_10_22_elev_dropseat_idle_for_plr;
  level._id_EC85["elevator_seat"]["seat_player_get_out"] = % mars_10_22_elev_dropseat_exit_for_plr;
  level._id_EC85["elevator_seat"]["seat_brooks"] = % mars_10_22_elev_dropseat_scene_for_mr1;
  level._id_EC85["elevator_seat"]["seat_salter"] = % mars_10_22_elev_dropseat_scene_for_xo;
  level._id_EC85["elevator_seat"]["seat_ethan"] = % mars_10_22_elev_dropseat_scene_for_c6i;
  level._id_EC85["elevator_seat"]["seat_mccallum"] = % mars_10_22_elev_dropseat_scene_for_eng;
  level._id_EC85["elevator_seat"]["elevator_npc01_idle"][0] = % mars_elevator_enter_ally01_seat02_idle;
  level._id_EC87["elevator_mount"] = #animtree;
  level._id_EC85["elevator_mount"]["mount_player_get_out"] = % mars_10_22_elev_mount_exit_for_plr;
  level._id_EC85["elevator_mount"]["mount_brooks"] = % mars_10_22_elev_mount_scene_for_mr1;
  level._id_EC85["elevator_mount"]["mount_salter"] = % mars_10_22_elev_mount_scene_for_xo;
  level._id_EC85["elevator_mount"]["mount_ethan"] = % mars_10_22_elev_mount_scene_for_c6i;
  level._id_EC85["elevator_mount"]["mount_mccallum"] = % mars_10_22_elev_mount_scene_for_eng;
  level._id_EC87["door"] = #animtree;
  level._id_EC85["door"]["generic_airlock_door_close"] = % airlock_close_in_2_door;
  level._id_EC85["door"]["airlock_to_ambush_close"] = % mars_mac_death_f_exit_to_airlock_door;
  level._id_EC85["door"]["airlock_open_start"] = % airlock_open_door_start;
  level._id_EC85["door"]["airlock_open_end"][0] = % airlock_open_door_end;
  level._id_EC87["pod_base"] = #animtree;
  level._id_EC85["pod_base"]["mac_death_pod_arrival"] = % mars_mac_death_a_catwalk_to_console_pod_base;
  level._id_EC85["pod_base"]["mac_death_scene_c"] = % mars_mac_death_c_plant_charge_pod_base;
  scripts\sp\anim::_id_17F6("pod_base", "pod_door_opening", scripts\sp\maps\yard\yard_lighting::_id_B131, "mac_death_scene_c");
  level._id_EC85["pod_base"]["mac_death_scene_d"] = % mars_mac_death_d_hold_door_loop_pod_base;
  level._id_EC85["pod_base"]["mac_death_scene_e"] = % mars_mac_death_e_exit_pod_base;
  scripts\sp\anim::_id_17F6("pod_base", "pod_door_closed", scripts\sp\maps\yard\yard_lighting::_id_B130, "mac_death_scene_c");
  level._id_EC8C["pod_arm"] = "veh_mil_air_ca_drop_pod_arm";
  level._id_EC87["pod_arm"] = #animtree;
  level._id_EC85["pod_arm"]["mac_death_scene_c"] = % mars_mac_death_c_plant_charge_pod_arm;
  level._id_EC8C["mac_charge"] = "weapon_handheld_hacking_device_vm";
  level._id_EC87["mac_charge"] = #animtree;
  level._id_EC85["mac_charge"]["mac_death_scene_c"] = % mars_mac_death_c_plant_charge_device;
  level._id_EC85["mac_charge"]["mac_death_scene_d"] = % mars_mac_death_d_hold_door_loop_device;
  level._id_EC85["mac_charge"]["mac_death_scene_e"] = % mars_mac_death_e_exit_device;
  level._id_EC87["mac_knife"] = #animtree;
  level._id_EC8C["mac_knife"] = "generic_prop_x3";
  level._id_EC85["mac_knife"]["mac_death_scene_c"] = % mars_mac_death_c_plant_charge_knife;
  level._id_EC85["mac_knife"]["mac_death_scene_d"] = % mars_mac_death_d_hold_door_loop_knife;
  level._id_EC85["mac_knife"]["mac_death_scene_e"] = % mars_mac_death_e_exit_knife;
  level._id_EC8C["mac_kiosk"] = "equipment_sdf_kiosk_01_red";
  level._id_EC87["mac_kiosk"] = #animtree;
  level._id_EC85["mac_kiosk"]["mac_death_scene_e"] = % mars_mac_death_e_exit_kiosk;
  level._id_EC87["bridge_lever"] = #animtree;
  level._id_EC85["bridge_lever"]["bridge_lever_pull"] = % mars_yard_elevator_lever_pulldown;
  level._id_EC87["server"] = #animtree;
  level._id_EC8C["server"] = "tag_origin";
  level._id_EC85["server"]["server_hit"] = % mars_yard_server_corridor_server_open;
  level._id_EC87["fuse_1"] = #animtree;
  level._id_EC87["fuse_2"] = #animtree;
  level._id_EC87["fuse_3"] = #animtree;
  level._id_EC8C["fuse_1"] = "equipment_oxygen_tank_01";
  level._id_EC8C["fuse_2"] = "equipment_oxygen_tank_01";
  level._id_EC8C["fuse_3"] = "equipment_oxygen_tank_01";
  level._id_EC85["fuse_1"]["destroy_core"] = % mars_yard_power_relay_fuse01_pulled;
  level._id_EC85["fuse_2"]["destroy_core"] = % mars_yard_power_relay_fuse02_pulled;
  level._id_EC85["fuse_3"]["destroy_core"] = % mars_yard_power_relay_fuse03_pulled;
  level._id_EC87["table"] = #animtree;
  level._id_EC8C["table"] = "p7_medical_gurney_01";
  level._id_EC85["table"]["table_flip"] = % pnr_attic_table_flip_table;
  level._id_EC87["j_prop_panel"] = #animtree;
  level._id_EC8C["j_prop_panel"] = "sdf_core_console_01_rig";
  level._id_EC85["j_prop_panel"]["panel_start_01"] = % yard_power_relay_panel_panel_rip_start01;
  level._id_EC85["j_prop_panel"]["panel_idle_01"][0] = % yard_power_relay_panel_panel_rip_idle01;
  level._id_EC85["j_prop_panel"]["panel_start_02"] = % yard_power_relay_panel_panel_rip_start02;
  level._id_EC85["j_prop_panel"]["panel_idle_02"][0] = % yard_power_relay_panel_panel_rip_idle02;
  level._id_EC85["j_prop_panel"]["panel_end"] = % yard_power_relay_panel_panel_rip_end;
  level._id_EC87["j_prop_hatch"] = #animtree;
  level._id_EC8C["j_prop_hatch"] = "generic_prop_x3";
  level._id_EC85["j_prop_hatch"]["hatch_pull"] = % yard_power_relay_grate_grate_rip;
  level._id_EC87["j_prop_missiles"] = #animtree;
  level._id_EC8C["j_prop_missiles"] = "generic_prop_x3";
  level._id_EC85["j_prop_missiles"]["spaced_scene"] = % yard_spaced_airlock_missiles;
  level._id_EC87["j_prop_ammo"] = #animtree;
  level._id_EC8C["j_prop_ammo"] = "generic_prop_x3";
  level._id_EC85["j_prop_ammo"]["spaced_scene"] = % yard_spaced_airlock_container;
  level._id_EC87["j_prop_grate"] = #animtree;
  level._id_EC8C["j_prop_grate"] = "generic_prop_x3";
  level._id_EC85["j_prop_grate"]["spaced_scene"] = % yard_spaced_airlock_grate;
  level._id_EC87["debris"] = #animtree;
  level._id_EC8C["debris"] = "generic_prop_x3";
  level._id_EC85["debris"]["end_scene"] = % yard_control_center_debris;
  level._id_EC87["debris_1"] = #animtree;
  level._id_EC8C["debris_1"] = "debris_exterior_metal_panels_thick_05";
  level._id_EC85["debris_1"]["end_scene"] = % yard_control_center_extraction_debris_1;
  level._id_EC87["debris_2"] = #animtree;
  level._id_EC8C["debris_2"] = "sdf_scrap_debris_05";
  level._id_EC85["debris_2"]["end_scene"] = % yard_control_center_extraction_debris_2;
  level._id_EC87["debris_3"] = #animtree;
  level._id_EC8C["debris_3"] = "vfx_debris_metal_shrapnel_a_01";
  level._id_EC85["debris_3"]["end_scene"] = % yard_control_center_extraction_debris_1;
  level._id_EC87["debris_4"] = #animtree;
  level._id_EC8C["debris_4"] = "vfx_debris_metal_shrapnel_a_02";
  level._id_EC85["debris_4"]["end_scene"] = % yard_control_center_extraction_end_debris_2;
  level._id_EC87["debris_5"] = #animtree;
  level._id_EC8C["debris_5"] = "vfx_debris_metal_shrapnel_a_03";
  level._id_EC85["debris_5"]["end_scene"] = % yard_control_center_extraction_end_debris_3;
  level._id_EC87["debris_6"] = #animtree;
  level._id_EC8C["debris_6"] = "vfx_debris_metal_shrapnel_a_04";
  level._id_EC85["debris_6"]["end_scene"] = % yard_control_center_extraction_end_debris_4;
  level._id_EC87["debris_7"] = #animtree;
  level._id_EC8C["debris_7"] = "vfx_debris_metal_shrapnel_a_05";
  level._id_EC85["debris_7"]["end_scene"] = % yard_control_center_extraction_end_debris_5;
  level._id_EC87["debris_8"] = #animtree;
  level._id_EC8C["debris_8"] = "vfx_debris_metal_shrapnel_a_06";
  level._id_EC85["debris_8"]["end_scene"] = % yard_control_center_extraction_end_debris_6;
  level._id_EC87["debris_9"] = #animtree;
  level._id_EC8C["debris_9"] = "vfx_debris_metal_shrapnel_a_01";
  level._id_EC85["debris_9"]["end_scene"] = % yard_control_center_extraction_end_debris_7;
  level._id_EC87["debris_10"] = #animtree;
  level._id_EC8C["debris_10"] = "vfx_debris_metal_a_08";
  level._id_EC85["debris_10"]["end_scene"] = % yard_control_center_extraction_end_debris_8;
  level._id_EC87["debris_11"] = #animtree;
  level._id_EC8C["debris_11"] = "vfx_debris_metal_a_09";
  level._id_EC85["debris_11"]["end_scene"] = % yard_control_center_extraction_end_debris_9;
  level._id_EC87["debris_12"] = #animtree;
  level._id_EC8C["debris_12"] = "vfx_debris_metal_shrapnel_a_04";
  level._id_EC85["debris_12"]["end_scene"] = % yard_control_center_extraction_end_debris_10;
  level._id_EC87["debris_13"] = #animtree;
  level._id_EC8C["debris_13"] = "vfx_debris_metal_a_10";
  level._id_EC85["debris_13"]["end_scene"] = % yard_control_center_extraction_end_debris_11;
  level._id_EC87["secret_skelter"] = #animtree;
  level._id_EC8C["secret_skelter"] = "veh_mil_air_ca_jackal_01";
  level._id_EC85["secret_skelter"]["end_scene"] = % yard_control_center_extraction_sdf_jack_1;
  level._id_EC87["ending_missile"] = #animtree;
  level._id_EC8C["ending_missile"] = "tag_origin";
  level._id_EC85["ending_missile"]["end_scene"] = % yard_control_center_extraction_missile_01;
  scripts\sp\anim::_id_17FC("ending_missile", "explode", "ending_missile_explode", "end_scene");
  level._id_EC87["ending_turret"] = #animtree;
  level._id_EC8C["ending_turret"] = "ship_exterior_ca_cannon_b";
  level._id_EC85["ending_turret"]["end_scene"] = % yard_control_center_extraction_turret_1;
  scripts\sp\anim::_id_17F6("ending_turret", "fire_left", scripts\sp\maps\yard\yard_ending::_id_6350, "end_scene");
  scripts\sp\anim::_id_17F6("ending_turret", "fire_right", scripts\sp\maps\yard\yard_ending::_id_6351, "end_scene");
  level._id_EC87["glass_break"] = #animtree;
  level._id_EC8C["glass_break"] = "vm_hero_protagonist_helmet_glass_break_yard";
  level._id_EC85["glass_break"]["end_scene"] = % vm_hero_protagonist_helmet_glass_break_yard;
}

#using_animtree("vehicles");

_id_13267() {
  level._id_EC85["destroyer_salter"]["escape_button_press"] = % yard_control_center_turn_xo_ship;
  level._id_EC85["destroyer_salter"]["end_scene"] = % yard_control_center_extraction_xo_ship;
  level._id_EC85["carrier_ram"]["end_scene"] = % yard_control_center_extraction_sdf_ship_1;
  scripts\sp\anim::_id_17FC("carrier_ram", "start_ram", "carrier_start_ram", "end_scene");
  scripts\sp\anim::_id_17FC("carrier_ram", "end_ram", "carrier_end_ram", "end_scene");
  level._id_EC85["carrier_attack"]["end_scene"] = % yard_control_center_extraction_sdf_ship_2;
}

_id_A056() {}