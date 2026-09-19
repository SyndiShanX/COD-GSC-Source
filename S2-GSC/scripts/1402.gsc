/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1402.gsc
**************************************/

_id_52A4() {
  _id_0561::initconsumablesfromtable("weapons", ::_id_A249, ::_id_1F8A, ::_id_472E);
}

_id_1F8A(var_0) {
  if(!_id_0561::_id_1F7B())
    return 0;

  if(!common_scripts\utility::_id_0668())
    return 0;

  if(!isDefined(self._id_4BA6) || !self._id_4BA6)
    return 1;

  if(isDefined(self._id_A9C1) && _id_259B(var_0) == self._id_A9C1)
    return 0;

  return 1;
}

_id_472E(var_0) {
  if(!isDefined(var_0))
    var_0 = "";

  switch (var_0) {
    case "epic":
      return 4;
    case "legendary":
      return 3;
    case "rare":
      return 2;
    case "common":
      return 1;
    default:
      return 0;
  }
}

_id_A249(var_0) {
  self endon("disconnect");
  self endon("begin_last_stand");
  var_1 = self._id_259F[var_0].name;
  _id_259C(var_1);
  thread _id_259E(var_1);
  level._id_400E[level._id_400E.size] = ["survivalist_set 3 -1", self];
  level._id_400E[level._id_400E.size] = ["survivalist_set 4 -1", self];
  self endon("weapon_consumable_used");
  childthread _id_A9A6();
  var_2 = 0;
  var_3 = common_scripts\utility::_id_A715("death", "weapon_consumable_timeout", "weapon_consumable_force_take");

  if(var_3 == "weapon_consumable_force_take")
    var_2 = 1;

  _id_259D(var_2);
}

_id_259E(var_0, var_1) {
  var_2 = consumable_getappendstring(var_0);

  if(!isDefined(var_1))
    var_1 = _id_A9A8();

  self _meth_82FF("ui_zm_" + var_2, gettime() + int(var_1 * 1000));
  thread maps\mp\gametypes\_hud_message::_id_9102("zm_consumable_" + var_2);
  thread consumable_uisplash_kill(var_0, var_1);
}

consumable_uisplash_kill(var_0, var_1) {
  self endon("weapon_consumable_timeout");
  self endon("death");
  var_2 = consumable_getappendstring(var_0);

  if(isDefined(var_1))
    common_scripts\utility::_id_A70D(var_1, self, "weapon_consumable_taken", self, "weapon_consumable_used");
  else
    common_scripts\utility::_id_A70A("weapon_consumable_taken", "weapon_consumable_used");

  self _meth_82FF("ui_zm_" + var_2, 0);
}

consumable_getappendstring(var_0) {
  switch (var_0) {
    case "consumable_zm_weapon_bazooka":
      return "bazooka";
    case "consumable_zm_weapon_panzerschreck":
      return "panzerschreck";
    case "consumable_zm_weapon_flamethrower":
      return "flamethrower";
    case "consumable_zm_weapon_ability":
      return "ability";
    case "consumable_zm_weapon_shield":
      return "shield";
    default:
      return "";
  }
}

_id_259B(var_0) {
  if(!isDefined(var_0))
    return "";

  switch (var_0) {
    case "consumable_zm_weapon_bazooka":
      return "bazooka_zm";
    case "consumable_zm_weapon_panzerschreck":
      return "panzerschreck_zm";
    case "consumable_zm_weapon_flamethrower":
      return "flamethrower_zm";
    default:
      return "";
  }
}

_id_259C(var_0) {
  self playlocalsound("zmb_pickup_general");

  if(_id_A260()) {
    if(isDefined(self._id_A9C1) && self _meth_8319(self._id_A9C1)) {
      _id_0586::_id_0790(self._id_A9C1);

      if(self._id_A9C1 == "flamethrower_zm")
        self detach("npc_usa_flamethrower_backpack");
    }

    self notify("weapon_consumable_used");
  } else
    self._id_5B98 = self _meth_8317();

  self._id_A9C1 = _id_259B(var_0);
  self._id_4BA6 = 1;
  _id_0586::_id_078C(self._id_A9C1);
  _id_0586::_id_078E(self._id_A9C1);
  thread _id_054E::playeruseconsumableweapon();

  if(self._id_A9C1 == "flamethrower_zm")
    self attach("npc_usa_flamethrower_backpack");

  childthread _id_A9B6();
  childthread weapon_switch_listener(self._id_A9C1);
}

_id_259D(var_0) {
  if(!_id_A260()) {
    return;
  }
  self._id_4BA6 = 0;

  if(common_scripts\utility::_id_562E(var_0))
    self notify("weapon_consumable_taken");

  var_1 = 0;
  var_2 = "";

  if(isDefined(self._id_5378) && self._id_5378 || var_0)
    var_1 = 1;

  if(!var_1) {
    if(isDefined(self._id_5B98) && self _meth_8319(self._id_5B98))
      var_2 = self._id_5B98;
    else {
      var_3 = self getweaponlistprimaries();

      foreach(var_5 in var_3) {
        if(!issubstr(var_5, "combatknife")) {
          var_2 = var_5;
          break;
        }
      }
    }

    _id_0586::_id_078E(var_2);
    self._id_5B98 = undefined;
  }

  if(self _meth_8319(self._id_A9C1))
    _id_0586::_id_0790(self._id_A9C1);

  if(self._id_A9C1 == "flamethrower_zm")
    self detach("npc_usa_flamethrower_backpack");

  self._id_A9C1 = undefined;
}

_id_A260() {
  return isDefined(self._id_4BA6) && self._id_4BA6;
}

_id_A9A6() {
  self endon("death");
  self endon("weapon_consumable_used");
  self endon("weapon_consumable_taken");
  var_0 = _id_A9A8();
  wait(var_0);
  self notify("weapon_consumable_timeout");
}

weapon_switch_listener(var_0) {
  self endon("death");
  self endon("weapon_consumable_used");
  self endon("weapon_consumable_taken");
  self endon("weapon_consumable_force_take");

  for(;;) {
    self waittill("weapon_change", var_1);

    if(_id_0547::_id_577E(self)) {
      return;
    }
    if(var_1 == var_0 || var_1 == "none") {
      continue;
    }
    if(_id_0547::_id_5865(var_1)) {
      continue;
    }
    break;
  }

  self notify("weapon_consumable_force_take");
}

_id_A9B6() {
  self endon("weapon_consumable_timeout");
  self endon("weapon_consumable_used");
  self endon("weapon_consumable_taken");
  self endon("death");
  var_0 = self._id_A9C1;

  for(;;) {
    self waittill("reload");
    var_1 = self getweaponammostock(var_0);

    if(var_1 == 0)
      self setweaponammostock(var_0, 1);
  }
}

_id_A9A8() {
  return 30 + _id_054A::_id_0633();
}