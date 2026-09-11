/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_weapons.gsc
***********************************************/

function createspawnweaponatpos(var0, var1, var2) {
  var3 = scripts\engine\trace::ray_trace(var0, (var0[0], var0[1], var0[2] - 60));
  var4 = var0;

  if(var3["fraction"] < 1) {
    var4 = var3["position"] + (0, 0, 2);
  }

  if(!isDefined(var1)) {
    var1 = (0, 0, 90);
  }

  var0 = var4;

  if(isDefined(var1)) {
    var1 = var1;
  } else {
    var1 = (0, 0, 90);
  }

  var5 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var0, var1);
  return weaponspawn(var2, undefined, var5, 1);
}

function createspawnweaponatposfromname(var0, var1) {
  var2 = var0;
  var3 = scripts\engine\trace::ray_trace(var0, (var0[0], var0[1], var0[2] - 60));

  if(var3["fraction"] < 1) {
    var2 = var3["position"] + (0, 0, 2);
  }

  var4 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var0, (0, 0, 90));
  return weaponspawn(var1, undefined, var4, 1);
}

function stripweaponsfromplayer() {
  var0 = undefined;
  var1 = undefined;

  foreach(var3 in self.equippedweapons) {
    var4 = scripts\mp\utility\weapon::getweaponrootname(var3.basename);

    if(var4 != "iw8_fists" && var4 != "iw8_knifestab" && var4 != "iw8_gunless") {
      if(issameweapon(var3) && var3.inventorytype == "primary") {
        var5 = scripts\mp\utility\weapon::getweaponrootname(self.currentprimaryweapon);

        if(var4 == var5) {
          var0 = var3;
        } else {
          var1 = var3;
        }
      }
    }
  }

  if(isDefined(var0)) {
    var7 = scripts\mp\utility\weapon::getweaponrootname(var0.basename);
  }

  if(isDefined(var1)) {
    var8 = scripts\mp\utility\weapon::getweaponrootname(var1.basename);
  }

  if(isDefined(var0) || isDefined(var1)) {
    if(isDefined(var0)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var0, 1);
    }

    if(isDefined(var1)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var1, 1);
    }

    scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_fists_mp");
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw8_fists_mp");
    return;
  }
}

function playerdropweaponfrominventory(var0) {
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in self.equippedweapons) {
    var5 = scripts\mp\utility\weapon::getweaponrootname(var4.basename);

    if(var5 != "iw8_fists" && var5 != "iw8_knifestab") {
      if(issameweapon(var4) && var4.inventorytype == "primary") {
        var6 = scripts\mp\utility\weapon::getweaponrootname(self.currentprimaryweapon);

        if(var5 == var6) {
          iprintln("PRIMARY IS " + var5);
          var1 = var4;
        } else {
          var2 = var4;
        }
      }
    }
  }

  var8 = undefined;
  var9 = undefined;
  var10 = "";
  var11 = "";

  if(isDefined(var1)) {
    var10 = scripts\mp\utility\weapon::getweaponrootname(var1.basename);
  }

  if(isDefined(var2)) {
    var11 = scripts\mp\utility\weapon::getweaponrootname(var2.basename);
  }

  if(var0 == var10) {
    var8 = var1;
    var9 = var2;
  } else if(var0 == var11) {
    var8 = var2;
    var9 = var1;
  }

  var12 = 0;

  if(isDefined(var8)) {
    var13 = self getweaponammoclip(var8);
    var14 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    var15 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var14, self.origin, self.angles, self);
    var16 = weaponspawn(var8, self, var15, 0);
    var16.count = var13;
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var8);

    if(isDefined(var9)) {
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var9);
    } else {
      scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_fists_mp");
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw8_fists_mp");
    }

    br_ammo_update_weapons(self);
    return;
  }
}

function weaponspawn(var0, var1, var2, var3, var4) {
  var5 = createheadicon(var0);
  var6 = scripts\mp\gametypes\br_pickups::spawnpickup(var5, var2, 0, var4, var0);
  level.ref_120ad _calloutmarkerping_handleluinotify_acknowledgedcancel::from(var6, var1, var0);
  return var6;
}

