/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_weapons.gsc
***********************************************/

createspawnweaponatpos(var_0, var_1, var_2) {
  var_3 = scripts\engine\trace::ray_trace(var_0, (var_0[0], var_0[1], var_0[2] - 60));
  var_4 = var_0;

  if(var_3["_encstr_A53009A25003666B9818C6"] < 1.0)
    var_4 = var_3["_encstr_BD260953AA97E3F014279D"] + (0, 0, 2);

  if(!isDefined(var_1))
    var_1 = (0, 0, 90);

  var_0 = var_4;

  if(isDefined(var_1))
    var_1 = var_1;
  else
    var_1 = (0, 0, 90);

  var_5 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::remove_roof_nodes(var_0, var_1);
  return weaponspawn(var_2, undefined, var_5, 1);
}

createspawnweaponatposfromname(var_0, var_1) {
  var_2 = var_0;
  var_3 = scripts\engine\trace::ray_trace(var_0, (var_0[0], var_0[1], var_0[2] - 60));

  if(var_3["_encstr_A53009A25003666B9818C6"] < 1.0)
    var_2 = var_3["_encstr_BD260953AA97E3F014279D"] + (0, 0, 2);

  var_4 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::remove_roof_nodes(var_0, (0, 0, 90));
  return weaponspawn(var_1, undefined, var_4, 1);
}

stripweaponsfromplayer() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in self.equippedweapons) {
    var_4 = scripts\mp\utility\weapon::getweaponrootname(var_3.basename);

    if(var_4 != "_encstr_A7ED0AD79F73990E28334B92" && var_4 != "_encstr_82200E7710825F228B4362D2DBEB8E1A" && var_4 != "_encstr_9A0D0C4B54606F8F63C84B8B53EE") {
      if(issameweapon(var_3) && var_3.inventorytype == "_encstr_BA7F0830B3A7859B60B0") {
        var_5 = scripts\mp\utility\weapon::getweaponrootname(self.currentprimaryweapon);

        if(var_4 == var_5)
          var_0 = var_3;
        else
          var_1 = var_3;
      }
    }
  }

  if(isDefined(var_0))
    var_7 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);

  if(isDefined(var_1))
    var_8 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

  if(isDefined(var_0) || isDefined(var_1)) {
    if(isDefined(var_0))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0, 1);

    if(isDefined(var_1))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1, 1);

    scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  }
}

playerdropweaponfrominventory(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in self.equippedweapons) {
    var_5 = scripts\mp\utility\weapon::getweaponrootname(var_4.basename);

    if(var_5 != "_encstr_A7ED0AD79F73990E28334B92" && var_5 != "_encstr_82200E7710825F228B4362D2DBEB8E1A") {
      if(issameweapon(var_4) && var_4.inventorytype == "_encstr_BA7F0830B3A7859B60B0") {
        var_6 = scripts\mp\utility\weapon::getweaponrootname(self.currentprimaryweapon);

        if(var_5 == var_6) {
          iprintln("_encstr_8AA30CF76A4969A7297759B36736" + var_5);
          var_1 = var_4;
        } else
          var_2 = var_4;
      }
    }
  }

  var_8 = undefined;
  var_9 = undefined;
  var_10 = "_encstr_B40101";
  var_11 = "_encstr_B40101";

  if(isDefined(var_1))
    var_10 = scripts\mp\utility\weapon::getweaponrootname(var_1.basename);

  if(isDefined(var_2))
    var_11 = scripts\mp\utility\weapon::getweaponrootname(var_2.basename);

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
    var_14 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::test_ai_anim();
    var_15 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::getitemdroporiginandangles(var_14, self.origin, self.angles, self);
    var_16 = weaponspawn(var_8, self, var_15, 0);
    var_16.count = var_13;
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_8);

    if(isDefined(var_9))
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_9);
    else {
      scripts\cp_mp\utility\inventory_utility::_giveweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
      scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
    }

    br_ammo_update_weapons(self);
  }
}

weaponspawn(var_0, var_1, var_2, var_3, var_4) {
  var_5 = createheadicon(var_0);
  var_6 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::spawnpickup(var_5, var_2, 0, var_4, var_0);
  level._id_120AD _calloutmarkerping_handleluinotify_acknowledgedcancel::from(var_6, var_1, var_0);
  return var_6;
}

