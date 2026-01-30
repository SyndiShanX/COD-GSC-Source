/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_wall_buys.gsc
******************************************/

init() {
  level thread mapweaponnamestonumbers();
  level thread wallbuyinit();
  initmagicboxweapons();
  level thread magicboxthink();
  level thread magicboxmaps();
  level thread weaponlevelboxinit();
}

wallbuyinit() {
  level.wallbuyweapons = [];
  var_0 = getEntArray("wallbuy", "targetname");

  foreach(var_2 in var_0) {
    level thread wallbuythink(var_2);
  }
}

wallbuyupdatehinstrings(var_0) {
  var_0 endon("disconnect");

  for(;;) {
    common_scripts\utility::waittill_any_ents(var_0, "weapon_change", var_0, "new_equipment", level, "disableWallbuysUpdate");
    var_1 = 0;
    var_2 = "";
    var_3 = var_0 getweaponslistall();

    foreach(var_5 in var_3) {
      var_2 = getweaponbasename(var_5);

      if(var_2 == self.weaponname) {
        var_1 = 1;
        break;
      }

      var_6 = maps\mp\zombies\_util::getzombieequipmentalternatename(var_2);

      if(isDefined(var_6) && var_6 == self.weaponname) {
        var_1 = 1;
        break;
      }
    }

    var_8 = var_0 getcurrentprimaryweapon();
    var_9 = 0;

    if(!maps\mp\zombies\_util::iszombieequipment(self.weaponname)) {
      var_9 = maps\mp\zombies\_util::getzombieweaponlevel(var_0, self.weaponname);
    }

    self setcursorhint("HINT_NOICON");

    if(maps\mp\zombies\_util::isrippedturretweapon(var_8) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_8) || maps\mp\zombies\_util::arewallbuysdisabled()) {
      self sethintstring("");
      self setsecondaryhintstring("");
      maps\mp\zombies\_util::tokenhintstring(0);
      continue;
    }

    if(var_1) {
      self sethintstring(getammohintstring(self));
      self setsecondaryhintstring(getammohintcoststring(self, var_9));
      maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(self.currentammocost));
      maps\mp\zombies\_util::tokenhintstring(1);
      continue;
    }

    self sethintstring(getweaponhintstring(self));
    self setsecondaryhintstring(getweaponhintcoststring(self, var_9));
    maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(self.currentweaponcost));
    maps\mp\zombies\_util::tokenhintstring(1);
  }
}

cg_wallbuyupdatehintstrings(var_0) {
  var_0 endon("disconnect");
  maps\mp\zombies\_util::cg_setupstorestrings(var_0);
  thread cg_storetriggermonitor(var_0);

  if(!isDefined(var_0.haveweapons)) {
    var_0.haveweapons = [];
  }

  for(;;) {
    var_0 common_scripts\utility::waittill_any("weapon_change", "new_equipment");
    var_0.haveweapons[self.weaponname] = 0;
    var_1 = "";
    var_2 = var_0 getweaponslistall();

    foreach(var_4 in var_2) {
      var_1 = getweaponbasename(var_4);

      if(var_1 == self.weaponname) {
        var_0.haveweapons[self.weaponname] = 1;
        break;
      }

      var_5 = maps\mp\zombies\_util::getzombieequipmentalternatename(var_1);

      if(isDefined(var_5) && var_5 == self.weaponname) {
        var_0.haveweapons[self.weaponname] = 1;
        break;
      }
    }
  }
}

cg_storetriggermonitor(var_0) {
  var_0 endon("disconnect");

  for(;;) {
    while(!var_0 istouching(self)) {
      wait 0.1;
    }

    var_1 = var_0 getcurrentprimaryweapon();
    var_2 = 0;

    if(!maps\mp\zombies\_util::iszombieequipment(self.weaponname)) {
      var_2 = maps\mp\zombies\_util::getzombieweaponlevel(var_0, self.weaponname);
    }

    if(maps\mp\zombies\_util::isrippedturretweapon(var_1) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_1) || maps\mp\zombies\_util::arewallbuysdisabled()) {
      var_0.storedescription settext("");
      var_0.storecost settext("");
    } else if(var_0.haveweapons[self.weaponname] == 1) {
      var_0.storedescription settext(getammohintstring(self));
      var_0.storecost settext(getammohintcoststring(self, var_2));
    } else {
      var_0.storedescription settext(getweaponhintstring(self));
      var_0.storecost settext(getweaponhintcoststring(self, var_2));
    }

    cg_terminalwaittilltriggerexit(var_0);
    var_0.storedescription settext("");
    var_0.storecost settext("");
  }
}

cg_terminalwaittilltriggerexit(var_0) {
  var_0 endon("wallBuyStateChange");
  childthread cg_wallbuywaittillstatechange(var_0);

  while(var_0 istouching(self)) {
    wait 0.1;
  }

  return;
}

cg_wallbuywaittillstatechange(var_0) {
  var_0 common_scripts\utility::waittill_any("weapon_change", "new_equipment");
  var_0 notify("wallBuyStateChange");
}

cg_onplayerconnectedwallbuyupdatehinstrings(var_0) {
  var_0 endon("death");

  for(;;) {
    level waittill("connected", var_1);
    var_0 thread cg_wallbuyupdatehintstrings(var_1);
  }
}

wallbuythink(var_0) {
  level endon("game_ended");
  var_1 = var_0.script_noteworthy;
  var_2 = 1;
  var_3 = strtok(var_0.script_parameters, ",");
  var_4 = int(var_3[0]);
  var_5 = 1000;

  if(!maps\mp\zombies\_util::iszombieequipment(var_1)) {
    var_6 = var_1;
    var_1 = maps\mp\gametypes\_class::buildweaponname(var_1, "none", "none", "none", 0, 0);
    var_2 = 0;
  }

  if(var_3.size > 1) {
    var_5 = int(var_3[1]);
  }

  var_0.currentweaponcost = var_4;
  var_0.weaponcost = var_4;
  var_0.currentammocost = var_5;
  var_0.ammocost = var_5;
  var_0.weaponname = var_1;

  if(level.nextgen) {
    var_0.modelent = getent(var_0.target, "targetname");
    thread audio_wpnbox_attract_on(var_0.modelent);

    if(isDefined(var_0.modelent.target)) {
      var_0.weaponent = getent(var_0.modelent.target, "targetname");

      if(maps\mp\zombies\_util::isusetriggerprimary(var_0) && !maps\mp\zombies\_util::iszombieequipment(var_1) && isDefined(var_0.weaponent)) {
        var_7 = level.wallbuyweapons.size;
        level.wallbuyweapons[var_7]["baseName"] = var_0.script_noteworthy + "_mp";
        level.wallbuyweapons[var_7]["displayModel"] = var_0.weaponent.model;
      }
    }

    if(maps\mp\zombies\_util::isusetriggerprimary(var_0)) {
      if(isDefined(var_0.weaponent)) {
        var_0.weaponent cloakingenable();
        var_0.weaponent hideweapontags(var_1);
        var_0.weaponent.origin = var_0.modelent.origin;
        var_8 = undefined;

        if(var_1 == "teleport_zombies_mp") {
          var_8 = [5, -3, 4];
        }

        level thread centerweaponforwallbuy(var_0.modelent, var_0.weaponent, var_8);
      }

      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_buy_weapon_pwr_on"), var_0.modelent, "tag_origin");
    }
  } else {
    if(isDefined(var_0.script_flag)) {
      if(maps\mp\zombies\_util::isusetriggerprimary(var_0) && !maps\mp\zombies\_util::iszombieequipment(var_1) && isDefined(var_0.script_noteworthy)) {
        var_7 = level.wallbuyweapons.size;
        level.wallbuyweapons[var_7]["baseName"] = var_0.script_noteworthy + "_mp";
        level.wallbuyweapons[var_7]["displayModel"] = var_0.script_flag;
      }
    }

    thread audio_wpnbox_attract_on(var_0);
  }

  if(level.nextgen) {
    maps\mp\zombies\_util::setupusetriggerforclient(var_0, ::wallbuyupdatehinstrings);
  } else {
    foreach(var_10 in level.players) {
      var_0 thread cg_wallbuyupdatehintstrings(var_10);
    }

    thread cg_onplayerconnectedwallbuyupdatehinstrings(var_0);
  }

  for(;;) {
    [var_10, var_13] = var_0 maps\mp\zombies\_util::waittilltriggerortokenuse();
    var_14 = var_10 getcurrentprimaryweapon();

    if(level.nextgen) {
      if(maps\mp\zombies\_util::isrippedturretweapon(var_14) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_14) || maps\mp\zombies\_util::arewallbuysdisabled()) {
        return;
      }
    } else if(maps\mp\zombies\_util::isrippedturretweapon(var_14) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_14) || maps\mp\zombies\_util::arewallbuysdisabled()) {
      continue;
    }
    var_15 = var_0.currentweaponcost;

    if(level.nextgen) {
      var_1 = getupgradeweaponname(var_10, var_1);
    } else {
      var_1 = getupgradeweaponname(var_10, var_0.weaponname);
    }

    if(maps\mp\zombies\_util::playerhasweapon(var_10, var_1)) {
      var_15 = var_0.currentammocost;

      if(hasfullammo(var_10, var_1)) {
        displayfullammomessage(var_10, var_2);
        continue;
      }
    }

    if(var_13 == "token") {
      var_10 maps\mp\gametypes\zombies::spendtoken(var_0.tokencost);
    } else if(!var_10 maps\mp\gametypes\zombies::attempttobuy(var_15)) {
      var_10 thread maps\mp\zombies\_zombies_audio::playerweaponbuy("wpn_no_cash");
      continue;
    }

    if(level.nextgen) {
      var_0 thread cloaking();
      var_0.modelent scriptmodelplayanim("dlc_weapon_box_01_activate");
      var_10 thread maps\mp\zombies\_zombies_audio::moneyspend();
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_buy_weapon"), var_0.modelent, "tag_printer_laser", 1);
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("wall_buy_steam"), var_0.modelent, "tag_origin", 1);
      var_0.modelent playSound("interact_weapon_box");
      thread audio_wpnbox_attract_in_use(var_0.modelent);
    } else {
      if(isDefined(var_0.target)) {
        var_16 = common_scripts\utility::getstruct(var_0.target, "targetname");
        playFX(common_scripts\utility::getfx("station_buy_weapon"), var_16.origin, anglesToForward(var_16.angles), anglestoup(var_16.angles));
      }

      var_10 thread maps\mp\zombies\_zombies_audio::moneyspend();
      var_0 playSound("interact_weapon_box");
    }

    if(var_2) {
      givezombieequipment(var_10, var_1);
      continue;
    }

    givezombieweapon(var_10, var_1);
  }
}

