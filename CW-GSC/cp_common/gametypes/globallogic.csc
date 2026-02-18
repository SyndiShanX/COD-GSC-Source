/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\globallogic.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#namespace globallogic;

function private autoexec __init__system__() {
  system::register(#"globallogic", &preinit, undefined, undefined, #"visionset_mgr");
}

function private preinit() {
  visionset_mgr::register_visionset_info("crithealth", 1, 25, undefined, "critical_health");
  level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
}