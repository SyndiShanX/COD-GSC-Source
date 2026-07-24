/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2820.gsc
**************************************/

_id_94F9() {
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
  var_0 = scripts\engine\utility::getStructArray("ammo_pickup", "targetname");
  var_1 = scripts\engine\utility::getStructArray("equipment_pickup", "targetname");
  scripts\engine\utility::array_thread(var_0, ::_id_4842, "ammo");
  scripts\engine\utility::array_thread(var_1, ::_id_4842, "equipment");
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
  scripts\sp\utility::_id_16EB("heavy_weapon_refill", &"WEAPON_CACHE_HEAVY_WEAPON_HINT", ::_id_8CF7);
}

spawn_equipment_crate(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_1);
  var_4.angles = var_2;
  var_4 setModel("container_equipment_crate_no_lid");
  var_4 notsolid();
  var_5 = spawn("script_model", var_1);
  var_5.angles = var_2;
  var_5 setModel("equipment_pickup_plane_01");
  var_5 notsolid();
  var_6 = spawnStruct();
  var_6.origin = var_1 + (0, 0, 13);
  var_6.script_noteworthy = var_0 + "_pickup";

  if(isDefined(var_3)) {
    var_6._id_EDE7 = var_3;
  }

  var_6 thread _id_4842("equipment");
}

