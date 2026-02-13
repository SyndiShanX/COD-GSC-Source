/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 22.gsc
*************************************************/

main() {
  if(isDefined(level._id_3FD9) && level._id_3FD9) {
    return;
  }
  if(level.gametype == "br") {
    return;
  }
  _id_D795();
  level._id_20EE = ::_func_0018;
  level._id_20EF = ::_func_0019;
  level thread _id_0015::init();
  level thread _id_0A2E::init();
}

_id_D795() {
  if(!isDefined(level._id_11EF)) {
    level._id_11EF = [];
  }

  level._id_11EF["player"] = [];
  level._id_11EF["player"]["spawn"] = ::_id_E0AD;
  level._id_11EF["player"]["think"] = ::scripts\mp\bots\bots_gametype_war::_id_291F;
  level._id_11EF["player"]["on_killed"] = ::_id_AA48;
  level._id_11EF["player"]["on_damaged"] = ::_id_AA47;
  level._id_11EF["player"]["on_damaged_finished"] = ::_id_11EC;
  _id_0A46::_id_D795();
  _id_0A34::_id_D795();
  _id_0A57::_id_D795();
  scripts\mp\agents\krampus\s4_krampus::_id_D795();
  scripts\mp\agents\elf\s4_mp_codmas_elf::_id_D795();
}

_id_107A6() {
  while(!isDefined(level._id_11EF)) {
    wait 0.05;
  }
}

_id_0FE1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = _id_0015::_id_3B84(var_0, var_1, var_2);

  if(isDefined(var_9)) {
    var_14._id_3802 = var_9;
  }

  if(isDefined(var_14)) {
    var_14 thread[[var_14 _id_09EF::_id_1215("spawn")]](var_3, var_4, var_5, var_6, var_7, var_8, var_10, var_11, var_12, var_13);
  }

  return var_14;
}

_id_E0AD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("disconnect");

  while(!isDefined(level._id_6D4A)) {
    waitframe();
  }

  if(self._id_7552) {
    wait(randomintrange(6, 10));
  }

  _id_09EF::_id_826D(1);

  if(isDefined(var_0) && isDefined(var_1)) {
    var_10 = var_0;
    var_11 = var_1;
    self._id_904C = spawnStruct();
    self._id_904C.origin = var_10;
    self._id_904C.angles = var_11;
  } else {
    var_12 = self[[level._id_6D4A]]();
    var_10 = var_12.origin;
    var_11 = var_12.angles;
    self._id_904C = var_12;
  }

  _id_09EF::_id_0EE4();
  self._id_904F = gettime();
  self._id_E393 = gettime();
  var_13 = var_10 + (0, 0, 25);
  var_14 = var_10;
  var_15 = _func_019A(var_13, var_14);

  if(distancesquared(var_15, var_13) > 1) {
    var_10 = var_15;
  }

  self _meth_83D1(var_10, var_11);

  if(isDefined(var_3) && var_3) {
    _id_09F7::_id_2701();
  } else {
    scripts\mp\bots\bots_util::_id_28C8("default");
  }

  if(isDefined(var_5)) {
    scripts\mp\bots\bots_util::_id_28C4(var_5);
  }

  _id_825E();
  _id_0015::_id_D132(100);

  if(isDefined(var_4) && var_4) {
    self._id_C684 = 1;
  }

  if(isDefined(var_2)) {
    _id_09EF::_id_D136(var_2.team, var_2);
  }

  if(isDefined(self.owner)) {
    thread _id_485E(self.owner);
  }

  self _meth_80D2(0);
  self takeallweapons();
  self[[level._id_ABA4]]();

  if(!istrue(var_6)) {
    scripts\mp\class::_id_6FB1(self.team, self.class, 1);
  }

  thread scripts\mp\bots\bots::_id_2904(1);
  thread scripts\mp\bots\bots::_id_28F9();
  thread _id_09F9::_id_2902();
  self thread[[_id_09EF::_id_1215("think")]]();

  if(!self._id_7552) {
    _id_0817::_id_1165();
  }

  self._id_7552 = 0;

  if(!istrue(var_7)) {
    thread scripts\mp\weapons::onplayerspawned();
  }

  if(!istrue(var_8)) {
    thread scripts\mp\healthoverlay::_id_9A29();
  }

  if(!istrue(var_9)) {
    thread scripts\mp\battlechatter_mp::onplayerspawned();
  }

  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  self notify("spawned_player");
}

_id_485E(var_0) {
  self endon("death");
  childthread _id_10BC5("disconnect", var_0);
  childthread _id_10BC5("joined_team", var_0);
  childthread _id_10BC5("joined_spectators", var_0);
}

