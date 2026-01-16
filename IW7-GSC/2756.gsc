/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2756.gsc
**************************************/

func_DEF9() {
  level.var_9979 = [];
  func_DEF8("ch_intel_kills", ::func_999E);
  func_DEF8("ch_intel_super_kills", ::func_99D6);
  func_DEF8("ch_intel_killjoys", ::func_999D);
  func_DEF8("ch_intel_score", ::func_99C9);
  func_DEF8("ch_intel_scorestreaks", ::func_99CD);
  func_DEF8("ch_intel_kills_or_assists", ::func_999F);
  func_DEF8("ch_intel_headshots", ::func_9992);
  func_DEF8("ch_intel_double_kills", ::func_9981);
  func_DEF8("ch_intel_triple_kills", ::func_99E2);
  func_DEF8("ch_intel_kills_this_life", ::func_99A0);
  func_DEF8("ch_intel_close_range_kills", ::func_997A);
  func_DEF8("ch_intel_ballistic_kills", ::func_9971);
  func_DEF8("ch_intel_energy_kills", ::func_9983);
  func_DEF8("ch_intel_secondary_kills", ::func_99CE);
  func_DEF8("ch_intel_hipfire_kills", ::func_9993);
  func_DEF8("ch_intel_buzzkill", ::func_9973);
  func_DEF8("ch_intel_medals", ::func_99B3);
  func_DEF8("ch_intel_multiple_weapon_kills", ::func_99BE);
  func_DEF8("ch_intel_attachment_0", ::intelattachmentcount0kills);
  func_DEF8("ch_intel_medal_savior", ::func_99C8);
  func_DEF8("ch_intel_medal_avenger", ::func_996E);
  func_DEF8("ch_intel_objective_attack", ::func_99C1);
  func_DEF8("ch_intel_objective_defend", ::func_99C3);
  func_DEF8("ch_intel_objective_capture", ::func_99C2);
  func_DEF8("ch_intel_ground_pound_rushdown_kills", ::func_998F);
  func_DEF8("ch_intel_lethal_kills", ::func_99A2);
  func_DEF8("ch_intel_popcorn", ::func_99C6);
  func_DEF8("ch_intel_stick", ::func_99D5);
  func_DEF8("ch_intel_aerial_support", ::func_9965);
  func_DEF8("ch_intel_scorestreak_assists", ::func_99CA);
  func_DEF8("ch_intel_scorestreak_kills", ::func_99CC);
  func_DEF8("ch_intel_tactical_assists", ::func_99D8);
  func_DEF8("ch_intel_ss_drone_kills", ::func_99D3);
  func_DEF8("ch_intel_ss_remote_kills", ::func_99D4);
  func_DEF8("ch_intel_attachment_4plus", ::intelattachmentcount4pluskills);
  func_DEF8("ch_intel_medal_jumpshot", ::func_99AD);
  func_DEF8("ch_intel_medal_grounded", ::func_99AC);
  func_DEF8("ch_intel_medal_smackdown", ::func_99B4);
  func_DEF8("ch_intel_medal_wallbuster", ::func_99B6);
  func_DEF8("ch_intel_medal_kingslayer", ::func_99AE);
  func_DEF8("ch_intel_medal_nosebreaker", ::func_99B2);
  func_DEF8("ch_intel_medal_low_blow", ::func_99B0);
  func_DEF8("ch_intel_medal_long_shot", ::func_99AF);
  func_DEF8("ch_intel_afterlife_kills", ::func_9966);
  func_DEF8("ch_intel_backstab_kills", ::func_9970);
  func_DEF8("ch_intel_crouch_kills", ::func_997B);
  func_DEF8("ch_intel_medal_fixated", ::func_99A9);
  func_DEF8("ch_intel_perch_active_camo_kills", ::func_99C5);
  func_DEF8("ch_intel_multikills", ::func_99BD);
  func_DEF8("ch_intel_medal_backfire", ::func_99A6);
  func_DEF8("ch_intel_ace", ::func_99A4);
  func_DEF8("ch_intel_multiple_weapon_one_life", ::func_99BF);
  func_DEF8("ch_intel_ftl_jump_rewind", ::func_998A);
  func_DEF8("ch_intel_assault_kills", ::func_996C);
  func_DEF8("ch_intel_assault_super_kills", ::func_996D);
  func_DEF8("ch_intel_guard_kills", ::func_9990);
  func_DEF8("ch_intel_guard_super_kills", ::func_9991);
  func_DEF8("ch_intel_agent_kills", ::func_9967);
  func_DEF8("ch_intel_agent_super_kills", ::func_9968);
  func_DEF8("ch_intel_ftl_kills", ::func_998B);
  func_DEF8("ch_intel_ftl_super_kills", ::func_998C);
  func_DEF8("ch_intel_engineer_kills", ::func_9984);
  func_DEF8("ch_intel_engineer_super_kills", ::func_9985);
  func_DEF8("ch_intel_ghost_kills", ::func_998D);
  func_DEF8("ch_intel_ghost_super_kills", ::func_998E);
  func_DEF8("ch_intel_weapon_assault_kills", ::func_996B);
  func_DEF8("ch_intel_weapon_lmg_kills", ::func_99A3);
  func_DEF8("ch_intel_weapon_shotgun_kills", ::func_99CF);
  func_DEF8("ch_intel_weapon_smg_kills", ::func_99D0);
  func_DEF8("ch_intel_weapon_sniper_kills", ::func_99D1);
  func_DEF8("ch_intel_finish", ::func_9988);
  func_DEF8("ch_intel_survive", ::func_99D7);
  func_DEF8("ch_intel_medal_fury", ::func_99AB);
  func_DEF8("ch_intel_medal_frenzy", ::func_99AA);
  func_DEF8("ch_intel_medal_super", ::func_99B5);
  func_DEF8("ch_intel_medal_merciless", ::func_99B1);
  func_DEF8("ch_intel_injured_kills", ::func_9995);
  func_DEF8("ch_intel_wallrun_time", ::func_99E3);
  func_DEF8("ch_intel_scorestreak_destroy", ::func_99CB);
  func_DEF8("ch_intel_destroy_equipment", ::func_9980);
  func_DEF8("ch_intel_medal_collateral", ::func_99A8);
  func_DEF8("ch_intel_air_sniper_kills", ::func_99A5);
}

