/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_teleporter.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_tomb_utility;
#using scripts\zm\zm_tomb_vo;
#using_animtree("generic");
#namespace zm_tomb_teleporter;

function teleporter_init() {
  clientfield::register("scriptmover", "teleporter_fx", 21000, 1, "int");
  clientfield::register("allplayers", "teleport_arrival_departure_fx", 21000, 1, "counter");
  clientfield::register("vehicle", "teleport_arrival_departure_fx", 21000, 1, "counter");
  visionset_mgr::register_info("overlay", "zm_factory_teleport", 21000, 61, 1, 1);
  level.teleport = [];
  level.n_active_links = 0;
  level.n_countdown = 0;
  level.teleport_cost = 0;
  level.is_cooldown = 0;
  level.n_active_timer = -1;
  level.n_teleport_time = 0;
  level.a_teleport_models = [];
  a_entrance_models = getEntArray("teleport_model", "targetname");
  foreach(e_model in a_entrance_models) {
    e_model useanimtree($generic);
    level.a_teleport_models[e_model.script_int] = e_model;
    e_model setignorepauseworld(1);
  }
  array::thread_all(a_entrance_models, & teleporter_samantha_chamber_line);
  a_portal_frames = getEntArray("portal_exit_frame", "script_noteworthy");
  level.a_portal_exit_frames = [];
  foreach(e_frame in a_portal_frames) {
    e_frame useanimtree($generic);
    e_frame ghost();
    level.a_portal_exit_frames[e_frame.script_int] = e_frame;
    e_frame thread scene::play("p7_fxanim_zm_ori_portal_collapse_bundle", e_frame);
  }
  level.a_teleport_exits = [];
  a_exits = struct::get_array("portal_exit", "script_noteworthy");
  foreach(s_portal in a_exits) {
    level.a_teleport_exits[s_portal.script_int] = s_portal;
  }
  level.a_teleport_exit_triggers = [];
  a_trigs = struct::get_array("chamber_exit_trigger", "script_noteworthy");
  foreach(s_trig in a_trigs) {
    level.a_teleport_exit_triggers[s_trig.script_int] = s_trig;
  }
  spawn_stargate_fx_origins();
}

function main() {
  a_s_teleporters = struct::get_array("trigger_teleport_pad", "targetname");
  array::thread_all(a_s_teleporters, & run_chamber_entrance_teleporter);
}

function teleporter_samantha_chamber_line() {
  max_dist_sq = 640000;
  level.sam_chamber_line_played = 0;
  level flag::wait_till("samantha_intro_done");
  while(!level.sam_chamber_line_played) {
    a_players = getplayers();
    foreach(e_player in a_players) {
      dist_sq = distance2dsquared(self.origin, e_player.origin);
      height_diff = abs(self.origin[2] - e_player.origin[2]);
      if(dist_sq < max_dist_sq && height_diff < 150 && (!(isDefined(e_player.isspeaking) && e_player.isspeaking))) {
        level thread play_teleporter_samantha_chamber_line(e_player);
        return;
      }
    }
    wait(0.1);
  }
}

function play_teleporter_samantha_chamber_line(e_player) {
  if(level.sam_chamber_line_played) {
    return;
  }
  level.sam_chamber_line_played = 1;
  level flag::wait_till_clear("story_vo_playing");
  level flag::set("story_vo_playing");
  zm_tomb_vo::set_players_dontspeak(1);
  zm_tomb_vo::samanthasay("vox_sam_enter_chamber_1_0", e_player, 1);
  zm_tomb_vo::samanthasay("vox_sam_enter_chamber_2_0", e_player);
  zm_tomb_vo::set_players_dontspeak(0);
  level flag::clear("story_vo_playing");
}

