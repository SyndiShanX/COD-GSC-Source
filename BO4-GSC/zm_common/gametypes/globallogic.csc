/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;

#namespace globallogic;

autoexec __init__system__() {
  system::register(#"globallogic", &__init__, undefined, #"visionset_mgr");
}

__init__() {
  visionset_mgr::register_visionset_info("crithealth", 1, 25, undefined, "critical_health");
  level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
}