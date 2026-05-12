/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\sg_events_v1\assassin_squad.gsc
***********************************************************/

func_00D5() {
  level.assassin_validation_func = ::maps\mp\zombies\zombie_assassin_basic::func_A26F;
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_meuchler_common", ::basic_assassin_squad_run, 30, 0, 1);
  while(!isDefined(level.var_A41)) {
    wait 0.05;
  }

  maps\mp\zombies\zombie_assassin_basic::func_D5();
}

basic_assassin_squad_run(param_00) {
  level endon("sg_obj_timeout");
  var_01 = common_scripts\utility::func_46B7("zmb_assassin_spawnpoint_leader", "targetname");
  var_02 = common_scripts\utility::func_7A33(var_01);
  var_02.leader = 1;
  var_03 = common_scripts\utility::func_46B7(var_02.var_1A2, "targetname");
  var_04 = common_scripts\utility::func_F73(var_03, [var_02]);
  maps\mp\mp_zombie_nest_ee_wave_manipulation::func_8608();
  var_05 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("meuchler_common_leader_type");
  var_06 = 0;
  if(int(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("meuchler_common_all_leaders"))) {
    var_07 = common_scripts\utility::func_7A33(var_05);
  } else {
    var_07 = undefined;
  }

  level.trucks_are_port_locked = 1;
  for(var_08 = 0; var_08 < maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("meuchler_common_count"); var_08++) {
    foreach(var_0A in var_04) {
      if(lib_0547::func_5565(var_0A.var_165, "zombie_sky_spawner")) {
        var_0A.var_8C95 = 1;
        var_0A.ignorehidingskyspawner = 1;
      }

      if(common_scripts\utility::func_562E(var_0A.leader)) {
        var_0B = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("meuchler_common_leader_health");
        var_0C = var_05[var_06];
        var_06++;
        if(var_06 == var_05.size) {
          var_06 = 0;
        }
      } else {
        var_0B = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("meuchler_common_health");
        var_0C = undefined;
        if(isDefined(var_07)) {
          var_0C = var_07;
        }
      }

      var_0B = var_0B * maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("meuchler_common_leader_health_buff");
      var_0D = spawn_sh_assassin(var_0C, var_0B, var_0A);
    }

    maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::basic_boss_waitfor_defeated();
    wait(3);
  }

  return 1;
}

spawn_sh_assassin(param_00, param_01, param_02) {
  param_02.ignorehidingskyspawner = 1;
  param_02.var_165 = "zombie_spawner";
  param_02.asssassinspawn = 1;
  var_03 = maps\mp\zombies\zombie_assassin_basic::spawn_an_assassin(param_00, param_01, param_02);
  var_03.assassinmustneverleave = 1;
  var_03.optionaldisablefogsensitivity = 1;
  var_03.optionaldisablecrouchedambush = 1;
  var_03.customrecyclehandling = ::respawnanassassinsquadzombie;
  var_03.no_kill_on_skip = 1;
  var_03.optionaldisableexits = 1;
  var_03.sgboss = 1;
  var_03 lib_0547::func_84CB();
  return var_03;
}

respawnanassassinsquadzombie() {
  var_00 = self.var_BC;
  var_01 = 0;
  if(isDefined(self.assassin_modifier)) {
    var_01 = 1;
  }

  var_02 = common_scripts\utility::func_46B7("zmb_assassin_spawnpoint_leader", "targetname");
  var_03 = common_scripts\utility::func_7A33(var_02);
  var_04 = spawn_sh_assassin(undefined, var_00, var_03);
  self.var_6701 = 1;
  self.var_2A9D = undefined;
  self.var_6734 = 1;
  self.var_AC10 = 1;
  self suicide();
}