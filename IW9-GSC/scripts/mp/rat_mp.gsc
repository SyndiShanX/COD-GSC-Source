/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\rat_mp.gsc
***********************************************/

init() {
  level._id_6392BEFA93AE3CC6 = undefined;
  level._id_91CA776F27D516C0 = undefined;
  _id_1A4FC95657361D97::init();
  _id_1A4FC95657361D97::_id_7A2DF9055CB22721("RatGetPlayerTeam", ::_id_A8822278E0639B8C, "string");
  _id_1A4FC95657361D97::_id_7A2DF9055CB22721("RatGetTeamCount", ::_id_481D2ED0525CA7F0, "int64_t");
  _id_1A4FC95657361D97::_id_7A2DF9055CB22721("RatGetPlayerEquipment", ::_id_88B08CA08DA59637, "string");
}

_id_A8822278E0639B8C(params) {
  player = _id_1A4FC95657361D97::_id_C98BC8F1BC6DECB2(params);
  return player.team;
}

_id_481D2ED0525CA7F0(params) {
  _id_B32A6E22B9CC2580 = scripts\engine\utility::_id_53C4C53197386572(params.team, "player");
  _id_A369F87F8A7A9868 = _id_A8822278E0639B8C(params);

  if(_id_B32A6E22B9CC2580 == "player")
    _id_B32A6E22B9CC2580 = _id_A369F87F8A7A9868;

  if(_id_B32A6E22B9CC2580 == "enemy") {
    if(_id_A369F87F8A7A9868 == "axis")
      _id_B32A6E22B9CC2580 = "allies";
    else
      _id_B32A6E22B9CC2580 = "axis";
  }

  return scripts\mp\utility\teams::getteamdata(_id_B32A6E22B9CC2580, "players").size;
}

_id_88B08CA08DA59637(params) {
  _id_313729DF937CBE05 = scripts\engine\utility::_id_53C4C53197386572(params.slot, "primary");
  player = _id_1A4FC95657361D97::_id_C98BC8F1BC6DECB2(params);
  _id_2EB789D043254817 = player _id_7EF95BBA57DC4B82::getcurrentequipment(_id_313729DF937CBE05);
  return _id_2EB789D043254817;
}