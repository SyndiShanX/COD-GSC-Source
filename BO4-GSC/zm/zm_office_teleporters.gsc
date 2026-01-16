/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_office_teleporters.gsc
***********************************************/

#include script_4bae07eadc57bb51;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_office_defcon;
#include scripts\zm\zm_office_floors;
#include scripts\zm_common\zm_fasttravel;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_office_teleporters;

autoexec __init__system__() {
  system::register(#"zm_office_teleporters", &__init__, &__main__, undefined);
}

__init__() {
  init_clientfields();
  callback::on_spawned(&on_player_spawn);
}

__main__() {
  level thread teleporter_power_cable();
  level thread function_e1bfdf45();
  level thread open_portal_rooms();
  level thread function_93530fe9();
  level.var_f0ff37fe = struct::get_array("conference_level2_spawns", "targetname");
  level.pack_room_trigger = getent("pack_room_trigger", "targetname");
  level.pack_door_slam = getent("slam_pack_door", "targetname");
}

init_clientfields() {
  clientfield::register("scriptmover", "portal_dest_fx", 1, 3, "int");
  clientfield::register("toplayer", "portal_conference_level1", 1, 1, "int");
  clientfield::register("toplayer", "portal_offices_level1", 1, 1, "int");
  clientfield::register("toplayer", "portal_war_room", 1, 1, "int");
  clientfield::register("toplayer", "portal_war_room_server_room", 1, 1, "int");
  clientfield::register("toplayer", "portal_war_room_map", 1, 1, "int");
  clientfield::register("toplayer", "portal_panic_room", 1, 1, "int");
  clientfield::register("toplayer", "portal_labs_power_room", 1, 1, "int");
  clientfield::register("toplayer", "portal_labs_hall1_east", 1, 1, "int");
  clientfield::register("toplayer", "portal_labs_hall1_west", 1, 1, "int");
  clientfield::register("toplayer", "portal_labs_hall2_east", 1, 1, "int");
  clientfield::register("toplayer", "portal_labs_hall2_west", 1, 1, "int");
  clientfield::register("world", "delete_war_room_portal_fx", 1, 1, "counter");
  clientfield::register("scriptmover", "cage_portal_fx", 1, 1, "int");
  clientfield::register("actor", "crawler_portal_spawn_fx", 1, 1, "counter");
  clientfield::register("toplayer", "teleporter_transition", 1, 1, "counter");
  clientfield::register("scriptmover", "war_room_map_control", 1, 1, "int");
}

function_93530fe9() {
  var_89b4f417 = getent("warroom_map_opaque", "script_noteworthy");
  var_89b4f417 show();
  var_5485b418 = getent("warroom_map_transp", "script_noteworthy");
  var_5485b418 hide();
}

function_884a609e() {
  var_89b4f417 = getent("warroom_map_opaque", "script_noteworthy");
  var_89b4f417 hide();
  var_5485b418 = getent("warroom_map_transp", "script_noteworthy");
  var_5485b418 show();
  waitframe(1);
  var_5485b418 clientfield::set("war_room_map_control", 1);
}

teleporter_init() {
  level.teleport_ae_funcs = [];
  level flag::init(#"portals_active");
  level thread setup_portals();
  poi1 = getent("pack_room_poi1", "targetname");
  poi2 = getent("pack_room_poi2", "targetname");
  poi1 zm_utility::create_zombie_point_of_interest(undefined, 30, 0, 0);
  poi1 zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 128);
  poi2 zm_utility::create_zombie_point_of_interest(undefined, 30, 0, 0);
  poi2 zm_utility::create_zombie_point_of_interest_attractor_positions(undefined, undefined, 128);
  level.s_zombie_teleport_room = struct::get("zombie_teleport_room", "targetname");
}

function_e1bfdf45() {
  level.portal_pack = undefined;
  level.portal_power = undefined;
  level.portal_top = [];
  level.portal_mid = [];
  level.portal_bottom = [];
  pos = struct::get_array("zombie_pos", "script_noteworthy");

  for(i = 0; i < pos.size; i++) {
    if(pos[i].script_string == "bottom_floor_5") {
      level.portal_power = pos[i];
      continue;
    }

    if(pos[i].script_string == "top_floor_1") {
      level.portal_top[0] = pos[i];
      continue;
    }

    if(pos[i].script_string == "top_floor_2") {
      level.portal_top[1] = pos[i];
      continue;
    }

    if(pos[i].script_string == "mid_floor_1") {
      level.portal_mid[0] = pos[i];
      continue;
    }

    if(pos[i].script_string == "server_room") {
      level.portal_mid[1] = pos[i];
      continue;
    }

    if(pos[i].script_string == "mid_floor_2") {
      level.portal_pack = pos[i];
      continue;
    }

    if(pos[i].script_string == "bottom_floor_1") {
      level.portal_bottom[0] = pos[i];
      continue;
    }

    if(pos[i].script_string == "bottom_floor_2") {
      level.portal_bottom[1] = pos[i];
      continue;
    }

    if(pos[i].script_string == "bottom_floor_3") {
      level.portal_bottom[2] = pos[i];
      continue;
    }

    if(pos[i].script_string == "bottom_floor_4") {
      level.portal_bottom[3] = pos[i];
      continue;
    }

    if(pos[i].script_string == "bottom_floor_4") {
      level.portal_bottom[3] = pos[i];
    }
  }

  level.var_8d796689 = array(level.portal_bottom[0], level.portal_bottom[1], level.portal_bottom[2], level.portal_bottom[3], level.portal_power);
}

function_2113985() {
  level.portal_trig = getEntArray("portal_trigs", "targetname");

  foreach(e_portal in level.portal_trig) {
    e_portal teleport_pad_init();
  }
}

teleport_pad_init() {
  self.active = 1;
  self.portal_used = [];
  s_zombie_pos = self function_d9e2dc1f();
  self.fx_pos = s_zombie_pos.origin;
  self thread player_teleporting();
}

function_9b917fd5(is_powered) {
  if(self.script_string === "pap_hideaway") {
    level.pap_machine = self;
  }

  self zm_pack_a_punch::set_state_hidden();
  level waittill(#"hash_537cc10c9deca9da");
  self zm_pack_a_punch::function_bb629351(1);
}

player_teleporting() {
  self endon(#"death");
  user = undefined;

  while(true) {
    waitresult = self waittill(#"trigger");
    user = waitresult.activator;
    player_used = 0;

    if(isDefined(self.portal_used)) {
      for(i = 0; i < self.portal_used.size; i++) {
        if(self.portal_used[i] == user) {
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

  if(isDefined(user.teleporting) && user.teleporting) {
    return;
  }

  w_curr = user getcurrentweapon();

  if(isDefined(w_curr.isburstfire) && w_curr.isburstfire && user isfiring() && !user ismeleeing()) {
    return;
  }

  user notify(#"teleporting");
  self notify(#"portal_used");
  level notify(#"portal_used", {
    #s_portal: self, 
    #player: user
  });
  user.teleporting = 1;
  user clientfield::increment_to_player("teleporter_transition", 1);

  switch (self.n_dest) {
    case 0:
      var_298e4578 = self find_portal_destination();
      break;
    case 1:
      var_298e4578 = level.a_s_portals[#"portal_panic_room"];
      break;
    case 2:
      var_298e4578 = level.var_3f3c65c7;
      level notify(#"hash_15a9f7117b9637b");
      break;
    case 3:
      var_298e4578 = level.a_s_portals[#"portal_war_room_map"];
      break;
    case 4:
      var_298e4578 = self find_portal_destination(1);
      break;
    case 5:
      var_298e4578 = self find_portal_destination(2);
      break;
    case 6:
      var_298e4578 = self find_portal_destination(3);
      break;
  }

  destination = var_298e4578.var_52a6f692;
  playFX(level._effect[#"teleport_depart"], user.origin);
  playFX(level._effect[#"portal_origin"], self.origin, (1, 0, 0), (0, 0, 1));
  playsoundatposition(#"evt_teleporter_out", self.origin);
  level thread function_fe50866d(user, self, var_298e4578);
  user.var_298e4578 = var_298e4578;
  self function_134670b9(1);
  user zm_fasttravel::function_66d020b0(undefined, undefined, undefined, undefined, destination, undefined, string(self.n_dest), 0);

  if(var_298e4578.script_noteworthy == "portal_panic_room") {
    level thread zm_office_defcon::start_defcon_countdown();
  }

  user clientfield::increment_to_player("teleporter_transition", 1);
  var_298e4578 thread cooldown_portal_timer(user);
  user thread function_c234a5ce();
  playFX(level._effect[#"teleport_arrive"], user.origin);
  playFX(level._effect[#"portal_dest"], var_298e4578.origin, (1, 0, 0), (0, 0, 1));
  playsoundatposition(#"evt_teleporter_go", var_298e4578.origin);
  user playsoundtoplayer(#"hash_39876bf613387fef", user);
  wait 0.5;
  user function_96e88318();
  util::setclientsysstate("levelNotify", "cool_fx", user);
  util::setclientsysstate("levelNotify", "ae1", user);
  wait 1.25;

  if(level flag::get("dog_round")) {
    util::setclientsysstate("levelNotify", "vis4", user);
    return;
  }

  user.floor = zm_office_floors::function_35babccd(user);
  util::setclientsysstate("levelNotify", "vis" + user.floor, user);
}

function_96e88318(str_notify) {
  self.var_298e4578 = undefined;
  self.teleporting = 0;
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

cooldown_portal_timer(e_user) {
  if(self.script_noteworthy == "portal_cage_enter") {
    return;
  }

  self endon(#"death", #"hash_3c91bf90cecbe758");

  if(!isDefined(self.a_e_users)) {
    self.a_e_users = [];
  } else if(!isarray(self.a_e_users)) {
    self.a_e_users = array(self.a_e_users);
  }

  self.a_e_users[self.a_e_users.size] = e_user;
  self function_cb7c6fc7(e_user, 0);

  for(time = 0; !level flag::get("defcon_active") && time < 20 || time < 2; time++) {
    wait 1;
  }

  arrayremovevalue(self.a_e_users, e_user);
  self function_cb7c6fc7(e_user, 1);
}

function_cb7c6fc7(e_user, b_show = 1) {
  if(!isDefined(e_user)) {
    return;
  }

  if(b_show) {
    e_user clientfield::set_to_player(self.script_noteworthy, 1);
    return;
  }

  e_user clientfield::set_to_player(self.script_noteworthy, 0);
}

function_fe50866d(target, portal_enter, portal_exit) {
  if(portal_exit.script_noteworthy == "portal_panic_room" || portal_exit.script_noteworthy == "portal_cage_enter") {
    return;
  }

  if(isDefined(level.s_cage_portal) && portal_enter == level.s_cage_portal) {
    return;
  }

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

    if(s_portal.script_noteworthy == "portal_panic_room") {
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

open_portal_rooms() {
  yellow_conf_screen = getent("yellow_conf_screen", "targetname");
  power_room_screen = getent("power_room_screen", "targetname");
  war_room_screen_ramp = getent("war_room_screen_ramp", "targetname");
  war_room_screen_north = getent("war_room_screen_north", "targetname");
  war_room_screen_south = getent("war_room_screen_south", "targetname");
  server_room_portal_door = getent("server_room_portal_door", "targetname");
  yellow_conf_screen disconnectpaths();
  power_room_screen disconnectpaths();
  war_room_screen_north disconnectpaths();
  war_room_screen_south disconnectpaths();
  server_room_portal_door disconnectpaths();
  level waittill(#"hash_2124984d1ece329c");
  power_room_screen playSound("evt_teleporter_door_short");
  power_room_screen movez(116, 1.5);
  power_room_screen thread function_4d547f18();
  war_room_screen_north playSound("evt_teleporter_door_short");
  war_room_screen_north movez(-122, 1.5);
  war_room_screen_ramp movey(46, 1.5);
  war_room_screen_north thread function_4d547f18();
  war_room_screen_south playSound("evt_teleporter_door_short");
  war_room_screen_south movez(-120, 1.5);
  war_room_screen_south thread function_4d547f18();
  level waittill(#"hash_21249b4d1ece37b5");
  level thread function_3e7ccc56();
  server_room_portal_door playSound("evt_teleporter_door_long");
  server_room_portal_door movez(-150, 2);
  server_room_portal_door thread function_4d547f18();
}

function_3e7ccc56() {
  yellow_conf_screen = getent("yellow_conf_screen", "targetname");
  yellow_conf_screen_parts = getEntArray("yellow_conf_screen_part", "script_noteworthy");

  foreach(part in yellow_conf_screen_parts) {
    part linkto(yellow_conf_screen);
  }

  yellow_conf_screen playSound("evt_teleporter_door_short");
  yellow_conf_screen movex(8, 0.2);
  yellow_conf_screen waittill(#"movedone");
  yellow_conf_screen movez(116, 1.5);
  yellow_conf_screen thread function_4d547f18();
}

war_room_portal_door() {
  war_room_screen_south = getent("war_room_screen_south", "targetname");
  war_room_screen_south playSound("evt_teleporter_door_short");
  war_room_screen_south movez(-120, 1.5);
  war_room_screen_south thread function_4d547f18();
}

function_4d547f18() {
  self endon(#"death");
  self waittill(#"movedone");
  self connectpaths();
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

teleporter_power_cable() {
  cable_on = getEntArray("teleporter_link_cable_on", "targetname");
  cable_off = getEntArray("teleporter_link_cable_off", "targetname");

  foreach(cable in cable_on) {
    cable hide();
  }

  level waittill(#"hash_2124984d1ece329c");

  foreach(cable in cable_off) {
    cable hide();
  }

  foreach(cable in cable_on) {
    cable show();
  }
}

function_e9848fa7() {
  var_84a6eef7 = undefined;
  var_9d761d98 = zm_office_floors::function_35babccd(self);
  test_portals = [];

  foreach(s_portal in level.a_s_portals) {
    if(s_portal.n_floor == var_9d761d98) {
      if(!isDefined(test_portals)) {
        test_portals = [];
      } else if(!isarray(test_portals)) {
        test_portals = array(test_portals);
      }

      test_portals[test_portals.size] = s_portal;
    }
  }

  if(test_portals.size > 0) {
    if(isDefined(self.var_b940d6ea)) {
      test_pos = self.var_b940d6ea;
    } else {
      test_pos = self.origin;
    }

    var_2bb91264 = 1410065408;

    foreach(portal in test_portals) {
      var_d9c76d4b = distancesquared(portal.origin, test_pos);

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

  level thread function_71be28e1(self, portal, portal_exit);
}

function_2ef25d40(str_notify) {
  self notify(#"reached_portal");
  self.b_ignore_cleanup = self.var_693b80bb;
  self.var_3f667178 = undefined;
}

function_71be28e1(zombie, start_portal, end_portal) {
  zombie endon(#"death");
  zombie disableaimassist();
  playFX(level._effect[#"teleport_depart"], zombie.origin);
  playFX(level._effect[#"portal_origin"], start_portal.origin, (1, 0, 0), (0, 0, 1));
  playsoundatposition(#"evt_teleporter_out", zombie.origin);
  zombie function_1f034d46(end_portal.origin);
  zombie.b_ignore_cleanup = 1;
  zombie forceteleport(level.s_zombie_teleport_room.origin);
  zombie setentitypaused(1);
  wait 3;
  end_target = end_portal.var_52a6f692[0];
  zombie setentitypaused(0);
  zombie forceteleport(end_portal.origin + anglesToForward(end_portal.angles) * randomfloatrange(0, 32), end_target.angles);
  zombie function_1f034d46();
  playFX(level._effect[#"teleport_arrive"], zombie.origin);
  playFX(level._effect[#"portal_dest"], end_portal.origin, (1, 0, 0), (0, 0, 1));
  playsoundatposition(#"evt_teleporter_go", zombie.origin);
  zombie.b_ignore_cleanup = zombie.var_693b80bb;
  zombie enableaimassist();
}

function_554c780b() {
  self endon(#"death", #"reached_portal");
  wait 2;
  self.b_ignore_cleanup = self.var_693b80bb;
}

function_1f034d46(destination) {
  self.var_b940d6ea = destination;

  if(isDefined(self.var_b940d6ea)) {
    self.var_f4bf0819 = zm_office_floors::function_cd2f24b2(zm_zonemgr::get_zone_from_position(self.var_b940d6ea, 1));
    return;
  }

  self.var_f4bf0819 = undefined;
}

function_bb3f9afd() {
  s_portal = level.a_s_portals[#"portal_war_room"];
  playFX(level._effect[#"portal_despawn"], s_portal.origin, (1, 0, 0), (0, 0, 1));
  s_portal.var_a1cf77d2 clientfield::set("portal_dest_fx", 0);
  level clientfield::increment("delete_war_room_portal_fx", 1);
  zm_unitrigger::unregister_unitrigger(s_portal.s_unitrigger);
  arrayremoveindex(level.a_s_portals, "portal_war_room", 1);
  s_portal notify(#"hash_6db43858f08123dd");
  s_portal notify(#"hash_3c91bf90cecbe758");
  s_portal = level.var_905aea40;

  if(util::get_game_type() == #"zstandard") {
    s_portal.n_floor = -1;
  }

  level.a_s_portals[s_portal.script_noteworthy] = s_portal;
  s_portal zm_unitrigger::create("", 32, &portal_think, 0, 0);
  playFX(level._effect[#"portal_spawn"], s_portal.origin, (1, 0, 0), (0, 0, 1));

  if(level flag::get("defcon_active") || util::get_game_type() == #"zstandard") {
    s_portal function_79e8b4c6(2);
  } else {
    s_portal function_98cd139();
  }

  foreach(e_player in level.activeplayers) {
    s_portal function_cb7c6fc7(e_player, 1);
  }

  cage_portal_init();
}

setup_portals() {
  a_s_portals = struct::get_array("office_portal");

  foreach(s_portal in a_s_portals) {
    if(s_portal.script_noteworthy == "portal_war_room_map") {
      level.var_905aea40 = s_portal;
    }

    s_portal portal_init();
  }

  level.var_3f3c65c7 = struct::get("cage_enter_portal");
  level.var_3f3c65c7.var_52a6f692 = zm_hms_util::function_2719d4c0(level.var_3f3c65c7.target, "targetname", "script_int");
  level.var_3f3c65c7.var_a1cf77d2 = util::spawn_model("tag_origin", self.origin, self.angles);
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
  self.var_d5ea18bf = array(4);
  self thread function_bbc76ca9();
  self.var_d99a94d9 = 0;
  self.var_52a6f692 = zm_hms_util::function_2719d4c0(self.target, "targetname", "script_int");
  self thread function_45a968e4();

  switch (self.script_noteworthy) {
    case #"portal_conference_level1":
    case #"portal_offices_level1":
      self.n_floor = 1;
      break;
    case #"portal_war_room_server_room":
    case #"portal_panic_room":
    case #"portal_war_room":
    case #"portal_war_room_map":
      self.n_floor = 2;
      break;
    case #"portal_labs_power_room":
    case #"portal_labs_hall2_west":
    case #"portal_labs_hall1_east":
    case #"portal_labs_hall2_east":
    case #"portal_labs_hall1_west":
      self.n_floor = 3;
      break;
  }
}

function_bbc76ca9() {
  self endon(#"death");
  level flag::wait_till("war_room_stair");

  if(!isDefined(self.var_d5ea18bf)) {
    self.var_d5ea18bf = [];
  } else if(!isarray(self.var_d5ea18bf)) {
    self.var_d5ea18bf = array(self.var_d5ea18bf);
  }

  self.var_d5ea18bf[self.var_d5ea18bf.size] = 5;

  if(self.script_noteworthy != "portal_labs_power_room") {
    level flag::wait_till("labs_enabled");

    if(!isDefined(self.var_d5ea18bf)) {
      self.var_d5ea18bf = [];
    } else if(!isarray(self.var_d5ea18bf)) {
      self.var_d5ea18bf = array(self.var_d5ea18bf);
    }

    self.var_d5ea18bf[self.var_d5ea18bf.size] = 6;
  }
}

portal_think() {
  self endon(#"death");
  s_portal = self.stub.related_parent;

  while(true) {
    waitresult = self waittill(#"trigger");
    e_user = waitresult.activator;

    if(array::contains(s_portal.a_e_users, e_user) || isDefined(self.stub.related_parent.var_cd2f1fed) && self.stub.related_parent.var_cd2f1fed) {
      continue;
    }

    if(zm_utility::is_player_valid(e_user, 0, 1)) {
      s_portal thread teleport_player(e_user);
    }
  }
}

portal_activate() {
  level.a_s_portals[self.script_noteworthy] = self;

  if(self.script_noteworthy == "portal_war_room") {
    s_stub = self zm_unitrigger::function_a7620bfb(32, 0);
    zm_unitrigger::unitrigger_set_hint_string(s_stub, "");
    s_stub.related_parent = self;
    self.s_unitrigger = s_stub;
    zm_unitrigger::register_dyn_unitrigger(s_stub, &portal_think, 0);
  } else {
    self zm_unitrigger::create("", 32, &portal_think, 0, 0);
  }

  self function_98cd139();

  foreach(e_player in level.activeplayers) {
    self function_cb7c6fc7(e_player, 1);
  }
}

function_ea199c46() {
  a_s_portals = struct::get_array("office_portal");
  level waittill(#"hash_2124984d1ece329c");

  for(i = 0; i < a_s_portals.size; i++) {
    if(a_s_portals[i].script_noteworthy != "portal_war_room_map") {
      a_s_portals[i] portal_activate();
    }

    if(i == 5) {
      level waittill(#"hash_21249b4d1ece37b5");
    }
  }

  level flag::set(#"portals_active");
}

function_79e8b4c6(var_9dff0a2b) {
  self.n_dest = var_9dff0a2b;

  switch (self.n_dest) {
    case 0:
      self.var_a1cf77d2 clientfield::set("portal_dest_fx", 1);
      break;
    case 1:
      self.var_a1cf77d2 clientfield::set("portal_dest_fx", 4);
      break;
    case 2:
      self.var_a1cf77d2 clientfield::set("portal_dest_fx", 5);
      break;
    case 4:
      self.var_a1cf77d2 clientfield::set("portal_dest_fx", 1);
      break;
    case 3:
    case 5:
      self.var_a1cf77d2 clientfield::set("portal_dest_fx", 2);
      break;
    case 6:
      self.var_a1cf77d2 clientfield::set("portal_dest_fx", 3);
      break;
  }
}

function_98cd139() {
  self function_79e8b4c6(self.var_d5ea18bf[self.var_d99a94d9]);
}

function_63283830() {
  if(isDefined(self.n_dest) && (self.n_dest == 4 || self.n_dest == 5 || self.n_dest == 6)) {
    self.var_d99a94d9++;

    if(self.var_d99a94d9 == self.var_d5ea18bf.size) {
      self.var_d99a94d9 = 0;
    }

    self function_98cd139();
  }
}

function_45a968e4() {
  self endon(#"death", #"hash_6db43858f08123dd");

  if(zm_utility::is_standard()) {
    n_cycle_time = 3;
  } else {
    n_cycle_time = 5;
  }

  while(true) {
    self.var_9f43786e = n_cycle_time;

    while(self.var_9f43786e > 0) {
      wait 1;
      self.var_9f43786e--;
    }

    self function_63283830();
  }
}

function_134670b9(n_delay) {
  if(isDefined(self.var_9f43786e)) {
    self.var_9f43786e += n_delay;
  }
}

function_c71dfad1(b_enable = 1) {
  foreach(s_portal in level.a_s_portals) {
    if(s_portal.script_noteworthy == "portal_panic_room") {
      continue;
    }

    if(b_enable) {
      if(s_portal.script_noteworthy == "portal_war_room_map") {
        s_portal function_79e8b4c6(2);
      } else {
        s_portal function_79e8b4c6(1);
      }

      continue;
    }

    s_portal function_98cd139();
  }
}

cage_portal_init() {
  level.s_cage_portal = struct::get("cage_portal");
  level.s_cage_portal.var_a1cf77d2 = util::spawn_model("tag_origin", level.s_cage_portal.origin, level.s_cage_portal.angles);
  level.s_cage_portal.n_dest = 3;
  level.var_a23b5c5 = getent("cage_portal_blocker", "targetname");
  level.var_a23b5c5.v_start_pos = level.var_a23b5c5.origin;
  getent("bunker_gate", "targetname") linkto(level.var_a23b5c5);
  getent("bunker_gate_2", "targetname") linkto(level.var_a23b5c5);
  getent("bunker_gate_3", "targetname") linkto(level.var_a23b5c5);
}

enable_cage_portal(b_enable = 1) {
  if(self.b_active === b_enable) {
    return;
  }

  self.b_active = b_enable;

  if(self.b_active) {
    level.s_cage_portal zm_unitrigger::create("", 32, &portal_think, 0, 0);
    function_60abbae4(1);
    level.var_a23b5c5 playSound(#"hash_123af2d6dc30025a");
    level.var_a23b5c5 movez(150, 1);
    return;
  }

  zm_unitrigger::unregister_unitrigger(level.s_cage_portal.s_unitrigger);
  function_60abbae4(0);
}

function_1bf7bc9e() {
  self endon(#"death");
  wait 0.5;
  array::random(level.a_s_portals) teleport_player(self);
}

function_a6bb56f6() {
  foreach(s_portal in level.a_s_portals) {
    if(s_portal.script_noteworthy != "portal_war_room_map" || util::get_game_type() != #"zstandard") {
      s_portal.var_cd2f1fed = 1;
      s_portal notify(#"hash_3c91bf90cecbe758");
      s_portal.a_e_users = [];

      foreach(e_player in getplayers()) {
        s_portal function_cb7c6fc7(e_player, 0);
      }

      continue;
    }

    s_portal function_cb7c6fc7(e_player, 1);
  }
}

function_cc9b97b0() {
  foreach(s_portal in level.a_s_portals) {
    s_portal.var_cd2f1fed = 0;

    foreach(e_player in getplayers()) {
      s_portal function_cb7c6fc7(e_player, 1);
    }
  }
}

function_60abbae4(b_enable) {
  if(b_enable) {
    level.s_cage_portal.var_a1cf77d2 clientfield::set("cage_portal_fx", 1);
    return;
  }

  level.s_cage_portal.var_a1cf77d2 clientfield::set("cage_portal_fx", 0);
}

on_player_spawn() {
  if(level flag::get(#"portals_active")) {
    foreach(s_portal in level.a_s_portals) {
      s_portal function_cb7c6fc7(self, 1);
    }
  }
}

function_2143dc13() {
  a_e_players = getplayers();

  foreach(e_player in a_e_players) {
    if(e_player.var_298e4578 === level.a_s_portals[#"portal_panic_room"]) {
      return true;
    }
  }

  return false;
}