/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_theater_teleporter.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_theater_magic_box;
#namespace zm_theater_teleporter;

function autoexec __init__sytem__() {
  system::register("zm_theater_teleporter", &__init__, undefined, undefined);
}

function __init__() {
  visionset_mgr::register_info("overlay", "zm_theater_teleport", 21000, 61, 1, 1);
  clientfield::register("scriptmover", "extra_screen", 21000, 1, "int");
  clientfield::register("scriptmover", "teleporter_fx", 21000, 1, "counter");
  clientfield::register("allplayers", "player_teleport_fx", 21000, 1, "counter");
  clientfield::register("scriptmover", "play_fly_me_to_the_moon_fx", 21000, 1, "int");
  clientfield::register("world", "teleporter_initiate_fx", 21000, 1, "counter");
  clientfield::register("scriptmover", "teleporter_link_cable_mtl", 21000, 1, "int");
  callback::on_spawned(&init_player);
}

function teleporter_init() {
  level.teleport = [];
  level.teleport_delay = 1.8;
  level.teleport_cost = 0;
  level.teleport_ae_funcs = [];
  level.eeroomsinuse = undefined;
  level.second_hand = getent("zom_clock_second_hand", "targetname");
  level.second_hand_angles = level.second_hand.angles;
  level.zombietheaterteleporterseeklogicfunc = &zombietheaterteleporterseeklogic;
  level flag::init("teleporter_linked");
  level flag::init("core_linked");
  setdvar("theaterAftereffectOverride", "-1");
  poi1 = getent("teleporter_poi1", "targetname");
  poi2 = getent("teleporter_poi2", "targetname");
  players = getplayers();
  if(players.size > 1) {
    poi1 zm_utility::create_zombie_point_of_interest(undefined, 30, 0, 0);
    poi2 zm_utility::create_zombie_point_of_interest(256, 15, 0, 0);
  } else {
    poi1 zm_utility::create_zombie_point_of_interest(undefined, 35, 100, 0);
    poi2 zm_utility::create_zombie_point_of_interest(256, 10, 0, 0);
  }
  poi1 thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, 45);
  poi2 thread zm_utility::create_zombie_point_of_interest_attractor_positions(4, 45);
  thread teleport_core_think(0);
  thread teleport_link_think();
  thread teleport_pad_think();
  thread theater_fly_me_to_the_moon_init();
  thread function_9272aa0();
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    util::setclientsysstate("levelNotify", "pack_clock_start", players[i]);
  }
  if(!issplitscreen()) {
    level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &teleport_aftereffect_fov;
  }
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &teleport_aftereffect_shellshock;
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &teleport_aftereffect_shellshock_electric;
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &teleport_aftereffect_bw_vision;
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &teleport_aftereffect_red_vision;
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &teleport_aftereffect_flashy_vision;
  level.teleport_ae_funcs[level.teleport_ae_funcs.size] = &teleport_aftereffect_flare_vision;
  scene::add_scene_func("p7_fxanim_zm_kino_wormhole_bundle", &function_d11d2c50, "play");
}

function init_player() {
  self.is_teleporting = 0;
  self.inteleportation = 0;
}

function function_9272aa0() {
  while(true) {
    level zombietheaterteleporterseeklogic();
    wait(0.05);
  }
}

function teleport_core_think(index) {
  trigger_name = "trigger_teleport_pad_" + index;
  active = 0;
  user = undefined;
  trigger = getent(trigger_name, "targetname");
  trigger setcursorhint("HINT_NOICON");
  trigger sethintstring("");
  exploder::exploder("teleporter_light_red");
  if(isDefined(trigger)) {
    while(!active) {
      level flag::wait_till("teleporter_linked");
      exploder::exploder("fxexp_200");
      exploder::kill_exploder("teleporter_light_red");
      exploder::exploder("teleporter_light_green");
      trigger sethintstring(&"ZM_THEATER_USE_TELEPORTER");
      trigger waittill("trigger", user);
      if(zombie_utility::is_player_valid(user) && user zm_score::can_player_purchase(level.teleport_cost)) {
        active = 1;
        exploder::kill_exploder("teleporter_light_green");
        exploder::exploder("teleporter_light_red");
        trigger sethintstring("");
        user zm_score::minus_to_player_score(level.teleport_cost);
        exploder::kill_exploder("fxexp_200");
        level clientfield::increment("teleporter_initiate_fx");
        trigger player_teleporting(index);
        level.var_4f3df77f clientfield::set("teleporter_link_cable_mtl", 0);
        trigger sethintstring(&"ZOMBIE_TELEPORT_COOLDOWN");
        wait(90);
        active = 0;
        exploder::delete_exploder_on_clients("fxexp_202");
        level flag::clear("teleporter_linked");
        level flag::clear("core_linked");
        exploder::kill_exploder("teleporter_light_red");
        exploder::exploder("teleporter_light_green");
      }
    }
  }
}