function takeweaponpickup(var0) {
  var1 = self.primaryweapons.size;

  if(!isDefined(var0.weapon)) {
    var2 = [];
    var3 = undefined;

    if(isDefined(var0.customweaponname)) {
      var4 = var0.customweaponname;
      var3 = asmdevgetallstates(var4);
      var3.customweaponname = var0.customweaponname;
    } else if(!isDefined(var1.completeweapon)) {
      var5 = scripts\mp\gametypes\br_pickups::relic_vampire_globalfunc(var1);
      var4 = createheadicon(var5);
    } else {
      var6 = scripts\mp\class::buildweapon(var3.loadoutprimaryfullname, var4, "none", "none", -1);
      var4 = var3.loadoutprimaryfullname;
    }

    if(!isDefined(var4)) {
      scripts\mp\utility\script::laststand_dogtags("takeWeaponPickup error - scriptable not setup for pickup: " + var3.scriptablename);
      return;
    }

    var2 = scripts\mp\utility\weapon::getweaponrootname(var4);
    var4 = var4;
  } else {
    var3 = var2.weapon;
    jumpiffalse(isDefined(var2.loadoutprimaryfullname)) LOC_000000e1;
    var6 = var2.loadoutprimaryfullname;
    goto LOC_000000f9;
  }

  var7 = 0;
  var8 = undefined;
  var9 = 0;

  foreach(var11 in self.primaryweapons) {
    if(nullweapon(var11)) {
      var5--;
      continue;
    }

    if(isnullweapon(var11, var6)) {
      var9 = 1;
      var7 = 1;
      var8 = var11;
    }
  }

  if(var5 > 1) {
    if(!self hasweapon("iw8_fists_mp")) {
      var7 = 1;
    } else if(!var9) {
      self takeweapon("iw8_fists_mp");
    }
  }

  if(var7) {
    if(!isDefined(var8)) {
      var8 = router_use_obj();
    }

    if(var8.basename != "none") {
      var13 = self getweaponammoclip(var8);
      var14 = self getweaponammoclip(var8, "left");
      var15 = 0;

      if(var8.hasalternate) {
        var16 = var8 getaltweapon();

        if(!debug_spawn_crate_on_train(var8, var16)) {
          var15 = self getweaponammoclip(var16);
        }
      }

      if(!scripts\mp\riotshield::isriotshield(var8)) {
        var17 = self getweaponammostock(var8);
        var18 = br_ammo_type_for_weapon(var8);

        if(isDefined(var18)) {
          self.br_ammo[var18] = var17;
        }
      }

      var19 = var3.origin - self.origin;
      var20 = vectortoyaw(var19);
      var21 = !scripts\mp\gametypes\br_extract_quest::operatorsfxalias(var8);

      if(var21) {
        if(isDefined(var3.tracknonoobplayerlocation) && isDefined(var3.tracknonoobplayerlocation.ƒj× ëuW ésò / ) k² oø E\¯‘€ 2[)) {
          var22 = var3.tracknonoobplayerlocation.ƒj× ëuW ésò / ) k² oø E\¯‘€ 2[; var23 = strtok(var8.basename, "_");

          if(scripts\mp\class::update_health_bar_to_players(var8) || var23[1] == "me") {
            var22 += (0, 90, 0);
          }
        }
        else {
          var22 = (0, var21, 0);
        }

        var24 = scripts\mp\gametypes\br_pickups::remove_roof_nodes(var5.origin, var22);
        var25 = tablesort(var24.origin, 500, 500);
        GscBinSkip0(0x2e, var25.size, self);
      }

      scripts\cp_mp\utility\inventory_utility::_takeweapon(var12);
    }
  }

  self giveweapon(var8);
  self notify("pickedupweapon", var10, var8);

  if(istrue(var8.isweaponfromcrate) || istrue(var6.isweaponfromcrate)) {
    var33 = br_ammo_type_for_weapon(var9);

    if(isDefined(var33)) {
      var34 = weaponclipsize(var8);
      br_ammo_give_type(self, var33, var34);
    }
  } else {
    var35 = var6.count;
    var36 = var6.impulsefx;
    var34 = weaponclipsize(var8);
    var37 = 0;

    if(var35 > var34) {
      var37 += var35 - var34;
      var35 = var34;
    }

    if(var36 > var34) {
      var37 += var36 - var34;
      var36 = var34;
    }

    self setweaponammoclip(var8, var35);
    self setweaponammoclip(var8, var36, "left");

    if(var37 > 0) {
      var33 = br_ammo_type_for_weapon(var8);

      if(isDefined(var33)) {
        br_ammo_give_type(self, var33, var37);
      }
    }

    if(var8.hasalternate) {
      var38 = var6.impactfunc_fire;
      var39 = var8 getaltweapon();

      if(!debug_spawn_crate_on_train(var8, var39)) {
        var40 = weaponclipsize(var39);

        if(var38 > var40) {
          var38 = var40;
        }

        self setweaponammoclip(var39, var38);
      }
    }
  }

  var8.ref_12cc1 = undefined;
  br_ammo_update_weapons(self);
  self assignweaponprimaryslot(var8);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var8);
  scripts\mp\weapons::fixupplayerweapons(self, var8);
  scripts\mp\weapons::updatelastweaponobj(var8);

  if(isDefined(var6.weapon) && isent(var6.weapon)) {
    var6.weapon delete();
  }

  var41 = undefined;

  foreach(var43 in self.equippedweapons) {
    if(issameweapon(var43) && var43.inventorytype == "primary") {
      var4 = createheadicon(var43);

      if(var4 == var10) {
        var41 = var43;
        break;
      }
    }
  }

  var41 = undefined;
  var43 = undefined;
  thread scripts\mp\gametypes\br_respawn::giveweaponpickup(var9);

  if(isDefined(var5.tracknonoobplayerlocation)) {
    level.ref_120ae _calloutmarkerping_handleluinotify_acknowledgedcancel::from(var5.tracknonoobplayerlocation, self, var7);
    return;
  }
}

