/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_low_grav.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_timer;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_castle_zombie;
#namespace zm_castle_low_grav;

function autoexec __init__sytem__() {
  system::register("zm_castle_low_grav", &__init__, &__main__, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "low_grav_powerup_triggered", 5000, 1, "counter");
  clientfield::register("toplayer", "player_screen_fx", 5000, 1, "int");
  clientfield::register("toplayer", "player_postfx", 5000, 1, "int");
  clientfield::register("scriptmover", "undercroft_emissives", 5000, 1, "int");
  clientfield::register("scriptmover", "undercroft_wall_panel_shutdown", 5000, 1, "counter");
  clientfield::register("scriptmover", "zombie_wall_dust", 5000, 1, "counter");
  clientfield::register("scriptmover", "floor_panel_emissives_glow", 5000, 1, "int");
  level._effect["low_grav_player_jump"] = "dlc1/castle/fx_plyr_115_liquid_trail";
}

function __main__() {
  level flag::init("low_grav_countdown");
  level flag::init("low_grav_on");
  level.var_a75d7260 = getent("trig_low_gravity_zone", "targetname");
  level.func_override_wallbuy_prompt = &function_efa3deb8;
  level thread function_ab786717();
  level flag::wait_till("start_zombie_round_logic");
  level flag::init("pressure_pads_activated");
  level flag::init("undercroft_powerup_available");
  level flag::init("grav_off_for_ee");
  var_4603701d = getEntArray("undercroft_floater_scene", "targetname");
  level thread function_8b18e3ce();
  level function_3fa7f11a();
  level thread function_554db684();
  level thread function_644bd455();
  level thread function_2cb9125b();
  level thread function_8a1f0208();
}

function function_3fa7f11a() {
  level endon("pressure_pads_activated");
  var_15ed352b = getEntArray("grav_pad_trigger", "targetname");
  level.var_d19d5236 = 0;
  level.var_cddeb078 = [];
  foreach(var_3b9a12e0 in var_15ed352b) {
    var_3b9a12e0 thread function_e49e9c09();
    var_8ecbce0a = getent(var_3b9a12e0.target, "targetname");
    var_4f15c74f = getent(var_8ecbce0a.target, "targetname");
    array::add(level.var_cddeb078, var_4f15c74f);
  }
  while(level.var_d19d5236 < var_15ed352b.size) {
    wait(0.05);
  }
  foreach(var_3b9a12e0 in var_15ed352b) {
    var_544a882 = getent(var_3b9a12e0.target, "targetname");
  }
  level thread function_ed0d48ca();
  level flag::set("pressure_pads_activated");
}

function function_ed0d48ca() {
  wait(5);
  exploder::exploder_stop("lgt_grav_pad_n");
  exploder::exploder_stop("lgt_grav_pad_s");
  exploder::exploder_stop("lgt_grav_pad_e");
  exploder::exploder_stop("lgt_grav_pad_w");
}

function function_e49e9c09() {
  var_8ecbce0a = getent(self.target, "targetname");
  var_8ecbce0a enablelinkto();
  var_4f15c74f = getent(var_8ecbce0a.target, "targetname");
  var_4f15c74f enablelinkto();
  var_4f15c74f linkto(var_8ecbce0a);
  var_2e8e2853 = var_8ecbce0a.origin - vectorscale((0, 0, 1), 2);
  var_93f2a402 = var_8ecbce0a.origin;
  while(true) {
    self waittill("trigger", e_who);
    var_8ecbce0a moveto(var_2e8e2853, 0.5);
    playsoundatposition("evt_stone_plate_down", var_8ecbce0a.origin);
    var_8ecbce0a waittill("movedone");
    var_4f15c74f clientfield::set("undercroft_emissives", 1);
    n_start_time = gettime();
    n_end_time = n_start_time + 3000;
    while(e_who istouching(self)) {
      n_time = gettime();
      if(n_time >= n_end_time) {
        level.var_d19d5236++;
        exploder::exploder("lgt_" + self.script_string);
        playsoundatposition("evt_stone_plate_up", var_8ecbce0a.origin);
        e_who playrumbleonentity("zm_castle_low_grav_panel_rumble");
        return;
      }
      wait(0.05);
    }
    var_8ecbce0a moveto(var_93f2a402, 0.5);
    playsoundatposition("evt_stone_plate_down", var_8ecbce0a.origin);
    var_4f15c74f clientfield::set("undercroft_emissives", 0);
    var_4f15c74f clientfield::increment("undercroft_wall_panel_shutdown");
  }
}

