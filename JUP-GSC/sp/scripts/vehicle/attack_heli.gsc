/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\vehicle\attack_heli.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\helicopter_globals;
#using scripts\sp\utility;
#namespace attack_heli;

function preload() {
  precacheitem("turret_attackheli");
  precacheitem("missile_attackheli");
  attack_heli_fx();
  thread init();
}

function attack_heli_fx() {
  if(getdvarint(@ "hash_ad42ca33a427de58") && getDvar(@ "hash_5c129cc6b6f612dc") != "0") {
    level._effect["_attack_heli_spotlight"] = loadfx("vfx/core/vehicles/hunted_spotlight_model");
    return;
  }

  level._effect["_attack_heli_spotlight"] = loadfx("vfx/core/vehicles/spotlight_large");
}

function init() {
  if(isDefined(level.attackheliaiburstsize)) {
    return;
  }

  while(!isDefined(level.gameskill)) {
    wait 0.05;
  }

  if(!isDefined(level.cosine)) {
    level.cosine = [];
  }

  if(!isDefined(level.cosine["25"])) {
    level.cosine["25"] = cos(25);
  }

  if(!isDefined(level.cosine["35"])) {
    level.cosine["35"] = cos(35);
  }

  if(!isDefined(level.attackhelirange)) {
    level.attackhelirange = 3500;
  }

  if(!isDefined(level.attackhelikillsai)) {
    level.attackhelikillsai = 0;
  }

  if(!isDefined(level.attackhelifov)) {
    level.attackhelifov = cos(30);
  }

  level.attackheliaiburstsize = 1;
  level.attackhelimemory = 3;
  level.attackhelitargetreaquire = 6;
  level.attackhelimovetime = 3;

  switch (level.gameskill) {
    case 0:
      level.attackheliplayerbreak = 9;
      level.attackhelitimeout = 1;
      break;
    case 1:
      level.attackheliplayerbreak = 7;
      level.attackhelitimeout = 2;
      break;
    case 2:
      level.attackheliplayerbreak = 5;
      level.attackhelitimeout = 3;
      break;
    case 3:
      level.attackheliplayerbreak = 3;
      level.attackhelitimeout = 5;
      break;
  }
}

function start_attack_heli(stargetname) {
  if(!isDefined(stargetname)) {
    stargetname = "kill_heli";
  }

  eheli = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(stargetname);
  eheli = begin_attack_heli_behavior(eheli);
  return eheli;
}

function begin_attack_heli_behavior(eheli, heli_points) {
  eheli endon("death");
  eheli endon("heli_players_dead");

  if(level.gameskill == 0 || level.gameskill == 1) {
    org = spawn("script_origin", eheli.origin + (0, 0, -20));
    org linkTo(eheli);
    eheli thread delete_on_death(org);
    strength = undefined;

    if(level.gameskill == 0) {
      strength = 2800;
    } else {
      strength = 2200;
    }

    if(!isDefined(eheli.no_attractor)) {
      eheli.attractor = missile_createattractorent(org, strength, 10000, level.player);
    }
  }

  eheli enableaimassist();
  eheli.startingorigin = spawn("script_origin", eheli.origin);
  eheli thread delete_on_death(eheli.startingorigin);

  if(!isDefined(eheli.circling)) {
    eheli.circling = 0;
  }

  eheli.allowshoot = 1;
  eheli.firingmissiles = 0;
  eheli.moving = 1;
  eheli.istakingdamage = 0;
  eheli.heli_lastattacker = undefined;
  eheli thread notify_disable();
  eheli thread notify_enable();
  thread kill_heli_logic(eheli, heli_points);
  eheli.turrettype = undefined;
  eheli heli_default_target_setup();
  eheli thread detect_player_death();

  switch (eheli.vehicletype) {
    case #"hash_7cbaf54a9583848":
    case #"hash_657241a1e3f14ce7":
    case #"hash_70514937441959cb":
    case #"hash_d29d1c641f811715":
      eheli.turrettype = "default";
      break;
    case #"hash_b5fd54495f0348e2":
    case #"hash_beeeed34c5017c21":
    case #"hash_bef1e634c503afb3":
      eheli.turrettype = "default";
      break;
    case #"hash_b55ba82d2cec3b73":
      eheli.turrettype = "default";
      break;
    case #"hash_1a1d956bedda953d":
    case #"hash_8c12ae8d5afba7a6":
      eheli setyawspeed(90, 30, 20);
      eheli setmaxpitchroll(40, 40);
      eheli sethoverparams(100, 20, 5);
      eheli setup_miniguns();
      break;
    default:
      assertmsg("Need to set up this heli type in the _attack_heli.gsc script: " + self.vehicletype);
      break;
  }

  eheli.etarget = eheli.targetdefault;

  if(isDefined(eheli.script_spotlight) && eheli.script_spotlight == 1 && !isDefined(eheli.spotlight)) {
    eheli thread heli_spotlight_on(undefined, 1);
  }

  eheli thread attack_heli_cleanup();
  return eheli;
}

function detect_player_death() {
  foreach(player in level.players) {
    player add_wait(&waittill_msg, "death");
  }

  do_wait_any();
  self notify("heli_players_dead");
}

