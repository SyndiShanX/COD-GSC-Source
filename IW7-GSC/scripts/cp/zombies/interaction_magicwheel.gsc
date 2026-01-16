/*********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_magicwheel.gsc
*********************************************************/

set_magic_wheel_starting_location(var_0) {
  level.var_B161 = var_0;
  level.var_A8E2 = var_0;
}

func_94EF() {
  wait(2);
  level.currentweaponlist = [];
  level.activewheels = 0;
  level.current_active_wheel = undefined;
  level.var_13D01 = 0;
  level.var_B162 = 0;
  level.var_B160 = [];
  level.fire_sale_func = ::func_10C4D;
  level.var_B163 = getEntArray("magic_wheel", "script_noteworthy");
  foreach(var_1 in level.var_B163) {
    var_1.origin = var_1.origin + (0, 0, 0.15);
    var_1.area_name = get_area(var_1);
    if(isDefined(var_1.area_name)) {
      level.var_B160[level.var_B160.size] = var_1.area_name;
    }

    var_1.var_E74A = func_7C20();
    var_1.var_13C25 = func_7ABF();
    var_2 = scripts\engine\utility::getclosest(var_1.origin, scripts\engine\utility::getstructarray("spinner", "script_noteworthy"));
    var_3 = spawn("script_model", var_2.origin + (0, 0, 0.15));
    if(!isDefined(var_2.angles)) {
      var_2.angles = (0, 0, 0);
    }

    var_3.angles = var_2.angles;
    var_3 setModel("zmb_magic_wheel_spinner");
    var_1.var_10A03 = var_3;
    var_1 setnonstick(1);
    level thread init_magic_wheel(var_1);
    var_1 thread func_13643();
    scripts\engine\utility::waitframe();
  }
}

magic_wheel_tutorial() {
  self endon("death");
  self endon("disconnect");
  self endon("saw_wheel_tutorial");
  wait(5);
  var_0 = cos(65);
  for(;;) {
    var_1 = level.var_B163;
    var_2 = sortbydistance(var_1, self.origin);
    if(!self.hide_tutorial && var_2.size > 0) {
      if(distancesquared(var_2[0].origin, self.origin) < 9216 && scripts\engine\utility::within_fov(self.origin, self.angles, var_2[0].origin, var_0)) {
        thread scripts\cp\cp_hud_message::tutorial_lookup_func("magic_wheel");
        wait(1);
        self notify("saw_wheel_tutorial");
      }
    }

    wait(0.25);
  }
}

func_7ABF() {
  return scripts\engine\utility::array_randomize_objects(level.magic_weapons);
}