func_DEF8(var_0, var_1) {
  level.var_9979[var_0] = var_1;
}

updatecurrentobjective(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = self.var_9978;
  var_2 = var_1.var_118A7[var_1.var_4C0D]["target"];
  var_3 = var_0;
  var_4 = var_2 - var_1.progress;
  var_0 = min(var_0, var_4);
  var_5 = var_3 - var_0;
  var_1.progress = var_1.progress + var_0;
  setmatchdata("players", self.clientid, "missionTeam_challengeProgress", var_1.progress);

  if(var_1.progress >= var_2) {
    scripts\mp\intel::func_F75C();
  }

  scripts\mp\intel::func_12EB7(var_1.progress);

  if(var_5 > 0 && !scripts\mp\intel::func_9E94()) {
    updatecurrentobjective(var_5);
  }
}

func_F80D(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\mp\intel::func_9E94()) {
    return;
  }
  var_1 = self.var_9978;
  var_1.progress = var_0;
  var_2 = var_1.var_118A7[var_1.var_4C0D]["target"];
  setmatchdata("players", self.clientid, "missionTeam_challengeProgress", var_0);

  while(var_1.progress >= var_2) {
    scripts\mp\intel::func_F75C();

    if(scripts\mp\intel::func_9E94()) {
      break;
    }
    var_2 = var_1.var_118A7[var_1.var_4C0D]["target"];
  }

  scripts\mp\intel::func_12EB7(var_1.progress);
}

func_9988(var_0) {
  self endon("disconnect");
  level waittill("game_ended");
  scripts\mp\intel::func_F75C();
}

func_9992(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);

    if(scripts\mp\utility\game::istrue(var_4["headshot"])) {
      updatecurrentobjective();
    }
  }
}

func_999E(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2);
    updatecurrentobjective();
  }
}

func_99C9(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("earned_score_buffered", var_1);
    var_2 = self.pers["gamemodeScore"];

    if(isDefined(var_2) && var_2 > 0) {
      var_1 = var_2 - self.var_9978.progress;
    }

    updatecurrentobjective(var_1);
  }
}

func_99CD(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("earned_killstreak_buffered");
    updatecurrentobjective();
  }
}

func_99B3(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("earned_award_buffered");
    updatecurrentobjective();
  }
}

func_999F(var_0) {
  self endon("disconnect");
  self endon("killsOrAssistsChallengeFinished");
  thread func_A67D();
  thread func_A67C();
}

