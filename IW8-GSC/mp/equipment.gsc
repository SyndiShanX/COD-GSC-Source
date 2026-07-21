/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\equipment.gsc
***********************************************/

init() {
  level.equipment = spawnStruct();
  inititems();
  loadtable();
  timeoflastexecute();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::equiponplayerspawned);
}

inititems() {
  level.equipment.callbacks = [];
  var_0 = level.equipment;
  scripts\mp\equipment_interact::equipmentinteract_init();

  if(!istrue(game["_encstr_AA010E901794F93B2A1E8B16B4F345E0"])) {
    scripts\mp\perks\headgear::init();
    scripts\mp\equipment\tactical_cover::tac_cover_init();
    scripts\mp\equipment\trophy_system::trophy_init();
    scripts\mp\equipment\decoy_grenade::decoy_init();
    _donewithcorpse::vehicle_compass_setteamfriendlyto();
    _encstr_A31921E61B9CA583E86E5E5B1CCBAC5CAED2835B2B73D1CB9BB1B4CDB39539173B9B36::_encstr_ADB30DDBB0A4C8978543B180029714();
    scripts\mp\equipment\at_mine::at_mine_init();
    scripts\mp\equipment\tac_insert::tacinsert_init();
  }

  scripts\mp\equipment\claymore::claymore_init();
  scripts\mp\equipment\molotov::molotov_init();
  _debug_rooftop_raid_exfil::emp_init();
  scripts\mp\equipment\weapon_drop::weapondrop_init();
  scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
  _encstr_B1B12957D332E09F73AB702083C6DDE80B21D9F37D9D504873E330C93A9B8EE127920B7DE14710176FFBC9::init();
  var_0.callbacks["_encstr_AB960DC007AFE8A837F8D5C8C0732B"]["_encstr_BA6F07F2708FA42359"] = scripts\mp\perks\headgear::runheadgear;
  var_0.callbacks["_encstr_AB960DC007AFE8A837F8D5C8C0732B"]["_encstr_ABCE07DBE61516B6AC"] = scripts\mp\perks\headgear::removeheadgear;
  var_0.callbacks["_encstr_820F114AE740032B7F8680CAD930B1D239F212"]["_encstr_8EE208B7DCC82D4E958C"] = scripts\mp\equipment\adrenaline::onequipmentfired;
  var_0.callbacks["_encstr_820F114AE740032B7F8680CAD930B1D239F212"]["_encstr_ABCE07DBE61516B6AC"] = scripts\mp\equipment\adrenaline::onequipmenttaken;
  var_0.callbacks["_encstr_843D095F2B7D52B041D9A3"]["_encstr_BA6F07F2708FA42359"] = scripts\mp\equipment\c4::c4_set;
  var_0.callbacks["_encstr_AA870D15FAF37393C74318F8BB184A"]["_encstr_BA6F07F2708FA42359"] = scripts\mp\equipment\trophy_system::trophy_set;
  var_0.callbacks["_encstr_AA870D15FAF37393C74318F8BB184A"]["_encstr_ABCE07DBE61516B6AC"] = scripts\mp\equipment\trophy_system::trophy_unset;
  var_0.callbacks["_encstr_881C1456B8BAB438FA46958DB7CDD7E6E80B47A5DB37"]["_encstr_ABCE07DBE61516B6AC"] = _debug_rooftop_heli_start::jugg_go_to_node_callback;
  var_0.callbacks["_encstr_881C1456B8BAB438FA46958DB7CDD7E6E80B47A5DB37"]["_encstr_BA6F07F2708FA42359"] = _debug_rooftop_heli_start::jugg_getminigunweapon;
  var_0.callbacks["_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381"]["_encstr_BA6F07F2708FA42359"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var_0.callbacks["_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381"]["_encstr_ABCE07DBE61516B6AC"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var_0.callbacks["_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC"]["_encstr_BA6F07F2708FA42359"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var_0.callbacks["_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC"]["_encstr_ABCE07DBE61516B6AC"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var_0.callbacks["_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B"]["_encstr_BA6F07F2708FA42359"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var_0.callbacks["_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B"]["_encstr_ABCE07DBE61516B6AC"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var_0.callbacks["_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1"]["_encstr_BA6F07F2708FA42359"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  var_0.callbacks["_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1"]["_encstr_ABCE07DBE61516B6AC"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  var_0.callbacks["_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9"]["_encstr_BA6F07F2708FA42359"] = scripts\mp\equipment\molotov::molotov_on_give;
  var_0.callbacks["_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9"]["_encstr_ABCE07DBE61516B6AC"] = scripts\mp\equipment\molotov::molotov_on_take;
  var_0.callbacks["_encstr_867010E842EB0B29AF8B8886074E3F2CB506"]["_encstr_BA6F07F2708FA42359"] = scripts\mp\equipment\tactical_cover::tac_cover_on_give;
  var_0.callbacks["_encstr_867010E842EB0B29AF8B8886074E3F2CB506"]["_encstr_ABCE07DBE61516B6AC"] = scripts\mp\equipment\tactical_cover::tac_cover_on_take;
  var_0.callbacks["_encstr_867010E842EB0B29AF8B8886074E3F2CB506"]["_encstr_8EE208B7DCC82D4E958C"] = scripts\mp\equipment\tactical_cover::tac_cover_on_fired;
  var_0.callbacks["_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A"]["_encstr_BA6F07F2708FA42359"] = scripts\mp\equipment\tac_insert::tacinsert_set;
  var_0.callbacks["_encstr_887E11568BD5A51CFA471636D7A5E66E56C93A"]["_encstr_ABCE07DBE61516B6AC"] = scripts\mp\equipment\tac_insert::tacinsert_unset;
  var_0.callbacks["_encstr_8E5B11B2E2AE4BC1FA134BDCDB1B5D36C227DC"]["_encstr_BA6F07F2708FA42359"] = _debug_rooftop_activesat::closeobjectiveiconid;
  var_0.callbacks["_encstr_8E5B11B2E2AE4BC1FA134BDCDB1B5D36C227DC"]["_encstr_ABCE07DBE61516B6AC"] = _debug_rooftop_activesat::codeloc;
  var_0.callbacks["_encstr_B24B12B7A88B412B8F84669AE0974315B0800B3F"]["_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9"] = scripts\mp\equipment\gas_grenade::gas_onplayerdamaged;
  var_0.callbacks["_encstr_BD170C5B689B786221E98009A80C"]["_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9"] = scripts\mp\equipment\flash_grenade::onplayerdamaged;
  var_0.callbacks["_encstr_AD0B110A20CB30F897F120B0BBDB76DBE8D81E"]["_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9"] = scripts\mp\equipment\concussion_grenade::onplayerdamaged;
  var_0.callbacks["_encstr_BDF90F4D9F8B8702A7B08A52682BBC0B61"]["_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9"] = scripts\mp\equipment\thermite::thermite_onplayerdamaged;
  var_0.callbacks["_encstr_B6C70ECA2EEAB4C1BED67BC6DE8EBDD9"]["_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9"] = scripts\mp\equipment\molotov::molotov_on_player_damaged;
  var_0.callbacks["_encstr_870C1695175DB438AFE6575B4CAC4ECDBECE93ACCDC2C895"]["_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9"] = _encstr_B1B12957D332E09F73AB702083C6DDE80B21D9F37D9D504873E330C93A9B8EE127920B7DE14710176FFBC9::_encstr_8184128746694B38EFF3D39561A02FB0E11FF75C;
  var_0.callbacks["_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95"]["_encstr_849F0F8868FFF7CDC716ADC86708494AD9"] = scripts\mp\equipment\at_mine::at_mine_onownerchanged;
  var_0.callbacks["_encstr_82A70F2B3B73E33B472371FF21D7809DDF"]["_encstr_849F0F8868FFF7CDC716ADC86708494AD9"] = scripts\mp\equipment\claymore::claymore_onownerchanged;
  var_0.callbacks["_encstr_843D095F2B7D52B041D9A3"]["_encstr_849F0F8868FFF7CDC716ADC86708494AD9"] = scripts\mp\equipment\c4::c4_onownerchanged;
  var_0.callbacks["_encstr_87560DB2E25D2D07EB4D85B5D65693"]["_encstr_849F0F8868FFF7CDC716ADC86708494AD9"] = _donewithcorpse::vehicle_compass_updateallvisibilityforplayer;
  var_0.callbacks["_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95"]["_encstr_BA6C14F27089A7377BD687996541CBE801087A7B28AB"] = scripts\mp\equipment\at_mine::at_mine_delete;
  var_0.callbacks["_encstr_82A70F2B3B73E33B472371FF21D7809DDF"]["_encstr_BA6C14F27089A7377BD687996541CBE801087A7B28AB"] = scripts\mp\equipment\claymore::claymore_delete;
  var_0.callbacks["_encstr_AA870D15FAF37393C74318F8BB184A"]["_encstr_BA6C14F27089A7377BD687996541CBE801087A7B28AB"] = scripts\mp\equipment\trophy_system::trophy_delete;
  var_0.callbacks["_encstr_843D095F2B7D52B041D9A3"]["_encstr_BA6C14F27089A7377BD687996541CBE801087A7B28AB"] = scripts\mp\equipment\c4::c4_delete;
  var_0.callbacks["_encstr_A15317C13205384F894F55535B939BC0BC0109BB5F76200D02"]["_encstr_BA6C14F27089A7377BD687996541CBE801087A7B28AB"] = scripts\mp\equipment\snapshot_grenade::snapshot_grenade_delete;
  thread watchlethaldelay();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onownerdisconnect);
}

getcallback(var_0, var_1) {
  if(!isDefined(level.equipment.callbacks[var_0]))
    return undefined;

  return level.equipment.callbacks[var_0][var_1];
}

loadtable() {
  level.equipment.table = [];
  var_0 = 1;

  for(;;) {
    var_1 = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 1);

    if(!isDefined(var_1) || var_1 == "_encstr_B40101") {
      break;
    }

    var_2 = tolower(var_1);
    var_3 = spawnStruct();
    var_3.ref = var_2;
    var_4 = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 6);

    if(var_4 != "_encstr_8BBA05185F8B99") {
      var_5 = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 19);
      var_6 = undefined;

      if(var_5 != "_encstr_B40101") {
        var_7 = getcompleteweaponname(var_4);

        if(!nullweapon(var_7))
          var_6 = [var_5];
      }

      var_3.objweapon = getcompleteweaponname(var_4, var_6);
    }

    var_3.id = var_0;
    var_3.image = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 4);
    var_3.defaultslot = scripts\engine\utility::ter_op(tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 7) == "_encstr_A74C0222", "_encstr_AC8F0AE74163F85AAA380AD8", "_encstr_BA7F0830B3A7859B60B0");
    var_3.scavengerammo = int(tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 10));
    var_3.ispassive = tolower(tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 11)) == "_encstr_AAEF05B83B43EB";
    var_3.usecellspawns = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 8) != "_encstr_B10703DD0F";
    var_8 = tablelookupbyrow("_encstr_A33111305B95AB4BBF194FC9ED2B13F56EF360", var_0, 12);

    if(var_8 == "_encstr_8BBA05185F8B99") {} else if(var_8 == "_encstr_B40101") {
      if(var_4 != "_encstr_8BBA05185F8B99")
        var_3.damageweaponnames = [var_4];
    } else {
      var_9 = [];

      if(var_4 != "_encstr_8BBA05185F8B99")
        var_9[var_9.size] = var_4;

      var_10 = strtok(var_8, "_encstr_974C0246");

      foreach(var_12 in var_10)
      var_9[var_9.size] = var_12;

      var_3.damageweaponnames = var_9;
    }

    level.equipment.table[var_2] = var_3;
    var_0++;
  }
}

