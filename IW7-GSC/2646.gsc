/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2646.gsc
***************************************/

hostmigrationwait() {
  level endon("game_ended");
  level.ingraceperiod = 25;
  thread matchstarttimer("waiting_for_players", 20.0);
  hostmigrationwaitforplayers();
  level.ingraceperiod = 10;
  thread matchstarttimer("match_resuming_in", 5.0);
  wait 5;
  level.ingraceperiod = 0;
}

hostmigrationwaitforplayers() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

hostmigrationname(var_00) {
  if(!isDefined(var_00)) {
    return "<removed_ent>";
  }

  var_01 = -1;
  var_02 = "?";

  if(isDefined(var_0.entity_number)) {
    var_01 = var_0.entity_number;
  }

  if(isplayer(var_00) && isDefined(var_0.name)) {
    var_02 = var_0.name;
  }

  if(isplayer(var_00)) {
    return "player <" + var_02 + ">";
  }

  if(isagent(var_00) && scripts\cp\utility::isgameparticipant(var_00)) {
    return "participant agent <" + var_01 + ">";
  }

  if(isagent(var_00)) {
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

waittillhostmigrationstarts(var_00) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  level endon("host_migration_begin");
  wait(var_00);
}

waitlongdurationwithhostmigrationpause(var_00) {
  if(var_00 == 0) {
    return;
  }
  var_01 = gettime();
  var_02 = gettime() + var_00 * 1000;

  while(gettime() < var_02) {
    waittillhostmigrationstarts((var_02 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var_03 = waittillhostmigrationdone();
      var_02 = var_02 + var_03;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_01;
}

waittill_notify_or_timeout_hostmigration_pause(var_00, var_01) {
  self endon(var_00);

  if(var_01 == 0) {
    return;
  }
  var_02 = gettime();
  var_03 = gettime() + var_01 * 1000;

  while(gettime() < var_03) {
    waittillhostmigrationstarts((var_03 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var_04 = waittillhostmigrationdone();
      var_03 = var_03 + var_04;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_02;
}

waitlongdurationwithgameendtimeupdate(var_00) {
  if(var_00 == 0) {
    return;
  }
  var_01 = gettime();
  var_02 = gettime() + var_00 * 1000;

  while(gettime() < var_02) {
    waittillhostmigrationstarts((var_02 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var_02 = var_02 + 1000;
      setgameendtime(int(var_02));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_02 = var_02 + 1000;
    setgameendtime(int(var_02));
    wait 1;
  }

  return gettime() - var_01;
}

matchstarttimer(var_00, var_01) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var_02 = int(var_01);

  if(var_02 >= 2) {
    setomnvar("ui_match_start_text", var_00);
    matchstarttimer_internal(var_02);
    visionsetnaked("", 3.0);
  } else {
    introvisionset();
    visionsetnaked("", 1.0);
  }
}

matchstarttimer_internal(var_00) {
  waittillframeend;
  introvisionset();
  level endon("match_start_timer_beginning");

  while(var_00 > 0 && !level.gameended) {
    setomnvar("ui_match_start_countdown", var_00);

    if(var_00 == 0) {
      visionsetnaked("", 0);
    }

    var_0--;
    wait 1.0;
  }

  setomnvar("ui_match_start_countdown", 0);
}

introvisionset() {
  if(!isDefined(level.introvisionset)) {
    level.introvisionset = "mpIntro";
  }

  visionsetnaked(level.introvisionset, 0);
}