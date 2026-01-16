/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml_anim.gsc
*****************************************************/

#using_animtree("generic_human");

main() {
  maps\_hand_signals::inithandsignals();
  maps\_readystand_anims::initreadystand();
  maps\_patrol_anims_creepwalk::init_creepwalk_archetype();
  level.scr_face["hesh"]["nml_hsh_onme_2"] = % nml_hsh_onme_2;
  level.scr_face["hesh"]["nml_hsh_sniper12oclockhigh"] = % nml_hsh_sniper12oclockhigh;
  level.scr_anim["generic"]["exposed_dive_grenade_F"] = % exposed_dive_grenade_f;
  level.scr_anim["generic"]["exposed_dive_grenade_B"] = % exposed_dive_grenade_b;
  level.scr_anim["generic"]["active_patrolwalk_gundown"] = % active_patrolwalk_gundown;
  level.scr_anim["generic"]["nml_pipe_jump"] = % nml_pipe_jump;
  level.scr_anim["generic"]["nml_pipe_jump_out"] = % nml_pipe_jump_climbup;
  level.scr_anim["generic"]["nml_pipe_jump_idle"][0] = % nml_pipe_jump_hanging_idle;
  level.scr_anim["generic"]["traverse_over_40_a_iw6"] = % traverse_over_40_a_iw6;
  level.scr_anim["generic"]["traverse_wallhop"] = % traverse_wallhop;
  level.scr_anim["generic"]["hazmat_crouch_geiger_2_run_scared_unarmed"] = % hazmat_crouch_geiger_2_run_scared_unarmed;
  level.scr_anim["generic"]["hazmat_stand_geiger_2_run_scared_unarmed_l_180"] = % hazmat_stand_geiger_2_run_scared_unarmed_l_180;
  level.scr_anim["generic"]["hijack_generic_stumble_stand2"] = % hijack_generic_stumble_stand2;
  level.scr_anim["generic"]["hijack_generic_stumble_crouch2"] = % hijack_generic_stumble_crouch2;
  level.scr_anim["generic"]["flee_run_shoot_behind"] = % flee_run_shoot_behind;
  level.scr_anim["generic"]["run_pain_stomach_stumble"] = % run_pain_stomach_stumble;
  level.scr_anim["generic"]["run_pain_fall"] = % run_pain_fall;
  level.scr_anim["generic"]["AI_attacked_german_shepherd_01_start_a"] = % ai_attacked_german_shepherd_01_start_a;
  level.scr_anim["generic"]["prague_prone_idle"][0] = % prague_prone_idle;
  level.scr_anim["generic"]["NML_mask_pulldown"] = % nml_mask_pulldown;
  level.scr_anim["generic"]["NML_slide_left"] = % nml_slide_left;
  level.scr_anim["generic"]["NML_slide_right"] = % nml_slide_right;
  level.scr_anim["hesh"]["NML_gate_open"] = % nml_gate_open_guy;
  level.scr_anim["generic"]["CQB_stand_signal_stop"] = % cqb_stand_signal_stop;
  level.scr_anim["generic"]["CQB_stand_signal_stop"] = % cqb_stand_signal_stop;
  level.scr_anim["generic"]["combatwalk_F_spin"] = % combatwalk_f_spin;
  level.scr_anim["generic"]["CornerStndR_alert_signal_move_out"] = % cornerstndr_alert_signal_move_out;
  level.scr_anim["generic"]["CornerStndR_alert_signal_on_me"] = % cornerstndr_alert_signal_on_me;
  level.scr_anim["generic"]["stand_exposed_wave_halt"] = % stand_exposed_wave_halt;
  level.scr_anim["generic"]["stand_2_prone"] = % stand_2_prone;
  level.scr_anim["generic"]["crouch_2_prone"] = % crouch_2_prone;
  level.scr_anim["generic"]["prone_2_stand"] = % prone_2_stand;
  level.scr_anim["generic"]["WE_casual_crouch_loop"][0] = % casual_crouch_v2_idle;
  level.scr_anim["generic"]["NML_slide_wolfpack"] = % nml_slide_wolfpack;
  level.scr_anim["hesh"]["stand_exposed_wave_halt"] = % corner_standl_signal_hold;
  level.scr_anim["generic"]["launchfacility_b_vent_drop_R"] = % launchfacility_b_vent_drop_r;
  level.scr_anim["generic"]["london_police_wave"] = % london_police_wave;
  level.scr_anim["generic"]["london_police_wave_1"] = % london_police_wave_1;
  level.scr_anim["generic"]["doorkick_2_cqbwalk"] = % doorkick_2_cqbwalk;
  level.scr_anim["generic"]["corner_standR_trans_CQB_OUT_8"] = % corner_standr_trans_cqb_out_8;
  level.scr_anim["generic"]["cornerSdR_melee_winD_defender"] = % cornersdr_melee_wind_defender;
  level.scr_anim["generic"]["cornerSdR_melee_winD_attacker"] = % cornersdr_melee_wind_attacker;
  maps\_anim::addnotetrack_detach("generic", "detach_knife", "weapon_parabolic_knife", "tag_inhand", "cornerSdR_melee_winD_defender");
  maps\_anim::addnotetrack_attach("generic", "attach_knife", "weapon_parabolic_knife", "tag_inhand", "cornerSdR_melee_winD_defender");
  maps\_anim::addnotetrack_customfunction("generic", "bodyfall large", ::animation_kills_ai, "cornerSdR_melee_winD_attacker");
  level.scr_anim["generic"]["unarmed_cowerstand_react"] = % unarmed_cowerstand_react;
  level.scr_anim["generic"]["unarmed_cowerstand_idle"][0] = % unarmed_cowerstand_idle;
  level.scr_anim["generic"]["unarmed_cowercrouch_idle"][0] = % unarmed_cowercrouch_idle;
  level.scr_anim["generic"]["rescue_pres_run"] = % rescue_pres_run;
  level.scr_anim["victim"]["dog_attack_0"] = % ai_attacked_german_shepherd_01_start_a;
  level.scr_anim["victim"]["dog_attack_1"] = % ai_attacked_german_shepherd_02_idle_a;
  level.scr_anim["victim"]["dog_attack_2"] = % ai_attacked_german_shepherd_03_push_a;
  level.scr_anim["victim"]["dog_attack_3"] = % ai_attacked_german_shepherd_04_middle_a;
  level.scr_anim["victim"]["dog_attack_4"] = % ai_attacked_german_shepherd_05_death_a;
  level.scr_anim["victim"]["dog_attack_kill"] = % iw6_dog_kill_breach_nml_guy;
  level.scr_anim["victim"]["iw6_dog_kill_front"] = % iw6_dog_kill_front_long_guy_1;
  level.scr_anim["generic"]["NML_cliff_walk"] = % nml_cliff_walk;
  level.scr_anim["hesh"]["NML_house_cqb"] = % nml_house_cqb;
  level.scr_anim["generic"]["NML_gate_stop"] = % nml_gate_stop;
  level.scr_anim["generic"]["NML_gate_in"] = % nml_gate_in;
  maps\_anim::addnotetrack_flag("generic", "Hesh_ready", "hesh_ready_to_leave_cave", "NML_gate_in");
  level.scr_anim["generic"]["NML_gate_idle"][0] = % nml_gate_idle;
  level.scr_anim["generic"]["NML_gate_out"] = % nml_gate_out;
  level.scr_anim["generic"]["NML_intro_exit"] = % nml_intro_exit;
  level.scr_anim["generic"]["NML_window_smash"] = % nml_window_smash;
  level.scr_anim["generic"]["NML_window_wait"][0] = % nml_house_breach_guy_start;
  level.scr_anim["generic"]["NML_craterview_idle"][0] = % nml_craterview_idle;
  level.scr_anim["generic"]["NML_craterview_in"] = % nml_craterview_in;
  level.scr_anim["generic"]["NML_craterview_out"] = % nml_craterview_out;
  level.scr_anim["generic"]["patrol_bored_idle_2_scared_idle"] = % patrol_bored_idle_2_scared_idle;
  level.scr_anim["generic"]["scared_idle"][0] = % scared_idle;
  level.scr_anim["generic"]["scared_idle"][1] = % scared_idle_twitch_1;
  level.scr_anim["generic"]["scared_idle"][2] = % scared_idle_twitch_2;
  level.scr_anim["generic"]["scared_idle"][3] = % scared_idle_twitch_3;
  level.scr_anim["generic"]["scared_idle_turn_r_90"] = % scared_idle_turn_r_90;
  level.scr_anim["generic"]["scared_idle_turn_l_90"] = % scared_idle_turn_l_90;
  level.scr_anim["generic"]["scared_idle_turn_180"] = % scared_idle_turn_180;
  level.scr_anim["generic"]["scared_idle_2_scared_walk"] = % scared_idle_2_scared_walk;
  level.scr_anim["generic"]["scared_walk_forward"] = % scared_walk_forward;
  level.scr_anim["generic"]["scared_walk_2_scared_idle"] = % scared_walk_2_scared_idle;
  level.scr_anim["generic"]["patrol_bored_walk_2_scared_idle_turn_180"] = % patrol_bored_walk_2_scared_idle_turn_180;
  level.scr_anim["generic"]["patrol_bored_walk_2_scared_idle_turn_l_90"] = % patrol_bored_walk_2_scared_idle_turn_l_90;
  level.scr_anim["generic"]["patrol_bored_walk_2_scared_idle_turn_r_90"] = % patrol_bored_walk_2_scared_idle_turn_r_90;
  level.scr_anim["generic"]["patrol_bored_walk_2_scared_idle"] = % patrol_bored_walk_2_scared_idle;
  level.scr_anim["generic"]["scared_run"] = % scared_run;
  level.scr_anim["generic"]["patrol_bored_walk_2_scared_run"] = % patrol_bored_walk_2_scared_run;
  level.scr_anim["generic"]["patrol_bored_walk_2_scared_run_turn_r_90"] = % patrol_bored_walk_2_scared_run_turn_r_90;
  level.scr_anim["generic"]["patrol_bored_walk_2_scared_run_turn_l_90"] = % patrol_bored_walk_2_scared_run_turn_l_90;
  level.scr_anim["generic"]["patrol_bored_walk_2_scared_run_turn_180"] = % patrol_bored_walk_2_scared_run_turn_180;
  level.scr_anim["generic"]["hazmat_crouch_2_stand"] = % hazmat_crouch_2_stand_geiger;
  level.scr_anim["generic"]["hazmat_stand_2_crouch"] = % hazmat_stand_2_crouch_geiger;
  level.scr_anim["generic"]["hazmat_crouch_geiger_idle"][0] = % hazmat_crouch_geiger_idle;
  level.scr_anim["generic"]["hazmat_crouch_geiger_idle"][1] = % hazmat_crouch_geiger_idle_twitch_1;
  level.scr_anim["generic"]["hazmat_run"][0] = % hazmat_run;
  level.scr_anim["generic"]["hazmat_run"][1] = % hazmat_run_twitch_1;
  level.scr_anim["generic"]["hazmat_run_2_grab_rifle_180"] = % hazmat_run_2_grab_rifle_180;
  level.scr_anim["generic"]["hazmat_stand_geiger_react"] = % hazmat_stand_geiger_2_run_scared_unarmed;
  level.scr_anim["generic"]["hazmat_stand_geiger_react_B"] = % hazmat_stand_geiger_2_run_scared_unarmed_l_180;
  level.scr_anim["generic"]["hazmat_stand_geiger_react_L"] = % hazmat_stand_geiger_2_run_scared_unarmed_l_90;
  level.scr_anim["generic"]["hazmat_stand_geiger_react_R"] = % hazmat_stand_geiger_2_run_scared_unarmed_r_90;
  level.scr_anim["generic"]["hazmat_crouch_geiger_react"] = % hazmat_crouch_geiger_2_run_scared_unarmed;
  maps\_anim::addnotetrack_detach("generic", "geiger_drop", "nml_geiger_counter", "tag_inhand", "hazmat_stand_geiger_react");
  maps\_anim::addnotetrack_detach("generic", "geiger_drop", "nml_geiger_counter", "tag_inhand", "hazmat_stand_geiger_react_B");
  maps\_anim::addnotetrack_detach("generic", "geiger_drop", "nml_geiger_counter", "tag_inhand", "hazmat_stand_geiger_react_L");
  maps\_anim::addnotetrack_detach("generic", "geiger_drop", "nml_geiger_counter", "tag_inhand", "hazmat_stand_geiger_react_R");
  maps\_anim::addnotetrack_detach("generic", "geiger_drop", "nml_geiger_counter", "tag_inhand", "hazmat_crouch_geiger_react");
  maps\_anim::addnotetrack_customfunction("generic", "geiger_drop", ::drop_geiger_counter, "hazmat_stand_geiger_react");
  maps\_anim::addnotetrack_customfunction("generic", "geiger_drop", ::drop_geiger_counter, "hazmat_stand_geiger_react_B");
  maps\_anim::addnotetrack_customfunction("generic", "geiger_drop", ::drop_geiger_counter, "hazmat_stand_geiger_react_L");
  maps\_anim::addnotetrack_customfunction("generic", "geiger_drop", ::drop_geiger_counter, "hazmat_stand_geiger_react_R");
  level.scr_anim["generic"]["_stealth_patrol_search_a_hazmat"] = % hazmat_curious_walk;
  level.scr_anim["generic"]["_stealth_patrol_search_b_hazmat"] = % hazmat_curious_walk;
  level.scr_anim["generic"]["_stealth_look_around_hazmat"][0] = % hazmat_alerted_idle;
  level.scr_anim["generic"]["_stealth_behavior_generic1_hazmat"] = % hazmat_walk_2_alerted_idle;
  level.scr_anim["generic"]["_stealth_behavior_generic2_hazmat"] = % hazmat_walk_2_alerted_idle;
  level.scr_anim["generic"]["_stealth_behavior_generic3_hazmat"] = % hazmat_walk_2_alerted_idle;
  level.scr_anim["generic"]["_stealth_behavior_generic4_hazmat"] = % hazmat_walk_2_alerted_idle;
  level.scr_anim["generic"]["hazmat_stand_geiger_idle"][0] = % hazmat_stand_geiger_idle;
  level.scr_anim["generic"]["hazmat_stand_geiger_idle"][1] = % hazmat_stand_geiger_idle_twitch_1;
  level.scr_anim["generic"]["hazmat_stand_geiger_idle"][2] = % hazmat_stand_geiger_idle_twitch_2;
  level.scr_anim["generic"]["hazmat_walk_geiger"][0] = % hazmat_walk_geiger;
  level.scr_anim["generic"]["hazmat_walk_geiger_stop"] = % hazmat_walk_geiger_2_stand_geiger;
  level.scr_anim["generic"]["hazmat_walk_geiger_start"] = % hazmat_stand_geiger_2_walk_geiger;
  level.scr_anim["generic"]["patrol_walk_hazmat"][0] = % hazmat_walk_geiger;
  level.scr_anim["generic"]["patrol_idle_hazmat"][0] = % hazmat_stand_geiger_idle;
  level.scr_anim["generic"]["patrol_stop_hazmat"] = % hazmat_walk_geiger_2_stand_geiger;
  level.scr_anim["generic"]["patrol_start_hazmat"] = % hazmat_stand_geiger_2_walk_geiger;
  level.scr_anim["hesh"]["dog_intro"] = % nml_dog_intro_guy;
  level.scr_anim["hesh"]["dog_affection"] = % iw6_dog_affection_guy_1;
  level.scr_goaltime["hesh"]["dog_affection"] = 0.75;
  level.scr_anim["hesh"]["breach_melee"] = % nml_house_breach_guy_end;
  level.scr_anim["victim"]["breach_melee"] = % nml_house_breach_enemy;
  level.scr_anim["hostage"]["vargas_scene"] = % nml_evil_talk_victim;
  level.scr_anim["soldier"]["vargas_scene"] = % nml_evil_talk_guy;
  level.scr_anim["vargas"]["vargas_scene"] = % nml_evil_talk_rourke;
  level.scr_anim["vargas"]["vargas_scene_idle"][0] = % nml_evil_talk_rourke_idle;
  level.scr_anim["hesh"]["dog_drag"] = % iw6_dog_drag_corner_guy_2;
  level.scr_anim["hesh"]["dog_drag_loop"] = % nml_dog_drag_guy_loop;
  level.scr_anim["hesh"]["dog_drag_end"] = % nml_dog_drag_guy_end;
  level.scr_anim["hesh"]["dog_drag_start"] = % nml_dog_drag_guy_start;
  level.scr_anim["hesh"]["merrick_scene"] = % nml_merrick_meetup_hesh;
  maps\_anim::addnotetrack_customfunction("hesh", "start_dsm", ::hesh_show_dsm, "merrick_scene");
  maps\_anim::addnotetrack_customfunction("hesh", "hide_dsm", ::hesh_hide_dsm, "merrick_scene");
  level.scr_anim["keegan"]["merrick_scene"] = % nml_merrick_meetup_keegan;
  level.scr_anim["merrick"]["merrick_scene"] = % nml_merrick_meetup_merrick;
  level.scr_anim["merrick"]["merrick_entrance"] = % nml_wolf_scene_merrick_entrance_merrick;
  vehicles();
  dog();
  animated_props();
  script_model_anims();
  radio();
  flavorbursts();
  player();
  walla();
}