function router_use_obj() {
  var0 = self method_87d5();

  if(isDefined(var0) && scripts\mp\weapons::isdroppableweapon(var0)) {
    foreach(var2 in self.primaryweapons) {
      if(isnullweapon(var2, var0)) {
        return var0;
      }
    }
  }

  return self.lastdroppableweaponobj;
}

function takeammopickup(var0) {
  var1 = 0;

  if(var0.scriptablename == "Ammo_Crate") {
    var2 = self getcurrentweapon().basename;
    var3 = scripts\mp\utility\weapon::getweaponrootname(var2);
    var4 = weaponclipsize(var2);
    var5 = br_ammo_type_for_weapon(var2);

    if(isDefined(var5)) {
      var1 = br_ammo_give_type(self, var5, var4);
    }
  } else {
    var1 = br_ammo_give_type(self, var0.scriptablename, var0.count, 1);
  }

  if(var1) {
    var0.count = var1;
    var6 = 1;
  } else {
    var6 = 0;
  }

  return var6;
}

function br_forcegiveweapon(var0, var1, var2) {
  if(!scripts\engine\utility::array_contains(level.br_pickups.br_lootguns, var0)) {
    var0 = degrees_to_radians();
  }

  var3 = spawnStruct();
  var3.loadoutprimaryfullname = var0;
  var3.scriptablename = scripts\mp\utility\weapon::getweaponrootname(var0);
  var3.completeweapon = var2;
  var3.count = 0;
  var3.impulsefx = 0;
  var3.impactfunc_fire = 0;
  takeweaponpickup(var1, var3);
}

function degrees_to_radians(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "ar";
  }

  if(!isDefined(var1)) {
    var1 = "comm";
  }

  var2 = [];

  foreach(var4 in level.br_pickups.br_lootguns) {
    if(issubstr(var4, "_" + var0 + "_")) {
      if(issubstr(var4, "_" + var1)) {
        var2 = var4;
      }
    }
  }

  return var2[randomint(var2.size)];
}