centerweaponforwallbuy(var_0, var_1, var_2) {
  var_3 = [6, 0, 4];

  if(isDefined(var_2)) {
    var_3 = var_2;
  }

  var_4 = var_0.origin;
  var_5 = anglestoaxis(var_0.angles);
  var_4 = var_4 + var_5["forward"] * var_3[0];
  var_4 = var_4 + var_5["right"] * var_3[1];
  var_4 = var_4 + var_5["up"] * var_3[2];
  var_6 = var_1 getpointinmodelbounds(0.0, 1.0, 0.0);
  var_7 = var_4 - var_6;
  var_1 dontinterpolate();
  var_1.origin = var_1.origin + var_7;
}

cloaking() {
  self notify("walbuy_cloak");
  self endon("walbuy_cloak");

  if(isDefined(self.weaponent)) {
    self.weaponent cloakingdisable();
    wait 3.5;
    self.weaponent cloakingenable();
  }
}

hasfullammo(var_0, var_1) {
  if(maps\mp\zombies\_util::iszombieequipment(var_1) && !var_0 maps\mp\zombies\_terminals::hasexosuit()) {
    var_2 = maps\mp\zombies\_util::getpreexoequipment(var_1);

    if(isDefined(var_2)) {
      var_1 = var_2;
    }
  }

  if(var_0 getweaponammostock(var_1) < weaponmaxammo(var_1, var_0)) {
    return 0;
  }

  if(var_0 getweaponammoclip(var_1) < weaponclipsize(var_1, var_0)) {
    return 0;
  }

  return 1;
}

displayfullammomessage(var_0, var_1) {
  var_0 playsoundtoplayer("ui_button_error", var_0);

  if(var_1) {
    var_0 iprintlnbold(&"ZOMBIES_EQUIPMENT_FULL");
  } else {
    var_0 iprintlnbold(&"ZOMBIES_AMMO_FULL");
  }
}

getweaponhintstring(var_0) {
  switch (var_0.script_noteworthy) {
    case "iw5_arx160zm":
      return &"ZOMBIES_ARX160";
    case "iw5_maulzm":
      return &"ZOMBIES_BULLDOG";
    case "contact_grenade_zombies_mp":
      return &"ZOMBIES_CONTACT";
    case "explosive_drone_zombie_mp":
      return &"ZOMBIES_EXPLOSIVE_DRONE";
    case "iw5_hbra3zm":
      return &"ZOMBIES_HBRA3";
    case "iw5_hmr9zm":
      return &"ZOMBIES_HMR9";
    case "iw5_himarzm":
      return &"ZOMBIES_IMR";
    case "iw5_m182sprzm":
      return &"ZOMBIES_MK14";
    case "iw5_mp11zm":
      return &"ZOMBIES_MP11";
    case "iw5_sac3zm":
      return &"ZOMBIES_SAC3";
    case "iw5_uts19zm":
      return &"ZOMBIES_TAC19";
    case "iw5_lsatzm":
      return &"ZOMBIES_LSAT";
    case "iw5_asawzm":
      return &"ZOMBIES_ASAW";
    case "iw5_rw1zm":
      return &"ZOMBIES_RW1";
    case "teleport_zombies_mp":
      return &"ZOMBIE_DLC3_TELEPORT_GRENADE";
    default:
      return &"ZOMBIES_WALL_BUY_AMMO_ERROR";
  }
}

getweaponhintcoststring(var_0, var_1) {
  var_0.currentweaponcost = var_0.weaponcost;

  if(var_1 > 4) {
    var_0.currentweaponcost = 2000;
  }

  if(var_1 > 9) {
    var_0.currentweaponcost = 3000;
  }

  if(var_1 > 14) {
    var_0.currentweaponcost = 4000;
  }

  if(var_1 > 19) {
    var_0.currentweaponcost = 5000;
  }

  if(isDefined(level.penaltycostincrease)) {
    for(var_2 = 0; var_2 < level.penaltycostincrease; var_2++) {
      var_3 = maps\mp\zombies\_util::getincreasedcost(var_0.currentweaponcost);
      var_0.currentweaponcost = var_3;
    }
  }

  return maps\mp\zombies\_util::getcoststring(var_0.currentweaponcost);
}

getammohintstring(var_0) {
  switch (var_0.script_noteworthy) {
    case "contact_grenade_zombies_mp":
      return &"ZOMBIES_CONTACT_AMMO";
    case "explosive_drone_zombie_mp":
      return &"ZOMBIES_DRONE_AMMO";
    case "teleport_zombies_mp":
      return &"ZOMBIE_DLC3_TELEPORT_GRENADE_AMMO";
  }

  return &"ZOMBIES_WALL_BUY_AMMO";
}

getammohintcoststring(var_0, var_1) {
  switch (var_0.script_noteworthy) {
    case "contact_grenade_zombies_mp":
      return &"ZOMBIES_COST_500";
    case "explosive_drone_zombie_mp":
      return &"ZOMBIES_COST_500";
    case "teleport_zombies_mp":
      return &"ZOMBIES_COST_500";
  }

  var_0.currentammocost = var_0.ammocost;

  if(var_1 > 4) {
    var_0.currentammocost = 1000;
  }

  if(var_1 > 9) {
    var_0.currentammocost = 2000;
  }

  if(var_1 > 14) {
    var_0.currentammocost = 3000;
  }

  if(var_1 > 19) {
    var_0.currentammocost = 4000;
  }

  if(isDefined(level.ammocostdecrease)) {
    var_2 = maps\mp\zombies\_util::getreducedcost(var_0.currentammocost);
    var_0.currentammocost = var_2;
  }

  if(isDefined(level.penaltycostincrease)) {
    for(var_3 = 0; var_3 < level.penaltycostincrease; var_3++) {
      var_4 = maps\mp\zombies\_util::getincreasedcost(var_0.currentammocost);
      var_0.currentammocost = var_4;
    }
  }

  return maps\mp\zombies\_util::getcoststring(var_0.currentammocost);
}