walla() {
  level.scr_sound["generic"]["walla_1_1"] = "nml_saf1_aprensenosestamosalejando";
  level.scr_sound["generic"]["walla_1_2"] = "nml_hmg1_solotenemosquecomprobar";
  level.scr_sound["generic"]["walla_1_3"] = "nml_saf1_puescomprubeloya";
  level.scr_sound["generic"]["walla_2_1"] = "nml_hmg2_hayunleverastro";
  level.scr_sound["generic"]["walla_2_2"] = "nml_hmg1_laagujanose";
  level.scr_sound["generic"]["walla_2_3"] = "nml_saf1_puesasegresenoquiero";
  level.scr_sound["generic"]["walla_3_1"] = "nml_hmg1_aviseporradiodaremos";
  level.scr_sound["generic"]["walla_3_2"] = "nml_hmg2_equipo1aquequipo";
  level.scr_sound["generic"]["walla_3_3"] = "nml_hmg_recibido7yacasi";
  level.scr_sound["generic"]["walla_3_4"] = "nml_hmg2_recibidosietecorto";
  level.scr_sound["generic"]["walla_4_1"] = "nml_saf1_chequeenalltodavano";
  level.scr_sound["generic"]["walla_4_2"] = "nml_hmg1_yatengounalectura";
  level.scr_sound["generic"]["walla_4_3"] = "nml_hmg2_mierdaactengouna";
  level.scr_sound["generic"]["walla_4_4"] = "nml_saf1_nonecesitountraje";
  level.scr_sound["generic"]["walla_4_5"] = "nml_hmg1_tranquiloestacantidadde";
  level.scr_sound["generic"]["walla_4_6"] = "nml_saf1_nosmesiento";
  level.scr_sound["generic"]["walla_4_7"] = "nml_hmg2_casisolotenemosque";
  level.scr_sound["generic"]["walla_4_8"] = "nml_saf1_puesdenseprisaen";
  level.scr_sound["generic"]["walla_4_9"] = "nml_hmg1_nuncahabavistoa";
  level.scr_sound["generic"]["walla_5_1"] = "nml_hmg2_equipo7adelanteequipo";
  level.scr_sound["generic"]["walla_5_2"] = "nml_hmg2_qucoosiacabo";
  level.scr_sound["generic"]["walla_5_3"] = "nml_hmg2_mierdasehabrnalejado";
  level.scr_sound["generic"]["walla_6_1"] = "nml_pmc4_whydidtheconvoy";
  level.scr_sound["generic"]["walla_6_2"] = "nml_fs5_theresatruckup";
  level.scr_sound["generic"]["walla_6_3"] = "nml_pmc4_greatweregonnabe";
  level.scr_sound["generic"]["walla_7_1"] = "nml_saf1_haveyougottenan";
  level.scr_sound["generic"]["walla_7_2"] = "nml_saf2_imwaitingforthem";
  level.scr_sound["generic"]["walla_7_3"] = "nml_saf1_ifyoudonthear";
  level.scr_sound["generic"]["walla_7_4"] = "nml_saf2_yessir";
  level.scr_sound["generic"]["walla_8_1"] = "nml_fs5_whensthenextconvoy";
  level.scr_sound["generic"]["walla_8_2"] = "nml_saf2_30minutes";
  level.scr_sound["generic"]["walla_8_3"] = "nml_fs5_theyarenevergoing";
  level.scr_sound["generic"]["walla_9_1"] = "nml_saf2_whatsthechopperhere";
  level.scr_sound["generic"]["walla_9_2"] = "nml_fs5_dontknowbutit";
  level.scr_sound["generic"]["walla_10_1"] = "nml_pmc4_whatswithallthe";
  level.scr_sound["generic"]["walla_10_2"] = "nml_saf2_dontknowtheymust";
  level.scr_sound["generic"]["walla_11_1"] = "nml_saf1_holdupallstop";
  level.scr_sound["generic"]["walla_11_2"] = "nml_fs5_outpost2report";
  level.scr_sound["generic"]["walla_11_3"] = "nml_pmc4_thisisoutpost2";
  level.scr_sound["generic"]["walla_11_4"] = "nml_saf2_sendanarmoredpersonnel";
  level.scr_sound["generic"]["walla_11_5"] = "nml_pmc4_communicationscheckyou";
  level.scr_sound["generic"]["walla_11_6"] = "nml_saf1_affirmativethisisbravo2";
  level.scr_sound["generic"]["walla_11_7"] = "nml_saf2_weneedamechanic";
  level.scr_sound["generic"]["walla_11_8"] = "nml_pmc4_letsgoletsget";
}

