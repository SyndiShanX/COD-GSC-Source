/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_flingers.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_castle_vo;
#namespace zm_castle_flingers;

function function_976c9217() {
  zm::register_player_damage_callback( & function_4b3d145d);
  var_fa27add4 = struct::get_array("115_flinger_pad_aimer", "targetname");
  array::thread_all(var_fa27add4, & function_5ecbd7cb);
  var_a6e47643 = struct::get_array("115_flinger_landing_pad", "targetname");
  array::thread_all(var_a6e47643, & function_cc8f94df);
  level thread function_979004a();
  register_clientfields();
  level._effect["flinger_land_kill"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_kill_zmb";
}

function register_clientfields() {
  clientfield::register("toplayer", "flinger_flying_postfx", 1, 1, "int");
  clientfield::register("toplayer", "flinger_land_smash", 1, 1, "counter");
  clientfield::register("scriptmover", "player_visibility", 1, 1, "int");
  clientfield::register("scriptmover", "flinger_launch_fx", 1, 1, "counter");
  clientfield::register("scriptmover", "flinger_pad_active_fx", 1, 1, "int");
}

function function_5ecbd7cb() {
  level waittill("start_zombie_round_logic");
  var_845e036a = getent(self.target, "targetname");
  vol_fling = getent(var_845e036a.target, "targetname");
  var_845e036a setModel("p7_zm_ctl_jumpsphere_combined_snow");
  v_fling = anglesToForward(self.angles) * self.script_int;
  s_unitrigger_stub = spawnStruct();
  s_unitrigger_stub.origin = self.origin + vectorscale((0, 0, 1), 30);
  s_unitrigger_stub.radius = 64;
  s_unitrigger_stub.hint_parm1 = 500;
  s_unitrigger_stub.cursor_hint = "HINT_NOICON";
  s_unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger_stub, 1);
  s_unitrigger_stub.prompt_and_visibility_func = & function_485001bf;
  zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, & function_4029cf56);
  var_81b99a73 = self.script_noteworthy;
  s_unitrigger_stub thread function_52d18d43(var_81b99a73, 500);
  var_3432399a = var_845e036a.target + "_spline";
  nd_start = getvehiclenode(var_3432399a, "targetname");
  var_df826fd8 = nd_start function_53f4df();
  level flag::wait_till(var_81b99a73);
  var_845e036a thread function_2f34da41();
  while(true) {
    var_845e036a setModel("p7_zm_ctl_jumpsphere_combined_snow_blue");
    var_845e036a thread function_cc3a384b(1);
    s_unitrigger_stub waittill("trigger", e_who);
    if(level flag::get("rocket_firing") && s_unitrigger_stub.in_zone === "zone_rooftop") {
      continue;
    }
    if(!e_who zm_score::can_player_purchase(500)) {
      e_who zm_audio::create_and_play_dialog("general", "transport_deny");
      continue;
    } else {
      e_who zm_score::minus_to_player_score(500);
      zm_unitrigger::unregister_unitrigger(s_unitrigger_stub);
    }
    s_unitrigger_stub notify("hash_4baa9cb4");
    var_df826fd8 setModel("p7_zm_ctl_jumpsphere_landing_pad_snow_blue");
    var_df826fd8 clientfield::set("flinger_pad_active_fx", 1);
    n_timer = 0;
    vol_fling playSound("zmb_fling_activate");
    while(n_timer <= 3) {
      a_ai_zombies = zombie_utility::get_zombie_array();
      a_ai_zombies = function_3dcd0982(a_ai_zombies, vol_fling);
      if(a_ai_zombies.size) {
        array::thread_all(a_ai_zombies, & function_e9d3c391, vol_fling, v_fling, nd_start);
      } else {
        var_7092e170 = function_3dcd0982(level.activeplayers, vol_fling);
        if(var_7092e170.size > 1) {
          var_7092e170 thread function_f7842163(vol_fling, v_fling, nd_start, var_845e036a, var_df826fd8);
        } else {
          array::thread_all(var_7092e170, & function_e9d3c391, vol_fling, v_fling, nd_start, var_845e036a, var_df826fd8);
        }
      }
      n_timer = n_timer + 0.1;
      wait(0.1);
    }
    var_845e036a thread function_5205dda3(var_df826fd8);
    wait(15);
    s_unitrigger_stub notify("hash_7edb4c9b");
    zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, & function_4029cf56);
    var_df826fd8 setModel("p7_zm_ctl_jumpsphere_landing_pad_snow_blue");
    var_df826fd8 playSound("zmb_fling_activate");
  }
}

