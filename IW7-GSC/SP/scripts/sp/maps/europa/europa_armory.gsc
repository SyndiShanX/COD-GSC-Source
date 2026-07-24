/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\europa\europa_armory.gsc
****************************************************/

_id_220C() {
  level._id_7464 = 1;
  _id_96F2();
  precacheshader("icon_ks_sentry_gun_hud");
  precacheitem("iw7_jackal_support_designator");
  precachestring(&"EUROPA_FAILED_TO_ESCAPE");
  precachestring(&"EUROPA_FSPAR_SHOOT");
  scripts\sp\utility::_id_16EB("fspar_switch", &"EUROPA_FSPAR_SWITCH");
  scripts\sp\utility::_id_22C9("tram_enemy_spawner", ::_id_D70D);
  scripts\sp\utility::_id_22C9("tram_enemy_spawner_c6", ::_id_D70E);
  scripts\sp\utility::_id_22CA("lastroom_fleer_bridge", ::_id_D710);
  scripts\sp\utility::_id_22CA("lastroom_fleer", ::_id_D710);
  scripts\sp\utility::_id_9187("bfgtargeting", 10);
  scripts\engine\utility::trigger_off("tram_out_trigger", "script_noteworthy");
  scripts\engine\utility::trigger_off("initial_enemy_trigger", "script_noteworthy");
  scripts\engine\utility::trigger_off("self_destruct_triggers", "script_noteworthy");
  scripts\engine\utility::trigger_off("c12_fight_done_triggers", "script_noteworthy");
  var_0 = getEntArray("flood_spawn_count", "targetname");
  scripts\engine\utility::array_levelthread(var_0, ::_id_6F55);
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
  scripts\engine\utility::flag_init("self_destruct_tiimer_active");
  scripts\engine\utility::flag_init("self_destruction_start");
  scripts\engine\utility::flag_init("no_c12_death_save");
  level.player scripts\sp\utility::_id_65E0("c12_door_visible");

  if(_id_9CD5("outro"))
    _id_11B3F();

  scripts\sp\maps\europa\europa_util::_id_95E7(1);
}

_id_96F2() {
  var_0 = ["armory_doors", "room1_doors", "room2_doors", "room3_doors"];

  foreach(var_2 in var_0)
  setumbraportalstate(var_2, 0);
}

_id_5F16() {
  wait 2;
  var_0 = level._id_EBBB;
  var_0.goalradius = 32;

  for(;;) {
    if(level.player useButtonPressed()) {
      var_1 = _id_11A7E();

      if(isDefined(var_1))
        var_0 setgoalpos(var_1);

      wait 0.5;
    }

    wait 0.05;
  }
}

_id_11A7E() {
  var_0 = level.player getEye();
  var_1 = anglesToForward(level.player getplayerangles());
  var_0 = var_0 + var_1 * 30;
  var_2 = var_0 + var_1 * 10000;
  var_3 = bulletTrace(var_0, var_2, 1);
  var_4 = var_3["position"];

  if(distance(var_3["position"], var_4) < 0.1)
    return var_4;

  return undefined;
}

_id_9531() {
  if(isDefined(level._id_220A)) {
    return;
  }
  level._id_220A = 1;
  scripts\engine\utility::array_thread(getEntArray("airlock_fan_02", "targetname"), ::_id_6B81);
  setsaveddvar("sm_sunSampleSizeNear", 1);
  _id_95B6("armory_doors");
  thread _id_7558();
  thread _id_75D7();
  thread _id_75D8();
  thread _id_7572();
  thread _id_A6EF();
  thread _id_1B20();
}

_id_6B81() {
  self endon("death");
  var_0 = randomfloatrange(2, 10);

  for(;;) {
    self rotatepitch(90, var_0);
    wait(var_0);
  }
}

_id_224A() {
  var_0 = getEntArray("extra_corridor_klaxon_light", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::_id_A6ED);
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\sp\utility::_id_F5AF("armory_start_point", [level._id_EBBB, level._id_EBBC, level.player]);
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "raise");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(2, "current", &"EUROPA_OBJECTIVE_FSPAR", "tram_move");
}

_id_21A4() {
  scripts\engine\utility::flag_wait("player_entering_armory");
  _id_9531();

  if(isDefined(level._id_4074) && isDefined(level._id_4074["locker_c6s"]))
    scripts\sp\utility::_id_4075("locker_c6s");

  scripts\sp\utility::_id_28D8("axis");
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_54F7);
  thread _id_21DF();
  scripts\sp\maps\europa\europa_util::_id_6244(1);
}

_id_21DF() {
  wait 1;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_allclear3");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_sip_jackpotgoteyeson");
  scripts\engine\utility::flag_set("goto_vault_door");
}

_id_21CC() {
  setsuncolorandintensity(0.784314, 0.937255, 1, 2);

  if(level._id_10CDA == "outro") {
    return;
  }
  _id_9531();
  scripts\sp\maps\europa\europa_util::_id_6244(1);
  scripts\engine\utility::flag_set("goto_vault_door");
  scripts\sp\utility::_id_28D8("axis");
}

_id_7392() {
  var_0 = getnodearray("tram_friendly_path", "targetname");
  var_0 = sortbydistance(var_0, level._id_EBBB.origin);
  level._id_EBBB thread _id_11B3C(var_0[0]);
  level._id_EBBC thread _id_11B3C(var_0[1]);
}

_id_11B41() {
  var_0 = getnodearray("initial_battle_node", "script_noteworthy");
  var_0 = sortbydistance(var_0, level._id_EBBB.origin);
  level._id_EBBB _meth_82EE(var_0[0]);
  level._id_EBBC _meth_82EE(var_0[1]);
  scripts\engine\utility::flag_set("initial_enemy_flood_dead");
}

_id_1353A(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0;

  var_2 = 1;
  var_3 = getEnt(var_0, "targetname");

  for(;;) {
    var_4 = getaiarray("axis");
    var_5 = 0;
    var_6 = [];

    foreach(var_8 in var_4) {
      if(!isalive(var_8) || var_8 scripts\sp\utility::_id_58DA()) {
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
        if(!isDefined(var_8._id_91EF)) {
          var_8 notify("stop_going_to_node");
          var_8 thread _id_91E5();
        }
      }
    }

    var_12 = 0;

    if(!var_5) {
      if(var_1) {
        var_13 = getEntArray(var_3.target, "targetname");

        foreach(var_15 in var_13) {
          if(!isspawner(var_15)) {
            continue;
          }
          if(var_15.count > 0) {
            var_12 = 1;
            break;
          }
        }
      }

      if(!var_12) {
        break;
      }
    }

    wait 0.1;
  }
}

_id_91E5() {
  self endon("death");
  self endon("stop_hunt");
  self._id_91EF = 1;
  var_0 = 300;
  var_1 = distance(self.origin, level.player.origin);

  for(;;) {
    wait 2;
    self.goalradius = var_1;
    var_1 = var_1 - 175;
    self setgoalentity(level.player);

    if(var_1 < var_0)
      return;
  }
}

_id_2891() {
  var_0 = getEntArray("extra_corridor_klaxon_light", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::_id_A6ED);
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_F5AF, "selfdestruct_start_point", [level._id_EBBB, level._id_EBBC, level.player]);
  level._id_11B30._id_10DDB = 2000;
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "raise");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(2, "done", &"EUROPA_OBJECTIVE_FSPAR");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(3, "current", &"EUROPA_OBJECTIVE_ESCAPE");
}

_id_288C() {
  if(isDefined(level._id_4074) && isDefined(level._id_4074["office_fight"]))
    scripts\sp\utility::_id_4074("office_fight");

  var_0 = getnode("console_node_sipes", "targetname");
  level._id_EBBB thread _id_0B77::_id_8409(var_0);
  var_0 = getnode("console_node_t", "targetname");
  level._id_EBBC thread _id_0B77::_id_8409(var_0);
  scripts\engine\utility::flag_wait("goto_vault_door");
  thread _id_288F();
  scripts\engine\utility::flag_wait("selfdestruct_ready");
  var_1 = getEnt("selfdestruct_console_trigger", "targetname");
  var_2[0] = [level._id_EBBB, "europa_sip_overherewolf"];
  var_2[1] = [level._id_EBBB, "europa_sip_terminalssetrighth"];
  var_2[2] = [level._id_EBBC, "europa_tee_consolesreadywolf"];
  thread scripts\sp\utility::_id_6E7C("console_nags", scripts\sp\maps\europa\europa_util::_id_BE3C, var_2, "selfdestruct_in_range");
  var_3 = scripts\engine\utility::getStruct("console_self_destruct", "targetname");
  var_3 _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, 5000, 120, 0);
  var_1 waittill("trigger");
  scripts\engine\utility::flag_set("selfdestruct_in_range");
  scripts\engine\utility::array_thread(level._id_EBCA, ::_id_1C38, 0);
  var_3 waittill("trigger");

  if(isDefined(level._id_11B30._id_10DDB))
    level._id_11B30._id_10DDB = undefined;

  thread _id_C856();
  _id_288E();
  scripts\engine\utility::array_thread(level._id_EBCA, ::_id_1C38, 1);
  var_4 = getEntArray("tram_out_trigger", "script_noteworthy");
  scripts\engine\utility::array_thread(var_4, scripts\engine\utility::trigger_on);
  scripts\sp\utility::_id_2669("post_give_steeldragon");
  wait 10;
  thread _id_7392();
  scripts\engine\utility::flag_set("open_room1_doors");
  scripts\sp\utility::_id_22CD("tram_initial_enemies", 1);
  scripts\engine\utility::trigger_on("self_destruct_triggers", "script_noteworthy");
  thread _id_537D("armory_entry_explosion", 7);
  level._id_362B = spawnStruct();
  _id_0A05::_id_35A8(getEntArray("steeldragon_pickup", "targetname"), level._id_362B, &"hud_interaction_prompt_center_steel_dragon", undefined, 1);
}

_id_7393() {}

_id_10216() {
  scripts\engine\utility::flag_wait("sipes_mount_fspar");
  scripts\engine\utility::delaythread(1.75, scripts\sp\maps\europa\europa_util::_id_134B7, "europa_sip_rogillneedtime");
  wait 4;
  var_0 = getEnt("tram_interact", "script_noteworthy");
  level._id_EBBB linkTo(var_0);
  var_0 scripts\sp\anim::_id_1F35(level._id_EBBB, "fspar_boot_intro");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EBBB, "fspar_boot_idle");
  thread scripts\engine\utility::flag_set_delayed("selfdestruct_anim_done", 1.2);
  wait 1.5;
  thread _id_10215();
  thread _id_746D();
  var_0 notify("stop_loop");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_EBBB, "fspar_boot_exit");
  level._id_EBBB unlink();
  wait 1.1;
  scripts\engine\utility::flag_set("selfdestruct_start");
}

_id_746D() {
  playFXOnTag(scripts\engine\utility::getfx("fspar_light_red"), level._id_11B30._id_1021B, "tag_origin");
}

_id_746C() {
  stopFXOnTag(scripts\engine\utility::getfx("fspar_light_red"), level._id_11B30._id_1021B, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("fspar_light_green"), level._id_11B30._id_1021B, "tag_origin");
}

