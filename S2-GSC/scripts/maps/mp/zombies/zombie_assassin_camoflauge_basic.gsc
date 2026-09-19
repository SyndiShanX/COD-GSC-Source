/************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_assassin_camoflauge_basic.gsc
************************************************************************/

seek_special_ability_use() {
  return !common_scripts\utility::_id_562E(self.specialoverheated) && maps\mp\zombies\zombie_assassin_basic::there_is_close_player(180);
}

activate_special_ability() {
  thread maps\mp\zombies\zombie_assassin_basic::recharge_special_ability(13.5);
  _id_0378::_id_8D74("aud_assassin_use_camoflage");
}

spawn_a_blinding_area() {
  playFX(common_scripts\utility::_id_44F5("zmi_assassin_teleport"), self.origin);
  wait 0.125;

  foreach(var_1 in level.players) {
    if(!isalive(var_1)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_1._id_5728)) {
      continue;
    }
    if(!common_scripts\utility::_id_562E(self.nochill) && distance(self.origin, var_1.origin) > 275) {
      continue;
    }
    var_1 thread play_assassin_blur(distance(self.origin, var_1.origin) / 275);
  }
}

play_assassin_blur(var_0) {
  self notify("new_blur");
  self endon("new_blur");
  self endon("death");
  self endon("disconnect");
  _id_0378::_id_8D74("aud_strt_asn_camo_blur");
  var_1 = 6.5 * var_0;
  self _meth_8483("mp_zombie_island_distort", 1);
  self _meth_83C7("mp_zombie_island_distort", 1);
  wait(var_1);
  self _meth_8483(maps\mp\_utility::_id_4571(), 1);
  self _meth_83C7(maps\mp\_utility::_id_4571(), 1);
  self.current_fog_state = undefined;
  _id_0378::_id_8D74("aud_stp_asn_camo_blur");
}

assassin_camo_notetrack_handler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "activate":
      thread spawn_a_blinding_area();
      break;
  }
}

special_assassin_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {}