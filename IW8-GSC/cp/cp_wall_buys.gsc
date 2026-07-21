/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_wall_buys.gsc
***********************************************/

init() {
  level.wall_buys = [];
  level.magic_weapons = [];
  level.all_magic_weapons = [];
  level.craftable_weapons = [];
  level.pap = [];
  level.wall_weapon_list = [];
  parse_weapons_table();
  var_0 = spawnStruct();
  var_0.purchase_type = "_encstr_AD0D0879F956D035534B";
  var_0.model = "_encstr_AA241B639825D6B18184F06988DE36DDE01F9987D5021A9FDBDF911399";
  var_0.weaponname = "_encstr_8AFE12BA923B5DC078856737ADE510157B79D063";
  level.wall_buys["_encstr_8AFE12BA923B5DC078856737ADE510157B79D063"] = var_0;
  scripts\engine\utility::flag_init("_encstr_B2511478F308E109255D5BE717CFF44F6AA78CADD0D5");
}

create_default_struct(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_0 = int(var_0);
  var_5.weapon = var_1;

  if(var_4 != "_encstr_B40101")
    var_5.scopemodel = var_4;

  var_5.model = getweaponmodel(var_1);
  var_5.purchase_type = var_3;
  level.wall_buys[var_2] = var_5;
}

parse_weapons_table() {
  var_0 = 0;

  if(isDefined(level.coop_weapontable))
    var_1 = level.coop_weapontable;
  else
    var_1 = "_encstr_A34A16F19B26261059FF4BBB70BD2875C712A8B9E67F6678";

  for(;;) {
    var_2 = tablelookupbyrow(var_1, var_0, 0);

    if(var_2 == "_encstr_B40101") {
      break;
    }

    var_3 = tablelookupbyrow(var_1, var_0, 1);
    var_4 = tablelookupbyrow(var_1, var_0, 2);
    var_5 = tablelookupbyrow(var_1, var_0, 4);
    var_6 = tablelookupbyrow(var_1, var_0, 5);
    var_7 = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_8 = strtok(var_4, "_encstr_974C0246");

    foreach(var_10 in var_8) {
      switch (var_10) {
        case "_encstr_8F9E06C26033773B":
          level.craftable_weapons[var_7] = var_3;
          break;
        case "_encstr_8EA50608B23F2B80":
          level.magic_weapons[var_7] = getweaponbasename(var_3);
          level.all_magic_weapons[var_7] = var_3;
          break;
        case "_encstr_A7D708BA0E769358C859":
          level.pap[var_7] = var_3;
          break;
        case "_encstr_AFF605A3F9E16B":
        case "_encstr_AD0D0879F956D035534B":
          create_default_struct(var_2, var_3, var_7, var_10, var_6);
          break;
      }
    }

    var_0++;
  }
}

