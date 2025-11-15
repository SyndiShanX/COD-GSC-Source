main() {
  // h1-mod patches
  replacefunc(maps\mp\gametypes\_class::isvalidprimary, ::isvalidprimary);
  replacefunc(maps\mp\gametypes\_class::isvalidsecondary, ::isvalidsecondary);
  replacefunc(maps\mp\gametypes\_class::isvalidweapon, ::isvalidweapon);
  replacefunc(maps\mp\gametypes\_class::buildweaponname, ::buildweaponname);

  // h2m patches
  replacefunc(maps\mp\gametypes\_class::isvalidmeleeweapon, ::isvalidmeleeweapon);
  replacefunc(maps\mp\gametypes\_class::isvalidattachment, ::isvalidattachment);
  replacefunc(maps\mp\gametypes\_class::isvalidequipment, ::isvalidequipment);
  replacefunc(maps\mp\gametypes\_class::giveoffhand, ::giveoffhand);
  replacefunc(maps\mp\gametypes\_class::takeoffhand, ::takeoffhand);

  // use attachkits instead of furnitekits
  replacefunc(maps\mp\_utility::getmatchrulesspecialclass, ::getmatchrulesspecialclass);
  replacefunc(maps\mp\gametypes\_class::cac_getweaponfurniturekit, ::cac_getweaponfurniturekit);
  replacefunc(maps\mp\gametypes\_class::furniturekitnametoid, ::furniturekitnametoid);
  replacefunc(maps\mp\gametypes\_class::isvalidfurniturekit, ::isvalidfurniturekit);
  replacefunc(maps\mp\gametypes\_class::getloadout, ::getloadout);
  replacefunc(maps\mp\gametypes\_class::table_getweaponfurniturekit, ::table_getweaponfurniturekit);
  replacefunc(maps\mp\gametypes\_class::isvalidattachkit, ::isvalidattachkit);
  replacefunc(maps\mp\gametypes\_class::addAutomaticAttachments, ::addAutomaticAttachments);
  replacefunc(maps\mp\gametypes\_class::applyloadout, ::applyloadout);
  replacefunc(maps\mp\gametypes\_class::isvalidcamo, ::isvalidcamo);

  setthermalbodymaterial("m/white_scope_def");
}

is_perk_actually_weapon(perk) {
  return (perk != "specialty_tacticalinsertion" && perk != "specialty_blastshield");
}

