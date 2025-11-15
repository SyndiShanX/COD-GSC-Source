/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_beacon_vignettes.gsc
*************************************************/

main() {
  vignette_precache();
  level.custom_onstartgametypefunc = ::vignettes_startup;
  thread test_calls();
  thread hide_wall_pieces();
}

vignettes_startup() {}

test_calls() {}

vignette_precache() {
  common_scripts\utility::flag_init("ready_for_gas_event");
  common_scripts\utility::flag_init("gas_event_done");
  common_scripts\utility::flag_init("boss_is_spawned");
  common_scripts\utility::flag_init("clear_for_crane_vo");
  common_scripts\utility::flag_init("cargo_control_room_vo_played");
  common_scripts\utility::flag_init("everyone_in_cargo_container");
  common_scripts\utility::flag_init("boss_in_pain");
  common_scripts\utility::flag_init("is_crane_nags");
  common_scripts\utility::flag_init("boss_turrets_on");
  common_scripts\utility::flag_init("delay_UGV_VO");
  common_scripts\utility::flag_init("no_ass_nag");
}

hide_wall_pieces() {
  while(!isDefined(level.drill))
    wait 0.05;

  level.wall_array_damaged = getEntArray("mini_boss_wall_damaged", "targetname");

  foreach(var_1 in level.wall_array_damaged)
  var_1 hide();

  var_3 = getent("miniboss_door_clip", "targetname");
  var_3 connectpaths();
  var_3 notsolid();
  var_4 = getscriptablearray("miniboss_door", "targetname");
  wait 0.05;
  var_4[0] setscriptablepartstate(0, 0);
  var_5 = getscriptablearray("swinging_wires", "targetname");
  wait 0.05;
  var_5[0] setscriptablepartstate(0, 5);
  var_6 = getscriptablearray("twisted_metal", "targetname");
  var_6[0] setscriptablepartstate(0, 5);
  thread first_door_vo();
  var_7 = getEntArray("cross_wall_swap_in", "targetname");

  foreach(var_9 in var_7)
  var_9 hide();
}

mini_boss() {
  while(!isDefined(level.drill))
    wait 0.05;

  thread door_notify_check();

  for(;;) {
    level waittill("drill_planted", var_0, var_1);

    if(var_1.target == "well_deck_3") {
      break;
    }
  }

  thread pre_miniboss_vo();
  level.damaged_positions = [];
  level.damaged_positions["1"] = [(-1408, 56, -128), (0, 152, 0)];
  level.damaged_positions["2"] = [(-1574.5, 108.1, -42.7), (0, 75.6, 0)];
  level.damaged_positions["3"] = [(-1504, 82, -128), (0, 126, 0)];
  level.damaged_positions["4"] = [(-1580, 108.1, -82.7), (0, 90, 0)];
  level.damaged_positions["5"] = [(-1570.5, 136, -51.5), (0, 270, 166.5)];
  level.damaged_positions["6"] = [(-1563.1, 136, -29), (0, 270, 162.2)];
  level.damaged_positions["7"] = [(-1550.7, 136.1, -8.6), (0, 270, 148.2)];
  level.damaged_positions["8"] = [(-1366.1, 227.6, -127.5), (296.567, 229.145, 19.2909)];
  level.damaged_positions["9"] = [(-1540.1, 185.3, 90), (351.097, 256.089, 16.4567)];
  level.damaged_positions["10"] = [(-1567, 211.5, 163), (347.824, 359.491, 5.78545)];
  level.damaged_positions["11"] = [(-1454, 730, -128), (0, 314, 0)];
  level.damaged_positions["12"] = [(-1580, 708.1, -42.7), (0, 90, 0)];
  level.damaged_positions["13"] = [(-1530, 702, -128), (0, 186, 0)];
  level.damaged_positions["14"] = [(-1580, 708.1, -82.7), (0, 90, 0)];
  wait 3;
  var_2 = getscriptablearray("swinging_wires", "targetname");
  var_3 = getscriptablearray("twisted_metal", "targetname");
  maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::initkrakententacle();
  level.miniboss = maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::alienminibosstentaclespawn();
  level.miniboss thread miniboss_emissive();
  level.miniboss thread maps\mp\mp_alien_beacon_fx::fx_tenticle_enter_water_fx();
  var_3[0] setscriptablepartstate(0, 3);
  var_2[0] setscriptablepartstate(0, 3);
  level.miniboss maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("miniboss_fight", 0, "miniboss_fight", "end", ::doornotetrackhandler);
  level.miniboss.idle = 0;
  level.miniboss.left = 0;
  level.miniboss notify("left_is_defined");
  level.miniboss.right = 0;
  level.miniboss thread miniboss_health_watcher();

  while(!isDefined(level.miniboss_beaten)) {
    var_4 = randomintrange(0, 5);

    if(common_scripts\utility::flag("boss_in_pain")) {
      var_4 = -9000;
      level.miniboss maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("miniboss_fight", 4, "miniboss_fight", "end", ::painnotetrackhandler);
      level.miniboss.idle = 1;
      level.miniboss.left = 0;
      level.miniboss.right = 0;
      common_scripts\utility::flag_clear("boss_in_pain");
      level.miniboss.spawncooling = undefined;
    }

    if(var_4 == 0 && level.miniboss.idle == 0) {
      var_3[0] setscriptablepartstate(0, 7);
      var_2[0] setscriptablepartstate(0, 7);
      level.miniboss maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("miniboss_fight", 1, "miniboss_fight", "end", ::idlenotetrackhandler);
      level.miniboss.idle = 1;
      level.miniboss.left = 0;
      level.miniboss.right = 0;
      level.miniboss.spawncooling = undefined;
    }

    if(var_4 == 1 && level.miniboss.left < 1) {
      var_3[0] setscriptablepartstate(0, 1);
      var_2[0] setscriptablepartstate(0, 1);
      level.miniboss maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("miniboss_fight", 2, "miniboss_fight", "end", ::smashnotetrackhandler);
      level.miniboss.idle = 0;
      level.miniboss.left = level.miniboss.left + 1;
      level.miniboss.right = 0;
      level.miniboss.spawncooling = undefined;
    }

    if(var_4 == 2 && level.miniboss.right < 1) {
      var_3[0] setscriptablepartstate(0, 2);
      var_2[0] setscriptablepartstate(0, 2);
      level.miniboss maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("miniboss_fight", 3, "miniboss_fight", "end", ::smashnotetrackhandler);
      level.miniboss.idle = 0;
      level.miniboss.left = 0;
      level.miniboss.right = level.miniboss.right + 1;
      level.miniboss.spawncooling = undefined;
    }

    if(var_4 >= 3 && !isDefined(level.miniboss.spawncooling)) {
      var_3[0] setscriptablepartstate(0, 6);
      var_2[0] setscriptablepartstate(0, 6);
      level.miniboss maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("miniboss_fight", 5, "miniboss_fight", "end", ::spawnnotetrackhandler);
      level.miniboss.idle = 0;
      level.miniboss.spawncooling = 1;
    }
  }

  var_3[0] setscriptablepartstate(0, 4);
  var_2[0] setscriptablepartstate(0, 4);
  level notify("dlc_vo_notify", "kraken_vo", "tentacle_gone");
  level.miniboss maps\mp\agents\_scriptedagents::playanimnuntilnotetrack("miniboss_fight", 6, "miniboss_fight", "end", ::endnotetrackhandler);
  maps\mp\alien\_outline_proto::disable_outline_for_players(level.miniboss, level.players);
  level.miniboss.vignette_death_skip = 1;
  level.miniboss suicide();
}

