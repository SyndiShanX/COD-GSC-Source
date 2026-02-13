/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2023.gsc
*************************************************/

init() {
  level.killcam = scripts\mp\tweakables::_id_6E14("game", "allowkillcam");
  level._id_8D6A = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/miscKillcamItems.csv", var_0, 0);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    var_1 = int(var_1);
    var_2 = tablelookupbyrow("mp/miscKillcamItems.csv", var_0, 1);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    level._id_8D6A[var_2] = var_1;
    var_0++;
  }
}

_id_D4C0(var_0, var_1, var_2) {
  self setclientomnvar("cam_scene_name", var_0);
  self setclientomnvar("cam_scene_lead", var_1);
  self setclientomnvar("cam_scene_support", var_2);
}

_id_6AD9(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0) || !isDefined(var_1) || var_0 == var_1 && !isagent(var_0)) {
    return undefined;
  }

  if(_id_FEC2(var_0, var_1, var_2, var_3)) {
    return undefined;
  }

  if(_id_FED9(var_0, var_1, var_2, var_3)) {
    return var_1.killcament;
  }

  switch (var_2.basename) {
    case "chopper_support_turret_mp":
    case "hover_jet_turret_mp":
    case "bouncing_betty_mp":
    case "hover_jet_proj_mp":
    case "bomb_site_mp":
    case "s4_glidebomb_fromeo_mp":
    case "lighttank_mp":
    case "trip_mine_mp":
      return scripts\engine\utility::ter_op(isDefined(var_1.killcament), var_1.killcament, var_1);
    case "s4_strafing_run_mp":
    case "s4_v2_mp":
    case "s4_firebombing_run_mp":
    case "s4_ks_ord_ger_mp":
    case "none":
      if(_id_894C(var_1) || _id_8832(var_1)) {
        return var_1.killcament;
      }

      break;
  }

  if(scripts\common\utility::_id_87FC(var_2.basename) || scripts\mp\utility\weapon::_id_8787(var_2.basename)) {
    if(isDefined(var_1.killcament) && !var_0 scripts\mp\utility\killstreak::_id_1DD8()) {
      return var_1.killcament;
    } else {
      return undefined;
    }
  }

  if(scripts\common\utility::isentitylessdestructibleclass(var_1.classname)) {
    return undefined;
  }

  return var_1;
}

_id_FEC2(var_0, var_1, var_2, var_3) {
  switch (var_2.basename) {
    case "apache_proj_mp":
    case "apache_turret_mp":
    case "ac130_25mm_mp":
    case "ac130_40mm_mp":
    case "ac130_105mm_mp":
    case "cruise_proj_mp":
    case "tur_apc_rus_mp":
    case "lighttank_tur_mp":
    case "lighttank_tur_ks_mp":
    case "pac_sentry_turret_mp":
    case "s4_tank_tur_mp":
    case "thermite_bolt_radius_mp":
    case "thermite_bolt_mp":
    case "semtex_bolt_splash_mp":
    case "semtex_bolt_mp":
      return 1;
  }

  return 0;
}

_id_FED9(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(!var_1 scripts\cp_mp\vehicles\vehicle::_id_8AF5()) {
    return 0;
  }

  switch (var_3) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_PROJECTILE":
      return 1;
    default:
      return 0;
  }
}

_id_D5C8(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_5._id_30A0 = "unknown";

  if(isDefined(var_1) && isDefined(var_1._id_1210)) {
    var_7 = "killcam_agent";

    switch (var_1._id_1210) {
      case "actor_s4_mp_guard_dog_codmas":
      case "actor_s4_mp_attack_dog_codmas":
      case "actor_s4_mp_guard_dog":
      case "actor_s4_mp_attack_dog":
        var_7 = "killcam_dog";
        break;
    }

    _id_D4C0(var_7, var_0 getentitynumber(), var_3 getentitynumber());
    var_5._id_30A0 = var_7;
    return 1;
  } else if(isDefined(var_6) && isDefined(var_6.basename)) {
    if(var_6.basename == "manual_turret_mp") {
      return 1;
    }
  } else if(var_4 > 0) {
    _id_D4C0("unknown", -1, -1);
    return 0;
  } else {
    _id_D4C0("unknown", -1, -1);
    return 0;
  }

  return 0;
}