func_A67D() {
  self endon("disconnect");
  self endon("killsOrAssistsChallengeFinished");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_0, var_1, var_2, var_3);
    updatecurrentobjective();
  }

  self notify("killsOrAssistsChallengeFinished");
}

func_A67C() {
  self endon("disconnect");
  self endon("killsOrAssistsChallengeFinished");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("assist_buffered", var_0);
    updatecurrentobjective();
  }

  self notify("killsOrAssistsChallengeFinished");
}

func_999D(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("earned_award_buffered", var_1);
    var_2 = level.awards[var_1].category;

    if(var_2 == "supershutdown" || var_2 == "streak_shutdown") {
      updatecurrentobjective();
    }
  }
}

func_9981(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("update_rapid_kill_buffered", var_1);

    if(var_1 % 2 == 0) {
      updatecurrentobjective();
    }
  }
}

func_99E2(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("update_rapid_kill_buffered", var_1);

    if(var_1 % 3 == 0) {
      updatecurrentobjective();
    }
  }
}

func_99D6(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("super_kill_buffered");
    updatecurrentobjective();
  }
}

func_99A0(var_0) {}

func_997A(var_0) {}

func_9971(var_0) {}

func_9983(var_0) {}

func_99CE(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);
    var_5 = scripts\mp\utility\game::getweaponrootname(var_2) == "iw7_axe";
    var_2 = scripts\mp\utility\game::func_13CA1(var_2);

    if(scripts\mp\utility\game::iscacsecondaryweapon(var_2)) {
      if(var_3 == "MOD_MELEE" || var_5) {
        continue;
      }
      updatecurrentobjective();
    }
  }
}

func_9993(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);

    if(scripts\mp\utility\game::istrue(var_4["hipfire"])) {
      updatecurrentobjective();
    }
  }
}

func_9973(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);

    if(scripts\mp\utility\game::istrue(var_4["buzzkill"])) {
      updatecurrentobjective();
    }
  }
}

func_99D7(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("damage");
    waittillframeend;

    if(self.health > 0 && self.health < self.maxhealth * 0.25) {
      thread func_99BC();
    }
  }
}

func_99BC() {
  self endon("disconnect");
  self endon("death");
  self notify("monitorSurviveHealth");
  self endon("monitorSurviveHealth");
  self waittill("healed");
  updatecurrentobjective();
}

func_9995(var_0) {}

func_99BE(var_0) {}

intelattachmentcount0kills(var_0) {
  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2);

    if(isDefined(var_2)) {
      if(!scripts\mp\utility\game::iscacprimaryweapon(var_2) && !scripts\mp\utility\game::iscacsecondaryweapon(var_2)) {
        continue;
      }
      intelattachmentcountchallenge(var_2, 0, 0);
    }
  }
}

intelattachmentcount4pluskills(var_0) {
  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2);

    if(isDefined(var_2)) {
      if(!scripts\mp\utility\game::iscacprimaryweapon(var_2) && !scripts\mp\utility\game::iscacsecondaryweapon(var_2)) {
        continue;
      }
      intelattachmentcountchallenge(var_2, 3, 1);
    }
  }
}

func_99E3(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    if(self iswallrunning()) {
      var_1 = gettime();

      while(self iswallrunning()) {
        wait 0.1;
      }

      var_2 = gettime() - var_1;
      var_2 = var_2 / 1000.0;

      if(!isDefined(self.var_138D5)) {
        self.var_138D5 = var_2;
      } else {
        self.var_138D5 = self.var_138D5 + var_2;
      }

      updatecurrentobjective(var_2);
    }

    wait 0.05;
  }
}

func_996C(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_9969("archetype_assault");
  }
}

func_996D(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_996A("archetype_assault");
  }
}

func_9990(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_9969("archetype_heavy");
  }
}

func_9991(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_996A("archetype_heavy");
  }
}

func_9967(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_9969("archetype_scout");
  }
}

func_9968(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_996A("archetype_scout");
  }
}

func_99A3(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99E4("weapon_lmg");
  }
}

func_99C8(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99A7("save_teammate");
  }
}

func_996E(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99A7("avenger");
  }
}

func_99C1(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("earned_award_buffered", var_1);

    if(var_1 == "mode_x_assault" || var_1 == "mode_sd_defuse_save" || var_1 == "mode_uplink_kill_with_ball" || var_1 == "mode_ctf_kill_with_flag") {
      updatecurrentobjective();
    }
  }
}

