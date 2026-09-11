/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58316.gsc
***********************************************/

function infectednightmode(var0, var1) {
  var2 = getEnt("e_" + var0 + "_crane_arm", "targetname");
  var2.molotov_crate_spawn = getEnt("e_" + var0 + "_crane_hook", "targetname");
  var2.molotov_delete_oldest_scriptable = getEnt("e_" + var0 + "_crane_platform", "targetname");
  var2.parachute_deploy = 0;
  var2.parachute_skydive = 0;
  var2.parachutecancutparachute = 0;
  var3 = var2 scripts\engine\utility::get_linked_ents();

  foreach(var5 in var3) {
    var5 linkTo(var2);
  }

  var7 = var2.molotov_delete_oldest_scriptable scripts\engine\utility::get_linked_ents();

  foreach(var5 in var7) {
    var5 linkTo(var2.molotov_delete_oldest_scriptable);
  }

  if(isDefined(var1)) {
    infectjugg_setconfig(var2, var1, undefined, 1);
  }

  return var2;
}

function infectedsupertwo(var0) {
  if(isarray(var0)) {
    for(var1 = 0; var1 < var0.size; var1++) {
      var2 = undefined;

      if(var1 < var0.size - 1) {
        var2 = var0[var1 + 1];
      }

      infectjugg_setconfig(var0[var1], var2, 0);
    }

    return;
  }

  infectjugg_setconfig(var0, undefined, 0);
}