setup_player_weapon_models(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;
  var_5 = 6;
  var_0.weapon_build_models = [];
  var_0.rofweaponslist = [];
  var_0.weapon_passives = [];

  if(1) {
    var_0.weaponkitinitialized = 1;
    var_0 notify("_encstr_81BE245F04EF42BBEA8938A082827778BFB2655B6C83CEEF142381D84A9C09D09F54E34AFD2B");
    return;
  }

  if(scripts\cp\utility::map_check(2))
    var_6 = "_encstr_AAC0203EF0F0CE1BD7895B4A997D87E34FCCF52942F06087C8A88DADC59F88A1A7AE";
  else if(scripts\cp\utility::map_check(3))
    var_6 = "_encstr_ABCC1FD807CB3607EB3A7BEE377DDDB01B8DBEC4D597EBADED2395D8B9716C9BD9";
  else
    var_6 = "_encstr_AAF31AE7381ED052EF3388410846014DEB5EC0F803971A47229F4253";

  var_7 = 0;

  for(;;) {
    var_8 = tablelookupbyrow(var_6, var_7, var_2);

    if(var_8 == "_encstr_B40101") {
      break;
    }

    var_9 = "_encstr_8BBA05185F8B99";
    var_10 = "_encstr_8BBA05185F8B99";
    var_11 = "_encstr_8BBA05185F8B99";
    var_12 = -1;

    if(isDefined(var_8)) {
      var_13 = tablelookup(var_6, var_1, var_7, var_3);
      var_14 = tablelookup(var_6, var_1, var_7, var_4);
      var_15 = [];

      if(isDefined(var_13) && var_13 != "_encstr_B40101") {
        for(var_16 = 0; var_16 < var_5; var_16++) {
          var_17 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_8AA214B2256D10B35A53C1E3CF620629373EF968CBDC", "_encstr_BD42193DF6AD892DCA05D80BE559C9AB565838EDB9A6BD9195B1B9", var_13, "_encstr_B19A0BD803A4E10F42E50598BB", var_16);

          if(isDefined(var_17) && var_17 != "_encstr_8BBA05185F8B99")
            var_15[var_15.size] = var_17;
        }

        var_9 = scripts\cp\utility::getweaponcamo(var_13);
        var_10 = scripts\cp\utility::getweaponcosmeticattachment(var_13);
        var_11 = scripts\cp\utility::getweaponreticle(var_13);
        var_12 = scripts\cp\utility::getweaponpaintjobid(var_13);
      }

      var_0.weapon_build_models[var_8] = scripts\cp\utility::mpbuildweaponname(scripts\cp\utility::getweaponrootname(var_14), var_15, var_9, var_11, scripts\cp\utility::get_weapon_variant_id(var_0, var_14), self getentitynumber(), self.clientid, var_12, var_10);

      if(var_8 == "_encstr_8F1804CF3FA2")
        var_0 loadweaponsforplayer([var_0.weapon_build_models[var_8]], 1);

      var_18 = getweaponattachments(var_0.weapon_build_models[var_8]);

      foreach(var_17 in var_18) {
        if(issubstr(var_17, "_encstr_B61904397B33"))
          var_0.rofweaponslist[var_0.rofweaponslist.size] = getweaponbasename(var_0.weapon_build_models[var_8]);
      }
    }

    var_7++;
  }

  var_0.weaponkitinitialized = 1;
  var_0 notify("_encstr_81BE245F04EF42BBEA8938A082827778BFB2655B6C83CEEF142381D84A9C09D09F54E34AFD2B");
}

assign_weapons_to_structs() {
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(scripts\cp\utility::map_check(2))
    var_0 = "_encstr_AAC0203EF0F0CE1BD7895B4A997D87E34FCCF52942F06087C8A88DADC59F88A1A7AE";
  else if(scripts\cp\utility::map_check(3))
    var_0 = "_encstr_ABCC1FD807CB3607EB3A7BEE377DDDB01B8DBEC4D597EBADED2395D8B9716C9BD9";
  else
    var_0 = "_encstr_AAF31AE7381ED052EF3388410846014DEB5EC0F803971A47229F4253";

  if(!scripts\engine\utility::flag_exist("_encstr_B2511478F308E109255D5BE717CFF44F6AA78CADD0D5"))
    scripts\engine\utility::flag_init("_encstr_B2511478F308E109255D5BE717CFF44F6AA78CADD0D5");

  var_1 = [];
  var_2 = 0;

  for(;;) {
    var_3 = tablelookupbyrow(var_0, var_2, 1);

    if(var_3 == "_encstr_B40101") {
      break;
    }

    var_1[var_1.size] = var_3;
    var_2++;
  }

  var_4 = [];
  var_5 = scripts\engine\utility::getStructArray("_encstr_81010C2D9BE8B29C0B8D1D2DED37", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_7 in var_5) {
    if(isDefined(var_7.name) && var_7.name == "_encstr_ABDD094B1109F39158BB21") {
      var_4[var_4.size] = var_7;

      if(isDefined(var_7.target)) {
        if(istrue(var_7.already_used)) {
          continue;
        }
        var_8 = scripts\engine\utility::getStructArray(var_7.target, "_encstr_A16007A921A23B85E3");

        foreach(var_10 in var_8) {
          if(var_10 == var_7) {
            continue;
          }
          var_10.already_used = 1;
          var_10.parent_struct = var_7;
        }
      }
    }
  }

  while(level.players.size < 1)
    wait 0.05;

  var_13 = sortbydistance(var_4, level.players[0].origin);

  foreach(var_24, var_15 in var_13) {
    var_15.script_noteworthy = strtok(var_15.script_noteworthy, "_encstr_BE4C0295")[0];
    var_16 = var_15.script_noteworthy;
    var_17 = scripts\cp\utility::getrawbaseweaponname(var_15.script_noteworthy);
    var_18 = undefined;

    if(!isDefined(level.wall_buys[var_17])) {
      var_15.disabled = 1;
      continue;
    }

    if(!istrue(var_15.already_used)) {
      if(isDefined(var_15.target)) {
        var_19 = scripts\engine\utility::getStruct(var_15.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_20 = var_19.origin;
        var_21 = var_19.angles;
      } else {
        var_20 = var_15.origin;
        var_21 = var_15.angles;
      }

      for(var_2 = 0; var_2 < var_1.size; var_2++) {
        if(var_1[var_2] == var_17) {
          var_18 = var_2;
          break;
        }
      }

      if(isDefined(var_18))
        var_15.trigger = spawn("_encstr_97BA0EB936935AC11D7DDDAC0B07B79B", var_20, 0, 0, var_18);
      else {
        var_22 = (0, 0, 0);
        var_23 = (0, 0, 0);

        if(issubstr(var_15.script_noteworthy, "_encstr_92C90C99ED393B95339395AC3DCA")) {
          var_22 = (3.25, -18, 9.75);
          var_23 = (0, 0, -90);
        }

        if(isDefined(var_21))
          var_21 = var_21 + var_23;

        var_15.trigger = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_20 + var_22);

        if(isDefined(var_16))
          var_15.trigger setModel(level.wall_buys[var_17].model);
        else
          var_15.trigger setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      }

      if(isDefined(var_21))
        var_15.trigger.angles = var_21;

      var_15.trigger thread add_item_to_outline_watcher(var_15, var_15.trigger, var_16, var_17);
      level.wall_weapon_list[level.wall_weapon_list.size] = var_15.trigger;
    } else if(isDefined(var_15.parent_struct.trigger))
      var_15.trigger = var_15.parent_struct.trigger;
    else
      var_15 thread applyparentstructvalues(var_15);

    var_15.weapon = var_16;
  }

  scripts\engine\utility::flag_set("_encstr_B2511478F308E109255D5BE717CFF44F6AA78CADD0D5");
}

