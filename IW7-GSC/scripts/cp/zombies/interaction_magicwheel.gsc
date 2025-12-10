/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_magicwheel.gsc
*********************************************************/

set_magic_wheel_starting_location(param_00) {
  level.var_B161 = param_00;
  level.var_A8E2 = param_00;
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
  foreach(var_01 in level.var_B163) {
    var_01.origin = var_01.origin + (0, 0, 0.15);
    var_01.area_name = get_area(var_01);
    if(isDefined(var_01.area_name)) {
      level.var_B160[level.var_B160.size] = var_01.area_name;
    }

    var_01.var_E74A = func_7C20();
    var_01.var_13C25 = func_7ABF();
    var_02 = scripts\engine\utility::getclosest(var_01.origin, scripts\engine\utility::getstructarray("spinner", "script_noteworthy"));
    var_03 = spawn("script_model", var_02.origin + (0, 0, 0.15));
    if(!isDefined(var_02.angles)) {
      var_02.angles = (0, 0, 0);
    }

    var_03.angles = var_02.angles;
    var_03 setModel("zmb_magic_wheel_spinner");
    var_01.var_10A03 = var_03;
    var_01 setnonstick(1);
    level thread init_magic_wheel(var_01);
    var_01 thread func_13643();
    scripts\engine\utility::waitframe();
  }
}

