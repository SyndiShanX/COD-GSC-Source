/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_audio.gsc
**********************************************/

init() {
  level zmbvox();
  level maps\mp\zombies\_zombies_audio_announcer::initannouncer();
  level thread maps\mp\zombies\_zombies_music::init();

  if(isDefined(level._zmbvoxlevelspecific)) {
    level thread[[level._zmbvoxlevelspecific]]();
  }

  if(isDefined(level._zmbvoxgametypespecific)) {
    level thread[[level._zmbvoxgametypespecific]]();
  }

  if(!isDefined(level.zmbsoundlengthpath)) {
    level.zmbsoundlengthpath = "mp/sound/soundlength_zm_mp.csv";
  }

  level.zmbglobalpriorityvoonly = 0;
}

zmbvox() {
  level.vox = zmbvoxcreate();
  level.vox zmbvoxadd("player", "general", "intro", "rnd_wave1", undefined);
  level.vox zmbvoxadd("player", "general", "wave1", "wave1", undefined);
  level.vox zmbvoxadd("player", "general", "wave2", "wave2", undefined, 30);
  level.vox zmbvoxadd("player", "general", "wave_early", "wave_early", undefined);
  level.vox zmbvoxadd("player", "general", "wave_start", "wave_start", undefined, 30);
  level.vox zmbvoxadd("player", "general", "wave_end", "wave_end", undefined, 30);
  level.vox zmbvoxadd("player", "general", "weapon_reminder", "weapon_reminder", undefined);
  level.vox zmbvoxadd("player", "general", "dog_round", "dog_round", undefined, 50);
  level.vox zmbvoxadd("player", "general", "host_round", "host_round", undefined, 50);
  level.vox zmbvoxadd("player", "general", "crawl_spawn", "turn_crawler", "resp_crawler_start", 10);
  level.vox zmbvoxadd("player", "general", "resp_crawler_start", "crawler", undefined);
  level.vox zmbvoxadd("player", "general", "host_damaged", "player_attk_host", undefined, 10);
  level.vox zmbvoxadd("player", "general", "resp_crawler_start", "crawler", undefined);
  level.vox zmbvoxadd("player", "general", "ammo_low", "lowammo", undefined);
  level.vox zmbvoxadd("player", "general", "ammo_out", "out_of_ammo", undefined);
  level.vox zmbvoxadd("player", "general", "exo_upgrade_no_suit", "exo_upgrade_no_suit", undefined);
  level.vox zmbvoxadd("player", "general", "exo_upgrade_no_cash", "exo_upgrade_no_cash", undefined);
  level.vox zmbvoxadd("player", "general", "exo_suit_no_cash", "exo_suit_no_cash", undefined);
  level.vox zmbvoxadd("player", "general", "printer_moved", "printer_moved", undefined);
  level.vox zmbvoxadd("player", "general", "found_printer", "disc_prntr", undefined, 30);
  level.vox zmbvoxadd("player", "general", "shoot_arm", "dismemb", undefined, 7);
  level.vox zmbvoxadd("player", "general", "oh_shit", "zom_short_range", "resp_surrounded", 25);
  level.vox zmbvoxadd("player", "general", "resp_surrounded", "surround", undefined);
  level.vox zmbvoxadd("player", "general", "power_on", "power_on", undefined, 75);
  level.vox zmbvoxadd("player", "general", "power_off", "power_off", undefined, 50);
  level.vox zmbvoxadd("player", "general", "wpn_no_cash", "wpn_no_cash", undefined);
  level.vox zmbvoxadd("player", "general", "printer_no_cash", "printer_no_cash", undefined);
  level.vox zmbvoxadd("player", "general", "reloading", "wpn_reload", undefined, 30);
  level.vox zmbvoxadd("player", "general", "thanks", "thanks", undefined);
  level.vox zmbvoxadd("player", "general", "revive_down", "laststand", undefined);
  level.vox zmbvoxadd("player", "general", "revive_up", "revived", "resp_revive");
  level.vox zmbvoxadd("player", "general", "resp_revive", "revive", undefined, 30);
  level.vox zmbvoxadd("player", "general", "crawl_hit", "attk_crawler", undefined);
  level.vox zmbvoxadd("player", "general", "host_hit", "host_attk_player", undefined, 20);
  level.vox zmbvoxadd("player", "general", "infected", "host_infect_player", undefined);
  level.vox zmbvoxadd("player", "general", "emp", "emz_offline", undefined, 25);
  level.vox zmbvoxadd("player", "general", "cured", "player_clean_station", undefined, 30);
  level.vox zmbvoxadd("player", "general", "dog_hit", "dog_attk_player", "resp_dog_hit", 25);
  level.vox zmbvoxadd("player", "general", "resp_dog_hit", "dog", undefined);
  level.vox zmbvoxadd("player", "general", "laser_traps", "laser_traps", undefined);
  level.vox zmbvoxadd("player", "general", "bonus_line_over", "bonus_line1", undefined, 5);
  level.vox zmbvoxadd("player", "general", "bonus_line_not_over", "bonus_line2", undefined, 5);
  level.vox zmbvoxadd("player", "general", "round_5", "rd05", undefined);
  level.vox zmbvoxadd("player", "general", "round_10", "rd10", undefined);
  level.vox zmbvoxadd("player", "general", "round_20", "rd20", undefined);
  level.vox zmbvoxadd("player", "general", "round_35", "rd35", undefined);
  level.vox zmbvoxadd("player", "general", "round_50", "rd50", undefined);
  level.vox zmbvoxadd("player", "general", "orbital_drop_pre", "orbital_drop_pre", undefined);
  level.vox zmbvoxadd("player", "general", "orbital_drop_react", "orbital_drop_react", undefined);
  level.vox zmbvoxadd("player", "general", "orbital_drop_1st_get", "orbital_drop_1st_get", undefined);
  level.vox zmbvoxadd("player", "general", "ss_crate_capture", "ss_grab_ocp", undefined);
  level.vox zmbvoxadd("player", "general", "ss_money", "ss_bonus_ocp", undefined);
  level.vox zmbvoxadd("player", "general", "ss_shield", "ss_invinc", undefined);
  level.vox zmbvoxadd("player", "general", "ss_use_assault_drone", "ss_assault_drone", undefined);
  level.vox zmbvoxadd("player", "general", "ss_use_turret", "ss_turret", undefined);
  level.vox zmbvoxadd("player", "general", "ss_zom_destroy_turret", "ss_zom_destroy_turret", undefined);
  level.vox zmbvoxadd("player", "perk", "exo_suit", "exo_suit", undefined);
  level.vox zmbvoxadd("player", "perk", "exo_health", "exo_health", undefined);
  level.vox zmbvoxadd("player", "perk", "exo_slam", "exo_slam", undefined);
  level.vox zmbvoxadd("player", "perk", "exo_revive", "exo_stim", undefined);
  level.vox zmbvoxadd("player", "perk", "exo_stabilizer", "exo_stabilizer", undefined);
  level.vox zmbvoxadd("player", "perk", "specialty_fastreload", "exo_speed", undefined);
  level.vox zmbvoxadd("player", "perk", "exo_upgrade_no_suit", "exo_upgrade_no_suit", undefined);
  level.vox zmbvoxadd("player", "perk", "exo_upgrade_no_cash", "exo_upgrade_no_cash", undefined);
  level.vox zmbvoxadd("player", "perk", "exo_suit_no_cash", "exo_suit_no_cash", undefined);
  level.vox zmbvoxadd("player", "perk", "weapon_upgrade", "wpn_upgrade", undefined, 40);
  level.vox zmbvoxadd("player", "perk", "weapon_upgrade_max", "wpn_maxupgrd", undefined);
  level.vox zmbvoxadd("player", "powerup", "apocalypse", "apocalypse", undefined);
  level.vox zmbvoxadd("player", "powerup", "insta_kill", "instakill_pckup", undefined);
  level.vox zmbvoxadd("player", "powerup", "max_ammo", "max_ammo", undefined);
  level.vox zmbvoxadd("player", "powerup", "2x_pts", "2x_pts", undefined);
  level.vox zmbvoxadd("player", "powerup", "pow_surge", "pow_surge", undefined);
  level.vox zmbvoxadd("player", "powerup", "traps", "traps_pckup", undefined);
  level.vox zmbvoxadd("player", "kill", "melee", "kill_w_melee", undefined, 5);
  level.vox zmbvoxadd("player", "kill", "melee_instakill", "melee_instakill", undefined, 20);
  level.vox zmbvoxadd("player", "kill", "closekill", "closekill", undefined, 15);
  level.vox zmbvoxadd("player", "kill", "damage", "close_dmg", undefined, 15);
  level.vox zmbvoxadd("player", "kill", "streak", "killstreak", undefined);
  level.vox zmbvoxadd("player", "kill", "headshot", "headshot_dist", "resp_kill_headshot", 15);
  level.vox zmbvoxadd("player", "kill", "resp_kill_headshot", "headshot", undefined);
  level.vox zmbvoxadd("player", "kill", "explosive", "exp_kills", undefined, 15);
  level.vox zmbvoxadd("player", "kill", "fusion_rifle", "spec_weapon", undefined, 7);
  level.vox zmbvoxadd("player", "kill", "bullet", "kill_w_bullets", undefined, 1);
  level.vox zmbvoxadd("player", "kill", "distract_drone", "distract_drone_kill", undefined, 15);
  level.vox zmbvoxadd("player", "kill", "nano_swarm", "dna_bomb_kill", undefined, 15);
  level.vox zmbvoxadd("player", "kill", "crawler", "kill_crawler", undefined, 15);
  level.vox zmbvoxadd("player", "kill", "host", "player_kill_host", undefined, 20);
  level.vox zmbvoxadd("player", "kill", "dog", "kill_dog", undefined, 20);
  level.vox zmbvoxadd("player", "weapon_pickup", "explosive_drone_zombie_mp", "explosive_drone", undefined);
  level.vox zmbvoxadd("player", "weapon_pickup", "explosive_drone_throw_zombie_mp", "explosive_drone", undefined);
  level.vox zmbvoxadd("player", "weapon_pickup", "contact_grenade_zombies_mp", "contact_grenade", undefined);
  level.vox zmbvoxadd("player", "weapon_pickup", "contact_grenade_throw_zombies_mp", "contact_grenade", undefined);
  level.vox zmbvoxadd("player", "weapon_pickup", "iw5_fusionzm_mp", "laser_shotgun", "resp_weapon_fav");
  level.vox zmbvoxadd("player", "weapon_pickup", "distraction_drone_zombie_mp", "distract_drone", undefined);
  level.vox zmbvoxadd("player", "weapon_pickup", "distraction_drone_throw_zombie_mp", "distract_drone", undefined);
  level.vox zmbvoxadd("player", "weapon_pickup", "dna_aoe_grenade_zombie_mp", "dna_bomb", undefined);
  level.vox zmbvoxadd("player", "weapon_pickup", "dna_aoe_grenade_throw_zombie_mp", "dna_bomb", undefined);
  level.vox zmbvoxadd("player", "weapon_pickup", "favorite", "fav_wallweapon", undefined);
  level.vox zmbvoxadd("player", "weapon_pickup", "resp_weapon_fav", "special_wpn", undefined);
  level.vox zmbvoxadd("player", "weapon_pickup", "bad_weapon", "wpnpickup_bad", undefined, 30);
  level.vox zmbvoxadd("player", "weapon_pickup", "generic", "wpnpickup_gen", undefined, 40);
  level.vox zmbvoxadd("player", "exert", "pain0", "pain_grunt_low", undefined);
  level.vox zmbvoxadd("player", "exert", "pain1", "pain_grunt_med", undefined);
  level.vox zmbvoxadd("player", "exert", "pain2", "pain_grunt_high", undefined);
  level.vox zmbvoxadd("player", "exert", "death0", "death_grunt_low", undefined);
  level.vox zmbvoxadd("player", "exert", "death1", "death_grunt_med", undefined);
  level.vox zmbvoxadd("player", "exert", "death2", "death_grunt_high", undefined);
  level.vox zmbvoxadd("player", "exert", "grunt", "exertion_grunt", undefined);
  level.vox zmbvoxadd("player", "exert", "punch", "punch", undefined, 30);
  level.vox zmbvoxadd("player", "exert", "cough", "cough", undefined, 70);
  level.vox zmbvoxadd("player", "exert", "laugh", "laugh", undefined, 70);
  level.vox zmbvoxadd("player", "exert", "scream", "scream", undefined);
  level.vox zmbvoxadd("player", "exert", "sigh", "sigh", undefined);
  level.vox zmbvoxadd("player", "movement", "first_jump", "exo_first_jump", undefined);
  level.vox zmbvoxadd("player", "movement", "hit_head", "exo_headbump", undefined);
  level.vox zmbvoxadd("player", "monologue", "slide_chute", "slide_chute", undefined, 30);
  level.vox zmbvoxadd("player", "an_conv", "an_conv_1b", "an_conv_1b", "an_conv,an_conv_1c");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_1d", "an_conv_1d", undefined);
  level.vox zmbvoxadd("player", "an_conv", "an_conv_2", "an_conv_2a", "an_conv,an_conv_2b");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_3", "an_conv_3a", "an_conv,an_conv_3b");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_4", "an_conv_4a", "an_conv,an_conv_4b");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_4c", "an_conv_4c", "an_conv,an_conv_4d");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_5", "an_conv_5a", "an_conv,an_conv_5b");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_5c", "an_conv_5c", "an_conv,an_conv_5d");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_6b", "an_conv_6b", "an_conv,an_conv_6c");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_6d", "an_conv_6d", undefined);
  level.vox zmbvoxadd("player", "an_conv", "an_conv_7", "an_conv_7a", "an_conv,an_conv_7b");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_7c", "an_conv_7c", "an_conv,an_conv_7d");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_9b", "an_conv_9b", "an_conv,an_conv_9c");
  level.vox zmbvoxadd("player", "an_conv", "an_conv_11b", "an_conv_11b", undefined);
  level.zmb_vox = [];
  level.zmb_vox["prefix"] = "zmb_";
  level.zmb_vox["zombie_generic"] = [];
  level.zmb_vox["zombie_generic"]["idle_low"] = "gen_idle_low";
  level.zmb_vox["zombie_generic"]["idle_high"] = "gen_idle_high";
  level.zmb_vox["zombie_generic"]["move"] = "gen_scream";
  level.zmb_vox["zombie_generic"]["attack"] = "gen_scream";
  level.zmb_vox["zombie_generic"]["spawn"] = "gen_spawn";
  level.zmb_vox["zombie_generic"]["taunt"] = "gen_scream";
  level.zmb_vox["zombie_generic"]["behind"] = "gen_behind";
  level.zmb_vox["zombie_generic"]["pain"] = "gen_pain";
  level.zmb_vox["zombie_dog"] = [];
  level.zmb_vox["zombie_dog"]["idle"] = "dog_idle";
  level.zmb_vox["zombie_dog"]["attack"] = "dog_bite";
  level.zmb_vox["zombie_dog"]["spawn"] = "dog_spawn";
  level.zmb_vox["zombie_dog"]["behind"] = "dog_behind";
  level.zmb_vox["zombie_dog"]["pain"] = "dog_pain";
  level.zmb_vox["zombie_host"] = [];
  level.zmb_vox["zombie_host"]["idle_low"] = "hst_scream";
  level.zmb_vox["zombie_host"]["idle_high"] = "hst_scream";
  level.zmb_vox["zombie_host"]["move"] = "hst_scream";
  level.zmb_vox["zombie_host"]["attack"] = "hst_attack_scream";
  level.zmb_vox["zombie_host"]["spawn"] = "hst_scream";
  level.zmb_vox["zombie_host"]["taunt"] = "hst_scream";
  level.zmb_vox["zombie_host"]["behind"] = "hst_behind";
  level.zmb_vox["zombie_host"]["pain"] = "hst_scream";

  if(maps\mp\zombies\_util::getzombieslevelnum() > 2) {
    level.zmb_vox["zombie_melee_goliath"] = [];
    level.zmb_vox["zombie_melee_goliath"]["idle_low"] = "gol_idle";
    level.zmb_vox["zombie_melee_goliath"]["idle_high"] = "gol_scream";
    level.zmb_vox["zombie_melee_goliath"]["move"] = "gol_scream";
    level.zmb_vox["zombie_melee_goliath"]["attack"] = "gol_scream";
    level.zmb_vox["zombie_melee_goliath"]["spawn"] = "gol_scream";
    level.zmb_vox["zombie_melee_goliath"]["taunt"] = "gol_scream";
    level.zmb_vox["zombie_melee_goliath"]["behind"] = "gol_scream";
    level.zmb_vox["zombie_melee_goliath"]["pain"] = "gol_pain";
    level.zmb_vox["zombie_ranged_goliath"] = [];
    level.zmb_vox["zombie_ranged_goliath"]["idle_low"] = "gol_idle";
    level.zmb_vox["zombie_ranged_goliath"]["idle_high"] = "gol_scream";
    level.zmb_vox["zombie_ranged_goliath"]["move"] = "gol_scream";
    level.zmb_vox["zombie_ranged_goliath"]["attack"] = "gol_scream";
    level.zmb_vox["zombie_ranged_goliath"]["spawn"] = "gol_scream";
    level.zmb_vox["zombie_ranged_goliath"]["taunt"] = "gol_scream";
    level.zmb_vox["zombie_ranged_goliath"]["behind"] = "gol_scream";
    level.zmb_vox["zombie_ranged_goliath"]["pain"] = "gol_pain";
  }
}

