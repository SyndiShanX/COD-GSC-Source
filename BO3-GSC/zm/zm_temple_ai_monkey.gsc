/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_ai_monkey.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_ai_monkey;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_shrink_ray;
#using_animtree("critter");
#namespace zm_temple_ai_monkey;

function autoexec function_dafa313c() {
  clientfield::register("scriptmover", "monkey_ragdoll", 21000, 1, "int");
  initmonkeybehaviorsandasm();
}

function private initmonkeybehaviorsandasm() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("templeMonkeyTargetService", &templemonkeytargetservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("templeMonkeyDeathStart", &templemonkeydeathstart);
}

function private templemonkeytargetservice(entity) {
  return true;
}

function private templemonkeydeathstart(entity) {
  if(isDefined(entity.powerup_to_grab)) {
    entity.powerup_to_grab.claimed = 0;
    level notify("powerup_dropped", entity.powerup_to_grab);
  }
}

function init() {
  precache_ambient_monkey_anims();
  level._effect["monkey_death"] = "maps/zombie/fx_zmb_monkey_death";
  level._effect["monkey_spawn"] = "maps/zombie/fx_zombie_ape_spawn_dust";
  level._effect["monkey_eye_glow"] = "maps/zombie/fx_zmb_monkey_eyes";
  level._effect["monkey_gib"] = "maps/zombie_temple/fx_ztem_zombie_mini_squish";
  level._effect["monkey_gib_no_gore"] = "dlc5/temple/fx_ztem_monkey_shrink";
  level._effect["monkey_launch"] = "weapon/fx_trail_rpg";
  level.monkey_zombie_spawners = getEntArray("monkey_zombie_spawner", "targetname");
  level.nextmonkeystealround = 1;
  level.monkey_zombie_health = level.zombie_vars["zombie_health_start"];
  level.stealer_monkey_spawns = struct::get_array("stealer_monkey_spawn", "targetname");
  level.stealer_monkey_exits = struct::get_array("stealer_monkey_exit", "targetname");
  cheat = getdvarint("");
  if(cheat) {
    level.nextmonkeystealround = 1;
  }
  level thread _setup_zone_info();
  level thread _watch_for_powerups();
  monkey_ambient_init();
  level thread monkey_grenade_watcher_temple();
}

function monkey_grenade_watcher_temple() {
  level flag::wait_till("initial_players_connected");
  level thread zm_ai_monkey::monkey_grenade_watcher();
}

function monkey_templethink(spawner) {
  self thread _monkey_templethinkinternal(spawner);
}

function monkey_getmonkeyspawnlocation(mindist, checkvisible, skipstartarea) {
  visitedzones = [];
  needtovisit = [];
  startzone = self _ent_getzonename();
  needtovisit[0] = startzone;
  zonecounter = 0;
  while(needtovisit.size > 0) {
    zonecounter++;
    visitname = needtovisit[0];
    zone = level.zones[visitname];
    if(isDefined(zone.barriers) && (!skipstartarea || startzone != visitname)) {
      barriers = array_randomize_knuth(zone.barriers);
      for(i = 0; i < barriers.size; i++) {
        text = (("Zone: " + zonecounter) + " Barrier: ") + i;
        if(barriers[i] barrier_test(zone, self, mindist, checkvisible)) {
          location = getbarrierattacklocation(barriers[i]);
          return location;
        }
      }
    }
    visitedzones[visitedzones.size] = visitname;
    arrayremoveindex(needtovisit, 0);
    azkeys = getarraykeys(zone.adjacent_zones);
    azkeys = array_randomize_knuth(azkeys);
    for(i = 0; i < azkeys.size; i++) {
      name = azkeys[i];
      if(!isinarray(visitedzones, name)) {
        adjzone = zone.adjacent_zones[name];
        globalzone = level.zones[name];
        if(adjzone.is_connected && globalzone.is_enabled) {
          needtovisit[needtovisit.size] = name;
        }
      }
    }
  }
  return undefined;
}

function barrier_test(zone, ent, mindist, checkvisible) {
  if(!zone.is_active) {
    return true;
  }
  mindist2 = mindist * mindist;
  disttobarrier = distancesquared(ent.origin, self.origin);
  if(disttobarrier < mindist2) {
    return false;
  }
  if(checkvisible) {
    playervisdist = 1800;
    playervisdist2 = playervisdist * playervisdist;
    players = getplayers();
    for(i = 0; i < players.size; i++) {
      player = players[i];
      disttoplayer2 = distancesquared(player.origin, self.origin);
      if(disttoplayer2 < playervisdist2) {
        if(self player_can_see_me(player)) {
          return false;
        }
      }
    }
  }
  return true;
}

function ent_gathervalidbarriers(zoneoverride, ignoreoccupied, ignorevisible) {
  valid_barriers = [];
  monkeyzone = zoneoverride;
  if(!isDefined(monkeyzone)) {
    monkeyzone = self _ent_getzonename();
  }
  if(isDefined(monkeyzone)) {
    s = spawnStruct();
    zonenames = _getconnectedzonenames(monkeyzone, s);
    players = getplayers();
    for(i = 0; i < zonenames.size; i++) {
      name = zonenames[i];
      zone = level.zones[name];
      if(isDefined(ignoreoccupied) && ignoreoccupied && zone.is_occupied) {
        continue;
      }
      barriers = [];
      if(isDefined(ignorevisible) && ignorevisible) {
        barriers = _get_non_visible_barriers(zone.barriers);
      } else if(isDefined(zone.barriers)) {
        barriers = zone.barriers;
      }
      if(barriers.size > 0) {
        valid_barriers = arraycombine(valid_barriers, barriers, 0, 0);
      }
    }
  }
  return valid_barriers;
}