function function_554db684() {
  setdvar("wallrun_enabled", 1);
  setdvar("doublejump_enabled", 1);
  setdvar("playerEnergy_enabled", 1);
  setdvar("bg_lowGravity", 300);
  setdvar("wallRun_maxTimeMs_zm", 10000);
  setdvar("playerEnergy_maxReserve_zm", 200);
  setdvar("wallRun_peakTest_zm", 0);
  level.var_a75d7260 = getent("trig_low_gravity_zone", "targetname");
  level thread function_fceff7eb();
}

function function_fceff7eb(n_duration = 50) {
  level endon("hash_9c3be857");
  level thread function_767bba0();
  while(true) {
    level flag::set("low_grav_on");
    level thread function_2f712e07();
    exploder::exploder("lgt_low_gravity_on");
    if(!(isDefined(level.var_513683a6) && level.var_513683a6)) {
      exploder::exploder("fxexp_117");
    }
    level clientfield::set("snd_low_gravity_state", 1);
    level clientfield::set("sndUEB", 1);
    wait(n_duration - 10);
    level function_e1998cb5();
    level flag::clear("low_grav_on");
    exploder::stop_exploder("lgt_low_gravity_on");
    level clientfield::set("snd_low_gravity_state", 0);
    level flag::wait_till_clear("grav_off_for_ee");
    wait(60);
  }
}

function function_e1998cb5() {
  level clientfield::set("snd_low_gravity_state", 2);
  level flag::set("low_grav_countdown");
  exploder::exploder("lgt_low_gravity_flash");
  wait(7);
  exploder::stop_exploder("lgt_low_gravity_flash");
  exploder::stop_exploder("fxexp_117");
  exploder::exploder("lgt_low_gravity_flash_fast");
  level clientfield::set("sndUEB", 0);
  wait(3);
  exploder::stop_exploder("lgt_low_gravity_flash_fast");
  level flag::clear("low_grav_countdown");
}

function function_3ccd9604() {
  self endon("death");
  while(true) {
    if(self istouching(level.var_a75d7260) && level flag::get("low_grav_on") && self.low_gravity == 0) {
      self zm_castle_zombie::set_gravity("low");
      self.low_gravity = 1;
    } else if(!self istouching(level.var_a75d7260) || !level flag::get("low_grav_on")) {
      self zm_castle_zombie::set_gravity("normal");
      self.low_gravity = 0;
    }
    wait(0.5);
  }
}

function function_f4766f6() {
  self endon("death");
  while(true) {
    if(self istouching(level.var_a75d7260) && level flag::get("low_grav_on") && (!(isDefined(self.low_gravity) && self.low_gravity))) {
      self ai::set_behavior_attribute("gravity", "low");
      self.low_gravity = 1;
    } else if(!self istouching(level.var_a75d7260) || !level flag::get("low_grav_on")) {
      self ai::set_behavior_attribute("gravity", "normal");
      self.low_gravity = 0;
    }
    wait(0.5);
  }
}

