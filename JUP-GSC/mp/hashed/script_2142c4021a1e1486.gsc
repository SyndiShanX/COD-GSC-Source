/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2142c4021a1e1486.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_3ab210ea917601e7;
#using script_3e31016b9c11a616;
#using script_41387eecc35b88bf;
#using script_4ef01fe6151dde4d;
#using script_4fdefae8b7bcdf73;
#using script_5753ba9c28794a65;
#using script_6df6604a74a7a9c7;
#using script_7956d56c4922bd1;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_c8a807248ca3f47d;

function function_31e28d0e057c0d07() {
  function_89384091f7a2dbd("REV_OB_SEISMIC_REFRACTOR", 0, &activity_setup);
  function_89384091f7a2dbd("REV_OB_SEISMIC_REFRACTOR", 1, &activity_begin);
  function_89384091f7a2dbd("REV_OB_SEISMIC_REFRACTOR", 2, &activity_ended);
  function_89384091f7a2dbd("REV_OB_SEISMIC_REFRACTOR", 3, &activity_destroy);
  function_89384091f7a2dbd("REV_OB_SEISMIC_REFRACTOR", 4, &function_6bb48579974ebf1e);
  function_89384091f7a2dbd("REV_OB_SEISMIC_REFRACTOR", 5, &function_81c481082c5b5b33);
  function_8b5b2a3392fc7e2a("PlayerJoin", &function_1531bbf5cff97dc0, "REV_OB_SEISMIC_REFRACTOR");
  function_8b5b2a3392fc7e2a("PlayerLeave", &function_5c651df8cfad0810, "REV_OB_SEISMIC_REFRACTOR");
}

function activity_setup() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  self.event_center = getStruct(self.varianttag, "targetname");
  self.var_d1ae8ddead6cd001 = getStruct(self.varianttag + "_RADIANT", "targetname");
  self.var_5e039caea04140ad = self.var_d1ae8ddead6cd001 function_50b5e4fcc500bb90("seismic_refractor_console", "targetname")[0];
  self.var_5e039caea04140ad setscriptablepartstate("model", "1");
  self.request_id = function_3ee36bc763779ba1(self.var_d1ae8ddead6cd001.target, 1, 1, 2, 2);
  function_84b829dec3e573eb(self.request_id, &function_e79f9faf8ebf2975, activity_instance);

  while(!(self.var_5e039caea04140ad getscriptablepartstate("model") == "active")) {
    waitframe();
  }

  function_b6fc2c96b463c007(activity_instance);
}

function activity_begin() {
  activity_instance = self;
  activity_instance endon("activity_ended");
  activity_instance endon("instance_destroyed");
  thread function_29e25c057d535749();
  wait 4;
  function_55caa7ecdad1659c(self.request_id);
}

function private function_29e25c057d535749() {
  var_85605e53426618ed = randomintrange(8, 12);
  var_2a4bffc6b2eef12d = 300;

  for(i = 0; i < var_85605e53426618ed; i++) {
    offset = function_6174330574a2a273() * var_2a4bffc6b2eef12d;

    while(!(self.var_5e039caea04140ad getscriptablepartstate("effects") == "pulse")) {
      waitframe();
    }

    wait 1;
  }

  endactivity(self, 0);
}

function private function_e79f9faf8ebf2975(requestid, userdata, zmb, data) {
  return true;
}

function activity_ended(activity_succeeded) {
  activity_instance = self;
  activity_instance endon("instance_destroyed");
}

function activity_destroy() {
  activity_instance = self;
  activity_instance endon("instance_destroyed");
  function_c0d31caee717b8eb();
}

function function_c0d31caee717b8eb() {
  self.var_5e039caea04140ad setscriptablepartstate("effects", "0");
  self.var_5e039caea04140ad setscriptablepartstate("model", "0");
}

function function_6bb48579974ebf1e() {
  return (0, 0, 0);
}

function function_81c481082c5b5b33() {
  var_cc7aa96a854fd8ee = spawnStruct();
  var_cc7aa96a854fd8ee.origin = self.var_d1ae8ddead6cd001.origin + (0, 50, 0);
  var_cc7aa96a854fd8ee.angles = (0, 0, 0);
  return var_cc7aa96a854fd8ee;
}

function function_1531bbf5cff97dc0(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
  var_a83ac3549acc2da2 = var_b381b0883bcd4847.playerjoinreason;
}

function function_5c651df8cfad0810(var_b381b0883bcd4847) {
  player_list = var_b381b0883bcd4847.playerlist;
}