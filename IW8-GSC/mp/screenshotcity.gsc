/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\screenshotcity.gsc
***********************************************/

move_to_blue_background() {
  var_0 = getEnt("_encstr_96EA18BB2B851CB79BEBC6F6C6D79BC62759AC37B91ADEE87D62", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, 0, 0);
  level.pictureweapons.origin = var_1;
  level.pictureweapons.angles = var_2;
  var_3 = getEnt("_encstr_A5C11BE1674D22DB8247DB23200AB07D17F6798A310DAD9A320840973E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_4;
  level.camera_anchor.angles = var_5;
}

move_to_blue_background_side_on() {
  var_0 = getEnt("_encstr_96EA18BB2B851CB79BEBC6F6C6D79BC62759AC37B91ADEE87D62", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, -25, 0);
  level.pictureweapons.origin = var_1;
  level.pictureweapons.angles = var_2;
  var_3 = getEnt("_encstr_A5C11BE1674D22DB8247DB23200AB07D17F6798A310DAD9A320840973E", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_4;
  level.camera_anchor.angles = var_5;
}

move_to_grey_background() {
  var_0 = getEnt("_encstr_AAEA18A04A46C1C8936F01882B2F33AFEAD2B8D083DC07637F2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, 0, 0);
  level.pictureweapons.origin = var_1;
  level.pictureweapons.angles = var_2;
  var_3 = getEnt("_encstr_9AC11B1B16DA9593C2F5DD2B2C077BE67D9B369C56ACE63734DED17D19", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_4;
  level.camera_anchor.angles = var_5;
}

move_to_grey_background_side_on() {
  var_0 = getEnt("_encstr_AAEA18A04A46C1C8936F01882B2F33AFEAD2B8D083DC07637F2A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = var_0.origin + (0, 0, 0);
  var_2 = var_0.angles + (0, -25, 0);
  level.pictureweapons.origin = var_1;
  level.pictureweapons.angles = var_2;
  var_3 = getEnt("_encstr_9AC11B1B16DA9593C2F5DD2B2C077BE67D9B369C56ACE63734DED17D19", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_4 = var_3.origin + (100, 0, 0);
  var_5 = var_3.angles + (0, 0, 0);
  level.camera_anchor dontinterpolate();
  level.camera_anchor.origin = var_4;
  level.camera_anchor.angles = var_5;
}

take_screenshots(var_0) {
  var_1 = tablelookup("_encstr_8A771C59F21E0749811BA8B88FDBE36BC21DCE538D03A9307B23AAD867E6", 0, var_0, 1);
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