volength(var_0, var_1) {
  var_2 = tablelookup(level.zmbsoundlengthpath, 0, var_0, 1);

  if(!isDefined(var_2) || var_2 == "") {
    if(isDefined(var_1) && var_1 == "exert") {
      return 0.5;
    } else if(isDefined(var_1) && (var_1 == "conversation" || var_1 == "an_conv")) {
      return 3;
    } else {
      return 2;
    }
  }

  var_2 = int(var_2);
  var_2 = var_2 * 0.001;
  return var_2;
}

init_audio_functions() {
  thread zombie_behind_vox();
  thread player_killstreak_init();
  thread oh_shit_vox();
  thread player_track_ammo_count();
  thread player_zone_tracking();
  thread player_movement_tracking();
  thread player_track_reload();
  thread player_track_punching();
}

player_track_punching() {
  for(;;) {
    self waittill("melee_fired");
    var_0 = playerexert("punch");

    if(var_0) {
      wait 5;
    }
  }
}

player_track_reload() {
  self endon("disconnect");

  for(;;) {
    if(self isreloading()) {
      create_and_play_dialog("general", "reloading");
      wait 30;
    }

    waitframe();
  }
}

player_movement_tracking() {
  self endon("disconnect");
  var_0 = 0;
  var_1 = 0;
  var_2 = 1;

  for(;;) {
    if(var_0 && var_1) {
      return;
    }
    if(!var_0 && maps\mp\zombies\_util::is_true(self.exosuitonline) && self ishighjumping()) {
      wait 0.2;

      if(isalive(self) && !maps\mp\zombies\_util::isplayerinlaststand(self)) {
        var_0 = create_and_play_dialog("movement", "first_jump");
      }
    } else if(!var_1 && maps\mp\zombies\_util::is_true(self.exosuitonline) && self ishighjumping() && self getvelocity()[2] >= 0) {
      var_3 = self getEye();
      var_4 = var_3 + (0, 0, 30);
      var_5 = bulletTrace(var_3, var_4, 0, self);

      if(var_5["fraction"] < 1) {
        var_1 = create_and_play_dialog("movement", "hit_head");
      }
    }

    waitframe();
  }
}

