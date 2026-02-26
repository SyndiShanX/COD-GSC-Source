/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_tungsten_zones.gsc
***********************************************/

#using script_4ce5d94e8c797350;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\compass;
#using scripts\core_common\flag_shared;
#using scripts\core_common\rappel;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\territory;
#using scripts\core_common\util_shared;
#using scripts\core_common\zipline_player;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_tungsten_zones;

function autoexec init() {
  callback::on_spawned(&function_44b1279a);
  level.var_65c43c31 = ["zone_bunker_entrance_01", "zone_bunker_entrance_02", "zone_bunker_entrance_03", "zone_service_tunnels_01", "zone_service_tunnels_02", "zone_service_tunnels_03", "zone_board_room_01", "zone_board_room_02", "zone_pa_room_01", "zone_pa_room_02", "zone_bunker_entrance", "zone_service_tunnels", "zone_board_room", "zone_board_office"];
  level.var_707f916f = ["zone_helipads", "zone_helipads_3", "zone_helipads_portal_room", "zone_main_street_backlot", "zone_xxx_club_roof", "zone_high_tide_bar_roof", "zone_main_street_bridge", "zone_anytown_usa_backlot", "zone_video_store_roof", "zone_bunker_entrance_01", "zone_service_tunnels_03", "zone_observation"];
  level.var_dc2ca204 = ["zone_helipads", "zone_helipads_2", "zone_helipads_3", "zone_helipads_4", "zone_helipads_portal_room"];
  level.var_6097ff89 = ["zone_main_street_backlot", "zone_main_street", "zone_main_street_01", "zone_main_street_02", "zone_main_street_bridge", "zone_deck_bar", "zone_diner", "zone_xxx_club", "zone_xxx_club_roof", "zone_pizza_kitchen", "zone_donuts", "zone_pizza_parlor", "zone_high_tide_bar", "zone_high_tide_bar_roof"];
  level.var_2f941a56 = ["zone_anytown_usa_backlot", "zone_anytown_usa_east", "zone_anytown_usa_east_2", "zone_burger_town", "zone_burger_town_roof", "zone_drinks_bar", "zone_drinks_bar_roof", "zone_anytown_usa_west", "zone_anytown_usa_west_2", "zone_arcade", "zone_video_store", "zone_video_store_2f", "zone_video_store_roof", "zone_tv_repair", "zone_cinema", "zone_concessions", "zone_anytown_usa_rooftops"];
  level.var_359fd531 = level.var_65c43c31;
  level.var_6eacc74a = arraycombine(level.var_6097ff89, level.var_2f941a56);
  level.var_747c9217 = ["zone_ndu_room", "zone_facility_shell_rooftop", "zone_observation"];
  level.var_c9350d57 = ["zone_observation"];
  level.var_aa3b88c5 = &function_27028b8e;
  level.var_27028b8e = &function_27028b8e;
  level.var_662dc783 = &function_6e486b1;
}

