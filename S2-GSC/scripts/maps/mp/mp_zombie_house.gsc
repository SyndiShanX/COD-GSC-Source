/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_house.gsc
***********************************************/

main() {
  _id_04BD::main();
  _id_0424::main();
  _id_04BC::main();
  _id_0483::main();
  maps\mp\mp_zombie_house_lighting::main();
  maps\mp\mp_zombie_house_aud::main();
  level._id_AC2E = 1;
  _id_0472::_id_8A2F("compass_map_mp_zombie_house");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level._id_2986 = "mp/zombieEnemyWavesHouse.csv";
  level._id_ACA3 = 1;
  level._id_7F24 = 9999;
  level._id_3C00 = 0;
  level._id_3BED = 0;
  level._id_7F1B = 10;
  level._id_323A = 1;
  level._id_AC71 = ::_id_52C4;
  level._id_AC72 = ::_id_6B45;
  level._id_6BB0 = ::_id_6B46;
  common_scripts\utility::flag_init("flag_all_lamps_hit");
  common_scripts\utility::flag_init("flag_all_signs_hit");
  _func_032("ui_zm_intermission_swaptime_1", 6);
  _func_032("ui_zm_intermission_swaptime_2", 2);
  setDvar("2494", "0.12, 0, 0");
  _id_055A::init();
  _id_055A::_id_530A("zone_training_house", 1);
  _id_055A::_id_088A();
  _id_327D();
  thread _id_357A();
  level._id_0C11 = 0;
  thread _id_0544::init();

  if(maps\mp\_utility::isproductionlevelactive(10))
    level thread maps\mp\zombies\_zombies_lo_events::init_zm_lo_events();

  _id_327C();

  foreach(var_1 in level._id_4EE7)
  _id_3281(var_1, 0);

  thread maps\mp\mp_zombie_falldamage_modifier::main();
  thread _id_3FD2();
  level thread maps\mp\zquests\dlc1_secrets_mp_zombie_house::init_dlc1_secrets_mp_zombie_house();
  level thread _id_0557::manage_mtx5_event();
}

_id_3FD2() {
  level waittill("player_spawned", var_0);
  var_1 = _id_325F();

  foreach(var_3 in var_1._id_9DC2)
  var_3 common_scripts\utility::_id_9D9F();

  level._id_7F22["normal"] = ::_id_4EF6;
  level._id_0A41["zombie_generic"]["move_mode"] = ::_id_4EF7;
}

_id_52C4() {
  thread _id_057D::_id_5162();
}

_id_6B45() {}

_id_6B46() {}

_id_4EF7() {
  var_0 = self._id_901F;
  return _id_054D::_id_957E(var_0 + 5);
}

_id_357A() {
  thread _id_3597();
  thread _id_358C();
  level._id_5AF2 = getEntArray("lamp_mystery_box", "targetname");

  foreach(var_1 in level._id_5AF2) {
    var_1 _meth_82C3(1);
    var_1._id_4DC9 = 0;
    var_1 thread _id_3579();
  }

  common_scripts\utility::_id_3C9F("flag_all_lamps_hit");

  foreach(var_4 in level._id_65F6)
  _id_3281(var_4, 1);

  level._id_65F6[0] _id_0378::_id_8D74("ee_complete");
  thread _id_357C();
}

_id_3597() {
  common_scripts\utility::_id_3C9F("flag_all_lamps_hit");
  level._id_8C52 = [];
  level._id_8C52 = getEntArray("klaus_signs", "targetname");

  if(level._id_8C52.size <= 0) {
    return;
  }
  foreach(var_1 in level._id_8C52) {
    var_1._id_4DC9 = 0;
    var_1 thread _id_3596();
  }

  common_scripts\utility::_id_3C9F("flag_all_signs_hit");
}

