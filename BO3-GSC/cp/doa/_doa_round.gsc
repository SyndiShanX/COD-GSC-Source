/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_round.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\doa\_doa_arena;
#using scripts\cp\doa\_doa_dev;
#using scripts\cp\doa\_doa_enemy;
#using scripts\cp\doa\_doa_fx;
#using scripts\cp\doa\_doa_gibs;
#using scripts\cp\doa\_doa_hazard;
#using scripts\cp\doa\_doa_pickups;
#using scripts\cp\doa\_doa_player_utility;
#using scripts\cp\doa\_doa_score;
#using scripts\cp\doa\_doa_utility;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\util_shared;
#namespace namespace_cdb9a8fe;

function private function_542758d0() {
  level.doa.var_f5e35752 = [];
  level.doa.var_5a609640 = [];
  challenges = struct::get_array("doa_challenge_def");
  for(i = 0; i < challenges.size; i++) {
    var_d0cde02c = challenges[i];
    var_72085a07 = spawnStruct();
    var_72085a07.spawner = getent(var_d0cde02c.target, "targetname");
    var_72085a07.spawner.var_d0cde02c = var_d0cde02c;
    assert(isDefined(var_d0cde02c.script_noteworthy));
    var_72085a07.number = int(var_d0cde02c.script_noteworthy);
    if(isDefined(level.doa.var_d18af0d)) {
      [
        [level.doa.var_d18af0d]
      ](var_72085a07);
    }
    if(!isDefined(var_72085a07.round)) {
      var_72085a07.round = (var_72085a07.number * 4) + 4;
    }
    if(!isDefined(var_72085a07.var_23502a36)) {
      var_72085a07.var_23502a36 = level.doa.rules.var_c53b19d1;
    }
    if(!isDefined(var_72085a07.var_84aef63e)) {
      var_72085a07.var_84aef63e = level.doa.rules.var_1faeb8d5;
    }
    if(!isDefined(var_72085a07.spawnfunc)) {
      var_72085a07.spawnfunc = &doa_enemy::function_a4e16560;
    }
    if(!isDefined(var_72085a07.var_83bae1f8)) {
      var_72085a07.var_83bae1f8 = level.doa.rules.var_466591b1;
    }
    level.doa.var_5a609640[level.doa.var_5a609640.size] = var_72085a07;
  }
}

function function_8c6e89b4(round) {
  for(i = 0; i < level.doa.var_5a609640.size; i++) {
    if(level.doa.var_5a609640[i].round == round) {
      return level.doa.var_5a609640[i];
    }
  }
}

function private function_5f5d09ae() {
  def = function_8c6e89b4(level.doa.round_number);
  if(!isDefined(def)) {
    level.doa.var_d0cde02c = undefined;
    return;
  }
  if(isDefined(def.initfunc)) {
    level thread[[def.initfunc]](def);
  }
  level thread doa_utility::function_c5f3ece8(&"DOA_CHALLENGE", undefined, 6, (1, 0, 0));
  level.voice playSound("vox_doaa_challenge_round");
  level thread doa_utility::function_37fb5c23(def.title, undefined, 5, (1, 0, 0));
  level.doa.var_d0cde02c = def;
  if(isDefined(def.var_84aef63e)) {
    if(isDefined(def.var_3ceda880) && def.var_3ceda880) {
      level.doa.rules.max_enemy_count = def.var_84aef63e;
    }
    if(level.doa.rules.max_enemy_count < def.var_84aef63e) {
      level.doa.rules.max_enemy_count = def.var_84aef63e;
    }
  }
  if(isDefined(def.var_965be9)) {
    level thread[[def.var_965be9]](def);
  }
}

function function_691ef36b() {
  level.doa.var_c838db72 = [];
  spawners = getEntArray("doa_basic_spawner", "targetname");
  for(i = 0; i < spawners.size; i++) {
    if(!isDefined(spawners[i].script_noteworthy)) {
      spawners[i].script_noteworthy = 1;
    }
    if(int(spawners[i].script_noteworthy) <= level.doa.round_number) {
      spawners[i].var_8d1af144 = 1;
      level.doa.var_c838db72[level.doa.var_c838db72.size] = spawners[i];
    }
  }
}

