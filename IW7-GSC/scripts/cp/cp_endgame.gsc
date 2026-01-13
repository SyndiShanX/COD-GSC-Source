/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\cp_endgame.gsc
*********************************************/

init() {
  func_DEB3();
}

endgame(var_0, var_1) {
  if(gamealreadyended()) {
    return;
  }

  setnojiptime(1);
  level thread kill_all_zombies();
  func_B37C();
  level notify("game_ended", var_0);
  func_7384(1, "cg_fovScale", 1);
  if(var_1 == 4) {
    wait(4.9);
  }

  var_2 = 0;
  foreach(var_4 in level.players) {
    var_4 stoplocalsound("zmb_laststand_music");
    if(var_4 issplitscreenplayer()) {
      if(var_4 issplitscreenplayerprimary()) {
        if(soundexists("mus_zombies_gameover")) {
          var_4 playlocalsound("mus_zombies_gameover");
        }
      }

      continue;
    }

    if(soundexists("mus_zombies_gameover")) {
      var_4 playlocalsound("mus_zombies_gameover");
    }
  }

  level.ingraceperiod = 0;
  setomnvar("allow_server_pause", 0);
  scripts\engine\utility::waitframe();
  level.time_survived = get_time_survived();
  setomnvar("zm_time_survived", level.time_survived);
  setomnvarforallclients("post_game_state", 1);
  setdvar("g_deadChat", 1);
  setdvar("ui_allow_teamchange", 0);
  setdvar("bg_compassShowEnemies", 0);
  setdvar("scr_gameended", 1);
  setgameendtime(0);
  setomnvar("zm_ui_timer", 0);
  scripts\cp\cp_challenge::deactivate_current_challenge();
  foreach(var_4 in level.players) {
    func_40A5(var_4);
  }

  level.var_2AAD = 1;
  foreach(var_9 in level.agentarray) {
    if(isDefined(var_9.isactive) && var_9.isactive) {
      var_9.precacheleaderboards = 1;
      var_9 scripts\cp\utility::enable_alien_scripted();
    }
  }

  setomnvarforallclients("post_game_state", 0);
  var_0B = func_FF5E(var_1);
  if(isDefined(var_0B)) {
    if(isDefined(level.var_ADDF)) {
      [
        [level.var_ADDF]
      ](var_1);
    }

    func_ADDE(var_0B);
    return;
  }

  scripts\cp\cp_gamescore::calculate_players_total_end_game_score(1);
  if(isDefined(level.var_D7BB)) {
    [[level.var_D7BB]]();
  }

  if(!scripts\cp\utility::is_codxp()) {
    foreach(var_4 in level.players) {
      var_4 setclientdvar("ui_opensummary", 1);
    }
  }

  setomnvarforallclients("post_game_state", 2);
  func_56DA(var_0, var_1);
  setomnvarforallclients("post_game_state", 1);
  var_0E = ::scripts\cp\cp_globallogic::spawnintermission;
  if(isDefined(level.var_4C58)) {
    var_0E = level.var_4C58;
  }

  if(!scripts\cp\utility::is_codxp()) {
    foreach(var_4 in level.players) {
      var_4 thread[[var_0E]](var_1);
    }
  }

  var_11 = func_7978(var_1);
  var_12 = func_7B85();
  scripts\cp\zombies\direct_boss_fight::adjust_wave_num(var_11);
  scripts\cp\cp_analytics::endgame(var_11, var_12);
  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    if(var_1 == 1) {
      setomnvar("zm_boss_splash", 5);
    } else {
      setomnvar("zm_boss_splash", 6);
    }
  }

  setomnvarforallclients("post_game_state", 4);
  wait(11);
  setomnvarforallclients("post_game_state", 1);
  level notify("exitLevel_called");
  exitlevel(0);
}

get_time_survived() {
  if(isDefined(level.calculate_time_survived_func)) {
    return [[level.calculate_time_survived_func]]();
  }

  return int(gettime() - level.starttime / 1000);
}

