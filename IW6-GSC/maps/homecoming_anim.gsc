/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\homecoming_anim.gsc
*****************************************************/

main() {
  generic_human();
  player();
  dog();
  vehicles();
  script_model();
  dialog();
}

#using_animtree("generic_human");

generic_human() {
  thread generic_human_intro();
  thread generic_human_beach();
  thread generic_human_recruits();
  level.scr_anim["generic"]["combat_jog"] = % combat_jog;
  level.scr_anim["generic"]["scared_run"] = % scared_run;
  level.scr_anim["generic"]["jump_down_56"] = % traverse_jumpdown_56_iw6;
  level.scr_anim["generic"]["paris_npc_dead_poses_v06"] = % paris_npc_dead_poses_v06;
  level.scr_anim["generic"]["paris_npc_dead_poses_v08"] = % paris_npc_dead_poses_v08;
  level.scr_anim["generic"]["paris_npc_dead_poses_v17"] = % paris_npc_dead_poses_v17;
  level.scr_anim["generic"]["paris_npc_dead_poses_v19"] = % paris_npc_dead_poses_v19;
  level.scr_anim["generic"]["paris_npc_dead_poses_v22"] = % paris_npc_dead_poses_v22;
  level.scr_anim["generic"]["paris_npc_dead_poses_v23"] = % paris_npc_dead_poses_v23;
  level.scr_anim["generic"]["stand_gunner_idle"] = % saw_gunner_aim_level_center;
  level.drone_anims["allies"]["stand"]["sprint"] = % sprint_loop_distant_relative;
  level.drone_anims["allies"]["stand"]["run_n_gun"] = % run_n_gun_f_relative;
  level.drone_anims["allies"]["stand"]["cqb"] = % walk_cqb_f_relative;
  level.drone_anims["axis"]["stand"]["sprint"] = % sprint_loop_distant_relative;
  level.drone_anims["axis"]["stand"]["run_n_gun"] = % run_n_gun_f_relative;
  level.drone_anims["axis"]["stand"]["cqb"] = % walk_cqb_f_relative;
  level.drone_anims["axis"]["traverse"]["traverse_jumpdown_56"] = % traverse_jumpdown_56;
  level.drone_anims["axis"]["traverse"]["traverse_jumpdown_96"] = % traverse_jumpdown_96;
  level.drone_anims["allies"]["stand"]["run2"] = % iw6_run_1_relative;
  level.drone_anims["allies"]["stand"]["run3"] = % iw6_run_2_relative;
  level.drone_anims["allies"]["stand"]["run4"] = % iw6_run_3_relative;
  level.drone_anims["allies"]["stand"]["run5"] = % iw6_run_4_relative;
  level.scr_anim["generic"]["traverse_stepup_52"] = % traverse_stepup_52_fast;
  level.scr_anim["generic"]["traverse_jumpdown_72_iw6"] = % traverse_jumpdown_72_iw6;
  level.scr_anim["generic"]["traverse_jumpdown_88_iw6"] = % traverse_jumpdown_88_iw6;
  level.scr_anim["generic"]["drone_hesco_stepup"] = % traverse_stepup_52;
  level.scr_anim["generic"]["traverse_wallhop"] = % traverse_wallhop;
  level.scr_anim["generic"]["drone_death_tumbleback"] = % stand_death_tumbleback;
  level.scr_anim["generic"]["drone_death_slowfall"] = % stand_death_headshot_slowfall;
  level.scr_anim["generic"]["drone_death_shoulderback"] = % stand_death_shoulderback;
  maps\_anim::addnotetrack_customfunction("generic", "start_ragdoll", ::die_and_ragdoll, "drone_death_tumbleback");
  maps\_anim::addnotetrack_customfunction("generic", "start_ragdoll", ::die_and_ragdoll, "drone_death_slowfall");
  maps\_anim::addnotetrack_customfunction("generic", "start_ragdoll", ::die_and_ragdoll, "drone_death_shoulderback");
  level.scr_anim["generic"]["coverstand_hide_idle"][0] = % coverstand_hide_idle;
  level.scr_anim["generic"]["coverstand_hide_idle"][1] = % coverstand_look_quick;
  level.scr_anim["generic"]["coverstand_hide_idle"][2] = % coverstand_look_quick_v2;
  level.scr_anim["generic"]["coverstand_hide_idle"][3] = % coverstand_hide_idle_twitch04;
  level.scr_anim["generic"]["coverstand_hide_idle"][4] = % coverstand_hide_idle_twitch05;
  level.scr_anim["generic"]["coverstand_hide_2_aim"] = % coverstand_hide_2_aim;
  level.scr_anim["generic"]["coverstand_aim_2_hide"] = % coverstand_aim_2_hide;
  level.scr_anim["generic"]["coverstand_reload"] = % coverstand_reloada;
  level.scr_anim["generic"]["coverstand_aim"][0] = % exposed_aim_5;
}

