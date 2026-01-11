/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\jungle_ghosts_runway.gsc
*****************************************/

runway_setup() {
  thread runway_vehicles();
  thread runway_bad_places();
  thread runway_sat_launch();
  thread escape_play_slide_fx_on_player();
  thread escape_globals("runway");
}

runway_bad_places() {
  var_0 = common_scripts\utility::getstructarray("escape_badplace", "targetname");

  foreach(var_2 in var_0) {
  badplace_cylinder("bp", 0, var_2.origin, var_2.radius, var_2.height, "allies");
  }
}

runway_sat_launch() {
  common_scripts\utility::flag_wait("field_dialogue_cue");
  var_0 = getent("missile01_start", "targetname");
  var_1 = getent("missile01_end", "targetname");
  var_2 = getent("icbm_missile01", "targetname");
  var_2 thread sat_launch_piece_fall_away();
  playFX(level._effect["icbm_launch"], var_2.origin);
  var_3 = 70;
  thread sat_launch_sound_earthquake_rumble(var_2);
  var_2 linkto(var_0);
  var_0 moveto(var_1.origin, var_3, 10, 0);
  var_0 rotateto((20, 0, 0), 8, 8, 0);
  playFXOnTag(level._effect["smoke_geotrail_icbm"], var_2, "tag_nozzle");
  common_scripts\utility::exploder("rocketwash");
  thread delete_rocket_wash();
  var_0 waittill("movedone");
  var_2 delete();
}

delete_rocket_wash() {
  wait 8;
  maps\_utility::stop_exploder("rocketwash");
}

sat_launch_piece_fall_away() {
  var_0 = getent("large_fuel1", "script_noteworthy");
  var_1 = getent("large_fuel2", "script_noteworthy");
  var_2 = getent("small_fuel1", "script_noteworthy");
  var_3 = getent("small_fuel2", "script_noteworthy");
  var_4 = common_scripts\utility::getstruct("large_fuel1_fx", "script_noteworthy");
  var_5 = common_scripts\utility::getstruct("large_fuel2_fx", "script_noteworthy");
  var_6 = common_scripts\utility::getstruct("small_fuel1_fx", "script_noteworthy");
  var_7 = common_scripts\utility::getstruct("small_fuel2_fx", "script_noteworthy");
  var_0 linkto(self, "");
  var_1 linkto(self, "");
  var_2 linkto(self, "");
  var_3 linkto(self, "");
  var_8 = var_4 common_scripts\utility::spawn_tag_origin();
  var_9 = var_5 common_scripts\utility::spawn_tag_origin();
  var_10 = var_6 common_scripts\utility::spawn_tag_origin();
  var_11 = var_7 common_scripts\utility::spawn_tag_origin();
  var_8 linkto(var_0, "");
  var_9 linkto(var_1, "");
  var_10 linkto(var_2, "");
  var_11 linkto(var_3, "");
  wait 3.5;
  wait 0.5;
  wait 1.5;
  var_0 unlink();
  var_0 movegravity((-250, 0, 1250), 10);
  var_0 rotateby((0, 0, 90), 5);
  wait 0.5;
  wait 0.5;
  var_1 unlink();
  var_1 movegravity((250, 0, 1250), 10);
  var_1 rotateby((0, 0, 90), 5);
  wait 2;
  var_2 unlink();
  var_2 movegravity((-450, 0, 1250), 10);
  var_2 rotateby((90, 0, 90), 5);
  wait 0.4;
  var_3 unlink();
  var_3 movegravity((450, 0, 1250), 10);
  var_3 rotateby((90, 0, 90), 5);
  wait 10;
  var_0 delete();
  var_1 delete();
  var_2 delete();
  var_3 delete();
  var_8 delete();
  var_9 delete();
  var_10 delete();
  var_11 delete();
}

putter_out_rocket_fx() {
  var_0 = randomintrange(2, 4);

  for(var_1 = 0; var_1 < var_0; var_1++) {
    wait(randomfloatrange(0.2, 0.5));
    stopFXOnTag(level._effect["smoke_geotrail_icbm"], self, "tag_origin");
    wait(randomfloatrange(0.2, 0.5));
    playFXOnTag(level._effect["smoke_geotrail_icbm"], self, "tag_origin");
    wait(randomfloatrange(0.2, 0.5));
  }

  stopFXOnTag(level._effect["smoke_geotrail_icbm"], self, "tag_origin");
}

sat_launch_sound_earthquake_rumble(var_0) {
  var_1 = 4;
  level.player thread maps\_utility::play_sound_on_entity("jg_earthquake_lr");
  earthquake(0.2, 8, level.player.origin, 8000);
  level.player playrumblelooponentity("grenade_rumble");
  wait(var_1);
  level.player stoprumble("grenade_rumble");
  level.player playrumblelooponentity("damage_heavy");
  wait(var_1);
  level.player stoprumble("damage_heavy");
  level.player playrumblelooponentity("damage_light");
  wait(var_1);
  level.player stoprumble("damage_light");
}

runway_vehicles() {
  common_scripts\utility::flag_wait("runway_halfway");
  thread runway_detect_player_stance_and_movement();
  thread no_go_back_into_field();
  thread warp_up_friendlies_if_necessary();
  wait 1;
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("departing_apache");
  common_scripts\utility::array_thread(var_0, maps\_vehicle::godon);
  common_scripts\utility::array_thread(var_0, maps\_vehicle_code::damage_hint_bullet_only);
  common_scripts\utility::array_call(var_0, ::vehicle_turnengineoff);

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      if(var_2.script_noteworthy == "runway_apache") {
        level.apache1 = var_2;
      }

      if(var_2.script_noteworthy == "runway_apache2") {
        level.apache2 = var_2;
      }
    }
  }

  level.cliff_chopper = level.apache2;
  level.apache1 thread runway_apache_logic("runway");
  level.cliff_chopper thread runway_apache_logic_cliff_chopper("runway");
  common_scripts\utility::array_call(var_0, ::vehicle_turnengineon);
  common_scripts\utility::array_thread(var_0, ::runway_chopper_detect_damage);
  level.cliff_chopper thread cliff_chopper_shoot_over_players_head();
  wait 3;
  maps\jungle_ghosts_util::do_lightning();
  wait 3;

  if(!common_scripts\utility::flag("choppers_saw_player")) {
    thread cliff_choppers_move_on(var_0);
  }
  else {
    level.apache1 thread fire_at_player_until_jump();
    level.apache1 thread kill_player_if_go_back_or_not_moving();
    level thread fire_random_rockets_around_player_until_jump();
  }
}

warp_up_friendlies_if_necessary() {
  common_scripts\utility::flag_wait("slide_start");
  wait 1;
  var_0 = (1332, 14368, 1320);

  foreach(var_2 in level.squad) {
    if(var_2 istouching(getent("no_go_back_chopper", "targetname"))) {
      var_2 notify("stop_path");
      var_2 forceteleport(var_0, (0, 225, 0));
      var_0 = var_0 - (50, 15, 0);
    }
  }
}

no_go_back_into_field() {
  level endon("slide_start");
  level endon("choppers_are_gone");
  var_0 = getent("no_go_back_chopper", "targetname");
  common_scripts\utility::flag_wait("choppers_get_down");

  for(;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_set("chopper_fire_on_player_hard");
    wait 3;

    if(level.player istouching(var_0)) {
      common_scripts\utility::flag_set("chopper_kill_player");
      continue;
    }

    common_scripts\utility::flag_clear("chopper_fire_on_player_hard");
  }
}

cliff_choppers_move_on(var_0) {
  common_scripts\utility::flag_set("choppers_are_gone");

  foreach(var_4, var_2 in var_0) {
    var_3 = getent("runway_choppers_flyaway" + var_4, "targetname");
    var_2 setlookatent(var_3);
    var_2 setvehgoalpos(var_3.origin, 1);
    wait 1;
  }

  wait 3;

  foreach(var_4, var_2 in var_0) {
    var_3 = getent("runway_choppers_flyaway" + var_4, "targetname");
    var_2 setlookatent(var_3);
    var_2 setvehgoalpos(var_3.origin, 1);
    var_2 vehicle_setspeed(60, 15, 1);
    wait 2;
  }

  wait 7;

  foreach(var_4, var_2 in var_0) {
    var_3 = getent("runway_choppers_flyaway" + (var_4 + 2), "targetname");
    var_2 setlookatent(var_3);
    var_2 setvehgoalpos(var_3.origin, 1);
    var_2 vehicle_setspeed(60, 15, 1);
    wait 2;
  }

  wait 10;

  foreach(var_4, var_2 in var_0) {
  var_2 delete();
  }
}

runway_detect_player_stance_and_movement() {
  level endon("choppers_are_gone");
  common_scripts\utility::flag_wait("choppers_get_down");

  if(common_scripts\utility::flag("keep_tall_grass_alive_longer")) {
    common_scripts\utility::flag_set("choppers_saw_player");
    return;
  }

  var_0 = 1.2;
  wait(var_0);
  var_1 = level.player.origin;
  var_2 = 32;
  var_3 = 0;

  while(!var_3) {
    if(level.player getstance() != "prone" || distance2d(var_1, level.player.origin) > var_2) {
      var_3 = 1;
    }

    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("choppers_saw_player");
}

runway_chopper_detect_damage() {
  level endon("choppers_are_gone");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("choppers_saw_player");
}

cliff_chopper_shoot_over_players_head() {
  wait 3;
  self setlookatent(level.player);
  wait 1;

  if(!common_scripts\utility::flag("choppers_saw_player")) {
    return;
  }
  var_0 = "rpg_straight";
  var_1 = "apache_turret";
  var_2 = 2;
  var_3 = 100;
  var_4 = level.player common_scripts\utility::spawn_tag_origin();
  var_4.origin = var_4.origin + (0, 0, var_3);
  var_2 = 4;
  var_5 = "tag_missile_left";

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = magicbullet("rpg_straight_nosound", self gettagorigin(var_5) + (0, 0, 64), var_4.origin);
    var_7 thread maps\jungle_ghosts_util::escape_earthquake_on_missile_impact();
    wait 0.25;

    if(var_5 == "tag_missile_left") {
      var_5 = "tag_missile_right";
      continue;
    }

    var_5 = "tag_missile_left";
  }

  var_4 delete();
  self setvehweapon(var_1);
}

magic_missile_fire_at_ent(var_0, var_1, var_2, var_3) {
  level endon("player_jump_watcher_stop");
  var_4 = "missile_attackheli";

  if(!isDefined(var_1)) {
    var_1 = 2;
  }

  var_1 = min(2, var_1);
  var_5 = "tag_missile_right";

  if(isDefined(var_2) && var_2) {
    level.player enabledeathshield(0);
    level.player enablehealthshield(0);
  }

  for(var_6 = 0; var_6 < var_1; var_6++) {
    var_7 = anglesToForward(level.player.angles);
    var_7 = var_7 * -500;
    var_8 = undefined;

    if(isDefined(var_3) && var_3) {
      var_8 = fake_rocket(self gettagorigin(var_5) + (0, 0, 64), var_0.origin + (randomintrange(-64, 64), randomintrange(-64, 64), randomintrange(-64, 64)));
    }
    else {
      var_8 = fake_rocket(level.player.origin + var_7 + (randomintrange(-128, 128), randomintrange(-128, 128), 800), var_0.origin + (randomintrange(-64, 64), randomintrange(-64, 64), randomintrange(-64, 64)));
    }

    if(var_6 == 0) {
      thread common_scripts\utility::play_sound_in_space("scn_chopper_fire_missile", var_8.origin);
      var_8.is_first = 1;
      var_8.is_last = 0;
      var_8 playLoopSound("scn_chopper_missile_loop");
    } else if(var_6 == var_1 - 1 && var_6 != 0) {
      var_8.is_first = 0;
      var_8.is_last = 1;
    } else {
      var_8.is_first = 0;
      var_8.is_last = 0;
    }

    if(var_5 == "tag_missile_left") {
      var_5 = "tag_missile_right";
    }
    else {
      var_5 = "tag_missile_left";
    }

    var_8 thread maps\jungle_ghosts_util::escape_earthquake_on_missile_impact();
    common_scripts\utility::waitframe();
  }

  if(isDefined(var_2) && var_2 && isalive(level.player)) {
    wait 1.5;
    maps\jungle_ghosts_util::set_death_quote(&"JUNGLE_GHOSTS_ESCAPE_DEATH_HINT");
    level.player kill();
  }
}

fake_rocket(var_0, var_1) {
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_0;
  var_2 setModel("projectile_rpg7");
  var_3 = common_scripts\utility::getfx("rpg_trail");
  playFXOnTag(var_3, var_2, "tag_origin");
  var_4 = bulletTrace(var_0, var_1, 1);
  var_2.angles = vectortoangles(var_0 - var_1);
  var_2 moveto(var_4["position"], 1.5, 1.5);
  var_2 thread rocket_delete();
  return var_2;
}

rocket_delete() {
  self waittill("movedone");
  var_0 = common_scripts\utility::getfx("rpg_explode");

  if(self.is_first) {
    playFX(var_0, self.origin);
    level thread common_scripts\utility::play_sound_in_space("rocket_explode_default", self.origin);
    radiusdamage(self.origin, 300, 5, 4);
  }

  if(self.is_last) {
    playFX(var_0, self.origin);
  }

  self stoploopsound("scn_chopper_missile_loop");
  self delete();
}

generic_gun_fire_at_player(var_0) {
  level endon("player_jump_watcher_stop");
  self endon("death");
  var_1 = -100;
  var_2 = 100;
  var_3 = 450;
  var_4 = 50;
  var_5 = 0;
  var_6 = level.player common_scripts\utility::spawn_tag_origin();
  var_7 = anglesToForward(level.player.angles);
  var_7 = level.player.origin + var_7 * var_3;
  var_8 = anglesToForward(level.player.angles);
  var_8 = level.player.origin - var_8 * var_4;
  var_6.origin = var_8;
  var_6 moveto(var_7, 2);

  if(isDefined(var_0) && var_0) {
    level.player enabledeathshield(0);
    level.player enablehealthshield(0);
    var_7 = level.player.origin;
    var_5 = 1;
  }

  var_9 = randomintrange(20, 25);

  for(var_10 = 0; var_10 < var_9; var_10++) {
    if(var_5) {
      self setturrettargetent(level.player);
    }
    else {
      self setturrettargetent(var_6);
    }

    common_scripts\utility::waitframe();
    self fireweapon();
    common_scripts\utility::waitframe();
  }

  var_6 delete();

  if(isDefined(var_0) && var_0 && isalive(level.player)) {
    maps\jungle_ghosts_util::set_death_quote(&"JUNGLE_GHOSTS_ESCAPE_DEATH_HINT");
    level.player kill();
  }
}

fire_random_rockets_around_player_until_jump() {
  level endon("player_crossed_river");
  common_scripts\utility::flag_wait("slide_start");
  wait 3;

  for(;;) {
    var_0 = anglesToForward(level.player.angles);
    var_0 = level.player.origin + var_0 * randomintrange(500, 750);
    var_0 = var_0 + (randomintrange(-250, 250), randomintrange(-250, 250), 0);
    var_1 = common_scripts\utility::spawn_tag_origin();
    var_1.origin = var_0;
    magic_missile_fire_at_ent(var_1, randomintrange(2, 6), 0, 0);
    wait(randomintrange(5, 10));
    var_1 delete();
  }
}

fire_at_player_until_jump() {
  level endon("player_jump_watcher_stop");
  self endon("death");

  if(!common_scripts\utility::flag("choppers_saw_player")) {
    return;
  }
  common_scripts\utility::flag_wait("slide_start");

  for(;;) {
    wait(randomintrange(2, 4));
    generic_gun_fire_at_player(0);
  }
}

