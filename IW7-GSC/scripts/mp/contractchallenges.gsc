/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\contractchallenges.gsc
*********************************************/

registercontractchallenges() {
  level.contractchallenges = [];
  registercontractchallenge("con_test", ::contracttestchallenge);
  registercontractchallenge("con_kills", ::contractkills);
  registercontractchallenge("con_kills_ads", ::contractkills);
  registercontractchallenge("con_kills_modified", ::contractkills);
  registercontractchallenge("con_kills_headshot", ::contractkills);
  registercontractchallenge("con_kills_AR", ::contractkills);
  registercontractchallenge("con_kills_LMG", ::contractkills);
  registercontractchallenge("con_kills_SG", ::contractkills);
  registercontractchallenge("con_kills_Sniper", ::contractkills);
  registercontractchallenge("con_kills_SMG", ::contractkills);
  registercontractchallenge("con_kills_rig_jtf", ::contractkills);
  registercontractchallenge("con_kills_rig_orion", ::contractkills);
  registercontractchallenge("con_kills_rig_sabre7", ::contractkills);
  registercontractchallenge("con_kills_rig_wraith", ::contractkills);
  registercontractchallenge("con_kills_rig_bloodanvil", ::contractkills);
  registercontractchallenge("con_battle_buddy", ::contractkills);
  registercontractchallenge("con_kills_variant", ::contractkills);
  registercontractchallenge("con_kills_oneshot", ::contractkills);
  registercontractchallenge("con_kills_double", ::contractkillsrapid);
  registercontractchallenge("con_kills_payload", ::contractkillspayload);
  registercontractchallenge("con_kills_rig_jtf_payload", ::contractkillspayload);
  registercontractchallenge("con_kills_rig_orion_payload", ::contractkillspayload);
  registercontractchallenge("con_kills_rig_sabre7_payload", ::contractkillspayload);
  registercontractchallenge("con_kills_rig_wraith_payload", ::contractkillspayload);
  registercontractchallenge("con_kills_rig_bloodanvil_payload", ::contractkillspayload);
  registercontractchallenge("con_kills_gesture", ::contractkillsgesture);
  registercontractchallenge("con_scorestreak_support", ::contractscorestreaksupport);
  registercontractchallenge("con_scorestreak_air", ::contractscorestreakair);
  registercontractchallenge("con_scorestreak_ground", ::contractscorestreakground);
  registercontractchallenge("con_scorestreak_destroy", ::contractscorestreakdestroy);
  registercontractchallenge("con_scorestreak_count", ::contractscorestreakcount);
  registercontractchallenge("con_medals_objective", ::contractmedalsobjective);
  registercontractchallenge("con_wins", ::contractempty);
  registercontractchallenge("con_wins_top3", ::contractempty);
  registercontractchallenge("con_kdr", ::contractempty);
  registercontractchallenge("con_wins_objective", ::contractempty);
  registercontractchallenge("con_wins_slayer", ::contractempty);
  registercontractchallenge("con_wins_hardcore", ::contractempty);
  registercontractchallenge("con_damage", ::contractempty);
  registercontractchallenge("con_shots_landed", ::contractempty);
  registercontractchallenge("con_equipment_hits", ::contractempty);
  registercontractchallenge("con_kills_streak", ::contractempty);
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
    scripts\mp\contracts::updatecontractprogress(var_0);
  }
}

contractkillsimmediate(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self.contracts)) {
    return;
  }

  foreach(var_6 in self.contracts) {
    var_7 = 0;
    switch (var_6.ref) {
      case "con_kills_streak":
        var_8 = self.pers["cur_kill_streak"];
        if(isDefined(var_8)) {
          if(var_8 % 5 == 0) {
            var_7 = 1;
          }
        }
        break;

      case "con_kills_gesture":
        if(isDefined(self.var_A960)) {
          var_9 = gettime();
          if(abs(self.var_A960 - var_9) < 3000) {
            var_0A = var_0 getentitynumber();
            thread stampkillgesture(var_0A);
            var_7 = 1;
          }
        }
        break;
    }

    if(var_7) {
      scripts\mp\contracts::updatecontractprogress(var_6);
    }
  }
}

