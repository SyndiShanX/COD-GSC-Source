/****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\maps\europa\europa_armory.gsc
****************************************************/

func_220C() {
  level.var_7464 = 1;
  func_96F2();
  precacheshader("icon_ks_sentry_gun_hud");
  precacheitem("iw7_jackal_support_designator");
  precachestring(&"EUROPA_FAILED_TO_ESCAPE");
  precachestring(&"EUROPA_FSPAR_SHOOT");
  scripts\sp\utility::func_16EB("fspar_switch", &"EUROPA_FSPAR_SWITCH");
  scripts\sp\utility::func_22C9("tram_enemy_spawner", ::func_D70D);
  scripts\sp\utility::func_22C9("tram_enemy_spawner_c6", ::func_D70E);
  scripts\sp\utility::func_22CA("lastroom_fleer_bridge", ::func_D710);
  scripts\sp\utility::func_22CA("lastroom_fleer", ::func_D710);
  scripts\sp\utility::func_9187("bfgtargeting", 10);
  scripts\engine\utility::trigger_off("tram_out_trigger", "script_noteworthy");
  scripts\engine\utility::trigger_off("initial_enemy_trigger", "script_noteworthy");
  scripts\engine\utility::trigger_off("self_destruct_triggers", "script_noteworthy");
  scripts\engine\utility::trigger_off("c12_fight_done_triggers", "script_noteworthy");
  var_0 = getEntArray("flood_spawn_count", "targetname");
  scripts\engine\utility::array_levelthread(var_0, ::func_6F55);
  scripts\engine\utility::flag_init("player_near_tram_console");
  scripts\engine\utility::flag_init("scar_near_tram_console");
  scripts\engine\utility::flag_init("goto_vault_door");
  scripts\engine\utility::flag_init("open_tram_door");
  scripts\engine\utility::flag_init("tram_intro_done");
  scripts\engine\utility::flag_init("open_room1_doors");
  scripts\engine\utility::flag_init("open_room2_doors");
  scripts\engine\utility::flag_init("open_room3_doors");
  scripts\engine\utility::flag_init("tram_move");
  scripts\engine\utility::flag_init("tram_assemble_pos");
  scripts\engine\utility::flag_init("initial_enemy_flood_dead");
  scripts\engine\utility::flag_init("last_call_before_fight");
  scripts\engine\utility::flag_init("selfdestruct_start");
  scripts\engine\utility::flag_init("selfdestruct_start");
  scripts\engine\utility::flag_init("selfdestruct_ready");
  scripts\engine\utility::flag_init("selfdestruct_in_range");
  scripts\engine\utility::flag_init("selfdestruct_anim_done");
  scripts\engine\utility::flag_init("pa_start");
  scripts\engine\utility::flag_init("pa_burn_active");
  scripts\engine\utility::flag_init("start_fallback");
  scripts\engine\utility::flag_init("c12_spawn");
  scripts\engine\utility::flag_init("c12_fight_done");
  scripts\engine\utility::flag_init("c12_dead");
  scripts\engine\utility::flag_init("c12_fight_done_tram_go");
  scripts\engine\utility::flag_init("enemy_flee");
  scripts\engine\utility::flag_init("kill_enemy_fleers");
  scripts\engine\utility::flag_init("player_can_use_bfg");
  scripts\engine\utility::flag_init("player_fired_bfg");
  scripts\engine\utility::flag_init("player_equipped_bfg");
  scripts\engine\utility::flag_init("start_decompress_player");
  scripts\engine\utility::flag_init("player_decompressed");
  scripts\engine\utility::flag_init("player_holding_on");
  scripts\engine\utility::flag_init("safe_to_decompress_player");
  scripts\engine\utility::flag_init("dragon_empty");
  scripts\engine\utility::flag_init("player_on_fspar");
  scripts\engine\utility::flag_init("fspar_event_complete");
  scripts\engine\utility::flag_init("fspar_ready");
  scripts\engine\utility::flag_init("final_stand_moveup");
  scripts\engine\utility::flag_init("final_stand_moveup_again");
  scripts\engine\utility::flag_init("fspar_done_firing");
  scripts\engine\utility::flag_init("armory_lookdown");
  scripts\engine\utility::flag_init("scar1_moveto_fspar");
  scripts\engine\utility::flag_init("new_decompress_anim");
  scripts\engine\utility::flag_init("pause_destruction_explosions");
  scripts\engine\utility::flag_init("middle_c12_approach");
  scripts\engine\utility::flag_init("console_nags");
  scripts\engine\utility::flag_init("fspar_prefire");
  scripts\engine\utility::flag_init("self_destruct_timer_active");
  scripts\engine\utility::flag_init("self_destruction_start");
  scripts\engine\utility::flag_init("no_c12_death_save");
  level.player scripts\sp\utility::func_65E0("c12_door_visible");
  if(func_9CD5("outro")) {
    func_11B3F();
  }

  scripts\sp\maps\europa\europa_util::func_95E7(1);
}

func_96F2() {
  var_0 = ["armory_doors", "room1_doors", "room2_doors", "room3_doors"];
  foreach(var_2 in var_0) {
    setumbraportalstate(var_2, 0);
  }
}

func_5F16() {
  wait(2);
  var_0 = level.var_EBBB;
  var_0.objective_playermask_showto = 32;
  for(;;) {
    if(level.player usebuttonpressed()) {
      var_1 = func_11A7E();
      if(isDefined(var_1)) {
        var_0 give_mp_super_weapon(var_1);
      }

      wait(0.5);
    }

    wait(0.05);
  }
}

func_11A7E() {
  var_0 = level.player getEye();
  var_1 = anglesToForward(level.player getplayerangles());
  var_0 = var_0 + var_1 * 30;
  var_2 = var_0 + var_1 * 10000;
  var_3 = bulletTrace(var_0, var_2, 1);
  var_4 = var_3["position"];
  if(distance(var_3["position"], var_4) < 0.1) {
    return var_4;
  }

  return undefined;
}

func_9531() {
  if(isDefined(level.var_220A)) {
    return;
  }

  level.var_220A = 1;
  scripts\engine\utility::array_thread(getEntArray("airlock_fan_02", "targetname"), ::func_6B81);
  setsaveddvar("sm_sunSampleSizeNear", 1);
  func_95B6("armory_doors");
  thread func_7558();
  thread func_75D7();
  thread func_75D8();
  thread func_7572();
  thread func_1B20();
}

func_6B81() {
  self endon("death");
  var_0 = randomfloatrange(2, 10);
  for(;;) {
    self rotatepitch(90, var_0);
    wait(var_0);
  }
}

func_224A() {
  var_0 = getEntArray("extra_corridor_klaxon_light", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::func_A6ED);
  scripts\sp\maps\europa\europa_util::func_107C5();
  scripts\sp\utility::func_F5AF("armory_start_point", [level.var_EBBB, level.var_EBBC, level.player]);
  scripts\engine\utility::array_thread(level.var_EBCA, scripts\sp\utility::func_DC45, "raise");
  thread scripts\sp\maps\europa\europa_util::func_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::func_67B6(2, "current", &"EUROPA_OBJECTIVE_FSPAR", "tram_move");
}

func_21A4() {
  scripts\engine\utility::flag_wait("player_entering_armory");
  func_9531();
  if(isDefined(level.var_4074) && isDefined(level.var_4074["locker_c6s"])) {
    scripts\sp\utility::func_4075("locker_c6s");
  }

  scripts\sp\utility::func_28D8("axis");
  scripts\engine\utility::array_thread(level.var_EBCA, scripts\sp\utility::func_54F7);
  thread func_21DF();
  scripts\sp\maps\europa\europa_util::func_6244(1);
}

func_21DF() {
  wait(1);
  scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_allclear3");
  scripts\sp\maps\europa\europa_util::func_134B7("europa_sip_jackpotgoteyeson");
  scripts\engine\utility::flag_set("goto_vault_door");
}

func_21CC() {
  setsuncolorandintensity(0.784314, 0.937255, 1, 2);
  if(level.var_10CDA == "outro") {
    return;
  }

  func_9531();
  scripts\sp\maps\europa\europa_util::func_6244(1);
  scripts\engine\utility::flag_set("goto_vault_door");
  scripts\sp\utility::func_28D8("axis");
}

func_7392() {
  var_0 = getnodearray("tram_friendly_path", "targetname");
  var_0 = sortbydistance(var_0, level.var_EBBB.origin);
  level.var_EBBB thread func_11B3C(var_0[0]);
  level.var_EBBC thread func_11B3C(var_0[1]);
}

func_11B41() {
  var_0 = getnodearray("initial_battle_node", "script_noteworthy");
  var_0 = sortbydistance(var_0, level.var_EBBB.origin);
  level.var_EBBB give_more_perk(var_0[0]);
  level.var_EBBC give_more_perk(var_0[1]);
  scripts\engine\utility::flag_set("initial_enemy_flood_dead");
}

func_1353A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = 1;
  var_3 = getent(var_0, "targetname");
  for(;;) {
    var_4 = getaiarray("axis");
    var_5 = 0;
    var_6 = [];
    foreach(var_8 in var_4) {
      if(!isalive(var_8) || var_8 scripts\sp\utility::func_58DA()) {
        continue;
      }

      if(var_8 istouching(var_3)) {
        var_5 = 1;
        if(!var_2) {
          break;
        }

        var_6[var_6.size] = var_8;
      }
    }

    if(var_6.size < 4) {
      foreach(var_8 in var_6) {
        if(!isDefined(var_8.var_91EF)) {
          var_8 notify("stop_going_to_node");
          var_8 thread func_91E5();
        }
      }
    }

    var_0C = 0;
    if(!var_5) {
      if(var_1) {
        var_0D = getEntArray(var_3.target, "targetname");
        foreach(var_0F in var_0D) {
          if(!isspawner(var_0F)) {
            continue;
          }

          if(var_0F.var_C1 > 0) {
            var_0C = 1;
            break;
          }
        }
      }

      if(!var_0C) {
        break;
      }
    }

    wait(0.1);
  }
}

func_91E5() {
  self endon("death");
  self endon("stop_hunt");
  self.var_91EF = 1;
  var_0 = 300;
  var_1 = distance(self.origin, level.player.origin);
  for(;;) {
    wait(2);
    self.objective_playermask_showto = var_1;
    var_1 = var_1 - 175;
    self setgoalentity(level.player);
    if(var_1 < var_0) {
      return;
    }
  }
}

func_2891() {
  var_0 = getEntArray("extra_corridor_klaxon_light", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::func_A6ED);
  scripts\sp\maps\europa\europa_util::func_107C5();
  scripts\engine\utility::delaythread(0.1, scripts\sp\utility::func_F5AF, "selfdestruct_start_point", [level.var_EBBB, level.var_EBBC, level.player]);
  level.var_11B30.var_10DDB = 2000;
  scripts\engine\utility::array_thread(level.var_EBCA, scripts\sp\utility::func_DC45, "raise");
  thread scripts\sp\maps\europa\europa_util::func_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::func_67B6(2, "done", &"EUROPA_OBJECTIVE_FSPAR");
  thread scripts\sp\maps\europa\europa_util::func_67B6(3, "current", &"EUROPA_OBJECTIVE_ESCAPE");
}

func_288C() {
  if(isDefined(level.var_4074) && isDefined(level.var_4074["office_fight"])) {
    scripts\sp\utility::func_4074("office_fight");
  }

  var_0 = getnode("console_node_sipes", "targetname");
  level.var_EBBB thread lib_0B77::worldpointinreticle_circle(var_0);
  var_0 = getnode("console_node_t", "targetname");
  level.var_EBBC thread lib_0B77::worldpointinreticle_circle(var_0);
  scripts\engine\utility::flag_wait("goto_vault_door");
  thread func_288F();
  scripts\engine\utility::flag_wait("selfdestruct_ready");
  var_1 = getent("selfdestruct_console_trigger", "targetname");
  var_2 = scripts\engine\utility::getstruct("console_self_destruct", "targetname");
  var_2 lib_0E46::func_48C4(undefined, undefined, undefined, undefined, 5000, 120, 0);
  var_1 waittill("trigger");
  scripts\engine\utility::flag_set("selfdestruct_in_range");
  scripts\engine\utility::array_thread(level.var_EBCA, ::func_1C38, 0);
  var_2 waittill("trigger");
  if(isDefined(level.var_11B30.var_10DDB)) {
    level.var_11B30.var_10DDB = undefined;
  }

  func_288E();
  scripts\engine\utility::array_thread(level.var_EBCA, ::func_1C38, 1);
  var_3 = getEntArray("tram_out_trigger", "script_noteworthy");
  scripts\engine\utility::array_thread(var_3, scripts\engine\utility::trigger_on);
  scripts\sp\utility::func_2669("post_give_steeldragon");
  thread func_C856();
  scripts\engine\utility::flag_wait("tram_intro_done");
  wait(2);
  level.player scripts\sp\utility::func_D090("ges_radio");
  level.player getnumownedagentsonteambytype(0);
  scripts\sp\utility::func_1034D("europa_plr_weremovinoutconfirmi");
  level.player stopgestureviewmodel("ges_radio", 1);
  level.player getnumownedagentsonteambytype(1);
  wait(0.15);
  scripts\sp\utility::func_10350("europa_rpr_initiatingdestruct");
  wait(1);
  thread alarm_lights_on();
  thread func_A6EF();
  thread func_2874();
  scripts\sp\utility::func_10350("europa_rpr_confirmedyouaregofor");
  wait(0.1);
  scripts\engine\utility::flag_set("last_call_before_fight");
  level.player scripts\sp\utility::func_D090("ges_radio");
  level.player getnumownedagentsonteambytype(0);
  scripts\sp\utility::func_1034D("europa_plr_copywereoscarmiker");
  level.player stopgestureviewmodel("ges_radio", 1);
  level.player getnumownedagentsonteambytype(1);
  wait(0.1);
  scripts\sp\utility::func_1034D("europa_plr_clocksticking");
  wait(0.3);
  thread func_C84D("europa_pas_allpersonnel");
  wait(0.1);
  scripts\engine\utility::flag_set("selfdestruct_start");
  wait(0.1);
  scripts\engine\utility::flag_set("pa_start");
  wait(1.5);
  thread func_7392();
  wait(2);
  scripts\engine\utility::flag_set("open_room1_doors");
  scripts\sp\utility::func_22CD("tram_initial_enemies", 1);
  scripts\engine\utility::trigger_on("self_destruct_triggers", "script_noteworthy");
  scripts\engine\utility::delaythread(2, ::armory_battlechatter);
  if(level.var_7683 > 1) {
    switch (level.var_7683) {
      case 2:
        thread start_self_destruct_timer(80);
        break;

      case 3:
      default:
        thread start_self_destruct_timer(60);
        break;
    }
  }

  thread func_537D("armory_entry_explosion", 7);
  level.var_362B = spawnStruct();
  lib_0A05::func_35A8(getEntArray("steeldragon_pickup", "targetname"), level.var_362B, &"hud_interaction_prompt_center_steel_dragon", undefined, 1);
}

func_10216() {
  scripts\engine\utility::flag_wait("sipes_mount_fspar");
  wait(2.5);
  var_0 = getent("tram_interact", "script_noteworthy");
  level.var_EBBB linkto(var_0);
  var_0 scripts\sp\anim::func_1F35(level.var_EBBB, "fspar_boot_intro");
  var_0 thread scripts\sp\anim::func_1EEA(level.var_EBBB, "fspar_boot_idle");
  thread scripts\engine\utility::flag_set_delayed("selfdestruct_anim_done", 1.2);
  scripts\engine\utility::flag_wait("last_call_before_fight");
  thread func_10215();
  thread func_746D();
  var_0 notify("stop_loop");
  var_0 thread scripts\sp\anim::func_1F35(level.var_EBBB, "fspar_boot_exit");
  level.var_EBBB unlink();
}

func_746D() {
  playFXOnTag(scripts\engine\utility::getfx("fspar_light_red"), level.var_11B30.var_1021B, "tag_origin");
}

func_746C() {
  stopFXOnTag(scripts\engine\utility::getfx("fspar_light_red"), level.var_11B30.var_1021B, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("fspar_light_green"), level.var_11B30.var_1021B, "tag_origin");
}

