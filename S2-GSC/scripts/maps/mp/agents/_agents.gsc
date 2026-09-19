/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agents.gsc
**********************************************/

main() {
  if(isDefined(level._id_27F6) && level._id_27F6) {
    return;
  }
  _id_87A7();
  level._id_14F6 = ::_func_01E;
  level._id_14F7 = ::_func_01D;
  level thread maps\mp\agents\_agent_common::init();

  if(!maps\mp\_utility::_id_551F() && !(isDefined(level._id_585D) && level._id_585D))
    return;
}

_id_87A7() {
  if(!isDefined(level._id_0A41))
    level._id_0A41 = [];

  if(!(isDefined(level._id_585D) && level._id_585D)) {
    level._id_0A41["player"] = [];
    level._id_0A41["player"]["spawn"] = ::_id_8F70;
    level._id_0A41["player"]["onAIConnect"] = ::_id_6AB5;
    level._id_0A41["player"]["think"] = maps\mp\bots\_bots_gametype_war::_id_1B25;
    level._id_0A41["player"]["on_killed"] = ::_id_6A75;
    level._id_0A41["player"]["on_damaged"] = ::_id_6A74;
    level._id_0A41["player"]["on_damaged_finished"] = ::_id_0A40;
    level._id_0A4D = ::_id_0933;
    level._id_0A4C = ::_id_0921;
    level._id_0A55 = ::_id_2DD5;
    level._id_0A5B = ::_id_5331;
    level._id_0A5D = ::_id_6AA3;
    level._id_0A5C = ::_id_6A73;
    level notify("agent_funcs_init");
  }
}

_id_A675() {
  while(!isDefined(level._id_0A41))
    waitframe();
}

