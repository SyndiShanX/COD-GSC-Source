/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\vehicle\attack_heli.gsc
***********************************************/

function preload() {
  precacheitem("turret_attackheli");
  precacheitem("missile_attackheli");
  attack_heli_fx();
  thread init();
}

function attack_heli_fx() {
  if(getdvarint("sm_spotEnable") && getDvar("r_zfeather") != "0") {
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

function start_attack_heli(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "kill_heli";
  }

  var_1 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  var_1 = begin_attack_heli_behavior(var_1);
  return var_1;
}

function begin_attack_heli_behavior(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("heli_players_dead");

  if(level.gameskill == 0 || level.gameskill == 1) {
    var_2 = spawn("script_origin", var_0.origin + (0, 0, -20));
    var_2 linkTo(var_0);
    var_0 thread scripts\engine\utility::delete_on_death(var_2);
    var_3 = undefined;

    if(level.gameskill == 0) {
      var_3 = 2800;
    } else {
      var_3 = 2200;
    }

    if(!isDefined(var_0.no_attractor)) {
      var_0.attractor = missile_createattractorent(var_2, var_3, 10000, level.player);
    }
  }

  var_0 enableaimassist();
  var_0.startingorigin = spawn("script_origin", var_0.origin);
  var_0 thread scripts\engine\utility::delete_on_death(var_0.startingorigin);

  if(!isDefined(var_0.circling)) {
    var_0.circling = 0;
  }

  var_0.allowshoot = 1;
  var_0.firingmissiles = 0;
  var_0.moving = 1;
  var_0.istakingdamage = 0;
  var_0.heli_lastattacker = undefined;
  thread notify_disable();
  thread notify_enable();
  thread kill_heli_logic(var_0, var_1);
  var_0.turrettype = undefined;
  heli_default_target_setup(var_0);
  thread detect_player_death();

  switch (var_0.vehicletype) {
    case "hind_battle":
    case "ny_harbor_hind":
    case "hind_blackice":
    case "hind":
      var_0.turrettype = "default";
      break;
    case "mi28":
    case "nh90":
    case "mi17":
      var_0.turrettype = "default";
      break;
    case "apache":
      var_0.turrettype = "default";
      break;
    case "littlebird_spotlight":
    case "littlebird":
      var_0 setyawspeed(90, 30, 20);
      var_0 setmaxpitchroll(40, 40);
      var_0 sethoverparams(100, 20, 5);
      setup_miniguns(var_0);
      break;
    default:
      break;
  }

  var_0.etarget = var_0.targetdefault;

  if(isDefined(var_0.script_spotlight) && var_0.script_spotlight == 1 && !isDefined(var_0.spotlight)) {
    thread heli_spotlight_on(var_0, undefined);
  }

  thread attack_heli_cleanup();
  return var_0;
}

function detect_player_death() {
  foreach(var_1 in level.players) {
    var_1 scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "death");
  }

  scripts\engine\sp\utility::do_wait_any();
  self notify("heli_players_dead");
}

function heli_default_target_setup() {
  var_0 = undefined;
  var_1 = undefined;

  switch (self.vehicletype) {
    case "hind_battle":
    case "ny_harbor_hind":
    case "hind_blackice":
    case "hind":
      var_1 = 600;
      var_0 = -100;
      break;
    case "mi28":
    case "nh90":
    case "mi17":
      var_1 = 600;
      var_0 = -100;
      break;
    case "apache":
      var_1 = 600;
      var_0 = -100;
      break;
    case "littlebird_spotlight":
    case "littlebird":
      var_1 = 600;
      var_0 = -204;
      break;
    default:
      break;
  }

  self.targetdefault = spawn("script_origin", self.origin);
  self.targetdefault.angles = self.angles;
  self.targetdefault.origin = self.origin;
  var_2 = spawnStruct();
  var_2.entity = self.targetdefault;
  var_2.forward = var_1;
  var_2.up = var_0;
  var_2 scripts\engine\sp\utility::translate_local();
  self.targetdefault linkTo(self);
  thread heli_default_target_cleanup(self.targetdefault);
}

function get_turrets() {
  if(isDefined(self.turrets)) {
    return self.turrets;
  }

  setup_miniguns();
  return self.turrets;
}

