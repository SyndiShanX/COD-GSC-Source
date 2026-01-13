/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3105.gsc
**************************************/

func_10746(var_0) {}

func_9635() {
  scripts\aitypes\bt_util::init();
  func_03AF::func_DEE8();
  func_0C4F::func_2371();
  func_0BD2::init();
  level thread func_B2E0();
  level.var_A41F = [];
  level.var_A41F["axis"]["patrol"] = "patrol";
  level.var_A41F["allies"]["patrol"] = "escape";
  level.var_A41F["axis"]["escape"] = "patrol";
  level.var_A41F["allies"]["escape"] = "escape";
}

func_61CA() {
  self endon("terminate_ai_threads");
  thread func_0BDC::func_1985();

  if(!issentient(self)) {
    var_0 = self makeentitysentient(self.script_team, 0);
  }

  func_0BDC::func_A0AF();
  self _meth_8459("face motion");
  self.behavior = "jackal\jackal";
  self.behaviortreeasset = "jackal";
  self.var_1FA9 = "jackal";

  if(!isDefined(self.subclass)) {
    self.subclass = "jackal";
  }

  if(self.script_team == "axis") {
    if(isDefined(self.var_9B4C) && self.var_9B4C) {
      var_1 = "ace";

      if(!isDefined(level.var_1554)) {
        level.var_1554 = 0;
      } else {
        level.var_1554++;
      }

      self.var_92BD = func_0A2F::func_D9EC(level.var_1554);
      var_2 = func_0BDC::func_A064(self.var_92BD);
      var_3 = var_2;
      thread func_0BDC::func_A063();
    } else if(isDefined(self.var_9CB8) && self.var_9CB8) {
      var_1 = "jackal";
      var_3 = "JACKAL_R16_SKELTER";
    } else {
      var_1 = "jackal";
      var_3 = "JACKAL_R7_SKELTER";
    }

    self.var_1FA8 = "jackal_enemy";
    func_0BDC::func_105DB(var_1, var_3, "jackal", "enemy_jackal", 1);
    level.var_A056.var_191E = scripts\engine\utility::array_add(level.var_A056.var_191E, self);
  } else {
    self.var_1FA8 = "jackal";
    func_0BDC::func_105DB("jackal", undefined, "ally_jackal", "ally_jackal");
    level.var_A056.var_1914 = scripts\engine\utility::array_add(level.var_A056.var_1914, self);
  }

  self.var_1912 = 1;
  self _meth_8456((0, 0, 1));
  func_0BDC::func_198F();
  self.a = spawnStruct();
  self.a.nodeath = 1;
  func_0C1A::func_25C5();
  func_0C20::func_7598(1);
  func_0C18::func_1EDC();
  self.lastenemysighttime = 0;
  self.var_440E = 0;
  self.var_112C8 = 0;
  self.var_112CA = 0;
  self.suppressionthreshold = 0.5;

  if(!isDefined(anim.var_3D4B)) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      anim.player = level.var_D127;
    } else {
      anim.player = getEntArray("player", "classname")[0];
    }

    scripts\anim\init::func_97DA();
  }

  self.var_29B8 = 1;
  self.var_3D4B = 0;
  thread scripts\anim\init::func_F7AC();
  scripts\aitypes\bt_util::bt_init();
  func_0A1E::func_234D(self.var_1FA9, self.var_1FA8);
  func_A231();
  func_A230();
  func_D97E();
  self.var_38A2 = 0;
  func_0BDC::func_198B(7.0);
  self _meth_8491(self._blackboard.var_E1AC);
  thread func_A067();
  thread func_A068();
  func_0C1B::func_13CC4();
  func_0C24::func_10A49();
  thread func_0C1B::func_13C2B();

  if(!isDefined(self.var_6EA3) || scripts\engine\utility::is_true(self.var_6EA3)) {
    thread func_0C1B::func_6EAC();
  }

  thread func_0C1C::init();
  level.var_A056.var_1630 = scripts\engine\utility::array_add(level.var_A056.var_1630, self);
  self _meth_8455(self.origin, 1);
  func_107E2();

  if(isDefined(self.var_9B4C) && self.var_9B4C) {
    func_0BDC::func_1997();
  }

  if(isDefined(self.var_9CB8) && self.var_9CB8) {
    func_0BDC::func_1999();
  }

  func_20DD("fly");
}

