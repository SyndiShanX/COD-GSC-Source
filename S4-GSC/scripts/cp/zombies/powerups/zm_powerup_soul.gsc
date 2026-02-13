/***********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\powerups\zm_powerup_soul.gsc
***********************************************************/

_id_BB93() {
  level._effect["sin_eater_powerup_on"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_zmb_soul.vfx");
  level._effect["sin_eater_powerup_intro"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_zmb_soul_spawn_in.vfx");
  level._effect["sin_eater_powerup_grabbed"] = loadfx("vfx/s4/zombie/vfx_obj_sin_eater_zmb_soul_grab.vfx");
  _id_0990::_id_C20E("soul", ::grab_soul);
  _id_0990::_id_1083("soul", "s4_zm_soul_capture_runestone_01", undefined, _id_0990::_id_6030, 1, !1, !1, "zombie/fx9_powerup_nuke", undefined, undefined, undefined, undefined, undefined, "sin_eater_powerup_on", "sin_eater_powerup_intro", "sin_eater_powerup_grabbed");
  _id_0990::_id_BB18("soul", "zmb_rune_spawn", "zmb_rune_lp", "zmb_soul_pickup_plr", "zmb_soul_pickup_npc", "zmb_timeout_flash");
}

grab_soul(var_0) {
  var_1 = spawnStruct();
  var_1.player = var_0;
  _id_06CB::_id_2F23("soul_collected", var_1);
}

cleanup_soul_powerup(var_0) {
  var_0._id_5D7F = 0;

  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_0 notify("loot_deleted");
}

cleanup_all_soul_powerups() {
  if(!isDefined(level.a_soul_powerups)) {
    return;
  }
  foreach(var_1 in level.a_soul_powerups) {
    if(isDefined(var_1)) {
      cleanup_soul_powerup(var_1);
    }
  }

  level.a_soul_powerups = [];
}

track_soul_powerups(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  level.a_soul_powerups = scripts\cp\utility::_id_459B(level.a_soul_powerups, []);
  level.a_soul_powerups = scripts\engine\utility::array_add(level.a_soul_powerups, var_0);
  level.a_soul_powerups = scripts\engine\utility::_id_1BD1(level.a_soul_powerups);
}