func_288E() {
  var_0 = 0.4;
  level.player.var_E505 = scripts\sp\player_rig::get_player_score(1);
  level.player.var_E505 hide();
  level.player func_84FE();
  var_1 = getent("selfdestruct_console", "targetname");
  var_1.var_1FBB = "selfdestruct_console";
  var_1 scripts\sp\anim::func_F64A();
  scripts\engine\utility::flag_set("tram_move");
  var_2 = [level.player.var_E505, level.var_EBBC, var_1];
  thread func_4543();
  thread func_10216();
  thread func_115F9();
  var_1 thread scripts\sp\anim::func_1F2C(var_2, "selfdestruct");
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player disableusability();
  level.player getradiuspathsighttestnodes();
  level.player playerlinktoblend(level.player.var_E505, "tag_player", var_0);
  wait(var_0);
  level.player playerlinktodelta(level.player.var_E505, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(1.5, ::lerpviewangleclamp, 2, 0, 0, 3, 20, 30, 5);
  level.player.var_E505 show();
  level.player.var_E505 waittillmatch("end", "single anim");
  level.player.var_E505 delete();
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player enableusability();
  level.player enableweapons();
  level.player func_84FD();
}

func_1C38(var_0) {
  if(var_0) {
    self.var_1C78 = undefined;
    return;
  }

  self.var_1C78 = 0;
}

func_115F9() {
  wait(5);
  var_0 = getnode("tee_after_handoff", "script_noteworthy");
  while(level.var_EBBC func_81A6()) {
    wait(0.05);
  }

  level.var_EBBC give_more_perk(var_0);
}

func_10215() {
  var_0 = getnode("sipes_after_handoff", "script_noteworthy");
  while(level.var_EBBB func_81A6()) {
    wait(0.05);
  }

  level.var_EBBB give_more_perk(var_0);
}

func_4543() {
  level.player func_81DE(55, 2);
  level waittill("dof_change");
  scripts\sp\art::func_583F(0, 194, 3, 100, 490, 3.2, 1.2);
  level waittill("dof_change");
  scripts\sp\art::func_583F(0, 0, 0, 68.1, 76.7, 1, 0.5);
  level waittill("dof_change");
  scripts\sp\art::func_583F(0, 0, 0, 0, 128.1, 2.6, 0.1);
  wait(1);
  level.player func_81DE(65, 0.25);
  scripts\sp\art::func_583D(0.05);
}

func_C856() {
  scripts\engine\utility::flag_wait("pa_start");
  if(func_9CD5("c12")) {
    func_C84D("europa_pas_evacuateimme");
    wait(1);
    func_C84D("europa_pas_emergencyyou");
    wait(2);
  }

  var_0 = [];
  var_0[var_0.size] = ["europa_pas_allpersonnel"];
  var_0[var_0.size] = ["europa_pas_evacuateimme"];
  var_0[var_0.size] = ["europa_pas_thisisnotadrill", "europa_pas_immediateevac2"];
  var_0[var_0.size] = ["europa_pas_proceedtothe"];
  func_C84B(var_0, "player_in_room1");
  scripts\engine\utility::flag_set("pa_burn_active");
  var_0 = [];
  var_0[var_0.size] = ["europa_pas_attentionopen", "europa_pas_proceedtothe"];
  var_0[var_0.size] = ["europa_pas_dangerburnsyst", "europa_pas_immediateevac1"];
  func_C84B(var_0, "c12_fight_done");
  func_C84D("europa_pas_warningcodered");
  func_C84D("europa_pas_dangerselfdestruct1");
  var_0 = [];
  var_0[var_0.size] = ["europa_pas_emergencyself"];
  var_0[var_0.size] = ["europa_pas_attentionopen", "europa_pas_evacuateimme"];
  var_0[var_0.size] = ["europa_pas_thisisnotadrill", "europa_pas_immediateevac2"];
  var_0[var_0.size] = ["europa_pas_dangerburnsyst", "europa_pas_proceedtothe"];
  var_0[var_0.size] = ["europa_pas_dangeropenburn", "europa_pas_immediateevac1"];
  var_0[var_0.size] = ["europa_pas_dangerthiszone", "europa_pas_proceedtothe"];
  func_C84B(var_0, "fspar_done_firing");
}

func_C850(var_0, var_1) {
  scripts\sp\utility::func_74D7(::func_C84D, var_0, var_1);
}

func_C84B(var_0, var_1) {
  for(;;) {
    if(func_C854(var_1)) {
      break;
    }

    var_0 = scripts\engine\utility::array_randomize(var_0);
    foreach(var_3 in var_0) {
      if(func_C854(var_1)) {
        break;
      }

      foreach(var_5 in var_3) {
        if(func_C854(var_1)) {
          break;
        }

        func_C84D(var_5, var_1);
      }

      wait(randomfloatrange(5, 9));
    }
  }
}

func_C854(var_0) {
  if(isDefined(var_0)) {
    return scripts\engine\utility::flag(var_0);
  }

  return 0;
}

func_C84D(var_0, var_1) {
  if(func_C854(var_1)) {
    return;
  }

  if(!isDefined(level.var_C845)) {
    level.var_C845 = spawnStruct();
    level.var_C845.is_playing = 0;
    level.var_C845.speakers = [];
    level.var_C845.speakers[0] = spawn("script_origin", (0, 0, 0));
    level.var_C845.speakers[1] = spawn("script_origin", (0, 0, 0));
    level.var_C845.speakers[1].var_5709 = 1;
  }

  while(level.var_C845.is_playing > 0) {
    wait(0.05);
  }

  level.var_C845.speakers[0] thread func_C84E(var_0);
  var_2 = scripts\engine\utility::getstructarray("pa_speaker", "targetname");
  while(level.var_C845.is_playing) {
    var_2 = sortbydistance(var_2, level.player.origin);
    foreach(var_6, var_4 in level.var_C845.speakers) {
      var_5 = var_6;
      if(var_5 == 0) {
        var_4.origin = var_2[var_6].origin;
        continue;
      }

      if(distance2dsquared(var_2[0].origin, var_2[var_5].origin) < 490000) {
        var_5++;
      }
    }

    wait(0.1);
  }
}

func_C84E(var_0) {
  if(isDefined(self.var_5709)) {
    wait(0.3);
  }

  level.var_C845.is_playing++;
  self playSound(var_0, "sound_done");
  self waittill("sound_done");
  wait(0.1);
  level.var_C845.is_playing--;
}

func_C846() {
  scripts\engine\utility::array_call(level.var_C849, ::delete);
  level.var_C849 = undefined;
}

func_288F() {
  level.player endon("death");
  level.player scripts\sp\utility::func_D090("ges_radio");
  level.player getnumownedagentsonteambytype(0);
  scripts\sp\utility::func_1034D("europa_plr_reaperwereatthe");
  level.player stopgestureviewmodel("ges_radio", 1);
  level.player getnumownedagentsonteambytype(1);
  scripts\engine\utility::flag_set("selfdestruct_ready");
  scripts\sp\utility::func_10350("europa_rpr_copythatpackageis");
  if(!scripts\engine\utility::flag("tram_move")) {
    scripts\sp\maps\europa\europa_util::func_134B7("europa_tee_weaponsbehind");
  }

  var_0[0] = [level.var_EBBB, "europa_sip_overherewolf"];
  var_0[1] = [level.var_EBBB, "europa_sip_terminalssetrighth"];
  var_0[2] = [level.var_EBBC, "europa_tee_consolesreadywolf"];
  thread scripts\sp\maps\europa\europa_util::func_BE3C(var_0, "selfdestruct_in_range");
}

armory_battlechatter() {
  scripts\sp\utility::func_1034D("europa_plr_gohot");
  wait(1);
  thread func_B784();
}

func_288D() {
  scripts\engine\utility::flag_set("tram_move");
  scripts\engine\utility::flag_set("open_armory_doors");
  scripts\engine\utility::flag_set("open_room1_doors");
  scripts\engine\utility::flag_set("pa_start");
  if(func_9CD5("outro")) {
    thread scripts\sp\maps\europa\europa_anim::func_F2DF("idle");
  }

  scripts\engine\utility::flag_set("selfdestruct_start");
  thread func_2874();
  scripts\sp\maps\europa\europa_util::func_117FF();
  level.player giveweapon("iw7_steeldragon+europaspeedmod");
  level.player switchtoweaponimmediate("iw7_steeldragon+europaspeedmod");
  if(func_9CD5("outro")) {
    scripts\engine\utility::delaythread(3, ::func_7392);
    scripts\engine\utility::trigger_on("self_destruct_triggers", "script_noteworthy");
    thread func_C856();
  }

  if(func_9CD5("decompression")) {
    level.var_362B = spawnStruct();
    lib_0A05::func_35A8(getEntArray("steeldragon_pickup", "targetname"), level.var_362B, &"hud_interaction_prompt_center_steel_dragon", undefined, 1);
  }
}

func_B784() {
  level endon("c12_spawn");
  level.var_B78A = spawnStruct();
  level.var_B78A.var_BFB3 = gettime() + 2000;
  level.var_B78A.var_29B5 = [];
  level.var_B78A.var_D3CA = 0;
  level.var_B78A.lastkilltime = -100000;
  level childthread func_299F();
  var_0 = [];
  var_0[0] = [level.player, "europa_plr_getgunsonem"];
  var_0[1] = [level.player, "europa_plr_smokeem"];
  func_1710(var_0, 15, 30, ::func_299E);
  var_0 = [];
  var_0[0] = [level.var_EBBB, "europa_sip_eyeshigh"];
  var_0[1] = [level.var_EBBB, "europa_sip_tangosonthecatw"];
  var_0[2] = [level.var_EBBC, "europa_tee_hostilesuptop"];
  var_0[3] = [level.var_EBBC, "europa_tee_watchthecatwalk"];
  func_1710(var_0, 13, 22, ::func_2999, 0);
  var_0 = [];
  var_0[0] = [level.var_EBBB, "europa_sip_wegottadoubletim"];
  var_0[1] = [level.var_EBBC, "europa_tee_blastsaregettingclose"];
  func_1710(var_0, 8, 16, ::func_299C);
  var_0 = [];
  var_0[0] = [level.var_EBBC, "europa_tee_goodheatwolf"];
  func_1710(var_0, 15, 25, ::func_299B);
  var_0 = undefined;
  for(;;) {
    wait(0.05);
    if(gettime() < level.var_B78A.var_BFB3) {
      continue;
    }

    foreach(var_2 in level.var_B78A.var_29B5) {
      if(gettime() < var_2.var_BFB3) {
        continue;
      }

      if(var_2[[var_2.func]]()) {
        level.var_B78A.var_BFB3 = gettime() + randomfloatrange(2000, 4000);
        break;
      }
    }
  }
}

func_299F() {
  level.player endon("death");
  for(;;) {
    level waittill("ai_killed", var_0, var_1, var_2, var_3);
    if(isDefined(var_0) && var_0.team != "axis") {
      continue;
    }

    if(!isDefined(var_1)) {
      continue;
    }

    if(var_1 != level.player) {
      continue;
    }

    level.var_B78A.var_D3CA++;
    level.var_B78A.lastkilltime = gettime();
  }
}

func_299E() {
  var_0 = getaiarray("axis");
  var_1 = 0;
  foreach(var_3 in var_0) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_3.origin, 0.8)) {
      if(bullettracepassed(level.player getEye(), var_3.origin, 0, level.player)) {
        var_1 = 1;
        break;
      }
    }
  }

  if(!var_1) {
    func_F2DD(1, 3);
    return 0;
  }

  func_EB80();
  return 1;
}

func_29A0() {
  func_EB80();
  self.var_B759 = self.var_B759 + 5;
  self.var_B48D = self.var_B48D + 5;
  func_F2DD();
  return 1;
}

func_2999() {
  if(!isDefined(self.var_13540)) {
    self.var_13540 = getEntArray("catwalk_volume", "targetname");
  }

  var_0 = 0;
  var_1 = getaiarray("axis");
  foreach(var_3 in self.var_13540) {
    if(var_3.script_noteworthy == "catwalk_volume" && !scripts\engine\utility::flag("player_in_room1")) {
      continue;
    }

    foreach(var_5 in var_1) {
      if(var_5 istouching(var_3)) {
        var_0 = 1;
        break;
      }
    }

    if(var_0) {
      break;
    }
  }

  if(var_0) {
    func_EB80();
    return 1;
  }

  return 0;
}

func_299C() {
  func_EB80();
  return 1;
}

func_299B() {
  if(gettime() - level.var_B78A.lastkilltime > 500) {
    return 0;
  }

  if(level.player getcurrentweapon() != "iw7_steeldragon+europaspeedmod") {
    return 0;
  }

  func_EB80();
  return 1;
}

func_EB80() {
  var_0 = scripts\engine\utility::random(self.var_1B4A);
  if(isplayer(var_0[0])) {
    scripts\sp\utility::func_1034D(var_0[1]);
  } else {
    var_0[0] scripts\sp\utility::func_10346(var_0[1]);
  }

  func_F2DD();
}

func_1710(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.var_1B4A = var_0;
  var_5.var_B759 = var_1;
  var_5.var_B48D = var_2;
  var_5.func = var_3;
  var_5.var_BFB3 = 0;
  if(!isDefined(var_4)) {
    var_5 func_F2DD();
  }

  level.var_B78A.var_29B5[level.var_B78A.var_29B5.size] = var_5;
}

func_F2DD(var_0, var_1) {
  if(isDefined(var_0)) {
    self.var_BFB3 = gettime() + randomfloatrange(var_0, var_1) * 1000;
    return;
  }

  self.var_BFB3 = gettime() + randomfloatrange(self.var_B759, self.var_B48D) * 1000;
}

func_3568() {
  scripts\sp\maps\europa\europa_util::func_107C5();
  scripts\sp\utility::func_F5AF("c12_fight_start_point", [level.var_EBBB, level.var_EBBC, level.player]);
  level.var_11B30.var_10DDB = 1000;
  scripts\engine\utility::array_thread(level.var_EBCA, scripts\sp\utility::func_DC45, "raise");
  thread func_B784();
  scripts\sp\utility::func_22CD("tram_initial_enemies", 1);
  thread scripts\sp\utility::func_1034D("europa_plr_letsgetitout");
  setmusicstate("mx_172_misslefight");
  thread scripts\sp\maps\europa\europa_util::func_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::func_67B6(2, "done", &"EUROPA_OBJECTIVE_FSPAR");
  thread scripts\sp\maps\europa\europa_util::func_67B6(3, "current", &"EUROPA_OBJECTIVE_ESCAPE");
  thread func_746D();
}

func_355E() {
  scripts\engine\utility::flag_set("c12_dead");
  scripts\engine\utility::flag_set("c12_fight_done");
  scripts\engine\utility::flag_set("open_room2_doors");
  scripts\engine\utility::flag_set("c12_fight_done_tram_go");
  if(isDefined(level.var_11B30)) {
    level.var_11B30.var_BCD2 = --15536;
  }

  scripts\engine\utility::trigger_on("c12_fight_done_triggers", "script_noteworthy");
  func_2873(3, 7, 1500, 2500);
  thread func_E6D3();
  if(isDefined(level.var_11B30)) {
    level.var_11B30 func_11B4F(100, 1);
  }
}

func_355D() {
  thread func_10C48(17);
  scripts\engine\utility::flag_wait("player_in_room1");
  var_0 = getEntArray("armory_middle_traverse", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 getrallyvehiclespawndata();
  }

  thread func_47EC();
  if(isDefined(level.var_11B30.var_10DDB)) {
    level.var_11B30.var_10DDB = undefined;
  }

  thread func_6476();
  thread func_35B4();
  thread func_353D();
  scripts\engine\utility::flag_wait("c12_spawn");
  setmusicstate("mx_172_misslefight");
  var_4 = scripts\sp\utility::func_107EA("c12_spawner", 1);
  level.var_3508 = var_4;
  var_4.var_1FBB = "c12";
  thread func_3536();
  thread func_359A();
  thread func_361F();
  thread func_35E1();
  level.var_362B.var_3508 = var_4;
  var_4 func_35B5();
  thread func_3621();
  thread func_3575();
  var_4 lib_0A05::func_3554();
  var_5 = 4;
  var_4 scripts\engine\utility::delaythread(var_5, lib_0A05::func_3551, 1);
  var_4 lib_0A05::func_3540();
  var_4 lib_0A05::func_3552(0);
  var_6 = getnode(var_4.target, "targetname");
  while(isDefined(var_6.target)) {
    var_6 = getnode(var_6.target, "targetname");
  }

  var_4.og_goalradius = 2048;
  var_4.og_goalpos = var_6.origin;
  var_7 = getEntArray("player_exposed_trig", "targetname");
  scripts\engine\utility::array_thread(var_7, ::c12_player_exposed_think, var_5);
  var_4 thread func_35FE();
  if(isalive(var_4)) {
    var_4 waittill("death");
  }

  level.var_11B30 func_11B4F(100, 1);
  scripts\engine\utility::flag_set("c12_fight_done");
  thread restore_c12_fight_trigs();
  foreach(var_9 in level.var_EBCA) {
    var_9 scripts\sp\utility::func_4145();
  }

  func_7392();
  if(!scripts\engine\utility::flag("no_c12_death_save")) {
    scripts\sp\utility::func_2669("c12_is_dead");
  }

  wait(3);
  scripts\engine\utility::flag_set("c12_fight_done_tram_go");
  level.var_11B30.var_BCD2 = --15536;
  thread func_E6D2();
}

restore_c12_fight_trigs() {
  var_0 = getEntArray("c12_fight_done_triggers", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.var_ED9A) && var_2.var_ED9A == "close_room1_doors") {
      var_2 thread trigger_on_when_tram_is_clear();
      continue;
    }

    var_2 scripts\engine\utility::trigger_on();
  }
}

trigger_on_when_tram_is_clear() {
  while(!is_tram_in_c12_room()) {
    wait(0.05);
  }

  scripts\engine\utility::trigger_on();
}

is_tram_in_c12_room() {
  var_0 = getent("c12_room_middle", "targetname");
  if(isDefined(level.var_11B30)) {
    return level.var_11B30.var_32D9 istouching(var_0);
  }
}