function heli_default_target_setup() {
  up_offset = undefined;
  forward_offset = undefined;

  switch (self.vehicletype) {
    case #"hash_7cbaf54a9583848":
    case #"hash_657241a1e3f14ce7":
    case #"hash_70514937441959cb":
    case #"hash_d29d1c641f811715":
      forward_offset = 600;
      up_offset = -100;
      break;
    case #"hash_b5fd54495f0348e2":
    case #"hash_beeeed34c5017c21":
    case #"hash_bef1e634c503afb3":
      forward_offset = 600;
      up_offset = -100;
      break;
    case #"hash_b55ba82d2cec3b73":
      forward_offset = 600;
      up_offset = -100;
      break;
    case #"hash_1a1d956bedda953d":
    case #"hash_8c12ae8d5afba7a6":
      forward_offset = 600;
      up_offset = -204;
      break;
    default:
      assertmsg("Need to set up this heli type in the _attack_heli.gsc script: " + self.vehicletype);
      break;
  }

  self.targetdefault = spawn("script_origin", self.origin);
  self.targetdefault.angles = self.angles;
  self.targetdefault.origin = self.origin;
  ent = spawnStruct();
  ent.entity = self.targetdefault;
  ent.forward = forward_offset;
  ent.up = up_offset;
  ent translate_local();
  self.targetdefault linkTo(self);
  self.targetdefault thread heli_default_target_cleanup(self);
}

function get_turrets() {
  if(isDefined(self.turrets)) {
    return self.turrets;
  }

  setup_miniguns();
  return self.turrets;
}

function setup_miniguns() {
  assertex(!isDefined(self.turrets), ".turrets are already defined");
  self.turrettype = "miniguns";
  self.minigunsspinning = 0;
  self.firingguns = 0;

  if(!isDefined(self.mgturret)) {
    return;
  }

  self.turrets = self.mgturret;
  array_thread(self.turrets, &littlebird_turrets_think, self);
}

function heli_default_target_cleanup(eheli) {
  eheli waittill_either("death", "vehicle_crashDone");

  if(isDefined(self)) {
    self delete();
  }
}

function start_circling_heli(heli_targetname, heli_points) {
  if(!isDefined(heli_targetname)) {
    heli_targetname = "kill_heli";
  }

  heli = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(heli_targetname);
  heli.startingorigin = spawn("script_origin", heli.origin);
  heli thread delete_on_death(heli.startingorigin);
  heli.circling = 1;
  heli.allowshoot = 1;
  heli.firingmissiles = 0;
  heli thread notify_disable();
  heli thread notify_enable();
  thread kill_heli_logic(heli, heli_points);
  return heli;
}

function kill_heli_logic(heli, heli_points) {
  if(!isDefined(heli)) {
    heli = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("kill_heli");
    assert(isDefined(heli));
    heli.allowshoot = 1;
    heli.firingmissiles = 0;
    heli thread notify_disable();
    heli thread notify_enable();
  }

  basespeed = undefined;

  if(!isDefined(heli.script_airspeed)) {
    basespeed = 40;
  } else {
    basespeed = heli.script_airspeed;
  }

  if(!isDefined(level.enemy_heli_killed)) {
    level.enemy_heli_killed = 0;
  }

  if(!isDefined(level.commander_speaking)) {
    level.commander_speaking = 0;
  }

  if(!isDefined(level.enemy_heli_attacking)) {
    level.enemy_heli_attacking = 0;
  }

  level.attack_heli_safe_volumes = undefined;
  volumes = getEntArray("attack_heli_safe_volume", "script_noteworthy");

  if(volumes.size > 0) {
    level.attack_heli_safe_volumes = volumes;
  }

  if(!level.enemy_heli_killed) {
    thread dialog_nags_heli(heli);
  }

  if(!isDefined(heli.helicopter_predator_target_shader)) {
    switch (heli.vehicletype) {
      case #"hash_b5fd54495f0348e2":
      case #"hash_beeeed34c5017c21":
      case #"hash_bef1e634c503afb3":
        target_set(heli, (0, 0, -80));
        break;
      case #"hash_7cbaf54a9583848":
      case #"hash_657241a1e3f14ce7":
      case #"hash_70514937441959cb":
      case #"hash_d29d1c641f811715":
        target_set(heli, (0, 0, -96));
        break;
      case #"hash_b55ba82d2cec3b73":
        target_set(heli, (0, 0, -96));
        break;
      case #"hash_1a1d956bedda953d":
      case #"hash_8c12ae8d5afba7a6":
        target_set(heli, (0, 0, -80));
        break;
      default:
        assertmsg("Need to set up this heli type in the _attack_heli.gsc script: " + self.vehicletype);
        break;
    }

    target_setjavelinonly(heli, 1);
  }

  heli thread heli_damage_monitor();
  heli thread heli_death_monitor();
  heli endon("death");
  heli endon("heli_players_dead");
  heli endon("returning_home");
  heli setvehweapon("turret_attackheli");

  if(!isDefined(heli.circling)) {
    heli.circling = 0;
  }

  if(!heli.circling) {
    heli setneargoalnotifydist(100);

    if(!isDefined(heli.dontwaitforpathend)) {
      heli waittill("reached_dynamic_path_end");
    }
  } else {
    heli setneargoalnotifydist(500);
    heli waittill("near_goal");
  }

  heli thread heli_shoot_think();

  if(heli.circling) {
    heli thread heli_circling_think(heli_points, basespeed);
    return;
  }

  heli thread heli_goal_think(basespeed);
}