function printtext(text, red) {
  level endon("stopprints");
  if(!isDefined(level.printoffsets)) {
    level.printoffsets = [];
  }
  originstr = ((((("(" + self.origin[0]) + ",") + self.origin[1]) + ",") + self.origin[2]) + ")";
  if(!isDefined(level.printoffsets[originstr])) {
    level.printoffsets[originstr] = (0, 0, 0);
  } else {
    level.printoffsets[originstr] = level.printoffsets[originstr] + vectorscale((0, 0, 1), 20);
  }
  offset = vectorscale((0, 0, 1), 45) + level.printoffsets[originstr];
  color = (0, 1, 0);
  if(isDefined(red) && red) {
    color = (1, 0, 0);
  }
  while(true) {
    print3d(self.origin + offset, text, color, 0.85);
    wait(0.05);
  }
}

function printtextstop() {
  level notify("stopprints");
  level.printoffsets = [];
}

function _get_non_visible_barriers(barriers) {
  returnbarriers = [];
  if(isDefined(barriers)) {
    players = getplayers();
    for(i = 0; i < barriers.size; i++) {
      cansee = 0;
      for(j = 0; j < players.size; j++) {
        if((abs(barriers[i].origin[2] - players[j].origin[2])) < 200) {
          if(barriers[i] player_can_see_me(players[j])) {
            cansee = 1;
            break;
          }
        }
      }
      if(!cansee) {
        returnbarriers[returnbarriers.size] = barriers[i];
      }
    }
  }
  return returnbarriers;
}

function player_can_see_me(player) {
  playerangles = player getplayerangles();
  playerforwardvec = anglesToForward(playerangles);
  playerunitforwardvec = vectornormalize(playerforwardvec);
  banzaipos = self.origin;
  playerpos = player geteyeapprox();
  playertobanzaivec = banzaipos - playerpos;
  playertobanzaiunitvec = vectornormalize(playertobanzaivec);
  forwarddotbanzai = vectordot(playerunitforwardvec, playertobanzaiunitvec);
  anglefromcenter = acos(forwarddotbanzai);
  playerfov = getdvarfloat("cg_fov");
  banzaivsplayerfovbuffer = getdvarfloat("g_banzai_player_fov_buffer");
  if(banzaivsplayerfovbuffer <= 0) {
    banzaivsplayerfovbuffer = 0.2;
  }
  playercanseeme = anglefromcenter <= (playerfov * 0.5) * (1 - banzaivsplayerfovbuffer);
  return playercanseeme;
}

function function_16882cf8(loc, color) {
  while(true) {
    circle(loc, 16, color, 0, 1, 800);
    wait(0.05);
  }
}

function getbarrierattacklocation(barrier) {
  forward = anglesToForward(barrier.angles);
  attack_location = barrier.origin + (forward * 80);
  attack_location = getclosestpointonnavmesh(attack_location, 200);
  return attack_location;
}

function _ent_getzone() {
  zonename = self _ent_getzonename();
  if(isDefined(zonename)) {
    return level.zones[zonename];
  }
  return undefined;
}

function _ent_getzonename() {
  zkeys = getarraykeys(level.zones);
  for(z = 0; z < zkeys.size; z++) {
    zonename = zkeys[z];
    zone = level.zones[zonename];
    for(v = 0; v < zone.volumes.size; v++) {
      touching = self istouching(zone.volumes[v]);
      if(touching) {
        return zonename;
      }
    }
  }
  return undefined;
}

function _setup_zone_info() {
  wait(1);
  checkent = spawn("script_origin", (0, 0, 0));
  for(i = 0; i < level.exterior_goals.size; i++) {
    goal = level.exterior_goals[i];
    forward = anglesToForward(goal.angles);
    checkent.origin = goal.origin + (forward * 100);
    zonename = checkent _ent_getzonename();
    valid = isDefined(zonename) && isDefined(level.zones[zonename]);
    if(!valid) {
      iprintln("" + checkent.origin);
      continue;
    }
    goal.zonename = zonename;
    zone = level.zones[zonename];
    if(!isDefined(zone.barriers)) {
      zone.barriers = [];
    }
    zone.barriers[zone.barriers.size] = goal;
  }
  checkent delete();
}

function _monkey_templethinkinternal(spawner) {
  self endon("death");
  spawner.count = 100;
  spawner.last_spawn_time = gettime();
  playFX(level._effect["monkey_death"], self.origin);
  playsoundatposition("zmb_bolt", self.origin);
  self.deathfunction = &_monkey_zombietempledeathcallback;
  self.spawnzone = spawner.script_noteworthy;
  self.shrink_ray_fling = &_monkey_templefling;
  self thread monkey_zombie_choose_sprint_temple();
  self thread _monkey_gotoboards();
}

function monkey_zombie_choose_run_temple(moveplaybackrate) {
  self.zombie_move_speed = "run";
  self zombie_utility::set_zombie_run_cycle("run");
}

function monkey_zombie_choose_sprint_temple(moveplaybackrate) {
  self.zombie_move_speed = "sprint";
  self zombie_utility::set_zombie_run_cycle("sprint");
}

function _monkey_zombietempledeathcallback(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self zombie_utility::reset_attack_spot();
  self.grenadeammo = 0;
  self thread zombie_utility::zombie_eye_glow_stop();
  playFX(level._effect["monkey_death"], self.origin);
  if(isDefined(self.attacker) && isPlayer(self.attacker)) {
    self.attacker zm_audio::create_and_play_dialog("kill", "thief");
  }
  if(self.damagemod == "MOD_BURNED") {
    self thread zombie_death::flame_death_fx();
  }
  return false;
}

