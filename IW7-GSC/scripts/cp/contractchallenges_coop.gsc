/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\contractchallenges_coop.gsc
**************************************************/

registercontractchallenges() {
  level.contractchallenges = [];
  registercontractchallenge("con_test", ::contracttestchallenge);
  registercontractchallenge("con_kills", ::contractkills);
  registercontractchallenge("con_kills_AR", ::contractkills);
  registercontractchallenge("con_kills_LMG", ::contractkills);
  registercontractchallenge("con_kills_SG", ::contractkills);
  registercontractchallenge("con_kills_Sniper", ::contractkills);
  registercontractchallenge("con_kills_SMG", ::contractkills);
  registercontractchallenge("con_kills_Pistol", ::contractkills);
  registercontractchallenge("con_kills_explosive", ::contractkills);
  registercontractchallenge("con_kills_head_zmb", ::contractkills);
  registercontractchallenge("con_kills_head_rave", ::contractkills);
  registercontractchallenge("con_kills_head_disco", ::contractkills);
  registercontractchallenge("con_kills_head_town", ::contractkills);
  registercontractchallenge("con_cash_earned_zmb", ::contractmoneyearned);
  registercontractchallenge("con_cash_earned_rave", ::contractmoneyearned);
  registercontractchallenge("con_cash_earned_disco", ::contractmoneyearned);
  registercontractchallenge("con_cash_earned_town", ::contractmoneyearned);
  registercontractchallenge("con_kills_golf_rave", ::contractkills);
  registercontractchallenge("con_kills_bat_rave", ::contractkills);
  registercontractchallenge("con_kills_machete_rave", ::contractkills);
  registercontractchallenge("con_kills_axe_rave", ::contractkills);
  registercontractchallenge("con_kills_axe_zmb", ::contractkills);
  registercontractchallenge("con_kills_cleaver_town", ::contractkills);
  registercontractchallenge("con_kills_crowbar_town", ::contractkills);
  registercontractchallenge("con_doors", ::contractdoors);
  registercontractchallenge("con_kills_dragon_disco", ::contractkills);
  registercontractchallenge("con_kills_tiger_disco", ::contractkills);
  registercontractchallenge("con_kills_snake_disco", ::contractkills);
  registercontractchallenge("con_kills_crane_disco", ::contractkills);
  registercontractchallenge("con_consumables_used", ::contractconsumables);
  registercontractchallenge("con_reboard_windows", ::contractreboard);
  registercontractchallenge("con_kills_clowns_zmb", ::contractkills);
  registercontractchallenge("con_kills_sasquatch_rave", ::contractkills);
  registercontractchallenge("con_kills_skaters_disco", ::contractkills);
  registercontractchallenge("con_kills_crogs_town", ::contractkills);
  registercontractchallenge("con_waves", ::contractnewwave);
  registercontractchallenge("con_trap_kills_zmb", ::contractkills);
  registercontractchallenge("con_trap_kills_rave", ::contractkills);
  registercontractchallenge("con_trap_kills_disco", ::contractkills);
  registercontractchallenge("con_trap_kills_town", ::contractkills);
  registercontractchallenge("con_magic_wheel_uses", ::contractmagicwheel);
  registercontractchallenge("con_hoff_spawn", ::contracthoffspawn);
  registercontractchallenge("con_elvira_spawn", ::contractelviraspawned);
  registercontractchallenge("con_cash_spent_zmb", ::contractmoneyspent);
  registercontractchallenge("con_cash_spent_rave", ::contractmoneyspent);
  registercontractchallenge("con_cash_spent_disco", ::contractmoneyspent);
  registercontractchallenge("con_cash_spent_town", ::contractmoneyspent);
  registercontractchallenge("con_challenge_badge_rave", ::contractchallengebadges);
  registercontractchallenge("con_crafted_kills_town", ::contractkills);
  registercontractchallenge("con_coaster_targets_zmb", ::contractcoastertargets);
  registercontractchallenge("con_shooting_gallery_zmb", ::contractshootinggallery);
  registercontractchallenge("con_spend_tickets", ::contractspendtickets);
  registercontractchallenge("con_kills_head_final", ::contractkills);
  registercontractchallenge("con_trap_kills_final", ::contractkills);
  registercontractchallenge("con_entangler_kills_final", ::contractkills);
  registercontractchallenge("con_venomx_kills_final", ::contractkills);
  registercontractchallenge("con_goon_kills_final", ::contractkills);
  registercontractchallenge("con_phantom_kills_final", ::contractkills);
  registercontractchallenge("con_special_kills_final", ::contractkills);
  registercontractchallenge("con_cash_earned_final", ::contractmoneyearned);
  registercontractchallenge("con_cash_spent_final", ::contractmoneyspent);
}