function run_chamber_exit(n_enum) {
  s_portal = level.a_teleport_exits[n_enum];
  s_activate_pos = level.a_teleport_exit_triggers[n_enum];
  e_portal_frame = level.a_portal_exit_frames[n_enum];
  e_portal_frame show();
  str_building_flag = e_portal_frame.targetname + "_building";
  level flag::init(str_building_flag);
  s_activate_pos.trigger_stub = zm_tomb_utility::tomb_spawn_trigger_radius(s_activate_pos.origin, 50, 1);
  s_activate_pos.trigger_stub zm_tomb_utility::set_unitrigger_hint_string(&"ZM_TOMB_TELE");
  s_portal.target = s_activate_pos.target;
  s_portal.origin = e_portal_frame gettagorigin("fx_portal_jnt");
  s_portal.angles = e_portal_frame gettagangles("fx_portal_jnt");
  str_fx = zm_tomb_utility::get_teleport_fx_from_enum(n_enum);
  collapse_time = getanimlength( % generic::p7_fxanim_zm_ori_portal_collapse_anim);
  open_time = getanimlength( % generic::p7_fxanim_zm_ori_portal_open_anim);
  var_ff7119bc = undefined;
  switch (s_portal.targetname) {
    case "portal_exit_fire": {
      var_ff7119bc = "p7_fxanim_zm_ori_portal_open_fire_bundle";
      break;
    }
    case "portal_exit_air": {
      var_ff7119bc = "p7_fxanim_zm_ori_portal_open_air_bundle";
      break;
    }
    case "portal_exit_ice": {
      var_ff7119bc = "p7_fxanim_zm_ori_portal_open_ice_bundle";
      break;
    }
    case "portal_exit_electric": {
      var_ff7119bc = "p7_fxanim_zm_ori_portal_open_elec_bundle";
      break;
    }
    default: {
      break;
    }
  }
  level flag::wait_till("start_zombie_round_logic");
  while(true) {
    s_activate_pos.trigger_stub waittill("trigger", e_player);
    if(!zombie_utility::is_player_valid(e_player)) {
      continue;
    }
    if(e_player.score < level.teleport_cost) {
      continue;
    }
    s_activate_pos.trigger_stub zm_tomb_utility::set_unitrigger_hint_string("");
    if(level.teleport_cost > 0) {
      e_player zm_score::minus_to_player_score(level.teleport_cost);
    }
    e_portal_frame playLoopSound("zmb_teleporter_loop_pre", 1);
    e_portal_frame thread scene::play(var_ff7119bc, e_portal_frame);
    level flag::set(str_building_flag);
    e_portal_frame thread zm_tomb_utility::whirlwind_rumble_nearby_players(str_building_flag);
    wait(open_time);
    e_portal_frame thread scene::play("p7_fxanim_zm_ori_portal_open_1frame_bundle", e_portal_frame);
    util::wait_network_frame();
    level flag::clear(str_building_flag);
    e_fx = spawn("script_model", s_portal.origin);
    e_fx.angles = s_portal.angles + vectorscale((0, 1, 0), 180);
    e_fx setModel("tag_origin");
    e_fx clientfield::set("element_glow_fx", n_enum + 4);
    zm_tomb_utility::rumble_nearby_players(e_fx.origin, 1000, 2);
    e_portal_frame playLoopSound("zmb_teleporter_loop_post", 1);
    s_portal thread teleporter_radius_think();
    wait(20);
    e_portal_frame thread scene::play("p7_fxanim_zm_ori_portal_collapse_bundle", e_portal_frame);
    e_portal_frame stoploopsound(0.5);
    e_portal_frame playSound("zmb_teleporter_anim_collapse_pew");
    s_portal notify("teleporter_radius_stop");
    e_fx clientfield::set("element_glow_fx", 0);
    wait(collapse_time);
    e_fx delete();
    s_activate_pos.trigger_stub zm_tomb_utility::set_unitrigger_hint_string(&"ZM_TOMB_TELE");
  }
}