getweaponslistprimariesminusalts() {
  var_0 = [];
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(!maps\mp\gametypes\_weapons::isaltmodeweapon(var_3)) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

givezombieweapon(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_4 = var_0 getweaponslistprimariesminusalts();

  if(var_4.size > 1) {
    var_5 = 1;

    foreach(var_7 in var_4) {
      if(var_1 == var_7) {
        var_5 = 0;
      }
    }

    if(var_5) {
      var_9 = var_0 getcurrentprimaryweapon();

      if(isDefined(level.customreplaceweaponfunc)) {
        var_9 = [[level.customreplaceweaponfunc]](var_0);
      } else {
        if(var_9 == "none" || var_9 == "search_dstry_bomb_defuse_mp") {
          var_9 = var_0 common_scripts\utility::getlastweapon();
        }

        if(!var_0 hasweapon(var_9)) {
          var_9 = var_0 maps\mp\killstreaks\_killstreaks::getfirstprimaryweapon();
        }
      }

      var_0 takeweapon(var_9);
    } else {
      zombiesgiveammoandswitch(var_0, var_1, var_3);
      return;
    }
  } else if(var_4.size == 1 && var_4[0] == var_1) {
    zombiesgiveammoandswitch(var_0, var_1, var_3);
    return;
  }

  maps\mp\gametypes\zombies::createzombieweaponstate(var_0, var_1);
  var_0 maps\mp\_utility::_giveweapon(var_1);
  var_0 givemaxammo(var_1);
  var_0 givemaxscriptedammo(var_1);

  if(var_3) {
    var_0 switchtoweaponimmediate(var_1);
  }

  if(isDefined(level.zmbprocessweapongivenfunc)) {
    level thread[[level.zmbprocessweapongivenfunc]](var_0, var_1);
  }

  if(var_2) {
    var_0 maps\mp\zombies\_zombies_audio::play_weapon_vo(var_1);
  }

  giveweaponlevelachievement(var_0);
  writeweaponlisttomatchdata(var_0);
}

writeweaponlisttomatchdata(var_0) {
  if(maps\mp\zombies\_util::isplayerinlaststand(var_0)) {
    if(isDefined(level.weaponnamemap["LastStand"])) {
      setmatchdata("players", var_0.clientid, "endMisses", level.weaponnamemap["LastStand"]);
      setmatchdata("players", var_0.clientid, "endGamesPlayed", level.weaponnamemap["LastStand"]);
    }
  } else {
    var_1 = var_0 getweaponslistprimaries();
    var_2 = [];

    foreach(var_4 in var_1) {
      var_2[var_2.size] = getweaponbasename(var_4);
    }

    if(isDefined(var_2[0]) && isDefined(level.weaponnamemap[var_2[0]])) {
      setmatchdata("players", var_0.clientid, "endMisses", level.weaponnamemap[var_2[0]]);
    }

    if(isDefined(var_2[1]) && isDefined(level.weaponnamemap[var_2[1]])) {
      setmatchdata("players", var_0.clientid, "endGamesPlayed", level.weaponnamemap[var_2[1]]);
    }
  }
}

givezombieequipment(var_0, var_1, var_2) {
  if(maps\mp\zombies\_util::iszombielethal(var_1)) {
    if(!var_0 maps\mp\zombies\_terminals::hasexosuit()) {
      var_3 = maps\mp\zombies\_util::getpreexoequipment(var_1);

      if(isDefined(var_3)) {
        var_1 = var_3;
      }
    }

    var_4 = var_0 getlethalweapon();

    if(var_4 != var_1) {
      var_0 takeweapon(var_4);
      var_0 setlethalweapon(var_1);
      var_0 giveweapon(var_1);
      fillweaponclip(var_0, var_1);

      if(isDefined(level.weaponnamemap[var_1])) {
        setmatchdata("players", var_0.clientid, "endLosses", level.weaponnamemap[var_1]);
      }

      var_0 notify("new_equipment");
    } else {
      var_0 setweaponammoclip(var_1, var_0 getweaponammoclip(var_1) + 1);
    }
  } else if(maps\mp\zombies\_util::iszombietactical(var_1)) {
    if(maps\mp\zombies\_util::getzombieslevelnum() == 3 && var_1 == "teleport_zombies_mp") {
      level notify("player_purchased_teleport_grenade");
    }

    if(!var_0 maps\mp\zombies\_terminals::hasexosuit()) {
      var_3 = maps\mp\zombies\_util::getpreexoequipment(var_1);

      if(isDefined(var_3)) {
        var_1 = var_3;
      }
    }

    var_5 = var_0 gettacticalweapon();

    if(var_5 != var_1) {
      var_0 takeweapon(var_5);
      var_0 settacticalweapon(var_1);
      var_0 giveweapon(var_1);
      fillweaponclip(var_0, var_1);

      if(isDefined(level.weaponnamemap[var_1])) {
        setmatchdata("players", var_0.clientid, "endHits", level.weaponnamemap[var_1]);
      }

      var_0 notify("new_equipment");
    } else {
      var_0 setweaponammoclip(var_1, var_0 getweaponammoclip(var_1) + 1);
    }
  }

  if(isDefined(level.zmbprocessweapongivenfunc)) {
    level thread[[level.zmbprocessweapongivenfunc]](var_0, var_1);
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    var_0 maps\mp\zombies\_zombies_audio::play_weapon_vo(var_1);
  }
}

fillweaponclip(var_0, var_1) {
  var_2 = weaponclipsize(var_1, var_0);
  var_0 setweaponammoclip(var_1, var_2);
}

plusoneweaponclip(var_0, var_1) {
  var_2 = weaponclipsize(var_1, var_0);
  var_3 = var_0 getweaponammoclip(var_1);

  if(var_3 + 1 <= var_2) {
    var_3++;
  }

  var_0 setweaponammoclip(var_1, var_3);
}

zombiesgiveammoandswitch(var_0, var_1, var_2) {
  var_3 = weaponclipsize(var_1, var_0);
  var_0 setweaponammoclip(var_1, var_3, "right");

  if(issubstr(var_1, "akimbo")) {
    var_0 setweaponammoclip(var_1, var_3, "left");
  }

  var_0 givemaxammo(var_1);
  var_0 givemaxscriptedammo(var_1);

  if(var_2) {
    var_0 switchtoweaponimmediate(var_1);
  }
}

givemaxscriptedammo(var_0) {
  if(issubstr(var_0, "iw5_em1zm_mp")) {
    maps\mp\gametypes\zombies::playersetem1maxammo();
  }

  if(isDefined(level.givemaxscriptedammofunc)) {
    self[[level.givemaxscriptedammofunc]](var_0);
  }
}

magicboxmaps() {
  var_0 = common_scripts\utility::getstructarray("magic_box_map", "targetname");
  common_scripts\utility::array_thread(var_0, ::magicboxmapinit);
}

magicboxmapinit() {
  self.box_locs = [];
  var_0 = getEntArray(self.target, "targetname");
  var_1 = common_scripts\utility::getstructarray(self.target, "targetname");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    switch (var_4.script_noteworthy) {
      case "current":
        var_4 hide();
        self.current_ent = var_4;
        break;
      case "all":
        var_4 hide();
        self.all_ent = var_4;
        break;
      case "box_loc":
        self.box_locs[self.box_locs.size] = var_4;
        break;
      case "breach_map":
        if(level.currentgen && maps\mp\_utility::getmapname() == "mp_zombie_ark") {
          break;
        } else if(isDefined(level.breachmapfunc)) {
          level thread[[level.breachmapfunc]](var_4);
        }

        break;
      default:
        break;
    }
  }

  common_scripts\utility::flag_wait("magic_box_init");

  foreach(var_7 in self.box_locs) {
    thread magicboxmapcurrentthink(var_7);
  }

  thread magicboxmapallthink();
  thread magicboxmapoffthink();
}

magicboxmapcurrentthink(var_0) {
  for(;;) {
    common_scripts\utility::flag_wait(var_0.script_flag_true);
    var_1 = 0;

    while(maps\mp\_utility::gameflag("fire_sale")) {
      var_1 = 1;
      waitframe();
    }

    var_2 = 0;

    while(maps\mp\_utility::gameflag("power_off")) {
      var_2 = 1;
      waitframe();
    }

    if(var_1 || var_2) {
      common_scripts\utility::flag_waitopen(var_0.script_flag_true);
      continue;
    }

    self.current_ent show();
    self.current_ent.origin = var_0.origin;
    common_scripts\utility::flag_waitopen(var_0.script_flag_true);
  }
}

magicboxmapallthink() {
  for(;;) {
    self.all_ent hide();
    maps\mp\_utility::gameflagwait("fire_sale");
    self.all_ent show();
    self.current_ent hide();

    while(maps\mp\_utility::gameflag("fire_sale")) {
      waitframe();
    }

    self.current_ent show();
  }
}

magicboxmapoffthink() {
  for(;;) {
    maps\mp\_utility::gameflagwait("power_off");
    self.all_ent hide();
    self.current_ent hide();

    while(maps\mp\_utility::gameflag("power_off")) {
      waitframe();
    }

    self.current_ent show();
  }
}

mapweaponnamestonumbers() {
  level.weaponnamemap = [];
  level.weaponnamemap["iw5_rw1zm_mp"] = 1;
  level.weaponnamemap["iw5_vbrzm_mp"] = 2;
  level.weaponnamemap["iw5_gm6zm_mp"] = 3;
  level.weaponnamemap["iw5_rhinozm_mp"] = 4;
  level.weaponnamemap["iw5_lsatzm_mp"] = 5;
  level.weaponnamemap["iw5_asawzm_mp"] = 6;
  level.weaponnamemap["iw5_ak12zm_mp"] = 7;
  level.weaponnamemap["iw5_bal27zm_mp"] = 8;
  level.weaponnamemap["iw5_himarzm_mp"] = 9;
  level.weaponnamemap["iw5_asm1zm_mp"] = 10;
  level.weaponnamemap["iw5_sn6zm_mp"] = 11;
  level.weaponnamemap["iw5_sac3zm_mp"] = 12;
  level.weaponnamemap["iw5_fusionzm_mp"] = 13;
  level.weaponnamemap["distraction_drone_zombie_mp"] = 14;
  level.weaponnamemap["dna_aoe_grenade_zombie_mp"] = 15;
  level.weaponnamemap["iw5_exocrossbowzm_mp"] = 16;
  level.weaponnamemap["iw5_mahemzm_mp"] = 17;
  level.weaponnamemap["iw5_em1zm_mp"] = 18;
  level.weaponnamemap["iw5_dlcgun1zm_mp"] = 19;
  level.weaponnamemap["iw5_arx160zm_mp"] = 20;
  level.weaponnamemap["iw5_mp11zm_mp"] = 21;
  level.weaponnamemap["explosive_drone_zombie_mp"] = 22;
  level.weaponnamemap["contact_grenade_zombies_mp"] = 23;
  level.weaponnamemap["iw5_hbra3zm_mp"] = 24;
  level.weaponnamemap["iw5_hmr9zm_mp"] = 25;
  level.weaponnamemap["iw5_maulzm_mp"] = 26;
  level.weaponnamemap["iw5_m182sprzm_mp"] = 27;
  level.weaponnamemap["iw5_uts19zm_mp"] = 28;
  level.weaponnamemap["contact_grenade_throw_zombies_mp"] = 29;
  level.weaponnamemap["explosive_drone_throw_zombie_mp"] = 30;
  level.weaponnamemap["distraction_drone_throw_zombie_mp"] = 31;
  level.weaponnamemap["dna_aoe_grenade_throw_zombie_mp"] = 32;
  level.weaponnamemap["iw5_titan45zm_mp"] = 33;
  level.weaponnamemap["LastStand"] = 34;
  level.weaponnamemap["iw5_microwavezm_mp"] = 35;
  level.weaponnamemap["iw5_linegunzm_mp"] = 36;
  level.weaponnamemap["frag_grenade_zombies_mp"] = 37;
  level.weaponnamemap["frag_grenade_throw_zombies_mp"] = 38;
  level.weaponnamemap["iw5_dlcgun2zm_mp"] = 39;
  level.weaponnamemap["iw5_dlcgun3zm_mp"] = 40;
  level.weaponnamemap["teleport_zombies_mp"] = 41;
  level.weaponnamemap["repulsor_zombie_mp"] = 42;
  level.weaponnamemap["iw5_tridentzm_mp"] = 43;
  level.weaponnamemap["iw5_dlcgun4zm_mp"] = 44;
  level.weaponnamemap["iw5_exominigunzm_mp"] = 45;
  level.weaponnamemap["playermech_rocket_zm_mp"] = 46;
  level.weaponnamemap["iw5_juggernautrocketszm_mp"] = 47;
  level.weaponnamemap["playermech_rocket_swarm_zm_mp"] = 48;
}

