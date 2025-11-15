vl_main() {
  // add "bad" check?
  replacefunc(maps\mp\_vl_cac::playercacprocesslui, ::playercacprocesslui_stub);

  // use attachkits instead of furtnitekits
  replacefunc(maps\mp\_vl_cac::parseweaponhighlightedvalue, ::parseweaponhighlightedvalue_stub);
  replacefunc(maps\mp\_vl_cac::handleweaponhighlighted, ::handleweaponhighlighted_stub);
  replacefunc(maps\mp\_vl_cac::buildweaponnamecac, ::buildweaponnamecac_stub);
  replacefunc(maps\mp\_vl_base::memberclasschanges, ::memberclasschanges_stub);
  replacefunc(maps\mp\_vl_base::updateavatarloadout, ::updateavatarloadout_stub);

  replacefunc(maps\mp\_vl_cac::showweaponavatar, ::showweaponavatar_stub);
  replacefunc(maps\mp\_vl_cac::spawngenericprop3avatar, ::spawngenericprop3avatar_stub);
  replacefunc(maps\mp\_vl_cac::showloadingweaponavatar, ::showloadingweaponavatar_stub);

  // patches to stock maps GSC that are only needed for vlobby
  // maps/mp/gametypes doesn't load on our custom scripts, so we need these still to be patching
  replacefunc(maps\mp\gametypes\_weapons::watchweaponchange, ::watchweaponchange_stub);
  replacefunc(maps\mp\gametypes\_weapons::init, ::weapons_init_stub);
  replacefunc(maps\mp\gametypes\_weapons::updatemovespeedscale, ::updatemovespeedscale_stub);
  replacefunc(maps\mp\perks\_perks::applyperks, ::applyperks_stub);
  replacefunc(maps\mp\perks\_perks::validateperk, ::validateperk_stub);

  replacefunc(maps\mp\_vl_base::resetvirtuallobbypresentable, ::resetvirtuallobbypresentable_stub);
}

resetvirtuallobbypresentable_stub() {
}

updatemovespeedscale_stub(weaponType) {
  if(!isDefined(level.prematch_done_time)) {
    return;
  }

  if(!isDefined(weaponType) || weaponType == "primary" || weaponType != "secondary")
    weaponType = self.primaryWeapon;
  else
    weaponType = self.secondaryWeapon;

  if(isDefined(self.primaryWeapon) && self.primaryWeapon == "riotshield_mp") {
    self setmovespeedscale(.8 * self.moveSpeedScaler);
    return;
  }

  if(!isDefined(weaponType))
    weapClass = "none";
  else
    weapClass = weaponclass(weaponType);

  switch (weapClass) {
    case "rifle":
      self setmovespeedscale(0.95 * self.moveSpeedScaler);
      break;
    case "pistol":
      self setmovespeedscale(1.0 * self.moveSpeedScaler);
      break;
    case "mg":
      self setmovespeedscale(0.875 * self.moveSpeedScaler);
      break;
    case "smg":
      self setmovespeedscale(1.0 * self.moveSpeedScaler);
      break;
    case "spread":
      self setmovespeedscale(.95 * self.moveSpeedScaler);
      break;
    case "rocketlauncher":
      self setmovespeedscale(0.80 * self.moveSpeedScaler);
      break;
    case "sniper":
      self setmovespeedscale(1.0 * self.moveSpeedScaler);
      break;
    default:
      self setmovespeedscale(1.0 * self.moveSpeedScaler);
      break;
  }
}