function setup_miniguns() {
  self.turrettype = "miniguns";
  self.minigunsspinning = 0;
  self.firingguns = 0;

  if(!isDefined(self.mgturret)) {
    return;
  }

  self.turrets = self.mgturret;
  scripts\engine\utility::array_thread(self.turrets, &littlebird_turrets_think, self);
}

function heli_default_target_cleanup(var_0) {
  var_0 scripts\engine\utility::waittill_either("death", "vehicle_crashDone");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function start_circling_heli(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "kill_heli";
  }

  var_2 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  var_2.startingorigin = spawn("script_origin", var_2.origin);
  var_2 thread scripts\engine\utility::delete_on_death(var_2.startingorigin);
  var_2.circling = 1;
  var_2.allowshoot = 1;
  var_2.firingmissiles = 0;
  thread notify_disable();
  thread notify_enable();
  thread kill_heli_logic(var_2, var_1);
  return var_2;
}

function kill_heli_logic(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("kill_heli");
    var_0.allowshoot = 1;
    var_0.firingmissiles = 0;
    thread notify_disable();
    thread notify_enable();
  }

  var_2 = undefined;

  if(!isDefined(var_0.script_airspeed)) {
    var_2 = 40;
  } else {
    var_2 = var_0.script_airspeed;
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
  var_3 = getEntArray("attack_heli_safe_volume", "script_noteworthy");

  if(var_3.size > 0) {
    level.attack_heli_safe_volumes = var_3;
  }

  if(!level.enemy_heli_killed) {
    thread dialog_nags_heli(var_0);
  }

  if(!isDefined(var_0.helicopter_predator_target_shader)) {
    switch (var_0.vehicletype) {
      case "mi28":
      case "nh90":
      case "mi17":
        target_set(var_0, (0, 0, -80));
        break;
      case "hind_battle":
      case "ny_harbor_hind":
      case "hind_blackice":
      case "hind":
        target_set(var_0, (0, 0, -96));
        break;
      case "apache":
        target_set(var_0, (0, 0, -96));
        break;
      case "littlebird_spotlight":
      case "littlebird":
        target_set(var_0, (0, 0, -80));
        break;
      default:
        break;
    }

    target_setjavelinonly(var_0, 1);
  }

  thread heli_damage_monitor();
  thread heli_death_monitor();
  var_0 endon("death");
  var_0 endon("heli_players_dead");
  var_0 endon("returning_home");
  var_0 setvehweapon("turret_attackheli");

  if(!isDefined(var_0.circling)) {
    var_0.circling = 0;
  }

  if(!var_0.circling) {
    var_0 setneargoalnotifydist(100);

    if(!isDefined(var_0.dontwaitforpathend)) {
      var_0 waittill("reached_dynamic_path_end");
    }
  } else {
    var_0 setneargoalnotifydist(500);
    var_0 waittill("near_goal");
  }

  thread heli_shoot_think();

  if(var_0.circling) {
    thread heli_circling_think(var_0, var_1);
    return;
  }

  thread heli_goal_think(var_0);
}

function heli_circling_think(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "attack_heli_circle_node";
  }

  var_2 = getEntArray(var_0, "targetname");

  if(!isDefined(var_2) || var_2.size < 1) {
    var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");
  }

  var_3 = self;
  var_3 endon("stop_circling");
  var_3 endon("death");
  var_3 endon("returning_home");
  var_3 endon("heli_players_dead");

  for(;;) {
    var_3 vehicle_setspeed(var_1, var_1 / 4, var_1 / 4);
    var_3 setneargoalnotifydist(100);
    var_4 = level.player;
    var_5 = var_4.origin;
    var_3 setlookatent(var_4);
    var_6 = scripts\engine\utility::getclosest(var_5, var_2);
    var_7 = getEntArray(var_6.target, "targetname");

    if(!isDefined(var_7) || var_7.size < 1) {
      var_7 = scripts\engine\utility::getStructArray(var_6.target, "targetname");
    }

    var_8 = var_7[randomint(var_7.size)];
    var_3 setvehgoalpos(var_8.origin, 1);
    var_3 waittill("near_goal");

    if(!isDefined(var_4.is_controlling_uav)) {
      wait 1;
      wait randomfloatrange(0.8, 1.3);
    }
  }
}

