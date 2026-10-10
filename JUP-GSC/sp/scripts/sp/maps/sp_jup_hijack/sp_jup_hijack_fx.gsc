/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\maps\sp_jup_hijack\sp_jup_hijack_fx.gsc
*****************************************************************/

#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\dialogue_wheel;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#namespace sp_jup_hijack_fx;

function main() {
  level._effect["vfx_hij_bomblight"] = loadfx("vfx/jup/level/sp_jup_hijack/vfx_hij_bomblight.vfx");
  level._effect["vfx_hij_mask_door_01"] = loadfx("vfx/jup/level/sp_jup_hijack/vfx_hij_mask_door_01.vfx");
  level._effect["vfx_hij_grenade_glint"] = loadfx("vfx/jup/level/sp_jup_hijack/vfx_hij_grenade_glint.vfx");
  level._effect["vfx_hij_blood_pool_grow"] = loadfx("vfx/jup/level/sp_jup_hijack/vfx_hij_blood_pool_grow.vfx");
  level._effect["vfx_hij_flahbang_geotrail"] = loadfx("vfx/jup/level/sp_jup_hijack/vfx_hij_flahbang_geotrail.vfx");
  level._effect["vfx_chemical_infil_impact_dust"] = loadfx("vfx/jup/level/sp_jup_chemical/vfx_chemical_infil_impact_dust.vfx");
  level._effect["vfx_hij_headshot_01"] = loadfx("vfx/jup/level/sp_jup_hijack/vfx_hij_headshot_01.vfx");
  level._effect["vfx_muz_pis_m"] = loadfx("vfx/iw9/core/weapons/muzzleflash/pis/vfx_muz_pis_m.vfx");
  level._effect["vfx_hij_takedown_y_forward_01"] = loadfx("vfx/jup/level/sp_jup_hijack/vfx_hij_takedown_y_forward_01.vfx");
  level._effect["vfx_hij_phone_edge_glow_intro"] = loadfx("vfx/jup/level/sp_jup_hijack/vfx_hij_phone_edge_glow_intro.vfx");
  level._effect["vfx_hij_cam_explode"] = loadfx("vfx/jup/level/sp_jup_hijack/vfx_hij_cam_explode.vfx");
  level._effect["vfx_hij_camera_glint"] = loadfx("vfx/jup/level/sp_jup_hijack/vfx_hij_camera_glint.vfx");

  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {}

  thread o2_masks();
}

function o2_masks() {
  var_27ceb937e0fb383b = getEntArray("right_mask_door", "script_noteworthy");
  var_a2c32e6abfe7f186 = getEntArray("centre_mask_door", "script_noteworthy");
  var_92b83298e5786d52 = getEntArray("left_mask_door", "script_noteworthy");
  flag_wait("flag_hide_o2_masks");
  flag_wait("lgt_mak_para_door_open");
  waitframe();
  showmayhem("vfx_mayh_oxy_mask_02");
  waitframe();
  playmayhem("vfx_mayh_oxy_mask_02");
  mask_doors = array_combine(var_27ceb937e0fb383b, var_a2c32e6abfe7f186, var_92b83298e5786d52);

  foreach(ent in mask_doors) {
    thread function_47160456e28a2e9(ent.origin);
  }

  flag_wait("flag_player_has_weapon_return_to_econ");
}

function function_c3336cb9cd5c7518(wait_time) {
  rotate_time = randomfloatrange(0.5, 1);
  rotate_amount = randomintrange(-95, -85);
  new_angles = (rotate_amount, 0, 0);

  if(self.script_noteworthy == "left_mask_door") {
    self rotateby((0, 0, 15), rotate_time, 0.3, 0.01);
  } else if(self.script_noteworthy == "right_mask_door") {
    self rotateby((0, 0, -15), rotate_time, 0.3, 0.01);
  }

  wait rotate_time;
  self rotateby(new_angles, rotate_time, 0.3, 0.01);
}

function function_47160456e28a2e9(origin) {
  playFX(level._effect["vfx_hij_mask_door_01"], origin);
}