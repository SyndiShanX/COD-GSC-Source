/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\filter_shared.csc
*************************************************/

#using scripts\shared\postfx_shared;
#namespace filter;

function init_filter_indices() {}

function map_material_helper_by_localclientnum(localclientnum, materialname) {
  level.filter_matid[materialname] = mapmaterialindex(localclientnum, materialname);
}

function map_material_if_undefined(localclientnum, materialname) {
  if(isDefined(mapped_material_id(materialname))) {
    return;
  }
  map_material_helper_by_localclientnum(localclientnum, materialname);
}

function map_material_helper(player, materialname) {
  map_material_helper_by_localclientnum(player.localclientnum, materialname);
}

function mapped_material_id(materialname) {
  if(!isDefined(level.filter_matid)) {
    level.filter_matid = [];
  }
  return level.filter_matid[materialname];
}

function init_filter_binoculars(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_binoculars");
}

function enable_filter_binoculars(player, filterid, overlayid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_binoculars"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function disable_filter_binoculars(player, filterid, overlayid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_binoculars_with_outline(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_binoculars_with_outline");
}

function enable_filter_binoculars_with_outline(player, filterid, overlayid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_binoculars_with_outline"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function disable_filter_binoculars_with_outline(player, filterid, overlayid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_hazmat(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_hazmat");
  map_material_helper(player, "generic_overlay_hazmat_1");
  map_material_helper(player, "generic_overlay_hazmat_2");
  map_material_helper(player, "generic_overlay_hazmat_3");
  map_material_helper(player, "generic_overlay_hazmat_4");
}

function set_filter_hazmat_opacity(player, filterid, overlayid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
  setoverlayconstant(player.localclientnum, overlayid, 0, opacity);
}

function enable_filter_hazmat(player, filterid, overlayid, stage, opacity) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_hazmat"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  if(stage == 1) {
    setoverlaymaterial(player.localclientnum, overlayid, mapped_material_id("generic_overlay_hazmat_1"), 1);
  } else {
    if(stage == 2) {
      setoverlaymaterial(player.localclientnum, overlayid, mapped_material_id("generic_overlay_hazmat_2"), 1);
    } else {
      if(stage == 3) {
        setoverlaymaterial(player.localclientnum, overlayid, mapped_material_id("generic_overlay_hazmat_3"), 1);
      } else if(stage == 4) {
        setoverlaymaterial(player.localclientnum, overlayid, mapped_material_id("generic_overlay_hazmat_4"), 1);
      }
    }
  }
  setoverlayenabled(player.localclientnum, overlayid, 1);
  set_filter_hazmat_opacity(player, filterid, overlayid, opacity);
}

function disable_filter_hazmat(player, filterid, overlayid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
  setoverlayenabled(player.localclientnum, overlayid, 0);
}

function init_filter_helmet(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_helmet");
  map_material_helper(player, "generic_overlay_helmet");
}

function enable_filter_helmet(player, filterid, overlayid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_helmet"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  setoverlaymaterial(player.localclientnum, overlayid, mapped_material_id("generic_overlay_helmet"), 1);
  setoverlayenabled(player.localclientnum, overlayid, 1);
}

function disable_filter_helmet(player, filterid, overlayid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
  setoverlayenabled(player.localclientnum, overlayid, 0);
}

function init_filter_tacticalmask(player) {
  init_filter_indices();
  map_material_helper(player, "generic_overlay_tacticalmask");
}

function enable_filter_tacticalmask(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_overlay_tacticalmask"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function disable_filter_tacticalmask(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_hud_projected_grid(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_hud_projected_grid");
}

function init_filter_hud_projected_grid_haiti(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_hud_projected_grid_haiti");
}

function set_filter_hud_projected_grid_position(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function set_filter_hud_projected_grid_radius(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

function enable_filter_hud_projected_grid(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_hud_projected_grid"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  player set_filter_hud_projected_grid_position(player, filterid, 500);
  player set_filter_hud_projected_grid_radius(player, filterid, 200);
}

function enable_filter_hud_projected_grid_haiti(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_hud_projected_grid_haiti"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  player set_filter_hud_projected_grid_position(player, filterid, 500);
  player set_filter_hud_projected_grid_radius(player, filterid, 200);
}

function disable_filter_hud_projected_grid(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_emp(player, materialname) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_emp_damage");
}

function set_filter_emp_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function enable_filter_emp(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_emp_damage"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function disable_filter_emp(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_raindrops(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_raindrops");
}

function set_filter_raindrops_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function enable_filter_raindrops(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_raindrops"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  setfilterpassquads(player.localclientnum, filterid, 0, 400);
  set_filter_raindrops_amount(player, filterid, 1);
}

function disable_filter_raindrops(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_squirrel_raindrops(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_squirrel_raindrops");
}

function set_filter_squirrel_raindrops_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function enable_filter_squirrel_raindrops(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_squirrel_raindrops"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  setfilterpassquads(player.localclientnum, filterid, 0, 400);
  set_filter_squirrel_raindrops_amount(player, filterid, 1);
}

function disable_filter_squirrel_raindrops(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_radialblur(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_radialblur");
}

function set_filter_radialblur_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function enable_filter_radialblur(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_radialblur"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  set_filter_radialblur_amount(player, filterid, 1);
}

function disable_filter_radialblur(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_vehicle_damage(player, materialname) {
  init_filter_indices();
  if(!isDefined(level.filter_matid[materialname])) {
    map_material_helper(player, materialname);
  }
}

function set_filter_vehicle_damage_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function set_filter_vehicle_sun_position(player, filterid, x, y) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, x);
  setfilterpassconstant(player.localclientnum, filterid, 0, 5, y);
}

function enable_filter_vehicle_damage(player, filterid, materialname) {
  if(isDefined(level.filter_matid[materialname])) {
    setfilterpassmaterial(player.localclientnum, filterid, 0, level.filter_matid[materialname]);
    setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  }
}

function disable_filter_vehicle_damage(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_oob(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_out_of_bounds");
}

function enable_filter_oob(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_out_of_bounds"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function disable_filter_oob(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_tactical(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_tactical_damage");
}

function enable_filter_tactical(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_tactical_damage"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function set_filter_tactical_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function disable_filter_tactical(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_water_sheeting(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_water_sheeting");
}

function enable_filter_water_sheeting(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_water_sheeting"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1, 0, 1);
}

function set_filter_water_sheet_reveal(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function set_filter_water_sheet_speed(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

function set_filter_water_sheet_rivulet_reveal(player, filterid, riv1, riv2, riv3) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, riv1);
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, riv2);
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, riv3);
}

function disable_filter_water_sheeting(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_water_dive(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_water_dive");
}

function enable_filter_water_dive(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_water_dive"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1, 0, 1);
}

function disable_filter_water_dive(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function set_filter_water_dive_bubbles(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function set_filter_water_scuba_bubbles(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

function set_filter_water_scuba_dive_speed(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, amount);
}

function set_filter_water_scuba_bubble_attitude(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, amount);
}

function set_filter_water_wash_reveal_dir(player, filterid, dir) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, dir);
}

function set_filter_water_wash_color(player, filterid, red, green, blue) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 5, red);
  setfilterpassconstant(player.localclientnum, filterid, 0, 6, green);
  setfilterpassconstant(player.localclientnum, filterid, 0, 7, blue);
}

function init_filter_teleportation(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_teleportation");
}

function enable_filter_teleportation(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_teleportation"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function set_filter_teleportation_anus_zoom(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function set_filter_teleportation_anus_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 6, amount);
}

function set_filter_teleportation_panther_zoom(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

function set_filter_teleportation_panther_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 7, amount);
}

function set_filter_teleportation_glow_radius(player, filterid, radius) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, radius);
}

function set_filter_teleportation_warp_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, amount);
}

function set_filter_teleportation_warp_direction(player, filterid, direction) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, direction);
}

function set_filter_teleportation_lightning_reveal(player, filterid, threshold) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 5, threshold);
}

function set_filter_teleportation_faces_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 8, amount);
}

function set_filter_teleportation_space_background(player, filterid, set) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 9, set);
}

function set_filter_teleportation_sparkle_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 10, amount);
}

function disable_filter_teleportation(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function settransported(player) {
  player thread postfx::playpostfxbundle("zm_teleporter");
}

function init_filter_ev_interference(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_ev_interference");
}

function enable_filter_ev_interference(player, filterid) {
  map_material_if_undefined(player.localclientnum, "generic_filter_ev_interference");
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_ev_interference"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function set_filter_ev_interference_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function disable_filter_ev_interference(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_vehiclehijack(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_vehicle_takeover");
  return mapped_material_id("generic_filter_vehicle_takeover");
}

function enable_filter_vehiclehijack(player, filterid, overlayid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_vehicle_takeover"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function disable_filter_vehiclehijack(player, filterid, overlayid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function set_filter_ev_vehiclehijack_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function init_filter_vehicle_hijack_oor(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_vehicle_out_of_range");
}

function enable_filter_vehicle_hijack_oor(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_vehicle_out_of_range"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, 0);
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, 1);
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, 0);
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, -1);
}

function set_filter_vehicle_hijack_oor_noblack(player, filterid) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, 1);
}

function set_filter_vehicle_hijack_oor_amount(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

function disable_filter_vehicle_hijack_oor(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_speed_burst(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_speed_burst");
}

function enable_filter_speed_burst(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_speed_burst"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function set_filter_speed_burst(player, filterid, constantindex, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, constantindex, amount);
}

function disable_filter_speed_burst(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_overdrive(player) {
  init_filter_indices();
  if(sessionmodeiscampaigngame()) {
    map_material_helper(player, "generic_filter_overdrive_cp");
  }
}

function enable_filter_overdrive(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_overdrive_cp"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function set_filter_overdrive(player, filterid, constantindex, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, constantindex, amount);
}

function disable_filter_overdrive(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_frost(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_frost");
}

function enable_filter_frost(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_frost"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function set_filter_frost_layer_one(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, amount);
}

function set_filter_frost_layer_two(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, amount);
}

function set_filter_frost_reveal_direction(player, filterid, direction) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, direction);
}

function disable_filter_frost(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_vision_pulse(localclientnum) {
  init_filter_indices();
  map_material_helper_by_localclientnum(localclientnum, "generic_filter_vision_pulse");
}

function enable_filter_vision_pulse(localclientnum, filterid) {
  map_material_if_undefined(localclientnum, "generic_filter_vision_pulse");
  setfilterpassmaterial(localclientnum, filterid, 0, mapped_material_id("generic_filter_vision_pulse"));
  setfilterpassenabled(localclientnum, filterid, 0, 1);
}

function set_filter_vision_pulse_constant(localclientnum, filterid, constid, value) {
  setfilterpassconstant(localclientnum, filterid, 0, constid, value);
}

function disable_filter_vision_pulse(localclientnum, filterid) {
  setfilterpassenabled(localclientnum, filterid, 0, 0);
}

function init_filter_sprite_transition(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_transition_sprite");
}

function enable_filter_sprite_transition(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 1, mapped_material_id("generic_filter_transition_sprite"));
  setfilterpassenabled(player.localclientnum, filterid, 1, 1);
  setfilterpassquads(player.localclientnum, filterid, 1, 2048);
}

function set_filter_sprite_transition_octogons(player, filterid, octos) {
  setfilterpassconstant(player.localclientnum, filterid, 1, 0, octos);
}

function set_filter_sprite_transition_blur(player, filterid, blur) {
  setfilterpassconstant(player.localclientnum, filterid, 1, 1, blur);
}

function set_filter_sprite_transition_boost(player, filterid, boost) {
  setfilterpassconstant(player.localclientnum, filterid, 1, 2, boost);
}

function set_filter_sprite_transition_move_radii(player, filterid, inner, outter) {
  setfilterpassconstant(player.localclientnum, filterid, 1, 24, inner);
  setfilterpassconstant(player.localclientnum, filterid, 1, 25, outter);
}

function set_filter_sprite_transition_elapsed(player, filterid, time) {
  setfilterpassconstant(player.localclientnum, filterid, 1, 28, time);
}

function disable_filter_sprite_transition(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 1, 0);
}

function init_filter_frame_transition(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_transition_frame");
}

function enable_filter_frame_transition(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 2, mapped_material_id("generic_filter_transition_frame"));
  setfilterpassenabled(player.localclientnum, filterid, 2, 1);
}

function set_filter_frame_transition_heavy_hexagons(player, filterid, hexes) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 0, hexes);
}

function set_filter_frame_transition_light_hexagons(player, filterid, hexes) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 1, hexes);
}

function set_filter_frame_transition_flare(player, filterid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 2, opacity);
}

function set_filter_frame_transition_blur(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 3, amount);
}

function set_filter_frame_transition_iris(player, filterid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 4, opacity);
}

function set_filter_frame_transition_saved_frame_reveal(player, filterid, reveal) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 5, reveal);
}

function set_filter_frame_transition_warp(player, filterid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, 2, 6, amount);
}

function disable_filter_frame_transition(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 2, 0);
}

function init_filter_base_frame_transition(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_transition_frame_base");
}

function enable_filter_base_frame_transition(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_transition_frame_base"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function set_filter_base_frame_transition_warp(player, filterid, warp) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, warp);
}

function set_filter_base_frame_transition_boost(player, filterid, boost) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, boost);
}

function set_filter_base_frame_transition_durden(player, filterid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, opacity);
}

function set_filter_base_frame_transition_durden_blur(player, filterid, blur) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, blur);
}

function disable_filter_base_frame_transition(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_sprite_blood(localclientnum, digitalblood) {
  if(digitalblood) {
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_sprite_blood_damage_reaper");
  } else {
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_sprite_blood_damage");
  }
}

function enable_filter_sprite_blood(localclientnum, filterid, passid, digitalblood) {
  if(digitalblood) {
    setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_sprite_blood_damage_reaper"));
  } else {
    setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_sprite_blood_damage"));
  }
  setfilterpassenabled(localclientnum, filterid, passid, 1);
  setfilterpassquads(localclientnum, filterid, passid, 400);
}

function init_filter_sprite_blood_heavy(localclientnum, digitalblood) {
  if(digitalblood) {
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_sprite_blood_heavy_damage_reaper");
  } else {
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_sprite_blood_heavy_damage");
  }
}

function enable_filter_sprite_blood_heavy(localclientnum, filterid, passid, digitalblood) {
  if(digitalblood) {
    setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_sprite_blood_heavy_damage_reaper"));
  } else {
    setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_sprite_blood_heavy_damage"));
  }
  setfilterpassenabled(localclientnum, filterid, passid, 1);
  setfilterpassquads(localclientnum, filterid, passid, 400);
}

function set_filter_sprite_blood_opacity(localclientnum, filterid, passid, opacity) {
  setfilterpassconstant(localclientnum, filterid, passid, 0, opacity);
}

function set_filter_sprite_blood_seed_offset(localclientnum, filterid, passid, offset) {
  setfilterpassconstant(localclientnum, filterid, passid, 26, offset);
}

function set_filter_sprite_blood_elapsed(localclientnum, filterid, passid, time) {
  setfilterpassconstant(localclientnum, filterid, passid, 28, time);
}

function disable_filter_sprite_blood(localclientnum, filterid, passid) {
  setfilterpassenabled(localclientnum, filterid, passid, 0);
}

function init_filter_feedback_blood(localclientnum, digitalblood) {
  init_filter_indices();
  if(digitalblood) {
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_blood_damage_reaper");
  } else {
    map_material_helper_by_localclientnum(localclientnum, "generic_filter_blood_damage");
  }
}

function enable_filter_feedback_blood(localclientnum, filterid, passid, digitalblood) {
  if(digitalblood) {
    setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_blood_damage_reaper"));
  } else {
    setfilterpassmaterial(localclientnum, filterid, passid, mapped_material_id("generic_filter_blood_damage"));
  }
  setfilterpassenabled(localclientnum, filterid, passid, 1);
}

function set_filter_feedback_blood_opacity(localclientnum, filterid, passid, opacity) {
  setfilterpassconstant(localclientnum, filterid, passid, 0, opacity);
}

function set_filter_feedback_blood_sundir(localclientnum, filterid, passid, pitch, yaw) {
  setfilterpassconstant(localclientnum, filterid, passid, 1, pitch);
  setfilterpassconstant(localclientnum, filterid, passid, 2, yaw);
}

function set_filter_feedback_blood_vignette(localclientnum, filterid, passid, amount) {
  setfilterpassconstant(localclientnum, filterid, passid, 3, amount);
}

function set_filter_feedback_blood_drowning(localclientnum, filterid, passid, tintamount, allowtint) {
  setfilterpassconstant(localclientnum, filterid, passid, 4, tintamount);
  setfilterpassconstant(localclientnum, filterid, passid, 5, allowtint);
}

function disable_filter_feedback_blood(localclientnum, filterid, passid) {
  setfilterpassenabled(localclientnum, filterid, passid, 0);
}

function init_filter_sprite_rain(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_sprite_rain");
}

function enable_filter_sprite_rain(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_sprite_rain"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  setfilterpassquads(player.localclientnum, filterid, 0, 2048);
}

function set_filter_sprite_rain_opacity(player, filterid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
}

function set_filter_sprite_rain_seed_offset(player, filterid, offset) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 26, offset);
}

function set_filter_sprite_rain_elapsed(player, filterid, time) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 28, time);
}

function disable_filter_sprite_rain(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_sgen_sprite_rain(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_blkstn_sprite_rain");
}

function enable_filter_sgen_sprite_rain(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_blkstn_sprite_rain"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  setfilterpassquads(player.localclientnum, filterid, 0, 2048);
}

function init_filter_sprite_dirt(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_sprite_dirt");
}

function enable_filter_sprite_dirt(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_sprite_dirt"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
  setfilterpassquads(player.localclientnum, filterid, 0, 400);
}

function set_filter_sprite_dirt_opacity(player, filterid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, opacity);
}

function set_filter_sprite_dirt_source_position(player, filterid, right, up, distance) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, right);
  setfilterpassconstant(player.localclientnum, filterid, 0, 2, up);
  setfilterpassconstant(player.localclientnum, filterid, 0, 3, distance);
}

function set_filter_sprite_dirt_sun_position(player, filterid, pitch, yaw) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 4, pitch);
  setfilterpassconstant(player.localclientnum, filterid, 0, 5, yaw);
}

function set_filter_sprite_dirt_seed_offset(player, filterid, offset) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 26, offset);
}

function set_filter_sprite_dirt_elapsed(player, filterid, time) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 28, time);
}