func_99C3(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("earned_award_buffered", var_1);

    if(var_1 == "mode_x_defend" || var_1 == "mode_sd_plant_save" || var_1 == "mode_uplink_kill_carrier" || var_1 == "mode_ctf_kill_carrier") {
      updatecurrentobjective();
    }
  }
}

func_99C2(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    thread func_99C0("earned_award_buffered");
    thread func_99C0("bomb_planted");
    self waittill("update_objective_capture", var_1);

    if(isDefined(var_1)) {
      if(var_1 == "mode_dom_secure_b" || var_1 == "mode_dom_secure_neutral" || var_1 == "mode_dom_secure" || var_1 == "mode_hp_secure" || var_1 == "mode_sd_last_defuse" || var_1 == "mode_sd_defuse" || var_1 == "mode_uplink_dunk" || var_1 == "mode_uplink_fieldgoal" || var_1 == "mode_ctf_cap" || var_1 == "mode_siege_secure") {
        updatecurrentobjective();
      }

      continue;
    }

    updatecurrentobjective();
  }
}

func_99C0(var_0) {
  self waittill(var_0, var_1);
  self notify("update_objective_capture", var_1);
}

func_998F(var_0) {}

func_99CF(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99E4("weapon_shotgun");
  }
}

func_99A2(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);
    var_5 = scripts\mp\utility\game::getequipmenttype(var_2);

    if(isDefined(var_5) && var_5 == "lethal") {
      updatecurrentobjective();
    }
  }
}

func_99C6(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99A7("grenade_double");
  }
}

func_99D5(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("grenade_stuck_enemy");
    updatecurrentobjective();
  }
}

func_9965(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("killstreak_used", var_1);
    var_2 = 0;

    switch (var_1) {
      case "jammer":
      case "jackal":
      case "directional_uav":
      case "counter_uav":
      case "uav":
      case "bombardment":
      case "precision_airstrike":
      case "thor":
      case "minijackal":
      case "drone_hive":
        var_2 = 1;
        break;
    }

    if(var_2) {
      updatecurrentobjective();
    }
  }
}

func_99CA(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("update_uav_assist_buffered");
    updatecurrentobjective();
  }
}

func_99CB(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("earned_award_buffered", var_1);
    var_2 = level.awards[var_1].category;

    if(var_2 == "streak_shutdown") {
      updatecurrentobjective();
    }
  }
}

func_99CC(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2);

    if(scripts\mp\utility\game::iskillstreakweapon(var_2)) {
      updatecurrentobjective();
    }
  }
}

func_9980(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("destroyed_equipment");
    updatecurrentobjective();
  }
}

func_99D8(var_0) {}

func_99D3(var_0) {}

func_99D4(var_0) {}

func_9984(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_9969("archetype_engineer");
  }
}

func_9985(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_996A("archetype_engineer");
  }
}

func_996B(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99E4("weapon_assault");
  }
}

func_99AD(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);

    if(scripts\mp\utility\game::istrue(var_4["airborne"])) {
      updatecurrentobjective();
    }
  }
}

func_99AC(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99A7("kill_jumper");
  }
}

func_99B4(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99A7("wallrun_kill");
  }
}

func_99B6(var_0) {}

func_99AE(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99A7("first_place_kill");
  }
}

func_99B2(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);

    if(var_3 == "MOD_MELEE") {
      updatecurrentobjective();
    }
  }
}

func_99B0(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99A7("slide_kill");
  }
}

func_99AF(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99A7("longshot");
  }
}

func_9966(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);

    if(scripts\mp\utility\game::istrue(var_4["posthumous"])) {
      updatecurrentobjective();
    }
  }
}

func_9970(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);

    if(scripts\mp\utility\game::istrue(var_4["backstab"]) && var_3 == "MOD_MELEE") {
      updatecurrentobjective();
    }
  }
}

func_997B(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("kill_event_buffered", var_1, var_2, var_3, var_4);

    if(scripts\mp\utility\game::istrue(var_4["crouch_kill"])) {
      updatecurrentobjective();
    }
  }
}

func_99A9(var_0) {}

func_99C5(var_0) {}

func_998D(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_9969("archetype_sniper");
  }
}

func_998E(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_996A("archetype_sniper");
  }
}

func_99D1(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99E4("weapon_sniper");
  }
}