getequipmenttableinfo(var_0) {
  return level.equipment.table[var_0];
}

giveequipment(var_0, var_1) {
  if(!isDefined(self.equipment))
    self.equipment = [];

  if(var_0 == "_encstr_8BBA05185F8B99") {
    return;
  }
  var_2 = getequipmenttableinfo(var_0);

  if(!isDefined(var_2))
    scripts\mp\utility\script::laststand_dogtags("_encstr_BD8328EDDBBCE079D30B33356FFE3D6820F71083075028A01A7B071FB3268DD00DCCBB78AF76984F562A" + var_0 + "_encstr_B20C0EE1C26044A58990A2989DD789A6" + var_1);
  else {
    if(var_1 == "_encstr_BEB406F03B72BB3B") {
      var_3 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[var_0]];
      var_2.id = scripts\mp\supers::getsuperid(var_3);
    }

    takeequipment(var_1);

    if(isDefined(var_2.objweapon)) {
      self giveweapon(var_2.objweapon);

      if(is_equipment_slot_allowed(var_1) && !var_2.ispassive) {
        if(var_1 == "_encstr_BA7F0830B3A7859B60B0")
          self assignweaponoffhandprimary(var_2.objweapon);
        else if(var_1 == "_encstr_AC8F0AE74163F85AAA380AD8")
          self assignweaponoffhandsecondary(var_2.objweapon);
        else if(var_1 == "_encstr_BEB406F03B72BB3B")
          self assignweaponoffhandspecial(var_2.objweapon);
      }
    }

    sethudslot(var_1, var_2.id);
    self.equipment[var_1] = var_0;
    var_4 = getcallback(var_0, "_encstr_BA6F07F2708FA42359");

    if(isDefined(var_4))
      self thread[[var_4]](var_0, var_1);

    updateuiammocount(var_1);
    var_5 = var_0 == "_encstr_952115DD01A75899A9C3C8936A7B6370578752C0618381" || var_0 == "_encstr_841F1AB2B8AE5AE07D471A27EDDD5A7376F5B6B996CCB2D7669693AC" || var_0 == "_encstr_AFBF1E59C5BA5A83BED1D027DBDD2DDCD9BEADDC4B99ACAFCAB1ACD8A393961B" || var_0 == "_encstr_978E1B7AA0C37CE3F62D787A481B4F451F390242D84D3727C916716CD1";

    if(scripts\mp\utility\game::getgametype() == "_encstr_A9B606B0C956B916" && var_5) {
      return;
    }
    thread watchlethaldelayplayer(var_0, var_1);
  }
}

