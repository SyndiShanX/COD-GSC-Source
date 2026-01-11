/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3105.gsc
***************************************/

func_10746(var_00) {}

func_9635() {
  scripts\aitypes\bt_util::init();
  func_03AF::func_DEE8();
  func_0C4F::func_2371();
  func_0BD2::init();
  level thread func_B2E0();
  level.func_A41F = [];
  level.func_A41F["axis"]["patrol"] = "patrol";
  level.func_A41F["allies"]["patrol"] = "escape";
  level.func_A41F["axis"]["escape"] = "patrol";
  level.func_A41F["allies"]["escape"] = "escape";
}

func_61CA() {
  self endon("terminate_ai_threads");
  thread func_0BDC::func_1985();

  if(!issentient(self)) {
    var_00 = self makeentitysentient(self.script_team, 0);
  }

  func_0BDC::func_A0AF();
  self _meth_8459("face motion");
  self.behavior = "jackal\jackal";
  self.behaviortreeasset = "jackal";
  self.func_1FA9 = "jackal";

  if(!isDefined(self.subclass)) {
    self.subclass = "jackal";
  }

  if(self.script_team == "axis") {
    if(isDefined(self.func_9B4C) && self.func_9B4C) {
      var_01 = "ace";

      if(!isDefined(level.func_1554)) {
        level.func_1554 = 0;
      } else {
        level.func_1554++;
      }

      self.func_92BD = func_0A2F::func_D9EC(level.func_1554);
      var_02 = func_0BDC::func_A064(self.func_92BD);
      var_03 = var_02;
      thread func_0BDC::func_A063();
    } else if(isDefined(self.func_9CB8) && self.func_9CB8) {
      var_01 = "jackal";
      var_03 = "JACKAL_R16_SKELTER";
    } else {
      var_01 = "jackal";
      var_03 = "JACKAL_R7_SKELTER";
    }

    self.func_1FA8 = "jackal_enemy";
    func_0BDC::func_105DB(var_01, var_03, "jackal", "enemy_jackal", 1);
    level.func_A056.func_191E = scripts\engine\utility::array_add(level.func_A056.func_191E, self);
  } else {
    self.func_1FA8 = "jackal";
    func_0BDC::func_105DB("jackal", undefined, "ally_jackal", "ally_jackal");
    level.func_A056.func_1914 = scripts\engine\utility::array_add(level.func_A056.func_1914, self);
  }

  self.func_1912 = 1;
  self _meth_8456((0, 0, 1));
  func_0BDC::func_198F();
  self.a = spawnStruct();
  self.a.nodeath = 1;
  func_0C1A::func_25C5();
  func_0C20::func_7598(1);
  func_0C18::func_1EDC();
  self.lastenemysighttime = 0;
  self.func_440E = 0;
  self.func_112C8 = 0;
  self.func_112CA = 0;
  self.suppressionthreshold = 0.5;

  if(!isDefined(anim.func_3D4B)) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      anim.player = level.func_D127;
    } else {
      anim.player = getEntArray("player", "classname")[0];
    }

    scripts\anim\init::func_97DA();
  }

  self.func_29B8 = 1;
  self.func_3D4B = 0;
  thread scripts\anim\init::func_F7AC();
  scripts\aitypes\bt_util::bt_init();
  func_0A1E::func_234D(self.func_1FA9, self.func_1FA8);
  func_A231();
  func_A230();
  func_D97E();
  self.func_38A2 = 0;
  func_0BDC::func_198B(7.0);
  self _meth_8491(self.var_1198.func_E1AC);
  thread func_A067();
  thread func_A068();
  func_0C1B::func_13CC4();
  func_0C24::func_10A49();
  thread func_0C1B::func_13C2B();

  if(!isDefined(self.func_6EA3) || scripts\engine\utility::is_true(self.func_6EA3)) {
    thread func_0C1B::func_6EAC();
  }

  thread func_0C1C::init();
  level.func_A056.func_1630 = scripts\engine\utility::array_add(level.func_A056.func_1630, self);
  self _meth_8455(self.origin, 1);
  func_107E2();

  if(isDefined(self.func_9B4C) && self.func_9B4C) {
    func_0BDC::func_1997();
  }

  if(isDefined(self.func_9CB8) && self.func_9CB8) {
    func_0BDC::func_1999();
  }

  func_20DD("fly");
}