takeweaponpickup(var_0) {
  var_1 = self.primaryweapons.size;

  if(!isDefined(var_0.weapon)) {
    var_2 = [];
    var_3 = undefined;

    if(isDefined(var_0.customweaponname)) {
      var_4 = var_0.customweaponname;
      var_3 = asmdevgetallstates(var_4);
      var_3.customweaponname = var_0.customweaponname;
    } else if(!isDefined(var_0.completeweapon)) {
      var_3 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::relic_vampire_globalfunc(var_0);
      var_4 = createheadicon(var_3);
    } else {
      var_3 = scripts\mp\class::buildweapon(var_0.loadoutprimaryfullname, var_2, "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
      var_4 = var_0.loadoutprimaryfullname;
    }

    if(!isDefined(var_4)) {
      scripts\mp\utility\script::laststand_dogtags("_encstr_BE8D3B63277A2DA7F248B04D8527D87222E763EAD8AB6280A3328A502A7AD26F7B5B882018A8C9D2284871F3D7D9B313FEEF18DB5973D8BBB89B833A26" + var_0.scriptablename);
      return;
    }

    var_5 = scripts\mp\utility\weapon::getweaponrootname(var_4);
    var_6 = var_4;
  } else {
    var_3 = var_0.weapon;

    if(isDefined(var_0.loadoutprimaryfullname))
      var_6 = var_0.loadoutprimaryfullname;
    else
      var_6 = getsubstr(var_3.classname, 7, var_3.classname.size);

    var_5 = scripts\mp\utility\weapon::getweaponrootname(var_6);
  }

  var_7 = 0;
  var_8 = undefined;
  var_9 = 0;

  foreach(var_11 in self.primaryweapons) {
    if(nullweapon(var_11)) {
      var_1--;
      continue;
    }

    if(isnullweapon(var_11, var_3)) {
      var_9 = 1;
      var_7 = 1;
      var_8 = var_11;
    }
  }

  if(var_1 > 1) {
    if(!self hasweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C"))
      var_7 = 1;
    else if(!var_9)
      self takeweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C");
  }

  if(var_7) {
    if(!isDefined(var_8))
      var_8 = router_use_obj();

    if(var_8.basename != "_encstr_8BBA05185F8B99") {
      var_13 = self getweaponammoclip(var_8);
      var_14 = self getweaponammoclip(var_8, "_encstr_A5AD056A019C63");
      var_15 = 0;

      if(var_8.hasalternate) {
        var_16 = var_8 getaltweapon();

        if(!debug_spawn_crate_on_train(var_8, var_16))
          var_15 = self getweaponammoclip(var_16);
      }

      if(!scripts\mp\riotshield::isriotshield(var_8)) {
        var_17 = self getweaponammostock(var_8);
        var_18 = br_ammo_type_for_weapon(var_8);

        if(isDefined(var_18))
          self.br_ammo[var_18] = var_17;
      }

      var_19 = var_0.origin - self.origin;
      var_20 = vectortoyaw(var_19);
      var_21 = !_encstr_8F4D2A4057AAF8318B1A2801B25657A1EDE7C09883557357D242681D883B85694BDB11407FED0BA9FE2F7616::operatorsfxalias(var_8);

      if(var_21) {
        if(isDefined(var_0.tracknonoobplayerlocation) && isDefined(var_0.tracknonoobplayerlocation._encstr_836A1AD7EB755703E973F2172F296BB26FF81B455CAF91807F19325B)) {
          var_22 = var_0.tracknonoobplayerlocation._encstr_836A1AD7EB755703E973F2172F296BB26FF81B455CAF91807F19325B;
          var_23 = strtok(var_8.basename, "_encstr_BA4C02DF");

          if(scripts\mp\class::update_health_bar_to_players(var_8) || var_23[1] == "_encstr_820703E04B")
            var_22 = var_22 + (0, 90, 0);
        } else
          var_22 = (0, var_20, 0);

        var_24 = _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::remove_roof_nodes(var_0.origin, var_22);
        var_25 = tablesort(var_24.origin, 500, 500);
        var_25[var_25.size] = self;
        var_26 = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1, 0, 1);
        var_27 = var_24.origin;
        var_28 = -1 * getdvarfloat("_encstr_A6E01526D9BEB6858726F6BDE8884EBD1C1295A576D01D", 2000.0);
        var_29 = var_24.origin + (0.0, 0.0, var_28);
        var_30 = scripts\engine\trace::ray_trace(var_27, var_29, var_25, var_26);

        if(var_30["_encstr_A53009A25003666B9818C6"] < 1.0)
          var_24.set_force_aitype_armored = var_30["_encstr_850E077B0BF30318B9"];

        var_31 = weaponspawn(var_8, self, var_24, 0);

        if(isDefined(var_0.tracknonoobplayerlocation) && isDefined(var_0.tracknonoobplayerlocation._encstr_915F1A88134FDF30BB419E9830FB79A737AAA0E8EB690FAB5F779308))
          var_31.origin = var_0.tracknonoobplayerlocation._encstr_915F1A88134FDF30BB419E9830FB79A737AAA0E8EB690FAB5F779308;

        if(isDefined(var_0.tracknonoobplayerlocation) && isDefined(var_0.tracknonoobplayerlocation._encstr_836A1AD7EB755703E973F2172F296BB26FF81B455CAF91807F19325B))
          var_31._encstr_836A1AD7EB755703E973F2172F296BB26FF81B455CAF91807F19325B = var_0.tracknonoobplayerlocation._encstr_836A1AD7EB755703E973F2172F296BB26FF81B455CAF91807F19325B;

        if(isDefined(var_31)) {
          _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::_id_119F5(var_31, var_13, var_14, var_15);
          var_32 = 1;
          _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_lootdrop(self, var_8.basename, var_32, var_13);
        }
      }

      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_8);
    }
  }

  self giveweapon(var_3);
  self notify("_encstr_AA630F0E968D5B2B915DE0DD5958E07B73", var_6, var_3);

  if(istrue(var_3.isweaponfromcrate) || istrue(var_0.isweaponfromcrate)) {
    var_33 = br_ammo_type_for_weapon(var_5);

    if(isDefined(var_33)) {
      var_34 = weaponclipsize(var_3);
      br_ammo_give_type(self, var_33, var_34);
    }
  } else {
    var_35 = var_0.count;
    var_36 = var_0.impulsefx;
    var_34 = weaponclipsize(var_3);
    var_37 = 0;

    if(var_35 > var_34) {
      var_37 = var_37 + (var_35 - var_34);
      var_35 = var_34;
    }

    if(var_36 > var_34) {
      var_37 = var_37 + (var_36 - var_34);
      var_36 = var_34;
    }

    self setweaponammoclip(var_3, var_35);
    self setweaponammoclip(var_3, var_36, "_encstr_A5AD056A019C63");

    if(var_37 > 0) {
      var_33 = br_ammo_type_for_weapon(var_3);

      if(isDefined(var_33))
        br_ammo_give_type(self, var_33, var_37);
    }

    if(var_3.hasalternate) {
      var_38 = var_0.impactfunc_fire;
      var_39 = var_3 getaltweapon();

      if(!debug_spawn_crate_on_train(var_3, var_39)) {
        var_40 = weaponclipsize(var_39);

        if(var_38 > var_40)
          var_38 = var_40;

        self setweaponammoclip(var_39, var_38);
      }
    }
  }

  var_3._id_12CC1 = undefined;
  br_ammo_update_weapons(self);
  self assignweaponprimaryslot(var_3);
  scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_3);
  scripts\mp\weapons::fixupplayerweapons(self, var_3);
  scripts\mp\weapons::updatelastweaponobj(var_3);

  if(isDefined(var_0.weapon) && isent(var_0.weapon))
    var_0.weapon delete();

  var_41 = undefined;

  foreach(var_43 in self.equippedweapons) {
    if(issameweapon(var_43) && var_43.inventorytype == "_encstr_BA7F0830B3A7859B60B0") {
      var_4 = createheadicon(var_43);

      if(var_4 == var_6) {
        var_41 = var_43;
        break;
      }
    }
  }

  thread _encstr_AAD224E6C69C2D383ADC5E5B1C5ED985B6593A97C195CD5E989CEB2795371CB0DD731776CDC6::giveweaponpickup(var_6);

  if(isDefined(var_0.tracknonoobplayerlocation))
    level._id_120AE _calloutmarkerping_handleluinotify_acknowledgedcancel::from(var_0.tracknonoobplayerlocation, self, var_3);
}

