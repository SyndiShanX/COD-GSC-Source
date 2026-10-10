/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4bcf78b337139620.gsc
*************************************************/

#using script_54e6d1e4fb728cb8;
#using scripts\engine\utility;
#namespace namespace_22693044d975f365;

function function_b182ef8398a23949(delta, maxdist, callback) {
  level endon("game_ended");
  self endon("disconnect");
  crate = undefined;

  while(true) {
    crate = function_af8d4a24d632c42a(delta, maxdist);

    if(crate != undefined) {
      break;
    }

    waitframe();
  }

  self[[callback]](crate);
}

function function_6acecd6fbf30866(delta, maxdist) {
  return isDefined(function_af8d4a24d632c42a(delta, maxdist));
}

function function_d7cbf1e3a78fcdc(params) {
  assert(isDefined(params));
  angle = params.angle;
  maxdistance = params.maxdistance;
  assert(isDefined(angle));
  assert(isDefined(maxdistance));
  return function_6acecd6fbf30866(angle, maxdistance);
}

function function_af8d4a24d632c42a(delta, maxdist) {
  assert(delta);
  assert(maxdist);
  var_7fb8e975add38476 = ["br_loot_cache", "br_loot_cache_lege"];

  foreach(var_44844f47e6571a59 in var_7fb8e975add38476) {
    lootcaches = getlootscriptablearrayinradius(var_44844f47e6571a59, undefined, self.origin, maxdist);

    foreach(lootcache in lootcaches) {
      if(!isDefined(lootcache.itemsdropped) && function_ed838558ef4e4e91(lootcache, delta)) {
        return lootcache;
      }
    }
  }

  return undefined;
}

function function_49ff999b129c0c3f(params) {
  assert(isDefined(params));
  maxdist = params.maxdistance;
  assert(isDefined(maxdist));
  lootcache = function_203032caf2ef038b(maxdist);
  self.var_657f5a0d17435bc.var_93bacbf8fe541c21 = lootcache;
  return isDefined(lootcache);
}

function function_203032caf2ef038b(maxdist) {
  var_7fb8e975add38476 = ["br_loot_cache", "br_loot_cache_lege"];
  closestdist = maxdist * maxdist;
  closestcache = undefined;

  foreach(var_44844f47e6571a59 in var_7fb8e975add38476) {
    lootcaches = getlootscriptablearrayinradius(var_44844f47e6571a59, undefined, self.origin, maxdist);

    foreach(lootcache in lootcaches) {
      if(!isDefined(lootcache.itemsdropped)) {
        checkdist = distancesquared(lootcache.origin, self.origin);

        if(!isDefined(closestcache) || checkdist < closestdist) {
          currentstate = lootcache getscriptablepartstate("body", 1);

          if(isDefined(currentstate) && (currentstate == "closed_usable" || currentstate == "closed_usable_no_collision")) {
            closestcache = lootcache;
            closestdist = checkdist;
          }
        }
      }
    }
  }

  return closestcache;
}

function function_f3be9fa4b21eafc2(maxdist) {
  assert(maxdist);
  var_7fb8e975add38476 = ["br_loot_cache", "br_loot_cache_lege"];
  var_c110377a69278429 = [];

  foreach(var_44844f47e6571a59 in var_7fb8e975add38476) {
    lootcaches = [];
    lootcaches = getlootscriptablearrayinradius(var_44844f47e6571a59, undefined, self.origin, maxdist);
    var_c110377a69278429 = array_combine(lootcaches, var_c110377a69278429);
  }

  return var_c110377a69278429;
}