function br_getweaponstartingclipammo(var0) {
  var1 = weaponclipsize(var0);
  return int(var1);
}

function br_forcegivecustomweapon(var0, var1, var2, var3, var4, var5) {
  if(var0 hasweapon(var1)) {
    var0 scripts\mp\hud_message::showerrormessage("MP/BR_ALREADY_HOLDING_WEAPON");
    return false;
  }

  var6 = var1 hasattachment("maxammo", 1);
  var7 = spawnStruct();
  var7.weapon = var1;
  var7.loadoutprimaryfullname = var2;
  var7.scriptablename = var3;
  var7.origin = var0.origin + (0, 0, 24);
  var7.count = br_getweaponstartingclipammo(var1);
  var7.impulsefx = 0;
  var7.impactfunc_fire = 0;

  if(var6) {
    var7.count = 999;
  }

  if(isDefined(var4) && isDefined(var5)) {
    var8 = weaponclipsize(var1);
    var9 = int(ceil(var8 * var4));
    var7.count = int(min(var9, var5));
  }

  if(scripts\mp\utility\weapon::turnexfiltoside(var1)) {
    var7.impulsefx = var7.count;
  }

  if(var1.hasalternate) {
    var10 = var1 getaltweapon();

    if(!debug_spawn_crate_on_train(var1, var10)) {
      var11 = weaponclipsize(var10);
      var7.impactfunc_fire = var11;

      if(var6) {
        var7.impactfunc_fire = 999;
      }
    }
  }

  if(getdvarint("scr_br_request_streaming_weapons", 0) > 0) {
    var0 loadweaponsforplayer([var7.loadoutprimaryfullname]);
  }

  takeweaponpickup(var0, var7);

  if(var1.hasalternate) {
    var12 = var1 getaltweapon();

    if(var12.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var12.underbarrel) == "ubshtgn") {
      var13 = weaponclipsize(var12);
      var14 = int(var13);
      var0 setweaponammoclip(var12, var14);
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
      var0 = self getweaponslistprimaries();

      foreach(var2 in var0) {
        var3 = weaponclipsize(var2);

        if(isDefined(var3)) {
          if(scripts\mp\utility\weapon::turnexfiltoside(var2)) {
            self setweaponammoclip(var2, var3, "left");
            self setweaponammoclip(var2, var3, "right");
            continue;
          }

          self setweaponammoclip(var2, var3);
        }
      }
    }

    foreach(var6 in level.br_ammo_types) {
      if(!scripts\mp\flags::gameflag("prematch_done")) {
        self.br_ammo[var6] = level.br_ammo_max[var6];
        continue;
      }

      self.br_ammo[var6] = 0;
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

  foreach(var1 in level.br_ammo_types) {
    self.br_ammo[var1] = 0;
  }

  self notify("ammo_update");
}

function debug_spawnallaccesscards() {
  var0 = self;
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    var4 = br_ammo_type_for_weapon(var3);

    if(isDefined(var4)) {
      var5 = var0 getweaponammoclip(var3, "right");
      var6 = weaponclipsize(var3);

      if(var5 < var6) {
        return false;
      }

      if(var3 hasattachment("akimbo", 1)) {
        var7 = var0 getweaponammoclip(var3, "left");

        if(var7 < var6) {
          return false;
        }
      }

      if(!br_ammo_type_player_full(var0, var4)) {
        return false;
      }
    }
  }

  return true;
}

function debug_spawncover_badnodetest() {
  var0 = self;
  var1 = [];
  var2 = var0 getweaponslistprimaries();

  foreach(var4 in var2) {
    var5 = br_ammo_type_for_weapon(var4);

    if(isDefined(var5)) {
      var1 = "dummy_value";
      var6 = weaponclipsize(var4);
      var0 setweaponammoclip(var4, var6);
    }
  }

  foreach(var5, var9 in var1) {
    var0.br_ammo[var5] = level.br_ammo_max[var5];
    br_ammo_player_hud_update_ammotype(var0, var5);
  }

  br_ammo_update_weapons(var0);
}

