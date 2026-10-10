/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5fca5166921c5d65.gsc
*************************************************/

#using script_a7e2df121c70d22;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\sp\anim;
#using scripts\sp\utility;
#namespace namespace_829b29c5553db8bb;

function main() {
  generic_human();
  script_models();
}

#using_animtree("generic_human");

function generic_human() {
  level.scr_anim["alex"]["intro_lasso"] = % gshp_0310_comp_infil_truck_signal_ally03;
  addnotetrack_customfunction("alex", "beam_on", &function_875317a777222194, "intro_lasso");
  addnotetrack_customfunction("alex", "beam_off", &function_bdbb074affe84fae, "intro_lasso");
  level.scr_anim["alex"]["intro_lasso_loop"][0] = % gshp_0310_comp_infil_truck_signal_loop_ally03;
  scene = "mortar_idle";
  level.scr_anim["mortar_guy_01"][scene][0] = % gshp_0570_amb_mortar_attack_idle_enemy01;
  level.scr_anim["mortar_guy_02"][scene][0] = % gshp_0570_amb_mortar_attack_idle_enemy02;
  scene = "mortar_fire";
  level.scr_anim["mortar_guy_01"][scene] = % gshp_0570_amb_mortar_attack_fire_enemy01;
  level.scr_anim["mortar_guy_02"][scene] = % gshp_0570_amb_mortar_attack_fire_enemy02;
  addnotetrack_customfunction("mortar_guy_02", "blast", &function_69edcd0aaf9f8b7b, scene);
}

function function_875317a777222194(guy) {
  guy setanimrate(%gshp_0310_comp_infil_truck_signal_ally03, 0.5);
  guy function_ed889c1df05699ab();
}

function function_ed889c1df05699ab() {
  laser = spawn("script_model", self gettagorigin("tag_accessory_left"));
  laser.angles = self gettagangles("tag_accessory_left");
  self.laser = laser;
  laser setModel("misc_wm_handheld_green_laser");
  laser setmoverlaserweapon("iw8_laser_painter_ac130_lasso_thermal");
  laser laserforceon();
  laser linkTo(self, "tag_accessory_left");
}

function function_bdbb074affe84fae(guy) {
  guy setanimrate(%gshp_0310_comp_infil_truck_signal_ally03, 1);
  guy function_b9e632d78e4e194f();
}

function function_b9e632d78e4e194f() {
  self.laser laserforceoff();
  self.laser delete();
}

function function_69edcd0aaf9f8b7b(guy) {
  level.mortar_launcher thread namespace_6393a86f2fcda776::function_371eab79c78ad557(guy, 3000);
}

#using_animtree("script_model");

function script_models() {
  crate = "m1_crate_01";
  level.scr_animtree[crate] = #animtree;
  level.scr_model[crate] = "box_wooden_grenade_01";
  level.scr_anim[crate]["mortar_runintro"] = % gshp_0570_amb_mortar_attack_runintro_crate;
  shell = "m1_shell_02";
  level.scr_animtree[shell] = #animtree;
  level.scr_model[shell] = "misc_wm_mortar_shell";
  level.scr_anim[shell]["mortar_idle"][0] = % gshp_0570_amb_mortar_attack_idle_shell02;
  level.scr_anim[shell]["mortar_fire"] = % gshp_0570_amb_mortar_attack_fire_shell02;
}