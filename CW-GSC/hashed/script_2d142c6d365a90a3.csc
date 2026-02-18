/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2d142c6d365a90a3.csc
***********************************************/

#using scripts\core_common\util_shared;
#namespace namespace_956bd4dd;

function function_f45ee99d() {
  if(isDefined(level.radiation)) {
    return;
  }

  level.radiation = {};
  level.radiation.levels = [];
  level.radiation.sickness = [];
}

function function_df1ecefe(maxhealth, var_1263c72f, var_9653dad7 = 0, var_21a59205 = 2147483647) {
  if(!function_ab99e60c()) {
    return;
  }

  function_f45ee99d();
  radiationlevel = spawnStruct();
  radiationlevel.maxhealth = maxhealth;
  radiationlevel.sickness = [];
  radiationlevel.var_e8f27947 = int(var_1263c72f * 1000);
  radiationlevel.var_9653dad7 = var_9653dad7;
  radiationlevel.var_21a59205 = var_21a59205;
  level.radiation.levels[level.radiation.levels.size] = radiationlevel;
}

function function_1cb3c52d(name, radiationlevel, duration, var_4267b283 = # "hash_4ae27316c3f95575") {
  if(!function_ab99e60c()) {
    return;
  }

  function_f45ee99d();

  if(!isint(radiationlevel) || !isint(duration) || !ishash(name)) {
    assert(0);
    return;
  }

  if(level.radiation.levels.size <= radiationlevel) {
    assertmsg("<dev string:x38>" + radiationlevel + "<dev string:x71>");
    return;
  }

  radiation = level.radiation.levels[radiationlevel];

  if(isDefined(radiation.sickness[name])) {
    assertmsg("<dev string:x89>" + name + "<dev string:xad>");
    return;
  }

  var_46bdb64c = spawnStruct();
  var_46bdb64c.duration = int(duration * 1000);
  var_46bdb64c.var_4bd5611f = var_4267b283;
  radiation.sickness[name] = var_46bdb64c;
}

function function_6b384c0f(radiationlevel, sickness) {
  var_7720923c = level.radiation.levels[radiationlevel];
  keys = getarraykeys(var_7720923c.sickness);

  for(index = 0; index < keys.size; index++) {
    if(keys[index] == sickness) {
      return index;
    }
  }
}

function function_ab99e60c() {
  if(util::is_frontend_map()) {
    return false;
  }

  return currentsessionmode() != 4 && is_true(isDefined(getgametypesetting("wzRadiation")) ? getgametypesetting("wzRadiation") : 0);
}