miniboss_emissive() {
  wait 3.0;
  maps\mp\alien\_utility::set_alien_emissive(2.0, 1.0);
  level waittill("tentacle_gone");
  maps\mp\alien\_utility::set_alien_emissive_default(6);
}

door_notify_check() {
  level waittill("door_opening");
  level notify("miniboss_door_is_open");
}

doornotetrackhandler(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_origin", (-1696, 400, -56));

  switch (var_0) {
    case "play_scriptable":
      var_5 = getscriptablearray("miniboss_door", "targetname");
      var_5[0] setscriptablepartstate(0, 1);
      break;
    case "hit_1":
      var_4 playSound("scn_bcn_miniboss_spawn");
      common_scripts\utility::exploder(13);
      common_scripts\utility::exploder(14);
      thread play_tentacle_music();
      break;
    case "hit_2":
      common_scripts\utility::exploder(13);
      thread miniboss_wall_knockback(1750);
      break;
    case "door_breach_fx":
      common_scripts\utility::exploder(12);
      break;
    case "enter_splash_fx":
      break;
    case "hit_3":
      thread miniboss_wall_swap();
      thread miniboss_wall_clip();
      var_6 = (-1696, 400, -56);
      earthquake(0.4, 0.4, var_6, 2048);
      playrumbleonposition("grenade_rumble", var_6);
      thread create_smashedwall_storm_sfx();

      foreach(var_8 in level.players) {
        if(distance(var_8.origin, var_6) <= 128) {
          var_8 setvelocity(vectornormalize(var_8.origin - var_6) * 800);
          var_8 dodamage(var_8.maxhealth / 3, var_6);
        }
      }

      var_10 = getscriptablearray("swinging_wires", "targetname");
      var_11 = getscriptablearray("twisted_metal", "targetname");
      break;
    case "ten_spawn_sfx":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("scn_bcn_miniboss_enter", "tag_hole", 6);
      break;
    default:
      break;
  }
}

miniboss_wall_swap() {
  var_0 = getEntArray("mini_boss_wall_undamaged", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_parameters)) {
      var_1[var_1.size] = var_3;
      continue;
    }

    var_3 delete();
  }

  foreach(var_3 in level.wall_array_damaged)
  var_3 show();

  foreach(var_3 in var_1) {
    var_8 = var_3.script_parameters;
    var_3.origin = level.damaged_positions[var_8][0];
    var_3.angles = level.damaged_positions[var_8][1];
    wait 0.1;
  }
}

miniboss_wall_clip() {
  thread miniboss_wall_knockback(1750);
  wait 1.0;
  var_0 = getent("miniboss_door_clip", "targetname");
  var_0 solid();
  var_0 disconnectpaths();
}

miniboss_wall_knockback(var_0) {
  var_1 = 1500.0;
  var_2 = 34225;
  var_3 = (-1590, 279, -136);
  var_4 = (-1590, 528, -136);

  foreach(var_6 in level.players) {
    if(distance2dsquared(var_6.origin, var_3) < var_2)
      var_7 = var_3;
    else if(distance2dsquared(var_6.origin, var_4) < var_2)
      var_7 = var_4;
    else
      continue;

    var_8 = var_6 getvelocity();
    var_9 = vectornormalize((var_6.origin - var_7) * (1, 1, 0)) * var_0;
    var_10 = (var_8 + var_9) * (1, 1, 0);
    var_11 = length(var_10);

    if(var_11 >= var_1)
      var_10 = vectornormalize(var_10) * var_1;

    var_6 setvelocity(var_10);
  }
}

play_miniboss_kraken_vocal() {
  wait(randomfloatrange(1.8, 2.5));
  playsoundatpos((-2350, 222, -66), "scn_bcn_miniboss_vo");
}

create_smashedwall_storm_sfx() {
  var_0 = spawn("script_origin", (-1680, 220, -66));
  var_1 = spawn("script_origin", (-1614, 570, -66));
  wait 0.1;
  var_0 playLoopSound("emt_bcn_storm_lt");
  var_1 playLoopSound("emt_bcn_storm_rt");
}

create_smashedwall2_storm_sfx() {
  var_0 = spawn("script_origin", (-423, 6459, 1508));
  var_1 = spawn("script_origin", (-303, 6415, 1508));
  var_2 = spawn("script_origin", (-213, 6450, 1508));
  var_3 = spawn("script_origin", (-347, 6423, 1508));
  var_4 = spawn("script_origin", (-273, 6399, 1508));
  wait 0.1;
  var_0 playLoopSound("emt_bcn_storm_lt");
  var_2 playLoopSound("emt_bcn_storm_rt");
  var_3 playLoopSound("emt_bcn_rain_01");
  var_4 playLoopSound("emt_bcn_rain_02");
  var_1 playLoopSound("emt_bcn_wind");
}

smashnotetrackhandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "hit_left":
      level notify("left_is_hit");
      var_4 = level.miniboss gettagorigin("Tag_hole");
      var_5 = spawn("script_origin", var_4);
      var_5 playSound("scn_bcn_miniboss_pound");
      thread play_miniboss_kraken_vocal();
      earthquake(0.4, 0.4, var_4, 1024);

      foreach(var_7 in level.players) {
        if(!isDefined(self.laststand))
          var_7 shellshock("alien_spitter_gas_cloud", 1);
      }

      playrumbleonposition("artillery_rumble", var_4);
      common_scripts\utility::exploder(15);

      foreach(var_7 in level.players) {
        var_10 = distance(var_7.origin, var_4);

        if(var_10 <= 512) {
          var_7 setvelocity(vectornormalize(var_7.origin - var_4) * ((512 - var_10) * 2));
          var_7 dodamage(var_7.maxhealth / 10, var_4);
        }
      }

      wait 0.1;
      var_5 delete();
      break;
    case "hit_right":
      var_4 = level.miniboss gettagorigin("Tag_hole");
      var_5 = spawn("script_origin", var_4);
      var_5 playSound("scn_bcn_miniboss_pound");
      thread play_miniboss_kraken_vocal();
      earthquake(0.4, 0.4, var_4, 1024);

      foreach(var_7 in level.players) {
        if(!isDefined(self.laststand))
          var_7 shellshock("alien_spitter_gas_cloud", 1);
      }

      playrumbleonposition("artillery_rumble", var_4);
      common_scripts\utility::exploder(16);

      foreach(var_7 in level.players) {
        var_10 = distance(var_7.origin, var_4);

        if(var_10 <= 512) {
          var_7 setvelocity(vectornormalize(var_7.origin - var_4) * ((512 - var_10) * 2));
          var_7 dodamage(var_7.maxhealth / 10, var_4);
        }
      }

      wait 0.1;
      var_5 delete();
      break;
    default:
      break;
  }
}

spawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "ten_spit_sfx":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("scn_bcn_miniboss_spit", "tag_hole", 8);
      break;
    case "ten_spawn":
      var_4 = getspawnpoint();
      spawn_alien_from_miniboss(var_4);
      var_4 delete();
      break;
    case "drool_fx":
      break;
    case "teeth_splash":
      break;
  }
}

idlenotetrackhandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "drool_fx":
      break;
    case "teeth_splash_idle":
      break;
    case "ten_idle_sfx":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("scn_bcn_miniboss_idle", "tag_hole", 7);
      break;
  }
}

painnotetrackhandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "drool_fx":
      break;
    case "ten_pain_sfx":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("scn_bcn_miniboss_pain", "tag_hole", 5);
      break;
  }
}

endnotetrackhandler(var_0, var_1, var_2, var_3) {
  switch (var_0) {
    case "ten_pain_sfx":
      thread maps\mp\mp_alien_beacon::beacon_play_sound_on_moving_tag("scn_bcn_miniboss_pain", "tag_hole", 5);
      thread play_miniboss_kraken_vocal();
      break;
    default:
      break;
  }
}

getspawnpoint() {
  var_0 = "Tag_hole";
  var_1 = self gettagorigin(var_0);
  var_2 = self gettagorigin(var_0);
  var_3 = spawn("script_origin", var_1);
  var_3.angles = var_2;
  return var_3;
}

miniboss_health_watcher() {
  var_0 = int(10000 * gettentaclehealthscalar(level.players.size));
  maps\mp\alien\_gamescore::update_team_encounter_performance("tentacle_bonus", "tentacle_start_HP", var_0);
  level.miniboss.hp = var_0;
  var_1 = level.players.size;
  var_2 = 3;
  var_3 = level.miniboss.hp * 0.25;

  while(!isDefined(level.miniboss_beaten)) {
    level.miniboss waittill("miniboss_damaged");

    if(var_1 < level.players.size) {
      var_4 = 10000 * gettentaclehealthscalar(level.players.size - var_1);
      maps\mp\alien\_gamescore::update_team_encounter_performance("tentacle_bonus", "tentacle_start_HP", var_4);
      level.miniboss.hp = int(level.miniboss.hp + var_4);
      var_1 = level.players.size;
      var_3 = level.miniboss.hp * (0.25 * var_2);
    }

    if(level.miniboss.hp <= 0) {
      level.miniboss_beaten = 1;
      level notify("miniboss_beaten");
    }

    if(var_2 > 0 && level.miniboss.hp < var_3) {
      var_2 = var_2 - 1;
      var_3 = level.miniboss.hp * (0.25 * var_2);
      common_scripts\utility::flag_set("boss_in_pain");
    }
  }
}

gettentaclehealthscalar(var_0) {
  switch (var_0) {
    case 1:
      return 0.2;
    case 2:
      return 0.3;
    case 3:
      return 0.8;
  }

  return 1.0;
}

play_tentacle_music() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    if(!common_scripts\utility::flag("exfil_music_playing"))
      level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc2_tentacle");
  }
}

outlineprep() {
  foreach(var_1 in level.players)
  var_1 thread miniboss_ountline_logic(self);
}

miniboss_ountline_logic(var_0) {
  self endon("disconnect");

  while(!isDefined(level.miniboss_beaten)) {
    while(!isDefined(self.isferal))
      wait 0.1;

    if(isDefined(var_0))
      maps\mp\alien\_outline_proto::enable_outline_for_player(var_0, self, 4, 1, "high");

    self waittill("unset_adrenaline");

    if(isDefined(var_0))
      maps\mp\alien\_outline_proto::disable_outline_for_player(var_0, self);

    wait 0.05;
  }
}

spawncool() {
  var_0 = 5;
  var_1 = gettime();
  var_2 = gettime() - var_0 * 1000;

  while(var_2 < var_1) {
    var_2 = gettime() - var_0 * 1000;
    wait 1;
  }

  self.spawncooling = undefined;
}

radial_damage(var_0) {
  foreach(var_2 in level.players) {
    if(distance(var_2.origin, var_0) <= 256) {
      var_2 setvelocity(vectornormalize(var_2.origin - var_0) * 1200);
      var_2 dodamage(var_2.maxhealth / 6, var_0);
    }
  }
}

spawn_alien_from_miniboss(var_0) {
  if(!isDefined(self.last_spawned))
    self.last_spawned = "wave minion";

  if(isDefined(var_0)) {
    var_1 = [];
    var_1 = maps\mp\alien\_spawnlogic::get_alive_agents();

    if(var_1.size <= 15) {
      if(level.players.size == 1 && self.last_spawned == "wave minion") {
        spawn_single_alien(var_0, "wave goon");
        self.last_spawned = "wave goon";
      } else {
        if(level.players.size == 1 && self.last_spawned != "wave minion") {
          spawn_single_alien(var_0, "wave minion");
          self.last_spawned = "wave minion";
          return;
        }

        var_2 = randomintrange(0, level.players.size + 1);

        if(var_2 == 0) {
          spawn_single_alien(var_0, "wave minion");
          self.last_spawned = "wave minion";
          return;
        }

        spawn_single_alien(var_0, "wave brute");
        self.last_spawned = "wave brute";
      }
    }
  }
}

set_up_blast_doors() {
  if(!isDefined(level.blast_doors_lifted)) {
    level.blast_doors_lifted = 1;
    level thread listen_and_lift_doors();
  }
}

listen_and_lift_doors() {
  var_0 = 1;
  var_1 = 0;
  var_2 = 0;

  while(!var_1) {
    if(level.blast_doors_lifted > 3) {
      if(var_0) {
        var_0 = 0;
        delay_vo_until_all_clear(15);
        wait 2.0;
      }

      if(level.blast_doors_lifted > var_2) {
        level thread lift_door_by_index(var_2);
        var_2++;

        if(var_2 >= 3)
          var_1 = 1;
      }
    }

    wait 0.1;
  }
}

pause_once_until_ready() {}

lift_door_by_index(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 0:
      var_1 = getEntArray("door0", "targetname");
      thread sfx_blast_door_move();
      break;
    case 1:
      var_1 = getEntArray("door1", "targetname");
      break;
    case 2:
      var_1 = getEntArray("door2", "targetname");
      break;
    default:
      break;
  }

  if(isDefined(var_1)) {
    foreach(var_4, var_3 in var_1)
    var_3 thread lift_door();
  }
}

lift_door() {
  var_0 = self.origin + (0, 0, 200);
  self moveto(var_0, 5);
  wait 6.0;
  self delete();
  level notify("blast_door_lifted");
}

sfx_blast_door_move() {
  wait 0.04;
  playsoundatpos((-309, 1224, 511), "scn_beacon_blast_doors");
}

setup_gas_encounter() {
  level endon("game_ended");
  thread pre_gas_event_vo();
  thread kill_gas_fog();
  common_scripts\utility::flag_wait("ready_for_gas_event");
  var_0 = getent("gas_chamber_trigger", "targetname");
  thread gas_console_marker(var_0);
  var_1 = spawnfx(level._effect["blinkylight_green"], var_0.origin + (-7, 2, 2));
  triggerfx(var_1);
  level thread players_use_gas_monitor(var_0);

  while(!are_all_players_using_gas())
    wait 0.05;

  level notify("all_players_using_gas");

  foreach(var_3 in level.players)
  var_3 forceusehintoff(&"MP_ALIEN_BEACON_GAS_HINT");

  thread gas_encounter_start_sfx();
  thread play_gas_chamber_fx();
  var_1 delete();
  level.gas_event_active = 1;
  level thread gas_exploit_fix();
  lab_gas_survival_encounter();
}

players_use_gas_monitor(var_0) {
  level endon("game_ended");
  level endon("all_players_using_gas");

  foreach(var_2 in level.players)
  var_2 thread watch_for_use_gas_trigger(var_0);

  for(;;) {
    level waittill("connected", var_2);
    var_2 thread watch_for_use_gas_trigger(var_0);
  }
}