applyloadout() {
  var_0 = self.loadout;

  if(!isDefined(self.loadout)) {
    return;
  }
  self.loadout = undefined;
  self.spectatorviewloadout = var_0;
  self takeallweapons();
  maps\mp\_utility::_clearperks();
  maps\mp\gametypes\_class::_detachall();
  self.changingweapon = undefined;

  if(var_0.copycatloadout)
    self.curclass = "copycat";

  self.class_num = var_0.class_num;
  self.loadoutprimary = var_0.primary;
  self.loadoutprimarycamo = int(tablelookup("mp/camoTable.csv", 1, var_0.primarycamo, 0));
  self.loadoutsecondary = var_0.secondary;
  self.loadoutsecondarycamo = int(tablelookup("mp/camoTable.csv", 1, var_0.secondarycamo, 0));

  if(!issubstr(var_0.primary, "iw5") && !issubstr(var_0.primary, "h1_") && !issubstr(var_0.primary, "h2_"))
    self.loadoutprimarycamo = 0;

  if(!issubstr(var_0.secondary, "iw5") && !issubstr(var_0.secondary, "h1_") && !issubstr(var_0.secondary, "h2_"))
    self.loadoutsecondarycamo = 0;

  self.loadoutprimaryreticle = int(tablelookup("mp/reticleTable.csv", 1, var_0.primaryreticle, 0));
  self.loadoutsecondaryreticle = int(tablelookup("mp/reticleTable.csv", 1, var_0.secondaryreticle, 0));

  if(!issubstr(var_0.primary, "iw5") && !issubstr(var_0.primary, "h1_") && !issubstr(var_0.primary, "h2_"))
    self.loadoutprimaryreticle = 0;

  if(!issubstr(var_0.secondary, "iw5") && !issubstr(var_0.secondary, "h1_") && !issubstr(var_0.secondary, "h2_"))
    self.loadoutsecondaryreticle = 0;

  self.loadoutmelee = var_0.meleeweapon;

  if(isDefined(var_0.juggernaut) && var_0.juggernaut) {
    self.health = self.maxhealth;
    thread maps\mp\_utility::recipeclassapplyjuggernaut(maps\mp\_utility::isjuggernaut());
    self.isjuggernaut = 1;
    self.juggmoveSpeedScaler = 0.7;
  } else if(maps\mp\_utility::isjuggernaut()) {
    self notify("lost_juggernaut");
    self.isjuggernaut = 0;
    self.moveSpeedScaler = level.baseplayermovescale;
  }

  var_2 = var_0.secondaryname;

  if(var_2 != "none") {
    // Liam - 21/02/2024 onemanarmy implementation
    can_give_secondary = true;

    if(isDefined(var_0.perks) && var_0.perks.size > 0) {
      if(var_0.perks[0] == "specialty_onemanarmy" || var_0.perks[0] == "specialty_omaquickchange") {
        can_give_secondary = false;

        if(!maps\mp\_utility::invirtuallobby())
          maps\mp\_utility::_giveweapon("onemanarmy_mp");
      }
    }

    if(can_give_secondary)
      maps\mp\_utility::_giveweapon(var_2);

    if(level.oldschool)
      maps\mp\gametypes\_oldschool::givestartammooldschool(var_2);
  }

  if(level.diehardmode)
    maps\mp\_utility::giveperk("specialty_pistoldeath", 0);

  maps\mp\gametypes\_class::loadoutallperks(var_0);
  maps\mp\perks\_perks::applyperks();

  if(var_0.equipment == "specialty_tacticalinsertion") {
    self maps\mp\_utility::giveperk("specialty_tacticalinsertion", 0);
    self setlethalweapon("flare_mp");
  } else if(var_0.equipment == "specialty_blastshield") {
    self maps\mp\_utility::giveperk("specialty_blastshield", 0);
    self setlethalweapon("none");
  } else
    self setlethalweapon(var_0.equipment);

  if(isDefined(var_0.equipment) && var_0.equipment != "specialty_null" &&
    (is_perk_actually_weapon(var_0.equipment) && self hasweapon(var_0.equipment))) {
    self setweaponammoclip(var_0.equipment, weaponStartAmmo(var_0.equipment));
  } else
    giveoffhand(var_0.equipment);

  var_5 = var_0.primaryname;
  maps\mp\_utility::_giveweapon(var_5);

  if(level.oldschool)
    maps\mp\gametypes\_oldschool::givestartammooldschool(var_5);

  if(!isai(self) && !maps\mp\_utility::ishodgepodgemm())
    self switchtoweapon(var_5);

  if(var_0.setprimaryspawnweapon)
    self setspawnweapon(maps\mp\_utility::get_spawn_weapon_name(var_0));
  self.pers["primaryWeapon"] = maps\mp\_utility::getbaseweaponname(var_5);
  self.loadoutoffhand = var_0.offhand;
  self settacticalweapon(var_0.offhand);

  if(!level.oldschool)
    giveoffhand(var_0.offhand);

  self setweaponammoclip(var_0.offhand, weaponStartAmmo(var_0.offhand));

  if(level.oldschool)
    self setweaponammoclip(var_0.offhand, 0);

  var_6 = var_5;
  self.primaryweapon = var_6;
  self.secondaryweapon = var_2;

  if(var_0.clearammo) {
    self setweaponammoclip(self.primaryweapon, 0);
    self setweaponammostock(self.primaryweapon, 0);
  }

  self.issniper = weaponclass(self.primaryweapon) == "sniper";
  maps\mp\_utility::_setactionslot(1, "nightvision");
  maps\mp\perks\_perks::giveperkinventory();
  maps\mp\_utility::_setactionslot(4, "");

  if(!level.console) {
    maps\mp\_utility::_setactionslot(5, "");
    maps\mp\_utility::_setactionslot(6, "");
    maps\mp\_utility::_setactionslot(7, "");
    maps\mp\_utility::_setactionslot(8, "");
  }

  if(maps\mp\_utility::_hasperk("specialty_extraammo")) {
    self givemaxammo(var_5);

    if(var_2 != "none")
      self givemaxammo(var_2);
  }

  if(!issubstr(var_0.class, "juggernaut")) {
    if(isDefined(self.lastclass) && self.lastclass != "" && self.lastclass != self.class)
      self notify("changed_class");

    self.pers["lastClass"] = self.class;
    self.lastclass = self.class;
  }

  if(isDefined(self.gamemode_chosenclass)) {
    self.pers["class"] = self.gamemode_chosenclass;
    self.pers["lastClass"] = self.gamemode_chosenclass;
    self.class = self.gamemode_chosenclass;

    if(!isDefined(self.gamemode_carrierclass))
      self.lastclass = self.gamemode_chosenclass;

    self.gamemode_chosenclass = undefined;
  }

  self.gamemode_carrierclass = undefined;

  if(!isDefined(level.iszombiegame) || !level.iszombiegame) {
    if(!isDefined(self.costume)) {
      if(isplayer(self))
        self.costume = maps\mp\gametypes\_class::cao_getactivecostume();
      else if(isagent(self) && self.agent_type == "player")
        self.costume = maps\mp\gametypes\_teams::getdefaultcostume();
    }

    if(maps\mp\_utility::invirtuallobby() && isDefined(level.vl_cac_getfactionteam) && isDefined(level.vl_cac_getfactionenvironment)) {
      var_7 = [
        [level.vl_cac_getfactionteam]
      ]();
      var_8 = [
        [level.vl_cac_getfactionenvironment]
      ]();
      maps\mp\gametypes\_teams::applycostume(var_6, var_7, var_8);
    } else if(level.teambased)
      maps\mp\gametypes\_teams::applycostume();
    else
      maps\mp\gametypes\_teams::applycostume(var_6, self.team);

    maps\mp\gametypes\_class::logplayercostume();
    self _meth_857C(var_0._id_A7ED);
  }

  self maps\mp\gametypes\_weapons::updatemovespeedscale("primary");

  maps\mp\perks\_perks::cac_selector();

  loadoutDeathStreak = var_0.deathstreak;

  // only give the deathstreak for the initial spawn for this life.
  if(isDefined(loadoutDeathStreak) && loadoutDeathStreak != "specialty_null" && gettime() == self.spawnTime) {
    if(loadoutDeathStreak == "specialty_copycat")
      deathVal = 3;
    else if(loadoutDeathStreak == "specialty_combathigh")
      deathVal = 5;
    else
      deathVal = 4;

    if(self maps\mp\_utility::_hasPerk("specialty_rollover"))
      deathVal -= 1;

    if(isDefined(self.pers["cur_death_streak"]) && self.pers["cur_death_streak"] >= deathVal) {
      self thread maps\mp\_utility::givePerk(loadoutDeathStreak);
    }
  }

  self notify("changed_kit");
  self notify("applyloadout");
}

table_getweaponfurniturekit(var_0, var_1, var_2) {
  return maps\mp\gametypes\_class::table_getweaponattachkit(var_0, var_1, var_2);
}

isvalidattachkit(var_0, var_1, var_2) {
  if(!isDefined(var_0) || var_0 == "" || var_0 == "none")
    return 1;

  var_3 = _func_304("mp/attachkits.csv", 1, var_0);

  if(var_3 <= 0) {
    if(maps\mp\_utility::is_true(var_2))
      foundinfraction("Replacing invalid attachKit " + var_0);

    return 0;
  }

  if(var_1 == "h1_mp44" || var_1 == "h1_deserteagle" || var_1 == "h1_deserteagle55") {
    var_4 = tablelookupbyrow("mp/attachkits.csv", var_3, 7);
    var_5 = getinventoryitemtype(var_4);

    if(var_5 == "default") {
      if(maps\mp\_utility::is_true(var_2))
        foundinfraction("Replacing invalid attachKit " + var_0);

      return 0;
    }
  }

  var_6 = tablelookupbyrow("mp/attachkits.csv", var_3, 6);

  if(var_6 == "")
    return 1;

  var_7 = maps\mp\_utility::getweaponclass(var_1);
  var_8 = "";

  switch (var_7) {
    case "weapon_assault":
      var_8 = "ast";
      break;
    case "weapon_smg":
      var_8 = "smg";
      break;
    case "weapon_lmg":
    case "weapon_heavy":
      var_8 = "lmg";
      break;
    case "weapon_sniper":
      var_8 = "snp";
      break;
    case "weapon_shotgun":
    case "weapon_secondary_shotgun":
      var_8 = "sht";
      break;
    case "weapon_pistol":
    case "weapon_secondary_machine_pistol":
      var_8 = "pst";
      break;
    default:
      break;
  }

  var_9 = 0;

  if(var_8 != "") {
    var_10 = strtok(var_6, " ");

    foreach(var_12 in var_10) {
      if(var_12 == var_8) {
        var_9 = 1;
        break;
      }
    }
  }

  if(!var_9 && maps\mp\_utility::is_true(var_2)) {
    foundinfraction("Replacing invalid attachKit " + var_0);
    return 0;
  }

  return 1;
}