router_use_obj() {
  var_0 = self _meth_87D5();

  if(isDefined(var_0) && scripts\mp\weapons::isdroppableweapon(var_0)) {
    foreach(var_2 in self.primaryweapons) {
      if(isnullweapon(var_2, var_0))
        return var_0;
    }
  }

  return self.lastdroppableweaponobj;
}

takeammopickup(var_0) {
  var_1 = 0;

  if(var_0.scriptablename == "_encstr_A3990B9BEF05B561F85A488BD8") {
    var_2 = self getcurrentweapon().basename;
    var_3 = scripts\mp\utility\weapon::getweaponrootname(var_2);
    var_4 = weaponclipsize(var_2);
    var_5 = br_ammo_type_for_weapon(var_2);

    if(isDefined(var_5))
      var_1 = br_ammo_give_type(self, var_5, var_4);
  } else
    var_1 = br_ammo_give_type(self, var_0.scriptablename, var_0.count, 1);

  if(var_1) {
    var_0.count = var_1;
    var_6 = 1;
  } else
    var_6 = 0;

  return var_6;
}

br_forcegiveweapon(var_0, var_1, var_2) {
  if(!scripts\engine\utility::array_contains(level.br_pickups.br_lootguns, var_0))
    var_0 = degrees_to_radians();

  var_3 = spawnStruct();
  var_3.loadoutprimaryfullname = var_0;
  var_3.scriptablename = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_3.completeweapon = var_2;
  var_3.count = 0;
  var_3.impulsefx = 0;
  var_3.impactfunc_fire = 0;
  var_1 takeweaponpickup(var_3);
}

