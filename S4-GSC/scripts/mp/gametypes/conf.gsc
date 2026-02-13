/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\conf.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 65);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C250(scripts\mp\utility\game::getgametype(), 1);
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  game["dialog"]["gametype"] = "mp_glob_kcon_bchr_kcst";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "mp_glob_kcon_bchr_kchc";
  }

  game["dialog"]["boost"] = "mp_glob_gene_bchr_z254";
  game["dialog"]["offense_obj"] = "mp_glob_gene_bchr_z254";
  game["dialog"]["defense_obj"] = "mp_glob_gene_bchr_z254";
  game["dialog"]["kill_confirmed"] = ["mp_glob_kcon_bchr_andthatsakillconfirm", "mp_glob_kcon_bchr_killconfirmednicejob", "mp_glob_kcon_bchr_thatsakillconfirmed", "mp_glob_kcon_bchr_anotherkillconfirmed"];
  game["dialog"]["kill_denied"] = ["mp_glob_kcon_bchr_killdeniedbutdontgiv", "mp_glob_kcon_bchr_thatsakilldeniedsold", "mp_glob_kcon_bchr_killdenied", "mp_glob_kcon_bchr_killdeniedbutitsnott"];
  game["dialog"]["hint_tags"] = "hint_tags";
  level._id_3B72["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3ea832f361e5f0f9e", getmatchrulesdata("confData", "pointsPerConfirm"));
  setdynamicdvar("#x3ee3025e722ce448c", getmatchrulesdata("confData", "pointsPerDeny"));
  setdynamicdvar("#x3e1cf872f62a500", 0);
  scripts\mp\utility\game::_id_C25D("conf", 0);
  setdynamicdvar("#x3d628ca1e61295f94", 0);
}

_id_ABAD() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  foreach(var_3 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/CONF");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/CONF");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/CONF_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/CONF_HINT");
  }

  _id_8294();
  level._id_4CE2 = ::_id_4CE2;
  level._id_4CE6 = ::_id_4CE6;
}

_id_8294() {
  _id_0817::_id_D461("Default", "Crit_Frontline");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_tdm_spawn_allies_start");
  _id_0817::_id_113A("mp_tdm_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_tdm_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_tdm_spawn_axis_start");
  var_0 = _id_0817::_id_6D4E("mp_tdm_spawn_allies_start");
  var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_2 = _id_0817::_id_6D4E("mp_tdm_spawn");
  var_3 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
  _id_0817::_id_C2B9("normal", var_2);
  _id_0817::_id_C2B9("fallback", var_3);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_CBF7 = scripts\mp\utility\dvars::_id_509C("pointsPerConfirm", 1, 0, 25);
  level._id_CBF8 = scripts\mp\utility\dvars::_id_509C("pointsPerDeny", 0, 0, 25);
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
    } else {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
    }
  } else
    var_1 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");

  return var_1;
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_ABA4() {
  self setclientomnvar("ui_match_status_hint_text", 33);
}

_id_4CE2(var_0) {
  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["denied"]);
    var_1 = randomfloat(1);

    if(var_1 < 0.33) {
      var_0 _id_0A8D::_id_9137("kill_denied", undefined, undefined, undefined, 4);
    }

    var_0 scripts\mp\gamescore::_id_7001(var_0.pers["team"], level._id_CBF8, 0);
  }
}

_id_4CE6(var_0) {
  if(isPlayer(var_0)) {
    var_1 = randomfloat(1);

    if(var_1 < 0.33) {
      var_0 _id_0A8D::_id_9137("kill_confirmed", undefined, undefined, undefined, 4);
    }

    var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["confirmed"]);
    var_0 thread _id_07BC::creategametypechallenegeevent("conf_confirm");
  }

  var_0 scripts\mp\gamescore::_id_7001(var_0.pers["team"], level._id_CBF7, 0);
}