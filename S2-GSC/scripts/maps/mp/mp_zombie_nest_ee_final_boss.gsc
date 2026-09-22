/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_final_boss.gsc
************************************************************/

main() {
  common_scripts\utility::flag_init("flag_all_players_in_hilt");
  common_scripts\utility::flag_init("flag_hilt_collected");
  var_0 = getEntArray("nest_brute_uber_inserts", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
  }

  var_4 = getEntArray("brute_final_barrier", "targetname");

  foreach(var_2 in var_4) {
    var_2 hide();
  }

  _id_51EB();
  _id_AA0B();
  _id_0557::_id_7846("8A The Hilt", _id_0557::_id_30D8, ["6B Left Hand overcharge", "7 Voice paintings", "6A Left Hand blimp parts", "5 Right Hand fuses"], &"ZOMBIE_NEST_HINT_QUEST_HILT", "ZOMBIE_NEST_HINT_QUEST_HILT");
  _id_0557::_id_781E("8A The Hilt", "Use Hilt", ::_id_785A, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_OBTAIN_HILT");
  _id_0557::_id_781E("8A The Hilt", "Shoot Hilt", ::_id_785B, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_SHOOT_HILT");
  _id_0557::_id_7848("8A The Hilt");
  _id_0557::_id_7846("8B final boss", ::_id_3AE7, ["8A The Hilt"], &"ZOMBIE_NEST_HINT_QUEST_BOSS", "ZOMBIE_NEST_HINT_QUEST_BOSS");
  _id_0557::_id_781E("8B final boss", "final boss battle part 1", ::_id_7853, _id_0557::_id_30D8, &"ZOMBIE_NEST_DEFEAT_FINAL_BOSS");
  _id_0557::_id_7848("8B final boss");
  level thread _id_5177();
}

_id_5177() {
  wait 1;
  _id_1CB7();
}

_id_785A() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\mp_zombie_nest_ee_util::_id_7403()) {
      var_0++;
    }
  }

  if(var_0 >= level.players.size) {
    common_scripts\utility::flag_set("flag_all_players_in_hilt");
  } else {
    thread _id_0C34();

    if(1) {
      var_4 = _getEnt("hilt_altar_model", "targetname");

      if(isDefined(var_4)) {
        var_5 = _id_0557::_id_782F(undefined, var_4);
        _id_0557::_id_781D("8A The Hilt", var_5);
      }
    }
  }

  common_scripts\utility::_id_3C9F("flag_all_players_in_hilt");
  _id_0557::_id_782D("8A The Hilt", "Use Hilt");
}

_id_785B() {
  foreach(var_1 in level.players) {
    maps\mp\_utility::_id_2CED(2, _id_0555::issprinting, "nest_no_return", var_1);
  }

  var_3 = _getEnt("hilt_altar_model", "targetname");

  if(isDefined(var_3)) {
    var_4 = _id_0557::_id_782F(undefined, var_3);
    _id_0557::_id_781D("8A The Hilt", var_4);
  }

  _id_A68E();
  _id_0557::_id_782D("8A The Hilt", "Shoot Hilt");
}

_id_7853() {
  _id_A68E();
  level._id_6F1E = 1;
  level.pause_treasure_zombie_reason = "players are fighting the brute";
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  maps\mp\gametypes\zombies::_id_08B2((0, 0, 0), 1);
  _id_310A();
  var_0 = _id_9008();
  var_0 _id_8FF5();
  shootstopsound();
  thread _id_7432(0.25, 0);

  foreach(var_2 in level.players) {
    if(_id_0547::_id_5565(_id_0378::_id_307B(var_2._id_20D8), "mari")) {
      var_2 _id_0367::_id_8E3D("klausnononono", level.players);
    }
  }

  level thread common_scripts\_exploder::_id_2A6D(238, undefined, 0);
  level thread _id_76A1();
  level thread _id_92B5(3);
  level._id_179A _id_0560::_id_AB83();

  if(maps\mp\mp_zombie_nest_ee_hc_true_voice::_id_744B()) {
    var_0._id_52D0 = 17500;
    var_0._id_7B44 = 7500;
    var_0._id_5C61 = 120;
  } else {
    var_0._id_52D0 = 12500;
    var_0._id_7B44 = 5000;
    var_0._id_5C61 = 60;
  }

  _id_0557::_id_7822("8B final boss", &"ZOMBIE_NEST_DEFEAT_FINAL_BOSS");
  maps\mp\_events_z::start_boss_battle_tracking();
  level _id_9308(var_0);
  maps\mp\_events_z::end_boss_battle_tracking();
  thread _id_3BEB();
  thread _id_3BE5();
  thread maps\mp\mp_zombie_nest_ee_util::_id_9EC4();
  level thread _id_93F5();
  level _id_310B(var_0);
  level _id_238D();
  thread maps\mp\mp_zombie_nest_ee_util::_id_9EC5();
  level._id_6F1E = 0;

  foreach(var_2 in level.players) {
    var_2 setlocalplayerprofiledata("specialUnlocks", 1, "1");
  }

  maps\mp\gametypes\zombies::_id_47A8("ZM_BRUTE");

  if(maps\mp\mp_zombie_nest_ee_hc_true_voice::_id_744B()) {
    maps\mp\gametypes\zombies::_id_47A8("ZM_KLAUS");
    level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_nest_01_final_boss", 1);
  } else
    level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("mp_zombie_nest_01_final_boss", 0);

  level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("any_boss_completed");
  thread maps\mp\mp_zombie_nest_ee_fire_well::_id_AA07();
  level thread _id_4AD1();
}

