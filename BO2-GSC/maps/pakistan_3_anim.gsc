/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pakistan_3_anim.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_anim;
#include maps\voice\voice_pakistan_3;
#include maps\createart\pakistan_3_art;

main() {
  event_7_anims();
  event_8_anims();
  event_9_anims();
  hanger_ending_chase_anims();
  player_soct_anims();
  precache_assets();
  maps\voice\voice_pakistan_3::init_voice();
}

#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

event_7_anims() {
  add_scene("heli_approach", "soct_slant_bldg_jump");
  add_vehicle_anim("h_hind", % v_pakistan_7_4_helo_crash_approach_hind);
  add_notetrack_custom_function("h_hind", "start_fire", ::heli_start_shooting);
  add_scene("heli_loop", "soct_slant_bldg_jump", 0, 0, 1);
  add_vehicle_anim("h_hind", % v_pakistan_7_4_helo_crash_idle_hind);
  add_scene("heli_crash", "soct_slant_bldg_jump");
  add_vehicle_anim("h_hind", % v_pakistan_7_4_helo_crash_hind, 1);
  add_vehicle_anim("heli_crash_soct", % v_pakistan_7_4_helo_crash_soct, 1);
  add_notetrack_custom_function("h_hind", "end_fire", ::heli_start_anim_callback);
  add_notetrack_custom_function("h_hind", "explode", ::heli_end_anim_explosion);
  add_notetrack_custom_function("heli_crash_soct", "explode", ::soct_explosion);
  add_scene("di_billboard_right", "ai_billboard");
  add_actor_anim("di_billboard_1", % ch_pakistan_7_1_drone_tutorial_billboard_guy01);
  add_scene("di_billboard_side", "ai_billboard");
  add_actor_anim("di_billboard_3", % ch_pakistan_7_1_drone_tutorial_billboard_guy03);
  add_scene("di_billboard_below", "ai_billboard");
  add_actor_anim("di_billboard_2", % ch_pakistan_7_1_drone_tutorial_billboard_guy02);
  add_scene("di_glass_building", "ai_glassbreak");
  add_actor_anim("di_glass_building_1", % ch_pakistan_7_1_drone_tutorial_glass_building_soldier01);
  add_actor_anim("di_glass_building_2", % ch_pakistan_7_1_drone_tutorial_glass_building_soldier02);
  add_prop_anim("di_table", % o_pakistan_7_1_drone_tutorial_glass_building_table, "anim_glo_dining_table_sq");
  add_notetrack_custom_function("di_table", "glass_break", ::drone_intro_glass_break);
  add_scene("intro_lower_scaffoldind_01", "ai_scaffold");
  add_actor_anim("intro_lower_scaffolding_01_spawner", % ch_pakistan_7_1_drone_tutorial_lower_scaffolding_guy01);
  add_scene("intro_lower_scaffoldind_02", "ai_scaffold");
  add_actor_anim("intro_lower_scaffolding_02_spawner", % ch_pakistan_7_1_drone_tutorial_lower_scaffolding_guy02);
  add_scene("intro_pipe_building_01", "ai_balcony");
  add_actor_anim("intro_pipe_building_01_spawner", % ch_pakistan_7_1_drone_tutorial_pipe_building_guy01);
  add_scene("di_scaffolding_middle_1", "ai_scaffold");
  add_actor_anim("di_scaffolding_1", % ch_pakistan_7_1_drone_tutorial_scafold_guy01);
  add_scene("di_scaffolding_middle_2", "ai_scaffold");
  add_actor_anim("di_scaffolding_2", % ch_pakistan_7_1_drone_tutorial_scafold_guy02);
  add_scene("di_scaffolding_middle_3", "ai_scaffold");
  add_actor_anim("di_scaffolding_3", % ch_pakistan_7_1_drone_tutorial_scafold_guy03);
  add_scene("di_scaffolding_middle_4", "ai_scaffold");
  add_actor_anim("di_scaffolding_4", % ch_pakistan_7_1_drone_tutorial_scafold_guy04);
  add_scene("di_scaffolding_middle_5", "ai_scaffold");
  add_actor_anim("di_scaffolding_5", % ch_pakistan_7_1_drone_tutorial_scafold_guy05);
  add_scene("di_scaffolding_middle_6", "ai_scaffold");
  add_actor_anim("di_scaffolding_6", % ch_pakistan_7_1_drone_tutorial_scafold_guy06);
  add_scene("di_scaffolding_middle_7", "ai_scaffold");
  add_actor_anim("di_scaffolding_7", % ch_pakistan_7_1_drone_tutorial_scafold_guy07);
  add_scene("di_scaffolding_middle_8", "ai_scaffold");
  add_actor_anim("di_scaffolding_8", % ch_pakistan_7_1_drone_tutorial_scafold_guy08);
}

event_8_anims() {
}

#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("vehicles");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");

