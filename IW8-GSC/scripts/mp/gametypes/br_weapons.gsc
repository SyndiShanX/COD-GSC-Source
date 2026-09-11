/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_weapons.gsc
***********************************************/

function createspawnweaponatpos(var_0, var_1, var_2) {
  var_3 = scripts\engine\trace::ray_trace(var_0, (var_0[0], var_0[1], var_0[2] - 60));
  var_4 = var_0;

  if(var_3["fraction"] < 1) {
    var_4 = var_3["position"] + (0, 0, 2);
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 90);
  }

  var_0 = var_4;

  if(isDefined(var_1)) {
    var_1 = var_1;
  } else {
    var_1 = (0, 0, 90);
  }

  var_5 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var_0, var_1);
  return weaponspawn(var_2, undefined, var_5, 1);
}

function createspawnweaponatposfromname(var_0, var_1) {
  var_2 = var_0;
  var_3 = scripts\engine\trace::ray_trace(var_0, (var_0[0], var_0[1], var_0[2] - 60));

  if(var_3["fraction"] < 1) {
    var_2 = var_3["position"] + (0, 0, 2);
  }

  var_4 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var_0, (0, 0, 90));
  return weaponspawn(var_1, undefined, var_4, 1);
}

function stripweaponsfromplayer() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in self.equippedweapons) {
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_3.basename);

    if(var_4 != "iw8_fists" && var_4 != "iw8_knifestab" && var_4 != "iw8_gunless") {
      if(issameweapon(var_3) && var_3.inventorytype == "primary") {
        var_5 = scripts\mp\utility\weapon::getweaponrootname(self.currentprimaryweapon);

        if(var_4 == var_5) {
          var_0 = var_3;
        } else {
          var_1 = var_3;
        }
      }
    }
  }

  if(isDefined(var_0)) {
    var_7 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);
  }

  if(isDefined(var_1)) {
    var_8 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);
  }

  if(isDefined(var_0) || isDefined(var_1)) {
    if(isDefined(var_0)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0, 1);
    }

    if(isDefined(var_1)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1, 1);
    }

    scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_fists_mp");
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw8_fists_mp");
    return;
  }
}

function playerdropweaponfrominventory(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in self.equippedweapons) {
    var_5 = scripts\mp\utility\weapon::getweaponrootname(var_4.basename);

    if(var_5 != "iw8_fists" && var_5 != "iw8_knifestab") {
      if(issameweapon(var_4) && var_4.inventorytype == "primary") {
        var_6 = scripts\mp\utility\weapon::getweaponrootname(self.currentprimaryweapon);

        if(var_5 == var_6) {
          iprintln("PRIMARY IS " + var_5);
          var_1 = var_4;
        } else {
          var_2 = var_4;
        }
      }
    }
  }

  var_8 = undefined;
  var_9 = undefined;
  var_10 = "";
  var_11 = "";

  if(isDefined(var_1)) {
    var_10 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);
  }

  if(isDefined(var_2)) {
    var_11 = scripts\mp\utility\weapon::getweaponrootname(var_2.basename);
  }

  if(var_0 == var_10) {
    var_8 = var_1;
    var_9 = var_2;
  } else if(var_0 == var_11) {
    var_8 = var_2;
    var_9 = var_1;
  }

  var_12 = 0;

  if(isDefined(var_8)) {
    var_13 = self getweaponammoclip(var_8);
    var_14 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var_15 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_14, self.origin, self.angles, self);
    var_16 = weaponspawn(var_8, self, var_15, 0);
    var_16.count = var_13;
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_8);

    if(isDefined(var_9)) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_9);
    } else {
      scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_fists_mp");
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw8_fists_mp");
    }

    br_ammo_update_weapons(self);
    return;
  }
}

function weaponspawn(var_0, var_1, var_2, var_3, var_4) {
  var_5 = createheadicon(var_0);
  var_6 = scripts\mp\gametypes\br_pickups::spawnpickup(var_5, var_2, 0, var_4, var_0);
  level.ref_120ad _calloutmarkerping_handleluinotify_acknowledgedcancel::from(var_6, var_1, var_0);
  return var_6;
}

