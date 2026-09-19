/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\sg_events_v1\assassin_squad.gsc
*******************************************************************/

init() {
  level.assassin_validation_func = maps\mp\zombies\zombie_assassin_basic::_id_A26F;
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_meuchler_common", ::basic_assassin_squad_run, 30, 0, 1);

  while(!isDefined(level._id_0A41))
    waitframe();

  maps\mp\zombies\zombie_assassin_basic::init();
}

basic_assassin_squad_run(var_0) {
  level endon("sg_obj_timeout");
  var_1 = common_scripts\utility::_id_46B7("zmb_assassin_spawnpoint_leader", "targetname");
  var_2 = common_scripts\utility::random(var_1);
  var_2.leader = 1;
  var_3 = common_scripts\utility::_id_46B7(var_2.target, "targetname");
  var_4 = common_scripts\utility::_id_0F73(var_3, [var_2]);
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  var_5 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("meuchler_common_leader_type");
  var_6 = 0;

  if(int(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("meuchler_common_all_leaders")))
    var_7 = common_scripts\utility::random(var_5);
  else
    var_7 = undefined;

  level.trucks_are_port_locked = 1;

  for(var_8 = 0; var_8 < maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("meuchler_common_count"); var_8++) {
    foreach(var_10 in var_4) {
      if(_id_0547::_id_5565(var_10._id_0165, "zombie_sky_spawner")) {
        var_10._id_8C95 = 1;
        var_10.ignorehidingskyspawner = 1;
      }

      if(common_scripts\utility::_id_562E(var_10.leader)) {
        var_11 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("meuchler_common_leader_health");
        var_12 = var_5[var_6];
        var_6++;

        if(var_6 == var_5.size)
          var_6 = 0;
      } else {
        var_11 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("meuchler_common_health");
        var_12 = undefined;

        if(isDefined(var_7))
          var_12 = var_7;
      }

      var_11 = var_11 * maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("meuchler_common_leader_health_buff");
      var_13 = spawn_sh_assassin(var_12, var_11, var_10);
    }

    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::basic_boss_waitfor_defeated();
    wait 3;
  }

  return 1;
}

spawn_sh_assassin(var_0, var_1, var_2) {
  var_2.ignorehidingskyspawner = 1;
  var_2._id_0165 = "zombie_spawner";
  var_2.asssassinspawn = 1;
  var_3 = maps\mp\zombies\zombie_assassin_basic::spawn_an_assassin(var_0, var_1, var_2);
  var_3.assassinmustneverleave = 1;
  var_3.optionaldisablefogsensitivity = 1;
  var_3.optionaldisablecrouchedambush = 1;
  var_3.customrecyclehandling = ::respawnanassassinsquadzombie;
  var_3.no_kill_on_skip = 1;
  var_3.optionaldisableexits = 1;
  var_3.sgboss = 1;
  var_3 _id_0547::_id_84CB();
  return var_3;
}

respawnanassassinsquadzombie() {
  var_0 = self.health;
  var_1 = 0;

  if(isDefined(self.assassin_modifier))
    var_1 = 1;

  var_2 = common_scripts\utility::_id_46B7("zmb_assassin_spawnpoint_leader", "targetname");
  var_3 = common_scripts\utility::random(var_2);
  var_4 = spawn_sh_assassin(undefined, var_0, var_3);
  self._id_6701 = 1;
  self._id_2A9D = undefined;
  self._id_6734 = 1;
  self._id_AC10 = 1;
  self suicide();
}