contractkills(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  if(var_0.ref == "con_battle_buddy") {
    thread contractassists(var_0);
  }

  for(;;) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);
    var_5 = 0;
    switch (var_0.ref) {
      case "con_kills":
        var_5 = 1;
        break;

      case "con_kills_ads":
        if(scripts\mp\utility::istrue(var_4["ads"])) {
          var_5 = 1;
        }
        break;

      case "con_kills_modified":
        if(scripts\mp\utility::istrue(var_4["sliding"]) || scripts\mp\utility::istrue(var_4["hipfire"]) || scripts\mp\utility::istrue(var_4["airborne"]) || scripts\mp\utility::istrue(var_4["wallkill"])) {
          var_5 = 1;
        }
        break;

      case "con_kills_headshot":
        if(scripts\mp\utility::istrue(var_4["headshot"])) {
          var_5 = 1;
        }
        break;

      case "con_kills_AR":
        var_2 = scripts\mp\utility::func_13CA1(var_2);
        if(var_3 != "MOD_MELEE" && !scripts\mp\utility::iskillstreakweapon(var_2) && scripts\mp\utility::getweapongroup(var_2) == "weapon_assault") {
          var_5 = 1;
        }
        break;

      case "con_kills_LMG":
        var_2 = scripts\mp\utility::func_13CA1(var_2);
        if(var_3 != "MOD_MELEE" && !scripts\mp\utility::iskillstreakweapon(var_2) && scripts\mp\utility::getweapongroup(var_2) == "weapon_lmg") {
          var_5 = 1;
        }
        break;

      case "con_kills_SG":
        var_2 = scripts\mp\utility::func_13CA1(var_2);
        if(var_3 != "MOD_MELEE" && !scripts\mp\utility::iskillstreakweapon(var_2) && scripts\mp\utility::getweapongroup(var_2) == "weapon_shotgun") {
          var_5 = 1;
        }

        if(self _meth_8519(var_2)) {
          var_6 = scripts\mp\utility::getweaponrootname(var_2);
          var_7 = getweaponvariantindex(var_2);
          if(var_6 == "iw7_longshot") {
            var_5 = 1;
          }

          if(var_6 == "iw7_erad" && isDefined(var_7) && var_7 == 3 || var_7 == 35) {
            var_5 = 1;
          }
        }
        break;

      case "con_kills_Sniper":
        var_2 = scripts\mp\utility::func_13CA1(var_2);
        if(var_3 != "MOD_MELEE" && !scripts\mp\utility::iskillstreakweapon(var_2) && scripts\mp\utility::getweapongroup(var_2) == "weapon_sniper") {
          var_5 = 1;
        }
        break;

      case "con_kills_SMG":
        var_2 = scripts\mp\utility::func_13CA1(var_2);
        if(var_3 != "MOD_MELEE" && !scripts\mp\utility::iskillstreakweapon(var_2) && scripts\mp\utility::getweapongroup(var_2) == "weapon_smg") {
          var_5 = 1;
        }
        break;

      case "con_battle_buddy":
        if(scripts\mp\utility::istrue(var_4["buddy_kill"])) {
          var_5 = 1;
        }
        break;

      case "con_kills_rig_jtf":
        var_8 = ["archetype_assault", "archetype_heavy", "archetype_scout"];
        var_5 = archtypecheck(var_8);
        break;

      case "con_kills_rig_orion":
        var_8 = ["archetype_assault", "archetype_heavy", "archetype_engineer"];
        var_5 = archtypecheck(var_8);
        break;

      case "con_kills_rig_sabre7":
        var_8 = ["archetype_engineer", "archetype_assassin"];
        var_5 = archtypecheck(var_8);
        break;

      case "con_kills_rig_wraith":
        var_8 = ["archetype_sniper", "archetype_scout"];
        var_5 = archtypecheck(var_8);
        break;

      case "con_kills_rig_bloodanvil":
        var_8 = ["archetype_heavy", "archetype_assassin"];
        var_5 = archtypecheck(var_8);
        break;

      case "con_kills_variant":
        var_5 = isDefined(getweaponvariantindex(var_2));
        break;

      case "con_kills_oneshot":
        if(scripts\mp\utility::istrue(var_4["oneshotkill"]) || scripts\mp\utility::istrue(var_4["oneshotkill_shotgun"])) {
          var_5 = 1;
        }
        break;
    }

    if(var_5) {
      scripts\mp\contracts::updatecontractprogress(var_0);
    }
  }
}

contractassists(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("assist_buffered", var_1);
    var_2 = 0;
    switch (var_0.ref) {
      case "con_battle_buddy":
        if(isDefined(var_1) && scripts\mp\utility::istrue(var_1["buddy_kill"])) {
          var_2 = 1;
        }
        break;
    }

    if(var_2) {
      scripts\mp\contracts::updatecontractprogress(var_0);
    }
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
      scripts\mp\contracts::updatecontractprogress(var_0);
    }
  }
}

