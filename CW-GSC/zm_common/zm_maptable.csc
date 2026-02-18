/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_maptable.csc
***********************************************/

#using scripts\core_common\util_shared;
#namespace zm_maptable;

function function_10672567() {
  if(!isDefined(level.maptableentry)) {
    mapname = util::get_map_name();
    fields = getmapfields(mapname);
    level.maptableentry = fields;
  }

  return level.maptableentry;
}

function get_cast() {
  cast = # "other";
  fields = function_10672567();

  if(isDefined(fields)) {
    cast = fields.cast;
  }

  return cast;
}

function get_story() {
  var_26ea2807 = get_cast();

  if(var_26ea2807 === # "story1") {
    return 1;
  }

  return 2;
}