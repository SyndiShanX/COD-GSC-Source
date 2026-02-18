/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\territory_util.gsc
***********************************************/

#using scripts\core_common\struct;
#namespace territory;

function function_c0de0601() {
  return isDefined(level.territory) && level.territory.name != "";
}

function get_center(territory = level.territory) {
  center = (0, 0, 0);

  if(!function_c0de0601() || territory.bounds.size <= 0) {
    return center;
  }

  foreach(boundary in territory.bounds) {
    center += boundary.origin;
  }

  return center / territory.bounds.size;
}

function get_radius(territory = level.territory) {
  absmins = [];
  absmaxs = [];

  if(!isstruct(territory) || !isarray(territory.bounds)) {
    return;
  }

  foreach(bound in territory.bounds) {
    var_f3ba0cb3 = bound.origin + bound.mins;
    var_cd8bd6d = bound.origin + bound.maxs;

    for(i = 0; i < 3; i++) {
      if(!isDefined(absmins[i])) {
        absmins[i] = var_f3ba0cb3[i];
      }

      if(!isDefined(absmaxs[i])) {
        absmaxs[i] = var_cd8bd6d[i];
      }

      absmins[i] = min(absmins[i], var_f3ba0cb3[i]);
      absmaxs[i] = max(absmaxs[i], var_cd8bd6d[i]);
    }
  }

  absmin = (absmins[0], absmins[1], 0);
  absmax = (absmaxs[0], absmaxs[1], 0);
  return distance2d(absmin, absmax) / 2;
}

function is_inside(point, ignoreheight = 0, territory = level.territory) {
  if(!function_c0de0601()) {
    return true;
  }

  if(!isvec(point)) {
    assert(0);
    return false;
  }

  if(!isDefined(territory.bounds) || territory.bounds.size == 0) {
    return true;
  }

  foreach(boundary in territory.bounds) {
    testpoint = point;

    if(ignoreheight) {
      testpoint = (testpoint[0], testpoint[1], boundary.origin[2]);
    }

    if(boundary istouching(testpoint)) {
      return true;
    }
  }

  return false;
}

function is_valid(object, territory = level.territory) {
  if(isDefined(territory.script_territory) && isDefined(object.script_territory) && territory.script_territory != object.script_territory) {
    return false;
  }

  return true;
}

function function_b3791221(maxattempts = 10, territory = level.territory) {
  if(!function_c0de0601()) {
    return;
  }

  absmins = [];
  absmaxs = [];

  if(!isstruct(territory) || !isarray(territory.bounds)) {
    return;
  }

  foreach(bound in territory.bounds) {
    var_f3ba0cb3 = bound.origin + bound.mins;
    var_cd8bd6d = bound.origin + bound.maxs;

    for(i = 0; i < 3; i++) {
      if(!isDefined(absmins[i])) {
        absmins[i] = var_f3ba0cb3[i];
      }

      if(!isDefined(absmaxs[i])) {
        absmaxs[i] = var_cd8bd6d[i];
      }

      absmins[i] = min(absmins[i], var_f3ba0cb3[i]);
      absmaxs[i] = max(absmaxs[i], var_cd8bd6d[i]);
    }
  }

  if(absmins.size <= 0 || absmaxs.size <= 0) {
    return;
  }

  for(index = 0; index < maxattempts; index++) {
    point = [];

    for(i = 0; i < 3; i++) {
      point[i] = randomfloatrange(absmins[i], absmaxs[i]);
    }

    randompoint = (point[0], point[1], point[2]);

    if(is_inside(randompoint, undefined, territory)) {
      return randompoint;
    }
  }
}

function function_5c7345a3(name, key, territory = level.territory) {
  structs = struct::get_array(name, key);
  return function_39dd704c(structs, territory);
}

function function_39dd704c(objects, territory) {
  validobjects = [];

  if(!isDefined(territory) || !isDefined(territory.name) || territory.name == "") {
    foreach(object in objects) {
      if(!isDefined(object.script_territory)) {
        validobjects[validobjects.size] = object;
      }
    }
  } else {
    foreach(object in objects) {
      if(!is_valid(object, territory)) {
        continue;
      }

      if(!is_inside(object.origin, undefined, territory)) {
        continue;
      }

      validobjects[validobjects.size] = object;
    }
  }

  return validobjects;
}