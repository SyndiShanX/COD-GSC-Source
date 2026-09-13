/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_a661c5fad6bedd8.gsc
***********************************************/

_id_BC586652AA211EE1() {
  return getdvarint("dvar_EE3003C40B220B00", 0);
}

_id_9C05104BB0F63E33() {
  return getdvarint("dvar_1E3DB97912855254", 0);
}

_id_FE000D9716D3AC83() {
  return getdvarint("dvar_AD97EB38D0F76AC4", 0);
}

_id_51A400F6949511DE() {
  return getdvarint("dvar_E301B53D24803BE0", 0);
}

_id_2327B6E483B3FB90() {
  return getdvarint("dvar_83D315D92242E5D7", 0);
}

_id_2CAFA6C0BC2D49A9(_id_F9F376A9DF858FC8, _id_E9ECD11F1D00D574, _id_44DA7A99757A17BA) {
  level._id_37AA0062320EBD1A = spawnStruct();
  level._id_37AA0062320EBD1A._id_91E547475C08DB07 = ::initialize;
  level._id_37AA0062320EBD1A._id_E9ECD11F1D00D574 = _id_E9ECD11F1D00D574;
  level._id_37AA0062320EBD1A._id_44DA7A99757A17BA = _id_44DA7A99757A17BA;

  if(_id_F9F376A9DF858FC8)
    level._id_744DFABB8F946331 = ::_id_744DFABB8F946331;

  level thread _id_BA26C6F0F3861EA2();
}

_id_FCD6214D8DD46123(_id_513A313408516DC2) {
  level._id_37AA0062320EBD1A._id_513A313408516DC2 = _id_513A313408516DC2;
}

initialize() {
  level.bot_funcs["player_spawned_gamemode"] = ::_id_84122B879D20EAC8;
  level.bot_funcs["gametype_think"] = ::_id_43AB8F184738915A;
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("onPlayerKilled");
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerKilled", ::_id_FF6CDD874110504F);
  _id_362C58E8BB39BCDA::_id_EC416FA15D5FA6AF("playerShouldRespawn");
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerShouldRespawn", ::playershouldrespawn);

  if(_id_9C05104BB0F63E33())
    _id_7F6AF4C52BBDAB76::init();

  if(_id_FE000D9716D3AC83())
    _id_2C694004928BD388::init();

  if(_id_2327B6E483B3FB90())
    _id_5922BC5FBA8ED290::init();

  _id_7E4910196DCBE632::init();
  level thread _id_CCAF436F3F04C8CC();
}

_id_84122B879D20EAC8() {
  self._id_89DAB0876DC8A170 = 1;
  scripts\mp\bots\bots_util::bot_set_personality("run_and_gun");
  self botsetflag("disable_random_goal", 1);
  self._id_37AA0062320EBD1A = spawnStruct();
  self.hasrespawntoken = 1;
}

_id_744DFABB8F946331() {
  return _id_0ACA13D10DCCD63E(level._id_37AA0062320EBD1A._id_E9ECD11F1D00D574, level._id_37AA0062320EBD1A._id_44DA7A99757A17BA);
}

_id_BA26C6F0F3861EA2() {
  level waittill("player_spawned");
  result = level scripts\engine\utility::waittill_any_timeout_1(10, "spawned_bots");

  if(result == "timeout") {
    _id_F4343E072926C2F9 = getdvarint("dvar_116700C9B39C1EBA", 0);
    level thread _id_40E63DD222434655::_id_F166B9F78BECA5E6(_id_F4343E072926C2F9);
  }
}

_id_B564050A363F08EC(bot, _id_5188156BCF936801) {
  _id_3804C067CBB288AF = ["goal", "off_navmesh", "bad_path_door_blocker_door_owner", "bad_path_door_blocker_invalid_client", "bad_path_stuck", "bad_path_stuck_recover_refuse", "bad_path_stuck_in_traversal", "bad_path_fell_over_edge_when_jump", "bad_path_fell_over_edge", "bad_path_no_path_found", "bad_path_clear_goal", "bad_path_frozen", "bad_path_owner_collide", "bad_path_node_claimed_by_other", "bad_path_claimed_node_lost", "bad_path_pathnode_inactive", "bad_path_no_tac_point"];
  return bot scripts\engine\utility::waittill_any_in_array_or_timeout(_id_3804C067CBB288AF, _id_5188156BCF936801);
}

_id_FF6CDD874110504F(_id_642470E1ABC1BBF9) {
  if(isDefined(self._id_37AA0062320EBD1A.onplayerkilled))
    [[self._id_37AA0062320EBD1A.onplayerkilled]](_id_642470E1ABC1BBF9);

  self.hasrespawntoken = 1;
  self.pers["lives"]++;
  self._id_C4C8B91E0B16AA5E = 0;
}

_id_721588AE374756B5(position, _id_BCBF43AE96B154F1, _id_F24BCCD9181848C1) {
  self botsetflag("disable_movement", 1);
  self botclearscriptgoal();
  self setvelocity((0, 0, 0));

  if(!_id_F5B564281D8F0656()) {
    self botsetflag("disable_movement", 0);
    return "unstoppable movement";
  }

  _id_197EFA0DCA54226F = position;

  if(isDefined(_id_F24BCCD9181848C1)) {
    _id_AC488FBC8F8E10ED = -30 - _id_F24BCCD9181848C1;
    _id_197EFA0DCA54226F = scripts\engine\utility::drop_to_ground(position, _id_F24BCCD9181848C1, _id_AC488FBC8F8E10ED);

    if(_id_2227FE7B9C3E31A3(_id_197EFA0DCA54226F[2] - position[2], _id_AC488FBC8F8E10ED, 1)) {
      self botsetflag("disable_movement", 0);
      return "no clip";
    }
  }

  self setOrigin(_id_197EFA0DCA54226F);

  if(!_id_F5B564281D8F0656()) {
    self botsetflag("disable_movement", 0);
    return "still sliding";
  }

  dist = distance(position, self.origin);

  if(dist > _id_BCBF43AE96B154F1) {
    self botsetflag("disable_movement", 0);
    return "inaccurate " + dist + "/" + _id_BCBF43AE96B154F1;
  }

  self botsetflag("disable_movement", 0);
}