#using_animtree("dog");

dog() {
  level.scr_anim["dog"]["dog_drag_idle"][0] = % iw6_dog_drag_bark_dog_2;
  level.scr_anim["dog"]["dog_drag"] = % iw6_dog_drag_corner_dog_2;
  level.scr_anim["generic"]["dog_alert"][0] = % iw6_dog_alertidle;
  level.scr_anim["generic"]["dog_bark"] = % iw6_dog_attackidle_cam_bark;
  level.scr_anim["generic"]["iw6_dog_sneak_runin_8"] = % iw6_dog_sneak_runin_8;
  level.scr_anim["generic"]["iw6_dog_attackidle_runout_6"] = % iw6_dog_attackidle_runout_6;
  level.scr_anim["generic"]["iw6_dog_attackidle_runout_3"] = % iw6_dog_attackidle_runout_3;
  level.scr_anim["generic"]["iw6_dog_attackidle_runout_8"] = % iw6_dog_attackidle_runout_8;
  level.scr_anim["generic"]["german_shepherd_run_jump_40"] = % iw6_dog_traverse_over_24;
  level.scr_anim["generic"]["german_shepherd_run_jump_window_40"] = % iw6_dog_traverse_over_36;
  level.scr_anim["generic"]["iw6_dog_traverse_over_36"] = % iw6_dog_traverse_over_36;
  level.scr_anim["generic"]["dog_idle"][0] = % iw6_dog_casualidle;
  level.scr_anim["generic"]["dog_sneak_idle"][0] = % iw6_dog_sneakidle;
  level.scr_anim["generic"]["dog_sneak_idle_intro"][0] = % iw6_dog_sneak_idle_intro;
  level.scr_anim["generic"]["dog_sneakidle_2_run"] = % iw6_dog_sneak_idle_2_run;
  level.scr_anim["generic"]["cairo_growl_loop"][0] = % iw6_dog_attackidle_bark;
  level.scr_anim["generic"]["cairo_growl_loop"][1] = % iw6_dog_attackidle;
  level.scr_anim["dog"]["dog_intro"] = % nml_dog_intro_camera;
  level.scr_anim["dog"]["dog_affection"] = % iw6_dog_affection_dog_1;
  level.scr_goaltime["dog"]["dog_affection"] = 0.75;
  level.scr_anim["dog"]["dog_attack_0"] = % german_shepherd_attack_ai_01_start_a;
  level.scr_anim["dog"]["dog_attack_1"] = % german_shepherd_attack_ai_02_idle_a;
  level.scr_anim["dog"]["dog_attack_2"] = % german_shepherd_attack_ai_03_pushed_a;
  level.scr_anim["dog"]["dog_attack_3"] = % german_shepherd_attack_ai_04_middle_a;
  level.scr_anim["dog"]["dog_attack_4"] = % german_shepherd_attack_ai_05_kill_a;
  level.scr_anim["dog"]["iw6_dog_kill_front"] = % iw6_dog_kill_front_long_1;
  level.scr_anim["dog"]["dog_attack_kill"] = % iw6_dog_kill_breach_nml;
  level.scr_anim["generic"]["dog_attack_kill_end"] = % iw6_dog_kill_breach_end_nml;
  level.scr_anim["wolf"]["wolf_death"] = % nml_wolf_scene_death_wolf;
  level.scr_anim["wolf"]["merrick_entrance"] = % nml_wolf_scene_merrick_entrance_wolf;
  level.scr_goaltime["wolf"]["merrick_entrance"] = 0.5;
  level.scr_anim["wolf"]["wolf_takedown"] = % nml_wolf_scene_takedown_wolf;
  level.scr_anim["wolf"]["wolf_struggle"] = % nml_wolf_scene_struggle_wolf;
  level.scr_anim["wolf"]["wolf_struggle_start"] = % nml_wolf_scene_struggle_start_wolf;
  level.scr_anim["wolf"]["wolf_struggle_cycle"] = % nml_wolf_scene_struggle_cycle_wolf;
  level.scr_anim["wolf"]["wolf_struggle_end"] = % nml_wolf_scene_struggle_end_wolf;
  level.scr_anim["wolf"]["wolf_playerdeath"] = % nml_wolf_scene_playerdeath_wolf;
  level.scr_anim["dog"]["wolf_struggle"] = % nml_wolf_scene_struggle_dog;
  level.scr_anim["dog"]["wolf_end"] = % nml_wolf_scene_end_dog;
  level.scr_anim["dog"]["wolf_struggle_end"] = % nml_wolf_scene_struggle_end_dog;
  level.scr_anim["dog"]["dog_drag_start"] = % nml_dog_drag_dog_start;
  level.scr_anim["dog"]["dog_drag_loop"] = % nml_dog_drag_dog_loop;
  level.scr_anim["dog"]["dog_drag_end"] = % nml_dog_drag_dog_end;
  level.scr_anim["generic"]["wolf_walk"] = % nml_wolf_walk;
}

