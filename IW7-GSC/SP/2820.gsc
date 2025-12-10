/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2820.gsc
************************/

func_94F9() {
  precacheshader("specialty_ammo_crate");
  precachemodel("frag_grenade_wm");
  precachemodel("emp_grenade_wm");
  precachemodel("seeker_grenade_folded");
  precachemodel("anti_grav_grenade_wm");
  precachemodel("veh_mil_air_un_pocketdrone_folded_wm");
  precachemodel("weapon_retract_shield_folded_vm");
  precachemodel("equipment_memory_chip_01");
  precachemodel("foam_grenade_wm");
  precachemodel("equipment_mp_nanoshot");
  precachemodel("helmet_hero_protagonist");
  precachemodel("equipment_pickup_plane_01");
  var_00 = scripts\engine\utility::getstructarray("ammo_pickup", "targetname");
  var_01 = scripts\engine\utility::getstructarray("equipment_pickup", "targetname");
  scripts\engine\utility::array_thread(var_00, ::func_4842, "ammo");
  scripts\engine\utility::array_thread(var_01, ::func_4842, "equipment");
  precachestring(&"EQUIPMENT_PICKUP_SEEKER");
  precachestring(&"EQUIPMENT_PICKUP_SHIELD");
  precachestring(&"EQUIPMENT_PICKUP_EMP");
  precachestring(&"EQUIPMENT_PICKUP_ANTIGRAV");
  precachestring(&"EQUIPMENT_PICKUP_DRONE");
  precachestring(&"EQUIPMENT_PICKUP_FRAG");
  precachestring(&"EQUIPMENT_PICKUP_HACK");
  precachestring(&"EQUIPMENT_PICKUP_COVER");
  precachestring(&"EQUIPMENT_PICKUP_NANOSHOT");
  precachestring(&"EQUIPMENT_PICKUP_HELMET");
  precachestring(&"EQUIPMENT_FULL_SEEKER");
  precachestring(&"EQUIPMENT_FULL_SHIELD");
  precachestring(&"EQUIPMENT_FULL_EMP");
  precachestring(&"EQUIPMENT_FULL_ANTIGRAV");
  precachestring(&"EQUIPMENT_FULL_DRONE");
  precachestring(&"EQUIPMENT_FULL_FRAG");
  precachestring(&"EQUIPMENT_FULL_HACK");
  precachestring(&"EQUIPMENT_FULL_COVER");
  precachestring(&"EQUIPMENT_FULL_NANOSHOT");
  precachestring(&"EQUIPMENT_FULL_HELMET");
  scripts\engine\utility::flag_init("heavy_weapon_refilled");
  scripts\sp\utility::func_16EB("heavy_weapon_refill", &"WEAPON_CACHE_HEAVY_WEAPON_HINT", ::func_8CF7);
}

spawn_equipment_crate(param_00, param_01, param_02, param_03) {
  var_04 = spawn("script_model", param_01);
  var_04.angles = param_02;
  var_04 setModel("container_equipment_crate_no_lid");
  var_04 notsolid();
  var_05 = spawn("script_model", param_01);
  var_05.angles = param_02;
  var_05 setModel("equipment_pickup_plane_01");
  var_05 notsolid();
  var_06 = spawnStruct();
  var_06.origin = param_01 + (0, 0, 13);
  var_06.script_noteworthy = param_00 + "_pickup";
  if(isDefined(param_03)) {
    var_06.var_EDE7 = param_03;
  }

  var_06 thread func_4842("equipment");
}

