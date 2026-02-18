/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\oic.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#namespace oic;

function event_handler[gametype_init] main(eventstruct) {
  level.var_8eef5741 = 1;
  clientfield::register_clientuimodel("hudItems.alivePlayerCount", #"hud_items", #"aliveplayercount", 1, 4, "int", undefined, 0, 0);
}