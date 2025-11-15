/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_mounted_mg.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\clientfield_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_stalingrad_mounted_mg;

function autoexec __init__sytem__() {
  system::register("zm_stalingrad_mounted_mg", & __init__, undefined, undefined);
}

function __init__() {
  level._effect["mounted_mg_overheat"] = "dlc3/stalingrad/fx_mg42_over_heat";
  clientfield::register("vehicle", "overheat_fx", 12000, 1, "int", & function_c71f5e4a, 0, 0);
}

function function_c71f5e4a(n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump) {
  if(n_new) {
    self.var_b4b6b5a6 = playFXOnTag(n_local_client, level._effect["mounted_mg_overheat"], self, "tag_flash");
  } else if(isDefined(self.var_b4b6b5a6)) {
    stopfx(n_local_client, self.var_b4b6b5a6);
  }
}