takeequipment(var_0) {
  var_1 = getcurrentequipment(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = getequipmenttableinfo(var_1);

  if(isDefined(var_2.objweapon)) {
    if(self hasweapon(var_2.objweapon)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2.objweapon);

      if(var_0 == "_encstr_BA7F0830B3A7859B60B0")
        self clearoffhandprimary();
      else if(var_0 == "_encstr_AC8F0AE74163F85AAA380AD8")
        self clearoffhandsecondary();
    }
  }

  sethudslot(var_0, 0);
  self.equipment[var_0] = undefined;
  var_3 = getcallback(var_1, "_encstr_ABCE07DBE61516B6AC");

  if(isDefined(var_3))
    self thread[[var_3]](var_1, var_0);

  updateuiammocount(var_0);
  self notify("_encstr_961111A5B00BE03947D8A33BC1039F3030F5BF" + var_1);
}

equiponplayerdamaged(var_0) {
  var_1 = var_0.objweapon.basename;

  foreach(var_10, var_3 in level.equipment.table) {
    var_4 = getcallback(var_10, "_encstr_A6FE1037D0F9C851EBBD03DD61CD095F1FF9");

    if(isDefined(var_4) && isDefined(var_3.damageweaponnames)) {
      foreach(var_6 in var_3.damageweaponnames) {
        if(var_6 == var_1) {
          var_7 = gettime();
          var_8 = [[var_4]](var_0);
          return var_8;
        }
      }
    }
  }
}

