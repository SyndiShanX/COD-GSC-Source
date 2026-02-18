/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\dynent_use.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace dynent_use;

function private autoexec __init__system__() {
  system::register(#"dynent_use", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::is_frontend_map() || !(isDefined(getgametypesetting(#"usabledynents")) ? getgametypesetting(#"usabledynents") : 0)) {
    return;
  }

  clientfield::register_clientuimodel("hudItems.dynentUseHoldProgress", #"hud_items", #"dynentuseholdprogress", 13000, 5, "float", undefined, 0, 0);
}