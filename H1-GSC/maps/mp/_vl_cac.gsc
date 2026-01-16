/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_vl_cac.gsc
********************************/

init_cac() {
  initweaponavatar();
  level.cac_weapon_base = "";
  level.weaponmodelboundscache = [];
  level.vl_selectedfaction = 0;
  buildfactions();
  level.vl_cac_getfactionteam = ::getfactionteam;
  level.vl_cac_getfactionenvironment = ::getfactionenvironment;
}

playercacprocesslui(var_0, var_1) {
  if(var_0 == "reset_loadout")
    resetloadout(var_1);
  else {
    if(maps\mp\_utility::is_true(level.in_depot)) {
      return;
    }
    if(var_0 == "cac")
      handlecacmodechange(var_1);
    else if(var_0 == "classpreview" || issubstr(var_0, "preset_classpreview"))
      handleclassselect(var_0, var_1);
    else if(var_0 == "weapon_highlighted" && var_1 != "none") {
      if(maps\mp\_vl_cao::iscollectionsmenuactive())
        maps\mp\_vl_cao::turncollectionsmodeoff();

      handleweaponhighlighted(var_1);
    } else {
      if(var_0 == "lootscreen_weapon_highlighted") {
        handlecacweapmodechange(0);
        handlecacmodechange(0);
        return;
      }

      if(var_0 == "faction_changed")
        handlefactionchanged(var_1);
    }
  }
}

resetloadout(var_0) {
  var_1 = var_0 & 15;
  var_2 = maps\mp\_vl_base::getfocusfromcontroller(var_1);
  var_3 = level.vlavatars[var_2];

  if(isdefined(var_3)) {
    level.vl_focus = var_2;
    thread maps\mp\_vl_base::virtual_lobby_set_class(var_2, var_1, "lobby" + self.currentselectedclass, 1);
    var_4 = level.vlavatars[level.vl_focus];
    level.cac_weapon = var_3.primaryweapon;
  }
}

handlecacweapmodechange(var_0, var_1) {
  if(var_0 == 0) {
    if(maps\mp\_utility::is_true(level.cac_weap)) {
      maps\mp\_vl_base::resetweaponavatar();
      maps\mp\_vl_base::resetplayeravatar();
      playerhidecacavatars();
      thread maps\mp\_vl_base::handlerotateplayeravatar();
      maps\mp\_vl_base::playerpopcameramode();
      level.cac_weap = undefined;
      return 1;
    }
  } else if(!maps\mp\_utility::is_true(level.cac_weap)) {
    maps\mp\_vl_base::resetweaponavatar();
    thread maps\mp\_vl_base::handlerotateweaponavatar(var_1);
    level.cac_weap = 1;
    maps\mp\_vl_base::playerchangecameramode("cac_weap");
    maps\mp\_vl_base::playersetlobbyfovscale();
    return 1;
  }

  return 0;
}

handlecacmodechange(var_0) {
  if(var_0 == 0) {
    if(maps\mp\_utility::is_true(level.cac)) {
      if(maps\mp\_utility::is_true(level.cac_weap))
        handlecacweapmodechange(0);

      maps\mp\_vl_base::resetweaponavatar();
      maps\mp\_vl_base::resetplayeravatar();
      self notify("handleRotateAvatar");
      maps\mp\_vl_base::playerpopcameramode();
      level.cac = undefined;
    } else
      self notify("handleRotateAvatar");
  } else if(maps\mp\_utility::is_true(level.cac_weap))
    handlecacweapmodechange(0);
  else if(!maps\mp\_utility::is_true(level.cac)) {
    maps\mp\_vl_base::resetplayeravatar();
    thread maps\mp\_vl_base::handlerotateplayeravatar();
    level.cac = 1;
    maps\mp\_vl_camera::fixlocalfocus();
    var_1 = level.vlavatars[level.vl_focus];
    maps\mp\_vl_avatar::playerteleportavatartocac(var_1);
    maps\mp\_vl_base::playerchangecameramode("cac");
  }
}