applyparentstructvalues(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  while(!isDefined(var_0.parent_struct.trigger))
    waitframe();

  var_0.trigger = var_0.parent_struct.trigger;
}

add_item_to_outline_watcher(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::flag("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF"))
    scripts\engine\utility::flag_wait("_encstr_8BA416297AC063070845C4D98B2F7FA1BBF78297FD679EAF");

  if(!isDefined(level.outline_weapon_watch_list)) {
    return;
  }
  var_1.cost = level.interactions[var_2].cost;
  var_1.struct = var_0;

  if(isDefined(var_3) && (issubstr(var_3, "_encstr_83BF0820F70B83E5E740") || issubstr(var_3, "_encstr_9BE008764102938025A5") || issubstr(var_3, "_encstr_ABCC07DA161D16E62C"))) {
    return;
  }
  if(!isDefined(var_0.script_parameters) || var_0.script_parameters != "_encstr_AD0D0879F956D035534B")
    level.outline_weapon_watch_list[level.outline_weapon_watch_list.size] = var_1;
}

item_pickup(var_0) {
  var_0 give_weapon_coop(self);
}

givevalidweapon(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_A10511BB565807ED37BE38BA4EB1A1B0DC2B8C");

  if(istrue(var_0.isusingsupercard))
    wait 0.5;

  var_2 = undefined;

  if(scripts\cp\cp_weapons::should_take_players_current_weapon(var_0)) {
    var_3 = var_0 scripts\cp\utility::getvalidtakeweapon();
    var_4 = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_0 takeweapon(var_3);

    if(isDefined(var_0.pap[var_4])) {
      var_0.pap[var_4] = undefined;
      var_0 notify("_encstr_A56D15C7BF3A174856E9C8E1CB0508D8B233636D5F82D5");
    }
  }

  var_5 = undefined;

  if(issameweapon(var_1))
    var_5 = var_1;
  else
    var_5 = asmdevgetallstates(var_1);

  var_6 = scripts\cp\utility::getrawbaseweaponname(var_5);
  var_0 scripts\cp\utility::take_fists_weapon(var_0);

  if(isDefined(var_0.weapon_build_models[var_6]))
    var_5 = asmdevgetallstates(var_0.weapon_build_models[var_6]);

  var_7 = getweaponattachments(var_5);
  var_8 = var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_5, undefined, var_7, undefined, undefined);
  var_5 = asmdevgetallstates(var_8);
  var_5 = var_0 scripts\cp\utility::_giveweapon(var_5, undefined, undefined, 0);
  var_9 = spawnStruct();
  var_9.lvl = 1;
  var_0.pap[var_6] = var_9;
  var_0 scripts\cp\cp_merits::processmerit("_encstr_B276149DEDC933D3D3A278E91361919F43CAA05B1F18");
  var_0 notify("_encstr_A56D15C7BF3A174856E9C8E1CB0508D8B233636D5F82D5");
  var_0 givemaxammo(var_5);
  var_0 switchtoweapon(var_5);
}

