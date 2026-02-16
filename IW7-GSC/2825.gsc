/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2825.gsc
**************************************/

func_952F() {
  func_2237();
  func_CF6C();
  func_EE1F();
  func_87EC();
  level.var_A03B = getDvar("player_itemUseRadius");
  level.var_A03A = getDvar("player_itemUseFOV");
  var_0 = getEntArray("loot_room_volume", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread func_CF73();
  }
}

func_2237() {}

func_489F(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_1 = scripts\engine\utility::getStructArray("loot_weapon_node", "targetname");
  var_2 = scripts\engine\utility::getStructArray("loot_terminal", "targetname");
  var_3 = scripts\engine\utility::getStructArray("locker_node", "targetname");
  var_4 = level.var_D9E5["equip_upgrades"];
  var_4 = var_4 / level.var_21E2;

  if(isDefined(level.var_FCD6) && level.var_FCD6 == 1) {
    var_5 = undefined;
    var_6 = getEntArray("loot_room_volume", "targetname");

    if(var_6.size > 1) {
      foreach(var_5 in var_6) {
        if(ispointinvolume(self.origin, var_5)) {
          break;
        }
      }

      if(isDefined(var_5)) {
        var_9 = var_1;
        var_10 = var_2;
        var_11 = var_3;
        var_1 = [];
        var_2 = [];
        var_3 = [];

        foreach(var_13 in var_9) {
          if(ispointinvolume(var_13.origin, var_5)) {
            var_1 = scripts\engine\utility::array_add(var_1, var_13);
          }
        }

        foreach(var_16 in var_10) {
          if(ispointinvolume(var_16.origin, var_5)) {
            var_2 = scripts\engine\utility::array_add(var_2, var_16);
          }
        }

        foreach(var_19 in var_11) {
          if(ispointinvolume(var_19.origin, var_5)) {
            var_3 = scripts\engine\utility::array_add(var_3, var_19);
          }
        }
      }
    }
  }

  func_B080(var_3, 0);
  thread func_B098(var_1);
  thread func_B095(var_0, var_2, var_4);
}

func_CF73() {
  for(;;) {
    for(;;) {
      if(level.player istouching(self)) {
        break;
      }
      wait 0.25;
    }

    _setsaveddvar("player_itemUseRadius", 100);
    _setsaveddvar("player_itemUseFOV", 90);

    for(;;) {
      if(!level.player istouching(self)) {
        break;
      }
      wait 0.25;
    }

    _setsaveddvar("player_itemUseRadius", level.var_A03B);
    _setsaveddvar("player_itemUseFOV", level.var_A03A);
  }
}

#using_animtree("player");

func_CF6C() {
  if(level.script == "sa_assassination") {
    if(isDefined(level.var_21E7)) {
      level[[level.var_21E7]]();
    }
  } else {
    level.var_EC87["player_arms"] = #animtree;
    level.var_EC8C["player_arms"] = "viewmodel_base_viewhands_iw7";
    level.var_EC85["player_arms"]["hack_terminal"] = % vm_gauntlet_armory_hack;
    level.var_EC85["player_arms"]["open_loot_door"] = % door_armory_open_player;
  }
}

#using_animtree("script_model");

func_EE1F() {
  level.var_EC87["loot_door"] = #animtree;
  level.var_EC87["loot_locker"] = #animtree;
  level.var_EC85["loot_door"]["open_loot_door"] = % door_armory_open_door;
  level.var_EC85["loot_locker"]["open_locker_doors"] = % loot_room_locker_door_open;
}

func_B098(var_0) {
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = spawnStruct();
  var_1.var_BF1B = 8;
  var_1.var_11A2E = var_0.size;
  var_1.var_10310 = var_0.size;
  var_1.nodes = var_0;

  for(var_2 = 0; var_2 < var_1.var_11A2E; var_2++) {
    var_1 = func_B097(var_1);
    var_1.var_10310--;
  }
}

func_B095(var_0, var_1, var_2) {
  var_3 = var_1.size;
  var_4 = var_2;

  foreach(var_8, var_6 in var_1) {
    var_7 = 1;

    if(var_4 > var_3) {
      var_7 = 2;
    }

    if(isDefined(level.var_B092)) {
      level.var_B093 = var_6;
      var_6.var_92B9 = 2;
    } else {
      level.var_B092 = var_6;
      var_6.var_92B9 = 1;
    }

    var_6 thread func_116DD(var_7, var_0, var_8);
    var_4 = var_4 - var_7;
  }
}

func_B080(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = "vault_locker_light_" + var_3 + "_on";
    var_5 = var_0[var_3] func_AF09(var_4, var_1);
  }

  return var_2;
}

func_AF09(var_0, var_1) {
  var_2 = getEntArray(self.target, "targetname");
  var_3 = [];
  var_4 = [];
  var_5 = undefined;
  var_6 = undefined;

  foreach(var_8 in var_2) {
    if(var_8.classname == "script_model") {
      var_5 = var_8;
      continue;
    }

    if(var_8.classname == "script_brushmodel") {
      var_4 = scripts\engine\utility::array_add(var_4, var_8);
      continue;
    }

    if(isDefined(var_8.script_noteworthy) && var_8.script_noteworthy == "loot_locker_volume") {
      var_6 = var_8;
      continue;
    }

    var_3 = scripts\engine\utility::array_add(var_3, var_8);
  }

  thread func_AF0F(var_0, var_3);
  thread func_AF04(var_0, var_5, var_4);
}

func_AF04(var_0, var_1, var_2) {
  thread func_0E46::func_48C4(undefined, undefined, undefined, undefined, undefined, undefined, 0);
  func_0E46::func_9016();
  level.player notify("opening_armory_locker");
  level notify(var_0);
  var_1 thread func_AF05(var_2);
  _playworldsound("loot_locker_open", self.origin);
}

func_AF05(var_0) {
  var_1 = self;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_0) {
    if(var_6.script_noteworthy == "left_door") {
      var_2 = var_6;
      continue;
    }

    if(var_6.script_noteworthy == "right_door") {
      var_3 = var_6;
      continue;
    }

    var_4 = var_6;
  }

  var_1 glinton(#animtree);
  var_2 linkto(var_1, "j_door_r");
  var_3 linkto(var_1, "j_door_l");
  var_1.var_1FBB = "loot_locker";
  var_1 scripts\sp\anim::func_1F35(var_1, "open_locker_doors");

  if(isDefined(var_4)) {
    var_4 delete();
  }
}

func_AF0F(var_0, var_1) {
  if(!isDefined(self.target)) {
    return;
  }
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_2 < 2 && randomint(100) > 25) {
      var_4 scripts\sp\lights::init_light_flicker(undefined, undefined, 0.1, 0.25, undefined, undefined, undefined, undefined, undefined, var_0, undefined);
      var_2++;
      continue;
    }

    var_4 scripts\sp\lights::init_light_generic_iw7(undefined, undefined, undefined, undefined, var_0);
  }
}

func_B097(var_0) {
  var_0 = func_13C4B(var_0);
  var_1 = level.var_D9E5["weapon_pickups"];
  var_2 = level.var_D9E5["optionalunlocks"];

  if(var_0.var_1067C == 1) {
    var_0 = func_3E94(var_0);

    if(var_0.var_F1B8 != "none" && func_0A2F::func_9B49(var_0.var_F1B8)) {
      var_3 = func_0A2F::build_attach_models(var_0.var_F1B8, "random", undefined, 0, 0, 3);

      if(isDefined(var_3)) {
        var_0.var_F1B8 = var_0.var_F1B8 + "+" + var_3;
      }

      var_4 = spawn("weapon_" + var_0.var_F1B8, var_0.var_F1B5.origin, 1);
      var_4.angles = var_0.var_F1B5.angles;
      var_4 thread func_13C65();

      if(getdvarint("progression_on") == 1) {
        var_5 = getweaponbasename(var_0.var_F1B8);

        if(scripts\engine\utility::array_contains(var_2, var_5)) {
          var_4 scripts\sp\utility::func_9196(4, 1, 0, "new_weapon");
          level.var_D9E5["armoryweapons"][level.var_D9E5["armoryweapons"].size] = var_4;
        }
      }
    }
  }

  return var_0;
}

func_13C65() {
  self endon("death");
  var_0 = getsubstr(self.classname, 7);
  self waittill("trigger");
  level.player givemaxammo(var_0);
}

func_116DF() {
  var_0 = randomintrange(0, 2);
  return var_0;
}

func_13C4B(var_0) {
  var_0.var_1067C = 1;
  return var_0;
}

func_3E94(var_0, var_1) {
  if(!isDefined(scripts\engine\utility::get_template_script_MAYBE())) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_0.var_3850 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = ["none"];

  if(!var_1) {
    var_4 = func_0A2F::func_D9FA();
  }

  var_4 = scripts\engine\utility::array_combine(var_4, func_0A2F::func_DA0A());
  var_4 = scripts\engine\utility::array_combine(var_4, func_0A2F::func_DA10());

  if(var_0.var_BF1B > 0 && scripts\engine\utility::get_template_script_MAYBE() != "rogue" && scripts\engine\utility::get_template_script_MAYBE() != "moon_port") {
    var_5 = randomfloatrange(0, 1);

    if(var_0.var_BF1B / 8 >= var_5) {
      if(level.var_D9E5["optionalunlocks"].size > 0) {
        level.var_D9E5["optionalunlocks"] = ::scripts\engine\utility::array_randomize(level.var_D9E5["optionalunlocks"]);

        foreach(var_7 in level.var_D9E5["optionalunlocks"]) {
          if(scripts\engine\utility::array_contains(level.var_D9E5["loaded_weapons"], var_7)) {
            var_2 = var_7;
            break;
          }
        }

        if(isDefined(var_2)) {
          var_3 = func_13C06(var_2, var_0.nodes);
        }

        if(isDefined(var_3)) {
          var_0.var_F1B8 = var_2;
          var_0.var_F1B5 = var_3;
          var_0.nodes = scripts\engine\utility::array_remove(var_0.nodes, var_3);
          var_0.nodes = scripts\engine\utility::array_randomize(var_0.nodes);
          var_0.var_BF1B--;
          return var_0;
        }
      }
    }
  }

  if(!isDefined(var_0.var_3850)) {
    var_0.var_3850 = [];

    foreach(var_10 in level.var_D9E5["loaded_weapons"]) {
      if(!scripts\engine\utility::array_contains(var_4, var_10) && !scripts\engine\utility::array_contains(level.var_D9E5["optionalunlocks"], var_10)) {
        var_0.var_3850 = scripts\engine\utility::array_add(var_0.var_3850, var_10);
      }
    }
  }

  var_0.var_3850 = scripts\engine\utility::array_randomize(var_0.var_3850);
  var_2 = undefined;
  var_3 = undefined;

  if(!isDefined(var_0.func_845F)) {
    var_0.func_845F = 0;
  }

  for(var_12 = 0; var_12 < var_0.var_3850.size; var_12++) {
    if(scripts\engine\utility::get_template_script_MAYBE() == "rogue") {
      if(var_0.var_10310 < var_0.var_11A2E) {
        var_0.func_845F = 1;
      }

      if(var_0.func_845F && randomint(100) > 25) {
        var_3 = undefined;
        var_2 = undefined;
        break;
      }

      var_2 = var_0.var_3850[var_12];

      if(weaponclass(var_2) == "spread") {
        var_3 = func_13C06(var_2, var_0.nodes);
        break;
      }
    } else if(scripts\engine\utility::get_template_script_MAYBE() == "moon_port") {
      var_2 = var_0.var_3850[var_12];

      if(!isDefined(var_0.func_8460)) {
        var_0.func_8460 = 0;
      }

      if(!isDefined(var_0.setplayermusicstate)) {
        var_0.setplayermusicstate = 0;
      }

      if(var_2 == "iw7_devastator" && var_0.setplayermusicstate < 12) {
        var_3 = func_13C06(var_2, var_0.nodes);
        var_0.setplayermusicstate++;
        break;
      } else if(var_2 == "iw7_mauler" && var_0.func_8460 < 12) {
        var_3 = func_13C06(var_2, var_0.nodes);
        var_0.func_8460++;
        break;
      }
    } else {
      var_2 = var_0.var_3850[var_12];
      var_3 = func_13C06(var_2, var_0.nodes);
      break;
    }
  }

  if(isDefined(var_3)) {
    var_0.var_F1B8 = var_2;
    var_0.var_F1B5 = var_3;
    var_0.nodes = scripts\engine\utility::array_remove(var_0.nodes, var_3);
    var_0.nodes = scripts\engine\utility::array_randomize(var_0.nodes);
  } else {
    var_0.var_F1B8 = "none";
  }

  return var_0;
}