degrees_to_radians(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = "_encstr_AD07034A38";

  if(!isDefined(var_1))
    var_1 = "_encstr_879105B17BDAB5";

  var_2 = [];

  foreach(var_4 in level.br_pickups.br_lootguns) {
    if(issubstr(var_4, "_encstr_BA4C02DF" + var_0 + "_encstr_BA4C02DF")) {
      if(issubstr(var_4, "_encstr_BA4C02DF" + var_1))
        var_2[var_2.size] = var_4;
    }
  }

  return var_2[randomint(var_2.size)];
}

br_getweaponstartingclipammo(var_0) {
  var_1 = weaponclipsize(var_0);
  return int(var_1);
}

br_forcegivecustomweapon(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_0 hasweapon(var_1)) {
    var_0 scripts\mp\hud_message::showerrormessage("_encstr_857D1D57E1802A49CFD76D122D1BE0E95689E7DBD9246E40F7F427DE8F5F38");
    return 0;
  }

  var_6 = var_1 hasattachment("_encstr_B45E080DA3A03EDFD998", 1);
  var_7 = spawnStruct();
  var_7.weapon = var_1;
  var_7.loadoutprimaryfullname = var_2;
  var_7.scriptablename = var_3;
  var_7.origin = var_0.origin + (0, 0, 24);
  var_7.count = br_getweaponstartingclipammo(var_1);
  var_7.impulsefx = 0;
  var_7.impactfunc_fire = 0;

  if(var_6)
    var_7.count = 999;

  if(isDefined(var_4) && isDefined(var_5)) {
    var_8 = weaponclipsize(var_1);
    var_9 = int(ceil(var_8 * var_4));
    var_7.count = int(min(var_9, var_5));
  }

  if(scripts\mp\utility\weapon::turnexfiltoside(var_1))
    var_7.impulsefx = var_7.count;

  if(var_1.hasalternate) {
    var_10 = var_1 getaltweapon();

    if(!debug_spawn_crate_on_train(var_1, var_10)) {
      var_11 = weaponclipsize(var_10);
      var_7.impactfunc_fire = var_11;

      if(var_6)
        var_7.impactfunc_fire = 999;
    }
  }

  if(getdvarint("_encstr_A72C21B98D27EB3127EB392B5CD5596EE87DDCA39CAC0BD6A5E676F5772B0B83B7DCB9", 0) > 0)
    var_0 loadweaponsforplayer([var_7.loadoutprimaryfullname]);

  var_0 takeweaponpickup(var_7);

  if(var_1.hasalternate) {
    var_12 = var_1 getaltweapon();

    if(var_12.isalternate && scripts\mp\utility\weapon::attachmentmap_tobase(var_12.underbarrel) == "_encstr_BE9708CBAB13138857AD") {
      var_13 = weaponclipsize(var_12);
      var_14 = int(var_13);
      var_0 setweaponammoclip(var_12, var_14);
    }
  }

  return 1;
}

