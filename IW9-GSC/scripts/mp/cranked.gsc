/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\cranked.gsc
***********************************************/

registercrankedtimerdvar(_id_CEFFD5A372961F55, value) {
  scripts\mp\utility\dvars::registerwatchdvarint("crankedBombTimer", value);
}

setcrankeddvarfordev() {}

makeplayercranked(event) {
  scripts\mp\utility\dialog::leaderdialogonplayer(event);
  setcrankedplayerbombtimer("kill");
  self.cranked = 1;
  self.supportcranked = 1;
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

oncranked(victim, attacker, lifeid) {
  if(isDefined(victim))
    victim thread cleanupcrankedplayertimer();

  if(isDefined(attacker.cranked)) {
    event = "stat_9A398B6A291FCD80";
    attacker thread scripts\mp\rank::scoreeventpopup("stat_E7EC5C6F05DDA4D9");
    attacker thread oncrankedkill(event);

    if(!istrue(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()))
      attacker playsoundtoplayer("mp_cranked_splash", attacker);
  } else if(scripts\mp\utility\player::isreallyalive(attacker) && (scripts\mp\utility\game::_id_F698BFD3EFA33302() || scripts\mp\utility\game::_id_E9F3A160BBEFE208(attacker))) {
    attacker makeplayercranked("begin_cranked");
    attacker thread scripts\mp\rank::scoreeventpopup("stat_1527C780FBE48BEF");

    if(!istrue(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()))
      attacker playsoundtoplayer("mp_cranked_start_splash", attacker);
  }

  if(isDefined(victim) && isDefined(victim.attackers) && !isDefined(level.assists_disabled)) {
    foreach(player in victim.attackers) {
      if(!isDefined(scripts\mp\utility\damage::_validateattacker(player))) {
        continue;
      }
      if(player == attacker) {
        continue;
      }
      if(victim == player) {
        continue;
      }
      if(!isDefined(player.cranked)) {
        continue;
      }
      player thread oncrankedassist("assist_cranked");
      player thread scripts\mp\rank::scoreeventpopup("stat_17632F30731E2AFF");
      player thread scripts\mp\rank::scoreeventpopup("stat_E7EC5C6F05DDA4D9");

      if(!istrue(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924()))
        player playsoundtoplayer("mp_cranked_splash", player);
    }
  }
}

oncrankedhit(victim) {
  if(self == victim) {
    return;
  }
  setcrankedplayerbombtimer("hit");
}

cleanupcrankedplayertimer() {
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self.cranked = undefined;
  self.cranked_end_time = undefined;
  self.supportcranked = undefined;
  thread waitthenstopcrankedbombtimer();
}

waitthenstopcrankedbombtimer() {
  waitframe();
  self notify("stop_cranked");
}

oncrankedkill(event) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers))
    waitframe();

  setcrankedplayerbombtimer("kill");
}

oncrankedassist(event) {
  level endon("game_ended");
  self endon("disconnect");
  setcrankedplayerbombtimer("assist");
}

setcrankedplayerbombtimer(type) {
  waittime = level.crankedbombtimer;
  _id_CC4A8BE0EFC3E195 = 0;

  if(scripts\mp\utility\game::getgametype() == "conf" || scripts\mp\utility\game::getgametype() == "grind")
    _id_CC4A8BE0EFC3E195 = 1;

  if(type == "hit") {
    waittime = int((self.cranked_end_time - gettime()) / 1000 + 1);

    if(waittime > level.crankedbombtimer)
      waittime = level.crankedbombtimer;
  } else if(type == "assist") {
    if(_id_CC4A8BE0EFC3E195)
      waittime = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.25, level.crankedbombtimer));
    else
      waittime = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
  } else if(type == "friendly_tag")
    waittime = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.25, level.crankedbombtimer));
  else if(_id_CC4A8BE0EFC3E195) {
    if(isDefined(self.cranked) && self.cranked && isDefined(self.cranked_end_time))
      waittime = int(min((self.cranked_end_time - gettime()) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer));
    else
      waittime = int(waittime * 0.5);
  } else
    waittime = level.crankedbombtimer;

  endtime = waittime * 1000 + gettime();
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", endtime);
  self.cranked_end_time = endtime;
  thread watchcrankedplayerhostmigration();
  thread watchcrankedbombtimer(waittime);
  thread watchcrankedendgame();
}

watchcrankedplayerhostmigration() {
  self notify("watchCrankedHostMigration");
  self endon("watchCrankedHostMigration");
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stop_cranked");
  level waittill("host_migration_begin");
  _id_3B5803E733581858 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(_id_3B5803E733581858 > 0)
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + _id_3B5803E733581858);
  else
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time);
}

watchcrankedendgame() {
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

watchcrankedbombtimer(waittime) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_cranked");
  thread crankedprogressuiupdater(waittime);
  _id_928B160C136333A8 = 5;
  _id_8440421626C8B0CF = waittime - _id_928B160C136333A8 - 1;

  if(_id_8440421626C8B0CF > 0) {
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(_id_8440421626C8B0CF);
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1.0);
  }

  while(_id_928B160C136333A8 > 0) {
    self playsoundtoplayer("ui_mp_cranked_timer", self);
    scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate(1.0);
    _id_928B160C136333A8--;
  }

  if(isDefined(self) && scripts\mp\utility\player::isreallyalive(self) && scripts\mp\utility\game::getgametype() != "tdef") {
    self._id_28E103726B808009 = 1;
    self playSound("vest_expl_trans");
    _id_4DB9D8AF7F807D76 = self.origin + (0, 0, 32);
    playFX(level._effect["cranked_explode"], _id_4DB9D8AF7F807D76);
    scripts\mp\utility\damage::_suicide();
    self radiusdamage(_id_4DB9D8AF7F807D76, 256, 200, 100, self, "MOD_EXPLOSIVE", "bomb_site_mp");
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);

    if(scripts\cp_mp\utility\player_utility::_isalive())
      self dodamage(self.maxhealth, _id_4DB9D8AF7F807D76, self, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");

    self._id_28E103726B808009 = undefined;
  }
}

crankedprogressuiupdater(waittime) {
  self endon("death_or_disconnect");
  self notify("refreshCrankedUIProgress");
  self endon("refreshCrankedUIProgress");
  currenttimelimitdelay = 0;
  _id_038FC7BD1495C4B2 = 0;

  if(waittime != level.crankedbombtimer)
    currenttimelimitdelay = level.crankedbombtimer - waittime;

  while(isalive(self)) {
    currenttimelimitdelay = currenttimelimitdelay + level.framedurationseconds;
    progress = clamp(1.0 - currenttimelimitdelay / level.crankedbombtimer, 0.0, 1.0);
    self setclientomnvar("ui_cranked_bomb_timer", progress);
    waitframe();
  }
}

_id_068A1353068460D1() {
  level endon("game_ended");

  while(!isalive(self))
    waitframe();

  if(isDefined(self.cranked) && self.cranked)
    setcrankedplayerbombtimer("kill");
  else
    oncranked(undefined, self);
}