are_all_players_using_gas() {
  var_0 = 1;

  foreach(var_2 in level.players) {
    if(!isDefined(var_2.player_using_gas) || !var_2.player_using_gas)
      var_0 = 0;
  }

  return var_0;
}

watch_for_use_gas_trigger(var_0) {
  level endon("game_ended");
  level endon("all_players_using_gas");
  self endon("disconnect");
  self notify("watch_for_use_gas");
  self endon("watch_for_use_gas");
  self.player_using_gas = 0;
  var_1 = & "MP_ALIEN_BEACON_GAS_HINT";
  var_2 = 24336;

  for(;;) {
    if(self ismeleeing() || self isthrowinggrenade() || !self isonground() || self getstance() == "prone")
      self forceusehintoff(var_1);
    else if(player_looking_at(var_0.origin, 0.6)) {
      if(distancesquared(self getEye(), var_0.origin) < var_2) {
        self forceusehinton(var_1);

        if(self usebuttonpressed()) {
          self.player_using_gas = 1;
          self notify("using_gas");
          thread reset_gas_usage();
        }
      } else
        self forceusehintoff(var_1);
    } else
      self forceusehintoff(var_1);

    wait 0.05;
  }
}

reset_gas_usage() {
  level endon("game_ended");
  level endon("all_players_using_gas");
  self endon("death");
  self endon("disconnect");
  self endon("using_gas");
  wait 0.5;
  self.player_using_gas = 0;
}

player_looking_at(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0.8;

  var_2 = self getEye();
  var_3 = vectortoangles(var_0 - var_2);
  var_4 = anglesToForward(var_3);
  var_5 = self getplayerangles();
  var_6 = anglesToForward(var_5);
  var_7 = vectordot(var_4, var_6);

  if(var_7 < var_1)
    return 0;

  var_8 = bulletTrace(var_0, var_2, 0);
  return var_8["fraction"] == 1;
}

gas_exploit_fix() {
  level notify("stop_teleport_script");
  thread maps\mp\mp_alien_beacon::update_override_info((-215.6, 4342.5, 1168), (0, 90, 0));
  var_0 = [];
  var_0 = getEntArray("deck_to_lab_door", "targetname");
  var_1 = getent("deck_to_lab_door_linker", "targetname");

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && isDefined(var_1))
      var_3 linkto(var_1);
  }

  var_1 movez(-92, 1.5, 0.1, 0.4);
}

teleport_player_to_labs(var_0) {
  self endon("disconnect");
  thread teleport_black_screen();
  wait 1;
  self cancelmantle();
  self dontinterpolate();
  self setorigin(var_0);
  var_1 = (0, 90, 0);
  self setplayerangles(var_1);
  self notify("teleport_finished");
}

teleport_black_screen() {
  self endon("disconnect");
  self.teleport_overlay = newclienthudelem(self);
  self.teleport_overlay.x = 0;
  self.teleport_overlay.y = 0;
  self.teleport_overlay setshader("black", 640, 480);
  self.teleport_overlay.alignx = "left";
  self.teleport_overlay.aligny = "top";
  self.teleport_overlay.sort = 1;
  self.teleport_overlay.horzalign = "fullscreen";
  self.teleport_overlay.vertalign = "fullscreen";
  self.teleport_overlay.alpha = 0;
  self.teleport_overlay.foreground = 1;
  self.teleport_overlay fadeovertime(0.75);
  self.teleport_overlay.alpha = 1;
  self waittill("teleport_finished");
  self.teleport_overlay fadeovertime(0.75);
  self.teleport_overlay.alpha = 0;
  wait 1;
  self.teleport_overlay destroy();
}

lab_gas_survival_encounter() {
  thread gas_fail_counter();
  var_0 = [];
  level.gas_ents = [];
  level.gas_zones = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_2 = getent("gas_attack_point_" + var_1, "targetname");
    var_0[var_1] = var_2;
    var_2 thread gas_attak_point_logic();
    level.gas_zones[level.gas_zones.size] = var_2 common_scripts\utility::get_target_ent();
  }

  wait 0.1;
  var_3 = 240;
  setomnvar("ui_alien_boss_status", 2);
  setomnvar("ui_alien_boss_icon", 3);
  setomnvar("ui_alien_boss_progression", 100);
  level.encounter_name = "lab_area_main";
  spawn_wave(13);
  thread remove_back_wall(var_3);
  timer(var_3);
  release_gas_fog("end");
  thread post_gas_event_vo();

  foreach(var_5 in var_0) {
    maps\mp\alien\_outline_proto::disable_outline_for_players(var_5, level.players);
    var_5 freeentitysentient();
  }

  foreach(var_5 in level.gas_ents)
  var_5 delete();

  foreach(var_5 in level.gas_zones) {
    var_5 notify("gas_done");
    var_5 delete();
  }

  setomnvar("ui_alien_boss_status", 0);
  level notify("stop_waves");
  level notify("end_cycle");
  level notify("alien_cycle_ended");
  common_scripts\utility::flag_set("gas_event_done");
  thread open_doors_to_map_room();
  var_11 = getEntArray("lab_area_main", "targetname");
  level.encounter_name = undefined;

  foreach(var_13 in var_11)
  var_13 delete();
}

remove_back_wall(var_0) {
  wait(var_0 - 4);
  var_1 = getEntArray("cross_wall_swap_out", "targetname");

  foreach(var_3 in var_1) {
    var_3 connectpaths();
    var_3 delete();
  }

  var_5 = getEntArray("cross_wall_swap_in", "targetname");

  foreach(var_3 in var_5)
  var_3 show();
}

open_doors_to_map_room() {
  wait 4;
  var_0 = getent("map_room_door_1", "targetname");
  var_1 = var_0 common_scripts\utility::get_target_ent();
  var_1 linkto(var_0);
  var_2 = getent("map_room_door_2", "targetname");
  var_3 = var_2 common_scripts\utility::get_target_ent();
  var_3 linkto(var_2);
  var_1 connectpaths();
  var_3 connectpaths();
  playsoundatpos((-738, 5825, 1471), "scn_beacon_lab_door_open");
  var_0 moveto((212, 5848, 1408), 5, 0, 1);
  var_2 moveto((-788, 5840, 1408), 5, 0, 1);
}

cross_gas_anims() {
  var_0 = getent("cross_body", "targetname");
  var_1 = spawn("script_model", var_0 gettagorigin("J_spine4"));
  var_1 setModel("head_cross_a");
  var_1.angles = var_0 gettagangles("J_spine4");
  var_0 scriptmodelplayanim("mp_alien_beacon_cross_idle");
  var_1 scriptmodelplayanim("mp_alien_beacon_cross_idle");
  level waittill("delete_cross_and_chair");
  var_0 delete();
  var_1 delete();
  var_2 = getEntArray("cross_chair_piece", "targetname");

  foreach(var_4 in var_2)
  var_4 delete();
}

gas_attak_point_logic() {
  self makeentitysentient("allies");
  self.threatbias = 1000;
  self setCanDamage(1);
  self.progresshealth = 200;
  thread gas_point_health_monitor();
  thread prevent_friendly_fire();
}

