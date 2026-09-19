/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_hostmigration.gsc
********************************************************/

callback_hostmigration() {
  level._id_4E08 = 0;

  if(level.gameended) {
    return;
  }
  var_0 = getmatchdata("match_common", "hostMigrationCount");
  var_0++;
  setmatchdata("match_common", "hostMigrationCount", var_0);

  foreach(var_2 in _func_2D1())
  var_2._id_4E05 = 0;

  level.hostmigrationtimer = 1;
  setDvar("ui_inhostmigration", 1);
  level notify("host_migration_begin");
  maps\mp\gametypes\_gamelogic::_id_A17B();

  foreach(var_2 in _func_2D1()) {
    if(isDefined(var_2.waterwakevfxdeletefunc))
      var_2[[var_2.waterwakevfxdeletefunc]]();

    if(isDefined(var_2.onhostmigrationbeginfunc))
      var_2[[var_2.onhostmigrationbeginfunc]]();

    var_2 thread _id_4E0A();

    if(isPlayer(var_2)) {
      var_2 _meth_82FF("ui_session_state", var_2.sessionstate);
      var_2 _meth_85EF(&"host_migration_show_hud", 0);
    }
  }

  setDvar("2523", game["state"]);
  level endon("host_migration_begin");
  _id_4E0C();
  level.hostmigrationtimer = undefined;
  setDvar("ui_inhostmigration", 0);
  level notify("host_migration_end");
  maps\mp\gametypes\_gamelogic::_id_A17B();
  level thread maps\mp\gametypes\_gamelogic::_id_A11E();
}

_id_4E0C() {
  level endon("game_ended");
  level._id_5139 = 25;
  thread maps\mp\gametypes\_gamelogic::_id_6037(20.0);
  _id_4E0D();
  level._id_5139 = 10;
  thread maps\mp\gametypes\_gamelogic::_id_6037(5.0);
  wait 5;
  level._id_5139 = 0;
}

_id_4E0D() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

_id_4E07(var_0) {
  if(!isDefined(var_0))
    return "<removed_ent>";

  var_1 = -1;
  var_2 = "?";

  if(isDefined(var_0._id_37CD))
    var_1 = var_0._id_37CD;

  if(isPlayer(var_0) && isDefined(var_0.name))
    var_2 = var_0.name;

  if(isPlayer(var_0))
    return "player <" + var_2 + "> (entNum " + var_1 + " )";

  if(_func_1EF(var_0) && maps\mp\_utility::_id_56FF(var_0))
    return "participant agent <" + var_1 + ">";

  if(_func_1EF(var_0))
    return "non-participant agent <" + var_1 + ">";

  return "unknown entity <" + var_1 + ">";
}

_id_4E0B() {
  level endon("host_migration_begin");
  level endon("host_migration_end");
  self endon("disconnect");
  self._id_4E05 = 1;

  while(!maps\mp\_utility::isreallyalive(self))
    self waittill("spawned");

  maps\mp\_utility::freezecontrolswrapper(1);
  self _meth_800F();
  level waittill("host_migration_end");
}

_id_4E0A() {
  level endon("host_migration_begin");
  self endon("disconnect");

  if(_func_1EF(self))
    self endon("death");

  _id_4E0B();

  if(self._id_4E05) {
    if(maps\mp\_utility::gameflag("prematch_done")) {
      maps\mp\_utility::freezecontrolswrapper(0);
      self _meth_800E();
    }

    self._id_4E05 = undefined;
  }
}

_id_A782() {
  if(!isDefined(level.hostmigrationtimer))
    return 0;

  var_0 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_0;
}

_id_A783(var_0) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  level endon("host_migration_begin");
  wait(var_0);
}

_id_A6F5(var_0) {
  if(var_0 == 0) {
    return;
  }
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    _id_A783((var_2 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var_3 = _id_A782();
      var_2 = var_2 + var_3;
    }
  }

  _id_A782();
  return gettime() - var_1;
}

_id_A74C(var_0, var_1) {
  self endon(var_0);

  if(var_1 == 0) {
    return;
  }
  var_2 = gettime();
  var_3 = gettime() + var_1 * 1000;

  while(gettime() < var_3) {
    _id_A783((var_3 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var_4 = _id_A782();
      var_3 = var_3 + var_4;
    }
  }

  _id_A782();
  return gettime() - var_2;
}

_id_A6F4(var_0) {
  if(var_0 == 0) {
    return;
  }
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    _id_A783((var_2 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var_2 = var_2 + 1000;
      _func_137(int(var_2));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_2 = var_2 + 1000;
    _func_137(int(var_2));
    wait 1;
  }

  return gettime() - var_1;
}