/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2000.gsc
*************************************************/

_id_8191() {
  level._id_5AA4 = level._id_5AA7 == 0;
  level._id_5AA6 = [];

  foreach(var_1 in level._id_EF89) {
    level._id_5AA6[var_1] = undefined;
  }

  level._id_5AA6["none"] = undefined;
  level._id_5AA3 = undefined;
  level._id_C145 = 1;

  if(scripts\mp\utility\game::getgametype() == "br") {
    level._id_5AA4 = 1;
    return;
  }
}

_id_5597() {
  for(var_0 = 0; var_0 < level._id_EF89.size; var_0++) {
    level._id_5AA6[level._id_EF89[var_0]] = undefined;
  }

  level._id_5AA6["none"] = undefined;
  level._id_5AA3 = undefined;
}

_id_BB9B() {
  var_0 = undefined;

  if(istrue(level._id_A731)) {
    return;
  }
  if(istrue(level._id_2B51)) {
    return;
  }
  if(level._id_BA8B) {
    if(_id_0805::_id_DBD9()) {
      level._id_BA8B = 0;
      level._id_5AA7 = 0;
      level._id_5AA4 = 1;
    }
  }

  if(level._id_5AA4) {
    var_1 = level._id_5AA6[level._id_5AA3];

    if(!isDefined(var_1)) {
      _id_07D1::_id_9355("final_killcam_preloaded");
      return;
    }

    var_0 = var_1.attacker;
  } else {
    var_2 = gettime();

    while(!_id_0805::_id_8A87()) {
      waitframe();
    }

    var_3 = _id_0805::_id_6A37();

    if(!isDefined(var_3)) {
      _id_07D1::_id_9355("final_killcam_preloaded");
      return;
    }

    var_0 = var_3._id_E3E1;
  }

  if(!isDefined(var_0) || !isPlayer(var_0)) {
    _id_07D1::_id_9355("final_killcam_preloaded");
    return;
  }

  var_4 = var_0 getEye();

  foreach(var_6 in level.players) {
    var_6 _meth_8215(var_0);
    var_6 _meth_8282(var_4, 1);
  }

  if(_id_0828::_id_86DC()) {
    _id_0828::preload_weapons("pom", var_0);
  }

  if(level._id_BA8B) {
    wait 1.0;
  }

  _id_07D1::_id_9355("final_killcam_preloaded");
}

_id_4E67() {
  if(isDefined(level._id_DDAE) || istrue(level._id_A731)) {
    return;
  }
  if((scripts\mp\utility\game::getgametype() == "sd" || scripts\mp\utility\game::getgametype() == "control") && !scripts\mp\utility\game::_id_10A16() && getdvarint("#x34e36f423d53d30d6", 1)) {
    return;
  }
  level._id_DCBA = 1;
  level._id_9C7E = 0.0;
  var_0 = level.potgwinner;

  foreach(var_2 in level.players) {
    var_3 = _id_0805::_id_6A37();

    if(!isDefined(var_3) || !isDefined(var_3._id_E3E1)) {
      level._id_DCBA = 0;
      return;
    }

    var_2 _id_07E7::_id_C634();
    var_2 scripts\mp\utility\player::_id_C708(0);
    var_2 setclientomnvar("ui_total_fade", 0);
    var_2 setclientomnvar("post_game_state", 4);

    if(isDefined(level.potgwinner.killcamvanityindex)) {
      var_2 setclientomnvar("ui_killcam_prestream_vanity_index", level.potgwinner.killcamvanityindex);
      var_2 setclientomnvar("ui_killcam_killedby_vanity_index", level.potgwinner.killcamvanityindex);
    }

    if(!scripts\mp\utility\weapon::_id_88F6(var_0.primaryweaponobj.basename)) {
      var_2 _id_07E7::_id_D5D0(var_0.primaryweaponobj, var_3._id_E3E1);
    }

    var_2 _id_07E7::_id_D8A5(var_3._id_E3E1, 0);
  }

  if(_id_0828::_id_86DC() && getdvarint("#x337dc1f218268a26", 1) == 1 && !getdvarint("#x3af4635af5e253c51", 0) && !istrue(level._id_A737)) {
    var_5 = _id_0805::_id_699D();

    foreach(var_2 in level.players) {
      if(!var_2 _meth_81D3()) {
        continue;
      }
      var_2 setclientomnvar("ui_killcam_killedby_health_ratio", var_5.playerhealthratio);
    }

    _id_0828::_id_C9ED(var_5._id_BCCE);
  }

  var_8 = scripts\mp\utility\game::modesupportsloadoutsharing() && !scripts\mp\utility\game::privatematch() && getdvarint("#x3a9c4045693a5c72b", 0) && getdvarint("#x392b4130600d839f5", 0);

  foreach(var_2 in level.players) {
    if(var_8 && !isbot(var_2) && var_2 != level.potgwinner) {
      var_2 thread _id_07C3::startlistenforloadoutsave(level.potgwinner);
    }
  }

  foreach(var_2 in level.players) {
    var_2 _meth_8209(1, 0);
    var_2 thread _id_4E68();
  }

  for(;;) {
    var_13 = 0;

    foreach(var_2 in level.players) {
      if(istrue(var_2._id_82D7)) {
        var_13 = 1;
        break;
      }
    }

    if(!var_13) {
      break;
    }

    waitframe();
  }

  if(_id_0828::_id_86DC()) {
    _id_0828::cleanup_preloaded_weapons("pom");
  }

  foreach(var_2 in level.players) {
    if(var_8 && !isbot(var_2) && var_2 != level.potgwinner) {
      var_2 thread _id_07C3::stoplistenforloadoutsave();
    }
  }

  level._id_DCBA = 0;
}