function function_c3f6aa22() {
  self endon("death");
  self endon("disconnect");
  level flag::wait_till("low_grav_on");
  self.var_7dd18a0 = 0;
  while(true) {
    while(self istouching(level.var_a75d7260)) {
      while(level flag::get("low_grav_on") && self istouching(level.var_a75d7260)) {
        if(self.var_7dd18a0 == 0) {
          self allowwallrun(1);
          self allowdoublejump(1);
          self setperk("specialty_lowgravity");
          self.var_7dd18a0 = 1;
          self clientfield::set_to_player("player_screen_fx", 1);
          self thread function_573a448e();
          self clientfield::set_to_player("player_postfx", 1);
          self thread function_e997f73a();
          if(getdvarint("") > 0) {
            setdvar("", getdvarint(""));
          }
        }
        wait(0.1);
      }
      if(self.var_7dd18a0 == 1) {
        self allowdoublejump(0);
        self allowwallrun(0);
        self unsetperk("specialty_lowgravity");
        self clientfield::set_to_player("player_screen_fx", 0);
        self clientfield::set_to_player("player_postfx", 0);
        self notify("hash_eb16fe00");
        self.var_7dd18a0 = 0;
      }
      wait(0.1);
    }
    wait(0.1);
  }
}

function function_e997f73a() {
  self endon("death");
  self endon("disconnect");
  self endon("hash_eb16fe00");
  while(true) {
    if(self isonground() || self iswallrunning()) {
      self setdoublejumpenergy(200);
    }
    wait(0.05);
  }
}

function function_573a448e() {
  self endon("death");
  self endon("disconnect");
  while(self.var_7dd18a0 == 1) {
    self waittill("jump_begin");
    var_5ed20759 = spawn("script_model", self.origin);
    var_5ed20759 setModel("tag_origin");
    var_5ed20759 enablelinkto();
    var_5ed20759 linkto(self, "j_spineupper");
    playFXOnTag(level._effect["low_grav_player_jump"], var_5ed20759, "tag_origin");
    while(!self isonground() || self iswallrunning() && level flag::get("low_grav_on")) {
      wait(0.5);
    }
    var_5ed20759 delete();
    wait(0.5);
  }
}

function function_767bba0() {
  level endon("hash_9c3be857");
  var_470f053a = struct::get_array("wall_buy_trigger", "targetname");
  var_6ad23999 = getEntArray("lowgrav_glow", "targetname");
  var_8ff7104f = getEntArray("pyramid", "targetname");
  var_6ad23999 = arraycombine(var_8ff7104f, var_6ad23999, 0, 0);
  while(true) {
    level flag::wait_till("low_grav_on");
    var_89ba571 = [];
    foreach(var_7b3fce7b in var_470f053a) {
      if(!(isDefined(var_7b3fce7b.activated) && var_7b3fce7b.activated)) {
        var_b8ac84e8 = getent(var_7b3fce7b.target, "targetname");
        array::add(var_89ba571, var_b8ac84e8);
      }
    }
    if(level flag::get("undercroft_powerup_available")) {
      array::add(var_89ba571, level.var_6f0e5d4c);
    }
    array::thread_all(var_89ba571, &clientfield::set, "undercroft_emissives", 1);
    array::thread_all(var_6ad23999, &clientfield::set, "undercroft_emissives", 1);
    array::thread_all(level.var_cddeb078, &clientfield::set, "floor_panel_emissives_glow", 1);
    level flag::wait_till("low_grav_countdown");
    wait(10);
    var_89ba571 = [];
    foreach(var_7b3fce7b in var_470f053a) {
      if(!(isDefined(var_7b3fce7b.activated) && var_7b3fce7b.activated)) {
        var_b8ac84e8 = getent(var_7b3fce7b.target, "targetname");
        array::add(var_89ba571, var_b8ac84e8);
      }
    }
    if(level flag::get("undercroft_powerup_available")) {
      array::add(var_89ba571, level.var_6f0e5d4c);
    }
    array::thread_all(var_6ad23999, &clientfield::set, "undercroft_emissives", 0);
    array::thread_all(var_89ba571, &clientfield::set, "undercroft_emissives", 0);
    array::thread_all(level.var_cddeb078, &clientfield::set, "floor_panel_emissives_glow", 0);
    level flag::wait_till_clear("low_grav_on");
  }
}