magic_wheel_tutorial() {
  self endon("death");
  self endon("disconnect");
  self endon("saw_wheel_tutorial");
  wait(5);
  var_00 = cos(65);
  for(;;) {
    var_01 = level.var_B163;
    var_02 = sortbydistance(var_01, self.origin);
    if(!self.hide_tutorial && var_02.size > 0) {
      if(distancesquared(var_02[0].origin, self.origin) < 9216 && scripts\engine\utility::within_fov(self.origin, self.angles, var_02[0].origin, var_00)) {
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
    self waittill("trigger", var_00);
    if(!var_00 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    var_01 = scripts\engine\utility::istrue(self.has_fnf_weapon);
    if(var_01) {
      level thread func_51EB(self, var_00, 1);
      continue;
    }

    if(isDefined(level.wheel_purchase_check)) {
      var_01 = [
        [level.wheel_purchase_check]
      ](self, var_00);
      if(var_01) {
        level thread[[level.wheel_hint_func]](self, var_00, 1);
        continue;
      }
    }

    if(scripts\engine\utility::flag_exist("fire_sale") && scripts\engine\utility::flag("fire_sale")) {
      var_02 = 10;
    } else {
      var_02 = 950;
    }

    if(isDefined(level.meph_fight_started)) {
      var_02 = 0;
    }

    if(var_00 scripts\cp\cp_persistence::player_has_enough_currency(var_02)) {
      var_00 scripts\cp\cp_persistence::take_player_currency(var_02, 1, "magic_wheel");
      func_12FFA(var_00, self, var_02);
      var_00 notify("magic_wheel_used");
      continue;
    }

    level thread func_51EB(self, var_00);
  }
}

func_51EB(param_00, param_01, param_02) {
  param_01 endon("disconnect");
  param_01 playlocalsound("purchase_deny");
  if(isDefined(param_02)) {
    param_01 forceusehinton(&"COOP_INTERACTIONS_CANNOT_BUY");
  } else {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
    param_01 forceusehinton(&"COOP_INTERACTIONS_NEED_MONEY");
  }

  wait(1);
  param_01 getrigindexfromarchetyperef();
}

func_BC3F() {
  for(;;) {
    var_00 = scripts\engine\utility::random(level.var_B160);
    if(var_00 != level.var_A8E2) {
      func_BC3E(var_00);
      return;
    }
  }
}

func_BC3E(param_00) {
  level.var_A8E2 = param_00;
  if(isDefined(level.show_wheel_location_func)) {
    level thread[[level.show_wheel_location_func]](param_00);
  }

  foreach(var_02 in level.var_B163) {
    if(!isDefined(var_02.area_name)) {
      continue;
    }

    if(var_02.area_name == param_00) {
      func_100ED(var_02);
      level.current_active_wheel = var_02;
      continue;
    }

    func_8E95(var_02);
  }
}

init_magic_wheel(param_00) {
  if(!isDefined(param_00.area_name)) {
    return;
  }

  if(param_00.area_name != level.var_B161) {
    level thread func_8E95(param_00);
    return;
  }

  param_00 setscriptablepartstate("base", "on");
  param_00 setscriptablepartstate("fx", get_default_fx_state());
  param_00.var_10A03 setscriptablepartstate("spinner", "idle");
  var_01 = getEntArray("out_of_order", "script_noteworthy");
  var_02 = scripts\engine\utility::getclosest(param_00.origin, var_01);
  var_02 hide();
  param_00 makeusable();
  param_00 _meth_84A7("tag_use");
  param_00 setusefov(60);
  param_00 setuserange(72);
  level.current_active_wheel = param_00;
  if(isDefined(level.magic_wheel_spin_hint)) {
    param_00 sethintstring(level.magic_wheel_spin_hint);
    return;
  }

  param_00 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
}

func_8E95(param_00) {
  while(scripts\engine\utility::istrue(param_00.inuse)) {
    wait(0.05);
  }

  param_00 makeunusable();
  param_00 setscriptablepartstate("base", "off");
  param_00 setscriptablepartstate("fx", "off");
  param_00.var_10A03 setscriptablepartstate("spinner", "off");
  var_01 = getEntArray("out_of_order", "script_noteworthy");
  var_02 = scripts\engine\utility::getclosest(param_00.origin, var_01);
  playFX(level._effect["vfx_magicwheel_fire"], var_02.origin);
  wait(0.5);
  var_02 show();
}

func_100ED(param_00) {
  param_00 setscriptablepartstate("fx", "hideshow");
  param_00 setscriptablepartstate("base", "on");
  param_00.var_10A03 setscriptablepartstate("spinner", "activate");
  var_01 = getEntArray("out_of_order", "script_noteworthy");
  var_02 = scripts\engine\utility::getclosest(param_00.origin, var_01);
  playFX(level._effect["vfx_magicwheel_fire"], var_02.origin);
  wait(0.5);
  var_02 hide();
  var_03 = get_default_fx_state();
  if(scripts\engine\utility::flag("fire_sale")) {
    var_03 = "firesale";
  }

  param_00 setscriptablepartstate("fx", var_03);
  wait(1);
  param_00.var_10A03 setscriptablepartstate("spinner", "idle");
  param_00 makeusable();
  param_00 _meth_84A7("tag_use");
  param_00 setusefov(60);
  param_00 setuserange(72);
  if(scripts\engine\utility::flag_exist("fire_sale") && scripts\engine\utility::flag("fire_sale")) {
    param_00 sethintstring(&"COOP_INTERACTIONS_SPIN_WHEEL_FIRE_SALE");
    return;
  }

  if(isDefined(level.magic_wheel_spin_hint)) {
    param_00 sethintstring(level.magic_wheel_spin_hint);
    return;
  }

  param_00 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
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

get_area(param_00) {
  var_01 = getEntArray("spawn_volume", "targetname");
  foreach(var_03 in var_01) {
    if(ispointinvolume(param_00.origin + (0, 0, 50), var_03)) {
      if(isDefined(var_03.basename)) {
        return var_03.basename;
      }
    }
  }

  return undefined;
}

func_12FFA(param_00, param_01, param_02) {
  level notify("magicWheelUsed");
  param_01 makeunusable();
  param_00.var_13103 = 1;
  param_01.var_10A05 = 1;
  param_01.inuse = 1;
  param_00 playlocalsound("zmb_wheel_spin_buy");
  var_03 = scripts\engine\utility::getclosest(param_01.origin, scripts\engine\utility::getstructarray("wheel_fx_spot", "targetname"));
  param_01 setscriptablepartstate("spin_light", "on");
  scripts\engine\utility::waitframe();
  var_04 = param_00 getweaponslistall();
  var_05 = [];
  foreach(var_07 in param_01.var_13C25) {
    var_08 = scripts\cp\utility::getbaseweaponname(var_07);
    var_09 = 0;
    foreach(var_0B in var_04) {
      var_0C = scripts\cp\utility::getbaseweaponname(var_0B);
      if(var_0C == var_08 || issubstr(var_0C, var_08)) {
        var_09 = 1;
        break;
      }
    }

    if(!var_09) {
      var_0E = var_07;
      var_0F = scripts\cp\utility::getrawbaseweaponname(var_07);
      if(isDefined(param_00.weapon_build_models[var_0F])) {
        var_0E = param_00.weapon_build_models[var_0F];
      }

      var_05[var_05.size] = var_0E;
    }
  }

  scripts\cp\zombies\zombie_analytics::func_AF79(level.wave_num);
  param_01.var_13C25 = var_05;
  level thread func_1010C(param_01, param_00);
  level thread func_13D00(param_01);
  param_01.var_10A03 setscriptablepartstate("spinner", "spinning");
  param_01.var_10A03 rotatepitch(param_01.var_E74A, 5, 1, 4);
  param_01.var_10A03 waittill("rotatedone");
  param_01.var_10A05 = 0;
  param_01 waittill("ready");
  if(!level.var_B162) {
    param_01.var_10A03 setscriptablepartstate("spinner", "idle");
  }

  param_01.inuse = 0;
  param_01 setscriptablepartstate("spin_light", "off");
  if(!scripts\engine\utility::flag_exist("fire_sale") || !scripts\engine\utility::flag("fire_sale")) {
    if(level.var_B162) {
      if(isDefined(param_00)) {
        param_00 scripts\cp\cp_persistence::give_player_currency(param_02, undefined, undefined, 1, "magicWheelRefund");
      }

      level.var_B162 = 0;
      wait(0.5);
      if(isDefined(param_01.var_394)) {
        param_01.var_394 delete();
      }

      func_BC3F();
      return;
    }

    wait(0.5);
    if(param_01 != level.current_active_wheel) {
      level thread func_8E95(param_01);
      return;
    }

    param_01 makeusable();
    param_01 _meth_84A7("tag_use");
    param_01 setusefov(60);
    param_01 setuserange(72);
    return;
  }

  wait(0.5);
  param_01 makeusable();
  param_01 _meth_84A7("tag_use");
  param_01 setusefov(60);
  param_01 setuserange(72);
}

func_13D00(param_00) {
  while(!isDefined(param_00.var_394)) {
    wait(0.05);
  }

  while(param_00.var_10A05) {
    var_01 = param_00.var_394.scriptmodelplayanim;
    wait(0.05);
  }
}

func_7B18(param_00) {
  var_01 = 21 / param_00.var_E74A / 5 * 0.05;
  if(var_01 - int(var_01) > 0) {
    var_01 = int(var_01) + 1;
  } else {
    var_01 = int(var_01);
  }

  param_00.var_E74D = var_01 * 0.05;
  var_02 = randomint(param_00.var_13C25.size);
  return param_00.var_13C25[var_02];
}

can_have_nunchucks(param_00) {
  if(param_00.vo_prefix != "p5_") {
    return 0;
  }

  var_01 = param_00 getplayerdata("cp", "alienSession", "escapedRank0");
  var_02 = param_00 getplayerdata("cp", "alienSession", "escapedRank1");
  var_03 = param_00 getplayerdata("cp", "alienSession", "escapedRank2");
  var_04 = param_00 getplayerdata("cp", "alienSession", "escapedRank3");
  if(isDefined(var_01) && var_01 == 1) {
    return 1;
  }

  if(isDefined(var_02) && var_02 == 1) {
    return 1;
  }

  if(isDefined(var_03) && var_03 == 1) {
    return 1;
  }

  if(isDefined(var_04) && var_04 == 1) {
    return 1;
  }

  return 0;
}

get_weapon_with_new_camo(param_00, param_01, param_02) {
  var_03 = getweaponbasename(param_01);
  var_04 = getweaponattachments(param_01);
  if(issubstr(var_03, "nunchucks") || issubstr(var_03, "venomx")) {}

  return param_00 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_03, undefined, var_04, undefined, param_02);
}

func_1010C(param_00, param_01) {
  if(scripts\engine\utility::flag("fire_sale")) {
    param_00.fire_sale_spin = 1;
  }

  var_02 = undefined;
  param_00.var_BF6D = func_7B18(param_00);
  if(isDefined(level.nextwheelweaponfunc)) {
    param_00.var_BF6D = [[level.nextwheelweaponfunc]](param_00, param_00.var_BF6D, param_01);
  }

  if(level.script == "cp_disco") {
    if(scripts\engine\utility::istrue(param_01.finished_backstory) && !scripts\engine\utility::istrue(param_01.given_nunchucks)) {
      var_03 = "";
      if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
        param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_nunchucks_zm_pap2");
        var_03 = "iw7_nunchucks_zm_pap2";
      } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && !param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
        var_03 = "iw7_nunchucks_zm_pap1";
        param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_nunchucks_zm_pap1");
      } else if(!scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
        var_03 = "iw7_nunchucks_zm_pap1";
      } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
        param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_nunchucks_zm_pap2");
        var_03 = "iw7_nunchucks_zm_pap2";
      }

      if(var_03 != "") {
        param_00.var_BF6D = var_03;
      } else {
        param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_nunchucks_zm");
        param_00.var_BF6D = "iw7_nunchucks_zm";
      }

      param_01.given_nunchucks = 1;
    } else if(randomint(100) > 95 || getdvar("debug_gns_reward") != "") {
      if(!has_nunchucks_in_loadout(param_01) && scripts\cp\zombies\directors_cut::directors_cut_is_activated() || can_have_nunchucks(param_01)) {
        var_03 = "";
        if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
          param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_nunchucks_zm_pap2");
          var_03 = "iw7_nunchucks_zm_pap2";
        } else if(scripts\cp\zombies\directors_cut::directors_cut_is_activated()) {
          if(param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade") && scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1)) {
            var_03 = "iw7_nunchucks_zm_pap2";
            param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, var_03);
          } else {
            var_03 = "iw7_nunchucks_zm_pap1";
          }
        } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && !param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          var_03 = "iw7_nunchucks_zm_pap1";
          param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_nunchucks_zm_pap1");
        } else if(!scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          var_03 = "iw7_nunchucks_zm_pap1";
        } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_nunchucks_zm_pap2");
          var_03 = "iw7_nunchucks_zm_pap2";
        }

        if(var_03 != "") {
          param_00.var_BF6D = var_03;
        } else {
          param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_nunchucks_zm");
          param_00.var_BF6D = "iw7_nunchucks_zm";
        }
      }
    }
  }

  if(level.script == "cp_final") {
    if(randomint(100) > 95) {
      if(!has_venomx_in_loadout(param_01) && scripts\cp\zombies\directors_cut::directors_cut_is_activated() || can_have_venomx(param_01)) {
        var_03 = "";
        if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
          param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_venomx_zm_pap2+camo34");
          var_03 = "iw7_venomx_zm_pap2+camo34";
        } else if(scripts\cp\zombies\directors_cut::directors_cut_is_activated()) {
          if(param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
            var_03 = "iw7_venomx_zm_pap2+camo34";
          } else {
            var_03 = "iw7_venomx_zm_pap1+camo32";
          }
        } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && !param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          var_03 = "iw7_venomx_zm_pap1+camo32";
          param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_venomx_zm_pap1+camo32");
        } else if(!scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          var_03 = "iw7_venomx_zm_pap1+camo32";
        } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
          param_00.var_13C25 = scripts\engine\utility::array_remove(param_00.var_13C25, "iw7_venomx_zm_pap1+camo32");
          param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_venomx_zm_pap2+camo34");
          var_03 = "iw7_venomx_zm_pap2+camo34";
        }

        if(var_03 != "") {
          param_00.var_BF6D = var_03;
          param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, var_03);
        } else {
          param_00.var_13C25 = scripts\engine\utility::array_add(param_00.var_13C25, "iw7_venomx_zm");
          param_00.var_BF6D = "iw7_venomx_zm";
        }
      }
    }
  }

  var_04 = getweaponindexfromlist(param_00.var_BF6D, param_00.var_13C25);
  if(scripts\engine\utility::array_contains(param_00.var_13C25, "iw7_forgefreeze_zm+forgefreezealtfire")) {
    param_00.var_13C25 = scripts\engine\utility::array_remove(param_00.var_13C25, "iw7_forgefreeze_zm+forgefreezealtfire");
  }

  param_01 loadweaponsforplayer([param_00.var_BF6D], 1);
  if(level.currentweaponlist.size > 0) {
    var_05 = level.currentweaponlist;
  } else {
    var_05 = getrotationlist(param_01.var_13C25);
  }

  if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) || scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
    foreach(var_08, var_07 in var_05) {
      var_05[var_08] = get_weapon_with_new_camo(param_01, var_07, get_camo_for_upgraded_weapon(getweaponbasename(var_07), param_01));
    }
  }

  level.activewheels++;
  level.currentweaponlist = var_05;
  loadworldweapons(var_05);
  var_09 = -1;
  var_0A = 0;
  var_0B = scripts\engine\utility::getclosest(param_00.origin, scripts\engine\utility::getstructarray("wheel_fx_spot", "targetname"));
  param_00.var_394 = undefined;
  while(param_00.var_10A05) {
    wait(param_00.var_E74D);
    param_00 playSound("zmb_wheel_spin_tick");
    var_09++;
    if(isDefined(param_00.var_394)) {
      param_00.var_394 setmoverweapon(var_05[var_09]);
    } else {
      param_00.var_394 = spawn("script_weapon", var_0B.origin, 0, 0, var_05[var_09]);
      if(isDefined(var_0B.angles)) {
        param_00.var_394.angles = var_0B.angles;
      } else {
        param_00.var_394.angles = (0, 0, 0);
      }
    }

    param_00.var_394.scriptmodelplayanim = var_05[var_09];
    if(var_09 >= var_05.size - 1) {
      var_09 = -1;
    }

    var_0A++;
  }

  param_00.var_394.scriptmodelplayanim = param_00.var_13C25[var_04];
  if((isDefined(param_01) && isplayer(param_01) && scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1)) || scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
    param_00.var_394 setmoverweapon(get_weapon_with_new_camo(param_01, param_00.var_394.scriptmodelplayanim, get_camo_for_upgraded_weapon(getweaponbasename(param_00.var_394.scriptmodelplayanim), param_01)));
  } else {
    param_00.var_394 setmoverweapon(param_00.var_394.scriptmodelplayanim);
  }

  level.activewheels--;
  if(level.activewheels < 0) {
    level.activewheels = 0;
  }

  if(!level.activewheels) {
    clearworldweapons();
    level.currentweaponlist = [];
  }

  var_0E = scripts\cp\zombies\interaction_weapon_upgrade::getoffsetfrombaseweaponname(param_00.var_13C25[var_04]);
  param_00.var_394.origin = var_0B.origin + var_0E;
  playsoundatpos(param_00.origin, "zmb_wheel_spin_end");
  if(!isDefined(param_00.fire_sale_spin) && !scripts\engine\utility::flag_exist("fire_sale") || !scripts\engine\utility::flag("fire_sale")) {
    level.var_13D01++;
    var_0F = randomint(100);
    if(scripts\engine\utility::istrue(level.meph_fight_started)) {
      level.var_13D01 = 0;
    }

    if(level.var_13D01 == 7) {
      var_0F = 100;
    }

    if(var_0F > 50 && level.var_13D01 > 4) {
      level.var_B162 = 1;
      var_10 = param_00.var_394.origin;
      if(isDefined(param_00.var_394)) {
        param_00.var_394 delete();
      }

      var_11 = spawn("script_model", var_10);
      var_11 setModel("zmb_arcade_toy_astronaut_blue");
      var_11.angles = param_00.angles;
      var_11 thread move_up_and_delete();
      param_00.var_10A03 setscriptablepartstate("spinner", "timetomove");
      level thread func_B16B(param_01);
      wait(3);
      param_00.var_10A03 setscriptablepartstate("spinner", "deactivate");
      param_00 setscriptablepartstate("base", "off");
      wait(2);
      level.var_13D01 = 0;
      param_00 setscriptablepartstate("fx", "hideshow");
      param_00 setscriptablepartstate("spin_light", "off");
      param_01.var_13103 = undefined;
      param_00 notify("ready");
      return;
    }
  }

  var_02.fire_sale_spin = undefined;
  var_02.var_394 makeusable();
  foreach(var_13 in level.players) {
    if(var_13 == var_04) {
      var_02.var_394 enableplayeruse(var_13);
      continue;
    }

    var_02.var_394 disableplayeruse(var_13);
  }

  var_02.var_394 thread wait_for_player_to_take_weapon(var_02);
  var_02.var_394 scripts\engine\utility::waittill_any_timeout_1(12, "weapon_taken");
  var_02.var_394 delete();
  if(scripts\engine\utility::array_contains(var_02.var_13C25, "iw7_nunchucks_zm")) {
    var_02.var_13C25 = scripts\engine\utility::array_remove(var_02.var_13C25, "iw7_nunchucks_zm");
  } else if(scripts\engine\utility::array_contains(var_02.var_13C25, "iw7_nunchucks_zm_pap2")) {
    var_02.var_13C25 = scripts\engine\utility::array_remove(var_02.var_13C25, "iw7_nunchucks_zm_pap2");
  }

  if(scripts\engine\utility::array_contains(var_02.var_13C25, "iw7_venomx_zm_pap1+camo32")) {
    var_02.var_13C25 = scripts\engine\utility::array_remove(var_02.var_13C25, "iw7_venomx_zm_pap1+camo32");
  } else if(scripts\engine\utility::array_contains(var_02.var_13C25, "iw7_venomx_zm_pap2+camo34")) {
    var_02.var_13C25 = scripts\engine\utility::array_remove(var_02.var_13C25, "iw7_venomx_zm_pap2+camo34");
  }

  var_02 setscriptablepartstate("spin_light", "off");
  var_02.var_13C25 = func_7ABF();
  var_02.var_E74A = func_7C20();
  var_04.var_13103 = undefined;
  var_02 notify("ready");
}

