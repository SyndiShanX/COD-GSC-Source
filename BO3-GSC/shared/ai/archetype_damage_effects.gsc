/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_damage_effects.gsc
*************************************************/

#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#namespace archetype_damage_effects;

function autoexec main() {
  clientfield::register("actor", "arch_actor_fire_fx", 1, 2, "int");
  clientfield::register("actor", "arch_actor_char", 1, 2, "int");
  callback::on_actor_damage( & onactordamagecallback);
  callback::on_vehicle_damage( & onvehicledamagecallback);
  callback::on_actor_killed( & onactorkilledcallback);
  callback::on_vehicle_killed( & onvehiclekilledcallback);
}

function onactordamagecallback(params) {
  onactordamage(params);
}

function onvehicledamagecallback(params) {
  onvehicledamage(params);
}

function onactorkilledcallback(params) {
  onactorkilled();
  switch (self.archetype) {
    case "human": {
      onhumankilled();
      break;
    }
    case "robot": {
      onrobotkilled();
      break;
    }
  }
}

function onvehiclekilledcallback(params) {
  onvehiclekilled(params);
}

function onactordamage(params) {}

function onvehicledamage(params) {
  onvehiclekilled(params);
}

function onactorkilled() {
  if(isdefined(self.damagemod)) {
    if(self.damagemod == "MOD_BURNED") {
      if(isdefined(self.damageweapon) && isdefined(self.damageweapon.specialpain) && self.damageweapon.specialpain == 0) {
        self clientfield::set("arch_actor_fire_fx", 2);
      }
    }
  }
}

function onhumankilled() {}

function onrobotkilled() {}

function onvehiclekilled(params) {}