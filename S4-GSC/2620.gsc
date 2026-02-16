/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2620.gsc
*************************************************/

init() {
  if(!isDefined(level._id_298E)) {
    level._id_298E = [];
  }
}

_id_24A8(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread _id_387C(var_3);
  thread _id_10AC4(var_0, var_2, var_1, var_3, var_4, var_5, var_6, var_7);
  return 1;
}

_id_10AC4(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_4)) {
    return;
  }
  if(!scripts\mp\utility\player::isreallyalive(self)) {
    var_3 delete();
  }

  var_3 _meth_821E(1);
  self notify("deployable_deployed");
  var_3.owner = self;
  var_3._id_04FE = var_4;
  self._id_9B4D = var_3;

  if(_id_8880(var_1)) {
    self thread[[level._id_298E[var_1]._id_7185]](var_3);
    return;
  }

  var_3 playsoundtoplayer(level._id_298E[var_1]._id_47E9, self);
  var_3 thread _id_9B51(var_0, var_2, var_1, ::_id_297D, var_5, var_6, var_7);
}

_id_387C(var_0) {
  var_0 endon("death");
  var_0 endon("late_missile_stuck");
  var_0 thread scripts\mp\utility\script::_id_A695("missile_stuck", "late_missile_stuck");
  self waittill("disconnect");
  var_0 delete();
}

_id_AD34(var_0) {
  self._id_87FB = 1;
  self notify("death");
}

_id_9B51(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self notify("markerActivate");
  self endon("markerActivate");
  self waittill("missile_stuck");
  var_7 = self.owner;
  var_8 = self.origin;

  if(!isDefined(var_7)) {
    return;
  }
  var_9 = _id_3F9C(var_2, var_8, var_7);
  var_10 = spawnStruct();
  var_10._id_950E = self _meth_8151();

  if(isDefined(var_10._id_950E) && isDefined(var_10._id_950E.model) && var_10._id_950E.model != "") {
    var_9.origin = var_10._id_950E.origin;
    var_11 = var_10._id_950E _meth_8151();

    if(isDefined(var_11)) {
      var_10._id_950E = var_11;
    } else {
      var_10._id_950E = undefined;
    }
  }

  var_10._id_43F7 = ::_id_AD34;
  var_9 thread scripts\mp\movers::_id_7403(var_10);
  var_9._id_A283 = var_10._id_950E;
  var_9 setotherent(var_7);
  waitframe();
  var_9 thread[[var_3]](var_4, var_5, var_6);

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_0);
  }

  self delete();

  if(isDefined(var_9) && var_9 scripts\mp\utility\entity::_id_F38F()) {
    self._id_87FB = 1;
    var_9 notify("death");
  }
}

_id_47E5(var_0) {
  if(var_0 == "mp_satcom") {
    return 1;
  } else if(issubstr(var_0, "paris_catacombs_iron")) {
    return 1;
  } else if(issubstr(var_0, "mp_warhawk_iron_gate")) {
    return 1;
  }

  return 0;
}

_id_88A5() {
  var_0 = self getcurrentweapon();

  if(isDefined(var_0)) {
    foreach(var_2 in level._id_298E) {
      if(getcompleteweaponname(var_0) == var_2.weaponinfo) {
        return 1;
      }
    }
  }

  return 0;
}

_id_3F9C(var_0, var_1, var_2) {
  var_3 = level._id_298E[var_0];
  var_4 = spawn("script_model", var_1 - (0, 0, 1));
  var_4 setModel(var_3.modelbase);
  var_4.health = 999999;
  var_4.maxhealth = var_3.maxhealth;
  var_4.angles = var_2.angles;
  var_4._id_2991 = var_0;
  var_4.owner = var_2;
  var_4.team = var_2.team;
  var_4._id_7C8C = var_3._id_7C8C;

  if(isDefined(var_3._id_4EC6)) {
    var_4._id_4EC6 = var_3._id_4EC6;
  }

  if(isDefined(var_3._id_9CB7)) {
    var_4._id_FED3 = var_3._id_9CB7;
  }

  var_4 _id_297F();
  var_4 thread _id_2976();
  var_4 _id_1095();
  return var_4;
}