getloadout(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  var_5 = 0;
  var_6 = undefined;
  var_7 = 0;
  var_8 = undefined;
  var_9 = issubstr(var_1, "custom");
  var_10 = 0;
  var_11 = [];
  var_12 = var_1 == "gamemode";

  if(issubstr(var_1, "axis"))
    var_13 = "axis";
  else if(issubstr(var_1, "allies"))
    var_13 = "allies";
  else
    var_13 = "none";

  var_14 = [];

  if(isDefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && var_2) {
    var_10 = 1;
    var_9 = 0;
    var_6 = maps\mp\_utility::getclassindex("copycat");
    var_14 = self.pers["copyCatLoadout"];
    var_15 = var_14["loadoutPrimary"];
    var_16 = var_14["loadoutPrimaryAttachKit"];
    var_17 = var_14["loadoutPrimaryFurnitureKit"];
    var_18 = var_14["loadoutPrimaryCamo"];
    var_19 = var_14["loadoutPrimaryReticle"];
    var_20 = var_14["loadoutSecondary"];
    var_21 = var_14["loadoutSecondaryAttachKit"];
    var_22 = var_14["loadoutSecondaryFurnitureKit"];
    var_23 = var_14["loadoutSecondaryCamo"];
    var_24 = var_14["loadoutSecondaryReticle"];
    var_25 = var_14["loadoutEquipment"];
    var_26 = var_14["loadoutOffhand"];

    for(var_27 = 0; var_27 < 3; var_27++)
      var_11[var_27] = var_14["loadoutPerks"][var_27];

    var_28 = var_14["loadoutMelee"];
  } else if(var_13 != "none") {
    var_29 = maps\mp\_utility::getclassindex(var_1);
    var_6 = var_29;
    self.class_num = var_29;
    self.teamname = var_13;
    var_15 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "weaponSetups", 0, "weapon");

    if(var_15 == "none") {
      var_15 = "h1_ak47";
      var_16 = "none";
      var_17 = "none";
    } else {
      var_30 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "weaponSetups", 0, "kit", "attachKit");
      var_31 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "weaponSetups", 0, "kit", "furnitureKit");
      var_16 = tablelookup("mp/attachkits.csv", 0, common_scripts\utility::tostring(var_30), 1);
      var_17 = tablelookup("mp/attachkits.csv", 0, common_scripts\utility::tostring(var_31), 1);
    }

    var_18 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "weaponSetups", 0, "camo");
    var_19 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "weaponSetups", 0, "reticle");
    var_20 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "weaponSetups", 1, "weapon");
    var_30 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "weaponSetups", 1, "kit", "attachKit");
    var_31 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "weaponSetups", 1, "kit", "furnitureKit");
    var_21 = tablelookup("mp/attachkits.csv", 0, common_scripts\utility::tostring(var_30), 1);
    var_22 = tablelookup("mp/attachkits.csv", 0, common_scripts\utility::tostring(var_31), 1);
    var_23 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "weaponSetups", 1, "camo");
    var_24 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "weaponSetups", 1, "reticle");
    var_25 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "equipment", 0);
    var_26 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "equipment", 1);

    for(var_27 = 0; var_27 < 3; var_27++)
      var_11[var_27] = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "perkSlots", var_27);

    var_28 = getmatchrulesdata("defaultClasses", var_13, "defaultClass", var_29, "class", "meleeWeapon");

    if(var_15 == "none" && var_20 != "none") {
      var_15 = var_20;
      var_16 = var_21;
      var_17 = var_22;
      var_18 = var_23;
      var_19 = var_24;
      var_20 = "none";
      var_21 = "none";
      var_22 = "none";
      var_23 = "none";
      var_24 = "none";
    } else if(var_15 == "none" && var_20 == "none") {
      var_5 = 1;
      var_15 = "h1_beretta";
      var_16 = "none";
      var_17 = "none";
    }
  } else if(issubstr(var_1, "custom")) {
    var_6 = maps\mp\_utility::getclassindex(var_1);
    var_15 = maps\mp\gametypes\_class::cac_getweapon(var_6, 0);
    var_16 = maps\mp\gametypes\_class::cac_getweaponattachkit(var_6, 0);
    var_17 = cac_getweaponfurniturekit(var_6, 0);
    var_18 = maps\mp\gametypes\_class::cac_getweaponcamo(var_6, 0);
    var_19 = maps\mp\gametypes\_class::cac_getweaponreticle(var_6, 0);
    var_20 = maps\mp\gametypes\_class::cac_getweapon(var_6, 1);
    var_21 = maps\mp\gametypes\_class::cac_getweaponattachkit(var_6, 1);
    var_22 = cac_getweaponfurniturekit(var_6, 1);
    var_23 = maps\mp\gametypes\_class::cac_getweaponcamo(var_6, 1);
    var_24 = maps\mp\gametypes\_class::cac_getweaponreticle(var_6, 1);
    var_25 = maps\mp\gametypes\_class::cac_getequipment(var_6, 0);
    var_26 = maps\mp\gametypes\_class::cac_getequipment(var_6, 1);

    for(var_27 = 0; var_27 < 3; var_27++)
      var_11[var_27] = maps\mp\gametypes\_class::cac_getperk(var_6, var_27);

    var_28 = maps\mp\gametypes\_class::cac_getmeleeweapon(var_6);
  } else if(issubstr(var_1, "lobby")) {
    var_6 = maps\mp\_utility::getclassindex(var_1);
    var_32 = maps\mp\_utility::cac_getcustomclassloc();
    var_33 = [[level.vl_loadoutfunc]](var_32, var_6);
    var_15 = var_33["primary"];
    var_16 = var_33["primaryAttachKit"];
    var_17 = var_33["primaryFurnitureKit"];
    var_18 = var_33["primaryCamo"];
    var_19 = var_33["primaryReticle"];
    var_20 = var_33["secondary"];
    var_21 = var_33["secondaryAttachKit"];
    var_22 = var_33["secondaryFurnitureKit"];
    var_23 = var_33["secondaryCamo"];
    var_24 = var_33["secondaryReticle"];
    var_25 = var_33["equipment"];
    var_26 = var_33["offhand"];

    for(var_27 = 0; var_27 < 3; var_27++)
      var_11[var_27] = var_33["perk" + var_27];

    var_28 = var_33["meleeWeapon"];
  } else if(var_12) {
    var_34 = self.pers["gamemodeLoadout"];
    var_15 = var_34["loadoutPrimary"];
    var_16 = var_34["loadoutPrimaryAttachKit"];
    var_17 = var_34["loadoutPrimaryFurnitureKit"];
    var_18 = var_34["loadoutPrimaryCamo"];
    var_19 = var_34["loadoutPrimaryReticle"];
    var_20 = var_34["loadoutSecondary"];
    var_21 = var_34["loadoutSecondaryAttachKit"];
    var_22 = var_34["loadoutSecondaryFurnitureKit"];
    var_23 = var_34["loadoutSecondaryCamo"];
    var_24 = var_34["loadoutSecondaryReticle"];
    var_25 = var_34["loadoutEquipment"];
    var_26 = var_34["loadoutOffhand"];

    if(var_26 == "specialty_null")
      var_26 = "none";

    for(var_27 = 0; var_27 < 3; var_27++)
      var_11[var_27] = var_34["loadoutPerks"][var_27];

    var_28 = var_34["loadoutMelee"];
  } else if(var_1 == "callback") {
    if(!isDefined(self.classcallback))
      common_scripts\utility::error("self.classCallback function reference required for class 'callback'");

    var_35 = [[self.classcallback]](var_4);

    if(!isDefined(var_35))
      common_scripts\utility::error("array required from self.classCallback for class 'callback'");

    var_15 = var_35["loadoutPrimary"];
    var_16 = var_35["loadoutPrimaryAttachKit"];
    var_17 = var_35["loadoutPrimaryFurnitureKit"];
    var_18 = var_35["loadoutPrimaryCamo"];
    var_19 = var_35["loadoutPrimaryReticle"];
    var_20 = var_35["loadoutSecondary"];
    var_21 = var_35["loadoutSecondaryAttachKit"];
    var_22 = var_35["loadoutSecondaryFurnitureKit"];
    var_23 = var_35["loadoutSecondaryCamo"];
    var_24 = var_35["loadoutSecondaryReticle"];
    var_25 = var_35["loadoutEquipment"];
    var_26 = var_35["loadoutOffhand"];
    var_11[0] = var_35["loadoutPerk1"];
    var_11[1] = var_35["loadoutPerk2"];
    var_11[2] = var_35["loadoutPerk3"];
    var_28 = var_35["loadoutMelee"];
  } else {
    var_6 = maps\mp\_utility::getclassindex(var_1);
    var_15 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_6, 0);
    var_16 = maps\mp\gametypes\_class::table_getweaponattachkit(level.classtablename, var_6, 0);
    var_17 = table_getweaponfurniturekit(level.classtablename, var_6, 0);
    var_18 = maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_6, 0);
    var_19 = maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename, var_6, 0);
    var_20 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, var_6, 1);
    var_21 = maps\mp\gametypes\_class::table_getweaponattachkit(level.classtablename, var_6, 1);
    var_22 = table_getweaponfurniturekit(level.classtablename, var_6, 1);
    var_23 = maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, var_6, 1);
    var_24 = maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename, var_6, 1);
    var_25 = maps\mp\gametypes\_class::table_getequipment(level.classtablename, var_6);
    var_26 = maps\mp\gametypes\_class::table_getoffhand(level.classtablename, var_6);
    var_11[0] = maps\mp\gametypes\_class::table_getperk(level.classtablename, var_6, 0);
    var_11[1] = maps\mp\gametypes\_class::table_getperk(level.classtablename, var_6, 1);
    var_11[2] = maps\mp\gametypes\_class::table_getperk(level.classtablename, var_6, 2);
    var_28 = "none";
  }

  var_36 = issubstr(var_1, "custom") || issubstr(var_1, "lobby");
  var_37 = issubstr(var_1, "recipe");
  var_38 = 0;

  if(!var_12 && !var_37 && !level.oldschool && !(isDefined(self.pers["copyCatLoadout"]) && self.pers["copyCatLoadout"]["inUse"] && var_2)) {
    if(!isvalidprimary(var_15, 1) || level.rankedmatch && var_36 && !var_38 && !self isitemunlocked(var_15)) {
      var_15 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, 10, 0);
      var_18 = "none";
      var_19 = "none";
      var_16 = "none";
      var_17 = "none";
    }

    if(!maps\mp\gametypes\_class::isvalidcamo(var_18, 1) || level.rankedmatch && var_36 && !var_38 && !maps\mp\gametypes\_class::iscamounlocked(var_15, var_18))
      var_18 = maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, 10, 0);

    if(!maps\mp\gametypes\_class::isvalidreticle(var_19, 1))
      var_19 = maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename, 10, 0);

    if(!maps\mp\gametypes\_class::isvalidattachkit(var_16, var_15, 1) || level.rankedmatch && var_36 && !var_38 && !maps\mp\gametypes\_class::isattachkitunlocked(var_15, var_16))
      var_16 = maps\mp\gametypes\_class::table_getweaponattachkit(level.classtablename, 10, 0);

    if(!maps\mp\gametypes\_class::isvalidfurniturekit(var_17, var_15, 1) || level.rankedmatch && var_36 && !var_38 && !maps\mp\gametypes\_class::isfurniturekitunlocked(var_15, var_17))
      var_17 = table_getweaponfurniturekit(level.classtablename, 10, 0);

    var_40 = common_scripts\utility::array_contains(var_11, "specialty_twoprimaries");

    if(!isvalidsecondary(var_20, var_40, 1) || level.rankedmatch && var_36 && !var_38 && !self isitemunlocked(var_20)) {
      var_20 = maps\mp\gametypes\_class::table_getweapon(level.classtablename, 10, 1);
      var_23 = "none";
      var_24 = "none";
      var_21 = "none";
      var_22 = "none";
    }

    if(!maps\mp\gametypes\_class::isvalidcamo(var_23, 1) || level.rankedmatch && var_36 && !var_38 && !maps\mp\gametypes\_class::iscamounlocked(var_20, var_23))
      var_23 = maps\mp\gametypes\_class::table_getweaponcamo(level.classtablename, 10, 1);

    if(!maps\mp\gametypes\_class::isvalidreticle(var_24, 1))
      var_24 = maps\mp\gametypes\_class::table_getweaponreticle(level.classtablename, 10, 1);

    if(!maps\mp\gametypes\_class::isvalidattachkit(var_21, var_20, 1) || level.rankedmatch && var_36 && !var_38 && !maps\mp\gametypes\_class::isattachkitunlocked(var_20, var_21))
      var_21 = maps\mp\gametypes\_class::table_getweaponattachkit(level.classtablename, 10, 1);

    if(!isvalidfurniturekit(var_22, var_20, 1) || level.rankedmatch && var_36 && !var_38 && !maps\mp\gametypes\_class::isfurniturekitunlocked(var_20, var_22))
      var_22 = table_getweaponfurniturekit(level.classtablename, 10, 1);

    if(!maps\mp\gametypes\_class::isvalidequipment(var_25, 1) || level.rankedmatch && var_36 && !var_38 && !self isitemunlocked(var_25))
      var_25 = maps\mp\gametypes\_class::table_getequipment(level.classtablename, 10);

    if(var_25 == var_26)
      var_25 = "specialty_null";

    if(!maps\mp\gametypes\_class::isvalidoffhand(var_26, 1))
      var_26 = maps\mp\gametypes\_class::table_getoffhand(level.classtablename, 10);

    if(!maps\mp\gametypes\_class::isvalidmeleeweapon(var_28, 1))
      var_28 = "none";
  }

  for(var_27 = 0; var_27 < 3; var_27++) {
    if(var_11[var_27] == "specialty_null") {
      continue;
    }
    var_41 = var_11[var_27];
    var_11[var_27] = maps\mp\perks\_perks::validateperk(var_27, var_11[var_27]);

    if(var_41 != var_11[var_27])
      foundinfraction("^1Warning: Perk " + var_41 + " in wrong slot.");

    if(var_27 == 0 && var_11[var_27] != "specialty_null" && (maps\mp\gametypes\_class::isgrenadelauncher(var_16) || maps\mp\gametypes\_class::isgrenadelauncher(var_21))) {
      foundinfraction("^1Warning: Player has a perk " + var_41 + " in slot 1 and a grenade launcher too.");
      var_11[0] = "specialty_null";
    }

    if(var_27 == 0 && var_11[var_27] != "specialty_null" && (maps\mp\gametypes\_class::isgrip(var_16) || maps\mp\gametypes\_class::isgrip(var_21))) {
      foundinfraction("^1Warning: Player has a perk " + var_41 + " in slot 1 and a foregrip too.");
      var_11[0] = "specialty_null";
    }

    if(var_27 == 0 && var_11[var_27] == "specialty_specialgrenade" && var_26 == "h1_smokegrenade_mp") {
      foundinfraction("^1Warning: Player has perk specialty_specialgrenade in slot 1 and smoke grenades too.");
      var_11[0] = "specialty_null";
    }
  }

  var_42 = 0;
  var_43 = 0;
  var_44 = 0;

  if(maps\mp\_utility::invirtuallobby()) {
    var_42 = self.emblemloadout.emblemindex;
    var_43 = self.emblemloadout.shouldapplyemblemtoweapon;
    var_44 = self.emblemloadout.shouldapplyemblemtocharacter;
  } else {
    var_42 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "emblemPatchIndex");

    if(isai(self)) {
      var_43 = self.pers["shouldApplyEmblemToWeapon"];
      var_44 = self.pers["shouldApplyEmblemToCharacter"];
    } else {
      var_43 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "applyEmblemToWeapon");
      var_44 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "applyEmblemToCharacter");
    }
  }

  var_45 = var_42;

  if(!var_43)
    var_45 = -1;

  var_46 = 0;

  if(maps\mp\_utility::invirtuallobby())
    var_46 = self.charactercamoloadout.camoindex;
  else
    var_46 = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "characterCamoIndex");

  var_33 = spawnStruct();
  var_33.class = var_1;
  var_33.class_num = var_6;
  var_33.teamname = var_13;
  var_33.clearammo = var_5;
  var_33.copycatloadout = var_10;
  var_33.cacloadout = var_9;
  var_33.isgamemodeclass = var_12;
  var_33.primary = var_15;
  var_33.primaryattachkit = var_16;
  var_33.primaryfurniturekit = var_17;
  var_33.primarycamo = var_18;
  var_33.primaryreticle = var_19;
  var_18 = int(tablelookup("mp/camoTable.csv", 1, var_33.primarycamo, 0));
  var_19 = int(tablelookup("mp/reticleTable.csv", 1, var_33.primaryreticle, 0));
  var_33.primaryname = buildweaponname(var_33.primary, var_33.primaryattachkit, var_33.primaryfurniturekit, var_18, var_11);
  var_33.secondary = var_20;
  var_33.secondaryattachkit = var_21;
  var_33.secondaryfurniturekit = var_22;
  var_33.secondarycamo = var_23;
  var_33.secondaryreticle = var_24;
  var_23 = int(tablelookup("mp/camoTable.csv", 1, var_33.secondarycamo, 0));
  var_24 = int(tablelookup("mp/reticleTable.csv", 1, var_33.secondaryreticle, 0));
  var_33.secondaryname = buildweaponname(var_33.secondary, var_33.secondaryattachkit, var_33.secondaryfurniturekit, var_23, var_11);
  var_33.equipment = var_25;
  var_33.offhand = var_26;
  var_33.perks = var_11;
  var_33.deathstreak = var_28;

  var_33.setprimaryspawnweapon = var_3;
  var_33.emblemindex = var_42;
  var_33.weaponemblemindex = var_45;
  var_33._id_A7EC = var_44;
  var_33._id_A7ED = var_46;

  if(maps\mp\_utility::is_true(level.movecompareactive) && isDefined(level.movecompareloadoutfunc))
    var_33 = self[[level.movecompareloadoutfunc]]();

  return var_33;
}