handleclassselect(var_0, var_1) {
  if(var_1 >= 0) {
    var_2 = var_1 & 15;
    level.caccontroller = var_2;
    var_3 = int(var_1 / 16);
    maps\mp\_vl_base::vlprintln("handleClassSelect " + var_0 + " controller=" + var_2 + "class=" + var_3);

    if(var_3 > 0)
      self.currentselectedclass = var_3;

    var_4 = maps\mp\_utility::cac_getcustomclassloc();
    self.currentclassloc = var_4;
    var_5 = maps\mp\_vl_base::getfocusfromcontroller(var_2);
    var_6 = level.vlavatars[var_5];

    if(isdefined(var_6)) {
      var_7 = getvlclass(var_0, self.currentselectedclass);
      _func_300(var_2);
      level.vl_focus = var_5;

      if(!maps\mp\_vl_cao::isequipmenuactive())
        handlecacmodechange(1);

      maps\mp\_vl_avatar::hide_avatar_weapons(var_6);
      maps\mp\_vl_camera::set_avatar_dof(1);
      thread maps\mp\_vl_base::virtual_lobby_set_class(var_5, var_2, var_7, 1);
      level.cac_weapon = var_6.primaryweapon;
      maps\mp\_vl_camera::playerupdatecamera();
      return;
    }
  } else
    handlecacmodechange(0);
}