_id_297D(var_0, var_1, var_2) {
  self setcursorhint("HINT_NOICON");
  var_3 = level._id_298E[self._id_2991];
  self sethintstring(var_3._id_0224);
  self _meth_84D1(1);
  self._id_84EF = 0;
  var_4 = _id_07F9::_id_C57D(1);

  if(var_4 == -1) {
    return;
  }
  _id_07F9::_id_A867(var_4, "invisible", (0, 0, 0));

  if(!isDefined(self _meth_8151())) {
    _id_07F9::_id_FB97(var_4, self.origin);
  } else {
    _id_07F9::_id_FB93(var_4, self);
  }

  _id_07F9::_id_FB9E(var_4, "active");
  _id_07F9::_id_FB8F(var_4, var_3._id_D968);
  _id_07F9::_id_FB98(var_4, 1);
  self._id_A907 = var_4;

  if(level.teambased) {
    if(var_4 != -1) {
      _id_07F9::_id_A8CA(var_4, self.team);
    }

    _id_297E(self.team, var_3.streakname, var_3._id_75F5);

    foreach(var_6 in level.players) {
      if(self.team != var_6.team) {
        continue;
      }
      if(isDefined(var_3._id_3201) && !var_6[[var_3._id_3201]](self)) {
        if(isDefined(self._id_298B)) {
          _id_078F::_id_D599(self._id_298B, var_6);
        }
      }
    }
  } else {
    if(var_4 != -1) {
      _id_07F9::_id_A8A5(var_4, self.owner);
    }

    if(!isDefined(var_3._id_3201) || self.owner[[var_3._id_3201]](self)) {
      _id_297E(self.owner, var_3.streakname, var_3._id_75F5);
    }
  }

  self makeuseable();
  self._id_8AC3 = 1;
  self setCanDamage(1);

  if(isDefined(var_0)) {
    self thread[[var_0]]();
  } else {
    thread _id_2973();
  }

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  } else {
    thread _id_2974();
  }

  if(isDefined(var_2)) {
    self thread[[var_2]]();
  } else {
    thread _id_2980();
  }

  _id_0812::_id_C2B2("Tactical_Ground", self.owner);

  if(isDefined(self.owner)) {
    self.owner notify("new_deployable_box", self);
  }

  if(level.teambased) {
    foreach(var_6 in level._id_AE7C) {
      if(istrue(var_3._id_8A93)) {
        _id_0B68(var_6, 1, var_3._id_3201);
      } else {
        _id_0B68(var_6, self.team == var_6.team, var_3._id_3201);
      }

      if(!isai(var_6)) {
        thread _id_297C(var_6);
      }
    }
  } else {
    foreach(var_6 in level._id_AE7C) {
      _id_0B68(var_6, isDefined(self.owner) && self.owner == var_6, var_3._id_3201);
    }
  }

  thread _id_297B();
  thread _id_296B();

  if(isDefined(var_3._id_AAAF)) {
    self[[var_3._id_AAAF]](var_3);
  }
}

_id_0B68(var_0, var_1, var_2) {
  if(var_1) {
    if(!isDefined(var_2) || var_0[[var_2]](self)) {
      _id_2972(var_0);
    } else {
      _id_2971(var_0);
      thread _id_4E9C(var_0);
    }

    thread _id_298F(var_0);
  } else
    _id_2971(var_0);
}

_id_297B() {
  self endon("death");

  for(;;) {
    level waittill("connected", var_0);
    childthread _id_2981(var_0);
  }
}

_id_296B() {
  self endon("death");

  for(;;) {
    level waittill("spawned_agent_player", var_0);
    _id_296A(var_0);
  }
}

_id_2981(var_0) {
  var_0 waittill("spawned_player");

  if(level.teambased) {
    _id_296A(var_0);
    thread _id_297C(var_0);
  }
}

_id_297C(var_0) {
  self endon("death");
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("joined_team");

    if(level.teambased) {
      _id_296A(var_0);
    }
  }
}

_id_296A(var_0) {
  if(self.team == var_0.team || istrue(level._id_298E[self._id_2991]._id_8A93)) {
    _id_2972(var_0);
    thread _id_298F(var_0);
  } else {
    _id_2971(var_0);

    if(isDefined(self._id_298B)) {
      _id_078F::_id_D599(self._id_298B, var_0);
    }
  }
}

_id_297E(var_0, var_1, var_2) {
  var_3 = level._id_298E[self._id_2991];
  var_4 = scripts\mp\utility\killstreak::_id_6AE9(var_1);

  if(isDefined(var_3._id_75E9)) {
    var_4 = var_3._id_75E9;
  }

  if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
    self._id_298B = thread _id_078F::_id_D59B(var_0, var_4, var_2, 1);
  }
}

