/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_proximity_spawned_vehicles.gsc
********************************************************/

main() {
  var_0 = spawnStruct();
  var_0.distance_to_spawn = squared(12000);
  var_0.spawners = [];
  var_1 = getEntArray("proximity_spawned", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(isspawner(var_3)) {
      var_0.spawners[var_0.spawners.size] = var_3;
    }
  }

  level.proximity_spawn = var_0;
  var_0 thread monitor_spawners();
}

monitor_spawners() {
  self notify("monitor_spawners");
  self endon("monitor_spawners");
  wait 0.05;

  for(;;) {
    if(!self.spawners.size) {
      wait 0.05;
      continue;
    }

    foreach(var_3, var_1 in self.spawners) {
      if(isDefined(var_1)) {
        var_2 = self.distance_to_spawn;

        if(isDefined(var_1.radius)) {
          var_2 = squared(var_1.radius);
        }

        if(distancesquared(var_1.origin, level.player.origin) < var_2) {
          thread spawn_and_restart_monitoring(var_1);
          return;
        }
      }

      if(var_3 % 4 == 0) {
        wait 0.05;
      }
    }
  }
}

spawn_and_restart_monitoring(var_0) {
  if(!isDefined(var_0.spawned_count) && !isDefined(var_0.vehicle_spawned_thisframe)) {
    var_1 = var_0 maps\_utility::spawn_vehicle();

    if(!issubstr(var_1.classname, "zpu")) {
      var_1 thread maps\_vehicle::gopath();
    }
  }

  self.spawners = common_scripts\utility::array_remove(self.spawners, var_0);
  var_0 common_scripts\utility::delaycall(0.05, ::delete);
  thread monitor_spawners();
}

end() {
  if(isDefined(level.proximity_spawn)) {
    level.proximity_spawn notify("monitor_spawners");
  }
}