br_ammo_init() {
  level.br_ammo_types = [];
  level.br_ammo_types[0] = "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9";
  level.br_ammo_types[1] = "_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18";
  level.br_ammo_types[2] = "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD";
  level.br_ammo_types[3] = "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6";
  level.br_ammo_types[4] = "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014";
  level.br_ammo_clipsize["_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9"] = 30;
  level.br_ammo_clipsize["_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18"] = 8;
  level.br_ammo_clipsize["_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"] = 30;
  level.br_ammo_clipsize["_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6"] = 8;
  level.br_ammo_clipsize["_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"] = 1;
  level.br_ammo_max = [];
  level.br_ammo_omnvars = [];
  level.br_ammo_omnvars["_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9"] = "_encstr_958315D5A5BE4CE47DB9DAC2C6D885E46B377DC2DAB5ED";
  level.br_ammo_omnvars["_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18"] = "_encstr_8CD013AEB4BE319CD76E1AF6A33BABDCD758B55BBD";
  level.br_ammo_omnvars["_encstr_A1DA10351DC230A75D660995FF3DC77AFACD"] = "_encstr_8A801368C0D98DDB6F1F40FF6BABD94B69BF95DF92";
  level.br_ammo_omnvars["_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6"] = "_encstr_AC36125D2DBE8927F537735A1CCA93D7B06B6BBD";
  level.br_ammo_omnvars["_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014"] = "_encstr_835D123B0CAF5AAD31034547D21DAD0FC1808A9F";
}

br_ammo_player_init() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  thread br_ammo_player_reload_watch();
  thread br_ammo_player_hud_monitor();

  for(;;) {
    self waittill("_encstr_A1E00B25BA2FD7DBEA6085B830");

    if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
      var_0 = self getweaponslistprimaries();

      foreach(var_2 in var_0) {
        var_3 = weaponclipsize(var_2);

        if(isDefined(var_3)) {
          if(scripts\mp\utility\weapon::turnexfiltoside(var_2)) {
            self setweaponammoclip(var_2, var_3, "_encstr_A5AD056A019C63");
            self setweaponammoclip(var_2, var_3, "_encstr_8253060E2B5FE330");
            continue;
          }

          self setweaponammoclip(var_2, var_3);
        }
      }
    }

    foreach(var_6 in level.br_ammo_types) {
      if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
        self.br_ammo[var_6] = level.br_ammo_max[var_6];
        continue;
      }

      self.br_ammo[var_6] = 0;
    }

    br_ammo_update_weapons(self);
    br_ammo_player_hud_update_ammotype("_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9");
    br_ammo_player_hud_update_ammotype("_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18");
    br_ammo_player_hud_update_ammotype("_encstr_A1DA10351DC230A75D660995FF3DC77AFACD");
    br_ammo_player_hud_update_ammotype("_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6");
    br_ammo_player_hud_update_ammotype("_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014");
  }
}

delay_add_to_chopper_boss_drone_target_array() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A30108473FBA97C8D662")) {
    return;
  }
  br_ammo_give_type(self, "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9", 30, 0);
}

br_ammo_player_clear() {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A30108473FBA97C8D662")) {
    return;
  }
  foreach(var_1 in level.br_ammo_types)
  self.br_ammo[var_1] = 0;

  self notify("_encstr_B2110C63C02DC5E92388229F9D75");
}

