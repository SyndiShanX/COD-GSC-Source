/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_filter.csc
**************************************/

init_filter_indices() {
  if(isDefined(level.genericfilterinitialized)) {
    return;
  }
  level.genericfilterinitialized = 1;
  level.filter_matcount = 5;
}

map_material_helper(player, materialname) {
  level.filter_matid[materialname] = level.filter_matcount;
  player map_material(level.filter_matcount, materialname);
  level.filter_matcount++;
}

init_filter_binoculars(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_binoculars");
}

enable_filter_binoculars(player, filterid, overlayid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_binoculars"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_binoculars(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_binoculars_with_outline(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_binoculars_with_outline");
}

enable_filter_binoculars_with_outline(player, filterid, overlayid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_binoculars_with_outline"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_binoculars_with_outline(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_frost(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_frost");
}

set_filter_frost_opacity(player, filterid, opacity) {
  player set_filter_pass_constant(filterid, 0, 0, opacity);
}

enable_filter_frost(player, filterid, opacity) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_frost"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_frost_opacity(player, filterid, opacity);
}

disable_filter_frost(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_hazmat(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_hazmat");
  map_material_helper(player, "generic_overlay_hazmat_1");
  map_material_helper(player, "generic_overlay_hazmat_2");
  map_material_helper(player, "generic_overlay_hazmat_3");
  map_material_helper(player, "generic_overlay_hazmat_4");
}

set_filter_hazmat_opacity(player, filterid, overlayid, opacity) {
  player set_filter_pass_constant(filterid, 0, 0, opacity);
  player set_overlay_constant(overlayid, 0, opacity);
}

enable_filter_hazmat(player, filterid, overlayid, stage, opacity) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_hazmat"]);
  player set_filter_pass_enabled(filterid, 0, 1);

  if(stage == 1)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_hazmat_1"], 1);
  else if(stage == 2)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_hazmat_2"], 1);
  else if(stage == 3)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_hazmat_3"], 1);
  else if(stage == 4)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_hazmat_4"], 1);

  player set_overlay_enabled(overlayid, 1);
  set_filter_hazmat_opacity(player, filterid, overlayid, opacity);
}

disable_filter_hazmat(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, 0);
  player set_overlay_enabled(overlayid, 0);
}

init_filter_helmet(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_helmet");
  map_material_helper(player, "generic_overlay_helmet");
}

enable_filter_helmet(player, filterid, overlayid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_helmet"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  player set_overlay_material(overlayid, level.filter_matid["generic_overlay_helmet"], 1);
  player set_overlay_enabled(overlayid, 1);
}

disable_filter_helmet(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, 0);
  player set_overlay_enabled(overlayid, 0);
}

init_filter_tacticalmask(player) {
  init_filter_indices();
  map_material_helper(player, "generic_overlay_tacticalmask");
}

enable_filter_tacticalmask(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_overlay_tacticalmask"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_tacticalmask(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_scope(player) {
  init_filter_indices();

  if(!isps3() || level.localplayers.size == 1)
    player map_material(0, "generic_filter_scope");
}

init_filter_infrared(player) {
  init_filter_indices();

  if(!isps3() || level.localplayers.size == 1)
    player map_material(1, "generic_filter_infrared");
}

init_filter_tvguided(player) {
  init_filter_indices();
  player map_material(2, "tow_filter_overlay_sp");
  player map_material(3, "tow_overlay");
}

init_filter_hud_outline_code(player) {
  init_filter_indices();
  player map_material(4, "generic_filter_hud_outline");
}

init_code_filters(player) {
  init_filter_scope(player);
  init_filter_infrared(player);
  init_filter_tvguided(player);
  init_filter_hud_outline_code(player);
}

init_filter_teargas(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_teargas");
}

set_filter_teargas_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_teargas(player, filterid, amount) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_teargas"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_teargas_amount(player, filterid, amount);
}

disable_filter_teargas(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_sonar(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_sonar_glass2");
}

set_filter_sonar_reveal_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
  player set_filter_pass_constant(filterid, 1, 0, amount);
}