function function_5205dda3(var_df826fd8) {
  while(isDefined(function_21a777b0()) && function_21a777b0()) {
    wait(0.1);
  }
  var_df826fd8 clientfield::set("flinger_pad_active_fx", 0);
  var_df826fd8 setModel("p7_zm_ctl_jumpsphere_landing_pad_snow_red");
  self setModel("p7_zm_ctl_jumpsphere_combined_snow_red");
  self thread function_cc3a384b(0);
}

function function_21a777b0() {
  foreach(e_player in level.activeplayers) {
    if(isDefined(e_player.is_flung) && e_player.is_flung || (isDefined(e_player.var_9a017681) && e_player.var_9a017681)) {
      return true;
    }
  }
  return false;
}

function function_52d18d43(var_81b99a73, n_cost) {
  self function_e2ae5aa6(&"ZM_CASTLE_FLING_LOCKED");
  level flag::wait_till(var_81b99a73);
  while(true) {
    self function_e2ae5aa6(&"ZM_CASTLE_FLING_AVAILABLE", n_cost);
    self waittill("hash_4baa9cb4");
    self function_e2ae5aa6(&"ZM_CASTLE_FLING_COOLDOWN");
    self waittill("hash_7edb4c9b");
  }
}

function function_e2ae5aa6(str_message, param1) {
  self.hint_string = str_message;
  self.hint_parm1 = param1;
  zm_unitrigger::unregister_unitrigger(self);
  zm_unitrigger::register_static_unitrigger(self, & unitrigger_think);
}

function unitrigger_think() {
  self endon("kill_trigger");
  self.stub thread unitrigger_refresh_message();
  while(true) {
    self waittill("trigger", var_4161ad80);
    self.stub notify("trigger", var_4161ad80);
  }
}

function unitrigger_refresh_message() {
  self zm_unitrigger::run_visibility_function_for_all_triggers();
}

function function_3dcd0982( & array, var_8d88ae81) {
  return array::filter(array, 0, & function_a78c631a, var_8d88ae81);
}

function function_a78c631a(val, var_8d88ae81) {
  return isalive(val) && (!(isDefined(val.is_flung) && val.is_flung)) && (!(isDefined(val.var_9a017681) && val.var_9a017681)) && val istouching(var_8d88ae81);
}

function function_2f34da41() {
  switch (self.target) {
    case "upper_courtyard_flinger": {
      exploder::exploder("lgt_upper_courtyard_nolink");
      return;
    }
    case "lower_courtyard_flinger": {
      exploder::exploder("lgt_lower_courtyard_nolink");
      return;
    }
    case "roof_flinger": {
      exploder::exploder("lgt_roof_nolink");
      return;
    }
    case "v10_rocket_pad_flinger": {
      exploder::exploder("lgt_v10_nolink");
      return;
    }
  }
}

function function_cc3a384b(b_active) {
  switch (self.target) {
    case "upper_courtyard_flinger": {
      if(b_active) {
        exploder::exploder("lgt_upper_courtyard_blue");
        exploder::exploder("fxexp_851");
        exploder::stop_exploder("lgt_upper_courtyard_red");
      } else {
        exploder::exploder("lgt_upper_courtyard_red");
        exploder::stop_exploder("lgt_upper_courtyard_blue");
        exploder::stop_exploder("fxexp_851");
      }
      return;
    }
    case "lower_courtyard_flinger": {
      if(b_active) {
        exploder::exploder("lgt_lower_courtyard_blue");
        exploder::exploder("fxexp_853");
        exploder::stop_exploder("lgt_lower_courtyard_red");
      } else {
        exploder::exploder("lgt_lower_courtyard_red");
        exploder::stop_exploder("lgt_lower_courtyard_blue");
        exploder::stop_exploder("fxexp_853");
      }
      return;
    }
    case "roof_flinger": {
      if(b_active) {
        exploder::exploder("lgt_roof_blue");
        exploder::exploder("fxexp_852");
        exploder::stop_exploder("lgt_roof_red");
      } else {
        exploder::exploder("lgt_roof_red");
        exploder::stop_exploder("lgt_roof_blue");
        exploder::stop_exploder("fxexp_852");
      }
      return;
    }
    case "v10_rocket_pad_flinger": {
      if(b_active) {
        exploder::exploder("lgt_v10_blue");
        exploder::exploder("fxexp_854");
        exploder::stop_exploder("lgt_v10_red");
      } else {
        exploder::exploder("lgt_v10_red");
        exploder::stop_exploder("lgt_v10_blue");
        exploder::stop_exploder("fxexp_854");
      }
      return;
    }
  }
}