func_13C06(var_0, var_1) {
  var_2 = scripts\engine\utility::weaponclass(var_0);
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = 0;

  if(isDefined(level.var_72A6)) {
    if(level.var_72A6 == "silencer") {
      var_7 = 1;
    }
  }

  if(var_0 == "iw7_sdflmg") {
    var_6 = 0.2;
  } else if(var_0 == "iw7_ar57") {
    if(var_7) {
      var_2 = "silenced_smg";
    }

    var_6 = 0;
  } else if(var_0 == "iw7_crb") {
    if(var_7) {
      var_2 = "silenced_smg";
    }

    var_6 = 2.8;
  } else if(var_0 == "iw7_devastator") {
    var_6 = 0.5;
  } else if(var_0 == "iw7_m8") {
    var_6 = 0.2;
  } else if(var_0 == "iw7_kbs") {
    var_6 = 4.8;
  } else if(var_0 == "iw7_fmg") {
    if(var_7) {
      var_2 = "silenced_smg";
    }

    var_6 = -1;
  } else if(var_0 == "iw7_ripper") {
    var_6 = -1;
  } else if(var_0 == "iw7_ump45") {
    if(var_7) {
      var_2 = "silenced_smg";
    }

    var_6 = -4;
  } else if(var_0 == "iw7_erad") {
    if(var_7) {
      var_2 = "silenced_smg";
    }

    var_6 = 0;
  } else if(var_0 == "iw7_fhr") {
    if(var_7) {
      var_2 = "silenced_smg";
    }

    var_6 = 1;
  } else if(var_0 == "iw7_ake") {
    var_2 = "sniper";
    var_6 = 0.8;
  } else if(var_0 == "iw7_m4") {
    var_2 = "sniper";
    var_6 = 0.2;
  } else if(var_0 == "iw7_sdfar") {
    var_2 = "large_ar";
    var_6 = -0.6;
  } else if(var_0 == "iw7_sonic") {
    var_2 = "large_shotgun";
    var_6 = -3.2;
  } else if(var_0 == "iw7_sdfshotty") {
    var_2 = "large_shotgun";
    var_6 = -1.2;
  } else if(var_0 == "iw7_mauler") {
    var_2 = "extra_large";
  }

  switch (var_2) {
    case "extra_large":
      var_5 = "extra_large";
      break;
    case "sniper":
      var_5 = "large";
      break;
    case "large_shotgun":
      var_5 = "large";
      break;
    case "large_ar":
      var_5 = "large";
      break;
    case "mg":
      var_5 = "large";
      break;
    case "pistol":
      var_5 = "pistol";
      break;
    case "beam":
      var_5 = "large";
      break;
    case "silenced_shotgun":
      var_5 = "large";
      break;
    case "silenced_smg":
      var_5 = "large";
      break;
  }

  if(func_0A2F::func_DA40(var_0)) {
    var_5 = "heavy";
  }

  var_8 = undefined;
  var_9 = undefined;

  if(isDefined(var_5) && var_5 == "extra_large") {
    foreach(var_11 in var_1) {
      var_12 = var_11 scripts\sp\utility::func_7A97();

      if(var_12.size > 0) {
        foreach(var_14 in var_12) {
          if(isDefined(var_14.script_noteworthy)) {
            var_15 = var_14 scripts\sp\utility::func_7A97();

            foreach(var_9 in var_15) {
              if(scripts\engine\utility::array_contains(var_1, var_14)) {
                if(scripts\engine\utility::array_contains(var_1, var_9)) {
                  if(isDefined(var_9.script_parameters) && var_9.script_parameters == "extra_large") {
                    var_3 = var_9;
                    break;
                  }
                }
              }
            }
          }
        }
      }

      if(isDefined(var_3)) {
        break;
      }
    }
  } else if(isDefined(var_5) && var_5 == "large") {
    foreach(var_11 in var_1) {
      var_21 = 0;
      var_22 = 0;

      if(isDefined(var_11.script_parameters) && var_11.script_parameters == "large") {
        var_12 = var_11 scripts\sp\utility::func_7A97();

        if(var_12.size > 0) {
          foreach(var_14 in var_12) {
            if(!scripts\engine\utility::array_contains(var_1, var_14)) {
              if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == "stacked") {
                if(isDefined(var_14.script_parameters) && var_14.script_parameters == "extra_large") {
                  var_21 = 1;
                }
              }
            }

            if(!scripts\engine\utility::array_contains(var_1, var_14) && var_0 == "iw7_sdflmg") {
              if(!isDefined(var_11.script_noteworthy)) {
                if(isDefined(var_14.script_parameters) && var_14.script_parameters == "extra_large") {
                  var_22 = 1;
                }
              }
            }
          }
        } else {
          if(var_0 == "iw7_smg") {
            var_22 = 1;
          }

          if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == "stacked") {
            var_21 = 1;
          }
        }

        if(!var_21 && !var_22) {
          var_3 = var_11;
          break;
        }
      }
    }
  } else if(isDefined(var_5) && var_5 == "heavy") {
    foreach(var_11 in var_1) {
      if(isDefined(var_11.script_parameters) && var_11.script_parameters == "heavy") {
        var_3 = var_11;
        break;
      }
    }
  } else if(isDefined(var_5) && var_5 == "pistol") {
    foreach(var_11 in var_1) {
      if(isDefined(var_11.script_parameters) && var_11.script_parameters == "pistol") {
        if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == "locker_weapon") {
          var_3 = var_11;
          break;
        } else {
          var_4 = var_11;
        }
      }
    }

    if(!isDefined(var_3)) {
      var_3 = var_4;
    }
  } else {
    foreach(var_11 in var_1) {
      if(!isDefined(var_11.script_parameters)) {
        if(isDefined(var_11.script_noteworthy) && var_11.script_noteworthy == "locker_weapon") {
          var_3 = var_11;
          break;
        } else {
          var_4 = var_11;
        }
      }
    }

    if(!isDefined(var_3)) {
      var_3 = var_4;
    }
  }

  if(isDefined(var_6) && isDefined(var_3)) {
    var_3.origin = var_3.origin + (0, 0, var_6);
  }

  return var_3;
}