weapons_init_stub() {
  level.scavenger_altmode = 1;
  level.scavenger_secondary = 1;
  level.maxperplayerexplosives = max(maps\mp\_utility::getintproperty("scr_maxPerPlayerExplosives", 2), 1);
  level.riotshieldxpbullets = maps\mp\_utility::getintproperty("scr_riotShieldXPBullets", 15);
  createthreatbiasgroup("DogsDontAttack");
  createthreatbiasgroup("Dogs");
  setignoremegroup("DogsDontAttack", "Dogs");

  switch (maps\mp\_utility::getintproperty("perk_scavengerMode", 0)) {
    case 1:
      level.scavenger_altmode = 0;
      break;
    case 2:
      level.scavenger_secondary = 0;
      break;
    case 3:
      level.scavenger_altmode = 0;
      level.scavenger_secondary = 0;
      break;
  }

  var_0 = getdvar("g_gametype");
  var_1 = maps\mp\_utility::getattachmentlistbasenames();
  var_1 = common_scripts\utility::alphabetize(var_1);
  var_2 = tablegetrowcount("mp/statstable.csv");
  var_3 = tablegetcolumncount("mp/statstable.csv");
  level.weaponlist = [];
  level.weaponattachments = [];

  for(var_4 = 0; var_4 <= var_2; var_4++) {
    if(!issubstr(tablelookupbyrow("mp/statstable.csv", var_4, 2), "weapon_")) {
      continue;
    }
    if(tablelookupbyrow("mp/statstable.csv", var_4, 51) != "") {
      continue;
    }
    if(tablelookupbyrow("mp/statstable.csv", var_4, var_3 - 1) == "Never") {
      continue;
    }
    var_5 = tablelookupbyrow("mp/statstable.csv", var_4, 4);

    if(var_5 == "" || var_5 == "none") {
      continue;
    }
    if(issubstr(var_5, "iw5") || issubstr(var_5, "iw6")) {
      var_6 = maps\mp\_utility::getweaponnametokens(var_5);
      var_5 = var_6[0] + "_" + var_6[1] + "_mp";
      level.weaponlist[level.weaponlist.size] = var_5;
      continue;
    } else
      level.weaponlist[level.weaponlist.size] = var_5 + "_mp";

    var_7 = maps\mp\_utility::getweaponattachmentarrayfromstats(var_5);
    var_8 = [];

    foreach(var_10 in var_1) {
      if(!isDefined(var_7[var_10])) {
        continue;
      }
      level.weaponlist[level.weaponlist.size] = var_5 + "_" + var_10 + "_mp";
      var_8[var_8.size] = var_10;
    }

    var_12 = [];

    for(var_13 = 0; var_13 < var_8.size - 1; var_13++) {
      var_14 = tablelookuprownum("mp/attachmentCombos.csv", 0, var_8[var_13]);

      for(var_15 = var_13 + 1; var_15 < var_8.size; var_15++) {
        if(tablelookup("mp/attachmentCombos.csv", 0, var_8[var_15], var_14) == "no") {
          continue;
        }
        var_12[var_12.size] = var_8[var_13] + "_" + var_8[var_15];
      }
    }

    foreach(var_17 in var_12)
    level.weaponlist[level.weaponlist.size] = var_5 + "_" + var_17 + "_mp";
  }

  thread maps\mp\_flashgrenades::main();
  thread maps\mp\_entityheadicons::init();

  if(!isDefined(level.weapondropfunction))
    level.weapondropfunction = maps\mp\gametypes\_weapons::dropweaponfordeath;

  var_23 = 70;
  level.claymoredetectiondot = cos(var_23);
  level.claymoredetectionmindist = 20;
  level.claymoredetectiongraceperiod = 0.75;
  level.claymoredetonateradius = 192;

  if(!isDefined(level.iszombiegame) || !level.iszombiegame) {
    level.minedetectiongraceperiod = 0.3;
    level.minedetectionradius = 100;
    level.minedetectionheight = 20;
    level.minedamageradius = 256;
    level.minedamagemin = 70;
    level.minedamagemax = 210;
    level.minedamagehalfheight = 46;
    level.mineselfdestructtime = 120;
  }

  level.delayminetime = 3.0;
  level.stingerfxid = loadfx("fx/explosions/aerial_explosion_large");
  level.meleeweaponbloodflick = loadfx("vfx/blood/blood_flick_melee_weapon");
  level.primary_weapon_array = [];
  level.side_arm_array = [];
  level.grenade_array = [];
  level.missile_array = [];
  level.inventory_array = [];
  level.mines = [];
  level.trophies = [];
  precachemodel("weapon_claymore_bombsquad_mw1");
  precachemodel("weapon_c4_bombsquad_mw1");
  precachelaser("mp_attachment_lasersight");
  precachelaser("mp_attachment_lasersight_short");
  level.c4fxid = loadfx("vfx/lights/light_c4_blink");
  level.claymorefxid = loadfx("vfx/props/claymore_laser");
  level thread maps\mp\gametypes\_weapons::onplayerconnect();
  level.c4explodethisframe = 0;
  common_scripts\utility::array_thread(getEntArray("misc_turret", "classname"), maps\mp\gametypes\_weapons::turret_monitoruse);
}

