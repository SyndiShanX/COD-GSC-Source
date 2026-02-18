/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\zm\heatseekingmissile.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\heatseekingmissile;
#namespace heatseekingmissile;

function private autoexec __init__system__() {
  system::register(#"heatseekingmissile", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}