initmagicboxweapons() {
  level.magicboxuses = 0;
  level.ondeckweapons = [];
  addmagicboxweapon("iw5_rw1zm", "npc_rw1_main_base_static_holo", &"ZOMBIES_RW1", "none", "none", "none");
  addmagicboxweapon("iw5_vbrzm", "npc_vbr_base_static_holo", &"ZOMBIES_VBR", "none", "none", "none");
  addmagicboxweapon("iw5_gm6zm", "npc_gm6_base_static_holo", &"ZOMBIES_GM6", "gm6scope", "none", "none");
  addmagicboxweapon("iw5_rhinozm", "npc_rhino_base_static_holo", &"ZOMBIES_RHINO", "none", "none", "none");
  addmagicboxweapon("iw5_lsatzm", "npc_lsat_base_static_holo", &"ZOMBIES_LSAT", "none", "none", "none");
  addmagicboxweapon("iw5_asawzm", "npc_ameli_base_static_holo", &"ZOMBIES_ASAW", "none", "none", "none");
  addmagicboxweapon("iw5_ak12zm", "npc_ak12_base_static_holo", &"ZOMBIES_AK12", "none", "none", "none");
  addmagicboxweapon("iw5_bal27zm", "npc_bal27_base_black_static_holo", &"ZOMBIES_BAL27", "none", "none", "none");
  addmagicboxweapon("iw5_himarzm", "npc_himar_base_static_holo", &"ZOMBIES_IMR", "none", "none", "none");
  addmagicboxweapon("iw5_asm1zm", "npc_asm1_base_static_holo", &"ZOMBIES_ASM1", "none", "none", "none");
  addmagicboxweapon("iw5_sn6zm", "npc_sn6_base_black_static_holo", &"ZOMBIES_SN6", "none", "none", "none");
  addmagicboxweapon("iw5_sac3zm", "npc_sac3_base_static_holo", &"ZOMBIES_SAC3", "none", "none", "none");
  addmagicboxweapon("iw5_fusionzm", "npc_fusion_shotgun_base_holo", &"ZOMBIES_FUSION_RIFLE", "none", "none", "none", 2);
  addmagicboxweapon("distraction_drone_zombie", "dlc_distraction_drone_01_holo", &"ZOMBIES_DISTRACTION_DRONE", "none", "none", "none", 2);
  addmagicboxweapon("dna_aoe_grenade_zombie", "npc_exo_launcher_grenade_holo", &"ZOMBIES_DNA_AOE", "none", "none", "none", 2);
  addmagicboxweapon("iw5_exocrossbowzm", "npc_crossbow_base_static_holo", &"ZOMBIES_CROSSBOW", "none", "none", "none");
  addmagicboxweapon("iw5_mahemzm", "npc_mahem_base_holo", &"ZOMBIES_MAHEM", "none", "none", "none");
  addmagicboxweapon("iw5_em1zm", "npc_em1_base_static_holo", &"ZOMBIES_EM1", "none", "none", "none");
  addmagicboxweapon("iw5_dlcgun1zm", "npc_dear_base_static_holo", &"ZOMBIES_DLC_GUN_1", "none", "none", "none");

  if(isDefined(level.initmagicboxweaponsfunc)) {
    [[level.initmagicboxweaponsfunc]]();
  }
}

addmagicboxweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isDefined(level.magicboxweapons)) {
    level.magicboxweapons = [];
  }

  var_8 = level.magicboxweapons.size;
  level.magicboxweapons[var_8]["baseNameNoMP"] = var_0;
  level.magicboxweapons[var_8]["baseName"] = var_0 + "_mp";
  level.magicboxweapons[var_8]["fullName"] = var_0 + "_mp";
  level.magicboxweapons[var_8]["displayModel"] = var_1;
  level.magicboxweapons[var_8]["displayString"] = var_2;
  level.magicboxweapons[var_8]["attachment1"] = var_3;
  level.magicboxweapons[var_8]["attachment2"] = var_4;
  level.magicboxweapons[var_8]["attachment3"] = var_5;
  level.magicboxweapons[var_8]["limit"] = var_6;

  if(isDefined(var_7)) {
    level.magicboxweapons[var_8]["forceSelect"] = randomint(var_7);
  }

  if(!maps\mp\zombies\_util::iszombieequipment(level.magicboxweapons[var_8]["baseName"])) {
    level.magicboxweapons[var_8]["fullName"] = maps\mp\gametypes\_class::buildweaponname(var_0, var_3, var_4, var_5, 0, 0);
  }
}

removemagicboxweapon(var_0) {
  var_1 = undefined;

  for(var_2 = 0; var_2 < level.magicboxweapons.size; var_2++) {
    if(level.magicboxweapons[var_2]["baseNameNoMP"] == var_0) {
      var_1 = var_2;
      break;
    }
  }

  if(isDefined(var_1)) {
    level.magicboxweapons = maps\mp\zombies\_util::array_remove_index(level.magicboxweapons, var_1);
  }
}

magicboxthink() {
  level endon("game_ended");
  common_scripts\utility::flag_init("magic_box_init");
  common_scripts\utility::flag_init("magic_box_moved");
  level.magicboxlocations = getEntArray("magic_box", "targetname");
  var_0 = undefined;

  foreach(var_2 in level.magicboxlocations) {
    var_2.modelent = getent(var_2.target, "targetname");

    if(isDefined(var_2.modelent) && isDefined(var_2.modelent.target)) {
      var_3 = getent(var_2.modelent.target, "targetname");

      if(isDefined(var_3) && var_3.code_classname == "light") {
        var_2.light = var_3;
        var_2.light.lightonintensity = var_2.light getlightintensity();
        var_2.light.lightoffintensity = 0.1;
      }
    }

    var_2.active = 0;
    var_2.isdispensingweapon = 0;
    var_2.ismoving = 0;

    if(isDefined(var_2.script_flag)) {
      common_scripts\utility::flag_init(var_2.script_flag);
    }
  }

  wait 2;

  foreach(var_2 in level.magicboxlocations) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "start_location") {
      var_0 = var_2;
      var_0.active = 1;
      var_2 activatemagicboxeffects(var_2.modelent, var_2.light);
      var_2 sethintstring(getmagicboxhintsting());
      var_2 setsecondaryhintstring(var_2 getmagicboxhintstringcost());
      var_2 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_2.cost));
      var_2 maps\mp\zombies\_util::tokenhintstring(1);
      continue;
    }

    var_2 sethintstring(getmagicboxhintsting(1));
    var_2 setsecondaryhintstring(var_2 getmagicboxhintstringcost(1));
    var_2 maps\mp\zombies\_util::tokenhintstring(0);
    var_2 deactivatemagicboxeffects(var_2.modelent, var_2.light);
  }

  common_scripts\utility::flag_set("magic_box_init");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    watchmagicboxtrigger(var_0, 0);

    while(maps\mp\_utility::gameflag("fire_sale")) {
      while(maps\mp\_utility::gameflag("fire_sale") || var_0.isdispensingweapon) {
        wait 0.15;
      }

      var_0 notify("fireSaleOver");
    }

    common_scripts\utility::flag_set("magic_box_moved");
    var_7 = [];

    foreach(var_9 in level.magicboxlocations) {
      if(var_0 == var_9) {
        continue;
      }
      if(isscriptedmagicbox(var_9)) {
        continue;
      }
      if(var_9.isdispensingweapon) {
        continue;
      }
      var_7[var_7.size] = var_9;
    }

    if(var_7.size > 0) {
      var_0 deactivatemagicboxeffects(var_0.modelent, var_0.light);
      var_0 sethintstring(getmagicboxhintsting(1));
      var_0 setsecondaryhintstring(var_0 getmagicboxhintstringcost(1));
      var_0 maps\mp\zombies\_util::tokenhintstring(0);
      var_0.active = 0;

      while(isDefined(var_0.deactivated)) {
        waitframe();
      }

      var_0 = var_7[randomint(var_7.size)];
      var_0 activatemagicboxeffects(var_0.modelent, var_0.light);
      var_0 sethintstring(getmagicboxhintsting());
      var_0 setsecondaryhintstring(var_0 getmagicboxhintstringcost());
      var_0 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_0.cost));
      var_0 maps\mp\zombies\_util::tokenhintstring(1);
      var_0.active = 1;
    }
  }
}

