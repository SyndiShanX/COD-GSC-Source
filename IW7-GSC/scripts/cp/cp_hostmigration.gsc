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

hostmigrationname(var_0) {
  if(!isDefined(var_0)) {
    return "<removed_ent>";
  }

  var_1 = -1;
  var_2 = "?";
  if(isDefined(var_0.entity_number)) {
    var_1 = var_0.entity_number;
  }

  if(isplayer(var_0) && isDefined(var_0.name)) {
    var_2 = var_0.name;
  }

  if(isplayer(var_0)) {
    return "player <" + var_2 + ">";
  }

  if(isagent(var_0) && scripts\cp\utility::isgameparticipant(var_0)) {
    return "participant agent <" + var_1 + ">";
  }

  if(isagent(var_0)) {
    return "non-participant agent <" + var_1 + ">";
  }

  return "unknown entity <" + var_1 + ">";
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

  var_0 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_0;
}

waittillhostmigrationstarts(var_0) {
  if(isDefined(level.hostmigrationtimer)) {
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
    waittillhostmigrationstarts(var_2 - gettime() / 1000);
    if(isDefined(level.hostmigrationtimer)) {
      var_3 = waittillhostmigrationdone();
      var_2 = var_2 + var_3;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_1;
}

waittill_notify_or_timeout_hostmigration_pause(var_0, var_1) {
  self endon(var_0);
  if(var_1 == 0) {
    return;
  }

  var_2 = gettime();
  var_3 = gettime() + var_1 * 1000;
  while(gettime() < var_3) {
    waittillhostmigrationstarts(var_3 - gettime() / 1000);
    if(isDefined(level.hostmigrationtimer)) {
      var_4 = waittillhostmigrationdone();
      var_3 = var_3 + var_4;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_2;
}

waitlongdurationwithgameendtimeupdate(var_0) {
  if(var_0 == 0) {
    return;
  }

  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;
  while(gettime() < var_2) {
    waittillhostmigrationstarts(var_2 - gettime() / 1000);
    while(isDefined(level.hostmigrationtimer)) {
      var_2 = var_2 + 1000;
      setgameendtime(int(var_2));
      wait(1);
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_2 = var_2 + 1000;
    setgameendtime(int(var_2));
    wait(1);
  }

  return gettime() - var_1;
}

matchstarttimer(var_0, var_1) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_2 = int(var_1);
  if(var_2 >= 2) {
    setomnvar("ui_match_start_text", var_0);
    matchstarttimer_internal(var_2);
    visionsetnaked("", 3);
    return;
  }

  introvisionset();
  visionsetnaked("", 1);
}

matchstarttimer_internal(var_0) {
  waittillframeend;
  introvisionset();
  level endon("match_start_timer_beginning");
  while(var_0 > 0 && !level.gameended) {
    setomnvar("ui_match_start_countdown", var_0);
    if(var_0 == 0) {
      visionsetnaked("", 0);
    }

    var_0--;
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