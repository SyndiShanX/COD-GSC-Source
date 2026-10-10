/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_6202afd5acdbf2da.gsc
*************************************************/

#using script_19163c4e4e504a5e;
#using script_1db908936531314b;
#using script_53f4e6352b0b2425;
#using script_6202afd5acdbf2da;
#using script_6bf6c8e2e1fdccaa;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace namespace_ee7ad018bcc1081a;

function main() {}

function function_907c6992fc83d232() {
  level.player setsoundsubmix("sp_jup_hijack_default");
}

function function_b194d4eb3b43f417() {
  level.player clearsoundsubmix("sp_jup_hijack_default");
}

function function_30485484eeb84f8() {
  level.player setclienttriggeraudiozone("sp_jup_hijack_first_class_disoriented", 1);
  wait 12;
  level.player clearclienttriggeraudiozone(2);
}

function function_15492311e775ef09() {
  level.player setsoundsubmix("sp_jup_hijack_scn_intro_ambience");
  wait 12;
  level.player clearsoundsubmix("sp_jup_hijack_scn_intro_ambience", 4);
}

function function_1fe5ec9e8442ee3() {
  level.player setsoundsubmix("sp_jup_hijack_scn_intro_passenger_vo");
  level waittill("passenger_vo_intro");
  level.player clearsoundsubmix("sp_jup_hijack_scn_intro_passenger_vo", 0.5);
}

function function_aee51ba44e4e892() {
  level.player setsoundsubmix("sp_jup_hijack_scn_intro_turbulence");
  level waittill("clear_turbulence_submix");
  level.player clearsoundsubmix("sp_jup_hijack_scn_intro_turbulence", 0.5);
}

function function_623b2fe30a053c15() {
  level.player setsoundsubmix("sp_jup_hijack_remove_dambs");
}

function function_deaf4e524dcd7776() {
  level.player clearsoundsubmix("sp_jup_hijack_remove_dambs", 0.5);
}

function function_475b473cd5fe0c73() {
  level waittill("standoff_ambience");
  level.player setsoundsubmix("sp_jup_hijack_scn_standoff_ambience");
  level waittill("standoff_canceled");
  level.player clearsoundsubmix("sp_jup_hijack_scn_standoff_ambience");
}

function function_6159c7170473b3b5() {
  level waittill("disarm_enemy_start");
  level.player setsoundsubmix("sp_jup_hijack_disarm");
  wait 8;
  level.player clearsoundsubmix("sp_jup_hijack_disarm");
}

function function_6bbac8f70172dad2() {
  level waittill("passenger_vo_hijacker_shooting");
  level.player setsoundsubmix("sp_jup_hijack_scn_hijacker_starts_shooting");
  level waittill("passenger_vo_wakeup");
  level.player clearsoundsubmix("sp_jup_hijack_scn_hijacker_starts_shooting");
}

function function_bbebf4009dc0eaa0() {
  level waittill("first_shot_enemy");
  level.player setsoundsubmix("sp_jup_hijack_first_shot_enemy");
  wait 2.5;
  level.player clearsoundsubmix("sp_jup_hijack_first_shot_enemy");
}

function function_faca90fa96fa2939() {
  flag_wait("flag_standoff_end");
  level.player setsoundsubmix("sp_jup_hijack_scn_standoff_end_ambience");
  level waittill("passenger_vo_flashbang_bounces");
  level.player clearsoundsubmix("sp_jup_hijack_scn_standoff_end_ambience");
}

function function_22d2fc50ad928fd2() {
  level waittill("passenger_vo_flashbang_bounces");
  level.player setsoundsubmix("sp_jup_hijack_flashbang_grenade_removal");
  level waittill("passenger_vo_wakeup");
  level.player clearsoundsubmix("sp_jup_hijack_flashbang_grenade_removal");
}

function function_ca3c04ca4ff302b5() {
  level waittill("passenger_vo_flashbang_bounces");
  level.player setsoundsubmix("sp_jup_hijack_flashbang_grenade_bounces");
}

function function_88f9036667bbfa9f() {
  level.player clearsoundsubmix("sp_jup_hijack_flashbang_grenade_bounces");
  level.player setsoundsubmix("sp_jup_hijack_flashbang_grenade_expl_passenger_vo");
  level waittill("passenger_vo_wakeup");
  level.player clearsoundsubmix("sp_jup_hijack_flashbang_grenade_expl_passenger_vo");
}

function function_5e320cd0ce9c9a2b() {
  level.player setsoundsubmix("sp_jup_hijack_pistol_whip_music");
  wait 2;
  level.player clearsoundsubmix("sp_jup_hijack_pistol_whip_music");
}

function function_2a90160a7dd87714() {
  level.player setsoundsubmix("sp_jup_hijack_scn_drag_to_first_class_music");
  wait 8;
  level.player clearsoundsubmix("sp_jup_hijack_scn_drag_to_first_class_music");
}