func_D97E() {
  if(isDefined(self.func_EF05)) {
    thread func_0C24::func_517E();
  }
}

func_54F8() {
  self notify("terminate_ai_threads");
  self notify("removed from battleChatter");
  self.func_1912 = 0;

  if(issentient(self)) {
    self freeentitysentient();
  }

  if(func_0BDC::func_9CC8()) {
    func_0BDC::func_105DA();
  }

  level.func_A056.func_1630 = scripts\engine\utility::array_remove(level.func_A056.func_1630, self);

  if(self.script_team == "allies") {
    level.func_A056.func_1914 = scripts\engine\utility::array_remove(level.func_A056.func_1914, self);
  } else {
    level.func_A056.func_191E = scripts\engine\utility::array_remove(level.func_A056.func_191E, self);
  }
}

func_A231() {
  self.var_3135.func_6577 = gettime();
  self.var_3135.func_673E = gettime();
  self.var_3135.func_DB05 = undefined;
  self.var_3135.func_673F = 0;
  self.var_3135.func_EF78 = 0;
  self.var_3135.func_5870 = 0;
  self.var_3135.func_A533 = 0;
  self.var_3135.func_DB06 = 0;
  self.var_3135.func_BFA2 = gettime();
  self.var_3135.attackerdata = spawnStruct();
  self.var_3135.attackerdata.func_24D3 = 0;
  self.var_3135.attackerdata.attacker = undefined;
  self.var_3135.attackerdata.func_2535 = gettime();
}

func_7C99(var_00) {
  return [];
}