generic_human_intro() {
  common_scripts\utility::flag_wait("homecoming_transient_intro_tr_loaded");
  level.scr_anim["dog_guy"]["dog_pass_off_start"] = % homecoming_dog_pass_off_guy_intro;
  level.scr_anim["dog_guy"]["dog_pass_off_start_idle"][0] = % homecoming_dog_pass_off_guy_idlea;
  level.scr_anim["dog_guy"]["dog_pass_off"] = % homecoming_dog_pass_off_guy;
  level.scr_anim["dog_guy"]["dog_pass_off_idle"][0] = % homecoming_dog_pass_off_guy_idleb;
  maps\_anim::addnotetrack_flag("dog_guy", "hesh_start", "FLAG_intro_hesh_start", "dog_pass_off");
  level.scr_anim["hesh"]["dog_pass_off"] = % homecoming_dog_pass_off_hesh;
  maps\_anim::addnotetrack_flag("hesh", "guy_start", "FLAG_intro_handler_start", "dog_pass_off");
  maps\_anim::addnotetrack_flag("hesh", "dog_start", "FLAG_intro_dog_start", "dog_pass_off");
  maps\_anim::addnotetrack_flag("hesh", "ps_homcom_hsh_takecairoandhead", "FLAG_nh90_ranger_dialog_done", "dog_pass_off");
  maps\_anim::addnotetrack_flag("hesh", "ps_homcom_hsh_angrygrunthowcan", "FLAG_nh90_hesh_last_line", "dog_pass_off");
  level.scr_anim["generic"]["readystand_idle"][0] = % readystand_idle;
  level.scr_anim["generic"]["run_trans_2_readystand_2"] = % run_trans_2_readystand_2;
  level.scr_anim["generic"]["readystand_trans_2_run_1"] = % readystand_trans_2_run_1;
  level.scr_anim["generic"]["readystand_trans_2_run_2"] = % readystand_trans_2_run_2;
  level.scr_anim["generic"]["bm21_guy3_idle"][0] = % bm21_guy3_idle;
  level.scr_anim["generic"]["bm21_guy3_climbout"] = % bm21_guy3_climbout;
  level.scr_anim["generic"]["bm21_guy_climbout_landing"] = % bm21_guy_climbout_landing;
  level.scr_anim["generic"]["HC_wounded_A"][0] = % hc_wounded_a;
  level.scr_anim["generic"]["HC_wounded_B"][0] = % hc_wounded_b;
  level.scr_anim["generic"]["HC_wounded_C"][0] = % hc_wounded_c;
  level.scr_anim["generic"]["HC_wounded_D"][0] = % hc_wounded_d;
  level.scr_anim["generic"]["cliffhanger_welder_wing"][0] = % cliffhanger_welder_wing;
  maps\_anim::addnotetrack_customfunction("generic", "spark on", ::welding_start, "cliffhanger_welder_wing");
  maps\_anim::addnotetrack_customfunction("generic", "spark off", ::welding_stop, "cliffhanger_welder_wing");
  level.scr_anim["generic"]["DC_Burning_stop_bleeding_medic"] = % dc_burning_stop_bleeding_medic;
  level.scr_anim["generic"]["DC_Burning_CPR_medic_endidle"][0] = % dc_burning_cpr_medic_endidle;
  level.scr_anim["generic"]["DC_Burning_CPR_medic"] = % dc_burning_cpr_medic;
  maps\_anim::addnotetrack_attach("generic", "attach prop", "adrenaline_syringe_animated", "TAG_INHAND", "DC_Burning_CPR_medic");
  maps\_anim::addnotetrack_detach("generic", "dettach prop", "adrenaline_syringe_animated", "TAG_INHAND", "DC_Burning_CPR_medic");
  level.scr_anim["generic"]["DC_Burning_CPR_wounded"] = % dc_burning_cpr_wounded;
  level.scr_anim["generic"]["cpr_run"] = % homecoming_cpr_run;
  level.scr_anim["generic"]["wounded_carry_carrier"] = % wounded_carry_fastwalk_carrier;
  level.scr_anim["generic"]["wounded_carry_wounded"][0] = % wounded_carry_fastwalk_wounded_relative;
  level.scr_anim["generic"]["wounded_carry_putdown_carrier"] = % dc_burning_wounded_carry_putdown_carrier;
  level.scr_anim["generic"]["wounded_carry_putdown_wounded"] = % dc_burning_wounded_carry_putdown_wounded;
  level.scr_anim["generic"]["wounded_carry_idle_carrier"][0] = % dc_burning_wounded_carry_idle_carrier;
  level.scr_anim["generic"]["wounded_carry_idle_wounded"][0] = % dc_burning_wounded_carry_idle_wounded;
  level.scr_anim["generic"]["hurt_sitting_wounded_loop"][0] = % clockwork_chaos_enemy_help_loop1_guard;
  level.scr_anim["generic"]["help_hurt_sitting_wounded"] = % clockwork_chaos_enemy_help_guard;
  level.scr_anim["generic"]["help_hurt_sitting_helper"] = % clockwork_chaos_enemy_help_guard2;
  level.scr_anim["generic"]["help_hurt_sitting_wounded_loop"][0] = % clockwork_chaos_enemy_help_loop2_guard;
  level.scr_anim["generic"]["help_hurt_sitting_helper_loop"][0] = % clockwork_chaos_enemy_help_loop2_guard2;
  level.scr_anim["generic"]["roadkill_cover_radio_soldier2"][0] = % roadkill_cover_radio_soldier2;
  level.scr_anim["wire_puller"]["wire_pull"] = % armada_wire_setup_guy;
  level.scr_anim["generic"]["clockwork_chaos_wave_guard"][0] = % clockwork_chaos_wave_guard;
  level.scr_anim["generic"]["patrol_jog_orders_once"] = % patrol_jog_orders_once;
  level.scr_anim["generic"]["payback_escape_forward_wave_right_price"] = % payback_escape_forward_wave_right_price;
  level.scr_anim["generic"]["covercrouch_hide_idle"][0] = % covercrouch_hide_idle;
  level.scr_anim["generic"]["covercrouch_run_out_M"] = % covercrouch_run_out_m;
  level.scr_anim["generic"]["crouch_2run_F"] = % crouch_2run_f;
  level.scr_anim["generic"]["combatwalk_f_spin"] = % combatwalk_f_spin;
  level.scr_anim["generic"]["dh_food_server"][0] = % dh_food_server;
  level.scr_anim["generic"]["hc_yelling_guard_A"][0] = % hc_yelling_guard_a;
  level.scr_anim["generic"]["hc_yelling_guard_B"][0] = % hc_yelling_guard_b;
  level.scr_anim["generic"]["wall_stumble"] = % dc_burning_bunker_stumble;
  level.scr_anim["generic"]["wall_stumble_idle"][0] = % dc_burning_bunker_sit_idle;
  level.scr_anim["secondary_gunner"]["bunker_mg_scene"] = % hc_machine_gunner_a;
  maps\_anim::addnotetrack_flag("secondary_gunner", "point", "FLAG_balcony_secondary_gunner_point", "bunker_mg_scene");
  level.scr_anim["primary_gunner"]["bunker_mg_scene"] = % hc_machine_gunner_b;
  maps\_anim::addnotetrack_flag("primary_gunner", "gunner_hit", "FLAG_balcony_gunner_hit", "bunker_mg_scene");
  level.scr_anim["generic"]["balcony_run"] = % hc_getto_balcony_run;
  level.scr_anim["generic"]["artillery_death_1"] = % death_explosion_stand_b_v1;
  level.scr_anim["generic"]["artillery_death_2"] = % death_explosion_stand_b_v3;
  level.scr_anim["generic"]["artillery_death_3"] = % death_explosion_stand_b_v4;
  level.scr_anim["hesh"]["balcony_stumble"] = % homecoming_balcony_tremor_reaction_a;
  level.scr_anim["ranger1"]["balcony_stumble"] = % homecoming_balcony_tremor_reaction_b;
  level.scr_anim["ranger2"]["balcony_stumble"] = % homecoming_balcony_tremor_reaction_c;
  level.scr_anim["secondary_gunner"]["balcony_stumble"] = % homecoming_balcony_tremor_reaction_d;
  level.scr_anim["generic"]["balcony_stumble_short_0"] = % teargas_react_1;
  level.scr_anim["generic"]["balcony_stumble_short_1"] = % teargas_react_2;
  level.scr_anim["generic"]["balcony_stumble_short_2"] = % teargas_react_3;
  level.scr_anim["generic"]["balcony_stumble_short_3"] = % teargas_react_4;
}

