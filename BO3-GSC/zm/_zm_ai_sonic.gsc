/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_ai_sonic.gsc
*************************************************/

#using scripts\shared\ai\systems\animation_state_machine_mocomp;
#using scripts\shared\ai\systems\animation_state_machine_notetracks;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_thundergun;
#namespace zm_ai_sonic;

function autoexec __init__sytem__() {
  system::register("zm_ai_sonic", &__init__, &__main__, undefined);
}

function __init__() {
  init_clientfields();
  _sonic_initfx();
  _sonic_initsounds();
  registerbehaviorscriptfunctions();
}

function __main__() {
  level.soniczombiesenabled = 1;
  level.soniczombieminroundwait = 1;
  level.soniczombiemaxroundwait = 3;
  level.soniczombieroundrequirement = 4;
  level.nextsonicspawnround = level.soniczombieroundrequirement + (randomintrange(0, level.soniczombiemaxroundwait + 1));
  level.sonicplayerdamage = 10;
  level.sonicscreamdamageradius = 300;
  level.sonicscreamattackradius = 240;
  level.sonicscreamattackdebouncemin = 3;
  level.sonicscreamattackdebouncemax = 9;
  level.sonicscreamattacknext = 0;
  level.sonichealthmultiplier = 2.5;
  level.sonic_zombie_spawners = getEntArray("sonic_zombie_spawner", "script_noteworthy");
  zombie_utility::set_zombie_var("thundergun_knockdown_damage", 15);
  level.thundergun_gib_refs = [];
  level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "guts";
  level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "right_arm";
  level.thundergun_gib_refs[level.thundergun_gib_refs.size] = "left_arm";
  array::thread_all(level.sonic_zombie_spawners, &spawner::add_spawn_function, &sonic_zombie_spawn);
  array::thread_all(level.sonic_zombie_spawners, &spawner::add_spawn_function, &zombie_utility::round_spawn_failsafe);
  zm_spawner::register_zombie_damage_callback(&_sonic_damage_callback);
  level thread function_1249f13c();
  println("" + level.nextsonicspawnround);
}

