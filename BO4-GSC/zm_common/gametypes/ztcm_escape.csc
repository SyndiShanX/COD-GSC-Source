/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\ztcm_escape.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\zm_common\gametypes\ztcm;

#namespace ztcm_escape;

event_handler[gametype_init] main(eventstruct) {
  ztcm::main(eventstruct);
  level.var_7a973c0e = createuimodel(getglobaluimodel(), "ZMHudGlobal.tcm");
  setuimodelvalue(createuimodel(level.var_7a973c0e, "active"), 0);
  callback::on_localplayer_spawned(&function_13bfe0d8);
}

function_13bfe0d8(localclientnum) {
  setuimodelvalue(createuimodel(level.var_7a973c0e, "active"), 3);
}