func_A230() {
  self.var_1198.func_EF72 = 0;
  self.var_1198.func_6D77 = "dont_shoot";
  self.var_1198.func_6D83 = "jackal_gatling_fire";
  self.var_1198.animscriptedactive = 0;
  self.var_1198.func_7235 = spawnStruct();
  self.var_1198.func_7235.target = undefined;
  self.var_1198.func_7235.offset = (0, 0, 0);
  self.var_1198.func_7235.func_7237 = 0;
  self.var_1198.func_90F3 = 0;
  self.var_1198.func_2520 = 0;
  self.var_1198.func_D9BA = undefined;
  self.var_1198.accuracy = 0.3;
  self.var_1198.func_2894 = 1.0;
  self.var_1198.func_AAB2 = 0;
  self.var_1198.func_A421 = undefined;
  self.var_1198.func_A420 = undefined;
  self.var_1198.func_23A4 = func_9536();
  self.var_1198.func_1113B = func_976D();
  self.var_1198.func_C97C = 0;
  self.var_1198.func_90EE = undefined;
  self.var_1198.func_7002 = undefined;
  self.var_1198.func_9DC2 = 0;
  self.var_1198.func_90EC = "";
  self.var_1198.func_90ED = -999999999;
  self.var_1198.shootparams = spawnStruct();
  self.var_1198.shootparams.func_C36B = (0, 0, 0);
  self.var_1198.shootparams.func_C36C = (0, 0, 0);
  self.var_1198.shootparams.time = 0;
  self.var_1198.shootparams.starttime = 0;
  self.var_1198.shootparams.func_0148 = 0;
  self.var_1198.func_90DC = undefined;
  self.var_1198.func_90DA = undefined;
  self.var_1198.func_90DB = undefined;
  self.var_1198.func_90D9 = undefined;
  self.var_1198.func_1000D = 0;
  self.var_1198.func_9DE4 = 0;
  self.var_1198.func_2CCD = 0;
  self.var_1198.func_2CD1 = gettime();
  self.var_1198.func_2CD2 = 0;
  self.var_1198.func_BFA6 = gettime() + randomintrange(5000, 10000);
  self.var_1198.func_2CCF = 0;
  self.var_1198.func_2CB8 = 0;
  self.var_1198.func_C702 = undefined;
  self.var_1198.func_C705 = undefined;
  self.var_1198.func_11577 = undefined;
  self.var_1198.func_E1AC = "none";
  self.var_1198.func_90EA = 1;
  self.var_1198.func_2521 = 0;
  self.var_1198.func_2531 = 0;
  self.var_1198.func_10A4A = undefined;
  self.var_1198.func_10A4B = undefined;
  self.var_1198.func_10A4D = func_7C99(self.team);
  self.var_1198.func_38DC = "down";
  self.var_1198.func_E1AB = "up";
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
    if(self.var_1198.animscriptedactive) {
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
  if(!isDefined(self.func_1323C) || !isDefined(self.func_1323C.func_EEC4)) {
    return;
  }
  var_00 = getEntArray(self.func_1323C.func_EEC4, "targetname");

  if(!isDefined(var_00) || var_0.size == 0) {
    return;
  }
  foreach(var_02 in var_00) {
    if(_isspawner(var_02) && isDefined(var_2.vehicletype) && var_2.vehicletype == self.vehicletype && var_2.script_team == self.script_team) {
      thread func_B28A(var_02, self);
    }
  }
}

func_B28A(var_00, var_01) {
  var_02 = var_0.origin - var_1.origin;
  wait 0.05;
  var_03 = scripts\sp\vehicle::func_13237(var_00);
  var_03 func_0BDC::func_199E(var_01, var_02);
}

func_9536() {
  var_00 = spawnStruct();
  var_0.speed = 100.0;
  var_0.func_1545 = 80.0;
  var_0.func_1E91 = 240.0;
  var_0.func_1E71 = 360.0;
  return var_00;
}

func_976D() {
  var_00 = spawnStruct();
  var_0.speed = 420.0;
  var_0.func_1545 = 380.0;
  var_0.func_1E91 = 360.0;
  var_0.func_1E71 = 480.0;
  return var_00;
}

_meth_814A(var_00) {
  var_01 = undefined;

  if(!isDefined(self.var_1198)) {
    return func_976D();
  }

  if(!isDefined(var_00)) {
    if(self.var_1198.func_E1AC != "none") {
      var_00 = self.var_1198.func_E1AC;
    } else {
      var_00 = "fly";
    }
  }

  switch (var_00) {
    case "hover":
      var_01 = self.var_1198.func_23A4;
      break;
    case "fly":
      var_01 = self.var_1198.func_1113B;
      break;
    default:
      var_01 = self.var_1198.func_1113B;
      break;
  }

  return var_01;
}

func_20DD(var_00) {
  var_01 = _meth_814A(var_00);
  self _meth_845F(var_1.speed, var_1.func_1545, var_1.func_1E91, var_1.func_1E71);
}

func_20DE(var_00, var_01) {
  var_02 = _meth_814A(var_01);
  self _meth_845F(var_2.speed * var_00, var_2.func_1545 * var_00, var_2.func_1E91 * var_00, var_2.func_1E71 * var_00);
}

func_B2E0() {
  for(;;) {
    var_00 = func_0BCE::func_7DB5();

    foreach(var_02 in var_00) {
      var_2.func_C1DB = 0;
    }

    foreach(var_02 in var_00) {
      if(isalive(var_2.enemy) && var_2.enemy scripts\sp\vehicle::func_9FEF() && _isaircraft(var_2.enemy)) {
        var_2.enemy.func_C1DB++;
      }
    }

    wait 0.05;
  }
}