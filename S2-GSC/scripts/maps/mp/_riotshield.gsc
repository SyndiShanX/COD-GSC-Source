/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_riotshield.gsc
*******************************************/

init() {
  level._id_7E95 = [];
  level._id_7E95[level._id_7E95.size] = "riotshield_mp";
}

_id_4B8C() {
  return isDefined(self._id_3EF6) || isDefined(self._id_14EA);
}

_id_4B8D() {
  return isDefined(self._id_3EF6);
}

_id_A9C9(var_0) {
  if(!isDefined(level._id_7E95)) {
    return 0;
  }

  var_1 = _getweaponbasename(var_0);

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  foreach(var_3 in level._id_7E95) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_45DD(var_0) {
  var_1 = 0;
  var_2 = self getweaponlistprimaries();

  foreach(var_4 in var_2) {
    if(_id_A9C9(var_4)) {
      if(var_4 == var_0 && !var_1) {
        var_1 = 1;
        continue;
      }

      return var_4;
    }
  }

  return undefined;
}

_id_A118(var_0, var_1) {
  self._id_3EF6 = undefined;
  self._id_14EA = undefined;

  if(!isDefined(var_0)) {
    var_0 = self getcurrentprimaryweapon();
  }

  if(_id_A9C9(var_0)) {
    self._id_3EF6 = _getweaponmodel(var_0);

    if(isDefined(self.riotshield_backpack) && self._id_267E[3] == 0) {
      self._id_267E[3] = self.riotshield_backpack;
      self _meth_84C7(self._id_267E, self.team, 1);
      self.riotshield_backpack = undefined;
    }
  }

  var_2 = _id_45DD(var_0);

  if(isDefined(var_2)) {
    self._id_14EA = _getweaponmodel(var_2);

    if(!isDefined(self.riotshield_backpack) && self._id_267E[3] != 0) {
      self.riotshield_backpack = self._id_267E[3];
    }

    if(isDefined(self.riotshield_backpack) && self._id_267E[3] != 0) {
      self._id_267E[3] = 0;
      self _meth_84C7(self._id_267E, self.team, 1);
    }
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self _meth_84D2(var_0, var_1);
}

_id_7E96() {
  self._id_3EF6 = undefined;
  self._id_14EA = undefined;
  self.riotshield_backpack = undefined;
}

_id_37C2() {
  if(!self islinked()) {
    return 0;
  }

  var_0 = self getlinkedtagname();

  if(!isDefined(var_0)) {
    return 0;
  }

  switch (var_0) {
    case "tag_inhand":
    case "tag_shield_back":
      return 1;
  }

  return 0;
}

_id_7E99() {
  if(_func_367() && getdvarint("spv_hub_riotshield_kswitch", 0) == 1) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");
  var_0 = undefined;
  self waittill("weapon_change", var_0);
  self notify("riotshield_change_weapon", var_0);
}

_id_7E9B() {
  if(_func_367() && getdvarint("spv_hub_riotshield_kswitch", 0) == 1) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("riotshield_change_weapon");
  var_0 = undefined;

  for(;;) {
    self waittill("weapon_switch_started", var_0);

    if(self isonladder()) {
      thread _id_7E9A();
      break;
    }

    if(isDefined(self._id_3EF6) && isDefined(self._id_14EA)) {
      wait 0.5;
      break;
    }
  }

  self notify("riotshield_change_weapon", var_0);
}

_id_7E9A() {
  if(_func_367()) {
    return;
  }
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self endon("weapon_change");

  while(self isonladder()) {
    waitframe();
  }

  self notify("riotshield_change_weapon", self getcurrentprimaryweapon());
}

_id_9BC6() {
  if(_func_367()) {
    if(getdvarint("spv_hub_riotshield_kswitch", 0) == 1) {
      return;
    }
    if(common_scripts\utility::_id_562E(self.activeshieldthread)) {
      return;
    }
    self.activeshieldthread = 1;
  }

  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  self notify("track_riot_shield");
  self endon("track_riot_shield");
  var_0 = 0;

  if(common_scripts\utility::_id_562E(self.hideshieldmodels)) {
    var_0 = 1;
  }

  _id_A118(self._id_2954, var_0);

  if(!_id_4B8C()) {
    if(_func_367()) {
      self.activeshieldthread = 0;
    }

    return;
  }

  self._id_5BC4 = "none";

  for(;;) {
    var_1 = self getcurrentweapon();
    thread _id_7E99();
    thread _id_7E9B();
    self waittill("riotshield_change_weapon", var_2);
    var_3 = 0;

    if(common_scripts\utility::_id_562E(self.hideshieldmodels)) {
      var_3 = 1;
    }

    if(_id_A9C9(var_2)) {
      if(_id_4B8C()) {
        if(isDefined(self._id_7EA3)) {
          self takeweapon(self._id_7EA3);
          self._id_7EA3 = undefined;
        }
      }

      if(_id_5832(var_1)) {
        self._id_5BC4 = var_1;
      }
    } else if(issubstr(var_2, "killstreak_uav") || issubstr(var_2, "super_soldier_syrum")) {
      continue;
    }
    _id_A15C(var_2, var_3);
  }
}

_id_A15C(var_0, var_1) {
  if(self ismantling() && var_0 == "none") {
    return;
  }
  _id_A118(var_0, var_1);
}

_id_5832(var_0) {
  if(maps\mp\_utility::iskillstreakweapon(var_0)) {
    return 0;
  }

  if(var_0 == "none") {
    return 0;
  }

  if(maps\mp\gametypes\_class::_id_5826(var_0, 1) || maps\mp\gametypes\_class::_id_5826(var_0, 0)) {
    return 0;
  }

  if(_id_A9C9(var_0)) {
    return 0;
  }

  if(weaponclass(var_0) == "ball") {
    return 0;
  }

  return 1;
}

_id_A93C(var_0, var_1) {
  var_0 endon("death");
  common_scripts\utility::_id_A70A("damageThenDestroyRiotshield", "death", "disconnect", "weapon_change", "deploy_riotshield");
  var_0 detonate(var_1);
}