function registerbehaviorscriptfunctions() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("sonicAttackInitialize", &sonicattackinitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("sonicAttackTerminate", &sonicattackterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("sonicCanAttack", &soniccanattack);
  animationstatenetwork::registernotetrackhandlerfunction("sonic_fire", &function_cd107cf);
}

function init_clientfields() {
  clientfield::register("actor", "issonic", 21000, 1, "int");
}

function _sonic_initfx() {
  level._effect["sonic_explosion"] = "dlc5/temple/fx_ztem_sonic_zombie";
  level._effect["sonic_spawn"] = "dlc5/temple/fx_ztem_sonic_zombie_spawn";
  level._effect["sonic_attack"] = "dlc5/temple/fx_ztem_sonic_zombie_attack";
}

function function_8b9e6756() {
  return level.sonic_zombie_spawners;
}

function function_1ebbce9b() {
  return level.zm_loc_types["napalm_location"];
}

function function_1249f13c() {
  level waittill("start_of_round");
  while(true) {
    if(function_89ce0aca()) {
      spawner_list = function_8b9e6756();
      location_list = function_1ebbce9b();
      spawner = array::random(spawner_list);
      location = array::random(location_list);
      ai = zombie_utility::spawn_zombie(spawner, spawner.targetname, location);
      if(isDefined(ai)) {
        ai.spawn_point_override = location;
      }
    }
    wait(3);
  }
}

function function_56fe13df() {
  self endon("death");
  spot = self.spawn_point_override;
  self.spawn_point = spot;
  if(isDefined(spot.target)) {
    self.target = spot.target;
  }
  if(isDefined(spot.zone_name)) {
    self.zone_name = spot.zone_name;
  }
  if(isDefined(spot.script_parameters)) {
    self.script_parameters = spot.script_parameters;
  }
  self thread zm_spawner::do_zombie_rise(spot);
  playsoundatposition("evt_sonic_spawn", self.origin);
  thread function_332b9adf();
}

function function_332b9adf() {
  wait(3);
  players = getplayers();
  players[randomintrange(0, players.size)] thread zm_audio::create_and_play_dialog("general", "sonic_spawn");
}

function _sonic_initsounds() {
  level.zmb_vox["sonic_zombie"] = [];
  level.zmb_vox["sonic_zombie"]["ambient"] = "sonic_ambient";
  level.zmb_vox["sonic_zombie"]["sprint"] = "sonic_ambient";
  level.zmb_vox["sonic_zombie"]["attack"] = "sonic_attack";
  level.zmb_vox["sonic_zombie"]["teardown"] = "sonic_attack";
  level.zmb_vox["sonic_zombie"]["taunt"] = "sonic_ambient";
  level.zmb_vox["sonic_zombie"]["behind"] = "sonic_ambient";
  level.zmb_vox["sonic_zombie"]["death"] = "sonic_explode";
  level.zmb_vox["sonic_zombie"]["crawler"] = "sonic_ambient";
  level.zmb_vox["sonic_zombie"]["scream"] = "sonic_scream";
}

function _entity_in_zone(zone) {
  for(i = 0; i < zone.volumes.size; i++) {
    if(self istouching(zone.volumes[i])) {
      return true;
    }
  }
  return false;
}

function function_89ce0aca() {
  if(!isDefined(level.soniczombiesenabled) || level.soniczombiesenabled == 0 || level.sonic_zombie_spawners.size == 0) {
    return 0;
  }
  if(isDefined(level.soniczombiecount) && level.soniczombiecount > 0) {
    return 0;
  }
  if(getdvarint("") != 0) {
    return 1;
  }
  if(level.nextsonicspawnround > level.round_number) {
    return 0;
  }
  if(level.var_57ecc1a3 >= level.round_number) {
    return 0;
  }
  if(level.zombie_total == 0) {
    return 0;
  }
  return level.zombie_total < level.zombiesleftbeforesonicspawn;
}

function sonic_zombie_spawn(animname_set) {
  self.custom_location = &function_56fe13df;
  zm_spawner::zombie_spawn_init(animname_set);
  level.var_57ecc1a3 = level.round_number;
  println("");
  setDvar("", 0);
  self.animname = "sonic_zombie";
  self clientfield::set("issonic", 1);
  self.maxhealth = int(self.maxhealth * level.sonichealthmultiplier);
  self.health = self.maxhealth;
  self.ignore_enemy_count = 1;
  self.sonicscreamattackdebouncemin = 6;
  self.sonicscreamattackdebouncemax = 10;
  self.death_knockdown_range = 480;
  self.death_gib_range = 360;
  self.death_fling_range = 240;
  self.death_scream_range = 480;
  self _updatenextscreamtime();
  self.deathfunction = &sonic_zombie_death;
  self._zombie_shrink_callback = &_sonic_shrink;
  self._zombie_unshrink_callback = &_sonic_unshrink;
  self.monkey_bolt_taunts = &sonic_monkey_bolt_taunts;
  self thread _zombie_runeffects();
  self thread _zombie_initsidestep();
  self thread _zombie_death_watch();
  self thread sonic_zombie_count_watch();
  self.zombie_move_speed = "walk";
  self.zombie_arms_position = "up";
  self.variant_type = randomint(3);
}

function _zombie_initsidestep() {
  self.zombie_can_sidestep = 1;
}

function _zombie_death_watch() {
  self waittill("death");
  self clientfield::set("issonic", 0);
}

function _zombie_ambient_sounds() {
  self endon("death");
  while(true) {}
}

function _updatenextscreamtime() {
  self.sonicscreamattacknext = gettime();
  self.sonicscreamattacknext = self.sonicscreamattacknext + (randomintrange(self.sonicscreamattackdebouncemin * 1000, self.sonicscreamattackdebouncemax * 1000));
}

function _canscreamnow() {
  if(gettime() > self.sonicscreamattacknext) {
    return true;
  }
  return false;
}

function private soniccanattack(entity) {
  if(entity.animname !== "sonic_zombie") {
    return false;
  }
  if(!isDefined(entity.favoriteenemy) || !isPlayer(entity.favoriteenemy)) {
    return false;
  }
  hashead = !(isDefined(entity.head_gibbed) && entity.head_gibbed);
  notmini = !(isDefined(entity.shrinked) && entity.shrinked);
  screamtime = level _canscreamnow() && entity _canscreamnow();
  if(screamtime && !entity.ignoreall && (!(isDefined(entity.is_traversing) && entity.is_traversing)) && hashead && notmini) {
    blurplayers = entity _zombie_any_players_in_blur_area();
    if(blurplayers) {
      return true;
    }
  }
  return false;
}

function private sonicattackinitialize(entity, asmstatename) {
  level _updatenextscreamtime();
  entity _updatenextscreamtime();
}

function private function_cd107cf(entity) {
  if(entity.animname !== "sonic_zombie") {
    return;
  }
  entity _zombie_screamattack();
}

function private sonicattackterminate(entity, asmstatename) {
  entity _zombie_scream_attack_done();
}

function _zombie_screamattack() {
  self playSound("zmb_vocals_sonic_scream");
  self thread _zombie_playscreamfx();
  players = getplayers();
  array::thread_all(players, &_player_screamattackwatch, self);
}

function _zombie_scream_attack_done() {
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] notify("scream_watch_done");
  }
  self notify("scream_attack_done");
}