player_zone_tracking() {
  self endon("disconnect");
  self waittill("spawned_player");
  var_0 = undefined;

  while(!isDefined(level.zone_data)) {
    wait 0.05;
  }

  if(isDefined(level.zmbaudiozonetrackingdelay)) {
    wait(level.zmbaudiozonetrackingdelay);
  }

  for(;;) {
    var_1 = maps\mp\zombies\_zombies_zone_manager::getcurrentplayeroccupiedzonestructs();

    if(var_1.size > 0) {
      var_2 = var_1[0];

      if(!isDefined(var_0)) {
        var_0 = var_2;
        wait 1;
        continue;
      } else if(var_0 != var_2) {
        if(isDefined(var_2.power_switch) && !common_scripts\utility::flag(var_2.power_switch.script_flag) && (!isDefined(var_2.nextpoweroffvotime) || gettime() > var_2.nextpoweroffvotime)) {
          var_0 = var_2;
          thread playerpoweroffvo();
          var_0.nextpoweroffvotime = gettime() + 30000;
          wait 15;
        }
      }
    }

    wait 1;
  }
}

zombie_behind_vox() {
  self endon("disconnect");

  if(!isDefined(level._zbv_vox_last_update_time)) {
    level._zbv_vox_last_update_time = 0;
    level._audio_zbv_shared_ent_list = maps\mp\zombies\_util::get_round_enemy_array();
  }

  for(;;) {
    waitframe();
    var_0 = gettime();

    if(var_0 > level._zbv_vox_last_update_time + 1000) {
      level._zbv_vox_last_update_time = var_0;
      level._audio_zbv_shared_ent_list = maps\mp\zombies\_util::get_round_enemy_array();
    }

    var_1 = level._audio_zbv_shared_ent_list;
    var_2 = 0;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(!isDefined(var_1[var_3]) || !isDefined(var_1[var_3].agent_type) || !isDefined(var_1[var_3].enemy) || var_1[var_3].enemy != self) {
        continue;
      }
      var_4 = 200;
      var_5 = 50;

      if(isDefined(var_1[var_3].zombie_move_speed)) {
        switch (var_1[var_3].zombie_move_speed) {
          case "walk":
            var_4 = 200;
            break;
          case "run":
            var_4 = 250;
            break;
          case "sprint":
            var_4 = 275;
            break;
        }
      }

      if(distancesquared(var_1[var_3].origin, self.origin) < var_4 * var_4) {
        var_6 = getyawtospot(var_1[var_3].origin);
        var_7 = self.origin[2] - var_1[var_3].origin[2];

        if((var_6 < -95 || var_6 > 95) && abs(var_7) < 50) {
          var_1[var_3] thread do_zombies_playvocals("behind", var_1[var_3].agent_type, self);
          var_2 = 1;
          break;
        }
      }
    }

    if(var_2) {
      wait 6;
    }
  }
}

getyawtospot(var_0) {
  var_1 = var_0;
  var_2 = self.angles[1] - getyaw(var_1);
  var_2 = angleclamp180(var_2);
  return var_2;
}

getyaw(var_0) {
  var_1 = vectortoangles(var_0 - self.origin);
  return var_1[1];
}

do_zombies_playvocals(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = "zombie_generic";
  }

  if(!isDefined(self.talking)) {
    self.talking = 0;
  }

  if(!isDefined(level.zmb_vox[var_1])) {
    return;
  }
  if(!isDefined(level.zmb_vox[var_1][var_0])) {
    return;
  }
  var_3 = level.zmb_vox["prefix"] + level.zmb_vox[var_1][var_0];

  if(!soundexists(var_3)) {
    return;
  }
  if(var_0 == "behind") {
    self playsoundtoplayer(var_3, var_2);
  } else if(var_0 == "spawn" || var_0 == "idle_low" || var_0 == "idle_high" || var_0 == "move" || var_0 == "taunt" || var_0 == "pain") {
    if(var_0 == "spawn") {
      wait 0.1;
    }

    self playsoundonmovingent(var_3);
  } else if(!self.talking) {
    self.talking = 1;

    if(is_last_zombie() && soundexists(var_3 + "_loud")) {
      var_3 = var_3 + "_loud";
    }

    playsoundwaituntildone(var_3);
    self.talking = 0;
  }
}

is_last_zombie() {
  if(maps\mp\zombies\zombies_spawn_manager::getnumberofzombies() <= 1) {
    return 1;
  }

  return 0;
}

oh_shit_vox() {
  self endon("disconnect");
  var_0 = 62500;
  var_1 = 40000;
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    wait 1;
    var_4 = gettime() > var_2;
    var_5 = gettime() > var_3;

    if(!var_5 && !var_4) {
      continue;
    }
    var_6 = maps\mp\zombies\_util::get_round_enemy_array();
    var_7 = 0;
    var_8 = 0;

    for(var_9 = 0; var_9 < var_6.size; var_9++) {
      var_10 = var_6[var_9];
      var_11 = distancesquared(var_10.origin, self.origin);
      var_12 = isDefined(var_10.enemy) && var_10.enemy == self || !isDefined(var_10.enemy);

      if(var_4 && var_12 && var_11 < var_0) {
        var_7++;
      }

      var_13 = isDefined(var_10.agent_type) && var_10.agent_type == "zombie_host";

      if(var_5 && var_13 && var_11 < var_1) {
        var_8 = 1;
      }
    }

    if(var_7 > 4) {
      var_14 = create_and_play_dialog("general", "oh_shit");

      if(var_14) {
        var_2 = gettime() + 15000;
      }

      continue;
    }

    if(var_8) {
      var_14 = playerexert("cough");

      if(var_14) {
        var_3 = gettime() + 3000;
      }
    }
  }
}

zmbsetglobalpriorityonly(var_0) {
  if(var_0) {
    level.zmbglobalpriorityvoonly++;
  } else {
    level.zmbglobalpriorityvoonly--;
  }

  if(level.zmbglobalpriorityvoonly < 0) {
    level.zmbglobalpriorityvoonly = 0;
  }
}

create_and_play_dialog_delay(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");
  self endon("disconnect");
  wait(var_5);
  thread create_and_play_dialog(var_0, var_1, var_2, var_3, var_4, var_6);
}