give_weapon_coop(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = 0;

  if(isDefined(var_0.trigger) && isDefined(var_0.trigger.cost))
    var_3 = var_0.trigger.cost;

  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = self getweaponslistprimaries();
  var_8 = var_7.size;
  var_9 = 3;
  var_10 = asmdevgetallstates(var_0.script_noteworthy);
  var_11 = scripts\cp\utility::getrawbaseweaponname(var_10);

  if(var_10.basename == "_encstr_B6271396DDCDD766DB27D9AC3393B256F4CA7D9EAD") {
    level.magic_weapons["_encstr_92C90C99ED393B95339395AC3DCA"] = "_encstr_A3CC269F80DB1F2297768F0754952AEDDA88CF2BB8809EFAC58417FF4653E2AA410B9B9B58A0C282";
    var_1 = 1;
  }

  if(scripts\cp\utility::weapon_is_dlc_melee(var_10))
    var_1 = 1;

  if(!scripts\cp\cp_weapon::has_weapon_variation(var_10)) {
    var_12 = scripts\cp\utility::getvalidtakeweapon();
    self.curr_weap = var_12;

    if(isDefined(var_12)) {
      var_2 = 1;
      var_13 = scripts\cp\utility::getrawbaseweaponname(var_12);

      if(scripts\cp\utility::has_special_weapon() && var_8 < var_9 + 1)
        var_2 = 0;

      foreach(var_15 in var_7) {
        if(var_15.isalternate)
          var_9++;
      }

      if(scripts\cp\utility::has_zombie_perk("_encstr_B6921259DD2AE8AF1FB2F1981A3BC591053FA5FB"))
        var_9++;

      if(var_7.size < var_9)
        var_2 = 0;

      if(var_2) {
        if(isDefined(self.pap[var_13])) {
          self.pap[var_13] = undefined;
          self notify("_encstr_A56D15C7BF3A174856E9C8E1CB0508D8B233636D5F82D5");
        }

        thread scripts\cp\cp_interaction::play_weapon_purchase_vo(var_0, self);
        self takeweapon(var_12);
      }
    }

    if(isDefined(self.weapon_build_models[var_11]))
      var_4 = self.weapon_build_models[var_11];
    else
      var_4 = var_0.weapon;

    if(scripts\cp\utility::is_consumable_active("_encstr_BEF80B4F27629151C06D536952") && !scripts\cp\utility::isnmlactive()) {
      var_17 = scripts\engine\utility::array_combine(getweaponattachments(var_4), ["_encstr_8A0D05B1400BA2"]);

      if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_11))
        var_6 = undefined;
      else if(isDefined(level.pap_1_camo))
        var_6 = level.pap_1_camo;

      switch (var_11) {
        case "_encstr_AB7E09E2881E27B4C85DA4":
          var_6 = "_encstr_8392077BDB70C5EA3F";
          break;
        case "_encstr_87D80B1A6182E9DF5DDD54432B":
          var_6 = "_encstr_869207668E020F8BFA";
          break;
        case "_encstr_82BB0BE8BF89C85EA32BE9C3DB":
          var_6 = "_encstr_9B92076C2CD67B91C4";
          break;
        case "_encstr_B62609371A9C594619569C":
          var_6 = "_encstr_8B92075E37537AA2F3";
          break;
      }

      var_18 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_4, undefined, var_17, undefined, var_6);
      var_19 = asmdevgetallstates(var_18);
      var_19 = scripts\cp\utility::_giveweapon(var_19, undefined, undefined, 1);
      var_20 = scripts\cp\utility::getrawbaseweaponname(var_19);
      scripts\cp\cp_merits::processmerit("_encstr_A14D13F01B27EDD0973A83F155F1A0BD87F30818F3");
      var_21 = spawnStruct();
      var_21.lvl = 2;
      self.pap[var_20] = var_21;
      scripts\cp\utility::notify_used_consumable("_encstr_BEF80B4F27629151C06D536952");
      scripts\cp\utility::take_fists_weapon(self);
    } else {
      if(!isDefined(var_4))
        var_4 = var_10;

      var_17 = getweaponattachments(var_4);
      var_18 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_4, undefined, var_17);
      var_19 = asmdevgetallstates(var_18);
      var_19 = scripts\cp\utility::_giveweapon(var_19, undefined, undefined, 1);
      self.itempicked = var_18;
      level.transactionid = randomint(100);
      scripts\cp\utility::take_fists_weapon(self);
      var_21 = spawnStruct();
      var_21.lvl = 1;
      self.pap[var_11] = var_21;
    }

    if(var_1) {
      var_0.trigger delete();
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    }

    self notify("_encstr_854710D77F30710F95196A31C3636F3450E9", var_19);
    scripts\cp\cp_merits::processmerit("_encstr_B276149DEDC933D3D3A278E91361919F43CAA05B1F18");
    self givemaxammo(var_19);
    self notify("_encstr_A56D15C7BF3A174856E9C8E1CB0508D8B233636D5F82D5");
    self switchtoweapon(var_19);
    wait 0.25;

    while(self isswitchingweapon())
      wait 0.05;

    thread scripts\cp\cp_vo::try_to_play_vo("_encstr_9B65109803783653479352F9FBADAF2A388D", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_BE19041BDEDD", 10, 0, 1, 0, 50);
  } else {
    self.purchasing_ammo = 1;
    var_11 = undefined;
    var_22 = self getweaponslistall();
    var_23 = scripts\cp\utility::getrawbaseweaponname(var_10);
    var_24 = undefined;

    foreach(var_26 in var_22) {
      var_11 = scripts\cp\utility::getrawbaseweaponname(var_26);

      if(var_11 == var_23) {
        var_24 = var_26;
        break;
      }
    }

    var_28 = weaponmaxammo(var_24);
    var_29 = scripts\cp\perks\cp_prestige::prestige_getminammo();
    var_30 = int(var_29 * var_28);
    var_31 = self getweaponammostock(var_24);

    if(var_31 < var_30)
      self setweaponammostock(var_24, var_30);

    thread scripts\cp\cp_vo::try_to_play_vo("_encstr_A1A00D923B4952F97188D737D068BF", "_encstr_BE470F2AF901379E9F50E27A50F1D9DB18", "_encstr_BE19041BDEDD", 10, 0, 1, 1, 50);
  }

  self notify("_encstr_A10511BB565807ED37BE38BA4EB1A1B0DC2B8C");
  wait 0.05;
  self.purchasing_ammo = undefined;
  scripts\cp\cp_interaction::refresh_interaction();
}

