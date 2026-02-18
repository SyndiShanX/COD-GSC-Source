/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6ad6653eed415ffc.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_16910aff9d97c520;
#using script_17662ff15f00e748;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2050c3ca1efa3116;
#using script_226eec8e867ca977;
#using script_2a5bf5b4a00cee0d;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_48e04a393ec6d855;
#using script_49f7fe670ba9398e;
#using script_4a247ed69e84b56f;
#using script_4d748e58ce25b60c;
#using script_50fca1a24ae351;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_60c9f7551ce6c823;
#using script_634ae70c663d1cc9;
#using script_683a55734f15d50e;
#using script_6ee927dd468f79b0;
#using script_746267f0669c40ae;
#using script_74a56359b7d02ab6;
#using script_79315a6ccf4fce3d;
#using script_dc59353021baee1;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_40bb01c9;

function init() {
  level.doa.var_f5a14209 = [];
}

function function_f69dda63() {
  namespace_268747c0::function_96e2f261(level.doa.var_f5a14209, 1);
}

function function_ddb3fb8f() {
  foreach(trap in level.doa.var_f5a14209) {
    trap notify(#"destroy_hazard", {
      #var_760a0807: 1
    });
  }

  level.doa.var_f5a14209 = [];
}