function _monkey_gotoboards() {
  self endon("death");
  self endon("shrink");
  barriers = level.zones[self.spawnzone].barriers;
  if(!isDefined(barriers)) {
    barriers = [];
  }
  barriers = _sort_by_num_boards(barriers);
  for(i = 0; i < barriers.size; i++) {
    barrier = barriers[i];
    location = getbarrierattacklocation(barrier);
    self.goalradius = 32;
    self setgoalpos(location);
    self waittill("goal");
    self setgoalpos(self.origin);
    while(true) {
      chunk = _find_chunk(barrier.barrier_chunks);
      if(!isDefined(chunk)) {
        break;
      }
      self _monkey_destroyboards(barrier, chunk, location);
    }
  }
  self _monkey_remove();
}

function _find_chunk(barrier_chunks) {
  assert(isDefined(barrier_chunks), "");
  for(i = 0; i < barrier_chunks.size; i++) {
    if(barrier_chunks[i] zm_utility::get_chunk_state() == "repaired") {
      return barrier_chunks[i];
    }
  }
  return undefined;
}

function _monkey_destroyboards(barrier, chunk, location) {
  chunk zm_blockers::update_states("target_by_zombie");
  self teleport(location, self.angles);
  time = self getanimlengthfromasd("zm_attack_perks_front", 0);
  self thread zm_ai_monkey::play_attack_impacts(time);
  zombie_shared::donotetracks("attack_perks_front");
  playFX(level._effect["wood_chunk_destory"], chunk.origin);
  if(chunk.script_noteworthy == "4" || chunk.script_noteworthy == "6") {
    chunk thread zm_spawner::zombie_boardtear_offset_fx_horizontle(chunk, barrier);
  } else {
    chunk thread zm_spawner::zombie_boardtear_offset_fx_verticle(chunk, barrier);
  }
  level thread zm_blockers::remove_chunk(chunk, barrier, 1, self);
  chunk zm_blockers::update_states("destroyed");
  chunk notify("destroyed");
  wait(time);
}

function _sort_by_num_boards(barriers) {
  return barriers;
}

function _watch_for_powerups() {
  if(!isDefined(level.monkey_zombie_spawners) || level.monkey_zombie_spawners.size == 0) {
    return;
  }
  while(true) {
    level waittill("powerup_dropped", powerup);
    if(!isDefined(powerup)) {
      continue;
    }
    if(level.round_number < level.nextmonkeystealround) {
      continue;
    }
    wait(randomfloatrange(0, 1));
    if(_cangrabpowerup(powerup)) {
      _grab_powerup(powerup);
    }
  }
}

function _cangrabpowerup(powerup) {
  return isDefined(powerup) && (!isDefined(powerup.claimed) || !powerup.claimed);
}

function _grab_powerup(powerup) {
  spawner = level.monkey_zombie_spawners[0];
  monkey = zombie_utility::spawn_zombie(spawner);
  if(!isDefined(monkey)) {
    return;
  }
  level.nextmonkeystealround = 1;
  cheat = getdvarint("");
  if(cheat) {
    level.nextmonkeystealround = 1;
  }
  monkey.ignore_enemy_count = 1;
  monkey.meleedamage = 10;
  monkey.custom_damage_func = &monkey_temple_custom_damage;
  location = monkey _monkey_getspawnlocation(powerup);
  monkey forceteleport(location, monkey.angles);
  monkey.deathfunction = &_monkey_zombietempleescapedeathcallback;
  monkey.shrink_ray_fling = &_monkey_templefling;
  monkey.zombie_sliding = &_monkey_templesliding;
  monkey.no_shrink = 0;
  monkey.ignore_solo_last_stand = 1;
  spawner.count = 100;
  spawner.last_spawn_time = gettime();
  monkey thread monkey_zombie_choose_sprint_temple();
  monkey.powerup_to_grab = powerup;
  monkey thread _monkey_zombie_grenade_watcher();
  monkey thread _monkey_checkplayablearea();
  monkey thread _monkey_timeout();
  monkey thread _monkey_stealpowerup();
  monkey.zombie_think_done = 1;
}

function _monkey_play_stolen_loop() {
  self endon("death");
  self endon("powerup_dropped");
  while(true) {
    playsoundatposition("zmb_stealer_stolen", self.origin);
    wait(0.845);
  }
}

function _monkey_getspawnlocation(var_93eb638b) {
  var_9199584e = self monkey_getmonkeyspawnlocation(700, 0, 1);
  if(!isDefined(var_9199584e)) {
    var_9199584e = self monkey_getmonkeyspawnlocation(700, 1, 0);
  }
  if(!isDefined(var_9199584e)) {
    var_9199584e = self monkey_getmonkeyspawnlocation(0, 0, 0);
  }
  if(!isDefined(var_9199584e) && isDefined(var_93eb638b)) {
    var_9199584e = getbarrierattacklocation(var_93eb638b);
  }
  return var_9199584e;
}

function _monkey_stealpowerup() {
  self endon("death");
  self endon("end_monkey_steal");
  self _monkey_grabpowerup();
  if(!isDefined(self.powerup) && (!(isDefined(self.attack_player) && self.attack_player))) {
    self monkey_attack_player();
  }
  self thread _monkey_pathcheck();
  self _monkey_escape();
}

function _monkey_pathcheck() {
  self notify("end_pathcheck");
  self endon("end_pathcheck");
  self endon("escape_goal");
  self endon("death");
  self waittill("bad_path");
  self notify("end_monkey_steal");
  self.melee_count = 0;
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(zombie_utility::is_player_valid(players[i])) {
      self.player_stole_power_up = players[i];
    }
  }
  self monkey_attack_player();
  self thread _monkey_stealpowerup();
}