func_4842(param_00, param_01) {
  level.player endon("death");
  var_02 = spawn("script_origin", self.origin);
  self.var_99F7 = var_02;
  if(isDefined(self.angles)) {
    var_02.angles = self.angles;
  }

  if(isDefined(self.dont_spawn_models)) {
    var_02.dont_spawn_models = 1;
    self.dont_spawn_models = undefined;
  }

  var_02 endon("remove_pickup_cache");
  scripts\engine\utility::waitframe();
  var_02.var_AE46 = undefined;
  var_02.var_6698 = [];
  var_03 = undefined;
  var_04 = 0.75;
  var_02.var_3860 = 1;
  var_02.var_74B3 = 1;
  var_02.var_6694 = [];
  if(isDefined(self.script_parameters)) {
    var_02 thread func_484C(self.script_parameters, param_00);
  }

  if(!isDefined(level.player.var_13102)) {
    level.player.var_13102 = 0;
  }

  if(isDefined(self.script_noteworthy)) {
    var_05 = strtok(self.script_noteworthy, "_");
    var_02.weapon_name = var_05[0];
    if(var_02.weapon_name != "contextual") {
      var_02.var_1E2D = weaponmaxammo(var_02.weapon_name);
    }

    if(isDefined(self.var_EDE7)) {
      var_02.var_1E2D = self.var_EDE7;
    }
  }

  var_06 = &"WEAPON_CACHE_USE_HINT";
  if(param_00 == "equipment") {
    if(isDefined(var_02.weapon_name) && var_02.weapon_name == "nanoshot" || var_02.weapon_name == "helmet") {
      var_02.can_save = 1;
    }

    while(distancesquared(self.origin, level.player.origin) > squared(1500)) {
      wait(1);
    }

    if(var_02.weapon_name == "contextual") {
      var_02 = var_02 func_4846();
    }

    var_02 thread func_4845();
    var_02 thread func_4849(1500);
    var_04 = 0.75;
  }

  for(;;) {
    if(param_00 == "ammo") {
      var_02.var_74B3 = 0;
      if(isstruct(self)) {
        var_02 lib_0E46::func_48C4(undefined, undefined, var_06, 40, 300, undefined, 1, undefined, undefined, &"hud_interaction_prompt_center_ammo");
      } else {
        var_02 lib_0E46::func_48C4("tag_origin", (0, 0, 50), var_06, 40, 300, undefined, 1, undefined, undefined, &"hud_interaction_prompt_center_ammo");
      }
    }

    var_02 waittill("trigger", var_07);
    if(!level.player scripts\engine\utility::isusabilityallowed()) {
      level.player notify("picked_up_equipment");
      continue;
    }

    if(var_02.var_74B3) {
      level.player notify("picked_up_equipment");
      continue;
    }

    if(isDefined(var_07.var_593F)) {
      continue;
    }

    var_07.var_13102 = 1;
    var_02 notify("used_ammo_cache");
    if(isDefined(var_02.var_AE46)) {
      if(var_02.var_AE46 == "shieldxshield") {
        level.player giveweapon(var_02.weapon_name);
      } else if(var_02.var_AE46 == "primaryxprimary") {
        var_08 = level.player lib_0A2F::func_7BB5(var_02.weapon_name);
        if(scripts\sp\utility::func_7BD6() != var_08) {
          level.player notify("primary_equipment_switch_input");
        }

        level.player giveunifiedpoints(var_08);
        while(scripts\sp\utility::func_7BD6() != var_08) {
          wait(0.05);
        }

        var_09 = scripts\sp\utility::func_7BD7();
        var_0A = weaponmaxammo(var_08);
        var_0B = min(var_0A, var_09 + var_02.var_1E2D);
        var_0C = var_0B - var_09;
        var_02.var_1E2D = var_02.var_1E2D - var_0C;
        level.player setweaponammostock(var_08, int(var_0B));
      } else if(var_02.var_AE46 == "secondaryxsecondary") {
        var_08 = level.player lib_0A2F::func_7BB5(var_02.weapon_name);
        if(scripts\sp\utility::func_7C3D() != var_08) {
          level.player notify("secondary_equipment_switch_input");
        }

        level.player giveunifiedpoints(var_08);
        while(scripts\sp\utility::func_7C3D() != var_08) {
          wait(0.05);
        }

        var_09 = scripts\sp\utility::func_7C3E();
        var_0A = weaponmaxammo(var_08);
        var_0B = min(var_0A, var_09 + var_02.var_1E2D);
        var_0C = var_0B - var_09;
        var_02.var_1E2D = var_02.var_1E2D - var_0C;
        level.player setweaponammostock(var_08, int(var_0B));
      } else if(var_02.var_AE46 == "newequipment_primary" || var_02.var_AE46 == "newequipment_secondary") {
        if(var_02.var_AE46 == "newequipment_primary") {
          var_09 = scripts\sp\utility::func_7BD7();
          var_03 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7BD6());
        } else {
          var_09 = scripts\sp\utility::func_7C3E();
          var_03 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7C3D());
        }

        var_08 = level.player lib_0A2F::func_7BB5(var_02.weapon_name);
        level.player giveweapon(var_08);
        level.player setweaponammostock(var_08, int(var_02.var_1E2D));
        var_02.var_6694 = [];
        if(var_09 > 0) {
          var_02.var_1E2D = var_09;
          var_02.weapon_name = var_03;
        } else {
          var_02.weapon_name = "none";
        }
      } else if(var_02.var_AE46 == "newequipment_empty") {
        var_08 = level.player lib_0A2F::func_7BB5(var_02.weapon_name);
        level.player giveweapon(var_08);
        if(isDefined(self.var_EDE7)) {
          level.player setweaponammostock(var_08, self.var_EDE7);
          self.var_EDE7 = undefined;
        } else if(var_08 == "helmet" || var_08 == "nanoshot") {
          var_0A = weaponmaxammo(var_08);
          level.player setweaponammostock(var_08, var_0A);
        }

        var_02.weapon_name = "none";
        var_02.var_1E2D = 0;
      }
    } else {
      var_0D = var_07 getweaponslistall();
      var_0E = scripts\sp\utility::func_7BD6();
      var_0F = scripts\sp\utility::func_7C3D();
      var_10 = [var_0E, var_0F];
      var_10 = scripts\engine\utility::array_removeundefined(var_10);
      var_0D = scripts\engine\utility::array_remove_array(var_0D, var_10);
      var_11 = "";
      var_12 = 0;
      foreach(var_14 in var_0D) {
        if(lib_0A2F::func_DA40(var_14)) {
          var_12 = 1;
          var_11 = var_14;
          continue;
        }

        var_07 givemaxammo(var_14);
        var_15 = weaponclipsize(var_14);
      }

      if(var_12 && level.player getcurrentweapon() == var_11) {
        scripts\sp\utility::func_56BE("heavy_weapon_refill", 3);
        thread scripts\engine\utility::flag_set_delayed("heavy_weapon_refilled", 15);
      }
    }

    if(param_00 == "ammo") {
      var_07 playSound("player_refill_all_ammo");
    } else {
      var_07 playSound("intelligence_pickup");
    }

    if(scripts\sp\utility::func_93A6() && isDefined(var_02.can_save)) {
      thread scripts\sp\specialist_MAYBE::func_2683();
      var_02.can_save = undefined;
    }

    level.player scripts\sp\utility::func_D091("ges_pickup");
    wait(var_04);
    var_07.var_13102 = 0;
    level.player notify("picked_up_equipment");
    if((isDefined(var_02.var_1E2D) && var_02.var_1E2D < 1) || isDefined(var_02.weapon_name) && var_02.weapon_name == "none") {
      var_02 notify("out_of_ammo");
      for(var_17 = 0; var_17 < var_02.var_6698.size; var_17++) {
        if(isDefined(var_02.var_6698[var_17])) {
          var_02.var_6698[var_17] delete();
        }
      }

      var_02.var_6698 = [];
      var_02 delete();
      break;
    }

    var_02.var_AE46 = undefined;
    var_03 = undefined;
    scripts\engine\utility::waitframe();
  }
}