_id_288E() {
  var_0 = 0.4;
  level.player._id_E505 = scripts\sp\player_rig::get_player_score(1);
  level.player._id_E505 hide();
  level.player _meth_84FE();
  var_1 = getEnt("selfdestruct_console", "targetname");
  var_1._id_1FBB = "selfdestruct_console";
  var_1 scripts\sp\anim::_id_F64A();
  scripts\engine\utility::flag_set("tram_move");
  var_2 = [level.player._id_E505, level._id_EBBC, var_1];
  thread _id_4543();
  thread _id_10216();
  thread _id_115F9();
  var_1 thread scripts\sp\anim::_id_1F2C(var_2, "selfdestruct");
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player disableusability();
  level.player disableweapons();
  level.player _meth_823C(level.player._id_E505, "tag_player", var_0);
  wait(var_0);
  level.player playerlinktodelta(level.player._id_E505, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::delaycall(1.5, ::lerpviewangleclamp, 2, 0, 0, 3, 20, 30, 5);
  level.player._id_E505 show();
  level.player._id_E505 waittillmatch("single anim", "end");
  level.player._id_E505 delete();
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player enableusability();
  level.player enableweapons();
  level.player _meth_84FD();
  thread _id_2874();
}

_id_1C38(var_0) {
  if(var_0)
    self._id_1C78 = undefined;
  else
    self._id_1C78 = 0;
}

_id_115F9() {
  wait 5;
  var_0 = getnode("tee_after_handoff", "script_noteworthy");

  while(level._id_EBBC _meth_81A6())
    wait 0.05;

  level._id_EBBC _meth_82EE(var_0);
}

_id_10215() {
  var_0 = getnode("sipes_after_handoff", "script_noteworthy");

  while(level._id_EBBB _meth_81A6())
    wait 0.05;

  level._id_EBBB _meth_82EE(var_0);
}

_id_4543() {
  level.player _meth_81DE(55, 2);
  level waittill("dof_change");
  _id_0B0A::_id_583F(0, 194, 3, 100, 490, 3.2, 1.2);
  level waittill("dof_change");
  _id_0B0A::_id_583F(0, 0, 0, 68.1, 76.7, 1, 0.5);
  level waittill("dof_change");
  _id_0B0A::_id_583F(0, 0, 0, 0, 128.1, 2.6, 0.1);
  wait 1;
  level.player _meth_81DE(65, 0.25);
  _id_0B0A::_id_583D(0.05);
}

_id_C856() {
  scripts\engine\utility::flag_wait("pa_start");

  if(_id_9CD5("c12")) {
    _id_C84D("europa_pas_allpersonnel");
    wait 3;
    _id_C84D("europa_pas_evacuateimme");
    wait 6;
    _id_C84D("europa_pas_emergencyyou");
    wait 3;
  }

  var_0 = [];
  var_0[var_0.size] = ["europa_pas_allpersonnel"];
  var_0[var_0.size] = ["europa_pas_evacuateimme"];
  var_0[var_0.size] = ["europa_pas_thisisnotadrill", "europa_pas_immediateevac2"];
  var_0[var_0.size] = ["europa_pas_proceedtothe"];
  _id_C84B(var_0, "player_in_room1");
  scripts\engine\utility::flag_set("pa_burn_active");
  var_0 = [];
  var_0[var_0.size] = ["europa_pas_attentionopen", "europa_pas_proceedtothe"];
  var_0[var_0.size] = ["europa_pas_dangerburnsyst", "europa_pas_immediateevac1"];
  _id_C84B(var_0, "c12_fight_done");
  _id_C84D("europa_pas_warningcodered");
  _id_C84D("europa_pas_dangerselfdestruct1");
  var_0 = [];
  var_0[var_0.size] = ["europa_pas_emergencyself"];
  var_0[var_0.size] = ["europa_pas_attentionopen", "europa_pas_evacuateimme"];
  var_0[var_0.size] = ["europa_pas_thisisnotadrill", "europa_pas_immediateevac2"];
  var_0[var_0.size] = ["europa_pas_dangerburnsyst", "europa_pas_proceedtothe"];
  var_0[var_0.size] = ["europa_pas_dangeropenburn", "europa_pas_immediateevac1"];
  var_0[var_0.size] = ["europa_pas_dangerthiszone", "europa_pas_proceedtothe"];
  _id_C84B(var_0, "fspar_done_firing");
}

_id_C850(var_0, var_1) {
  scripts\sp\utility::_id_74D7(::_id_C84D, var_0, var_1);
}

_id_C84B(var_0, var_1) {
  for(;;) {
    if(_id_C854(var_1)) {
      break;
    }

    var_0 = scripts\engine\utility::array_randomize(var_0);

    foreach(var_3 in var_0) {
      if(_id_C854(var_1)) {
        break;
      }

      foreach(var_5 in var_3) {
        if(_id_C854(var_1)) {
          break;
        }

        _id_C84D(var_5, var_1);
      }

      wait(randomfloatrange(5, 9));
    }
  }
}

_id_C854(var_0) {
  if(isDefined(var_0))
    return scripts\engine\utility::flag(var_0);

  return 0;
}

_id_C84D(var_0, var_1) {
  if(_id_C854(var_1)) {
    return;
  }
  if(!isDefined(level._id_C845)) {
    level._id_C845 = spawnStruct();
    level._id_C845.is_playing = 0;
    level._id_C845.speakers = [];
    level._id_C845.speakers[0] = spawn("script_origin", (0, 0, 0));
    level._id_C845.speakers[1] = spawn("script_origin", (0, 0, 0));
    level._id_C845.speakers[1]._id_5709 = 1;
  }

  while(level._id_C845.is_playing > 0)
    wait 0.05;

  level._id_C845.speakers[0] thread _id_C84E(var_0);
  var_2 = scripts\engine\utility::getStructArray("pa_speaker", "targetname");

  while(level._id_C845.is_playing) {
    var_2 = sortbydistance(var_2, level.player.origin);

    foreach(var_6, var_4 in level._id_C845.speakers) {
      var_5 = var_6;

      if(var_5 == 0) {
        var_4.origin = var_2[var_6].origin;
        continue;
      }

      if(distance2dsquared(var_2[0].origin, var_2[var_5].origin) < 490000)
        var_5++;
    }

    wait 0.1;
  }
}

_id_C84E(var_0) {
  if(isDefined(self._id_5709))
    wait 0.3;

  level._id_C845.is_playing++;
  self playSound(var_0, "sound_done");
  self waittill("sound_done");
  wait 0.1;
  level._id_C845.is_playing--;
}

_id_C846() {
  scripts\engine\utility::array_call(level._id_C849, ::delete);
  level._id_C849 = undefined;
}

_id_288F() {
  level.player endon("death");
  scripts\sp\utility::_id_1034D("europa_plr_reaperwereatthe");
  scripts\engine\utility::flag_set("selfdestruct_ready");
  scripts\sp\utility::_id_10350("europa_rpr_copythatpackageis");
  scripts\sp\utility::_id_1034D("europa_plr_roger");

  if(!scripts\engine\utility::flag("tram_move"))
    scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_weaponsbehind");

  scripts\engine\utility::flag_set("console_nags");
  scripts\engine\utility::flag_wait("selfdestruct_anim_done");
  thread scripts\engine\utility::flag_set_delayed("pa_start", 3.7);
  scripts\sp\utility::_id_10350("europa_rpr_confirmedyouaregofor");
  wait 0.15;
  scripts\sp\utility::_id_1034D("europa_plr_copywereoscarmiker");
  scripts\sp\utility::_id_1034D("europa_plr_clocksticking");
  wait 0.25;
  scripts\engine\utility::delaythread(2.25, scripts\sp\maps\europa\europa_util::_id_134B7, "europa_plr_gohot");
  wait 4;
  wait 0.5;
  thread _id_B784();
}

_id_288D() {
  scripts\engine\utility::flag_set("tram_move");
  scripts\engine\utility::flag_set("open_armory_doors");
  scripts\engine\utility::flag_set("open_room1_doors");
  scripts\engine\utility::flag_set("pa_start");

  if(_id_9CD5("outro"))
    thread scripts\sp\maps\europa\europa_anim::_id_F2DF("idle");

  scripts\engine\utility::flag_set("selfdestruct_start");
  thread _id_2874();
  scripts\sp\maps\europa\europa_util::_id_117FF();
  level.player giveweapon("iw7_steeldragon+europaspeedmod");
  level.player switchtoweaponimmediate("iw7_steeldragon+europaspeedmod");

  if(_id_9CD5("outro")) {
    scripts\engine\utility::delaythread(3, ::_id_7392);
    scripts\engine\utility::trigger_on("self_destruct_triggers", "script_noteworthy");
    thread _id_C856();
  }

  if(_id_9CD5("decompression")) {
    level._id_362B = spawnStruct();
    _id_0A05::_id_35A8(getEntArray("steeldragon_pickup", "targetname"), level._id_362B, &"hud_interaction_prompt_center_steel_dragon", undefined, 1);
  }
}

_id_B784() {
  level endon("c12_spawn");
  level._id_B78A = spawnStruct();
  level._id_B78A._id_BFB3 = gettime() + 2000;
  level._id_B78A._id_29B5 = [];
  level._id_B78A._id_D3CA = 0;
  level._id_B78A.lastkilltime = -100000;
  level childthread _id_299F();
  var_0 = [];
  var_0[0] = [level.player, "europa_plr_getgunsonem"];
  var_0[1] = [level.player, "europa_plr_smokeem"];
  _id_1710(var_0, 15, 30, ::_id_299E);
  var_0 = [];
  var_0[0] = [level._id_EBBB, "europa_sip_eyeshigh"];
  var_0[1] = [level._id_EBBB, "europa_sip_tangosonthecatw"];
  var_0[2] = [level._id_EBBC, "europa_tee_hostilesuptop"];
  var_0[3] = [level._id_EBBC, "europa_tee_watchthecatwalk"];
  _id_1710(var_0, 13, 22, ::_id_2999, 0);
  var_0 = [];
  var_0[0] = [level._id_EBBB, "europa_sip_wegottadoubletim"];
  var_0[1] = [level._id_EBBC, "europa_tee_blastsaregettingclose"];
  _id_1710(var_0, 8, 16, ::_id_299C);
  var_0 = [];
  var_0[0] = [level._id_EBBC, "europa_tee_goodheatwolf"];
  _id_1710(var_0, 15, 25, ::_id_299B);
  var_0 = undefined;

  for(;;) {
    wait 0.05;

    if(gettime() < level._id_B78A._id_BFB3) {
      continue;
    }
    foreach(var_2 in level._id_B78A._id_29B5) {
      if(gettime() < var_2._id_BFB3) {
        continue;
      }
      if(var_2[[var_2.func]]()) {
        level._id_B78A._id_BFB3 = gettime() + randomfloatrange(2000, 4000);
        break;
      }
    }
  }
}

_id_299F() {
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
    level._id_B78A._id_D3CA++;
    level._id_B78A.lastkilltime = gettime();
  }
}

_id_299E() {
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
    _id_F2DD(1, 3);
    return 0;
  }

  _id_EB80();
  return 1;
}

_id_29A0() {
  _id_EB80();
  self._id_B759 = self._id_B759 + 5;
  self._id_B48D = self._id_B48D + 5;
  _id_F2DD();
  return 1;
}

_id_2999() {
  if(!isDefined(self._id_13540))
    self._id_13540 = getEntArray("catwalk_volume", "targetname");

  var_0 = 0;
  var_1 = getaiarray("axis");

  foreach(var_3 in self._id_13540) {
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
    _id_EB80();
    return 1;
  }

  return 0;
}

_id_299C() {
  _id_EB80();
  return 1;
}

_id_299B() {
  if(gettime() - level._id_B78A.lastkilltime > 500)
    return 0;

  if(level.player getcurrentweapon() != "iw7_steeldragon+europaspeedmod")
    return 0;

  _id_EB80();
  return 1;
}

_id_EB80() {
  var_0 = scripts\engine\utility::random(self._id_1B4A);

  if(isPlayer(var_0[0]))
    scripts\sp\utility::_id_1034D(var_0[1]);
  else
    var_0[0] scripts\sp\utility::_id_10346(var_0[1]);

  _id_F2DD();
}

_id_1710(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5._id_1B4A = var_0;
  var_5._id_B759 = var_1;
  var_5._id_B48D = var_2;
  var_5.func = var_3;
  var_5._id_BFB3 = 0;

  if(!isDefined(var_4))
    var_5 _id_F2DD();

  level._id_B78A._id_29B5[level._id_B78A._id_29B5.size] = var_5;
}

_id_F2DD(var_0, var_1) {
  if(isDefined(var_0))
    self._id_BFB3 = gettime() + randomfloatrange(var_0, var_1) * 1000;
  else
    self._id_BFB3 = gettime() + randomfloatrange(self._id_B759, self._id_B48D) * 1000;
}

_id_3568() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\sp\utility::_id_F5AF("c12_fight_start_point", [level._id_EBBB, level._id_EBBC, level.player]);
  level._id_11B30._id_10DDB = 1000;
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "raise");
  thread _id_B784();
  scripts\sp\utility::_id_22CD("tram_initial_enemies", 1);
  thread scripts\sp\utility::_id_1034D("europa_plr_letsgetitout");
  setmusicstate("mx_172_misslefight");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(2, "done", &"EUROPA_OBJECTIVE_FSPAR");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(3, "current", &"EUROPA_OBJECTIVE_ESCAPE");
  thread _id_746D();
}

_id_355E() {
  scripts\engine\utility::flag_set("c12_dead");
  scripts\engine\utility::flag_set("c12_fight_done");
  scripts\engine\utility::flag_set("open_room2_doors");
  scripts\engine\utility::flag_set("c12_fight_done_tram_go");

  if(isDefined(level._id_11B30))
    level._id_11B30._id_BCD2 = -50000;

  scripts\engine\utility::trigger_on("c12_fight_done_triggers", "script_noteworthy");
  _id_2873(3, 7, 1500, 2500);
  thread _id_E6D3();

  if(isDefined(level._id_11B30))
    level._id_11B30 _id_11B4F(100, 1);
}

_id_355D() {
  thread _id_10C48(17);
  scripts\engine\utility::flag_wait("player_in_room1");
  var_0 = getEntArray("armory_middle_traverse", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 _meth_80AC();

  thread _id_47EC();

  if(isDefined(level._id_11B30._id_10DDB))
    level._id_11B30._id_10DDB = undefined;

  thread _id_6476();
  thread _id_35B4();
  thread _id_353D();
  scripts\engine\utility::flag_wait("c12_spawn");
  setmusicstate("mx_172_misslefight");
  var_4 = scripts\sp\utility::_id_107EA("c12_spawner", 1);
  level._id_3508 = var_4;
  var_4._id_1FBB = "c12";

  if(level._id_7683 > 2)
    thread _id_10D13(70);

  thread _id_3536();
  thread _id_359A();
  thread _id_361F();
  thread _id_35E1();
  level._id_362B._id_3508 = var_4;
  var_4 _id_35B5();
  thread _id_3621();
  thread _id_3575();
  var_4 _id_0A05::_id_3554();
  var_5 = 4;
  var_4 scripts\engine\utility::delaythread(var_5, _id_0A05::_id_3551, 1);
  var_4 _id_0A05::_id_3540();
  var_4 _id_0A05::_id_3552(0);

  for(var_6 = getnode(var_4.target, "targetname"); isDefined(var_6.target); var_6 = getnode(var_6.target, "targetname")) {}

  var_4.og_goalradius = 2048;
  var_4.og_goalpos = var_6.origin;
  var_7 = getEntArray("player_exposed_trig", "targetname");
  scripts\engine\utility::array_thread(var_7, ::c12_player_exposed_think, var_5);
  var_4 thread _id_35FE();

  if(isalive(var_4))
    var_4 waittill("death");

  level._id_11B30 _id_11B4F(100, 1);
  scripts\engine\utility::flag_set("c12_fight_done");
  thread restore_c12_fight_trigs();

  foreach(var_9 in level._id_EBCA)
  var_9 scripts\sp\utility::_id_4145();

  _id_7392();

  if(!scripts\engine\utility::flag("no_c12_death_save"))
    scripts\sp\utility::_id_2669("c12_is_dead");

  wait 3;
  scripts\engine\utility::flag_set("c12_fight_done_tram_go");
  level._id_11B30._id_BCD2 = -50000;
  thread _id_E6D2();
}

restore_c12_fight_trigs() {
  var_0 = getEntArray("c12_fight_done_triggers", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_ED9A) && var_2._id_ED9A == "close_room1_doors") {
      var_2 thread trigger_on_when_tram_is_clear();
      continue;
    }

    var_2 scripts\engine\utility::trigger_on();
  }
}

trigger_on_when_tram_is_clear() {
  while(!is_tram_in_c12_room())
    wait 0.05;

  scripts\engine\utility::trigger_on();
}

is_tram_in_c12_room() {
  var_0 = getEnt("c12_room_middle", "targetname");

  if(isDefined(level._id_11B30))
    return level._id_11B30._id_32D9 istouching(var_0);
}

_id_35B4() {
  level.player endon("death");
  var_0 = 25;
  var_1 = gettime() + var_0 * 1000;
  var_2 = 0;
  var_3 = 20;
  var_4 = scripts\engine\utility::getStruct("c12_lookat", "targetname");
  wait 7;

  while(gettime() < var_1) {
    var_5 = distance2dsquared(level.player.origin, var_4.origin) < squared(750);

    if(_id_D284(var_5))
      var_2++;
    else {
      var_2--;
      var_2 = int(max(0, var_2));
    }

    if(var_2 == var_3) {
      level.player scripts\sp\utility::_id_65E1("c12_door_visible");
      break;
    }

    wait 0.05;
  }

  level.player scripts\sp\utility::_id_65E8("player_has_red_flashing_overlay");
  scripts\engine\utility::flag_set("c12_spawn");
  scripts\engine\utility::flag_set("open_room2_doors");
  thread _id_A5D9();
}

_id_D284(var_0) {
  var_1 = scripts\engine\utility::getStruct("c12_lookat", "targetname");
  var_2 = 0.88;
  var_3 = vectorNormalize(var_1.origin - level.player getEye());
  var_4 = level.player getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = 0;
  var_7 = vectordot(var_5, var_3);

  if(var_7 >= var_2) {
    if(var_0)
      return scripts\common\trace::ray_trace_passed(level.player getEye(), var_1.origin, level.player);
    else
      return 1;
  }

  return 0;
}

_id_10C48(var_0) {
  scripts\engine\utility::flag_wait_or_timeout("c12_spawn", var_0);
  scripts\engine\utility::flag_set("start_fallback");
}

c12_player_exposed_think(var_0) {
  level._id_3508 endon("death");
  level.player endon("death");
  var_1 = level._id_3508;
  wait(var_0 + 0.05);

  for(;;) {
    if(!level.player istouching(self))
      self waittill("trigger");

    if(!isDefined(level.player_exposed_trigger_count))
      level.player_exposed_trigger_count = 0;

    level.player_exposed_trigger_count++;
    var_2 = scripts\engine\utility::getStruct(self.target, "targetname");
    var_1 _id_0A05::_id_3551(0);
    var_1.goalradius = var_2.radius;
    var_1 setgoalpos(getclosestpointonnavmesh(var_2.origin, var_1));
    var_1 _id_0A05::_id_360D("left", level.player);
    var_1 _id_0A05::_id_360D("right", level.player);

    while(level.player istouching(self))
      wait 0.05;

    level.player_exposed_trigger_count--;

    if(level.player_exposed_trigger_count == 0) {
      var_1 _id_0A05::_id_352D("left");
      var_1 _id_0A05::_id_352D("right");
      var_1.goalradius = var_1.og_goalradius;
      var_1 setgoalpos(var_1.og_goalpos);
      var_1 _id_0A05::_id_3551(1);
    }
  }
}

