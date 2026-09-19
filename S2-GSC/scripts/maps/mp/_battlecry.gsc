/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_battlecry.gsc
******************************************/

init() {
  level endon("game_ended");
  setdvarifuninitialized("battlecry_enabled", 0);
  level._id_1648 = 0;
  level.battlecrymovespeedscale = 1.12;

  for(;;) {
    if(getdvarint("battlecry_enabled", 0) && level._id_1648 == 0) {
      level._id_1648 = 1;
      thread _id_A71F();
      return;
    }

    wait 1;
  }
}

_id_A71F() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(!isDefined(var_0._id_1643)) {
      var_0._id_1643 = 1;
      var_0._id_1647 = 1;

      if(!isbot(var_0)) {
        var_0._id_1645 = _newclienthudelem(var_0);
        var_0._id_1645.x = 0;
        var_0._id_1645.y = 0;
        var_0._id_1645.alignx = "left";
        var_0._id_1645.aligny = "top";
        var_0._id_1645._id_00C6 = "fullscreen";
        var_0._id_1645._id_01CA = "fullscreen";
        var_0._id_1645 setshader("combathigh_overlay", 640, 480);
        var_0._id_1645.alpha = 0.0;
        var_0._id_1645.color = (1, 1, 1);
        var_0._id_1645.sort = -3;
        var_0 notifyonplayercommand("activate_battlecry", "+actionslot 3");
      }

      var_0 thread _id_1646();
      var_0 thread _id_A88F();
      var_0 thread _id_49A0();
      var_0 thread _id_A735();
    }
  }
}

_id_1646() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self._id_1642 = 0;
    self._id_1649 = -1;
    self waittill("spawned_player");
  }
}

_id_A88F() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("activate_battlecry");

    if(self._id_1647) {
      self._id_1647 = 0;
      self._id_1642 = 1;

      foreach(var_1 in level.players) {
        if(self.team == var_1.team)
          var_1._id_1649 = 60;
      }

      self._id_1644 = _id_0479::_id_869E(self.team, "waypoint_escort", (0, 0, 90), 14, 14, 0, 0.05, 0, 1, 0, 0, "tag_origin");

      if(isDefined(self._id_1645))
        self._id_1645.alpha = 1.0;

      foreach(var_1 in level.players) {
        if(!isbot(var_1) && var_1.team == self.team) {
          var_1 iprintlnbold(&"MP_BATTLECRY_ACTIVE");
          var_1 playlocalsound("battlecry_use");
        }
      }
    }
  }
}

_id_49A0() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    if(self._id_1649 > 0) {
      if(isDefined(self._id_1645))
        self._id_1645.alpha = 1.0;

      self._id_1649 = self._id_1649 - 1;
      _id_0513::_id_A13B();

      if(!maps\mp\_utility::_hasperk("specialty_fastreload"))
        maps\mp\_utility::giveperk("specialty_fastreload");

      self._id_98E2 = 4.0;
      self._id_98E1 = 0.1;
      self notify("damage");
    } else if(self._id_1649 == 0) {
      if(isDefined(self._id_1645))
        self._id_1645.alpha = 0.0;

      _id_0513::_id_A13B();

      if(maps\mp\_utility::_hasperk("specialty_fastreload"))
        maps\mp\_utility::_id_0735("specialty_fastreload");

      self._id_98E2 = undefined;
      self._id_98E1 = undefined;
      self notify("damage");
      _id_3673();
      self._id_1649 = -1;
    }

    wait 1;
  }
}

_id_A735() {
  level endon("game_ended");

  for(;;) {
    common_scripts\utility::_id_A70A("disconnect", "death", "faux_spawn");

    if(isDefined(self))
      _id_3673();
  }
}

_id_3673() {
  self._id_1647 = 0;
  self._id_1642 = 0;
  self._id_1649 = 0;

  if(isDefined(self._id_1644))
    self._id_1644 destroy();
}

_id_1647() {
  self iprintlnbold(&"MP_BATTLECRY_READY");
  self playlocalsound("battlecry_use");
  self._id_1647 = 1;
}

_id_164A() {
  level endon("game_ended");
  self endon("disconnect");
  thread _id_A7F9();
}

_id_A7F9() {
  level endon("game_ended");
  self endon("disconnect");
  thread _id_6511();
}

_id_3209() {
  level endon("game_ended");
  self endon("disconnect");
  thread _id_3212();
}

_id_6511() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("updateRecentKills");
    waitframe();

    if(self._id_7AD2 > 1 && self._id_1642 == 0 && self._id_1647 == 0)
      _id_1647();
  }
}

_id_6633() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    common_scripts\utility::_id_A70A("neardeath_battlecry");

    if(self._id_1642 == 0 && self._id_1647 == 0)
      _id_1647();
  }
}

_id_7B43() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    common_scripts\utility::_id_A70A("recovery_battlecry");

    if(self._id_1642 == 0 && self._id_1647 == 0)
      _id_1647();
  }
}

_id_9EA2() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("turned_on_battlecry");

    if(self._id_1642 == 0 && self._id_1647 == 0)
      _id_1647();
  }
}

_id_3212() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("dominated_battlecry");

    if(isDefined(self.team) && maps\mp\gametypes\dom::_id_46CC(maps\mp\_utility::getotherteam(self.team)) == level._id_3CC5.size && self._id_1642 == 0 && self._id_1647 == 0)
      _id_1647();

    waitframe();
  }
}