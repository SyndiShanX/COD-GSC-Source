/*********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_clowntooth.gsc
*********************************************************/

init_clowntooth_game() {
  var_0 = 4;
  var_1 = 7;
  var_2 = scripts\engine\utility::getstructarray("clown_tooth_game", "script_noteworthy");
  foreach(var_4 in var_2) {
    var_4 thread func_F918();
    var_4 thread scripts\cp\zombies\arcade_game_utility::turn_off_machine_after_uses(var_0, var_1);
    wait(0.05);
  }
}

init_afterlife_clowntooth_game() {
  var_0 = scripts\engine\utility::getstructarray("clown_tooth_game_afterlife", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread func_F918("afterlife");
    var_2.in_afterlife_arcade = 1;
    wait(0.05);
  }
}

func_F918(var_0) {
  var_1 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  var_2 = getEntArray(self.target, "targetname");
  self.var_115FB = [];
  foreach(var_4 in var_2) {
    if(var_4.classname == "light_spot") {
      self.setminimap = var_4;
      continue;
    }

    if(var_4.classname == "script_model") {
      var_4.var_12D72 = var_4.angles;
      self.var_115FB[self.var_115FB.size] = var_4;
    }
  }

  if(isDefined(self.setminimap)) {
    self.setminimap setlightintensity(0);
  }

  for(;;) {
    var_6 = "power_on";
    if(var_1) {
      var_6 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
    }

    if(var_6 == "power_off" && !scripts\engine\utility::istrue(self.powered_on)) {
      setomnvar("zombie_arcade_clowntooth_power_" + self.script_location, 0);
      wait(0.25);
      continue;
    }

    if(var_6 != "power_off" && !isDefined(var_0)) {
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

    if(!var_1) {
      break;
    }
  }
}

use_clowntooth_game(var_0, var_1) {
  var_1 notify("cancel_sentry");
  var_1 notify("cancel_medusa");
  var_1 notify("cancel_trap");
  var_1 notify("cancel_boombox");
  var_1 notify("cancel_revocator");
  var_1 notify("cancel_ims");
  var_1 notify("cancel_gascan");
  scripts\cp\zombies\arcade_game_utility::set_arcade_game_award_type(var_1);
  var_1.playing_game = 1;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  level.wave_num_at_start_of_game = level.wave_num;
  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("clown_tooth_game", var_1);
  } else {
    scripts\cp\zombies\zombie_analytics::log_times_per_wave("clown_tooth_game_afterlife", var_1);
  }

  if(!scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    var_0 notify("machine_used");
  }

  var_1.pre_arcade_game_weapon = var_1 scripts\cp\zombies\arcade_game_utility::saveplayerpregameweapon(var_1);
  var_2 = scripts\engine\utility::getstructarray("cryptid_sound", "targetname");
  if(var_2.size > 0) {
    var_3 = scripts\engine\utility::getclosest(var_0.origin, var_2);
    playsoundatpos(var_3.origin, "arcade_cryptid_attack_start");
  }

  var_1 setclientomnvar("zombie_arcade_game_time", 1);
  var_1 setclientomnvar("zombie_ca_widget", 1);
  scripts\engine\utility::waitframe();
  var_0.destroynavrepulsor = 0;
  setomnvar("zombie_arcade_clowntooth_score_" + var_0.script_location, var_0.destroynavrepulsor);
  if(scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
    setomnvar("zombie_afterlife_clowntooth_balls", 6);
  } else {
    setomnvar("zombie_arcade_clowntooth_balls", 6);
  }

  var_1 scripts\cp\zombies\arcade_game_utility::take_player_grenades_pre_game();
  var_1 giveweapon("iw7_cpclowntoothball_mp");
  var_1 switchtoweapon("iw7_cpclowntoothball_mp");
  var_1 scripts\engine\utility::allow_weapon_switch(0);
  var_1 scripts\cp\utility::allow_player_interactions(0);
  var_1 thread func_42D7(var_0, var_1);
  var_0 thread func_F917(var_0, var_1);
  var_1 thread func_D040(var_0, var_1);
  var_1 thread func_D09E(var_0, var_1);
  if(isDefined(level.start_cryptid_attack_func)) {
    var_0 thread[[level.start_cryptid_attack_func]](var_0, var_1);
  }
}

func_F917(var_0, var_1) {
  var_0.remaining_teeth = var_0.var_115FB;
  foreach(var_3 in self.var_115FB) {
    if(var_3.angles != var_3.var_12D72) {
      var_3 playSound("arcade_tooth_reset");
      var_3 rotateto(var_3.var_12D72, 0.1);
    }

    var_3 setCanDamage(1);
    var_3 setCanRadiusDamage(1);
    var_3.health = 999999;
    var_3 thread func_13633(var_0, var_1);
    wait(0.05);
  }
}

