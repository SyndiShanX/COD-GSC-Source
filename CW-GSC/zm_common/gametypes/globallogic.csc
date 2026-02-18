/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic.csc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#namespace globallogic;

function private autoexec __init__system__() {
  system::register(#"globallogic", &preinit, undefined, undefined, #"visionset_mgr");
}

function private preinit() {
  visionset_mgr::register_visionset_info("crithealth", 1, 25, undefined, "critical_health");
  clientfield::register_clientuimodel("hudItems.armorIsOnCooldown", #"hud_items", #"armorisoncooldown", 1, 1, "int", undefined, 0, 0);
  clientfield::function_91cd7763("string", "hudItems.cursorHintZMPurchaseInvalidText", #"hud_items", #"cursorhintzmpurchaseinvalidtext", 1, undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.cursorHintZMPurchaseInvalid", #"hud_items", #"cursorhintzmpurchaseinvalid", 1, 1, "int", undefined, 0, 0);
  level.new_health_model = 1;
}