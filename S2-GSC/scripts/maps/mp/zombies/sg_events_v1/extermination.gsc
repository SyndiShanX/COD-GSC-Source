/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\sg_events_v1\extermination.gsc
******************************************************************/

init() {
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_extermination_common", ::basic_extermination_run, 120, 0, 0);
}

basic_extermination_run(var_0) {
  var_1 = level.zmb_sg_objectives[var_0];
  var_2 = ["zombie_exploder"];
  var_3 = undefined;
  level.zmb_temp_zombie_health_buff = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_extermination_health_multiplier");
  level.zmb_disable_all_hitreacts = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_extermination_hitreacts_enabled");

  if(level.zmb_temp_zombie_health_buff == 1)
    level.zmb_temp_zombie_health_buff = undefined;

  if(isDefined(var_1._id_2A35)) {
    if(isDefined(var_1._id_2A35.ext_type)) {
      if(_func_0C0(var_1._id_2A35.ext_type)) {
        if(_func_0C0(var_1._id_2A35.ext_type[0]))
          var_2 = common_scripts\utility::random(var_1._id_2A35.ext_type);
        else
          var_2 = var_1._id_2A35.ext_type;
      } else
        var_2 = [var_1._id_2A35.ext_type];
    }

    foreach(var_5 in var_2) {
      switch (var_5) {
        case "zombie_exploder":
          var_3 = level._id_0A41["zombie_exploder"]["move_mode"];
          level._id_0A41["zombie_exploder"]["move_mode"] = ::objective_extermination_bomber_movemode;
          break;
        case "zombie_generic":
          level thread objective_extermination_sizzler_handler();
          break;
      }
    }

    if(common_scripts\utility::_id_0F79(var_2, "zombie_sizzler") || common_scripts\utility::_id_0F79(var_2, "zombie_generic"))
      level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_extermination_dialog();

    var_7 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting(var_0 + "_delay");

    if(!isDefined(var_7) && isDefined(var_1._id_2A35.ext_spawn_delay))
      var_7 = var_1._id_2A35.ext_spawn_delay;

    if(isDefined(var_7))
      level.sg_manual_spawn_delay = var_7;

    var_8 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting(var_0 + "_count");
    var_9 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_player_level_extension");
    var_8 = int(var_8 * var_9);
    _id_0547::_id_7BA9(::exterminationkillcounter);
    level thread notify_on_extermination_kill_requirement(var_8);

    if(!isDefined(var_8) && isDefined(var_1._id_2A35.ext_wave_count))
      var_8 = var_1._id_2A35.ext_wave_count;
  }

  level notify("extermination_round_start", var_2[0]);
  level._id_1CC0 = var_2;
  [var_11, var_12] = common_scripts\utility::_id_A70E(level, "sg_obj_timeout", level, "round complete", level, "extermination complete");
  _id_0547::_id_2D8C(::exterminationkillcounter);
  level.zmb_temp_zombie_health_buff = undefined;
  level.zmb_disable_all_hitreacts = undefined;
  level._id_1CC0 = undefined;

  foreach(var_5 in var_2) {
    switch (var_5) {
      case "zombie_exploder":
        level._id_0A41["zombie_exploder"]["move_mode"] = var_3;
        break;
    }
  }

  if(var_11 == "sg_obj_timeout")
    return 0;
  else
    return 1;
}

notify_on_extermination_kill_requirement(var_0) {
  level endon("sg_obj_timeout");
  level endon("round complete");
  level.plr_extermination_kills = 0;
  level.currentexterminationgoal = var_0;

  foreach(var_2 in level.players) {
    var_2 _meth_82FF("ui_onevone_class_3", level.currentexterminationgoal);
    var_2 _meth_82FF("ui_onevone_class_4", level.plr_extermination_kills);
  }

  while(level.plr_extermination_kills < var_0)
    waitframe();

  level notify("extermination complete");
}