func_53BE() {
  var_0 = scripts\engine\utility::random(["", "small", "medium", "large"]);
  return var_0;
}

func_116DD(var_0, var_1, var_2) {
  func_8835();
  setomnvar("ui_inworld_terminal_hack", 0);

  if(isDefined(self.var_92B9) && self.var_92B9 == 1) {
    func_F3F0("on");
  } else {
    func_F3F0("on", 1);
  }

  if(func_0A2F::func_DA44(var_1, var_2)) {
    if(isDefined(self.var_92B9) && self.var_92B9 == 1) {
      func_F3F0("hacked");
    } else {
      func_F3F0("hacked", 1);
    }

    return;
  }

  var_3 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_3 thread func_0E46::func_48C4("tag_origin", undefined, undefined, undefined, undefined, 35, 0);
  var_3 func_0E46::func_9016();
  var_4 = undefined;
  var_5 = getent(self.target, "targetname");
  var_4 = var_5 scripts\engine\utility::spawn_tag_origin();
  level.player playSound("armory_terminal_start_use");
  var_6 = var_4 func_0B1F::func_FA17("hack_terminal");
  thread func_8834(var_6);
  var_6 thread func_116DC("hack_terminal", var_0, var_1);
  var_4 scripts\sp\anim::func_1F35(var_6, "hack_terminal");
  func_0A2F::func_DA4D(var_1, var_2);
  var_6 delete();
  level.player func_0B1F::func_5990();
  level.player unlink();
  var_3 delete();
  var_4 delete();
}