_id_7432(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = "white";
  }

  foreach(var_4 in level.players) {
    if(var_1 >= 1) {
      if(isDefined(var_4._id_1781)) {
        var_4._id_1781 destroy();
      }

      var_4._id_1781 = _id_2787("black", 0.0, var_4, (1, 1, 1));
      var_4._id_1781 setshader(var_2, 640, 480);
    }

    if(isDefined(var_4._id_1781)) {
      var_4._id_1781 fadeovertime(var_0);
      var_4._id_1781.alpha = var_1;
    }
  }

  wait(var_0);
}

_id_3BEB() {
  var_0 = _getscriptablearray("fire_on", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("fire", "die");
  }
}

_id_3BE5() {
  var_0 = _getscriptablearray("fill_on", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("fire_fill", "die");
  }
}

_id_92B5(var_0) {
  level endon("stop_start_zombie_minimum");

  for(;;) {
    var_1 = _id_0547::_id_408F();
    var_2 = var_1.size;

    if(var_2 < 3) {
      for(var_3 = 0; var_3 < 3 - var_2; var_3++) {
        var_4 = _id_054D::_id_90BA("zombie_generic", undefined, "wave system", 1, 0, 1, undefined);
      }
    }

    wait 3;
  }
}

_id_93F5() {
  level notify("stop_start_zombie_minimum");
}

_id_0C34() {
  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(var_2 maps\mp\mp_zombie_nest_ee_util::_id_7403()) {
        var_0++;
      }
    }

    if(var_0 >= level.players.size) {
      common_scripts\utility::flag_set("flag_all_players_in_hilt");
      break;
    } else
      wait 1;
  }
}

_id_38D9(var_0) {
  maps\mp\mp_zombie_nest_ee_fire_well::showviewmodel();
  var_0 _id_A695();
  var_0 _id_1C88();
  var_0._id_3ACE delete();
  maps\mp\mp_zombie_nest_ee_fire_well::hideviewmodel(1);
}

_id_9008() {
  var_0 = common_scripts\utility::_id_46B5("final_brute_boss", "targetname");
  var_1 = _id_054D::_id_90BA("zombie_boss_village", var_0, "fire well", 0, 0, 0);
  var_1._id_1CBD = var_0;
  var_1 _id_0547::disableoffhandsecondaryweapons();
  return var_1;
}

_id_1C88() {
  level notify("brute battle complete");
  level._id_1CBA = 0;
}

_id_A695() {
  level endon("brute battle complete");
  level._id_1CBA = 1;
  _id_8A0A();
  thread _id_055F::_id_1CC6();
  var_0 = _id_8A09();
  var_1 = var_0["brute_sequences_completed"];
  var_2 = var_0["brute_health_checkpoints"];
  var_3 = "";
  var_4 = 50000;

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    var_6 = _id_A697(50000, 50000 - self._id_52D0);
    _id_6AC8();

    if(var_5 == var_2.size - 1) {
      _preloadcinematicforall("mp/zombie_outro");
    }

    if(var_5 < var_2.size - 1) {
      if(isDefined(var_6)) {
        var_6 thread _id_2E81();
      }

      _id_92E2();
      continue;
    }

    level notify("brute battle complete");
  }
}

_id_A697(var_0, var_1) {
  var_2 = var_0;
  var_3 = 0;
  var_4 = undefined;

  while(!var_3) {
    _id_A6CA(var_2, var_1);

    if(self._id_0BA4 == "traverse") {
      while(self._id_0BA4 == "traverse") {
        wait 1;
      }
    }

    [var_3, var_4] = _id_055F::_id_AB7B();

    if(!var_3) {
      var_2 = var_1 + self._id_7B44;
      _id_055F::_id_AB75();
    }
  }

  return var_4;
}

_id_6AC8() {
  thread _id_1CCE();
}

_id_92E2() {
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
  self._id_99E6 = self._id_5C61;

  while(self._id_99E6 > 0) {
    self._id_99E6 = self._id_99E6 - 1;
    wait 1;
  }

  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
  _id_0560::_id_1F46();
  _id_055F::_id_AB72();
}

_id_A6CA(var_0, var_1) {
  var_2 = var_0;

  while(var_2 > var_1) {
    self waittill("brute_boss_damage", var_3, var_4);

    if(common_scripts\utility::_id_562E(self._id_55A6)) {
      continue;
    }
    var_3 = maps\mp\mp_zombie_nest_ee_util::_id_98ED(var_4, var_3);
    var_3 = var_3 / level.players.size;
    var_2 = var_2 - var_3;
  }
}