_id_F63E(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_2 + var_3;

  if(isDefined(var_5) && var_6 > var_5) {
    if(var_5 < 2) {
      return;
    }
    if(var_5 - var_2 >= 1) {
      var_3 = var_5 - var_2;
    } else {
      var_3 = 1;
      var_2 = var_5 - 1;
    }

    var_6 = var_2 + var_3;
  }

  var_7 = var_2 + var_4;

  if(isDefined(var_0) && isDefined(var_0._id_904F)) {
    var_8 = var_0._id_904F;
  } else {
    var_8 = var_1._id_904F;

    if(isDefined(var_1._id_441F)) {
      if(gettime() - var_1._id_441F < var_3 * 1000.0) {
        var_3 = 1.0;
        var_3 = var_3 - level._id_5F3A;
        var_6 = var_2 + var_3;
      }
    }
  }

  var_9 = (gettime() - var_8) / 1000.0;

  if(var_7 > var_9 && var_9 > var_4) {
    var_10 = var_9 - var_4;

    if(var_2 > var_10) {
      var_2 = var_10;
      var_6 = var_2 + var_3;
      var_7 = var_2 + var_4;
    }
  }

  var_11 = spawnStruct();
  var_11._id_30B2 = var_2;
  var_11._id_BA44 = var_3;
  var_11._id_8D68 = var_6;
  var_11._id_8D6B = var_7;
  return var_11;
}

_id_BB94(var_0) {
  if(isDefined(var_0) && !isagent(var_0)) {
    var_1 = [];

    if(isDefined(self.class) && isDefined(self._id_3808)) {
      var_2 = scripts\mp\playerlogic::_id_6C42(self._id_3808);
      var_1[var_1.size] = var_2;
    }

    if(isDefined(var_0.class) && isDefined(var_0._id_3808)) {
      var_3 = scripts\mp\playerlogic::_id_6C42(var_0._id_3808);
      var_1[var_1.size] = var_3;
    }

    if(var_1.size > 0) {
      scripts\mp\playerlogic::_id_96A6(var_1, 1);
    }

    self _meth_8282(var_0 getEye(), 1);
    self _meth_8215(var_0);
  }
}

_id_99F7(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15) {
  var_16 = spawnStruct();
  var_16._id_511D = var_0;
  var_16._id_7E94 = var_1;
  var_16._id_1DDB = var_2;
  var_16._id_8D63 = var_3;
  var_16._id_8D64 = var_4;
  var_16._id_8D69 = var_5;
  var_16._id_8D66 = var_6;
  var_16.objweapon = var_7;
  var_16._id_A983 = var_8;
  var_16._id_9CB1 = var_9;
  var_16.attacker = var_10;
  var_16._id_103C2 = var_11;
  var_16._id_DE2B = var_12;
  var_16._id_1DDA = var_13;
  var_16._id_DDB7 = var_14;
  var_16._id_4E76 = var_15;
  var_16.attackerhealthratio = int(var_10.health / var_10.maxhealth * 127);

  if(var_12 == "MOD_EXECUTION") {
    var_16._id_5705 = _id_0790::_id_56FC(var_10);
  }

  return var_16;
}

_id_4D03(var_0, var_1, var_2, var_3) {
  killcam(var_0._id_511D, var_0._id_7E94, var_0._id_1DDB, var_0._id_8D63, var_0._id_8D64, var_0._id_8D69, var_0._id_8D66, var_0.objweapon, var_1, var_0._id_A983, var_2, var_0._id_9CB1, var_0.attacker, var_0._id_103C2, var_0._id_DE2B, var_0._id_1DDA, var_0._id_DDB7, var_0._id_4E76, var_3);
}