function function_f7842163(var_ca34f349, v_fling, nd_start, var_173065cc, var_df826fd8) {
  for(i = 0; i < self.size; i++) {
    self[i].var_9a017681 = 1;
  }
  for(i = 0; i < self.size; i++) {
    if(self[i] istouching(var_ca34f349) && (isDefined(self[i].var_9a017681) && self[i].var_9a017681)) {
      self[i] thread function_e9d3c391(var_ca34f349, v_fling, nd_start, var_173065cc, var_df826fd8);
      wait(0.25);
    }
    self[i].var_9a017681 = undefined;
  }
}

function function_149a5187() {
  self endon("hash_13bf4db7");
  level waittill("end_game");
  self.var_3048ac6d = 1;
}

function function_e9d3c391(var_ca34f349, v_fling, nd_start, var_173065cc, var_df826fd8) {
  self endon("death");
  if(isplayer(self)) {
    self thread function_149a5187();
    self enableinvulnerability();
    self.is_flung = 1;
    while(self isslamming()) {
      util::wait_network_frame();
    }
    self zm_utility::create_streamer_hint(var_df826fd8.origin, self.angles, 1);
    self notsolid();
    self notify(var_173065cc.target);
    if(!self laststand::player_is_in_laststand() && !self inlaststand()) {
      self allowcrouch(0);
      self allowprone(0);
      self allowstand(1);
      if(self getstance() != "stand") {
        self setstance("stand");
      }
    }
    self playSound("zmb_fling_fly");
    var_413ea50f = vehicle::spawn(undefined, "player_vehicle", "flinger_vehicle", nd_start.origin, nd_start.angles);
    self playerlinktodelta(var_413ea50f);
    self thread function_44659337(nd_start, var_ca34f349, v_fling);
    self playrumbleonentity("zm_castle_flinger_launch");
    self clientfield::set_to_player("flinger_flying_postfx", 1);
    self thread function_c1f1756a();
    if(isDefined(var_173065cc)) {
      var_173065cc clientfield::increment("flinger_launch_fx");
    }
    var_6a7beeb2 = function_cbac68fe(self);
    var_6a7beeb2 linkto(var_413ea50f);
    w_current = self.currentweapon;
    if(w_current != level.weaponnone) {
      var_f5434f17 = zm_utility::spawn_buildkit_weapon_model(self, w_current, undefined, var_6a7beeb2 gettagorigin("tag_weapon_right"), var_6a7beeb2 gettagangles("tag_weapon_right"));
      var_f5434f17 linkto(var_6a7beeb2, "tag_weapon_right");
      var_f5434f17 setowner(self);
    }
    var_6a7beeb2 thread scene::play("cin_zm_dlc1_jump_pad_air_loop", var_6a7beeb2);
    var_6a7beeb2 clientfield::set("player_visibility", 1);
    if(isDefined(var_f5434f17)) {
      var_f5434f17 clientfield::set("player_visibility", 1);
    }
    self ghost();
    var_413ea50f setignorepauseworld(1);
    var_413ea50f attachpath(nd_start);
    var_413ea50f startpath();
    var_413ea50f waittill("reached_end_node");
    self thread function_3298b25f(nd_start);
    self thread function_29c06608();
    self playrumbleonentity("zm_castle_flinger_land");
    self clientfield::set_to_player("flinger_flying_postfx", 0);
    var_6a7beeb2 clientfield::set("player_visibility", 0);
    if(isDefined(var_f5434f17)) {
      var_f5434f17 clientfield::set("player_visibility", 0);
    }
    var_6a7beeb2 thread scene::stop("cin_zm_dlc1_jump_pad_air_loop");
    if(isDefined(var_f5434f17)) {
      var_f5434f17 delete();
    }
    self show();
    self solid();
    self thread function_9f131b98();
    if(!self laststand::player_is_in_laststand()) {
      self allowcrouch(1);
      self allowprone(1);
    }
    self playSound("zmb_fling_land");
    var_6a7beeb2 hide();
    util::wait_network_frame();
    var_6a7beeb2 delete();
    self.is_flung = undefined;
    self notify("hash_13bf4db7");
    var_413ea50f delete();
    self zm_utility::clear_streamer_hint();
    self thread function_d1736cb5();
  } else {
    if(self.isdog) {
      self kill();
    } else if(self.archetype === "zombie") {
      self.is_flung = 1;
      self setplayercollision(0);
      self.mdl_anchor = util::spawn_model("tag_origin", nd_start.origin, nd_start.angles);
      self linkto(self.mdl_anchor);
      nd_next = getvehiclenode(nd_start.target, "targetname");
      n_distance = distance(nd_start.origin, nd_next.origin);
      n_time = n_distance / 600;
      self.mdl_anchor moveto(nd_next.origin, n_time);
      self.mdl_anchor waittill("movedone");
      self unlink();
      self startragdoll();
      self launchragdoll(v_fling * randomfloatrange(0.17, 0.21));
      util::wait_network_frame();
      self dodamage(self.health, self.origin);
      level.zombie_total++;
      while(self istouching(var_ca34f349)) {
        wait(0.1);
      }
      self.is_flung = undefined;
    }
  }
}