function heli_circling_think(heli_points, basespeed) {
  if(!isDefined(heli_points)) {
    heli_points = "attack_heli_circle_node";
  }

  points = getEntArray(heli_points, "targetname");

  if(!isDefined(points) || points.size < 1) {
    points = getStructArray(heli_points, "targetname");
  }

  assert(isDefined(points));
  heli = self;
  heli endon("stop_circling");
  heli endon("death");
  heli endon("returning_home");
  heli endon("heli_players_dead");

  for(;;) {
    heli vehicle_setspeed(basespeed, basespeed / 4, basespeed / 4);
    heli setneargoalnotifydist(100);
    player = level.player;
    playerorigin = player.origin;
    heli setlookatent(player);
    player_location = getclosest(playerorigin, points);
    heli_locations = getEntArray(player_location.target, "targetname");

    if(!isDefined(heli_locations) || heli_locations.size < 1) {
      heli_locations = getStructArray(player_location.target, "targetname");
    }

    assert(isDefined(heli_locations));
    goal = heli_locations[randomint(heli_locations.size)];
    heli setvehgoalpos(goal.origin, 1);
    heli waittill("near_goal");

    if(!isDefined(player.is_controlling_uav)) {
      wait 1;
      wait randomfloatrange(0.8, 1.3);
    }
  }
}

function heli_goal_think(basespeed) {
  self endon("death");
  points = getEntArray("kill_heli_spot", "targetname");
  assert(isDefined(points));
  heli = self;
  goal = getclosest(heli.origin, points);
  current_node = goal;
  assert(isDefined(goal));
  heli endon("death");
  heli endon("returning_home");
  heli endon("heli_players_dead");
  var_66a7fbc9d133f2bf = undefined;

  for(;;) {
    wait 0.05;
    heli vehicle_setspeed(basespeed, basespeed / 2, basespeed / 10);
    heli setneargoalnotifydist(100);
    player = level.player;
    playerorigin = player.origin;

    if(goal == current_node && heli.istakingdamage) {
      linked = get_linked_points(heli, goal, points, player, playerorigin);
      goal = getclosest(playerorigin, linked);
    }

    heli setvehgoalpos(goal.origin, 1);
    heli.moving = 1;
    player = level.player;

    if(isDefined(self.etarget) && isDefined(self.etarget.classname) && self.etarget.classname == "script_origin") {
      var_66a7fbc9d133f2bf = player;
    } else if(isDefined(self.etarget)) {
      var_66a7fbc9d133f2bf = self.etarget;
    } else {
      var_66a7fbc9d133f2bf = self.targetdefault;
    }

    heli setlookatent(var_66a7fbc9d133f2bf);
    heli waittill("near_goal");
    heli.moving = 0;

    if(level.gameskill == 0 || level.gameskill == 1) {
      while(player_is_aiming_with_rocket(heli)) {
        wait 0.5;
      }

      wait 3;
    }

    player = level.player;
    playerorigin = player.origin;
    linked = get_linked_points(heli, goal, points, player, playerorigin);
    linked[linked.size] = goal;
    current_node = goal;
    player_location = getclosest(playerorigin, points);
    var_30ba4289875dd691 = getclosest(playerorigin, linked);

    foreach(point in linked) {
      if(player sightconetrace(point.origin, heli) != 1) {
        linked = array_remove(linked, point);
      }
    }

    closest_neighbor = getclosest(playerorigin, linked);

    if(linked.size < 2) {
      goal = var_30ba4289875dd691;
    } else if(closest_neighbor != player_location) {
      goal = closest_neighbor;
    } else {
      excluders = [];
      excluders[0] = closest_neighbor;
      linked = get_array_of_closest(playerorigin, linked, excluders, 2);
      irand = randomint(linked.size);

      if(randomint(100) > 50) {
        goal = linked[irand];
      } else {
        goal = player_location;
      }
    }

    frand = randomfloatrange(level.attackhelimovetime - 0.5, level.attackhelimovetime + 0.5);
    waittill_notify_or_timeout("damage_by_player", frand);
  }
}

function player_is_aiming_with_rocket(eheli) {
  if(!level.player usingantiairweapon()) {
    return false;
  }

  if(!level.player adsButtonPressed()) {
    return false;
  }

  playereye = level.player getEye();

  if(sighttracepassed(playereye, eheli.origin, 0, level.player)) {
    return true;
  }

  return false;
}

function heli_shoot_think() {
  self endon("stop_shooting");
  self endon("death");
  self endon("heli_players_dead");
  thread heli_missiles_think();
  var_13e19e01df44d953 = level.attackhelirange * level.attackhelirange;
  level.attackheligraceperiod = 0;

  while(isDefined(self)) {
    wait randomfloatrange(0.8, 1.3);

    if(!heli_has_target() || !heli_has_player_target()) {
      etarget = heli_get_target_player_only();

      if(isPlayer(etarget)) {
        self.etarget = etarget;
      }
    }

    if(heli_has_player_target()) {
      if(!heli_can_see_target() || level.attackheligraceperiod == 1) {
        etarget = heli_get_target_ai_only();
        self.etarget = etarget;
      }
    }

    if(isDefined(self.heli_lastattacker) && isPlayer(self.heli_lastattacker)) {
      self.etarget = self.heli_lastattacker;
    } else if(!heli_has_target()) {
      etarget = heli_get_target_ai_only();
      self.etarget = etarget;
    }

    if(!heli_has_target()) {
      continue;
    }

    if(self.etarget is_hidden_from_heli(self)) {
      continue;
    }

    if(heli_has_target() && distancesquared(self.etarget.origin, self.origin) > var_13e19e01df44d953) {
      continue;
    }

    if(self.turrettype == "default" && heli_has_player_target()) {
      miss_player(self.etarget);
      wait randomfloatrange(0.8, 1.3);
      miss_player(self.etarget);
      wait randomfloatrange(0.8, 1.3);

      while(can_see_player(self.etarget) && !self.etarget is_hidden_from_heli(self)) {
        fire_guns();
        wait randomfloatrange(2, 4);
      }

      continue;
    }

    if(isPlayer(self.etarget) || isai(self.etarget)) {
      fire_guns();
    }

    if(isPlayer(self.etarget)) {
      thread player_grace_period(self);
    }

    waittill_notify_or_timeout("damage_by_player", level.attackhelitargetreaquire);
  }
}