function takeweaponpickup(var_0) {
  var_1 = self.primaryweapons.size;

  if(!isDefined(var_0.weapon)) {
    var_2 = [];
    var_3 = undefined;

    if(isDefined(var_0.customweaponname)) {
      var_4 = var_0.customweaponname;
      var_3 = asmdevgetallstates(var_4);
      var_3.customweaponname = var_0.customweaponname;
    } else if(!isDefined(var_1.completeweapon)) {
      var_5 = scripts\mp\gametypes\br_pickups::relic_vampire_globalfunc(var_1);
      var_4 = createheadicon(var_5);
    } else {
      var_6 = scripts\mp\class::buildweapon(var_3.loadoutprimaryfullname, var_4, "none", "none", -1);
      var_4 = var_3.loadoutprimaryfullname;
    }

    if(!isDefined(var_4)) {
      scripts\mp\utility\script::laststand_dogtags("takeWeaponPickup error - scriptable not setup for pickup: " + var_3.scriptablename);
      return;
    }

    var_2 = scripts\mp\utility\weapon::getweaponrootname(var_4);
    var_4 = var_4;
  } else {
    var_3 = var_2.weapon;
    jumpiffalse(isDefined(var_2.loadoutprimaryfullname)) LOC_000000e1;
    var_6 = var_2.loadoutprimaryfullname;
    goto LOC_000000f9;
  }

  var_7 = 0;
  var_8 = undefined;
  var_9 = 0;

  foreach(var_11 in self.primaryweapons) {
    if(nullweapon(var_11)) {
      var_5--;
      continue;
    }

    if(isnullweapon(var_11, var_6)) {
      var_9 = 1;
      var_7 = 1;
      var_8 = var_11;
    }
  }

  if(var_5 > 1) {
    if(!self hasweapon("iw8_fists_mp")) {
      var_7 = 1;
    } else if(!var_9) {
      self takeweapon("iw8_fists_mp");
    }
  }

  if(var_7) {
    if(!isDefined(var_8)) {
      var_8 = router_use_obj();
    }

    if(var_8.basename != "none") {
      var_13 = self getweaponammoclip(var_8);
      var_14 = self getweaponammoclip(var_8, "left");
      var_15 = 0;

      if(var_8.hasalternate) {
        var_16 = var_8 getaltweapon();

        if(!debug_spawn_crate_on_train(var_8, var_16)) {
          var_15 = self getweaponammoclip(var_16);
        }
      }

      if(!scripts\mp\riotshield::isriotshield(var_8)) {
        var_17 = self getweaponammostock(var_8);
        var_18 = br_ammo_type_for_weapon(var_8);

        if(isDefined(var_18)) {
          self.br_ammo[var_18] = var_17;
        }
      }

      var_19 = var_3.origin - self.origin;
      var_20 = vectortoyaw(var_19);
      var_21 = !scripts\mp\gametypes\br_extract_quest::operatorsfxalias(var_8);

      if(var_21) {
        if(isDefined(var_3.tracknonoobplayerlocation) && isDefined(var_3.tracknonoobplayerlocation.ƒj× ëuW ésò / ) k² oø E\¯‘€ 2[)) {
          var_22 = var_3.tracknonoobplayerlocation.ƒj× ëuW ésò / ) k² oø E\¯‘€ 2[; var_23 = strtok(var_8.basename, "_");

          if(scripts\mp\class::update_health_bar_to_players(var_8) || var_23[1] == "me") {
            var_22 += (0, 90, 0);
          }
        }
        else {
          var_22 = (0, var_21, 0);
        }

        var_24 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var_5.origin, var_22);
        var_25 = tablesort(var_24.origin, 500, 500);
        GscBinSkip0(0x2e, var_25.size, self);
      }

      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_12);
    }
  }

  self giveweapon(var_8);
  self notify("pickedupweapon", var_10, var_8);

  if(istrue(var_8.isweaponfromcrate) || istrue(var_6.isweaponfromcrate)) {
    var_33 = br_ammo_type_for_weapon(var_9);

    if(isDefined(var_33)) {
      var_34 = weaponclipsize(var_8);
      br_ammo_give_type(self, var_33, var_34);
    }
  } else {
    var_35 = var_6.count;
    var_36 = var_6.impulsefx;
    var_34 = weaponclipsize(var_8);
    var_37 = 0;

    if(var_35 > var_34) {
      var_37 += var_35 - var_34;
      var_35 = var_34;
    }

    if(var_36 > var_34) {
      var_37 += var_36 - var_34;
      var_36 = var_34;
    }

    self setweaponammoclip(var_8, var_35);
    self setweaponammoclip(var_8, var_36, "left");

    if(var_37 > 0) {
      var_33 = br_ammo_type_for_weapon(var_8);

      if(isDefined(var_33)) {
        br_ammo_give_type(self, var_33, var_37);
      }
    }

    if(var_8.hasalternate) {
      var_38 = var_6.impactfunc_fire;
      var_39 = var_8 getaltweapon();

      if(!debug_spawn_crate_on_train(var_8, var_39)) {
        var_40 = weaponclipsize(var_39);

        if(var_38 > var_40) {
          var_38 = var_40;
        }

        self setweaponammoclip(var_39, var_38);
      }
    }
  }

  var_8.ref_12cc1 = undefined;
  br_ammo_update_weapons(self);
  self assignweaponprimaryslot(var_8);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_8);
  scripts\mp\weapons::fixupplayerweapons(self, var_8);
  scripts\mp\weapons::updatelastweaponobj(var_8);

  if(isDefined(var_6.weapon) && isent(var_6.weapon)) {
    var_6.weapon delete();
  }

  var_41 = undefined;

  foreach(var_43 in self.equippedweapons) {
    if(issameweapon(var_43) && var_43.inventorytype == "primary") {
      var_4 = createheadicon(var_43);

      if(var_4 == var_10) {
        var_41 = var_43;
        break;
      }
    }
  }

  var_41 = undefined;
  var_43 = undefined;
  thread scripts\mp\gametypes\br_respawn::giveweaponpickup(var_9);

  if(isDefined(var_5.tracknonoobplayerlocation)) {
    level.ref_120ae _calloutmarkerping_handleluinotify_acknowledgedcancel::from(var_5.tracknonoobplayerlocation, self, var_7);
    return;
  }
}

