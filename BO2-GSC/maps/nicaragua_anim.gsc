/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nicaragua_anim.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dialog;
#include maps\_scene;
#include maps\_anim;
#include maps\voice\voice_nicaragua;
#include maps\createart\nicaragua_art;
#include maps\nicaragua_intro;
#include maps\nicaragua_menendez_hallway;
#include maps\nicaragua_mason_intro;
#include maps\nicaragua_mason_hill;
#include maps\nicaragua_mason_truck;
#include maps\nicaragua_mason_woods_freakout;
#include maps\nicaragua_mason_to_mission;
#include maps\nicaragua_mason_bunker;
#include maps\nicaragua_mason_final_push;
#include maps\nicaragua_mason_shattered;
#include maps\nicaragua_mason_outro;

main() {
  maps\voice\voice_nicaragua::init_voice();
  menendez_intro_anims();
  noriega_intro_anims();
  village_intro_anims();
  village_pdf_ransacking_anims();
  village_heycart_animations();
  village_execution_anims();
  stables_weapons_cache_anims();
  stables_door();
  stables_woman_attacked_anims();
  stables_exit_cartel_ralley();
  balcony_throw();
  mission_banister_jumpdown();
  mansion_menendez_meets_mason();
  brutality_scenes();
  mason_intro_anims();
  mason_intruder_perk();
  mason_hill_fire_deaths();
  mason_hill_molotov_toss();
  mason_truck();
  mason_donkeykong();
  mason_woods_freakout();
  bruteforce_perk_anims();
  mason_split_up();
  lockbreaker_perk_anims();
  mason_bunker_cokeworkers();
  mason_bunker_paperburners();
  mason_woods_backbreaker();
  mason_shattered_parttwo();
  mason_outro();
  precache_assets();
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");

menendez_intro_anims() {
  add_scene("menendez_intro_part1", "josephina_room");
  add_player_anim("player_body", % ch_nic_01_01_intro_player, 0, 0, undefined, 1, 1, 20, 20, 20, 20);
  add_notetrack_custom_function("player_body", "dof_mirror", maps\createart\nicaragua_art::dof_mirror);
  add_notetrack_custom_function("player_body", "dof_pendant", maps\createart\nicaragua_art::dof_pendant);
  add_notetrack_custom_function("player_body", "dof_josefina", maps\createart\nicaragua_art::dof_josefina);
  add_actor_model_anim("intro_menendez_mirror", % ch_nic_01_01_intro_player_ref, undefined, 1, undefined, undefined, "intro_menendez_mirror");
  add_actor_model_anim("josefina", % ch_nic_01_01_intro_josafina, undefined, 0, undefined, undefined, "josefina");
  add_notetrack_custom_function("player_body", "title_card", maps\nicaragua_intro::menendez_title_card);
  add_notetrack_custom_function("player_body", "sndPlayBellChimes", ::play_bell_rings);
  add_scene("menedez_intro_1_pendant", "mi_player_body");
  add_prop_anim("intro_pendant", % o_nic_01_01_intro_pendant, "p6_anim_menendez_necklace", 1, 0, undefined, "tag_weapon1");
  add_scene("menendez_intro_part2", "josephina_room");
  add_player_anim("player_body", % ch_nic_01_02_intro_player, 1, 0, undefined, 1, 1, 20, 20, 20, 20);
  add_notetrack_custom_function("player_body", "dof_door_guy", maps\createart\nicaragua_art::dof_door_guy);
  add_notetrack_custom_function("player_body", "dof_struggle", maps\createart\nicaragua_art::dof_struggle);
  add_notetrack_custom_function("player_body", "dof_leader", maps\createart\nicaragua_art::dof_leader);
  add_notetrack_custom_function("player_body", "dof_josefina_struggle", maps\createart\nicaragua_art::dof_josefina_struggle);
  add_notetrack_custom_function("player_body", "dof_stab", maps\createart\nicaragua_art::dof_stab);
  add_notetrack_custom_function("player_body", "dof_syringe", maps\createart\nicaragua_art::dof_syringe);
  add_notetrack_custom_function("player_body", "sndSnapshotIntro", ::sndsnapshotintro);
  add_actor_model_anim("josefina", % ch_nic_01_02_intro_josafina, undefined, 1);
  add_actor_anim("intro_pdf01", % ch_nic_01_02_intro_pdf01, 1, 0, 1);
  add_actor_anim("intro_pdf02", % ch_nic_01_02_intro_pdf02, 0, 0, 1);
  add_actor_anim("intro_pdf03", % ch_nic_01_02_intro_pdf03, 0, 0, 1);
  add_actor_anim("intro_pdf04", % ch_nic_01_02_intro_pdf04, 0, 0, 1);
  add_actor_anim("intro_cartel_guard", % ch_nic_01_02_intro_guard, 1, 0, 1, 1);
  add_prop_anim("josephina_door", % o_nic_01_02_intro_door, undefined, 0, 1);
  add_prop_anim("intro_shard", % o_nic_01_02_intro_shard, "t6_wpn_glass_shard_prop", 1);
  add_prop_anim("intro_syringe", % o_nic_01_02_intro_syringe, "p6_anim_syringe", 1);
  add_notetrack_exploder("josefina", "hit_vanity", 60);
  add_notetrack_custom_function("intro_pdf04", "fire", maps\nicaragua_intro::intro_guard_fx);
  add_notetrack_custom_function("player_body", "rage_start", maps\nicaragua_intro::menendez_intro_part2_rage_start);
  add_notetrack_custom_function("player_body", "black_screen", maps\nicaragua_intro::menendez_intro_not_mature_black_screen);
  add_notetrack_custom_function("player_body", "rage", maps\nicaragua_intro::menendez_intro_part1_rage_notetrack);
  add_notetrack_custom_function("player_body", "stab", maps\nicaragua_intro::menendez_intro_glass_stab);
  add_notetrack_custom_function("player_body", "b", maps\nicaragua_intro::menendez_intro_bloody_viewbody);
  add_notetrack_custom_function("player_body", "blur", maps\nicaragua_intro::menendez_intro_blur);
  add_notetrack_custom_function("player_body", "start_fade", maps\nicaragua_intro::menendez_intro_part1_fade_notetrack);
  add_scene("menendez_intro_part2_picture", "josephina_room");
  add_prop_anim("intro_picture_frame", % o_nic_01_01_intro_picture, "p6_anim_picture_table_silver1_4x6", 1);
}

show_spas() {
  noriega = get_ais_from_scene("noriega_arrives", "noriega");
  noriega gun_remove();
  spas = getent("spas", "targetname");
  spas show();
}

hide_spas() {
  noriega = get_ais_from_scene("noriega_arrives", "noriega");
  noriega gun_recall();
  spas = getent("spas", "targetname");
  spas hide();
}

#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

noriega_intro_anims() {
  add_scene("noriega_arrives", "shot_in_back");
  add_player_anim("player_body", % ch_nic_02_01_noriega_arrives_player, 1, 0, undefined, 1, 1, 20, 20, 20, 20);
  add_actor_anim("noriega", % ch_nic_02_01_noriega_arrives_noriega, 0, 0, 0, 1);
  add_prop_anim("spas", % o_nic_02_01_noriega_arrives_spas_idle, "t6_wpn_shotty_spas_world", 1);
  add_notetrack_exploder("player_body", "mud", 102);
  add_notetrack_custom_function("player_body", "start_prop", ::show_spas);
  add_notetrack_custom_function("player_body", "end_prop", ::hide_spas);
  add_notetrack_custom_function("player_body", "rage_start", maps\nicaragua_intro::noriega_arrives_low_rage);
  add_notetrack_custom_function("player_body", "high_rage", maps\nicaragua_intro::player_no_headlook_during_scene);
  add_notetrack_custom_function("player_body", "high_rage", maps\nicaragua_intro::noriega_arrives_high_rage);
  add_notetrack_custom_function("player_body", "m", maps\nicaragua_intro::noriega_arrives_muddy_viewbody);
  add_notetrack_custom_function("player_body", "punch_noriega", maps\nicaragua_intro::noriega_arrives_head_switch);
  add_notetrack_custom_function("player_body", "free_look_on", maps\nicaragua_intro::give_player_headlook_during_scene);
  add_notetrack_custom_function("player_body", "spas_switch", maps\nicaragua_intro::noriega_arrives_spas_swap);
  add_notetrack_custom_function("player_body", "look_at_mission", maps\nicaragua_intro::noriega_arrives_look_at_mission);
  add_notetrack_custom_function("noriega", "fire", maps\nicaragua_intro::noriega_arrives_pdf_blood);
  add_scene("noriega_arrives_cuffs", "shot_in_back");
  add_prop_anim("handcuffs", % o_nic_02_01_noriega_arrives_cuffs, "p6_anim_handcuffs_80s");
  add_scene("noriega_arrives_pdf_1", "shot_in_back");
  add_actor_anim("noriega_arrives_pdf_1", % ch_nic_02_01_noriega_arrives_pdf01, 0, 0, 0, 1, undefined, "noriega_arrives_pdf");
  add_scene("noriega_arrives_pdf_2", "shot_in_back");
  add_actor_anim("noriega_arrives_pdf_2", % ch_nic_02_01_noriega_arrives_pdf02, 0, 0, 0, 1, undefined, "noriega_arrives_pdf");
}

village_intro_anims() {
  add_scene("mh_shot_in_the_back_civs", "shot_in_back");
  add_actor_anim("mh_shot_in_the_back_pdf_1", % ch_nic_03_01_shot_in_the_back_pdf01, 0, 0, 0, 0, undefined, "generic_pdf");
  add_scene("mh_civ_carries_civ", "anim_civ_carries_civ");
  add_actor_anim("mh_shot_in_the_back_civ_4", % ch_nic_03_01_shot_in_the_back_civ04, 1, 0, 0, 1, undefined, "generic_civ_male");
  add_actor_anim("mh_shot_in_the_back_civ_5", % ch_nic_03_01_shot_in_the_back_civ05, 1, 0, 0, 1, undefined, "generic_civ_female");
}

village_ai_intros() {
  add_scene("village_pdf_kicks_villager", "shot_in_back");
  add_actor_anim("village_pdf_kicker", % ch_nic_03_01_ambient_deaths_pdf01, 0, 1, 0, 0);
  add_actor_anim("village_villager_kicked", % ch_nic_03_01_ambient_deaths_civ01, 0, 1, 0, 0);
}

village_pdf_ransacking_anims() {
  add_scene("door_death");
  add_actor_anim("generic", % ch_nic_03_01_village_door_death_pdf01, 0, 0, 0, 1);
  add_notetrack_custom_function("generic", undefined, ::door_death_started);
}

door_death_started(ai_door_death) {
  wait 0.05;
  ai_door_death notify("door_death_started");
}

village_heycart_animations() {
}

#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");

village_execution_anims_old() {
  add_scene("execution_player_intro_axe", "axe_grab");
  add_prop_anim("execution_axe", % o_nic_03_1_axe_hack_grab_axe, "t6_wpn_axe_prop", 0, 1);
  add_scene("execution_player_axe_grab", "axe_grab");
  add_player_anim("player_body", % p_nic_03_1_axe_hack_grab_axe, 1);
  add_prop_anim("execution_axe", % o_nic_03_1_axe_hack_grab_axe, "t6_wpn_axe_prop", 0, 1);
  add_actor_anim("axe_guy_1", % ch_nic_03_1_axe_hack_axe_hack_pdf_01, 0, 0, 0, 0);
  add_actor_anim("axe_guy_2", % ch_nic_03_1_axe_hack_axe_hack_pdf_02, 0, 0, 0, 0);
  add_scene("village_execution_villagers_wait_loop", "axe_grab", 0, 0, 1);
  add_actor_anim("village_execution_male1_spawner", % ch_nic_03_01_village_execution_civ01_loop, 0, 1);
  add_actor_anim("village_execution_female1_spawner", % ch_nic_03_01_village_execution_civ02_loop, 0, 1);
  add_actor_anim("village_execution_male2_spawner", % ch_nic_03_01_village_execution_civ03_loop, 0, 1);
  add_actor_anim("village_execution_female2_spawner", % ch_nic_03_01_village_execution_civ04_loop, 0, 1);
  add_scene("village_execution_enemy_wait_loop", "axe_grab", 0, 0, 1);
  add_actor_anim("village_executioner_1", % ch_nic_03_01_village_execution_pdf01_loop, 0, 1);
  add_actor_anim("village_executioner_2", % ch_nic_03_01_village_execution_pdf02_loop, 0, 1);
  add_actor_anim("village_executioner_3", % ch_nic_03_01_village_execution_pdf03_loop, 0, 1);
  add_actor_anim("village_executioner_4", % ch_nic_03_01_village_execution_pdf04_loop, 0, 1);
  add_scene("village_execution_enemy_scene", "axe_grab");
  add_actor_anim("village_execution_male1_spawner", % ch_nic_03_01_village_execution_civ01, 0, 1);
  add_actor_anim("village_execution_female1_spawner", % ch_nic_03_01_village_execution_civ02, 0, 1);
  add_actor_anim("village_execution_male2_spawner", % ch_nic_03_01_village_execution_civ03, 0, 1);
  add_actor_anim("village_execution_female2_spawner", % ch_nic_03_01_village_execution_civ04, 0, 1);
  add_scene("village_execution_villagers_scene", "axe_grab");
  add_actor_anim("village_executioner_1", % ch_nic_03_01_village_execution_pdf01, 0, 1);
  add_actor_anim("village_executioner_2", % ch_nic_03_01_village_execution_pdf02, 0, 1);
  add_actor_anim("village_executioner_3", % ch_nic_03_01_village_execution_pdf03, 0, 1);
  add_actor_anim("village_executioner_4", % ch_nic_03_01_village_execution_pdf04, 0, 1);
  add_scene("execution_ground_idles", "axe_grab", 0, 0, 1);
  add_actor_anim("execution_grounds_guy_1", % ch_nic_03_1_execution_idle_pdf_01, 0, 1, 0, 0, undefined);
  add_actor_anim("execution_grounds_guy_2", % ch_nic_03_1_execution_idle_pdf_02, 0, 1, 0, 0, undefined);
  add_actor_anim("execution_grounds_guy_3", % ch_nic_03_1_execution_idle_pdf_03, 0, 1, 0, 0, undefined);
  add_actor_anim("execution_grounds_guy_4", % ch_nic_03_1_execution_idle_pdf_04, 0, 1, 0, 0, undefined);
  add_actor_anim("execution_grounds_guy_5", % ch_nic_03_1_execution_idle_pdf_05, 0, 1, 0, 0, undefined);
  add_scene("excecution_ground_reactions", "axe_grab", 0, 0, 0);
  add_actor_anim("execution_grounds_guy_1", % ch_nic_03_1_execution_react_pdf_01, 0, 1, 0, 0, undefined);
  add_actor_anim("execution_grounds_guy_2", % ch_nic_03_1_execution_react_pdf_02, 0, 1, 0, 0, undefined);
  add_actor_anim("execution_grounds_guy_3", % ch_nic_03_1_execution_react_pdf_03, 0, 1, 0, 0, undefined);
  add_actor_anim("execution_grounds_guy_4", % ch_nic_03_1_execution_react_pdf_04, 0, 1, 0, 0, undefined);
  add_actor_anim("execution_grounds_guy_5", % ch_nic_03_1_execution_react_pdf_05, 0, 1, 0, 0, undefined);
}

#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

village_execution_anims() {
  add_scene("execution_loop", "axe_grab", 0, 0, 1);
  add_actor_anim("execution_civ_1", % ch_nic_03_01_village_execution_civ01_loop, 1, 0, 0, 1, undefined, "execution_civ_female");
  add_actor_anim("execution_civ_2", % ch_nic_03_01_village_execution_civ02_loop, 1, 0, 0, 1, undefined, "execution_civ_male");
  add_actor_anim("execution_civ_3", % ch_nic_03_01_village_execution_civ03_loop, 1, 0, 0, 1, undefined, "execution_civ_female");
  add_actor_anim("execution_civ_4", % ch_nic_03_01_village_execution_civ04_loop, 1, 0, 0, 1, undefined, "execution_civ_male");
  add_actor_anim("execution_civ_5", % ch_nic_03_01_village_execution_civ05_loop, 1, 0, 0, 1, undefined, "execution_civ_female");
  add_actor_anim("execution_pdf_1", % ch_nic_03_01_village_execution_pdf01_loop, 0, 0, 0, 1, undefined, "executioner");
  add_actor_anim("execution_pdf_2", % ch_nic_03_01_village_execution_pdf02_loop, 0, 0, 0, 1, undefined, "executioner");
  add_actor_anim("execution_pdf_3", % ch_nic_03_01_village_execution_pdf03_loop, 0, 0, 0, 1, undefined, "executioner");
  add_actor_anim("execution_pdf_4", % ch_nic_03_01_village_execution_pdf04_loop, 0, 0, 0, 1, undefined, "executioner");
  add_scene("execution_civ_1", "axe_grab");
  add_actor_anim("execution_civ_1", % ch_nic_03_01_village_execution_civ01, 1);
  add_scene("execution_civ_2", "axe_grab");
  add_actor_anim("execution_civ_2", % ch_nic_03_01_village_execution_civ02, 1);
  add_scene("execution_civ_3", "axe_grab");
  add_actor_anim("execution_civ_3", % ch_nic_03_01_village_execution_civ03, 1);
  add_scene("execution_civ_4", "axe_grab");
  add_actor_anim("execution_civ_4", % ch_nic_03_01_village_execution_civ04, 1);
  add_scene("execution_civ_5", "axe_grab");
  add_actor_anim("execution_civ_5", % ch_nic_03_01_village_execution_civ05, 1);
  add_scene("execution_pdf_1", "axe_grab");
  add_actor_anim("execution_pdf_1", % ch_nic_03_01_village_execution_pdf01);
  add_scene("execution_pdf_2", "axe_grab");
  add_actor_anim("execution_pdf_2", % ch_nic_03_01_village_execution_pdf02);
  add_scene("execution_pdf_3", "axe_grab");
  add_actor_anim("execution_pdf_3", % ch_nic_03_01_village_execution_pdf03);
  add_scene("execution_pdf_4", "axe_grab");
  add_actor_anim("execution_pdf_4", % ch_nic_03_01_village_execution_pdf04);
  add_scene("execution_pdf_5", "axe_grab");
  add_actor_anim("execution_pdf_5", % ch_nic_03_01_village_execution_pdf05);
  add_scene("execution_escape_1", "axe_grab");
  add_actor_anim("execution_civ_1", % ch_nic_03_01_village_execution_civ01_escape, 1);
  add_scene("execution_escape_2", "axe_grab");
  add_actor_anim("execution_civ_2", % ch_nic_03_01_village_execution_civ02_escape, 1);
  add_scene("execution_escape_3", "axe_grab");
  add_actor_anim("execution_civ_3", % ch_nic_03_01_village_execution_civ03_escape, 1);
  add_scene("execution_escape_4", "axe_grab");
  add_actor_anim("execution_civ_4", % ch_nic_03_01_village_execution_civ04_escape, 1);
  add_scene("execution_escape_5", "axe_grab");
  add_actor_anim("execution_civ_5", % ch_nic_03_01_village_execution_civ05_escape, 1);
  add_scene("axe_attack_pdf_loop", "axe_grab", 0, 0, 1);
  add_actor_anim("execution_pdf_5", % ch_nic_03_01_village_execution_pdf05_loop, 0, 0, 0, 1, undefined, "executioner");
  add_scene("axe_attack_pdf", "axe_grab");
  add_actor_anim("execution_pdf_5", % ch_nic_03_1_axe_hack_axe_hack_pdf_01);
  add_scene("axe_attack_prop", "axe_grab");
  add_prop_anim("axe", % o_nic_03_1_axe_hack_grab_axe, "t6_wpn_axe_prop");
  add_notetrack_fx_on_tag("axe", "axe_hit", "flesh_hit_axe_chest", "TAG_FX");
  add_scene("axe_attack_player", "axe_grab");
  add_player_anim("player_body", % p_nic_03_1_axe_hack_grab_axe, 1);
  add_scene("execution_watchers_idle", "axe_grab", 0, 0, 1);
  add_actor_anim("roof_pdf", % ch_nic_03_1_execution_idle_pdf_01, 0, 0, 0, 0, undefined, "execution_watcher_pdf");
  add_actor_anim("molotov_pdf", % ch_nic_03_1_execution_idle_pdf_03, 0, 0, 0, 0, undefined, "executioner");
  add_scene("execution_watcher_react_roof", "axe_grab");
  add_actor_anim("roof_pdf", % ch_nic_03_1_execution_react_pdf_01);
  add_scene("execution_watcher_react_molotov", "axe_grab");
  add_actor_anim("molotov_pdf", % ch_nic_03_1_execution_react_pdf_03);
  add_scene("execution_molotv_idle", "axe_grab", 0, 0, 1);
  add_prop_anim("molotov_idle", % o_nic_03_1_execution_idle_molotv, "t6_wpn_molotov_cocktail_prop_world", 1, 1);
  add_scene("execution_molotv_react", "axe_grab");
  add_prop_anim("molotov_react", % o_nic_03_1_execution_react_molotov, "t6_wpn_molotov_cocktail_prop_world", 1, 1);
  add_notetrack_exploder("molotov_react", "explode", 110);
  add_scene("slide_to_cover", "anim_slide_to_cover", 1);
  add_actor_anim("execution_pdf_1", % slide_across_car_2_cover);
}

brutality_scenes() {
  add_scene("brutality_civ_idle_1", undefined, 0, 0, 1);
  add_actor_anim("generic", % ch_nic_03_01_pdf_brutality_civ_01_idle);
  add_scene("brutality_pdf_idle_1", undefined, 0, 0, 1);
  add_actor_anim("generic", % ch_nic_03_01_pdf_brutality_pdf_01_idle);
  add_scene("brutality_civ_react_1");
  add_actor_anim("generic", % ch_nic_03_01_pdf_brutality_civ_01_react);
  add_scene("brutality_pdf_react_1");
  add_actor_anim("generic", % ch_nic_03_01_pdf_brutality_pdf_01_react);
  add_scene("brutality_civ_idle_2", undefined, 0, 0, 1);
  add_actor_anim("generic", % ch_nic_03_01_pdf_brutality_civ_02_idle);
  add_scene("brutality_pdf_idle_2", undefined, 0, 0, 1);
  add_actor_anim("generic", % ch_nic_03_01_pdf_brutality_pdf_02_idle);
  add_scene("brutality_civ_react_2");
  add_actor_anim("generic", % ch_nic_03_01_pdf_brutality_civ_02_react);
  add_scene("brutality_pdf_react_2");
  add_actor_anim("generic", % ch_nic_03_01_pdf_brutality_pdf_02_react);
}

#using_animtree("animated_props");
#using_animtree("player");

stables_door() {
  add_scene("barn_doors", "barn_door");
  add_prop_anim("barn_door", % o_nicaragua_barn_door_open_door);
  add_scene("barn_door_player", "barn_door");
  add_player_anim("player_body", % int_nicaragua_barn_door_open, 1);
}

#using_animtree("generic_human");

balcony_throw() {
  add_scene("balcony_throw", "cartel_rally");
  add_actor_anim("balcony_throw_civ", % ch_nic_03_02_balcony_throw_civ, 1, 0, 0, 1, undefined, "generic_civ_male");
  add_actor_anim("balcony_throw_pdf", % ch_nic_03_02_balcony_throw_pdf, 0, 0, 0, 0, undefined, "generic_pdf");
}

stables_weapons_cache_anims() {
}

stables_woman_attacked_anims_old() {
}

stables_woman_attacked_anims() {
}

stables_exit_cartel_ralley() {
}

mission_banister_jumpdown() {
}

#using_animtree("animated_props");
#using_animtree("player");

mansion_menendez_meets_mason() {
  add_scene("shattered_1", "grenade_hallway");
  add_actor_anim("hudson", % ch_nic_04_01_shattered_hudson, 0, 1, 1);
  add_actor_anim("woods", % ch_nic_04_01_shattered_woods, 0, 1, 1);
  add_actor_anim("mason_intro_anim", % ch_nic_04_01_shattered_mason, 0, 1, 1);
  add_prop_anim("shattered_part2_door", % o_nic_04_01_shattered_door, undefined, 0, 1);
  add_prop_anim("josephina_hallway_door", % o_nic_04_01_shattered_door_02, undefined, 0, 1);
  add_prop_anim("grenade_shattered", % viewmodel_nic_04_01_shattered_grenade, "t6_wpn_grenade_m67_prop_view", 1);
  add_player_anim("player_body", % p_nic_04_01_shattered_menendez, 1, 0, undefined, 1, 1, 20, 20, 20, 20);
  add_notetrack_custom_function("player_body", "slow_mo_start", maps\nicaragua_menendez_hallway::shattered_1_slow_mo_start);
  add_notetrack_custom_function("player_body", "slow_mo_end", maps\nicaragua_menendez_hallway::shattered_1_slow_mo_end);
  add_notetrack_custom_function("player_body", "explosion", maps\nicaragua_menendez_hallway::shattered_1_explosion);
}

#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");

mason_intro_anims() {
  add_scene("mason_intro", "mason_introscene");
  add_actor_anim("hudson", % ch_nic_05_01_recon_hudson);
  add_actor_anim("woods", % ch_nic_05_01_recon_woods);
  add_actor_anim("noriega", % ch_nic_05_01_recon_noriega, 1, 1);
  add_player_anim("player_body", % ch_nic_05_01_recon_player, 1, 0, undefined, 1, 1, 20, 20, 20, 20);
  add_notetrack_detach("hudson", "detach_binocular", "p6_binoculars_anim", "tag_weapon_left");
  add_notetrack_attach("player_body", "snap_binocular", "p6_binoculars_anim", "tag_weapon1");
  add_notetrack_custom_function("player_body", "fade_out", maps\nicaragua_intro::recon_1_notify_done);
  add_scene("mason_intro_switch_to_menendez", "josephina_room");
  add_actor_model_anim("menendez", % ch_nic_05_01_recon_scope_mendendez_intro, undefined, 1, undefined, undefined, "menendez");
  add_notetrack_custom_function("menendez", "fade_to_menendez", maps\nicaragua_intro::mason_intro_window_view_fade_to_menendez);
  add_scene("mason_intro_window_view", "josephina_room");
  add_actor_anim("intro_cartel_guard", % ch_nic_05_01_recon_scope_guard, 1, 0, 1, 1);
  add_actor_anim("intro_pdf01", % ch_nic_05_01_recon_scope_pdf01, 1, 0, 1, 1);
  add_actor_anim("intro_pdf02", % ch_nic_05_01_recon_scope_pdf02, 1, 0, 1, 1);
  add_actor_anim("intro_pdf03", % ch_nic_05_01_recon_scope_pdf03, 1, 0, 1, 1);
  add_actor_anim("intro_pdf04", % ch_nic_05_01_recon_scope_pdf04, 0, 0, 1, 1);
  add_prop_anim("josephina_door", % o_nic_05_01_recon_scope_door, undefined, 0, 1);
  add_actor_model_anim("menendez", % ch_nic_05_01_recon_scope_mendendez, undefined, 1, undefined, undefined, "menendez");
  add_actor_model_anim("menendez_reflection", % ch_nic_05_01_recon_scope_mendendez_reflection, undefined, 1, undefined, undefined, "menendez");
  add_notetrack_custom_function("intro_pdf04", "fire", maps\nicaragua_intro::intro_guard_fx);
  add_notetrack_custom_function("menendez", "fade_out", maps\nicaragua_mason_intro::mason_intro_window_view_fade_out);
  add_scene("fxanim_blanket_2nd", undefined, 0, 0, 0, 1);
  add_prop_anim("fxanim_blanket", % fxanim_nic_blanket_anim);
  add_scene("mason_intro_part2_player", "mason_introscene");
  add_player_anim("player_body", % ch_nic_05_02_recon_go_player, 1, 0, undefined, 1, 1, 40, 40, 40, 40);
  add_scene("mason_intro_part2_hudson", "mason_introscene");
  add_actor_anim("hudson", % ch_nic_05_02_recon_go_hudson, 0, 1, 0, 0);
  add_scene("mason_intro_part2_woods", "mason_introscene");
  add_actor_anim("woods", % ch_nic_05_02_recon_go_woods, 0, 1, 0, 0);
  add_scene("mason_intro_part2_noriega", "mason_introscene");
  add_actor_anim("noriega", % ch_nic_05_02_recon_go_noriega, 1, 1, 0, 0);
}

#using_animtree("player");
#using_animtree("animated_props");

mason_intruder_perk() {
  add_scene("intruder_perk", "intruder_box");
  add_player_anim("player_body", % int_specialty_nicaragua_intruder, 1, 0, undefined, 0, 1, 20, 20, 20, 20);
  add_prop_anim("boltcutters", % o_specialty_nicaragua_intruder_boltcutter, "t6_wpn_boltcutters_prop_view", 1, 0);
  add_prop_anim("grabbed_molotov", % o_specialty_nicaragua_intruder_grabbed_molotov, "t6_wpn_molotov_cocktail_prop_world", 1, 1);
  add_prop_anim("molotov1", % o_specialty_nicaragua_intruder_filler_molotov_1, "t6_wpn_molotov_cocktail_prop_world", 1, 1);
  add_prop_anim("molotov2", % o_specialty_nicaragua_intruder_filler_molotov_2, "t6_wpn_molotov_cocktail_prop_world", 1, 1);
  add_prop_anim("intruder_box", % o_specialty_nicaragua_intruder_strongbox, undefined, 0, 0);
}

#using_animtree("generic_human");

mason_hill_fire_deaths() {
  add_scene("wave1_fire_window", "mason_hill_wave1_fire_window", 1, 1);
  add_actor_anim("generic", % ai_mantle_window_dive_36, 0, 1, 0, 0);
}

mason_hill_molotov_toss() {
  add_scene("molotov_toss_1", "molotov_1", 1, 1);
  add_actor_anim("generic", % ai_stand_exposed_grenade_throwa_nic_02, 0, 1, 0, 1);
  add_notetrack_attach("generic", "grenade_right", "t6_wpn_molotov_cocktail_prop_world", "tag_inhand");
  add_notetrack_custom_function("generic", "molotov_light", maps\nicaragua_mason_hill::molotov_1_light);
  add_notetrack_custom_function("generic", "molotov_detach", maps\nicaragua_mason_hill::molotov_1_detach);
  add_scene("molotov_toss_2", "molotov_2", 1, 1);
  add_actor_anim("generic", % ai_stand_exposed_grenade_throwa_nic_01, 0, 1, 0, 1);
  add_notetrack_attach("generic", "grenade_right", "t6_wpn_molotov_cocktail_prop_world", "tag_inhand");
  add_notetrack_custom_function("generic", "molotov_light", maps\nicaragua_mason_hill::molotov_2_light);
  add_notetrack_custom_function("generic", "molotov_detach", maps\nicaragua_mason_hill::molotov_2_detach);
}

#using_animtree("vehicles");
#using_animtree("generic_human");

mason_truck() {
  add_scene("mason_truck_stop", "truck_crash");
  add_vehicle_anim("mason_truck", % fxanim_nic_truck_stop_anim);
  add_notetrack_custom_function("mason_truck", "exploder 10650 #trough_1_break", maps\nicaragua_mason_truck::trough_1_break);
  add_scene("mason_truck_crash", "truck_crash");
  add_vehicle_anim("mason_truck", % fxanim_nic_truck_crash_anim);
  add_notetrack_custom_function("mason_truck", "exploder 10650 #trough_1_break", maps\nicaragua_mason_truck::trough_1_break);
  add_notetrack_custom_function("mason_truck", "exploder 10651 #trough_2_break", maps\nicaragua_mason_truck::trough_2_break);
  add_notetrack_custom_function("mason_truck", "exploder 10652 #fence_break", maps\nicaragua_mason_truck::fence_break);
  add_notetrack_custom_function("mason_truck", "exploder 10653 #truck_hits_tree", maps\nicaragua_mason_truck::truck_hits_tree);
  add_scene("mason_truck_driver_death", "mason_truck", 0, 1, 0);
  add_actor_anim("generic", % ai_crew_pickup_truck_driver_death_shot, 1, 0, 0, 1, "tag_driver");
  add_scene("mason_truck_passenger_crash_idle", "mason_truck", 0, 1, 1);
  add_actor_anim("generic", % ai_crew_pickup_truck_passenger_crash_idle, 1, 0, 0, 1, "tag_passenger");
  add_scene("mason_truck_passenger_crash_death", "mason_truck", 0, 1, 0);
  add_actor_anim("generic", % ai_crew_pickup_truck_passenger_crash, 1, 0, 0, 1, "tag_passenger");
  add_scene("mason_truck_pdf_corpse", "mason_truck_pdf_corpse_struct");
  add_actor_model_anim("mason_truck_pdf_corpse", % ch_gen_m_wall_armcraddle_leanleft_deathpose, undefined, 1, undefined, undefined, undefined, 0);
}

#using_animtree("animated_props");

mason_donkeykong() {
  add_scene("wagon_traversal", "wagon_traversal", 1, 0);
  add_actor_anim("donkeykong_wagon_traversal", % ai_mantle_over_36_down_90, 0, 1);
  add_scene("woods_freakout_doors", "to_the_balcony");
  add_prop_anim("woods_freakout_doors", % o_nic_06_08_balcony_doors_start, undefined, 0, 0);
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");

mason_woods_freakout() {
  add_scene("woods_freakout_intro_HUDSON", "to_the_balcony", 1);
  add_actor_anim("hudson", % ch_nic_06_08_balcony_hudson_intro, 0, 1);
  add_scene("woods_freakout_intro_WOODS", "to_the_balcony", 1);
  add_actor_anim("woods", % ch_nic_06_08_balcony_woods_intro, 0, 1);
  add_scene("woods_freakout_idle_HUDSON", "to_the_balcony", 0, 0, 1);
  add_actor_anim("hudson", % ch_nic_06_08_balcony_hudson_idle, 0, 1);
  add_scene("woods_freakout_idle_WOODS", "to_the_balcony", 0, 0, 1);
  add_actor_anim("woods", % ch_nic_06_08_balcony_woods_idle, 0, 1);
  add_scene("woods_freakout", "to_the_balcony", 1, 0);
  add_actor_anim("hudson", % ch_nic_06_08_balcony_fence_strugle_hudson, 0, 1);
  add_actor_anim("woods", % ch_nic_06_08_balcony_fence_strugle_woods, 0, 1);
  add_notetrack_custom_function("woods", "start_anim", maps\nicaragua_mason_woods_freakout::woods_freakout_menendez);
  add_notetrack_custom_function("woods", "door_open", maps\nicaragua_mason_woods_freakout::balcony_door_open);
  add_prop_anim("woods_freakout_doors", % o_nic_06_08_balcony_doors, undefined, 0, 0);
  add_scene("woods_freakout_menendez", "stables");
  add_actor_anim("menendez_rage", % ch_nic_06_08_balcony_fence_strugle_menendez, 0, 1, 1, 1);
  add_notetrack_custom_function("menendez_rage", "explosion", maps\nicaragua_mason_woods_freakout::menendez_stables_explosion);
  add_notetrack_custom_function("menendez_rage", "doors_open", maps\nicaragua_mason_woods_freakout::menendez_opens_stables_door);
  add_prop_anim("stables_doors", % o_nic_06_08_balcony_fence_strugle_menendez, "p6_anim_nic_barn_door_01", 0, 0);
}

#using_animtree("player");
#using_animtree("animated_props");

bruteforce_perk_anims() {
  add_scene("bruteforce_perk", "intruder_garage");
  add_player_anim("player_body", % int_specialty_nicaragua_bruteforce, 1, 0, undefined, 0, 1, 20, 20, 20, 20);
  add_notetrack_custom_function("player_body", "rumble_light", maps\nicaragua_mason_to_mission::bruteforce_rumble_light);
  add_notetrack_custom_function("player_body", "rumble_med", maps\nicaragua_mason_to_mission::bruteforce_rumble_med);
  add_notetrack_custom_function("player_body", "mortar_pickup", maps\nicaragua_mason_to_mission::bruteforce_mortar_pickup);
  add_prop_anim("bruteforce_garagedoor", % o_specialty_nicaragua_bruteforce_door, undefined, 0, 0);
  add_prop_anim("crowbar", % o_specialty_nicaragua_bruteforce_crowbar, "t6_wpn_crowbar_prop", 1, 1);
  add_prop_anim("filler_mortar1", % o_specialty_nicaragua_bruteforce_filler_mortar1, undefined, 0, 1);
  add_prop_anim("filler_mortar2", % o_specialty_nicaragua_bruteforce_filler_mortar2, undefined, 0, 1);
  add_prop_anim("filler_mortar3", % o_specialty_nicaragua_bruteforce_filler_mortar3, undefined, 0, 1);
  add_prop_anim("grabbed_mortar1", % o_specialty_nicaragua_bruteforce_grabbed_mortar1, "t6_wpn_mortar_shell_world", 1, 1);
  add_prop_anim("grabbed_mortar2", % o_specialty_nicaragua_bruteforce_grabbed_mortar2, "t6_wpn_mortar_shell_world", 1, 1);
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("player");
#using_animtree("generic_human");
#using_animtree("animated_props");

mason_split_up() {
  add_scene("split_up_start_woods_START", "pdf_bunker_entry", 1, 0);
  add_actor_anim("woods", % ch_nic_06_14_split_up_woods_loop, 0, 1, 0, 1);
  add_scene("split_up_start_hudson_START", "pdf_bunker_entry", 1, 0);
  add_actor_anim("hudson", % ch_nic_06_14_split_up_hudson_loop, 0, 1, 0, 1);
  add_scene("split_up_start_pdf_01_START", "pdf_bunker_entry", 1, 0);
  add_actor_anim("bunker_redshirt_pdf", % ch_nic_06_14_split_up_pdf_01_loop, 0, 1, 0, 1);
  add_scene("split_up_start_pdf_02_START", "pdf_bunker_entry", 1, 0);
  add_actor_anim("split_up_pdf_02", % ch_nic_06_14_split_up_pdf_02_loop, 0, 1, 0, 1);
  add_scene("split_up_start_pdf_03_START", "pdf_bunker_entry", 1, 0);
  add_actor_anim("split_up_pdf_03", % ch_nic_06_14_split_up_pdf_03_loop, 0, 1, 0, 1);
  add_scene("split_up_start_woods_LOOP", "pdf_bunker_entry", 0, 0, 1);
  add_actor_anim("woods", % ch_nic_06_14_split_up_woods_loop, 0, 1, 0, 1);
  add_scene("split_up_start_hudson_LOOP", "pdf_bunker_entry", 0, 0, 1);
  add_actor_anim("hudson", % ch_nic_06_14_split_up_hudson_loop, 0, 1, 0, 1);
  add_scene("split_up_start_pdf_01_LOOP", "pdf_bunker_entry", 0, 0, 1);
  add_actor_anim("bunker_redshirt_pdf", % ch_nic_06_14_split_up_pdf_01_loop, 0, 1, 0, 1);
  add_scene("split_up_start_pdf_02_LOOP", "pdf_bunker_entry", 0, 0, 1);
  add_actor_anim("split_up_pdf_02", % ch_nic_06_14_split_up_pdf_02_loop, 0, 1, 0, 1);
  add_scene("split_up_start_pdf_03_LOOP", "pdf_bunker_entry", 0, 0, 1);
  add_actor_anim("split_up_pdf_03", % ch_nic_06_14_split_up_pdf_03_loop, 0, 1, 0, 1);
  add_scene("split_up_start_woods", "pdf_bunker_entry");
  add_actor_anim("woods", % ch_nic_06_14_split_up_woods, 0, 1, 0, 1);
  add_scene("split_up_start_hudson", "pdf_bunker_entry");
  add_actor_anim("hudson", % ch_nic_06_14_split_up_hudson, 0, 1, 0, 1);
  add_scene("split_up_start_pdf_01", "pdf_bunker_entry");
  add_actor_anim("bunker_redshirt_pdf", % ch_nic_06_14_split_up_pdf_01, 0, 1, 0, 1);
  add_scene("split_up_start_pdf_02", "pdf_bunker_entry");
  add_actor_anim("split_up_pdf_02", % ch_nic_06_14_split_up_pdf_02, 0, 1, 0, 1);
  add_scene("split_up_start_pdf_03", "pdf_bunker_entry");
  add_actor_anim("split_up_pdf_03", % ch_nic_06_14_split_up_pdf_03, 0, 1, 0, 1);
  add_scene("split_up_hudson_idle", "pdf_bunker_entry", 0, 0, 1);
  add_actor_anim("hudson", % ch_nic_06_14_split_up_hudson_idle, 0, 1);
  add_scene("split_up_pdf_02_idle", "pdf_bunker_entry", 0, 0, 1);
  add_actor_anim("split_up_pdf_02", % ch_nic_06_14_split_up_pdf_02_idle, 0, 1);
  add_scene("split_up_pdf_03_idle", "pdf_bunker_entry", 0, 0, 1);
  add_actor_anim("split_up_pdf_03", % ch_nic_06_14_split_up_pdf_03_idle, 0, 1);
  add_scene("split_up_enter_woods", "pdf_bunker_entry", 1);
  add_actor_anim("woods", % ch_nic_06_14_split_up_woods_enter, 0, 1);
  add_scene("split_up_enter_pdf", "pdf_bunker_entry", 1);
  add_actor_anim("bunker_redshirt_pdf", % ch_nic_06_14_split_up_pdf_enter, 0, 1, 0, 1);
  add_scene("split_up_start_idle_woods", "pdf_bunker_entry", 0, 0);
  add_actor_anim("woods", % ch_nic_06_14_split_up_woods_start_idle, 0, 1);
  add_prop_anim("bunker_entry_gate", % o_nic_06_14_split_up_door_start_idle, undefined, 0, 0);
  add_prop_anim("mason_bunker_hatch", % o_nic_06_14_split_up_hatch_start_idle, undefined, 0, 1);
  add_scene("split_up_start_idle_pdf", "pdf_bunker_entry", 0, 0);
  add_actor_anim("bunker_redshirt_pdf", % ch_nic_06_14_split_up_pdf_start_idle, 0, 1, 0, 1);
  add_scene("split_up_climb_down", "pdf_bunker_entry");
  add_actor_anim("woods", % ch_nic_06_14_split_up_woods_climb_down, 0, 1);
  add_actor_anim("bunker_redshirt_pdf", % ch_nic_06_14_split_up_pdf_climb_down, 0, 1, 0, 1);
  add_notetrack_custom_function("bunker_redshirt_pdf", "door_kick", maps\nicaragua_mason_bunker::split_up_door_kick);
  add_prop_anim("bunker_entry_gate", % o_nic_06_14_split_up_door_open, undefined, 0, 0);
  add_prop_anim("mason_bunker_hatch", % o_nic_06_14_split_up_hatch_enter, undefined, 0, 1);
  add_scene("bunker_enter", "pdf_bunker_entry");
  add_player_anim("player_body", % ch_nic_06_14_bunker_enter_player, 1, 0, undefined, 1, 1, 40, 40, 40, 40);
  add_actor_anim("hudson_bunker_entery", % ch_nic_06_14_bunker_enter_hudson, 0, 1, 1, 1);
  add_scene("close_hatch", "pdf_bunker_entry");
  add_prop_anim("mason_bunker_hatch", % o_nic_06_14_split_up_hatch_close, undefined, 0, 1);
}

#using_animtree("player");
#using_animtree("animated_props");

lockbreaker_perk_anims() {
  add_scene("lockbreaker_perk", "machete_vault");
  add_player_anim("player_body", % int_specialty_nicaragua_lockbreaker, 1, 0, undefined, 0, 1, 20, 20, 20, 20);
  add_notetrack_flag("player_body", "door_open", "lockbreaker_door_open");
  add_notetrack_flag("player_body", "machete_pickup", "lockbreaker_machete_picked_up");
  add_prop_anim("lock_pick", % o_specialty_nicaragua_lockbreaker_device, "t6_wpn_lock_pick_view", 1, 0);
  add_prop_anim("lockbreaker_machete", % o_specialty_nicaragua_lockbreaker_grabbed_machete, undefined, 1, 1);
  add_prop_anim("lockbreaker_door", % o_specialty_nicaragua_lockbreaker_door, undefined, 0, 1);
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");

mason_bunker_cokeworkers() {
  add_scene("bunker_coke_worker_1", "anim_align_bunker_tables", 0, 0, 1);
  add_actor_anim("bunker_coke_worker_1", % ch_nic_06_16_bunker_cartel_worker01, 1, 1);
  add_scene("bunker_coke_worker_2", "anim_align_bunker_tables", 0, 0, 1);
  add_actor_anim("bunker_coke_worker_2", % ch_nic_06_16_bunker_cartel_worker02, 1, 1);
  add_scene("bunker_coke_worker_4", "anim_align_bunker_tables", 0, 0, 1);
  add_actor_anim("bunker_coke_worker_4", % ch_nic_06_16_bunker_cartel_worker04, 1, 1);
  add_scene("bunker_coke_worker_5", "anim_align_bunker_tables", 0, 0, 1);
  add_actor_anim("bunker_coke_worker_5", % ch_nic_06_16_bunker_cartel_worker05, 1, 1);
  add_scene("bunker_coke_worker_1_react", "anim_align_bunker_tables");
  add_actor_anim("bunker_coke_worker_1", % ch_nic_06_16_bunker_cartel_worker01_react, 1, 1);
  add_scene("bunker_coke_worker_2_react", "anim_align_bunker_tables");
  add_actor_anim("bunker_coke_worker_2", % ch_nic_06_16_bunker_cartel_worker02_react, 1, 1);
  add_scene("bunker_coke_worker_4_react", "anim_align_bunker_tables");
  add_actor_anim("bunker_coke_worker_4", % ch_nic_06_16_bunker_cartel_worker04_react, 1, 1);
  add_scene("bunker_coke_worker_5_react", "anim_align_bunker_tables");
  add_actor_anim("bunker_coke_worker_5", % ch_nic_06_16_bunker_cartel_worker05_react, 1, 1);
  add_scene("bunker_tables_idle", "anim_align_bunker_tables");
  add_prop_anim("bunker_cartel_tabel_01", % o_nic_06_16_bunker_cartel_tablel_02_idle, undefined, 0, 1);
  add_prop_anim("bunker_cartel_tabel_03", % o_nic_06_16_bunker_cartel_tablel_01_idle, undefined, 0, 1);
  add_scene("bunker_table_kick_1", "anim_align_bunker_tables");
  add_actor_anim("bunker_cartel_table_watch01_ai", % ch_nic_06_16_bunker_cartel_cartel_01_react, 0, 1, 0, 1);
  add_prop_anim("bunker_cartel_tabel_01", % o_nic_06_16_bunker_cartel_tablel_02_react, undefined, 0, 1);
  add_notetrack_custom_function("bunker_cartel_tabel_01", "start_flip", maps\nicaragua_mason_bunker::bunker_table_flipped_01);
  add_scene("bunker_table_kick_2", "anim_align_bunker_tables");
  add_actor_anim("bunker_cartel_table_watch03_ai", % ch_nic_06_16_bunker_cartel_cartel_02_react, 0, 1, 0, 1);
  add_prop_anim("bunker_cartel_tabel_03", % o_nic_06_16_bunker_cartel_tablel_01_react, undefined, 0, 1);
  add_notetrack_custom_function("bunker_cartel_tabel_03", "start_flip", maps\nicaragua_mason_bunker::bunker_table_flipped_03);
  add_scene("bunker_civilian_run_01", "woods_doorkick");
  add_actor_anim("bunker_civilian_run_01", % ch_nic_06_16_bunker_cocaine_run_civ01, 1, 0, 0, 0);
  add_notetrack_custom_function("bunker_civilian_run_01", "begin_anim", maps\nicaragua_mason_bunker::bunker_table_civilian_run_01_begin_anim);
  add_scene("bunker_civilian_run_02", "woods_doorkick");
  add_actor_anim("bunker_civilian_run_02", % ch_nic_06_16_bunker_cocaine_run_civ02, 1, 0, 0, 0);
  add_notetrack_custom_function("bunker_civilian_run_02", "begin_anim", maps\nicaragua_mason_bunker::bunker_table_civilian_run_02_begin_anim);
  add_scene("bunker_civilian_run_03", "woods_doorkick");
  add_actor_anim("bunker_civilian_run_03", % ch_nic_06_16_bunker_cocaine_run_civ03, 1, 0, 0, 0);
  add_notetrack_custom_function("bunker_civilian_run_03", "begin_anim", maps\nicaragua_mason_bunker::bunker_table_civilian_run_03_begin_anim);
  add_notetrack_custom_function("bunker_civilian_run_03", "attach_cocaine", maps\nicaragua_mason_bunker::bunker_table_civilian_run_03_attach_cocaine);
  add_scene("bunker_cartel_frantic", "anim_align_bunker_tables");
  add_actor_anim("generic", % ch_nic_06_16_bunker_cartel_frantic, 0, 1);
  add_scene("bunker_cartel_frantic_reaction", "anim_align_bunker_tables");
  add_actor_anim("generic", % ch_nic_06_16_bunker_cartel_frantic_reaction, 0, 1);
  add_scene("bunker_cartel_table_watch01", "anim_align_bunker_tables");
  add_actor_anim("generic", % ch_nic_06_16_bunker_cartel_table_watch01, 0, 1);
  add_scene("bunker_cartel_table_watch01_reaction", "anim_align_bunker_tables");
  add_actor_anim("generic", % ch_nic_06_16_bunker_cartel_table_watch01_reaction, 0, 1);
  add_scene("bunker_cartel_table_watch02", "anim_align_bunker_tables");
  add_actor_anim("generic", % ch_nic_06_16_bunker_cartel_table_watch02, 0, 1);
  add_scene("bunker_cartel_table_watch02_reaction", "anim_align_bunker_tables");
  add_actor_anim("generic", % ch_nic_06_16_bunker_cartel_table_watch02_reaction, 0, 1);
  add_scene("bunker_cartel_table_watch03", "anim_align_bunker_tables");
  add_actor_anim("generic", % ch_nic_06_16_bunker_cartel_table_watch03, 0, 1);
  add_scene("bunker_cartel_table_watch03_reaction", "anim_align_bunker_tables");
  add_actor_anim("generic", % ch_nic_06_16_bunker_cartel_table_watch03_reaction, 0, 1);
}

#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");

mason_bunker_paperburners() {
  add_scene("bunker_paper_burner_1", "woods_doorkick", 0, 0, 1);
  add_actor_anim("bunker_paper_burner_1", % ch_nic_06_16_evidence_cartel01_idle, 0, 1);
  add_prop_anim("evidence_box", % o_nic_06_16_evidence_cartel01_idle, "anim_com_copypaper_box_open", 0, 0);
  add_notetrack_custom_function("bunker_paper_burner_1", "paper_toss", maps\nicaragua_mason_bunker::paper_toss);
  add_scene("bunker_paper_burner_2", "woods_doorkick", 0, 0, 1);
  add_actor_anim("bunker_paper_burner_2", % ch_nic_06_16_evidence_cartel02_idle, 0, 1);
  add_prop_anim("evidence_gascan", % o_nic_06_16_evidence_cartel02_idle, "anim_rus_gascan", 0, 0);
  add_scene("bunker_paper_burner_1_react", "woods_doorkick");
  add_actor_anim("bunker_paper_burner_1", % ch_nic_06_16_evidence_cartel01_react, 0, 1);
  add_prop_anim("evidence_box", % o_nic_06_16_evidence_cartel01_react, undefined, 0, 0);
  add_scene("bunker_paper_burner_2_react", "woods_doorkick");
  add_actor_anim("bunker_paper_burner_2", % ch_nic_06_16_evidence_cartel02_react, 0, 1);
  add_notetrack_custom_function("bunker_paper_burner_2", "gascan_drop", maps\nicaragua_mason_bunker::gascan_drop);
  add_notetrack_custom_function("bunker_paper_burner_2", "match_flame", maps\nicaragua_mason_bunker::match_flame);
  add_prop_anim("evidence_gascan", % o_nic_06_16_evidence_cartel02_react, undefined, 0, 0);
}

#using_animtree("generic_human");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");

mason_woods_backbreaker() {
  add_scene("woods_bunker_exit_approach", "woods_backbreaker", 1, 0, 0);
  add_actor_anim("woods", % ch_nic_06_18_bunker_exit_approach_woods, 0, 1);
  add_scene("woods_bunker_exit_wait", "woods_backbreaker", 0, 0, 1);
  add_actor_anim("woods", % ch_nic_06_18_bunker_exit_wait_woods, 0, 1);
  add_scene("woods_bunker_exit", "woods_backbreaker");
  add_actor_anim("woods", % ch_nic_06_18_bunker_exit_woods, 0, 1);
  add_notetrack_custom_function("woods", "door_kick", maps\nicaragua_mason_final_push::woods_backbreaker_door_kick);
  add_notetrack_custom_function("woods", "door_fully_open", maps\nicaragua_mason_final_push::woods_backbreaker_door_fully_open);
  add_prop_anim("woods_bunker_exit_door", % o_nic_06_18_bunker_exit_door, undefined, 0, 1);
  add_scene("woods_backbreaker_idle", "woods_backbreaker", 0, 0, 1);
  add_actor_anim("woods", % ch_nic_06_18_backbreaker_woods_idle, 0, 1);
  add_scene("woods_backbreaker", "woods_backbreaker");
  add_actor_anim("woods", % ch_nic_06_18_backbreaker_woods, 0, 1);
  add_actor_anim("woods_backbreaker_cartel", % ch_nic_06_18_backbreaker_cartel, 1, 0, 0, 1);
  add_notetrack_custom_function("woods_backbreaker_cartel", "scuffle", maps\nicaragua_mason_final_push::woods_backbreaker_start_scuffle);
  add_notetrack_custom_function("woods_backbreaker_cartel", "head_slam", maps\nicaragua_mason_final_push::woods_backbreaker_head_slam);
  add_notetrack_custom_function("woods_backbreaker_cartel", "neck_snap", maps\nicaragua_mason_final_push::woods_backbreaker_neck_snap);
  add_notetrack_custom_function("woods_backbreaker_cartel", "become_corpse", maps\nicaragua_mason_final_push::woods_backbreaker_become_corpse);
  add_scene("woods_backbreaker_player", "woods_backbreaker");
  add_player_anim("player_body", % p_nic_06_18_backbreaker_player, 1, 0, undefined, 1, 1, 20, 20, 20, 20);
  add_notetrack_custom_function("player_body", "start_backbreaker", maps\nicaragua_mason_final_push::start_backbreaker);
}

#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("player");
#using_animtree("animated_props");

mason_shattered_parttwo() {
  add_scene("door_preshattered", "grenade_hallway");
  add_prop_anim("shattered_part2_door", % o_nic_04_01_shattered2_door, undefined, 0, 1);
  add_scene("mason_preshattered", "grenade_hallway", 1);
  add_actor_anim("woods", % ch_nic_04_01_shattered2_woods_runtoposition, 0, 1);
  add_scene("mason_preshattered_idle", "grenade_hallway", 0, 0, 1);
  add_actor_anim("woods", % ch_nic_04_01_shattered2_woods_idle, 0, 1);
  add_scene("mason_shattered_part2", "grenade_hallway");
  add_actor_anim("hudson", % ch_nic_04_01_shattered2_hudson, 0, 1);
  add_actor_model_anim("menendez_rage", % ch_nic_04_01_shattered2_menendez, undefined, 1, undefined, undefined, "menendez_rage");
  add_actor_anim("woods", % ch_nic_04_01_shattered2_woods, 0, 1);
  add_notetrack_custom_function("woods", "fire", maps\nicaragua_mason_shattered::woods_fires_gun);
  add_player_anim("player_body", % p_nic_04_01_shattered2_mason, 1, 0, undefined, 0, 1, 15, 15, 15, 15);
  add_notetrack_custom_function("player_body", "headbutt", maps\nicaragua_mason_shattered::woods_headbutt);
  add_notetrack_custom_function("player_body", "start_slow", maps\nicaragua_mason_shattered::shattered_part_two_timescale_slow);
  add_notetrack_custom_function("player_body", "start_normal", maps\nicaragua_mason_shattered::shattered_part_two_timescale_normal);
  add_notetrack_custom_function("player_body", "playercontrol_off", maps\nicaragua_mason_shattered::shattered_part_two_headlook_off);
  add_notetrack_custom_function("player_body", "start_explosion", maps\nicaragua_mason_shattered::shattered_part_two_grenade_explosion);
  add_prop_anim("shattered_part2_door", % o_nic_04_01_shattered2_door, undefined, 0, 1);
  add_prop_anim("grenade_shattered2", % o_nic_04_01_shattered2_grenade, "t6_wpn_grenade_m67_prop_view", 1);
}

#using_animtree("player");
#using_animtree("animated_props");
#using_animtree("generic_human");
#using_animtree("animated_props");

mason_outro() {
  add_scene("mason_outro", "move_the_rubble");
  add_player_anim("player_body", % ch_nic_08_02_outro_player, 1, 0, undefined, 1, 1, 40, 40, 40, 0);
  add_notetrack_custom_function("player_body", "dof_rubble", maps\createart\nicaragua_art::dof_rubble);
  add_notetrack_custom_function("player_body", "dof_woods1", maps\createart\nicaragua_art::dof_woods1);
  add_notetrack_custom_function("player_body", "dof_body", maps\createart\nicaragua_art::dof_body);
  add_notetrack_custom_function("player_body", "dof_woods2", maps\createart\nicaragua_art::dof_woods2);
  add_notetrack_custom_function("player_body", "dof_convo", maps\createart\nicaragua_art::dof_convo);
  add_notetrack_custom_function("player_body", "fade_out", maps\nicaragua_mason_outro::start_outro_fade);
  add_prop_anim("mason_outro_rubble_01", % o_nic_08_02_outro_rubble01, "prop_wood_beam_split02", 0, 1);
  add_prop_anim("mason_outro_rubble_02", % o_nic_08_02_outro_rubble02, "prop_wood_beam_split04", 0, 1);
  add_prop_anim("mason_outro_rubble_03", % o_nic_08_02_outro_rubble03, "prop_wood_beam_split01", 0, 1);
  add_prop_anim("mason_outro_rubble_04", % o_nic_08_02_outro_rubble04, "prop_wood_beam_split01", 0, 1);
  add_prop_anim("mason_outro_rubble_05", % o_nic_08_02_outro_rubble05, "prop_wood_beam_split02", 0, 1);
  add_prop_anim("mason_outro_rubble_06", % o_nic_08_02_outro_rubble06, "prop_wood_beam_split02", 0, 1);
  add_actor_anim("hudson", % ch_nic_08_02_outro_hudson, 0, 0);
  add_actor_anim("woods", % ch_nic_08_02_outro_woods, 0, 0);
  add_actor_anim("mason_outro_pdf_01", % ch_nic_08_02_outro_pdf_01, 1, 0);
  add_actor_anim("mason_outro_pdf_02", % ch_nic_08_02_outro_pdf_02, 1, 0);
  add_actor_anim("mason_outro_pdf_04", % ch_nic_08_02_outro_pdf_04, 0, 0);
  add_actor_anim("mason_outro_pdf_05", % ch_nic_08_02_outro_pdf_05, 0, 0);
  add_actor_anim("mason_outro_pdf_06", % ch_nic_08_02_outro_pdf_06, 0, 0);
  add_actor_anim("mason_outro_pdf_07", % ch_nic_08_02_outro_pdf_07, 0, 0);
  add_actor_anim("mason_outro_pdf_08", % ch_nic_08_02_outro_pdf_08, 0, 0);
  add_actor_anim("mason_outro_pdf_09", % ch_nic_08_02_outro_pdf_09, 1, 0);
  add_actor_anim("mason_outro_pdf_10", % ch_nic_08_02_outro_pdf_10, 0, 0);
  add_prop_anim("mason_outro_body_bag", % o_nic_08_02_outro_body_bag, "anim_jun_bodybag", 0, 0);
  add_prop_anim("mason_outro_gaz_truck", % o_nic_08_02_outro_ghaz_truck, "veh_t6_mil_gaz66", 0, 0);
  add_prop_anim("mason_outro_gaz_cargo", % o_nic_08_02_outro_ghaz_cargo, "veh_t6_mil_gaz66_cargo", 0, 0);
}

play_bell_rings(guy) {
  playsoundatposition("amb_bell_chime", (-3485, -9689, 2306));
  wait 2.9;
  playsoundatposition("amb_bell_chime", (-3485, -9689, 2306));
}

sndsnapshotintro(guy) {
  rpc("clientscripts/nicaragua_amb", "sndSnapshotIntro");
}