function zone_init() {
  level flag::set("always_on");
  zm_zonemgr::zone_init("zone_helipads");
  zm_zonemgr::zone_init("zone_main_street_backlot");
  zm_zonemgr::zone_init("zone_anytown_usa_west");
  zm_zonemgr::zone_init("zone_bunker_entrance_01");
  zm_zonemgr::zone_init("zone_observation");
  zm_zonemgr::zone_init("zone_facility_shell_rooftop");
  zm_zonemgr::zone_init("zone_ndu_room");
  zm_zonemgr::zone_init("zone_intermission");

  if(zm_utility::is_ee_enabled()) {
    zm_zonemgr::zone_init("zone_pizza_kitchen");
    zm_zonemgr::enable_zone("zone_pizza_kitchen");
  }

  zm_zonemgr::enable_zone("zone_helipads");
  zm_zonemgr::enable_zone("zone_facility_shell_rooftop");
  zm_zonemgr::enable_zone("zone_ndu_room");
  zm_zonemgr::add_adjacent_zone("zone_helipads", "zone_helipads_2", "always_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_helipads", "zone_helipads_3", "always_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_helipads", "zone_helipads_4", "always_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_helipads_2", "zone_helipads_3", "always_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_helipads_2", "zone_helipads_4", "always_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_helipads_3", "zone_helipads_4", "always_on", 0);
  zm_zonemgr::add_adjacent_zone("zone_helipads_3", "zone_helipads_portal_room", "connect_helipad_to_portal", 0);
  zm_zonemgr::add_adjacent_zone("zone_main_street_backlot", "zone_main_street_01", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_main_street_backlot", "zone_deck_bar", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_main_street_backlot", "zone_donuts", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_main_street_01", "zone_main_street_backlot", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_main_street_01", "zone_donuts", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_main_street_01", "zone_deck_bar", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_main_street_01", "zone_diner", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_main_street_01", "zone_pizza_parlor", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_main_street_01", "zone_main_street_02", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_main_street_01", "zone_xxx_club", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_main_street_01", "zone_high_tide_bar", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_donuts", "zone_main_street_backlot", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_donuts", "zone_main_street_01", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_donuts", "zone_deck_bar", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_donuts", "zone_pizza_parlor", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_donuts", "zone_diner", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_deck_bar", "zone_main_street_backlot", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_deck_bar", "zone_main_street_01", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_deck_bar", "zone_donuts", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_deck_bar", "zone_pizza_parlor", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_deck_bar", "zone_diner", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_main_street_02", "zone_main_street_01", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_main_street_02", "zone_donuts", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_main_street_02", "zone_deck_bar", "connect_backlot_to_mainstreet");
  zm_zonemgr::add_adjacent_zone("zone_main_street_02", "zone_xxx_club", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_main_street_02", "zone_high_tide_bar", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_main_street_02", "zone_main_street_03", "main_street_tunnel_open");
  zm_zonemgr::add_adjacent_zone("zone_main_street_02", "zone_main_street_bridge", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_pizza_kitchen", "zone_pizza_parlor", "kitchen_door_open");
  zm_zonemgr::add_adjacent_zone("zone_pizza_parlor", "zone_pizza_kitchen", "kitchen_door_open");
  zm_zonemgr::add_adjacent_zone("zone_pizza_parlor", "zone_main_street_01", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_pizza_parlor", "zone_donuts", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_pizza_parlor", "zone_deck_bar", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_pizza_parlor", "zone_high_tide_bar", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_pizza_parlor", "zone_high_tide_bar_roof", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar", "zone_pizza_parlor", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar", "zone_main_street_01", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar", "zone_main_street_02", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar", "zone_xxx_club", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar", "zone_high_tide_bar_roof", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar_roof", "zone_pizza_parlor", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar_roof", "zone_main_street_02", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar_roof", "zone_high_tide_bar", "connect_pizza_parlor");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar_roof", "zone_xxx_club", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar_roof", "zone_xxx_club_roof", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_high_tide_bar_roof", "zone_main_street_bridge", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_diner", "zone_donuts", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_diner", "zone_deck_bar", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_diner", "zone_main_street_01", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_diner", "zone_main_street_02", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_diner", "zone_xxx_club", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_diner", "zone_xxx_club_roof", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club", "zone_main_street_01", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club", "zone_main_street_02", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club", "zone_diner", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club", "zone_xxx_club_roof", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club", "zone_high_tide_bar", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club_roof", "zone_main_street_01", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club_roof", "zone_main_street_02", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club_roof", "zone_diner", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club_roof", "zone_xxx_club", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club_roof", "zone_deck_bar", "connect_diner");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club_roof", "zone_high_tide_bar_roof", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_xxx_club_roof", "zone_main_street_bridge", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_main_street_bridge", "zone_high_tide_bar", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_main_street_bridge", "zone_high_tide_bar_roof", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_main_street_bridge", "zone_xxx_club", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_main_street_bridge", "zone_xxx_club_roof", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_main_street_bridge", "zone_main_street_02", "connect_xxx_club_to_high_tide_bar");
  zm_zonemgr::add_adjacent_zone("zone_main_street_03", "zone_main_street_04", "main_street_tunnel_open");
  zm_zonemgr::add_adjacent_zone("zone_main_street_03", "zone_main_street_02", "main_street_tunnel_open");
  zm_zonemgr::add_adjacent_zone("zone_main_street_04", "zone_main_street_03", "main_street_tunnel_open");
  zm_zonemgr::add_adjacent_zone("zone_main_street_04", "zone_main_street_tunnel", "main_street_tunnel_open");
  zm_zonemgr::add_adjacent_zone("zone_main_street_tunnel", "zone_main_street_04", "main_street_tunnel_open");
  zm_zonemgr::add_adjacent_zone("zone_main_street_tunnel", "zone_main_street_tunnel_02", "main_street_tunnel_open");
  zm_zonemgr::add_adjacent_zone("zone_main_street_tunnel_02", "zone_main_street_tunnel", "main_street_tunnel_open");
  level thread function_5077fd82();
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_backlot", "zone_anytown_usa_east", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_backlot", "zone_burger_town", "connect_burger_town");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east", "zone_anytown_usa_backlot", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east", "zone_anytown_usa_east_2", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east", "zone_burger_town", "connect_burger_town");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east", "zone_drinks_bar", "connect_drinks_bar");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east", "zone_tv_repair", "connect_tv_repair");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east", "zone_concessions", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east", "zone_drinks_bar_roof", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east_2", "zone_anytown_usa_east", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east_2", "zone_burger_town", "connect_burger_town");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east_2", "zone_drinks_bar", "connect_drinks_bar");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east_2", "zone_tv_repair", "connect_tv_repair");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east_2", "zone_concessions", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_east_2", "zone_drinks_bar_roof", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_burger_town", "zone_anytown_usa_backlot", "connect_burger_town");
  zm_zonemgr::add_adjacent_zone("zone_burger_town", "zone_anytown_usa_east", "connect_burger_town");
  zm_zonemgr::add_adjacent_zone("zone_burger_town", "zone_anytown_usa_east_2", "connect_burger_town");
  zm_zonemgr::add_adjacent_zone("zone_burger_town", "zone_drinks_bar", "connect_burger_to_drinks");
  zm_zonemgr::add_adjacent_zone("zone_burger_town", "zone_tv_repair", "connect_burger_to_tv");
  zm_zonemgr::add_adjacent_zone("zone_burger_town", "zone_concessions", "connect_burger_to_concessions");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar", "zone_anytown_usa_east", "connect_drinks_bar");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar", "zone_anytown_usa_east_2", "connect_drinks_bar");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar", "zone_tv_repair", "connect_drinks_to_tv");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar", "zone_concessions", "connect_drinks_to_concessions");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar", "zone_burger_town", "connect_burger_to_drinks");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar", "zone_drinks_bar_roof", "connect_drinks_bar");
  zm_zonemgr::add_adjacent_zone("zone_tv_repair", "zone_anytown_usa_east", "connect_tv_repair");
  zm_zonemgr::add_adjacent_zone("zone_tv_repair", "zone_anytown_usa_east_2", "connect_tv_repair");
  zm_zonemgr::add_adjacent_zone("zone_tv_repair", "zone_drinks_bar", "connect_drinks_to_tv");
  zm_zonemgr::add_adjacent_zone("zone_tv_repair", "zone_cinema", "connect_tv_to_cinema_concessions");
  zm_zonemgr::add_adjacent_zone("zone_tv_repair", "zone_concessions", "connect_tv_to_cinema_concessions");
  zm_zonemgr::add_adjacent_zone("zone_tv_repair", "zone_burger_town", "connect_burger_to_tv");
  zm_zonemgr::add_adjacent_zone("zone_tv_repair", "zone_anytown_usa_west", "connect_tv_repair");
  zm_zonemgr::add_adjacent_zone("zone_tv_repair", "zone_anytown_usa_west_2", "connect_tv_repair");
  zm_zonemgr::add_adjacent_zone("zone_tv_repair", "zone_video_store", "connect_tv_to_video_arcade");
  zm_zonemgr::add_adjacent_zone("zone_tv_repair", "zone_arcade", "connect_tv_to_video_arcade");
  zm_zonemgr::add_adjacent_zone("zone_concessions", "zone_anytown_usa_east", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_concessions", "zone_anytown_usa_east_2", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_concessions", "zone_burger_town", "connect_burger_to_concessions");
  zm_zonemgr::add_adjacent_zone("zone_concessions", "zone_drinks_bar", "connect_drinks_to_concessions");
  zm_zonemgr::add_adjacent_zone("zone_concessions", "zone_cinema", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_concessions", "zone_anytown_usa_west", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_cinema", "zone_anytown_usa_east_2", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_cinema", "zone_concessions", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_cinema", "zone_burger_town", "connect_burger_to_concessions");
  zm_zonemgr::add_adjacent_zone("zone_cinema", "zone_anytown_usa_west", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_cinema", "zone_anytown_usa_west_2", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_cinema", "zone_tv_repair", "connect_tv_to_cinema_concessions");
  zm_zonemgr::add_adjacent_zone("zone_cinema", "zone_video_store", "connect_cinema_to_video_arcade");
  zm_zonemgr::add_adjacent_zone("zone_cinema", "zone_arcade", "connect_cinema_to_video_arcade");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west", "zone_cinema", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west", "zone_anytown_usa_west_2", "connect_anytown_usa_west_zones");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west", "zone_tv_repair", "connect_tv_repair");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west", "zone_video_store", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west", "zone_arcade", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west", "zone_video_store_roof", "connect_anytown_usa_west_zones");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west_2", "zone_cinema", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west_2", "zone_anytown_usa_west", "connect_anytown_usa_west_zones");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west_2", "zone_tv_repair", "connect_tv_repair");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west_2", "zone_video_store", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west_2", "zone_video_store_2f", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_west_2", "zone_arcade", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_arcade", "zone_video_store", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_arcade", "zone_video_store_2f", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_arcade", "zone_video_store_roof", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_arcade", "zone_anytown_usa_west", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_arcade", "zone_anytown_usa_west_2", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store", "zone_arcade", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store", "zone_anytown_usa_west", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store", "zone_anytown_usa_west_2", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store", "zone_video_store_roof", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store", "zone_video_store_2f", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store_2f", "zone_arcade", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store_2f", "zone_anytown_usa_west", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store_2f", "zone_anytown_usa_west_2", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store_2f", "zone_video_store_roof", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store_2f", "zone_video_store", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store_roof", "zone_arcade", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store_roof", "zone_cinema", "connect_cinema");
  zm_zonemgr::add_adjacent_zone("zone_video_store_roof", "zone_anytown_usa_west", "connect_anytown_usa_west_zones");
  zm_zonemgr::add_adjacent_zone("zone_video_store_roof", "zone_anytown_usa_west_2", "connect_anytown_usa_west_zones");
  zm_zonemgr::add_adjacent_zone("zone_video_store_roof", "zone_video_store_2f", "connect_video_store");
  zm_zonemgr::add_adjacent_zone("zone_video_store_roof", "zone_anytown_usa_rooftops", "connect_anytown_usa_rooftops");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_rooftops", "zone_video_store_roof", "connect_anytown_usa_rooftops");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_rooftops", "zone_anytown_usa_west_2", "connect_anytown_usa_rooftops");
  zm_zonemgr::add_adjacent_zone("zone_anytown_usa_rooftops", "zone_drinks_bar_roof", "connect_anytown_usa_rooftops");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar_roof", "zone_anytown_usa_rooftops", "connect_anytown_usa_rooftops");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar_roof", "zone_burger_town_roof", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar_roof", "zone_anytown_usa_east", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar_roof", "zone_anytown_usa_east_2", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_drinks_bar_roof", "zone_drinks_bar", "connect_drinks_bar");
  zm_zonemgr::add_adjacent_zone("zone_burger_town_roof", "zone_anytown_usa_rooftops", "connect_anytown_usa_rooftops");
  zm_zonemgr::add_adjacent_zone("zone_burger_town_roof", "zone_drinks_bar_roof", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_burger_town_roof", "zone_anytown_usa_east", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_burger_town_roof", "zone_anytown_usa_east_2", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_adjacent_zone("zone_burger_town_roof", "zone_drinks_bar", "connect_drinks_bar");
  zm_zonemgr::add_zone_flags("connect_cinema", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_zone_flags("connect_tv_repair", "connect_anytown_usa_east_zones");
  zm_zonemgr::add_zone_flags("connect_anytown_usa_rooftops", "connect_anytown_usa_east_zones");
  level thread function_e20c4fba();
  level thread function_a7b4cb9e();
  level thread function_2803d91d();
  level thread function_e41728ee();
  level thread function_da725fc1();
  level thread function_68e1cb94();
  level thread function_158bd6c6();
  level thread function_dde97037();
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_01", "zone_bunker_entrance_02", "connect_bunker_entrance_zones");
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_01", "zone_bunker_entrance_03", "connect_bunker_entrance_zones");
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_02", "zone_bunker_entrance_01", "connect_bunker_entrance_zones");
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_02", "zone_bunker_entrance_03", "connect_bunker_entrance_zones");
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_02", "zone_board_room_01", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_03", "zone_bunker_entrance_01", "connect_bunker_entrance_zones");
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_03", "zone_bunker_entrance_02", "connect_bunker_entrance_zones");
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_03", "zone_board_room_01", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_03", "zone_service_tunnels_01", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_03", "zone_service_tunnels_02", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_bunker_entrance_03", "zone_pa_room_01", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_01", "zone_bunker_entrance_02", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_01", "zone_bunker_entrance_03", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_01", "zone_service_tunnels_02", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_01", "zone_pa_room_01", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_01", "zone_pa_room_02", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_02", "zone_bunker_entrance_03", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_02", "zone_service_tunnels_01", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_02", "zone_service_tunnels_03", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_02", "zone_pa_room_01", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_02", "zone_pa_room_02", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_02", "zone_board_room_02", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_03", "zone_service_tunnels_01", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_03", "zone_service_tunnels_02", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_03", "zone_pa_room_01", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_03", "zone_pa_room_02", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_service_tunnels_03", "zone_board_room_02", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_pa_room_01", "zone_pa_room_02", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_pa_room_01", "zone_service_tunnels_01", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_pa_room_01", "zone_service_tunnels_02", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_pa_room_01", "zone_service_tunnels_03", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_pa_room_02", "zone_pa_room_01", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_pa_room_02", "zone_service_tunnels_01", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_pa_room_02", "zone_service_tunnels_02", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_pa_room_02", "zone_service_tunnels_03", "connect_service_tunnels");
  zm_zonemgr::add_adjacent_zone("zone_board_room_01", "zone_bunker_entrance_01", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_board_room_01", "zone_bunker_entrance_02", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_board_room_01", "zone_bunker_entrance_03", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_board_room_01", "zone_board_room_02", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_board_room_01", "zone_service_tunnels_02", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_board_room_02", "zone_bunker_entrance_02", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_board_room_02", "zone_service_tunnels_02", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_board_room_02", "zone_service_tunnels_03", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_board_room_02", "zone_board_room_01", "connect_board_room");
  zm_zonemgr::add_adjacent_zone("zone_town_square_01", "zone_town_square_02", #"hash_2145c074d359b87d", 0);
  zm_zonemgr::add_adjacent_zone("zone_town_square_01", "zone_town_square_03", #"hash_2145c074d359b87d", 0);
  zm_zonemgr::add_adjacent_zone("zone_town_square_01", "zone_town_square_04", #"hash_2145c074d359b87d", 0);
  zm_zonemgr::add_adjacent_zone("zone_town_square_02", "zone_town_square_03", #"hash_2145c074d359b87d", 0);
  zm_zonemgr::add_adjacent_zone("zone_town_square_02", "zone_town_square_04", #"hash_2145c074d359b87d", 0);
  zm_zonemgr::add_adjacent_zone("zone_town_square_03", "zone_town_square_04", #"hash_2145c074d359b87d", 0);
  level clientfield::set("" + # "hash_2a35f1483d5f5467", 1);
  level clientfield::set("" + # "hash_deec7a5e441c482", 1);
  level thread function_49779a9c();
  level thread function_9dd333eb();
  level.ascendstarts = struct::get_array("zm_ascend_begin", "script_noteworthy");

  if(isDefined(level.ascendstarts)) {
    array::thread_all(level.ascendstarts, &function_8aecc4f0);
  }

  array::thread_all(struct::get_array("zipline_start_zm", "script_noteworthy"), &function_4fc2e560);
  array::thread_all(struct::get_array("zipline_power_gate"), &function_169ac2dd);
  namespace_f0b43eb5::create_challenge(#"hash_24ddbd878df00902", 90, "zone_video_store_roof", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_video_store_roof", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_39c9629b7028ed5d", 90, "zone_cinema", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_cinema", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_33b83c4a38a3bdca", 90, "zone_arcade", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_arcade", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_10eb3850b26d48c", 90, "zone_burger_town", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_burger_town", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_402b667a503d4ccb", 90, "zone_video_store", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_video_store", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_39e9787c0de0daf1", 90, "zone_anytown_usa_backlot", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_anytown_usa_backlot", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_453a742eed680932", 90, "zone_xxx_club_roof", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_xxx_club_roof", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  namespace_f0b43eb5::create_challenge(#"hash_30c036366e17895", 90, "zone_pizza_parlor", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_pizza_parlor", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  s_challenge = namespace_f0b43eb5::create_challenge(#"hash_2c457fb4d5c4a3b9", 90, "zone_dark_aether_lab_upper", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_dark_aether_lab_upper", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  s_challenge.var_4e0096cd = # "hash_19f7784bc90ba3c5";
  s_challenge = namespace_f0b43eb5::create_challenge(#"hash_6cda1bb2296c5334", 90, "zone_dark_aether_lab_lower", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_dark_aether_lab_lower", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  s_challenge.var_4e0096cd = # "hash_366946412ba7b470";
  namespace_f0b43eb5::create_challenge(#"hash_6f2d55d2d3f4d404", 90, "zone_video_store_2f", undefined, #"hash_374955e0c82d6aa4", "s_obj_challenge_zone_video_store_2f", &namespace_f0b43eb5::function_f51adffa, &namespace_f0b43eb5::function_9742c28f);
  var_f8f0b389 = struct::get("s_obj_challenge_zone_tv_repair");

  if(isDefined(var_f8f0b389.target)) {
    hidemiscmodels(var_f8f0b389.target);
    var_77cd2496 = getEntArray(var_f8f0b389.target, "targetname");
    array::run_all(var_77cd2496, &hide);
    array::run_all(var_77cd2496, &notsolid);
  }

  namespace_f0b43eb5::create_challenge(#"hash_7912ea609d3670e4", 90, "zone_concessions", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_concessions", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  var_f8f0b389 = struct::get("s_obj_challenge_zone_drinks_bar");

  if(isDefined(var_f8f0b389.target)) {
    hidemiscmodels(var_f8f0b389.target);
    var_77cd2496 = getEntArray(var_f8f0b389.target, "targetname");
    array::run_all(var_77cd2496, &hide);
    array::run_all(var_77cd2496, &notsolid);
  }

  namespace_f0b43eb5::create_challenge(#"hash_748d52da3b04b32", 90, "zone_anytown_usa_rooftops", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_anytown_usa_rooftops", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  namespace_f0b43eb5::create_challenge(#"hash_3359139601088551", 90, "zone_drinks_bar_roof", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_drinks_bar_roof", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  namespace_f0b43eb5::create_challenge(#"hash_14d4a43db0399d79", 90, "zone_high_tide_bar_roof", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_high_tide_bar_roof", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  namespace_f0b43eb5::create_challenge(#"hash_3f393a7be6cf192", 90, "zone_xxx_club", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_xxx_club", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  namespace_f0b43eb5::create_challenge(#"hash_5bf8e83a711797f4", 90, "zone_main_street_bridge", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_main_street_bridge", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
  var_f8f0b389 = struct::get("s_obj_challenge_zone_bunker_entrance_03");

  if(isDefined(var_f8f0b389.target)) {
    hidemiscmodels(var_f8f0b389.target);
    var_77cd2496 = getEntArray(var_f8f0b389.target, "targetname");
    array::run_all(var_77cd2496, &hide);
    array::run_all(var_77cd2496, &notsolid);
  }

  namespace_f0b43eb5::create_challenge(#"hash_580e3a81d3b46e59", 90, "zone_board_room_01", undefined, #"hash_5cee7e17aff44d7e", "s_obj_challenge_zone_board_room_01", &namespace_f0b43eb5::function_1d60215, &namespace_f0b43eb5::function_6be352fc);
}

function function_b9ad8870() {
  flag::wait_till("<dev string:x38>");

  while(true) {
    wait 2;
  }
}

function function_990a7f89() {
  zm_zonemgr::enable_zone("zone_main_street_backlot");
}

function function_4f804075() {
  zm_zonemgr::enable_zone("zone_anytown_usa_west");
  level flag::set("connect_anytown_usa_west_zones");
}

function function_5c0aa258() {
  zm_zonemgr::enable_zone("zone_bunker_entrance_01");
  level flag::set("connect_bunker_entrance_zones");
}

function function_904e469e() {
  zm_zonemgr::enable_zone("zone_observation");
  level flag::set(#"hash_79bb6bfeda6a5c");
}

function function_2d12df62() {
  zm_zonemgr::enable_zone("zone_town_square_01");
}

function function_5077fd82() {
  level endon(#"end_game");
  flag::wait_till_all(array("connect_pizza_parlor", "connect_diner"));
  flag::set("connect_xxx_club_to_high_tide_bar");
}

function function_e20c4fba() {
  level endon(#"end_game");
  flag::wait_till_all(array("connect_burger_town", "connect_drinks_bar"));
  flag::set("connect_burger_to_drinks");
}

function function_a7b4cb9e() {
  level endon(#"end_game");
  flag::wait_till_all(array("connect_burger_town", "connect_tv_repair"));
  flag::set("connect_burger_to_tv");
}

function function_2803d91d() {
  level endon(#"end_game");
  flag::wait_till_all(array("connect_burger_town", "connect_cinema"));
  flag::set("connect_burger_to_concessions");
}

function function_e41728ee() {
  level endon(#"end_game");
  flag::wait_till_all(array("connect_drinks_bar", "connect_tv_repair"));
  flag::set("connect_drinks_to_tv");
}

function function_da725fc1() {
  level endon(#"end_game");
  flag::wait_till_all(array("connect_drinks_bar", "connect_cinema"));
  flag::set("connect_drinks_to_concessions");
}

function function_68e1cb94() {
  level endon(#"end_game");
  flag::wait_till_all(array("connect_cinema", "connect_video_store"));
  flag::set("connect_cinema_to_video_arcade");
}

function function_158bd6c6() {
  level endon(#"end_game");
  flag::wait_till_all(array("connect_tv_repair", "connect_video_store"));
  flag::set("connect_tv_to_video_arcade");
}

function function_dde97037() {
  level endon(#"end_game");
  flag::wait_till_all(array("connect_tv_repair", "connect_cinema"));
  flag::set("connect_tv_to_cinema_concessions");
}

function function_44b1279a() {
  self notify("b16a9f8e903683d");
  self endon("b16a9f8e903683d");
  self endon(#"disconnect", #"death");
  self setupminimap("", "amerika");
  self clientfield::set_to_player("" + # "minimap_underground", 0);
  self clientfield::set_to_player("" + # "music_underscore", 4);
  self.var_9767e0af = 0;
  util::wait_network_frame();

  while(true) {
    if(!isPlayer(self)) {
      return;
    }

    if(!clientfield::function_ec6130f9("" + # "minimap_underground")) {
      waitframe(1);
      continue;
    }

    is_player_in_zone = self zm_zonemgr::is_player_in_zone(level.var_65c43c31, 0);
    minimap_underground = self clientfield::get_to_player("" + # "minimap_underground");

    if(is_player_in_zone && minimap_underground == 0) {
      self setupminimap("", "tunnel");
      self clientfield::set_to_player("" + # "minimap_underground", 1);
    } else if(!is_player_in_zone && minimap_underground == 1) {
      self setupminimap("", "amerika");
      self clientfield::set_to_player("" + # "minimap_underground", 0);
    }

    var_6444ee1f = self zm_zonemgr::is_player_in_zone(level.var_6eacc74a, 0);
    var_52764a82 = self zm_zonemgr::is_player_in_zone(level.var_359fd531, 0);
    var_710b2d6e = self clientfield::get_to_player("" + # "music_underscore");

    if(var_6444ee1f || var_52764a82) {
      if(var_6444ee1f && var_710b2d6e != 0) {
        self clientfield::set_to_player("" + # "music_underscore", 0);
      } else if(var_52764a82 && var_710b2d6e != 1) {
        self clientfield::set_to_player("" + # "music_underscore", 1);
      }
    } else if(var_710b2d6e != 4) {
      self clientfield::set_to_player("" + # "music_underscore", 4);
    }

    s_waitresult = self waittill(#"zone_change");
  }
}

function setupminimap(material, var_da0dddd2) {
  corners = territory::function_1f583d2e("minimap_corner", "targetname");
  var_32af51c9 = [];
  var_aa9f20e7 = [];

  foreach(corner in corners) {
    if(corner.script_noteworthy === "tunnel") {
      if(!isDefined(var_32af51c9)) {
        var_32af51c9 = [];
      } else if(!isarray(var_32af51c9)) {
        var_32af51c9 = array(var_32af51c9);
      }

      var_32af51c9[var_32af51c9.size] = corner;
      continue;
    }

    if(!isDefined(var_aa9f20e7)) {
      var_aa9f20e7 = [];
    } else if(!isarray(var_aa9f20e7)) {
      var_aa9f20e7 = array(var_aa9f20e7);
    }

    var_aa9f20e7[var_aa9f20e7.size] = corner;
  }

  assert(var_32af51c9.size == 2 && var_aa9f20e7.size == 2, "<dev string:x49>");

  if(var_da0dddd2 == "tunnel") {
    self compass::function_d6cba2e9(material, var_32af51c9[0].origin[0], var_32af51c9[0].origin[1], var_32af51c9[1].origin[0], var_32af51c9[1].origin[1]);
  }

  if(var_da0dddd2 == "amerika") {
    self compass::function_d6cba2e9(material, var_aa9f20e7[0].origin[0], var_aa9f20e7[0].origin[1], var_aa9f20e7[1].origin[0], var_aa9f20e7[1].origin[1]);
  }
}

function function_27028b8e(str_zone) {
  if(!isDefined(str_zone)) {
    return undefined;
  }

  if(isarray(str_zone)) {
    str_zone = str_zone[0];
  }

  switch (str_zone) {
    case # "zone_anytown_usa_backlot":
      str_display = # "hash_13d56fe3ab409e5";
      break;
    case # "zone_anytown_usa_east":
      str_display = # "hash_184b38d3bddc3620";
      break;
    case # "zone_drinks_bar_roof":
      str_display = # "hash_7cc77ccbc8b3f62a";
      break;
    case # "zone_anytown_usa_rooftops":
      str_display = # "hash_6dc19a704897a7a3";
      break;
    case # "zone_anytown_usa_west":
      str_display = # "hash_261ebc5ca63b1d5a";
      break;
    case # "zone_arcade":
      str_display = # "hash_4f1016f8fb60b23e";
      break;
    case # "zone_board_room_01":
      str_display = # "hash_54f3ecaca280008c";
      break;
    case # "zone_board_room_02":
      str_display = # "hash_b204e33898248cf";
      break;
    case # "zone_bunker_entrance_03":
    case # "zone_bunker_entrance_02":
    case # "zone_bunker_entrance_01":
      str_display = # "hash_47d4a8c4751828ea";
      break;
    case # "zone_burger_town":
      str_display = # "hash_5a9a6d8fdf9e5f58";
      break;
    case # "zone_cinema":
      str_display = # "hash_579d50ea19f0fe9";
      break;
    case # "zone_concessions":
      str_display = # "hash_5a38dd3025ad247f";
      break;
    case # "zone_diner":
      str_display = # "hash_3b6bb42366cfd4aa";
      break;
    case # "zone_drinks_bar":
      str_display = # "hash_547cca8e6424b8f3";
      break;
    case # "zone_helipads":
    case # "zone_helipads_portal_room":
    case # "zone_helipads_4":
    case # "zone_helipads_3":
    case # "zone_helipads_2":
      str_display = # "hash_3c025d87182e7e3c";
      break;
    case # "zone_high_tide_bar":
      str_display = # "hash_19e0e208ab46aaf5";
      break;
    case # "zone_main_street_02":
    case # "zone_main_street_01":
      str_display = # "hash_37cb3084f1ed10a7";
      break;
    case # "zone_main_street_backlot":
      str_display = # "hash_5b061064f7d4ef36";
      break;
    case # "zone_observation":
      str_display = # "hash_342e6dc1966544a8";
      break;
    case # "zone_pizza_parlor":
      str_display = # "hash_7ce2860b6f3b7061";
      break;
    case # "zone_service_tunnels_01":
    case # "zone_service_tunnels_02":
    case # "zone_service_tunnels_03":
      str_display = # "hash_72ac36585c1de4c1";
      break;
    case # "zone_town_square_01":
      str_display = # "hash_18ff37374dac36f4";
      break;
    case # "zone_tv_repair":
      str_display = # "hash_229d0feeecd8c374";
      break;
    case # "zone_video_store":
      str_display = # "hash_7115e7d86a5f7a57";
      break;
    case # "zone_xxx_club":
      str_display = # "hash_64e9623136c6d327";
      break;
    case # "zone_high_tide_bar_roof":
      str_display = # "hash_59a9723a6effa74c";
      break;
    case # "zone_main_street_bridge":
      str_display = # "hash_2789b3302c124ddd";
      break;
    case # "zone_video_store_roof":
      str_display = # "hash_22403c671894486";
      break;
    case # "zone_video_store_2f":
      str_display = # "hash_ac2ef2906462ba8";
      break;
    case # "zone_xxx_club_roof":
      str_display = # "hash_3399f0fdbae86fc9";
      break;
    default:
      str_display = undefined;
      break;
  }

  return str_display;
}

function function_9dd333eb() {
  var_47b7f8a9 = getnode("zone_main_street_bridge", "targetname");
  a_t_doors = getEntArray("zombie_door", "targetname");

  foreach(t_door in a_t_doors) {
    if(t_door.script_flag === "connect_pizza_parlor" || t_door.script_flag === "connect_diner") {
      if(distance2dsquared(t_door.origin, var_47b7f8a9.origin) <= sqr(350)) {
        t_door.var_4f96681c = "zone_main_street_bridge";
      }
    }
  }
}

function function_8aecc4f0() {
  if(isDefined(self.script_flag)) {
    level flag::wait_till(self.script_flag);
  }

  rappel::function_731b9325(self, 1);
}

function function_4fc2e560() {
  level flag::wait_till("power_on1");
  wait 1;
  zipline_player::function_2a1bd467(self);
}

function function_169ac2dd() {
  scene::add_scene_func(#"p9_fxanim_zm_platinum_zipline_bundle", &function_f63d1381, "init");
  self thread scene::init("p9_fxanim_zm_platinum_zipline_bundle");
  self.var_e1455171 = zm_utility::function_4a4cf79a(#"hash_255e6c8cbb3d4503", self.origin);
  level flag::wait_till("power_on1");
  scene::remove_scene_func(#"p9_fxanim_zm_platinum_zipline_bundle", &function_f63d1381, "init");
  scene::add_scene_func(#"p9_fxanim_zm_platinum_zipline_bundle", &function_88c5fdab, "play");
  self thread scene::play("p9_fxanim_zm_platinum_zipline_bundle");

  if(isDefined(self.var_e1455171)) {
    zm_utility::function_bc5a54a8(self.var_e1455171);
  }
}

function function_49779a9c() {
  scene::add_scene_func(#"p9_fxanim_zm_platinum_rappel_bundle", &function_8d8f7e79, "init");
  level thread scene::init("p9_fxanim_zm_platinum_rappel_bundle");
  level flag::wait_till("connect_backlot_to_mainstreet");
  t_door = getent("connect_backlot_to_mainstreet", "script_flag");
  t_door notify(#"hash_57b465b557811eb7");
  scene::remove_scene_func(#"p9_fxanim_zm_platinum_rappel_bundle", &function_8d8f7e79, "init");
  scene::add_scene_func(#"p9_fxanim_zm_platinum_rappel_bundle", &function_2a1cfabb, "play");
  level thread scene::play("p9_fxanim_zm_platinum_rappel_bundle");
}

function private function_8d8f7e79(a_ents) {
  e_door = a_ents[#"zipline_door"];
  e_door function_619a5c20();
  e_door.var_72910c52 = zm_utility::function_4a4cf79a(#"hash_1b7c3d825c8b5c1a", e_door.origin);
}

function private function_2a1cfabb(a_ents) {
  e_door = a_ents[#"zipline_door"];
  e_door function_23a29590();

  if(isDefined(e_door.var_72910c52)) {
    zm_utility::function_bc5a54a8(e_door.var_72910c52);
  }
}

function private function_f63d1381(a_ents) {
  e_door = a_ents[#"zipline_door"];
  e_door function_619a5c20();
}

function private function_88c5fdab(a_ents) {
  e_door = a_ents[#"zipline_door"];
  e_door function_23a29590();
}

function function_6e486b1(kstype) {
  var_74de2d96 = self zm_zonemgr::is_player_in_zone(level.var_65c43c31);
  var_74de2d96 |= self zm_zonemgr::is_player_in_zone("zone_observation");
  return var_74de2d96;
}