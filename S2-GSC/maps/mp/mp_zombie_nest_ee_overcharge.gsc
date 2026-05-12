/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_overcharge.gsc
****************************************************/

func_00F9() {
  for(var_00 = 1; var_00 <= 3; var_00++) {
    common_scripts\utility::func_3C87("quest_item_blimp_uberschnelle_" + var_00);
  }

  var_01 = maps\mp\mp_zombie_nest_ee_util::func_44C8("blimp_uberschnell_deposit");
  foreach(var_03 in var_01) {
    var_03 method_805C();
  }

  var_05 = getent("lhog_control", "targetname");
  if(isDefined(var_05)) {
    var_05 thread maps\mp\mp_zombie_nest_ee_util::func_4D77("off");
  }

  var_01[0] method_805B();
  playFXOnTag(level.var_0611["zmb_uberschnelle_charge"], var_01[0], "tag_origin");
  lib_0557::func_7846("6B Left Hand overcharge", ::func_6C9E, ["5 Right Hand fuses"], &"ZOMBIE_NEST_HINT_QUEST_OVERCHARGE", "ZOMBIE_NEST_HINT_QUEST_OVERCHARGE");
  lib_0557::func_781E("6B Left Hand overcharge", "examine left hand", ::func_7862, ::lib_0557::func_30D8, &"ZOMBIE_NEST_STUDY_LEFT_HAND");
  lib_0557::func_781E("6B Left Hand overcharge", "activate left hand", ::func_7861, ::func_714D, &"ZOMBIE_NEST_HINT_STEP_INTERACT_LEFT_HAND");
  lib_0557::func_7848("6B Left Hand overcharge");
  lib_0557::func_7846("6A Left Hand blimp parts", ::lib_0557::func_30D8, ["5 Right Hand fuses"], &"ZOMBIE_NEST_HINT_QUEST_BLIMP", "ZOMBIE_NEST_HINT_QUEST_BLIMP");
  lib_0557::func_781E("6A Left Hand blimp parts", "Blimp Battery Hunt", ::func_784B, ::lib_0557::func_30D8, &"ZOMBIE_NEST_BLIMP_ROAMING");
  lib_0557::func_7848("6A Left Hand blimp parts");
}

func_6C9E() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("lefthandofgod");
    var_01 lib_0378::func_8D74("objective_complete", "lefthandofgod");
  }
}

func_714D() {
  var_00 = getent("left_hand_of_god_model", "targetname");
  playFXOnTag(level.var_0611["zmb_lhog_init"], var_00, "tag_origin");
}

func_7862() {
  level notify("nest_ee_fuses_complete");
  var_00 = getent("overcharge_trig", "targetname");
  var_00.var_4D91 = lib_0559::func_7BE3(var_00, "lhog");
  var_00 sethintstring(&"ZOMBIES_SWITCH_HINT_GENERIC_EXAMINE");
  var_00.var_17A9 = 0;
  var_01 = getent("left_hand_of_god_model", "targetname");
  var_02 = getent("lhog_control", "targetname");
  if(isDefined(var_02)) {
    var_02 thread maps\mp\mp_zombie_nest_ee_util::func_4D77("red");
  }

  if(1) {
    var_03 = lib_0557::func_782F(undefined, [var_01]);
    lib_0557::func_781D("6B Left Hand overcharge", var_03);
  }

  var_01 thread func_20C7(var_00);
  var_04 = maps\mp\mp_zombie_nest_ee_util::func_44C8("blimp_uberschnell_deposit");
  var_00 thread func_8C24();
  while(var_00.var_17A9 < 3) {
    level thread func_92B6(var_00);
    var_00 waittill("trigger", var_08);
    if(var_08 lib_0585::func_9E12("Blimp Battery Hunt")) {
      var_00.var_17A9++;
      var_00 notify("blimp part was deposited");
      if(var_00.var_17A9 == 1) {
        thread func_2E9C(1, var_08);
        lib_0557::func_7822("6B Left Hand overcharge", &"ZOMBIE_NEST_HINT_STEP_MORE_BATTERIES");
      } else if(var_00.var_17A9 == 2) {
        thread func_2E9C(2, var_08);
      } else if(var_00.var_17A9 == 3) {
        thread func_2E9C(3, var_08);
      }

      var_04[var_00.var_17A9] method_805B();
      playFXOnTag(level.var_0611["zmb_uberschnelle_charge"], var_04[var_00.var_17A9], "tag_origin");
      lib_0378::func_8D74("aud_uberschnelle_place_altar");
      func_86A4();
      common_scripts\utility::func_3C8F("quest_item_blimp_uberschnelle_" + var_00.var_17A9);
    }
  }

  var_00 notify("stop_hide_show");
  wait 0.05;
  var_00 common_scripts\utility::func_9DA3();
  lib_0557::func_782D("6A Left Hand blimp parts", "Blimp Battery Hunt");
  lib_0557::func_782D("6B Left Hand overcharge", "examine left hand");
}

