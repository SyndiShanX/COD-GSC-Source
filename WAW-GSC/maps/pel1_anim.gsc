/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\pel1_anim.gsc
*****************************************************/

#include maps\_utility;
#include maps\_anim;
#include common_scripts\utility;
#using_animtree("generic_human");

main() {
  level.scr_anim["in_water"]["run_deep_a"] = % ai_run_deep_water_a;
  level.scr_anim["in_water"]["run_deep_b"] = % ai_run_deep_water_b;
  level.scr_anim["in_water"]["run_shallow_a"] = % ai_run_shallow_water_a;
  level.scr_anim["in_water"]["run_shallow_b"] = % ai_run_shallow_water_b;
  level.scr_anim["in_water"]["run_shallow_d"] = % ai_run_shallow_water_d;
  level.scr_anim["flamebunker1"]["flamedeath"] = % ch_bunker_burnout_death_guy1;
  level.scr_anim["flamebunker1"]["dead"] = % ch_bunker_burnout_death_guy1_dead;
  level.scr_anim["flamebunker2"]["flamedeath"] = % ch_bunker_burnout_death_guy2;
  level.scr_anim["flamebunker2"]["dead"] = % ch_bunker_burnout_death_guy2_dead;
  level.scr_anim["pistol_jap"]["grab_loop"][0] = % ch_peleliu1_woundedjapanese1_loop;
  level.scr_anim["pistol_jap"]["fire"] = % ch_peleliu1_woundedjapanese1_fire;
  level.scr_anim["pistol_jap"]["death"] = % ch_peleliu1_woundedjapanese1_death;
  level.scr_anim["pillar_guy1"]["coverloop"][0] = % ch_peleliu1_pillarcover_guy1;
  level.scr_anim["pillar_guy2"]["coverloop"][0] = % ch_peleliu1_pillarcover_guy2;
  level.scr_anim["pillar_guy3"]["coverloop"][0] = % ch_peleliu1_pillarcover_guy3;
  level.scr_anim["pillar_guy4"]["coverloop"][0] = % ch_peleliu1_pillarcover_guy4;
  level.scr_anim["pillar_guy5"]["coverloop"][0] = % ch_peleliu1_pillarcover_guy5;
  level.scr_anim["pillar_guy6"]["coverloop"][0] = % ch_peleliu1_pillarcover_guy6;
  level.scr_anim["on_fire_run"]["on_fire"] = % ch_peleliu1_outbunker_guy1;
  level.scr_anim["on_fire_walk"]["on_fire"] = % ch_peleliu1_outbunker_guy2;
  level.scr_anim["grenade_jap"]["suicide"] = % ch_peleliu1_suicide_grenade;
  addNotetrack_attach("grenade_jap", "attach", "weapon_jap_type97_grenade", "tag_weapon_right", "suicide");
  addNotetrack_detach("grenade_jap", "detach", "weapon_jap_type97_grenade", "tag_weapon_right", "suicide");
  addNotetrack_customFunction("grenade_jap", "strike", ::event2_grenade_death_guy_explode, "suicide");
  level.scr_anim["wounded"]["wounded_loop"][0] = % ch_draggedSoldierA_wounded;
  level.scr_anim["wounded"]["drag_loop"][0] = % ch_draggedSoldierA_dragged;
  level.scr_anim["dragger"]["drag_loop"][0] = % ch_draggedSoldierA_dragging;
  level.scr_anim["ridein2"]["ride_in"] = % crew_lvt4_peleliu1_character2;
  level.scr_anim["ridein2"]["death"] = % crew_lvt4_peleliu1_character2_dead;
  level.scr_anim["ridein3"]["ride_in"] = % crew_lvt4_peleliu1_character3;
  level.scr_anim["ridein4"]["ride_in"] = % crew_lvt4_peleliu1_character4;
  level.scr_anim["ridein5"]["ride_in"] = % crew_lvt4_peleliu1_character5;
  level.scr_anim["ridein6"]["ride_in"] = % crew_lvt4_peleliu1_character6;
  level.scr_anim["ridein7"]["ride_in"] = % crew_lvt4_peleliu1_character7;
  level.scr_anim["ridein9"]["ride_in"] = % crew_lvt4_peleliu1_character9;
  level.scr_anim["berm1"]["over"] = % ai_climb_log_a_intro;
  level.scr_anim["berm2"]["over"] = % ai_climb_log_b_intro;
  level.scr_anim["berm3"]["over"] = % ai_climb_log_c_intro;
  level.scr_anim["berm4"]["over"] = % ai_climb_log_d_intro;
  level.scr_anim["berm5"]["over"] = % ai_climb_log_e_intro;
  level.scr_anim["berm6"]["over"] = % ai_climb_log_f_intro;
  level.scr_anim["berm7"]["over"] = % ai_climb_log_g_intro;
  level.scr_anim["berm8"]["over"] = % ai_climb_log_h_intro;
  level.scr_anim["sarge"]["over"] = % ai_climb_log_sarge_intro;
  level.scr_anim["flame"]["over"] = % ai_climb_log_flamethrower_intro;
  level.scr_anim["radioguy"]["coral_loop"][0] = % ch_peleliu1_coralcover_radio_guy3;
  level.scr_sound["radioguy"]["coral_loop"][0] = "Pel01_G1A_RADI_003A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_004A"] = "Pel01_G2A_RADI_004A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_005A"] = "Pel01_G2A_RADI_005A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_006A"] = "Pel01_G2A_RADI_006A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_008A"] = "Pel01_G2A_RADI_008A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_009A"] = "Pel01_G2A_RADI_009A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_010A"] = "Pel01_G2A_RADI_010A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_011A"] = "Pel01_G2A_RADI_011A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_012A"] = "Pel01_G2A_RADI_012A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_013A"] = "Pel01_G2A_RADI_013A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_014A"] = "Pel01_G2A_RADI_014A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_015A"] = "Pel01_G2A_RADI_015A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_016A"] = "Pel01_G2A_RADI_016A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_017A"] = "Pel01_G2A_RADI_017A";
  level.scr_sound["radioguy"]["Pel01_G2A_RADI_018A"] = "Pel01_G2A_RADI_018A";
  level.scr_anim["coralguy1"]["coral_loop"][0] = % ch_peleliu1_coralcover_guy1;
  level.scr_anim["coralguy2"]["coral_loop"][0] = % ch_peleliu1_coralcover_guy2;
  level.scr_anim["coralguy3"]["coral_loop"][0] = % ch_peleliu1_coralcover_guy4;
  level.scr_anim["coralguy4"]["coral_loop"][0] = % ch_peleliu1_coralcover_guy5;
  level.scr_anim["coralguy5"]["coral_loop"][0] = % ch_peleliu1_coralcover_guy6;
  level.scr_anim["dazedjap1"]["dazed"] = % ch_dazed_a;
  level.scr_anim["dazedjap2"]["dazed"] = % ch_dazed_b;
  level.scr_anim["dazedjap3"]["dazed"] = % ch_dazed_c;
  level.scr_anim["dazedjap4"]["dazed"] = % ch_dazed_d;
  level.scr_anim["dazedjap1"]["dazed_death"] = % ch_dazed_a_death;
  level.scr_anim["dazedjap2"]["dazed_death"] = % ch_dazed_b_death;
  level.scr_anim["dazedjap3"]["dazed_death"] = % ch_dazed_c_death;
  level.scr_anim["dazedjap4"]["dazed_death"] = % ch_dazed_d_death;
  level.scr_anim["float"]["floata"] = % ch_deadbody_floating_A;
  level.scr_anim["float"]["floatb"] = % ch_deadbody_floating_B;
  level.scr_sound["in_water"]["off_lvt1"] = "Pel01_G1A_ROEB_001A";
  level.scr_sound["in_water"]["off_lvt2"] = "Pel01_G1A_ROEB_002A";
  level.scr_sound["sarge"]["moveup_028a"] = "Pel01_G1A_ROEB_002A";
  level.scr_sound["sarge"]["moveup_029a"] = "Pel01_G2A_ROEB_029A";
  level.scr_sound["sarge"]["front_right_tunnel"] = "Pel01_G2A_ROEB_030A";
  level.scr_sound["sarge"]["deep_right_tunnel"] = "Pel01_G2A_ROEB_031A";
  level.scr_sound["sarge"]["sarge_out_of_hole"] = "Pel01_G2A_ROEB_003A";
  level.scr_sound["sarge"]["flame_banter"] = "Pel01_G2A_ROEB_001A";
  level.scr_sound["sarge"]["trap_door_open"] = "Pel01_G2A_ROEB_032A";
  level.scr_sound["polo"]["moveup_019a"] = "Pel01_G2A_POLO_019A";
  level.scr_sound["polo"]["moveup_025a"] = "Pel01_G2A_POLO_025A";
  level.scr_sound["polo"]["grenade_guy_warning"] = "Pel01_G2A_POLO_026A";
  level.scr_sound["polo"]["grenade_guy_past"] = "Pel01_G2A_POLO_027A";
  level.scr_sound["polo"]["bunker_explode"] = "Pel01_G2A_POLO_021A";
  level.scr_anim["grass_guy"]["prone_anim_fast"] = % ch_grass_prone2run_fast;
  level.scr_anim["grass_guy"]["prone_anim_fast"] = % ch_grass_prone2run_fast;
  level.scr_anim["grass_guy"]["prone_anim_fast_b"] = % ch_grass_prone2run_fast_b;
  level.scr_anim["generic"]["jog1"] = % ch_makinraid_creepy_run_guy1;
  level.scr_anim["generic"]["jog2"] = % ch_makinraid_creepy_run_guy2;
  level.scr_anim["generic"]["jog3"] = % ch_makinraid_creepy_run_guy3;
  level.scr_anim["generic"]["jog4"] = % ch_makinraid_creepy_run_guy4;
  level.scr_anim["underwater2"]["eject_lvt"] = % ch_pel1_underwater_death2;
  level.scr_anim["underwater1"]["eject_lvt"] = % ch_pel1_underwater_death;
  level.scr_anim["crawl1"]["crawl_crawl"] = % ch_berlin2_crawl1;
  level.scr_anim["crawl1"]["crawl_die"] = % ch_berlin2_crawl1_die;
  level.scr_anim["crawl1"]["crawl_idle"][0] = % ch_berlin2_crawl1_loop;
  level.scr_anim["crawl1"]["crawl_shot"] = % ch_berlin2_crawl1_shot;
  level.scr_anim["crawl2"]["crawl_crawl"] = % ch_berlin2_crawl2;
  level.scr_anim["crawl2"]["crawl_die"] = % ch_berlin2_crawl2_die;
  level.scr_anim["crawl2"]["crawl_idle"][0] = % ch_berlin2_crawl2_loop;
  level.scr_anim["crawl2"]["crawl_shot"] = % ch_berlin2_crawl2_shot;
  level.scr_anim["crawl3"]["crawl_crawl"] = % ch_berlin2_crawl3;
  level.scr_anim["crawl3"]["crawl_die"] = % ch_berlin2_crawl3_die;
  level.scr_anim["crawl3"]["crawl_idle"][0] = % ch_berlin2_crawl3_loop;
  level.scr_anim["crawl3"]["crawl_shot"] = % ch_berlin2_crawl3_shot;
  level.scr_anim["sarge"]["outro_start_old"] = % ch_peleliu1a_outro_roebuck;
  level.scr_anim["sullivan"]["outro_start_old"] = % ch_peleliu1a_outro_sullivan;
  level.scr_anim["officer"]["outro_start_old"] = % ch_peleliu1a_outro_japanese_officer;
  level.scr_anim["polo"]["outro_start_old"] = % ch_peleliu1a_outro_polonsky;
  level.scr_anim["sarge"]["outro_start"] = % ch_peleliu1a_outro_roebuck_v2;
  level.scr_anim["sullivan"]["outro_start"] = % ch_peleliu1a_outro_sullivan_v2;
  level.scr_anim["officer"]["outro_start"] = % ch_peleliu1a_outro_japanese_officer_v2;
  level.scr_anim["jackson"]["outro_start"] = % ch_peleliu1a_outro_jackson_v2;
  level.scr_anim["polo"]["outro_start"] = % ch_peleliu1a_outro_polonsky_v2;
  level.scr_sound["outro"]["outro1"] = "Pel1_OUT_200A_ROEB";
  level.scr_sound["outro"]["outro2"] = "Pel1_OUT_000B_SULL";
  level.scr_sound["outro"]["outro3"] = "Pel1_OUT_001B_SULL";
  level.scr_sound["outro"]["outro4"] = "Pel1_OUT_004A_POLO";
  level.scr_sound["outro"]["outro5"] = "Pel1_OUT_100A_SULL";
  level.scr_sound["outro"]["outro6"] = "Pel1_OUT_201A_USR1";
  level.scr_sound["outro"]["outro7"] = "Pel1_OUT_901A_JAS2";
  level.scr_sound["outro"]["outro8"] = "Pel1_OUT_900A_JAS2";
  level.scr_sound["outro"]["outro9"] = "sullivan_death_00";
  level.scr_sound["outro"]["outro10"] = "Pel1_OUT_006A_ROEB";
  level.scr_sound["outro"]["outro11"] = "Pel1_OUT_202A_ROEB";
  level.scr_anim["lvt_driver"]["drive_idle"][0] = % crew_lvt4_peleliu1_driver;
  level.scr_anim["lvt_passenger"]["drive_idle"][0] = % crew_jeep1_passenger1_drive_idle;
  level.scr_anim["sullivan"]["sullivan_pullout"] = % ch_pel1_underwater_sullivan;
  level.scr_sound["sullivan"]["sullivan_pullout1"] = "Pel1_IGD_300A_SULL";
  level.scr_sound["sullivan"]["sullivan_pullout2"] = "Pel1_IGD_301A_SULL";
  level.scr_sound["sullivan"]["sullivan_pullout3"] = "Pel1_IGD_100A_SULL";
  level.scr_sound["sullivan"]["barrge_use_intro1"] = "Pel1_IGD_101A_SULL";
  level.scr_sound["sullivan"]["barrge_use_intro2"] = "Pel1_IGD_103A_SULL";
  level.scr_sound["sullivan"]["barrge_use_intro3"] = "Pel1_IGD_104A_SULL";
  level.scr_sound["sullivan"]["barrge_use_intro4"] = "Pel1_IGD_105A_SULL";
  level.scr_sound["sullivan"]["barrge_use_intro5"] = "Pel1_IGD_106A_SULL";
  level.scr_sound["sullivan"]["barrge_use_intro6"] = "Pel1_IGD_107A_SULL";
  level.scr_sound["intro"]["intro1"] = "Pel1_INT_000A_SULL";
  level.scr_sound["intro"]["intro2"] = "Pel1_INT_001A_ROEB";
  level.scr_sound["intro"]["intro3"] = "Pel1_INT_002A_ROEB";
  level.scr_sound["intro"]["intro4"] = "Pel1_INT_004A_SULL";
  level.scr_sound["intro"]["intro5"] = "Pel1_INT_005A_ROEB";
  level.scr_sound["intro"]["intro6"] = "Pel1_INT_006A_ROEB";
  level.scr_sound["intro"]["intro7"] = "Pel1_INT_200A_ROEB";
  level.scr_sound["intro"]["intro8"] = "Pel1_INT_003A_SULL";
  level.scr_sound["intro"]["intro9"] = "Pel1_INT_007A_SULL";
  level.scr_sound["intro"]["intro10"] = "Pel1_INT_100A_ROEB";
  level.scr_sound["intro"]["intro11"] = "Pel1_INT_008A_SULL";
  level.scr_sound["intro"]["intro12"] = "Pel1_INT_009A_ROEB";
  level.scr_sound["intro"]["intro13"] = "Pel1_INT_010A_PSOU";
  level.scr_sound["intro"]["intro14"] = "Pel1_INT_101A_POLO";
  level.scr_sound["intro"]["intro15"] = "Pel1_INT_103A_USR2";
  level.scr_sound["intro"]["intro16"] = "Pel1_INT_011A_ROEB";
  level.scr_sound["intro"]["intro17"] = "Pel1_INT_013A_SULL";
  level.scr_sound["intro"]["intro18"] = "Pel1_INT_012A_PSOU";
  level.scr_sound["intro"]["intro19"] = "Pel1_INT_102A_SULL";
  level.scr_sound["intro"]["intro20"] = "Pel1_INT_015A_LVTD";
  level.scr_sound["intro"]["intro21"] = "Pel1_INT_016A_SULL";
  level.scr_sound["intro"]["intro22"] = "Pel1_INT_017A_POLO";
  level.scr_sound["intro"]["intro23"] = "Pel1_INT_018A_POLO";
  level.scr_sound["intro"]["intro24"] = "Pel1_INT_019A_SULL";
  level.scr_sound["intro"]["intro25"] = "Pel1_INT_020A_PSOU";
  level.scr_sound["intro"]["intro26"] = "Pel1_INT_021A_SULL";
  level.scr_sound["intro"]["intro27"] = "Pel1_INT_104A_SULL";
  level.scr_sound["sullivan"]["good_job"] = "Pel1_IGD_007A_SULL";
  level.scr_sound["sarge"]["moveup_beach1"] = "Pel1_IGD_203A_ROEB";
  level.scr_sound["sarge"]["moveup_beach2"] = "Pel1_IGD_204A_ROEB";
  level.scr_sound["polo"]["moveup_beach3"] = "Pel1_IGD_001A_POLO";
  level.scr_sound["sullivan"]["moveup_beach4"] = "Pel1_IGD_003A_SULL";
  level.scr_sound["sullivan"]["moveup_beach5"] = "Pel1_IGD_004A_SULL";
  level.scr_sound["sullivan"]["moveup_beach6a"] = "Pel1_IGD_312A_SULL";
  level.scr_sound["sullivan"]["moveup_beach6"] = "Pel1_IGD_008A_SULL";
  level.scr_sound["redshirt"]["moveup_beach_redshirt1"] = "Pel1_IGD_303A_USR1";
  level.scr_sound["redshirt"]["moveup_beach_redshirt2"] = "Pel1_IGD_304A_USR1";
  level.scr_sound["redshirt"]["moveup_beach_redshirt2a"] = "Pel1_IGD_311A_SULL";
  level.scr_sound["redshirt"]["moveup_beach_redshirt6"] = "Pel1_IGD_308A_USR1";
  level.scr_sound["redshirt"]["moveup_beach_redshirt7"] = "Pel1_IGD_309A_USR1";
  level.scr_sound["redshirt"]["moveup_beach_redshirt8"] = "Pel1_IGD_310A_USR3";
  level.scr_sound["polo"]["over_berm1"] = "Pel1_IGD_009A_POLO";
  level.scr_sound["sarge"]["over_berm2"] = "Pel1_IGD_010A_ROEB";
  level.scr_sound["sullivan"]["over_berm3"] = "Pel1_IGD_011A_SULL";
  level.scr_sound["sarge"]["over_berm4"] = "Pel1_IGD_012A_ROEB";
  level.scr_sound["sarge"]["over_berm5"] = "Pel1_IGD_013A_ROEB";
  level.scr_sound["polo"]["over_berm7"] = "Pel1_IGD_015A_POLO";
  level.scr_sound["sullivan"]["over_berm8"] = "Pel1_IGD_016A_SULL";
  level.scr_sound["sullivan"]["over_berm9"] = "Pel1_IGD_017A_SULL";
  level.scr_sound["sullivan"]["over_berm10"] = "Pel1_IGD_018A_SULL";
  level.scr_sound["sarge"]["first_fight1"] = "Pel1_IGD_019A_ROEB";
  level.scr_sound["sarge"]["first_fight2"] = "Pel1_IGD_021A_ROEB";
  level.scr_sound["sarge"]["first_fight3"] = "Pel1_IGD_022A_ROEB";
  level.scr_sound["sarge"]["first_fight4"] = "Pel1_IGD_023A_ROEB";
  level.scr_sound["sarge"]["first_fight5"] = "Pel1_IGD_024A_ROEB";
  level.scr_sound["sullivan"]["first_fight6"] = "Pel1_IGD_025A_SULL";
  level.scr_sound["sullivan"]["first_fight7"] = "Pel1_IGD_026A_SULL";
  level.scr_sound["sarge"]["first_fight9"] = "Pel1_IGD_028A_ROEB";
  level.scr_sound["sullivan"]["first_fight10"] = "Pel1_IGD_029A_SULL";
  level.scr_sound["sarge"]["first_fight11"] = "Pel1_IGD_030A_ROEB";
  level.scr_sound["sarge"]["first_fight12"] = "Pel1_IGD_031A_ROEB";
  level.scr_sound["sarge"]["tree_area1"] = "Pel1_IGD_032A_ROEB";
  level.scr_sound["sarge"]["tree_area2"] = "Pel1_IGD_033A_ROEB";
  level.scr_sound["polo"]["tree_area3"] = "Pel1_IGD_034A_POLO";
  level.scr_sound["sarge"]["tree_area4"] = "Pel1_IGD_035A_ROEB";
  level.scr_sound["sarge"]["tree_area5"] = "Pel1_IGD_036A_ROEB";
  level.scr_sound["sarge"]["tree_area6"] = "Pel1_IGD_037A_ROEB";
  level.scr_sound["sarge"]["tree_area7"] = "Pel1_IGD_038A_ROEB";
  level.scr_sound["sarge"]["tree_area8"] = "Pel1_IGD_039A_ROEB";
  level.scr_sound["polo"]["tree_area9"] = "Pel1_IGD_040A_POLO";
  level.scr_sound["sullivan"]["tree_area10"] = "Pel1_IGD_041A_SULL";
  level.scr_sound["sullivan"]["tree_area12"] = "Pel1_IGD_043A_SULL";
  level.scr_sound["sarge"]["tree_area13"] = "Pel1_IGD_044A_ROEB";
  level.scr_sound["sarge"]["tree_area14"] = "Pel1_IGD_045A_ROEB";
  level.scr_sound["sarge"]["third_fight1"] = "Pel1_IGD_046A_ROEB";
  level.scr_sound["sullivan"]["third_fight2"] = "Pel1_IGD_047A_SULL";
  level.scr_sound["sullivan"]["last_fight3"] = "Pel1_IGD_048A_SULL";
  level.scr_sound["sarge"]["third_fight4"] = "Pel1_IGD_049A_ROEB";
  level.scr_sound["sarge"]["third_fight5"] = "Pel1_IGD_050A_ROEB";
  level.scr_sound["sarge"]["third_fight6"] = "Pel1_IGD_051A_ROEB";
  level.scr_sound["sarge"]["third_fight7"] = "Pel1_IGD_052A_ROEB";
  level.scr_sound["sarge"]["third_fight8"] = "Pel1_IGD_053A_ROEB";
  level.scr_sound["sullivan"]["final_bunker1"] = "Pel1_IGD_054A_SULL";
  level.scr_sound["sarge"]["final_bunker2"] = "Pel1_IGD_055A_ROEB";
  level.scr_sound["sullivan"]["final_bunker3"] = "Pel1_IGD_056A_SULL";
  level.scr_sound["sarge"]["final_bunker4"] = "Pel1_IGD_057A_ROEB";
  level.scr_sound["sarge"]["final_bunker5"] = "Pel1_IGD_058A_ROEB";
  level.scr_sound["sarge"]["final_bunker6"] = "Pel1_IGD_059A_ROEB";
  level.scr_sound["sarge"]["final_bunker7"] = "Pel1_IGD_060A_ROEB";
  level.scr_sound["sullivan"]["final_bunker8"] = "Pel1_IGD_061A_SULL";
  level.scr_sound["sarge"]["final_bunker9"] = "Pel1_IGD_062A_ROEB";
  level.scr_sound["sullivan"]["final_bunker10"] = "Pel1_IGD_063A_SULL";
  level.scr_sound["sarge"]["final_bunker11"] = "Pel1_IGD_064A_ROEB";
  level.scr_sound["sullivan"]["final_bunker12"] = "Pel1_IGD_320A_SULL";
  level.scr_sound["sarge"]["use_rockets_end1"] = "Pel1_IGD_317A_ROEB";
  level.scr_sound["sarge"]["use_rockets_end2"] = "Pel1_IGD_318A_ROEB";
  level.scr_sound["sarge"]["use_rockets_end3"] = "Pel1_ThreatTank_Roebuck_00";
  level.scr_sound["sarge"]["use_rockets_end4"] = "Pel1_ThreatTank_Roebuck_01";
  level.scr_sound["polo"]["warn_get_back_here1"] = "Pel1_IGD_200A_POLO";
  level.scr_sound["polo"]["warn_get_back_here2"] = "Pel1_IGD_201A_POLO";
  level.scr_sound["polo"]["warn_get_back_here3"] = "Pel1_IGD_202A_POLO";
  level.scr_sound["polo"]["last_battle_flank_around1"] = "Pel1_IGD_207A_POLO";
  level.scr_sound["polo"]["last_battle_flank_around2"] = "Pel1_IGD_208A_POLO";
  level.scr_sound["sarge"]["last_battle_flank_around3"] = "Pel1_IGD_209A_ROEB";
  level.scr_sound["polo"]["last_battle_use_rockets1"] = "Pel1_IGD_210A_POLO";
  level.scr_sound["polo"]["last_battle_use_rockets2"] = "Pel1_IGD_211A_POLO";
  level.scr_sound["polo"]["last_battle_use_rockets3"] = "Pel1_IGD_212A_POLO";
  level.scr_sound["radioguy"]["rb_confirm_main"] = "Pel1_IGD_805A_RADO";
  level.scr_sound["radioguy"]["rb_bunker_confirmed"] = "Pel1_IGD_801A_RADO";
  level.scr_sound["radioguy"]["rb_hit_bunker"] = "Pel1_IGD_803A_RADO";
  level.scr_sound["radioguy"]["rb_miss1"] = "Pel1_IGD_804A_RADO";
  level.scr_sound["radioguy"]["rb_fire_generic1"] = "Pel1_IGD_841A_RADO";
  level.scr_sound["radioguy"]["rb_fire_generic2"] = "Pel1_IGD_801A_RADO";
  level.scr_sound["radioguy"]["rb_fire_generic3"] = "Pel1_IGD_811A_RADO";
  level.scr_sound["radioguy"]["rb_fire_generic4"] = "Pel1_IGD_845A_RADO";
  level.scr_sound["radioguy"]["rb_fire_generic5"] = "Pel1_IGD_842A_RADO";
  level.scr_sound["radioguy"]["rb_hit_enemy1"] = "Pel1_IGD_810A_RADO";
  level.scr_sound["radioguy"]["rb_hit_enemy2"] = "Pel1_IGD_811A_RADO";
  level.scr_sound["radioguy"]["rb_hit_enemy3"] = "Pel1_IGD_812A_RADO";
  level.scr_sound["radioguy"]["rb_charging1"] = "Pel1_IGD_813A_RADO";
  level.scr_sound["radioguy"]["rb_charging2"] = "Pel1_IGD_814A_RADO";
  level.scr_sound["radioguy"]["rb_counting"] = "Pel1_IGD_817A_RADO";
  level.scr_sound["radioguy"]["rb_counting_55"] = "Pel1_IGD_818A_RADO";
  level.scr_sound["radioguy"]["rb_counting_50"] = "Pel1_IGD_819A_RADO";
  level.scr_sound["radioguy"]["rb_counting_45"] = "Pel1_IGD_820A_RADO";
  level.scr_sound["radioguy"]["rb_counting_40"] = "Pel1_IGD_821A_RADO";
  level.scr_sound["radioguy"]["rb_counting_35"] = "Pel1_IGD_822A_RADO";
  level.scr_sound["radioguy"]["rb_counting_30"] = "Pel1_IGD_823A_RADO";
  level.scr_sound["radioguy"]["rb_counting_25"] = "Pel1_IGD_824A_RADO";
  level.scr_sound["radioguy"]["rb_counting_20"] = "Pel1_IGD_825A_RADO";
  level.scr_sound["radioguy"]["rb_counting_15"] = "Pel1_IGD_826A_RADO";
  level.scr_sound["radioguy"]["rb_counting_10"] = "Pel1_IGD_827A_RADO";
  level.scr_sound["radioguy"]["rb_counting_5"] = "Pel1_IGD_828A_RADO";
  level.scr_sound["radioguy"]["rb_ready_1"] = "Pel1_IGD_829A_RADO";
  level.scr_sound["radioguy"]["rb_ready_2"] = "Pel1_IGD_830A_RADO";
  level.scr_sound["radioguy"]["rb_ready_3"] = "Pel1_IGD_831A_RADO";
  level.scr_sound["radioguy"]["rb_ready_4"] = "Pel1_IGD_832A_RADO";
  level.scr_sound["radioguy"]["rb_ready_5"] = "Pel1_IGD_833A_RADO";
  level.scr_sound["radioguy"]["rb_ready_6"] = "Pel1_IGD_834A_RADO";
  level.scr_sound["radioguy"]["rb_ready_7"] = "Pel1_IGD_838A_RADO";
  level.scr_sound["radioguy"]["rb_ready_8"] = "Pel1_IGD_839A_RADO";
  level.scr_sound["radioguy"]["rb_fire_simple1"] = "Pel1_IGD_841A_RADO";
  level.scr_sound["radioguy"]["rb_fire_simple2"] = "Pel1_IGD_842A_RADO";
  level.scr_sound["radioguy"]["rb_cant_fire_there"] = "Pel1_IGD_844A_RADO";
  level.scr_sound["radioguy"]["rb_fire_simple3"] = "Pel1_IGD_845A_RADO";
  vehicle_anims();
  custom_drone_run_cycles();
}