magicboxhasmoved() {
  return common_scripts\utility::flag_exist("magic_box_moved") && common_scripts\utility::flag("magic_box_moved");
}

activatemagicboxeffects(var_0, var_1) {
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("station_mystery_box_icon_off"), var_0, "tag_origin");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_mystery_box_icon_on"), var_0, "tag_origin");
  thread audio_magicbox_attract_on(var_0);

  if(isDefined(var_1)) {
    var_1 setlightintensity(var_1.lightonintensity);
  }

  if(isDefined(self.script_flag)) {
    common_scripts\utility::flag_set(self.script_flag);
  }
}

deactivatemagicboxeffects(var_0, var_1) {
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("station_mystery_box_icon_on"), var_0, "tag_origin");
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_mystery_box_icon_off"), var_0, "tag_origin");
  thread audio_magicbox_attract_off(var_0);

  if(isDefined(var_1)) {
    var_1 setlightintensity(var_1.lightoffintensity);
  }

  if(isDefined(self.script_flag)) {
    common_scripts\utility::flag_clear(self.script_flag);
  }
}

audio_magicbox_attract_on(var_0) {
  if(!isDefined(var_0.soundent)) {
    var_1 = var_0 gettagorigin("tag_printer_laser");
    var_0.soundent = spawn("script_origin", var_1);
    var_0.soundent scalevolume(0);
    waitframe();
  }

  var_0.soundent scalevolume(1, 0.25);
  var_0.soundent playLoopSound("interact_mystery_box_attract");
}

audio_magicbox_attract_off(var_0) {
  if(!isDefined(var_0.soundent)) {
    return;
  }
  var_0.soundent scalevolume(0, 1);
  wait 1;
  var_0.soundent stoploopsound();
  waitframe();
  var_0.soundent delete();
}

audio_magicbox_attract_in_use(var_0) {
  var_0.soundent scalevolume(0, 0.5);
  wait 0.5;
  var_0.soundent stoploopsound();
}

audio_wpnbox_attract_on(var_0) {
  var_0 scalevolume(1, 0.25);
  var_0 playLoopSound("interact_weapon_box_attract");
}

audio_wpnbox_attract_in_use(var_0) {
  var_0 scalevolume(0, 0.5);
  wait 3.5;
  var_0 scalevolume(1, 0.5);
}

centerweaponformagicbox(var_0, var_1, var_2) {
  var_3 = [0, 0, 39];
  var_4 = var_0.origin;
  var_5 = anglestoaxis(var_0.angles);
  var_4 = var_4 + var_5["forward"] * var_3[0];
  var_4 = var_4 + var_5["right"] * var_3[1];
  var_4 = var_4 + var_5["up"] * var_3[2];
  var_6 = var_1 getpointinmodelbounds(0.0, 0.0, 0.0);
  var_7 = var_4 - var_6;
  var_1 dontinterpolate();
  var_1.origin = var_1.origin + var_7;
}

magicboxusewait() {
  self endon("fireSaleOver");
  self endon("deactivated");
  return maps\mp\zombies\_util::waittilltriggerortokenuse();
}

isscriptedmagicbox(var_0) {
  return isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "scripted_magic_box";
}

watchmagicboxtrigger(var_0, var_1) {
  var_2 = 0;
  var_3 = randomintrange(4, 7);
  var_4 = int(var_0.script_parameters);
  var_5 = var_0.modelent.origin;
  var_6 = var_0.modelent gettagangles("tag_printer_laser");
  var_7 = spawn("script_model", var_5);
  var_7.angles = var_6 + (0, 90, 0);
  var_7 setModel("tag_origin");
  var_0.weaponmodel = var_7;
  var_0.lastweapon = "";
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_slow"), var_0.modelent, "tag_origin");

  for(;;) {
    if(var_1 && !maps\mp\_utility::gameflag("fire_sale")) {
      break;
    }

    var_8 = var_0 magicboxusewait();

    if(!isDefined(var_8)) {
      break;
    }

    [var_10, var_11] = var_8;
    var_12 = var_2 >= var_3 && !maps\mp\_utility::gameflag("fire_sale") && !isscriptedmagicbox(var_0);
    var_13 = getmagicboxcost(var_4);
    var_14 = var_10 getcurrentprimaryweapon();

    if(maps\mp\zombies\_util::isrippedturretweapon(var_14) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_14) || maps\mp\zombies\_util::arewallbuysdisabled()) {
      continue;
    }
    if(var_12 && !var_10 maps\mp\gametypes\zombies::canbuy(var_13)) {
      var_10 thread maps\mp\zombies\_zombies_audio::playerweaponbuy("printer_no_cash");
      continue;
    }

    if(!var_12 && !isDefined(self.deactivated)) {
      if(var_11 == "token") {
        var_10 maps\mp\gametypes\zombies::spendtoken(var_0.tokencost);
      } else if(!var_10 maps\mp\gametypes\zombies::attempttobuy(var_13)) {
        var_10 thread maps\mp\zombies\_zombies_audio::playerweaponbuy("printer_no_cash");
        continue;
      }
    }

    if(!var_12 && !isDefined(self.deactivated)) {
      if(var_2 == 0) {
        var_10 thread maps\mp\zombies\_zombies_audio::playerfoundprinter();
      }

      level notify("magicBoxUse", var_0);
      var_0 common_scripts\utility::trigger_off();
      var_0.isdispensingweapon = 1;
      var_10 thread maps\mp\zombies\_zombies_audio::moneyspend();
      maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_slow"), var_0.modelent, "tag_origin");
      var_18 = selectmagicboxweapon(var_10, var_0);
      level.ondeckweapons[level.ondeckweapons.size] = var_18["fullName"];
      var_7 setModel(var_18["displayModel"]);
      level thread centerweaponformagicbox(var_0.modelent, var_7);
      var_7 show();

      if(level.nextgen) {
        var_7 cloakingenable();
      }

      wait 0.5;

      if(level.nextgen) {
        var_7 cloakingdisable();
      }

      var_0.modelent scriptmodelplayanim("dlc_weapon_mystery_box_01_open", "magicBox");
      var_0.modelent.soundent playSound("interact_mystery_box");
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_mystery_box"), var_0.modelent, "tag_printer_laser", 1);
      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("magic_box_steam"), var_0.modelent, "tag_origin", 1);
      var_0.lastweapon = var_18["baseName"];
      level.magicboxuses++;

      if(isDefined(var_10)) {
        var_10.magicboxuses++;
        var_10 givemagicboxachievement();
      }

      thread audio_magicbox_attract_in_use(var_0.modelent);
      var_0.modelent waittillmatch("magicBox", "weapon_ready");
      var_19 = var_18["displayString"];

      if(isDefined(var_0.magicboxpickupstrfunc)) {
        var_19 = [[var_0.magicboxpickupstrfunc]]();
      }

      var_0 sethintstring(var_19);
      var_0 setsecondaryhintstring("");
      var_0 maps\mp\zombies\_util::tokenhintstring(0);

      if(isDefined(var_10)) {
        var_10 clientclaimtrigger(var_0);
      }

      var_0 common_scripts\utility::trigger_on();
      var_0 notify("pickupReady");
      var_20 = 8;
      var_21 = gettime() + var_20 * 1000;
      level thread flashweaponmodel(var_7);
      var_22 = "nothing";

      while(gettime() < var_21 && var_22 != "trigger") {
        var_23 = (var_21 - gettime()) / 1000;
        var_0 thread activemagicboxtimeout(var_23);
        var_24 = var_0 maps\mp\zombies\_util::waittill_any_return_parms_no_endon_death("timeout", "trigger");
        var_0 notify("stopActiveMagicBoxTimeout");
        var_22 = var_24[0];

        if(var_22 == "timeout") {
          break;
        }

        var_25 = var_24[1];

        if(isDefined(var_0.magicboxcanpickupfunc)) {
          if(![
              [var_0.magicboxcanpickupfunc]
            ](var_25))
            var_22 = "nothing";
        } else {
          var_14 = var_25 getcurrentprimaryweapon();

          if(maps\mp\zombies\_util::isrippedturretweapon(var_14) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_14) || maps\mp\zombies\_util::arewallbuysdisabled()) {
            var_22 = "nothing";
          }
        }

        if(var_22 == "trigger") {
          var_10 = var_25;
        }
      }

      var_0.modelent.soundent playSound("interact_mystery_box_reset");
      var_0.modelent scriptmodelplayanim("dlc_weapon_mystery_box_01_close", "magicBox");
      var_0 common_scripts\utility::trigger_off();
      var_0 sethintstring(getmagicboxhintsting());
      var_0 setsecondaryhintstring(var_0 getmagicboxhintstringcost());
      var_0 maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(var_0.cost));
      var_0 maps\mp\zombies\_util::tokenhintstring(1);
      var_0 releaseclaimedtrigger();
      var_7 setModel("tag_origin");
      var_7 notify("stop_flashing");

      if(isDefined(var_10)) {
        var_26 = getupgradeweaponname(var_10, var_18["fullName"]);

        if(isDefined(var_0.magicboxgivefunc)) {
          var_0[[var_0.magicboxgivefunc]](var_22, var_10);
        } else if(var_22 == "trigger" && maps\mp\_utility::isreallyalive(var_10) && !maps\mp\zombies\_util::isplayerinlaststand(var_10)) {
          if(maps\mp\zombies\_util::iszombieequipment(var_26)) {
            givezombieequipment(var_10, var_26);
          } else {
            givezombieweapon(var_10, var_26);
          }
        }
      }

      level.ondeckweapons = arrayremovestring(level.ondeckweapons, var_18["fullName"]);
      var_0.modelent waittillmatch("magicBox", "end");
      var_0 common_scripts\utility::trigger_on();
      var_0.isdispensingweapon = 0;
      var_0 notify("magicBoxUseEnd");
      thread audio_magicbox_attract_on(var_0.modelent);

      if(!maps\mp\_utility::gameflag("fire_sale")) {
        var_2++;
      }

      maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_slow"), var_0.modelent, "tag_origin");
      continue;
    }

    var_0 common_scripts\utility::trigger_off();
    var_0.ismoving = 1;
    maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_slow"), var_0.modelent, "tag_origin");
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_fast"), var_0.modelent, "tag_origin");
    var_0.modelent.soundent playSound("interact_mystery_box_break");
    thread audio_magicbox_attract_in_use(var_0.modelent);
    wait 2;
    maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_fast"), var_0.modelent, "tag_origin");
    maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("station_mystery_box_icon_on"), var_0.modelent, "tag_origin");
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("magic_box_move"), var_0.modelent, "tag_origin");
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("magic_box_steam"), var_0.modelent, "tag_origin", 1);
    var_0.modelent scriptmodelplayanim("dlc_weapon_mystery_box_01_malfunction", "magicBox");
    maps\mp\zombies\_zombies_audio_announcer::announcerprintermoveddialog();
    wait 3;
    var_0.modelent.soundent playSound("interact_mystery_box_shutoff");
    wait 2;
    maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("magic_box_move"), var_0.modelent, "tag_origin");
    var_0.ismoving = 0;
    var_0 common_scripts\utility::trigger_on();
    break;
  }

  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("weapon_cycle_slow"), var_0.modelent, "tag_origin");
  var_7 delete();
}