_id_0933(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = maps\mp\agents\_agent_common::_id_2586(var_0, var_1, var_2);

  if(isDefined(var_11)) {
    if(isDefined(var_10))
      var_11._id_9089 = var_10;

    var_11 thread[[var_11 maps\mp\agents\_agent_utility::_id_0A59("spawn")]](var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  return var_11;
}

_id_0921(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return [[level._id_0A4D]]("dog", var_0, var_1, var_2, var_3, var_4, 0, var_5, var_6, var_7);
}

_id_6AB5() {
  self._id_0009 = &"PLAYER";
}

_id_8F70(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");

  while(!isDefined(level._id_4696))
    waitframe();

  if(self._id_4B60)
    wait(_func_0A4(6, 10));

  maps\mp\agents\_agent_utility::_id_5334(1);

  if(isDefined(var_0) && isDefined(var_1)) {
    var_7 = var_0;
    var_8 = var_1;
    self._id_5BE0 = spawnStruct();
    self._id_5BE0.origin = var_7;
    self._id_5BE0.angles = var_8;
  } else {
    self _meth_856C();
    var_9 = [[level._id_4696]]();
    var_7 = var_9.origin;
    var_8 = var_9.angles;
    self._id_5BE0 = var_9;
  }

  maps\mp\agents\_agent_utility::_id_08A7();
  self._id_5CC6 = maps\mp\agents\_agent_utility::_id_45AE(self.name);
  self._id_5BE2 = gettime();

  if(level.teambased) {
    var_10["position"] = var_7;
    var_10["time"] = self._id_5BE2;
    level._id_7AD4[self.team][level._id_7AD4[self.team].size] = var_10;
  }

  var_11 = var_7 + (0, 0, 25);
  var_12 = var_7;
  var_13 = _func_081(var_11, var_12);

  if(distancesquared(var_13, var_11) > 1)
    var_7 = var_13;

  self _meth_838F(var_7, var_8);

  if(isDefined(var_5))
    self._id_0A43 = var_5;

  if(isDefined(self._id_0A43)) {
    if(self._id_0A43 == "follow_code_and_dev_dvar")
      self[[level._id_19D5["bot_set_difficulty"]]](self _meth_836D(), 1);
    else
      self[[level._id_19D5["bot_set_difficulty"]]](var_5);
  } else
    self[[level._id_19D5["bot_set_difficulty"]]](self _meth_836D());

  if(isDefined(var_3) && var_3)
    self._id_A1F0 = 1;

  if(isDefined(self._id_A1F0) && self._id_A1F0) {
    if(!self._id_4B60) {
      var_14 = self _meth_837D("advancedPersonality");

      if(isDefined(var_14) && var_14 != 0)
        maps\mp\bots\_bots_personality::_id_193F();
    }

    maps\mp\bots\_bots_personality::_id_1939();
  } else
    self[[level._id_19D5["bot_set_personality"]]]("default");

  maps\mp\agents\_agent_common::_id_83FD(100);

  if(isDefined(var_4) && var_4)
    self._id_7DAD = 1;

  if(isDefined(var_2))
    maps\mp\agents\_agent_utility::_id_83FE(var_2.team, var_2);

  if(isDefined(self._id_0117))
    self thread[[level._id_0A55]](self._id_0117);

  thread maps\mp\_flashgrenades::_id_6394();
  self _meth_83D6(0);
  self[[level._id_6BA7]]();

  if(isDefined(var_6)) {
    self._id_0BA6 = var_6;
    self _meth_858A(var_6);
    maps\mp\agents\_agent_common::_id_83FD(self.health);
    maps\mp\gametypes\_class::_id_4774();
  } else {
    self[[level._id_0A5B]]();
    maps\mp\gametypes\_class::_id_4773(self.team, self.class, 1);
  }

  self thread[[level._id_19D5["bot_think_watch_enemy"]]](1);
  thread maps\mp\bots\_bots::_id_1AFE();
  self thread[[level._id_19D5["bot_think_tactical_goals"]]]();
  self thread[[maps\mp\agents\_agent_utility::_id_0A59("think")]]();

  if(!self._id_4B60)
    _id_050D::_id_09FA();

  if(!self._id_4B60) {
    thread _id_0513::onplayerspawned();

    if(!isDefined(level._id_212F) || !level._id_212F)
      thread _id_04C2::onplayerspawned();
  }

  self._id_4B60 = 0;
  thread _id_04D6::_id_73FC();

  if(isDefined(self._id_A1F0) && self._id_A1F0 && isDefined(self._id_7DAD) && self._id_7DAD)
    self _meth_8528(1, self.team);

  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  level notify("player_spawned", self);
  self notify("spawned_player");
}

_id_2DD5(var_0) {
  self endon("death");
  var_0 waittill("killstreak_disowned");
  self notify("owner_disconnect");

  if(maps\mp\gametypes\_hostmigration::_id_A782())
    waitframe();

  self suicide();
}

_id_0A40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_0) || isDefined(var_1)) {
    if(!isDefined(var_0))
      var_0 = var_1;

    if(isDefined(self._id_0C31) && !self._id_0C31) {
      if(isDefined(var_0.classname) && var_0.classname == "script_vehicle")
        return 0;
    }

    if(isDefined(var_0.classname) && var_0.classname == "auto_turret")
      var_1 = var_0;

    if(isDefined(var_1) && var_4 != "MOD_FALLING" && var_4 != "MOD_SUICIDE") {
      if(level.teambased) {
        if(isDefined(var_1.team) && var_1.team != self.team)
          self _meth_8391(var_1);
      } else
        self _meth_8391(var_1);
    }
  }

  var_11 = self _meth_8390(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0);

  if(isDefined(var_11))
    thread _id_3BA5(var_11[0], var_11[1], var_11[2], var_11[3], var_11[4], var_11[5], var_11[6]);

  if(!isDefined(self._id_565F))
    self._id_A6ED = 1;

  return 1;
}