watchweaponchange_stub() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended"); // just in case

  thread maps\mp\gametypes\_weapons::watchstartweaponchange();
  self.lastdroppableweapon = self.currentweaponatspawn;
  self.hitsthismag = [];
  var_0 = self getcurrentweapon();

  if(maps\mp\_utility::iscacprimaryweapon(var_0) && !isDefined(self.hitsthismag[var_0])) {
    self.hitsthismag[var_0] = weaponclipsize(var_0);
  }

  self.bothbarrels = undefined;

  if(issubstr(var_0, "ranger")) {
    thread maps\mp\gametypes\_weapons::watchrangerusage(var_0);
  }

  var_1 = 1;

  for(;;) {
    if(!var_1) {
      self waittill("weapon_change");
    }

    var_1 = 0;
    var_0 = self getcurrentweapon();

    if(var_0 == "none") {
      continue;
    }

    var_2 = getweaponattachments(var_0);
    self.has_opticsthermal = 0;
    self.has_target_enhancer = 0;
    self.has_stock = 0;
    self.has_laser = 0;

    if(isDefined(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4 == "opticstargetenhancer") {
          self.has_target_enhancer = 1;
          continue;
        }

        if(var_4 == "stock") {
          self.has_stock = 1;
          continue;
        }

        if(var_4 == "lasersight") {
          self.has_laser = 1;
          continue;
        }

        if(issubstr(var_4, "opticsthermal")) {
          self.has_opticsthermal = 1;
        }
      }
    }

    if(maps\mp\_utility::isbombsiteweapon(var_0)) {
      continue;
    }

    var_6 = maps\mp\_utility::getweaponnametokens(var_0);
    self.bothbarrels = undefined;

    if(issubstr(var_0, "ranger")) {
      thread maps\mp\gametypes\_weapons::watchrangerusage(var_0);
    }

    if(var_6[0] == "alt") {
      var_7 = getsubstr(var_0, 4);
      var_0 = var_7;
      var_6 = maps\mp\_utility::getweaponnametokens(var_0);
    }

    if(var_0 != "none" && var_6[0] != "iw5" && var_6[0] != "iw6" && var_6[0] != "h1" && var_6[0] != "h2") {
      if(maps\mp\_utility::iscacprimaryweapon(var_0) && !isDefined(self.hitsthismag[var_0 + "_mp"])) {
        self.hitsthismag[var_0 + "_mp"] = weaponclipsize(var_0 + "_mp");
      }
    } else if(var_0 != "none" && (var_6[0] == "iw5" || var_6[0] == "iw6" || var_6[0] == "h1" || var_6[0] == "h2")) {
      if(maps\mp\_utility::iscacprimaryweapon(var_0) && !isDefined(self.hitsthismag[var_0])) {
        self.hitsthismag[var_0] = weaponclipsize(var_0);
      }
    }

    if(maps\mp\gametypes\_weapons::maydropweapon(var_0)) {
      self.lastdroppableweapon = var_0;
    }

    self.changingweapon = undefined;
  }
}

applyperks_stub() {
  self endon("disconnect");
  level endon("game_ended");

  self setviewkickscale(1.0);

  table = "mp/perkTable.csv";

  for(i = 0; i < tablegetrowcount(table); i++) {
    pro_perk = tableLookup(table, 0, i, 8);

    if(!isSubStr(pro_perk, "specialty_")) {
      continue;
    }
    if(self maps\mp\_utility::_hasPerk(pro_perk))
      self maps\mp\_utility::givePerk(tableLookup(table, 0, i, 1), false);
  }
}

