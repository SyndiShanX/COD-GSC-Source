/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_49ade6666f36c74a.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_e59f070a7a8a4fcd;

function pick_random(params) {
  return params[randomint(params.size)];
}

function layout_join(params) {
  result = [];

  for(i = 0; i < params.size; i++) {
    param = params[i];

    if(isarray(param)) {
      result = result array_combine(result, param);
      continue;
    }

    result[result.size] = param;
  }

  return result;
}

function function_c7dcf35d43da192b(names) {
  entities = [];

  foreach(i, name in names) {
    entities[i] = getEnt(name, "script_noteworthy");
  }

  return entities;
}