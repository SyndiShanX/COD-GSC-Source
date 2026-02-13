/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2567.gsc
*************************************************/

_id_4539() {
  level._id_4541 = [];
  var_0 = spawnStruct();
  level._id_4540 = var_0;
  var_0._id_5B94 = [];
  var_0._id_5B95 = [];
  var_0._id_5B92 = [];
  var_0._id_5B7C = [];
  var_0._id_5B79 = [];
  var_0._id_5B78 = [];
  var_0._id_5B80 = [];
  var_0._id_5B7E = [];
  var_0._id_5B7F = [];
  var_0._id_5B7D = [];
  var_0._id_5B94[var_0._id_5B94.size] = "ar";
  var_0._id_5B95["ar"] = 35;
  var_0._id_5B92["ar"] = 0.4;
  var_0._id_5B7C["ar"] = 3;
  var_0._id_5B79["ar"] = 0.5;
  var_0._id_5B78["ar"] = 2;
  var_0._id_5B80["ar"] = 175;
  var_0._id_5B7E["ar"] = 225;
  var_0._id_5B7F["ar"] = 55;
  var_0._id_5B7D["ar"] = 125;
  var_0._id_5B94[var_0._id_5B94.size] = "smg";
  var_0._id_5B95["smg"] = 50;
  var_0._id_5B92["smg"] = 0.4;
  var_0._id_5B7C["smg"] = 4;
  var_0._id_5B79["smg"] = 0.25;
  var_0._id_5B78["smg"] = 1;
  var_0._id_5B80["smg"] = 80;
  var_0._id_5B7E["smg"] = 125;
  var_0._id_5B7F["smg"] = 175;
  var_0._id_5B7D["smg"] = 265;
  var_0._id_5B94[var_0._id_5B94.size] = "sniper";
  var_0._id_5B95["sniper"] = 15;
  var_0._id_5B92["sniper"] = 0.4;
  var_0._id_5B7C["sniper"] = 2;
  var_0._id_5B79["sniper"] = 1;
  var_0._id_5B78["sniper"] = 3;
  var_0._id_5B80["sniper"] = 250;
  var_0._id_5B7E["sniper"] = 375;
  var_0._id_5B7F["sniper"] = 0;
  var_0._id_5B7D["sniper"] = 60;
}

_id_453F(var_0) {
  var_0 endon("death");
  scripts\mp\utility\print::_id_BD15("decoy grenade spawn", var_0.owner);
  var_0._id_B794 = [];
  var_0 _id_078D::_id_D15E(::_id_452E);
  var_0 _id_078D::_id_1538(0);
  _id_4529(var_0);
  thread scripts\mp\weapons::_id_A106(self, var_0);
  wait 0.4;
  var_0 _id_078D::_id_1538(1);
  var_0 thread _id_07C3::_id_A0FF(19, "hitequip", ::_id_4538, ::_id_4537);
  var_0 thread _id_453D();
  wait 0.6;
  var_1 = gettime() + 5000;
  var_2 = gettime();
  var_3 = 3;

  while(gettime() < var_1) {
    if(gettime() >= var_2) {
      var_2 = gettime() + 200.0;

      if(var_0 _id_453A()) {
        var_3--;

        if(var_3 == 0) {
          break;
        }
      } else
        var_3 = 3;
    }

    wait 0.2;
  }

  var_0 thread _id_453C();
  var_0 thread _id_4528();
}

_id_4528() {
  self endon("death");
  self setotherent(self.owner);
  self setscriptablepartstate("beacon", "active", 0);
  var_0 = _id_4533();

  for(;;) {
    _id_4530(var_0);
    wait(randomfloatrange(1.5, 3.5));
  }
}

_id_452D() {
  self setscriptablepartstate("destroy", "active", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread _id_452C(0.1);
}

_id_452C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  self notify("death");
  self._id_57CE = 1;
  _id_453E(self getentitynumber());
  _id_07C3::_id_A100();
  wait(var_0);
  self delete();
}

_id_4530(var_0) {
  var_1 = _id_4534();
  var_2 = 1 + randomint(var_1._id_5B7C[var_0]);

  for(;;) {
    var_2--;
    _id_452F(var_0);

    if(var_2 == 0) {
      break;
    }

    wait(randomfloatrange(var_1._id_5B79[var_0], var_1._id_5B78[var_0]));
  }
}

_id_452F(var_0) {
  var_1 = _id_4535();
  var_2 = _id_4531(var_1);
  var_3 = _id_4532(var_1, var_0, var_2);
  var_4 = self.owner getheldoffhand();

  if(!isDefined(var_4) || var_4.basename != "s4_frag_usa_mk2_mp") {
    self.owner scripts\mp\utility\weapon::_id_0C48("s4_decoy_grenade_mp", self.origin + (0, 0, 10), var_3, 100, 1, self);
  }

  self setCanDamage(1);
  self setscriptablepartstate("beacon", "active", 0);
  self setscriptablepartstate("weaponFire", var_0 + "Fire", 0);
  var_5 = "wpn_grenade_decoy_ar_fire";

  switch (var_0) {
    case "ar":
      var_5 = "wpn_grenade_decoy_ar_fire";
      break;
    case "smg":
      var_5 = "wpn_grenade_decoy_smg_fire";
      break;
    case "sniper":
      var_5 = "wpn_grenade_decoy_sniper_fire";
      break;
  }

  playsoundatpos(self.origin, var_5);
  _func_0252(self.origin, self.team, self.owner);
  _id_452A();
  var_6 = _id_4534();
  wait(var_6._id_5B92[var_0]);
}