kill_player_if_go_back_or_not_moving() {
  thread kill_on_river_crossing_back_track();
  level endon("player_crossed_river");
  var_0 = 13500;
  var_1 = 400;
  var_2 = 10;
  common_scripts\utility::flag_wait("slide_start");

  while(!common_scripts\utility::flag("player_crossed_river")) {
    wait(var_2);

    if(level.player.origin[1] > var_0 - var_1) {
      magic_missile_fire_at_ent(level.player, 6, 1);
    }

    var_1 = var_1 + var_1;
  }
}

kill_on_river_crossing_back_track() {
  level endon("player_jump_watcher_stop");
  var_0 = -560;
  var_1 = 9284;
  common_scripts\utility::flag_wait("player_crossed_river");
  wait 10;

  if(level.player.origin[0] > var_0 || level.player.origin[1] > var_1) {
    magic_missile_fire_at_ent(level.player, 6, 1, 1);
  }

  wait 12;
  magic_missile_fire_at_ent(level.player, 6, 1, 1);
}

runway_apache_logic(var_0) {
  self endon("death");

  switch (var_0) {
    case "runway":
    default:
      thread maps\_vehicle::godon();
      self waittill("attack");
      thread maps\_vehicle::godon();
      common_scripts\utility::flag_wait_any("choppers_saw_player", "choppers_are_gone");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        thread maps\jungle_ghosts_util::music_escape_hot();
        maps\_utility::delaythread(3, ::turret_burst_fire_at_ent, level.player);
        self setlookatent(level.player);
      }
    case "jungle":
      common_scripts\utility::flag_wait("slide_start");
      self notify("stop_burst_fire");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        var_1 = maps\_utility::getent_or_struct("attack_trees", "script_noteworthy");
        self setvehgoalpos(var_1.origin, 1);
        self vehicle_setspeedimmediate(50);
        var_2 = getent("attack_trees_lookat", "script_noteworthy");
        self setlookatent(var_2);
        self waittill("goal");
        var_3 = getEntArray("dest_top", "script_noteworthy");
        var_4 = 50;
        var_5 = 200;

        foreach(var_7 in var_3) {
          var_8 = var_7.origin;
          var_9 = randomintrange(3, 5);

          for(var_10 = 0; var_10 < var_9; var_10++) {
            var_11 = randomintrange(var_4, var_5);

            if(common_scripts\utility::cointoss()) {
              var_11 = var_11 * -1;
            }

            self setturrettargetent(var_7);
            wait 0.05;
            self fireweapon();
            wait(randomfloatrange(0.05, 0.15));
          }
        }
      }
    case "river":
      common_scripts\utility::flag_wait("escape_halfway");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        var_1 = maps\_utility::getent_or_struct("attack_river_jump", "targetname");
        self setvehgoalpos(var_1.origin, 1);
        self vehicle_setspeedimmediate(50);
        self setlookatent(level.player);
        wait 3;
      }

      common_scripts\utility::flag_wait("player_at_river");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        self clearlookatent();
        var_13 = maps\_utility::getent_or_struct("river_path_start", "targetname");
        thread maps\_vehicle::vehicle_paths(var_13);
        self vehicle_setspeed(50, 25);
      }

      common_scripts\utility::flag_wait("player_crossed_river");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        self setlookatent(level.player);
      }

      maps\_utility::trigger_wait_targetname("river_slide_trig");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        var_14 = common_scripts\utility::getstructarray("waterfall_missile_impact", "targetname");
        wait 1;
        thread escape_apache_shoot_missiles_at_structs(var_14);
      }

      common_scripts\utility::flag_wait("final_read");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        var_15 = spawn("script_origin", level.player getEye() + (0, 0, 50));
        var_15 linkto(level.player);
        level.player common_scripts\utility::delaycall(0.5, ::playsound, "slowmo_bullet_whoosh");
        level.player common_scripts\utility::delaycall(1, ::playsound, "slowmo_bullet_whoosh");
        level.player common_scripts\utility::delaycall(1.5, ::playsound, "slowmo_bullet_whoosh");
        var_9 = 20;

        for(var_10 = 0; var_10 < var_9; var_10++) {
          self setturrettargetent(var_15, (100, 100, 50));
          self fireweapon();
          wait(randomfloatrange(0.05, 0.15));
        }

        return;
      }
  }
}

runway_apache_logic_cliff_chopper(var_0) {
  self endon("death");

  switch (var_0) {
    case "runway":
    default:
      thread maps\_vehicle::godon();
      common_scripts\utility::flag_wait_any("choppers_saw_player", "choppers_are_gone");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        maps\_utility::delaythread(8, ::turret_burst_fire_at_ent, level.player);
        self setlookatent(level.player);
      }
    case "jungle":
      if(common_scripts\utility::flag("choppers_saw_player")) {
        escape_apache_pressure_player_until_flag("slide_start");
      }

      common_scripts\utility::flag_wait("slide_start");
      self notify("stop_burst_fire");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        var_1 = maps\_utility::getent_or_struct("attack_trees_chopper2", "script_noteworthy");
        self setvehgoalpos(var_1.origin, 1);
        self vehicle_setspeedimmediate(50);
        var_2 = getent("attack_trees_lookat", "script_noteworthy");
        self setlookatent(var_2);
        self waittill("goal");
        common_scripts\utility::flag_wait("escape_halfway");
        var_1 = maps\_utility::getent_or_struct("attack_trees_chopper2", "script_noteworthy");
        self setvehgoalpos(var_1.origin, 1);
        self waittill("goal");
        self delete();
        return;
      }
  }
}

runway_apache_turret_logic() {
  self setmode("manual");
  self setturretteam("axis");
  self setdefaultdroppitch(0);
}

escape_apache_pressure_player_until_flag(var_0) {
  var_1 = 60;
  self notify("stop_shooting");
  self endon("stop_shooting");
  level endon(var_0);
  var_2 = randomintrange(15, 30);

  while(!common_scripts\utility::flag(var_0)) {
    self setturrettargetent(level.player, (var_1, var_1, 10));
    wait 2;

    for(var_3 = 0; var_3 < var_2; var_3++) {
      if(common_scripts\utility::cointoss()) {
        var_1 = var_1 * -1;
      }

      self setturrettargetent(level.player, (var_1, var_1, 10));
      wait 0.05;
      self fireweapon();
    }

    var_1 = var_1 - 10;

    if(var_1 < 0) {
      var_1 = 0;
    }

    wait(randomintrange(2, 4));
  }
}

turret_burst_fire_at_ent(var_0, var_1) {
  for(;;) {
    self endon("death");
    self endon("stop_burst_fire");

    if(!isDefined(var_1)) {
      var_1 = randomintrange(10, 20);
    }

    if(level.gameskill < 2) {
      var_2 = 150;
      var_3 = 200;
    } else if(level.gameskill == 2) {
      var_2 = 150;
      var_3 = 200;
    } else {
      var_2 = 50;
      var_3 = 100;
    }

    var_4 = randomintrange(var_2, var_3);
    self setturrettargetent(var_0, (var_4, var_4, 0));
    wait 2;

    if(common_scripts\utility::flag("chopper_kill_player")) {
      level.player enabledeathshield(0);
      level.player enablehealthshield(0);
    }

    for(var_5 = 0; var_5 < var_1; var_5++) {
      var_4 = randomintrange(var_2, var_3);

      if(common_scripts\utility::flag("chopper_kill_player")) {
        var_4 = 0;
      }

      if(common_scripts\utility::cointoss()) {
        var_4 = var_4 * -1;
      }

      self setturrettargetent(var_0, (var_4, var_4, 0));
      wait 0.05;

      if(level.player.health > 50 && !common_scripts\utility::flag("chopper_kill_player")) {
        self fireweapon();
      }
    }

    if(common_scripts\utility::flag("chopper_kill_player")) {
      level.player kill();
    }

    self notify("done_shooting");
  }
}