function function_9f131b98() {
  wait(0.5);
  self disableinvulnerability();
}

function function_d1736cb5() {
  if(!isDefined(level.var_d69af29) || (gettime() - level.var_d69af29) > 30000) {
    var_323d1645 = randomint(5);
    while(var_323d1645 === self.var_9a3fa33b) {
      var_323d1645 = randomint(5);
    }
    if(zm_castle_vo::function_68ee653()) {
      return;
    }
    b_result = self zm_castle_vo::function_7b697614((("vox_plr_" + self.characterindex) + "_use_jumpsphere_") + var_323d1645, 1.4);
    if(b_result) {
      self.var_9a3fa33b = var_323d1645;
      level.var_d69af29 = gettime();
    }
  }
}

function function_cbac68fe(e_player) {
  var_629f4b8 = spawn("script_model", e_player.origin);
  var_629f4b8.angles = e_player.angles;
  mdl_body = e_player getcharacterbodymodel();
  var_629f4b8 setModel(mdl_body);
  bodyrenderoptions = e_player getcharacterbodyrenderoptions();
  var_629f4b8 setbodyrenderoptions(bodyrenderoptions, bodyrenderoptions, bodyrenderoptions);
  var_629f4b8.health = 100;
  var_629f4b8 setowner(e_player);
  var_629f4b8.team = e_player.team;
  var_629f4b8 solid();
  return var_629f4b8;
}

function function_74d2bb99(nd_start) {
  self endon("death");
  self endon("reached_end_node");
  var_5f7e3f41 = nd_start;
  while(isDefined(var_5f7e3f41)) {
    self waittill("reached_node", var_5f7e3f41);
    nd_last = var_5f7e3f41;
    var_5f7e3f41 = undefined;
    var_5f7e3f41 = getvehiclenode(nd_last.target, "targetname");
    if(isDefined(var_5f7e3f41) && isDefined(var_5f7e3f41.speed)) {
      var_2a07f017 = var_5f7e3f41.speed / 17.6;
      var_db94396f = self getspeedmph();
      if(var_db94396f != var_2a07f017) {
        self setspeed(var_2a07f017, 10);
      }
    }
    waittillframeend();
  }
}

function function_c1f1756a() {
  while(isDefined(self.is_flung) && self.is_flung) {
    self playrumbleonentity("zod_beast_grapple_reel");
    wait(0.2);
  }
}

function function_3298b25f(nd_start) {
  var_a05a47c7 = nd_start function_fbd80603();
  var_16f5c370 = var_a05a47c7.origin;
  while(positionwouldtelefrag(var_16f5c370)) {
    util::wait_network_frame();
    var_16f5c370 = var_a05a47c7.origin + (randomfloatrange(-24, 24), randomfloatrange(-24, 24), 0);
  }
  self unlink();
  self setorigin(var_16f5c370);
  if(isDefined(self.var_3048ac6d) && self.var_3048ac6d) {
    self freezecontrols(1);
  }
  self clientfield::increment_to_player("flinger_land_smash");
  wait(3);
  var_a05a47c7.occupied = undefined;
}

