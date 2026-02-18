/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_93de924cdc949f.gsc
***********************************************/

#using script_1351b3cdb6539f9b;
#using scripts\core_common\array_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace namespace_8589bd1a;

function main() {}

function function_554199a0(location) {
  self notify("69fcf47cff35fbcb");
  self endon("69fcf47cff35fbcb");
  level flag::wait_till("level_intro_complete");

  if(isDefined(level.player)) {
    var_6a25fa7 = level.player getlightingstate();
  }

  if(level.var_731c10af.var_42659717 == 0) {
    if(isDefined(var_6a25fa7) && var_6a25fa7 != 0) {
      setlightingstate(0);
    }
  } else if(level.var_731c10af.var_42659717 == 1) {
    if(isDefined(var_6a25fa7) && var_6a25fa7 != 2) {
      setlightingstate(2);
    }
  } else if(level.var_731c10af.var_42659717 == 2) {
    if(isDefined(var_6a25fa7) && var_6a25fa7 != 0) {
      setlightingstate(0);
    }
  } else if(level.var_731c10af.var_42659717 == 3) {
    if(isDefined(var_6a25fa7) && var_6a25fa7 != 0) {
      setlightingstate(0);
    }
  }

  if(isDefined(location) && (location == "bunker" || location == "lab")) {
    if(isDefined(var_6a25fa7) && var_6a25fa7 != 0) {
      setlightingstate(0);
    }
  }
}

function function_b733d218(var_accd268b, var_159584a6 = "targetname", turn_on) {
  light_array = getEntArray(var_accd268b, var_159584a6);

  foreach(light in light_array) {
    if(!isDefined(light.default_intensity)) {
      light.default_intensity = light getlightintensity();
    }
  }

  if(isDefined(turn_on)) {
    foreach(light in light_array) {
      var_8b4ea7bd = light getlightintensity();

      if(var_8b4ea7bd != light.default_intensity) {
        light setlightintensity(light.default_intensity);
      }
    }

    return;
  }

  foreach(light in light_array) {
    var_8b4ea7bd = light getlightintensity();

    if(var_8b4ea7bd != 0) {
      light setlightintensity(0);
    }
  }
}