handleweaponhighlighted(var_0) {
  var_1 = 0;
  var_2 = strtok(var_0, "_");
  var_3 = "none";
  var_4 = 0;

  if(var_2.size > 1) {
    var_4 = int(var_2[0]);
    var_2 = maps\mp\_utility::array_remove_index(var_2, 0);
    var_3 = parseweaponhighlightedcategory(var_2[0]);
  }

  if(var_0 != "none" && var_0 != "" && !maps\mp\_vl_cao::iscollectionsmenuactive() && !maps\mp\_vl_cao::isarmorymenuactive()) {
    maps\mp\_vl_avatar::hide_avatars();
    var_5 = handlecacweapmodechange(1, var_3);

    if(var_5)
      var_1 = 1;
  }

  var_6 = "weapons_lobby";

  if(maps\mp\_vl_cao::iscollectionsmenuactive())
    var_6 = "weapons_collection";

  maps\mp\_vl_base::weaponroomscenelightsupdate(var_6);

  if(var_2.size > 1) {
    var_7 = parseweaponhighlightedvalue(var_2[0], var_2[1]);
    var_8 = "none";
    var_9 = "none";
    var_10 = 0;
    var_11 = 0;

    if(var_2.size > 3 && var_2.size % 2 == 0) {
      var_12 = (var_2.size - 2) / 2;

      for (var_13 = 0; var_13 < var_12; var_13++) {
        var_14 = var_2[2 + var_13 * 2];
        var_15 = parseweaponhighlightedcategory(var_2[2 + var_13 * 2]);
        var_16 = var_2[3 + var_13 * 2];

        if(var_15 == "FurnitureKit") {
          var_9 = parseweaponhighlightedvalue(var_14, var_16);
          continue;
        }

        if(var_15 == "AttachKit") {
          var_8 = parseweaponhighlightedvalue(var_14, var_16);
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

    if(isdefined(self.emblemloadout.emblemindex)) {
      if(self.emblemloadout.shouldapplyemblemtoweapon)
        var_17 = self.emblemloadout.emblemindex;
    } else {
      var_18 = getcacplayerdataforgroup(var_4, common_scripts\utility::getstatsgroup_common(), "applyEmblemToWeapon");

      if(var_18)
        var_17 = getcacplayerdataforgroup(var_4, common_scripts\utility::getstatsgroup_common(), "emblemPatchIndex");
    }

    var_19 = shouldhidecamoonweapon(var_4, var_7, var_10);

    if(var_19)
      var_10 = 0;

    thread setcacweapon(var_7, var_3, var_8, var_9, var_10, var_11, var_17, var_1);
  } else
    thread setcacweapon("none");
}

doescamoignoreprivatematchunlock(var_0) {
  return tablelookuprownum("mp\privateMatchLockTable.csv", 0, var_0) >= 0;
}

shouldhidecamoonweapon(var_0, var_1, var_2) {
  var_3 = tablelookup("mp\camotable.csv", 0, var_2, 1);
  var_4 = doescamoignoreprivatematchunlock(var_3);
  return !maps\mp\gametypes\_class::iscamounlocked(var_1, var_3, var_4, var_0);
}

parseweaponhighlightedcategory(var_0) {
  switch (var_0) {
    case "1":
      return "Primary";
    case "2":
      return "Secondary";
    case "3":
      return "Equipment";
    case "4":
      return "Perk";
    case "5":
      return "FurnitureKit";
    case "6":
      return "AttachKit";
    case "7":
      return "Camo";
    case "8":
      return "Reticle";
    case "9":
      return "Melee";
    default:
      break;
  }

  return "none";
}

parseweaponhighlightedvalue(var_0, var_1) {
  switch (var_0) {
    case "9":
    case "1":
    case "2":
      return tablelookup("mp\statstable.csv", 0, var_1, 4);
    case "4":
    case "3":
      return tablelookup("mp\perktable.csv", 0, var_1, 1);
    case "5":
      return tablelookup("mp\furniturekits.csv", 0, var_1, 1);
    case "6":
      return tablelookup("mp\attachkits.csv", 0, var_1, 1);
    case "7":
      return tablelookup("mp\camotable.csv", 0, var_1, 1);
    case "8":
      return tablelookup("mp\reticletable.csv", 0, var_1, 1);
    default:
      break;
  }

  return "none";
}

handlefactionchanged(var_0) {
  var_1 = strtok(var_0, ":");

  if(var_1.size > 1) {
    var_2 = int(var_1[0]);
    var_3 = int(var_1[1]);
    level.vl_selectedfaction = var_2;
    var_4 = maps\mp\_vl_base::getfocusfromcontroller(var_3);

    if(var_4 >= 0) {
      var_5 = level.vlavatars[var_4];

      if(!isdefined(var_5.loadout))
        var_5.loadout = spawnstruct();

      var_5.loadout._id_A7E7 = var_2;
      thread maps\mp\_vl_base::playerrefreshavatar(var_4);
    }
  }
}

updatefactionselection(var_0) {
  level.vl_selectedfaction = var_0;
}

streamcacweaponwait(var_0) {
  maps\mp\_vl_base::vlprintln("weapon_stream: " + var_0);
  var_1 = [var_0];
  var_2 = gettime();
  var_3 = getdvarfloat("scr_vl_minweaponstreamtime", 0.0);
  waittillframeend;

  if(self loadweapons(var_1)) {
    return;
  }
  level.weaponavatarparent dontinterpolate();
  waitframe();

  for (;;) {
    waittillframeend;

    if(self loadweapons(var_1)) {
      break;
    }

    waitframe();
  }

  while ((gettime() - var_2) / 1000 < var_3)
    waitframe();
}

setcacweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("setCacWeapon");
  self endon("setCacWeapon");

  if(maps\mp\_utility::is_true(var_7))
    maps\mp\_utility::waittillplayersnextsnapshot(self);

  var_8 = "none";

  if(var_0 != "none") {
    if(level.cac_weapon_base != var_0) {
      maps\mp\_vl_base::resetweaponavatar();
      thread maps\mp\_vl_base::handlerotateweaponavatar(var_1);
    }

    if(var_1 == "Equipment") {
      var_8 = var_0;
      showloadingweaponavatar(var_8, var_1);
      streamcacweaponwait(var_8);
    } else if(var_1 == "Perk")
      var_8 = var_0;
    else {
      var_8 = buildweaponnamecac(var_0, var_2, var_3, var_4, var_5, var_6);
      showloadingweaponavatar(var_8, var_1);
      streamcacweaponwait(var_8);
    }
  }

  level.cac_weapon_base = var_0;
  level.cac_weapon = var_8;
  updateweaponavatar(var_1);
}

buildweaponnamecac(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(issubstr(var_0, "meleebottle") || issubstr(var_0, "meleejun6") || issubstr(var_0, "meleejun5"))
    var_2 = "lby";

  return maps\mp\gametypes\_class::buildweaponname(var_0, var_1, var_2, var_3, var_4, var_5);
}

has_suffix(var_0, var_1) {
  if(var_0.size >= var_1.size) {
    if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1)
      return 1;
  }

  return 0;
}

initweaponavatar() {
  level.weaponavatarparent = common_scripts\utility::spawn_tag_origin();
  level.weaponavatarparent.cameralocation = common_scripts\utility::getstruct("weaponCamera", "targetname");
  spawnloadingweaponavatar("h1_ak47loading_mp");
  maps\mp\_vl_base::resetweaponavatar();
}

spawngenericprop3avatar() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setmodel("genericprop_x3");
  var_0 scriptmodelplayanim("h1_lobby_turnaround_ranger_akimbo_align");
  return var_0;
}