activemagicboxtimeout(var_0) {
  self endon("stopActiveMagicBoxTimeout");
  wait(var_0);
  self notify("timeout");
}

flashweaponmodel(var_0) {
  var_0 endon("stop_flashing");
  wait 5;

  for(;;) {
    var_0 ghost();
    wait 0.35;
    var_0 show();
    wait 0.35;
  }
}

arrayremovestring(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

selectmagicboxweapon(var_0, var_1) {
  var_2 = [];
  var_3 = "";
  var_4 = var_0 getweaponslistall();
  var_5 = [];

  foreach(var_7 in var_4) {
    var_5[var_5.size] = getweaponbasename(var_7);
  }

  foreach(var_14, var_10 in level.magicboxweapons) {
    var_11 = 1;

    foreach(var_7 in var_5) {
      if(var_10["baseName"] == var_7) {
        var_11 = 0;
        break;
      }
    }

    if(var_1.lastweapon == var_10["baseName"]) {
      var_11 = 0;
    }

    if(islimitreached(var_10)) {
      var_11 = 0;
    }

    if(isDefined(var_10["forceSelect"])) {
      if(var_10["forceSelect"] <= level.magicboxuses) {
        level.magicboxweapons[var_14]["forceSelect"] = undefined;
        var_2 = [var_10];
        break;
      } else {
        var_11 = 0;
      }
    }

    if(var_11) {
      var_2[var_2.size] = var_10;
    }
  }

  var_3 = var_2[randomint(var_2.size)];
  return var_3;
}

islimitreached(var_0) {
  if(!isDefined(var_0["limit"])) {
    return 0;
  }

  var_1 = level.ondeckweapons;

  foreach(var_3 in level.players) {
    var_4 = var_3 getweaponslistall();
    var_1 = common_scripts\utility::array_combine(var_1, var_4);
  }

  var_6 = 0;
  var_7 = var_0["limit"];

  foreach(var_9 in var_1) {
    var_10 = getweaponbasename(var_9);

    if(var_10 == var_0["baseName"]) {
      var_6++;
    }
  }

  return var_6 >= var_7;
}

getmagicboxhintsting(var_0) {
  var_1 = &"ZOMBIES_BUY_MYSTERY_BOX";

  if(maps\mp\_utility::gameflag("fire_sale")) {
    var_1 = &"ZOMBIES_FIRE_SALE_MAGIC_BOX";
  }

  if(isDefined(var_0) && var_0) {
    var_1 = &"ZOMBIES_PRINTER_OFFLINE";

    if(randomint(1000) == 500) {
      var_1 = &"ZOMBIES_PC_LOAD_LETTER";
    }
  }

  return var_1;
}

getmagicboxhintstringcost(var_0) {
  self.cost = 1000;
  var_1 = &"ZOMBIES_COST_1000";

  if(isDefined(level.penaltycostincrease)) {
    var_2 = 1000;

    for(var_3 = 0; var_3 < level.penaltycostincrease; var_3++) {
      var_2 = maps\mp\zombies\_util::getincreasedcost(var_2);
    }

    self.cost = var_2;
    var_1 = maps\mp\zombies\_util::getcoststring(var_2);
  }

  if(maps\mp\_utility::gameflag("fire_sale")) {
    self.cost = 10;
    var_1 = &"ZOMBIES_COST_10";
  }

  if(isDefined(var_0) && var_0) {
    self.cost = 0;
    var_1 = &"ZOMBIES_EMPTY_STRING";
  }

  return var_1;
}

getmagicboxcost(var_0) {
  var_1 = var_0;

  if(isDefined(level.penaltycostincrease)) {
    for(var_2 = 0; var_2 < level.penaltycostincrease; var_2++) {
      var_1 = maps\mp\zombies\_util::getincreasedcost(var_1);
    }
  }

  if(maps\mp\_utility::gameflag("fire_sale")) {
    var_1 = 10;
  }

  return var_1;
}

givemagicboxachievement() {
  if(self.magicboxuses >= 15) {
    maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_PCLOADLETTER");
  }
}

weaponlevelboxinit() {
  initcamolevels();
  level.weaponlevelboxes = getEntArray("weapon_level_box", "targetname");
  common_scripts\utility::array_thread(level.weaponlevelboxes, ::weaponlevelboxthink);
}

weaponlevelboxsetupspecialbox() {
  if(!isDefined(self.modelent) || !isDefined(self.modelent.target) || isDefined(self.modelent.light)) {
    return;
  }
  var_0 = getent(self.modelent.target, "targetname");

  if(isDefined(var_0) && var_0.code_classname == "light") {
    self.modelent.light = var_0;
    self.modelent.light.lightonintensity = self.modelent.light getlightintensity();
    self.modelent.light.lightoffintensity = 0.1;
    self.modelent.light.ison = 1;
  }
}

weaponlevelboxturnonlight() {
  if(isDefined(self.modelent.light) && isDefined(self.modelent.light.lightoffintensity) && isDefined(self.modelent.light.ison) && !self.modelent.light.ison) {
    self.modelent.light setlightintensity(self.modelent.light.lightonintensity);
    self.modelent.light.ison = 1;
  }
}

weaponlevelboxturnofflight() {
  if(isDefined(self.modelent.light) && isDefined(self.modelent.light.lightoffintensity) && isDefined(self.modelent.light.ison) && self.modelent.light.ison) {
    self.modelent.light setlightintensity(self.modelent.light.lightoffintensity);
    self.modelent.light.ison = 0;
  }
}

isspecialweaponbox(var_0) {
  return isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "special";
}

weaponlevelboxisplayerweaponmaxed(var_0, var_1) {
  return !isspecialweaponbox(self) && var_0.weaponstate[var_1]["level"] >= 20 || isspecialweaponbox(self) && var_0.weaponstate[var_1]["level"] >= 25;
}

weaponlevelboxupdatehintstrings(var_0) {
  var_0 endon("disconnect");
  var_1 = &"ZOMBIES_COST_2500";

  if(maps\mp\zombies\_util::iszombieshardmode()) {
    var_1 = &"ZOMBIES_COST_1500";
  }

  for(;;) {
    var_2 = var_0 maps\mp\zombies\_util::waittill_any_return_parms_no_endon_death("weapon_change", "no_upgrades");
    var_3 = undefined;

    if(var_2[0] == "no_upgrades" && self.allowupgrade) {
      continue;
    }
    switch (var_2[0]) {
      case "weapon_change":
        var_3 = var_2[1];
        break;
      case "no_upgrades":
        self sethintstring("");
        self setsecondaryhintstring("");
        maps\mp\zombies\_util::tokenhintstring(0);
        var_0 waittill("allow_upgrades");
        var_3 = maps\mp\zombies\_util::getplayerweaponzombies(var_0);
        break;
    }

    var_4 = getweaponbasename(var_3);
    self setcursorhint("HINT_NOICON");

    if(!maps\mp\zombies\_util::haszombieweaponstate(var_0, var_4) || !weaponlevelboxisplayerweaponmaxed(var_0, var_4)) {
      self sethintstring(&"ZOMBIES_WEAPON_LEVEL_BOX");
      self setsecondaryhintstring(var_1);
      maps\mp\zombies\_util::settokencost(maps\mp\zombies\_util::creditstotokens(2500));
      maps\mp\zombies\_util::tokenhintstring(1);
      continue;
    }

    self sethintstring(&"ZOMBIES_WEAPON_LEVEL_MAX");
    self setsecondaryhintstring("");
    maps\mp\zombies\_util::tokenhintstring(0);
  }
}

deactivatemagicbox() {
  self.deactivated = 1;
  self notify("deactivated");
}

reactivatemagicbox() {
  self.deactivated = undefined;
}

cg__onplayerconnectedweaponlevelboxupdatehintstrings(var_0) {
  var_0 endon("death");

  for(;;) {
    level waittill("connected", var_1);
    var_0 thread cg_weaponlevelboxupdatehintstrings(var_1);
  }
}

cg_weaponlevelboxupdatehintstrings(var_0) {
  var_0 endon("disconnect");
  maps\mp\zombies\_util::cg_setupstorestrings(var_0);
  thread cg_levelboxtriggermonitor(var_0);

  for(;;) {
    var_1 = var_0 maps\mp\zombies\_util::waittill_any_return_parms_no_endon_death("weapon_change", "no_upgrades");
    var_2 = undefined;

    if(var_1[0] == "no_upgrades" && self.allowupgrade) {
      continue;
    }
    switch (var_1[0]) {
      case "weapon_change":
        var_2 = var_1[1];
        break;
      case "no_upgrades":
        var_0 waittill("allow_upgrades");
        var_2 = maps\mp\zombies\_util::getplayerweaponzombies(var_0);
        break;
    }

    var_0.baseweapon = getweaponbasename(var_2);
  }
}

cg_levelboxtriggermonitor(var_0) {
  var_0 endon("disconnect");

  for(;;) {
    while(!var_0 istouching(self)) {
      wait 0.1;
    }

    if(!maps\mp\zombies\_util::haszombieweaponstate(var_0, var_0.baseweapon) || !weaponlevelboxisplayerweaponmaxed(var_0, var_0.baseweapon)) {
      var_0.storedescription settext(&"ZOMBIES_WEAPON_LEVEL_BOX");
      var_1 = &"ZOMBIES_COST_2500";

      if(maps\mp\zombies\_util::iszombieshardmode()) {
        var_1 = &"ZOMBIES_COST_1500";
      }

      var_0.storecost settext(var_1);
    } else {
      var_0.storedescription settext(&"ZOMBIES_WEAPON_LEVEL_MAX");
      var_0.storecost settext("");
    }

    while(var_0 istouching(self)) {
      wait 0.1;
    }

    var_0.storedescription settext("");
    var_0.storecost settext("");
  }
}

weaponlevelboxthink() {
  level endon("game_ended");
  self.modelent = getent(self.target, "targetname");
  self.allowupgrade = 1;

  if(isspecialweaponbox(self)) {
    weaponlevelboxsetupspecialbox();
    weaponlevelboxturnofflight();
    common_scripts\utility::trigger_off();
    level waittill("special_weapon_box_unlocked");

    if(level.currentgen) {
      common_scripts\utility::trigger_on();
    }

    weaponlevelboxturnonlight();
  }

  var_0 = self.modelent gettagangles("tag_origin");
  self.modelent playLoopSound("interact_weapon_upgrade_attract");

  if(maps\mp\zombies\_util::isusetriggerprimary(self)) {
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon_pwr_on"), self.modelent, "tag_origin");
  }

  if(level.nextgen) {
    maps\mp\zombies\_util::setupusetriggerforclient(self, ::weaponlevelboxupdatehintstrings);
  } else {
    foreach(var_2 in level.players) {
      thread cg_weaponlevelboxupdatehintstrings(var_2);
    }

    thread cg__onplayerconnectedweaponlevelboxupdatehintstrings(self);
  }

  var_4 = int(self.script_parameters);

  if(isDefined(level.penaltycostincrease)) {
    for(var_5 = 0; var_5 < level.penaltycostincrease; var_5++) {
      var_6 = maps\mp\zombies\_util::getincreasedcost(var_4);
      var_4 = var_6;
    }
  }

  if(maps\mp\zombies\_util::iszombieshardmode()) {
    var_4 = 1500;
  }

  for(;;) {
    [var_2, var_8] = maps\mp\zombies\_util::waittilltriggerortokenuse();
    var_9 = var_2 getcurrentprimaryweapon();

    if(maps\mp\zombies\_util::isrippedturretweapon(var_9) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_9) || maps\mp\zombies\_util::arewallbuysdisabled()) {
      continue;
    }
    var_10 = maps\mp\zombies\_util::getplayerweaponzombies(var_2);
    var_11 = getweaponbasename(var_10);

    if(!maps\mp\zombies\_util::haszombieweaponstate(var_2, var_11)) {
      continue;
    }
    if(weaponlevelboxisplayerweaponmaxed(var_2, var_11)) {
      diaplaymaxlevelmessage(var_2);
      continue;
    }

    if(isspecialweaponbox(self) && var_2.weaponstate[var_11]["level"] != 20) {
      displayrequiredlevelmessage(var_2);
      continue;
    }

    if(var_8 == "token") {
      var_2 maps\mp\gametypes\zombies::spendtoken(self.tokencost);
    } else if(!var_2 maps\mp\gametypes\zombies::attempttobuy(var_4)) {
      var_2 thread maps\mp\zombies\_zombies_audio::playerweaponbuy("wpn_no_cash");
      continue;
    }

    self.allowupgrade = 0;

    foreach(var_13 in level.players) {
      var_13 notify("no_upgrades");
    }

    var_15 = undefined;

    if(level.nextgen) {
      var_16 = findholomodel(var_11);
      var_15 = spawn("script_model", self.origin);
      var_15.angles = var_0 - (0, 90, 0);
      var_15 setModel(var_16);
      var_17 = [15, 0, -6];

      if(var_11 == "iw5_exocrossbowzm_mp") {
        var_17 = [13, 0, -13];
        var_15.angles = var_15.angles + (0, 0, -90);
      }

      level thread centerweaponforwallbuy(self.modelent, var_15, var_17);
    }

    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon"), self.modelent, "tag_origin", 1);
    self.modelent playSound("interact_weapon_upgrade");

    if(isspecialweaponbox(self)) {
      setweaponlevel(var_2, var_10, 25);
    } else {
      setweaponlevel(var_2, var_10, var_2.weaponstate[var_11]["level"] + 1);
    }

    var_2 thread maps\mp\zombies\_zombies_audio::playerweaponupgrade(isspecialweaponbox(self), var_2.weaponstate[var_11]["level"]);
    var_2.numupgrades++;
    wait 1.2;

    if(isDefined(var_2)) {
      if(var_2.weaponstate[var_11]["level"] > 19) {
        maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("weapon_level_20"), self.modelent, "tag_origin", 1);
        self.modelent playSound("interact_weapon_upgrade_fwks");
      }
    }

    wait 0.75;

    if(isDefined(var_15)) {
      var_15 delete();
    }

    self.allowupgrade = 1;

    foreach(var_13 in level.players) {
      var_13 notify("allow_upgrades");
    }
  }
}

