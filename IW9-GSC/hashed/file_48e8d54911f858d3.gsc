/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_48e8d54911f858d3.gsc
***********************************************/

init() {
  level._effect["vfx_2x_points_screen_fx"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_2x_scrnfx");
  level._effect["vfx_2x_points_victim_explosion"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_victim_2x_explosion");
  level._effect["vfx_2x_points_hand_glow"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_2x_hands_trail");
  game["dialog"]["powerup_double_points"] = "power_up_double_points";
  _id_716C2B3C9E7569B3 = spawnStruct();
  _id_716C2B3C9E7569B3._id_04CDDC1583171DAE = "double_points";
  _id_716C2B3C9E7569B3._id_19C0658A705F4A94 = getdvarfloat("dvar_66CB28FB7BE032E9", 45);
  _id_716C2B3C9E7569B3._id_2B65725ECD17D33A = ::_id_2B65725ECD17D33A;
  _id_716C2B3C9E7569B3._id_115CFFC870AD0973 = ::_id_115CFFC870AD0973;
  _id_716C2B3C9E7569B3._id_97183CB1A6E6C08B = ::_id_97183CB1A6E6C08B;
  _id_7FEAED3F883FE324::_id_591D2B2DB731B2D7(_id_716C2B3C9E7569B3);
}

_id_2B65725ECD17D33A() {
  self._id_56416B76461EFA9B = 0;
  self._id_98EA5AFB293A76A2 = 2;
  self.player._id_D933C184544F70FC = 1;
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("powerup_double_points", self.player);
  thread _id_21EED2C636F24A52();
  self.player playlocalsound("mp_powerup_activate_2x_plr");
  _id_7FEAED3F883FE324::_id_AD38C0594F257A1D(self.player, "br_rumble_powerup_double_points_activated");
}

_id_97183CB1A6E6C08B() {
  self notify("singleton_deactivate_func");
  self endon("singleton_deactivate_func");
  self.player._id_D933C184544F70FC = 0;
  thread _id_2E6E436C3A41E0A3();

  if(isalive(self.player))
    self.player playlocalsound("mp_powerup_deactivate_2x_plr");
}

_id_115CFFC870AD0973() {
  _id_1BD8558F1AEF50BD(self._id_02FA928445372D72._id_19C0658A705F4A94);
  self.player playlocalsound("mp_powerup_reactivate_2x_plr");
}

_id_FA66101B60F4D9BC(data) {
  if(isDefined(data.attacker) && istrue(data.attacker._id_D933C184544F70FC)) {
    playFX(scripts\engine\utility::getfx("vfx_2x_points_victim_explosion"), data.victim.origin);
    _id_C40F543B5CAD5C1E = spawnscriptable("brloot_rumble_powerup_sfx", data.victim.origin);
    _id_C40F543B5CAD5C1E setscriptablepartstate("sfx", "2x_victim_death_3D");
    data.attacker playlocalsound("mp_powerup_victim_death_2x_plr");
    _id_E74300DFB04B35EB = data.attacker _id_7FEAED3F883FE324::_id_9925A4BF8196071A("double_points");
    _id_3B9C5EE38CC10966 = 50;
  }
}

_id_1BD8558F1AEF50BD(_id_CEBDB0E614D4D7D2) {
  self._id_A7F29930A5DD5069 = gettime() + _id_CEBDB0E614D4D7D2 * 1000;
  self.player thread _id_7FEAED3F883FE324::_id_86DC7FCF1ACCBCBF(undefined, 1, 2);
}

_id_21EED2C636F24A52() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_le");
  playFXOnTag(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_ri");
  waitframe();
  stopfxontagforclients(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_le", self.player);
  waitframe();
  stopfxontagforclients(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_ri", self.player);
}

_id_2E6E436C3A41E0A3() {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_le");
  waitframe();
  stopFXOnTag(scripts\engine\utility::getfx("vfx_2x_points_hand_glow"), self.player, "j_wrist_ri");
}

_id_82BB896A0ADA90E7() {
  _id_2902155747C5C4FE::registerhandlecommand(::_id_B50BE56905600239);
  level thread _id_DB5C75F2A84FF03D();
}

_id_DB5C75F2A84FF03D() {
  level endon("game_ended");

  while(!isDefined(level.player))
    waitframe();
}

_id_B50BE56905600239(_id_10D8148F3496F8DE, _id_434809FD34BABEE0) {
  _id_15A18DD2DD7ED5DA = "";

  switch (_id_10D8148F3496F8DE) {
    case "rmbl_give_double_points_powerup":
      level.player _id_7FEAED3F883FE324::_id_D8FBE43CA106C7CD("double_points");
      break;
    case "rmbl_spawn_double_points_powerup":
      _id_2AE01F9836C08415 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      spawnscriptable("brloot_rumble_powerup_double_points", _id_2AE01F9836C08415);
      break;
    case "rmbl_give_teammate_double_points_powerup":
      _id_A369F87F8A7A9868 = scripts\mp\utility\teams::getteamdata(level.player.team, "players");
      _id_A369F87F8A7A9868 = scripts\engine\utility::array_remove(_id_A369F87F8A7A9868, level.player);
      _id_A369F87F8A7A9868[randomintrange(0, _id_A369F87F8A7A9868.size)] _id_7FEAED3F883FE324::_id_D8FBE43CA106C7CD("double_points");
      break;
  }
}