_id_1CCE() {
  playFX(common_scripts\utility::_id_44F5("nuke_blast"), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  _id_0378::_id_8D74("aud_nuke_explo");
  maps\mp\gametypes\zombies::_id_281C("ammo", self.origin, "random", 0, 0);
  level thread maps\mp\gametypes\zombies::_id_08B2(self.origin);
  _id_055F::_id_AB79();
}

_id_8A09() {
  var_0 = [];
  var_1 = [];
  var_2 = "";

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_0[var_3] = 0;
    var_1[var_3] = 50000 * (1 - (var_3 * 0.333333 + 0.166667));
    var_2 = var_2 + (var_1[var_3] + " ");
  }

  var_4 = [];
  var_4["brute_sequences_completed"] = var_0;
  var_4["brute_health_checkpoints"] = var_1;
  return var_4;
}

_id_8A0A() {
  self._id_3ACE = _getEnt("brute_boss_agent_interact", "targetname");
  self._id_3ACE enablelinkTo();
  self._id_3ACE linktosynchronizedparent(self);
  self._id_3ACE setHintString(&"ZOMBIES_EMPTY_STRING");
}

_id_2E81() {
  wait 3;
  _id_0367::_id_8E3D("uberbossinsertion");
}

_id_3AE7() {
  var_0 = level.players;

  foreach(var_2 in var_0) {
    if(common_scripts\utility::_id_562E(var_2._id_596A)) {
      var_2.besttimetrialtimes[4] = int(gettime() / 1000);
    }

    if(maps\mp\mp_zombie_nest_ee_hc_true_voice::_id_744B()) {
      var_2 _id_054C::_id_AC23("brutefinalehc");
      level._id_400E[level._id_400E.size] = ["survivalist_set 1 -1", "all"];
      var_2 _id_056A::_id_4772(1);
    } else
      var_2 _id_054C::_id_AC23("brutefinale");

    var_2 _id_0378::_id_8D74("objective_complete", "brutefinale");
    var_2 _id_0468::_id_0A2B("killBoss");
    level._id_400E[level._id_400E.size] = ["raven_set 1 1", "all"];

    if(level._id_A980 <= 12) {
      level._id_400E[level._id_400E.size] = ["assassin_set 0 1", "all"];
    }

    level._id_400E[level._id_400E.size] = ["assassin_set 1 1", "all"];
    level._id_400E[level._id_400E.size] = ["assassin_set 2 1", "all"];
    level._id_400E[level._id_400E.size] = ["assassin_set 3 1", "all"];
    level._id_400E[level._id_400E.size] = ["assassin_set 4 1", "all"];
  }
}

_id_238D() {
  level._id_1CBA = 0;
  level thread _id_5F28();
  _id_7E33();
  _id_0557::_id_782D("8B final boss", "final boss battle part 1");
}

_id_51EB() {
  var_0 = common_scripts\utility::_id_44BD("klaus_revive_spawn_point", "targetname");
}

