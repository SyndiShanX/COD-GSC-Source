/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\angola_2.csc
**************************************/

#include clientscripts\_utility;
#include clientscripts\_audio;
#include clientscripts\_filter;
#include clientscripts\angola_2_fx;
#include clientscripts\_load;
#include clientscripts\angola_2_amb;
#include clientscripts\_driving_fx;

main() {
  clientscripts\angola_2_fx::main();
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\angola_2_amb::main();
  thread set_fog_bank_cod();
  thread kill_buckets();
  register_clientflag_callback("scriptmover", 9, ::link_cardboard_box_to_barge);
  register_clientflag_callback("player", 10, ::play_tow_futz);
  register_clientflag_callback("player", 8, ::play_tow_highlight);
  init_lighting_pairs();
  waitforclient(0);
  clientscripts\_driving_fx::add_vehicletype_callback("boat_pbr_medium_breakable", ::boat_setup_pbr);
  clientscripts\_driving_fx::add_vehicletype_callback("boat_patrol_nva_river", ::boat_setup_patrol);
  init_filter_custom_tow(level.localplayers[0]);
}

set_fog_bank_cod() {
  n_local_client_number = 0;
  n_sensitive_room_fog_bank = 2;
  level waittill("cod_fog_bank");
  setworldfogactivebank(n_local_client_number, n_sensitive_room_fog_bank);
  level waittill("default_fog_bank");
  n_local_client_number = 0;
  n_sensitive_room_fog_bank = 1;
  setworldfogactivebank(n_local_client_number, n_sensitive_room_fog_bank);
}

boat_setup_pbr(localclientnum) {
  self thread play_water_loop("veh_boat_water_loop", "veh_boat_water_splash", 35);
  self thread play_water_loop("veh_boat_run", "null", 15);
}

boat_setup_patrol(localclientnum) {
  self thread play_water_loop("veh_boat_water_loop", "veh_boat_water_splash", 35);
  self thread play_water_loop("veh_boat_engine_medium", "null", 15);
}

grab_light_origin(localclientnum, set, newent) {
  level endon("cod_finished");
  level.light_origin = self;
}

light_player_with_entity(localclientnum, set, newent) {
  self setlightingentity(level.light_origin);
  level waittill("clear_lighting_entities");
}

light_actor_with_entity(localclientnum, set, newent) {
  self setlightingentity(level.light_origin);
  level waittill("clear_lighting_entities");
  self setlightingentity(self);
}

kill_buckets(localclientnum, set, newent) {
  dyn_ents = getdynentarray("barge_dyn_ents");
  level waittill("unlink_box");

  if(isstereoon()) {
    foreach(dyn_ent in dyn_ents)
    setdynentenabled(dyn_ent, 0);
  }
}

link_cardboard_box_to_barge(localclientnum, set, newent) {
  dyn_ents = getdynentarray("barge_dyn_ents");
  level waittill("unlink_box");

  foreach(dyn_ent in dyn_ents) {
    x = randomintrange(250, 500);

    if(randomint(2))
      x = x * -1;

    offset = (x, randomintrange(-200, 200), 0);
    dyn_ent.origin = self.origin + offset;
  }
}

play_tow_futz(localclientnum, set, newent) {
  if(set)
    enable_filter_custom_tow(level.localplayers[0]);
  else
    disable_filter_custom_tow(level.localplayers[0]);
}

play_tow_highlight(localclientnum, set, newent) {
  if(set)
    towlockedon = 1;
  else
    towlockedon = 0;

  set_filter_custom_tow_mode(level.localplayers[0], towlockedon);
}