/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_24411f7b18415b53.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\engine\utility;
#namespace namespace_1f4491fee85c632;

function main() {
  player();
  xcams();
  humans();
  script_models();
}

#using_animtree("player");

function player() {
  rigname = "player_rig";
  level.scr_animtree[rigname] = #animtree;
  level.scr_model[rigname] = "vm_c_jup_sp_hero_gaz_urban";
  level.scr_anim[rigname]["infil_shot_3"] = % jup_apt_infil_enter_vm_cam;
  level.scr_goaltime[rigname]["infil_shot_3"] = 0;
  level.scr_anim[rigname]["skyhook_hvt"] = % jup_apt_skyhook_vm_01;
  level.scr_anim[rigname]["skyhook_exfil"] = % jup_apt_skyhook_vm_02;
  level.scr_goaltime[rigname]["skyhook_exfil"] = 0;
  level.scr_anim[rigname]["capture_convo"] = % jup_apt_skyhook_capture_player_conversation;
  level.scr_goaltime[rigname]["capture_convo"] = 0;
  addnotetrack_notify(rigname, "lgt_look_up", "lgt_look_up", "skyhook_exfil");
  addnotetrack_notify(rigname, "lgt_look_down", "lgt_look_down", "skyhook_exfil");
  addnotetrack_notify(rigname, "lgt_hook_in", "lgt_hook_in", "skyhook_exfil");
  addnotetrack_notify(rigname, "lgt_watch", "lgt_watch", "skyhook_exfil");
  addnotetrack_notify(rigname, "lgt_follow_guy", "lgt_follow_guy", "skyhook_exfil");
  addnotetrack_notify(rigname, "lgt_release", "lgt_release", "skyhook_exfil");
}

function xcams() {
  level.scr_xcam["infil_shot_1"] = "jup_apt_intro_drone_xcam";
  level.scr_xcam["infil_shot_2"] = "jup_apt_intro_vm_xcam_01";
}

#using_animtree("generic_human");

