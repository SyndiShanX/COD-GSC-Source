/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_theater_quad.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie_quad;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_quad;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_zonemgr;
#namespace zm_theater_quad;

function autoexec init() {
  function_66da4eb0();
}

function private function_66da4eb0() {
  behaviortreenetworkutility::registerbehaviortreeaction("traverseWallCrawlAction", & traversewallcrawlaction, & function_7d285db1, undefined);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldWallTraverse", & shouldwalltraverse);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldWallCrawl", & shouldwallcrawl);
  behaviortreenetworkutility::registerbehaviortreescriptapi("traverseWallIntro", & traversewallintro);
  behaviortreenetworkutility::registerbehaviortreescriptapi("traverseWallJumpOff", & traversewalljumpoff);
  behaviortreenetworkutility::registerbehaviortreescriptapi("quadCollisionService", & quadcollisionservice);
  animationstatenetwork::registeranimationmocomp("quad_wall_traversal", & function_dd3e35df, undefined, undefined);
  animationstatenetwork::registeranimationmocomp("quad_wall_jump_off", & function_5d8b540c, undefined, & function_18650281);
  animationstatenetwork::registeranimationmocomp("quad_move_strict_traversal", & function_9e9b3f8b, undefined, & function_2433815e);
}

function traversewallcrawlaction(entity, asmstatename) {
  animationstatenetworkutility::requeststate(entity, asmstatename);
  return 5;
}

function function_7d285db1(entity, asmstatename) {
  if(!shouldwallcrawl(entity)) {
    return 4;
  }
  return 5;
}

function shouldwalltraverse(entity) {
  if(isDefined(entity.traversestartnode)) {
    if(issubstr(entity.traversestartnode.animscript, "zm_wall_crawl_drop")) {
      return true;
    }
  }
  return false;
}

function shouldwallcrawl(entity) {
  if(isDefined(self.var_2826ab5d)) {
    if(gettime() >= self.var_2826ab5d) {
      return false;
    }
  }
  return true;
}

function traversewallintro(entity) {
  entity allowpitchangle(0);
  entity.clamptonavmesh = 0;
  if(isDefined(entity.traversestartnode)) {
    entity.var_1bb3c5d0 = entity.traversestartnode;
    entity.var_7531a5e3 = entity.traverseendnode;
    if(entity.traversestartnode.animscript == "zm_wall_crawl_drop") {
      blackboard::setblackboardattribute(self, "_quad_wall_crawl", "quad_wall_crawl_theater");
    } else {
      blackboard::setblackboardattribute(self, "_quad_wall_crawl", "quad_wall_crawl_start");
    }
  }
}

function traversewalljumpoff(entity) {
  self.var_2826ab5d = undefined;
}

function quadcollisionservice(behaviortreeentity) {
  if(isDefined(behaviortreeentity.dontpushtime)) {
    if(gettime() < behaviortreeentity.dontpushtime) {
      return true;
    }
  }
  zombies = getaiteamarray(level.zombie_team);
  foreach(zombie in zombies) {
    if(zombie == behaviortreeentity) {
      continue;
    }
    if(isDefined(zombie.missinglegs) && zombie.missinglegs || (isDefined(zombie.knockdown) && zombie.knockdown)) {
      continue;
    }
    dist_sq = distancesquared(behaviortreeentity.origin, zombie.origin);
    if(dist_sq < 14400) {
      behaviortreeentity pushactors(0);
      behaviortreeentity.dontpushtime = gettime() + 3000;
      zombie thread function_77876867();
      return true;
    }
  }
  behaviortreeentity pushactors(1);
  return false;
}

function function_77876867() {
  self endon("death");
  self setavoidancemask("avoid all");
  wait(3);
  self setavoidancemask("avoid none");
}