reset_special_ammo(var_0) {
  if(isDefined(self.special_ammocount_ap))
    self.special_ammocount_ap = undefined;

  if(isDefined(self.special_ammocount_in))
    self.special_ammocount_in = undefined;

  if(isDefined(self.special_ammocount_explo))
    self.special_ammocount_explo = undefined;

  if(isDefined(self.special_ammocount_comb))
    self.special_ammocount_comb = undefined;

  if(isDefined(self.special_ammocount))
    self.special_ammocount = undefined;
}

give_pistol_ammo_if_nerf_active() {
  if(scripts\cp\perks\cp_prestige::prestige_getnodeployables() == 1) {
    var_0 = self getweaponslistprimaries();

    foreach(var_2 in var_0) {
      var_3 = var_2.classname;

      if(var_3 == "_encstr_ABC90E77AC5883F6DCBE38A5CD1D7B36") {
        var_4 = weaponmaxammo(var_2);
        var_5 = int(var_4 * 0.25);
        var_6 = self getammocount(var_2);

        if(var_5 > var_6)
          self setweaponammostock(var_2, var_5);
      }
    }
  }
}

get_weapon_ref(var_0) {
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_4 = scripts\cp\cp_persistence::get_base_weapon_name(var_3);

    if(issubstr(var_0, var_4))
      return var_3;
  }

  return undefined;
}

