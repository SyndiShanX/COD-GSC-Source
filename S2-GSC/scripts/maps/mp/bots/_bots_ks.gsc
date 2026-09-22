/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_ks.gsc
*********************************************/

_id_1A4E() {
  if(!maps\mp\_utility::_id_0F5C()) {
    return;
  }
  var_0 = gettime();

  if(!isDefined(level._id_5A59)) {
    _id_1AB3("uav", ::_id_1A50);
    _id_1AB3("counter_uav", ::_id_1A50);
    _id_1AB3("flak_gun", ::_id_1A50);
    _id_1AB3("fritzx", ::_id_1A50);
    _id_1AB3("airstrike", ::_id_1A50);
    _id_1AB3("plane_gunner", ::_id_1A50);
    _id_1AB3("paratroopers", ::_id_1A50);
    _id_1AB3("carepackage", ::_id_1A42);
    _id_1AB3("emergency_carepackage", ::_id_1A42);
    _id_1AB3("molotovs", ::bot_killstreak_weapon);
    _id_1AB3("flamethrower", ::bot_killstreak_weapon);
    _id_1AB3("firebomb", ::_id_1A3D, ::_id_1961);
    _id_1AB3("fighter_strike", ::_id_1A3D, ::_id_1961);
    _id_1AB3("mortar_strike", ::_id_1A3D, ::_id_1961);
    _id_1AB3("missile_strike", ::_id_1A3D, ::_id_1961);
    _id_1AB3("v2_rocket", ::_id_1A3D, ::_id_1961);
  }

  thread maps\mp\bots\_bots_ks_remote_vehicle::_id_7C63();
}

_id_1AB3(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_5A59)) {
    level._id_5A59 = [];
  }

  level._id_5A59[var_0] = var_1;

  if(!isDefined(level._id_5A58)) {
    level._id_5A58 = [];
  }

  level._id_5A58[var_0] = var_2;

  if(!isDefined(level._id_5A5A)) {
    level._id_5A5A = [];
  }

  level._id_5A5A[var_0] = var_3;

  if(!isDefined(level._id_1AF3)) {
    level._id_1AF3 = [];
  }

  level._id_1AF3[level._id_1AF3.size] = var_0;
}

_id_1A38(var_0, var_1) {
  if(_id_1A49(var_0, "bots", undefined)) {
    return 1;
  } else if(var_1) {}

  return 0;
}

_id_1A49(var_0, var_1, var_2) {
  if(!_id_1A4A(var_0, var_1)) {
    return 0;
  }

  return 1;
}

_id_1A4A(var_0, var_1) {
  if(var_1 == "humans") {
    return isDefined(level._id_5A61) && isDefined(level._id_5A61[var_0]) && maps\mp\_utility::_id_453F(var_0) != -1;
  } else if(var_1 == "bots") {
    return isDefined(level._id_5A59) && isDefined(level._id_5A59[var_0]);
  }
}

_id_1B01() {
  self notify("bot_think_killstreak");
  self endon("bot_think_killstreak");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self._id_1B2F = undefined;

  while(!isDefined(level._id_5A59)) {
    waitframe();
  }

  for(;;) {
    if(maps\mp\bots\_bots_util::_id_1937()) {
      var_0 = self.pers["killstreaks"];

      if(isDefined(var_0)) {
        foreach(var_2 in var_0) {
          if(isDefined(var_2._id_944C) && isDefined(self._id_1A51) && isDefined(self._id_1A51[var_2._id_944C]) && gettime() < self._id_1A51[var_2._id_944C]) {
            continue;
          }
          if(var_2._id_13AF) {
            var_3 = var_2._id_944C;
            var_2._id_01D0 = maps\mp\_utility::_id_454A(var_2._id_944C, self.team, maps\mp\_utility::_hasperk("specialty_improvedstreaks"));
            var_4 = level._id_5A58[var_3];

            if(isDefined(var_4) && !self[[var_4]](var_2)) {
              continue;
            }
            if(!maps\mp\_utility::_id_A27A(var_2._id_944C, 1)) {
              continue;
            }
            var_5 = level._id_5A59[var_3];

            if(isDefined(var_5)) {
              var_6 = self[[var_5]](var_2, var_0, var_4, level._id_5A5A[var_2._id_944C]);

              if(!isDefined(var_6) || var_6 == 0) {
                if(!isDefined(self._id_1A51)) {
                  self._id_1A51 = [];
                }

                self._id_1A51[var_2._id_944C] = gettime() + 5000;
              }
            } else {
              var_2._id_13AF = 0;
              _id_051E::_id_A129(0);
            }

            break;
          }
        }
      }
    }

    wait(_randomfloatrange(2.0, 4.0));
  }
}