function _monkey_grabpowerup() {
  if(isDefined(self.powerup_to_grab)) {
    self.goalradius = 16;
    powerup_pos = getclosestpointonnavmesh(self.powerup_to_grab.origin, 200);
    self setgoalpos(powerup_pos);
    self _monkey_grap_powerup_wait();
  }
  if(_cangrabpowerup(self.powerup_to_grab)) {
    self monkey_zombie_choose_run_temple();
    self.powerup_to_grab show();
    self _monkey_bindpowerup(self.powerup_to_grab);
    self.powerup = self.powerup_to_grab;
    self.powerup_to_grab = undefined;
    if(isDefined(self.powerup.grab_count)) {
      self.powerup.grab_count++;
    } else {
      self.powerup.grab_count = 1;
    }
    self.powerup thread powerup_red(self);
    self.powerup thread _powerup_randomize(self);
    self thread _monkey_play_stolen_loop();
    self.powerup.stolen = 1;
    self.powerup notify("powerup_grabbed");
    self thread player_random_response_to_theft();
  }
}

function player_random_response_to_theft() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    if(distancesquared(self.origin, players[i].origin) <= 250000) {
      players[i] thread zm_audio::create_and_play_dialog("general", "thief_steal");
      return;
    }
  }
}

function _monkey_grap_powerup_wait() {
  self endon("goal");
  self.powerup_to_grab waittill("death");
  self.player_stole_power_up = self.powerup_to_grab.power_up_grab_player;
}

function powerup_red(monkey) {
  monkey endon("death");
  self.fx_red = zm_net::network_safe_spawn("monkey_red_powerup", 2, "script_model", self.origin);
  self.fx_red setModel("tag_origin");
  self.fx_red linkto(self);
  playFXOnTag(level._effect["powerup_on_red"], self.fx_red, "tag_origin");
  self clientfield::set("powerup_fx", 3);
}

function _monkey_escape() {
  self endon("death");
  self endon("end_monkey_steal");
  self notify("stop_find_flesh");
  self.escaping = 1;
  self _monkey_add_time();
  location = (0, 0, 0);
  angles = (0, 0, 0);
  playexitanim = 0;
  if(level.stealer_monkey_exits.size > 0) {
    playexitanim = 1;
    randstruct = array::random(level.stealer_monkey_exits);
    location = randstruct.origin;
    angles = randstruct.angles;
  } else {
    valid_escapes = self ent_gathervalidbarriers();
    maxdist = 0;
    bestbarrier = undefined;
    for(i = 0; i < valid_escapes.size; i++) {
      dist2 = distancesquared(self.origin, valid_escapes[i].origin);
      if(dist2 > maxdist) {
        maxdist = dist2;
        bestbarrier = valid_escapes[i];
      }
    }
    location = getbarrierattacklocation(bestbarrier);
  }
  self.goalradius = 8;
  location = getclosestpointonnavmesh(location, 200);
  self setgoalpos(location);
  self waittill("goal");
  self notify("escape_goal");
  if(playexitanim) {
    if(!isDefined(angles)) {
      angles = (0, 0, 0);
    }
    escape_anim = "rtrg_ai_zm_dlc5_monkey_pap_escape";
    time = getanimlength(escape_anim);
    self animscripted("escape_anim", self.origin, self.angles, escape_anim);
    wait(time);
  }
  haspowerup = isDefined(self.powerup);
  if(haspowerup) {
    level notify("monkey_powerup_escape");
  }
  level thread escape_monkey_counter(haspowerup);
  self _monkey_remove();
}

function escape_monkey_counter(haspowerup) {
  if(!isDefined(level.monkey_escape_count)) {
    level.monkey_escape_count = 0;
    level.monkey_escape_with_powerup_count = 0;
  }
  level.monkey_escape_count++;
  if(haspowerup) {
    level.monkey_escape_with_powerup_count++;
  }
  if((level.monkey_escape_with_powerup_count % 5) == 0) {
    level thread launch_monkey();
  }
}

function launch_monkey() {
  effectent = spawn("script_model", (-24, 1448, 1000));
  if(isDefined(effectent)) {
    effectent endon("death");
    effectent setModel("tag_origin");
    effectent.angles = vectorscale((1, 0, 0), 90);
    playFXOnTag(level._effect["monkey_launch"], effectent, "tag_origin");
    launchtime = 6;
    effectent moveto(effectent.origin + vectorscale((0, 0, 1), 2500), launchtime, 3);
    wait(launchtime);
    effectent delete();
  }
}

function _monkey_checkplayablearea() {
  self endon("death");
  candamage = 1;
  areas = getEntArray("player_volume", "script_noteworthy");
  while(true) {
    inarea = 0;
    for(i = 0; i < areas.size && !inarea; i++) {
      inarea = self istouching(areas[i]);
    }
    if(candamage && !inarea) {
      println("");
      candamage = 0;
      self util::magic_bullet_shield();
    } else if(!candamage && inarea) {
      println("");
      candamage = 1;
      self util::stop_magic_bullet_shield();
    }
    wait(0.2);
  }
}

function _monkey_timeout() {
  self endon("death");
  if(!isDefined(self.endtime)) {
    self.endtime = gettime() + 60000;
  }
  while(self.endtime > gettime()) {
    wait(0.5);
  }
  self _monkey_remove();
}

function _monkey_add_time() {
  self.endtime = gettime() + 60000;
}