function infectjugg_setconfig(var0, var1, var2) {
  var3 = 494;
  var4 = 0.3;
  var5 = 3;
  var6 = 3;
  var7 = 40;
  var8 = var4 / var7;
  var9 = var5 / var7;
  var10 = var6 / var7;
  var11 = 0;
  var12 = 0;
  var13 = 0;

  if(var2) {
    var4 = 90;
    var5 = 10000;
    var6 = 10000;
    self.parachute_deploy = 90;
    self.parachute_skydive = 10000;
    self.parachutecancutparachute = 10000;
  }

  if(!isvector(var0)) {
    var0 = var0.origin;
  }

  var0 = (var0[0], var0[1], var0[2] + var3);

  if(isDefined(var1)) {
    if(!isvector(var1)) {
      var1 = var1.origin;
    }

    var1 = (var1[0], var1[1], var1[2] + var3);
  }

  var14 = vectortoangles(self.origin - var0);
  var15 = var14[1];
  var15 += 90;

  if(var15 >= 360) {
    var15 -= 360;
  }

  if(self.angles[1] < var15) {
    if(abs(self.angles[1] - var15) > 180) {
      var4 *= -1;
      var8 *= -1;
    }
  } else if(abs(self.angles[1] - var15) < 180) {
    var4 *= -1;
    var8 *= -1;
  }

  var16 = distance2d(self.origin, self.molotov_crate_spawn.origin);
  var17 = distance2d(self.origin, var0);
  var18 = self.molotov_crate_spawn.origin[2] - self.origin[2];

  if(var17 < var16) {
    var5 *= -1;
    var9 *= -1;
  }

  var19 = var0[2] - self.molotov_delete_oldest_scriptable.origin[2];

  if(var19 < 0) {
    var6 *= -1;
    var10 *= -1;
  }

  var20 = 0;
  var21 = 0;
  var22 = 0;
  var23 = scripts\mp\utility\player::getplayersinradius(self.molotov_delete_oldest_scriptable.origin, 300);

  foreach(var25 in var23) {
    var26 = var25.origin - self.molotov_delete_oldest_scriptable.origin;
    var27 = vectortoangles(var26);
    var27 = (var27[0], var27[1] + 40, var27[2]);
    var28 = distance2d(var25.origin, self.molotov_delete_oldest_scriptable.origin);
    var29 = self.molotov_delete_oldest_scriptable.origin + var27 * var28;
    var30 = self.molotov_delete_oldest_scriptable.origin + anglesToForward(self.molotov_delete_oldest_scriptable.angles) * 160;
    var31 = self.molotov_delete_oldest_scriptable.origin + anglesToForward(self.molotov_delete_oldest_scriptable.angles) * -160;
    var32 = self.molotov_delete_oldest_scriptable.origin + anglestoright(self.molotov_delete_oldest_scriptable.angles) * 115;
    var33 = self.molotov_delete_oldest_scriptable.origin + anglestoright(self.molotov_delete_oldest_scriptable.angles) * -115;

    if(var31[0] < var25.origin[0] && var25.origin[0] < var30[0] && var32[1] < var25.origin[1] && var25.origin[1] < var33[1] && self.molotov_delete_oldest_scriptable.origin[2] < var25.origin[2] && var25 isonground()) {
      var25 earthquakeforplayer(0.1, 2, var25.origin, 100);
      var25 playrumbleonpositionforclient("damage_light", var25.origin);
    }
  }

  for(;;) {
    var35 = var15 - self.angles[1];

    if(!var20 && !var35) {
      var20 = 1;
    }

    if(var35) {
      var36 = 0;

      if(isDefined(var1) && var21 && var22) {
        var37 = vectortoangles(self.origin - var1);
        var38 = var37[1];
        var38 += 90;

        if(var38 >= 360) {
          var38 -= 360;
        }

        if(var15 != var38) {
          if(abs(self.parachute_deploy) < abs(var4)) {
            self.parachute_deploy += var8;
          }
        } else if(abs(var35) < var7 / 2 * abs(var4)) {
          self.parachute_deploy = var4 * abs(var35) / var7 / 2 * abs(var4);

          if(abs(self.parachute_deploy) < 0.05 * abs(var4)) {
            self.parachute_deploy = 0.05 * var4;
          }

          if(abs(var35) < 0.05 * abs(var4)) {
            self.parachute_deploy = var35;
            var36 = 1;
          }
        } else if(abs(self.parachute_deploy) < abs(var4)) {
          self.parachute_deploy += var8;
        }

        if(abs(var35) <= abs(var4)) {
          var20 = 1;
        }
      } else if(abs(var35) < var7 / 2 * abs(var4)) {
        self.parachute_deploy = var4 * abs(var35) / var7 / 2 * abs(var4);

        if(abs(self.parachute_deploy) < 0.05 * abs(var4)) {
          self.parachute_deploy = 0.05 * var4;
        }

        if(abs(var35) < 0.05 * abs(var4)) {
          self.parachute_deploy = var35;
          var36 = 1;
        }
      } else if(abs(self.parachute_deploy) < abs(var4)) {
        self.parachute_deploy += var8;
      }

      if(var35) {
        self rotateYaw(self.parachute_deploy, 0.05);
        self.molotov_crate_spawn rotateYaw(self.parachute_deploy, 0.05);
        self.molotov_delete_oldest_scriptable rotateYaw(self.parachute_deploy, 0.05);

        if(var36) {
          self.parachute_deploy = 0;
        }
      }
    }

    var39 = undefined;
    var16 = distance2d(self.origin, self.molotov_crate_spawn.origin);
    var40 = var17 - var16;

    if(!var21 && abs(var40) < 0.005) {
      var21 = 1;
    }

    if(var35 || var40) {
      var41 = (0, self.angles[1] + self.parachute_deploy, 0);
      var42 = vectorNormalize(-1 * anglestoright(var41));
      var36 = 0;

      if(isDefined(var1) && var20 && var22) {
        var43 = distance2d(self.origin, var1);

        if(var17 != var43) {
          if(abs(self.parachute_skydive) < abs(var5)) {
            self.parachute_skydive += var9;
          }
        } else if(abs(var40) < var7 / 2 * abs(var5)) {
          self.parachute_skydive = var5 * abs(var40) / var7 / 2 * abs(var5);

          if(abs(self.parachute_skydive) < 0.05 * abs(var5)) {
            self.parachute_skydive = 0.05 * var5;
          }

          if(abs(var40) < 0.05 * abs(var5)) {
            self.parachute_skydive = var40;
            var36 = 1;
          }
        } else if(abs(self.parachute_skydive) < abs(var5)) {
          self.parachute_skydive += var9;
        }

        if(abs(var40) <= abs(var5)) {
          var21 = 1;
        }
      } else if(abs(var40) < var7 / 2 * abs(var5)) {
        self.parachute_skydive = var5 * abs(var40) / var7 / 2 * abs(var5);

        if(abs(self.parachute_skydive) < 0.05 * abs(var5)) {
          self.parachute_skydive = 0.05 * var5;
        }

        if(abs(var40) < 0.05 * abs(var5)) {
          self.parachute_skydive = var40;
          var36 = 1;
        }
      } else if(abs(self.parachute_skydive) < abs(var5)) {
        self.parachute_skydive += var9;
      }

      if(var35 || var40) {
        var44 = var16 + self.parachute_skydive;
        var39 = self.origin + var42 * var44 + (0, 0, var18);
        self.molotov_crate_spawn moveTo(var39, 0.05);

        if(var36) {
          self.parachute_skydive = 0;
        }
      }
    }

    var45 = var0[2] - self.molotov_delete_oldest_scriptable.origin[2];

    if(!var22 && !var45) {
      var22 = 1;
    }

    if(var35 || var40 || var45) {
      var36 = 0;

      if(isDefined(var1) && var20 && var21) {
        var46 = var1[2] - self.molotov_delete_oldest_scriptable.origin[2];

        if(var19 != var46) {
          if(abs(self.parachutecancutparachute) < abs(var6)) {
            self.parachutecancutparachute += var10;
          }
        } else if(abs(var45) < abs(var7 / 2) * abs(var6)) {
          self.parachutecancutparachute = var6 * abs(var45) / abs(var7 / 2) * abs(var6);

          if(abs(self.parachutecancutparachute) < 0.05 * abs(var6)) {
            self.parachutecancutparachute = 0.05 * var6;
          }

          if(abs(var45) < 0.05 * abs(var6)) {
            self.parachutecancutparachute = var45;
            var36 = 1;
          }
        } else if(abs(self.parachutecancutparachute) < abs(var6)) {
          self.parachutecancutparachute += var10;
        }

        if(abs(var45) <= abs(var6)) {
          var22 = 1;
        }
      } else if(abs(var45) < abs(var7 / 2) * abs(var6)) {
        self.parachutecancutparachute = var6 * abs(var45) / abs(var7 / 2) * abs(var6);

        if(abs(self.parachutecancutparachute) < 0.05 * abs(var6)) {
          self.parachutecancutparachute = 0.05 * var6;
        }

        if(abs(var45) < 0.05 * abs(var6)) {
          self.parachutecancutparachute = var45;
          var36 = 1;
        }
      } else if(abs(self.parachutecancutparachute) < abs(var6)) {
        self.parachutecancutparachute += var10;
      }

      if(isDefined(var39)) {
        var47 = (var39[0], var39[1], self.molotov_delete_oldest_scriptable.origin[2] + self.parachutecancutparachute);
      } else {
        var47 = (self.molotov_delete_oldest_scriptable.origin[0], self.molotov_delete_oldest_scriptable.origin[1], self.molotov_delete_oldest_scriptable.origin[2] + self.parachutecancutparachute);
      }

      self.molotov_delete_oldest_scriptable moveTo(var47, 0.05);

      if(var47) {
        self.parachutecancutparachute = 0;
      }
    }

    if(var21 && var22 && var23) {
      break;
    }

    wait 0.05;
  }
}

