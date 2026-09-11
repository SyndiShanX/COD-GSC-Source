/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\cranked.gsc
***********************************************/

function registercrankedtimerdvar(var0, var1) {
  scripts\mp\utility\dvars::registerwatchdvarint("crankedBombTimer", var1);
}

function setcrankeddvarfordev() {}

function makeplayercranked(var0) {
  scripts\mp\utility\dialog::leaderdialogonplayer(var0);
  setcrankedplayerbombtimer("kill");
  self.cranked = 1;
  scripts\mp\utility\perk::giveperk("specialty_fastreload");
  scripts\mp\utility\perk::giveperk("specialty_quickdraw");
  scripts\mp\utility\perk::giveperk("specialty_fastoffhand");
  scripts\mp\utility\perk::giveperk("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::giveperk("specialty_marathon");
  scripts\mp\utility\perk::giveperk("specialty_quickswap");
  scripts\mp\utility\perk::giveperk("specialty_stalker");
  scripts\mp\utility\perk::giveperk("specialty_sprintfire");
  self.movespeedscaler = 1.2;
  scripts\mp\weapons::updatemovespeedscale();
}

function oncranked(var0, var1, var2) {
  if(isDefined(var0)) {
    thread cleanupcrankedplayertimer();
  }

  if(isDefined(var1.cranked)) {
    var3 = "kill_cranked";
    var1 thread scripts\mp\rank::scoreeventpopup("time_added");
    thread oncrankedkill(var1);

    if(!istrue(scripts\cp_mp\utility\game_utility::isrealismenabled())) {
      var1 playsoundtoplayer("mp_cranked_splash", var1);
    }
  } else if(scripts\mp\utility\player::isreallyalive(var1)) {
    makeplayercranked(var1, "begin_cranked");
    var1 thread scripts\mp\rank::scoreeventpopup("begin_cranked");

    if(!istrue(scripts\cp_mp\utility\game_utility::isrealismenabled())) {
      var1 playsoundtoplayer("mp_cranked_start_splash", var1);
    }
  }

  if(isDefined(var0) && isDefined(var0.attackers) && !isDefined(level.assists_disabled)) {
    foreach(var5 in var0.attackers) {
      if(var0 == var5) {
        continue;
      }

      if(!isDefined(var5.cranked)) {
        continue;
      }

      thread oncrankedassist(var5);
      var5 thread scripts\mp\rank::scoreeventpopup("assist_cranked");
      var5 thread scripts\mp\rank::scoreeventpopup("time_added");

      if(!istrue(scripts\cp_mp\utility\game_utility::isrealismenabled())) {
        var5 playsoundtoplayer("mp_cranked_splash", var5);
        LOC_00000126:
      }
      LOC_00000126:
    }

    return;
  }
}

function ref_1200c(var0) {
  if(self == var0) {
    return;
  }

  setcrankedplayerbombtimer("hit");
}

function cleanupcrankedplayertimer() {
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self.cranked = undefined;
  self.cranked_end_time = undefined;
  thread waitthenstopcrankedbombtimer();
}

function waitthenstopcrankedbombtimer() {
  waitframe();
  self notify("stop_cranked");
}

function oncrankedkill(var0) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  setcrankedplayerbombtimer("kill");
}

function oncrankedassist(var0) {
  level endon("game_ended");
  self endon("disconnect");
  setcrankedplayerbombtimer("assist");
}

function setcrankedplayerbombtimer(var0) {
  var1 = level.crankedbombtimer;
  var2 = 0;

  if(scripts\mp\utility\game::getgametype() == "conf" || scripts\mp\utility\game::getgametype() == "grind") {
    var2 = 1;
  }

  if(var0 == "hit") {
    var1 = int((self.cranked_end_time - gettime()) / 1000 + 1);

    if(var1 > level.crankedbombtimer) {
      var1 = level.crankedbombtimer;
    }
  } else if(var0 == "assist") {
    if(var2) {
      var1 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.25, level.crankedbombtimer));
    } else {
      var1 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
    }
  } else if(var0 == "friendly_tag") {
    var1 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.25, level.crankedbombtimer));
  } else if(var2) {
    if(isDefined(self.cranked) && self.cranked && isDefined(self.cranked_end_time)) {
      var1 = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
    } else {
      var1 = int(var1 * 0.5);
    }
  } else {
    var1 = level.crankedbombtimer;
  }

  var3 = var1 * 1000 + gettime();
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", var3);
  self.cranked_end_time = var3;
  thread watchcrankedplayerhostmigration();
  thread watchcrankedbombtimer(var1);
  thread watchcrankedendgame();
}

function watchcrankedplayerhostmigration() {
  self notify("watchCrankedHostMigration");
  self endon("watchCrankedHostMigration");
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stop_cranked");
  level waittill("host_migration_begin");
  var0 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var0 > 0) {
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + var0);
    return;
  }

  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time);
}

function watchcrankedendgame() {
  self notify("watchEndGame");
  self endon("watchEndGame");
  self endon("death_or_disconnect");
  self endon("stop_cranked");

  for(;;) {
    if(game["state"] == "postgame" || level.gameended) {
      self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
      break;
    }

    wait 0.1;
  }
}

function watchcrankedbombtimer(var0) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_cranked");
  thread infectparachuteheightoffset(var0);
  var1 = 5;
  var2 = var0 - var1 - 1;

  if(var2 > 0) {
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(var2);
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1);
  }

  while(var1 > 0) {
    self playsoundtoplayer("ui_mp_cranked_timer", self);
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1);
    var1--;
  }

  if(isDefined(self) && scripts\mp\utility\player::isreallyalive(self) && scripts\mp\utility\game::getgametype() != "tdef") {
    self playSound("vest_expl_trans");
    var3 = self.origin + (0, 0, 32);
    playFX(level._effect["cranked_explode"], var3);
    scripts\mp\utility\damage::_suicide();
    self radiusdamage(var3, 256, 200, 100, self, "MOD_EXPLOSIVE", "bomb_site_mp");
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self dodamage(self.maxhealth, var3, self, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
      return;
    }

    return;
  }
}

function infectparachuteheightoffset(var0) {
  self endon("death");
  self notify("refreshCrankedUIProgress");
  self endon("refreshCrankedUIProgress");
  var1 = 0;
  var2 = 0;
  jumpiffalse(var0 != level.crankedbombtimer) LOC_00000032;
  var1 = level.crankedbombtimer - var0;

  while(isalive(self)) {
    var1 += 0.05;
    var3 = clamp(1 - var1 / level.crankedbombtimer, 0, 1);
    self setclientomnvar("ui_cranked_bomb_timer", var3);
    wait 0.05;
  }
}