/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_746b9338c1f8a98.gsc
***********************************************/

#namespace namespace_e4c964e8;

function private function_7b29177a() {
  mapbundle = function_2717b55f();
  var_fc0caf4 = mapbundle.var_39cc9e65;

  if(isDefined(var_fc0caf4)) {
    return getscriptbundle(var_fc0caf4);
  }

  return undefined;
}

function private default_value(val, def) {
  if(isDefined(val)) {
    return val;
  }

  return def;
}

function private event_handler[level_init] main(eventstruct) {
  settings = function_7b29177a();

  if(isDefined(settings) && is_true(settings.var_9f40f0a7)) {
    setDvar(#"hash_53f625ed150e7700", default_value(settings.culldistance, 0));
    setDvar(#"hash_10fde33c9a36a9b4", default_value(settings.var_920327d8, 0));
    setDvar(#"cg_aggressivecullradius", default_value(settings.var_45fe6c24, 0));
    setDvar(#"hash_394141aabb847427", default_value(settings.var_cfe949f6, 0));
    setDvar(#"hash_72e6bad547b219c4", default_value(settings.var_8523ce94, 0));
    setDvar(#"hash_41f667b7ac4c5d0a", default_value(settings.var_8ca430ec, 0));
    setDvar(#"hash_7a38facac936bea9", default_value(settings.var_e84972d, 0));
  }
}