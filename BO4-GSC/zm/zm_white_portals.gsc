/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_portals.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm_common\zm_crafting;
#include scripts\zm_common\zm_fasttravel;
#include scripts\zm_common\zm_item_pickup;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_white_portals;

init() {
  callback::on_spawned(&on_player_spawn);
  main();
}

main() {
  if(!zm_utility::is_standard()) {
    level thread teleporter_init();
    level thread function_24167ed8();
  }

  level thread function_ab07399f();
}

init_clientfields() {
  clientfield::register("scriptmover", "portal_dest_fx", 20000, 3, "int");
  clientfield::register("toplayer", "PORTAL_YELLOW_BACKYARD", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_YELLOW_HOUSE", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_RED_HOUSE", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_GREEN_HOUSE", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_GREEN_BACKYARD", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_STREET_MID", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_STREET_START", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_PRISONER_HOLDING", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_OPERATIONS", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_TRANSFUSION_FACILITY", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_APD_INTERROGATION", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_DINER", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_BEDS", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_LOUNGE", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_POWER", 20000, 2, "int");
  clientfield::register("toplayer", "PORTAL_STORAGE", 20000, 2, "int");
  clientfield::register("actor", "crawler_portal_spawn_fx", 20000, 1, "counter");
  clientfield::register("toplayer", "teleporter_transition", 20000, 1, "counter");
  clientfield::register("toplayer", "teleporter_depart", 20000, 1, "counter");
  clientfield::register("toplayer", "teleporter_arrive", 20000, 1, "counter");
  clientfield::register("world", "portal_maps_clear_lights", 20000, 1, "int");
  clientfield::register("world", "portal_maps_initialize_lights", 20000, 1, "int");
  clientfield::register("world", "portal_map_indicator_green_house_backyard", 20000, 1, "int");
  clientfield::register("world", "portal_map_indicator_red_house", 20000, 1, "int");
  clientfield::register("world", "portal_map_indicator_yellow_house", 20000, 1, "int");
  clientfield::register("world", "portal_map_indicator_prisoner_holding", 20000, 1, "int");
  clientfield::register("world", "portal_map_indicator_street_middle", 20000, 1, "int");
  clientfield::register("world", "portal_map_indicator_transfusion_facility", 20000, 1, "int");
  clientfield::register("world", "portal_map_indicator_diner", 20000, 1, "int");
  clientfield::register("world", "portal_map_indicator_beds", 20000, 1, "int");
  clientfield::register("world", "portal_map_indicator_power", 20000, 1, "int");
  clientfield::register("world", "portal_map_indicator_storage", 20000, 1, "int");
}