function player_grace_period(eheli) {
  level notify("player_is_heli_target");
  level endon("player_is_heli_target");
  level.attackheligraceperiod = 1;
  eheli waittill_notify_or_timeout("damage_by_player", level.attackheliplayerbreak);
  level.attackheligraceperiod = 0;
}

function heli_can_see_target() {
  if(!isDefined(self.etarget)) {
    return 0;
  }

  org = self.etarget.origin + (0, 0, 32);

  if(isPlayer(self.etarget)) {
    org = self.etarget getEye();
  }

  tag_flash_loc = self gettagorigin("tag_flash");
  can_sight = sighttracepassed(tag_flash_loc, org, 0, self);
  return can_sight;
}

function heli_has_player_target() {
  if(!isDefined(self.etarget)) {
    return 0;
  }

  if(isPlayer(self.etarget)) {
    return 1;
  }

  return 0;
}

function heli_has_target() {
  if(!isDefined(self.etarget)) {
    return 0;
  }

  if(!isalive(self.etarget)) {
    return 0;
  }

  if(self.etarget == self.targetdefault) {
    return 0;
  }

  return 1;
}

function heli_get_target() {
  etarget = scripts\sp\helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 1, 0, 1, level.attackheliexcluders);

  if(isDefined(etarget) && isPlayer(etarget)) {
    etarget = self.targetdefault;
  }

  if(!isDefined(etarget)) {
    etarget = self.targetdefault;
  }

  return etarget;
}

function heli_get_target_player_only() {
  aexcluders = getaiarray("allies");
  etarget = scripts\sp\helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 0, 0, 0, aexcluders);

  if(!isDefined(etarget)) {
    etarget = self.targetdefault;
  }

  return etarget;
}

function heli_get_target_ai_only() {
  etarget = scripts\sp\helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 1, 0, 1, level.players);

  if(!isDefined(etarget)) {
    etarget = self.targetdefault;
  }

  return etarget;
}

function heli_missiles_think() {
  if(!isDefined(self.script_missiles)) {
    return;
  }

  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_shooting");
  ishots = undefined;
  defaultweapon = "turret_attackheli";
  weaponname = "missile_attackheli";
  var_20b553d85ec7bc57 = undefined;
  var_8f26a943256ed058 = undefined;
  tags = [];

  switch (self.vehicletype) {
    case #"hash_beeeed34c5017c21":
      ishots = 1;
      var_20b553d85ec7bc57 = 1;
      var_8f26a943256ed058 = 0.5;
      tags[0] = "tag_store_L_2_a";
      tags[1] = "tag_store_R_2_a";
      tags[2] = "tag_store_L_2_b";
      tags[3] = "tag_store_R_2_b";
      tags[4] = "tag_store_L_2_c";
      tags[5] = "tag_store_R_2_c";
      tags[6] = "tag_store_L_2_d";
      tags[7] = "tag_store_R_2_d";
      break;
    case #"hash_8c12ae8d5afba7a6":
    case #"hash_b55ba82d2cec3b73":
      ishots = 1;
      var_20b553d85ec7bc57 = 1;
      var_8f26a943256ed058 = 0.5;
      tags[0] = "tag_missile_left";
      tags[1] = "tag_missile_right";
      break;
    default:
      assertmsg("Missiles have not been setup for helicoper model: " + self.vehicletype);
      break;
  }

  nextmissiletag = -1;

  while(true) {
    wait 0.05;
    self waittill("fire_missiles", other);

    if(!isPlayer(other)) {
      continue;
    }

    player = other;

    if(!player_is_good_missile_target(player)) {
      continue;
    }

    for(i = 0; i < ishots; i++) {
      nextmissiletag++;

      if(nextmissiletag >= tags.size) {
        nextmissiletag = 0;
      }

      self setvehweapon(weaponname);
      self.firingmissiles = 1;
      emissile = self fireweapon(tags[nextmissiletag], player);
      emissile thread missilelosetarget(var_8f26a943256ed058);
      emissile thread missile_earthquake();

      if(i < ishots - 1) {
        wait var_20b553d85ec7bc57;
      }
    }

    self.firingmissiles = 0;
    self setvehweapon(defaultweapon);
    wait 10;
  }
}

function player_is_good_missile_target(player) {
  if(self.moving) {
    return 0;
  }

  return 1;
}

function missile_earthquake() {
  if(distancesquared(self.origin, level.player.origin) > 9000000) {
    return;
  }

  org = self.origin;

  while(isDefined(self)) {
    org = self.origin;
    wait 0.1;
  }

  earthquake(0.7, 1.5, org, 1600);
}

function missilelosetarget(fdelay) {
  self endon("death");
  self endon("heli_players_dead");
  wait fdelay;

  if(isDefined(self)) {
    self missile_cleartarget();
  }
}

function get_different_player(player) {
  for(i = 0; i < level.players.size; i++) {
    if(player != level.players[i]) {
      return level.players[i];
    }
  }

  return level.players[0];
}

function notify_disable() {
  self notify("notify_disable_thread");
  self endon("notify_disable_thread");
  self endon("death");
  self endon("heli_players_dead");

  for(;;) {
    self waittill("disable_turret");
    self.allowshoot = 0;
  }
}

