/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1843.gsc
*************************************************/

_id_7AB1() {
  level endon("game_ended");
  level._id_7EB0 = 25;
  thread _id_9BF2("waiting_for_players", 20.0);
  _id_7AB2();
  level._id_7EB0 = 10;
  thread _id_9BF2("match_resuming_in", 5.0);
  wait 5;
  level._id_7EB0 = 0;
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

  if(isagent(var_0) && scripts\cp\utility::_id_8877(var_0)) {
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

  while(!scripts\cp_mp\utility\player_utility::_isalive()) {
    self waittill("spawned");
  }

  self._id_7AA9 = 1;
  scripts\cp\utility::_id_5F63(1);
  level waittill("host_migration_end");
}

_id_7AAF() {
  self endon("disconnect");
  _id_7AB0();

  if(self._id_7AA9) {
    if(scripts\cp\utility::_id_60BE("prematch_done")) {
      scripts\cp\utility::_id_5F63(0);
    }

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

_id_9BF2(var_0, var_1) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_2 = int(var_1);

  if(var_2 >= 2) {
    setomnvar("ui_match_start_text", var_0);
    _id_9BF3(var_2);
    visionsetnaked("", 3.0);
  } else {
    _id_84E3();
    visionsetnaked("", 1.0);
  }
}

_id_9BF3(var_0) {
  waittillframeend;
  _id_84E3();
  level endon("match_start_timer_beginning");

  while(var_0 > 0 && !level.gameended) {
    foreach(var_2 in level.players) {
      var_2 setclientomnvar("ui_match_start_countdown", var_0);
      var_2 setclientomnvar("ui_match_in_progress", 0);
    }

    if(var_0 == 0) {
      visionsetnaked("", 0);
    }

    var_0--;
    wait 1.0;
  }

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_match_start_countdown", 0);
    var_2 setclientomnvar("ui_match_in_progress", 1);
  }
}

_id_84E3() {
  if(!isDefined(level._id_84E3)) {
    level._id_84E3 = "mpIntro";
  }

  visionsetnaked(level._id_84E3, 0);
}