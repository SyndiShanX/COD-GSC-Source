/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_54b939ad79f46602.csc
***********************************************/

#using script_7c8886f468a029fb;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_utility;
#namespace namespace_a2a34bbc;

function private autoexec __init__system__() {
  system::register(#"hash_1613437b4759eb4a", &preinit, undefined, undefined, undefined);
}

function preinit() {
  if(!zm_utility::is_survival()) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_759fe9a9853a9b36")) && !getdvarint(#"hash_730311c63805303a", 0)) {
    return;
  }

  level.var_3c3b40c7 = sr_orda_health_bar::register();
}