function private function_dd3e35df(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  animdist = abs(getmovedelta(mocompanim, 0, 1)[2]);
  self.ground_pos = bulletTrace(self.var_7531a5e3.origin, self.var_7531a5e3.origin + (vectorscale((0, 0, -1), 100000)), 0, self)["position"];
  physdist = abs((self.origin[2] - self.ground_pos[2]) - 60);
  cycles = physdist / animdist;
  time = cycles * getanimlength(mocompanim);
  self.var_2826ab5d = gettime() + (time * 1000);
}

function private function_5d8b540c(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity animmode("noclip", 0);
}

function private function_18650281(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity allowpitchangle(1);
  entity.clamptonavmesh = 1;
}

function private function_9e9b3f8b(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  assert(isDefined(entity.traversestartnode));
  entity.blockingpain = 1;
  entity.usegoalanimweight = 1;
  entity animmode("noclip", 0);
  entity forceteleport(entity.traversestartnode.origin, entity.traversestartnode.angles, 0);
  entity orientmode("face angle", entity.traversestartnode.angles[1]);
}

function private function_2433815e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
  entity finishtraversal();
  entity.usegoalanimweight = 0;
  entity.blockingpain = 0;
}

function init_roofs() {
  level flag::wait_till("curtains_done");
  level thread quad_stage_roof_break();
  level thread quad_lobby_roof_break();
  level thread quad_dining_roof_break();
  level thread function_79dea782();
}

function quad_roof_crumble_fx_play(n_index) {
  play_quad_first_sounds();
  roof_parts = getEntArray(self.target, "targetname");
  if(isDefined(roof_parts)) {
    for(i = 0; i < roof_parts.size; i++) {
      roof_parts[i] delete();
    }
  }
  fx = struct::get(self.target, "targetname");
  if(isDefined(fx)) {
    self function_b7b3e976(n_index);
    thread rumble_all_players("damage_heavy");
  }
  if(isDefined(self.script_noteworthy)) {
    util::clientnotify(self.script_noteworthy);
  }
  if(isDefined(self.script_int)) {
    exploder::exploder(self.script_int);
  }
}

function function_b7b3e976(n_index) {
  switch (n_index) {
    case 0: {
      str_exploder_name = "fxexp_1012";
      break;
    }
    case 1: {
      str_exploder_name = "fxexp_1007";
      break;
    }
    case 2: {
      str_exploder_name = "fxexp_1008";
      break;
    }
    case 3: {
      str_exploder_name = "fxexp_1009";
      break;
    }
    case 4: {
      str_exploder_name = "fxexp_1010";
      break;
    }
    case 5: {
      str_exploder_name = "fxexp_1003";
      break;
    }
    case 6: {
      str_exploder_name = "fxexp_1004";
      break;
    }
    case 7: {
      str_exploder_name = "fxexp_1001";
      break;
    }
    case 8: {
      str_exploder_name = "fxexp_1002";
      break;
    }
    case 10: {
      str_exploder_name = "fxexp_1006";
      break;
    }
    case 12: {
      str_exploder_name = "fxexp_1014";
      break;
    }
    case 15: {
      str_exploder_name = "fxexp_1011";
      break;
    }
  }
  if(isDefined(str_exploder_name)) {
    exploder::exploder(str_exploder_name);
  }
}

function play_quad_first_sounds() {
  location = struct::get(self.target, "targetname");
  self playsoundwithnotify("zmb_vocals_quad_spawn", "sounddone");
  self waittill("sounddone");
  self playSound("zmb_quad_roof_hit");
  thread play_wood_land_sound(location.origin);
}

function play_wood_land_sound(origin) {
  wait(1);
  playsoundatposition("zmb_quad_roof_break_land", origin - vectorscale((0, 0, 1), 150));
}