_id_3621() {
  level._id_3508 endon("death");
  level._id_3508 endon("begin_rodeo");
  level.player endon("death");
  var_0 = 15000;

  for(;;) {
    while(!_id_3614())
      wait 0.05;

    var_1 = gettime() + var_0;
    var_2 = level.player _meth_8519(level.player getcurrentweapon());
    var_3 = 0;
    var_4 = 3;

    while(_id_3614()) {
      if(level.player _meth_8519(level.player getcurrentweapon()) != var_2) {
        var_2 = !var_2;
        var_3++;
      }

      if(gettime() >= var_1 || var_3 >= var_4) {
        scripts\sp\utility::_id_56BE("fspar_switch", 5);
        wait 5;
        var_1 = gettime() + var_0;
        var_3 = 0;
      }

      wait 0.05;
    }
  }
}

_id_3614() {
  var_0 = "iw7_steeldragon+europaspeedmod";

  if(!level.player hasweapon(var_0))
    return 0;

  if(level.player getcurrentweapon() == var_0)
    return 0;

  if(level.player getweaponammoclip(var_0) + level.player getweaponammostock(var_0) == 0)
    return 0;

  if(!level.console && !level.player usinggamepad())
    return 0;

  return 1;
}

_id_47EC() {
  scripts\engine\utility::flag_wait("pa_burn_active");
  scripts\engine\utility::flag_set("enemy_flee");
  thread _id_E6D0();
}

_id_2872(var_0) {
  var_1 = newhudelem();
  var_1.x = 0;
  var_1.y = 50;
  var_1.fontscale = 0.5;
  var_1.alignx = "center";
  var_1.aligny = "middle";
  var_1.horzalign = "center";
  var_1.vertalign = "top";
  var_1.hidewheninmenu = 0;
  var_1.hidewhendead = 1;
  var_1.font = "objective";
  var_1.alpha = 0;
  var_1 settenthstimer(var_0);
  var_1 fadeovertime(2.5);
  var_1.alpha = 1;
  var_1 changefontscaleovertime(0.2);
  var_1.fontscale = 2.7;
  wait 0.2;
  var_1 changefontscaleovertime(0.1);
  var_1.fontscale = 2.5;
  level._id_46B2 = var_1;
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
    level._id_46B2.color = (1, 0.1, 0.1);
    level._id_46B2 fadeovertime(var_3);
    wait(var_3);
    level._id_46B2.color = var_6;
    level._id_46B2 fadeovertime(var_3);
    wait(var_3);
    var_7 = var_1 - (gettime() - var_2);

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

  wait 1;
  var_4 delete();
}

_id_E6D0() {
  _id_2873(2, 5, 1500, 2500);
  wait(randomfloatrange(1, 2));
  _id_537D("room1_airvent_explosion");
  wait(randomfloatrange(1, 3));
  _id_537D("room1_console_explosions");
  thread _id_E6D1();
}

_id_E6D1() {
  level.player._id_8632 = spawn("script_origin", level.player.origin);
  level.player _meth_823F(level.player._id_8632);
  var_0 = 5;
  level.player._id_8632 rotateroll(5, var_0, var_0);
  var_1 = gettime() + var_0 * 1000;

  while(gettime() < var_1) {
    wait 0.05;
    _id_F352();
  }

  physics_setgravity((0, 0, -386.09));
  level.player _meth_8251((0, 0, 0));
  var_0 = 0.25;
  level.player._id_8632 rotateTo((0, 0, 0), var_0, var_0);
  screenshake(level.player.origin, 5, 1, 1, 1, 0, 1, 5000, 3, 2, 0);
}

_id_E6D2() {
  level endon("fspar_prefire");
  scripts\sp\specialist_MAYBE::halt_specialist_hints();
  _id_2873(0.5, 2.5, 500, 2500);
  childthread _id_E6D3();
  childthread _id_E6D4();
  wait(randomfloatrange(1, 3));
  _id_537D("room2_airvent_explosion");
  wait(randomfloatrange(1, 3));
  _id_537D("room2_closet_explosion");
}

_id_E6D3() {
  if(level._id_10CDA == "outro") {
    return;
  }
  level.player._id_8632 = spawn("script_origin", level.player.origin);
  level.player _meth_823F(level.player._id_8632);
  var_0 = 15;
  level.player._id_8632 rotateroll(10, var_0, var_0);
  var_1 = gettime() + var_0 * 1000;

  while(!scripts\engine\utility::flag("start_decompress_player")) {
    wait 0.05;
    _id_F352();
  }

  physics_setgravity((0, 0, -386.09));
}

_id_E6D4() {
  while(!scripts\engine\utility::flag("start_decompress_player")) {
    var_0 = randomfloatrange(0.2, 1);
    var_0 = min(var_0, 1);
    var_1 = randomfloatrange(0.1, 0.5) * var_0;
    var_2 = randomfloatrange(0.2, 0.5) * var_0;
    var_3 = randomfloatrange(0.05, 0.2) * var_0;
    level.player _meth_8291(var_1, var_2, var_3, 0.2, 0, 0, 700, 10, 10, 10);
    wait 0.2;
  }
}

_id_F352() {
  var_0 = level.player._id_8632.angles[2] * 5;
  var_1 = anglestoup(level.player._id_8632.angles + (0, 0, var_0));
  var_1 = var_1 * -300;
  physics_setgravity(var_1);
  var_2 = (var_1[0], var_1[1], 0) * 0.02;
  level.player _meth_8251(var_2);
}

_id_A9E2() {
  var_0 = 5;
  level.player._id_8632 rotatepitch(20, var_0, var_0);
}

_id_6476() {
  wait 1;
  var_0 = getEntArray("enemy_fleer", "targetname");
  var_1 = 2;
  var_2 = gettime() + 1500;

  while(var_1 > 0 && var_2 > gettime()) {
    var_3 = scripts\engine\utility::random(var_0);
    var_3.count = 1;
    var_4 = var_3 scripts\sp\utility::_id_10619();

    if(isDefined(var_4))
      var_1--;

    wait(randomfloatrange(0.25, 0.65));
  }
}

_id_35B5() {
  _id_35B6("head");
  _id_35B6("right_arm");
  _id_35B6("right_arm", "upper");
  _id_35B6("right_arm", "lower");
  _id_35B6("left_arm");
  _id_35B6("left_arm", "upper");
  _id_35B6("left_arm", "lower");
  _id_35B6("right_leg");
  _id_35B6("right_leg", "upper");
  _id_35B6("right_leg", "lower");
  _id_35B6("left_leg");
  _id_35B6("left_leg", "upper");
  _id_35B6("left_leg", "lower");
}

_id_35B6(var_0, var_1) {
  if(isDefined(var_1))
    var_2 = self _meth_850C(var_0, var_1);
  else
    var_2 = self _meth_850C(var_0);

  self _meth_8550(var_0, var_1, var_2 * 0.6);
}

_id_35FE() {
  var_0 = scripts\engine\utility::waittill_any_return("self_destruct", "death");

  if(var_0 == "death") {
    return;
  }
  level.player _meth_80CB(1);
  self waittill("death");
  thread _id_363D();
  wait 0.1;
  level.player _meth_80CB(0);
}

_id_353D() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("open_room2_doors");
  level.player setsoundsubmix("europa_c12_intro");
  wait 1;
  thread scripts\sp\utility::_id_1034D("europa_plr_ohshit");
  wait 1;
  level._id_EBBB scripts\sp\utility::_id_10346("europa_sip_c12");

  while(level.player _meth_819F())
    wait 0.05;

  level.player clearsoundsubmix();
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_sipesgetthatf");
  wait 0.1;

  while(level.player _meth_819F())
    wait 0.05;

  scripts\sp\maps\europa\europa_util::_id_134B7("europa_sip_itsnotreadyyet");
  var_0 = ["europa_sip_fanoutwelldraw", "europa_sip_wellhavetosplit"];
  level._id_EBBB thread scripts\sp\utility::_id_10346(scripts\engine\utility::random(var_0));
}

_id_35E1() {
  level._id_3508 endon("death");
  level endon("stop_c12_reactive_dialogue");
  scripts\engine\utility::flag_wait("open_room2_doors");
  wait 4;
  level._id_3508 thread _id_35E2("rocket_targeting", ["europa_tee_getouttathere", "europa_tee_rocketsgettocover"], level._id_EBBC);
  var_0 = [];
  var_0[0] = "europa_tee_wolfuseyourheavy";
  var_0[1] = "europa_tee_gethatheavyweapon";
  var_0[2] = "europa_tee_welldrawitsfire";
  var_1 = _id_3530(var_0, 5000, 15000);
  var_0 = [];
  var_0[0] = "europa_tee_targethisarm";
  var_0[1] = "europa_tee_stayonitwolf";
  var_2 = _id_3530(var_0, 3000, 7000);

  while(isalive(level._id_3508)) {
    wait 0.05;

    if(isDefined(level._id_35E1)) {
      var_3 = level._id_35E1.alias;
      var_4 = level._id_35E1.ent;
      level._id_35E1 = undefined;
      var_4 scripts\sp\utility::_id_10346(var_3);
      continue;
    }

    if(_id_35CE() && gettime() > var_1._id_BFB3) {
      var_5 = level.player getcurrentprimaryweapon();

      if(!weaponisbeam(var_5))
        level._id_EBBC _id_35F6(var_1);
      else
        var_1._id_BFB3 = var_1._id_BFB3 + 2000;
    }
  }
}

_id_3530(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_BE40 = var_0;
  var_3._id_B759 = var_1;
  var_3._id_B48D = var_2;
  var_3._id_BFB3 = gettime() + randomintrange(var_1, var_2);
  var_3._id_A87F = "";
  return var_3;
}

_id_35F6(var_0) {
  var_0._id_BFB3 = gettime() + randomintrange(var_0._id_B759, var_0._id_B48D);
  var_0._id_BE40 = scripts\engine\utility::array_randomize(var_0._id_BE40);
  var_1 = var_0._id_BE40[0];

  if(var_0._id_BE40.size > 1 && var_0._id_A87F == var_1)
    var_1 = var_0._id_BE40[1];

  var_0._id_A87F = var_1;
  scripts\sp\utility::_id_10346(var_1);
}

_id_35A9() {
  if(!isDefined(level._id_3508._blackboard.shootparams))
    return 0;

  return level._id_3508 _id_0C08::_id_9F7B("left");
}

_id_350F() {
  if(_id_782D() == 1)
    return 1;

  return 0;
}

_id_782D() {
  var_0 = 0;

  if(level._id_3508 scripts\asm\asm_bb::ispartdismembered("right_arm"))
    var_0++;

  if(level._id_3508 scripts\asm\asm_bb::ispartdismembered("left_arm"))
    var_0++;

  return var_0;
}

_id_35CE() {
  if(_id_782D() == 0)
    return 1;

  return 0;
}

_id_35E2(var_0, var_1, var_2) {
  self endon("death");

  for(;;) {
    self waittill(var_0);
    level._id_35E1 = spawnStruct();
    level._id_35E1.alias = scripts\engine\utility::random(var_1);
    level._id_35E1.ent = var_2;
    wait(randomfloatrange(8, 13));
  }
}

_id_10D13(var_0) {
  if(scripts\engine\utility::flag("self_destruct_tiimer_active")) {
    return;
  }
  scripts\engine\utility::flag_set("self_destruct_tiimer_active");

  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = 61 + var_0;

  switch (level._id_7683) {
    case 1:
    case 0:
      var_1 = 61 + var_0;
      break;
    case 3:
    case 2:
    default:
      var_1 = 46 + var_0;
      break;
  }

  scripts\engine\utility::delaythread(var_1, ::_id_D287);
  thread scripts\engine\utility::flag_set_delayed("no_c12_death_save", var_1 - 20.1);
  thread _id_2872(var_1);
}

_id_361F() {
  level endon("self_destruct_tiimer_active");

  while(isDefined(level._id_3508) && !isDefined(level._id_3508._id_30EA))
    wait 0.05;

  if(isDefined(level._id_3508) && isDefined(level._id_3508._id_E601)) {
    while(isalive(level._id_3508))
      wait 0.05;
  }

  thread _id_10D13(4);
}

_id_35F0() {
  if(isDefined(level._id_3508._id_30E8) && !level._id_3508._id_30E8) {
    return;
  }
  level._id_3508 endon("death");
  level._id_3508 waittill("begin_rodeo");
  level notify("stop_c12_reactive_dialogue");
  wait 0.6;
  scripts\sp\utility::_id_1034D("europa_plr_gotitfireinthehole");
}

_id_359A() {
  level._id_3508 endon("death");
  level._id_3508 waittill("self_destruct");
  thread _id_10D13(6);
  level notify("stop_c12_reactive_dialogue");
  wait 2;
  level._id_EBBC scripts\sp\utility::_id_10346("europa_tee_lookouthesgonna");
  thread _id_363D();
}

_id_3536() {
  level._id_3508 waittill("death");
  thread _id_10D13(0);
  wait 2;
  level._id_EBBC scripts\sp\utility::_id_10346("europa_tee_goodheatonthatcann");
  thread _id_363D();
}

_id_3532() {
  var_0 = level._id_3508;
  var_0 setCanDamage(1);
  var_0 _id_0A05::_id_3555("left", 0);
  var_0 _id_0A05::_id_3555("right", 0);
  var_1 = ["hip_pack_right", "hip_pack_left", "left_arm", "right_arm", "head"];

  foreach(var_3 in var_1)
  var_0 _meth_847D(var_3);

  wait 0.5;
  var_0.asm._id_4E73 = 1;
  var_0 _meth_81D0();
  thread _id_363D();
  scripts\engine\utility::flag_set("c12_dead");
}

_id_363D() {
  setmusicstate("");
  wait 2;
  setmusicstate("mx_351_tram_start");
}

_id_2AA5() {
  scripts\sp\maps\europa\europa_anim::_id_F2DF("powerup");
  scripts\sp\maps\europa\europa_anim::_id_F2DF("idle");
}

_id_3575() {
  level endon("c12_fight_done");
  var_0 = getEntArray("c12_right_cover_volume", "targetname");
  var_0 = scripts\engine\utility::array_combine(var_0, getEntArray("c12_left_cover_volume", "targetname"));

  foreach(var_2 in level._id_EBCA) {
    var_2.fixednode = 0;
    var_2 scripts\sp\utility::_id_4145();
    var_3 = sortbydistance(var_0, var_2.origin);

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_2 _id_7398(var_3[var_4])) {
        break;
      }
    }
  }

  while(!isDefined(level._id_3508))
    wait 0.1;

  level._id_3508.ignoreme = 1;
  var_6 = -1;
  var_7 = scripts\engine\utility::random(level._id_EBCA);
  var_8 = undefined;
  var_9 = undefined;

  for(;;) {
    var_10 = gettime();

    if(!isDefined(var_8) && _id_9C6B()) {
      if(var_6 == -1)
        var_6 = gettime() + 3000;
    } else
      var_6 = -1;

    if(isDefined(var_8)) {
      if(var_10 > var_9) {
        var_8 _id_7398(var_8._id_3FF5);
        var_8 = undefined;
      }
    } else if(var_6 > 0) {
      if(var_10 > var_6) {
        if(isDefined(var_7)) {
          foreach(var_2 in level._id_EBCA) {
            if(var_7 != var_2) {
              level._id_3508.ignoreme = 0;
              var_8 = var_2;
              var_7 = var_8;
              break;
            }
          }
        }

        var_9 = var_10 + 8000;
        var_8 _id_7399();
      }
    }

    wait 0.05;
  }
}