can_have_venomx(param_00) {
  if(scripts\engine\utility::flag_exist("completepuzzles_step4") && scripts\engine\utility::flag("completepuzzles_step4")) {
    if(!has_venomx_in_loadout(param_00)) {
      return 1;
    }

    return 0;
  }

  return 0;
}

has_venomx_in_loadout(param_00) {
  var_01 = param_00 getweaponslistall();
  foreach(var_03 in var_01) {
    if(issubstr(var_03, "venomx")) {
      return 1;
    }
  }

  return 0;
}

has_nunchucks_in_loadout(param_00) {
  var_01 = param_00 getweaponslistall();
  foreach(var_03 in var_01) {
    if(issubstr(var_03, "nunchucks")) {
      return 1;
    }
  }

  return 0;
}

getrotationlist(param_00) {
  var_01 = [];
  for(var_02 = 0; var_02 < 8; var_02++) {
    var_01[var_02] = param_00[var_02];
  }

  return var_01;
}

getweaponindexfromlist(param_00, param_01) {
  for(var_02 = 0; var_02 < param_01.size; var_02++) {
    if(param_00 == param_01[var_02]) {
      return var_02;
    }
  }

  return 0;
}

func_B16B(param_00) {
  param_00 endon("disconnect");
  level endon("game_ended");
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_magicbox_laughter", "zmb_announcer_vo", "highest", 5, 0, 0, 1);
  wait(4);
  param_00 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_badspin", "zmb_comment_vo", "low", 30, 0, 0, 1);
}