function teleport_link_think() {
  trigger_name = "trigger_teleport_pad_0";
  core = getent(trigger_name, "targetname");
  user = undefined;
  while(true) {
    if(!level flag::get("core_linked")) {
      core sethintstring(&"ZM_THEATER_LINK_CORE");
      core waittill("trigger", user);
      core playSound("evt_teleporter_activate_start");
      level flag::set("core_linked");
      core sethintstring("");
      pad = getent(core.target, "targetname");
      pad sethintstring(&"ZM_THEATER_LINK_PAD");
    }
    util::wait_network_frame();
  }
}

function teleport_pad_hide_use() {
  trigger_name = "trigger_teleport_pad_0";
  core = getent(trigger_name, "targetname");
  pad = getent(core.target, "targetname");
  pad setcursorhint("HINT_NOICON");
  level.var_4f3df77f = getent("teleporter_link_cable", "targetname");
  pad sethintstring(&"ZOMBIE_NEED_POWER");
  level flag::wait_till("power_on");
  pad sethintstring(&"ZM_THEATER_START_CORE");
}

function teleport_pad_think() {
  trigger_name = "trigger_teleport_pad_0";
  core = getent(trigger_name, "targetname");
  pad = getent(core.target, "targetname");
  user = undefined;
  while(true) {
    if(!level flag::get("teleporter_linked") && level flag::get("core_linked")) {
      pad waittill("trigger", user);
      pad sethintstring("");
      pad playSound("evt_teleporter_activate_finish");
      level flag::set("teleporter_linked");
      level.var_4f3df77f clientfield::set("teleporter_link_cable_mtl", 1);
    }
    util::wait_network_frame();
  }
}

function player_teleporting(index) {
  var_1bea176e = [];
  self thread teleport_pad_player_fx(undefined);
  self thread teleport_2d_audio();
  self thread teleport_nuke(undefined, 300);
  wait(level.teleport_delay);
  exploder::exploder("fxexp_202");
  self notify("fx_done");
  var_1bea176e = self teleport_players(var_1bea176e, "projroom");
  if(!isDefined(var_1bea176e) || (isDefined(var_1bea176e) && var_1bea176e.size < 1)) {
    return;
  }
  var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
  foreach(e_player in var_1bea176e) {
    e_player.var_35c3d096 = 1;
  }
  wait(30);
  var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
  level.extracam_screen clientfield::set("extra_screen", 0);
  if(randomint(100) > 24 && !isDefined(level.eeroomsinuse)) {
    loc = "eerooms";
    level.eeroomsinuse = 1;
    if(randomint(100) > 65) {
      level thread eeroom_powerup_drop();
    }
  } else {
    loc = "theater";
    exploder::exploder(301);
  }
  self thread teleport_pad_player_fx(var_1bea176e);
  self thread teleport_2d_audio_specialroom_start(var_1bea176e);
  wait(level.teleport_delay);
  var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
  self notify("fx_done");
  self thread teleport_2d_audio_specialroom_go(var_1bea176e);
  self teleport_players(var_1bea176e, loc);
  if(isDefined(loc) && loc == "eerooms") {
    loc = "theater";
    wait(4);
    var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
    self thread teleport_2d_audio_specialroom_start(var_1bea176e);
    exploder::exploder(301);
    self thread teleport_pad_player_fx(var_1bea176e);
    wait(level.teleport_delay);
    var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
    self notify("fx_done");
    self thread teleport_2d_audio_specialroom_go(var_1bea176e);
    self teleport_players(var_1bea176e, loc);
  }
}

function teleport_trigger_invisible(enable) {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i])) {
      self setinvisibletoplayer(players[i], enable);
    }
  }
}

function player_is_near_pad(player) {
  if(player istouching(self)) {
    return true;
  }
  return false;
}

