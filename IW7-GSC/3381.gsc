/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3381.gsc
*********************************************/

init_knifethrow_game() {
  level._effect["shot_impact"] = loadfx("vfx\iw7\core\zombie\blood\vfx_zmb_blood_frontend.vfx");
  load_animation();
  var_0 = scripts\engine\utility::getstructarray("interaction_knife_throw", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_F9BE();
    var_2 thread scripts\cp\zombies\arcade_game_utility::turn_off_machine_after_uses(4, 7);
    wait(0.05);
  }
}

load_animation() {
  precachempanim("iw7_cp_zom_wheel_hit_01");
  precachempanim("iw7_cp_zom_wheel_hit_02");
  precachempanim("iw7_cp_zom_wheel_idle_01");
}

func_F9BE(var_0) {
  wait(5);
  var_1 = getEntArray(self.target, "targetname");
  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_noteworthy)) {
      continue;
    }

    switch (var_3.script_noteworthy) {
      case "knife":
        self.var_A6FB = var_3;
        break;
    }
  }

  var_5 = scripts\engine\utility::getstructarray(self.target, "targetname");
  foreach(var_7 in var_5) {
    if(!isDefined(var_7.script_noteworthy)) {
      continue;
    }

    switch (var_7.script_noteworthy) {
      case "knife_target":
        var_8 = spawn("script_model", var_7.origin);
        var_8 setModel("zmb_rave_knife_throw_target");
        var_8.angles = var_7.angles;
        var_9 = spawn("script_model", var_8 gettagorigin("j_spine4"));
        var_9 setModel("zmb_male_head_01");
        var_9.angles = var_8 gettagangles("j_spine4");
        var_9 linkto(var_8, "j_spine4");
        var_8 scriptmodelplayanim("IW7_cp_zom_wheel_idle_01", 1);
        self.knife_throw_target = var_8;
        break;

      case "knife_wheel":
        var_10 = spawn("script_model", var_7.origin);
        var_10 setModel("cp_rave_misfortune_wheel_01");
        var_10.angles = var_7.angles;
        self.var_13CFD = var_10;
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
  var_12 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  thread interaction_usability_manager_per_wave(self);
  for(;;) {
    var_13 = "power_on";
    if(var_12) {
      var_13 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_13 == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      wait(0.25);
      continue;
    }

    if(var_13 != "power_off" && !isDefined(var_0)) {
      self.powered_on = 1;
    } else {
      self.powered_on = 0;
    }

    if(!var_12) {
      break;
    }
  }
}

interaction_usability_manager_per_wave(var_0) {
  for(;;) {
    level scripts\engine\utility::waittill_any("regular_wave_starting", "event_wave_starting");
    foreach(var_2 in level.players) {
      scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_2);
    }
  }
}

set_up_damage_location(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_origin", var_2);
  var_5.tag_location = var_3;
  var_5.damage_location_range = var_4;
  var_5 linkto(var_1);
  var_0.damage_location[var_0.damage_location.size] = var_5;
}

use_knife_throw(var_0, var_1) {
  var_0.var_A6FB hide();
  turn_on_knife_throw_light(var_0);
  scripts\cp\zombies\arcade_game_utility::set_arcade_game_award_type(var_1);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    var_0 notify("machine_used");
  }

  var_1.playing_game = 1;
  var_1.pre_arcade_game_weapon = var_1 scripts\cp\zombies\arcade_game_utility::saveplayerpregameweapon(var_1);
  var_1 playlocalsound("arcade_insert_coin_02");
  var_1 scripts\cp\utility::setlowermessage("knife_hint", &"CP_RAVE_KNIFE_HINT", 6);
  var_1 setclientomnvar("zombie_arcade_game_time", 1);
  scripts\engine\utility::waitframe();
  var_0.score = 0;
  var_0.knife_throw_target setCanDamage(1);
  var_0.knife_throw_target.health = 10000000;
  var_0.knife_throw_target.head_hit = 0;
  if(isDefined(level.dc_wheel_of_misfortune_start_func)) {
    var_0 thread[[level.dc_wheel_of_misfortune_start_func]](var_0.knife_throw_target, var_1);
    scripts\engine\utility::waitframe();
  } else if(isDefined(level.gns_wheel_of_misfortune_start_func)) {
    var_0 thread[[level.gns_wheel_of_misfortune_start_func]](var_0.knife_throw_target, var_1);
    scripts\engine\utility::waitframe();
  }

  var_1 scripts\cp\zombies\arcade_game_utility::take_player_grenades_pre_game();
  var_1 giveweapon("iw7_cpknifethrow_mp");
  var_1 switchtoweapon("iw7_cpknifethrow_mp");
  var_1 scripts\engine\utility::allow_weapon_switch(0);
  var_1 scripts\engine\utility::allow_usability(0);
  var_1 scripts\cp\utility::allow_player_interactions(0);
  var_1 thread func_A701(var_0, var_1);
  var_1 thread func_D040(var_0, var_1);
  var_1 thread func_D09E(var_0, var_1);
  level thread play_wheel_sfx(var_0, var_1);
  level thread func_10A00(var_0, var_1);
}

play_wheel_sfx(var_0, var_1) {
  var_1 endon("arcade_game_over_for_player");
  var_0.var_13CFD playSound("rave_wheel_of_misfortune_start");
  wait(lookupsoundlength("rave_wheel_of_misfortune_start") / 1000);
  var_0.var_13CFD playLoopSound("rave_wheel_of_misfortune_lp");
}

stop_wheel_sfx(var_0) {
  var_0.var_13CFD stopsounds();
  var_0.var_13CFD stoploopsound("rave_wheel_of_misfortune_lp");
  var_0.var_13CFD playSound("rave_wheel_of_misfortune_stop");
}

