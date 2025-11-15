/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\vehicles\recon_wz.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_shared;

#namespace recon_wz;

autoexec __init__system__() {
  system::register("recon_wz", &__init__, undefined, undefined);
}

__init__() {
  vehicle::add_main_callback("recon_wz", &function_294117a0);
  callback::on_vehicle_killed(&on_vehicle_killed);
  clientfield::register("toplayer", "recon_out_of_circle", 1, 5, "int");
  clientfield::register("toplayer", "recon_static_postfx", 1, 1, "int");

  if(!isDefined(level.var_1f020f16)) {
    level.var_1f020f16 = [];
  }

  level.var_1f020f16[#"vehicle_t8_drone_recon_wz"] = &function_3711499d;
}

function_294117a0() {
  self vehicle::toggle_sounds(1);
  self disabledriverfiring(1);
  self.ignore_death_jolt = 1;
  self.var_92043a49 = 1;
  self.overridevehicledamage = &function_371a151b;
  self.is_staircase_up = &vehicle::function_eb183ffe;
}

function_3711499d(vehicle, deployable_weapon, traceresult) {
  maxdepth = isDefined(deployable_weapon.var_76127e14) ? deployable_weapon.var_76127e14 : 0;

  if(maxdepth > 0 && traceresult.waterdepth > maxdepth) {
    return false;
  }

  return true;
}

function_371a151b(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(smeansofdeath == "MOD_CRUSH" && self isvehicleusable()) {
    self.idflags |= 8192;
  }

  return idamage;
}

event_handler[enter_vehicle] codecallback_vehicleenter(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  vehicle = eventstruct.vehicle;

  if(!isDefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != "recon_wz") {
    return;
  }

  self clientfield::set_to_player("recon_static_postfx", 1);
  vehicle makevehicleusable();
  vehicle thread watchownerdisconnect(self);
  self thread function_b96833b2(vehicle);
}

watchownerdisconnect(player) {
  self notify("5f1e127cceae91cd");
  self endon("5f1e127cceae91cd");
  self endon(#"death", #"exit_vehicle");
  player waittill(#"disconnect", #"death");
  self makevehicleunusable();
  self thread function_ec1a4a6b();
}

event_handler[exit_vehicle] codecallback_vehicleexit(eventstruct) {
  if(!isplayer(self)) {
    return;
  }

  self clientfield::set_to_player("recon_out_of_circle", 0);
  vehicle = eventstruct.vehicle;

  if(!isDefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != "recon_wz") {
    return;
  }

  self clientfield::set_to_player("recon_static_postfx", 0);

  if(isalive(vehicle)) {
    vehicle makevehicleunusable();
    vehicle thread function_ec1a4a6b();
  }
}

private function_b96833b2(vehicle) {
  self notify("103a2be8751d4c46");
  self endon("103a2be8751d4c46");
  self endon(#"death", #"disconnect");
  vehicle endon(#"death", #"exit_vehicle");

  while(true) {
    if(vehicle function_2c2c30e0()) {
      vehicle dodamage(vehicle.health, vehicle.origin);
    } else {
      var_aba3faed = distancesquared(self.origin, vehicle.origin);

      if(var_aba3faed > 8000 * 8000) {
        vehicle usevehicle(self, 0);
      }
    }

    if(isDefined(level.deathcircle)) {
      if(distance2dsquared(vehicle.origin, level.deathcircle.origin) > level.deathcircle.radius * level.deathcircle.radius) {
        if(!isDefined(vehicle.var_3de57a77)) {
          vehicle.var_3de57a77 = gettime();
        }

        var_a71a8383 = gettime() - vehicle.var_3de57a77;

        if(int(3 * 1000) <= var_a71a8383) {
          vehicle usevehicle(self, 0);
          self clientfield::set_to_player("recon_out_of_circle", 0);
        }

        var_e96a9222 = min(var_a71a8383, int(3 * 1000));
        var_e96a9222 /= int(3 * 1000);
        var_e96a9222 *= 31;
        self clientfield::set_to_player("recon_out_of_circle", int(var_e96a9222));
        waitframe(1);
      } else {
        self clientfield::set_to_player("recon_out_of_circle", 0);
        vehicle.var_3de57a77 = undefined;
        wait 0.5;
      }

      continue;
    }

    wait 0.1;
  }
}

private function_ec1a4a6b() {
  self notify("47a7355b1fe3316");
  self endon("47a7355b1fe3316");
  self endon(#"death");

  while(true) {
    speed = abs(self getspeedmph());
    velocity = self getvelocity();
    zvelocity = abs(velocity[2]);

    if(speed < 0.1 && zvelocity < 0.1) {
      self notify(#"hash_363004a4e0ccc1f");
      return;
    }

    wait 0.1;
  }
}

private on_vehicle_killed(params) {
  if(!isDefined(self.scriptvehicletype) || self.scriptvehicletype != "recon_wz") {
    return;
  }

  if(isDefined(params.occupants)) {
    if(params.occupants.size > 0 && self function_c7aa9338(params.occupants)) {
      if(isplayer(params.eattacker)) {
        params.eattacker stats::function_dad108fa(#"destroy_equipment", 1);
        callback::callback(#"hash_67dd51a5d529c64c");
      }
    }
  }

  wait 0.1;

  if(isDefined(self)) {
    self.var_4217cfcb = 1;
    self ghost();
  }

  wait 2;

  if(isDefined(self)) {
    self delete();
  }
}

private function_c7aa9338(array) {
  foreach(ent in array) {
    if(util::function_fbce7263(ent.team, self.team)) {
      return true;
    }
  }

  return false;
}