function router_use_obj() {
  var_0 = self method_87d5();

  if(isDefined(var_0) && scripts\mp\weapons::isdroppableweapon(var_0)) {
    foreach(var_2 in self.primaryweapons) {
      if(isnullweapon(var_2, var_0)) {
        return var_0;
      }
    }
  }

  return self.lastdroppableweaponobj;
}

function takeammopickup(var_0) {
  var_1 = 0;

  if(var_0.scriptablename == "Ammo_Crate") {
    var_2 = self getcurrentweapon().basename;
    var_3 = scripts\mp\utility\weapon::getweaponrootname(var_2);
    var_4 = weaponclipsize(var_2);
    var_5 = br_ammo_type_for_weapon(var_2);

    if(isDefined(var_5)) {
      var_1 = br_ammo_give_type(self, var_5, var_4);
    }
  } else {
    var_1 = br_ammo_give_type(self, var_0.scriptablename, var_0.count, 1);
  }

  if(var_1) {
    var_0.count = var_1;
    var_6 = 1;
  } else {
    var_6 = 0;
  }

  return var_6;
}

function br_forcegiveweapon(var_0, var_1, var_2) {
  if(!scripts\engine\utility::array_contains(level.br_pickups.br_lootguns, var_0)) {
    var_0 = degrees_to_radians();
  }

  var_3 = spawnStruct();
  var_3.loadoutprimaryfullname = var_0;
  var_3.scriptablename = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_3.completeweapon = var_2;
  var_3.count = 0;
  var_3.impulsefx = 0;
  var_3.impactfunc_fire = 0;
  takeweaponpickup(var_1, var_3);
}