function teleport_pad_player_fx(players) {
  self endon("fx_done");
  inprojroom = 0;
  if(!isDefined(players)) {
    players = getplayers();
  } else {
    inprojroom = 1;
  }
  while(true) {
    for(i = 0; i < players.size; i++) {
      if(isDefined(players[i])) {
        if(self player_is_near_pad(players[i]) || inprojroom) {
          continue;
        }
      }
    }
    wait(0.05);
  }
}

function function_1488cf91(e_player) {
  var_1de511b3 = getent("teleportation_area", "targetname");
  return isalive(e_player) && e_player.sessionstate !== "spectator" && e_player istouching(var_1de511b3);
}

function teleport_players(var_1bea176e, loc) {
  self endon("death");
  player_radius = 16;
  dest_room = [];
  all_players = level.players;
  slot = undefined;
  start = undefined;
  if(loc == "projroom") {
    players = all_players;
  } else {
    players = var_1bea176e;
  }
  dest_room = get_array_spots("teleport_room_", dest_room);
  initialize_occupied_flag(dest_room);
  check_for_occupied_spots(dest_room, all_players, player_radius);
  prone_offset = vectorscale((0, 0, 1), 49);
  crouch_offset = vectorscale((0, 0, 1), 20);
  stand_offset = (0, 0, 0);
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i])) {
      if(loc == "projroom" && self player_is_near_pad(players[i]) == 0) {
        continue;
      } else if(loc == "projroom" && self player_is_near_pad(players[i])) {
        array::add(var_1bea176e, players[i], 0);
      }
      players[i].is_teleporting = 1;
      players[i] clientfield::increment("player_teleport_fx");
      players[i] clientfield::set_to_player("player_dust_mote", 0);
      players[i] freezecontrols(1);
      players[i] disableweapons();
      players[i] disableoffhandweapons();
      util::wait_network_frame();
      slot = i;
      start = 0;
      while(dest_room[slot].occupied && start < 4) {
        start++;
        slot++;
        if(slot >= 4) {
          slot = 0;
        }
      }
      dest_room[slot].occupied = 1;
      players[i].inteleportation = 1;
      visionset_mgr::activate("overlay", "zm_theater_teleport", players[i]);
      if(players[i] getstance() == "prone") {
        desired_origin = dest_room[i].origin + prone_offset;
        desired_offset = prone_offset;
      } else {
        if(players[i] getstance() == "crouch") {
          desired_origin = dest_room[i].origin + crouch_offset;
          desired_offset = crouch_offset;
        } else {
          desired_origin = dest_room[i].origin + stand_offset;
          desired_offset = stand_offset;
        }
      }
      util::setclientsysstate("levelNotify", "black_box_start", players[i]);
      players[i] setorigin(dest_room[i].origin);
      players[i] setplayerangles(dest_room[i].angles);
      players[i].teleport_origin = spawn("script_origin", players[i].origin);
      players[i].teleport_origin.angles = players[i].angles;
      players[i] linkto(players[i].teleport_origin);
      players[i] thread function_7e0ed731(slot, desired_offset);
      players[i] playrumbleonentity("zm_castle_moon_explosion_rumble");
    }
  }
  if(!isDefined(var_1bea176e) || (isDefined(var_1bea176e) && var_1bea176e.size < 1)) {
    return;
  }
  wait(2);
  var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
  dest_room = [];
  if(loc == "projroom") {
    dest_room = get_array_spots("projroom_teleport_player", dest_room);
  } else {
    if(loc == "eerooms") {
      level.eeroomsinuse = 1;
      dest_room = get_array_spots("ee_teleport_player", dest_room);
    } else if(loc == "theater") {
      if(isDefined(self.target)) {
        ent = getent(self.target, "targetname");
        self thread teleport_nuke(undefined, 20);
      }
      dest_room = get_array_spots("theater_teleport_player", dest_room);
    }
  }
  initialize_occupied_flag(dest_room);
  check_for_occupied_spots(dest_room, all_players, player_radius);
  var_1bea176e = array::filter(var_1bea176e, 0, &function_1488cf91);
  for(i = 0; i < var_1bea176e.size; i++) {
    if(isDefined(var_1bea176e[i])) {
      slot = randomintrange(0, 4);
      start = 0;
      while(dest_room[slot].occupied && start < 4) {
        start++;
        slot++;
        if(slot >= 4) {
          slot = 0;
        }
      }
      dest_room[slot].occupied = 1;
      util::setclientsysstate("levelNotify", "black_box_end", var_1bea176e[i]);
      var_1bea176e[i] notify("stop_teleport_fx");
      assert(isDefined(var_1bea176e[i].teleport_origin));
      var_1bea176e[i].teleport_origin delete();
      var_1bea176e[i].teleport_origin = undefined;
      var_1bea176e[i] setorigin(dest_room[slot].origin);
      var_1bea176e[i] setplayerangles(dest_room[slot].angles);
      var_1bea176e[i] clientfield::increment("player_teleport_fx");
      if(loc != "eerooms") {
        var_1bea176e[i] enableweapons();
        var_1bea176e[i] enableoffhandweapons();
        var_1bea176e[i] freezecontrols(0);
      } else {
        var_1bea176e[i] freezecontrols(0);
      }
      util::setclientsysstate("levelNotify", "t2bfx", var_1bea176e[i]);
      visionset_mgr::deactivate("overlay", "zm_theater_teleport", var_1bea176e[i]);
      var_1bea176e[i] teleport_aftereffects();
      if(loc == "projroom") {
        level.second_hand thread start_wall_clock();
        thread extra_cam_startup();
        var_1bea176e[i] clientfield::set_to_player("player_dust_mote", 1);
      } else {
        if(loc == "theater") {
          var_1bea176e[i].inteleportation = 0;
          var_1bea176e[i].var_35c3d096 = undefined;
          var_1bea176e[i] clientfield::set_to_player("player_dust_mote", 1);
        } else {
          players[i] notify("player_teleported", slot);
        }
      }
      players[i].is_teleporting = 0;
    }
  }
  if(loc == "projroom") {
    return var_1bea176e;
  }
  if(loc == "theater") {
    level.eeroomsinuse = undefined;
    exploder::exploder(302);
  }
}

