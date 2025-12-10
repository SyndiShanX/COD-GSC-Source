/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3381.gsc
************************/

init_knifethrow_game() {
  level._effect["shot_impact"] = loadfx("vfx\iw7\core\zombie\blood\vfx_zmb_blood_frontend.vfx");
  load_animation();
  var_00 = scripts\engine\utility::getstructarray("interaction_knife_throw", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_F9BE();
    var_02 thread scripts\cp\zombies\arcade_game_utility::turn_off_machine_after_uses(4, 7);
    wait(0.05);
  }
}

load_animation() {
  precachempanim("iw7_cp_zom_wheel_hit_01");
  precachempanim("iw7_cp_zom_wheel_hit_02");
  precachempanim("iw7_cp_zom_wheel_idle_01");
}

func_F9BE(param_00) {
  wait(5);
  var_01 = getEntArray(self.target, "targetname");
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.script_noteworthy)) {
      continue;
    }

    switch (var_03.script_noteworthy) {
      case "knife":
        self.var_A6FB = var_03;
        break;
    }
  }

  var_05 = scripts\engine\utility::getstructarray(self.target, "targetname");
  foreach(var_07 in var_05) {
    if(!isDefined(var_07.script_noteworthy)) {
      continue;
    }

    switch (var_07.script_noteworthy) {
      case "knife_target":
        var_08 = spawn("script_model", var_07.origin);
        var_08 setModel("zmb_rave_knife_throw_target");
        var_08.angles = var_07.angles;
        var_09 = spawn("script_model", var_08 gettagorigin("j_spine4"));
        var_09 setModel("zmb_male_head_01");
        var_09.angles = var_08 gettagangles("j_spine4");
        var_09 linkto(var_08, "j_spine4");
        var_08 scriptmodelplayanim("IW7_cp_zom_wheel_idle_01", 1);
        self.knife_throw_target = var_08;
        break;

      case "knife_wheel":
        var_0A = spawn("script_model", var_07.origin);
        var_0A setModel("cp_rave_misfortune_wheel_01");
        var_0A.angles = var_07.angles;
        self.var_13CFD = var_0A;
        break;
    }
  }

  self.knife_throw_target.damage_location = [];
  set_up_damage_location(self.knife_throw_target, self.var_13CFD, (-585, -1598, 148), "j_helmet", 100);
  set_up_damage_location(self.knife_throw_target, self.var_13CFD, (-572, -1575, 155), "j_wrist_le", 256);
  set_up_damage_location(self.knife_throw_target, self.var_13CFD, (-607, -1611, 155), "j_wrist_ri", 256);
  set_up_damage_location(self.knife_throw_target, self.var_13CFD, (-566, -1584, 98), "j_ankle_ri", 961);
  set_up_damage_location(self.knife_throw_target, self.var_13CFD, (-597, -1617, 98), "j_ankle_le", 961);
  self.knife_throw_target thread knife_target_damage_monitor(self.knife_throw_target);
  self.knife_throw_target linkto(self.var_13CFD);
  self.var_13CFF = self.var_13CFD.angles;
  var_0C = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  thread interaction_usability_manager_per_wave(self);
  for(;;) {
    var_0D = "power_on";
    if(var_0C) {
      var_0D = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_0D == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      wait(0.25);
      continue;
    }

    if(var_0D != "power_off" && !isDefined(param_00)) {
      self.powered_on = 1;
    } else {
      self.powered_on = 0;
    }

    if(!var_0C) {
      break;
    }
  }
}

interaction_usability_manager_per_wave(param_00) {
  for(;;) {
    level scripts\engine\utility::waittill_any_3("regular_wave_starting", "event_wave_starting");
    foreach(var_02 in level.players) {
      scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(param_00, var_02);
    }
  }
}

set_up_damage_location(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawn("script_origin", param_02);
  var_05.tag_location = param_03;
  var_05.damage_location_range = param_04;
  var_05 linkto(param_01);
  param_00.damage_location[param_00.damage_location.size] = var_05;
}

