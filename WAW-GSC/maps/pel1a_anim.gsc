/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pel1a_anim.gsc
*****************************************************/

#include maps\_utility;
#include maps\_anim;
#using_animtree("generic_human");

main() {
  event1();
  event1_bunker_doors();
  event2();
  event3();
  event4();
  new_dialogue();
  level thread do_collectible_corpse();
}

new_dialogue() {
  level.scr_sound["roebuck"]["intro1"] = "Pel1A_IGD_100A_ROEB";
  level.scr_sound["roebuck"]["intro2"] = "Pel1A_IGD_101A_ROEB";
  level.scr_sound["roebuck"]["intro3"] = "Pel1A_IGD_102A_ROEB";
  level.scr_sound["roebuck"]["intro4"] = "Pel1A_IGD_103A_ROEB";
  level.scr_sound["polonsky"]["first_mg1"] = "Pel1A_IGD_104A_POLO";
  level.scr_sound["polonsky"]["first_mg2"] = "Pel1A_IGD_105A_POLO";
  level.scr_sound["roebuck"]["first_mg3"] = "Pel1A_IGD_106A_ROEB";
  level.scr_sound["polonsky"]["first_mg4"] = "Pel1A_IGD_107A_POLO";
  level.scr_sound["roebuck"]["first_mg5"] = "Pel1A_IGD_108A_ROEB";
  level.scr_sound["roebuck"]["first_mg7"] = "Pel1A_IGD_110A_ROEB";
  level.scr_sound["roebuck"]["first_mg8"] = "Pel1A_IGD_111A_ROEB";
  level.scr_sound["roebuck"]["darn"] = "Pel1A_IGD_142A_ROEB";
  level.scr_sound["roebuck"]["first_mortar_pit1"] = "Pel1A_IGD_112A_ROEB";
  level.scr_sound["polonsky"]["first_mortar_pit2"] = "Pel1A_IGD_115A_POLO";
  level.scr_sound["roebuck"]["first_mortar_pit3"] = "Pel1A_IGD_116A_ROEB";
  level.scr_sound["roebuck"]["first_mortar_pit4"] = "Pel1A_IGD_117A_ROEB";
  level.scr_sound["roebuck"]["up_hill1"] = "Pel1A_IGD_113A_ROEB";
  level.scr_sound["roebuck"]["up_hill2"] = "Pel1A_IGD_114A_ROEB";
  level.scr_sound["polonsky"]["second_mortar_pit1"] = "Pel1A_IGD_118A_POLO";
  level.scr_sound["roebuck"]["second_mortar_pit2"] = "Pel1A_IGD_119A_ROEB";
  level.scr_sound["roebuck"]["second_mortar_pit3"] = "Pel1A_IGD_120A_ROEB";
  level.scr_sound["roebuck"]["second_mortar_pit4"] = "Pel1A_IGD_121A_ROEB";
  level.scr_sound["roebuck"]["barrel_enemies1"] = "Pel1A_IGD_122A_ROEB";
  level.scr_sound["polonsky"]["ridge_enemies1"] = "Pel1A_IGD_123A_POLO";
  level.scr_sound["roebuck"]["third_mortar_pit1"] = "Pel1A_IGD_124A_ROEB";
  level.scr_sound["roebuck"]["third_mortar_pit2"] = "Pel1A_IGD_125A_ROEB";
  level.scr_sound["roebuck"]["third_mortar_pit3"] = "Pel1A_IGD_126A_ROEB";
  level.scr_sound["roebuck"]["third_mortar_pit5"] = "Pel1A_IGD_128A_ROEB";
  level.scr_sound["radio_man"]["outro1"] = "Pel1A_IGD_131A_RADO";
  level.scr_sound["polonsky"]["outro2"] = "Pel1A_IGD_156A_POLO";
  level.scr_sound["roebuck"]["we_made_it"] = "Pel1A_IGD_157A_ROEB";
  level.scr_sound["roebuck"]["outro3"] = "Pel1A_IGD_129A_ROEB";
  level.scr_sound["roebuck"]["outro4"] = "Pel1A_IGD_130A_ROEB";
  level.scr_sound["polonsky"]["treesnipers"] = "Oki2_IGD_100A_POLO";
}

#using_animtree("generic_human");