kill_all_zombies() {
  wait(1);
  var_0 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  foreach(var_2 in var_0) {
    var_2.precacheleaderboards = 1;
    var_2.scripted_mode = 1;
    var_2 ghostskulls_complete_status(getclosestpointonnavmesh(var_2.origin));
    if(!isDefined(var_2.agent_type)) {
      continue;
    }

    if(var_2.agent_type == "zombie_grey") {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.entered_playspace)) {
      continue;
    }

    switch (var_2.agent_type) {
      case "zombie_cop":
      case "zombie_ghost":
      case "zombie_brute":
      case "zombie_clown":
        break;

      case "generic_zombie":
        playFX(level._effect["head_loss"], var_2 gettagorigin("j_head"));
        var_2 setscriptablepartstate("head", "detached", 1);
        var_2 setscriptablepartstate("eyes", "eye_glow_off", 1);
        break;
    }

    var_2 dodamage(var_2.health + 100, var_2.origin);
    wait(0.25);
  }
}

func_72BF() {
  level thread endgame("axis", func_7979("host_end"));
}

func_B37C() {
  game["state"] = "postgame";
  level.gameended = 1;
}

gamealreadyended() {
  return game["state"] == "postgame" || level.gameended;
}

func_7384(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  foreach(var_4 in level.players) {
    var_4 thread freezeplayerforroundend(var_0);
    var_4 thread func_E760(4);
    var_4 freegameplayhudelems();
    var_4 setclientdvars("cg_everyoneHearsEveryone", 1, "cg_drawSpectatorMessages", 0);
    if(isDefined(var_1) && isDefined(var_2)) {
      var_4 setclientdvars(var_1, var_2);
    }
  }

  foreach(var_7 in level.agentarray) {
    var_7 scripts\cp\utility::freezecontrolswrapper(1);
  }
}

freezeplayerforroundend(var_0) {
  self endon("disconnect");
  scripts\cp\utility::clearlowermessages();
  if(!isDefined(var_0)) {
    var_0 = 0.05;
  }

  wait(var_0);
  scripts\cp\utility::freezecontrolswrapper(1);
}

func_E760(var_0) {
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);
}

func_7B85() {
  var_0 = 0;
  if(isDefined(level.starttime)) {
    var_0 = gettime() - level.starttime;
  }

  return var_0;
}

freegameplayhudelems() {
  if(isDefined(self.perkicon)) {
    if(isDefined(self.perkicon[0])) {
      self.perkicon[0] scripts\cp\utility::destroyelem();
      self.perkname[0] scripts\cp\utility::destroyelem();
    }

    if(isDefined(self.perkicon[1])) {
      self.perkicon[1] scripts\cp\utility::destroyelem();
      self.perkname[1] scripts\cp\utility::destroyelem();
    }

    if(isDefined(self.perkicon[2])) {
      self.perkicon[2] scripts\cp\utility::destroyelem();
      self.perkname[2] scripts\cp\utility::destroyelem();
    }
  }

  self notify("perks_hidden");
  self.lowermessage scripts\cp\utility::destroyelem();
  self.lowertimer scripts\cp\utility::destroyelem();
  if(isDefined(self.proxbar)) {
    self.proxbar scripts\cp\utility::destroyelem();
  }

  if(isDefined(self.proxbartext)) {
    self.proxbartext scripts\cp\utility::destroyelem();
  }
}

func_40A5(var_0) {
  var_0 notify("select_mode");
  var_0 notify("reset_outcome");
  var_0.pers["stats"] = var_0.var_10E53;
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0 setclientomnvar("ui_intel_progress_current", -1);
  var_0 setclientomnvar("ui_intel_progress_max", -1);
  var_0 setclientomnvar("ui_intel_percent", -1);
  var_0 setclientomnvar("ui_intel_target_player", -1);
  var_0 setclientomnvar("ui_intel_prechallenge", 0);
  var_0 setclientomnvar("ui_intel_timer", -1);
  var_0 setclientomnvar("ui_intel_challenge_scalar", -1);
  var_0 setclientomnvar("zombie_number_of_ticket", 0);
  var_0 setplayerdata("cp", "zombiePlayerLoadout", "tutorialOff", 1);
  var_0 scripts\cp\utility::clearlowermessages();
  if(isDefined(var_0.pap)) {
    var_0.pap = [];
  }

  if(isDefined(var_0.powerupicons)) {
    var_0.powerupicons = [];
  }

  if(isDefined(var_0.var_456D)) {
    var_0.var_456D = [];
  }

  if(isDefined(var_0.powers)) {
    var_0.powers = [];
  }

  var_0 func_4172();
}

