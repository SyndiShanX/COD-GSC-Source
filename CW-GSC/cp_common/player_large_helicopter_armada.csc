/********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\player_large_helicopter_armada.csc
********************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\driving_fx;
#namespace player_large_helicopter_armada;

function private autoexec __init__system__() {
  system::register(#"player_large_helicopter_armada", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_vehicletype_callback("player_large_helicopter_armada", &function_38ae4287);
  clientfield::register("scriptmover", "armada_chopper_deathfx", 1, 1, "int", &field_do_deathfx, 0, 0);
}

function private function_38ae4287(localclientnum, data) {
  self.var_41860110 = &function_74272495;
  self.var_c6a9216 = &function_8411122e;
  self thread function_69fda304(data);
}

function private field_do_deathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self util::playFXOnTag(fieldname, "vehicle/fx8_vdest_heli_fuselage_destroyed", self, "tag_origin");
  }
}

function private function_b4806ee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = getscriptbundle(self.scriptbundlesettings);
  }

  if(isDefined(self.var_ec515b18)) {
    stopfx(fieldname, self.var_ec515b18);
    self.var_ec515b18 = undefined;
  }

  if(bwastimejump == 1) {
    if(isDefined(self.settings) && isDefined(self.settings.vehicle_turret)) {
      self.var_ec515b18 = self util::playFXOnTag(fieldname, self.settings.vehicle_turret, self, "tag_gunner_flash1");
    }
  }
}

function private function_8411122e(localclientnum, owner) {
  surfaces = [];

  if(isDefined(self.trace)) {
    if(self.trace[# "fraction"] != 1) {
      if(!isDefined(surfaces)) {
        surfaces = [];
      } else if(!isarray(surfaces)) {
        surfaces = array(surfaces);
      }

      if(!isinarray(surfaces, driving_fx::function_73e08cca(self.trace[# "surfacetype"]))) {
        surfaces[surfaces.size] = driving_fx::function_73e08cca(self.trace[# "surfacetype"]);
      }
    }
  }

  return surfaces;
}

function private function_74272495(localclientnum, owner) {
  return true;
}

function private function_69fda304(localclientnum) {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"enter_vehicle");

    if("right" == "right") {
      self function_4e9da3d7(1);
    }

    if(isDefined(waitresult.player)) {
      if(waitresult.player function_21c0fa55()) {
        waitresult.player thread function_732976d8(localclientnum, self);
        self thread function_ef93e0f5(waitresult.player);
      }
    }

    self thread function_5e7d8e1e();
    waitframe(1);
  }
}

function private function_5e7d8e1e() {
  self notify("5825fc11634841f0");
  self endon("5825fc11634841f0");
  self endon(#"death", #"disconnect", #"exit_vehicle");

  while(true) {
    waitframe(1);
  }
}

function private heli_exit(localclientnum) {
  self endon(#"death");
  self endon(#"disconnect");
  self waittill(#"exit_vehicle");
  self function_d1731820(localclientnum);
  self function_bada59a4();
}

function private function_ef93e0f5(player) {
  seatnum = self getoccupantseat(0, player);

  if(1 && isDefined(seatnum) && seatnum == 0) {
    self setanim(#"t9_arm_huey_ambient_delta_dummy");
    self setanim(#"t9_arm_huey_ambient_hover_additive");
    return;
  }

  if(0 && isDefined(seatnum) && seatnum != 0) {
    self setanim(#"t9_arm_huey_ambient_delta_dummy");
    self setanim(#"t9_arm_huey_ambient_hover_additive");
  }
}

function private function_bada59a4() {
  self clearanim(#"t9_arm_huey_ambient_delta_dummy", 0);
  self clearanim(#"t9_arm_huey_ambient_hover_additive", 0);
}

function private function_d1731820(localclientnum) {
  if(isDefined(self) && isDefined(self.var_a9757792)) {
    self stoprumble(localclientnum, self.var_a9757792);
    self.var_a9757792 = undefined;
  }
}

function private function_ff8d2820(localclientnum, rumble) {
  if(!isDefined(self)) {
    return;
  }

  if(self.var_a9757792 === rumble) {
    return;
  }

  if(isDefined(self.var_a9757792)) {
    self function_d1731820(localclientnum);
  }

  self.var_a9757792 = rumble;
  self playrumblelooponentity(localclientnum, self.var_a9757792);
}

function private function_732976d8(localclientnum, vehicle) {
  self notify("464688c098446c3e");
  self endon("464688c098446c3e");
  self endon(#"death");
  self endon(#"disconnect");
  var_26408b5d = sqr(210);
  offsetorigin = (0, 0, 210 * 2);

  while(true) {
    if(!isDefined(vehicle) || !isinvehicle(localclientnum, vehicle)) {
      break;
    }

    if(!vehicle isdrivingvehicle(self) && self function_21c0fa55()) {
      self function_d1731820(localclientnum);
      wait 1;
      continue;
    }

    trace = bulletTrace(vehicle.origin, vehicle.origin - offsetorigin, 0, vehicle, 1);
    distsqr = distancesquared(vehicle.origin, trace[# "position"]);

    if(trace[# "fraction"] == 1) {
      self function_d1731820(localclientnum);
      wait 1;
      continue;
    }

    if(distsqr > var_26408b5d) {
      self function_d1731820(localclientnum);
      wait 0.2;
      continue;
    }

    self function_ff8d2820(localclientnum, "fallwind_loop_slow");
    wait 0.2;
  }

  self function_d1731820(localclientnum);
}