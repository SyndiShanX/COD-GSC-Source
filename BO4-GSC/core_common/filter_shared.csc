/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\filter_shared.csc
***********************************************/

#include scripts\core_common\postfx_shared;
#include scripts\core_common\util_shared;

#namespace filter;

init_filter_indices() {
  util::function_89a98f85();
}

map_material_helper_by_localclientnum(localclientnum, materialname) {
  level.filter_matid[materialname] = mapmaterialindex(localclientnum, materialname);
}

map_material_if_undefined(localclientnum, materialname) {
  if(isDefined(mapped_material_id(materialname))) {
    return;
  }

  map_material_helper_by_localclientnum(localclientnum, materialname);
}

map_material_helper(player, materialname) {
  if(!isDefined(player)) {
    return;
  }

  map_material_helper_by_localclientnum(player.localclientnum, materialname);
}

mapped_material_id(materialname) {
  if(!isDefined(level.filter_matid)) {
    level.filter_matid = [];
  }

  return level.filter_matid[materialname];
}

function_74649ba9(player, filterid, pass, enable) {
  if(!isDefined(player)) {
    return;
  }

  util::function_89a98f85();

  if(isDefined(player) && isplayer(player) && isalive(player)) {
    num = player.localclientnum;
    setfilterpassenabled(num, filterid, pass, enable);
  }
}

function_83a54227(locaclientnum, filterid, pass, enable) {
  util::function_89a98f85();
  setfilterpassenabled(locaclientnum, filterid, pass, enable);
}

init_filter_vehicle_damage(player, materialname) {
  init_filter_indices();

  if(!isDefined(level.filter_matid[materialname])) {
    map_material_helper(player, materialname);
  }
}

set_filter_vehicle_damage_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

set_filter_vehicle_sun_position(player, filterid, x, y) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, x);
  setfilterpassconstant(player.localclientnum, filterid, 0, 5, y);
}

enable_filter_vehicle_damage(player, filterid, materialname) {
  if(isDefined(level.filter_matid[materialname])) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, level.filter_matid[materialname]);
    function_74649ba9(player, filterid, 0, 1);
  }
}

disable_filter_vehicle_damage(player, filterid) {
  util::function_89a98f85();
  function_74649ba9(player, filterid, 0, 0);
}

init_filter_oob(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_out_of_bounds");
}

enable_filter_oob(localclientnum, filterid) {
  setfilterpassmaterial(localclientnum, filterid, 0, mapped_material_id("generic_filter_out_of_bounds"));
  function_83a54227(localclientnum, filterid, 0, 1);
}

disable_filter_oob(localclientnum, filterid) {
  function_83a54227(localclientnum, filterid, 0, 0);
}

init_filter_tactical(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_tactical_damage");
}

enable_filter_tactical(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_tactical_damage"));
  function_74649ba9(player, filterid, 0, 1);
}

set_filter_tactical_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

disable_filter_tactical(player, filterid) {
  function_74649ba9(player, filterid, 0, 0);
}

init_filter_water_sheeting(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_water_sheeting");
}

enable_filter_water_sheeting(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_water_sheeting"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1, 0, 1);
}

set_filter_water_sheet_reveal(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

set_filter_water_sheet_speed(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

set_filter_water_sheet_rivulet_reveal(player, filterid, riv1, riv2, riv3) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, riv1);
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, riv2);
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, riv3);
}

disable_filter_water_sheeting(player, filterid) {
  function_74649ba9(player, filterid, 0, 0);
}

init_filter_water_dive(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_water_dive");
}

enable_filter_water_dive(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_water_dive"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1, 0, 1);
}

disable_filter_water_dive(player, filterid) {
  function_74649ba9(player, filterid, 0, 0);
}

set_filter_water_dive_bubbles(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

set_filter_water_scuba_bubbles(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

set_filter_water_scuba_dive_speed(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, amount);
}

set_filter_water_scuba_bubble_attitude(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, amount);
}

set_filter_water_wash_reveal_dir(player, filterid, dir) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, dir);
}

set_filter_water_wash_color(player, filterid, red, green, blue) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 5, red);
  setfilterpassconstant(player.localclientnum, filterid, 0, 6, green);
  setfilterpassconstant(player.localclientnum, filterid, 0, 7, blue);
}

settransported(player) {
  player thread postfx::playpostfxbundle(#"zm_teleporter");
}

init_filter_ev_interference(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_ev_interference");
}

enable_filter_ev_interference(player, filterid) {
  map_material_if_undefined(player.localclientnum, "generic_filter_ev_interference");
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_ev_interference"));
  function_74649ba9(player, filterid, 0, 1);
}

set_filter_ev_interference_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

disable_filter_ev_interference(player, filterid) {
  function_74649ba9(player, filterid, 0, 0);
}

init_filter_vehicle_hijack_oor(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_vehicle_out_of_range");
}

enable_filter_vehicle_hijack_oor(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_vehicle_out_of_range"));
  function_74649ba9(player, filterid, 0, 1);
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, 0);
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, 1);
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, 0);
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, -1);
}

set_filter_vehicle_hijack_oor_noblack(player, filterid) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, 1);
}

set_filter_vehicle_hijack_oor_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

disable_filter_vehicle_hijack_oor(player, filterid) {
  function_74649ba9(player, filterid, 0, 0);
}

init_filter_speed_burst(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_speed_burst");
}

enable_filter_speed_burst(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_speed_burst"));
  function_74649ba9(player, filterid, 0, 1);
}

set_filter_speed_burst(player, filterid, constantindex, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, constantindex, amount);
}