function _monkey_zombietempleescapedeathcallback(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self.grenadeammo = 0;
  playsoundatposition("zmb_stealer_death", self.origin);
  self thread zombie_utility::zombie_eye_glow_stop();
  if(isDefined(self.attacker) && isPlayer(self.attacker)) {
    self.attacker zm_audio::create_and_play_dialog("kill", "thief");
    isfavoriteenemy = isDefined(self.favoriteenemy) && self.favoriteenemy == self.attacker;
    nomeleehits = !isDefined(self.melee_count) || self.melee_count == 0;
    if(isDefined(self.attacking_player) && self.attacking_player && nomeleehits && isfavoriteenemy) {
      self.attacker zm_score::player_add_points("thundergun_fling", 500, (0, 0, 0), 0);
    }
  }
  if(isDefined(self.attacker) && isPlayer(self.attacker)) {
    self.attacker zm_score::player_add_points("damage");
  }
  if(isDefined(self.powerup)) {
    self _monkey_dropstolenpowerup();
  }
  if("rottweil72_upgraded_zm" == self.damageweapon.name && "MOD_RIFLE_BULLET" == self.damagemod) {
    self thread _monkey_temple_dragons_breath_flame_death_fx();
  }
  if(isDefined(self.do_gib_death) && self.do_gib_death) {
    self thread _monkey_gib();
    self util::delay(0.05, undefined, &zm_utility::self_delete);
  }
  return false;
}

function _monkey_temple_dragons_breath_flame_death_fx() {
  if(self.isdog) {
    return;
  }
  if(!isDefined(level._effect) || !isDefined(level._effect["character_fire_death_sm"])) {
    println("");
    return;
  }
  playFXOnTag(level._effect["character_fire_death_sm"], self, "J_SpineLower");
  tagarray = [];
  if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "left_arm") {
    tagarray[tagarray.size] = "J_Elbow_LE";
    tagarray[tagarray.size] = "J_Wrist_LE";
  }
  if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "right_arm") {
    tagarray[tagarray.size] = "J_Elbow_RI";
    tagarray[tagarray.size] = "J_Wrist_RI";
  }
  if(!isDefined(self.a.gib_ref) || (self.a.gib_ref != "no_legs" && self.a.gib_ref != "left_leg")) {
    tagarray[tagarray.size] = "J_Knee_LE";
    tagarray[tagarray.size] = "J_Ankle_LE";
  }
  if(!isDefined(self.a.gib_ref) || (self.a.gib_ref != "no_legs" && self.a.gib_ref != "right_leg")) {
    tagarray[tagarray.size] = "J_Knee_RI";
    tagarray[tagarray.size] = "J_Ankle_RI";
  }
  tagarray = array::randomize(tagarray);
  playFXOnTag(level._effect["character_fire_death_sm"], self, tagarray[0]);
}

function _monkey_dropstolenpowerup() {
  returnpowerup = self.powerup;
  if(isDefined(self.powerup)) {
    self notify("powerup_dropped");
    self.powerup notify("stop_randomize");
    if(isDefined(self.powerup.fx_red)) {
      self.powerup.fx_red util::delay(0.1, undefined, &zm_utility::self_delete);
      self.powerup.fx_red = undefined;
    }
    self.powerup.claimed = 0;
    level notify("powerup_dropped", self.powerup);
    origin = self.origin;
    if(isDefined(self.is_traversing) && self.is_traversing) {
      origin = zm_utility::groundpos(self.origin + vectorscale((0, 0, 1), 10));
    }
    origin = origin + vectorscale((0, 0, 1), 40);
    self.powerup unlink();
    self.powerup.origin = origin;
    self.powerup thread zm_powerups::powerup_timeout();
    self.powerup thread zm_powerups::powerup_wobble();
    self.powerup thread zm_powerups::powerup_grab();
    self.powerup = undefined;
  }
  return returnpowerup;
}

function _monkey_remove(playfx) {
  self notify("remove");
  if(!isDefined(playfx)) {
    playfx = 1;
  }
  if(isDefined(self.powerup)) {
    if(isDefined(self.powerup.fx_red)) {
      self.powerup.fx_red delete();
      self.powerup.fx_red = undefined;
    }
    self.powerup zm_powerups::powerup_delete();
  }
  self thread zombie_utility::zombie_eye_glow_stop();
  self delete();
}

function _getconnectedzonenames(zonename, params) {
  if(!isDefined(params.tested)) {
    params.tested = [];
  }
  ret = [];
  if(!isDefined(params.tested[zonename])) {
    ret[0] = zonename;
    params.tested[zonename] = 1;
    zone = level.zones[zonename];
    azkeys = getarraykeys(zone.adjacent_zones);
    for(i = 0; i < azkeys.size; i++) {
      name = azkeys[i];
      adjzone = zone.adjacent_zones[name];
      globalzone = level.zones[name];
      if(adjzone.is_connected && globalzone.is_enabled) {
        zonenames = _getconnectedzonenames(name, params);
        ret = arraycombine(ret, zonenames, 0, 0);
      }
    }
  }
  return ret;
}

function _powerup_randomize(monkey) {
  self endon("stop_randomize");
  monkey endon("remove");
  powerup_cycle = array("carpenter", "fire_sale", "nuke", "double_points", "insta_kill");
  powerup_cycle = array_randomize_knuth(powerup_cycle);
  powerup_cycle[powerup_cycle.size] = "full_ammo";
  if(level.chest_moves < 1) {
    arrayremovevalue(powerup_cycle, "fire_sale");
  }
  if(level.round_number <= 1) {
    arrayremovevalue(powerup_cycle, "nuke");
  }
  currentpowerup = undefined;
  keys = getarraykeys(level.zombie_powerups);
  for(i = 0; i < keys.size; i++) {
    if(level.zombie_powerups[keys[i]].model_name == self.model) {
      currentpowerup = keys[i];
      break;
    }
  }
  if(isDefined(currentpowerup)) {
    arrayremovevalue(powerup_cycle, currentpowerup);
    arrayinsert(powerup_cycle, currentpowerup, 0);
  }
  if(currentpowerup == "full_ammo" && self.grab_count == 1) {
    index = randomintrange(1, powerup_cycle.size - 1);
    arrayinsert(powerup_cycle, "free_perk", index);
  }
  wait(1);
  index = 1;
  while(true) {
    powerupname = powerup_cycle[index];
    index++;
    if(index >= powerup_cycle.size) {
      index = 0;
    }
    self zm_powerups::powerup_setup(powerupname, undefined, undefined, undefined, 0);
    self playSound("zmb_temple_powerup_switch");
    monkey _monkey_bindpowerup(self);
    if(powerupname == "free_perk") {
      wait(0.25);
    } else {
      wait(1);
    }
  }
}