validateperk_stub(var_0, var_1) {
  if(getdvarint("scr_game_perks") == 0)
    return "specialty_null";

  if(var_0 == 0) {
    switch (var_1) {
      case "specialty_longersprint":
      case "specialty_fastmantle":
      case "specialty_fastreload":
      case "specialty_quickdraw":
      case "specialty_scavenger":
      case "specialty_extraammo":
      case "specialty_bling":
      case "specialty_secondarybling":
      case "specialty_onemanarmy":
      case "specialty_omaquickchange":
        return var_1;
      default:
        break;
    }
  } else if(var_0 == 1) {
    switch (var_1) {
      case "specialty_bulletdamage":
      case "specialty_armorpiercing":
      case "specialty_lightweight":
      case "specialty_fastsprintrecovery":
      case "specialty_hardline":
      case "specialty_rollover":
      case "specialty_radarimmune":
      case "specialty_spygame":
      case "specialty_explosivedamage":
      case "specialty_dangerclose":
        return var_1;
      default:
        break;
    }
  } else if(var_0 == 2) {
    switch (var_1) {
      case "specialty_extendedmelee":
      case "specialty_falldamage":
      case "specialty_bulletaccuracy":
      case "specialty_holdbreath":
      case "specialty_localjammer":
      case "specialty_delaymine":
      case "specialty_heartbreaker":
      case "specialty_quieter":
      case "specialty_detectexplosive":
      case "specialty_selectivehearing":
      case "specialty_pistoldeath":
      case "specialty_laststandoffhand":
        return var_1;
      default:
        break;
    }
  }

  return "specialty_null";
}

parseweaponhighlightedvalue_stub(var_0, var_1) {
  switch (var_0) {
    case "2":
    case "1":
    case "9":
      return tablelookup("mp/statstable.csv", 0, var_1, 4);
    case "3":
    case "4":
      return tablelookup("mp/perktable.csv", 0, var_1, 1);
    case "5": // was furniturekits
    case "6":
      return tablelookup("mp/attachkits.csv", 0, var_1, 1);
    case "7":
      return tablelookup("mp/camotable.csv", 0, var_1, 1);
    case "8":
      return tablelookup("mp/reticletable.csv", 0, var_1, 1);
    default:
      break;
  }

  return "none";
}

updateavatarloadout_stub(var_0, var_1, var_2) {
  if(!maps\mp\_utility::is_true(var_1.updateloadout) || maps\mp\_utility::is_true(level.in_firingrange)) {
    return;
  }
  var_3 = var_1.loadout;
  var_4 = var_1.updatecostume;
  var_5 = maps\mp\_vl_avatar::get_ownerid_for_avatar(var_1);
  var_6 = tablelookup("mp/statstable.csv", 0, var_3.primary, 4);
  var_7 = tablelookup("mp/attachkits.csv", 0, var_3.primaryattachkit, 1);
  var_8 = tablelookup("mp/attachkits.csv", 0, var_3.primaryfurniturekit, 1);
  var_9 = var_3.primarycamo;
  var_10 = var_3.primaryreticle;
  var_11 = var_3.playercardpatch;
  var_1._id_A7EA = var_11;
  var_12 = var_3._id_A7EB;
  var_13 = var_3._id_A7EC;
  var_1 _meth_8577(var_13);

  if(!var_12)
    var_11 = -1;

  var_14 = maps\mp\gametypes\_class::buildweaponname(var_6, var_7, var_8, var_9, undefined, undefined);
  maps\mp\_vl_avatar::vl_avatar_loadout(var_0, var_5, var_14, var_4, var_3._id_A7ED);
  var_1.updateloadout = undefined;
  var_1.updatecostume = undefined;
  var_1.weapclasschanged = undefined;

  if(var_6 == "h1_junsho" || isDefined(var_2) && issubstr(var_2, "h1_junsho"))
    var_0 maps\mp\_vl_avatar::playerteleportavatartoweaponroom(var_1, level.camparams.camera, 1);
}