getoriginforoffset(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = anglestoforward(var_1);
  var_3 = var_3 + var_4 * var_2[0];
  var_5 = anglestoright(var_1);
  var_3 = var_3 + var_5 * var_2[1];
  var_6 = anglestoup(var_1);
  var_3 = var_3 + var_6 * var_2[2];
  return var_3;
}

getweaponavatarforwarddistance(var_0, var_1) {
  var_2 = var_1["halfsize"];
  var_3 = var_2[0];
  var_4 = var_2[2];
  var_5 = 0;

  if(isavatarameleeweapon(var_0))
    var_5 = 3.54 * var_4 + 11.492;
  else
    var_5 = 1.8325 * var_3 + 28.587;

  if(isavataraperk(var_0))
    var_5 = var_5 + 20;

  if(maps\mp\_vl_cao::iscollectionsmenuactive())
    var_5 = var_5 + 15;

  return var_5;
}

getweaponavatarrightdistance(var_0) {
  var_1 = 125;

  if(maps\mp\_vl_cao::iscollectionsmenuactive())
    var_1 = 20;

  return var_1;
}

getweaponavatarupdistance(var_0, var_1) {
  var_2 = 0;

  if(!isavatarameleeweapon(var_0))
    var_2 = 20;

  if(maps\mp\_vl_cao::iscollectionsmenuactive())
    var_2 = var_2 - 55;

  return var_2;
}

getweaponavatarlocation(var_0, var_1) {
  var_2 = getweaponavatarforwarddistance(var_0, var_1);
  var_3 = getweaponavatarrightdistance(var_1);
  var_4 = getweaponavatarupdistance(var_0, var_1);
  var_5 = (var_2, var_3, var_4);
  var_6 = getdvarfloat("cg_fov");

  if(isdefined(self.fovscale))
    var_6 = var_6 * self.fovscale;

  var_7 = self screenpostoworldpoint((var_3, var_4, 0), var_6, var_2, 1);
  return var_7;
}

getweaponbounds(var_0, var_1) {
  if(!isdefined(var_1))
    var_1 = 0;

  if(isdefined(level.weaponmodelboundscache[var_0.weapon_name]))
    return level.weaponmodelboundscache[var_0.weapon_name];
  else if(!var_1) {
    var_2 = getweaponmodelbounds(var_0);

    if(!isdefined(var_2))
      var_2 = [];

    if(!maps\mp\_utility::is_true(var_0.isloadingweapon))
      level.weaponmodelboundscache[var_0.weapon_name] = var_2;

    return var_2;
  }
}

getavatarbounds(var_0, var_1) {
  if(isweaponavataraweapon(var_0))
    var_2 = getweaponbounds(var_0, var_1);
  else
    var_2 = getperkbounds(var_0);

  return var_2;
}

getweaponcenteroffset(var_0) {
  return var_0["midpoint"];
}

