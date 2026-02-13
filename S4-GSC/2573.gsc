/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2573.gsc
*************************************************/

_id_61A6(var_0) {
  self endon("disconnect");
  var_0 endon("death");
  scripts\mp\utility\print::_id_BD15("gasGrenade spawn", var_0.owner);
  thread scripts\mp\weapons::_id_A106(self, var_0);
  var_0 waittill("missile_stuck", var_1);
  thread _id_61AB(var_0);
  var_0 detonate();
}

_id_61AB(var_0) {
  var_0 thread scripts\mp\utility\script::_id_A695("death", "end_explode");
  var_0 endon("end_explode");
  var_1 = var_0.owner;
  var_0 waittill("explode", var_2);
  thread _id_6157(var_2, var_1);
}

_id_6188(var_0) {
  if(var_0._id_9CD6 == "MOD_IMPACT") {
    return 1;
  }

  if(scripts\mp\utility\perk::_hasperk("specialty_gasmask")) {
    return 0;
  }

  if(var_0.attacker == var_0._id_103C2) {
    if(distancesquared(var_0.point, var_0._id_103C2.origin) > 30625) {
      return 0;
    }
  } else {
    var_0.attacker _id_07C3::_id_3AC3("equip_gas_grenade");
    var_0.attacker scripts\mp\utility\stats::_id_7DAE("gasHits", 1);

    if(var_0._id_103C2 scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
      var_0.attacker _id_07C4::_id_FC47("hittacresist", undefined, undefined, undefined, 1);
    }
  }

  var_0._id_103C2 thread _id_613D(var_0.attacker, 1);
  return 1;
}

_id_614F(var_0) {
  _id_6152(var_0);
  _id_6150(var_0);
  _id_6151(var_0);

  if(isDefined(self._id_61DD)) {
    foreach(var_2 in self._id_61DD) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_2._id_B7C0[self getentitynumber()] = undefined;
    }
  }

  self._id_61DD = undefined;
}

_id_6157(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 4.5;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = spawn("trigger_radius", var_0 + (0, 0, int(-57.75 * var_3)), 0, int(256 * var_3), int(175 * var_3));
  var_4 _id_078E::_id_C2B5(1, ::_id_EC15);
  var_4 endon("death");
  var_4.owner = var_1;

  if(isDefined(var_1)) {
    var_4.team = var_1.team;
  }

  var_4._id_B7C0 = [];
  var_4 thread _id_61AC();
  var_4 thread _id_61AD();
  wait(var_2);
  var_4 thread _id_6159();
}

_id_EC15() {
  thread _id_6159();
}

_id_6159() {
  foreach(var_1 in self._id_B7C0) {
    if(!isDefined(var_1)) {
      continue;
    }
    self._id_B7C0[var_1 getentitynumber()] = undefined;
    var_1 thread _id_6187(self getentitynumber());
  }

  _id_078E::_id_4807();
  self delete();
}

_id_6186(var_0) {
  if(!isDefined(self._id_61DD)) {
    self._id_61DD = [];
  }

  var_1 = var_0 getentitynumber();
  self._id_61DD[var_1] = var_0;
  var_2 = var_0.owner;

  if(isDefined(var_2) && var_2 scripts\mp\utility\perk::_hasperk("specialty_tactical_outline")) {
    _id_0A6B::_id_ACF0(var_2, var_0);
  }

  self._id_8FDB = gettime();

  if(self._id_61DD.size >= 1) {
    thread _id_613E();
    thread _id_613C();
  }

  if(self._id_61DD.size == 1) {
    thread _id_613D(var_0.owner, 0);
    _id_09BE::_id_525A();
  }

  scripts\mp\utility\player::_id_3A20("gas", -1);
  return var_1;
}

_id_6187(var_0, var_1) {
  if(!isDefined(self._id_61DD)) {
    return;
  }
  if(isDefined(var_1)) {
    var_2 = var_1.owner;

    if(isDefined(var_2) && var_2 scripts\mp\utility\perk::_hasperk("specialty_tactical_outline")) {
      self notify("gasExit", var_1.owner);
    }
  }

  self._id_61DD[var_0] = undefined;
  self._id_8FDB = gettime();

  if(self._id_61DD.size == 0) {
    scripts\mp\utility\player::_id_3A20("gas", 0);
    thread _id_6196();
    thread _id_6194();
    _id_09BE::_id_4ACA();
    self notify("gas_exited");
  }
}