func_8CF7() {
  return scripts\engine\utility::flag("heavy_weapon_refilled");
}

func_484C(param_00, param_01) {
  var_02 = self;
  for(;;) {
    level waittill(param_00);
    if(isDefined(var_02)) {
      var_02.var_3860 = 0;
      thread lib_0E46::func_DFE3();
      self waittill("hint_destroyed");
      level.player notify("primary_equipment_switch");
      if(issubstr(param_00, "cleanup")) {
        if(isDefined(var_02.var_6698)) {
          for(var_03 = 0; var_03 < var_02.var_6698.size; var_03++) {
            if(isDefined(var_02.var_6698[var_03])) {
              var_02.var_6698[var_03] delete();
            }
          }
        }

        var_02 notify("remove_pickup_cache");
        var_02 delete();
        break;
      }
    } else {
      break;
    }

    level waittill(param_00);
    if(isDefined(var_02)) {
      var_02.var_3860 = 1;
      if(param_01 == "ammo") {
        var_02.var_74B3 = 0;
        var_04 = &"WEAPON_CACHE_USE_HINT";
        var_02 lib_0E46::func_48C4(undefined, undefined, var_04, 40, 300, undefined, 1, undefined, undefined, &"hud_interaction_prompt_center_ammo");
      }

      level.player notify("picked_up_equipment");
      continue;
    }

    break;
  }
}