get_target_structs() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_0 = common_scripts\utility::getstructarray(self.target, "targetname");
  }

  return var_0;
}

escape_globals(var_0) {
  escape_setup_trees();
  thread escape_player_speed(var_0);
  thread escape_friendly_movement(var_0);
  thread escape_enemies_and_vehicles(var_0);

  if(common_scripts\utility::flag("choppers_saw_player")) {
    thread escape_scripted_destruction(var_0);
  }

  thread escape_player_jump();
  thread escape_vo(var_0);
  thread water_push_player();
  common_scripts\utility::flag_wait("player_slid");
  level.rain_effect = common_scripts\utility::getfx("rain_heavy");
}

water_push_player() {
  var_0 = common_scripts\utility::get_target_ent("water_push");
  var_0 waittill("trigger");
  var_1 = vectornormalize(common_scripts\utility::getstruct(var_0.target, "targetname").origin - var_0.origin);
  var_2 = 0;
  var_3 = 10;

  for(;;) {
    if(var_0 istouching(level.player)) {
      var_2 = var_2 + 0.2;
    }
    else {
      var_2 = 0;
    }

    var_2 = min(var_2, var_3);
    level.player pushplayervector(var_1 * var_2, 0);
    wait 0.1;
  }
}

escape_player_speed(var_0) {
  common_scripts\utility::flag_wait("player_slid");
  level.player thread maps\_utility::player_speed_default(1);
  level.player common_scripts\utility::delaycall(1, ::setbobrate, 1);
  setsaveddvar("player_sprintspeedscale", 1.4);
  setsaveddvar("player_sprintunlimited", 1);
}

escape_scripted_destruction(var_0) {
  switch (var_0) {
    case "jungle":
    case "runway":
    default:
      wait 1;
      common_scripts\utility::flag_wait("slide_start");
      var_0 = (1104, 12994, 1468);
      var_1 = (274, 12416, 927);
      var_2 = magicbullet("rpg_straight_nosound", var_0, var_1, level.player);
      var_2 thread maps\jungle_ghosts_util::escape_earthquake_on_missile_impact();
      wait 0.5;
      var_2 = magicbullet("rpg_straight_nosound", var_0, var_1, level.player);
      var_2 thread maps\jungle_ghosts_util::escape_earthquake_on_missile_impact();
    case "river":
  }
}

escape_socr_turret_own_target(var_0, var_1) {
  self.maxhealth = 99999999;
  self.health = self.maxhealth;
  self setmode("manual");
  var_2 = spawn("script_origin", var_0.origin - (0, 0, 40));
  var_2 linkto(var_0);

  if(isDefined(var_1)) {
    self waittill(var_1);
  }

  self settargetentity(var_2);
  var_3 = randomintrange(60, 70);
  self startbarrelspin();
  wait 1;
  var_0 thread escape_chopper_timeout_death();
  var_0 clearlookatent();

  if(!common_scripts\utility::flag("choppers_attacked")) {
    maps\_utility::delaythread(1.5, common_scripts\utility::flag_set, "choppers_attacked");
  }

  for(;;) {
    for(var_4 = 0; var_4 < var_3; var_4++) {
      self settargetentity(var_2);
      self shootturret();
      wait(randomfloatrange(0.05, 0.15));
    }

    if(!isDefined(var_0)) {
      break;
    } else if(var_0 maps\_vehicle::vehicle_is_crashing()) {
      break;
    }
  }

  self stopbarrelspin();
}

escape_chopper_timeout_death() {
  self endon("death");
  wait 2;

  if(isalive(self) || !maps\_vehicle::vehicle_is_crashing()) {
    thread maps\_vehicle_code::_kill_fx(self.model, 0);
  }
}

escape_apache_shoot_missiles_at_structs(var_0, var_1) {
  if(isDefined(var_1)) {
    self waittill(var_1);
  }

  var_2 = "tag_missile_left";

  foreach(var_4 in var_0) {
    var_5 = self gettagorigin(var_2) - (0, 0, 60);
    var_6 = magicbullet("rpg_straight_nosound", var_5, var_4.origin);
    var_6 thread maps\jungle_ghosts_util::escape_earthquake_on_missile_impact();
    wait 0.2;

    if(var_2 == "tag_missile_left") {
      var_2 = "tag_missile_right";
      continue;
    }

    var_2 = "tag_missile_left";
  }
}

escape_friendly_movement(var_0) {
  thread escape_blockers();

  while(!isDefined(level.squad)) {
    wait 0.1;
  }

  while(level.squad.size != 4) {
    wait 0.1;
  }

  switch (var_0) {
    case "runway":
    default:
      common_scripts\utility::flag_wait("runway_approach");
      maps\_utility::autosave_by_name("runway_approach");
      common_scripts\utility::flag_wait("runway_halfway");

      if(!common_scripts\utility::flag("keep_tall_grass_alive_longer")) {
        common_scripts\utility::array_thread(level.squad, maps\_utility::disable_ai_color);
        common_scripts\utility::array_thread(level.squad, ::runway_stop_in_place);
        common_scripts\utility::array_call(level.squad, ::allowedstances, "prone");
      }

      common_scripts\utility::flag_wait_any("choppers_are_gone", "choppers_saw_player", "slide_start");

      if(common_scripts\utility::flag("slide_start") && !common_scripts\utility::flag("choppers_are_gone")) {
        common_scripts\utility::flag_set("choppers_saw_player");
      }

      if(common_scripts\utility::flag("choppers_are_gone")) {
        wait 5;
      }

      common_scripts\utility::array_call(level.squad, ::allowedstances, "stand", "crouch");
      common_scripts\utility::array_thread(level.squad, maps\_utility::disable_cqbwalk);
      common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
      maps\_utility::activate_trigger_with_targetname("squad_hill_bottom");
      var_1 = 0;

      foreach(var_4, var_3 in level.squad) {
        var_3 thread escape_temp_ai_slide();
        wait 1;
      }
    case "jungle":
      common_scripts\utility::flag_wait("slide_start");

      foreach(var_3 in level.squad) {
        var_3 thread maps\_utility::enable_sprint();
        var_3.perfectaim = 1;
        var_3.baseaccuracy = 90;
        var_3.grenadeammo = 0;
        var_3.disablearrivals = 1;
      }
    case "river":
      common_scripts\utility::flag_wait("escape_halfway");
      common_scripts\utility::array_thread(level.squad, maps\_utility::enable_ai_color);
      var_7 = common_scripts\utility::getstructarray("waterfall_jump", "targetname");
      var_8 = common_scripts\utility::getstructarray("waterfall_ai_land", "targetname");
      common_scripts\utility::flag_wait("player_at_river");

      foreach(var_4, var_3 in level.squad) {
      var_3 thread escape_friendly_jumps_waterfall_to_swimming(var_7[var_4], var_8[var_4]);
      }
    case "waterfall":
      common_scripts\utility::flag_wait("choppers_attacked");
      wait 6;
      maps\_utility::activate_trigger_with_targetname("squad_to_boats");
      wait 5;
      iprintlnbold("end of scripting");
  }
}

escape_blockers() {
  common_scripts\utility::flag_wait("slide_start");

  if(common_scripts\utility::flag("choppers_saw_player")) {
    return;
  }
  var_0 = getEntArray("escape_blockers", "targetname");

  foreach(var_2 in var_0) {
    var_2 connectpaths();
    var_2 delete();
  }
}

runway_stop_in_place() {
  maps\_utility::disable_ai_color();
  self setgoalpos(self.origin);
}