function function_c81e1083(name) {
  setname = name + "_enemy_spawn";
  spawners = struct::get_array(setname);
  level.doa.spawners[setname] = [];
  level.doa.spawners[setname]["top"] = [];
  level.doa.spawners[setname]["bottom"] = [];
  level.doa.spawners[setname]["left"] = [];
  level.doa.spawners[setname]["right"] = [];
  for(i = 0; i < spawners.size; i++) {
    side = spawners[i].script_noteworthy;
    size = level.doa.spawners[setname][side].size;
    level.doa.spawners[setname][side][size] = spawners[i];
  }
  level.doa.spawners[setname]["boss"] = struct::get_array(name + "_no_traverse_spawn");
  level.doa.spawners[setname]["wolf"] = struct::get_array(name + "_no_traverse_spawn");
  level.doa.spawners[setname]["skeleton"] = struct::get_array(name + "_no_traverse_spawn");
}

function main() {
  level endon("hash_24d3a44");
  foreach(player in getplayers()) {
    player thread namespace_831a4a7c::function_7d7a7fde();
  }
  level thread function_d87cb356();
  function_542758d0();
  function_d9345c74();
  while(!level flag::get("doa_game_is_over")) {
    doa_utility::debugmsg((("" + level.doa.round_number) + "") + gettime());
    level.doa.rules.max_enemy_count = namespace_3ca3c537::function_b0e9983(namespace_3ca3c537::function_d2d75f5d());
    level.doa.var_a3a11449 = 0;
    level.doa.var_2f019708 = 1;
    level.doa.var_677d1262 = 0;
    changeadvertisedstatus((level.doa.round_number < 9 ? 1 : 0));
    function_5f5d09ae();
    function_691ef36b();
    function_703bb8b2(level.doa.round_number);
    if(isDefined(level.doa.var_c95041ea)) {
      var_ca7f54a6 = level[[level.doa.var_c95041ea]]();
    }
    if(isDefined(level.doa.dev_level_skipped)) {
      flag::clear("");
      doa_utility::killallenemy();
      wait(1);
      doa_utility::killallenemy();
    }
    if(!(isDefined(var_ca7f54a6) && var_ca7f54a6)) {
      if(!isDefined(level.doa.dev_level_skipped)) {
        flag::set("doa_round_active");
        if(isDefined(level.doa.var_d0cde02c)) {
          level notify("hash_ba37290e", "challenge");
        } else {
          level notify("hash_ba37290e");
        }
        function_87703158();
      }
      doa_utility::function_c157030a();
      waittillframeend();
      level.doa.var_677d1262 = 0;
      level.doa.round_end_time = gettime();
      doa_utility::debugmsg((("" + level.doa.round_number) + "") + level.doa.round_end_time);
      flag::clear("doa_round_active");
      level notify("hash_e9dfbb22");
      foreach(player in getplayers()) {
        player notify("hash_e9dfbb22");
      }
      if(level flag::get("doa_game_is_over")) {
        break;
      }
      level.doa.var_b351e5fb = 0;
      while(level flag::get("doa_round_paused")) {
        wait(0.05);
        continue;
      }
      level thread doa_pickups::spawnmoneyglob(0, 3);
      var_d2d5db8a = namespace_3ca3c537::function_78c7b56e();
    } else {
      level waittill("hash_593b80cb");
      level.doa.var_677d1262 = 0;
    }
    if(level flag::get("doa_game_is_over")) {
      break;
    }
    level.doa.zombie_move_speed = level.doa.zombie_move_speed + level.doa.var_c9e1c854;
    level.doa.zombie_health = level.doa.zombie_health + level.doa.zombie_health_inc;
    level.doa.round_number++;
    level.doa.var_6f2c52d8 = undefined;
    level clientfield::set("roundnumber", level.doa.round_number &(1024 - 1));
    function_d9345c74();
    function_55762a85();
    namespace_d88e3a06::function_7a8a936b();
    if(isDefined(var_d2d5db8a) && var_d2d5db8a) {
      level thread namespace_3ca3c537::function_e88371e5();
    }
    namespace_831a4a7c::function_82e3b1cb();
    level notify("hash_31680c6");
    doa_utility::function_390adefe();
  }
}

function private function_d87cb356() {
  self notify("hash_d87cb356");
  self endon("hash_d87cb356");
  level endon("hash_24d3a44");
  while(!level flag::get("doa_game_is_over")) {
    level.doa.in_intermission = 0;
    while(level flag::get("doa_round_active")) {
      wait(1);
    }
    level.doa.in_intermission = 1;
    while(!level flag::get("doa_round_active")) {
      wait(1);
    }
  }
}