func_4846() {
  var_00 = self;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = undefined;
  var_08 = undefined;
  var_09 = scripts\sp\utility::func_7BD6();
  var_0A = scripts\sp\utility::func_7CAF();
  var_0B = scripts\sp\utility::func_7C3D();
  var_0C = scripts\sp\utility::func_7CB1();
  if(isDefined(var_09) && var_09 != "nanoshot") {
    var_05 = weaponmaxammo(var_09);
  } else {
    var_09 = "frag";
    var_01 = 100;
  }

  if(isDefined(var_0A) && var_0A != "nanoshot") {
    var_06 = weaponmaxammo(var_0A);
  } else {
    var_0A = "frag";
    var_02 = 100;
  }

  if(isDefined(var_0B) && var_0B != "helmet") {
    var_07 = weaponmaxammo(var_0B);
  } else {
    var_0B = "offhandshield";
    var_03 = 100;
  }

  if(isDefined(var_0C) && var_0C != "helmet") {
    var_08 = weaponmaxammo(var_0C);
  } else {
    var_0C = "offhandshield";
    var_04 = 100;
  }

  var_0D = scripts\sp\utility::func_7BD7();
  var_0E = scripts\sp\utility::func_7CB0();
  var_0F = scripts\sp\utility::func_7C3E();
  var_10 = scripts\sp\utility::func_7CB2();
  if(!isDefined(var_01)) {
    var_01 = var_0D / var_05;
  }

  if(!isDefined(var_02)) {
    var_02 = var_0E / var_06;
  }

  if(!isDefined(var_03)) {
    var_03 = var_0F / var_07;
  }

  if(!isDefined(var_04)) {
    var_04 = var_10 / var_08;
  }

  if(var_01 <= var_02) {
    var_11 = var_09;
    var_12 = var_01;
  } else {
    var_11 = var_0C;
    var_12 = var_03;
  }

  if(var_03 <= var_04) {
    var_13 = var_0B;
    var_14 = var_03;
  } else {
    var_13 = var_0E;
    var_14 = var_05;
  }

  if(var_12 <= var_14) {
    var_00.weapon_name = scripts\sp\loadout::func_7C27(var_11);
    var_00.var_1E2D = weaponmaxammo(var_11);
  } else {
    var_00.weapon_name = scripts\sp\loadout::func_7C27(var_13);
    var_00.var_1E2D = weaponmaxammo(var_13);
  }

  return var_00;
}