function _zombie_playscreamfx() {
  if(isDefined(self.screamfx)) {
    self.screamfx delete();
  }
  tag = "tag_eye";
  origin = self gettagorigin(tag);
  self.screamfx = spawn("script_model", origin);
  self.screamfx setModel("tag_origin");
  self.screamfx.angles = self gettagangles(tag);
  self.screamfx linkto(self, tag);
  playFXOnTag(level._effect["sonic_attack"], self.screamfx, "tag_origin");
  self util::waittill_any("death", "scream_attack_done", "shrink");
  self.screamfx delete();
}

function _player_screamattackwatch(sonic_zombie) {
  self endon("death");
  self endon("scream_watch_done");
  sonic_zombie endon("death");
  self.screamattackblur = 0;
  while(true) {
    if(self _player_in_blur_area(sonic_zombie)) {
      break;
    }
    wait(0.1);
  }
  self thread _player_sonicblurvision(sonic_zombie);
  self thread zm_audio::create_and_play_dialog("general", "sonic_hit");
}

function _player_in_blur_area(sonic_zombie) {
  if((abs(self.origin[2] - sonic_zombie.origin[2])) > 70) {
    return false;
  }
  radiussqr = level.sonicscreamdamageradius * level.sonicscreamdamageradius;
  if(distance2dsquared(self.origin, sonic_zombie.origin) > radiussqr) {
    return false;
  }
  dirtoplayer = self.origin - sonic_zombie.origin;
  dirtoplayer = vectornormalize(dirtoplayer);
  sonicdir = anglesToForward(sonic_zombie.angles);
  dot = vectordot(dirtoplayer, sonicdir);
  if(dot < 0.4) {
    return false;
  }
  return true;
}

function _zombie_any_players_in_blur_area() {
  if(isDefined(level.intermission) && level.intermission) {
    return false;
  }
  players = level.players;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(zombie_utility::is_player_valid(player) && player _player_in_blur_area(self)) {
      return true;
    }
  }
  return false;
}

function _player_sonicblurvision(zombie) {
  self endon("disconnect");
  level endon("intermission");
  if(!self.screamattackblur) {
    mini = isDefined(zombie) && (isDefined(zombie.shrinked) && zombie.shrinked);
    self.screamattackblur = 1;
    if(mini) {
      self _player_screamattackdamage(1, 2, 0.2, "damage_light", zombie);
    } else {
      self _player_screamattackdamage(4, 5, 0.2, "damage_heavy", zombie);
    }
    self.screamattackblur = 0;
  }
}

function _player_screamattackdamage(time, blurscale, earthquakescale, rumble, attacker) {
  self thread _player_blurfailsafe();
  earthquake(earthquakescale, 3, attacker.origin, level.sonicscreamdamageradius, self);
  visionset_mgr::activate("overlay", "zm_ai_screecher_blur", self);
  self playrumbleonentity(rumble);
  self _player_screamattack_wait(time);
  visionset_mgr::deactivate("overlay", "zm_ai_screecher_blur", self);
  self notify("blur_cleared");
  self stoprumble(rumble);
}

function _player_blurfailsafe() {
  self endon("disconnect");
  self endon("blur_cleared");
  level waittill("intermission");
  visionset_mgr::deactivate("overlay", "zm_ai_screecher_blur", self);
}

function _player_screamattack_wait(time) {
  self endon("disconnect");
  level endon("intermission");
  wait(time);
}

function _player_soniczombiedeath_doublevision() {}

function _zombie_runeffects() {}

function _zombie_setupfxonjoint(jointname, fxname) {
  origin = self gettagorigin(jointname);
  effectent = spawn("script_model", origin);
  effectent setModel("tag_origin");
  effectent.angles = self gettagangles(jointname);
  effectent linkto(self, jointname);
  playFXOnTag(level._effect[fxname], effectent, "tag_origin");
  return effectent;
}