function activate_seq_button() {}

function ref_125fc() {
  var0 = spawnStruct();
  var0.ref_12889 = [];
  var0.brtdm_config = [];
  var0.brtruck_cleanupents = [];
  var0.brtruck_ontimelimit = [];
  var0.offhands = [];
  var0.nvidiaansel_overridecollisionradius = [];
  var0.should_use_velo_forward = self.should_use_velo_forward;
  var0.callprecisionairstrikeonlocation = scripts\mp\equipment::getequipmentslotammo("health");
  var1 = [];
  var2 = self getweaponslistprimaries();

  foreach(var4 in var2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var4) && !issubstr(var4.basename, "iw8_fists_mp") && !scripts\mp\utility\weapon::unset_relic_mythic(var4.basename)) {
      var1 = var4;
    }
  }

  foreach(var7 in var1) {
    var8 = createheadicon(var7);

    if(var7.basename == "iw8_lm_dblmg_mp" || var7.basename == "iw8_la_mike32_mp") {
      var0.brtdm_config[var8] = self getweaponammoclip(var7);
      var0.brtruck_ontimelimit[var8] = self getweaponammostock(var7);
    } else {
      var0.brtdm_config[var8] = weaponclipsize(var7);
      var0.brtruck_ontimelimit[var8] = int(max(self getweaponammostock(var7), weaponclipsize(var7)));
    }

    if(scripts\mp\utility\weapon::turnexfiltoside(var7)) {
      var0.brtruck_cleanupents[var8] = weaponclipsize(var7);
    }

    if(getsubstr(var8, 0, 4) == "alt_") {
      continue;
    }

    var0.ref_12889[var0.ref_12889.size] = var7;
  }

  var10 = self getweaponslistoffhands();

  foreach(var12 in var10) {
    if(var12.basename == "bandage_br") {
      continue;
    }

    var13 = self getweaponammoclip(var12);

    if(var13 <= 0) {
      continue;
    }

    var0.offhands[var0.offhands.size] = var12;
    var14 = createheadicon(var12);
    var0.brtdm_config[var14] = var13;
  }

  foreach(var17 in self.equipment) {
    var0.nvidiaansel_overridecollisionradius[var17] = var18;
  }

  if(getdvarint("scr_restore_loadout_super", 1)) {
    var0.super = undefined;

    if(isDefined(self.super) && !self.super.usepercent) {
      var0.super = self.equipment["super"];
    }
  }

  if(isDefined(self.streakdata.streaks[1]) && getdvarint("scr_restore_loadout_killstreak", 1)) {
    var0.vo_one_remain = self.streakdata.streaks[1].streakname;
  }

  if(scripts\cp_mp\gasmask::hasgasmask(self) && getdvarint("scr_restore_loadout_gas_mask", 1)) {
    var0.gasmaskhealth = self.gasmaskhealth;
    var0.plunderpads = self.plunderpads;
    var0.plundersilentcountdownendtime = self.plundersilentcountdownendtime;
  }

  self.ref_12eb0 = var0;
}

