/*************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\gametypes\fireteam_koth.csc
*************************************************/

#using script_2ce5448dd4c3e201;
#using script_6741a9edbcf6c25e;
#using script_6a72d858ff1942eb;
#using scripts\core_common\clientfield_shared;
#namespace fireteam_koth;

function event_handler[gametype_init] main(eventstruct) {
  namespace_2938acdc::init();
  namespace_d150537f::init();
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_friendly_count_0", #"hud_items_fireteam_percontroller", #"waypoint_friendly_count_0", 20000, 3, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_friendly_count_1", #"hud_items_fireteam_percontroller", #"waypoint_friendly_count_1", 20000, 3, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_friendly_count_2", #"hud_items_fireteam_percontroller", #"waypoint_friendly_count_2", 20000, 3, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_enemy_count_0", #"hud_items_fireteam_percontroller", #"waypoint_enemy_count_0", 20000, 3, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_enemy_count_1", #"hud_items_fireteam_percontroller", #"waypoint_enemy_count_1", 20000, 3, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hud_items_fireteam_percontroller.waypoint_enemy_count_2", #"hud_items_fireteam_percontroller", #"waypoint_enemy_count_2", 20000, 3, "int", undefined, 0, 0);
}