func_4847() {
  self endon("remove_pickup_cache");
  var_00 = 1;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = undefined;
  var_08 = undefined;
  var_09 = undefined;
  wait(0.15);
  switch (self.weapon_name) {
    case "frag":
      var_01 = &"EQUIPMENT_PICKUP_FRAG";
      var_09 = func_4843("primary", self.weapon_name, &"EQUIPMENT_FULL_FRAG");
      break;

    case "emp":
      var_01 = &"EQUIPMENT_PICKUP_EMP";
      var_09 = func_4843("primary", self.weapon_name, &"EQUIPMENT_FULL_EMP");
      break;

    case "antigrav":
      var_01 = &"EQUIPMENT_PICKUP_ANTIGRAV";
      var_09 = func_4843("primary", self.weapon_name, &"EQUIPMENT_FULL_ANTIGRAV");
      break;

    case "seeker":
      var_01 = &"EQUIPMENT_PICKUP_SEEKER";
      var_09 = func_4843("primary", self.weapon_name, &"EQUIPMENT_FULL_SEEKER");
      break;

    case "nanoshot":
      var_01 = &"EQUIPMENT_PICKUP_NANOSHOT";
      var_09 = func_4843("primary", self.weapon_name, &"EQUIPMENT_FULL_NANOSHOT");
      break;

    case "supportdrone":
      var_01 = &"EQUIPMENT_PICKUP_DRONE";
      var_09 = func_4843("secondary", self.weapon_name, &"EQUIPMENT_FULL_DRONE");
      var_00 = 2;
      break;

    case "offhandshield":
      var_01 = &"EQUIPMENT_PICKUP_SHIELD";
      var_09 = func_4843("secondary", self.weapon_name, &"EQUIPMENT_FULL_SHIELD");
      var_00 = 2;
      break;

    case "hackingdevice":
      var_01 = &"EQUIPMENT_PICKUP_HACK";
      var_09 = func_4843("secondary", self.weapon_name, &"EQUIPMENT_FULL_HACK");
      var_00 = 2;
      break;

    case "coverwall":
      var_01 = &"EQUIPMENT_PICKUP_COVER";
      var_09 = func_4843("secondary", self.weapon_name, &"EQUIPMENT_FULL_COVER");
      var_00 = 2;
      break;

    case "helmet":
      var_01 = &"EQUIPMENT_PICKUP_HELMET";
      var_09 = func_4843("secondary", self.weapon_name, &"EQUIPMENT_FULL_HELMET");
      var_00 = 2;
      break;
  }

  return [var_09, var_01, var_00];
}

func_4843(param_00, param_01, param_02) {
  var_03 = level.player lib_0A2F::func_7BB5(param_01);
  var_04 = weaponmaxammo(var_03);
  var_05 = scripts\sp\loadout::func_7C27(param_01, 1);
  var_06 = [];
  if(param_00 == "primary") {
    var_07 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7BD6(), 1);
    if(isDefined(var_07) && var_07 == var_05) {
      if(scripts\sp\utility::func_7BD7() == var_04) {
        return param_02;
      }
    }

    var_07 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7CAF(), 1);
    if(isDefined(var_07) && var_07 == var_05) {
      if(scripts\sp\utility::func_7CB0() == var_04) {
        return param_02;
      }
    }
  } else {
    var_07 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7C3D(), 1);
    if(isDefined(var_07) && var_07 == var_05) {
      if(scripts\sp\utility::func_7C3E() == var_04 || var_07 == "offhandshield") {
        return param_02;
      }
    }

    var_07 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7CB1(), 1);
    if(isDefined(var_07) && var_07 == var_05) {
      if(scripts\sp\utility::func_7CB2() == var_04 || var_07 == "offhandshield") {
        return param_02;
      }
    }
  }

  return undefined;
}

func_4849(param_00) {
  self endon("death");
  for(;;) {
    while(distancesquared(self.origin, level.player.origin) > squared(param_00)) {
      wait(1);
    }

    func_484A();
    while(distancesquared(self.origin, level.player.origin) < squared(param_00)) {
      wait(1);
    }

    for(var_01 = 0; var_01 < self.var_6698.size; var_01++) {
      if(isDefined(self.var_6698[var_01])) {
        self.var_6698[var_01] delete();
      }
    }
  }
}