_id_4842(var_0, var_1) {
  level.player endon("death");
  var_2 = spawn("script_origin", self.origin);
  self._id_99F7 = var_2;

  if(isDefined(self.angles)) {
    var_2.angles = self.angles;
  }

  if(isDefined(self.dont_spawn_models)) {
    var_2.dont_spawn_models = 1;
    self.dont_spawn_models = undefined;
  }

  var_2 endon("remove_pickup_cache");
  scripts\engine\utility::waitframe();
  var_2._id_AE46 = undefined;
  var_2._id_6698 = [];
  var_3 = undefined;
  var_4 = 0.75;
  var_2._id_3860 = 1;
  var_2._id_74B3 = 1;
  var_2._id_6694 = [];

  if(isDefined(self.script_parameters)) {
    var_2 thread _id_484C(self.script_parameters, var_0);
  }

  if(!isDefined(level.player._id_13102)) {
    level.player._id_13102 = 0;
  }

  if(isDefined(self.script_noteworthy)) {
    var_5 = strtok(self.script_noteworthy, "_");
    var_2.weapon_name = var_5[0];

    if(var_2.weapon_name != "contextual") {
      var_2._id_1E2D = weaponmaxammo(var_2.weapon_name);
    }

    if(isDefined(self._id_EDE7)) {
      var_2._id_1E2D = self._id_EDE7;
    }
  }

  var_6 = &"WEAPON_CACHE_USE_HINT";

  if(var_0 == "equipment") {
    if(isDefined(var_2.weapon_name) && (var_2.weapon_name == "nanoshot" || var_2.weapon_name == "helmet")) {
      var_2.can_save = 1;
    }

    while(distancesquared(self.origin, level.player.origin) > squared(1500)) {
      wait 1;
    }

    if(var_2.weapon_name == "contextual") {
      var_2 = var_2 _id_4846();
    }

    var_2 thread _id_4845();
    var_2 thread _id_4849(1500);
    var_4 = 0.75;
  }

  for(;;) {
    if(var_0 == "ammo") {
      var_2._id_74B3 = 0;

      if(isstruct(self)) {
        var_2 _id_0E46::_id_48C4(undefined, undefined, var_6, 40, 300, undefined, 1, undefined, undefined, &"hud_interaction_prompt_center_ammo");
      } else {
        var_2 _id_0E46::_id_48C4("tag_origin", (0, 0, 50), var_6, 40, 300, undefined, 1, undefined, undefined, &"hud_interaction_prompt_center_ammo");
      }
    }

    var_2 waittill("trigger", var_7);

    if(!level.player scripts\engine\utility::isusabilityallowed()) {
      level.player notify("picked_up_equipment");
      continue;
    }

    if(var_2._id_74B3) {
      level.player notify("picked_up_equipment");
      continue;
    }

    if(isDefined(var_7._id_593F)) {
      continue;
    }
    var_7._id_13102 = 1;
    var_2 notify("used_ammo_cache");

    if(isDefined(var_2._id_AE46)) {
      if(var_2._id_AE46 == "shieldxshield") {
        level.player giveweapon(var_2.weapon_name);
      } else if(var_2._id_AE46 == "primaryxprimary") {
        var_8 = level.player _id_0A2F::_id_7BB5(var_2.weapon_name);

        if(scripts\sp\utility::_id_7BD6() != var_8) {
          level.player notify("primary_equipment_switch_input");
        }

        level.player _meth_83B4(var_8);

        while(scripts\sp\utility::_id_7BD6() != var_8) {
          wait 0.05;
        }

        var_9 = scripts\sp\utility::_id_7BD7();
        var_10 = weaponmaxammo(var_8);
        var_11 = min(var_10, var_9 + var_2._id_1E2D);
        var_12 = var_11 - var_9;
        var_2._id_1E2D = var_2._id_1E2D - var_12;
        level.player setweaponammostock(var_8, int(var_11));
      } else if(var_2._id_AE46 == "secondaryxsecondary") {
        var_8 = level.player _id_0A2F::_id_7BB5(var_2.weapon_name);

        if(scripts\sp\utility::_id_7C3D() != var_8) {
          level.player notify("secondary_equipment_switch_input");
        }

        level.player _meth_83B4(var_8);

        while(scripts\sp\utility::_id_7C3D() != var_8) {
          wait 0.05;
        }

        var_9 = scripts\sp\utility::_id_7C3E();
        var_10 = weaponmaxammo(var_8);
        var_11 = min(var_10, var_9 + var_2._id_1E2D);
        var_12 = var_11 - var_9;
        var_2._id_1E2D = var_2._id_1E2D - var_12;
        level.player setweaponammostock(var_8, int(var_11));
      } else if(var_2._id_AE46 == "newequipment_primary" || var_2._id_AE46 == "newequipment_secondary") {
        if(var_2._id_AE46 == "newequipment_primary") {
          var_9 = scripts\sp\utility::_id_7BD7();
          var_3 = scripts\sp\loadout::_id_7C27(scripts\sp\utility::_id_7BD6());
        } else {
          var_9 = scripts\sp\utility::_id_7C3E();
          var_3 = scripts\sp\loadout::_id_7C27(scripts\sp\utility::_id_7C3D());
        }

        var_8 = level.player _id_0A2F::_id_7BB5(var_2.weapon_name);
        level.player giveweapon(var_8);
        level.player setweaponammostock(var_8, int(var_2._id_1E2D));
        var_2._id_6694 = [];

        if(var_9 > 0) {
          var_2._id_1E2D = var_9;
          var_2.weapon_name = var_3;
        } else
          var_2.weapon_name = "none";
      } else if(var_2._id_AE46 == "newequipment_empty") {
        var_8 = level.player _id_0A2F::_id_7BB5(var_2.weapon_name);
        level.player giveweapon(var_8);

        if(isDefined(self._id_EDE7)) {
          level.player setweaponammostock(var_8, self._id_EDE7);
          self._id_EDE7 = undefined;
        } else if(var_8 == "helmet" || var_8 == "nanoshot") {
          var_10 = weaponmaxammo(var_8);
          level.player setweaponammostock(var_8, var_10);
        }

        var_2.weapon_name = "none";
        var_2._id_1E2D = 0;
      }
    } else {
      var_13 = var_7 getweaponslistall();
      var_14 = scripts\sp\utility::_id_7BD6();
      var_15 = scripts\sp\utility::_id_7C3D();
      var_16 = [var_14, var_15];
      var_16 = scripts\engine\utility::array_removeundefined(var_16);
      var_13 = scripts\engine\utility::array_remove_array(var_13, var_16);
      var_17 = "";
      var_18 = 0;

      foreach(var_20 in var_13) {
        if(_id_0A2F::_id_DA40(var_20)) {
          var_18 = 1;
          var_17 = var_20;
          continue;
        }

        var_7 givemaxammo(var_20);
        var_21 = weaponclipsize(var_20);
      }

      if(var_18 && level.player getcurrentweapon() == var_17) {
        scripts\sp\utility::_id_56BE("heavy_weapon_refill", 3);
        thread scripts\engine\utility::flag_set_delayed("heavy_weapon_refilled", 15);
      }
    }

    if(var_0 == "ammo") {
      var_7 playSound("player_refill_all_ammo");
    } else {
      var_7 playSound("intelligence_pickup");
    }

    if(scripts\sp\utility::_id_93A6() && isDefined(var_2.can_save)) {
      thread scripts\sp\specialist_MAYBE::_id_2683();
      var_2.can_save = undefined;
    }

    level.player scripts\sp\utility::_id_D091("ges_pickup");
    wait(var_4);
    var_7._id_13102 = 0;
    level.player notify("picked_up_equipment");

    if(isDefined(var_2._id_1E2D) && var_2._id_1E2D < 1 || isDefined(var_2.weapon_name) && var_2.weapon_name == "none") {
      var_2 notify("out_of_ammo");

      for(var_23 = 0; var_23 < var_2._id_6698.size; var_23++) {
        if(isDefined(var_2._id_6698[var_23])) {
          var_2._id_6698[var_23] delete();
        }
      }

      var_2._id_6698 = [];
      var_2 delete();
      break;
    }

    var_2._id_AE46 = undefined;
    var_3 = undefined;
    scripts\engine\utility::waitframe();
  }
}

