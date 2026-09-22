/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_assassin_camoflauge.gsc
******************************************************************/

seek_special_ability_use() {
  return !common_scripts\utility::_id_562E(self.specialoverheated) && maps\mp\zombies\zombie_assassin::there_is_close_player(180);
}

activate_special_ability() {
  thread maps\mp\zombies\zombie_assassin::recharge_special_ability(13.5);
  _id_0378::_id_8D74("aud_assassin_use_camoflage");
}

spawn_a_blinding_area() {
  if(common_scripts\utility::_id_562E(self.nochill)) {
    thread showoff();
    return;
  }

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

showoff() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] thread intro_fog_vision();
  }

  playFX(common_scripts\utility::_id_44F5("zmi_assassin_teleport"), self.origin);
}

intro_fog_vision() {
  self.fog_set_is_locked = 0;
  thread maps\mp\mp_zombie_island_fog_zones::set_light_and_fog("mp_zombie_island_distort", "mp_zombie_island_distort", 0.9, 1);
  wait 0.8;
  level thread maps\mp\zquests\casual\island_ee_util::_id_7432(0.4, 1);
  wait 1.5;
  common_scripts\utility::flag_set("asn_players_are_blinded");
  self.fog_set_is_locked = 0;
  thread maps\mp\mp_zombie_island_fog_zones::set_light_and_fog("mp_zombie_island_fog_beach", "mp_zombie_island_fog", 0, 1);
  level thread maps\mp\zquests\casual\island_ee_util::_id_7432(1, 0);
  wait 1;
  self.fog_set_is_locked = 0;
}

play_assassin_blur(var_0) {
  self notify("new_blur");
  self endon("new_blur");
  self endon("death");
  self endon("disconnect");
  _id_0378::_id_8D74("aud_strt_asn_camo_blur");
  maps\mp\mp_zombie_island_fog_zones::set_light_and_fog("mp_zombie_island_distort", "mp_zombie_island_distort", 1.4 * var_0);
  wait(1.4 * var_0);
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