event_9_anims() {
  add_scene("standoff_approach", "chinese_standoff");
  add_actor_anim("han", % ch_pakistan_9_4_standoff_approach_redshirt);
  add_actor_anim("salazar", % ch_pakistan_9_4_standoff_approach_salazar);
  add_scene("standoff_approach_burned_harper", "chinese_standoff");
  add_actor_anim("harper", % ch_pakistan_9_4_standoff_approach_burned_harper);
  add_scene("standoff_approach_burned_player", "chinese_standoff");
  add_player_anim("player_body", % p_pakistan_9_4_standoff_approach_burned_player, 1, 0, undefined, 1, 1, 75, 75, 25, 25);
  addnotetrack_exploder("player_body", "fx_start_turn", 810);
  add_scene("standoff_approach_soct", "chinese_standoff");
  add_vehicle_anim("player_soc_t", % v_pakistan_9_4_standoff_approach_soct1);
  add_scene("standoff_approach_not_burned_harper", "chinese_standoff");
  add_actor_anim("harper", % ch_pakistan_9_4_standoff_approach_success_harper);
  add_scene("standoff_approach_not_burned_player", "chinese_standoff");
  add_player_anim("player_body", % p_pakistan_9_4_standoff_approach_success_player, 1, 0, undefined, 1, 1, 75, 75, 25, 25);
  add_scene("standoff_approach_not_burned_soct", "chinese_standoff");
  add_vehicle_anim("player_soc_t", % v_pakistan_9_4_standoff_approach_success_soct);
  add_scene("harper_burned_walk", undefined, 0, 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_9_4_harper_burned_walk);
  add_scene("standoff_idle_han", "chinese_standoff", 0, 0, 1);
  add_actor_anim("han", % ch_pakistan_9_4_standoff_idle_redshirt);
  add_scene("standoff_idle_salazar", "chinese_standoff", 0, 0, 1);
  add_actor_anim("salazar", % ch_pakistan_9_4_standoff_idle_salazar);
  add_scene("harper_standoff_idle_burned", "chinese_standoff", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_9_4_standoff_burned_idle_harper);
  add_scene("harper_standoff_idle_not_burned", "chinese_standoff", 0, 0, 1);
  add_actor_anim("harper", % ch_pakistan_9_4_standoff_idle_harper);
  add_scene("standoff", "chinese_standoff");
  add_player_anim("player_body", % p_pakistan_9_4_standoff_player, 1, 0, undefined, 1, 0.1, 50, 50, 25, 25);
  add_notetrack_custom_function("player_body", "dof_chinese_1", maps\createart\pakistan_3_art::standoff_dof_start);
  add_notetrack_custom_function("player_body", "dof_zhao_2", maps\createart\pakistan_3_art::standoff_zhao_turn);
  add_notetrack_custom_function("player_body", "DOF_zhao_walk", maps\createart\pakistan_3_art::standoff_zhao_walk);
  add_notetrack_custom_function("player_body", "dof_zhao_3", maps\createart\pakistan_3_art::standoff_dof_stop);
  add_notetrack_custom_function("player_body", "dof_zhao_4", maps\createart\pakistan_3_art::standoff_dof_closeup);
  add_notetrack_custom_function("player_body", "dof_zhao_5", maps\createart\pakistan_3_art::standoff_dof_end);
  add_notetrack_custom_function("player_body", "settle", ::standoff_settle);
  add_notetrack_custom_function("player_body", "start_fade", ::next_mission);
  add_scene("standoff_chinese_important", "chinese_standoff");
  add_actor_anim("chinese_1", % ch_pakistan_9_4_standoff_chinese01);
  add_actor_anim("chinese_2", % ch_pakistan_9_4_standoff_chinese02);
  add_actor_anim("zhao", % ch_pakistan_9_4_standoff_zhao);
  add_scene("standoff_burned", "chinese_standoff");
  add_actor_anim("harper", % ch_pakistan_9_4_standoff_burned_harper);
  add_scene("soldier_idle_chinese_1", undefined, 0, 0, 1);
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_idle_chin01);
  add_scene("soldier_idle_chinese_2", undefined, 0, 0, 1);
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_idle_chin02);
  add_scene("soldier_idle_chinese_3", undefined, 0, 0, 1);
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_idle_chin03);
  add_scene("soldier_idle_seal_1", undefined, 0, 0, 1);
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_idle_us01);
  add_scene("soldier_idle_seal_2", undefined, 0, 0, 1);
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_idle_us02);
  add_scene("soldier_idle_seal_3", undefined, 0, 0, 1);
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_idle_us03);
  add_scene("soldier_react_chinese_1");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_react_chin01);
  add_scene("soldier_react_chinese_2");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_react_chin02);
  add_scene("soldier_react_chinese_3");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_react_chin03);
  add_scene("soldier_react_seal_1");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_react_us01);
  add_scene("soldier_react_seal_2");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_react_us02);
  add_scene("soldier_react_seal_3");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_react_us03);
  add_scene("soldier_settle_chinese_1");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_settle_chin01);
  add_scene("soldier_settle_chinese_2");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_settle_chin02);
  add_scene("soldier_settle_chinese_3");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_settle_chin03);
  add_scene("soldier_settle_seal_1");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_settle_us01);
  add_scene("soldier_settle_seal_2");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_settle_us02);
  add_scene("soldier_settle_seal_3");
  add_actor_anim("generic", % ch_pakistan_9_4_standoff_soldier_settle_us03);
}

