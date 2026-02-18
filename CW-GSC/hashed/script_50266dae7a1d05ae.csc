/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_50266dae7a1d05ae.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#namespace namespace_3983f538;

function autoexec main() {
  level endon(#"end_game");
  clientfield::register("world", "" + # "hash_2e92282adde859ff", 1, 1, "int", &function_7d6a713b, 0, 0);
  callback::on_spawned(&on_player_spawned);
}

function function_7d6a713b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    function_be93487f(fieldname, 2, 1, 1, 0, 0);
    return;
  }

  function_be93487f(fieldname, 1, 1, 1, 0, 0);
}

function on_player_spawned(localclientnum) {
  function_f58e42ae(localclientnum, 3);
}