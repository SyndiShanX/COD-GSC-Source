/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1985.gsc
*************************************************/

_id_C24D(var_0, var_1) {
  scripts\mp\utility\dvars::_id_C2CB("crankedBombTimer", var_1);
}

_id_D4ED() {}

_id_9A01(var_0) {
  _id_0A8D::_id_9137(var_0);
  _id_D4EE("kill");
  self._id_3E59 = 1;
  scripts\mp\utility\perk::_id_6FC2("specialty_fastreload");
  scripts\mp\utility\perk::_id_6FC2("specialty_quickdraw");
  scripts\mp\utility\perk::_id_6FC2("specialty_fastoffhand");
  scripts\mp\utility\perk::_id_6FC2("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::_id_6FC2("specialty_marathon");
  scripts\mp\utility\perk::_id_6FC2("specialty_quickswap");
  scripts\mp\utility\perk::_id_6FC2("specialty_stalker");
  scripts\mp\utility\perk::_id_6FC2("specialty_sprintfire");
  self._id_A25F = 1.2;
  scripts\mp\weapons::_id_FCCC();
}

_id_AA91(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 thread _id_387A();
  }

  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 0);

  if(isDefined(var_1._id_3E59)) {
    var_3 = "kill_cranked";
    var_1 thread scripts\mp\rank::_id_CC00("kill_cranked");
    var_1 thread scripts\mp\rank::_id_CC00("time_added");
    var_1 thread _id_AA94(var_3);

    if(!istrue(scripts\cp_mp\utility\game_utility::_id_89EC())) {
      var_1 playsoundtoplayer("mp_cranked_splash", var_1);
    }
  } else if(scripts\mp\utility\player::isreallyalive(var_1)) {
    var_1 _id_9A01("begin_cranked");
    var_1 thread scripts\mp\rank::_id_CC00("begin_cranked");

    if(!istrue(scripts\cp_mp\utility\game_utility::_id_89EC())) {
      var_1 playsoundtoplayer("mp_cranked_start_splash", var_1);
    }
  }

  if(isDefined(var_0) && isDefined(var_0._id_1DDE) && !isDefined(level._id_1D2C)) {
    foreach(var_5 in var_0._id_1DDE) {
      if(!isDefined(_id_0A8B::_id_0DB6(var_5))) {
        continue;
      }
      if(var_5 == var_1) {
        continue;
      }
      if(var_0 == var_5) {
        continue;
      }
      if(!isDefined(var_5._id_3E59)) {
        continue;
      }
      var_5 thread _id_AA92("assist_cranked");
      var_5 thread scripts\mp\rank::_id_CC00("assist_cranked");
      var_5 thread scripts\mp\rank::_id_CC00("time_added");

      if(!istrue(scripts\cp_mp\utility\game_utility::_id_89EC())) {
        var_5 playsoundtoplayer("mp_cranked_splash", var_5);
      }
    }
  }
}

_id_AA93(var_0) {
  if(self == var_0) {
    return;
  }
  _id_D4EE("hit");
}

_id_387A() {
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 0);
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self._id_3E59 = undefined;
  self._id_3E5A = undefined;
  thread _id_10873();
}

_id_10873() {
  waitframe();
  self notify("stop_cranked");
}

_id_AA94(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  _id_D4EE("kill");
}

_id_AA92(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  _id_D4EE("assist");
}

_id_D4EE(var_0) {
  var_1 = level._id_3E5B;
  var_2 = 0;

  if(scripts\mp\utility\game::getgametype() == "conf" || scripts\mp\utility\game::getgametype() == "grind") {
    var_2 = 1;
  }

  if(var_0 == "hit") {
    var_1 = int((self._id_3E5A - gettime()) / 1000 + 1);

    if(var_1 > level._id_3E5B) {
      var_1 = level._id_3E5B;
    }
  } else if(var_0 == "assist") {
    if(var_2) {
      var_1 = int(min((self._id_3E5A - gettime()) / 1000 + level._id_3E5B * 0.25, level._id_3E5B));
    } else {
      var_1 = int(min((self._id_3E5A - gettime()) / 1000 + level._id_3E5B * 0.5, level._id_3E5B));
    }
  } else if(var_0 == "friendly_tag")
    var_1 = int(min((self._id_3E5A - gettime()) / 1000 + level._id_3E5B * 0.25, level._id_3E5B));
  else if(var_2) {
    if(isDefined(self._id_3E59) && self._id_3E59 && isDefined(self._id_3E5A)) {
      var_1 = int(min((self._id_3E5A - gettime()) / 1000 + level._id_3E5B * 0.5, level._id_3E5B));
    } else {
      var_1 = int(var_1 * 0.5);
    }
  } else
    var_1 = level._id_3E5B;

  var_3 = var_1 * 1000 + gettime();
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", var_3);
  self._id_3E5A = var_3;
  thread _id_10AB7();
  thread _id_10AB4(var_1);
  thread _id_10AB5();
}

_id_10AB7() {
  self notify("watchCrankedHostMigration");
  self endon("watchCrankedHostMigration");
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stop_cranked");
  level waittill("host_migration_begin");
  var_0 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(self._id_3E5A + var_0 < 5) {
    self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);
  }

  if(var_0 > 0) {
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self._id_3E5A + var_0);
  } else {
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self._id_3E5A);
  }
}

_id_10AB5() {
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

_id_10AB4(var_0) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("disconnect");
  level endon("game_ended");
  self endon("stop_cranked");
  var_1 = 5;
  var_2 = var_0 - var_1 - 1;

  if(var_2 > 0) {
    scripts\mp\hostmigration::_id_1084E(var_2);
    scripts\mp\hostmigration::_id_1084E(1.0);
  }

  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);

  while(var_1 > 0) {
    self playsoundtoplayer("ui_mp_cranked_timer", self);
    scripts\mp\hostmigration::_id_1084E(1.0);
    var_1--;
  }

  if(isDefined(self) && scripts\mp\utility\player::isreallyalive(self) && scripts\mp\utility\game::getgametype() != "tdef") {
    self playSound("vest_expl_trans");
    var_3 = self.origin + (0, 0, 32);
    playFX(level._effect["cranked_explode"], var_3);
    _id_0A8B::_id_0D8A();
    self radiusdamage(var_3, 256, 200, 100, self, "MOD_EXPLOSIVE", "bomb_site_mp");
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);

    if(scripts\cp_mp\utility\player_utility::_isalive()) {
      self dodamage(self.maxhealth, var_3, self, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    }
  }
}