_id_4AD1() {
  var_0 = common_scripts\utility::_id_44BD("klaus_revive_spawn_point", "targetname");
  var_1 = maps\mp\mp_zombie_nest_ee_hc_true_voice::_id_744B();
  var_2 = 0;

  if(var_1) {
    var_2 = 6.7;
  } else {
    var_2 = 7.4;
  }

  if(var_1) {
    thread _id_8FEE(var_0);

    if(level.players.size < 2) {
      level._id_400E[level._id_400E.size] = ["bat_elite_set 0 1", "all"];
    }

    if(level._id_A980 <= 16) {
      level._id_400E[level._id_400E.size] = ["bat_elite_set 1 1", "all"];
    }

    if(gettime() - level.starttime <= 4500000) {
      level._id_400E[level._id_400E.size] = ["bat_elite_set 2 1", "all"];
    }

    level._id_400E[level._id_400E.size] = ["bat_elite_set 3 1", "all"];
    level._id_400E[level._id_400E.size] = ["bat_elite_set 4 1", "all"];
    level._id_400E[level._id_400E.size] = ["wicht_set 0 1", "all"];
  } else
    thread _id_8F93(var_0);

  var_3 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_5 in var_3) {
    if(var_5._id_000A == level._id_746E) {
      continue;
    }
    if(isalive(var_5)) {
      var_5._id_1DEB = 1;
      var_5 suicide();
    }
  }

  _id_056D::_id_8A6E(1);
  _id_83E0(var_0);
  var_7 = 1.0;
  _id_7432(var_7, 0);

  foreach(var_9 in level.players) {
    var_9 playershow();
    var_9 setstance("stand");
    var_9 unlink();

    if(isDefined(var_9._id_1781)) {
      var_9._id_1781 destroy();
    }

    var_9._id_324E = 0;
  }

  var_11 = common_scripts\utility::_id_46B7("klaus_player_pos", "targetname");
  var_12 = maps\mp\mp_zombie_nest_ee_util::_id_440D();

  for(var_13 = 0; var_13 < var_12.size; var_13++) {
    var_12[var_13] thread _id_74BE(var_0, var_11[var_13], var_1, var_2);
    var_12[var_13] thread _id_0367::_id_8E3C("klauscorpseview");
  }

  if(var_1) {
    wait 4.666;
    common_scripts\utility::flag_init("flag_dlg_klaus_reached_pnt_1");
    common_scripts\utility::flag_init("flag_dlg_klaus_reached_pnt_2");
    common_scripts\utility::flag_init("flag_dlg_klaus_reached_pnt_3");
    common_scripts\utility::flag_init("flag_dlg_klaus_reached_pnt_4");
    common_scripts\utility::flag_init("flag_klaus_reached_well");
    maps\mp\mp_zombie_nest_ee_fire_well::_id_AA07();
    maps\mp\mp_zombie_nest_ee_fire_well::showviewmodel();
    level notify("klaus_getup");
    thread _id_2E92();
    level._id_5A89 waittill("klaus_getup_finished");
    level._id_5A89 _meth_80B1();
    level._id_5A89 thread _id_0568::_id_5A98();

    foreach(var_9 in level.players) {
      var_9 _id_0547::_id_8A6D(0);
    }

    _id_056D::_id_8A6E(0);
    wait 1;
    var_16 = common_scripts\utility::_id_46B5("klaus_mid_point", "targetname");
    var_17 = common_scripts\utility::_id_46B5("klaus_mid_point_2", "targetname");
    var_18 = common_scripts\utility::_id_46B5("klaus_mid_point_3", "targetname");
    var_19 = common_scripts\utility::_id_46B5("klaus_ent_point", "targetname");
    thread _id_5A9D();
    level._id_5A89 _id_0568::_id_5A90(var_16);
    common_scripts\utility::flag_set("flag_dlg_klaus_reached_pnt_1");
    level._id_5A89 _id_0568::_id_5A90(var_17);
    common_scripts\utility::flag_set("flag_dlg_klaus_reached_pnt_2");
    level._id_5A89 _id_0568::_id_5A90(var_18);
    common_scripts\utility::flag_set("flag_dlg_klaus_reached_pnt_3");
    level._id_5A89 _id_0568::_id_5A90(var_19);
    common_scripts\utility::flag_set("flag_dlg_klaus_reached_pnt_4");
    _id_647E();
  } else {
    wait 7.3;

    foreach(var_9 in level.players) {
      var_9 _id_0547::_id_8A6D(0);
    }

    _id_056D::_id_8A6E(0);
    _id_AA0A();
  }

  var_22 = &"ZOMBIE_NEST_HINT_STEP_EPILOGUE_FAIL";

  if(var_1) {
    var_22 = &"ZOMBIE_NEST_HINT_STEP_EPILOGUE_SUCCESS";
  }

  _id_0557::_id_7846("9 Epilogue", _id_0557::_id_30D8, undefined, &"ZOMBIE_NEST_HINT_QUEST_EPILOGUE", "ZOMBIE_NEST_HINT_QUEST_EPILOGUE");
  _id_0557::_id_781E("9 Epilogue", "Epilogue Step", undefined, _id_0557::_id_30D8, var_22);
  _id_0557::_id_7848("9 Epilogue");
}

_id_2E92() {
  level._id_5A89 endon("klaus_exploit_warp");
  wait 8;

  foreach(var_1 in level.players) {
    if(_id_0547::_id_5565(_id_0378::_id_307B(var_1._id_20D8), "mari")) {
      var_1 _id_0367::_id_8E3D("holdstillbrotherifollowed", level.players);
    }
  }

  level._id_5A89 waittill("klaus_getup_finished");
  wait 1;

  foreach(var_1 in level.players) {
    if(_id_0547::_id_5565(_id_0378::_id_307B(var_1._id_20D8), "mari")) {
      var_1 _id_0367::_id_8E3D("klaus", level.players);
    }
  }

  common_scripts\utility::_id_3C9F("flag_dlg_klaus_reached_pnt_1");
  _id_0378::_id_8D74("aud_revived_klaus_speak", level._id_5A89, 3);
  common_scripts\utility::_id_3C9F("flag_dlg_klaus_reached_pnt_2");
  _id_0378::_id_8D74("aud_revived_klaus_speak", level._id_5A89, 4);
  common_scripts\utility::_id_3C9F("flag_dlg_klaus_reached_pnt_3");
  _id_0378::_id_8D74("aud_revived_klaus_speak", level._id_5A89, 5);
  common_scripts\utility::_id_3C9F("flag_dlg_klaus_reached_pnt_4");
  _id_0378::_id_8D74("aud_revived_klaus_speak", level._id_5A89, 6);
}

_id_5A9D() {
  level._id_5A89 endon("death");
  level endon("flag_klaus_reached_well");
  wait 180;
  level._id_5A89 notify("klaus_exploit_warp");
  level._id_5A89 scragentclearpath();
  _id_5A8D();
}

_id_8FEE(var_0) {
  level._id_5A89 = _id_0568::_id_5A97(var_0);
}

_id_647E() {
  level._id_5A89 endon("death");
  level._id_5A89 endon("klaus_exploit_warp");
  var_0 = common_scripts\utility::_id_46B5("klaus_revive_death_point", "targetname");
  level._id_5A89 _id_0568::_id_5A90(var_0);
  common_scripts\utility::flag_set("flag_klaus_reached_well");
  _id_5A8D();
}