func_35B4() {
  level.player endon("death");
  var_0 = 25;
  var_1 = gettime() + var_0 * 1000;
  var_2 = 0;
  var_3 = 20;
  var_4 = scripts\engine\utility::getstruct("c12_lookat", "targetname");
  wait(7);
  while(gettime() < var_1) {
    var_5 = distance2dsquared(level.player.origin, var_4.origin) < squared(750);
    if(func_D284(var_5)) {
      var_2++;
    } else {
      var_2--;
      var_2 = int(max(0, var_2));
    }

    if(var_2 == var_3) {
      level.player scripts\sp\utility::func_65E1("c12_door_visible");
      break;
    }

    wait(0.05);
  }

  level.player scripts\sp\utility::func_65E8("player_has_red_flashing_overlay");
  scripts\engine\utility::flag_set("c12_spawn");
  scripts\engine\utility::flag_set("open_room2_doors");
  thread func_A5D9();
}

func_D284(var_0) {
  var_1 = scripts\engine\utility::getstruct("c12_lookat", "targetname");
  var_2 = 0.88;
  var_3 = vectornormalize(var_1.origin - level.player getEye());
  var_4 = level.player getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = 0;
  var_7 = vectordot(var_5, var_3);
  if(var_7 >= var_2) {
    if(var_0) {
      return scripts\common\trace::ray_trace_passed(level.player getEye(), var_1.origin, level.player);
    } else {
      return 1;
    }
  }

  return 0;
}

func_10C48(var_0) {
  scripts\engine\utility::flag_wait_or_timeout("c12_spawn", var_0);
  scripts\engine\utility::flag_set("start_fallback");
}

c12_player_exposed_think(var_0) {
  level.var_3508 endon("death");
  level.player endon("death");
  var_1 = level.var_3508;
  wait(var_0 + 0.05);
  for(;;) {
    if(!level.player istouching(self)) {
      self waittill("trigger");
    }

    if(!isDefined(level.player_exposed_trigger_count)) {
      level.player_exposed_trigger_count = 0;
    }

    level.player_exposed_trigger_count++;
    var_2 = scripts\engine\utility::getstruct(self.target, "targetname");
    var_1 lib_0A05::func_3551(0);
    var_1.objective_playermask_showto = var_2.fgetarg;
    var_1 give_mp_super_weapon(getclosestpointonnavmesh(var_2.origin, var_1));
    var_1 lib_0A05::func_360D("left", level.player);
    var_1 lib_0A05::func_360D("right", level.player);
    while(level.player istouching(self)) {
      wait(0.05);
    }

    level.player_exposed_trigger_count--;
    if(level.player_exposed_trigger_count == 0) {
      var_1 lib_0A05::func_352D("left");
      var_1 lib_0A05::func_352D("right");
      var_1.objective_playermask_showto = var_1.og_goalradius;
      var_1 give_mp_super_weapon(var_1.og_goalpos);
      var_1 lib_0A05::func_3551(1);
    }
  }
}

func_3621() {
  level.var_3508 endon("death");
  level.var_3508 endon("begin_rodeo");
  level.player endon("death");
  var_0 = 15000;
  for(;;) {
    while(!func_3614()) {
      wait(0.05);
    }

    var_1 = gettime() + var_0;
    var_2 = level.player func_8519(level.player getcurrentweapon());
    var_3 = 0;
    var_4 = 3;
    while(func_3614()) {
      if(level.player func_8519(level.player getcurrentweapon()) != var_2) {
        var_2 = !var_2;
        var_3++;
      }

      if(gettime() >= var_1 || var_3 >= var_4) {
        scripts\sp\utility::func_56BE("fspar_switch", 5);
        wait(5);
        var_1 = gettime() + var_0;
        var_3 = 0;
      }

      wait(0.05);
    }
  }
}

func_3614() {
  var_0 = "iw7_steeldragon+europaspeedmod";
  if(!level.player hasweapon(var_0)) {
    return 0;
  }

  if(level.player getcurrentweapon() == var_0) {
    return 0;
  }

  if(level.player getweaponammoclip(var_0) + level.player getweaponammostock(var_0) == 0) {
    return 0;
  }

  if(!level.console && !level.player usinggamepad()) {
    return 0;
  }

  return 1;
}

func_47EC() {
  scripts\engine\utility::flag_wait("pa_burn_active");
  scripts\engine\utility::flag_set("enemy_flee");
  thread func_E6D0();
}

func_2872(var_0) {
  var_1 = newhudelem();
  var_1.x = 0;
  var_1.y = 50;
  var_1.fontscale = 0.5;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "top";
  var_1.hidewheninmenu = 0;
  var_1.playrumblelooponposition = 1;
  var_1.font = "objective";
  var_1.alpha = 0;
  var_1 settenthstimer(var_0);
  var_1 fadeovertime(2.5);
  var_1.alpha = 1;
  var_1 changefontscaleovertime(0.2);
  var_1.fontscale = 2.7;
  wait(0.2);
  var_1 changefontscaleovertime(0.1);
  var_1.fontscale = 2.5;
  level.var_46B2 = var_1;
  thread countdown_timer_flasher(var_0);
  scripts\engine\utility::flag_wait("decompress_blackout");
  var_1 destroy();
}

countdown_timer_flasher(var_0) {
  level.player endon("death");
  var_1 = var_0 * 1000;
  var_2 = gettime();
  var_3 = 0.5;
  var_4 = level.player scripts\engine\utility::spawn_script_origin();
  var_5 = "europa_armory_self_destruct_beep1";
  var_6 = (1, 1, 1);
  while(!scripts\engine\utility::flag("player_on_fspar")) {
    var_4 playSound(var_5);
    level.var_46B2.color = (1, 0.1, 0.1);
    level.var_46B2 fadeovertime(var_3);
    wait(var_3);
    level.var_46B2.color = var_6;
    level.var_46B2 fadeovertime(var_3);
    wait(var_3);
    var_7 = var_1 - gettime() - var_2;
    if(var_7 < 21000) {
      var_6 = (1, 0.75, 0.05);
      if(var_7 < 11000) {
        var_5 = "europa_armory_self_destruct_beep3";
        var_3 = 0.1;
        continue;
      }

      var_5 = "europa_armory_self_destruct_beep2";
      var_3 = 0.25;
    }
  }

  wait(1);
  var_4 delete();
}

func_E6D0() {
  func_2873(2, 5, 1500, 2500);
  wait(randomfloatrange(1, 2));
  func_537D("room1_airvent_explosion");
  wait(randomfloatrange(1, 3));
  func_537D("room1_console_explosions");
  thread func_E6D1();
}

func_E6D1() {
  level.player.var_8632 = spawn("script_origin", level.player.origin);
  level.player getwholescenedurationmin(level.player.var_8632);
  var_0 = 5;
  level.player.var_8632 rotateroll(5, var_0, var_0);
  var_1 = gettime() + var_0 * 1000;
  while(gettime() < var_1) {
    wait(0.05);
    func_F352();
  }

  physics_setgravity((0, 0, -386.09));
  level.player func_8251((0, 0, 0));
  var_0 = 0.25;
  level.player.var_8632 rotateto((0, 0, 0), var_0, var_0);
  screenshake(level.player.origin, 5, 1, 1, 1, 0, 1, 5000, 3, 2, 0);
}

func_E6D2() {
  level endon("fspar_prefire");
  scripts\sp\specialist_MAYBE::halt_specialist_hints();
  func_2873(0.5, 2.5, 500, 2500);
  childthread func_E6D3();
  childthread func_E6D4();
  wait(randomfloatrange(1, 3));
  func_537D("room2_airvent_explosion");
  wait(randomfloatrange(1, 3));
  func_537D("room2_closet_explosion");
}

func_E6D3() {
  if(level.var_10CDA == "outro") {
    return;
  }

  level.player.var_8632 = spawn("script_origin", level.player.origin);
  level.player getwholescenedurationmin(level.player.var_8632);
  var_0 = 15;
  level.player.var_8632 rotateroll(10, var_0, var_0);
  var_1 = gettime() + var_0 * 1000;
  while(!scripts\engine\utility::flag("start_decompress_player")) {
    wait(0.05);
    func_F352();
  }

  physics_setgravity((0, 0, -386.09));
}

func_E6D4() {
  while(!scripts\engine\utility::flag("start_decompress_player")) {
    var_0 = randomfloatrange(0.2, 1);
    var_0 = min(var_0, 1);
    var_1 = randomfloatrange(0.1, 0.5) * var_0;
    var_2 = randomfloatrange(0.2, 0.5) * var_0;
    var_3 = randomfloatrange(0.05, 0.2) * var_0;
    level.player func_8291(var_1, var_2, var_3, 0.2, 0, 0, 700, 10, 10, 10);
    wait(0.2);
  }
}

func_F352() {
  var_0 = level.player.var_8632.angles[2] * 5;
  var_1 = anglestoup(level.player.var_8632.angles + (0, 0, var_0));
  var_1 = var_1 * -300;
  physics_setgravity(var_1);
  var_2 = (var_1[0], var_1[1], 0) * 0.02;
  level.player func_8251(var_2);
}

func_A9E2() {
  var_0 = 5;
  level.player.var_8632 rotatepitch(20, var_0, var_0);
}

func_6476() {
  wait(1);
  var_0 = getEntArray("enemy_fleer", "targetname");
  var_1 = 2;
  var_2 = gettime() + 1500;
  while(var_1 > 0 && var_2 > gettime()) {
    var_3 = scripts\engine\utility::random(var_0);
    var_3.var_C1 = 1;
    var_4 = var_3 scripts\sp\utility::func_10619();
    if(isDefined(var_4)) {
      var_1--;
    }

    wait(randomfloatrange(0.25, 0.65));
  }
}

func_35B5() {
  func_35B6("head");
  func_35B6("right_arm");
  func_35B6("right_arm", "upper");
  func_35B6("right_arm", "lower");
  func_35B6("left_arm");
  func_35B6("left_arm", "upper");
  func_35B6("left_arm", "lower");
  func_35B6("right_leg");
  func_35B6("right_leg", "upper");
  func_35B6("right_leg", "lower");
  func_35B6("left_leg");
  func_35B6("left_leg", "upper");
  func_35B6("left_leg", "lower");
}

func_35B6(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = self func_850C(var_0, var_1);
  } else {
    var_2 = self func_850C(var_1);
  }

  self func_8550(var_0, var_1, var_2 * 0.6);
}

func_35FE() {
  var_0 = scripts\engine\utility::waittill_any_return("self_destruct", "death");
  if(var_0 == "death") {
    return;
  }

  level.player getrankinfofull(1);
  self waittill("death");
  thread func_363D();
  wait(0.1);
  level.player getrankinfofull(0);
}

func_353D() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("open_room2_doors");
  level.player setsoundsubmix("europa_c12_intro");
  wait(1);
  thread scripts\sp\utility::func_1034D("europa_plr_ohshit");
  wait(1);
  level.var_EBBB scripts\sp\utility::func_10346("europa_sip_c12");
  while(level.player func_819F()) {
    wait(0.05);
  }

  level.player clearsoundsubmix();
  scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_sipesgetthatf");
  wait(0.1);
  while(level.player func_819F()) {
    wait(0.05);
  }

  scripts\sp\maps\europa\europa_util::func_134B7("europa_sip_itsnotreadyyet");
  var_0 = ["europa_sip_fanoutwelldraw", "europa_sip_wellhavetosplit"];
  level.var_EBBB thread scripts\sp\utility::func_10346(scripts\engine\utility::random(var_0));
}

func_35E1() {
  level.var_3508 endon("death");
  level endon("stop_c12_reactive_dialogue");
  scripts\engine\utility::flag_wait("open_room2_doors");
  wait(4);
  level.var_3508 thread func_35E2("rocket_targeting", ["europa_tee_getouttathere", "europa_tee_rocketsgettocover"], level.var_EBBC);
  var_0 = [];
  var_0[0] = "europa_tee_wolfuseyourheavy";
  var_0[1] = "europa_tee_gethatheavyweapon";
  var_0[2] = "europa_tee_welldrawitsfire";
  var_1 = func_3530(var_0, 5000, 15000);
  var_0 = [];
  var_0[0] = "europa_tee_targethisarm";
  var_0[1] = "europa_tee_stayonitwolf";
  var_2 = func_3530(var_0, 3000, 7000);
  while(isalive(level.var_3508)) {
    wait(0.05);
    if(isDefined(level.var_35E1)) {
      var_3 = level.var_35E1.alias;
      var_4 = level.var_35E1.ent;
      level.var_35E1 = undefined;
      var_4 scripts\sp\utility::func_10346(var_3);
      continue;
    }

    if(func_35CE() && gettime() > var_1.var_BFB3) {
      var_5 = level.player getcurrentprimaryweapon();
      if(!weaponisbeam(var_5)) {
        level.var_EBBC func_35F6(var_1);
        continue;
      }

      var_1.var_BFB3 = var_1.var_BFB3 + 2000;
    }
  }
}

func_3530(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.var_BE40 = var_0;
  var_3.var_B759 = var_1;
  var_3.var_B48D = var_2;
  var_3.var_BFB3 = gettime() + randomintrange(var_1, var_2);
  var_3.var_A87F = "";
  return var_3;
}

func_35F6(var_0) {
  var_0.var_BFB3 = gettime() + randomintrange(var_0.var_B759, var_0.var_B48D);
  var_0.var_BE40 = scripts\engine\utility::array_randomize(var_0.var_BE40);
  var_1 = var_0.var_BE40[0];
  if(var_0.var_BE40.size > 1 && var_0.var_A87F == var_1) {
    var_1 = var_0.var_BE40[1];
  }

  var_0.var_A87F = var_1;
  scripts\sp\utility::func_10346(var_1);
}

func_35A9() {
  if(!isDefined(level.var_3508._blackboard.shootparams)) {
    return 0;
  }

  return level.var_3508 lib_0C08::func_9F7B("left");
}

func_350F() {
  if(func_782D() == 1) {
    return 1;
  }

  return 0;
}

func_782D() {
  var_0 = 0;
  if(level.var_3508 scripts\asm\asm_bb::ispartdismembered("right_arm")) {
    var_0++;
  }

  if(level.var_3508 scripts\asm\asm_bb::ispartdismembered("left_arm")) {
    var_0++;
  }

  return var_0;
}

func_35CE() {
  if(func_782D() == 0) {
    return 1;
  }

  return 0;
}

func_35E2(var_0, var_1, var_2) {
  self endon("death");
  for(;;) {
    self waittill(var_0);
    level.var_35E1 = spawnStruct();
    level.var_35E1.alias = scripts\engine\utility::random(var_1);
    level.var_35E1.ent = var_2;
    wait(randomfloatrange(8, 13));
  }
}

start_self_destruct_timer(var_0) {
  if(scripts\engine\utility::flag("self_destruct_timer_active")) {
    return;
  }

  scripts\engine\utility::flag_set("self_destruct_timer_active");
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = 61 + var_0;
  scripts\engine\utility::delaythread(var_1, ::func_D287);
  thread scripts\engine\utility::flag_set_delayed("no_c12_death_save", var_1 - 20.1);
  thread func_2872(var_1);
}

func_361F() {
  level endon("self_destruct_tiimer_active");
  while(isDefined(level.var_3508) && !isDefined(level.var_3508.var_30EA)) {
    wait(0.05);
  }

  if(isDefined(level.var_3508) && isDefined(level.var_3508.var_E601)) {
    while(isalive(level.var_3508)) {
      wait(0.05);
    }
  }

  thread start_self_destruct_timer(4);
}

func_35F0() {
  if(isDefined(level.var_3508.var_30E8) && !level.var_3508.var_30E8) {
    return;
  }

  level.var_3508 endon("death");
  level.var_3508 waittill("begin_rodeo");
  level notify("stop_c12_reactive_dialogue");
  wait(0.6);
  scripts\sp\utility::func_1034D("europa_plr_gotitfireinthehole");
}

func_359A() {
  level.var_3508 endon("death");
  level.var_3508 waittill("self_destruct");
  thread start_self_destruct_timer(0);
  level notify("stop_c12_reactive_dialogue");
  wait(2);
  level.var_EBBC scripts\sp\utility::func_10346("europa_tee_lookouthesgonna");
  thread func_363D();
}

func_3536() {
  level.var_3508 waittill("death");
  thread start_self_destruct_timer(0);
  wait(2);
  level.var_EBBC scripts\sp\utility::func_10346("europa_tee_goodheatonthatcann");
  thread func_363D();
}

func_3532() {
  var_0 = level.var_3508;
  var_0 setCanDamage(1);
  var_0 lib_0A05::func_3555("left", 0);
  var_0 lib_0A05::func_3555("right", 0);
  var_1 = ["hip_pack_right", "hip_pack_left", "left_arm", "right_arm", "head"];
  foreach(var_3 in var_1) {
    var_0 func_847D(var_3);
  }

  wait(0.5);
  var_0.asm.var_4E73 = 1;
  var_0 func_81D0();
  thread func_363D();
  scripts\engine\utility::flag_set("c12_dead");
}

func_363D() {
  setmusicstate("");
  wait(2);
  setmusicstate("mx_351_tram_start");
}

func_2AA5() {
  scripts\sp\maps\europa\europa_anim::func_F2DF("powerup");
  scripts\sp\maps\europa\europa_anim::func_F2DF("idle");
}