_id_9C6B() {
  if(!isalive(level._id_3508))
    return 0;

  if(!isDefined(level._id_3508._blackboard.shootparams))
    return 0;

  foreach(var_1 in level._id_3508._blackboard.shootparams._id_13CC3) {
    if(!isDefined(var_1.ent)) {
      continue;
    }
    if(isPlayer(var_1.ent))
      return 1;
  }

  return 0;
}

_id_7399() {
  var_0 = getnodearray(self._id_3FF5.target, "targetname");
  var_1 = scripts\engine\utility::random(var_0);
  self.goalradius = 32;
  self.threatbias = self.threatbias + 500;
  self _meth_82EE(var_1);
}

_id_56CE(var_0) {
  self notify("stop_display_state");
  self endon("stop_display_state");

  for(;;)
    wait 0.05;
}

_id_7398(var_0) {
  if(isDefined(var_0._id_3FF4) && var_0._id_3FF4 != self)
    return 0;

  var_0._id_3FF4 = self;
  self._id_3FF5 = var_0;

  if(self.threatbias >= 500)
    self.threatbias = self.threatbias - 500;

  self _meth_82F1(var_0);
  return 1;
}

_id_8EAA() {
  level._id_11B30 = getEnt("tram_brushmodel", "targetname");
  level._id_11B30._id_6664 = getEntArray(level._id_11B30.target, "targetname");

  foreach(var_1 in level._id_11B30._id_6664) {
    if(var_1.classname == "script_model")
      var_1 hide();
  }
}

_id_11B3F() {
  if(isDefined(level._id_11B30)) {
    return;
  }
  level._id_11B30 = getEnt("tram_brushmodel", "targetname");
  level._id_11B30._id_BCD2 = -400;
  level._id_11B30._id_6664 = getEntArray(level._id_11B30.target, "targetname");
  level._id_11B30._id_2AA2 = undefined;
  var_0 = getEntArray(level._id_11B30.target, "targetname");

  foreach(var_2 in var_0) {
    var_2 linkTo(level._id_11B30);

    if(var_2.model == "large_steel_dragon_transport_frame_01") {
      level._id_11B30._id_2AA2 = var_2;
      playFXOnTag(scripts\engine\utility::getfx("vfx_eu_base_hoverrail_distort"), var_0[0], "tag_origin");
      thread _id_11B50(var_0[0]);
      continue;
    }

    if(var_2.model == "large_steel_dragon_2x_scale") {
      level._id_11B30._id_7458 = var_2;
      continue;
    }

    if(var_2.model == "p7_desk_metal_military_03_tablet") {
      level._id_11B30._id_C85C = var_2;
      continue;
    }

    if(var_2.model == "electrical_airlock_cycle_button") {
      level._id_11B30._id_32D9 = var_2;
      continue;
    }

    if(var_2.model == "shipcrib_emergency_light")
      level._id_11B30._id_1021B = var_2;
  }

  level._id_11B30._id_BE67 = getEnt("tram_nav_clip", "targetname");
  level._id_11B30._id_BE67 connectpaths();
  level._id_11B30._id_BE67 linkTo(level._id_11B30);
  var_4 = scripts\engine\utility::getStruct("steel_dragon_gun_flash", "targetname");
  level._id_11B30._id_113F2 = spawn("script_model", var_4.origin);
  level._id_11B30._id_113F2.angles = var_4.angles;
  level._id_11B30._id_113F2 setModel("tag_flash");
  level._id_11B30._id_113F2 linkTo(level._id_11B30);
  var_5 = scripts\engine\utility::getStructArray(level._id_11B30.target, "targetname");
  level._id_11B30._id_C058 = [];

  foreach(var_7 in var_5) {
    var_7.offset = rotatevectorinverted(var_7.origin - level._id_11B30.origin, level._id_11B30.angles);
    var_7._id_C36A = level._id_11B30.angles - var_7.angles;
    level._id_11B30._id_C058[level._id_11B30._id_C058.size] = var_7;
  }

  var_9 = scripts\engine\utility::getStruct("tram_move_start", "targetname");
  var_10 = var_9;

  for(;;) {
    if(isDefined(var_9._id_EDA0))
      _id_12863(var_9._id_EDA0);

    if(isDefined(var_9._id_ED9E))
      _id_12863(var_9._id_ED9E);

    if(!isDefined(var_9.target)) {
      break;
    }

    var_9 = scripts\engine\utility::getStruct(var_9.target, "targetname");
  }

  level._id_11B30 thread _id_11B45(var_10);
}

_id_11B44() {
  var_0 = level._id_11B30.origin;
  wait 0.05;
  var_1 = level._id_11B30.origin;
  return var_1 != var_0;
}

_id_11B50(var_0) {
  scripts\engine\utility::flag_wait("tram_move");
  wait 3.4;
  thread scripts\engine\utility::exploder("dooropen");
  wait 8;
  playFXOnTag(scripts\engine\utility::getfx("vfx_eu_base_hoverrail_coldsmoke"), var_0, "tag_origin");
}

_id_12863(var_0) {
  if(!scripts\engine\utility::flag_exist(var_0))
    scripts\engine\utility::flag_init(var_0);
}

_id_496D(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = spawn("script_origin", var_1.origin);
  var_2.angles = var_1.angles;
  var_2 linkTo(level._id_11B30);
  var_3 = spawn("script_origin", var_0.origin);
  var_3 linkTo(level._id_11B30);
  var_2._id_22E8 = var_3;
  var_2.animation = var_1.animation;
  return var_2;
}

_id_11B45(var_0) {
  level notify("stop_tram_move");
  level endon("stop_tram_move");
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  self._id_5F75 = 0;

  if(isDefined(level._id_AC81))
    level._id_AC81["lift"].origin = var_0.origin;

  var_1["unlink_platform"] = ::_id_11B52;
  var_1["decompression_start_check"] = ::_id_11B37;
  var_1["c12_start_check"] = ::_id_11B34;
  var_1["tram_assemble"] = ::_id_11B32;
  scripts\engine\utility::flag_wait("tram_move");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(3, "current", &"EUROPA_OBJECTIVE_ESCAPE");
  thread _id_11B47();
  thread _id_11B48();
  var_2 = 0;
  var_3 = 80;

  for(;;) {
    if(!isDefined(var_0.target)) {
      break;
    }

    if(isDefined(var_0.script_noteworthy)) {
      if(isDefined(var_1[var_0.script_noteworthy]))
        [[var_1[var_0.script_noteworthy]]]();
    }

    var_4 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_0 scripts\sp\utility::script_delay();

    if(isDefined(var_0._id_EDA0)) {
      if(!scripts\engine\utility::flag(var_0._id_EDA0)) {
        _id_11B51();
        self.speed = 0;
        scripts\engine\utility::flag_wait(var_0._id_EDA0);
        _id_11B38();
      }
    }

    if(isDefined(var_0._id_ED9E))
      scripts\engine\utility::flag_set(var_0._id_ED9E);

    if(isDefined(var_0.speed))
      var_3 = var_0.speed;
    else
      var_3 = 50;

    _id_11B39(var_4, var_0, var_3);
    var_0 = var_4;
  }

  self notify("stop_moving");
  self._id_BE67 disconnectPaths();
  scripts\engine\utility::flag_set("fspar_ready");
  self stoploopsound("europa_armory_fspar_tram_lp");
}

_id_11B51() {
  foreach(var_1 in level._id_11B30._id_C058) {
    var_2 = "Cover Stand";

    if(isDefined(var_1.script_type))
      var_2 = var_1.script_type;

    var_3 = 0;

    if(isDefined(var_1.script_index))
      var_3 = var_1.script_index;

    var_4 = level._id_11B30.origin + rotatevector(var_1.offset, level._id_11B30.angles);
    var_5 = scripts\engine\utility::drop_to_ground(var_4, 15, -100);
    var_6 = level._id_11B30.angles + var_1._id_C36A;
    var_1.node = spawncovernode(var_5, var_6, var_2, var_3);
  }
}

debug_line(var_0, var_1) {
  for(;;)
    wait 0.05;
}

_id_11B38() {
  foreach(var_1 in level._id_11B30._id_C058) {
    if(isDefined(var_1.node))
      despawncovernode(var_1.node);
  }
}

_id_11B4F(var_0, var_1) {
  if(isDefined(var_1))
    self._id_EF81 = var_1;

  self._id_527C = var_0;
}

_id_7C96() {
  if(isDefined(self._id_10DDB))
    return self._id_10DDB;

  return self._id_527C;
}

_id_11B39(var_0, var_1, var_2) {
  self.goalpos = var_0.origin;
  self._id_4C18 = self.origin;

  if(!isDefined(self.speed))
    self.speed = 0;

  var_3 = 1;
  self._id_11937 = 0.2;
  var_4 = 1 * self._id_11937;
  var_5 = 2 * self._id_11937;

  if(!isDefined(self._id_EF81))
    _id_11B4F(var_2);

  self.forward = vectorNormalize(var_0.origin - var_1.origin);
  var_6 = distance(self._id_4C18, var_0.origin);
  var_7 = self.angles;

  while(!_id_11B4A(var_1, var_0)) {
    var_8 = _id_7C96();

    if(self._id_5F75) {
      var_9 = self._id_4C18 + self.forward * self._id_BCD2;

      if(vectordot(self.forward, vectorNormalize(level.player.origin - var_9)) > 0) {
        var_10 = _id_7D15(self.forward, var_9);
        self.speed = self.speed + var_4 * (var_8 * var_10);
        _id_11B53(var_8);
      } else if(self.speed > 0) {
        self.speed = self.speed - var_5 * var_8;
        _id_11B53(var_8);
      }
    } else {
      self.speed = self.speed + var_4 * var_8;

      if(self.speed > var_8)
        self.speed = var_8;

      _id_11B53(var_8);
    }

    var_11 = self._id_4C18;

    if(isDefined(self._id_90DF))
      var_11 = var_11 + self._id_90DF.origin;

    if(var_3)
      self moveTo(var_11, self._id_11937);
    else
      self.origin = var_11;

    var_12 = distance(self._id_4C18, var_0.origin) / var_6;
    self.angles = (var_0.angles - var_7) * var_12;
    wait(self._id_11937);
  }

  self.angles = var_0.angles;
}

_id_11B33() {
  self endon("death");
  level endon("fspar_ready");
  var_0 = 0;

  for(;;) {
    wait 0.05;

    if(self.speed > 0) {
      if(var_0 == 0) {
        self playSound("europa_armory_fspar_tram_start");
        self playLoopSound("europa_armory_fspar_tram_lp");
      } else {}
    } else if(var_0 > 0) {
      self playSound("europa_armory_fspar_tram_start");
      self stoploopsound();
    }

    var_0 = self.speed;
  }
}

_id_7D15(var_0, var_1) {
  var_2 = 500;
  var_3 = level._id_11B30._id_4C18 + var_0 * var_2 * -1;
  var_4 = pointonsegmentnearesttopoint(level._id_11B30._id_4C18, var_3, level.player.origin);
  var_5 = distance(level._id_11B30._id_4C18, var_4);
  var_6 = 1 - var_5 / var_2;
  return clamp(var_6, 0.05, 1);
}

_id_11B53(var_0) {
  self.speed = clamp(self.speed, 0, var_0);
  var_1 = self._id_11937 * self.speed;
  var_2 = self._id_4C18 + self.forward * var_1;
  self._id_4C18 = var_2;
}

_id_11B4A(var_0, var_1) {
  var_2 = squared(16);

  if(distancesquared(self._id_4C18, var_1.origin) < var_2)
    return 1;

  var_3 = vectorNormalize(var_1.origin - var_0.origin);

  if(vectordot(var_3, vectorNormalize(self._id_4C18 - var_1.origin)) > 0)
    return 1;

  return 0;
}

_id_11B3E() {
  var_0 = (0, 0, 0);
  self._id_90DF = spawn("script_origin", var_0);
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
    var_10 = randomfloatrange(var_5, var_6);
    var_11 = randomfloatrange(var_7, var_8);
    var_12 = var_0 + (var_9, var_10, var_11);
    var_13 = randomfloatrange(var_1, var_2);
    self._id_90DF moveTo(var_12, var_13, var_13 * 0.5, var_13 * 0.5);
    wait(var_13);
    var_9 = randomfloatrange(var_3, var_4);
    var_10 = randomfloatrange(var_5, var_6);
    var_11 = randomfloatrange(var_7, var_8) * -1;
    var_12 = var_0 + (var_9, var_10, var_11);
    var_13 = randomfloatrange(var_1, var_2);
    self._id_90DF moveTo(var_12, var_13, var_13 * 0.5, var_13 * 0.5);
    wait(var_13);
  }
}

_id_11B37() {
  if(level._id_10CDA == "decompression") {
    self._id_10DDB = undefined;
    wait 1;
  }
}

_id_11B34() {
  if(level._id_10CDA == "c12") {
    self._id_10DDB = undefined;
    wait 1;
  }
}

_id_11B32() {
  self._id_5F75 = 1;
  scripts\engine\utility::flag_set("tram_assemble_pos");
  self.speed = 0;
  thread _id_11B33();
  scripts\engine\utility::flag_wait("selfdestruct_start");
}

_id_11B48() {
  self endon("stop_moving");
  var_0 = 300;
  var_1 = 200;
  var_2 = 400;
  var_3 = anglesToForward(self.angles + (0, 180, 0));
  var_4 = anglestoright(self.angles + (0, 180, 0));
  var_5 = var_4 * 140;
  var_6 = var_4 * 500;
  level._id_6B86 = [];
  level._id_BE84 = [];
  level._id_A66C = [];

  for(;;) {
    var_7 = _id_79B2(var_3, var_2);
    self._id_6B86[0] = var_7 + var_5;
    self._id_6B86[1] = var_7 + var_5 * -1;
    var_8 = self.origin + var_3 * var_1;
    self._id_BE84[0] = var_8 + var_6;
    self._id_BE84[1] = var_8 + var_6 * -1;
    wait 0.05;
  }
}

_id_79B2(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct("farplane_cap", "targetname");
  var_3 = self.origin + var_0 * var_1;

  for(;;) {
    if(!scripts\engine\utility::flag(var_2._id_EDA0)) {
      break;
    }

    if(!isDefined(var_2.target)) {
      var_2 = undefined;
      break;
    }

    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }

  if(isDefined(var_2)) {
    if(vectordot(var_0, vectorNormalize(var_3 - var_2.origin)) > 0)
      var_3 = var_2.origin;
  }

  return var_3;
}

_id_11B47() {
  self endon("stop_moving");
  wait 1;

  for(;;) {
    wait 0.5;
    self._id_BE67 connectpaths();
    var_0 = self._id_4C18;
    wait 0.1;
    self._id_BE67 disconnectPaths();

    while(var_0 == self._id_4C18)
      wait 0.05;
  }
}

_id_11B3C(var_0) {
  self endon("death");
  self notify("stop_follow_tram");
  self endon("stop_follow_tram");
  self._id_3912 = 0;
  self.goalradius = 32;
  var_1 = var_0;
  var_2 = var_0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 1;
  var_6 = anglesToForward(level._id_11B30.angles + (0, 180, 0));
  var_7 = 50;

  for(;;) {
    var_8 = level._id_11B30._id_4C18 + var_6 * var_7;

    if(var_5) {
      while(vectordot(var_6, vectorNormalize(var_1.origin - var_8)) < 0) {
        var_9 = getnodearray(var_1.target, "targetname");
        var_2 = var_1;
        var_1 = scripts\engine\utility::random(var_9);
      }

      var_5 = 0;
      var_1 = var_2;
    }

    if(vectordot(var_6, vectorNormalize(var_1.origin - var_8)) < 0) {
      if(!isDefined(var_1.target)) {
        break;
      }

      var_9 = getnodearray(var_1.target, "targetname");
      var_1 = scripts\engine\utility::random(var_9);
      thread _id_11B3D(var_1);
    }

    wait 0.1;
  }
}

