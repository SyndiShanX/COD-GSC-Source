/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1821.gsc
*************************************************/

init() {
  level._id_47DE = ::_id_7F0D;

  if(!isDefined(level._id_298E)) {
    level._id_298E = [];
  }

  level thread _id_0704::_id_16D3();
  level thread _id_0730::_id_7140();
}

_id_7F0D() {
  _id_0737::_id_C1EE("deployable_box", "null", undefined, ::_id_2977, ::_id_2969, 0, 0, undefined);
}

_id_2977(var_0, var_1) {
  var_2 = level._id_298E[var_0._id_2968._id_2991];
  return var_2._id_0224;
}

_id_2969(var_0, var_1) {
  var_0._id_2968 notify("captured", var_1);
}

_id_296E(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1._id_0481 = "interaction";
  var_1._id_039B = "deployable_box";
  var_1._id_C588 = 0;
  var_1._id_2968 = var_0;
  var_1._id_E3FF = "null";
  var_1._id_3D91 = 0;
  _id_0737::_id_1037(var_1);
  var_0._id_8350 = var_1;
  return var_0;
}

_id_24A8(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  thread _id_10AC4(var_1, var_0, var_2, var_3, var_4, var_5, var_6);
  return 1;
}

_id_10AC4(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("spawned_player");
  self endon("disconnect");

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  var_2 _meth_821E(1);
  self notify("deployable_deployed");
  var_7 = "cp_used_" + var_0;

  foreach(var_9 in level.players) {
    var_9 thread scripts\cp\cp_hud_message::showsplash(var_7, undefined, self);
  }

  var_2.owner = self;
  var_2._id_04FE = var_3;
  self._id_9B4D = var_2;
  var_11 = scripts\cp\utility::_id_6E8F();
  var_12 = thread _id_0777::_id_EC3F(var_11, 0);
  self._id_8F79 = undefined;

  if(_id_8880(var_0)) {
    self thread[[level._id_298E[var_0]._id_7185]](var_2);
    return;
  }

  var_2 thread _id_9B51(var_1, var_0, ::_id_297D, var_4, var_5, var_6);
}

_id_AD34(var_0) {
  self notify("death");
}

_id_9B4F() {
  self endon("death");
  _id_9B50();

  if(isDefined(self) && !istrue(self._id_87FB)) {
    thread _id_EB62();
  }
}

_id_9B50() {
  self.owner endon("disconnect");
  self.owner endon("joined_team");
  self.owner endon("joined_spectators");
  level endon("game_ended");
  _id_0733::waitlongdurationwithhostmigrationpause(5);
}

_id_9B51(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("markerActivate");
  self endon("markerActivate");
  var_6 = scripts\engine\utility::_id_10898("missile_stuck", "explode", "death");
  var_7 = self.owner;
  var_8 = self.origin;
  var_9 = level._id_298E[var_1];
  var_10 = undefined;

  if(var_6 == "explode") {
    var_10 = _id_3F9C(var_1, scripts\engine\utility::_id_5000(var_8, 1000), var_7);
  } else if(var_6 == "death") {
    var_10 = _id_3F9C(var_1, scripts\engine\utility::_id_5000(var_8, 1000), var_7);
  } else {
    var_10 = self;
  }

  var_10 setscriptablepartstate("effects", "plant", 0);
  var_10 setscriptablepartstate("anims", "closedIdle", 0);
  var_10 setscriptablepartstate("beacon", "active", 0);
  var_10.health = 999999;
  var_10.maxhealth = var_9.maxhealth;
  var_10.angles = self.angles;
  var_10._id_2991 = var_1;
  var_10.owner = var_7;
  var_10.team = var_7.team;
  var_10._id_7C8C = var_9._id_7C8C;

  if(isDefined(var_9._id_4EC6)) {
    var_10._id_4EC6 = var_9._id_4EC6;
  }

  if(isDefined(var_9._id_9CB7)) {
    var_10._id_FED3 = var_9._id_9CB7;
  }

  var_10.owner._id_EB5B = var_10;
  var_10 thread _id_2976();
  var_10 _id_1096(var_10.owner);
  var_10 _id_EB5E();
  var_10[[var_2]](var_10, var_3, var_4, var_5);
  var_11 = level._id_3E52[var_1]._id_9DED;
  var_12 = 0;

  if(var_7 _id_074E::_id_F723(var_11)) {
    return;
  }
}