_id_2EBD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(getDvar("#x3a08ff1cbfefa6b24") == "") {
    if(level._id_DCBA) {
      if(var_10 == "MOD_EXECUTION") {
        var_11 = 4.0;
      } else if(scripts\mp\utility\game::_id_875E()) {
        if(isDefined(var_2._id_C0F3) && var_2._id_C0F3 > 1) {
          var_11 = 4.0 + level._id_9C7E - var_9;
        } else {
          var_11 = 1.5 + level._id_9C7E - var_9;
        }
      } else
        var_11 = 4.0 + level._id_9C7E - var_9;
    } else if(var_7.basename == "s4_strafing_run_mp")
      var_11 = 2.25;
    else if(var_7.basename == "hover_jet_proj_mp") {
      var_11 = 3.0;
    } else if(var_7.basename == "hover_jet_turret_mp" || var_7.basename == "chopper_support_turret_mp") {
      var_11 = 1.5;
    } else if(var_7.basename == "s4_ks_ord_ger_mp") {
      var_11 = 2.5;
    } else if(var_7.basename == "cruise_proj_mp") {
      var_11 = 3.0;
    } else if(var_7.basename == "javelin_mp") {
      var_11 = 8;
    } else if(issubstr(var_7.basename, "remotemissile_")) {
      var_11 = 5;
    } else if(isDefined(var_0._id_D11F) && var_0._id_D11F == "multiturret") {
      var_11 = 2.0;
    } else if(!var_8 || var_8 > 5.0) {
      var_11 = 5.0;
    } else if(var_7.basename == "s4_frag_usa_mk2_mp" || var_7.basename == "frag_grenade_short_mp" || var_7.basename == "s4_semtex_mp" || var_7.basename == "semtexproj_mp" || var_7.basename == "mortar_shell__mp" || var_7.basename == "cluster_grenade_mp" || var_7.basename == "s4_frag_gbr_n23_mp" || var_7.basename == "s4_frag_ger_m24_mp" || var_7.basename == "s4_frag_gbr_n82_mp" || var_7.basename == "s4_bundle_charge_mp") {
      var_11 = 4.25;
    } else {
      var_11 = 2.5;
    }
  } else
    var_11 = getdvarfloat("#x3a08ff1cbfefa6b24");

  if(isDefined(var_5)) {
    if(var_11 > var_5) {
      var_11 = var_5;
    }

    if(var_11 < level._id_5F3A) {
      var_11 = level._id_5F3A;
    }
  }

  if(scripts\mp\utility\game::_id_875E()) {
    var_12 = 1;

    if(var_10 == "MOD_EXECUTION") {
      var_12 = 3.0;
    }
  } else if(getDvar("#x3e9f5ccdc5b198ab6") == "")
    var_12 = 2;
  else {
    var_12 = getdvarfloat("#x3e9f5ccdc5b198ab6");

    if(var_12 < level._id_5F3A) {
      var_12 = level._id_5F3A;
    }
  }

  if(var_3 < 0 || !isDefined(var_2)) {
    return undefined;
  }

  if(isagent(var_2) || isagent(var_0)) {
    var_3 = var_4 getentitynumber();
  }

  var_13 = _id_F63E(var_1, var_2, var_11, var_12, var_6, var_5);

  if(!isDefined(var_13)) {
    return undefined;
  }

  return var_13;
}

_id_D5D1(var_0) {
  self setclientomnvar("ui_killcam_killedby_id", var_0 getentitynumber());
}

_id_D5CF(var_0) {
  self setclientomnvar("ui_killcam_end_milliseconds", int(var_0 * 1000) + gettime());
}

_id_D887(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isPlayer(var_0)) {
    _id_D5D1(var_0);
    self setclientomnvar("ui_killcam_victim_id", var_1 getentitynumber());
    self _meth_8215(var_0);
  }

  if(scripts\mp\utility\weapon::_id_88F6(var_2.basename)) {
    _id_D5CB(var_2);
  } else if(scripts\mp\utility\game::_id_875D()) {
    for(var_6 = 0; var_6 < 6; var_6++) {
      self setclientomnvar("ui_killcam_killedby_perk" + var_6, -1);
    }

    if(isDefined(var_0.arena_evo_perks)) {
      var_7 = 0;

      foreach(var_9 in var_0.arena_evo_perks) {
        var_10 = scripts\mp\perks\perks::_id_6C26(var_9);
        self setclientomnvar("ui_killcam_killedby_perk" + var_7, var_10);
        var_7++;
      }
    }
  } else
    scripts\mp\perks\perks::_id_D626("ui_killcam_killedby_perk", var_5);

  var_12 = getdvarint("#x388d06624940c1a88");

  if(var_4 && !level.gameended || isDefined(self) && !level.gameended || var_12 == 0 && !level.gameended) {
    self setclientomnvar("ui_killcam_text", "skip");
  } else if(!level.gameended) {
    self setclientomnvar("ui_killcam_text", "respawn");
  } else {
    self setclientomnvar("ui_killcam_text", "none");
  }

  _id_D5CF(var_3._id_8D68);
}