generic_human_beach() {
  common_scripts\utility::flag_wait("homecoming_transient_beach_tr_loaded");
  level.scr_anim["hesh"]["balcony_hesh_wave"] = % payback_escape_forward_wave_right_price;
  level.scr_anim["generic"]["teargas_recover_2"] = % teargas_recover_2;
  level.scr_anim["generic"]["artemis_getin"] = % artemis_enter_r;
  level.scr_anim["generic"]["artemis_loop"][0] = % artemis_idle;
  level.scr_anim["generic"]["artemis_loop"][1] = % artemis_twitch_a;
  level.scr_anim["generic"]["artemis_loop"][2] = % artemis_twitch_b;
  level.scr_anim["generic"]["artemis_loop"][3] = % artemis_twitch_c;
  level.scr_anim["generic"]["hovercraft_stumble_walk_1"] = % homecoming_hovercraft_reaction_a_run;
  level.scr_anim["generic"]["hovercraft_stumble_walk_2"] = % homecoming_hovercraft_reaction_b_run;
  level.scr_anim["generic"]["hovercraft_stumble_walk_3"] = % homecoming_hovercraft_reaction_c_run;
  level.scr_anim["hesh"]["tower_hesh_wave"] = % payback_escape_forward_wave_right_price;
  level.scr_anim["generic"]["run_pain_stomach_stumble"] = % run_pain_stomach_stumble;
  level.scr_anim["generic"]["run_pain_leg"] = % run_pain_leg;
  level.scr_anim["generic"]["tower_pickup_wounded_idle"][0] = % hc_wounded_pickup_guy1_idle;
  level.scr_anim["generic"]["tower_pickup_wounded"] = % hc_wounded_pickup_guy1;
  level.scr_anim["generic"]["tower_pickup_soldier"] = % hc_wounded_pickup_guy;
  level.scr_anim["wounded"]["tower_pickup_b_wounded_idle"][0] = % hc_wounded_pickup_guy1_idle_b;
  level.scr_anim["wounded"]["tower_pickup_b"] = % hc_wounded_pickup_guy1_b;
  level.scr_anim["helper"]["tower_pickup_b"] = % hc_wounded_pickup_guy_b;
  level.scr_anim["generic"]["tower_explosion_death"] = % death_explosion_stand_f_v3;
  level.scr_anim["cougher"]["tower_coughing_death"] = % london_gas_hero_death_3;
  level.scr_anim["firefighter"]["extinguisher_loop"][0] = % blackice_engineroom_firefighter1_idle;
  level.scr_anim["firefighter"]["extinguisher_out"] = % blackice_engineroom_firefighter1;
  level.scr_anim["generic"]["run_react_stumble_non_loop"] = % run_react_stumble_non_loop;
  level.scr_anim["generic"]["payback_escape_forward_wave_right_price"] = % payback_escape_forward_wave_right_price;
  level.scr_anim["hesh"]["dog_affection_guy"] = % iw6_dog_affection_guy_1;
  level.scr_anim["generic"]["hesh_dog_reunite_corner"] = % vegas_raid_enemy_aware2;
  level.scr_anim["generic"]["ladder_climbon"] = % ladder_climbon;
  level.scr_anim["generic"]["ladder_slide"] = % scout_sniper_ladder_slide;
  level.scr_anim["generic"]["flee_run_shoot_behind"] = % flee_run_shoot_behind;
  level.scr_anim["generic"]["run_death_roll"] = % run_death_roll_02;
  level.scr_anim["dragger"]["elias_street_drag_wounded_drag"] = % airport_civ_dying_groupb_pull;
  level.scr_anim["dragger"]["elias_street_drag_wounded_death"] = % airport_civ_dying_groupb_pull_death;
  level.scr_anim["wounded"]["elias_street_drag_wounded_drag"] = % airport_civ_dying_groupb_wounded;
  level.scr_anim["wounded"]["elias_street_drag_wounded_death"] = % airport_civ_dying_groupb_wounded_death;
  level.scr_anim["generic"]["airport_security_guard_pillar_death_R"] = % airport_security_guard_pillar_death_r;
  level.scr_anim["hesh"]["elias_garage_lift"] = % homecoming_garage_door_open;
  maps\_anim::addnotetrack_customfunction("hesh", "garage_open", ::street_garage_door_open, "elias_garage_lift");
  level.scr_anim["hesh"]["elias_garage_idle"][0] = % homecoming_garage_door_idle;
  level.scr_anim["hesh"]["elias_garage_idle"][1] = % homecoming_garage_door_twitch;
  level.scr_anim["hesh"]["elias_garage_thru"] = % homecoming_garage_door_close;
  maps\_anim::addnotetrack_customfunction("hesh", "ps_homcom_hsh_adamwehaveto", ::street_garage_door_dialogue, "elias_garage_thru");
  level.scr_anim["hesh"]["elais_house_blocker_in"] = % homecoming_fire_blocker_in;
  level.scr_anim["hesh"]["elais_house_blocker_idle"][0] = % homecoming_fire_blocker_idle;
  level.scr_anim["hesh"]["elais_house_blocker_out"] = % homecoming_fire_blocker_out;
  level.scr_anim["elite"]["house_attack_grab"] = % homecoming_house_attack_enemy;
  level.scr_anim["elite"]["house_attack_knife"] = % homecoming_house_knife_enemy;
  level.scr_anim["elite"]["house_attack_knife_fail"] = % homecoming_house_fail_enemy;
  level.scr_anim["elite"]["house_attack_save"] = % homecoming_house_save_enemy;
  level.scr_anim["hesh"]["house_attack_save"] = % homecoming_house_save_ally;
  maps\_anim::addnotetrack_customfunction("hesh", "start_fire", ::house_attack_hesh_fire, "house_attack_save");
  maps\_anim::addnotetrack_notify("hesh", "stop_fire", "house_attack_stop_fire", "house_attack_save");
  level.scr_anim["merrick"]["house_attack_save"] = % homecoming_house_save_allya;
  level.scr_anim["keegan"]["house_attack_save"] = % homecoming_house_save_allyb;
}