func_99AB(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("update_rapid_kill_buffered", var_1);

    if(var_1 % 4 == 0) {
      updatecurrentobjective();
    }
  }
}

func_99AA(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("update_rapid_kill_buffered", var_1);

    if(var_1 % 5 == 0) {
      updatecurrentobjective();
    }
  }
}

func_99B5(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("update_rapid_kill_buffered", var_1);

    if(var_1 % 6 == 0) {
      updatecurrentobjective();
    }
  }
}

func_99BD(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("update_rapid_kill_buffered", var_1);

    if(var_1) {
      func_F80D(var_1);
      thread func_99BB();
      thread func_99B9();
    }
  }
}

func_99BB() {
  self endon("disconnect");
  self endon("intel_max_tier_complete");
  self notify("intelMonitorMultikills");
  self endon("intelMonitorMultikills");

  while(self.var_DDC2 != 0) {
    wait 0.1;
  }

  func_F80D(0);
}

func_99A6(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99A7("backfire");
  }
}

func_99A8(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99A7("one_shot_two_kills");
  }
}

func_99B1(var_0) {}

func_99A5(var_0) {}

func_99A4(var_0) {}

func_99BF(var_0) {}

func_998A(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    self waittill("super_kill_buffered");

    if(scripts\mp\supers::getcurrentsuperref() == "super_teleport" || scripts\mp\supers::getcurrentsuperref() == "super_rewind") {
      updatecurrentobjective();
    }
  }
}

func_998B(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_9969("archetype_assassin");
  }
}

func_998C(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_996A("archetype_assassin");
  }
}

func_99D0(var_0) {
  self endon("disconnect");

  while(!scripts\mp\intel::func_9E94()) {
    func_99E4("weapon_smg");
  }
}