_id_24A3(var_0, var_1, var_2, var_3) {
  scripts\mp\utility\player::_id_FD26("spectator");
  self._id_03EB = 1;
  self._id_01D2 = var_0;
  self.killcamentity = -1;
  self._id_0060 = var_1;
  self._id_8D68 = var_2;
  self._id_0354 = var_3;
  self _meth_8013("freelook", 1);
  self _meth_8013("none", 1);

  foreach(var_5 in level._id_EF89) {
    self _meth_8013(var_5, 1);
  }
}

_id_3524(var_0) {
  if(self._id_0060 + 0.015 < var_0) {
    var_1 = var_0 - self._id_0060;

    if(game["truncated_killcams"] < 32) {
      game["truncated_killcams"]++;
    }
  }
}

_id_BED3(var_0) {
  level._id_A795++;
  var_1 = 1;

  if(istrue(level._id_DCBA) && scripts\mp\utility\game::getgametype() == "br") {
    var_1 = 5;
  }

  var_2 = level._id_5F3A * int(floor((level._id_A795 - 1) / var_1));
  level._id_9C7E = var_2;
  var_3 = 0;

  if(var_2 > 0) {
    if(istrue(var_0)) {
      var_3 = 1;
      self setclientomnvar("ui_total_fade", 1.0);
    }

    wait(var_2);
  }

  waitframe();
  level._id_A795--;

  if(var_3) {
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0.1);
  }

  return var_2;
}

killcam(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18) {
  self endon("disconnect");
  self endon("spawned");
  level endon("game_ended");
  scripts\mp\utility\player::_id_BD21("killcam::killcam() START");
  _id_C634();
  var_19 = istrue(var_13.killedbyassistedsuicide) && getdvarint("assistedSuicideSkipKillcam", 1) == 1;

  if(var_2 < 0 || !isDefined(var_12) || var_19) {
    self notify("killcam_canceled");

    if(istrue(var_18)) {
      self setclientomnvar("post_game_state", 1);
    }

    return;
  }

  var_20 = istrue(level.ran_winner_circle_intro_fx) && istrue(var_18);
  var_21 = _id_BED3(var_20);
  var_22 = _id_2EBD(var_0, var_1, var_12, var_2, var_13, var_11, var_8, var_7, var_10, var_21, var_14);

  if(!isDefined(var_22)) {
    self notify("killcam_canceled");

    if(istrue(var_18)) {
      self setclientomnvar("post_game_state", 1);
    }

    return;
  }

  _id_D887(var_12, var_13, var_7, var_22, var_10, var_15);

  if(isPlayer(var_12)) {
    self _meth_8215(var_12);
  }

  _id_24A3(var_2, var_22._id_8D6B, var_22._id_8D68, var_9);
  var_23 = _id_D5C8(var_0, var_1, var_2, var_13, var_3, var_22, var_7);

  if(!var_23) {
    thread _id_D5C6(var_3, var_22._id_8D6B, var_4, var_5, var_6);
  }

  thread _id_52F3(var_18);
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  _id_3524(var_22._id_8D6B);
  var_22._id_30B2 = self._id_0060 - level._id_5F3A - var_8;
  var_22._id_8D68 = var_22._id_30B2 + var_22._id_BA44;
  self._id_8D68 = var_22._id_8D68;

  if(var_22._id_30B2 <= 0) {
    _id_8D61(1, undefined, var_18);
    return;
  }

  self.killcam = 1;
  thread killcamreportplayermonitor();
  thread _id_E2BC(var_18);

  if(istrue(var_17)) {
    thread _id_4D04(var_22._id_30B2);
  }

  if(!isDefined(var_16) || var_16) {
    thread _id_1085F(var_10);
  }

  if(istrue(var_18)) {
    thread _id_07D0::_id_5AA5();
  }

  thread _id_5323();

  if(!isbot(self)) {
    thread _id_C648();
  }

  self._id_8D6D = gettime();
  _id_1095A();
  self._id_8D6D = (gettime() - self._id_8D6D) / 1000;
  scripts\mp\utility\stats::_id_7DAE("timeWatchingKillcams", self._id_8D6D);
  _id_8D61(1, undefined, var_18);
  self _meth_8209(1, 0.5);
  scripts\mp\utility\player::_id_BD21("killcam::killcam() COMPLETE");
}

