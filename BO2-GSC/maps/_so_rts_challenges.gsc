/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_so_rts_challenges.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_scene;
#include maps\_music;
#include maps\_so_rts_support;

global_actor_killed_challenges_callback(e_inflictor, e_attacker, n_damage, str_means_of_death, str_weapon, v_dir, str_hit_loc, timeoffset) {
  if(e_attacker.classname == "worldspawn")
    e_attacker = self.attacker;

  if(isplayer(e_attacker)) {
    if(self.team == "axis") {
      level.rts.kill_stats.total_kills++;
      process_challenge_explosive_kills(str_means_of_death);
      process_challenge_kill_claws(str_means_of_death);
      process_challenge_headshots(str_hit_loc);
      process_challenge_melee_kills(str_means_of_death);
      process_challenge_stun_kills();
      process_challenge_asd_rundown(str_means_of_death);
      process_challenge_kills_as_claw();
      process_challenge_kills_as_chloe();
      process_challenge_explosive_car_kills(e_inflictor, e_attacker, n_damage, str_means_of_death);
      process_challenge_vtol_kills();
      process_challenge_quad_kills(undefined, n_damage);
      process_challenge_sentry_kills(str_weapon, str_means_of_death);
      process_challenge_kill_ied_planter();
    }
  }
}

