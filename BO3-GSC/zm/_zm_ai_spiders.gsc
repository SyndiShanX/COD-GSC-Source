/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_spiders.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_spider;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_bgb_machine;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_zonemgr;
#namespace zm_ai_spiders;

function autoexec __init__sytem__() {
  system::register("zm_ai_spiders", &__init__, &__main__, undefined);
}

function __init__() {
  level.var_9d7b5e00 = 200;
  level.var_6ea0fe2e = 1;
  level flag::init("spider_round");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  level thread function_3fd0c070();
  function_5c48d276();
  init();
  callback::on_spawned(&function_d3c8090f);
  callback::on_spawned(&function_eb951410);
  callback::on_spawned(&function_7d50634d);
  callback::on_spawned(&function_83a70ec3);
  callback::on_spawned(&function_d717ef02);
  callback::on_connect(&function_3a14f1bc);
}

function __main__() {
  register_clientfields();
}

function register_clientfields() {
  clientfield::register("toplayer", "spider_round_fx", 9000, 1, "counter");
  clientfield::register("toplayer", "spider_round_ring_fx", 9000, 1, "counter");
  clientfield::register("toplayer", "spider_end_of_round_reset", 9000, 1, "counter");
  clientfield::register("scriptmover", "set_fade_material", 9000, 1, "int");
  clientfield::register("scriptmover", "web_fade_material", 9000, 3, "float");
  clientfield::register("missile", "play_grenade_stuck_in_web_fx", 9000, 1, "int");
  clientfield::register("scriptmover", "play_spider_web_tear_fx", 9000, getminbitcountfornum(4), "int");
  clientfield::register("scriptmover", "play_spider_web_tear_complete_fx", 9000, getminbitcountfornum(4), "int");
}

function function_3a14f1bc() {
  self.var_7f3c8431 = 0;
  self.var_f795ee17 = 0;
  self.var_86009342 = 0;
  self.var_3b4423fd = 0;
  self.var_ee8976c8 = 0;
  self.var_5c159c87 = 0;
}

function function_83a70ec3() {
  self endon("disconnect");
  while(true) {
    self waittill("bled_out");
    if(level flag::get("spider_round_in_progress")) {
      self waittill("spawned_player");
      level flag::wait_till_clear("spider_round_in_progress");
      util::wait_network_frame();
      self clientfield::increment_to_player("spider_end_of_round_reset", 1);
    }
  }
}

function init() {
  level.var_173ca157 = 1;
  level.var_347e707c = 0;
  level.var_7f2af1cf = 1;
  level.var_42034f6a = 30;
  level.var_c38a4fee = [];
  level flag::init("spider_clips");
  level flag::init("spider_round_in_progress");
  level.aat["zm_aat_turned"].immune_trigger["spider"] = 1;
  level.aat["zm_aat_thunder_wall"].immune_result_indirect["spider"] = 1;
  level.aat["zm_aat_dead_wire"].immune_trigger["spider"] = 1;
  level.melee_range_sav = getdvarstring("ai_meleeRange");
  level.melee_width_sav = getdvarstring("ai_meleeWidth");
  level.melee_height_sav = getdvarstring("ai_meleeHeight");
  function_7a544164();
  level thread function_fd32a77c();
  scene::add_scene_func("scene_zm_dlc2_spider_web_engage", &function_1c624caf, "done");
  scene::add_scene_func("scene_zm_dlc2_spider_burrow_out_of_ground", &function_1c624caf, "done");
  visionset_mgr::register_info("visionset", "zm_isl_parasite_spider_visionset", 9000, 33, 16, 0, &visionset_mgr::ramp_in_out_thread, 0);
}

function function_1c624caf(a_ents) {
  if(self.model === "tag_origin") {
    self zm_utility::self_delete();
  }
}

function function_5c48d276() {
  level._effect["spider_gib"] = "dlc2/island/fx_spider_death_explo_sm";
  level._effect["spider_web_bgb_reweb"] = "dlc2/island/fx_web_bgb_reweb";
  level._effect["spider_web_perk_machine_reweb"] = "dlc2/island/fx_web_perk_machine_reweb";
  level._effect["spider_web_doorbuy_reweb"] = "dlc2/island/fx_web_perk_machine_reweb";
  level._effect["spider_web_spit_reweb"] = "dlc2/island/fx_spider_spit_projectile_reweb";
  level._effect["spider_web_melee_hit"] = "dlc2/island/fx_web_impact_player_melee";
  level._effect["spider_web_spider_enter"] = "dlc2/island/fx_web_impact_spider_crawl";
  level._effect["spider_web_spider_leave"] = "dlc2/island/fx_web_impact_spider_crawl";
}

function function_fd32a77c() {
  clips_on = 0;
  level.spider_clips = getEntArray("spider_clips", "targetname");
  while(true) {
    for(i = 0; i < level.spider_clips.size; i++) {
      level.spider_clips[i] connectpaths();
    }
    level flag::wait_till("spider_clips");
    if(isDefined(level.var_e564e9cd) && level.var_e564e9cd == 1) {
      return;
    }
    for(i = 0; i < level.spider_clips.size; i++) {
      level.spider_clips[i] disconnectpaths();
      util::wait_network_frame();
    }
    var_26b8af54 = 1;
    while(var_26b8af54 || level flag::get("spider_round")) {
      var_26b8af54 = 0;
      var_4b55c671 = getvehiclearray("zombie_spider", "targetname");
      for(i = 0; i < var_4b55c671.size; i++) {
        if(isalive(var_4b55c671[i])) {
          var_26b8af54 = 1;
        }
      }
      wait(1);
    }
    level flag::clear("spider_clips");
    wait(1);
  }
}

function function_d2716ad8() {
  level.var_347e707c = 1;
  if(!isDefined(level.var_33655cba)) {
    level.var_33655cba = &function_2a424152;
  }
  level thread[[level.var_33655cba]]();
}

function function_7a544164() {
  level.var_c38a4fee = getEntArray("zombie_spider_spawner", "script_noteworthy");
  var_c84b3c65 = getEntArray("later_round_spider_spawners", "script_noteworthy");
  level.var_c7f0b45b = arraycombine(level.var_c38a4fee, var_c84b3c65, 1, 0);
  if(level.var_c38a4fee.size == 0) {
    return;
  }
  for(i = 0; i < level.var_c38a4fee.size; i++) {
    if(zm_spawner::is_spawner_targeted_by_blocker(level.var_c38a4fee[i])) {
      level.var_c38a4fee[i].is_enabled = 0;
      continue;
    }
    level.var_c38a4fee[i].is_enabled = 1;
    level.var_c38a4fee[i].script_forcespawn = 1;
  }
  assert(level.var_c38a4fee.size > 0);
  array::thread_all(level.var_c38a4fee, &spawner::add_spawn_function, &function_7c1ef59b);
}

function function_7c1ef59b() {
  self.targetname = "zombie_spider";
  self.b_is_spider = 1;
  function_6e19aa86();
  self.maxhealth = level.var_fda270a4;
  self.health = self.maxhealth;
  self.no_gib = 1;
  self.no_eye_glow = 1;
  self.custom_player_shellshock = &function_c685a92b;
  self.team = level.zombie_team;
  self.missinglegs = 0;
  self.thundergun_knockdown_func = &function_96d38ff4;
  self.lightning_chain_immune = 1;
  self.heroweapon_kill_power = 1;
  self thread zombie_utility::round_spawn_failsafe();
  self thread function_747a2fea();
  self thread function_7609fd9();
  self playSound("zmb_spider_spawn");
  self thread function_eebdfab2();
}

