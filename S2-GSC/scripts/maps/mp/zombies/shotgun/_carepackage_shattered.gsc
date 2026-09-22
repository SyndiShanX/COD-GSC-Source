/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_carepackage_shattered.gsc
**********************************************************************/

init() {
  level thread init_supply_drop_triggers();
  level.zombie_crate_timeout_callback = ::zombie_handle_crate_timeout;
  level thread highlight_next_carepackage();
}

zombie_handle_crate_timeout(var_0) {
  var_1 = common_scripts\utility::_id_46B7("carepackage_dz", "targetname");
  var_2 = common_scripts\utility::_id_4461(var_0.origin, var_1);

  if(common_scripts\utility::_id_562E(var_2.no_crate_timeout)) {
    return;
  } else {
    level thread zombie_crate_timeout(var_0);
  }
}

zombie_crate_timeout(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(90);

  while(var_0._id_28D5 != 0) {
    wait 1;
  }

  level notify("zombies_crate_timed_out");
  var_0 _id_0529::_id_2D30(1, 1);
}

spawn_player_carepackage(var_0) {
  level notify("new_carepackage_reward");
  level endon("new_carepackage_reward");
  var_1 = 4;
  var_2 = 125;
  maps\mp\zombies\zombie_carepackage::zm_care_spawn(common_scripts\utility::random(level.players), level.care_package_lz);

  for(;;) {
    level waittill("zombies_crate_captured", var_3, var_4, var_5);

    if(common_scripts\utility::_id_562E(var_4.is_objective_package)) {
      continue;
    }
    if(_distance2dsquared(var_5, level.care_package_lz.origin) < 250000) {
      break;
    }
  }

  level notify("zombies_sg_carepackage_opened");
  var_6 = level.zmb_shotgun_carepackage_rewards["level_" + var_0];
  var_7 = common_scripts\utility::_id_0FA3(common_scripts\utility::array_randomize(var_6.normals), 0, var_1);

  if(isDefined(var_6.melees)) {
    var_8 = common_scripts\utility::array_randomize(var_6.melees);

    for(var_9 = 0; var_9 < 2; var_9++) {
      var_7[var_9] = var_8[var_9];
    }
  }

  if(isDefined(var_6.upgrades)) {
    var_10 = common_scripts\utility::array_randomize(var_6.upgrades);
    var_7[var_7.size - 1] = common_scripts\utility::random(var_6.upgrades);
  }

  foreach(var_14, var_12 in level.players) {
    for(var_13 = 0; var_13 < 4; var_13++) {
      level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::run_mini_monies(var_12, level.zmb_shotgun_carepackage_rewards["money_" + var_0], level.care_package_lz.origin + (randomint(120) - 120, randomint(120) - 120, 0));
    }
  }

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::run_armor_powerup(level.care_package_lz.origin);
  maps\mp\gametypes\zombies::_id_281C("ammo", level.care_package_lz.origin, "random", 0, 0);
  var_15 = randomint(level.players.size);

  foreach(var_14, var_12 in level.players) {
    if(var_15 == var_14 && isDefined(var_6._id_90C5)) {
      var_7[0] = var_6._id_90C5;
    }

    level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::spawn_player_rewards(level.care_package_lz, var_7, var_2, var_1, var_12);
  }
}

highlight_next_carepackage() {
  for(;;) {
    level waittill("zombies_crate_spawned", var_0);

    if(common_scripts\utility::_id_562E(level.mark_next_package_as_objective_package)) {
      var_0.is_objective_package = 1;
      level.mark_next_package_as_objective_package = 0;
    }

    var_0 hudoutlineenable(2, 0);
  }
}

start_care_package_reward_all(var_0) {
  if(!isDefined(var_0)) {
    if(!isDefined(level.zmb_shotgun_num_completed_objectives)) {
      level.zmb_shotgun_num_completed_objectives = 0;
    }

    level.zmb_shotgun_num_completed_objectives++;

    if(level.zmb_shotgun_num_completed_objectives >= level.zmb_shotgun_carepackage_rewards.size) {
      level.zmb_shotgun_num_completed_objectives = level.zmb_shotgun_carepackage_rewards.size - 1;
    }

    var_0 = level.zmb_shotgun_num_completed_objectives;
  }

  if(level._id_A980 < 10) {
    wait 2;
    level thread maps\mp\_utility::_id_6F74(maps\mp\gametypes\_hud_message::_id_9102, "zm_airdrop_incoming");
    level thread reward_care_package_to_players(var_0);
  }
}

reward_care_package_to_players(var_0, var_1) {
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_rideau_supply_drop_comment();
  level thread spawn_player_carepackage(var_0);
}

init_supply_drop_triggers() {
  level.usa_carepackage_dz_triggers = [];

  for(var_0 = 0; var_0 < 4; var_0++) {
    var_1 = getEntArray("usa_carepackage_dz_trigger_" + (var_0 + 1), "targetname");
    level.usa_carepackage_dz_triggers[var_0] = var_1;

    for(var_2 = 0; var_2 < 4; var_2++) {
      var_1[var_2].setmovespeedscale = var_2;
      _id_0547::_id_8A4F(var_1[var_2], ::hideuninitializedweapontriggersfromowner, ::hidetriggerfromotherplayer);
    }
  }
}

hideuninitializedweapontriggersfromowner(var_0) {
  if(!isDefined(self._id_A9E0)) {
    self disableplayeruse(var_0);
  }
}

hidetriggerfromotherplayer(var_0) {
  self _meth_8006(var_0);
  self disableplayeruse(var_0);
}

hideweaprewardstoplayer(var_0) {}

showweaprewardtoplayer(var_0) {}