create_and_play_dialog(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(self.zmbvoxid)) {
    return 0;
  }

  if(!isDefined(level.vox.speaker[self.zmbvoxid])) {
    return 0;
  }

  if(level.zmbglobalpriorityvoonly > 0 && var_0 != "global_priority") {
    return 0;
  }

  if(maps\mp\zombies\_util::is_true(self.dontspeak)) {
    return 0;
  }

  if(maps\mp\zombies\_util::isplayerinfected(self) && var_1 != "infected" && var_1 != "sq") {
    return 0;
  }

  if(!isDefined(self.isspeaking)) {
    self.isspeaking = 0;
  }

  if(maps\mp\zombies\_util::is_true(self.isspeaking)) {
    return 0;
  }

  if(areimportantspeakersnearby(var_0)) {
    return 0;
  }

  var_7 = isDefined(var_2);
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = maps\mp\zombies\_zombies_audio_announcer::isannouncer(self);

  if(!isDefined(level.vox.speaker[self.zmbvoxid].alias[var_0]) || !isDefined(level.vox.speaker[self.zmbvoxid].alias[var_0][var_1])) {
    return 0;
  }

  if(var_11 && !level.allowzmbannouncer) {
    return 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(!var_4 && !can_event_play(self.zmbvoxid, var_0, var_1)) {
    return 0;
  }

  var_12 = getarraykeys(level.vox.speaker[self.zmbvoxid].prefixes);
  var_10 = level.vox.speaker[self.zmbvoxid].prefixes[var_12[0]];
  var_8 = level.vox.speaker[self.zmbvoxid].alias[var_0][var_1];

  if(isplayer(self) || maps\mp\zombies\_util::is_true(self.fakeplayer)) {
    if(self.sessionstate != "playing") {
      return 0;
    }

    if(maps\mp\zombies\_util::isplayerinlaststand(self) && var_1 != "revive_down" && var_1 != "revive_up" && var_1 != "bonus_line_over") {
      return 0;
    }

    var_9 = maps\mp\zombies\_util::get_player_index(self);
    var_10 = level.vox.speaker[self.zmbvoxid].prefixes[var_9];
  }

  if(isDefined(level.zmbaudioplayaltvofunc) && self[[level.zmbaudioplayaltvofunc]](var_0, var_1, var_2, var_3, var_4, var_5, var_6)) {
    return 1;
  }

  var_13 = "";

  if(var_0 == "conversation") {
    if(!isDefined(var_3)) {
      var_3 = 1;
    }

    var_13 = build_dialog_line("", var_8, var_3);

    if(!soundexists(var_13)) {
      return 0;
    }
  } else {
    if(var_7) {
      var_14 = var_2 + var_8;
      var_15 = "any_" + var_8;
      var_16 = zmbvoxgetlinevariant(var_10, var_15, var_3);

      if(isDefined(var_16) && soundexists(var_16) && randomint(100) > 50) {
        var_8 = var_15;
      } else {
        var_8 = var_14;
      }
    }

    var_13 = zmbvoxgetlinevariant(var_10, var_8, var_3);

    if(!isDefined(var_13) && soundexists(var_10 + var_8)) {
      var_13 = var_10 + var_8;
    }
  }

  if(isDefined(var_13)) {
    if(!soundexists(var_13)) {
      return 0;
    }

    if(var_11) {
      thread maps\mp\zombies\_zombies_audio_announcer::playannouncerdialog(var_10, var_9, var_13, var_0, var_1, var_7, var_5, var_3, var_6);
    } else {
      thread do_player_or_npc_playvox(var_10, var_9, var_13, var_0, var_1, var_7, var_5, var_3, var_6);
    }
  } else {
    return 0;
  }

  return 1;
}

do_player_or_npc_playvox(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");
  self endon("stopSpeaking");
  var_9 = 0.25;

  if(var_3 == "exert") {
    var_9 = 0;
  }

  self.speakingline = var_2;
  self.isspeaking = 1;
  self notify("speaking");
  playsoundwaituntildone(var_2, var_3, var_4, var_8);

  if(var_9 > 0) {
    wait(var_9);
  }

  self notify("done_speaking");
  level notify("done_speaking");
  self.isspeaking = 0;

  if(var_3 == "conversation") {
    level thread setup_conversation_response_line(self, var_1, var_3, var_4, var_6, var_7);
  } else if(isDefined(level.vox.speaker[self.zmbvoxid].response) && isDefined(level.vox.speaker[self.zmbvoxid].response[var_3]) && isDefined(level.vox.speaker[self.zmbvoxid].response[var_3][var_4])) {
    if(isDefined(level._audio_custom_response_line)) {
      level thread[[level._audio_custom_response_line]](self, var_1, var_3, var_4, var_6);
    } else if(var_3 == "an_conv") {
      level thread setup_announcer_conversation_response_line(self, var_3, var_4);
    } else {
      level thread setup_response_line(self, var_1, var_3, var_4, var_6);
    }
  }
}

areimportantspeakersnearby(var_0) {
  return arenearbyspeakersactive() && !maps\mp\zombies\_util::is_true(self.ignorenearbyspkrs) && var_0 != "global_priority" && var_0 != "exert" && var_0 != "conversation" && var_0 != "ignore_nearby" && var_0 != "sq";
}

waituntilquietnearby(var_0, var_1) {
  while(var_0 arenearbyspeakersactive()) {
    waitframe();
  }
}

player_stop_speaking() {
  self notify("stopSpeaking");

  if(maps\mp\zombies\_util::is_true(self.isspeaking) && isDefined(self.speakingline)) {
    self stopsound(self.speakingline);
    self.isspeaking = 0;
  }
}

getrandomcharacterinrange(var_0) {
  var_1 = 250000;
  var_2 = [];

  foreach(var_4 in level.players) {
    if(!isDefined(var_4) || var_4 == var_0) {
      continue;
    }
    var_5 = distancesquared(var_0.origin, var_4.origin) < var_1;

    if(var_5) {
      var_2[var_2.size] = var_4;
    }
  }

  if(var_2.size == 1) {
    return var_2[0];
  } else if(var_2.size > 1) {
    var_7 = randomintrange(0, var_2.size);
    return var_2[var_7];
  }
}

setup_response_line(var_0, var_1, var_2, var_3, var_4) {
  if(level.players.size == 1) {
    return;
  }
  if(!isDefined(var_4)) {
    var_4 = getrandomcharacterinrange(var_0);
  }

  if(isDefined(var_4)) {
    var_5 = level.vox.speaker[var_4.zmbvoxid].response[var_2][var_3];

    if(isDefined(var_5)) {
      var_6 = level.vox.speaker[var_0.zmbvoxid].prefixes[var_1];
      var_4 create_and_play_dialog(var_2, var_5, var_6);
    }
  }
}

setup_conversation_response_line(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_4) && isalive(var_4)) {
    var_4 create_and_play_dialog(var_2, var_3, undefined, var_5 + 1, undefined, var_0);
  }
}

setup_announcer_conversation_response_line(var_0, var_1, var_2) {
  var_3 = maps\mp\zombies\_zombies_audio_announcer::getannouncer();
  var_4 = level.vox.speaker[var_0.zmbvoxid].response[var_1][var_2];
  var_5 = strtok(var_4, ",");

  if(var_5.size == 3) {
    var_6 = var_5[0];
    var_7 = maps\mp\zombies\_zombies_audio_announcer::getannouncers(var_6);

    if(var_7.size == 1) {
      var_1 = var_5[1];
      var_2 = var_5[2];
      var_7[0] create_and_play_dialog(var_1, var_2);
      return;
    }
  } else if(var_5.size == 2) {
    var_1 = var_5[0];
    var_2 = var_5[1];
    var_3 create_and_play_dialog(var_1, var_2);
  } else if(var_5.size == 1) {
    var_2 = var_5[0];
    var_8 = common_scripts\utility::array_randomize(level.players);

    foreach(var_0 in var_8) {
      var_10 = var_0 create_and_play_dialog(var_1, var_2, "");

      if(var_10) {
        break;
      }
    }
  }
}

player_killstreak_init() {
  self.timerisrunning = 0;
  self.killcounter = 0;
}

player_kill_zombie(var_0, var_1, var_2, var_3) {
  var_4 = 8;
  var_5 = 5;
  self.killcounter++;
  var_6 = 16;
  var_7 = isDefined(var_1) && var_1 == "MOD_MELEE";
  var_8 = isDefined(var_3.missingbodyparts) && var_3.missingbodyparts &var_6;

  if(var_7 && var_8) {
    playerlaugh();
  } else {
    thread player_zombie_kill_vox(var_0, var_1, var_2, var_3);
  }

  if(self.timerisrunning != 1) {
    self.timerisrunning = 1;
    thread timer_actual(var_4, var_5);
  }
}