function array_randomize_knuth(array) {
  n = array.size;
  while(n > 0) {
    index = randomint(n);
    n = n - 1;
    temp = array[index];
    array[index] = array[n];
    array[n] = temp;
  }
  return array;
}

function _monkey_bindpowerup(powerup) {
  powerup unlink();
  powerup.angles = self.angles;
  powerup.origin = self.origin;
  offset = vectorscale((0, 0, 1), 40);
  angles = (0, 0, 0);
  powerup linkto(self, "tag_origin", offset, angles);
}

function _monkey_gib() {
  playFX(level._effect["monkey_gib_no_gore"], self.origin);
  self ghost();
}

function _monkey_templefling(player) {
  self.do_gib_death = 1;
  self dodamage(self.health + 666, self.origin, player);
}

function _monkey_templesliding(slide_node) {
  self endon("death");
  level endon("intermission");
  if(isDefined(self.sliding) && self.sliding) {
    return;
  }
  self notify("end_monkey_steal");
  self.is_traversing = 1;
  self notify("zombie_start_traverse");
  self.sliding = 1;
  self.ignoreall = 1;
  self thread set_monkey_slide_anim();
  self setgoalnode(slide_node);
  check_dist_squared = 3600;
  while(distancesquared(self.origin, slide_node.origin) > check_dist_squared) {
    wait(0.01);
  }
  self thread monkey_zombie_choose_sprint_temple();
  self notify("water_slide_exit");
  self.sliding = 0;
  self.is_traversing = 0;
  self notify("zombie_end_traverse");
  self thread _monkey_stealpowerup();
}

function set_monkey_slide_anim() {
  self zombie_utility::set_zombie_run_cycle("sprint_slide");
}

function precache_ambient_monkey_anims() {}

function monkey_ambient_init() {
  level flag::init("monkey_ambient_excited");
  monkey_ambient_level_set_next_sound();
  level.ambient_monkey_locations = struct::get_array("monkey_ambient", "targetname");
  level thread monkey_crowd_noise();
  level thread monkey_ambient_drops_add_array();
  level thread manage_ambient_monkeys(4);
}

function monkey_crowd_noise() {
  origin1 = getent("evt_monkey_crowd01_origin", "targetname");
  origin2 = getent("evt_monkey_crowd02_origin", "targetname");
  if(!isDefined(origin1) || !isDefined(origin2)) {
    return;
  }
  while(true) {
    level flag::wait_till("monkey_ambient_excited");
    origin1 playLoopSound("evt_monkey_crowd01", 2);
    origin2 playLoopSound("evt_monkey_crowd02", 2);
    while(level flag::get("monkey_ambient_excited")) {
      wait(0.1);
    }
    origin1 stoploopsound(3);
    origin2 stoploopsound(3);
  }
}

function manage_ambient_monkeys(max_monkeys) {
  checkzone = "temple_start_zone";
  level.active_monkeys = [];
  playerinzone = 0;
  hacktofixstart = 1;
  while(true) {
    if(!hacktofixstart) {
      util::wait_network_frame();
    }
    if(zone_is_active(checkzone) || hacktofixstart) {
      if(level.active_monkeys.size == 0 && !playerinzone) {
        level.ambient_monkey_locations = array_randomize_knuth(level.ambient_monkey_locations);
        if(level.ambient_monkey_locations.size > 0) {
          for(i = 0; i < max_monkeys; i++) {
            level.ambient_monkey_locations[i] monkey_ambient_spawn();
            if(!hacktofixstart) {
              util::wait_network_frame();
            }
            util::wait_network_frame();
          }
        }
      }
      if(hacktofixstart) {
        while(!zone_is_active(checkzone)) {
          wait(0.1);
        }
      }
      hacktofixstart = 0;
      playerinzone = 1;
    } else {
      playerinzone = 0;
      array::remove_undefined(level.active_monkeys);
    }
  }
}

function zone_is_active(zone_name) {
  if(!isDefined(level.zones) || !isDefined(level.zones[zone_name]) || !level.zones[zone_name].is_active) {
    return false;
  }
  return true;
}

function monkey_ambient_spawn() {
  self.monkey = util::spawn_model("c_zom_dlchd_shangrila_monkey", self.origin, self.angles);
  self.monkey.animname = "monkey";
  self.monkey setCanDamage(1);
  self.monkey.v_starting_origin = self.origin;
  self.monkey.var_2e8d47d3 = self.angles;
  self.health = 9999;
  zm_weap_shrink_ray::add_shrinkable_object(self.monkey);
  self.monkey.location = self;
  self.monkey.anim_spot = util::spawn_model("tag_origin", self.origin, self.angles);
  if(!isDefined(level.active_monkeys)) {
    level.active_monkeys = [];
  } else if(!isarray(level.active_monkeys)) {
    level.active_monkeys = array(level.active_monkeys);
  }
  level.active_monkeys[level.active_monkeys.size] = self.monkey;
  self.monkey monkey_ambient_set_next_sound();
  self.monkey thread monkey_ambient_noise();
  self.monkey thread monkey_ambient_watch_for_power_up();
  self.monkey thread monkey_ambient_wait_to_be_shot();
  self.monkey thread monkey_ambient_idle();
  self.monkey thread monkey_ambient_shrink();
  self.monkey clientfield::set("monkey_ragdoll", 1);
}