foundinfraction(why) {
  print(why);
}

isvalidfurniturekit(var_0, var_1, var_2) {
  return maps\mp\gametypes\_class::isvalidattachkit(var_0, var_1, var_2);
}

furniturekitnametoid(var_0) {
  var_1 = tablelookup("mp/attachkits.csv", 1, var_0, 0);
  var_1 = int(var_1);
  return var_1;
}

cac_getweaponfurniturekit(var_0, var_1, var_2) {
  var_3 = maps\mp\gametypes\_class::cac_getweaponfurniturekitid(var_0, var_1, var_2);
  var_4 = tablelookup("mp/attachkits.csv", 0, common_scripts\utility::tostring(var_3), 1);
  return var_4;
}

getmatchrulesspecialclass(var_0, var_1) {
  var_2 = [];
  var_2["loadoutPrimary"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "weapon");
  var_3 = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "kit", "attachKit");
  var_4 = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "kit", "furnitureKit");
  var_2["loadoutPrimaryAttachKit"] = tablelookup("mp/attachkits.csv", 0, common_scripts\utility::tostring(var_3), 1);
  var_2["loadoutPrimaryFurnitureKit"] = tablelookup("mp/attachkits.csv", 0, common_scripts\utility::tostring(var_4), 1);
  var_2["loadoutPrimaryCamo"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "camo");
  var_2["loadoutPrimaryReticle"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 0, "reticle");
  var_2["loadoutSecondary"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "weapon");
  var_3 = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "kit", "attachKit");
  var_4 = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "kit", "furnitureKit");
  var_2["loadoutSecondaryAttachKit"] = tablelookup("mp/attachkits.csv", 0, common_scripts\utility::tostring(var_3), 1);
  var_2["loadoutSecondaryFurnitureKit"] = tablelookup("mp/attachkits.csv", 0, common_scripts\utility::tostring(var_4), 1);
  var_2["loadoutSecondaryCamo"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "camo");
  var_2["loadoutSecondaryReticle"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "weaponSetups", 1, "reticle");
  var_2["loadoutEquipment"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "equipment", 0);
  var_2["loadoutOffhand"] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "equipment", 1);

  for(var_5 = 0; var_5 < 3; var_5++)
    var_2["loadoutPerks"][var_5] = getmatchrulesdata("defaultClasses", var_0, "defaultClass", var_1, "class", "perkSlots", var_5);

  var_2["loadoutMelee"] = "none";
  return var_2;
}

