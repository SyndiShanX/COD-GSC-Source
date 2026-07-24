/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3105.gsc
**************************************/

_id_10746(var_0) {}

_id_9635() {
  scripts\aitypes\bt_util::init();
  _id_03AF::_id_DEE8();
  _id_0C4F::_id_2371();
  _id_0BD2::init();
  level thread _id_B2E0();
  level._id_A41F = [];
  level._id_A41F["axis"]["patrol"] = "patrol";
  level._id_A41F["allies"]["patrol"] = "escape";
  level._id_A41F["axis"]["escape"] = "patrol";
  level._id_A41F["allies"]["escape"] = "escape";
}

_id_61CA() {
  self endon("terminate_ai_threads");
  thread _id_0BDC::_id_1985();

  if(!issentient(self)) {
    var_0 = self makeentitysentient(self.script_team, 0);
  }

  _id_0BDC::_id_A0AF();
  self _meth_8459("face motion");
  self.behavior = "jackal/jackal";
  self.behaviortreeasset = "jackal";
  self._id_1FA9 = "jackal";

  if(!isDefined(self.subclass)) {
    self.subclass = "jackal";
  }

  if(self.script_team == "axis") {
    if(isDefined(self._id_9B4C) && self._id_9B4C) {
      var_1 = "ace";

      if(!isDefined(level._id_1554)) {
        level._id_1554 = 0;
      } else {
        level._id_1554++;
      }

      self._id_92BD = _id_0A2F::_id_D9EC(level._id_1554);
      var_2 = _id_0BDC::_id_A064(self._id_92BD);
      var_3 = var_2;
      thread _id_0BDC::_id_A063();
    } else if(isDefined(self._id_9CB8) && self._id_9CB8) {
      var_1 = "jackal";
      var_3 = "JACKAL_R16_SKELTER";
    } else {
      var_1 = "jackal";
      var_3 = "JACKAL_R7_SKELTER";
    }

    self._id_1FA8 = "jackal_enemy";
    _id_0BDC::_id_105DB(var_1, var_3, "jackal", "enemy_jackal", 1);
    level._id_A056._id_191E = scripts\engine\utility::array_add(level._id_A056._id_191E, self);
  } else {
    self._id_1FA8 = "jackal";
    _id_0BDC::_id_105DB("jackal", undefined, "ally_jackal", "ally_jackal");
    level._id_A056._id_1914 = scripts\engine\utility::array_add(level._id_A056._id_1914, self);
  }

  self._id_1912 = 1;
  self _meth_8456((0, 0, 1));
  _id_0BDC::_id_198F();
  self.a = spawnStruct();
  self.a.nodeath = 1;
  _id_0C1A::_id_25C5();
  _id_0C20::_id_7598(1);
  _id_0C18::_id_1EDC();
  self.lastenemysighttime = 0;
  self._id_440E = 0;
  self._id_112C8 = 0;
  self._id_112CA = 0;
  self.suppressionthreshold = 0.5;

  if(!isDefined(anim._id_3D4B)) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      anim.player = level._id_D127;
    } else {
      anim.player = getEntArray("player", "classname")[0];
    }

    scripts\anim\init::_id_97DA();
  }

  self._id_29B8 = 1;
  self._id_3D4B = 0;
  thread scripts\anim\init::_id_F7AC();
  scripts\aitypes\bt_util::bt_init();
  _id_0A1E::_id_234D(self._id_1FA9, self._id_1FA8);
  _id_A231();
  _id_A230();
  _id_D97E();
  self._id_38A2 = 0;
  _id_0BDC::_id_198B(7.0);
  self _meth_8491(self._blackboard._id_E1AC);
  thread _id_A067();
  thread _id_A068();
  _id_0C1B::_id_13CC4();
  _id_0C24::_id_10A49();
  thread _id_0C1B::_id_13C2B();

  if(!isDefined(self._id_6EA3) || scripts\engine\utility::is_true(self._id_6EA3)) {
    thread _id_0C1B::_id_6EAC();
  }

  thread _id_0C1C::init();
  level._id_A056._id_1630 = scripts\engine\utility::array_add(level._id_A056._id_1630, self);
  self _meth_8455(self.origin, 1);
  _id_107E2();

  if(isDefined(self._id_9B4C) && self._id_9B4C) {
    _id_0BDC::_id_1997();
  }

  if(isDefined(self._id_9CB8) && self._id_9CB8) {
    _id_0BDC::_id_1999();
  }

  _id_20DD("fly");
}

