/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3a7a33fe428d8a7.gsc
************************************************/

#using scripts\common\anim;
#using scripts\engine\utility;
#namespace namespace_a8c165be2fe51298;

function main() {
  anim_precache();
  player();
  humans();
  script_models();
}

function anim_precache() {
  precachemodel("head_c_jup_sp_hero_farah_desert");
  precachemodel("body_c_jup_sp_enemy_pmc_grunt_02");
  precachemodel("head_c_jup_sp_enemy_pmc_grunt_02");
  precachemodel("body_c_jup_sp_enemy_pmc_grunt_03");
  precachemodel("head_c_jup_sp_enemy_pmc_grunt_03");
}

#using_animtree("player");

function player() {
  var_7907568326d674ab = "player_rig";
  level.scr_animtree[var_7907568326d674ab] = #animtree;
  level.scr_model[var_7907568326d674ab] = "viewmodel_fullbody_sp_soap_party";
  level.scr_anim[var_7907568326d674ab]["infil"] = % jup_port_infil_vm_cam;
  level.scr_anim[var_7907568326d674ab]["open_door"] = % jup_port_shipping_container_open_vm;
  level.scr_anim[var_7907568326d674ab]["open_door_front"] = % jup_port_shipping_container_open_vm_front;
  level.scr_anim[var_7907568326d674ab]["open_door_left"] = % jup_port_shipping_container_open_vm_left;
  level.scr_anim[var_7907568326d674ab]["open_door_right"] = % jup_port_shipping_container_open_vm_right;
}

#using_animtree("generic_human");

function humans() {
  thirdpersonplayer = "3rd_person_player";
  level.scr_animtree[thirdpersonplayer] = #animtree;
  level.scr_model[thirdpersonplayer] = "body_c_jup_sp_hero_farah_desert";
  level.scr_anim[thirdpersonplayer]["infil"] = % jup_port_infil_npc;
  level.scr_animtree["konni01"] = #animtree;
  level.scr_model["konni01"] = "body_c_jup_sp_enemy_pmc_grunt_02";
  level.scr_anim["konni01"]["iw9_mp_veh_jltv_seat_0_idle"][0] = % iw9_mp_veh_jltv_seat_0_idle;
  level.scr_anim["konni01"]["iw9_mp_veh_jltv_seat_1_idle"][0] = % iw9_mp_veh_jltv_seat_1_idle;
  addnotetrack_notify(thirdpersonplayer, "lgt_sss_lerp", "lgt_sss_lerp", "infil");
}

function script_model_anims() {}

function vehicle() {}

#using_animtree("script_model");

function script_models() {
  level.scr_animtree["usable_shipping_container_door"] = #animtree;
  level.scr_model["usable_shipping_container_door"] = "storage_shipping_container_door_right_red";
  level.scr_anim["usable_shipping_container_door"]["open_door"] = % jup_port_shipping_container_open_door;
}

function mp_vehicles() {}