do_collectible_corpse() {
  wait_for_first_player();
  spot = getstruct("collectible_body_align", "targetname");
  corpse = spawn("script_model", spot.origin);
  corpse character\char_jap_makpel_rifle::main();
  corpse UseAnimTree(#animtree);
  corpse.angles = spot.angles;
  corpse.animname = "collectible_dude";
  spot anim_single_solo(corpse, "hes_dead");
}

event1() {
  level.scr_anim["collectible_dude"]["hes_dead"] = % ch_pel1a_collectible;
  level.scr_anim["roebuck"]["event1_open_door"] = % ch_peleliu1a_intro_char1;
  level.scr_anim["polonsky"]["event1_open_door"] = % ch_peleliu1a_intro_char2;
  level.scr_sound["roebuck"]["intro_talk"] = "Pel01_C1A_ROEB_004A";
  level.scr_sound["polonsky"]["intro_talk"] = "Pel01_C1A_POLO_003A";
  level.scr_sound["roebuck"]["mortars_to_the_trenches"] = "Pel1A_G1A_ROEB_001A";
  level.scr_sound["radio_man"]["air_support"] = "Pel1A_G1A_RADI_002A";
  level.scr_sound["roebuck"]["mg_stay_low"] = "Pel1A_G1A_ROEB_002A";
  level.scr_sound["polonsky"]["plane_down1"] = "Pel1A_G1A_POLO_003A";
  level.scr_sound["polonsky"]["plane_down2"] = "Pel1A_G1A_POLO_006A";
  level.scr_sound["joiner"]["rush_talk"] = "Pel1A_G1A_ARS3_022A";
  level.scr_sound["roebuck"]["will_pop_smoke"] = "Pel1A_G1A_ROEB_005A";
  level.scr_sound["roebuck"]["popped_smoke"] = "Pel1A_G1A_ROEB_006A";
}

event2() {
  level.scr_sound["polonsky"]["take_out_mg"] = "Pel1A_G1A_POLO_007A";
}

event3() {
  level.scr_sound["polonsky"]["lookout"] = "Pel1A_G1A_POLO_012A";
}

event4() {
  level.scr_sound["polonsky"]["tanks_show_up"] = "Pel1A_G1A_POLO_013A";
  level.scr_sound["roebuck"]["glad_to_see"] = "Pel1A_G1A_ROEB_014A";
  level.scr_sound["polonsky"]["same_gun"] = "Pel1A_G1A_POLO_017A";
  level.scr_sound["roebuck"]["detour"] = "Pel1A_G1A_ROEB_016A";
  level.scr_anim["event4_door_kicker"]["kick_door"] = % door_kick_in;
  maps\_anim::addNotetrack_customFunction("event4_door_kicker", "kick", ::event4_kick_door_open, "kick_door");
  level.scr_sound["talker"]["found_one"] = "Pel1A_G1A_ARS2_019A";
  level.scr_sound["talker"]["more_info"] = "Pel1A_G1A_ARS3_023A";
  level.scr_sound["polonsky"]["3days"] = "Pel1A_G1A_ARS3_023A";
  level.scr_anim["event4_push_a_ally"]["intro"] = % ch_peleliu1_pushed_a_guy1_intro;
  level.scr_anim["event4_push_a_ally"]["loop"][0] = % ch_peleliu1_pushed_a_guy1_loop;
  level.scr_anim["event4_push_a_axis"]["intro"] = % ch_peleliu1_pushed_a_guy2_intro;
  level.scr_anim["event4_push_a_axis"]["loop"][0] = % ch_peleliu1_pushed_a_guy2_loop;
  level.scr_anim["event4_push_b_ally"]["intro"] = % ch_peleliu1_pushed_b_guy1_intro;
  level.scr_anim["event4_push_b_ally"]["loop"][0] = % ch_peleliu1_pushed_b_guy1_loop;
  level.scr_anim["event4_push_b_axis"]["intro"] = % ch_peleliu1_pushed_b_guy2_intro;
  level.scr_anim["event4_push_b_axis"]["loop"][0] = % ch_peleliu1_pushed_b_guy2_loop;
  PrecacheModel("weapon_jap_katana");
  level.scr_anim["event4_officer1"]["hara_kiri_idle"][0] = % ch_peleliu1a_outro_guy1_idle;
  level.scr_anim["event4_officer1"]["hara_kiri"] = % ch_peleliu1a_outro_guy1;
  level.scr_anim["event4_officer2"]["hara_kiri_idle"][0] = % ch_peleliu1a_outro_guy2_idle;
  level.scr_anim["event4_officer2"]["hara_kiri"] = % ch_peleliu1a_outro_guy2;
  level.scr_anim["generic"]["patroller"] = % patrol_bored_patrolwalk;
  level.scr_anim["generic"]["weary1"] = % Ai_walk_weary_c;
  level.scr_anim["generic"]["weary2"] = % Ai_walk_weary_d;
  level.scr_anim["generic"]["traffic_dude"][0] = % ch_holland3_traffic;
  level.scr_anim["generic"]["traffic_dude_reach"] = % ch_holland3_traffic;
  level.scr_sound["last_captor"]["shocked"] = "Pel1A_G1A_ARS3_025A";
  level.scr_sound["polonsky"]["hara_kiri"] = "Pel1A_G1A_POLO_026A";
}

event4_kick_door_open(guy) {
  door = GetEnt("kick_door1", "targetname");
  door ConnectPaths();
  door RotateTo((0, -115, 0), 0.5, 0, 0.1);
  node = GetNode("event4_kicker_spot1", "targetname");
  guy SetGoalNode(node);
  flankers = get_ai_group_ai("event4_flankers");
  nodes = GetNodeArray("event4_flank_nodes", "targetname");
  for(i = 0; i < flankers.size; i++) {
    flankers[i] SetGoalNode(nodes[i]);
  }
}

#using_animtree("pel1a_bunker_doors");

event1_bunker_doors() {
  PrecacheModel("tag_origin_animate");
  level.scr_animtree["bunker_door_left"] = #animtree;
  level.scr_animtree["bunker_door_right"] = #animtree;
  level.scr_model["bunker_door_left"] = "tag_origin_animate";
  level.scr_anim["bunker_door_left"]["open"] = % o_peleliu1a_intro_doorl;
  level.scr_model["bunker_door_right"] = "tag_origin_animate";
  level.scr_anim["bunker_door_right"]["open"] = % o_peleliu1a_intro_doorr;
}