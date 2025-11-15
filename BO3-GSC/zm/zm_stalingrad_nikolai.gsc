/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_nikolai.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\music_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_sentinel_drone;
#using scripts\zm\_load;
#using scripts\zm\_util;
#using scripts\zm\_zm_ai_raz;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\zm_siegebot_nikolai;
#using scripts\zm\zm_stalingrad_audio;
#using scripts\zm\zm_stalingrad_dragon;
#using scripts\zm\zm_stalingrad_drop_pods;
#using scripts\zm\zm_stalingrad_ee_main;
#using scripts\zm\zm_stalingrad_pap_quest;
#using scripts\zm\zm_stalingrad_util;
#using scripts\zm\zm_stalingrad_vo;
#namespace zm_stalingrad_nikolai;

function main() {
  level flag::init("nikolai_start");
  level flag::init("nikolai_complete");
  level thread function_885ea49f();
  level flag::wait_till("nikolai_start");
  util::clientnotify("nbs");
  level clientfield::set("deactivate_ai_vox", 1);
  level thread zm_stalingrad_audio::function_f1ce2a9a(1);
  level function_cf4e4fc1();
}

function function_cf4e4fc1() {
  level scene::init("cin_sta_outro_3rd_sh020");
  zm_spawner::deregister_zombie_death_event_callback( & namespace_2e6e7fce::function_1389d425);
  level flag::clear("zombie_drop_powerups");
  level.whelp_no_power_up_pickup = 1;
  level function_6afa5293();
  wait(0.05);
  level.var_cf6e9729 thread function_d9ffbd23();
  level flag::wait_till("nikolai_complete");
  foreach(e_player in level.players) {
    e_player.var_4222bc21 = 1;
  }
  level thread zm_stalingrad_util::function_adf4d1d0();
  zombie_utility::ai_calculate_health(level.round_number);
  level thread zm_stalingrad_audio::function_f1ce2a9a(4);
  level clientfield::set("deactivate_ai_vox", 0);
  util::clientnotify("nbstp");
  function_a21082e5();
}

function function_a21082e5() {
  var_77857680 = getEntArray("boss_arena_blocker", "targetname");
  n_wait = getanimlength("ai_zm_dlc3_russian_mech_dth");
  foreach(player in level.players) {
    if(player laststand::player_is_in_laststand()) {
      player reviveplayer();
      player notify("player_revived");
      player notify("stop_revive_trigger");
      if(isDefined(player.revivetrigger)) {
        player.revivetrigger delete();
        player.revivetrigger = undefined;
      }
    }
  }
  level thread zm_stalingrad_ee_main::ee_outro(n_wait);
  level waittill("hash_19aa582d");
  zm_spawner::register_zombie_death_event_callback( & namespace_2e6e7fce::function_1389d425);
  level flag::set("zombie_drop_powerups");
  level.whelp_no_power_up_pickup = undefined;
  var_5b2e05a8 = struct::get_array("boss_complete_return_point", "targetname");
  n_player = 0;
  zm_stalingrad_util::function_4da6e8(1);
  foreach(player in level.players) {
    player setorigin(var_5b2e05a8[n_player].origin);
    player setplayerangles(var_5b2e05a8[n_player].angles);
    n_player++;
  }
  foreach(var_f26a7c29 in var_77857680) {
    var_f26a7c29 delete();
    util::wait_network_frame();
  }
  level flag::clear("players_in_arena");
  level.var_6d27427c = undefined;
  level.var_b9c4d468 = undefined;
  level.var_9ddab511 = undefined;
  level.var_5fe02c5a = undefined;
}

function function_885ea49f() {
  level endon("intermission");
  var_77857680 = getEntArray("dragon_boss_blocker", "targetname");
  var_3e7d18ce = getEntArray("dragon_boss_blocker_clip", "targetname");
  foreach(var_9c1f0837 in var_3e7d18ce) {
    var_9c1f0837 disconnectpaths();
  }
  var_c341c732 = getent("dragon_boss_blocker_clip_vehicle", "targetname");
  var_c341c732 disconnectpaths();
  var_c341c732 notsolid();
  level flag::wait_till("nikolai_start");
  foreach(var_9c1f0837 in var_3e7d18ce) {
    var_9c1f0837 connectpaths();
    var_9c1f0837 delete();
  }
  foreach(var_f26a7c29 in var_77857680) {
    var_f26a7c29 delete();
  }
}