func_13643() {
  self endon("delete_wheel");
  for(;;) {
    self waittill("trigger", var_0);
    if(!var_0 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var_1 = scripts\engine\utility::istrue(self.has_fnf_weapon);
    if(var_1) {
      level thread func_51EB(self, var_0, 1);
      continue;
    }

    if(isDefined(level.wheel_purchase_check)) {
      var_1 = [
        [level.wheel_purchase_check]
      ](self, var_0);
      if(var_1) {
        level thread[[level.wheel_hint_func]](self, var_0, 1);
        continue;
      }
    }

    if(scripts\engine\utility::flag_exist("fire_sale") && scripts\engine\utility::flag("fire_sale")) {
      var_2 = 10;
    } else {
      var_2 = 950;
    }

    if(isDefined(level.meph_fight_started)) {
      var_2 = 0;
    }

    if(var_0 scripts\cp\cp_persistence::player_has_enough_currency(var_2)) {
      var_0 scripts\cp\cp_persistence::take_player_currency(var_2, 1, "magic_wheel");
      func_12FFA(var_0, self, var_2);
      var_0 notify("magic_wheel_used");
      continue;
    }

    level thread func_51EB(self, var_0);
  }
}

func_51EB(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_1 playlocalsound("purchase_deny");
  if(isDefined(var_2)) {
    var_1 forceusehinton(&"COOP_INTERACTIONS_CANNOT_BUY");
  } else {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
    var_1 forceusehinton(&"COOP_INTERACTIONS_NEED_MONEY");
  }

  wait(1);
  var_1 getrigindexfromarchetyperef();
}

func_BC3F() {
  for(;;) {
    var_0 = scripts\engine\utility::random(level.var_B160);
    if(var_0 != level.var_A8E2) {
      func_BC3E(var_0);
      return;
    }
  }
}

func_BC3E(var_0) {
  level.var_A8E2 = var_0;
  if(isDefined(level.show_wheel_location_func)) {
    level thread[[level.show_wheel_location_func]](var_0);
  }

  foreach(var_2 in level.var_B163) {
    if(!isDefined(var_2.area_name)) {
      continue;
    }

    if(var_2.area_name == var_0) {
      func_100ED(var_2);
      level.current_active_wheel = var_2;
      continue;
    }

    func_8E95(var_2);
  }
}

init_magic_wheel(var_0) {
  if(!isDefined(var_0.area_name)) {
    return;
  }

  if(var_0.area_name != level.var_B161) {
    level thread func_8E95(var_0);
    return;
  }

  var_0 setscriptablepartstate("base", "on");
  var_0 setscriptablepartstate("fx", get_default_fx_state());
  var_0.var_10A03 setscriptablepartstate("spinner", "idle");
  var_1 = getEntArray("out_of_order", "script_noteworthy");
  var_2 = scripts\engine\utility::getclosest(var_0.origin, var_1);
  var_2 hide();
  var_0 makeusable();
  var_0 func_84A7("tag_use");
  var_0 setusefov(60);
  var_0 setuserange(72);
  level.current_active_wheel = var_0;
  if(isDefined(level.magic_wheel_spin_hint)) {
    var_0 sethintstring(level.magic_wheel_spin_hint);
    return;
  }

  var_0 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
}

func_8E95(var_0) {
  while(scripts\engine\utility::istrue(var_0.inuse)) {
    wait(0.05);
  }

  var_0 makeunusable();
  var_0 setscriptablepartstate("base", "off");
  var_0 setscriptablepartstate("fx", "off");
  var_0.var_10A03 setscriptablepartstate("spinner", "off");
  var_1 = getEntArray("out_of_order", "script_noteworthy");
  var_2 = scripts\engine\utility::getclosest(var_0.origin, var_1);
  playFX(level._effect["vfx_magicwheel_fire"], var_2.origin);
  wait(0.5);
  var_2 show();
}

func_100ED(var_0) {
  var_0 setscriptablepartstate("fx", "hideshow");
  var_0 setscriptablepartstate("base", "on");
  var_0.var_10A03 setscriptablepartstate("spinner", "activate");
  var_1 = getEntArray("out_of_order", "script_noteworthy");
  var_2 = scripts\engine\utility::getclosest(var_0.origin, var_1);
  playFX(level._effect["vfx_magicwheel_fire"], var_2.origin);
  wait(0.5);
  var_2 hide();
  var_3 = get_default_fx_state();
  if(scripts\engine\utility::flag("fire_sale")) {
    var_3 = "firesale";
  }

  var_0 setscriptablepartstate("fx", var_3);
  wait(1);
  var_0.var_10A03 setscriptablepartstate("spinner", "idle");
  var_0 makeusable();
  var_0 func_84A7("tag_use");
  var_0 setusefov(60);
  var_0 setuserange(72);
  if(scripts\engine\utility::flag_exist("fire_sale") && scripts\engine\utility::flag("fire_sale")) {
    var_0 sethintstring(&"COOP_INTERACTIONS_SPIN_WHEEL_FIRE_SALE");
    return;
  }

  if(isDefined(level.magic_wheel_spin_hint)) {
    var_0 sethintstring(level.magic_wheel_spin_hint);
    return;
  }

  var_0 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
}

get_default_fx_state() {
  if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && should_play_upgraded_magic_wheel_vfx()) {
    return "upgrade";
  }

  if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2) && should_play_upgraded_magic_wheel_vfx()) {
    return "upgrade";
  }

  return "normal";
}

should_play_upgraded_magic_wheel_vfx() {
  switch (level.script) {
    case "cp_disco":
      if(scripts\engine\utility::istrue(level.complete_skull_buster)) {
        return 1;
      } else {
        return 0;
      }

      break;

    default:
      return 0;
  }
}

get_area(var_0) {
  var_1 = getEntArray("spawn_volume", "targetname");
  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0.origin + (0, 0, 50), var_3)) {
      if(isDefined(var_3.basename)) {
        return var_3.basename;
      }
    }
  }

  return undefined;
}

