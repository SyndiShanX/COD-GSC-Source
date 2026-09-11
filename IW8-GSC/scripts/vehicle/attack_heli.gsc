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
  if(getdvarint("RNPPKQOTN") && getDvar("r_zfeather") != "0") {
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

function start_attack_heli(var0) {
  if(!isDefined(var0)) {
    var0 = "kill_heli";
  }

  var1 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var0);
  var1 = begin_attack_heli_behavior(var1);
  return var1;
}

function begin_attack_heli_behavior(var0, var1) {
  var0 endon("death");
  var0 endon("heli_players_dead");

  if(level.gameskill == 0 || level.gameskill == 1) {
    var2 = spawn("script_origin", var0.origin + (0, 0, -20));
    var2 linkTo(var0);
    var0 thread scripts\engine\utility::delete_on_death(var2);
    var3 = undefined;

    if(level.gameskill == 0) {
      var3 = 2800;
    } else {
      var3 = 2200;
    }

    if(!isDefined(var0.no_attractor)) {
      var0.attractor = missile_createattractorent(var2, var3, 10000, level.player);
    }
  }

  var0 enableaimassist();
  var0.startingorigin = spawn("script_origin", var0.origin);
  var0 thread scripts\engine\utility::delete_on_death(var0.startingorigin);

  if(!isDefined(var0.circling)) {
    var0.circling = 0;
  }

  var0.allowshoot = 1;
  var0.firingmissiles = 0;
  var0.moving = 1;
  var0.istakingdamage = 0;
  var0.heli_lastattacker = undefined;
  thread notify_disable();
  thread notify_enable();
  thread kill_heli_logic(var0, var1);
  var0.turrettype = undefined;
  heli_default_target_setup(var0);
  thread detect_player_death();

  switch (var0.vehicletype) {
    case "hind_battle":
    case "ny_harbor_hind":
    case "hind_blackice":
    case "hind":
      var0.turrettype = "default";
      break;
    case "mi28":
    case "nh90":
    case "mi17":
      var0.turrettype = "default";
      break;
    case "apache":
      var0.turrettype = "default";
      break;
    case "littlebird_spotlight":
    case "littlebird":
      var0 setyawspeed(90, 30, 20);
      var0 setmaxpitchroll(40, 40);
      var0 sethoverparams(100, 20, 5);
      setup_miniguns(var0);
      break;
    default:
      break;
  }

  var0.etarget = var0.targetdefault;

  if(isDefined(var0.script_spotlight) && var0.script_spotlight == 1 && !isDefined(var0.spotlight)) {
    thread heli_spotlight_on(var0, undefined);
  }

  thread attack_heli_cleanup();
  return var0;
}

function detect_player_death() {
  foreach(var1 in level.players) {
    var1 scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "death");
  }

  scripts\engine\sp\utility::do_wait_any();
  self notify("heli_players_dead");
}