_id_10BC5(var_0, var_1) {
  var_1 waittill(var_0);
  self notify("owner_disconnect");

  if(scripts\mp\hostmigration::waittillhostmigrationdone()) {
    wait 0.05;
  }

  self suicide();
}

_id_11EC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isalive(self)) {
    if(isDefined(var_0) || isDefined(var_1)) {
      if(!isDefined(var_0)) {
        var_0 = var_1;
      }

      if(isDefined(self._id_15E0) && !self._id_15E0) {
        if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
          return 0;
        }
      }

      if(isDefined(var_0.classname) && var_0.classname == "auto_turret") {
        var_1 = var_0;
      }

      if(isDefined(var_1) && var_4 != "MOD_FALLING" && var_4 != "MOD_SUICIDE") {
        if(level.teambased) {
          if(isDefined(var_1.team) && var_1.team != self.team) {
            self _meth_82D2(var_1);
          }
        } else
          self _meth_82D2(var_1);
      }
    }

    self _meth_80F1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, var_10, var_11);

    if(!isDefined(self.isactive)) {
      self._id_10847 = 1;
    }

    return 1;
  }
}

_id_AA45(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = isDefined(var_1) && isDefined(self.owner) && self.owner == var_1;
  var_14 = _id_0A8B::_id_1DD9(self.owner, var_1) || var_13;

  if(isDefined(self.candamage) && !self.candamage) {
    return 0;
  }

  if(!(var_13 && self._id_1210 == "playerProxy")) {
    if(level.teambased && var_14 && !level._id_5FA5) {
      return 0;
    }

    if(!level.teambased && var_13) {
      return 0;
    }
  }

  if(isDefined(var_4) && var_4 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
    return 0;
  }

  if(!isDefined(self) || !scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(isDefined(var_1) && var_1.classname == "script_origin" && isDefined(var_1.type) && var_1.type == "soft_landing") {
    return 0;
  }

  if(isDefined(var_0) && isDefined(var_0._id_EA8F) && var_0._id_EA8F == self) {
    var_2 = self.health + 1;
  }

  if(var_2 <= 0) {
    return 0;
  }

  if(isDefined(var_1) && var_1 != self && var_2 > 0 && (!isDefined(var_8) || var_8 != "shield")) {
    if(var_3 &level._id_7CA8) {
      var_15 = "stun";
    } else {
      var_15 = "standard";
    }

    var_1 thread _id_07C4::_id_FC47(var_15, var_2 >= self.health);
  }

  if(isDefined(level._id_A00B)) {
    var_2 = [[level._id_A00B]](var_0, self, var_1, var_2, var_4, var_5, var_6, var_7, var_8);
  }

  return self[[_id_09EF::_id_1215("on_damaged_finished")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_AA47(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = isDefined(var_1) && isDefined(self.owner) && self.owner == var_1;

  if(!level.teambased && var_13) {
    return 0;
  }

  if(isweapon(var_5)) {
    var_14 = getcompleteweaponname(var_5);
  } else {
    var_14 = var_5;
  }

  var_12 = makeweaponfromstring(var_14);

  if(isDefined(level._id_10DB1)) {
    [[level._id_10DB1]](var_12, var_0);
  }

  _id_07C3::_id_2F38(var_0, var_1, var_2, var_3, var_4, var_12, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_AA48(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _id_AA54(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);

  if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
    _id_07C3::_id_AB18("squad_mate", var_1, var_4, var_3, var_2, "destroyed_squad_mate");
  }

  thread scripts\mp\weapons::_id_5057(var_1);

  if(self.isactive) {
    self._id_7552 = 1;

    if(scripts\mp\utility\game::_id_6A65() != 1 && (isDefined(self._id_C684) && self._id_C684)) {
      self thread[[_id_09EF::_id_1215("spawn")]]();
    } else {
      _id_09EF::_id_4386();
    }
  }
}

_id_AA54(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(self._id_75A6) && self._id_75A6) {
    _id_07C3::_id_90FE(var_2, var_3);

    if(!var_9) {
      var_10 = self dropitem(self getcurrentweapon());

      if(isDefined(var_10)) {
        var_10 thread scripts\mp\weapons::_id_4783();
        var_10.owner = self;
        var_10._id_ADAD = var_1;
        var_10 makeunusable();
      }
    }
  }

  if(var_9) {
    self[[level._id_10D7D]](var_1, var_3, undefined, var_2);
  }

  _id_080B::_id_C877();

  if(isDefined(self._id_A546)) {
    return;
  }
  self._id_25CA = self _meth_808C(var_8);
  thread _id_07C3::_id_0D84(self._id_25CA, var_3, var_0);
}

_id_825E() {
  if(isDefined(self._id_3800)) {
    self.class = self._id_3800;
  } else if(_id_09F6::_id_28CF()) {
    self.class = "callback";
  } else {
    self.class = "class1";
  }
}