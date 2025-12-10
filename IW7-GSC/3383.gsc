/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3383.gsc
***************************************/

set_magic_wheel_starting_location(var_00) {
  level.func_B161 = var_00;
  level.func_A8E2 = var_00;
}

func_94EF() {
  wait 2;
  level.currentweaponlist = [];
  level.activewheels = 0;
  level.current_active_wheel = undefined;
  level.func_13D01 = 0;
  level.func_B162 = 0;
  level.func_B160 = [];
  level.fire_sale_func = ::func_10C4D;
  level.func_B163 = getEntArray("magic_wheel", "script_noteworthy");

  foreach(var_01 in level.func_B163) {
    var_1.origin = var_1.origin + (0, 0, 0.15);
    var_1.area_name = get_area(var_01);
    level.func_B160[level.func_B160.size] = var_1.area_name;
    var_1.func_E74A = func_7C20();
    var_1.func_13C25 = func_7ABF();
    var_02 = scripts\engine\utility::getclosest(var_1.origin, scripts\engine\utility::getstructarray("spinner", "script_noteworthy"));
    var_03 = spawn("script_model", var_2.origin + (0, 0, 0.15));

    if(!isDefined(var_2.angles))
      var_2.angles = (0, 0, 0);

    var_3.angles = var_2.angles;
    var_03 setModel("zmb_magic_wheel_spinner");
    var_1.func_10A03 = var_03;
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
  wait 5;
  var_00 = cos(65);

  for(;;) {
    var_01 = level.func_B163;
    var_02 = sortbydistance(var_01, self.origin);

    if(!self.hide_tutorial && var_2.size > 0) {
      if(distancesquared(var_2[0].origin, self.origin) < 9216 && scripts\engine\utility::within_fov(self.origin, self.angles, var_2[0].origin, var_00)) {
        thread scripts\cp\cp_hud_message::tutorial_lookup_func("magic_wheel");
        wait 1;
        self notify("saw_wheel_tutorial");
      }
    }

    wait 0.25;
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
    var_01 = scripts\engine\utility::is_true(self.has_fnf_weapon);

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

    if(scripts\engine\utility::flag_exist("fire_sale") && scripts\engine\utility::flag("fire_sale"))
      var_02 = 10;
    else
      var_02 = 950;

    if(var_00 scripts\cp\cp_persistence::player_has_enough_currency(var_02)) {
      var_00 scripts\cp\cp_persistence::take_player_currency(var_02, 1, "magic_wheel");
      func_12FFA(var_00, self, var_02);
      var_00 notify("magic_wheel_used");
      continue;
    }

    level thread func_51EB(self, var_00);
  }
}

func_51EB(var_00, var_01, var_02) {
  var_01 endon("disconnect");
  var_01 playlocalsound("purchase_deny");

  if(isDefined(var_02))
    var_01 forceusehinton(&"COOP_INTERACTIONS_CANNOT_BUY");
  else {
    var_01 thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
    var_01 forceusehinton(&"COOP_INTERACTIONS_NEED_MONEY");
  }

  wait 1;
  var_01 getrigindexfromarchetyperef();
}

func_BC3F() {
  for(;;) {
    var_00 = scripts\engine\utility::random(level.func_B160);

    if(var_00 != level.func_A8E2) {
      func_BC3E(var_00);
      return;
    }
  }
}

func_BC3E(var_00) {
  level.func_A8E2 = var_00;

  foreach(var_02 in level.func_B163) {
    if(var_2.area_name == var_00) {
      func_100ED(var_02);
      level.current_active_wheel = var_02;
      continue;
    }

    func_8E95(var_02);
  }
}

init_magic_wheel(var_00) {
  if(!isDefined(var_0.area_name)) {
    return;
  }
  if(var_0.area_name != level.func_B161)
    level thread func_8E95(var_00);
  else {
    var_00 setscriptablepartstate("base", "on");
    var_00 setscriptablepartstate("fx", get_default_fx_state());
    var_0.func_10A03 setscriptablepartstate("spinner", "idle");
    var_01 = getEntArray("out_of_order", "script_noteworthy");
    var_02 = scripts\engine\utility::getclosest(var_0.origin, var_01);
    var_02 hide();
    var_00 makeusable();
    var_00 _meth_84A7("tag_use");
    var_00 setusefov(60);
    var_00 setuserange(72);
    level.current_active_wheel = var_00;

    if(isDefined(level.magic_wheel_spin_hint))
      var_00 sethintstring(level.magic_wheel_spin_hint);
    else
      var_00 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
  }
}

func_8E95(var_00) {
  while(scripts\engine\utility::is_true(var_0.inuse))
    wait 0.05;

  var_00 makeunusable();
  var_00 setscriptablepartstate("base", "off");
  var_00 setscriptablepartstate("fx", "off");
  var_0.func_10A03 setscriptablepartstate("spinner", "off");
  var_01 = getEntArray("out_of_order", "script_noteworthy");
  var_02 = scripts\engine\utility::getclosest(var_0.origin, var_01);
  playFX(level._effect["vfx_magicwheel_fire"], var_2.origin);
  wait 0.5;
  var_02 show();
}

func_100ED(var_00) {
  var_00 setscriptablepartstate("fx", "hideshow");
  var_00 setscriptablepartstate("base", "on");
  var_0.func_10A03 setscriptablepartstate("spinner", "activate");
  var_01 = getEntArray("out_of_order", "script_noteworthy");
  var_02 = scripts\engine\utility::getclosest(var_0.origin, var_01);
  playFX(level._effect["vfx_magicwheel_fire"], var_2.origin);
  wait 0.5;
  var_02 hide();
  var_03 = get_default_fx_state();

  if(scripts\engine\utility::flag("fire_sale"))
    var_03 = "firesale";

  var_00 setscriptablepartstate("fx", var_03);
  wait 1;
  var_0.func_10A03 setscriptablepartstate("spinner", "idle");
  var_00 makeusable();
  var_00 _meth_84A7("tag_use");
  var_00 setusefov(60);
  var_00 setuserange(72);

  if(scripts\engine\utility::flag_exist("fire_sale") && scripts\engine\utility::flag("fire_sale"))
    var_00 sethintstring(&"COOP_INTERACTIONS_SPIN_WHEEL_FIRE_SALE");
  else if(isDefined(level.magic_wheel_spin_hint))
    var_00 sethintstring(level.magic_wheel_spin_hint);
  else
    var_00 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");
}

get_default_fx_state() {
  if(scripts\engine\utility::is_true(level.magic_wheel_upgraded))
    return "upgrade";

  return "normal";
}

get_area(var_00) {
  var_01 = getEntArray("spawn_volume", "targetname");

  foreach(var_03 in var_01) {
    if(ispointinvolume(var_0.origin + (0, 0, 50), var_03)) {
      if(isDefined(var_3.basename))
        return var_3.basename;
    }
  }

  return undefined;
}

func_12FFA(var_00, var_01, var_02) {
  level notify("magicWheelUsed");
  var_01 makeunusable();
  var_0.func_13103 = 1;
  var_1.func_10A05 = 1;
  var_1.inuse = 1;
  var_00 playlocalsound("zmb_wheel_spin_buy");
  var_03 = scripts\engine\utility::getclosest(var_1.origin, scripts\engine\utility::getstructarray("wheel_fx_spot", "targetname"));
  var_01 setscriptablepartstate("spin_light", "on");
  scripts\engine\utility::waitframe();
  var_04 = var_00 getweaponslistall();
  var_05 = [];

  foreach(var_07 in var_1.func_13C25) {
    var_08 = scripts\cp\utility::getbaseweaponname(var_07);
    var_09 = 0;

    foreach(var_11 in var_04) {
      var_12 = scripts\cp\utility::getbaseweaponname(var_11);

      if(var_12 == var_08) {
        var_09 = 1;
        break;
      }
    }

    if(!var_09) {
      var_14 = var_07;
      var_15 = scripts\cp\utility::getrawbaseweaponname(var_07);

      if(isDefined(var_0.weapon_build_models[var_15]))
        var_14 = var_0.weapon_build_models[var_15];

      var_5[var_5.size] = var_14;
    }
  }

  scripts\cp\zombies\zombie_analytics::func_AF79(level.wave_num);
  var_1.func_13C25 = var_05;
  level thread func_1010C(var_01, var_00);
  level thread func_13D00(var_01);
  var_1.func_10A03 setscriptablepartstate("spinner", "spinning");
  var_1.func_10A03 ghost_nav_mode(var_1.func_E74A, 5, 1, 4);
  var_1.func_10A03 waittill("rotatedone");
  var_1.func_10A05 = 0;
  var_01 waittill("ready");

  if(!level.func_B162)
    var_1.func_10A03 setscriptablepartstate("spinner", "idle");

  var_1.inuse = 0;
  var_01 setscriptablepartstate("spin_light", "off");

  if(!scripts\engine\utility::flag_exist("fire_sale") || !scripts\engine\utility::flag("fire_sale")) {
    if(level.func_B162) {
      if(isDefined(var_00))
        var_00 scripts\cp\cp_persistence::give_player_currency(var_02, undefined, undefined, 1, "magicWheelRefund");

      level.func_B162 = 0;
      wait 0.5;

      if(isDefined(var_1.weapon))
        var_1.weapon delete();

      func_BC3F();
    } else {
      wait 0.5;

      if(var_01 != level.current_active_wheel) {
        level thread func_8E95(var_01);
        return;
      }

      var_01 makeusable();
      var_01 _meth_84A7("tag_use");
      var_01 setusefov(60);
      var_01 setuserange(72);
    }
  } else {
    wait 0.5;
    var_01 makeusable();
    var_01 _meth_84A7("tag_use");
    var_01 setusefov(60);
    var_01 setuserange(72);
  }
}

func_13D00(var_00) {
  while(!isDefined(var_0.weapon))
    wait 0.05;

  while(var_0.func_10A05) {
    var_01 = var_0.weapon.scriptmodelplayanim;
    wait 0.05;
  }
}

func_7B18(var_00) {
  var_01 = 21 / (var_0.func_E74A / 5 * 0.05);

  if(var_01 - int(var_01) > 0)
    var_01 = int(var_01) + 1;
  else
    var_01 = int(var_01);

  var_0.func_E74D = var_01 * 0.05;
  var_02 = randomint(var_0.func_13C25.size);
  return var_0.func_13C25[var_02];
}

can_have_nunchucks(var_00) {
  if(var_0.vo_prefix != "p5_")
    return 0;
  else {
    var_01 = var_00 getrankedplayerdata("cp", "alienSession", "escapedRank0");
    var_02 = var_00 getrankedplayerdata("cp", "alienSession", "escapedRank1");
    var_03 = var_00 getrankedplayerdata("cp", "alienSession", "escapedRank2");
    var_04 = var_00 getrankedplayerdata("cp", "alienSession", "escapedRank3");

    if(isDefined(var_01) && var_01 == 1)
      return 1;
    else if(isDefined(var_02) && var_02 == 1)
      return 1;
    else if(isDefined(var_03) && var_03 == 1)
      return 1;
    else if(isDefined(var_04) && var_04 == 1)
      return 1;
    else
      return 0;
  }
}

get_weapon_with_new_camo(var_00, var_01, var_02) {
  var_03 = getweaponbasename(var_01);
  var_04 = getweaponattachments(var_01);

  if(issubstr(var_03, "nunchucks")) {}

  return var_00 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_03, undefined, var_04, undefined, var_02);
}