_id_1A4B() {}

_id_1A3E(var_0) {
  return 0;
}

_id_1A3C(var_0) {
  return var_0._id_01D0 == "killstreak_uav_mp";
}

_id_A3EB() {
  return maps\mp\_utility::_id_2924() >= maps\mp\_utility::_id_60A6() || level._id_3A62 + 1 >= maps\mp\_utility::_id_60A6();
}

_id_1963(var_0) {
  if(isDefined(level.empplayer)) {
    return 0;
  }

  var_1 = level._id_6C63[self.team];

  if(isDefined(level.teamemped) && isDefined(level.teamemped[var_1]) && level.teamemped[var_1]) {
    return 0;
  }

  return 1;
}

_id_1961(var_0) {
  if(isDefined(level._id_0B93)) {
    return 0;
  }

  return 1;
}

_id_1A50(var_0, var_1, var_2, var_3) {
  wait(_randomintrange(3, 5));

  if(!maps\mp\bots\_bots_util::_id_1937()) {
    return 1;
  }

  if(isDefined(var_2) && !self[[var_2]](var_0)) {
    return 0;
  }

  _id_1AF4(var_0, var_1, var_0._id_01D0);
  return 1;
}

bot_killstreak_weapon(var_0, var_1, var_2, var_3) {
  wait(_randomintrange(3, 5));

  if(!maps\mp\bots\_bots_util::_id_1937()) {
    return 1;
  }

  if(isDefined(var_2) && !self[[var_2]](var_0)) {
    return 0;
  }

  _id_1AF4(var_0, var_1, var_0._id_01D0);

  while(self getcurrentweapon() != var_0._id_01D0) {
    waitframe();
  }

  while(self getammocount(var_0._id_01D0) > 0 && self getcurrentweapon() == var_0._id_01D0) {
    waitframe();
  }

  if(self getcurrentweapon() == var_0._id_01D0) {
    self switchtoweapon("none");
  }

  return 1;
}

_id_1A40(var_0, var_1, var_2, var_3) {
  _id_1A3F(var_0, var_1, var_2, var_3, "anywhere");
}

_id_1A42(var_0, var_1, var_2, var_3) {
  _id_1A3F(var_0, var_1, var_2, var_3, "outside");
}

_id_1A41(var_0, var_1, var_2, var_3) {
  _id_1A3F(var_0, var_1, var_2, var_3, "hidden");
}