function monkey_ambient_idle() {
  self endon("monkey_killed");
  self endon("monkey_cleanup");
  level flag::wait_till("zm_temple_connected");
  self.anim_spot notify("monkey_stop_loop");
  self useanimtree($critter);
  self animation::stop(0.2);
  self animation::play("rtrg_ai_zm_dlc5_monkey_calm_idle_loop_03", self.v_starting_origin, self.var_2e8d47d3);
}

function monkey_ambient_wait_to_be_shot() {
  self endon("monkey_cleanup");
  self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags);
  self.alive = 0;
  self notify("monkey_killed");
  playsoundatposition("zmb_stealer_death", self.origin);
  self animation::stop();
  self startragdoll();
}

function monkey_ambient_wait_for_remove() {
  self endon("monkey_cleanup");
  self endon("monkey_killed");
  wait(10);
}

function monkey_ambient_drops_add_array() {
  self endon("monkey_cleanup");
  self endon("monkey_killed");
  while(true) {
    level waittill("powerup_dropped", powerup);
    level flag::set("monkey_ambient_excited");
    do {
      wait(0.3);
      level.monkey_drops = zm_powerups::get_powerups();
      level.monkey_drops = array::remove_undefined(level.monkey_drops);
    }
    while(level.monkey_drops.size != 0);
    level flag::clear("monkey_ambient_excited");
  }
}

function monkey_ambient_watch_for_power_up() {
  self endon("monkey_killed");
  self endon("monkey_cleanup");
  if(!isDefined(self.var_188503aa)) {
    self.var_188503aa = [];
    if(!isDefined(self.var_188503aa)) {
      self.var_188503aa = [];
    } else if(!isarray(self.var_188503aa)) {
      self.var_188503aa = array(self.var_188503aa);
    }
    self.var_188503aa[self.var_188503aa.size] = "rtrg_ai_zm_dlc5_monkey_freaked_01";
    if(!isDefined(self.var_188503aa)) {
      self.var_188503aa = [];
    } else if(!isarray(self.var_188503aa)) {
      self.var_188503aa = array(self.var_188503aa);
    }
    self.var_188503aa[self.var_188503aa.size] = "rtrg_ai_zm_dlc5_monkey_freaked_01a";
    if(!isDefined(self.var_188503aa)) {
      self.var_188503aa = [];
    } else if(!isarray(self.var_188503aa)) {
      self.var_188503aa = array(self.var_188503aa);
    }
    self.var_188503aa[self.var_188503aa.size] = "rtrg_ai_zm_dlc5_monkey_freaked_01b";
    if(!isDefined(self.var_188503aa)) {
      self.var_188503aa = [];
    } else if(!isarray(self.var_188503aa)) {
      self.var_188503aa = array(self.var_188503aa);
    }
    self.var_188503aa[self.var_188503aa.size] = "rtrg_ai_zm_dlc5_monkey_freaked_01c";
  }
  while(true) {
    self.var_188503aa = array::randomize(self.var_188503aa);
    level flag::wait_till("monkey_ambient_excited");
    wait(randomfloatrange(0, 1));
    self.excited = 1;
    self thread monkey_ambient_excited_noise();
    self.anim_spot notify("monkey_stop_loop");
    n_index = 0;
    while(true) {
      self animation::stop(0.2);
      self animation::play(self.var_188503aa[n_index], self.v_starting_origin, self.var_2e8d47d3);
      if(!level flag::get("monkey_ambient_excited")) {
        break;
      }
      if(n_index < (self.var_188503aa.size - 2)) {
        n_index++;
      } else {
        n_index = 0;
      }
    }
    self.excited = 0;
    self thread monkey_ambient_idle();
  }
}

function monkey_ambient_level_set_next_sound() {
  level.ambient_monkey_next_sound_time = gettime() + (randomfloatrange(3, 6) * 1000);
}

function monkey_ambient_set_next_sound() {
  self.next_sound_time = gettime() + (randomfloatrange(6, 12) * 1000);
}

function monkey_ambient_can_make_sound() {
  if(gettime() < level.ambient_monkey_next_sound_time) {
    return false;
  }
  if(gettime() < self.next_sound_time) {
    return false;
  }
  return true;
}

function monkey_ambient_noise() {
  self endon("monkey_killed");
  self endon("monkey_cleanup");
  while(true) {
    if(self monkey_ambient_can_make_sound()) {
      self thread monkey_ambient_play_sound("zmb_stealer_ambient");
      self monkey_ambient_set_next_sound();
      monkey_ambient_level_set_next_sound();
    }
    wait(0.1);
  }
}

function monkey_ambient_excited_noise() {
  self endon("monkey_killed");
  self endon("monkey_cleanup");
  while(self.excited) {
    self thread monkey_ambient_play_sound("zmb_stealer_excited");
    wait(randomfloatrange(1.5, 3));
  }
}

function monkey_ambient_play_sound(soundname) {
  while(isDefined(level.monkey_ambient_sound_choke) && level.monkey_ambient_sound_choke) {
    util::wait_network_frame();
  }
  level.monkey_ambient_sound_choke = 1;
  self playSound(soundname);
  util::wait_network_frame();
  level.monkey_ambient_sound_choke = 0;
}

function monkey_ambient_shrink() {
  waitstr = self util::waittill_any_return("shrunk", "death", "monkey_killed", "monkey_cleanup");
  zm_weap_shrink_ray::remove_shrinkable_object(self);
  if(waitstr == "shrunk") {
    self thread _monkey_gib();
  }
}