enable_filter_sonar_glass(player, filterid, overlayid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_sonar_glass2"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_sonar_glass(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_hud_outline(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_hud_outline");
}

set_filter_hud_outline_reveal_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
  player set_filter_pass_constant(filterid, 1, 0, amount);
}

enable_filter_hud_outline(player, filterid, overlayid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_hud_outline"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_hud_outline(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_pakistan3_outline(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_pakistan3_outline");
}

set_filter_pakistan3_outline_reveal_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
  player set_filter_pass_constant(filterid, 1, 0, amount);
}

enable_filter_pakistan3_outline(player, filterid, overlayid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_pakistan3_outline"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_pakistan3_outline(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_sonar_attachment(player) {
  init_filter_indices();
  map_material_helper(player, "generic_overlay_sonar_attachment");
}

set_filter_sonar_attachment_params(player, filterid, pulse_duration, pulse_time) {
  player set_filter_pass_constant(filterid, 0, 10, pulse_duration);
  player set_filter_pass_constant(filterid, 0, 11, pulse_time);
}

enable_filter_sonar_attachment(player, filterid, overlayid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_overlay_sonar_attachment"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_sonar_attachment(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_hud_projected_grid(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_hud_projected_grid");
}

init_filter_hud_projected_grid_haiti(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_hud_projected_grid_haiti");
}

set_filter_hud_projected_grid_position(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

set_filter_hud_projected_grid_radius(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 1, amount);
}

enable_filter_hud_projected_grid(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_hud_projected_grid"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  player set_filter_hud_projected_grid_position(player, filterid, 500);
  player set_filter_hud_projected_grid_radius(player, filterid, 200);
}

enable_filter_hud_projected_grid_haiti(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_hud_projected_grid_haiti"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  player set_filter_hud_projected_grid_position(player, filterid, 500);
  player set_filter_hud_projected_grid_radius(player, filterid, 200);
}

disable_filter_hud_projected_grid(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_rts_hologram(player, materialname) {
  init_filter_indices();
  map_material_helper(player, materialname);
  map_material_helper(player, "generic_filter_rts_hologram_nosonar");
}

set_filter_rts_hologram_position(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

set_filter_rts_hologram_radius(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 1, amount);
}

enable_filter_rts_hologram(player, filterid, materialname) {
  player set_filter_pass_material(filterid, 0, level.filter_matid[materialname]);
  player set_filter_pass_enabled(filterid, 0, 1);
  player set_filter_rts_hologram_position(player, filterid, 500);
  player set_filter_rts_hologram_radius(player, filterid, 200);
  player set_filter_bit_flag(filterid, 0, 1);
}

disable_filter_rts_hologram(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, 0);
  player set_filter_bit_flag(filterid, 0, 0);
}

enable_filter_rts_hologram_no_sonar(player, filterid, materialname) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_rts_hologram_nosonar"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  player set_filter_rts_hologram_position(player, filterid, 500);
  player set_filter_rts_hologram_radius(player, filterid, 200);
  player set_filter_bit_flag(filterid, 0, 1);
}

disable_filter_rts_hologram_no_sonar(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, 0);
  player set_filter_bit_flag(filterid, 0, 0);
}

init_filter_rts_vehicle_damage(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_rts_vehicle_damage");
}

set_filter_rts_vehicle_damage_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_rts_vehicle_damage(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_rts_vehicle_damage"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_rts_vehicle_damage_amount(player, filterid, 0);
}

disable_filter_rts_vehicle_damage(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_satellite_transition(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_satellite_transition");
}

set_filter_satellite_transition_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_satellite_transition(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_satellite_transition"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_satellite_transition(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_f35_damage(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_f35_damage");
}

set_filter_f35_damage_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_f35_damage(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_f35_damage"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_f35_damage_amount(player, filterid, 0);
}

disable_filter_f35_damage(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_karma_spiderbot(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_karma_spiderbot");
}

enable_filter_karma_spiderbot(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_karma_spiderbot"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_karma_spiderbot(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_karma_lowlight(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_karma_lowlight");
}

enable_filter_karma_lowlight(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_karma_lowlight"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_karma_lowlight(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_vehicle_damage(player, materialname) {
  init_filter_indices();

  if(!isDefined(level.filter_matid[materialname]))
    map_material_helper(player, materialname);
}