debug_spawnallaccesscards() {
  var_0 = self;
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = br_ammo_type_for_weapon(var_3);

    if(isDefined(var_4)) {
      var_5 = var_0 getweaponammoclip(var_3, "_encstr_8253060E2B5FE330");
      var_6 = weaponclipsize(var_3);

      if(var_5 < var_6)
        return 0;

      if(var_3 hasattachment("_encstr_AD9C07E0478148252A", 1)) {
        var_7 = var_0 getweaponammoclip(var_3, "_encstr_A5AD056A019C63");

        if(var_7 < var_6)
          return 0;
      }

      if(!br_ammo_type_player_full(var_0, var_4))
        return 0;
    }
  }

  return 1;
}

debug_spawncover_badnodetest() {
  var_0 = self;
  var_1 = [];
  var_2 = var_0 getweaponslistprimaries();

  foreach(var_4 in var_2) {
    var_5 = br_ammo_type_for_weapon(var_4);

    if(isDefined(var_5)) {
      var_1[var_5] = "_encstr_8DE10C8C575B6BCB7D3B1663AE95";
      var_6 = weaponclipsize(var_4);
      var_0 setweaponammoclip(var_4, var_6);
    }
  }

  foreach(var_5, var_9 in var_1) {
    var_0.br_ammo[var_5] = level.br_ammo_max[var_5];
    var_0 br_ammo_player_hud_update_ammotype(var_5);
  }

  br_ammo_update_weapons(var_0);
}

br_ammo_type_player_full(var_0, var_1) {
  if(!isDefined(var_0.br_ammo) || !isDefined(var_0.br_ammo[var_1]))
    return 0;

  if(!isDefined(level.br_ammo_max[var_1]))
    return 0;

  return _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_0.br_ammo[var_1]) >= level.br_ammo_max[var_1];
}

br_ammo_give_type(var_0, var_1, var_2, var_3) {
  debug_spawnrewardstest(var_0, var_1);

  if(br_ammo_type_player_full(var_0, var_1))
    return var_2;

  if(!isDefined(var_0.br_ammo))
    var_0.br_ammo = [];

  if(!isDefined(var_0.br_ammo[var_1]))
    var_0.br_ammo[var_1] = 0;

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = 0;
  var_0.br_ammo[var_1] = var_0.br_ammo[var_1] + var_2;

  if(var_0.br_ammo[var_1] > level.br_ammo_max[var_1]) {
    if(var_3) {
      var_4 = var_0.br_ammo[var_1] - level.br_ammo_max[var_1];

      if(var_4 < level.br_ammo_clipsize[var_1])
        var_4 = 0;
    }

    var_0.br_ammo[var_1] = level.br_ammo_max[var_1];
  }

  var_0 br_ammo_player_hud_update_ammotype(var_1);
  debug_start_numbers_threaded(var_0, var_1);
  return var_4;
}

debug_spawnrewardstest(var_0, var_1) {
  if(!var_0 isreloading()) {
    return;
  }
  var_2 = var_0 getcurrentprimaryweapon();
  var_3 = br_ammo_type_for_weapon(var_2);

  if(isDefined(var_3) && var_1 == var_3)
    var_0.br_ammo[var_1] = var_0 getweaponammostock(var_2);
}

br_ammo_take_type(var_0, var_1, var_2) {
  if(var_0.br_ammo[var_1] <= 0)
    return 0;

  var_0.br_ammo[var_1] = var_0.br_ammo[var_1] - var_2;

  if(var_0.br_ammo[var_1] < 0)
    var_0.br_ammo[var_1] = 0;

  var_0 br_ammo_player_hud_update_ammotype(var_1);
  br_ammo_update_weapons(var_0);
  return 1;
}