positionweaponavatar(var_0, var_1) {
  var_2 = getavatarbounds(var_0);

  if(var_2.size == 0) {
    return;
  }
  var_3 = var_0;

  if(isdefined(var_0.linker))
    var_3 = var_0.linker;

  var_3 unlink();
  var_4 = getweaponavatarforwarddistance(var_0, var_2);
  maps\mp\_vl_camera::vl_dof_based_on_focus_weap_cac(var_4);
  var_5 = getweaponavatarlocation(var_0, var_2);
  var_6 = isavatarbottle(var_0);
  var_7 = var_2["midpoint"];
  var_8 = var_2["halfsize"];

  if(var_6)
    var_7 = (0, 0, -1 * var_8[2]);
  else if(var_1 == "Equipment")
    var_7 = (0, 0, var_7[2]);

  var_3.origin = var_5 - var_7;

  if(var_6)
    var_3.angles = (185, 126, 0);
  else if(isweaponavataraweapon(var_0))
    var_3.angles = (5, 0, 0);
  else
    var_3.angles = (0, 300, 15);

  level.weaponavatarparent.origin = var_5;
  var_9 = level.weaponavatarparent.angles;
  level.weaponavatarparent.angles = (0, 180, 0);
  var_3 linktosynchronizedparent(level.weaponavatarparent);
  level.weaponavatarparent.angles = var_9;
}

getperkbounds(var_0) {
  if(!isdefined(level.perkboundscache)) {
    level.perkboundscache = [];

    if(var_0 islinked()) {
      var_0 unlink();
      var_0.origin = (0, 0, 0);
    }

    var_1 = var_0 getpointinmodelbounds(0, 0, 0);
    var_2 = var_0 getpointinmodelbounds(1, 0, 0);
    var_3 = distance(var_2, var_1);
    var_4 = var_0 getpointinmodelbounds(0, 1, 0);
    var_5 = distance(var_4, var_1);
    var_6 = var_0 getpointinmodelbounds(0, 0, 1);
    var_7 = distance(var_6, var_1);
    level.perkboundscache["midpoint"] = var_1;
    level.perkboundscache["halfsize"] = (var_3, var_5, var_7);
  }

  return level.perkboundscache;
}

spawnloadingweaponavatar(var_0) {
  var_1 = common_scripts\utility::getstruct("cameraWeapon", "targetname").origin;
  var_2 = spawn("weapon_" + var_0, var_1, 1);
  var_2.isloadingweapon = 1;
  var_2 cloakingenable();
  var_2.weapon_name = var_0;
  var_2.linker = spawngenericprop3avatar();
  level.weaponavatarparent.loadingweaponavatar = var_2;
  return var_2;
}

showloadingweaponavatar(var_0, var_1) {
  setomnvar("ui_cac_weapon_loading", 1);
  hideweaponavatar();
  hideperkavatar();
  var_2 = level.weaponavatarparent.loadingweaponavatar;

  if(!isdefined(var_2))
    var_2 = spawnloadingweaponavatar(var_0);
  else {
    var_2 show();

    if(var_2.weapon_name == var_0)
      return;
  }

  var_3 = strtok(var_0, "_");
  var_4 = var_3[0] + "_" + var_3[1] + "loading_mp";
  var_2 setpickupweapon(var_4, 1);
  var_2.weapon_name = var_0;
  var_2.category = var_1;
  var_5 = shouldplayidleanim(var_1);
  weaponitemplayidleanim(var_2, var_5);
  var_6 = isavatarakimbo(var_2);

  if(var_6) {
    if(!isdefined(var_2.akimboavatar)) {
      var_7 = common_scripts\utility::getstruct("cameraWeapon", "targetname").origin;
      var_2.akimboavatar = spawn("weapon_" + var_0, var_7, 1);
      var_2.akimboavatar cloakingenable();
      var_2.akimboavatar linktosynchronizedparent(var_2.linker, "j_prop_2", (0, 0, 0), (0, 0, 0));
    } else
      var_2.akimboavatar show();

    var_2.akimboavatar setpickupweapon(var_4, 1);
    weaponitemplayidleanim(var_2.akimboavatar, var_5);
    var_2 linktosynchronizedparent(var_2.linker, "j_prop_1", (0, 0, 0), (0, 0, 0));
  } else {
    if(isdefined(var_2.akimboavatar))
      var_2.akimboavatar hide();

    var_2 linktosynchronizedparent(var_2.linker, "j_prop_3", (0, 0, 0), (0, 0, 0));
  }

  positionweaponavatar(var_2, var_1);
}

