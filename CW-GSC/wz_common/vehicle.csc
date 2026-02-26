/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\vehicle.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace wz_vehicle;

function private autoexec __init__system__() {
  system::register(#"wz_vehicle", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level._effect[#"plane_ambient"] = # "hash_3cb3a6fc9eb00337";
  level._effect[#"plane_ambient_high_alt"] = # "hash_3919b64dc762cab2";
  vehicle::function_2f97bc52("vehicle_t9_plane_flyable_prototype", &function_58e95b55);
  vehicle::function_cd2ede5("vehicle_t9_plane_flyable_prototype", &function_84f28fd9);
}

function function_58e95b55(localclientnum, vehicle) {
  if(!self function_21c0fa55()) {
    return;
  }

  vehicle thread function_c6d5a97d(localclientnum);

  if(!isDefined(vehicle.var_3a2e004d)) {
    vehicle.var_3a2e004d = [];
  }
}

function function_84f28fd9(localclientnum, vehicle) {
  if(!self function_21c0fa55()) {
    return;
  }

  vehicle thread function_c0119d33(localclientnum);
}

function function_7a5dc47e(localclientnum, height, fx) {
  self endon(#"death", #"hash_2a08d043fde0f8b1");

  while(true) {
    if(self.origin[2] < height) {
      self function_bc80c148(localclientnum, fx);
      self thread function_b57d31e4(localclientnum, height, fx);
      return;
    }

    wait 1;
  }
}

function function_b57d31e4(localclientnum, height, fx) {
  self endon(#"death", #"hash_2a08d043fde0f8b1");

  while(true) {
    if(isDefined(self.var_3a2e004d[fx])) {
      return;
    }

    if(self.origin[2] > height + 100) {
      self.var_3a2e004d[fx] = util::playFXOnTag(localclientnum, level._effect[fx], self, "tag_origin");
      self thread function_7a5dc47e(localclientnum, 3000, fx);
      return;
    }

    wait 1;
  }
}

function function_c6d5a97d(localclientnum) {
  function_b57d31e4(localclientnum, 3000, "plane_ambient");
  function_b57d31e4(localclientnum, 20000, "plane_ambient_high_alt");
}

function function_bc80c148(localclientnum, fx) {
  if(isDefined(self.var_3a2e004d[fx])) {
    stopfx(localclientnum, self.var_3a2e004d[fx]);
    self.var_3a2e004d[fx] = undefined;
  }
}

function function_c0119d33(localclientnum) {
  self notify(#"hash_2a08d043fde0f8b1");
  function_bc80c148(localclientnum, "plane_ambient");
  function_bc80c148(localclientnum, "plane_ambient_high_alt");
}