br_ammo_player_hud_monitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    scripts\engine\utility::_id_143A8("_encstr_B2110C63C02DC5E92388229F9D75", "_encstr_AA630F0E968D5B2B915DE0DD5958E07B73", "_encstr_8C25132BF1EFA3BD18CF0BF75B30460B1849220259", "_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D", "_encstr_88DC177857A1B367527916ABCE6A4FD937D73050EB74A9198A");
    br_ammo_player_hud_update_ammotype("_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9");
    br_ammo_player_hud_update_ammotype("_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18");
    br_ammo_player_hud_update_ammotype("_encstr_A1DA10351DC230A75D660995FF3DC77AFACD");
    br_ammo_player_hud_update_ammotype("_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6");
    br_ammo_player_hud_update_ammotype("_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014");
  }
}

br_ammo_player_hud_update_ammotype(var_0, var_1) {
  if(isDefined(level.br_ammo_omnvars[var_0])) {
    if(!isDefined(self.br_ammo))
      self.br_ammo = [];

    if(!isDefined(self.br_ammo[var_0]))
      self.br_ammo[var_0] = 0;

    self setclientomnvar(level.br_ammo_omnvars[var_0], self.br_ammo[var_0]);
  }
}

br_ammo_update_weapons(var_0) {
  if(_encstr_9B64269B2F78B433CD93F6DA1B88B76E289B140961B87A06FEAB096201F1F7635059BD8B453B820F::unset_relic_aggressive_melee("_encstr_A30108473FBA97C8D662")) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = br_ammo_type_for_weapon(var_3);

    if(isDefined(var_4)) {
      var_5 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_0.br_ammo[var_4]);
      var_0 setweaponammostock(var_3, var_5);
    }
  }

  var_0 notify("_encstr_B2110C63C02DC5E92388229F9D75");
}

debug_start_numbers_threaded(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    var_5 = br_ammo_type_for_weapon(var_4);

    if(isDefined(var_5) && var_1 == var_5) {
      var_6 = _encstr_AB571C86E61BEB3B44E75A70D3271133328FFD0BBAC267883A8B5A283783::get_int_or_0(var_0.br_ammo[var_1]);
      var_0 setweaponammostock(var_4, var_6);
    }
  }

  var_0 notify("_encstr_B2110C63C02DC5E92388229F9D75");
}

br_ammo_type_for_weapon(var_0) {
  var_1 = undefined;
  var_2 = ["_encstr_88270B9BE59120260B9BFD6343", "_encstr_91A61237B5D5E076138B19AD32E7BC886D18898B", "_encstr_99F5126EACB12B36D16E2BB5D27D1673B7B3E40D", "_encstr_B24911F730CE4A7BF782E25DF5979103D1E03F", "_encstr_A32A0CD7C550DA8DE8803AC57BF0", "_encstr_99530EC29BE16B4239C38F2B17550AB9", "_encstr_853F14B2C1080D5265BFC7FF93980A5268A8AF3DDBF8", "_encstr_B8E10EB90D7DDC56C6B28DE858D547B7", "_encstr_B85A14DC2B1BAC8DD16E2BD6B4BE5BB4ADCA98274C26"];
  var_3 = ["_encstr_BE9708CBAB13138857AD", "_encstr_A3B40A839140B0937C150272", "_encstr_B8520EABB146A31B30CD474DFB68679A"];

  if(var_0.isalternate && isDefined(var_0.underbarrel) && !scripts\engine\utility::array_contains(var_2, var_0.underbarrel)) {
    if(scripts\engine\utility::array_contains(var_3, var_0.underbarrel))
      return undefined;
    else
      var_1 = "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195";
  } else
    var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  return debug_spawning(var_1, var_0.basename);
}

debug_spawning(var_0, var_1) {
  switch (var_0) {
    case "_encstr_BA2816DDB25807DE9BAF5B168D0D4BCDB2EB834BDC3A7B63":
    case "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36":
      if(isDefined(var_1) && var_1 == "_encstr_97F517F8C3B807B36797F54B904F9BE9D5DAB078BA43CF285B")
        return "_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18";
    case "_encstr_AF710BF4355A9195B0FF0AEAD0":
      return "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9";
    case "_encstr_87E60F77CA0BC1DB37BEE6D0DE47D9ABB9":
      return "_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18";
    case "_encstr_A3710BEEACC2E0B737EB36B676":
    case "_encstr_8E250FDD59C283DE37F5169BCD85BA1B1D":
    case "_encstr_9B65109F23E0F24FC016431A79258FEE4889":
      return "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD";
    case "_encstr_A1710B57AD31DBCDCDF1422A60":
    case "_encstr_8BBE0E9455B73BE7A5B1D020CA7ABB33":
      return "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6";
    case "_encstr_BDBF1277568507DEE67D0E9CED4DB21BA32DB195":
    case "_encstr_8D200E63B9A7DBC550975D5D99600FAA":
      return "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014";
  }

  return undefined;
}