_id_3596() {
  for(;;) {
    level waittill("jack_exploded", var_0);

    if(distance(var_0, self.origin) < 32) {
      break;
    }
  }

  self._id_4DC9 = 1;
  var_1 = 1;

  foreach(var_3 in level._id_8C52) {
    if(!var_3._id_4DC9)
      var_1 = 0;
  }

  if(var_1)
    common_scripts\utility::flag_set("flag_all_signs_hit");

  self _meth_805C();
}

_id_358C() {
  var_0 = _func_18E("trig_ee_piano", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(common_scripts\utility::_id_3C77("flag_all_signs_hit") && common_scripts\utility::_id_3C77("flag_all_lamps_hit") && var_1 maps\mp\gametypes\zombies::_id_11C2(10000, 1)) {
      _id_0378::_id_8D74("ee_piano_use", var_0.origin, 1);
      break;
    } else {
      _id_0378::_id_8D74("ee_piano_use", var_0.origin, 0);
      wait 1;
      continue;
    }
  }

  level.mystery_box_packed = 1;
  thread _id_357B();
}

_id_357C() {
  while(!isDefined(level._id_5F7F))
    wait 1;

  _id_0548::_id_7CEA("fliegerfaust_zm");
}

_id_357B() {
  var_0 = [];
  var_1 = undefined;

  foreach(var_3 in level._id_5F7F) {
    var_4 = _id_0547::_id_AAF9(var_3["baseNameNoMP"], undefined, 1);
    var_1 = _id_0547::_id_9475(var_4) + "_pap_zm";

    if(!_id_0547::_id_5843(var_1)) {
      continue;
    }
    if(isDefined(var_1)) {
      _id_0548::_id_7CEA(var_3["baseNameNoMP"]);
      _id_0548::_id_09C8(var_1, "none", "none", "none");
    }
  }

  _id_0548::_id_09C8("kar98_pap_zm", "none", "none", "none");
  _id_0548::_id_09C8("luger_pap_zm", "none", "none", "none");
  _id_0548::_id_09C8("m30_pap_zm", "none", "none", "none");
  _id_0548::_id_09C8("model21_pap_zm", "none", "none", "none");
  _id_0548::_id_09C8("m1a1_pap_zm", "none", "none", "none");
  _id_0548::_id_09C8("m712_pap_zm", "none", "none", "none");
}

_id_3579() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  self._id_4DC9 = 1;
  var_10 = (0, 0, 0);

  if(self.model == "ger_oil_lamp_01_a")
    var_10 = (0, 0, 8);
  else if(self.model == "ger_oil_lamp_01_b")
    var_10 = (0, 0, -23);

  playFX(common_scripts\utility::_id_44F5("ee_lamp_fx"), self.origin + var_10, anglesToForward(self.angles), anglestoup(self.angles));
  _id_0378::_id_8D74("ee_update");
  var_11 = 1;

  foreach(var_13 in level._id_5AF2) {
    if(!var_13._id_4DC9)
      var_11 = 0;
  }

  if(var_11)
    common_scripts\utility::flag_set("flag_all_lamps_hit");
}

_id_AA3D() {
  if(!0) {
    var_0 = getEntArray("zbarrier_window", "script_noteworthy");

    foreach(var_2 in var_0)
    var_2 _meth_80B3();
  }
}

