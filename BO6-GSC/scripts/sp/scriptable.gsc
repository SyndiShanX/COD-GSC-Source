/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\scriptable.gsc
**************************************/

#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\sp\door_scriptable;
#using scripts\sp\interactables\dynolight;
#namespace scriptable;

function scriptable_spglobalcallback() {
  scriptable_setinitcallback(&scriptable_spcallback);
}

function scriptable_spcallback() {
  starttime = gettime();
  scriptables = getscriptablearray("X\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95", #code_classname);

  foreach(scriptable in scriptables) {
    if(isDefined(scriptable.initialized)) {
      thread scriptable_print_warning();
      continue;
    }

    if(isDefined(scriptable.script_noteworthy)) {
      if(scriptable.script_noteworthy == "r\x8e\x9d\x1c\t\x94\xc9\v;\xb5d}Hu;\x06") {
        scriptable door_scriptable::scriptable_init();
      } else if(issubstr(scriptable.script_noteworthy, "\xaeU\x04q\x1dB?\xd1r")) {
        dynolight::add_dynolight(scriptable);
      }
    }

    scriptable.initialized = 1;
  }

  dynolight::init();
  assert(gettime() == starttime, "<dev string:x24>");
  waitframe();

  if(!utility::flag_exist("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97")) {
    utility::flag_init("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");
  }

  utility::flag_set("\x9bl'\xb4\x0e\xa3aL6Y\x9b\xd7\xc9+\x85\x8c\x97");
}

function scriptable_print_warning() {
  if(isDefined(level.scriptable_warning)) {
    return;
  }

  level.scriptable_warning = 1;
  wait 0.1;

  iprintln("<dev string:x54>");
}