func_7C20() {
  var_00 = 1440;
  if(randomint(100) > 50) {
    var_00 = 1080;
  }

  return var_00;
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

func_45FC(param_00) {}

func_7A37(param_00, param_01) {
  var_02 = getarraykeys(param_00);
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(var_02[var_03] == param_01) {
      return var_03;
    }
  }
}

func_782E(param_00, param_01) {
  var_02 = getarraykeys(param_00);
  return param_00[var_02[param_01]];
}

func_7D60(param_00) {
  if(isDefined(level.coop_weapontable)) {
    var_01 = level.coop_weapontable;
  } else {
    var_01 = "cp\cp_weapontable.csv";
  }

  return tablelookup(var_01, 2, param_00, 1);
}

wait_for_player_to_take_weapon(param_00) {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_01);
    if(var_01 ismeleeing() || var_01 meleebuttonpressed() || scripts\engine\utility::istrue(var_01.isusingsupercard)) {
      continue;
    }

    if(isDefined(level.magicwheel_weapon_take_check)) {
      if([
          [level.magicwheel_weapon_take_check]
        ](param_00, var_01, self)) {
        break;
      } else {
        continue;
      }
    }

    break;
  }

  if(isDefined(self.scriptmodelplayanim) && getsubstr(self.scriptmodelplayanim, 0, 5) == "power") {
    if(level.powers[self.scriptmodelplayanim].defaultslot == "secondary") {
      var_01 scripts\cp\powers\coop_powers::givepower(self.scriptmodelplayanim, level.powers[self.scriptmodelplayanim].defaultslot, undefined, undefined, undefined, 0, 0);
    } else {
      var_01 scripts\cp\powers\coop_powers::givepower(self.scriptmodelplayanim, level.powers[self.scriptmodelplayanim].defaultslot, undefined, undefined, undefined, 0, 1);
    }
  } else {
    var_02 = self.scriptmodelplayanim;
    func_B16A(var_01, var_02);
    var_03 = scripts\cp\utility::getrawbaseweaponname(var_02);
    switch (var_03) {
      case "lmg03":
      case "sdflmg":
      case "mauler":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 25);
        break;

      case "katana":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_katana", "zmb_comment_vo", "low", 10, 0, 1, 0);
        break;

      case "venomx":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_venx", "zmb_comment_vo", "low", 10, 0, 1, 1, 50);
        break;

      case "nunchucks":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_nunchucks", "zmb_comment_vo", "low", 10, 0, 1, 0);
        break;

      case "forgefreeze":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0);
        break;

      case "glprox":
      case "chargeshot":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
        break;

      case "cheytac":
      case "kbs":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
        break;

      default:
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 25);
        break;
    }
  }

  self notify("weapon_taken");
  param_00 notify("weapon_taken");
  param_00.var_BF6D = undefined;
  playsoundatpos(self.origin, "zmb_wheel_wpn_acquired");
}