event2_grenade_death_guy_explode(guy) {
  level.sarge magicgrenademanual(guy gettagorigin("tag_weapon_right") + (0, 0, 20), (0, 0, 0), 3.0);
}

hatch_guy_throw_grenade(guy) {
  point = anglestoforward(guy.angles);
  point = vectorScale(point, 70);
  orgs = getentarray("grenadetosspoint", "targetname");
  point = maps\pel1::getClosestEnt(guy.origin, orgs);
  grenadeOrigin = guy GetTagOrigin("tag_inhand");
  guy MagicGrenadeManual(point.origin, (0, 0, 0), randomfloatrange(2, 3.5));
}

#using_animtree("vehicles");

vehicle_anims() {
  level.scr_anim["playerlvt"]["ride_in"] = % v_lvt4_peleliu1_the_ride_in;
  level.scr_anim["deadlvts"]["sink"] = % v_lvt4_sinking;
  level.scr_anim["lvts"]["float_loop"] = % v_lvt4_float_loop;
  level.scr_anim["playerlvt"]["eject_tilt"] = % v_pel1_intro_LVT_explosion;
}

#using_animtree("vehicles");

tip_vehicle() {
  level.players_lvt UseAnimTree(#animtree);
  level.players_lvt clearanim( % v_lvt4_peleliu1_the_ride_in, 0);
  level.players_lvt setflaggedanim("tipping", % v_pel1_intro_LVT_explosion, 1, 0);
  wait 2;
  level.players_lvt clearanim( % v_pel1_intro_LVT_explosion, 0);
}

lvt_play_ride_in() {
  self setflaggedanim("ride_in", % v_lvt4_peleliu1_the_ride_in, 1, 0);
}

#using_animtree("fakeshooters");

custom_drone_run_cycles() {
  level.drone_run_cycle["run_deep_a"] = % ai_run_deep_water_a;
  level.drone_run_cycle["run_deep_b"] = % ai_run_deep_water_b;
  level.drone_run_cycle["run_fast"] = % combat_run_fast_3;
}

#using_animtree("player");

lvt_tipover() {
  level.scr_animtree["player"] = #animtree;
  mantle_anim = % int_pel1_intro_LVT_explosion;
  org = GetStartOrigin(level.players_lvt.origin, level.players_lvt.angles, mantle_anim);
  angles = GetStartAngles(level.players_lvt.origin, level.players_lvt.angles, mantle_anim);
  level.scr_model["viewmodel_usa_player"] = "viewmodel_usa_player";
  level.scr_animtree["viewmodel_usa_player"] = #animtree;
  hands = spawn_anim_model("viewmodel_usa_player");
  hands Hide();
  hands.origin = org;
  hands.angles = angles;
  hands SetVisibleToPlayer(self);
  lerp_time = 0.5;
  fraction = 1;
  right_arc = 20;
  left_arc = 20;
  top_arc = 10;
  bottom_arc = 10;
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] playerlinktodelta(hands, "tag_player", fraction, right_arc, left_arc, top_arc, bottom_arc, false);
    players[i] hide();
    if(getdvar("start") != "off_lvt") {
      players[i] detach("weapon_usa_m1garand_rifle", "tag_weapon_right");
    }
  }
  hands AnimScripted("mantle_anim", level.players_lvt.origin, level.players_lvt.angles + (0, 0, 0), mantle_anim);
  hands thread hands_notetrack_watcher();
  hands waittillmatch("mantle_anim", "play_sullivan_now");
  thread sullivan_pullout();
  hands waittillmatch("mantle_anim", "end");
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] unlink();
    if(i == 1) {
      point = getstruct("post_lvt_warp1", "script_noteworthy");
      players[i] thread warp_a_player(point);
    } else if(i == 2) {
      point = getstruct("post_lvt_warp2", "script_noteworthy");
      players[i] thread warp_a_player(point);
    } else if(i == 3) {
      point = getstruct("post_lvt_warp3", "script_noteworthy");
      players[i] thread warp_a_player(point);
    }
  }
  hands Delete();
  thread maps\pel1::set_objective(0.1);
  trig = getent("use_rocket_hint", "targetname");
  trig notify("trigger");
  SetSavedDvar("compass", "1");
  level notify("done underwater");
  players = get_players();
  for (i = 0; i < players.size; i++) {
    if(i != 0) {
      players[i] thread set_player_after_sullivan_scene();
    } else {
      players[i] freezecontrols(false);
      players[i] enableweapons(true);
      players[i] giveweapon("fraggrenade");
      players[i] givemaxammo("fraggrenade");
      if(isDefined(players[i]) && isDefined(players[i].lvt_linkspot)) {
        players[i] allowcrouch(true);
        players[i] allowprone(true);
        players[i].lvt_linkspot thread maps\pel1::delete_wait();
        players[i].lvt_linkspot_ref thread maps\pel1::delete_wait();
      }
    }
  }
  wait 0.2;
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] show();
  }
}