hideloadingweaponavatar() {
  setomnvar("ui_cac_weapon_loading", 0);

  if(isdefined(level.weaponavatarparent.loadingweaponavatar)) {
    var_0 = level.weaponavatarparent.loadingweaponavatar;
    var_0 hide();

    if(isdefined(var_0.akimboavatar))
      var_0.akimboavatar hide();
  }
}

showweaponavatar(var_0) {
  var_1 = level.weaponavatarparent.savedweaponavatar;

  if(!isdefined(var_1)) {
    var_1 = spawn("weapon_" + level.cac_weapon, (0, 0, 0), 1);
    var_1.isweapon = 1;
    level.weaponavatarparent.savedweaponavatar = var_1;
    var_1.linker = spawngenericprop3avatar();
  } else
    var_1 show();

  var_1 setpickupweapon(level.cac_weapon, 1);
  var_1.weapon_name = level.cac_weapon;
  var_1.category = var_0;
  var_2 = shouldplayidleanim(var_0);
  weaponitemplayidleanim(var_1, var_2);
  var_3 = isavatarakimbo(var_1);

  if(var_3) {
    if(!isdefined(var_1.akimboavatar)) {
      var_1.akimboavatar = spawn("weapon_" + level.cac_weapon, (0, 0, 0), 1);
      var_1.akimboavatar linktosynchronizedparent(var_1.linker, "j_prop_2", (0, 0, 0), (0, 0, 0));
    } else
      var_1.akimboavatar show();

    var_1.akimboavatar setpickupweapon(level.cac_weapon, 1);
    weaponitemplayidleanim(var_1.akimboavatar, var_2);
    var_1 linktosynchronizedparent(var_1.linker, "j_prop_1", (0, 0, 0), (0, 0, 0));
  } else {
    if(isdefined(var_1.akimboavatar))
      var_1.akimboavatar hide();

    var_1 linktosynchronizedparent(var_1.linker, "j_prop_3", (0, 0, 0), (0, 0, 0));
  }

  positionweaponavatar(var_1, var_0);
  level.weaponavatarparent.weaponavatar = var_1;
  maps\mp\_vl_base::prep_for_controls(level.weaponavatarparent);
}

shouldplayidleanim(var_0) {
  return var_0 != "Equipment" && var_0 != "Melee";
}

hideweaponavatar() {
  if(isdefined(level.weaponavatarparent.savedweaponavatar)) {
    var_0 = level.weaponavatarparent.savedweaponavatar;
    var_0 hide();

    if(isdefined(var_0.akimboavatar))
      var_0.akimboavatar hide();
  }
}

showperkavatar(var_0) {
  var_1 = level.weaponavatarparent.savedperkavatar;

  if(!isdefined(var_1)) {
    var_1 = spawn("script_model", (0, 0, 0));
    var_1.isperk = 1;
    level.weaponavatarparent.savedperkavatar = var_1;
  } else
    var_1 show();

  var_2 = getperkmodel(level.cac_weapon);
  var_1 setmodel(var_2);
  var_1.weapon_name = level.cac_weapon;
  var_1.category = var_0;
  positionweaponavatar(var_1, var_0);
  level.weaponavatarparent.weaponavatar = var_1;
  maps\mp\_vl_base::prep_for_controls(level.weaponavatarparent);
}

hideperkavatar() {
  if(isdefined(level.weaponavatarparent.savedperkavatar))
    level.weaponavatarparent.savedperkavatar hide();
}

playerhidecacavatars() {
  hideloadingweaponavatar();
  hideweaponavatar();
  hideperkavatar();
  self notify("setCacWeapon");
}