func_9C55(var_0) {
  var_1 = func_0A2F::func_D9F8("items");
  return scripts\engine\utility::array_contains(var_1, var_0);
}

func_116DC(var_0, var_1, var_2) {
  level.player notify("armory_terminal_start");
  var_3 = getanimlength(scripts\sp\utility::func_7DC1(var_0));
  var_4 = [];
  var_5 = ["frag", "antigrav", "emp", "seeker", "frag", "seeker", "offhandshield", "antigrav", "emp", "hackingdevice", "supportdrone", "coverwall"];
  level.player playSound("armory_terminal_tick");
  wait(var_3 / 2);
  level.player playSound("armory_terminal_tick");
  wait(var_3 / 2);
  level.player playSound("armory_terminal_got_file");

  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_7 = 0;
    var_8 = func_0A2F::func_D9F8();

    foreach(var_10 in var_8) {
      var_11 = level.player func_84C6("equipmentState", var_10);

      if(!isDefined(var_11)) {
        continue;
      }
      if(var_11 == "upgrade2") {
        var_7 = var_7 + 2;
        continue;
      }

      if(var_11 == "upgrade1") {
        var_7 = var_7 + 1;
      }
    }

    var_13 = var_5[var_7];
    var_14 = level.player func_84C6("equipmentState", var_13);
    var_15 = "upgrade1";

    if(isDefined(var_14) && var_14 == "upgrade1") {
      var_15 = "upgrade2";
    }

    if(var_13 == "coverwall" && var_15 == "upgrade1") {
      if(level.player.var_4759.active.size > 0) {
        level.player thread scripts\sp\coverwall::func_B9C4();
      }
    }

    level.player func_84C7("equipmentState", var_13, var_15);
    level.var_D9E5["weaponstates"][var_13] = var_15;
    func_0A2F::setlightintensity(var_13, var_15);
    var_4 = scripts\engine\utility::array_add(var_4, var_13);
  }

  level thread terminal_unlocks_ui(var_4, var_1);
  level.player playSound("armory_terminal_finish");
  level.player notify("armory_terminal_finish");
  func_0A2F::func_3D6E();
  var_16 = "armory" + var_2;
  scripts\sp\utility::func_266A(var_16);
}

terminal_unlocks_ui(var_0, var_1) {
  scripts\engine\utility::waitframe();

  if(scripts\engine\utility::flag("game_saving")) {
    wait 0.25;
  }

  thread clearomnvaronautosave("ui_loot_unlocked");
  var_2 = var_0.size;

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = var_0[var_3];
    setomnvar("ui_loot_unlocked", var_4);
    wait 3.0;

    if(var_3 < var_2 - 1) {
      while(scripts\engine\utility::flag("game_saving")) {
        scripts\engine\utility::waitframe();
      }
    }
  }

  setomnvar("ui_files_acquired", var_1);
  setomnvar("ui_loot_unlocked", "none");
  level notify("ClearOmnvarOnAutoSave_Abort");
}

clearomnvaronautosave(var_0) {
  level endon("ClearOmnvarOnAutoSave_Abort");

  for(;;) {
    level waittill("trying_new_autosave");
    setomnvar(var_0, "none");
  }
}

func_FA17(var_0) {
  var_1 = scripts\sp\utility::func_10639("player_arms");
  var_2 = level.player func_84C6("currentViewModel");

  if(isDefined(var_2)) {
    var_1 setModel(var_2);
  }

  var_1 hide();
  var_3 = [var_1, self];
  thread scripts\sp\anim::func_1EC3(var_1, var_0);
  var_4 = scripts\engine\utility::spawn_tag_origin(level.player.origin, level.player getplayerangles());
  level.player getweaponvarianttablename(var_4, "tag_origin");
  wait 0.05;
  var_5 = 1;
  level.player getweaponweight(var_1, "tag_player", var_5, 0.25, 0.25);
  level.player func_0B1F::func_598D();
  wait(var_5);
  level.player getweightedchanceroll(var_1, "tag_player", 0, 5, 5, 5, 5);
  var_1 show();
  var_4 delete();
  return var_1;
}

func_2246() {}

