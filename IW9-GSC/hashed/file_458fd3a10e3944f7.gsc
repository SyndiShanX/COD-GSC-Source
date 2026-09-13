/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_458fd3a10e3944f7.gsc
***********************************************/

init() {
  _id_70FECC979CEB6591 = spawnStruct();
  _id_70FECC979CEB6591._id_04CDDC1583171DAE = "field_resupply";
  _id_70FECC979CEB6591._id_F031D79FAB22BD13 = ::_id_F031D79FAB22BD13;
  _id_70FECC979CEB6591._id_E910A7513E3AE146 = ::_id_E910A7513E3AE146;
  _id_7FEAED3F883FE324::_id_591D2B2DB731B2D7(_id_70FECC979CEB6591);
}

_id_F031D79FAB22BD13() {
  _id_21EED2C636F24A52();
  self.player playlocalsound("ui_iw8_vip_premium_collected_fullscreen_lsrs");
  self.player thread _id_83A9811E9F20736D();
  _id_7FEAED3F883FE324::_id_AD38C0594F257A1D(self.player, "br_rumble_powerup_field_resupply_activated");
}

_id_83A9811E9F20736D() {
  self.health = self.maxhealth;
  _id_07C40FA80892A721::_id_AC7803D45979135C(self._id_8790C077C95DB752);
  _id_7E52B56769FA7774::fillmaxarmorplate();
  scripts\mp\supers::givesuperpoints(scripts\mp\supers::getsuperpointsneeded());
  thread _id_B21A25DF2F6B1E43();
}

_id_B21A25DF2F6B1E43() {
  self endon("death_or_disconnect");
  thread scripts\mp\equipment::givescavengerammo();
  thread scripts\mp\equipment::givescavengerammo();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
  waitframe();
  scripts\mp\weapons::scavengergiveammo(self);
}

_id_E910A7513E3AE146() {}

_id_21EED2C636F24A52() {}

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
    case "rmbl_give_field_resupply_powerup":
      level.player _id_7FEAED3F883FE324::_id_D8FBE43CA106C7CD("field_resupply");
      break;
    case "rmbl_spawn_field_resupply_powerup":
      _id_2AE01F9836C08415 = level.player.origin + anglesToForward(level.player.angles) * 300 + (0, 0, 25);
      spawnscriptable("brloot_rumble_powerup_field_resupply", _id_2AE01F9836C08415);
      break;
    case "rmbl_give_teammate_field_resupply_powerup":
      _id_A369F87F8A7A9868 = scripts\mp\utility\teams::getteamdata(level.player.team, "players");
      _id_A369F87F8A7A9868 = scripts\engine\utility::array_remove(_id_A369F87F8A7A9868, level.player);
      _id_A369F87F8A7A9868[randomintrange(0, _id_A369F87F8A7A9868.size)] _id_7FEAED3F883FE324::_id_D8FBE43CA106C7CD("field_resupply");
      break;
  }
}