function extra_cam_startup() {
  wait(2);
  level.extracam_screen show();
  level.extracam_screen clientfield::set("extra_screen", 1);
  players = level.players;
  for(i = 0; i < players.size; i++) {
    util::setclientsysstate("levelNotify", "camera_start", players[i]);
  }
}

function get_array_spots(sname, spots) {
  for(i = 0; i < 4; i++) {
    spots[i] = getent(sname + i, "targetname");
  }
  return spots;
}

function initialize_occupied_flag(spots) {
  for(i = 0; i < spots.size; i++) {
    spots[i].occupied = 0;
  }
}

function check_for_occupied_spots(dest, players, player_radius) {
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i])) {
      for(j = 0; j < dest.size; j++) {
        if(!dest[j].occupied) {
          dist = distance2d(dest[j].origin, players[i].origin);
          if(dist < player_radius) {
            dest[j].occupied = 1;
          }
        }
      }
    }
  }
}

function teleport_2d_audio() {
  self endon("fx_done");
  util::clientnotify("tpa");
  players = getplayers();
  wait(1.7);
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i])) {
      if(self player_is_near_pad(players[i])) {
        util::setclientsysstate("levelNotify", "t2d", players[i]);
      }
    }
  }
}

function teleport_2d_audio_nopad(player) {
  self endon("fx_done");
  for(i = 0; i < player.size; i++) {
    if(isDefined(player[i])) {
      util::setclientsysstate("levelNotify", "t2dn", player[i]);
    }
  }
}

function teleport_2d_audio_specialroom_start(player) {
  self endon("fx_done");
  for(i = 0; i < player.size; i++) {
    if(isDefined(player[i])) {
      util::setclientsysstate("levelNotify", "tss", player[i]);
    }
  }
}

function teleport_2d_audio_specialroom_go(player) {
  self endon("fx_done");
  for(i = 0; i < player.size; i++) {
    if(isDefined(player[i])) {
      util::setclientsysstate("levelNotify", "tsg", player[i]);
    }
  }
}

function teleport_nuke(max_zombies, range) {
  zombies = getaispeciesarray("axis");
  zombies = util::get_array_of_closest(self.origin, zombies, undefined, max_zombies, range);
  for(i = 0; i < zombies.size; i++) {
    wait(randomfloatrange(0.2, 0.3));
    if(!isDefined(zombies[i])) {
      continue;
    }
    if(isDefined(zombies[i].animname) && (zombies[i].animname != "boss_zombie" && zombies[i].animname != "ape_zombie" && zombies[i].animname != "zombie_dog") && zombies[i].health < 5000) {
      zombies[i] zombie_utility::zombie_head_gib();
    }
    zombies[i] dodamage(zombies[i].health + 100, zombies[i].origin);
    playsoundatposition("nuked", zombies[i].origin);
  }
}