func_B16A(param_00, param_01) {
  param_00 notify("weapon_purchased");
  if(scripts\engine\utility::istrue(param_00.isusingsupercard)) {
    wait(0.5);
  }

  var_02 = undefined;
  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(param_00)) {
    var_03 = param_00 scripts\cp\utility::getvalidtakeweapon();
    var_04 = scripts\cp\utility::getrawbaseweaponname(var_03);
    param_00 takeweapon(var_03);
    if(isDefined(param_00.pap[var_04])) {
      param_00.pap[var_04] = undefined;
      param_00 notify("weapon_level_changed");
    }
  }

  var_05 = scripts\cp\utility::getrawbaseweaponname(param_01);
  param_00 scripts\cp\utility::take_fists_weapon(param_00);
  if(isDefined(param_00.weapon_build_models[var_05])) {
    param_01 = param_00.weapon_build_models[var_05];
  }

  if(param_00 scripts\cp\cp_weapon::can_upgrade(param_01) && is_magic_wheel_upgrades(param_00)) {
    var_02 = get_camo_for_upgraded_weapon(var_05, param_00);
    var_06 = scripts\engine\utility::array_combine(getweaponattachments(param_01), [get_attachment_for_upgraded_weapon(param_01, param_00)]);
    param_01 = param_00 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(param_01, undefined, var_06, undefined, var_02);
    param_01 = param_00 scripts\cp\utility::_giveweapon(param_01, undefined, undefined, 1);
    var_07 = scripts\cp\utility::getrawbaseweaponname(param_01);
    var_08 = spawnStruct();
    var_08.lvl = 2;
    if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
      var_08.lvl = 3;
    }

    param_00.pap[var_07] = var_08;
    param_00 notify("weapon_level_changed");
    param_00 scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
    if(param_00 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
      param_00 scripts\cp\utility::notify_used_consumable("magic_wheel_upgrade");
    }
  } else {
    var_06 = getweaponattachments(var_05);
    var_02 = param_01 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_02, undefined, var_08, undefined, undefined);
    var_02 = param_01 scripts\cp\utility::_giveweapon(var_02, undefined, undefined, 0);
    var_08 = spawnStruct();
    var_08.lvl = 1;
    param_00.pap[var_05] = var_08;
    param_00 scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
    param_00 notify("weapon_level_changed");
  }

  if(issubstr(param_01, "g18_") || level.script == "cp_final" && issubstr(param_01, "iw7_arclassic")) {
    param_00.has_replaced_starting_pistol = 1;
  }

  if(issubstr(param_01, "udm45_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_udm_unlock");
  }

  if(issubstr(param_01, "rvn_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_rvn_unlock");
  }

  if(issubstr(param_01, "crdb_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_crdb_unlock");
  }

  if(issubstr(param_01, "vr_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_vr_unlock");
  }

  if(issubstr(param_01, "mp28_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_mp28_unlock");
  }

  if(issubstr(param_01, "minilmg_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_minilmg_unlock");
  }

  if(issubstr(param_01, "ba50cal_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_ba50cal_unlock");
  }

  if(issubstr(param_01, "mod2187_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_mod2187_unlock");
  }

  if(issubstr(param_01, "longshot_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_longshot_unlock");
  }

  if(issubstr(param_01, "gauss_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_gauss_unlock");
  }

  if(issubstr(param_01, "mag_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_mag_unlock");
  }

  if(issubstr(param_01, "unsalmg_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_unsalmg_unlock");
  }

  if(issubstr(param_01, "tacburst_")) {
    param_00 scripts\cp\cp_merits::processmerit("mt_tacburst_unlock");
  }

  param_00 notify("wor_item_pickup", param_01);
  param_00 givemaxammo(param_01);
  param_00 switchtoweapon(param_01);
}

