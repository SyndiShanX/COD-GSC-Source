/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hostmigration.gsc
***********************************************/

function hostmigrationwait() {
  level endon("game_ended");
  level.ingraceperiod = 25;
  thread matchstarttimer("waiting_for_players", 20);
  hostmigrationwaitforplayers();
  level.ingraceperiod = 10;
  thread matchstarttimer("match_resuming_in", 5);
  wait 5;
  level.ingraceperiod = 0;
}

function hostmigrationwaitforplayers() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

function hostmigrationname(var0) {
  if(!isDefined(var0)) {
    return "<removed_ent>";
  }

  var1 = -1;
  var2 = "?";

  if(isDefined(var0.entity_number)) {
    var1 = var0.entity_number;
  }

  if(isPlayer(var0) && isDefined(var0.name)) {
    var2 = var0.name;
  }

  if(isPlayer(var0)) {
    return ("player <" + var2 + ">");
  }

  if(isagent(var0) && scripts\cp\utility::isgameparticipant(var0)) {
    return ("participant agent <" + var1 + ">");
  }

  if(isagent(var0)) {
    return ("non-participant agent <" + var1 + ">");
  }

  return "unknown entity <" + var1 + ">";
}

function hostmigrationtimerthink_internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");

  while(!scripts\cp_mp\utility\player_utility::_isalive()) {
    self waittill("spawned");
  }

  self.hostmigrationcontrolsfrozen = 1;
  scripts\cp\utility::freezecontrolswrapper(1);
  level waittill("host_migration_end");
}

function hostmigrationtimerthink() {
  self endon("disconnect");
  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    if(scripts\cp\utility::gameflag("prematch_done")) {
      scripts\cp\utility::freezecontrolswrapper(0);
    }

    self.hostmigrationcontrolsfrozen = undefined;
    return;
  }
}

function waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer)) {
    return 0;
  }

  var0 = gettime();
  level waittill("host_migration_end");
  return gettime() - var0;
}

function waittillhostmigrationstarts(var0) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon("host_migration_begin");
  wait var0;
}

function waitlongdurationwithhostmigrationpause(var0) {
  if(var0 == 0) {
    return;
  }

  var1 = gettime();
  var2 = gettime() + var0 * 1000;

  while(gettime() < var2) {
    waittillhostmigrationstarts((var2 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var3 = waittillhostmigrationdone();
      var2 += var3;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var1;
}

function waittill_notify_or_timeout_hostmigration_pause(var0, var1) {
  self endon(var0);

  if(var1 == 0) {
    return;
  }

  var2 = gettime();
  var3 = gettime() + var1 * 1000;

  while(gettime() < var3) {
    waittillhostmigrationstarts((var3 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var4 = waittillhostmigrationdone();
      var3 += var4;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var2;
}

function waitlongdurationwithgameendtimeupdate(var0) {
  if(var0 == 0) {
    return;
  }

  var1 = gettime();
  var2 = gettime() + var0 * 1000;

  while(gettime() < var2) {
    waittillhostmigrationstarts((var2 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var2 += 1000;
      setgameendtime(int(var2));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var2 += 1000;
    setgameendtime(int(var2));
    wait 1;
  }

  return gettime() - var1;
}

function matchstarttimer(var0, var1) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  var2 = int(var1);

  if(var2 >= 2) {
    setomnvar("ui_match_start_text", var0);
    matchstarttimer_internal(var2);
    visionsetnaked("", 3);
    return;
  }

  introvisionset();
  visionsetnaked("", 1);
}

function matchstarttimer_internal(var0) {
  waittillframeend();
  introvisionset();
  level endon("match_start_timer_beginning");

  while(var0 > 0 && !level.gameended) {
    foreach(var2 in level.players) {
      var2 setclientomnvar("ui_match_start_countdown", var0);
      var2 setclientomnvar("ui_match_in_progress", 0);
    }

    if(var0 == 0) {
      visionsetnaked("", 0);
    }

    var0--;
    wait 1;
  }

  foreach(var2 in level.players) {
    var2 setclientomnvar("ui_match_start_countdown", 0);
    var2 setclientomnvar("ui_match_in_progress", 1);
  }
}

function introvisionset() {
  if(!isDefined(level.introvisionset)) {
    level.introvisionset = "mpIntro";
  }

  visionsetnaked(level.introvisionset, 0);
}