_id_61AC() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0 scripts\mp\utility\killstreak::_id_88DF()) {
      continue;
    }
    if(var_0 scripts\mp\utility\perk::_hasperk("specialty_gasmask")) {
      continue;
    }
    if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self._id_B7C0[var_0 getentitynumber()])) {
      continue;
    }
    if(level.teambased) {
      if(isDefined(self.owner)) {
        if(var_0 != self.owner && !scripts\cp_mp\utility\player_utility::_id_B78C(var_0, self.owner)) {
          continue;
        }
      } else if(isDefined(self.team) && scripts\mp\utility\player::_id_886C(self.team, var_0))
        continue;
    }

    self._id_B7C0[var_0 getentitynumber()] = var_0;
    var_0 thread _id_6186(self);
  }
}

_id_61AD() {
  self endon("death");

  for(;;) {
    foreach(var_2, var_1 in self._id_B7C0) {
      if(!isDefined(var_1)) {
        self._id_B7C0[var_2] = undefined;
        continue;
      }

      if(!var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(var_1 istouching(self)) {
        continue;
      }
      self._id_B7C0[var_1 getentitynumber()] = undefined;
      var_1 thread _id_6187(self getentitynumber(), self);
    }

    waitframe();
  }
}

_id_613D(var_0, var_1) {
  var_2 = self _meth_849A();

  if(var_2) {
    return;
  }
  var_3 = scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist");
  var_4 = isDefined(var_0) && self == var_0;

  if(!var_4 && var_3) {
    return;
  }
  var_5 = 0;

  if(istrue(var_1)) {
    var_5 = 1;

    if(var_4) {
      var_5 = 0;
    }
  }

  if(!istrue(self._id_61CB) || istrue(var_1)) {
    thread _id_6193(var_5);
  }
}

_id_6193(var_0) {
  self endon("death_or_disconnect");
  self endon("gas_clear_cough");
  self endon("gas_exited");
  self notify("gas_queue_cough");
  self endon("gas_queue_cough");
  var_1 = gettime() + 1000;

  while(_id_6153()) {
    waitframe();
  }

  if(var_0 && gettime() > var_1) {
    var_0 = 0;
  }

  var_2 = getdvarint("#x369da023837e800f", 1) == 1;

  if(var_2) {
    thread _id_6147(var_0);
  } else {
    self endon("gas_begin_coughing");
    self._id_61CB = 1;

    if(var_0) {
      self _meth_8493("iw8_ges_teargas_cough");
      wait 1.2;
    } else {
      self _meth_8493("iw8_ges_teargas_cough_long");
      wait 0.8;
    }

    self._id_61CB = undefined;
  }
}

_id_6147(var_0) {
  self endon("death_or_disconnect");
  self endon("gas_clear_cough");
  self notify("gas_begin_coughing");
  self endon("gas_begin_coughing");

  if(!isnullweapon(self getheldoffhand())) {
    childthread _id_61A2();
  }

  self._id_61CB = 1;

  if(self hasweapon(makeweapon("s4_gas_cough_light_mp"))) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_gas_cough_light_mp");
  }

  if(self hasweapon(makeweapon("s4_gas_cough_heavy_mp"))) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_gas_cough_heavy_mp");
  }

  var_1 = scripts\engine\utility::ter_op(istrue(var_0), makeweapon("s4_gas_cough_heavy_mp"), makeweapon("s4_gas_cough_light_mp"));
  var_2 = scripts\engine\utility::ter_op(istrue(var_0), 1.2, 0.8);
  self _meth_852A(var_1);
  childthread _id_6183(var_1);
  childthread _id_6184(var_1);
  childthread _id_6182(var_2);
  scripts\engine\utility::waittill_any_3("gas_coughWeaponFired", "gas_coughWeaponTaken", "gas_coughDuration");

  if(self hasweapon(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
  }

  self._id_61CB = undefined;
}

_id_6195(var_0) {
  self notify("gas_queue_cough");
  self notify("gas_begin_coughing");
  self._id_61CB = undefined;

  if(!istrue(var_0)) {
    if(isDefined(self._id_61DC)) {
      _id_6197();
    }
  }
}