function _zombie_getnearbyplayers() {
  nearbyplayers = [];
  radiussqr = level.sonicscreamattackradius * level.sonicscreamattackradius;
  players = level.players;
  for(i = 0; i < players.size; i++) {
    if(!zombie_utility::is_player_valid(players[i])) {
      continue;
    }
    playerorigin = players[i].origin;
    if((abs(playerorigin[2] - self.origin[2])) > 70) {
      continue;
    }
    if(distance2dsquared(playerorigin, self.origin) > radiussqr) {
      continue;
    }
    nearbyplayers[nearbyplayers.size] = players[i];
  }
  return nearbyplayers;
}

function sonic_zombie_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self playSound("evt_sonic_explode");
  if(isDefined(level._effect["sonic_explosion"])) {
    playFXOnTag(level._effect["sonic_explosion"], self, "J_SpineLower");
  }
  if(isDefined(self.attacker) && isPlayer(self.attacker)) {
    self.attacker thread zm_audio::create_and_play_dialog("kill", "sonic");
  }
  self thread _sonic_zombie_death_scream(self.attacker);
  _sonic_zombie_death_explode(self.attacker);
  return self zm_spawner::zombie_death_animscript();
}

function zombie_sonic_scream_death(attacker) {
  self endon("death");
  randomwait = randomfloatrange(0, 1);
  wait(randomwait);
  self.no_powerups = 1;
  self zombie_utility::zombie_eye_glow_stop();
  self playSound("evt_zombies_head_explode");
  self zombie_utility::zombie_head_gib();
  self dodamage(self.health + 666, self.origin, attacker);
}

function _sonic_zombie_death_scream(attacker) {
  zombies = _sonic_zombie_get_enemies_in_scream_range();
  for(i = 0; i < zombies.size; i++) {
    if(!isDefined(zombies[i])) {
      continue;
    }
    if(zm_utility::is_magic_bullet_shield_enabled(zombies[i])) {
      continue;
    }
    if(self.animname == "monkey_zombie") {
      continue;
    }
    zombies[i] thread zombie_sonic_scream_death(attacker);
  }
}

function _sonic_zombie_death_explode(attacker) {
  physicsexplosioncylinder(self.origin, 600, 240, 1);
  if(!isDefined(level.soniczombie_knockdown_enemies)) {
    level.soniczombie_knockdown_enemies = [];
    level.soniczombie_knockdown_gib = [];
    level.soniczombie_fling_enemies = [];
    level.soniczombie_fling_vecs = [];
  }
  self _sonic_zombie_get_enemies_in_range();
  level.sonic_zombie_network_choke_count = 0;
  for(i = 0; i < level.soniczombie_fling_enemies.size; i++) {
    level.soniczombie_fling_enemies[i] thread _soniczombie_fling_zombie(attacker, level.soniczombie_fling_vecs[i], i);
  }
  for(i = 0; i < level.soniczombie_knockdown_enemies.size; i++) {
    level.soniczombie_knockdown_enemies[i] thread _soniczombie_knockdown_zombie(attacker, level.soniczombie_knockdown_gib[i]);
  }
  level.soniczombie_knockdown_enemies = [];
  level.soniczombie_knockdown_gib = [];
  level.soniczombie_fling_enemies = [];
  level.soniczombie_fling_vecs = [];
}

function _sonic_zombie_network_choke() {
  level.sonic_zombie_network_choke_count++;
  if(!level.sonic_zombie_network_choke_count % 10) {
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
  }
}

function _sonic_zombie_get_enemies_in_scream_range() {
  return_zombies = [];
  center = self getcentroid();
  zombies = array::get_all_closest(center, getaispeciesarray("axis", "all"), undefined, undefined, self.death_scream_range);
  if(isDefined(zombies)) {
    for(i = 0; i < zombies.size; i++) {
      if(!isDefined(zombies[i]) || !isalive(zombies[i])) {
        continue;
      }
      test_origin = zombies[i] getcentroid();
      if(!bullettracepassed(center, test_origin, 0, undefined)) {
        continue;
      }
      return_zombies[return_zombies.size] = zombies[i];
    }
  }
  return return_zombies;
}

