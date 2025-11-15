/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_infantry_elevator.gsc
***********************************************/

start() {
  common_scripts\utility::getstruct("infantry_elevator_player_start", "targetname").origin = (42758.8, 8655.44, 324);
  maps\oilrocks_apache_code::spawn_apache_allies("apache_elevator_ally_0");
  maps\oilrocks_infantry_code::infantry_teleport_start("infantry_elevator_player_start");
}

hacky_sound_wait(var_0) {
  var_1 = level.player common_scripts\utility::spawn_tag_origin();
  var_1 = spawn("script_origin", (0, 0, 0));
  var_2 = lookupsoundlength(var_0);
  var_1 playSound(var_0);
  wait(var_2 / 1000);
  var_1 delete();
}

main() {
  var_0 = getent("elevator_dialogue", "targetname");
  var_0 waittill("trigger");
  maps\oilrocks_apache_code::send_apaches_to_hangout("hangout_volume_rooftop");
  var_1 = 1;

  while(var_1) {
    var_2 = getaiarray("axis");
    var_1 = 0;

    foreach(var_4 in var_2) {
      if(distance(var_4.origin, var_0.origin) < var_0.radius)
        var_1 = 1;
    }

    wait 0.05;
  }

  maps\_utility::smart_radio_dialogue("oilrocks_hp1_stalkersixyouvegot");
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_wereengagingdangerclose");
  maps\_utility::trigger_wait_targetname("trigger_elevator");
  maps\_utility::delaythread(0.4, maps\_utility::autosave_now);
  elevator_zoom();
  var_6 = getent("elevator_up_the_shaft", "targetname");
  var_7 = maps\_utility::getstructarray_delete("elevator_positions", "targetname");
  var_8 = measure_shaft("shaft_measure");
  thread cleanup_infantry_area();

  foreach(var_10, var_4 in level.infantry_guys)
  var_4 thread forceteleport_maintain(var_7[var_10].origin + (0, 0, var_8), (0, 0, 0));

  var_6.origin = var_6.origin + (0, 0, var_8);
  wait 0.5;
  maps\oilrocks_code::camlanding_from_apache("camelevatorback", 0.7, 0.32);
  level.player maps\_utility::vision_set_fog_changes("oilrocks_infantry", 1);
  var_11 = maps\_vehicle::spawn_vehicles_from_targetname("infantry_elevator_hind_wave2");

  foreach(var_13 in var_11) {
    var_13 thread maps\oilrocks_apache_code::choper_fly_in_think(var_13.attachedpath);
    var_13 thread sensitive_chopper_in_players_view();
  }

  level.player clearclienttriggeraudiozone(0.8);
  thread maps\_utility::autosave_by_name();
  wait 1;
  maps\_utility::smart_radio_dialogue("oilrocks_mrk_thanksoutlaw");
  wait 0.25;
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_anytime");
  wait 0.5;
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_okboyswerepeeling");
  maps\_chopperboss_utility::chopper_boss_clear_hangout_volume();
}

forceteleport_maintain(var_0, var_1) {
  var_2 = gettime() + 10000;
  var_3 = 1;
  var_4 = self.origin;

  while(var_2 > gettime()) {
    if(var_3) {
      var_3 = 0;
      self notify("endTeleportThread");
      self forceteleport(var_0, var_1);
    } else if(distance(self.origin, var_4) > 800)
      var_3 = 1;

    var_4 = self.origin;
    wait 0.05;
  }
}

_precache() {
  common_scripts\utility::flag_init("player_back_on_elevator");
}

measure_shaft(var_0) {
  var_1 = maps\_utility::getstruct_delete(var_0, "targetname");
  var_2 = maps\_utility::getstruct_delete(var_1.target, "targetname");
  return var_2.origin[2] - var_1.origin[2];
}

elevator_zoom() {
  thread cleanup_infantry_area();
  maps\_utility::array_spawn_targetname("top_elevator_enemies", 1);
  var_0 = 1.5;
  maps\_utility::delaythread(var_0, maps\oilrocks_slamzoom::digitalflash, 0.35);
  level.player setclienttriggeraudiozone("oilrocks_heli_gunner", 0.8);
  zoom_into_apache("camelevator", 0.8, 0.3, 0);
  var_1 = maps\_vehicle::spawn_vehicles_from_targetname("elevator_zpu");
  var_2 = gettime();
  maps\_utility::waittill_dead(var_1, 2, 2);
  maps\_utility::wait_for_buffer_time_to_pass(var_2, 2);
  var_3 = maps\_vehicle::spawn_vehicles_from_targetname("infantry_elevator_hind");

  foreach(var_5 in var_3) {
    var_5 thread maps\oilrocks_apache_code::choper_fly_in_think(var_5.attachedpath);
    var_5 thread sensitive_chopper_in_players_view();
  }

  var_1 = maps\_utility::array_removedead(var_1);
  maps\_utility::waittill_dead(var_1, undefined, 2);
  var_3 = maps\_utility::array_removedead(var_3);
  var_7 = [];

  foreach(var_5 in var_3) {
    if(!isDefined(var_5._animactive) || !var_5._animactive)
      var_7[var_7.size] = var_5;
  }

  maps\_utility::waittill_dead(var_7);
  maps\_utility::smart_radio_dialogue("oilrocks_hp1_ordinanceisdestroyed");
}

sensitive_chopper_in_players_view() {
  self endon("death");
  var_0 = 0;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5);

    if(!isDefined(var_2.script_team)) {
      continue;
    }
    if(var_5 != "MOD_PROJECTILE") {
      continue;
    }
    if(maps\_utility::within_fov_of_players(self.origin, 0.7) && sighttracepassed(level.player getEye(), self.origin, 0, self))
      maps\_vehicle::force_kill();
  }
}

zoom_into_apache(var_0, var_1, var_2, var_3) {
  var_3 = common_scripts\utility::ter_op(isDefined(var_3), var_3, 1);
  maps\oilrocks_code::camlanding_from_apache(var_0, var_1, var_2, var_3);
  var_4 = spawnStruct();
  var_4.origin = level.player.origin;
  var_4.angles = level.player.angles;
  var_5 = maps\oilrocks_code::spawn_apache_player_at_struct(var_4);
  var_5 maps\_chopperboss_utility::chopper_boss_locs_monitor_disable_turn_off();
  var_5 vehicle_setspeedimmediate(40, 35, 35);
}

cleanup_infantry_area() {
  var_0 = getweaponarray();
  maps\_utility::array_delete(getweaponarray());
  var_1 = getscriptablearray();
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_4.origin[2] > 680) {
      continue;
    }
    var_4 delete();
    var_2++;
  }

  var_2 = 0;
  var_6 = getscriptablearray();

  foreach(var_4 in var_6) {
    if(distance2d(var_4.origin, level.player.origin) < 10000) {
      continue;
    }
    var_2++;
    var_4 delete();
  }

  var_2 = 0;
  var_9 = getaiarray("axis");

  foreach(var_11 in var_9) {
    if(var_11.origin[2] > 680) {
      continue;
    }
    var_11 delete();
    var_2++;
  }
}