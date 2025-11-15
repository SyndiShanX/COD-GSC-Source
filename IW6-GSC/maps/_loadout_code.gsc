/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_loadout_code.gsc
*****************************************************/

saveplayerweaponstatepersistent(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  level.player endon("death");

  if(level.player.health == 0) {
    return;
  }
  var_2 = level.player getcurrentprimaryweapon();

  if(!isDefined(var_2) || var_2 == "none") {}

  game["weaponstates"][var_0]["current"] = var_2;
  var_3 = level.player getcurrentoffhand();
  game["weaponstates"][var_0]["offhand"] = var_3;
  game["weaponstates"][var_0]["list"] = [];
  var_4 = common_scripts\utility::array_combine(level.player getweaponslistprimaries(), level.player getweaponslistoffhands());

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    game["weaponstates"][var_0]["list"][var_5]["name"] = var_4[var_5];

    if(var_1) {
      game["weaponstates"][var_0]["list"][var_5]["clip"] = level.player getweaponammoclip(var_4[var_5]);
      game["weaponstates"][var_0]["list"][var_5]["stock"] = level.player getweaponammostock(var_4[var_5]);
    }
  }
}

restoreplayerweaponstatepersistent(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::ter_op(isDefined(var_2) && var_2, ::switchtoweaponimmediate, ::switchtoweapon);

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(game["weaponstates"]))
    return 0;

  if(!isDefined(game["weaponstates"][var_0]))
    return 0;

  level.player takeallweapons();

  for(var_4 = 0; var_4 < game["weaponstates"][var_0]["list"].size; var_4++) {
    var_5 = game["weaponstates"][var_0]["list"][var_4]["name"];

    if(var_5 == "c4") {
      continue;
    }
    if(var_5 == "claymore") {
      continue;
    }
    level.player giveweapon(var_5);
    level.player givemaxammo(var_5);

    if(var_1) {
      level.player setweaponammoclip(var_5, game["weaponstates"][var_0]["list"][var_4]["clip"]);
      level.player setweaponammostock(var_5, game["weaponstates"][var_0]["list"][var_4]["stock"]);
    }
  }

  level.player switchtooffhand(game["weaponstates"][var_0]["offhand"]);
  level.player call[[var_3]](game["weaponstates"][var_0]["current"]);
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
  if(isDefined(level.loadout))
    return level.loadout;

  return level.script;
}

campaign(var_0) {
  level._lc = var_0;
}

persist(var_0, var_1, var_2) {
  var_3 = get_loadout();

  if(var_0 != var_3) {
    return;
  }
  if(!isDefined(game["previous_map"])) {
    return;
  }
  level._lc_persists = 1;

  if(isDefined(var_2))
    level.player setoffhandsecondaryclass(var_2);

  restoreplayerweaponstatepersistent(get_loadout(), 1);
  level.has_loadout = 1;
}

loadout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_0)) {
    var_7 = get_loadout();

    if(var_0 != var_7 || isDefined(level._lc_persists))
      return;
  }

  if(isDefined(var_1)) {
    level.default_weapon = var_1;
    level.player giveweapon(var_1);
  }

  if(isDefined(var_6))
    level.player setoffhandsecondaryclass(var_6);

  if(isDefined(var_2))
    level.player giveweapon(var_2);

  if(isDefined(var_3))
    level.player giveweapon(var_3);

  if(isDefined(var_4))
    level.player giveweapon(var_4);

  level.player switchtoweapon(var_1);

  if(isDefined(var_5))
    level.player setviewmodel(var_5);

  level.campaign = level._lc;
  level._lc = undefined;
  level.has_loadout = 1;
}

loadout_complete() {
  level.loadoutcomplete = 1;
  level notify("loadout complete");
}

default_loadout_if_notset() {
  if(level.has_loadout) {
    return;
  }
  loadout(undefined, "kriss", undefined, "flash_grenade", "fraggrenade", "viewmodel_base_viewhands", "flash");
  level.map_without_loadout = 1;
}