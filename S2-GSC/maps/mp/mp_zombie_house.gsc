/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_house.gsc
*********************************************/

main() {
  lib_04BD::main();
  lib_0424::main();
  lib_04BC::main();
  maps\mp\_load::main();
  maps / mp / mp_zombie_house_lighting::main();
  maps / mp / mp_zombie_house_aud::main();
  level.var_AC2E = 1;
  maps\mp\_compass::setupminimap("compass_map_mp_zombie_house");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_2986 = "mp/zombieEnemyWavesHouse.csv";
  level.var_ACA3 = 1;
  level.var_7F24 = 9999;
  level.var_3C00 = 0;
  level.var_3BED = 0;
  level.var_7F1B = 10;
  level.var_323A = 1;
  level.var_AC71 = ::func_52C4;
  level.var_AC72 = ::func_6B45;
  level.var_6BB0 = ::func_6B46;
  common_scripts\utility::func_3C87("flag_all_lamps_hit");
  common_scripts\utility::func_3C87("flag_all_signs_hit");
  setomnvar("ui_zm_intermission_swaptime_1", 6);
  setomnvar("ui_zm_intermission_swaptime_2", 2);
  setDvar("2494", "0.12, 0, 0");
  lib_055A::init();
  lib_055A::func_530A("zone_training_house", 1);
  lib_055A::func_88A();
  func_327D();
  thread func_357A();
  level.var_C11 = 0;
  thread maps\mp\zombies\_zombies_money::init();
  if(maps\mp\_utility::isproductionlevelactive(10)) {
    level thread maps / mp / zombies / _zombies_lo_events::init_zm_lo_events();
  }

  func_327C();
  foreach(var_01 in level.var_4EE7) {
    func_3281(var_01, 0);
  }

  thread maps / mp / mp_zombie_falldamage_modifier::main();
  thread func_3FD2();
  level thread maps / mp / zquests / dlc1_secrets_mp_zombie_house::init_dlc1_secrets_mp_zombie_house();
  level thread lib_0557::manage_mtx5_event();
}

func_3FD2() {
  level waittill("player_spawned", var_00);
  var_01 = func_325F();
  foreach(var_03 in var_01.var_9DC2) {
    var_03 common_scripts\utility::func_9D9F();
  }

  level.var_7F22["normal"] = ::func_4EF6;
  level.var_A41["zombie_generic"]["move_mode"] = ::func_4EF7;
}

func_52C4() {
  thread lib_057D::func_5162();
}

func_6B45() {}

func_6B46() {}

func_4EF7() {
  var_00 = self.var_901F;
  return lib_054D::func_957E(var_00 + 5);
}

func_357A() {
  thread func_3597();
  thread func_358C();
  level.var_5AF2 = getEntArray("lamp_mystery_box", "targetname");
  foreach(var_01 in level.var_5AF2) {
    var_01 setCanDamage(1);
    var_01.var_4DC9 = 0;
    var_01 thread func_3579();
  }

  common_scripts\utility::func_3C9F("flag_all_lamps_hit");
  foreach(var_04 in level.var_65F6) {
    func_3281(var_04, 1);
  }

  level.var_65F6[0] lib_0378::func_8D74("ee_complete");
  thread func_357C();
}

func_3597() {
  common_scripts\utility::func_3C9F("flag_all_lamps_hit");
  level.var_8C52 = [];
  level.var_8C52 = getEntArray("klaus_signs", "targetname");
  if(level.var_8C52.size <= 0) {
    return;
  }

  foreach(var_01 in level.var_8C52) {
    var_01.var_4DC9 = 0;
    var_01 thread func_3596();
  }

  common_scripts\utility::func_3C9F("flag_all_signs_hit");
}