get_replaceable_weapon() {
  var_0 = self getweaponslistprimaries();
  var_1 = 3;

  foreach(var_3 in var_0) {
    if(var_3.isalternate)
      var_1++;
  }

  if(scripts\cp\utility::has_zombie_perk("_encstr_B6921259DD2AE8AF1FB2F1981A3BC591053FA5FB"))
    var_1++;

  if(var_0.size >= var_1) {
    var_5 = self getcurrentweapon();
    var_6 = 0;

    if(nullweapon(var_5))
      var_6 = 1;
    else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_5))
      var_6 = 1;
    else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_5 getbaseweapon()))
      var_6 = 1;
    else if(scripts\cp\utility::is_melee_weapon(var_5, 1))
      var_6 = 1;

    if(var_6) {
      self.copy_fullweaponlist = self getweaponslistall();
      var_5 = scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
    }

    self.copy_fullweaponlist = undefined;

    if(weaponinventorytype(var_5) == "_encstr_B4DC085639F9C2779108")
      var_5 = var_5 getaltweapon();

    return var_5;
  }

  return undefined;
}

get_weapon_name_from_alt(var_0) {
  if(weaponinventorytype(var_0) != "_encstr_B4DC085639F9C2779108")
    return var_0;

  return getsubstr(var_0, 4);
}

can_give_weapon(var_0) {
  var_1 = self getweaponslistprimaries();
  var_2 = self getcurrentweapon();
  var_3 = var_2.classname;
  var_4 = scripts\cp\utility::getbaseweaponname(var_2);

  foreach(var_0 in var_1) {
    if(var_0.isalternate)
      var_1 = scripts\engine\utility::array_remove(var_1, var_0);
  }

  var_7 = 0;

  if(!scripts\cp\utility::has_zombie_perk("_encstr_B6921259DD2AE8AF1FB2F1981A3BC591053FA5FB"))
    var_8 = 3;
  else
    var_8 = 4;

  if(isDefined(self.numadditionalprimaries))
    var_8 = var_8 + self.numadditionalprimaries;

  while(self isswitchingweapon())
    wait 0.05;

  if(nullweapon(var_2))
    return 0;

  if(isDefined(level.custom_cangive_weapon_func)) {
    if(![[level.custom_cangive_weapon_func]](var_1, var_2, var_3, var_8))
      return 0;
  }

  if(isDefined(scripts\cp\utility::has_special_weapon()) && scripts\cp\utility::has_special_weapon())
    return 0;

  if(var_1.size >= var_8 + 1 && self.hasriotshield)
    return 0;

  if(var_1.size >= var_8 + 2 && self.hasriotshield)
    return 0;

  if(var_1.size >= var_8 + 1 && !self.hasriotshieldequipped)
    return 0;

  if(var_1.size >= var_8 + 2 && self.hasriotshieldequipped)
    return 0;

  if(self.hasriotshieldequipped && var_1.size >= var_8 + 1)
    return 0;

  if(self.hasriotshieldequipped && var_1.size >= var_8 + 1)
    return 0;

  if(!scripts\cp\utility::is_holding_deployable())
    return 1;
  else
    return 0;

  return 0;
}

interaction_purchase_weapon(var_0, var_1) {
  if(scripts\cp\utility::is_weapon_purchase_disabled()) {
    return;
  }
  var_0 item_pickup(var_1);
  var_1.last_interaction_point = undefined;
}

get_wall_buy_hint_func(var_0, var_1) {
  if(scripts\cp\utility::is_weapon_purchase_disabled())
    return &"_encstr_A59A26552A1F91E1682FCBFD3B205681DBB39C2C45BB82A4300BC9D78BC91B29B45C4765FEDC99F5";

  if(!var_1 can_give_weapon(var_0))
    return &"_encstr_8F7C1D5625F45106A1DB79F98381DD01085D58C69578BBEC5EC74131BBCD56";

  var_2 = [[level.weapon_hint_func]](var_0, var_1);

  if(isDefined(var_2))
    return var_2;

  var_3 = getweaponbasename(var_0.script_noteworthy);
  return level.interaction_hintstrings[var_3];
}

set_weapon_purchase_disabled(var_0) {
  level.weapon_purchase_disabled = var_0;
}