function function_40bfe842(entnum = 0) {
  if(isDefined(level.doa.var_a3a11449) && level.doa.var_a3a11449) {
    switch (entnum) {
      case 0: {
        var_3c70b682 = "top";
        break;
      }
      case 1: {
        var_3c70b682 = "bottom";
        break;
      }
      case 2: {
        var_3c70b682 = "left";
        break;
      }
      default: {
        var_3c70b682 = "right";
        break;
      }
    }
  } else {
    var_3c70b682 = level.doa.previous_exit_taken;
  }
  if(level.doa.arena_round_number != 0) {
    points = level.doa.arenas[level.doa.current_arena].var_f616a3b7[var_3c70b682];
    if(isDefined(points) && points.size) {
      if(!isDefined(points[entnum])) {
        doa_utility::debugmsg((((("" + level.doa.current_arena) + "") + level.doa.previous_exit_taken) + "") + entnum);
        return points[0].origin;
      }
      return points[entnum].origin;
    }
  }
  return namespace_831a4a7c::function_68ece679(entnum).origin;
}

function function_f581d585(point, facepoint) {
  if(isDefined(self.doa.vehicle)) {
    self.doa.vehicle.angles = vectortoangles(facepoint - point);
    self.doa.vehicle.origin = point + vectorscale((0, 0, 1), 72);
    self.doa.vehicle.groundpos = point;
  }
}

function function_fe0946ac(spawn_origin, var_97887a95 = 1) {
  self endon("disconnect");
  while(!isDefined(self.doa)) {
    wait(0.05);
  }
  if(!isDefined(spawn_origin)) {
    spawn_origin = function_40bfe842(self.entnum);
  }
  var_60de7d19 = namespace_3ca3c537::function_61d60e0b();
  self thread namespace_831a4a7c::function_7d7a7fde();
  foreach(guardian in self.doa.var_af875fb7) {
    if(isDefined(guardian)) {
      guardian forceteleport(spawn_origin + (randomintrange(-60, 60), randomintrange(-60, 60), 0), self.angles);
    }
  }
  if(isDefined(self.doa) && isDefined(self.doa.vehicle)) {
    self thread function_f581d585(spawn_origin, var_60de7d19);
  } else {
    if(!isDefined(self.doa.shield_is_on)) {
      self.doa.var_f4a883ed = undefined;
      self disableinvulnerability();
    }
    self setorigin(spawn_origin);
  }
  angles = vectortoangles(var_60de7d19 - self.origin);
  self setplayerangles((0, angles[1], 0));
  self notify("move_to_start");
  if(var_97887a95) {
    self thread namespace_831a4a7c::function_b5843d4f(level.doa.arena_round_number == 3);
    self thread namespace_831a4a7c::function_f2507519(level.doa.arena_round_number == 3);
  }
}

function function_55762a85(spawn_origin) {
  stopallrumbles();
  array::thread_all(getplayers(), &function_fe0946ac, spawn_origin);
  level notify("hash_3b6e1e2");
}

function private function_ff7f941a(def) {
  num = doa_utility::function_2f0d697f(def.spawner);
  if(num >= def.var_84aef63e) {
    return false;
  }
  if(isDefined(def.var_a0b2e897) && namespace_3ca3c537::function_d2d75f5d() != def.var_a0b2e897) {
    return false;
  }
  return true;
}

