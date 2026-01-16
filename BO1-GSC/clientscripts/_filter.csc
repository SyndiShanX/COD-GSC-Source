/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_filter.csc
**************************************/

init_filter_indices() {
  if(isDefined(level.genericfilterinitialized))
    return;
  level.genericfilterinitialized = true;
  level.filter_matcount = 4;
  level.targetid_none = 0;
  level.targerid_small0 = 1;
  level.targerid_small1 = 2;
  level.targerid_scene = 3;
  level.targerid_postsun = 4;
  level.targerid_smallblur = 5;
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
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_binoculars"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
}

disable_filter_binoculars(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, false);
}

init_filter_warp_sr71(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_warp_sr71");
}

set_filter_warp_sr71_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_warp_sr71(player, filterid, amount) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_warp_sr71"], level.targerid_scene, level.targerid_smallblur, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  set_filter_warp_sr71_amount(player, filterid, amount);
}

disable_filter_warp_sr71(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, false);
}

init_filter_frost(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_frost");
}

set_filter_frost_opacity(player, filterid, opacity) {
  player set_filter_pass_constant(filterid, 0, 0, opacity);
}

enable_filter_frost(player, filterid, opacity) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_frost"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  set_filter_frost_opacity(player, filterid, opacity);
}

disable_filter_frost(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, false);
}

init_filter_pentagon_fullscreen(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_pentagon_fullscreen");
}

set_filter_pentagon_fullscreen_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_pentagon_fullscreen(player, filterid, amount) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_pentagon_fullscreen"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  set_filter_pentagon_fullscreen_amount(player, filterid, amount);
}

disable_filter_pentagon_fullscreen(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, false);
}

init_filter_pentagon_blowout(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_pentagon_blowout");
}

set_filter_pentagon_blowout_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_pentagon_blowout(player, filterid, amount) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_pentagon_blowout"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  set_filter_pentagon_blowout_amount(player, filterid, amount);
}

disable_filter_pentagon_blowout(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, false);
}

init_filter_pentagon_bulgeblur(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_pentagon_bulgeblur");
}

set_filter_pentagon_bulgeblur_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_pentagon_bulgeblur(player, filterid, amount) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_pentagon_bulgeblur"], level.targerid_scene, level.targerid_smallblur, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  set_filter_pentagon_bulgeblur_amount(player, filterid, amount);
}

disable_filter_pentagon_bulgeblur(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, false);
}

init_filter_pentagon_multicam1(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_pentagon_multicam1");
}

set_filter_pentagon_multicam1_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

set_filter_pentagon_multicam1_bink1(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 1, amount);
}

set_filter_pentagon_multicam1_bink2(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 2, amount);
}

enable_filter_pentagon_multicam1(player, filterid, amount) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_pentagon_multicam1"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  set_filter_pentagon_multicam1_amount(player, filterid, amount);
}

disable_filter_pentagon_multicam1(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, false);
}

init_filter_pentagon_multicam2(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_pentagon_multicam2");
}

set_filter_pentagon_multicam2_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

set_filter_pentagon_multicam2_bink1(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 1, amount);
}

set_filter_pentagon_multicam2_bink2(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 2, amount);
}

enable_filter_pentagon_multicam2(player, filterid, amount) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_pentagon_multicam2"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  set_filter_pentagon_multicam2_amount(player, filterid, amount);
}

disable_filter_pentagon_multicam2(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, false);
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
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_hazmat"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  if(stage == 1)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_hazmat_1"], 1);
  else if(stage == 2)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_hazmat_2"], 1);
  else if(stage == 3)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_hazmat_3"], 1);
  else if(stage == 4)
    player set_overlay_material(overlayid, level.filter_matid["generic_overlay_hazmat_4"], 1);
  player set_overlay_enabled(overlayid, true);
  set_filter_hazmat_opacity(player, filterid, overlayid, opacity);
}

disable_filter_hazmat(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, false);
  player set_overlay_enabled(overlayid, false);
}

init_filter_helmet(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_helmet");
  map_material_helper(player, "generic_overlay_helmet");
}

enable_filter_helmet(player, filterid, overlayid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_helmet"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  player set_overlay_material(overlayid, level.filter_matid["generic_overlay_helmet"], 1);
  player set_overlay_enabled(overlayid, true);
}

disable_filter_helmet(player, filterid, overlayid) {
  player set_filter_pass_enabled(filterid, 0, false);
  player set_overlay_enabled(overlayid, false);
}