function function_a327bd0ac215996e() {
  level waittill("plane_door_open");
  level.player setsoundsubmix("sp_jup_hijack_scn_makarov_reveal_bomb_beep");
  wait 11.5;
  level.player clearsoundsubmix("sp_jup_hijack_scn_makarov_reveal_bomb_beep");
}

function function_c8de152f50814b71() {
  level waittill("plane_door_open");
  level.player setsoundsubmix("sp_jup_hijack_scn_plane_door_open");
  level.player setsoundsubmix("sp_jup_hijack_scn_post_makarov_exit_ambience");
  level waittill("passenger_vo_stop");
  level.player clearsoundsubmix("sp_jup_hijack_scn_post_makarov_exit_ambience");
  level.player clearsoundsubmix("sp_jup_hijack_scn_plane_door_open");
}

function function_56490d046a0db2a6() {
  level waittill("turbine_filter_lower");
  level.player setsoundsubmix("sp_jup_hijack_scn_post_makarov_exit_turbine_filter");
  level waittill("passenger_vo_enter_economy");
  level.player clearsoundsubmix("sp_jup_hijack_scn_post_makarov_exit_turbine_filter");
}

function function_b87c2c00f5f8cb71() {
  level waittill("passenger_vo_wakeup");
  level.player setsoundsubmix("sp_jup_hijack_scn_passenger_vo_behind_curtain");
  level waittill("passenger_vo_economy_curtain_opens");
  level.player clearsoundsubmix("sp_jup_hijack_scn_passenger_vo_behind_curtain");
}

function function_b3f33897c12d0e04() {
  level waittill("thrown_bomb_beep");
  level.player setsoundsubmix("sp_jup_hijack_throw_into_economy_bomb_beep");
  wait 4;
  level.player clearsoundsubmix("sp_jup_hijack_throw_into_economy_bomb_beep");
}

function function_2868ab53f630a1a6() {
  level waittill("passenger_vo_enter_economy");
  level.player setsoundsubmix("sp_jup_hijack_scn_post_thrown_into_economy");
  level waittill("passenger_vo_stop");
  level.player clearsoundsubmix("sp_jup_hijack_scn_post_thrown_into_economy");
}

function function_2adfa93148e9c10e() {
  level.player setsoundsubmix("sp_jup_hijack_scn_post_makarov_exit_turbulence");
}

function function_312fd9dc4b5565d5() {
  level.player clearsoundsubmix("sp_jup_hijack_scn_post_makarov_exit_turbulence", 0.5);
}

function function_42e0ce8a59962f9c() {
  level waittill("passenger_vo_takedown");
  level.player setsoundsubmix("sp_jup_hijack_scn_post_makarov_exit_takedown");
  level waittill("passenger_vo_woman_picks_up_phone");
  level.player clearsoundsubmix("sp_jup_hijack_scn_post_makarov_exit_takedown");
}

function function_9358eb324ef5b753() {
  level waittill("passenger_vo_woman_picks_up_phone");
  level.player setsoundsubmix("sp_jup_hijack_scn_enter_economy_picks_up_phone");
  level waittill("passenger_vo_stop");
  level.player clearsoundsubmix("sp_jup_hijack_scn_enter_economy_picks_up_phone");
}

function function_694cefd45aed146b() {
  level.player setsoundsubmix("sp_jup_hijack_bomb_explosion");
}

function function_9db777987d129538() {
  level.player clearsoundsubmix("sp_jup_hijack_bomb_explosion");
}

function function_8bc536c11fe3eb9() {
  sndobj = snd_play([0, "jup_hijack_vo_passengers_general_conversation_lp_lr", 1]);
  level waittill("passenger_vo_economy_walla_stop");
  snd_stop(sndobj, 8);
}

function function_6f948ae583865e3e() {
  wait 3;
  var_24e389c41665462c = snd_play([0, "jup_hijack_vo_passengers_panic_lp_lr", 4]);
  level waittill("post_knockout_dragged_through_first_class");
  snd_stop(var_24e389c41665462c, 1);
}

function function_36bac2eed4b69c80() {
  level waittill("passenger_vo_hijacker_shooting");
  var_7bcd04016c2ec46a = snd_play("jup_hijack_vo_passengers_hijackers_appear_lr");
  flag_wait("flag_flashbang_done");
  snd_stop(var_7bcd04016c2ec46a, 0.15);
}

function function_47a0692123a119e6() {
  var_7bcd04016c2ec46a = snd_play("jup_hijack_vo_passengers_hijackers_appear_lr");
  flag_wait("flag_flashbang_done");
  snd_stop(var_7bcd04016c2ec46a, 0.15);
}

function function_c9ded0a9c560bbff() {
  level waittill("passenger_vo_hijackers_appear_disarm");
  var_24e393c416655c2a = snd_play("jup_hijack_vo_passengers_hijackers_appear_lr");
  flag_wait("flag_flashbang_done");
  snd_stop(var_24e393c416655c2a, 0.15);
}

function function_16fe145d50df4028() {
  flag_wait("standoff_canceled");
  var_7bcd04016c2ec46a = snd_play("jup_hijack_vo_passengers_hijackers_appear_lr");
  flag_wait("flag_flashbang_done");
  snd_stop(var_7bcd04016c2ec46a, 0.15);
}