func_3575() {
  var_0 = getEntArray("c12_right_cover_volume", "targetname");
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("c12_left_cover_volume", "targetname"));
  foreach(var_2 in level.var_EBCA) {
    var_2.logstring = 0;
    var_2 scripts\sp\utility::func_4145();
    var_3 = sortbydistance(var_0, var_2.origin);
    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_2 func_7398(var_3[var_4])) {
        break;
      }
    }
  }

  while(!isDefined(level.var_3508) && !scripts\engine\utility::flag("c12_fight_done")) {
    wait(0.1);
  }

  level.var_3508.ignoreme = 1;
  var_6 = -1;
  var_7 = scripts\engine\utility::random(level.var_EBCA);
  var_8 = undefined;
  var_9 = undefined;
  while(!scripts\engine\utility::flag("c12_fight_done")) {
    var_0A = gettime();
    if(!isDefined(var_8) && func_9C6B()) {
      if(var_6 == -1) {
        var_6 = gettime() + 3000;
      }
    } else {
      var_6 = -1;
    }

    if(isDefined(var_8)) {
      if(var_0A > var_9) {
        var_8 func_7398(var_8.var_3FF5);
        var_8 = undefined;
      }

      continue;
    }

    if(var_6 > 0) {
      if(var_0A > var_6) {
        if(isDefined(var_7)) {
          foreach(var_2 in level.var_EBCA) {
            if(var_7 != var_2) {
              level.var_3508.ignoreme = 0;
              var_8 = var_2;
              var_7 = var_8;
              break;
            }
          }
        }

        var_9 = var_0A + 8000;
        var_8 func_7399();
      }
    }

    wait(0.05);
  }

  foreach(var_2 in level.var_EBCA) {
    var_2 func_7398(var_2.var_3FF5);
  }
}

func_9C6B() {
  if(!isalive(level.var_3508)) {
    return 0;
  }

  if(!isDefined(level.var_3508._blackboard.shootparams)) {
    return 0;
  }

  foreach(var_1 in level.var_3508._blackboard.shootparams.var_13CC3) {
    if(!isDefined(var_1.ent)) {
      continue;
    }

    if(isplayer(var_1.ent)) {
      return 1;
    }
  }

  return 0;
}

func_7399() {
  var_0 = getnodearray(self.var_3FF5.target, "targetname");
  var_1 = scripts\engine\utility::random(var_0);
  self.objective_playermask_showto = 32;
  self.var_33F = self.var_33F + 500;
  self give_more_perk(var_1);
}

func_56CE(var_0) {
  self notify("stop_display_state");
  self endon("stop_display_state");
  wait(0.05);
}

func_7398(var_0) {
  if(isDefined(var_0.var_3FF4) && var_0.var_3FF4 != self) {
    return 0;
  }

  var_0.var_3FF4 = self;
  self.var_3FF5 = var_0;
  if(self.var_33F >= 500) {
    self.var_33F = self.var_33F - 500;
  }

  self func_82F1(var_0);
  return 1;
}

func_8EAA() {
  level.var_11B30 = getent("tram_brushmodel", "targetname");
  level.var_11B30.var_6664 = getEntArray(level.var_11B30.target, "targetname");
  foreach(var_1 in level.var_11B30.var_6664) {
    if(var_1.classname == "script_model") {
      var_1 hide();
    }
  }
}

func_11B3F() {
  if(isDefined(level.var_11B30)) {
    return;
  }

  level.var_11B30 = getent("tram_brushmodel", "targetname");
  level.var_11B30.var_BCD2 = -400;
  level.var_11B30.var_6664 = getEntArray(level.var_11B30.target, "targetname");
  level.var_11B30.var_2AA2 = undefined;
  var_0 = getEntArray(level.var_11B30.target, "targetname");
  foreach(var_2 in var_0) {
    var_2 linkto(level.var_11B30);
    if(var_2.model == "large_steel_dragon_transport_frame_01") {
      level.var_11B30.var_2AA2 = var_2;
      playFXOnTag(scripts\engine\utility::getfx("vfx_eu_base_hoverrail_distort"), var_0[0], "tag_origin");
      thread func_11B50(var_0[0]);
      continue;
    }

    if(var_2.model == "large_steel_dragon_2x_scale") {
      level.var_11B30.var_7458 = var_2;
      continue;
    }

    if(var_2.model == "p7_desk_metal_military_03_tablet") {
      level.var_11B30.var_C85C = var_2;
      continue;
    }

    if(var_2.model == "electrical_airlock_cycle_button") {
      level.var_11B30.var_32D9 = var_2;
      continue;
    }

    if(var_2.model == "shipcrib_emergency_light") {
      level.var_11B30.var_1021B = var_2;
    }
  }

  level.var_11B30.var_BE67 = getent("tram_nav_clip", "targetname");
  level.var_11B30.var_BE67 connectpaths();
  level.var_11B30.var_BE67 linkto(level.var_11B30);
  var_4 = scripts\engine\utility::getstruct("steel_dragon_gun_flash", "targetname");
  level.var_11B30.var_113F2 = spawn("script_model", var_4.origin);
  level.var_11B30.var_113F2.angles = var_4.angles;
  level.var_11B30.var_113F2 setModel("tag_flash");
  level.var_11B30.var_113F2 linkto(level.var_11B30);
  var_5 = scripts\engine\utility::getstructarray(level.var_11B30.target, "targetname");
  level.var_11B30.var_C058 = [];
  foreach(var_7 in var_5) {
    var_7.offset = rotatevectorinverted(var_7.origin - level.var_11B30.origin, level.var_11B30.angles);
    var_7.var_C36A = level.var_11B30.angles - var_7.angles;
    level.var_11B30.var_C058[level.var_11B30.var_C058.size] = var_7;
  }

  var_9 = scripts\engine\utility::getstruct("tram_move_start", "targetname");
  var_0A = var_9;
  for(;;) {
    if(isDefined(var_9.var_EDA0)) {
      func_12863(var_9.var_EDA0);
    }

    if(isDefined(var_9.var_ED9E)) {
      func_12863(var_9.var_ED9E);
    }

    if(!isDefined(var_9.target)) {
      break;
    }

    var_9 = scripts\engine\utility::getstruct(var_9.target, "targetname");
  }

  level.var_11B30 thread func_11B45(var_0A);
}

func_11B44() {
  var_0 = level.var_11B30.origin;
  wait(0.05);
  var_1 = level.var_11B30.origin;
  return var_1 != var_0;
}

func_11B50(var_0) {
  scripts\engine\utility::flag_wait("tram_move");
  wait(3.4);
  thread scripts\engine\utility::exploder("dooropen");
  wait(8);
  playFXOnTag(scripts\engine\utility::getfx("vfx_eu_base_hoverrail_coldsmoke"), var_0, "tag_origin");
}

func_12863(var_0) {
  if(!scripts\engine\utility::flag_exist(var_0)) {
    scripts\engine\utility::flag_init(var_0);
  }
}

func_496D(var_0) {
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_2 = spawn("script_origin", var_1.origin);
  var_2.angles = var_1.angles;
  var_2 linkto(level.var_11B30);
  var_3 = spawn("script_origin", var_0.origin);
  var_3 linkto(level.var_11B30);
  var_2.var_22E8 = var_3;
  var_2.animation = var_1.animation;
  return var_2;
}

func_11B45(var_0) {
  level notify("stop_tram_move");
  level endon("stop_tram_move");
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  self.var_5F75 = 0;
  if(isDefined(level.var_AC81)) {
    level.var_AC81["lift"].origin = var_0.origin;
  }

  var_1["unlink_platform"] = ::func_11B52;
  var_1["decompression_start_check"] = ::func_11B37;
  var_1["c12_start_check"] = ::func_11B34;
  var_1["tram_assemble"] = ::func_11B32;
  scripts\engine\utility::flag_wait("tram_move");
  thread scripts\sp\maps\europa\europa_util::func_67B6(3, "current", &"EUROPA_OBJECTIVE_ESCAPE");
  thread func_11B47();
  thread func_11B48();
  var_2 = 0;
  var_3 = 80;
  for(;;) {
    if(!isDefined(var_0.target)) {
      break;
    }

    if(isDefined(var_0.script_noteworthy)) {
      if(isDefined(var_1[var_0.script_noteworthy])) {
        [[var_1[var_0.script_noteworthy]]]();
      }
    }

    var_4 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_0 scripts\sp\utility::script_delay();
    if(isDefined(var_0.var_EDA0)) {
      if(!scripts\engine\utility::flag(var_0.var_EDA0)) {
        func_11B51();
        self.getclosestpointonnavmesh3d = 0;
        scripts\engine\utility::flag_wait(var_0.var_EDA0);
        func_11B38();
      }
    }

    if(isDefined(var_0.var_ED9E)) {
      scripts\engine\utility::flag_set(var_0.var_ED9E);
    }

    if(isDefined(var_0.getclosestpointonnavmesh3d)) {
      var_3 = var_0.getclosestpointonnavmesh3d;
    } else {
      var_3 = 50;
    }

    func_11B39(var_4, var_0, var_3);
    var_0 = var_4;
  }

  self notify("stop_moving");
  self.var_BE67 disconnectpaths();
  scripts\engine\utility::flag_set("fspar_ready");
  self stoploopsound("europa_armory_fspar_tram_lp");
}

func_11B51() {
  foreach(var_1 in level.var_11B30.var_C058) {
    var_2 = "Cover Stand";
    if(isDefined(var_1.script_type)) {
      var_2 = var_1.script_type;
    }

    var_3 = 0;
    if(isDefined(var_1.script_index)) {
      var_3 = var_1.script_index;
    }

    var_4 = level.var_11B30.origin + rotatevector(var_1.offset, level.var_11B30.angles);
    var_5 = scripts\engine\utility::drop_to_ground(var_4, 15, -100);
    var_6 = level.var_11B30.angles + var_1.var_C36A;
    var_1.target_getindexoftarget = spawncovernode(var_5, var_6, var_2, var_3);
  }
}

debug_line(var_0, var_1) {
  wait(0.05);
}

func_11B38() {
  foreach(var_1 in level.var_11B30.var_C058) {
    if(isDefined(var_1.target_getindexoftarget)) {
      despawncovernode(var_1.target_getindexoftarget);
    }
  }
}

func_11B4F(var_0, var_1) {
  if(isDefined(var_1)) {
    self.var_EF81 = var_1;
  }

  self.var_527C = var_0;
}

func_7C96() {
  if(isDefined(self.var_10DDB)) {
    return self.var_10DDB;
  }

  return self.var_527C;
}

func_11B39(var_0, var_1, var_2) {
  self.objective_playermask_hidefromall = var_0.origin;
  self.var_4C18 = self.origin;
  if(!isDefined(self.getclosestpointonnavmesh3d)) {
    self.getclosestpointonnavmesh3d = 0;
  }

  var_3 = 1;
  self.var_11937 = 0.2;
  var_4 = 1 * self.var_11937;
  var_5 = 2 * self.var_11937;
  if(!isDefined(self.var_EF81)) {
    func_11B4F(var_2);
  }

  self.missionfailed = vectornormalize(var_0.origin - var_1.origin);
  var_6 = distance(self.var_4C18, var_0.origin);
  var_7 = self.angles;
  while(!func_11B4A(var_1, var_0)) {
    var_8 = func_7C96();
    if(self.var_5F75) {
      var_9 = self.var_4C18 + self.missionfailed * self.var_BCD2;
      if(vectordot(self.missionfailed, vectornormalize(level.player.origin - var_9)) > 0) {
        var_0A = func_7D15(self.missionfailed, var_9);
        self.getclosestpointonnavmesh3d = self.getclosestpointonnavmesh3d + var_4 * var_8 * var_0A;
        func_11B53(var_8);
      } else if(self.getclosestpointonnavmesh3d > 0) {
        self.getclosestpointonnavmesh3d = self.getclosestpointonnavmesh3d - var_5 * var_8;
        func_11B53(var_8);
      }
    } else {
      self.getclosestpointonnavmesh3d = self.getclosestpointonnavmesh3d + var_4 * var_8;
      if(self.getclosestpointonnavmesh3d > var_8) {
        self.getclosestpointonnavmesh3d = var_8;
      }

      func_11B53(var_8);
    }

    var_0B = self.var_4C18;
    if(isDefined(self.var_90DF)) {
      var_0B = var_0B + self.var_90DF.origin;
    }

    if(var_3) {
      self moveto(var_0B, self.var_11937);
    } else {
      self.origin = var_0B;
    }

    var_0C = distance(self.var_4C18, var_0.origin) / var_6;
    self.angles = var_0.angles - var_7 * var_0C;
    wait(self.var_11937);
  }

  self.angles = var_0.angles;
}

func_11B33() {
  self endon("death");
  level endon("fspar_ready");
  var_0 = 0;
  for(;;) {
    wait(0.05);
    if(self.getclosestpointonnavmesh3d > 0) {
      if(var_0 == 0) {
        self playSound("europa_armory_fspar_tram_start");
        self playLoopSound("europa_armory_fspar_tram_lp");
      }
    } else if(var_0 > 0) {
      self playSound("europa_armory_fspar_tram_start");
      self stoploopsound();
    }

    var_0 = self.getclosestpointonnavmesh3d;
  }
}

func_7D15(var_0, var_1) {
  var_2 = 500;
  var_3 = level.var_11B30.var_4C18 + var_0 * var_2 * -1;
  var_4 = pointonsegmentnearesttopoint(level.var_11B30.var_4C18, var_3, level.player.origin);
  var_5 = distance(level.var_11B30.var_4C18, var_4);
  var_6 = 1 - var_5 / var_2;
  return clamp(var_6, 0.05, 1);
}

func_11B53(var_0) {
  self.getclosestpointonnavmesh3d = clamp(self.getclosestpointonnavmesh3d, 0, var_0);
  var_1 = self.var_11937 * self.getclosestpointonnavmesh3d;
  var_2 = self.var_4C18 + self.missionfailed * var_1;
  self.var_4C18 = var_2;
}

func_11B4A(var_0, var_1) {
  var_2 = squared(16);
  if(distancesquared(self.var_4C18, var_1.origin) < var_2) {
    return 1;
  }

  var_3 = vectornormalize(var_1.origin - var_0.origin);
  if(vectordot(var_3, vectornormalize(self.var_4C18 - var_1.origin)) > 0) {
    return 1;
  }

  return 0;
}

func_11B3E() {
  var_0 = (0, 0, 0);
  self.var_90DF = spawn("script_origin", var_0);
  var_1 = 4;
  var_2 = 5;
  var_3 = -3;
  var_4 = 3;
  var_5 = -1;
  var_6 = 1;
  var_7 = 0.2;
  var_8 = 2;
  for(;;) {
    var_9 = randomfloatrange(var_3, var_4);
    var_0A = randomfloatrange(var_5, var_6);
    var_0B = randomfloatrange(var_7, var_8);
    var_0C = var_0 + (var_9, var_0A, var_0B);
    var_0D = randomfloatrange(var_1, var_2);
    self.var_90DF moveto(var_0C, var_0D, var_0D * 0.5, var_0D * 0.5);
    wait(var_0D);
    var_9 = randomfloatrange(var_3, var_4);
    var_0A = randomfloatrange(var_5, var_6);
    var_0B = randomfloatrange(var_7, var_8) * -1;
    var_0C = var_0 + (var_9, var_0A, var_0B);
    var_0D = randomfloatrange(var_1, var_2);
    self.var_90DF moveto(var_0C, var_0D, var_0D * 0.5, var_0D * 0.5);
    wait(var_0D);
  }
}

func_11B37() {
  if(level.var_10CDA == "decompression") {
    self.var_10DDB = undefined;
    wait(1);
  }
}

func_11B34() {
  if(level.var_10CDA == "c12") {
    self.var_10DDB = undefined;
    wait(1);
  }
}

func_11B32() {
  self.var_5F75 = 1;
  scripts\engine\utility::flag_set("tram_assemble_pos");
  self.getclosestpointonnavmesh3d = 0;
  thread func_11B33();
  scripts\engine\utility::flag_set("tram_intro_done");
  scripts\engine\utility::flag_wait("selfdestruct_start");
}

func_11B48() {
  self endon("stop_moving");
  var_0 = 300;
  var_1 = 200;
  var_2 = 400;
  var_3 = anglesToForward(self.angles + (0, 180, 0));
  var_4 = anglestoright(self.angles + (0, 180, 0));
  var_5 = var_4 * 140;
  var_6 = var_4 * 500;
  level.var_6B86 = [];
  level.var_BE84 = [];
  level.var_A66C = [];
  for(;;) {
    var_7 = func_79B2(var_3, var_2);
    self.var_6B86[0] = var_7 + var_5;
    self.var_6B86[1] = var_7 + var_5 * -1;
    var_8 = self.origin + var_3 * var_1;
    self.var_BE84[0] = var_8 + var_6;
    self.var_BE84[1] = var_8 + var_6 * -1;
    wait(0.05);
  }
}