function function_747a2fea() {
  self endon("death");
  while(true) {
    self waittill("damage", n_amount, e_attacker, v_direction, v_hit_location, str_mod);
    if(isplayer(e_attacker)) {
      e_attacker.use_weapon_type = str_mod;
      self thread zm_powerups::check_for_instakill(e_attacker, str_mod, v_hit_location);
    }
  }
}

function function_96d38ff4(e_player, gib) {
  self endon("death");
  n_damage = int(self.maxhealth * 0.5);
  self dodamage(n_damage, self.origin, e_player);
}

function function_a3f4adb() {}

function function_eebdfab2() {
  self endon("death");
  wait(randomfloatrange(3, 6));
  while(true) {
    self playsoundontag("zmb_spider_vocals_ambient", "tag_eye");
    wait(randomfloatrange(2, 6));
  }
}

function function_7609fd9() {
  self waittill("death", e_attacker);
  if(function_c9adb887() == 0 && level.zombie_total == 0) {
    if(!isDefined(level.zm_ai_round_over) || [
        [level.zm_ai_round_over]
      ]()) {
      level.last_ai_origin = self.origin;
      level notify("last_ai_down", self);
    }
  }
  if(isplayer(e_attacker)) {
    if(!(isDefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
      e_attacker zm_score::player_add_points("death_spider");
    }
    if(isDefined(level.hero_power_update)) {
      [
        [level.hero_power_update]
      ](e_attacker, self);
    }
    e_attacker notify("player_killed_spider");
    e_attacker zm_stats::increment_client_stat("zspiders_killed");
    e_attacker zm_stats::increment_player_stat("zspiders_killed");
  }
  if(isDefined(e_attacker) && isai(e_attacker)) {
    e_attacker notify("killed", self);
  }
  if(isDefined(self)) {
    self stoploopsound();
    self thread function_c3147dc1(self.origin);
  }
}

function function_c3147dc1(v_pos) {
  self thread fx::play("spider_gib", v_pos);
}

function function_2a424152() {
  level.var_3013498 = level.round_number + randomintrange(4, 7);
  level.var_5ccd3661 = level.var_3013498;
  old_spawn_func = level.round_spawn_func;
  old_wait_func = level.round_wait_func;
  while(true) {
    level waittill("between_round_over");
    if(getdvarint("") > 0) {
      level.var_3013498 = level.round_number;
    }
    if(level.round_number == level.var_3013498) {
      level.sndmusicspecialround = 1;
      old_spawn_func = level.round_spawn_func;
      old_wait_func = level.round_wait_func;
      function_9f7a20d2();
      level.round_spawn_func = &function_a2a299a1;
      level.round_wait_func = &function_872e306e;
      level.var_3013498 = level.round_number + randomintrange(4, 6);
      getplayers()[0] iprintln("" + level.var_3013498);
    } else if(level flag::get("spider_round")) {
      function_123b370a();
      level.round_spawn_func = old_spawn_func;
      level.round_wait_func = old_wait_func;
      level.var_6ea0fe2e = level.var_6ea0fe2e + 1;
    }
  }
}

function spider_round_fx() {
  foreach(player in level.players) {
    player clientfield::increment_to_player("spider_round_fx");
    player clientfield::increment_to_player("spider_round_ring_fx");
  }
  visionset_mgr::activate("visionset", "zm_isl_parasite_spider_visionset", undefined, 1.5, &function_fad41aec, 2);
}

function function_fad41aec() {
  level flag::wait_till_clear("spider_round_in_progress");
}

function function_a2a299a1() {
  level endon("intermission");
  level endon("end_of_round");
  level endon("restart_round");
  for(i = 0; i < level.players.size; i++) {
    level.players[i].hunted_by = 0;
  }
  level endon("kill_round");
  if(getdvarint("") == 2 || getdvarint("") >= 4) {
    return;
  }
  if(level.intermission) {
    return;
  }
  level flag::set("spider_round_in_progress");
  level thread function_f602171e();
  array::thread_all(level.players, &function_cb42e438);
  wait(1);
  level notify("hash_9c49b4a8");
  spider_round_fx();
  wait(4);
  var_c15d44e9 = function_67c1c842();
  if(getdvarstring("") != "") {
    var_c15d44e9 = getdvarint("");
  }
  level.zombie_total = var_c15d44e9;
  while(true) {
    while(level.zombie_total > 0) {
      if(isDefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
        util::wait_network_frame();
        continue;
      }
      function_45237f11();
      util::wait_network_frame();
    }
    util::wait_network_frame();
  }
}

function function_67c1c842() {
  if(level.var_6ea0fe2e < 3) {
    n_wave_count = level.players.size * 6;
  } else {
    n_wave_count = level.players.size * 8;
  }
  return n_wave_count;
}

function function_45237f11() {
  while(!function_c1730af7()) {
    wait(0.1);
  }
  s_spawn_loc = undefined;
  var_19764360 = get_favorite_enemy();
  if(!isDefined(var_19764360)) {
    wait(randomfloatrange(0.3333333, 0.6666667));
    return;
  }
  if(isDefined(level.var_21f08627)) {
    s_spawn_loc = [[level.var_21f08627]](var_19764360);
  } else {
    s_spawn_loc = function_570247b9(var_19764360);
  }
  if(!isDefined(s_spawn_loc)) {
    wait(randomfloatrange(0.3333333, 0.6666667));
    return;
  }
  if(level flag::exists("spiders_from_mars_round") && level flag::get("spiders_from_mars_round") && isDefined(level.var_39b24700)) {
    ai = zombie_utility::spawn_zombie(level.var_39b24700[0]);
  } else {
    ai = zombie_utility::spawn_zombie(level.var_c38a4fee[0]);
  }
  if(isDefined(ai)) {
    s_spawn_loc thread function_49e57a3b(ai, s_spawn_loc);
    level.zombie_total--;
    level thread zm_spawner::zombie_death_event(ai);
    if(isDefined(level.var_2aacffb1)) {
      ai thread[[level.var_2aacffb1]]();
    }
    function_1abf8192();
  }
}

function function_c1730af7() {
  var_621b3c65 = function_c9adb887();
  var_8817ee62 = var_621b3c65 >= 13;
  var_72a71294 = var_621b3c65 >= (level.players.size * 4);
  if(var_8817ee62 || var_72a71294 || !level flag::get("spawn_zombies")) {
    return false;
  }
  return true;
}

function function_c9adb887() {
  var_388bdc38 = getEntArray("zombie_spider", "targetname");
  var_aa45da74 = var_388bdc38.size;
  foreach(var_c79d3f71 in var_388bdc38) {
    if(!isalive(var_c79d3f71)) {
      var_aa45da74--;
    }
  }
  return var_aa45da74;
}

function function_872e306e() {
  level endon("restart_round");
  level endon("kill_round");
  if(level flag::get("spider_round")) {
    level flag::wait_till("spider_round_in_progress");
    level flag::wait_till_clear("spider_round_in_progress");
  }
  level.sndmusicspecialround = 0;
}

function function_9f7a20d2() {
  level flag::set("spider_round");
  level flag::set("special_round");
  level clientfield::set("force_stream_spiders", 1);
  if(!isDefined(level.var_8276ee15)) {
    level.var_8276ee15 = 0;
  }
  level.var_8276ee15 = 1;
  level notify("hash_f96039de");
  level thread zm_audio::sndmusicsystem_playstate("spider_roundstart");
  if(isDefined(level.var_9d7b5e00)) {
    setdvar("ai_meleeRange", level.var_9d7b5e00);
  } else {
    setdvar("ai_meleeRange", 100);
  }
}

function function_123b370a() {
  level flag::clear("spider_round");
  level flag::clear("special_round");
  level clientfield::set("force_stream_spiders", 0);
  if(!isDefined(level.var_8276ee15)) {
    level.var_8276ee15 = 0;
  }
  level.var_8276ee15 = 0;
  level notify("hash_daeb2e4f");
  setdvar("ai_meleeRange", level.melee_range_sav);
  setdvar("ai_meleeWidth", level.melee_width_sav);
  setdvar("ai_meleeHeight", level.melee_height_sav);
}

function function_1abf8192() {
  switch (level.players.size) {
    case 1: {
      n_default_wait = 2.25;
      break;
    }
    case 2: {
      n_default_wait = 2;
      break;
    }
    case 3: {
      n_default_wait = 1.75;
      break;
    }
    default: {
      n_default_wait = 1.5;
      break;
    }
  }
  wait(n_default_wait);
}

function function_6e19aa86() {
  if(isDefined(level.var_718361fb)) {
    level.var_fda270a4 = level.var_718361fb;
  } else {
    switch (level.var_6ea0fe2e) {
      case 1: {
        level.var_fda270a4 = 400;
        break;
      }
      case 2: {
        level.var_fda270a4 = 900;
        break;
      }
      case 3: {
        level.var_fda270a4 = 1300;
        break;
      }
      default: {
        level.var_fda270a4 = 1600;
        break;
      }
    }
    level.var_fda270a4 = int(level.var_fda270a4 * 0.5);
    if(level flag::exists("spiders_from_mars_round") && level flag::get("spiders_from_mars_round")) {
      level.var_fda270a4 = level.var_fda270a4 * 2;
    }
  }
}

function function_570247b9(var_19764360) {
  switch (level.players.size) {
    case 1: {
      var_3a613778 = 2500;
      var_e27d607a = 490000;
      break;
    }
    case 2: {
      var_3a613778 = 2500;
      var_e27d607a = 810000;
      break;
    }
    case 3: {
      var_3a613778 = 2500;
      var_e27d607a = 1000000;
      break;
    }
    case 4: {
      var_3a613778 = 2500;
      var_e27d607a = 1000000;
      break;
    }
    default: {
      var_3a613778 = 2500;
      var_e27d607a = 490000;
      break;
    }
  }
  if(isDefined(level.zm_loc_types["spider_location"])) {
    var_aa136cb0 = array::randomize(level.zm_loc_types["spider_location"]);
  } else {
    assertmsg("");
    return;
  }
  for(i = 0; i < var_aa136cb0.size; i++) {
    if(isDefined(level.var_fcbb5ce0) && level.var_fcbb5ce0 == var_aa136cb0[i]) {
      continue;
    }
    n_dist_squared = distancesquared(var_aa136cb0[i].origin, var_19764360.origin);
    n_height_diff = abs(var_aa136cb0[i].origin[2] - var_19764360.origin[2]);
    if(n_dist_squared > var_3a613778 && n_dist_squared < var_e27d607a && n_height_diff < 128) {
      s_spawn_loc = function_4df33b5a(var_aa136cb0[i]);
      level.var_fcbb5ce0 = s_spawn_loc;
      return s_spawn_loc;
    }
  }
  s_spawn_loc = function_4df33b5a(arraygetclosest(var_19764360.origin, var_aa136cb0));
  level.var_fcbb5ce0 = s_spawn_loc;
  return s_spawn_loc;
}

function function_4df33b5a(s_spawn_loc) {
  assert(isDefined(s_spawn_loc), "");
  var_8bf32428 = s_spawn_loc;
  var_8bf32428.origin = s_spawn_loc.origin + vectorscale((0, 0, 1), 16);
  return var_8bf32428;
}

function function_cb42e438() {
  self playlocalsound("zmb_raps_round_start");
}

function function_f602171e() {
  level waittill("last_ai_down", e_enemy_ai);
  level thread zm_audio::sndmusicsystem_playstate("spider_roundend");
  if(isDefined(level.zm_override_ai_aftermath_powerup_drop)) {
    [[level.zm_override_ai_aftermath_powerup_drop]](e_enemy_ai, level.last_ai_origin);
  } else {
    var_4a50cb2a = level.last_ai_origin;
    if(!ispointonnavmesh(var_4a50cb2a, e_enemy_ai)) {
      var_4a50cb2a = getclosestpointonnavmesh(var_4a50cb2a, 100);
      if(!isDefined(var_4a50cb2a)) {
        e_player = zm_utility::get_closest_player(level.last_ai_origin);
        var_4a50cb2a = e_player.origin;
      }
    }
    trace = groundtrace(var_4a50cb2a + vectorscale((0, 0, 1), 15), var_4a50cb2a + (vectorscale((0, 0, -1), 1000)), 0, undefined);
    var_4a50cb2a = trace["position"];
    if(isDefined(var_4a50cb2a)) {
      level thread zm_powerups::specific_powerup_drop("full_ammo", var_4a50cb2a);
    }
  }
  wait(2);
  level.sndmusicspecialround = 0;
  if(isDefined(level.var_c102a998)) {
    [[level.var_c102a998]]();
  } else {
    wait(6);
    level flag::clear("spider_round_in_progress");
    foreach(player in level.players) {
      player clientfield::increment_to_player("spider_end_of_round_reset", 1);
    }
  }
}

function get_favorite_enemy() {
  var_5a210579 = level.players;
  e_least_hunted = var_5a210579[0];
  for(i = 0; i < var_5a210579.size; i++) {
    if(!isDefined(var_5a210579[i].hunted_by)) {
      var_5a210579[i].hunted_by = 0;
    }
    if(!zm_utility::is_player_valid(var_5a210579[i])) {
      continue;
    }
    if(!zm_utility::is_player_valid(e_least_hunted)) {
      e_least_hunted = var_5a210579[i];
    }
    if(var_5a210579[i].hunted_by < e_least_hunted.hunted_by) {
      e_least_hunted = var_5a210579[i];
    }
  }
  e_least_hunted.hunted_by = e_least_hunted.hunted_by + 1;
  return e_least_hunted;
}

function function_f4bd92a2(n_to_spawn, s_spawn_point) {
  var_4b55c671 = getvehiclearray("zombie_spider", "targetname");
  if(isDefined(var_4b55c671) && var_4b55c671.size >= 9) {
    return 0;
  }
  if(!isDefined(n_to_spawn)) {
    n_to_spawn = 1;
  }
  var_c46ed637 = 0;
  while(var_c46ed637 < n_to_spawn) {
    var_19764360 = get_favorite_enemy();
    if(isDefined(level.var_21f08627)) {
      if(!isDefined(s_spawn_point)) {
        s_spawn_point = [
          [level.var_21f08627]
        ](level.var_c38a4fee, var_19764360);
      }
      ai = zombie_utility::spawn_zombie(level.var_c38a4fee[0]);
      if(isDefined(ai)) {
        s_spawn_point thread function_49e57a3b(ai, s_spawn_point);
        level.zombie_total--;
        var_c46ed637++;
        level flag::set("spider_clips");
      }
    } else {
      if(!isDefined(s_spawn_point)) {
        s_spawn_point = function_570247b9(var_19764360);
      }
      ai = zombie_utility::spawn_zombie(level.var_c38a4fee[0]);
      if(isDefined(ai)) {
        s_spawn_point thread function_49e57a3b(ai, s_spawn_point);
        level.zombie_total--;
        var_c46ed637++;
        level flag::set("spider_clips");
      }
    }
    function_1abf8192();
  }
  if(isDefined(ai)) {
    return ai;
  }
  return undefined;
}

function function_49e57a3b(var_c79d3f71, ent = self, var_a79b986e = 0) {
  var_c79d3f71 endon("death");
  var_c79d3f71 ai::set_ignoreall(1);
  if(!isDefined(ent.target) || var_a79b986e) {
    var_c79d3f71 ghost();
    var_c79d3f71 util::delay(0.2, "death", &show);
    var_c79d3f71 util::delay_notify(0.2, "visible", "death");
    var_c79d3f71.origin = ent.origin;
    var_c79d3f71.angles = ent.angles;
    var_c79d3f71 vehicle_ai::set_state("scripted");
    if(isalive(var_c79d3f71)) {
      a_ground_trace = groundtrace(var_c79d3f71.origin + vectorscale((0, 0, 1), 100), var_c79d3f71.origin - vectorscale((0, 0, 1), 1000), 0, var_c79d3f71, 1);
      if(isDefined(a_ground_trace["position"])) {
        var_197f1988 = util::spawn_model("tag_origin", a_ground_trace["position"], var_c79d3f71.angles);
      } else {
        var_197f1988 = util::spawn_model("tag_origin", var_c79d3f71.origin, var_c79d3f71.angles);
      }
      var_197f1988 scene::play("scene_zm_dlc2_spider_burrow_out_of_ground", var_c79d3f71);
      state = "combat";
      if(randomfloat(1) > 0.6) {
        state = "meleeCombat";
      }
      var_c79d3f71 vehicle_ai::set_state(state);
      var_c79d3f71 setvisibletoall();
      var_c79d3f71 ai::set_ignoreme(0);
    }
  } else {
    var_c79d3f71.disablearrivals = 1;
    var_c79d3f71.disableexits = 1;
    var_c79d3f71 vehicle_ai::set_state("scripted");
    var_c79d3f71 notify("visible");
    var_ce7c81e4 = struct::get_array(ent.target, "targetname");
    var_ed41ff6b = array::random(var_ce7c81e4);
    if(isDefined(var_ed41ff6b) && isalive(var_c79d3f71)) {
      var_ed41ff6b.script_play_multiple = 1;
      level scene::play(ent.target, var_c79d3f71);
    } else {
      var_36eb5144 = getvehiclenodearray(ent.target, "targetname");
      var_a8deb964 = array::random(var_36eb5144);
      var_c79d3f71 ghost();
      var_c79d3f71.var_75bf86b = spawner::simple_spawn_single("spider_mover_spawner");
      var_c79d3f71.origin = var_c79d3f71.var_75bf86b.origin;
      var_c79d3f71.angles = var_c79d3f71.var_75bf86b.angles;
      var_c79d3f71 linkto(var_c79d3f71.var_75bf86b);
      s_end = struct::get(var_a8deb964.target, "targetname");
      var_c79d3f71.var_75bf86b vehicle::get_on_path(var_a8deb964);
      var_c79d3f71 show();
      if(isDefined(var_a8deb964.script_int)) {
        var_c79d3f71.var_75bf86b setspeed(var_a8deb964.script_int);
      } else {
        var_c79d3f71.var_75bf86b setspeed(20);
      }
      var_c79d3f71.var_75bf86b vehicle::go_path();
      var_c79d3f71 notify("hash_a81735f9");
      var_c79d3f71 unlink();
      var_c79d3f71.var_75bf86b delete();
    }
    earthquake(0.1, 0.5, var_c79d3f71.origin, 256);
    state = "combat";
    if(randomfloat(1) > 0.6) {
      state = "meleeCombat";
    }
    var_c79d3f71 vehicle_ai::set_state(state);
    var_c79d3f71.completed_emerging_into_playable_area = 1;
  }
  var_c79d3f71 ai::set_ignoreall(0);
}

function function_c685a92b(damage, attacker, direction_vec, point, mod) {
  if(mod == "MOD_EXPLOSIVE") {
    self thread function_81cf36fd();
  }
}

function function_81cf36fd() {
  self endon("death");
  if(!isDefined(self.var_7f8ad3ef)) {
    self.var_7f8ad3ef = 0;
  }
  self.var_7f8ad3ef++;
  if(self.var_7f8ad3ef >= 4) {
    self shellshock("pain", 1);
  }
  self util::waittill_any_timeout(10, "death");
  self.var_7f8ad3ef--;
}

function function_b4fb1b85() {
  var_dd20bf74 = getEntArray("spider_web_visual", "script_string");
  array::run_all(var_dd20bf74, &notsolid);
  array::run_all(var_dd20bf74, &hide);
  level.var_d3b40681 = [];
  level.revive_trigger_should_ignore_sight_checks = &function_7495ed75;
  var_5d2147f2 = getEntArray("bgb_web_trigger", "targetname");
  foreach(trigger in var_5d2147f2) {
    trigger thread function_d002d19c();
    if(!isDefined(level.var_d3b40681)) {
      level.var_d3b40681 = [];
    } else if(!isarray(level.var_d3b40681)) {
      level.var_d3b40681 = array(level.var_d3b40681);
    }
    level.var_d3b40681[level.var_d3b40681.size] = trigger;
  }
  var_b850d29a = getEntArray("zombie_door", "targetname");
  foreach(trigger in var_b850d29a) {
    var_9224b839 = getEntArray(trigger.target, "targetname");
    var_53169151 = [];
    foreach(e_piece in var_9224b839) {
      if(e_piece.script_string === "spider_web_trigger") {
        if(!isDefined(var_53169151)) {
          var_53169151 = [];
        } else if(!isarray(var_53169151)) {
          var_53169151 = array(var_53169151);
        }
        var_53169151[var_53169151.size] = e_piece;
      }
    }
    foreach(var_e08b3d94 in var_53169151) {
      var_e08b3d94.var_b8a7fb78 = trigger;
      var_e08b3d94.script_flag = trigger.script_flag;
      var_e08b3d94 function_7428955c();
      if(!(isDefined(var_e08b3d94.b_active) && var_e08b3d94.b_active)) {
        var_e08b3d94.b_active = 1;
        if(!isDefined(level.var_d3b40681)) {
          level.var_d3b40681 = [];
        } else if(!isarray(level.var_d3b40681)) {
          level.var_d3b40681 = array(level.var_d3b40681);
        }
        level.var_d3b40681[level.var_d3b40681.size] = var_e08b3d94;
        var_e08b3d94 thread function_a96551fe();
      }
    }
  }
}

function function_7428955c() {
  var_18ec47f1 = getEntArray(self.target, "targetname");
  self.var_1c12769f = struct::get(self.target, "targetname");
  foreach(var_6538189a in var_18ec47f1) {
    if(var_6538189a.script_string === "spider_web_visual") {
      self.e_destructible = var_6538189a;
      self.var_1e831600 = var_6538189a;
      self.var_1e831600 clientfield::set("web_fade_material", 0);
    }
  }
}

function function_511e58cc() {
  s_unitrigger = spawnStruct();
  s_unitrigger.origin = self.origin;
  if(self.targetname == "bgb_web_trigger" || self.targetname == "doorbuy_web_trigger") {
    var_81aba619 = struct::get_array(self.target, "targetname");
    if(isDefined(var_81aba619[0])) {
      s_unitrigger.angles = var_81aba619[0].angles;
    } else {
      s_unitrigger.angles = self.angles;
    }
  } else {
    s_unitrigger.angles = self.angles;
  }
  s_unitrigger.script_unitrigger_type = "unitrigger_box_use";
  s_unitrigger.cursor_hint = "HINT_NOICON";
  s_unitrigger.require_look_at = 0;
  s_unitrigger.var_a6a648f0 = self;
  if(isDefined(self.script_width)) {
    s_unitrigger.script_width = self.script_width;
  } else {
    s_unitrigger.script_width = 128;
  }
  if(isDefined(self.script_length)) {
    s_unitrigger.script_length = self.script_length;
  } else {
    s_unitrigger.script_length = 130;
  }
  if(isDefined(self.script_height)) {
    s_unitrigger.script_height = self.script_height;
  } else {
    s_unitrigger.script_height = 100;
  }
  if(isDefined(self.script_vector)) {
    s_unitrigger.script_length = self.script_vector[0];
    s_unitrigger.script_width = self.script_vector[1];
    s_unitrigger.script_height = self.script_vector[2];
  }
  s_unitrigger.prompt_and_visibility_func = &function_e433eb78;
  zm_unitrigger::register_static_unitrigger(s_unitrigger, &function_c915f7a9);
  self.s_unitrigger = s_unitrigger;
}

function function_d002d19c() {
  self endon("death");
  self function_7428955c();
  self.e_bgb_machine = undefined;
  foreach(e_bgb_machine in level.bgb_machines) {
    if(e_bgb_machine istouching(self)) {
      self.e_bgb_machine = e_bgb_machine;
      self.var_1e831600.origin = self.e_bgb_machine.origin;
      self.var_1e831600.angles = self.e_bgb_machine.angles;
    }
  }
  while(true) {
    if(function_f67965ad(self.origin)) {
      self function_f375c6d9(1);
      if(isDefined(self.e_bgb_machine)) {
        self notify("hash_16b3008");
        self thread function_8c3397a();
      }
      self waittill("web_torn");
      self function_f375c6d9(0);
    }
    level waittill("hash_9c49b4a8");
  }
}

function function_8c3397a() {
  self endon("death");
  self endon("hash_16b3008");
  self.e_bgb_machine thread fx::play("spider_web_bgb_reweb", self.e_bgb_machine.origin, self.e_bgb_machine.angles);
  if(self.e_bgb_machine bgb_machine::get_bgb_machine_state() === "initial" || self.e_bgb_machine bgb_machine::is_bgb_machine_active()) {
    self.e_bgb_machine thread zm_unitrigger::unregister_unitrigger(self.e_bgb_machine.unitrigger_stub);
    self waittill("web_torn");
    self.e_bgb_machine thread zm_unitrigger::register_static_unitrigger(self.e_bgb_machine.unitrigger_stub, &bgb_machine::bgb_machine_unitrigger_think);
  }
  while(true) {
    self.e_bgb_machine waittill("zbarrier_state_change");
    if(isDefined(self.var_f83345c7) && self.var_f83345c7) {
      if(self.e_bgb_machine bgb_machine::get_bgb_machine_state() === "initial" || self.e_bgb_machine bgb_machine::is_bgb_machine_active()) {
        self.e_bgb_machine thread zm_unitrigger::unregister_unitrigger(self.e_bgb_machine.unitrigger_stub);
        self waittill("web_torn");
        self.e_bgb_machine thread zm_unitrigger::register_static_unitrigger(self.e_bgb_machine.unitrigger_stub, &bgb_machine::bgb_machine_unitrigger_think);
      }
    }
  }
}

function function_a96551fe() {
  self endon("death");
  while(!(isDefined(self.var_b8a7fb78._door_open) && self.var_b8a7fb78._door_open)) {
    wait(0.5);
  }
  while(true) {
    self trigger::wait_till();
    if(isDefined(self.who.b_is_spider) && self.who.b_is_spider || (isDefined(level.var_f618f3e1) && level.var_f618f3e1)) {
      var_59bd3c5a = self.who;
      var_94aebe65 = randomint(100);
      if(var_94aebe65 < level.var_42034f6a) {
        self.var_cb6fa5c5 = 0;
        self thread function_e96bd0d2();
        if(isalive(var_59bd3c5a) && (isDefined(var_59bd3c5a.b_is_spider) && var_59bd3c5a.b_is_spider)) {
          var_59bd3c5a function_d8cfc139(self);
        }
        self function_c83dc712();
        level util::waittill_any_ents(level, "end_of_round", level, "between_round_over", level, "start_of_round", self, "death", level, "enable_all_webs");
      } else {
        wait(3);
      }
    }
  }
}

function function_d8cfc139(e_dest) {
  self endon("death");
  var_366514d8 = util::spawn_model("tag_origin", self.origin, self.angles);
  var_366514d8 thread scene::play("scene_zm_dlc2_spider_web_engage", self);
  self waittill("web");
  self spit_projectile(e_dest);
}

function spit_projectile(e_dest) {
  v_origin = self gettagorigin("head_1");
  v_angles = self gettagangles("head_1");
  var_e9ad0294 = util::spawn_model("tag_origin", v_origin, v_angles);
  var_e9ad0294 thread fx::play("spider_web_spit_reweb", v_origin, v_angles, "movedone", 1);
  var_e9ad0294 moveto(e_dest.origin, 0.5);
  var_e9ad0294 waittill("movedone");
  var_e9ad0294 delete();
}

function function_f375c6d9(b_on = 1, var_32ee3d8b = 0.5) {
  if(b_on) {
    if(isDefined(self.var_1c12769f)) {
      self.var_1e831600 thread fx::play("spider_web_doorbuy_reweb", self.var_1c12769f.origin, self.var_1c12769f.angles);
    }
    self function_511e58cc();
    self.var_1e831600 show();
    self.var_1e831600 solid();
    self.var_1e831600 clientfield::set("web_fade_material", var_32ee3d8b);
    self.var_f83345c7 = 1;
    self thread function_1a393131();
  } else {
    self.var_f83345c7 = 0;
    self.var_cb6fa5c5 = 0;
    self.var_1e831600 clientfield::set("web_fade_material", 0);
    self.var_1e831600 notsolid();
    self.var_1e831600 hide();
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
  }
}

function function_c83dc712() {
  self endon("death");
  if(isDefined(self.script_noteworthy)) {
    var_6adf046 = [];
    var_6adf046 = strtok(self.script_noteworthy, " ");
  } else {
    return;
  }
  self function_f375c6d9(1);
  var_9df462ad = [];
  foreach(str_zone in var_6adf046) {
    e_zone = level.zones[str_zone];
    assert(isDefined(e_zone), ("" + str_zone) + "");
    if(!function_7be01d65(str_zone)) {
      e_zone.is_spawning_allowed = 0;
      e_zone thread function_cb33362d();
      if(!isDefined(var_9df462ad)) {
        var_9df462ad = [];
      } else if(!isarray(var_9df462ad)) {
        var_9df462ad = array(var_9df462ad);
      }
      var_9df462ad[var_9df462ad.size] = e_zone;
      var_d1cba433 = zombie_utility::get_zombie_array();
      foreach(ai_zombie in var_d1cba433) {
        if(ai_zombie zm_zonemgr::entity_in_zone(str_zone)) {
          ai_zombie.var_b1b7c1b7 = 1;
        }
      }
    }
  }
  self waittill("web_torn");
  foreach(e_zone in var_9df462ad) {
    e_zone.is_spawning_allowed = 1;
    e_zone notify("web_torn");
  }
  self function_f375c6d9(0);
}

function function_7be01d65(str_zone) {
  e_zone = level.zones[str_zone];
  for(i = 0; i < e_zone.volumes.size; i++) {
    foreach(player in level.players) {
      if(zm_utility::is_player_valid(player, 0, 0) && player istouching(e_zone.volumes[i])) {
        return true;
      }
    }
  }
  return false;
}

function function_cb33362d() {
  self endon("web_torn");
  str_zone = self.volumes[0].targetname;
  while(!(isDefined(function_7be01d65(str_zone)) && function_7be01d65(str_zone))) {
    wait(1);
  }
  self.is_spawning_allowed = 1;
}

function function_e96bd0d2() {
  self endon("web_torn");
  self thread function_e85225c8();
  while(true) {
    self waittill("trigger", e_who);
    if(!(isDefined(e_who.b_is_spider) && e_who.b_is_spider) && (!(isDefined(e_who.var_93100ec2) && e_who.var_93100ec2)) && isai(e_who)) {
      self.var_cb6fa5c5++;
    } else if(isDefined(e_who.b_is_spider) && e_who.b_is_spider && (!(isDefined(e_who.var_a56241ac) && e_who.var_a56241ac))) {
      e_who thread function_9b4a5d94(self);
    }
  }
}

function function_e85225c8() {
  self endon("web_torn");
  var_e08b3d94 = spawn("trigger_radius", self.origin, 1, 50, 50);
  var_e08b3d94 endon("death");
  self thread function_d1835ae4(var_e08b3d94);
  self.var_82b5ff7a = 0;
  while(true) {
    var_e08b3d94 waittill("trigger", e_who);
    if(e_who.archetype === "thrasher") {
      self thread function_6b1cc9fb(1);
      self notify("web_torn");
    } else if(e_who.archetype === "zombie" && (!(isDefined(e_who.var_93100ec2) && e_who.var_93100ec2))) {
      e_who thread function_82900a05(self);
      if(!self.var_82b5ff7a) {
        self thread function_d672fbd9(var_e08b3d94);
        self thread function_6c15e157(4, 0.125);
      }
    }
  }
}

function function_d672fbd9(var_e08b3d94) {
  self endon("web_torn");
  wait(60);
  foreach(ai_zombie in getaiteamarray(level.zombie_team)) {
    if(ai_zombie istouching(var_e08b3d94)) {
      self.var_82b5ff7a = 0;
      self thread function_6b1cc9fb(1);
      self notify("web_torn");
    }
  }
  self.var_82b5ff7a = 0;
}

function function_82900a05(var_e08b3d94) {
  self endon("death");
  self.var_93100ec2 = 1;
  if(var_e08b3d94.var_cb6fa5c5 > 5) {
    self.var_b1b7c1b7 = 1;
  } else {
    self thread function_e0f04a8a();
  }
  self asmsetanimationrate(0.1);
  self ai::set_ignoreall(1);
  var_e08b3d94 waittill("web_torn");
  self asmsetanimationrate(1);
  self ai::set_ignoreall(0);
  self notify("hash_af52d2f8");
  self.var_93100ec2 = 0;
  self.var_b1b7c1b7 = 0;
}

function function_d1835ae4(var_e08b3d94) {
  self waittill("web_torn");
  if(isDefined(var_e08b3d94)) {
    var_e08b3d94 delete();
  }
}

function function_9b4a5d94(var_e08b3d94) {
  self endon("death");
  var_e08b3d94 endon("death");
  self.var_a56241ac = 1;
  self fx::play("spider_web_spider_enter", self.origin, self.angles, "stop_spider_web_enter", 0, "tag_body");
  var_e08b3d94 thread function_6c15e157(1);
  while(true) {
    wait(0.05);
    if(self istouching(var_e08b3d94) && (isDefined(var_e08b3d94.var_f83345c7) && var_e08b3d94.var_f83345c7)) {
      continue;
    } else {
      self.var_a56241ac = 0;
      self notify("stop_spider_web_enter");
      self fx::play("spider_web_spider_leave", self.origin, self.angles, 2, 0, "tag_body");
      break;
    }
  }
}

function function_6c15e157(var_f0566a69 = 4, var_d1bb0869 = 0.25) {
  self endon("death");
  if(!isDefined(self.var_1e831600)) {
    return;
  }
  if(!(isDefined(self.var_c8acfaf8) && self.var_c8acfaf8)) {
    self.var_c8acfaf8 = 1;
    v_original_pos = self.var_1e831600.origin;
    for(i = 0; i < var_f0566a69; i++) {
      var_45634a22 = (randomfloatrange(0, 2), randomfloatrange(0, 2), 0);
      self.var_1e831600 moveto(v_original_pos + var_45634a22, var_d1bb0869);
      self.var_1e831600 waittill("movedone");
      self.var_1e831600 moveto(v_original_pos, var_d1bb0869);
      self.var_1e831600 waittill("movedone");
    }
    self.var_c8acfaf8 = 0;
  }
}

function function_17a41767(var_a6a648f0) {
  self endon("death");
  self.var_93100ec2 = 1;
  if(isDefined(self.var_61f7b3a0) && self.var_61f7b3a0) {
    var_ab201dd8 = util::spawn_model("tag_origin", self.origin, self.angles);
    var_ab201dd8 thread scene::play("scene_zm_dlc2_thrasher_attack_swing_swipe", self);
    self waittill("thrasher_melee");
    var_a6a648f0 thread function_6b1cc9fb(1);
    var_a6a648f0 notify("web_torn");
    self.var_93100ec2 = 0;
    return;
  }
  if(var_a6a648f0.var_cb6fa5c5 > 2) {
    self.var_b1b7c1b7 = 1;
  } else {
    self thread function_e0f04a8a();
  }
  self asmsetanimationrate(0.1);
  self ai::set_ignoreall(1);
  self clientfield::set("widows_wine_wrapping", 1);
  self thread function_81936417();
  var_a6a648f0 thread function_6c15e157(4, 0.125);
  var_a6a648f0 waittill("web_torn");
  self asmsetanimationrate(1);
  self ai::set_ignoreall(0);
  self clientfield::set("widows_wine_wrapping", 0);
  self notify("hash_af52d2f8");
  self.var_93100ec2 = 0;
  self.var_b1b7c1b7 = 0;
}

function function_81936417() {
  self waittill("death");
  if(isDefined(self)) {
    if(self clientfield::get("widows_wine_wrapping")) {
      self clientfield::set("widows_wine_wrapping", 0);
    }
  }
}

function function_e0f04a8a(n_delay_timer = 5) {
  self endon("death");
  self endon("hash_af52d2f8");
  self.var_b1b7c1b7 = 0;
  wait(n_delay_timer);
  self.var_b1b7c1b7 = 1;
}

function function_e433eb78(player) {
  if(!player zm_utility::is_player_looking_at(self.origin, 0.4, 0) || !player zm_magicbox::can_buy_weapon()) {
    self sethintstring("");
    return false;
  }
  self sethintstring(&"ZM_ISLAND_TEAR_WEB");
  return true;
}

function function_7495ed75() {
  if(!isDefined(level.var_d3b40681)) {
    return 0;
  }
  var_a15343e5 = 0;
  foreach(var_e08b3d94 in level.var_d3b40681) {
    if(!(isDefined(var_e08b3d94.var_f83345c7) && var_e08b3d94.var_f83345c7)) {
      continue;
    }
    foreach(player in level.players) {
      if(player == self) {
        continue;
      }
      if(isDefined(player.revivetrigger) && self istouching(player.revivetrigger) && self util::is_player_looking_at(player.revivetrigger.origin, 0.6, 0) && distance2dsquared(self.origin, var_e08b3d94.origin) < 14400) {
        var_a15343e5 = 1;
        break;
      }
    }
    if(var_a15343e5) {
      break;
    }
  }
  return var_a15343e5;
}

function function_c915f7a9() {
  var_a6a648f0 = self.stub.var_a6a648f0;
  var_a6a648f0 endon("web_torn");
  while(true) {
    self waittill("trigger", e_who);
    e_who.var_77f9de0d = self.stub.var_a6a648f0;
    if(e_who zm_laststand::is_reviving_any()) {
      continue;
    }
    if(e_who.is_drinking > 0) {
      continue;
    }
    if(!e_who zm_magicbox::can_buy_weapon()) {
      continue;
    }
    if(!zm_utility::is_player_valid(e_who)) {
      continue;
    } else {
      e_who notify("tearing_web");
    }
    if(isDefined(self.related_parent)) {
      self.related_parent notify("trigger_activated", e_who);
    }
    if(!isDefined(e_who.usebar)) {
      if(isDefined(level.var_922007f3)) {
        self thread[[level.var_922007f3]](e_who);
      } else {
        self thread function_8cf6fed9();
      }
      var_a6a648f0 thread function_6b1cc9fb();
      var_a7579b72 = self util::waittill_any_ex("webtear_succeed", "webtear_failed", "kill_trigger", var_a6a648f0, "web_torn");
      if(var_a7579b72 == "webtear_succeed") {
        e_who.var_7f3c8431 = 1;
        e_who function_20915a1a();
        var_a6a648f0 thread function_6b1cc9fb(1);
        var_a6a648f0 notify("web_torn");
        break;
      } else {
        var_a6a648f0 thread function_6b1cc9fb(1);
      }
    }
  }
}

function function_8cf6fed9() {
  wait(0.25);
  self notify("webtear_succeed");
}

function function_d3c8090f() {
  self endon("death");
  while(true) {
    self waittill("grenade_fire", e_grenade, weapon);
    e_grenade thread function_a5ee3628(weapon, self);
  }
}

function function_eb951410() {
  self endon("death");
  while(true) {
    self waittill("grenade_launcher_fire", e_grenade, weapon);
    e_grenade thread function_a5ee3628(weapon, self);
  }
}

function function_7d50634d() {
  self endon("death");
  while(true) {
    self waittill("missile_fire", e_projectile, weapon);
    e_projectile thread function_5165d3f2(weapon, self);
  }
}

function function_a5ee3628(weapon, player) {
  self endon("death");
  if(!isDefined(level.var_d3b40681)) {
    return;
  }
  if(weapon === getweapon("sticky_grenade_widows_wine")) {
    self waittill("stationary");
    var_9f172edf = self.origin;
    v_normal = (0, 0, 0);
  } else {
    self waittill("grenade_bounce", var_9f172edf, v_normal, hitent, str_surface);
  }
  foreach(trigger in level.var_d3b40681) {
    if(!(isDefined(trigger.var_f83345c7) && trigger.var_f83345c7)) {
      continue;
    }
    if(self istouching(trigger) || trigger.var_1e831600 === hitent && distance2dsquared(trigger.origin, var_9f172edf) < 2500) {
      self thread function_96ebe65e(trigger, weapon, var_9f172edf, v_normal, player);
      return;
    }
  }
  self thread function_8f6a18e4(player);
}

function function_8f6a18e4(player) {
  var_68b0e214 = self.origin;
  self waittill("death");
  foreach(trigger in level.var_d3b40681) {
    if(!(isDefined(trigger.var_f83345c7) && trigger.var_f83345c7) || (isDefined(trigger.var_e084d7bd) && trigger.var_e084d7bd)) {
      continue;
    }
    if(distance2dsquared(trigger.origin, var_68b0e214) < 2500) {
      player.var_3b4423fd = 1;
      trigger thread function_6b1cc9fb(1, var_68b0e214, undefined, 1);
      trigger notify("web_torn");
      player function_20915a1a(1, 1);
      return;
    }
  }
}

function function_1a393131() {
  self endon("death");
  self endon("web_torn");
  while(true) {
    self.var_1e831600 waittill("grenade_stuck", e_grenade);
  }
}

function function_5165d3f2(weapon, player) {
  if(!isDefined(level.var_d3b40681) || weapon == getweapon("skull_gun")) {
    return;
  }
  self waittill("death");
  if(isDefined(self) && isDefined(self.origin)) {
    var_318d5542 = self.origin;
  } else {
    return;
  }
  foreach(trigger in level.var_d3b40681) {
    if(!(isDefined(trigger.var_f83345c7) && trigger.var_f83345c7) || (isDefined(trigger.var_e084d7bd) && trigger.var_e084d7bd)) {
      continue;
    }
    if(distance2dsquared(trigger.origin, var_318d5542) < 10000) {
      if(weapon == getweapon("launcher_standard") || weapon == getweapon("launcher_standard_upgraded")) {
        player.var_86009342 = 1;
      } else if(weapon == getweapon("ray_gun") || weapon == getweapon("ray_gun_upgraded")) {
        player.var_ee8976c8 = 1;
      }
      trigger thread function_6b1cc9fb(1, var_318d5542, undefined, 1);
      trigger notify("web_torn");
      player function_20915a1a(1, 1);
      return;
    }
  }
}

function function_96ebe65e(trigger, weapon, var_9f172edf, v_normal, player) {
  trigger endon("death");
  trigger endon("web_torn");
  player endon("death");
  if(weapon == getweapon("frag_grenade")) {
    var_a8dac2c5 = player magicgrenademanualplayer(var_9f172edf - v_normal, (0, 0, 0), getweapon("frag_grenade_web"), weapon.fusetime / 1000);
  } else {
    if(weapon == getweapon("bouncingbetty")) {
      var_a8dac2c5 = player magicgrenademanualplayer(var_9f172edf - v_normal, (0, 0, 0), getweapon("bouncingbetty_web"), weapon.fusetime / 1000);
    } else {
      if(weapon == getweapon("sticky_grenade_widows_wine")) {
        var_a8dac2c5 = self;
      } else {
        return;
      }
    }
  }
  var_a8dac2c5.angles = self.angles;
  if(var_a8dac2c5 != self) {
    self delete();
  }
  trigger thread function_52f52ae0(var_a8dac2c5);
  var_a8dac2c5 clientfield::set("play_grenade_stuck_in_web_fx", 1);
  var_a8dac2c5 waittill("death");
  if(!(isDefined(trigger.var_e084d7bd) && trigger.var_e084d7bd)) {
    player.var_3b4423fd = 1;
    trigger thread function_6b1cc9fb(1, var_9f172edf - v_normal, undefined, 1);
    player function_20915a1a(1, 1);
    trigger notify("web_torn");
  }
}

function function_52f52ae0(var_a8dac2c5) {
  var_a8dac2c5 endon("death");
  self waittill("web_torn");
  var_a8dac2c5 delete();
}

function function_eca55d4c() {
  self endon("death");
  self endon("web_torn");
  self.e_destructible setCanDamage(1);
  self.b_destroyed = 0;
  var_50f39d2b = level.players[0];
  while(!self.b_destroyed) {
    self.e_destructible waittill("damage", n_damage, e_attacker, v_vector, v_point, str_means_of_death, str_string_1, str_string_2, str_string_3, w_weapon);
    if(zm_utility::is_player_valid(e_attacker) && str_means_of_death == "MOD_MELEE") {
      if(w_weapon === getweapon("bowie_knife")) {
        self.b_destroyed = 1;
        var_50f39d2b = e_attacker;
        var_50f39d2b.var_f795ee17 = 1;
      }
    } else {
      self.health = 10000;
      wait(0.05);
    }
  }
  var_50f39d2b function_20915a1a();
  self thread function_6b1cc9fb(1);
  if(isDefined(self.var_ae94a833)) {
    self thread[[self.var_ae94a833]]();
  } else {
    self notify("web_torn");
  }
}

function function_6b1cc9fb(b_destroyed = 0, v_origin, v_angles, var_ef07eb9d = 0) {
  if(!isDefined(self.var_1c12769f)) {
    return;
  }
  if(isDefined(v_origin)) {
    var_fde3dbd8 = v_origin;
  } else {
    var_fde3dbd8 = self.var_1c12769f.origin;
  }
  if(isDefined(v_angles)) {
    var_e1a86b86 = v_angles;
  } else {
    var_e1a86b86 = self.var_1c12769f.angles;
  }
  if(!isDefined(self.var_160abeb7) && !b_destroyed) {
    self.var_160abeb7 = util::spawn_model("tag_origin", var_fde3dbd8, var_e1a86b86);
    self.var_160abeb7 function_9b41e249(1, self.var_1c12769f.script_string);
  } else {
    if(!isDefined(self.var_160abeb7) && b_destroyed) {
      self.var_160abeb7 = util::spawn_model("tag_origin", var_fde3dbd8, var_e1a86b86);
      if(var_ef07eb9d) {
        self.var_160abeb7 function_9b41e249(1, "spider_web_particle_explosive", 1);
      } else {
        self.var_160abeb7 function_9b41e249(1, self.var_1c12769f.script_string, 1);
      }
      util::wait_network_frame();
      if(isDefined(self.var_160abeb7)) {
        self.var_160abeb7 delete();
      }
    } else {
      self.var_160abeb7 function_9b41e249(0);
      if(b_destroyed) {
        self.var_160abeb7 function_9b41e249(1, self.var_1c12769f.script_string, 1);
      }
      util::wait_network_frame();
      if(isDefined(self.var_160abeb7)) {
        self.var_160abeb7 delete();
      }
    }
  }
}

function function_9b41e249(var_eddcecaa = 1, str_type, b_completed = 0) {
  if(!var_eddcecaa) {
    self clientfield::set("play_spider_web_tear_fx", 0);
    return;
  }
  switch (str_type) {
    case "spider_web_particle_bgb": {
      if(!b_completed) {
        self clientfield::set("play_spider_web_tear_fx", 1);
      } else {
        self clientfield::set("play_spider_web_tear_complete_fx", 1);
      }
      break;
    }
    case "spider_web_particle_perk_machine": {
      if(!b_completed) {
        self clientfield::set("play_spider_web_tear_fx", 2);
      } else {
        self clientfield::set("play_spider_web_tear_complete_fx", 2);
      }
      break;
    }
    case "spider_web_particle_doorbuy": {
      if(!b_completed) {
        self clientfield::set("play_spider_web_tear_fx", 3);
      } else {
        self clientfield::set("play_spider_web_tear_complete_fx", 3);
      }
      break;
    }
    case "spider_web_particle_explosive": {
      self clientfield::set("play_spider_web_tear_complete_fx", 4);
      break;
    }
    default: {
      if(!b_completed) {
        self clientfield::set("play_spider_web_tear_fx", 2);
      } else {
        self clientfield::set("play_spider_web_tear_complete_fx", 2);
      }
      break;
    }
  }
}

function function_d717ef02() {
  self endon("death");
  self.var_255c77dc = 0;
  while(true) {
    level waittill("end_of_round");
    self.var_255c77dc = 0;
  }
}

function function_20915a1a(n_multiplier = 1, var_2b5697d = 0) {
  self endon("death");
  if(self.var_255c77dc < 100) {
    var_86b6ca3c = (10 * n_multiplier) * zm_score::get_points_multiplier(self);
    self zm_score::add_to_player_score(var_86b6ca3c);
    self.var_255c77dc = self.var_255c77dc + var_86b6ca3c;
  }
  self notify("hash_52472986");
  if(var_2b5697d) {
    self notify("hash_7ae66b0a");
  }
  if(self.var_7f3c8431 && self.var_f795ee17 && self.var_86009342 && self.var_3b4423fd && self.var_ee8976c8 && self.var_5c159c87) {
    self notify("hash_1327d1d5");
  }
}

function function_f67965ad(var_4e7dce73) {
  if(level.round_number === 1) {
    return true;
  }
  if(zm_utility::check_point_in_enabled_zone(var_4e7dce73, 1)) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, var_4e7dce73) < 640000) {
        return false;
      }
      if(player util::is_player_looking_at(var_4e7dce73, 0.5, 0) && distancesquared(player.origin, var_4e7dce73) < 1440000) {
        return false;
      }
    }
    return true;
  }
  return false;
}