func_484A() {
  if(isDefined(self.dont_spawn_models)) {
    return;
  }

  var_00 = self.var_1E2D;
  var_01 = self.angles;
  var_02 = self.origin + (0, 0, 0);
  var_03 = (0, 0, 0);
  var_04 = undefined;
  var_05 = 2;
  var_06 = 2;
  var_07 = 0;
  var_08 = undefined;
  var_09 = undefined;
  var_0A = 0;
  var_0B = 0;
  var_0C = 0;
  var_0D = 0;
  var_0E = (0, 0, 0);
  var_0F = vectornormalize(anglesToForward(self.angles));
  var_10 = vectornormalize(anglestoright(self.angles));
  var_11 = vectornormalize(anglestoup(self.angles));
  if(isDefined(self.var_6698)) {
    for(var_12 = 0; var_12 < self.var_6698.size; var_12++) {
      if(isDefined(self.var_6698[var_12])) {
        self.var_6698[var_12] delete();
      }
    }
  } else {
    self.var_6698 = [];
  }

  if(self.weapon_name == "frag") {
    var_02 = self.origin + var_10 * 4;
    var_02 = var_02 + var_0F * 4;
    var_02 = var_02 + var_11 * 1.5;
    var_01 = (0, 0, 90);
    var_0A = 45;
    var_0B = 90;
    var_05 = 8;
    var_06 = 8;
    var_09 = "frag_grenade_wm";
  } else if(self.weapon_name == "emp") {
    var_02 = self.origin + var_10 * 4;
    var_02 = var_02 + var_0F * 4;
    var_02 = var_02 + var_11 * 1;
    var_01 = (0, 0, 90);
    var_0A = 45;
    var_05 = 8;
    var_06 = 8;
    var_09 = "emp_grenade_wm";
  } else if(self.weapon_name == "antigrav") {
    var_02 = self.origin + var_10 * 7;
    var_02 = var_02 + var_0F * 3.25;
    var_02 = var_02 + var_11;
    var_01 = (0, 0, -90);
    var_0A = 15;
    var_0B = 25;
    var_05 = 8;
    var_06 = 8;
    var_09 = "anti_grav_grenade_wm";
  } else if(self.weapon_name == "seeker") {
    var_02 = self.origin + var_10 * 4;
    var_02 = var_02 + var_0F * 4;
    var_02 = var_02 + var_11 * -1;
    var_0A = 5;
    var_05 = 8;
    var_06 = 8;
    var_01 = (0, 0, 0);
    var_09 = "seeker_grenade_folded";
  } else if(self.weapon_name == "supportdrone") {
    var_02 = self.origin + var_10 * 4.7;
    var_02 = var_02 + var_0F * 0.5;
    var_02 = var_02 + var_11 * 3;
    var_05 = 9;
    var_06 = 0;
    var_01 = (0, 0, 0);
    if(var_00 > 2) {
      var_00 = 2;
    }

    var_09 = "veh_mil_air_un_pocketdrone_folded_wm";
  } else if(self.weapon_name == "offhandshield") {
    var_00 = 1;
    var_02 = self.origin + var_10 * 2;
    var_02 = var_02 - var_0F * 2;
    var_02 = var_02 + var_11;
    var_01 = (0, 45, 0);
    var_09 = "weapon_retract_shield_folded_vm";
  } else if(self.weapon_name == "hackingdevice") {
    var_02 = self.origin + var_10 * 4;
    var_02 = var_02 + var_0F * 4;
    var_02 = var_02 + var_11;
    var_01 = (0, 270, 0);
    var_0A = 25;
    var_05 = 8;
    var_06 = 8;
    var_09 = "equipment_memory_chip_01";
  } else if(self.weapon_name == "coverwall") {
    var_02 = self.origin + var_10 * 4;
    var_02 = var_02 + var_0F * 4;
    var_02 = var_02 + var_11 * 1.65;
    var_01 = (0, 0, 90);
    var_0A = 45;
    var_0B = 90;
    var_05 = 8;
    var_06 = 8;
    var_09 = "foam_grenade_wm";
  } else if(self.weapon_name == "nanoshot") {
    var_02 = self.origin + var_10 * 4;
    var_02 = var_02 + var_0F * 4;
    var_02 = var_02 + var_11 * 0.5;
    var_01 = (0, 0, 90);
    var_0A = 45;
    var_05 = 8;
    var_06 = 8;
    var_09 = "equipment_mp_nanoshot";
  } else if(self.weapon_name == "helmet") {
    var_02 = self.origin + var_10 * -1;
    var_02 = var_02 + var_0F * 7.1;
    var_02 = var_02 + var_11 * -8.5;
    var_01 = (297, 227, -90);
    var_06 = 14;
    var_09 = "helmet_hero_protagonist";
  }

  if(var_06 > 0) {
    var_00 = var_00 / 2;
    if(var_00 != int(var_00)) {
      var_08 = var_00;
      var_00 = scripts\sp\utility::func_E753(var_00, 0, 0);
    }
  }

  var_03 = var_02;
  var_13 = var_02;
  for(var_14 = 0; var_14 < var_00; var_14++) {
    self.var_6698[var_14] = spawn("script_model", var_02);
    self.var_6698[var_14].origin = var_02;
    if(isDefined(self.var_6694[var_14])) {
      var_15 = self.var_6694[var_14];
    } else {
      if(var_0B != 0) {
        var_0D = randomintrange(-1 * var_0B, var_0B);
      }

      if(var_0A != 0) {
        var_0C = randomintrange(-1 * var_0A, var_0A);
      }

      var_15 = (var_0D, var_0C, 0);
      self.var_6694[var_14] = var_15;
    }

    self.var_6698[var_14].angles = combineangles(self.angles, var_01 + var_15);
    self.var_6698[var_14] setModel(var_09);
    if(var_14 <= var_00 / 2 - 1) {
      var_02 = var_02 - var_05 * var_10;
    } else {
      if(isDefined(var_03)) {
        var_02 = var_03;
        var_03 = undefined;
      }

      var_02 = var_02 + var_05 * var_10;
    }

    if(self.weapon_name == "helmet") {
      var_01 = (297, 33, -90);
    }
  }

  var_03 = var_13;
  if(var_06 > 0) {
    if(!var_07) {
      var_02 = var_13 - var_06 * var_0F;
    } else {
      var_02 = var_02 - var_06 * var_0F;
    }

    if(isDefined(var_08) && var_08 != int(var_08)) {
      var_00 = scripts\sp\utility::func_E753(var_08, 0, 1);
    }

    for(var_16 = var_14; var_16 < var_14 + var_00; var_16++) {
      self.var_6698[var_16] = spawn("script_model", var_02);
      self.var_6698[var_16].origin = var_02;
      if(isDefined(self.var_6694[var_16])) {
        var_15 = self.var_6694[var_16];
      } else {
        if(var_0B != 0) {
          var_0D = randomintrange(-1 * var_0B, var_0B);
        }

        if(var_0A != 0) {
          var_0C = randomintrange(-1 * var_0A, var_0A);
        }

        var_15 = (var_0D, var_0C, 0);
        self.var_6694[var_16] = var_15;
      }

      self.var_6698[var_16].angles = combineangles(self.angles, var_01 + var_15);
      self.var_6698[var_16] setModel(var_09);
      if(var_16 <= var_14 + var_00 / 2 - 1) {
        var_02 = var_02 - var_05 * var_10;
        continue;
      }

      if(isDefined(var_03)) {
        var_02 = var_03 - var_06 * var_0F;
        var_03 = undefined;
      }

      var_02 = var_02 + var_05 * var_10;
    }

    var_17 = var_16;
  } else {
    var_17 = var_15;
  }

  if(isDefined(var_04)) {
    self.var_6698[var_17] = spawn("script_model", self.origin);
    self.var_6698[var_17].origin = self.origin;
    self.var_6698[var_17].angles = var_01 + self.angles;
    self.var_6698[var_17] setModel(var_04);
  }
}