func_79B2(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct("farplane_cap", "targetname");
  var_3 = self.origin + var_0 * var_1;
  for(;;) {
    if(!scripts\engine\utility::flag(var_2.var_EDA0)) {
      break;
    }

    if(!isDefined(var_2.target)) {
      var_2 = undefined;
      break;
    }

    var_2 = scripts\engine\utility::getstruct(var_2.target, "targetname");
  }

  if(isDefined(var_2)) {
    if(vectordot(var_0, vectornormalize(var_3 - var_2.origin)) > 0) {
      var_3 = var_2.origin;
    }
  }

  return var_3;
}

func_11B47() {
  self endon("stop_moving");
  wait(1);
  for(;;) {
    wait(0.5);
    self.var_BE67 connectpaths();
    var_0 = self.var_4C18;
    wait(0.1);
    self.var_BE67 disconnectpaths();
    while(var_0 == self.var_4C18) {
      wait(0.05);
    }
  }
}

func_11B3C(var_0) {
  self endon("death");
  self notify("stop_follow_tram");
  self endon("stop_follow_tram");
  self.var_3912 = 0;
  self.objective_playermask_showto = 32;
  var_1 = var_0;
  var_2 = var_0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 1;
  var_6 = anglesToForward(level.var_11B30.angles + (0, 180, 0));
  var_7 = 50;
  for(;;) {
    var_8 = level.var_11B30.var_4C18 + var_6 * var_7;
    if(var_5) {
      while(vectordot(var_6, vectornormalize(var_1.origin - var_8)) < 0) {
        var_9 = getnodearray(var_1.target, "targetname");
        var_2 = var_1;
        var_1 = scripts\engine\utility::random(var_9);
      }

      var_5 = 0;
      var_1 = var_2;
    }

    if(vectordot(var_6, vectornormalize(var_1.origin - var_8)) < 0) {
      if(!isDefined(var_1.target)) {
        break;
      }

      var_9 = getnodearray(var_1.target, "targetname");
      var_1 = scripts\engine\utility::random(var_9);
      thread func_11B3D(var_1);
    }

    wait(0.1);
  }
}

func_11B3D(var_0) {
  self notify("new_friendly_path_node");
  self endon("new_friendly_path_node");
  self endon("stop_follow_tram");
  self endon("death");
  if(self.var_3912) {
    wait(randomfloatrange(1, 3));
  }

  self give_more_perk(var_0);
  self.var_3912 = 1;
  self waittill("goal");
  wait(randomfloat(1));
  self.var_3912 = 0;
}

func_11B52() {
  foreach(var_1 in level.var_AC81) {
    var_1 unlink();
  }

  level.var_AC81 = undefined;
}

func_11B4C() {
  thread func_11B3B();
  scripts\engine\utility::flag_wait("tram_enemies_alive");
  scripts\engine\utility::flag_set("open_tram_doors3_dialogue");
}

func_11B3B() {
  var_0 = getent("tram_out_volume", "targetname");
  for(;;) {
    wait(0.1);
    var_1 = getaiarray("bad_guys");
    var_2 = 1;
    foreach(var_4 in var_1) {
      if(var_4 scripts\sp\utility::func_58DA()) {
        continue;
      }

      if(!var_4 istouching(var_0)) {
        continue;
      }

      if(isalive(var_4)) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      break;
    }
  }

  scripts\engine\utility::flag_set("tram_enemies_alive");
}

func_11B35() {}

func_11B3A() {
  scripts\engine\utility::flag_set("tram_pre_blow_doors");
}

func_21DB() {
  scripts\sp\maps\europa\europa_util::func_107C5();
  scripts\sp\utility::func_F5AF("armory_tram_end_startpoint", [level.var_EBBB, level.var_EBBC, level.player]);
  scripts\engine\utility::array_thread(level.var_EBCA, scripts\sp\utility::func_DC45, "raise");
  scripts\engine\utility::flag_set("tram_move");
  scripts\engine\utility::delaythread(30.5, ::func_D287);
  thread func_2872(30.5);
  level.var_11B30.var_10DDB = 2000;
  thread scripts\sp\maps\europa\europa_util::func_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::func_67B6(2, "done", &"EUROPA_OBJECTIVE_FSPAR");
  thread scripts\sp\maps\europa\europa_util::func_67B6(3, "current", &"EUROPA_OBJECTIVE_ESCAPE");
  thread func_746D();
}

func_D70D() {
  self endon("death");
  if(!scripts\engine\utility::flag("c12_spawn")) {
    thread func_652C();
  }

  scripts\engine\utility::flag_wait("c12_spawn");
  scripts\sp\utility::func_51E1("frantic");
  thread func_6474();
}

func_D710() {
  self.var_C061 = 1;
}

func_6474() {
  self endon("death");
  self notify("stop_enemy_think");
  self getplayerforguid();
  if(distancesquared(self.origin, level.player.origin) > squared(500)) {
    self.precacheleaderboards = 1;
  }

  scripts\engine\utility::flag_wait("open_room2_doors");
  self.objective_playermask_showto = 130;
  func_F3DB("enemy_flee_struct");
  self waittill("goal");
  scripts\engine\utility::flag_wait("kill_enemy_fleers");
  wait(0.25);
  if(scripts\engine\utility::cointoss()) {
    self.missile_createattractororigin = 1;
  }

  wait(randomfloat(0.5));
  self func_81D0();
}

func_A5D9() {
  var_0 = getent("enemy_flee_volume", "targetname");
  for(;;) {
    wait(0.05);
    var_1 = getaiarray("axis");
    var_2 = [];
    foreach(var_4 in var_1) {
      if(var_4.unittype == "c12") {
        continue;
      }

      var_2[var_2.size] = var_4;
    }

    var_6 = var_2.size;
    var_7 = 0;
    foreach(var_4 in var_2) {
      if(var_4.unittype == "c12") {
        continue;
      }

      if(var_4 istouching(var_0)) {
        var_7++;
      }
    }

    if(var_7 > var_6 * 0.75) {
      level.var_6475 = 1;
      func_537D("room2_closet_explosion");
      scripts\engine\utility::flag_set("kill_enemy_fleers");
      return;
    }
  }
}

func_F3DB(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 32;
  }

  var_2 = scripts\engine\utility::getstruct(var_0, "targetname");
  var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
  var_4 = pointonsegmentnearesttopoint(var_2.origin, var_3.origin, self.origin);
  var_4 = scripts\engine\utility::drop_to_ground(var_4, 10, -200);
  self.objective_playermask_showto = var_1;
  self give_mp_super_weapon(var_4);
}

func_D70E() {
  thread func_652C();
}

func_652C() {
  self endon("death");
  self endon("stop_enemy_think");
  scripts\engine\utility::flag_wait("armory_enemy_fallback");
  wait(0.1);
  self notify("stop_going_to_node");
  if(func_1024C()) {
    return;
  }

  var_0 = getent("enemy_fallback_room1", "targetname");
  if(isDefined(self.var_91EF)) {
    self notify("stop_hunt");
    self give_mp_super_weapon(self.origin);
  }

  self func_82F1(var_0);
  scripts\engine\utility::flag_wait("start_fallback");
  var_0 = getent("c12_backhalf", "targetname");
  wait(randomfloat(1));
  self func_82F1(var_0);
}

func_1024C() {
  if(self.unittype != "c6") {
    return 0;
  }

  if(lib_0A0B::func_2040()) {
    return 1;
  }

  if(scripts\asm\asm_bb::func_293E()) {
    return 1;
  }

  return 0;
}

func_D287(var_0) {
  if(!isDefined(var_0)) {
    wait(1);
  }

  if(scripts\engine\utility::flag("player_on_fspar")) {
    return;
  }

  scripts\engine\utility::flag_set("self_destruction_start");
  level.player freezecontrols(1);
  playFX(scripts\engine\utility::getfx("explosion_med"), level.player.origin + anglesToForward(level.player.angles) * 70);
  earthquake(0.6, 0.5, level.player.origin, 100);
  playworldsound("scn_europa_window_explosion", level.player.origin);
  if(!isDefined(var_0)) {
    lib_0B60::func_F322("EUROPA_FAILED_TO_ESCAPE");
  }

  level.player func_80A1();
  magicgrenademanual("frag", level.player.origin, (0, 0, 0), 0);
  wait(0.5);
  foreach(var_2 in level.var_EBCA) {
    var_2 scripts\sp\utility::func_1101B();
    var_2 scripts\sp\utility::func_54C6();
  }

  if(isalive(level.player)) {
    if(scripts\sp\utility::func_93A6()) {
      level.player notify("headshot_death");
      level.player func_80A1();
    }

    level.player scripts\sp\utility::func_54C6();
  }
}

func_2AC3() {
  var_0 = scripts\sp\utility::func_22CD("final_stand", 1);
  thread func_138EF();
  thread func_CFA3(var_0);
  thread func_6C29(var_0);
  foreach(var_2 in var_0) {
    var_2 lib_0A05::func_353F();
  }

  scripts\engine\utility::flag_wait("fspar_ready");
  thread func_746C();
  scripts\engine\utility::array_thread(level.var_EBCA, ::func_1C38, 0);
  thread func_134D9();
  thread func_5530();
  wait(1.5);
  thread func_D294();
  scripts\engine\utility::flag_wait("player_on_fspar");
  setmusicstate("");
  level.player scripts\engine\utility::delaycall(2, ::playsound, "scn_europa_fspar_button");
  stopFXOnTag(scripts\engine\utility::getfx("fspar_light_green"), level.var_11B30.var_1021B, "tag_origin");
  var_4 = 3.2;
  if(scripts\sp\utility::func_93A6()) {
    level.player thread scripts\sp\specialist_MAYBE::func_BE53();
    level.player thread scripts\sp\specialist_MAYBE::func_BE51();
  }

  wait(var_4);
  var_5 = 2.5;
  var_6 = 0.5;
  thread func_111B3();
  thread func_3D24(var_5);
  scripts\engine\utility::delaythread(var_5, ::func_FED5, var_6);
  thread scripts\engine\utility::flag_set_delayed("fspar_prefire", var_5 - 1);
  thread scripts\engine\utility::flag_set_delayed("fspar_done_firing", var_6 + var_5);
  thread func_7468(var_5, var_6, var_0);
  thread func_7463(var_5, var_6);
  scripts\engine\utility::delaythread(var_5 + var_6 + 1, scripts\engine\utility::exploder, "decomp_room");
  scripts\engine\utility::delaythread(var_5 + 0.2, ::func_3576, var_0);
  scripts\engine\utility::delaythread(var_5 + var_6, ::func_FED5, 0.25);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), ::func_A9E0);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), ::func_4FAC);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), ::func_4F99);
  scripts\engine\utility::delaythread(var_5 + 0.05, ::func_4F97);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), ::func_4FA9);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), scripts\sp\maps\europa\europa_util::func_6F30);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), ::func_224B);
  wait(var_5 + var_6);
  wait(3);
  scripts\engine\utility::flag_set("new_decompress_anim");
}

func_111B3() {
  scripts\engine\utility::flag_wait("fspar_prefire");
  var_0 = anglesToForward((-40, 0, 0));
  var_0 = var_0 * -500;
  physics_setgravity(var_0);
}

func_138EF() {
  scripts\engine\utility::flag_wait("player_asking_for_it");
  if(!scripts\engine\utility::flag("player_on_fspar")) {
    scripts\sp\maps\europa\europa_util::func_134B7("europa_sip_wolfdongoout");
  }
}

func_134D9() {
  level.player endon("death");
  level.var_EBBB endon("death");
  level.var_EBBC endon("death");
  scripts\sp\maps\europa\europa_util::func_134B7("europa_plr_sipeswherestheweap");
  scripts\sp\maps\europa\europa_util::func_134B7("europa_sip_fsparsonline");
  var_0 = scripts\engine\utility::array_randomize(["europa_tee_hitemwiththefspar", "europa_tee_usethefsparor"]);
  for(;;) {
    foreach(var_2 in var_0) {
      if(scripts\engine\utility::flag("player_on_fspar")) {
        return;
      }

      scripts\sp\maps\europa\europa_util::func_134B7(var_2);
      wait(2);
    }
  }
}

func_7463(var_0, var_1) {
  thread scripts\sp\art::func_583F(0, 1199, 2, 80000, 90000, 0, var_0);
  level.player func_81DE(60, var_0);
  wait(var_0 + var_1);
  scripts\sp\art::func_583D(0.05);
  level.player func_81DE(65, 0.05);
}

func_746F(var_0) {
  setslowmotion(1, 0.5, 0.1);
  wait(var_0 + 0.1);
  scripts\sp\utility::func_10322();
}

func_5530() {
  scripts\engine\utility::flag_set("pause_destruction_explosions");
  stop_far_cars();
}

func_FED5(var_0) {
  level.player stoprumble("steady_rumble");
  earthquake(0.75, 0.65, level.player.origin, 500);
  level.player playrumbleonentity("heavy_2s");
  level.player viewkick(25, level.player getEye(), 0);
}

func_3D24(var_0) {
  level endon("stop_charge_shake");
  level thread scripts\sp\utility::func_C12D("stop_charge_shake", var_0);
  var_1 = 1;
  level.player func_8244("steady_rumble");
  for(;;) {
    var_2 = var_1 * 0.5;
    var_2 = min(var_2, 1);
    var_3 = randomfloatrange(0.2, 0.6) * var_2;
    var_4 = randomfloatrange(0.2, 0.5) * var_2;
    var_5 = randomfloatrange(0.1, 0.2) * var_2;
    level.player func_8291(var_3, var_4, var_5, 0.2, 0, 0, 700, 10, 10, 10);
    wait(0.2);
    var_1++;
  }
}

func_CFA3(var_0) {
  thread func_CFCD();
  wait(1);
  var_1 = [];
  foreach(var_3 in scripts\engine\utility::getstructarray("c12_rocket_target", "targetname")) {
    var_1[var_1.size] = scripts\engine\utility::spawn_script_origin(var_3.origin);
  }

  level.var_3623 = var_1;
  scripts\engine\utility::array_thread(var_0, ::func_6AD9);
  scripts\engine\utility::array_thread(var_0, ::func_10FC7);
  scripts\engine\utility::flag_wait("player_asking_for_it");
  wait(1.25);
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  scripts\engine\utility::array_thread(var_0, ::func_24C1);
}

func_CFCD() {
  level endon("player_on_fspar");
  level.player endon("death");
  scripts\engine\utility::flag_wait("player_in_decompression_area");
  func_D287(1);
}

func_24C1() {
  self endon("death");
  level endon("player_on_fspar");
  level.player endon("death");
  for(;;) {
    if(func_FFA7()) {
      level.player.ignoreme = 0;
      self notify("attacking_player");
      self.var_2894 = 5;
      lib_0A05::func_3555("right", 1);
      lib_0A05::func_3555("left", 1);
      lib_0A05::func_360D("right", level.player, "rockets_done", 1);
      lib_0A05::func_360D("left", level.player, "mg_done", 1);
      while(func_FFA7()) {
        wait(0.5);
      }
    } else {
      lib_0A05::func_352D("left");
      lib_0A05::func_352D("right");
      func_6AD9();
      while(!func_FFA7()) {
        wait(0.5);
      }
    }

    wait(0.5);
  }
}

func_10FC7() {
  scripts\engine\utility::flag_wait("player_on_fspar");
  func_6AD9();
}

func_6AD9() {
  self.var_2894 = 1;
  self.precacheleaderboards = 0;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "rockets") {
    thread func_E5DF();
    return;
  } else if(isDefined(self.script_noteworthy) && self.script_noteworthy == "mg") {
    lib_0A05::func_3555("left", 1);
    lib_0A05::func_3553(1);
    return;
  }

  thread func_3BA9();
}

func_3BA9() {
  self endon("death");
  self endon("attacking_player");
  self notify("regulating_rockets");
  self endon("regulating_rockets");
  var_0 = level.var_3623;
  self.precacheleaderboards = 0;
  wait(randomfloat(2));
  for(;;) {
    lib_0A05::func_3555("left", 0);
    lib_0A05::func_3555("right", 1);
    lib_0A05::func_360D("right", scripts\engine\utility::random(var_0), "rockets_done", 1);
    self waittill("rockets_done");
    lib_0A05::func_352D("right");
    lib_0A05::func_3555("right", 0);
    lib_0A05::func_3555("left", 1);
    wait(randomfloatrange(4, 6));
  }
}

func_E5DF() {
  self endon("death");
  self endon("attacking_player");
  self notify("regulating_rockets");
  self endon("regulating_rockets");
  var_0 = level.var_3623;
  self.precacheleaderboards = 0;
  lib_0A05::func_3555("right", 1);
  wait(randomfloat(2));
  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    foreach(var_2 in var_0) {
      lib_0A05::func_360D("right", var_2, "rockets_done", 1);
      self waittill("rockets_done");
      wait(randomfloatrange(0.25, 1));
    }

    wait(randomfloatrange(2, 4));
  }
}

func_FFA7() {
  return scripts\engine\utility::flag("player_asking_for_it") && scripts\sp\utility::func_13D91(level.player.origin, level.player.angles, self.origin, cos(50));
}

func_2AC2() {}

func_6C29(var_0) {
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::func_51E1, "casual");
  scripts\engine\utility::flag_wait("open_room3_doors");
  wait(2);
  scripts\engine\utility::flag_set("final_stand_moveup");
}

func_137E6(var_0) {
  var_0 endon("death");
  for(;;) {
    if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_0.origin, cos(40))) {
      if(scripts\sp\detonategrenades::func_385C(level.player getEye(), var_0)) {
        return;
      }
    }

    wait(0.05);
  }
}

