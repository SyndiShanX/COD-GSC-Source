/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6d8b721f24e2653d.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_a2fc8c70;

function private autoexec __init__system__() {
  system::register(#"hash_35d5e49c19d9cf09", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(is_true(getgametypesetting(#"hash_cd096e90260a26b"))) {
    level function_504792();
  }
}

function function_504792() {
  level._effect[# "orb_idle"] = "zombie/fx9_onslaught_orb_unstable";
  level._effect[# "soul_fx"] = "maps/zm_red/fx8_soul_red";
  level._effect[# "hash_308d15c5b36ba48a"] = "maps/zm_red/fx8_soul_charge_red";
  level._effect[# "hash_d7a655f41aa4b03"] = "zombie/fx9_onslaught_spawn_lg_unstable";
  level._effect[# "orb_activate"] = "zombie/fx9_onslaught_orb_unstable_collapse";
  level.var_de8cc106 = # "hash_6a78a4f5119b8978";
}