#using_animtree("player");

player() {
  level.scr_anim["player_rig"]["mask_puton"] = % nml_player_mask_on;
  level.scr_anim["player_rig"]["wolf_takedown"] = % nml_wolf_scene_takedown_player;
  level.scr_anim["player_rig"]["wolf_struggle"] = % nml_wolf_scene_struggle_player;
  level.scr_anim["player_rig"]["wolf_struggle_start"] = % nml_wolf_scene_struggle_start_player;
  level.scr_anim["player_rig"]["wolf_struggle_cycle"] = % nml_wolf_scene_struggle_cycle_player;
  level.scr_anim["player_rig"]["wolf_struggle_end"] = % nml_wolf_scene_struggle_end_player;
  level.scr_anim["player_rig"]["wolf_playerdeath"] = % nml_wolf_scene_playerdeath_player;
  level.scr_anim["player_rig"]["wolf_end"] = % nml_wolf_scene_end_player;
  level.scr_anim["player_rig"]["merrick_entrance"] = % nml_wolf_scene_merrick_entrance_player;
  level.scr_anim["player_rig"]["merrick_scene"] = % nml_merrick_meetup_player;
}

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["tank_crush"] = #animtree;
  level.scr_anim["truck"]["tank_crush"] = % sedan_tankcrush_side;
  level.scr_anim["tank"]["tank_crush"] = % tank_tankcrush_side;
  level.scr_sound["tank_crush"] = "scn_nml_tank_crush_car";
  level._vehicle_effect["tankcrush"]["window_med"] = loadfx("fx/props/car_glass_med");
  level._vehicle_effect["tankcrush"]["window_large"] = loadfx("fx/props/car_glass_large");
  level.scr_animtree["crane"] = #animtree;
  level.scr_anim["crane"]["mall_crane_idle"][0] = % nml_crane_idle_sway;
  level.scr_anim["crane"]["mall_crane_idle_out"][0] = % nml_crane_idle_out;
  level.scr_anim["crane"]["mall_crane_move"] = % nml_crane_move;
  level.scr_anim["crane"]["mall_crane_move_out"] = % nml_crane_move_out;
  level.scr_anim["crane"]["sat_crane_hold_up"][0] = % nml_crane_holdup;
}

