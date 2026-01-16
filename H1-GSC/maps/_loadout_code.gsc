/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_loadout_code.gsc
********************************/

saveplayerweaponstatepersistent(var_0) {
  var_1 = level.player getcurrentweapon();

  if(!isdefined(var_1) || var_1 == "none") {}

  game["weaponstates"][var_0]["current"] = var_1;
  var_2 = level.player getcurrentoffhand();
  game["weaponstates"][var_0]["offhand"] = var_2;
  game["weaponstates"][var_0]["list"] = [];
  var_3 = level.player getweaponslistall();

  for (var_4 = 0; var_4 < var_3.size; var_4++)
    game["weaponstates"][var_0]["list"][var_4]["name"] = var_3[var_4];
}

restoreplayerweaponstatepersistent(var_0) {
  if(!isdefined(game["weaponstates"]))
    return 0;

  if(!isdefined(game["weaponstates"][var_0]))
    return 0;

  level.player takeallweapons();

  for (var_1 = 0; var_1 < game["weaponstates"][var_0]["list"].size; var_1++) {
    var_2 = game["weaponstates"][var_0]["list"][var_1]["name"];

    if(isdefined(level.legit_weapons)) {
      if(!isdefined(level.legit_weapons[var_2]))
        continue;
    }

    if(var_2 == "c4") {
      continue;
    }
    if(var_2 == "claymore") {
      continue;
    }
    level.player giveweapon(var_2);
    level.player givemaxammo(var_2);
  }

  if(isdefined(level.legit_weapons)) {
    var_2 = game["weaponstates"][var_0]["offhand"];

    if(isdefined(level.legit_weapons[var_2]))
      level.player switchtooffhand(var_2);

    var_2 = game["weaponstates"][var_0]["current"];

    if(isdefined(level.legit_weapons[var_2]))
      level.player switchtoweapon(var_2);
  } else {
    level.player switchtooffhand(game["weaponstates"][var_0]["offhand"]);
    level.player switchtoweapon(game["weaponstates"][var_0]["current"]);
  }

  return 1;
}

setdefaultactionslot() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "altMode");
  self setactionslot(4, "");
}

init_player() {
  setdefaultactionslot();
  self takeallweapons();
}

get_loadout() {
  if(isdefined(level.loadout))
    return level.loadout;

  return level.script;
}

persist(var_0, var_1) {
  var_2 = get_loadout();

  if(var_0 != var_2) {
    return;
  }
  if(!isdefined(game["previous_map"])) {
    return;
  }
  if(game["previous_map"] != var_1) {
    return;
  }
  level._lc_persists = 1;
  restoreplayerweaponstatepersistent(var_1);
  level.has_loadout = 1;
}

loadout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isdefined(var_0)) {
    var_7 = get_loadout();

    if(var_0 != var_7)
      return;
  }

  if(!isdefined(level._lc_persists)) {
    if(isdefined(var_1)) {
      level.default_weapon = var_1;
      level.player giveweapon(var_1);
    }

    if(isdefined(var_2))
      level.player giveweapon(var_2);

    if(isdefined(var_1))
      level.player switchtoweapon(var_1);
    else if(isdefined(var_2))
      level.player switchtoweapon(var_2);
  }

  if(isdefined(var_3)) {
    level.player setlethalweapon(var_3);
    level.player giveweapon(var_3);
  }

  if(isdefined(var_4)) {
    level.player settacticalweapon(var_4);
    level.player giveweapon(var_4);
  }

  if(isdefined(var_5))
    level.player setviewmodel(var_5);

  if(isdefined(var_6))
    level.campaign = var_6;

  level.has_loadout = 1;
}

loadoutequipment(var_0, var_1, var_2) {
  if(!isdefined(var_0)) {
    return;
  }
  if(level.script != var_0) {
    return;
  }
  if(isdefined(var_1)) {
    level.player giveweapon(var_1);
    level.player setactionslot(2, "weapon", var_1);
  }

  if(isdefined(var_2)) {
    level.player giveweapon(var_2);
    level.player setactionslot(4, "weapon", var_2);
  }
}

loadout_complete() {
  level.loadoutcomplete = 1;
  level notify("loadout complete");
}

default_loadout_if_notset() {
  if(level.has_loadout) {
    return;
  }
  loadout(undefined, "mp5", undefined, "fraggrenade", "flash_grenade", "viewmodel_base_viewhands");
  level.map_without_loadout = 1;
}

loadoutcustomization() {
  switch (level.script) {
    case "killhouse":
      loadout_killhouse();
      break;
    case "cargoship":
      break;
    case "coup":
      break;
    case "blackout":
      loadout_blackout();
      break;
    case "armada":
      break;
    case "bog_a":
      break;
    case "hunted":
      break;
    case "ac130":
      break;
    case "bog_b":
      break;
    case "airlift":
      break;
    case "aftermath":
      break;
    case "village_assault":
      break;
    case "scoutsniper":
      loadout_scoutsniper();
      break;
    case "sniperescape":
      loadout_sniperescape();
      break;
    case "village_defend":
      loadout_village_defend();
      break;
    case "ambush":
      loadout_ambush();
      break;
    case "icbm":
      break;
    case "launchfacility_a":
      loadout_launchfacility_a();
      break;
    case "launchfacility_b":
      loadout_launchfacility_b();
      break;
    case "jeepride":
      break;
    case "airplane":
      break;
    case "simplecredits":
      break;
  }
}

loadout_killhouse() {
  level.player setweaponammoclip("fraggrenade", 0);
  level.player setweaponammoclip("flash_grenade", 0);
}

loadout_blackout() {
  level.player givemaxammo("m4m203_silencer_reflex");
  level.player givemaxammo("m14_scoped_silencer_woodland");
}

loadout_scoutsniper() {
  level.player givemaxammo("m14_scoped_silencer");
  level.player givemaxammo("usp_silencer");
}

loadout_sniperescape() {
  if(level.gameskill >= 2) {
    level.player setweaponammoclip("claymore", 10);
    level.player setweaponammoclip("c4", 6);
  } else {
    level.player setweaponammoclip("claymore", 8);
    level.player setweaponammoclip("c4", 3);
  }
}

loadout_village_defend() {
  level.player givemaxammo("claymore");
}

loadout_ambush() {
  level.player setweaponammostock("remington700", 10);
}

loadout_launchfacility_a() {
  level.player givemaxammo("claymore");
}

loadout_launchfacility_b() {
  var_0 = undefined;
  var_1 = 0;
  var_2 = level.player getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(issubstr(var_4, "javelin")) {
      var_0 = var_4;
      continue;
    }

    if(issubstr(var_4, "m4m203_silencer_reflex"))
      var_1 = 1;
  }

  if(isdefined(var_0)) {
    level.player takeweapon(var_0);

    if(var_1)
      level.player giveweapon("usp_silencer");
    else
      level.player giveweapon("m4m203_silencer_reflex");

    level.player switchtoweaponimmediate("m4m203_silencer_reflex");
  }
}