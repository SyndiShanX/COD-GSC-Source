/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\cp_hostmigration.gsc
*******************************************/

hostmigrationwait() {
  level endon("game_ended");
  level.ingraceperiod = 25;
  thread matchstarttimer("waiting_for_players", 20);
  hostmigrationwaitforplayers();
  level.ingraceperiod = 10;
  thread matchstarttimer("match_resuming_in", 5);
  wait(5);
  level.ingraceperiod = 0;
}

hostmigrationwaitforplayers() {
  level endon("hostmigration_enoughplayers");
  wait(15);
}

hostmigrationname(param_00) {
  if(!isDefined(param_00)) {
    return "<removed_ent>";
  }

  var_01 = -1;
  var_02 = "?";
  if(isDefined(param_00.entity_number)) {
    var_01 = param_00.entity_number;
  }

  if(isplayer(param_00) && isDefined(param_00.name)) {
    var_02 = param_00.name;
  }

  if(isplayer(param_00)) {
    return "player <" + var_02 + ">";
  }

  if(isagent(param_00) && scripts\cp\utility::isgameparticipant(param_00)) {
    return "participant agent <" + var_01 + ">";
  }

  if(isagent(param_00)) {
    return "non-participant agent <" + var_01 + ">";
  }

  return "unknown entity <" + var_01 + ">";
}

hostmigrationtimerthink_internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");
  while(!scripts\cp\utility::isreallyalive(self)) {
    self waittill("spawned");
  }

  self.hostmigrationcontrolsfrozen = 1;
  scripts\cp\utility::freezecontrolswrapper(1);
  level waittill("host_migration_end");
}

hostmigrationtimerthink() {
  self endon("disconnect");
  hostmigrationtimerthink_internal();
  if(self.hostmigrationcontrolsfrozen) {
    if(scripts\cp\utility::gameflag("prematch_done")) {
      scripts\cp\utility::freezecontrolswrapper(0);
    }

    self.hostmigrationcontrolsfrozen = undefined;
  }
}

waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer)) {
    return 0;
  }

  var_00 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_00;
}

waittillhostmigrationstarts(param_00) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon("host_migration_begin");
  wait(param_00);
}

waitlongdurationwithhostmigrationpause(param_00) {
  if(param_00 == 0) {
    return;
  }

  var_01 = gettime();
  var_02 = gettime() + param_00 * 1000;
  while(gettime() < var_02) {
    waittillhostmigrationstarts(var_02 - gettime() / 1000);
    if(isDefined(level.hostmigrationtimer)) {
      var_03 = waittillhostmigrationdone();
      var_02 = var_02 + var_03;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_01;
}

waittill_notify_or_timeout_hostmigration_pause(param_00, param_01) {
  self endon(param_00);
  if(param_01 == 0) {
    return;
  }

  var_02 = gettime();
  var_03 = gettime() + param_01 * 1000;
  while(gettime() < var_03) {
    waittillhostmigrationstarts(var_03 - gettime() / 1000);
    if(isDefined(level.hostmigrationtimer)) {
      var_04 = waittillhostmigrationdone();
      var_03 = var_03 + var_04;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_02;
}

waitlongdurationwithgameendtimeupdate(param_00) {
  if(param_00 == 0) {
    return;
  }

  var_01 = gettime();
  var_02 = gettime() + param_00 * 1000;
  while(gettime() < var_02) {
    waittillhostmigrationstarts(var_02 - gettime() / 1000);
    while(isDefined(level.hostmigrationtimer)) {
      var_02 = var_02 + 1000;
      setgameendtime(int(var_02));
      wait(1);
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_02 = var_02 + 1000;
    setgameendtime(int(var_02));
    wait(1);
  }

  return gettime() - var_01;
}

matchstarttimer(param_00, param_01) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_02 = int(param_01);
  if(var_02 >= 2) {
    setomnvar("ui_match_start_text", param_00);
    matchstarttimer_internal(var_02);
    visionsetnaked("", 3);
    return;
  }

  introvisionset();
  visionsetnaked("", 1);
}

matchstarttimer_internal(param_00) {
  waittillframeend;
  introvisionset();
  level endon("match_start_timer_beginning");
  while(param_00 > 0 && !level.gameended) {
    setomnvar("ui_match_start_countdown", param_00);
    if(param_00 == 0) {
      visionsetnaked("", 0);
    }

    param_00--;
    wait(1);
  }

  setomnvar("ui_match_start_countdown", 0);
}

introvisionset() {
  if(!isDefined(level.introvisionset)) {
    level.introvisionset = "mpIntro";
  }

  visionsetnaked(level.introvisionset, 0);
}