_id_2972(var_0) {
  if(isPlayer(var_0)) {
    self _meth_80E0(var_0);
  }

  self._id_4A8D[var_0 getentitynumber()] = 0;
}

_id_2971(var_0) {
  if(isPlayer(var_0)) {
    self disableplayeruse(var_0);
  }

  self._id_4A8D[var_0 getentitynumber()] = 1;
}

_id_297F() {
  self makeunusable();
  self._id_8AC3 = 0;

  if(isDefined(self._id_A907)) {
    _id_07F9::_id_C799(self._id_A907);
  }
}

_id_2973() {
  var_0 = level._id_298E[self._id_2991];
  _id_07C3::_id_A0FF(var_0.maxhealth, var_0._id_42FD, ::_id_2975, ::_id_297A, 1);
}

_id_297A(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;
  var_7 = level._id_298E[self._id_2991];

  if(var_7._id_15C1) {
    var_6 = _id_07C3::_id_7468(var_2, var_3, var_6);
  }

  var_6 = _id_07C3::_id_746C(var_2, var_3, var_6);
  var_6 = _id_07C3::_id_7453(var_2, var_3, var_6);
  var_6 = _id_07C3::_id_741D(var_2, var_3, var_6);
  return var_6;
}

_id_2975(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  self._id_4849 = 1;
  var_5 = level._id_298E[self._id_2991];
  var_6 = _id_07C3::_id_AB18("deployable_ammo", var_1, var_2, var_3, var_4, var_5._id_CC16, var_5._id_1068F);

  if(var_6) {
    var_1 notify("destroyed_equipment");
  }
}

_id_2974() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  _id_297F();
  _id_C47D();
  var_0 = level._id_298E[self._id_2991];

  if(!istrue(self._id_4849)) {
    playFX(var_0._id_4421, self.origin);
    self playSound("mp_killstreak_disappear");
  } else {
    var_1 = self.origin + (0, 0, var_0._id_75F5);

    if(isDefined(var_0._id_43DF)) {
      var_2 = undefined;

      if(isDefined(self.owner)) {
        var_2 = self.owner;
      }

      if(isDefined(var_0._id_57CD)) {
        playFX(var_0._id_57CD, self.origin);
        self playSound("c4_expl_trans");
      }

      _func_01BA(var_1, var_0._id_43E1, var_0._id_43DF, var_0._id_43E0, var_2, "MOD_EXPLOSIVE", "support_box_mp");
      thread _id_0814::_id_7144(self.origin, 1.0);
    }
  }

  self notify("deleting");
  self delete();
}

_id_2976() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  childthread _id_2982("disconnect");
  childthread _id_2982("joined_team");
  childthread _id_2982("joined_spectators");
}

_id_2982(var_0) {
  self.owner waittill(var_0);
  self._id_87FB = 1;
  self notify("death");
}

_id_298F(var_0) {
  self endon("death");
  thread _id_2989(var_0);

  if(!isDefined(var_0._id_298A)) {
    var_0._id_298A = [];
  }

  var_0._id_298A[var_0._id_298A.size] = self;
  var_1 = level._id_298E[self._id_2991];

  for(;;) {
    self waittill("captured", var_2);

    if(var_2 == var_0) {
      var_0 playlocalsound(var_1._id_ABD3);

      if(isDefined(var_1._id_ABCD)) {
        var_0[[var_1._id_ABCD]](self);
      }

      if(isDefined(self.owner) && var_0 != self.owner && !scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0)) {
        self.owner thread _id_0A9F::_id_7003("support", undefined, var_1._id_FEF7);
      }

      if(isDefined(self._id_FED3)) {
        self._id_FED3--;

        if(self._id_FED3 == 0) {
          _id_2978();
          break;
        }
      }

      if(isDefined(var_1._id_3208) && var_1._id_3208) {
        foreach(var_4 in level._id_47DD[var_1.streakname]) {
          var_4 _id_2971(var_0);

          if(isDefined(var_4._id_298B)) {
            _id_078F::_id_D599(var_4._id_298B, var_0);
          }

          var_4 thread _id_4E9C(var_0);
        }

        continue;
      }

      if(istrue(var_1._id_31BD)) {
        continue;
      }
      if(isDefined(self._id_298B)) {
        _id_078F::_id_D599(self._id_298B, var_0);
      }

      _id_2971(var_0);
      thread _id_4E9C(var_0);
    }
  }
}

