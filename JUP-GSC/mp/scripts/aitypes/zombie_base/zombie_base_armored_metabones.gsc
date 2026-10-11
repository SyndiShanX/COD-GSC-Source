/****************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\aitypes\zombie_base\zombie_base_armored_metabones.gsc
****************************************************************************/

#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\engine\utility;
#namespace zombie_base_armored_metabones;

function autoexec main() {
  var_601bcee5d276f46d = "zombie_base_armored";
  function_d6736c5ef5ac2990(var_601bcee5d276f46d, &function_b9f4b7206d76e7ce);
}

function private function_b9f4b7206d76e7ce(params) {
  function_ebb83c1efeaae2c7(params.metabone_name);
}

function private function_ebb83c1efeaae2c7(metabone_name) {
  if(self getscriptablehaspart(metabone_name)) {
    self setscriptablepartstate(metabone_name, "destroyed");
    function_3d2728c0e2252a1d(metabone_name, "exposed");

    if(metabone_name == "armored_head") {
      function_7380ccd6f2c49392(metabone_name, 1);
    }

    return;
  }

  assertmsg("<dev string:x1c>" + metabone_name);
}