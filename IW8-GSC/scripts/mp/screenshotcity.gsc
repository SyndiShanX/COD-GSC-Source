/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\screenshotcity.gsc
***********************************************/

function move_to_blue_background() {
  var_0 = getEnt("weapon_loc_screenshot_1", "targetname");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, 0, 0);
  level.pictureweapons.origin = var_1;
  level.pictureweapons.angles = var_2;
  var_3 = getEnt("camera_weapon_screenshot_1", "targetname");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_4;
  level.camera_anchor.angles = var_5;
}

function move_to_blue_background_side_on() {
  var_0 = getEnt("weapon_loc_screenshot_1", "targetname");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, -25, 0);
  level.pictureweapons.origin = var_1;
  level.pictureweapons.angles = var_2;
  var_3 = getEnt("camera_weapon_screenshot_1", "targetname");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_4;
  level.camera_anchor.angles = var_5;
}

function move_to_grey_background() {
  var_0 = getEnt("weapon_loc_screenshot_2", "targetname");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, 0, 0);
  level.pictureweapons.origin = var_1;
  level.pictureweapons.angles = var_2;
  var_3 = getEnt("camera_weapon_screenshot_2", "targetname");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_4;
  level.camera_anchor.angles = var_5;
}

function move_to_grey_background_side_on() {
  var_0 = getEnt("weapon_loc_screenshot_2", "targetname");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, -25, 0);
  level.pictureweapons.origin = var_1;
  level.pictureweapons.angles = var_2;
  var_3 = getEnt("camera_weapon_screenshot_2", "targetname");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_4;
  level.camera_anchor.angles = var_5;
}

function take_screenshots(var_0) {
  var_1 = tablelookup("mp/weaponScreenshotList.csv", 0, var_0, 1);
  move_to_blue_background();
  wait 2;
  wait 2;
  move_to_blue_background_side_on();
  wait 2;
  wait 2;
  move_to_grey_background();
  wait 2;
  wait 2;
  move_to_grey_background_side_on();
  wait 2;
  wait 2;
}