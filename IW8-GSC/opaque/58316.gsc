/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58316.gsc
***********************************************/

infectednightmode(var_0, var_1) {
  var_2 = getEnt("_encstr_9607039829" + var_0 + "_encstr_93E80B5F4EB37F6D3B11F2FBB8", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2.molotov_crate_spawn = getEnt("_encstr_9607039829" + var_0 + "_encstr_AB3C0CDF4710DE333D7E1A524002", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2.molotov_delete_oldest_scriptable = getEnt("_encstr_9607039829" + var_0 + "_encstr_B62410F5D89C58E659F51C8D0BA333F6E4DA", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2.parachute_deploy = 0;
  var_2.parachute_skydive = 0;
  var_2.parachutecancutparachute = 0;
  var_3 = var_2 scripts\engine\utility::get_linked_ents();

  foreach(var_5 in var_3)
  var_5 linkTo(var_2);

  var_7 = var_2.molotov_delete_oldest_scriptable scripts\engine\utility::get_linked_ents();

  foreach(var_5 in var_7)
  var_5 linkTo(var_2.molotov_delete_oldest_scriptable);

  if(isDefined(var_1))
    var_2 infectjugg_setconfig(var_1, undefined, 1);

  return var_2;
}

infectedsupertwo(var_0) {
  if(isarray(var_0)) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = undefined;

      if(var_1 < var_0.size - 1)
        var_2 = var_0[var_1 + 1];

      infectjugg_setconfig(var_0[var_1], var_2, 0);
    }
  } else
    infectjugg_setconfig(var_0, undefined, 0);
}

infectjugg_setconfig(var_0, var_1, var_2) {
  var_3 = 494;
  var_4 = 0.3;
  var_5 = 3;
  var_6 = 3;
  var_7 = 40;
  var_8 = var_4 / var_7;
  var_9 = var_5 / var_7;
  var_10 = var_6 / var_7;
  var_11 = 0;
  var_12 = 0;
  var_13 = 0;

  if(var_2) {
    var_4 = 90;
    var_5 = 10000;
    var_6 = 10000;
    self.parachute_deploy = 90;
    self.parachute_skydive = 10000;
    self.parachutecancutparachute = 10000;
  }

  if(!isvector(var_0))
    var_0 = var_0.origin;

  var_0 = (var_0[0], var_0[1], var_0[2] + var_3);

  if(isDefined(var_1)) {
    if(!isvector(var_1))
      var_1 = var_1.origin;

    var_1 = (var_1[0], var_1[1], var_1[2] + var_3);
  }

  var_14 = vectortoangles(self.origin - var_0);
  var_15 = var_14[1];
  var_15 = var_15 + 90;

  if(var_15 >= 360)
    var_15 = var_15 - 360;

  if(self.angles[1] < var_15) {
    if(abs(self.angles[1] - var_15) > 180) {
      var_4 = var_4 * -1;
      var_8 = var_8 * -1;
    }
  } else if(abs(self.angles[1] - var_15) < 180) {
    var_4 = var_4 * -1;
    var_8 = var_8 * -1;
  }

  var_16 = distance2d(self.origin, self.molotov_crate_spawn.origin);
  var_17 = distance2d(self.origin, var_0);
  var_18 = self.molotov_crate_spawn.origin[2] - self.origin[2];

  if(var_17 < var_16) {
    var_5 = var_5 * -1;
    var_9 = var_9 * -1;
  }

  var_19 = var_0[2] - self.molotov_delete_oldest_scriptable.origin[2];

  if(var_19 < 0) {
    var_6 = var_6 * -1;
    var_10 = var_10 * -1;
  }

  var_20 = 0;
  var_21 = 0;
  var_22 = 0;
  var_23 = scripts\mp\utility\player::getplayersinradius(self.molotov_delete_oldest_scriptable.origin, 300);

  foreach(var_25 in var_23) {
    var_26 = var_25.origin - self.molotov_delete_oldest_scriptable.origin;
    var_27 = vectortoangles(var_26);
    var_27 = (var_27[0], var_27[1] + 40, var_27[2]);
    var_28 = distance2d(var_25.origin, self.molotov_delete_oldest_scriptable.origin);
    var_29 = self.molotov_delete_oldest_scriptable.origin + var_27 * var_28;
    var_30 = self.molotov_delete_oldest_scriptable.origin + anglesToForward(self.molotov_delete_oldest_scriptable.angles) * 160;
    var_31 = self.molotov_delete_oldest_scriptable.origin + anglesToForward(self.molotov_delete_oldest_scriptable.angles) * -160;
    var_32 = self.molotov_delete_oldest_scriptable.origin + anglestoright(self.molotov_delete_oldest_scriptable.angles) * 115;
    var_33 = self.molotov_delete_oldest_scriptable.origin + anglestoright(self.molotov_delete_oldest_scriptable.angles) * -115;

    if(var_31[0] < var_25.origin[0] && var_25.origin[0] < var_30[0] && var_32[1] < var_25.origin[1] && var_25.origin[1] < var_33[1] && self.molotov_delete_oldest_scriptable.origin[2] < var_25.origin[2] && var_25 isonground()) {
      var_25 earthquakeforplayer(0.1, 2, var_25.origin, 100);
      var_25 playrumbleonpositionforclient("_encstr_B14F0D7B2B51F287F03ED59C51F0DC", var_25.origin);
    }
  }

  for(;;) {
    var_35 = var_15 - self.angles[1];

    if(!var_20 && !var_35)
      var_20 = 1;

    if(var_35) {
      var_36 = 0;

      if(isDefined(var_1) && var_21 && var_22) {
        var_37 = vectortoangles(self.origin - var_1);
        var_38 = var_37[1];
        var_38 = var_38 + 90;

        if(var_38 >= 360)
          var_38 = var_38 - 360;

        if(var_15 != var_38) {
          if(abs(self.parachute_deploy) < abs(var_4))
            self.parachute_deploy = self.parachute_deploy + var_8;
        } else if(abs(var_35) < var_7 / 2 * abs(var_4)) {
          self.parachute_deploy = var_4 * (abs(var_35) / (var_7 / 2 * abs(var_4)));

          if(abs(self.parachute_deploy) < 0.05 * abs(var_4))
            self.parachute_deploy = 0.05 * var_4;

          if(abs(var_35) < 0.05 * abs(var_4)) {
            self.parachute_deploy = var_35;
            var_36 = 1;
          }
        } else if(abs(self.parachute_deploy) < abs(var_4))
          self.parachute_deploy = self.parachute_deploy + var_8;

        if(abs(var_35) <= abs(var_4))
          var_20 = 1;
      } else if(abs(var_35) < var_7 / 2 * abs(var_4)) {
        self.parachute_deploy = var_4 * (abs(var_35) / (var_7 / 2 * abs(var_4)));

        if(abs(self.parachute_deploy) < 0.05 * abs(var_4))
          self.parachute_deploy = 0.05 * var_4;

        if(abs(var_35) < 0.05 * abs(var_4)) {
          self.parachute_deploy = var_35;
          var_36 = 1;
        }
      } else if(abs(self.parachute_deploy) < abs(var_4))
        self.parachute_deploy = self.parachute_deploy + var_8;

      if(var_35) {
        self rotateYaw(self.parachute_deploy, 0.05);
        self.molotov_crate_spawn rotateYaw(self.parachute_deploy, 0.05);
        self.molotov_delete_oldest_scriptable rotateYaw(self.parachute_deploy, 0.05);

        if(var_36)
          self.parachute_deploy = 0;
      }
    }

    var_39 = undefined;
    var_16 = distance2d(self.origin, self.molotov_crate_spawn.origin);
    var_40 = var_17 - var_16;

    if(!var_21 && abs(var_40) < 0.005)
      var_21 = 1;

    if(var_35 || var_40) {
      var_41 = (0, self.angles[1] + self.parachute_deploy, 0);
      var_42 = vectorNormalize(-1 * anglestoright(var_41));
      var_36 = 0;

      if(isDefined(var_1) && var_20 && var_22) {
        var_43 = distance2d(self.origin, var_1);

        if(var_17 != var_43) {
          if(abs(self.parachute_skydive) < abs(var_5))
            self.parachute_skydive = self.parachute_skydive + var_9;
        } else if(abs(var_40) < var_7 / 2 * abs(var_5)) {
          self.parachute_skydive = var_5 * (abs(var_40) / (var_7 / 2 * abs(var_5)));

          if(abs(self.parachute_skydive) < 0.05 * abs(var_5))
            self.parachute_skydive = 0.05 * var_5;

          if(abs(var_40) < 0.05 * abs(var_5)) {
            self.parachute_skydive = var_40;
            var_36 = 1;
          }
        } else if(abs(self.parachute_skydive) < abs(var_5))
          self.parachute_skydive = self.parachute_skydive + var_9;

        if(abs(var_40) <= abs(var_5))
          var_21 = 1;
      } else if(abs(var_40) < var_7 / 2 * abs(var_5)) {
        self.parachute_skydive = var_5 * (abs(var_40) / (var_7 / 2 * abs(var_5)));

        if(abs(self.parachute_skydive) < 0.05 * abs(var_5))
          self.parachute_skydive = 0.05 * var_5;

        if(abs(var_40) < 0.05 * abs(var_5)) {
          self.parachute_skydive = var_40;
          var_36 = 1;
        }
      } else if(abs(self.parachute_skydive) < abs(var_5))
        self.parachute_skydive = self.parachute_skydive + var_9;

      if(var_35 || var_40) {
        var_44 = var_16 + self.parachute_skydive;
        var_39 = self.origin + var_42 * var_44 + (0, 0, var_18);
        self.molotov_crate_spawn moveTo(var_39, 0.05);

        if(var_36)
          self.parachute_skydive = 0;
      }
    }

    var_45 = var_0[2] - self.molotov_delete_oldest_scriptable.origin[2];

    if(!var_22 && !var_45)
      var_22 = 1;

    if(var_35 || var_40 || var_45) {
      var_36 = 0;

      if(isDefined(var_1) && var_20 && var_21) {
        var_46 = var_1[2] - self.molotov_delete_oldest_scriptable.origin[2];

        if(var_19 != var_46) {
          if(abs(self.parachutecancutparachute) < abs(var_6))
            self.parachutecancutparachute = self.parachutecancutparachute + var_10;
        } else if(abs(var_45) < abs(var_7 / 2) * abs(var_6)) {
          self.parachutecancutparachute = var_6 * (abs(var_45) / (abs(var_7 / 2) * abs(var_6)));

          if(abs(self.parachutecancutparachute) < 0.05 * abs(var_6))
            self.parachutecancutparachute = 0.05 * var_6;

          if(abs(var_45) < 0.05 * abs(var_6)) {
            self.parachutecancutparachute = var_45;
            var_36 = 1;
          }
        } else if(abs(self.parachutecancutparachute) < abs(var_6))
          self.parachutecancutparachute = self.parachutecancutparachute + var_10;

        if(abs(var_45) <= abs(var_6))
          var_22 = 1;
      } else if(abs(var_45) < abs(var_7 / 2) * abs(var_6)) {
        self.parachutecancutparachute = var_6 * (abs(var_45) / (abs(var_7 / 2) * abs(var_6)));

        if(abs(self.parachutecancutparachute) < 0.05 * abs(var_6))
          self.parachutecancutparachute = 0.05 * var_6;

        if(abs(var_45) < 0.05 * abs(var_6)) {
          self.parachutecancutparachute = var_45;
          var_36 = 1;
        }
      } else if(abs(self.parachutecancutparachute) < abs(var_6))
        self.parachutecancutparachute = self.parachutecancutparachute + var_10;

      if(isDefined(var_39))
        var_47 = (var_39[0], var_39[1], self.molotov_delete_oldest_scriptable.origin[2] + self.parachutecancutparachute);
      else
        var_47 = (self.molotov_delete_oldest_scriptable.origin[0], self.molotov_delete_oldest_scriptable.origin[1], self.molotov_delete_oldest_scriptable.origin[2] + self.parachutecancutparachute);

      self.molotov_delete_oldest_scriptable moveTo(var_47, 0.05);

      if(var_36)
        self.parachutecancutparachute = 0;
    }

    if(var_20 && var_21 && var_22) {
      break;
    }

    wait 0.05;
  }
}

activate_seq_button() {}

_id_125FC() {
  var_0 = spawnStruct();
  var_0._id_12889 = [];
  var_0.brtdm_config = [];
  var_0.brtruck_cleanupents = [];
  var_0.brtruck_ontimelimit = [];
  var_0.offhands = [];
  var_0.nvidiaansel_overridecollisionradius = [];
  var_0.should_use_velo_forward = self.should_use_velo_forward;
  var_0.callprecisionairstrikeonlocation = scripts\mp\equipment::getequipmentslotammo("_encstr_91B50734CA58631D1A");
  var_1 = [];
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_4) && !issubstr(var_4.basename, "_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C") && !scripts\mp\utility\weapon::unset_relic_mythic(var_4.basename))
      var_1[var_1.size] = var_4;
  }

  foreach(var_7 in var_1) {
    var_8 = createheadicon(var_7);

    if(var_7.basename == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB" || var_7.basename == "_encstr_B6D8115ADD83F5B12CD7D64BDACACC91EBD6E0") {
      var_0.brtdm_config[var_8] = self getweaponammoclip(var_7);
      var_0.brtruck_ontimelimit[var_8] = self getweaponammostock(var_7);
    } else {
      var_0.brtdm_config[var_8] = weaponclipsize(var_7);
      var_0.brtruck_ontimelimit[var_8] = int(max(self getweaponammostock(var_7), weaponclipsize(var_7)));
    }

    if(scripts\mp\utility\weapon::turnexfiltoside(var_7))
      var_0.brtruck_cleanupents[var_8] = weaponclipsize(var_7);

    if(getsubstr(var_8, 0, 4) == "_encstr_9B83050BD88EF5") {
      continue;
    }
    var_0._id_12889[var_0._id_12889.size] = var_7;
  }

  var_10 = self getweaponslistoffhands();

  foreach(var_12 in var_10) {
    if(var_12.basename == "_encstr_A51B0B2BD260444AAFCD6F86E2") {
      continue;
    }
    var_13 = self getweaponammoclip(var_12);

    if(var_13 <= 0) {
      continue;
    }
    var_0.offhands[var_0.offhands.size] = var_12;
    var_14 = createheadicon(var_12);
    var_0.brtdm_config[var_14] = var_13;
  }

  foreach(var_18, var_17 in self.equipment)
  var_0.nvidiaansel_overridecollisionradius[var_17] = var_18;

  if(getdvarint("_encstr_BD8A1A026E05119A41682BBF98B97FEAE7F74FBDCD6169C36B5867C3", 1)) {
    var_0.super = undefined;

    if(isDefined(self.super) && !self.super.usepercent)
      var_0.super = self.equipment["_encstr_BEB406F03B72BB3B"];
  }

  if(isDefined(self.streakdata.streaks[1]) && getdvarint("_encstr_8AF31F9B6C4EBEC9B26E3A7B2795EB637B5823F65D47AFDAA536639B3AC9562CAD", 1))
    var_0.vo_one_remain = self.streakdata.streaks[1].streakname;

  if(scripts\cp_mp\gasmask::hasgasmask(self) && getdvarint("_encstr_B2851DABDFC219FD8FDA653F95CBCFDB48705A20634D3104178F0F41963B32", 1)) {
    var_0.gasmaskhealth = self.gasmaskhealth;
    var_0.plunderpads = self.plunderpads;
    var_0.plundersilentcountdownendtime = self.plundersilentcountdownendtime;
  }

  self._id_12EB0 = var_0;
}