function run_chamber_entrance_teleporter() {
  self endon("death");
  fx_glow = zm_tomb_utility::get_teleport_fx_from_enum(self.script_int);
  e_model = level.a_teleport_models[self.script_int];
  self.origin = e_model gettagorigin("fx_portal_jnt");
  self.angles = e_model gettagangles("fx_portal_jnt");
  self.angles = (self.angles[0], self.angles[1] + 180, self.angles[2]);
  self.trigger_stub = zm_tomb_utility::tomb_spawn_trigger_radius(self.origin - vectorscale((0, 0, 1), 30), 50);
  level flag::init("enable_teleporter_" + self.script_int);
  str_building_flag = "teleporter_building_" + self.script_int;
  level flag::init(str_building_flag);
  collapse_time = getanimlength( % generic::p7_fxanim_zm_ori_portal_collapse_anim);
  open_time = getanimlength( % generic::p7_fxanim_zm_ori_portal_open_anim);
  level flag::wait_till("start_zombie_round_logic");
  e_model thread scene::play("p7_fxanim_zm_ori_portal_collapse_bundle", e_model);
  wait(collapse_time);
  while(true) {
    level flag::wait_till("enable_teleporter_" + self.script_int);
    level flag::set(str_building_flag);
    var_babde23d = undefined;
    var_ff7119bc = undefined;
    switch (self.target) {
      case "fire_teleport_player": {
        var_babde23d = "lgtexp_fireCave_fade";
        var_ff7119bc = "p7_fxanim_zm_ori_portal_open_fire_bundle";
        break;
      }
      case "air_teleport_player": {
        var_babde23d = "lgtexp_airCave_fade";
        var_ff7119bc = "p7_fxanim_zm_ori_portal_open_air_bundle";
        break;
      }
      case "water_teleport_player": {
        var_babde23d = "lgtexp_iceCave_fade";
        var_ff7119bc = "p7_fxanim_zm_ori_portal_open_ice_bundle";
        break;
      }
      case "electric_teleport_player": {
        var_babde23d = "lgtexp_elecCave_fade";
        var_ff7119bc = "p7_fxanim_zm_ori_portal_open_elec_bundle";
        break;
      }
      default: {
        break;
      }
    }
    e_model thread zm_tomb_utility::whirlwind_rumble_nearby_players(str_building_flag);
    if(isDefined(var_ff7119bc)) {
      e_model thread scene::play(var_ff7119bc, e_model);
    }
    e_model playLoopSound("zmb_teleporter_loop_pre", 1);
    wait(open_time);
    e_model thread scene::play("p7_fxanim_zm_ori_portal_open_1frame_bundle", e_model);
    util::wait_network_frame();
    e_fx = spawn("script_model", self.origin);
    e_fx.angles = self.angles;
    e_fx setModel("tag_origin");
    e_fx clientfield::set("element_glow_fx", self.script_int + 4);
    zm_tomb_utility::rumble_nearby_players(e_fx.origin, 1000, 2);
    e_model playLoopSound("zmb_teleporter_loop_post", 1);
    if(isDefined(var_babde23d)) {
      exploder::exploder(var_babde23d);
    }
    if(!(isDefined(self.exit_enabled) && self.exit_enabled)) {
      self.exit_enabled = 1;
      level thread run_chamber_exit(self.script_int);
    }
    self thread stargate_teleport_think();
    level flag::clear(str_building_flag);
    level flag::wait_till_clear("enable_teleporter_" + self.script_int);
    level notify("disable_teleporter_" + self.script_int);
    e_fx clientfield::set("element_glow_fx", 0);
    e_model stoploopsound(0.5);
    e_model playSound("zmb_teleporter_anim_collapse_pew");
    e_model thread scene::play("p7_fxanim_zm_ori_portal_collapse_bundle", e_model);
    if(isDefined(var_babde23d)) {
      exploder::kill_exploder(var_babde23d);
    }
    wait(collapse_time);
    e_fx delete();
  }
}

function teleporter_radius_think(radius = 120) {
  self endon("teleporter_radius_stop");
  radius_sq = radius * radius;
  while(true) {
    a_players = getplayers();
    foreach(e_player in a_players) {
      dist_sq = distancesquared(e_player.origin, self.origin);
      if(dist_sq < radius_sq && e_player getstance() != "prone" && (!(isDefined(e_player.teleporting) && e_player.teleporting))) {
        playFX(level._effect["teleport_3p"], self.origin, (1, 0, 0), (0, 0, 1));
        playsoundatposition("zmb_teleporter_tele_3d", self.origin);
        level thread stargate_teleport_player(self.target, e_player, 5);
      }
    }
    util::wait_network_frame();
  }
}

function stargate_teleport_think() {
  self endon("death");
  level endon("disable_teleporter_" + self.script_int);
  e_potal = level.a_teleport_models[self.script_int];
  while(true) {
    self.trigger_stub waittill("trigger", e_player);
    if(e_player getstance() != "prone" && (!(isDefined(e_player.teleporting) && e_player.teleporting))) {
      playFX(level._effect["teleport_3p"], self.origin, (1, 0, 0), (0, 0, 1));
      playsoundatposition("zmb_teleporter_tele_3d", self.origin);
      level notify("player_teleported", e_player, self.script_int);
      level thread stargate_teleport_player(self.target, e_player);
    }
  }
}

function stargate_teleport_enable(n_index) {
  level flag::set("enable_teleporter_" + n_index);
}

function stargate_teleport_disable(n_index) {
  level flag::clear("enable_teleporter_" + n_index);
}

