/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_actor.csc
*****************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace globallogic_actor;

autoexec __init__system__() {
  system::register(#"globallogic_actor", &__init__, undefined, undefined);
}

__init__() {
  level._effect[#"rcbombexplosion"] = #"killstreaks/fx_rcxd_exp";
}