func_4845() {
  level.player endon("death");
  self endon("remove_pickup_cache");
  self endon("out_of_ammo");
  var_00 = func_4844();
  lib_0E46::func_48C4(undefined, (0, 0, 4), var_00, 40, 300, undefined, undefined, undefined, undefined, &"hud_interaction_prompt_center_equipment");
  for(;;) {
    while(distancesquared(self.origin, level.player.origin) < squared(500) && level.player.var_13102 == 0 && self.var_3860) {
      func_484A();
      var_00 = func_4844();
      thread lib_0E46::func_DFE3();
      self waittill("hint_destroyed");
      if(self.var_3860) {
        lib_0E46::func_48C4(undefined, (0, 0, 4), var_00, 40, 300, undefined, undefined, undefined, 0, &"hud_interaction_prompt_center_equipment");
        level.player scripts\engine\utility::waittill_any_3("picked_up_equipment", "equipment_change", "hackingdevice_end", "offhand_ammo", "item_ammo");
      }
    }

    wait(0.1);
  }
}

func_4844() {
  var_00 = func_4847();
  var_01 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7BD6());
  var_02 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7CAF());
  var_03 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7C3D());
  var_04 = scripts\sp\loadout::func_7C27(scripts\sp\utility::func_7CB1());
  if(!isDefined(var_01)) {
    var_01 = "none";
  }

  if(!isDefined(var_02)) {
    var_02 = "none";
  }

  if(!isDefined(var_03)) {
    var_03 = "none";
  }

  if(!isDefined(var_04)) {
    var_04 = "none";
  }

  if(var_00[2] == 1) {
    if(var_01 != "none" && var_02 != "none" || !scripts\sp\utility::func_D0C9()) {
      if(var_01 == self.weapon_name || var_02 == self.weapon_name) {
        self.var_AE46 = "primaryxprimary";
      } else {
        self.var_AE46 = "newequipment_primary";
      }
    } else if(var_01 == self.weapon_name || var_02 == self.weapon_name) {
      self.var_AE46 = "primaryxprimary";
    } else {
      self.var_AE46 = "newequipment_empty";
    }
  } else {
    if((var_03 == "offhandshield" || var_04 == "offhandshield") && self.weapon_name == "offhandshield") {
      self.var_AE46 = "shieldxshield";
    }

    if(var_00[2] == 2) {
      if(var_03 != "none" && var_04 != "none" || !scripts\sp\utility::func_D0C9()) {
        if(var_03 == self.weapon_name || var_04 == self.weapon_name) {
          self.var_AE46 = "secondaryxsecondary";
        } else {
          self.var_AE46 = "newequipment_secondary";
        }
      } else if(var_03 == self.weapon_name || var_04 == self.weapon_name) {
        self.var_AE46 = "secondaryxsecondary";
      } else {
        self.var_AE46 = "newequipment_empty";
      }
    } else {}
  }

  if(!isDefined(var_00[0])) {
    self.var_74B3 = 0;
    return var_00[1];
  }

  self.var_74B3 = 1;
  return var_00[0];
}

func_1E33(param_00) {
  if(param_00.alpha != 0) {
    return;
  }

  param_00 fadeovertime(0.2);
  param_00.alpha = 0.3;
  wait(0.2);
}

func_1E34(param_00) {
  if(param_00.alpha == 0) {
    return;
  }

  param_00 fadeovertime(0.2);
  param_00.alpha = 0;
  wait(0.2);
}