prevent_friendly_fire() {
  self endon("death");
  self endon("end_cycle");
  self.health = 9999999;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_1.team) && var_1.team == "allies") {
      self.health = self.health + var_0;
      continue;
    }

    if(self.origin[2] > 1350)
      level notify("dlc_vo_notify", "warn_pipes", "warn_pipes_upper");
    else
      level notify("dlc_vo_notify", "warn_pipes", "warn_pipes_lower");

    self.progresshealth = self.progresshealth - var_0;
    playsoundatpos(self.origin, "scn_beacon_cross_gas_pipehit");
  }
}

gas_point_health_monitor() {
  level endon("end_cycle");
  var_0 = self.progresshealth;
  self.start_health = var_0;
  var_1 = 0;
  maps\mp\alien\_outline_proto::enable_outline_for_players(self, level.players, 2, 1, "high");
  self.alarmed = 0;

  while(self.progresshealth > 0) {
    if(self.progresshealth < self.start_health) {
      var_1 = 0;
      self.start_health = self.progresshealth;

      if(self.progresshealth > var_0 * 0.75) {} else if(self.progresshealth > var_0 * 0.5)
        maps\mp\alien\_outline_proto::enable_outline_for_players(self, level.players, 5, 1, "high");
      else if(self.progresshealth > var_0 * 0.25)
        maps\mp\alien\_outline_proto::enable_outline_for_players(self, level.players, 4, 1, "high");
      else {
        maps\mp\alien\_outline_proto::enable_outline_for_players(self, level.players, 1, 1, "high");

        if(self.alarmed == 0) {
          playsoundatpos(self.origin + (0, 0, 40), "scn_beacon_cross_gas_alarm");
          self.alarmed = 1;
        }
      }
    } else {
      var_1 = var_1 + 1;

      if(var_1 >= 50) {
        if(self.progresshealth > var_0 * 0.75) {
          self.progresshealth = var_0;
          var_1 = 0;
        } else if(self.progresshealth > var_0 * 0.5) {
          self.progresshealth = int(floor(var_0 * 0.75));
          var_1 = 0;
        } else if(self.progresshealth > var_0 * 0.25) {
          self.progresshealth = int(floor(var_0 * 0.5));
          var_1 = 0;
        } else {
          self.progresshealth = int(floor(var_0 * 0.25));
          var_1 = 0;
        }
      }
    }

    wait 0.1;
  }

  maps\mp\alien\_gamescore::update_team_encounter_performance("gas", "num_valve_destroyed");
  level notify("valve_dead");
  maps\mp\alien\_outline_proto::disable_outline_for_players(self, level.players);
  var_2 = cross_gas_out_fx();
  level.gas_ents[level.gas_ents.size] = var_2;
  playsoundatpos(self.origin + (0, 0, 40), "scn_beacon_cross_gas_burst");
  playsoundatpos(self.origin + (0, 0, 40), "scn_beacon_cross_gas_start");
  var_3 = spawn("script_origin", self.origin + (0, 0, 40));
  wait 0.1;
  triggerfx(var_2);
  var_3 playLoopSound("scn_beacon_cross_gas_lp_02");
  var_4 = common_scripts\utility::get_target_ent();
  var_4 thread gas_pain_logic(self);
  self freeentitysentient();
}

cross_gas_out_fx() {
  if(self.targetname == "gas_attack_point_0") {
    var_0 = spawnfx(level._effect["beacon_cross_gas_top"], self.origin + (0, 0, 40));
    var_0.angles = var_0.angles + (90, 0, 0);
    return var_0;
  } else if(self.targetname == "gas_attack_point_1") {
    var_0 = spawnfx(level._effect["beacon_cross_gas_top"], self.origin + (0, 0, 40));
    return var_0;
  } else if(self.targetname == "gas_attack_point_2") {
    var_0 = spawnfx(level._effect["beacon_cross_gas_bot"], self.origin + (0, 0, 40));
    var_0.angles = var_0.angles + (90, 0, 0);
    return var_0;
  } else if(self.targetname == "gas_attack_point_3") {
    var_0 = spawnfx(level._effect["beacon_cross_gas_bot"], self.origin + (0, 0, 40));
    return var_0;
  }
}

play_gas_chamber_fx() {
  self endon("gas_event_done");
  self endon("death");
  common_scripts\utility::exploder(33);
  wait 215.5;
  common_scripts\utility::exploder(34);
  wait 24;
  playFX(level._effect["electrical_sparks_20_funner2"], (-288.287, 5798.12, 1496.07), anglesToForward((25, 270, 90)), anglestoup((25, 270, 90)));
  playFX(level._effect["electrical_sparks_20_funner2"], (-286.878, 5825.81, 1449.25), anglesToForward((310, 270, 90)), anglestoup((310, 270, 90)));
}

gas_pain_logic(var_0) {
  self endon("gas_done");
  var_1 = spawn("script_origin", var_0.origin);
  var_1 moveto(var_1.origin - (0, -1472, 0), 10, 0, 0);
  var_1 thread spot_check_for_gas(10);

  for(;;) {
    foreach(var_3 in level.players) {
      if(var_3 istouching(self)) {
        if(!isDefined(var_1.allkill)) {
          if(var_3.origin[1] > var_1.origin[1]) {
            level notify("dlc_vo_notify", "warn_gas");
            var_3 dodamage(var_3.maxhealth * 0.175, var_3.origin);
          }

          continue;
        }

        level notify("dlc_vo_notify", "warn_gas");
        var_3 dodamage(var_3.maxhealth * 0.175, var_3.origin);
      }
    }

    wait 0.5;
  }
}

spot_check_for_gas(var_0) {
  wait(var_0);
  self.allkill = 1;
  common_scripts\utility::flag_wait("gas_event_done");
  self delete();
}

gas_fail_counter() {
  level endon("end_cycle");
  var_0 = 0;

  while(var_0 < 4) {
    level waittill("valve_dead");
    var_0 = var_0 + 1;

    switch (var_0) {
      case 1:
        release_gas_fog("start");
        break;
      case 2:
        release_gas_fog("two pipes");
        break;
      case 3:
        release_gas_fog("three pipes");
        break;
      case 4:
        release_gas_fog("four pipes");
        break;
    }
  }

  release_gas_fog("end");
  maps\mp\gametypes\aliens::alienendgame("axis", maps\mp\alien\_hud::get_end_game_string_index("gas_fail"));
}

spawn_wave(var_0) {
  level endon("stop_waves");
  maps\mp\alien\_spawn_director::start_cycle(var_0);
}

timer(var_0) {
  thread gas_intro_sounds_and_shakes(0.5, 1);
  var_1 = var_0 / 100;
  var_2 = 0;

  while(var_2 <= 100) {
    wait(var_1);
    var_2 = var_2 + 1;

    if(var_2 == 33)
      thread buildup_tentacle_sounds_and_shakes(0.15, 1);

    if(var_2 == 66)
      thread buildup_tentacle_sounds_and_shakes2(0.2, 1.5);

    if(var_2 == 92)
      thread play_cross_gas_music();

    if(var_2 == 97) {
      thread gas_finale_sfx_and_shakes();
      level notify("delete_cross_and_chair");
    }

    setomnvar("ui_alien_boss_progression", 100 - var_2);
  }
}

gas_encounter_start_sfx() {
  level.gas_entity = spawn("script_origin", (-298, 5816, 1468));
  playsoundatpos((-527, 5793, 1468), "scn_drillbot_activate");
  wait 0.2;
  playsoundatpos((-765, 5711, 1651), "scn_beacon_cross_gas_distant");
  wait 0.4;
  playsoundatpos((-298, 5816, 1468), "scn_beacon_cross_gas_start");
  wait 0.1;
  level.gas_entity playLoopSound("scn_beacon_cross_gas_lp");
  wait 238;
  level.gas_entity stoploopsound("scn_beacon_cross_gas_lp");
  wait 0.5;
  level.gas_entity delete();
}