function teleporter_vo_play(vox_type, pre_wait = 0) {
  index = zm_utility::get_player_index(self);
  plr = ("plr_" + index) + "_";
  wait(pre_wait);
  self zm_audio::create_and_play_dialog(plr, vox_type, 0.25);
}

function teleport_aftereffects() {
  self thread[[level.teleport_ae_funcs[randomint(level.teleport_ae_funcs.size)]]]();
}

function teleport_aftereffect_shellshock() {
  println("");
  self shellshock("explosion", 3);
}

function teleport_aftereffect_shellshock_electric() {
  println("");
  self shellshock("electrocution", 3);
}

function teleport_aftereffect_fov() {
  println("");
  start_fov = 30;
  end_fov = 65;
  duration = 0.5;
  i = 0;
  while(i < duration) {
    fov = start_fov + (end_fov - start_fov) * (i / duration);
    wait(0.017);
    i = i + 0.017;
  }
}

function teleport_aftereffect_bw_vision(localclientnum) {
  println("");
  visionset_mgr::activate("visionset", "cheat_bw_invert_contrast", self);
  wait(1.25);
  visionset_mgr::deactivate("visionset", "cheat_bw_invert_contrast", self);
}

function teleport_aftereffect_red_vision(localclientnum) {
  println("");
  visionset_mgr::activate("visionset", "zombie_turned", self);
  wait(1.25);
  visionset_mgr::deactivate("visionset", "zombie_turned", self);
}

function teleport_aftereffect_flashy_vision(localclientnum) {
  println("");
  visionset_mgr::activate("visionset", "cheat_bw_invert_contrast", self);
  wait(0.4);
  visionset_mgr::deactivate("visionset", "cheat_bw_invert_contrast", self);
  visionset_mgr::activate("visionset", "cheat_bw_contrast", self);
  wait(1.2);
  visionset_mgr::deactivate("visionset", "cheat_bw_contrast", self);
}

function teleport_aftereffect_flare_vision(localclientnum) {
  println("");
  visionset_mgr::activate("visionset", "flare", self);
  wait(1.25);
  visionset_mgr::deactivate("visionset", "flare", self);
}

function zombietheaterteleporterseeklogic() {
  inteleportcount = 0;
  nonteleportinvalidcount = 0;
  poi1 = getent("teleporter_poi1", "targetname");
  poi2 = getent("teleporter_poi2", "targetname");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i].inteleportation) && players[i].inteleportation == 1) {
      inteleportcount++;
    }
    if(!zombie_utility::is_player_valid(players[i]) && (!isDefined(players[i].inteleportation) || players[i].inteleportation == 0)) {
      nonteleportinvalidcount++;
    }
  }
  if(inteleportcount > 0 && (inteleportcount == players.size || (inteleportcount + nonteleportinvalidcount) == players.size)) {
    if(!poi1.poi_active && !poi2.poi_active) {
      poi1 zm_utility::activate_zombie_point_of_interest();
      poi2 zm_utility::activate_zombie_point_of_interest();
    }
  } else if(inteleportcount != players.size) {
    if(poi1.poi_active && poi2.poi_active) {
      if(isDefined(poi1.attractor_array)) {
        poi1 zm_utility::deactivate_zombie_point_of_interest(1);
      }
      if(isDefined(poi2.attractor_array)) {
        poi2 zm_utility::deactivate_zombie_point_of_interest(1);
      }
    }
  }
}

function zombies_goto_position(position) {
  self endon("death");
  self endon("bad_path");
  orig_radius = self.goalradius;
  self.ignoreall = 1;
  self.goalradius = 128;
  iprintlnbold("", orig_radius);
  self setgoalpos(position.origin + (randomfloatrange(-40, 40), randomfloatrange(-40, 40), 0));
  self waittill("goal");
  self.ignoreall = 0;
  self.goalradius = orig_radius;
  self orientmode("face point", level.extracam_screen.origin);
}

function start_wall_clock() {
  self rotatepitch(180, 0.05);
  self waittill("rotatedone");
  for(clocktime = 0; clocktime != 30; clocktime++) {
    self rotatepitch(6, 0.1);
    wait(1);
  }
  wait(5);
  self rotateto(level.second_hand_angles, 0.05);
}

