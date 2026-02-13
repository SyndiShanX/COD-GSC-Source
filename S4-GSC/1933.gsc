/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1933.gsc
*************************************************/

_id_5181() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "init")]]();
  }
}

_id_19B8(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.attacker = var_0;
  var_2._id_103C2 = self;
  var_2.objweapon = var_1;
  _id_19B9(var_2);
}

_id_19B9(var_0) {
  if(!isDefined(var_0.damage)) {
    var_0.damage = 1;
  }

  if(!isDefined(var_0._id_9CD6)) {
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  if(!isDefined(var_0.point)) {
    var_0.point = (0, 0, 0);
  }

  if(!isDefined(var_0._id_49CA)) {
    var_0._id_49CA = (0, 0, 0);
  }

  if(!isDefined(var_0.modelname)) {
    var_0.modelname = 0;
  }

  if(!isDefined(var_0._id_031A)) {
    var_0._id_031A = "";
  }

  if(!isDefined(var_0._id_047C)) {
    var_0._id_047C = 0;
  }

  if(!isDefined(var_0._id_4304)) {
    var_0._id_4304 = 0;
  }

  if(!isDefined(var_0._id_79A8)) {
    var_0._id_79A8 = "none";
  }

  if(!isDefined(var_0._id_F21F)) {
    var_0._id_F21F = 0;
  }

  if(!isDefined(var_0._id_103C2._id_5191)) {
    var_0._id_103C2._id_5191 = 0;
  }

  var_0._id_103C2._id_5191++;

  if(var_0._id_103C2._id_5191 == 1) {
    if(isPlayer(var_0._id_103C2)) {
      var_0._id_103C2 thread _id_E5D0(var_0);
    }

    if(isDefined(var_0._id_103C2._id_51C1)) {
      var_0._id_103C2 thread[[var_0._id_103C2._id_51C1]](var_0);
    }

    var_0._id_103C2 notify("emp_started", var_0);
  }

  if(isDefined(var_0._id_103C2._id_518F)) {
    var_0._id_103C2 thread[[var_0._id_103C2._id_518F]](var_0);
  }

  var_0._id_103C2 notify("emp_applied", var_0);
}

_id_C3AE() {
  self._id_5191--;

  if(isDefined(self._id_51BC)) {
    self thread[[self._id_51BC]]();
  }

  self notify("emp_removed");

  if(self._id_5191 == 0) {
    _id_38CB(0);
  }
}

_id_38CB(var_0) {
  if(isDefined(self._id_5191)) {
    self._id_5191 = undefined;

    if(isPlayer(self)) {
      thread _id_E890(istrue(var_0));
    } else if(isDefined(self._id_5190)) {
      self thread[[self._id_5190]](istrue(var_0));
    }

    self notify("emp_cleared");
  }
}

_id_85B2(var_0) {
  var_1 = 0;

  switch (var_0.basename) {
    case "emp_grenade_mp":
      var_1 = 1;
  }

  return var_1;
}

_id_85B1(var_0, var_1) {
  if(!_id_85B2(var_0)) {
    return 0;
  }

  if(!_func_010F(var_1)) {
    return 0;
  }

  return 1;
}

_id_1538(var_0) {
  if(isPlayer(self)) {
    _id_1539(var_0);
  } else {
    if(!isDefined(self._id_51B9)) {
      self._id_51B9 = 0;
    }

    if(var_0) {
      self._id_51B9--;
    } else {
      self._id_51B9++;
    }
  }
}

_id_30B7() {
  if(isPlayer(self)) {
    return _id_30C2();
  } else if(istrue(self._id_57CE)) {
    return 0;
  } else if(istrue(self._id_51B9)) {
    return 0;
  }

  return 1;
}

_id_85B3() {
  return isDefined(self._id_5191) && self._id_5191 > 0;
}

_id_646E() {
  var_0 = _id_5187();
  _id_518E();
  return var_0._id_5527;
}

_id_D15E(var_0) {
  self._id_518F = var_0;
}

_id_D3BA(var_0) {
  self._id_51C1 = var_0;
}

_id_D387(var_0) {
  self._id_51BC = var_0;
}

_id_D189(var_0) {
  self._id_5190 = var_0;
}

_id_0FD1(var_0) {
  var_1 = _id_5187();
  var_2 = var_0 getentitynumber();
  var_1._id_5526[var_2] = var_0;
  return var_2;
}

_id_B21E(var_0) {
  if(var_0 == 0) {
    return;
  }
  if(!isDefined(self._id_51BE)) {
    self._id_51BE = [];
  }

  var_1 = self._id_51BE[var_0];

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  self._id_51BE[var_0] = var_1 + 1;
  _id_0DA3();
}

_id_E891(var_0) {
  if(var_0 == 0) {
    return;
  }
  self._id_51BE[var_0] = self._id_51BE[var_0] - 1;

  if(self._id_51BE[var_0] == 0) {
    self._id_51BE[var_0] = undefined;
  }

  _id_0DA3();
}

_id_0DA3() {
  var_0 = 0;

  foreach(var_3, var_2 in self._id_51BE) {
    if(var_3 > var_0) {
      var_0 = var_3;
    }
  }

  self setclientomnvar("ui_scrambler_strength", var_0);
}

_id_B2B4(var_0, var_1) {
  var_0 _id_B21E(var_1);
  scripts\engine\utility::waittill_any_2("emp_cleared", "death");

  if(isDefined(var_0)) {
    var_0 _id_E891(var_1);
  }
}

_id_1539(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "setPlayerEMPImmune")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "setPlayerEMPImmune")]](var_0);
  }
}