setweaponlevel(var_0, var_1, var_2) {
  var_0 takeweapon(var_1);
  var_3 = getweaponbasename(var_1);
  var_0.weaponstate[var_3]["level"] = var_2;
  var_4 = getupgradeweaponname(var_0, var_3);
  givezombieweapon(var_0, var_4, 0);

  if(issubstr(var_4, "iw5_em1zm_mp")) {
    var_0 maps\mp\gametypes\zombies::playersetem1maxammo();
  }

  if(isDefined(level.setweaponlevelfunc)) {
    var_0[[level.setweaponlevelfunc]](var_1, var_2);
  }

  var_0 playsoundtoplayer("mp_s1_earn_medal", var_0);
}

giveweaponlevelachievement(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  if(var_1.size < 2) {
    return;
  }
  foreach(var_3 in var_1) {
    var_4 = getweaponbasename(var_3);

    if(var_0.weaponstate[var_4]["level"] < 20) {
      return;
    }
  }

  var_0 maps\mp\gametypes\zombies::givezombieachievement("DLC1_ZOMBIE_2020");
}

findholomodel(var_0) {
  foreach(var_2 in level.magicboxweapons) {
    if(var_2["baseName"] == var_0) {
      return var_2["displayModel"];
    }
  }

  foreach(var_2 in level.wallbuyweapons) {
    if(var_2["baseName"] == var_0) {
      return var_2["displayModel"];
    }
  }

  return "npc_titan45_base_static_holo";
}