isvalidcamo(var_0, var_1) {
  switch (var_0) {
    case "none":
    case "camo016":
    case "camo017":
    case "camo018":
    case "camo019":
    case "camo020":
    case "camo021":
    case "camo022":
    case "camo023":
    case "camo024":
    case "camo025":
    case "camo026":
    case "camo027":
    case "camo028":
    case "camo029":
    case "camo030":
    case "camo031":
    case "camo032":
    case "camo033":
    case "camo034":
    case "camo035":
    case "camo036":
    case "camo037":
    case "camo038":
    case "camo039":
    case "camo040":
    case "camo041":
    case "camo042":
    case "camo043":
    case "camo044":
    case "camo045":
    case "camo046":
    case "camo047":
    case "camo048":
    case "camo049":
    case "camo050":
    case "camo051":
    case "camo052":
    case "camo053":
    case "camo054":
    case "toxicwaste":
    case "camo056":
    case "camo057":
    case "camo058":
    case "golddiamond":
    case "gold":
      return 1;
    default:
      if(maps\mp\_utility::is_true(var_1))
        maps\mp\gametypes\_class::foundinfraction("Replacing invalid camo: " + var_0);

      return 0;
  }
}

find_in_table(csv, weap) {
  rows = tablegetrowcount(csv);

  for(i = 0; i < rows; i++) {
    if(tablelookupbyrow(csv, i, 0) == weap) {
      return true;
    }
  }

  return false;
}