function monkey_ambient_gib_all() {
  for(i = level.active_monkeys.size - 1; i >= 0; i--) {
    monkey = level.active_monkeys[i];
    monkey thread _monkey_gib();
  }
}

function _monkey_zombie_grenade_watcher() {
  self endon("death");
  grenade_respond_dist_sq = 14400;
  while(true) {
    if(isDefined(self.monkey_grenade) && self.monkey_grenade) {
      util::wait_network_frame();
      continue;
    }
    if(isDefined(level.monkey_grenades) && level.monkey_grenades.size > 0) {
      for(i = 0; i < level.monkey_grenades.size; i++) {
        grenade = level.monkey_grenades[i];
        if(!isDefined(grenade) || isDefined(grenade.monkey)) {
          util::wait_network_frame();
          continue;
        }
        if(isDefined(self.powerup)) {
          util::wait_network_frame();
          continue;
        }
        grenade_dist_sq = distancesquared(self.origin, grenade.origin);
        if(grenade_dist_sq <= grenade_respond_dist_sq) {
          grenade.monkey = self;
          self.monkey_grenade = grenade;
          self monkey_zombie_grenade_response();
          break;
        }
      }
    }
    util::wait_network_frame();
  }
}

function monkey_zombie_grenade_response() {
  self endon("death");
  self notify("end_monkey_steal");
  self monkey_zombie_grenade_pickup();
  self thread _monkey_stealpowerup();
}

function monkey_zombie_grenade_pickup() {
  self endon("death");
  pickup_dist_sq = 1024;
  picked_up = 0;
  while(isDefined(self.monkey_grenade)) {
    self setgoalpos(self.monkey_grenade.origin);
    grenade_dist_sq = distancesquared(self.origin, self.monkey_grenade.origin);
    if(grenade_dist_sq <= pickup_dist_sq) {
      self.monkey_thrower = self.monkey_grenade.thrower;
      self.monkey_grenade delete();
      self.monkey_grenade = undefined;
      picked_up = 1;
    }
    util::wait_network_frame();
  }
  if(picked_up) {
    while(true) {
      self setgoalpos(self.monkey_thrower.origin);
      target_dir = self.monkey_thrower.origin - self.origin;
      monkey_dir = anglesToForward(self.angles);
      dot = vectordot(vectornormalize(target_dir), vectornormalize(monkey_dir));
      if(dot >= 0.5) {
        break;
      }
      util::wait_network_frame();
    }
    self thread monkey_zombie_grenade_throw(self.monkey_thrower);
    self waittill("throw_done");
  }
}

function monkey_zombie_grenade_throw_watcher(target, animname) {
  self endon("death");
  self waittillmatch(animname);
  throw_angle = randomintrange(20, 30);
  dir = vectortoangles(target.origin - self.origin);
  dir = (dir[0] - throw_angle, dir[1], dir[2]);
  dir = anglesToForward(dir);
  velocity = dir * 550;
  fuse = randomfloatrange(1, 2);
  hand_pos = self gettagorigin("J_Thumb_RI_1");
  grenade_type = target zm_utility::get_player_lethal_grenade();
  self magicgrenadetype(grenade_type, hand_pos, velocity, fuse);
}

function monkey_zombie_grenade_throw(target) {
  self notify("throw_done");
}

function monkey_attack_player() {
  self endon("death");
  self.attack_player = 1;
  self.attacking_player = 1;
  players = getplayers();
  self.ignore_player = [];
  player = undefined;
  if(isDefined(self.player_stole_power_up) && zombie_utility::is_player_valid(self.player_stole_power_up)) {
    player = self.player_stole_power_up;
  }
  if(isDefined(player)) {
    self.favoriteenemy = player;
    self thread monkey_obvious_vox();
    self _monkey_add_time();
    self thread monkey_pathing();
    self thread monkey_attack_player_wait_wrapper(self.favoriteenemy);
    self waittill("end_monkey_attacks");
  }
}

function monkey_attack_player_wait_wrapper(player) {
  self monkey_attack_player_wait(player);
  self monkey_stop_attck_player();
}

function monkey_attack_player_wait(player) {
  self endon("death");
  self endon("end_monkey_steal");
  attacktimeend = gettime() + 20000;
  while(attacktimeend > gettime()) {
    if(!zombie_utility::is_player_valid(player)) {
      break;
    }
    if(isDefined(self.melee_count) && self.melee_count >= 1) {
      break;
    }
    wait(0.1);
  }
}

function monkey_stop_attck_player() {
  self notify("end_monkey_attacks");
  self.ignoreall = 1;
  if(isalive(self)) {
    self.favoriteenemy = undefined;
    self.attacking_player = 0;
  }
}

function monkey_pathing() {
  self endon("death");
  self endon("end_monkey_attacks");
  self.ignoreall = 0;
  self.meleeattackdist = 64;
  while(isDefined(self.favoriteenemy)) {
    self.goalradius = 32;
    self orientmode("face default");
    self setgoalpos(self.favoriteenemy.origin);
    util::wait_network_frame();
  }
}

function monkey_temple_custom_damage(player) {
  self endon("death");
  damage = self.meleedamage;
  if(!isDefined(self.melee_count)) {
    self.melee_count = 0;
  }
  self.melee_count++;
  if(isDefined(player) && player.score > 0) {
    pointstosteal = int(min(player.score, 50));
    player zm_score::minus_to_player_score(pointstosteal);
  }
  return damage;
}

function monkey_obvious_vox() {
  self endon("death");
  self endon("end_monkey_attacks");
  while(true) {
    self playSound("zmb_stealer_attack");
    wait(randomfloatrange(2, 4));
  }
}