/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_clowntooth.gsc
*********************************************************/

init_clowntooth_game() {
  var_00 = 4;
  var_01 = 7;
  var_02 = scripts\engine\utility::getstructarray("clown_tooth_game", "script_noteworthy");
  foreach(var_04 in var_02) {
    var_04 thread func_F918();
    var_04 thread scripts\cp\zombies\arcade_game_utility::turn_off_machine_after_uses(var_00, var_01);
    wait(0.05);
  }
}

init_afterlife_clowntooth_game() {
  var_00 = scripts\engine\utility::getstructarray("clown_tooth_game_afterlife", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread func_F918("afterlife");
    var_02.in_afterlife_arcade = 1;
    wait(0.05);
  }
}

func_F918(param_00) {
  var_01 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_02 = getEntArray(self.target, "targetname");
  self.var_115FB = [];
  foreach(var_04 in var_02) {
    if(var_04.classname == "light_spot") {
      self.setminimap = var_04;
      continue;
    }

    if(var_04.classname == "script_model") {
      var_04.var_12D72 = var_04.angles;
      self.var_115FB[self.var_115FB.size] = var_04;
    }
  }

  if(isDefined(self.setminimap)) {
    self.setminimap setlightintensity(0);
  }

  for(;;) {
    var_06 = "power_on";
    if(var_01) {
      var_06 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_06 == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      setomnvar("zombie_arcade_clowntooth_power_" + self.script_location, 0);
      wait(0.25);
      continue;
    }

    if(var_06 != "power_off" && !isDefined(param_00)) {
      self.powered_on = 1;
      setomnvar("zombie_arcade_clowntooth_power_" + self.script_location, 1);
      if(isDefined(self.setminimap)) {
        self.setminimap setlightintensity(2);
      }

      getent("cryptid_attack_arcade", "targetname") setModel("park_game_cryptid_attack");
    } else {
      self.powered_on = 0;
      if(isDefined(self.setminimap)) {
        self.setminimap setlightintensity(0);
      }
    }

    if(!var_01) {
      break;
    }
  }
}

use_clowntooth_game(param_00, param_01) {
  param_01 notify("cancel_sentry");
  param_01 notify("cancel_medusa");
  param_01 notify("cancel_trap");
  param_01 notify("cancel_boombox");
  param_01 notify("cancel_revocator");
  param_01 notify("cancel_ims");
  param_01 notify("cancel_gascan");
  scripts\cp\zombies\arcade_game_utility::set_arcade_game_award_type(param_01);
  param_01.playing_game = 1;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  level.wave_num_at_start_of_game = level.wave_num;
  if(!scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("clown_tooth_game", param_01);
  } else {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("clown_tooth_game_afterlife", param_01);
  }

  if(!scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    param_00 notify("machine_used");
  }

  param_01.pre_arcade_game_weapon = param_01 scripts\cp\zombies\arcade_game_utility::saveplayerpregameweapon(param_01);
  var_02 = scripts\engine\utility::getstructarray("cryptid_sound", "targetname");
  if(var_02.size > 0) {
    var_03 = scripts\engine\utility::getclosest(param_00.origin, var_02);
    playsoundatpos(var_03.origin, "arcade_cryptid_attack_start");
  }

  param_01 setclientomnvar("zombie_arcade_game_time", 1);
  param_01 setclientomnvar("zombie_ca_widget", 1);
  scripts\engine\utility::waitframe();
  param_00.destroynavrepulsor = 0;
  setomnvar("zombie_arcade_clowntooth_score_" + param_00.script_location, param_00.destroynavrepulsor);
  if(scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
    setomnvar("zombie_afterlife_clowntooth_balls", 6);
  } else {
    setomnvar("zombie_arcade_clowntooth_balls", 6);
  }

  param_01 scripts\cp\zombies\arcade_game_utility::take_player_grenades_pre_game();
  param_01 giveweapon("iw7_cpclowntoothball_mp");
  param_01 switchtoweapon("iw7_cpclowntoothball_mp");
  param_01 scripts\engine\utility::allow_weapon_switch(0);
  param_01 scripts\cp\utility::allow_player_interactions(0);
  param_01 thread func_42D7(param_00, param_01);
  param_00 thread func_F917(param_00, param_01);
  param_01 thread func_D040(param_00, param_01);
  param_01 thread func_D09E(param_00, param_01);
  if(isDefined(level.start_cryptid_attack_func)) {
    param_00 thread[[level.start_cryptid_attack_func]](param_00, param_01);
  }
}

func_F917(param_00, param_01) {
  param_00.remaining_teeth = param_00.var_115FB;
  foreach(var_03 in self.var_115FB) {
    if(var_03.angles != var_03.var_12D72) {
      var_03 playSound("arcade_tooth_reset");
      var_03 rotateto(var_03.var_12D72, 0.1);
    }

    var_03 setCanDamage(1);
    var_03 setCanRadiusDamage(1);
    var_03.health = 999999;
    var_03 thread func_13633(param_00, param_01);
    wait(0.05);
  }
}

