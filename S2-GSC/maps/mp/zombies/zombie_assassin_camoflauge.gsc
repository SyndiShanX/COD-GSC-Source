/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_assassin_camoflauge.gsc
**********************************************************/

seek_special_ability_use() {
  return !common_scripts\utility::func_562E(self.specialoverheated) && maps\mp\zombies\zombie_assassin::there_is_close_player(180);
}

activate_special_ability() {
  thread maps\mp\zombies\zombie_assassin::recharge_special_ability(13.5);
  lib_0378::func_8D74("aud_assassin_use_camoflage");
}

spawn_a_blinding_area() {
  if(common_scripts\utility::func_562E(self.nochill)) {
    thread showoff();
    return;
  }

  playFX(common_scripts\utility::func_44F5("zmi_assassin_teleport"), self.var_116);
  wait(0.125);
  foreach(var_01 in level.var_744A) {
    if(!isalive(var_01)) {
      continue;
    }

    if(common_scripts\utility::func_562E(var_01.var_5728)) {
      continue;
    }

    if(!common_scripts\utility::func_562E(self.nochill) && distance(self.var_116, var_01.var_116) > 275) {
      continue;
    }

    var_01 thread play_assassin_blur(distance(self.var_116, var_01.var_116) / 275);
  }
}

showoff() {
  for(var_00 = 0; var_00 < level.var_744A.size; var_00++) {
    level.var_744A[var_00] thread intro_fog_vision();
  }

  playFX(common_scripts\utility::func_44F5("zmi_assassin_teleport"), self.var_116);
}

intro_fog_vision() {
  self.fog_set_is_locked = 0;
  thread maps\mp\mp_zombie_island_fog_zones::set_light_and_fog("mp_zombie_island_distort", "mp_zombie_island_distort", 0.9, 1);
  wait(0.8);
  level thread maps\mp\zquests\casual\island_ee_util::func_7432(0.4, 1);
  wait(1.5);
  common_scripts\utility::func_3C8F("asn_players_are_blinded");
  self.fog_set_is_locked = 0;
  thread maps\mp\mp_zombie_island_fog_zones::set_light_and_fog("mp_zombie_island_fog_beach", "mp_zombie_island_fog", 0, 1);
  level thread maps\mp\zquests\casual\island_ee_util::func_7432(1, 0);
  wait(1);
  self.fog_set_is_locked = 0;
}

play_assassin_blur(param_00) {
  self notify("new_blur");
  self endon("new_blur");
  self endon("death");
  self endon("disconnect");
  lib_0378::func_8D74("aud_strt_asn_camo_blur");
  maps\mp\mp_zombie_island_fog_zones::set_light_and_fog("mp_zombie_island_distort", "mp_zombie_island_distort", 1.4 * param_00);
  wait(1.4 * param_00);
  self.current_fog_state = undefined;
  lib_0378::func_8D74("aud_stp_asn_camo_blur");
}

assassin_camo_notetrack_handler(param_00, param_01, param_02, param_03) {
  switch (param_00) {
    case "activate":
      thread spawn_a_blinding_area();
      break;
  }
}

special_assassin_damaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {}