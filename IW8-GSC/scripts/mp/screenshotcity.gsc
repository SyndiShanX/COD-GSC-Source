/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\screenshotcity.gsc
***********************************************/

function move_to_blue_background() {
  var0 = getEnt("weapon_loc_screenshot_1", "targetname");
  var1 = var0.origin + (0, 0, 0);
  var2 = var0.angles + (0, 0, 0);
  level.pictureweapons.origin = var1;
  level.pictureweapons.angles = var2;
  var3 = getEnt("camera_weapon_screenshot_1", "targetname");
  var4 = var3.origin + (100, 0, 0);
  var5 = var3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var4;
  level.camera_anchor.angles = var5;
}

function move_to_blue_background_side_on() {
  var0 = getEnt("weapon_loc_screenshot_1", "targetname");
  var1 = var0.origin + (0, 0, 0);
  var2 = var0.angles + (0, -25, 0);
  level.pictureweapons.origin = var1;
  level.pictureweapons.angles = var2;
  var3 = getEnt("camera_weapon_screenshot_1", "targetname");
  var4 = var3.origin + (100, 0, 0);
  var5 = var3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var4;
  level.camera_anchor.angles = var5;
}

function move_to_grey_background() {
  var0 = getEnt("weapon_loc_screenshot_2", "targetname");
  var1 = var0.origin + (0, 0, 0);
  var2 = var0.angles + (0, 0, 0);
  level.pictureweapons.origin = var1;
  level.pictureweapons.angles = var2;
  var3 = getEnt("camera_weapon_screenshot_2", "targetname");
  var4 = var3.origin + (100, 0, 0);
  var5 = var3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var4;
  level.camera_anchor.angles = var5;
}

function move_to_grey_background_side_on() {
  var0 = getEnt("weapon_loc_screenshot_2", "targetname");
  var1 = var0.origin + (0, 0, 0);
  var2 = var0.angles + (0, -25, 0);
  level.pictureweapons.origin = var1;
  level.pictureweapons.angles = var2;
  var3 = getEnt("camera_weapon_screenshot_2", "targetname");
  var4 = var3.origin + (100, 0, 0);
  var5 = var3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var4;
  level.camera_anchor.angles = var5;
}

function take_screenshots(var0) {
  var1 = tablelookup("mp/weaponScreenshotList.csv", 0, var0, 1);
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