player_zombie_kill_vox(var_0, var_1, var_2, var_3) {
  self endon("disconnect");

  if(!isDefined(var_3) || maps\mp\zombies\_util::is_true(self.force_wait_on_kill_line)) {
    return;
  }
  var_2 = getweaponbasename(var_2);
  var_4 = playertryzombiekillvo(var_0, var_1, var_2, var_3);

  if(isDefined(var_4)) {
    self.force_wait_on_kill_line = 1;
    wait 2;
    self.force_wait_on_kill_line = 0;
  }
}

can_event_play(var_0, var_1, var_2) {
  var_3 = get_event_chance(var_0, var_1, var_2);
  return var_3 > randomintrange(1, 100);
}

get_event_chance(var_0, var_1, var_2) {
  if(!isDefined(level.vox.speaker[var_0]) || !isDefined(level.vox.speaker[var_0].chance) || !isDefined(level.vox.speaker[var_0].chance[var_1]) || !isDefined(level.vox.speaker[var_0].chance[var_1][var_2])) {
    return 0;
  }

  return level.vox.speaker[var_0].chance[var_1][var_2];
}

playertryzombiekillvo(var_0, var_1, var_2, var_3) {
  var_4 = "kill";

  if(maps\mp\zombies\_util::istrapweapon(var_2)) {
    return;
  }
  if(isDefined(var_3.agent_type) && var_3.agent_type == "zombie_melee_goliath") {
    if(maps\mp\zombies\_util::getzombieslevelnum() > 2) {
      wait 2.5;
    }

    create_and_play_dialog(var_4, "goliath_kill");
    return "goliath_kill";
  }

  if(isDefined(var_3.sound_damage_player) && var_3.sound_damage_player == self && create_and_play_dialog(var_4, "damage")) {
    return "damage";
  }

  var_5 = distancesquared(self.origin, var_3.origin);

  if(maps\mp\_utility::isheadshot(var_2, var_0, var_1) && var_5 >= 160000 && create_and_play_dialog(var_4, "headshot")) {
    return "headshot";
  }

  var_6 = maps\mp\zombies\_util::gameflagexists("explosive_touch") && maps\mp\_utility::gameflag("explosive_touch");

  if(var_6 && isDefined(var_2) && var_2 == "explosive_touch_zombies_mp" && create_and_play_dialog(var_4, "melee_instakill")) {
    return "melee_instakill";
  }

  var_7 = maps\mp\zombies\_util::isinstakill();

  if(var_7) {
    if((var_1 == "MOD_MELEE" || var_1 == "MOD_MELEE_ALT") && create_and_play_dialog(var_4, "melee_instakill")) {
      return "melee_instakill";
    } else if(create_and_play_dialog(var_4, "weapon_instakill")) {
      return "weapon_instakill";
    }
  }

  if(maps\mp\zombies\_util::iszombiedistractiondrone(var_2) && create_and_play_dialog(var_4, "distract_drone")) {
    return "distract_drone";
  }

  if(maps\mp\zombies\_util::iszombiednagrenade(var_2) && create_and_play_dialog(var_4, "nano_swarm")) {
    return "nano_swarm";
  }

  if(isexplosivedamagemod(var_1) && var_2 != "repulsor_zombie_mp" && var_2 != "iw5_tridentzm_mp" && var_2 != "playermech_rocket_zm_mp" && var_2 != "iw5_juggernautrocketszm_mp" && create_and_play_dialog(var_4, "explosive")) {
    return "explosive";
  }

  if(var_5 < 4096 && create_and_play_dialog(var_4, "closekill")) {
    return "closekill";
  }

  if(var_3 maps\mp\zombies\_util::checkactivemutator("acid") && create_and_play_dialog(var_4, "acid_kill")) {
    return "acid_kill";
  }

  if(var_3.agent_type == "zombie_host" && create_and_play_dialog(var_4, "host")) {
    return "host";
  }

  if(var_3.agent_type == "zombie_dog" && create_and_play_dialog(var_4, "dog")) {
    return "dog";
  }

  if(maps\mp\zombies\_util::is_true(var_3.dismember_crawl) && create_and_play_dialog(var_4, "crawler")) {
    return "crawler";
  }

  if(var_2 == "iw5_microwavezm_mp" && create_and_play_dialog(var_4, "microwave")) {
    return "microwave";
  }

  if(var_2 == "iw5_fusionzm_mp" && create_and_play_dialog(var_4, "fusion_rifle")) {
    return "fusion_rifle";
  }

  if(maps\mp\zombies\_util::getzombieslevelnum() > 2) {
    if((var_2 == "iw5_linegunzm_mp" || var_2 == "iw5_linegundamagezm_mp") && create_and_play_dialog(var_4, "linegun")) {
      return "linegun";
    }

    if(var_2 == "iw5_dlcgun2zm_mp" && create_and_play_dialog(var_4, "ohm")) {
      return "ohm";
    }

    if(var_2 == "iw5_dlcgun3zm_mp" && create_and_play_dialog(var_4, "m1irons")) {
      return "m1irons";
    }

    if(var_2 == "repulsor_zombie_mp" && create_and_play_dialog(var_4, "respulsor")) {
      return "respulsor";
    }
  }

  if(maps\mp\zombies\_util::getzombieslevelnum() > 3) {
    if(var_2 == "iw5_tridentzm_mp" && create_and_play_dialog(var_4, "trident")) {
      return "trident";
    }

    if(var_2 == "iw5_dlcgun4zm_mp" && create_and_play_dialog(var_4, "blunderbuss")) {
      return "blunderbuss";
    }

    if(var_2 == "iw5_exominigunzm_mp") {
      if((var_1 == "MOD_MELEE" || var_1 == "MOD_MELEE_ALT") && create_and_play_dialog(var_4, "gol_melee_kill")) {
        return "gol_melee";
      }
    }

    if(var_2 == "playermech_rocket_zm_mp" && create_and_play_dialog(var_4, "gol_missile_kill")) {
      return "gol_missile";
    }

    if(var_2 == "iw5_juggernautrocketszm_mp" && create_and_play_dialog(var_4, "gol_rocket_kill")) {
      return "gol_rocket";
    }
  }

  if((var_1 == "MOD_MELEE" || var_1 == "MOD_MELEE_ALT") && create_and_play_dialog(var_4, "melee")) {
    return "melee";
  }

  if((var_1 == "MOD_RIFLE_BULLET" || var_1 == "MOD_PISTOL_BULLET") && create_and_play_dialog(var_4, "bullet")) {
    return "bullet";
  }
}

timer_actual(var_0, var_1) {
  self endon("disconnect");
  self endon("death");
  var_2 = gettime() + var_1 * 1000;

  while(gettime() < var_2) {
    if(self.killcounter > var_0) {
      thread create_and_play_dialog_delay("kill", "streak", undefined, undefined, undefined, 1);
      wait 2;
      self.killcounter = 0;
      var_2 = -2;
    }

    wait 0.1;
  }

  wait 10;
  self.killcounter = 0;
  self.timerisrunning = 0;
}

player_hurt(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2 == "MOD_FALLING" && !maps\mp\_utility::isjuggernaut()) {
    thread playerexert("grunt");
  } else if(isDefined(var_0) && isai(var_0)) {
    if(isDefined(var_0.agent_type) && var_0.agent_type == "zombie_host") {
      thread create_and_play_dialog_delay("general", "host_hit", undefined, undefined, 1, 1);
    } else if(isDefined(var_0.agent_type) && var_0.agent_type == "zombie_dog") {
      thread create_and_play_dialog_delay("general", "dog_hit", undefined, undefined, 1, 1);
    }

    if(var_1 < self.health) {
      var_0.sound_damage_player = self;

      if(maps\mp\zombies\_util::is_true(var_0.dismember_crawl)) {
        thread create_and_play_dialog("general", "crawl_hit");
      }
    }
  }
}

player_emp() {
  var_0 = !isDefined(self.hitbyemp);
  thread create_and_play_dialog("general", "emp", undefined, undefined, var_0);
  self.hitbyemp = 1;
}

player_infected() {
  if(isDefined(self.hasburgerinfected)) {
    return;
  }
  thread create_and_play_dialog_delay("general", "infected", undefined, undefined, undefined, 3);
}

player_cured() {
  thread create_and_play_dialog_delay("general", "cured", undefined, undefined, undefined, 1);
}

zombie_hurt(var_0, var_1) {
  if(isDefined(var_0) && isplayer(var_0) && var_1 < self.health) {
    if(var_0 isjumping()) {
      var_0 thread playerlaugh();
    } else if(isDefined(self.agent_type) && self.agent_type == "zombie_host") {
      var_0 thread player_hurt_zombie_vox("host_damaged");
    }
  }
}

playerlaugh() {
  if(!isDefined(self.nextlaughtime) || gettime() > self.nextlaughtime) {
    var_0 = playerexert("laugh");

    if(var_0) {
      self.nextlaughtime = gettime() + 15000;
    }
  }
}