escape_vo(var_0) {
  switch (var_0) {
    case "runway":
      common_scripts\utility::flag_wait("runway_halfway");
      thread runway_got_spotted();
      maps\jungle_ghosts_util::dialogue_stop();
      level.alpha2 maps\_utility::smart_dialogue("jungleg_gs2_choppersincoming");
      common_scripts\utility::flag_set("choppers_get_down");

      if(!common_scripts\utility::flag("keep_tall_grass_alive_longer")) {
        level.alpha1 maps\_utility::smart_dialogue("jungleg_gs1_okpreparetorappel");
        wait 2;

        if(!common_scripts\utility::flag("choppers_saw_player")) {
          level.merrick maps\_utility::smart_dialogue("jungleg_mrk_dontmove_2");
        }
      }

      common_scripts\utility::flag_wait_any("choppers_are_gone", "choppers_saw_player");

      if(common_scripts\utility::flag("choppers_are_gone") && !common_scripts\utility::flag("choppers_saw_player")) {
        level.alpha2 maps\_utility::delaythread(5, maps\_utility::smart_dialogue, "jungleg_kgn_weshouldmovenow");
      }
    case "jungle":
      common_scripts\utility::flag_wait("slide_start");
      thread runway_escape_run_vo_cold();
      thread runway_escape_run_vo_hot();
    default:
      break;
  }
}

runway_escape_run_vo_cold() {
  if(common_scripts\utility::flag("choppers_saw_player")) {
    return;
  }
  wait 2;
  level.player maps\_utility::play_sound_on_entity("jungleg_btd_copygammateamadjusting");
  wait 0.5;
  level.hesh maps\_utility::smart_dialogue("jungleg_gs2_incomingstrykerthrowing");
  wait 0.5;
  level.player maps\_utility::play_sound_on_entity("jungleg_gs1_cmonthisway");
  wait 0.5;
  level.alpha1 maps\_utility::smart_dialogue("jungleg_gs1_keepmoving");
  wait 0.5;
  level.merrick maps\_utility::smart_dialogue("jungleg_gs2_riverupahead");
  wait 0.5;
  level.alpha1 maps\_utility::smart_dialogue("jungleg_btd_gammateamthisis");
  common_scripts\utility::flag_wait("jump_vo_trig");
  level.merrick maps\_utility::smart_dialogue("jungleg_mrk_iguesweregetting");
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_everyonejump");
}

runway_escape_run_vo_hot() {
  if(!common_scripts\utility::flag("choppers_saw_player")) {
    return;
  }
  wait 5;
  level.player maps\_utility::play_sound_on_entity("jungleg_mko_commandthisismako");
  wait 1;
  level.hesh maps\_utility::smart_dialogue("jungleg_gs2_incomingstrykerthrowing");
  wait 1;
  level.alpha2 maps\_utility::smart_dialogue("jungleg_kgn_stayclearofthe");
  common_scripts\utility::flag_wait("player_crossed_river");
  level.hesh maps\_utility::smart_dialogue("jungleg_hsh_waterwater");
  common_scripts\utility::flag_wait("jump_vo_trig");
  level.merrick maps\_utility::smart_dialogue("jungleg_mrk_jump");
}

runway_got_spotted() {
  common_scripts\utility::flag_wait("choppers_saw_player");
  thread count_down_to_slide();
  maps\jungle_ghosts_util::dialogue_stop();
  level.alpha1 maps\_utility::smart_dialogue("jungleg_els_wevebeenspottedrun");
}

count_down_to_slide() {
  level endon("player_slid");
  wait 20;
  common_scripts\utility::flag_set("chopper_kill_player");
}

escape_player_jump() {
  common_scripts\utility::flag_wait("player_crossed_river");
  thread escape_mg_bullets_at_player_river_run();
  thread escape_player_water_logic();
  thread new_player_jump();
  return;
}

new_player_jump() {
  var_0 = common_scripts\utility::getstruct("struct_player_bigjump_edge_reference", "targetname");
  var_1 = common_scripts\utility::getstruct("struct_player_recovery_animref", "targetname");
  var_2 = anglesToForward(var_0.angles);
  var_3 = level.player;

  if(level.start_point != "underwater") {
    var_4 = getent("player_waterfall_jump_trig", "targetname");
    var_0 = common_scripts\utility::getstruct("struct_player_bigjump_edge_reference", "targetname");
    var_1 = common_scripts\utility::getstruct("struct_player_recovery_animref", "targetname");
    var_2 = anglesToForward(var_0.angles);
    thread maps\jungle_ghosts_util::player_jump_watcher();
    var_5 = getent("player_waterfall_jump_trig_back_up", "targetname");

    for(;;) {
      var_6 = 0;

      while(level.player istouching(var_4)) {
        if(common_scripts\utility::flag("player_jumping") || level.player istouching(var_5)) {
          var_6 = 1;
          break;
        }

        wait 0.05;
      }

      if(var_6) {
        break;
      }

      wait 0.05;
    }

    common_scripts\utility::flag_set("player_jump_watcher_stop");
  }

  level.player setclienttriggeraudiozone("jungle_ghosts_escape_jump", 0.5);
  thread maps\jungle_ghosts_util::music_end_jump_stinger();
  var_3 disableweapons();
  level.player takeweapon("fraggrenade");
  level.player allowcrouch(0);
  level.player setstance("stand");
  level.player common_scripts\utility::delaycall(0.5, ::takeallweapons);
  level.player thread maps\_utility::play_sound_on_entity("scn_jungle_player_over_falls");
  var_7 = "player_rig";
  var_8 = "waterfall_jump";
  var_9 = level.scr_anim[var_7][var_8];
  var_10 = (var_0.origin[0], var_3.origin[1], var_0.origin[2]);
  var_11 = var_0.angles;
  var_12 = getstartorigin(var_10, var_11, var_9);
  var_13 = getstartangles(var_10, var_11, var_9);
  var_14 = spawn("script_origin", var_10);
  var_14.angles = var_11;
  var_15 = maps\_utility::spawn_anim_model(var_7, var_12);
  var_15.angles = level.player.angles;
  var_15 hide();
  level thread escape_waterfall_player_link_logic(var_15);
  var_14 thread maps\jungle_ghosts_util::bigjump_player_blend_to_anim(var_15);
  var_14 thread maps\_anim::anim_single_solo(var_15, var_8);
  level.player common_scripts\utility::delaycall(3, ::playrumbleonentity, "grenade_rumble");
  setslowmotion(1, 0.5, 0.5);
  wait 2.5;
  setslowmotion(0.5, 1.5, 0.5);
  wait 1;
  setslowmotion(1.5, 0.3, 0.1);
  wait 3;
  setslowmotion(0.3, 1, 1);
  level.player playrumbleonentity("grenade_rumble");
}