_id_4E68() {
  self endon("disconnect");
  self._id_82D7 = 1;
  var_0 = _id_0805::_id_6A37();

  if(!isDefined(var_0) || !isDefined(var_0._id_E3E1)) {
    _id_BA8F();
    return;
  }

  thread _id_07E7::_id_BA8A(var_0._id_E3E1, var_0._id_0354, var_0._id_E72D, var_0._id_534E);
  var_1 = scripts\engine\utility::_id_1089F("begin_killcam", "killcam_ended");

  if(var_1 == "killcam_ended") {
    _id_BA8F();
    return;
  }

  thread scripts\mp\utility\game::_id_D73A(1.0, self._id_8D68 - 0.5);
  self waittill("killcam_ended");
  _id_BA8F();
}

_id_BA8F() {
  self setclientomnvar("post_game_state", 1);
  self._id_82D7 = 0;
}

_id_D8A2(var_0, var_1) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  self setclientomnvar("ui_killcam_victim_or_attacker", 1);
  _id_07E7::_id_C634();
  var_2 = spawnStruct();
  var_2._id_8D68 = 0;
  _id_07E7::_id_D887(var_0.attacker, var_0._id_103C2, var_0.objweapon, var_2, 0, var_0._id_1DDA);
  self setclientomnvar("ui_in_player_showcase", 1);
}

_id_4CAC() {
  if(!level._id_5AA4) {
    return 0;
  }

  if(isDefined(level._id_DDAE) || istrue(level._id_A731)) {
    return 0;
  }

  level._id_DCBA = 1;
  var_0 = "none";

  if(isDefined(level._id_5AA3)) {
    var_0 = level._id_5AA3;
  }

  var_1 = level._id_5AA6[var_0];

  if(!isDefined(var_1)) {
    level._id_DCBA = 0;
    return 0;
  }

  var_2 = var_1.attacker;
  var_3 = var_1._id_103C2;

  if(!isDefined(var_3) || !isDefined(var_2)) {
    level._id_DCBA = 0;
    return 0;
  }

  var_4 = 20;
  var_5 = scripts\mp\utility\game::_id_6D1C();
  var_6 = max(0, scripts\mp\utility\game::_id_6D1C() - var_1._id_F256);

  if(var_6 > var_4) {
    level._id_DCBA = 0;
    return 0;
  }

  level thread _id_07BC::_id_BD6E(var_2, var_3);
  _func_02E3("atmosphere", "killcam", 0.1);
  level._id_9C7E = 0.0;

  foreach(var_8 in level.players) {
    var_8 scripts\mp\utility\player::_id_C708(0);
    var_8 setclientomnvar("ui_total_fade", 0);
    var_8 setclientomnvar("post_game_state", 3);
    var_8 setclientomnvar("ui_killcam_final_length", int(var_6 * 1000));

    if(isDefined(level.potgwinner.killcamvanityindex)) {
      var_8 setclientomnvar("ui_killcam_killedby_vanity_index", level.potgwinner.killcamvanityindex);
    }

    var_8 _id_D8A2(var_1);
  }

  foreach(var_8 in level.players) {
    if(!var_8 _meth_81D3()) {
      continue;
    }
    if(!scripts\mp\utility\weapon::_id_88F6(var_1.objweapon.basename)) {
      var_8 _id_07E7::_id_D5CD(var_1.objweapon, var_1._id_DE2B, var_1._id_511D, var_1._id_5705);
    }

    var_8 setclientomnvar("ui_killcam_killedby_health_ratio", var_1.attackerhealthratio);
  }

  if(_id_0828::_id_86DC() && getdvarint("#x337dc1f218268a26", 1) == 1 && !getdvarint("#x3af4635af5e253c51", 0) && !istrue(level._id_A737)) {
    _id_0828::_id_C9ED(var_2);
  }

  var_12 = scripts\mp\utility\game::modesupportsloadoutsharing() && !scripts\mp\utility\game::privatematch() && getdvarint("#x3a9c4045693a5c72b", 0) && getdvarint("#x3ac0a19ea2d1c42bc", 0);

  foreach(var_8 in level.players) {
    if(var_12 && !isbot(var_8) && var_8 != var_2) {
      var_8 thread _id_07C3::startlistenforloadoutsave(var_2);
    }
  }

  var_15 = (gettime() - var_3._id_441F) / 1000;

  foreach(var_8 in level.players) {
    var_8._id_0266 = var_3 getentitynumber();
    var_8 _id_07C3::_id_FC4B(var_1._id_1DDE, var_1._id_1DD4, var_2);

    if(!scripts\mp\utility\weapon::_id_88F6(var_1.objweapon.basename) && !var_8 _meth_81D3()) {
      var_8 _id_07E7::_id_D5CD(var_1.objweapon, var_1._id_DE2B, var_1._id_511D, var_1._id_5705);
    }

    var_8 _meth_82FC("killcam", "mix");
    var_8 thread _id_07E7::_id_4D03(var_1, var_15, 0, 1);
  }

  wait(0.15 + level._id_9C7E);

  while(_id_1918()) {
    waitframe();
  }

  foreach(var_8 in level.players) {
    if(var_12 && !isbot(var_8) && var_8 != var_2) {
      var_8 thread _id_07C3::stoplistenforloadoutsave();
    }
  }

  level._id_DCBA = 0;
}