_id_6151(var_0) {
  self notify("gas_queue_cough");
  self notify("gas_begin_coughing");
  self._id_61CB = undefined;

  if(!istrue(var_0)) {
    var_1 = getdvarint("#x369da023837e800f", 1) == 1;

    if(var_1) {
      if(self hasweapon(makeweapon("s4_gas_cough_light_mp"))) {
        scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_gas_cough_light_mp");
      }

      if(self hasweapon(makeweapon("s4_gas_cough_heavy_mp"))) {
        scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_gas_cough_heavy_mp");
      }

      if(isDefined(self._id_61DC)) {
        _id_6197();
      }
    } else {
      self _meth_8494("iw8_ges_teargas_cough");
      self _meth_8494("iw8_ges_teargas_cough_long");
    }
  }
}

_id_6183(var_0) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughDuration");

  for(;;) {
    self waittill("offhand_fired", var_1);

    if(issameweapon(var_1, var_0)) {
      break;
    }
  }

  self notify("gas_coughWeaponFired");
}

_id_6184(var_0) {
  self endon("gas_coughWeaponFired");
  self endon("gas_coughDuration");

  while(self hasweapon(var_0)) {
    waitframe();
  }

  self notify("gas_coughWeaponTaken");
}

_id_6182(var_0) {
  self endon("gas_coughWeaponTaken");
  self endon("gas_coughWeaponFired");
  wait(var_0);
  self notify("gas_coughDuration");
}

_id_61A2() {
  if(isDefined(self._id_61DC)) {
    _id_6197();
  }

  self endon("gas_restoreHeldOffhand");
  self._id_61DC = self getheldoffhand();
  var_0 = scripts\mp\equipment::_id_6A14(self._id_61DC);

  if(isDefined(var_0) && scripts\mp\equipment::_id_755B(var_0)) {
    self._id_61DB = scripts\mp\equipment::_id_6A0F(var_0);
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_61DC);
    waitframe();
    thread _id_6197();
  }

  var_1 = scripts\mp\supers::_id_6DA5(self._id_61DC);

  if(isDefined(var_1)) {
    var_2 = scripts\mp\supers::_id_69B0();

    if(isDefined(var_2) && var_2 == var_1) {
      self._id_61DB = self _meth_8109(self._id_61DC);
      scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_61DC);
      waitframe();
      thread _id_6197();
    }
  }

  var_3 = scripts\mp\utility\weapon::_id_887A(self._id_61DC);

  if(var_3) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_61DC);
    waitframe();
    thread _id_6197();
  }

  self._id_61DB = self _meth_8109(self._id_61DC);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_61DC);
  waitframe();
  thread _id_6197();
}

_id_6197() {
  self notify("gas_restoreHeldOffhand");
  var_0 = scripts\mp\equipment::_id_6A14(self._id_61DC);

  if(isDefined(var_0) && scripts\mp\equipment::_id_755B(var_0)) {
    if(scripts\mp\equipment::_id_755B(var_0)) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self._id_61DC);
      var_1 = scripts\mp\equipment::_id_5AEA(var_0);

      if(var_1 == "primary") {
        self _meth_849C(self._id_61DC);
      } else if(var_1 == "secondary") {
        self _meth_849D(self._id_61DC);
      }

      scripts\mp\equipment::_id_D543(var_0, self._id_61DB);
      self._id_61DC = undefined;
      self._id_61DB = undefined;
    }

    return;
  }

  var_2 = scripts\mp\supers::_id_6DA5(self._id_61DC);

  if(isDefined(var_2)) {
    var_3 = scripts\mp\supers::_id_69B0();

    if(isDefined(var_3) && var_3 == var_2) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self._id_61DC);
      self _meth_84E9(self._id_61DC);
      self setweaponammoclip(self._id_61DC, self._id_61DB);
      self._id_61DC = undefined;
      self._id_61DB = undefined;
    }

    return;
  }

  var_4 = scripts\mp\utility\weapon::_id_887A(self._id_61DC);

  if(var_4) {
    if(isDefined(self._id_62F1) && self._id_62F1 == self._id_61DC.basename) {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(self._id_61DC);
      self._id_61DC = undefined;
    }

    return;
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(self._id_61DC);
  self setweaponammoclip(self._id_61DC, self._id_61DB);
  self._id_61DC = undefined;
  self._id_61DB = undefined;
}