updateweaponavatar(var_0) {
  if(!isdefined(level.cac_weap) && !maps\mp\_vl_cao::iscollectionsmenuactive() && !maps\mp\_vl_cao::isarmorymenuactive()) {
    return;
  }
  hideloadingweaponavatar();

  if(level.cac_weapon == "" || level.cac_weapon == "none" || level.cac_weapon == "specialty_null") {
    hideperkavatar();
    hideweaponavatar();
  } else if(var_0 == "Perk") {
    hideweaponavatar();
    showperkavatar(var_0);
  } else {
    hideperkavatar();
    showweaponavatar(var_0);
  }

  level.weaponavatarparent dontinterpolate();
}

isweaponavataraweapon(var_0) {
  return issubstr(var_0.classname, "weapon_");
}

isavataraperk(var_0) {
  return maps\mp\_utility::is_true(var_0.isperk);
}

isavatarameleeweapon(var_0) {
  return var_0.category == "Melee";
}

isavatarbottle(var_0) {
  return isavatarameleeweapon(var_0) && (issubstr(var_0.weapon_name, "meleebottle") || issubstr(var_0.weapon_name, "meleejun6"));
}

isavatarakimbo(var_0) {
  return issubstr(var_0.weapon_name, "akimbo");
}

getperkmodel(var_0) {
  var_1 = 1;
  var_2 = 14;
  return tablelookup("mp\perktable.csv", var_1, var_0, var_2);
}

buildfactions() {
  var_0 = 1;
  var_1 = 2;
  level.vl_factions = [];
  var_2 = tablegetrowcount("mp\uiFactionsTable.csv");

  for (var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = tablelookupbyrow("mp\uiFactionsTable.csv", var_3, var_0);
    var_5 = tablelookupbyrow("mp\uiFactionsTable.csv", var_3, var_1);
    var_6 = level.vl_factions.size;
    level.vl_factions[var_6] = spawnstruct();
    level.vl_factions[var_6]._id_3338 = var_5;
    level.vl_factions[var_6].team = var_4;
  }
}

getfactionenvironment() {
  return level.vl_factions[level.vl_selectedfaction]._id_3338;
}

getfactionteam() {
  return level.vl_factions[level.vl_selectedfaction].team;
}

setselectedfaction(var_0) {
  var_1 = maps\mp\gametypes\_class::cac_getlastteam(var_0);
  var_2 = maps\mp\gametypes\_class::cac_getlastenvironment(var_0);

  if(var_1 == "axis" && var_2 == "urban")
    var_2 = "woodland";

  level.vl_selectedfaction = getfactionindex(var_1, var_2);
}

getfactionindex(var_0, var_1) {
  for (var_2 = 0; var_2 < level.vl_factions.size; var_2++) {
    var_3 = level.vl_factions[var_2];

    if(var_3.team == var_0 && var_3._id_3338 == var_1)
      return var_2;
  }

  return 0;
}

getvlclass(var_0, var_1) {
  var_2 = "none";

  if(var_0 == "preset_classpreview_allies")
    var_2 = "allies_recipe" + var_1;
  else if(var_0 == "preset_classpreview_axis")
    var_2 = "axis_recipe" + var_1;
  else if(var_0 == "classpreview")
    var_2 = "lobby" + var_1;

  if(!isclassvalid(var_2, var_1)) {
    if(var_1 > 0)
      var_1--;

    var_2 = "class" + var_1;
  }

  return var_2;
}

isclassvalid(var_0, var_1) {
  if(issubstr(var_0, "lobby"))
    return 1;
  else if(issubstr(var_0, "axis"))
    var_2 = "axis";
  else if(issubstr(var_0, "allies"))
    var_2 = "allies";
  else
    return 0;

  var_3 = maps\mp\_utility::getclassindex(var_0);
  var_4 = getmatchrulesdata("defaultClasses", var_2, "defaultClass", var_3, "class", "weaponSetups", 0, "weapon");
  return var_4 != "none";
}