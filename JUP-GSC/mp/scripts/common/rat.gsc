/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\rat.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace rat;

function init() {
  if(isDefined(level.var_6392befa93ae3cc6)) {
    return;
  }

  level.var_6392befa93ae3cc6 = [];
  level.var_91ca776f27d516c0 = [];
  ratregisterfunction("RatGetPlayerPosition", &ratgetplayerposition, "vector3");
  ratregisterfunction("RatGetPlayerAngles", &ratgetplayerangles, "vector3");
  ratregisterfunction("RatGetPlayerIsSwitchingWeapon", &ratgetplayerisswitchingweapon, "bool");
  ratregisterfunction("RatGetPlayerIsReloading", &ratgetplayerisreloading, "bool");
  ratregisterfunction("RatGetPlayerIsMeleeing", &ratgetplayerismeleeing, "bool");
  ratregisterfunction("RatGetPlayerADS", &ratgetplayerads, "float");
  ratregisterfunction("RatGetPlayerStance", &ratgetplayerstance, "string");
  ratregisterfunction("RatGetPlayerHealth", &ratgetplayerhealth, "int64_t");
  ratregisterfunction("RatSetPlayerHealth", &ratsetplayerhealth);
  ratregisterfunction("RatDoDamage", &ratdodamage, "bool");
  ratregisterfunction("RatGetClipAmmoCount", &ratgetclipammocount, "int64_t");
  ratregisterfunction("RatGetTotalAmmoCount", &ratgettotalammocount, "int64_t");
  ratregisterfunction("RatGetCompleteWeaponName", &ratgetcompleteweaponname, "string");
  ratregisterfunction("RatGetPlayerKills", &ratgetplayerkills, "int64_t");
  ratregisterfunction("RatGetPlayerDeaths", &ratgetplayerdeaths, "int64_t");
}

function ratregisterfunction(function_name, function_ref, return_type) {
  key = tolower(function_name);
  level.var_6392befa93ae3cc6[key] = function_ref;
  level.var_91ca776f27d516c0[key] = return_type;
}

function function_70cf605d288ebae(function_name) {
  init();
  key = tolower(function_name);

  if(isDefined(level.var_91ca776f27d516c0[key])) {
    return level.var_91ca776f27d516c0[key];
  }

  return "";
}

function function_b596c6ff2e019c61(params) {
  assert(isDefined(params._cmd));
  key = tolower(params._cmd);
  assert(isDefined(level.var_6392befa93ae3cc6[key]));
  func = level.var_6392befa93ae3cc6[key];
  return [[func]](params);
}

function getplayer(params) {
  if(isDefined(params.xuid)) {
    xuid = int(params.xuid);
    players = getEntArray("player", "classname");

    for(index = 0; index < players.size; index++) {
      player = players[index];

      if(!isDefined(player.bot)) {
        params.xuid = int(player getxuid());

        if(xuid == params.xuid) {
          return player;
        }
      }
    }
  }

  if(!isDefined(level.players) || !isDefined(level.players[0])) {
    return level.player;
  }

  return level.players[0];
}

function ratgetplayerposition(params) {
  player = getplayer(params);
  return player.origin + (0, 0, 60);
}

function ratgetplayerangles(params) {
  player = getplayer(params);
  playerangles = player getplayerangles();
  return ((playerangles[0] + 360) % 360, (playerangles[1] + 360) % 360, playerangles[2]);
}

function ratgetplayerisswitchingweapon(params) {
  player = getplayer(params);
  return player isswitchingweapon();
}

function ratgetplayerisreloading(params) {
  player = getplayer(params);
  return player isreloading();
}

function ratgetplayerismeleeing(params) {
  player = getplayer(params);
  return player ismeleeing();
}

function ratgetplayerads(params) {
  player = getplayer(params);
  return player playerads();
}

function ratgetplayerstance(params) {
  player = getplayer(params);
  return player getstance();
}

function ratgetplayerhealth(params) {
  player = getplayer(params);
  return player.health;
}

function ratsetplayerhealth(params) {
  amount = intvalue(params.amount, 1);
  player = getplayer(params);
  player.health = amount;
}

function ratdodamage(params) {
  amount = floatvalue(params.amount, 1);
  force_damage = boolvalue(params.force_damage, 0);
  player = getplayer(params);

  if(force_damage) {
    var_8e3f23290b67f726 = getdvarint(@ "hash_45dd70c0ac1afda2");
    setDvar(@ "hash_45dd70c0ac1afda2", 1);
    success = player dodamage(amount, player.origin);
    setDvar(@ "hash_45dd70c0ac1afda2", var_8e3f23290b67f726);
  } else {
    success = player dodamage(amount, player.origin, player);
  }

  return success;
}

function ratgetclipammocount(params) {
  player = getplayer(params);
  return player getcurrentweaponclipammo();
}

function ratgettotalammocount(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();
  return player getammocount(currentweapon);
}

function ratgetcompleteweaponname(params) {
  player = getplayer(params);
  currentweapon = player getcurrentweapon();
  weaponname = getcompleteweaponname(currentweapon);
  return weaponname;
}

function ratgetplayerkills(params) {
  player = getplayer(params);
  return player.kills;
}

function ratgetplayerdeaths(params) {
  player = getplayer(params);
  return player.deaths;
}

function intvalue(param, default_val) {
  if(!isDefined(param)) {
    return default_val;
  }

  return int(param);
}

function floatvalue(param, default_val) {
  if(!isDefined(param)) {
    return default_val;
  }

  return float(param);
}

function boolvalue(param, default_val) {
  if(!isDefined(param)) {
    return default_val;
  }

  param_lower = tolower(param);

  if(param_lower == "false" || param_lower == "0") {
    return 0;
  }

  return 1;
}