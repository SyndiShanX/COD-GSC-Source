/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scriptable.gsc
***********************************************/

scriptable_spglobalcallback() {
  scripts\engine\scriptable::scriptable_setinitcallback(::scriptable_spcallback);
}

scriptable_spcallback() {
  var_0 = gettime();
  var_1 = getscriptablearray("scriptable", "code_classname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.initialized)) {
      thread scriptable_print_warning();
      continue;
    }

    if(isDefined(var_3.script_noteworthy)) {
      if(var_3.script_noteworthy == "interactive_door")
        var_3 scripts\sp\door_scriptable::scriptable_init();
      else if(issubstr(var_3.script_noteworthy, "dynolight"))
        scripts\sp\interactables\dynolight::add_dynolight(var_3);
    }

    var_3.initialized = 1;
  }

  scripts\sp\interactables\dynolight::init();
  waitframe();

  if(!scripts\engine\utility::flag_exist("scriptables_ready"))
    scripts\engine\utility::flag_init("scriptables_ready");

  scripts\engine\utility::flag_set("scriptables_ready");
}

scriptable_print_warning() {
  if(isDefined(level.scriptable_warning)) {
    return;
  }
  level.scriptable_warning = 1;
  wait 0.1;
  iprintln("^3Scriptables tried re-initializing, you may want to map_restart for safety");
}