func_8835() {
  if(!isDefined(self.angles)) {
    self.angles = (0, 0, 0);
  }

  self.var_87EB = [];
  var_0 = undefined;

  if(isDefined(self.target)) {
    var_0 = getent(self.target, "targetname");
  }

  if(isDefined(var_0)) {
    self.var_87EB["fx_tag"] = var_0 scripts\engine\utility::spawn_tag_origin();
    self.var_87EB["fx_tag"].origin = self.var_87EB["fx_tag"].origin + anglesToForward(var_0.angles) * 47.9;
    self.var_87EB["fx_tag"].origin = self.var_87EB["fx_tag"].origin + anglestoup(var_0.angles) * 52;
  } else {
    self.var_87EB["fx_tag"] = ::scripts\engine\utility::spawn_tag_origin();
  }

  if(!isDefined(var_0)) {
    self.var_87EB["fx_tag"].origin = self.origin + anglesToForward(self.angles) * -2.0;
    self.var_87EB["fx_tag"].angles = self.angles + (73, 0, 0);
  }
}

func_87EC() {
  level._effect["vfx_ui_terminal_press"] = loadfx("vfx\iw7\core\ui\vfx_ui_terminal_press.vfx");
  level._effect["vfx_ui_terminal_off"] = loadfx("vfx\iw7\core\ui\vfx_ui_terminal_off.vfx");
  level._effect["vfx_ui_terminal_on"] = loadfx("vfx\iw7\core\ui\vfx_ui_terminal_on.vfx");
  level._effect["vfx_ui_terminal_firmware"] = loadfx("vfx\iw7\core\ui\vfx_ui_terminal_firmware.vfx");
  level._effect["vfx_ui_terminal_hack"] = loadfx("vfx\iw7\core\ui\vfx_ui_terminal_hack.vfx");
  level._effect["vfx_ui_terminal_success"] = loadfx("vfx\iw7\core\ui\vfx_ui_terminal_success.vfx");
  level._effect["vfx_ui_terminal_suit"] = loadfx("vfx\iw7\core\ui\vfx_ui_terminal_suit.vfx");
}

func_8834(var_0) {
  if(isDefined(self.var_92B9) && self.var_92B9 == 1) {
    func_F3F0("hack");
  } else {
    func_F3F0("hack", 1);
  }

  setomnvar("ui_inworld_terminal_wrist_ent", var_0);
  setomnvar("ui_wrist_pc", 7);
  wait 6.0;
  setomnvar("ui_wrist_pc", 0);
}

func_F3F0(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "on";
  }

  var_2 = self.var_87EB["fx_tag"];

  if(isDefined(var_1) && var_1) {
    setomnvar("ui_inworld_terminal_ent_2", var_2);
    setomnvar("ui_inworld_terminal_hack2", 1);
    setomnvar("ui_inworld_terminal_hack2", 0);
  } else {
    setomnvar("ui_inworld_terminal_ent", var_2);
    setomnvar("ui_inworld_terminal_hack", 1);
    setomnvar("ui_inworld_terminal_hack", 0);
  }

  wait 0.3;

  switch (var_0) {
    case "on":
      setomnvar("ui_inworld_terminal_on", 1);

      if(isDefined(var_1) && var_1) {
        setomnvar("ui_inworld_terminal_hack2", 0);
      } else {
        setomnvar("ui_inworld_terminal_hack", 0);
      }

      break;
    case "hacked":
      if(!getomnvar("ui_inworld_terminal_on")) {
        setomnvar("ui_inworld_terminal_on", 1);
      }

      if(isDefined(var_1) && var_1) {
        setomnvar("ui_inworld_terminal_hack2", 2);
      } else {
        setomnvar("ui_inworld_terminal_hack", 2);
      }

      break;
    case "hack":
      if(isDefined(var_1) && var_1) {
        setomnvar("ui_inworld_terminal_hack2", 1);
      } else {
        setomnvar("ui_inworld_terminal_hack", 1);
      }

      break;
    case "off":
      setomnvar("ui_inworld_terminal_on", 0);

      if(isDefined(var_1) && var_1) {
        setomnvar("ui_inworld_terminal_hack2", 0);
      } else {
        setomnvar("ui_inworld_terminal_hack", 0);
      }

      break;
  }
}