generic_human_recruits() {
  common_scripts\utility::flag_wait("homecoming_transient_recruits_tr_loaded");
  level.scr_anim["elias"]["recruit_pt1"] = % hc_recruit_elias_part1;
  level.scr_anim["elias"]["recruit_pt2"] = % hc_recruit_elias;
  level.scr_anim["hesh"]["recruit"] = % hc_recruit_hesh;
  level.scr_anim["merrick"]["recruit"] = % hc_recruit_merrick;
  level.scr_anim["keagan"]["recruit"] = % hc_recruit_keagan;
  level.scr_anim["pilot"]["sitting_idle_pilot"][0] = % helicopter_pilot2_twitch_lookoutside;
  maps\_anim::addnotetrack_customfunction("elias", "vo_homcom_els_hewasoneof", ::recruits_start_fade_out, "recruit_pt2");
}

#using_animtree("player");

player() {
  thread player_intro();
  thread player_beach();
  thread player_recruits();
  level.scr_animtree["player_rig"] = #animtree;
  level.scr_model["player_rig"] = "viewhands_player_us_rangers";
}

player_intro() {
  common_scripts\utility::flag_wait("homecoming_transient_intro_tr_loaded");
  level.scr_anim["player_rig"]["intro_chopper_idle"][0] = % hc_chopper_intro_player_idle;
  level.scr_anim["player_rig"]["intro_chopper_letgo"] = % hc_chopper_intro_player_end;
  level.scr_anim["player_rig"]["bunker_balcony_collapse"] = % jungle_ghost_wf_escape_jumpoff_player;
}

player_beach() {
  common_scripts\utility::flag_wait("homecoming_transient_beach_tr_loaded");
  level.scr_anim["player_rig"]["house_attack_grab"] = % homecoming_house_attack_player;
  maps\_anim::addnotetrack_flag("player_rig", "wall_impact", "FLAG_house_attack_through_wall", "house_attack_grab");
  level.scr_anim["player_rig"]["house_attack_knife"] = % homecoming_house_knife_player;
  maps\_anim::addnotetrack_flag("player_rig", "knife_enter", "FLAG_attacker_killing_player", "house_attack_knife");
  level.scr_anim["player_rig"]["house_attack_knife_fail"] = % homecoming_house_fail_player;
  maps\_anim::addnotetrack_flag("player_rig", "knife_kill", "FLAG_attack_fail_kill_player", "house_attack_knife_fail");
  level.scr_anim["player_rig"]["house_attack_save"] = % homecoming_house_save_player;
  maps\_anim::addnotetrack_flag("player_rig", "heli_flyover", "FLAG_house_attack_heli_over", "house_attack_save");
  maps\_anim::addnotetrack_flag("player_rig", "ghosts_enter", "FLAG_house_attack_ghosts_enter", "house_attack_save");
  maps\_anim::addnotetrack_customfunction("player_rig", "ceiling_slowmo", ::house_ghost_slowmo, "house_attack_save");
}

player_recruits() {
  common_scripts\utility::flag_wait("homecoming_transient_recruits_tr_loaded");
  level.scr_anim["player_rig"]["recruit"] = % hc_recruit_player_new;
  level.scr_anim["player_rig"]["player_sway_static"] = % sw_player_sway_static;
  level.scr_anim["player_rig"]["player_wind_static"] = % sw_player_wind_static;
  level.scr_anim["player_rig"]["player_nosway_static"] = % sw_player_nosway_static;
  maps\_anim::addnotetrack_customfunction("player_rig", "player_control_given", ::player_control_given);
}

#using_animtree("dog");

dog() {
  thread dog_intro();
  thread dog_beach();
  thread dog_recruit();
  level.scr_anim["generic"]["iw6_dog_casualidle_runin_8"] = % iw6_dog_run;
  level.scr_anim["dog"]["casualidle"][0] = % iw6_dog_casualidle;
  level.scr_anim["dog"]["run"] = % iw6_dog_run;
}

dog_intro() {
  common_scripts\utility::flag_wait("homecoming_transient_intro_tr_loaded");
  level.scr_anim["dog"]["intro_chopper_idle"][0] = % iw6_dog_casualidle;
  level.scr_anim["dog"]["intro_chopper_letgo"] = % iw6_dog_traverse_down_40;
  level.scr_anim["dog"]["dog_pass_off"] = % homecoming_dog_pass_off_dog;
  level.scr_anim["dog"]["dog_pass_off_idle"][0] = % homecoming_dog_pass_off_dog_idle;
}

dog_beach() {
  common_scripts\utility::flag_wait("homecoming_transient_beach_tr_loaded");
  level.scr_anim["dog"]["attackidle_bark"][0] = % iw6_dog_attackidle_bark;
  level.scr_anim["dog"]["dog_affection_dog"] = % iw6_dog_affection_dog_1;
  level.scr_anim["dog"]["dog_scratch_door"] = % german_shepherd_scratch_door;
  level.scr_anim["dog"]["dog_hop_1"] = % iw6_dog_happyhop_1;
  level.scr_anim["dog"]["dog_hop_2"] = % iw6_dog_happyhop_2;
  level.scr_anim["dog"]["house_attack_grab"] = % homecoming_house_attack_dog;
  maps\_anim::addnotetrack_flag("dog", "dog_slowmo_end", "FLAG_stop_house_attack_slowmo", "house_attack_grab");
  maps\_anim::addnotetrack_sound("dog", "dog_hit", "house_attack_grab", "scn_home_end_dog_hurt");
}