func_D294() {
  level.player endon("death");
  var_0 = getent("tram_interact", "script_noteworthy");
  var_1 = scripts\sp\utility::func_10639("player_rig", var_0.origin + (0, 0, 500));
  var_1 hide();
  var_0 scripts\sp\anim::func_1EC3(var_1, "fspar_fire");
  var_2 = spawnStruct();
  var_2.origin = var_1.origin + (0, 0, 50) + anglesToForward(var_1.angles) * 45;
  var_2 lib_0E46::func_48C4(undefined, undefined, &"EUROPA_FSPAR_SHOOT");
  objective_onentity(3, var_1);
  var_2 waittill("trigger");
  if(scripts\engine\utility::flag("self_destruction_start")) {
    return;
  }

  thread scripts\engine\utility::flag_set_delayed("middle_c12_approach", 2);
  func_D087(var_0, var_1);
  scripts\engine\utility::flag_wait("new_decompress_anim");
  var_0 notify("stop_loop");
  level.player func_8244("steady_rumble");
  level.player scripts\engine\utility::delaycall(4.5, ::stoprumble, "steady_rumble");
  scripts\engine\utility::delaythread(0.5, ::func_AB59);
  scripts\engine\utility::flag_clear("pause_destruction_explosions");
  level.player lerpviewangleclamp(0.5, 0.25, 0.25, 5, 5, 10, 10);
  var_0 scripts\sp\anim::func_1F2C([var_1, level.var_EBBB], "fspar_suckout");
}

func_D087(var_0, var_1) {
  scripts\engine\utility::flag_set("player_on_fspar");
  objective_position(3, (0, 0, 0));
  level.player getrankinfoxpamt();
  var_2 = 0.5;
  scripts\sp\maps\europa\europa_util::func_D85C();
  var_1 scripts\engine\utility::delaycall(var_2, ::show);
  level.player playerlinktoblend(var_1, "tag_player", var_2, var_2 / 2, var_2 / 2);
  level.player scripts\engine\utility::delaycall(var_2, ::playerlinktodelta, var_1, "tag_player", 1, 20, 20, 20, 20, 1);
  level.var_46B2.alpha = 0;
  var_0 scripts\sp\anim::func_1F35(var_1, "fspar_fire");
  var_0 thread scripts\sp\anim::func_1EEA(var_1, "fspar_idle");
  setmusicstate("");
}

func_7468(var_0, var_1, var_2) {
  level.var_11B30.var_113F2 thread func_746E(var_0, var_1);
  var_3 = scripts\engine\utility::getclosest(level.var_11B30.var_113F2.origin, var_2);
  playFX(scripts\engine\utility::getfx("vfx_eu_bfg_chargeup"), level.var_11B30.var_113F2.origin, anglesToForward(level.var_11B30.var_113F2.angles), anglestoup(level.var_11B30.var_113F2.angles));
  wait(2.5);
  var_4 = var_3.origin + (0, 0, 90);
  var_5 = vectornormalize(var_4 - level.var_11B30.var_113F2.origin);
  var_6 = vectortoangles(var_5);
  level.var_11B30.var_113F2 unlink();
  level.var_11B30.var_113F2.angles = var_6;
  var_7 = level.var_11B30.var_113F2.origin + anglesToForward(var_6) * 10000;
  playfxbetweenpoints(scripts\engine\utility::getfx("vfx_eu_bfg_beam"), level.var_11B30.var_113F2.origin, var_6, var_7);
}

func_746E(var_0, var_1) {
  level.player setsoundsubmix("scn_heavy_uber");
  self playSound("scn_europa_fspar_charge");
  wait(var_0);
  self stopsounds();
  self playSound("heistspace_fspar_fire");
  wait(var_1);
  self stopsounds();
  self playSound("heistspace_fspar_powerdown");
  level.player clearsoundsubmix();
}

func_3576(var_0) {
  var_0 = sortbydistance(var_0, level.player.origin);
  foreach(var_3, var_2 in var_0) {
    if(var_3 == 0) {
      playFX(scripts\engine\utility::getfx("c12_fspar_explosion_center"), var_2.origin + (0, 0, 20));
    } else {
      playFX(scripts\engine\utility::getfx("c12_fspar_explosion"), var_2.origin + (0, 0, 20));
    }

    thread scripts\sp\detonategrenades::func_DBDB(var_2.origin + (0, 0, 50), 0.09, 950, 2000, undefined, undefined, undefined, 1);
    var_2 thread lib_0C46::func_35FD();
    var_2 lib_0A05::func_3555("left", 0);
    var_2 lib_0A05::func_3555("right", 0);
    var_2 lib_0C41::func_35EB();
    wait(0.25);
    var_2 hide();
    var_2 scripts\engine\utility::delaycall(0.8, ::delete);
    wait(0.15);
  }
}

func_7459(var_0, var_1, var_2) {
  level endon("mons_cannon_targeting");
  level endon("removing_mons_cannon");
  var_3 = "tag_flash";
  self.var_38D7 = spawn("script_origin", self.origin);
  self.var_38D7 linkto(self);
  self.var_38D7 thread func_BA6B();
  if(var_0 > 0) {
    var_4 = gettime();
    var_5 = var_4 + var_0 * 1000;
    playFXOnTag(level._effect["vfx_heist_mons_steeldragon_chargeup"], self, var_3);
    while(gettime() < var_5) {
      earthquake(0.1, 0.05, self.origin, 150000);
      wait(0.05);
    }

    self.var_38D7 notify("chargeup_over");
    stopFXOnTag(level._effect["vfx_heist_mons_steeldragon_chargeup"], self, var_3);
  }

  playFXOnTag(level._effect["vfx_heist_mons_steeldragon_loop"], self, var_3);
  var_4 = gettime();
  var_1 = var_4 + var_1 * 1000;
  while(gettime() < var_1) {
    var_6 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, self.origin + anglesToForward(self.angles) * 1000);
    var_7 = self gettagorigin(var_3);
    var_8 = self gettagangles(var_3);
    playfxbetweenpoints(level._effect["vfx_heist_mons_steeldragon_beam"], var_7, var_8, var_6);
    earthquake(0.3, 0.1, self.origin, 150000);
    wait(0.1);
  }

  stopFXOnTag(level._effect["vfx_heist_mons_steeldragon_loop"], self, var_3);
  level notify("mons_cannon_fired");
}

func_BA6B() {
  level scripts\engine\utility::waittill_any_3("mons_cannon_fired", "mons_cannon_targeting", "removing_mons_cannon");
  self stopsounds();
  wait(0.05);
  self delete();
}

func_21DA() {
  if(level.var_7464) {
    thread func_134DA();
    thread func_A9E5();
    func_2AC3();
    scripts\engine\utility::flag_wait("fspar_done_firing");
    scripts\engine\utility::flag_wait("decompress_blackout");
    setomnvar("ui_countdown_timer", 0);
    stop_far_cars();
    scripts\sp\utility::func_28D7();
    scripts\engine\utility::flag_set("player_decompressed");
    var_0 = scripts\sp\hud_util::func_7B4F();
    var_0.alpha = 1;
    wait(0.05);
    clearallcorpses();
    func_11B36();
    return;
  }

  thread func_A9E4();
  thread func_A9E5();
  scripts\engine\utility::flag_wait("lastroom_destruction");
  thread func_A9E2();
  if(getdvarint("debug_europa")) {
    level.var_37CE = 1;
  }

  thread func_224B();
  func_A9E0();
  thread func_4F95();
  thread func_4F97();
  thread func_4FA9();
  thread scripts\sp\maps\europa\europa_util::func_6F30();
  func_4F99();
  thread func_4FAC();
  scripts\engine\utility::flag_wait("decompress_blackout");
  setomnvar("ui_countdown_timer", 0);
  stop_far_cars();
  scripts\sp\utility::func_28D7();
  scripts\engine\utility::flag_set("player_decompressed");
  var_0 = scripts\sp\hud_util::func_7B4F();
  var_0.alpha = 1;
  wait(0.05);
  clearallcorpses();
  func_11B36();
}

func_111B4() {
  var_0 = scripts\engine\utility::getstruct("door_sound_struct", "targetname");
  var_1 = var_0.origin + (0, 0, 60);
  setsaveddvar("r_mbenable", 1);
  setsaveddvar("r_mbRadialOverridePosition", var_1);
  setsaveddvar("r_mbRadialOverridePositionActive", 1);
  thread scripts\sp\utility::func_AB9A("r_mbRadialOverrideRadius", 0.314878, 1);
  thread scripts\sp\utility::func_AB9A("r_mbRadialoverridechromaticAberration", 0.25, 2);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverridestrength", 0.05, 1);
  scripts\engine\utility::flag_wait("player_holding_on");
  setsaveddvar("r_mbRadialOverridePosition", level.var_11B30.var_113F2.origin);
  earthquake(0.3, 1, level.player.origin, 300);
  scripts\engine\utility::flag_wait("decompress_blackout");
  setsaveddvar("r_mbenable", 0);
  setsaveddvar("r_mbRadialoverridechromaticAberration", 0);
  setsaveddvar("r_mbradialoverridestrength", 0);
  setsaveddvar("r_mbRadialOverrideRadius", 0);
  setsaveddvar("r_mbRadialOverridePositionActive", 0);
}

func_4F99() {
  func_16D4("decompress");
  func_16D4("doorblast");
  func_16D4("end_ext_explosion");
}

func_224B() {
  level thread scripts\engine\utility::play_sound_in_space("scn_europa_window_explosion", (30584, -11739, -298));
  level.var_4FB4 = scripts\engine\utility::play_loopsound_in_space("scn_end_suck_out_door_wind_lr", level.player.origin);
  level.var_4FB4 linkto(level.player);
  level.player playSound("scn_end_suck_out_room_debris_lr");
  wait(4);
}

func_224E() {
  level.player func_82C0("europa_suck_out_grab", 1);
  level.player playSound("scn_end_suck_out_plr_grab_bar");
  wait(2.8);
  playworldsound("scn_euro_guy_impacts_plr_lr", level.player.origin);
  scripts\engine\utility::flag_wait("decompress_blackout");
  thread func_224F();
  level.player playrumbleonentity("damage_heavy");
}

func_224F() {
  level.player stoprumble("steady_rumble");
  level.var_4FB4 stoploopsound();
  level.player func_82C0("europa_suck_out_hit_fade_to_black", 0);
  setmusicstate("");
  level.player stopsounds();
  level.player setclientomnvar("ui_hide_hud", 1);
}

func_A9E5() {
  scripts\engine\utility::flag_wait("open_room3_doors");
  thread func_537D("lastroom_rail_explosion");
  scripts\sp\utility::func_22CD("lastroom_fleer", 1);
}

func_134DA() {
  level.player endon("death");
  level endon("player_decompressed");
  wait(2.5);
  var_0 = ["europa_rpr_scar1weretaking", "europa_plr_reaperthisis11radioch", "europa_sip_nocomms"];
  scripts\sp\maps\europa\europa_util::func_48BD(var_0);
  level.var_EBBC scripts\sp\utility::func_10346("europa_tee_thisplaceisgonnabl");
  wait(0.5);
  level.var_EBBB scripts\sp\utility::func_10346("europa_sip_keeppushing");
  scripts\engine\utility::flag_wait("fspar_done_firing");
  wait(0.5);
  level.var_EBBC scripts\engine\utility::delaythread(0.6, scripts\sp\maps\europa\europa_util::func_134B7, "europa_tee_holdon");
  level.var_EBBB scripts\sp\utility::func_10346("europa_sip_itsdecompressing");
  wait(0.6);
  scripts\sp\utility::func_1034D("europa_plr_holdon");
}

func_A9E4() {
  level.var_EBBC scripts\sp\utility::func_10346("europa_sip_wegottagetoffthexn");
  wait(randomfloatrange(1, 2));
  scripts\sp\utility::func_10350("europa_rpr_11uhthiscantberight");
  scripts\sp\utility::func_1034D("europa_plr_reapersayagainyouare");
  wait(1);
  scripts\sp\utility::func_1034D("europa_plr_reaperthisis11radioch");
  level.var_EBBC scripts\sp\utility::func_10346("europa_tee_nocomms");
  wait(2);
  scripts\engine\utility::flag_wait("tram_room2_enter");
  func_2873(2, 5, 1000, 2000);
  scripts\engine\utility::flag_wait("open_room3_doors");
  level.var_EBBC scripts\sp\utility::func_10346("europa_tee_thisplaceisgonnabl");
  wait(3);
  wait(1);
  level.var_EBBB scripts\sp\utility::func_10346("europa_sip_keeppushing");
}

func_4F95() {
  wait(1);
  level.var_EBBB scripts\sp\utility::func_10346("europa_sip_itsdecompressing");
  wait(1);
  scripts\sp\utility::func_1034D("europa_plr_holdon");
}

func_A9E0() {
  scripts\sp\utility::func_22CD("lastroom_fleer_bridge", 1);
  func_537D("lastroom_destruction_start");
  func_A9E3();
  var_0 = scripts\engine\utility::getstructarray("lastroom_destruction_end", "targetname");
  scripts\engine\utility::array_levelthread(var_0, ::func_537C);
}

func_A9E3() {
  var_0 = scripts\engine\utility::getstruct("lastroom_destruction_train", "targetname");
  var_0.script_fxid = "fireball_med_bridge";
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1.fx = var_0.script_fxid;
  var_1 thread func_A9E1();
  var_2 = 400;
  for(;;) {
    if(!isDefined(var_0.target)) {
      break;
    }

    if(isDefined(var_0.script_fxid)) {
      var_1.fx = var_0.script_fxid;
    }

    var_1.angles = var_0.angles;
    var_0 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_3 = distance(var_1.origin, var_0.origin) / var_2;
    var_1 moveto(var_0.origin, var_3);
    var_1 waittill("movedone");
    if(isDefined(var_0.getclosestpointonnavmesh3d)) {
      var_2 = var_0.getclosestpointonnavmesh3d;
    }
  }

  var_1 delete();
}

func_A9E1() {
  var_0 = scripts\engine\utility::getfx(self.fx);
  var_1 = 1;
  playFXOnTag(var_0, self, "tag_origin");
  self endon("death");
  for(;;) {
    if(self.fx != "fireball_med_bridge") {
      if(var_1) {
        var_1 = 0;
        stopFXOnTag(var_0, self, "tag_origin");
      }

      var_0 = scripts\engine\utility::getfx(self.fx);
      playFX(var_0, self.origin, anglesToForward(self.angles));
    }

    radiusdamage(self.origin, 100, 200, 200, undefined, "MOD_EXPLOSIVE");
    wait(0.25);
  }
}

func_4FAC() {
  var_0 = scripts\engine\utility::getstruct("decompress_start", "targetname");
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_2 = vectornormalize(var_1.origin - var_0.origin);
  var_3 = spawn("script_origin", var_0.origin);
  var_3.angles = var_0.angles;
  scripts\sp\utility::func_16AE(var_3, "decompress");
  var_4 = 1100;
  var_5 = distance(var_1.origin, var_3.origin);
  var_6 = var_5 / var_4;
  var_3 moveto(var_1.origin, var_6);
  var_7 = [level.player, level.var_EBBB, level.var_EBBC];
  var_7 = scripts\engine\utility::array_combine(var_7, getaiarray("axis"));
  var_7 = scripts\sp\utility::func_22B9(var_7);
  for(;;) {
    var_7 = scripts\sp\utility::func_22B9(var_7);
    foreach(var_9 in var_7) {
      if(isDefined(var_9.var_4FAE)) {
        continue;
      }

      if(vectordot(var_2, vectornormalize(var_3.origin - var_9.origin)) > 0) {
        var_9.var_4FAE = 1;
        var_9 thread func_4F98();
      }
    }

    var_0B = [];
    foreach(var_9 in var_7) {
      if(isDefined(var_9.var_4FAE)) {
        continue;
      }

      var_0B[var_0B.size] = var_9;
    }

    var_7 = var_0B;
    wait(0.05);
  }
}

func_4F98() {
  if(self == level.player) {
    if(!scripts\engine\utility::flag("safe_to_decompress_player")) {
      return;
    }

    thread func_4F9E();
    return;
  }

  if(self == level.var_EBBB) {
    if(!scripts\engine\utility::flag("safe_to_decompress_player")) {
      return;
    }

    thread func_4FA7();
    return;
  }

  if(self == level.var_EBBC) {
    if(!scripts\engine\utility::flag("safe_to_decompress_player")) {
      return;
    }

    thread func_4FA8();
    return;
  }

  if(self != level.var_EBBC && self != level.var_EBBB && isai(self)) {
    level thread func_4F8E(self);
    return;
  }
}

