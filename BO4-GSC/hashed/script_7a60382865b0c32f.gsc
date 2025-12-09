/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_7a60382865b0c32f.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\flagsys_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\teleport_shared;
#namespace namespace_fb2fa231;

autoexec __init__system__() {
  system::register(#"hash_f6d669c16956035", & __init__, & __main__, undefined);
}

__init__() {
}

__main__() {
  level flagsys::wait_till("radiant_gameobjects_initialized");
  var_89a8613a = getdvarint(#"hash_410c90db0ceacb59", 0) || isDefined(getgametypesetting(#"hash_41597159456773fd")) && getgametypesetting(#"hash_41597159456773fd");
  if(sessionmodeiswarzonegame() && var_89a8613a == 1) {
    var_f24225a3 = struct::get_array("gameobject_warzone_teleport", "scriptbundlename");
    foreach(e_gameobject in var_f24225a3) {
      e_gameobject thread function_2253b5d3();
    }
    level thread function_c12c0902();
    return;
  }
  var_f24225a3 = struct::get_array("gameobject_warzone_teleport", "scriptbundlename");
  foreach(e_gameobject in var_f24225a3) {
    e_gameobject gameobjects::destroy_object(1);
  }
}

function_2253b5d3() {
  self.mdl_gameobject endon(#"death");
  while(true) {
    waitresult = self.mdl_gameobject waittill(#"gameobject_end_use_player");
    e_player = waitresult.player;
    level teleport::player(e_player, array(self.target, "targetname"));
    level teleport::function_8db85ae7(array(self.target, "targetname"));
    waitframe(1);
  }
}

function_c12c0902() {
  a_containers = struct::get_array("chest_container");
  foreach(s_object in a_containers) {
    s_object.var_97c4739a = getent(s_object.target, "targetname");
    s_object.mdl_gameobject gameobjects::set_onbeginuse_event( & function_b7ff7728);
    s_object.mdl_gameobject gameobjects::set_onenduse_event( & function_24357980);
    s_object.mdl_gameobject gameobjects::function_336b5791(#"allies");
    s_object.mdl_gameobject.state = "closed";
    s_object.var_97c4739a scene::init("p8_fxanim_test_weapon_crate_close_bundle", s_object.var_97c4739a);
    var_1fade293 = struct::get(s_object.var_97c4739a.target);
    s_object.mdl_gameobject thread function_b708171a(var_1fade293);
  }
  a_containers = struct::get_array("secret_container");
  foreach(s_object in a_containers) {
    s_object.var_97c4739a = getent(s_object.target, "targetname");
    s_object.mdl_gameobject gameobjects::set_onbeginuse_event( & function_6a477b2b);
    s_object.mdl_gameobject gameobjects::set_onenduse_event( & function_d62f7403);
    s_object.mdl_gameobject gameobjects::function_336b5791(#"allies");
    s_object.mdl_gameobject.state = "closed";
    s_object.var_97c4739a scene::init("p8_fxanim_cp_journalist_vehicle_atv_cover_removal_bundle", s_object.var_97c4739a);
    var_1fade293 = struct::get(s_object.var_97c4739a.target);
    s_object.mdl_gameobject thread function_14250cfb(var_1fade293);
  }
  a_containers = struct::get_array("bed_container");
  foreach(s_object in a_containers) {
    s_object.mdl_gameobject gameobjects::set_onbeginuse_event( & function_85c6cdd4);
    s_object.mdl_gameobject gameobjects::set_onenduse_event( & function_e127fadc);
    s_object.mdl_gameobject gameobjects::function_336b5791(#"allies");
  }
}

function_b7ff7728(e_player) {
}

function_24357980(team, player, success) {
  if(!isDefined(player)) {
    return;
  }
  if(isDefined(success) && success) {
    if(self.state == "closed") {
      self.e_object.var_97c4739a scene::play("p8_fxanim_test_weapon_crate_open_bundle", self.e_object.var_97c4739a);
      self.state = "open";
      return;
    }
    self.e_object.var_97c4739a scene::play("p8_fxanim_test_weapon_crate_close_bundle", self.e_object.var_97c4739a);
    self.state = "closed";
  }
}

function_6a477b2b(e_player) {
}

function_d62f7403(team, player, success) {
  if(!isDefined(player)) {
    return;
  }
  if(isDefined(success) && success) {
    self.e_object.var_97c4739a thread scene::play("p8_fxanim_cp_journalist_vehicle_atv_cover_removal_bundle");
    wait 2.75;
    self gameobjects::disable_object();
  }
}

function_85c6cdd4(e_player) {
}

function_e127fadc(team, player, success) {
  if(!isDefined(player)) {
    return;
  }
  if(isDefined(success) && success) {
    var_d2cc84e8 = struct::get(self.e_object.target);
    self.visuals[0] moveto(var_d2cc84e8.origin, 1);
    var_11c7e7ad = struct::get(var_d2cc84e8.target);
    self function_29fc87a7(var_11c7e7ad.origin, var_11c7e7ad.angles);
    self gameobjects::disable_object();
  }
}

function_b708171a(container) {
  w_random = array::random(array(getweapon(#"ar_accurate_t8"), getweapon(#"lmg_standard_t8")));
  self.var_969d9221 = spawnweapon(w_random, container.origin, container.angles);
  self.var_969d9221.angles = self.e_object.var_97c4739a.angles + (0, -90, 0);
  self.gun_origin = self.var_969d9221.origin;
}

function_14250cfb(container) {
  w_random = array::random(array(getweapon(#"ar_accurate_t8"), getweapon(#"lmg_standard_t8")));
  self.var_969d9221 = spawnweapon(w_random, container.origin, container.angles);
  self.gun_origin = self.var_969d9221.origin;
}

function_29fc87a7(origin = self.origin, offset = undefined) {
  w_random = array::random(array(getweapon(#"ar_accurate_t8"), getweapon(#"lmg_standard_t8")));
  self.var_969d9221 = spawnweapon(w_random, origin, offset);
  self.gun_origin = self.var_969d9221.origin;
  if(isDefined(offset)) {
    self.var_969d9221.angles += offset;
    return;
  }
  if(isDefined(self.e_object.var_97c4739a)) {
    self.var_969d9221.angles = self.e_object.var_97c4739a.angles + (0, -90, 0);
  }
}