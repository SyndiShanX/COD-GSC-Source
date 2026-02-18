/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\ammo_resupply_crate.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\cp_common\util;
#namespace ammo_resupply_crate;

function private autoexec __init__system__() {
  system::register(#"ammo_resupply_crate", undefined, &init_postload, undefined, undefined);
}

function private init_postload() {
  var_59dc62dc = struct::get_array("ammo_resupply_crate");
  level flag::wait_till("all_players_connected");
  array::thread_all(var_59dc62dc, &ammo_crate_init);
}

function ammo_crate_init() {
  self util::create_cursor_hint(undefined, undefined, #"hash_59581ed64841a461", undefined, undefined, &resupply_ammo, undefined, undefined, undefined, undefined, 1, 0, &function_6014ca4c);
}

function private resupply_ammo(s_info) {
  player = s_info.player;
  player endon(#"death");
  player playgestureviewmodel(#"ges_drophand");
  wait 0.3;
  player playrumbleonentity("damage_light");
  a_w_weapons = player getweaponslist(0);

  foreach(w_weapon in a_w_weapons) {
    if(isDefined(w_weapon.var_4d97c40b) && w_weapon.var_4d97c40b) {
      continue;
    }

    player givemaxammo(w_weapon);
  }

  snd::play("fly_ammo_crate_pickup", self);
  player thread function_cc6f66e5();
}

function private function_cc6f66e5() {
  self endon(#"death");
  self.var_626ab4f2 = 1;
  wait 5;
  self.var_626ab4f2 = undefined;
}

function function_6014ca4c(s_info) {
  return !isDefined(s_info.player.var_626ab4f2);
}