function heli_goal_think(var_0) {
  self endon("death");
  var_1 = getEntArray("kill_heli_spot", "targetname");
  var_2 = self;
  var_3 = scripts\engine\utility::getclosest(var_2.origin, var_1);
  var_4 = var_3;
  var_2 endon("death");
  var_2 endon("returning_home");
  var_2 endon("heli_players_dead");
  var_5 = undefined;

  for(;;) {
    wait 0.05;
    var_2 vehicle_setspeed(var_0, var_0 / 2, var_0 / 10);
    var_2 setneargoalnotifydist(100);
    var_6 = level.player;
    var_7 = var_6.origin;

    if(var_3 == var_4 && var_2.istakingdamage) {
      var_8 = get_linked_points(var_2, var_3, var_1, var_6, var_7);
      var_3 = scripts\engine\utility::getclosest(var_7, var_8);
    }

    var_2 setvehgoalpos(var_3.origin, 1);
    var_2.moving = 1;
    var_6 = level.player;

    if(isDefined(self.etarget) && isDefined(self.etarget.classname) && self.etarget.classname == "script_origin") {
      var_5 = var_6;
    } else if(isDefined(self.etarget)) {
      var_5 = self.etarget;
    } else {
      var_5 = self.targetdefault;
    }

    var_2 setlookatent(var_5);
    var_2 waittill("near_goal");
    var_2.moving = 0;

    if(level.gameskill == 0 || level.gameskill == 1) {
      while(player_is_aiming_with_rocket(var_2)) {
        wait 0.5;
      }

      wait 3;
    }

    var_6 = level.player;
    var_7 = var_6.origin;
    var_8 = get_linked_points(var_2, var_3, var_1, var_6, var_7);
    var_8 = var_3;
    var_4 = var_3;
    var_9 = scripts\engine\utility::getclosest(var_7, var_1);
    var_10 = scripts\engine\utility::getclosest(var_7, var_8);

    foreach(var_12 in var_8) {
      if(var_6 sightconetrace(var_12.origin, var_2) != 1) {
        var_8 = scripts\engine\utility::array_remove(var_8, var_12);
      }
    }

    var_14 = scripts\engine\utility::getclosest(var_7, var_8);

    if(var_8.size < 2) {
      var_3 = var_10;
    } else if(var_14 != var_9) {
      var_3 = var_14;
    } else {
      var_15 = [];
      GscBinSkip0(0x2e, 0, var_14);
    }

    var_15 = randomfloatrange(level.attackhelimovetime - 0.5, level.attackhelimovetime + 0.5);
    scripts\engine\utility::waittill_notify_or_timeout("damage_by_player", var_15);
  }
}

function player_is_aiming_with_rocket(var_0) {
  if(!usingantiairweapon(level.player)) {
    return false;
  }

  if(!level.player adsButtonPressed()) {
    return false;
  }

  var_1 = level.player getEye();

  if(sighttracepassed(var_1, var_0.origin, 0, level.player)) {
    return true;
  }

  return false;
}