ondestroyedbytrophy() {
  if(isDefined(self.equipmentref)) {
    var_0 = getcallback(self.equipmentref, "_encstr_BA6C14F27089A7377BD687996541CBE801087A7B28AB");

    if(isDefined(var_0)) {
      self thread[[var_0]]();
      return 1;
    } else if(scripts\mp\weapons::isplantedequipment(self)) {
      thread scripts\mp\weapons::deleteexplosive();
      return 1;
    }
  }

  return 0;
}

disableslotinternal(var_0) {
  if(var_0 == "_encstr_BA7F0830B3A7859B60B0")
    self clearoffhandprimary();
  else if(var_0 == "_encstr_AC8F0AE74163F85AAA380AD8")
    self clearoffhandsecondary();
  else if(var_0 == "_encstr_BEB406F03B72BB3B")
    self clearoffhandspecial();
}

enableslotinternal(var_0) {
  var_1 = getcurrentequipment(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = getequipmenttableinfo(var_1);

  if(isDefined(var_2.objweapon) && !var_2.ispassive && self hasweapon(var_2.objweapon)) {
    if(var_0 == "_encstr_BA7F0830B3A7859B60B0")
      self assignweaponoffhandprimary(var_2.objweapon);
    else if(var_0 == "_encstr_AC8F0AE74163F85AAA380AD8")
      self assignweaponoffhandsecondary(var_2.objweapon);
    else if(var_0 == "_encstr_BEB406F03B72BB3B")
      self assignweaponoffhandspecial(var_2.objweapon);
  }
}

allow_equipment(var_0, var_1) {
  allow_equipment_slot("_encstr_BA7F0830B3A7859B60B0", var_0, var_1);
  allow_equipment_slot("_encstr_AC8F0AE74163F85AAA380AD8", var_0, var_1);
}

allow_equipment_slot(var_0, var_1, var_2) {
  var_3 = scripts\common\input_allow::allow_input_internal("_encstr_A15A0B8549EF10A11D1A20F891" + var_0, var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }
  if(var_1)
    enableslotinternal(var_0);
  else
    disableslotinternal(var_0);
}

is_equipment_slot_allowed(var_0) {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_A15A0B8549EF10A11D1A20F891" + var_0);
}

sethudslot(var_0, var_1) {
  if(var_0 != "_encstr_BEB406F03B72BB3B")
    self setclientomnvar("_encstr_864011EBA7F1B580654C13887756E0E0CAFBC7" + var_0, var_1);
  else
    self setclientomnvar("_encstr_BE551757D2BEC1B227AD7D0E2CB1B6169DCABECDBAE0B23913", var_1);
}

getcurrentequipment(var_0) {
  if(!isDefined(self.equipment))
    return undefined;

  return self.equipment[var_0];
}

clearallequipment() {
  if(!isDefined(self.equipment)) {
    return;
  }
  foreach(var_2, var_1 in self.equipment)
  takeequipment(var_2);
}

getequipmentmaxammo(var_0) {
  var_1 = getequipmenttableinfo(var_0);

  if(!isDefined(var_1))
    return undefined;

  if(!isDefined(var_1.objweapon))
    return 0;

  if(level.gametype != "_encstr_B607038AAB") {
    var_2 = scripts\mp\utility\perk::_hasperk("_encstr_86501BA373482BFBE0426B73E9035853F8AE60DA1438E238F25F4D8010");
    var_3 = weaponmaxammo(var_1.objweapon, var_2);

    switch (var_0) {
      case "_encstr_A78210CAB8D5A507FAA198F5CD2BCDE6BD93":
      case "_encstr_8E5B11B2E2AE4BC1FA134BDCDB1B5D36C227DC":
      case "_encstr_867010E842EB0B29AF8B8886074E3F2CB506":
        break;
      default:
        var_3--;
        break;
    }

    var_4 = findequipmentslot(var_0);

    if(isDefined(var_4) && scripts\mp\utility\perk::_hasperk("_encstr_84D117B3C285F853FA4311F3774223884A1EBEE92FE9B89953") && var_4 == "_encstr_BA7F0830B3A7859B60B0")
      var_3++;
  } else {
    var_5 = level.br_pickups.br_equipnametoscriptable[var_1.ref];
    var_3 = level.br_pickups.maxcounts[var_5];

    if(!isDefined(var_3))
      var_3 = 0;

    if(var_0 == "_encstr_9A6E11F537232F9A3F7053BA18BD52F3191D7D") {
      if(scripts\mp\utility\perk::_hasperk("_encstr_B68A1CDC072BC696C2C63AE5F54CC9FA37A339B7B93BCA937DC2C9ADDE27"))
        var_3 = getdvarint("_encstr_BD331BCD3639FA1327BEC1CAC9B6AFDC474EDBE6CE954EBEB0275B7BE4", 5);

      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::should_use_velo_forward())
        var_3 = var_3 + getdvarint("_encstr_A32317E64BF201803AAEE9593AC37291576BC163CF67A33D95", 3);
    }
  }

  return var_3;
}