function heli_default_target_setup() {
  var0 = undefined;
  var1 = undefined;

  switch (self.vehicletype) {
    case "hind_battle":
    case "ny_harbor_hind":
    case "hind_blackice":
    case "hind":
      var1 = 600;
      var0 = -100;
      break;
    case "mi28":
    case "nh90":
    case "mi17":
      var1 = 600;
      var0 = -100;
      break;
    case "apache":
      var1 = 600;
      var0 = -100;
      break;
    case "littlebird_spotlight":
    case "littlebird":
      var1 = 600;
      var0 = -204;
      break;
    default:
      break;
  }

  self.targetdefault = spawn("script_origin", self.origin);
  self.targetdefault.angles = self.angles;
  self.targetdefault.origin = self.origin;
  var2 = spawnStruct();
  var2.entity = self.targetdefault;
  var2.forward = var1;
  var2.up = var0;
  var2 scripts\engine\sp\utility::translate_local();
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

function heli_default_target_cleanup(var0) {
  var0 scripts\engine\utility::waittill_either("death", "vehicle_crashDone");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function start_circling_heli(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "kill_heli";
  }

  var2 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive(var0);
  var2.startingorigin = spawn("script_origin", var2.origin);
  var2 thread scripts\engine\utility::delete_on_death(var2.startingorigin);
  var2.circling = 1;
  var2.allowshoot = 1;
  var2.firingmissiles = 0;
  thread notify_disable();
  thread notify_enable();
  thread kill_heli_logic(var2, var1);
  return var2;
}

function kill_heli_logic(var0, var1) {
  if(!isDefined(var0)) {
    var0 = scripts\common\vehicle::spawn_vehicle_from_targetname_and_drive("kill_heli");
    var0.allowshoot = 1;
    var0.firingmissiles = 0;
    thread notify_disable();
    thread notify_enable();
  }

  var2 = undefined;

  if(!isDefined(var0.script_airspeed)) {
    var2 = 40;
  } else {
    var2 = var0.script_airspeed;
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
  var3 = getEntArray("attack_heli_safe_volume", "script_noteworthy");

  if(var3.size > 0) {
    level.attack_heli_safe_volumes = var3;
  }

  if(!level.enemy_heli_killed) {
    thread dialog_nags_heli(var0);
  }

  if(!isDefined(var0.helicopter_predator_target_shader)) {
    switch (var0.vehicletype) {
      case "mi28":
      case "nh90":
      case "mi17":
        target_set(var0, (0, 0, -80));
        break;
      case "hind_battle":
      case "ny_harbor_hind":
      case "hind_blackice":
      case "hind":
        target_set(var0, (0, 0, -96));
        break;
      case "apache":
        target_set(var0, (0, 0, -96));
        break;
      case "littlebird_spotlight":
      case "littlebird":
        target_set(var0, (0, 0, -80));
        break;
      default:
        break;
    }

    target_setjavelinonly(var0, 1);
  }

  thread heli_damage_monitor();
  thread heli_death_monitor();
  var0 endon("death");
  var0 endon("heli_players_dead");
  var0 endon("returning_home");
  var0 setvehweapon("turret_attackheli");

  if(!isDefined(var0.circling)) {
    var0.circling = 0;
  }

  if(!var0.circling) {
    var0 setneargoalnotifydist(100);

    if(!isDefined(var0.dontwaitforpathend)) {
      var0 waittill("reached_dynamic_path_end");
    }
  } else {
    var0 setneargoalnotifydist(500);
    var0 waittill("near_goal");
  }

  thread heli_shoot_think();

  if(var0.circling) {
    thread heli_circling_think(var0, var1);
    return;
  }

  thread heli_goal_think(var0);
}

function heli_circling_think(var0, var1) {
  if(!isDefined(var0)) {
    var0 = "attack_heli_circle_node";
  }

  var2 = getEntArray(var0, "targetname");

  if(!isDefined(var2) || var2.size < 1) {
    var2 = scripts\engine\utility::getStructArray(var0, "targetname");
  }

  var3 = self;
  var3 endon("stop_circling");
  var3 endon("death");
  var3 endon("returning_home");
  var3 endon("heli_players_dead");

  for(;;) {
    var3 vehicle_setspeed(var1, var1 / 4, var1 / 4);
    var3 setneargoalnotifydist(100);
    var4 = level.player;
    var5 = var4.origin;
    var3 setlookatent(var4);
    var6 = scripts\engine\utility::getclosest(var5, var2);
    var7 = getEntArray(var6.target, "targetname");

    if(!isDefined(var7) || var7.size < 1) {
      var7 = scripts\engine\utility::getStructArray(var6.target, "targetname");
    }

    var8 = var7[randomint(var7.size)];
    var3 setvehgoalpos(var8.origin, 1);
    var3 waittill("near_goal");

    if(!isDefined(var4.is_controlling_uav)) {
      wait 1;
      wait randomfloatrange(0.8, 1.3);
    }
  }
}

function heli_goal_think(var0) {
  self endon("death");
  var1 = getEntArray("kill_heli_spot", "targetname");
  var2 = self;
  var3 = scripts\engine\utility::getclosest(var2.origin, var1);
  var4 = var3;
  var2 endon("death");
  var2 endon("returning_home");
  var2 endon("heli_players_dead");
  var5 = undefined;

  for(;;) {
    wait 0.05;
    var2 vehicle_setspeed(var0, var0 / 2, var0 / 10);
    var2 setneargoalnotifydist(100);
    var6 = level.player;
    var7 = var6.origin;

    if(var3 == var4 && var2.istakingdamage) {
      var8 = get_linked_points(var2, var3, var1, var6, var7);
      var3 = scripts\engine\utility::getclosest(var7, var8);
    }

    var2 setvehgoalpos(var3.origin, 1);
    var2.moving = 1;
    var6 = level.player;

    if(isDefined(self.etarget) && isDefined(self.etarget.classname) && self.etarget.classname == "script_origin") {
      var5 = var6;
    } else if(isDefined(self.etarget)) {
      var5 = self.etarget;
    } else {
      var5 = self.targetdefault;
    }

    var2 setlookatent(var5);
    var2 waittill("near_goal");
    var2.moving = 0;

    if(level.gameskill == 0 || level.gameskill == 1) {
      while(player_is_aiming_with_rocket(var2)) {
        wait 0.5;
      }

      wait 3;
    }

    var6 = level.player;
    var7 = var6.origin;
    var8 = get_linked_points(var2, var3, var1, var6, var7);
    var8 = var3;
    var4 = var3;
    var9 = scripts\engine\utility::getclosest(var7, var1);
    var10 = scripts\engine\utility::getclosest(var7, var8);

    foreach(var12 in var8) {
      if(var6 sightconetrace(var12.origin, var2) != 1) {
        var8 = scripts\engine\utility::array_remove(var8, var12);
      }
    }

    var14 = scripts\engine\utility::getclosest(var7, var8);

    if(var8.size < 2) {
      var3 = var10;
    } else if(var14 != var9) {
      var3 = var14;
    } else {
      var15 = [];
      GscBinSkip0(0x2e, 0, var14);
    }

    var15 = randomfloatrange(level.attackhelimovetime - 0.5, level.attackhelimovetime + 0.5);
    scripts\engine\utility::waittill_notify_or_timeout("damage_by_player", var15);
  }
}

function player_is_aiming_with_rocket(var0) {
  if(!usingantiairweapon(level.player)) {
    return false;
  }

  if(!level.player adsButtonPressed()) {
    return false;
  }

  var1 = level.player getEye();

  if(sighttracepassed(var1, var0.origin, 0, level.player)) {
    return true;
  }

  return false;
}

function heli_shoot_think() {
  self endon("stop_shooting");
  self endon("death");
  self endon("heli_players_dead");
  thread heli_missiles_think();
  var0 = level.attackhelirange * level.attackhelirange;
  level.attackheligraceperiod = 0;

  while(isDefined(self)) {
    wait randomfloatrange(0.8, 1.3);

    if(!heli_has_target() || !heli_has_player_target()) {
      var1 = heli_get_target_player_only();

      if(isPlayer(var1)) {
        self.etarget = var1;
      }
    }

    if(heli_has_player_target()) {
      if(!heli_can_see_target() || level.attackheligraceperiod == 1) {
        var1 = heli_get_target_ai_only();
        self.etarget = var1;
      }
    }

    if(isDefined(self.heli_lastattacker) && isPlayer(self.heli_lastattacker)) {
      self.etarget = self.heli_lastattacker;
    } else if(!heli_has_target()) {
      var1 = heli_get_target_ai_only();
      self.etarget = var1;
    }

    if(!heli_has_target()) {
      continue;
    }

    if(is_hidden_from_heli(self.etarget, self)) {
      continue;
    }

    if(heli_has_target() && distancesquared(self.etarget.origin, self.origin) > var0) {
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

function player_grace_period(var0) {
  level notify("player_is_heli_target");
  level endon("player_is_heli_target");
  level.attackheligraceperiod = 1;
  var0 scripts\engine\utility::waittill_notify_or_timeout("damage_by_player", level.attackheliplayerbreak);
  level.attackheligraceperiod = 0;
}

function heli_can_see_target() {
  if(!isDefined(self.etarget)) {
    return 0;
  }

  var0 = self.etarget.origin + (0, 0, 32);

  if(isPlayer(self.etarget)) {
    var0 = self.etarget getEye();
  }

  var1 = self gettagorigin("tag_flash");
  var2 = sighttracepassed(var1, var0, 0, self);
  return var2;
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
  var0 = scripts\sp\helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 1, 0, 1, level.attackheliexcluders);

  if(isDefined(var0) && isPlayer(var0)) {
    var0 = self.targetdefault;
  }

  if(!isDefined(var0)) {
    var0 = self.targetdefault;
  }

  return var0;
}

function heli_get_target_player_only() {
  var0 = getaiarray("allies");
  var1 = scripts\sp\helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 0, 0, 0, var0);

  if(!isDefined(var1)) {
    var1 = self.targetdefault;
  }

  return var1;
}

function heli_get_target_ai_only() {
  var0 = scripts\sp\helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 1, 0, 1, level.players);

  if(!isDefined(var0)) {
    var0 = self.targetdefault;
  }

  return var0;
}

function heli_missiles_think() {
  if(!isDefined(self.script_missiles)) {
    return;
  }

  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_shooting");
  var0 = undefined;
  var1 = "turret_attackheli";
  var2 = "missile_attackheli";
  var3 = undefined;
  var4 = undefined;
  var5 = [];

  switch (self.vehicletype) {
    case "mi28":
      var0 = 1;
      var3 = 1;
      var4 = 0.5;
      GscBinSkip0(0x2e, 0, "tag_store_L_2_a");

    case "littlebird":
    case "apache":
      var0 = 1;
      var3 = 1;
      var4 = 0.5;
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    default:
      break;
  }

  var6 = -1;

  for(;;) {
    wait 0.05;
    self waittill("fire_missiles", var7);

    if(!isPlayer(var7)) {
      continue;
    }

    var8 = var7;

    if(!player_is_good_missile_target(var8)) {
      continue;
    }

    for(var9 = 0; var9 < var0; var9++) {
      var6++;

      if(var6 >= var5.size) {
        var6 = 0;
      }

      self setvehweapon(var2);
      self.firingmissiles = 1;
      var10 = self fireweapon(var5[var6], var8);
      thread missilelosetarget(var10);
      thread missile_earthquake();

      if(var9 < var0 - 1) {
        wait var3;
      }
    }

    self.firingmissiles = 0;
    self setvehweapon(var1);
    wait 10;
  }
}

function player_is_good_missile_target(var0) {
  if(self.moving) {
    return 0;
  }

  return 1;
}

function missile_earthquake() {
  if(distancesquared(self.origin, level.player.origin) > 9000000) {
    return;
  }

  var0 = self.origin;

  while(isDefined(self)) {
    var0 = self.origin;
    wait 0.1;
  }

  earthquake(0.7, 1.5, var0, 1600);
}

function missilelosetarget(var0) {
  self endon("death");
  self endon("heli_players_dead");
  wait var0;

  if(isDefined(self)) {
    self missile_cleartarget();
    return;
  }
}

function get_different_player(var0) {
  for(var1 = 0; var1 < level.players.size; var1++) {
    if(var0 != level.players[var1]) {
      return level.players[var1];
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
      var0 = randomintrange(5, 10);
      var1 = weaponfiretime("turret_attackheli");
      turret_default_fire(self.etarget, var0, var1);
      break;
    case "miniguns":
      var0 = getburstsize(self.etarget);

      if(self.allowshoot && !self.firingmissiles) {
        turret_minigun_fire(self.etarget, var0);
      }

      break;
    default:
      break;
  }
}

function getburstsize(var0) {
  var1 = undefined;

  if(!isPlayer(var0)) {
    var1 = level.attackheliaiburstsize;
    return var1;
  }

  switch (level.gameskill) {
    case 3:
    case 2:
    case 1:
    case 0:
      var1 = randomintrange(2, 3);
      break;
  }

  return var1;
}

function fire_missiles(var0) {
  self endon("death");
  self endon("heli_players_dead");
  wait var0;

  if(!isPlayer(self.etarget)) {
    return;
  }

  self notify("fire_missiles", self.etarget);
}

function turret_default_fire(var0, var1, var2) {
  thread fire_missiles(randomfloatrange(0.2, 2));

  for(var3 = 0; var3 < var1; var3++) {
    self setturrettargetEnt(var0, scripts\engine\utility::randomvector(50) + (0, 0, 32));

    if(self.allowshoot && !self.firingmissiles) {
      self fireweapon();
    }

    wait var2;
  }
}

function turret_minigun_fire(var0, var1, var2) {
  self endon("death");
  self endon("heli_players_dead");
  self notify("firing_miniguns");
  self endon("firing_miniguns");
  var3 = get_turrets();
  scripts\engine\utility::array_thread(var3, &turret_minigun_target_track, var0, self);

  if(!self.minigunsspinning) {
    self.firingguns = 1;
    thread scripts\engine\sp\utility::play_sound_on_tag("littlebird_gatling_spinup", "tag_flash");
    wait 2.1;
    thread scripts\engine\sp\utility::play_loop_sound_on_tag("littlebird_minigun_spinloop", "tag_flash");
  }

  self.minigunsspinning = 1;

  if(!isDefined(var2)) {
    var2 = 3;
  }

  var4 = 0.5;

  if(var4 > var2) {
    var4 = var2;
  }

  if(var4 > 0) {
    wait randomfloatrange(var4, var2);
  }

  minigun_fire(var0, var1);
  var3 = get_turrets();
  scripts\engine\utility::array_call(var3, &stopfiring);
  thread minigun_spindown(var0);
  self notify("stopping_firing");
}

function minigun_fire(var0, var1) {
  self endon("death");
  self endon("heli_players_dead");

  if(isPlayer(var0)) {
    self endon("cant_see_player");
  }

  var2 = get_turrets();
  scripts\engine\utility::array_call(var2, &startfiring);
  wait randomfloatrange(1, 2);

  if(isPlayer(var0)) {
    thread target_track(var0);
  }

  if(isPlayer(var0)) {
    var3 = randomfloatrange(0.5, 3);
    thread fire_missiles(var3);
  }

  wait var1;
}

function target_track(var0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stopping_firing");
  self notify("tracking_player");
  self endon("tracking_player");

  for(;;) {
    if(!can_see_player(var0)) {
      break;
    }

    wait 0.5;
  }

  wait level.attackhelitimeout;
  self notify("cant_see_player");
}

function turret_minigun_target_track(var0, var1) {
  var1 endon("death");
  var1 endon("heli_players_dead");
  self notify("miniguns_have_new_target");
  self endon("miniguns_have_new_target");

  if(!isPlayer(var0) && isai(var0) && level.attackhelikillsai == 0) {
    var2 = spawn("script_origin", var0.origin + (0, 0, 100));
    var2 linkTo(var0);
    thread minigun_ai_target_cleanup(var2);
    var0 = var2;
  }

  for(;;) {
    wait 0.5;
    self settargetentity(var0);
  }
}

function minigun_ai_target_cleanup(var0) {
  scripts\engine\utility::waittill_either("death", "miniguns_have_new_target");
  var0 delete();
}

function minigun_spindown(var0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("firing_miniguns");

  if(isPlayer(var0)) {
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

function miss_player(var0) {
  var1 = anglesToForward(level.player.angles);
  var2 = var1 * 400;
  var3 = var2 + scripts\engine\utility::randomvector(50);
  var4 = randomintrange(10, 20);
  var5 = weaponfiretime("turret_attackheli");

  for(var6 = 0; var6 < var4; var6++) {
    var3 = var2 + scripts\engine\utility::randomvector(50);
    self setturrettargetEnt(var0, var3);

    if(self.allowshoot) {
      self fireweapon();
    }

    wait var5;
  }
}

function can_see_player(var0) {
  self endon("death");
  self endon("heli_players_dead");
  var1 = self gettagorigin("tag_flash");
  var2 = (0, 0, 0);

  if(isPlayer(var0)) {
    var2 = var0 getEye();
  } else {
    var2 = var0.origin;
  }

  if(sighttracepassed(var1, var2, 0, undefined)) {
    return 1;
  }

  return 0;
}

function get_linked_points(var0, var1, var2, var3, var4) {
  var5 = [];
  var6 = strtok(var1.script_linkto, " ");

  for(var7 = 0; var7 < var2.size; var7++) {
    for(var8 = 0; var8 < var6.size; var8++) {
      if(var2[var7].script_linkname == var6[var8]) {
        var5 = var2[var7];
      }
    }
  }

  foreach(var10 in var5) {
    if(var10.origin[2] < var4[2]) {
      var5 = scripts\engine\utility::array_remove(var5, var10);
    }
  }

  return var5;
}

function heli_damage_monitor() {
  self endon("death");
  self endon("heli_players_dead");
  self endon("crashing");
  self endon("leaving");
  self.damagetaken = 0;
  self.seen_attacker = undefined;

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4);

    if(!isDefined(var1) || !isPlayer(var1)) {
      continue;
    }

    self notify("damage_by_player");
    thread heli_damage_update();
    thread can_see_attacker_for_a_bit(var1);

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

function can_see_attacker_for_a_bit(var0) {
  self notify("attacker_seen");
  self endon("attacker_seen");
  self.seen_attacker = var0;
  self.heli_lastattacker = var0;
  wait level.attackhelimemory;
  self.heli_lastattacker = undefined;
  self.seen_attacker = undefined;
}

function is_hidden_from_heli(var0) {
  if(isDefined(var0.seen_attacker)) {
    if(var0.seen_attacker == self) {
      return false;
    }
  }

  if(isDefined(level.attack_heli_safe_volumes)) {
    foreach(var2 in level.attack_heli_safe_volumes) {
      if(self istouching(var2)) {
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
  for(var0 = 0; var0 < level.players.size; var0++) {
    var1 = level.players[var0];
    var1.hud_damagefeedback = newclienthudelem(var1);
    var1.hud_damagefeedback.horzalign = "center";
    var1.hud_damagefeedback.vertalign = "middle";
    var1.hud_damagefeedback.x = -12;
    var1.hud_damagefeedback.y = -12;
    var1.hud_damagefeedback.alpha = 0;
    var1.hud_damagefeedback.archived = 1;
    var1.hud_damagefeedback setshader("damage_feedback", 24, 48);
  }
}

function heli_death_monitor() {
  self waittill("death");
  level notify("attack_heli_destroyed");
  level.enemy_heli_killed = 1;
  wait 15;
  level.enemy_heli_attacking = 0;
}

function dialog_nags_heli(var0) {
  var0 endon("death");
  var0 endon("heli_players_dead");
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

function commander_dialog(var0) {
  while(level.commander_speaking) {
    wait 1;
  }

  level.commander_speaking = 1;
  level.player playSound(var0, "sounddone");
  level.player waittill("sounddone");
  wait 0.5;
  level.commander_speaking = 0;
}

function usingantiairweapon() {
  var0 = self getcurrentweapon();

  if(!isDefined(var0)) {
    return false;
  }

  var1 = tolower(var0.basename);

  if(issubstr(var1, "rpg")) {
    return true;
  }

  if(issubstr(var1, "stinger")) {
    return true;
  }

  if(issubstr(var1, "at4")) {
    return true;
  }

  return false;
}

function heli_spotlight_cleanup(var0) {
  scripts\engine\utility::waittill_any("death", "vehicle_crashDone", "turn_off_spotlight");
  self.spotlight = undefined;

  if(isDefined(self)) {
    stopFXOnTag(scripts\engine\utility::getfx("_attack_heli_spotlight"), self, var0);
    return;
  }
}

function heli_spotlight_create_default_targets(var0) {
  self endon("death");
  self endon("heli_players_dead");
  var1 = self.targetdefault;

  if(isDefined(var0)) {
    var1 = var0;
  }

  var1.targetname = "original_ent";
  self.left_ent = spawn("script_origin", var1.origin);
  self.left_ent.origin = var1.origin;
  self.left_ent.angles = var1.angles;
  self.left_ent.targetname = "left_ent";
  self.right_ent = spawn("script_origin", var1.origin);
  self.right_ent.origin = var1.origin;
  self.right_ent.angles = var1.angles;
  self.right_ent.targetname = "right_ent";
  var2 = spawnStruct();
  var2.entity = self.left_ent;
  var2.right = 250;
  var2 scripts\engine\sp\utility::translate_local();
  self.left_ent linkTo(self);
  var3 = spawnStruct();
  var3.entity = self.right_ent;
  var3.right = -250;
  var3 scripts\engine\sp\utility::translate_local();
  self.right_ent linkTo(self);
  var4 = [];
  GscBinSkip0(0x2e, 0, var1);
}

function heli_spotlight_destroy_default_targets() {
  if(isDefined(level.spotlight_aim_ents)) {
    foreach(var1 in level.spotlight_aim_ents) {
      if(isDefined(var1)) {
        var1 delete();
      }
    }

    return;
  }
}

function heli_spotlight_aim(var0) {
  self endon("death");
  self endon("heli_players_dead");

  if(self.vehicletype != "littlebird") {
    return;
  }

  thread heli_spotlight_think(var0);
  var1 = undefined;

  for(;;) {
    wait 0.05;

    switch (self.vehicletype) {
      case "littlebird_spotlight":
      case "littlebird":
        var1 = self.spottarget;
        break;
      default:
        var1 = self.etarget;
        break;
    }

    if(isDefined(var1)) {
      self setturrettargetEnt(var1, (0, 0, 0));
    }
  }
}

function heli_spotlight_think(var0) {
  self endon("death");
  self endon("heli_players_dead");
  heli_spotlight_create_default_targets();
  scripts\engine\utility::array_thread(level.spotlight_aim_ents, &heli_spotlight_aim_ents_cleanup, self);

  if(isDefined(var0)) {
    self thread[[var0]]();
    return;
  }

  for(;;) {
    wait randomfloatrange(1, 3);

    if(heli_has_player_target() && !within_player_fov()) {
      self.spottarget = self.etarget;
      continue;
    }

    var1 = randomint(level.spotlight_aim_ents.size);
    self.targetdefault = level.spotlight_aim_ents[var1];
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

  var0 = self.etarget;
  var1 = scripts\engine\utility::within_fov(var0 getEye(), var0 getplayerangles(), self.origin, level.cosine["35"]);
  return var1;
}

function heli_spotlight_aim_ents_cleanup(var0) {
  var0 scripts\engine\utility::waittill_either("death", "vehicle_crashDone");

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function littlebird_turrets_think(var0) {
  var1 = self;
  var1 scripts\common\vehicle_code::turret_set_default_on_mode("manual");

  if(isDefined(var0.targetdefault)) {
    var1 settargetentity(var0.targetdefault);
  }

  var1 setmode("manual");
  var0 waittill("death");

  if(isDefined(var0.firingguns) && var0.firingguns == 1) {
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

function heli_default_missiles_on(var0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_default_heli_missiles");
  self.preferredtarget = undefined;

  while(isDefined(self)) {
    wait 0.05;
    var1 = undefined;
    var2 = undefined;
    var3 = undefined;
    self.preferredtarget = undefined;
    var4 = undefined;

    if(isDefined(self.currentnode) && isDefined(self.currentnode.target)) {
      var4 = scripts\engine\utility::getent_or_struct(self.currentnode.target, "targetname");
    }

    if(isDefined(var4) && isDefined(var4.script_linkto)) {
      self.preferredtarget = scripts\engine\utility::getent_or_struct(var4.script_linkto, "script_linkname");
    }

    if(isDefined(self.preferredtarget)) {
      var1 = self.preferredtarget;
      var2 = var1.script_shotcount;
      var3 = var1.script_delay;
      var4 waittill("trigger");
    } else {
      scripts\engine\utility::waittill_any("near_goal", "goal");
    }

    if(isDefined(var1)) {
      thread heli_fire_missiles(var1, var2, var3, var0);
    }
  }
}

function heli_default_missiles_off() {
  self notify("stop_default_heli_missiles");
}

function heli_spotlight_on(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = "tag_barrel";
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  playFXOnTag(scripts\engine\utility::getfx("_attack_heli_spotlight"), self, var0);
  self.spotlight = 1;
  thread heli_spotlight_cleanup(var0);

  if(var2) {
    self setturrettargetEnt(level.player);
    return;
  }

  if(var1) {
    self endon("death");
    self endon("heli_players_dead");
    var3 = self gettagorigin("tag_origin");

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

function heli_fire_missiles(var0, var1, var2, var3) {
  self endon("death");
  self endon("heli_players_dead");

  if(isDefined(self.defaultweapon)) {
    var4 = self.defaultweapon;
  } else {
    var4 = "turret_attackheli";
  }

  var5 = "missile_attackheli";

  if(isDefined(var4)) {
    var5 = var4;
  }

  var6 = undefined;
  var7 = [];
  self setvehweapon(var4);

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var1.classname)) {
    if(!isDefined(self.dummytarget)) {
      self.dummytarget = spawn("script_origin", var1.origin);
      thread scripts\engine\utility::delete_on_death(self.dummytarget);
    }

    self.dummytarget.origin = var1.origin;
    var1 = self.dummytarget;
  }

  switch (self.vehicletype) {
    case "mi28":
      var6 = 0.5;
      GscBinSkip0(0x2e, 0, "tag_store_L_2_a");

    case "littlebird":
    case "apache":
      var6 = 0.5;
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    case "hind_battle":
      GscBinSkip0(0x2e, 0, "tag_missile_left");

    default:
      break;
  }

  var8 = -1;

  for(var9 = 0; var9 < var2; var9++) {
    var8++;

    if(var8 >= var7.size) {
      var8 = 0;
    }

    self setvehweapon(var5);
    self.firingmissiles = 1;
    var10 = self fireweapon(var7[var8], var1);
    thread missile_earthquake();

    if(var9 < var2 - 1) {
      wait var3;
    }
  }

  self.firingmissiles = 0;
  self setvehweapon(var4);
}

function boneyard_style_heli_missile_attack() {
  self waittill("trigger", var0);
  var1 = scripts\engine\utility::getStructArray(self.target, "targetname");
  var1 = scripts\engine\sp\utility::array_index_by_script_index(var1);
  boneyard_fire_at_targets(var0, var1);
}

function boneyard_style_heli_missile_attack_linked() {
  self waittill("trigger", var0);
  var1 = scripts\engine\utility::get_linked_structs();
  var1 = scripts\engine\sp\utility::array_index_by_script_index(var1);
  boneyard_fire_at_targets(var0, var1);
}

function boneyard_fire_at_targets(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, 0, "tag_missile_right");
}