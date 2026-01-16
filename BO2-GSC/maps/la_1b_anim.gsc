/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\la_1b_anim.gsc
**************************************/

#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_turret;
#include maps\la_utility;
#include maps\voice\voice_la_1b;
#include maps\createart\la_1b_art;
#include maps\la_street;
#include maps\la_plaza;
#include maps\la_intersection;

main() {
  event_5_anims();
  event_6_anims();
  event_7_anims();
  fxanim_test();
  precache_assets();
  maps\voice\voice_la_1b::init_voice();
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("vehicles");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");

event_5_anims() {
  add_scene("cougar_exit_player", "anim_align_cougar_crash");
  add_player_anim("player_body", % ch_la_05_01_cougar_exit_player, 1, 0, undefined, 1, 1, 20, 20, 20, 20);
  add_notetrack_custom_function("player_body", "sndTurnOffIntroSnapshot", ::sndturnoffintrosnapshot);
  add_notetrack_custom_function("player_body", "dof steering_wheel", maps\createart\la_1b_art::cougar_exit_dof1);
  add_notetrack_custom_function("player_body", "dof harper", maps\createart\la_1b_art::cougar_exit_dof2);
  add_notetrack_custom_function("player_body", "dof hatch", maps\createart\la_1b_art::cougar_exit_dof3);
  add_notetrack_custom_function("player_body", "dof f35", maps\createart\la_1b_art::cougar_exit_dof4);
  add_notetrack_custom_function("player_body", "dof convoy", maps\createart\la_1b_art::cougar_exit_dof5);
  add_notetrack_custom_function("player_body", "dof claw", maps\createart\la_1b_art::cougar_exit_dof6);
  add_notetrack_flag("player_body", "dof claw", "start_claw_vo");
  add_scene("cougar_exit", "anim_align_cougar_crash");
  add_actor_anim("ce_bike_cop_1", % ch_la_05_01_cougar_exit_bike_cop1, 0, 0, 1);
  add_actor_anim("ce_bike_cop_2", % ch_la_05_01_cougar_exit_bike_cop2, 0, 0, 1);
  add_actor_anim("ce_bike_cop_3", % ch_la_05_01_cougar_exit_bike_cop3, 0, 0, 1);
  add_actor_anim("ce_cop_1", % ch_la_05_01_cougar_exit_cop1);
  add_actor_anim("ce_cop_2", % ch_la_05_01_cougar_exit_cop2, 0, 0, 0, 1);
  add_actor_anim("ter_cougar_exit", % ch_la_05_01_cougar_exit_ter1);
  add_prop_anim("ce_bike_1", % v_la_05_01_cougar_exit_bike1, "veh_t6_civ_police_motorcycle", 0);
  add_prop_anim("ce_bike_2", % v_la_05_01_cougar_exit_bike2, "veh_t6_civ_police_motorcycle", 0);
  add_prop_anim("ce_bike_3", % v_la_05_01_cougar_exit_bike3, "veh_t6_civ_police_motorcycle", 0);
  add_prop_anim("ce_car_1", % v_la_05_01_cougar_exit_cop_car1, "veh_t6_police_car", 0);
  add_prop_anim("ce_car_2", % v_la_05_01_cougar_exit_cop_car2, "veh_t6_police_car", 0);
  add_prop_anim("president_cougar_exit", % v_la_05_01_cougar_exit_cougar02, "veh_t6_mil_cougar", 0);
  add_vehicle_anim("f35_cougar_exit", % v_la_05_01_cougar_exit_f35, 1, "tag_gear");
  add_notetrack_fx_on_tag("ce_bike_1", "shot", "ce_dest_cop_motorcycle", "tag_body_animate_jnt");
  add_notetrack_fx_on_tag("ce_bike_3", "shot", "ce_dest_cop_motorcycle", "tag_body_animate_jnt");
  add_notetrack_fx_on_tag("ce_bike_cop_2", "shot", "ce_motocop_blood_fx_single", "j_spine4");
  add_notetrack_fx_on_tag("ce_bike_cop_3", "shot", "ce_motocop_blood_fx_single", "j_spine4");
  add_notetrack_custom_function("f35_cougar_exit", "fire1", ::fire_turret_2);
  add_notetrack_custom_function("f35_cougar_exit", "hit", ::ce_f35_hit);
  add_notetrack_custom_function("f35_cougar_exit", "AB_off", ::ce_f35_hover);
  add_notetrack_custom_function("f35_cougar_exit", "AB_on", ::ce_f35_fly);
  add_notetrack_custom_function("ter_cougar_exit", "fire_at_f35", ::fire_at_f35);
  add_notetrack_custom_function("ce_cop_1", "shot", ::ce_blood_fx);
  add_notetrack_custom_function("ce_cop_2", "shot", ::ce_blood_fx);
  add_scene("cougar_exit_bigrig", "anim_align_cougar_crash");
  add_prop_anim("wheeler_cougar_exit", % v_la_05_01_cougar_exit_18wheeler);
  add_scene("cougar_exit_interior", "anim_align_cougar_crash");
  add_prop_anim("interior_cougar_exit", % v_la_05_01_cougar_exit_cougar);
  add_scene("cougar_exit_interior_noharper", "anim_align_cougar_crash");
  add_prop_anim("interior_cougar_exit", % v_la_05_01_cougar_exit_harperdead_cougar);
  add_scene("cougar_exit_harper", "anim_align_cougar_crash");
  add_actor_anim("harper", % ch_la_05_01_cougar_exit_harper1);
  add_notetrack_custom_function("harper", "fire_sniper", maps\la_street::harper_fire_sniperstorm, 0);
  add_notetrack_custom_function("harper", "fire_sniper2", maps\la_street::harper_fire_sniperstorm, 0);
  add_notetrack_custom_function("harper", "grenade_right", ::ce_harper_grenade);
  add_scene("cougar_exit_claw", "anim_align_cougar_crash");
  add_prop_anim("ce_bdog_turret", % v_la_05_01_cougar_exit_claw_turret, "veh_t6_drone_claw_turret");
  add_prop_anim("bdog_cougar_exit", % v_la_05_01_cougar_exit_big_dog, "veh_t6_drone_claw_mk2_alt");
  add_notetrack_custom_function("bdog_cougar_exit", "fire", ::bdog_muzzle_flash);
  add_notetrack_fx_on_tag("bdog_cougar_exit", "sniper_hit", "ce_bdog_killshot", "tag_neck");
  add_notetrack_exploder("bdog_cougar_exit", "grenade_hit", 505);
  add_notetrack_exploder("bdog_cougar_exit", "grenade_hit", 506);
  add_notetrack_fx_on_tag("bdog_cougar_exit", "sniper_killshot_hit", "ce_bdog_killshot", "tag_neck");
  add_notetrack_fx_on_tag("bdog_cougar_exit", "claw disabled", "ce_bdog_stun", "tag_body_animate");
  add_notetrack_custom_function("bdog_cougar_exit", "claw_explode", ::bdog_die_explosion);
  add_notetrack_custom_function("bdog_cougar_exit", "start_fire", ::snd_bdog_fire);
  add_notetrack_custom_function("bdog_cougar_exit", "stop_fire", ::snd_bdog_stop_fire);
  add_scene("cougar_exit_cop_car", "anim_align_cougar_crash");
  add_prop_anim("cop_car_cougar_exit", % v_la_05_01_cougar_exit_cop_car3);
  add_notetrack_custom_function("cop_car_cougar_exit", "tire_skid", ::ce_tire_fx);
  add_notetrack_custom_function("cop_car_cougar_exit", "car_explode", ::ce_explode);
  add_scene("ce_fxanim_cop_car", undefined, 0, 0, 0, 1);
  add_prop_anim("cop_car_cougar_exit", % fxanim_la_cop_car_shootup_anim);
  add_notetrack_fx_on_tag("cop_car_cougar_exit", undefined, "ce_dest_cop_car_fx", "tag_body");
  add_scene("ce_fxanim_cop_car_explode", undefined, 0, 0, 0, 1);
  add_prop_anim("cop_car_cougar_exit", % fxanim_la_cop_car_shootup_explode_anim);
  add_scene("clear_the_street", "anim_align_semi_arrival");
  add_prop_anim("wheeler_clear_the_street", % v_la_05_02_clearthestreet_18whlr, "veh_t6_civ_18wheeler");
  add_prop_anim("policecar_clear_the_street", % v_la_05_02_clearthestreet_policecar);
  add_notetrack_attach("wheeler_clear_the_street", undefined, "veh_t6_civ_18wheeler_trailer_props", "tag_trailer_props");
  add_notetrack_custom_function("policecar_clear_the_street", "hits_bus", ::clear_street_lapd_car_explode);
  add_scene("clear_the_street_ter", "anim_align_semi_arrival");
  add_actor_anim("ter_clear_the_street", % ch_la_05_02_clearthestreet_ter1);
  add_scene("clear_street_ter_semi", "anim_align_semi_arrival");
  add_actor_anim("clearthestreet_ter2", % ch_la_05_02_clearthestreet_ter2);
  add_actor_anim("clearthestreet_ter3", % ch_la_05_02_clearthestreet_ter3);
  add_actor_anim("clearthestreet_ter4", % ch_la_05_02_clearthestreet_ter4);
  add_actor_anim("clearthestreet_ter5", % ch_la_05_02_clearthestreet_ter5);
  add_scene("street_bodies", "anim_align_cougar_crash");
  add_actor_model_anim("street_body03", % ch_la_05_03_deathposesforla_streets_guy03, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_actor_model_anim("street_body04", % ch_la_05_03_deathposesforla_streets_guy04, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_actor_model_anim("street_body05", % ch_la_05_03_deathposesforla_streets_guy05, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_actor_model_anim("street_body07", % ch_la_05_03_deathposesforla_streets_guy07, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_actor_model_anim("street_body09", % ch_la_05_03_deathposesforla_streets_guy09, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_actor_model_anim("street_body10", % ch_la_05_03_deathposesforla_streets_guy10, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_actor_model_anim("street_body11", % ch_la_05_03_deathposesforla_streets_guy11, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_actor_model_anim("street_body12", % ch_la_05_03_deathposesforla_streets_guy12, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_actor_model_anim("street_body13", % ch_la_05_03_deathposesforla_streets_guy13, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_actor_model_anim("street_body15", % ch_la_05_03_deathposesforla_streets_guy15, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_scene("streetbody_01", "align_streetbody_01");
  add_actor_model_anim("street_body01", % ch_gen_m_floor_armup_onfront_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_scene("streetbody_02", "align_streetbody_02");
  add_actor_model_anim("street_body02", % ch_gen_m_floor_armup_legaskew_onfront_faceleft_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_scene("streetbody_06", "align_streetbody_06");
  add_actor_model_anim("street_body06", % ch_gen_m_wall_armcraddle_leanleft_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_scene("streetbody_08", "align_streetbody_08");
  add_actor_model_anim("street_body08", % ch_gen_m_ledge_armhanging_facedown_onfront_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_scene("streetbody_14", "align_streetbody_14");
  add_actor_model_anim("street_body14", % ch_gen_m_floor_armdown_onfront_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner");
  add_scene("brute_force_player", "anim_align_bruteforce");
  add_player_anim("player_body", % ch_la_05_03_bruteforce_player, 1);
  add_prop_anim("bruteforce_jaws", % o_la_05_03_bruteforce_jaws, "t6_wpn_jaws_of_life_prop", 1);
  add_notetrack_custom_function("player_body", "start_ssa_anim", ::start_ssa_anim);
  add_scene("brute_force_ssa_1", "anim_align_bruteforce");
  add_actor_anim("ssa_1_brute_force", % ch_la_05_03_bruteforce_ssa1, 0, 0, 0, 1, undefined, "ssa_brute_force");
  add_scene("brute_force_ssa_2", "anim_align_bruteforce");
  add_actor_anim("ssa_2_brute_force", % ch_la_05_03_bruteforce_ssa2, 0, 0, 0, 1, undefined, "ssa_brute_force");
  add_scene("brute_force_ssa_3", "anim_align_bruteforce");
  add_actor_anim("ssa_3_brute_force", % ch_la_05_03_bruteforce_ssa3, 0, 0, 0, 1, undefined, "ssa_brute_force");
  add_scene("brute_force_cougar", "anim_align_bruteforce");
  add_prop_anim("bruteforce_cougar", % v_la_05_03_bruteforce_cougar);
  add_scene("train_surprise_attack", "align_train_surprise", 0, 1);
  add_actor_anim("street_train_surprise", % ai_mantle_on_56);
  add_scene("cart_push", "anim_align_cougar_crash");
  add_actor_anim("guy_push_cart_1", % ch_la_05_02_entries_cartpush_guy01);
  add_actor_anim("guy_push_cart_2", % ch_la_05_02_entries_cartpush_guy02);
  add_prop_anim("hotdog_cart_push", % o_la_05_02_entries_cartpush_cart);
  add_scene("ladder_entry_1", "anim_align_cougar_crash", 0, 1);
  add_actor_anim("generic", % ch_la_05_02_entries_ladder_guy01);
  add_scene("ladder_entry_2", "anim_align_cougar_crash");
  add_actor_anim("guy_ladder_2", % ch_la_05_02_entries_ladder_guy02);
  add_scene("pipe_entry_1", "anim_align_cougar_crash");
  add_actor_anim("guy_pipe_1", % ch_la_05_02_entries_pipe_guy01);
  add_scene("pipe_entry_2", "anim_align_cougar_crash", 0, 1);
  add_actor_anim("generic", % ch_la_05_02_entries_pipe_guy02);
  add_scene("building_collapse_player");
  add_player_anim("player_body", % ch_la_07_09_building_collapse_playerreaction, 1);
}

ce_f35_hover(vh_f35) {
  vh_f35 notify("hover");
}

ce_f35_fly(vh_f35) {
  vh_f35 notify("fly");
}

fire_at_f35(ai_ter) {
  vh_f35 = get_model_or_models_from_scene("cougar_exit", "f35_cougar_exit");
  v_rpg_pos = ai_ter gettagorigin("tag_weapon");
  v_canopy_pos = vh_f35 gettagorigin("tag_driver");
  v_f35_pos = v_canopy_pos;
  magicbullet("usrpg_magic_bullet_sp", v_rpg_pos, v_canopy_pos);
  wait 3;
  level thread autosave_by_name("street_start");
}

fire_turret_2(vh_f35) {
  vh_f35 fire_turret_for_time(0.4, 2);
}

ce_f35_hit(vh_f35) {
  playfxontag(level._effect["ce_f35_fx"], vh_f35, "tag_origin");
}

bdog_muzzle_flash(m_bdog) {
  m_turret = get_model_or_models_from_scene("cougar_exit_claw", "ce_bdog_turret");
  playfxontag(level._effect["ce_bdog_tracer"], m_turret, "tag_flash");
}

ce_blood_fx(ai_cop) {
  playfxontag(level._effect["ce_cop_blood_fx_single"], ai_cop, "j_spineupper");
}

clear_street_lapd_car_explode(vh_lapd_car) {
  vh_lapd_car dodamage(10000, vh_lapd_car.origin);
}

ce_tire_fx(m_cop_car) {
  v_left_tire_org = m_cop_car gettagorigin("tag_wheel_back_left");
  v_left_tire_angle = (m_cop_car.angles[1] * -1, m_cop_car.angles[2], m_cop_car.angles[0]);
  m_fx_left = spawn_model("tag_origin", v_left_tire_org, v_left_tire_angle);
  m_fx_left linkto(m_cop_car);
  playfxontag(getfx("ce_cop_car_marks_left"), m_fx_left, "tag_origin");
  v_right_tire_org = m_cop_car gettagorigin("tag_wheel_back_right");
  v_right_tire_angle = (m_cop_car.angles[1] * -1, m_cop_car.angles[2], m_cop_car.angles[0]);
  m_fx_right = spawn_model("tag_origin", v_right_tire_org, v_right_tire_angle);
  m_fx_right linkto(m_cop_car);
  playfxontag(getfx("ce_cop_car_marks_right"), m_fx_right, "tag_origin");
  level notify("cop_car_skid_done");
  scene_wait("ce_fxanim_cop_car");
  m_fx_left delete();
  m_fx_right delete();
}

ce_explode(m_cop_car) {
  m_cop_car dodamage(m_cop_car.health, m_cop_car.origin, undefined, undefined, "riflebullet");
}

ce_harper_grenade(ai_harper) {
  ai_bdog = get_model_or_models_from_scene("cougar_exit_claw", "bdog_cougar_exit");
  v_start_pos = ai_harper gettagorigin("J_Wrist_RI");
  v_end_pos = ai_bdog.origin;
  v_grenade_velocity = vectornormalize(v_end_pos - v_start_pos) * 1000;
  ai_harper magicgrenademanual(ai_harper gettagorigin("J_Wrist_RI"), v_grenade_velocity, 0.5);
}

bdog_die_explosion(m_bdog) {
  fxorigin = m_bdog gettagorigin("tag_body_animate");
  playfx(level._effect["ce_bdog_death"], fxorigin);
  playsoundatposition("wpn_bigdog_explode", fxorigin);
  m_bdog delete();
  m_turret = get_model_or_models_from_scene("cougar_exit_claw", "ce_bdog_turret");
  m_turret delete();
  level thread power_pole_fxanim();
}

power_pole_fxanim() {
  level notify("fxanim_alley_power_pole_start");
}

start_ssa_anim(e_player) {
  level thread run_scene("brute_force_ssa_1");
  level thread run_scene("brute_force_ssa_2");
  level thread run_scene("brute_force_ssa_3");
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

event_6_anims() {
  add_scene("plaza_bodies", "align_plaza");
  add_actor_model_anim("plaza_body01", % ch_la_05_03_deathposesforla_plaza_guy01, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("plaza_body05", % ch_la_05_03_deathposesforla_plaza_guy05, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("plaza_body06", % ch_la_05_03_deathposesforla_plaza_guy06, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("plaza_body07", % ch_la_05_03_deathposesforla_plaza_guy07, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("plaza_body09", % ch_la_05_03_deathposesforla_plaza_guy09, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("plaza_body12", % ch_la_05_03_deathposesforla_plaza_guy12, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("plaza_body14", % ch_la_05_03_deathposesforla_plaza_guy14, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("plaza_body15", % ch_la_05_03_deathposesforla_plaza_guy15, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("plaza_body17", % ch_la_05_03_deathposesforla_plaza_guy17, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("plazabody_02", "align_plazabody_02");
  add_actor_model_anim("plaza_body02", % ch_gen_m_wall_legspread_armonleg_leanright_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("plazabody_03", "align_plazabody_03");
  add_actor_model_anim("plaza_body03", % ch_gen_m_floor_armsopen_onback_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("plazabody_04", "align_plazabody_04");
  add_actor_model_anim("plaza_body04", % ch_gen_m_wall_low_armstomach_leanleft_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("plazabody_08", "align_plazabody_08");
  add_actor_model_anim("plaza_body08", % ch_gen_m_wall_legspread_armdown_leanleft_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("plazabody_10", "align_plazabody_10");
  add_actor_model_anim("plaza_body10", % ch_gen_m_ledge_armhanging_faceright_onfront_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("plazabody_11", "align_plazabody_11");
  add_actor_model_anim("plaza_body11", % ch_gen_m_wall_armcraddle_leanleft_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("plazabody_13", "align_plazabody_13");
  add_actor_model_anim("plaza_body13", % ch_gen_m_floor_armstretched_onrightside_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("plazabody_16", "align_plazabody_16");
  add_actor_model_anim("plaza_body16", % ch_gen_m_ledge_armhanging_facedown_onfront_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("f35_crash_pilot", "fxanim_f35_dead");
  add_actor_model_anim("crash_pilot", % ch_la_06_03_f35crash_deadpilot, undefined, 0, "tag_origin");
  add_scene("plaza_counter_filp", "align_plaza", 1);
  add_actor_anim("plaza_foodguy01", % ch_la_06_02_plaza_foodguy01);
  add_scene("plaza_shopguy01", "align_plaza");
  add_actor_anim("plaza_shopguy01", % ch_la_06_02_plaza_shopguy01);
  add_prop_anim("plaza_cart_1", % o_la_06_02_plaza_cart01);
  add_scene("plaza_shopguy02", "align_plaza");
  add_actor_anim("plaza_shopguy02", % ch_la_06_02_plaza_shopguy02);
  add_prop_anim("plaza_cart_2", % o_la_06_02_plaza_cart02);
  add_scene("climb_plaza_building", "anim_climb_plaza_building");
  add_actor_anim("plaza_building", % ai_mantle_on_56);
  add_scene("climb_on_cylinder_0", "anim_plaza_right_rpg_0");
  add_actor_anim("plaza_right_rpg_0", % ai_mantle_on_56);
  add_scene("climb_on_cylinder_1", "anim_plaza_right_rpg_1");
  add_actor_anim("plaza_right_rpg_1", % ai_mantle_on_56);
  add_scene("plaza_grate1", "align_plaza");
  add_actor_anim("plaza_grate_01", % ch_la_06_02_plaza_grate01, 0, 0, 0, 0, undefined);
  add_scene("plaza_grate2", "align_plaza");
  add_actor_anim("plaza_grate_02", % ch_la_06_02_plaza_grate02, 0, 0, 0, 0, undefined);
  add_scene("plaza_grate1_loop", "align_plaza", 0, 0, 1);
  add_actor_anim("plaza_grate_01", % ch_la_06_02_plaza_grate01_loop, 0, 0, 0, 0, undefined);
  add_scene("plaza_grate2_loop", "align_plaza", 0, 0, 1);
  add_actor_anim("plaza_grate_02", % ch_la_06_02_plaza_grate02_loop, 0, 0, 0, 0, undefined);
  add_scene("plaza_ledge1", "plaza_ledge_01_node");
  add_actor_anim("plaza_ledge_01", % ch_la_06_02_plaza_ledge01, 0, 0, 0, 0, undefined);
  add_scene("plaza_planter", "plaza_planter_node");
  add_actor_anim("plaza_planter_01", % ch_la_06_02_plaza_planter_enemy1, 0, 0, 0, 0, undefined);
  add_prop_anim("plaza_stairs_planter", % o_la_06_02_plaza_planter01);
  add_scene("plaza_table_flip_01", "plaza_table_flip_01_node", 1);
  add_prop_anim("plaza_table_flip_table_01", % o_la_06_02_plaza_table_flip_table_01, "p6_plaza_table", 0, 1);
  add_prop_anim("plaza_table_flip_chair_01", % o_la_06_02_plaza_table_flip_chair_01, "p6_plaza_chair", 0, 1);
  add_prop_anim("plaza_table_flip_chair_02", % o_la_06_02_plaza_table_flip_chair_02, "p6_plaza_chair", 0, 1);
  add_prop_anim("plaza_table_flip_chair_03", % o_la_06_02_plaza_table_flip_chair_03, "p6_plaza_chair", 0, 1);
  add_actor_anim("plaza_table_flip_guy_01", % ch_la_06_02_plaza_table_flip_guy_01);
  add_scene("plaza_table_flip_02", "plaza_table_flip_02_node", 1);
  add_prop_anim("plaza_table_flip_table_02", % o_la_06_02_plaza_table_flip_table_02, "p6_plaza_table", 0, 1);
  add_prop_anim("plaza_table_flip_chair_04", % o_la_06_02_plaza_table_flip_chair_02, "p6_plaza_chair", 0, 1);
  add_prop_anim("plaza_table_flip_chair_05", % o_la_06_02_plaza_table_flip_chair_05, "p6_plaza_chair", 0, 1);
  add_actor_anim("plaza_table_flip_guy_02", % ch_la_06_02_plaza_table_flip_guy_02);
}

#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");

event_7_anims() {
  add_scene("intersection_bodies", "anim_align_stadium_intersection");
  add_actor_model_anim("intersection_body01", % ch_la_05_03_deathposesforla_intersection_guy01, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body03", % ch_la_05_03_deathposesforla_intersection_guy03, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body04", % ch_la_05_03_deathposesforla_intersection_guy04, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body05", % ch_la_05_03_deathposesforla_intersection_guy05, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body06", % ch_la_05_03_deathposesforla_intersection_guy06, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body08", % ch_la_05_03_deathposesforla_intersection_guy08, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body10", % ch_la_05_03_deathposesforla_intersection_guy10, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body11", % ch_la_05_03_deathposesforla_intersection_guy11, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body14", % ch_la_05_03_deathposesforla_intersection_guy14, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body15", % ch_la_05_03_deathposesforla_intersection_guy15, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body16", % ch_la_05_03_deathposesforla_intersection_guy16, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body18", % ch_la_05_03_deathposesforla_intersectionb_guy01, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body19", % ch_la_05_03_deathposesforla_intersectionb_guy02, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body20", % ch_la_05_03_deathposesforla_intersectionb_guy03, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body21", % ch_la_05_03_deathposesforla_intersectionb_guy04, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body22", % ch_la_05_03_deathposesforla_intersectionb_guy05, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body23", % ch_la_05_03_deathposesforla_intersectionb_guy06, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body24", % ch_la_05_03_deathposesforla_intersectionb_guy07, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_actor_model_anim("intersection_body26", % ch_la_05_03_deathposesforla_intersectionb_guy09, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("intersectbody_02", "align_intersectbody_02");
  add_actor_model_anim("intersection_body02", % ch_gen_m_floor_armdown_onfront_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("intersectbody_09", "align_intersectbody_09");
  add_actor_model_anim("intersection_body09", % ch_gen_m_floor_armdown_onback_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("intersectbody_12", "align_intersectbody_12");
  add_actor_model_anim("intersection_body12", % ch_gen_m_floor_armover_onrightside_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("intersectbody_13", "align_intersectbody_13");
  add_actor_model_anim("intersection_body13", % ch_gen_m_floor_armover_onrightside_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("intersectbody_17", "align_intersectbody_17");
  add_actor_model_anim("intersection_body17", % ch_gen_m_floor_armdown_legspread_onback_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("intersectbody_25", "align_intersectbody_25");
  add_actor_model_anim("intersection_body25", % ch_gen_m_floor_armdown_onfront_deathpose, undefined, 0, undefined, undefined, "dead_body_spawner", 0, 1);
  add_scene("lockbreaker", "anim_align_intruder");
  add_prop_anim("lockbreaker_lock", % o_specialty_la_lockbreaker_dongle, "t6_wpn_hacking_dongle_prop");
  add_player_anim("player_body", % int_specialty_la_lockbreaker, 1);
  add_notetrack_custom_function("player_body", undefined, ::data_glove_on);
  add_notetrack_custom_function("player_body", "planted", maps\la_plaza::lockbreaker_planted);
  add_notetrack_custom_function("player_body", "door_open", maps\la_plaza::lockbreaker_door_open);
  add_scene("intruder", "18wheeler_cage");
  add_prop_anim("intruder_cutter", % o_specialty_la_intruder_cutter, "t6_wpn_laser_cutter_prop", 1, 0, undefined, "tag_trailer");
  add_prop_anim("18wheeler_cage", % o_specialty_la_intruder_gate, undefined, 0, 0, undefined, "tag_trailer");
  add_player_anim("player_body", % int_specialty_la_intruder, 1, 0, "tag_trailer");
  add_notetrack_custom_function("player_body", "zap", maps\la_street::intruder_zap);
  add_notetrack_custom_function("player_body", "gatecrash", maps\la_street::intruder_gatecrash);
  add_notetrack_custom_function("18wheeler_cage", "hide_bolts", maps\la_street::intruder_hide_bolts);
  add_notetrack_custom_function("intruder_cutter", "zap_start", maps\la_street::intruder_zap_start);
  add_notetrack_custom_function("intruder_cutter", "zap_end", maps\la_street::intruder_zap_end);
  add_notetrack_custom_function("intruder_cutter", "start", maps\la_street::intruder_cutter_on);
  add_scene("sam_in", "intruder_sam");
  add_player_anim("player_body", % ch_la_07_01_sam_turret_in, 1);
  add_scene("sam_out", "intruder_sam");
  add_player_anim("player_body", % ch_la_07_01_sam_turret_out, 1);
  add_scene("sam_thrown_out", "intruder_sam");
  add_player_anim("player_body", % ch_la_07_01_sam_turret_thrown_out, 1);
  add_scene("fa38_landing", "anim_align_stadium_intersection");
  add_vehicle_anim("f35_vtol", % v_la_07_02_f35staples_f35);
  add_notetrack_custom_function("f35_vtol", undefined, maps\la_intersection::f35_land_fx);
  add_scene("ssathanks_ssa_idle", "anim_align_stadium_intersection", 0, 0, 1);
  add_actor_anim("thank_guy", % ch_la_07_02_ssathanks_guy01_idle1, 0, 0, 0, 1);
  add_scene("ssathanks_ssa", "anim_align_stadium_intersection");
  add_actor_anim("thank_guy", % ch_la_07_02_ssathanks_guy01, 0, 0, 0, 1);
  add_scene("ssathanks_harper", "anim_align_stadium_intersection", 1);
  add_actor_anim("harper", % ch_la_07_02_ssathanks_guy02);
  add_scene("ending_drone", "anim_align_arena_exit");
  add_prop_anim("crash_drone_ending", % fxanim_la_drone_crash_tower_anim, "veh_t6_drone_avenger");
}

fxanim_test() {
  level.scr_animtree["fxanim_ambient_drone_1"] = #animtree;
  level.scr_model["fxanim_ambient_drone_1"] = "veh_t6_drone_avenger";
  level.scr_anim["fxanim_ambient_drone_1"]["drone_ambient_1"][0] = % fxanim_la_drone_ambient_01_anim;
  level.scr_anim["fxanim_ambient_drone_1"]["drone_ambient_2"][0] = % fxanim_la_drone_ambient_02_anim;
  level.scr_animtree["fxanim_ambient_drone_2"] = #animtree;
  level.scr_model["fxanim_ambient_drone_2"] = "veh_t6_drone_pegasus";
  level.scr_anim["fxanim_ambient_drone_2"]["drone_ambient_1"][0] = % fxanim_la_drone_ambient_01_anim;
  level.scr_anim["fxanim_ambient_drone_2"]["drone_ambient_2"][0] = % fxanim_la_drone_ambient_02_anim;
  level.scr_animtree["fxanim_ambient_f35"] = #animtree;
  level.scr_model["fxanim_ambient_f35"] = "veh_t6_air_fa38";
  level.scr_anim["fxanim_ambient_f35"]["f35_ambient_1"][0] = % fxanim_la_drone_ambient_01_anim;
  level.scr_anim["fxanim_ambient_f35"]["f35_ambient_2"][0] = % fxanim_la_drone_ambient_02_anim;
}

snd_bdog_fire(bigdog) {
  bigdog playloopsound("wpn_intro_claw_loop");
}

snd_bdog_stop_fire(bigdog) {
  bigdog stoploopsound();
  bigdog playsound("wpn_intro_claw_stop");
}

sndturnoffintrosnapshot(guy) {
  level clientnotify("stop_intro_snp");
}