gas_intro_sounds_and_shakes(var_0, var_1) {
  var_2 = (-292, 5782, 1491);
  var_3 = spawn("script_origin", var_2);
  earthquake(var_0, var_1, var_2, 1800);

  foreach(var_5 in level.players)
  playrumbleonposition("grenade_rumble", var_5.origin);

  play_sound_on_player("scn_beacon_cross_gas_quake");
  wait(var_1);
  var_3 delete();
}

buildup_tentacle_sounds_and_shakes(var_0, var_1) {
  var_2 = (-292, 5782, 1491);
  var_3 = spawn("script_origin", var_2);
  earthquake(var_0, var_1, var_2, 1800);
  playsoundatpos((-286, 6269, 1519), "scn_cross_smoke_hit1");

  foreach(var_5 in level.players)
  playrumbleonposition("grenade_rumble", var_5.origin);

  wait(var_1);
  var_3 delete();
}

buildup_tentacle_sounds_and_shakes2(var_0, var_1) {
  var_2 = (-292, 5782, 1491);
  var_3 = spawn("script_origin", var_2);
  earthquake(var_0, var_1, var_2, 1800);
  playsoundatpos((-286, 6269, 1519), "scn_cross_smoke_hit2");

  foreach(var_5 in level.players)
  playrumbleonposition("grenade_rumble", var_5.origin);

  wait(var_1);
  var_3 delete();
}

gas_finale_sfx_and_shakes() {
  var_0 = (-292, 5782, 1491);
  var_1 = spawn("script_origin", var_0);
  playsoundatpos((-286, 6269, 1519), "scn_cross_smoke_hit3_preroar");
  wait 1;
  earthquake(0.45, 1.5, var_0, 1800);
  playsoundatpos((-286, 6269, 1519), "scn_cross_smoke_hit3");

  foreach(var_3 in level.players)
  playrumbleonposition("artillery_rumble", var_3.origin);

  wait 2.5;
  earthquake(0.85, 2.5, var_0, 1800);
  playsoundatpos((-286, 6269, 1519), "scn_cross_smoke_hit4");
  thread create_smashedwall2_storm_sfx();

  foreach(var_3 in level.players)
  playrumbleonposition("artillery_rumble", var_3.origin);

  wait 2.5;
  var_1 delete();
}

play_cross_gas_music() {
  foreach(var_1 in level.players) {
    if(common_scripts\utility::flag("alien_music_playing")) {
      var_1 stoplocalsound("mp_suspense_01");
      var_1 stoplocalsound("mp_suspense_02");
      var_1 stoplocalsound("mp_suspense_03");
      var_1 stoplocalsound("mp_suspense_04");
      var_1 stoplocalsound("mp_suspense_05");
      var_1 stoplocalsound("mp_suspense_06");
      var_1 stoplocalsound("mus_alien_newwave");
      var_1 stoplocalsound("mus_alien_queen");
      common_scripts\utility::flag_clear("alien_music_playing");
    }

    if(!common_scripts\utility::flag("exfil_music_playing"))
      level thread maps\mp\alien\_music_and_dialog::play_alien_music("mus_alien_dlc2_cross");
  }
}

gas_console_marker(var_0) {
  var_1 = "waypoint_alien_blocker";
  var_2 = 14;
  var_3 = 14;
  var_4 = 0.5;
  var_5 = var_0.origin;
  var_6 = 49;
  var_7 = 256;
  var_8 = 100;
  var_9 = maps\mp\alien\_hud::make_waypoint(var_1, var_2, var_3, var_4, var_5);
  var_10 = spawn("trigger_radius", var_5, 0, var_7, var_8);
  var_10 thread watch_trigger_by_player();
  var_10 common_scripts\utility::waittill_any_timeout(var_6, "trigger_by_player");
  var_10 delete();
  var_9 destroy();
}

release_gas_fog(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case "start":
      var_1.startdist = 0;
      var_1.halfwaydist = 4098;
      var_1.red = 0.4417;
      var_1.green = 0.704;
      var_1.blue = 0.381;
      var_1.hdrcolorintensity = 1;
      var_1.maxopacity = 0.1;
      var_1.sunfogenabled = 1;
      var_1.sunred = 0.44;
      var_1.sungreen = 0.53;
      var_1.sunblue = 0.62;
      var_1.hdrsuncolorintensity = 0.5;
      var_1.sundir = (0.488, -0.8, 0.35);
      var_1.sunbeginfadeangle = 0;
      var_1.sunendfadeangle = 45;
      var_1.normalfogscale = 1;
      var_1.skyfogintensity = 0.9;
      var_1.skyfogminangle = -36;
      var_1.skyfogmaxangle = 60;
      var_1.transition_time = 4.0;
      break;
    case "two pipes":
      var_1.startdist = 0;
      var_1.halfwaydist = 4098;
      var_1.red = 0.4417;
      var_1.green = 0.704;
      var_1.blue = 0.381;
      var_1.hdrcolorintensity = 1;
      var_1.maxopacity = 0.3;
      var_1.sunfogenabled = 1;
      var_1.sunred = 0.44;
      var_1.sungreen = 0.53;
      var_1.sunblue = 0.62;
      var_1.hdrsuncolorintensity = 1;
      var_1.sundir = (0.488, -0.8, 0.35);
      var_1.sunbeginfadeangle = 0;
      var_1.sunendfadeangle = 45;
      var_1.normalfogscale = 2;
      var_1.skyfogintensity = 0.9;
      var_1.skyfogminangle = -36;
      var_1.skyfogmaxangle = 60;
      var_1.transition_time = 3.0;
      break;
    case "three pipes":
      var_1.startdist = 0;
      var_1.halfwaydist = 4098;
      var_1.red = 0.4417;
      var_1.green = 0.704;
      var_1.blue = 0.381;
      var_1.hdrcolorintensity = 1;
      var_1.maxopacity = 0.5;
      var_1.sunfogenabled = 1;
      var_1.sunred = 0.44;
      var_1.sungreen = 0.53;
      var_1.sunblue = 0.62;
      var_1.hdrsuncolorintensity = 1;
      var_1.sundir = (0.488, -0.8, 0.35);
      var_1.sunbeginfadeangle = 0;
      var_1.sunendfadeangle = 45;
      var_1.normalfogscale = 3;
      var_1.skyfogintensity = 0.9;
      var_1.skyfogminangle = -36;
      var_1.skyfogmaxangle = 60;
      var_1.transition_time = 2.0;
      break;
    case "four pipes":
      var_1.startdist = 0;
      var_1.halfwaydist = 4098;
      var_1.red = 0.4417;
      var_1.green = 0.704;
      var_1.blue = 0.381;
      var_1.hdrcolorintensity = 1;
      var_1.maxopacity = 0.7;
      var_1.sunfogenabled = 1;
      var_1.sunred = 0.44;
      var_1.sungreen = 0.53;
      var_1.sunblue = 0.62;
      var_1.hdrsuncolorintensity = 1;
      var_1.sundir = (0.488, -0.8, 0.35);
      var_1.sunbeginfadeangle = 0;
      var_1.sunendfadeangle = 45;
      var_1.normalfogscale = 4;
      var_1.skyfogintensity = 0.9;
      var_1.skyfogminangle = -36;
      var_1.skyfogmaxangle = 60;
      var_1.transition_time = 1.0;
      break;
    case "end":
      var_1.startdist = 1024;
      var_1.halfwaydist = 4098;
      var_1.red = 0.39;
      var_1.green = 0.42;
      var_1.blue = 0.46;
      var_1.hdrcolorintensity = 1;
      var_1.maxopacity = 0.43;
      var_1.transition_time = 10.0;
      var_1.sunfogenabled = 1;
      var_1.sunred = 0.44;
      var_1.sungreen = 0.53;
      var_1.sunblue = 0.62;
      var_1.hdrsuncolorintensity = 1;
      var_1.sundir = (0.488, -0.8, 0.35);
      var_1.sunbeginfadeangle = 0;
      var_1.sunendfadeangle = 45;
      var_1.normalfogscale = 4;
      var_1.skyfogintensity = 0.9;
      var_1.skyfogminangle = -36;
      var_1.skyfogmaxangle = 60;
      break;
  }

  level.player playersetexpfog(var_1.startdist, var_1.halfwaydist, var_1.red, var_1.green, var_1.blue, var_1.hdrcolorintensity, var_1.maxopacity, var_1.transition_time, var_1.sunred, var_1.sungreen, var_1.sunblue, var_1.hdrsuncolorintensity, var_1.sundir, var_1.sunbeginfadeangle, var_1.sunendfadeangle, var_1.normalfogscale, var_1.skyfogintensity, var_1.skyfogminangle, var_1.skyfogmaxangle);
}

