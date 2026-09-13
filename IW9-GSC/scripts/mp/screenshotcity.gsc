/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\screenshotcity.gsc
***********************************************/

move_to_blue_background() {
  _id_7BC1C35C0AB292C2 = getEnt("weapon_loc_screenshot_1", "targetname");
  weaponpos = _id_7BC1C35C0AB292C2.origin + (0, 0, 0);
  _id_9CBCD63169EBE6B9 = _id_7BC1C35C0AB292C2.angles + (0, 0, 0);
  level.pictureweapons.origin = weaponpos;
  level.pictureweapons.angles = _id_9CBCD63169EBE6B9;
  cameraent = getEnt("camera_weapon_screenshot_1", "targetname");
  camerapos = cameraent.origin + (100, 0, 0);
  _id_ABB06648E9DB3FFE = cameraent.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = camerapos;
  level.camera_anchor.angles = _id_ABB06648E9DB3FFE;
}

move_to_blue_background_side_on() {
  _id_7BC1C35C0AB292C2 = getEnt("weapon_loc_screenshot_1", "targetname");
  weaponpos = _id_7BC1C35C0AB292C2.origin + (0, 0, 0);
  _id_9CBCD63169EBE6B9 = _id_7BC1C35C0AB292C2.angles + (0, -25, 0);
  level.pictureweapons.origin = weaponpos;
  level.pictureweapons.angles = _id_9CBCD63169EBE6B9;
  cameraent = getEnt("camera_weapon_screenshot_1", "targetname");
  camerapos = cameraent.origin + (100, 0, 0);
  _id_ABB06648E9DB3FFE = cameraent.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = camerapos;
  level.camera_anchor.angles = _id_ABB06648E9DB3FFE;
}

move_to_grey_background() {
  _id_7BC1C35C0AB292C2 = getEnt("weapon_loc_screenshot_2", "targetname");
  weaponpos = _id_7BC1C35C0AB292C2.origin + (0, 0, 0);
  _id_9CBCD63169EBE6B9 = _id_7BC1C35C0AB292C2.angles + (0, 0, 0);
  level.pictureweapons.origin = weaponpos;
  level.pictureweapons.angles = _id_9CBCD63169EBE6B9;
  cameraent = getEnt("camera_weapon_screenshot_2", "targetname");
  camerapos = cameraent.origin + (100, 0, 0);
  _id_ABB06648E9DB3FFE = cameraent.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = camerapos;
  level.camera_anchor.angles = _id_ABB06648E9DB3FFE;
}

move_to_grey_background_side_on() {
  _id_7BC1C35C0AB292C2 = getEnt("weapon_loc_screenshot_2", "targetname");
  weaponpos = _id_7BC1C35C0AB292C2.origin + (0, 0, 0);
  _id_9CBCD63169EBE6B9 = _id_7BC1C35C0AB292C2.angles + (0, -25, 0);
  level.pictureweapons.origin = weaponpos;
  level.pictureweapons.angles = _id_9CBCD63169EBE6B9;
  cameraent = getEnt("camera_weapon_screenshot_2", "targetname");
  camerapos = cameraent.origin + (100, 0, 0);
  _id_ABB06648E9DB3FFE = cameraent.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = camerapos;
  level.camera_anchor.angles = _id_ABB06648E9DB3FFE;
}

take_screenshots(_id_FE4048AD22C35D73) {
  weaponname = tablelookup("mp/weaponScreenshotList.csv", 0, _id_FE4048AD22C35D73, 1);
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