function function_fbd80603() {
  var_df826fd8 = self function_53f4df();
  a_s_spots = struct::get_array(var_df826fd8.target, "targetname");
  for(i = 0; i < a_s_spots.size; i++) {
    for(j = i; j < a_s_spots.size; j++) {
      if(a_s_spots[j].script_int < a_s_spots[i].script_int) {
        temp = a_s_spots[i];
        a_s_spots[i] = a_s_spots[j];
        a_s_spots[j] = temp;
      }
    }
  }
  for(i = 0; i < a_s_spots.size; i++) {
    if(!(isDefined(a_s_spots[i].occupied) && a_s_spots[i].occupied)) {
      a_s_spots[i].occupied = 1;
      return a_s_spots[i];
    }
  }
}

function function_53f4df() {
  switch (self.targetname) {
    case "lower_courtyard_flinger_spline": {
      var_df826fd8 = getent("lower_courtyard_landing_pad", "targetname");
      return var_df826fd8;
    }
    case "upper_courtyard_flinger_spline": {
      var_df826fd8 = getent("upper_courtyard_landing_pad", "targetname");
      return var_df826fd8;
    }
    case "roof_flinger_spline": {
      var_df826fd8 = getent("rooftop_landing_pad", "targetname");
      return var_df826fd8;
    }
    case "v10_rocket_pad_flinger_spline": {
      var_df826fd8 = getent("v10_rocket_landing_pad", "targetname");
      return var_df826fd8;
    }
  }
}

function function_44659337(nd_target, var_ca34f349, v_fling) {
  a_ai = getaiteamarray(level.zombie_team);
  a_sorted_ai = arraysortclosest(a_ai, nd_target.origin, a_ai.size, 0, 512);
  array::thread_all(a_sorted_ai, & function_1a4837ab, nd_target, self, var_ca34f349, v_fling);
}

