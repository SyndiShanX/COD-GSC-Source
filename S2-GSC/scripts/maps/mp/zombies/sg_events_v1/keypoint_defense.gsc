/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\sg_events_v1\keypoint_defense.gsc
*********************************************************************/

init() {
  maps\mp\mp_zombies_attack_object::init();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_defense_common", ::basic_defense_run, 120, 1, 1);
  level._zombies_shotgun_obj_keypoint_defense_dmg_structs = initialize_damage_states();
  var_0 = common_scripts\utility::_id_46B5("zmb_shotgun_keypoint_defend_point_a", "targetname");
  var_1 = common_scripts\utility::_id_46B5("zmb_shotgun_keypoint_defend_point_b", "targetname");

  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_3 in [var_0, var_1]) {
      var_3.ondamagetakenfunc = ::uberschnell_pile_update_visuals;
      var_3 initialize_defend_point();
    }
  }
}

basic_defense_run(var_0) {
  if(maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::not_the_final_objective())
    level._id_1CC0 = ["zombie_generic"];

  level thread maps\mp\zombies\shotgun\_zombies_shotgun_rideau_global::run_rideau_defense_comment();
  var_1 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_defense_common_zombie_attacker_allow_bombers");
  var_2 = ["zombie_generic"];

  if(var_1)
    var_2 = ["zombie_generic", "zombie_exploder"];

  var_3 = common_scripts\utility::_id_46B5("zmb_shotgun_keypoint_defend_point_a", "targetname");
  var_4 = common_scripts\utility::_id_46B5("zmb_shotgun_keypoint_defend_point_b", "targetname");
  var_5 = [var_3, var_4];
  var_6 = common_scripts\utility::random(var_5);
  level.outro_targetname = var_6.targetname + "_cam";
  var_7 = spawn("script_model", var_6.origin);
  var_7 setModel("tag_origin");
  var_7.ammo_attack_points = common_scripts\utility::_id_46B7(var_6._id_0165, "targetname");

  if(isDefined(var_6.angles))
    var_7.angles = var_6.angles;

  if(isDefined(var_6.ondamagetakenfunc))
    var_7.ondamagetakenfunc = var_6.ondamagetakenfunc;

  var_8 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("defense_common");
  var_8 = var_8 + maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_defense_common_generator_health_buff");
  var_8 = var_8 * maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_defense_common_generator_health_red_skull");
  var_8 = int(var_8);
  var_7.capture_health = var_8;
  var_7.maxhealth = var_8;
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::single_ent_health_display_start(var_7, 0, 1);
  var_7 common_scripts\utility::_id_3799("obj_destroyed");
  var_9 = spawn("script_model", var_7.origin);
  var_9 setModel("zmb_uberschnalle_battery_chunk_01");

  if(isDefined(var_7.angles))
    var_9.angles = var_7.angles;

  level thread maps\mp\_utility::_id_6F74(::showoutlinehelp, [var_9]);
  common_scripts\utility::flag_set("zmb_objectives_defense_start");
  var_10 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_player_level_setting("type_defense_common_zombie_attacker_count");
  var_11 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_defense_common_zombie_attacker_count_max");
  var_12 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_defense_common_zombie_attacker_count_wave");
  var_10 = var_10 + var_12;

  if(var_10 > var_11)
    var_10 = var_11;

  var_7 thread maps\mp\mp_zombies_attack_object::create_inanimate_zombie_enemy(var_10, var_8, "obj_destroyed", 99999, 400, ::basic_defense_on_finished, [], var_7.ammo_attack_points, var_2, ["zombie_is_passive", "zombie_is_crawler", "zombie_is_objective", "zombie_is_stunned"]);
  var_7 thread basic_defense_wait_for_destruction();
  var_13 = basic_defense_waitfor_timeout_or_fail();
  level._id_1CC0 = undefined;
  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_nest_01_tower_battle", int(100 * (var_7.capture_health / var_7.maxhealth)));
  common_scripts\utility::flag_set("zmb_objectives_defense_end");
  level thread maps\mp\_utility::_id_6F74(::canceloutlinehelp);
  var_9 hide();

  if((_id_0547::_id_5565(var_13, "sg_obj_timeout") || _id_0547::_id_5565(var_13, "zombie_wave_ended")) && isDefined(var_7))
    var_7.shouldterminate = 1;

  if(_id_0547::_id_5565(var_13, "sg_obj_timeout") && common_scripts\utility::_id_562E(level.zmb_sg_objectives[var_0].timeout_win) || _id_0547::_id_5565(var_13, "zombie_wave_ended"))
    return 1;
  else
    return 0;
}