function notify_enable() {
  self notify("notify_enable_thread");
  self endon("notify_enable_thread");
  self endon("death");
  self endon("heli_players_dead");

  for(;;) {
    self waittill("enable_turret");
    self.allowshoot = 1;
  }
}

function fire_guns() {
  switch (self.turrettype) {
    case #"hash_7038dec66d8275be":
      burstsize = randomintrange(5, 10);
      firetime = weaponfiretime("turret_attackheli");
      turret_default_fire(self.etarget, burstsize, firetime);
      break;
    case #"hash_5eb3a214d0fb4f01":
      burstsize = getburstsize(self.etarget);

      if(self.allowshoot && !self.firingmissiles) {
        turret_minigun_fire(self.etarget, burstsize);
      }

      break;
    default:
      assertmsg("Gun firing logic has not been set up in the _attack_heli.gsc script for helicopter type: " + self.turrettype);
      break;
  }
}

function getburstsize(etarget) {
  burstsize = undefined;

  if(!isPlayer(etarget)) {
    burstsize = level.attackheliaiburstsize;
    return burstsize;
  }

  switch (level.gameskill) {
    case 0:
    case 1:
    case 2:
    case 3:
      burstsize = randomintrange(2, 3);
      break;
  }

  return burstsize;
}

function fire_missiles(fdelay) {
  self endon("death");
  self endon("heli_players_dead");
  wait fdelay;

  if(!isPlayer(self.etarget)) {
    return;
  }

  self notify("fire_missiles", self.etarget);
}

function turret_default_fire(etarget, burstsize, firetime) {
  thread fire_missiles(randomfloatrange(0.2, 2));

  for(i = 0; i < burstsize; i++) {
    self setturrettargetEnt(etarget, randomvector(50) + (0, 0, 32));

    if(self.allowshoot && !self.firingmissiles) {
      self fireweapon();
    }

    wait firetime;
  }
}

function turret_minigun_fire(etarget, burstsize, var_f4f31ef6fe61050a) {
  self endon("death");
  self endon("heli_players_dead");
  self notify("firing_miniguns");
  self endon("firing_miniguns");
  turrets = get_turrets();
  array_thread(turrets, &turret_minigun_target_track, etarget, self);

  if(!self.minigunsspinning) {
    self.firingguns = 1;
    thread play_sound_on_tag("littlebird_gatling_spinup", "tag_flash");
    wait 2.1;
    thread play_loop_sound_on_tag("littlebird_minigun_spinloop", "tag_flash");
  }

  self.minigunsspinning = 1;

  if(!isDefined(var_f4f31ef6fe61050a)) {
    var_f4f31ef6fe61050a = 3;
  }

  var_65213dd2c413d808 = 0.5;

  if(var_65213dd2c413d808 > var_f4f31ef6fe61050a) {
    var_65213dd2c413d808 = var_f4f31ef6fe61050a;
  }

  if(var_65213dd2c413d808 > 0) {
    wait randomfloatrange(var_65213dd2c413d808, var_f4f31ef6fe61050a);
  }

  minigun_fire(etarget, burstsize);
  turrets = get_turrets();
  array_call(turrets, &stopfiring);
  thread minigun_spindown(etarget);
  self notify("stopping_firing");
}

function minigun_fire(etarget, burstsize) {
  self endon("death");
  self endon("heli_players_dead");

  if(isPlayer(etarget)) {
    self endon("cant_see_player");
  }

  turrets = get_turrets();
  array_call(turrets, &startfiring);
  wait randomfloatrange(1, 2);

  if(isPlayer(etarget)) {
    thread target_track(etarget);
  }

  if(isPlayer(etarget)) {
    frand = randomfloatrange(0.5, 3);
    thread fire_missiles(frand);
  }

  wait burstsize;
}

function target_track(etarget) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stopping_firing");
  self notify("tracking_player");
  self endon("tracking_player");

  while(true) {
    if(!can_see_player(etarget)) {
      break;
    }

    wait 0.5;
  }

  wait level.attackhelitimeout;
  self notify("cant_see_player");
}

function turret_minigun_target_track(etarget, eheli) {
  eheli endon("death");
  eheli endon("heli_players_dead");
  self notify("miniguns_have_new_target");
  self endon("miniguns_have_new_target");

  if(!isPlayer(etarget) && isai(etarget) && level.attackhelikillsai == 0) {
    var_692e37fea1e1cc0c = spawn("script_origin", etarget.origin + (0, 0, 100));
    var_692e37fea1e1cc0c linkTo(etarget);
    thread minigun_ai_target_cleanup(var_692e37fea1e1cc0c);
    etarget = var_692e37fea1e1cc0c;
  }

  while(true) {
    wait 0.5;
    self settargetentity(etarget);
  }
}

function minigun_ai_target_cleanup(var_692e37fea1e1cc0c) {
  waittill_either("death", "miniguns_have_new_target");
  var_692e37fea1e1cc0c delete();
}

function minigun_spindown(etarget) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("firing_miniguns");

  if(isPlayer(etarget)) {
    wait randomfloatrange(3, 4);
  } else {
    wait randomfloatrange(1, 2);
  }

  thread minigun_spindown_sound();
  self.firingguns = 0;
}

function minigun_spindown_sound() {
  self notify("stop sound" + "littlebird_minigun_spinloop");
  self.minigunsspinning = 0;
  play_sound_on_tag("littlebird_gatling_cooldown", "tag_flash");
}

