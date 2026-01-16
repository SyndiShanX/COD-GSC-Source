/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\so_tut_mp_drone.csc
*********************************************/

#include clientscripts\_utility;
#include clientscripts\_bigdog;
#include clientscripts\so_tut_mp_drone_fx;
#include clientscripts\_claw_grenade;
#include clientscripts\_load;
#include clientscripts\_audio;
#include clientscripts\so_tut_mp_drone_amb;
#include clientscripts\_so_rts;
#include clientscripts\_footsteps;
#include clientscripts\_vehicle;

main() {
  clientscripts\so_tut_mp_drone_fx::main();
  clientscripts\_claw_grenade::main();
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\so_tut_mp_drone_amb::main();
  thread clientscripts\_so_rts::rts_init("generic_filter_rts_hologram_drone");
  clientscripts\_footsteps::registeraitypefootstepcb("So_Enemy_Bigdog", clientscripts\_footsteps::bigdogfootstepcbfunc);
  disablefx = getdvarint(#"_id_C9B177D6");

  if(!isDefined(disablefx) || disablefx <= 0)
    precache_scripted_fx();

  thread waitforclient(0);
  register_clientflag_callback("scriptmover", 6, ::make_fake_blackhawk);
}

make_fake_blackhawk(localclientnum, set, newent) {
  if(set) {
    self.vehicletype = "heli_osprey";
    self.lightfxnamearray = [];
    self.treadfx = [];
    self.treadfx["concrete"] = loadfx("vehicle/treadfx/fx_heli_dust_concrete");
    self thread clientscripts\_vehicle::aircraft_dustkick();
  }
}

precache_scripted_fx() {
  level._effect["claymore_laser"] = loadfx("weapon/claymore/fx_claymore_laser");
  level._effect["claymore_explode"] = loadfx("explosions/fx_grenadeexp_dirt");
  level._effect["claymore_gib"] = loadfx("explosions/fx_exp_death_gib");
}