_id_5A8D() {
  level._id_5A89 thread _id_0568::_id_5A96();
  wait 0.666667;
  _id_0378::_id_8D74("aud_revived_klaus_speak", level._id_5A89, 7);
  thread _id_35A7();
  wait 3.06667;
  thread maps\mp\mp_zombie_nest_ee_fire_well::_id_7854();
  thread maps\mp\gametypes\zombies::_id_08B2(level._id_5A89.origin, 1);
  wait 0.65;
  _id_AA0A();
  wait 2;
  maps\mp\mp_zombie_nest_ee_fire_well::hideviewmodel();
}

_id_35A7() {
  wait 3.5;
  _playFXOnTag(level._effect["zmb_klaus_fire_hide"], level._id_5A89, "TAG_ORIGIN");
}

_id_8F93(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("zom_klaus_wholebody");
  var_1 scriptmodelplayanim("s2_zom_kls_lay_idle", "klaus_revival");
}

_id_74BE(var_0, var_1, var_2, var_3) {
  var_4 = "hilt_inspect_zm";

  if(var_2) {
    var_4 = "hilt_inspect_hc_zm";
  }

  common_scripts\utility::_id_0603();
  common_scripts\utility::_disableoffhandweapons();
  waitframe();
  _id_0586::_id_078C(var_4);
  self enableweapons();
  self switchtoweapon(var_4);
  waitframe();
  wait(var_3);
  self switchtoweapon(_id_0547::_id_AB2B());
  common_scripts\utility::_id_0617();
  common_scripts\utility::_id_0614();

  if(self hasweapon(var_4)) {
    _id_0586::_id_0790(var_4);
  }

  maps\mp\_utility::freezecontrolswrapper(0);
  self _meth_8546(1);
  self allowjump(1);
  self allowcrouch(1);
  self allowads(1);
  self allowfire(1);
  self allowsprint(1);
  self allowmelee(1);
  self allowprone(1);
  self _meth_85BF(1);
  self _meth_8309(1);
}

_id_9308(var_0) {
  level thread _id_38D9(var_0);
  level thread _id_5CCA(var_0);
  level thread _id_6CC3();
  level thread _id_6C00();
  level waittill("brute battle complete");
  level thread common_scripts\_exploder::_id_088E(238);
  _id_0378::_id_8D74("brute_battle_complete_notification");
  waitframe();
  var_1 = getEntArray("nest_brute_uber_inserts", "targetname");

  foreach(var_3 in var_1) {
    var_3 delete();
  }
}

_id_8FF5() {
  var_0 = common_scripts\utility::_id_46B7(self._id_1CBD.target, "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = _id_054D::_id_90BA("zombie_generic", var_3, "brute introduction", 1, 1, 1);
    var_1 = common_scripts\utility::_id_0F6F(var_1, var_4);
  }

  waitframe();

  foreach(var_7 in var_1) {
    var_7 _id_0547::disableoffhandsecondaryweapons();
    var_7 thread _id_ABE1();
  }
}

_id_ABE1() {
  self endon("death");
  self._id_4B9F = 1;
  var_0 = "board_taunt";
  var_1 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0, undefined, 1);

  if(isDefined(var_1)) {
    var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_7A35(var_1);
    self scragentsetanimmode("anim deltas");
    self scragentsetorientmode("face angle abs", self.angles);
    self scragentsetscripted(1);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, var_2, 1.0, "taunt_anim");
    self scragentsetscripted(0);
  }
}

_id_40E2() {
  return "flag_hilt_collected";
}

_id_A68E() {
  while(!common_scripts\utility::_id_562E(level._id_6654)) {
    wait 0.5;
  }
}

_id_A696() {
  var_0 = common_scripts\utility::_id_46B5("put_brute_out_of_misery", "targetname");

  while(distance(self.origin, var_0.origin) > var_0.radius) {
    wait 0.5;
  }
}

_id_44C9(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    foreach(var_6 in level.players) {
      if(distance(var_4.origin, var_6.origin) < var_1) {
        var_2 = common_scripts\utility::_id_0F6F(var_2, var_4);
      }
    }
  }

  return var_2;
}

_id_7E33() {
  level._id_1CBF = undefined;
  maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8607();
  level._id_1CBA = 0;
}

_id_3204() {
  self scriptmodelplayanim("s2_zom_brt_klaus_intro");
}

#using_animtree("zombie_boss");