contractkillspayload(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("super_kill_buffered");
    var_1 = 0;
    switch (var_0.ref) {
      case "con_kills_payload":
        var_1 = 1;
        break;

      case "con_kills_rig_jtf_payload":
        var_2 = ["archetype_assault", "archetype_heavy", "archetype_scout"];
        var_1 = archtypecheck(var_2);
        break;

      case "con_kills_rig_orion_payload":
        var_2 = ["archetype_assault", "archetype_heavy", "archetype_engineer"];
        var_1 = archtypecheck(var_2);
        break;

      case "con_kills_rig_sabre7_payload":
        var_2 = ["archetype_engineer", "archetype_assassin"];
        var_1 = archtypecheck(var_2);
        break;

      case "con_kills_rig_wraith_payload":
        var_2 = ["archetype_sniper", "archetype_scout"];
        var_1 = archtypecheck(var_2);
        break;

      case "con_kills_rig_bloodanvil_payload":
        var_2 = ["archetype_heavy", "archetype_assassin"];
        var_1 = archtypecheck(var_2);
        break;
    }

    if(var_1) {
      scripts\mp\contracts::updatecontractprogress(var_0);
    }
  }
}

archtypecheck(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\mp\utility::func_9D48(var_2)) {
      return 1;
    }
  }

  return 0;
}

contractscorestreaksupport(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("killstreak_used", var_1);
    var_2 = 0;
    switch (var_1) {
      case "dronedrop":
      case "directional_uav":
      case "counter_uav":
      case "uav":
        var_2 = 1;
        break;
    }

    if(var_2) {
      scripts\mp\contracts::updatecontractprogress(var_0);
    }
  }
}

contractscorestreakair(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("kill_event_buffered", var_1, var_2);
    var_3 = 0;
    if(scripts\mp\utility::iskillstreakweapon(var_2)) {
      var_4 = scripts\mp\missions::func_7F48(var_2);
      switch (var_4) {
        case "jackal":
        case "bombardment":
        case "precision_airstrike":
        case "thor":
        case "minijackal":
        case "drone_hive":
          var_3 = 1;
          break;
      }

      if(var_3) {
        scripts\mp\contracts::updatecontractprogress(var_0);
      }
    }
  }
}

contractscorestreakground(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("kill_event_buffered", var_1, var_2);
    var_3 = 0;
    if(scripts\mp\utility::iskillstreakweapon(var_2)) {
      var_4 = scripts\mp\missions::func_7F48(var_2);
      switch (var_4) {
        case "ball_drone_backup":
        case "remote_c8":
        case "venom":
        case "sentry_shock":
          var_3 = 1;
          break;
      }

      if(var_3) {
        scripts\mp\contracts::updatecontractprogress(var_0);
      }
    }
  }
}

contractscorestreakdestroy(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("earned_award_buffered", var_1);
    if(issubstr(var_1, "kill_ss_")) {
      scripts\mp\contracts::updatecontractprogress(var_0);
    }
  }
}

contractscorestreakcount(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    self waittill("killstreak_used", var_1);
    if(!isDefined(self.pers["con_scorestreak_count"])) {
      self.pers["con_scorestreak_count"] = 1;
    } else {
      self.pers["con_scorestreak_count"]++;
    }

    if(self.pers["con_scorestreak_count"] % 2 == 0) {
      scripts\mp\contracts::updatecontractprogress(var_0);
    }
  }
}

contractmatchend(var_0) {
  if(!isDefined(self.contracts)) {
    return;
  }

  foreach(var_2 in self.contracts) {
    var_3 = 0;
    switch (var_2.ref) {
      case "con_wins":
        if(var_0.var_13D8A) {
          var_3 = 1;
        }
        break;

      case "con_wins_top3":
        if(var_0.var_13D8A && var_0.var_CBFC < 3) {
          var_3 = 1;
        }
        break;

      case "con_kdr":
        if(self.pers["kdratio"] >= 2) {
          var_3 = 1;
        }
        break;

      case "con_wins_objective":
        if(var_0.var_13D8A) {
          switch (level.gametype) {
            case "tdef":
            case "koth":
            case "grind":
            case "dom":
            case "conf":
            case "dd":
            case "ball":
            case "ctf":
            case "siege":
            case "sd":
            case "sr":
              var_3 = 1;
              break;
          }
        }
        break;

      case "con_wins_slayer":
        if(var_0.var_13D8A) {
          switch (level.gametype) {
            case "conf":
            case "front":
            case "dm":
            case "war":
              var_3 = 1;
              break;
          }
        }
        break;

      case "con_wins_hardcore":
        if(var_0.var_13D8A && level.hardcoremode) {
          var_3 = 1;
        }
        break;
    }

    if(var_3) {
      scripts\mp\contracts::updatecontractprogress(var_2);
    }
  }
}

