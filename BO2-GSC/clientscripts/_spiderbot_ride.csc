/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_spiderbot_ride.csc
*********************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\_driving_fx;

init() {
  clientscripts\_driving_fx::add_vehicletype_callback("spiderbot_large", ::drive_spiderbot);
}

drive_spiderbot(localclientnum) {
  self endon("entityshutdown");

  while(true) {
    self waittill("enter_vehicle", player);
    init_filter_karma_spiderbot(player);
    enable_filter_karma_spiderbot(player, 0);
    setsaveddvar("r_stereo3DEyeSeparationScaler", 0.01);

    if(isDefined(level._audio_spiderbot_override))
      self thread[[level._audio_spiderbot_override]](player);

    self waittill("exit_vehicle");
    disable_filter_karma_spiderbot(player, 0);
    setsaveddvar("r_stereo3DEyeSeparationScaler", 1);
  }
}