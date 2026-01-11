/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_raz.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\aat_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#namespace zm_ai_raz;

function autoexec __init__sytem__() {
  system::register("zm_ai_raz", &__init__, &__main__, undefined);
}

function __init__() {
  init();
}

function __main__() {
  register_clientfields();
  execdevgui("");
  thread function_fbcfe4b6();
}

function register_clientfields() {}

function init() {
  zm::register_player_damage_callback(&function_94372a17);
  level.var_2e815d61 = 1;
  level.var_629d0743 = 0;
  level.var_d4fa016a = 1;
  level.var_b9ce6312 = 0;
  level.var_6bca5baa = [];
  level.var_f95eaac8 = 5500;
  zm_score::register_score_event("death_raz", &function_6fdcefe3);
  level flag::init("raz_round");
  level flag::init("raz_round_in_progress");
  level thread aat::register_immunity("zm_aat_blast_furnace", "raz", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_dead_wire", "raz", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_fire_works", "raz", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_thunder_wall", "raz", 1, 1, 1);
  level thread aat::register_immunity("zm_aat_turned", "raz", 1, 1, 1);
  function_e099c556();
  level thread function_ff9b21c4();
}

function function_6fdcefe3(str_event, str_mod, str_hit_location, var_48d0b2fe, var_2f7fd5db) {
  if(str_event === "death_raz") {
    var_1fdfc3ef = zm_score::get_zombie_death_player_points();
    var_2d175949 = self zm_score::player_add_points_kill_bonus(str_mod, str_hit_location, var_2f7fd5db);
    var_1fdfc3ef = (var_1fdfc3ef + var_2d175949) * 2;
    if(str_mod == "MOD_GRENADE" || str_mod == "MOD_GRENADE_SPLASH") {
      self zm_stats::increment_client_stat("grenade_kills");
      self zm_stats::increment_player_stat("grenade_kills");
    }
    scoreevents::processscoreevent("kill_raz", self, undefined, var_2f7fd5db);
    return var_1fdfc3ef;
  }
  return 0;
}

function function_7dfa7ca6() {
  level.var_629d0743 = 1;
  if(!isDefined(level.var_c810e243)) {
    level.var_c810e243 = &function_684ce0;
  }
  level thread[[level.var_c810e243]]();
}

function function_e099c556() {
  level.var_6bca5baa = getEntArray("zombie_raz_spawner", "script_noteworthy");
  if(level.var_6bca5baa.size == 0) {
    assertmsg("");
    return;
  }
  foreach(var_ad58b9ca in level.var_6bca5baa) {
    var_ad58b9ca.is_enabled = 1;
    var_ad58b9ca.script_forcespawn = 1;
    var_ad58b9ca spawner::add_spawn_function(&function_4749ab89);
  }
}

function function_ff9b21c4() {
  level waittill("start_of_round");
  function_a67ada8();
  while(true) {
    level waittill("between_round_over");
    function_a67ada8();
  }
}

function function_684ce0() {
  level.var_d4fa016a = 1;
  level.var_51a5abd0 = randomintrange(5, 8);
  if(getdvarint("") > 0) {
    level.var_51a5abd0 = 5;
  }
  old_spawn_func = level.round_spawn_func;
  old_wait_func = level.round_wait_func;
  while(true) {
    level waittill("between_round_over");
    if(getdvarint("") > 0) {
      level.var_51a5abd0 = level.round_number;
    }
    if(level.round_number == level.var_51a5abd0) {
      level.sndmusicspecialround = 1;
      old_spawn_func = level.round_spawn_func;
      old_wait_func = level.round_wait_func;
      function_77ff30a0();
      level.round_spawn_func = &function_a33bc00f;
      level.round_wait_func = &function_692370a0;
      if(isDefined(level.var_95444cb4)) {
        level.var_51a5abd0 = [[level.var_95444cb4]]();
      } else {
        level.var_51a5abd0 = level.var_51a5abd0 + randomintrange(5, 8);
      }
      getplayers()[0] iprintln("" + level.var_51a5abd0);
    } else if(level flag::get("raz_round")) {
      function_783ab6ac();
      level.round_spawn_func = old_spawn_func;
      level.round_wait_func = old_wait_func;
      level.var_d4fa016a++;
    }
  }
}

function function_77ff30a0() {
  level flag::set("raz_round");
  level flag::set("special_round");
  level.var_b9ce6312 = 1;
  level notify("hash_61c47438");
  level thread zm_audio::sndmusicsystem_playstate("raz_start");
}

function function_783ab6ac() {
  level flag::clear("raz_round");
  level flag::clear("special_round");
  level.var_b9ce6312 = 0;
  level notify("hash_22aa6eed");
}

function function_a33bc00f() {
  level endon("intermission");
  level endon("raz_round");
  level.var_bc3f44bf = getplayers();
  for(i = 0; i < level.var_bc3f44bf.size; i++) {
    level.var_bc3f44bf[i].hunted_by = 0;
  }
  level endon("restart_round");
  level endon("kill_round");
  if(getdvarint("") == 2 || getdvarint("") >= 4) {
    return;
  }
  if(level.intermission) {
    return;
  }
  array::thread_all(level.players, &function_bdf13070);
  n_wave_count = function_852019c2();
  function_a67ada8();
  level.zombie_total = int(n_wave_count);
  if(getdvarstring("") != "" && getdvarint("") > 0) {
    level.zombie_total = getdvarint("");
    setdvar("", 0);
  }
  wait(1);
  wait(6);
  var_c55cf881 = 0;
  level flag::set("raz_round_in_progress");
  level endon("last_ai_down");
  level thread function_25561504();
  while(true) {
    while(level.zombie_total > 0) {
      if(isDefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
        util::wait_network_frame();
        continue;
      }
      function_45bace88();
      util::wait_network_frame();
    }
    util::wait_network_frame();
  }
}

function function_665a13cd(spawner, s_spot) {
  var_a09c80cd = zombie_utility::spawn_zombie(level.var_6bca5baa[0], "raz", s_spot);
  if(isDefined(var_a09c80cd)) {
    var_a09c80cd.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    var_a09c80cd thread zombie_utility::round_spawn_failsafe();
    var_a09c80cd thread function_b8671cc0(s_spot);
  }
  return var_a09c80cd;
}

function function_b8671cc0(s_spot) {
  if(isDefined(level.var_71ab2462)) {
    self thread[[level.var_71ab2462]](s_spot);
  }
  if(isDefined(level.var_ae95a175)) {
    self thread[[level.var_ae95a175]]();
  }
}

function function_45bace88() {
  while(!function_ea911683()) {
    wait(0.1);
  }
  s_spawn_loc = undefined;
  var_19764360 = get_favorite_enemy();
  if(!isDefined(var_19764360)) {
    wait(randomfloatrange(0.3333333, 0.6666667));
    return;
  }
  if(isDefined(level.var_e80c1065)) {
    s_spawn_loc = [[level.var_e80c1065]](var_19764360);
  } else {
    iprintlnbold("");
    if(level.zm_loc_types[""].size == 0) {}
    s_spawn_loc = array::random(level.zm_loc_types["raz_location"]);
  }
  if(!isDefined(s_spawn_loc)) {
    wait(randomfloatrange(0.3333333, 0.6666667));
    return;
  }
  ai = function_665a13cd(level.var_6bca5baa[0]);
  if(isDefined(ai)) {
    ai thread function_b8671cc0(s_spawn_loc);
    ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
    if(isDefined(var_19764360)) {
      ai.favoriteenemy = var_19764360;
      ai.favoriteenemy.hunted_by++;
    }
    level.zombie_total--;
    function_a74c2884();
  }
}

function function_852019c2() {
  switch (level.players.size) {
    case 1: {
      n_wave_count = 6;
      break;
    }
    case 2: {
      n_wave_count = 10;
      break;
    }
    case 3: {
      n_wave_count = 14;
      break;
    }
    case 4:
    default: {
      n_wave_count = 16;
      break;
    }
  }
  return n_wave_count;
}

function function_692370a0() {
  level endon("restart_round");
  level endon("kill_round");
  if(level flag::get("raz_round")) {
    level flag::wait_till("raz_round_in_progress");
    level flag::wait_till_clear("raz_round_in_progress");
  }
  level.sndmusicspecialround = 0;
}

function function_a1d75eeb() {
  var_89de5b91 = getEntArray("zombie_raz", "targetname");
  var_c55cf881 = var_89de5b91.size;
  foreach(var_1c963231 in var_89de5b91) {
    if(!isalive(var_1c963231)) {
      var_c55cf881--;
    }
  }
  return var_c55cf881;
}

function function_bcbbda54() {
  switch (level.players.size) {
    case 1: {
      return 2;
      break;
    }
    case 2: {
      return 3;
      break;
    }
    case 3: {
      return 4;
      break;
    }
    case 4: {
      return 4;
      break;
    }
  }
}

function function_ea911683() {
  var_c55cf881 = function_a1d75eeb();
  var_f0ab435a = function_bcbbda54();
  if(var_c55cf881 >= var_f0ab435a || !level flag::get("spawn_zombies")) {
    return false;
  }
  return true;
}

function function_a74c2884() {
  switch (level.players.size) {
    case 1: {
      n_default_wait = 2.25;
      break;
    }
    case 2: {
      n_default_wait = 1.75;
      break;
    }
    case 3: {
      n_default_wait = 1.25;
      break;
    }
    default: {
      n_default_wait = 0.75;
      break;
    }
  }
  wait(n_default_wait);
}

function function_25561504() {
  level waittill("last_ai_down", e_enemy_ai);
  level thread zm_audio::sndmusicsystem_playstate("raz_over");
  if(isDefined(level.zm_override_ai_aftermath_powerup_drop)) {
    [[level.zm_override_ai_aftermath_powerup_drop]](e_enemy_ai, level.var_6a6f912a);
  } else {
    var_4a50cb2a = level.var_6a6f912a;
    trace = groundtrace(var_4a50cb2a + vectorscale((0, 0, 1), 100), var_4a50cb2a + (vectorscale((0, 0, -1), 1000)), 0, undefined);
    var_4a50cb2a = trace["position"];
    if(isDefined(var_4a50cb2a)) {
      level thread zm_powerups::specific_powerup_drop("full_ammo", var_4a50cb2a);
    }
  }
  wait(2);
  level.sndmusicspecialround = 0;
  wait(6);
  level flag::clear("raz_round_in_progress");
}

function get_favorite_enemy() {
  var_bc3f44bf = getplayers();
  e_least_hunted = undefined;
  foreach(e_target in var_bc3f44bf) {
    if(!isDefined(e_target.hunted_by)) {
      e_target.hunted_by = 0;
    }
    if(!zm_utility::is_player_valid(e_target)) {
      continue;
    }
    if(isDefined(level.var_3fded92e) && ![
        [level.var_3fded92e]
      ](e_target)) {
      continue;
    }
    if(!isDefined(e_least_hunted)) {
      e_least_hunted = e_target;
      continue;
    }
    if(e_target.hunted_by < e_least_hunted.hunted_by) {
      e_least_hunted = e_target;
    }
  }
  return e_least_hunted;
}

function function_a67ada8() {
  level.var_f95eaac8 = 5500 + (level.round_number * 100);
  if(level.var_f95eaac8 < 5500) {
    level.var_f95eaac8 = 5500;
  } else if(level.var_f95eaac8 > 15000) {
    level.var_f95eaac8 = 15000;
  }
  level.var_f95eaac8 = int(level.var_f95eaac8 * (1 + (0.15 * (level.players.size - 1))));
  level.razgunhealth = level.var_f95eaac8 * 0.15;
  level.razhelmethealth = level.var_f95eaac8 * 0.3;
  level.razleftshoulderarmorhealth = level.var_f95eaac8 * 0.25;
  level.razchestarmorhealth = level.var_f95eaac8 * 0.4;
  level.razthigharmorhealth = level.var_f95eaac8 * 0.25;
}

function function_bdf13070() {
  self playlocalsound("zmb_raz_round_start");
  variation_count = 5;
  wait(4.5);
  players = getplayers();
  num = randomintrange(0, players.size);
  players[num] zm_audio::create_and_play_dialog("general", "raz_spawn");
}

function function_4749ab89() {
  self.targetname = "zombie_raz";
  self.script_noteworthy = undefined;
  self.animname = "zombie_raz";
  self.allowdeath = 1;
  self.allowpain = 1;
  self.force_gib = 1;
  self.is_zombie = 1;
  self.gibbed = 0;
  self.head_gibbed = 0;
  self.default_goalheight = 40;
  self.ignore_inert = 1;
  self.lightning_chain_immune = 1;
  self.holdfire = 1;
  self.grenadeawareness = 0;
  self.badplaceawareness = 0;
  self.ignoresuppression = 1;
  self.suppressionthreshold = 1;
  self.nododgemove = 1;
  self.dontshootwhilemoving = 1;
  self.pathenemylookahead = 0;
  self.chatinitialized = 0;
  self.missinglegs = 0;
  self.team = level.zombie_team;
  self.sword_kill_power = 4;
  self.instakill_func = &function_a59f11f9;
  self thread zombie_utility::zombie_eye_glow();
  if(isDefined(level.var_c7da0559)) {
    self.func_custom_cleanup_check = level.var_c7da0559;
  }
  self.maxhealth = level.var_f95eaac8;
  if(isDefined(level.a_zombie_respawn_health[self.archetype]) && level.a_zombie_respawn_health[self.archetype].size > 0) {
    self.health = level.a_zombie_respawn_health[self.archetype][0];
    arrayremovevalue(level.a_zombie_respawn_health[self.archetype], level.a_zombie_respawn_health[self.archetype][0]);
  } else {
    self.health = self.maxhealth;
  }
  self thread function_f8080b7();
  level thread zm_spawner::zombie_death_event(self);
  self thread zm_spawner::enemy_death_detection();
  self zm_spawner::zombie_history(("zombie_raz_spawn_init -> Spawned = ") + self.origin);
  if(isDefined(level.achievement_monitor_func)) {
    self thread[[level.achievement_monitor_func]]();
  }
}

function function_f8080b7() {
  self waittill("death", attacker);
  self thread zombie_utility::zombie_eye_glow_stop();
  if(function_a1d75eeb() == 0 && level.zombie_total == 0) {
    if(!isDefined(level.zm_ai_round_over) || [
        [level.zm_ai_round_over]
      ]()) {
      level.var_6a6f912a = self.origin;
      level notify("last_ai_down", self);
    }
  }
  if(isplayer(attacker)) {
    if(!(isDefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
      attacker zm_score::player_add_points("death_raz", self.damagemod, self.damagelocation);
    }
    if(isDefined(level.hero_power_update)) {
      [
        [level.hero_power_update]
      ](attacker, self);
    }
    attacker zm_audio::create_and_play_dialog("kill", "raz");
    attacker zm_stats::increment_client_stat("zraz_killed");
    attacker zm_stats::increment_player_stat("zraz_killed");
  }
  if(isDefined(attacker) && isai(attacker)) {
    attacker notify("killed", self);
  }
  if(isDefined(self)) {
    self stoploopsound();
    self thread function_b1f85217(self.origin);
  }
}

function function_b1f85217(origin) {}

function function_b4cd74ca() {
  self zm_spawner::zombie_history("zombie_setup_attack_properties()");
  self.ignoreall = 0;
  self.meleeattackdist = 64;
  self.disablearrivals = 1;
  self.disableexits = 1;
}

function function_7b5bfac6() {
  self waittill("death");
  self stopsounds();
}

function function_7ed6c714(n_to_spawn = 1, var_e41e673a, b_force_spawn = 0, var_b7959229 = undefined) {
  n_spawned = 0;
  while(n_spawned < n_to_spawn) {
    if(!b_force_spawn && !function_ea911683()) {
      return n_spawned;
    }
    players = getplayers();
    var_19764360 = get_favorite_enemy();
    if(isDefined(var_b7959229)) {
      s_spawn_loc = var_b7959229;
    } else {
      if(isDefined(level.var_a3559c05)) {
        s_spawn_loc = [[level.var_a3559c05]](level.var_6bca5baa, var_19764360);
      } else if(level.zm_loc_types["raz_location"].size > 0) {
        s_spawn_loc = array::random(level.zm_loc_types["raz_location"]);
      }
    }
    if(!isDefined(s_spawn_loc)) {
      return 0;
    }
    ai = function_665a13cd(level.var_6bca5baa[0]);
    if(isDefined(ai)) {
      ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
      ai.script_string = s_spawn_loc.script_string;
      ai.find_flesh_struct_string = ai.script_string;
      if(isDefined(var_19764360)) {
        ai.favoriteenemy = var_19764360;
        ai.favoriteenemy.hunted_by++;
      }
      n_spawned++;
      if(isDefined(var_e41e673a)) {
        ai thread[[var_e41e673a]]();
      }
      playsoundatposition("zmb_raz_spawn", s_spawn_loc.origin);
    }
    function_a74c2884();
  }
  return 1;
}

function function_175052a7() {
  self endon("death");
  while(true) {
    self playSound("zmb_hellhound_vocals_amb");
    wait(randomfloatrange(3, 6));
  }
}

function function_d1fed7c2(player, gib) {
  self endon("death");
  damage = int(self.maxhealth * 0.5);
  self dodamage(damage, player.origin, player, undefined, "none", "MOD_UNKNOWN");
}

function function_94372a17(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime) {
  player = self;
  if(isDefined(attacker) && attacker.archetype === "raz" && mod === "MOD_PROJECTILE_SPLASH" && isDefined(weapon) && issubstr("raz_melee", weapon.name)) {
    dist_sq = distancesquared(attacker.origin, player.origin);
    var_bfa346a2 = 16384;
    var_a9914202 = 1 - (dist_sq / var_bfa346a2);
    var_2882f9d = 35;
    damage = var_2882f9d * var_a9914202;
    damage = int(damage);
    damage = damage + 15;
    return damage;
  }
  return -1;
}

function function_a59f11f9(e_player, var_3ca8546d, var_9908b5f4) {
  if(var_9908b5f4 == "right_arm_lower" || var_9908b5f4 == "right_hand") {
    return true;
  }
  if(var_9908b5f4 == "right_arm_upper" && self.razhasgunattached == 1) {
    self.razgunhealth = 1;
    self dodamage(1, e_player.origin, e_player, e_player, "right_arm_upper");
    return true;
  }
  if(isDefined(self.last_damage_hit_armor) && self.last_damage_hit_armor) {
    return true;
  }
  return false;
}

function function_fbcfe4b6() {
  level flag::wait_till("");
  zm_devgui::add_custom_devgui_callback(&function_3626e3d1);
}

function function_3626e3d1(cmd) {
  switch (cmd) {
    case "": {
      function_39a724b1();
      break;
    }
    case "": {
      function_9a80ee5f();
      break;
    }
    case "": {
      function_e115a394(getdvarint(""));
      break;
    }
    case "": {
      function_70864ef2(getdvarint(""));
      break;
    }
  }
}

function function_39a724b1() {
  player = level.players[0];
  v_direction = player getplayerangles();
  v_direction = anglesToForward(v_direction) * 8000;
  eye = player getEye();
  trace = bulletTrace(eye, eye + v_direction, 0, undefined);
  var_feba5c63 = positionquery_source_navigation(trace[""], 128, 256, 128, 20);
  s_spot = spawnStruct();
  if(isDefined(var_feba5c63) && var_feba5c63.data.size > 0) {
    s_spot.origin = var_feba5c63.data[0].origin;
  } else {
    s_spot.origin = player.origin;
  }
  s_spot.angles = (0, player.angles[1] - 180, 0);
  function_7ed6c714(1, undefined, 1, s_spot);
  return true;
}

function function_9a80ee5f() {
  if(!(isDefined(level.b_raz_ignore_mangler_cooldown) && level.b_raz_ignore_mangler_cooldown)) {
    level.b_raz_ignore_mangler_cooldown = 1;
  } else {
    level.b_raz_ignore_mangler_cooldown = undefined;
  }
}

function function_e115a394(var_eee0e63b) {
  if(!isDefined(level.var_2e815d61) || !level.var_2e815d61) {
    return;
  }
  if(!isDefined(level.var_629d0743) || !level.var_629d0743) {
    return;
  }
  if(!isDefined(level.var_6bca5baa) || level.var_6bca5baa.size < 1) {
    return;
  }
  function_d8afb0d4(var_eee0e63b);
  level.var_51a5abd0 = level.round_number + 1;
}

function function_70864ef2(var_eee0e63b) {
  if(isDefined(level.var_51a5abd0)) {
    function_d8afb0d4(var_eee0e63b);
    zm_devgui::zombie_devgui_goto_round(level.var_51a5abd0);
  }
}

function function_d8afb0d4(var_eee0e63b) {
  if(isDefined(var_eee0e63b) && var_eee0e63b > 0) {
    setdvar("", var_eee0e63b);
  } else {
    setdvar("", "");
  }
}