_id_11B3D(var_0) {
  self notify("new_friendly_path_node");
  self endon("new_friendly_path_node");
  self endon("stop_follow_tram");
  self endon("death");

  if(self._id_3912)
    wait(randomfloatrange(1, 3));

  self _meth_82EE(var_0);
  self._id_3912 = 1;
  self waittill("goal");
  wait(randomfloat(1));
  self._id_3912 = 0;
}

_id_11B52() {
  foreach(var_1 in level._id_AC81)
  var_1 unlink();

  level._id_AC81 = undefined;
}

_id_11B4C() {
  thread _id_11B3B();
  scripts\engine\utility::flag_wait("tram_enemies_alive");
  scripts\engine\utility::flag_set("open_tram_doors3_dialogue");
}

_id_11B3B() {
  var_0 = getEnt("tram_out_volume", "targetname");

  for(;;) {
    wait 0.1;
    var_1 = getaiarray("bad_guys");
    var_2 = 1;

    foreach(var_4 in var_1) {
      if(var_4 scripts\sp\utility::_id_58DA()) {
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

_id_11B35() {}

_id_11B3A() {
  scripts\engine\utility::flag_set("tram_pre_blow_doors");
}

_id_21DB() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\sp\utility::_id_F5AF("armory_tram_end_startpoint", [level._id_EBBB, level._id_EBBC, level.player]);
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "raise");
  scripts\engine\utility::flag_set("tram_move");
  scripts\engine\utility::delaythread(30.5, ::_id_D287);
  thread _id_2872(30.5);
  level._id_11B30._id_10DDB = 2000;
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(2, "done", &"EUROPA_OBJECTIVE_FSPAR");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(3, "current", &"EUROPA_OBJECTIVE_ESCAPE");
  thread _id_746D();
}

_id_D70D() {
  self endon("death");

  if(!scripts\engine\utility::flag("c12_spawn"))
    thread _id_652C();

  scripts\engine\utility::flag_wait("c12_spawn");
  scripts\sp\utility::_id_51E1("frantic");
  thread _id_6474();
}

_id_D710() {
  self._id_C061 = 1;
}

_id_6474() {
  self endon("death");
  self notify("stop_enemy_think");
  self clearenemy();

  if(distancesquared(self.origin, level.player.origin) > squared(500))
    self.ignoreall = 1;

  scripts\engine\utility::flag_wait("open_room2_doors");
  self.goalradius = 130;
  _id_F3DB("enemy_flee_struct");
  self waittill("goal");
  scripts\engine\utility::flag_wait("kill_enemy_fleers");
  wait 0.25;

  if(scripts\engine\utility::cointoss())
    self.forceragdollimmediate = 1;

  wait(randomfloat(0.5));
  self _meth_81D0();
}

_id_A5D9() {
  var_0 = getEnt("enemy_flee_volume", "targetname");

  for(;;) {
    wait 0.05;
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
      if(var_4 istouching(var_0))
        var_7++;
    }

    if(var_7 > var_6 * 0.75) {
      level._id_6475 = 1;
      _id_537D("room2_closet_explosion");
      scripts\engine\utility::flag_set("kill_enemy_fleers");
      return;
    }
  }
}

_id_F3DB(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 32;

  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_4 = pointonsegmentnearesttopoint(var_2.origin, var_3.origin, self.origin);
  var_4 = scripts\engine\utility::drop_to_ground(var_4, 10, -200);
  self.goalradius = var_1;
  self setgoalpos(var_4);
}

_id_D70E() {
  thread _id_652C();
}

_id_652C() {
  self endon("death");
  self endon("stop_enemy_think");
  scripts\engine\utility::flag_wait("armory_enemy_fallback");
  wait 0.1;
  self notify("stop_going_to_node");

  if(_id_1024C()) {
    return;
  }
  var_0 = getEnt("enemy_fallback_room1", "targetname");

  if(isDefined(self._id_91EF)) {
    self notify("stop_hunt");
    self setgoalpos(self.origin);
  }

  self _meth_82F1(var_0);
  scripts\engine\utility::flag_wait("start_fallback");
  var_0 = getEnt("c12_backhalf", "targetname");
  wait(randomfloat(1));
  self _meth_82F1(var_0);
}

_id_1024C() {
  if(self.unittype != "c6")
    return 0;

  if(_id_0A0B::_id_2040())
    return 1;

  if(scripts\asm\asm_bb::_id_293E())
    return 1;

  return 0;
}

_id_D287(var_0) {
  if(!isDefined(var_0))
    wait 1;

  if(scripts\engine\utility::flag("player_on_fspar")) {
    return;
  }
  scripts\engine\utility::flag_set("self_destruction_start");
  level.player freezecontrols(1);
  playFX(scripts\engine\utility::getfx("explosion_med"), level.player.origin + anglesToForward(level.player.angles) * 70);
  earthquake(0.6, 0.5, level.player.origin, 100);
  playworldsound("scn_europa_window_explosion", level.player.origin);

  if(!isDefined(var_0))
    _id_0B60::_id_F322("EUROPA_FAILED_TO_ESCAPE");

  level.player _meth_80A1();
  magicgrenademanual("frag", level.player.origin, (0, 0, 0), 0);
  wait 0.5;

  foreach(var_2 in level._id_EBCA) {
    var_2 scripts\sp\utility::_id_1101B();
    var_2 scripts\sp\utility::_id_54C6();
  }

  if(isalive(level.player))
    level.player scripts\sp\utility::_id_54C6();
}

_id_2AC3() {
  var_0 = scripts\sp\utility::_id_22CD("final_stand", 1);
  thread _id_138EF();
  thread _id_CFA3(var_0);
  thread _id_6C29(var_0);

  foreach(var_2 in var_0)
  var_2 _id_0A05::_id_353F();

  scripts\engine\utility::flag_wait("fspar_ready");
  thread _id_746C();
  scripts\engine\utility::array_thread(level._id_EBCA, ::_id_1C38, 0);
  thread _id_134D9();
  thread _id_5530();
  wait 1.5;
  thread _id_D294();
  scripts\engine\utility::flag_wait("player_on_fspar");
  setmusicstate("");
  level.player scripts\engine\utility::delaycall(2.0, ::playsound, "scn_europa_fspar_button");
  stopFXOnTag(scripts\engine\utility::getfx("fspar_light_green"), level._id_11B30._id_1021B, "tag_origin");
  var_4 = 3.2;
  wait(var_4);
  var_5 = 2.5;
  var_6 = 0.5;
  thread _id_111B3();
  thread _id_3D24(var_5);
  scripts\engine\utility::delaythread(var_5, ::_id_FED5, var_6);
  thread scripts\engine\utility::flag_set_delayed("fspar_prefire", var_5 - 1);
  thread scripts\engine\utility::flag_set_delayed("fspar_done_firing", var_6 + var_5);
  thread _id_7468(var_5, var_6, var_0);
  thread _id_7463(var_5, var_6);
  scripts\engine\utility::delaythread(var_5 + var_6 + 1, scripts\engine\utility::exploder, "decomp_room");
  scripts\engine\utility::delaythread(var_5 + 0.2, ::_id_3576, var_0);
  scripts\engine\utility::delaythread(var_5 + var_6, ::_id_FED5, 0.25);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), ::_id_A9E0);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), ::_id_4FAC);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), ::_id_4F99);
  scripts\engine\utility::delaythread(var_5 + 0.05, ::_id_4F97);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), ::_id_4FA9);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), scripts\sp\maps\europa\europa_util::_id_6F30);
  scripts\engine\utility::delaythread(var_5 + var_6 + randomfloatrange(0.05, 0.25), ::_id_224B);
  wait(var_5 + var_6);
  wait 3;
  scripts\engine\utility::flag_set("new_decompress_anim");
}

_id_111B3() {
  scripts\engine\utility::flag_wait("fspar_prefire");
  var_0 = anglesToForward((-40, 0, 0));
  var_0 = var_0 * -500;
  physics_setgravity(var_0);
}

_id_138EF() {
  scripts\engine\utility::flag_wait("player_asking_for_it");

  if(!scripts\engine\utility::flag("player_on_fspar"))
    scripts\sp\maps\europa\europa_util::_id_134B7("europa_sip_wolfdongoout");
}

_id_134D9() {
  level.player endon("death");
  level._id_EBBB endon("death");
  level._id_EBBC endon("death");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_sipeswherestheweap");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_sip_fsparsonline");
  var_0 = scripts\engine\utility::array_randomize(["europa_tee_hitemwiththefspar", "europa_tee_usethefsparor"]);

  for(;;) {
    foreach(var_2 in var_0) {
      if(scripts\engine\utility::flag("player_on_fspar")) {
        return;
      }
      scripts\sp\maps\europa\europa_util::_id_134B7(var_2);
      wait 2;
    }
  }
}

_id_7463(var_0, var_1) {
  thread _id_0B0A::_id_583F(0, 1199, 2, 80000, 90000, 0, var_0);
  level.player _meth_81DE(60, var_0);
  wait(var_0 + var_1);
  _id_0B0A::_id_583D(0.05);
  level.player _meth_81DE(65, 0.05);
}

_id_746F(var_0) {
  setslowmotion(1, 0.5, 0.1);
  wait(var_0 + 0.1);
  scripts\sp\utility::_id_10322();
}

_id_5530() {
  scripts\engine\utility::flag_set("pause_destruction_explosions");
  stop_far_cars();
}

_id_FED5(var_0) {
  level.player stoprumble("steady_rumble");
  earthquake(0.75, 0.65, level.player.origin, 500);
  level.player playRumbleOnEntity("heavy_2s");
  level.player viewkick(25, level.player getEye(), 0);
}

_id_3D24(var_0) {
  level endon("stop_charge_shake");
  level thread scripts\sp\utility::_id_C12D("stop_charge_shake", var_0);
  var_1 = 1;
  level.player _meth_8244("steady_rumble");

  for(;;) {
    var_2 = var_1 * 0.5;
    var_2 = min(var_2, 1);
    var_3 = randomfloatrange(0.2, 0.6) * var_2;
    var_4 = randomfloatrange(0.2, 0.5) * var_2;
    var_5 = randomfloatrange(0.1, 0.2) * var_2;
    level.player _meth_8291(var_3, var_4, var_5, 0.2, 0, 0, 700, 10, 10, 10);
    wait 0.2;
    var_1++;
  }
}

_id_CFA3(var_0) {
  thread _id_CFCD();
  wait 1;
  var_1 = [];

  foreach(var_3 in scripts\engine\utility::getStructArray("c12_rocket_target", "targetname"))
  var_1[var_1.size] = scripts\engine\utility::spawn_script_origin(var_3.origin);

  level._id_3623 = var_1;
  scripts\engine\utility::array_thread(var_0, ::_id_6AD9);
  scripts\engine\utility::array_thread(var_0, ::_id_10FC7);
  scripts\engine\utility::flag_wait("player_asking_for_it");
  wait 1.25;
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  scripts\engine\utility::array_thread(var_0, ::_id_24C1);
}

_id_CFCD() {
  level endon("player_on_fspar");
  level.player endon("death");
  scripts\engine\utility::flag_wait("player_in_decompression_area");
  _id_D287(1);
}

_id_24C1() {
  self endon("death");
  level endon("player_on_fspar");
  level.player endon("death");

  for(;;) {
    if(_id_FFA7()) {
      level.player.ignoreme = 0;
      self notify("attacking_player");
      self._id_2894 = 5;
      _id_0A05::_id_3555("right", 1);
      _id_0A05::_id_3555("left", 1);
      _id_0A05::_id_360D("right", level.player, "rockets_done", 1);
      _id_0A05::_id_360D("left", level.player, "mg_done", 1);

      while(_id_FFA7())
        wait 0.5;
    } else {
      _id_0A05::_id_352D("left");
      _id_0A05::_id_352D("right");
      _id_6AD9();

      while(!_id_FFA7())
        wait 0.5;
    }

    wait 0.5;
  }
}

_id_10FC7() {
  scripts\engine\utility::flag_wait("player_on_fspar");
  _id_6AD9();
}

_id_6AD9() {
  self._id_2894 = 1;
  self.ignoreall = 0;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "rockets") {
    thread _id_E5DF();
    return;
  } else if(isDefined(self.script_noteworthy) && self.script_noteworthy == "mg") {
    _id_0A05::_id_3555("left", 1);
    _id_0A05::_id_3553(1);
    return;
  }

  thread _id_3BA9();
}

_id_3BA9() {
  self endon("death");
  self endon("attacking_player");
  self notify("regulating_rockets");
  self endon("regulating_rockets");
  var_0 = level._id_3623;
  self.ignoreall = 0;
  wait(randomfloat(2));

  for(;;) {
    _id_0A05::_id_3555("left", 0);
    _id_0A05::_id_3555("right", 1);
    _id_0A05::_id_360D("right", scripts\engine\utility::random(var_0), "rockets_done", 1);
    self waittill("rockets_done");
    _id_0A05::_id_352D("right");
    _id_0A05::_id_3555("right", 0);
    _id_0A05::_id_3555("left", 1);
    wait(randomfloatrange(4, 6));
  }
}

_id_E5DF() {
  self endon("death");
  self endon("attacking_player");
  self notify("regulating_rockets");
  self endon("regulating_rockets");
  var_0 = level._id_3623;
  self.ignoreall = 0;
  _id_0A05::_id_3555("right", 1);
  wait(randomfloat(2));

  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    foreach(var_2 in var_0) {
      _id_0A05::_id_360D("right", var_2, "rockets_done", 1);
      self waittill("rockets_done");
      wait(randomfloatrange(0.25, 1));
    }

    wait(randomfloatrange(2, 4));
  }
}

_id_FFA7() {
  return scripts\engine\utility::flag("player_asking_for_it") && scripts\sp\utility::_id_13D91(level.player.origin, level.player.angles, self.origin, cos(50));
}

_id_2AC2() {}

_id_6C29(var_0) {
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_51E1, "casual");
  scripts\engine\utility::flag_wait("open_room3_doors");
  wait 2;
  scripts\engine\utility::flag_set("final_stand_moveup");
}

_id_137E6(var_0) {
  var_0 endon("death");

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_0.origin, cos(40))) {
      if(_id_0B1D::_id_385C(level.player getEye(), var_0))
        return;
    }

    wait 0.05;
  }
}

_id_D294() {
  level.player endon("death");
  var_0 = getEnt("tram_interact", "script_noteworthy");
  var_1 = scripts\sp\utility::_id_10639("player_rig", var_0.origin + (0, 0, 500));
  var_1 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "fspar_fire");
  var_2 = spawnStruct();
  var_2.origin = var_1.origin + (0, 0, 50) + anglesToForward(var_1.angles) * 45;
  var_2 _id_0E46::_id_48C4(undefined, undefined, &"EUROPA_FSPAR_SHOOT");
  objective_onentity(3, var_1);
  var_2 waittill("trigger");

  if(scripts\engine\utility::flag("self_destruction_start")) {
    return;
  }
  thread scripts\engine\utility::flag_set_delayed("middle_c12_approach", 2);
  _id_D087(var_0, var_1);
  scripts\engine\utility::flag_wait("new_decompress_anim");
  var_0 notify("stop_loop");
  level.player _meth_8244("steady_rumble");
  level.player scripts\engine\utility::delaycall(4.5, ::stoprumble, "steady_rumble");
  scripts\engine\utility::delaythread(0.5, ::_id_AB59);
  scripts\engine\utility::flag_clear("pause_destruction_explosions");
  level.player lerpviewangleclamp(0.5, 0.25, 0.25, 5, 5, 10, 10);
  var_0 scripts\sp\anim::_id_1F2C([var_1, level._id_EBBB], "fspar_suckout");
}