use_knife_throw(param_00, param_01) {
  param_00.var_A6FB hide();
  turn_on_knife_throw_light(param_00);
  scripts\cp\zombies\arcade_game_utility::set_arcade_game_award_type(param_01);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  if(!scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    param_00 notify("machine_used");
  }

  param_01.playing_game = 1;
  param_01.pre_arcade_game_weapon = param_01 scripts\cp\zombies\arcade_game_utility::saveplayerpregameweapon(param_01);
  param_01 playlocalsound("arcade_insert_coin_02");
  param_01 scripts\cp\utility::setlowermessage("knife_hint", &"CP_RAVE_KNIFE_HINT", 6);
  param_01 setclientomnvar("zombie_arcade_game_time", 1);
  scripts\engine\utility::waitframe();
  param_00.destroynavrepulsor = 0;
  param_00.knife_throw_target setCanDamage(1);
  param_00.knife_throw_target.health = 10000000;
  param_00.knife_throw_target.head_hit = 0;
  if(isDefined(level.dc_wheel_of_misfortune_start_func)) {
    param_00 thread[[level.dc_wheel_of_misfortune_start_func]](param_00.knife_throw_target, param_01);
    scripts\engine\utility::waitframe();
  } else if(isDefined(level.gns_wheel_of_misfortune_start_func)) {
    param_00 thread[[level.gns_wheel_of_misfortune_start_func]](param_00.knife_throw_target, param_01);
    scripts\engine\utility::waitframe();
  }

  param_01 scripts\cp\zombies\arcade_game_utility::take_player_grenades_pre_game();
  param_01 giveweapon("iw7_cpknifethrow_mp");
  param_01 switchtoweapon("iw7_cpknifethrow_mp");
  param_01 scripts\engine\utility::allow_weapon_switch(0);
  param_01 scripts\engine\utility::allow_usability(0);
  param_01 scripts\cp\utility::allow_player_interactions(0);
  param_01 thread func_A701(param_00, param_01);
  param_01 thread func_D040(param_00, param_01);
  param_01 thread func_D09E(param_00, param_01);
  level thread play_wheel_sfx(param_00, param_01);
  level thread func_10A00(param_00, param_01);
}

play_wheel_sfx(param_00, param_01) {
  param_01 endon("arcade_game_over_for_player");
  param_00.var_13CFD playSound("rave_wheel_of_misfortune_start");
  wait(lookupsoundlength("rave_wheel_of_misfortune_start") / 1000);
  param_00.var_13CFD playLoopSound("rave_wheel_of_misfortune_lp");
}

stop_wheel_sfx(param_00) {
  param_00.var_13CFD stopsounds();
  param_00.var_13CFD stoploopsound("rave_wheel_of_misfortune_lp");
  param_00.var_13CFD playSound("rave_wheel_of_misfortune_stop");
}

func_10A00(param_00, param_01) {
  param_01 endon("arcade_game_over_for_player");
  for(;;) {
    param_00.var_13CFD rotateroll(360, 12);
    wait(12);
  }
}

knife_target_damage_monitor(param_00) {
  param_00 endon("death");
  for(;;) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    param_00.health = 10000000;
    if(!isDefined(var_0A)) {
      continue;
    }

    if(!isDefined(var_02)) {
      continue;
    }

    if(var_0A != "iw7_cpknifethrow_mp") {
      continue;
    }

    if(isDefined(var_04)) {
      param_00 playSound("rave_wheel_zmb_pain");
      give_knife_throw_rewards(param_00, var_04, var_02);
      playFX(level._effect["shot_impact"], var_04);
      param_00 thread play_pain_anim(param_00);
      var_02 playlocalsound("zombie_dismember_arm");
    }

    wait(0.1);
  }
}

play_pain_anim(param_00) {
  param_00 notify("knife_throw_target_pain_anim");
  param_00 endon("knife_throw_target_pain_anim");
  var_01 = scripts\engine\utility::random(["iw7_cp_zom_wheel_hit_01", "iw7_cp_zom_wheel_hit_02"]);
  param_00 scriptmodelplayanim(var_01, 1);
  wait(0.8);
  param_00 scriptmodelplayanim("IW7_cp_zom_wheel_idle_01", 1);
}

func_A701(param_00, param_01) {
  self endon("last_stand");
  self endon("disconnect");
  self endon("arcade_game_over_for_player");
  self endon("player_too_far");
  var_02 = 6;
  for(;;) {
    param_01 waittill("grenade_pullback", var_03);
    if(var_03 != "iw7_cpknifethrow_mp") {
      continue;
    }

    if(!isDefined(param_01.disabledusability) || param_01.disabledusability == 0) {
      param_01 scripts\engine\utility::allow_usability(0);
    }

    param_01 waittill("grenade_fire", var_04, var_03);
    if(var_03 == "iw7_cpknifethrow_mp") {
      var_02--;
    }

    if(var_02 == 0) {
      break;
    }

    wait(0.1);
  }

  wait(1);
  param_01 thread func_6955(param_00, param_01);
}