get_attachment_override(weapon, attachment) {
  csv = "mp/attachoverrides.csv";
  rows = tablegetrowcount(csv);

  if(!issubstr(weapon, "_mp")) {
    weapon += "_mp";
  }

  for(i = 0; i < rows; i++) {
    if(tablelookupbyrow(csv, i, 0) == weapon && tablelookupbyrow(csv, i, 1) == attachment) {
      return tablelookupbyrow(csv, i, 2);
    }
  }
}

get_attachment_name(weapon, attachment) {
  name = tablelookup("mp/attachkits.csv", 1, attachment, 2);
  override = get_attachment_override(weapon, name);

  if(isDefined(override) && override != "") {
    return override;
  }

  return name;
}

is_custom_weapon(weap) {
  return find_in_table("mp/customweapons.csv", weap);
}

h2_buildweaponname(baseName, attachment1, attachment2, camo, perks) {
  weaponName = baseName;

  attachments = [];
  attachments[attachments.size] = attachment1;

  perk1 = "";
  if(isDefined(perks) && typeof(perks) == "array" && perks.size > 0) {
    perk1 = perks[0];
  }

  if(perk1 == "specialty_bling" || perk1 == "specialty_secondarybling")
    attachments[attachments.size] = attachment2;

  attachments = common_scripts\utility::array_remove(attachments, "none");

  weapon_class = maps\mp\_utility::getweaponclass(weaponName);
  if(weapon_class == "weapon_sniper") {
    if(isDefined(self.pers["class"])) {
      class_index = maps\mp\_utility::getclassindex(self.pers["class"]);
      if(isDefined(class_index)) {
        should_use_classic = self getcacplayerdata(class_index, "use2dScopes");
        if(should_use_classic) {
          attachments = common_scripts\utility::array_remove(attachments, "acogh2");
          attachments = common_scripts\utility::array_remove(attachments, "thermal");
          attachments[attachments.size] = "ogscope";
        }
      }
    }
  }

  if(isDefined(attachments.size) && attachments.size) {
    attachments = common_scripts\utility::alphabetize(attachments);
  }

  foreach(attachment in attachments) {
    name = get_attachment_name(baseName, attachment);
    if(isDefined(name) && name != "")
      attachment = name;

    if(issubstr(weaponName, "_" + attachment))
      weaponName = weaponName;
    else
      weaponName += "_" + attachment;

    if(attachment == "gl" || attachment == "glak47")
      weaponName += "_glpre";

    if(attachment == "sho")
      weaponName += "_shopre";
  }

  if(isSubStr(weaponName, "at4_") || isSubStr(weaponName, "stinger_") || isSubStr(weaponName, "javelin_") || IsSubStr(weaponName, "h2_") || IsSubStr(weaponName, "h1_")) {
    weaponName = maps\mp\gametypes\_class::buildweaponnamecamo(weaponName, camo);
  } else if(!isValidWeapon(weaponName + "_mp", false)) {
    weaponName = baseName + "_mp";
  } else {
    weaponName = maps\mp\gametypes\_class::buildweaponnamecamo(weaponName, camo);
    weaponName += "_mp";
  }

  return weaponName;
}