func_99BA(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");

  if(isDefined(self.var_9978)) {
    if(!scripts\mp\intel::func_9E94()) {
      switch (self.var_9978.ref) {
        case "ch_intel_air_sniper_kills":
          if(!self isonground() && isDefined(var_2) && scripts\mp\utility\game::getweapongroup(var_2) == "weapon_sniper") {
            updatecurrentobjective();
          }

          break;
        case "ch_intel_medal_merciless":
          if(isDefined(self.killsthislife) && self.killsthislife.size % 10 == 0) {
            updatecurrentobjective();
          }

          break;
        case "ch_intel_ace":
          var_5 = 0;

          if(level.teambased) {
            var_5 = scripts\mp\utility\game::getteamarray(scripts\mp\utility\game::getotherteam(self.team)).size;
          } else {
            var_5 = level.players.size - 1;
          }

          if(isDefined(self.var_A653) && var_5 >= 4) {
            var_6 = combinepartialprogressandvalidateplayers(self.var_A653);

            if(var_6.size == var_5) {
              var_7 = self.var_9978.progress;

              foreach(var_9 in var_6) {
                if(var_9 <= var_7) {
                  return;
                }
              }

              updatecurrentobjective();
            }
          }

          break;
        case "ch_intel_injured_kills":
          if(self.health > 0 && self.health < self.maxhealth * 0.9) {
            updatecurrentobjective();
          }

          break;
        case "ch_intel_kills_this_life":
          if(isDefined(self.killsthislife)) {
            var_11 = self.pers["cur_kill_streak"];
            func_F80D(var_11);
            thread func_99B9();
          }

          break;
        case "ch_intel_multiple_weapon_kills":
          var_7 = self.var_9978.progress;

          if(isDefined(self.killsperweapon)) {
            var_12 = combinealtweaponarray(self.killsperweapon);
            var_13 = combinepartialprogress(var_12);

            if(var_13.size > var_7) {
              updatecurrentobjective();
            }
          }

          break;
        case "ch_intel_multiple_weapon_one_life":
          if(isDefined(self.killsthislifeperweapon)) {
            var_14 = combinealtweaponarray(self.killsthislifeperweapon);
            var_13 = combinepartialprogress(var_14);
            thread func_99B9();
            func_F80D(var_13.size);
          }

          break;
        case "ch_intel_ballistic_kills":
          if((isDefined(var_2) && scripts\mp\utility\game::iscacprimaryweapon(var_2) || scripts\mp\utility\game::iscacsecondaryweapon(var_2)) && !_weaponusesenergybullets(var_2)) {
            if(var_3 == "MOD_MELEE") {
              var_15 = scripts\mp\utility\game::getweaponrootname(var_2);

              if(var_15 == "iw7_devastator") {
                var_16 = getweaponvariantindex(var_2);

                if(isDefined(var_16) && (var_16 == 4 || var_16 == 36)) {
                  updatecurrentobjective();
                }
              }
            } else if(isexplosivedamagemod(var_3)) {
              var_15 = scripts\mp\utility\game::getweaponrootname(var_2);

              if(var_15 == "iw7_kbs") {
                var_16 = getweaponvariantindex(var_2);

                if(isDefined(var_16) && (var_16 == 6 || var_16 == 38)) {
                  updatecurrentobjective();
                }
              }
            } else if(scripts\engine\utility::isbulletdamage(var_3)) {
              updatecurrentobjective();
            }
          }

          break;
        case "ch_intel_energy_kills":
          if((isDefined(var_2) && scripts\mp\utility\game::iscacprimaryweapon(var_2) || scripts\mp\utility\game::iscacsecondaryweapon(var_2)) && _weaponusesenergybullets(var_2)) {
            if(var_3 == "MOD_MELEE") {
              var_15 = scripts\mp\utility\game::getweaponrootname(var_2);

              if(var_15 == "iw7_rvn") {
                if(self isalternatemode(var_2)) {
                  updatecurrentobjective();
                }
              }
            } else if(isexplosivedamagemod(var_3)) {
              var_15 = scripts\mp\utility\game::getweaponrootname(var_2);

              if(var_15 == "iw7_rvn") {
                var_16 = getweaponvariantindex(var_2);

                if(isDefined(var_16) && (var_16 == 3 || var_16 == 35)) {
                  if(self isalternatemode(var_2)) {
                    updatecurrentobjective();
                  }
                }
              }
            } else if(scripts\engine\utility::isbulletdamage(var_3)) {
              updatecurrentobjective();
            }
          }

          break;
        case "ch_intel_ground_pound_rushdown_kills":
          if(isDefined(var_2) && (var_2 == "groundpound_mp" || var_2 == "thruster_mp")) {
            updatecurrentobjective();
          }

          break;
        case "ch_intel_ss_drone_kills":
          if(!isDefined(var_2) || !scripts\mp\utility\game::iskillstreakweapon(var_2)) {
            return;
          }
          var_17 = scripts\mp\missions::func_7F48(var_2);

          switch (var_17) {
            case "ball_drone_backup":
            case "jackal":
            case "sentry_shock":
              updatecurrentobjective();
              break;
            case "remote_c8":
              if(isDefined(self.var_4BE1) && self.var_4BE1 != "MANUAL") {
                updatecurrentobjective();
              }

              break;
          }

          break;
        case "ch_intel_ss_remote_kills":
          if(!isDefined(var_2) || !scripts\mp\utility\game::iskillstreakweapon(var_2)) {
            return;
          }
          var_17 = scripts\mp\missions::func_7F48(var_2);

          switch (var_17) {
            case "venom":
            case "thor":
            case "minijackal":
            case "drone_hive":
              updatecurrentobjective();
              break;
            case "remote_c8":
              if(isDefined(self.var_4BE1) && self.var_4BE1 == "MANUAL") {
                updatecurrentobjective();
              }

              break;
          }

          break;
        case "ch_intel_perch_active_camo_kills":
          if(isDefined(self.trait) && self.trait == "specialty_wall_lock" && scripts\mp\utility\game::istrue(self.var_9FF6) || scripts\mp\supers::issuperinuse() && scripts\mp\supers::getcurrentsuperref() == "super_invisible") {
            updatecurrentobjective();
          }

          break;
        case "ch_intel_medal_fixated":
          var_5 = 0;

          if(level.teambased) {
            var_5 = scripts\mp\utility\game::getteamarray(scripts\mp\utility\game::getotherteam(self.team)).size;
          } else {
            var_5 = level.players.size - 1;
          }

          if(isDefined(self.var_A653)) {
            var_6 = combinepartialprogressandvalidateplayers(self.var_A653);
            var_7 = self.var_9978.progress;
            var_18 = 0;

            foreach(var_9 in var_6) {
              if(var_9 > var_7) {
                var_18 = 1;
                break;
              }
            }

            if(var_18) {
              updatecurrentobjective();
            }
          }

          break;
        case "ch_intel_close_range_kills":
          if(var_1 == self) {
            var_21 = distancesquared(self.origin, var_0.origin);

            if(var_3 == "MOD_MELEE" || var_21 < 24336) {
              updatecurrentobjective();
            }
          }

          break;
        case "ch_intel_medal_wallbuster":
          if(isDefined(var_0.var_AA43) && gettime() - var_0.var_AA43 < 1000) {
            updatecurrentobjective();
          }

          break;
      }
    }
  }
}