contractmedalsobjective(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  for(;;) {
    thread contractnotifylistener("earned_award_buffered", "update_objective_medal");
    thread contractnotifylistener("bomb_planted", "update_objective_medal");
    self waittill("update_objective_medal", var_1);
    if(isDefined(var_1)) {
      if(var_1 == "mode_x_assault" || var_1 == "mode_sd_defuse_save" || var_1 == "mode_uplink_kill_with_ball" || var_1 == "mode_ctf_kill_with_flag" || var_1 == "mode_x_defend" || var_1 == "mode_sd_plant_save" || var_1 == "mode_uplink_kill_carrier" || var_1 == "mode_ctf_kill_carrier" || var_1 == "mode_dom_secure_b" || var_1 == "mode_dom_secure_neutral" || var_1 == "mode_dom_secure" || var_1 == "mode_hp_secure" || var_1 == "mode_sd_last_defuse" || var_1 == "mode_sd_defuse" || var_1 == "mode_uplink_dunk" || var_1 == "mode_uplink_fieldgoal" || var_1 == "mode_ctf_cap" || var_1 == "mode_siege_secure") {
        scripts\mp\contracts::updatecontractprogress(var_0);
      }

      continue;
    }

    scripts\mp\contracts::updatecontractprogress(var_0);
  }
}

contractnotifylistener(var_0, var_1) {
  self waittill(var_0, var_2);
  self notify(var_1, var_2);
}

contractplayerdamaged(var_0) {
  if(!isDefined(self.contracts)) {
    return;
  }

  foreach(var_2 in self.contracts) {
    if(var_2.ref == "con_damage") {
      scripts\mp\contracts::updatecontractprogress(var_2, var_0);
    }
  }
}

contractshotslanded(var_0) {
  if(!isDefined(self.contracts)) {
    return;
  }

  foreach(var_2 in self.contracts) {
    if(var_2.ref == "con_shots_landed") {
      scripts\mp\contracts::updatecontractprogress(var_2);
    }
  }
}

contractkillsgesture(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  self.contractkillgesture = [];
  for(;;) {
    self waittill("used_cosmetic_gesture");
    var_1 = gettime();
    foreach(var_3 in self.killsthislife) {
      if(abs(var_3.time - var_1) < 3000) {
        if(!isDefined(self.contractkillgesture[var_3.victimid])) {
          thread stampkillgesture(var_3.victimid);
          scripts\mp\contracts::updatecontractprogress(var_0);
        }
      }
    }
  }
}

stampkillgesture(var_0) {
  self endon("disconnect");
  self endon("game_ended");
  self.contractkillgesture[var_0] = 1;
  wait(3);
  self.contractkillgesture[var_0] = undefined;
}

contractequipmentdamagedplayer(var_0, var_1, var_2) {
  if(!isDefined(self.contracts)) {
    return;
  }

  foreach(var_4 in self.contracts) {
    if(var_4.ref == "con_equipment_hits") {
      if(!isDefined(self.equipmentdamageinflictors)) {
        self.equipmentdamageinflictors = [];
      }

      if(!isDefined(self.equipmentdamageinflictors[var_0.guid])) {
        self.equipmentdamageinflictors[var_0.guid] = [];
      }

      if(isDefined(var_2.parentinflictor)) {
        var_5 = var_2.parentinflictor;
      } else {
        var_5 = var_3 getentitynumber();
      }

      var_6 = var_5 + "_" + scripts\mp\utility::func_13CA1(var_1);
      if(var_0 != self && !isDefined(self.equipmentdamageinflictors[var_0.guid][var_6])) {
        thread stampinflictordamage(var_0.guid, var_6);
        scripts\mp\contracts::updatecontractprogress(var_4);
      }
    }
  }
}

stampinflictordamage(var_0, var_1) {
  self endon("disconnect");
  self endon("game_ended");
  self.equipmentdamageinflictors[var_0][var_1] = 1;
  wait(5);
  self.equipmentdamageinflictors[var_0][var_1] = undefined;
}