function disable_filter_sprite_dirt(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_blood_spatter(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_blood_spatter");
}

function enable_filter_blood_spatter(player, filterid) {
  setfilterpassmaterial(player.localclientnum, filterid, 0, mapped_material_id("generic_filter_blood_spatter"));
  setfilterpassenabled(player.localclientnum, filterid, 0, 1);
}

function set_filter_blood_spatter_reveal(player, filterid, threshold, direction) {
  setfilterpassconstant(player.localclientnum, filterid, 0, 0, threshold);
  setfilterpassconstant(player.localclientnum, filterid, 0, 1, direction);
}

function disable_filter_blood_spatter(player, filterid) {
  setfilterpassenabled(player.localclientnum, filterid, 0, 0);
}

function init_filter_teleporter_base(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_zm_teleporter_base");
}

function enable_filter_teleporter_base(player, filterid, passid) {
  setfilterpassmaterial(player.localclientnum, filterid, passid, mapped_material_id("generic_filter_zm_teleporter_base"));
  setfilterpassenabled(player.localclientnum, filterid, passid, 1);
}

function set_filter_teleporter_base_amount(player, filterid, passid, amount) {
  setfilterpassconstant(player.localclientnum, filterid, passid, 0, amount);
}

function disable_filter_teleporter_base(player, filterid, passid) {
  setfilterpassenabled(player.localclientnum, filterid, passid, 0);
}

function init_filter_teleporter_sprite(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_zm_teleporter_sprite");
}

function enable_filter_teleporter_sprite(player, filterid, passid) {
  setfilterpassmaterial(player.localclientnum, filterid, passid, mapped_material_id("generic_filter_zm_teleporter_sprite"));
  setfilterpassenabled(player.localclientnum, filterid, passid, 1);
  setfilterpassquads(player.localclientnum, filterid, passid, 400);
}

function set_filter_teleporter_sprite_opacity(player, filterid, passid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, passid, 0, opacity);
}

function set_filter_teleporter_sprite_seed_offset(player, filterid, passid, offset) {
  setfilterpassconstant(player.localclientnum, filterid, passid, 26, offset);
}

function set_filter_teleporter_sprite_elapsed(player, filterid, passid, time) {
  setfilterpassconstant(player.localclientnum, filterid, passid, 28, time);
}

function disable_filter_teleporter_sprite(player, filterid, passid) {
  setfilterpassenabled(player.localclientnum, filterid, passid, 0);
}

function init_filter_teleporter_top(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_zm_teleporter_base");
}

function enable_filter_teleporter_top(player, filterid, passid) {
  setfilterpassmaterial(player.localclientnum, filterid, passid, mapped_material_id("generic_filter_zm_teleporter_base"));
  setfilterpassenabled(player.localclientnum, filterid, passid, 1);
}

function set_filter_teleporter_top_reveal(player, filterid, passid, threshold, direction) {
  setfilterpassconstant(player.localclientnum, filterid, passid, 0, threshold);
  setfilterpassconstant(player.localclientnum, filterid, passid, 1, direction);
}

function disable_filter_teleporter_top(player, filterid, passid) {
  setfilterpassenabled(player.localclientnum, filterid, passid, 0);
}

function init_filter_keyline_blend(player) {
  init_filter_indices();
  map_material_helper(player, "postfx_keyline_blend");
}

function enable_filter_keyline_blend(player, filterid, passid) {
  setfilterpassmaterial(player.localclientnum, filterid, passid, mapped_material_id("postfx_keyline_blend"));
  setfilterpassenabled(player.localclientnum, filterid, passid, 1);
}

function set_filter_keyline_blend_opacity(player, filterid, passid, opacity) {
  setfilterpassconstant(player.localclientnum, filterid, passid, 0, opacity);
}

function disable_filter_keyline_blend(player, filterid, passid) {
  setfilterpassenabled(player.localclientnum, filterid, passid, 0);
}

function init_filter_drowning_damage(localclientnum) {
  init_filter_indices();
  map_material_helper_by_localclientnum(localclientnum, "generic_filter_drowning");
}

function enable_filter_drowning_damage(localclientnum, passid) {
  setfilterpassmaterial(localclientnum, 5, passid, mapped_material_id("generic_filter_drowning"));
  setfilterpassenabled(localclientnum, 5, passid, 1, 0, 1);
}

function set_filter_drowning_damage_opacity(localclientnum, passid, opacity) {
  setfilterpassconstant(localclientnum, 5, passid, 0, opacity);
}

function set_filter_drowning_damage_inner_radius(localclientnum, passid, inner) {
  setfilterpassconstant(localclientnum, 5, passid, 1, inner);
}

function set_filter_drowning_damage_outer_radius(localclientnum, passid, outer) {
  setfilterpassconstant(localclientnum, 5, passid, 2, outer);
}

function disable_filter_drowning_damage(localclientnum, passid) {
  setfilterpassenabled(localclientnum, 5, passid, 0);
}