set_filter_vehicle_damage_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

set_filter_vehicle_sun_position(player, filterid, x, y) {
  player set_filter_pass_constant(filterid, 0, 4, x);
  player set_filter_pass_constant(filterid, 0, 5, y);
}

enable_filter_vehicle_damage(player, filterid, materialname) {
  if(isDefined(level.filter_matid[materialname])) {
    player set_filter_pass_material(filterid, 0, level.filter_matid[materialname]);
    player set_filter_pass_enabled(filterid, 0, 1);
  }
}

disable_filter_vehicle_damage(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_emp(player, materialname) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_emp_damage");
}

set_filter_emp_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_emp(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_emp_damage"]);
  player set_filter_pass_enabled(filterid, 0, 1);
}

disable_filter_emp(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_raindrops(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_raindrops");
}

set_filter_raindrops_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_raindrops(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_raindrops"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  player set_filter_pass_quads(filterid, 0, 400);
  set_filter_raindrops_amount(player, filterid, 1.0);
}

disable_filter_raindrops(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_squirrel_raindrops(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_squirrel_raindrops");
}

set_filter_squirrel_raindrops_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_squirrel_raindrops(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_squirrel_raindrops"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  player set_filter_pass_quads(filterid, 0, 400);
  set_filter_squirrel_raindrops_amount(player, filterid, 1.0);
}

disable_filter_squirrel_raindrops(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_radialblur(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_radialblur");
}

set_filter_radialblur_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_radialblur(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_radialblur"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_radialblur_amount(player, filterid, 1.0);
}

disable_filter_radialblur(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_zodiac_raindrops(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_zodiac_raindrops");
}

set_filter_zodiac_raindrops_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_zodiac_raindrops(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_zodiac_raindrops"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  player set_filter_pass_quads(filterid, 0, 400);
  set_filter_zodiac_raindrops_amount(player, filterid, 1.0);
}

disable_filter_zodiac_raindrops(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_rage(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_rage");
}

init_filter_rage_simple(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_rage_simple");
}

set_filter_rage_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

set_filter_rage_ghost_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 1, amount);
}

set_filter_rage_ghost_scale(player, filterid, scalex, scaley) {
  player set_filter_pass_constant(filterid, 0, 8, scalex);
  player set_filter_pass_constant(filterid, 0, 9, scaley);
}

set_filter_rage_ghost_offset(player, filterid, offsetx, offsety) {
  player set_filter_pass_constant(filterid, 0, 10, offsetx);
  player set_filter_pass_constant(filterid, 0, 11, offsety);
}

set_filter_rage_ghost_image(player, filterid, image) {
  player set_filter_pass_constant(filterid, 0, 4, image);
}

set_filter_rage_shift_amount(player, filterid, image) {
  player set_filter_pass_constant(filterid, 0, 5, image);
}

set_filter_rage_warp_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 6, amount);
}

set_filter_rage_hit(player, filterid, opacity) {
  player set_filter_pass_constant(filterid, 0, 12, opacity);
}

enable_filter_rage(player, filterid, rage_amount) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_rage"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_rage_amount(player, filterid, rage_amount);
  set_filter_rage_ghost_scale(player, filterid, 1.9, 1);
  set_filter_rage_shift_amount(player, filterid, 0);
  set_filter_rage_warp_amount(player, filterid, 0);
}

enable_filter_rage_simple(player, filterid, rage_amount) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_rage_simple"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_rage_amount(player, filterid, rage_amount);
  set_filter_rage_ghost_scale(player, filterid, 1.9, 1);
}

