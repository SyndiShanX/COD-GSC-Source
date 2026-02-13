/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2016.gsc
*************************************************/

_id_2F32() {
  level._id_7AAC = 0;

  if(level.gameended) {
    return;
  }
  if(_func_0391()) {
    _func_038E();
  }

  level thread _id_7AA8();

  foreach(var_1 in level.characters) {
    var_1._id_7AA9 = 0;
  }

  level._id_7AAE = 1;
  setDvar("#x31ce9c5116005b62a", 1);
  level._id_7AA5 = 1;
  level notify("host_migration_begin");
  scripts\mp\gamelogic::_id_FD65();

  foreach(var_1 in level.characters) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1 thread _id_7AAF();

    if(isPlayer(var_1)) {
      var_1 setclientomnvar("ui_session_state", var_1.sessionstate);

      if(_func_0391()) {
        _func_0390(var_1.guid);
      }
    }
  }

  level endon("host_migration_begin");
  _id_7AB1();
  level._id_7AAE = undefined;
  setDvar("#x31ce9c5116005b62a", 0);
  visionsetthermal(game["thermal_vision"]);
  level._id_7AA5 = 0;
  level notify("host_migration_end");
  scripts\mp\gamelogic::_id_FD65();
  level thread[[level._id_FC75]]();
}

_id_7AA8() {
  level endon("host_migration_end");
  level endon("host_migration_begin");
  level waittill("connected", var_0);
  var_0 thread _id_7AAF();

  if(isPlayer(var_0)) {
    var_0 setclientomnvar("ui_session_state", var_0.sessionstate);
  }
}

_id_7AB1() {
  level endon("game_ended");
  level._id_7EB0 = 25;
  thread scripts\mp\gamelogic::_id_9BF2("waiting_for_players", 20.0);
  _id_7AB2();
  level._id_7EB0 = 10;
  thread scripts\mp\gamelogic::_id_9BF2("match_resuming_in", 5.0);
  wait 5;
  level._id_7EB0 = 0;

  if(istrue(level._id_5EFD) && !istrue(level._id_5EFC)) {
    setomnvar("ui_match_start_text", "opponent_forfeiting_in");
  }
}

_id_7AB2() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

_id_7AAB(var_0) {
  if(!isDefined(var_0)) {
    return "<removed_ent>";
  }

  var_1 = -1;
  var_2 = "?";

  if(isDefined(var_0._id_5501)) {
    var_1 = var_0._id_5501;
  }

  if(isPlayer(var_0) && isDefined(var_0.name)) {
    var_2 = var_0.name;
  }

  if(isPlayer(var_0)) {
    return "player <" + var_2 + ">";
  }

  if(isagent(var_0) && scripts\mp\utility\entity::_id_8877(var_0)) {
    return "participant agent <" + var_1 + ">";
  }

  if(isagent(var_0)) {
    return "non-participant agent <" + var_1 + ">";
  }

  return "unknown entity <" + var_1 + ">";
}

_id_7AB0() {
  level endon("host_migration_begin");
  level endon("host_migration_end");

  while(!scripts\mp\utility\player::isreallyalive(self)) {
    self waittill("spawned");
  }

  self._id_7AA9 = 1;
  scripts\mp\utility\player::_freezecontrols(1);
  level waittill("host_migration_end");
}

_id_7AAF() {
  self endon("disconnect");
  _id_7AB0();

  if(self._id_7AA9) {
    scripts\mp\utility\player::_freezecontrols(0);
    self._id_7AA9 = undefined;
  }
}

waittillhostmigrationdone() {
  if(!isDefined(level._id_7AAE)) {
    return 0;
  }

  var_0 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_0;
}

_id_10959(var_0) {
  if(isDefined(level._id_7AAE)) {
    return;
  }
  level endon("host_migration_begin");
  wait(var_0);
}

waitlongdurationwithhostmigrationpause(var_0) {
  if(var_0 == 0) {
    return;
  }
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    _id_10959((var_2 - gettime()) / 1000);

    if(isDefined(level._id_7AAE)) {
      var_3 = waittillhostmigrationdone();
      var_2 = var_2 + var_3;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_1;
}

_id_108F6(var_0, var_1) {
  self endon(var_0);

  if(var_1 == 0) {
    return;
  }
  var_2 = gettime();
  var_3 = gettime() + var_1 * 1000;

  while(gettime() < var_3) {
    _id_10959((var_3 - gettime()) / 1000);

    if(isDefined(level._id_7AAE)) {
      var_4 = waittillhostmigrationdone();
      var_3 = var_3 + var_4;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_2;
}

_id_1084E(var_0) {
  if(var_0 == 0) {
    return;
  }
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    _id_10959((var_2 - gettime()) / 1000);

    while(isDefined(level._id_7AAE)) {
      var_2 = var_2 + 1000;
      setgameendtime(int(var_2));
      wait 1;
    }
  }

  while(isDefined(level._id_7AAE)) {
    var_2 = var_2 + 1000;
    setgameendtime(int(var_2));
    wait 1;
  }

  return gettime() - var_1;
}