/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1ad79c8c3b54b317.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_ping;
#namespace namespace_3bb7295f;

function private autoexec __init__system__() {
  system::register(#"hash_4e2289c68f35238d", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_ping::function_5ae4a10c(array(#"p8_wz_snowball_pile", #"p8_wz_snowball_pile_sml"), "snowball_pile", #"hash_34daeba184b6d103", undefined, #"ui_icon_inventory_snowball");
}