function function_6afa5293() {
  level.var_cf6e9729 = spawner::simple_spawn_single("siegebot_nikolai");
  level.var_cf6e9729.b_ignore_cleanup = 1;
  level.var_cf6e9729.targetname = "nikolai_siegebot";
  level.var_cf6e9729.ignore_nuke = 1;
  level.var_cf6e9729.ignore_round_robbin_death = 1;
  level.var_cf6e9729.b_ignore_mark3_pulse_damage = 1;
  level.var_cf6e9729 enablelinkto();
  var_729f9335 = level.var_cf6e9729 gettagorigin("tag_driver");
  var_febde835 = level.var_cf6e9729 gettagangles("tag_driver");
  level.var_cf6e9729.var_fa4643fb = util::spawn_model("c_zom_dlc_waw_nikolai_fb", var_729f9335, var_febde835);
  level.var_cf6e9729 thread siegebot_nikolai::function_f7035c2f(level.var_cf6e9729.var_fa4643fb);
  level.var_cf6e9729.allowdeath = 0;
  level.var_cf6e9729 sethighdetail(0);
  level.var_cf6e9729.var_cba3d62a = struct::get_array("boss_arena_move", "targetname");
  level.var_cf6e9729.var_62fb9a9f = struct::get_array("boss_arena_jump");
  level.var_cf6e9729.var_62fb9a9f = arraycombine(level.var_cf6e9729.var_62fb9a9f, level.var_cf6e9729.var_cba3d62a, 0, 0);
  level.var_cf6e9729.var_64627ad6 = "north";
  level.var_cf6e9729.var_36fb48d9[1] = 22;
  level.var_cf6e9729.var_36fb48d9[2] = 30;
  level.var_cf6e9729.var_36fb48d9[3] = 36;
  level.var_cf6e9729.var_36fb48d9[4] = 44;
  level.var_cf6e9729.var_5b7a19fe[1] = 14;
  level.var_cf6e9729.var_5b7a19fe[2] = 16;
  level.var_cf6e9729.var_5b7a19fe[3] = 19;
  level.var_cf6e9729.var_5b7a19fe[4] = 22;
  level.var_cf6e9729.var_4266e1d4[1] = 6;
  level.var_cf6e9729.var_4266e1d4[2] = 8;
  level.var_cf6e9729.var_4266e1d4[3] = 10;
  level.var_cf6e9729.var_4266e1d4[4] = 14;
  level.var_cf6e9729.var_ea7d582d[1] = 2;
  level.var_cf6e9729.var_ea7d582d[2] = 3;
  level.var_cf6e9729.var_ea7d582d[3] = 4;
  level.var_cf6e9729.var_ea7d582d[4] = 5;
  level.var_cf6e9729.var_9310b6ba = [];
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_trench_northeast", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_trench_northwest", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_trench_southwest", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_trench_southeast", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_balcony_south", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_balcony_west", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_balcony_east", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_ruins_south", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_ruins_west", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_ruins_east", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_center_northeast", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_center_northwest", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_center_southwest", "targetname");
  if(!isDefined(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = [];
  } else if(!isarray(level.var_cf6e9729.var_9310b6ba)) {
    level.var_cf6e9729.var_9310b6ba = array(level.var_cf6e9729.var_9310b6ba);
  }
  level.var_cf6e9729.var_9310b6ba[level.var_cf6e9729.var_9310b6ba.size] = getent("boss_center_southeast", "targetname");
  level.var_cf6e9729 function_c291114d();
  util::wait_network_frame();
  var_41b8920e = struct::get_array("s_nikolai_debug_player", "targetname");
  n_player = 0;
  foreach(player in level.activeplayers) {
    player setorigin(var_41b8920e[n_player].origin);
    player setplayerangles(var_41b8920e[n_player].angles);
    n_player++;
    player.ignoreme = 0;
  }
  level.var_cf6e9729 thread function_1679e5f0();
  level.var_cf6e9729 thread function_b79713c();
  level.var_cf6e9729 thread zm_stalingrad_vo::function_cd0b1f13();
  level.var_cf6e9729 thread function_f8190c14();
  level.var_cf6e9729.func_mod_damage_override = & function_934917cc;
  level.var_cf6e9729.var_a555da3c = getweapon("spike_charge_siegebot_harpoon");
  level.var_cf6e9729.var_70fcb15a = getweapon("siegebot_gatling_turret");
}

function function_f8190c14() {
  level endon("nikolai_complete");
  level waittill("intermission");
  if(isDefined(level.var_cf6e9729)) {
    level.var_cf6e9729.overridevehicledamage = undefined;
  }
}

function function_d9ffbd23() {
  level endon("nikolai_complete");
  level endon("intermission");
  self endon("death");
  n_wait = 0.25;
  var_15518756 = 3;
  self.var_7231744c = 0;
  wait(n_wait);
  while(true) {
    if(!(isDefined(self.var_7231744c) && self.var_7231744c) && randomint(100) >= 94) {
      self thread zm_stalingrad_vo::function_6d6eb04e();
    } else {
      self thread zm_stalingrad_vo::function_90f2084c();
    }
    if(isDefined(self.var_a0c38d8) && self.var_a0c38d8) {
      var_15518756 = 2;
      self.var_7231744c = 1;
    }
    for(i = 0; i < var_15518756; i++) {
      self function_39d2d4b6();
      if(i < (var_15518756 - 1)) {
        self flag::set("halt_thread_gun");
        self function_f56920ff(self.var_54fa7d2c);
        self flag::clear("halt_thread_gun");
      }
    }
    self flag::set("halt_thread_gun");
    self function_3c68f919();
    self function_f56920ff(self.var_8d725883);
    if(isDefined(self.var_a0c38d8) && self.var_a0c38d8) {
      self function_3c68f919(1);
      self function_f56920ff(self.var_8d725883);
    }
    self function_3c68f919();
    self flag::clear("halt_thread_gun");
  }
  wait(n_wait);
}

function function_c291114d() {
  self.var_54fa7d2c = [];
  if(!isDefined(self.var_54fa7d2c)) {
    self.var_54fa7d2c = [];
  } else if(!isarray(self.var_54fa7d2c)) {
    self.var_54fa7d2c = array(self.var_54fa7d2c);
  }
  self.var_54fa7d2c[self.var_54fa7d2c.size] = & function_29d15688;
  if(!isDefined(self.var_54fa7d2c)) {
    self.var_54fa7d2c = [];
  } else if(!isarray(self.var_54fa7d2c)) {
    self.var_54fa7d2c = array(self.var_54fa7d2c);
  }
  self.var_54fa7d2c[self.var_54fa7d2c.size] = & function_960cbfc1;
  if(!isDefined(self.var_54fa7d2c)) {
    self.var_54fa7d2c = [];
  } else if(!isarray(self.var_54fa7d2c)) {
    self.var_54fa7d2c = array(self.var_54fa7d2c);
  }
  self.var_54fa7d2c[self.var_54fa7d2c.size] = & function_8b21fdfe;
  self.var_8d725883 = [];
  if(!isDefined(self.var_8d725883)) {
    self.var_8d725883 = [];
  } else if(!isarray(self.var_8d725883)) {
    self.var_8d725883 = array(self.var_8d725883);
  }
  self.var_8d725883[self.var_8d725883.size] = & function_960cbfc1;
  if(!isDefined(self.var_8d725883)) {
    self.var_8d725883 = [];
  } else if(!isarray(self.var_8d725883)) {
    self.var_8d725883 = array(self.var_8d725883);
  }
  self.var_8d725883[self.var_8d725883.size] = & function_8b21fdfe;
  if(level flag::exists("")) {
    func_override = & function_29d15688;
  } else {
    if(level flag::exists("")) {
      func_override = & function_960cbfc1;
    } else if(level flag::exists("")) {
      func_override = & function_8b21fdfe;
    }
  }
  if(isDefined(func_override)) {
    for(i = 0; i < self.var_54fa7d2c.size; i++) {
      self.var_54fa7d2c[i] = func_override;
    }
    for(i = 0; i < self.var_8d725883.size; i++) {
      self.var_8d725883[i] = func_override;
    }
    return;
  }
  self thread function_57b59893();
  self thread function_b8f2ff49();
}

function function_57b59893() {
  self endon("death");
  self waittill("hash_5eb926b6");
  if(!isDefined(self.var_8d725883)) {
    self.var_8d725883 = [];
  } else if(!isarray(self.var_8d725883)) {
    self.var_8d725883 = array(self.var_8d725883);
  }
  self.var_8d725883[self.var_8d725883.size] = & function_29d15688;
  if(!isDefined(self.var_54fa7d2c)) {
    self.var_54fa7d2c = [];
  } else if(!isarray(self.var_54fa7d2c)) {
    self.var_54fa7d2c = array(self.var_54fa7d2c);
  }
  self.var_54fa7d2c[self.var_54fa7d2c.size] = & function_8b21fdfe;
}

function function_b8f2ff49() {
  self endon("death");
  self waittill("hash_ae5c218");
  if(!isDefined(self.var_8d725883)) {
    self.var_8d725883 = [];
  } else if(!isarray(self.var_8d725883)) {
    self.var_8d725883 = array(self.var_8d725883);
  }
  self.var_8d725883[self.var_8d725883.size] = & function_960cbfc1;
}

function function_f56920ff(var_d4d0fbf9) {
  level endon("intermission");
  if(!isDefined(self.favoriteenemy) || !isalive(self.favoriteenemy) || self.favoriteenemy laststand::player_is_in_laststand()) {
    self function_1d0e6184();
  }
  e_enemy = self.favoriteenemy;
  foreach(var_eb96527b in level.var_cf6e9729.var_9310b6ba) {
    if(e_enemy istouching(var_eb96527b)) {
      var_ed7a7e87 = strtok(var_eb96527b.targetname, "_");
      break;
    }
  }
  switch (var_ed7a7e87[1]) {
    case "trench": {
      if(!isDefined(level.var_5fe02c5a)) {
        var_a4787ecd = & function_29d15688;
      }
      break;
    }
    case "balcony": {
      var_a4787ecd = & function_960cbfc1;
      break;
    }
    case "ruins": {
      var_a4787ecd = & function_8b21fdfe;
      break;
    }
  }
  if(isDefined(var_a4787ecd) && math::cointoss()) {
    [[var_a4787ecd]]();
  }
  if(isDefined(level.var_5fe02c5a)) {
    arrayremovevalue(var_d4d0fbf9, & function_29d15688);
  }
  [[array::random(var_d4d0fbf9)]]();
}

function function_29d15688() {
  if(getdvarint("") > 0) {
    debug = getdvarint("");
    if(debug !== 0 && debug !== 3) {
      wait(0.05);
      return;
    }
  }
  iprintlnbold("");
  level.var_5fe02c5a = 18;
  self siegebot_nikolai::function_59fe8c9c(self.favoriteenemy.origin);
  iprintlnbold("");
}

function function_960cbfc1() {
  if(getdvarint("") > 0) {
    debug = getdvarint("");
    if(debug !== 0 && debug !== 2) {
      wait(0.05);
      return;
    }
  }
  iprintlnbold("");
  self siegebot_nikolai::function_dfc5ede1(self.favoriteenemy);
  iprintlnbold("");
}

function function_8b21fdfe() {
  if(getdvarint("") > 0) {
    debug = getdvarint("");
    if(debug !== 0 && debug !== 1) {
      wait(0.05);
      return;
    }
  }
  iprintlnbold("");
  self siegebot_nikolai::function_a3258c2a(6);
  iprintlnbold("");
}

function function_39d2d4b6() {
  self notify("reselect_goal");
  self endon("death");
  if(getdvarint("") > 0) {
    debug = getdvarint("");
    if(debug !== 0) {
      wait(0.05);
      return;
    }
  }
  var_d3ffff5c = arraycopy(self.var_cba3d62a);
  var_d3ffff5c = array::filter(var_d3ffff5c, 0, & function_f75d4706, self.var_64627ad6);
  var_73c9db2b = var_d3ffff5c[randomintrange(0, var_d3ffff5c.size)];
  self.var_64627ad6 = var_73c9db2b.script_string;
  self siegebot_nikolai::face_target(var_73c9db2b.origin, 30);
  self setgoal(var_73c9db2b.origin);
  self util::waittill_any_timeout(20, "near_goal", "death");
  self clearforcedgoal();
}

function function_f75d4706(s_pos, str_pos) {
  if(s_pos.script_string == str_pos) {
    return false;
  }
  switch (str_pos) {
    case "north": {
      if(s_pos.script_string == "south") {
        return false;
      }
      break;
    }
    case "east": {
      if(s_pos.script_string == "west") {
        return false;
      }
      break;
    }
    case "south": {
      if(s_pos.script_string == "north") {
        return false;
      }
      break;
    }
    case "west": {
      if(s_pos.script_string == "east") {
        return false;
      }
      break;
    }
  }
  return true;
}

function function_3c68f919(var_74557a8b) {
  self notify("reselect_goal");
  level endon("nikolai_complete");
  self endon("death");
  if(getdvarint("") > 0) {
    debug = getdvarint("");
    if(debug !== 0) {
      wait(0.05);
      return;
    }
  }
  switch (self.var_64627ad6) {
    case "northeast": {
      if(isDefined(var_74557a8b) && var_74557a8b) {
        str_target = "southwest";
      } else {
        str_target = "south";
      }
      break;
    }
    case "northwest": {
      if(isDefined(var_74557a8b) && var_74557a8b) {
        str_target = "southeast";
      } else {
        str_target = "east";
      }
      break;
    }
    case "southeast": {
      if(isDefined(var_74557a8b) && var_74557a8b) {
        str_target = "northwest";
      } else {
        str_target = "west";
      }
      break;
    }
    case "southwest": {
      if(isDefined(var_74557a8b) && var_74557a8b) {
        str_target = "northeast";
      } else {
        str_target = "north";
      }
      break;
    }
    case "south": {
      str_target = "northeast";
      break;
    }
    case "east": {
      str_target = "northwest";
      break;
    }
    case "west": {
      str_target = "southeast";
      break;
    }
    case "north": {
      str_target = "southwest";
      break;
    }
  }
  foreach(var_1da6c387 in self.var_62fb9a9f) {
    if(var_1da6c387.script_string == str_target) {
      s_point = var_1da6c387;
      break;
    }
  }
  if(!isDefined(s_point)) {
    self function_39d2d4b6();
    return;
  }
  var_b06830e5 = self siegebot_nikolai::jump_to(s_point.origin);
  if(var_b06830e5) {
    self waittill("jump_finished");
    self.var_64627ad6 = s_point.script_string;
  } else {
    self function_39d2d4b6();
  }
}

function function_1d0e6184() {
  level endon("nikolai_complete");
  var_3a73aa84 = undefined;
  while(!isDefined(var_3a73aa84)) {
    foreach(player in level.activeplayers) {
      if(zombie_utility::is_player_valid(player, 1)) {
        if(!isDefined(var_3a73aa84) || player.var_b3a9099 >= var_3a73aa84.var_b3a9099) {
          var_3a73aa84 = player;
        }
      }
    }
    if(isDefined(var_3a73aa84)) {
      break;
    }
    wait(0.2);
  }
  if(randomint(100) > 33) {
    self function_211641b9();
  }
  self.favoriteenemy = var_3a73aa84;
}

function function_211641b9() {
  level endon("nikolai_complete");
  foreach(e_player in level.players) {
    e_player.var_b3a9099 = 0;
  }
}

function function_1679e5f0() {
  self endon("death");
  level endon("intermission");
  level.var_6d27427c = 0;
  level.var_b9c4d468 = 0;
  level.var_9ddab511 = & function_6e418eff;
  if(level.round_number < 20) {
    zombie_utility::ai_calculate_health(20);
  }
  var_238bb684 = struct::get("boss_arena_center", "targetname");
  var_cbcef56 = self.var_36fb48d9[level.activeplayers.size];
  var_84a0beb8 = self.var_5b7a19fe[level.activeplayers.size];
  var_2b71b5b4 = self.var_4266e1d4[level.players.size];
  var_c444a38d = self.var_ea7d582d[level.players.size];
  var_67441125 = 3;
  var_b4fcee85 = int((var_cbcef56 / var_2b71b5b4) / 2);
  var_ad0ee644 = struct::get_array("boss_arena_spawn", "targetname");
  var_ad0ee644 = array::filter(var_ad0ee644, 0, & zm_stalingrad_util::function_c66f2957);
  level.var_c3c3ffc5 = [];
  if(!isDefined(level.var_c3c3ffc5)) {
    level.var_c3c3ffc5 = [];
  } else if(!isarray(level.var_c3c3ffc5)) {
    level.var_c3c3ffc5 = array(level.var_c3c3ffc5);
  }
  level.var_c3c3ffc5[level.var_c3c3ffc5.size] = self;
  level thread function_830cf1ca();
  wait(3);
  while(isDefined(self) && (!(isDefined(self.var_a0c38d8) && self.var_a0c38d8))) {
    nospawn = getdvarint("");
    if(nospawn) {
      wait(3);
      continue;
    }
    level thread zm_stalingrad_util::function_b55ebb81(undefined, var_2b71b5b4, var_c444a38d, var_67441125, var_b4fcee85, "nikolai_final_weakpoint_revealed", 1);
    level zm_stalingrad_util::function_f70dde0b(level.zombie_spawners[0], var_ad0ee644, "boss_arena_spawn", var_84a0beb8, 0.5, var_cbcef56, "nikolai_final_weakpoint_revealed", 0);
    level flag::wait_till_timeout(15, "wave_event_raz_spawning_active");
    wait(5);
    var_cbcef56 = var_cbcef56 + 2;
    var_2b71b5b4 = var_2b71b5b4 + 1;
  }
  var_c444a38d = var_c444a38d + level.players.size;
  level thread zm_stalingrad_util::function_b55ebb81(undefined, undefined, var_c444a38d, var_67441125, undefined, "nikolai_complete", 1);
  level thread zm_stalingrad_util::function_f70dde0b(level.zombie_spawners[0], var_ad0ee644, "boss_arena_spawn", var_84a0beb8, 0.5, undefined, "nikolai_complete", 0);
}

function function_6e418eff(var_56d259ba) {
  if(var_56d259ba == "sentinel") {
    return level.var_b9c4d468 >= 2;
  }
  if(var_56d259ba == "raz" || var_56d259ba == "zombie") {
    if(isDefined(level.var_5fe02c5a)) {
      if(level.var_c3c3ffc5.size > level.var_5fe02c5a) {
        return 1;
      }
    }
    return 0;
  }
}

function function_830cf1ca() {
  var_1cee535f = struct::get("s_nikolai_full_ammo", "targetname");
  var_93eb638b = zm_powerups::specific_powerup_drop("full_ammo", var_1cee535f.origin);
  var_93eb638b notify("powerup_reset");
  var_93eb638b endon("powerup_grabbed");
  level waittill("nikolai_complete");
  if(isDefined(var_93eb638b)) {
    var_93eb638b thread zm_powerups::powerup_timeout();
  }
}

function function_b79713c() {
  level endon("intermission");
  level endon("nikolai_complete");
  while(self siegebot_nikolai::function_86cc3c11() < 2) {
    wait(5);
  }
  level.var_79ad3656 = 0;
  var_8cdc0866 = struct::get_array("boss_arena_spawn", "targetname");
  var_8cdc0866 = array::filter(var_8cdc0866, 0, & function_dc342bfa);
  foreach(var_c2b68b3f in var_8cdc0866) {
    var_c2b68b3f thread function_cb725ad1();
    wait(randomfloatrange(0.12, 0.55));
  }
}

function function_dc342bfa(s_point) {
  return s_point.script_noteworthy === "sentinel_location";
}

function function_cb725ad1() {
  level endon("nikolai_complete");
  while(true) {
    if(!(isDefined(self.var_88e5f77d) && self.var_88e5f77d)) {
      level zm_stalingrad_util::function_9b76f612("sentinel");
      var_663b2442 = zm_stalingrad_util::function_70e59bda(undefined, self);
      if(isalive(var_663b2442)) {
        var_663b2442 sentinel_drone::sentinel_forcegoandstayinposition(1, self.origin);
        var_663b2442.no_powerups = 1;
        var_663b2442.no_damage_points = 1;
        var_663b2442.deathpoints_already_given = 1;
        var_663b2442.settings.engagementheightmax = 300;
        level.var_b9c4d468++;
        if(!isDefined(level.var_c3c3ffc5)) {
          level.var_c3c3ffc5 = [];
        } else if(!isarray(level.var_c3c3ffc5)) {
          level.var_c3c3ffc5 = array(level.var_c3c3ffc5);
        }
        level.var_c3c3ffc5[level.var_c3c3ffc5.size] = var_663b2442;
        var_663b2442 thread function_4fd3f4f9(self.script_string);
        var_663b2442 zm_stalingrad_util::function_d48ad6b4();
        self function_ec910337(var_663b2442);
      }
    }
    wait(0.05);
  }
}

function function_ec910337(var_663b2442) {
  level endon("nikolai_complete");
  self.var_88e5f77d = 1;
  var_663b2442 waittill("death");
  level.var_b9c4d468--;
  wait(10);
  self.var_88e5f77d = 0;
}

function function_4fd3f4f9(var_8087702e) {
  self endon("death");
  var_6be58df = struct::get_array(var_8087702e, "targetname");
  var_6be58df = array::sort_by_script_int(var_6be58df, 1);
  self waittill("completed_spawning");
  self setspeed(10);
  while(true) {
    self function_716d82f6();
    wait(0.5);
    for(i = 1; i < var_6be58df.size; i++) {
      self sentinel_drone::sentinel_forcegoandstayinposition(1, var_6be58df[i].origin);
      wait(0.5);
      self waittill("near_goal");
      self function_716d82f6();
    }
    wait(3);
    for(i = var_6be58df.size - 2; i >= 0; i--) {
      self sentinel_drone::sentinel_forcegoandstayinposition(1, var_6be58df[i].origin);
      wait(0.5);
      self waittill("near_goal");
      self function_716d82f6();
    }
    wait(0.05);
  }
}

function function_716d82f6() {
  self endon("death");
  a_players = arraycopy(level.activeplayers);
  a_players = array::randomize(a_players);
  foreach(player in a_players) {
    v_target_pos = player.origin + vectorscale((0, 0, 1), 48);
    var_64d7d15b = sentinel_drone::sentinel_canseeenemy(self.origin, v_target_pos);
    if(isDefined(var_64d7d15b.can_see_enemy) && var_64d7d15b.can_see_enemy && sentinel_drone::sentinel_isinsideengagementdistance(self.origin, v_target_pos, 1)) {
      self sentinel_drone::sentinel_firebeam(player.origin);
      break;
    }
  }
}

function function_934917cc(e_inflictor, str_mod, w_weapon) {
  if(w_weapon === self.var_a555da3c) {
    return "MOD_UNKNOWN";
  }
  if(w_weapon === self.var_70fcb15a) {
    return "MOD_RIFLE_BULLET";
  }
  return str_mod;
}