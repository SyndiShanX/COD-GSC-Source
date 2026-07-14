/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_2834f5c740d999e1.gsc
*****************************************************/

#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_1bdf12582cbba8fd;

function private autoexec __init__system__() {
  system::register(#"hash_9018527773943c04", undefined, &function_2101cd7bc0ecd190, undefined);
}

function private function_2101cd7bc0ecd190() {
  utility::registersharedfunc(#"spatial_zone", #"getplayersinspatialzonesphere", &getplayersinspatialzonesphere);
  utility::registersharedfunc(#"spatial_zone", #"couldplayersbenearspatialzonesphere", &couldplayersbenearspatialzonesphere);
}

function getplayersinspatialzonesphere(sphereorigin, sphereradius, excludedplayers) {
  if(utility::playerwithindistance(level.player, sphereorigin, sphereradius)) {
    return [level.player];
  }

  return [];
}

function couldplayersbenearspatialzonesphere(sphereorigin, sphereradius) {
  return true;
}