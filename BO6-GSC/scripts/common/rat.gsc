/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\rat.gsc
**************************************/

#namespace rat;

function init() {
  if(isDefined(level.var_855c138311a366fb)) {
    return;
  }

  level.var_855c138311a366fb = [];
  level.var_ade95642d19836cd = [];
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
  level.var_855c138311a366fb[key] = function_ref;
  level.var_ade95642d19836cd[key] = return_type;
}

function function_5dcc3c9b5e08f7d5(function_name) {
  init();
  key = tolower(function_name);

  if(isDefined(level.var_ade95642d19836cd[key])) {
    return level.var_ade95642d19836cd[key];
  }

  return "";
}

function function_23d093e60b946bcc(params) {
  assert(isDefined(params._cmd));
  key = tolower(params._cmd);
  assert(isDefined(level.var_855c138311a366fb[key]));
  func = level.var_855c138311a366fb[key];
  return [[func]](params);
}

function getplayer(params) {
  if(isDefined(params.xuid)) {
    xuid = int(params.xuid);
    players = getEntArray("player", #classname);

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

  if(!(isDefined(level.players) && isDefined(level.players[0]))) {
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
    var_8a6e95df9229044b = getdvarint(@ "scr_force_damage");
    setDvar(@ "scr_force_damage", 1);
    success = player dodamage(amount, player.origin);
    setDvar(@ "scr_force_damage", var_8a6e95df9229044b);
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