_id_8CF7() {
  return scripts\engine\utility::flag("heavy_weapon_refilled");
}

_id_484C(var_0, var_1) {
  var_2 = self;

  for(;;) {
    level waittill(var_0);

    if(isDefined(var_2)) {
      var_2._id_3860 = 0;
      thread _id_0E46::_id_DFE3();
      self waittill("hint_destroyed");
      level.player notify("primary_equipment_switch");

      if(issubstr(var_0, "cleanup")) {
        if(isDefined(var_2._id_6698)) {
          for(var_3 = 0; var_3 < var_2._id_6698.size; var_3++) {
            if(isDefined(var_2._id_6698[var_3])) {
              var_2._id_6698[var_3] delete();
            }
          }
        }

        var_2 notify("remove_pickup_cache");
        var_2 delete();
        break;
      }
    } else
      break;

    level waittill(var_0);

    if(isDefined(var_2)) {
      var_2._id_3860 = 1;

      if(var_1 == "ammo") {
        var_2._id_74B3 = 0;
        var_4 = &"WEAPON_CACHE_USE_HINT";
        var_2 _id_0E46::_id_48C4(undefined, undefined, var_4, 40, 300, undefined, 1, undefined, undefined, &"hud_interaction_prompt_center_ammo");
      }

      level.player notify("picked_up_equipment");
      continue;
    }

    break;
  }
}

_id_4846() {
  var_0 = self;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = scripts\sp\utility::_id_7BD6();
  var_10 = scripts\sp\utility::_id_7CAF();
  var_11 = scripts\sp\utility::_id_7C3D();
  var_12 = scripts\sp\utility::_id_7CB1();

  if(isDefined(var_9) && var_9 != "nanoshot") {
    var_5 = weaponmaxammo(var_9);
  } else {
    var_9 = "frag";
    var_1 = 100;
  }

  if(isDefined(var_10) && var_10 != "nanoshot") {
    var_6 = weaponmaxammo(var_10);
  } else {
    var_10 = "frag";
    var_2 = 100;
  }

  if(isDefined(var_11) && var_11 != "helmet") {
    var_7 = weaponmaxammo(var_11);
  } else {
    var_11 = "offhandshield";
    var_3 = 100;
  }

  if(isDefined(var_12) && var_12 != "helmet") {
    var_8 = weaponmaxammo(var_12);
  } else {
    var_12 = "offhandshield";
    var_4 = 100;
  }

  var_13 = scripts\sp\utility::_id_7BD7();
  var_14 = scripts\sp\utility::_id_7CB0();
  var_15 = scripts\sp\utility::_id_7C3E();
  var_16 = scripts\sp\utility::_id_7CB2();

  if(!isDefined(var_1)) {
    var_1 = var_13 / var_5;
  }

  if(!isDefined(var_2)) {
    var_2 = var_14 / var_6;
  }

  if(!isDefined(var_3)) {
    var_3 = var_15 / var_7;
  }

  if(!isDefined(var_4)) {
    var_4 = var_16 / var_8;
  }

  if(var_1 <= var_2) {
    var_17 = var_9;
    var_18 = var_1;
  } else {
    var_17 = var_10;
    var_18 = var_2;
  }

  if(var_3 <= var_4) {
    var_19 = var_11;
    var_20 = var_3;
  } else {
    var_19 = var_12;
    var_20 = var_4;
  }

  if(var_18 <= var_20) {
    var_0.weapon_name = scripts\sp\loadout::_id_7C27(var_17);
    var_0._id_1E2D = weaponmaxammo(var_17);
  } else {
    var_0.weapon_name = scripts\sp\loadout::_id_7C27(var_19);
    var_0._id_1E2D = weaponmaxammo(var_19);
  }

  return var_0;
}

