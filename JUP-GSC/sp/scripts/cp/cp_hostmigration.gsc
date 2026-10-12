/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hostmigration.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#namespace cp_hostmigration;

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

function hostmigrationname(ent) {
  if(!isDefined(ent)) {
    return "<removed_ent>";
  }

  entnum = -1;
  entname = "?";

  if(isDefined(ent.entity_number)) {
    entnum = ent.entity_number;
  }

  if(isPlayer(ent) && isDefined(ent.name)) {
    entname = ent.name;
  }

  if(isPlayer(ent)) {
    return ("player <" + entname + ">");
  }

  if(isagent(ent) && scripts\cp_mp\utility\game_utility::isgameparticipant(ent)) {
    return ("participant agent <" + entnum + ">");
  }

  if(isagent(ent)) {
    return ("non-participant agent <" + entnum + ">");
  }

  return "unknown entity <" + entnum + ">";
}

function hostmigrationtimerthink_internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");
  assertex(isDefined(self.hostmigrationcontrolsfrozen), "Not properly tracking controller frozen for " + hostmigrationname(self));

  while(!scripts\cp_mp\utility\player_utility::_isalive()) {
    self waittill("spawned");
  }

  println("<dev string:x1c>" + hostmigrationname(self) + "<dev string:x3d>" + self.hostmigrationcontrolsfrozen);
  self.hostmigrationcontrolsfrozen = 1;
  freezecontrolswrapper(1);
  level waittill("host_migration_end");
}

function hostmigrationtimerthink() {
  self endon("disconnect");
  assertex(isDefined(self.hostmigrationcontrolsfrozen), "Not properly tracking controller frozen for " + hostmigrationname(self));
  hostmigrationtimerthink_internal();
  assertex(isDefined(self.hostmigrationcontrolsfrozen), "Attempted to unfreeze controls for " + hostmigrationname(self));
  println("<dev string:x62>" + hostmigrationname(self) + "<dev string:x3d>" + self.hostmigrationcontrolsfrozen);

  if(self.hostmigrationcontrolsfrozen) {
    if(gameflag("prematch_done")) {
      freezecontrolswrapper(0);
    }

    self.hostmigrationcontrolsfrozen = undefined;
  }
}

function waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer)) {
    return 0;
  }

  starttime = gettime();
  level waittill("host_migration_end");
  return gettime() - starttime;
}

function waittillhostmigrationstarts(duration) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon("host_migration_begin");
  wait duration;
}

function waitlongdurationwithhostmigrationpause(duration) {
  if(duration == 0) {
    return;
  }

  assert(duration > 0);
  starttime = gettime();
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      timepassed = waittillhostmigrationdone();
      endtime += timepassed;
    }
  }

  waittillhostmigrationdone();
  return gettime() - starttime;
}

function waittill_notify_or_timeout_hostmigration_pause(msg, duration) {
  self endon(msg);

  if(duration == 0) {
    return;
  }

  assert(duration > 0);
  starttime = gettime();
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      timepassed = waittillhostmigrationdone();
      endtime += timepassed;
    }
  }

  waittillhostmigrationdone();
  return gettime() - starttime;
}

function waitlongdurationwithgameendtimeupdate(duration) {
  if(duration == 0) {
    return;
  }

  assert(duration > 0);
  starttime = gettime();
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      endtime += 1000;
      setgameendtime(int(endtime));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    endtime += 1000;
    setgameendtime(int(endtime));
    wait 1;
  }

  return gettime() - starttime;
}

function matchstarttimer(type, duration) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  counttime = int(duration);

  if(counttime >= 2) {
    setomnvar("ui_match_start_text", type);
    matchstarttimer_internal(counttime);
    visionsetnaked("", 3);
    return;
  }

  introvisionset();
  visionsetnaked("", 1);
}

function matchstarttimer_internal(counttime) {
  waittillframeend();
  introvisionset();
  level endon("match_start_timer_beginning");

  while(counttime > 0 && !level.gameended) {
    foreach(p in level.players) {
      p setclientomnvar("ui_match_start_countdown", counttime);
      p setclientomnvar("ui_match_in_progress", 0);
    }

    if(counttime == 0) {
      visionsetnaked("", 0);
    }

    counttime--;
    wait 1;
  }

  foreach(p in level.players) {
    p setclientomnvar("ui_match_start_countdown", 0);
    p setclientomnvar("ui_match_in_progress", 1);
  }
}

function introvisionset() {
  if(!isDefined(level.introvisionset)) {
    level.introvisionset = "mpIntro";
  }

  visionsetnaked(level.introvisionset, 0);
}