_id_D087(var_0, var_1) {
  scripts\engine\utility::flag_set("player_on_fspar");
  objective_position(3, (0, 0, 0));
  level.player _meth_80D1();
  var_2 = 0.5;
  scripts\sp\maps\europa\europa_util::_id_D85C();
  var_1 scripts\engine\utility::delaycall(var_2, ::show);
  level.player _meth_823C(var_1, "tag_player", var_2, var_2 / 2, var_2 / 2);
  level.player scripts\engine\utility::delaycall(var_2, ::playerlinktodelta, var_1, "tag_player", 1, 20, 20, 20, 20, 1);
  level._id_46B2.alpha = 0;
  var_0 scripts\sp\anim::_id_1F35(var_1, "fspar_fire");
  var_0 thread scripts\sp\anim::_id_1EEA(var_1, "fspar_idle");
  setmusicstate("");
}

_id_7468(var_0, var_1, var_2) {
  level._id_11B30._id_113F2 thread _id_746E(var_0, var_1);
  var_3 = scripts\engine\utility::getclosest(level._id_11B30._id_113F2.origin, var_2);
  playFX(scripts\engine\utility::getfx("vfx_eu_bfg_chargeup"), level._id_11B30._id_113F2.origin, anglesToForward(level._id_11B30._id_113F2.angles), anglestoup(level._id_11B30._id_113F2.angles));
  wait 2.5;
  var_4 = var_3.origin + (0, 0, 90);
  var_5 = vectorNormalize(var_4 - level._id_11B30._id_113F2.origin);
  var_6 = vectortoangles(var_5);
  level._id_11B30._id_113F2 unlink();
  level._id_11B30._id_113F2.angles = var_6;
  var_7 = level._id_11B30._id_113F2.origin + anglesToForward(var_6) * 10000;
  playfxbetweenpoints(scripts\engine\utility::getfx("vfx_eu_bfg_beam"), level._id_11B30._id_113F2.origin, var_6, var_7);
}

_id_746E(var_0, var_1) {
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

_id_3576(var_0) {
  var_0 = sortbydistance(var_0, level.player.origin);

  foreach(var_3, var_2 in var_0) {
    if(var_3 == 0)
      playFX(scripts\engine\utility::getfx("c12_fspar_explosion_center"), var_2.origin + (0, 0, 20));
    else
      playFX(scripts\engine\utility::getfx("c12_fspar_explosion"), var_2.origin + (0, 0, 20));

    thread _id_0B1D::_id_DBDB(var_2.origin + (0, 0, 50), 0.09, 950, 2000, undefined, undefined, undefined, 1);
    var_2 thread _id_0C46::_id_35FD();
    var_2 _id_0A05::_id_3555("left", 0);
    var_2 _id_0A05::_id_3555("right", 0);
    var_2 _id_0C41::_id_35EB();
    wait 0.25;
    var_2 hide();
    var_2 scripts\engine\utility::delaycall(0.8, ::delete);
    wait 0.15;
  }
}

_id_7459(var_0, var_1, var_2) {
  level endon("mons_cannon_targeting");
  level endon("removing_mons_cannon");
  var_3 = "tag_flash";
  self._id_38D7 = spawn("script_origin", self.origin);
  self._id_38D7 linkTo(self);
  self._id_38D7 thread _id_BA6B();

  if(var_0 > 0) {
    var_4 = gettime();
    var_5 = var_4 + var_0 * 1000;
    playFXOnTag(level._effect["vfx_heist_mons_steeldragon_chargeup"], self, var_3);

    while(gettime() < var_5) {
      earthquake(0.1, 0.05, self.origin, 150000);
      wait 0.05;
    }

    self._id_38D7 notify("chargeup_over");
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
    wait 0.1;
  }

  stopFXOnTag(level._effect["vfx_heist_mons_steeldragon_loop"], self, var_3);
  level notify("mons_cannon_fired");
}

_id_BA6B() {
  level scripts\engine\utility::waittill_any("mons_cannon_fired", "mons_cannon_targeting", "removing_mons_cannon");
  self stopsounds();
  wait 0.05;
  self delete();
}

_id_21DA() {
  if(level._id_7464) {
    thread _id_134DA();
    thread _id_A9E5();
    _id_2AC3();
    scripts\engine\utility::flag_wait("fspar_done_firing");
    scripts\engine\utility::flag_wait("decompress_blackout");
    setomnvar("ui_countdown_timer", 0);
    stop_far_cars();
    scripts\sp\utility::_id_28D7();
    scripts\engine\utility::flag_set("player_decompressed");
    var_0 = scripts\sp\hud_util::_id_7B4F();
    var_0.alpha = 1;
    wait 0.05;
    clearallcorpses();
    _id_11B36();
    return;
  }

  thread _id_A9E4();
  thread _id_A9E5();
  scripts\engine\utility::flag_wait("lastroom_destruction");
  thread _id_A9E2();

  if(getdvarint("debug_europa"))
    level._id_37CE = 1;

  thread _id_224B();
  _id_A9E0();
  thread _id_4F95();
  thread _id_4F97();
  thread _id_4FA9();
  thread scripts\sp\maps\europa\europa_util::_id_6F30();
  _id_4F99();
  thread _id_4FAC();
  scripts\engine\utility::flag_wait("decompress_blackout");
  setomnvar("ui_countdown_timer", 0);
  stop_far_cars();
  scripts\sp\utility::_id_28D7();
  scripts\engine\utility::flag_set("player_decompressed");
  var_0 = scripts\sp\hud_util::_id_7B4F();
  var_0.alpha = 1;
  wait 0.05;
  clearallcorpses();
  _id_11B36();
}

_id_111B4() {
  var_0 = scripts\engine\utility::getStruct("door_sound_struct", "targetname");
  var_1 = var_0.origin + (0, 0, 60);
  setsaveddvar("r_mbenable", 1);
  setsaveddvar("r_mbRadialOverridePosition", var_1);
  setsaveddvar("r_mbRadialOverridePositionActive", 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideRadius", 0.314878, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialoverridechromaticAberration", 0.25, 2);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.05, 1);
  scripts\engine\utility::flag_wait("player_holding_on");
  setsaveddvar("r_mbRadialOverridePosition", level._id_11B30._id_113F2.origin);
  earthquake(0.3, 1, level.player.origin, 300);
  scripts\engine\utility::flag_wait("decompress_blackout");
  setsaveddvar("r_mbenable", 0);
  setsaveddvar("r_mbRadialoverridechromaticAberration", 0);
  setsaveddvar("r_mbradialoverridestrength", 0);
  setsaveddvar("r_mbRadialOverrideRadius", 0);
  setsaveddvar("r_mbRadialOverridePositionActive", 0);
}

_id_4F99() {
  _id_16D4("decompress");
  _id_16D4("doorblast");
  _id_16D4("end_ext_explosion");
}

_id_224B() {
  level thread scripts\engine\utility::play_sound_in_space("scn_europa_window_explosion", (30584, -11739, -298));
  level._id_4FB4 = scripts\engine\utility::play_loopsound_in_space("scn_end_suck_out_door_wind_lr", level.player.origin);
  level._id_4FB4 linkTo(level.player);
  level.player playSound("scn_end_suck_out_room_debris_lr");
  wait 4;
}

_id_224E() {
  level.player _meth_82C0("europa_suck_out_grab", 1.0);
  level.player playSound("scn_end_suck_out_plr_grab_bar");
  wait 2.8;
  playworldsound("scn_euro_guy_impacts_plr_lr", level.player.origin);
  scripts\engine\utility::flag_wait("decompress_blackout");
  thread _id_224F();
  level.player playRumbleOnEntity("damage_heavy");
}

_id_224F() {
  level.player stoprumble("steady_rumble");
  level._id_4FB4 stoploopsound();
  level.player _meth_82C0("europa_suck_out_hit_fade_to_black", 0.0);
  setmusicstate("");
  level.player stopsounds();
  level.player setclientomnvar("ui_hide_hud", 1);
}

_id_A9E5() {
  scripts\engine\utility::flag_wait("open_room3_doors");
  thread _id_537D("lastroom_rail_explosion");
  scripts\sp\utility::_id_22CD("lastroom_fleer", 1);
}

_id_134DA() {
  level.player endon("death");
  level endon("player_decompressed");
  wait 2.5;
  var_0 = ["europa_rpr_scar1weretaking", "europa_plr_reaperthisis11radioch", "europa_sip_nocomms"];
  scripts\sp\maps\europa\europa_util::_id_48BD(var_0);
  level._id_EBBC scripts\sp\utility::_id_10346("europa_tee_thisplaceisgonnabl");
  wait 0.5;
  level._id_EBBB scripts\sp\utility::_id_10346("europa_sip_keeppushing");
  scripts\engine\utility::flag_wait("fspar_done_firing");
  wait 0.5;
  level._id_EBBC scripts\engine\utility::delaythread(0.6, scripts\sp\maps\europa\europa_util::_id_134B7, "europa_tee_holdon");
  level._id_EBBB scripts\sp\utility::_id_10346("europa_sip_itsdecompressing");
  wait 0.6;
  scripts\sp\utility::_id_1034D("europa_plr_holdon");
}

_id_A9E4() {
  level._id_EBBC scripts\sp\utility::_id_10346("europa_sip_wegottagetoffthexn");
  wait(randomfloatrange(1, 2));
  scripts\sp\utility::_id_10350("europa_rpr_11uhthiscantberight");
  scripts\sp\utility::_id_1034D("europa_plr_reapersayagainyouare");
  wait 1;
  scripts\sp\utility::_id_1034D("europa_plr_reaperthisis11radioch");
  level._id_EBBC scripts\sp\utility::_id_10346("europa_tee_nocomms");
  wait 2;
  scripts\engine\utility::flag_wait("tram_room2_enter");
  _id_2873(2, 5, 1000, 2000);
  scripts\engine\utility::flag_wait("open_room3_doors");
  level._id_EBBC scripts\sp\utility::_id_10346("europa_tee_thisplaceisgonnabl");
  wait 3;
  wait 1;
  level._id_EBBB scripts\sp\utility::_id_10346("europa_sip_keeppushing");
}

_id_4F95() {
  wait 1;
  level._id_EBBB scripts\sp\utility::_id_10346("europa_sip_itsdecompressing");
  wait 1;
  scripts\sp\utility::_id_1034D("europa_plr_holdon");
}

_id_A9E0() {
  scripts\sp\utility::_id_22CD("lastroom_fleer_bridge", 1);
  _id_537D("lastroom_destruction_start");
  _id_A9E3();
  var_0 = scripts\engine\utility::getStructArray("lastroom_destruction_end", "targetname");
  scripts\engine\utility::array_levelthread(var_0, ::_id_537C);
}

_id_A9E3() {
  var_0 = scripts\engine\utility::getStruct("lastroom_destruction_train", "targetname");
  var_0.script_fxid = "fireball_med_bridge";
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1.fx = var_0.script_fxid;
  var_1 thread _id_A9E1();
  var_2 = 400;

  for(;;) {
    if(!isDefined(var_0.target)) {
      break;
    }

    if(isDefined(var_0.script_fxid))
      var_1.fx = var_0.script_fxid;

    var_1.angles = var_0.angles;
    var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    var_3 = distance(var_1.origin, var_0.origin) / var_2;
    var_1 moveTo(var_0.origin, var_3);
    var_1 waittill("movedone");

    if(isDefined(var_0.speed))
      var_2 = var_0.speed;
  }

  var_1 delete();
}

_id_A9E1() {
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
    wait 0.25;
  }
}

_id_4FAC() {
  var_0 = scripts\engine\utility::getStruct("decompress_start", "targetname");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = vectorNormalize(var_1.origin - var_0.origin);
  var_3 = spawn("script_origin", var_0.origin);
  var_3.angles = var_0.angles;
  scripts\sp\utility::_id_16AE(var_3, "decompress");
  var_4 = 1100;
  var_5 = distance(var_1.origin, var_3.origin);
  var_6 = var_5 / var_4;
  var_3 moveTo(var_1.origin, var_6);
  var_7 = [level.player, level._id_EBBB, level._id_EBBC];
  var_7 = scripts\engine\utility::array_combine(var_7, getaiarray("axis"));
  var_7 = scripts\sp\utility::_id_22B9(var_7);

  for(;;) {
    var_7 = scripts\sp\utility::_id_22B9(var_7);

    foreach(var_9 in var_7) {
      if(isDefined(var_9._id_4FAE)) {
        continue;
      }
      if(vectordot(var_2, vectorNormalize(var_3.origin - var_9.origin)) > 0) {
        var_9._id_4FAE = 1;
        var_9 thread _id_4F98();
      }
    }

    var_11 = [];

    foreach(var_9 in var_7) {
      if(isDefined(var_9._id_4FAE)) {
        continue;
      }
      var_11[var_11.size] = var_9;
    }

    var_7 = var_11;
    wait 0.05;
  }
}

_id_4F98() {
  if(self == level.player) {
    if(!scripts\engine\utility::flag("safe_to_decompress_player")) {
      return;
    }
    thread _id_4F9E();
  } else if(self == level._id_EBBB) {
    if(!scripts\engine\utility::flag("safe_to_decompress_player")) {
      return;
    }
    thread _id_4FA7();
  } else if(self == level._id_EBBC) {
    if(!scripts\engine\utility::flag("safe_to_decompress_player")) {
      return;
    }
    thread _id_4FA8();
  } else if(self != level._id_EBBC && self != level._id_EBBB && isai(self))
    level thread _id_4F8E(self);
}

_id_4F8E(var_0) {
  if(!isalive(var_0) || var_0 scripts\sp\utility::_id_58DA()) {
    return;
  }
  var_1 = spawn("script_origin", var_0.origin + (0, 0, 40));
  var_0 linkTo(var_1);
  var_0.ignoreall = 1;
  var_2 = scripts\engine\utility::getStruct("decompress_doorway", "targetname");
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_4 = pointonsegmentnearesttopoint(var_2.origin, var_3.origin, var_1.origin);

  if(var_0.unittype == "soldier")
    var_0 thread scripts\sp\anim::_id_1ECC(var_0, "decompress");

  var_5 = vectorNormalize(var_4 - var_1.origin);
  var_6 = 1000;
  var_7 = distance(var_1.origin, var_4) / var_6;
  var_1 moveTo(var_4, var_7, var_7 * 0.25, 0);
  wait(var_7);
  var_8 = var_4 + var_5 * 5000;
  var_7 = 5000 / var_6;
  var_1 moveTo(var_8, var_7);
  wait(var_7);

  if(isDefined(var_0))
    var_0 delete();

  var_1 delete();
}

_id_4FA7() {
  level endon("player_holding_on");

  if(scripts\engine\utility::flag("player_holding_on")) {
    return;
  }
  var_0 = scripts\sp\maps\europa\europa_util::_id_5F32(scripts\engine\utility::getStruct("decompress_anim", "targetname"));
  var_0 scripts\sp\anim::_id_1F35(level._id_EBBB, "decompress_intro");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EBBB, "decompress_loop");
  var_0 notify("stop_loop");
}

_id_4FA8() {
  level._id_EBBC scripts\sp\anim::_id_1F35(level._id_EBBC, "decompress");
}

