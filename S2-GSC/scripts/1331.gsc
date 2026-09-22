/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1331.gsc
**************************************/

_id_7BCE(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4._id_52BC = var_1;
  var_4._id_6AF7 = var_2;
  var_4._id_6AED = var_3;
  level._id_7ED0[var_0] = var_4;
}

_id_7BA6() {
  _id_7BCE("role_ability_adrenaline_shot_mp", _id_052E::init, _id_052E::_id_3662, _id_052E::_id_2F9E);
  _id_7BCE("role_ability_steel_bib_mp", _id_0535::init, _id_0535::_id_3662, _id_0535::_id_2F9E);
  _id_7BCE("role_ability_extreme_conditioning_mp", _id_0531::init, _id_0531::_id_3662, _id_0531::_id_2F9E);
  _id_7BCE("role_ability_doron_vest_mp", _id_0530::init, _id_0530::_id_3662, _id_0530::_id_2F9E);
  _id_7BCE("role_ability_combat_focus_mp", _id_052F::init, _id_052F::_id_3662, _id_052F::_id_2F9E);
  _id_7BCE("role_ability_undercover_mp", _id_0536::init, _id_0536::_id_3662, _id_0536::_id_2F9E);
  _id_7BCE("role_ability_misinformation_mp", _id_0532::init, _id_0532::_id_3662, _id_0532::_id_2F9E);
  _id_7BCE("role_ability_self_revive_mp", _id_0534::init, _id_0534::_id_3662, _id_0534::_id_2F9E);
}

init() {
  self._id_7ED1 = [];
  level._id_7ED0 = [];

  if(isDefined(level._id_7BF5)) {
    level[[level._id_7BF5]]();
  } else {
    _id_7BA6();
  }

  foreach(var_1 in level._id_7ED0) {
    level thread[[var_1._id_52BC]]();
  }

  level thread onplayerconnect();
  setdvarifuninitialized("rolePowerGainOnDeathShouldCheckWasActive", 0);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!maps\mp\_utility::_id_585F()) {
      if(!isDefined(var_0.pers["roleRespawnPower"])) {
        var_0.pers["roleRespawnPower"] = 0;
      }
    }

    var_0 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    self._id_7ED1["activeOnDeath"] = 0;
    _id_7DF5();

    if(getdvarint("1936")) {
      thread _id_6B7A();
      thread _id_6B74();
      thread _id_6B98();
      thread _id_6B76();
    }
  }
}

_id_6B7A() {
  self endon("disconnect");
  self endon("spawned");
  self waittill("joined_team");
  _id_7D6B();
}

_id_6B74() {
  self endon("disconnect");
  self endon("spawned");
  self waittill("death");
  var_0 = self _meth_85BA("active");
  self._id_7ED1["activeOnDeath"] = var_0;
  self _meth_85BC();
  _id_942F();
}

_id_6B76() {
  self endon("disconnect");
  self endon("spawned");
  self endon("death ");
  var_0 = self _meth_85BA("ready");

  if(var_0) {
    return;
  }
  for(;;) {
    var_1 = self _meth_85BA("ready");
    var_2 = self _meth_85BA("active");

    if(!var_0 && (var_1 || var_2)) {
      if(maps\mp\_utility::_id_585F()) {
        _id_0378::_id_8D74("role_ready");
      } else {
        self playsoundtoplayer("ks_earn_dna_bomb", self, 1);
      }

      return;
    } else
      waitframe();
  }
}

_id_6B98() {
  self endon("disconnect");
  self endon("spawned");
  level waittill("game_ended");

  if(maps\mp\_utility::isroundbased() && !maps\mp\_utility::islastround()) {
    var_0 = self _meth_85BA("active");
    self._id_7ED1["activeOnDeath"] = var_0;
    self _meth_85BC();
    _id_942F();
  }
}

_id_3662(var_0) {
  if(!getdvarint("1936")) {
    return;
  }
  if(isDefined(self._id_7ED1) && isDefined(self._id_7ED1[var_0]) && self._id_7ED1[var_0] == 1) {
    _id_2F9E(var_0);
    return;
  }

  var_1 = level._id_7ED0[var_0];

  if(isDefined(var_1)) {
    self thread[[var_1._id_6AF7]]();
  } else {
    return;
  }

  self._id_7ED1[var_0] = 1;
  thread _id_2F94(var_0);
}

_id_2F9E(var_0) {
  if(!getdvarint("1936")) {
    return;
  }
  self notify("DisabledRoleAbility");
  self notify("DisabledRoleAbility_" + var_0);
  var_1 = level._id_7ED0[var_0];

  if(isDefined(var_1)) {
    self thread[[var_1._id_6AED]]();
  } else {
    return;
  }

  if(maps\mp\_utility::_id_585F()) {
    var_2 = self getentitynumber();
    _luinotifyeventextra(&"activate_special_teammate", 3, var_2, var_0, 0);
  }

  self._id_7ED1[var_0] = 0;
  _id_2408();
}

_id_2F94(var_0) {
  level endon("game_ended");
  self endon("DisabledRoleAbility");
  common_scripts\utility::_id_A70A("death", "disconnect", "joined_team", "joined_spectators");
  _id_2F9E(var_0);
}

_id_2408() {
  self _meth_85B9(-1);
}

_id_0F37(var_0, var_1, var_2) {
  if(isDefined(self.powerbuffamount)) {
    var_0 = var_0 * self.powerbuffamount;
  }

  if(var_0 > 0.0 && var_0 < 1.0 && isDefined(level._zmb_roles_positive_power_multiplier)) {
    var_0 = var_0 * level._zmb_roles_positive_power_multiplier;
  }

  if(!getdvarint("1936")) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(self.sessionstate == "dead") {
    if(isDefined(self.pers["roleRespawnPower"])) {
      var_3 = getdvarint("rolePowerGainOnDeathShouldCheckWasActive") == 1;

      if(var_3) {
        if(isDefined(self._id_7ED1["activeOnDeath"])) {
          var_4 = self._id_7ED1["activeOnDeath"];

          if(!var_4) {
            self.pers["roleRespawnPower"] = self.pers["roleRespawnPower"] + var_0;
            self _meth_85B9(var_0, var_1);
          }
        }
      } else {
        self.pers["roleRespawnPower"] = self.pers["roleRespawnPower"] + var_0;
        self _meth_85B9(var_0, var_1);
      }
    }
  } else {
    var_5 = self _meth_85BA("active");

    if(!var_5 || var_2) {
      self _meth_85B9(var_0, var_1);
    }
  }
}

_id_3F90() {
  if(!maps\mp\_utility::_id_585F()) {
    _id_0F37(0.07);
  }
}

_id_6BCF(var_0) {
  if(!maps\mp\_utility::_id_585F()) {
    _id_0F37(0.0425);
  }
}

_id_942F() {
  var_0 = self _meth_85BB();

  if(isDefined(self.pers["roleRespawnPower"])) {
    self.pers["roleRespawnPower"] = var_0;
  }
}

_id_7D6B() {
  if(isDefined(self.pers["roleRespawnPower"])) {
    self.pers["roleRespawnPower"] = 0;
  }
}

_id_7DF5() {
  if(isDefined(self.pers["roleRespawnPower"])) {
    self _meth_85B9(self.pers["roleRespawnPower"]);
  }
}