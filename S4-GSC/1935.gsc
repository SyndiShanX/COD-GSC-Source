/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1935.gsc
*************************************************/

init() {
  if(getdvarint("#x3ae83453ae71ec805", 0)) {
    level._id_5897 = "hud_icon_head_equipment_friendly_white";
  } else {
    level._id_5897 = "hud_icon_head_equipment_friendly";
  }

  level._id_5896 = "hud_icon_head_equipment_enemy";
  level._id_0F44 = [];
}

_id_D59B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  level endon("game_ended");

  if(isDefined(var_6)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6);
  }

  if(!isDefined(self)) {
    return;
  }
  var_11 = _id_D592(undefined, var_9);
  _func_0355(var_11, var_1);

  if(!isDefined(var_2)) {
    var_2 = 30;
  }

  _func_035D(var_11, var_2);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  _func_035C(var_11, var_3);

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  _func_035A(var_11, var_4);

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  _func_0359(var_11, var_5);

  if(_func_0107(var_0)) {
    foreach(var_13 in var_0) {
      if(isPlayer(var_13)) {
        _func_035E(var_11, var_13);
        continue;
      }

      if(isDefined(var_13) && _id_8A91(var_13)) {
        _func_035F(var_11, var_13);
      }
    }
  } else if(isPlayer(var_0))
    _func_035E(var_11, var_0);
  else if(isDefined(var_0) && _id_8A91(var_0)) {
    _func_035F(var_11, var_0);
  }

  if(!istrue(var_7)) {
    thread _id_D59C(var_11);
  }

  if(istrue(var_8)) {
    _func_035B(var_11, 1);
  }

  if(istrue(var_10)) {
    _func_042A(var_11, 1);
  }

  return var_11;
}

_id_D598(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  level endon("game_ended");

  if(isDefined(var_8)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_8);
  }

  if(!isDefined(self)) {
    return;
  }
  var_13 = _id_D592(undefined, var_11);

  if(isDefined(var_1)) {
    _func_0356(var_13, var_1);
  }

  if(isDefined(var_2)) {
    _func_0358(var_13, var_2);
  }

  if(isDefined(var_3)) {
    _func_0357(var_13, var_3);
  }

  if(!isPlayer(self)) {
    if(!isDefined(self.owner) && !isDefined(self.team)) {
      _id_D593(var_13);
      return;
    }

    if(isDefined(self.owner)) {
      _func_0365(var_13, self.owner);
    }

    if(level.teambased && isDefined(self.team)) {
      _func_0364(var_13, self.team);
    }
  }

  if(!isDefined(var_4)) {
    var_4 = 30;
  }

  _func_035D(var_13, var_4);

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  _func_035C(var_13, var_5);

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  _func_035A(var_13, var_6);

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  _func_0359(var_13, var_7);

  if(_func_0107(var_0)) {
    foreach(var_15 in var_0) {
      if(isPlayer(var_15)) {
        _func_035E(var_13, var_15);
        continue;
      }

      if(isDefined(var_15) && _id_8A91(var_15)) {
        _func_035F(var_13, var_15);
      }
    }
  } else if(isPlayer(var_0))
    _func_035E(var_13, var_0);
  else if(isDefined(var_0) && _id_8A91(var_0)) {
    _func_035F(var_13, var_0);
  }

  if(!istrue(var_9)) {
    thread _id_D59C(var_13);
  }

  if(istrue(var_10)) {
    _func_035B(var_13, 1);
  }

  if(istrue(var_12)) {
    _func_042A(var_13, 1);
  }

  return var_13;
}

_id_D594(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    return;
  }
  level endon("game_ended");

  if(isDefined(var_5)) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_5);
  }

  if(!isDefined(self)) {
    return;
  }
  var_10 = _id_D592(undefined, var_8);
  var_11 = spawnStruct();
  var_11._id_7C3B = var_10;
  var_11._id_5516 = self.owner;
  var_11._id_DCF5 = var_0;
  var_11._id_ADA7 = var_7;

  if(!isDefined(var_1)) {
    var_1 = 30;
  }

  _func_035D(var_11._id_7C3B, var_1);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  _func_035C(var_11._id_7C3B, var_2);

  if(!isDefined(var_3)) {
    var_3 = 768;
  }

  _func_035A(var_11._id_7C3B, var_3);

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  _func_0359(var_11._id_7C3B, var_4);

  if(!istrue(var_6)) {
    thread _id_D59C(var_11._id_7C3B);
  }

  if(istrue(var_9)) {
    _func_042A(var_10, 1);
  }

  _id_0DAB(var_11);
  thread _id_D59F(var_11);
  var_12 = getdvarint("#x361f0d268e8c5c376", 1);

  if(var_12) {
    thread _id_D5A0(var_11);
  }

  return var_11._id_7C3B;
}