func_10A00(var_0, var_1) {
  var_1 endon("arcade_game_over_for_player");
  for(;;) {
    var_0.var_13CFD rotateroll(360, 12);
    wait(12);
  }
}

knife_target_damage_monitor(var_0) {
  var_0 endon("death");
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0.health = 10000000;
    if(!isDefined(var_10)) {
      continue;
    }

    if(!isDefined(var_2)) {
      continue;
    }

    if(var_10 != "iw7_cpknifethrow_mp") {
      continue;
    }

    if(isDefined(var_4)) {
      var_0 playSound("rave_wheel_zmb_pain");
      give_knife_throw_rewards(var_0, var_4, var_2);
      playFX(level._effect["shot_impact"], var_4);
      var_0 thread play_pain_anim(var_0);
      var_2 playlocalsound("zombie_dismember_arm");
    }

    wait(0.1);
  }
}

play_pain_anim(var_0) {
  var_0 notify("knife_throw_target_pain_anim");
  var_0 endon("knife_throw_target_pain_anim");
  var_1 = scripts\engine\utility::random(["iw7_cp_zom_wheel_hit_01", "iw7_cp_zom_wheel_hit_02"]);
  var_0 scriptmodelplayanim(var_1, 1);
  wait(0.8);
  var_0 scriptmodelplayanim("IW7_cp_zom_wheel_idle_01", 1);
}

func_A701(var_0, var_1) {
  self endon("last_stand");
  self endon("disconnect");
  self endon("arcade_game_over_for_player");
  self endon("player_too_far");
  var_2 = 6;
  for(;;) {
    var_1 waittill("grenade_pullback", var_3);
    if(var_3 != "iw7_cpknifethrow_mp") {
      continue;
    }

    if(!isDefined(var_1.disabledusability) || var_1.disabledusability == 0) {
      var_1 scripts\engine\utility::allow_usability(0);
    }

    var_1 waittill("grenade_fire", var_4, var_3);
    if(var_3 == "iw7_cpknifethrow_mp") {
      var_2--;
    }

    if(var_2 == 0) {
      break;
    }

    wait(0.1);
  }

  wait(1);
  var_1 thread func_6955(var_0, var_1);
}

func_D040(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("arcade_game_over_for_player");
  var_2 = var_1 scripts\engine\utility::waittill_any_return("disconnect", "last_stand", "player_too_far", "spawned");
  var_1 thread func_6955(var_0, var_1, var_2);
}

func_D09E(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("arcade_game_over_for_player");
  var_1 endon("spawned");
  var_1 endon("disconnect");
  var_2 = 10000;
  for(;;) {
    wait(0.1);
    if(distancesquared(var_1.origin, var_0.origin) > var_2) {
      wait(1);
      if(distancesquared(var_1.origin, var_0.origin) > var_2) {
        var_1 notify("player_too_far");
        return;
      }
    }
  }
}

func_6955(var_0, var_1, var_2) {
  var_0.var_A6FB show();
  var_0.knife_throw_target setCanDamage(0);
  turn_off_knife_throw_light(var_0);
  if(isDefined(var_1) && isalive(var_1)) {
    var_1 takeweapon("iw7_cpknifethrow_mp");
    var_1 scripts\cp\zombies\interaction_shooting_gallery::func_FEBF(var_1);
    var_1 setclientomnvar("zombie_ca_widget", 0);
    var_1.playing_game = undefined;
    var_1 scripts\engine\utility::allow_weapon_switch(1);
    if(!var_1 scripts\engine\utility::isusabilityallowed()) {
      var_1 scripts\engine\utility::allow_usability(1);
    }

    var_1 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(var_1);
    var_1 scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
    playsoundatpos(var_0.origin, "mp_slot_machine_coins");
    var_3 = var_0.score;
    if(var_1.arcade_game_award_type == "soul_power") {
      var_1 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(var_1, var_3);
    } else {
      var_1 scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_1, var_3);
    }

    if(!var_1 scripts\cp\utility::areinteractionsenabled()) {
      var_1 scripts\cp\utility::allow_player_interactions(1);
    }
  }

  var_1 notify("arcade_game_over_for_player");
  if(var_0.knife_throw_target.head_hit == 6) {
    scripts\cp\loot::give_max_ammo_to_player(var_1);
  }

  stop_wheel_sfx(var_0);
  wait(3);
  var_0.var_13CFD rotateto(var_0.var_13CFF, 1);
  wait(3);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  if(isDefined(var_1)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  }
}

turn_on_knife_throw_light(var_0) {
  var_1 = getEntArray(var_0.var_EF20, "targetname");
  foreach(var_3 in var_1) {
    var_3 setscriptablepartstate("knife_throw_light", "light_on");
  }
}

turn_off_knife_throw_light(var_0) {
  var_1 = getEntArray(var_0.var_EF20, "targetname");
  foreach(var_3 in var_1) {
    var_3 setscriptablepartstate("knife_throw_light", "light_off");
  }
}

give_knife_throw_rewards(var_0, var_1, var_2) {
  var_3 = get_knife_hit_location(var_0, var_1);
  var_4 = get_knife_hit_reward_point(var_3);
  if(var_3 == "j_helmet") {
    var_0.head_hit++;
  }

  var_2 iprintlnbold("+$" + var_4);
  var_2 scripts\cp\cp_persistence::give_player_currency(var_4);
}

get_knife_hit_location(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.damage_location.size; var_2++) {
    var_3 = var_0.damage_location[var_2];
    if(distancesquared(var_1, var_3.origin) <= var_3.damage_location_range) {
      return var_3.tag_location;
    }
  }

  return "body";
}

get_knife_hit_reward_point(var_0) {
  switch (var_0) {
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