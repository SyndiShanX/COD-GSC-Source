/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_sampan.gsc
**************************************/

#include maps\_vehicle;
#include maps\_utility;

main() {
  if(isDefined(self.script_string) && self.script_string == "sink_me") {
    level._effect["sink_fx" + self.vehicletype] = loadfx("vehicle/vexplosion/fx_vexp_sampan_machinegun");
    level._effect["explo_fx" + self.vehicletype] = loadfx("vehicle/vexplosion/fx_vexp_sampan");
    level.vehicle_death_thread[self.vehicletype] = ::delete_and_sink_fx;
  }
}

delete_and_sink_fx() {
  self notify("nodeath_thread");

  if(!isDefined(self.weapon_last_damage))
    self.weapon_last_damage = "hind_rockets";

  if(self.weapon_last_damage == "hind_rockets") {
    playfx(level._effect["explo_fx" + self.vehicletype], self.origin, anglestoforward(self.angles));
    self playsound("evt_sampan_explo");
  } else {
    playfx(level._effect["sink_fx" + self.vehicletype], self.origin, anglestoforward(self.angles));
    self playsound("evt_sampan_sink");
  }

  waittillframeend;
  self delete();
}