/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\siegebot.csc
***********************************************/

#using scripts\core_common\struct;
#using scripts\core_common\vehicle_shared;
#namespace siegebot;

function autoexec main() {
  vehicle::add_vehicletype_callback("siegebot", &_setup_);
}

function _setup_(localclientnum) {
  if(isDefined(self.scriptbundlesettings)) {
    settings = getscriptbundle(self.scriptbundlesettings);
  }

  if(!isDefined(settings)) {
    return;
  }
}