function function_1a4837ab(nd_target, e_target, var_ca34f349, v_fling) {
  self endon("death");
  if(!(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
    return;
  }
  var_c95b4513 = [];
  for(i = 0; i < level.activeplayers.size; i++) {
    if(level.activeplayers[i] != e_target) {
      array::add(var_c95b4513, level.activeplayers[i]);
    }
  }
  var_57cf6f70 = arraysortclosest(var_c95b4513, self.origin, var_c95b4513.size, 0, 512);
  if(var_57cf6f70.size) {
    return;
  }
  if(self.archetype === "zombie" && self.ai_state === "zombie_think") {
    self.ignoreall = 1;
    self setgoal(nd_target.origin, 1);
    n_start_time = gettime();
    self util::waittill_any_timeout(6, "goal");
    self.ignoreall = 0;
    n_end_time = gettime();
    n_total_time = (n_end_time - n_start_time) / 1000;
    if(!(isDefined(self.is_flung) && self.is_flung) && n_total_time < 6) {
      self thread function_e9d3c391(var_ca34f349, v_fling, nd_target);
    }
  }
}

function function_29c06608() {
  a_ai = getaiteamarray(level.zombie_team);
  a_ai_zombies = arraysortclosest(a_ai, self.origin, a_ai.size, 0, 128);
  foreach(ai_zombie in a_ai_zombies) {
    if(ai_zombie.archetype === "zombie") {
      ai_zombie.knockdown = 1;
      self thread zombie_slam_direction(ai_zombie);
    }
  }
}

function zombie_slam_direction(ai_zombie) {
  v_zombie_to_player = self.origin - ai_zombie.origin;
  v_zombie_to_player_2d = vectornormalize((v_zombie_to_player[0], v_zombie_to_player[1], 0));
  v_zombie_forward = anglesToForward(ai_zombie.angles);
  v_zombie_forward_2d = vectornormalize((v_zombie_forward[0], v_zombie_forward[1], 0));
  v_zombie_right = anglestoright(ai_zombie.angles);
  v_zombie_right_2d = vectornormalize((v_zombie_right[0], v_zombie_right[1], 0));
  v_dot = vectordot(v_zombie_to_player_2d, v_zombie_forward_2d);
  if(v_dot >= 0.5) {
    ai_zombie.knockdown_direction = "front";
    ai_zombie.getup_direction = "getup_back";
  } else {
    if(v_dot < 0.5 && v_dot > -0.5) {
      v_dot = vectordot(v_zombie_to_player_2d, v_zombie_right_2d);
      if(v_dot > 0) {
        ai_zombie.knockdown_direction = "right";
        if(math::cointoss()) {
          ai_zombie.getup_direction = "getup_back";
        } else {
          ai_zombie.getup_direction = "getup_belly";
        }
      } else {
        ai_zombie.knockdown_direction = "left";
        ai_zombie.getup_direction = "getup_belly";
      }
    } else {
      ai_zombie.knockdown_direction = "back";
      ai_zombie.getup_direction = "getup_belly";
    }
  }
  wait(1);
  self.knockdown = 0;
}

function function_4b3d145d(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(isDefined(self.is_flung) && self.is_flung) {
    return 0;
  }
  return -1;
}

function function_485001bf() {
  str_msg = & "";
  str_msg = self.stub.hint_string;
  param1 = self.stub.hint_parm1;
  if(level flag::get("rocket_firing") && self.stub.in_zone === "zone_rooftop") {
    self sethintstring(&"ZM_CASTLE_WUNDERSPHERE_LOCKED");
    return false;
  }
  if(isDefined(param1)) {
    self sethintstring(str_msg, param1);
  } else {
    if(isDefined(self.stub.flag_name) && level flag::get(self.stub.flag_name) == 1) {
      self sethintstring("");
    } else {
      self sethintstring(str_msg);
      if(str_msg == (&"ZM_CASTLE_FLING_LOCKED")) {
        if(!isDefined(level.var_4f91b555) || !isDefined(level.var_4f91b555["sphere_" + self.stub.in_zone]) || (gettime() - (level.var_4f91b555["sphere_" + self.stub.in_zone])) > 11000) {
          level.var_4f91b555["sphere_" + self.stub.in_zone] = gettime();
          playsoundatposition("vox_maxis_pad_pa_unable_0", self.origin);
        }
      }
    }
  }
  return true;
}

function function_4029cf56() {
  self endon("kill_trigger");
  self.stub thread zm_unitrigger::run_visibility_function_for_all_triggers();
  while(true) {
    self waittill("trigger", var_4161ad80);
    self.stub notify("trigger", var_4161ad80);
  }
}

function function_cc8f94df() {
  var_9ca35935 = self.script_noteworthy;
  level flag::init(var_9ca35935);
  var_1143aa58 = getent(self.target, "targetname");
  var_1143aa58 setModel("p7_zm_ctl_jumpsphere_landing_pad_snow");
  s_unitrigger_stub = spawnStruct();
  s_unitrigger_stub.origin = self.origin + vectorscale((0, 0, 1), 30);
  s_unitrigger_stub.radius = 50;
  s_unitrigger_stub.cursor_hint = "HINT_NOICON";
  s_unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
  s_unitrigger_stub.flag_name = var_9ca35935;
  s_unitrigger_stub.prompt_and_visibility_func = & function_485001bf;
  zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, & function_4029cf56);
  s_unitrigger_stub function_e2ae5aa6(&"ZM_CASTLE_ENABLE_LANDING_PAD");
  s_unitrigger_stub waittill("trigger", e_who);
  var_1143aa58 playSound("evt_launchpad_on");
  if(level zm_utility::is_player_valid(e_who)) {
    playsoundatposition("vox_maxis_pad_pa_activate_0", e_who.origin);
    e_who playrumbleonentity("zm_castle_interact_rumble");
  }
  zm_unitrigger::unregister_unitrigger(s_unitrigger_stub);
  level flag::set(var_9ca35935);
  var_1143aa58 setModel("p7_zm_ctl_jumpsphere_landing_pad_snow_blue");
}

function function_979004a() {
  level waittill("start_zombie_round_logic");
  var_7d3b9ef4 = getent("trig_115_lift", "targetname");
  while(true) {
    var_7d3b9ef4 waittill("trigger", e_player);
    if(zm_utility::is_player_valid(e_player)) {
      e_player thread function_ab3112dc(var_7d3b9ef4);
    }
    wait(0.1);
  }
}