function function_d8c586f52f52805e() {
  level waittill("passenger_vo_plr_disarm");
  var_24e393c416655c2a = snd_play("jup_hijack_vo_passengers_reacting_to_disarm");
}

function function_6f0e50943cc99139() {
  var_24e38ac41665485f = snd_play([0, "jup_hijack_vo_passengers_waiting_economy_lp", 9.5], (-118, -2, 58));
  level waittill("passenger_vo_enter_economy");
  snd_stop(var_24e38ac41665485f, 4);
}

function function_6bdd001c0eefe74b() {
  level waittill("passenger_vo_enter_economy");
  var_24e387c4166541c6 = snd_play("jup_hijack_vo_passengers_thrown_into_economy");
  level waittill("passenger_vo_react_samara_with_gun");
  var_24e388c4166543f9 = snd_play("jup_hijack_vo_passengers_reacting_to_gun");
  level waittill("passenger_vo_fighting_samara");
  snd_stop(var_24e387c4166541c6, 1);
  level waittill("passenger_vo_stop");
  snd_stop(var_24e388c4166543f9, 0.25);
}

function function_4b5cfeaa7e57162b() {
  var_a8c5efb7ece85e43 = snd_play("jup_hijack_vo_passengers_reacting_to_gun_add");
  level waittill("passenger_vo_stop");
  snd_stop(var_a8c5efb7ece85e43, 0.25);
}

function function_4437b50ae5c40f41() {
  var_a8c5eeb7ece85c10 = snd_play("jup_hijack_vo_passengers_fighting_samara");
  level waittill("passenger_vo_stop");
  snd_stop(var_a8c5eeb7ece85c10, 0.25);
}

function function_ef66685f1a7d7f60() {
  level waittill("passenger_vo_enter_economy");
  wait 7;
  panic_end = snd_play("jup_hijack_vo_passengers_panic_end_lp_lr");
  level waittill("passenger_vo_takedown");
  snd_stop(panic_end, 0.25);
  level waittill("passenger_vo_stop");
  snd_stop(panic_end, 0.25);
}

function intro_jet_whine() {
  level.player snd_play("jup_hijack_scn_intro_jet_whine");
}

function flashbang_explosion() {
  level.player snd_play("jup_hijack_scn_flashbang_toss_explosion_transient");
  level.player snd_play("jup_hijack_flashbang_disorientation");
}

function function_657f121fc52518ca() {
  thread function_a327bd0ac215996e();
  level waittill("plane_door_open_start");
  snd_play("jup_hijack_plane_door_open", (414, 80, 58));
  level waittill("plane_door_open");
  var_300a4187ea15e52 = snd_play("jup_hijack_seatbelt_rattle_lp", (438, 10, 48));
  var_300a3187ea15c1f = snd_play("jup_hijack_seatbelt_rattle_lp", (172, 10, 42));
  var_300a2187ea159ec = snd_play("jup_hijack_seatbelt_rattle_lp", (80, -82, 42));
  snd_play("jup_hijack_curtain_movement_lp", (318, -48, 56));
  var_3518e1f4f18d1fc6 = snd_play("jup_hijack_oxygen_mask_lp", (130, -84, 62));
  var_3518e0f4f18d1d93 = snd_play("jup_hijack_oxygen_mask_lp", (52, 8, 62));
  var_3518dff4f18d1b60 = snd_play("jup_hijack_oxygen_mask_lp", (-154, 4, 62));
  var_3518e6f4f18d2ac5 = snd_play("jup_hijack_oxygen_mask_lp", (-172, -80, 62));
  var_3518e5f4f18d2892 = snd_play("jup_hijack_oxygen_mask_lp", (202, 4, 68));
  var_3ee4c5776f719693 = snd_play([45, "jup_hijack_exposed_turbine_lp_lr", 5]);
  level.player snd_play("jup_hijack_turbines_lr");
  level waittill("pre_thrown_into_economy_handed_weapon");
  snd_stop(var_3518e1f4f18d1fc6, 16);
  snd_stop(var_3518e0f4f18d1d93, 16);
  snd_stop(var_3518dff4f18d1b60, 16);
  snd_stop(var_3518e6f4f18d2ac5, 16);
  snd_stop(var_3518e5f4f18d2892, 16);
  snd_stop(var_300a4187ea15e52, 16);
  snd_stop(var_300a3187ea15c1f, 16);
  snd_stop(var_300a2187ea159ec, 16);
  wait 7.25;
  var_b682d8f8dcde9658 = snd_play("jup_hijack_scn_enter_economy_plane_banking_accent");
  level waittill("passenger_vo_takedown");
  snd_stop(var_3ee4c5776f719693, 6);
  snd_stop(var_b682d8f8dcde9658, 10);
}

function bomb_explosion() {
  level.player snd_play("jup_hijack_bomb_explosion_transient");
}

