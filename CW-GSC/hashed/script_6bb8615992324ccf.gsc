/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6bb8615992324ccf.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\ui\prompts;
#namespace namespace_7b8a8e22;

function private autoexec __init__system__() {
  system::register(#"hash_5bc761d26eb100ef", &preload, undefined, undefined, undefined);
}

function preload() {
  clientfield::register("toplayer", "set_camera_state", 1, 1, "int");
  clientfield::register("toplayer", "swap_camera", 1, 1, "counter");
  clientfield::register("toplayer", "block_zoom_input", 1, 1, "int");
}

function function_6186baa2(var_b3a11ae2) {
  self endon(#"death");

  if(isDefined(self.var_80730518)) {
    self.var_80730518 usevehicle(self, 0);
    self clientfield::increment_to_player("swap_camera", 1);
  } else {
    self clientfield::set_to_player("set_camera_state", 1);
  }

  var_b3a11ae2 usevehicle(self, 0);
  self val::set(#"hash_5bc761d26eb100ef", "freezecontrols", 1);
  wait 0.4;
  self val::reset(#"hash_5bc761d26eb100ef", "freezecontrols");
}

function function_c168eb01() {
  self endon(#"death");
  self clientfield::set_to_player("set_camera_state", 0);
  self val::set(#"hash_5bc761d26eb100ef", "freezecontrols", 1);
  wait 0.4;
  self val::reset(#"hash_5bc761d26eb100ef", "freezecontrols");
  self.var_80730518 usevehicle(self, 0);
}

function block_zoom_input(b_state) {
  self clientfield::set_to_player("block_zoom_input", b_state);
}