_id_4E9C(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("death");

  if(level.teambased) {
    if(self.team == var_0.team) {
      if(isDefined(self._id_298B)) {
        _id_078F::_id_D590(self._id_298B, var_0);
      }

      _id_2972(var_0);
    }
  } else if(isDefined(self.owner) && self.owner == var_0) {
    if(isDefined(self._id_298B)) {
      _id_078F::_id_D590(self._id_298B, var_0);
    }

    _id_2972(var_0);
  }
}

_id_2989(var_0) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", var_1);

    if(isDefined(level._id_298E[self._id_2991]._id_A6C5) && level._id_298E[self._id_2991]._id_A6C5 && scripts\mp\utility\weapon::_id_88F6(var_0 getcurrentweapon())) {
      continue;
    }
    if(var_1 == var_0 && _id_FE7D(var_0, level._id_298E[self._id_2991]._id_FEE7)) {
      self notify("captured", var_0);
    }
  }
}

_id_8870(var_0) {
  return level.teambased && self.team == var_0.team;
}

_id_2980() {
  self endon("death");
  level endon("game_ended");
  var_0 = level._id_298E[self._id_2991];
  var_1 = var_0._id_9371;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);

  if(isDefined(var_0._id_10690)) {
    self.owner thread _id_0A8D::_id_9137(var_0._id_10690);
  }

  _id_2978();
}

_id_2978() {
  waitframe();
  self._id_87FB = 1;
  self notify("death");
}

_id_477B(var_0) {
  wait 0.25;
  self linkto(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 waittill("death");
  _id_2978();
}

_id_2979(var_0) {
  self endon("death");
  self hide();

  foreach(var_2 in level.players) {
    if(var_2.team == var_0) {
      self showtoplayer(var_2);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self showtoplayer(var_2);
      }
    }
  }
}

_id_FE7D(var_0, var_1) {
  scripts\mp\movers::_id_CDD8(var_0);
  var_0 scripts\common\utility::_id_158D(0);
  var_0._id_298D = spawnStruct();
  var_0._id_298D._id_4143 = 0;
  var_0._id_298D._id_84EF = 1;
  var_0._id_298D._id_FEB1 = 0;
  var_0._id_298D._id_7C8C = self._id_7C8C;

  if(isDefined(var_1)) {
    var_0._id_298D._id_FEE7 = var_1;
  } else {
    var_0._id_298D._id_FEE7 = 3000;
  }

  var_2 = _id_FE7F(var_0);

  if(isalive(var_0)) {
    var_0 scripts\common\utility::_id_158D(1);
    scripts\mp\movers::_id_CDE7(var_0);
  }

  if(!isDefined(self)) {
    return 0;
  }

  var_0._id_298D._id_84EF = 0;
  var_0._id_298D._id_4143 = 0;
  return var_2;
}

_id_FE7F(var_0) {
  var_1 = var_0._id_298D;

  while(var_0 _id_89A4(var_1)) {
    if(!var_0 scripts\mp\movers::_id_CDE8(self)) {
      var_0 _id_07D6::_id_FD75(var_1, 0);
      return 0;
    }

    var_1._id_4143 = var_1._id_4143 + level._id_01E2 * var_1._id_FEB1;

    if(isDefined(var_0._id_A8EC)) {
      var_1._id_FEB1 = 1 * var_0._id_A8EC;
    } else {
      var_1._id_FEB1 = 1;
    }

    var_0 _id_07D6::_id_FD75(var_1, 1);

    if(var_1._id_4143 >= var_1._id_FEE7) {
      var_0 _id_07D6::_id_FD75(var_1, 0);
      return scripts\mp\utility\player::isreallyalive(var_0);
    }

    waitframe();
  }

  var_0 _id_07D6::_id_FD75(var_1, 0);
  return 0;
}

_id_1095() {
  level._id_47DD[self._id_2991][self getentitynumber()] = self;
}

_id_C47D() {
  level._id_47DD[self._id_2991][self getentitynumber()] = undefined;
}

_id_89A4(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\mp\utility\player::isreallyalive(self) && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0._id_4143 < var_0._id_FEE7 && (!isDefined(self._id_F03B) || !self._id_F03B);
}

_id_8880(var_0) {
  var_1 = 0;

  switch (var_0) {
    default:
      var_1 = 0;
      break;
  }

  return var_1;
}