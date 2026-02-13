/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_conf.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  level._id_ED22 = "to_conf";
  level._id_41D2 = "to_conf";
  setomnvar("ui_tac_ops_submode", level._id_41D2);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 65);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C250(scripts\mp\utility\game::getgametype(), 1);
    level._id_9BEB = 0;
    level._id_9BF0 = 0;
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  level._id_ABC0 = scripts\mp\gamelogic::_id_4580;

  if(level._id_9BEB || level._id_9BF0) {
    level._id_A00B = _id_07C3::_id_60D1;
  }

  level._id_3B72["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  scripts\mp\bots\bots_gametype_to_conf::_id_D795();
  scripts\mp\bots\bots_gametype_to_conf::_id_D769();
  _id_ABAD();
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x39d81cb46387bee06", 5);
  setdynamicdvar("#x376e30d4ffec23996", 10);
  setdynamicdvar("#x3ea832f361e5f0f9e", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("#x3ee3025e722ce448c", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("#x3e1cf872f62a500", 0);
  scripts\mp\utility\game::_id_C25D("conf", 0);
  setdynamicdvar("#x3d628ca1e61295f94", 0);
}

_id_ABAD() {
  level._id_4CE2 = ::_id_4CE2;
  level._id_4CE6 = ::_id_4CE6;
  level._id_5856 = 0;
  setgameendtime(0);
  scripts\mp\utility\dvars::_id_D633("timelimit", 6);
}

_id_8294() {
  _id_0817::_id_D461("TDM");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_1136("allies", "mp_front_spawn_allies");
  _id_0817::_id_1136("axis", "mp_front_spawn_axis");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
}

_id_FC7D() {
  level._id_AD6A[_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_dogtags")] = 1;
  scripts\mp\gametypes\common::_id_FC39();
  level._id_CBF7 = scripts\mp\utility\dvars::_id_509C("pointsPerConfirm", 1, 0, 25);
  level._id_CBF8 = scripts\mp\utility\dvars::_id_509C("pointsPerDeny", 0, 0, 25);
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  }

  if(_id_0817::_id_DC06()) {
    var_1 = _id_0817::_id_6DDD(var_0);
    var_2 = undefined;
  } else {
    var_1 = _id_0817::_id_6DDD(var_0);
    var_3 = _id_0817::_id_6DCD(var_0);
    var_2 = undefined;
  }

  return var_2;
  return var_2;
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4);
}

_id_ABA4() {
  var_0 = 0;

  if(self.team == "allies") {
    var_0 = 1;
  } else if(self.team == "axis") {
    var_0 = 2;
  }

  self setclientomnvar("ui_tacops_team", var_0);
}

_id_4CE2(var_0) {
  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["denied"]);
    var_0 scripts\mp\gamescore::_id_7001(var_0.pers["team"], level._id_CBF8, 0);
  }
}

_id_4CE6(var_0) {
  if(isPlayer(var_0)) {
    var_0 _id_0A8D::_id_9137("kill_confirmed", undefined, undefined, undefined, 4);
    var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["confirmed"]);
  }

  var_0 scripts\mp\gamescore::_id_7001(var_0.pers["team"], level._id_CBF7, 0);
}