get_camo_for_upgraded_weapon(param_00, param_01) {
  var_02 = undefined;
  if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, param_00)) {
    var_02 = undefined;
  } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2) && isDefined(level.pap_2_camo)) {
    var_02 = level.pap_2_camo;
  } else if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade") && isDefined(level.pap_2_camo)) {
    var_02 = level.pap_2_camo;
  } else if(isDefined(level.pap_1_camo)) {
    var_02 = level.pap_1_camo;
  }

  switch (param_00) {
    case "dischord":
    case "iw7_dischord_zm_pap1":
      var_02 = "camo20";
      break;

    case "facemelter":
    case "iw7_facemelter_zm_pap1":
      var_02 = "camo22";
      break;

    case "headcutter":
    case "iw7_headcutter_zm_pap1":
      var_02 = "camo21";
      break;

    case "shredder":
    case "iw7_shredder_zm_pap1":
      var_02 = "camo23";
      break;

    case "nunchucks":
      var_02 = "camo222";
      break;

    case "iw7_cutie_zm":
      var_02 = undefined;
      break;
  }

  return var_02;
}

get_attachment_for_upgraded_weapon(param_00, param_01) {
  if(issubstr(param_00, "venomx")) {
    return undefined;
  }

  if(issubstr(param_00, "nunchucks")) {
    return undefined;
  }

  if(issubstr(param_00, "dischord") || issubstr(param_00, "facemelter") || issubstr(param_00, "headcutter") || issubstr(param_00, "shredder")) {
    return "pap1";
  }

  if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap2)) {
    return "pap2";
  }

  if(scripts\engine\utility::istrue(level.magic_wheel_upgraded_pap1) && param_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
    return "pap2";
  }

  return "pap1";
}