function miss_player(player) {
  println("<dev string:x1c>");
  forward = anglesToForward(level.player.angles);
  forwardfar = forward * 400;
  miss_vec = forwardfar + randomvector(50);
  burstsize = randomintrange(10, 20);
  firetime = weaponfiretime("turret_attackheli");

  for(i = 0; i < burstsize; i++) {
    miss_vec = forwardfar + randomvector(50);
    self setturrettargetEnt(player, miss_vec);

    if(self.allowshoot) {
      self fireweapon();
    }

    wait firetime;
  }
}

function can_see_player(player) {
  self endon("death");
  self endon("heli_players_dead");
  tag_flash_loc = self gettagorigin("tag_flash");
  pos = (0, 0, 0);

  if(isPlayer(player)) {
    pos = player getEye();
  } else {
    pos = player.origin;
  }

  if(sighttracepassed(tag_flash_loc, pos, 0, undefined)) {
    return 1;
  }

  println("<dev string:x46>");
  return 0;
}

function get_linked_points(heli, goal, points, player, playerorigin) {
  linked = [];
  tokens = strtok(goal.script_linkto, " ");

  for(i = 0; i < points.size; i++) {
    for(j = 0; j < tokens.size; j++) {
      if(points[i].script_linkname == tokens[j]) {
        linked[linked.size] = points[i];
      }
    }
  }

  foreach(point in linked) {
    if(point.origin[2] < playerorigin[2]) {
      linked = array_remove(linked, point);
    }
  }

  return linked;
}

function heli_damage_monitor() {
  self endon("death");
  self endon("heli_players_dead");
  self endon("crashing");
  self endon("leaving");
  self.damagetaken = 0;
  self.seen_attacker = undefined;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, p, type);

    if(!isDefined(attacker) || !isPlayer(attacker)) {
      continue;
    }

    self notify("damage_by_player");
    thread heli_damage_update();
    thread can_see_attacker_for_a_bit(attacker);

    if(is_damagefeedback_enabled()) {
      attacker thread updatedamagefeedback();
    }
  }
}

function heli_damage_update() {
  self notify("taking damage");
  self endon("taking damage");
  self endon("death");
  self endon("heli_players_dead");
  self.istakingdamage = 1;
  wait 1;
  self.istakingdamage = 0;
}

function can_see_attacker_for_a_bit(attacker) {
  self notify("attacker_seen");
  self endon("attacker_seen");
  self.seen_attacker = attacker;
  self.heli_lastattacker = attacker;
  wait level.attackhelimemory;
  self.heli_lastattacker = undefined;
  self.seen_attacker = undefined;
}

function is_hidden_from_heli(heli) {
  if(isDefined(heli.seen_attacker)) {
    if(heli.seen_attacker == self) {
      return false;
    }
  }

  if(isDefined(level.attack_heli_safe_volumes)) {
    foreach(volume in level.attack_heli_safe_volumes) {
      if(self istouching(volume)) {
        return true;
      }
    }
  }

  return false;
}

function updatedamagefeedback() {
  if(!isPlayer(self)) {
    return;
  }

  self.hud_damagefeedback setshader("damage_feedback", 24, 48);
  self playlocalsound("player_feedback_hit_alert");
  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback fadeovertime(1);
  self.hud_damagefeedback.alpha = 0;
}

function damage_feedback_setup() {
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    player.hud_damagefeedback = newclienthudelem(player);
    player.hud_damagefeedback.horzalign = "center";
    player.hud_damagefeedback.vertalign = "middle";
    player.hud_damagefeedback.x = -12;
    player.hud_damagefeedback.y = -12;
    player.hud_damagefeedback.alpha = 0;
    player.hud_damagefeedback.archived = 1;
    player.hud_damagefeedback setshader("damage_feedback", 24, 48);
  }
}

function heli_death_monitor() {
  self waittill("death");
  level notify("attack_heli_destroyed");
  level.enemy_heli_killed = 1;
  wait 15;
  level.enemy_heli_attacking = 0;
}

function dialog_nags_heli(heli) {
  heli endon("death");
  heli endon("heli_players_dead");
  wait 30;

  if(!level.enemy_heli_attacking) {
    return;
  }

  commander_dialog("co_cf_cmd_heli_small_fire");

  if(!level.enemy_heli_attacking) {
    return;
  }

  commander_dialog("co_cf_cmd_rpg_stinger");
  wait 30;

  if(!level.enemy_heli_attacking) {
    return;
  }

  commander_dialog("co_cf_cmd_heli_wonders");
}

function commander_dialog(dialog_line) {
  while(level.commander_speaking) {
    wait 1;
  }

  level.commander_speaking = 1;
  level.player playSound(dialog_line, "sounddone");
  level.player waittill("sounddone");
  wait 0.5;
  level.commander_speaking = 0;
}

function usingantiairweapon() {
  weapon = self getcurrentweapon();

  if(!isDefined(weapon)) {
    return false;
  }

  weaponname = tolower(weapon.basename);

  if(issubstr(weaponname, "rpg")) {
    return true;
  }

  if(issubstr(weaponname, "stinger")) {
    return true;
  }

  if(issubstr(weaponname, "at4")) {
    return true;
  }

  return false;
}

function heli_spotlight_cleanup(stag) {
  waittill_any_3("death", "vehicle_crashDone", "turn_off_spotlight");
  self.spotlight = undefined;

  if(isDefined(self)) {
    stopFXOnTag(getfx("_attack_heli_spotlight"), self, stag);
  }
}