player_hurt_zombie_vox(var_0) {
  thread create_and_play_dialog_delay("general", var_0, undefined, undefined, undefined, 1);
}

player_track_ammo_count() {
  self notify("stop_ammo_tracking");
  self endon("disconnect");
  self endon("stop_ammo_tracking");
  var_0 = [];
  var_1 = 0;
  var_2 = self getcurrentweapon();
  var_3 = var_2;

  for(;;) {
    wait 0.1;
    var_3 = var_2;
    var_2 = self getcurrentweapon();

    if(!isDefined(var_2) || var_2 == "none" || !can_track_ammo(var_2)) {
      continue;
    }
    if(maps\mp\zombies\_util::gameflagexists("unlimited_ammo") && maps\mp\_utility::gameflag("unlimited_ammo")) {
      continue;
    }
    if(!isDefined(var_0[var_2])) {
      var_0[var_2] = 0;
    }

    if(!playerammolow(var_2) || maps\mp\zombies\_util::isplayerinlaststand(self)) {
      continue;
    }
    if(playerammoout()) {
      if(gettime() > var_1) {
        create_and_play_dialog("general", "ammo_out");
        var_1 = gettime() + 20000;
      }

      continue;
    }

    if(gettime() > var_0[var_2]) {
      create_and_play_dialog("general", "ammo_low");
      var_0[var_2] = gettime() + 20000;
    }
  }
}

playerammolow(var_0) {
  if(isDefined(level.playerammolowfunc)) {
    var_1 = [[level.playerammolowfunc]](var_0);

    if(isDefined(var_1)) {
      return var_1;
    }
  }

  if(var_0 == "search_dstry_bomb_defuse_mp") {
    return 0;
  }

  if(issubstr(var_0, "iw5_em1zm_mp") && maps\mp\zombies\_util::playerhasem1ammoinfo()) {
    var_2 = maps\mp\zombies\_util::playergetem1ammo();
    var_3 = maps\mp\gametypes\zombies::getem1maxammo();
    return var_2 / var_3 < 0.05;
  } else if(maps\mp\zombies\_util::isrippedturretweapon(var_0) && maps\mp\killstreaks\_rippedturret::playerhasrippableturretinfo()) {
    var_2 = maps\mp\killstreaks\_rippedturret::playergetrippableammo();
    var_3 = maps\mp\killstreaks\_rippedturret::getammoforturretweapontype(var_0);
    return var_2 / var_3 < 0.05;
  } else {
    return self getweaponammostock(var_0) == 0;
  }
}

playerammoout() {
  var_0 = 0;
  var_1 = self getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3 == "search_dstry_bomb_defuse_mp") {
      continue;
    }
    if(issubstr(var_3, "iw5_em1zm_mp") && maps\mp\zombies\_util::playerhasem1ammoinfo()) {
      var_4 = maps\mp\zombies\_util::playergetem1ammo();

      if(var_4 > 0) {
        var_0 = 1;
        break;
      }

      continue;
    }

    if(maps\mp\zombies\_util::isrippedturretweapon(var_3) && maps\mp\killstreaks\_rippedturret::playerhasrippableturretinfo()) {
      var_4 = maps\mp\killstreaks\_rippedturret::playergetrippableammo();

      if(var_4 > 0) {
        var_0 = 1;
        break;
      }

      continue;
    }

    if(self getammocount(var_3) > 0) {
      var_0 = 1;
      break;
    }
  }

  return !var_0;
}

can_track_ammo(var_0) {
  if(!isDefined(var_0) || var_0 == "none") {
    return 0;
  }

  if(maps\mp\zombies\weapons\_zombie_weapons::isplaceableminetype(var_0) || maps\mp\zombies\_util::iszombieequipment(var_0) || maps\mp\zombies\_util::iszombiekillstreakweapon(var_0) || var_0 == maps\mp\gametypes\zombies::getexosuitequipweaponname() || var_0 == maps\mp\gametypes\zombies::getcharacterintroweaponname() || var_0 == maps\mp\gametypes\zombies::getcharacterintroidleweapon() || var_0 == maps\mp\gametypes\zombies::getexosuitperkweaponname("health") || var_0 == maps\mp\gametypes\zombies::getexosuitperkweaponname("stabilizer") || var_0 == maps\mp\gametypes\zombies::getexosuitperkweaponname("stim") || var_0 == maps\mp\gametypes\zombies::getexosuitperkweaponname("slam") || var_0 == maps\mp\gametypes\zombies::getexosuitperkweaponname("fastreload") || var_0 == "iw5_combatknife_mp" || var_0 == "iw5_combatknifegoliath_mp") {
    return 0;
  }

  return 1;
}

weapon_toggle_vox(var_0, var_1) {
  self notify("audio_activated_trigger");
  self endon("audio_activated_trigger");
  var_2 = "vox_pa_switcher_";
  var_3 = var_2 + var_0;
  var_4 = undefined;

  if(isDefined(var_1)) {
    var_4 = get_weapon_num(var_1);

    if(!isDefined(var_4)) {
      return;
    }
  }

  self stopsounds();
  wait 0.05;

  if(isDefined(var_4)) {
    playsoundwaituntildone(var_2 + "weapon_" + var_4, "sounddone");
  }

  self playSound(var_3 + "_0");
}

get_weapon_num(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "humangun_zm":
      var_1 = 0;
      break;
    case "sniper_explosive_zm":
      var_1 = 1;
      break;
    case "tesla_gun_zm":
      var_1 = 2;
      break;
  }

  return var_1;
}

addasspeakernpc(var_0) {
  if(!isDefined(level.npcs)) {
    level.npcs = [];
  }

  if(maps\mp\zombies\_util::is_true(var_0)) {
    self.ignorenearbyspkrs = 1;
  } else {
    self.ignorenearbyspkrs = 0;
  }

  self.isnpc = 1;
  level.npcs[level.npcs.size] = self;
}