_id_1A3F(var_0, var_1, var_2, var_3, var_4) {
  wait(_randomintrange(2, 4));

  if(!isDefined(var_4)) {
    var_4 = "anywhere";
  }

  if(!maps\mp\bots\_bots_util::_id_1937()) {
    return 1;
  }

  if(isDefined(var_2) && !self[[var_2]](var_0)) {
    return 0;
  }

  var_5 = self getweaponammoclip(var_0._id_01D0) + self getweaponammostock(var_0._id_01D0);

  if(var_5 == 0) {
    foreach(var_7 in var_1) {
      if(isDefined(var_7._id_944C) && var_7._id_944C == var_0._id_944C) {
        var_7._id_13AF = 0;
      }
    }

    _id_051E::_id_A129(0);
    return 1;
  }

  var_9 = undefined;

  if(var_4 == "outside") {
    var_10 = [];
    var_11 = maps\mp\bots\_bots_util::_id_19FA(0, 750, 0.6, 1);

    foreach(var_13 in var_11) {
      if(_nodeexposedtosky(var_13)) {
        var_10 = common_scripts\utility::_id_0F6F(var_10, var_13);
      }
    }

    if(var_11.size > 5 && var_10.size > var_11.size * 0.6) {
      var_15 = common_scripts\utility::_id_40B0(self.origin, var_10, undefined, undefined, undefined, 150);

      if(var_15.size > 0) {
        var_9 = common_scripts\utility::random(var_15);
      } else {
        var_9 = common_scripts\utility::random(var_10);
      }
    }
  } else if(var_4 == "hidden") {
    var_16 = _getnodesinradius(self.origin, 256, 0, 40);
    var_17 = self getnearestnode();

    if(isDefined(var_17)) {
      var_18 = [];

      foreach(var_13 in var_16) {
        if(_nodesvisible(var_17, var_13, 1)) {
          var_18 = common_scripts\utility::_id_0F6F(var_18, var_13);
        }
      }

      var_9 = self botnodepick(var_18, 1, "node_hide");
    }
  }

  if(isDefined(var_9) || var_4 == "anywhere") {
    self botsetflag("disable_movement", 1);

    if(isDefined(var_9)) {
      self botlookatpoint(var_9.origin, 2.45, "script_forced");
    }

    _id_1AF4(var_0, var_1, var_0._id_01D0);
    wait 2.0;
    self botpressbutton("attack");
    wait 1.5;
    self switchtoweapon("none");
    self botsetflag("disable_movement", 0);
  }

  return 1;
}

_id_1AF4(var_0, var_1, var_2) {
  _id_1A87(var_0, var_1);
  waitframe();
  self switchtoweapon(var_2);
}

_id_1A87(var_0, var_1) {
  if(isDefined(var_0._id_5703) && var_0._id_5703) {
    self notify("streakUsed1");
  } else {
    for(var_2 = 0; var_2 < 3; var_2++) {
      if(isDefined(var_1[var_2]._id_944C)) {
        if(var_1[var_2]._id_944C == var_0._id_944C) {
          break;
        }
      }
    }

    self notify("streakUsed" + (var_2 + 1));
  }
}

_id_1A3D(var_0, var_1, var_2, var_3) {
  wait(_randomintrange(3, 5));

  if(!maps\mp\bots\_bots_util::_id_1937()) {
    return;
  }
  var_4 = _getzonenearest(self.origin);

  if(!isDefined(var_4)) {
    return;
  }
  self botsetflag("disable_movement", 1);
  _id_1AF4(var_0, var_1, var_0._id_01D0);
  wait 2;

  if(!isDefined(self._id_83AF)) {
    return;
  }
  var_5 = level._id_AC9C;
  var_6 = -1;
  var_7 = 0;
  var_8 = [];
  var_9 = _randomfloat(100) > 50;

  for(var_10 = 0; var_10 < var_5; var_10++) {
    if(var_9) {
      var_11 = var_5 - 1 - var_10;
    } else {
      var_11 = var_10;
    }

    if(var_11 != var_4 && _botzonegetindoorpercent(var_11) < 0.25) {
      var_12 = _botzonegetcount(var_11, self.team, "enemy_predict");

      if(var_12 > var_7) {
        var_6 = var_11;
        var_7 = var_12;
      }

      var_8 = common_scripts\utility::_id_0F6F(var_8, var_11);
    }
  }

  if(var_6 >= 0) {
    var_13 = _getzoneorigin(var_6);
  } else if(var_8.size > 0) {
    var_13 = _getzoneorigin(common_scripts\utility::random(var_8));
  } else {
    var_13 = _getzoneorigin(randomint(level._id_AC9C));
  }

  var_14 = 1;

  while(var_14) {
    var_15 = (_randomfloatrange(-500, 500), _randomfloatrange(-500, 500), 0);
    self notify("confirm_location", var_13 + var_15, _randomintrange(0, 360), (0.5, 0.5, 0), 0);
    var_16 = common_scripts\utility::waittill_any_return("location_selection_complete", "airstrikeShowBlockedHUD", "single_location_selection_complete");

    if(var_16 == "location_selection_complete") {
      var_14 = 0;
      continue;
    }

    wait 0.5;
  }

  wait 1.0;
  self botsetflag("disable_movement", 0);
}

