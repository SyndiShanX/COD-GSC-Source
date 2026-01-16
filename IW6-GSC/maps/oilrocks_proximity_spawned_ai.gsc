/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_proximity_spawned_ai.gsc
**************************************************/

main() {
  initialize();
  level.proximity_spawn_ai thread monitor_spawners();
}

initialize() {
  var_0 = spawnStruct();
  var_0.distance_to_spawn = squared(9000);
  var_0.locations = [];
  var_0.living_ai = [];
  var_0.ai_out_time = 15;
  var_0.max_ai_out = 9;
  var_1 = maps\_utility::getstructarray_delete("proximity_spawned_ai", "targetname");

  foreach(var_3 in var_1)
  var_0.locations[var_0.locations.size] = var_3;

  level.proximity_spawn_ai = var_0;
  common_scripts\utility::create_lock("proximity_spawned_ai_heavy_hide");
}

monitor_spawners() {
  self notify("monitor_spawners");
  self endon("monitor_spawners");
  wait 0.05;

  for(;;) {
    if(!self.locations.size) {
      wait 0.05;
      continue;
    }

    self.locations = sortbydistance(self.locations, level.player getEye());
    var_0 = [];

    foreach(var_3, var_2 in self.locations) {
      if(isDefined(var_2)) {
        if(isDefined(var_2.exhausted))
          var_0[var_0.size] = var_2;

        if(distancesquared(var_2.origin, level.player.origin) < self.distance_to_spawn && common_scripts\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_2.origin, 0.342))
          thread spawn_ai_for_location(var_2);
        else if(isDefined(var_2.living_ai) && var_2.living_ai.size)
          maps\_utility::array_notify(var_2.living_ai, "player_out_of_range");
      }

      if(var_3 % 7 == 0)
        wait 0.05;
    }

    if(var_0.size)
      self.locations = common_scripts\utility::array_remove_array(self.locations, var_0);
  }
}

location_in_range(var_0) {
  return distancesquared(var_0.origin, level.player.origin) < self.distance_to_spawn;
}

set_spawners_for_location(var_0) {
  var_0.living_ai = [];
  var_0.spawners = maps\_utility::getstructarray_delete(var_0.target, "targetname");

  foreach(var_2 in var_0.spawners) {
    if(isDefined(var_2.target)) {
      var_3 = getnodearray(var_2.target, "targetname");

      foreach(var_5 in var_3) {
        if(!isDefined(var_5.radius) || var_5.radius == 2048)
          var_5.radius = 128;
      }
    }
  }

  var_0.player_killed_ai_count = 0;
  var_0.last_spawned_time = gettime();
}

spawn_ai_for_location(var_0) {
  if(!isDefined(var_0.living_ai))
    set_spawners_for_location(var_0);

  if(var_0.living_ai.size) {
    return;
  }
  if(self.living_ai.size >= self.max_ai_out) {
    request_ai_spawn(var_0.spawners.size);
    return;
  }

  var_1 = spawn_ai_for_location_from_pool(var_0);

  foreach(var_3 in var_1)
  thread ai_track(var_3, var_0);
}

spawn_ai_for_location_from_pool(var_0) {
  var_1 = maps\_spawner::get_pool_spawners_from_structarray(var_0.spawners);
  var_2 = maps\_utility::array_spawn(var_1, 1, 1);
  var_0.ai_to_kill = var_2.size;
  var_0.living_ai = var_2;
  self.living_ai = common_scripts\utility::array_combine(self.living_ai, var_2);
  return var_2;
}

request_ai_spawn(var_0) {
  for(var_1 = var_0; var_1 >= 0; var_1--) {
    var_2 = self.living_ai[var_1];
    var_2 notify("return_to_spawn_hole");
  }
}