function heli_spotlight_create_default_targets(default_target) {
  self endon("death");
  self endon("heli_players_dead");
  original_ent = self.targetdefault;

  if(isDefined(default_target)) {
    original_ent = default_target;
  }

  original_ent.targetname = "original_ent";
  self.left_ent = spawn("script_origin", original_ent.origin);
  self.left_ent.origin = original_ent.origin;
  self.left_ent.angles = original_ent.angles;
  self.left_ent.targetname = "left_ent";
  self.right_ent = spawn("script_origin", original_ent.origin);
  self.right_ent.origin = original_ent.origin;
  self.right_ent.angles = original_ent.angles;
  self.right_ent.targetname = "right_ent";
  ent = spawnStruct();
  ent.entity = self.left_ent;
  ent.right = 250;
  ent translate_local();
  self.left_ent linkTo(self);
  ent2 = spawnStruct();
  ent2.entity = self.right_ent;
  ent2.right = -250;
  ent2 translate_local();
  self.right_ent linkTo(self);
  aim_ents = [];
  aim_ents[0] = original_ent;
  aim_ents[1] = self.left_ent;
  aim_ents[2] = self.right_ent;
  level.spotlight_aim_ents = aim_ents;
  self.spottarget = original_ent;
}

function heli_spotlight_destroy_default_targets() {
  if(isDefined(level.spotlight_aim_ents)) {
    foreach(aim_ent in level.spotlight_aim_ents) {
      if(isDefined(aim_ent)) {
        aim_ent delete();
      }
    }
  }
}

function heli_spotlight_aim(var_8b9ffc712b48d29e) {
  self endon("death");
  self endon("heli_players_dead");

  if(self.vehicletype != "littlebird") {
    return;
  }

  thread heli_spotlight_think(var_8b9ffc712b48d29e);
  var_943f3eecf3858541 = undefined;

  while(true) {
    wait 0.05;

    switch (self.vehicletype) {
      case #"hash_1a1d956bedda953d":
      case #"hash_8c12ae8d5afba7a6":
        var_943f3eecf3858541 = self.spottarget;
        break;
      default:
        var_943f3eecf3858541 = self.etarget;
        break;
    }

    if(isDefined(var_943f3eecf3858541)) {
      self setturrettargetEnt(var_943f3eecf3858541, (0, 0, 0));
    }
  }
}

function heli_spotlight_think(var_8b9ffc712b48d29e) {
  self endon("death");
  self endon("heli_players_dead");
  heli_spotlight_create_default_targets();
  array_thread(level.spotlight_aim_ents, &heli_spotlight_aim_ents_cleanup, self);

  if(isDefined(var_8b9ffc712b48d29e)) {
    self thread[[var_8b9ffc712b48d29e]]();
    return;
  }

  while(true) {
    wait randomfloatrange(1, 3);

    if(heli_has_player_target() && !within_player_fov()) {
      self.spottarget = self.etarget;
      continue;
    }

    irand = randomint(level.spotlight_aim_ents.size);
    self.targetdefault = level.spotlight_aim_ents[irand];
    self.spottarget = self.targetdefault;
  }
}

function within_player_fov() {
  self endon("death");
  self endon("heli_players_dead");

  if(!isDefined(self.etarget)) {
    return 0;
  }

  if(!isPlayer(self.etarget)) {
    return 0;
  }

  player = self.etarget;
  binfov = within_fov(player getEye(), player getplayerangles(), self.origin, level.cosine["35"]);
  return binfov;
}

function heli_spotlight_aim_ents_cleanup(eheli) {
  eheli waittill_either("death", "vehicle_crashDone");

  if(isDefined(self)) {
    self delete();
  }
}

function littlebird_turrets_think(eheli) {
  eturret = self;
  eturret scripts\common\vehicle_code::turret_set_default_on_mode("manual");

  if(isDefined(eheli.targetdefault)) {
    eturret settargetentity(eheli.targetdefault);
  }

  eturret setmode("manual");
  eheli waittill("death");

  if(isDefined(eheli.firingguns) && eheli.firingguns == 1) {
    thread minigun_spindown_sound();
  }
}

function attack_heli_cleanup() {
  waittill_either("death", "vehicle_crashDone");

  if(isDefined(self.attractor)) {
    missile_deleteattractor(self.attractor);
  }

  if(isDefined(self.attractor2)) {
    missile_deleteattractor(self.attractor2);
  }
}

function heli_default_missiles_on(custommissiles) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_default_heli_missiles");
  self.preferredtarget = undefined;

  while(isDefined(self)) {
    wait 0.05;
    etarget = undefined;
    ishots = undefined;
    delay = undefined;
    self.preferredtarget = undefined;
    enextnode = undefined;

    if(isDefined(self.currentnode) && isDefined(self.currentnode.target)) {
      enextnode = getent_or_struct(self.currentnode.target, "targetname");
    }

    if(isDefined(enextnode) && isDefined(enextnode.script_linkto)) {
      self.preferredtarget = getent_or_struct(enextnode.script_linkto, "script_linkname");
    }

    if(isDefined(self.preferredtarget)) {
      etarget = self.preferredtarget;
      ishots = etarget.script_shotcount;
      delay = etarget.script_delay;
      enextnode waittill("trigger");
    } else {
      waittill_any_2("near_goal", "goal");
    }

    if(isDefined(etarget)) {
      thread heli_fire_missiles(etarget, ishots, delay, custommissiles);
    }
  }
}

function heli_default_missiles_off() {
  self notify("stop_default_heli_missiles");
}