_id_4847() {
  self endon("remove_pickup_cache");
  var_0 = 1;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  wait 0.15;

  switch (self.weapon_name) {
    case "frag":
      var_1 = &"EQUIPMENT_PICKUP_FRAG";
      var_9 = _id_4843("primary", self.weapon_name, &"EQUIPMENT_FULL_FRAG");
      break;
    case "emp":
      var_1 = &"EQUIPMENT_PICKUP_EMP";
      var_9 = _id_4843("primary", self.weapon_name, &"EQUIPMENT_FULL_EMP");
      break;
    case "antigrav":
      var_1 = &"EQUIPMENT_PICKUP_ANTIGRAV";
      var_9 = _id_4843("primary", self.weapon_name, &"EQUIPMENT_FULL_ANTIGRAV");
      break;
    case "seeker":
      var_1 = &"EQUIPMENT_PICKUP_SEEKER";
      var_9 = _id_4843("primary", self.weapon_name, &"EQUIPMENT_FULL_SEEKER");
      break;
    case "nanoshot":
      var_1 = &"EQUIPMENT_PICKUP_NANOSHOT";
      var_9 = _id_4843("primary", self.weapon_name, &"EQUIPMENT_FULL_NANOSHOT");
      break;
    case "supportdrone":
      var_1 = &"EQUIPMENT_PICKUP_DRONE";
      var_9 = _id_4843("secondary", self.weapon_name, &"EQUIPMENT_FULL_DRONE");
      var_0 = 2;
      break;
    case "offhandshield":
      var_1 = &"EQUIPMENT_PICKUP_SHIELD";
      var_9 = _id_4843("secondary", self.weapon_name, &"EQUIPMENT_FULL_SHIELD");
      var_0 = 2;
      break;
    case "hackingdevice":
      var_1 = &"EQUIPMENT_PICKUP_HACK";
      var_9 = _id_4843("secondary", self.weapon_name, &"EQUIPMENT_FULL_HACK");
      var_0 = 2;
      break;
    case "coverwall":
      var_1 = &"EQUIPMENT_PICKUP_COVER";
      var_9 = _id_4843("secondary", self.weapon_name, &"EQUIPMENT_FULL_COVER");
      var_0 = 2;
      break;
    case "helmet":
      var_1 = &"EQUIPMENT_PICKUP_HELMET";
      var_9 = _id_4843("secondary", self.weapon_name, &"EQUIPMENT_FULL_HELMET");
      var_0 = 2;
      break;
  }

  return [var_9, var_1, var_0];
}

_id_4843(var_0, var_1, var_2) {
  var_3 = level.player _id_0A2F::_id_7BB5(var_1);
  var_4 = weaponmaxammo(var_3);
  var_5 = scripts\sp\loadout::_id_7C27(var_1, 1);
  var_6 = [];

  if(var_0 == "primary") {
    var_7 = scripts\sp\loadout::_id_7C27(scripts\sp\utility::_id_7BD6(), 1);

    if(isDefined(var_7) && var_7 == var_5) {
      if(scripts\sp\utility::_id_7BD7() == var_4) {
        return var_2;
      }
    }

    var_7 = scripts\sp\loadout::_id_7C27(scripts\sp\utility::_id_7CAF(), 1);

    if(isDefined(var_7) && var_7 == var_5) {
      if(scripts\sp\utility::_id_7CB0() == var_4) {
        return var_2;
      }
    }
  } else {
    var_7 = scripts\sp\loadout::_id_7C27(scripts\sp\utility::_id_7C3D(), 1);

    if(isDefined(var_7) && var_7 == var_5) {
      if(scripts\sp\utility::_id_7C3E() == var_4 || var_7 == "offhandshield") {
        return var_2;
      }
    }

    var_7 = scripts\sp\loadout::_id_7C27(scripts\sp\utility::_id_7CB1(), 1);

    if(isDefined(var_7) && var_7 == var_5) {
      if(scripts\sp\utility::_id_7CB2() == var_4 || var_7 == "offhandshield") {
        return var_2;
      }
    }
  }

  return undefined;
}

