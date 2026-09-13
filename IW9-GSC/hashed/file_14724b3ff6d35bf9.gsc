/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_14724b3ff6d35bf9.gsc
***********************************************/

init() {
  level._effect["vfx_speed_boost_trail_fx"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_speed_boost_trail");
  level._effect["vfx_speed_boost_screen_fx"] = loadfx("vfx/iw8_br/gameplay/rumble/vfx_rum_speed_boost_scrnfx");
  game["dialog"]["powerup_speed_boost"] = "power_up_speed_boost";
  _id_70FECC979CEB6591 = spawnStruct();
  _id_70FECC979CEB6591._id_04CDDC1583171DAE = "speed_boost";
  _id_70FECC979CEB6591._id_19C0658A705F4A94 = getdvarfloat("dvar_C6D7CD604297BA7F", 45);
  _id_70FECC979CEB6591._id_2B65725ECD17D33A = ::_id_2B65725ECD17D33A;
  _id_70FECC979CEB6591._id_115CFFC870AD0973 = ::_id_115CFFC870AD0973;
  _id_70FECC979CEB6591._id_97183CB1A6E6C08B = ::_id_97183CB1A6E6C08B;
  _id_7FEAED3F883FE324::_id_591D2B2DB731B2D7(_id_70FECC979CEB6591);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_powerup_speed_boost", "extend_time_by", ::_id_1BD8558F1AEF50BD);
}

_id_2B65725ECD17D33A() {
  self.player._id_4A62CBD8802444F2 = 1;
  level thread _id_2CEDCC356F1B9FC8::brleaderdialogplayer("powerup_speed_boost", self.player);
  self.player lerpfovbypreset("zombiedefault");
  _id_21EED2C636F24A52();
  self.player _id_EA1ECC965EDA7A5F();
  self.player playlocalsound("mp_powerup_activate_speed_plr");
  _id_7FEAED3F883FE324::_id_AD38C0594F257A1D(self.player, "br_rumble_powerup_speed_boost_activated");
}

_id_97183CB1A6E6C08B() {
  self notify("singleton_deactivate_func");
  self endon("singleton_deactivate_func");
  self.player._id_4A62CBD8802444F2 = 0;
  _id_2E6E436C3A41E0A3();
  self.player _id_A52F8D58C9BA7B15();

  if(isalive(self.player))
    self.player playlocalsound("mp_powerup_deactivate_speed_plr");

  self.player lerpfovbypreset("default_2seconds");
}

_id_115CFFC870AD0973() {
  _id_1BD8558F1AEF50BD(self._id_02FA928445372D72._id_19C0658A705F4A94);
  self.player playlocalsound("mp_powerup_reactivate_speed_plr");
}

_id_1BD8558F1AEF50BD(_id_CEBDB0E614D4D7D2) {
  self._id_A7F29930A5DD5069 = gettime() + _id_CEBDB0E614D4D7D2 * 1000;
  self.player thread _id_7FEAED3F883FE324::_id_86DC7FCF1ACCBCBF(undefined, 4, 2);
}

_id_21EED2C636F24A52() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_speed_boost_trail_fx"), self.player, "j_spine4");
}

_id_2E6E436C3A41E0A3() {
  stopFXOnTag(scripts\engine\utility::getfx("vfx_speed_boost_trail_fx"), self.player, "j_spine4");
}

_id_EA1ECC965EDA7A5F(_id_CEBDB0E614D4D7D2) {
  thread _id_DCB03E76673BA631();

  if(!istrue(self.isjuggernaut) && !isDefined(self.vehicle))
    thread _id_D79F2EC2DA324515();

  if(isDefined(self.vehicle))
    _id_7FEAED3F883FE324::_id_9925A4BF8196071A("speed_boost") thread _id_285C489F9F584680();
}

_id_285C489F9F584680() {
  level endon("game_ended");
  self endon("stop_powerup");
  self.player endon("death_or_disconnect");

  while(isDefined(self.player.vehicle))
    waitframe();

  thread _id_D79F2EC2DA324515();
}

_id_2140F3D92B3CC487() {
  level endon("game_ended");
  self endon("disconnect");

  while(isDefined(self.vehicle))
    waitframe();

  thread _id_6921BFEF1EC1229C();
}

_id_A52F8D58C9BA7B15() {
  thread _id_9B62300E4D3108AC();

  if(!isDefined(self.vehicle))
    thread _id_6921BFEF1EC1229C();
  else
    thread _id_2140F3D92B3CC487();
}

_id_D79F2EC2DA324515() {
  if(!isDefined(self.operatorcustomization) || !isDefined(self.operatorcustomization.suit)) {
    return;
  }
  if(self.operatorcustomization.suit == "actionhero_mp_mgl") {
    return;
  }
  if(!isDefined(self._id_F9779E44BD572312))
    self._id_F9779E44BD572312 = self.operatorcustomization.suit;

  self.operatorcustomization.suit = "actionhero_mp_mgl";
  scripts\mp\utility\player::_setsuit("actionhero_mp_mgl");
}

_id_6921BFEF1EC1229C() {
  self notify("custom_suit_start");
  self endon("custom_suit_start");

  if(isDefined(self._id_F9779E44BD572312) && self.operatorcustomization.suit != self._id_F9779E44BD572312) {
    self.operatorcustomization.suit = self._id_F9779E44BD572312;
    scripts\mp\utility\player::_setsuit(self._id_F9779E44BD572312);
    self._id_F9779E44BD572312 = undefined;
  }
}

_id_DCB03E76673BA631() {
  self notify("player_set_infinate_super_sprint");
  self endon("player_set_infinate_super_sprint");
  self endon("death_or_disconnect");
  self refreshsprinttime();
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();

  if(!_id_2CEDCC356F1B9FC8::hasspecialistbonus()) {
    scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
    scripts\mp\utility\perk::giveperk("specialty_sprintads");
    scripts\mp\utility\perk::giveperk("specialty_marathon");
    scripts\mp\utility\perk::giveperk("specialty_fastsprintrecovery");
  }
}

_id_9B62300E4D3108AC() {
  if(!_id_2CEDCC356F1B9FC8::hasspecialistbonus()) {
    scripts\mp\utility\perk::removeperk("specialty_sprintmelee");
    scripts\mp\utility\perk::removeperk("specialty_sprintads");
    scripts\mp\utility\perk::removeperk("specialty_marathon");
    scripts\mp\utility\perk::removeperk("specialty_fastsprintrecovery");
  }

  self.movespeedscaler = 1;
  scripts\mp\weapons::updatemovespeedscale();
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
    case "rmbl_give_speed_boost_powerup":
      level.player _id_7FEAED3F883FE324::_id_D8FBE43CA106C7CD("speed_boost");
      break;
    case "rmbl_spawn_speed_boost_powerup":
      _id_2AE01F9836C08415 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      spawnscriptable("brloot_rumble_powerup_speed_boost", _id_2AE01F9836C08415);
      break;
    case "rmbl_give_teammate_speed_boost_powerup":
      _id_A369F87F8A7A9868 = scripts\mp\utility\teams::getteamdata(level.player.team, "players");
      _id_A369F87F8A7A9868 = scripts\engine\utility::array_remove(_id_A369F87F8A7A9868, level.player);
      _id_A369F87F8A7A9868[randomintrange(0, _id_A369F87F8A7A9868.size)] _id_7FEAED3F883FE324::_id_D8FBE43CA106C7CD("speed_boost");
      break;
  }
}