dog_recruit() {
  common_scripts\utility::flag_wait("homecoming_transient_recruits_tr_loaded");
  level.scr_animtree["riley"] = #animtree;
  level.scr_anim["riley"]["recruit"] = % hc_recruit_riley;
  level.scr_model["riley"] = "fullbody_dog_a";
  maps\_anim::addnotetrack_customfunction("riley", "boom_1", maps\homecoming_recruits_util::heli_shake);
  maps\_anim::addnotetrack_customfunction("riley", "boom_2", maps\homecoming_recruits_util::heli_shake);
  maps\_anim::addnotetrack_customfunction("riley", "fade_start", ::notetrack_func_fade_to_black);
  maps\_anim::addnotetrack_notify("riley", "fade_end", "notify_fade_end");
}

#using_animtree("vehicles");

vehicles() {
  level.scr_animtree["tank"] = #animtree;
  level.scr_anim["generic"]["lcac_tank_exit_01"] = % lcac_tank_exit_01;
  level.scr_anim["generic"]["lcac_tank_exit_02"] = % lcac_tank_exit_02;
}

script_model() {
  thread script_model_intro();
  thread script_model_beach();
  thread script_model_recruits();
  thread flare_rig_anims();
}

#using_animtree("script_model");

script_model_intro() {
  common_scripts\utility::flag_wait("homecoming_transient_intro_tr_loaded");
  level.scr_animtree["barbed_wire"] = #animtree;
  level.scr_model["barbed_wire"] = "mil_razorwire_long";
  level.scr_anim["barbed_wire"]["wire_pull"] = % armada_wire_setup_wire;
}

script_model_beach() {
  common_scripts\utility::flag_wait("homecoming_transient_beach_tr_loaded");
  level.scr_anim["tower"]["airport_tower_cg_exp1_anim"] = % airport_tower_cg_exp1_anim;
  level.scr_anim["tower"]["airport_tower_cg_exp2_anim"] = % airport_tower_cg_exp2_anim;
  level.scr_anim["tower"]["airport_tower_exp2_anim"] = % airport_tower_exp2_anim;
  level.scr_anim["tower"]["airport_tower_exp3_anim"] = % airport_tower_exp3_anim;
  level.scr_anim["tower"]["airport_tower_exp4_anim"] = % airport_tower_exp4_anim;
  level.scr_anim["tower"]["airport_tower_exp5_anim"] = % airport_tower_exp5_anim;
  level.scr_anim["tower"]["airport_tower_exp6_anim"] = % airport_tower_exp6_anim;
  level.scr_anim["tower"]["airport_tower_exp7_anim"] = % airport_tower_exp7_anim;
  level.scr_anim["tower"]["airport_tower_exp8_anim"] = % airport_tower_exp8_anim;
  level.scr_anim["tower"]["airport_tower_exp9_anim"] = % airport_tower_exp9_anim;
  level.scr_anim["tower"]["airport_tower_exp10_anim"] = % airport_tower_exp10_anim;
  level.scr_anim["tower"]["airport_tower_exp11_anim"] = % airport_tower_exp11_anim;
  level.scr_animtree["extinguisher"] = #animtree;
  level.scr_model["extinguisher"] = "com_fire_extinguisher_anim";
  level.scr_anim["extinguisher"]["extinguisher_loop"][0] = % blackice_engineroom_firefighter1_ext_idle;
  level.scr_anim["extinguisher"]["extinguisher_out"] = % blackice_engineroom_firefighter1_ext;
  level.scr_animtree["blocker"] = #animtree;
  level.scr_model["blocker"] = "tag_origin";
  level.scr_anim["blocker"]["elais_house_blocker_in"] = % homecoming_fire_blocker_in_debirs;
  level.scr_anim["blocker"]["elais_house_blocker_idle"][0] = % homecoming_fire_blocker_idle_debirs;
  level.scr_anim["blocker"]["elais_house_blocker_out"] = % homecoming_fire_blocker_out_debirs;
  level.scr_animtree["rope1"] = #animtree;
  level.scr_model["rope1"] = "cliffhanger_rope_100ft";
  level.scr_anim["rope1"]["house_attack_save"] = % homecoming_house_save_allya_rope;
  level.scr_animtree["rope2"] = #animtree;
  level.scr_model["rope2"] = "cliffhanger_rope_100ft";
  level.scr_anim["rope2"]["house_attack_save"] = % homecoming_house_save_allyb_rope;
}

script_model_recruits() {
  common_scripts\utility::flag_wait("homecoming_transient_recruits_tr_loaded");
  level.scr_animtree["elias_mask"] = #animtree;
  level.scr_model["elias_mask"] = "elias_stealth_head_mask";
  level.scr_anim["elias_mask"]["recruit"] = % hc_recruit_eliasmask;
  level.scr_animtree["merrick_mask"] = #animtree;
  level.scr_model["merrick_mask"] = "merrick_head_halfmask";
  level.scr_anim["merrick_mask"]["recruit"] = % hc_recruit_merrickmask;
  level.scr_animtree["outside_tower"] = #animtree;
  level.scr_model["outside_tower"] = "hc_hesco_tower_dest";
  level.scr_anim["outside_tower"]["recruit"] = % hc_recruit_tower;
  level.scr_animtree["outside_palmtree"] = #animtree;
  level.scr_model["outside_palmtree"] = "palm_tree01_iw6";
  level.scr_anim["outside_palmtree"]["recruit"] = % hc_recruit_palmtree;
}

flare_rig_anims() {
  level.scr_animtree["flare_rig"] = #animtree;
  level.scr_model["flare_rig"] = "angel_flare_rig";
  level.scr_anim["flare_rig"]["flare"][0] = % ac130_angel_flares01;
  level.scr_anim["flare_rig"]["flare"][1] = % ac130_angel_flares02;
  level.scr_anim["flare_rig"]["flare"][2] = % ac130_angel_flares03;
}

welding_start(var_0) {
  var_0 endon("stop_welding");
  var_0 endon("death");
  playFXOnTag(common_scripts\utility::getfx("welding_sparks"), var_0.weldtool, "tag_tip_fx");

  for(;;) {
    var_0.weldtool playSound("elec_spark_welding_bursts");
    wait(randomfloatrange(0.05, 0.1));
  }
}

welding_stop(var_0) {
  var_0 notify("stop_welding");
  stopFXOnTag(common_scripts\utility::getfx("welding_sparks"), var_0.weldtool, "tag_tip_fx");
}

start_ragdoll(var_0) {
  var_0 startragdoll();
}