func_FF5E(var_0) {
  if((var_0 == 1 || var_0 == 2) && getdvar("ui_mapname") == "cp_jackal_ass") {
    return "cp_titan";
  }

  return undefined;
}

func_ADDE(var_0) {
  func_A5D7();
  level scripts\engine\utility::waittill_any_timeout_1(15, "intermission_over");
  setdvar("ui_mapname", var_0);
  setdvar("g_gametype", "aliens");
  var_1 = "map " + var_0;
}

\\Restart Map
func_E2AE() {
  func_A5D7();
  setomnvar("allow_server_pause", 1);
  setomnvarforallclients("post_game_state", 0);
  for(var_0 = 3; var_0 > 0; var_0--) {
    iprintlnbold("RESTARTING IN..." + var_0);
    wait(1);
  }

  map_restart(1);
}

\\Kill Aliens
func_A5D7() {
  foreach(var_1 in level.characters) {
    var_1 dodamage(100000, var_1.origin);
  }

  var_3 = scripts\cp\cp_agent_utils::getactiveagentsofspecies("alien");
  foreach(var_5 in var_3) {
    var_5 suicide();
  }
}

func_D40D(var_0) {
  if(var_0 == 4) {
    level.var_E40B = 0;
    level.var_E40C = 0;
    foreach(var_2 in level.players) {
      var_2 thread func_56C4();
    }

    var_4 = level.players.size - level.var_E40B;
    while(level.var_E40B < level.players.size) {
      var_5 = var_4;
      var_4 = level.players.size - level.var_E40B;
      if(var_4 != var_5) {
        iprintlnbold("Waiting for " + var_4 + " player\'s to vote");
      }

      wait(0.5);
    }

    if(level.var_E40C == level.players.size) {
      return 1;
    }
  }

  return 0;
}

func_56C4() {
  wait(3);
  scripts\cp\cp_laststand::clear_last_stand_timer(self);
  self setclientomnvar("retry_popup", 1);
  self waittill("luinotifyserver", var_0);
  level.var_E40B = level.var_E40B + 1;
  if(var_0 == "retry_level") {
    level.var_E40C = level.var_E40C + 1;
  }
}

func_4172() {
  if(isDefined(self.powers)) {
    foreach(var_1 in getarraykeys(self.powers)) {
      var_2 = self.powers[var_1].charges * -1;
      scripts\cp\powers\coop_powers::power_adjustcharges(var_2);
    }
  }

  scripts\cp\powers\coop_powers::func_13F00("secondary");
  scripts\cp\powers\coop_powers::func_13F00("primary");
}

func_7978(var_0) {
  switch (var_0) {
    case 1:
      return "all_escape";

    case 2:
      return "some_escape";

    case 3:
      return "fail_escape";

    case 8:
    case 5:
    case 4:
      return "died";

    case 6:
      return "host_quit";

    case 7:
      return "gas_fail";

    default:
      break;
  }
}