escape_waterfall_player_link_logic(var_0) {
  if(isDefined(var_0)) {
    var_0 waittill("single anim");
    level.player unlink();
    var_0 delete();
    common_scripts\utility::flag_set("final_read");
  } else {
    common_scripts\utility::flag_wait("final_read");
    wait 1;
  }

  var_1 = (0, 0, 250);
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = common_scripts\utility::getstruct("in_the_water", "targetname").origin + var_1;
  var_2.angles = common_scripts\utility::getstruct("in_the_water", "targetname").angles + (5, 0, 0);
  level.player setorigin(var_2.origin);
  level.player setplayerangles(var_2.angles);
  level.player.float_ent = var_2;
  level.player playerlinktodelta(var_2, "tag_origin", 1, 50, 50, 20, 20, 1);
  var_3 = 0.6;
  thread maps\jungle_ghosts_jungle::player_heartbeat();
  var_4 = maps\_vehicle::spawn_vehicle_from_targetname("river_run");
  var_5 = common_scripts\utility::getstruct("player_underwater", "targetname");

  if(common_scripts\utility::flag("choppers_saw_player")) {
    level.apache1 thread turret_burst_fire_at_ent(level.player);
    level.river_apache thread turret_burst_fire_at_ent(level.player);
  }

  var_3 = 4;
  var_6 = common_scripts\utility::getstruct("waterfall_player_land", "targetname");
  var_7 = common_scripts\utility::getstruct("in_the_water", "targetname").angles;
  var_8 = level.player.float_ent.origin + (0, 0, 253) - var_1;
  level.player.float_ent moveto(level.player.float_ent.origin - (100, 100, 200), 1.5, 0, 1.5);
  level.player.float_ent waittill("movedone");
  level.player.float_ent moveto(var_8, 2.5, 0.7, 0.7);
  level.player.float_ent rotateto(var_7 + (40, 0, 10), 2);
  level.player thread maps\_utility::notify_delay("stop_underwater_fx", 1);
  wait 2;
  level.player.float_ent rotateto(var_7, 2);
  level.player setstance("stand");
  level.player setclienttriggeraudiozone("jungle_ghosts_exfil", 0.8);
  common_scripts\utility::flag_set("player_surfaces");
  thread maps\jungle_ghosts_util::give_jg_achievement();
  maps\_utility::autosave_by_name("surfacing");
  level thread maps\jungle_ghosts_util::player_swim_think();
  level.player thread maps\_utility::vision_set_fog_changes("jungle_boat_rescue", 0.05);
  level.player stopshellshock();
  level notify("stop_player_heartbeat");
  level.player setwatersheeting(1, 7.5);
  visionsetnaked("jungle_boat_rescue", 0.1);
  level.player thread maps\_utility::play_sound_on_entity("weap_sniper_breathin");
  level thread maps\jungle_ghosts_util::start_raining();
  wait 0.7;
  level.player setblurforplayer(0, 5);
  level.player thread maps\_utility::play_sound_on_entity("weap_sniper_breathin");
  level.player unlink();
  wait 6.0;
  level.player setclienttriggeraudiozone("jungle_ghosts_fade_out", 5.3);
  wait 4.0;
  maps\_utility::nextmission();
}

escape_player_fall_check() {
  level endon("player_jump_watcher_stop");
  var_0 = getent("player_fall_check", "targetname");
  var_0 waittill("trigger");
  var_0 delete();
  common_scripts\utility::flag_set("player_fell_off_waterfall");
  thread escape_waterfall_player_link_logic();
  level.player disableweapons();
  level.player enableinvulnerability();
}

escape_player_water_logic() {
  common_scripts\utility::flag_wait("final_read");
  level.player thread maps\_utility::play_sound_on_entity("scn_jungle_player_plunge");
  level.player setclienttriggeraudiozone("jungle_ghosts_escape_uw", 0.1);
  thread escape_underwater_fx();
}

escape_mg_bullets_at_player_river_run() {
  if(common_scripts\utility::flag("choppers_saw_player")) {
    var_0 = anglesToForward(level.player.angles);
    var_1 = level.player.origin + var_0 * 200;
    var_2 = spawn("script_origin", var_1);
    var_2 linkto(level.player);
    var_3 = 60;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      level.river_apache setturrettargetent(var_2);
      level.river_apache fireweapon();
      wait(randomfloatrange(0.05, 0.15));
    }

    var_2 delete();
  }
}

escape_underwater_fx() {
  var_0 = anglesToForward(level.player.angles);
  var_1 = anglestoright(level.player.angles);
  var_2 = level.player.origin + var_0 * 110 - var_1 * 25;
  playFX(common_scripts\utility::getfx("vfx_jg_wfall_underw_inispl"), var_2, anglestoup(level.player.angles), anglesToForward(level.player.angles));
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.script_max_left_angle = 2;
  level.player playersetgroundreferenceent(var_3);
  var_4 = 0.15;
  thread maps\jungle_ghosts_util::fade_out_in("white", undefined, var_4 * 2, var_4);
  var_3 thread maps\jungle_ghosts_util::pitch_and_roll();
  level notify("stop_rain");
  level notify("stop_lightning");
  wait(var_4);
  level.player endon("stop_underwater_fx");
  level.player shellshock("underwater", 999999);

  if(maps\_utility::game_is_current_gen()) {
    level.player thread maps\_utility::vision_set_fog_changes("jungle_underwater", 0.05);
  }

  level.player setblurforplayer(10, 0.1);
  visionsetnaked("jungle_underwater", 0.1);

  if(common_scripts\utility::flag("choppers_saw_player")) {
    var_5 = [level.river_apache, level.apache1];

    if(isDefined(var_5[0])) {
      common_scripts\utility::array_thread(var_5, ::escape_fake_underwater_bullets);
    }
  }

  for(;;) {
    playFX(common_scripts\utility::getfx("vfx_jg_wfall_underw_bubbles"), level.player getEye() + var_0 * 32, anglestoup(level.player.angles), anglesToForward(level.player.angles));
    wait 0.2;
  }
}

fade_out_in_custom(var_0) {
  var_1 = newhudelem();
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("black", 640, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 0.75;
  var_1.sort = -2;
  var_1 fadeovertime(var_0);
  var_1.alpha = 0;
  wait(var_0);
  var_1 destroy();
}

escape_friendly_jumps_waterfall_to_swimming(var_0, var_1) {
  maps\_utility::enable_sprint();
  escape_friendly_does_anim_off_struct(var_0);
  thread splashdown_fx();
  self.goalradius = 32;
  maps\_utility::disable_ai_color();
  self setgoalpos(self.origin);
  thread maps\jungle_ghosts_util::enable_ai_swim();
  wait 3;
  var_2 = common_scripts\utility::spawn_tag_origin();
  self linkto(var_2);
  var_2 moveto(var_1.origin, 3);
}

splashdown_fx() {
  common_scripts\utility::waitframe();
  playFXOnTag(common_scripts\utility::getfx("splash_down"), self, "tag_origin");
}

escape_friendly_does_anim_off_struct(var_0) {
  wait(randomint(2));
  maps\_utility::disable_ai_color();
  maps\_utility::set_forcegoal();
  self.og_animname = self.animname;
  self.animname = "generic";
  var_0 maps\_anim::anim_generic_reach(self, var_0.script_noteworthy);
  maps\_utility::delaythread(1, maps\_utility::enable_ai_color);
  maps\_utility::delaythread(1.5, maps\_utility::unset_forcegoal);
  var_0 maps\_anim::anim_single_solo_run(self, var_0.script_noteworthy);
  self.animname = self.og_animname;
}

escape_friendly_follow_spline(var_0) {
  maps\_utility::disable_ai_color();
  maps\_utility::set_forcegoal();
  maps\_utility::disable_pain();
  self[[level.ignore_on_func]]();
  self.goalradius = 100;
  var_1 = getnode(var_0, "targetname");

  for(;;) {
    self setgoalnode(var_1);
    self waittill("goal");

    if(isDefined(var_1.target)) {
      var_2 = getnode(var_1.target, "targetname");
      var_1 = var_2;
      continue;
    }

    self notify("end_of_spline");
    self setgoalnode(var_1);
    self waittill("goal");
    break;
  }

  maps\_utility::unset_forcegoal();
  maps\_utility::disable_sprint();
  maps\_utility::enable_pain();
  self[[level.ignore_off_func]]();
}

escape_enemies_and_vehicles(var_0) {
  switch (var_0) {
    case "runway":
      common_scripts\utility::flag_wait("runway_halfway");
      wait 3;
    case "jungle":
      common_scripts\utility::flag_wait("player_slid");
      common_scripts\utility::flag_wait("player_crossed_river");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        level.river_apache = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("river_chopper");
        level.river_apache maps\_vehicle::mgoff();
      }
    case "river":
      maps\_utility::trigger_wait_targetname("player_waterfall_jump_trig");

      if(common_scripts\utility::flag("choppers_saw_player")) {
        level.river_apache setlookatent(level.player);
      }
    case "waterfall":
      common_scripts\utility::flag_wait("final_read");
      var_1 = spawn_vehicles_throttled("socr_boats", 1);
      thread boat_vo();

      foreach(var_6, var_3 in var_1) {
        if(var_3.script_noteworthy == "left") {
          var_3.animname = "seal_boat1";
          var_3.spawners = getEntArray("left_boat_guys", "targetname");
          var_3 thread boat1_in_sounds();
          var_4 = getent("boat1_clip", "targetname");
          var_4.origin = var_3.origin;
          var_4.angles = var_3.angles;
          var_4 linkto(var_3, "tag_origin");
        } else {
          var_3.animname = "seal_boat2";
          var_3.spawners = getEntArray("right_boat_guys", "targetname");
          var_3 thread dog_on_a_boat();
          var_3 thread man_on_a_boat_waving();
          var_3 thread boat2_in_sounds();
          var_4 = getent("boat2_clip", "targetname");
          var_4.origin = var_3.origin;
          var_4.angles = var_3.angles;
          var_4 linkto(var_3, "tag_origin");
        }

        var_5 = getent("boat_light_ref_ent", "targetname");
        var_3 useanimtree(level.scr_animtree["seal_boat1"]);
        var_3 thread boat_populate();
        var_3 retargetscriptmodellighting(var_5);
      }

      var_7 = common_scripts\utility::get_target_ent("boat_outro");
      var_8 = var_7 common_scripts\utility::spawn_tag_origin();
      var_8 thread maps\_anim::anim_single(var_1, "outro", "tag_origin");

      foreach(var_6, var_3 in var_1) {
        var_3 maps\_vehicle::godon();

        if(common_scripts\utility::flag("choppers_saw_player")) {
          var_10 = [level.apache1, level.river_apache];
          var_10[var_6].enablerocketdeath = 1;
          var_10[var_6].alwaysrocketdeath = 1;
          var_3 thread escape_socr_logic(var_10[var_6]);
        } else
          var_3 thread escape_socr_logic(undefined);

        wait 1.5;
      }
  }
}