_id_EB62() {
  self setscriptablepartstate("effects", "destroy", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread _id_EB61(3);
}

_id_EB61(var_0) {
  self notify("death");
  self._id_87FB = 1;
  self setCanDamage(0);
  _id_EB84();
  _id_EB85();
}

_id_EB5E() {
  if(1) {
    if(isDefined(self.owner)) {
      self._id_ACE5 = scripts\cp\cp_outline_utility::outlineenableforplayer(self, self.owner, "outline_depth_white", "killstreak_personal");
    }
  }
}

_id_EB85() {
  if(isDefined(self._id_ACE5)) {
    scripts\cp\cp_outline_utility::outlinedisable(self._id_ACE5, self);
  }
}

_id_EB5D() {
  var_0 = _id_07F9::_id_C57D(1);

  if(var_0 == -1) {
    return;
  }
  _id_07F9::_id_A867(var_0, "invisible", (0, 0, 0));
  _id_07F9::_id_FB93(var_0, self);
  _id_07F9::_id_FB9E(var_0, "active");
  _id_07F9::_id_FB8F(var_0, level._id_298E[self._id_2991]._id_D968);
  _id_07F9::_id_FB98(var_0, 1);
}

_id_EB84() {
  if(isDefined(self._id_A8DA)) {
    _id_07F9::_id_C799(self._id_A8DA);
  }
}

_id_3F9C(var_0, var_1, var_2) {
  var_3 = level._id_298E[var_0];
  var_4 = spawn("script_model", var_1 - (0, 0, 1));
  var_4 setModel(var_3.modelbase);
  var_4.health = 999999;
  var_4.maxhealth = var_3.maxhealth;
  var_4.angles = self.angles;
  var_4._id_2991 = var_0;
  var_4.owner = var_2;
  var_4.team = var_2.team;
  var_4._id_7C8C = var_3._id_7C8C;
  return var_4;
}

_id_297D(var_0, var_1, var_2, var_3) {
  var_4 = level._id_298E[self._id_2991];
  self._id_84EF = 0;

  if(isDefined(self.owner)) {
    self.owner thread _id_0752::_id_7003("munitions_box_teammate_used");
    self.owner notify("munitions_used", var_0._id_2991);
    self.owner thread _id_0750::_id_AB3D(self._id_2991);
  }

  if(isDefined(var_4._id_47EB)) {
    self.owner thread[[var_4._id_47EB]]();
  }

  if(!isDefined(var_4._id_3201) || self.owner[[var_4._id_3201]](self)) {
    _id_297E(self.owner, var_4.streakname, var_4._id_75F5);
  }

  var_0 = _id_296E(var_0);

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  } else {
    thread _id_2973();
  }

  thread _id_2974();

  if(isDefined(var_3)) {
    self thread[[var_3]]();
  } else {
    thread _id_2980();
  }

  thread _id_297B();
  thread _id_296B();
  thread _id_298F();
}

_id_0B68(var_0, var_1, var_2) {
  if(var_1) {
    if(!isDefined(var_2) || var_0[[var_2]](self)) {
      _id_2972(var_0);
    } else {}

    thread _id_298F();
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
  if(self.team == var_0.team) {
    _id_2972(var_0);
    thread _id_298F();
    _id_297E(var_0, level._id_298E[self._id_2991].streakname, level._id_298E[self._id_2991]._id_75F5);
  } else
    _id_2971(var_0);
}

_id_297E(var_0, var_1, var_2) {
  var_3 = level._id_298E[self._id_2991];
  var_4 = undefined;

  if(isDefined(var_3._id_75E9)) {
    var_4 = var_3._id_75E9;
  }

  self._id_298B = thread scripts\cp\utility::_id_546A(self, var_2, self.team, var_4, 0);
}

_id_2972(var_0) {
  self._id_4A8D[var_0 getentitynumber()] = 0;
}

_id_2971(var_0) {
  self._id_4A8D[var_0 getentitynumber()] = 1;
}

_id_297F() {}

_id_2973() {
  var_0 = level._id_298E[self._id_2991];
}

_id_297A(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0._id_7C97;
  var_6 = var_4;
  var_7 = level._id_298E[self._id_2991];
  return var_6;
}

_id_2975(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = level._id_298E[self._id_2991];
  var_1 notify("destroyed_equipment");
}

_id_2974() {
  self waittill("death");
  _id_0737::_id_C3C5(self._id_8350);

  foreach(var_1 in level.players) {
    var_1 _id_0737::_id_C1A2();
  }

  _id_297F();
  _id_C47E(self.owner);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.owner)) {
    self.owner._id_EB5B = undefined;
  }

  if(isDefined(self._id_298B)) {
    thread scripts\cp\utility::_id_546B(self, self._id_298B);
  }

  var_3 = level._id_298E[self._id_2991];
  var_4 = anglesToForward(self.angles);
  var_5 = anglestoup(self.angles);
  playFX(var_3._id_4421, self.origin, var_4, var_5);
  self playSound("mp_equip_destroyed");
  self notify("deleting");
  self delete();
}

_id_2976() {
  self endon("death");
  level endon("game_ended");
  self notify("box_handleOwner");
  self endon("box_handleOwner");
  self.owner scripts\engine\utility::waittill_any_2("killstreak_disowned", "disconnect");
  self notify("death");
}

