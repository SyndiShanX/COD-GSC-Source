/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp\cp_ger_stakeout_fx.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\animation_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_utility;
#namespace cp_ger_stakeout_fx;

function private autoexec __init__system__() {
  system::register(#"cp_ger_stakeout_fx", &_preload, &function_fa076c68, undefined, undefined);
}

function private _preload() {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  function_bc948200();
}

function private function_fa076c68() {
  animation::add_notetrack_func("cp_ger_stakeout_fx::lerp_gas_on", &function_f14be656);
  animation::add_notetrack_func("cp_ger_stakeout_fx::lerp_gas_off", &function_77b211f6);
}

function private function_bc948200() {
  clientfield::register("actor", "umbrella_drips", 1, 2, "int", &umbrella_drips, 0, 0);
  clientfield::register("scriptmover", "police_headlights", 1, 1, "int", &police_headlights, 0, 0);
  clientfield::register("vehicle", "police_headlights", 1, 1, "int", &police_headlights, 0, 0);
  clientfield::register("scriptmover", "police_sirens", 1, 1, "int", &police_sirens, 0, 0);
  clientfield::register("vehicle", "police_sirens", 1, 1, "int", &police_sirens, 0, 0);
  clientfield::register("scriptmover", "clf_contact_cig_smoke", 1, 1, "int", &function_cc046f42, 0, 0);
}

function function_f14be656(parms) {
  self notify("19d555e485b55ae3");
  self endon("19d555e485b55ae3");
  self endon(#"death");
  progress = 0;
  increment = 1 / 187.5;

  while(progress < 1) {
    println("<dev string:x38>" + progress);
    function_be93487f(self.localclientnum, 3, 1, progress, 0, 0);
    progress += increment;
    progress = max(0, min(progress, 1));
    waitframe(1);
  }

  function_be93487f(self.localclientnum, 2, 0, 1, 0, 0);
  println("<dev string:x57>");
}

function function_77b211f6(parms) {
  self notify("38f081f584e691a2");
  self endon("38f081f584e691a2");
  self endon(#"death");
  progress = 1;
  decrement = 1 / 500;

  while(progress > 0) {
    println("<dev string:x7a>" + progress);
    function_be93487f(self.localclientnum, 3, 1, progress, 0, 0);
    progress -= decrement;
    progress = max(0, min(progress, 1));
    waitframe(1);
  }

  function_be93487f(self.localclientnum, 1, 1, 0, 0, 0);
  println("<dev string:x99>");
}

function private function_cc046f42(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    fxid = util::playFXOnTag(fieldname, "maps/cp_stakeout/fx9_cig_smoke_attached_loop_offset", self, "tag_origin");
    self thread function_67552e6a(fieldname, fxid);
    return;
  }

  self notify(#"hash_23cc6d8b29c98232");
}

function private function_67552e6a(localclientnum, fxid) {
  self waittill(#"death", #"hash_23cc6d8b29c98232");
  stopfx(localclientnum, fxid);
}

function umbrella_drips(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump === 1) {
    self.var_b2c18fb3 = util::playFXOnTag(fieldname, "maps/cp_stakeout/fx9_rain_drips_umbrella", self, "tag_accessory_left");
    self waittill(#"death");
  } else if(bwastimejump === 2) {
    self.var_b2c18fb3 = util::playFXOnTag(fieldname, "maps/cp_stakeout/fx9_rain_drips_umbrella", self, "tag_accessory_right");
    self waittill(#"death");
  } else {
    waitframe(1);
  }

  if(isDefined(self.var_b2c18fb3)) {
    stopfx(fieldname, self.var_b2c18fb3);
    self.var_b2c18fb3 = undefined;
  }
}

function police_headlights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.lights)) {
    self.lights = spawnStruct();
  }

  if(isDefined(self.lights.var_9e97f891)) {
    stopfx(fieldname, self.lights.var_9e97f891);
    self.lights.var_9e97f891 = undefined;
  }

  if(isDefined(self.lights.var_f1119d87)) {
    stopfx(fieldname, self.lights.var_f1119d87);
    self.lights.var_f1119d87 = undefined;
  }

  if(isDefined(self.lights.var_f5005d7f)) {
    stopfx(fieldname, self.lights.var_f5005d7f);
    self.lights.var_f5005d7f = undefined;
  }

  if(isDefined(self.lights.var_a3c2bacd)) {
    stopfx(fieldname, self.lights.var_a3c2bacd);
    self.lights.var_a3c2bacd = undefined;
  }

  if(bwastimejump === 1) {
    self.lights.var_9e97f891 = util::playFXOnTag(fieldname, "maps/cp_stakeout/fx9_headlight_yellow_car_l", self, "tag_fx_headlight_left");
    self.lights.var_f1119d87 = util::playFXOnTag(fieldname, "maps/cp_stakeout/fx9_headlight_yellow_car_r", self, "tag_fx_headlight_right");
    self.lights.var_f5005d7f = util::playFXOnTag(fieldname, "vehicle/fx9_taillight_civ_rus_gaz", self, "tag_fx_tail_light_left");
    self.lights.var_a3c2bacd = util::playFXOnTag(fieldname, "vehicle/fx9_taillight_civ_rus_gaz", self, "tag_fx_tail_light_right");
  }
}

function police_sirens(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.lights)) {
    self.lights = spawnStruct();
  }

  if(bwastimejump === 1) {
    if(isDefined(self.lights.var_765beb37)) {
      stopfx(fieldname, self.lights.var_765beb37);
      self.lights.var_765beb37 = undefined;
    }

    if(isDefined(self.lights.var_8ce0ffd)) {
      stopfx(fieldname, self.lights.var_8ce0ffd);
      self.lights.var_8ce0ffd = undefined;
    }

    self.lights.var_765beb37 = util::playFXOnTag(fieldname, "maps/cp_stakeout/fx9_police_light_blue_ccw_rnr", self, "tag_siren_glass_left_spinner_d0");
    self.lights.var_8ce0ffd = util::playFXOnTag(fieldname, "maps/cp_stakeout/fx9_police_light_blue_rnr", self, "tag_siren_glass_right_spinner_d0");
    return;
  }

  if(isDefined(self.lights.var_765beb37)) {
    stopfx(fieldname, self.lights.var_765beb37);
    self.lights.var_765beb37 = undefined;
  }

  if(isDefined(self.lights.var_8ce0ffd)) {
    stopfx(fieldname, self.lights.var_8ce0ffd);
    self.lights.var_8ce0ffd = undefined;
  }
}