func_4F8E(var_0) {
  if(!isalive(var_0) || var_0 scripts\sp\utility::func_58DA()) {
    return;
  }

  var_1 = spawn("script_origin", var_0.origin + (0, 0, 40));
  var_0 linkto(var_1);
  var_0.precacheleaderboards = 1;
  var_2 = scripts\engine\utility::getstruct("decompress_doorway", "targetname");
  var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
  var_4 = pointonsegmentnearesttopoint(var_2.origin, var_3.origin, var_1.origin);
  if(var_0.unittype == "soldier") {
    var_0 thread scripts\sp\anim::func_1ECC(var_0, "decompress");
  }

  var_5 = vectornormalize(var_4 - var_1.origin);
  var_6 = 1000;
  var_7 = distance(var_1.origin, var_4) / var_6;
  var_1 moveto(var_4, var_7, var_7 * 0.25, 0);
  wait(var_7);
  var_8 = var_4 + var_5 * 5000;
  var_7 = 5000 / var_6;
  var_1 moveto(var_8, var_7);
  wait(var_7);
  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_1 delete();
}

func_4FA7() {
  level endon("player_holding_on");
  if(scripts\engine\utility::flag("player_holding_on")) {
    return;
  }

  var_0 = scripts\sp\maps\europa\europa_util::func_5F32(scripts\engine\utility::getstruct("decompress_anim", "targetname"));
  var_0 scripts\sp\anim::func_1F35(level.var_EBBB, "decompress_intro");
  var_0 thread scripts\sp\anim::func_1EEA(level.var_EBBB, "decompress_loop");
  var_0 notify("stop_loop");
}

func_4FA8() {
  level.var_EBBC scripts\sp\anim::func_1F35(level.var_EBBC, "decompress");
}

func_AB59() {
  scripts\engine\utility::flag_set("start_decompress_player");
  thread func_111B4();
  thread func_4FB1();
  level.player playSound("scn_europa_decompression_suck");
  scripts\engine\utility::flag_wait("player_holding_on");
  thread func_224E();
}

func_4F9E() {
  scripts\engine\utility::flag_set("start_decompress_player");
  level.player thread scripts\sp\utility::func_DC45("lower");
  thread func_4FB1();
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player getradiuspathsighttestnodes();
  wait(0.1);
  var_0 = anglesToForward((-40, 0, 0));
  var_0 = var_0 * -500;
  physics_setgravity(var_0);
  wait(0.5);
  func_4FA3();
}

func_4FB1() {
  level endon("decompress_blackout");
  var_0 = getEntArray("decompression_body", "targetname");
  for(;;) {
    foreach(var_2 in var_0) {
      wait(randomfloatrange(1, 3));
      var_2.var_C1 = 1;
      var_3 = var_2 scripts\sp\utility::func_10619(1);
      if(!isDefined(var_3)) {
        continue;
      }

      var_3.var_DC1A = 1;
      var_3 func_81D0();
    }
  }
}

func_4FA4() {
  var_0 = scripts\sp\maps\europa\europa_util::func_5F32(scripts\engine\utility::getstruct("decompress_anim", "targetname"));
  var_1 = 10;
  var_2 = 485;
  var_3 = var_1;
  var_4 = 1;
  level.player.var_8632 rotateto((0, 0, 0), var_4, var_4 * 0.5, var_4 * 0.5);
  var_5 = var_4 * 20;
  var_6 = var_2 - var_1 / var_5;
  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_3 = var_3 + var_6;
    var_8 = vectornormalize(var_0.origin - level.player.origin) * var_3;
    level.player setvelocity(var_8);
    wait(0.05);
  }

  level.player getwholescenedurationmin(undefined);
}

func_4FAB() {
  scripts\sp\maps\europa\europa_util::func_107C5();
  scripts\sp\utility::func_F5AF("armory_tram_end_startpoint", [level.var_EBBB, level.var_EBBC, level.player]);
  func_95B6("armory_doors");
  level.var_220A = 1;
  scripts\engine\utility::flag_set("open_room2_doors");
  scripts\engine\utility::flag_set("open_room3_doors");
  setdvar("test_decompress", "1");
  thread func_4FA3();
}

func_4FA3() {
  var_0 = scripts\engine\utility::getstructarray("decompress_door_struct", "targetname");
  thread scripts\sp\utility::func_1034D("europa_plr_scramblingtofindso");
  var_1 = undefined;
  func_95A3();
  var_2 = 1;
  if(var_2) {
    var_3 = func_48CA(level.player.origin);
    thread func_5B56(var_3);
    var_4 = var_3.var_D648[var_3.var_D648.size - 1].origin;
    var_5 = 0;
    var_6 = 500;
    for(;;) {
      var_7 = func_7AB4(var_3, 100);
      if(!isDefined(var_7)) {
        break;
      }

      if(!isDefined(level.player.var_102E8)) {
        func_48CB();
      }

      var_7 = scripts\engine\utility::drop_to_ground(var_7, 10, -1000);
      var_8 = vectornormalize(var_7 - level.player.origin) * 800;
      level.player.var_102E8 moveslide((0, 0, 15), 15, var_8);
      var_9 = vectortoangles(var_4 - level.player.origin);
      var_0A = angleclamp180(var_9[1] - level.player.var_102E8.angles[1]) * 0.15;
      level.player.var_102E8.angles = level.player.var_102E8.angles + (0, var_0A, 0);
      wait(0.05);
    }
  }

  func_4F9F();
}

func_48CB() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0.angles = level.player.angles;
  level.player.var_102E8 = var_0;
  var_1 = 0.2;
  level.player playerlinktoblend(var_0, undefined, var_1);
  thread func_4FAA(var_1);
}

func_4FAA(var_0) {
  wait(var_0);
  if(!isDefined(level.player.var_102E8)) {
    return;
  }

  level.player playerlinktodelta(level.player.var_102E8, undefined, 0.4, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.4, 0, 0, 30, 20, 30, 10);
}

func_95A3() {
  var_0 = scripts\engine\utility::getstructarray("decompression_path", "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.path)) {
      continue;
    }

    var_3 = spawnStruct();
    var_4 = [];
    var_5 = var_2;
    for(;;) {
      if(var_4.size > 0) {
        var_4[var_4.size - 1].var_BF2E = var_5;
      }

      var_4[var_4.size] = var_5;
      if(!isDefined(var_5.target)) {
        break;
      }

      var_5 = scripts\engine\utility::getstruct(var_5.target, "targetname");
    }

    var_3.var_D648 = var_4;
    var_2.path = var_3;
  }
}

func_48CA(var_0) {
  var_1 = func_78C6(var_0);
  var_2 = spawnStruct();
  var_3 = [];
  var_4 = (var_0[0], var_0[1], var_1.origin[2]);
  var_3[var_3.size] = func_495D(var_4);
  var_5 = func_78C5(var_1.path, var_0);
  var_3[var_3.size] = func_495D(var_5.var_D3E3);
  var_3[var_3.size - 2].var_BF2E = var_3[var_3.size - 1];
  var_3[var_3.size - 1].var_BF2E = var_5.var_BF2E;
  for(;;) {
    if(!isDefined(var_3[var_3.size - 1].var_BF2E)) {
      break;
    }

    var_3[var_3.size] = var_3[var_3.size - 1].var_BF2E;
  }

  var_2.var_D648 = var_3;
  return var_2;
}

func_48EC(var_0) {
  var_1 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  var_2 = isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "main_path";
  var_3 = undefined;
  if(var_2) {
    if(level.var_10CDA == "decompress_test") {
      level.var_11B30 = spawnStruct();
      level.var_11B30.origin = (31739, -11736, -629);
      level.var_11B30.angles = (0, 0, 0);
    }

    var_4 = anglesToForward((0, level.var_11B30.angles[1], 0));
    var_3 = level.var_11B30.origin + var_4 * 180;
    var_3 = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, var_3);
  }

  var_5 = spawnStruct();
  if(var_2 && bullettracepassed(level.player getEye(), var_3, 0, undefined)) {
    var_5.origin = pointonsegmentnearesttopoint(var_3, var_1.origin, level.player.origin);
  } else {
    var_5.origin = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.player.origin);
  }

  var_5.target = var_0.target;
  var_5.var_BF2E = var_1;
  return var_5;
}

func_78C6(var_0) {
  var_1 = scripts\engine\utility::getstructarray("decompression_path", "targetname");
  foreach(var_3 in var_1) {
    var_3.var_429C = func_78C5(var_3.path, var_0);
  }

  var_5 = var_1[0].var_429C.var_56E8;
  var_6 = var_1[0];
  for(var_7 = 1; var_7 < var_1.size; var_7++) {
    var_3 = var_1[var_7];
    if(var_3.var_429C.var_56E8 < var_5) {
      var_5 = var_3.var_429C.var_56E8;
      var_6 = var_3;
    }
  }

  foreach(var_3 in var_1) {
    var_3.var_429C = undefined;
    foreach(var_0A in var_3.path.var_D648) {
      var_0A.var_56E8 = undefined;
    }
  }

  return var_6;
}

func_7AB4(var_0, var_1) {
  var_2 = undefined;
  for(var_3 = 5; var_3 > 1; var_3--) {
    var_2 = func_7AB3(var_0, var_1 * var_3);
    if(isDefined(var_2) && var_3 > 1 && func_AFFB(var_2)) {
      break;
    }
  }

  return var_2;
}

func_AFFB(var_0) {
  var_1 = scripts\common\trace::capsule_trace(level.player.origin, var_0, 15, 70, (0, 0, 0), level.player);
  if(var_1["fraction"] > 0.9) {
    return 1;
  }

  return 0;
}

func_7AB3(var_0, var_1) {
  var_2 = func_78C5(var_0, level.player.origin);
  var_3 = var_2.var_D3E3;
  var_4 = var_1;
  var_5 = undefined;
  var_6 = var_3;
  for(;;) {
    if(!isDefined(var_2.var_BF2E)) {
      var_5 = undefined;
      break;
    }

    var_7 = distance(var_3, var_2.var_BF2E.origin);
    if(var_7 > var_4) {
      var_8 = vectornormalize(var_2.var_BF2E.origin - var_2.origin);
      var_5 = var_3 + var_8 * var_4;
      break;
    } else {
      var_4 = var_4 - var_7;
      if(distance(var_3, var_2.origin) > var_1) {
        var_3 = var_3;
      } else {
        var_3 = var_2.var_BF2E.origin;
      }
    }

    if(!isDefined(var_2.var_BF2E)) {
      break;
    }

    var_2 = var_2.var_BF2E;
  }

  return var_5;
}

func_78C5(var_0, var_1) {
  var_2 = squared(99999);
  var_3 = undefined;
  foreach(var_5 in var_0.var_D648) {
    if(!isDefined(var_5.var_BF2E)) {
      break;
    }

    var_6 = pointonsegmentnearesttopoint(var_5.origin, var_5.var_BF2E.origin, level.player.origin);
    var_7 = distancesquared(var_6, level.player.origin);
    if(var_7 < var_2) {
      var_5.var_D3E3 = var_6;
      var_2 = var_7;
      var_5.var_56E8 = var_7;
      var_3 = var_5;
    }
  }

  return var_3;
}

func_495D(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  return var_1;
}

func_5B56(var_0) {}

func_4F9F() {
  var_0 = 485;
  var_1 = func_4F9B();
  level.player func_84FE();
  level.player.var_E505 = scripts\sp\player_rig::get_player_score(1);
  level.player.var_E505 hide();
  level.player.var_E505.angles = level.player.angles;
  var_2 = level.player.var_E505 scripts\sp\utility::func_7DC1(var_1);
  var_3 = scripts\engine\utility::getstruct("decompress_anim", "targetname");
  var_4 = getstartorigin(var_3.origin, var_3.angles, var_2);
  var_5 = getstartangles(var_3.origin, var_3.angles, var_2);
  var_6 = var_4;
  var_5 = vectortoangles(var_6 - level.player.var_E505.origin);
  thread func_4FA1();
  thread func_4FA0(level.player.var_E505);
  if(!isDefined(level.player.var_8632)) {
    level.player.var_8632 = spawn("script_origin", level.player.origin);
  }

  level.player playSound("scn_europa_decompression_suck");
  var_7 = distance(level.player.var_E505.origin, var_6);
  var_8 = func_E769(var_7 / var_0);
  var_9 = scripts\engine\utility::getstruct("decompress_angles", "targetname");
  level.player.var_E505 thread func_4FA2(var_6, var_8, var_8 * 0.5);
  var_5 = (0, var_5[1], var_5[2]);
  level.player.var_E505 rotateto(var_5, var_8 * 0.5, var_8 * 0.25);
  wait(var_8 - 0.2);
  var_0A = scripts\sp\utility::func_10639("player_rig");
  var_0A hide();
  level.player.var_E505 notify("stop_decompress_loop");
  scripts\engine\utility::flag_set("player_holding_on");
  level.var_EBBB scripts\sp\utility::anim_stopanimscripted();
  var_0B = [var_0A, level.var_EBBB];
  level.player.var_E505 delete();
  thread func_4FA0(var_0A);
  thread func_224E();
  var_3 scripts\sp\anim::func_1F2C(var_0B, var_1);
}

func_4F9B() {
  var_0 = scripts\engine\utility::getstructarray("decompress_side", "targetname");
  var_0 = sortbydistance(var_0, level.player.origin);
  var_1 = var_0[0];
  var_2 = "right_decompress";
  if(var_1.script_parameters == "left") {
    var_2 = "left_decompress";
  }

  return var_2;
}

func_E769(var_0) {
  return floor(var_0 / 0.05) * 0.05;
}

func_4FA0(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0.4;
  }

  level.player playerlinktoblend(var_0, "tag_player", var_1);
  wait(var_1);
  var_0 show();
  level.player playerlinktodelta(var_0, "tag_player", 0.4, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.4, 0, 0, 30, 20, 30, 10);
}

func_4FA2(var_0, var_1, var_2) {
  level.player.var_E505 endon("death");
  var_3 = 0.05;
  var_4 = length(level.player getvelocity());
  var_5 = distance(var_0, level.player.var_E505.origin);
  var_6 = var_4 + var_5 - var_4 * var_1 / var_1 - 0.5 * var_2;
  var_7 = gettime() + var_1 * 1000 - 100;
  var_8 = gettime() + var_2 * 1000;
  while(gettime() < var_7) {
    if(gettime() < var_8) {
      var_9 = var_4 + var_6 - var_4 / gettime() / var_8;
    } else {
      var_9 = var_6;
    }

    var_0A = vectornormalize(var_0 - level.player.var_E505.origin);
    var_0B = var_9 * var_3;
    level.player.var_E505.origin = level.player.var_E505.origin + var_0A * var_0B;
    wait(var_3);
  }
}

func_4FA9() {
  level endon("player_decompressed");
  var_0 = 1;
  for(;;) {
    var_1 = var_0 * 0.05;
    var_1 = min(var_1, 1);
    var_2 = randomfloatrange(0.25, 0.55) * var_1;
    var_3 = randomfloatrange(0.25, 0.55) * var_1;
    var_4 = randomfloatrange(0.1, 0.3) * var_1;
    level.player func_8291(var_2, var_3, var_4, 0.2, 0, 0, 700, 10, 10, 10);
    wait(0.2);
    var_0++;
  }
}

func_4FA1() {
  var_0 = level.player.var_E505;
  var_0 endon("stop_decompress_loop");
  var_1 = var_0 scripts\sp\utility::func_7DC1("decompress_loop");
  var_2 = "decompress_loop";
  for(;;) {
    var_0 func_82E7(var_2, var_1, 1, 0.2, 1);
    var_0 thread scripts\sp\anim::func_10CBF(var_0, var_2);
    var_0 scripts\anim\shared::donotetracks(var_2);
  }
}

func_4FA5(var_0, var_1) {
  var_1 = gettime() + var_1 * 1000;
  var_2 = 250000;
  while(distancesquared(level.player.origin, var_0.origin) > var_2) {
    wait(0.05);
  }

  var_3 = var_1 - gettime() * 0.001;
  level.player.var_E505 rotateto(var_0.angles, var_3, var_3);
}

func_4F97() {
  var_0 = getEntArray("armory_last_doors", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread func_4F96();
  }
}

func_4F96() {
  self.clip = getent(self.target, "targetname");
  var_0 = scripts\engine\utility::getstruct(self.target, "targetname");
  var_1 = self.getclosestpointonnavmesh3d;
  var_2 = undefined;
  var_3 = undefined;
  for(;;) {
    var_4 = distance(self.origin, var_0.origin);
    var_5 = var_4 / var_1;
    if(isDefined(var_0.var_EED2)) {
      var_2 = 1;
      self moveto(var_0.origin, var_5, 0, var_5);
      self rotateto(var_0.angles, var_5, 0, var_5);
    } else if(isDefined(var_2)) {
      var_2 = undefined;
      self moveto(var_0.origin, var_5, var_5, 0);
      self rotateto(var_0.angles, var_5, var_5, 0);
    } else {
      self moveto(var_0.origin, var_5);
      self rotateto(var_0.angles, var_5);
    }

    wait(var_5);
    if(!isDefined(var_0.target)) {
      var_6 = vectornormalize(var_0.origin - var_3.origin);
      var_7 = self.origin + var_6 * 10000;
      var_8 = var_0.angles - var_3.angles;
      break;
    }

    var_3 = var_0;
    var_0 = scripts\engine\utility::getstruct(var_0.target, "targetname");
  }

  var_4 = distance(self.origin, var_7);
  var_5 = var_4 / var_1;
  self moveto(var_7, var_5 * 0.5);
  self rotatevelocity(var_8, 50);
  wait(var_5);
  self delete();
}