func_12FFA(var_0, var_1, var_2) {
  level notify("magicWheelUsed");
  var_1 makeunusable();
  var_0.var_13103 = 1;
  var_1.var_10A05 = 1;
  var_1.inuse = 1;
  var_0 playlocalsound("zmb_wheel_spin_buy");
  var_3 = scripts\engine\utility::getclosest(var_1.origin, scripts\engine\utility::getstructarray("wheel_fx_spot", "targetname"));
  var_1 setscriptablepartstate("spin_light", "on");
  scripts\engine\utility::waitframe();
  var_4 = var_0 getweaponslistall();
  var_5 = [];
  foreach(var_7 in var_1.var_13C25) {
    var_8 = scripts\cp\utility::getbaseweaponname(var_7);
    var_9 = 0;
    foreach(var_11 in var_4) {
      var_12 = scripts\cp\utility::getbaseweaponname(var_11);
      if(var_12 == var_8 || issubstr(var_12, var_8)) {
        var_9 = 1;
        break;
      }
    }

    if(!var_9) {
      var_14 = var_7;
      var_15 = scripts\cp\utility::getrawbaseweaponname(var_7);
      if(isDefined(var_0.weapon_build_models[var_15])) {
        var_14 = var_0.weapon_build_models[var_15];
      }

      var_5[var_5.size] = var_14;
    }
  }

  scripts\cp\zombies\zombie_analytics::func_AF79(level.wave_num);
  var_1.var_13C25 = var_5;
  level thread func_1010C(var_1, var_0);
  level thread func_13D00(var_1);
  var_1.var_10A03 setscriptablepartstate("spinner", "spinning");
  var_1.var_10A03 rotatepitch(var_1.var_E74A, 5, 1, 4);
  var_1.var_10A03 waittill("rotatedone");
  var_1.var_10A05 = 0;
  var_1 waittill("ready");
  if(!level.var_B162) {
    var_1.var_10A03 setscriptablepartstate("spinner", "idle");
  }

  var_1.inuse = 0;
  var_1 setscriptablepartstate("spin_light", "off");
  if(!scripts\engine\utility::flag_exist("fire_sale") || !scripts\engine\utility::flag("fire_sale")) {
    if(level.var_B162) {
      if(isDefined(var_0)) {
        var_0 scripts\cp\cp_persistence::give_player_currency(var_2, undefined, undefined, 1, "magicWheelRefund");
      }

      level.var_B162 = 0;
      wait(0.5);
      if(isDefined(var_1.weapon)) {
        var_1.weapon delete();
      }

      func_BC3F();
      return;
    }

    wait(0.5);
    if(var_1 != level.current_active_wheel) {
      level thread func_8E95(var_1);
      return;
    }

    var_1 makeusable();
    var_1 func_84A7("tag_use");
    var_1 setusefov(60);
    var_1 setuserange(72);
    return;
  }

  wait(0.5);
  var_1 makeusable();
  var_1 func_84A7("tag_use");
  var_1 setusefov(60);
  var_1 setuserange(72);
}

func_13D00(var_0) {
  while(!isDefined(var_0.weapon)) {
    wait(0.05);
  }

  while(var_0.var_10A05) {
    var_1 = var_0.weapon.scriptmodelplayanim;
    wait(0.05);
  }
}

func_7B18(var_0) {
  var_1 = 21 / var_0.var_E74A / 5 * 0.05;
  if(var_1 - int(var_1) > 0) {
    var_1 = int(var_1) + 1;
  } else {
    var_1 = int(var_1);
  }

  var_0.var_E74D = var_1 * 0.05;
  var_2 = randomint(var_0.var_13C25.size);
  return var_0.var_13C25[var_2];
}

can_have_nunchucks(var_0) {
  if(var_0.vo_prefix != "p5_") {
    return 0;
  }

  var_1 = var_0 getplayerdata("cp", "alienSession", "escapedRank0");
  var_2 = var_0 getplayerdata("cp", "alienSession", "escapedRank1");
  var_3 = var_0 getplayerdata("cp", "alienSession", "escapedRank2");
  var_4 = var_0 getplayerdata("cp", "alienSession", "escapedRank3");
  if(isDefined(var_1) && var_1 == 1) {
    return 1;
  }

  if(isDefined(var_2) && var_2 == 1) {
    return 1;
  }

  if(isDefined(var_3) && var_3 == 1) {
    return 1;
  }

  if(isDefined(var_4) && var_4 == 1) {
    return 1;
  }

  return 0;
}

get_weapon_with_new_camo(var_0, var_1, var_2) {
  var_3 = getweaponbasename(var_1);
  var_4 = getweaponattachments(var_1);
  if(issubstr(var_3, "nunchucks") || issubstr(var_3, "venomx")) {}

  return var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_3, undefined, var_4, undefined, var_2);
}