func_99B8(var_0) {
  self endon("disconnect");
  var_1 = var_0.attackerdata[self.guid];

  if(isDefined(self.var_9978)) {
    if(!scripts\mp\intel::func_9E94()) {
      if(self.var_9978.ref == "ch_intel_tactical_assists") {
        if(isDefined(var_1) && scripts\mp\utility\game::istrue(var_1.diddamagewithtacticalequipment)) {
          updatecurrentobjective();
        }
      }
    }
  }
}

func_99B9() {
  self endon("disconnect");
  self endon("intel_max_tier_complete");
  self notify("intelMonitorDeathResetProgress");
  self endon("intelMonitorDeathResetProgress");
  self waittill("death");
  func_F80D(0);
  self.pers["intelPartialProgress"] = undefined;
}

func_99A7(var_0) {
  self waittill("earned_award_buffered", var_1);

  if(var_1 == var_0) {
    updatecurrentobjective();
  }
}

func_9969(var_0) {
  self waittill("kill_event_buffered", var_1, var_2);

  if(!scripts\mp\utility\game::iskillstreakweapon(var_2) && scripts\mp\utility\game::func_9D48(var_0)) {
    updatecurrentobjective();
  }
}

func_996A(var_0) {
  self waittill("super_kill_buffered");

  if(scripts\mp\utility\game::func_9D48(var_0)) {
    updatecurrentobjective();
  }
}

func_99E4(var_0) {
  self waittill("kill_event_buffered", var_1, var_2, var_3);
  var_2 = scripts\mp\utility\game::func_13CA1(var_2);

  if(!scripts\mp\utility\game::iskillstreakweapon(var_2) && scripts\mp\utility\game::getweapongroup(var_2) == var_0) {
    if(var_3 != "MOD_MELEE") {
      updatecurrentobjective();
    }
  }
}

intelattachmentcountchallenge(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\game::getweaponrootname(var_0);
  var_4 = 0;

  foreach(var_6 in getweaponattachments(var_0)) {
    var_7 = scripts\mp\utility\game::attachmentmap_tobase(var_6);

    if(scripts\mp\weapons::func_9F3C(var_3, var_7)) {
      var_4++;
    }
  }

  if(var_2 < 0) {
    if(var_4 < var_1) {
      updatecurrentobjective();
    }
  } else if(var_2 > 0) {
    if(var_4 > var_1) {
      updatecurrentobjective();
    }
  } else if(var_4 == var_1) {
    updatecurrentobjective();
  }
}

combinealtweaponarray(var_0) {
  var_1 = [];

  foreach(var_5, var_3 in var_0) {
    var_4 = var_5;

    if(scripts\mp\utility\game::isstrstart(var_5, "alt_")) {
      var_4 = getsubstr(var_5, 4, var_5.size);
    }

    if(!isDefined(var_1[var_4])) {
      var_1[var_4] = var_3;
      continue;
    }

    var_1[var_4] = var_1[var_4] + var_3;
  }

  return var_1;
}

combinepartialprogress(var_0) {
  if(!isDefined(self.pers["intelPartialProgress"])) {
    self.pers["intelPartialProgress"] = [];
  }

  self.pers["intelPartialProgress"][level.currentround] = var_0;
  var_1 = [];
  var_2 = self.pers["intelPartialProgress"];

  foreach(var_8, var_4 in var_2) {
    foreach(var_7, var_6 in var_4) {
      if(!isDefined(var_1[var_7])) {
        var_1[var_7] = var_6;
        continue;
      }

      var_1[var_7] = var_1[var_7] + var_6;
    }
  }

  return var_1;
}

combinepartialprogressandvalidateplayers(var_0) {
  var_1 = combinepartialprogress(var_0);
  var_2 = [];

  foreach(var_8, var_4 in var_1) {
    foreach(var_6 in level.players) {
      if(var_6.guid == var_8) {
        var_2[var_8] = var_4;
        break;
      }
    }
  }

  return var_2;
}