function stargate_play_fx() {
  self.e_fx clientfield::set("teleporter_fx", 1);
  self waittill("stop_teleport_fx");
  self.e_fx clientfield::set("teleporter_fx", 0);
}

function spawn_stargate_fx_origins() {
  a_teleport_positions = struct::get_array("teleport_room", "script_noteworthy");
  foreach(s_teleport in a_teleport_positions) {
    v_fx_pos = (s_teleport.origin + (0, 0, 64)) + (anglesToForward(s_teleport.angles) * 120);
    s_teleport.e_fx = spawn("script_model", v_fx_pos);
    s_teleport.e_fx setModel("tag_origin");
    s_teleport.e_fx.angles = s_teleport.angles + vectorscale((0, 1, 0), 180);
  }
}

function stargate_teleport_player(str_teleport_to, player, n_teleport_time_sec = 2, show_fx = 1) {
  player.teleporting = 1;
  player clientfield::increment("teleport_arrival_departure_fx");
  if(show_fx) {
    player thread hud::fade_to_black_for_x_sec(0, 0.3, 0, 0.5, "white");
    util::wait_network_frame();
  }
  n_pos = player.characterindex;
  prone_offset = vectorscale((0, 0, 1), 49);
  crouch_offset = vectorscale((0, 0, 1), 20);
  stand_offset = (0, 0, 0);
  image_room = struct::get("teleport_room_" + n_pos, "targetname");
  player disableoffhandweapons();
  player disableweapons();
  player freezecontrols(1);
  util::wait_network_frame();
  var_64103691 = struct::get_array(str_teleport_to, "targetname");
  n_total_time = n_teleport_time_sec + 4;
  player zm_utility::create_streamer_hint(struct::get_array(str_teleport_to, "targetname")[0].origin, struct::get_array(str_teleport_to, "targetname")[0].angles, 1, n_total_time);
  if(player getstance() == "prone") {
    desired_origin = image_room.origin + prone_offset;
  } else {
    if(player getstance() == "crouch") {
      desired_origin = image_room.origin + crouch_offset;
    } else {
      desired_origin = image_room.origin + stand_offset;
    }
  }
  player.teleport_origin = spawn("script_model", player.origin);
  player.teleport_origin setModel("tag_origin");
  player.teleport_origin.angles = player.angles;
  player playerlinktoabsolute(player.teleport_origin, "tag_origin");
  player.teleport_origin.origin = desired_origin;
  player.teleport_origin.angles = image_room.angles;
  if(show_fx) {
    player playsoundtoplayer("zmb_teleporter_plr_start", player);
  }
  util::wait_network_frame();
  player.teleport_origin.angles = image_room.angles;
  if(show_fx) {
    image_room thread stargate_play_fx();
    visionset_mgr::activate("overlay", "zm_factory_teleport", player);
  }
  var_c5af343b = 0.5;
  wait(n_teleport_time_sec - var_c5af343b);
  if(show_fx) {
    player thread hud::fade_to_black_for_x_sec(0, var_c5af343b + 0.3, 0, 0.5, "white");
    util::wait_network_frame();
  }
  image_room notify("stop_teleport_fx");
  a_pos = struct::get_array(str_teleport_to, "targetname");
  s_pos = get_free_teleport_pos(player, a_pos);
  player unlink();
  if(isDefined(player.teleport_origin)) {
    player.teleport_origin delete();
    player.teleport_origin = undefined;
  }
  player setorigin(s_pos.origin);
  player setplayerangles(s_pos.angles);
  player enableweapons();
  player enableoffhandweapons();
  player freezecontrols(0);
  visionset_mgr::deactivate("overlay", "zm_factory_teleport", player);
  if(show_fx) {
    player playsoundtoplayer("zmb_teleporter_plr_end", player);
  }
  player.teleporting = 0;
  player clientfield::increment("teleport_arrival_departure_fx");
  player notify("teleport_finished");
}

function is_teleport_landing_valid(s_pos, n_radius) {
  n_radius_sq = n_radius * n_radius;
  a_players = getplayers();
  foreach(e_player in a_players) {
    if(distance2dsquared(s_pos.origin, e_player.origin) < n_radius_sq) {
      return false;
    }
  }
  return true;
}

function get_free_teleport_pos(player, a_structs) {
  n_player_radius = 64;
  while(true) {
    a_players = getplayers();
    foreach(s_pos in a_structs) {
      if(is_teleport_landing_valid(s_pos, n_player_radius)) {
        return s_pos;
      }
    }
    wait(0.05);
  }
}