boat1_in_sounds() {
  common_scripts\utility::flag_wait("player_surfaces");
  self playSound("scn_jungle_boat1_in");
}

boat2_in_sounds() {
  common_scripts\utility::flag_wait("player_surfaces");
  self playSound("scn_jungle_boat2_in");
}

boat_vo() {
  wait 2;

  if(!common_scripts\utility::flag("choppers_saw_player")) {
    level.player maps\_utility::play_sound_on_entity("jungleg_mko_approachingextractionnow");
  }
  else {
    level.player maps\_utility::play_sound_on_entity("jungleg_mko_cominginhotactual");
  }
}

boat_populate() {
  foreach(var_1 in self.spawners) {
    var_2 = var_1 maps\_utility::spawn_ai(1);
    var_2.script_startingposition = var_1.script_startingposition;
    thread maps\_vehicle_aianim::guy_enter(var_2);
  }
}

man_on_a_boat_waving() {
  var_0 = getent("boat_waver", "targetname");
  wait 5;
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1.animname = "waving_man";
  var_2 = var_1 common_scripts\utility::spawn_tag_origin();
  var_2.origin = self gettagorigin("TAG_TURRET_MIDDLE_RIGHT");
  var_2.angles = self gettagangles("TAG_TURRET_MIDDLE_RIGHT");
  var_2 linkto(self, "TAG_TURRET_MIDDLE_RIGHT", (-11, 0, -45), (0, 0, 0));
  var_1 forceteleport(var_2.origin, var_2.angles);
  var_1 linkto(var_2, "tag_origin");
  var_2 thread maps\_anim::anim_single_solo(var_1, "wave");
}

dog_on_a_boat() {
  var_0 = maps\_utility::spawn_anim_model("riley", self.origin);
  var_0.team = "allies";
  var_0.name = "Riley";
  var_1 = var_0 common_scripts\utility::spawn_tag_origin();
  var_1 thread maps\_anim::anim_loop_solo(var_0, "idle", "stop_loop");
  var_1 linkto(self, "TAG_TURRET_MIDDLE_RIGHT", (-11, 150, -8), (0, 0, 0));
  var_0 linkto(var_1, "tag_origin");

  while(distance(var_0.origin, level.player.origin) > 700) {
    common_scripts\utility::waitframe();
  }

  var_1 notify("stop_loop");
  var_1 maps\_anim::anim_loop_solo(var_0, "sniff", "stop_loop");
}

escape_waterfall_enemies_logic() {
  self.dontevershoot = 1;

  if(common_scripts\utility::cointoss()) {
    maps\_utility::enable_cqbwalk();
  }
}

spawn_vehicles_throttled(var_0, var_1) {
  var_2 = [];
  var_3 = getEntArray(var_0, "targetname");
  var_4 = [];

  foreach(var_6 in var_3) {
    if(!isDefined(var_6.code_classname) || var_6.code_classname != "script_vehicle") {
      continue;
    }
    if(isspawner(var_6)) {
      var_2[var_2.size] = maps\_vehicle_code::_vehicle_spawn(var_6);
    }

    wait(var_1);
  }

  return var_2;
}

escape_socr_logic(var_0) {
  if(self.script_noteworthy == "left") {
    var_1 = "tag_wheel_back_right";
  }
  else {
    var_1 = "tag_wheel_back_left";
  }

  thread escape_socr_fx_loop("splash_large", "tag_splash_front", 0.1, 0.25);
  thread escape_socr_fx_loop("splash_small", "tag_splash_back", 0.1, 0.25);
  wait 2;

  if(common_scripts\utility::flag("choppers_saw_player")) {
    foreach(var_4, var_3 in self.mgturret) {
    var_3 thread escape_socr_turret_own_target(var_0);
    }
  }

  wait 2;
  self notify("stop_fx_on_" + var_1);
  thread escape_socr_fx_loop("splash_small", "tag_splash_front", 0.1, 0.25);
  wait 1;
  self notify("stop_fx_on_tag_splash_front");
  self notify("stop_fx_on_tag_splash_back");
  self notify("stop_fx_on_tag_wheel_back_right");
  self notify("stop_fx_on_tag_wheel_back_left");
  common_scripts\utility::flag_set("obj_all_done");
}

escape_socr_fx_loop(var_0, var_1, var_2, var_3) {
  self notify("stop_fx_on_" + var_1);
  self endon("stop_fx_on_" + var_1);

  for(;;) {
    playFXOnTag(common_scripts\utility::getfx(var_0), self, var_1);
    wait(randomfloatrange(var_2, var_3));
  }
}

#using_animtree("generic_human");

escape_temp_ai_slide(var_0, var_1) {
  if(isDefined(var_0)) {
    common_scripts\utility::flag_wait(var_0);
  }

  var_2 = undefined;

  if(!isDefined(var_1)) {
    var_2 = "jungle_ghost_ai_slide1";
  }
  else {
    var_2 = "jungle_ghost_ai_slide2";
  }

  var_3 = common_scripts\utility::getstruct("ai_slide_anim_ent", "targetname");
  maps\_utility::disable_ai_color();
  maps\_utility::set_forcegoal();

  if(isDefined(self.animname)) {
    if(var_2 == "jungle_ghost_ai_slide1") {
      level.scr_anim[self.animname]["jungle_ghost_ai_slide1"] = % jungle_ghost_ai_slide_guy1;
    }
    else {
      level.scr_anim[self.animname]["jungle_ghost_ai_slide2"] = % jungle_ghost_ai_slide_guy2;
    }
  } else
    self.animname = "generic";

  var_3 maps\_anim::anim_generic_reach(self, var_2);
  maps\_utility::delaythread(1, maps\_utility::enable_ai_color);
  maps\_utility::delaythread(1.5, maps\_utility::unset_forcegoal);
  thread escape_play_slide_fx_on_npc();
  var_3 maps\_anim::anim_single_solo_run(self, var_2);
  self notify("finished slide");
}

escape_play_slide_fx_on_npc() {
  self playSound("foot_slide_npc_start");
  self playLoopSound("foot_slide_npc_loop");
  playFXOnTag(level._effect["slide_npc"], self, "tag_origin");
  self waittill("finished slide");
  stopFXOnTag(level._effect["slide_npc"], self, "tag_origin");
  self stoploopsound("foot_slide_npc_loop");
  self playSound("foot_slide_npc_end");
}