set_player_after_sullivan_scene() {
  self endon("disconnect");
  self endon("death");
  self waittill("coop_warp_complete");
  self freezecontrols(false);
  self enableweapons(true);
  self giveweapon("fraggrenade");
  self givemaxammo("fraggrenade");
  if(isDefined(self) && isDefined(self.lvt_linkspot)) {
    self allowcrouch(true);
    self allowprone(true);
    self.lvt_linkspot thread maps\pel1::delete_wait();
    self.lvt_linkspot_ref thread maps\pel1::delete_wait();
  }
}

sullivan_pullout() {
  level.sullivan thread pullout_dialog();
  level.sullivan thread anim_single_solo(level.sullivan, "sullivan_pullout", undefined, level.players_lvt);
  wait 2.25;
  thread maps\pel1::rumble_all_players("damage_heavy");
  wait 0.3;
  thread maps\pel1::rumble_all_players("damage_light");
  wait 0.3;
  thread maps\pel1::rumble_all_players("damage_light");
  wait 0.3;
  thread maps\pel1::rumble_all_players("damage_light");
  wait 0.3;
  thread maps\pel1::rumble_all_players("damage_heavy");
}

pullout_dialog() {
  self waittillmatch("single anim", "dialog");
  self playsound(level.scr_sound["sullivan"]["sullivan_pullout1"]);
  self waittillmatch("single anim", "dialog");
  self playsound(level.scr_sound["sullivan"]["sullivan_pullout2"]);
  self waittillmatch("single anim", "dialog");
  self playsound(level.scr_sound["sullivan"]["sullivan_pullout3"]);
}