function function_ab3112dc(var_16a4e32) {
  if(!(isDefined(self.var_c7a6615d) && self.var_c7a6615d)) {
    var_2d04a37c = randomfloatrange(1.4, 1.7);
    self.var_c7a6615d = 1;
    n_start_time = gettime();
    if(!isDefined(level.var_bf38980c) || (gettime() - level.var_bf38980c) > 7000) {
      level.var_bf38980c = gettime();
      playsoundatposition("vox_maxis_pad_pa_use_0", self.origin);
    }
    while(self istouching(var_16a4e32) && (!(isDefined(self.is_flung) && self.is_flung))) {
      self playrumbleonentity("zod_beast_grapple_reel");
      n_current_time = gettime();
      n_time = (n_current_time - n_start_time) / 1000;
      if(n_time >= var_2d04a37c) {
        self thread function_894853cb(var_16a4e32);
        return;
      }
      wait(0.2);
    }
    self.var_c7a6615d = undefined;
  }
}

function function_894853cb(var_16a4e32) {
  self endon("death");
  nd_start = getvehiclenode(var_16a4e32.target, "targetname");
  self.is_flung = 1;
  self enableinvulnerability();
  self notsolid();
  if(!self laststand::player_is_in_laststand() && !self inlaststand()) {
    self allowcrouch(0);
    self allowprone(0);
    self allowstand(1);
    if(self getstance() != "stand") {
      self setstance("stand");
    }
  }
  self playSound("zmb_fling_fly");
  var_413ea50f = vehicle::spawn(undefined, "player_vehicle", "flinger_vehicle", nd_start.origin, nd_start.angles);
  self linkto(var_413ea50f);
  self disableweaponcycling();
  self disableoffhandweapons();
  self playrumbleonentity("zm_castle_flinger_launch");
  self clientfield::set_to_player("flinger_flying_postfx", 1);
  self thread function_c1f1756a();
  var_6a7beeb2 = function_cbac68fe(self);
  var_6a7beeb2 linkto(var_413ea50f);
  w_current = self.currentweapon;
  if(w_current != level.weaponnone) {
    var_f5434f17 = zm_utility::spawn_buildkit_weapon_model(self, w_current, undefined, var_6a7beeb2 gettagorigin("tag_weapon_right"), var_6a7beeb2 gettagangles("tag_weapon_right"));
    var_f5434f17 linkto(var_6a7beeb2, "tag_weapon_right");
    var_f5434f17 setowner(self);
  }
  var_6a7beeb2 thread scene::play("cin_zm_dlc1_jump_pad_air_loop", var_6a7beeb2);
  var_6a7beeb2 clientfield::set("player_visibility", 1);
  if(isDefined(var_f5434f17)) {
    var_f5434f17 clientfield::set("player_visibility", 1);
  }
  self ghost();
  var_413ea50f notsolid();
  var_6a7beeb2 notsolid();
  if(isDefined(var_f5434f17)) {
    var_f5434f17 notsolid();
  }
  var_413ea50f setignorepauseworld(1);
  var_413ea50f attachpath(nd_start);
  var_413ea50f startpath();
  var_413ea50f waittill("reached_end_node");
  self unlink();
  self function_121c6c1e();
  self thread function_29c06608();
  self playrumbleonentity("zm_castle_well_land");
  self clientfield::set_to_player("flinger_flying_postfx", 0);
  var_6a7beeb2 clientfield::set("player_visibility", 0);
  if(isDefined(var_f5434f17)) {
    var_f5434f17 clientfield::set("player_visibility", 0);
  }
  var_6a7beeb2 thread scene::stop("cin_zm_dlc1_jump_pad_air_loop");
  var_6a7beeb2 hide();
  if(isDefined(var_f5434f17)) {
    var_f5434f17 delete();
  }
  self show();
  self solid();
  var_413ea50f delete();
  self enableweaponcycling();
  self enableoffhandweapons();
  if(!self laststand::player_is_in_laststand() && !self inlaststand()) {
    self allowcrouch(1);
    self allowprone(1);
  }
  self thread function_9f131b98();
  self playSound("zmb_fling_land");
  util::wait_network_frame();
  var_6a7beeb2 delete();
  self.is_flung = undefined;
  self.var_c7a6615d = undefined;
}

function function_121c6c1e() {
  v_position = self.origin + (randomfloatrange(-16, 16), randomfloatrange(-16, 16), 0);
  if(positionwouldtelefrag(v_position)) {
    self setorigin(self.origin + (randomfloatrange(-32, 32), randomfloatrange(-32, 32), 0));
  } else {
    self setorigin(v_position);
  }
}