_id_298F() {
  var_0 = level._id_298E[self._id_2991];

  for(;;) {
    self waittill("captured", var_1);

    if(isPlayer(var_1) && var_1.team == self.owner.team) {
      var_2 = 1;

      if(isDefined(var_0._id_ABCD)) {
        var_2 = var_1[[var_0._id_ABCD]](self);
      }

      if(istrue(var_2)) {
        thread _id_B36F();
        var_1 scripts\cp\utility::_id_B744("ges_swipe");

        if(isDefined(self.owner) && var_1 != self.owner) {
          self.owner thread _id_0752::_id_7003("munitions_box_teammate_used");
        }

        if(isDefined(self._id_FED3)) {
          self._id_FED3--;

          if(self._id_FED3 == 0) {
            _id_2978();
            break;
          }
        }

        if(isDefined(var_0._id_3208) && var_0._id_3208) {
          foreach(var_4 in level._id_47DD[var_0.streakname]) {
            var_4 _id_2971(self);
            var_4 thread _id_4E9C(self);
          }

          continue;
        }

        if(istrue(var_0._id_31BD)) {
          continue;
        }
      }
    }
  }
}

_id_B36F() {
  self endon("death");
  self notify("playerboxUseAnimation");
  self endon("playerboxUseAnimation");
  self setscriptablepartstate("anims", "open", 0);
  wait(_id_EB67());
  self setscriptablepartstate("anims", "close", 0);
  wait(_id_EB66());
  self setscriptablepartstate("anims", "closedIdle", 0);
}

_id_4E9C(var_0) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 waittill("death");

  if(level.teambased) {
    if(self.team == var_0.team) {
      _id_297E(var_0, level._id_298E[self._id_2991].streakname, level._id_298E[self._id_2991]._id_75F5);
      _id_2972(var_0);
    }
  } else if(isDefined(self.owner) && self.owner == var_0) {
    _id_297E(var_0, level._id_298E[self._id_2991].streakname, level._id_298E[self._id_2991]._id_75F5);
    _id_2972(var_0);
  }
}

_id_2989(var_0) {
  level endon("game_ended");

  while(isDefined(self)) {
    self waittill("trigger", var_1);

    if(var_1 == var_0) {
      self notify("captured", var_1);
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
  _id_0733::waitlongdurationwithhostmigrationpause(var_1);
  _id_2978();
}

_id_2978() {
  waitframe();
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
    var_1._id_4143 = var_1._id_4143 + level._id_01E2 * var_1._id_FEB1;

    if(isDefined(var_0._id_A8EC)) {
      var_1._id_FEB1 = 1 * var_0._id_A8EC;
    } else {
      var_1._id_FEB1 = 1;
    }

    if(var_1._id_4143 >= var_1._id_FEE7) {
      return var_0 scripts\cp_mp\utility\player_utility::_isalive();
    }

    waitframe();
  }

  return 0;
}

_id_1096(var_0) {
  if(!isDefined(var_0._id_47DD)) {
    var_0._id_47DD = [];
  }

  if(!isDefined(var_0._id_47DD[self._id_2991])) {
    var_0._id_47DD[self._id_2991] = [];
  }

  if(var_0._id_47DD[self._id_2991].size >= 2) {
    var_1 = 1 + var_0._id_47DD[self._id_2991].size - 3;

    foreach(var_3 in var_0._id_47DD[self._id_2991]) {
      if(var_1 > 0) {
        var_3 thread _id_EB62();
        var_1--;
      }
    }
  }

  var_0._id_47DD[self._id_2991][self getentitynumber()] = self;
}

_id_C47E(var_0) {
  if(isDefined(var_0)) {
    var_0._id_47DD[self._id_2991][self getentitynumber()] = undefined;
  }
}

_id_1095() {
  if(isDefined(level._id_47DD[self._id_2991]) && level._id_47DD[self._id_2991].size > 0) {
    foreach(var_1 in level._id_47DD[self._id_2991]) {
      var_1 thread _id_EB62();
    }
  }

  level._id_47DD[self._id_2991][self getentitynumber()] = self;
}

_id_C47D() {
  level._id_47DD[self._id_2991][self getentitynumber()] = undefined;
}

_id_89A4(var_0) {
  return !level.gameended && isDefined(var_0) && scripts\cp_mp\utility\player_utility::_isalive() && self useButtonPressed() && !self isonladder() && !self meleeButtonPressed() && var_0._id_4143 < var_0._id_FEE7 && (!isDefined(self._id_F03B) || !self._id_F03B);
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

_id_EB79(var_0) {
  var_1 = self _meth_8151();
  self unlink();
  self.angles = _func_0047(self.angles, (0, 90, 0));
  self.origin = self.origin + anglestoup(self.angles) * 3;

  if(isDefined(var_1)) {
    self linkto(var_1);
  }

  thread _id_EB7A(var_0);
}

_id_EB7A(var_0) {
  self endon("death");
  self setscriptablepartstate("anims", "open", 0);
  self setscriptablepartstate("effects", "plant", 0);
  wait(var_0._id_47E7);
}

#using_animtree("scriptables");

_id_EB67() {
  return _func_0079(%wm_supportbox_ground_open);
}

_id_EB66() {
  return _func_0079(%wm_supportbox_ground_close);
}