#using_animtree("animated_props");

animated_props() {
  level.scr_animtree["grass"] = #animtree;
  level.scr_anim["grass"]["sway"] = % nml_grass_anim;
}

#using_animtree("script_model");

script_model_anims() {
  level.scr_model["pistol"] = "viewmodel_p226";
  level.scr_animtree["pistol"] = #animtree;
  level.scr_anim["pistol"]["wolf_struggle_end"] = % nml_wolf_scene_struggle_end_pistol;
  level.scr_model["dsm"] = "mil_wireless_dsm_small";
  level.scr_animtree["dsm"] = #animtree;
  level.scr_anim["dsm"]["merrick_scene"] = % nml_merrick_meetup_dsm;
  level.scr_model["rifle"] = "weapon_mts_255_small";
  level.scr_animtree["rifle"] = #animtree;
  level.scr_anim["rifle"]["NML_house_cqb"] = % nml_house_cqb_gun;
  level.scr_animtree["gun"] = #animtree;
  level.scr_anim["gun"]["hazmat_run_2_grab_rifle_180"] = % hazmat_rifle_run_2_grab_rifle_180;
  level.scr_model["crate"] = "tag_origin";
  level.scr_animtree["crate"] = #animtree;
  level.scr_anim["crate"]["mall_crane_idle"][0] = % nml_container_idle_sway;
  level.scr_anim["crate"]["mall_crane_move"] = % nml_container_move;
  level.scr_model["gate"] = "tag_origin";
  level.scr_animtree["gate"] = #animtree;
  level.scr_anim["gate"]["NML_gate_open"] = % nml_gate_open_gate;
  level.scr_animtree["church_cliff"] = #animtree;
  level.scr_anim["church_cliff"]["collapse"] = % vfx_nml_church_cliff_anim;
  level.scr_anim["church_piece_0"]["collapse"] = % vfx_nml_church_collapse0_anim;
  level.scr_anim["church_piece_1"]["collapse"] = % vfx_nml_church_collapse1_anim;
  level.scr_anim["church_piece_2"]["collapse"] = % vfx_nml_church_collapse2_anim;
  level.scr_anim["church_piece_3"]["collapse"] = % vfx_nml_church_collapse3_anim;
  level.scr_anim["church_piece_4"]["collapse"] = % vfx_nml_church_collapse4_anim;
  level.scr_anim["church_piece_5"]["collapse"] = % vfx_nml_church_collapse5_anim;
  level.scr_anim["church_piece_6"]["collapse"] = % vfx_nml_church_collapse6_anim;
  level.scr_anim["church_piece_7"]["collapse"] = % vfx_nml_church_collapse7_anim;
  level.scr_anim["church_piece_8"]["collapse"] = % vfx_nml_church_collapse8_anim;
  level.scr_anim["church_piece_9"]["collapse"] = % vfx_nml_church_collapse9_anim;
  level.scr_anim["church_piece_10"]["collapse"] = % vfx_nml_church_collapse10_anim;
  level.scr_anim["church_piece_11"]["collapse"] = % vfx_nml_church_collapse11_anim;
  level.scr_anim["church_piece_12"]["collapse"] = % vfx_nml_church_collapse12_anim;
  level.scr_anim["church_piece_13"]["collapse"] = % vfx_nml_church_collapse13_anim;
  level.scr_anim["church_piece_14"]["collapse"] = % vfx_nml_church_collapse14_anim;
  level.scr_anim["church_piece_15"]["collapse"] = % vfx_nml_church_collapse15_anim;
}