function heli_spotlight_on(stag, buseattackhelibehavior, var_d8d5db80fb486480) {
  if(!isDefined(stag)) {
    stag = "tag_barrel";
  }

  if(!isDefined(buseattackhelibehavior)) {
    buseattackhelibehavior = 0;
  }

  if(!isDefined(var_d8d5db80fb486480)) {
    var_d8d5db80fb486480 = 0;
  }

  playFXOnTag(getfx("_attack_heli_spotlight"), self, stag);
  self.spotlight = 1;
  thread heli_spotlight_cleanup(stag);

  if(var_d8d5db80fb486480) {
    self setturrettargetEnt(level.player);
    return;
  }

  if(buseattackhelibehavior) {
    self endon("death");
    self endon("heli_players_dead");
    spawn_origin = self gettagorigin("tag_origin");

    if(!isDefined(self.targetdefault)) {
      heli_default_target_setup();
    }

    self setturrettargetEnt(self.targetdefault);
    thread heli_spotlight_aim();
  }
}

function heli_spotlight_off() {
  self notify("turn_off_spotlight");
}

function heli_spotlight_random_targets_on() {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_spotlight_random_targets");

  if(!isDefined(self.targetdefault)) {
    thread heli_default_target_setup();
  }

  if(!isDefined(self.left_ent)) {
    thread heli_spotlight_think();
  }

  while(isDefined(self)) {
    wait 0.05;
    self setturrettargetEnt(self.targetdefault, (0, 0, 0));
  }
}

function heli_spotlight_random_targets_off() {
  self notify("stop_spotlight_random_targets");
}

function heli_fire_missiles(etarget, ishots, delay, custommissiles) {
  self endon("death");
  self endon("heli_players_dead");

  if(isDefined(self.defaultweapon)) {
    defaultweapon = self.defaultweapon;
  } else {
    defaultweapon = "turret_attackheli";
  }

  weaponname = "missile_attackheli";

  if(isDefined(custommissiles)) {
    weaponname = custommissiles;
  }

  var_8f26a943256ed058 = undefined;
  tags = [];
  self setvehweapon(defaultweapon);

  if(!isDefined(ishots)) {
    ishots = 1;
  }

  if(!isDefined(delay)) {
    delay = 1;
  }

  if(!isDefined(etarget.classname)) {
    if(!isDefined(self.dummytarget)) {
      self.dummytarget = spawn("script_origin", etarget.origin);
      thread delete_on_death(self.dummytarget);
    }

    self.dummytarget.origin = etarget.origin;
    etarget = self.dummytarget;
  }

  switch (self.vehicletype) {
    case #"hash_beeeed34c5017c21":
      var_8f26a943256ed058 = 0.5;
      tags[0] = "tag_store_L_2_a";
      tags[1] = "tag_store_R_2_a";
      tags[2] = "tag_store_L_2_b";
      tags[3] = "tag_store_R_2_b";
      tags[4] = "tag_store_L_2_c";
      tags[5] = "tag_store_R_2_c";
      tags[6] = "tag_store_L_2_d";
      tags[7] = "tag_store_R_2_d";
      break;
    case #"hash_8c12ae8d5afba7a6":
    case #"hash_b55ba82d2cec3b73":
      var_8f26a943256ed058 = 0.5;
      tags[0] = "tag_missile_left";
      tags[1] = "tag_missile_right";
      break;
    case #"hash_657241a1e3f14ce7":
      tags[0] = "tag_missile_left";
      tags[1] = "tag_missile_right";
      break;
    default:
      assertmsg("Missiles have not been setup for helicoper model: " + self.vehicletype);
      break;
  }

  nextmissiletag = -1;

  for(i = 0; i < ishots; i++) {
    nextmissiletag++;

    if(nextmissiletag >= tags.size) {
      nextmissiletag = 0;
    }

    self setvehweapon(weaponname);
    self.firingmissiles = 1;
    emissile = self fireweapon(tags[nextmissiletag], etarget);
    emissile thread missile_earthquake();

    if(i < ishots - 1) {
      wait delay;
    }
  }

  self.firingmissiles = 0;
  self setvehweapon(defaultweapon);
}

function boneyard_style_heli_missile_attack() {
  self waittill("trigger", vehicle);
  struct_arr = getStructArray(self.target, "targetname");
  struct_arr = array_index_by_script_index(struct_arr);
  boneyard_fire_at_targets(vehicle, struct_arr);
}

function boneyard_style_heli_missile_attack_linked() {
  self waittill("trigger", vehicle);
  struct_arr = get_linked_structs();
  struct_arr = array_index_by_script_index(struct_arr);
  boneyard_fire_at_targets(vehicle, struct_arr);
}

function boneyard_fire_at_targets(vehicle, struct_arr) {
  tags = [];
  tags[0] = "tag_missile_right";
  tags[1] = "tag_missile_left";

  if(vehicle.vehicletype == "cobra") {
    tags[0] = "tag_store_L_1_a";
    tags[1] = "tag_store_R_1_a";
  }

  ents = [];

  for(i = 0; i < struct_arr.size; i++) {
    assertex(isDefined(struct_arr[i]), "boneyard_style_heli_missile_attack requires script_index key/value to start at 0 and not have any gaps.");
    ents[i] = spawn("script_origin", struct_arr[i].origin);
    vehicle setvehweapon("littlebird_FFAR");
    vehicle setturrettargetEnt(ents[i]);
    missile = vehicle fireweapon(tags[i % tags.size], ents[i], (0, 0, 0));
    missile delaycall(1, &missile_cleartarget);
    wait randomfloatrange(0.2, 0.3);
  }

  wait 2;

  foreach(ent in ents) {
    ent delete();
  }
}