is_magic_wheel_upgrades(param_00) {
  if(param_00 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
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

func_10C4D(param_00, param_01, param_02) {
  level notify("activated" + param_00);
  level endon("activated" + param_00);
  level endon("deactivated" + param_00);
  level endon("game_ended");
  var_03 = undefined;
  level.active_power_ups["fire_sale"] = 1;
  scripts\engine\utility::flag_set("fire_sale");
  foreach(var_05 in level.var_B163) {
    if(!isDefined(var_05.area_name)) {
      continue;
    }

    if(var_05.area_name == level.var_A8E2) {
      var_05 sethintstring(&"COOP_INTERACTIONS_SPIN_WHEEL_FIRE_SALE");
      var_03 = var_05;
      continue;
    }

    thread func_100ED(var_05);
  }

  level thread func_4DB4(param_00, param_01, var_03);
  foreach(var_08 in level.players) {
    if(isDefined(level.temporal_increase)) {
      var_08 thread scripts\cp\loot::power_icon_active(30 * level.temporal_increase, "fire_30");
      continue;
    }

    var_08 thread scripts\cp\loot::power_icon_active(30, "fire_30");
  }
}

func_4DB4(param_00, param_01, param_02) {
  level endon("game_ended");
  var_03 = scripts\engine\utility::waittill_any_timeout_1(param_01, "deactivated" + param_00, "activated" + param_00);
  if(var_03 != "activated" + param_00) {
    level.active_power_ups["fire_sale"] = 0;
    scripts\engine\utility::flag_clear("fire_sale");
    foreach(var_05 in level.var_B163) {
      if(!isDefined(var_05.area_name)) {
        continue;
      }

      if(!isDefined(param_02)) {
        func_BC3F();
      } else if(var_05 == param_02) {
        if(isDefined(level.magic_wheel_spin_hint)) {
          var_05 sethintstring(level.magic_wheel_spin_hint);
        } else {
          var_05 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
        }

        continue;
      }

      var_05 makeunusable();
      thread func_8E95(var_05);
    }

    foreach(var_08 in level.players) {
      var_08.var_8B7B = undefined;
    }

    level notify("deactivated" + param_00);
    var_0A = 1;
    while(var_0A) {
      var_0B = 0;
      foreach(var_08 in level.players) {
        if(scripts\engine\utility::istrue(var_08.var_13103)) {
          wait(0.25);
          var_0B = 1;
          continue;
        }
      }

      if(!var_0B) {
        var_0A = 0;
      }
    }

    wait(0.25);
  }
}

func_50DA(param_00) {
  level endon("game_ended");
  param_00 scripts\engine\utility::waittill_any_3("ready", "weapon_taken");
  func_8E95(param_00);
}