function humans() {
  thirdpersonplayer = "3rd_person_player";
  level.scr_animtree[thirdpersonplayer] = #animtree;
  level.scr_model[thirdpersonplayer] = "body_c_jup_sp_hero_gaz_urban";
  level.scr_anim[thirdpersonplayer]["infil_shot_3"] = % jup_apt_infil_enter_vm;
  addnotetrack_notify(thirdpersonplayer, "fade_out_intro", "fade_from_black", "infil_shot_3");
  level.scr_anim[thirdpersonplayer]["skyhook_exfil"] = % jup_apt_skyhook_vm_body_02;
  level.scr_goaltime[thirdpersonplayer]["skyhook_exfil"] = 0;
  infil_ally = "infil_ally";
  level.scr_model[infil_ally] = "body_c_jup_sp_hero_price_urban";
  level.scr_animtree[infil_ally] = #animtree;
  level.scr_anim[infil_ally]["infil_shot_1"] = % jup_apt_intro_price_01;
  level.scr_anim[infil_ally]["infil_shot_2"] = % jup_apt_intro_price_02;
  addnotetrack_notify(infil_ally, "fade_in_intro", "fade_to_black", "infil_shot_2");
  overwatch_ally = "overwatch_ally";
  level.scr_animtree[overwatch_ally] = #animtree;
  level.scr_anim[overwatch_ally]["wave"] = % jup_apt_snipe_ghost_wave;
  level.scr_anim[overwatch_ally]["pre_wave_loop"][0] = % jup_apt_snipe_ghost_loop;
  hvt = "hvt";
  level.scr_animtree[hvt] = #animtree;
  level.scr_anim[hvt]["speech"] = % jup_apt_enemy_alarmed_01;
  level.scr_anim[hvt]["speech_pain_2"] = % jup_apt_enemy_alarmed_pains_2;
  level.scr_anim[hvt]["speech_pain_4"] = % jup_apt_enemy_alarmed_pains_4;
  level.scr_anim[hvt]["speech_pain_6"] = % jup_apt_enemy_alarmed_pains_6;
  level.scr_anim[hvt]["speech_pain_8"] = % jup_apt_enemy_alarmed_pains_8;
  level.scr_anim[hvt]["speech_react_2"] = % jup_apt_enemy_alarmed_reacts_2;
  level.scr_anim[hvt]["speech_react_4"] = % jup_apt_enemy_alarmed_reacts_4;
  level.scr_anim[hvt]["speech_react_6"] = % jup_apt_enemy_alarmed_reacts_6;
  level.scr_anim[hvt]["speech_react_8"] = % jup_apt_enemy_alarmed_reacts_8;
  level.scr_anim[hvt]["skyhook_hvt"] = % jup_apt_skyhook_hostage_01;
  level.scr_anim[hvt]["skyhook_hvt_idle"] = % jup_apt_skyhook_hostage_idle;
  level.scr_goaltime[hvt]["skyhook_exfil"] = 0;
  level.scr_anim[hvt]["skyhook_exfil"] = % jup_apt_skyhook_hostage_02;
  level.scr_anim[overwatch_ally]["skyhook_exfil"] = % jup_apt_skyhook_price_02;
  pcap_guy = "pcap_guy";
  level.scr_animtree[pcap_guy] = #animtree;
  level.scr_model[pcap_guy] = "body_hero_farahs_father_bloody";
  level.scr_anim[pcap_guy]["pcap_test"] = % jup_apt_scenea_father_test;
  level.scr_animtree[hvt] = #animtree;
  level.scr_anim[hvt]["infil_shot_1"] = % jup_apt_intro_hvt;
  var_2090ac31e6b1c1ac = "est_enemy_1";
  level.scr_animtree[var_2090ac31e6b1c1ac] = #animtree;
  level.scr_anim[var_2090ac31e6b1c1ac]["infil_shot_1"] = % jup_apt_intro_hvt_pmc_01;
  var_2090af31e6b1c845 = "est_enemy_2";
  level.scr_animtree[var_2090af31e6b1c845] = #animtree;
  level.scr_anim[var_2090af31e6b1c845]["infil_shot_1"] = % jup_apt_intro_hvt_pmc_02;
  var_2090ae31e6b1c612 = "est_enemy_3";
  level.scr_animtree[var_2090ae31e6b1c612] = #animtree;
  level.scr_anim[var_2090ae31e6b1c612]["infil_shot_1"] = % jup_apt_intro_hvt_pmc_03;
  var_2090a931e6b1bb13 = "est_enemy_4";
  level.scr_animtree[var_2090a931e6b1bb13] = #animtree;
  level.scr_anim[var_2090a931e6b1bb13]["infil_shot_1"] = % jup_apt_intro_hvt_pmc_04;
  var_2090a831e6b1b8e0 = "est_enemy_5";
  level.scr_animtree[var_2090a831e6b1b8e0] = #animtree;
  level.scr_anim[var_2090a831e6b1b8e0]["infil_shot_1"] = % jup_apt_intro_hvt_pmc_05;
  var_2090ab31e6b1bf79 = "est_enemy_6";
  level.scr_animtree[var_2090ab31e6b1bf79] = #animtree;
  level.scr_anim[var_2090ab31e6b1bf79]["infil_shot_1"] = % jup_apt_intro_hvt_pmc_06;
  var_2090aa31e6b1bd46 = "est_enemy_7";
  level.scr_animtree[var_2090aa31e6b1bd46] = #animtree;
  level.scr_anim[var_2090aa31e6b1bd46]["infil_shot_1"] = % jup_apt_intro_hvt_pmc_07;
  est_roof_guy_1 = "est_roof_guy_1";
  level.scr_animtree[est_roof_guy_1] = #animtree;
  level.scr_anim[est_roof_guy_1]["infil_shot_1"] = % jup_apt_intro_pmc_01;
  est_roof_guy_2 = "est_roof_guy_2";
  level.scr_animtree[est_roof_guy_2] = #animtree;
  level.scr_anim[est_roof_guy_2]["infil_shot_1"] = % jup_apt_intro_pmc_02;
  est_roof_guy_3 = "est_roof_guy_3";
  level.scr_animtree[est_roof_guy_3] = #animtree;
  level.scr_anim[est_roof_guy_3]["infil_shot_1"] = % jup_apt_intro_pmc_03;
  est_roof_guy_4 = "est_roof_guy_4";
  level.scr_animtree[est_roof_guy_4] = #animtree;
  level.scr_anim[est_roof_guy_4]["infil_shot_1"] = % jup_apt_intro_pmc_04;
  est_roof_guy_5 = "est_roof_guy_5";
  level.scr_animtree[est_roof_guy_5] = #animtree;
  level.scr_anim[est_roof_guy_5]["infil_shot_1"] = % jup_apt_intro_pmc_05;
  actor = "computer_enemy";
  level.scr_animtree[actor] = #animtree;
  level.scr_anim[actor]["computer_idle"] = % intd_0790_cabin_fever_idle_enmy01;
  level.scr_animname[actor]["computer_idle"] = "intd_0790_cabin_fever_idle_enmy01";
  level.scr_anim[actor]["computer_react"] = % intd_0790_cabin_fever_react_enmy01;
  level.scr_animname[actor]["computer_react"] = "intd_0790_cabin_fever_react_enmy01";
  level.scr_anim[actor]["computer_idle_death"] = % intd_0790_cabin_fever_death_back_enmy01;
  level.scr_animname[actor]["computer_idle_death"] = "intd_0790_cabin_fever_death_back_enmy01";
  level.scr_anim[actor]["computer_react_death"] = % intd_0790_cabin_fever_death_enmy01;
  level.scr_animname[actor]["computer_react_death"] = "intd_0790_cabin_fever_death_enmy01";
  ally_reveal_target1 = "ally_reveal_target1";
  level.scr_animtree[ally_reveal_target1] = #animtree;
  level.scr_anim[ally_reveal_target1]["run_by"] = % jup_apt_snipe_enemy_walk;
  level.scr_anim[ally_reveal_target1]["wait_idle"][0] = % jup_apt_snipe_enemy_loop;
  level.scr_anim[ally_reveal_target1]["snipe_death"] = % jup_apt_snipe_enemy_death;
  level.scr_goaltime[ally_reveal_target1]["snipe_death"] = 0;
  ally_reveal_target2 = "ally_reveal_target2";
  level.scr_animtree[ally_reveal_target2] = #animtree;
  level.scr_anim[ally_reveal_target2]["window_guy_death"] = % jup_apt_balcony_fall_enemy_01;
  level.scr_goaltime[ally_reveal_target2]["window_guy_death"] = 0;
  level.scr_anim[overwatch_ally]["zipline"] = % jup_apt_roof_zipline_scene_price;
  addnotetrack_notify(overwatch_ally, "price_fire", "price_fire", "zipline");
  level.scr_anim[overwatch_ally]["zipline_idle"] = % jup_apt_roof_zipline_idle_price;
  level.scr_anim[overwatch_ally]["zipline_nag"] = % jup_apt_roof_zipline_nag_price;
  level.scr_anim[overwatch_ally]["zipline_exit"] = % jup_apt_roof_zipline_exit_price;
  level.scr_anim[hvt]["hvt_flare"] = % jup_apt_roof_flare_nolan;
  level.scr_anim[hvt]["capture_stand"] = % jup_apt_skyhook_capture_nolan_stand_to_loop;
  level.scr_goaltime[hvt]["capture_stand"] = 0;
  level.scr_anim[hvt]["capture_idle"] = % jup_apt_skyhook_capture_nolan_idle_loop;
  level.scr_anim[hvt]["capture_idle_head"] = % jup_apt_skyhook_capture_nolan_idle_loop_head;
  level.scr_anim[hvt]["capture_convo"] = % jup_apt_skyhook_capture_nolan_conversation;
  level.scr_anim[hvt]["capture_convo_head"] = % jup_apt_skyhook_capture_nolan_conversation_head;
  level.scr_anim[hvt]["capture_end_idle"] = % jup_apt_skyhook_capture_nolan_struggle_loop;
  level.scr_anim[hvt]["ground_idle_struggle_fake"][0] = % jup_apt_skyhook_capture_nolan_struggle_loop;
  level.scr_goaltime[hvt]["ground_idle_struggle_fake"] = 0;
  level.scr_anim[hvt]["pickup_ground_4_head"] = % jup_hostage_pickedup_stand_4_head;
  level.scr_anim[hvt]["pickup_ground_6_head"] = % jup_hostage_pickedup_stand_6_head;
  level.scr_anim[hvt]["pickup_ground_8_head"] = % jup_hostage_pickedup_stand_8_head;
  level.scr_anim[hvt]["dropped_stand_head"] = % jup_hostage_dropped_stand_head;
  level.scr_anim[overwatch_ally]["ally_pickup_shield"] = % jup_apt_roof_shieldgrab_ally01;
}