_id_D97E() {
  if(isDefined(self._id_EF05)) {
    thread _id_0C24::_id_517E();
  }
}

_id_54F8() {
  self notify("terminate_ai_threads");
  self notify("removed from battleChatter");
  self._id_1912 = 0;

  if(issentient(self)) {
    self freeentitysentient();
  }

  if(_id_0BDC::_id_9CC8()) {
    _id_0BDC::_id_105DA();
  }

  level._id_A056._id_1630 = scripts\engine\utility::array_remove(level._id_A056._id_1630, self);

  if(self.script_team == "allies") {
    level._id_A056._id_1914 = scripts\engine\utility::array_remove(level._id_A056._id_1914, self);
  } else {
    level._id_A056._id_191E = scripts\engine\utility::array_remove(level._id_A056._id_191E, self);
  }
}

_id_A231() {
  self.bt._id_6577 = gettime();
  self.bt._id_673E = gettime();
  self.bt._id_DB05 = undefined;
  self.bt._id_673F = 0;
  self.bt._id_EF78 = 0;
  self.bt._id_5870 = 0;
  self.bt._id_A533 = 0;
  self.bt._id_DB06 = 0;
  self.bt._id_BFA2 = gettime();
  self.bt.attackerdata = spawnStruct();
  self.bt.attackerdata._id_24D3 = 0;
  self.bt.attackerdata.attacker = undefined;
  self.bt.attackerdata._id_2535 = gettime();
}

_id_7C99(var_0) {
  return [];
}

_id_A230() {
  self._blackboard._id_EF72 = 0;
  self._blackboard._id_6D77 = "dont_shoot";
  self._blackboard._id_6D83 = "jackal_gatling_fire";
  self._blackboard.animscriptedactive = 0;
  self._blackboard._id_7235 = spawnStruct();
  self._blackboard._id_7235.target = undefined;
  self._blackboard._id_7235.offset = (0, 0, 0);
  self._blackboard._id_7235._id_7237 = 0;
  self._blackboard._id_90F3 = 0;
  self._blackboard._id_2520 = 0;
  self._blackboard._id_D9BA = undefined;
  self._blackboard.accuracy = 0.3;
  self._blackboard._id_2894 = 1.0;
  self._blackboard._id_AAB2 = 0;
  self._blackboard._id_A421 = undefined;
  self._blackboard._id_A420 = undefined;
  self._blackboard._id_23A4 = _id_9536();
  self._blackboard._id_1113B = _id_976D();
  self._blackboard._id_C97C = 0;
  self._blackboard._id_90EE = undefined;
  self._blackboard._id_7002 = undefined;
  self._blackboard._id_9DC2 = 0;
  self._blackboard._id_90EC = "";
  self._blackboard._id_90ED = -999999999;
  self._blackboard.shootparams = spawnStruct();
  self._blackboard.shootparams._id_C36B = (0, 0, 0);
  self._blackboard.shootparams._id_C36C = (0, 0, 0);
  self._blackboard.shootparams.time = 0;
  self._blackboard.shootparams.starttime = 0;
  self._blackboard.shootparams._id_0148 = 0;
  self._blackboard._id_90DC = undefined;
  self._blackboard._id_90DA = undefined;
  self._blackboard._id_90DB = undefined;
  self._blackboard._id_90D9 = undefined;
  self._blackboard._id_1000D = 0;
  self._blackboard._id_9DE4 = 0;
  self._blackboard._id_2CCD = 0;
  self._blackboard._id_2CD1 = gettime();
  self._blackboard._id_2CD2 = 0;
  self._blackboard._id_BFA6 = gettime() + randomintrange(5000, 10000);
  self._blackboard._id_2CCF = 0;
  self._blackboard._id_2CB8 = 0;
  self._blackboard._id_C702 = undefined;
  self._blackboard._id_C705 = undefined;
  self._blackboard._id_11577 = undefined;
  self._blackboard._id_E1AC = "none";
  self._blackboard._id_90EA = 1;
  self._blackboard._id_2521 = 0;
  self._blackboard._id_2531 = 0;
  self._blackboard._id_10A4A = undefined;
  self._blackboard._id_10A4B = undefined;
  self._blackboard._id_10A4D = _id_7C99(self.team);
  self._blackboard._id_38DC = "down";
  self._blackboard._id_E1AB = "up";
}