func_D040(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("arcade_game_over_for_player");
  var_02 = param_01 scripts\engine\utility::waittill_any_return("disconnect", "last_stand", "player_too_far", "spawned");
  param_01 thread func_6955(param_00, param_01, var_02);
}

func_D09E(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("arcade_game_over_for_player");
  param_01 endon("spawned");
  param_01 endon("disconnect");
  var_02 = 10000;
  for(;;) {
    wait(0.1);
    if(distancesquared(param_01.origin, param_00.origin) > var_02) {
      wait(1);
      if(distancesquared(param_01.origin, param_00.origin) > var_02) {
        param_01 notify("player_too_far");
        return;
      }
    }
  }
}

func_6955(param_00, param_01, param_02) {
  param_00.var_A6FB show();
  param_00.knife_throw_target setCanDamage(0);
  turn_off_knife_throw_light(param_00);
  if(isDefined(param_01) && isalive(param_01)) {
    param_01 takeweapon("iw7_cpknifethrow_mp");
    param_01 scripts\cp\zombies\interaction_shooting_gallery::func_FEBF(param_01);
    param_01 setclientomnvar("zombie_ca_widget", 0);
    param_01.playing_game = undefined;
    param_01 scripts\engine\utility::allow_weapon_switch(1);
    if(!param_01 scripts\engine\utility::isusabilityallowed()) {
      param_01 scripts\engine\utility::allow_usability(1);
    }

    param_01 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(param_01);
    param_01 scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
    playsoundatpos(param_00.origin, "mp_slot_machine_coins");
    var_03 = param_00.destroynavrepulsor;
    if(param_01.arcade_game_award_type == "soul_power") {
      param_01 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(param_01, var_03);
    } else {
      param_01 scripts\cp\zombies\arcade_game_utility::give_player_tickets(param_01, var_03);
    }

    if(!param_01 scripts\cp\utility::areinteractionsenabled()) {
      param_01 scripts\cp\utility::allow_player_interactions(1);
    }
  }

  param_01 notify("arcade_game_over_for_player");
  if(param_00.knife_throw_target.head_hit == 6) {
    scripts\cp\loot::give_max_ammo_to_player(param_01);
  }

  stop_wheel_sfx(param_00);
  wait(3);
  param_00.var_13CFD rotateto(param_00.var_13CFF, 1);
  wait(3);
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
  if(isDefined(param_01)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(param_00, param_01);
  }
}

turn_on_knife_throw_light(param_00) {
  var_01 = getEntArray(param_00.var_EF20, "targetname");
  foreach(var_03 in var_01) {
    var_03 setscriptablepartstate("knife_throw_light", "light_on");
  }
}

turn_off_knife_throw_light(param_00) {
  var_01 = getEntArray(param_00.var_EF20, "targetname");
  foreach(var_03 in var_01) {
    var_03 setscriptablepartstate("knife_throw_light", "light_off");
  }
}

give_knife_throw_rewards(param_00, param_01, param_02) {
  var_03 = get_knife_hit_location(param_00, param_01);
  var_04 = get_knife_hit_reward_point(var_03);
  if(var_03 == "j_helmet") {
    param_00.head_hit++;
  }

  param_02 iprintlnbold("+$" + var_04);
  param_02 scripts\cp\cp_persistence::give_player_currency(var_04);
}

get_knife_hit_location(param_00, param_01) {
  for(var_02 = 0; var_02 < param_00.damage_location.size; var_02++) {
    var_03 = param_00.damage_location[var_02];
    if(distancesquared(param_01, var_03.origin) <= var_03.damage_location_range) {
      return var_03.tag_location;
    }
  }

  return "body";
}

get_knife_hit_reward_point(param_00) {
  switch (param_00) {
    case "j_helmet":
      return 100;

    case "j_wrist_ri":
    case "j_wrist_le":
    case "j_ankle_ri":
    case "j_ankle_le":
      return 50;

    case "body":
      return 5;
  }
}