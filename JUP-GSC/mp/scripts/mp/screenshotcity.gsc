/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\screenshotcity.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\frontendutils;
#using scripts\engine\utility;
#namespace screenshotcity;

function move_to_blue_background() {
  weaponent = getEnt("weapon_loc_screenshot_1", "targetname");
  weaponpos = weaponent.origin + (0, 0, 0);
  weaponangles = weaponent.angles + (0, 0, 0);
  level.pictureweapons.origin = weaponpos;
  level.pictureweapons.angles = weaponangles;
  cameraent = getEnt("camera_weapon_screenshot_1", "targetname");
  camerapos = cameraent.origin + (100, 0, 0);
  cameraangles = cameraent.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = camerapos;
  level.camera_anchor.angles = cameraangles;
}

function move_to_blue_background_side_on() {
  weaponent = getEnt("weapon_loc_screenshot_1", "targetname");
  weaponpos = weaponent.origin + (0, 0, 0);
  weaponangles = weaponent.angles + (0, -25, 0);
  level.pictureweapons.origin = weaponpos;
  level.pictureweapons.angles = weaponangles;
  cameraent = getEnt("camera_weapon_screenshot_1", "targetname");
  camerapos = cameraent.origin + (100, 0, 0);
  cameraangles = cameraent.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = camerapos;
  level.camera_anchor.angles = cameraangles;
}

function move_to_grey_background() {
  weaponent = getEnt("weapon_loc_screenshot_2", "targetname");
  weaponpos = weaponent.origin + (0, 0, 0);
  weaponangles = weaponent.angles + (0, 0, 0);
  level.pictureweapons.origin = weaponpos;
  level.pictureweapons.angles = weaponangles;
  cameraent = getEnt("camera_weapon_screenshot_2", "targetname");
  camerapos = cameraent.origin + (100, 0, 0);
  cameraangles = cameraent.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = camerapos;
  level.camera_anchor.angles = cameraangles;
}

function move_to_grey_background_side_on() {
  weaponent = getEnt("weapon_loc_screenshot_2", "targetname");
  weaponpos = weaponent.origin + (0, 0, 0);
  weaponangles = weaponent.angles + (0, -25, 0);
  level.pictureweapons.origin = weaponpos;
  level.pictureweapons.angles = weaponangles;
  cameraent = getEnt("camera_weapon_screenshot_2", "targetname");
  camerapos = cameraent.origin + (100, 0, 0);
  cameraangles = cameraent.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = camerapos;
  level.camera_anchor.angles = cameraangles;
}

function take_screenshots(weaponindex) {
  println("<dev string:x1c>");
  weaponname = tablelookup("<dev string:x35>", 0, weaponindex, 1);
  move_to_blue_background();
  wait 2;
  adddebugcommand("<dev string:x54>" + "<dev string:x63>" + weaponname + "<dev string:x72>");
  wait 2;
  move_to_blue_background_side_on();
  wait 2;
  adddebugcommand("<dev string:x54>" + "<dev string:x63>" + weaponname + "<dev string:x7c>");
  wait 2;
  move_to_grey_background();
  wait 2;
  adddebugcommand("<dev string:x54>" + "<dev string:x63>" + weaponname + "<dev string:x8d>");
  wait 2;
  move_to_grey_background_side_on();
  wait 2;
  adddebugcommand("<dev string:x54>" + "<dev string:x63>" + weaponname + "<dev string:x97>");
  wait 2;
  println("<dev string:xa8>");
}

# /