_id_AB59() {
  scripts\engine\utility::flag_set("start_decompress_player");
  thread _id_111B4();
  thread _id_4FB1();
  level.player playSound("scn_europa_decompression_suck");
  scripts\engine\utility::flag_wait("player_holding_on");
  thread _id_224E();
}

_id_4F9E() {
  scripts\engine\utility::flag_set("start_decompress_player");
  level.player thread scripts\sp\utility::_id_DC45("lower");
  thread _id_4FB1();
  level.player allowstand(1);
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player disableweapons();
  wait 0.1;
  var_0 = anglesToForward((-40, 0, 0));
  var_0 = var_0 * -500;
  physics_setgravity(var_0);
  wait 0.5;
  _id_4FA3();
}

_id_4FB1() {
  level endon("decompress_blackout");
  var_0 = getEntArray("decompression_body", "targetname");

  for(;;) {
    foreach(var_2 in var_0) {
      wait(randomfloatrange(1, 3));
      var_2.count = 1;
      var_3 = var_2 scripts\sp\utility::_id_10619(1);

      if(!isDefined(var_3)) {
        continue;
      }
      var_3._id_DC1A = 1;
      var_3 _meth_81D0();
    }
  }
}

_id_4FA4() {
  var_0 = scripts\sp\maps\europa\europa_util::_id_5F32(scripts\engine\utility::getStruct("decompress_anim", "targetname"));
  var_1 = 10;
  var_2 = 485;
  var_3 = var_1;
  var_4 = 1;
  level.player._id_8632 rotateTo((0, 0, 0), var_4, var_4 * 0.5, var_4 * 0.5);
  var_5 = var_4 * 20;
  var_6 = (var_2 - var_1) / var_5;

  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_3 = var_3 + var_6;
    var_8 = vectorNormalize(var_0.origin - level.player.origin) * var_3;
    level.player setvelocity(var_8);
    wait 0.05;
  }

  level.player _meth_823F(undefined);
}

_id_4FAB() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\sp\utility::_id_F5AF("armory_tram_end_startpoint", [level._id_EBBB, level._id_EBBC, level.player]);
  _id_95B6("armory_doors");
  level._id_220A = 1;
  scripts\engine\utility::flag_set("open_room2_doors");
  scripts\engine\utility::flag_set("open_room3_doors");
  setDvar("test_decompress", "1");
  thread _id_4FA3();
}

_id_4FA3() {
  var_0 = scripts\engine\utility::getStructArray("decompress_door_struct", "targetname");
  thread scripts\sp\utility::_id_1034D("europa_plr_scramblingtofindso");
  var_1 = undefined;
  _id_95A3();
  var_2 = 1;

  if(var_2) {
    var_3 = _id_48CA(level.player.origin);
    thread _id_5B56(var_3);
    var_4 = var_3._id_D648[var_3._id_D648.size - 1].origin;
    var_5 = 0;
    var_6 = 500;

    for(;;) {
      var_7 = _id_7AB4(var_3, 100);

      if(!isDefined(var_7)) {
        break;
      }

      if(!isDefined(level.player._id_102E8))
        _id_48CB();

      var_7 = scripts\engine\utility::drop_to_ground(var_7, 10, -1000);
      var_8 = vectorNormalize(var_7 - level.player.origin) * 800;
      level.player._id_102E8 moveslide((0, 0, 15), 15, var_8);
      var_9 = vectortoangles(var_4 - level.player.origin);
      var_10 = angleclamp180(var_9[1] - level.player._id_102E8.angles[1]) * 0.15;
      level.player._id_102E8.angles = level.player._id_102E8.angles + (0, var_10, 0);
      wait 0.05;
    }
  }

  _id_4F9F();
}

_id_48CB() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0.angles = level.player.angles;
  level.player._id_102E8 = var_0;
  var_1 = 0.2;
  level.player _meth_823C(var_0, undefined, var_1);
  thread _id_4FAA(var_1);
}

_id_4FAA(var_0) {
  wait(var_0);

  if(!isDefined(level.player._id_102E8)) {
    return;
  }
  level.player playerlinktodelta(level.player._id_102E8, undefined, 0.4, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.4, 0, 0, 30, 20, 30, 10);
}

_id_95A3() {
  var_0 = scripts\engine\utility::getStructArray("decompression_path", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.path)) {
      continue;
    }
    var_3 = spawnStruct();
    var_4 = [];
    var_5 = var_2;

    for(;;) {
      if(var_4.size > 0)
        var_4[var_4.size - 1]._id_BF2E = var_5;

      var_4[var_4.size] = var_5;

      if(!isDefined(var_5.target)) {
        break;
      }

      var_5 = scripts\engine\utility::getStruct(var_5.target, "targetname");
    }

    var_3._id_D648 = var_4;
    var_2.path = var_3;
  }
}

_id_48CA(var_0) {
  var_1 = _id_78C6(var_0);
  var_2 = spawnStruct();
  var_3 = [];
  var_4 = (var_0[0], var_0[1], var_1.origin[2]);
  var_3[var_3.size] = _id_495D(var_4);
  var_5 = _id_78C5(var_1.path, var_0);
  var_3[var_3.size] = _id_495D(var_5._id_D3E3);
  var_3[var_3.size - 2]._id_BF2E = var_3[var_3.size - 1];
  var_3[var_3.size - 1]._id_BF2E = var_5._id_BF2E;

  for(;;) {
    if(!isDefined(var_3[var_3.size - 1]._id_BF2E)) {
      break;
    }

    var_3[var_3.size] = var_3[var_3.size - 1]._id_BF2E;
  }

  var_2._id_D648 = var_3;
  return var_2;
}

_id_48EC(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "main_path";
  var_3 = undefined;

  if(var_2) {
    if(level._id_10CDA == "decompress_test") {
      level._id_11B30 = spawnStruct();
      level._id_11B30.origin = (31739, -11736, -629);
      level._id_11B30.angles = (0, 0, 0);
    }

    var_4 = anglesToForward((0, level._id_11B30.angles[1], 0));
    var_3 = level._id_11B30.origin + var_4 * 180;
    var_3 = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, var_3);
  }

  var_5 = spawnStruct();

  if(var_2 && bullettracepassed(level.player getEye(), var_3, 0, undefined))
    var_5.origin = pointonsegmentnearesttopoint(var_3, var_1.origin, level.player.origin);
  else
    var_5.origin = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.player.origin);

  var_5.target = var_0.target;
  var_5._id_BF2E = var_1;
  return var_5;
}

_id_78C6(var_0) {
  var_1 = scripts\engine\utility::getStructArray("decompression_path", "targetname");

  foreach(var_3 in var_1)
  var_3._id_429C = _id_78C5(var_3.path, var_0);

  var_5 = var_1[0]._id_429C._id_56E8;
  var_6 = var_1[0];

  for(var_7 = 1; var_7 < var_1.size; var_7++) {
    var_3 = var_1[var_7];

    if(var_3._id_429C._id_56E8 < var_5) {
      var_5 = var_3._id_429C._id_56E8;
      var_6 = var_3;
    }
  }

  foreach(var_3 in var_1) {
    var_3._id_429C = undefined;

    foreach(var_10 in var_3.path._id_D648)
    var_10._id_56E8 = undefined;
  }

  return var_6;
}

_id_7AB4(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 5; var_3 > 1; var_3--) {
    var_2 = _id_7AB3(var_0, var_1 * var_3);

    if(isDefined(var_2) && var_3 > 1 && _id_AFFB(var_2)) {
      break;
    }
  }

  return var_2;
}

_id_AFFB(var_0) {
  var_1 = scripts\common\trace::capsule_trace(level.player.origin, var_0, 15, 70, (0, 0, 0), level.player);

  if(var_1["fraction"] > 0.9)
    return 1;

  return 0;
}

_id_7AB3(var_0, var_1) {
  var_2 = _id_78C5(var_0, level.player.origin);
  var_3 = var_2._id_D3E3;
  var_4 = var_1;
  var_5 = undefined;
  var_6 = var_3;

  for(;;) {
    if(!isDefined(var_2._id_BF2E)) {
      var_5 = undefined;
      break;
    }

    var_7 = distance(var_3, var_2._id_BF2E.origin);

    if(var_7 > var_4) {
      var_8 = vectorNormalize(var_2._id_BF2E.origin - var_2.origin);
      var_5 = var_3 + var_8 * var_4;
      break;
    } else {
      var_4 = var_4 - var_7;

      if(distance(var_3, var_2.origin) > var_1)
        var_3 = var_3;
      else
        var_3 = var_2._id_BF2E.origin;
    }

    if(!isDefined(var_2._id_BF2E)) {
      break;
    }

    var_2 = var_2._id_BF2E;
  }

  return var_5;
}

_id_78C5(var_0, var_1) {
  var_2 = squared(99999);
  var_3 = undefined;

  foreach(var_5 in var_0._id_D648) {
    if(!isDefined(var_5._id_BF2E)) {
      break;
    }

    var_6 = pointonsegmentnearesttopoint(var_5.origin, var_5._id_BF2E.origin, level.player.origin);
    var_7 = distancesquared(var_6, level.player.origin);

    if(var_7 < var_2) {
      var_5._id_D3E3 = var_6;
      var_2 = var_7;
      var_5._id_56E8 = var_7;
      var_3 = var_5;
    }
  }

  return var_3;
}

_id_495D(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0;
  return var_1;
}

_id_5B56(var_0) {}

_id_4F9F() {
  var_0 = 485;
  var_1 = _id_4F9B();
  level.player _meth_84FE();
  level.player._id_E505 = scripts\sp\player_rig::get_player_score(1);
  level.player._id_E505 hide();
  level.player._id_E505.angles = level.player.angles;
  var_2 = level.player._id_E505 scripts\sp\utility::_id_7DC1(var_1);
  var_3 = scripts\engine\utility::getStruct("decompress_anim", "targetname");
  var_4 = getstartorigin(var_3.origin, var_3.angles, var_2);
  var_5 = getstartangles(var_3.origin, var_3.angles, var_2);
  var_6 = var_4;
  var_5 = vectortoangles(var_6 - level.player._id_E505.origin);
  thread _id_4FA1();
  thread _id_4FA0(level.player._id_E505);

  if(!isDefined(level.player._id_8632))
    level.player._id_8632 = spawn("script_origin", level.player.origin);

  level.player playSound("scn_europa_decompression_suck");
  var_7 = distance(level.player._id_E505.origin, var_6);
  var_8 = _id_E769(var_7 / var_0);
  var_9 = scripts\engine\utility::getStruct("decompress_angles", "targetname");
  level.player._id_E505 thread _id_4FA2(var_6, var_8, var_8 * 0.5);
  var_5 = (0, var_5[1], var_5[2]);
  level.player._id_E505 rotateTo(var_5, var_8 * 0.5, var_8 * 0.25);
  wait(var_8 - 0.2);
  var_10 = scripts\sp\utility::_id_10639("player_rig");
  var_10 hide();
  level.player._id_E505 notify("stop_decompress_loop");
  scripts\engine\utility::flag_set("player_holding_on");
  level._id_EBBB scripts\sp\utility::anim_stopanimScripted();
  var_11 = [var_10, level._id_EBBB];
  level.player._id_E505 delete();
  thread _id_4FA0(var_10);
  thread _id_224E();
  var_3 scripts\sp\anim::_id_1F2C(var_11, var_1);
}

_id_4F9B() {
  var_0 = scripts\engine\utility::getStructArray("decompress_side", "targetname");
  var_0 = sortbydistance(var_0, level.player.origin);
  var_1 = var_0[0];
  var_2 = "right_decompress";

  if(var_1.script_parameters == "left")
    var_2 = "left_decompress";

  return var_2;
}

_id_E769(var_0) {
  return floor(var_0 / 0.05) * 0.05;
}

_id_4FA0(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 0.4;

  level.player _meth_823C(var_0, "tag_player", var_1);
  wait(var_1);
  var_0 show();
  level.player playerlinktodelta(var_0, "tag_player", 0.4, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.4, 0, 0, 30, 20, 30, 10);
}

_id_4FA2(var_0, var_1, var_2) {
  level.player._id_E505 endon("death");
  var_3 = 0.05;
  var_4 = length(level.player getvelocity());
  var_5 = distance(var_0, level.player._id_E505.origin);
  var_6 = var_4 + (var_5 - var_4 * var_1) / (var_1 - 0.5 * var_2);
  var_7 = gettime() + var_1 * 1000 - 100;
  var_8 = gettime() + var_2 * 1000;

  while(gettime() < var_7) {
    if(gettime() < var_8)
      var_9 = var_4 + (var_6 - var_4) / (gettime() / var_8);
    else
      var_9 = var_6;

    var_10 = vectorNormalize(var_0 - level.player._id_E505.origin);
    var_11 = var_9 * var_3;
    level.player._id_E505.origin = level.player._id_E505.origin + var_10 * var_11;
    wait(var_3);
  }
}

_id_4FA9() {
  level endon("player_decompressed");
  var_0 = 1;

  for(;;) {
    var_1 = var_0 * 0.05;
    var_1 = min(var_1, 1);
    var_2 = randomfloatrange(0.25, 0.55) * var_1;
    var_3 = randomfloatrange(0.25, 0.55) * var_1;
    var_4 = randomfloatrange(0.1, 0.3) * var_1;
    level.player _meth_8291(var_2, var_3, var_4, 0.2, 0, 0, 700, 10, 10, 10);
    wait 0.2;
    var_0++;
  }
}

_id_4FA1() {
  var_0 = level.player._id_E505;
  var_0 endon("stop_decompress_loop");
  var_1 = var_0 scripts\sp\utility::_id_7DC1("decompress_loop");
  var_2 = "decompress_loop";

  for(;;) {
    var_0 _meth_82E7(var_2, var_1, 1.0, 0.2, 1.0);
    var_0 thread scripts\sp\anim::_id_10CBF(var_0, var_2);
    var_0 scripts\anim\shared::donotetracks(var_2);
  }
}

_id_4FA5(var_0, var_1) {
  var_1 = gettime() + var_1 * 1000;
  var_2 = 250000;

  while(distancesquared(level.player.origin, var_0.origin) > var_2)
    wait 0.05;

  var_3 = (var_1 - gettime()) * 0.001;
  level.player._id_E505 rotateTo(var_0.angles, var_3, var_3);
}

_id_4F97() {
  var_0 = getEntArray("armory_last_doors", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_4F96();
}

_id_4F96() {
  self.clip = getEnt(self.target, "targetname");
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_1 = self.speed;
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    var_4 = distance(self.origin, var_0.origin);
    var_5 = var_4 / var_1;

    if(isDefined(var_0._id_EED2)) {
      var_2 = 1;
      self moveTo(var_0.origin, var_5, 0, var_5);
      self rotateTo(var_0.angles, var_5, 0, var_5);
    } else if(isDefined(var_2)) {
      var_2 = undefined;
      self moveTo(var_0.origin, var_5, var_5, 0);
      self rotateTo(var_0.angles, var_5, var_5, 0);
    } else {
      self moveTo(var_0.origin, var_5);
      self rotateTo(var_0.angles, var_5);
    }

    wait(var_5);

    if(!isDefined(var_0.target)) {
      var_6 = vectorNormalize(var_0.origin - var_3.origin);
      var_7 = self.origin + var_6 * 10000;
      var_8 = var_0.angles - var_3.angles;
      break;
    }

    var_3 = var_0;
    var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  }

  var_4 = distance(self.origin, var_7);
  var_5 = var_4 / var_1;
  self moveTo(var_7, var_5 * 0.5);
  self rotatevelocity(var_8, 50);
  wait(var_5);
  self delete();
}

