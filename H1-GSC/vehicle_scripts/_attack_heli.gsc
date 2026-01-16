/********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_attack_heli.gsc
********************************************/

preload() {
  precacheitem("turret_attackheli");
  precacheitem("missile_attackheli");
  attack_heli_fx();
  thread init();
}

attack_heli_fx() {
  if(getdvarint("sm_enable") && getdvar("r_zfeather") != "0")
    level._effect["_attack_heli_spotlight"] = loadfx("fx\misc\hunted_spotlight_model");
  else
    level._effect["_attack_heli_spotlight"] = loadfx("fx\misc\spotlight_large");
}

init() {
  if(isdefined(level.attackheliaiburstsize)) {
    return;
  }
  while (!isdefined(level.gameskill))
    wait 0.05;

  if(!isdefined(level.cosine))
    level.cosine = [];

  if(!isdefined(level.cosine["25"]))
    level.cosine["25"] = cos(25);

  if(!isdefined(level.cosine["35"]))
    level.cosine["35"] = cos(35);

  if(!isdefined(level.attackhelirange))
    level.attackhelirange = 3500;

  if(!isdefined(level.attackhelikillsai))
    level.attackhelikillsai = 0;

  if(!isdefined(level.attackhelifov))
    level.attackhelifov = cos(30);

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

start_attack_heli(var_0) {
  if(!isdefined(var_0))
    var_0 = "kill_heli";

  var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  var_1 = begin_attack_heli_behavior(var_1);
  return var_1;
}

begin_attack_heli_behavior(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("heli_players_dead");

  if(level.gameskill == 0 || level.gameskill == 1) {
    var_2 = spawn("script_origin", var_0.origin + (0, 0, -20));
    var_2 linkto(var_0);
    var_0 thread common_scripts\utility::delete_on_death(var_2);
    var_3 = undefined;

    if(level.gameskill == 0)
      var_3 = 2800;
    else
      var_3 = 2200;

    if(!isdefined(var_0.no_attractor)) {
      var_0.attractor = missile_createattractorent(var_2, var_3, 10000, level.player);

      if(maps\_utility::is_coop())
        var_0.attractor2 = missile_createattractorent(var_2, var_3, 10000, level.player2);
    }
  }

  var_0 enableaimassist();
  var_0.startingorigin = spawn("script_origin", var_0.origin);
  var_0 thread common_scripts\utility::delete_on_death(var_0.startingorigin);

  if(!isdefined(var_0.circling))
    var_0.circling = 0;

  var_0.allowshoot = 1;
  var_0.firingmissiles = 0;
  var_0.moving = 1;
  var_0.istakingdamage = 0;
  var_0.heli_lastattacker = undefined;
  var_0 thread notify_disable();
  var_0 thread notify_enable();
  thread kill_heli_logic(var_0, var_1);
  var_0.turrettype = undefined;
  var_0 heli_default_target_setup();
  var_0 thread detect_player_death();

  switch (var_0.vehicletype) {
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
      var_0 setup_miniguns();
      break;
    default:
      break;
  }

  var_0.etarget = var_0.targetdefault;

  if(isdefined(var_0.script_spotlight) && var_0.script_spotlight == 1 && !isdefined(var_0.spotlight))
    var_0 thread heli_spotlight_on(undefined, 1);

  var_0 thread attack_heli_cleanup();
  return var_0;
}

detect_player_death() {
  foreach(var_1 in level.players)
  var_1 maps\_utility::add_wait(maps\_utility::waittill_msg, "death");

  maps\_utility::do_wait_any();
  self notify("heli_players_dead");
}

heli_default_target_setup() {
  var_0 = undefined;
  var_1 = undefined;

  switch (self.vehicletype) {
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
  var_2 = spawnstruct();
  var_2.entity = self.targetdefault;
  var_2.forward = var_1;
  var_2.up = var_0;
  var_2 maps\_utility::translate_local();
  self.targetdefault linkto(self);
  self.targetdefault thread heli_default_target_cleanup(self);
}

get_turrets() {
  if(isdefined(self.turrets))
    return self.turrets;

  setup_miniguns();
  return self.turrets;
}

setup_miniguns() {
  self.turrettype = "miniguns";
  self.minigunsspinning = 0;
  self.firingguns = 0;

  if(!isdefined(self.mgturret)) {
    return;
  }
  self.turrets = self.mgturret;
  common_scripts\utility::array_thread(self.turrets, ::littlebird_turrets_think, self);
}

heli_default_target_cleanup(var_0) {
  var_0 common_scripts\utility::waittill_either("death", "crash_done");

  if(isdefined(self))
    self delete();
}

start_circling_heli(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = "kill_heli";

  var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(var_0);
  var_2.startingorigin = spawn("script_origin", var_2.origin);
  var_2 thread common_scripts\utility::delete_on_death(var_2.startingorigin);
  var_2.circling = 1;
  var_2.allowshoot = 1;
  var_2.firingmissiles = 0;
  var_2 thread notify_disable();
  var_2 thread notify_enable();
  thread kill_heli_logic(var_2, var_1);
  return var_2;
}

kill_heli_logic(var_0, var_1) {
  if(!isdefined(var_0)) {
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("kill_heli");
    var_0.allowshoot = 1;
    var_0.firingmissiles = 0;
    var_0 thread notify_disable();
    var_0 thread notify_enable();
  }

  var_2 = undefined;

  if(!isdefined(var_0.script_airspeed))
    var_2 = 40;
  else
    var_2 = var_0.script_airspeed;

  if(!isdefined(level.enemy_heli_killed))
    level.enemy_heli_killed = 0;

  if(!isdefined(level.commander_speaking))
    level.commander_speaking = 0;

  if(!isdefined(level.enemy_heli_attacking))
    level.enemy_heli_attacking = 0;

  level.attack_heli_safe_volumes = undefined;
  var_3 = getentarray("attack_heli_safe_volume", "script_noteworthy");

  if(var_3.size > 0)
    level.attack_heli_safe_volumes = var_3;

  if(!level.enemy_heli_killed)
    thread dialog_nags_heli(var_0);

  if(!isdefined(var_0.helicopter_predator_target_shader)) {
    switch (var_0.vehicletype) {
      case "mi28":
      case "nh90":
      case "mi17":
        target_set(var_0, (0, 0, -80));
        break;
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

  var_0 thread heli_damage_monitor();
  var_0 thread heli_death_monitor();
  var_0 endon("death");
  var_0 endon("heli_players_dead");
  var_0 endon("returning_home");
  var_0 setvehweapon("turret_attackheli");

  if(!isdefined(var_0.circling))
    var_0.circling = 0;

  if(!var_0.circling) {
    var_0 setneargoalnotifydist(100);

    if(!isdefined(var_0.dontwaitforpathend))
      var_0 waittill("reached_dynamic_path_end");
  } else {
    var_0 setneargoalnotifydist(500);
    var_0 waittill("near_goal");
  }

  var_0 thread heli_shoot_think();

  if(var_0.circling)
    var_0 thread heli_circling_think(var_1, var_2);
  else
    var_0 thread heli_goal_think(var_2);
}

heli_circling_think(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = "attack_heli_circle_node";

  var_2 = getentarray(var_0, "targetname");

  if(!isdefined(var_2) || var_2.size < 1)
    var_2 = common_scripts\utility::getstructarray(var_0, "targetname");

  var_3 = self;
  var_3 endon("stop_circling");
  var_3 endon("death");
  var_3 endon("returning_home");
  var_3 endon("heli_players_dead");

  for (;;) {
    var_3 vehicle_setspeed(var_1, var_1 / 4, var_1 / 4);
    var_3 setneargoalnotifydist(100);
    var_4 = maps\_utility::get_closest_player_healthy(var_3.origin);
    var_5 = var_4.origin;
    var_3 setlookatent(var_4);
    var_6 = common_scripts\utility::getclosest(var_5, var_2);
    var_7 = getentarray(var_6.target, "targetname");

    if(!isdefined(var_7) || var_7.size < 1)
      var_7 = common_scripts\utility::getstructarray(var_6.target, "targetname");

    var_8 = var_7[randomint(var_7.size)];
    var_3 setvehgoalpos(var_8.origin, 1);
    var_3 waittill("near_goal");

    if(!isdefined(var_4.is_controlling_uav)) {
      wait 1;
      wait(randomfloatrange(0.8, 1.3));
    }
  }
}

heli_goal_think(var_0) {
  self endon("death");
  var_1 = getentarray("kill_heli_spot", "targetname");
  var_2 = self;
  var_3 = common_scripts\utility::getclosest(var_2.origin, var_1);
  var_4 = var_3;
  var_2 endon("death");
  var_2 endon("returning_home");
  var_2 endon("heli_players_dead");
  var_5 = undefined;

  for (;;) {
    wait 0.05;
    var_2 vehicle_setspeed(var_0, var_0 / 2, var_0 / 10);
    var_2 setneargoalnotifydist(100);
    var_6 = maps\_utility::get_closest_player_healthy(var_2.origin);
    var_7 = var_6.origin;

    if(var_3 == var_4 && var_2.istakingdamage) {
      var_8 = get_linked_points(var_2, var_3, var_1, var_6, var_7);
      var_3 = common_scripts\utility::getclosest(var_7, var_8);
    }

    var_2 setvehgoalpos(var_3.origin, 1);
    var_2.moving = 1;
    var_6 = maps\_utility::get_closest_player_healthy(var_2.origin);

    if(isdefined(self.etarget) && isdefined(self.etarget.classname) && self.etarget.classname == "script_origin")
      var_5 = var_6;
    else if(isdefined(self.etarget))
      var_5 = self.etarget;
    else
      var_5 = self.targetdefault;

    var_2 setlookatent(var_5);
    var_2 waittill("near_goal");
    var_2.moving = 0;

    if(!maps\_utility::is_coop()) {
      if(level.gameskill == 0 || level.gameskill == 1) {
        while (player_is_aiming_with_rocket(var_2))
          wait 0.5;

        wait 3;
      }
    }

    var_6 = maps\_utility::get_closest_player_healthy(var_2.origin);
    var_7 = var_6.origin;
    var_8 = get_linked_points(var_2, var_3, var_1, var_6, var_7);
    var_8[var_8.size] = var_3;
    var_4 = var_3;
    var_9 = common_scripts\utility::getclosest(var_7, var_1);
    var_10 = common_scripts\utility::getclosest(var_7, var_8);

    foreach(var_12 in var_8) {
      if(var_6 sightconetrace(var_12.origin, var_2) != 1) {
        var_8 = common_scripts\utility::array_remove(var_8, var_12);
        continue;
      }
    }

    var_14 = common_scripts\utility::getclosest(var_7, var_8);

    if(var_8.size < 2)
      var_3 = var_10;
    else if(var_14 != var_9)
      var_3 = var_14;
    else {
      var_15 = [];
      var_15[0] = var_14;
      var_8 = common_scripts\utility::get_array_of_closest(var_7, var_8, var_15, 2);
      var_16 = randomint(var_8.size);

      if(randomint(100) > 50)
        var_3 = var_8[var_16];
      else
        var_3 = var_9;
    }

    var_17 = randomfloatrange(level.attackhelimovetime - 0.5, level.attackhelimovetime + 0.5);
    common_scripts\utility::waittill_notify_or_timeout("damage_by_player", var_17);
  }
}

player_is_aiming_with_rocket(var_0) {
  if(!level.player usingantiairweapon())
    return 0;

  if(!level.player adsbuttonpressed())
    return 0;

  var_1 = level.player geteye();

  if(sighttracepassed(var_1, var_0.origin, 0, level.player))
    return 1;

  return 0;
}

heli_shoot_think() {
  self endon("stop_shooting");
  self endon("death");
  self endon("heli_players_dead");
  thread heli_missiles_think();
  var_0 = level.attackhelirange * level.attackhelirange;
  level.attackheligraceperiod = 0;

  while (isdefined(self)) {
    wait(randomfloatrange(0.8, 1.3));

    if(!heli_has_target() || !heli_has_player_target()) {
      var_1 = heli_get_target_player_only();

      if(isplayer(var_1))
        self.etarget = var_1;
    }

    if(heli_has_player_target() && level.players.size > 1) {
      var_2 = maps\_utility::get_closest_player_healthy(self.origin);

      if(self.etarget != var_2) {
        var_1 = heli_get_target_player_only();

        if(isplayer(var_1))
          self.etarget = var_1;
      }
    }

    if(heli_has_player_target()) {
      if(!heli_can_see_target() || level.attackheligraceperiod == 1) {
        var_1 = heli_get_target_ai_only();
        self.etarget = var_1;
      }
    }

    if(isdefined(self.heli_lastattacker) && isplayer(self.heli_lastattacker))
      self.etarget = self.heli_lastattacker;
    else if(!heli_has_target()) {
      var_1 = heli_get_target_ai_only();
      self.etarget = var_1;
    }

    if(!heli_has_target()) {
      continue;
    }
    if(self.etarget is_hidden_from_heli(self)) {
      continue;
    }
    if(heli_has_target() && distancesquared(self.etarget.origin, self.origin) > var_0) {
      continue;
    }
    if(self.turrettype == "default" && heli_has_player_target()) {
      miss_player(self.etarget);
      wait(randomfloatrange(0.8, 1.3));
      miss_player(self.etarget);
      wait(randomfloatrange(0.8, 1.3));

      while (can_see_player(self.etarget) && !self.etarget is_hidden_from_heli(self)) {
        fire_guns();
        wait(randomfloatrange(2.0, 4.0));
      }

      continue;
    }

    if(isplayer(self.etarget) || isai(self.etarget))
      fire_guns();

    if(isplayer(self.etarget))
      thread player_grace_period(self);

    common_scripts\utility::waittill_notify_or_timeout("damage_by_player", level.attackhelitargetreaquire);
  }
}

player_grace_period(var_0) {
  level notify("player_is_heli_target");
  level endon("player_is_heli_target");
  level.attackheligraceperiod = 1;
  var_0 common_scripts\utility::waittill_notify_or_timeout("damage_by_player", level.attackheliplayerbreak);
  level.attackheligraceperiod = 0;
}

heli_can_see_target() {
  if(!isdefined(self.etarget))
    return 0;

  var_0 = self.etarget.origin + (0, 0, 32);

  if(isplayer(self.etarget))
    var_0 = self.etarget geteye();

  var_1 = self gettagorigin("tag_flash");
  var_2 = sighttracepassed(var_1, var_0, 0, self);
  return var_2;
}

heli_has_player_target() {
  if(!isdefined(self.etarget))
    return 0;

  if(isplayer(self.etarget))
    return 1;
  else
    return 0;
}

heli_has_target() {
  if(!isdefined(self.etarget))
    return 0;

  if(!isalive(self.etarget))
    return 0;

  if(self.etarget == self.targetdefault)
    return 0;
  else
    return 1;
}

heli_get_target() {
  var_0 = maps\_helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 1, 0, 1, level.attackheliexcluders);

  if(isdefined(var_0) && isplayer(var_0))
    var_0 = self.targetdefault;

  if(!isdefined(var_0))
    var_0 = self.targetdefault;

  return var_0;
}

heli_get_target_player_only() {
  var_0 = getaiarray("allies");
  var_1 = maps\_helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 0, 0, 0, var_0);

  if(!isdefined(var_1))
    var_1 = self.targetdefault;

  return var_1;
}

heli_get_target_ai_only() {
  var_0 = maps\_helicopter_globals::getenemytarget(level.attackhelirange, level.attackhelifov, 1, 1, 0, 1, level.players);

  if(!isdefined(var_0))
    var_0 = self.targetdefault;

  return var_0;
}

heli_missiles_think() {
  if(!isdefined(self.script_missiles)) {
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
      var_5[0] = "tag_store_L_2_a";
      var_5[1] = "tag_store_R_2_a";
      var_5[2] = "tag_store_L_2_b";
      var_5[3] = "tag_store_R_2_b";
      var_5[4] = "tag_store_L_2_c";
      var_5[5] = "tag_store_R_2_c";
      var_5[6] = "tag_store_L_2_d";
      var_5[7] = "tag_store_R_2_d";
      break;
    case "littlebird":
    case "apache":
      var_0 = 1;
      var_3 = 1;
      var_4 = 0.5;
      var_5[0] = "tag_missile_left";
      var_5[1] = "tag_missile_right";
      break;
    default:
      break;
  }

  var_6 = -1;

  for (;;) {
    wait 0.05;
    self waittill("fire_missiles", var_7);

    if(!isplayer(var_7)) {
      continue;
    }
    var_8 = var_7;

    if(!player_is_good_missile_target(var_8)) {
      continue;
    }
    for (var_9 = 0; var_9 < var_0; var_9++) {
      var_6++;

      if(var_6 >= var_5.size)
        var_6 = 0;

      self setvehweapon(var_2);
      self.firingmissiles = 1;
      var_10 = self fireweapon(var_5[var_6], var_8);
      var_10 thread missilelosetarget(var_4);
      var_10 thread missile_earthquake();

      if(var_9 < var_0 - 1)
        wait(var_3);
    }

    self.firingmissiles = 0;
    self setvehweapon(var_1);
    wait 10;
  }
}

player_is_good_missile_target(var_0) {
  if(self.moving)
    return 0;
  else
    return 1;
}

missile_earthquake() {
  if(distancesquared(self.origin, level.player.origin) > 9000000) {
    return;
  }
  var_0 = self.origin;

  while (isdefined(self)) {
    var_0 = self.origin;
    wait 0.1;
  }

  earthquake(0.7, 1.5, var_0, 1600);
}

missilelosetarget(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  wait(var_0);

  if(isdefined(self))
    self missile_cleartarget();
}

get_different_player(var_0) {
  for (var_1 = 0; var_1 < level.players.size; var_1++) {
    if(var_0 != level.players[var_1])
      return level.players[var_1];
  }

  return level.players[0];
}

notify_disable() {
  self notify("notify_disable_thread");
  self endon("notify_disable_thread");
  self endon("death");
  self endon("heli_players_dead");

  for (;;) {
    self waittill("disable_turret");
    self.allowshoot = 0;
  }
}

notify_enable() {
  self notify("notify_enable_thread");
  self endon("notify_enable_thread");
  self endon("death");
  self endon("heli_players_dead");

  for (;;) {
    self waittill("enable_turret");
    self.allowshoot = 1;
  }
}

fire_guns() {
  switch (self.turrettype) {
    case "default":
      var_0 = randomintrange(5, 10);
      var_1 = weaponfiretime("turret_attackheli");
      turret_default_fire(self.etarget, var_0, var_1);
      break;
    case "miniguns":
      var_0 = getburstsize(self.etarget);

      if(self.allowshoot && !self.firingmissiles)
        turret_minigun_fire(self.etarget, var_0);

      break;
    default:
      break;
  }
}

getburstsize(var_0) {
  var_1 = undefined;

  if(!isplayer(var_0)) {
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

fire_missiles(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  wait(var_0);

  if(!isplayer(self.etarget)) {
    return;
  }
  self notify("fire_missiles", self.etarget);
}

turret_default_fire(var_0, var_1, var_2) {
  thread fire_missiles(randomfloatrange(0.2, 2));

  for (var_3 = 0; var_3 < var_1; var_3++) {
    self setturrettargetent(var_0, common_scripts\utility::randomvector(50) + (0, 0, 32));

    if(self.allowshoot && !self.firingmissiles)
      self fireweapon();

    wait(var_2);
  }
}

turret_minigun_fire(var_0, var_1, var_2) {
  self endon("death");
  self endon("heli_players_dead");
  self notify("firing_miniguns");
  self endon("firing_miniguns");
  var_3 = get_turrets();
  common_scripts\utility::array_thread(var_3, ::turret_minigun_target_track, var_0, self);

  if(!self.minigunsspinning) {
    self.firingguns = 1;
    thread maps\_utility::play_sound_on_tag("littlebird_gatling_spinup", "tag_flash");
    wait 2.1;
    thread maps\_utility::play_loop_sound_on_tag("littlebird_minigun_spinloop", "tag_flash");
  }

  self.minigunsspinning = 1;

  if(!isdefined(var_2))
    var_2 = 3;

  var_4 = 0.5;

  if(var_4 > var_2)
    var_4 = var_2;

  if(var_4 > 0)
    wait(randomfloatrange(var_4, var_2));

  minigun_fire(var_0, var_1);
  var_3 = get_turrets();
  common_scripts\utility::array_call(var_3, ::stopfiring);
  thread minigun_spindown(var_0);
  self notify("stopping_firing");
}

minigun_fire(var_0, var_1) {
  self endon("death");
  self endon("heli_players_dead");

  if(isplayer(var_0))
    self endon("cant_see_player");

  var_2 = get_turrets();
  common_scripts\utility::array_call(var_2, ::startfiring);
  wait(randomfloatrange(1, 2));

  if(isplayer(var_0))
    thread target_track(var_0);

  if(isplayer(var_0)) {
    var_3 = randomfloatrange(0.5, 3);
    thread fire_missiles(var_3);
  }

  wait(var_1);
}

target_track(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stopping_firing");
  self notify("tracking_player");
  self endon("tracking_player");

  for (;;) {
    if(!can_see_player(var_0)) {
      break;
    }

    wait 0.5;
  }

  wait(level.attackhelitimeout);
  self notify("cant_see_player");
}

turret_minigun_target_track(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("heli_players_dead");
  self notify("miniguns_have_new_target");
  self endon("miniguns_have_new_target");

  if(!isplayer(var_0) && isai(var_0) && level.attackhelikillsai == 0) {
    var_2 = spawn("script_origin", var_0.origin + (0, 0, 100));
    var_2 linkto(var_0);
    thread minigun_ai_target_cleanup(var_2);
    var_0 = var_2;
  }

  for (;;) {
    wait 0.5;
    self settargetentity(var_0);
  }
}

minigun_ai_target_cleanup(var_0) {
  common_scripts\utility::waittill_either("death", "miniguns_have_new_target");
  var_0 delete();
}

minigun_spindown(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("firing_miniguns");

  if(isplayer(var_0))
    wait(randomfloatrange(3, 4));
  else
    wait(randomfloatrange(1, 2));

  thread minigun_spindown_sound();
  self.firingguns = 0;
}

minigun_spindown_sound() {
  self notify("stop soundlittlebird_minigun_spinloop");
  self.minigunsspinning = 0;
  maps\_utility::play_sound_on_tag("littlebird_gatling_cooldown", "tag_flash");
}

miss_player(var_0) {
  var_1 = anglestoforward(level.player.angles);
  var_2 = var_1 * 400;
  var_3 = var_2 + common_scripts\utility::randomvector(50);
  var_4 = randomintrange(10, 20);
  var_5 = weaponfiretime("turret_attackheli");

  for (var_6 = 0; var_6 < var_4; var_6++) {
    var_3 = var_2 + common_scripts\utility::randomvector(50);
    self setturrettargetent(var_0, var_3);

    if(self.allowshoot)
      self fireweapon();

    wait(var_5);
  }
}

can_see_player(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  var_1 = self gettagorigin("tag_flash");
  var_2 = (0, 0, 0);

  if(isplayer(var_0))
    var_2 = var_0 geteye();
  else
    var_2 = var_0.origin;

  if(sighttracepassed(var_1, var_2, 0, undefined))
    return 1;
  else
    return 0;
}

get_linked_points(var_0, var_1, var_2, var_3, var_4) {
  var_5 = [];
  var_6 = strtok(var_1.script_linkto, " ");

  for (var_7 = 0; var_7 < var_2.size; var_7++) {
    for (var_8 = 0; var_8 < var_6.size; var_8++) {
      if(var_2[var_7].script_linkname == var_6[var_8])
        var_5[var_5.size] = var_2[var_7];
    }
  }

  foreach(var_10 in var_5) {
    if(var_10.origin[2] < var_4[2]) {
      var_5 = common_scripts\utility::array_remove(var_5, var_10);
      continue;
    }
  }

  return var_5;
}

heli_damage_monitor() {
  self endon("death");
  self endon("heli_players_dead");
  self endon("crashing");
  self endon("leaving");
  self.damagetaken = 0;
  self.seen_attacker = undefined;

  for (;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isdefined(var_1) || !isplayer(var_1)) {
      continue;
    }
    self notify("damage_by_player");
    thread heli_damage_update();
    thread can_see_attacker_for_a_bit(var_1);

    if(maps\_utility::is_damagefeedback_hud_enabled())
      var_1 thread updatedamagefeedbackhud();

    if(maps\_utility::is_damagefeedback_snd_enabled())
      var_1 thread updatedamagefeedbacksnd();
  }
}

heli_damage_update() {
  self notify("taking damage");
  self endon("taking damage");
  self endon("death");
  self endon("heli_players_dead");
  self.istakingdamage = 1;
  wait 1;
  self.istakingdamage = 0;
}

can_see_attacker_for_a_bit(var_0) {
  self notify("attacker_seen");
  self endon("attacker_seen");
  self.seen_attacker = var_0;
  self.heli_lastattacker = var_0;
  wait(level.attackhelimemory);
  self.heli_lastattacker = undefined;
  self.seen_attacker = undefined;
}

is_hidden_from_heli(var_0) {
  if(isdefined(var_0.seen_attacker)) {
    if(var_0.seen_attacker == self)
      return 0;
  }

  if(isdefined(level.attack_heli_safe_volumes)) {
    foreach(var_2 in level.attack_heli_safe_volumes) {
      if(self istouching(var_2))
        return 1;
    }
  }

  return 0;
}

updatedamagefeedbackhud() {
  if(!isplayer(self)) {
    return;
  }
  self.hud_damagefeedback setshader("damage_feedback", 24, 48);
  self.hud_damagefeedback.alpha = 1;
  self.hud_damagefeedback fadeovertime(1);
  self.hud_damagefeedback.alpha = 0;
}

updatedamagefeedbacksnd() {
  if(!isplayer(self)) {
    return;
  }
  self playlocalsound("player_feedback_hit_alert");
}

damage_feedback_setup() {
  for (var_0 = 0; var_0 < level.players.size; var_0++) {
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

heli_death_monitor() {
  self waittill("death");
  level notify("attack_heli_destroyed");
  level.enemy_heli_killed = 1;
  wait 15;
  level.enemy_heli_attacking = 0;
}

dialog_nags_heli(var_0) {
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

commander_dialog(var_0) {
  while (level.commander_speaking)
    wait 1;

  level.commander_speaking = 1;
  level.player playsound(var_0, "sounddone");
  level.player waittill("sounddone");
  wait 0.5;
  level.commander_speaking = 0;
}

usingantiairweapon() {
  var_0 = self getcurrentweapon();

  if(!isdefined(var_0))
    return 0;

  if(issubstr(tolower(var_0), "rpg"))
    return 1;

  if(issubstr(tolower(var_0), "stinger"))
    return 1;

  if(issubstr(tolower(var_0), "at4"))
    return 1;

  return 0;
}

heli_spotlight_cleanup(var_0) {
  common_scripts\utility::waittill_any("death", "crash_done", "turn_off_spotlight");
  self.spotlight = undefined;

  if(isdefined(self))
    stopfxontag(common_scripts\utility::getfx("_attack_heli_spotlight"), self, var_0);
}

heli_spotlight_create_default_targets(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  var_1 = self.targetdefault;

  if(isdefined(var_0))
    var_1 = var_0;

  var_1.targetname = "original_ent";
  self.left_ent = spawn("script_origin", var_1.origin);
  self.left_ent.origin = var_1.origin;
  self.left_ent.angles = var_1.angles;
  self.left_ent.targetname = "left_ent";
  self.right_ent = spawn("script_origin", var_1.origin);
  self.right_ent.origin = var_1.origin;
  self.right_ent.angles = var_1.angles;
  self.right_ent.targetname = "right_ent";
  var_2 = spawnstruct();
  var_2.entity = self.left_ent;
  var_2.right = 250;
  var_2 maps\_utility::translate_local();
  self.left_ent linkto(self);
  var_3 = spawnstruct();
  var_3.entity = self.right_ent;
  var_3.right = -250;
  var_3 maps\_utility::translate_local();
  self.right_ent linkto(self);
  var_4 = [];
  var_4[0] = var_1;
  var_4[1] = self.left_ent;
  var_4[2] = self.right_ent;
  level.spotlight_aim_ents = var_4;
  self.spottarget = var_1;
}

heli_spotlight_destroy_default_targets() {
  if(isdefined(level.spotlight_aim_ents)) {
    foreach(var_1 in level.spotlight_aim_ents) {
      if(isdefined(var_1))
        var_1 delete();
    }
  }
}

heli_spotlight_aim(var_0) {
  self endon("death");
  self endon("heli_players_dead");

  if(self.vehicletype != "littlebird") {
    return;
  }
  thread heli_spotlight_think(var_0);
  var_1 = undefined;

  for (;;) {
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

    if(isdefined(var_1))
      self setturrettargetent(var_1, (0, 0, 0));
  }
}

heli_spotlight_think(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  heli_spotlight_create_default_targets();
  common_scripts\utility::array_thread(level.spotlight_aim_ents, ::heli_spotlight_aim_ents_cleanup, self);

  if(isdefined(var_0))
    self thread[[var_0]]();
  else {
    for (;;) {
      wait(randomfloatrange(1, 3));

      if(heli_has_player_target() && !within_player_fov()) {
        self.spottarget = self.etarget;
        continue;
      }

      var_1 = randomint(level.spotlight_aim_ents.size);
      self.targetdefault = level.spotlight_aim_ents[var_1];
      self.spottarget = self.targetdefault;
    }
  }
}

within_player_fov() {
  self endon("death");
  self endon("heli_players_dead");

  if(!isdefined(self.etarget))
    return 0;

  if(!isplayer(self.etarget))
    return 0;

  var_0 = self.etarget;
  var_1 = common_scripts\utility::within_fov(var_0 geteye(), var_0 getplayerangles(), self.origin, level.cosine["35"]);
  return var_1;
}

heli_spotlight_aim_ents_cleanup(var_0) {
  var_0 common_scripts\utility::waittill_either("death", "crash_done");

  if(isdefined(self))
    self delete();
}

littlebird_turrets_think(var_0) {
  var_1 = self;
  var_1 maps\_vehicle_code::turret_set_default_on_mode("manual");

  if(isdefined(var_0.targetdefault))
    var_1 settargetentity(var_0.targetdefault);

  var_1 setmode("manual");
  var_0 waittill("death");

  if(isdefined(var_0.firingguns) && var_0.firingguns == 1)
    thread minigun_spindown_sound();
}

attack_heli_cleanup() {
  common_scripts\utility::waittill_either("death", "crash_done");

  if(isdefined(self.attractor))
    missile_deleteattractor(self.attractor);

  if(isdefined(self.attractor2))
    missile_deleteattractor(self.attractor2);
}

heli_default_missiles_on(var_0) {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_default_heli_missiles");
  self.preferredtarget = undefined;

  while (isdefined(self)) {
    wait 0.05;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    self.preferredtarget = undefined;
    var_4 = undefined;

    if(isdefined(self.currentnode) && isdefined(self.currentnode.target))
      var_4 = maps\_utility::getent_or_struct(self.currentnode.target, "targetname");

    if(isdefined(var_4) && isdefined(var_4.script_linkto))
      self.preferredtarget = maps\_utility::getent_or_struct(var_4.script_linkto, "script_linkname");

    if(isdefined(self.preferredtarget)) {
      var_1 = self.preferredtarget;
      var_2 = var_1.script_shotcount;
      var_3 = var_1.script_delay;
      var_4 waittill("trigger");
    } else
      common_scripts\utility::waittill_any("near_goal", "goal");

    if(isdefined(var_1))
      thread heli_fire_missiles(var_1, var_2, var_3, var_0);
  }
}

heli_default_missiles_off() {
  self notify("stop_default_heli_missiles");
}

heli_spotlight_on(var_0, var_1, var_2) {
  if(!isdefined(var_0))
    var_0 = "tag_barrel";

  if(!isdefined(var_1))
    var_1 = 0;

  if(!isdefined(var_2))
    var_2 = 0;

  playfxontag(common_scripts\utility::getfx("_attack_heli_spotlight"), self, var_0);
  self.spotlight = 1;
  thread heli_spotlight_cleanup(var_0);

  if(var_2)
    self setturrettargetent(level.player);
  else if(var_1) {
    self endon("death");
    self endon("heli_players_dead");
    var_3 = self gettagorigin("tag_origin");

    if(!isdefined(self.targetdefault))
      heli_default_target_setup();

    self setturrettargetent(self.targetdefault);
    thread heli_spotlight_aim();
  }
}

heli_spotlight_off() {
  self notify("turn_off_spotlight");
}

heli_spotlight_random_targets_on() {
  self endon("death");
  self endon("heli_players_dead");
  self endon("stop_spotlight_random_targets");

  if(!isdefined(self.targetdefault))
    thread heli_default_target_setup();

  if(!isdefined(self.left_ent))
    thread heli_spotlight_think();

  while (isdefined(self)) {
    wait 0.05;
    self setturrettargetent(self.targetdefault, (0, 0, 0));
  }
}

heli_spotlight_random_targets_off() {
  self notify("stop_spotlight_random_targets");
}

heli_fire_missiles(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("heli_players_dead");

  if(isdefined(self.defaultweapon))
    var_4 = self.defaultweapon;
  else
    var_4 = "turret_attackheli";

  var_5 = "missile_attackheli";

  if(isdefined(var_3))
    var_5 = var_3;

  var_6 = undefined;
  var_7 = [];
  self setvehweapon(var_4);

  if(!isdefined(var_1))
    var_1 = 1;

  if(!isdefined(var_2))
    var_2 = 1;

  if(!isdefined(var_0.classname)) {
    if(!isdefined(self.dummytarget)) {
      self.dummytarget = spawn("script_origin", var_0.origin);
      thread common_scripts\utility::delete_on_death(self.dummytarget);
    }

    self.dummytarget.origin = var_0.origin;
    var_0 = self.dummytarget;
  }

  switch (self.vehicletype) {
    case "mi28":
      var_6 = 0.5;
      var_7[0] = "tag_store_L_2_a";
      var_7[1] = "tag_store_R_2_a";
      var_7[2] = "tag_store_L_2_b";
      var_7[3] = "tag_store_R_2_b";
      var_7[4] = "tag_store_L_2_c";
      var_7[5] = "tag_store_R_2_c";
      var_7[6] = "tag_store_L_2_d";
      var_7[7] = "tag_store_R_2_d";
      break;
    case "littlebird":
    case "apache":
      var_6 = 0.5;
      var_7[0] = "tag_missile_left";
      var_7[1] = "tag_missile_right";
      break;
    case "hind_battle":
      var_7[0] = "tag_missile_left";
      var_7[1] = "tag_missile_right";
      break;
    default:
      break;
  }

  var_8 = -1;

  for (var_9 = 0; var_9 < var_1; var_9++) {
    var_8++;

    if(var_8 >= var_7.size)
      var_8 = 0;

    self setvehweapon(var_5);
    self.firingmissiles = 1;
    var_10 = self fireweapon(var_7[var_8], var_0);
    var_10 thread missile_earthquake();

    if(var_9 < var_1 - 1)
      wait(var_2);
  }

  self.firingmissiles = 0;
  self setvehweapon(var_4);
}

boneyard_style_heli_missile_attack() {
  self waittill("trigger", var_0);
  var_1 = common_scripts\utility::getstructarray(self.target, "targetname");
  var_1 = maps\_utility::array_index_by_script_index(var_1);
  boneyard_fire_at_targets(var_0, var_1);
}

boneyard_style_heli_missile_attack_linked() {
  self waittill("trigger", var_0);
  var_1 = maps\_utility::get_linked_structs();
  var_1 = maps\_utility::array_index_by_script_index(var_1);
  boneyard_fire_at_targets(var_0, var_1);
}

boneyard_fire_at_targets(var_0, var_1) {
  var_2 = [];
  var_2[0] = "tag_missile_right";
  var_2[1] = "tag_missile_left";

  if(var_0.vehicletype == "cobra") {
    var_2[0] = "tag_store_L_1_a";
    var_2[1] = "tag_store_R_1_a";
  }

  var_3 = [];

  for (var_4 = 0; var_4 < var_1.size; var_4++) {
    var_3[var_4] = spawn("script_origin", var_1[var_4].origin);
    var_0 setvehweapon("littlebird_FFAR");
    var_0 setturrettargetent(var_3[var_4]);
    var_5 = var_0 fireweapon(var_2[var_4 % var_2.size], var_3[var_4], (0, 0, 0));
    var_5 common_scripts\utility::delaycall(1, ::missile_cleartarget);
    wait(randomfloatrange(0.2, 0.3));
  }

  wait 2;

  foreach(var_7 in var_3)
  var_7 delete();
}