registercontractchallenge(var_0, var_1) {
  level.contractchallenges[var_0] = var_1;
}

contractempty(var_0) {}

contracttestchallenge(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    wait(1);
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractkills(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    var_10 = 0;
    var_11 = scripts\cp\utility::getweaponclass(var_5);
    var_12 = getdvar("ui_mapname");
    var_13 = scripts\engine\utility::isbulletdamage(var_4);
    var_14 = isDefined(var_5) && var_5 == "iw7_dischorddummy_zm" || var_5 == "iw7_facemelterdummy_zm" || var_5 == "iw7_headcutterdummy_zm" || var_5 == "iw7_shredderdummy_zm";
    var_15 = issubstr(var_5, "venomx");
    var_10 = issubstr(var_5, "longshot");
    var_11 = issubstr(var_5, "m8");
    var_12 = var_13 && scripts\cp\utility::isheadshot(var_5, var_7, var_4, var_2) && !var_15;
    if(isDefined(var_1.owner)) {
      var_13 = var_2 scripts\cp\utility::is_trap(var_1, var_5) && var_1.owner == var_2;
    } else {
      var_13 = var_2 scripts\cp\utility::is_trap(var_1, var_5);
    }

    var_14 = isexplosivedamagemod(var_4);
    if(var_14) {
      if(issubstr(var_5, "shuriken")) {
        var_14 = 0;
      } else if(scripts\engine\utility::istrue(var_2.kung_fu_mode)) {
        var_14 = 0;
      }
    }

    switch (var_0.ref) {
      case "con_kills":
        var_10 = 1;
        break;

      case "con_kills_head_zmb":
        if(scripts\engine\utility::istrue(var_12) && var_12 == "cp_zmb") {
          var_10 = 1;
        }
        break;

      case "con_kills_head_rave":
        if(scripts\engine\utility::istrue(var_12) && var_12 == "cp_rave") {
          var_10 = 1;
        }
        break;

      case "con_kills_head_disco":
        if(scripts\engine\utility::istrue(var_12) && var_12 == "cp_disco") {
          var_10 = 1;
        }
        break;

      case "con_kills_head_town":
        if(scripts\engine\utility::istrue(var_12) && var_12 == "cp_town") {
          var_10 = 1;
        }
        break;

      case "con_kills_head_final":
        if(scripts\engine\utility::istrue(var_12) && var_12 == "cp_final") {
          var_10 = 1;
        }
        break;

      case "con_kills_AR":
        if(var_4 != "MOD_MELEE" && var_11 == "weapon_assault") {
          var_10 = 1;
        } else if(var_4 != "MOD_MELEE" && var_11 == "weapon_sniper" && var_11 && !scripts\cp\agents\gametype_zombie::checkaltmodestatus(var_5)) {
          var_10 = 1;
        }
        break;

      case "con_kills_LMG":
        if(var_4 != "MOD_MELEE" && var_11 == "weapon_lmg") {
          var_10 = 1;
        }
        break;

      case "con_kills_SG":
        if(var_4 != "MOD_MELEE" && var_11 == "weapon_shotgun" && !var_10) {
          var_10 = 1;
        } else if(var_4 != "MOD_MELEE" && var_11 == "weapon_sniper" && var_10 && !scripts\cp\agents\gametype_zombie::checkaltmodestatus(var_5)) {
          var_10 = 1;
        }
        break;

      case "con_kills_Sniper":
        if(var_4 != "MOD_MELEE" && var_11 == "weapon_sniper" && !var_10 && !var_11) {
          var_10 = 1;
        } else if(var_4 != "MOD_MELEE" && var_11 == "weapon_sniper" && var_10 && scripts\cp\agents\gametype_zombie::checkaltmodestatus(var_5)) {
          var_10 = 1;
        } else if(var_4 != "MOD_MELEE" && var_11 == "weapon_sniper" && var_11 && scripts\cp\agents\gametype_zombie::checkaltmodestatus(var_5)) {
          var_10 = 1;
        }
        break;

      case "con_kills_SMG":
        if(var_4 != "MOD_MELEE" && var_11 == "weapon_smg") {
          var_10 = 1;
        }
        break;

      case "con_kills_Pistol":
        if(var_4 != "MOD_MELEE" && var_11 == "weapon_pistol") {
          var_10 = 1;
        } else if(var_14) {
          var_10 = 1;
        }
        break;

      case "con_kills_explosive":
        var_10 = var_14;
        break;

      case "con_kills_golf_rave":
        if(var_12 == "cp_rave") {
          if(var_5 == "iw7_golf_club_mp" || var_5 == "iw7_golf_club_mp_pap1" || var_5 == "iw7_golf_club_mp_pap2") {
            var_10 = 1;
          }
        }
        break;

      case "con_kills_bat_rave":
        if(var_12 == "cp_rave") {
          if(var_5 == "iw7_spiked_bat_mp" || var_5 == "iw7_spiked_bat_mp_pap1" || var_5 == "iw7_spiked_bat_mp_pap2") {
            var_10 = 1;
          }
        }
        break;

      case "con_kills_axe_rave":
        if(var_12 == "cp_rave") {
          if(var_5 == "iw7_two_headed_axe_mp" || var_5 == "iw7_two_headed_axe_mp_pap1" || var_5 == "iw7_two_headed_axe_mp_pap2") {
            var_10 = 1;
          }
        }
        break;

      case "con_kills_machete_rave":
        if(var_12 == "cp_rave") {
          if(var_5 == "iw7_machete_mp" || var_5 == "iw7_machete_mp_pap1" || var_5 == "iw7_machete_mp_pap2") {
            var_10 = 1;
          }
        }
        break;

      case "con_kills_cleaver_town":
        if(var_12 == "cp_town") {
          if(var_5 == "iw7_knife_zm_cleaver") {
            var_10 = 1;
          }
        }
        break;

      case "con_kills_crowbar_town":
        if(var_12 == "cp_town") {
          if(var_5 == "iw7_knife_zm_crowbar") {
            var_10 = 1;
          }
        }
        break;

      case "con_kills_axe_zmb":
        if(var_12 == "cp_zmb") {
          if(var_5 == "iw7_axe_zm" || getweaponbasename(var_5) == "iw7_axe_zm_pap1" || getweaponbasename(var_5) == "iw7_axe_zm_pap2") {
            var_10 = 1;
          }
        }
        break;

      case "con_entangler_kills_final":
        if(var_12 == "cp_final") {
          if(isDefined(var_5) && var_5 == "iw7_entangler2_zm" || var_5 == "ghost_grenade_launcher") {
            var_10 = 1;
          }
        }
        break;

      case "con_venomx_kills_final":
        if(var_12 == "cp_final") {
          if(var_15) {
            var_10 = 1;
          }
        }
        break;

      case "con_kills_dragon_disco":
        if(var_12 == "cp_disco") {
          if(scripts\engine\utility::istrue(var_2.kung_fu_mode) && !scripts\cp\cp_merits::is_crafted_trap_damage(var_5)) {
            if(var_2.kungfu_style == "dragon") {
              var_10 = 1;
            }
          }
        }
        break;

      case "con_kills_tiger_disco":
        if(var_12 == "cp_disco") {
          if(scripts\engine\utility::istrue(var_2.kung_fu_mode) && !scripts\cp\cp_merits::is_crafted_trap_damage(var_5)) {
            if(var_2.kungfu_style == "tiger") {
              var_10 = 1;
            }
          }
        }
        break;

      case "con_kills_snake_disco":
        if(var_12 == "cp_disco") {
          if(scripts\engine\utility::istrue(var_2.kung_fu_mode) && !scripts\cp\cp_merits::is_crafted_trap_damage(var_5)) {
            if(var_2.kungfu_style == "snake") {
              var_10 = 1;
            }
          }
        }
        break;

      case "con_kills_crane_disco":
        if(var_12 == "cp_disco") {
          if(scripts\engine\utility::istrue(var_2.kung_fu_mode) && !scripts\cp\cp_merits::is_crafted_trap_damage(var_5)) {
            if(var_2.kungfu_style == "crane") {
              var_10 = 1;
            }
          }
        }
        break;

      case "con_kills_clowns_zmb":
        if(var_12 == "cp_zmb") {
          if(isDefined(var_9) && var_9 == "zombie_clown") {
            var_10 = 1;
          }
        }
        break;

      case "con_kills_sasquatch_rave":
        if(var_12 == "cp_rave") {
          if(isDefined(var_9) && var_9 == "zombie_sasquatch") {
            var_10 = 1;
          }
        }
        break;

      case "con_kills_skaters_disco":
        if(var_12 == "cp_disco") {
          if(isDefined(var_9) && var_9 == "skater") {
            var_10 = 1;
          }
        }
        break;

      case "con_kills_crogs_town":
        if(var_12 == "cp_town") {
          if(isDefined(var_9) && var_9 == "crab_mini") {
            var_10 = 1;
          }
        }
        break;

      case "con_special_kills_final":
        if(var_12 == "cp_final") {
          if(isDefined(var_9) && var_9 == "karatemaster" || var_9 == "zombie_clown" || var_9 == "slasher") {
            var_10 = 1;
          }
        }
        break;

      case "con_goon_kills_final":
        if(var_12 == "cp_final") {
          if(isDefined(var_9) && var_9 == "alien_goon") {
            var_10 = 1;
          }
        }
        break;

      case "con_phantom_kills_final":
        if(var_12 == "cp_final") {
          if(isDefined(var_9) && var_9 == "alien_phantom") {
            var_10 = 1;
          }
        }
        break;

      case "con_trap_kills_zmb":
        if(var_12 == "cp_zmb") {
          if(scripts\engine\utility::istrue(var_13)) {
            var_10 = 1;
          }
        }
        break;

      case "con_trap_kills_rave":
        if(var_12 == "cp_rave") {
          if(scripts\engine\utility::istrue(var_13)) {
            var_10 = 1;
          }
        }
        break;

      case "con_trap_kills_disco":
        if(var_12 == "cp_disco") {
          if(scripts\engine\utility::istrue(var_13)) {
            var_10 = 1;
          }
        }
        break;

      case "con_trap_kills_town":
        if(var_12 == "cp_town") {
          if(var_5 == "iw7_electrictrap_zm") {
            var_10 = 1;
          }
        }
        break;

      case "con_trap_kills_final":
        if(var_12 == "cp_final") {
          if(scripts\engine\utility::istrue(var_13)) {
            var_10 = 1;
          }
        }
        break;

      case "con_crafted_kills_town":
        if(var_12 == "cp_town") {
          if(isDefined(var_2.var_20) && var_2.var_20 == "allies") {
            var_10 = 1;
          }

          if(var_5 == "iw7_fantrap_zm") {
            var_10 = 1;
          }
        }
        break;
    }

    if(var_10) {
      scripts\cp\contracts_coop::updatecontractprogress(var_0);
    }
  }
}