_id_125FB() {
  self takeallweapons(0, 1);
  _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_clear();
  self.equipment["_encstr_BA7F0830B3A7859B60B0"] = undefined;
  self.equipment["_encstr_AC8F0AE74163F85AAA380AD8"] = undefined;
  self.equipment["_encstr_91B50734CA58631D1A"] = undefined;
  self.equipment["_encstr_BEB406F03B72BB3B"] = undefined;
  var_0 = 0;

  foreach(var_2 in self._id_12EB0._id_12889) {
    var_3 = createheadicon(var_2);

    if(var_3 == "_encstr_93BD10DAA3532F4D30DF0C12A1E857E711BB")
      _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_forcegiveweapon("_encstr_A1FF1C139363EDB7D1AFDDB28583ED73D7366BD74626D8B53BBE63AC7656", self);
    else
      scripts\cp_mp\utility\inventory_utility::_giveweapon(var_2);

    if(!var_0) {
      self assignweaponprimaryslot(var_3);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_2);
      var_0 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, var_3);
  }

  if(self._id_12EB0._id_12889.size < 2) {
    var_5 = getcompleteweaponname("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    self giveweapon(var_5);
  }

  foreach(var_7 in self._id_12EB0.offhands) {
    var_8 = scripts\mp\equipment::getequipmentreffromweapon(var_7);

    if(!isDefined(var_8)) {
      continue;
    }
    var_9 = self._id_12EB0.nvidiaansel_overridecollisionradius[var_8];

    if(!isDefined(var_9)) {
      continue;
    }
    scripts\mp\equipment::giveequipment(var_8, var_9);
  }

  foreach(var_3, var_12 in self._id_12EB0.brtruck_ontimelimit) {
    self setweaponammostock(var_3, var_12);
    var_2 = getcompleteweaponname(getweaponbasename(var_3));
    var_13 = _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_type_for_weapon(var_2);

    if(isDefined(var_13)) {
      self.br_ammo[var_13] = var_12;
      _encstr_97D524A791FAFBB85348207081058F9E8D173930515956F05175FF83A22FCF97B870E5B7FBB7::br_ammo_player_hud_update_ammotype(var_13);
    }
  }

  foreach(var_3, var_12 in self._id_12EB0.brtdm_config)
  self setweaponammoclip(var_3, var_12);

  foreach(var_3, var_12 in self._id_12EB0.brtruck_cleanupents)
  self setweaponammoclip(var_3, var_12, "_encstr_A5AD056A019C63");

  waitframe();

  if(isDefined(self._id_12EB0.super) && getdvarint("_encstr_BD8A1A026E05119A41682BBF98B97FEAE7F74FBDCD6169C36B5867C3", 1)) {
    var_16 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self._id_12EB0.super]];
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::forcegivesuper(var_16, 0);
  }

  if(isDefined(self._id_12EB0.vo_one_remain) && getdvarint("_encstr_8AF31F9B6C4EBEC9B26E3A7B2795EB637B5823F65D47AFDAA536639B3AC9562CAD", 1))
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::playerpackdataintogulagomnvar(self._id_12EB0.vo_one_remain);

  if(getdvarint("_encstr_8B741B5BEE4AC1061287B987AB3AD8E0FFC621509394093FDAB7A1ABB7", 1)) {
    self.should_use_velo_forward = self._id_12EB0.should_use_velo_forward;
    self setclientomnvar("_encstr_938B169BE839A29B18612F6F27B74219C8F19922C0B06B72", istrue(self.should_use_velo_forward));

    if(isDefined(self._id_12EB0.callprecisionairstrikeonlocation) && self._id_12EB0.callprecisionairstrikeonlocation > 0) {
      scripts\mp\equipment::giveequipment("_encstr_9A6E11F537232F9A3F7053BA18BD52F3191D7D", "_encstr_91B50734CA58631D1A");
      scripts\mp\equipment::setequipmentslotammo("_encstr_91B50734CA58631D1A", self._id_12EB0.callprecisionairstrikeonlocation);
    }
  }

  if(isDefined(self._id_12EB0.plundersilentcountdownendtime) && getdvarint("_encstr_B2851DABDFC219FD8FDA653F95CBCFDB48705A20634D3104178F0F41963B32", 1))
    scripts\cp_mp\gasmask::init(self._id_12EB0.gasmaskhealth, self._id_12EB0.plundersilentcountdownendtime);

  thread scripts\cp_mp\gestures::_id_13E1A();
  self._id_12EB0 = undefined;
}