function_24167ed8() {
  level flag::init(#"hash_2120a14c5eeab590");
  level flag::init(#"shield_built");
  level flag::init(#"hash_2a5fb4f6bae2e180");
  zm_crafting::function_d1f16587(#"ztable_white_open", &function_5702b2e7);
}

function_ab07399f() {
  foreach(t_crafting in level.var_4fe2f84d[#"ztable_white_open"]) {
    if(isDefined(t_crafting.var_4f749ffe)) {
      t_crafting.var_ae360c37 = getent(t_crafting.var_4f749ffe.target, "targetname");
      t_crafting.var_ae360c37 ghost();
    }
  }
}

function_5702b2e7(e_player) {
  if(isDefined(self.stub) && isDefined(self.stub.blueprint)) {
    t_crafting = self.stub;
  } else if(isDefined(self.blueprint)) {
    t_crafting = self;
  }

  if(t_crafting.blueprint.name == #"zblueprint_white_mmtd") {
    t_crafting.var_4f749ffe show();
    t_crafting.var_ae360c37 show();
    level flag::set(#"hash_2120a14c5eeab590");

    if(function_8b1a219a()) {
      level.var_279a11a3 = self.stub.var_4f749ffe zm_unitrigger::create(#"hash_57249497bfb88a5", 64, &function_735e7b);
    } else {
      level.var_279a11a3 = self.stub.var_4f749ffe zm_unitrigger::create(#"hash_57249497bfb88a5", 64, &function_735e7b);
    }

    zm_ui_inventory::function_7df6bb60("zm_whiteteleporter_phase_num", 1);
  } else {
    level flag::set(#"shield_built");
  }

  if(level flag::get(#"hash_2120a14c5eeab590") && level flag::get(#"shield_built")) {
    level flag::set(#"hash_2a5fb4f6bae2e180");
  }
}

function_735e7b() {
  self waittill(#"trigger");
  function_e0a8fc52();
}

function_e0a8fc52() {
  level.var_868c98df = 2;
  level notify(#"modifier_acquired");
  self playSound(#"hash_59436c2037092176");
  level.var_279a11a3.related_parent setinvisibletoall();
  var_ae360c37 = getent(level.var_279a11a3.related_parent.target, "targetname");
  var_ae360c37 setinvisibletoall();
  zm_ui_inventory::function_7df6bb60("teleporter_pad_1", 1);
  zm_ui_inventory::function_7df6bb60("teleporter_pad_2", 1);
  zm_unitrigger::unregister_unitrigger(level.var_279a11a3);
}

function_3264eb9c() {
  level clientfield::set("portal_maps_clear_lights", 1);
}

function_71e1c159() {
  level clientfield::set("portal_maps_initialize_lights", 1);
  var_7ed14c5f = function_688df525();

  foreach(s_portal in var_7ed14c5f) {
    level thread function_3566160b(s_portal.script_noteworthy, 1);
  }
}

teleporter_init() {
  level.teleport_ae_funcs = [];
  level flag::init(#"portals_active");
  level.var_868c98df = 0;
  level thread setup_portals();
  level.s_zombie_teleport_room = struct::get("zombie_teleport_room", "targetname");
  level clientfield::set("portal_maps_clear_lights", 1);
}

function_2113985() {
  level.portal_trig = getEntArray("portal_trigs", "targetname");

  foreach(e_portal in level.portal_trig) {
    e_portal teleport_pad_init();
  }
}

teleport_pad_init() {
  self.b_active = 1;
  self.b_locked = 0;
  self.b_placed = 0;
  self.a_portal_used = [];
  s_zombie_pos = self function_d9e2dc1f();
  self.fx_pos = s_zombie_pos.origin;
  self thread player_teleporting();
}

player_teleporting() {
  self endon(#"death");
  user = undefined;

  while(true) {
    waitresult = self waittill(#"trigger");
    user = waitresult.activator;
    player_used = 0;

    if(isDefined(self.a_portal_used)) {
      for(i = 0; i < self.a_portal_used.size; i++) {
        if(self.a_portal_used[i] == user) {
          player_used = 1;
        }
      }
    }

    if(player_used == 1) {
      continue;
    }

    if(zm_utility::is_player_valid(user, 0, 1)) {
      self thread teleport_player(user);
    }
  }
}

teleport_player(user) {
  if(!isDefined(user)) {
    return;
  }

  user endoncallback(&function_96e88318, #"death");
  destination = undefined;

  if(isDefined(user.teleporting) && user.teleporting == 1) {
    return;
  }

  level notify(#"portal_used", {
    #s_portal: self
  });
  user notify(#"teleporting");
  user.teleporting = 1;
  user.s_teleport = self;
  user.teleport_location = self.origin;
  user clientfield::increment_to_player("teleporter_transition", 1);

  switch (self.n_dest) {
    case 0:
      var_298e4578 = level.s_portal_yellow_backyard;
      break;
    case 1:
      var_298e4578 = level.s_portal_yellow_house;
      break;
    case 2:
      var_298e4578 = level.s_portal_red_house;
      break;
    case 3:
      var_298e4578 = level.s_portal_green_house;
      break;
    case 4:
      var_298e4578 = level.s_portal_green_backyard;
      break;
    case 5:
      var_298e4578 = level.s_portal_street_mid;
      break;
    case 6:
      var_298e4578 = level.s_portal_street_start;
      break;
    case 7:
      var_298e4578 = level.s_portal_prisoner_holding;
      break;
    case 8:
      var_298e4578 = level.s_portal_operations;
      break;
    case 9:
      var_298e4578 = level.s_portal_transfusion_facility;
      break;
    case 10:
      var_298e4578 = level.s_portal_apd_interrogation;
      break;
    case 11:
      var_298e4578 = level.s_portal_diner;
      break;
    case 12:
      var_298e4578 = level.s_portal_beds;
      break;
    case 13:
      var_298e4578 = level.s_portal_lounge;
      break;
    case 14:
      var_298e4578 = level.s_portal_power;
      break;
    case 15:
      var_298e4578 = level.s_portal_storage;
      break;
  }

  destination = var_298e4578.var_52a6f692;
  user clientfield::increment_to_player("teleporter_depart", 1);
  playFX(level._effect[#"portal_origin"], self.origin, (1, 0, 0), (0, 0, 1));
  playsoundatposition(#"evt_teleporter_out", self.origin);
  level thread function_fe50866d(user, self, var_298e4578);
  self function_134670b9(1);
  user zm_fasttravel::function_66d020b0(undefined, undefined, undefined, undefined, destination, undefined, string(self.n_dest), 0);
  user clientfield::increment_to_player("teleporter_transition", 1);
  var_298e4578 thread cooldown_portal_timer(user);
  user thread function_c234a5ce();
  user clientfield::increment_to_player("teleporter_arrive", 1);
  playFX(level._effect[#"portal_dest"], var_298e4578.origin, (1, 0, 0), (0, 0, 1));
  playsoundatposition(#"evt_teleporter_go", var_298e4578.origin);
  user playsoundtoplayer(#"hash_39876bf613387fef", user);
  wait 0.5;
  user function_96e88318();
  user notify(#"teleporting_done");
  util::setclientsysstate("levelNotify", "cool_fx", user);
  util::setclientsysstate("levelNotify", "ae1", user);
}

function_96e88318(str_notify) {
  self.teleporting = 0;
  self.s_teleport = undefined;
}

function_c234a5ce() {
  self endoncallback(&function_4f5d4783, #"death");
  self val::set(#"teleport_exit", "ignoreme", 1);
  wait 1;
  self function_4f5d4783();
}

function_4f5d4783(str_notify) {
  self val::reset(#"teleport_exit", "ignoreme");
}

function_26ddb915() {
  foreach(player in level.players) {
    if(player.teleporting === 1) {
      return true;
    }
  }

  return false;
}

cooldown_portal_timer(e_user) {
  self endon(#"death", #"hash_3c91bf90cecbe758");
  e_user endon(#"death");

  if(!isDefined(self.a_e_users)) {
    self.a_e_users = [];
  } else if(!isarray(self.a_e_users)) {
    self.a_e_users = array(self.a_e_users);
  }

  self.a_e_users[self.a_e_users.size] = e_user;
  self function_cb7c6fc7(e_user, 0);
  wait 20;
  arrayremovevalue(self.a_e_users, e_user);
  self function_cb7c6fc7(e_user, 1);
  playsoundatposition(#"hash_1c870a3a31a2dcf9", self.origin);
}

function_cb7c6fc7(e_user, b_show = 1) {
  if(b_show) {
    e_user clientfield::set_to_player(self.script_noteworthy, 2);
    return;
  }

  e_user clientfield::set_to_player(self.script_noteworthy, 1);
}

function_7c7520a5(e_user) {
  e_user clientfield::set_to_player(self.script_noteworthy, 0);
}

function_fe50866d(target, portal_enter, portal_exit) {
  util::wait_network_frame();
  zombies = getaiarray();

  foreach(zombie in zombies) {
    if(zombie.favoriteenemy === target) {
      zombie thread function_9d689cc4(portal_enter, portal_exit);
    }
  }
}

function_d9e2dc1f() {
  portals = struct::get_array(self.target, "targetname");

  foreach(portal in portals) {
    if(portal.script_noteworthy === "zombie_pos") {
      return portal;
    }
  }
}

function_254e91a2() {
  portals = struct::get_array(self.target, "targetname");

  foreach(portal in portals) {
    if(portal.script_noteworthy === "player_pos") {
      return portal;
    }
  }
}

find_portal_destination(var_210b4680) {
  var_98ceafca = [];

  foreach(s_portal in level.a_s_portals) {
    if(self == s_portal) {
      continue;
    }

    if(!level.zones[s_portal.zone_name].is_enabled) {
      continue;
    }

    if(isDefined(var_210b4680) && s_portal.n_floor != var_210b4680) {
      continue;
    }

    if(!isDefined(var_98ceafca)) {
      var_98ceafca = [];
    } else if(!isarray(var_98ceafca)) {
      var_98ceafca = array(var_98ceafca);
    }

    var_98ceafca[var_98ceafca.size] = s_portal;
  }

  if(var_98ceafca.size > 0) {
    return array::random(var_98ceafca);
  }

  return self;
}

enable_zone_portals_init() {
  portal_zone_trig = getEntArray("portal_zone_trigs", "targetname");

  for(i = 0; i < portal_zone_trig.size; i++) {
    portal_zone_trig[i] thread enable_zone_portals();
  }
}

enable_zone_portals() {
  waitresult = self waittill(#"trigger");
  user = waitresult.activator;

  if((laststand::player_is_in_laststand() || zm_utility::is_player_valid(user)) && isDefined(self.script_noteworthy)) {
    level thread zm_zonemgr::enable_zone(self.script_noteworthy);
  }
}

function_e9848fa7() {
  var_84a6eef7 = undefined;
  var_9d761d98 = function_35babccd(self);
  var_ba7bf98e = [];

  foreach(s_portal in level.a_s_portals) {
    if(s_portal.n_floor == var_9d761d98) {
      if(!isDefined(var_ba7bf98e)) {
        var_ba7bf98e = [];
      } else if(!isarray(var_ba7bf98e)) {
        var_ba7bf98e = array(var_ba7bf98e);
      }

      var_ba7bf98e[var_ba7bf98e.size] = s_portal;
    }
  }

  if(var_ba7bf98e.size > 0) {
    if(isDefined(self.var_b940d6ea)) {
      var_4da60e8d = self.var_b940d6ea;
    } else {
      var_4da60e8d = self.origin;
    }

    var_2bb91264 = 1410065408;

    foreach(portal in var_ba7bf98e) {
      var_d9c76d4b = distancesquared(portal.origin, var_4da60e8d);

      if(var_d9c76d4b < var_2bb91264) {
        var_2bb91264 = var_d9c76d4b;
        var_84a6eef7 = portal;
      }
    }
  }

  return var_84a6eef7;
}

function_9d689cc4(portal, portal_exit) {
  self endoncallback(&function_2ef25d40, #"damage", #"death", #"cancel_teleport");

  if(!isDefined(portal)) {
    portal = self function_e9848fa7();

    if(!isDefined(portal)) {
      self.favoriteenemy = undefined;
      return;
    }
  }

  self.var_3f667178 = portal;
  self.var_693b80bb = self.b_ignore_cleanup;
  self.b_ignore_cleanup = 1;
  self thread function_554c780b();

  while(distancesquared(self.origin, portal.origin) > self.goalradius * self.goalradius) {
    wait 0.1;
  }

  self notify(#"reached_portal");
  self.var_3f667178 = undefined;

  if(!isDefined(portal_exit)) {
    if(!isDefined(self.favoriteenemy)) {
      self.favoriteenemy = zm_hms_util::function_3815943c();
    }

    if(!isDefined(self.favoriteenemy)) {
      self function_2ef25d40();
      return;
    }

    portal_exit = self.favoriteenemy function_e9848fa7();

    if(!isDefined(portal_exit)) {
      self.favoriteenemy = undefined;
      self function_2ef25d40();
      return;
    }
  }

  self thread function_71be28e1(self, portal, portal_exit);
}

function_2ef25d40(str_notify) {
  self notify(#"reached_portal");
  self.b_ignore_cleanup = self.var_693b80bb;
  self.var_3f667178 = undefined;
}

function_71be28e1(zombie, start_portal, end_portal) {
  self endon(#"death");
  playFX(level._effect[#"teleport_depart"], zombie.origin);
  playFX(level._effect[#"portal_origin"], start_portal.origin, (1, 0, 0), (0, 0, 1));
  playsoundatposition(#"evt_teleporter_out", zombie.origin);
  zombie function_1f034d46(end_portal.origin);
  zombie.b_ignore_cleanup = 1;
  zombie forceteleport(level.s_zombie_teleport_room.origin);
  zombie setentitypaused(1);
  wait 3;

  if(!isDefined(zombie)) {
    return;
  }

  end_target = end_portal.var_52a6f692[0];
  zombie setentitypaused(0);
  zombie forceteleport(end_portal.origin + anglesToForward(end_portal.angles) * randomfloatrange(0, 32), end_target.angles);
  zombie function_1f034d46();
  playFX(level._effect[#"teleport_arrive"], zombie.origin);
  playFX(level._effect[#"portal_dest"], end_portal.origin, (1, 0, 0), (0, 0, 1));
  playsoundatposition(#"evt_teleporter_go", zombie.origin);
  self.b_ignore_cleanup = self.var_693b80bb;
}

function_554c780b() {
  self endon(#"death", #"reached_portal");
  wait 2;
  self.b_ignore_cleanup = self.var_693b80bb;
}

function_1f034d46(destination) {
  self.var_b940d6ea = destination;

  if(isDefined(self.var_b940d6ea)) {
    self.var_f4bf0819 = undefined;
    return;
  }

  self.var_f4bf0819 = undefined;
}

setup_portals() {
  a_s_portals = struct::get_array("white_portal");

  foreach(s_portal in a_s_portals) {
    s_portal portal_init();
  }

  level.s_portal_yellow_backyard = struct::get("PORTAL_YELLOW_BACKYARD", "script_noteworthy");
  level.s_portal_yellow_house = struct::get("PORTAL_YELLOW_HOUSE", "script_noteworthy");
  level.s_portal_red_house = struct::get("PORTAL_RED_HOUSE", "script_noteworthy");
  level.s_portal_green_house = struct::get("PORTAL_GREEN_HOUSE", "script_noteworthy");
  level.s_portal_green_backyard = struct::get("PORTAL_GREEN_BACKYARD", "script_noteworthy");
  level.s_portal_street_mid = struct::get("PORTAL_STREET_MID", "script_noteworthy");
  level.s_portal_street_start = struct::get("PORTAL_STREET_START", "script_noteworthy");
  level.s_portal_prisoner_holding = struct::get("PORTAL_PRISONER_HOLDING", "script_noteworthy");
  level.s_portal_operations = struct::get("PORTAL_OPERATIONS", "script_noteworthy");
  level.s_portal_transfusion_facility = struct::get("PORTAL_TRANSFUSION_FACILITY", "script_noteworthy");
  level.s_portal_apd_interrogation = struct::get("PORTAL_APD_INTERROGATION", "script_noteworthy");
  level.s_portal_diner = struct::get("PORTAL_DINER", "script_noteworthy");
  level.s_portal_beds = struct::get("PORTAL_BEDS", "script_noteworthy");
  level.s_portal_lounge = struct::get("PORTAL_LOUNGE", "script_noteworthy");
  level.s_portal_power = struct::get("PORTAL_POWER", "script_noteworthy");
  level.s_portal_storage = struct::get("PORTAL_STORAGE", "script_noteworthy");
  function_ea199c46();
  function_a6bb56f6();
}

portal_init() {
  if(!isDefined(level.a_s_portals)) {
    level.a_s_portals = [];
  } else if(!isarray(level.a_s_portals)) {
    level.a_s_portals = array(level.a_s_portals);
  }

  self.var_a1cf77d2 = util::spawn_model("tag_origin", self.origin, self.angles);

  if(!isDefined(self.a_e_users)) {
    self.a_e_users = [];
  } else if(!isarray(self.a_e_users)) {
    self.a_e_users = array(self.a_e_users);
  }

  self.zone_name = zm_zonemgr::get_zone_from_position(self.origin, 1);
  self.var_d5ea18bf = array("PORTAL_YELLOW_BACKYARD", "PORTAL_YELLOW_HOUSE", "PORTAL_RED_HOUSE", "PORTAL_GREEN_HOUSE", "PORTAL_GREEN_BACKYARD", "PORTAL_STREET_MID", "PORTAL_STREET_START", "PORTAL_PRISONER_HOLDING", "PORTAL_OPERATIONS", "PORTAL_TRANSFUSION_FACILITY", "PORTAL_APD_INTERROGATION", "PORTAL_DINER", "PORTAL_BEDS", "PORTAL_LOUNGE", "PORTAL_POWER", "PORTAL_STORAGE");

  if(self.script_noteworthy === "PORTAL_POWER") {
    self.var_d99a94d9 = 5;
  } else {
    self.var_d99a94d9 = 14;
  }

  self.var_52a6f692 = zm_hms_util::function_2719d4c0(self.target, "targetname", "script_int");
  var_c60b7f6d = getEntArray(self.target, "targetname");

  foreach(e in var_c60b7f6d) {
    if(e.script_noteworthy === "model") {
      self.e_model = e;
      continue;
    }

    if(e.script_noteworthy === "info_volume") {
      self.e_volume = e;
    }
  }

  switch (self.script_noteworthy) {
    case #"portal_yellow_backyard":
      self.var_7b89ada3 = 0;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_yellow_house":
      self.var_7b89ada3 = 1;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_red_house":
      self.var_7b89ada3 = 2;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_green_house":
      self.var_7b89ada3 = 3;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_green_backyard":
      self.var_7b89ada3 = 4;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_street_mid":
      self.var_7b89ada3 = 5;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_street_start":
      self.var_7b89ada3 = 6;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_prisoner_holding":
      self.var_7b89ada3 = 7;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_operations":
      self.var_7b89ada3 = 8;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_transfusion_facility":
      self.var_7b89ada3 = 9;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_apd_interrogation":
      self.var_7b89ada3 = 10;
      self.n_floor = 1;
      self.e_model hide();
      break;
    case #"portal_diner":
      self.var_7b89ada3 = 11;
      self.n_floor = 2;
      self.e_model hide();
      break;
    case #"portal_beds":
      self.var_7b89ada3 = 12;
      self.n_floor = 2;
      self.e_model hide();
      break;
    case #"portal_lounge":
      self.var_7b89ada3 = 13;
      self.n_floor = 2;
      self.e_model hide();
      break;
    case #"portal_power":
      self.var_7b89ada3 = 14;
      self.n_floor = 2;
      self.e_model hide();
      break;
    case #"portal_storage":
      self.var_7b89ada3 = 15;
      self.n_floor = 2;
      self.e_model hide();
      break;
  }

  self.b_active = 0;
  self.b_placed = 0;
  self.b_locked = 0;
}

function_688df525() {
  a_s_portals = struct::get_array("white_portal");
  a_s_active = [];

  foreach(s_portal in a_s_portals) {
    if(s_portal.b_placed) {
      if(!isDefined(a_s_active)) {
        a_s_active = [];
      } else if(!isarray(a_s_active)) {
        a_s_active = array(a_s_active);
      }

      a_s_active[a_s_active.size] = s_portal;
    }
  }

  return a_s_active;
}

function_a09d62f1() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"trigger_activated");
    e_user = waitresult.e_who;

    if(level.var_868c98df > 0 && !self.b_placed) {
      if(zm_utility::is_player_valid(e_user) && math::cointoss()) {
        e_user thread zm_hms_util::function_51b752a9(#"hash_7832a05d73569401");
      }

      level.var_868c98df--;
      self.b_active = 1;
      self.b_placed = 1;

      if(isDefined(self.e_model)) {
        self.e_model show();
        playsoundatposition(#"hash_d8a6518e5c2027d", self.e_model.origin + (0, 0, 20));
      }

      level.a_s_active = function_688df525();

      if(level.var_868c98df == 0) {
        level.a_s_active[0].n_dest = level.a_s_active[1].var_7b89ada3;
        level.a_s_active[1].n_dest = level.a_s_active[0].var_7b89ada3;
        level.a_s_active[0] thread reenable_teleporter();
        level.a_s_active[1] thread reenable_teleporter();
      }

      foreach(s_portal in level.a_s_active) {
        level thread function_3566160b(s_portal.script_noteworthy, 1);
      }
    } else if(self.b_placed && !self.b_locked && !function_26ddb915()) {
      level.a_s_active = function_688df525();
      level.var_868c98df++;
      self.b_active = 0;
      self.b_placed = 0;

      if(isDefined(self.e_model)) {
        self.e_model hide();
        playsoundatposition(#"hash_59436c2037092176", self.e_model.origin + (0, 0, 20));
      }

      if(level.var_868c98df == 1) {
        foreach(s_active in level.a_s_active) {
          s_active disable_teleporter();
        }
      }

      level thread function_3566160b(self.script_noteworthy, 0);
    }

    switch (level.var_868c98df) {
      case 0:
        zm_ui_inventory::function_7df6bb60("teleporter_pad_1", 0);
        zm_ui_inventory::function_7df6bb60("teleporter_pad_2", 0);
        break;
      case 1:
        zm_ui_inventory::function_7df6bb60("teleporter_pad_1", 0);
        zm_ui_inventory::function_7df6bb60("teleporter_pad_2", 1);
        break;
      case 2:
        zm_ui_inventory::function_7df6bb60("teleporter_pad_1", 1);
        zm_ui_inventory::function_7df6bb60("teleporter_pad_2", 1);
        break;
      default:

        iprintlnbold("<dev string:x38>");

          break;
    }
  }
}

portal_ready() {
  if(!zm_utility::is_standard()) {
    self zm_unitrigger::create(&function_99407d66, 128);
    self thread function_a09d62f1();
  }
}

function_97d4ad50() {
  self zm_unitrigger::create(&function_99407d66, 128);
}

function_99407d66(e_player) {
  if(e_player zm_utility::is_drinking()) {
    self sethintstring("");
    return 0;
  }

  if(self.stub.related_parent.b_active === 0 && level.var_868c98df === 0) {
    self sethintstring(#"hash_5fb23a325b41e010");
    return 1;
  }

  if(self.stub.related_parent.b_active === 1) {
    if(function_26ddb915()) {
      self sethintstring(#"hash_79fc5d02a880a44b");
      return 1;
    } else if(self.stub.related_parent.b_locked === 1) {
      self sethintstring(#"hash_4a621c0c0f51fef9");
      return 1;
    } else if(function_8b1a219a()) {
      self sethintstring(#"hash_57249497bfb88a5");
      return 1;
    } else {
      self sethintstring(#"hash_6801c3df1d9b2a37");
      return 1;
    }

    return;
  }

  if(function_8b1a219a()) {
    self sethintstring(#"hash_57748c9a86bf5e92");
    return 1;
  }

  self sethintstring(#"hash_45755e67c1efbdb6");
  return 1;
}

function_360c6be0() {
  self endon(#"death");

  while(self.b_active) {
    e_user = undefined;

    while(self.b_active && !isDefined(e_user)) {
      foreach(player in level.players) {
        if(isalive(player) && player istouching(self.e_volume)) {
          e_user = player;
        }
      }

      waitframe(1);
    }

    if(array::contains(self.a_e_users, e_user) || isDefined(self.var_cd2f1fed) && self.var_cd2f1fed) {
      continue;
    }

    if(zm_utility::is_player_valid(e_user, 0, 1)) {
      self thread teleport_player(e_user);
    }
  }
}

function_a54a70b3() {
  self endon(#"death");
  self.b_locked = 1;

  for(time = 0; time < 20; time++) {
    wait 1;
  }

  self.b_locked = 0;
}

portal_activate() {
  level.a_s_portals[self.script_noteworthy] = self;
  self function_98cd139();
}

function_ea199c46() {
  level endon(#"game_end");
  a_s_portals = struct::get_array("white_portal");
  level waittill(#"power_on1");
  exploder::exploder("fxexp_power_on");

  for(i = 0; i < a_s_portals.size; i++) {
    a_s_portals[i] portal_activate();
    a_s_portals[i] portal_ready();
  }

  level flag::set(#"portals_active");
  level clientfield::set("portal_maps_initialize_lights", 1);
}

function_79e8b4c6(var_9dff0a2b) {
  self.n_dest = var_9dff0a2b;
}

function_98cd139() {
  self function_79e8b4c6(self.var_d5ea18bf[self.var_d99a94d9]);
}

function_134670b9(n_delay) {
  if(isDefined(self.var_9f43786e)) {
    self.var_9f43786e += n_delay;
  }
}

function_a6bb56f6() {
  foreach(s_portal in level.a_s_portals) {
    s_portal disable_teleporter();
  }
}

function_3566160b(str_location, n_newval) {
  str_clientfield = "";

  switch (str_location) {
    case #"portal_yellow_house":
      str_clientfield = "portal_map_indicator_yellow_house";
      break;
    case #"portal_red_house":
      str_clientfield = "portal_map_indicator_red_house";
      break;
    case #"portal_green_backyard":
      str_clientfield = "portal_map_indicator_green_house_backyard";
      break;
    case #"portal_street_mid":
      str_clientfield = "portal_map_indicator_street_middle";
      break;
    case #"portal_prisoner_holding":
      str_clientfield = "portal_map_indicator_prisoner_holding";
      break;
    case #"portal_transfusion_facility":
      str_clientfield = "portal_map_indicator_transfusion_facility";
      break;
    case #"portal_diner":
      str_clientfield = "portal_map_indicator_diner";
      break;
    case #"portal_beds":
      str_clientfield = "portal_map_indicator_beds";
      break;
    case #"portal_power":
      str_clientfield = "portal_map_indicator_power";
      break;
    case #"portal_storage":
      str_clientfield = "portal_map_indicator_storage";
      break;
  }

  self clientfield::set(str_clientfield, n_newval);
}

disable_teleporter() {
  self.var_cd2f1fed = 1;
  self notify(#"hash_3c91bf90cecbe758");
  self.a_e_users = [];

  foreach(e_player in getplayers()) {
    self function_7c7520a5(e_player);
  }
}

reenable_teleporter(var_1e62b431 = 1) {
  self.var_cd2f1fed = 0;
  self thread function_a54a70b3();

  if(level flag::get(#"hash_1478cafcd626c361") && !level flag::get(#"circuit_step_complete")) {
    var_1e62b431 = 0;
  }

  if(var_1e62b431) {
    self thread function_360c6be0();

    foreach(e_player in getplayers()) {
      self function_cb7c6fc7(e_player, 1);
    }
  }
}

on_player_spawn() {
  if(level flag::get(#"portals_active")) {
    foreach(s_portal in level.a_s_portals) {
      if(s_portal.b_active) {
        s_portal function_cb7c6fc7(self, 1);
      }
    }
  }
}

function_35babccd(ent) {
  if(isDefined(ent.var_f4bf0819)) {
    ent.floor_num = ent.var_f4bf0819;
    return ent.floor_num;
  }

  if(!isDefined(ent.floor_num)) {
    ent.floor_num = 1;
  }

  index = ent.floor_num - 1;
  floor_count = level.var_b4fcac11.size;

  for(n = 0; n < floor_count; n++) {
    if(ent istouching(level.var_b4fcac11[index])) {
      ent.floor_num = index + 1;
      return ent.floor_num;
    }

    index = (index + 1) % floor_count;
  }

  println("<dev string:x61>");
  return ent.floor_num;
}

function_5c2807fc() {
  level.var_868c98df = 0;
  a_s_portals = struct::get_array("white_portal");

  foreach(s_portal in a_s_portals) {
    s_portal thread disable_teleporter();
    s_portal.b_active = 0;

    if(isDefined(s_portal.s_unitrigger)) {
      zm_unitrigger::unregister_unitrigger(s_portal.s_unitrigger);
    }
  }
}