func_56C5() {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_0);
    if(var_0 == "close_menu") {
      level.var_AE3F = level.var_AE3F + 1;
      continue;
    } else {
      switch (var_0) {
        case "dpad_team_ammo_ap":
        case "dpad_team_ammo_in":
        case "dpad_team_ammo_stun":
        case "dpad_team_ammo_reg":
          break;

        case "dpad_team_boost":
        case "dpad_team_armor":
        case "dpad_team_adrenaline":
        case "dpad_team_explosives":
          break;

        case "dpad_maaws":
        case "dpad_riotshield":
        case "dpad_death_machine":
        case "dpad_war_machine":
          break;

        case "perk_bullet_damage":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;

        case "perk_health":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;

        case "perk_rigger":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;

        case "perk_medic":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;

        case "perk_robotics":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;

        case "perk_demolition":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;

        case "perk_gunslinger":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;

        case "perk_hybrid":
          scripts\engine\utility::waitframe();
          scripts\engine\utility::waitframe();
          break;

        case "perk_pistol_zemc":
        case "perk_pistol_zg18":
        case "perk_pistol_magnum":
        case "perk_pistol_znrg":
          break;

        case "perk_skill_pet":
        case "perk_skill_electric_arc":
        case "perk_skill_mortar":
        case "perk_skill_drone":
        case "perk_skill_heal_ring":
        case "perk_skill_stasis":
        case "perk_skill_invulnerable":
        case "perk_skill_infinite_ammo":
          break;

        case "iw6_kriss_mp":
        case "iw6_cprgm_mp":
        case "iw6_cppanzerfaust3_mp":
        case "iw6_l115a3_mp+acogsniper":
        case "iw6_vks_mp+vksscope":
        case "iw6_svu_mp":
        case "iw6_g28_mp":
        case "iw6_imbel_mp":
        case "iw6_microtar_mp":
        case "iw6_pdw_mp":
        case "iw6_vepr_mp":
        case "iw6_pp19_mp":
        case "iw6_maul_mp":
        case "iw6_cbjms_mp":
        case "iw6_mts255_mp":
        case "iw6_fp6_mp":
        case "iw6_honeybadger_mp":
        case "iw6_aliendlc11li_mp":
        case "iw6_m27_mp":
        case "iw6_lsat_mp":
        case "iw6_dlcweap02_mp+dlcweap02scope":
        case "iw6_plasmaauto_mp":
        case "iw7_erad_mp":
        case "iw7_crb_mp":
        case "iw7_devastator_mp":
        case "iw7_chargeshot_mp":
        case "iw7_spas_mp":
        case "iw7_forge_mp":
        case "iw7_nrg_mp":
        case "iw7_ake_mp":
        case "iw7_m1_mp":
        case "iw7_ar57_mp":
        case "iw7_m8_mp+m8scope":
        case "iw7_cheytac_mp+cheytacscope":
        case "iw7_kbs_mp+kbsscope":
        case "iw6_arx160_mp":
        case "iw6_kac_mp":
        case "iw7_glprox_mp":
        case "iw6_panzerfaust3_mp":
        case "iw6_mp443_mp":
        case "iw6_m9a1_mp":
        case "iw6_magnum_mp":
        case "iw6_p226_mp":
          break;
      }
    }
  }
}

func_56DA(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3.connectedpostgame) || var_3.pers["team"] == "spectator") {
      continue;
    }

    var_3 thread func_C752(var_0, var_1);
    var_3 thread scripts\cp\utility::freezecontrolswrapper(1);
  }

  level notify("game_win", var_0);
}

func_C752(var_0, var_1) {
  self endon("disconnect");
  self notify("reset_outcome");
  wait(0.5);
  var_2 = self.pers["team"];
  if(!isDefined(var_2) || var_2 != "allies" && var_2 != "axis") {
    var_2 = "allies";
  }

  while(scripts\cp\cp_hud_message::isdoingsplash()) {
    wait(0.05);
  }

  self endon("reset_outcome");
  if(isDefined(self.pers["team"]) && var_0 == var_2) {
    var_3 = func_7979("win");
  } else {
    var_3 = func_7979("fail");
  }

  self setclientomnvar("ui_round_end_title", var_3);
  if(isDefined(var_1)) {
    self setclientomnvar("ui_round_end_reason", var_1);
  }

  self setclientomnvar("zm_ui_show_eog_score", 1);
}

func_DEB3() {
  if(isDefined(level.var_62D2)) {
    [[level.var_62D2]]();
    return;
  }

  func_DEAC();
}

func_DEAC() {
  level.end_game_string_index = [];
  level.end_game_string_index["win"] = 1;
  level.end_game_string_index["fail"] = 2;
  level.end_game_string_index["all_escape"] = 1;
  level.end_game_string_index["some_escape"] = 2;
  level.end_game_string_index["fail_escape"] = 3;
  level.end_game_string_index["kia"] = 4;
  level.end_game_string_index["host_end"] = 5;
}

func_7979(var_0) {
  return level.end_game_string_index[var_0];
}

func_E761(var_0, var_1) {
  var_2 = 0;
  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;
    foreach(var_5 in var_3) {
      if(!isDefined(var_5.var_58DD)) {
        continue;
      }

      if(!var_5 scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }

      var_2 = 0;
    }

    wait(0.5);
  }

  if(!var_1) {
    wait(var_0);
    level notify("round_end_finished");
    return;
  }

  wait(var_0 / 2);
  level notify("give_match_bonus");
  wait(var_0 / 2);
  var_2 = 0;
  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;
    foreach(var_5 in var_3) {
      if(!isDefined(var_5.var_58DD)) {
        continue;
      }

      if(!var_5 scripts\cp\cp_hud_message::isdoingsplash()) {
        continue;
      }

      var_2 = 0;
    }

    wait(0.5);
  }

  level notify("round_end_finished");
}