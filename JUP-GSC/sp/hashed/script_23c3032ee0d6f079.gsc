/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_23c3032ee0d6f079.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\engine\utility;
#namespace namespace_e969b788a6a542a5;

function main() {
  anim_precache();
  player();
  humans();
  vehicle();
  function_ee7ebeaec9124cc4();
}

function anim_precache() {
  precachemodel("viewmodel_fullbody_sp_soap_mexico");
  precachemodel("veh9_civ_lnd_dirt_bike_farrah_hack");
}

#using_animtree("player");

function player() {
  var_7907568326d674ab = "player_rig";
  level.scr_animtree[var_7907568326d674ab] = #animtree;
  level.scr_model[var_7907568326d674ab] = "viewmodel_fullbody_sp_soap_party";
  level.scr_anim[var_7907568326d674ab]["infil"] = % jup_ranch_infil_vm_cam;
  level.scr_anim[var_7907568326d674ab]["exfil"] = % jup_ranch_exfil_vm_cam;
  level.scr_anim[var_7907568326d674ab]["outro_scene"] = % jup_ranch_1000_igc_outro_scene_plr_cam;
  level.scr_eventanim[var_7907568326d674ab]["outro_scene"] = % "jup_ranch_1000_igc_outro_scene_plr_cam";
}

#using_animtree("generic_human");

function humans() {
  thirdpersonplayer = "3rd_person_player";
  level.scr_animtree[thirdpersonplayer] = #animtree;
  level.scr_model[thirdpersonplayer] = "body_c_jup_sp_hero_farah_convoy";
  level.scr_anim[thirdpersonplayer]["infil"] = % jup_ranch_infil_npc;
  level.scr_anim[thirdpersonplayer]["exfil"] = % jup_ranch_exfil_npc;
  addnotetrack_notify(thirdpersonplayer, "vista_offbike", "vista_offbike", "infil");
  addnotetrack_notify(thirdpersonplayer, "vista_bikedown", "vista_bikedown", "infil");
  addnotetrack_notify(thirdpersonplayer, "vista_end", "vista_end", "infil");
  level.scr_anim["hostage_alex"]["surrender"] = % jup_ranch_exfil_alex_surrender;
  level.scr_anim["hostage_alex"]["kneel_2"][0] = % jup_ranch_exfil_alex_kneel_loop;
  level.scr_anim["hostage_alex"]["grab_gun_4"] = % jup_ranch_exfil_alex_freed;
  level.scr_anim["hostage_alex"]["outro_jltv_enter"] = % jup_ranch_1000_igc_outro_enter_alex;
  level.scr_anim["hostage_alex"]["outro_jltv_idle"][0] = % jup_ranch_1000_igc_outro_idle_alex;
  level.scr_anim["hostage_alex"]["outro_scene"] = % jup_ranch_1000_igc_outro_scene_alex;
  level.scr_anim["farah"]["outro_scene"] = % jup_ranch_1000_igc_outro_scene_farah;
  level.scr_animtree["enemy_01"] = #animtree;
  level.scr_model["enemy_01"] = "body_c_jup_sp_hero_farah_convoy";
  level.scr_anim["enemy_01"]["cine_shot"] = % jup_ranch_infil_shot06_enemy_01;
  level.scr_animtree["enemy_02"] = #animtree;
  level.scr_model["enemy_02"] = "body_c_jup_sp_hero_farah_convoy";
  level.scr_anim["enemy_02"]["cine_shot"] = % jup_ranch_infil_shot06_enemy_02;
  level.scr_animtree["corpse_01"] = #animtree;
  level.scr_model["corpse_01"] = "body_civ_london_male_2_1";
  level.scr_anim["corpse_01"]["cine_shot"] = % jup_ranch_infil_shot06_corpse_01;
  level.scr_animtree["corpse_02"] = #animtree;
  level.scr_model["corpse_02"] = "body_civ_london_female_4_1";
  level.scr_anim["corpse_02"]["cine_shot"] = % jup_ranch_infil_shot06_corpse_02;
}

#using_animtree("mp_vehicles_always_loaded");

function function_ee7ebeaec9124cc4() {
  level.scr_anim["jltv"]["outro_scene"] = % jup_ranch_1000_igc_outro_scene_jltv;
}

#using_animtree("vehicles");

function vehicle() {
  level.scr_animtree["dirtbike"] = #animtree;
  level.scr_animtree["jltv"] = #animtree;
  level.scr_model["dirtbike"] = "veh9_civ_lnd_dirt_bike_farrah_hack";
  level.scr_anim["dirtbike"]["infil"] = % jup_ranch_infil_veh;
  level.scr_anim["dirtbike"]["exfil"] = % jup_ranch_exfil_veh;
}