function degrees_to_radians(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "ar";
  }

  if(!isDefined(var_1)) {
    var_1 = "comm";
  }

  var_2 = [];

  foreach(var_4 in level.br_pickups.br_lootguns) {
    if(issubstr(var_4, "_" + var_0 + "_")) {
      if(issubstr(var_4, "_" + var_1)) {
        var_2 = var_4;
      }
    }
  }

  return var_2[randomint(var_2.size)];
}

function br_getweaponstartingclipammo(var_0) {
  var_1 = weaponclipsize(var_0);
  return int(var_1);
}

function br_forcegivecustomweapon(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_0 hasweapon(var_1)) {
    var_0 scripts\mp\hud_message::showerrormessage("MP/BR_ALREADY_HOLDING_WEAPON");
    return false;
  }

  var_6 = var_1 hasattachment("maxammo", 1);
  var_7 = spawnStruct();
  var_7.weapon = var_1;
  var_7.loadoutprimaryfullname = var_2;
  var_7.scriptablename = var_3;
  var_7.origin = var_0.origin + (0, 0, 24);
  var_7.count = br_getweaponstartingclipammo(var_1);
  var_7.impulsefx = 0;
  var_7.impactfunc_fire = 0;

  if(var_6) {
    var_7.count = 999;
  }

  if(isDefined(var_4) && isDefined(var_5)) {
    var_8 = weaponclipsize(var_1);
    var_9 = int(ceil(var_8 * var_4));
    var_7.count = int(min(var_9, var_5));
  }

  if(scripts\mp\utility\weapon::turnexfiltoside(var_1)) {
    var_7.impulsefx = var_7.count;
  }

  if(var_1.hasalternate) {
    var_10 = var_1 getaltweapon();

    if(!debug_spawn_crate_on_train(var_1, var_10)) {
      var_11 = weaponclipsize(var_10);
      var_7.impactfunc_fire = var_11;

      if(var_6) {
        var_7.impactfunc_fire = 999;
      }
    }
  }

  if(getdvarint("scr_br_request_streaming_weapons", 0) > 0) {
    var_0 loadweaponsforplayer([var_7.loadoutprimaryfullname]);
  }

  takeweaponpickup(var_0, var_7);

  if(var_1.hasalternate) {
    var_12 = var_1 getaltweapon();

    if(var_12.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_12.underbarrel) == "ubshtgn") {
      var_13 = weaponclipsize(var_12);
      var_14 = int(var_13);
      var_0 setweaponammoclip(var_12, var_14);
    }
  }

  return true;
}

function br_ammo_init() {
  level.br_ammo_types = [];
  level.br_ammo_types[0] = "brloot_ammo_919";
  level.br_ammo_types[1] = "brloot_ammo_12g";
  level.br_ammo_types[2] = "brloot_ammo_762";
  level.br_ammo_types[3] = "brloot_ammo_50cal";
  level.br_ammo_types[4] = "brloot_ammo_rocket";
  level.br_ammo_clipsize["brloot_ammo_919"] = 30;
  level.br_ammo_clipsize["brloot_ammo_12g"] = 8;
  level.br_ammo_clipsize["brloot_ammo_762"] = 30;
  level.br_ammo_clipsize["brloot_ammo_50cal"] = 8;
  level.br_ammo_clipsize["brloot_ammo_rocket"] = 1;
  level.br_ammo_max = [];
  level.br_ammo_omnvars = [];
  level.br_ammo_omnvars["brloot_ammo_919"] = "ui_br_smallarms_ammo";
  level.br_ammo_omnvars["brloot_ammo_12g"] = "ui_br_shotgun_ammo";
  level.br_ammo_omnvars["brloot_ammo_762"] = "ui_br_assault_ammo";
  level.br_ammo_omnvars["brloot_ammo_50cal"] = "ui_br_sniper_ammo";
  level.br_ammo_omnvars["brloot_ammo_rocket"] = "ui_br_rocket_ammo";
}