function heli_shoot_think() {
  self endon("stop_shooting");
  self endon("death");
  self endon("heli_players_dead");
  thread heli_missiles_think();
  var_0 = level.attackhelirange * level.attackhelirange;
  level.attackheligraceperiod = 0;

  while(isDefined(self)) {
    wait randomfloatrange(0.8, 1.3);

    if(!heli_has_target() || !heli_has_player_target()) {
      var_1 = heli_get_target_player_only();

      if(isPlayer(var_1)) {
        self.etarget = var_1;
      }
    }

    if(heli_has_player_target()) {
      if(!heli_can_see_target() || level.attackheligraceperiod == 1) {
        var_1 = heli_get_target_ai_only();
        self.etarget = var_1;
      }
    }

    if(isDefined(self.heli_lastattacker) && isPlayer(self.heli_lastattacker)) {
      self.etarget = self.heli_lastattacker;
    } else if(!heli_has_target()) {
      var_1 = heli_get_target_ai_only();
      self.etarget = var_1;
    }

    if(!heli_has_target()) {
      continue;
    }

    if(is_hidden_from_heli(self.etarget, self)) {
      continue;
    }

    if(heli_has_target() && distancesquared(self.etarget.origin, self.origin) > var_0) {
      continue;
    }

    if(self.turrettype == "default" && heli_has_player_target()) {
      miss_player(self.etarget);
      wait randomfloatrange(0.8, 1.3);
      miss_player(self.etarget);
      wait randomfloatrange(0.8, 1.3);

      while(can_see_player(self.etarget) && !is_hidden_from_heli(self.etarget, self)) {
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

    scripts\engine\utility::waittill_notify_or_timeout("damage_by_player", level.attackhelitargetreaquire);
  }
}

function player_grace_period(var_0) {
  level notify("player_is_heli_target");
  level endon("player_is_heli_target");
  level.attackheligraceperiod = 1;
  var_0 scripts\engine\utility::waittill_notify_or_timeout("damage_by_player", level.attackheliplayerbreak);
  level.attackheligraceperiod = 0;
}

function heli_can_see_target() {
  if(!isDefined(self.etarget)) {
    return 0;
  }

  var_0 = self.etarget.origin + (0, 0, 32);

  if(isPlayer(self.etarget)) {
    var_0 = self.etarget getEye();
  }

  var_1 = self gettagorigin("tag_flash");
  var_2 = sighttracepassed(var_1, var_0, 0, self);
  return var_2;
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
  var_0 = scripts\sp\helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 1, 0, 1, level.attackheliexcluders);

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_0 = self.targetdefault;
  }

  if(!isDefined(var_0)) {
    var_0 = self.targetdefault;
  }

  return var_0;
}

function heli_get_target_player_only() {
  var_0 = getaiarray("allies");
  var_1 = scripts\sp\helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 0, 0, 0, var_0);

  if(!isDefined(var_1)) {
    var_1 = self.targetdefault;
  }

  return var_1;
}

function heli_get_target_ai_only() {
  var_0 = scripts\sp\helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 1, 0, 1, level.players);

  if(!isDefined(var_0)) {
    var_0 = self.targetdefault;
  }

  return var_0;
}

function heli_missiles_think() {
  if(!isDefined(self.script_missiles)) {
    return;
  }

  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_shooting");
  var_0 = undefined;
  var_1 = "turret_attackheli";
  var_2 = "missile_attackheli";
  var_3 = undefined;
  var_4 = undefined;
  var_5 = [];

  switch (self.vehicletype) {
    case "mi28":
      var_0 = 1;
      var_3 = 1;
      var_4 = 0.5;
      GscBinSkip0(0x2e, 0, "tag_store_L_2_a");

    case "littlebird":
    case "apache":
      var_0 = 1;
      var_3 = 1;
      var_4 = 0.5;
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    default:
      break;
  }

  var_6 = -1;

  for(;;) {
    wait 0.05;
    self waittill("fire_missiles", var_7);

    if(!isPlayer(var_7)) {
      continue;
    }

    var_8 = var_7;

    if(!player_is_good_missile_target(var_8)) {
      continue;
    }

    for(var_9 = 0; var_9 < var_0; var_9++) {
      var_6++;

      if(var_6 >= var_5.size) {
        var_6 = 0;
      }

      self setvehweapon(var_2);
      self.firingmissiles = 1;
      var_10 = self fireweapon(var_5[var_6], var_8);
      thread missilelosetarget(var_10);
      thread missile_earthquake();

      if(var_9 < var_0 - 1) {
        wait var_3;
      }
    }

    self.firingmissiles = 0;
    self setvehweapon(var_1);
    wait 10;
  }
}

function player_is_good_missile_target(var_0) {
  if(self.moving) {
    return 0;
  }

  return 1;
}

function missile_earthquake() {
  if(distancesquared(self.origin, level.player.origin) > 9000000) {
    return;
  }

  var_0 = self.origin;

  while(isDefined(self)) {
    var_0 = self.origin;
    wait 0.1;
  }

  earthquake(0.7, 1.5, var_0, 1600);
}

function missilelosetarget(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  wait var_0;

  if(isDefined(self)) {
    self missile_cleartarget();
    return;
  }
}

function get_different_player(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(var_0 != level.players[var_1]) {
      return level.players[var_1];
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
    case "default":
      var_0 = randomintrange(5, 10);
      var_1 = weaponfiretime("turret_attackheli");
      turret_default_fire(self.etarget, var_0, var_1);
      break;
    case "miniguns":
      var_0 = getburstsize(self.etarget);

      if(self.allowshoot && !self.firingmissiles) {
        turret_minigun_fire(self.etarget, var_0);
      }

      break;
    default:
      break;
  }
}

function getburstsize(var_0) {
  var_1 = undefined;

  if(!isPlayer(var_0)) {
    var_1 = level.attackheliaiburstsize;
    return var_1;
  }

  switch (level.gameskill) {
    case 3:
    case 2:
    case 1:
    case 0:
      var_1 = randomintrange(2, 3);
      break;
  }

  return var_1;
}

function fire_missiles(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  wait var_0;

  if(!isPlayer(self.etarget)) {
    return;
  }

  self notify("fire_missiles", self.etarget);
}

function turret_default_fire(var_0, var_1, var_2) {
  thread fire_missiles(randomfloatrange(0.2, 2));

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self setturrettargetEnt(var_0, scripts\engine\utility::randomvector(50) + (0, 0, 32));

    if(self.allowshoot && !self.firingmissiles) {
      self fireweapon();
    }

    wait var_2;
  }
}

function turret_minigun_fire(var_0, var_1, var_2) {
  self endon("death");
  self endon("heli_players_dead");
  self notify("firing_miniguns");
  self endon("firing_miniguns");
  var_3 = get_turrets();
  scripts\engine\utility::array_thread(var_3, &turret_minigun_target_track, var_0, self);

  if(!self.minigunsspinning) {
    self.firingguns = 1;
    thread scripts\engine\sp\utility::play_sound_on_tag("littlebird_gatling_spinup", "tag_flash");
    wait 2.1;
    thread scripts\engine\sp\utility::play_loop_sound_on_tag("littlebird_minigun_spinloop", "tag_flash");
  }

  self.minigunsspinning = 1;

  if(!isDefined(var_2)) {
    var_2 = 3;
  }

  var_4 = 0.5;

  if(var_4 > var_2) {
    var_4 = var_2;
  }

  if(var_4 > 0) {
    wait randomfloatrange(var_4, var_2);
  }

  minigun_fire(var_0, var_1);
  var_3 = get_turrets();
  scripts\engine\utility::array_call(var_3, &stopfiring);
  thread minigun_spindown(var_0);
  self notify("stopping_firing");
}

function minigun_fire(var_0, var_1) {
  self endon("death");
  self endon("heli_players_dead");

  if(isPlayer(var_0)) {
    self endon("cant_see_player");
  }

  var_2 = get_turrets();
  scripts\engine\utility::array_call(var_2, &startfiring);
  wait randomfloatrange(1, 2);

  if(isPlayer(var_0)) {
    thread target_track(var_0);
  }

  if(isPlayer(var_0)) {
    var_3 = randomfloatrange(0.5, 3);
    thread fire_missiles(var_3);
  }

  wait var_1;
}

function target_track(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stopping_firing");
  self notify("tracking_player");
  self endon("tracking_player");

  for(;;) {
    if(!can_see_player(var_0)) {
      break;
    }

    wait 0.5;
  }

  wait level.attackhelitimeout;
  self notify("cant_see_player");
}

function turret_minigun_target_track(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("heli_players_dead");
  self notify("miniguns_have_new_target");
  self endon("miniguns_have_new_target");

  if(!isPlayer(var_0) && isai(var_0) && level.attackhelikillsai == 0) {
    var_2 = spawn("script_origin", var_0.origin + (0, 0, 100));
    var_2 linkTo(var_0);
    thread minigun_ai_target_cleanup(var_2);
    var_0 = var_2;
  }

  for(;;) {
    wait 0.5;
    self settargetentity(var_0);
  }
}

function minigun_ai_target_cleanup(var_0) {
  scripts\engine\utility::waittill_either("death", "miniguns_have_new_target");
  var_0 delete();
}