func_1010C(var_0, var_1) {
  if(scripts\engine\utility::flag("fire_sale")) {
    var_0.fire_sale_spin = 1;
  }

  var_2 = undefined;
  var_0.var_BF6D = func_7B18(var_0);
  if(isDefined(level.nextwheelweaponfunc)) {
    var_0.var_BF6D = [[level.nextwheelweaponfunc]](var_0, var_0.var_BF6D, var_1);
  }

  if(level.script == "cp_disco") {
    if(scripts\engine\utility::istrue(var_1.finished_backstory) && !scripts\engine\utility::istrue(var_1.given_nunchucks)) {
      var_3 = "";
      if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
        var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_nunchucks_zm_pap2");
        var_3 = "iw7_nunchucks_zm_pap2";
      } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && !var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
        var_3 = "iw7_nunchucks_zm_pap1";
        var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_nunchucks_zm_pap1");
      } else if(!scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
        var_3 = "iw7_nunchucks_zm_pap1";
      } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
        var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_nunchucks_zm_pap2");
        var_3 = "iw7_nunchucks_zm_pap2";
      }

      if(var_3 != "") {
        var_0.var_BF6D = var_3;
      } else {
        var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_nunchucks_zm");
        var_0.var_BF6D = "iw7_nunchucks_zm";
      }

      var_1.given_nunchucks = 1;
    } else if(randomint(100) > 95 || getdvar("debug_gns_reward") != "") {
      if(!has_nunchucks_in_loadout(var_1) && scripts\cp\zombies\directors_cut::directors_cut_is_activated() || can_have_nunchucks(var_1)) {
        var_3 = "";
        if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
          var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_nunchucks_zm_pap2");
          var_3 = "iw7_nunchucks_zm_pap2";
        } else if(scripts\cp\zombies\directors_cut::directors_cut_is_activated()) {
          if(var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade") && scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1)) {
            var_3 = "iw7_nunchucks_zm_pap2";
            var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, var_3);
          } else {
            var_3 = "iw7_nunchucks_zm_pap1";
          }
        } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && !var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          var_3 = "iw7_nunchucks_zm_pap1";
          var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_nunchucks_zm_pap1");
        } else if(!scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          var_3 = "iw7_nunchucks_zm_pap1";
        } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_nunchucks_zm_pap2");
          var_3 = "iw7_nunchucks_zm_pap2";
        }

        if(var_3 != "") {
          var_0.var_BF6D = var_3;
        } else {
          var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_nunchucks_zm");
          var_0.var_BF6D = "iw7_nunchucks_zm";
        }
      }
    }
  }

  if(level.script == "cp_final") {
    if(randomint(100) > 95) {
      if(!has_venomx_in_loadout(var_1) && scripts\cp\zombies\directors_cut::directors_cut_is_activated() || can_have_venomx(var_1)) {
        var_3 = "";
        if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
          var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_venomx_zm_pap2+camo34");
          var_3 = "iw7_venomx_zm_pap2+camo34";
        } else if(scripts\cp\zombies\directors_cut::directors_cut_is_activated()) {
          if(var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
            var_3 = "iw7_venomx_zm_pap2+camo34";
          } else {
            var_3 = "iw7_venomx_zm_pap1+camo32";
          }
        } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && !var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          var_3 = "iw7_venomx_zm_pap1+camo32";
          var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_venomx_zm_pap1+camo32");
        } else if(!scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          var_3 = "iw7_venomx_zm_pap1+camo32";
        } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          var_0.var_13C25 = scripts\engine\utility::array_remove(var_0.var_13C25, "iw7_venomx_zm_pap1+camo32");
          var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_venomx_zm_pap2+camo34");
          var_3 = "iw7_venomx_zm_pap2+camo34";
        }

        if(var_3 != "") {
          var_0.var_BF6D = var_3;
          var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, var_3);
        } else {
          var_0.var_13C25 = scripts\engine\utility::array_add(var_0.var_13C25, "iw7_venomx_zm");
          var_0.var_BF6D = "iw7_venomx_zm";
        }
      }
    }
  }

  var_4 = getweaponindexfromlist(var_0.var_BF6D, var_0.var_13C25);
  if(scripts\engine\utility::array_contains(var_0.var_13C25, "iw7_forgefreeze_zm+forgefreezealtfire")) {
    var_0.var_13C25 = scripts\engine\utility::array_remove(var_0.var_13C25, "iw7_forgefreeze_zm+forgefreezealtfire");
  }

  var_1 loadweaponsforplayer([var_0.var_BF6D], 1);
  if(level.currentweaponlist.size > 0) {
    var_5 = level.currentweaponlist;
  } else {
    var_5 = getrotationlist(var_1.var_13C25);
  }

  if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) || scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
    foreach(var_8, var_7 in var_5) {
      var_5[var_8] = get_weapon_with_new_camo(var_1, var_7, get_camo_for_upgraded_weapon(getweaponbasename(var_7), var_1));
    }
  }

  level.activewheels++;
  level.currentweaponlist = var_5;
  loadworldweapons(var_5);
  var_9 = -1;
  var_10 = 0;
  var_11 = scripts\engine\utility::getclosest(var_0.origin, scripts\engine\utility::getstructarray("wheel_fx_spot", "targetname"));
  var_0.weapon = undefined;
  while(var_0.var_10A05) {
    wait(var_0.var_E74D);
    var_0 playSound("zmb_wheel_spin_tick");
    var_9++;
    if(isDefined(var_0.weapon)) {
      var_0.weapon setmoverweapon(var_5[var_9]);
    } else {
      var_0.weapon = spawn("script_weapon", var_11.origin, 0, 0, var_5[var_9]);
      if(isDefined(var_11.angles)) {
        var_0.weapon.angles = var_11.angles;
      } else {
        var_0.weapon.angles = (0, 0, 0);
      }
    }

    var_0.weapon.scriptmodelplayanim = var_5[var_9];
    if(var_9 >= var_5.size - 1) {
      var_9 = -1;
    }

    var_10++;
  }

  var_0.weapon.scriptmodelplayanim = var_0.var_13C25[var_4];
  if((isDefined(var_1) && isplayer(var_1) && scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1)) || scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
    var_0.weapon setmoverweapon(get_weapon_with_new_camo(var_1, var_0.weapon.scriptmodelplayanim, get_camo_for_upgraded_weapon(getweaponbasename(var_0.weapon.scriptmodelplayanim), var_1)));
  } else {
    var_0.weapon setmoverweapon(var_0.weapon.scriptmodelplayanim);
  }

  level.activewheels--;
  if(level.activewheels < 0) {
    level.activewheels = 0;
  }

  if(!level.activewheels) {
    clearworldweapons();
    level.currentweaponlist = [];
  }

  var_14 = scripts\cp\zombies\interaction_weapon_upgrade::getoffsetfrombaseweaponname(var_0.var_13C25[var_4]);
  var_0.weapon.origin = var_11.origin + var_14;
  playsoundatpos(var_0.origin, "zmb_wheel_spin_end");
  if(!isDefined(var_0.fire_sale_spin) && !scripts\engine\utility::flag_exist("fire_sale") || !scripts\engine\utility::flag("fire_sale")) {
    level.var_13D01++;
    var_15 = randomint(100);
    if(scripts\engine\utility::istrue(level.meph_fight_started)) {
      level.var_13D01 = 0;
    }

    if(level.var_13D01 == 7) {
      var_15 = 100;
    }

    if(var_15 > 50 && level.var_13D01 > 4) {
      level.var_B162 = 1;
      var_10 = var_0.weapon.origin;
      if(isDefined(var_0.weapon)) {
        var_0.weapon delete();
      }

      var_11 = spawn("script_model", var_10);
      var_11 setModel("zmb_arcade_toy_astronaut_blue");
      var_11.angles = var_0.angles;
      var_11 thread move_up_and_delete();
      var_0.var_10A03 setscriptablepartstate("spinner", "timetomove");
      level thread func_B16B(var_1);
      wait(3);
      var_0.var_10A03 setscriptablepartstate("spinner", "deactivate");
      var_0 setscriptablepartstate("base", "off");
      wait(2);
      level.var_13D01 = 0;
      var_0 setscriptablepartstate("fx", "hideshow");
      var_0 setscriptablepartstate("spin_light", "off");
      var_1.var_13103 = undefined;
      var_0 notify("ready");
      return;
    }
  }

  var_2.fire_sale_spin = undefined;
  var_2.weapon makeusable();
  foreach(var_13 in level.players) {
    if(var_13 == var_4) {
      var_2.weapon enableplayeruse(var_13);
      continue;
    }

    var_2.weapon disableplayeruse(var_13);
  }

  var_2.weapon thread wait_for_player_to_take_weapon(var_2);
  var_2.weapon scripts\engine\utility::waittill_any_timeout(12, "weapon_taken");
  var_2.weapon delete();
  if(scripts\engine\utility::array_contains(var_2.var_13C25, "iw7_nunchucks_zm")) {
    var_2.var_13C25 = scripts\engine\utility::array_remove(var_2.var_13C25, "iw7_nunchucks_zm");
  } else if(scripts\engine\utility::array_contains(var_2.var_13C25, "iw7_nunchucks_zm_pap2")) {
    var_2.var_13C25 = scripts\engine\utility::array_remove(var_2.var_13C25, "iw7_nunchucks_zm_pap2");
  }

  if(scripts\engine\utility::array_contains(var_2.var_13C25, "iw7_venomx_zm_pap1+camo32")) {
    var_2.var_13C25 = scripts\engine\utility::array_remove(var_2.var_13C25, "iw7_venomx_zm_pap1+camo32");
  } else if(scripts\engine\utility::array_contains(var_2.var_13C25, "iw7_venomx_zm_pap2+camo34")) {
    var_2.var_13C25 = scripts\engine\utility::array_remove(var_2.var_13C25, "iw7_venomx_zm_pap2+camo34");
  }

  var_2 setscriptablepartstate("spin_light", "off");
  var_2.var_13C25 = func_7ABF();
  var_2.var_E74A = func_7C20();
  var_4.var_13103 = undefined;
  var_2 notify("ready");
}