function br_ammo_type_player_full(var0, var1) {
  if(!isDefined(var0.br_ammo) || !isDefined(var0.br_ammo[var1])) {
    return false;
  }

  if(!isDefined(level.br_ammo_max[var1])) {
    return false;
  }

  return scripts\mp\gametypes\br::get_int_or_0(var0.br_ammo[var1]) >= level.br_ammo_max[var1];
}

function br_ammo_give_type(var0, var1, var2, var3) {
  debug_spawnrewardstest(var0, var1);

  if(br_ammo_type_player_full(var0, var1)) {
    return var2;
  }

  if(!isDefined(var0.br_ammo)) {
    var0.br_ammo = [];
  }

  if(!isDefined(var0.br_ammo[var1])) {
    var0.br_ammo[var1] = 0;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var4 = 0;
  var0.br_ammo[var1] += var2;

  if(var0.br_ammo[var1] > level.br_ammo_max[var1]) {
    if(var3) {
      var4 = var0.br_ammo[var1] - level.br_ammo_max[var1];

      if(var4 < level.br_ammo_clipsize[var1]) {
        var4 = 0;
      }
    }

    var0.br_ammo[var1] = level.br_ammo_max[var1];
  }

  br_ammo_player_hud_update_ammotype(var0, var1);
  debug_start_numbers_threaded(var0, var1);
  return var4;
}

function debug_spawnrewardstest(var0, var1) {
  if(!var0 isreloading()) {
    return;
  }

  var2 = var0 getcurrentprimaryweapon();
  var3 = br_ammo_type_for_weapon(var2);

  if(isDefined(var3) && var1 == var3) {
    var0.br_ammo[var1] = var0 getweaponammostock(var2);
    return;
  }
}

function br_ammo_take_type(var0, var1, var2) {
  if(var0.br_ammo[var1] <= 0) {
    return false;
  }

  var0.br_ammo[var1] -= var2;

  if(var0.br_ammo[var1] < 0) {
    var0.br_ammo[var1] = 0;
  }

  br_ammo_player_hud_update_ammotype(var0, var1);
  br_ammo_update_weapons(var0);
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

function br_ammo_player_hud_update_ammotype(var0, var1) {
  if(isDefined(level.br_ammo_omnvars[var0])) {
    if(!isDefined(self.br_ammo)) {
      self.br_ammo = [];
    }

    if(!isDefined(self.br_ammo[var0])) {
      self.br_ammo[var0] = 0;
    }

    self setclientomnvar(level.br_ammo_omnvars[var0], self.br_ammo[var0]);
    return;
  }
}

function br_ammo_update_weapons(var0) {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("weapons")) {
    return;
  }

  if(!isDefined(var0)) {
    return;
  }

  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    var4 = br_ammo_type_for_weapon(var3);

    if(isDefined(var4)) {
      var5 = scripts\mp\gametypes\br::get_int_or_0(var0.br_ammo[var4]);
      var0 setweaponammostock(var3, var5);
    }
  }

  var0 notify("ammo_update");
}

function debug_start_numbers_threaded(var0, var1) {
  if(!isDefined(var0) || !isDefined(var1)) {
    return;
  }

  var2 = self getweaponslistprimaries();

  foreach(var4 in var2) {
    var5 = br_ammo_type_for_weapon(var4);

    if(isDefined(var5) && var1 == var5) {
      var6 = scripts\mp\gametypes\br::get_int_or_0(var0.br_ammo[var1]);
      var0 setweaponammostock(var4, var6);
    }
  }

  var0 notify("ammo_update");
}