escape_play_slide_fx_on_player() {
  common_scripts\utility::flag_wait("slide_start");
  var_0 = level.player common_scripts\utility::spawn_tag_origin();
  var_0 linkto(level.player);
  level.player playrumbleonentity("damage_heavy");
  level.player common_scripts\utility::delaycall(0.25, ::playrumblelooponentity, "slide_loop");
  level.player common_scripts\utility::delaycall(2.5, ::stoprumble, "slide_loop");
  level.player common_scripts\utility::delaycall(2.55, ::playrumbleonentity, "damage_light");
  thread maps\jungle_ghosts_util::do_bokeh("end n bokeh", "slide_screenspace", 15, 1, 1.1);
  playFXOnTag(level._effect["slide_player"], var_0, "tag_origin");
  wait 1;
  level.player notify("stop_bokeh");
  level.player notify("end mud bokeh");
  stopFXOnTag(common_scripts\utility::getfx("vfx_atmos_bokeh_jungle"), level.player.bokeh_ent, "tag_origin");
  stopFXOnTag(level._effect["slide_player"], var_0, "tag_origin");
  var_0 delete();
}

escape_setup_trees() {
  var_0 = getEntArray("dest_tree", "targetname");
  var_1 = getEntArray("dest_tree_small", "targetname");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);
  common_scripts\utility::array_thread(var_2, ::escape_dest_tree_logic);
  var_3 = getEntArray("do_tree_damage", "targetname");
  common_scripts\utility::array_thread(var_3, ::escape_do_tree_damage_trig_logic, var_0);
  var_4 = common_scripts\utility::getstructarray("player_radius_damage", "targetname");
  common_scripts\utility::array_thread(var_4, ::radius_damage_when_player_is_close);
}

escape_dest_tree_logic() {
  var_0 = common_scripts\utility::get_linked_ents();
  var_1 = common_scripts\utility::add_to_array(var_0, self);
  self.parts = var_0;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    var_4.is_small = 0;

    if(var_4.script_noteworthy == "dest_top_goal") {
      var_2 = var_4.angles;
    }

    if(var_4.model == "ctl_foliage_tree_pine_tall_b_broken_top") {
      var_4.is_small = 1;
    }

    if(var_4.script_noteworthy == "dest_top") {
      foreach(var_6 in var_0) {
        if(var_6.script_noteworthy == "dest_kill_trig") {
          var_4.kill_trig = var_6;
        }
      }
    }
  }

  common_scripts\utility::array_thread(var_1, ::escape_dest_tree_parts_logic, var_2);
}

escape_do_tree_damage_trig_logic(var_0) {
  self waittill("trigger");

  if(!common_scripts\utility::flag("choppers_saw_player")) {
    return;
  }
  var_1 = getent(self.target, "targetname");
  magic_missile_fire_at_ent(var_1, 6);
  wait 1;
  var_0 = common_scripts\utility::get_array_of_closest(var_1.origin, var_0);
  var_0[0] dodamage(100, (0, 0, 0));
}

escape_dest_tree_parts_logic(var_0) {
  switch (self.script_noteworthy) {
    case "pristine":
      maps\_utility::ent_flag_init("destroyed");
      self setCanDamage(1);
      self setCanRadiusDamage(1);

      for(;;) {
        var_1 = undefined;
        self waittill("damage", var_2, var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

        if(var_1.classname == "worldspawn") {
          break;
        }
      }

      maps\_utility::array_notify(self.parts, "tree_destroyed");
      maps\_utility::ent_flag_set("destroyed");
      self hide();
      break;
    case "dest_top":
      if(isDefined(self.is_small) && self.is_small) {
        var_10 = randomintrange(2, 4);
        var_11 = maps\_utility::groundpos(self.origin);
        var_12 = common_scripts\utility::getfx("tree_dust_small");
        var_13 = 0;
        var_14 = "jungle_tree_small_fall";
        var_15 = "jungle_tree_small_land";
      } else {
        var_10 = randomintrange(2, 3);
        var_11 = maps\_utility::groundpos(self.kill_trig.origin);
        var_12 = common_scripts\utility::getfx("tree_dust");
        var_13 = 1;
        var_14 = "jungle_tree_fall";
        var_15 = "jungle_tree_land";
      }

      self hide();
      self.clip_brush = getent(self.target, "targetname");
      self.clip_brush linkto(self);
      self waittill("tree_destroyed");
      playFX(common_scripts\utility::getfx("tree_explosion"), self.origin);
      self show();

      if(isDefined(self.script_parameters) || isDefined(self.script_index)) {
        break;
      }

      self playSound("explo_tree");
      earthquake(0.3, 0.5, level.player.origin, 300);
      level.player playrumbleonentity("grenade_rumble");
      common_scripts\utility::noself_delaycall(var_10 * 0.8, ::playfx, var_12, var_11);
      self.final_angles = var_0;
      self rotateto(var_0, var_10, var_10 * 0.9, var_10 * 0.1);
      var_16 = common_scripts\utility::spawn_tag_origin();
      var_16.origin = var_16.origin + (0, 0, 375);
      var_16 linkto(self);

      if(!self.is_small) {
        self.kill_trig thread falling_tree_player_detection(var_10, self.clip_brush);
      }

      thread maps\_utility::play_sound_on_entity(var_14);
      var_16 thread play_impact_sound(var_15);
      wait(var_10 * 0.95);
      self.og_angles = self.angles;
      wait(var_10 * 0.05);
      thread after_fall_bounce();

      if(var_13) {
        earthquake(0.7, 0.6, var_11, 1000);
      }

      break;
    case "dest_top_goal":
      self delete();
      break;
    case "dest_bottom":
      self hide();
      self waittill("tree_destroyed");
      self show();
      break;
    default:
      break;
  }
}

after_fall_bounce() {
  var_0 = 0.7;
  self rotateto(self.og_angles, var_0, var_0 / 2, var_0 / 2);
  wait(var_0);
  self rotateto(self.final_angles, var_0, var_0 / 2, var_0 / 2);
}

play_impact_sound(var_0) {
  self playSound(var_0, "sound_done");
  level.player playrumbleonentity("damage_heavy");
  self waittill("sound_done");
  self delete();
}

radius_damage_when_player_is_close() {
  level endon("player_at_river");

  if(common_scripts\utility::flag("choppers_saw_player")) {
    var_0 = 1000000;

    for(;;) {
      var_1 = distancesquared(self.origin, level.player.origin);

      if(var_1 <= var_0) {
        radiusdamage(self.origin, 186, 100, 100);
        return;
      }

      wait 0.25;
    }
  }
}

falling_tree_player_detection(var_0, var_1) {
  var_0 = var_0 - 0.25;
  wait(var_0);
  var_1 disconnectpaths();
  self endon("timeout");
  thread maps\_utility::notify_delay("timeout", 1);

  for(;;) {
    if(level.player istouching(self)) {
      level notify("new_quote_string");
      setdvar("ui_deadquote", &"jungle_ghosts_obit_tree");
      level.player kill();
      return;
    }

    wait 0.05;
  }
}

escape_fake_underwater_bullets() {
  level endon("player_surfaces");
  var_0 = 26;
  var_1 = [];
  var_1[0] = "whizby_near_00_r";
  var_1[1] = "whizby_near_00_l";

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = randomintrange(-25, 25);
    var_4 = vectornormalize(self.origin - level.player.origin);
    var_5 = level.player.origin + var_4 * randomintrange(85, 100);
    var_5 = var_5 + (var_3, var_3, 0);
    var_6 = vectortoangles(var_4);
    var_7 = anglestoup(var_6);
    playFX(common_scripts\utility::getfx("underwater_bullet"), var_5, var_4, var_7);

    if(common_scripts\utility::cointoss()) {
      thread common_scripts\utility::play_sound_in_space("bullet_large_water", var_5);
    }

    level.player thread maps\_utility::play_sound_on_entity(common_scripts\utility::random(var_1));
    wait(randomfloatrange(0.1, 0.35));
  }
}