memberclasschanges_stub(var_0) {
  if(!isDefined(level.vlplayer) || !isDefined(level.camparams) || level.vlavatars.size == 0) {
    return;
  }
  var_1 = level.vlplayer;
  maps\mp\_vl_base::updatelocalavatarloadouts(var_0);

  foreach(var_3 in var_0) {
    var_4 = maps\mp\_vl_avatar::get_avatar_for_xuid(var_3.xuid);

    if(isDefined(var_4)) {
      if(var_3.player_controller >= 0) {
        var_5 = maps\mp\_vl_avatar::get_ownerid_for_avatar(var_4);
        var_6 = !level.vl_active || !isDefined(var_4.loadout) && getdvarint("virtualLobbyMode", 0) == 6;

        if(isDefined(var_4)) {
          var_4.loadout = var_3;
          var_4.xuid = var_3.xuid;
        }

        if(!var_6)
          continue;
      }
    }

    var_7 = tablelookup("mp/statstable.csv", 0, var_3.primary, 4);
    var_8 = var_3.primaryattachkit;
    var_9 = tablelookup("mp/attachkits.csv", 0, var_3.primaryattachkit, 1);
    var_10 = var_3.primaryfurniturekit;
    var_11 = tablelookup("mp/attachkits.csv", 0, var_3.primaryfurniturekit, 1);
    var_12 = var_3.primarycamo;
    var_13 = tablelookup("mp/camoTable.csv", 0, var_3.primarycamo, 1);
    var_14 = var_3.primaryreticle;
    var_15 = tablelookup("mp/reticleTable.csv", 0, var_3.primaryreticle, 1);
    var_16 = var_3.playercardpatch;
    var_17 = var_16;
    var_18 = var_3._id_A7EB;
    var_19 = var_3._id_A7EC;

    if(!var_18)
      var_17 = -1;

    var_20 = maps\mp\gametypes\_class::buildweaponname(var_7, var_9, var_11, var_12, undefined, undefined);
    var_21 = maps\mp\_utility::getbaseweaponname(var_20);
    var_22 = [];
    var_22[level.costumecat2idx["gender"]] = var_3.gender;
    var_22[level.costumecat2idx["shirt"]] = var_3.shirt;
    var_22[level.costumecat2idx["head"]] = var_3.head;
    var_22[level.costumecat2idx["gloves"]] = var_3.gloves;
    var_23 = var_3._id_A7ED;

    if(!isDefined(var_4)) {
      var_5 = maps\mp\_vl_avatar::getnewlobbyavatarownerid(var_3.xuid);
      var_24 = maps\mp\gametypes\vlobby::getspawnpoint(maps\mp\_vl_base::getconstlocalplayer());
      var_4 = maps\mp\_vl_avatar::spawn_an_avatar(var_1, var_24, var_20, var_22, var_23, var_3._id_A7E7, var_5, 0);
      setdvar("virtuallobbymembers", level.vlavatars.size);
      thread maps\mp\_vl_base::setvirtuallobbypresentable();
      var_4._id_A7EA = var_16;
      var_4 _meth_8577(var_19);
      var_4.loadout = var_3;
      var_4.xuid = var_3.xuid;
      var_4.membertimeout = gettime() + 4000;

      if(var_3.player_controller >= 0)
        var_4.controller = var_3.player_controller;

      continue;
    }

    var_5 = maps\mp\_vl_avatar::get_ownerid_for_avatar(var_4);

    if(var_3.player_controller >= 0 && isDefined(var_4.savedcostume))
      var_22 = var_4.savedcostume;

    if(var_3.player_controller >= 0 || maps\mp\_vl_base::loadout_changed(var_4.loadout, var_3) || maps\mp\_vl_base::costume_changed(var_4.costume, var_22)) {
      var_25 = var_4.primaryweapon;
      var_4.loadout = var_3;
      var_4.updateloadout = 1;
      var_4.updatecostume = var_22;

      if(var_3.player_controller >= 0) {
        thread maps\mp\_vl_base::updateavatarloadout(var_1, var_4);
        maps\mp\_vl_cac::updatefactionselection(var_3._id_A7E7);

        if(!level.vl_active) {
          level.vl_focus = var_5;
          var_1 thread maps\mp\_vl_camera::playerupdatecamera();
        }

        level.vl_active = 1;
      } else if(!maps\mp\_utility::is_true(var_4.weapclasschanged)) {
        var_4.weapclasschanged = maps\mp\_vl_base::weaponclass_changed(var_25, var_20);

        if(!var_4.weapclasschanged)
          thread maps\mp\_vl_base::updateavatarloadout(var_1, var_4, var_25);
      }
    }
  }
}