_id_452A() {
  var_0 = scripts\common\utility::_id_B7B6(self.origin, 800);

  foreach(var_2 in var_0) {
    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(!istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_2))) {
      continue;
    }
    thread _id_452B(var_2);
    self.owner _id_07C3::_id_3AC3("equip_decoy");
    self.owner scripts\mp\utility\stats::_id_7DAE("decoyHits", 1);
  }
}

_id_452B(var_0) {
  var_0 endon("disconnect");
  var_1 = self.owner;
  var_1 endon("disconnect");
  self notify("decoy_debuffEnemy_" + var_0 getentitynumber());
  self endon("decoy_debuffEnemy_" + var_0 getentitynumber());

  if(!isDefined(self._id_B794[var_0 getentitynumber()])) {
    self._id_B794[var_0 getentitynumber()] = var_0;
  }

  var_2 = var_0 scripts\engine\utility::_id_108F7("death", 5);

  if(isDefined(self)) {
    self._id_B794[var_0 getentitynumber()] = undefined;
  }

  if(isDefined(var_0._id_8FFD) && var_0._id_8FFD != var_1) {
    if(var_2 == "death" && scripts\cp_mp\utility\player_utility::_id_B78C(var_0, var_1)) {
      var_1 thread _id_0A9F::_id_7003("assist_decoy");
    }
  }
}

_id_453D() {
  self endon("death");

  for(;;) {
    var_0 = self.origin;
    waitframe();
    self._id_AA38 = var_0;
  }
}

_id_453C() {
  self endon("death");
  wait 15;
  thread _id_452D();
}

_id_452E(var_0) {
  var_0._id_103C2 _id_4536(var_0.attacker);
  var_0._id_103C2 thread _id_452D();
}

_id_4537(var_0) {
  scripts\mp\weapons::_id_555D(self.owner, var_0.attacker, var_0.objweapon, var_0._id_9CD6);
  return var_0.damage;
}

_id_4538(var_0) {
  _id_4536(var_0.attacker, var_0.objweapon);
  thread _id_452D();
}

_id_4533() {
  var_1 = 0;
  var_2 = [];
  var_3 = _id_4534();

  for(var_4 = 0; var_4 < var_3._id_5B94.size; var_4++) {
    var_5 = var_3._id_5B94[var_4];
    var_1 = var_1 + var_3._id_5B95[var_5];
    var_2[var_4] = var_1;
  }

  var_6 = randomint(var_1);

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_6 < var_2[var_4]) {
      return var_3._id_5B94[var_4];
    }
  }

  return undefined;
}

_id_4535() {
  if(!isDefined(self._id_AA38)) {
    return undefined;
  }

  return (self.origin - self._id_AA38) / level._id_5F3A;
}

_id_4531(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0)) {
    var_1 = (0, randomint(360), 0);
  } else if(var_0 * (1, 1, 0) == (0, 0, 0)) {
    var_1 = (0, randomint(360), 0);
  } else if(randomint(100) < 20) {
    var_1 = (0, randomint(360), 0);
  } else {
    var_1 = vectortoangles(var_0 * (1, 1, 0));
    var_2 = _func_000B(var_1[1]);
    var_2 = var_2 + _func_000A(-30.0 + randomint(61));
    var_1 = (var_1[0], var_2, var_1[2]);
  }

  return var_1;
}

_id_4532(var_0, var_1, var_2) {
  var_3 = _id_4534();
  var_4 = var_0;
  var_4 = var_4 + anglestoup(var_2) * randomfloatrange(var_3._id_5B80[var_1], var_3._id_5B7E[var_1]);
  var_4 = var_4 + anglesToForward(var_2) * randomfloatrange(var_3._id_5B7F[var_1], var_3._id_5B7D[var_1]);
  return var_4;
}

_id_453A() {
  var_0 = _id_4535();

  if(!isDefined(var_0) || abs(var_0[2]) <= 200) {
    if(_id_453B()) {
      return 1;
    }
  }

  return 0;
}

_id_453B() {
  var_0 = scripts\engine\trace::_id_3EE5(0, 1, 0, 0, 1, 1);
  var_1 = self.origin + (0, 0, 1);
  var_2 = var_1 + (0, 0, -5);
  var_3 = _func_02C1(var_1, var_2, var_0, self, 0, "physicsquery_closest", 1);

  if(isDefined(var_3) && var_3.size > 0) {
    return 1;
  }

  return 0;
}

_id_4536(var_0, var_1) {
  if(isDefined(var_0) && istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_0))) {
    var_0 notify("destroyed_equipment");
    var_0 scripts\mp\killstreaks\killstreaks::_id_6FEA(self, var_1);
  }
}

_id_4529(var_0) {
  level._id_4541[var_0 getentitynumber()] = var_0;
}

_id_453E(var_0) {
  level._id_4541[var_0] = undefined;
}

_id_4534() {
  return level._id_4540;
}