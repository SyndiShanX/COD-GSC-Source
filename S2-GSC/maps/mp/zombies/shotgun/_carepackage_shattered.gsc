/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_carepackage_shattered.gsc
**************************************************************/

func_00D5() {
  level thread init_supply_drop_triggers();
  level.zombie_crate_timeout_callback = ::zombie_handle_crate_timeout;
  level thread highlight_next_carepackage();
}

zombie_handle_crate_timeout(param_00) {
  var_01 = common_scripts\utility::func_46B7("carepackage_dz", "targetname");
  var_02 = common_scripts\utility::func_4461(param_00.var_116, var_01);
  if(common_scripts\utility::func_562E(var_02.no_crate_timeout)) {
    return;
  }

  level thread zombie_crate_timeout(param_00);
}

zombie_crate_timeout(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  maps\mp\gametypes\_hostmigration::func_A6F5(90);
  while(param_00.var_28D5 != 0) {
    wait(1);
  }

  level notify("zombies_crate_timed_out");
  param_00 lib_0529::func_2D30(1, 1);
}

spawn_player_carepackage(param_00) {
  level notify("new_carepackage_reward");
  level endon("new_carepackage_reward");
  var_01 = 4;
  var_02 = 125;
  maps\mp\zombies\zombie_carepackage::zm_care_spawn(common_scripts\utility::func_7A33(level.var_744A), level.care_package_lz);
  for(;;) {
    level waittill("zombies_crate_captured", var_03, var_04, var_05);
    if(common_scripts\utility::func_562E(var_04.is_objective_package)) {
      continue;
    }

    if(distance2dsquared(var_05, level.care_package_lz.var_116) < 250000) {
      break;
    }
  }

  level notify("zombies_sg_carepackage_opened");
  var_06 = level.zmb_shotgun_carepackage_rewards["level_" + param_00];
  var_07 = common_scripts\utility::func_FA3(common_scripts\utility::func_F92(var_06.normals), 0, var_01);
  if(isDefined(var_06.melees)) {
    var_08 = common_scripts\utility::func_F92(var_06.melees);
    for(var_09 = 0; var_09 < 2; var_09++) {
      var_07[var_09] = var_08[var_09];
    }
  }

  if(isDefined(var_06.upgrades)) {
    var_0A = common_scripts\utility::func_F92(var_06.upgrades);
    var_07[var_07.size - 1] = common_scripts\utility::func_7A33(var_06.upgrades);
  }

  foreach(var_0C in level.var_744A) {
    for(var_0D = 0; var_0D < 4; var_0D++) {
      level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::run_mini_monies(var_0C, level.zmb_shotgun_carepackage_rewards["money_" + param_00], level.care_package_lz.var_116 + (randomint(120) - 120, randomint(120) - 120, 0));
    }
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::run_armor_powerup(level.care_package_lz.var_116);
  maps\mp\gametypes\zombies::func_281C("ammo", level.care_package_lz.var_116, "random", 0, 0);
  var_0F = randomint(level.var_744A.size);
  foreach(var_0E, var_0C in level.var_744A) {
    if(var_0F == var_0E && isDefined(var_06.var_90C5)) {
      var_07[0] = var_06.var_90C5;
    }

    level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::spawn_player_rewards(level.care_package_lz, var_07, var_02, var_01, var_0C);
  }
}

highlight_next_carepackage() {
  for(;;) {
    level waittill("zombies_crate_spawned", var_00);
    if(common_scripts\utility::func_562E(level.mark_next_package_as_objective_package)) {
      var_00.is_objective_package = 1;
      level.mark_next_package_as_objective_package = 0;
    }

    var_00 hudoutlineenable(2, 0);
  }
}

start_care_package_reward_all(param_00) {
  if(!isDefined(param_00)) {
    if(!isDefined(level.zmb_shotgun_num_completed_objectives)) {
      level.zmb_shotgun_num_completed_objectives = 0;
    }

    level.zmb_shotgun_num_completed_objectives++;
    if(level.zmb_shotgun_num_completed_objectives >= level.zmb_shotgun_carepackage_rewards.size) {
      level.zmb_shotgun_num_completed_objectives = level.zmb_shotgun_carepackage_rewards.size - 1;
    }

    param_00 = level.zmb_shotgun_num_completed_objectives;
  }

  if(level.var_A980 < 10) {
    wait(2);
    level thread maps\mp\_utility::func_6F74(::maps\mp\gametypes\_hud_message::func_9102, "zm_airdrop_incoming");
    level thread reward_care_package_to_players(param_00);
  }
}

reward_care_package_to_players(param_00, param_01) {
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_rideau_supply_drop_comment();
  level thread spawn_player_carepackage(param_00);
}

init_supply_drop_triggers() {
  level.usa_carepackage_dz_triggers = [];
  for(var_00 = 0; var_00 < 4; var_00++) {
    var_01 = getEntArray("usa_carepackage_dz_trigger_" + var_00 + 1, "targetname");
    level.usa_carepackage_dz_triggers[var_00] = var_01;
    for(var_02 = 0; var_02 < 4; var_02++) {
      var_01[var_02].var_81E1 = var_02;
      lib_0547::func_8A4F(var_01[var_02], ::hideuninitializedweapontriggersfromowner, ::hidetriggerfromotherplayer);
    }
  }
}

hideuninitializedweapontriggersfromowner(param_00) {
  if(!isDefined(self.var_A9E0)) {
    self disableplayeruse(param_00);
  }
}

hidetriggerfromotherplayer(param_00) {
  self hidefromclient(param_00);
  self disableplayeruse(param_00);
}

hideweaprewardstoplayer(param_00) {}

showweaprewardtoplayer(param_00) {}