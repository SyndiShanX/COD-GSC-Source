/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_breakable_loot_cache.gsc
***************************************************************/

#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\structspawnconfig;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_lootcache;
#using scripts\mp\gametypes\br_pickups;
#namespace br_breakable_loot_cache;

function autoexec init() {
  if(!getdvarint(@ "hash_50661a2e735c4ff4", 1)) {
    return;
  }

  if(getdvarint(@ "scr_ssc_enabled", 0)) {
    scripts\mp\flags::function_1240434f4201ac9d("ssc_initialized");
    scripts\cp_mp\structspawnconfig::function_4f7660cfd85cd517("breakable_cache", &function_e6c1c35181a2870f);
    scripts\cp_mp\structspawnconfig::function_412f527ef0863f0e("breakable_cache", &function_88501e89a993b890);
    scripts\cp_mp\structspawnconfig::function_eded5b87f8f7bdfd("breakable_cache", &function_688349ac143a54bc);
    scripts\mp\gametypes\br_circle::registercirclecallbacks(19, &dangercircletick);
  }
}

function function_e6c1c35181a2870f(structname) {
  allspawnlocations = getStructArray(structname, "targetname");
  return allspawnlocations;
}

function function_88501e89a993b890(structname, cachestruct) {
  if(!isDefined(level.var_1bc7ff1d89c35da9)) {
    level.var_1bc7ff1d89c35da9 = [];
  }

  level.var_1bc7ff1d89c35da9[level.var_1bc7ff1d89c35da9.size] = cachestruct;
  return cachestruct;
}

function function_688349ac143a54bc(structname) {
  level endon("game_ended");
  level waittill("scriptable_loot_hide_off");
  waitframe();

  if(!isDefined(level.var_1bc7ff1d89c35da9) || level.var_1bc7ff1d89c35da9.size == 0) {
    return;
  }

  level.var_430915b3b28cf27d = [];

  foreach(cachestruct in level.var_1bc7ff1d89c35da9) {
    cache = function_13ace45be109698e(cachestruct);
    level.var_430915b3b28cf27d = array_add(level.var_430915b3b28cf27d, cache);
  }

  scripts\engine\scriptable::scriptable_adddamagedcallback(&function_86eda8d9956d4976);
  level.var_1bc7ff1d89c35da9 = undefined;
  thread function_eb667f4637b65478();
}

function function_eb667f4637b65478() {
  level waittill("br_ending_start");

  if(!isDefined(level.var_430915b3b28cf27d) || level.var_430915b3b28cf27d.size == 0) {
    return;
  }

  foreach(cache in level.var_430915b3b28cf27d) {
    if(isDefined(cache)) {
      cache scripts\mp\gametypes\br_pickups::deletescriptableinstance(1);
    }
  }
}

function function_13ace45be109698e(cachestruct) {
  if(!isDefined(level.var_8ccc53d3eec3626f)) {
    level.var_8ccc53d3eec3626f = [];
  }

  cache = spawncachesinglebase(cachestruct.origin, cachestruct.angles);
  level.var_8ccc53d3eec3626f[level.var_8ccc53d3eec3626f.size] = cache;
  return cache;
}

function spawncachesinglebase(origin, angles) {
  cache = spawnscriptable("br_breakable_loot_cache", origin, angles);
  cache setscriptablepartstate("base", "visible");
  return cache;
}

function function_86eda8d9956d4976(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  cache = instance;

  if(!isDefined(cache) || cache.type != "br_breakable_loot_cache") {
    return;
  }

  level thread function_c0897471dbdb42ad(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname);
}

function function_c0897471dbdb42ad(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  cache = instance;
  waittillframeend();

  if(eattacker scripts\common\vehicle::isvehicle()) {
    eattacker = eattacker.owner;
  }

  items = getscriptcachecontents("br_breakable_cache", randomint(20));
  cache.itemsdropped = 0;
  cache scripts\mp\gametypes\br_lootcache::lootcachespawncontents(items, 0, eattacker, undefined);
}

function scriptablehide() {
  cache = self;
  cache setscriptablepartstate("base", "dead");
}

function dangercircletick(dangercircleorigin, dangercircleradius, thresholdradius) {
  if(isDefined(level.var_430915b3b28cf27d)) {
    var_52d59c928eb97c81 = dangercircleradius + thresholdradius;

    foreach(cache in level.var_430915b3b28cf27d) {
      if(distance2dsquared(dangercircleorigin, cache.origin) > var_52d59c928eb97c81 * var_52d59c928eb97c81) {
        cache scriptablehide();
      }
    }
  }
}