func_D97E() {
  if(isDefined(self.var_EF05)) {
    thread func_0C24::func_517E();
  }
}

func_54F8() {
  self notify("terminate_ai_threads");
  self notify("removed from battleChatter");
  self.var_1912 = 0;

  if(issentient(self)) {
    self freeentitysentient();
  }

  if(func_0BDC::func_9CC8()) {
    func_0BDC::func_105DA();
  }

  level.var_A056.var_1630 = scripts\engine\utility::array_remove(level.var_A056.var_1630, self);

  if(self.script_team == "allies") {
    level.var_A056.var_1914 = scripts\engine\utility::array_remove(level.var_A056.var_1914, self);
  } else {
    level.var_A056.var_191E = scripts\engine\utility::array_remove(level.var_A056.var_191E, self);
  }
}

func_A231() {
  self.bt.var_6577 = gettime();
  self.bt.var_673E = gettime();
  self.bt.var_DB05 = undefined;
  self.bt.var_673F = 0;
  self.bt.var_EF78 = 0;
  self.bt.var_5870 = 0;
  self.bt.var_A533 = 0;
  self.bt.var_DB06 = 0;
  self.bt.var_BFA2 = gettime();
  self.bt.attackerdata = spawnStruct();
  self.bt.attackerdata.var_24D3 = 0;
  self.bt.attackerdata.attacker = undefined;
  self.bt.attackerdata.var_2535 = gettime();
}

func_7C99(var_0) {
  return [];
}

func_A230() {
  self._blackboard.var_EF72 = 0;
  self._blackboard.var_6D77 = "dont_shoot";
  self._blackboard.var_6D83 = "jackal_gatling_fire";
  self._blackboard.animscriptedactive = 0;
  self._blackboard.var_7235 = spawnStruct();
  self._blackboard.var_7235.target = undefined;
  self._blackboard.var_7235.offset = (0, 0, 0);
  self._blackboard.var_7235.var_7237 = 0;
  self._blackboard.var_90F3 = 0;
  self._blackboard.var_2520 = 0;
  self._blackboard.var_D9BA = undefined;
  self._blackboard.accuracy = 0.3;
  self._blackboard.var_2894 = 1.0;
  self._blackboard.var_AAB2 = 0;
  self._blackboard.var_A421 = undefined;
  self._blackboard.var_A420 = undefined;
  self._blackboard.var_23A4 = func_9536();
  self._blackboard.var_1113B = func_976D();
  self._blackboard.var_C97C = 0;
  self._blackboard.var_90EE = undefined;
  self._blackboard.var_7002 = undefined;
  self._blackboard.var_9DC2 = 0;
  self._blackboard.var_90EC = "";
  self._blackboard.var_90ED = -999999999;
  self._blackboard.shootparams = spawnStruct();
  self._blackboard.shootparams.var_C36B = (0, 0, 0);
  self._blackboard.shootparams.var_C36C = (0, 0, 0);
  self._blackboard.shootparams.time = 0;
  self._blackboard.shootparams.starttime = 0;
  self._blackboard.shootparams.var_0148 = 0;
  self._blackboard.var_90DC = undefined;
  self._blackboard.var_90DA = undefined;
  self._blackboard.var_90DB = undefined;
  self._blackboard.var_90D9 = undefined;
  self._blackboard.var_1000D = 0;
  self._blackboard.var_9DE4 = 0;
  self._blackboard.var_2CCD = 0;
  self._blackboard.var_2CD1 = gettime();
  self._blackboard.var_2CD2 = 0;
  self._blackboard.var_BFA6 = gettime() + randomintrange(5000, 10000);
  self._blackboard.var_2CCF = 0;
  self._blackboard.var_2CB8 = 0;
  self._blackboard.var_C702 = undefined;
  self._blackboard.var_C705 = undefined;
  self._blackboard.var_11577 = undefined;
  self._blackboard.var_E1AC = "none";
  self._blackboard.var_90EA = 1;
  self._blackboard.var_2521 = 0;
  self._blackboard.var_2531 = 0;
  self._blackboard.var_10A4A = undefined;
  self._blackboard.var_10A4B = undefined;
  self._blackboard.var_10A4D = func_7C99(self.team);
  self._blackboard.var_38DC = "down";
  self._blackboard.var_E1AB = "up";
}