disable_filter_rage(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

toggle_rage_filter(player, filterid, rage_amount, toggle) {
  if(toggle) {
    disable_filter_rage(player, filterid);
    init_filter_rage(player);
    enable_filter_rage(player, filterid, rage_amount);
  } else {
    disable_filter_rage(player, filterid);
    init_filter_rage_simple(player);
    enable_filter_rage_simple(player, filterid, rage_amount);
  }
}

init_filter_massiah(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_massiah");
}

set_filter_massiah_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_massiah(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_massiah"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_massiah_amount(player, filterid, 1.0);
}

disable_filter_massiah(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_oxygenmask(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_oxygenmask_warp");
  map_material_helper(player, "generic_filter_oxygenmask_condensation");
  map_material_helper(player, "generic_overlay_oxygenmask_1");
  map_material_helper(player, "generic_overlay_oxygenmask_2");
  map_material_helper(player, "generic_overlay_oxygenmask_3");
  map_material_helper(player, "generic_overlay_oxygenmask_4");
}

set_filter_oxygenmask_amount(player, filterid_warp, amount) {
  player set_filter_pass_constant(filterid_warp, 0, 0, amount);
}

set_filter_oxygenmask_smoke_amount(player, filterid_warp, amount) {
  player set_filter_pass_constant(filterid_warp, 0, 1, amount);
}

set_filter_oxygenmask_radialblur_amount(player, filterid_warp, amount) {
  player set_filter_pass_constant(filterid_warp, 0, 2, amount);
}

set_filter_oxygenmask_condensation_amount(player, filterid_condensation, amount) {
  player set_filter_pass_constant(filterid_condensation, 0, 0, amount);
}

set_filter_oxygenmask_crack_state(player, overlayid, stage) {
  if(stage == 1)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_oxygenmask_1"], 1);
  else if(stage == 2)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_oxygenmask_2"], 1);
  else if(stage == 3)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_oxygenmask_3"], 1);
  else if(stage == 4)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_oxygenmask_4"], 1);
}

enable_filter_oxygenmask(player, filterid_warp, filterid_condensation, overlayid, stage) {
  player set_filter_pass_material(filterid_warp, 0, level.filter_matid["generic_filter_oxygenmask_warp"]);
  player set_filter_pass_enabled(filterid_warp, 0, 1);
  player set_filter_pass_material(filterid_condensation, 0, level.filter_matid["generic_filter_oxygenmask_condensation"]);
  player set_filter_pass_enabled(filterid_condensation, 0, 1);
  player set_filter_pass_quads(filterid_condensation, 0, 400);

  if(stage == 1)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_oxygenmask_1"], 1);
  else if(stage == 2)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_oxygenmask_2"], 1);
  else if(stage == 3)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_oxygenmask_3"], 1);
  else if(stage == 4)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_oxygenmask_4"], 1);

  player set_overlay_enabled(overlayid, 1);
}

disable_filter_oxygenmask(player, filterid_warp, filterid_condensation, overlayid) {
  player set_filter_pass_enabled(filterid_warp, 0, 0);
  player set_filter_pass_enabled(filterid_condensation, 0, 0);
  player set_overlay_enabled(overlayid, 0);
}

init_filter_crackedglass_pakistan3(player) {
  init_filter_indices();
  map_material_helper(player, "generic_overlay_broken_glass_2");
  map_material_helper(player, "generic_overlay_broken_glass_3");
  map_material_helper(player, "generic_overlay_broken_glass_4");
}

set_filter_crackedglass_pakistan3_state(player, overlayid, stage) {
  if(stage == 0)
    player set_overlay_enabled(overlayid, 0);
  else if(stage == 1) {
    player set_overlay_enabled(overlayid, 1);
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_broken_glass_2"], 1);
  } else if(stage == 2) {
    player set_overlay_enabled(overlayid, 1);
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_broken_glass_3"], 1);
  } else {
    player set_overlay_enabled(overlayid, 1);
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_broken_glass_4"], 1);
  }
}

init_filter_custom_tow(player) {
  init_filter_indices();
  map_material_helper(player, "generic_overlay_custom_tow_noise");
  map_material_helper(player, "generic_overlay_custom_tow_crosshair");
}

set_filter_custom_tow_mode(player, mode) {
  player set_overlay_constant(1, 0, mode);
}

enable_filter_custom_tow(player) {
  player set_overlay_material(0, level.filter_matid["generic_overlay_custom_tow_noise"], 1);
  player set_overlay_material(1, level.filter_matid["generic_overlay_custom_tow_crosshair"], 1);
  player set_overlay_enabled(0, 1);
  player set_overlay_enabled(1, 1);
}

disable_filter_custom_tow(player, overlayid) {
  player set_overlay_enabled(0, 0);
  player set_overlay_enabled(1, 0);
}

init_filter_harper_blood(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_harper_blood");
}

set_filter_harper_blood_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_harper_blood(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_harper_blood"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_harper_blood_amount(player, filterid, 1.0);
}

disable_filter_harper_blood(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_claw_boot(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_boot_up");
}

set_filter_claw_boot_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_claw_boot(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_boot_up"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_claw_boot_amount(player, filterid, 1.0);
}

disable_filter_claw_boot(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_angola_gun_cam(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_angola_gun_cam");
}

set_filter_angola_gun_cam(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 10, amount);
}

enable_filter_angola_gun_cam(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_angola_gun_cam"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_angola_gun_cam(player, filterid, 1);
}

disable_filter_angola_gun_cam(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_blood_splats(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_blood_splats");
}

set_filter_blood_splats_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

set_filter_blood_splats_count(player, filterid, count) {
  player set_filter_pass_constant(filterid, 0, 1, count);
}

set_filter_blood_splats_coverage(player, filterid, coverage) {
  player set_filter_pass_constant(filterid, 0, 2, coverage);
}

set_filter_blood_splats_life(player, filterid, life) {
  player set_filter_pass_constant(filterid, 0, 3, life);
}

set_filter_blood_splats_sun(player, filterid, sunx, suny) {
  player set_filter_pass_constant(filterid, 0, 4, sunx);
  player set_filter_pass_constant(filterid, 0, 5, suny);
}

enable_filter_blood_splats(player, filterid, amount, count) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_blood_splats"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  player set_filter_pass_quads(filterid, 0, 60);
  set_filter_blood_splats_amount(player, filterid, amount);
  set_filter_blood_splats_count(player, filterid, count);
  set_filter_blood_splats_coverage(player, filterid, 1);
  set_filter_blood_splats_life(player, filterid, 1);
  set_filter_blood_splats_sun(player, filterid, 0, 0);
}

disable_filter_blood_splats(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_blood_droplets(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_blood_droplets");
}

set_filter_blood_droplets_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

set_filter_blood_droplets_count(player, filterid, count) {
  player set_filter_pass_constant(filterid, 0, 1, count);
}

set_filter_blood_droplets_coverage(player, filterid, coverage) {
  player set_filter_pass_constant(filterid, 0, 2, coverage);
}

set_filter_blood_droplets_life(player, filterid, life) {
  player set_filter_pass_constant(filterid, 0, 3, life);
}

set_filter_blood_droplets_sun(player, filterid, sunx, suny) {
  player set_filter_pass_constant(filterid, 0, 4, sunx);
  player set_filter_pass_constant(filterid, 0, 5, suny);
}

enable_filter_blood_droplets(player, filterid, amount, count) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_blood_droplets"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  player set_filter_pass_quads(filterid, 0, 400);
  set_filter_blood_droplets_amount(player, filterid, amount);
  set_filter_blood_droplets_count(player, filterid, count);
  set_filter_blood_droplets_coverage(player, filterid, 1);
  set_filter_blood_droplets_life(player, filterid, 1);
  set_filter_blood_droplets_sun(player, filterid, 0, 0);
}

disable_filter_blood_droplets(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}

init_filter_rage_hit(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_rage_hit");
}

set_filter_rage_hit_opacity(player, filterid, opacity) {
  player set_filter_pass_constant(filterid, 0, 4, opacity);
}

set_filter_rage_hit_tint_color(player, filterid, red, green, blue) {
  player set_filter_pass_constant(filterid, 0, 0, red);
  player set_filter_pass_constant(filterid, 0, 1, green);
  player set_filter_pass_constant(filterid, 0, 2, blue);
}

enable_filter_rage_hit(player, filterid, opacity, tintr, tintg, tintb) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_rage_hit"]);
  player set_filter_pass_enabled(filterid, 0, 1);
  set_filter_rage_hit_opacity(player, filterid, opacity);
}

disable_filter_rage_hit(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, 0);
}