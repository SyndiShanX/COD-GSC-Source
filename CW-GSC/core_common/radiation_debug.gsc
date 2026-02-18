/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\radiation_debug.gsc
***********************************************/

#using script_c8d806d2487b617;
#using scripts\core_common\radiation;
#using scripts\core_common\system_shared;
#namespace radiation_debug;

function private autoexec __init__system__() {
  system::register(#"radiation_debug", &preinit, undefined, undefined, #"radiation");
}

function private preinit() {
  if(!namespace_956bd4dd::function_ab99e60c()) {
    return;
  }

  level thread _setup_devgui();
  level thread function_aa32646f();
}

function private _setup_devgui() {
  while(!canadddebugcommand()) {
    waitframe(1);
  }

  path = "<dev string:x38>";
  cmd = "<dev string:x5b>";
  adddebugcommand("<dev string:x81>" + path + "<dev string:x8f>" + cmd + "<dev string:xa4>");
  adddebugcommand("<dev string:x81>" + path + "<dev string:xaa>" + cmd + "<dev string:xbf>");
  adddebugcommand("<dev string:x81>" + path + "<dev string:xc5>" + cmd + "<dev string:xdb>");
  adddebugcommand("<dev string:x81>" + path + "<dev string:xe2>" + cmd + "<dev string:xf8>");
  adddebugcommand("<dev string:x81>" + path + "<dev string:xff>" + cmd + "<dev string:x116>");
  path = "<dev string:x11e>";
  adddebugcommand("<dev string:x81>" + path + "<dev string:x143>");
  adddebugcommand("<dev string:x81>" + path + "<dev string:x191>");
  adddebugcommand("<dev string:x81>" + path + "<dev string:x1f1>");
  adddebugcommand("<dev string:x81>" + path + "<dev string:x243>");
}

function private function_aa32646f() {}