func_13633(var_0, var_1) {
  var_1 endon("arcade_game_over_for_player");
  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B);
    self.health = 999999;
    if(!isDefined(var_0B) || var_0B != "iw7_cpclowntoothball_mp") {
      continue;
    }

    var_0.destroynavrepulsor++;
    self playSound("arcade_cryptid_attack_tooth_hit");
    if(isDefined(self.script_noteworthy)) {
      self playSound("arcade_" + self.script_noteworthy);
    } else {
      self playSound("zmb_wheel_spin_tick");
    }

    if(var_0.destroynavrepulsor == 6) {
      var_0.destroynavrepulsor = 10;
    }

    setomnvar("zombie_arcade_clowntooth_score_" + var_0.script_location, var_0.destroynavrepulsor * 10);
    self rotateto(scripts\engine\utility::getstruct(self.target, "targetname").angles, 0.1);
    var_0.remaining_teeth = scripts\engine\utility::array_remove(var_0.remaining_teeth, self);
    var_1 notify("hit_a_cryptid_tooth", self);
  }
}

func_42D7(var_0, var_1) {
  self endon("last_stand");
  self endon("disconnect");
  self endon("arcade_game_over_for_player");
  self endon("player_too_far");
  var_2 = 6;
  for(;;) {
    self waittill("grenade_pullback", var_3);
    if(var_3 != "iw7_cpclowntoothball_mp") {
      continue;
    }

    if(!isDefined(self.disabledusability) || self.disabledusability == 0) {
      scripts\engine\utility::allow_usability(0);
    }

    self waittill("grenade_fire", var_4, var_3);
    if(var_3 == "iw7_cpclowntoothball_mp") {
      self notify("throw_a_ball_at_cryptid_attack");
      var_2--;
      if(scripts\engine\utility::istrue(var_1.in_afterlife_arcade)) {
        setomnvar("zombie_afterlife_clowntooth_balls", var_2);
      } else {
        setomnvar("zombie_arcade_clowntooth_balls", var_2);
      }
    }

    if(var_2 == 0) {
      break;
    }

    wait(0.1);
  }

  wait(1);
  func_6946(var_0, self);
}

func_D040(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("arcade_game_over_for_player");
  var_2 = var_1 scripts\engine\utility::waittill_any_return("disconnect", "last_stand", "player_too_far", "spawned");
  func_6946(var_0, var_1, var_2);
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
      var_1 playlocalsound("purchase_deny");
      wait(1);
      if(distancesquared(self.origin, var_0.origin) > var_2) {
        var_1 notify("player_too_far");
        return;
      }
    }
  }
}

func_6946(var_0, var_1, var_2) {
  if(isDefined(var_1) && isalive(var_1)) {
    var_1 takeweapon("iw7_cpclowntoothball_mp");
    var_1 scripts\cp\zombies\interaction_shooting_gallery::func_FEBF(var_1);
    var_1 setclientomnvar("zombie_arcade_game_time", -1);
    var_1 setclientomnvar("zombie_arcade_game_ticket_earned", 0);
    var_1 setclientomnvar("zombie_ca_widget", 0);
    var_1.playing_game = undefined;
    var_1 scripts\engine\utility::allow_weapon_switch(1);
    if(!var_1 scripts\engine\utility::isusabilityallowed()) {
      var_1 scripts\engine\utility::allow_usability(1);
    }

    var_1 scripts\cp\zombies\arcade_game_utility::give_player_back_weapon(var_1);
    var_1 scripts\cp\zombies\arcade_game_utility::restore_player_grenades_post_game();
    if(var_0.destroynavrepulsor > 0) {
      playsoundatpos(var_0.origin, "mp_slot_machine_coins");
    }

    if(var_0.destroynavrepulsor == 6) {
      wait(1);
      var_1 playlocalsound("purchase_perk");
      var_0.destroynavrepulsor = 10;
    }

    var_3 = var_0.destroynavrepulsor * 10;
    if(var_1.arcade_game_award_type == "soul_power") {
      var_1 scripts\cp\zombies\zombie_afterlife_arcade::give_soul_power(var_1, var_3);
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "clown_tooth_game_afterlife", 1, var_3, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["clown_tooth_game_afterlife"]);
    } else {
      level notify("update_arcade_game_performance", "cryptid_attack", var_3);
      var_1 scripts\cp\zombies\arcade_game_utility::give_player_tickets(var_1, var_3);
      scripts\cp\zombies\zombie_analytics::log_finished_mini_game(1, var_1, level.wave_num_at_start_of_game, "clown_tooth_game", 0, var_3, var_1.pers["timesPerWave"].var_11930[level.wave_num_at_start_of_game]["clown_tooth_game"]);
    }

    if(!var_1 scripts\cp\utility::areinteractionsenabled()) {
      var_1 scripts\cp\utility::allow_player_interactions(1);
    }
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  var_1 notify("arcade_game_over_for_player");
}