getequipmentstartammo(var_0) {
  var_1 = getequipmenttableinfo(var_0);

  if(!isDefined(var_1))
    return undefined;

  if(!isDefined(var_1.objweapon))
    return 0;

  var_2 = scripts\mp\utility\perk::_hasperk("_encstr_86501BA373482BFBE0426B73E9035853F8AE60DA1438E238F25F4D8010");
  return weaponstartammo(var_1.objweapon, var_2);
}

getequipmentammo(var_0) {
  var_1 = getequipmenttableinfo(var_0);

  if(!isDefined(var_1))
    return undefined;

  if(!isDefined(var_1.objweapon))
    return 0;

  return self getammocount(var_1.objweapon);
}

setequipmentammo(var_0, var_1) {
  var_2 = getequipmenttableinfo(var_0);

  if(!isDefined(var_2.objweapon)) {
    return;
  }
  self setweaponammoclip(var_2.objweapon, var_1);
  updateuiammocount(findequipmentslot(var_0));
}

incrementequipmentammo(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = getequipmentammo(var_0);
  var_3 = int(min(var_2 + var_1, getequipmentmaxammo(var_0)));
  setequipmentammo(var_0, var_3);
}

decrementequipmentammo(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = getequipmentammo(var_0);
  var_1 = int(min(var_1, var_2));

  if(var_1 > 0) {
    var_3 = int(min(var_2 - var_1, getequipmentmaxammo(var_0)));
    setequipmentammo(var_0, var_3);
  }
}

incrementequipmentslotammo(var_0, var_1) {
  var_2 = getcurrentequipment(var_0);

  if(!isDefined(var_2))
    return undefined;

  if(!isDefined(var_1))
    var_1 = 1;

  var_3 = getequipmentammo(var_2);
  var_4 = int(min(var_3 + var_1, getequipmentmaxammo(var_2)));
  setequipmentammo(var_2, var_4);
}

decrementequipmentslotammo(var_0, var_1) {
  var_2 = getcurrentequipment(var_0);

  if(!isDefined(var_2))
    return undefined;

  if(!isDefined(var_1))
    var_1 = 1;

  var_3 = getequipmentammo(var_2);
  var_4 = int(min(var_3 - var_1, getequipmentmaxammo(var_2)));
  setequipmentammo(var_2, var_4);
}

getequipmentslotammo(var_0) {
  var_1 = getcurrentequipment(var_0);

  if(!isDefined(var_1))
    return undefined;

  return getequipmentammo(var_1);
}

setequipmentslotammo(var_0, var_1) {
  var_2 = getcurrentequipment(var_0);

  if(!isDefined(var_2))
    return undefined;

  return setequipmentammo(var_2, var_1);
}

mapequipmentweaponforref(var_0) {
  switch (var_0.basename) {
    case "_encstr_AA45132A90AFC77D50D55D1FAD5847CFC7086172BB":
      return getcompleteweaponname("_encstr_ACC40CC1F8A321601715CFBFE0EA");
    case "_encstr_91730EE7A8D8C8B0A5FD1FF790E72860":
      return getcompleteweaponname("_encstr_81430B218B3F7018458997D78A");
    case "_encstr_B29B0FE0E32573E3A23395B04E6BBF5898":
    case "_encstr_A98D0FF0185ABBC537DD8D30B807FF81C1":
      return getcompleteweaponname("_encstr_99410C4B48C39AB7D0CD95B769DB");
  }

  return var_0;
}

getequipmentreffromweapon(var_0) {
  var_0 = mapequipmentweaponforref(var_0);

  foreach(var_2 in level.equipment.table) {
    if(isDefined(var_2.objweapon) && var_0 == var_2.objweapon)
      return var_2.ref;
  }

  return undefined;
}

getweaponfromequipmentref(var_0) {
  foreach(var_2 in level.equipment.table) {
    if(isDefined(var_2.ref) && var_0 == var_2.ref)
      return var_2.objweapon;
  }

  return undefined;
}

hasequipment(var_0) {
  if(!isDefined(self.equipment))
    return 0;

  foreach(var_2 in self.equipment) {
    if(var_2 == var_0)
      return 1;
  }

  return 0;
}

findequipmentslot(var_0) {
  if(!isDefined(self.equipment))
    return undefined;

  foreach(var_3, var_2 in self.equipment) {
    if(var_2 == var_0)
      return var_3;
  }
}

