/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_545684ac3072093.gsc
************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_e043e6db317d6d71;

function main() {
  function_959babe1a25e784e();
}

#using_animtree("script_model");

function function_959babe1a25e784e() {
  level.scr_animtree["zone1_heavy_lab_device"] = #animtree;
  level.scr_anim["zone1_heavy_lab_device"]["exploded"] = % jup_fxanim_war_military_heavy_lab_device_damaged;
  level.scr_animname["zone1_heavy_lab_device"]["exploded"] = "jup_fxanim_war_military_heavy_lab_device_damaged";
  level.scr_animtree["zone1_heavy_lab_device_line"] = #animtree;
  level.scr_anim["zone1_heavy_lab_device_line"]["exploded"] = % jup_fxanim_war_military_heavy_lab_device_line_damaged;
  level.scr_animname["zone1_heavy_lab_device_line"]["exploded"] = "jup_fxanim_war_military_heavy_lab_device_line_damaged";
}