/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\hint_tutorial.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace hint_tutorial;

function private autoexec __init__system__() {
  system::register("hint_tutorial", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("toplayer", "hint_pause_state", 1, 1, "int", &function_22315c10, 1, 0);
}

function private function_22315c10(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (bwastimejump) {
    case 1:
      function_5ea2c6e3("cp_hint_tutorial_duck", 0.1, 1);
      break;
    case 0:
      function_ed62c9c2("cp_hint_tutorial_duck", 0.1);
      break;
  }
}