function br_ammo_type_for_weapon(var0) {
  var1 = undefined;
  var2 = ["selectsemi", "selectsemi_falpha", "selectsemi_anov94", "ub_buckslug_semi", "ub_buckslug", "s4_selectsemi", "selectsemi_bromeopg", "s4_selectauto", "selectsemi_mike1911"];
  var3 = ["ubshtgn", "ubshtgn02", "ubshtgn_mike4"];

  if(var0.isalternate && isDefined(var0.underbarrel) && !scripts\engine\utility::array_contains(var2, var0.underbarrel)) {
    if(scripts\engine\utility::array_contains(var3, var0.underbarrel)) {
      return undefined;
    } else {
      var1 = "weapon_projectile";
    }
  } else {
    var1 = scripts\mp\utility\weapon::getweapongroup(var0);
  }

  return debug_spawning(var1, var0.basename);
}

function debug_spawning(var0, var1) {
  switch (var0) {
    case "weapon_machine_pistol":
    case "weapon_pistol":
      if(isDefined(var1) && var1 == "iw8_pi_t9pistolshot_mp") {
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

function trial_vehicle(var0) {
  switch (var0) {
    case "brloot_ammo_50cal":
    case "brloot_ammo_rocket":
    case "brloot_ammo_919":
    case "brloot_ammo_12g":
    case "brloot_ammo_762":
      return true;
  }

  return false;
}

function debug_spawn_crate_on_train(var0, var1) {
  var2 = br_ammo_type_for_weapon(var0);
  var3 = br_ammo_type_for_weapon(var1);
  return isDefined(var2) && isDefined(var3) && var2 == var3;
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

    var0 = self getcurrentweapon();
    var1 = br_ammo_type_for_weapon(var0);

    if(!isDefined(var1)) {
      continue;
    }

    denyascendmessagejugg(var0);

    if(!isDefined(self)) {
      return;
    }

    if(var0 != self getcurrentweapon()) {
      continue;
    }

    if(!getdvarint("scr_prematch_infinite_ammo", istrue(level.ref_12857)) || scripts\mp\flags::gameflag("prematch_done")) {
      self.br_ammo[var1] = self getweaponammostock(var0);
    }

    debug_start_numbers_threaded(self, var1);
  }
}

function denyascendmessagejugg(var0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("weapon_fired");

  while(self isreloading()) {
    waitframe();
  }
}

function delay_delete_alerted_icon(var0, var1) {
  var2 = self;

  if(!isDefined(var1)) {
    var1 = 1;
  }

  var3 = br_ammo_type_for_weapon(var0);

  if(isDefined(var3)) {
    var4 = int(level.br_ammo_clipsize[var3] * var1);
    var2.br_ammo[var3] = int(clamp(var2.br_ammo[var3] + var4, 0, level.br_ammo_max[var3]));
  }

  debug_start_numbers_threaded(var2, var3);
}

function delay_camera_normal(var0, var1) {
  var2 = self;
  var3 = br_ammo_type_for_weapon(var0);

  if(isDefined(var3)) {
    var2.br_ammo[var3] = int(clamp(var2.br_ammo[var3] + var1, 0, level.br_ammo_max[var3]));
  }

  debug_start_numbers_threaded(var2, var3);
}

function vandalize_attack_max_cooldown(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!issameweapon(var0)) {
    return false;
  }

  if(nullweapon(var0)) {
    return false;
  }

  if(scripts\mp\weapons::isfistweapon(var0) || scripts\mp\utility\weapon::unset_relic_mythic(var0) || scripts\mp\utility\weapon::update_health_bar_to_player(var0)) {
    return false;
  }

  return true;
}

function deregistergasmaskscriptableatframeend() {
  if(istrue(level.debug_safehouse_regroup_start) && !scripts\mp\gametypes\br_public::uniquelootitemid()) {
    return 1;
  }
}

function droptogroundmultitrace(var0) {
  foreach(var2 in var0) {
    zone_bounds(var2, istrue(var2.should_spawn_boss_one));
  }
}

function zone_bounds(var0, var1) {
  var2 = br_ammo_type_for_weapon(var0);
  var3 = weaponstartammo(var0);
  var4 = weaponclipsize(var0);
  var5 = weaponmaxammo(var0);
  var6 = undefined;

  if(var1) {
    var6 = var5;
  } else {
    var6 = var3 - var4;
  }

  if(isDefined(var2)) {
    br_ammo_give_type(self, var2, var6);
    return;
  }
}