hands_notetrack_watcher() {
  self waittillmatch("mantle_anim", "fade_in");
  level notify("fade_from_white");
  self waittillmatch("mantle_anim", "splash");
  thread maps\pel1::rumble_all_players("damage_heavy");
  model = spawn("script_model", self.origin + (-20, 0, 20));
  model setmodel("tag_origin");
  model linkto(self);
  model thread delete_in_a_bit(2.5);
  playfxontag(level._effect["splash_bubbles"], model, "tag_origin");
  self waittillmatch("mantle_anim", "start_anim");
  thread maps\pel1_anim::guys_underwater_getting_shot();
  level notify("start_underwater_anim");
}

delete_in_a_bit(time) {
  wait time;
  self delete();
}

#using_animtree("generic_human");

guys_underwater_getting_shot() {
  node = getnode("underwater_alignnode", "targetname");
  guy1 = maps\pel1::spawn_fake_guy_lvt(node.origin, node.angles, 1, "underwater1", "underwater_guy", 0);
  guy2 = maps\pel1::spawn_fake_guy_lvt(node.origin, node.angles, 1, "underwater2", "underwater_guy", 0);
  guys = [];
  guys[0] = guy1;
  guys[1] = guy2;
  guy1 thread underwater_notes1();
  guy2 thread underwater_notes2();
  guy1 thread underwater_bubbles();
  guy2 thread underwater_bubbles();
  thread random_underwater_tracers();
  guy1 thread animate_then_rag("eject_lvt", node);
  guy2 thread animate_then_rag("eject_lvt", node);
  level waittill("remove floaters");
  guy1 delete();
  guy2 delete();
}