disable_filter_speed_burst(player, filterid) {
  function_74649ba9(player, filterid, 0, 0);
}

init_filter_sprite_transition(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_transition_sprite");
}

enable_filter_sprite_transition(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 1, mapped_material_id("generic_filter_transition_sprite"));
  function_74649ba9(player, filterid, 1, 1);
  setfilterpassquads(player.localclientnum, filterid, 1, 2048);
}

set_filter_sprite_transition_octogons(player, filterid, octos) {
  setfilterpassconstant(player.localclientnum, filterid, 1, 0, octos);
}

set_filter_sprite_transition_blur(player, filterid, blur) {
  setfilterpassconstant(player.localclientnum, filterid, 1, 1, blur);
}

set_filter_sprite_transition_boost(player, filterid, boost) {
  setfilterpassconstant(player.localclientnum, filterid, 1, 2, boost);
}

set_filter_sprite_transition_move_radii(player, filterid, inner, outter) {
  setfilterpassconstant(player.localclientnum, filterid, 1, 24, inner);
  setfilterpassconstant(player.localclientnum, filterid, 1, 25, outter);
}

set_filter_sprite_transition_elapsed(player, filterid, time) {
  setfilterpassconstant(player.localclientnum, filterid, 1, 28, time);
}

disable_filter_sprite_transition(player, filterid) {
  function_74649ba9(player, filterid, 1, 0);
}

init_filter_frame_transition(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_transition_frame");
}

enable_filter_frame_transition(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 2, mapped_material_id("generic_filter_transition_frame"));
  function_74649ba9(player, filterid, 2, 1);
}

set_filter_frame_transition_heavy_hexagons(player, filterid, hexes) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 0, hexes);
}

set_filter_frame_transition_light_hexagons(player, filterid, hexes) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 1, hexes);
}

set_filter_frame_transition_flare(player, filterid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 2, opacity);
}

set_filter_frame_transition_blur(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 3, amount);
}

set_filter_frame_transition_iris(player, filterid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 4, opacity);
}

set_filter_frame_transition_saved_frame_reveal(player, filterid, reveal) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 5, reveal);
}

set_filter_frame_transition_warp(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 6, amount);
}

disable_filter_frame_transition(player, filterid) {
  function_74649ba9(player, filterid, 2, 0);
}

init_filter_base_frame_transition(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_transition_frame_base");
}

enable_filter_base_frame_transition(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_transition_frame_base"));
  function_74649ba9(player, filterid, 0, 1);
}

set_filter_base_frame_transition_warp(player, filterid, warp) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, warp);
}

set_filter_base_frame_transition_boost(player, filterid, boost) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, boost);
}

set_filter_base_frame_transition_durden(player, filterid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, opacity);
}

set_filter_base_frame_transition_durden_blur(player, filterid, blur) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, blur);
}

disable_filter_base_frame_transition(player, filterid) {
  function_74649ba9(player, filterid, 0, 0);
}

function_9ff66ea3(localclientnum, filterid, passid, opacity) {
  setfilterpassconstant(localclientnum, filterid, passid, 0, opacity);
}

init_filter_sprite_rain(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_sprite_rain");
}

enable_filter_sprite_rain(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_sprite_rain"));
  function_74649ba9(player, filterid, 0, 1);
  setfilterpassquads(player.localclientnum, filterid, 0, 2048);
}

set_filter_sprite_rain_opacity(player, filterid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
}

set_filter_sprite_rain_seed_offset(player, filterid, offset) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 26, offset);
}

set_filter_sprite_rain_elapsed(player, filterid, time) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 28, time);
}

disable_filter_sprite_rain(player, filterid) {
  function_74649ba9(player, filterid, 0, 0);
}

init_filter_sprite_dirt(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_sprite_dirt");
}

enable_filter_sprite_dirt(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_sprite_dirt"));
  function_74649ba9(player, filterid, 0, 1);
  setfilterpassquads(player.localclientnum, filterid, 0, 400);
}

set_filter_sprite_dirt_opacity(player, filterid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
}

set_filter_sprite_dirt_source_position(player, filterid, right, up, distance) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, right);
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, up);
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, distance);
}

set_filter_sprite_dirt_sun_position(player, filterid, pitch, yaw) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, pitch);
  setfilterpassconstant(player.localclientnum, filterid, 0, 5, yaw);
}

set_filter_sprite_dirt_seed_offset(player, filterid, offset) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 26, offset);
}

set_filter_sprite_dirt_elapsed(player, filterid, time) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 28, time);
}

disable_filter_sprite_dirt(player, filterid) {
  function_74649ba9(player, filterid, 0, 0);
}

init_filter_drowning_damage(localclientnum) {
  init_filter_indices();
  map_material_helper_by_localclientnum(localclientnum, "generic_filter_drowning");
}

enable_filter_drowning_damage(localclientnum, passid) {
  setfilterpassmaterial(localclientnum, 5, passid, mapped_material_id("generic_filter_drowning"));
  setfilterpassenabled(localclientnum, 5, passid, 1, 0, 1);
}

set_filter_drowning_damage_opacity(localclientnum, passid, opacity) {
  setfilterpassconstant(localclientnum, 5, passid, 0, opacity);
}

set_filter_drowning_damage_inner_radius(localclientnum, passid, inner) {
  setfilterpassconstant(localclientnum, 5, passid, 1, inner);
}

set_filter_drowning_damage_outer_radius(localclientnum, passid, outer) {
  setfilterpassconstant(localclientnum, 5, passid, 2, outer);
}

disable_filter_drowning_damage(localclientnum, passid) {
  setfilterpassenabled(localclientnum, 5, passid, 0);
}