function function_21a582ff(current_wave, endnote) {
  if(isDefined(endnote)) {
    level endon(endnote);
  }
  level.doa.var_3706f843[level.doa.var_3706f843.size] = current_wave;
  spawn_locations = level.doa.current_spawners[current_wave.spawn_side];
  time = current_wave.spawn_duration;
  time = (time * 1000) + gettime();
  while(gettime() < time || (level.players.size == 1 && level.doa.var_9a1cbf58 && current_wave.var_3f7b0d81 > 0)) {
    if(level flag::get("doa_game_is_over") || level flag::get("doa_round_abort")) {
      break;
    }
    wait(getdvarfloat("scr_doa_spawn_delay", 0.35));
    spawnpoint = spawn_locations[randomint(spawn_locations.size)];
    var_48be25f5 = level.doa.var_c838db72[randomint(level.doa.var_c838db72.size)];
    if(isDefined(level.doa.var_d0cde02c) && function_ff7f941a(level.doa.var_d0cde02c)) {
      var_48be25f5 = level.doa.var_d0cde02c.spawner;
      ai = [
        [level.doa.var_d0cde02c.spawnfunc]
      ](var_48be25f5, spawnpoint, level.doa.var_d0cde02c);
      if(isDefined(ai)) {
        current_wave.var_3f7b0d81--;
        ai.var_d3c93fe9 = 1;
        var_48be25f5 = undefined;
      }
    }
    if(isDefined(level.doa.var_d0cde02c) && (isDefined(level.doa.var_d0cde02c.var_3ceda880) && level.doa.var_d0cde02c.var_3ceda880 || getdvarint("scr_doa_onlyboss_during_challenge", 0))) {
      continue;
    }
    if(level.doa.var_f5e35752.size && gettime() > level.doa.var_4481ad9) {
      tries = 5;
      while(tries) {
        var_9f7a6d48 = level.doa.var_f5e35752[randomint(level.doa.var_f5e35752.size)];
        tries--;
        if(isDefined(var_9f7a6d48.cooldown)) {
          if(gettime() < var_9f7a6d48.cooldown) {
            continue;
          }
          var_9f7a6d48.cooldown = gettime() + var_9f7a6d48.var_759562f7;
        }
        roll = var_9f7a6d48.var_23502a36 * 100;
        if(randomint(100) > roll) {
          continue;
        }
        if(level.doa.var_b351e5fb >= level.doa.rules.max_enemy_count) {
          doa_utility::function_fe180f6f(2);
          wait(0.05);
        }
        spawnpoint = spawn_locations[randomint(spawn_locations.size)];
        ai = [[var_9f7a6d48.spawnfunc]](var_9f7a6d48.spawner, spawnpoint, var_9f7a6d48);
        level.doa.var_4481ad9 = gettime() + level.doa.var_5bd7f25a;
        break;
      }
    }
    if(isDefined(level.doa.arenas[level.doa.current_arena].var_f06f27e8)) {
      ai = [
        [level.doa.arenas[level.doa.current_arena].var_f06f27e8]
      ]();
      if(isDefined(ai)) {
        current_wave.var_3f7b0d81--;
      }
    }
    if(isDefined(var_48be25f5)) {
      ai = doa_enemy::function_a4e16560(var_48be25f5, spawnpoint);
      if(isDefined(ai)) {
        current_wave.var_3f7b0d81--;
        ai notify("hash_48b8c577");
        if(!isvehicle(ai) && (!(isDefined(ai.var_ad61c13d) && ai.var_ad61c13d))) {
          ai thread zombie_utility::zombie_gib_on_damage();
          ai.tesla_head_gib_func = &namespace_fba031c8::function_deb7df37;
        }
        if(isDefined(level.doa.var_2836c8ee) && level.doa.var_2836c8ee) {
          ai thread namespace_eaa992c::function_285a2999("spawnZombie");
        }
      }
    }
  }
  arrayremovevalue(level.doa.var_3706f843, current_wave);
}

function function_87703158(var_372a8daa = 0) {
  level notify("hash_50be1db3");
  level endon("hash_50be1db3");
  flag::set("doa_round_spawning");
  level notify("round_spawning_starting");
  level lui::screen_close_menu();
  level.doa.round_start_time = gettime();
  level.doa.round_end_time = undefined;
  level.doa.var_e0d67a74 = struct::get_array(namespace_3ca3c537::function_d2d75f5d() + "_rise_spot");
  spawn_set = level.doa.arenas[level.doa.current_arena].name + "_enemy_spawn";
  level.doa.current_spawners = level.doa.spawners[spawn_set];
  level.doa.var_3706f843 = [];
  var_81b4b863 = 0;
  var_9805ff33 = 0;
  do {
    for(wave = 0; wave < level.doa.spawn_sequence.size; wave++) {
      while(level flag::get("doa_round_paused") || (isDefined(level.hostmigrationtimer) && level.hostmigrationtimer)) {
        wait(0.05);
      }
      if(level flag::get("doa_game_is_over")) {
        break;
      }
      var_81b4b863 = isDefined(var_9805ff33) && var_9805ff33 || (isDefined(getdvarint("scr_doa_infinite_round", 0)) && getdvarint("scr_doa_infinite_round", 0));
      if(!var_81b4b863 && !level flag::get("doa_round_active")) {
        break;
      }
      level.doa.current_wave = level.doa.spawn_sequence[wave];
      level thread function_21a582ff(level.doa.current_wave);
      doa_utility::debugmsg((("" + level.doa.current_wave.var_601f5749) + "") + level.doa.current_wave.spawn_side);
      wait(level.doa.current_wave.time_till_next_group);
      while(level.players.size == 1 && level.doa.var_9a1cbf58 && level.doa.var_3706f843.size > 10) {
        doa_utility::debugmsg("");
        wait(1);
      }
    }
    if(level flag::get("doa_game_is_over")) {
      break;
    }
    var_9805ff33 = (isDefined(level.doa.boss) ? 1 : 0);
    if(!var_9805ff33 && isDefined(level.doa.var_2c8bf5cd)) {
      level.doa.var_2c8bf5cd = array::remove_undefined(level.doa.var_2c8bf5cd);
      var_9805ff33 = level.doa.var_2c8bf5cd.size > 0;
    }
    if(isDefined(level.doa.var_155f5b81)) {
      level.doa.var_155f5b81 = array::remove_undefined(level.doa.var_155f5b81);
      var_9805ff33 = var_9805ff33 | (level.doa.var_155f5b81.size > 0);
    }
    var_81b4b863 = isDefined(var_9805ff33) && var_9805ff33 || (isDefined(getdvarint("scr_doa_infinite_round", 0)) && getdvarint("scr_doa_infinite_round", 0));
    if(!var_81b4b863 && !level flag::get("doa_round_active")) {
      break;
    }
    wait(0.05);
  }
  while(var_81b4b863);
  while(level.doa.var_3706f843.size > 0) {
    wait(1);
  }
  flag::clear("doa_round_spawning");
}