func_1010C(var_00, var_01) {
  if(scripts\engine\utility::flag("fire_sale"))
    var_0.fire_sale_spin = 1;

  var_02 = undefined;
  var_0.func_BF6D = func_7B18(var_00);

  if(isDefined(level.nextwheelweaponfunc))
    var_0.func_BF6D = [[level.nextwheelweaponfunc]](var_00, var_0.func_BF6D, var_01);

  if(scripts\engine\utility::is_true(var_1.finished_backstory) && !scripts\engine\utility::is_true(var_1.given_nunchucks)) {
    var_03 = "";

    if(scripts\engine\utility::is_true(level.magic_wheel_upgraded) && !var_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
      var_03 = "iw7_nunchucks_zm_pap1";
      var_0.func_13C25 = scripts\engine\utility::array_add(var_0.func_13C25, "iw7_nunchucks_zm_pap1");
    } else if(!scripts\engine\utility::is_true(level.magic_wheel_upgraded) && var_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade"))
      var_03 = "iw7_nunchucks_zm_pap1";
    else if(scripts\engine\utility::is_true(level.magic_wheel_upgraded) && var_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
      var_0.func_13C25 = scripts\engine\utility::array_add(var_0.func_13C25, "iw7_nunchucks_zm_pap2");
      var_03 = "iw7_nunchucks_zm_pap2";
    }

    if(var_03 != "")
      var_0.func_BF6D = var_03;
    else {
      var_0.func_13C25 = scripts\engine\utility::array_add(var_0.func_13C25, "iw7_nunchucks_zm");
      var_0.func_BF6D = "iw7_nunchucks_zm";
    }

    var_1.given_nunchucks = 1;
  } else if(randomint(100) > 95) {
    if(can_have_nunchucks(var_01)) {
      var_03 = "";

      if(scripts\engine\utility::is_true(level.magic_wheel_upgraded) && !var_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
        var_03 = "iw7_nunchucks_zm_pap1";
        var_0.func_13C25 = scripts\engine\utility::array_add(var_0.func_13C25, "iw7_nunchucks_zm_pap1");
      } else if(!scripts\engine\utility::is_true(level.magic_wheel_upgraded) && var_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade"))
        var_03 = "iw7_nunchucks_zm_pap1";
      else if(scripts\engine\utility::is_true(level.magic_wheel_upgraded) && var_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade")) {
        var_0.func_13C25 = scripts\engine\utility::array_add(var_0.func_13C25, "iw7_nunchucks_zm_pap2");
        var_03 = "iw7_nunchucks_zm_pap2";
      }

      if(var_03 != "")
        var_0.func_BF6D = var_03;
      else {
        var_0.func_13C25 = scripts\engine\utility::array_add(var_0.func_13C25, "iw7_nunchucks_zm");
        var_0.func_BF6D = "iw7_nunchucks_zm";
      }
    }
  }

  var_04 = getweaponindexfromlist(var_0.func_BF6D, var_0.func_13C25);

  if(scripts\engine\utility::array_contains(var_0.func_13C25, "iw7_forgefreeze_zm+forgefreezealtfire"))
    var_0.func_13C25 = scripts\engine\utility::array_remove(var_0.func_13C25, "iw7_forgefreeze_zm+forgefreezealtfire");

  var_01 loadweaponsforplayer([var_0.func_BF6D], 1);

  if(level.currentweaponlist.size > 0)
    var_05 = level.currentweaponlist;
  else
    var_05 = getrotationlist(var_0.func_13C25);

  if(scripts\engine\utility::is_true(level.magic_wheel_upgraded)) {
    foreach(var_08, var_07 in var_05)
    var_5[var_08] = get_weapon_with_new_camo(var_01, var_07, get_camo_for_upgraded_weapon(getweaponbasename(var_07), var_01));
  }

  level.activewheels++;
  level.currentweaponlist = var_05;
  _loadworldweapons(var_05);
  var_09 = -1;
  var_10 = 0;
  var_11 = scripts\engine\utility::getclosest(var_0.origin, scripts\engine\utility::getstructarray("wheel_fx_spot", "targetname"));

  for(var_0.weapon = undefined; var_0.func_10A05; var_10++) {
    wait(var_0.func_E74D);
    var_00 playSound("zmb_wheel_spin_tick");
    var_9++;

    if(isDefined(var_0.weapon))
      var_0.weapon setmoverweapon(var_5[var_09]);
    else {
      var_0.weapon = spawn("script_weapon", var_11.origin, 0, 0, var_5[var_09]);

      if(isDefined(var_11.angles))
        var_0.weapon.angles = var_11.angles;
      else
        var_0.weapon.angles = (0, 0, 0);
    }

    var_0.weapon.scriptmodelplayanim = var_5[var_09];

    if(var_09 >= var_5.size - 1)
      var_09 = -1;
  }

  var_0.weapon.scriptmodelplayanim = var_0.func_13C25[var_04];

  if(scripts\engine\utility::is_true(level.magic_wheel_upgraded))
    var_0.weapon setmoverweapon(get_weapon_with_new_camo(var_01, var_0.weapon.scriptmodelplayanim, get_camo_for_upgraded_weapon(getweaponbasename(var_0.weapon.scriptmodelplayanim), var_01)));
  else
    var_0.weapon setmoverweapon(var_0.weapon.scriptmodelplayanim);

  level.activewheels--;

  if(level.activewheels < 0)
    level.activewheels = 0;

  if(!level.activewheels) {
    _clearworldweapons();
    level.currentweaponlist = [];
  }

  var_14 = scripts\cp\zombies\interaction_weapon_upgrade::getoffsetfrombaseweaponname(var_0.func_13C25[var_04]);
  var_0.weapon.origin = var_11.origin + var_14;
  playLoopSound(var_0.origin, "zmb_wheel_spin_end");

  if(!isDefined(var_0.fire_sale_spin) && (!scripts\engine\utility::flag_exist("fire_sale") || !scripts\engine\utility::flag("fire_sale"))) {
    level.func_13D01++;
    var_15 = randomint(100);

    if(level.func_13D01 == 7)
      var_15 = 100;

    if(var_15 > 50 && level.func_13D01 > 4) {
      level.func_B162 = 1;
      var_16 = var_0.weapon.origin;

      if(isDefined(var_0.weapon))
        var_0.weapon delete();

      var_17 = spawn("script_model", var_16);
      var_17 setModel("zmb_arcade_toy_astronaut_blue");
      var_17.angles = var_0.angles;
      var_17 thread move_up_and_delete();
      var_0.func_10A03 setscriptablepartstate("spinner", "timetomove");
      level thread func_B16B(var_01);
      wait 3;
      var_0.func_10A03 setscriptablepartstate("spinner", "deactivate");
      var_00 setscriptablepartstate("base", "off");
      wait 2;
      level.func_13D01 = 0;
      var_00 setscriptablepartstate("fx", "hideshow");
      var_00 setscriptablepartstate("spin_light", "off");
      var_1.func_13103 = undefined;
      var_00 notify("ready");
      return;
    }
  }

  var_0.fire_sale_spin = undefined;
  var_0.weapon makeusable();

  foreach(var_19 in level.players) {
    if(var_19 == var_01) {
      var_0.weapon enableplayeruse(var_19);
      continue;
    }

    var_0.weapon disableplayeruse(var_19);
  }

  var_0.weapon thread wait_for_player_to_take_weapon(var_00);
  var_0.weapon scripts\engine\utility::waittill_any_timeout(12, "weapon_taken");
  var_0.weapon delete();
  var_0.func_13C25 = scripts\engine\utility::array_remove(var_0.func_13C25, "iw7_nunchucks_zm");
  var_0.func_13C25 = scripts\engine\utility::array_remove(var_0.func_13C25, "iw7_nunchucks_zm_pap2");
  var_00 setscriptablepartstate("spin_light", "off");
  var_0.func_13C25 = func_7ABF();
  var_0.func_E74A = func_7C20();
  var_1.func_13103 = undefined;
  var_00 notify("ready");
}

getrotationlist(var_00) {
  var_01 = [];

  for(var_02 = 0; var_02 < 8; var_2++)
    var_1[var_02] = var_0[var_02];

  return var_01;
}

getweaponindexfromlist(var_00, var_01) {
  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(var_00 == var_1[var_02])
      return var_02;
  }

  return 0;
}

func_B16B(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  level thread scripts\cp\cp_vo::try_to_play_vo("ww_magicbox_laughter", "zmb_announcer_vo", "highest", 5, 0, 0, 1);
  wait 4;
  var_00 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_badspin", "zmb_comment_vo", "low", 30, 0, 0, 1);
}

func_7C20() {
  var_00 = 1440;

  if(randomint(100) > 50)
    var_00 = 1080;

  return var_00;
}

move_up_and_delete() {
  self movez(50, 3, 2, 1);
  self ghost_portal_vfx(-10, 1);
  wait 1;
  self ghost_portal_vfx(10, 1);
  wait 1;
  self ghost_portal_vfx(-10, 0.5);
  wait 0.5;
  self ghost_portal_vfx(10, 0.5);
  wait 0.5;
  playFX(level._effect["vfx_magicwheel_toy_pop"], self.origin);
  self delete();
}

func_45FC(var_00) {}

func_7A37(var_00, var_01) {
  var_02 = getarraykeys(var_00);

  for(var_03 = 0; var_03 < var_2.size; var_3++) {
    if(var_2[var_03] == var_01)
      return var_03;
  }
}

func_782E(var_00, var_01) {
  var_02 = getarraykeys(var_00);
  return var_0[var_2[var_01]];
}

func_7D60(var_00) {
  if(isDefined(level.coop_weapontable))
    var_01 = level.coop_weapontable;
  else
    var_01 = "cp\cp_weapontable.csv";

  return tablelookup(var_01, 2, var_00, 1);
}

wait_for_player_to_take_weapon(var_00) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_01);

    while(var_01 ismeleeing() || var_01 meleebuttonpressed())
      wait 0.05;

    if(isDefined(level.magicwheel_weapon_take_check)) {
      if([
          [level.magicwheel_weapon_take_check]
        ](var_00, var_01, self)) {
        break;
      } else
        continue;
    }

    break;
  }

  if(isDefined(self.scriptmodelplayanim) && getsubstr(self.scriptmodelplayanim, 0, 5) == "power") {
    if(level.powers[self.scriptmodelplayanim].defaultslot == "secondary")
      var_01 scripts\cp\powers\coop_powers::givepower(self.scriptmodelplayanim, level.powers[self.scriptmodelplayanim].defaultslot, undefined, undefined, undefined, 0, 0);
    else
      var_01 scripts\cp\powers\coop_powers::givepower(self.scriptmodelplayanim, level.powers[self.scriptmodelplayanim].defaultslot, undefined, undefined, undefined, 0, 1);
  } else {
    var_02 = self.scriptmodelplayanim;
    func_B16A(var_01, var_02);
    var_03 = scripts\cp\utility::getrawbaseweaponname(var_02);

    switch (var_03) {
      case "mauler":
      case "sdflmg":
      case "lmg03":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 25);
        break;
      case "katana":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_katana", "zmb_comment_vo", "low", 10, 0, 1, 0);
        break;
      case "nunchucks":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_nunchucks", "zmb_comment_vo", "low", 10, 0, 1, 0);
        break;
      case "forgefreeze":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("magicwheel_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0);
        break;
      case "glprox":
      case "chargeshot":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_launcher", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
        break;
      case "cheytac":
      case "kbs":
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("player_purchase_sniper", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
        break;
      default:
        var_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_weapon", "zmb_comment_vo", "low", 10, 0, 1, 0, 25);
    }
  }

  self notify("weapon_taken");
  var_00 notify("weapon_taken");
  var_0.func_BF6D = undefined;
  playLoopSound(self.origin, "zmb_wheel_wpn_acquired");
}