function function_2f712e07() {
  var_4603701d = getEntArray("undercroft_floater_model", "targetname");
  if(getdvarint("splitscreen_playerCount") > 2) {
    array::run_all(var_4603701d, &delete);
    return;
  }
  array::thread_all(var_4603701d, &function_5f2da053);
  level flag::wait_till("low_grav_countdown");
  var_3bebe64c = var_4603701d.size;
  var_d1d3b1 = 5;
  var_29be1256 = 5;
  var_2916f722 = int(var_3bebe64c / var_29be1256);
  var_398a5cc1 = var_d1d3b1 / var_29be1256;
  var_4603701d = array::randomize(var_4603701d);
  while(var_4603701d.size > 0) {
    for(i = 0; i < var_2916f722; i++) {
      var_4603701d[i] notify("hash_2f498788");
      var_4603701d = array::remove_index(var_4603701d, i);
      if(var_4603701d.size <= 1) {
        break;
      }
      n_rand_wait = randomfloatrange(0, 0.5);
      wait(n_rand_wait);
    }
    wait(var_398a5cc1);
  }
}

function function_5f2da053() {
  wait(randomfloatrange(0, 1));
  switch (self.model) {
    case "p7_fxanim_zm_castle_undercroft_floaters_books_mod": {
      str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_books_bundle";
      break;
    }
    case "p7_fxanim_zm_castle_undercroft_floaters_candles_mod": {
      str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_candles_bundle";
      break;
    }
    case "p7_fxanim_zm_castle_undercroft_floaters_rocks_mod": {
      str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_rocks_bundle";
      break;
    }
    case "p7_fxanim_zm_castle_undercroft_floaters_skull_mod": {
      str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_skull_bundle";
      break;
    }
    case "p7_fxanim_zm_castle_undercroft_floaters_toolbox_mod": {
      str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_toolbox_bundle";
      break;
    }
    case "p7_fxanim_zm_castle_undercroft_floaters_urn_mod": {
      str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_urn_bundle";
      break;
    }
  }
  self playLoopSound("zmb_low_grav_item_loop");
  self scene::play(str_scene_name + "_up", self);
  self thread scene::play(str_scene_name + "_idle", self);
  self waittill("hash_2f498788");
  self thread scene::play(str_scene_name + "_down", self);
  self stoploopsound();
}

function function_8b18e3ce() {
  level endon("hash_6580ea04");
  function_7f2caa5(2, "pistol_burst");
  if(level.round_number != 2) {
    return;
  }
  function_7f2caa5(4, "ar_marksman");
  function_7f2caa5(5, "pistol_burst");
  var_d99e0864 = getent("zm_fam", "targetname");
  if(!isDefined(var_d99e0864)) {
    return;
  }
  var_feb1d46b = struct::get("s_zm_fam_loc", "targetname");
  if(!isDefined(var_feb1d46b)) {
    return;
  }
  e_floor = getent("zm_fam_floor", "targetname");
  if(!isDefined(e_floor)) {
    return;
  }
  level thread function_f67d5866();
  level.players[0] util::waittill_player_looking_at(var_feb1d46b.origin + vectorscale((0, 0, 1), 50), 90);
  level notify("hash_d64d78d6");
  var_d99e0864.origin = var_feb1d46b.origin + vectorscale((0, 0, 1), 64);
  e_floor.origin = var_feb1d46b.origin;
  e_floor enablelinkto();
  var_5ed20759 = spawn("script_model", var_feb1d46b.origin);
  var_5ed20759 setModel("p7_zm_zod_stage_heart_frame");
  e_floor linkto(var_5ed20759);
  for(i = 0; i < 500; i++) {
    var_5ed20759 rotateto(var_5ed20759.angles + vectorscale((0, 1, 0), 180), 3);
    var_5ed20759 waittill("rotatedone");
  }
  var_d99e0864 delete();
  var_5ed20759 delete();
  e_floor delete();
}

function function_f67d5866() {
  level endon("hash_d64d78d6");
  wait(5);
  level notify("hash_6580ea04");
}