playercacprocesslui_stub(var_0, var_1) {
  if(var_0 == "reset_loadout")
    maps\mp\_vl_cac::resetloadout(var_1);
  else {
    if(maps\mp\_utility::is_true(level.in_depot)) {
      return;
    }
    if(var_0 == "cac")
      maps\mp\_vl_cac::handlecacmodechange(var_1);
    else if(var_0 == "classpreview" || issubstr(var_0, "preset_classpreview"))
      maps\mp\_vl_cac::handleclassselect(var_0, var_1);
    else if(var_0 == "weapon_highlighted" && var_1 != "none") {
      if(maps\mp\_vl_cao::iscollectionsmenuactive())
        maps\mp\_vl_cao::turncollectionsmodeoff();

      maps\mp\_vl_cac::handleweaponhighlighted(var_1);
    } else {
      if(var_0 == "weapon_highlighted" && var_1 == "none") {
        if(maps\mp\_vl_cao::iscollectionsmenuactive())
          maps\mp\_vl_cao::turncollectionsmodeoff();

        //maps\mp\_vl_avatar::hide_avatars();
        //maps\mp\_vl_cac::handlecacweapmodechange( 0 );

        var_6 = "weapons_lobby";
        if(maps\mp\_vl_cao::iscollectionsmenuactive())
          var_6 = "weapons_collection";
        maps\mp\_vl_base::weaponroomscenelightsupdate(var_6);

        thread maps\mp\_vl_cac::setcacweapon("none");

        return;
      }

      if(var_0 == "lootscreen_weapon_highlighted") {
        maps\mp\_vl_cac::handlecacweapmodechange(0);
        maps\mp\_vl_cac::handlecacmodechange(0);
        return;
      }

      if(var_0 == "faction_changed")
        maps\mp\_vl_cac::handlefactionchanged(var_1);
    }
  }
}

handleweaponhighlighted_stub(var_0) {
  var_1 = 0;
  var_2 = strtok(var_0, "_");
  var_3 = "none";
  var_4 = 0;

  if(var_2.size > 1) {
    var_4 = int(var_2[0]);
    var_2 = maps\mp\_utility::array_remove_index(var_2, 0);
    var_3 = maps\mp\_vl_cac::parseweaponhighlightedcategory(var_2[0]);
  }

  if(var_0 != "none" && var_0 != "" && !maps\mp\_vl_cao::iscollectionsmenuactive() && !maps\mp\_vl_cao::isarmorymenuactive()) {
    maps\mp\_vl_avatar::hide_avatars();
    var_5 = maps\mp\_vl_cac::handlecacweapmodechange(1, var_3);

    if(var_5)
      var_1 = 1;
  }

  var_6 = "weapons_lobby";

  if(maps\mp\_vl_cao::iscollectionsmenuactive())
    var_6 = "weapons_collection";

  maps\mp\_vl_base::weaponroomscenelightsupdate(var_6);

  if(var_2.size > 1) {
    var_7 = maps\mp\_vl_cac::parseweaponhighlightedvalue(var_2[0], var_2[1]);
    var_8 = "none";
    var_9 = "none";
    var_10 = 0;
    var_11 = 0;

    if(var_2.size > 3 && var_2.size % 2 == 0) {
      var_12 = (var_2.size - 2) / 2;

      for(var_13 = 0; var_13 < var_12; var_13++) {
        var_14 = var_2[2 + var_13 * 2];
        var_15 = maps\mp\_vl_cac::parseweaponhighlightedcategory(var_2[2 + var_13 * 2]);
        var_16 = var_2[3 + var_13 * 2];

        if(var_15 == "FurnitureKit") {
          var_9 = maps\mp\_vl_cac::parseweaponhighlightedvalue(var_14, var_16);
          if(issubstr(var_9, "tacknife"))
            var_9 = "none";

          continue;
        }

        if(var_15 == "AttachKit") {
          var_8 = maps\mp\_vl_cac::parseweaponhighlightedvalue(var_14, var_16);
          if(issubstr(var_8, "tacknife"))
            var_8 = "none";

          continue;
        }

        if(var_15 == "Camo") {
          var_10 = int(var_16);
          continue;
        }

        if(var_15 == "Reticle")
          var_11 = int(var_16);
      }
    }

    var_17 = -1;

    if(isDefined(self.emblemloadout.emblemindex)) {
      if(self.emblemloadout.shouldapplyemblemtoweapon)
        var_17 = self.emblemloadout.emblemindex;
    } else {
      var_18 = _func_2FA(var_4, common_scripts\utility::getstatsgroup_common(), "applyEmblemToWeapon");

      if(var_18)
        var_17 = _func_2FA(var_4, common_scripts\utility::getstatsgroup_common(), "emblemPatchIndex");
    }

    if(var_7 == "specialty_tacticalinsertion" || var_7 == "specialty_blastshield")
      thread maps\mp\_vl_cac::setcacweapon("none");
    else
      thread maps\mp\_vl_cac::setcacweapon(var_7, var_3, var_8, var_9, var_10, var_11, var_17, var_1);
  } else
    thread maps\mp\_vl_cac::setcacweapon("none");
}