_id_A067() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    assertdemo(2541000);
    scripts\aitypes\bt_util::bt_tick();
    assertdemo(2541001);
    scripts\asm\asm::_id_2314();
    assertdemo(2541002);
    scripts\asm\asm::_id_2389();
    assertdemo(2541003);
    wait 0.05;
  }
}

_id_A068() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    if(!issentient(self)) {
      return;
    }
    if(self._blackboard.animscriptedactive) {
      wait 0.05;
      continue;
    }

    _id_0C1B::_id_12E3A();
    _id_0C1B::_id_12E1A();
    _id_0C1B::_id_12D7B();
    _id_0C1B::_id_12D99();
    wait 0.5;
  }
}

_id_107E2() {
  if(!isDefined(self._id_1323C) || !isDefined(self._id_1323C._id_EEC4)) {
    return;
  }
  var_0 = getEntArray(self._id_1323C._id_EEC4, "targetname");

  if(!isDefined(var_0) || var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    if(isspawner(var_2) && isDefined(var_2.vehicletype) && var_2.vehicletype == self.vehicletype && var_2.script_team == self.script_team) {
      thread _id_B28A(var_2, self);
    }
  }
}

_id_B28A(var_0, var_1) {
  var_2 = var_0.origin - var_1.origin;
  wait 0.05;
  var_3 = scripts\sp\vehicle::_id_13237(var_0);
  var_3 _id_0BDC::_id_199E(var_1, var_2);
}

_id_9536() {
  var_0 = spawnStruct();
  var_0.speed = 100.0;
  var_0._id_1545 = 80.0;
  var_0._id_1E91 = 240.0;
  var_0._id_1E71 = 360.0;
  return var_0;
}

_id_976D() {
  var_0 = spawnStruct();
  var_0.speed = 420.0;
  var_0._id_1545 = 380.0;
  var_0._id_1E91 = 360.0;
  var_0._id_1E71 = 480.0;
  return var_0;
}

_id_814A(var_0) {
  var_1 = undefined;

  if(!isDefined(self._blackboard)) {
    return _id_976D();
  }

  if(!isDefined(var_0)) {
    if(self._blackboard._id_E1AC != "none") {
      var_0 = self._blackboard._id_E1AC;
    } else {
      var_0 = "fly";
    }
  }

  switch (var_0) {
    case "hover":
      var_1 = self._blackboard._id_23A4;
      break;
    case "fly":
      var_1 = self._blackboard._id_1113B;
      break;
    default:
      var_1 = self._blackboard._id_1113B;
      break;
  }

  return var_1;
}

_id_20DD(var_0) {
  var_1 = _id_814A(var_0);
  self _meth_845F(var_1.speed, var_1._id_1545, var_1._id_1E91, var_1._id_1E71);
}

_id_20DE(var_0, var_1) {
  var_2 = _id_814A(var_1);
  self _meth_845F(var_2.speed * var_0, var_2._id_1545 * var_0, var_2._id_1E91 * var_0, var_2._id_1E71 * var_0);
}

_id_B2E0() {
  for(;;) {
    var_0 = _id_0BCE::_id_7DB5();

    foreach(var_2 in var_0) {
      var_2._id_C1DB = 0;
    }

    foreach(var_2 in var_0) {
      if(isalive(var_2.enemy) && var_2.enemy scripts\sp\vehicle::_id_9FEF() && isaircraft(var_2.enemy)) {
        var_2.enemy._id_C1DB++;
      }
    }

    wait 0.05;
  }
}