init_filter_tacticalmask(player) {
  init_filter_indices();
  map_material_helper(player, "generic_overlay_tacticalmask");
}

enable_filter_tacticalmask(player, filterid) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_overlay_tacticalmask"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
}

disable_filter_tacticalmask(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, false);
}

init_filter_superflare(player, materialname) {
  init_filter_indices();
  map_material_helper(player, materialname);
}

set_filter_superflare_position(player, filterid, passid, x, y, z) {
  player set_filter_pass_constant(filterid, passid, 0, x);
  player set_filter_pass_constant(filterid, passid, 1, y);
  player set_filter_pass_constant(filterid, passid, 2, z);
}

set_filter_superflare_intensity(player, filterid, passid, intensity) {
  player set_filter_pass_constant(filterid, passid, 4, intensity);
}

set_filter_superflare_radius(player, filterid, passid, radius) {
  player set_filter_pass_constant(filterid, passid, 5, radius);
}

enable_filter_superflare(player, materialname, filterid, passid, quads, x, y, z, intensity, radius) {
  player set_filter_pass_material(filterid, passid, level.filter_matid[materialname], level.targerid_small0, level.targetid_none, level.targetid_none);
  player set_filter_pass_quads(filterid, passid, quads);
  player set_filter_pass_enabled(filterid, passid, true);
  set_filter_superflare_intensity(player, filterid, passid, intensity);
  set_filter_superflare_radius(player, filterid, passid, radius);
  set_filter_superflare_position(player, filterid, passid, x, y, z);
}

disable_filter_superflare(player, materialname, filterid, passid) {
  player set_filter_pass_enabled(filterid, passid, false);
}

init_filter_lensflare(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_lensflare_cutoff");
  map_material_helper(player, "generic_filter_lensflare_flip");
  map_material_helper(player, "generic_filter_lensflare_apply");
}

set_filter_lensflare_cutoff(player, filterid, cutoff) {
  player set_filter_pass_constant(filterid, 0, 0, cutoff);
}

set_filter_lensflare_intensity(player, filterid, intensity) {
  player set_filter_pass_constant(filterid, 0, 1, intensity);
}

set_filter_lensflare_brightness(player, filterid, brightness) {
  player set_filter_pass_constant(filterid, 1, 0, brightness);
}

enable_filter_lensflare(player, filterid, cutoff, intensity, brightness) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_lensflare_cutoff"], level.targerid_small0, level.targerid_smallblur, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  player set_filter_pass_material(filterid, 1, level.filter_matid["generic_filter_lensflare_flip"], level.targerid_small0, level.targerid_small0, level.targetid_none);
  player set_filter_pass_enabled(filterid, 1, true);
  player set_filter_pass_material(filterid, 2, level.filter_matid["generic_filter_lensflare_apply"], level.targerid_scene, level.targerid_small0, level.targetid_none);
  player set_filter_pass_enabled(filterid, 2, true);
  set_filter_lensflare_cutoff(player, filterid, cutoff);
  set_filter_lensflare_intensity(player, filterid, intensity);
  set_filter_lensflare_brightness(player, filterid, brightness);
}

disable_filter_lensflare(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, false);
  player set_filter_pass_enabled(filterid, 1, false);
  player set_filter_pass_enabled(filterid, 2, false);
}

init_filter_scope(player) {
  init_filter_indices();
  if(!isps3() || getLocalPlayers().size == 1)
    player map_material(0, "generic_filter_scope");
}

init_filter_infrared(player) {
  init_filter_indices();
  if(!isps3() || getLocalPlayers().size == 1)
    player map_material(1, "generic_filter_infrared");
}

init_filter_tvguided(player) {
  init_filter_indices();
  player map_material(2, "tow_filter_overlay");
  player map_material(3, "tow_overlay");
}

init_filter_teargas(player) {
  init_filter_indices();
  map_material_helper(player, "generic_filter_teargas");
}

set_filter_teargas_amount(player, filterid, amount) {
  player set_filter_pass_constant(filterid, 0, 0, amount);
}

enable_filter_teargas(player, filterid, amount) {
  player set_filter_pass_material(filterid, 0, level.filter_matid["generic_filter_teargas"], level.targerid_scene, level.targerid_scene, level.targetid_none);
  player set_filter_pass_enabled(filterid, 0, true);
  set_filter_teargas_amount(player, filterid, amount);
}

disable_filter_teargas(player, filterid) {
  player set_filter_pass_enabled(filterid, 0, false);
}