function function_3fd0c070() {
  level flagsys::wait_till("");
  zm_devgui::add_custom_devgui_callback(&function_8457e10f);
}

function function_8457e10f(cmd) {
  switch (cmd) {
    case "": {
      var_19764360 = get_favorite_enemy();
      s_spawn_point = function_570247b9(var_19764360);
      ai = zombie_utility::spawn_zombie(level.var_c38a4fee[0]);
      if(isDefined(ai) && isDefined(s_spawn_point)) {
        s_spawn_point thread function_49e57a3b(ai, s_spawn_point);
      }
      break;
    }
    case "": {
      var_19764360 = get_favorite_enemy();
      s_spawn_point = function_570247b9(var_19764360);
      ai = zombie_utility::spawn_zombie(level.var_c38a4fee[0]);
      if(isDefined(ai) && isDefined(s_spawn_point)) {
        s_spawn_point thread function_49e57a3b(ai, s_spawn_point, 1);
      }
      break;
    }
    case "": {
      a_enemies = getaiteamarray(level.zombie_team);
      if(a_enemies.size > 0) {
        foreach(e_enemy in a_enemies) {
          if(isDefined(e_enemy.b_is_spider) && e_enemy.b_is_spider) {
            e_enemy kill();
          }
        }
      }
      break;
    }
    case "": {
      level.var_3013498 = level.round_number + 1;
      zm_devgui::zombie_devgui_goto_round(level.var_3013498);
      break;
    }
    case "": {
      level.var_42034f6a = 100;
      break;
    }
    case "": {
      level.var_f618f3e1 = 1;
      level.var_42034f6a = 100;
      level notify("enable_all_webs");
      util::wait_network_frame();
      foreach(trigger in level.var_d3b40681) {
        if(!(isDefined(trigger.var_f83345c7) && trigger.var_f83345c7)) {
          trigger notify("trigger", level.players[0], trigger);
        }
      }
      break;
    }
  }
}