func_92B6(param_00) {
  param_00 notify("start zombie blocking behavior");
  param_00 endon("start zombie blocking behavior");
  param_00 endon("blimp part was deposited");
  level waittill("player grabbed uber battery");
  var_01 = common_scripts\utility::func_46B7("zombie_spawner", "script_noteworthy");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_81A1) && var_03.var_81A1 == "zombie_blimp_player_blocker") {
      var_03 childthread func_179C();
    }
  }
}

func_179C() {
  self.var_686D = randomint(3) + 1;
  if(isDefined(self.var_01A2)) {
    self.var_301B = common_scripts\utility::func_46B5(self.var_01A2, "targetname");
  }

  while(self.var_686D > 0) {
    foreach(var_01 in level.var_744A) {
      if(isDefined(self.var_301B)) {
        var_02 = distance(self.var_301B.var_0116, var_01.var_0116) < 150;
      } else {
        var_02 = distance(var_01.var_0116, self.var_0116) < 512;
      }

      if(var_01 lib_0586::func_72C3() && var_02) {
        var_03 = self.var_686D;
        for(var_04 = 0; var_04 < var_03; var_04++) {
          var_05 = lib_054D::func_90BA("zombie_generic", self, "blimp part blocker", 0, 1, 1);
          self.var_686D--;
          wait(2);
        }
      }
    }

    wait(0.125);
  }
}

func_7861() {
  var_00 = getent("left_hand_of_god_model", "targetname");
  var_01 = getent("overcharge_trig", "targetname");
  var_01 sethintstring(&"ZOMBIE_NEST_ENABLE_LEFT_HAND");
  if(1) {
    var_02 = undefined;
    if(isDefined(var_00)) {
      var_02 = lib_0557::func_782F(undefined, [var_00]);
      lib_0557::func_781D("6B Left Hand overcharge", var_02);
    }
  }

  wait(0.5);
  var_01 waittill("trigger", var_03);
  var_04 = getent("lhog_control", "targetname");
  if(isDefined(var_04)) {
    var_04 thread maps\mp\mp_zombie_nest_ee_util::func_4D76();
    var_04 thread maps\mp\mp_zombie_nest_ee_util::func_4D77("green");
  }

  thread func_2E73(var_03);
  var_01 common_scripts\utility::func_9D9F();
  var_00 lib_0378::func_8D74("aud_activate_left_hand_of_god");
  thread maps\mp\mp_zombie_nest_ee_util::func_4D78(2);
  lib_0557::func_782D("6B Left Hand overcharge", "activate left hand");
}

func_8C24() {
  self endon("stop_hide_show");
  var_00 = self.var_0116;
  for(;;) {
    var_01 = 0;
    foreach(var_03 in level.var_744A) {
      if(var_03 lib_0586::func_72C3() && distance(var_03.var_0116, var_00) < 256) {
        var_01 = 1;
        break;
      }
    }

    if(var_01) {
      common_scripts\utility::func_9DA3();
    } else {
      common_scripts\utility::func_9D9F();
    }

    wait(0.5);
  }
}

func_784B() {
  level.var_179A lib_0560::func_AB83();
  var_00 = 0;
  while(!var_00) {
    foreach(var_02 in level.var_744A) {
      if(var_02 maps\mp\mp_zombie_nest_ee_util::func_740A()) {
        var_00 = 1;
        break;
      }
    }

    wait(1);
  }

  while(!isDefined(level.var_179A.var_6655)) {
    wait(1);
  }

  thread func_86A7(level.var_179A.var_6655);
}

func_40C0(param_00) {
  return "quest_item_blimp_uberschnelle_" + param_00;
}

func_41E7() {
  return lib_0557::func_7838("6B Left Hand overcharge", "activate left hand", 1);
}

func_95F4() {
  level notify("nest_ee_overcharge_remove_uberschnell_hint");
  wait 0.05;
  self.var_65DF delete();
  self notify("blimp_part_deposited");
}