func_13633(param_00, param_01) {
  param_01 endon("arcade_game_over_for_player");
  for(;;) {
    self waittill("damage", var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    self.health = 999999;
    if(!isDefined(var_0B) || var_0B != "iw7_cpclowntoothball_mp") {
      continue;
    }

    param_00.destroynavrepulsor++;
    self playSound("arcade_cryptid_attack_tooth_hit");
    if(isDefined(self.script_noteworthy)) {
      self playSound("arcade_" + self.script_noteworthy);
    } else {
      self playSound("zmb_wheel_spin_tick");
    }

    if(param_00.destroynavrepulsor == 6) {
      param_00.destroynavrepulsor = 10;
    }

    setomnvar("zombie_arcade_clowntooth_score_" + param_00.script_location, param_00.destroynavrepulsor * 10);
    self rotateto(scripts\engine\utility::getstruct(self.target, "targetname").angles, 0.1);
    param_00.remaining_teeth = scripts\engine\utility::array_remove(param_00.remaining_teeth, self);
    param_01 notify("hit_a_cryptid_tooth", self);
  }
}

func_42D7(param_00, param_01) {
  self endon("last_stand");
  self endon("disconnect");
  self endon("arcade_game_over_for_player");
  self endon("player_too_far");
  var_02 = 6;
  for(;;) {
    self waittill("grenade_pullback", var_03);
    if(var_03 != "iw7_cpclowntoothball_mp") {
      continue;
    }

    if(!isDefined(self.disabledusability) || self.disabledusability == 0) {
      scripts\engine\utility::allow_usability(0);
    }

    self waittill("grenade_fire", var_04, var_03);
    if(var_03 == "iw7_cpclowntoothball_mp") {
      self notify("throw_a_ball_at_cryptid_attack");
      var_02--;
      if(scripts\engine\utility::istrue(param_01.in_afterlife_arcade)) {
        setomnvar("zombie_afterlife_clowntooth_balls", var_02);
      } else {
        setomnvar("zombie_arcade_clowntooth_balls", var_02);
      }
    }

    if(var_02 == 0) {
      break;
    }

    wait(0.1);
  }

  wait(1);
  func_6946(param_00, self);
}

func_D040(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("arcade_game_over_for_player");
  var_02 = param_01 scripts\engine\utility::waittill_any_return("disconnect", "last_stand", "player_too_far", "spawned");
  func_6946(param_00, param_01, var_02);
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
      param_01 playlocalsound("purchase_deny");
      wait(1);
      if(distancesquared(self.origin, param_00.origin) > var_02) {
        param_01 notify("player_too_far");
        return;
      }
    }
  }
}

func_6946(param_00, param_01, param_02) {
  if(isDefined(param_01) && isalive(param_01)) {
    param_01 takeweapon("iw7_cpclowntoothball_mp");
    param_01 scripts\cp\zombies\interaction_shooting_gallery::func_FEBF(param_01);
    param_01 setclientomnvar("zombie_arcade_game_time", -1);
    param_01 setclientomnvar("zombie_arcade_game_ticket_earned", 0);
    param_01 setclientomnvar("zombie_ca_widget", 0);
    param_01.playing_game = undefined;
    param_01 scripts\engine\utility::allow_weapon_switch(1);
    if(!param_01 scripts\engine\utility::isusabilityallowed()) {
      param_01 scripts\engine\utility::allow_usability(1);
    }

    param_01 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(param_01);
    param_01 scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
    if(param_00.destroynavrepulsor > 0) {
      playsoundatpos(param_00.origin, "mp_slot_machine_coins");
    }

    if(param_00.destroynavrepulsor == 6) {
      wait(1);
      param_01 playlocalsound("purchase_perk");
      param_00.destroynavrepulsor = 10;
    }

    var_03 = param_00.destroynavrepulsor * 10;
    if(param_01.arcade_game_award_type == "soul_power") {
      param_01 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(param_01, var_03);
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, param_01, level.wave_num_at_start_of_game, "clown_tooth_game_afterlife", 1, var_03, param_01.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["clown_tooth_game_afterlife"]);
    } else {
      level notify("update_arcade_game_performance", "cryptid_attack", var_03);
      param_01 scripts\cp\zombies\arcade_game_utility::give_player_tickets(param_01, var_03);
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, param_01, level.wave_num_at_start_of_game, "clown_tooth_game", 0, var_03, param_01.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["clown_tooth_game"]);
    }

    if(!param_01 scripts\cp\utility::areinteractionsenabled()) {
      param_01 scripts\cp\utility::allow_player_interactions(1);
    }
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
  param_01 notify("arcade_game_over_for_player");
}