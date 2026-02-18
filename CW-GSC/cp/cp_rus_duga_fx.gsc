/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_rus_duga_fx.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\cp_common\skipto;
#namespace duga_fx;

function private autoexec __init__system__() {
  system::register(#"duga_fx", &_preload, &function_fa076c68, undefined, undefined);
}

function private _preload() {
  function_bc948200();
}

function private function_fa076c68() {}

function private function_bc948200() {}