can_have_venomx(var_0) {
  if(scripts\engine\utility::flag_exist("completepuzzles_step4") && scripts\engine\utility::flag("completepuzzles_step4")) {
    if(!has_venomx_in_loadout(var_0)) {
      return 1;
    }

    return 0;
  }

  return 0;
}

has_venomx_in_loadout(var_0) {
  var_1 = var_0 getweaponslistall();
  foreach(var_3 in var_1) {
    if(issubstr(var_3, "venomx")) {
      return 1;
    }
  }

  return 0;
}

has_nunchucks_in_loadout(var_0) {
  var_1 = var_0 getweaponslistall();
  foreach(var_3 in var_1) {
    if(issubstr(var_3, "nunchucks")) {
      return 1;
    }
  }

  return 0;
}

getrotationlist(var_0) {
  var_1 = [];
  for(var_2 = 0; var_2 < 8; var_2++) {
    var_1[var_2] = var_0[var_2];
  }

  return var_1;
}

getweaponindexfromlist(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2]) {
      return var_2;
    }
  }

  return 0;
}

func_B16B(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_magicbox_laughter", "zmb_announcer_vo", "highest", 5, 0, 0, 1);
  wait(4);
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_badspin", "zmb_comment_vo", "low", 30, 0, 0, 1);
}