trial_vehicle(var_0) {
  switch (var_0) {
    case "_encstr_AFD11231E4B1DEF6D1EB58B5B6DEF5A9188D16C6":
    case "_encstr_AD89139E43D9D0A8132FFF388B1A77DDC813C2E014":
    case "_encstr_ADD9109D2A4D28F89BB11198FA9FB8C2B2C9":
    case "_encstr_84DA105286BAFAFA6DF1A14B97D0EEA34B18":
    case "_encstr_A1DA10351DC230A75D660995FF3DC77AFACD":
      return 1;
  }

  return 0;
}

debug_spawn_crate_on_train(var_0, var_1) {
  var_2 = br_ammo_type_for_weapon(var_0);
  var_3 = br_ammo_type_for_weapon(var_1);
  return isDefined(var_2) && isDefined(var_3) && var_2 == var_3;
}

br_ammo_player_reload_watch() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    self waittill("_encstr_8A730DD6B72A37C984A7486847CA23");

    if(!isDefined(self)) {
      return;
    }
    if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
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
    if(!getdvarint("_encstr_8D321B6E1B397D07E4ACB6B03A6C437D2D9B9996CD2DD1567DB0D6DAF6", istrue(level._id_12857)) || scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B"))
      self.br_ammo[var_1] = self getweaponammostock(var_0);

    debug_start_numbers_threaded(self, var_1);
  }
}

denyascendmessagejugg(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_BE140DBB2B2CE0B773F5CC5AC9CA19");

  while(self isreloading())
    waitframe();
}

delay_delete_alerted_icon(var_0, var_1) {
  var_2 = self;

  if(!isDefined(var_1))
    var_1 = 1;

  var_3 = br_ammo_type_for_weapon(var_0);

  if(isDefined(var_3)) {
    var_4 = int(level.br_ammo_clipsize[var_3] * var_1);
    var_2.br_ammo[var_3] = int(clamp(var_2.br_ammo[var_3] + var_4, 0, level.br_ammo_max[var_3]));
  }

  debug_start_numbers_threaded(var_2, var_3);
}

delay_camera_normal(var_0, var_1) {
  var_2 = self;
  var_3 = br_ammo_type_for_weapon(var_0);

  if(isDefined(var_3))
    var_2.br_ammo[var_3] = int(clamp(var_2.br_ammo[var_3] + var_1, 0, level.br_ammo_max[var_3]));

  debug_start_numbers_threaded(var_2, var_3);
}

vandalize_attack_max_cooldown(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!issameweapon(var_0))
    return 0;

  if(nullweapon(var_0))
    return 0;

  if(scripts\mp\weapons::isfistweapon(var_0) || scripts\mp\utility\weapon::unset_relic_mythic(var_0) || scripts\mp\utility\weapon::update_health_bar_to_player(var_0))
    return 0;

  return 1;
}

deregistergasmaskscriptableatframeend() {
  if(istrue(level.debug_safehouse_regroup_start) && !_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::uniquelootitemid())
    return 1;
}

droptogroundmultitrace(var_0) {
  foreach(var_2 in var_0)
  zone_bounds(var_2, istrue(var_2.should_spawn_boss_one));
}

zone_bounds(var_0, var_1) {
  var_2 = br_ammo_type_for_weapon(var_0);
  var_3 = weaponstartammo(var_0);
  var_4 = weaponclipsize(var_0);
  var_5 = weaponmaxammo(var_0);
  var_6 = undefined;

  if(var_1)
    var_6 = var_5;
  else
    var_6 = var_3 - var_4;

  if(isDefined(var_2))
    br_ammo_give_type(self, var_2, var_6);
}