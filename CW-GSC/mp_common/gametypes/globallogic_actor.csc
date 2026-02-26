/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_actor.csc
*****************************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace globallogic_actor;

function private autoexec __init__system__() {
  system::register(#"globallogic_actor", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level._effect[#"rcbombexplosion"] = # "killstreaks/fx_rcxd_exp";
}