killcamreportplayermonitor() {
  self endon("disconnect");
  self endon("killcam_ended");

  if(!isai(self)) {
    if(self usinggamepad()) {
      self notifyonplayercommand("kc_report", "+melee");
      self notifyonplayercommand("kc_report", "+melee_zoom");
    } else
      self notifyonplayercommand("kc_report", "+special");

    for(;;) {
      self waittill("kc_report");
      self setclientomnvar("ui_killcam_report_player", 1);
      waitframe();
    }
  }
}

_id_C648() {
  self endon("disconnect");
  scripts\engine\utility::_id_108A8(0.15, "killcam_canceled", "spawned");
  self _meth_8283();

  if(istrue(level._id_DCBA)) {
    scripts\mp\gamelogic::_id_BB7C();
  }
}

_id_D8A5(var_0, var_1) {
  _id_D5D1(var_0);
  _id_D5CF(var_1);
}

_id_BA8A(var_0, var_1, var_2, var_3) {
  self endon("disconnect");
  _id_BB94(var_0);
  _id_C634();
  var_4 = var_0 getentitynumber();
  var_5 = istrue(level.ran_winner_circle_intro_fx);
  _id_BED3(var_5);

  if(isPlayer(var_0)) {
    self _meth_8215(var_0);
  }

  var_6 = gettime();
  var_7 = (var_6 - var_2) / 1000.0;
  var_8 = (var_6 - var_3) / 1000.0;
  var_9 = (var_3 - var_2) / 1000.0;
  _id_D8A5(var_0, var_9);
  self._id_0061 = 1;
  _id_24A3(var_4, var_7, var_9, var_1);
  waitframe();

  if(!isDefined(self)) {
    return;
  }
  _id_3524(var_7);
  self._id_8D68 = self._id_0060 - var_8;
  self.killcam = 1;
  self notify("begin_killcam");
  _id_1095A();
  _id_BA8E();
}

_id_BA8E() {
  self.killcam = undefined;
  _id_081A::_id_D6E2();
  scripts\mp\utility\player::_id_FD26("dead");
  scripts\mp\utility\player::_id_394E();
  self notify("killcam_ended");
}

_id_4D04(var_0) {
  self endon("killcam_ended");

  if(isDefined(level._id_4CFB)) {
    return;
  }
  level._id_4CFB = 1;
  var_1 = 0;
  var_2 = var_0;

  if(var_2 > 1.0) {
    var_2 = 1.0;
    var_1 = var_1 + 1.0;
    wait(var_0 - var_1);
  }

  if(!isDefined(level._id_8D60)) {
    _func_0428("killcam");
    level._id_8D60 = 1;
  }

  _func_01F0(1.0, 0.25, var_2);
  wait(var_2 + 0.5);
  _func_01F0(0.25, 1, 1);
  level._id_4CFB = undefined;
}

_id_D5CD(var_0, var_1, var_2, var_3) {
  if(var_1 == "MOD_EXECUTION") {
    _id_D5C9(var_3);
  } else if(!isDefined(var_0) || var_0.basename == "none") {
    _id_394B();
  } else {
    if(isDefined(var_2._id_7015)) {
      var_4 = undefined;
      var_0 = var_2._id_7015;
      var_2 = undefined;
    } else
      var_4 = scripts\mp\utility\weapon::_id_6A18(var_0.basename);

    if(isDefined(scripts\mp\supers::_id_6DA7(var_0))) {
      _id_D5CE(var_0);
    } else {
      if(isDefined(var_4) && (var_4 == "lethal" || var_4 == "tactical")) {
        _id_D5C7(var_0);
        return;
      }

      if(isDefined(level._id_8D6A[var_0.basename])) {
        _id_D5CC(level._id_8D6A[var_0.basename]);
        return;
      }

      _id_D5D0(var_0, var_2);
    }
  }
}