function br_ammo_player_init() {
  self endon("disconnect");
  thread br_ammo_player_reload_watch();
  thread br_ammo_player_hud_monitor();

  for(;;) {
    self waittill("br_spawned");

    if(!scripts\mp\flags::gameflag("prematch_done")) {
      var_0 = self getweaponslistprimaries();

      foreach(var_2 in var_0) {
        var_3 = weaponclipsize(var_2);

        if(isDefined(var_3)) {
          if(scripts\mp\utility\weapon::turnexfiltoside(var_2)) {
            self setweaponammoclip(var_2, var_3, "left");
            self setweaponammoclip(var_2, var_3, "right");
            continue;
          }

          self setweaponammoclip(var_2, var_3);
        }
      }
    }

    foreach(var_6 in level.br_ammo_types) {
      if(!scripts\mp\flags::gameflag("prematch_done")) {
        self.br_ammo[var_6] = level.br_ammo_max[var_6];
        continue;
      }

      self.br_ammo[var_6] = 0;
    }

    br_ammo_update_weapons(self);
    br_ammo_player_hud_update_ammotype("brloot_ammo_919");
    br_ammo_player_hud_update_ammotype("brloot_ammo_12g");
    br_ammo_player_hud_update_ammotype("brloot_ammo_762");
    br_ammo_player_hud_update_ammotype("brloot_ammo_50cal");
    br_ammo_player_hud_update_ammotype("brloot_ammo_rocket");
  }
}

function delay_add_to_chopper_boss_drone_target_array() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("weapons")) {
    return;
  }

  br_ammo_give_type(self, "brloot_ammo_919", 30, 0);
}

function br_ammo_player_clear() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("weapons")) {
    return;
  }

  foreach(var_1 in level.br_ammo_types) {
    self.br_ammo[var_1] = 0;
  }

  self notify("ammo_update");
}

function debug_spawnallaccesscards() {
  var_0 = self;
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = br_ammo_type_for_weapon(var_3);

    if(isDefined(var_4)) {
      var_5 = var_0 getweaponammoclip(var_3, "right");
      var_6 = weaponclipsize(var_3);

      if(var_5 < var_6) {
        return false;
      }

      if(var_3 hasattachment("akimbo", 1)) {
        var_7 = var_0 getweaponammoclip(var_3, "left");

        if(var_7 < var_6) {
          return false;
        }
      }

      if(!br_ammo_type_player_full(var_0, var_4)) {
        return false;
      }
    }
  }

  return true;
}

function debug_spawncover_badnodetest() {
  var_0 = self;
  var_1 = [];
  var_2 = var_0 getweaponslistprimaries();

  foreach(var_4 in var_2) {
    var_5 = br_ammo_type_for_weapon(var_4);

    if(isDefined(var_5)) {
      var_1 = "dummy_value";
      var_6 = weaponclipsize(var_4);
      var_0 setweaponammoclip(var_4, var_6);
    }
  }

  foreach(var_5, var_9 in var_1) {
    var_0.br_ammo[var_5] = level.br_ammo_max[var_5];
    br_ammo_player_hud_update_ammotype(var_0, var_5);
  }

  br_ammo_update_weapons(var_0);
}

function br_ammo_type_player_full(var_0, var_1) {
  if(!isDefined(var_0.br_ammo) || !isDefined(var_0.br_ammo[var_1])) {
    return false;
  }

  if(!isDefined(level.br_ammo_max[var_1])) {
    return false;
  }

  return scripts\mp\gametypes\br::get_int_or_0(var_0.br_ammo[var_1]) >= level.br_ammo_max[var_1];
}

