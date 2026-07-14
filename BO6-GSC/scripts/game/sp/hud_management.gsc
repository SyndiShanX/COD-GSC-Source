/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\game\sp\hud_management.gsc
**********************************************/

#using scripts\common\system;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace hud_management;

function private autoexec __init__system__() {
  system::register(#"hash_7a72c0b5b88f5ace", undefined, undefined, &post_main);
}

function private post_main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  foreach(player in level.players) {
    player thread function_3b734e29f1ed7c37();
    player thread function_32502e48e29004ee();

    if(getdvarint(@ "marketing_build", 0) != 0) {
      player function_170c03b36bf19328("<dev string:x24>", "<dev string:x37>", 1, 1);
    }
  }
}

function private function_3b734e29f1ed7c37() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  var_31dad4748b39ef77 = ["?\xe9\x13p,\xe8\v\xbb\xfcF.J\xb7\xd3\x0es3"];

  while(true) {
    self waittill("`\x16\xae\xa2\xe4t\x187\xe7");

    if(val::get("`\x16\xae\xa2\xe4t\x187\xe7")) {
      function_a4b07de99918f624("`\x16\xae\xa2\xe4t\x187\xe7");
      continue;
    }

    function_170c03b36bf19328("`\x16\xae\xa2\xe4t\x187\xe7", var_31dad4748b39ef77, 1, 1);
  }
}

function private function_32502e48e29004ee() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  var_31dad4748b39ef77 = ["?\xe9\x13p,\xe8\v\xbb\xfcF.J\xb7\xd3\x0es3"];

  if(self gethandsoccupied()) {
    function_170c03b36bf19328("\x86X7\x8c\xdc", var_31dad4748b39ef77, 1, 1);
  }

  while(true) {
    self waittill("\x86X7\x8c\xdc");

    if(val::get("\x86X7\x8c\xdc")) {
      function_a4b07de99918f624("\x86X7\x8c\xdc");
      continue;
    }

    function_170c03b36bf19328("\x86X7\x8c\xdc", var_31dad4748b39ef77, 1, 1);
  }
}