function function_7f2caa5(n_num, var_42133686) {
  level waittill("weapon_bought", player, weapon);
  if(weapon.name != var_42133686) {
    level notify("hash_6580ea04");
    return;
  }
  foreach(barrier in level.exterior_goals) {
    if(issubstr(barrier.script_string, "start_set")) {
      var_c5f3d26a = 0;
      for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++) {
        if(barrier.zbarrier getzbarrierpiecestate(x) == "closed") {
          var_c5f3d26a++;
        }
      }
      if(var_c5f3d26a != n_num) {
        level notify("hash_6580ea04");
        return;
      }
    }
  }
}

function function_644bd455() {
  a_traps = struct::get_array("low_grav_trap", "targetname");
  array::thread_all(a_traps, &function_d09bda12);
}

function function_d09bda12() {
  var_60532813 = getent(self.script_noteworthy, "targetname");
  self.trap_available = 1;
  var_c5728235 = getent(self.script_string, "targetname");
  var_6b2a60d = getent(self.target, "targetname");
  var_c5728235 enablelinkto();
  var_c5728235 linkto(var_6b2a60d);
  var_c5728235 thread trigger_damage();
  while(true) {
    var_60532813 waittill("trigger", e_player);
    n_distance = distance2d(e_player.origin, self.origin);
    if(e_player.var_b94b5f2f == 1 && self.trap_available == 1 && n_distance > 500 && n_distance < 1000 && e_player iswallrunning() && !level.dog_intermission) {
      e_player thread function_d04113df(3);
      n_rand = randomfloatrange(0, 1);
      if(n_rand < 0.33) {
        self thread function_30b0d4ab(8);
        self thread function_e7a4bc31(e_player);
      }
    }
  }
}

function function_e7a4bc31(e_player) {
  var_6b2a60d = getent(self.target, "targetname");
  var_6b2a60d.original_location = var_6b2a60d.origin;
  var_477663ed = (anglesToForward(self.origin) * 25) + self.origin;
  var_6b2a60d moveto(var_477663ed, 1);
  s_anim_struct = struct::get(var_6b2a60d.target, "targetname");
  var_bb7b50d = zombie_utility::spawn_zombie(level.zombie_spawners[0], "wall_trap_zombie", s_anim_struct, 1);
  var_bb7b50d.health = 5;
  var_bb7b50d thread function_f7d8fe24(var_6b2a60d);
  var_5ed20759 = spawn("script_model", s_anim_struct.origin);
  var_5ed20759 setModel("tag_origin");
  var_5ed20759.angles = s_anim_struct.angles;
  util::wait_network_frame();
  var_5ed20759 clientfield::increment("zombie_wall_dust");
  if(self.script_int == 1) {
    var_5ed20759 playSound("zmb_zombie_wall_spawn");
    var_5ed20759 scene::play("cin_zm_castle_wall_zombie_right_intro", var_bb7b50d);
    var_5ed20759 scene::play("cin_zm_castle_wall_zombie_right_main", var_bb7b50d);
    var_6b2a60d moveto(var_6b2a60d.original_location, 1);
    if(isalive(var_bb7b50d)) {
      var_5ed20759 scene::play("cin_zm_castle_wall_zombie_right_outro", var_bb7b50d);
      var_bb7b50d notify("hash_6815f745");
      var_bb7b50d delete();
      var_6b2a60d.origin = var_6b2a60d.original_location;
    }
  } else {
    var_5ed20759 playSound("zmb_zombie_wall_spawn");
    var_5ed20759 scene::play("cin_zm_castle_wall_zombie_left_intro", var_bb7b50d);
    var_5ed20759 scene::play("cin_zm_castle_wall_zombie_left_main", var_bb7b50d);
    var_6b2a60d moveto(var_6b2a60d.original_location, 1);
    if(isalive(var_bb7b50d)) {
      var_5ed20759 scene::play("cin_zm_castle_wall_zombie_left_outro", var_bb7b50d);
      var_bb7b50d notify("hash_6815f745");
      var_bb7b50d delete();
      var_6b2a60d.origin = var_6b2a60d.original_location;
    }
    var_5ed20759 delete();
  }
}

