/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_nic_revolucion_fx.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\cp_common\snd;
#namespace cp_nic_revolucion_fx;

function preload() {
  clientfield::register("toplayer", "cctv_cam_swap", 1, 1, "counter");
  clientfield::register("toplayer", "cctv_cam_static", 1, 2, "int");
  clientfield::register("vehicle", "ac130_runner", 1, 1, "int");
}

function function_383d3084() {
  self clientfield::increment_to_player("cctv_cam_swap", 1);
  snd::client_msg("flg_cctv_cam_swap_audio");
  level notify(#"hash_37a2f205712110e2");
}

function function_476c025a(var_5f6ea71e) {
  self clientfield::set_to_player("cctv_cam_static", var_5f6ea71e);
}

function function_bf0e01f7() {
  level.ac130 clientfield::set("ac130_runner", 1);
}