kill_gas_fog() {
  level endon("alien_cycle_ended");
  level waittill("game_ended");
  release_gas_fog("end");
}

boat_ride_vo() {
  wait 4;
  delay_vo_until_all_clear();
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  wait 1;

  if(common_scripts\utility::cointoss()) {
    play_sound_on_player("beacon_gdf_cif1thisisgodfather");
    wait 7.5;
    play_sound_on_player("beacon_gdf_yourobjectiveisto");
    wait 5.25;
    play_sound_on_player("beacon_gdf_youwillbeaccompaniedby");
    wait 8.5;
    play_sound_on_player("beacon_gdf_keepyourheaddown");
    wait 4;
  } else {
    play_sound_on_player("beacon_gdf_godfathertocif1your");
    wait 7.75;
    play_sound_on_player("beacon_gdf_youlldeploywithan");
    wait 4.9;
    play_sound_on_player("beacon_gdf_beadvisedcif1were");
    wait 5.75;
    play_sound_on_player("beacon_gdf_whateveritisits");
    wait 3.75;
    play_sound_on_player("beacon_gdf_findyourmanand");
    wait 3.5;
  }

  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

first_door_vo() {
  for(;;) {
    level waittill("door_opening", var_0);
    wait 1;

    if(check_door_name(var_0)) {
      break;
    }
  }

  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("beacon_gdf_goodworkotherstashes");
  wait 4.25;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
  level.first_door_opened = 1;
}

check_door_name(var_0) {
  var_1 = ["door_hive_4", "door_hive_6", "cargo_area_main"];

  foreach(var_3 in var_1) {
    if(var_3 == var_0)
      return 0;
  }

  return 1;
}

pre_miniboss_vo() {
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("beacon_gdf_braceforimpact");
  wait 5;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

post_miniboss_vo() {
  delay_vo_until_all_clear(10);
  wait 4;
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("beacon_gdf_headedbackto");
  wait 3.5;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

cargo_room_intro_vo() {
  var_0 = getent("cargo_entrance_vo_trig", "targetname");
  var_0 waittill("trigger");
  wait 3;
  delay_vo_until_all_clear();
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  var_1 = lookupsoundlength("beacon_gdf_findawaytoaccess") / 1000;
  play_sound_on_player("beacon_gdf_findawaytoaccess");
  wait(var_1 + 1);
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

cargo_room_use_ugv_vo() {
  var_0 = getent("use_ugv_vo_trig", "targetname");
  var_0 waittill("trigger");
  level notify("stop_post_hive_vo");

  while(common_scripts\utility::flag("delay_UGV_VO"))
    wait 0.1;

  delay_vo_until_all_clear();
  wait 2;
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  var_1 = lookupsoundlength("beacon_gdf_usethatugv") / 1000;
  play_sound_on_player("beacon_gdf_usethatugv");
  wait(var_1 + 1);
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

cargo_room_hive_two_vo() {
  level notify("stop_post_hive_vo");
  delay_vo_until_all_clear();
  common_scripts\utility::flag_set("delay_UGV_VO");
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  var_0 = lookupsoundlength("beacon_gdf_locatetheasset") / 1000;
  play_sound_on_player("beacon_gdf_locatetheasset");
  wait(var_0 + 1);
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
  common_scripts\utility::flag_clear("delay_UGV_VO");
}

cargo_room_go_to_control_room_vo() {
  level waittill("blast_door_lifted");
  level notify("stop_post_hive_vo");
  delay_vo_until_all_clear(25);
  common_scripts\utility::flag_set("cargo_control_room_vo_played");
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  wait 0.5;
  var_0 = lookupsoundlength("beacon_gdf_thatsitgetup") / 1000;
  play_sound_on_player("beacon_gdf_thatsitgetup");
  wait(var_0 + 1);
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

pre_crane_vo() {
  level waittill("godfathers_explanation");
  common_scripts\utility::flag_set("is_crane_nags");
  level notify("stop_post_hive_vo");
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  var_0 = lookupsoundlength("beacon_gdf_godfathertocif1i") / 1000;
  play_sound_on_player("beacon_gdf_godfathertocif1i");
  wait(var_0 + 1);
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
  common_scripts\utility::flag_clear("is_crane_nags");
  common_scripts\utility::flag_set("clear_for_crane_vo");
  thread cargo_room_get_on_container_vo();
}

crane_vo() {
  common_scripts\utility::flag_wait("clear_for_crane_vo");
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  var_0 = lookupsoundlength("beacon_gdf_drcrosshasbeendesignated") / 1000;
  play_sound_on_player("beacon_gdf_drcrosshasbeendesignated");
  wait(var_0 + 1);
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

lab_entrance_vo() {
  thread cross_gas_anims();
  delay_vo_until_all_clear();
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("beacon_gdf_crossisonthe");
  wait 4;
  play_sound_on_player("beacon_gdf_youllneedtoclear");
  wait 3.5;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

lab_first_hive_vo() {
  delay_vo_until_all_clear();
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("beacon_gdf_remembernoheadshotswe");
  wait 4.1;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

lab_second_hive_vo() {
  delay_vo_until_all_clear();
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("beacon_arc_itriedtokill");
  wait 10;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

pre_gas_event_vo() {
  delay_vo_until_all_clear(45);
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("beacon_arc_thosewindowsarehigh");
  wait 10.5;
  common_scripts\utility::flag_set("ready_for_gas_event");
  play_sound_on_player("beacon_arc_thenkissyourarse");
  wait 5;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
  thread gas_event_nag();
}

gas_event_nag() {
  wait 15;

  if(!isDefined(level.gas_event_active)) {
    thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
    play_sound_on_player("beacon_arc_triggerthealarmto");
    wait 3;
    thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
  }

  wait 15;

  if(!isDefined(level.gas_event_active))
    level notify("dlc_vo_notify", "start_containment");
}

post_gas_event_vo() {
  var_0 = getent("post_gas_vo_trig", "targetname");
  var_0 waittill("trigger");
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  var_1 = randomintrange(0, 3);

  if(var_1 == 0) {
    play_sound_on_player("beacon_gdf_howdidyoumanageto");
    wait 4;
  } else if(var_1 == 1) {
    play_sound_on_player("beacon_gdf_unlessshesproutedgills");
    wait 4.75;
  } else {
    play_sound_on_player("beacon_gdf_whereiscrosswhat");
    wait 3;
  }

  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
  thread pre_boss_vo();
}

pre_boss_vo() {
  common_scripts\utility::flag_wait("boss_is_spawned");
  wait 22;
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("beacon_gdf_cif1takethatthing");
  wait 6;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

post_boss_vo() {
  wait 4;
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  play_sound_on_player("beacon_gdf_goodworkcif1ive");
  wait 9;
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

play_sound_on_player(var_0) {
  foreach(var_2 in level.players) {
    if(isDefined(var_2)) {
      var_2 playSound(var_0);
      break;
    }
  }
}

drill_teleport(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
  var_3 waittill("trigger");
  level.drill_vehicle vehicle_teleport(var_1, var_2);
}

drill_swap() {
  var_0 = getent("drill_boat_spawn", "targetname");
  var_0.origin = var_0.origin + (0, 0, -10);
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("mp_laser_drill");
  var_2 = getent("intro_hovercraft", "targetname");
  var_1 linkto(var_2);
  common_scripts\utility::flag_wait("boat_ride_over");
  level notify("spawn_beacon_drill", var_1.origin, var_1.angles);
  var_1 delete();
  var_0 delete();
}

spawn_single_alien(var_0, var_1) {
  var_2 = maps\mp\gametypes\aliens::addalienagent("axis", var_0.origin, var_0.angles, var_1);
  return var_2;
}

clean_up(var_0, var_1) {
  level notify(var_0);
  wait 0.05;

  foreach(var_3 in var_1)
  var_3 delete();
}

play_vignette_vo(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = "high";

  if(!isDefined(var_2))
    var_2 = 30;

  if(!isDefined(var_3))
    var_3 = 0;

  if(!isDefined(var_4))
    var_4 = 0.25;

  foreach(var_6 in level.players) {
    var_6 maps\mp\alien\_music_and_dialog::play_vo_on_player(var_0, var_1, var_2, var_3, var_4);
    break;
  }
}

spawn_model(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", (0, 0, 0));
  var_4 setModel(var_0);
  var_4.origin = var_1 gettagorigin(var_2);
  var_4.angles = var_1 gettagangles(var_2) + var_3;
  var_4 linkto(var_1, var_2);
  return var_4;
}

watch_trigger_by_player() {
  self endon("death");
  level endon("game_ended");
  common_scripts\utility::waitframe();

  for(;;) {
    self waittill("trigger", var_0);

    if(isplayer(var_0)) {
      break;
    }
  }

  self notify("trigger_by_player");
}

delay_vo_until_all_clear(var_0) {
  if(!isDefined(var_0))
    var_0 = 30;

  var_1 = gettime() - var_0 * 1000;
  var_2 = gettime();

  while(var_1 <= var_2) {
    var_1 = gettime() - var_0 * 1000;
    var_3 = 0;
    var_4 = common_scripts\utility::array_combine(level.seeder_active_turrets, level.agentarray);

    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        if(isalive(var_6) || var_6.model == "alien_spore") {
          if(var_6.team == "axis" && isDefined(var_6.alien_type) && var_6.alien_type != "spider" || var_6.model == "alien_spore" && var_6.team == "axis") {
            var_3 = 1;
            break;
          }
        }
      }
    }

    if(var_3 == 0) {
      wait(randomfloatrange(1, 3.5));
      return;
    }

    wait 0.5;
  }
}

cargo_room_get_on_container_vo() {
  level endon("crane_started");
  var_0 = 15;

  while(!common_scripts\utility::flag("everyone_in_cargo_container")) {
    wait(var_0);

    if(!common_scripts\utility::flag("no_ass_nag")) {
      common_scripts\utility::flag_set("is_crane_nags");
      var_0 = var_0 + 10;
      thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
      var_1 = lookupsoundlength("beacon_gdf_getyourasson") / 1000;
      play_sound_on_player("beacon_gdf_getyourasson");
      wait(var_1 + 1);
      thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
      common_scripts\utility::flag_clear("is_crane_nags");
    }
  }
}

nag_bink_toggle() {
  var_0 = getent("cargo_room_control_switch", "targetname");
  level.no_more_binks_archer = undefined;

  while(!common_scripts\utility::flag("everyone_in_cargo_container")) {
    if(common_scripts\utility::flag("is_crane_nags") || isDefined(level.no_more_binks_archer))
      var_0 makeunusable();
    else {
      var_0 makeusable();
      var_0 sethintstring(&"MP_ALIEN_BEACON_BINK_BUTTON");
    }

    wait 0.05;
  }

  var_0 delete();
}

init_cinematics(var_0, var_1) {
  level endon("crane_started");

  if(!is_ps3_online_splitscreen())
    level thread watch_cinematic_use(var_0, "cinematic_preload", "cinematic_start", "cinematic_end");

  level notify("cinematic_preload");
  wait 1;

  if(!isDefined(level.bink_first_play)) {
    level.bink_first_play = 1;
    level waittill("trigger_first_archer_bink");
  } else {
    var_2 = getent("cargo_room_control_switch", "targetname");
    var_2 waittill("trigger");
    var_2 makeunusable();
  }

  if(is_ps3_online_splitscreen())
    level thread no_bink_nag();

  level notify("cinematic_start");

  if(var_0 == "mp_beacon_archer_vig_nag_02")
    level.no_more_binks_archer = 1;

  common_scripts\utility::flag_set("is_crane_nags");
  common_scripts\utility::flag_set("no_ass_nag");
  wait(var_1);
  level notify("cinematic_end");
  wait 1;
}

is_ps3_online_splitscreen() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2 issplitscreenplayer())
      var_0 = 1;
  }

  if(var_0 && level.ps3 && level.onlinegame)
    return 1;
  else
    return 0;
}

no_bink_nag() {
  thread maps\mp\alien\_music_and_dialog::pause_vo_system(level.players);
  var_0 = lookupsoundlength("beacon_gdf_getyourasson") / 1000;
  play_sound_on_player("beacon_gdf_getyourasson");
  wait(var_0 + 1);
  thread maps\mp\alien\_music_and_dialog::unpause_vo_system(level.players);
}

watch_cinematic_use(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  level waittill(var_1);
  preloadcinematicforall(var_0);
  level waittill(var_2);
  playcinematicforall(var_0);
  level waittill(var_3);
  stopcinematicforall();
  common_scripts\utility::flag_clear("no_ass_nag");
  wait 3;

  if(common_scripts\utility::flag("everyone_in_cargo_container")) {
    return;
  }
  common_scripts\utility::flag_clear("is_crane_nags");

  if(!isDefined(level.bink_second_play)) {
    level notify("godfathers_explanation");
    level.bink_second_play = 1;
    thread init_cinematics("mp_beacon_archer_vig_nag_01", 11);
    return;
  }

  if(!isDefined(level.bink_third_play)) {
    level.bink_third_play = 1;
    thread init_cinematics("mp_beacon_archer_vig_nag_02", 7);
  }
}