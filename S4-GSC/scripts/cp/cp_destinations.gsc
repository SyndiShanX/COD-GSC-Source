/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\cp_destinations.gsc
*************************************************/

init() {
  setDvar("#x3ec4c98210e66f6e6", 10);
  level.destinationstreamingenabled = getdvarint("#x3ffc2e53a66127a90", 1);
  level.loadeddestination = undefined;
  level.hubdestination = "";
}

load_destination(var_0) {
  if(!level.destinationstreamingenabled) {
    return;
  }
  _func_039E(var_0);
  level.loadeddestination = var_0;
}

wait_for_current_destination_to_load() {
  if(!level.destinationstreamingenabled) {
    return;
  }
  while(isDefined(level.loadeddestination) && !_func_03A1(level.loadeddestination)) {
    waitframe();
  }
}

unload_current_destination() {
  if(!level.destinationstreamingenabled) {
    return;
  }
  wait_for_current_destination_to_load();

  if(isDefined(level.loadeddestination)) {
    _func_039F(level.loadeddestination);
    level.loadeddestination = undefined;
  }
}

get_loaded_destination() {
  if(!level.destinationstreamingenabled) {
    return "";
  }

  if(isDefined(level.loadeddestination)) {
    return level.loadeddestination;
  }

  return "";
}