function minigun_spindown(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("firing_miniguns");

  if(isPlayer(var_0)) {
    wait randomfloatrange(3, 4);
  } else {
    wait randomfloatrange(1, 2);
  }

  thread minigun_spindown_sound();
  self.firingguns = 0;
}

function minigun_spindown_sound() {
  self notify("stop soundlittlebird_minigun_spinloop");
  self.minigunsspinning = 0;
  scripts\engine\sp\utility::play_sound_on_tag("littlebird_gatling_cooldown", "tag_flash");
}

function miss_player(var_0) {
  var_1 = anglesToForward(level.player.angles);
  var_2 = var_1 * 400;
  var_3 = var_2 + scripts\engine\utility::randomvector(50);
  var_4 = randomintrange(10, 20);
  var_5 = weaponfiretime("turret_attackheli");

  for(var_6 = 0; var_6 < var_4; var_6++) {
    var_3 = var_2 + scripts\engine\utility::randomvector(50);
    self setturrettargetEnt(var_0, var_3);

    if(self.allowshoot) {
      self fireweapon();
    }

    wait var_5;
  }
}

function can_see_player(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  var_1 = self gettagorigin("tag_flash");
  var_2 = (0, 0, 0);

  if(isPlayer(var_0)) {
    var_2 = var_0 getEye();
  } else {
    var_2 = var_0.origin;
  }

  if(sighttracepassed(var_1, var_2, 0, undefined)) {
    return 1;
  }

  return 0;
}

function get_linked_points(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = strtok(var_1.script_linkto, " ");

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    for(var_8 = 0; var_8 < var_6.size; var_8++) {
      if(var_2[var_7].script_linkname == var_6[var_8]) {
        var_5 = var_2[var_7];
      }
    }
  }

  foreach(var_10 in var_5) {
    if(var_10.origin[2] < var_4[2]) {
      var_5 = scripts\engine\utility::array_remove(var_5, var_10);
    }
  }

  return var_5;
}

