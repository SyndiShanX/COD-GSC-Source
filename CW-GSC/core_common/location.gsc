/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\location.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace location;

function private autoexec __init__system__() {
  system::register(#"location", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.locations = [];
  function_d1b7504e();
}

function function_d1b7504e() {
  var_74fed7b1 = struct::get_array("map_location");

  foreach(map_location in var_74fed7b1) {
    if(!isDefined(level.location)) {
      level.location = [];
    } else if(!isarray(level.location)) {
      level.location = array(level.location);
    }

    level.location[level.location.size] = map_location;
  }
}

function function_18dac968(origin, height, width, radius) {
  location = {
    #origin: origin, #height: height, #width: width, #radius: radius
  };

  if(!isDefined(level.location)) {
    level.location = [];
  } else if(!isarray(level.location)) {
    level.location = array(level.location);
  }

  level.location[level.location.size] = location;
  return location;
}

function function_2e7ce8a0() {
  return array::random(level.location);
}

function function_98eed213(location) {
  xoffset = 0;
  yoffset = 0;

  if(location.width > 0) {
    halfwidth = location.width / 2;
    xoffset = randomfloatrange(halfwidth * -1, halfwidth);
  }

  if(location.height > 0) {
    halfheight = location.height / 2;
    yoffset = randomfloatrange(halfheight * -1, halfheight);
  }

  origin = (location.origin[0] + xoffset, location.origin[1] + yoffset, location.origin[2]);
  return origin;
}