function ref_125fb() {
  self takeallweapons(0, 1);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  self.equipment["primary"] = undefined;
  self.equipment["secondary"] = undefined;
  self.equipment["health"] = undefined;
  self.equipment["super"] = undefined;
  var0 = 0;

  foreach(var2 in self.ref_12eb0.ref_12889) {
    var3 = createheadicon(var2);

    if(var3 == "iw8_lm_dblmg_mp") {
      scripts\mp\gametypes\br_weapons::br_forcegiveweapon("brloot_weapon_lm_dblmg_lege", self);
    } else {
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var2);
    }

    if(!var0) {
      self assignweaponprimaryslot(var3);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var2);
      var0 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, var3);
  }

  if(self.ref_12eb0.ref_12889.size < 2) {
    var5 = getcompleteweaponname("iw8_fists_mp");
    self giveweapon(var5);
  }

  foreach(var7 in self.ref_12eb0.offhands) {
    var8 = scripts\mp\equipment::getequipmentreffromweapon(var7);

    if(!isDefined(var8)) {
      continue;
    }

    var9 = self.ref_12eb0.nvidiaansel_overridecollisionradius[var8];

    if(!isDefined(var9)) {
      continue;
    }

    scripts\mp\equipment::giveequipment(var8, var9);
  }

  foreach(var3, var12 in self.ref_12eb0.brtruck_ontimelimit) {
    self setweaponammostock(var3, var12);
    var2 = getcompleteweaponname(getweaponbasename(var3));
    var13 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var2);

    if(isDefined(var13)) {
      self.br_ammo[var13] = var12;
      scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype(var13);
    }
  }

  foreach(var3, var12 in self.ref_12eb0.brtdm_config) {
    self setweaponammoclip(var3, var12);
  }

  foreach(var3, var12 in self.ref_12eb0.brtruck_cleanupents) {
    self setweaponammoclip(var3, var12, "left");
  }

  waitframe();

  if(isDefined(self.ref_12eb0.super) && getdvarint("scr_restore_loadout_super", 1)) {
    var16 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self.ref_12eb0.super]];
    scripts\mp\gametypes\br_pickups::forcegivesuper(var16, 0);
  }

  if(isDefined(self.ref_12eb0.vo_one_remain) && getdvarint("scr_restore_loadout_killstreak", 1)) {
    scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar(self.ref_12eb0.vo_one_remain);
  }

  if(getdvarint("scr_restore_loadout_plates", 1)) {
    self.should_use_velo_forward = self.ref_12eb0.should_use_velo_forward;
    self setclientomnvar("ui_br_has_plate_pouch", istrue(self.should_use_velo_forward));

    if(isDefined(self.ref_12eb0.callprecisionairstrikeonlocation) && self.ref_12eb0.callprecisionairstrikeonlocation > 0) {
      scripts\mp\equipment::giveequipment("equip_armorplate", "health");
      scripts\mp\equipment::setequipmentslotammo("health", self.ref_12eb0.callprecisionairstrikeonlocation);
    }
  }

  if(isDefined(self.ref_12eb0.plundersilentcountdownendtime) && getdvarint("scr_restore_loadout_gas_mask", 1)) {
    scripts\cp_mp\gasmask::init(self.ref_12eb0.gasmaskhealth, self.ref_12eb0.plundersilentcountdownendtime);
  }

  thread scripts\cp_mp\gestures::ref_13e1a();
  self.ref_12eb0 = undefined;
}