die_and_ragdoll(var_0) {
  var_0 startragdoll();
  var_0 maps\homecoming_util::kill_safe();
}

ragdoll_and_delete(var_0) {
  var_0 notify("death");
  var_0 startragdoll();
  var_0 maps\_utility::delaythread(3, maps\homecoming_util::delete_safe);
}

street_garage_door_open(var_0) {
  level.garagedoor thread maps\_utility::play_sound_on_entity("scn_home_garage_open");
}

street_garage_door_dialogue(var_0) {
  var_1 = lookupsoundlength("homcom_hsh_adamwehaveto");
  wait(var_1 / 1000);
  common_scripts\utility::flag_set("FLAG_garage_dialoge_done");
}

house_attack_hesh_fire(var_0) {
  level endon("house_attack_stop_fire");

  for(;;) {
    var_0 thread house_attack_hesh_shot();
    wait(randomfloatrange(0.09, 0.15));
  }
}

house_attack_hesh_shot() {
  thread maps\_drone::drone_shoot();
  var_0 = common_scripts\utility::random(["j_shoulder_le", "j_shoulder_ri"]);
  var_1 = level.attacker gettagorigin(var_0);
  playFX(common_scripts\utility::getfx("body_impact1"), var_1);
  thread common_scripts\utility::play_sound_in_space("bullet_large_flesh_npc", var_1);
}

house_attack_slowmo(var_0) {
  var_1 = gettime();
  setslowmotion(1, 0.5, 0);
  common_scripts\utility::flag_wait("FLAG_stop_house_attack_slowmo");
  setslowmotion(0.5, 1, 0);
}

house_ghost_slowmo(var_0) {
  setslowmotion(1, 0.25, 1);
}

recruits_start_fade_out(var_0) {
  level.player common_scripts\utility::delaycall(0.5, ::setclienttriggeraudiozone, "homecoming_black", 2.0);
}

elias_hide_mask(var_0) {}

player_control_given(var_0) {
  var_1 = 0.2;
  level.player springcamdisabled(var_1);
  wait(var_1);
  level.player setmovespeedscale(0.1);
  level.player enableslowaim(0.25, 0.25);
  maps\homecoming_recruits_util::player_animated_sequence_cleanup(0);
  level.player allowjump(0);
  var_2 = 0.35;
  maps\homecoming_recruits_util::player_sway_blendto(level.timestep, level.player_sway_weight * var_2);
  maps\homecoming_recruits_util::player_wind_blendto(level.timestep, level.player_wind_weight * var_2);
}

notetrack_func_fade_to_black(var_0) {
  var_1 = 1.0;
  level.black_overlay fadeovertime(var_1);
  level.black_overlay.alpha = 1;
  wait(var_1);
  maps\homecoming_recruits_util::hc_show_previous_hud();
  level.player thread maps\_utility::lerp_fov_overtime(level.timestep, level.default_fov);
  level.default_fov = undefined;
  level.player.disablereload = 0;
  level.player enableweapons();
  level.player enableoffhandweapons();
  level.player enableweaponswitch();
  level.player setmovespeedscale(1.0);
  level.player disableslowaim();
  level notify("notify_end_rhythm_rumble");
}