isequipmentlethal(var_0) {
  return isequipmentprimary(var_0);
}

isequipmentprimary(var_0) {
  if(isDefined(level.equipment.table[var_0]))
    return level.equipment.table[var_0].defaultslot == "_encstr_BA7F0830B3A7859B60B0";
  else
    return 0;
}

isequipmenttactical(var_0) {
  return isequipmentsecondary(var_0);
}

isequipmentsecondary(var_0) {
  if(isDefined(level.equipment.table[var_0]))
    return level.equipment.table[var_0].defaultslot == "_encstr_AC8F0AE74163F85AAA380AD8";
  else
    return 0;
}

unset_force_aitype_suicidebomber(var_0) {
  if(isDefined(level.equipment.table[var_0]))
    return istrue(level.equipment.table[var_0].usecellspawns);
  else
    return 0;
}

updateuiammocount(var_0) {
  if(!isDefined(self.equipment)) {
    return;
  }
  var_1 = 0;
  var_2 = getcurrentequipment(var_0);

  if(isDefined(var_2))
    var_1 = getequipmentslotammo(var_0);

  if(var_0 == "_encstr_BA7F0830B3A7859B60B0") {
    self setclientomnvar("_encstr_BA1E157B08D950EAACDBC37F25553287D0B0F60261501B", var_1);
    self trajectoryupdateoriginandangles("_encstr_BA7F0830B3A7859B60B0", var_1);
  } else if(var_0 == "_encstr_AC8F0AE74163F85AAA380AD8") {
    self setclientomnvar("_encstr_832B1F5BA70160ED732A6677B6318EAF956A472A7A879813FA2E1A38015ED77583", var_1);
    self trajectoryupdateoriginandangles("_encstr_AC8F0AE74163F85AAA380AD8", var_1);
  } else if(var_0 == "_encstr_91B50734CA58631D1A") {
    self setclientomnvar("_encstr_831122AED2FA2BB85D9607D6CA371DBE96327D0DCA16B1D186AF9BABB51AA10B39762B9B", var_1);

    if(scripts\mp\utility\game::unset_relic_grounded())
      _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_ABB312D50723C247B21393B23CD1938523161D16("_encstr_838F10072A626FE3F81390301FC39883BA53", var_1);
  }
}

equiponplayerspawned() {
  thread watchoffhandfired();
}

resetequipment() {
  self.equipment = [];
}

executeoffhandfired(var_0) {
  foreach(var_6, var_2 in self.equipment) {
    var_3 = getequipmenttableinfo(var_2);

    if(isDefined(var_3.objweapon) && var_0 == var_3.objweapon) {
      if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB")
        _encstr_8A0626DB827B1B28BBD3C74BF8B548D7EF1AB3021B9F4E9A56CA1F4B1E0E58A3D372A9CB66FF861B::branalytics_equipmentuse(self, var_0);

      var_4 = getequipmentreffromweapon(var_0);
      scripts\mp\damage::hide_name_fx_from_players(var_4);
      var_5 = getcallback(var_2, "_encstr_8EE208B7DCC82D4E958C");

      if(isDefined(var_5))
        self thread[[var_5]](var_2, var_6, var_0);

      updateuiammocount(var_6);
      break;
    }
  }
}

watchoffhandfired() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    self waittill("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0", var_0);
    executeoffhandfired(var_0);
  }
}

givescavengerammo() {
  foreach(var_3, var_1 in self.equipment) {
    var_2 = getequipmenttableinfo(var_1);

    if(var_2.scavengerammo > 0)
      incrementequipmentammo(var_1, var_2.scavengerammo);
  }
}

getdefaultslot(var_0) {
  var_1 = getequipmenttableinfo(var_0);

  if(!isDefined(var_1))
    return undefined;

  return var_1.defaultslot;
}

watchlethaldelay() {
  level endon("_encstr_8FBD11CAA135B34E789F4C55E1481027D5B8C2");
  level endon("_encstr_AAF00AA3C077B857EFB7F045");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\mp\flags::gameflagwait("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B");
  var_0 = initstandardloadout();

  if(var_0)
    level.lethaldelaystarttime = gettime();
  else
    level.lethaldelaystarttime = scripts\mp\utility\game::gettimepassed();

  if(level.lethaldelay == 0) {
    level.lethaldelayendtime = level.lethaldelaystarttime;
    level notify("_encstr_8FBD11CAA135B34E789F4C55E1481027D5B8C2");
  }

  level.lethaldelayendtime = level.lethaldelaystarttime + level.lethaldelay * 1000;
  level notify("_encstr_8BBD131955E338FB25B168789A3E839647EC178EBC");

  for(;;) {
    var_1 = undefined;

    if(var_0)
      var_1 = gettime();
    else
      var_1 = scripts\mp\utility\game::gettimepassed();

    if(var_1 >= level.lethaldelayendtime) {
      break;
    }

    waitframe();
  }

  level notify("_encstr_8FBD11CAA135B34E789F4C55E1481027D5B8C2");
}