_id_327D() {
  level._id_65F6 = getEntArray("mysterybox_door", "targetname");

  foreach(var_1 in level._id_65F6) {
    var_2 = getEntArray(var_1.target, "targetname");

    foreach(var_4 in var_2) {
      if(!isDefined(var_4._id_0165)) {
        continue;
      }
      var_5 = var_4._id_0165;

      switch (var_5) {
        case "door_model":
          var_1._id_326B = var_4;
          var_6 = common_scripts\utility::_id_46B5(var_4.target, "targetname");
          var_7 = common_scripts\utility::_id_46B5(var_6.target, "targetname");
          var_1._id_6BE3 = var_6.angles;
          var_1._id_2443 = var_7.angles;
          break;
        case "door_model_r":
          var_1._id_326D = var_4;
          var_8 = common_scripts\utility::_id_46B5(var_4.target, "targetname");
          var_9 = common_scripts\utility::_id_46B5(var_8.target, "targetname");
          var_1._id_6BF2 = var_8.origin;
          var_1._id_2446 = var_9.origin;
          break;
        case "door_model_l":
          var_1._id_326C = var_4;
          var_10 = common_scripts\utility::_id_46B5(var_4.target, "targetname");
          var_11 = common_scripts\utility::_id_46B5(var_10.target, "targetname");
          var_1._id_6BF1 = var_10.origin;
          var_1._id_2445 = var_11.origin;
          break;
        default:
          break;
      }
    }

    _id_3281(var_1, 0);
  }
}

_id_327C() {
  level._id_4EE7 = getEntArray("house_door", "targetname");

  foreach(var_1 in level._id_4EE7) {
    var_2 = _func_18E(var_1.target, "targetname");
    var_3 = common_scripts\utility::_id_46B5(var_2.target, "targetname");
    var_4 = common_scripts\utility::_id_46B5(var_3.target, "targetname");
    var_1._id_326B = var_2;
    var_1._id_6BE3 = var_3.angles;
    var_1._id_2443 = var_4.angles;
  }
}

_id_3281(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_1)) {
    if(isDefined(var_0._id_326C) && isDefined(var_0._id_326D)) {
      if(var_0._id_326C.origin != var_0._id_6BF1)
        var_0._id_326C _meth_82B1(var_0._id_6BF1, 1, 0.25, 0.5);

      if(var_0._id_326D.origin != var_0._id_6BF2)
        var_0._id_326D _meth_82B1(var_0._id_6BF2, 1, 0.25, 0.5);
    } else if(var_0._id_326B.angles != var_0._id_6BE3)
      var_0._id_326B _meth_82B8(var_0._id_6BE3, 1, 0.25, 0.5);

    var_0 _meth_82C2();
    var_0 _meth_8060();
  } else {
    if(isDefined(var_0._id_326C) && isDefined(var_0._id_326D)) {
      if(var_0._id_326C.origin != var_0._id_2445)
        var_0._id_326C _meth_82B1(var_0._id_2445, 1, 0.25, 0.5);

      if(var_0._id_326D.origin != var_0._id_2446)
        var_0._id_326D _meth_82B1(var_0._id_2446, 1, 0.25, 0.5);
    } else if(var_0._id_326B.angles != var_0._id_2443)
      var_0._id_326B _meth_82B8(var_0._id_2443, 1, 0.25, 0.5);

    var_0 _meth_82C1();
    var_0 _meth_805F();
  }
}

_id_325F() {
  var_0 = "house_to_end";

  foreach(var_2 in level._id_AC1D) {
    if(_id_0547::_id_5565(var_2._id_819A, var_0))
      return var_2;
  }
}

_id_4EF6() {
  if(level._id_A980 == 6)
    level._id_7F1B = 5;

  if(level._id_A980 == 7)
    level._id_7F1B = 4;

  if(level._id_A980 == 8)
    level._id_7F1B = 3;

  if(level._id_A980 == 9)
    level._id_7F1B = 2;

  if(level._id_A980 == 10)
    level._id_7F1B = 1;

  if(level._id_A980 == 50)
    _id_0564::_id_3C11(0);
}

_id_4EED(var_0) {
  switch (var_0) {
    case "cash":
      _id_0547::_id_ABC9(self, 0);
      break;
    case "round":
      _id_0547::_id_ABC9(self, 3);
      break;
    case "weapon":
      _id_0547::_id_ABC9(self, 6);
      break;
    case "ability":
      _id_0547::_id_ABC9(self, 1);
      break;
    case "consumable":
      _id_0547::_id_ABC9(self, 2);
      break;
    case "all":
      self _meth_82FF("ui_hide_hud", 1);
      break;
  }
}