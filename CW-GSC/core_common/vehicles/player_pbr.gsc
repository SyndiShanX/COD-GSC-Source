/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\player_pbr.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicles\player_vehicle;
#namespace player_pbr;

function private autoexec __init__system__() {
  system::register(#"player_pbr", &preinit, undefined, undefined, #"player_vehicle");
}

function private preinit() {
  vehicle::add_main_callback("player_pbr", &function_cc0af45d);
  setDvar(#"phys_buoyancy", 1);
}

function private function_cc0af45d() {
  self setmovingplatformenabled(1, 0);
  callback::function_d8abfc3d(#"hash_666d48a558881a36", &function_b65217f6);
  callback::function_d8abfc3d(#"hash_55f29e0747697500", &function_674b9c5b);
  callback::function_d8abfc3d(#"hash_2c1cafe2a67dfef8", &function_f2626e5f);
  callback::function_d8abfc3d(#"hash_551381cffdc79048", &function_ca11d4c2);
  self.var_3daa0191 = &function_b61c27bb;
  self.var_96c0f900 = [];
  self.var_96c0f900[1] = 1000;
  self.var_96c0f900[2] = 1000;
  self thread player_vehicle::function_5bce3f3a(0, 1000);
  self thread player_vehicle::function_5bce3f3a(1, 1000);
  self thread player_vehicle::function_5bce3f3a(2, 1000);
}

function private function_b61c27bb(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  occupants = self getvehoccupants();

  if(isDefined(occupants)) {
    foreach(occupant in occupants) {
      if(isPlayer(occupant) && !isbot(occupant)) {
        damagepct = modelindex / self.maxhealth;
        damagepct = int(max(damagepct, 3));
        damagedirection = undefined;

        if(isDefined(damagefromunderneath) || isDefined(psoffsettime)) {
          if(isDefined(psoffsettime) && (partname === "MOD_RIFLE_BULLET" || partname === "MOD_PISTOL_BULLET")) {
            damagedirection = vectornormalize(occupant.origin - psoffsettime.origin);
          } else {
            damagedirection = vsurfacenormal;
          }
        }

        occupant addtodamageindicator(damagepct, damagedirection);
        break;
      }
    }
  }
}

function function_b65217f6(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(eventstruct.seat_index === 0) {
    self function_eb39313f(player);
  }

  self thread player_vehicle::function_e8e41bbb();
}

function function_674b9c5b(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(eventstruct.seat_index === 0) {
    self function_77fbc7d9(player);
  }
}

function function_f2626e5f(params) {
  player = params.player;
  eventstruct = params.eventstruct;

  if(!isDefined(player)) {
    return;
  }

  if(eventstruct.seat_index === 0) {
    self function_eb39313f(player);
    return;
  }

  self function_77fbc7d9(player);
}

function private function_ca11d4c2(params) {
  if(!isalive(self)) {
    return;
  }

  driver = self getseatoccupant(0);

  if(!isDefined(driver)) {
    return;
  }

  if(isvehicle(params.entity) && params.entity.scriptvehicletype !== "player_pbr") {
    array::add(self.var_9be5a571, params.entity, 0);
  }
}

function function_eb39313f(player) {
  if(!isDefined(self.var_9be5a571)) {
    self.var_9be5a571 = [];
  }

  self thread function_53f7a11f(player);
}

function function_77fbc7d9(player) {
  self.overridevehicledamage = undefined;

  if(isDefined(player)) {
    player notify(#"hash_2c76be993516dda2");
  }
}

function function_53f7a11f(player) {
  self notify("638241f01faa741a");
  self endon("638241f01faa741a");
  self endon(#"death");
  player endon(#"death", #"exit_vehicle", #"change_seat");

  while(true) {
    self.overridevehicledamage = undefined;

    if(self.var_9be5a571.size > 0) {
      for(i = self.var_9be5a571.size - 1; i >= 0; i--) {
        vehicle = self.var_9be5a571[i];

        if(isvehicle(vehicle)) {
          dist = distance2dsquared(self.origin, vehicle.origin);

          if(dist >= 80000) {
            arrayremovevalue(self.var_9be5a571, vehicle);
            continue;
          }

          z_dist = self.origin[2] - vehicle.origin[2];

          if(z_dist > 0 && dist <= 9000) {
            if(isalive(vehicle)) {
              self.overridevehicledamage = &function_786eff5d;
              vehicle.var_369c83bd = 1;
              vehicle.var_475b9991 = 1;
              vehicle.var_c0381a15 = 1;
              vehicle dodamage(vehicle.health, self.origin, player, self);
            }

            arrayremovevalue(self.var_9be5a571, vehicle);
          }
        }
      }
    }

    waitframe(1);
  }
}

function private function_786eff5d(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  damage = partname;

  if(isPlayer(modelindex)) {
    attackervehicle = modelindex getvehicleoccupied();

    if(attackervehicle === self) {
      if(isvehicle(damagefromunderneath) && vsurfacenormal === "MOD_EXPLOSIVE") {
        damage = 0;
      }
    }
  }

  return damage;
}