function br_ammo_give_type(var_0, var_1, var_2, var_3) {
  debug_spawnrewardstest(var_0, var_1);

  if(br_ammo_type_player_full(var_0, var_1)) {
    return var_2;
  }

  if(!isDefined(var_0.br_ammo)) {
    var_0.br_ammo = [];
  }

  if(!isDefined(var_0.br_ammo[var_1])) {
    var_0.br_ammo[var_1] = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = 0;
  var_0.br_ammo[var_1] += var_2;

  if(var_0.br_ammo[var_1] > level.br_ammo_max[var_1]) {
    if(var_3) {
      var_4 = var_0.br_ammo[var_1] - level.br_ammo_max[var_1];

      if(var_4 < level.br_ammo_clipsize[var_1]) {
        var_4 = 0;
      }
    }

    var_0.br_ammo[var_1] = level.br_ammo_max[var_1];
  }

  br_ammo_player_hud_update_ammotype(var_0, var_1);
  debug_start_numbers_threaded(var_0, var_1);
  return var_4;
}

function debug_spawnrewardstest(var_0, var_1) {
  if(!var_0 isreloading()) {
    return;
  }

  var_2 = var_0 getcurrentprimaryweapon();
  var_3 = br_ammo_type_for_weapon(var_2);

  if(isDefined(var_3) && var_1 == var_3) {
    var_0.br_ammo[var_1] = var_0 getweaponammostock(var_2);
    return;
  }
}

function br_ammo_take_type(var_0, var_1, var_2) {
  if(var_0.br_ammo[var_1] <= 0) {
    return false;
  }

  var_0.br_ammo[var_1] -= var_2;

  if(var_0.br_ammo[var_1] < 0) {
    var_0.br_ammo[var_1] = 0;
  }

  br_ammo_player_hud_update_ammotype(var_0, var_1);
  br_ammo_update_weapons(var_0);
  return true;
}

function br_ammo_player_hud_monitor() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::ref_143a8("ammo_update", "pickedupweapon", "weapon_switch_done", "weapon_change", "weapon_change_complete");
    br_ammo_player_hud_update_ammotype("brloot_ammo_919");
    br_ammo_player_hud_update_ammotype("brloot_ammo_12g");
    br_ammo_player_hud_update_ammotype("brloot_ammo_762");
    br_ammo_player_hud_update_ammotype("brloot_ammo_50cal");
    br_ammo_player_hud_update_ammotype("brloot_ammo_rocket");
  }
}

function br_ammo_player_hud_update_ammotype(var_0, var_1) {
  if(isDefined(level.br_ammo_omnvars[var_0])) {
    if(!isDefined(self.br_ammo)) {
      self.br_ammo = [];
    }

    if(!isDefined(self.br_ammo[var_0])) {
      self.br_ammo[var_0] = 0;
    }

    self setclientomnvar(level.br_ammo_omnvars[var_0], self.br_ammo[var_0]);
    return;
  }
}

function br_ammo_update_weapons(var_0) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("weapons")) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = br_ammo_type_for_weapon(var_3);

    if(isDefined(var_4)) {
      var_5 = scripts\mp\gametypes\br::get_int_or_0(var_0.br_ammo[var_4]);
      var_0 setweaponammostock(var_3, var_5);
    }
  }

  var_0 notify("ammo_update");
}

function debug_start_numbers_threaded(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }

  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    var_5 = br_ammo_type_for_weapon(var_4);

    if(isDefined(var_5) && var_1 == var_5) {
      var_6 = scripts\mp\gametypes\br::get_int_or_0(var_0.br_ammo[var_1]);
      var_0 setweaponammostock(var_4, var_6);
    }
  }

  var_0 notify("ammo_update");
}

function br_ammo_type_for_weapon(var_0) {
  var_1 = undefined;
  var_2 = ["selectsemi", "selectsemi_falpha", "selectsemi_anov94", "ub_buckslug_semi", "ub_buckslug", "s4_selectsemi", "selectsemi_bromeopg", "s4_selectauto", "selectsemi_mike1911"];
  var_3 = ["ubshtgn", "ubshtgn02", "ubshtgn_mike4"];

  if(var_0.isalternate && isDefined(var_0.underbarrel) && !scripts\engine\utility::array_contains(var_2, var_0.underbarrel)) {
    if(scripts\engine\utility::array_contains(var_3, var_0.underbarrel)) {
      return undefined;
    } else {
      var_1 = "weapon_projectile";
    }
  } else {
    var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  }

  return debug_spawning(var_1, var_0.basename);
}