arenearbyspeakersactive() {
  var_0 = 1000000;
  var_1 = 0;
  var_2 = maps\mp\zombies\_zombies_audio_announcer::isannouncer(self);
  var_3 = level.players;

  if(isDefined(level.npcs)) {
    var_3 = common_scripts\utility::array_combine(var_3, level.npcs);
  }

  foreach(var_5 in var_3) {
    if(self == var_5) {
      continue;
    }
    if(isplayer(var_5)) {
      if(var_5.sessionstate != "playing" || maps\mp\zombies\_util::isplayerinlaststand(var_5)) {
        continue;
      }
    } else {}

    if(maps\mp\zombies\_util::is_true(var_5.isspeaking) && !maps\mp\zombies\_util::is_true(var_5.ignorenearbyspkrs)) {
      if(var_2 || distancesquared(self.origin, var_5.origin) < var_0) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

zmbvoxcreate() {
  var_0 = spawnStruct();
  var_0.speaker = [];
  return var_0;
}

zmbvoxinitspeaker(var_0, var_1, var_2, var_3) {
  var_2.zmbvoxid = var_0;

  if(!isDefined(self.speaker[var_0])) {
    self.speaker[var_0] = spawnStruct();
    self.speaker[var_0].alias = [];
    self.speaker[var_0].prefixes = [];
    self.speaker[var_0].ents = [];
  }

  self.speaker[var_0].ents[var_3] = var_2;
  self.speaker[var_0].prefixes[var_3] = var_1;
}

zmbvoxadd(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(self.speaker[var_0])) {
    self.speaker[var_0] = spawnStruct();
    self.speaker[var_0].alias = [];
    self.speaker[var_0].prefixes = [];
    self.speaker[var_0].ents = [];
  }

  if(!isDefined(self.speaker[var_0].alias[var_1])) {
    self.speaker[var_0].alias[var_1] = [];
  }

  self.speaker[var_0].alias[var_1][var_2] = var_3;

  if(isDefined(var_4)) {
    if(!isDefined(self.speaker[var_0].response)) {
      self.speaker[var_0].response = [];
    }

    if(!isDefined(self.speaker[var_0].response[var_1])) {
      self.speaker[var_0].response[var_1] = [];
    }

    self.speaker[var_0].response[var_1][var_2] = var_4;
  }

  if(!isDefined(var_5)) {
    var_5 = 100;
  }

  if(!isDefined(self.speaker[var_0].chance)) {
    self.speaker[var_0].chance = [];
  }

  if(!isDefined(self.speaker[var_0].chance[var_1])) {
    self.speaker[var_0].chance[var_1] = [];
  }

  self.speaker[var_0].chance[var_1][var_2] = var_5;
}

build_dialog_line(var_0, var_1, var_2) {
  if(var_2 < 10) {
    return var_0 + var_1 + "_0" + var_2;
  } else {
    return var_0 + var_1 + "_" + var_2;
  }
}

zmbvoxgetlinevariant(var_0, var_1, var_2) {
  if(!isDefined(self.sound_dialog)) {
    self.sound_dialog = [];
    self.sound_dialog_available = [];
  }

  if(!isDefined(self.sound_dialog[var_1])) {
    var_3 = get_number_variants(var_0, var_1);

    if(var_3 <= 0) {
      return undefined;
    }

    for(var_4 = 0; var_4 < var_3; var_4++) {
      self.sound_dialog[var_1][var_4] = var_4 + 1;
    }

    self.sound_dialog_available[var_1] = [];
  }

  if(self.sound_dialog_available[var_1].size <= 0) {
    for(var_4 = 0; var_4 < self.sound_dialog[var_1].size; var_4++) {
      self.sound_dialog_available[var_1][var_4] = self.sound_dialog[var_1][var_4];
    }
  }

  var_5 = common_scripts\utility::random(self.sound_dialog_available[var_1]);
  self.sound_dialog_available[var_1] = common_scripts\utility::array_remove(self.sound_dialog_available[var_1], var_5);

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  return build_dialog_line(var_0, var_1, var_5);
}

playsoundwaituntildone(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1 == "monologue") {
    self playlocalsound(var_0);
  } else if(isDefined(var_3) && var_3.size > 0) {
    var_3 = common_scripts\utility::array_removeundefined(var_3);

    foreach(var_5 in var_3) {
      if(isDefined(var_5)) {
        self playsoundtoplayer(var_0, var_5, 1);
      }
    }
  } else {
    self playsoundonmovingent(var_0);
  }

  var_7 = volength(var_0, var_1);
  wait(var_7);
}

get_number_variants(var_0, var_1) {
  var_2 = 100;

  for(var_3 = 1; var_3 < var_2; var_3++) {
    if(!soundexists(build_dialog_line(var_0, var_1, var_3))) {
      return var_3 - 1;
    }
  }

  return var_2;
}

play_level_start_vox() {
  level thread setupwaveintermissiondialog();
  wait 1;

  if(isDefined(level.zmbaudiowave1vo)) {
    level thread[[level.zmbaudiowave1vo]]();
  } else if(level.players.size == 1) {
    var_0 = randomintrange(0, level.players.size);
    level.players[var_0] thread create_and_play_dialog("general", "intro");
  } else {
    level thread playwavenumintrodialog("wave1", 1, 2, 0, 3);
  }

  level.zmplayedearlywavevo = 0;

  for(;;) {
    level waittill("zombie_wave_started");
    wait 1;
    var_1 = 0;

    if(!maps\mp\zombies\_zombies_audio_announcer::isannouncinground()) {
      maps\mp\zombies\_zombies_audio_announcer::waittillannouncerdonespeaking();
    } else {
      var_1 = 1;
    }

    if(isDefined(level.zmbaudiowavestartvo)) {
      var_1 = [[level.zmbaudiowavestartvo]](var_1);
    } else {
      if(!var_1 && level.wavecounter == 2) {
        playwavenumintrodialog("wave2", 2, 0, 1, 3);
        var_1 = 1;
      } else if(!var_1 && (level.wavecounter == 5 || level.wavecounter == 10 || level.wavecounter == 20 || level.wavecounter == 35 || level.wavecounter == 50)) {
        var_0 = randomintrange(0, level.players.size);
        level.players[var_0] create_and_play_dialog("general", "round_" + level.wavecounter);
        var_1 = 1;
      }

      if(!var_1 && level.wavecounter > 2 && !level.zmplayedearlywavevo) {
        var_2 = randomintrange(0, 100);

        if(var_2 < 30) {
          playwavenumintrodialog("wave_early", 0, 2, 1, 3);
          level.zmplayedearlywavevo = 0;
          var_1 = 1;
        }
      }
    }

    if(!var_1 && level.wavecounter > 1) {
      var_0 = randomintrange(0, level.players.size);
      level.players[var_0] create_and_play_dialog("general", "wave_start");
      var_1 = 1;
    }

    level waittill("zombie_wave_ended");
    var_3 = 1;
    var_4 = 0;

    if(isDefined(level.zmbdowaveendvo)) {
      var_3 = [[level.zmbdowaveendvo]]();
    }

    if(var_3) {
      wait 1;
      var_0 = randomintrange(0, level.players.size);
      var_4 = level.players[var_0] create_and_play_dialog("general", "wave_end");

      if(var_4) {
        level.players[var_0] common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
        wait 1;
      }
    }

    if(isDefined(level.zmbwaveintermissionvo)) {
      var_4 = [[level.zmbwaveintermissionvo]](var_4);
    }

    if(!playweaponremindervo() && !var_4) {
      playwaveintermissiondialog();
    }
  }
}

playwavenumintrodialog(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = "general";
  }

  var_6 = getcharacterbyindex(var_1);

  if(isDefined(var_6) && var_6 create_and_play_dialog(var_5, var_0)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }

  var_6 = getcharacterbyindex(var_2);

  if(isDefined(var_6) && var_6 create_and_play_dialog(var_5, var_0)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }

  var_6 = getcharacterbyindex(var_3);

  if(isDefined(var_6) && var_6 create_and_play_dialog(var_5, var_0)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }

  var_6 = getcharacterbyindex(var_4);

  if(isDefined(var_6) && var_6 create_and_play_dialog(var_5, var_0)) {
    level common_scripts\utility::waittill_notify_or_timeout("done_speaking", 6);
  }
}

playweaponremindervo() {
  if(level.wavecounter == 2) {
    var_0 = getplayerwhoonlyhaspistol();

    if(isDefined(var_0)) {
      return var_0 create_and_play_dialog("general", "weapon_reminder", undefined, 1);
    }
  } else if(level.wavecounter == 10) {
    var_0 = getplayerwhohasnotupgraded();

    if(isDefined(var_0)) {
      return var_0 create_and_play_dialog("general", "weapon_reminder", undefined, 2);
    }
  }

  return 0;
}

getplayerwhoonlyhaspistol() {
  foreach(var_1 in level.players) {
    var_2 = var_1 getweaponslistprimaries();

    if(var_2.size == 1 && var_2[0] == "iw5_titan45zm_mp") {
      return var_1;
    }
  }
}

getplayerwhohasnotupgraded() {
  foreach(var_1 in level.players) {
    var_2 = var_1 getweaponslistprimaries();

    foreach(var_4 in var_2) {
      if(maps\mp\zombies\_util::getzombieweaponlevel(var_1, var_4) < 2) {
        return var_1;
      }
    }
  }
}

setupwaveintermissiondialog() {
  level.zmwaveintermissiondialog = [];
  level.zmwaveintermissiondialog[0] = newwaveintermissionstruct();
  level.zmwaveintermissiondialog[1] = newwaveintermissionstruct();
}

newwaveintermissionstruct() {
  var_0 = spawnStruct();
  var_0.characters = [];
  var_0.prefixes = [];
  var_0.sequence = 1;
  var_0.active = 0;
  var_0.completed = 0;
  var_0.nextround = 1;
  return var_0;
}

playwaveintermissiondialog() {
  if(level.players.size == 1 || !isDefined(level.vox.speaker["player"].alias["conversation"])) {
    return 0;
  }

  foreach(var_1 in level.zmwaveintermissiondialog) {
    if(dialogcanplay(var_1) && playdialog(var_1)) {
      dialogincrement(var_1);
      return 1;
    }
  }

  foreach(var_1 in level.zmwaveintermissiondialog) {
    if(!var_1.active && createdialog(var_1)) {
      if(playdialog(var_1)) {
        dialogincrement(var_1);
        return 1;
      } else {
        return 0;
      }
    }
  }

  return 0;
}

dialogcanplay(var_0) {
  return var_0.active && var_0.nextround <= level.wavecounter && dialogcharactersactive(var_0);
}

dialogcharactersactive(var_0) {
  if(var_0.characters.size != 2) {
    return 0;
  }

  foreach(var_2 in var_0.characters) {
    if(!isDefined(var_2) || !maps\mp\_utility::isreallyalive(var_2)) {
      return 0;
    }
  }

  return 1;
}

dialogincrement(var_0) {
  var_0.nextround = var_0.nextround + randomintrange(2, 4);
  var_0.sequence++;
}

playerinanydialog() {
  foreach(var_1 in level.zmwaveintermissiondialog) {
    if(common_scripts\utility::array_contains(var_1.characters, self)) {
      return 1;
    }
  }

  return 0;
}

