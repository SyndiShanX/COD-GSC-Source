/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\to_wmd.gsc
*************************************************/

main() {
  _id_997B();
  _id_07DC::init();
  _id_07DC::_id_D854();

  if(_func_0127()) {
    scripts\mp\utility\game::_id_D4E0();
  }

  _id_997C();
  level._id_E6A1 = 0;
  level._id_ABAD = ::_id_ABAD;
}

_id_997A() {
  _id_997B();
  _id_997C();
  level._id_E6A1 = 1;
  _id_ABAD(1);
}

_id_997B() {
  level._id_ED22 = "to_wmd";
  level._id_41D2 = "to_wmd";
  setomnvar("ui_tac_ops_submode", level._id_41D2);
}

_id_997C() {
  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA("to_wmd", 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1("to_wmd", 10);
    scripts\mp\utility\game::_id_C2AD("to_wmd", 65);
    scripts\mp\utility\game::_id_C2A9("to_wmd", 1);
    scripts\mp\utility\game::_id_C2D0("to_wmd", 1);
    scripts\mp\utility\game::_id_C27E("to_wmd", 0);
    scripts\mp\utility\game::_id_C25D("to_wmd", 0);
    scripts\mp\utility\game::_id_C250("to_wmd", 0);
    level._id_9BEB = 0;
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  level._id_ABC0 = scripts\mp\gamelogic::_id_4580;
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3a22e8059b1679206", 5);
  setdynamicdvar("#x3ea832f361e5f0f9e", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("#x3ee3025e722ce448c", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("#x3e1cf872f62a500", 0);
  scripts\mp\utility\game::_id_C25D("conf", 0);
  setdynamicdvar("#x3d628ca1e61295f94", 0);
}

_id_ABAD(var_0) {
  level._id_5856 = 0;
  setgameendtime(0);
  scripts\mp\utility\dvars::_id_D633("timelimit", 6);
  var_1[0] = "dd";
  var_1[1] = "dd_bombzone";
  var_1[2] = "blocker";
  var_1[3] = "grind";
  var_1[4] = "dom";
  var_1[5] = "conf";
  _id_07D6::main(var_1);

  if(!istrue(var_0)) {
    scripts\mp\gametypes\tac_ops::_id_3AE4();
    _id_0EFE();
  }
}

_id_8294() {
  var_0 = level._id_ED1E;
  _id_0817::_id_1136("allies", "mp_towmd_spawn_allies", 1);
  _id_0817::_id_1136("axis", "mp_towmd_spawn_axis", 1);
  var_0._id_F2B1 = [];
  var_0._id_F2B1["allies"] = _id_0817::_id_6D4E("mp_towmd_spawn_allies");
  var_0._id_F2B1["axis"] = _id_0817::_id_6D4E("mp_towmd_spawn_axis");

  if(var_0._id_F2B1["allies"].size <= 0) {
    _id_0817::_id_1136("allies", "mp_front_spawn_allies");
    var_0._id_F2B1["allies"] = _id_0817::_id_6D4E("mp_front_spawn_allies");
  }

  if(var_0._id_F2B1["axis"].size <= 0) {
    _id_0817::_id_1136("axis", "mp_front_spawn_axis");
    var_0._id_F2B1["axis"] = _id_0817::_id_6D4E("mp_front_spawn_axis");
  }
}

_id_6D4A() {
  var_0 = level._id_ED1E;
  var_1 = self.pers["team"];
  var_2 = _id_081C::_id_5A54(var_0._id_F2B1[var_1]);
  var_3 = undefined;
  return var_3;
}

_id_0EFE() {
  _id_0817::_id_D461("TDM");
  _id_081C::_id_D45F("to_wmd", "allies");
  _id_081C::_id_D45F("to_wmd", "axis");
  level._id_6D4A = ::_id_6D4A;
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
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