function private function_da304666(wave_number, round_number) {
  wave = spawnStruct();
  wave.spawn_duration = (1 + (randomfloatrange(0, 1 + (wave_number * 0.3)))) + (randomfloatrange(0, 1 + (round_number * 0.2)));
  wave.spawn_side = doa_utility::function_5b4fbaef();
  wave.time_till_next_group = 1 + (randomfloatrange(0, wave.spawn_duration * 0.6));
  wave.var_3f7b0d81 = int((wave.spawn_duration / getdvarfloat("scr_doa_spawn_delay", 0.35)) * 0.35);
  wave.var_4ccd4ad7 = wave.spawn_duration - wave.time_till_next_group;
  wave.var_601f5749 = wave_number;
  return wave;
}

function function_703bb8b2(round_number) {
  level.doa.spawn_sequence = [];
  max = level.doa.rules.var_57cac10a + (level.doa.var_da96f13c * level.doa.rules.var_57cac10a);
  waves = 6 + (int(round_number * 1.2));
  if(waves > max) {
    waves = max;
  }
  if(isDefined(level.doa.var_d0cde02c) && isDefined(level.doa.var_d0cde02c.var_474e643b)) {
    waves = level.doa.var_d0cde02c.var_474e643b;
  }
  level.doa.var_677d1262 = gettime();
  for(i = 0; i < waves; i++) {
    level.doa.spawn_sequence[i] = function_da304666(i, round_number);
    level.doa.var_677d1262 = level.doa.var_677d1262 + (int(level.doa.spawn_sequence[i].var_4ccd4ad7 * 1000));
  }
  level.doa.var_677d1262 = level.doa.var_677d1262 + (level.doa.var_677d1262 >> 2);
}

function private function_d9345c74() {
  foreach(player in getplayers()) {
    if(isDefined(player.doa) && player.doa.var_e1956fd2 > 0) {
      player globallogic_score::incpersstat("score", player.doa.var_e1956fd2, 1, 1);
      self.doa.var_e1956fd2 = 0;
    }
  }
  level thread doa_pickups::function_c1869ec8();
  level thread doa_utility::clearallcorpses();
  level.doa.var_e0d67a74 = [];
  if(isDefined(level.doa.dev_level_skipped)) {
    if(level.doa.round_number > level.doa.dev_level_skipped) {
      level.doa.dev_level_skipped = undefined;
      setdvar("", "");
    }
  }
  if(isDefined(level.doa.teleporter)) {
    if(isDefined(level.doa.teleporter.trigger)) {
      level.doa.teleporter.trigger delete();
    }
    level.doa.teleporter delete();
  }
  if(isDefined(level.doa.var_d0cde02c)) {
    if(!(isDefined(level.doa.var_d0cde02c.var_79c72134) && level.doa.var_d0cde02c.var_79c72134)) {
      if(isDefined(level.doa.var_d0cde02c.var_bb9ff15b)) {
        count = 0;
        foreach(def in level.doa.var_f5e35752) {
          if(def.number == level.doa.var_d0cde02c.number) {
            count++;
          }
        }
        if(count < level.doa.var_d0cde02c.var_bb9ff15b) {
          level.doa.var_f5e35752[level.doa.var_f5e35752.size] = level.doa.var_d0cde02c;
        }
      } else {
        level.doa.var_f5e35752[level.doa.var_f5e35752.size] = level.doa.var_d0cde02c;
      }
    }
    if(isDefined(level.doa.var_d0cde02c.endfunc)) {
      level thread[[level.doa.var_d0cde02c.endfunc]](level.doa.var_d0cde02c);
    }
  }
  level.doa.var_d0cde02c = undefined;
  level.doa.var_9a1cbf58 = 1;
  level flag::clear("doa_round_abort");
  level notify("exit_taken");
}