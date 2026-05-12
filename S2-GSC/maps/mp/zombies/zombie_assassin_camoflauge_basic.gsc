/****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombie_assassin_camoflauge_basic.gsc
****************************************************************/

seek_special_ability_use() {
  return !common_scripts\utility::func_562E(self.specialoverheated) && maps\mp\zombies\zombie_assassin_basic::there_is_close_player(180);
}

activate_special_ability() {
  thread maps\mp\zombies\zombie_assassin_basic::recharge_special_ability(13.5);
  lib_0378::func_8D74("aud_assassin_use_camoflage");
}

spawn_a_blinding_area() {
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

play_assassin_blur(param_00) {
  self notify("new_blur");
  self endon("new_blur");
  self endon("death");
  self endon("disconnect");
  lib_0378::func_8D74("aud_strt_asn_camo_blur");
  var_01 = 6.5 * param_00;
  self method_8483("mp_zombie_island_distort", 1);
  self lightsetoverrideenableforplayer("mp_zombie_island_distort", 1);
  wait(var_01);
  self method_8483(maps\mp\_utility::func_4571(), 1);
  self lightsetoverrideenableforplayer(maps\mp\_utility::func_4571(), 1);
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