_id_310A() {
  var_0 = "cam_note_notify";
  var_1 = [0.6615, 0.4461, 0.2153, 0.9846, 1];

  if(getdvarint("scr_bruteIntroSkip", 0) == 1) {
    return;
  }
  var_2 = % s2_zom_brt_cam_intro;
  var_3 = % s2_zom_brt_intro;
  var_4 = 0.25;
  wait(3 - var_4);
  setDvar("4712", 2);
  thread maps\mp\mp_zombie_nest_ee_util::_id_9EC4();
  thread maps\mp\mp_zombie_nest_ee_util::_id_3BE6();
  thread maps\mp\mp_zombie_nest_ee_util::_id_3BEC();
  level._id_22F0 = 1;
  level thread maps\mp\mp_zombie_nest_straub_appearances::_id_93F6();
  level thread common_scripts\_exploder::_id_088E(221);
  _id_7432(var_4, 1);
  var_5 = common_scripts\utility::_id_46B5("final_boss_anim_intro_scripted_node", "targetname");
  level._id_7317 = spawn("script_model", (0, 0, 0));
  level._id_7317 setModel("player_generic_world_body");
  level._id_7317 ghost();
  var_6 = spawn("script_model", (0, 0, 0));
  var_6 setModel("zom_brute_b_base");
  var_7 = spawn("script_model", (0, 0, 0));
  var_7 setModel("zom_klaus_wholebody");
  var_7 linkTo(var_6, "tag_origin");
  var_8 = spawn("script_model", (0, 0, 0));
  var_8 setModel("zmb_rock_intro_02");

  foreach(var_10 in level.players) {
    if(_id_0547::_id_577E(var_10)) {
      var_10 notify("revive_trigger");
    }

    if(var_10 getstance() != "stand") {
      var_11 = var_10 setstance("stand", 0);
      waittillframeend;
      var_12 = var_10 getstance();

      while(var_12 != "stand") {
        var_12 = var_10 getstance();
        waitframe();
      }
    }

    var_10 allowprone(0);
    var_10 allowcrouch(0);
    var_10 allowjump(0);
    var_10 _meth_8546(0);
  }

  wait 0.5;

  foreach(var_10 in level.players) {
    var_10 maps\mp\_utility::freezecontrolswrapper(1);
    var_10._id_324E = 1;
    var_10 setclienttriggervisionset("mp_zombie_nest_01");
    var_10 setclientomnvar("ui_hide_hud", 1);
    var_10 hideviewmodel();
    var_10 playerhide();
    var_10 disableweapons();
    var_10 setOrigin(level._id_7317 gettagorigin("tag_player"));
    var_10 setplayerangles(level._id_7317 gettagangles("tag_player"));
    var_10 playerlinktoabsolute(level._id_7317, "tag_player");
    var_10 _id_0547::_id_8A6D(1);
  }

  wait(var_4);
  _id_0378::_id_8D74("brute_intro_begin");
  level._id_7317 scriptmodelplayanimdeltamotionfrompos("s2_zom_brt_cam_intro", var_5.origin, var_5.angles, var_0);
  var_6 scriptmodelplayanimdeltamotionfrompos("s2_zom_brt_intro", var_5.origin, var_5.angles);
  var_8 scriptmodelplayanimdeltamotionfrompos("s2_zom_brt_rock_intro", var_5.origin, var_5.angles);

  if(isDefined(level._id_179A)) {
    level._id_179A _id_0560::_id_AB81();
  }

  level._id_7317 childthread _id_20B6(var_2, var_0, var_1);
  var_7 _id_3204();
  var_16 = _getanimlength(var_3);
  waitframe();
  _id_7432(var_4, 0);

  foreach(var_10 in level.players) {
    var_10 enablephysicaldepthoffieldscripting();
    var_10 setphysicaldepthoffield(3.0, 80, 20);
  }

  wait 15.8;

  foreach(var_10 in level.players) {
    var_10 setphysicaldepthoffield(8.0, 140, 20);
  }

  wait 18.5;
  _id_0380::_id_6842("zmb_nst01_mari_klauswhathavetheydonetoyo", level.players, level._id_7317.origin);
  wait 13.7;

  foreach(var_10 in level.players) {
    var_10 setphysicaldepthoffield(10.0, 4000, 20);
  }

  wait 7;

  foreach(var_10 in level.players) {
    var_10 setphysicaldepthoffield(18.0, 64, 20);
  }

  wait(var_16 - (55.0 + var_4 + var_4));

  foreach(var_10 in level.players) {
    var_10 disablephysicaldepthoffieldscripting();
  }

  _id_7432(var_4, 1);
  var_6 delete();
  var_7 delete();
  level._id_22F0 = 0;

  if(isDefined(level._id_179A)) {
    level._id_179A _id_0560::_id_AB85();
  }

  level._id_7317 scriptmodelclearanim();
  level._id_7317.origin = level._id_7317.origin + (0, 0, 32);
  thread maps\mp\mp_zombie_nest_ee_util::_id_1CC9();
  thread maps\mp\mp_zombie_nest_ee_util::_id_1CCB();
  setDvar("4712", 1);
  level thread common_scripts\_exploder::_id_2A6D(221, undefined, 0);

  foreach(var_10 in level.players) {
    var_10 unlink();
    var_10 playershow();
    var_10 showviewmodel();
    var_10 enableweapons();
    var_10 maps\mp\_utility::freezecontrolswrapper(0);
    var_10 allowprone(1);
    var_10 allowcrouch(1);
    var_10 allowjump(1);
    var_10 _meth_8546(1);
    var_10 _id_0547::_id_8A6D(0);
    var_10 setclientomnvar("ui_hide_hud", 0);
    var_10._id_324E = 0;
  }

  level._id_7317 delete();
  var_8 delete();
  _id_0378::_id_8D74("brute_intro_end");
}