_id_1095A() {
  self endon("abort_killcam");
  scripts\mp\utility\player::_id_BD21("killcam::waittillKillcamOver() START");
  wait(self._id_8D68 - level._id_01E2 / 1000.0);
  scripts\mp\utility\player::_id_BD21("killcam::waittillKillcamOver() COMPLETE");
}

_id_D5C6(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  self endon("killcam_ended");
  var_5 = gettime() - var_1 * 1000;

  if(var_2 > var_5) {
    waitframe();
    var_1 = self._id_0060;
    var_5 = gettime() - var_1 * 1000;

    if(var_2 > var_5) {
      wait((var_2 - var_5) / 1000);
    }
  }

  self.killcamentity = var_0;

  if(isDefined(var_3)) {
    self._id_0266 = var_3;
  }

  if(isDefined(var_4)) {
    self _meth_8615(var_4);
  }
}

_id_1085F(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");

  if(!isai(self)) {
    self notifyonplayercommand("kc_respawn", "+usereload");
    self notifyonplayercommand("kc_respawn", "+activate");
    self notifyonplayercommand("kc_respawn_alt", "+gostand");
    var_1 = 0;

    while(!var_1) {
      var_2 = scripts\engine\utility::_id_10897("kc_respawn", "kc_respawn_alt");

      if(var_2 == "kc_respawn_alt") {
        if(!self usinggamepad() || self _meth_8429()) {
          var_1 = 1;
        }

        continue;
      }

      var_1 = 1;
    }

    scripts\mp\utility\stats::_id_7DAE("skippedKillcams", 1);
    scripts\mp\utility\player::_id_BD21("killcam::waitSkipKillcamButton() Killcam SKIPPED");
    self notify("abort_killcam");
  }
}

_id_5323() {
  self endon("disconnect");
  self endon("killcam_ended");

  for(;;) {
    if(self._id_0060 <= 0) {
      break;
    }

    waitframe();
  }

  scripts\mp\utility\player::_id_BD21("killcam::endKillcamIfNothingToShow() Killcam SKIPPED");
  self notify("abort_killcam");
}

_id_E2BC(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");
  self waittill("spawned");
  _id_8D61(0, undefined, var_0);
}

_id_52F3(var_0) {
  self endon("disconnect");
  self endon("killcam_ended");
  level waittill("game_ended");
  _id_8D61(1, 1, var_0);
}

_id_394D() {
  _id_394C();
  self setclientomnvar("ui_killcam_end_milliseconds", 0);
  self setclientomnvar("ui_killcam_killedby_id", -1);
  self setclientomnvar("ui_killcam_victim_id", -1);
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  self setclientomnvar("ui_killcam_killedby_vanity_index", -1);
  _id_394B();

  for(var_0 = 0; var_0 < 6; var_0++) {
    self setclientomnvar("ui_killcam_killedby_perk" + var_0, -1);
  }
}

_id_8D61(var_0, var_1, var_2) {
  _id_394D();
  self.killcam = undefined;
  _id_D4C0("unknown", -1, -1);
  _id_081A::_id_D6E2(var_1);
  scripts\mp\utility\player::_id_394E();
  self setclientomnvar("ui_killcam_prestream_vanity_index", 0);

  if(istrue(var_0) && !istrue(var_1)) {
    scripts\mp\utility\player::_id_FD26("dead");
  }

  self notify("killcam_ended");

  if(istrue(var_2)) {
    self setclientomnvar("post_game_state", 1);
  }
}

_id_3957() {
  self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
  self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
}

_id_394C() {
  self setclientomnvar("ui_killcam_killedby_item_type", -1);
  self setclientomnvar("ui_killcam_killedby_item_id", -1);
}

_id_D5CA(var_0, var_1) {
  self setclientomnvar("ui_killcam_killedby_item_type", var_0);
  self setclientomnvar("ui_killcam_killedby_item_id", var_1);
}

