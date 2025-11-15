/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2643.gsc
***************************************/

main() {
  func_95F5();
}

func_95F5() {
  level._effect["melee_blood"] = loadfx("vfx\core\impacts\small\impact_alien_flesh_hit_b_fatal");
  level._effect["vfx_scrnfx_tocam_slidedust_m"] = loadfx("vfx\core\screen\vfx_scrnfx_tocam_slidedust_m");
  level._effect["vfx_melee_blood_spray"] = loadfx("vfx\core\screen\vfx_melee_blood_spray");
  level._effect["vfx_blood_hit_left"] = loadfx("vfx\core\screen\vfx_blood_hit_left");
  level._effect["vfx_blood_hit_right"] = loadfx("vfx\core\screen\vfx_blood_hit_right");
}