_id_613E() {
  self endon("death_or_disconnect");
  self notify("gas_modify_speed");
  self endon("gas_modify_speed");

  if(isDefined(self._id_61DA)) {
    if(self._id_61DA < -0.1) {
      if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
        self._id_61DA = -0.1;
        scripts\mp\weapons::_id_FCCC();
        return;
      }

      if(isDefined(self._id_61DD)) {
        foreach(var_1 in self._id_61DD) {
          if(isDefined(var_1) && isDefined(var_1.owner) && var_1.owner == self) {
            self._id_61DA = -0.1;
            scripts\mp\weapons::_id_FCCC();
            return;
          }
        }
      }
    }
  } else
    self._id_61DA = 0;

  var_3 = -0.3;

  if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
    var_3 = -0.1;
  } else if(scripts\mp\utility\perk::_hasperk("specialty_dauntless")) {
    var_3 = 0;
  } else if(isDefined(self._id_61DD)) {
    foreach(var_1 in self._id_61DD) {
      if(isDefined(var_1) && isDefined(var_1.owner) && var_1.owner == self) {
        var_3 = -0.1;
      }
    }
  }

  _id_6181(var_3);
  self._id_61DA = var_3;
  scripts\mp\weapons::_id_FCCC();
}

_id_6196() {
  self endon("death_or_disconnect");
  self notify("gas_modify_speed");
  self endon("gas_modify_speed");

  if(!isDefined(self._id_61DA)) {
    return;
  }
  _id_6181(0);
  self._id_61DA = undefined;
  scripts\mp\weapons::_id_FCCC();
}

_id_6181(var_0) {
  var_1 = 0;

  while(var_1 <= 0.45) {
    var_1 = var_1 + 0.05;
    self._id_61DA = scripts\engine\math::_id_91A9(self._id_61DA, var_0, min(1, var_1 / 0.45));
    scripts\mp\weapons::_id_FCCC();
    wait 0.05;
  }
}

_id_6152(var_0) {
  self notify("gas_modify_speed");
  self._id_61DA = undefined;

  if(!istrue(var_0)) {
    scripts\mp\weapons::_id_FCCC();
  }
}

_id_613C() {
  self endon("death_or_disconnect");
  self notify("gas_modify_blur");
  self endon("gas_modify_blur");
  var_0 = "gas_grenade_heavy_mp";

  if(scripts\mp\utility\perk::_hasperk("specialty_gas_grenade_resist")) {
    var_0 = "gas_grenade_light_mp";
  } else if(isDefined(self._id_61DD)) {
    foreach(var_2 in self._id_61DD) {
      if(isDefined(var_2) && isDefined(var_2.owner) && var_2.owner == self) {
        var_0 = "gas_grenade_light_mp";
      }
    }
  }

  for(;;) {
    _id_09C8::_id_0CF9(var_0, "gas", 0.4, 0);
    wait 0.2;
  }
}

_id_6194() {
  self notify("gas_modify_blur");
}

_id_6150(var_0) {
  self notify("gas_modify_blur");

  if(!istrue(var_0)) {
    _id_09C8::_id_0D89();
  }
}

_id_6198() {
  switch (self getheldoffhand().basename) {
    case "s4_super_delay_mp":
      return 0;
    default:
      return 1;
  }

  return 0;
}

_id_6153() {
  if(!scripts\common\utility::_id_8586()) {
    return 1;
  }

  if(!scripts\common\utility::_id_8650()) {
    return 1;
  }

  if(!isnullweapon(self getheldoffhand()) && !_id_6198()) {
    return 1;
  }

  return 0;
}

_id_616D() {
  if(!isDefined(self._id_61DD)) {
    return 0;
  }

  if(self._id_61DD.size == 0) {
    return 0;
  }

  return 1;
}

_id_61A5() {
  if(scripts\mp\utility\killstreak::_id_88DF() || scripts\mp\utility\perk::_hasperk("specialty_gasmask")) {
    _id_614F();
    return;
  }

  if(_id_616D()) {
    thread _id_613E();
    thread _id_613C();
  }
}

_id_616B(var_0) {
  return 200.0;
}