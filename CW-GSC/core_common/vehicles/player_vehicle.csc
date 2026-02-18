/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_vehicle.csc
***************************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace player_vehicle;

function private autoexec __init__system__() {
  system::register(#"player_vehicle", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_vehicle_spawned(&on_vehicle_spawned);
  clientfield::register("vehicle", "overheat_fx", 1, 1, "int", &function_ed50d3e0, 0, 0);
  clientfield::register("vehicle", "overheat_fx1", 1, 1, "int", &function_b7f86930, 0, 0);
  clientfield::register("vehicle", "overheat_fx2", 1, 1, "int", &function_4b2a0f55, 0, 0);
  clientfield::register("vehicle", "overheat_fx3", 1, 1, "int", &function_a2943e68, 0, 0);
  clientfield::register("vehicle", "overheat_fx4", 1, 1, "int", &function_a64f45de, 0, 0);
  clientfield::register("toplayer", "toggle_vehicle_sensor", 1, 1, "int", &function_12d038ac, 0, 0);
  callback::on_localplayer_spawned(&on_localplayer_spawned);
}

function private on_vehicle_spawned(localclientnum) {
  if(!is_true(self.isplayervehicle)) {
    return;
  }

  self function_4edde887(localclientnum);
}

function private function_4edde887(localclientnum) {
  if(self function_b835102b() && !(self.vehicleclass === "boat") && !(self.vehicleclass === "helicopter") && !(self.vehicleclass === "plane")) {
    self function_3f24c5a(1);
  }

  self.stunnedcallback = &stunnedcallback;
  self function_1f0c7136(3);
}

function private on_localplayer_spawned(localclientnum) {
  if(self function_21c0fa55()) {
    self.var_53204996 = &function_3ec2efae;
  }
}

function private function_12d038ac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(isDefined(self.var_e29b96d2)) {
      self.var_e29b96d2 delete();
    }

    self thread function_54e9d3c4(fieldname);
    return;
  }

  if(isDefined(self.var_e29b96d2)) {
    self.var_e29b96d2 delete();
  }
}

function private function_54e9d3c4(localclientnum) {
  self notify("a0febefad645c24");
  self endon("a0febefad645c24");
  self endon(#"death");
  self endon(#"exit_vehicle");
  vehicle = undefined;

  while(true) {
    vehicle = getplayervehicle(self);

    if(isDefined(vehicle)) {
      break;
    }

    waitframe(1);
  }

  driver = vehicle.owner;

  if(!isDefined(driver) || !isPlayer(driver)) {
    return;
  }

  self.var_e29b96d2 = spawn(localclientnum, vehicle.origin, "script_model", vehicle getentitynumber(), driver.team);

  if(isDefined(self.var_e29b96d2)) {
    self.var_e29b96d2 setModel(#"tag_origin");
    self.var_e29b96d2 linkto(vehicle);
    self.var_e29b96d2 setcompassicon("icon_minimap_sensor_dart");
    self.var_e29b96d2 function_811196d1(0);
    self.var_e29b96d2 function_a5edb367(#"neutral");
    self.var_e29b96d2 function_8e04481f();
    self.var_e29b96d2 function_5e00861(0.62);
    self.var_e29b96d2 enablevisioncircle(localclientnum, 2400, 1);
  }
}

function function_3ec2efae(localclientnum) {
  vehicle = getplayervehicle(self);

  if(!isDefined(vehicle) || !vehicle isvehicle()) {
    return false;
  }

  if(!isDefined(vehicle.owner)) {
    return false;
  }

  if(util::function_fbce7263(vehicle.owner.team, self.team)) {
    return false;
  }

  if(!isDefined(vehicle.scriptbundlesettings)) {
    return false;
  }

  if(!isDefined(vehicle.settings)) {
    vehicle.settings = getscriptbundle(vehicle.scriptbundlesettings);
  }

  if(isDefined(vehicle.settings) && is_true(vehicle.settings.var_2627e80a)) {
    var_1861e0b1 = vehicle clientfield::get("toggle_horn_sound");

    if(is_true(var_1861e0b1)) {
      return true;
    }
  }

  return false;
}

function stunnedcallback(localclientnum, val) {
  self setstunned(val);
}

function function_b0d51c9(localclientnum, owner) {
  curtime = gettime();

  if(curtime < self.var_1a6ef836) {
    return self.var_ed40ad25;
  }

  self.var_ed40ad25 = 0;

  if(isDefined(owner)) {
    self.var_1a6ef836 = curtime + 500;
    cameraangles = owner getcamangles();

    if(isDefined(cameraangles)) {
      var_742173a2 = anglesToForward(cameraangles);
      var_a181fdc8 = anglesToForward(self.angles);
      dot = vectordot(var_742173a2, var_a181fdc8);

      if(dot > 0.866025) {
        self.var_ed40ad25 = 1;
      }
    }
  }

  return self.var_ed40ad25;
}

function private function_1e8ff2f7(settings, seat_index) {
  switch (seat_index) {
    case 0:
      return settings.vehicle_turret;
    case 1:
      return settings.var_87d0163a;
    case 2:
      return settings.var_e207caa8;
    case 3:
      return settings.var_d4412f1b;
    case 4:
      return settings.var_544baf32;
    default:
      return undefined;
  }
}

function private function_356e1073(seat_index) {
  switch (seat_index) {
    case 0:
      return "tag_flash";
    case 1:
      return "tag_gunner_flash1";
    case 2:
      return "tag_gunner_flash2";
    case 3:
      return "tag_gunner_flash3";
    case 4:
      return "tag_gunner_flash4";
    default:
      return undefined;
  }
}

function private function_ed50d3e0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_b4806ee(0, localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function private function_b7f86930(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_b4806ee(1, localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function private function_4b2a0f55(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_b4806ee(2, localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function private function_a2943e68(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_b4806ee(3, localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function private function_a64f45de(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self function_b4806ee(4, localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function private function_b4806ee(seatindex, localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.settings) && isDefined(self.scriptbundlesettings)) {
    self.settings = getscriptbundle(self.scriptbundlesettings);
  }

  if(!isDefined(self.settings)) {
    return;
  }

  if(!isDefined(self.var_500ef685)) {
    self.var_500ef685 = [];
  }

  if(isDefined(self.var_500ef685[binitialsnap])) {
    stopfx(fieldname, self.var_500ef685[binitialsnap]);
    self.var_500ef685[binitialsnap] = undefined;
  }

  if(bwastimejump == 1) {
    var_82989abf = function_1e8ff2f7(self.settings, binitialsnap);
    fx_tag = function_356e1073(binitialsnap);

    if(isDefined(var_82989abf) && isDefined(fx_tag)) {
      self.var_500ef685[binitialsnap] = self util::playFXOnTag(fieldname, var_82989abf, self, fx_tag);
    }
  }
}