watchlethaldelayplayer(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_AAF00AA3C077B857EFB7F045");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(lethaldelaypassed()) {
    return;
  }
  self notify("_encstr_A24D18879F95474069CF9B98B7406F9DED7157F790FA90A70BE7" + var_1);
  self endon("_encstr_A24D18879F95474069CF9B98B7406F9DED7157F790FA90A70BE7" + var_1);
  self endon("_encstr_961111A5B00BE03947D8A33BC1039F3030F5BF" + var_0);

  if(!isDefined(self.weapon_xp_iw8_sh_charlie725) || !istrue(self.weapon_xp_iw8_sh_charlie725[var_1])) {
    if(!isDefined(self.weapon_xp_iw8_sh_charlie725))
      self.weapon_xp_iw8_sh_charlie725 = [];

    self.weapon_xp_iw8_sh_charlie725[var_1] = 1;
    allow_equipment_slot(var_1, 0);
  }

  watchlethaldelayfeedbackplayer(self, var_1);

  if(isDefined(self.weapon_xp_iw8_sh_charlie725) && istrue(self.weapon_xp_iw8_sh_charlie725[var_1])) {
    self.weapon_xp_iw8_sh_charlie725[var_1] = undefined;

    if(self.weapon_xp_iw8_sh_charlie725.size == 0)
      self.weapon_xp_iw8_sh_charlie725 = undefined;

    allow_equipment_slot(var_1, 1);
  }
}

watchlethaldelayfeedbackplayer(var_0, var_1) {
  level endon("_encstr_8FBD11CAA135B34E789F4C55E1481027D5B8C2");

  if(!istrue(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")))
    level waittill("_encstr_8BBD131955E338FB25B168789A3E839647EC178EBC");

  var_2 = "_encstr_9B0D065699E485D9";

  if(var_1 != "_encstr_BA7F0830B3A7859B60B0")
    var_2 = "_encstr_8E5F0795E6AD7BAD2B";

  if(!isai(var_0))
    var_0 notifyonplayercommand("_encstr_AD40103659A343C28DBE16473A95B6C18EAF" + var_1, var_2);

  var_3 = initstandardloadout();

  for(;;) {
    self waittill("_encstr_AD40103659A343C28DBE16473A95B6C18EAF" + var_1);
    var_4 = undefined;

    if(var_3)
      var_4 = gettime();
    else
      var_4 = scripts\mp\utility\game::gettimepassed();

    var_5 = (level.lethaldelayendtime - var_4) / 1000;
    var_5 = int(max(0, ceil(var_5)));
    var_0 scripts\mp\hud_message::showerrormessage("_encstr_96F11D31C826142BB328B9D9F119732CF756AFBB7C471DF12F6199B9F9218D", var_5);
  }
}

cancellethaldelay() {
  level.lethaldelay = 0;

  if(initstandardloadout())
    level.lethaldelaystarttime = gettime();
  else
    level.lethaldelaystarttime = scripts\mp\utility\game::gettimepassed();

  level.lethaldelayendtime = level.lethaldelaystarttime;
  level notify("_encstr_8FBD11CAA135B34E789F4C55E1481027D5B8C2");
}

lethaldelaypassed() {
  if(isDefined(level.lethaldelay) && level.lethaldelay == 0)
    return 1;

  if(isDefined(level.lethaldelayendtime)) {
    var_0 = undefined;

    if(initstandardloadout())
      var_0 = gettime();
    else
      var_0 = scripts\mp\utility\game::gettimepassed();

    return var_0 > level.lethaldelayendtime;
  }

  return 0;
}

initstandardloadout() {
  var_0 = scripts\mp\utility\game::getgametype();

  if(var_0 == "_encstr_8E07030349" || var_0 == "_encstr_9A7205B39CB919" || var_0 == "_encstr_BDD705AD7BD143")
    return 1;

  return 0;
}

onownerdisconnect(var_0) {
  var_1 = var_0 scripts\mp\weapons::getallequip();

  foreach(var_3 in var_1)
  var_3 notify("_encstr_AD4911F6BB37AC9CF58CD2B98DDB9BE6CA6CE8");
}

hackequipment(var_0) {
  self.ishacked = 1;
  var_0 scripts\mp\gamelogic::sethasdonecombat(var_0, 1);
  var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_1203D(self.equipmentref);
  changeowner(var_0);

  if(level.teambased)
    self filteroutplayermarks(var_0.team);
  else
    self filteroutplayermarks(var_0);

  var_0 scripts\mp\killstreaks\killstreaks::givescoreforhack();
}

changeowner(var_0) {
  var_1 = self.owner;
  self setentityowner(var_0);
  self.owner = var_0;
  self.team = var_0.team;
  self setotherent(var_0);
  var_1 scripts\mp\weapons::removeequip(self);
  self.owner scripts\mp\weapons::updateplantedarray(self);
  var_2 = getcallback(self.equipmentref, "_encstr_849F0F8868FFF7CDC716ADC86708494AD9");
  self notify("_encstr_8A420D18FC784DBB5E48F9E077671B");

  if(isDefined(var_2))
    self[[var_2]](var_1);
}

scriptablescleanupbatchsize(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(istrue(var_4.gulag)) {
      continue;
    }
    var_4._id_12FB1 = var_4 getcurrentequipment(var_1);
    var_4._id_12FB0 = getequipmentslotammo(var_1);
    var_4 takeequipment(var_1);
    var_4 giveequipment(var_2, var_1);
  }
}

_id_13A30(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    if(istrue(var_5.gulag)) {
      continue;
    }
    var_6 = var_5 getcurrentequipment(var_1);

    if(!istrue(var_3) && isDefined(var_6) && var_2 != var_6) {
      continue;
    }
    var_5 takeequipment(var_1);
    var_7 = var_5._id_12FB1;
    var_8 = var_5._id_12FB0;

    if(isDefined(var_7)) {
      var_5 giveequipment(var_7, var_1);
      var_5._id_12FB1 = undefined;

      if(isDefined(var_8)) {
        var_5 setequipmentammo(var_7, var_8);
        var_5._id_12FB0 = undefined;
      }
    }
  }
}