_id_20B6(var_0, var_1, var_2) {
  var_3 = _func_2C7(var_0);
  var_4 = 1;

  foreach(var_6 in level.players) {
    var_6 lerpfovscale(var_2[0], 0);
  }

  for(var_8 = 0; var_8 < var_3.size; var_8++) {
    maps\mp\agents\_scripted_agent_anim_util::_id_A79E(var_1, var_3[var_8]["name"]);

    switch (var_3[var_8]["name"]) {
      case "fov end":
        foreach(var_6 in level.players) {
          var_6 thread _id_9C7A(var_0, var_2[var_4], var_8, var_3);
        }

        var_4++;
        break;
      case "fov default":
        foreach(var_6 in level.players) {
          var_6 lerpfovscale(1, 0);
        }

        break;
    }
  }

  var_13 = "";
}

_id_9C7A(var_0, var_1, var_2, var_3) {
  self notify("new_fov_trans");
  self endon("new_fov_trans");
  var_4 = _getanimlength(var_0) * (var_3[var_2 + 1]["time"] - var_3[var_2]["time"]);
  var_4 = int(var_4 * 10) / 10;
  self lerpfovscale(var_1, var_4);
}

_id_310B(var_0) {
  var_1 = 1.0;

  foreach(var_3 in level.players) {
    var_3 disableweapons();
    var_3 playerhide();
    var_3 maps\mp\_utility::freezecontrolswrapper(1);
    var_3 _id_0547::_id_8A6D(1);
    var_3 setclientomnvar("ui_hide_hud", 1);
    var_3._id_324E = 1;
  }

  _id_7432(var_1, 1);
  var_0._id_5A9C delete();
  var_0 suicide();
  _playcinematicforall("mp/zombie_outro", 1);

  foreach(var_3 in level.players) {
    var_3 setplayerdata(common_scripts\utility::_id_46A8(), "cinematicUnlocked", 0, 1);
  }

  _id_7432(0.01, 0);
  wait 47;
  _id_7432(0.01, 1);
  _stopcinematicforall("mp/zombie_outro");

  foreach(var_3 in level.players) {
    var_3 setclientomnvar("ui_hide_hud", 0);
  }
}

_id_76A1() {
  var_0 = common_scripts\utility::_id_46B7("zmb_blimp_pieces_struct", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_57F7 = 0;
  }

  level._id_179A _id_0560::_id_7D52(1);
  level._id_179A _id_0560::_id_85FB(1);
}

_id_6CC3() {
  var_0 = common_scripts\utility::_id_46B7("zombie_spawner", "script_noteworthy");
  level._id_1CBF = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2.setgoalnode) && var_2.setgoalnode == "zmb_brute_valid_spawner") {
      level._id_1CBF = common_scripts\utility::_id_0F6F(level._id_1CBF, var_2);
    }
  }

  var_6 = common_scripts\utility::_id_46B7("zmb_blimp_pieces_struct", "targetname");
  level._id_1CBC = [];

  foreach(var_2 in var_6) {
    if(var_2.getnegotiationnextnode == "zeppelin_part_drop_brute") {
      level._id_1CBC = common_scripts\utility::_id_0F6F(level._id_1CBC, var_2);
    }
  }
}

_id_5CCA(var_0) {
  level thread common_scripts\_exploder::_id_088E(240);
  var_1 = getEntArray("brute_final_barrier", "targetname");
  var_2 = getEntArray("brute_exit_traversal_mantle", "targetname");
  var_1 = common_scripts\utility::_id_0F73(var_1, var_2);
  _id_AA09();
  var_3 = getEntArray("brute_exit_trucks", "targetname");

  foreach(var_5 in var_3) {
    var_5 hide();
  }

  foreach(var_8 in var_1) {
    if(var_8.classname != "script_model") {
      var_8.origin = var_8.origin + (0, 0, 1024);
    } else {
      var_8 show();
      var_9 = common_scripts\utility::_id_46B5(var_8.target, "targetname");
      var_8.origin = var_9.origin;

      if(isDefined(var_9.angles)) {
        var_8.angles = var_9.angles;
      }
    }

    var_10 = anglesToForward(var_8.angles);

    if(var_8.model == "zmb_brute_debris_02") {
      var_8._id_3BBC = _spawnfx(common_scripts\utility::_id_44F5("zmb_brute_debris_fire_01"), var_8.origin, var_10);
      _triggerfx(var_8._id_3BBC);
    }
  }

  waitframe();

  foreach(var_8 in var_1) {
    if(var_8.classname != "script_model") {
      waitframe();
      var_8 disconnectPaths();
    }
  }

  var_14 = _getEnt("brute_debris_floor_clip", "targetname");
  var_14 solid();
  var_14 connectpaths();
  var_15 = getEntArray("brute_exit_blocker_village_gallows", "targetname");

  foreach(var_8 in var_15) {
    var_8 notsolid();
    var_8 connectpaths();
  }

  var_18 = _getEnt("brute_exit_blocker_tower_path", "targetname");
  var_18 hide();
  var_14 notsolid();
}

_id_AA0B() {
  var_0 = getEntArray("well_debris_brute", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 hide();
  }
}