drone_intro_glass_break(m_table) {
  s_radius = getstruct("glass_break_radius", "targetname");
  radiusdamage(s_radius.origin, 16, 100, 100, undefined, "MOD_PROJECTILE");
}

heli_start_shooting(vh_heli) {
  vh_heli notify("shoot");
}

heli_end_shooting(vh_heli, note_t) {
  vh_heli notify("stop_shooting");
}

soct_explosion(vh_soct) {
  a_vh_heli = getentarray("h_hind", "targetname");

  if(isDefined(a_vh_heli)) {
    for(i = 0; i < a_vh_heli.size; i++) {
      e_heli = a_vh_heli[i];

      if(isDefined(e_heli.death_counter) && e_heli.death_counter > 0) {
        continue;
      }
      playfx(level._effect["blockade_explosion"], e_heli gettagorigin("tag_fx_flare"));
      playfxontag(level._effect["heli_crash_smoke_trail"], e_heli, "tag_origin");
    }
  }
}

vehicle_explosion(vh_hangar) {
  playfx(level._effect["blockade_explosion"], vh_hangar.origin);
}

drone_explosion_small(vh_drone) {
  playfx(level._effect["blockade_explosion"], vh_drone.origin);
  vh_drone play_fx("heli_crash_smoke_trail", vh_drone.origin, vh_drone.angles, undefined, 1, "tag_origin");
}

drone_explosion_big(vh_drone, note_t) {
  exploder(809);
}

burn_harper_face(ai_harper) {
  if(is_mature()) {
    ai_harper detach("c_usa_cia_combat_harper_head_wt");
    ai_harper attach("c_usa_cia_combat_harper_head_brn");
  }
}

standoff_settle(m_player_body) {
  level notify("standoff_settle");
}

next_mission(m_player_body) {
  screen_fade_out(0.5);
  wait 0.6;
  nextmission();
}

#using_animtree("vehicles");

hanger_ending_chase_anims() {
  add_scene("heli_factory_exit_crash", "heli_factory_exit_anim_struct");
  add_vehicle_anim("heli_factory_exit_boss_anim_crash_spawner", % v_pakistan_7_4_helo_crash_fast_hind, 1);
  add_notetrack_custom_function("h_hind", "end_fire", ::heli_start_anim_callback);
  add_notetrack_custom_function("h_hind", "explode", ::heli_end_anim_explosion);
  add_scene("soct_factory_exit_crash", "soct_factory_exit_anim_struct");
  add_vehicle_anim("heli_factory_exit_boss_anim_crash_spawner", % v_pakistan_7_4_helo_crash_fast_hind, 1);
  add_notetrack_custom_function("h_hind", "end_fire", ::heli_start_anim_callback);
  add_notetrack_custom_function("h_hind", "explode", ::heli_end_anim_explosion);
}

heli_start_anim_callback(vh_heli) {
  playfxontag(level._effect["ending_helicopter_explosion"], vh_heli, "body_animate_jnt");
  heli_end_shooting(vh_heli, undefined);
}

heli_end_anim_explosion(vh_heli) {
  playfxontag(level._effect["ending_helicopter_explosion"], vh_heli, "body_animate_jnt");
}

player_soct_anims() {
  level.scr_anim["player_scot"]["damage_start_slow"] = % fxanim_pak_soct_dmg_slow_start_anim;
  level.scr_anim["player_scot"]["damage_start_med"] = % fxanim_pak_soct_dmg_med_start_anim;
  level.scr_anim["player_scot"]["damage_start_fast"] = % fxanim_pak_soct_dmg_fast_start_anim;
  level.scr_anim["player_scot"]["damage_end_slow"] = % fxanim_pak_soct_dmg_slow_stop_anim;
  level.scr_anim["player_scot"]["damage_end_med"] = % fxanim_pak_soct_dmg_med_stop_anim;
  level.scr_anim["player_scot"]["damage_end_fast"] = % fxanim_pak_soct_dmg_fast_stop_anim;
  level.scr_anim["player_scot"]["damage_slow_loop"][0] = % fxanim_pak_soct_dmg_slow_anim;
  level.scr_anim["player_scot"]["damage_med_loop"][0] = % fxanim_pak_soct_dmg_med_anim;
  level.scr_anim["player_scot"]["damage_fast_loop"][0] = % fxanim_pak_soct_dmg_fast_anim;
}