func_7C20() {
  var_0 = 1440;
  if(randomint(100) > 50) {
    var_0 = 1080;
  }

  return var_0;
}

move_up_and_delete() {
  self movez(50, 3, 2, 1);
  self rotateroll(-10, 1);
  wait(1);
  self rotateroll(10, 1);
  wait(1);
  self rotateroll(-10, 0.5);
  wait(0.5);
  self rotateroll(10, 0.5);
  wait(0.5);
  playFX(level._effect["vfx_magicwheel_toy_pop"], self.origin);
  self delete();
}

func_45FC(var_0) {}

func_7A37(var_0, var_1) {
  var_2 = getarraykeys(var_0);
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] == var_1) {
      return var_3;
    }
  }
}

func_782E(var_0, var_1) {
  var_2 = getarraykeys(var_0);
  return var_0[var_2[var_1]];
}

func_7D60(var_0) {
  if(isDefined(level.coop_weapontable)) {
    var_1 = level.coop_weapontable;
  } else {
    var_1 = "cp\cp_weapontable.csv";
  }

  return tablelookup(var_1, 2, var_0, 1);
}

wait_for_player_to_take_weapon(var_0) {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_1);
    if(var_1 ismeleeing() || var_1 meleebuttonpressed() || scripts\engine\utility::istrue(var_1.isusingsupercard)) {
      continue;
    }

    if(isDefined(level.magicwheel_weapon_take_check)) {
      if([[level.magicwheel_weapon_take_check]](var_0, var_1, self)) {
        break;
      } else {
        continue;
      }
    }

    break;
  }

  if(isDefined(self.scriptmodelplayanim) && getsubstr(self.scriptmodelplayanim, 0, 5) == "power") {
    if(level.powers[self.scriptmodelplayanim].defaultslot == "secondary") {
      var_1 scripts\cp\powers\coop_powers::givepower(self.scriptmodelplayanim, level.powers[self.scriptmodelplayanim].defaultslot, undefined, undefined, undefined, 0, 0);
    } else {
      var_1 scripts\cp\powers\coop_powers::givepower(self.scriptmodelplayanim, level.powers[self.scriptmodelplayanim].defaultslot, undefined, undefined, undefined, 0, 1);
    }
  } else {
    var_2 = self.scriptmodelplayanim;
    func_B16A(var_1, var_2);
    var_3 = scripts\cp\utility::getrawbaseweaponname(var_2);
    switch (var_3) {
      case "lmg03":
      case "sdflmg":
      case "mauler":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 25);
        break;

      case "katana":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_katana", "zmb_comment_vo", "low", 10, 0, 1, 0);
        break;

      case "venomx":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_venx", "zmb_comment_vo", "low", 10, 0, 1, 1, 50);
        break;

      case "nunchucks":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_nunchucks", "zmb_comment_vo", "low", 10, 0, 1, 0);
        break;

      case "forgefreeze":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0);
        break;

      case "glprox":
      case "chargeshot":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
        break;

      case "cheytac":
      case "kbs":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
        break;

      default:
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 25);
        break;
    }
  }

  self notify("weapon_taken");
  var_0 notify("weapon_taken");
  var_0.var_BF6D = undefined;
  playsoundatpos(self.origin, "zmb_wheel_wpn_acquired");
}