func_C95E(var_0, var_1, var_2) {
  var_3 = var_2[2] - var_1[2];
  var_4 = 0;
  var_5 = [];
  var_6 = var_1;
  foreach(var_9, var_8 in var_0) {
    var_4 = var_4 + distance(var_6, var_8);
    var_5[var_9] = var_4;
    var_6 = var_8;
  }

  var_0A = [];
  foreach(var_9, var_8 in var_0) {
    var_0C = var_5[var_9] / var_4;
    var_0A[var_0A.size] = (var_8[0], var_8[1], var_1[2] + var_3 * var_0C);
  }

  return var_0A;
}

func_11B36() {
  var_0 = getaiarray("bad_guys");
  scripts\engine\utility::array_call(var_0, ::delete);
}

func_6F55(var_0) {
  var_0 waittill("trigger");
  if(isDefined(var_0.var_EDA0)) {
    scripts\engine\utility::flag_wait(var_0.var_EDA0);
  }

  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = var_0.script_count;
  for(var_3 = []; var_1.size > 0; var_3 = scripts\sp\utility::array_removedeadvehicles(var_3)) {
    if(var_3.size < var_2) {
      foreach(var_5 in var_1) {
        if(!isDefined(var_5)) {
          continue;
        }

        var_5.var_C1 = 1;
        var_6 = var_5 scripts\sp\utility::func_10619();
        if(isDefined(var_6)) {
          var_3[var_3.size] = var_6;
        }
      }
    }

    wait(0.1);
    var_1 = scripts\engine\utility::array_removeundefined(var_1);
  }
}

func_95B6(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  foreach(var_3 in var_1) {
    if(isDefined(var_3.var_C88D)) {
      continue;
    }

    var_4 = [var_3];
    var_3.var_C88D = 1;
    foreach(var_6 in var_1) {
      if(isDefined(var_6.var_C88D)) {
        continue;
      }

      if(var_6.script_parameters == var_3.script_parameters) {
        var_6.var_C88D = 1;
        var_4[var_4.size] = var_6;
      }

      if(!scripts\engine\utility::flag_exist("open_" + var_6.script_parameters)) {
        scripts\engine\utility::flag_init("open_" + var_6.script_parameters);
      }

      if(!scripts\engine\utility::flag_exist("close_" + var_6.script_parameters)) {
        scripts\engine\utility::flag_init("close_" + var_6.script_parameters);
      }
    }

    level thread func_59F8(var_4);
  }
}

func_59F8(var_0) {
  scripts\engine\utility::flag_wait("open_" + var_0[0].script_parameters);
  if(var_0[0].script_parameters == "room3_doors") {
    scripts\engine\utility::flag_wait("c12_fight_done_tram_go");
  }

  if(isDefined(var_0[0].var_EE88)) {
    setumbraportalstate(var_0[0].var_EE88, 1);
  }

  var_1 = scripts\sp\utility::func_7853(var_0);
  playworldsound("scn_europa_fspar_door_open", var_1);
  foreach(var_4, var_3 in var_0) {
    var_3 thread func_59B8(var_4);
    wait(randomfloat(0.1));
  }

  scripts\engine\utility::flag_wait("close_" + var_0[0].script_parameters);
  if(var_0[0].script_parameters == "room2_doors") {
    scripts\engine\utility::flag_wait("fspar_ready");
  }

  foreach(var_3 in var_0) {
    var_3 thread func_5986();
  }

  var_0[0] waittill("movedone");
  playworldsound("scn_europa_fspar_door_stop", var_1);
  if(isDefined(var_0[0].var_EE88)) {
    setumbraportalstate(var_0[0].var_EE88, 0);
  }
}

func_59B8(var_0) {
  if(func_9CD4("decompression") && level.var_10CDA != "decompress_test") {
    return;
  }

  var_1 = 3;
  if(isDefined(self.var_EEE5)) {
    var_1 = self.var_EEE5;
  }

  var_2 = scripts\engine\utility::getstruct(self.target, "targetname");
  self.var_C390 = self.origin;
  self.var_BE67 = getent(self.target, "targetname");
  if(isDefined(self.var_BE67)) {
    self.var_BE67 linkto(self);
  }

  thread func_59B4(var_2);
  var_3 = 4;
  var_4 = distance(var_2.origin, self.origin);
  var_5 = var_3 / var_4;
  var_6 = var_1 * var_5;
  var_7 = vectornormalize(var_2.origin - self.origin);
  var_8 = self.origin + var_7 * var_3;
  if(var_0 == 0) {
    thread func_59EA();
  }

  self moveto(var_8, var_6, var_6 * 0.1, var_6 * 0.1);
  self waittill("movedone");
  wait(0.2);
  var_1 = var_1 - var_6;
  self moveto(var_2.origin, var_1, var_1 * 0.1, var_1 * 0.1);
  self waittill("movedone");
  self.var_11083 = 1;
}

func_59EA() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  switch (self.script_parameters) {
    case "armory_doors":
      var_0 = "scn_europa_armory_door_open";
      var_1 = "scn_europa_armory_door_open_dist";
      var_2 = (34159, -11722, -443);
      playworldsound("scn_europa_armory_door_open_decompress", self.origin + (0, 0, 60));
      if(isDefined(level.var_11B30)) {
        level.var_11B30 scripts\engine\utility::delaycall(1.8, ::playsound, "scn_europa_armory_door_fspar_reveal");
      }
      break;

    case "room1_doors":
      var_0 = "scn_europa_armory_door_open_enemy";
      var_1 = "scn_europa_armory_door_open_enemy_dist";
      var_2 = (35607, -11722, -443);
      break;
  }

  if(isDefined(var_0)) {
    playworldsound(var_0, self.origin + (0, 0, 60));
  }

  if(isDefined(var_1)) {
    playworldsound(var_1, var_2);
  }
}

func_5986() {
  var_0 = 5;
  self moveto(self.var_C390, var_0, var_0 * 0.1, var_0 * 0.1);
  self waittill("movedone");
  if(isDefined(self.var_BE67)) {
    self.var_BE67 connectpaths();
  }
}

func_59B4(var_0) {
  if(!isDefined(self.var_BE68) && !isDefined(self.var_BE67)) {
    return;
  }

  if(self.classname == "script_brushmodel") {
    self connectpaths();
  }

  if(isDefined(self.var_BE67)) {
    while(!isDefined(self.var_11083)) {
      wait(0.1);
      self.var_BE67 disconnectpaths();
      wait(1);
      self.var_BE67 connectpaths();
    }
  }
}

func_2874() {
  scripts\engine\utility::flag_wait("selfdestruct_start");
  func_2873(5, 10, 2500, 3000);
  var_0 = 5000;
  var_1 = 10000;
  wait(4);
  var_2 = 0;
  var_3 = level.var_289B;
  var_4 = scripts\engine\utility::getstructarray("base_destruction_point", "targetname");
  var_5 = 0;
  var_6 = var_4[0];
  while(!scripts\engine\utility::flag("player_holding_on")) {
    if(gettime() >= var_2) {
      var_2 = gettime() + randomintrange(var_3.var_B7CD, var_3.var_B4CC);
      var_7 = undefined;
      var_4 = scripts\engine\utility::array_randomize(var_4);
      foreach(var_9 in var_4) {
        var_0A = distancesquared(var_9.origin, level.player.origin);
        if(var_0A < var_3.var_B7C8) {
          continue;
        }

        if(var_0A > var_3.setthreatbiasagainstall) {
          continue;
        }

        if(var_9 == var_6) {
          continue;
        }

        var_7 = var_9;
        break;
      }

      if(!isDefined(var_7)) {
        var_7 = scripts\engine\utility::random(var_4);
      }

      var_6 = var_7;
      func_537C(var_7);
    }

    wait(0.05);
  }
}

func_2873(var_0, var_1, var_2, var_3) {
  level.var_289B = spawnStruct();
  level.var_289B.var_B7CD = var_0 * 1000;
  level.var_289B.var_B4CC = var_1 * 1000;
  level.var_289B.var_B7C8 = squared(var_2);
  level.var_289B.setthreatbiasagainstall = squared(var_3);
}

func_537D(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);
  }

  var_2 = scripts\engine\utility::getstructarray(var_0, "targetname");
  scripts\engine\utility::array_levelthread(var_2, ::func_537C);
}

func_537C(var_0) {
  if(scripts\engine\utility::flag("pause_destruction_explosions")) {
    return;
  }

  var_1 = 3000;
  var_2 = 3;
  var_0 scripts\sp\utility::script_delay();
  if(isDefined(var_0.script_fxid)) {
    var_3 = anglesToForward(var_0.angles);
    playFX(scripts\engine\utility::getfx(var_0.script_fxid), var_0.origin, var_3);
  }

  thread func_532E(var_0.origin);
  if(isDefined(var_0.script_damage)) {
    radiusdamage(var_0.origin, 500, 200, 200, undefined, "MOD_EXPLOSIVE");
  }

  thread func_FB6C();
  level.player playSound("scn_euro_armory_quake_lr");
  screenshake(var_0.origin, 1, 1, 1, var_2, 0, var_2, var_1, 15, 2, 10);
  playrumbleonposition("heavy_2s", var_0.origin);
}

func_FB6C() {
  var_0 = [];
  var_0[0] = (35960, -11750, -520);
  var_0[1] = (35808, -11178, -520);
  var_0[2] = (35851, -12186, -520);
  var_0[3] = (36065, -11936, -520);
  var_0[4] = (36115, -11543, -520);
  var_0[5] = (34366, -10310, -520);
  var_0[6] = (34256, -13322, -520);
  var_1 = randomint(7);
  playworldsound("scn_europa_dist_expl", var_0[var_1]);
}

func_532E(var_0) {
  var_1 = scripts\engine\utility::getstructarray("explosion_dust", "targetname");
  if(!isDefined(level.var_532F)) {
    level.var_532F = 1;
    foreach(var_3 in var_1) {
      var_3.var_BFB3 = 0;
    }
  }

  var_1 = sortbydistance(var_1, var_0);
  var_5 = squared(100);
  var_6 = [];
  var_6[var_6.size] = var_1[0];
  var_7 = 10;
  foreach(var_3 in var_1) {
    if(gettime() < var_3.var_BFB3) {
      continue;
    }

    foreach(var_0A in var_6) {
      if(var_0A == var_3) {
        continue;
      }

      if(distance2dsquared(var_0A.origin, var_3.origin) > var_5) {
        var_6[var_6.size] = var_3;
        break;
      }
    }

    if(var_6.size == var_7) {
      break;
    }
  }

  var_0D = scripts\engine\utility::getfx("explosion_dust");
  for(var_0E = 0; var_0E < var_6.size; var_0E++) {
    if(isDefined(var_6[var_0E].script_fxid)) {
      playFX(scripts\engine\utility::getfx(var_6[var_0E].script_fxid), var_6[var_0E].origin);
    } else {
      playFX(var_0D, var_6[var_0E].origin);
    }

    var_6[var_0E].var_BFB3 = gettime() + 1000;
    wait(randomfloatrange(0, 0.1));
  }
}

func_10F7F() {
  level.player endon("death");
  var_0 = 0;
  var_1 = 0;
  var_2 = -10;
  var_3 = 1000;
  for(;;) {
    wait(0.05);
    if(level.player attackbuttonpressed()) {
      if(level.player getcurrentweapon() == "iw7_steeldragon+europaspeedmod") {
        if(!var_0) {
          var_1 = gettime();
        }

        var_0 = 1;
        var_4 = gettime() - var_1 / var_3;
        var_4 = min(var_4, 1);
        var_5 = anglesToForward(level.player.angles) * var_4 * var_2;
        level.player func_8251(var_5);
      }

      continue;
    }

    if(var_0) {
      var_0 = 0;
      var_5 = (0, 0, 0);
      level.player func_8251(var_5);
    }
  }
}

func_7558() {
  scripts\engine\utility::flag_wait("selfdestruct_start");
  scripts\engine\utility::flag_wait("tram_move");
  wait(5);
  func_16D4("button_room_stage1");
  scripts\engine\utility::flag_wait("open_room1_doors");
  wait(10);
  func_16D4("button_room_stage2");
  func_16D4("begin_ext_explosion");
  wait(10);
  func_16D4("button_room_stage3");
  func_16D4("begin_ext_explosion_02");
}

func_75D7() {
  scripts\engine\utility::flag_wait("open_room1_doors");
  func_16D4("room_1_stage1");
  scripts\engine\utility::flag_wait("open_room2_doors");
  wait(5);
  func_16D4("room_1_stage2");
  func_16D4("room1_ext_explosion_01");
  wait(20);
  func_16D4("room_1_stage3");
  func_16D4("room1_ext_explosion_02");
  scripts\engine\utility::flag_wait("c12_fight_done");
  func_16D4("room_1_stage4");
}

func_75D8() {
  scripts\engine\utility::flag_wait("c12_fight_done");
  wait(10);
  func_16D4("room_2_stage1");
  scripts\engine\utility::flag_wait("tram_room2_enter");
  wait(5);
  func_16D4("room_2_stage2");
}

func_7572() {
  scripts\engine\utility::flag_wait("open_room3_doors");
  func_16D4("decomp_room");
  scripts\sp\utility::func_10FEC("button_room_stage1");
}

func_A6EF() {
  scripts\engine\utility::flag_wait("tram_move");
  thread func_2212();
  var_0 = getEntArray("extra_corridor_klaxon_light", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::func_A6EE);
  thread func_DAED(1);
}

func_2212() {
  var_0 = scripts\engine\utility::play_loopsound_in_space("scn_europa_armory_destruct_alarm", level.player.origin) scripts\engine\utility::flag_wait("decompress_blackout");
  if(isDefined(var_0)) {
    var_0 stoploopsound();
    wait(0.05);
    var_0 delete();
  }
}

func_A6EE() {
  thread func_DAEC(0.25);
}

func_A6ED() {
  self notify("stop_pulse_loop");
  scripts\sp\maps\europa\europa_util::func_AC90(0, 0.5);
}

func_DAEC(var_0) {
  self endon("stop_pulse_loop");
  for(;;) {
    scripts\sp\maps\europa\europa_util::func_AC90(60, var_0);
    wait(var_0);
    scripts\sp\maps\europa\europa_util::func_AC90(0, var_0);
    wait(var_0);
  }
}

func_DAED(var_0) {
  var_1 = scripts\engine\utility::getstructarray("lab_emergency_light", "targetname");
  var_2 = [];
  foreach(var_4 in var_1) {
    var_5 = var_4 scripts\engine\utility::spawn_tag_origin();
    var_2[var_2.size] = var_5;
  }

  for(;;) {
    foreach(var_5 in var_2) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_light_emergency_flicker"), var_5, "tag_origin");
    }

    wait(var_0);
  }
}

func_1B20() {
  wait(0.1);
  var_0 = getEntArray("europa_monitor_light_red1", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::func_AC86);
  var_0 = getEntArray("europa_monitor_light_red2", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::func_AC86);
  var_0 = getEntArray("europa_monitor_light_blue1", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::func_AC87, 20);
  var_0 = getEntArray("europa_monitor_light_blue2", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::func_AC87, 10);
  var_1 = getscriptablearray("monitors", "targetname");
  scripts\sp\maps\europa\europa_util::func_EF3F(var_1, "part", "healthy", "healthy_blue");
  scripts\sp\maps\europa\europa_util::func_EF3F(var_1, "part", "dead", "dead_blue");
  scripts\engine\utility::flag_wait("tram_move");
}

alarm_lights_on() {
  var_0 = getEntArray("europa_monitor_light_blue1", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::func_AC86);
  var_0 = getEntArray("europa_monitor_light_blue2", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::func_AC86);
  var_0 = getEntArray("europa_monitor_light_red1", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::func_AC87, 5);
  var_0 = getEntArray("europa_monitor_light_red2", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::func_AC87, 5);
  var_1 = getscriptablearray("monitors", "targetname");
  scripts\sp\maps\europa\europa_util::func_EF3F(var_1, "part", "healthy_blue", "healthy_red");
  scripts\sp\maps\europa\europa_util::func_EF3F(var_1, "part", "health_healthy_blue", "healthy_red");
  scripts\sp\maps\europa\europa_util::func_EF3F(var_1, "part", "dead_blue", "dead_red");
}

func_9CD4(var_0) {
  var_1 = func_7A3A(var_0);
  var_2 = func_7A3A(level.var_10CDA);
  if(isDefined(var_1) && isDefined(var_2)) {
    return var_2 > var_1;
  }

  return undefined;
}

func_9CD5(var_0) {
  var_1 = func_7A3A(var_0);
  var_2 = func_7A3A(level.var_10CDA);
  if(isDefined(var_1) && isDefined(var_2)) {
    return var_2 < var_1;
  }

  return undefined;
}

func_7A3A(var_0) {
  foreach(var_3, var_2 in level.var_10C58) {
    if(var_2["name"] == var_0) {
      return var_3;
    }
  }

  return undefined;
}

func_16D4(var_0) {
  if(!isDefined(level.var_69B7)) {
    level.var_69B7 = [];
  }

  level.var_69B7[level.var_69B7.size] = var_0;
  scripts\engine\utility::exploder(var_0);
}

stop_far_cars() {
  foreach(var_1 in level.var_69B7) {
    scripts\sp\utility::func_10FEC(var_1);
  }

  level.var_69B7 = undefined;
}