_id_4849(var_0) {
  self endon("death");

  for(;;) {
    while(distancesquared(self.origin, level.player.origin) > squared(var_0)) {
      wait 1;
    }

    _id_484A();

    while(distancesquared(self.origin, level.player.origin) < squared(var_0)) {
      wait 1;
    }

    for(var_1 = 0; var_1 < self._id_6698.size; var_1++) {
      if(isDefined(self._id_6698[var_1])) {
        self._id_6698[var_1] delete();
      }
    }
  }
}

_id_484A() {
  if(isDefined(self.dont_spawn_models)) {
    return;
  }
  var_0 = self._id_1E2D;
  var_1 = self.angles;
  var_2 = self.origin + (0, 0, 0);
  var_3 = (0, 0, 0);
  var_4 = undefined;
  var_5 = 2;
  var_6 = 2;
  var_7 = 0;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = 0;
  var_14 = (0, 0, 0);
  var_15 = vectorNormalize(anglesToForward(self.angles));
  var_16 = vectorNormalize(anglestoright(self.angles));
  var_17 = vectorNormalize(anglestoup(self.angles));

  if(isDefined(self._id_6698)) {
    for(var_18 = 0; var_18 < self._id_6698.size; var_18++) {
      if(isDefined(self._id_6698[var_18])) {
        self._id_6698[var_18] delete();
      }
    }
  } else
    self._id_6698 = [];

  if(self.weapon_name == "frag") {
    var_2 = self.origin + var_16 * 4;
    var_2 = var_2 + var_15 * 4;
    var_2 = var_2 + var_17 * 1.5;
    var_1 = (0, 0, 90);
    var_10 = 45;
    var_11 = 90;
    var_5 = 8;
    var_6 = 8;
    var_9 = "frag_grenade_wm";
  } else if(self.weapon_name == "emp") {
    var_2 = self.origin + var_16 * 4;
    var_2 = var_2 + var_15 * 4;
    var_2 = var_2 + var_17 * 1;
    var_1 = (0, 0, 90);
    var_10 = 45;
    var_5 = 8;
    var_6 = 8;
    var_9 = "emp_grenade_wm";
  } else if(self.weapon_name == "antigrav") {
    var_2 = self.origin + var_16 * 7;
    var_2 = var_2 + var_15 * 3.25;
    var_2 = var_2 + var_17;
    var_1 = (0, 0, -90);
    var_10 = 15;
    var_11 = 25;
    var_5 = 8;
    var_6 = 8;
    var_9 = "anti_grav_grenade_wm";
  } else if(self.weapon_name == "seeker") {
    var_2 = self.origin + var_16 * 4;
    var_2 = var_2 + var_15 * 4;
    var_2 = var_2 + var_17 * -1;
    var_10 = 5;
    var_5 = 8;
    var_6 = 8;
    var_1 = (0, 0, 0);
    var_9 = "seeker_grenade_folded";
  } else if(self.weapon_name == "supportdrone") {
    var_2 = self.origin + var_16 * 4.7;
    var_2 = var_2 + var_15 * 0.5;
    var_2 = var_2 + var_17 * 3;
    var_5 = 9;
    var_6 = 0;
    var_1 = (0, 0, 0);

    if(var_0 > 2) {
      var_0 = 2;
    }

    var_9 = "veh_mil_air_un_pocketdrone_folded_wm";
  } else if(self.weapon_name == "offhandshield") {
    var_0 = 1;
    var_2 = self.origin + var_16 * 2;
    var_2 = var_2 - var_15 * 2;
    var_2 = var_2 + var_17;
    var_1 = (0, 45, 0);
    var_9 = "weapon_retract_shield_folded_vm";
  } else if(self.weapon_name == "hackingdevice") {
    var_2 = self.origin + var_16 * 4;
    var_2 = var_2 + var_15 * 4;
    var_2 = var_2 + var_17;
    var_1 = (0, 270, 0);
    var_10 = 25;
    var_5 = 8;
    var_6 = 8;
    var_9 = "equipment_memory_chip_01";
  } else if(self.weapon_name == "coverwall") {
    var_2 = self.origin + var_16 * 4;
    var_2 = var_2 + var_15 * 4;
    var_2 = var_2 + var_17 * 1.65;
    var_1 = (0, 0, 90);
    var_10 = 45;
    var_11 = 90;
    var_5 = 8;
    var_6 = 8;
    var_9 = "foam_grenade_wm";
  } else if(self.weapon_name == "nanoshot") {
    var_2 = self.origin + var_16 * 4;
    var_2 = var_2 + var_15 * 4;
    var_2 = var_2 + var_17 * 0.5;
    var_1 = (0, 0, 90);
    var_10 = 45;
    var_5 = 8;
    var_6 = 8;
    var_9 = "equipment_mp_nanoshot";
  } else if(self.weapon_name == "helmet") {
    var_2 = self.origin + var_16 * -1;
    var_2 = var_2 + var_15 * 7.1;
    var_2 = var_2 + var_17 * -8.5;
    var_1 = (297, 227, -90);
    var_6 = 14;
    var_9 = "helmet_hero_protagonist";
  }

  if(var_6 > 0) {
    var_0 = var_0 / 2;

    if(var_0 != int(var_0)) {
      var_8 = var_0;
      var_0 = scripts\sp\utility::_id_E753(var_0, 0, 0);
    }
  }

  var_3 = var_2;
  var_19 = var_2;

  for(var_20 = 0; var_20 < var_0; var_20++) {
    self._id_6698[var_20] = spawn("script_model", var_2);
    self._id_6698[var_20].origin = var_2;

    if(isDefined(self._id_6694[var_20])) {
      var_21 = self._id_6694[var_20];
    } else {
      if(var_11 != 0) {
        var_13 = randomintrange(-1 * var_11, var_11);
      }

      if(var_10 != 0) {
        var_12 = randomintrange(-1 * var_10, var_10);
      }

      var_21 = (var_13, var_12, 0);
      self._id_6694[var_20] = var_21;
    }

    self._id_6698[var_20].angles = combineangles(self.angles, var_1 + var_21);
    self._id_6698[var_20] setModel(var_9);

    if(var_20 <= var_0 / 2 - 1) {
      var_2 = var_2 - var_5 * var_16;
    } else {
      if(isDefined(var_3)) {
        var_2 = var_3;
        var_3 = undefined;
      }

      var_2 = var_2 + var_5 * var_16;
    }

    if(self.weapon_name == "helmet") {
      var_1 = (297, 33, -90);
    }
  }

  var_3 = var_19;

  if(var_6 > 0) {
    if(!var_7) {
      var_2 = var_19 - var_6 * var_15;
    } else {
      var_2 = var_2 - var_6 * var_15;
    }

    if(isDefined(var_8) && var_8 != int(var_8)) {
      var_0 = scripts\sp\utility::_id_E753(var_8, 0, 1);
    }

    for(var_22 = var_20; var_22 < var_20 + var_0; var_22++) {
      self._id_6698[var_22] = spawn("script_model", var_2);
      self._id_6698[var_22].origin = var_2;

      if(isDefined(self._id_6694[var_22])) {
        var_21 = self._id_6694[var_22];
      } else {
        if(var_11 != 0) {
          var_13 = randomintrange(-1 * var_11, var_11);
        }

        if(var_10 != 0) {
          var_12 = randomintrange(-1 * var_10, var_10);
        }

        var_21 = (var_13, var_12, 0);
        self._id_6694[var_22] = var_21;
      }

      self._id_6698[var_22].angles = combineangles(self.angles, var_1 + var_21);
      self._id_6698[var_22] setModel(var_9);

      if(var_22 <= var_20 + var_0 / 2 - 1) {
        var_2 = var_2 - var_5 * var_16;
        continue;
      }

      if(isDefined(var_3)) {
        var_2 = var_3 - var_6 * var_15;
        var_3 = undefined;
      }

      var_2 = var_2 + var_5 * var_16;
    }

    var_23 = var_22;
  } else
    var_23 = var_20;

  if(isDefined(var_4)) {
    self._id_6698[var_23] = spawn("script_model", self.origin);
    self._id_6698[var_23].origin = self.origin;
    self._id_6698[var_23].angles = var_1 + self.angles;
    self._id_6698[var_23] setModel(var_4);
  }
}