func_3596() {
  for(;;) {
    level waittill("jack_exploded", var_00);
    if(distance(var_00, self.origin) < 32) {
      break;
    }
  }

  self.var_4DC9 = 1;
  var_01 = 1;
  foreach(var_03 in level.var_8C52) {
    if(!var_03.var_4DC9) {
      var_01 = 0;
    }
  }

  if(var_01) {
    common_scripts\utility::func_3C8F("flag_all_signs_hit");
  }

  self hide();
}

func_358C() {
  var_00 = getEnt("trig_ee_piano", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(common_scripts\utility::func_3C77("flag_all_signs_hit") && common_scripts\utility::func_3C77("flag_all_lamps_hit") && var_01 maps / mp / gametypes / zombies::func_11C2(10000, 1)) {
      lib_0378::func_8D74("ee_piano_use", var_00.origin, 1);
      break;
    } else {
      lib_0378::func_8D74("ee_piano_use", var_00.origin, 0);
      wait(1);
      continue;
    }
  }

  level.mystery_box_packed = 1;
  thread func_357B();
}

func_357C() {
  while(!isDefined(level.var_5F7F)) {
    wait(1);
  }

  maps\mp\zombies\_zombies_magicbox::func_7CEA("fliegerfaust_zm");
}

func_357B() {
  var_00 = [];
  var_01 = undefined;
  foreach(var_03 in level.var_5F7F) {
    var_04 = lib_0547::func_AAF9(var_03["baseNameNoMP"], undefined, 1);
    var_01 = lib_0547::func_9475(var_04) + "_pap_zm";
    if(!lib_0547::func_5843(var_01)) {
      continue;
    }

    if(isDefined(var_01)) {
      maps\mp\zombies\_zombies_magicbox::func_7CEA(var_03["baseNameNoMP"]);
      maps\mp\zombies\_zombies_magicbox::func_9C8(var_01, "none", "none", "none");
    }
  }

  maps\mp\zombies\_zombies_magicbox::func_9C8("kar98_pap_zm", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("luger_pap_zm", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("m30_pap_zm", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("model21_pap_zm", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("m1a1_pap_zm", "none", "none", "none");
  maps\mp\zombies\_zombies_magicbox::func_9C8("m712_pap_zm", "none", "none", "none");
}

func_3579() {
  self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
  self.var_4DC9 = 1;
  var_0A = (0, 0, 0);
  if(self.model == "ger_oil_lamp_01_a") {
    var_0A = (0, 0, 8);
  } else if(self.model == "ger_oil_lamp_01_b") {
    var_0A = (0, 0, -23);
  }

  playFX(common_scripts\utility::func_44F5("ee_lamp_fx"), self.origin + var_0A, anglesToForward(self.angles), anglestoup(self.angles));
  lib_0378::func_8D74("ee_update");
  var_0B = 1;
  foreach(var_0D in level.var_5AF2) {
    if(!var_0D.var_4DC9) {
      var_0B = 0;
    }
  }

  if(var_0B) {
    common_scripts\utility::func_3C8F("flag_all_lamps_hit");
  }
}

func_AA3D() {
  if(!0) {
    var_00 = getEntArray("zbarrier_window", "script_noteworthy");
    foreach(var_02 in var_00) {
      var_02 makeunusable();
    }
  }
}

func_327D() {
  level.var_65F6 = getEntArray("mysterybox_door", "targetname");
  foreach(var_01 in level.var_65F6) {
    var_02 = getEntArray(var_01.target, "targetname");
    foreach(var_04 in var_02) {
      if(!isDefined(var_04.script_noteworthy)) {
        continue;
      }

      var_05 = var_04.script_noteworthy;
      switch (var_05) {
        case "door_model":
          var_01.var_326B = var_04;
          var_06 = common_scripts\utility::func_46B5(var_04.target, "targetname");
          var_07 = common_scripts\utility::func_46B5(var_06.target, "targetname");
          var_01.var_6BE3 = var_06.angles;
          var_01.var_2443 = var_07.angles;
          break;

        case "door_model_r":
          var_01.var_326D = var_04;
          var_08 = common_scripts\utility::func_46B5(var_04.target, "targetname");
          var_09 = common_scripts\utility::func_46B5(var_08.target, "targetname");
          var_01.var_6BF2 = var_08.origin;
          var_01.var_2446 = var_09.origin;
          break;

        case "door_model_l":
          var_01.var_326C = var_04;
          var_0A = common_scripts\utility::func_46B5(var_04.target, "targetname");
          var_0B = common_scripts\utility::func_46B5(var_0A.target, "targetname");
          var_01.var_6BF1 = var_0A.origin;
          var_01.var_2445 = var_0B.origin;
          break;

        default:
          break;
      }
    }

    func_3281(var_01, 0);
  }
}

func_327C() {
  level.var_4EE7 = getEntArray("house_door", "targetname");
  foreach(var_01 in level.var_4EE7) {
    var_02 = getEnt(var_01.target, "targetname");
    var_03 = common_scripts\utility::func_46B5(var_02.target, "targetname");
    var_04 = common_scripts\utility::func_46B5(var_03.target, "targetname");
    var_01.var_326B = var_02;
    var_01.var_6BE3 = var_03.angles;
    var_01.var_2443 = var_04.angles;
  }
}

func_3281(param_00, param_01) {
  if(common_scripts\utility::func_562E(param_01)) {
    if(isDefined(param_00.var_326C) && isDefined(param_00.var_326D)) {
      if(param_00.var_326C.origin != param_00.var_6BF1) {
        param_00.var_326C moveTo(param_00.var_6BF1, 1, 0.25, 0.5);
      }

      if(param_00.var_326D.origin != param_00.var_6BF2) {
        param_00.var_326D moveTo(param_00.var_6BF2, 1, 0.25, 0.5);
      }
    } else if(param_00.var_326B.angles != param_00.var_6BE3) {
      param_00.var_326B rotateTo(param_00.var_6BE3, 1, 0.25, 0.5);
    }

    param_00 notsolid();
    param_00 method_8060();
    return;
  }

  if(isDefined(param_00.var_326C) && isDefined(param_00.var_326D)) {
    if(param_00.var_326C.origin != param_00.var_2445) {
      param_00.var_326C moveTo(param_00.var_2445, 1, 0.25, 0.5);
    }

    if(param_00.var_326D.origin != param_00.var_2446) {
      param_00.var_326D moveTo(param_00.var_2446, 1, 0.25, 0.5);
    }
  } else if(param_00.var_326B.angles != param_00.var_2443) {
    param_00.var_326B rotateTo(param_00.var_2443, 1, 0.25, 0.5);
  }

  param_00 solid();
  param_00 method_805F();
}

func_325F() {
  var_00 = "house_to_end";
  foreach(var_02 in level.var_AC1D) {
    if(lib_0547::func_5565(var_02.var_819A, var_00)) {
      return var_02;
    }
  }
}

func_4EF6() {
  if(level.var_A980 == 6) {
    level.var_7F1B = 5;
  }

  if(level.var_A980 == 7) {
    level.var_7F1B = 4;
  }

  if(level.var_A980 == 8) {
    level.var_7F1B = 3;
  }

  if(level.var_A980 == 9) {
    level.var_7F1B = 2;
  }

  if(level.var_A980 == 10) {
    level.var_7F1B = 1;
  }

  if(level.var_A980 == 50) {
    lib_0564::func_3C11(0);
  }
}

func_4EED(param_00) {
  switch (param_00) {
    case "cash":
      lib_0547::func_ABC9(self, 0);
      break;

    case "round":
      lib_0547::func_ABC9(self, 3);
      break;

    case "weapon":
      lib_0547::func_ABC9(self, 6);
      break;

    case "ability":
      lib_0547::func_ABC9(self, 1);
      break;

    case "consumable":
      lib_0547::func_ABC9(self, 2);
      break;

    case "all":
      self setclientomnvar("ui_hide_hud", 1);
      break;
  }
}