func_2E9C(param_00, param_01) {
  if(!isDefined(param_00) || !isDefined(param_01)) {
    return;
  }

  switch (param_00) {
    case 1:
      param_01 thread lib_0367::func_8E3C("lefthandaltaruber1");
      break;

    case 2:
      param_01 thread lib_0367::func_8E3C("lefthandaltaruber2");
      break;

    case 3:
      param_01 thread lib_0367::func_8E3C("lefthandaltaruber3");
      break;
  }
}

func_2E73(param_00) {
  param_00 thread lib_0367::func_8E3C("lefthandaltaractivated");
}

func_A788(param_00, param_01) {
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    return;
  }

  param_01 thread func_A787(param_00);
  level waittill(param_00, param_01);
  if(!common_scripts\utility::func_562E(param_01.var_73E3)) {
    func_86A5(param_01);
  }
}

func_A787(param_00) {
  level endon(param_00);
  for(;;) {
    var_01 = common_scripts\utility::func_4461(self.var_0116, level.var_744A, 200);
    if(isDefined(var_01)) {
      break;
    } else {
      wait(1);
    }
  }

  func_86A5(self);
  self.var_73E3 = 1;
}

func_86A7(param_00) {
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    return;
  }

  var_01 = undefined;
  if(0) {
    var_01 = lib_0557::func_782F(undefined, [param_00]);
    lib_0557::func_781D("6A Left Hand blimp parts", var_01);
  }

  lib_0557::func_7822("6A Left Hand blimp parts", &"ZOMBIE_NEST_SHOOT_BLIMP_GUN");
  level common_scripts\utility::func_A70A("destroyed_blimp_gun", "blimp_ee_look_for_battery");
  if(0) {
    lib_0557::func_7847("6A Left Hand blimp parts", var_01);
  }
}

func_86A4() {
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    return;
  }

  lib_0557::func_7822("6A Left Hand blimp parts", &"ZOMBIE_NEST_FINISH_ZEPPELIN_ZOMBIE_ROUND");
}

func_86A6() {
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    return;
  }

  level notify("blimp_ee_look_for_battery");
  lib_0557::func_7822("6A Left Hand blimp parts", &"ZOMBIE_NEST_FIND_DROPPED_BATTERY");
}

func_86A5(param_00) {
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    return;
  }

  var_01 = undefined;
  if(0) {
    var_01 = lib_0557::func_782F(undefined, [param_00]);
    lib_0557::func_781D("6A Left Hand blimp parts", var_01);
  }

  lib_0557::func_7822("6A Left Hand blimp parts", &"ZOMBIE_NEST_BLIMP_KILL_ZOMBIES");
  level waittill("nest_ee_overcharge_remove_uberschnell_hint");
  if(0) {
    lib_0557::func_7847("6A Left Hand blimp parts", var_01);
  }
}

func_86A3() {
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    return;
  }

  lib_0557::func_7822("6A Left Hand blimp parts", &"ZOMBIE_NEST_BRING_BATTERY_TO_ALTER");
}

func_8C89() {
  if(common_scripts\utility::func_562E(level.var_1CBA) || common_scripts\utility::func_562E(level.var_5C6A)) {
    return;
  }

  level.var_5C6A = 0;
  var_00 = getent("overcharge_trig", "targetname");
  var_00 notify("bypassed");
}

func_20C7(param_00) {
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    return;
  }

  param_00 thread func_2EB0();
  param_00 thread func_2E8D();
  param_00 common_scripts\utility::func_A70A("trigger", "soft_triggered", "bypassed");
  lib_0557::func_7822("6B Left Hand overcharge", &"ZOMBIE_NEST_HINT_STEP_BATTERIES");
  param_00 sethintstring(&"ZOMBIE_NEST_PLACE_UBER");
  param_00 notify("discovered");
}

func_2E8D() {
  self endon("discovered");
  self waittill("trigger", var_00);
  var_00 thread lib_0367::func_8E3C("lefthandaltarclue");
}

func_2EB0() {
  if(common_scripts\utility::func_562E(level.var_1CBA)) {
    return;
  }

  self endon("discovered");
  var_00 = 0;
  var_01 = 0.7;
  var_02 = 0.05;
  var_03 = undefined;
  for(;;) {
    var_04 = 0;
    foreach(var_06 in level.var_744A) {
      if(distance(var_06.var_0116, self.var_0116) < 64) {
        var_04 = 1;
        var_03 = var_06;
      }
    }

    if(var_04) {
      var_00 = var_00 + var_02;
    } else {
      var_00 = 0;
    }

    if(var_00 >= var_01) {
      if(isDefined(var_03)) {
        var_03 thread lib_0367::func_8E3C("lefthandaltarclue");
      }

      self notify("soft_triggered");
      break;
    }

    wait(var_02);
  }
}