contractmoneyearned(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("currency_earned_buffered", var_1);
    var_2 = getdvar("ui_mapname");
    var_3 = 0;
    switch (var_0.ref) {
      case "con_cash_earned_zmb":
        if(var_2 == "cp_zmb") {
          var_3 = 1;
        }
        break;

      case "con_cash_earned_rave":
        if(var_2 == "cp_rave") {
          var_3 = 1;
        }
        break;

      case "con_cash_earned_disco":
        if(var_2 == "cp_disco") {
          var_3 = 1;
        }
        break;

      case "con_cash_earned_town":
        if(var_2 == "cp_town") {
          var_3 = 1;
        }
        break;

      case "con_cash_earned_final":
        if(var_2 == "cp_final") {
          var_3 = 1;
        }
        break;
    }

    if(var_3) {
      scripts\cp\contracts_coop::updatecontractprogress(var_0, var_1);
    }
  }
}

contractdoors(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("door_opened_notify");
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractconsumables(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("consumable_selected");
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractreboard(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("window_reboard_notify");
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractnewwave(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("next_wave_notify");
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractmagicwheel(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("magic_wheel_used");
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contracthoffspawn(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("hoff_spawned");
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractelviraspawned(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("elvira_summoned_notify");
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractmoneyspent(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("currency_spent_buffered", var_1);
    var_2 = getdvar("ui_mapname");
    var_3 = 0;
    switch (var_0.ref) {
      case "con_cash_spent_zmb":
        if(var_2 == "cp_zmb") {
          var_3 = 1;
        }
        break;

      case "con_cash_spent_rave":
        if(var_2 == "cp_rave") {
          var_3 = 1;
        }
        break;

      case "con_cash_spent_disco":
        if(var_2 == "cp_disco") {
          var_3 = 1;
        }
        break;

      case "con_cash_spent_town":
        if(var_2 == "cp_town") {
          var_3 = 1;
        }
        break;

      case "con_cash_spent_final":
        if(var_2 == "cp_final") {
          var_3 = 1;
        }
        break;
    }

    if(var_3) {
      scripts\cp\contracts_coop::updatecontractprogress(var_0, var_1);
    }
  }
}

contractchallengebadges(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("rave_challenge_badge_notify");
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractcraftedkills(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("crafted_kill_town_notify");
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractcoastertargets(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("coaster_target_hit_notify");
    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractshootinggallery(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("moving_target_hit_notify");
    if(scripts\engine\utility::istrue(self.in_afterlife_arcade)) {
      continue;
    }

    scripts\cp\contracts_coop::updatecontractprogress(var_0);
  }
}

contractspendtickets(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("spent_tickets_notify", var_1);
    scripts\cp\contracts_coop::updatecontractprogress(var_0, var_1);
  }
}

contractkillsrapid(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("update_rapid_kill_buffered", var_1);
    var_2 = 0;
    switch (var_0.ref) {
      case "con_kills_double":
        if(var_1 % 2 == 0) {
          var_2 = 1;
        }
        break;
    }

    if(var_2) {
      scripts\cp\contracts_coop::updatecontractprogress(var_0);
    }
  }
}

contractnotifylistener(var_0, var_1) {
  self waittill(var_0, var_2);
  self notify(var_1, var_2);
}