_id_4845() {
  level.player endon("death");
  self endon("remove_pickup_cache");
  self endon("out_of_ammo");
  var_0 = _id_4844();
  _id_0E46::_id_48C4(undefined, (0, 0, 4), var_0, 40, 300, undefined, undefined, undefined, undefined, &"hud_interaction_prompt_center_equipment");

  for(;;) {
    while(distancesquared(self.origin, level.player.origin) < squared(500) && level.player._id_13102 == 0 && self._id_3860) {
      _id_484A();
      var_0 = _id_4844();
      thread _id_0E46::_id_DFE3();
      self waittill("hint_destroyed");

      if(self._id_3860) {
        _id_0E46::_id_48C4(undefined, (0, 0, 4), var_0, 40, 300, undefined, undefined, undefined, 0, &"hud_interaction_prompt_center_equipment");
        level.player scripts\engine\utility::waittill_any("picked_up_equipment", "equipment_change", "hackingdevice_end", "offhand_ammo", "item_ammo");
      }
    }

    wait 0.1;
  }
}

_id_4844() {
  var_0 = _id_4847();
  var_1 = scripts\sp\loadout::_id_7C27(scripts\sp\utility::_id_7BD6());
  var_2 = scripts\sp\loadout::_id_7C27(scripts\sp\utility::_id_7CAF());
  var_3 = scripts\sp\loadout::_id_7C27(scripts\sp\utility::_id_7C3D());
  var_4 = scripts\sp\loadout::_id_7C27(scripts\sp\utility::_id_7CB1());

  if(!isDefined(var_1)) {
    var_1 = "none";
  }

  if(!isDefined(var_2)) {
    var_2 = "none";
  }

  if(!isDefined(var_3)) {
    var_3 = "none";
  }

  if(!isDefined(var_4)) {
    var_4 = "none";
  }

  if(var_0[2] == 1) {
    if(var_1 != "none" && (var_2 != "none" || !scripts\sp\utility::_id_D0C9())) {
      if(var_1 == self.weapon_name || var_2 == self.weapon_name) {
        self._id_AE46 = "primaryxprimary";
      } else {
        self._id_AE46 = "newequipment_primary";
      }
    } else if(var_1 == self.weapon_name || var_2 == self.weapon_name)
      self._id_AE46 = "primaryxprimary";
    else {
      self._id_AE46 = "newequipment_empty";
    }
  } else {
    if((var_3 == "offhandshield" || var_4 == "offhandshield") && self.weapon_name == "offhandshield") {
      self._id_AE46 = "shieldxshield";
    }

    if(var_0[2] == 2) {
      if(var_3 != "none" && (var_4 != "none" || !scripts\sp\utility::_id_D0C9())) {
        if(var_3 == self.weapon_name || var_4 == self.weapon_name) {
          self._id_AE46 = "secondaryxsecondary";
        } else {
          self._id_AE46 = "newequipment_secondary";
        }
      } else if(var_3 == self.weapon_name || var_4 == self.weapon_name)
        self._id_AE46 = "secondaryxsecondary";
      else {
        self._id_AE46 = "newequipment_empty";
      }
    } else {}
  }

  if(!isDefined(var_0[0])) {
    self._id_74B3 = 0;
    return var_0[1];
  } else {
    self._id_74B3 = 1;
    return var_0[0];
  }
}

_id_1E33(var_0) {
  if(var_0.alpha != 0) {
    return;
  }
  var_0 fadeovertime(0.2);
  var_0.alpha = 0.3;
  wait 0.2;
}

_id_1E34(var_0) {
  if(var_0.alpha == 0) {
    return;
  }
  var_0 fadeovertime(0.2);
  var_0.alpha = 0;
  wait 0.2;
}