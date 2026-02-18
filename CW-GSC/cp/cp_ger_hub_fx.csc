/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_ger_hub_fx.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_utility;
#namespace cp_ger_hub_fx;

function private autoexec __init__system__() {
  system::register(#"cp_ger_hub_fx", &_preload, &function_fa076c68, undefined, undefined);
}

function private _preload() {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  function_bc948200();
}

function private function_fa076c68() {}

function private function_bc948200() {}