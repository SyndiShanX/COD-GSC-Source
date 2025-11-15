/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_slamzoom.gsc
**************************************/

vehicle_spline_cam(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = 0.55;

  spline_cam_intro(var_1);
  var_4 = getvehiclenode(var_0, "targetname");
  var_5 = var_4 maps\_utility::get_last_ent_in_chain("vehiclenode");
  var_6 = spawnvehicle("tag_origin", "spline_cam_vehicle", "empty", var_4.origin, var_4.angles);
  var_6 attachpath(var_4);
  var_6 startpath();
  level.player playersetstreamorigin(var_5.origin);
  var_6 thread maps\_utility::play_sound_on_entity("scn_oilrocks_slamzoom");

  if(!isDefined(var_2))
    var_2 = 0.4;

  level.player playerlinktoblend(var_6, "tag_origin", var_2, 0, 0);
  var_6 waittill("reached_end_node");
  level.player playerclearstreamorigin();
  spline_cam_outro(var_1, var_3);
  var_6 delete();
}

spline_cam_intro(var_0) {
  if(!isDefined(var_0))
    var_0 = 0.55;

  level.player maps\_utility::vision_set_changes("cheat_bw", 0.1);
  thread digitalflash(0.1);
  setslowmotion(1, var_0, 0.4);
  level.player enableinvulnerability();
  stashloudout();
}

stashloudout() {
  var_0 = level.player getcurrentprimaryweapon();

  if(isDefined(var_0) && var_0 != "none")
    maps\_loadout_code::saveplayerweaponstatepersistent("oilrocks", 1);

  level.player takeallweapons();
}

spline_cam_outro(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0.55;

  level.player unlink();
  level.player common_scripts\utility::delaycall(1, ::disableinvulnerability);

  if(!maps\_loadout_code::restoreplayerweaponstatepersistent("oilrocks", 1, 1))
    maps\_loadout::give_loadout();

  if(isDefined(var_1) && var_1)
    thread digitalflash(0.35);

  setslowmotion(var_0, 1, 0.4);
  level.player maps\_utility::vision_set_changes("", 0.4);
}

digitalflash(var_0) {
  level.player digitaldistortsetparams(1, 1);
  wait(var_0);
  level.player digitaldistortsetparams(0, 1);
}

precache_zoom() {
  precachevehicle("empty");
}