getupgradeweaponname(var_0, var_1) {
  var_2 = var_1;
  var_3 = getweaponbasename(var_1);

  if(maps\mp\zombies\_util::haszombieweaponstate(var_0, var_3) && var_0.weaponstate[var_3]["level"] > 0) {
    var_4 = var_0.weaponstate[var_3]["level"];

    if(var_4 > 25) {
      var_4 = 25;
    }

    var_5 = getcamoforweaponlevel(var_3, var_4);
    var_6 = getattachment1forweaponlevel(var_3, var_4);
    var_7 = getattachment2forweaponlevel(var_3, var_4);
    var_8 = getattachment3forweaponlevel(var_3, var_4);
    var_9 = maps\mp\_utility::strip_suffix(var_3, "_mp");
    var_2 = maps\mp\gametypes\_class::buildweaponname(var_9, var_6, var_7, var_8, var_5, 0);
  }

  return var_2;
}

getcamoforweaponlevel(var_0, var_1) {
  var_1 = int(min(var_1, level.camolevel.size - 1));
  return level.camolevel[var_1];
}

getattachment1forweaponlevel(var_0, var_1) {
  var_2 = getmagicboxweapondefaultattachment(var_0, "attachment1");

  if(var_1 > 3) {
    switch (var_0) {
      case "iw5_m182sprzm_mp":
      case "iw5_hbra3zm_mp":
      case "iw5_dlcgun1zm_mp":
      case "iw5_ak12zm_mp":
        var_2 = "opticseotech";
        break;
      case "iw5_arx160zm_mp":
      case "iw5_sn6zm_mp":
      case "iw5_bal27zm_mp":
      case "iw5_exocrossbowzm_mp":
      case "iw5_em1zm_mp":
        var_2 = "variablereddot";
        break;
      case "iw5_uts19zm_mp":
      case "iw5_maulzm_mp":
      case "iw5_mp11zm_mp":
      case "iw5_asm1zm_mp":
      case "iw5_vbrzm_mp":
      case "iw5_microwavezm_mp":
        var_2 = "opticsreddot";
        break;
      case "iw5_asawzm_mp":
        var_2 = "opticsthermalar";
        break;
      case "iw5_hmr9zm_mp":
        var_2 = "opticsthermal";
        break;
      case "iw5_himarzm_mp":
      case "iw5_lsatzm_mp":
      case "iw5_rhinozm_mp":
      case "iw5_rw1zm_mp":
      case "iw5_dlcgun2zm_mp":
      case "iw5_linegunzm_mp":
      case "iw5_fusionzm_mp":
      case "iw5_tridentzm_mp":
      case "iw5_titan45zm_mp":
        var_2 = "opticstargetenhancer";
        break;
      case "iw5_sac3zm_mp":
      case "iw5_dlcgun3zm_mp":
        var_2 = "lasersight";
        break;
      case "iw5_dlcgun4zm_mp":
      case "iw5_mahemzm_mp":
        var_2 = "quickdraw";
        break;
      case "iw5_gm6zm_mp":
        var_2 = "opticsacog2";
        break;
    }
  }

  return var_2;
}

getattachment2forweaponlevel(var_0, var_1) {
  var_2 = getmagicboxweapondefaultattachment(var_0, "attachment2");

  if(var_1 > 6) {
    switch (var_0) {
      case "iw5_uts19zm_mp":
      case "iw5_maulzm_mp":
      case "iw5_hmr9zm_mp":
      case "iw5_hbra3zm_mp":
      case "iw5_mp11zm_mp":
      case "iw5_arx160zm_mp":
      case "iw5_asm1zm_mp":
      case "iw5_himarzm_mp":
      case "iw5_bal27zm_mp":
      case "iw5_ak12zm_mp":
      case "iw5_asawzm_mp":
      case "iw5_rhinozm_mp":
        var_2 = "lasersight";
        break;
      case "iw5_m182sprzm_mp":
      case "iw5_dlcgun1zm_mp":
      case "iw5_lsatzm_mp":
      case "iw5_dlcgun4zm_mp":
      case "iw5_dlcgun2zm_mp":
      case "iw5_fusionzm_mp":
        var_2 = "stock";
        break;
      case "iw5_vbrzm_mp":
      case "iw5_rw1zm_mp":
      case "iw5_dlcgun3zm_mp":
      case "iw5_linegunzm_mp":
      case "iw5_tridentzm_mp":
      case "iw5_gm6zm_mp":
      case "iw5_em1zm_mp":
      case "iw5_titan45zm_mp":
        var_2 = "quickdraw";
        break;
      case "iw5_sac3zm_mp":
      case "iw5_sn6zm_mp":
        var_2 = "firerate";
        break;
      case "iw5_mahemzm_mp":
      case "iw5_exocrossbowzm_mp":
        var_2 = "xmags";
        break;
    }
  }

  return var_2;
}

getattachment3forweaponlevel(var_0, var_1) {
  var_2 = getmagicboxweapondefaultattachment(var_0, "attachment3");

  if(var_1 > 9) {
    switch (var_0) {
      case "iw5_arx160zm_mp":
      case "iw5_himarzm_mp":
      case "iw5_bal27zm_mp":
      case "iw5_ak12zm_mp":
      case "iw5_mahemzm_mp":
      case "iw5_em1zm_mp":
        var_2 = "stock";
        break;
      case "iw5_hbra3zm_mp":
      case "iw5_mp11zm_mp":
      case "iw5_asm1zm_mp":
      case "iw5_asawzm_mp":
      case "iw5_lsatzm_mp":
      case "iw5_dlcgun2zm_mp":
      case "iw5_exocrossbowzm_mp":
        var_2 = "quickdraw";
        break;
      case "iw5_uts19zm_mp":
      case "iw5_m182sprzm_mp":
      case "iw5_maulzm_mp":
      case "iw5_hmr9zm_mp":
      case "iw5_dlcgun1zm_mp":
      case "iw5_sac3zm_mp":
      case "iw5_sn6zm_mp":
      case "iw5_rhinozm_mp":
      case "iw5_vbrzm_mp":
      case "iw5_rw1zm_mp":
      case "iw5_dlcgun4zm_mp":
      case "iw5_dlcgun3zm_mp":
      case "iw5_fusionzm_mp":
      case "iw5_tridentzm_mp":
      case "iw5_gm6zm_mp":
      case "iw5_titan45zm_mp":
        var_2 = "xmags";
        break;
      case "iw5_linegunzm_mp":
        var_2 = "xmagslinegun";
        break;
    }
  }

  return var_2;
}

getmagicboxweapondefaultattachment(var_0, var_1) {
  var_2 = "none";

  foreach(var_4 in level.magicboxweapons) {
    if(var_4["baseName"] == var_0) {
      var_2 = var_4[var_1];
      break;
    }
  }

  return var_2;
}

displayrequiredlevelmessage(var_0) {
  var_0 playsoundtoplayer("ui_button_error", var_0);
  var_0 iprintlnbold(&"ZOMBIES_REQUIRES_LEVEL_20");
}

diaplaymaxlevelmessage(var_0) {
  var_0 playsoundtoplayer("ui_button_error", var_0);

  if(!isspecialweaponbox(self)) {
    var_0 iprintlnbold(&"ZOMBIES_MAX_LEVEL_20");
  } else {
    var_0 iprintlnbold(&"ZOMBIES_MAX_LEVEL_25");
  }
}

initcamolevels() {
  var_0 = "mp/zmWeaponLevels.csv";
  level.camolevel = [];

  for(var_1 = 0; var_1 <= 25; var_1++) {
    var_2 = int(tablelookup(var_0, 0, var_1, 1));
    level.camolevel[var_1] = var_2;
  }
}

wallbuydisable(var_0) {
  if(level.nextgen) {
    var_0.weaponent hide();
    maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("station_buy_weapon_pwr_on"), var_0.modelent, "tag_origin");
  }

  var_0 common_scripts\utility::trigger_off();
}

wallbuyenable(var_0) {
  if(level.nextgen) {
    var_0.weaponent show();
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_buy_weapon_pwr_on"), var_0.modelent, "tag_origin");
  }

  var_0 common_scripts\utility::trigger_on();
  thread wallbuyrestoretriggerhintstring(var_0);
}

wallbuyrestoretriggerhintstring(var_0) {
  if(level.nextgen) {
    maps\mp\zombies\_util::setupusetriggerforclient(var_0, ::wallbuyupdatehinstrings);
  } else {
    foreach(var_2 in level.players) {
      var_0 thread cg_wallbuyupdatehintstrings(var_2);
    }

    thread cg_onplayerconnectedwallbuyupdatehinstrings(var_0);
  }
}

weaponlevelrestoretriggerhintstring(var_0) {
  if(level.nextgen) {
    maps\mp\zombies\_util::setupusetriggerforclient(var_0, ::weaponlevelboxupdatehintstrings);
  } else {
    foreach(var_2 in level.players) {
      var_0 thread cg_weaponlevelboxupdatehintstrings(var_2);
    }

    thread cg__onplayerconnectedweaponlevelboxupdatehintstrings(var_0);
  }
}

weaponlevelboxdisable(var_0) {
  maps\mp\zombies\_util::killfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon_pwr_on"), var_0.modelent, "tag_origin");
  var_0 weaponlevelboxturnofflight();
  var_0 common_scripts\utility::trigger_off();
}

weaponlevelboxenable(var_0) {
  maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("station_upgrade_weapon_pwr_on"), var_0.modelent, "tag_origin");
  var_0 weaponlevelboxturnonlight();
  var_0 common_scripts\utility::trigger_on();
  thread weaponlevelrestoretriggerhintstring(var_0);
}