_id_3BA5(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  waittillframeend;

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  self _meth_853B(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_6A73(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(self._id_0117)) {
    var_11 = isDefined(var_1) && self._id_0117 == var_1;
    var_12 = maps\mp\_utility::_id_118D(self._id_0117, var_1) || var_11;
  } else {
    var_11 = 0;
    var_12 = maps\mp\_utility::_id_118D(self, var_1);
  }

  if(level.teambased && var_12 && !level._id_3EC4 && !common_scripts\utility::_id_562E(var_1.candamageallies))
    return 0;

  if(!level.teambased && var_11)
    return 0;

  if(isDefined(var_4) && var_4 == "MOD_CRUSH" && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "script_vehicle")
    return 0;

  if(!isDefined(self) || !maps\mp\_utility::isreallyalive(self))
    return 0;

  if(isDefined(var_1) && var_1.classname == "script_origin" && isDefined(var_1.type) && var_1.type == "soft_landing")
    return 0;

  if(var_5 == "killstreak_emp_mp")
    return 0;

  if(var_5 == "bouncingbetty_mp" && !_id_0513::_id_61DA(var_0, self))
    return 0;

  if((var_5 == "throwingknife_mp" || var_5 == "throwingknifejugg_mp") && var_4 == "MOD_IMPACT")
    var_2 = self.health + 1;

  if(isDefined(var_0) && isDefined(var_0._id_9488) && var_0._id_9488 == self)
    var_2 = self.health + 1;

  if(var_2 <= 0)
    return 0;

  if(isDefined(level._id_62AD))
    var_2 = [[level._id_62AD]](self, var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8, var_10);

  if(maps\mp\_utility::_id_585F()) {
    var_13 = common_scripts\utility::_id_562E(self.ignorethiszerodamage);
    self.ignorethiszerodamage = undefined;

    if(var_13 && var_2 <= 0)
      return 0;
  }

  if(isDefined(var_1) && var_1 != self && var_2 > 0 && (!isDefined(var_8) || var_8 != "shield")) {
    if(var_3 &level.idflags_shield_explosive_impact)
      var_14 = "stun";
    else if(!maps\mp\gametypes\_damage::_id_8BB3(var_5))
      var_14 = "none";
    else {
      var_14 = "standard";

      if(isDefined(level._id_585D) && level._id_585D && isDefined(level._id_1E41))
        var_14 = [[level._id_1E41]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    }

    var_1 thread _id_04C7::_id_A102(var_14);
  }

  return self[[maps\mp\agents\_agent_utility::_id_0A59("on_damaged_finished")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_6A74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = isDefined(var_1) && isDefined(self._id_0117) && self._id_0117 == var_1;

  if(!level.teambased && var_11)
    return 0;

  maps\mp\gametypes\_damage::callback_playerdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_6A75(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self[[level._id_0A5D]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, 1);

  if(isPlayer(var_1) && (!isDefined(self._id_0117) || var_1 != self._id_0117) && (!isDefined(self._id_672C) || !self._id_672C))
    maps\mp\gametypes\_damage::_id_6B4B(var_1, var_4, var_3, var_2, "destroyed_squad_mate");

  if(isDefined(level._id_6A75))
    [[level._id_6A75]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  thread _id_0513::_id_34A9(var_1, var_3, var_4);

  if(self._id_565F) {
    self._id_4B60 = 1;

    if(maps\mp\_utility::getgametypenumlives() != 1 && (isDefined(self._id_7DAD) && self._id_7DAD))
      self thread[[maps\mp\agents\_agent_utility::_id_0A59("spawn")]]();
    else
      maps\mp\agents\_agent_utility::_id_2A73();
  }
}

_id_6AA3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(_id_048A::_id_4B8D()) {
    maps\mp\gametypes\_damage::_id_5C2D(var_2, var_3);

    if(!var_9) {
      var_10 = self _meth_8247(self getcurrentweapon());

      if(isDefined(var_10)) {
        var_10 thread _id_0513::_id_2D45();
        var_10._id_0117 = self;
        var_10._id_6DAF = var_1;
        var_10 _meth_80B3();
      }
    }
  }

  if(var_9)
    self thread[[level._id_A9C5]](var_1, var_3, var_4);

  self._id_18A8 = self _meth_8392(var_8);

  if(!maps\mp\gametypes\_damage::_id_8B8B(self))
    self._id_18A8 _meth_8028();
  else
    thread maps\mp\gametypes\_damage::_id_2CEC(self._id_18A8, var_6, var_5, var_4, var_0, var_3);

  _id_048A::_id_7E96();
}

_id_5331() {
  if(isDefined(self._id_231C))
    self.class = self._id_231C;
  else if(maps\mp\bots\_bots_loadout::_id_1ADE())
    self.class = "callback";
  else
    self.class = "class1";
}