function turbulence(big_shake) {
  if(isDefined(big_shake) && big_shake) {
    thread namespace_2f067fefb7259496::function_c0f0d9a29d612e95();
    return;
  }

  if(isDefined(big_shake) && !big_shake) {
    thread namespace_2f067fefb7259496::turbulence_light();
    return;
  }

  thread namespace_2f067fefb7259496::function_c0f0d9a29d612e95();
}

function function_e587439a27a5c001(big_shake) {
  if(isDefined(big_shake) && big_shake) {
    thread namespace_2f067fefb7259496::turbulence_light_intro();
    return;
  }

  if(isDefined(big_shake) && !big_shake) {
    thread namespace_2f067fefb7259496::turbulence_light_intro();
    return;
  }

  thread namespace_2f067fefb7259496::turbulence_light_intro();
}

function function_c0f0d9a29d612e95() {
  var_45835b5f7f63c9ea = (-520, -4, 78);
  playsoundatpos(var_45835b5f7f63c9ea, "jup_hijack_flight_turbulence_large");
  var_bf81ce3781023a39 = (-910, 72, 60);
  playsoundatpos(var_bf81ce3781023a39, "jup_hijack_flight_turbulence_pos_coach");
  var_5536931ccef99de8 = (-754, 18, 60);
  playsoundatpos(var_5536931ccef99de8, "jup_hijack_flight_turbulence_pos_coach");
  var_c7a30fd6b59060bb = (-610, -80, 60);
  playsoundatpos(var_c7a30fd6b59060bb, "jup_hijack_flight_turbulence_pos_coach");
  var_f38a3b73cd440dd2 = (-470, 80, 60);
  playsoundatpos(var_f38a3b73cd440dd2, "jup_hijack_flight_turbulence_pos_coach");
  var_717baec28cef445 = (-346, 2, 60);
  playsoundatpos(var_717baec28cef445, "jup_hijack_flight_turbulence_pos_coach");
  var_3dfe773f342658b4 = (-190, -80, 60);
  playsoundatpos(var_3dfe773f342658b4, "jup_hijack_flight_turbulence_pos_coach");
  var_518bf6b78fb13f27 = (-100, 78, 60);
  playsoundatpos(var_518bf6b78fb13f27, "jup_hijack_flight_turbulence_pos_coach");
  var_1f7c7811a47b4d4e = (-378, -58, 78);
  playsoundatpos(var_1f7c7811a47b4d4e, "jup_hijack_flight_turbulence_pos_coach");
  var_8d9178b5a71f921 = (-262, -82, 62);
  playsoundatpos(var_8d9178b5a71f921, "jup_hijack_flight_turbulence_pos_coach");
  var_9d0fcf45da2a46d7 = (-184, 82, 60);
  playsoundatpos(var_9d0fcf45da2a46d7, "jup_hijack_flight_turbulence_pos_coach");
  var_43c8c75a4947d359 = (-938, -20, 32);
  playsoundatpos(var_43c8c75a4947d359, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_4fe897fc6dae8188 = (-836, 66, 32);
  playsoundatpos(var_4fe897fc6dae8188, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_c9ff09041bfbfbdb = (-752, 4, 32);
  playsoundatpos(var_c9ff09041bfbfbdb, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_736b349690b37df2 = (-614, -66, 32);
  playsoundatpos(var_736b349690b37df2, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_86f8b40eec3e6465 = (-498, 66, 32);
  playsoundatpos(var_86f8b40eec3e6465, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_c58964afbf4c8054 = (-416, 2, 32);
  playsoundatpos(var_c58964afbf4c8054, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_c9c2fb8c8b69f7c7 = (-318, -66, 32);
  playsoundatpos(var_c9c2fb8c8b69f7c7, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_ab6d658234779dee = (-202, 84, 32);
  playsoundatpos(var_ab6d658234779dee, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_81101c60562ab1c1 = (-158, -22, 32);
  playsoundatpos(var_81101c60562ab1c1, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_2156c868a26fdff7 = (-100, -88, 32);
  playsoundatpos(var_2156c868a26fdff7, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_5852376a4188f444 = (-492, -74, 38);
  playsoundatpos(var_5852376a4188f444, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_b68b8ca5335f1415 = (-336, -68, 60);
  playsoundatpos(var_b68b8ca5335f1415, "jup_hijack_flight_turbulence_pos_chair_coach");
  var_f437bc605517040a = (-266, -22, 40);
  playsoundatpos(var_f437bc605517040a, "jup_hijack_flight_turbulence_pos_seatbelt_coach");
  var_1fd26357a99f979f = (-394, -78, 40);
  playsoundatpos(var_1fd26357a99f979f, "jup_hijack_flight_turbulence_pos_seatbelt_coach");
  var_4655ac7983af79ac = (-536, -18, 40);
  playsoundatpos(var_4655ac7983af79ac, "jup_hijack_flight_turbulence_pos_seatbelt_coach");
  var_32c835012824a4d1 = (-694, -76, 40);
  playsoundatpos(var_32c835012824a4d1, "jup_hijack_flight_turbulence_pos_seatbelt_coach");
  var_c05ab847418baefe = (-906, -14, 40);
  playsoundatpos(var_c05ab847418baefe, "jup_hijack_flight_turbulence_pos_seatbelt_coach");
  var_cffe4dba9a35d94 = (136, 10, 32);
  playsoundatpos(var_cffe4dba9a35d94, "jup_hijack_flight_turbulence_pos_chair_first_class");
  var_d2d6343adb6d9da5 = (196, -88, 32);
  playsoundatpos(var_d2d6343adb6d9da5, "jup_hijack_flight_turbulence_pos_chair_first_class");
  var_ca359d5e0a77ca32 = (288, -12, 32);
  playsoundatpos(var_ca359d5e0a77ca32, "jup_hijack_flight_turbulence_pos_chair_first_class");
  var_a2b571c0f79c791b = (288, -86, 40);
  playsoundatpos(var_a2b571c0f79c791b, "jup_hijack_flight_turbulence_pos_chair_first_class");
  var_5cef4f5da067a43e = (78, 50, 60);
  playsoundatpos(var_5cef4f5da067a43e, "jup_hijack_flight_turbulence_pos_first_class");
  var_fa8cd07fd2e33093 = (194, -80, 60);
  playsoundatpos(var_fa8cd07fd2e33093, "jup_hijack_flight_turbulence_pos_first_class");
  var_af0d3f76cf0019e0 = (266, 36, 60);
  playsoundatpos(var_af0d3f76cf0019e0, "jup_hijack_flight_turbulence_pos_first_class");
  var_5daab2f865f56e7d = (264, -82, 68);
  playsoundatpos(var_5daab2f865f56e7d, "jup_hijack_flight_turbulence_pos_first_class");
  var_a4853c1248345e4a = (284, -62, 32);
  playsoundatpos(var_a4853c1248345e4a, "jup_hijack_flight_turbulence_pos_seatbelt");
  var_4e34e3143ae2f3df = (308, -84, 64);
  playsoundatpos(var_4e34e3143ae2f3df, "jup_hijack_flight_turbulence_pos_first_class");
  var_e750438fe76197ec = (308, 12, 64);
  playsoundatpos(var_e750438fe76197ec, "jup_hijack_flight_turbulence_pos_first_class");
  var_9508b87f9c03e8b3 = (460, 52, 64);
  playsoundatpos(var_9508b87f9c03e8b3, "jup_hijack_flight_turbulence_pos_deck");
  var_6bf1ff8f8f5cb5e = (356, 52, 64);
  playsoundatpos(var_6bf1ff8f8f5cb5e, "jup_hijack_flight_turbulence_pos_deck");
  var_853b9100ac196eb1 = (488, -52, 64);
  playsoundatpos(var_853b9100ac196eb1, "jup_hijack_flight_turbulence_pos_chair_deck");
  var_bf11fe81b35328c = (444, -4, 64);
  playsoundatpos(var_bf11fe81b35328c, "jup_hijack_flight_turbulence_pos_chair_deck");
  var_f05abf61cbba637f = (440, -36, 64);
  playsoundatpos(var_f05abf61cbba637f, "jup_hijack_flight_turbulence_pos_deck");
  var_c0d7cf4a794cf704 = (414, -76, 76);
  playsoundatpos(var_c0d7cf4a794cf704, "jup_hijack_flight_turbulence_pos_door");
  var_7d17fd836dcdcbb8 = (380, 0, 44);
  playsoundatpos(var_7d17fd836dcdcbb8, "jup_hijack_flight_turbulence_pos_seatbelt_deck");
  var_660178937e0f3a89 = (440, 8, 44);
  playsoundatpos(var_660178937e0f3a89, "jup_hijack_flight_turbulence_pos_seatbelt_deck");
  var_3403c135a39e15d0 = (380, 0, 76);
  playsoundatpos(var_3403c135a39e15d0, "jup_hijack_flight_turbulence_pos_plastic_box_deck");
}

function function_186c811d20202ad() {
  var_45835b5f7f63c9ea = (-520, -4, 78);
  playsoundatpos(var_45835b5f7f63c9ea, "jup_hijack_flight_turbulence_large_outro");
  var_bf81ce3781023a39 = (-910, 72, 60);
  playsoundatpos(var_bf81ce3781023a39, "jup_hijack_flight_turbulence_pos_coach_outro");
  var_5536931ccef99de8 = (-754, 18, 60);
  playsoundatpos(var_5536931ccef99de8, "jup_hijack_flight_turbulence_pos_coach_outro");
  var_c7a30fd6b59060bb = (-610, -80, 60);
  playsoundatpos(var_c7a30fd6b59060bb, "jup_hijack_flight_turbulence_pos_coach_outro");
  var_f38a3b73cd440dd2 = (-470, 80, 60);
  playsoundatpos(var_f38a3b73cd440dd2, "jup_hijack_flight_turbulence_pos_coach_outro");
  var_717baec28cef445 = (-346, 2, 60);
  playsoundatpos(var_717baec28cef445, "jup_hijack_flight_turbulence_pos_coach_outro");
  var_3dfe773f342658b4 = (-190, -80, 60);
  playsoundatpos(var_3dfe773f342658b4, "jup_hijack_flight_turbulence_pos_coach_outro");
  var_518bf6b78fb13f27 = (-100, 78, 60);
  playsoundatpos(var_518bf6b78fb13f27, "jup_hijack_flight_turbulence_pos_coach_outro");
  var_1f7c7811a47b4d4e = (-378, -58, 78);
  playsoundatpos(var_1f7c7811a47b4d4e, "jup_hijack_flight_turbulence_pos_coach_outro");
  var_8d9178b5a71f921 = (-262, -82, 62);
  playsoundatpos(var_8d9178b5a71f921, "jup_hijack_flight_turbulence_pos_coach_outro");
  var_9d0fcf45da2a46d7 = (-184, 82, 60);
  playsoundatpos(var_9d0fcf45da2a46d7, "jup_hijack_flight_turbulence_pos_coach_outro");
  var_43c8c75a4947d359 = (-938, -20, 32);
  playsoundatpos(var_43c8c75a4947d359, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_4fe897fc6dae8188 = (-836, 66, 32);
  playsoundatpos(var_4fe897fc6dae8188, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_c9ff09041bfbfbdb = (-752, 4, 32);
  playsoundatpos(var_c9ff09041bfbfbdb, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_736b349690b37df2 = (-614, -66, 32);
  playsoundatpos(var_736b349690b37df2, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_86f8b40eec3e6465 = (-498, 66, 32);
  playsoundatpos(var_86f8b40eec3e6465, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_c58964afbf4c8054 = (-416, 2, 32);
  playsoundatpos(var_c58964afbf4c8054, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_c9c2fb8c8b69f7c7 = (-318, -66, 32);
  playsoundatpos(var_c9c2fb8c8b69f7c7, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_ab6d658234779dee = (-202, 84, 32);
  playsoundatpos(var_ab6d658234779dee, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_81101c60562ab1c1 = (-158, -22, 32);
  playsoundatpos(var_81101c60562ab1c1, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_2156c868a26fdff7 = (-100, -88, 32);
  playsoundatpos(var_2156c868a26fdff7, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_5852376a4188f444 = (-492, -74, 38);
  playsoundatpos(var_5852376a4188f444, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_b68b8ca5335f1415 = (-336, -68, 60);
  playsoundatpos(var_b68b8ca5335f1415, "jup_hijack_flight_turbulence_pos_chair_coach_outro");
  var_f437bc605517040a = (-266, -22, 40);
  playsoundatpos(var_f437bc605517040a, "jup_hijack_flight_turbulence_pos_seatbelt_coach_outro");
  var_1fd26357a99f979f = (-394, -78, 40);
  playsoundatpos(var_1fd26357a99f979f, "jup_hijack_flight_turbulence_pos_seatbelt_coach_outro");
  var_4655ac7983af79ac = (-536, -18, 40);
  playsoundatpos(var_4655ac7983af79ac, "jup_hijack_flight_turbulence_pos_seatbelt_coach_outro");
  var_32c835012824a4d1 = (-694, -76, 40);
  playsoundatpos(var_32c835012824a4d1, "jup_hijack_flight_turbulence_pos_seatbelt_coach_outro");
  var_c05ab847418baefe = (-906, -14, 40);
  playsoundatpos(var_c05ab847418baefe, "jup_hijack_flight_turbulence_pos_seatbelt_coach_outro");
  var_cffe4dba9a35d94 = (136, 10, 32);
  playsoundatpos(var_cffe4dba9a35d94, "jup_hijack_flight_turbulence_pos_chair_first_class_outro");
  var_d2d6343adb6d9da5 = (196, -88, 32);
  playsoundatpos(var_d2d6343adb6d9da5, "jup_hijack_flight_turbulence_pos_chair_first_class_outro");
  var_ca359d5e0a77ca32 = (288, -12, 32);
  playsoundatpos(var_ca359d5e0a77ca32, "jup_hijack_flight_turbulence_pos_chair_first_class_outro");
  var_5cef4f5da067a43e = (78, 50, 60);
  playsoundatpos(var_5cef4f5da067a43e, "jup_hijack_flight_turbulence_pos_first_class_outro");
  var_fa8cd07fd2e33093 = (194, -80, 60);
  playsoundatpos(var_fa8cd07fd2e33093, "jup_hijack_flight_turbulence_pos_first_class_outro");
  var_af0d3f76cf0019e0 = (266, 36, 60);
  playsoundatpos(var_af0d3f76cf0019e0, "jup_hijack_flight_turbulence_pos_first_class_outro");
  var_5daab2f865f56e7d = (284, -62, 32);
  playsoundatpos(var_5daab2f865f56e7d, "jup_hijack_flight_turbulence_pos_seatbelt_outro");
  var_a4853c1248345e4a = (284, -62, 32);
  playsoundatpos(var_a4853c1248345e4a, "jup_hijack_flight_turbulence_pos_seatbelt");
  var_4e34e3143ae2f3df = (308, -84, 64);
  playsoundatpos(var_4e34e3143ae2f3df, "jup_hijack_flight_turbulence_pos_first_class");
  var_e750438fe76197ec = (308, 12, 64);
  playsoundatpos(var_e750438fe76197ec, "jup_hijack_flight_turbulence_pos_first_class");
  var_853b9100ac196eb1 = (488, -52, 64);
  playsoundatpos(var_853b9100ac196eb1, "jup_hijack_flight_turbulence_pos_chair_deck");
  var_bf11fe81b35328c = (444, -4, 64);
  playsoundatpos(var_bf11fe81b35328c, "jup_hijack_flight_turbulence_pos_chair_deck");
  var_f05abf61cbba637f = (440, -36, 64);
  playsoundatpos(var_f05abf61cbba637f, "jup_hijack_flight_turbulence_pos_deck");
  var_c0d7cf4a794cf704 = (414, -76, 76);
  playsoundatpos(var_c0d7cf4a794cf704, "jup_hijack_flight_turbulence_pos_door");
}

function turbulence_light() {
  var_45835b5f7f63c9ea = (-520, -4, 78);
  playsoundatpos(var_45835b5f7f63c9ea, "jup_hijack_flight_turbulence_light");
  var_bf81ce3781023a39 = (-910, 72, 60);
  playsoundatpos(var_bf81ce3781023a39, "jup_hijack_flight_turbulence_pos_coach_light");
  var_5536931ccef99de8 = (-754, 18, 60);
  playsoundatpos(var_5536931ccef99de8, "jup_hijack_flight_turbulence_pos_coach_light");
  var_c7a30fd6b59060bb = (-610, -80, 60);
  playsoundatpos(var_c7a30fd6b59060bb, "jup_hijack_flight_turbulence_pos_coach_light");
  var_f38a3b73cd440dd2 = (-470, 80, 60);
  playsoundatpos(var_f38a3b73cd440dd2, "jup_hijack_flight_turbulence_pos_coach_light");
  var_717baec28cef445 = (-346, 2, 60);
  playsoundatpos(var_717baec28cef445, "jup_hijack_flight_turbulence_pos_coach_light");
  var_3dfe773f342658b4 = (-190, -80, 60);
  playsoundatpos(var_3dfe773f342658b4, "jup_hijack_flight_turbulence_pos_coach_light");
  var_518bf6b78fb13f27 = (-100, 78, 60);
  playsoundatpos(var_518bf6b78fb13f27, "jup_hijack_flight_turbulence_pos_coach_light");
  var_1f7c7811a47b4d4e = (-378, -58, 78);
  playsoundatpos(var_1f7c7811a47b4d4e, "jup_hijack_flight_turbulence_pos_coach_light");
  var_8d9178b5a71f921 = (-262, -82, 62);
  playsoundatpos(var_8d9178b5a71f921, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_9d0fcf45da2a46d7 = (-184, 82, 60);
  playsoundatpos(var_9d0fcf45da2a46d7, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_43c8c75a4947d359 = (-938, -20, 32);
  playsoundatpos(var_43c8c75a4947d359, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_4fe897fc6dae8188 = (-836, 66, 32);
  playsoundatpos(var_4fe897fc6dae8188, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_c9ff09041bfbfbdb = (-752, 4, 32);
  playsoundatpos(var_c9ff09041bfbfbdb, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_736b349690b37df2 = (-614, -66, 32);
  playsoundatpos(var_736b349690b37df2, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_86f8b40eec3e6465 = (-498, 66, 32);
  playsoundatpos(var_86f8b40eec3e6465, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_c58964afbf4c8054 = (-416, 2, 32);
  playsoundatpos(var_c58964afbf4c8054, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_c9c2fb8c8b69f7c7 = (-318, -66, 32);
  playsoundatpos(var_c9c2fb8c8b69f7c7, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_ab6d658234779dee = (-202, 84, 32);
  playsoundatpos(var_ab6d658234779dee, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_81101c60562ab1c1 = (-158, -22, 32);
  playsoundatpos(var_81101c60562ab1c1, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_2156c868a26fdff7 = (-100, -88, 32);
  playsoundatpos(var_2156c868a26fdff7, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_5852376a4188f444 = (-492, -74, 38);
  playsoundatpos(var_5852376a4188f444, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_b68b8ca5335f1415 = (-336, -68, 60);
  playsoundatpos(var_b68b8ca5335f1415, "jup_hijack_flight_turbulence_pos_chair_coach_light");
  var_f437bc605517040a = (-266, -22, 40);
  playsoundatpos(var_f437bc605517040a, "jup_hijack_flight_turbulence_pos_seatbelt_coach_light");
  var_1fd26357a99f979f = (-394, -78, 40);
  playsoundatpos(var_1fd26357a99f979f, "jup_hijack_flight_turbulence_pos_seatbelt_coach_light");
  var_4655ac7983af79ac = (-536, -18, 40);
  playsoundatpos(var_4655ac7983af79ac, "jup_hijack_flight_turbulence_pos_seatbelt_coach_light");
  var_32c835012824a4d1 = (-694, -76, 40);
  playsoundatpos(var_32c835012824a4d1, "jup_hijack_flight_turbulence_pos_seatbelt_coach_light");
  var_c05ab847418baefe = (-906, -14, 40);
  playsoundatpos(var_c05ab847418baefe, "jup_hijack_flight_turbulence_pos_seatbelt_coach_light");
  var_cffe4dba9a35d94 = (136, 10, 32);
  playsoundatpos(var_cffe4dba9a35d94, "jup_hijack_flight_turbulence_pos_chair_first_class");
  var_d2d6343adb6d9da5 = (196, -88, 32);
  playsoundatpos(var_d2d6343adb6d9da5, "jup_hijack_flight_turbulence_pos_chair_first_class");
  var_ca359d5e0a77ca32 = (288, -12, 32);
  playsoundatpos(var_ca359d5e0a77ca32, "jup_hijack_flight_turbulence_pos_chair_first_class");
  var_5cef4f5da067a43e = (78, 50, 60);
  playsoundatpos(var_5cef4f5da067a43e, "jup_hijack_flight_turbulence_pos_first_class");
  var_fa8cd07fd2e33093 = (194, -80, 60);
  playsoundatpos(var_fa8cd07fd2e33093, "jup_hijack_flight_turbulence_pos_first_class");
  var_af0d3f76cf0019e0 = (266, 36, 60);
  playsoundatpos(var_af0d3f76cf0019e0, "jup_hijack_flight_turbulence_pos_first_class");
  var_5daab2f865f56e7d = (284, -62, 32);
  playsoundatpos(var_5daab2f865f56e7d, "jup_hijack_flight_turbulence_pos_seatbelt");
  var_c0d7cf4a794cf704 = (414, -76, 76);
  playsoundatpos(var_c0d7cf4a794cf704, "jup_hijack_flight_turbulence_pos_door");
}

function turbulence_light_intro() {
  var_45835b5f7f63c9ea = (-520, -4, 78);
  playsoundatpos(var_45835b5f7f63c9ea, "jup_hijack_flight_turbulence_light_intro");
  var_bf81ce3781023a39 = (-910, 72, 60);
  playsoundatpos(var_bf81ce3781023a39, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_5536931ccef99de8 = (-754, 18, 60);
  playsoundatpos(var_5536931ccef99de8, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_c7a30fd6b59060bb = (-610, -80, 60);
  playsoundatpos(var_c7a30fd6b59060bb, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_f38a3b73cd440dd2 = (-470, 80, 60);
  playsoundatpos(var_f38a3b73cd440dd2, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_717baec28cef445 = (-346, 2, 60);
  playsoundatpos(var_717baec28cef445, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_3dfe773f342658b4 = (-190, -80, 60);
  playsoundatpos(var_3dfe773f342658b4, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_518bf6b78fb13f27 = (-100, 78, 60);
  playsoundatpos(var_518bf6b78fb13f27, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_1f7c7811a47b4d4e = (-378, -58, 78);
  playsoundatpos(var_1f7c7811a47b4d4e, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_8d9178b5a71f921 = (-262, -82, 62);
  playsoundatpos(var_8d9178b5a71f921, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_9d0fcf45da2a46d7 = (-184, 82, 60);
  playsoundatpos(var_9d0fcf45da2a46d7, "jup_hijack_flight_turbulence_pos_coach_light_intro");
  var_43c8c75a4947d359 = (-938, -20, 32);
  playsoundatpos(var_43c8c75a4947d359, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_4fe897fc6dae8188 = (-836, 66, 32);
  playsoundatpos(var_4fe897fc6dae8188, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_c9ff09041bfbfbdb = (-752, 4, 32);
  playsoundatpos(var_c9ff09041bfbfbdb, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_736b349690b37df2 = (-614, -66, 32);
  playsoundatpos(var_736b349690b37df2, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_86f8b40eec3e6465 = (-498, 66, 32);
  playsoundatpos(var_86f8b40eec3e6465, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_c58964afbf4c8054 = (-416, 2, 32);
  playsoundatpos(var_c58964afbf4c8054, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_c9c2fb8c8b69f7c7 = (-318, -66, 32);
  playsoundatpos(var_c9c2fb8c8b69f7c7, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_ab6d658234779dee = (-202, 84, 32);
  playsoundatpos(var_ab6d658234779dee, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_81101c60562ab1c1 = (-158, -22, 32);
  playsoundatpos(var_81101c60562ab1c1, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_2156c868a26fdff7 = (-100, -88, 32);
  playsoundatpos(var_2156c868a26fdff7, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_5852376a4188f444 = (-492, -74, 38);
  playsoundatpos(var_5852376a4188f444, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
  var_b68b8ca5335f1415 = (-336, -68, 60);
  playsoundatpos(var_b68b8ca5335f1415, "jup_hijack_flight_turbulence_pos_chair_coach_light_intro");
}