ai_track(var_0, var_1) {
  var_0.dropweapon = 0;
  var_0 maps\_utility::disable_long_death();
  var_0 maps\_utility::enable_sprint();
  var_0 endon("entitydeleted");
  var_2 = var_0.origin;
  thread ai_track_death_by_player(var_0, var_1);
  thread ai_on_death(var_0, var_1);
  var_0 endon("death");
  var_3 = var_0 common_scripts\utility::waittill_any_return("goal", "player_out_of_range", "return_to_spawn_hole");

  if(var_3 != "return_to_spawn_hole" && var_3 != "player_out_of_range")
    common_scripts\utility::waittill_notify_or_timeout_return("return_to_spawn_hole", self.ai_out_time);

  if(common_scripts\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, 0.3746)) {
    var_0 maps\_utility::set_goal_pos(var_2);
    var_0 maps\_utility::set_goal_radius(64);

    if(common_scripts\utility::waittill_notify_or_timeout_return("goal", 2) == "timeout")
      var_0 do_heavy_delete_wait();
  } else {}

  var_0 delete();
}

do_heavy_delete_wait() {
  self endon("goal");
  var_0 = 1;

  while(var_0) {
    common_scripts\utility::lock("proximity_spawned_ai_heavy_hide");
    var_0 = common_scripts\utility::within_fov(level.player getEye(), level.player getplayerangles(), self.origin, 0.342);
    common_scripts\utility::unlock_wait("proximity_spawned_ai_heavy_hide");
  }
}

ai_on_death(var_0, var_1) {
  var_0 waittill("death");
  var_1.living_ai = maps\_utility::array_removedead_or_dying(var_1.living_ai);
  self.living_ai = maps\_utility::array_removedead_or_dying(self.living_ai);
}

ai_track_death_by_player(var_0, var_1) {
  var_0 endon("entitydeleted");
  var_0 waittill("death", var_2);
  var_3 = isalive(var_2) && isplayer(var_2);

  if(!var_3 && isDefined(var_2) && var_2.classname == "worldspawn")
    var_3 = 1;

  if(isDefined(var_2.owner) && var_2.owner == level.player)
    var_3 = 1;

  if(var_3) {
    var_1.player_killed_ai_count++;
    try_exausting_location(var_1);
  }
}

try_exausting_location(var_0) {
  if(var_0.player_killed_ai_count >= var_0.ai_to_kill)
    var_0.exhausted = 1;
}

end() {
  if(isDefined(level.proximity_spawn_ai))
    level.proximity_spawn_ai notify("monitor_spawners");
}

test_all() {
  wait 0.05;
  level.player maps\_utility::set_ignoreme(1);
  level.proxytestent = common_scripts\utility::spawn_tag_origin();
  level.player playerlinkto(level.proxytestent, "tag_origin");

  foreach(var_1 in level.proximity_spawn_ai.locations)
  level.proximity_spawn_ai test_location(var_1);

  iprintlnbold("success!!");
  level waittill("forever");
}

test_location(var_0) {
  set_spawners_for_location(var_0);
  level.proxytestent.origin = var_0.origin;
  var_1 = maps\_utility::get_average_origin(var_0.spawners);
  var_2 = var_1 - var_0.origin;
  level.player setplayerangles(vectortoangles(var_2));
  level.proxytestent.origin = var_0.origin - var_2 * 2;
  var_3 = spawn_ai_for_location_from_pool(var_0);
  var_0.ai_test_count = var_3.size;

  foreach(var_5 in var_3)
  thread test_individual_spawner(var_0, var_5);

  var_7 = gettime() + 20000;

  while(var_0.ai_test_count) {
    wait 0.05;

    if(gettime() > var_7)
      iprintlnbold("timeout!");
  }
}

test_individual_spawner(var_0, var_1) {
  test_guy_do_goalor_die(var_1);
  var_0.ai_test_count--;

  if(isDefined(var_1))
    var_1 delete();
}

test_guy_do_goalor_die(var_0) {
  var_0 endon("death");
  var_0 maps\_utility::enable_sprint();
  var_1 = var_0.origin;
  var_0 waittill("goal");
  var_0 maps\_utility::set_goal_pos(var_1);
  var_0 maps\_utility::set_goal_radius(64);
  var_0 waittill("goal");
}

start() {
  level.proxy_start_test = 1;
  initialize();
}

start_test() {
  if(isDefined(level.proxy_start_test))
    test_all();
}