buildweaponnamecac_stub(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(issubstr(var_0, "meleebottle") || issubstr(var_0, "meleejun6") || issubstr(var_0, "meleejun5"))
    var_2 = "lby";

  class_index = maps\mp\_utility::getclassindex("lobby" + self.currentselectedclass);
  custom_class_loc = maps\mp\_utility::cac_getcustomclassloc();
  vl_loadout = maps\mp\_vl_base::getloadoutvl(custom_class_loc, class_index);

  perks = [];
  for(var_9 = 0; var_9 < 3; var_9++)
    perks[var_9] = vl_loadout["perk" + var_9];

  return maps\mp\gametypes\_class::buildWeaponName(var_0, var_1, var_2, var_3, perks, undefined);
}

spawngenericprop3avatar_stub() {
  var_0 = spawn("script_model", (0.0, 0.0, 0.0));
  var_0 setModel("genericprop_x3");
  // var_0 scriptmodelplayanim( "h1_lobby_turnaround_ranger_akimbo_align" );
  return var_0;
}

showloadingweaponavatar_stub(var_0, var_1) {
  setomnvar("ui_cac_weapon_loading", 1);
  maps\mp\_vl_cac::hideweaponavatar();
  maps\mp\_vl_cac::hideperkavatar();
}

showweaponavatar_stub(var_0) {
  var_1 = level.weaponavatarparent.savedweaponavatar;

  if(!isDefined(var_1)) {
    var_1 = spawn("weapon_" + level.cac_weapon, (0.0, 0.0, 0.0), 1);
    var_1.isweapon = 1;
    level.weaponavatarparent.savedweaponavatar = var_1;
    var_1.linker = spawngenericprop3avatar_stub();
  } else
    var_1 show();

  var_1 setpickupweapon(level.cac_weapon, 1);
  var_1.weapon_name = level.cac_weapon;
  var_1.category = var_0;
  var_3 = maps\mp\_vl_cac::isavatarakimbo(var_1);

  if(var_3) {
    if(!isDefined(var_1.akimboavatar)) {
      var_1.akimboavatar = spawn("weapon_" + level.cac_weapon, (0.0, 0.0, 0.0), 1);
      var_1.akimboavatar linktosynchronizedparent(var_1.linker, "j_prop_2", (0.0, 0.0, 0.0), (0.0, 0.0, 0.0));
    } else
      var_1.akimboavatar show();

    var_1.akimboavatar setpickupweapon(level.cac_weapon, 1);
    var_1 linktosynchronizedparent(var_1.linker, "j_prop_1", (0.0, 0.0, 0.0), (0.0, 0.0, 0.0));
  } else {
    if(isDefined(var_1.akimboavatar))
      var_1.akimboavatar hide();

    var_1 linktosynchronizedparent(var_1.linker, "j_prop_3", (0.0, 0.0, 0.0), (0.0, 0.0, 0.0));
  }

  maps\mp\_vl_cac::positionweaponavatar(var_1, var_0);
  level.weaponavatarparent.weaponavatar = var_1;
  maps\mp\_vl_base::prep_for_controls(level.weaponavatarparent);
}