#using_animtree("script_model");

function script_models() {
  level.scr_animtree["cargo_container"] = #animtree;
  level.scr_model["cargo_container"] = "jup_construction_apt_crane_shipping_container_01";
  level.scr_anim["cargo_container"]["container_swing"] = % jup_apt_crane_shipping_container_swing;
  level.scr_animtree["infil_drone"] = #animtree;
  level.scr_model["infil_drone"] = "veh9_mil_air_drone_recon_large_mp";
  level.scr_anim["infil_drone"]["infil_shot_2"] = % jup_apt_intro_drone_01;
  level.scr_animtree["exfil_plane"] = #animtree;
  level.scr_model["exfil_plane"] = "jup_mil_air_acharlie130";
  level.scr_anim["exfil_plane"]["skyhook_exfil"] = % jup_apt_skyhook_plane;
  level.scr_animtree["hostage_cable"] = #animtree;
  level.scr_model["hostage_cable"] = "jup_ee_military_hook_cable_01";
  level.scr_anim["hostage_cable"]["skyhook_hvt"] = % jup_apt_skyhook_hostage_cable_01;
  level.scr_anim["hostage_cable"]["skyhook_hvt_idle"] = % jup_apt_skyhook_hostage_cable_idle;
  level.scr_anim["hostage_cable"]["skyhook_exfil"] = % jup_apt_skyhook_hostage_cable_02;
  level.scr_animtree["price_cable"] = #animtree;
  level.scr_model["price_cable"] = "jup_ee_military_hook_cable_01";
  level.scr_anim["price_cable"]["skyhook_hvt"] = % jup_apt_skyhook_price_cable_01;
  level.scr_anim["price_cable"]["skyhook_exfil"] = % jup_apt_skyhook_price_cable_02;
  level.scr_animtree["player_cable"] = #animtree;
  level.scr_model["player_cable"] = "jup_ee_military_hook_cable_01";
  level.scr_anim["player_cable"]["skyhook_hvt"] = % jup_apt_skyhook_vm_cable_01;
  level.scr_anim["player_cable"]["skyhook_exfil"] = % jup_apt_skyhook_vm_cable_02;
  level.scr_animtree["hostage_carabiner"] = #animtree;
  level.scr_model["hostage_carabiner"] = "jup_ee_military_hook_carabiner_01";
  level.scr_anim["hostage_carabiner"]["skyhook_hvt"] = % jup_apt_skyhook_hostage_carabiner_01;
  level.scr_anim["hostage_carabiner"]["skyhook_hvt_idle"] = % jup_apt_skyhook_hostage_carabiner_idle;
  level.scr_anim["hostage_carabiner"]["skyhook_exfil"] = % jup_apt_skyhook_hostage_carabiner_02;
  level.scr_animtree["player_carabiner"] = #animtree;
  level.scr_model["player_carabiner"] = "jup_ee_military_hook_carabiner_01";
  level.scr_anim["player_carabiner"]["skyhook_exfil"] = % jup_apt_skyhook_vm_carabiner_02;
  level.scr_animtree["spool"] = #animtree;
  level.scr_model["spool"] = "jup_ee_machinery_spool_01";
  level.scr_anim["spool"]["skyhook_exfil"] = % jup_apt_skyhook_spool_02;
  level.scr_animtree["blimp"] = #animtree;
  level.scr_model["blimp"] = "jup_ee_military_aerostat_tethered_01";
  level.scr_anim["blimp"]["skyhook_hvt"] = % jup_apt_skyhook_blimp_01;
  level.scr_anim["blimp"]["skyhook_exfil"] = % jup_apt_skyhook_blimp_02;
  level.scr_anim["blimp"]["blimp_idle"] = % jup_apt_skyhook_blimp_idle;
  level.scr_anim["blimp"]["blimp_infil"] = % jup_apt_skyhook_blimp_idle_02;
  level.scr_animtree["blimp_tether"] = #animtree;
  level.scr_model["blimp_tether"] = "jup_ee_military_aerostat_tether_long";
  level.scr_anim["blimp_tether"]["skyhook_hvt"] = % jup_apt_skyhook_blimp_cable_01;
  level.scr_anim["blimp_tether"]["skyhook_exfil"] = % jup_apt_skyhook_blimp_cable_02;
  level.scr_anim["blimp_tether"]["blimp_idle"] = % jup_apt_skyhook_blimp_cable_idle;
  level.scr_anim["blimp_tether"]["blimp_infil"] = % jup_apt_skyhook_blimp_cable_idle_02;
  level.scr_animtree["ascender"] = #animtree;
  level.scr_model["ascender"] = "misc_wm_ascender";
  level.scr_anim["ascender"]["zipline"] = % jup_apt_roof_zipline_scene_ascender;
  level.scr_anim["ascender"]["zipline_idle"] = % jup_apt_roof_zipline_idle_ascender;
  level.scr_anim["ascender"]["zipline_nag"] = % jup_apt_roof_zipline_nag_ascender;
  level.scr_anim["ascender"]["zipline_exit"] = % jup_apt_roof_zipline_exit_ascender;
  level.scr_animtree["ally_shield"] = #animtree;
  level.scr_model["ally_shield"] = "weapon_wm_riotshield_p34";
  level.scr_anim["ally_shield"]["ally_pickup_shield"] = % jup_apt_roof_shieldgrab_shield;
  level.scr_anim["ally_shield"]["skyhook_exfil"] = % jup_apt_skyhook_price_riot_shield_02;
  level.scr_animtree["exfil_grenade"] = #animtree;
  level.scr_model["exfil_grenade"] = "projectile_grenade_frag_v0";
  level.scr_anim["exfil_grenade"]["skyhook_exfil"] = % jup_apt_skyhook_grenade_prop;
}

function private function_a943be0168cd3ed1(animname, linkto_ent, body, head, weapon) {
  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);

  if(isDefined(head)) {
    guy_head = spawn("script_model", (0, 0, 0));
    guy_head setModel(head);
    guy_head linkTo(guy, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.head = guy_head;
    guy thread delete_on_death(guy_head);
  }

  if(!isDefined(weapon)) {
    guy_weapon = spawn("script_model", (0, 0, 0));
    guy_weapon setModel("wpn_wm_p00_stream_ar");
    guy_weapon linkTo(guy, "j_gun", (0, 0, 0), (0, 0, 0));
    guy thread delete_on_death(guy_weapon);
    guy.weapon = guy_weapon;
  }

  guy.animname = animname;
  guy setanimtree();

  if(isDefined(linkto_ent)) {
    thread delete_on_death(guy);
    guy linkTo(self, linkto_ent, (0, 0, 0), (0, 0, 0));
  }

  return guy;
}