_id_0DAB(var_0) {
  self notify("_updateIconOwner()");

  if(istrue(var_0._id_DCF5)) {
    _func_0356(var_0._id_7C3B, level._id_5897);
    _func_0358(var_0._id_7C3B, level._id_5896);
    _func_0357(var_0._id_7C3B, level._id_5896);

    if(!isPlayer(self)) {
      if(!isDefined(self.owner) && !isDefined(self.team)) {
        _id_D593(var_0._id_7C3B);
        return;
      }

      if(isDefined(self.owner)) {
        _func_0365(var_0._id_7C3B, self.owner);
      }

      if(level.teambased && isDefined(self.team)) {
        _func_0364(var_0._id_7C3B, self.team);
      }
    }
  } else {
    var_1 = level._id_5897;
    _func_0355(var_0._id_7C3B, var_1);

    if(level.teambased && isDefined(self.team)) {
      _func_0364(var_0._id_7C3B, self.team);
      _func_0480(var_0._id_7C3B, 1);
    }
  }

  foreach(var_3 in level.players) {
    _func_0360(var_0._id_7C3B, var_3);
  }

  if(istrue(var_0._id_DCF5)) {
    foreach(var_3 in level.players) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(istrue(var_0._id_ADA7) && var_3 == self.owner) {
        continue;
      }
      _func_035E(var_0._id_7C3B, var_3);
    }

    thread _id_D59D(var_0._id_7C3B);
  } else {
    if(!isDefined(self.owner)) {
      _id_D593(var_0._id_7C3B);
      return;
    }

    foreach(var_3 in level.players) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(level.teambased && var_3.team != self.owner.team) {
        continue;
      }
      if(!level.teambased && var_3 != self.owner) {
        continue;
      }
      if(istrue(var_0._id_ADA7) && var_3 == self.owner) {
        continue;
      }
      _func_035E(var_0._id_7C3B, var_3);
    }
  }
}

_id_D59D(var_0) {
  self endon("death");
  self endon("_updateIconOwner()");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_1);
    thread _id_D59E(var_0, var_1);
  }
}

_id_D59E(var_0, var_1) {
  self endon("death");
  self endon("_updateIconOwner()");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    var_1 waittill("spawned_player");
    _func_035E(var_0, var_1);
  }
}

_id_D59F(var_0) {
  self endon("death");

  if(isPlayer(self)) {
    self endon("disconnect");
  }

  level endon("game_ended");

  for(;;) {
    if(var_0._id_5516 != self.owner) {
      var_0._id_5516 = self.owner;
      _id_0DAB(var_0);
    }

    wait 0.1;
  }
}

_id_D5A0(var_0) {
  level endon("game_ended");
  self endon("headicon_deleted");
  self endon("death");

  for(;;) {
    level waittill("add_to_team", var_1);
    _func_0360(var_0._id_7C3B, var_1);

    if(istrue(var_0._id_DCF5)) {
      _func_035E(var_0._id_7C3B, var_1);
      continue;
    }

    if(!isDefined(self.owner)) {
      _id_D593(var_0._id_7C3B);
      return;
    }

    if(var_1.team != self.owner.team) {
      continue;
    }
    _func_035E(var_0._id_7C3B, var_1);
  }
}

_id_D59C(var_0) {
  level endon("game_ended");
  self endon("headicon_deleted");
  self waittill("death_or_disconnect");
  _id_D593(var_0);
}

_id_8A91(var_0) {
  if(var_0 == "spectator" || var_0 == "follower") {
    return 1;
  }

  foreach(var_2 in level._id_EF89) {
    if(var_0 == var_2) {
      return 1;
    }
  }

  return 0;
}

_id_D592(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!_id_D591()) {
    _id_D59A(var_0);
  }

  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = _func_0429(var_1);
  } else {
    var_2 = _func_0353(self);
  }

  if(!isDefined(var_2) || var_2 < 0) {
    return;
  }
  var_4 = spawnStruct();
  var_4._id_7C3B = var_2;
  var_4._id_5512 = self;
  var_4._id_BD2C = var_0;
  var_4._id_F209 = gettime();
  level._id_0F44[var_4._id_7C3B] = var_4;
  return var_4._id_7C3B;
}

_id_D593(var_0) {
  var_1 = _id_D597(var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_1._id_5512)) {
      var_1._id_5512 notify("headicon_deleted");
    }

    _func_0354(var_1._id_7C3B);
    level._id_0F44[var_1._id_7C3B] = undefined;
  }
}

_id_D591() {
  return level._id_0F44.size < 1023;
}

_id_D597(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(level._id_0F44[var_0])) {
    return;
  }
  return level._id_0F44[var_0];
}

_id_D59A(var_0) {
  var_1 = _id_D595(var_0);
  var_2 = _id_D596(var_1);
  _id_D593(var_2);
}

_id_D595(var_0) {
  var_1 = var_0;

  foreach(var_3 in level._id_0F44) {
    if(var_1 > var_3._id_BD2C) {
      var_1 = var_3._id_BD2C;
    }
  }

  return var_1;
}

_id_D596(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level._id_0F44) {
    if(!isDefined(var_1) && !isDefined(var_2) || var_1._id_F209 > var_4._id_F209) {
      var_1 = var_4;
      var_2 = var_4._id_7C3B;
    }
  }

  return var_2;
}

_id_D590(var_0, var_1) {
  var_2 = _id_D597(var_0);

  if(isDefined(var_2)) {
    _func_035E(var_0, var_1);
  }
}

_id_D599(var_0, var_1) {
  var_2 = _id_D597(var_0);

  if(isDefined(var_2)) {
    _func_0360(var_0, var_1);
  }
}