function heli_damage_monitor() {
  self endon("death");
  self endon("heli_players_dead");
  self endon("crashing");
  self endon("leaving");
  self.damagetaken = 0;
  self.seen_attacker = undefined;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isDefined(var_1) || !isPlayer(var_1)) {
      continue;
    }

    self notify("damage_by_player");
    thread heli_damage_update();
    thread can_see_attacker_for_a_bit(var_1);

    if(scripts\engine\sp\utility::is_damagefeedback_enabled()) {
      thread updatedamagefeedback();
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

function can_see_attacker_for_a_bit(var_0) {
  self notify("attacker_seen");
  self endon("attacker_seen");
  self.seen_attacker = var_0;
  self.heli_lastattacker = var_0;
  wait level.attackhelimemory;
  self.heli_lastattacker = undefined;
  self.seen_attacker = undefined;
}

function is_hidden_from_heli(var_0) {
  if(isDefined(var_0.seen_attacker)) {
    if(var_0.seen_attacker == self) {
      return false;
    }
  }

  if(isDefined(level.attack_heli_safe_volumes)) {
    foreach(var_2 in level.attack_heli_safe_volumes) {
      if(self istouching(var_2)) {
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
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];
    var_1.hud_damagefeedback = newclienthudelem(var_1);
    var_1.hud_damagefeedback.horzalign = "center";
    var_1.hud_damagefeedback.vertalign = "middle";
    var_1.hud_damagefeedback.x = -12;
    var_1.hud_damagefeedback.y = -12;
    var_1.hud_damagefeedback.alpha = 0;
    var_1.hud_damagefeedback.archived = 1;
    var_1.hud_damagefeedback setshader("damage_feedback", 24, 48);
  }
}

function heli_death_monitor() {
  self waittill("death");
  level notify("attack_heli_destroyed");
  level.enemy_heli_killed = 1;
  wait 15;
  level.enemy_heli_attacking = 0;
}

function dialog_nags_heli(var_0) {
  var_0 endon("death");
  var_0 endon("heli_players_dead");
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

function commander_dialog(var_0) {
  while(level.commander_speaking) {
    wait 1;
  }

  level.commander_speaking = 1;
  level.player playSound(var_0, "sounddone");
  level.player waittill("sounddone");
  wait 0.5;
  level.commander_speaking = 0;
}

function usingantiairweapon() {
  var_0 = self getcurrentweapon();

  if(!isDefined(var_0)) {
    return false;
  }

  var_1 = tolower(var_0.basename);

  if(issubstr(var_1, "rpg")) {
    return true;
  }

  if(issubstr(var_1, "stinger")) {
    return true;
  }

  if(issubstr(var_1, "at4")) {
    return true;
  }

  return false;
}

function heli_spotlight_cleanup(var_0) {
  scripts\engine\utility::waittill_any("death", "vehicle_crashDone", "turn_off_spotlight");
  self.spotlight = undefined;

  if(isDefined(self)) {
    stopFXOnTag(scripts\engine\utility::getfx("_attack_heli_spotlight"), self, var_0);
    return;
  }
}

function heli_spotlight_create_default_targets(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  var_1 = self.targetdefault;

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  var_1.targetname = "original_ent";
  self.left_ent = spawn("script_origin", var_1.origin);
  self.left_ent.origin = var_1.origin;
  self.left_ent.angles = var_1.angles;
  self.left_ent.targetname = "left_ent";
  self.right_ent = spawn("script_origin", var_1.origin);
  self.right_ent.origin = var_1.origin;
  self.right_ent.angles = var_1.angles;
  self.right_ent.targetname = "right_ent";
  var_2 = spawnStruct();
  var_2.entity = self.left_ent;
  var_2.right = 250;
  var_2 scripts\engine\sp\utility::translate_local();
  self.left_ent linkTo(self);
  var_3 = spawnStruct();
  var_3.entity = self.right_ent;
  var_3.right = -250;
  var_3 scripts\engine\sp\utility::translate_local();
  self.right_ent linkTo(self);
  var_4 = [];
  GscBinSkip0(0x2e, 0, var_1);
}

function heli_spotlight_destroy_default_targets() {
  if(isDefined(level.spotlight_aim_ents)) {
    foreach(var_1 in level.spotlight_aim_ents) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }

    return;
  }
}

function heli_spotlight_aim(var_0) {
  self endon("death");
  self endon("heli_players_dead");

  if(self.vehicletype != "littlebird") {
    return;
  }

  thread heli_spotlight_think(var_0);
  var_1 = undefined;

  for(;;) {
    wait 0.05;

    switch (self.vehicletype) {
      case "littlebird_spotlight":
      case "littlebird":
        var_1 = self.spottarget;
        break;
      default:
        var_1 = self.etarget;
        break;
    }

    if(isDefined(var_1)) {
      self setturrettargetEnt(var_1, (0, 0, 0));
    }
  }
}

function heli_spotlight_think(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  heli_spotlight_create_default_targets();
  scripts\engine\utility::array_thread(level.spotlight_aim_ents, &heli_spotlight_aim_ents_cleanup, self);

  if(isDefined(var_0)) {
    self thread[[var_0]]();
    return;
  }

  for(;;) {
    wait randomfloatrange(1, 3);

    if(heli_has_player_target() && !within_player_fov()) {
      self.spottarget = self.etarget;
      continue;
    }

    var_1 = randomint(level.spotlight_aim_ents.size);
    self.targetdefault = level.spotlight_aim_ents[var_1];
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

  var_0 = self.etarget;
  var_1 = scripts\engine\utility::within_fov(var_0 getEye(), var_0 getplayerangles(), self.origin, level.cosine["35"]);
  return var_1;
}

function heli_spotlight_aim_ents_cleanup(var_0) {
  var_0 scripts\engine\utility::waittill_either("death", "vehicle_crashDone");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function littlebird_turrets_think(var_0) {
  var_1 = self;
  var_1 scripts\common\vehicle_code::turret_set_default_on_mode("manual");

  if(isDefined(var_0.targetdefault)) {
    var_1 settargetentity(var_0.targetdefault);
  }

  var_1 setmode("manual");
  var_0 waittill("death");

  if(isDefined(var_0.firingguns) && var_0.firingguns == 1) {
    thread minigun_spindown_sound();
    return;
  }
}

function attack_heli_cleanup() {
  scripts\engine\utility::waittill_either("death", "vehicle_crashDone");

  if(isDefined(self.attractor)) {
    missile_deleteattractor(self.attractor);
  }

  if(isDefined(self.attractor2)) {
    missile_deleteattractor(self.attractor2);
    return;
  }
}

function heli_default_missiles_on(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_default_heli_missiles");
  self.preferredtarget = undefined;

  while(isDefined(self)) {
    wait 0.05;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    self.preferredtarget = undefined;
    var_4 = undefined;

    if(isDefined(self.currentnode) && isDefined(self.currentnode.target)) {
      var_4 = scripts\engine\utility::getent_or_struct(self.currentnode.target, "targetname");
    }

    if(isDefined(var_4) && isDefined(var_4.script_linkto)) {
      self.preferredtarget = scripts\engine\utility::getent_or_struct(var_4.script_linkto, "script_linkname");
    }

    if(isDefined(self.preferredtarget)) {
      var_1 = self.preferredtarget;
      var_2 = var_1.script_shotcount;
      var_3 = var_1.script_delay;
      var_4 waittill("trigger");
    } else {
      scripts\engine\utility::waittill_any("near_goal", "goal");
    }

    if(isDefined(var_1)) {
      thread heli_fire_missiles(var_1, var_2, var_3, var_0);
    }
  }
}

function heli_default_missiles_off() {
  self notify("stop_default_heli_missiles");
}

function heli_spotlight_on(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = "tag_barrel";
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  playFXOnTag(scripts\engine\utility::getfx("_attack_heli_spotlight"), self, var_0);
  self.spotlight = 1;
  thread heli_spotlight_cleanup(var_0);

  if(var_2) {
    self setturrettargetEnt(level.player);
    return;
  }

  if(var_1) {
    self endon("death");
    self endon("heli_players_dead");
    var_3 = self gettagorigin("tag_origin");

    if(!isDefined(self.targetdefault)) {
      heli_default_target_setup();
    }

    self setturrettargetEnt(self.targetdefault);
    thread heli_spotlight_aim();
    return;
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

function heli_fire_missiles(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("heli_players_dead");

  if(isDefined(self.defaultweapon)) {
    var_4 = self.defaultweapon;
  } else {
    var_4 = "turret_attackheli";
  }

  var_5 = "missile_attackheli";

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  var_6 = undefined;
  var_7 = [];
  self setvehweapon(var_4);

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_1.classname)) {
    if(!isDefined(self.dummytarget)) {
      self.dummytarget = spawn("script_origin", var_1.origin);
      thread scripts\engine\utility::delete_on_death(self.dummytarget);
    }

    self.dummytarget.origin = var_1.origin;
    var_1 = self.dummytarget;
  }

  switch (self.vehicletype) {
    case "mi28":
      var_6 = 0.5;
      GscBinSkip0(0x2e, 0, "tag_store_L_2_a");

    case "littlebird":
    case "apache":
      var_6 = 0.5;
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "hind_battle":
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    default:
      break;
  }

  var_8 = -1;

  for(var_9 = 0; var_9 < var_2; var_9++) {
    var_8++;

    if(var_8 >= var_7.size) {
      var_8 = 0;
    }

    self setvehweapon(var_5);
    self.firingmissiles = 1;
    var_10 = self fireweapon(var_7[var_8], var_1);
    thread missile_earthquake();

    if(var_9 < var_2 - 1) {
      wait var_3;
    }
  }

  self.firingmissiles = 0;
  self setvehweapon(var_4);
}

function boneyard_style_heli_missile_attack() {
  self waittill("trigger", var_0);
  var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var_1 = scripts\engine\sp\utility::array_index_by_script_index(var_1);
  boneyard_fire_at_targets(var_0, var_1);
}

function boneyard_style_heli_missile_attack_linked() {
  self waittill("trigger", var_0);
  var_1 = scripts\engine\utility::get_linked_structs();
  var_1 = scripts\engine\sp\utility::array_index_by_script_index(var_1);
  boneyard_fire_at_targets(var_0, var_1);
}

function boneyard_fire_at_targets(var_0, var_1) {
  var_2 = [];
  GscBinSkip0(0x2e, 0, "tag_missile_right");
}