debughackequipment() {
  for(;;) {
    if(getdvarint("_encstr_A79317CDC693BE46ACC4573B240BB1D615B8D55A07ADB2DC47") != 0) {
      var_0 = level.players[0];
      var_1 = undefined;

      for(var_2 = 1; var_2 < level.players.size; var_2++) {
        if(var_0 scripts\mp\utility\player::isenemy(level.players[var_2])) {
          var_1 = level.players[var_2];
          break;
        }
      }

      if(!isDefined(var_1)) {
        iprintlnbold("_encstr_84C03AC03DA26C76A88E08B97FFAF79B79603251D96897F6F80318184E8944F393672E9B58769F919078F587CED3B440F8DBB799400DD3E715BAE2B3");
        continue;
      }

      var_3 = var_0 scripts\mp\weapons::getallequip();
      var_4 = undefined;

      if(var_3.size > 0)
        var_4 = var_3[0];

      if(!isDefined(var_4)) {
        iprintlnbold("_encstr_AD5351C954C2E393F19890D7E89736BA208B6B197A09480B6A07DBB8E9EA4F294BDBAE4750DD91F227ABB8C23770B872A970EB4B5298D7A30B167B2FBEB70AB3C1099F2A55CAF35BCAF2685B03208B938FC82B");
        continue;
      }

      var_4 hackequipment(var_1);
    }

    waitframe();
  }
}

debugemp() {
  for(;;) {
    if(getdvarint("_encstr_8D7013F8DB26400B4FCB2C27CF5FAF134DD60650CF") != 0) {
      if(level.players.size < 2) {
        iprintlnbold("_encstr_8CCD30C9B2CA3208588E08C62B0B9BE8081DDDDB80078D589759C99B01D1ED029BD893EBD1569BA3159A051D932BE6C2C856");
        continue;
      }

      var_0 = level.players[1];
      var_0 scripts\mp\utility\weapon::_launchgrenade("_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E", (0, 0, 0), (0, 0, 0), 0.05, 0);
    }

    waitframe();
  }
}

debugempdrone() {
  for(;;) {
    if(getdvarint("_encstr_887111E66CC9AF3A2BB9A351352888C9B7B959") != 0) {
      if(level.players.size < 2) {
        iprintlnbold("_encstr_B1012E5D61E0ACC60F51321B6B27BBF472EB8B9D31A07CEA5B1B736FC955A2188091426913502B73AD73838B95F0FA95");
        continue;
      }

      var_0 = level.players[0];
      var_1 = level.players[1];
      var_2 = spawnStruct();
      var_2.streakname = "_encstr_8F2C0AB2DA1CD74639B7372B";
      var_2.owner = var_1;
      var_2.id = scripts\cp_mp\utility\killstreak_utility::getuniquekillstreakid(var_1);
      var_2.lifeid = 0;
      var_3 = var_0.origin;
      var_4 = var_1 scripts\cp_mp\killstreaks\emp_drone_targeted::empdrone_createdrone(var_2, var_3);
    }

    waitframe();
  }
}

debugdestroyempdrones() {
  for(;;) {
    if(getdvarint("_encstr_856E18E68D93D7E8CA9BE854A6828827B7B9AC22ACCD3A4E7B2F") != 0) {
      foreach(var_1 in level.activekillstreaks) {
        if(isDefined(var_1.streakinfo) && var_1.streakinfo.streakname == "_encstr_8F2C0AB2DA1CD74639B7372B")
          var_1 scripts\cp_mp\killstreaks\emp_drone::empdrone_destroy();
      }
    }

    waitframe();
  }
}

timeoflastexecute() {
  level.weapon_xp_iw8_pi_papa320 = [];
  var_0 = 0;

  foreach(var_2 in level.equipment.table) {
    if(!var_2.usecellspawns) {
      continue;
    }
    if(var_2.id <= 0) {
      continue;
    }
    if(var_2.defaultslot == "_encstr_AC8F0AE74163F85AAA380AD8") {
      continue;
    }
    level.weapon_xp_iw8_pi_papa320[var_2.ref] = 1 << var_0;
    var_0++;
  }
}