buildweaponname(var_0, var_1, var_2, var_3, perks, var_5) {
  if(!isDefined(var_0) || var_0 == "none" || var_0 == "") {
    return var_0;
  }

  if(!isDefined(level.lettertonumber)) {
    level.lettertonumber = maps\mp\gametypes\_class::makeletterstonumbers();
  }

  var_6 = "";

  if(issubstr(var_0, "iw5_") || issubstr(var_0, "h1_") || issubstr(var_0, "h2_") || var_0 == "at4" || var_0 == "stinger" || var_0 == "javelin") {
    var_7 = var_0 + "_mp";
    var_8 = var_0.size;

    if(issubstr(var_0, "h1_") || issubstr(var_0, "h2_") || var_0 == "at4" || var_0 == "stinger" || var_0 == "javelin") {
      var_6 = getsubstr(var_0, 3, var_8);
    } else {
      var_6 = getsubstr(var_0, 4, var_8);
    }
  } else {
    var_7 = var_0;
    var_6 = var_0;
  }

  if(var_7 == "h1_junsho_mp") {
    var_1 = "akimbohidden";
  }

  var_9 = isDefined(var_1) && var_1 != "none";
  var_10 = isDefined(var_2) && var_2 != "none";

  if(!var_10) {
    var_11 = tablelookuprownum("mp/furniturekits/base.csv", 0, var_7);

    if(var_11 >= 0) {
      var_2 = "base";
      var_10 = 1;
    }
  }

  if(issubstr(var_7, "h2_") || issubstr(var_7, "h1_") || var_7 == "at4_mp" || var_7 == "stinger_mp" || var_7 == "javelin_mp") {
    if(var_2 == "base")
      var_2 = "none";
    return h2_buildweaponname(var_7, var_1, var_2, var_3, perks);
  }

  if(!issubstr(var_0, "h1_") && !issubstr(var_0, "h2_")) {
    if(var_9) {
      name = get_attachment_name(var_0, var_1);
      if(isDefined(name) && name != "") {
        var_7 += "_" + name;
      }
    }
  } else if(var_9 || var_10) {
    if(!var_9)
      var_1 = "none";

    if(!var_10)
      var_2 = "base";

    if(issubstr(var_0, "h2_"))
      var_2 = "none";

    var_7 += ("_a#" + var_1);
    var_7 += ("_f#" + var_2);
  } else if(issubstr(var_7, "iw5_") || issubstr(var_7, "h1_")) {
    /*
    var_7 = maps\mp\gametypes\_class::buildweaponnamereticle(var_7, var_4);
    var_7 = maps\mp\gametypes\_class::buildweaponnameemblem(var_7, var_5);
    */
    var_7 = maps\mp\gametypes\_class::buildweaponnamecamo(var_7, var_3);
    return var_7;
  } else if(!isvalidweapon(var_7 + "_mp")) {
    return var_0 + "_mp";
  } else {
    /*
    var_7 = maps\mp\gametypes\_class::buildweaponnamereticle(var_7, var_4);
    var_7 = maps\mp\gametypes\_class::buildweaponnameemblem(var_7, var_5);
    */
    var_7 = maps\mp\gametypes\_class::buildweaponnamecamo(var_7, var_3);
    return var_7 + "_mp";
  }
}

isvalidweapon(var_0, var_1) {
  if(!isDefined(level.weaponrefs)) {
    level.weaponrefs = [];

    foreach(var_3 in level.weaponlist) {
      level.weaponrefs[var_3] = 1;
    }
  }

  if(isDefined(level.weaponrefs[var_0])) {
    return 1;
  }

  return 0;
}

isvalidsecondary(var_0, var_1, var_2) {
  switch (var_0) {
    case "none":
    case "h2_pp2000":
    case "h2_glock":
    case "h2_beretta393":
    case "h2_tmp":
    case "h2_usp":
    case "h2_coltanaconda":
    case "h2_m9":
    case "h2_colt45":
    case "h2_deserteagle":
    case "h2_spas12":
    case "h2_aa12":
    case "h2_striker":
    case "h2_ranger":
    case "h2_winchester1200":
    case "h2_m1014":
    case "h2_model1887":
    case "at4":
    case "h2_m79":
    case "stinger":
    case "javelin":
    case "h2_rpg":
    case "h2_shovel":
    case "h2_karambit":
    case "h2_hatchet":
    case "h2_icepick":
    case "h2_sickle":
      return 1;
    default:
      //maps\mp\gametypes\_class::foundinfraction(va("%s is not valid secondary", var_0));
      return 0;
  }

  return 0;
}

