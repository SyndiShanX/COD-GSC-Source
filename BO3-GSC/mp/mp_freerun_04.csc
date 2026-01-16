/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_freerun_04.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_load;
#using scripts\mp\_util;
#using scripts\mp\mp_freerun_04_fx;
#using scripts\mp\mp_freerun_04_sound;
#using scripts\shared\callbacks_shared;
#using scripts\shared\util_shared;
#namespace namespace_d7e71261;

function main() {
  namespace_c68b7fb6::main();
  namespace_8a3acb29::main();
  level._effect["blood_rain"] = "weather/fx_rain_blood_player_freerun_loop";
  setdvar("phys_buoyancy", 1);
  setdvar("phys_ragdoll_buoyancy", 1);
  load::main();
  util::waitforclient(0);
  callback::on_localplayer_spawned( & player_rain);
}

function player_rain(localclientnum) {
  self.e_link = spawn(localclientnum, self.origin, "script_model");
  self.e_link setmodel("tag_origin");
  self.e_link.angles = self.angles;
  self.e_link linkto(self);
  self.var_88aec2ed = playfxontag(localclientnum, level._effect["blood_rain"], self.e_link, "tag_origin");
}