func_A067() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }
    _assertdemo(2541000);
    scripts\aitypes\bt_util::bt_tick();
    _assertdemo(2541001);
    scripts\asm\asm::func_2314();
    _assertdemo(2541002);
    scripts\asm\asm::func_2389();
    _assertdemo(2541003);
    wait 0.05;
  }
}

func_A068() {
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

    func_0C1B::func_12E3A();
    func_0C1B::func_12E1A();
    func_0C1B::func_12D7B();
    func_0C1B::func_12D99();
    wait 0.5;
  }
}

func_107E2() {
  if(!isDefined(self.var_1323C) || !isDefined(self.var_1323C.var_EEC4)) {
    return;
  }
  var_0 = getEntArray(self.var_1323C.var_EEC4, "targetname");

  if(!isDefined(var_0) || var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    if(_isspawner(var_2) && isDefined(var_2.vehicletype) && var_2.vehicletype == self.vehicletype && var_2.script_team == self.script_team) {
      thread func_B28A(var_2, self);
    }
  }
}

func_B28A(var_0, var_1) {
  var_2 = var_0.origin - var_1.origin;
  wait 0.05;
  var_3 = scripts\sp\vehicle::func_13237(var_0);
  var_3 func_0BDC::func_199E(var_1, var_2);
}

func_9536() {
  var_0 = spawnStruct();
  var_0.speed = 100.0;
  var_0.var_1545 = 80.0;
  var_0.var_1E91 = 240.0;
  var_0.var_1E71 = 360.0;
  return var_0;
}

func_976D() {
  var_0 = spawnStruct();
  var_0.speed = 420.0;
  var_0.var_1545 = 380.0;
  var_0.var_1E91 = 360.0;
  var_0.var_1E71 = 480.0;
  return var_0;
}

_meth_814A(var_0) {
  var_1 = undefined;

  if(!isDefined(self._blackboard)) {
    return func_976D();
  }

  if(!isDefined(var_0)) {
    if(self._blackboard.var_E1AC != "none") {
      var_0 = self._blackboard.var_E1AC;
    } else {
      var_0 = "fly";
    }
  }

  switch (var_0) {
    case "hover":
      var_1 = self._blackboard.var_23A4;
      break;
    case "fly":
      var_1 = self._blackboard.var_1113B;
      break;
    default:
      var_1 = self._blackboard.var_1113B;
      break;
  }

  return var_1;
}

func_20DD(var_0) {
  var_1 = _meth_814A(var_0);
  self _meth_845F(var_1.speed, var_1.var_1545, var_1.var_1E91, var_1.var_1E71);
}

func_20DE(var_0, var_1) {
  var_2 = _meth_814A(var_1);
  self _meth_845F(var_2.speed * var_0, var_2.var_1545 * var_0, var_2.var_1E91 * var_0, var_2.var_1E71 * var_0);
}

func_B2E0() {
  for(;;) {
    var_0 = func_0BCE::func_7DB5();

    foreach(var_2 in var_0) {
      var_2.var_C1DB = 0;
    }

    foreach(var_2 in var_0) {
      if(isalive(var_2.enemy) && var_2.enemy scripts\sp\vehicle::func_9FEF() && _isaircraft(var_2.enemy)) {
        var_2.enemy.var_C1DB++;
      }
    }

    wait 0.05;
  }
}