function _sonic_zombie_get_enemies_in_range() {
  center = self getcentroid();
  zombies = array::get_all_closest(center, getaispeciesarray("axis", "all"), undefined, undefined, self.death_knockdown_range);
  if(!isDefined(zombies)) {
    return;
  }
  knockdown_range_squared = self.death_knockdown_range * self.death_knockdown_range;
  gib_range_squared = self.death_gib_range * self.death_gib_range;
  fling_range_squared = self.death_fling_range * self.death_fling_range;
  for(i = 0; i < zombies.size; i++) {
    if(!isDefined(zombies[i]) || !isalive(zombies[i])) {
      continue;
    }
    test_origin = zombies[i] getcentroid();
    test_range_squared = distancesquared(center, test_origin);
    if(test_range_squared > knockdown_range_squared) {
      return;
    }
    if(!bullettracepassed(center, test_origin, 0, undefined)) {
      continue;
    }
    if(test_range_squared < fling_range_squared) {
      level.soniczombie_fling_enemies[level.soniczombie_fling_enemies.size] = zombies[i];
      dist_mult = (fling_range_squared - test_range_squared) / fling_range_squared;
      fling_vec = vectornormalize(test_origin - center);
      fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
      fling_vec = vectorscale(fling_vec, 100 + (100 * dist_mult));
      level.soniczombie_fling_vecs[level.soniczombie_fling_vecs.size] = fling_vec;
      continue;
    }
    if(test_range_squared < gib_range_squared) {
      level.soniczombie_knockdown_enemies[level.soniczombie_knockdown_enemies.size] = zombies[i];
      level.soniczombie_knockdown_gib[level.soniczombie_knockdown_gib.size] = 1;
      continue;
    }
    level.soniczombie_knockdown_enemies[level.soniczombie_knockdown_enemies.size] = zombies[i];
    level.soniczombie_knockdown_gib[level.soniczombie_knockdown_gib.size] = 0;
  }
}

function _soniczombie_fling_zombie(player, fling_vec, index) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self dodamage(self.health + 666, player.origin, player);
  if(self.health <= 0) {
    points = 10;
    if(!index) {
      points = zm_score::get_zombie_death_player_points();
    } else if(1 == index) {
      points = 30;
    }
    player zm_score::player_add_points("thundergun_fling", points);
    self startragdoll();
    self launchragdoll(fling_vec);
  }
}

function _soniczombie_knockdown_zombie(player, gib) {
  self endon("death");
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.thundergun_knockdown_func)) {
    self.lander_knockdown = 1;
    self[[self.thundergun_knockdown_func]](player, gib);
  } else {
    if(gib) {
      self.a.gib_ref = array::random(level.thundergun_gib_refs);
      self thread zombie_death::do_gib();
    }
    self.thundergun_handle_pain_notetracks = &zm_weap_thundergun::handle_thundergun_pain_notetracks;
    self dodamage(20, player.origin, player);
  }
}

function _sonic_shrink() {}

function _sonic_unshrink() {}

function sonic_zombie_count_watch() {
  if(!isDefined(level.soniczombiecount)) {
    level.soniczombiecount = 0;
  }
  level.soniczombiecount++;
  self waittill("death");
  level.soniczombiecount--;
  if(isDefined(self.shrinked) && self.shrinked) {
    level.nextsonicspawnround = level.round_number + 1;
  } else {
    level.nextsonicspawnround = level.round_number + (randomintrange(level.soniczombieminroundwait, level.soniczombiemaxroundwait + 1));
  }
  println("" + level.nextsonicspawnround);
  attacker = self.attacker;
  if(isDefined(attacker) && isPlayer(attacker) && (isDefined(attacker.screamattackblur) && attacker.screamattackblur)) {
    attacker notify("blinded_by_the_fright_achieved");
  }
}

function _sonic_damage_callback(str_mod, str_hit_location, v_hit_origin, e_player, n_amount, w_weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
  if(isDefined(self.lander_knockdown) && self.lander_knockdown) {
    return false;
  }
  if(self.classname == "actor_spawner_zm_temple_sonic") {
    if(!isDefined(self.damagecount)) {
      self.damagecount = 0;
    }
    if((self.damagecount % (int(getplayers().size * level.sonichealthmultiplier))) == 0) {
      e_player zm_score::player_add_points("thundergun_fling", 10, str_hit_location, self.isdog);
    }
    self.damagecount++;
    self thread zm_powerups::check_for_instakill(e_player, str_mod, str_hit_location);
    return true;
  }
  return false;
}

function sonic_monkey_bolt_taunts(monkey_bolt) {
  return isDefined(self.in_the_ground) && self.in_the_ground;
}