_id_30C2() {
  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "getPlayerEMPImmune")) {
    return ![[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "getPlayerEMPImmune")]]();
  }

  return 1;
}

_id_E5D0(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("emp", "onPlayerEMPed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("emp", "onPlayerEMPed")]](var_0);
  }

  self _meth_830E(1);
  scripts\common\utility::_id_154F(0, "emp");
  scripts\common\utility::_id_1587(0, "emp");
}

_id_E890(var_0) {
  self _meth_830E(0);

  if(!var_0) {
    scripts\common\utility::_id_154F(1, "emp");
    scripts\common\utility::_id_1587(1, "emp");
  }
}

_id_518C() {
  var_0 = spawnStruct();
  level._id_517F = var_0;
  level._id_517F._id_5526 = [];
}

_id_5187() {
  if(!isDefined(level._id_517F)) {
    _id_518C();
  }

  return level._id_517F;
}

_id_518E() {
  var_0 = _id_5187();
  var_1 = [];

  foreach(var_3 in var_0._id_5526) {
    if(isDefined(var_3) && var_3 _id_30B7()) {
      var_1[var_1.size] = var_3;
    }
  }

  foreach(var_6 in level._id_9EE2) {
    if(isDefined(var_6) && var_6 _id_30B7()) {
      var_1[var_1.size] = var_6;
    }
  }

  var_8 = getEntArray("misc_turret", "classname");

  foreach(var_10 in var_8) {
    if(isDefined(var_10) && var_10 _id_30B7()) {
      var_1[var_1.size] = var_10;
    }
  }

  if(isDefined(level._id_0F4C)) {
    foreach(var_13 in level._id_0F4C) {
      if(isDefined(var_13) && var_13 _id_30B7()) {
        var_1[var_1.size] = var_13;
      }
    }
  }

  if(isDefined(level.vehicle)) {
    foreach(var_16 in level.vehicle._id_8300) {
      foreach(var_18 in var_16) {
        if(isDefined(var_18) && var_18 _id_30B7()) {
          var_1[var_1.size] = var_18;
        }
      }
    }
  }

  if(isDefined(level._id_4541)) {
    foreach(var_22 in level._id_4541) {
      if(isDefined(var_22) && var_22 _id_30B7()) {
        var_1[var_1.size] = var_22;
      }
    }
  }

  foreach(var_25 in level.players) {
    if(!isPlayer(var_25) && var_25 _id_30B7()) {
      var_1[var_1.size] = var_25;
    }
  }

  var_0._id_5527 = var_1;
  thread _id_518D();
}

_id_518D() {
  var_0 = _id_5187();
  waittillframeend;
  var_0._id_5527 = undefined;
}