exterminationkillcounter(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(common_scripts\utility::_id_562E(self._id_AC10)) {
    return;
  }
  var_9 = 0;

  if(_id_0547::_id_5565(self._id_0A4B, "zombie_exploder"))
    var_9 = 1;

  if(_id_0547::_id_5565(self._id_0A4B, "zombie_sizzler") && (_id_0547::_id_5565(var_4, "trap_zm_mp") || isDefined(var_1) && isPlayer(var_1)))
    var_9 = 1;

  if(_id_0547::_id_5565(self._id_0A4B, "zombie_generic") && common_scripts\utility::_id_562E(self.transformingtosizzler) && (_id_0547::_id_5565(var_4, "trap_zm_mp") || isDefined(var_1) && isPlayer(var_1)))
    var_9 = 1;

  if(var_9) {
    level.plr_extermination_kills++;

    if(isDefined(level.currentexterminationgoal)) {
      foreach(var_11 in level.players) {
        var_11 _meth_82FF("ui_onevone_class_3", level.currentexterminationgoal);
        var_11 _meth_82FF("ui_onevone_class_4", level.plr_extermination_kills);
      }
    }
  }
}

objective_extermination_bomber_movemode() {
  if(!isDefined(self.bomberforceruntimestart)) {
    self.bomberforceruntimestart = gettime();
    self.bomberforcerundelay = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_bomber_force_run_start");
  }

  if((gettime() - self.bomberforceruntimestart) / 1000 >= self.bomberforcerundelay)
    return _id_054D::_id_957E(100);
  else
    return "walk";
}

basic_extermination_skip_cleanup() {
  level endon("sg_obj_timeout");
  level endon("round complete");
  level waittill("skipWave");
  level._id_1CC0 = undefined;
}

objective_extermination_sizzler_handler() {
  level endon("round complete");
  level.max_sizzlers = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("extermination_common_sizzler_maximum");
  level.max_sizzlers = level.max_sizzlers + maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_sizzler_add");
  var_0 = 0.05;
  var_1 = 0.15;
  wait(_func_0A5(var_0, var_1));

  for(;;) {
    level.current_sizz = _id_0547::_id_4090("zombie_sizzler").size;

    if(level.current_sizz < level.max_sizzlers) {
      var_2 = _id_0547::_id_4090("zombie_generic");

      foreach(var_4 in var_2) {
        if(!_func_1EF(var_4) || !isalive(var_4) || var_4 _meth_85A5() != "zombie_animclass" || common_scripts\utility::_id_562E(var_4.transformingtosizzler))
          var_5 = common_scripts\utility::_id_0F93(var_2, var_4);
      }

      var_7 = undefined;

      if(var_2.size > 0)
        var_7 = objective_extermination_sizzler_choose_best_generic(var_2);
      else {
        level waittill("spawned_agent", var_4);
        var_7 = var_4;
        wait 1;

        if(!isDefined(var_7)) {
          waitframe();
          continue;
        }
      }

      if(isDefined(var_7)) {
        if(!var_7 try_to_become_a_sizzler()) {
          waitframe();
          continue;
        } else {}

        wait(_func_0A5(var_0, var_1));
      } else
        wait 0.15;
    } else
      wait 0.15;

    waitframe();
  }
}

try_to_become_a_sizzler(var_0) {
  var_1 = self;

  if(!_id_0547::_id_5565(var_1._id_0A4B, "zombie_generic") || !_func_1EF(var_1) || !isalive(var_1) || var_1 _meth_85A5() != "zombie_animclass" || common_scripts\utility::_id_562E(var_1.transformingtosizzler))
    return 0;

  var_1 objective_extermination_sizzler_think(var_0);
  return 1;
}

objective_extermination_sizzler_choose_best_generic(var_0) {
  if(var_0.size == 1)
    return var_0[0];
  else
    return common_scripts\utility::random(var_0);
}

objective_extermination_sizzler_think(var_0) {
  self endon("death");

  if(!common_scripts\utility::_id_562E(var_0))
    thread _id_5D67(self.origin);

  thread maps\mp\zombies\zombie_sizzler::zombie_make_sizzler();
}

_id_5D67(var_0) {
  var_1 = 5000;
  var_2 = spawn("script_model", var_0 + (0, 0, var_1));
  var_2 setModel("tag_origin");
  var_2.angles = var_2.angles + (90, 0, 0);
  var_3 = spawn("script_model", var_0);
  var_3 setModel("tag_origin");
  var_3.angles = var_3.angles + (-90, 0, 0);
  var_4 = _func_382("zmb_wm_lightning_beam", var_2, "tag_origin", var_3, "tag_origin");
  _func_147(level._effect["zmb_wm_lightning_impact_base_rnr"], var_3, "tag_origin");
  _id_0378::_id_8D74("lightning_strike", var_2.origin, var_0);
  wait(_func_0A5(0.25, 0.35));
  var_4 delete();
  var_2 delete();
  var_3 delete();
}