_id_1B05() {
  self notify("bot_think_watch_aerial_killstreak");
  self endon("bot_think_watch_aerial_killstreak");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(level._id_5B27)) {
    level._id_5B27 = -10000;
  }

  if(!isDefined(level._id_5A5B)) {
    level._id_5A5B["allies"] = [];
    level._id_5A5B["axis"] = [];
  }

  if(!isDefined(level._id_0A2C)) {
    level._id_0A2C["allies"] = 0;
    level._id_0A2C["axis"] = 0;
  }

  var_0 = 0;
  var_1 = _randomfloatrange(0.05, 4.0);

  for(;;) {
    wait(var_1);
    var_1 = _randomfloatrange(0.05, 4.0);

    if(maps\mp\bots\_bots_util::_id_1A36()) {
      continue;
    }
    if(self botgetdifficultysetting("strategyLevel") == 0) {
      continue;
    }
    var_2 = 0;

    if(_id_3741(self.team)) {
      _id_9E0D("missile_strike", ::_id_3741);
      var_2 = 1;
    }

    if(_id_36FB(self.team)) {
      _id_9E0D("missile_strike", ::_id_36FB);
      var_2 = 1;
    }

    if(!var_0 && var_2) {
      var_0 = 1;
      self botsetflag("hide_indoors", 1);
    }

    if(var_0 && !var_2) {
      var_0 = 0;
      self botsetflag("hide_indoors", 0);
    }

    level._id_0A2C[self.team] = var_2;
  }
}

_id_1A31(var_0) {
  if(!isDefined(self._id_0A2D)) {
    return 0;
  }

  return common_scripts\utility::_id_0F79(self._id_0A2D, var_0);
}

_id_62DF(var_0) {
  if(!isDefined(self._id_0A2D)) {
    self._id_0A2D = [];
  }

  self._id_0A2D[self._id_0A2D.size] = var_0;
  var_1 = vectorNormalize((var_0.origin - self.origin) * (1, 1, 0));

  while(isalive(var_0)) {
    var_2 = vectorNormalize((var_0.origin - self.origin) * (1, 1, 0));
    var_3 = vectordot(var_1, var_2);

    if(var_3 <= 0) {
      var_1 = var_2;
      self notify("defend_force_node_recalculation");
    }

    waitframe();
  }

  self._id_0A2D = common_scripts\utility::_id_0F93(self._id_0A2D, var_0);
}

_id_9E0D(var_0, var_1) {
  if(!isDefined(level._id_5A5B[self.team][var_0])) {
    level._id_5A5B[self.team][var_0] = 0;
  }

  if(!level._id_5A5B[self.team][var_0]) {
    level._id_5A5B[self.team][var_0] = 1;
    level thread _id_6308(self.team, var_0, var_1);
  }
}

_id_6308(var_0, var_1, var_2) {
  var_3 = 0.5;

  while([[var_2]](var_0)) {
    if(gettime() > level._id_5B27 + 4000) {
      _badplace_global("", 5.0, var_0, "only_sky");
      level._id_5B27 = gettime();
    }

    wait(var_3);
  }

  level._id_5A5B[var_0][var_1] = 0;
}

_id_3741(var_0) {
  if(maps\mp\_utility::_id_579B()) {
    return 0;
  }

  if(isDefined(level._id_7C66) && isDefined(level._id_7EBB)) {
    foreach(var_2 in level._id_7EBB) {
      if(var_2.type == "remote" && var_2.team != var_0) {
        return 1;
      }
    }
  }

  return 0;
}

_id_36FB(var_0) {
  if(maps\mp\_utility::_id_579B()) {
    return 0;
  }

  if(isDefined(level.makeglobalusable)) {
    foreach(var_2 in level.makeglobalusable) {
      if(maps\mp\_utility::_id_57E5(var_2._id_944C, "airstrike") && var_2.team != var_0) {
        return 1;
      }
    }
  }

  return 0;
}