radio() {}

flavorbursts() {
  level.scr_enemy_bursts = [];
  level.scr_enemy_bursts[level.scr_enemy_bursts.size] = "nml_safr_salvageteametato";
  level.scr_enemy_bursts[level.scr_enemy_bursts.size] = "nml_safr_lookslikeuhhzerosurvivors";
  level.scr_enemy_bursts[level.scr_enemy_bursts.size] = "nml_safr_maintainsweepchutes";
  level.scr_enemy_bursts[level.scr_enemy_bursts.size] = "nml_safr_standbyforrules";
  level.scr_enemy_bursts[level.scr_enemy_bursts.size] = "nml_safr_team2reportingzero";
  level.scr_enemy_bursts[level.scr_enemy_bursts.size] = "nml_safr_team3hasrecovered";
  level.scr_enemy_bursts[level.scr_enemy_bursts.size] = "nml_safr_primarytargetrecoveredall";
}

animation_kills_ai(var_0) {
  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield)
    maps\_utility::stop_magic_bullet_shield();

  var_0 notify("animation_killed_me");
  wait 0.05;
  var_0.a.nodeath = 1;
  var_0.allowpain = 1;
  var_0.allowdeath = 1;
  var_0 kill();
}

drop_geiger_counter(var_0) {
  var_0 notify("geiger_drop");
  var_1 = "tag_inhand";
  var_2 = var_0 gettagorigin(var_1);
  var_3 = var_0 gettagangles(var_1);
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;

  if(isDefined(var_0.geiger_sound_source))
    var_0.geiger_sound_source stopsounds();

  var_4 setModel("nml_geiger_counter");
  var_4 physicslaunchclient(var_4.origin, (0, 0, 0));
  wait 10;
  var_4 delete();
}

hesh_show_dsm(var_0) {
  if(isDefined(var_0.dsm))
    var_0.dsm show();
}

hesh_hide_dsm(var_0) {
  if(isDefined(var_0.dsm))
    var_0.dsm delete();
}