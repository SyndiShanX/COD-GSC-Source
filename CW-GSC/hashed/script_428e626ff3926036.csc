/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_428e626ff3926036.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\fx_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_utility;
#namespace namespace_9bf84a22;

function private autoexec __init__system__() {
  system::register(#"hash_6d911609eb131d76", &_preload, &function_fa076c68, undefined, undefined);
}

function private _preload() {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  function_bc948200();
}

function private function_fa076c68() {
  vehicle::add_vehicletype_callback(#"hash_1d28a638b43b4117", &function_d7fc17ab);
}

function private function_bc948200() {
  clientfield::register("scriptmover", "clf_cargoplane_client_register", 1, 1, "int", &function_a9581e24, 0, 0);
  clientfield::register("scriptmover", "clf_cargoplane_landing_lights", 1, 1, "int", &function_5caef633, 0, 0);
  clientfield::register("scriptmover", "clf_cargoplane_nav_lights", 1, 1, "int", &function_c4178945, 0, 0);
}

function private function_a9581e24(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  level._fx.cargo_plane = self;
}

function private function_5caef633(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  function_907070de("<dev string:x38>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  if(newval) {
    self function_9a0e9c31(localclientnum);
    return;
  }

  self notify(#"hash_10d9c330299e2a6d");
}

function private function_9a0e9c31(localclientnum) {
  self notify(#"hash_16331609e21e3a86");
  var_3f79908d = playtagfxset(localclientnum, "fx9_cargo_plane_landing_lights", self);
  self thread function_b053bd08(localclientnum, var_3f79908d);
}

function private function_b053bd08(localclientnum, var_3f79908d) {
  self waittill(#"death", #"hash_16331609e21e3a86", #"hash_10d9c330299e2a6d");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function private function_c4178945(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self util::waittill_dobj(localclientnum);

  function_907070de("<dev string:x59>", localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);

  if(newval) {
    self function_54105299(localclientnum);
    return;
  }

  self notify(#"hash_5bd6457a6c206a17");
}

function private function_54105299(localclientnum) {
  self notify(#"hash_8d07a9f3af1838");
  var_3f79908d = playtagfxset(localclientnum, "fx9_cargo_plane_nav_lights", self);
  self thread function_fa38e4db(localclientnum, var_3f79908d);
}

function private function_fa38e4db(localclientnum, var_3f79908d) {
  self waittill(#"death", #"hash_8d07a9f3af1838", #"hash_5bd6457a6c206a17");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function private function_d7fc17ab(localclientnum) {
  if(!isDefined(level._fx)) {
    level._fx = {};
  }

  self util::waittill_dobj(localclientnum);
  level._fx.var_a736d041 = self;
  var_3f79908d = playtagfxset(localclientnum, "fx9_cargo_plane_nav_lights", self);
  self thread function_5445f621(localclientnum, var_3f79908d);
}

function private function_5445f621(localclientnum, var_3f79908d) {
  self waittill(#"death");

  foreach(fxid in var_3f79908d) {
    stopfx(localclientnum, fxid);
  }
}

function private function_bb753058(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!function_65b9eb0f(fieldname)) {
    timer_model = function_c8b7588d(fieldname);
    duration_msec = bwastimejump * 1000;
    setuimodelvalue(timer_model, getservertime(fieldname, 1) + duration_msec);
  }
}

function private on_localplayer_connect(localclientnum) {
  timer_model = function_c8b7588d(localclientnum);
  setuimodelvalue(timer_model, 0);
}

function private function_c8b7588d(localclientnum) {
  return getuimodel(function_1df4c3b0(localclientnum, #"warzone_global"), "srProtoTimer");
}

function private function_907070de(var_55ee7def, localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  println("<dev string:x76>" + var_55ee7def + "<dev string:x86>" + localclientnum + "<dev string:x9d>" + oldval + "<dev string:xab>" + newval + "<dev string:xb9>" + bnewent + "<dev string:xc8>" + binitialsnap + "<dev string:xdc>" + fieldname + "<dev string:xed>" + bwastimejump);
}