function rumble_all_players(high_rumble_string, low_rumble_string, rumble_org, high_rumble_range, low_rumble_range) {
  players = level.players;
  for(i = 0; i < players.size; i++) {
    if(isDefined(high_rumble_range) && isDefined(low_rumble_range) && isDefined(rumble_org)) {
      if(distance(players[i].origin, rumble_org) < high_rumble_range) {
        players[i] playrumbleonentity(high_rumble_string);
      } else if(distance(players[i].origin, rumble_org) < low_rumble_range) {
        players[i] playrumbleonentity(low_rumble_string);
      }
      continue;
    }
    players[i] playrumbleonentity(high_rumble_string);
  }
}

function quad_traverse_death_fx() {
  self endon("traverse_anim");
  self waittill("death");
  playFX(level._effect["quad_grnd_dust_spwnr"], self.origin);
}

function begin_quad_introduction(quad_round_name) {
  if(level flag::get("dog_round")) {
    level flag::clear("dog_round");
  }
  if(level.next_dog_round == (level.round_number + 1)) {
    level.next_dog_round++;
  }
  level.zombie_total = 0;
  level.quad_round_name = quad_round_name;
}

function theater_quad_round() {
  level.zombie_health = level.zombie_vars["zombie_health_start"];
  old_round = zm::get_round_number();
  level.zombie_total = 0;
  level.zombie_health = 100 * old_round;
  kill_all_zombies();
  zm::set_round_number(old_round);
}

function spawn_second_wave_quads(second_wave_targetname) {
  second_wave_spawners = [];
  second_wave_spawners = getEntArray(second_wave_targetname, "targetname");
  if(second_wave_spawners.size < 1) {
    assertmsg("");
    return;
  }
  for(i = 0; i < second_wave_spawners.size; i++) {
    ai = zombie_utility::spawn_zombie(second_wave_spawners[i]);
    if(isDefined(ai)) {
      ai thread zombie_utility::round_spawn_failsafe();
      ai thread quad_traverse_death_fx();
    }
    wait(randomintrange(10, 45));
  }
  util::wait_network_frame();
}

function spawn_a_quad_zombie(spawn_array) {
  spawn_point = spawn_array[randomint(spawn_array.size)];
  ai = zombie_utility::spawn_zombie(spawn_point);
  if(isDefined(ai)) {
    ai thread zombie_utility::round_spawn_failsafe();
    ai thread quad_traverse_death_fx();
  }
  wait(level.zombie_vars["zombie_spawn_delay"]);
  util::wait_network_frame();
}

function kill_all_zombies() {
  zombies = getaispeciesarray("axis", "all");
  if(isDefined(zombies)) {
    for(i = 0; i < zombies.size; i++) {
      if(!isDefined(zombies[i])) {
        continue;
      }
      zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
      util::wait_network_frame();
    }
  }
}

function prevent_round_ending() {
  level endon("quad_round_can_end");
  while(true) {
    if(level.zombie_total < 1) {
      level.zombie_total = 1;
    }
    wait(0.5);
  }
}

function intro_quad_spawn() {
  timer = gettime();
  spawned = 0;
  previous_spawn_delay = level.zombie_vars["zombie_spawn_delay"];
  thread prevent_round_ending();
  initial_spawners = [];
  switch (level.quad_round_name) {
    case "initial_round": {
      initial_spawners = getEntArray("initial_first_round_quad_spawner", "targetname");
      break;
    }
    case "theater_round": {
      initial_spawners = getEntArray("initial_theater_round_quad_spawner", "targetname");
      break;
    }
    default: {
      assertmsg("");
      return;
    }
  }
  if(initial_spawners.size < 1) {
    assertmsg("");
    return;
  }
  while(true) {
    if(isDefined(level.delay_spawners)) {
      manage_zombie_spawn_delay(timer);
    }
    level.delay_spawners = 1;
    spawn_a_quad_zombie(initial_spawners);
    wait(0.2);
    spawned++;
    if(spawned > level.quads_per_round) {
      break;
    }
  }
  spawned = 0;
  second_spawners = [];
  switch (level.quad_round_name) {
    case "initial_round": {
      second_spawners = getEntArray("initial_first_round_quad_spawner_second_wave", "targetname");
      break;
    }
    case "theater_round": {
      second_spawners = getEntArray("theater_round_quad_spawner_second_wave", "targetname");
      break;
    }
    default: {
      assertmsg("");
      return;
    }
  }
  if(second_spawners.size < 1) {
    assertmsg("");
    return;
  }
  while(true) {
    manage_zombie_spawn_delay(timer);
    spawn_a_quad_zombie(second_spawners);
    wait(0.2);
    spawned++;
    if(spawned > (level.quads_per_round * 2)) {
      break;
    }
  }
  level.zombie_vars["zombie_spawn_delay"] = previous_spawn_delay;
  level.zombie_health = level.zombie_vars["zombie_health_start"];
  level.zombie_total = 0;
  level.round_spawn_func = & zm::round_spawning;
  level thread[[level.round_spawn_func]]();
  wait(2);
  level notify("quad_round_can_end");
  level.delay_spawners = undefined;
}

