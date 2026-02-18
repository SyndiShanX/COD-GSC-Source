/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_655e1025200f4d5b.gsc
***********************************************/

#using script_2a30ac7aa0ee8988;
#using scripts\core_common\item_world_fixup;
#namespace namespace_2d440395;

function autoexec function_88ff61e0() {
  thread function_45a212c0();
}

function function_45a212c0() {
  var_87d0eef8 = &item_world_fixup::remove_item;
  var_74257310 = &item_world_fixup::add_item_replacement;
  var_f8a4c541 = &item_world_fixup::function_6991057;

  while(!isDefined(level)) {
    waitframe(1);
  }

  level.var_21f73755 = 1;
}

function private function_205a8326(msg, var_9fb99f62) {
  if(isDefined(var_9fb99f62)) {
    println("<dev string:x38>" + msg + "<dev string:x50>" + var_9fb99f62);
    return;
  }

  println("<dev string:x38>" + msg);
}

function private function_48b77dbf(customgame) {
  var_9fb99f62 = "<dev string:x5e>";

  if(!is_true(getgametypesetting(#"wzenablespraycans"))) {
    var_9fb99f62 = "<dev string:x69>" + (isDefined(getgametypesetting(#"wzenablespraycans")) ? getgametypesetting(#"wzenablespraycans") : "<dev string:x81>");
  } else if(customgame) {
    if(gamemodeismode(1)) {
      var_9fb99f62 = "<dev string:x8e>";
    } else if(gamemodeismode(7)) {
      var_9fb99f62 = "<dev string:x9f>";
    }
  }

  function_205a8326("<dev string:xb6>", var_9fb99f62);
}