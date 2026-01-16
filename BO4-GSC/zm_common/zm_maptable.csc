/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_maptable.csc
***********************************************/

#include scripts\core_common\util_shared;

#namespace zm_maptable;

function_10672567() {
  if(!isDefined(level.maptableentry)) {
    mapname = util::get_map_name();
    fields = getmapfields();

    if(!isDefined(fields)) {
      fields = getmapfields(mapname, 0);
    }

    if(!isDefined(fields)) {
      fields = getmapfields(mapname, 1);
    }

    if(!isDefined(fields)) {
      fields = getmapfields(mapname, 2);
    }

    if(!isDefined(fields)) {
      fields = getmapfields(mapname, 3);
    }

    if(!isDefined(fields)) {
      fields = getmapfields(mapname, 4);
    }

    if(!isDefined(fields)) {
      fields = getmapfields(mapname, "<dev string:x38>");
    }

      level.maptableentry = fields;
  }

  return level.maptableentry;
}

get_cast() {
  cast = #"other";
  fields = function_10672567();

  if(isDefined(fields)) {
    cast = fields.cast;
  }

  return cast;
}

get_story() {
  var_26ea2807 = get_cast();

  if(var_26ea2807 === #"story1") {
    return 1;
  }

  return 2;
}