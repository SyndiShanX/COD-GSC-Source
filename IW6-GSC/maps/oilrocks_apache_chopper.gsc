/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_chopper.gsc
********************************************/

start() {
  level.player setclienttriggeraudiozone("oilrocks_heli_gunner", 0.1);
  maps\oilrocks_code::spawn_apache_player("apache_chopper");
  maps\oilrocks_apache_code::spawn_apache_allies("struct_apache_ally_chopper_0");
  maps\oilrocks_apache_code::spawn_blackhawk_ally("blackhawk_ally_finale");

  foreach(var_1 in ["apache_chase_zpu", "apache_chase_additional_zpu", "apache_main_island_zpu"])
  maps\_utility::array_delete(getEntArray(var_1, "targetname"));
}

main() {
  thread maps\oilrocks_apache_vo::apache_mission_vo_think(maps\oilrocks_apache_vo::apache_mission_vo_chopper);
  thread maps\oilrocks_apache_hints::apache_hints_chopper();
  blackhawk_hides_away();
  maps\_utility::autosave_by_name();
  var_0 = maps\oilrocks_apache_code::get_apache_player();
  var_0 thread maps\_chopperboss_utility::chopper_boss_locs_monitor_disable(2048);
  thread maps\_utility::lerp_saveddvar("vehHelicopterPitchOffset", var_0.heli.pitch_offset_air, 15.0);
  var_0 thread vehicle_scripts\_apache_player::altitude_min_override(2000, 15.0);
  thread apache_chopper_enemies();
  maps\_utility::delaythread(2, maps\oilrocks_apache_hints::hint_missile_lock);
  objectives();
}

blackhawk_hides_away() {
  var_0 = maps\oilrocks_apache_code::get_blackhawk_ally();
  var_1 = common_scripts\utility::getstruct("blackhawk_ally_finale", "targetname");
  var_0 thread maps\_vehicle::vehicle_paths(var_1);
}

objectives() {
  var_0 = maps\_utility::obj("apache_escort");
  objective_add(var_0, "active", &"OILROCKS_OBJ_APACHE_CHOPPER");
  objective_current(var_0);
  common_scripts\utility::flag_wait("FLAG_apache_chopper_finished");
  maps\_utility::objective_complete(var_0);
}

apache_chopper_enemies() {
  var_0 = common_scripts\utility::getstructarray("apache_chopper_enemy_hind_path_start", "targetname");
  level.apache_chopper_hinds = [];

  foreach(var_2 in var_0)
  apache_chopper_hind_spawn(var_2);

  while(level.apache_chopper_hinds.size > 1)
    level common_scripts\utility::waittill_any_timeout(1.0, "apache_chopper_hind_died");

  common_scripts\utility::flag_set("FLAG_apache_chopper_hind_destroyed_two");
  var_0 = common_scripts\utility::getstructarray("apache_chopper_enemy_hind_path_start_part_2", "targetname");

  foreach(var_2 in var_0)
  apache_chopper_hind_spawn(var_2);

  while(level.apache_chopper_hinds.size > 0) {
    level common_scripts\utility::waittill_any_timeout(1.0, "apache_chopper_hind_died");

    if(level.apache_chopper_hinds.size <= 3 && !common_scripts\utility::flag("FLAG_apache_chopper_hind_remaining_three"))
      common_scripts\utility::flag_set("FLAG_apache_chopper_hind_remaining_three");

    if(level.apache_chopper_hinds.size <= 1 && !common_scripts\utility::flag("FLAG_apache_chopper_hind_remaining_one"))
      common_scripts\utility::flag_set("FLAG_apache_chopper_hind_remaining_one");
  }

  level.apache_chopper_hinds = undefined;
  common_scripts\utility::flag_wait("FLAG_apache_chopper_vo_done");
  common_scripts\utility::flag_set("FLAG_apache_chopper_finished");
}

apache_chopper_hind_spawn(var_0) {
  var_1 = maps\oilrocks_apache_code::spawn_hind_enemy(var_0);
  var_1 thread hind_warp_ship();
  var_1 thread maps\oilrocks_apache_code::choper_fly_in_think(var_0);
  var_1 thread apache_chopper_hind_on_death();
  return var_1;
}

hind_warp_ship() {
  var_0 = vectornormalize(common_scripts\utility::flat_origin(self.origin) - common_scripts\utility::flat_origin(level.player getEye()));
  var_0 = var_0 * 50000;
  self hide();
  self.mgturret[0] hide();
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1 setModel(self.model);
  var_1 show();
  var_1.origin = self.origin + var_0;
  var_2 = 2.5;
  wait 0.1;
  var_1 lerpy_moveto(self, "tag_origin", var_2);
  self show();
  self.mgturret[0] show();
  var_1 delete();
}

lerpy_moveto(var_0, var_1, var_2) {
  for(var_3 = var_2; var_3 > 0; var_3 = var_3 - 0.05) {
    self moveto(var_0 gettagorigin(var_1), var_3, 0, 0);
    self rotateto(var_0 gettagangles(var_1), var_3, 0, 0);
    wait 0.05;
  }
}

apache_chopper_hind_on_death() {
  level.apache_chopper_hinds[level.apache_chopper_hinds.size] = self;
  self waittill("death");
  level.apache_chopper_hinds = common_scripts\utility::array_removeundefined(level.apache_chopper_hinds);
  level.apache_chopper_hinds = common_scripts\utility::array_remove(level.apache_chopper_hinds, self);
  level notify("apache_chopper_hind_died");
}