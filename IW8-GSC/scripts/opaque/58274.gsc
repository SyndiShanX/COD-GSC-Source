/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58274.gsc
***********************************************/

function init() {
  level._effect["vfx_2x_points_screen_fx"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_2x_scrnfx");
  level._effect["vfx_2x_points_victim_explosion"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_victim_2x_explosion");
  level._effect["vfx_2x_points_hand_glow"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_2x_hands_trail");
  game["dialog"]["powerup_double_points"] = "power_up_double_points";
  var_0 = spawnStruct();
  var_0.ref_138fd = "double_points";
  var_0.parachute_get_path = getdvarfloat("scr_brPowerups_double_points_buff_duration", 45);
  var_0.asm_playfacialanim_mp = &asm_playfacialanim_mp;
  var_0.ref_12a35 = &ref_12a35;
  var_0.isdeathshieldskippingenabled = &isdeathshieldskippingenabled;
  _keypadscriptableused_bunkeralt::ref_12af4(var_0);
}

function asm_playfacialanim_mp() {
  self.ref_1265d = 0;
  self.ref_11e08 = 2;
  self.player.ref_12827 = 1;
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("powerup_double_points", self.player);
  thread ref_135b7();
  self.player playlocalsound("mp_powerup_activate_2x_plr");
  _keypadscriptableused_bunkeralt::ref_12425(self.player, "br_rumble_powerup_double_points_activated");
}

function isdeathshieldskippingenabled() {
  self notify("singleton_deactivate_func");
  self endon("singleton_deactivate_func");
  self.player.ref_12827 = 0;
  thread lb_impulse_dmg_threshold_low();

  if(isalive(self.player)) {
    self.player playlocalsound("mp_powerup_deactivate_2x_plr");
    return;
  }
}

function ref_12a35() {
  open_starting_safehouse_door(self.ref_12e2d.parachute_get_path);
  self.player playlocalsound("mp_powerup_reactivate_2x_plr");
}

function ref_11ff1(var_0) {
  if(isDefined(var_0.attacker) && istrue(var_0.attacker.ref_12827)) {
    playFX(scripts\engine\utility::getfx("vfx_2x_points_victim_explosion"), var_0.victim.origin);
    var_1 = easepower("brloot_rumble_powerup_sfx", var_0.victim.origin);
    var_1 setscriptablepartstate("sfx", "2x_victim_death_3D");
    var_0.attacker playlocalsound("mp_powerup_victim_death_2x_plr");
    var_2 = var_0.attacker _keypadscriptableused_bunkeralt::ref_1249c("double_points");
    var_3 = 50;
    return;
  }
}

function open_starting_safehouse_door(var_0) {
  self.mp_layover_patch = gettime() + var_0 * 1000;
  self.player thread _keypadscriptableused_bunkeralt::ref_13f7e(undefined, 1, 2);
}

function ref_135b7() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_le");
  playFXOnTag(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_ri");
  waitframe();
  stopfxontagforclients(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_le", self.player);
  waitframe();
  stopfxontagforclients(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_ri", self.player);
}

function lb_impulse_dmg_threshold_low() {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_le");
  waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_ri");
}

function isplatepouch() {
  scripts\mp\gametypes\br_dev::ref_12b21(&isplacementplayerobstructed);
  thread isplayerbrsquadleader();
}

function isplayerbrsquadleader() {
  level endon("game_ended");

  while(!isDefined(level.player)) {
    waitframe();
  }
}

function isplacementplayerobstructed(var_0, var_1) {
  var_2 = "";

  switch (var_0) {
    case "rmbl_give_double_points_powerup":
      level.player _keypadscriptableused_bunkeralt::ref_1393a("double_points");
      break;
    case "rmbl_spawn_double_points_powerup":
      var_3 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      easepower("brloot_rumble_powerup_double_points", var_3);
      break;
    case "rmbl_give_teammate_double_points_powerup":
      var_4 = scripts\mp\utility\teams::getteamdata(level.player.team, "players");
      var_4 = scripts\engine\utility::array_remove(var_4, level.player);
      var_4[randomintrange(0, var_4.size)] _keypadscriptableused_bunkeralt::ref_1393a("double_points");
      break;
  }
}