_id_C95E(var_0, var_1, var_2) {
  var_3 = var_2[2] - var_1[2];
  var_4 = 0;
  var_5 = [];
  var_6 = var_1;

  foreach(var_9, var_8 in var_0) {
    var_4 = var_4 + distance(var_6, var_8);
    var_5[var_9] = var_4;
    var_6 = var_8;
  }

  var_10 = [];

  foreach(var_9, var_8 in var_0) {
    var_12 = var_5[var_9] / var_4;
    var_10[var_10.size] = (var_8[0], var_8[1], var_1[2] + var_3 * var_12);
  }

  return var_10;
}

_id_11B36() {
  var_0 = getaiarray("bad_guys");
  scripts\engine\utility::array_call(var_0, ::delete);
}

_id_6F55(var_0) {
  var_0 waittill("trigger");

  if(isDefined(var_0._id_EDA0))
    scripts\engine\utility::flag_wait(var_0._id_EDA0);

  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = var_0.script_count;

  for(var_3 = []; var_1.size > 0; var_3 = scripts\sp\utility::array_removedeadvehicles(var_3)) {
    if(var_3.size < var_2) {
      foreach(var_5 in var_1) {
        if(!isDefined(var_5)) {
          continue;
        }
        var_5.count = 1;
        var_6 = var_5 scripts\sp\utility::_id_10619();

        if(isDefined(var_6))
          var_3[var_3.size] = var_6;
      }
    }

    wait 0.1;
    var_1 = scripts\engine\utility::array_removeundefined(var_1);
  }
}

_id_95B6(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_C88D)) {
      continue;
    }
    var_4 = [var_3];
    var_3._id_C88D = 1;

    foreach(var_6 in var_1) {
      if(isDefined(var_6._id_C88D)) {
        continue;
      }
      if(var_6.script_parameters == var_3.script_parameters) {
        var_6._id_C88D = 1;
        var_4[var_4.size] = var_6;
      }

      if(!scripts\engine\utility::flag_exist("open_" + var_6.script_parameters))
        scripts\engine\utility::flag_init("open_" + var_6.script_parameters);

      if(!scripts\engine\utility::flag_exist("close_" + var_6.script_parameters))
        scripts\engine\utility::flag_init("close_" + var_6.script_parameters);
    }

    level thread _id_59F8(var_4);
  }
}

_id_59F8(var_0) {
  scripts\engine\utility::flag_wait("open_" + var_0[0].script_parameters);

  if(var_0[0].script_parameters == "room3_doors")
    scripts\engine\utility::flag_wait("c12_fight_done_tram_go");

  if(isDefined(var_0[0]._id_EE88))
    setumbraportalstate(var_0[0]._id_EE88, 1);

  var_1 = scripts\sp\utility::_id_7853(var_0);
  playworldsound("scn_europa_fspar_door_open", var_1);

  foreach(var_4, var_3 in var_0) {
    var_3 thread _id_59B8(var_4);
    wait(randomfloat(0.1));
  }

  scripts\engine\utility::flag_wait("close_" + var_0[0].script_parameters);

  if(var_0[0].script_parameters == "room2_doors")
    scripts\engine\utility::flag_wait("fspar_ready");

  foreach(var_3 in var_0)
  var_3 thread _id_5986();

  var_0[0] waittill("movedone");
  playworldsound("scn_europa_fspar_door_stop", var_1);

  if(isDefined(var_0[0]._id_EE88))
    setumbraportalstate(var_0[0]._id_EE88, 0);
}

_id_59B8(var_0) {
  if(_id_9CD4("decompression") && level._id_10CDA != "decompress_test") {
    return;
  }
  var_1 = 3;

  if(isDefined(self._id_EEE5))
    var_1 = self._id_EEE5;

  var_2 = scripts\engine\utility::getStruct(self.target, "targetname");
  self._id_C390 = self.origin;
  self._id_BE67 = getEnt(self.target, "targetname");

  if(isDefined(self._id_BE67))
    self._id_BE67 linkTo(self);

  thread _id_59B4(var_2);
  var_3 = 4;
  var_4 = distance(var_2.origin, self.origin);
  var_5 = var_3 / var_4;
  var_6 = var_1 * var_5;
  var_7 = vectorNormalize(var_2.origin - self.origin);
  var_8 = self.origin + var_7 * var_3;

  if(var_0 == 0)
    thread _id_59EA();

  self moveTo(var_8, var_6, var_6 * 0.1, var_6 * 0.1);
  self waittill("movedone");
  wait 0.2;
  var_1 = var_1 - var_6;
  self moveTo(var_2.origin, var_1, var_1 * 0.1, var_1 * 0.1);
  self waittill("movedone");
  self._id_11083 = 1;
}

_id_59EA() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  switch (self.script_parameters) {
    case "armory_doors":
      var_0 = "scn_europa_armory_door_open";
      var_1 = "scn_europa_armory_door_open_dist";
      var_2 = (34159, -11722, -443);
      playworldsound("scn_europa_armory_door_open_decompress", self.origin + (0, 0, 60));

      if(isDefined(level._id_11B30))
        level._id_11B30 scripts\engine\utility::delaycall(1.8, ::playsound, "scn_europa_armory_door_fspar_reveal");

      break;
    case "room1_doors":
      var_0 = "scn_europa_armory_door_open_enemy";
      var_1 = "scn_europa_armory_door_open_enemy_dist";
      var_2 = (35607, -11722, -443);
      break;
  }

  if(isDefined(var_0))
    playworldsound(var_0, self.origin + (0, 0, 60));

  if(isDefined(var_1))
    playworldsound(var_1, var_2);
}

_id_5986() {
  var_0 = 5;
  self moveTo(self._id_C390, var_0, var_0 * 0.1, var_0 * 0.1);
  self waittill("movedone");

  if(isDefined(self._id_BE67))
    self._id_BE67 connectpaths();
}

_id_59B4(var_0) {
  if(!isDefined(self._id_BE68) && !isDefined(self._id_BE67)) {
    return;
  }
  if(self.classname == "script_brushmodel")
    self connectpaths();

  if(isDefined(self._id_BE67)) {
    while(!isDefined(self._id_11083)) {
      wait 0.1;
      self._id_BE67 disconnectPaths();
      wait 1;
      self._id_BE67 connectpaths();
    }

    return;
  }
}

_id_2874() {
  _id_2873(5, 10, 2500, 3000);
  var_0 = 5000;
  var_1 = 10000;
  wait 4;
  var_2 = 0;
  var_3 = level._id_289B;
  var_4 = scripts\engine\utility::getStructArray("base_destruction_point", "targetname");
  var_5 = 0;
  var_6 = var_4[0];

  while(!scripts\engine\utility::flag("player_holding_on")) {
    if(gettime() >= var_2) {
      var_2 = gettime() + randomintrange(var_3._id_B7CD, var_3._id_B4CC);
      var_7 = undefined;
      var_4 = scripts\engine\utility::array_randomize(var_4);

      foreach(var_9 in var_4) {
        var_10 = distancesquared(var_9.origin, level.player.origin);

        if(var_10 < var_3._id_B7C8) {
          continue;
        }
        if(var_10 > var_3._id_01D2) {
          continue;
        }
        if(var_9 == var_6) {
          continue;
        }
        var_7 = var_9;
        break;
      }

      if(!isDefined(var_7))
        var_7 = scripts\engine\utility::random(var_4);

      var_6 = var_7;
      _id_537C(var_7);
    }

    wait 0.05;
  }
}

_id_2873(var_0, var_1, var_2, var_3) {
  level._id_289B = spawnStruct();
  level._id_289B._id_B7CD = var_0 * 1000;
  level._id_289B._id_B4CC = var_1 * 1000;
  level._id_289B._id_B7C8 = squared(var_2);
  level._id_289B._id_01D2 = squared(var_3);
}

_id_537D(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");
  scripts\engine\utility::array_levelthread(var_2, ::_id_537C);
}

_id_537C(var_0) {
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

  thread _id_532E(var_0.origin);

  if(isDefined(var_0.script_damage))
    radiusdamage(var_0.origin, 500, 200, 200, undefined, "MOD_EXPLOSIVE");

  thread _id_FB6C();
  level.player playSound("scn_euro_armory_quake_lr");
  screenshake(var_0.origin, 1, 1, 1, var_2, 0, var_2, var_1, 15, 2, 10);
  playrumbleonposition("heavy_2s", var_0.origin);
}

_id_FB6C() {
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

_id_532E(var_0) {
  var_1 = scripts\engine\utility::getStructArray("explosion_dust", "targetname");

  if(!isDefined(level._id_532F)) {
    level._id_532F = 1;

    foreach(var_3 in var_1)
    var_3._id_BFB3 = 0;
  }

  var_1 = sortbydistance(var_1, var_0);
  var_5 = squared(100);
  var_6 = [];
  var_6[var_6.size] = var_1[0];
  var_7 = 10;

  foreach(var_3 in var_1) {
    if(gettime() < var_3._id_BFB3) {
      continue;
    }
    foreach(var_10 in var_6) {
      if(var_10 == var_3) {
        continue;
      }
      if(distance2dsquared(var_10.origin, var_3.origin) > var_5) {
        var_6[var_6.size] = var_3;
        break;
      }
    }

    if(var_6.size == var_7) {
      break;
    }
  }

  var_13 = scripts\engine\utility::getfx("explosion_dust");

  for(var_14 = 0; var_14 < var_6.size; var_14++) {
    if(isDefined(var_6[var_14].script_fxid))
      playFX(scripts\engine\utility::getfx(var_6[var_14].script_fxid), var_6[var_14].origin);
    else
      playFX(var_13, var_6[var_14].origin);

    var_6[var_14]._id_BFB3 = gettime() + 1000;
    wait(randomfloatrange(0, 0.1));
  }
}

_id_10F7F() {
  level.player endon("death");
  var_0 = 0;
  var_1 = 0;
  var_2 = -10;
  var_3 = 1000;

  for(;;) {
    wait 0.05;

    if(level.player attackButtonPressed()) {
      if(level.player getcurrentweapon() == "iw7_steeldragon+europaspeedmod") {
        if(!var_0)
          var_1 = gettime();

        var_0 = 1;
        var_4 = (gettime() - var_1) / var_3;
        var_4 = min(var_4, 1);
        var_5 = anglesToForward(level.player.angles) * (var_4 * var_2);
        level.player _meth_8251(var_5);
      }

      continue;
    }

    if(var_0) {
      var_0 = 0;
      var_5 = (0, 0, 0);
      level.player _meth_8251(var_5);
    }
  }
}

_id_7558() {
  scripts\engine\utility::flag_wait("tram_move");
  wait 5;
  _id_16D4("button_room_stage1");
  scripts\engine\utility::flag_wait("open_room1_doors");
  wait 10;
  _id_16D4("button_room_stage2");
  _id_16D4("begin_ext_explosion");
  wait 10;
  _id_16D4("button_room_stage3");
  _id_16D4("begin_ext_explosion_02");
}

_id_75D7() {
  scripts\engine\utility::flag_wait("open_room1_doors");
  _id_16D4("room_1_stage1");
  scripts\engine\utility::flag_wait("open_room2_doors");
  wait 5;
  _id_16D4("room_1_stage2");
  _id_16D4("room1_ext_explosion_01");
  wait 20;
  _id_16D4("room_1_stage3");
  _id_16D4("room1_ext_explosion_02");
  scripts\engine\utility::flag_wait("c12_fight_done");
  _id_16D4("room_1_stage4");
}

_id_75D8() {
  scripts\engine\utility::flag_wait("c12_fight_done");
  wait 10;
  _id_16D4("room_2_stage1");
  scripts\engine\utility::flag_wait("tram_room2_enter");
  wait 5;
  _id_16D4("room_2_stage2");
}

_id_7572() {
  scripts\engine\utility::flag_wait("open_room3_doors");
  _id_16D4("decomp_room");
  scripts\sp\utility::_id_10FEC("button_room_stage1");
}

_id_A6EF() {
  scripts\engine\utility::flag_wait("tram_move");
  thread _id_2212();
  var_0 = getEntArray("extra_corridor_klaxon_light", "script_noteworthy");
  scripts\engine\utility::array_thread(var_0, ::_id_A6EE);
  thread _id_DAED(1);
}

_id_2212() {
  var_0 = scripts\engine\utility::play_loopsound_in_space("scn_europa_armory_destruct_alarm", level.player.origin) scripts\engine\utility::flag_wait("decompress_blackout");

  if(isDefined(var_0)) {
    var_0 stoploopsound();
    wait 0.05;
    var_0 delete();
  }
}

_id_A6EE() {
  thread _id_DAEC(0.25);
}

_id_A6ED() {
  self notify("stop_pulse_loop");
  scripts\sp\maps\europa\europa_util::_id_AC90(0.0, 0.5);
}

_id_DAEC(var_0) {
  self endon("stop_pulse_loop");

  for(;;) {
    scripts\sp\maps\europa\europa_util::_id_AC90(60, var_0);
    wait(var_0);
    scripts\sp\maps\europa\europa_util::_id_AC90(0, var_0);
    wait(var_0);
  }
}

_id_DAED(var_0) {
  var_1 = scripts\engine\utility::getStructArray("lab_emergency_light", "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4 scripts\engine\utility::spawn_tag_origin();
    var_2[var_2.size] = var_5;
  }

  for(;;) {
    foreach(var_5 in var_2)
    playFXOnTag(scripts\engine\utility::getfx("vfx_light_emergency_flicker"), var_5, "tag_origin");

    wait(var_0);
  }
}

_id_1B20() {
  wait 0.1;
  var_0 = getEntArray("europa_monitor_light_red1", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC86);
  var_0 = getEntArray("europa_monitor_light_red2", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC86);
  var_0 = getEntArray("europa_monitor_light_blue1", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 20);
  var_0 = getEntArray("europa_monitor_light_blue2", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 10);
  var_1 = getscriptablearray("monitors", "targetname");
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_1, "part", "healthy", "healthy_blue");
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_1, "part", "dead", "dead_blue");
  scripts\engine\utility::flag_wait("tram_move");
  wait 7;
  var_0 = getEntArray("europa_monitor_light_blue1", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC86);
  var_0 = getEntArray("europa_monitor_light_blue2", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC86);
  var_0 = getEntArray("europa_monitor_light_red1", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 5);
  var_0 = getEntArray("europa_monitor_light_red2", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 5);
  var_1 = getscriptablearray("monitors", "targetname");
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_1, "part", "healthy_blue", "healthy_red");
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_1, "part", "health_healthy_blue", "healthy_red");
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_1, "part", "dead_blue", "dead_red");
}

_id_9CD4(var_0) {
  var_1 = _id_7A3A(var_0);
  var_2 = _id_7A3A(level._id_10CDA);

  if(isDefined(var_1) && isDefined(var_2))
    return var_2 > var_1;

  return undefined;
}

_id_9CD5(var_0) {
  var_1 = _id_7A3A(var_0);
  var_2 = _id_7A3A(level._id_10CDA);

  if(isDefined(var_1) && isDefined(var_2))
    return var_2 < var_1;

  return undefined;
}

_id_7A3A(var_0) {
  foreach(var_3, var_2 in level._id_10C58) {
    if(var_2["name"] == var_0)
      return var_3;
  }

  return undefined;
}

_id_16D4(var_0) {
  if(!isDefined(level._id_69B7))
    level._id_69B7 = [];

  level._id_69B7[level._id_69B7.size] = var_0;
  scripts\engine\utility::exploder(var_0);
}

stop_far_cars() {
  foreach(var_1 in level._id_69B7)
  scripts\sp\utility::_id_10FEC(var_1);

  level._id_69B7 = undefined;
}