_id_AA09() {
  maps\mp\mp_zombie_nest_ee_fire_well::_id_AA04();
  var_0 = getEntArray("well_debris_brute", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_46B5(var_2.target, "targetname");
    var_2.origin = var_3.origin;

    if(isDefined(var_3.angles)) {
      var_2.angles = var_3.angles;
    }

    var_2 show();

    if(var_2.model == "zmb_brute_debris_01") {
      var_4 = anglesToForward(var_0[0].angles);
      var_2._id_3BBC = _spawnfx(common_scripts\utility::_id_44F5("zmb_brute_debris_fire_02"), var_2.origin, var_4);
      _triggerfx(var_2._id_3BBC);
    }
  }
}

_id_AA0A() {
  var_0 = getEntArray("well_debris_brute", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2.origin = var_2.origin + (0, 0, -128);

    if(isDefined(var_2._id_3BBC)) {
      var_2._id_3BBC delete();
    }

    var_2 delete();
  }

  maps\mp\mp_zombie_nest_ee_fire_well::_id_AA08();
}

_id_5F28() {
  var_0 = getEntArray("brute_final_barrier", "targetname");
  var_1 = getEntArray("brute_exit_traversal_mantle", "targetname");
  var_0 = common_scripts\utility::_id_0F73(var_0, var_1);
  _id_1CB7();
  var_2 = getEntArray("brute_exit_trucks", "targetname");

  foreach(var_4 in var_2) {
    var_4 show();
  }

  foreach(var_7 in var_0) {
    if(var_7.classname != "script_model") {
      var_7 connectpaths();
    }

    if(isDefined(var_7._id_3BBC)) {
      var_7._id_3BBC delete();
    }

    var_7 delete();
  }

  _stopclientexploder(240, level.players, 1);
  var_9 = getEntArray("brute_exit_blocker_village_gallows", "targetname");

  foreach(var_7 in var_9) {
    var_7 solid();

    if(var_7.classname != "script_model") {
      var_7 disconnectPaths();
    }
  }

  var_12 = _getEnt("brute_exit_blocker_tower_path", "targetname");
  var_12 show();
}

_id_1CB7() {
  var_0 = _getEnt("brute_debris_floor_clip", "targetname");
  var_0 solid();
  var_0 connectpaths();
}

shootstopsound() {
  var_0 = common_scripts\utility::_id_46B7("nest_ee_brute_boss_player_spawns", "targetname");
  level._id_1CBB = var_0;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1]._id_763C = level.players[var_1].origin;
    level.players[var_1] setOrigin(var_0[var_1].origin);
    level.players[var_1] setplayerangles(var_0[var_1].angles);
    level.players[var_1] unlink();
    level.players[var_1] enableweapons();
    level.players[var_1] freezecontrols(0);
    level.players[var_1]._id_AC5B = 0;
    level.players[var_1] playershow();
  }
}

_id_83E0(var_0) {
  maps\mp\gametypes\zombies::_id_7E57();
  var_1 = common_scripts\utility::_id_46B7("klaus_player_pos", "targetname");

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    level.players[var_2] setOrigin(var_1[var_2].origin);
    var_3 = var_0.origin - level.players[var_2] getEye();
    level.players[var_2] setplayerangles(vectortoangles(var_3));
    level.players[var_2] _meth_8546(0);
    level.players[var_2] allowjump(0);
    level.players[var_2] allowcrouch(0);
    level.players[var_2] allowads(0);
    level.players[var_2] allowfire(0);
    level.players[var_2] allowsprint(0);
    level.players[var_2] allowmelee(0);
    level.players[var_2] allowprone(0);
    level.players[var_2] _meth_85BF(0);
    level.players[var_2] _meth_8309(0);
  }
}

_id_7CD1(var_0) {
  level endon("game cinematic started");
  wait(var_0);
}

_id_2D3A(var_0) {
  wait(var_0);
  self delete();
}

_id_6C00() {
  _id_0547::_id_A6F6();

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1._id_3280) && var_1._id_3280 == "closeable") {
      var_1 notify("close");
    } else {
      var_1 notify("open");
    }

    foreach(var_3 in var_1._id_9DC2) {
      var_3 common_scripts\utility::_id_9D9F();
    }
  }

  level waittill("brute battle complete");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1._id_3280) && var_1._id_3280 == "closeable") {
      var_1 notify("open");
    }

    foreach(var_3 in var_1._id_9DC2) {
      var_3 common_scripts\utility::_id_9DA3();
    }
  }
}

_id_94BF(var_0, var_1) {
  self endon(var_1);
  _id_0555::issprinting("brute_stun");

  while(var_0 > 0) {
    var_0--;
    wait 1;
  }

  _id_0555::issprinting("brute_awake");
  self notify(var_1, 0);
}

_id_2787(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_4 = _newclienthudelem(var_2);
  } else {
    var_4 = newhudelem();
  }

  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader(var_0, 640, 480);
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.sort = 1;
  var_4._id_00C6 = "fullscreen";
  var_4._id_01CA = "fullscreen";
  var_4.alpha = var_1;
  var_4.foreground = 1;

  if(isDefined(var_3)) {
    var_4.color = var_3;
  }

  return var_4;
}