process_challenge_explosive_kills(str_means_of_death) {
  if(isDefined(level.rts.kill_stats.explosive_kills) && level.rts.kill_stats.explosive_kills != -1) {
    explosive_mods = array("MOD_EXPLOSIVE_SPLASH", "MOD_EXPLOSIVE", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH");

    if(isinarray(explosive_mods, str_means_of_death)) {
      level.rts.kill_stats.explosive_kills++;

      println("challenge_explosive_kills_increment " + level.rts.kill_stats.explosive_kills);

      if(level.rts.kill_stats.explosive_kills >= level.rts.kill_stats.explosive_kills_total) {
        println("challenge_explosive_kills_increment " + " awarded");

        level.rts.kill_stats.explosive_kills = -1;
        level.rts.player notify("challenge_EXPLOSIVE_KILLS_increment");
      }
    }
  }
}

process_challenge_kill_claws(str_means_of_death) {
  if(isDefined(level.rts.kill_stats.claw_kills) && level.rts.kill_stats.claw_kills != -1) {
    if(self.isbigdog && level.player maps\_so_rts_support::get_player_rts_mode() == "human") {
      level.rts.kill_stats.claw_kills++;

      println("challenge_kill_claws_increment " + level.rts.kill_stats.claw_kills);

      if(level.rts.kill_stats.claw_kills >= level.rts.kill_stats.claw_kills_total) {
        println("challenge_kill_claws_increment " + " awarded");

        level.rts.kill_stats.claw_kills = -1;
        level.rts.player notify("challenge_KILL_CLAWS_increment");
      }
    }
  }
}

process_challenge_headshots(str_hit_loc) {
  if(isDefined(level.rts.kill_stats.headshot_kills) && level.rts.kill_stats.headshot_kills != -1) {
    headshot_tags = array("head", "helmet");

    if(isinarray(headshot_tags, str_hit_loc)) {
      level.rts.kill_stats.headshot_kills++;

      println("challenge_headshot_kills_increment " + level.rts.kill_stats.headshot_kills);

      if(level.rts.kill_stats.headshot_kills >= level.rts.kill_stats.headshot_kills_total) {
        println("challenge_headshot_kills_increment " + " awarded");

        level.rts.kill_stats.headshot_kills = -1;
        level.rts.player notify("challenge_HEADSHOTS_increment");
      }
    }
  }
}

process_challenge_melee_kills(str_means_of_death) {
  if(isDefined(level.rts.kill_stats.melee_kills) && level.rts.kill_stats.melee_kills != -1) {
    if(str_means_of_death == "MOD_MELEE") {
      level.rts.kill_stats.melee_kills++;

      println("challenge_melee_kills_increment " + level.rts.kill_stats.melee_kills);

      if(level.rts.kill_stats.melee_kills >= level.rts.kill_stats.melee_kills_total) {
        println("challenge_melee_kills_increment " + " awarded");

        level.rts.kill_stats.melee_kills = -1;
        level.rts.player notify("challenge_MELEE_KILLS_increment");
      }
    }
  }
}

process_challenge_stun_kills() {
  if(isDefined(level.rts.kill_stats.stun_kills) && level.rts.kill_stats.stun_kills != -1) {
    if(self common_scripts\utility::isstunned() || self common_scripts\utility::isflashed()) {
      level.rts.kill_stats.stun_kills++;

      println("challenge_stun_kills_increment " + level.rts.kill_stats.stun_kills);

      if(level.rts.kill_stats.stun_kills >= level.rts.kill_stats.stun_kills_total) {
        println("challenge_stun_kills_increment " + " awarded");

        level.rts.kill_stats.stun_kills = -1;
        level.rts.player notify("challenge_STUN_KILLS_increment");
      }
    }
  }
}

process_challenge_asd_rundown(str_means_of_death) {
  if(isDefined(level.rts.kill_stats.asd_rundown_kills) && level.rts.kill_stats.asd_rundown_kills != -1) {
    if(issubstr(level.player maps\_so_rts_support::get_player_rts_mode(), "metalstorm") && str_means_of_death == "MOD_CRUSH") {
      level.rts.kill_stats.asd_rundown_kills++;

      println("challenge_asd_rundown_kills_increment " + level.rts.kill_stats.asd_rundown_kills);

      if(level.rts.kill_stats.asd_rundown_kills >= level.rts.kill_stats.asd_rundown_kills_total) {
        println("challenge_asd_rundown_kills_increment " + " awarded");

        level.rts.kill_stats.asd_rundown_kills = -1;
        level.rts.player notify("challenge_ASD_RUNDOWN_increment");
      }
    }
  }
}

process_challenge_kills_as_claw() {
  if(isDefined(level.rts.kill_stats.kills_as_claw) && level.rts.kill_stats.kills_as_claw != -1) {
    if(issubstr(level.player maps\_so_rts_support::get_player_rts_mode(), "bigdog")) {
      level.rts.kill_stats.kills_as_claw++;

      println("challenge_claw_kills_increment " + level.rts.kill_stats.kills_as_claw);

      if(level.rts.kill_stats.kills_as_claw >= level.rts.kill_stats.kills_as_claw_total) {
        println("challenge_claw_kills_increment " + " awarded");

        level.rts.kill_stats.kills_as_claw = -1;
        level.rts.player notify("challenge_CLAW_KILLS_increment");
      }
    }
  }
}

process_challenge_kill_riders(rider, damage) {
  if(isDefined(level.rts.kill_stats.kill_riders) && level.rts.kill_stats.kill_riders != -1) {
    if(isDefined(rider.ridingvehicle) && rider.ridingvehicle.vehicletype == "horse" && rider.health - damage <= 0) {
      if(isDefined(rider.kill_riders_counted) && rider.kill_riders_counted) {
        return;
      }
      rider.kill_riders_counted = 1;
      level.rts.kill_stats.kill_riders++;

      println("challenge_kill_riders_increment " + level.rts.kill_stats.kill_riders);

      if(level.rts.kill_stats.kill_riders >= level.rts.kill_stats.kill_riders_total) {
        println("challenge_kill_riders_increment " + " awarded");

        level.rts.kill_stats.kill_riders = -1;
        level.rts.player notify("challenge_KILL_RIDERS_increment");
      }
    }
  }
}

process_challenge_kills_as_chloe() {
  if(isDefined(level.rts.kill_stats.chloe_kills) && level.rts.kill_stats.chloe_kills != -1) {
    if(isDefined(level.rts.player.ally) && isDefined(level.rts.player.ally) && level.rts.player.ally.ai_ref.ref == "ai_spawner_karma") {
      level.rts.kill_stats.chloe_kills++;

      println("challenge_chloe_kills_increment " + level.rts.kill_stats.chloe_kills);

      if(level.rts.kill_stats.chloe_kills >= level.rts.kill_stats.chloe_kills_total) {
        println("challenge_chloe_kills_increment " + " awarded");

        level.rts.kill_stats.chloe_kills = -1;
        level.rts.player notify("challenge_CHLOE_KILLS_increment");
      }
    }
  }
}

process_challenge_explosive_car_kills(e_inflictor, e_attacker, n_damage, str_means_of_death) {
  if(isDefined(level.rts.kill_stats.explosive_car_kills) && level.rts.kill_stats.explosive_car_kills != -1) {
    if(is_explosive_car_death(e_inflictor, e_attacker, n_damage, str_means_of_death)) {
      level.rts.kill_stats.explosive_car_kills++;

      println("challenge_explosive_car_kills_increment " + level.rts.kill_stats.explosive_car_kills);

      if(level.rts.kill_stats.explosive_car_kills >= level.rts.kill_stats.explosive_car_kills_total) {
        println("challenge_explosive_car_kills_increment " + " awarded");

        level.rts.kill_stats.explosive_car_kills = -1;
        level.rts.player notify("challenge_EXPLOSIVE_CAR_KILLS_increment");
      }
    }
  }
}

is_explosive_car_death(e_inflictor, e_attacker, n_damage, str_means_of_death) {
  if(isDefined(str_means_of_death) && str_means_of_death == "MOD_EXPLOSIVE") {
    if(isDefined(e_inflictor) && isDefined(e_inflictor.destructibledef)) {
      if(isDefined(e_inflictor.destructiblecar) && e_inflictor.destructiblecar)
        return true;
    }
  }

  return false;
}

process_challenge_vtol_kills() {
  if(isDefined(level.rts.kill_stats.vtol_kills) && level.rts.kill_stats.vtol_kills != -1) {
    if(issubstr(level.player maps\_so_rts_support::get_player_rts_mode(), "vtol")) {
      level.rts.kill_stats.vtol_kills++;

      println("challenge_vtol_kills_increment " + level.rts.kill_stats.vtol_kills);

      if(level.rts.kill_stats.vtol_kills >= level.rts.kill_stats.vtol_kills_total) {
        println("challenge_vtol_kills_increment " + " awarded");

        level.rts.kill_stats.vtol_kills = -1;
        level.rts.player notify("challenge_VTOL_KILLS_increment");
      }
    }
  }
}

process_challenge_quad_kills(rider, n_damage) {
  if(isDefined(level.rts.kill_stats.quad_kills) && level.rts.kill_stats.quad_kills != -1) {
    if(isDefined(rider) && (isDefined(rider.quad_kill_counted) && rider.quad_kill_counted))
      return;
    else if(isDefined(self.quad_kill_counted) && self.quad_kill_counted) {
      return;
    }
    if(isDefined(rider) && rider.health - n_damage > 0) {
      return;
    }
    if(issubstr(level.player maps\_so_rts_support::get_player_rts_mode(), "quad")) {
      if(isDefined(rider))
        rider.quad_kill_counted = 1;
      else
        self.quad_kill_counted = 1;

      level.rts.kill_stats.quad_kills++;

      println("challenge_quad_kills_increment " + level.rts.kill_stats.quad_kills);

      if(level.rts.kill_stats.quad_kills >= level.rts.kill_stats.quad_kills_total) {
        println("challenge_quad_kills_increment " + " awarded");

        level.rts.kill_stats.quad_kills = -1;
        level.rts.player notify("challenge_QUAD_KILLS_increment");
      }
    }
  }
}

process_challenge_sentry_kills(str_weapon, str_means_of_death) {
  if(isDefined(level.rts.kill_stats.sentry_kills) && level.rts.kill_stats.sentry_kills != -1) {
    rts_mode = level.player maps\_so_rts_support::get_player_rts_mode();
    was_turret_kill = 0;

    if(str_weapon == "auto_gun_turret_sp_minigun_rts")
      was_turret_kill = 1;
    else if(rts_mode == "sentry_turret_friendly")
      was_turret_kill = 1;
    else if(rts_mode == "human" && level.rts.player.usingvehicle && str_means_of_death == "MOD_UNKNOWN")
      was_turret_kill = 1;

    if(was_turret_kill) {
      level.rts.kill_stats.sentry_kills++;

      println("challenge_sentry_kills_increment " + level.rts.kill_stats.sentry_kills);

      if(level.rts.kill_stats.sentry_kills >= level.rts.kill_stats.sentry_kills_total) {
        println("challenge_sentry_kills_increment " + " awarded");

        level.rts.kill_stats.sentry_kills = -1;
        level.rts.player notify("challenge_SENTRY_KILLS_increment");
      }
    }
  }
}

process_challenge_kill_ied_planter() {
  if(isDefined(level.rts.kill_stats.kill_ied) && level.rts.kill_stats.kill_ied != -1) {
    if(self ent_flag_exist("planting_ied") && self ent_flag("planting_ied")) {
      level.rts.kill_stats.kill_ied++;

      println("challenge_kill_ied_increment " + level.rts.kill_stats.kill_ied);

      if(level.rts.kill_stats.kill_ied >= level.rts.kill_stats.kill_ied_total) {
        println("challenge_kill_ied_increment " + " awarded");

        level.rts.kill_stats.kill_ied = -1;
        level.rts.player notify("challenge_KILL_IED_increment");
      }
    }
  }
}