function function_d04113df(n_wait_time) {
  self notify("new_timer");
  self endon("new_timer");
  self endon("death");
  self endon("disconnect");
  self.var_b94b5f2f = 0;
  wait(n_wait_time);
  self.var_b94b5f2f = 1;
}

function function_30b0d4ab(n_wait_time) {
  self notify("new_timer");
  self endon("new_timer");
  self.trap_available = 0;
  wait(n_wait_time);
  self.trap_available = 1;
}

function trigger_damage() {
  while(true) {
    self waittill("trigger", e_who);
    if(isplayer(e_who) && (!(isDefined(e_who.var_c54a399c) && e_who.var_c54a399c))) {
      e_who dodamage(25, e_who.origin, undefined, undefined, "none", "MOD_MELEE");
      e_who.var_c54a399c = 1;
      e_who thread function_266e5562();
    }
    wait(0.05);
  }
}

function function_266e5562() {
  self endon("death");
  self endon("disconnect");
  wait(0.5);
  self.var_c54a399c = 0;
}

function function_f7d8fe24(var_6b2a60d) {
  self endon("hash_6815f745");
  self.no_powerups = 1;
  self waittill("death");
  var_6b2a60d.origin = var_6b2a60d.original_location;
  level.zombie_total++;
  gibserverutils::annihilate(self);
}

function function_2cb9125b() {
  var_9369bf6c = struct::get("powerup_button", "targetname");
  s_unitrigger_stub = spawnStruct();
  s_unitrigger_stub.origin = var_9369bf6c.origin;
  s_unitrigger_stub.angles = var_9369bf6c.angles;
  s_unitrigger_stub.script_unitrigger_type = "unitrigger_box";
  s_unitrigger_stub.cursor_hint = "HINT_NOICON";
  s_unitrigger_stub.require_look_at = 0;
  s_unitrigger_stub.script_length = 32;
  s_unitrigger_stub.script_width = 64;
  s_unitrigger_stub.script_height = 64;
  s_unitrigger_stub.var_bf3837fa = var_9369bf6c;
  level flag::set("undercroft_powerup_available");
  level.var_57c06a96 = 1;
  s_unitrigger_stub.prompt_and_visibility_func = &function_94073af5;
  level.var_6f0e5d4c = getent(var_9369bf6c.target, "targetname");
  thread zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, &function_81be0b2f);
}

function function_94073af5(player) {
  if(level.round_number >= level.var_57c06a96) {
    return true;
  }
  return false;
}

function function_81be0b2f() {
  e_player = self.parent_player;
  if(e_player iswallrunning() && level flag::get("undercroft_powerup_available")) {
    level flag::clear("undercroft_powerup_available");
    var_7c68b1e = getent(self.stub.var_bf3837fa.target, "targetname");
    var_17ff3d6f = vectornormalize(anglesToForward(self.stub.var_bf3837fa.angles)) * 0;
    var_e16f14a2 = var_17ff3d6f + var_7c68b1e.origin;
    var_7c68b1e.old_origin = var_7c68b1e.origin;
    var_7c68b1e moveto(var_e16f14a2, 0.5);
    var_7c68b1e clientfield::increment("low_grav_powerup_triggered");
    e_player playrumbleonentity("zm_castle_low_grav_panel_rumble");
    level.var_6f0e5d4c clientfield::increment("undercroft_wall_panel_shutdown");
    self thread function_34091daf(var_7c68b1e);
  }
}

function function_34091daf(var_7c68b1e) {
  var_c21c2ac2 = struct::get("low_grav_powerup_spawn", "targetname");
  powerup = zm_powerups::specific_powerup_drop("minigun", var_c21c2ac2.origin);
  level thread function_42dee8e(var_7c68b1e, powerup, self.stub);
  level thread powerup_timer(var_7c68b1e, powerup, self.stub);
}