_id_F5B564281D8F0656() {
  waitframe();
  waitframe();
  _id_0EBFFCA02C10E75C = 20000;
  starttime = gettime();

  while(self getvelocity() != (0, 0, 0)) {
    wait 0.1;

    if(gettime() - starttime > _id_0EBFFCA02C10E75C)
      return 0;
  }

  return 1;
}

_id_9A0A24DE119B078A(category, _id_239402335F791B06) {
  _id_FAD588394427F934 = "[BR Map AutoTest]" + category + ";";
}

_id_2227FE7B9C3E31A3(_id_720738AC4583A048, _id_72073BAC4583A6E1, _id_30CDDDB8087B55B1) {
  return abs(_id_720738AC4583A048 - _id_72073BAC4583A6E1) < _id_30CDDDB8087B55B1;
}

_id_0ACA13D10DCCD63E(_id_BEEE8E39A2ED2475, _id_28EFCB0861A301F7) {
  points = [];
  num = getdvarint("dvar_116700C9B39C1EBA", 1) + 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < num; _id_AC0E594AC96AA3A8++) {
    startpoint = spawnStruct();
    startpoint.origin = _id_CF24515B476DE99E(_id_BEEE8E39A2ED2475, _id_28EFCB0861A301F7);
    startpoint.angles = (0, randomfloat(360), 0);
    startpoint.team = undefined;
    startpoint.script_label = "InteriorSpawnPoint";
    points[points.size] = startpoint;
  }

  return points;
}

_id_CF24515B476DE99E(_id_BEEE8E39A2ED2475, _id_28EFCB0861A301F7) {
  _id_332BFCF7ECA6F520 = _id_1B71C5C952BF3A5E::_id_3EC57983D173D1E3();
  return _id_2695A20D4011076D::getrandompointincircle(_id_332BFCF7ECA6F520, _id_28EFCB0861A301F7, float(_id_BEEE8E39A2ED2475) / _id_28EFCB0861A301F7, 1, 1, 1);
}

_id_43AB8F184738915A() {
  self notify("auto_test");
  self endon("auto_test");
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;)
    _id_6609E21915DE2C73();
}

_id_CCAF436F3F04C8CC() {
  level endon("game_ended");

  for(;;) {
    _id_9A0A24DE119B078A("Timer", "The game has been running for:" + scripts\mp\utility\print::getformattedtimestamp());
    wait 60;
  }
}

playershouldrespawn() {
  return 1;
}

_id_032BE989CD7E0E06(name, _id_FFD4129F1032E796, _id_60524DE5341E2666) {
  thread _id_FF299AA9C1C02C3E(name, _id_60524DE5341E2666);
  thread _id_B5EEB52EA9D620B2(name, _id_FFD4129F1032E796);
  scripts\engine\utility::_id_5ADCA43F839A3CCE([name, "death_or_disconnect"]);
}

_id_B5EEB52EA9D620B2(name, _id_FFD4129F1032E796) {
  self endon(name);
  self endon("death_or_disconnect");
  waitframe();
  self[[_id_FFD4129F1032E796]]();
  self notify(name);
}

_id_FF299AA9C1C02C3E(name, _id_60524DE5341E2666) {
  scripts\engine\utility::_id_5ADCA43F839A3CCE([name, "death_or_disconnect"]);
  self[[_id_60524DE5341E2666]]();
}

_id_6609E21915DE2C73() {
  if(_id_51A400F6949511DE() && !istrue(level._id_37AA0062320EBD1A._id_6EED45DF5312FFDC)) {
    level thread _id_7E4910196DCBE632::_id_5D1148BBED9FC1D7();
    level._id_37AA0062320EBD1A._id_6EED45DF5312FFDC = 1;
  }

  if(_id_9C05104BB0F63E33() && _id_7F6AF4C52BBDAB76::_id_3113F44EBAFE71B1())
    _id_032BE989CD7E0E06("door", _id_7F6AF4C52BBDAB76::_id_FFD4129F1032E796, _id_7F6AF4C52BBDAB76::_id_60524DE5341E2666);
  else if(_id_FE000D9716D3AC83() && _id_2C694004928BD388::_id_3113F44EBAFE71B1())
    _id_032BE989CD7E0E06("traversal", _id_2C694004928BD388::_id_FFD4129F1032E796, _id_2C694004928BD388::_id_60524DE5341E2666);
  else if(_id_2327B6E483B3FB90() && _id_5922BC5FBA8ED290::_id_3113F44EBAFE71B1())
    _id_032BE989CD7E0E06("connectivity", _id_5922BC5FBA8ED290::_id_FFD4129F1032E796, _id_5922BC5FBA8ED290::_id_60524DE5341E2666);
  else
    _id_032BE989CD7E0E06("wander", _id_1B71C5C952BF3A5E::_id_FFD4129F1032E796, _id_1B71C5C952BF3A5E::_id_60524DE5341E2666);

  waitframe();
}