/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_puzzle_loot_cache.gsc
************************************************************/

#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\structspawnconfig;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\objidpoolmanager;
#namespace puzzle_cache;

function autoexec init() {
  var_f0a41e29e2358f1a = getdvarint(@ "hash_509756357a8b62e3", 0) == 1;

  if(!var_f0a41e29e2358f1a) {
    return;
  }

  iprintln("<dev string:x1c>");
  init_debug();

  level.var_fa1aaea5978f2c8e = getdvarint(@ "hash_41511be21090e24a", 0) == 1;

  if(getdvarint(@ "scr_ssc_enabled", 0)) {
    scripts\mp\flags::function_1240434f4201ac9d("POIs_initialized");
    function_28d7437a275a45c7();
    scripts\mp\gametypes\br_circle::registercirclecallbacks(16, &dangercircletick);
  }

  registersharedfunc("brPuzzleLootCache", "spawnCacheSingleBase", &spawncachesinglebase);
  init_dialog();
}

function function_28d7437a275a45c7() {
  level endon("game_ended");

  while(!isDefined(level.ssc)) {
    waitframe();
  }

  scripts\cp_mp\structspawnconfig::function_4f7660cfd85cd517("puzzle_cache", &function_e6c1c35181a2870f);
  scripts\cp_mp\structspawnconfig::function_412f527ef0863f0e("puzzle_cache", &function_88501e89a993b890);
  scripts\cp_mp\structspawnconfig::function_eded5b87f8f7bdfd("puzzle_cache", &function_688349ac143a54bc);
}

function init_dialog() {
  while(!isDefined(game["dialog"])) {
    waitframe();
  }

  game["dialog"]["puzzle_cache_destroyed"] = "eaeg_eean_eest";
}

function function_e6c1c35181a2870f(structname) {
  allspawnlocations = getStructArray(structname, "targetname");
  return allspawnlocations;
}

function function_88501e89a993b890(structname, cachestruct) {
  if(!isDefined(level.var_e901d9c7ae760bd6)) {
    level.var_e901d9c7ae760bd6 = [];
  }

  level.var_e901d9c7ae760bd6[level.var_e901d9c7ae760bd6.size] = cachestruct;
  return cachestruct;
}

function function_688349ac143a54bc(structname) {
  level endon("game_ended");
  level waittill("scriptable_loot_hide_off");
  waitframe();

  if(!isDefined(level.var_e901d9c7ae760bd6) || level.var_e901d9c7ae760bd6.size == 0) {
    return;
  }

  level.var_b8279fd758a757fc = [];
  maxcaches = getdvarint(@ "hash_724f93c58932f368", 50);

  if(maxcaches > 0) {
    level.var_e901d9c7ae760bd6 = array_randomize(level.var_e901d9c7ae760bd6);
    maxcaches = int(min(maxcaches, level.var_e901d9c7ae760bd6.size));

    for(i = 0; i < maxcaches; i++) {
      cachestruct = level.var_e901d9c7ae760bd6[i];
      cache = function_13ace45be109698e(cachestruct);
      level.var_b8279fd758a757fc = array_add(level.var_b8279fd758a757fc, cache);
    }
  } else {
    foreach(cachestruct in level.var_e901d9c7ae760bd6) {
      cache = function_13ace45be109698e(cachestruct);
      level.var_b8279fd758a757fc = array_add(level.var_b8279fd758a757fc, cache);
    }
  }

  scripts\engine\scriptable::scriptable_adddamagedcallback(&function_86eda8d9956d4976);
  level.var_e901d9c7ae760bd6 = undefined;
}

function function_13ace45be109698e(cachestruct) {
  if(!isDefined(level.puzzlecaches)) {
    level.puzzlecaches = [];
  }

  cache = spawncachesinglebase(cachestruct.origin, cachestruct.angles);
  level.puzzlecaches[level.puzzlecaches.size] = cache;
  return cache;
}

function spawncachesinglebase(origin, angles) {
  cache = spawnscriptable("br_puzzle_loot_cache", origin, angles);
  cache setscriptablepartstate("base", "visible");

  if(level.var_fa1aaea5978f2c8e) {
    function_a20133b287aa61da(cache);
  }

  return cache;
}

function function_86eda8d9956d4976(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  cache = instance;

  if(cache.type != "br_puzzle_loot_cache" || istrue(cache.popped)) {
    return;
  }

  if(isDefined(eattacker)) {
    thread spawncacheloot(cache, eattacker);
    squadmates = [[getsharedfunc("game", "getSquadmates")]](eattacker.team, eattacker.sessionsquadid, 1);

    foreach(player in squadmates) {
      scripts\cp_mp\challenges::function_8359cadd253f9604(player, "BR_EASTEREGG_BUNNYKILL", 1);
    }
  }

  cache scriptablehide();
}

function spawncacheloot(cache, eattacker) {
  waitframe();

  if(isDefined(cache.popped) && cache.popped) {
    return;
  }

  items = getscriptcachecontents("br_puzzle_loot_cache", randomint(20));
  cache.containertype = 4;
  cache.itemsdropped = 0;

  if(eattacker scripts\common\vehicle::isvehicle()) {
    eattacker = eattacker.owner;
  }

  cache scripts\mp\gametypes\br_lootcache::lootcachespawncontents(items, 0, eattacker, undefined);
  cache.popped = 1;
  function_1dc8d7e303dba9a3(eattacker);
}

function function_1dc8d7e303dba9a3(player) {
  level thread scripts\mp\gametypes\br_public::brleaderdialogplayer("puzzle_cache_destroyed", player, 1, undefined, 0, undefined, "dx_br_jpbm_");
}

function scriptablehide() {
  cache = self;
  cache setscriptablepartstate("base", "dead");

  if(level.var_fa1aaea5978f2c8e) {
    if(isDefined(cache.scriptedobjid)) {
      objective_delete(cache.scriptedobjid);
      scripts\mp\objidpoolmanager::returnobjectiveid(cache.scriptedobjid);
      cache.scriptedobjid = undefined;
      return;
    }

    cache setscriptablepartstate("debug_icon", "disabled");
  }
}

function dangercircletick(dangercircleorigin, dangercircleradius, thresholdradius) {
  var_52d59c928eb97c81 = dangercircleradius + thresholdradius;

  foreach(cache in level.var_b8279fd758a757fc) {
    if(distance2dsquared(dangercircleorigin, cache.origin) > var_52d59c928eb97c81 * var_52d59c928eb97c81) {
      cache scriptablehide();
    }
  }
}

function function_a20133b287aa61da(cache) {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid != -1) {
    cache setscriptablepartstate("debug_icon", "disabled");
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", cache.origin, "jup_ui_map_icon_mr_peeks");
    scripts\mp\objidpoolmanager::function_d7e3c4a08682c1b9(objid, 1);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, 75);
    scripts\mp\objidpoolmanager::function_98ba077848896a3(objid, 1);
    scripts\mp\objidpoolmanager::function_846c2acd91309cd8(objid, 66, 73, 224);
    cache.scriptedobjid = objid;
    return;
  }

  cache setscriptablepartstate("debug_icon", "visible");
}

function init_debug() {
  function_6e7290c8ee4f558b("<dev string:x39>");
  add_devgui_command("<dev string:x56>", "<dev string:x6a>");
  function_fe953f000498048f();
}

# /