createdialog(var_0) {
  var_1 = common_scripts\utility::array_randomize(level.players);
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    if(!var_5 playerinanydialog()) {
      if(!isDefined(var_2)) {
        var_2 = var_5;
      } else {
        var_3 = var_5;
      }
    }

    if(isDefined(var_2) && isDefined(var_3)) {
      break;
    }
  }

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return 0;
  }

  var_0.characters[0] = var_2;
  var_0.characters[1] = var_3;
  var_0.prefixes[0] = level.vox.speaker[var_2.zmbvoxid].prefixes[maps\mp\zombies\_util::get_player_index(var_2)];
  var_0.prefixes[1] = level.vox.speaker[var_3.zmbvoxid].prefixes[maps\mp\zombies\_util::get_player_index(var_3)];
  var_0.active = 1;
  var_0.completed = 0;
  return 1;
}

playdialog(var_0) {
  var_1 = "" + var_0.prefixes[0] + var_0.prefixes[1] + var_0.sequence;
  var_2 = var_0.characters[0];
  var_3 = var_0.characters[1];

  if(!isDefined(level.vox.speaker["player"].alias["conversation"][var_1])) {
    var_1 = "" + var_0.prefixes[1] + var_0.prefixes[0] + var_0.sequence;
    var_2 = var_0.characters[1];
    var_3 = var_0.characters[0];

    if(!isDefined(level.vox.speaker["player"].alias["conversation"][var_1])) {
      var_0.completed = 1;
      return 0;
    }
  }

  return var_2 create_and_play_dialog("conversation", var_1, undefined, undefined, undefined, var_3);
}

getcharacterbyindex(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.characterindex == var_0) {
      return var_2;
    }
  }
}

getcharacterindexbyprefix(var_0) {
  switch (var_0) {
    case "guard":
      return 0;
    case "exec":
      return 1;
    case "it":
      return 2;
    case "pilot":
    case "janitor":
      return 3;
  }
}

getcharacterbyprefix(var_0) {
  return getcharacterbyindex(getcharacterindexbyprefix(var_0));
}

getanycharacterbyprefixexcept(var_0) {
  var_1 = getcharacterbyprefix(var_0);

  if(!isDefined(var_1)) {
    return level.players[randomint(level.players.size)];
  } else {
    var_2 = common_scripts\utility::array_randomize(level.players);

    foreach(var_4 in level.players) {
      if(var_4 != var_1) {
        return var_4;
      }
    }
  }
}

play_weapon_vo(var_0) {
  if(!isplayer(self)) {
    return;
  }
  var_0 = getweaponbasename(var_0);
  var_1 = weapon_type_check(var_0);

  if(var_1 == "skip") {
    return;
  }
  create_and_play_dialog("weapon_pickup", var_1);
}

is_favorite_weapon(var_0) {
  if(!isDefined(self.favorite_wall_weapons_list)) {
    return 0;
  }

  foreach(var_2 in self.favorite_wall_weapons_list) {
    if(issubstr(var_0, var_2)) {
      return 1;
    }
  }

  return 0;
}

is_bad_weapon(var_0) {
  return 0;
}

has_custom_weapon_vo(var_0) {
  switch (var_0) {
    case "iw5_dlcgun4zm_mp":
    case "iw5_dlcgun3zm_mp":
    case "iw5_dlcgun2zm_mp":
    case "iw5_linegunzm_mp":
    case "iw5_fusionzm_mp":
    case "iw5_tridentzm_mp":
    case "iw5_microwavezm_mp":
    case "teleport_throw_zombies_mp":
    case "dna_aoe_grenade_zombie_mp":
    case "distraction_drone_throw_zombie_mp":
    case "distraction_drone_zombie_mp":
    case "explosive_drone_throw_zombie_mp":
    case "explosive_drone_zombie_mp":
    case "contact_grenade_throw_zombies_mp":
    case "contact_grenade_zombies_mp":
    case "dna_aoe_grenade_throw_zombie_mp":
    case "teleport_zombies_mp":
    case "repulsor_zombie_mp":
      return 1;
    default:
      break;
  }

  return 0;
}

skip_weapon_vo(var_0) {
  switch (var_0) {
    case "frag_grenade_zombies_mp":
    case "frag_grenade_throw_zombies_mp":
      return 1;
    default:
      break;
  }

  return 0;
}

weapon_type_check(var_0) {
  var_0 = getweaponbasename(var_0);

  if(is_favorite_weapon(var_0)) {
    return "favorite";
  } else if(is_bad_weapon(var_0)) {
    return "bad_weapon";
  } else if(has_custom_weapon_vo(var_0)) {
    return var_0;
  } else if(skip_weapon_vo(var_0)) {
    return "skip";
  } else {
    return "generic";
  }
}

zmplaydeathsound() {
  var_0 = randomintrange(0, 3);
  player_stop_speaking();
  playerstopexerting();
  playerexert("death" + var_0);
}

zmplaydamagesound(var_0) {
  if(isDefined(self.damage_sound_time) && self.damage_sound_time + 5000 > var_0) {
    return;
  }
  if(!maps\mp\zombies\_util::is_true(self.isexerting)) {
    self.damage_sound_time = var_0;
    var_1 = randomintrange(0, 3);
    player_stop_speaking();
    playerexert("pain" + var_1);
  }
}

playerexert(var_0) {
  if(maps\mp\zombies\_util::is_true(self.isspeaking) || maps\mp\zombies\_util::is_true(self.isexerting)) {
    return 0;
  }

  var_1 = create_and_play_dialog("exert", var_0);

  if(!maps\mp\zombies\_util::is_true(self.isexerting)) {
    thread exert_timer();
  }

  return var_1;
}

playerstopexerting() {
  self notify("stopExerting");
  self.isexerting = undefined;
}

exert_timer() {
  self endon("disconnect");
  self endon("stopExerting");
  wait 1;
  self.isexerting = 1;
  wait(randomfloatrange(1.5, 3));
  self.isexerting = undefined;
}

playerkillstreakcratevo(var_0) {
  self endon("disconnect");

  if(issubstr(var_0, "drop_pre")) {
    wait 2;
  } else {
    wait 0.5;
  }

  thread create_and_play_dialog("general", var_0);
}

playerpoweronvo() {
  thread create_and_play_dialog_delay("general", "power_on", undefined, undefined, undefined, 1);
}

playerpoweroffvo() {
  thread create_and_play_dialog_delay("general", "power_off", undefined, undefined, undefined, 1);
}

playerrevivevo(var_0) {
  self endon("disconnect");
  wait 1;
  var_1 = create_and_play_dialog("general", "bonus_line_not_over", undefined, undefined, undefined, var_0);

  if(!var_1) {
    create_and_play_dialog("general", "revive_up", undefined, undefined, undefined, var_0);
  }
}

playerlaststandvo() {
  self endon("disconnect");
  wait 1;
  var_0 = create_and_play_dialog("general", "bonus_line_over");

  if(!var_0) {
    create_and_play_dialog("general", "revive_down");
  }
}

playerexosuit(var_0) {
  self endon("death");
  self endon("disconnect");
  wait 0.5;
  thread create_and_play_dialog_delay("perk", var_0, undefined, undefined, undefined, 0.5);
}

playerexosuitrejected(var_0, var_1) {
  var_2 = var_0;

  if(var_0 != "exo_suit") {
    var_2 = "exo_upgrade";
  }

  var_2 = var_2 + "_" + var_1;
  thread _playerbuyrejected(var_2);
}

_playerbuyrejected(var_0) {
  if(!maps\mp\zombies\_util::is_true(self.force_wait_on_buy_line)) {
    self.force_wait_on_buy_line = 1;
    create_and_play_dialog("general", var_0);
    wait 10;
    self.force_wait_on_buy_line = undefined;
  }
}

playerweaponbuy(var_0) {
  thread _playerbuyrejected(var_0);
}

playerweaponupgrade(var_0, var_1) {
  if(var_1 == 20) {
    thread create_and_play_dialog_delay("perk", "weapon_upgrade_max", undefined, undefined, undefined, 1);
  } else if(!isDefined(self.weaponupgradevodebounce) || self.weaponupgradevodebounce < gettime()) {
    thread create_and_play_dialog_delay("perk", "weapon_upgrade", undefined, undefined, undefined, 1);
    self.weaponupgradevodebounce = gettime() + 20000;
  }
}

playerfoundprinter() {
  thread create_and_play_dialog("general", "found_printer");
}

moneyspend() {
  self playlocalsound("interact_purchase");
}

playertrashchute() {
  self endon("disconnect");
  var_0 = "slide_chute";

  if(maps\mp\zombies\_util::getzombieslevelnum() == 3) {
    wait 2;
    var_0 = "teleport_machine";
  }

  thread create_and_play_dialog_delay("monologue", var_0, undefined, undefined, undefined, 0.5);
}

plinko_clink(var_0, var_1) {
  var_0 playsoundonmovingent("plinko_clink_" + var_1);
}