func_B16A(var_0, var_1) {
  var_0 notify("weapon_purchased");
  if(scripts\engine\utility::istrue(var_0.isusingsupercard)) {
    wait(0.5);
  }

  var_2 = undefined;
  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(var_0)) {
    var_3 = var_0 scripts\cp\utility::getvalidtakeweapon();
    var_4 = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_0 takeweapon(var_3);
    if(isDefined(var_0.pap[var_4])) {
      var_0.pap[var_4] = undefined;
      var_0 notify("weapon_level_changed");
    }
  }

  var_5 = scripts\cp\utility::getrawbaseweaponname(var_1);
  var_0 scripts\cp\utility::take_fists_weapon(var_0);
  if(isDefined(var_0.weapon_build_models[var_5])) {
    var_1 = var_0.weapon_build_models[var_5];
  }

  if(var_0 scripts\cp\cp_weapon::can_upgrade(var_1) && is_magic_wheel_upgrades(var_0)) {
    var_2 = get_camo_for_upgraded_weapon(var_5, var_0);
    var_6 = scripts\engine\utility::array_combine(getweaponattachments(var_1), [get_attachment_for_upgraded_weapon(var_1, var_0)]);
    var_1 = var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_1, undefined, var_6, undefined, var_2);
    var_1 = var_0 scripts\cp\utility::_giveweapon(var_1, undefined, undefined, 1);
    var_7 = scripts\cp\utility::getrawbaseweaponname(var_1);
    var_8 = spawnStruct();
    var_8.lvl = 2;
    if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
      var_8.lvl = 3;
    }

    var_0.pap[var_7] = var_8;
    var_0 notify("weapon_level_changed");
    var_0 scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
    if(var_0 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
      var_0 scripts\cp\utility::notify_used_consumable("magic_wheel_upgrade");
    }
  } else {
    var_6 = getweaponattachments(var_5);
    var_2 = var_1 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_2, undefined, var_8, undefined, undefined);
    var_2 = var_1 scripts\cp\utility::_giveweapon(var_2, undefined, undefined, 0);
    var_8 = spawnStruct();
    var_8.lvl = 1;
    var_0.pap[var_5] = var_8;
    var_0 scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
    var_0 notify("weapon_level_changed");
  }

  if(issubstr(var_1, "g18_") || level.script == "cp_final" && issubstr(var_1, "iw7_arclassic")) {
    var_0.has_replaced_starting_pistol = 1;
  }

  if(issubstr(var_1, "udm45_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_udm_unlock");
  }

  if(issubstr(var_1, "rvn_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_rvn_unlock");
  }

  if(issubstr(var_1, "crdb_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_crdb_unlock");
  }

  if(issubstr(var_1, "vr_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_vr_unlock");
  }

  if(issubstr(var_1, "mp28_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_mp28_unlock");
  }

  if(issubstr(var_1, "minilmg_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_minilmg_unlock");
  }

  if(issubstr(var_1, "ba50cal_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_ba50cal_unlock");
  }

  if(issubstr(var_1, "mod2187_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_mod2187_unlock");
  }

  if(issubstr(var_1, "longshot_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_longshot_unlock");
  }

  if(issubstr(var_1, "gauss_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_gauss_unlock");
  }

  if(issubstr(var_1, "mag_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_mag_unlock");
  }

  if(issubstr(var_1, "unsalmg_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_unsalmg_unlock");
  }

  if(issubstr(var_1, "tacburst_")) {
    var_0 scripts\cp\cp_merits::processmerit("mt_tacburst_unlock");
  }

  var_0 notify("wor_item_pickup", var_1);
  var_0 givemaxammo(var_1);
  var_0 switchtoweapon(var_1);
}