isvalidprimary(var_0, var_1) {
  switch (var_0) {
    case "h2_m4":
    case "h2_famas":
    case "h2_scar":
    case "h2_tavor":
    case "h2_fal":
    case "h2_m16":
    case "h2_masada":
    case "h2_fn2000":
    case "h2_ak47":
    case "h2_mp5k":
    case "h2_ump45":
    case "h2_kriss":
    case "h2_p90":
    case "h2_uzi":
    case "h2_ak74u":
    case "h2_cheytac":
    case "h2_barrett":
    case "h2_wa2000":
    case "h2_m21":
    case "h2_m40a3":
    case "h2_sa80":
    case "h2_rpd":
    case "h2_mg4":
    case "h2_aug":
    case "h2_m240":
    case "h2_inspect":
      return 1;
    default:
      return 0;
  }

  return 0;
}

isvalidequipment(var_0, var_1) {
  var_0 = maps\mp\_utility::strip_suffix(var_0, "_lefthand");

  switch (var_0) {
    case "specialty_null":
    case "h1_fraggrenade_mp":
    case "h2_semtex_mp":
    case "iw9_throwknife_mp":
    case "specialty_tacticalinsertion":
    case "specialty_blastshield":
    case "h1_claymore_mp":
    case "h1_c4_mp":
      return 1;
    default:
      if(maps\mp\_utility::is_true(var_1))
        maps\mp\gametypes\_class::foundinfraction("Replacing invalid equipment: " + var_0);

      return 0;
  }
}

giveoffhand(var_0) {
  var_1 = maps\mp\_utility::strip_suffix(var_0, "_lefthand");

  switch (var_1) {
    case "specialty_tacticalinsertion":
      self giveweapon("flare_mp");
      break;
    case "h1_fraggrenade_mp":
    case "h2_semtex_mp":
    case "iw9_throwknife_mp":
    case "h1_claymore_mp":
    case "h1_c4_mp":
    case "h1_smokegrenade_mp":
    case "h1_concussiongrenade_mp":
    case "h1_flashgrenade_mp":
      self giveweapon(var_0);
      break;
    case "none":
    case "specialty_null":
    case "specialty_blastshield":
    default:
      break;
  }
}

takeoffhand(var_0) {
  var_1 = maps\mp\_utility::strip_suffix(var_0, "_lefthand");

  switch (var_1) {
    case "h1_fraggrenade_mp":
    case "h2_semtex_mp":
    case "iw9_throwknife_mp":
    case "specialty_tacticalinsertion":
    case "specialty_blastshield":
    case "h1_claymore_mp":
    case "h1_c4_mp":
    case "h1_smokegrenade_mp":
    case "h1_concussiongrenade_mp":
    case "h1_flashgrenade_mp":
      self takeweapon(var_0);
      break;
    case "none":
    case "specialty_null":
    default:
      break;
  }
}

is_lethal_equipment(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "h1_fraggrenade_mp":
    case "h2_semtex_mp":
    case "iw9_throwknife_mp":
    case "specialty_tacticalinsertion":
    case "specialty_blastshield":
    case "h1_claymore_mp":
    case "h1_c4_mp":
      return 1;
    default:
      return 0;
  }
}

isvalidmeleeweapon(var_0, var_1) {
  switch (var_0) {
    case "none":
    case "specialty_combathigh":
    case "specialty_copycat":
    case "specialty_finalstand":
    case "specialty_grenadepulldeath":
      return 1;
    default:
      if(maps\mp\_utility::is_true(var_1))
        foundinfraction("Replacing invalid melee weapon: " + var_0);

      return 0;
  }
}

isvalidattachment(var_0, var_1, var_2) {
  var_3 = 0;

  switch (var_0) {
    case "none":
    case "thermal":
    case "stock":
    case "shotgun":
    case "sho":
    case "shopre":
    case "gl":
    case "glmwr":
    case "masterkeymwr":
    case "glpremwr":
    case "glpre":
    case "masterkeypremwr":
    case "tacknifemwr":
    case "akimbo":
    case "zoomscope":
    case "ironsights":
    case "acog":
    case "acogsmg":
    case "reflex":
    case "reflexsmg":
    case "reflexlmg":
    case "silencer":
    case "silencer02":
    case "silencer03":
    case "grip":
    case "gp25":
    case "m320":
    case "thermalsmg":
    case "heartbeat":
    case "fmj":
    case "rof":
    case "xmags":
    case "dualmag":
    case "eotech":
    case "eotechsmg":
    case "eotechlmg":
    case "tactical":
    case "scopevz":
    case "hamrhybrid":
    case "hybrid":
    case "parabolicmicrophone":
    case "opticsreddot":
    case "opticsacog2":
    case "opticseotech":
    case "opticsthermal":
    case "silencer01":
    case "sensorheartbeat":
    case "foregrip":
    case "variablereddot":
    case "opticstargetenhancer":
    case "firerate":
    case "longrange":
    case "quickdraw":
    case "lasersight":
    case "thorscopevz":
    case "trackrounds":
    case "stabilizer":
    case "heatsink":
    case "rw1scopebase":
    case "crossbowscopebase":
    case "silencerpistol":
    case "silencersniper":
    case "acogmwr":
    case "gripmwr":
    case "reflexmwr":
    case "silencermwr":
    case "akimbomwr":
    case "heartbeatmwr":
    case "holosightmwr":
    case "longbarrelmwr":
    case "reflexvarmwr":
    case "thermalmwr":
    case "varzoommwr":
    case "xmagmwr":
      var_3 = 1;
      break;
    default:
      var_3 = 0;
      break;
  }

  if(var_3 && var_0 != "none") {
    var_4 = maps\mp\_utility::getweaponattachmentarrayfromstats(var_1);
    var_3 = common_scripts\utility::array_contains(var_4, var_0);
  }

  if(!var_3 && maps\mp\_utility::is_true(var_2))
    foundinfraction("Replacing invalid attachment: " + var_0);

  return var_3;
}

addautomaticattachments(var_0, var_1) {
  var_2 = [];
  var_3 = maps\mp\_utility::getbaseweaponname(var_0);

  if(maps\mp\gametypes\_class::needsscopeoverride(var_3, var_1)) {
    var_4 = var_3;

    if(issubstr(var_3, "iw5_") || issubstr(var_3, "iw6_") || issubstr(var_3, "h1_") || issubstr(var_3, "h2_")) {
      var_5 = var_3.size;
      var_4 = getsubstr(var_3, 4, var_5);
    }

    var_6 = maps\mp\gametypes\_class::getbasefromlootversion(var_4) + "scope";
    var_2[var_2.size] = var_6;
  }

  return var_2;
}