func_B16A(var_00, var_01) {
  var_00 notify("weapon_purchased");

  if(scripts\engine\utility::is_true(var_0.isusingsupercard))
    wait 0.5;

  var_02 = undefined;

  if(scripts\cp\zombies\zombies_weapons::should_take_players_current_weapon(var_00)) {
    var_03 = var_00 scripts\cp\utility::getvalidtakeweapon();
    var_04 = scripts\cp\utility::getrawbaseweaponname(var_03);
    var_00 giveuponsuppressiontime(var_03);

    if(isDefined(var_0.pap[var_04])) {
      var_0.pap[var_04] = undefined;
      var_00 notify("weapon_level_changed");
    }
  }

  var_05 = scripts\cp\utility::getrawbaseweaponname(var_01);
  var_00 scripts\cp\utility::take_fists_weapon(var_00);

  if(isDefined(var_0.weapon_build_models[var_05]))
    var_01 = var_0.weapon_build_models[var_05];

  if(var_00 scripts\cp\cp_weapon::can_upgrade(var_01) && is_magic_wheel_upgrades(var_00)) {
    var_02 = get_camo_for_upgraded_weapon(var_05, var_00);
    var_06 = scripts\engine\utility::array_combine(getweaponattachments(var_01), [get_attachment_for_upgraded_weapon(var_01, var_00)]);
    var_01 = var_00 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_01, undefined, var_06, undefined, var_02);
    var_01 = var_00 scripts\cp\utility::_giveweapon(var_01, undefined, undefined, 1);
    var_07 = scripts\cp\utility::getrawbaseweaponname(var_01);
    var_08 = spawnStruct();
    var_8.lvl = 2;
    var_0.pap[var_07] = var_08;
    var_00 notify("weapon_level_changed");
    var_00 scripts\cp\cp_merits::processmerit("mt_purchased_weapon");

    if(var_00 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade"))
      var_00 scripts\cp\utility::notify_used_consumable("magic_wheel_upgrade");
  } else {
    var_06 = getweaponattachments(var_01);
    var_01 = var_00 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_01, undefined, var_06, undefined, undefined);
    var_01 = var_00 scripts\cp\utility::_giveweapon(var_01, undefined, undefined, 0);
    var_08 = spawnStruct();
    var_8.lvl = 1;
    var_0.pap[var_05] = var_08;
    var_00 scripts\cp\cp_merits::processmerit("mt_purchased_weapon");
    var_00 notify("weapon_level_changed");
  }

  if(issubstr(var_01, "g18_"))
    var_0.has_replaced_starting_pistol = 1;

  if(issubstr(var_01, "udm45_"))
    var_00 scripts\cp\cp_merits::processmerit("mt_udm_unlock");

  if(issubstr(var_01, "rvn_"))
    var_00 scripts\cp\cp_merits::processmerit("mt_rvn_unlock");

  if(issubstr(var_01, "crdb_"))
    var_00 scripts\cp\cp_merits::processmerit("mt_crdb_unlock");

  if(issubstr(var_01, "vr_"))
    var_00 scripts\cp\cp_merits::processmerit("mt_vr_unlock");

  if(issubstr(var_01, "mp28_"))
    var_00 scripts\cp\cp_merits::processmerit("mt_mp28_unlock");

  if(issubstr(var_01, "minilmg_"))
    var_00 scripts\cp\cp_merits::processmerit("mt_minilmg_unlock");

  if(issubstr(var_01, "ba50cal_"))
    var_00 scripts\cp\cp_merits::processmerit("mt_ba50cal_unlock");

  if(issubstr(var_01, "mod2187_"))
    var_00 scripts\cp\cp_merits::processmerit("mt_mod2187_unlock");

  if(issubstr(var_01, "longshot_"))
    var_00 scripts\cp\cp_merits::processmerit("mt_longshot_unlock");

  var_00 notify("wor_item_pickup", var_01);
  var_00 givemaxammo(var_01);
  var_00 switchtoweapon(var_01);
}