get_camo_for_upgraded_weapon(var_0, var_1) {
  var_2 = undefined;
  if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_0)) {
    var_2 = undefined;
  } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2) && isDefined(level.pap_2_camo)) {
    var_2 = level.pap_2_camo;
  } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade") && isDefined(level.pap_2_camo)) {
    var_2 = level.pap_2_camo;
  } else if(isDefined(level.pap_1_camo)) {
    var_2 = level.pap_1_camo;
  }

  switch (var_0) {
    case "dischord":
    case "iw7_dischord_zm_pap1":
      var_2 = "camo20";
      break;

    case "facemelter":
    case "iw7_facemelter_zm_pap1":
      var_2 = "camo22";
      break;

    case "headcutter":
    case "iw7_headcutter_zm_pap1":
      var_2 = "camo21";
      break;

    case "shredder":
    case "iw7_shredder_zm_pap1":
      var_2 = "camo23";
      break;

    case "nunchucks":
      var_2 = "camo222";
      break;

    case "iw7_cutie_zm":
      var_2 = undefined;
      break;
  }

  return var_2;
}

get_attachment_for_upgraded_weapon(var_0, var_1) {
  if(issubstr(var_0, "venomx")) {
    return undefined;
  }

  if(issubstr(var_0, "nunchucks")) {
    return undefined;
  }

  if(issubstr(var_0, "dischord") || issubstr(var_0, "facemelter") || issubstr(var_0, "headcutter") || issubstr(var_0, "shredder")) {
    return "pap1";
  }

  if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
    return "pap2";
  }

  if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && var_1 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
    return "pap2";
  }

  return "pap1";
}

is_magic_wheel_upgrades(var_0) {
  if(var_0 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
    return 1;
  }

  if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
    return 1;
  }

  if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1)) {
    return 1;
  }

  return 0;
}

func_10C4D(var_0, var_1, var_2) {
  level notify("activated" + var_0);
  level endon("activated" + var_0);
  level endon("deactivated" + var_0);
  level endon("game_ended");
  var_3 = undefined;
  level.active_power_ups["fire_sale"] = 1;
  scripts\engine\utility::flag_set("fire_sale");
  foreach(var_5 in level.var_B163) {
    if(!isDefined(var_5.area_name)) {
      continue;
    }

    if(var_5.area_name == level.var_A8E2) {
      var_5 sethintstring(&"COOP_INTERACTIONS_SPIN_WHEEL_FIRE_SALE");
      var_3 = var_5;
      continue;
    }

    thread func_100ED(var_5);
  }

  level thread func_4DB4(var_0, var_1, var_3);
  foreach(var_8 in level.players) {
    if(isDefined(level.temporal_increase)) {
      var_8 thread scripts\cp\loot::power_icon_active(30 * level.temporal_increase, "fire_30");
      continue;
    }

    var_8 thread scripts\cp\loot::power_icon_active(30, "fire_30");
  }
}

func_4DB4(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = scripts\engine\utility::waittill_any_timeout(var_1, "deactivated" + var_0, "activated" + var_0);
  if(var_3 != "activated" + var_0) {
    level.active_power_ups["fire_sale"] = 0;
    scripts\engine\utility::flag_clear("fire_sale");
    foreach(var_5 in level.var_B163) {
      if(!isDefined(var_5.area_name)) {
        continue;
      }

      if(!isDefined(var_2)) {
        func_BC3F();
      } else if(var_5 == var_2) {
        if(isDefined(level.magic_wheel_spin_hint)) {
          var_5 sethintstring(level.magic_wheel_spin_hint);
        } else {
          var_5 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
        }

        continue;
      }

      var_5 makeunusable();
      thread func_8E95(var_5);
    }

    foreach(var_8 in level.players) {
      var_8.var_8B7B = undefined;
    }

    level notify("deactivated" + var_0);
    var_10 = 1;
    while(var_10) {
      var_11 = 0;
      foreach(var_8 in level.players) {
        if(scripts\engine\utility::istrue(var_8.var_13103)) {
          wait(0.25);
          var_11 = 1;
          continue;
        }
      }

      if(!var_11) {
        var_10 = 0;
      }
    }

    wait(0.25);
  }
}

func_50DA(var_0) {
  level endon("game_ended");
  var_0 scripts\engine\utility::waittill_any("ready", "weapon_taken");
  func_8E95(var_0);
}