underwater_bubbles() {
  self endon("stop bubbles");
  tags = [];
  tags[0] = "j_spineupper";
  tags[1] = "j_wrist_le";
  tags[2] = "j_wrist_ri";
  tags[3] = "j_ankle_ri";
  tags[4] = "j_ankle_le";
  while (1) {
    tag = tags[randomint(tags.size)];
    if(issubstr("spine", tag)) {
      playfx(level._effect["limb_bubbles"], self gettagorigin(tag));
    } else {
      playfx(level._effect["torso_bubbles"], self gettagorigin(tag));
    }
    wait 1;
  }
}

animate_then_rag(anim_ref, node) {
  self thread anim_single_solo(self, anim_ref, undefined, node);
  self waittill("eject_lvt");
}

random_underwater_tracers() {
  thread maps\pel1::event1_underwater_squib(true);
  wait 1;
  thread maps\pel1::event1_underwater_squib(true);
  wait 1.5;
  thread maps\pel1::event1_underwater_squib(true);
  wait 1.5;
  thread maps\pel1::event1_underwater_squib(true);
  wait 1;
  thread maps\pel1::event1_underwater_squib(true);
  wait 0.75;
  thread maps\pel1::event1_underwater_squib(true);
}

underwater_notes1() {
  self thread underwater_blood1();
  self waittillmatch("single anim", "tracer");
  thread maps\pel1::event1_underwater_squib();
  self waittillmatch("single anim", "tracer");
  thread maps\pel1::event1_underwater_squib();
  self waittillmatch("single anim", "start_ragdoll");
  self notify("stop bubbles");
  self startragdoll();
}

underwater_notes2() {
  self thread underwater_blood2();
  self waittillmatch("single anim", "tracer");
  thread maps\pel1::event1_underwater_squib();
  self waittillmatch("single anim", "start_ragdoll");
  self notify("stop bubbles");
  self startragdoll();
}

underwater_blood1() {
  wait 3;
  playfxontag(level._effect["uw_blood"], self, "j_hip_ri");
  wait 2;
  playfxontag(level._effect["uw_blood"], self, "j_spine4");
  wait 1.75;
  playfxontag(level._effect["uw_blood"], self, "j_clavicle_ri");
}

underwater_blood2() {
  wait 2;
  playfxontag(level._effect["uw_blood"], self, "j_spineupper");
  wait 1.5;
  playfxontag(level._effect["uw_blood"], self, "j_head");
  wait 2.5;
  playfxontag(level._effect["uw_blood"], self, "j_elbow_le");
}