get_camo_for_upgraded_weapon(var_00, var_01) {
  var_02 = undefined;

  if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_00))
    var_02 = undefined;
  else if(scripts\engine\utility::is_true(level.magic_wheel_upgraded) && var_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade") && isDefined(level.pap_2_camo))
    var_02 = level.pap_2_camo;
  else if(isDefined(level.pap_1_camo))
    var_02 = level.pap_1_camo;

  switch (var_00) {
    case "dischord":
      var_02 = "camo20";
      break;
    case "facemelter":
      var_02 = "camo22";
      break;
    case "headcutter":
      var_02 = "camo21";
      break;
    case "shredder":
      var_02 = "camo23";
      break;
    case "nunchucks":
      var_02 = "camo222";
      break;
  }

  return var_02;
}

get_attachment_for_upgraded_weapon(var_00, var_01) {
  if(issubstr(var_00, "nunchucks"))
    return undefined;

  if(scripts\engine\utility::is_true(level.magic_wheel_upgraded) && var_01 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade"))
    return "pap2";

  return "pap1";
}

is_magic_wheel_upgrades(var_00) {
  if(var_00 scripts\cp\utility::is_consumable_active("magic_wheel_upgrade"))
    return 1;

  if(scripts\engine\utility::is_true(level.magic_wheel_upgraded))
    return 1;

  return 0;
}

func_10C4D(var_00, var_01, var_02) {
  level notify("activated" + var_00);
  level endon("activated" + var_00);
  level endon("deactivated" + var_00);
  level endon("game_ended");
  var_03 = undefined;
  level.active_power_ups["fire_sale"] = 1;
  scripts\engine\utility::flag_set("fire_sale");

  foreach(var_05 in level.func_B163) {
    if(var_5.area_name == level.func_A8E2) {
      var_05 sethintstring(&"COOP_INTERACTIONS_SPIN_WHEEL_FIRE_SALE");
      var_03 = var_05;
      continue;
    }

    thread func_100ED(var_05);
  }

  level thread func_4DB4(var_00, var_01, var_03);

  foreach(var_08 in level.players) {
    if(isDefined(var_8.temporal_increase)) {
      var_08 thread scripts\cp\loot::power_icon_active(30 * var_8.temporal_increase, "fire_30");
      continue;
    }

    var_08 thread scripts\cp\loot::power_icon_active(30, "fire_30");
  }
}

func_4DB4(var_00, var_01, var_02) {
  level endon("game_ended");
  var_03 = scripts\engine\utility::waittill_any_timeout(var_01, "deactivated" + var_00, "activated" + var_00);

  if(var_03 != "activated" + var_00) {
    level.active_power_ups["fire_sale"] = 0;
    scripts\engine\utility::flag_clear("fire_sale");

    foreach(var_05 in level.func_B163) {
      if(!isDefined(var_02))
        func_BC3F();
      else if(var_05 == var_02) {
        if(isDefined(level.magic_wheel_spin_hint))
          var_05 sethintstring(level.magic_wheel_spin_hint);
        else
          var_05 sethintstring(&"CP_ZMB_INTERACTIONS_SPIN_WHEEL");

        continue;
      }

      var_05 makeunusable();
      thread func_8E95(var_05);
    }

    foreach(var_08 in level.players)
    var_8.func_8B7B = undefined;

    level notify("deactivated" + var_00);
    var_10 = 1;

    while(var_10) {
      var_11 = 0;

      foreach(var_08 in level.players) {
        if(scripts\engine\utility::is_true(var_8.func_13103)) {
          wait 0.25;
          var_11 = 1;
          continue;
        }
      }

      if(!var_11)
        var_10 = 0;
    }

    wait 0.25;
  }
}

func_50DA(var_00) {
  level endon("game_ended");
  var_00 scripts\engine\utility::waittill_any("ready", "weapon_taken");
  func_8E95(var_00);
}