function manage_zombie_spawn_delay(start_timer) {
  if((gettime() - start_timer) < 15000) {
    level.zombie_vars["zombie_spawn_delay"] = randomintrange(30, 45);
  } else {
    if((gettime() - start_timer) < 25000) {
      level.zombie_vars["zombie_spawn_delay"] = randomintrange(15, 30);
    } else {
      if((gettime() - start_timer) < 35000) {
        level.zombie_vars["zombie_spawn_delay"] = randomintrange(10, 15);
      } else if((gettime() - start_timer) < 50000) {
        level.zombie_vars["zombie_spawn_delay"] = randomintrange(5, 10);
      }
    }
  }
}

function quad_lobby_roof_break() {
  zone = level.zones["foyer_zone"];
  while(true) {
    if(zone.is_occupied) {
      flag::set("lobby_occupied");
      break;
    }
    util::wait_network_frame();
  }
  quad_stage_roof_break_single(5);
  wait(0.4);
  quad_stage_roof_break_single(6);
  wait(2);
  quad_stage_roof_break_single(7);
  wait(1);
  quad_stage_roof_break_single(8);
}

function quad_dining_roof_break() {
  level endon("hash_e1db2a20");
  zone = level.zones["dining_zone"];
  while(true) {
    if(zone.is_occupied) {
      flag::set("dining_occupied");
      break;
    }
    util::wait_network_frame();
  }
  quad_stage_roof_break_single(9);
  wait(1);
  quad_stage_roof_break_single(10);
}

function quad_stage_roof_break() {
  quad_stage_roof_break_single(1);
  wait(2);
  quad_stage_roof_break_single(3);
  wait(0.33);
  quad_stage_roof_break_single(2);
  wait(1);
  quad_stage_roof_break_single(0);
  wait(0.45);
  quad_stage_roof_break_single(4);
  level thread play_quad_start_vo();
  wait(0.33);
  quad_stage_roof_break_single(15);
  wait(0.4);
  quad_stage_roof_break_single(11);
  wait(0.45);
  quad_stage_roof_break_single(12);
  wait(0.3);
  quad_stage_roof_break_single(13);
  wait(0.35);
  quad_stage_roof_break_single(14);
  zm_ai_quad::function_5af423f4();
}

function quad_stage_roof_break_single(index) {
  trigger = getent("quad_roof_crumble_fx_origin_" + index, "target");
  trigger thread quad_roof_crumble_fx_play(index);
}

function play_quad_start_vo() {
  players = getplayers();
  player = players[randomintrange(0, players.size)];
  player zm_audio::create_and_play_dialog("general", "quad_spawn");
}

function function_79dea782() {
  trigger = getent("quad_roof_crumble_fx_origin_10", "target");
  trigger waittill("trigger", who);
  level notify("hash_e1db2a20");
  roof_parts = getEntArray(trigger.target, "targetname");
  if(isDefined(roof_parts)) {
    for(i = 0; i < roof_parts.size; i++) {
      roof_parts[i] delete();
    }
  }
}