function debug_spawning(var_0, var_1) {
  switch (var_0) {
    case "weapon_machine_pistol":
    case "weapon_pistol":
      if(isDefined(var_1) && var_1 == "iw8_pi_t9pistolshot_mp") {
        return "brloot_ammo_12g";
      }
    case "weapon_smg":
      return "brloot_ammo_919";
    case "weapon_shotgun":
      return "brloot_ammo_12g";
    case "weapon_lmg":
    case "weapon_assault":
    case "weapon_tactical":
      return "brloot_ammo_762";
    case "weapon_dmr":
    case "weapon_sniper":
      return "brloot_ammo_50cal";
    case "weapon_projectile":
    case "weapon_melee2":
      return "brloot_ammo_rocket";
  }

  return undefined;
}

function trial_vehicle(var_0) {
  switch (var_0) {
    case "brloot_ammo_50cal":
    case "brloot_ammo_rocket":
    case "brloot_ammo_919":
    case "brloot_ammo_12g":
    case "brloot_ammo_762":
      return true;
  }

  return false;
}

function debug_spawn_crate_on_train(var_0, var_1) {
  var_2 = br_ammo_type_for_weapon(var_0);
  var_3 = br_ammo_type_for_weapon(var_1);
  return isDefined(var_2) && isDefined(var_3) && var_2 == var_3;
}

function br_ammo_player_reload_watch() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("reload_start");

    if(!isDefined(self)) {
      return;
    }

    if(scripts\mp\gametypes\br_public::isplayeringulag()) {
      continue;
    }

    var_0 = self getcurrentweapon();
    var_1 = br_ammo_type_for_weapon(var_0);

    if(!isDefined(var_1)) {
      continue;
    }

    denyascendmessagejugg(var_0);

    if(!isDefined(self)) {
      return;
    }

    if(var_0 != self getcurrentweapon()) {
      continue;
    }

    if(!getdvarint("scr_prematch_infinite_ammo", istrue(level.ref_12857)) || scripts\mp\flags::gameflag("prematch_done")) {
      self.br_ammo[var_1] = self getweaponammostock(var_0);
    }

    debug_start_numbers_threaded(self, var_1);
  }
}

function denyascendmessagejugg(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("weapon_fired");

  while(self isreloading()) {
    waitframe();
  }
}

function delay_delete_alerted_icon(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_3 = br_ammo_type_for_weapon(var_0);

  if(isDefined(var_3)) {
    var_4 = int(level.br_ammo_clipsize[var_3] * var_1);
    var_2.br_ammo[var_3] = int(clamp(var_2.br_ammo[var_3] + var_4, 0, level.br_ammo_max[var_3]));
  }

  debug_start_numbers_threaded(var_2, var_3);
}

function delay_camera_normal(var_0, var_1) {
  var_2 = self;
  var_3 = br_ammo_type_for_weapon(var_0);

  if(isDefined(var_3)) {
    var_2.br_ammo[var_3] = int(clamp(var_2.br_ammo[var_3] + var_1, 0, level.br_ammo_max[var_3]));
  }

  debug_start_numbers_threaded(var_2, var_3);
}

function vandalize_attack_max_cooldown(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!issameweapon(var_0)) {
    return false;
  }

  if(nullweapon(var_0)) {
    return false;
  }

  if(scripts\mp\weapons::isfistweapon(var_0) || scripts\mp\utility\weapon::unset_relic_mythic(var_0) || scripts\mp\utility\weapon::update_health_bar_to_player(var_0)) {
    return false;
  }

  return true;
}

function deregistergasmaskscriptableatframeend() {
  if(istrue(level.debug_safehouse_regroup_start) && !scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return 1;
  }
}

function droptogroundmultitrace(var_0) {
  foreach(var_2 in var_0) {
    zone_bounds(var_2, istrue(var_2.should_spawn_boss_one));
  }
}

function zone_bounds(var_0, var_1) {
  var_2 = br_ammo_type_for_weapon(var_0);
  var_3 = weaponstartammo(var_0);
  var_4 = weaponclipsize(var_0);
  var_5 = weaponmaxammo(var_0);
  var_6 = undefined;

  if(var_1) {
    var_6 = var_5;
  } else {
    var_6 = var_3 - var_4;
  }

  if(isDefined(var_2)) {
    br_ammo_give_type(self, var_2, var_6);
    return;
  }
}