_id_D5D0(var_0, var_1) {
  if(isDefined(var_0._id_AE61)) {
    var_0 = var_0._id_AE61;
  }

  var_0 = scripts\mp\utility\weapon::_id_9ACB(var_0, var_1);
  var_2 = scripts\mp\utility\weapon::getweaponrootname(var_0.basename);
  var_3 = tablelookuprownum("mp/statstable.csv", 4, var_2);
  self setclientomnvar("ui_weapon_pickup", 0);

  if(!isDefined(var_3) || var_3 < 0) {
    _id_D5CA(-1, -1);
    return;
  }

  var_4 = _id_07ED::_id_6B20(var_0.basename, var_0._id_04CC);

  if(isDefined(var_4)) {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var_4._id_04CC);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var_4._id_BE98 - 1);
  } else {
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", -1);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", -1);
  }

  self setclientomnvar("ui_killcam_killedby_weapon_rarity_notify", gettime());
  _id_D5CA(0, var_3);

  if(var_2 != "s4_me_knife") {
    var_5 = getweaponattachments(var_0);

    if(!isDefined(var_5)) {
      var_5 = [];
    }

    var_6 = 0;

    for(var_7 = 0; var_7 < var_5.size; var_7++) {
      var_8 = var_5[var_7];
      var_9 = scripts\mp\utility\weapon::_id_1DA5(var_8);

      if(scripts\mp\utility\weapon::_id_1D9B(var_2, var_9)) {
        if(var_6 >= 8) {
          break;
        }

        var_10 = tablelookuprownum("dynamic_weapon_attachment_icon_table.csv", 0, var_8);

        if(isDefined(var_10) && var_10 >= 0) {
          self setclientomnvar("ui_killcam_killedby_attachment" + (var_6 + 1), var_10);
          var_6++;
        }
      }
    }

    for(var_7 = var_6; var_7 < 8; var_7++) {
      self setclientomnvar("ui_killcam_killedby_attachment" + (var_7 + 1), -1);
    }
  }
}

_id_D5CE(var_0) {
  var_1 = scripts\mp\supers::_id_6DA7(var_0);
  var_2 = scripts\mp\supers::_id_6DA1(var_1);
  _id_D5CA(2, var_2);
  _id_3957();
  _id_394B();
}

_id_D5CB(var_0) {
  var_1 = scripts\mp\utility\killstreak::_id_6AE3(level._id_8DEE[var_0.basename]);

  if(isDefined(self._id_CC22)) {
    var_1 = self._id_CC22._id_7C8C;
    var_2 = self._id_CC22._id_C040;
    self setclientomnvar("ui_killcam_killedby_item_type", 1);
    self setclientomnvar("ui_killcam_killedby_loot_variant_id", var_1);
    self setclientomnvar("ui_killcam_killedby_weapon_rarity", var_2 - 1);
  } else {
    _id_D5CA(1, var_1);
    _id_3957();
  }

  _id_394B();
}

_id_D5C7(var_0) {
  var_1 = scripts\mp\equipment::_id_6A14(var_0);
  var_2 = scripts\mp\equipment::_id_6A17(var_1);
  _id_D5CA(3, var_2._id_7C8C);
  _id_3957();
  _id_394B();
}

_id_D5C9(var_0) {
  if(!isDefined(var_0)) {
    var_1 = 0;
  } else {
    var_1 = _id_0790::_id_56FA(var_0);
  }

  _id_D5CA(4, var_1);
  _id_3957();
  _id_394B();
}

_id_D5CC(var_0) {
  _id_D5CA(5, var_0);
  _id_3957();
  _id_394B();
}

_id_394B() {
  for(var_0 = 0; var_0 < 8; var_0++) {
    self setclientomnvar("ui_killcam_killedby_attachment" + (var_0 + 1), -1);
  }
}

_id_894C(var_0) {
  var_1 = 0;

  if(isDefined(var_0) && isDefined(var_0._id_0481)) {
    switch (var_0._id_0481) {
      case "remote_tank":
      case "care_package":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

_id_8832(var_0) {
  var_1 = 0;

  if(isDefined(var_0.killcament) && isDefined(var_0.classname)) {
    switch (var_0.classname) {
      case "script_brushmodel":
      case "script_model":
      case "trigger_multiple":
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

_id_C634() {
  _id_09CA::_id_1035E(self);
}