initialize_defend_point() {
  set_condition(1);
}

initialize_damage_states() {
  var_0 = [1, 2, 3, 4, 5];
  var_1 = [];

  foreach(var_5, var_3 in var_0) {
    var_4 = spawnStruct();

    switch (var_3) {
      case 1:
        var_4._id_3F02 = ::set_condition_prestine;
        var_4.fx = undefined;
        break;
      case 2:
        var_4._id_3F02 = ::set_condition_damage_low;
        var_4.fx = "zmb_battery_defense_dmg_1";
        break;
      case 3:
        var_4._id_3F02 = ::set_condition_damage_med;
        var_4.fx = "zmb_battery_defense_dmg_2";
        break;
      case 4:
        var_4._id_3F02 = ::set_condition_damage_high;
        var_4.fx = "zmb_battery_defense_dmg_3";
        break;
      case 5:
        var_4._id_3F02 = ::set_condition_damage_exp;
        var_4.fx = "zmb_battery_defense_dmg_fail";
        break;
    }

    var_1[var_5] = var_4;
  }

  return var_1;
}

uberschnell_pile_update_visuals() {
  var_0 = self.maxhealth * 0.2;

  if(!isDefined(self.nexthealthcheckpoint)) {
    self.healthstate = 0;
    self.nexthealthcheckpoint = self.maxhealth - var_0;
  }

  if(self.capture_health < self.nexthealthcheckpoint) {
    self.healthstate++;
    self.nexthealthcheckpoint = self.nexthealthcheckpoint - var_0;

    if(self.nexthealthcheckpoint < var_0)
      self.nexthealthcheckpoint = 1;

    thread set_condition(self.healthstate);
  }
}

set_condition(var_0) {
  var_1 = level._zombies_shotgun_obj_keypoint_defense_dmg_structs;

  if(var_0 > var_1.size) {
    return;
  }
  if(var_0 == var_1.size) {
    wait 1.3;
    var_2 = _id_0547::_id_408F();
    var_2 = common_scripts\utility::_id_40B0(self.origin, var_2);

    foreach(var_5, var_4 in var_2) {
      if(var_5 < 4)
        var_4 _meth_8682(0, 10, 1, "none", 1);
    }
  }

  clear_dmg_fx();
  spawn_defense_fx(var_1[var_0 - 1].fx);
  self[[var_1[var_0 - 1]._id_3F02]]();
}

set_condition_prestine() {}

set_condition_damage_low() {}

set_condition_damage_med() {}

set_condition_damage_high() {}

set_condition_damage_exp() {}

basic_defense_on_finished() {}

basic_defense_waitfor_timeout_or_fail(var_0) {
  [var_2, var_3] = common_scripts\utility::_id_A70E(level, "sg_defense_failed", level, "sg_obj_timeout", level, "zombie_wave_ended");
  return var_2;
}

basic_defense_wait_for_destruction() {
  level endon("sg_obj_timeout");
  level endon("sg_defense_failed");
  var_0 = self;
  var_0 common_scripts\utility::_id_379C("obj_destroyed");
  level notify("sg_defense_failed");
}

spawn_defense_fx(var_0) {
  if(isDefined(var_0)) {
    self.dmgfx = _id_0547::_id_8FBA(self, var_0);
    _triggerfx(self.dmgfx);
  }
}

clear_dmg_fx() {
  if(isDefined(self.dmgfx))
    self.dmgfx delete();
}

basic_defense_skip_cleanup(var_0) {
  level endon("sg_obj_timeout");
  level endon("sg_defense_failed");
  level waittill("skipWave");
  var_0.shouldterminate = 1;
}

showoutlinehelp(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 endon("helper_canceled");
  var_2 = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_utility::get_difficulty_setting("type_defense_common_outline_dist");

  for(;;) {
    foreach(var_4 in var_0) {
      if(distance(var_4.origin, var_1.origin) > var_2) {
        var_4 showtoplayer(var_1);
        var_4 hudoutlineenableforclient(var_1, 2, 0);
        continue;
      }

      var_4 _meth_8006(var_1);
      var_4 hudoutlinedisableforclient(var_1);
    }

    wait 0.5;
  }
}

canceloutlinehelp() {
  var_0 = self;
  var_0 notify("helper_canceled");
}