_id_5AA5() {
  self notify("showing_final_killcam");
  self _meth_8209(1, 0);
  thread scripts\mp\utility\game::_id_D73A(1.0, self._id_8D68 - 0.5);
  self setclientomnvar("post_game_state", 3);
  thread _id_10BD2();
}

_id_10BD2() {
  self endon("killcam_canceled");
  self waittill("killcam_ended");
  _func_02E3("atmosphere", "", 0.5);
  self _meth_8078(4);
  thread scripts\mp\playerlogic::_id_E2C1();
}

_id_C145(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!_id_0805::_id_DBD9()) {
    return;
  }
  var_11 = spawnStruct();

  if(isDefined(var_4) && isagent(var_4)) {
    var_11._id_1210 = var_4._id_1210;
    var_11._id_904F = var_4._id_904F;
  }

  var_12 = _id_07E7::_id_99F7(var_4, var_11, var_3, var_5, var_6, var_1 getentitynumber(), var_7, var_8, var_9, 3, var_2, var_1, var_10, var_2.pers["loadoutPerks"], 0, 1);
  var_12._id_F256 = scripts\mp\utility\game::_id_6D1C();

  if(var_10 == "MOD_EXECUTION") {
    var_12._id_F256 = var_12._id_F256 - 3.0;
    var_12._id_F256 = max(0, var_12._id_F256);
  }

  var_12._id_1DDE = var_1._id_1DDE;
  var_12._id_1DD4 = var_1._id_1DD4;

  if(level.teambased && isDefined(var_2.team)) {
    level._id_5AA6[var_2.team] = var_12;
  } else if(!level.teambased) {
    level._id_5AA6[var_2.guid] = var_12;
  }

  level._id_5AA6["none"] = var_12;
}

_id_10860() {
  self endon("disconnect");
  self endon("killcam_death_done_waiting");
  self notifyonplayercommand("death_respawn", "+usereload");
  self notifyonplayercommand("death_respawn", "+activate");
  self waittill("death_respawn");
  self notify("killcam_death_button_cancel");
}

_id_10861(var_0) {
  self endon("disconnect");
  self endon("killcam_death_button_cancel");
  wait(var_0);
  self notify("killcam_death_done_waiting");
}

_id_DDB1(var_0) {
  self endon("disconnect");

  if(level._id_DCBA) {
    return 0;
  }

  if(!isai(self)) {
    thread _id_10860();
    thread _id_10861(var_0);
    var_1 = scripts\engine\utility::_id_10897("killcam_death_done_waiting", "killcam_death_button_cancel");

    if(isDefined(var_1) && var_1 == "killcam_death_done_waiting") {
      self._id_DDC1 = 0;
      return 0;
    } else {
      self._id_DDC1 = 1;
      scripts\mp\utility\stats::_id_7DAE("skippedKillcams", 1);
      return 1;
    }
  }

  return 0;
}

_id_1918() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1.killcam)) {
      return 1;
    }
  }

  return 0;
}