dialog() {
  level.scr_sound["ranger1"]["homcom_gs1_holdyourfirehold"] = "homcom_gs1_holdyourfirehold";
  level.scr_sound["ranger2"]["homcom_so2_weaponsdown"] = "homcom_so2_weaponsdown";
  level.scr_sound["dog_guy"]["homcom_us1_youwalkersboys"] = "homcom_us1_youwalkersboys";
  level.scr_sound["hesh"]["homcom_hsh_captainineeda"] = "homcom_hsh_captainineeda";
  level.scr_sound["dog_guy"]["homcom_us1_noideasonim"] = "homcom_us1_noideasonim";
  level.scr_sound["hesh"]["homcom_hsh_angrygrunthowcan"] = "homcom_hsh_angrygrunthowcan";
  level.scr_sound["hesh"]["homcom_hsh_takecairoandhead"] = "homcom_hsh_takecairoandhead";
  level.scr_sound["ranger1"]["homcom_sos_hooah"] = "homcom_sos_hooah_1";
  level.scr_sound["ranger2"]["homcom_sos_hooah"] = "homcom_sos_hooah_2";
  level.scr_sound["hesh"]["homcom_us1_wellbewaitin"] = "homcom_us1_wellbewaitin";
  level.scr_sound["hesh"]["homcom_us1_welldontjuststand"] = "homcom_us1_welldontjuststand";
  level.scr_sound["hesh"]["homcom_hsh_wellhelpoutwhere"] = "homcom_hsh_wellhelpoutwhere";
  level.scr_radio["homcom_hsh_rogerletssecurethat"] = "homcom_hsh_rogerletssecurethat";
  level.scr_sound["secondary_gunner"]["homcom_smg_welcometotheshit"] = "homcom_smg_welcometotheshit";
  level.scr_sound["hesh"]["homcom_hsh_getonthatgun"] = "homcom_hsh_getonthatgun";
  level.scr_sound["hesh"]["homcom_hsh_enemytanksoverlrodwhere"] = "homcom_hsh_enemytanksoverlrodwhere";
  level.scr_radio["homcom_com_fornowyouregoing"] = "homcom_com_fornowyouregoing";
  level.scr_sound["hesh"]["homcom_hsh_makeitquickor"] = "homcom_hsh_makeitquickor";
  level.scr_sound["hesh"]["homcom_hsh_lookslikewereon"] = "homcom_hsh_lookslikewereon";
  level.scr_radio["homcom_us1_shitthosedroneswere"] = "homcom_us1_shitthosedroneswere";
  level.scr_sound["secondary_gunner"]["homcom_us1_rightsiderightside"] = "homcom_us1_rightsiderightside";
  level.scr_sound["secondary_gunner"]["homcom_us1_nicehit"] = "homcom_us1_nicehit";
  level.scr_sound["secondary_gunner"]["homcom_us1_keepfiringbringit"] = "homcom_us1_keepfiringbringit";
  level.scr_sound["secondary_gunner"]["homcom_us1_anotherhelicopterdownthe"] = "homcom_us1_anotherhelicopterdownthe";
  level.scr_sound["secondary_gunner"]["homcom_us1_keepfiringkeepfiring"] = "homcom_us1_keepfiringkeepfiring";
  level.scr_sound["secondary_gunner"]["homcom_us1_theyreretreating"] = "homcom_us1_theyreretreating";
  level.scr_sound["hesh"]["homcom_hsh_theyrescatteredkeep"] = "homcom_hsh_theyrescatteredkeep";
  level.scr_radio["homcom_so3_enemysmoketheyremarking"] = "homcom_so3_enemysmoketheyremarking";
  level.scr_sound["hesh"]["homcom_hsh_getdownenemyartillery"] = "homcom_hsh_getdownenemyartillery";
  level.scr_sound["hesh"]["homcom_hsh_commandwherearethose"] = "homcom_hsh_commandwherearethose";
  level.scr_sound["hesh"]["homcom_hsh_commandthisisraptor"] = "homcom_hsh_commandthisisraptor";
  level.scr_radio["homcom_hqr_rogerraptor21air"] = "homcom_hqr_rogerraptor21air";
  level.scr_sound["hesh"]["homcom_hsh_tanksaremovingup"] = "homcom_hsh_tanksaremovingup";
  level.scr_sound["hesh"]["homcom_hsh_thoseenemytankshave"] = "homcom_hsh_thoseenemytankshave";
  level.scr_sound["hesh"]["homcom_hsh_lookslikewereon"] = "homcom_hsh_lookslikewereon";
  level.scr_sound["hesh"]["homcom_hsh_werelosingthebeach"] = "homcom_hsh_werelosingthebeach";
  level.scr_radio["homcom_hqr_a10dronesupportis"] = "homcom_hqr_a10dronesupportis";
  level.scr_sound["hesh"]["homcom_hsh_adamtakecontrolof"] = "homcom_hsh_adamtakecontrolof";
  level.scr_sound["hesh"]["homcom_hsh_thedronesareready"] = "homcom_hsh_thedronesareready";
  level.scr_sound["hesh"]["homcom_hsh_a10dronesarein"] = "homcom_hsh_a10dronesarein";
  level.scr_sound["hesh"]["homcom_hsh_takecontrolofthe"] = "homcom_hsh_takecontrolofthe";
  level.scr_sound["hesh"]["homcom_hsh_lookslikewereon"] = "homcom_hsh_lookslikewereon";
  level.scr_sound["hesh"]["homcom_hsh_holdon"] = "homcom_hsh_holdon";
  level.scr_radio["homcom_hsh_youregoodgetup"] = "homcom_hsh_youregoodgetup";
  level.scr_radio["homcom_hsh_enemytroopsadvancingout"] = "homcom_hsh_enemytroopsadvancingout";
  level.scr_radio["homcom_com_raptor21dronecontrols"] = "homcom_com_raptor21dronecontrols";
  level.scr_sound["hesh"]["homcom_hsh_rogerthatpatchme"] = "homcom_hsh_rogerthatpatchme";
  level.scr_radio["homcom_dcon_raptor21weresurrounded"] = "homcom_dcon_raptor21weresurrounded";
  level.scr_sound["hesh"]["homcom_hsh_weremakingourway"] = "homcom_hsh_weremakingourway";
  level.scr_radio["homcom_com_alldefensiveunitsbe"] = "homcom_com_alldefensiveunitsbe";
  level.scr_sound["hesh"]["homcom_hsh_ifthattowergoes"] = "homcom_hsh_ifthattowergoes";
  level.scr_sound["hesh"]["homcom_hsh_commandwehavean"] = "homcom_hsh_commandwehavean";
  level.scr_radio["homcom_com_copythattheyvebeen"] = "homcom_com_copythattheyvebeen";
  level.scr_sound["hesh"]["homcom_hsh_usethea10drones"] = "homcom_hsh_usethea10drones";
  level.scr_sound["hesh"]["homcom_hsh_tankdestroyedgoodjob"] = "homcom_hsh_tankdestroyedgoodjob";
  level.scr_radio["homcom_dcon_raptor21weresurrounded"] = "homcom_dcon_raptor21weresurrounded";
  level.scr_sound["hesh"]["homcom_hsh_wilcowerealmostthere"] = "homcom_hsh_wilcowerealmostthere";
  level.scr_sound["hesh"]["homcom_hsh_dronecontrolenemyforces"] = "homcom_hsh_dronecontrolenemyforces";
  level.scr_radio["homcom_dcon_rogerthatrepositioning"] = "homcom_dcon_rogerthatrepositioning";
  level.scr_sound["hesh"]["homcom_hsh_calleminmake"] = "homcom_hsh_calleminmake";
  level.scr_sound["hesh"]["homcom_hsh_doorsopening"] = "homcom_hsh_doorsopening";
  level.scr_radio["homcom_dcon_enemylockonbeginning"] = "homcom_dcon_enemylockonbeginning";
  level.scr_radio["homcom_dcon_dronetwosbeenhit"] = "homcom_dcon_dronetwosbeenhit";
  level.scr_sound["hesh"]["homcom_hsh_dronecontrolcomein"] = "homcom_hsh_dronecontrolcomein";
  level.scr_sound["hesh"]["homcom_hsh_shitcomeonlets"] = "homcom_hsh_shitcomeonlets";
  level.scr_sound["hesh"]["homcom_hsh_thatsthelastof"] = "homcom_hsh_thatsthelastof";
  level.scr_sound["hesh"]["homcom_hsh_commandthisisraptor_2"] = "homcom_hsh_commandthisisraptor_2";
  level.scr_radio["homcom_com_allunitsthisis"] = "homcom_com_allunitsthisis";
  level.scr_sound["generic"]["homcom_us3_fallbackfallback"] = "homcom_us3_fallbackfallback";
  level.scr_radio["homcom_us1_shitthosedroneswere"] = "homcom_us1_shitthosedroneswere";
  level.scr_sound["hesh"]["homcom_hsh_stickwithme"] = "homcom_hsh_stickwithme";
  level.scr_sound["hesh"]["homcom_hsh_overlordraptor21have"] = "homcom_hsh_overlordraptor21have";
  level.scr_sound["hesh"]["homcom_hsh_theresriley"] = "homcom_hsh_theresriley";
  level.scr_sound["hesh"]["homcom_hsh_rileycmonboy"] = "homcom_hsh_rileycmonboy";
  level.scr_sound["hesh"]["homcom_hsh_enemiesendofthe"] = "homcom_hsh_enemiesendofthe";
  level.scr_radio["homcom_us1_wegotenemiesfast"] = "homcom_us1_wegotenemiesfast";
  level.scr_sound["hesh"]["homcom_hsh_watchyourfirefriendlies"] = "homcom_hsh_watchyourfirefriendlies";
  level.scr_sound["hesh"]["homcom_hqr_sorryraptor21nothing"] = "homcom_hqr_sorryraptor21nothing";
  level.scr_sound["hesh"]["homcom_hsh_cairogo"] = "homcom_hsh_cairogo";
  level.scr_sound["hesh"]["homcom_hsh_enemiesadvancingbehindus"] = "homcom_hsh_enemiesadvancingbehindus";
  level.scr_sound["hesh"]["homcom_hsh_getinside"] = "homcom_hsh_getinside";
  level.scr_sound["hesh"]["homcom_hsh_comeonadamwe"] = "homcom_hsh_comeonadamwe";
  level.scr_sound["hesh"]["homcom_hsh_adamgetinhere"] = "homcom_hsh_adamgetinhere";
  level.scr_sound["hesh"]["homcom_hsh_adamweneedto"] = "homcom_hsh_adamweneedto";
  level.scr_sound["hesh"]["homcom_hsh_coughing"] = "homcom_hsh_coughing";
  level.scr_sound["hesh"]["homcom_hsh_adamwehaveto"] = "homcom_hsh_adamwehaveto";
  level.scr_sound["hesh"]["homcom_hsh_upthestairs"] = "homcom_hsh_upthestairs";
  level.scr_sound["hesh"]["homcom_hsh_watchout"] = "homcom_hsh_watchout";
  level.scr_sound["hesh"]["homcom_hsh_shiticantget"] = "homcom_hsh_shiticantget";
  level.scr_sound["hesh"]["homcom_hsh_logan"] = "homcom_hsh_logan";
  level.scr_sound["hesh"]["homcom_hsh_shityourebleeding"] = "homcom_hsh_shityourebleeding";
  level.scr_sound["hesh"]["homcom_hsh_holdonillget"] = "homcom_hsh_holdonillget";
  level.scr_sound["hesh"]["homcom_hsh_getdown"] = "homcom_hsh_getdown";
  level.scr_sound["elias"]["homcom_els_easysonyoullbeok"] = "homcom_els_easysonyoullbeok";
  level.scr_sound["hesh"]["homcom_hsh_thiswholetimeyou"] = "homcom_hsh_thiswholetimeyou";
  level.scr_sound["elias"]["homcom_els_theresalotive"] = "homcom_els_theresalotive";
  level.scr_sound["elias"]["homcom_els_youvetrainedforthis"] = "homcom_els_youvetrainedforthis";
  level.scr_sound["hesh"]["homcom_hsh_werereadywewont"] = "homcom_hsh_werereadywewont";
  level.scr_sound["elias"]["homcom_els_theresnowayyou"] = "homcom_els_theresnowayyou";
  level.scr_sound["hesh"]["homcom_hsh_whataboutrorkeajax"] = "homcom_hsh_whataboutrorkeajax";
  level.scr_sound["elias"]["homcom_els_hewasoneof"] = "homcom_els_hewasoneof";
  level.scr_sound["generic"]["homcom_hsh_thedronesareready"] = "homcom_hsh_thedronesareready";
  level.scr_sound["generic"]["homcom_hsh_a10dronesarein"] = "homcom_hsh_a10dronesarein";
  level.scr_sound["generic"]["homcom_hsh_takecontrolofthe"] = "homcom_hsh_takecontrolofthe";
  level.scr_radio["homcom_dcon_repositioningdronestoyour"] = "homcom_dcon_repositioningdronestoyour";
  level.scr_radio["homcom_dcon_rogera10drones"] = "homcom_dcon_rogera10drones";
  level.scr_radio["homcom_dcon_dronesarestill"] = "homcom_dcon_dronesarestill";
  level.scr_radio["homcom_us2_hogonesinfrom"] = "homcom_us2_hogonesinfrom";
  level.scr_radio["homcom_us2_riflehogwerecoming"] = "homcom_us2_riflehogwerecoming";
  level.scr_radio["homcom_us2_copythattargetin"] = "homcom_us2_copythattargetin";
  level.scr_radio["homcom_us2_hogonesin"] = "homcom_us2_hogonesin";
  level.scr_radio["a10_ambient_line_0"] = "homcom_plt1_hogriflethankselevation";
  level.scr_radio["a10_ambient_line_1"] = "homcom_plt1_threevehiclesoriented";
  level.scr_radio["a10_ambient_line_2"] = "homcom_plt1_threeyoureinsidethree";
  level.scr_radio["a10_ambient_line_3"] = "homcom_plt1_twoyoureclearedhot";
  level.scr_radio["a10_ambient_line_4"] = "homcom_plt1_okineedeveryone";
  level.scr_radio["a10_ambient_line_5"] = "homcom_plt1_keepitsouthtake";
  level.scr_radio["a10_ambient_line_6"] = "homcom_plt1_copythatimoff";
  level.scr_radio["a10_ambient_line_7"] = "homcom_plt1_copyonthati";
  level.scr_radio["a10_ambient_line_8"] = "homcom_plt1_hogoneineed";
  level.scr_radio["a10_ambient_line_9"] = "homcom_plt1_imunabletoget";
  level.scr_radio["a10_ambient_line_10"] = "homcom_plt1_hogtwowhenyou";
  level.scr_radio["a10_ambient_line_11"] = "homcom_plt1_hogoneivegot";
  level.scr_radio["a10_ambient_line_12"] = "homcom_plt1_hogtwothosemarks";
  level.scr_radio["homcom_dcon_confirmedtankkillsgood"] = "homcom_dcon_confirmedtankkillsgood";
  level.scr_radio["homcom_dcon_enemyarmorconfirmed"] = "homcom_dcon_enemyarmorconfirmed";
  level.scr_radio["homcom_dcon_tenpluskiasgood"] = "homcom_dcon_tenpluskiasgood";
  level.scr_radio["homcom_dcon_goodkillsraptor21"] = "homcom_dcon_goodkillsraptor21";
  level.scr_radio["homcom_dcon_confirmedarmorandinfantry"] = "homcom_dcon_confirmedarmorandinfantry";
}