function eeroom_powerup_drop() {
  struct_array = struct::get_array("struct_random_powerup_post_teleport", "targetname");
  powerup_array = [];
  powerup_array[powerup_array.size] = "nuke";
  powerup_array[powerup_array.size] = "insta_kill";
  powerup_array[powerup_array.size] = "double_points";
  powerup_array[powerup_array.size] = "carpenter";
  powerup_array[powerup_array.size] = "fire_sale";
  powerup_array[powerup_array.size] = "full_ammo";
  powerup_array[powerup_array.size] = "minigun";
  struct_array = array::randomize(struct_array);
  powerup_array = array::randomize(powerup_array);
  level thread zm_powerups::specific_powerup_drop(powerup_array[0], struct_array[0].origin);
}

function theater_fly_me_to_the_moon_init() {
  var_37cacae8 = getent("trigger_jump", "targetname");
  to_the_moon_alice_trigger = getent("trigger_fly_me_to_the_moon", "targetname");
  var_37cacae8 thread function_2cdd3a26();
  to_the_moon_alice_trigger thread theater_fly_me_to_the_moon();
}

function function_2cdd3a26() {
  self endon("death");
  self.a_e_players = [];
  while(true) {
    self waittill("trigger", e_player);
    if(isinarray(self.a_e_players, e_player)) {
      continue;
    }
    if(!isDefined(self.a_e_players)) {
      self.a_e_players = [];
    } else if(!isarray(self.a_e_players)) {
      self.a_e_players = array(self.a_e_players);
    }
    self.a_e_players[self.a_e_players.size] = e_player;
    if(!isDefined(e_player._moon_jumps)) {
      e_player._moon_jumps = 0;
    }
    e_player thread function_edc40283(self);
    e_player thread function_bc057378(self);
  }
}

function function_edc40283(var_4e54c41) {
  self endon("exit_trigger");
  self endon("death");
  var_4e54c41 endon("death");
  while(self._moon_jumps < 5) {
    if(self jumpbuttonpressed()) {
      self._moon_jumps = self._moon_jumps + 1;
      wait(0.9);
    }
    wait(0.05);
  }
  self notify("hash_7bde7d2d");
}

function function_bc057378(var_4e54c41) {
  self endon("hash_7bde7d2d");
  var_4e54c41 endon("death");
  while(self istouching(var_4e54c41)) {
    wait(0.05);
  }
  if(self._moon_jumps < 5) {
    self._moon_jumps = 0;
  }
  self notify("exit_trigger");
  arrayremovevalue(var_4e54c41.a_e_players, self);
}

function theater_fly_me_to_the_moon() {
  self endon("hash_64fcb4a6");
  self sethintstring("");
  self setcursorhint("HINT_NOICON");
  while(isDefined(self)) {
    self waittill("trigger", e_player);
    if(!isDefined(e_player._moon_jumps) || e_player._moon_jumps < 5) {
      wait(0.05);
      continue;
    }
    if(isDefined(e_player._moon_jumps) && e_player._moon_jumps >= 5) {
      level theater_moon_jump_go();
      e_player._moon_jumps = undefined;
    }
  }
}

function theater_moon_jump_go() {
  ship = getent("model_zombie_rocket", "targetname");
  ship_base_origin = ship.origin;
  wait(0.05);
  ship clientfield::set("play_fly_me_to_the_moon_fx", 1);
  ship movez(120, 3, 0.7, 0);
  ship waittill("movedone");
  ship clientfield::set("play_fly_me_to_the_moon_fx", 0);
  ship delete();
  var_4e54c41 = getent("trigger_jump", "targetname");
  var_4e54c41 notify("hash_88782877");
  to_the_moon_alice_trigger = getent("trigger_fly_me_to_the_moon", "targetname");
  to_the_moon_alice_trigger delete();
}

function function_7e0ed731(var_f7b84b84, v_offset) {
  self endon("disconnect");
  var_51bf1eed = var_f7b84b84 + 1;
  var_2d8dac7a = "teleport_room_fx_" + var_51bf1eed;
  var_b4c5584f = struct::get(var_2d8dac7a, "targetname");
  s_wormhole = struct::spawn(var_b4c5584f.origin - v_offset, var_b4c5584f.angles);
  if(isDefined(s_wormhole)) {
    waittillframeend();
    s_wormhole scene::play("p7_fxanim_zm_kino_wormhole_bundle");
    s_wormhole struct::delete();
  }
}

function function_d11d2c50(a_ents) {
  a_ents["fxanim_kino_wormhole"] setignorepauseworld(1);
  wait(0.05);
  a_ents["fxanim_kino_wormhole"] clientfield::increment("teleporter_fx");
}