function function_42dee8e(var_7c68b1e, powerup, unitrigger_stub) {
  level endon("hash_558a2606");
  powerup waittill("powerup_grabbed");
  level.var_57c06a96 = level.round_number + randomintrange(3, 5);
  level thread function_34029460(var_7c68b1e, unitrigger_stub);
}

function function_34029460(var_7c68b1e, unitrigger_stub) {
  while(true) {
    level waittill("start_of_round");
    if(level.round_number >= level.var_57c06a96) {
      var_7c68b1e moveto(var_7c68b1e.old_origin, 0.5);
      level flag::set("undercroft_powerup_available");
      break;
    }
  }
}

function powerup_timer(var_7c68b1e, powerup, unitrigger_stub) {
  powerup endon("powerup_grabbed");
  wait(10);
  level notify("hash_558a2606");
  powerup zm_powerups::powerup_delete();
  wait(50);
  var_7c68b1e moveto(var_7c68b1e.old_origin, 0.5);
  level flag::set("undercroft_powerup_available");
}

function function_8a1f0208() {
  level.var_aed784b3 = 0;
  var_15ed352b = struct::get_array("wall_buy_trigger", "targetname");
  for(i = 0; i < var_15ed352b.size; i++) {
    var_15ed352b[i] thread function_20c76956();
  }
}

function function_20c76956() {
  s_unitrigger_stub = spawnStruct();
  s_unitrigger_stub.origin = self.origin;
  s_unitrigger_stub.angles = self.angles;
  s_unitrigger_stub.script_unitrigger_type = "unitrigger_box";
  s_unitrigger_stub.cursor_hint = "HINT_NOICON";
  s_unitrigger_stub.require_look_at = 0;
  s_unitrigger_stub.script_length = 32;
  s_unitrigger_stub.script_width = 64;
  s_unitrigger_stub.script_height = 64;
  s_unitrigger_stub.var_bf3837fa = self;
  s_unitrigger_stub.var_bf3837fa.activated = 0;
  thread zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, &function_147f328);
}

function function_147f328(var_607fccfa) {
  e_player = self.parent_player;
  if(e_player iswallrunning() && self.stub.var_bf3837fa.activated == 0) {
    self.stub.var_bf3837fa.activated = 1;
    var_544a882 = getent(self.stub.var_bf3837fa.target, "targetname");
    playsoundatposition("evt_stone_plate_down", var_544a882.origin);
    e_player playrumbleonentity("zm_castle_low_grav_panel_rumble");
    level.var_aed784b3++;
    var_1b02ae62 = struct::get_array("wall_buy_trigger", "targetname");
    if(level.var_aed784b3 >= var_1b02ae62.size) {
      var_cd1d0af1 = getent("brm_door", "targetname");
      var_cd1d0af1 movez(-20, 2, 0, 1.5);
    }
    var_544a882 clientfield::increment("undercroft_wall_panel_shutdown");
  }
}

function function_efa3deb8(e_player) {
  if(self.weapon.name == "lmg_light") {
    var_15ed352b = struct::get_array("wall_buy_trigger", "targetname");
    if(level.var_aed784b3 >= var_15ed352b.size) {
      return true;
    }
    self.stub.hint_string = "";
    self sethintstring("");
    self.stub.cursor_hint = "HINT_NOICON";
    self setcursorhint("HINT_NOICON");
    return false;
  }
  return true;
}

function detect_reentry() {
  if(isDefined(self.var_8665ab89)) {
    if(self.var_8665ab89 == gettime()) {
      return true;
    }
  }
  self.var_8665ab89 = gettime();
  return false;
}

function function_ab786717() {
  level flagsys::wait_till("");
  wait(1);
  zm_devgui::add_custom_devgui_callback(&function_e41a2453);
  adddebugcommand("");
}

function function_e41a2453(cmd) {
  switch (cmd) {
    case "": {
      if(level detect_reentry()) {
        return true;
      }
      level notify("hash_9c3be857");
      level thread function_fceff7eb(9999);
      return true;
    }
  }
  return false;
}