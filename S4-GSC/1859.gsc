/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1859.gsc
*************************************************/

_id_7FFF() {
  _id_8000();
  _id_80B9();
  _id_D74F();
  level thread _id_7F72();
  level thread _id_80E2();
  level thread _id_0729::main();

  if(isDefined(level._id_1675)) {
    level thread[[level._id_1675]]();
  }

  _id_A017();
  _id_0771::_id_810D();

  if(getdvarint("#x3db9280a31b77f898", 1)) {
    level thread _id_80BC();
  }
}

_id_8000() {
  scripts\engine\utility::_id_5C11("pause_wave_progression");
  scripts\engine\utility::_id_5C11("trigger_modules_initialized");
  scripts\engine\utility::_id_5C11("spawner_scoring");
  scripts\engine\utility::_id_5C11("pause_always_on_spawning");
  scripts\engine\utility::_id_5C11("disable_vehicle_spawning");
  scripts\engine\utility::_id_5C11("disable_air_vehicle_spawning");
  scripts\engine\utility::_id_5C11("disable_ground_vehicle_spawning");
  scripts\engine\utility::_id_5C11("cover_spawners_initialized");
  scripts\engine\utility::_id_5C11("make_ai_aggro");
}

_id_80B9() {
  level._id_7D21 = ::_id_8826;
  level._id_E1CF = 0;
  level._id_0F30 = [];
  level._id_A01B = 0;
  level._id_E31C = ::_id_FBC7;
  level._id_53C9 = ::_id_53C7;
  level._id_A018 = [];
  level._id_A3F5 = [];
  level._id_1676 = [];
  level._id_41A6 = 0;
  level._id_50B2 = [];
  level._id_E767 = [];
  level._id_4182 = 0;
  level._id_4184 = 0;
  level._id_4183 = 0;
  level._id_4185 = 0;
  level._id_F367 = 0;
  level._id_C599 = [];
  level._id_DFE9 = 0;
  level._id_46B7 = 0;
  level._id_4815 = 0;
  level._id_416B = 0;
  level._id_9C37 = 0;
  level._id_9C15 = 0;
  level._id_904A = undefined;
  level._id_E2A4 = [];
  level._id_E2A1 = [];
  level._id_E2A0 = [];
  level._id_9C1A = 20;
  level._id_E2AC = [];
  level._id_E2AA = [];
  level._id_7634 = [];
  level._id_C679 = [];
  level._id_AE5C = [];
  level._id_0F2F = [];
  level._id_A46F = 0;
  level._id_E2D7 = [];
  level._id_C56E = 0;
  level._id_C56F = [];
  level._id_1463 = [];
  level._id_FF2D = [];
  level._id_71AD = [];
  level._id_8E9E = [];
  level._id_147A = [];
  level._id_3A02 = [];
  level._id_7226 = [];
  level._id_C56D = [];
  level._id_10CAC = [];
  level._id_E1E3 = [];
  level._id_13F3 = [];
  level._id_13F5 = [];
  level._id_13F4 = 0;
  level._id_30D0 = [];
  level._id_3DCB = [];
  level._id_3DCC = 0;
  level._id_E197 = [];
  level._id_3AD0 = [];
  level._id_DC15 = 0;
  level._id_7D0F = [];
  level._id_E2D2 = [];
  level._id_DD9A = 0;
  level._id_9050 = [];
  level _id_803B();
}

_id_D74F() {
  level._id_13F7 = [];
  level._id_BFD6 = ["ar", "smg", "shotgun"];
  _id_0762::_id_3EC3("actor_converted_vehicle_ai");
  var_0 = ["dx_cps_kama_callout_armored_spawning_10", "dx_cps_kama_callout_armored_spawning_20"];
  var_1 = ["dx_cps_kama_callout_drone_thrower_spawning_10", "dx_cps_kama_callout_drone_thrower_spawning_20"];
  var_2 = ["dx_cps_kama_callout_enemy_squad_spawning_10", "dx_cps_kama_callout_enemy_squad_spawning_20", "dx_cps_kama_callout_enemy_squad_spawning_30", "dx_cps_lass_callout_enemy_squad_spawning_10", "dx_cps_lass_callout_enemy_squad_spawning_20", "dx_cps_lass_callout_enemy_squad_spawning_30"];
  var_3 = ["dx_cps_kama_callout_juggernaut_spawning_10", "dx_cps_kama_callout_juggernaut_spawning_20", "dx_cps_lass_callout_juggernaut_spawning_10", "dx_cps_lass_callout_juggernaut_spawning_10"];
  var_4 = ["dx_cps_kama_callout_sniper_spawning_10", "dx_cps_kama_callout_sniper_spawning_20", "dx_cps_kama_callout_sniper_spawning_30", "dx_cps_lass_callout_sniper_spawning_10", "dx_cps_lass_callout_sniper_spawning_20", "dx_cps_lass_callout_sniper_spawning_30"];
  var_5 = ["dx_cps_kama_callout_suicide_bomber_spawning_10", "dx_cps_kama_callout_suicide_bomber_spawning_20", "dx_cps_lass_callout_suicide_bomber_spawning_10", "dx_cbc_aq1_reaction_hostile_burst", "dx_cbc_aq2_reaction_hostile_burst", "dx_cbc_aq3_reaction_hostile_burst", "dx_cbc_aq4_reaction_hostile_burst", "dx_cps_lass_callout_suicide_bomber_spawning_20"];
  _id_C1C7("suits", "actor_enemy_cp_rus_desert_ar_goliath_suits", undefined, undefined, undefined, undefined);
  _id_C1C7("goliath", "actor_enemy_cp_rus_desert_ar_goliath", undefined, ::_id_2341, undefined, var_0);
  _id_C1C7("goliath_bomber", "actor_enemy_cp_alq_desert_crowd", ::_id_F0BE, undefined, undefined, var_0);
  _id_C1C7("goliath_rpg", "actor_enemy_cp_rus_desert_rpg_goliath", undefined, undefined, undefined, var_0);
  _id_C1C7("smg", "actor_enemy_cp_alq_desert_smg", undefined, ::_id_2341, undefined, undefined);
  _id_C1C7("smg_heavy", "actor_enemy_cp_rus_desert_smg", undefined, ::_id_1B52, undefined, undefined);
  _id_C1C7("vehicle_ai", "actor_converted_vehicle_ai", undefined, ::_id_2341, undefined, undefined);
  _id_C1C7("ar", "actor_enemy_cp_alq_desert_ar", undefined, ::_id_2341, undefined, var_2);
  _id_C1C7("ar_heavy", "actor_enemy_cp_rus_desert_ar_ak", undefined, ::_id_1B52, undefined, var_2);
  _id_C1C7("ar_heavy_laser", "actor_enemy_cp_rus_desert_ar_ak_laser", undefined, ::_id_2341, undefined, var_2);
  _id_C1C7("hvt", "actor_enemy_cp_alq_desert_ar_hvt", undefined, undefined, undefined, undefined);
  _id_C1C7("shotgun", "actor_enemy_cp_alq_desert_shotgun", undefined, ::_id_2341, undefined, undefined);
  _id_C1C7("shotgun_heavy", "actor_enemy_cp_rus_desert_shotgun", undefined, ::_id_1B52, undefined, undefined);
  _id_C1C7("juggernaut", "actor_enemy_cp_rus_juggernaut", undefined, ::_id_D264, undefined, var_3);
  _id_C1C7("suicidebomber", "actor_enemy_cp_alq_desert_bomber", ::_id_EAD2, ::_id_3E1C, undefined, var_5);
  _id_C1C7("rpg", "actor_enemy_cp_alq_desert_rpg", undefined, undefined, undefined, undefined);
  _id_C1C7("riotshield", "actor_enemy_cp_rus_riotshield", undefined, undefined, undefined, var_0);
  _id_C1C7("sniper", "actor_enemy_cp_alq_desert_sniper", undefined, undefined, undefined, var_4);
  _id_C1C7("lmg", "actor_enemy_cp_alq_desert_lmg", undefined, undefined, undefined, undefined);
  _id_C1C7("lmg_heavy", "actor_enemy_cp_rus_desert_lmg", undefined, ::_id_1B52, undefined, undefined);
  _id_C1C7("informant", "actor_enemy_cp_alq_desert_sniper", undefined, ::_id_D7D0, undefined, undefined);
  _id_C1C7("ally_ar", "actor_ally_cp_usmc_ar", undefined, ::_id_2341, undefined, undefined);
  _id_C1C7("hadir", "actor_ally_cp_hero_hadir_urban", undefined, ::_id_2341, undefined, undefined);
  _id_C1C7("bombvest_hostage", "actor_ally_cp_bombvest_hostage", undefined, ::_id_2341, undefined, undefined);
}

_id_3E1C() {
  self._id_264D = 1;
  self._id_265B = 0;
  self._id_010D = "no_cover";
  self._id_EAF0 = 0;
}

_id_D264() {
  self._id_4ABB = 1;
  self._id_02A4 = getdvarint("#x366cf3cae9e8a657f", self._id_02A4);
  self._id_02A3 = getdvarint("#x37a5dcf360908158d", self._id_02A3);
  self._id_9DA7 = _func_0219(getdvarint("#x3ec6b87af62ee70ed", _func_0218(self._id_9DA7)));
  self._id_9D7F = getdvarint("#x3bfeda430ba886288", self._id_9D7F);
  self._id_0074 = getdvarint("#x3174b392ca0c11b95", self._id_0074);
  self._id_8C84 = getdvarint("#x32c2362482118196", self._id_8C84);
  self._id_02B2 = getdvarint("#x3d35a3d9d25454058", self._id_02B2);
  self.maxhealth = getdvarint("#x39ad41cdb4b0c26d5", self.maxhealth);
  self.health = self.maxhealth;
  self._id_7D49 = 1;
  self._id_C0E9 = [];
  self _meth_800D("stand");
  self setscriptablepartstate("loop_sounds", "music", 1);
  self _meth_84C4("mp_lochit_dmgtable");

  if(getdvarint("#x33fbb83f84bdb94fa", 1)) {
    scripts\engine\utility::_id_4A32();
  }

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] setplayermusicstate("cp_juggernaut_intro");
  }

  thread _id_ADE0();
  thread _id_8C0A();
}

_id_8C0A() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkto(self);
  wait 0.1;
  var_0 setModel("juggernaut_scriptable");
  scripts\engine\utility::waittill_any_3("juggernaut_end", "disconnect", "death");
  var_0 delete();
}

_id_ADE0() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = _id_6534();
    self waittill("damage", var_1, var_2);
    var_3 = level.players.size;

    if(isDefined(var_2) && var_2 scripts\cp\utility::_id_8708() && var_3 > 0) {
      self._id_C0E9[var_2.name] = 1;
      thread _id_C432(var_2);
      var_4 = getdvarint("#x3f4ee8d0563384665", 75);
      var_5 = self._id_C0E9.size;
      var_6 = int(max(1, var_0 * (var_3 / var_5) - (var_5 - 1) * var_4));
      self._id_02B2 = var_6;
    }
  }
}

_id_C432(var_0) {
  var_0 notify("remove_player_from_attacker_list");
  var_0 endon("remove_player_from_attacker_list");
  var_0 endon("disconnect");
  self endon("death");
  self._id_C0E9[var_0.name] = 1;
  wait(getdvarfloat("#x38d03f71714d7933c", 0.5));
  self._id_C0E9[var_0.name] = undefined;

  if(self._id_C0E9.size < 1) {
    self._id_02B2 = _id_6534();
  }
}

_id_6534() {
  return getdvarint("#x3d35a3d9d25454058", 200);
}

_id_F9B3() {
  _id_D1E3();
}

_id_F0BE() {
  var_0 = 1;
}

_id_C1C7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6._id_1210 = var_1;
  var_6._id_3A93 = var_2;
  var_6._id_E141 = var_3;
  var_6._id_7E9F = var_4;
  var_6._id_E243 = var_5;
  level._id_9050[var_0] = -99999;
  level._id_13F7[var_0] = var_6;
}

_id_6319() {
  var_0 = undefined;

  if(isDefined(var_0)) {
    self._id_BA3E[self._id_BA3E.size] = var_0;
  }
}

_id_631A() {
  var_0 = [];

  if(!isDefined(self._id_039B)) {
    return level._id_BFD6;
  } else {
    var_1 = strtok(self._id_039B, " ");

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(isDefined(level._id_13F7[var_3])) {
        var_0[var_0.size] = var_3;
      }
    }

    if(var_0.size > 0) {
      return var_0;
    } else {
      return level._id_BFD6;
    }
  }
}

_id_7F72() {
  level._id_E2A5["soldier"] = 0;
  level._id_E2A5["armored"] = 0;
  level._id_E2A5["armored_helmet"] = 0;
  level._id_E2A5["juggernaut"] = 0;
  level._id_15A4["soldier"] = 99;
  level._id_15A4["armored"] = 20;
  level._id_15A4["armored_helmet"] = 5;
  level._id_15A4["juggernaut"] = 1;
  level._id_765A = 0;
  level._id_5146 = 0;

  if(isDefined(level._id_53BC)) {
    _id_7F86();
    _id_FB6C(0);
  }
}

_id_7F86(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "cp/cp_lab_enemy_table.csv";
  }

  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = spawnStruct();
    var_3.index = int(var_2);
    var_3._id_5D1E = int(_func_0222(var_0, 0, var_2, 1));
    var_3._id_7218 = _func_0222(var_0, 0, var_2, 2);
    var_3._id_9C24 = int(_func_0222(var_0, 0, var_2, 3));
    var_3._id_9EA0 = int(_func_0222(var_0, 0, var_2, 4));
    var_3._id_9C23 = int(_func_0222(var_0, 0, var_2, 5));
    var_3._id_765A = int(_func_0222(var_0, 0, var_2, 6));
    var_3._id_15A7 = _func_0222(var_0, 0, var_2, 7);
    var_3._id_15A6 = _func_0222(var_0, 0, var_2, 8);
    var_3._id_9E9D = int(_func_0222(var_0, 0, var_2, 9));
    var_3._id_9C18 = int(_func_0222(var_0, 0, var_2, 10));
    var_3._id_5146 = int(_func_0222(var_0, 0, var_2, 11));
    var_3._id_15A3 = _func_0222(var_0, 0, var_2, 12);
    var_4 = strtok(var_3._id_15A7, ",");
    var_3._id_15A7 = var_4;
    var_4 = strtok(var_3._id_15A6, ",");
    var_3._id_15A6 = var_4;
    var_4 = strtok(var_3._id_15A3, ",");
    var_3._id_15A3 = var_4;
    level._id_5417[var_3._id_5D1E][var_3._id_7218] = var_3;
    var_1++;
  }
}

_id_FB6C(var_0) {
  level._id_E2A5["soldier"] = 0;
  level._id_E2A5["armored"] = 0;
  level._id_E2A5["armored_helmet"] = 0;
  level._id_E2A5["juggernaut"] = 0;
  level._id_15A4["soldier"] = 0;
  level._id_15A4["armored"] = 0;
  level._id_15A4["armored_helmet"] = 0;
  level._id_15A4["juggernaut"] = 0;
  var_1 = "group_0";
  var_2 = level._id_5417[var_0][var_1]._id_15A7;
  var_3 = 99;

  foreach(var_5 in var_2) {
    level._id_15A4[var_5] = var_3;
  }

  level._id_765A = level._id_5417[var_0][var_1]._id_765A;

  if(level._id_765A > 0) {
    var_2 = level._id_5417[var_0][var_1]._id_15A6;
    var_3 = level._id_5417[var_0][var_1]._id_9C23;

    foreach(var_5 in var_2) {
      level._id_15A4[var_5] = var_3;
    }
  }

  level._id_5146 = level._id_5417[var_0][var_1]._id_5146;

  if(level._id_5146 > 0) {
    var_2 = level._id_5417[var_0][var_1]._id_15A3;
    var_3 = level._id_5417[var_0][var_1]._id_9C18;

    foreach(var_5 in var_2) {
      level._id_15A4[var_5] = var_3;
    }
  }
}

_id_80E2() {
  level endon("game_ended");
  _id_C222("run_spawn_module", ::_id_F5F0, ::_id_C225);
  _id_C222("run_spawn_module_looping", ::_id_F5EF, ::_id_C224);
  _id_C222("run_spawn_module_infinite", ::_id_F5EF, ::_id_C223);
  _id_C222("run_spawn_module_timeout_loop", ::_id_F5EF, ::_id_C227);
  _id_C222("run_spawn_module_list", ::_id_F597, ::_id_C227);
  scripts\engine\utility::_id_5C24("strike_init_done");
  scripts\engine\utility::_id_5C24("introscreen_over");
  scripts\engine\utility::_id_5C24("infil_complete");
  scripts\engine\utility::_id_5C24("interactions_initialized");
  var_0 = getEntArray("module_update", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.target) && isDefined(var_2._id_CD62)) {
      [[_id_CA15(var_2._id_CD62)]](var_2);
      var_2 thread _id_C9F6(var_2);
    }
  }

  scripts\engine\utility::_id_5C1B("trigger_modules_initialized");
}

_id_CA15(var_0) {
  if(isDefined(level._id_F5FB[var_0])) {
    return level._id_F5FB[var_0];
  } else {
    return::_id_C225;
  }
}

_id_C227(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0._id_CCEA), int(var_0._id_CCEA), undefined);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_0._id_CCEC), int(var_0._id_CCEC), 0);
  var_4 = scripts\engine\utility::ter_op(isDefined(var_0._id_CCEB), int(var_0._id_CCEB), var_1.size);
  _id_C23C(var_0.target, var_3, var_4, var_2, [::_id_107AD, 0.25, 5, 0.8], undefined, var_0.target, undefined, var_0.target, 30);
  _id_D3B2(var_0.target, undefined, undefined, var_0._id_CDB3, undefined);
}

_id_10A5B(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isDefined(self._id_71F4)) {
    self._id_71F4 endon("weapons_free");
  }

  var_1 = _id_4633(var_1, 562500);
  var_2 = _id_4633(var_2, 45);
  var_4 = _id_4633(var_4, 2.5);
  var_5 = 0;

  for(;;) {
    self waittill("known_event", var_6);

    if(isDefined(var_6) && isPlayer(var_6)) {
      if(var_6 scripts\cp\utility::_id_8708() && !istrue(var_6.ignoreme)) {
        if(scripts\engine\trace::_id_30F5(var_6 getEye(), 0)) {
          wait(var_4);
          var_7 = distancesquared(self.origin, var_6.origin);

          if(isDefined(var_3)) {
            if(var_7 <= var_3) {
              self._id_71F4 scripts\engine\utility::_id_5474("weapons_free");
              level notify("weapons_checked_in");
            } else if(var_7 <= var_1) {
              if(!var_5) {
                var_5 = 1;
                _id_D1C8("alert");
              }
            }
          } else if(var_7 <= var_1) {
            self._id_71F4 scripts\engine\utility::_id_5474("weapons_free");
            level notify("weapons_checked_in");
          }
        }
      }
    }
  }
}

_id_D394(var_0, var_1, var_2, var_3) {
  var_4 = getarraykeys(level._id_0F2F);

  for(var_5 = 0; var_5 < level._id_0F2F.size; var_5++) {
    var_6 = level._id_0F2F[var_4[var_5]];

    if(_func_0107(var_6)) {
      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];

        if(var_8._id_7218 != var_0) {
          var_9 = _id_BD55(var_8, var_8._id_E1C5);

          for(var_10 = 0; var_10 < var_9.size; var_10++) {
            var_8._id_E1C5[var_10]._id_CCEA = 1;
            var_8._id_E1C5[var_10]._id_CE85 = undefined;
          }
        }
      }

      continue;
    }

    if(var_6._id_7218 != var_0) {
      for(var_10 = 0; var_10 < var_6._id_E1C5.size; var_10++) {
        var_6._id_E1C5[var_10]._id_CCEA = 1;
        var_6._id_E1C5[var_10]._id_CE85 = undefined;
      }
    }
  }
}

_id_1078D(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && isDefined(var_2)) {
    wait(randomfloatrange(var_1, var_2));
  } else if(isDefined(var_2)) {
    wait(var_2);
  } else if(isDefined(var_1)) {
    wait(var_1);
  } else {
    wait 0.25;
  }
}

_id_107AD(var_0, var_1, var_2, var_3) {
  var_4 = var_0._id_0F3C;
  var_5 = _id_BD55(var_0, var_0._id_9C33);

  if(var_4 / var_5 >= var_3) {
    return var_2;
  } else {
    return var_1;
  }
}

_id_C223(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  _id_C23C(var_0.target, 0, var_1.size, undefined, 0.25, undefined, var_0.target, undefined, undefined, undefined);
  _id_D3B2(var_0.target, undefined, undefined, var_0._id_CDB3, undefined);
}

_id_C224(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  _id_C23C(var_0.target, 0, var_1.size, var_1.size, 0.25, ::_id_106ED, var_0.target, undefined, var_0.target, undefined);
  _id_D3B2(var_0.target, undefined, undefined, var_0._id_CDB3, undefined);
}

_id_C225(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  _id_C23C(var_0.target, 0, var_1.size, var_1.size, 0.25, undefined, var_0.target, undefined, undefined, undefined);
  _id_D3B2(var_0.target, undefined, undefined, var_0._id_CDB3, undefined);
}

_id_C226(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  _id_C23C(var_0.target, 0, var_1.size, var_1.size, 0.25, undefined, var_0.target, undefined, undefined, undefined);
  _id_C1F7(var_0.target, _id_0762::_id_4A13);
  _id_C1F7(var_0.target, _id_0762::_id_49ED);
  _id_C1F7(var_0.target, ::_id_10A5B);
  _id_C1FE(var_0.target, _id_0762::_id_5204);
}

_id_C222(var_0, var_1, var_2) {
  if(!isDefined(level._id_F5F9)) {
    level._id_F5F9 = [];
  }

  if(!isDefined(level._id_F5FB)) {
    level._id_F5FB = [];
  }

  level._id_F5F9[var_0] = var_1;
  level._id_F5FB[var_0] = var_2;
}

_id_C9F6(var_0) {
  var_0 notify("run_script_func_when_triggered");
  var_0 endon("run_script_func_when_triggered");
  var_0 endon("death");
  level endon("game_ended");
  var_0 scripts\engine\utility::_id_F125("disable_trigger", scripts\engine\utility::_id_F5E0);

  if(!isDefined(level._id_F5F9)) {
    var_0 notify("disable_trigger");
    return;
  }

  if(!isDefined(level._id_F5F9[var_0._id_CD62])) {
    var_0 notify("disable_trigger");
    return;
  }

  var_1 = level._id_F5F9[var_0._id_CD62];

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      [[var_1]](var_0, var_2);
    }
  }
}

_id_8826(var_0, var_1) {
  if(!isagent(var_0)) {
    return 0;
  }

  if(istrue(var_1.ignoreme)) {
    return 1;
  }

  var_2 = var_0 _meth_8181();
  var_3 = var_1 _meth_8181();

  if(isDefined(level._id_7D2E) && isDefined(level._id_7D2E[var_3])) {
    if(scripts\engine\utility::array_contains(level._id_7D2E[var_3], var_2)) {
      return 1;
    } else {
      return 0;
    }
  } else
    return 0;
}

_id_4459(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 scripts\engine\utility::_id_5212();
  var_0 _meth_8019("normal");
  var_0 _id_D232(32);
  var_0 _id_0AED::_id_18C1();
  var_0 notify("alerted");
  var_0 notify("enter_combat");
  var_0._id_A546 = undefined;
  var_0._id_CF4A = 0;
  var_0._id_54CF = 1;

  if(isDefined(var_0._id_E342.target)) {
    var_1 = scripts\engine\utility::getstruct(var_0._id_E342.target, "targetname");
    var_0 _id_D22F(var_1.origin);
  }

  var_0 scripts\engine\utility::waittill_any_2("goal_reached", "goal");
  wait 2;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "MOD_SUICIDE");
}

_id_E1F5(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_4 = var_1;
  } else {
    var_4 = _id_359C(var_0);
  }

  var_0._id_C6A3 = undefined;

  if(!isDefined(var_4)) {
    var_0 _id_33CA(undefined, "No Spawner");
    return 0;
  }

  if(istrue(var_0._id_DD9D)) {
    return 1;
  }

  return _id_E1F6(var_0, var_4, 0, undefined, var_2, var_3);
}

_id_F2B5(var_0, var_1) {
  var_1 = _id_4633(var_1, 1);
  var_0._id_DD9D = var_1;
}

_id_E1F6(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_3 = undefined;

  if(isDefined(var_1._id_BA00)) {
    var_7 = var_1._id_BA00.origin;
    var_8 = var_1._id_BA00.angles;
  } else if(isDefined(var_1._id_10238)) {
    var_7 = var_1.origin;
    var_8 = var_1.angles;
  }

  if(isDefined(var_1._id_E3DE)) {
    if(!_func_0107(var_1._id_E3DE)) {
      var_1._id_E3DE = [var_1._id_E3DE];
    }

    var_3 = scripts\engine\utility::random(var_1._id_E3DE);
    var_6 = var_3;
  }

  var_9 = var_1 _id_E0AE(var_7, var_8, var_3, var_0);

  if(isDefined(var_9)) {
    if(isDefined(var_0._id_1D17)) {
      if(isDefined(level.players[var_0._id_1D17])) {
        level.players[var_0._id_1D17]._id_1D16++;
        var_9._id_1D19 = level.players[var_0._id_1D17];
      }
    }

    var_0 _id_33CA(undefined, "Found Agent");
    var_1 notify("spawn_success", var_1);
    level notify("spawned_group_soldier", var_9);
    level notify("ai_spawn_successful", var_9, var_1, var_1.origin, var_0);
    return _id_C9A8(var_0, var_9, var_1, var_4, var_6, var_2, var_5);
  } else {
    var_0 _id_33CA(undefined, "No Free Agent");
    var_1 notify("spawn_failed", var_1);
    var_1._id_13F1 = undefined;

    if(istrue(var_5)) {
      return undefined;
    } else {
      return 0;
    }
  }
}

_id_C9A8(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 endon("death");
  var_1 _id_D1C2(undefined, var_2, var_3, var_0);
  var_1 _id_A559(var_2);

  if(isDefined(var_0) && var_0 _id_0762::_id_A01A()) {
    var_1 thread _id_0762::_id_4A53(var_2);
  }

  _id_3D5C(var_2, var_1);
  var_1 _id_C9BF(undefined, var_2, var_3, var_0);
  var_2 _id_D1BD();
  var_1 _id_0763::_id_1170();
  var_2 _id_CA02(var_0);
  var_1 _id_C9A7();
  var_1 _id_C9AB();

  if(isDefined(var_2._id_E3DE) && isDefined(var_4)) {
    if(scripts\engine\utility::array_contains(var_2._id_E3DE, var_4)) {
      var_2._id_E3DE = scripts\engine\utility::array_remove(var_2._id_E3DE, var_4);

      if(var_2._id_E3DE.size < 1) {
        var_2._id_E3DE = undefined;
      }
    }
  }

  var_7 = undefined;

  if(isDefined(var_2._id_CC9F)) {
    if(!isDefined(var_0) || !var_0 scripts\engine\utility::_id_546E("weapons_free")) {
      var_8 = strtok(var_2._id_CC9F, ",");
      var_7 = scripts\engine\utility::random(var_8);
    }
  }

  if(isDefined(var_2._id_CD62)) {
    if(isDefined(level._id_E2D7[var_2._id_CD62]) && isDefined(var_2._id_129B)) {
      var_1[[level._id_E2D7[var_2._id_CD62]._id_CD62]](var_0, var_2, var_2._id_129B);
    }
  } else if(isDefined(var_7) && isDefined(level._id_E1EF[var_7])) {
    var_1 thread _id_5496();
    var_1 thread[[level._id_E1EF[var_7]._id_DDCD]]();
  } else if(var_1 _id_85AA()) {
    if(istrue(var_5)) {
      var_1 thread _id_1211(var_2._id_4E4C[0], var_1, var_2._id_4E4C, var_2._id_4E4C[0].origin, var_2._id_4E4C[0].angles, ::_id_4459, var_2);
    } else {
      var_1 thread _id_1211(var_2._id_4E4C[0], var_1, var_2._id_4E4C, var_2._id_4E4C[0].origin, var_2._id_4E4C[0].angles, undefined, var_2);
    }
  } else {
    scripts\engine\utility::delaythread(5, ::_id_FA44, var_2);

    if(var_1 _id_865D() || var_1 _id_8657()) {
      if(!isDefined(var_0) || !var_0 scripts\engine\utility::_id_546E("weapons_free")) {
        if(!isDefined(var_2._id_CD03)) {
          if(_id_86C8("civilian")) {
            var_1 _id_D1C8("panic");
          } else if(_id_86C8("juggernaut")) {
            if(var_1._id_E342 _id_E2EC(512)) {
              var_1 _id_0762::_id_4A13(var_0);
            }
          } else if(isnullweapon(var_1._id_034C))
            var_1 _id_D1C8("casual");
          else if(scripts\cp\utility::_id_8694() && scripts\cp\utility::_id_3D1D("sp_stealth")) {
            var_1 _id_D1C8("patrol");
          } else {
            var_1 _id_D1C8("casual_gun");
          }
        }

        var_1 thread _id_E624();
      } else
        var_1 thread _id_5494();
    } else if(isDefined(var_2.target))
      var_1 thread _id_5495();
    else {
      var_1 thread _id_5494();
    }
  }

  var_2._id_13F1 = undefined;

  if(istrue(var_6)) {
    return var_1;
  } else {
    return 1;
  }
}

_id_C9AB() {
  if(isDefined(self._id_13F1) && isDefined(level._id_13F7[self._id_13F1]) && isDefined(level._id_13F7[self._id_13F1]._id_E141)) {
    self thread[[level._id_13F7[self._id_13F1]._id_E141]]();
  }

  if(_id_DA92()) {
    thread _id_4C23(self._id_13F1);
  }
}

_id_DA92() {
  var_0 = istrue(self._id_0313) || istrue(self.ignoreme) || istrue(self._id_0229) || isDefined(level._id_7041) && !istrue(level._id_7041) || istrue(level._id_18F9) || istrue(level._id_E244) || istrue(level._id_8A9B) || istrue(level._id_EBA5);
  return !var_0;
}

_id_4C23(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(level._id_9050[var_0] + 60000 > gettime()) {
    return;
  }
  if(isDefined(level._id_13F7[var_0]) && isDefined(level._id_13F7[var_0]._id_E243)) {
    var_1 = level._id_13F7[var_0]._id_E243;
    level._id_E244 = 1;

    if(_func_0107(var_1)) {
      var_2 = scripts\engine\utility::random(var_1);
      level _id_076F::_id_F730(var_2, "allies");
    } else
      level _id_076F::_id_F730(var_1, "allies");

    level._id_9050[var_0] = gettime();
    level._id_E244 = 0;
  }
}

_id_D1C8(var_0) {
  if(_id_86C8("civilian")) {
    _id_06BD::_id_2402(var_0);
  } else if(!_id_86C8("juggernaut")) {
    scripts\common\utility::_id_47A7(var_0);
  }
}

_id_6F51() {
  if(!issubstr(self._id_1210, "_armor") && !_id_8615()) {}

  self._id_10DF0 = 1;
}

_id_6F52() {
  if(!issubstr(self._id_1210, "_helmet") && !_id_8615()) {}

  self._id_10DF1 = 1;
}

_id_D184(var_0, var_1, var_2) {
  if(isDefined(self._id_7611)) {
    self detach(self._id_7611);
  }

  if(isDefined(var_0)) {
    self setModel(var_0);
  }

  if(isDefined(var_1)) {
    self attach(var_1, "", 1);
    self._id_7611 = var_1;
  }
}

_id_10A35() {
  level endon("game_ended");
  self endon("death");
  var_0 = 0;
  var_1 = 0;
  wait 5;

  for(;;) {
    self waittill("bad_path", var_2);

    if(getdvarint("#x37e42531712b60624", 0)) {
      break;
    }

    if(!_id_7504()) {
      var_3 = gettime();

      if(var_3 - var_1 > 5000) {
        var_0 = 0;
        var_1 = var_3;
      } else {
        var_0++;
        var_1 = var_3;

        if(var_0 >= 10) {
          if(_id_AE99(gettime())) {
            _id_F030("Bad Path", var_2);
          }
        }

        wait 0.5;
      }
    }
  }
}

_id_10A2E() {
  level endon("game_ended");
  self endon("death");
  self endon("enter_combat");
  self notify("watch_for_ai_events");
  self endon("watch_for_ai_events");

  for(;;) {
    self waittill("ai_events", var_0);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1];

      if(_id_74F4(var_2.type)) {
        _id_C9A9(var_2.type, var_0);
      }

      switch (var_2.type) {
        case "projectile_impact":
        case "silenced_shot":
        case "gunshot_teammate":
        case "gunshot":
        case "bulletwhizby":
        case "explode":
          var_3 = 1;

          if(var_3) {
            thread _id_5494();
          }

          break;
        default:
          break;
      }
    }
  }
}

_id_C1C6(var_0, var_1, var_2) {
  if(isDefined(level._id_1676[var_0]) && _func_0107(level._id_1676[var_0])) {
    for(var_3 = 0; var_3 < level._id_1676[var_0].size; var_3++) {
      if(!isDefined(level._id_1676[var_0][var_3]._id_1315)) {
        level._id_1676[var_0][var_3]._id_1315 = [];
      }

      level._id_1676[var_0][var_3]._id_1315[var_1] = var_2;
    }
  } else {
    if(!isDefined(level._id_1676[var_0]._id_1315)) {
      level._id_1676[var_0]._id_1315 = [];
    }

    level._id_1676[var_0]._id_1315[var_1] = var_2;
  }
}

_id_74F4(var_0) {
  if(isDefined(self._id_71F4._id_1315) && isDefined(self._id_71F4._id_1315[var_0]) && _func_03AC(self._id_71F4._id_1315[var_0])) {
    return 1;
  } else {
    return 0;
  }
}

_id_C9A9(var_0, var_1) {
  self thread[[self._id_71F4._id_1315[var_0]]](var_0, var_1);
}

_id_65D0(var_0, var_1) {
  if(!isDefined(self._id_A427)) {
    self._id_A427 = 0;
  }

  thread _id_7DD6();
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];

    switch (var_4.type) {
      case "footstep_sprint":
        if(self._id_A427 >= randomintrange(15, 45)) {
          self._id_A427 = undefined;
          thread _id_5494();
          return;
        }

        var_2 = ["You're drawing attention to yourself."];
        break;
      case "player_ads_threat":
        var_2 = ["Watch where you point that thing.", "Rude.", "You're drawing attention to yourself.", "Calm down!"];

        if(self._id_A427 >= randomintrange(5, 15)) {
          self._id_A427 = undefined;
          thread _id_5494();
          return;
        }

        break;
    }

    if(isDefined(var_2) && isDefined(var_4._id_019B) && isPlayer(var_4._id_019B)) {
      var_4._id_019B thread _id_19B2();
      var_4._id_019B _id_6F0F(scripts\engine\utility::random(var_2));
    }
  }
}

_id_6F0F(var_0) {
  if(!isDefined(self._id_A470) || gettime() > self._id_A470) {
    self._id_A470 = gettime() + randomintrange(3, 5) * 1000;
    self iprintlnbold(var_0);
  }
}

_id_19B2() {
  self notify("apply_and_remove_attention_flag");
  self endon("apply_and_remove_attention_flag");
  self._id_74E9 = 1;
  wait 5;
  self._id_74E9 = undefined;
}

_id_7DD6() {
  self notify("increment_and_decay_nervousness");
  self endon("increment_and_decay_nervousness");
  self endon("death");
  self endon("enter_combat");
  self._id_A427++;
  wait 5;
  self._id_A427--;
}

_id_1E04(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(isDefined(var_3.type) && var_3.type == "footstep_sprint") {
      var_4 = ["You're drawing attention to yourself."];
    } else {
      var_4 = ["He's wearing a mask.", "He has no sleeves on his shirt.", "He's not like us.", "He's wearing boots.", "He's carries a lot of equipment on his waste.", "He may attack soon.", "There may be a group of them.", "There may be a group of them.", "There may be a group of them."];
    }

    if(isDefined(var_3._id_019B) && isPlayer(var_3._id_019B)) {
      var_3._id_019B _id_6F0F(scripts\engine\utility::random(var_4));
    }
  }
}

_id_3D5C(var_0, var_1) {
  var_1._id_E342 = var_0;
  var_1.target = var_0.target;
  var_1._id_CE5D = var_0._id_CE5D;
  var_1._id_CE6E = var_0._id_CE6E;
  var_1._id_CD04 = var_0._id_CD04;
  var_1._id_CD75 = var_0._id_CD75;
  var_1._id_03A0 = var_0._id_03A0;
  var_1._id_4DA6 = var_0._id_4DA6;
  var_1._id_CE1A = var_0._id_CE1A;
  var_1._id_5549 = var_0._id_5549;
  var_1._id_8651 = var_0._id_8651;
  var_1._id_4E14 = var_0._id_4E14;
  var_1._id_4D80 = var_0._id_4D80;
  var_1._id_CE10 = var_0._id_CE10;
  var_1._id_13F1 = var_0._id_13F1;

  if(isDefined(var_0._id_CD2B)) {
    var_1._id_CD2B = var_0._id_CD2B;
  }

  if(isDefined(var_0._id_CD76)) {
    var_1._id_CD76 = getent(var_0._id_CD76, "targetname");
  }
}

_id_FA44(var_0) {
  if(isDefined(var_0)) {
    var_0._id_FE3F = undefined;
  }
}

_id_359C(var_0, var_1, var_2) {
  if(isDefined(var_0.vehicle)) {
    return var_0.vehicle._id_E1C2 _id_5AD4(var_0);
  }

  if(istrue(var_1)) {
    var_0._id_C6A3 = 1;
  }

  var_3 = var_0 _id_BD55(var_0, var_0._id_E1C5);
  var_4 = var_0 _id_0760::_id_CBDB(var_3, var_1, undefined, var_2);
  var_0._id_BA09 = undefined;
  var_0 _id_0760::_id_BD04(var_4);

  if(!isDefined(var_4)) {
    return undefined;
  }

  if(0) {
    return var_4 _id_5AD4(var_0);
  } else if(isDefined(var_4._id_CE34)) {
    var_4._id_CE34 = int(var_4._id_CE34);

    if(!isDefined(var_4._id_011A)) {
      var_4._id_011A = 1;
    } else {
      var_4._id_011A = int(var_4._id_011A);
      var_4._id_011A++;
    }

    if(var_4._id_011A >= var_4._id_CE34) {
      var_4._id_FE3F = 1;
      var_4 thread _id_C5E8(var_4);
    }
  } else
    var_4._id_FE3F = 1;

  return var_4;
}

_id_5AD4(var_0) {
  if(!isDefined(self.vehicle)) {
    if(!_id_E23A(var_0)) {
      return undefined;
    }
  }

  if(isDefined(self.vehicle) && self.vehicle _id_06E7::_id_100D4()) {
    level notify("vehicle_spawned", var_0, self.vehicle);
    var_0 notify("vehicle_spawned", var_0, self.vehicle);

    if(isDefined(self._id_FFF0) && isDefined(self._id_FFF0._id_CEB3)) {
      return _id_65C7();
    } else {
      self._id_BA00 = self.vehicle;
      return self;
    }
  } else
    return undefined;
}

_id_65C7() {
  var_0 = scripts\engine\utility::getStructArray(self._id_FFF0._id_CEB3, "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] == self._id_FFF0) {
      continue;
    }
    if(!istrue(var_0[var_1]._id_4A88)) {
      self._id_BA00 = var_0[var_1];
      var_0[var_1]._id_4A88 = 1;
      return self;
    }
  }

  return undefined;
}

_id_E23A(var_0) {
  if(!isDefined(self._id_CD62)) {
    return 0;
  }

  if(_id_752C(var_0, self._id_CD62)) {
    return 0;
  }

  if([[level._id_12EA[self._id_CD62]._id_10270]](var_0, self, self._id_CD62)) {
    var_0.vehicle _id_1023F(var_0.vehicle);
    var_0.vehicle thread _id_10091(var_0.vehicle);
    return 1;
  } else
    return 0;
}

_id_1023F(var_0) {
  level._id_A018[var_0 getentitynumber()] = var_0;
}

_id_10091(var_0) {
  level endon("game_ended");
  var_1 = var_0 getentitynumber();
  var_0 waittill("death");

  if(isDefined(var_0._id_1031E)) {
    scripts\cp_mp\vehicles\vehicle_tracking::_id_102BB(var_0);
  }

  level._id_A018[var_1] = undefined;
}

_id_D268() {}

_id_6541() {}

_id_4A4F(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 > 0) {
    var_0 _id_4A51();

    if(isDefined(var_2)) {
      var_2._id_97CA = 1;
    }

    wait(var_1);

    if(isDefined(var_2)) {
      var_2._id_97CA = 0;
    }

    var_0 _id_5222();
  } else
    var_0 _id_4A51();
}

_id_E177(var_0) {
  if(!_func_02E1(var_0) && isDefined(var_0._id_03EA)) {
    var_1 = int(var_0._id_03EA);
    var_2 = 16;
    var_3 = 8;
    var_4 = 512;

    if(var_1 &var_2) {
      var_0 _id_4632("vehicle_spawner");
      var_0 _id_C3DA(8);
      var_0 _id_1057(16);

      if(!isDefined(var_0._id_CD62)) {
        var_0._id_CD62 = "random_ground_vehicle_spawn";
      }
    }

    if(var_1 &var_3) {
      var_0 _id_4632("vehicle_spawner");
      var_0 _id_1057(8);
      var_0 _id_C3DA(16);
      var_0._id_CD77 = 1;

      if(!isDefined(var_0._id_CD62)) {
        var_0._id_CD62 = "random_air_vehicle_spawn";
      }

      level._id_FF2D[level._id_FF2D.size] = var_0;
      level._id_1463[level._id_1463.size] = var_0;

      if(!(var_1 & 32)) {}
    }

    if((var_0 _id_E2CB(16) || var_0 _id_E2CB(8)) && var_1 &var_4) {
      var_0._id_FFED = 1;
      var_0._id_4DA2 = 1;
    }

    if(var_1 &var_3 || var_1 &var_2) {
      return 1;
      return;
    }

    return undefined;
    return;
  } else
    return undefined;
}

_id_1058(var_0) {
  if(isDefined(self._id_03EA)) {
    if(!_id_E2EC(var_0)) {
      self._id_03EA = self._id_03EA + var_0;
    }
  } else
    self._id_03EA = var_0;
}

_id_C3DB(var_0) {
  if(isDefined(self._id_03EA) && self._id_03EA &var_0) {
    self._id_03EA = self._id_03EA - var_0;
  }
}

_id_4632(var_0) {
  switch (var_0) {
    case "cluster_spawner":
      _id_462D();
      break;
    case "vehicle_spawner":
      _id_462E();
      break;
  }
}

_id_E2EC(var_0) {
  return isDefined(self._id_03EA) && self._id_03EA &var_0;
}

_id_E2CB(var_0) {
  return isDefined(self._id_E2CA) && self._id_E2CA &var_0;
}

_id_1057(var_0) {
  if(isDefined(self._id_E2CA)) {
    if(!_id_E2CB(var_0)) {
      self._id_E2CA = self._id_E2CA + var_0;
    }
  } else
    self._id_E2CA = var_0;
}

_id_C3DA(var_0) {
  if(isDefined(self._id_E2CA) && self._id_E2CA &var_0) {
    self._id_E2CA = self._id_E2CA - var_0;
  }
}

_id_C3A9() {
  if(isDefined(self._id_E342) && _func_02DE(self._id_E342)) {
    if(isDefined(self._id_E342._id_03EA) && self._id_E342._id_03EA & 1024) {
      self._id_E342._id_03EA = self._id_E342._id_03EA - 1024;
    }
  }
}

_id_462D() {
  if(isDefined(self._id_E2CA)) {
    if(!_id_E2CB(4)) {
      self._id_E2CA = self._id_E2CA + 4;
    }
  } else
    self._id_E2CA = 4;
}

_id_462E() {
  if(isDefined(self._id_E2CA)) {
    if(!_id_E2CB(2)) {
      self._id_E2CA = self._id_E2CA + 2;
    }
  } else
    self._id_E2CA = 2;
}

_id_C5E8(var_0) {}

_id_C7A1(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  } else {
    return 0;
  }
}

_id_C792(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  } else {
    return::_id_2540;
  }
}

_id_2540(var_0, var_1, var_2, var_3, var_4, var_5) {}

_id_C23C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_11 = strtok(var_0, "/");

  if(var_11.size > 1) {
    var_10._id_7218 = var_11[1];
  } else {
    var_10._id_7218 = var_0;
  }

  var_10._id_9EA5 = _id_C7A1(var_1);
  var_10._id_9C33 = _id_C7A1(var_2);
  var_10._id_F1E9 = _id_C7A1(var_4);
  var_10._id_BA37 = _id_C7A1(var_5);
  var_10._id_0F3C = 0;
  var_10._id_E109 = 0;
  var_10._id_12EB = [];
  var_10._id_A024 = [];
  var_10._id_A025 = 0;
  var_10._id_F364 = 0;
  var_10._id_3E30 = 0;
  var_10._id_44A0 = var_10 _id_3F45();

  if(isDefined(var_6)) {
    if(_func_03AC(var_6)) {
      var_10._id_E1C5 = var_6;
    } else if(_func_0107(var_6)) {
      foreach(var_13 in var_6) {
        var_10._id_E1C5 = scripts\engine\utility::array_combine(var_10._id_E1C5, scripts\engine\utility::getStructArray(var_13, "targetname"));
      }

      for(var_15 = 0; var_15 < var_10._id_E1C5.size; var_15++) {
        var_16 = var_10._id_E1C5[var_15];
        var_16 thread _id_E2CD();
      }

      var_10._id_E1C5 = [::_id_C780, var_6];
    } else {
      var_10._id_E1C5 = scripts\engine\utility::getStructArray(var_6, "targetname");

      foreach(var_16 in var_10._id_E1C5) {
        var_16 thread _id_E2CD();
      }
    }
  }

  var_10._id_F381 = _id_C7A1(var_3);
  var_10._id_E5E6 = _id_C792(var_7);
  var_10._id_A4A5 = var_8;
  var_10._id_F225 = var_9;
  var_10._id_41D4 = 0;
  var_10._id_41D3 = 0;
  var_10._id_7156 = ["frag_grenade_mp", "molotov_mp", "semtex_mp", "flash_grenade_mp", "concussion_grenade_mp", "smoke_grenade_mp", "gas_mp"];
  var_10._id_713F = [0.5, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];

  if(isDefined(level._id_1676[var_10._id_7218])) {
    if(_func_0107(level._id_1676[var_10._id_7218])) {
      var_19 = [];

      foreach(var_21 in level._id_1676[var_10._id_7218]) {
        var_19 = scripts\engine\utility::array_add(var_19, var_21);
      }

      var_19 = scripts\engine\utility::array_add(var_19, var_10);
      level._id_1676[var_10._id_7218] = var_19;
    } else {
      var_23 = level._id_1676[var_10._id_7218];
      level._id_1676[var_10._id_7218] = [var_10, var_23];
    }

    var_10._id_A029 = level._id_A01B;
    level._id_A01B++;
  } else {
    var_10._id_A029 = level._id_A01B;
    level._id_A01B++;
    level._id_1676[var_10._id_7218] = var_10;
  }

  var_24 = ":0/" + var_0 + ":" + level._id_1676.size;
  var_25 = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Start Module" + var_24 + "\" \"set scr_debug_spawning spawn_module_change &" + var_10._id_7218 + "\" \n";
  scripts\cp\utility::_id_10A9(var_25);
  var_25 = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Stop Module" + var_24 + "\" \"set scr_debug_spawning stop_module_change &" + var_10._id_7218 + "\" \n";
  scripts\cp\utility::_id_10A9(var_25);
}

_id_C780(var_0, var_1) {
  if(!_func_0107(var_1)) {
    var_1 = [var_1];
  } else {
    var_2 = [];

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      var_2[var_2.size] = var_1[var_3];
    }

    var_1 = var_2;
  }

  var_4 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = scripts\engine\utility::array_combine(var_4, scripts\engine\utility::getStructArray(var_1[var_3], "targetname"));
  }

  return var_4;
}

_id_4690() {
  if(getDvar("#x3fe835c6c65085e83", "") != "") {
    scripts\engine\utility::_id_5C24("strike_init_done");
    scripts\engine\utility::_id_5C24("introscreen_over");
    scripts\engine\utility::_id_5C24("infil_complete");
    scripts\engine\utility::_id_5C24("interactions_initialized");
    wait 2;
    var_0 = _id_C9FD(getDvar("#x3fe835c6c65085e83", ""));
  }
}

_id_468D() {
  if(getdvarint("#x348f7f626e222167b", 0)) {
    scripts\engine\utility::_id_5C24("strike_init_done");
    scripts\engine\utility::_id_5C24("introscreen_over");
    scripts\engine\utility::_id_5C24("infil_complete");
    scripts\engine\utility::_id_5C24("interactions_initialized");
    wait 2;
    var_0 = _id_C9FD("cover_node_spawning");
    _id_C9CE("cover_node_spawning", [::_id_AD42, undefined, undefined, 10000, undefined]);
    _id_C9CE("cover_node_spawning", [::_id_F2B4, 1]);
  }
}

_id_4691() {
  if(getdvarint("#x37875c0c26384a5a4", 0)) {
    scripts\engine\utility::_id_5C24("strike_init_done");
    scripts\engine\utility::_id_5C24("introscreen_over");
    scripts\engine\utility::_id_5C24("infil_complete");
    scripts\engine\utility::_id_5C24("interactions_initialized");
    wait 2;
    var_0 = _id_C9FD("wave_spawning");
  }
}

_id_80BC() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("strike_init_done");
  scripts\engine\utility::_id_5C24("introscreen_over");
  scripts\engine\utility::_id_5C24("infil_complete");
  scripts\engine\utility::_id_5C24("interactions_initialized");
  _id_C23C("no_group_ai", 0, ::_id_6589, undefined, 0.05, undefined, undefined, undefined, undefined, undefined);
  _id_C23C("pre_wave_spawning_dwn_twn", 0, 24, undefined, 0.1, undefined, "dwn_twn_patrol_structs", undefined, undefined);
  _id_D3B2("pre_wave_spawning_dwn_twn", 1250, 2000, 5000, 1);
  _id_C1F7("pre_wave_spawning_dwn_twn", ::_id_D360);
  _id_C1FE("pre_wave_spawning_dwn_twn", ::_id_BB5A);
  _id_C23C("pre_wave_spawning", 0, 24, undefined, 0.1, ::_id_FA30, ::_id_C770, ::_id_8075, "wave_spawning");
  _id_D3B2("pre_wave_spawning", 750, 2000, 5000, 1);
  _id_C1F7("pre_wave_spawning", ::_id_D360);
  _id_C23C("cover_node_spawning", [::_id_6347, 0], [::_id_6346, 24], undefined, ::_id_A028, undefined, ::_id_C770, ::_id_1074A);
  _id_C1F8("cover_node_spawning");
  _id_D3B2("cover_node_spawning", 750, 2000, 5000, 1);
  level thread _id_468D();
  level thread _id_4691();
  var_0 = scripts\engine\utility::getStructArray("cover_node_parents", "targetname");
  var_1 = _id_6336();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2]._id_CD8D = undefined;
  }

  if(var_0.size < 1) {
    var_3 = 0;
    var_4 = [];
    var_5 = 0;

    for(;;) {
      var_3++;
      var_6 = var_1[0];
      var_7 = [];
      var_4[var_4.size] = var_6;

      if(var_1.size > 1) {
        for(var_8 = 0; var_8 < var_1.size; var_8++) {
          var_9 = var_1[var_8];
          var_9._id_CD8D = undefined;

          if(var_6 == var_9) {
            continue;
          }
          if(isDefined(var_9.classname) && var_9.classname == "node_exposed") {
            continue;
          }
          var_7[var_7.size] = var_9;
        }

        var_1 = var_7;
        var_4 = var_7;
        break;
      } else
        break;
    }

    var_1 = undefined;
    var_0 = _id_E424(var_4);
    var_4 = undefined;
  }

  for(var_8 = 0; var_8 < var_0.size; var_8++) {
    var_0[var_8] _id_4632("cluster_spawner");
    var_0[var_8] thread _id_E2CD();
    var_0[var_8] _id_7F28();
    var_0[var_8]._id_3577 = undefined;
  }

  level._id_3DCA = var_0;
  scripts\engine\utility::_id_5C1B("cover_spawners_initialized");
}

_id_6336() {
  return _func_0075();
}

_id_1E03(var_0) {
  var_0++;

  if(var_0 % 2000 == 0) {
    waitframe();
  }

  return var_0;
}

_id_C770(var_0) {
  if(istrue(var_0._id_FDEC)) {
    return [];
  }

  if(isDefined(var_0._id_3DCB) && var_0._id_3DCB.size > 0) {
    var_1 = [];
    var_2 = getarraykeys(var_0._id_3DCB);

    for(var_3 = 0; var_3 < var_0._id_3DCB.size; var_3++) {
      var_1 = scripts\engine\utility::array_combine(var_1, var_0._id_3DCB[var_2[var_3]]);
    }

    if(var_1.size > 0) {
      return var_1;
    }
  } else if(isDefined(var_0._id_10CAC) && var_0._id_10CAC.size > 0) {
    var_1 = [];

    for(var_3 = 0; var_3 < var_0._id_10CAC.size; var_3++) {
      var_4 = scripts\engine\utility::getStructArray(var_0._id_10CAC[var_3], "targetname");
      var_1 = scripts\engine\utility::array_combine(var_1, var_4);
    }

    if(var_1.size > 0) {
      return var_1;
    }
  } else if(isDefined(var_0._id_C56D) && var_0._id_C56D.size > 0) {
    var_1 = [];

    for(var_3 = 0; var_3 < var_0._id_C56D.size; var_3++) {
      var_4 = scripts\engine\utility::getStructArray(var_0._id_C56D[var_3], "targetname");
      var_1 = scripts\engine\utility::array_combine(var_1, var_4);
    }

    if(var_1.size > 0) {
      if(isDefined(level._id_3DCA)) {
        return scripts\engine\utility::array_combine(level._id_3DCA, var_1);
      } else {
        return var_1;
      }
    } else if(isDefined(level._id_3DCA))
      return level._id_3DCA;
    else {
      return [];
    }
  }

  if(isDefined(level._id_3DCA)) {
    return level._id_3DCA;
  } else {
    return [];
  }
}

_id_FDCB(var_0) {
  scripts\engine\utility::_id_5C24("cover_spawners_initialized");

  if(isDefined(self._id_3DCA)) {
    var_1 = scripts\engine\utility::_id_6369(var_0, self._id_3DCA, undefined, 5, undefined, undefined);
    self._id_3DCB[self._id_3DCC] = var_1;
    var_2 = self._id_3DCC;
    self._id_3DCC++;
    return var_2;
  } else
    return undefined;
}

_id_C395(var_0) {
  if(isDefined(self._id_3DCB[var_0])) {
    self._id_3DCB[var_0] = undefined;
  }
}

_id_810C(var_0) {
  var_0._id_10CA5 = 1;
}

_id_8075(var_0) {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("cover_spawners_initialized");
  _id_0FDD("axis", ::_id_E779);
  _id_0FDD("axis", ::_id_D138);
  _id_0FDD("axis", ::_id_10A5B, undefined, 1000000, 45);
}

_id_FA30(var_0) {
  _id_C3E5("axis", ::_id_E779);
  _id_C3E5("axis", ::_id_D138);
  _id_C3E5("axis", ::_id_10A5B);
}

_id_D83F(var_0) {
  var_0._id_E0B6 = [];
}

_id_1074A(var_0) {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("cover_spawners_initialized");
}

_id_E424(var_0) {
  if(isDefined(var_0) && var_0.size < 1) {
    return [];
  }

  var_1 = scripts\cp\utility::_id_63BD(var_0);
  var_2 = spawnStruct();
  var_2.origin = var_1;
  var_2.angles = (0, 0, 0);
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];

  for(var_13 = 0; var_13 < var_0.size; var_13++) {
    var_14 = var_0[var_13];
    var_15 = var_2 _id_0762::_id_3E11(var_14.origin);
    var_16 = var_2 _id_0762::_id_3E12(var_14.origin);

    if(var_15 && var_16) {
      var_3[var_3.size] = var_14;
      continue;
    }

    if(!var_15 && !var_16) {
      var_6[var_6.size] = var_14;
      continue;
    }

    if(!var_15 && var_16) {
      var_5[var_5.size] = var_14;
      continue;
    }

    if(var_15 && !var_16) {
      var_4[var_4.size] = var_14;
    }
  }

  if(isDefined(var_3)) {
    if(var_3.size > 64) {
      var_9 = _id_E424(var_3);

      for(var_13 = 0; var_13 < var_9.size; var_13++) {
        var_17 = var_9[var_13];

        if(isDefined(var_17._id_3577) && var_17._id_3577.size > 0) {
          var_17.origin = scripts\cp\utility::_id_63BD(var_17._id_3577);
          var_17.angles = (0, 0, 0);
          var_7[var_7.size] = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17._id_3577 = var_3;

      if(isDefined(var_17._id_3577) && var_17._id_3577.size > 0) {
        var_17.origin = scripts\cp\utility::_id_63BD(var_17._id_3577);
        var_17.angles = (0, 0, 0);
        var_7[var_7.size] = var_17;
      }
    }
  }

  if(isDefined(var_4)) {
    if(var_4.size > 64) {
      var_10 = _id_E424(var_4);

      for(var_13 = 0; var_13 < var_10.size; var_13++) {
        var_17 = var_10[var_13];

        if(isDefined(var_17._id_3577) && var_17._id_3577.size > 0) {
          var_17.origin = scripts\cp\utility::_id_63BD(var_17._id_3577);
          var_17.angles = (0, 0, 0);
          var_7[var_7.size] = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17._id_3577 = var_4;

      if(isDefined(var_17._id_3577) && var_17._id_3577.size > 0) {
        var_17.origin = scripts\cp\utility::_id_63BD(var_17._id_3577);
        var_17.angles = (0, 0, 0);
        var_7[var_7.size] = var_17;
      }
    }
  }

  if(isDefined(var_5)) {
    if(var_5.size > 64) {
      var_11 = _id_E424(var_5);

      for(var_13 = 0; var_13 < var_11.size; var_13++) {
        var_17 = var_11[var_13];

        if(isDefined(var_17._id_3577) && var_17._id_3577.size > 0) {
          var_17.origin = scripts\cp\utility::_id_63BD(var_17._id_3577);
          var_17.angles = (0, 0, 0);
          var_7[var_7.size] = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17._id_3577 = var_5;

      if(isDefined(var_17._id_3577) && var_17._id_3577.size > 0) {
        var_17.origin = scripts\cp\utility::_id_63BD(var_17._id_3577);
        var_17.angles = (0, 0, 0);
        var_7[var_7.size] = var_17;
      }
    }
  }

  if(isDefined(var_6)) {
    if(var_6.size > 64) {
      var_12 = _id_E424(var_6);

      for(var_13 = 0; var_13 < var_12.size; var_13++) {
        var_17 = var_12[var_13];

        if(isDefined(var_17._id_3577) && var_17._id_3577.size > 0) {
          var_17.origin = scripts\cp\utility::_id_63BD(var_17._id_3577);
          var_17.angles = (0, 0, 0);
          var_7[var_7.size] = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17._id_3577 = var_6;

      if(isDefined(var_17._id_3577) && var_17._id_3577.size > 0) {
        var_17.origin = scripts\cp\utility::_id_63BD(var_17._id_3577);
        var_17.angles = (0, 0, 0);
        var_7[var_7.size] = var_17;
      }
    }
  }

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  return var_7;
}

_id_1D0E(var_0) {
  var_1 = scripts\cp\utility::_id_63BD(var_0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {}
}

_id_C1F8(var_0) {
  if(isDefined(level._id_1676[var_0])) {
    if(_func_0107(level._id_1676[var_0])) {
      for(var_1 = 0; var_1 < level._id_1676[var_0].size; var_1++) {
        level._id_1676[var_0][var_1]._id_865C = 1;
      }
    } else
      level._id_1676[var_0]._id_865C = 1;
  }
}

_id_C1F7(var_0, var_1) {
  if(isDefined(level._id_1676[var_0])) {
    if(_func_0107(level._id_1676[var_0])) {
      for(var_2 = 0; var_2 < level._id_1676[var_0].size; var_2++) {
        if(!isDefined(level._id_1676[var_0][var_2]._id_12E9)) {
          level._id_1676[var_0][var_2]._id_12E9 = [];
        }

        level._id_1676[var_0][var_2]._id_12E9[level._id_1676[var_0][var_2]._id_12E9.size] = var_1;
      }
    } else {
      if(!isDefined(level._id_1676[var_0]._id_12E9)) {
        level._id_1676[var_0]._id_12E9 = [];
      }

      level._id_1676[var_0]._id_12E9[level._id_1676[var_0]._id_12E9.size] = var_1;
    }
  }
}

_id_0FF3(var_0, var_1) {
  if(isDefined(level._id_0F2F[var_0])) {
    if(_func_0107(level._id_0F2F[var_0])) {
      for(var_2 = 0; var_2 < level._id_0F2F[var_0].size; var_2++) {
        if(!isDefined(level._id_0F2F[var_0][var_2]._id_12E9)) {
          level._id_0F2F[var_0][var_2]._id_12E9 = [];
        }

        level._id_0F2F[var_0][var_2]._id_12E9[level._id_0F2F[var_0][var_2]._id_12E9.size] = var_1;
      }
    } else {
      if(!isDefined(level._id_0F2F[var_0]._id_12E9)) {
        level._id_0F2F[var_0]._id_12E9 = [];
      }

      level._id_0F2F[var_0]._id_12E9[level._id_0F2F[var_0]._id_12E9.size] = var_1;
    }
  }
}

_id_19BC(var_0, var_1) {
  if(isDefined(level._id_0F2F[var_0])) {
    var_2 = level._id_0F2F[var_0];

    if(_func_0107(var_2)) {
      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        var_4 = var_2[var_3];

        for(var_5 = 0; var_5 < var_4._id_12EB.size; var_5++) {
          var_4._id_12EB[var_5] thread[[var_1]]();
        }
      }
    }
  }
}

_id_C1FE(var_0, var_1) {
  if(isDefined(level._id_1676[var_0])) {
    if(_func_0107(level._id_1676[var_0])) {
      for(var_2 = 0; var_2 < level._id_1676[var_0].size; var_2++) {
        if(!isDefined(level._id_1676[var_0][var_2]._id_5D50)) {
          level._id_1676[var_0][var_2]._id_5D50 = [];
        }

        level._id_1676[var_0][var_2]._id_5D50[level._id_1676[var_0][var_2]._id_5D50.size] = var_1;
      }
    } else {
      if(!isDefined(level._id_1676[var_0]._id_5D50)) {
        level._id_1676[var_0]._id_5D50 = [];
      }

      level._id_1676[var_0]._id_5D50[level._id_1676[var_0]._id_5D50.size] = var_1;
    }
  }
}

_id_C1F6(var_0, var_1) {
  if(isDefined(level._id_1676[var_0])) {
    if(_func_0107(level._id_1676[var_0])) {
      for(var_2 = 0; var_2 < level._id_1676[var_0].size; var_2++) {
        if(!isDefined(level._id_1676[var_0][var_2]._id_124C)) {
          level._id_1676[var_0][var_2]._id_124C = [];
        }

        level._id_1676[var_0][var_2]._id_124C[level._id_1676[var_0][var_2]._id_124C.size] = var_1;
      }
    } else {
      if(!isDefined(level._id_1676[var_0]._id_124C)) {
        level._id_1676[var_0]._id_124C = [];
      }

      level._id_1676[var_0]._id_124C[level._id_1676[var_0]._id_124C.size] = var_1;
    }
  }
}

_id_C1FD(var_0, var_1, var_2) {
  if(isDefined(level._id_1676[var_0])) {
    if(_func_0107(level._id_1676[var_0])) {
      for(var_3 = 0; var_3 < level._id_1676[var_0].size; var_3++) {
        if(!isDefined(level._id_1676[var_0][var_3]._id_6036)) {
          level._id_1676[var_0][var_3]._id_6036 = [];
        }

        level._id_1676[var_0][var_3]._id_6036[var_1] = var_2;
      }
    } else {
      if(!isDefined(level._id_1676[var_0]._id_6036)) {
        level._id_1676[var_0]._id_6036 = [];
      }

      level._id_1676[var_0]._id_6036[var_1] = var_2;
    }
  }
}

_id_A01E() {
  if(isDefined(self._id_6036)) {
    self endon("all_group_spawns_dead");
    var_0 = getarraykeys(self._id_6036);

    for(;;) {
      var_1 = level scripts\engine\utility::_id_10892(var_0);
      self thread[[self._id_6036[var_1]]]();
    }
  }
}

_id_D266(var_0, var_1, var_2) {
  var_0._id_8D3E = var_1;
  var_0._id_8F54 = var_2;
}

_id_F2B4(var_0, var_1) {}

_id_A019(var_0) {
  if(isDefined(level._id_1676[var_0])) {
    if(_func_0107(level._id_1676[var_0])) {
      for(var_1 = 0; var_1 < level._id_1676[var_0].size; var_1++) {
        level._id_1676[var_0][var_1]._id_1652 = 1;
      }
    } else
      level._id_1676[var_0]._id_1652 = 1;
  }
}

_id_5E58(var_0) {
  if(isDefined(level._id_1676[var_0])) {
    if(_func_0107(level._id_1676[var_0])) {
      for(var_1 = 0; var_1 < level._id_1676[var_0].size; var_1++) {
        level._id_1676[var_0][var_1]._id_3E30 = 1;
      }
    } else
      level._id_1676[var_0]._id_3E30 = 1;
  }
}

_id_AD42(var_0, var_1, var_2, var_3, var_4) {
  var_0 _id_3F72(var_1, var_2, var_3, var_4);
}

_id_D3B3(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = level.gametype;
    var_6 = strtok(var_4, " ");

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(var_6[var_7] == var_5) {
        break;
      }
    }

    return;
  }

  level._id_E1E2 = _id_3F72(var_0, var_1, var_2, var_3);
}

_id_D3B2(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5)) {
    var_6 = level.gametype;
    var_7 = strtok(var_5, " ");

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_7[var_8] == var_6) {
        break;
      }
    }

    return;
  }

  if(isDefined(level._id_1676[var_0])) {
    if(_func_0107(level._id_1676[var_0])) {
      for(var_8 = 0; var_8 < level._id_1676[var_0].size; var_8++) {
        level._id_1676[var_0][var_8]._id_E1E2 = _id_3F72(var_1, var_2, var_3, var_4);
      }
    } else
      level._id_1676[var_0]._id_E1E2 = _id_3F72(var_1, var_2, var_3, var_4);
  }
}

_id_3F72(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(isDefined(var_0)) {
    var_4._id_39BC = int(var_0);
  } else {
    var_4._id_39BC = 1024;
  }

  var_4._id_39BD = var_4._id_39BC * var_4._id_39BC;

  if(isDefined(var_1)) {
    var_4._id_5973 = int(var_1);
  } else {
    var_4._id_5973 = 2048;
  }

  var_4._id_5974 = var_4._id_5973 * var_4._id_5973;

  if(isDefined(var_2)) {
    var_4._id_F338 = int(var_2);
    var_4._id_F339 = var_4._id_F338 * var_4._id_F338;
  } else {
    var_4._id_F338 = 4096;
    var_4._id_F339 = 16777216;
  }

  if(isDefined(var_3)) {
    var_4._id_5975 = int(var_3);
  } else {
    var_4._id_5975 = 20;
  }

  return var_4;
}

_id_676D(var_0) {
  var_1 = [];

  if(_func_02DE(self)) {
    if(_func_0107(self)) {
      for(var_2 = 0; var_2 < self.size; var_2++) {
        var_1 = scripts\engine\utility::array_combine(var_1, self[var_2]._id_12EB);
      }
    } else
      var_1 = self._id_12EB;
  } else if(isDefined(level._id_0F2F[var_0])) {
    var_3 = level._id_0F2F[var_0];

    if(_func_0107(var_3)) {
      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_5 = var_3[var_4];
        var_1 = scripts\engine\utility::array_combine(var_1, var_5._id_12EB);
      }
    } else
      var_1 = scripts\engine\utility::array_combine(var_1, var_3._id_12EB);
  }

  return var_1;
}

_id_998B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1)) {
    self._id_ABCB = var_1;
  } else {
    self._id_ABCB = ::_id_5E24;
  }

  self.trigger = spawn("script_model", self.origin + (0, 0, 30));
  self.trigger linkto(self);
  self.trigger makeuseable();
  self.trigger _meth_83A2();
  self.trigger setcursorhint("HINT_BUTTON");
  self.trigger _meth_84D4(148);
  self.trigger sethintdisplayfov(90);
  self.trigger setuserange(72);
  self.trigger setusefov(45);
  self.trigger _meth_84D9("show");
  self.trigger sethintrequiresholding(1);
  self.trigger setuseholdduration("duration_short");

  if(isDefined(var_2)) {
    self.trigger sethintstring(var_2);
  }

  if(isDefined(var_4)) {
    _id_D232(var_4);
  }

  if(isDefined(var_5)) {
    self._id_01FE = var_5;
  }

  thread scripts\engine\utility::_id_472E(self.trigger);
  thread _id_12FD(var_3);
}

_id_12FD(var_0) {
  self endon("death");
  self endon("downed");
  self endon("exfil");
  self.trigger endon("death");

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::_id_8708()) {
      continue;
    }
    if(isDefined(self._id_ABCB)) {
      self thread[[self._id_ABCB]](var_1, var_0);
    }
  }
}

_id_5E24(var_0, var_1) {
  self notify("follow_triggering_player");
  self endon("follow_triggering_player");
  self endon("death");
  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand");

  if(isDefined(var_1)) {
    _id_3F24(var_1);
  }

  for(;;) {
    _id_D228(var_0);
    wait 1;
    var_0 = scripts\cp\utility::_id_63E3();
  }
}

_id_3F24(var_0) {
  self._id_75E9 = _func_0353(self);
  _func_0355(self._id_75E9, var_0);
  _func_035B(self._id_75E9, 1);
  _func_035A(self._id_75E9, 29000);
  _func_0359(self._id_75E9, 10);
  _func_035D(self._id_75E9, 10);
  thread _id_C3EF();
}

_id_C3EF() {
  if(!isDefined(self._id_75E9)) {
    return;
  }
  var_0 = self._id_75E9;
  var_1 = scripts\engine\utility::waittill_any_2("death", "remove_headicon");
  _func_0354(var_0);
}

_id_4A14(var_0, var_1, var_2, var_3) {
  var_0._id_4A14 = 1;
}

_id_65B3(var_0) {
  if(isDefined(level._id_1676) && isDefined(level._id_1676[var_0])) {
    return level._id_1676[var_0];
  } else {
    return undefined;
  }
}

_id_874F(var_0) {
  self endon("death");

  if(scripts\engine\utility::_id_5472("pause_group") && scripts\engine\utility::_id_546E("pause_group")) {
    scripts\engine\utility::_id_547B("pause_group");
    return 1;
  }

  if(istrue(level._id_E344)) {
    level waittill("end_spawnpoint_debug");
  }

  if(istrue(level._id_1674)) {
    wait 0.25;
    return 1;
  }

  return 0;
}

_id_15AB(var_0, var_1, var_2, var_3) {
  var_4 = _id_67DC();
  var_5 = _id_6589();
  var_6 = var_5 - var_4;
  var_7 = level._id_E2A0.size - level._id_46B7;
  var_8 = var_6 - var_7;

  if(isDefined(var_0)) {
    var_9 = var_0 _id_640C();

    if(!isDefined(var_9)) {
      return 0;
    }

    var_10 = var_9 - var_0 _id_62F8(1);
    var_11 = _id_66FD(var_3);
    var_6 = var_5 - var_4 + var_11;

    if(!istrue(var_0._id_8D3A)) {
      if(var_10 > 0 && var_8 > 0) {
        return 1;
        return;
      }

      return 0;
      return;
      return;
    }

    if(var_10 > 0 && var_8 > 0) {
      return 1;
      return;
    }

    if(!istrue(var_0._id_9EA7)) {
      var_0._id_9EA7 = 1;
      var_0 _id_7DBB(1, var_0._id_A029, var_0);
    }

    var_12 = 0;

    if(!istrue(var_0._id_4A14)) {
      var_13 = int(abs(var_8));
      var_12 = _id_8D3A(var_0, int(clamp(var_13, 1, var_6)), istrue(var_0._id_8D3A) || istrue(var_1));
    }

    if(var_12 > 0) {
      wait 0.1;
    }

    var_14 = level._id_E2A0.size - level._id_46B7;
    var_15 = var_6 - var_14;
    return var_15;
    return;
    return;
  } else if(var_8 < 1) {
    var_13 = int(abs(var_8));
    var_12 = _id_8D3A(undefined, int(clamp(var_13, 1, var_6)), istrue(var_1));

    if(var_12 > 0) {
      wait 0.1;
    }

    var_14 = level._id_E2A0.size - level._id_46B7;
    var_15 = var_6 - var_14;
    return var_15;
  } else
    return var_8;
}

_id_6589(var_0) {
  var_1 = getdvarint("#x3cbcd4ee052317649", 32);
  var_2 = 32;
  var_3 = getdvarint("#x35271a2bd2af99e14", var_1);

  if(var_2 > var_1) {
    return int(var_2);
  }

  return int(clamp(var_3, var_2, var_1));
}

_id_8547(var_0, var_1) {
  if(!isDefined(var_1._id_53AB)) {
    return 0;
  }

  if(var_0 == var_1._id_53AB) {
    return 1;
  }

  return 0;
}

_id_6452(var_0, var_1) {
  var_2 = var_0 _id_63EE();
  var_3 = var_1 _id_63EE();
  return var_2 > var_3;
}

_id_E027() {
  if(isDefined(self._id_71F4)) {
    if(self._id_71F4._id_7218 != "wave_spawning") {
      return 1;
    } else {
      return 0;
    }
  } else
    return 0;
}

_id_63EE() {
  var_0 = 1073741824;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    var_4 = distancesquared(self.origin, var_3.origin);

    if(var_4 < var_0) {
      var_1 = var_3;
      var_0 = var_4;
    }
  }

  return var_0;
}

_id_8CC1() {
  self endon("death");
  self._id_DD82 = 1;
  self._id_5E84 = 1;
  self._id_D00B = 1;

  for(;;) {
    var_0 = _id_AEA0(1);

    if(isDefined(var_0) && !var_0) {
      self._id_DD82 = undefined;
      self._id_5E84 = undefined;
      break;
    }

    wait 0.25;
  }
}

_id_8D3A(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = gettime();

  if(isDefined(var_0)) {
    level._id_3AF3 = var_0._id_7218;
  }

  if(istrue(var_2) && var_1 > var_4) {
    var_6 = _func_0070("axis");
    var_7 = scripts\engine\utility::_id_1BD6(var_6, ::_id_6452);
    var_7 = scripts\cp\utility::_id_1BD5(var_7, ::_id_E027);

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_7[var_8] _id_AEA0(1)) {
        var_4++;

        if(var_1 <= var_4) {
          return var_4;
        }
      }
    }

    var_7 = scripts\engine\utility::_id_1BCA(var_7);

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      var_9 = var_7[var_8];

      if(var_9 _id_7504()) {
        continue;
      }
      if(istrue(scripts\engine\utility::_id_CD61("ai_is_carrying_hvt", var_9))) {
        continue;
      }
      if(!isDefined(var_9) || !isalive(var_9) || var_9.health <= 0) {
        continue;
      }
      if(isDefined(var_9.team) && var_9.team == "allies") {
        continue;
      }
      if(isDefined(var_0) && scripts\engine\utility::is_equal(var_9._id_53AB, var_0._id_7218)) {
        var_9 thread _id_F030("Forced Kill-Off");
        continue;
      }

      var_9 _id_CD94();
      var_4++;

      if(var_1 <= var_4) {
        return var_4;
      }
    }
  }

  return var_4;
}

_id_AE99(var_0) {
  if(isDefined(self._id_8D8E) && var_0 <= self._id_8D8E) {
    return 0;
  } else {
    return 1;
  }
}

_id_6746() {
  if(isDefined(self._id_D00B)) {
    return self._id_D00B;
  } else if(isDefined(self._id_71F4)) {
    if(isDefined(self._id_71F4._id_8F54)) {
      return self._id_71F4._id_8F54;
    } else if(istrue(self._id_71F4._id_3E30)) {
      return 2;
    } else {
      return 6;
    }
  } else
    return 6;
}

_id_30BA(var_0, var_1) {
  if(istrue(self._id_9B33)) {
    return 0;
  }

  if(_id_74E8()) {
    return 0;
  }

  if(istrue(self._id_B85C)) {
    return 0;
  }

  if(_id_86A4()) {
    return 0;
  }

  if(isDefined(self._id_8D8E) && gettime() <= self._id_8D8E) {
    return 0;
  }

  if(_id_86C8("juggernaut")) {
    return 0;
  }

  if(isDefined(self._id_71F4)) {
    if(self._id_71F4 _id_62F8() <= _id_BD55(self._id_71F4, self._id_71F4._id_9EA5)) {
      if(!isDefined(var_0) || var_0 != self._id_71F4) {
        return 0;
      }
    }
  }

  if(var_1 && isDefined(self._id_53AB) && isDefined(var_0)) {
    if(self._id_53AB != var_0._id_7218) {
      return 0;
    }
  }

  if(isDefined(self._id_0192) && self _meth_8069()) {
    return 0;
  }
}

_id_4D82() {
  return istrue(self._id_4DA6);
}

_id_8555() {
  if(isDefined(self._id_53AB)) {
    if(istrue(self._id_71F4._id_865C)) {
      return 1;
    } else if(self._id_53AB == "always_on") {
      return 1;
    } else {
      return 0;
    }
  } else
    return 0;
}

_id_30BB() {
  return istrue(self._id_2423);
}

_id_8564() {
  return istrue(self._id_0084);
}

_id_86A8() {
  if(!isDefined(level._id_3AF3)) {
    return 1;
  } else {
    return isDefined(self._id_53AB) && self._id_53AB == level._id_3AF3;
  }
}

_id_8D3D() {
  var_0 = 0;

  if(!_id_86A4()) {
    var_0 = var_0 + 15;
  }

  if(_id_86A8()) {
    var_0 = var_0 + 15;
  }

  if(!_id_8564()) {
    var_0 = var_0 + 10;
  }

  if(!_id_8555()) {
    var_0 = var_0 + 25;
  }

  return var_0;
}

_id_6535() {
  if(isDefined(self._id_8D8E)) {
    return self._id_8D8E;
  } else {
    return 0;
  }
}

_id_10A31(var_0, var_1) {
  level endon("group_" + var_1 + "_ended");
  var_2 = 0;
  var_3 = [];

  foreach(var_5 in var_0) {
    thread _id_A68A(var_5, var_1, var_2);
    var_3[var_3.size] = var_1 + var_2 + "_completed";
    var_2++;
  }

  level scripts\engine\utility::_id_10879(var_3);
  level notify("module_group " + var_1 + " completed");
}

_id_A68A(var_0, var_1, var_2) {
  level endon("group_" + var_1 + "_ended");
  var_0 waittill("group_spawning_completed");
  level notify(var_1 + var_2 + "_completed");
}

_id_C9FD(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("level_ready_for_script");

  if(getdvarint("#x3e551f79e67cd0150", 0)) {
    if(var_0 != "always_on" && var_0 != "Max Agent Test") {
      return;
    }
  }

  if(getdvarint("#x34884f8d674216743", 0)) {
    if(isDefined(level._id_1676[var_0]) && !istrue(level._id_1676[var_0]._id_865C)) {
      return;
    }
  }

  level notify("new_spawn_module_requested_" + var_0);
  level._id_0F30[level._id_0F30.size] = var_0;

  if(!isDefined(level._id_0F2F[var_0])) {
    level._id_0F2F[var_0] = [];
  }

  if(!isDefined(level._id_E197[var_0])) {
    level._id_E197[var_0] = [];
  }

  var_5 = _id_3F46(var_0);

  if(isDefined(var_5)) {
    if(_func_0107(var_5)) {
      var_5 thread _id_10A31(var_5, var_0);

      foreach(var_2 in var_5) {
        level thread _id_0F98(var_2, var_0);
      }

      foreach(var_2 in var_5) {
        level thread _id_C9BD(var_2, 1);
      }
    } else {
      level thread _id_0F98(var_5, var_0);
      level thread _id_C9BD(var_5, 0);
    }

    return var_5;
  }
}

_id_0F98(var_0, var_1) {
  level endon("game_ended");
  level._id_0F2F[var_1][level._id_0F2F[var_1].size] = var_0;
  level._id_E197[var_1][level._id_E197[var_1].size] = var_0;
  var_0 waittill("death");

  if(var_0 _id_62F8(1) < 1) {
    _id_0762::_id_C3E9(var_0);

    if(isDefined(level._id_E197[var_0._id_7218]) && scripts\engine\utility::array_contains(level._id_E197[var_0._id_7218], var_0)) {
      level._id_E197[var_0._id_7218] = ::scripts\engine\utility::array_remove(level._id_E197[var_0._id_7218], var_0);

      if(isDefined(level._id_E197[var_0._id_7218]) && level._id_E197[var_0._id_7218].size < 1) {
        level._id_E197[var_0._id_7218] = undefined;
      }
    }
  }

  if(scripts\engine\utility::array_contains(level._id_0F2F[var_1], var_0)) {
    level._id_0F2F[var_1] = ::scripts\engine\utility::array_remove(level._id_0F2F[var_1], var_0);

    if(isDefined(level._id_0F2F[var_1]) && level._id_0F2F[var_1].size < 1) {
      level._id_0F2F[var_1] = undefined;
    }
  }
}

_id_3F46(var_0) {
  var_1 = _id_65B3(var_0);

  if(isDefined(var_1)) {
    if(_func_0107(var_1)) {
      var_2 = [];

      foreach(var_4 in var_1) {
        var_5 = _id_3D56(var_4);
        var_2 = scripts\engine\utility::array_add(var_2, var_5);
      }

      return var_2;
    } else {
      var_5 = _id_3D56(var_1);
      return var_5;
    }
  }
}

_id_3D56(var_0) {
  var_1 = spawnStruct();
  var_1._id_7218 = var_0._id_7218;
  var_1._id_9EA5 = var_0._id_9EA5;
  var_1._id_9C33 = var_0._id_9C33;
  var_1._id_F1E9 = var_0._id_F1E9;
  var_1._id_BA37 = var_0._id_BA37;
  var_1._id_0F3C = var_0._id_0F3C;
  var_1._id_E109 = var_0._id_E109;
  var_1._id_12EB = var_0._id_12EB;
  var_1._id_E1C5 = var_0._id_E1C5;
  var_1._id_F381 = var_0._id_F381;
  var_1._id_E5E6 = var_0._id_E5E6;
  var_1._id_A4A5 = var_0._id_A4A5;
  var_1._id_F225 = var_0._id_F225;
  var_1._id_41D4 = var_0._id_41D4;
  var_1._id_41D3 = var_0._id_41D3;
  var_1._id_A029 = var_0._id_A029;
  var_1._id_12E9 = var_0._id_12E9;
  var_1._id_124C = var_0._id_124C;
  var_1._id_5D50 = var_0._id_5D50;
  var_1._id_3E30 = var_0._id_3E30;
  var_1._id_1652 = var_0._id_1652;
  var_1._id_E774 = var_0._id_E774;
  var_1._id_E1E2 = var_0._id_E1E2;
  var_1._id_1315 = var_0._id_1315;
  var_1._id_865C = var_0._id_865C;
  var_1._id_A024 = var_0._id_A024;
  var_1._id_A025 = var_0._id_A025;
  var_1._id_4A54 = var_0._id_4A54;
  var_1._id_3ACF = var_0._id_3ACF;
  var_1._id_10119 = var_0._id_10119;
  var_1._id_443F = var_0._id_443F;
  var_1._id_F364 = var_0._id_F364;
  var_1._id_7156 = var_0._id_7156;
  var_1._id_713F = var_0._id_713F;
  var_1._id_4983 = var_0._id_4983;
  var_1._id_9300 = var_0;
  level._id_C56F[var_1._id_A029] = 0;
  var_1 scripts\engine\utility::_id_5473("pause_group");
  var_1 scripts\engine\utility::_id_5473("weapons_free");
  return var_1;
}

_id_1047(var_0, var_1) {
  if(isDefined(var_1)) {
    if(!isDefined(var_0._id_10006)) {
      var_0._id_10006 = [];
    }

    if(!isDefined(var_0._id_10006[var_1])) {
      var_0._id_10006[var_1] = 1;
    } else {
      var_0._id_10006[var_1]++;
    }
  }

  var_0._id_A025++;
  var_0._id_A024[var_0._id_A024.size] = self;
  thread scripts\engine\utility::_id_F126("death", ::_id_C3D0, var_0, var_1);
}

_id_752C(var_0, var_1) {
  if(!isDefined(var_0._id_10005)) {
    return 0;
  }

  if(isDefined(var_0._id_10005[var_1])) {
    if(!isDefined(var_0._id_10006)) {
      return 0;
    }

    if(!isDefined(var_0._id_10006[var_1])) {
      return 0;
    }

    if(_id_85E3(var_0._id_10006[var_1], var_0._id_10005[var_1])) {
      return 1;
    }
  }

  return 0;
}

_id_C3D0(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_0._id_10006)) {
      if(isDefined(var_0._id_10006[var_1])) {
        var_0._id_10006[var_1]--;

        if(var_0._id_10006[var_1] < 0) {
          var_0._id_10006[var_1] = 0;
        }
      }
    }
  }

  if(scripts\engine\utility::array_contains(var_0._id_A024, self)) {
    var_0._id_A024 = scripts\engine\utility::array_remove(var_0._id_A024, self);
  }

  var_0 notify("vehicle_removed_from_group");
}

_id_F229() {
  self endon("death");
  level notify("timeout_group_after_duration_" + self._id_A029);
  level endon("timeout_group_after_duration_" + self._id_A029);
  level endon("group_" + self._id_7218 + "_ended");
  var_0 = _id_BD55(self, self._id_F225);

  if(isDefined(var_0) && _func_02B7(var_0)) {
    wait(var_0);
  }

  level notify("spawnModuleTimedOut_" + self._id_A029);
}

_id_C9BD(var_0, var_1) {
  level notify("run_current_spawn_group" + var_0._id_A029);
  level endon("game_ended");
  var_0 endon("death");
  var_0 thread _id_10A49();
  var_0 thread _id_C9EF();
  var_0 thread _id_A01E();

  if(isDefined(var_0._id_F225)) {
    var_0 thread _id_F229();
  }

  var_0 _id_33CA(undefined, "Init Funcs");
  var_0 _id_0762::_id_C9E2();

  if(isDefined(var_0._id_E5E6)) {
    var_0 _id_33CA(undefined, "Start Func");
    _id_BD55(var_0, var_0._id_E5E6);
  }

  var_0 thread _id_CA1A();

  if(getDvar("#x33276b4a6ea6fdba7", "") != "" && getDvar("#x33276b4a6ea6fdba7", "") == var_0._id_7218) {
    level thread _id_CA74(var_0, var_1);
  } else {
    level thread _id_CA73(var_0, var_1);
  }

  var_0 waittill("death");
}

_id_CA1A() {
  if(isDefined(self._id_5D50)) {
    scripts\engine\utility::_id_5476("weapons_free");

    for(var_0 = 0; var_0 < self._id_5D50.size; var_0++) {
      thread _id_BD55(self, self._id_5D50[var_0]);
    }
  }
}

_id_C9C2() {
  if(isDefined(self._id_71F4._id_4983)) {
    for(var_0 = 0; var_0 < self._id_71F4._id_4983.size; var_0++) {
      thread _id_BD55(self._id_71F4, self._id_71F4._id_4983[var_0]);
    }
  }
}

_id_C9EF() {
  level endon("game_ended");
  self endon("death");
  var_0 = level scripts\engine\utility::_id_10897("spawn_module_" + self._id_A029 + "_completed", "spawnModuleTimedOut_" + self._id_A029);

  if(isDefined(self._id_BA37)) {
    var_1 = _id_BD55(self, self._id_BA37);

    if(isDefined(var_1) && _id_8955(var_1)) {
      level scripts\engine\utility::_id_108A7(var_1, "new_module_requested");
    }

    level notify("group_" + self._id_7218 + "_post_module_complete");
  }

  if(isDefined(self._id_A4A5)) {
    var_2 = _id_BD55(self, self._id_A4A5);

    if(isDefined(var_2) && _func_0121(var_2)) {
      level thread _id_C9FD(var_2, undefined, self);
    }
  }

  self notify("death");
}

_id_C426() {
  for(var_0 = 0; var_0 < level._id_E2A4.size; var_0++) {
    level._id_E2A4[var_0]._id_0313 = 0;
    level._id_E2A4[var_0]._id_CE12 = undefined;
    level._id_E2A4[var_0] thread _id_5496();
  }
}

_id_C427() {
  self._id_0313 = 0;
  self._id_CE12 = undefined;
}

_id_47A8(var_0) {
  for(var_1 = 0; var_1 < level._id_E2A4.size; var_1++) {
    level._id_E2A4[var_1] _id_D1C8(var_0);
  }
}

_id_D1E3(var_0) {
  self._id_4D80 = 1;
}

_id_38C8() {
  self._id_4D80 = undefined;
}

_id_10A49() {
  level endon("game_ended");
  self endon("death");
  var_0 = ["run_current_spawn_group" + self._id_A029, "end_spawn_module_" + self._id_A029, "end_spawn_module_" + self._id_7218];
  level scripts\engine\utility::_id_10892(var_0);
  self notify("death");
}

_id_8955(var_0) {
  if(isDefined(var_0) && _func_02B7(var_0) && var_0 > 0) {
    return 1;
  } else {
    return 0;
  }
}

_id_CA73(var_0, var_1) {
  level endon("game_ended");
  level notify("runSpawnModule_" + var_0._id_A029);
  level endon("runSpawnModule_" + var_0._id_A029);
  var_0 endon("death");
  var_0 thread _id_C616();
  waittillframeend;

  for(;;) {
    if(var_0 _id_874F()) {
      var_0 _id_33CA(undefined, "Module Paused");
      continue;
    }

    var_2 = _id_BD55(var_0, var_0._id_F381);
    var_0._id_443F._id_F381 = var_2;

    if(var_2 > 0 && var_0 _id_62F8(1) + var_0._id_41D4 >= var_2) {
      level notify("spawn_module_" + var_0._id_A029 + "_completed");
      return;
    }

    var_2 = _id_BD55(var_0, var_0._id_F381);
    var_0._id_443F._id_F381 = var_2;
    var_3 = var_0 _id_640C();
    var_4 = var_0 _id_640C(0);
    var_5 = _id_15AB(var_0);

    if(var_5) {
      if(isDefined(var_3) && isDefined(var_4) && var_0 _id_62F8(1) < var_3 && var_0 _id_62F8() < var_4) {
        var_0 _id_E1F5(var_0);
      }

      var_6 = _id_BD55(var_0, var_0._id_F1E9);

      if(_id_8955(var_6)) {
        wait(var_6);
      } else {
        waitframe();
      }

      continue;
    }

    wait 0.1;
  }
}

_id_CA74(var_0, var_1) {
  level endon("game_ended");
  level notify("runSpawnModule_" + var_0._id_A029);
  level endon("runSpawnModule_" + var_0._id_A029);
  var_0 endon("death");
  var_0 thread _id_C616();

  for(;;) {
    if(var_0 _id_874F()) {
      var_0 _id_33CA(undefined, "Module Paused");
      continue;
    }

    var_2 = _id_BD55(var_0, var_0._id_F381);
    var_0._id_443F._id_F381 = var_2;

    if(var_2 > 0 && var_0 _id_62F8(1) + var_0._id_41D4 >= var_2) {
      level notify("spawn_module_" + var_0._id_A029 + "_completed");
      return;
    }

    var_2 = _id_BD55(var_0, var_0._id_F381);
    var_0._id_443F._id_F381 = var_2;
    var_3 = var_0 _id_640C();
    var_4 = var_0 _id_640C(0);
    var_5 = _id_15AB(var_0);

    if(var_5) {
      if(isDefined(var_3) && isDefined(var_4) && var_0 _id_62F8(1) < var_3 && var_0 _id_62F8() < var_4) {
        var_0 _id_E1F5(var_0);
      }

      var_6 = _id_BD55(var_0, var_0._id_F1E9);

      if(_id_8955(var_6)) {
        wait(var_6);
      }

      continue;
    }

    wait 0.1;
  }
}

_id_640C(var_0) {
  var_1 = _id_BD55(self, self._id_9EA5);
  self._id_443F._id_9EA5 = var_1;
  self._id_8D3A = undefined;
  var_0 = _id_4633(var_0, 1);

  if(isDefined(var_1) && _id_62F8(var_0) < var_1) {
    self._id_8D3A = 1;
    level._id_C56F[self._id_A029] = var_1;
    return var_1;
  }

  var_2 = _id_BD55(self, self._id_9C33);
  self._id_443F._id_9C33 = var_2;

  if(isDefined(var_2) && _id_62F8(var_0) < var_2) {
    level._id_C56F[self._id_A029] = var_2;
    return var_2;
  }

  return undefined;
}

_id_D0A4(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = self;
  }

  if(isDefined(var_1)) {
    if(_func_0107(self._id_71F4)) {
      var_6 = [];

      for(var_7 = 0; var_7 < self._id_71F4.size; var_7++) {
        var_6 = scripts\engine\utility::array_add(var_6, self._id_71F4[var_7]._id_12EB);
      }

      var_8 = scripts\engine\utility::_id_6369(self.origin, var_6, undefined, undefined, var_1, 0);
    } else
      var_8 = scripts\engine\utility::_id_6369(self.origin, self._id_71F4._id_12EB, undefined, undefined, var_1, 0);
  } else if(_func_0107(self._id_71F4)) {
    var_6 = [];

    for(var_7 = 0; var_7 < self._id_71F4.size; var_7++) {
      var_6 = scripts\engine\utility::array_add(var_6, self._id_71F4[var_7]._id_12EB);
    }

    var_8 = var_6;
  } else
    var_8 = self._id_71F4._id_12EB;

  for(var_7 = 0; var_7 < var_8.size; var_7++) {
    if(var_8[var_7] == self) {
      if(istrue(var_4)) {
        var_8[var_7] _meth_8523(var_0, var_5, self.origin);
        continue;
      } else
        continue;
    }

    if(istrue(var_2) && !scripts\engine\utility::_id_10E76(self.origin, self.angles, var_8[var_7].origin, cos(65))) {
      continue;
    }
    if(istrue(var_3) && !self _meth_8009(self.origin, var_8[var_7].origin, 15, 60)) {
      continue;
    }
    var_8[var_7] _meth_8523(var_0, var_5, self.origin);
  }
}

_id_A67D(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4)) {
    var_5 = _func_0070("axis");
  } else {
    var_5 = self._id_71F4._id_12EB;
  }

  if(isDefined(var_1)) {
    var_5 = scripts\engine\utility::_id_6369(self.origin, var_5, undefined, undefined, var_1, 0);
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(var_5[var_6] == self) {
      continue;
    }
    if(istrue(var_2) && !scripts\engine\utility::_id_10E76(var_5[var_6].origin, var_5[var_6].angles, self.origin, cos(65))) {
      continue;
    }
    if(istrue(var_3) && !var_5[var_6] _meth_8067(self)) {
      continue;
    }
    var_5[var_6] notify(var_0);
  }
}

_id_66FC(var_0) {
  var_1 = 0;

  foreach(var_4, var_3 in level._id_C56F) {
    if(isDefined(var_0) && var_0 == var_4) {
      continue;
    }
    var_1 = var_1 + var_3;
  }

  return var_1;
}

_id_C9CE(var_0, var_1) {
  foreach(var_3 in level._id_0F2F) {
    if(_func_0107(var_3)) {
      foreach(var_5 in var_3) {
        if(var_5._id_7218 == var_0) {
          var_5 _id_BD55(var_5, var_1);
        }
      }

      continue;
    }

    if(var_3._id_7218 == var_0) {
      var_3 _id_BD55(var_3, var_1);
    }
  }
}

_id_AF52(var_0) {
  foreach(var_2 in level._id_0F2F) {
    if(_func_0107(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4._id_7218 != var_0) {
          if(getdvarint("#x3d541992519421965", 0)) {
            _func_0012(var_4._id_7218 + " ^1Paused");
          }

          var_4 scripts\engine\utility::_id_5474("pause_group");
        }
      }

      continue;
    }

    if(var_2._id_7218 != var_0) {
      if(getdvarint("#x3d541992519421965", 0)) {
        _func_0012(var_2._id_7218 + " ^1Paused");
      }

      var_2 scripts\engine\utility::_id_5474("pause_group");
    }
  }
}

_id_F99A(var_0) {
  foreach(var_2 in level._id_0F2F) {
    if(_func_0107(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4._id_7218 != var_0) {
          if(getdvarint("#x3d541992519421965", 0)) {
            _func_0012(var_4._id_7218 + " ^3Unpaused");
          }

          var_4 scripts\engine\utility::_id_5470("pause_group");
        }
      }

      continue;
    }

    if(var_2._id_7218 != var_0) {
      if(getdvarint("#x3d541992519421965", 0)) {
        _func_0012(var_2._id_7218 + " ^3Unpaused");
      }

      var_2 scripts\engine\utility::_id_5470("pause_group");
    }
  }
}

_id_AF5C(var_0, var_1) {
  foreach(var_3 in level._id_0F2F) {
    if(_func_0107(var_3)) {
      foreach(var_5 in var_3) {
        if(var_5._id_7218 == var_0 && var_5._id_A029 == var_1) {
          if(getdvarint("#x3d541992519421965", 0)) {
            _func_0012(var_5._id_7218 + " ^1Paused");
          }

          var_5 scripts\engine\utility::_id_5474("pause_group");
        }
      }

      continue;
    }

    if(var_3._id_7218 == var_0 && var_3._id_A029 == var_1) {
      if(getdvarint("#x3d541992519421965", 0)) {
        _func_0012(var_3._id_7218 + " ^1Paused");
      }

      var_3 scripts\engine\utility::_id_5474("pause_group");
    }
  }
}

_id_F99C(var_0, var_1) {
  foreach(var_3 in level._id_0F2F) {
    if(_func_0107(var_3)) {
      foreach(var_5 in var_3) {
        if(var_5._id_7218 == var_0 && var_5._id_A029 == var_1) {
          if(getdvarint("#x3d541992519421965", 0)) {
            _func_0012(var_5._id_7218 + " ^3Unpaused");
          }

          var_5 scripts\engine\utility::_id_5470("pause_group");
        }
      }

      continue;
    }

    if(var_3._id_7218 == var_0 && var_3._id_A029 == var_1) {
      if(getdvarint("#x3d541992519421965", 0)) {
        _func_0012(var_3._id_7218 + " ^3Unpaused");
      }

      var_3 scripts\engine\utility::_id_5470("pause_group");
    }
  }
}

_id_D44C() {
  foreach(var_1 in level._id_E197) {
    if(_func_0107(var_1)) {
      foreach(var_3 in var_1) {
        var_3 scripts\engine\utility::_id_5474("weapons_free");
      }

      continue;
    }

    var_1 scripts\engine\utility::_id_5474("weapons_free");
  }
}

_id_AF5B(var_0) {
  foreach(var_2 in level._id_0F2F) {
    if(_func_0107(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4._id_7218 == var_0) {
          if(getdvarint("#x3d541992519421965", 0)) {
            _func_0012(var_4._id_7218 + " ^1Paused");
          }

          var_4 _id_0762::_id_C9E3();
          var_4 scripts\engine\utility::_id_5474("pause_group");
        }
      }

      continue;
    }

    if(var_2._id_7218 == var_0) {
      if(getdvarint("#x3d541992519421965", 0)) {
        _func_0012(var_2._id_7218 + " ^1Paused");
      }

      var_2 _id_0762::_id_C9E3();
      var_2 scripts\engine\utility::_id_5474("pause_group");
    }
  }
}

_id_F99B(var_0) {
  foreach(var_2 in level._id_0F2F) {
    if(_func_0107(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4._id_7218 == var_0) {
          if(getdvarint("#x3d541992519421965", 0)) {
            _func_0012(var_2._id_7218 + " ^3Unpaused");
          }

          var_4 _id_0762::_id_C9E4();
          var_4 scripts\engine\utility::_id_5470("pause_group");
        }
      }

      continue;
    }

    if(var_2._id_7218 == var_0) {
      if(getdvarint("#x3d541992519421965", 0)) {
        _func_0012(var_2._id_7218 + " ^3Unpaused");
      }

      var_2 _id_0762::_id_C9E4();
      var_2 scripts\engine\utility::_id_5470("pause_group");
    }
  }
}

_id_E879() {
  var_0 = getarraykeys(level._id_0F2F);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    _id_E8BF(var_0[var_1]);
  }
}

_id_E8C0(var_0) {
  level notify("end_spawn_module_" + var_0);
}

_id_E8BF(var_0, var_1) {
  if(isDefined(level._id_0F2F[var_0])) {
    var_2 = level._id_0F2F[var_0];

    if(_func_0107(var_2)) {
      foreach(var_4 in var_2) {
        if(istrue(var_1)) {
          level notify("spawn_module_" + var_4._id_A029 + "_completed");
          continue;
        }

        var_4 notify("death");
      }
    } else if(istrue(var_1))
      level notify("spawn_module_" + var_2._id_A029 + "_completed");
    else {
      var_2 notify("death");
    }
  }
}

_id_81C8() {
  _id_4632("vehicle_spawner");
  _id_C3DA(8);
  _id_1057(16);
  self._id_CD62 = "techo_phys";
  self._id_FFED = 1;
  scripts\cp\utility::_id_1172("targetname", "ground_veh_exit", self);
  scripts\cp\utility::_id_1172("script_noteworthy", "deleteme", self);
}

_id_BD55(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("var_param_race_timeout");

  if(!isDefined(var_1)) {
    return "empty";
  }

  var_4 = var_1;

  if(_func_0121(var_1)) {
    return var_1;
  } else if(_id_8955(var_1)) {
    return var_1;
  } else if(_func_0107(var_1)) {
    if(_func_0107(var_1[0])) {
      for(var_5 = 0; var_5 < var_1.size; var_5++) {
        var_4 = _id_BD55(var_0, var_1[var_5], var_2);
      }
    } else if(_func_03AC(var_1[0])) {
      var_6 = var_1[0];
      var_7 = [];
      var_8 = _id_BD54(var_0, var_1);
      var_4 = var_0 _id_C9E1(var_6, var_8, var_3);
    } else
      var_4 = var_1;
  } else if(_func_03AC(var_1)) {
    if(istrue(var_2)) {
      return var_1;
    } else {
      var_4 = [[var_1]](var_0);
    }
  }

  return var_4;
}

_id_BD54(var_0, var_1) {
  var_2 = [];

  if(var_1.size < 2) {
    return var_2;
  } else {
    var_3 = spawnStruct();
    var_3._id_FFBF = [];
    var_4 = min(var_1.size, 9);

    for(var_5 = 1; var_5 < var_4; var_5++) {
      var_6 = var_1[var_5];
      var_3 thread _id_D0AF("var_param_race_timeout");
      var_3._id_FFBF[var_5 - 1] = var_3 _id_BD55(var_0, var_6, 1);
    }
  }

  return var_3;
}

_id_D0AF(var_0) {
  self endon("death");
  waittillframeend;
  self notify(var_0);
}

_id_C9E1(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = self;
  }

  if(!isDefined(var_1._id_FFBF)) {
    return var_3[[var_0]](self);
  } else if(var_1._id_FFBF.size == 1) {
    return var_3[[var_0]](self, _id_C78B(var_1._id_FFBF[0]));
  } else if(var_1._id_FFBF.size == 2) {
    return var_3[[var_0]](self, _id_C78B(var_1._id_FFBF[0]), _id_C78B(var_1._id_FFBF[1]));
  } else if(var_1._id_FFBF.size == 3) {
    return var_3[[var_0]](self, _id_C78B(var_1._id_FFBF[0]), _id_C78B(var_1._id_FFBF[1]), _id_C78B(var_1._id_FFBF[2]));
  } else if(var_1._id_FFBF.size == 4) {
    return var_3[[var_0]](self, _id_C78B(var_1._id_FFBF[0]), _id_C78B(var_1._id_FFBF[1]), _id_C78B(var_1._id_FFBF[2]), _id_C78B(var_1._id_FFBF[3]));
  } else if(var_1._id_FFBF.size == 5) {
    return var_3[[var_0]](self, _id_C78B(var_1._id_FFBF[0]), _id_C78B(var_1._id_FFBF[1]), _id_C78B(var_1._id_FFBF[2]), _id_C78B(var_1._id_FFBF[3]), _id_C78B(var_1._id_FFBF[4]));
  } else if(var_1._id_FFBF.size == 6) {
    return var_3[[var_0]](self, _id_C78B(var_1._id_FFBF[0]), _id_C78B(var_1._id_FFBF[1]), _id_C78B(var_1._id_FFBF[2]), _id_C78B(var_1._id_FFBF[3]), _id_C78B(var_1._id_FFBF[4]), _id_C78B(var_1._id_FFBF[5]));
  } else if(var_1._id_FFBF.size == 7) {
    return var_3[[var_0]](self, _id_C78B(var_1._id_FFBF[0]), _id_C78B(var_1._id_FFBF[1]), _id_C78B(var_1._id_FFBF[2]), _id_C78B(var_1._id_FFBF[3]), _id_C78B(var_1._id_FFBF[4]), _id_C78B(var_1._id_FFBF[5]), _id_C78B(var_1._id_FFBF[6]));
  } else if(var_1._id_FFBF.size == 8) {
    return var_3[[var_0]](self, _id_C78B(var_1._id_FFBF[0]), _id_C78B(var_1._id_FFBF[1]), _id_C78B(var_1._id_FFBF[2]), _id_C78B(var_1._id_FFBF[3]), _id_C78B(var_1._id_FFBF[4]), _id_C78B(var_1._id_FFBF[5]), _id_C78B(var_1._id_FFBF[6]), _id_C78B(var_1._id_FFBF[7]));
  } else {
    return undefined;
  }
}

_id_C78B(var_0) {
  if(isDefined(var_0)) {
    if(_func_0121(var_0) && var_0 == "empty") {
      return undefined;
    } else {
      return var_0;
    }
  } else
    return undefined;
}

_id_C616() {
  level endon("game_ended");
  self waittill("death");
  self._id_41D4 = 0;
  level._id_C56F[self._id_A029] = undefined;
}

_id_E0AE(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_3 _id_33CA(undefined, "attempt spawn_ai");
  }

  var_4 = self.origin;
  var_5 = self.angles;

  if(isDefined(var_0)) {
    var_4 = var_0;
  }

  if(isDefined(var_1)) {
    var_5 = (0, var_1[1], 0);
  }

  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(var_3) && isDefined(var_3._id_E0B6) && var_3._id_E0B6.size > 0 && !isDefined(self.vehicle)) {
    var_6 = var_3 _id_358C();
    var_7 = level._id_13F7[var_6]._id_1210;
  } else if(isDefined(var_3) && isDefined(var_3._id_13F3) && var_3._id_13F3.size && !isDefined(self.vehicle)) {
    var_8 = _id_10DF6(var_3._id_13F3, var_3._id_13F5);
    var_7 = level._id_13F7[var_8]._id_1210;
    var_6 = var_8;
  } else if(isDefined(level._id_13F3) && level._id_13F3.size && !isDefined(self.vehicle)) {
    var_8 = _id_10DF6(level._id_13F3, level._id_13F5);
    var_7 = level._id_13F7[var_8]._id_1210;
    var_6 = var_8;
  } else if(isDefined(var_2)) {
    var_7 = level._id_13F7[var_2]._id_1210;
    var_6 = var_2;
  } else {
    var_9 = _id_631A();
    var_8 = scripts\engine\utility::random(var_9);
    var_7 = level._id_13F7[var_8]._id_1210;
    var_6 = var_8;
  }

  if(!isDefined(var_7)) {
    var_8 = scripts\engine\utility::random(level._id_BFD6);
    var_7 = level._id_13F7[var_8]._id_1210;
    var_6 = var_8;
  }

  var_10 = var_7;

  if(isDefined(var_3)) {
    var_3 _id_33CA(undefined, "Chose agent_type");
  }

  if(isDefined(var_3)) {
    var_3 _id_33CA(undefined, "In Spawn Queue");
  }

  _id_54C4();

  if(_id_855E()) {
    if(isDefined(level._id_11ED[var_10 + "_heavy"])) {
      var_10 = var_10 + "_heavy";
    }
  }

  self._id_13F1 = var_6;
  self._id_1210 = var_7;

  if(isDefined(var_3) && istrue(var_3._id_9EA7)) {
    var_11 = undefined;
    var_3 _id_33CA(undefined, "Force Spawn Loop");

    for(;;) {
      var_11 = _id_07F7::_id_E32A(var_10, var_4, var_5);

      if(isDefined(var_11)) {
        break;
      }

      waitframe();
    }

    var_3._id_9EA7 = undefined;

    if(_id_66FD(var_3._id_A029) > 0) {
      _id_4547(1, var_3._id_A029);
    }
  } else {
    if(isDefined(var_3)) {
      var_3 _id_33CA(undefined, "Spawn Attempt");
    }

    var_11 = _id_07F7::_id_E32A(var_10, var_4, var_5);
  }

  return var_11;
}

_id_85E3(var_0, var_1) {
  return var_0 >= var_1;
}

_id_358C() {
  var_0 = getarraykeys(self._id_E0B6);

  foreach(var_2 in var_0) {
    if(isDefined(self._id_E0B6[var_2]) && isint(self._id_E0B6[var_2]) && _id_85E3(self._id_E0B6[var_2], 1)) {
      for(var_3 = 0; var_3 < level._id_E197[self._id_7218].size; var_3++) {
        var_4 = level._id_E197[self._id_7218][var_3];

        if(isDefined(var_4._id_E0B6[var_2])) {
          var_4._id_E0B6[var_2]--;

          if(var_4._id_E0B6[var_2] <= 0) {
            var_4._id_E0B6[var_2] = undefined;
          }
        }
      }

      var_5 = level._id_13F7[var_2]._id_1210;
      var_6 = var_2;
      return var_6;
    }
  }

  return undefined;
}

_id_10DF6(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2 = var_2 + var_1[var_3];
  }

  var_4 = randomfloat(var_2);
  var_5 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_5 = var_5 + var_1[var_3];

    if(var_5 >= var_4) {
      return var_0[var_3];
    }
  }
}

_id_54C4() {
  level endon("game_ended");
  level._id_E1CF++;

  if(level._id_E1CF > 1) {
    wait(level._id_E1CF * 0.05);
  }

  level._id_E1CF--;
}

_id_E624() {
  self endon("death");
  self notify("start_patrol");
  self endon("start_patrol");
  self endon("enter_combat");
  level endon("game_ended");
  thread _id_5496();

  if(isDefined(self._id_0399)) {
    thread _id_7066(_id_65E0());
  } else if(isDefined(self._id_E342.target) || isDefined(self._id_E342._id_0399) && !_id_85AA()) {
    thread _id_7066(self._id_E342 _id_65E0());
  } else if(_id_DAC8()) {
    thread _id_AF44();
  }
}

_id_AF44() {
  self endon("enter_combat");
  self endon("death");

  if(!isDefined(self._id_4E81)) {
    self._id_4E81 = 0;
  }

  if(self._id_0201 < 256) {
    var_0 = 1024;
  } else {
    var_0 = self._id_0201;
  }

  _id_D232(64);
  var_1 = 64;
  var_2 = 256;
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(self._id_CD75)) {
    var_2 = int(self._id_CD75);
  }

  for(;;) {
    if(isDefined(self._id_CE10)) {
      var_5 = self._id_CE10;
    } else {
      var_5 = self.origin;
    }

    if(istrue(self._id_5AD2)) {
      wait 0.25;
      continue;
    }

    var_6 = -1;
    var_4 = undefined;
    var_7 = undefined;
    var_8 = _func_00B5(var_5, var_0, var_1, var_2, "all");
    var_9 = [];

    if(isDefined(var_8) && var_8.size > 0) {
      for(var_10 = 0; var_10 < var_8.size; var_10++) {
        if(isDefined(var_3) && var_8[var_10] == var_3) {
          continue;
        }
        if(isDefined(_func_03D1(var_8[var_10]))) {
          continue;
        }
        if(isDefined(self._id_4E81)) {
          var_11 = self.angles + (0, self._id_4E81, 0);
        } else {
          var_11 = self.angles;
        }

        var_12 = scripts\engine\math::_id_645E(self.origin, var_11, var_8[var_10].origin);

        if(var_12 < 0.3) {
          if(var_12 > var_6) {
            var_4 = var_8[var_10];
            var_6 = var_12;
          }

          continue;
        }

        var_9[var_9.size] = var_8[var_10];
      }
    }

    if(var_9.size > 0) {
      var_7 = _id_6549(var_9);
    }

    var_13 = gettime();

    if(isDefined(var_7)) {
      self._id_4E81 = undefined;
      var_3 = var_7;
      _id_7066(var_7);
      var_14 = gettime();

      if(var_14 <= var_13) {
        waitframe();
      }

      continue;
    }

    if(isDefined(var_4)) {
      self._id_4E81 = undefined;
      var_3 = var_4;
      _id_7066(var_4);
      var_14 = gettime();

      if(var_14 <= var_13) {
        waitframe();
      }

      continue;
    }

    wait 1;
  }
}

_id_5496(var_0) {
  self notify("enter_combat_after_stealth");
  self endon("enter_combat_after_stealth");
  self endon("death");
  self endon("enter_combat");
  var_1 = [];
  var_2 = [];
  var_3 = undefined;

  if(isDefined(self.team)) {
    if(isDefined(self._id_71F4) && self._id_71F4 scripts\engine\utility::_id_5472("weapons_free") && !self._id_71F4 scripts\engine\utility::_id_546E("weapons_free")) {
      if(self.team == "allies") {
        var_2 = [self, level];
        scripts\engine\utility::_id_10889(var_2, "damage", "stealth_combat", "stealth_over", "weapons_free", "bulletwhizby");
      } else if(istrue(self._id_1220))
        return;
      else if(_id_8657()) {
        var_2 = [self, self._id_71F4, level];
        scripts\engine\utility::_id_10889(var_2, "weapons_free", "saw_death");
      } else {
        var_2 = [self, self._id_71F4, level];
        var_3 = scripts\engine\utility::_id_1088C(level, "weapons_free", self._id_71F4, "weapons_free", self, "saw_death", self, "known_event");
      }
    }
  }

  if(isDefined(level._id_5497) && !scripts\engine\utility::_id_5C00(level._id_5497)) {
    scripts\engine\utility::_id_5C1B(level._id_5497);
  }

  thread _id_5494();
}

_id_D1BD() {
  self._id_904F = gettime();
}

_id_D1C2(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!_id_86C8("civilian") && (_id_8657() || _id_865D())) {
    thread _id_10A2E();
  }

  if(isDefined(var_0) && isDefined(var_0._id_722E)) {
    self._id_722E = var_0._id_722E;
  }

  _id_D265();

  if(isDefined(self._id_03A0)) {
    _id_D232(self._id_03A0);
  } else {
    _id_D232(2048);
  }

  if(isDefined(self._id_CD75)) {
    self._id_01FE = self._id_CD75;
  } else {
    self._id_01FE = 256;
  }

  self._id_A991 = self._id_0201;
  self._id_E342 = var_1;
  self._id_BE92 = 1;
  self._id_E1B3 = var_2;

  if(istrue(self._id_5549) || _id_8615()) {
    _id_6F52();
  }

  if(_id_855E() || _id_8615()) {
    _id_6F51();
  }

  _id_7EB9();
}

_id_C9BF(var_0, var_1, var_2, var_3) {
  self endon("death");
  thread _id_10A35();

  if(isDefined(var_3)) {
    _id_8BD8(var_3, self);
  }

  if(isDefined(level._id_7038) && level._id_7038.size > 0) {
    if(isDefined(self.team) && self.team == "axis") {
      var_4 = self.team;

      for(var_5 = 0; var_5 < level._id_7038[var_4].size; var_5++) {
        var_6 = level._id_7038[var_4][var_5];

        if(isDefined(var_6["param4"])) {
          self thread[[var_6["function"]]](var_6["param1"], var_6["param2"], var_6["param3"], var_6["param4"]);
          continue;
        }

        if(isDefined(var_6["param3"])) {
          self thread[[var_6["function"]]](var_6["param1"], var_6["param2"], var_6["param3"]);
          continue;
        }

        if(isDefined(var_6["param2"])) {
          self thread[[var_6["function"]]](var_6["param1"], var_6["param2"]);
          continue;
        }

        if(isDefined(var_6["param1"])) {
          self thread[[var_6["function"]]](var_6["param1"]);
          continue;
        }

        self thread[[var_6["function"]]]();
      }
    }
  }

  if(!_id_86C8("civilian") && (_id_8657() || _id_865D())) {
    thread _id_10A2E();
  }

  if(isDefined(level._id_53C9)) {
    self thread[[level._id_53C9]](self._id_04B9);
  }
}

_id_7EB9() {
  self._id_0188 = 0;

  if(!isDefined(self._id_03D6)) {
    self._id_03D6 = _func_0375();
  }

  scripts\common\utility::_id_82BA(self._id_034C);
  scripts\common\utility::_id_82BA(self._id_03D6);

  if(!_id_86C8("civilian")) {
    scripts\anim\shared::_id_B17E(self._id_034C, "primary");
    scripts\anim\shared::_id_B17E(self._id_03D6, "sidearm");
    scripts\cp\utility::_id_D170(1);
  }
}

_id_D265(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 * 1000;
  } else if(isDefined(self._id_71F4) && isDefined(self._id_71F4._id_8D3E)) {
    var_1 = self._id_71F4._id_8D3E * 1000;
  } else if(isDefined(self._id_E342) && isDefined(self._id_E342._id_CE86)) {
    var_1 = self._id_E342._id_CE86 * 1000;
  } else if(isDefined(self._id_71F4) && istrue(self._id_71F4._id_3E30)) {
    var_1 = 2500000;
  } else {
    var_1 = 20000;
  }

  var_2 = gettime() + var_1;

  if(!isDefined(self._id_8D8E) || var_2 > self._id_8D8E) {
    self._id_8D8E = var_2;
  }

  if(istrue(self._id_54CF)) {
    var_3 = var_1 / 1000;
    thread _id_1043(var_3);
  } else
    _id_C3CC();
}

_id_1043(var_0) {
  self notify("add_to_kill_off_list");
  self endon("add_to_kill_off_list");
  self endon("death");
  _id_C3CC();
  wait(var_0);

  if(isDefined(self._id_5501)) {
    level._id_30D0[self._id_5501] = self;
  } else {
    level._id_30D0[self getentitynumber()] = self;
  }

  if(level._id_30D0.size == 1) {
    level thread _id_AEA1();
  }
}

_id_AEA1() {
  level notify("stop_kill_off_loop");
  level endon("stop_kill_off_loop");
  level endon("game_ended");
  var_0 = level._id_01E2 / 1000;

  for(;;) {
    var_1 = 1;
    var_2 = getarraykeys(level._id_30D0);

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(!isDefined(level._id_30D0[var_2[var_3]])) {
        continue;
      }
      var_4 = level._id_30D0[var_2[var_3]] thread _id_AEA0();

      if(!isDefined(var_4) || var_4) {
        if(var_1 > var_0) {
          var_1 = var_1 - var_0;
        }

        waitframe();
      }
    }

    wait(var_1);
  }
}

_id_AEA0(var_0) {
  if(!isalive(self)) {
    return 0;
  }

  if(self.health < 1) {
    return 0;
  }

  if(_id_74E8()) {
    return 0;
  }

  if(istrue(scripts\engine\utility::_id_CD61("ai_is_carrying_hvt", self))) {
    return 0;
  }

  if(istrue(self._id_1E07)) {
    return 0;
  }

  if(istrue(self._id_B85C)) {
    return 0;
  }

  if(_id_86C8("juggernaut")) {
    return 0;
  }

  if(istrue(self._id_8617)) {
    _id_D265(20);
    return 0;
  }

  if(!istrue(self._id_5E84)) {
    if(_id_86A4()) {
      return 0;
    }

    if(isDefined(self._id_0192) && self _meth_8069()) {
      return 0;
    }
  }

  var_1 = _id_6746();

  if(isDefined(self._id_71F4) && istrue(self._id_71F4._id_3E30)) {
    var_2 = 2250000;
  } else {
    var_2 = 25000000;
  }

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(distancesquared(var_4.origin, self.origin) < var_2) {
      return 0;
    }

    if(self _meth_82CE(var_4, var_1)) {
      return 0;
    }
  }

  if(!_id_8D8D()) {
    if(!istrue(var_0)) {
      return 1;
    }
  }

  _id_F030("Passive Kill-Off", undefined, 0);
  return 1;
}

_id_8D8D() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(self _meth_861A(var_1, 0, 64, 1)) {
      return 0;
    }

    if(var_1 _meth_861A(self, 0, 64, 1)) {
      return 0;
    }
  }

  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 0, 0, 0, 1);
  var_3 = self _meth_86A9();

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_4 = level.players[var_0];

    if(scripts\engine\trace::ray_trace_passed(var_4 getEye(), var_3, [var_4, self], var_2)) {
      return 0;
    }
  }

  return 1;
}

_id_86A4() {
  return isDefined(self._id_C83B);
}

_id_86C8(var_0) {
  return isDefined(self._id_04B9) && self._id_04B9 == var_0;
}

_id_8615() {
  return isDefined(self._id_04B9) && self._id_04B9 == "juggernaut";
}

_id_D1B9() {
  self endon("death");
  wait 0.5;
  _id_D232(150);
  self._id_A991 = self._id_0201;
  self._id_037B = 100;
}

_id_EAD2(var_0) {
  thread _id_E5B5();

  if(isDefined(level._id_EAD2)) {
    self thread[[level._id_EAD2]]();
  } else {
    thread _id_4593();
  }
}

_id_E5B5() {
  self endon("death");
  self._id_EAF0 = 0;
  wait 3;
  var_0 = self.origin;

  while(distance(var_0, self.origin) < 750) {
    self._id_EAF0 = 0;
    wait 0.5;
  }

  self._id_EAF0 = 1;
}

_id_4593() {
  self endon("death");

  for(;;) {
    _id_6338();

    if(isDefined(self._id_0192)) {
      if(isDefined(self._id_0192._id_1024C)) {
        self._id_265A = self._id_0192._id_1024C;
      } else {
        self._id_265A = undefined;
      }
    }

    wait 1;
  }
}

_id_D7D0() {
  self._id_0229 = 1;
  self._id_0201 = 4;
  self._id_01FE = 32;
  self._id_010D = "no_cover";
  self _meth_800D("stand");
}

_id_D1BB() {
  self endon("death");
  self._id_A50F = 1;
  wait 0.5;
  _id_D232(250);
  self._id_A991 = self._id_0201;
}

_id_1D0C(var_0, var_1) {
  if(isDefined(var_0) && isDefined(level._id_DFF0)) {
    if(isDefined(level._id_DFF0[var_0])) {
      var_1[[level._id_DFF0[var_0]]]();

      if(isDefined(var_1._id_E3B2)) {
        level._id_E2A5[var_1._id_E3B2]++;
      }
    }
  }
}

_id_1E05() {
  if(isDefined(self._id_CD76)) {
    return;
  }
  if(_id_8643()) {
    return;
  }
  if(scripts\anim\utility_common::_id_8917()) {
    return;
  }
  if(isDefined(self._id_04B9) && self._id_04B9 == "juggernaut") {
    return;
  }
  level._id_E482 = getdvarint("#x31a3975e62a888e44", 4);
  level._id_E480 = getdvarint("#x36f31c8bb4b8a9506", 2);
  _id_0763::_id_1170();
}

_id_CA02(var_0) {
  if(isDefined(var_0) && isDefined(self._id_BA3F)) {
    foreach(var_2 in self._id_BA3F) {
      self[[var_2]](var_0);
    }
  }
}

_id_C9A7() {
  if(isDefined(self._id_E342._id_BA3E)) {
    foreach(var_1 in self._id_E342._id_BA3E) {
      self[[var_1]]();
    }
  }
}

_id_8BD8(var_0, var_1) {
  var_1._id_53AB = var_0._id_7218;
  var_1._id_A029 = var_0._id_A029;
  var_1._id_71F4 = var_0;
  var_1._id_71F4._id_0F3C++;
  var_1._id_71F4._id_E109++;
  var_0._id_12EB[var_0._id_12EB.size] = var_1;
  var_0 thread scripts\cp\utility::_id_1049("spawned_group_soldier", var_1);

  if(isDefined(var_0._id_F15F)) {
    var_1._id_F15F = var_0._id_F15F;
  }

  if(isDefined(var_0._id_12E9)) {
    for(var_2 = 0; var_2 < var_0._id_12E9.size; var_2++) {
      var_1 thread _id_BD55(var_0, var_0._id_12E9[var_2], undefined, var_1);
    }
  }
}

_id_8F5E() {
  if(isDefined(self._id_904F)) {
    return self._id_904F;
  } else {
    return gettime();
  }
}

_id_D3B6() {
  _id_1057(1);
}

_id_86C2() {
  return isDefined(self._id_E2CA) && self._id_E2CA & 1;
}

_id_E2CD() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("level_ready_for_script");
  scripts\engine\utility::_id_5C24("player_spawned_with_loadout");

  if(_id_86C2()) {
    return;
  }
  _id_D3B6();
  _id_C3A3();
  _id_D3B7();

  if(!_id_86C3()) {
    _id_C3DA(4);
    _id_C3DA(2);
  } else {
    _id_E177(self);
    self._id_904F = 0;

    if(_func_02DE(self) && isDefined(self._id_03EA)) {
      self._id_03EA = int(self._id_03EA);
    }

    if(isDefined(self._id_039D)) {
      var_0 = scripts\engine\utility::getStructArray(self._id_039D, "targetname");

      if(var_0.size > 0) {
        self._id_3577 = [];
        self._id_3577 = var_0;
        _id_7F28();
        scripts\engine\utility::_id_1BE2(var_0, ::_id_E2CD);
        return;
      }

      return;
    }

    var_1 = 2;
    var_2 = 64;
    var_3 = 128;
    var_4 = 256;

    if(!_func_02E1(self) && isDefined(self._id_03EA)) {
      if(!isint(self._id_03EA)) {
        self._id_03EA = int(self._id_03EA);
      }

      if(self._id_03EA &var_1) {
        self._id_5546 = 1;
      }

      if(self._id_03EA &var_2) {
        _id_1057(512);
        self._id_8651 = 1;
      }

      var_5 = 8;

      if(self._id_03EA &var_5) {
        self._id_4D80 = 1;
      }
    }

    if(isDefined(self._id_CCEA) || isDefined(self._id_CE85)) {
      self._id_BA3F = [];
      self._id_BA3F[self._id_BA3F.size] = ::_id_E2C8;
    }

    _id_6319();
  }
}

_id_86C3() {
  var_0 = "^0";
  var_1 = "^1";
  var_2 = "^2";
  var_3 = "^3";
  var_4 = "^4";
  var_5 = "^5";
  var_6 = "^6";
  var_7 = "^7";
  var_8 = "^8";
  var_9 = "^9";
  var_10 = var_1 + "SPAWNER DISABLED: ";

  if(isDefined(self._id_0481)) {
    var_11 = var_0 + "targetname = (" + self._id_0481 + ")";
  } else {
    var_11 = "";
  }

  var_12 = scripts\engine\utility::ter_op(_func_02DE(self), var_0 + "(struct) " + var_11 + var_3 + "spawner", var_0 + "(node)" + var_11 + var_3 + " spawner");

  if(isDefined(self._id_CD0A) && level._id_60E6 <= 1 && scripts\engine\utility::is_equal(self._id_CD0A, "hard")) {
    _id_4A51();
    return 0;
  }

  var_13 = 0;

  if(!_id_E2CB(4)) {
    if(isDefined(self.origin)) {
      var_14 = getgroundposition(self.origin, 1, 100, 16);

      if(var_13) {
        if(!isDefined(self._id_DD95) && !_func_02AE(var_14)) {
          _id_4A51();
          return 0;
        } else
          return 1;
      } else
        var_14 = self.origin;

      var_15 = _func_02AB(var_14);

      if(distance2dsquared(var_15, self.origin) <= 4096) {
        if(_func_02DE(self)) {
          var_15 = scripts\engine\utility::_id_5000(var_15, 32, -1000);
          self.origin = var_15;
        }
      } else {
        _id_4A51();
        return 0;
      }
    } else {
      _id_4A51();
      return 0;
    }
  }

  return 1;
}

_id_4A51() {
  _id_1057(1024);
}

_id_5222() {
  _id_C3DA(1024);
}

_id_D3B7() {
  if(isDefined(self._id_03EA) && !_func_02E1(self)) {
    var_0 = int(self._id_03EA);
    var_1 = 16;
    var_2 = 8;

    if(var_0 &var_1) {
      _id_4632("vehicle_spawner");
    }

    if(var_0 &var_2) {
      _id_4632("vehicle_spawner");
    }
  }

  if(isDefined(self._id_039D)) {
    var_3 = scripts\engine\utility::getStructArray(self._id_039D, "targetname");

    if(var_3.size > 0) {
      _id_4632("cluster_spawner");
    }
  }
}

_id_C3A3() {
  if(scripts\engine\utility::is_equal(self.target, "default")) {
    self.target = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_039B, "default")) {
    self._id_039B = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_CD58, 0)) {
    self._id_CD58 = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_CE7D, "axis")) {
    self._id_CE7D = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_03A0, 0)) {
    self._id_03A0 = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_CD75, 0)) {
    self._id_CD75 = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_CE10, (0, 0, 0))) {
    self._id_CE10 = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_CCEA, 0)) {
    self._id_CCEA = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_CE85, 0)) {
    self._id_CE85 = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_CD20, 0)) {
    self._id_CD20 = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_CD11, 0)) {
    self._id_CD11 = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_CD03, "default")) {
    self._id_CD03 = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_CE57, 0)) {
    self._id_CE57 = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_0399, "default")) {
    self._id_0399 = undefined;
  }

  if(scripts\engine\utility::is_equal(self._id_0398, "default")) {
    self._id_0398 = undefined;
  }

  if(isDefined(self._id_CEA5)) {
    if(_func_0121(self._id_CEA5) && scripts\engine\utility::is_equal(self._id_CEA5, "-1")) {
      self._id_CEA5 = undefined;
    } else if(isint(self._id_CEA5) && scripts\engine\utility::is_equal(self._id_CEA5, -1)) {
      self._id_CEA5 = undefined;
    }
  }
}

_id_85AA() {
  var_0 = 32;

  if(isDefined(self._id_E342)) {
    if(istrue(self._id_E342._id_4E14)) {
      return 1;
    } else if(!_func_02E1(self._id_E342) && isDefined(self._id_E342._id_03EA)) {
      if(self._id_E342._id_03EA &var_0 && !(self._id_E342._id_03EA & 8)) {
        if(isDefined(self._id_E342._id_0399)) {
          var_1 = getEntArray(self._id_E342._id_0399, "script_linkname");

          if(!isDefined(var_1) || var_1.size < 1) {
            var_1 = scripts\engine\utility::getStructArray(self._id_E342._id_0399, "script_linkname");
          }

          if(isDefined(var_1) && var_1.size > 0) {
            for(var_2 = 0; var_2 < var_1.size; var_2++) {
              var_3 = var_1[var_2];

              if(isDefined(var_3._id_0481) && var_3._id_0481 == "ai_spawn_doors") {
                if(!isDefined(self._id_E342._id_4E4C)) {
                  self._id_E342._id_4E4C = [var_3];
                } else {
                  self._id_E342._id_4E4C[self._id_E342._id_4E4C.size] = var_3;
                }

                continue;
              }

              if(isDefined(var_1[0]._id_039B) && var_1[0]._id_039B == "spawn_door_single") {
                if(!isDefined(self._id_E342._id_4E4C)) {
                  self._id_E342._id_4E4C = [var_3];
                  continue;
                }

                self._id_E342._id_4E4C[self._id_E342._id_4E4C.size] = var_3;
              }
            }

            if(isDefined(self._id_E342._id_4E4C) && self._id_E342._id_4E4C > 0) {
              self._id_E342._id_4E14 = 1;
              return 1;
              return;
            }

            return 0;
            return;
            return;
          }

          return 0;
          return;
        } else
          return 0;
      } else
        return 0;
    } else if(isDefined(self._id_E342._id_0399)) {
      var_1 = getEntArray(self._id_E342._id_0399, "script_linkname");

      if(!isDefined(var_1) || var_1.size < 1) {
        var_1 = scripts\engine\utility::getStructArray(self._id_E342._id_0399, "script_linkname");
      }

      if(isDefined(var_1) && var_1.size > 0) {
        for(var_2 = 0; var_2 < var_1.size; var_2++) {
          var_3 = var_1[var_2];

          if(isDefined(var_3._id_0481) && var_3._id_0481 == "ai_spawn_doors") {
            if(!isDefined(self._id_E342._id_4E4C)) {
              self._id_E342._id_4E4C = [var_3];
            } else {
              self._id_E342._id_4E4C[self._id_E342._id_4E4C.size] = var_3;
            }

            continue;
          }

          if(isDefined(var_1[0]._id_039B) && var_1[0]._id_039B == "spawn_door_single") {
            if(!isDefined(self._id_E342._id_4E4C)) {
              self._id_E342._id_4E4C = [var_3];
              continue;
            }

            self._id_E342._id_4E4C[self._id_E342._id_4E4C.size] = var_3;
          }
        }

        if(isDefined(self._id_E342._id_4E4C) && self._id_E342._id_4E4C.size > 0) {
          self._id_E342._id_4E14 = 1;
          return 1;
          return;
        }

        return 0;
        return;
        return;
      }

      return 0;
      return;
    } else
      return 0;
  } else
    return 0;
}

_id_8643() {
  if(isDefined(self._id_E342)) {
    if(!_func_02E1(self._id_E342) && isDefined(self._id_E342._id_03EA)) {
      return self._id_E342._id_03EA & 1;
    } else {
      return 0;
    }
  } else
    return istrue(self._id_A5DD);
}

_id_855E() {
  if(isDefined(self._id_E342)) {
    if(!_func_02E1(self._id_E342) && isDefined(self._id_E342._id_03EA)) {
      return self._id_E342._id_03EA & 2;
    } else {
      return 0;
    }
  } else
    return istrue(self._id_5546);
}

_id_865D() {
  if(isDefined(self._id_E342)) {
    if(!_func_02E1(self._id_E342) && isDefined(self._id_E342._id_03EA)) {
      return self._id_E342._id_03EA & 128;
    } else {
      return 0;
    }
  } else
    return istrue(self._id_CE1A);
}

_id_8657() {
  if(istrue(self._id_ADC5)) {
    return 1;
  } else if(isDefined(self._id_E342)) {
    if(!_func_02E1(self._id_E342) && isDefined(self._id_E342._id_03EA)) {
      return self._id_E342._id_03EA & 256;
    } else {
      return 0;
    }
  } else
    return istrue(self._id_CE12);
}

_id_C428() {
  if(isDefined(self._id_03EA)) {
    if(!_func_02E1(self._id_E342) && self._id_03EA & 256) {
      self._id_03EA = self._id_03EA - 256;
    }
  }
}

_id_FBC1(var_0) {
  var_1 = _id_BD55(self, self._id_E1C5);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(_func_02DE(var_1[var_2])) {
      var_1[var_2]._id_CD03 = var_0;
    }
  }
}

_id_74E8() {
  if(isDefined(self._id_0094) && self._id_0094 >= gettime()) {
    return 1;
  }

  if(_id_7504()) {
    return 1;
  }

  if(istrue(self._id_DD82)) {
    return 0;
  } else if(istrue(self._id_4DA6)) {
    return 1;
  } else if(isDefined(self._id_E342)) {
    if(!_func_02E1(self._id_E342) && isDefined(self._id_E342._id_03EA)) {
      return self._id_E342._id_03EA & 1024;
    } else {
      return 0;
    }
  } else
    return 0;
}

_id_7504() {
  if(isDefined(self._id_0094) && self._id_0094 >= gettime()) {
    return 1;
  }

  if(istrue(self._id_A439)) {
    return 1;
  } else if(isDefined(self._id_E342)) {
    if(!_func_02E1(self._id_E342) && isDefined(self._id_E342._id_03EA)) {
      return self._id_E342._id_03EA & 2048;
    } else {
      return 0;
    }
  } else
    return 0;
}

_id_DAC8() {
  if(isDefined(self._id_E342) && !istrue(_id_E177(self._id_E342))) {
    if(!_func_02E1(self._id_E342) && isDefined(self._id_E342._id_03EA)) {
      if(self._id_E342._id_03EA & 512) {
        return 0;
      } else {
        return 1;
      }
    } else
      return 1;
  } else
    return 1;
}

_id_AE56(var_0, var_1) {
  var_0 endon("death");
  self notify("parent_spawner_disable_after_count");
  self endon("parent_spawner_disable_after_count");
  var_1 endon("spawn_failed");
  var_1 waittill("spawn_success");

  if(isDefined(self._id_CCEA)) {
    self._id_CCEA--;

    if(self._id_CCEA < 1) {
      thread _id_4A4F(self, self._id_CE85, var_0);
    }
  } else if(isDefined(self._id_CE85)) {
    if(!isDefined(self._id_904F)) {
      self._id_904F = 0;
    }

    self._id_904F = gettime() + self._id_CE85 * 1000 + 10000;
  }
}

_id_E2C8(var_0) {
  if(isDefined(self._id_CCEA)) {
    self._id_CCEA--;

    if(self._id_CCEA < 1) {
      thread _id_4A4F(self, self._id_CE85, var_0);
    }
  } else if(isDefined(self._id_CE85)) {
    if(!isDefined(self._id_904F)) {
      _id_E2CD();
    }

    self._id_904F = gettime() + self._id_CE85 * 1000 + 10000;
  }
}

_id_7F28() {
  _id_4632("cluster_spawner");
}

_id_10A4A() {
  for(;;) {
    level waittill("disable_nearby_spawners_for_time", var_0);

    if(distance2dsquared(self.origin, var_0) <= 65536) {
      _id_D1BD();
    }
  }
}

_id_809E(var_0) {}

_id_6504(var_0) {
  if(!isDefined(var_0._id_039B)) {
    return 1250;
  }

  switch (var_0._id_039B) {
    case "sniper":
      return 2500;
    case "ar":
      return 1250;
    case "smg":
      return 1250;
    case "shotgun":
      return 1250;
    case "rpg":
      return 1250;
    case "soldier":
      return 1250;
    case "soldier_armored":
      return 1250;
    case "soldier_armored_helmet":
      return 1250;
    case "juggernaut":
      return 1250;
    case "soldier_random":
    default:
      return 1250;
  }
}

_id_53C7(var_0, var_1) {
  level endon("game_ended");
  _id_FBC8(var_0, var_1);

  if(getdvarint("#x34e1ebacc88a2dcb0", 0) != 0) {
    thread _id_8D00();
  }
}

_id_8D00() {
  self endon("death");

  for(;;) {
    var_0 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 10), self.origin + (0, 0, -10), 0, self);
    self._id_799F = var_0["surfacetype"] == "surftype_water";

    if(istrue(self._id_799F)) {
      if(istrue(level._id_2C4E)) {
        if(isDefined(level._id_E00F)) {
          self[[level._id_E00F]](2);
        }
      }
    }

    wait 1;
  }
}

_id_FBC8(var_0, var_1) {
  var_2 = 1;

  if(isDefined(self.team)) {
    if(self.team == "axis") {
      level._id_E2A4[level._id_E2A4.size] = self;
      level._id_4182 = level._id_4182 + var_2;
    } else if(self.team == "allies")
      level._id_E2A1[level._id_E2A1.size] = self;
  }

  level._id_E2A0[level._id_E2A0.size] = self;

  if(isDefined(var_0)) {
    if(var_0 == "juggernaut") {
      level._id_E2AA[level._id_E2AA.size] = self;
      level._id_4183 = level._id_4183 + var_2;
    }

    if(var_0 == "soldier_agent" || var_0 == "soldier") {
      level._id_E2AC[level._id_E2AC.size] = self;
      level._id_4184 = level._id_4184 + var_2;
    }
  }
}

_id_0DA4(var_0, var_1) {
  level endon("game_ended");
  self endon("update_spawn_data_on_death");
  self waittill("death");
  thread _id_FBC7(var_0, var_1);
}

_id_C3CC() {
  if(isDefined(level._id_30D0)) {
    if(isDefined(self._id_5501) && isDefined(level._id_30D0[self._id_5501])) {
      level._id_30D0[self._id_5501] = undefined;
    } else if(isDefined(level._id_30D0[self getentitynumber()])) {
      level._id_30D0[self getentitynumber()] = undefined;
    }

    if(level._id_30D0.size < 1) {
      level notify("stop_kill_off_loop");
    }
  }
}

_id_FBC7(var_0, var_1) {
  self notify("update_spawn_data_on_death");
  self endon("update_spawn_data_on_death");
  level endon("game_ended");
  thread _id_C3CC();

  if(!isDefined(self._id_71F4)) {
    level notify("no group defined");
  }

  var_2 = 1;

  if(isDefined(self._id_1D19)) {
    if(isDefined(self._id_1D19._id_1D16)) {
      self._id_1D19._id_1D16--;

      if(self._id_1D19._id_1D16 < 1) {
        self._id_1D19._id_1D16 = 0;
      }
    }
  }

  if(isDefined(self.team)) {
    if(self.team == "axis") {
      if(scripts\engine\utility::array_contains(level._id_E2A4, self)) {
        level._id_E2A4 = scripts\engine\utility::array_remove(level._id_E2A4, self);
        level._id_4182 = level._id_4182 - var_2;
      }
    } else if(self.team == "allies") {
      if(scripts\engine\utility::array_contains(level._id_E2A1, self)) {
        level._id_E2A1 = scripts\engine\utility::array_remove(level._id_E2A1, self);
      }
    }
  }

  _id_C3C7();

  if(isDefined(self._id_C83B)) {
    self._id_C83B thread scripts\cp\utility::_id_1049("passenger_died");
  }

  if(scripts\engine\utility::array_contains(level._id_E2A0, self)) {
    level._id_E2A0 = scripts\engine\utility::array_remove(level._id_E2A0, self);
  }

  if(isDefined(self._id_71F4)) {
    var_3 = _id_863B();

    if(self._id_71F4 _id_62F8() - var_2 >= 1) {
      self._id_71F4._id_0F3C = int(clamp(self._id_71F4._id_0F3C - var_2, 0, self._id_71F4._id_0F3C - var_2));
    } else {
      self._id_71F4._id_0F3C = 0;
    }

    self._id_71F4._id_12EB = scripts\engine\utility::array_remove(self._id_71F4._id_12EB, self);

    if(var_3) {
      if(!istrue(self._id_4982)) {
        self._id_71F4._id_41D4 = self._id_71F4._id_41D4 + var_2;
      }
    } else
      self._id_71F4._id_41D4 = self._id_71F4._id_41D4 + var_2;

    var_4 = _id_BD55(self._id_71F4, self._id_71F4._id_F381);

    if(isDefined(var_4) && var_4 > 0) {
      if(var_3 && self._id_71F4._id_41D4 >= var_4) {
        self._id_71F4 notify("spawn_module_" + self._id_71F4._id_A029 + "_completed");
        self._id_71F4 notify("group_spawning_completed");
        self._id_71F4 notify("reached_total_spawns");
        level notify("group_spawning_completed");

        if(self._id_71F4 _id_62F8(1) < 1) {
          _id_0762::_id_C3E9(self._id_71F4);
          self._id_71F4 notify("all_group_spawns_dead");

          if(scripts\engine\utility::array_contains(level._id_E197[self._id_71F4._id_7218], self._id_71F4)) {
            level._id_E197[self._id_71F4._id_7218] = ::scripts\engine\utility::array_remove(level._id_E197[self._id_71F4._id_7218], self._id_71F4);

            if(isDefined(level._id_E197[self._id_71F4._id_7218]) && level._id_E197[self._id_71F4._id_7218].size < 1) {
              level._id_E197[self._id_71F4._id_7218] = undefined;
            }
          }
        }
      } else if(!var_3 && self._id_71F4 _id_62F8(1) < 1) {
        _id_0762::_id_C3E9(self._id_71F4);
        self._id_71F4 notify("all_group_spawns_dead");

        if(scripts\engine\utility::array_contains(level._id_E197[self._id_71F4._id_7218], self._id_71F4)) {
          level._id_E197[self._id_71F4._id_7218] = ::scripts\engine\utility::array_remove(level._id_E197[self._id_71F4._id_7218], self._id_71F4);

          if(isDefined(level._id_E197[self._id_71F4._id_7218]) && level._id_E197[self._id_71F4._id_7218].size < 1) {
            level._id_E197[self._id_71F4._id_7218] = undefined;
          }
        }
      } else if(var_3 && self._id_71F4 _id_62F8(1) < 1)
        self._id_71F4 notify("active_all_group_spawns_dead");
    } else if(!var_3 && self._id_71F4 _id_62F8(1) < 1) {
      _id_0762::_id_C3E9(self._id_71F4);
      self._id_71F4 notify("all_group_spawns_dead");

      if(scripts\engine\utility::array_contains(level._id_E197[self._id_71F4._id_7218], self._id_71F4)) {
        level._id_E197[self._id_71F4._id_7218] = ::scripts\engine\utility::array_remove(level._id_E197[self._id_71F4._id_7218], self._id_71F4);

        if(isDefined(level._id_E197[self._id_71F4._id_7218]) && level._id_E197[self._id_71F4._id_7218].size < 1) {
          level._id_E197[self._id_71F4._id_7218] = undefined;
        }
      }
    } else if(var_3 && self._id_71F4 _id_62F8(1) < 1)
      self._id_71F4 notify("active_all_group_spawns_dead");

    if(!istrue(self._id_4982)) {
      thread _id_C9D6();
    } else {
      thread _id_C9C2();
    }

    if(_id_0762::_id_7214(self._id_71F4._id_7218)) {
      var_5 = self._id_71F4 _id_0762::_id_64DA();

      if(isDefined(var_5)) {
        var_6 = level._id_3AD0[var_5];

        if(isDefined(var_6) && var_6.size > 0) {
          for(var_7 = 0; var_7 < var_6.size; var_7++) {
            level thread _id_D0B3(var_6[var_7]._id_7218, "activeCount_changed", var_6[var_7] _id_62F8());
          }
        } else
          level thread _id_D0B3(self._id_71F4._id_7218, "activeCount_changed", self._id_71F4 _id_62F8());
      } else
        level thread _id_D0B3(self._id_71F4._id_7218, "activeCount_changed", self._id_71F4 _id_62F8());
    } else
      level thread _id_D0B3(self._id_71F4._id_7218, "activeCount_changed", self._id_71F4 _id_62F8());
  }

  if(isDefined(self._id_04B9)) {
    if(isDefined(self._id_04B9) && self._id_04B9 == "juggernaut") {
      level._id_E2AA = scripts\engine\utility::array_remove(level._id_E2AA, self);
      level._id_4183 = level._id_4183 - var_2;
    }

    if(self._id_04B9 == "soldier") {
      level._id_E2AC = scripts\engine\utility::array_remove(level._id_E2AC, self);
      level._id_4184 = level._id_4184 - var_2;
    }
  }
}

_id_F2C1(var_0, var_1, var_2) {
  if(isDefined(level._id_E197[var_0])) {
    for(var_3 = 0; var_3 < level._id_E197[var_0].size; var_3++) {
      level._id_E197[var_0][var_3]._id_E8F8 = var_1;

      if(!istrue(var_1)) {
        level._id_E197[var_0][var_3] notify("wave_spawn");
      }

      if(isDefined(var_2)) {
        level._id_E197[var_0][var_3] _id_33CA(undefined, var_2);
      }
    }
  }
}

_id_6765(var_0) {
  var_1 = 0;

  if(isDefined(level._id_E197[var_0])) {
    for(var_2 = 0; var_2 < level._id_E197[var_0].size; var_2++) {
      if(isDefined(level._id_E197[var_0][var_2]._id_E109)) {
        var_1 = var_1 + level._id_E197[var_0][var_2]._id_E109;
      }
    }
  }

  return var_1;
}

_id_1056(var_0) {
  var_0._id_E109++;
}

_id_EAC5(var_0) {
  var_0._id_E109--;
}

_id_C5E6(var_0) {
  if(isDefined(level._id_E197[var_0])) {
    for(var_1 = 0; var_1 < level._id_E197[var_0].size; var_1++) {
      if(isDefined(level._id_E197[var_0][var_1]._id_E109)) {
        level._id_E197[var_0][var_1]._id_E109 = 0;
      }
    }
  }
}

_id_D0B3(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_E197[var_0])) {
    for(var_4 = 0; var_4 < level._id_E197[var_0].size; var_4++) {
      var_5 = level._id_E197[var_0][var_4];
      var_5 thread scripts\cp\utility::_id_1049(var_1, var_2);
    }
  }
}

_id_62F8(var_0) {
  if(istrue(self._id_DD9D)) {
    return self._id_A025;
  } else {
    var_1 = 0;

    if(!istrue(var_0) && isDefined(self._id_3ACE)) {
      var_2 = level._id_3AD0[self._id_3ACE];

      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        var_4 = var_2[var_3];

        if(isDefined(var_4._id_0F3C)) {
          var_1 = var_1 + var_4._id_0F3C;
        }
      }
    } else if(isDefined(self._id_0F3C))
      var_1 = self._id_0F3C;

    return var_1;
  }
}

_id_D442(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_0F2F[var_0])) {
    for(var_4 = 0; var_4 < level._id_0F2F[var_0].size; var_4++) {
      var_5 = level._id_0F2F[var_0][var_4];
      var_5._id_10CA5 = var_1;
      var_5._id_8F77 = var_2;
      var_5._id_8F76 = var_3;
    }
  }
}

_id_F2D3(var_0) {
  self._id_DAE6 = 1;
}

_id_E779() {
  if(!scripts\engine\utility::_id_5C00("make_ai_aggro")) {
    self._id_ADC5 = 1;
    _id_D1C8("casual_gun");
    _id_5496();
    _id_10A2E();
  }
}

_id_D138() {
  self endon("death");
  self notify("set_aggro_flag_on_enter_combat");
  self endon("set_aggro_flag_on_enter_combat");
  self waittill("enter_combat");
  self._id_71F4 notify("weapons_free");
  level notify("spawn_module_" + self._id_71F4._id_A029 + "_completed");
  scripts\engine\utility::_id_5C1B("make_ai_aggro");
}

_id_BB5A(var_0) {
  level notify("spawn_module_" + var_0._id_A029 + "_completed");
}

_id_D360(var_0) {
  if(getdvarint("#x3fb70172ee8c19324", 1)) {
    var_1 = scripts\engine\utility::getStructArray("dwn_twn_patrol_structs", "targetname");
    var_2 = scripts\engine\utility::_id_6969(self.origin, var_1);

    if(isDefined(var_2) && isDefined(var_2._id_0398)) {
      self._id_0399 = var_2._id_0398;
    }
  } else
    thread _id_D397();

  var_3 = self;
  var_3._id_DD37 = 2200;
  var_3._id_ADC5 = 1;
}

_id_D397() {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(istrue(self._id_54CF)) {
      break;
    }

    self._id_CE10 = scripts\cp\utility::_id_63BD(level.players);
    wait 2;
  }
}

_id_F2C3(var_0, var_1) {
  var_0._id_8CAA = var_1;
}

_id_554C() {
  if(!isDefined(self._id_71F4)) {
    var_0 = ["frag_grenade_mp", "molotov_mp", "semtex_mp", "flash_grenade_mp", "concussion_grenade_mp", "smoke_grenade_mp", "gas_mp"];
    var_1 = [0.5, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];
  } else {
    var_0 = self._id_71F4._id_7156;
    var_1 = self._id_71F4._id_713F;
  }

  var_2 = scripts\engine\utility::_id_1BE1(var_1);
  var_3 = randomfloatrange(0.0, var_2);
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_4 = var_4 + var_1[var_5];

    if(var_4 >= var_3) {
      self._id_020A = makeweapon(var_0[var_5]);
      self._id_0206 = 2;
      return;
    }
  }
}

_id_64CE(var_0) {
  if(isDefined(var_0) && isDefined(var_0._id_7156)) {
    return;
  }
}

_id_1B52(var_0) {
  _id_6F51();
  thread _id_2341(var_0);
}

_id_2341(var_0) {
  if(isDefined(self._id_CE10)) {
    return;
  }
  if(istrue(self._id_DD7E)) {
    return;
  }
  if(scripts\cp\utility::_id_871A()) {
    return;
  }
  self notify("basic_combat");
  self endon("basic_combat");
  level endon("game_ended");
  self endon("death");

  if(!istrue(self._id_54CF)) {
    self waittill("enter_combat");
  }

  if(isDefined(self._id_0DDF) && !_id_86C8("juggernaut") && !istrue(self._id_24F9)) {
    self._id_0DDF._id_4AC4 = 0;
  } else {
    self._id_0DDF._id_4AC4 = 1;
  }

  _id_554C();

  if(!scripts\cp\utility::_id_871A()) {
    self._id_029A = 1200;
  }

  _id_D232(2048);
  var_1 = randomintrange(10, 20);
  wait(var_1);

  while(istrue(self._id_B85C)) {
    wait 1;
  }

  _id_D232(1536);
  var_1 = randomintrange(10, 20);
  wait(var_1);

  while(istrue(self._id_B85C)) {
    wait 1;
  }

  if(!scripts\cp\utility::_id_871A()) {
    self._id_002F = 1;
  }

  self._id_0230 = 1;
  _id_D232(1024);
  var_1 = randomintrange(10, 20);
  wait(var_1);

  while(istrue(self._id_B85C)) {
    wait 1;
  }

  _id_D232(512);
}

_id_10C96(var_0) {
  level endon("game_ended");

  if(isDefined(var_0)) {
    var_0 notify("wave_go_kamikaze");
    var_0 endon("wave_go_kamikaze");
    var_0 endon("death");

    if(isDefined(var_0._id_F226) && var_0._id_F226 > 0) {
      _id_0771::_id_FB62(0, var_0);
      var_0 thread _id_F22E(var_0._id_F226);
    }
  }

  wait 1.5;
  level notify("wave_ending");
}

_id_F22E(var_0) {
  level endon("game_ended");
  level notify("timeout_wave");
  level endon("timeout_wave");
  self endon("death");
  _id_A665(self._id_7218, "threshold_timeout");
  _id_F2C1(self._id_7218, 1, "wave_delay");
  _id_F2C1("wave_paratroopers", 1, "wave_delay");
  _id_10C92(var_0);

  if(!istrue(self._id_4A6A)) {
    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      level.players[var_1] thread scripts\cp\cp_hud_message::showsplash("cp_wave_ended", level._id_4B75, undefined);
    }
  }

  _id_0771::_id_FB62(0, self);
  wait(var_0);
  setomnvar("cp_wave_timer", 0);
  _id_0771::_id_7DC5();
  _id_C9CE(self._id_7218, [::_id_F2C3, undefined]);
  _id_F2C1(self._id_7218, undefined, "new_wave_starting");
  _id_F2C1("wave_paratroopers", undefined, "new_wave_starting");
}

_id_A665(var_0, var_1) {
  if(isDefined(level._id_E197[var_0])) {
    for(var_2 = 0; var_2 < level._id_E197[var_0].size; var_2++) {
      level._id_E197[var_0][var_2] notify(var_1);
    }
  }
}

_id_7223(var_0) {
  self endon("death");
  self endon("threshold_timeout");

  for(;;) {
    self waittill("activeCount_changed", var_1);

    if(getdvarfloat("#x33bbf0543ad27ff74", 0) != 0) {
      childthread _id_E657(getdvarfloat("#x33bbf0543ad27ff74"));
    }

    if(var_1 <= var_0) {
      self notify("start_threshold_timeout");
      break;
    }
  }
}

_id_E657(var_0) {
  self notify("start_threshold_timeout");
  self endon("start_threshold_timeout");
  wait(var_0);
  self notify("threshold_timeout");
}

_id_C9D6() {
  if(isDefined(self._id_71F4) && isDefined(self._id_71F4._id_124C)) {
    for(var_0 = 0; var_0 < self._id_71F4._id_124C.size; var_0++) {
      self thread[[self._id_71F4._id_124C[var_0]]]();
    }
  }
}

_id_863B() {
  var_0 = getarraykeys(level._id_0F2F);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = level._id_0F2F[var_0[var_1]];

    if(_func_0107(var_2)) {
      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        if(var_2[var_3] == self._id_71F4) {
          return 1;
        }
      }

      continue;
    }

    if(var_2 == self._id_71F4) {
      return 1;
    }
  }

  return 0;
}

_id_67DC() {
  var_0 = 0;

  foreach(var_2 in level._id_C599) {
    var_0 = var_0 + var_2;
  }

  return var_0;
}

_id_66FD(var_0) {
  if(isDefined(var_0) && isDefined(level._id_C599[var_0])) {
    return level._id_C599[var_0];
  } else {
    return 0;
  }
}

_id_7DBB(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    if(!isDefined(level._id_C599[var_1])) {
      level._id_C599[var_1] = 0;
    }
  } else
    var_1 = "default";

  level._id_C599[var_1] = level._id_C599[var_1] + var_0;
  _id_15AB(var_2, 1, level._id_C599[var_1], var_1);
}

_id_4547(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(level._id_C599[var_1])) {
      var_2 = level._id_C599[var_1];
      level._id_C599[var_1] = int(clamp(var_2 - var_0, 0, var_2 - var_0));

      if(level._id_C599[var_1] < 1) {
        level._id_C599[var_1] = undefined;
        return;
      }
    } else {}
  } else {
    var_1 = "default";

    if(isDefined(level._id_C599[var_1])) {
      var_2 = level._id_C599[var_1];
      level._id_C599[var_1] = int(clamp(var_2 - var_0, 0, var_2 - var_0));

      if(level._id_C599[var_1] < 1) {
        level._id_C599[var_1] = undefined;
        return;
      }
    } else {}
  }
}

_id_7DB5(var_0) {
  level._id_46B7 = level._id_46B7 + var_0;
}

_id_4542(var_0) {
  level._id_46B7 = level._id_46B7 - var_0;
}

_id_58F8(var_0) {
  self notify("fake_flashlight");
  self endon("fake_flashlight");
  self endon("death");

  if(getdvarint("#x38983e0a106d1bbca", 0) != 0) {
    return;
  }
  wait 0.25;
  var_1 = "npc_flashlight";

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(!isDefined(level._effect[var_1])) {
    return;
  }
  var_2 = [];
  var_2[var_2.size] = "tag_flash";
  var_2[var_2.size] = "tag_light";
  var_2[var_2.size] = "tag_silencer";

  foreach(var_4 in var_2) {
    if(isDefined(self gettagorigin(var_4, 1))) {
      playFXOnTag(level._effect[var_1], self, var_4);
      scripts\engine\utility::_id_10883("alerted", "spotted_player", "enter_combat", "alertNearbyEnemiesAfterDelay", "shooting");
      stopFXOnTag(level._effect[var_1], self, var_4);
      break;
    }
  }
}

_id_5494(var_0) {
  if(istrue(self._id_1220) || istrue(self._id_4D80)) {
    return;
  }
  self notify("alerted");
  self notify("enter_combat");
  self notify("stop_going_to_node");
  self endon("death");
  level endon("game_ended");
  _id_D265();
  _id_D1C8("combat");

  if(getdvarint("#x3b30defa995b4409a", 0)) {
    _id_074A::_id_5210(self, level.players, "outline_nodepth_green", "high");
  }

  self._id_ADC5 = undefined;
  self._id_CF4A = 0;
  self._id_54CF = 1;
  self._id_CE12 = undefined;
  self._id_0313 = 0;
  self._id_41D8 = undefined;

  if(!_id_86C8("juggernaut")) {
    var_1 = randomintrange(180, 220);
    scripts\engine\utility::set_movement_speed(var_1);
  }

  if(isDefined(self._id_CD75)) {
    self._id_01FE = self._id_CD75;
  } else {
    self._id_01FE = 256;
  }

  if(!_id_86C8("suicidebomber") && !_id_86C8("civilian")) {
    thread _id_6479();
  }

  _id_C9B7();
}

_id_C9B7(var_0, var_1) {
  if(isDefined(self._id_3A95)) {
    var_2 = self._id_3A95;
  } else {
    var_2 = self._id_13F1;
  }

  if(isDefined(var_2)) {
    if(isDefined(level._id_13F7[var_2]) && isDefined(level._id_13F7[var_2]._id_3A93)) {
      if(isDefined(var_0) && isDefined(var_1)) {
        self thread[[level._id_13F7[var_2]._id_3A93]](var_0, var_1);
      } else if(isDefined(var_0)) {
        self thread[[level._id_13F7[var_2]._id_3A93]](var_0);
      } else {
        self thread[[level._id_13F7[var_2]._id_3A93]]();
      }
    }
  }
}

_id_6479(var_0) {
  level endon("game_ended");
  self notify("get_enemy_info_loop");
  self endon("get_enemy_info_loop");
  self endon("death");

  if(istrue(self._id_1E07)) {
    self._id_0229 = 0;
    self._id_8651 = undefined;
    self._id_1E07 = undefined;
    self show();
    _id_D265(20.0);
  }

  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  var_1 = 0;
  var_2 = 1;

  if(isDefined(self._id_71F4)) {
    if(isDefined(self._id_71F4._id_E1E2)) {
      var_3 = self._id_71F4._id_E1E2._id_F338;
    } else if(istrue(self._id_71F4._id_3E30)) {
      var_3 = 2333;
    } else {
      var_3 = 4096;
    }
  } else if(istrue(level._id_E1E2))
    var_3 = level._id_E1E2._id_F338;
  else {
    var_3 = 4096;
  }

  var_3 = int(min(var_3, 2500));

  for(;;) {
    if(istrue(self._id_0229) || istrue(self._id_CF4A)) {
      var_1 = 0;
      self._id_EE6F = undefined;
    } else {
      var_4 = ::_id_6338;
      var_5 = ::_id_63D0;
      var_6 = var_3;

      if(var_2) {
        var_6 = undefined;
      }

      var_7 = self[[var_4]](var_6);
      var_8 = self[[var_5]](var_6, var_7);

      if(isDefined(var_8)) {
        var_2 = 0;

        if(isDefined(self._id_CE10)) {
          var_9 = self._id_CE10;
        } else {
          var_9 = var_8.origin;
        }

        if(scripts\cp\utility::_id_871A()) {
          _id_D230(var_8.origin);
        } else if(!_id_74E8() && _id_10FFC(var_9)) {
          if(_id_AE99(gettime())) {
            _id_F030("Too Far From Target", var_9);
          }
        } else {
          _id_D265(var_0);
          _id_D1C8("combat");

          if(isDefined(self._id_707D) && !isDefined(self._id_8F57)) {
            self._id_707D = undefined;
            _id_D232(self._id_8F24);
          }

          _id_FBD8(var_8);

          if(isDefined(self._id_71F4)) {
            self._id_71F4 scripts\engine\utility::_id_5474("weapons_free");
          }

          if(isDefined(self._id_CD76)) {
            self _meth_8328(self._id_CD76);
          } else {
            self _meth_807C();

            if(!istrue(self._id_3A94)) {
              if(!istrue(self._id_8651) && isDefined(self._id_0197)) {
                var_10 = 6;

                if(self _meth_82CE(var_8, var_10)) {
                  var_11 = distancesquared(var_9, self.origin);
                  var_12 = var_11 <= self._id_0197 * self._id_0197;

                  if(istrue(var_1) && var_12 || isDefined(var_8._id_1024C)) {
                    var_1 = 0;
                    _id_D230(self.origin);
                  } else if(!istrue(var_1) && !var_12) {
                    var_1 = 1;
                    _id_D230(var_8.origin);
                  }
                } else {
                  var_1 = 1;
                  _id_D230(var_8.origin);
                }
              } else {
                self._id_707D = undefined;
                _id_D230(self.origin);
              }
            }
          }
        }
      } else if(!istrue(self._id_3A94)) {
        var_1 = 0;
        self._id_EE6F = undefined;
        self._id_707D = undefined;

        if(isDefined(self._id_CE10)) {
          _id_D230(self._id_CE10);
        } else if(istrue(self._id_8651)) {
          _id_D230(self.origin);
        } else if(isDefined(self._id_CD76)) {
          self _meth_8328(self._id_CD76);
        } else if(!_id_74E8()) {
          if(_id_AE99(gettime())) {
            _id_F030("No Target Found", self.origin);
          } else {
            _id_D230(self.origin);
            _id_D1C8("cqb");
          }
        } else {
          _id_D230(self.origin);
          _id_D1C8("cqb");
        }
      }
    }

    wait(var_0);
  }
}

_id_6337() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    self _meth_812E(level.players[var_0]);
  }
}

_id_6338(var_0) {
  self notify("get_all_players_enemy_info_new");
  self endon("get_all_players_enemy_info_new");
  var_1 = [];

  if(!scripts\engine\utility::is_equal(self._id_015B, "combat")) {
    self endon("death");
    wait 5;
  }

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(_id_6678(level.players[var_2])) {
      var_1[var_1.size] = level.players[var_2];
    }
  }

  return var_1;
}

_id_6678(var_0) {
  if(scripts\cp\utility::_id_871A()) {
    var_0._id_903D = gettime();
    self _meth_812E(var_0);
    return 1;
  }

  var_1 = 5;
  var_2 = 5;

  if(self _meth_82CE(var_0, var_1)) {
    var_0._id_903D = gettime();
    self _meth_812E(var_0);
    return 1;
  } else if(isDefined(var_0._id_903D) && gettime() < var_0._id_903D + var_2 * 1000) {
    self _meth_812E(var_0);
    return 1;
  } else if(isDefined(self._id_0323) && distancesquared(self._id_0323, var_0.origin) < 262144 && self _meth_8473() < 2048)
    return 1;

  return 0;
}

_id_10FFC(var_0) {
  var_1 = self.origin;
  var_2 = 256;

  if(scripts\anim\utility_common::_id_8766()) {
    var_2 = 512;
  }

  var_3 = undefined;

  if(isDefined(var_0)) {
    var_3 = var_0[2];
  }

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(!isDefined(var_0)) {
      var_3 = level.players[var_4].origin[2];
    }

    if(int(abs(var_1[2] - var_3)) >= var_2 && !_func_0213(undefined, level.players[var_4].origin, var_1)) {
      return 1;
    }
  }

  return 0;
}

_id_D231() {
  self endon("death");

  if(!isDefined(self._id_707D)) {
    _id_D232(1024);
  }

  var_0 = level._id_E2A4;
  var_1 = scripts\engine\utility::_id_6369(self.origin, var_0, undefined, 10);
  var_2 = scripts\cp\utility::_id_63BD(var_1);

  if(!isDefined(self._id_707D) || distance2dsquared(self._id_707D, var_2) >= 262144) {
    self._id_707D = var_2;
    _id_D22F(self._id_707D);
  }

  wait 5;
}

_id_7519() {
  self endon("death");
  var_0 = 10;
  var_1 = gettime() / level._id_01E2 % var_0;
  var_2 = self getentitynumber() % var_0;

  if(var_1 != var_2) {
    wait((var_2 + var_0 - var_1) % var_0 * level._id_01E2 / 1000);
  }

  while(_id_7518()) {
    wait 0.5;
  }
}

_id_7518() {
  var_0 = 3;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(self _meth_82CE(level.players[var_1], var_0)) {
      return 1;
    }
  }

  if(!_id_8D8D()) {
    return 1;
  }

  return 0;
}

_id_F030(var_0, var_1, var_2) {
  if(scripts\cp\utility::_id_871A()) {
    return;
  }
  if(istrue(self._id_9B33) || istrue(self._id_1E07)) {
    return;
  }
  if(_id_7504()) {
    if(isDefined(var_0)) {
      if(getdvarint("#x3226b36501b00064b", 0)) {
        var_3 = 1;

        if(isDefined(var_1)) {
          if(var_3) {
            _func_0012("(NKO)Agent at: " + self.origin + " attempted teleport because: " + var_0);
          }
        } else if(var_3)
          _func_0012("(NKO)Agent at: " + self.origin + " attempted teleport because: " + var_0);
      }
    }
  } else if(istrue(self._id_5E84) || !isDefined(self._id_71F4))
    _id_CD94();
  else {
    self endon("death");
    self notify("teleport_to_nearby_spawner");
    self endon("teleport_to_nearby_spawner");

    if(getdvarint("#x3226b36501b00064b", 0)) {
      self _meth_81B0("outline_cp_teleport_debug");
    }

    if(getdvarint("#x3ce954131db058308", 0)) {
      self notify("get_enemy_info_loop");
      self._id_0229 = 1;
      self.ignoreme = 1;
      self._id_9B33 = 1;
      _id_D22F(self.origin);
      self waittill("forever");
    }

    if(!isDefined(var_2)) {
      var_2 = 1;
    }

    if(var_2) {
      _id_7519();
    }

    if(istrue(self._id_B85C)) {
      _id_CD94(1);
    } else {
      if(_id_86A4()) {
        _id_CD94();
        return;
        return;
      }

      var_4 = _id_359C(self._id_71F4, 1, self);

      if(isDefined(var_4)) {
        if(isDefined(var_0)) {
          if(getdvarint("#x3226b36501b00064b", 0)) {
            var_3 = 1;

            if(isDefined(var_1)) {
              if(var_3) {
                _func_0012("Agent at: " + self.origin + " teleported because: " + var_0);
              }
            } else if(var_3)
              _func_0012("Agent at: " + self.origin + " teleported because: " + var_0);
          }
        }

        var_4 notify("spawn_success", var_4);
        self endon("death");
        self._id_3A94 = undefined;
        self._id_1E07 = 1;
        self._id_0229 = 1;
        _id_D265(20.0);
        self hide();
        var_4 _id_D1BD();
        wait 0.1;
        self dontinterpolate();
        var_5 = (0, 0, 0);

        if(isDefined(var_4.angles)) {
          var_5 = var_4.angles;
        }

        self _meth_80F9(var_4.origin, var_5, 10000, 1);
        self._id_707D = undefined;
        _id_D22F(self.origin);
        wait 0.1;
        self._id_0229 = 0;
        self._id_8651 = undefined;
        self._id_1E07 = undefined;
        self show();
        _id_D265(20.0);
        var_6 = _id_63CF();
        _id_FBD8(var_6);
        return;
      }

      if(isDefined(var_0)) {
        if(var_0 == "Bad Path") {
          return;
        }
        if(var_0 == "Too Far From Target") {
          if(isDefined(var_1)) {} else {}

          _id_D231();
          return;
        }

        _id_CD94();
        return;
        return;
        return;
      }

      _id_CD94();
    }
  }
}

_id_CD94(var_0) {
  _id_C3CC();

  if(self._id_0094 >= gettime()) {
    waitframe();
  }

  self._id_9B33 = 1;

  if(!istrue(var_0)) {
    self._id_A546 = 1;
  }

  self._id_4982 = 1;
  self._id_4984 = self.health;
  self _meth_81FA();
}

_id_8605() {
  return 0;
}

_id_C3C7(var_0) {
  if(!isDefined(var_0) && isDefined(self._id_EE6F)) {
    var_0 = self._id_EE6F;
  }

  if(isDefined(var_0)) {
    if(scripts\engine\utility::array_contains(var_0._id_53C1, self)) {
      var_0._id_53C1 = scripts\engine\utility::array_remove(var_0._id_53C1, self);
    }
  }
}

_id_63CF(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_2 = scripts\common\utility::_id_B7C7(self.origin, var_0);
  } else {
    var_2 = scripts\cp\utility::_id_636E();
  }

  var_2 = _func_0204(var_2, self.origin);
  var_3 = var_0;

  if(var_2.size > 0) {
    var_1 = var_2[0];

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_5 = var_2[var_4];

      if(istrue(var_5.ignoreme)) {
        continue;
      }
      if(!var_5 scripts\cp\utility::_id_8708(1, 1)) {
        continue;
      }
      if(isDefined(self._id_0192) && var_5 == self._id_0192) {
        return var_5;
      }

      if(_id_0762::_id_3E11(var_5.origin)) {
        var_1 = var_5;
        break;
      }
    }
  }

  if(isDefined(var_1)) {
    return var_1;
  } else {
    return undefined;
  }
}

_id_63D0(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0) && !scripts\cp\utility::_id_871A()) {
    var_3 = _id_B7C8(self.origin, var_0, var_1);
  } else {
    var_3 = scripts\cp\utility::_id_636E();
  }

  var_3 = _func_0204(var_3, self.origin);
  var_4 = var_0;

  if(var_3.size > 0) {
    var_2 = var_3[0];

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_6 = var_3[var_5];

      if(istrue(var_6.ignoreme)) {
        continue;
      }
      if(!var_6 scripts\cp\utility::_id_8708(1, 1)) {
        continue;
      }
      if(isDefined(self._id_0192) && var_6 == self._id_0192) {
        return var_6;
      }

      if(var_6 _id_0762::_id_3E11(self.origin)) {
        var_2 = var_6;
        break;
      }
    }
  }

  if(isDefined(var_2)) {
    return var_2;
  } else {
    return undefined;
  }
}

_id_B7C8(var_0, var_1, var_2) {
  var_3 = physics_createcontents(["physicscontents_characterproxy"]);
  var_4 = (var_1, var_1, var_1);
  var_5 = var_0 - var_4;
  var_6 = var_0 + var_4;
  var_7 = [];
  var_8 = _func_02BF(var_5, var_6, var_3, []);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    if(isPlayer(var_8[var_9])) {
      if(scripts\engine\utility::array_contains(var_2, var_8[var_9])) {
        var_7 = scripts\engine\utility::array_add(var_7, var_8[var_9]);
      }
    }
  }

  return var_7;
}

_id_D1B5() {
  self._id_029A = 768;
  scripts\engine\utility::set_movement_speed(75);
  self _meth_8310(128, 64);
  self _meth_830F(512, 640);
}

_id_DA5B(var_0) {
  if(!isDefined(var_0)) {
    var_0 = _id_63CF();
  }

  if(!isDefined(var_0)) {
    _id_D1C8("sprint");
    _id_D232(2000);
    return;
  } else {
    _id_FBD8(var_0);
    _id_D228(var_0);
    self _meth_8323(var_0, 250);
    _id_D232(512);
    _id_D1C8("combat");
  }
}

_id_DA5A(var_0) {
  if(!isDefined(var_0)) {
    var_0 = _id_63CF();
  }

  if(!isDefined(var_0)) {
    _id_D1C8("sprint");
    _id_D232(2000);
  } else {
    self._id_3A94 = 1;
    _id_D228(var_0);
    _id_D232(256);
    _id_D1C8("combat");
  }
}

_id_FBD8(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(var_0._id_53C1)) {
      var_0._id_53C1 = [];
    }

    if(!isDefined(self._id_EE6F) || self._id_EE6F != var_0) {
      self notify("changed_target");
      _id_C3C7(var_0);
    }

    _id_C9B7(var_0);
  }

  self._id_EE6F = var_0;
}

_id_DA5C() {}

_id_DF54() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self._id_CD76)) {
    self _meth_8328(self._id_CD76);
  }

  self._id_0159 = "cover_sniper_cp";
  _id_D1C8("frantic");
  self _meth_8310(1024.0, 0.0);
  self _meth_830F(2048.0, 4096.0);
  self waittill("enemy");
  self _meth_8510(1, 1);
  self _meth_8512(64);
  self _meth_8511(1);
}

_id_B2A8(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0._id_0229 = 1;
  var_0 _id_0AED::_id_18C8("sdr_com_inter_rappel_window", var_1.origin, var_1.angles);
  var_0._id_0229 = 0;
  var_0 _id_0AED::_id_18C1();

  if(isDefined(var_2)) {
    var_0 thread[[var_2]](var_0);
  }
}

_id_F597(var_0, var_1) {}

_id_F5EF(var_0, var_1) {
  level endon("game_ended");
  var_2 = _id_C9FD(var_0.target);
  var_0 notify("disable_trigger");
}

_id_F5F0(var_0, var_1) {
  level endon("game_ended");
  var_2 = _id_C9FD(var_0.target);

  if(isDefined(var_2)) {
    _id_106ED(var_2);
  }
}

_id_D1E4() {
  self._id_4DA6 = 1;
}

_id_106EF(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    level scripts\engine\utility::_id_108A7(var_1, "module_group " + var_0._id_7218 + " completed");
  } else {
    level waittill("module_group " + var_0._id_7218 + " completed");
  }
}

_id_106ED(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_0 scripts\engine\utility::_id_108A7(var_1, "group_spawning_completed");
  } else {
    var_0 waittill("group_spawning_completed");
  }
}

_id_106D5(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(var_0._id_E109 % var_1 == 0) {
    return var_2;
  } else {
    return var_3;
  }
}

_id_C77E(var_0, var_1, var_2) {
  var_1 = _id_4633(var_1, 3);
  var_2 = _id_4633(var_2, 5);
  return randomintrange(var_1, var_2);
}

_id_10924(var_0, var_1) {
  if(var_0._id_E109 == 0) {
    level waittill(var_1);
  } else if(var_0._id_9C33 % var_0._id_E109 == 0) {
    level waittill(var_1);
  } else {
    return 0.1;
  }
}

_id_10E7B(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(!_func_0107(var_1)) {
    var_1 = [var_1];
  }

  if(!_func_0107(var_2)) {
    var_2 = [var_2];
  }

  if(var_1.size != var_2.size) {
    return;
  }
  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = "within_bounds_" + var_5;
    var_4[var_5] = var_6;
    _id_10A5C(var_0, var_1[var_5], var_2[var_5], undefined, var_6, 1);
  }

  var_0 scripts\engine\utility::_id_10879(var_4);
  var_0 notify("stop_watching_beyond_point");

  if(isDefined(var_3)) {
    var_0 thread[[var_3]]();
  }
}

_id_10A5C(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_10A5D(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_52CC() {
  _id_E8BF(self._id_7218, 1);
}

_id_10A5D(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_0 endon("stop_watching_beyond_point");
  var_6 = spawnStruct();
  var_6.origin = var_1;
  var_6.angles = var_2;

  for(;;) {
    for(var_7 = 0; var_7 < level.players.size; var_7++) {
      if(var_6 _id_0762::_id_3E11(level.players[var_7].origin)) {
        if(isDefined(var_4)) {
          var_0 notify(var_4);
        }

        if(isDefined(var_3)) {
          var_0 thread[[var_3]]();
        }

        if(!istrue(var_5)) {
          return;
        }
      }
    }

    wait 0.5;
  }
}

_id_1075D(var_0) {
  var_0 scripts\engine\utility::_id_5476("weapons_free");
}

_id_721A(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 2048;
  }

  var_2 = var_0 _id_676D();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] _id_D232(var_1);
  }
}

_id_721E(var_0, var_1) {
  thread _id_F9C2(var_1);
}

_id_F9C2(var_0) {
  level endon("game_ended");
  self endon("death");
  level waittill(var_0);
  self._id_0229 = 0;
}

_id_721F(var_0, var_1) {
  var_2 = var_0 _id_676D();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] _id_0762::_id_5204();
  }
}

_id_D26E(var_0) {
  level notify("weapons_free");

  if(scripts\engine\utility::_id_5C0C("weapons_free")) {
    scripts\engine\utility::_id_5C1B("weapons_free");
  }
}

_id_7207(var_0, var_1) {
  var_2 = var_0 _id_676D();
  var_0 _id_D395(var_1);
}

_id_5963(var_0, var_1) {
  if(var_0 scripts\engine\utility::_id_546E("weapons_free")) {
    _id_D396(var_1);
  }
}

_id_E87E(var_0, var_1, var_2) {
  _id_C9FD(var_2);
  _id_E8BF(var_1);
}

_id_A028(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 = _id_4633(var_1, _id_663F());
  var_2 = _id_4633(var_2, _id_663C());
  var_3 = _id_4633(var_3, 0.1);
  var_7 = _id_4633(var_6, var_0 _id_62F8());
  var_4 = _id_663E(var_0, var_4);
  var_5 = _id_663D(var_0, var_5);

  if(istrue(var_0._id_E253)) {
    if(!istrue(var_0._id_4A6A)) {
      setomnvar("cp_wave_timer", 0);
    }

    return var_3;
  } else {
    var_8 = gettime();

    if(isDefined(var_4) && isDefined(var_5)) {
      if(isDefined(var_6)) {
        if(var_0._id_E109 > 0 && var_0._id_E109 % var_5 == 0) {
          var_0 _id_33CA(undefined, "low_threshold: " + var_4);
          var_0 _id_7223(var_4);
          var_0 _id_33CA(undefined, "wave_delay");
          var_0 _id_10C92(var_1);
          wait(var_1);

          if(!istrue(var_0._id_4A6A)) {
            setomnvar("cp_wave_timer", 0);
          }

          var_0 _id_0771::_id_7DC5();
          var_0 _id_33CA(undefined, "spawning_after_low_threshold");
        } else {
          var_0 _id_33CA(undefined, "spawning_to_high_threshold");
          return var_3;
        }
      } else if(var_7 >= var_5) {
        var_0 _id_33CA(undefined, "low_threshold: " + var_4);
        var_0 _id_7223(var_4);
        var_0 _id_33CA(undefined, "wave_delay");
        var_0 _id_10C92(var_1);
        wait(var_1);

        if(!istrue(var_0._id_4A6A)) {
          setomnvar("cp_wave_timer", 0);
        }

        var_0 _id_0771::_id_7DC5();
        var_0 _id_33CA(undefined, "spawning_after_low_threshold");
      } else {
        var_0 _id_33CA(undefined, "spawning_to_high_threshold");
        return var_3;
      }
    } else if(!isDefined(var_0._id_8F78)) {
      var_0 _id_33CA(undefined, "first_spawn_window");
      var_0._id_E253 = 1;
      var_0 scripts\engine\utility::delaythread(var_2, ::_id_4A50);
      var_0 scripts\engine\utility::delaythread(var_2, ::_id_10C92, var_1);
      return var_3;
    } else {
      var_9 = var_0._id_8F78 + var_1 * 1000 - var_8;

      if(var_9 < 0) {
        var_0 _id_33CA(undefined, "full_spawn_window");
        var_0._id_E253 = 1;
        var_0 scripts\engine\utility::delaythread(var_2, ::_id_4A50);
        var_0 scripts\engine\utility::delaythread(var_2, ::_id_10C92, var_1);
        return var_3;
      } else {
        var_0 _id_33CA(undefined, "wave_delay");
        return var_1;
      }
    }
  }
}

_id_10C92(var_0) {
  if(!istrue(level._id_10C91)) {
    level thread _id_A0EC(var_0);

    if(!istrue(self._id_4A6A)) {
      var_1 = gettime() + var_0 * 1000;
      setomnvar("cp_wave_timer", int(var_1));
    }
  }
}

_id_A0EC(var_0) {
  level endon("game_ended");
  level._id_10C91 = 1;
  wait(var_0);
  level._id_10C91 = undefined;
}

_id_AD43(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(isDefined(var_1)) {
    var_4[var_4.size] = var_1;
  }

  if(isDefined(var_2)) {
    var_4[var_4.size] = var_2;
  }

  if(isDefined(var_3)) {
    var_4[var_4.size] = var_3;
  }

  for(var_5 = 0; var_5 < var_0._id_E1C5.size; var_5++) {
    var_6 = var_0._id_E1C5[var_5];
    var_6._id_039B = var_4;
  }
}

_id_D19D(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_7226[var_1])) {
    level._id_7226[var_1] = [];
  }

  if(!scripts\engine\utility::array_contains(level._id_7226[var_1], var_0)) {
    level._id_7226[var_1][level._id_7226[var_1].size] = var_0;
  }

  var_4 = var_0._id_0F3C;
  var_5 = _id_62F5(level._id_7226[var_1]);

  if(var_5 < var_2) {
    return var_3;
  } else {
    return 0;
  }
}

_id_7501(var_0) {
  var_1 = _id_679B(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  var_2 = _id_679B(var_0);

  if(!isDefined(var_2)) {
    return 0;
  }

  return var_1 < var_2;
}

_id_679B(var_0) {
  if(isDefined(var_0._id_EACF)) {
    return var_0._id_EACF;
  } else {
    return undefined;
  }
}

_id_67DE(var_0) {
  if(isDefined(var_0._id_F368)) {
    return var_0._id_F368;
  } else {
    return undefined;
  }
}

_id_D3EB(var_0, var_1) {
  var_0._id_F368 = var_1;
}

_id_62F5(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_1 + var_0[var_2]._id_0F3C;
  }

  return var_1;
}

_id_4633(var_0, var_1) {
  if(!isDefined(var_0)) {
    if(_func_03AC(var_1)) {
      return [[var_1]]();
    } else {
      return var_1;
    }
  } else
    return var_0;
}

_id_4A50(var_0) {
  self._id_E253 = undefined;
  self._id_8F78 = gettime();
}

_id_10CA7(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(var_0 _id_62F8() <= var_0._id_9EA5) {
    if(var_1 > 0.05) {
      return randomfloatrange(0.05, var_1);
    } else {
      return 0.05;
    }
  }

  if(var_0._id_0F3C >= var_0._id_9C33) {
    while(var_0 _id_62F8() > var_0._id_9EA5) {
      wait 0.25;
    }

    return var_2;
  }

  if(isDefined(var_1)) {
    return var_1;
  } else if(isDefined(var_2)) {
    return var_2;
  } else {
    return 0.05;
  }
}

_id_D443(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_0._id_4A6A = !var_1;
}

_id_7066(var_0, var_1, var_2) {
  if(!isDefined(var_0) || _func_0107(var_0) && var_0.size < 1) {
    var_0 = self._id_E342 _id_65E0();

    if(var_0.size == 0) {
      self notify("reached_path_end");

      if(isDefined(var_1)) {
        [[var_1]]();
      }

      return;
    }
  } else if(!_func_0107(var_0))
    var_0 = [var_0];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isvector(var_0[var_3])) {
      var_4 = spawnStruct();
      var_4.origin = var_0[var_3];
      var_4.angles = (0, 0, 0);
      var_0[var_3] = var_4;
    }
  }

  _id_7069(var_0, var_1, var_2);
}

_id_65E0() {
  var_0 = _id_6563();

  if(var_0.size < 1) {
    if(isDefined(self.target)) {
      var_0 = _id_67AC(self.target);
    }
  }

  return var_0;
}

_id_67AC(var_0) {
  var_1 = _func_00B3(var_0, "targetname");
  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    var_1[var_1.size] = var_4;
  }

  var_2 = getEntArray(var_0, "targetname");

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_4 = var_2[var_6];

    if(!_id_86E0(var_4)) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_6563() {
  var_0 = [];

  if(isDefined(self._id_0399)) {
    var_1 = scripts\engine\utility::_id_6556();
    var_2 = scripts\engine\utility::_id_655C();
    var_3 = scripts\engine\utility::_id_6557();
    var_0 = scripts\engine\utility::array_combine(var_1, var_2, var_3);
  }

  return var_0;
}

_id_7069(var_0, var_1, var_2) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");
  level endon("game_ended");

  if(!_func_0107(var_0)) {
    var_0 = [var_0];
  }

  thread _id_7068();
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;
  var_6 = var_0[0];

  for(;;) {
    if(!var_3) {
      var_0 = _id_6549(var_0);
      var_5 = _id_6640(var_0, var_6);

      if(var_5.size > 1) {
        var_3 = 1;
      }
    }

    self._id_41D8 = var_0;

    if(var_3) {
      var_0 = var_5[var_5.size - 1];
      _id_705D(var_5, var_1, var_2);
      var_5 = undefined;
      var_3 = 0;
    } else {
      _id_A559(var_0);
      _id_706B(var_0);
      self waittill("goal");
    }

    var_0 notify("trigger", self);
    _id_A556(var_0, var_1);
    _id_A558(var_0);
    var_0 scripts\engine\utility::_id_0393();

    if(isDefined(var_0._id_CD4B)) {
      scripts\engine\utility::_id_5C24(var_0._id_CD4B);
    }

    if(isDefined(var_0._id_CD31)) {
      scripts\engine\utility::_id_5476(var_0._id_CD31);
    }

    var_0 scripts\engine\utility::_id_CEB7();
    _id_A557(var_0, var_2);

    if(!isDefined(var_0.target) && !isDefined(var_0._id_0399)) {
      break;
    }

    var_7 = var_0 _id_65E0();

    if(!var_7.size) {
      break;
    }

    var_0 = var_7;
  }

  self notify("reached_path_end");

  if(isDefined(self._id_CD56)) {
    return;
  }
  var_8 = self _meth_8138();

  if(isDefined(var_8)) {
    self _meth_8328(var_8, var_8 _id_641C());
  }
}

_id_6549(var_0) {
  if(var_0.size == 1) {
    return var_0[0];
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0];

  if(!isDefined(var_1._id_FE40)) {
    var_1._id_FE40 = 0;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3._id_FE40)) {
      var_3._id_FE40 = 0;
    }

    if(var_3._id_FE40 < var_1._id_FE40) {
      var_1 = var_3;
    }
  }

  var_1._id_FE40 = gettime();
  return var_1;
}

_id_6640(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for(;;) {
    var_2[var_2.size] = var_0;
    var_3++;

    if(var_3 == 16) {
      break;
    }

    if(_id_706F(var_0)) {
      break;
    }

    if(!isDefined(var_0.target) && !isDefined(var_0._id_0399)) {
      break;
    }

    var_4 = var_0 _id_65E0();

    if(!var_4.size) {
      break;
    }

    var_0 = _id_6549(var_4);

    if(var_0 == var_1) {
      break;
    }
  }

  return var_2;
}

_id_705D(var_0, var_1, var_2) {
  self _meth_8325(var_0);

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_3;
    var_5 = var_0[var_3];
    self._id_41D8 = var_5;
    _id_A559(var_5);
    var_6 = _id_1092E();

    if(var_4 == var_0.size - 1) {
      self waittill("goal");
      break;
    }

    var_5 notify("trigger", self);
    _id_A556(var_5, var_1);
    _id_A558(var_5);
    _id_A557(var_5, var_2);
  }
}

_id_A559(var_0) {
  if(isDefined(var_0._id_0359)) {
    _id_D232(var_0._id_0359);
  }

  if(isDefined(var_0._id_03A0)) {
    self._id_03A0 = var_0._id_03A0;
    _id_D232(var_0._id_03A0);
  }

  if(isDefined(var_0.height)) {
    self._id_01FE = var_0.height;
  }

  if(isDefined(var_0._id_CD03)) {
    _id_D1C8(var_0._id_CD03);
  }

  if(istrue(var_0._id_CE12) || isDefined(var_0._id_03EA) && var_0._id_03EA & 256) {
    self._id_0313 = 1;
  }

  if(isDefined(var_0._id_CD89)) {
    self._id_0229 = var_0._id_CD89;
  }

  if(isDefined(var_0._id_CD8A)) {
    self.ignoreme = var_0._id_CD8A;
  }

  if(isDefined(var_0._id_CD45)) {
    scripts\engine\utility::_id_5C11(var_0._id_CD45);
  }

  if(isDefined(var_0._id_CE57)) {
    scripts\engine\utility::set_movement_speed(var_0._id_CE57);
  }
}

_id_A556(var_0, var_1) {
  if(isDefined(var_1)) {
    [[var_1]](var_0);
  }

  if(isDefined(var_0._id_CD49)) {
    scripts\engine\utility::_id_5C1B(var_0._id_CD49);
  }

  if(isDefined(var_0._id_CD30)) {
    scripts\engine\utility::_id_5474(var_0._id_CD30);
  }

  if(isDefined(var_0._id_CD46)) {
    scripts\engine\utility::_id_5C04(var_0._id_CD46);
  }
}

_id_A558(var_0) {
  level endon("game_ended");
  self endon("death");

  if(!istrue(level._id_7041) && !istrue(self._id_54CF) && isDefined(var_0._id_CC9F)) {
    var_1 = undefined;
    var_2 = strtok(var_0._id_CC9F, ",");
    var_1 = scripts\engine\utility::random(var_2);

    if(isDefined(var_1)) {
      if(!istrue(var_0._id_CDA9)) {
        self._id_DD5A = 1;
      } else {
        self._id_DD5A = undefined;
      }

      self._id_B85C = 1;
      _id_B2C9(var_0, var_1);
      self._id_B85C = undefined;

      while(istrue(self._id_B85C)) {
        wait 0.05;
      }
    }
  }
}

_id_B2C9(var_0, var_1) {
  self endon("death");

  if(istrue(self._id_DD5A)) {
    self endon("patrol_" + var_1 + "_loop");
  }

  _id_D22F(var_0.origin);
  self thread[[level._id_E1EF[var_1]._id_DDCD]]();

  while(istrue(self._id_B85C)) {
    wait 0.05;
  }
}

_id_A557(var_0, var_1) {
  if(isDefined(var_0._id_CE4B)) {
    if(_func_0205(var_0._id_CE4B)) {
      self playSound(var_0._id_CE4B);
    }
  }

  if(isDefined(var_0._id_CD56)) {
    _id_D232(var_0._id_CD56);
  }

  if(isDefined(self._id_BA42)) {
    [[self._id_BA42]]();
  }

  if(isDefined(var_0._id_CCFF)) {
    wait(var_0._id_CCFF);
  }

  while(isDefined(var_0._id_CE32)) {
    var_0._id_CE32 = 0;

    if(_id_7072(var_0, ::_id_65E0)) {
      var_0._id_CE32 = 1;
      var_0 notify("script_requires_player");
      break;
    }

    wait 0.25;
  }

  if(isDefined(var_0._id_CD04)) {
    _id_D1C8(var_0._id_CD04);
  }

  if(isDefined(var_1)) {
    [[var_1]](var_0);
  }

  if(isDefined(var_0._id_CCEF) && var_0._id_CCEF) {
    _id_CD94();
  }

  if(isDefined(var_0._id_0394) && var_0._id_0394) {
    self delete();
  }
}

_id_7072(var_0, var_1) {
  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    var_3 = level.players[var_2];

    if(distancesquared(var_3.origin, var_0.origin) < distancesquared(self.origin, var_0.origin)) {
      return 1;
    }

    if(!isDefined(var_0._id_CD11)) {
      var_4 = anglesToForward(self.angles);

      if(isDefined(var_0.target)) {
        var_5 = var_0[[var_1]](var_0.target);

        if(var_5.size == 1) {
          var_4 = vectornormalize(var_5[0].origin - var_0.origin);
        } else if(isDefined(var_0.angles)) {
          var_4 = anglesToForward(var_0.angles);
        }
      } else if(isDefined(var_0.angles))
        var_4 = anglesToForward(var_0.angles);

      var_6 = [];
      var_6[var_6.size] = vectornormalize(var_3.origin - self.origin);

      foreach(var_8 in var_6) {
        if(vectordot(var_4, var_8) > 0) {
          return 1;
        }
      }
    }

    var_10 = 300;

    if(var_0._id_CE32 > var_10) {
      var_10 = var_0._id_CE32;
    }

    if(distancesquared(var_3.origin, self.origin) < _func_0219(var_10)) {
      return 1;
    }

    return 0;
  }
}

_id_1092E() {
  self endon("goal");
  self waittill("subgoal", var_0);
  return var_0;
}

_id_706F(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  if(!isDefined(var_0.target)) {
    return 1;
  }

  if(isDefined(var_0._id_0393)) {
    return 1;
  }

  if(isDefined(var_0._id_CCFD)) {
    return 1;
  }

  if(isDefined(var_0._id_CCFB)) {
    return 1;
  }

  if(isDefined(var_0._id_CEB7)) {
    return 1;
  }

  if(isDefined(var_0._id_CEBD)) {
    return 1;
  }

  if(isDefined(var_0._id_CEBF)) {
    return 1;
  }

  if(isDefined(var_0._id_CEBE)) {
    return 1;
  }

  if(isDefined(var_0._id_CD4B)) {
    return 1;
  }

  if(isDefined(var_0._id_CD31)) {
    return 1;
  }

  if(isDefined(var_0._id_CCFF)) {
    return 1;
  }

  if(isDefined(var_0._id_CE32)) {
    return 1;
  }

  if(isDefined(var_0._id_CD86)) {
    return 1;
  }

  if(isDefined(var_0._id_CE6F)) {
    return 1;
  }

  return 0;
}

_id_641C() {
  if(isDefined(self._id_7090)) {
    return anglesToForward((0, self._id_7090, 0));
  } else {
    return undefined;
  }
}

_id_706B(var_0) {
  if(_func_02E1(var_0)) {
    _id_706D(var_0);
  } else if(_func_02DE(var_0)) {
    _id_706E(var_0);
  } else if(isent(var_0)) {
    _id_706C(var_0);
  }

  if(_func_02DE(var_0) || _func_02E1(var_0)) {
    var_0._id_AF43 = _id_706F(var_0);
  }
}

_id_706C(var_0) {
  if(var_0._id_00EC == "info_volume") {
    self _meth_8328(var_0, var_0 _id_641C());
    self notify("go_to_node_new_goal");
    return;
  }

  _id_706E(var_0);
}

_id_706E(var_0) {
  _id_D228(var_0);
  self notify("go_to_node_new_goal");
}

_id_5495() {
  level endon("game_ended");
  self endon("death");
  _id_7066(self._id_E342 _id_65E0());
  thread _id_5494();
}

_id_D228(var_0) {
  _id_D22F(var_0.origin);
  self._id_8F57 = var_0;

  if(_func_02DE(var_0) && !isDefined(var_0.type)) {
    var_0.type = "struct";
  }
}

_id_D22F(var_0) {
  if(istrue(self._id_01C2)) {
    return;
  }
  self._id_8F58 = undefined;
  self._id_8F59 = var_0;
  self._id_8F57 = undefined;
  self _meth_8326(_func_02AB(var_0));
  self notify("new_goal_pos");
}

_id_706D(var_0) {
  _id_D22C(var_0);
  self notify("go_to_node_new_goal");
}

_id_D22C(var_0) {
  self._id_8F58 = var_0;
  self._id_8F59 = undefined;
  self._id_8F57 = undefined;
  self _meth_8324(var_0);
}

_id_7068() {
  self notify("go_to_node_end");
  self endon("go_to_node_end");
  self endon("death");
  level endon("game_ended");
  self._id_FEFC = 1;
  var_0 = scripts\engine\utility::_id_10897("reached_path_end", "stop_going_to_node");
  self._id_FEFC = undefined;
  self._id_AED4 = undefined;
  self._id_AED5 = undefined;
}

_id_86E0(var_0) {
  if(_func_011E(var_0)) {
    return 0;
  }

  switch (var_0._id_00EC) {
    case "trigger_once":
    case "trigger_multiple":
    case "trigger_radius":
    case "misc_turret":
      return 0;
  }

  return 1;
}

_id_D232(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 2048;
  }

  self._id_8F24 = self._id_0201;
  self._id_0201 = int(var_0);
}

_id_C783() {
  if(isDefined(self._id_8F24)) {
    _id_D232(self._id_8F24);
  }
}

_id_D230(var_0) {
  if(isDefined(self._id_CE10)) {
    var_0 = self._id_CE10;
  }

  _id_D22F(var_0);
}

_id_D395(var_0) {
  if(_func_0107(self)) {
    var_1 = [];

    for(var_2 = 0; var_2 < self.size; var_2++) {
      var_1 = scripts\engine\utility::array_add(var_1, self[var_2]._id_12EB);
    }

    var_3 = var_1;
  } else
    var_3 = self._id_12EB;

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    var_3[var_2] _id_D265();
    var_3[var_2] _id_D396(var_0);
  }
}

_id_A022(var_0) {
  self._id_DD7E = 1;
}

_id_A020(var_0, var_1) {
  _id_D232(var_1);
}

_id_A01F(var_0, var_1) {
  self._id_01FE = var_1;
}

_id_A027(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24(var_1);
  scripts\engine\utility::_id_5C30(var_1);
}

_id_C77F(var_0) {
  return var_0._id_7218;
}

_id_A026(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24(var_1);
}

_id_A021(var_0, var_1) {
  self._id_CE10 = var_1;
}

_id_D396(var_0) {
  self._id_CE10 = var_0;
}

_id_3902(var_0) {
  self._id_CE10 = undefined;
}

_id_A017() {
  _id_4690();
  setDvar("#x391cd6389fe783812", 0);
  setdvarifuninitialized("#x3a731d9ca20703d4b", 0);
  setdvarifuninitialized("#x3d2f526ab5353c293", 0);
  setdvarifuninitialized("#x37e42531712b60624", 0);
  setdvarifuninitialized("#x3b30defa995b4409a", 0);
  setdvarifuninitialized("#x3f6b900a1b7f27a67", 0);
  setdvarifuninitialized("#x3e551f79e67cd0150", 0);
  setdvarifuninitialized("#x3c4b6901a26ba195", 0);
  setdvarifuninitialized("#x39cb63f850cbec3e8", 0);
  setdvarifuninitialized("#x3fe835c6c65085e83", "");
  setdvarifuninitialized("#x348f7f626e222167b", 0);
  setdvarifuninitialized("#x3db9280a31b77f898", 1);
  setdvarifuninitialized("#x37875c0c26384a5a4", 0);
  setdvarifuninitialized("#x34884f8d674216743", 0);
  setdvarifuninitialized("#x3226b36501b00064b", 0);
  setdvarifuninitialized("#x3ce954131db058308", 0);
  setdvarifuninitialized("#x3aad81f9e75acfd21", 0);
  setdvarifuninitialized("#x36f754e78b977f4cd", -1);
  setdvarifuninitialized("#x3c6c7a78d09f8cf89", -1);
  setdvarifuninitialized("#x3fe5e21af7fa522c8", -1);
  setdvarifuninitialized("#x3c36ed0a3906233db", -1);
  setdvarifuninitialized("#x399040ec4278fcaa5", -1);
  setdvarifuninitialized("#x36dc3312205b204d7", "");
  setdvarifuninitialized("#x35e52d1abcb1ecaf2", 0);
  setdvarifuninitialized("#x33bbf0543ad27ff74", 0);
  setdvarifuninitialized("#x3fb70172ee8c19324", 1);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Agent Stats:1 / Disable:0\" \"togglep scr_show_agent_stats 0\" \n";
  scripts\cp\utility::_id_10A9(var_0);

  for(var_1 = 4; var_1 < 4 + _id_6589(); var_1++) {
    var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Agent Stats:1 / e" + var_1 + ":" + var_1 + "\" \"togglep scr_show_agent_stats " + var_1 + "\" \n";
    scripts\cp\utility::_id_10A9(var_0);
  }

  var_0 = "devgui_cmd \"CP Debug:2 / Debug / Print Dialogue Aliases\" \"togglep scr_print_dialogue_alias 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Print Spawner Disables:2\" \"togglep scr_print_spawner_disables 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Cleanup Stats:2\" \"togglep scr_show_kill_off_stats 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Pause Spawning:0\" \"togglep scr_pause_spawning 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Print Spec Info\" \"togglep scr_show_spawn_spec_info 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Toggle Ambient Spawning\" \"togglep scr_always_on_always 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Disable badpath cleanup:3\" \"togglep scr_disable_bad_path_cleanup 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Teleport Reasons:3\" \"togglep scr_show_teleport_reason 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Use Wave Spawning\" \"togglep scr_wave_spawning 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Init Nodes As Spawners\" \"togglep scr_init_cover_node_spawners 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Use Cover Node Spawning\" \"togglep scr_cover_node_spawning 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Only Use Passive Spawning\" \"togglep scr_only_passive_spawning 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / AI Outline Debug:4\" \"togglep scr_ai_outline_debug 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Cleanup Vehicles:4\" \"set scr_debug_spawning cleanup_vehicles\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Stop All Groups:4\" \"set scr_debug_spawning stop_all_groups\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / whyAmINotShooting\" \"togglep ai_whyaminotshooting 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / whyAmINotMoving\" \"togglep ai_whyaminotmoving 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Stealth / Debug\" \"togglep debug_stealth 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Stealth / Chat\" \"togglep debug_stealth_chat 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Stealth / fov\" \"togglep debug_stealth_fov 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  level._id_E344 = 0;
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Toggle:4\" \"set scr_debug_spawning spawnpoint_debug\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Spawnpoint Selection\" \"togglep scr_show_spawn_selection 0 1\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Add Proxy Player At Loc:4\" \"set scr_debug_spawning proxy_add_player\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Delete All Proxy Players:4\" \"set scr_debug_spawning proxy_delete_all\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Delete Selected Proxy Player:4\" \"set scr_debug_spawning proxy_delete_selected\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Active Spawn Modules\" \"set scr_debug_spawning show_active_spawn_modules\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Convert Nodes To Spawners\" \"set scr_debug_spawning convert_nodes\" \n";
  scripts\cp\utility::_id_10A9(var_0);
  _id_C23C("DEBUG:0/Max Agent Test", 0, ::_id_6589, undefined, 0.1, undefined, ::_id_632B, undefined, undefined, undefined);
  _id_C23C("DEBUG:0/Vehicles/Vehicle_Spawn_Test", 0, 24, undefined, 0.1, undefined, ::_id_6809, undefined, undefined, undefined);
}

_id_6809(var_0) {
  if(getDvar("#x3a5ce9d6014ffeb19", "") != "") {
    var_1 = scripts\engine\utility::getStructArray(getDvar("#x3a5ce9d6014ffeb19", ""), "targetname");

    if(var_1.size > 0) {
      return var_1;
      return;
    }

    return [];
    return;
  } else
    return [];
}

_id_632B(var_0) {
  if(isDefined(level._id_3A02) && level._id_3A02.size > 0) {
    return level._id_3A02;
  } else {
    return undefined;
  }
}

_id_BCEF() {
  level notify("print_active_modules_to_screen");
  level endon("print_active_modules_to_screen");
  level._id_DC15 = !level._id_DC15;

  if(!level._id_DC15) {
    if(isDefined(level._id_9DB8)) {
      level._id_9DB8 destroy();
    }

    return;
  }

  _id_3ED4();

  for(;;) {
    var_0 = 150;
    var_1 = " ";
    var_2 = "|Active| Min| Max|Deaths| Total";
    var_3 = "Active Modules| Spawn Count: " + level._id_E2A0.size + "/" + _id_6589();
    var_3 = var_3 + _func_00D6(var_1, 0, var_1.size - (var_3.size + var_2.size)) + var_2;
    var_0 = var_0 + 15;
    var_4 = " ";
    var_5 = _func_00D6(var_1, 0, var_1.size - var_4.size * 5 - 4);

    if(isDefined(level._id_E197) && level._id_E197.size > 0) {
      var_6 = getarraykeys(level._id_E197);

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];
        var_9 = level._id_E197[var_8];

        for(var_10 = 0; var_10 < var_9.size; var_10++) {
          var_11 = var_9[var_10];

          if(var_8 == "wave_spawning") {
            var_12 = var_11 _id_642D();
            var_8 = "wave: " + var_12;
          }

          var_13 = var_11 _id_65B1();

          if(isDefined(level._id_0F2F) && var_11 _id_85E6()) {
            var_14 = (1, 1, 1);
          } else {
            var_14 = (1, 1, 0);
          }

          var_15 = _id_101B("| A:" + var_11 _id_62F8(1), var_4);
          var_16 = _id_101B("| m:" + var_13._id_9EA5, var_4);
          var_17 = _id_101B("| M:" + var_13._id_9C33, var_4);
          var_18 = _id_101B("| T:" + var_13._id_F381, var_4);
          var_19 = _id_101B("| D:" + var_11._id_41D4, var_4);
          var_3 = _id_101B(var_13._id_E774 + "|" + var_8, var_5) + "[" + var_10 + "] " + var_15 + var_16 + var_17 + var_19 + var_18;
          var_0 = var_0 + 15;
        }
      }
    }

    waitframe();
  }
}

_id_3ED4() {
  level._id_9DB8 = _id_3F29();
  level._id_9DB8 setshader("black", 350, 110);
  level._id_9DB8.color = (0.2, 0.2, 0.2);
  level._id_9DB8.alpha = 0.1;
  level._id_9DB8.sort = -20;
}

_id_3F29(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 20;
  }

  var_6 = newhudelem();
  var_6._id_96CF = 0;
  var_6.alignx = "left";
  var_6.aligny = "middle";
  var_6.vertalign = "top";
  var_6.horzalign = "left";
  var_6._id_01D6 = 1;
  var_6.fontscale = 1;
  var_6.sort = _id_4633(var_5, 1);
  var_6.alpha = _id_4633(var_4, 0.1);
  var_6.x = _id_4633(var_1, 0);
  var_6.y = _id_4633(var_2, 85);
  var_6._id_A9A9 = 1;
  var_6.archived = 0;

  if(isDefined(var_0)) {
    var_6._id_F0E8 = var_0;

    if(_func_02B7(var_0)) {
      var_6 _meth_83A3(var_0);
    } else {
      var_6 _meth_8076();
    }
  }

  return var_6;
}

_id_101B(var_0, var_1) {
  if(var_0.size > var_1.size) {
    return _func_00D6(var_0, 0, var_1.size);
  } else {
    var_2 = _func_00D6(var_1, 0, var_1.size - var_0.size);

    if(isDefined(var_2) && var_2.size > 0) {
      return var_0 + var_2;
    } else {
      return var_0;
    }
  }
}

_id_85E6() {
  if(isDefined(level._id_0F2F) && level._id_0F2F.size > 0) {
    var_0 = getarraykeys(level._id_0F2F);

    for(var_1 = 0; var_1 < level._id_0F2F.size; var_1++) {
      var_2 = var_0[var_1];

      if(scripts\engine\utility::array_contains(level._id_0F2F[var_2], self)) {
        return 1;
      }
    }

    return 0;
  } else
    return 0;
}

_id_3F45() {
  var_0 = spawnStruct();
  var_0._id_E774 = "running";
  var_0._id_9EA5 = 0;
  var_0._id_9C33 = 0;
  var_0._id_F381 = 0;
  self._id_443F = var_0;
}

_id_33CA(var_0, var_1) {}

_id_65B1() {
  return self._id_443F;
}

_id_1211(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("door_being_used");
  var_1 notify("door_being_used");
  var_1 endon("door_being_used");

  foreach(var_8 in var_2) {
    if(!var_8 scripts\engine\utility::_id_5472("max_spawns_reached")) {
      var_8 scripts\engine\utility::_id_5473("max_spawns_reached");
    }

    if(!var_8 scripts\engine\utility::_id_5472("using_intro_anim")) {
      var_8 scripts\engine\utility::_id_5473("using_intro_anim");
    }
  }

  var_1 _meth_85CA(var_1._id_1CB8, "animscripted");
  var_1 _id_06BD::_id_2400();
  var_1._id_0229 = 1;
  var_1._id_CF4A = 1;
  var_10 = undefined;
  var_11 = 2;
  var_12 = undefined;
  var_1 thread _id_454E(var_0, var_1, var_6, var_2);

  if(isDefined(level._id_E17E)) {
    if(var_0._id_E2DB == 1) {
      foreach(var_8 in var_2) {
        _id_D1E6(var_8, "open_started", var_6);
      }

      var_1 thread _id_E009(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
    } else
      var_1 thread _id_E009(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  } else {
    foreach(var_8 in var_2) {
      _id_D1E6(var_8, "open_started", var_6);
    }

    var_1 thread _id_E009(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
  }
}

_id_454E(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(!isDefined(var_0._id_E2DB)) {
    var_0._id_E2DB = 0;
  }

  var_0._id_E2DB++;

  if(isDefined(var_2) && isDefined(var_2._id_CE34)) {
    var_4 = var_2._id_CE34;
  } else {
    var_4 = 3;
  }

  if(var_0._id_E2DB >= var_4) {
    foreach(var_6 in var_3) {
      var_6 thread scripts\engine\utility::_id_5475("max_spawns_reached", 0.25);
    }
  }

  var_1 scripts\engine\utility::waittill_any_2("death", "door_infil_anim_completed");
  _id_4551(var_0, var_3);
}

_id_4551(var_0, var_1) {
  var_2 = var_0._id_E2DB;

  if(var_2 <= 0) {
    var_2 = 0;
  } else {
    var_2--;
  }

  var_0._id_E2DB = var_2;

  if(var_0._id_E2DB <= 0) {
    foreach(var_4 in var_1) {
      _id_D1E6(var_4, "door_closing");
    }
  }
}

_id_E009(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

_id_B267(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_1 endon("death");
  var_0._id_8F05 = var_2;
  var_4 = var_1 _id_0009::_id_1C7D("animscripted", var_2);
  var_5 = var_1 _id_0009::_id_1C6E("animscripted", var_4);
  var_6 = var_0.origin;
  var_7 = var_0.angles;
  var_8 = getstartorigin(var_6, var_7, var_5);
  var_9 = _func_00D2(var_6, var_7, var_5);
  var_1 dontinterpolate();
  var_1 _meth_80F9(var_8, var_9);
  var_10 = spawn("script_model", var_0.origin);
  var_10 setModel("offhand_wm_grenade_smoke");
  wait 0.2;
  var_1 _meth_85ED("animscripted", var_4);
  var_1 _meth_8019("noclip");
  var_11 = _func_0079(var_5);
  var_12 = _id_6456(var_2);

  if(isDefined(var_0._id_9508)) {
    foreach(var_14 in var_0._id_9508) {
      var_14._id_18AF = "ai_spawn_door";
      var_14 useanimtree(level._id_CC34[var_14._id_18AF]);
      var_0 thread _id_06C6::_id_1845(var_14, var_12);
    }
  } else if(isDefined(var_0._id_EEE8)) {
    foreach(var_14 in var_0._id_EEE8) {
      var_14._id_18AF = "ai_spawn_door";
      var_14 useanimtree(level._id_CC34[var_14._id_18AF]);
      var_0 thread _id_06C6::_id_1845(var_14, var_12);
    }
  } else if(isent(var_0)) {
    var_0._id_18AF = "ai_spawn_door";
    var_0 useanimtree(level._id_CC34[var_0._id_18AF]);
    var_0 thread _id_06C6::_id_1845(var_0, var_12);
  }

  wait(var_11);
  var_10 delete();
  wait 1;

  foreach(var_19 in var_3) {
    var_19 scripts\engine\utility::_id_5470("using_intro_anim");
  }
}

_id_12E8(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("ai_spawn_door_interal");
  var_0 endon("ai_spawn_door_interal");
  var_2 = "wood_door_kick";
  var_7 = _id_6456(var_1._id_1259);

  if(isDefined(level._id_CC31["ai_spawn_door"][var_7])) {
    var_8 = _func_0079(level._id_CC31["ai_spawn_door"][var_7]);
    var_9 = 0.5;
  } else {
    var_8 = 5;
    var_9 = 0.5;
  }

  var_0 thread _id_C9E9(var_0, var_2, var_7, var_8, var_9, var_6, var_3);

  if(var_0 scripts\engine\utility::_id_546E("using_intro_anim")) {
    var_0 scripts\engine\utility::_id_547B("using_intro_anim");
  }

  var_0 scripts\engine\utility::_id_5479("max_spawns_reached", 3);

  foreach(var_11 in var_3) {
    var_11 scripts\engine\utility::_id_5474("max_spawns_reached");
  }

  var_0 scripts\engine\utility::_id_5476("door_opening");
  wait 0.75;

  if(isDefined(var_2) && _func_0205(var_2)) {
    scripts\cp\utility::_id_B8EF(var_2, var_4);
  }
}

_id_C9C3(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");

  if(isDefined(var_3)) {
    var_0 thread scripts\cp\utility::_id_A669("door_infil_anim_completed", var_3);
    var_6 = max(0.05, var_3 - 0.25);
    wait(var_6);
  }

  var_0._id_0229 = 0;

  if(isDefined(var_2)) {
    [[var_2]](var_0);
  } else {
    if(var_0._id_1210 != "juggernaut") {
      var_0 _id_D232(2000);
      var_0 scripts\engine\utility::_id_5212();
      var_0 _meth_8019("normal");
    } else
      var_0 _id_D232(128);

    var_0 _id_0AED::_id_18C1();

    if(isDefined(var_0._id_E342.target)) {
      var_0 thread _id_E624();
    } else {
      var_0 thread _id_5494();
    }
  }
}

_id_C9E9(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("run_open_door_anim");
  var_0 endon("run_open_door_anim");
  var_0 scripts\engine\utility::_id_5476("door_opening");

  if(isDefined(var_0._id_17F9)) {
    var_7 = var_0._id_17F9;
  } else {
    var_7 = var_0;
  }

  if(isDefined(var_0._id_9508)) {
    foreach(var_9 in var_0._id_9508) {
      var_9._id_18AF = "ai_spawn_door";
      var_9 useanimtree(level._id_CC34[var_9._id_18AF]);
      var_7 thread _id_06C6::_id_1845(var_9, var_2);
      var_9 notify("door_opened");
    }
  } else if(isDefined(var_0._id_EEE8)) {
    foreach(var_9 in var_0._id_EEE8) {
      var_9._id_18AF = "ai_spawn_door";
      var_9 useanimtree(level._id_CC34[var_9._id_18AF]);
      var_7 thread _id_06C6::_id_1845(var_9, var_2);
      var_9 notify("door_opened");
    }
  } else if(isent(var_0)) {
    var_0._id_18AF = "ai_spawn_door";
    var_0 useanimtree(level._id_CC34[self._id_18AF]);
    var_7 thread _id_06C6::_id_1845(var_0, var_2);
    var_0 notify("door_opened");
  }

  _id_10701(var_0, var_3, var_4, var_5, var_6, var_2);
}

_id_10701(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_0 notify("wait_for_door_anim_end");
  var_0 endon("wait_for_door_anim_end");

  foreach(var_7 in var_4) {
    _id_D1E6(var_7, "opened", var_3);
  }

  wait(max(0, var_1 + 1.25));

  foreach(var_7 in var_4) {
    _id_D1E6(var_7, "closed", var_3);
  }
}

_id_7F5E() {
  if(!scripts\engine\utility::_id_5472("door_closed")) {
    scripts\engine\utility::_id_5473("door_closed");
  }

  if(!scripts\engine\utility::_id_5472("door_opened")) {
    scripts\engine\utility::_id_5473("door_opened");
  }

  if(!scripts\engine\utility::_id_5472("door_opening")) {
    scripts\engine\utility::_id_5473("door_opening");
  }

  if(!scripts\engine\utility::_id_5472("door_closing")) {
    scripts\engine\utility::_id_5473("door_closing");
  }

  if(!scripts\engine\utility::_id_5472("door_open_started")) {
    scripts\engine\utility::_id_5473("door_open_started");
  }
}

_id_D1E6(var_0, var_1, var_2) {
  var_0 _id_7F5E();
  var_0._id_419E = var_1;
  var_0 scripts\engine\utility::_id_5470("using_intro_anim");

  switch (var_1) {
    case "opening":
      var_0 scripts\engine\utility::_id_5470("door_closed");
      var_0 scripts\engine\utility::_id_5470("door_opened");
      var_0 scripts\engine\utility::_id_5474("door_opening");
      var_0 scripts\engine\utility::_id_5470("door_closing");
      var_0 scripts\engine\utility::_id_5470("door_open_started");
      break;
    case "door_closing":
      var_0 scripts\engine\utility::_id_5470("door_closed");
      var_0 scripts\engine\utility::_id_5470("door_opened");
      var_0 scripts\engine\utility::_id_5470("door_opening");
      var_0 scripts\engine\utility::_id_5474("door_closing");
      var_0 scripts\engine\utility::_id_5470("door_open_started");
      break;
    case "opened":
      var_0 scripts\engine\utility::_id_5470("door_closed");
      var_0 scripts\engine\utility::_id_5474("door_opened");
      var_0 scripts\engine\utility::_id_5470("door_opening");
      var_0 scripts\engine\utility::_id_5470("door_closing");
      var_0 scripts\engine\utility::_id_5470("door_open_started");
      break;
    case "closed":
      var_0 scripts\engine\utility::_id_5474("door_closed");
      var_0 scripts\engine\utility::_id_5470("door_opened");
      var_0 scripts\engine\utility::_id_5470("door_opening");
      var_0 scripts\engine\utility::_id_5470("door_closing");
      var_0 scripts\engine\utility::_id_5470("door_open_started");
      var_0._id_8F05 = undefined;
      var_0._id_E2DB = 0;
      var_0 scripts\engine\utility::_id_5470("max_spawns_reached");

      if(isDefined(var_2)) {
        var_2 _id_5222();
        var_2._id_4DBA = undefined;
        var_2._id_FE3F = undefined;
        var_2._id_011A = 0;
      }

      break;
    case "open_started":
      var_0 scripts\engine\utility::_id_5470("door_closed");
      var_0 scripts\engine\utility::_id_5470("door_opened");
      var_0 scripts\engine\utility::_id_5470("door_opening");
      var_0 scripts\engine\utility::_id_5470("door_closing");
      var_0 scripts\engine\utility::_id_5474("door_open_started");
      break;
  }
}

_id_64B0(var_0) {
  switch (var_0) {
    case "sdr_com_inter_ldoor_kick_ex_run_a_alt":
    case "sdr_com_inter_ldoor_kick_ex_run_a":
      return "sdr_com_inter_ldoor_kick_ex_run_b";
    case "sdr_com_inter_ldoor_kick_ex_run_b":
      return "sdr_com_inter_ldoor_kick_ex_run_c";
    case "sdr_com_inter_ldoor_kick_ex_run_c":
      return scripts\engine\utility::random(level._id_E17E);
    case "sdr_com_inter_ldoor_kick_ex_cqb_a":
      return "sdr_com_inter_ldoor_kick_ex_cqb_b";
    case "sdr_com_inter_ldoor_kick_ex_cqb_b":
      return "sdr_com_inter_ldoor_kick_ex_cqb_c";
    case "sdr_com_inter_ldoor_kick_ex_cqb_c":
      return scripts\engine\utility::random(level._id_E10D);
    case "sdr_com_inter_dbldoor_kick_ex_run_a":
      return "sdr_com_inter_dbldoor_kick_ex_run_b";
    case "sdr_com_inter_dbldoor_kick_ex_run_b":
      return "sdr_com_inter_dbldoor_kick_ex_run_c";
    case "sdr_com_inter_dbldoor_kick_ex_run_c":
      return scripts\engine\utility::random(level._id_E10D);
    case "sdr_com_inter_dbldoor_kick_ex_cqb_a":
      return "sdr_com_inter_dbldoor_kick_ex_cqb_b";
    case "sdr_com_inter_dbldoor_kick_ex_cqb_b":
      return "sdr_com_inter_dbldoor_kick_ex_cqb_c";
    case "sdr_com_inter_dbldoor_kick_ex_cqb_c":
      return scripts\engine\utility::random(level._id_E10D);
    case "sdr_com_inter_ldoor_wall_kick_ex_run_a":
      return "sdr_com_inter_ldoor_wall_kick_ex_run_b";
    case "sdr_com_inter_ldoor_wall_kick_ex_run_b":
      return "sdr_com_inter_ldoor_wall_kick_ex_run_c";
    case "sdr_com_inter_ldoor_wall_kick_ex_run_c":
      return scripts\engine\utility::random(level._id_E17E);
    case "sdr_com_inter_ldoor_wall_kick_ex_cqb_a":
      return "sdr_com_inter_ldoor_wall_kick_ex_cqb_b";
    case "sdr_com_inter_ldoor_wall_kick_ex_cqb_b":
      return "sdr_com_inter_ldoor_wall_kick_ex_cqb_c";
    case "sdr_com_inter_ldoor_wall_kick_ex_cqb_c":
      return scripts\engine\utility::random(level._id_E17E);
    case "sdr_com_inter_rdoor_wall_kick_ex_run_a":
      return "sdr_com_inter_rdoor_wall_kick_ex_run_b";
    case "sdr_com_inter_rdoor_wall_kick_ex_run_b":
      return "sdr_com_inter_rdoor_wall_kick_ex_run_c";
    case "sdr_com_inter_rdoor_wall_kick_ex_run_c":
      return scripts\engine\utility::random(level._id_E1D1);
    case "sdr_com_inter_rdoor_wall_kick_ex_cqb_a":
      return "sdr_com_inter_rdoor_wall_kick_ex_cqb_b";
    case "sdr_com_inter_rdoor_wall_kick_ex_cqb_b":
      return "sdr_com_inter_rdoor_wall_kick_ex_cqb_c";
    case "sdr_com_inter_rdoor_wall_kick_ex_cqb_c":
      return scripts\engine\utility::random(level._id_E1D1);
    case "sdr_com_inter_ldoor_wall_tac_ex_cqb_a":
      return "sdr_com_inter_ldoor_wall_tac_ex_cqb_b";
    case "sdr_com_inter_ldoor_wall_tac_ex_cqb_b":
      return "sdr_com_inter_ldoor_wall_tac_ex_cqb_c";
    case "sdr_com_inter_ldoor_wall_tac_ex_cqb_c":
      return scripts\engine\utility::random(level._id_E17E);
    case "sdr_com_inter_ldoor_tac_ex_cqb_a":
      return "sdr_com_inter_ldoor_tac_ex_cqb_b";
    case "sdr_com_inter_ldoor_tac_ex_cqb_b":
      return "sdr_com_inter_ldoor_tac_ex_cqb_c";
    case "sdr_com_inter_ldoor_tac_ex_cqb_c":
      return scripts\engine\utility::random(level._id_E17E);
    case "sdr_com_inter_rdoor_wall_tac_ex_cqb_a":
      return "sdr_com_inter_rdoor_wall_tac_ex_cqb_b";
    case "sdr_com_inter_rdoor_wall_tac_ex_cqb_b":
      return "sdr_com_inter_rdoor_wall_tac_ex_cqb_c";
    case "sdr_com_inter_rdoor_wall_tac_ex_cqb_c":
      return scripts\engine\utility::random(level._id_E1D1);
    case "sdr_com_inter_ldoor_90_pull_ex_idle_a":
      return "sdr_com_inter_ldoor_90_pull_ex_idle_b";
    case "sdr_com_inter_ldoor_90_pull_ex_idle_b":
      return "sdr_com_inter_ldoor_90_pull_ex_idle_c";
    case "sdr_com_inter_ldoor_90_pull_ex_idle_c":
      return scripts\engine\utility::random(level._id_E17E);
    case "sdr_com_inter_rdoor_90_pull_ex_idle_a":
      return "sdr_com_inter_rdoor_90_pull_ex_idle_b";
    case "sdr_com_inter_rdoor_90_pull_ex_idle_b":
      return "sdr_com_inter_rdoor_90_pull_ex_idle_c";
    case "sdr_com_inter_rdoor_90_pull_ex_idle_c":
      return scripts\engine\utility::random(level._id_E1D1);
    case "sdr_com_inter_rdoor_tac_ex_cqb_a":
      return "sdr_com_inter_rdoor_tac_ex_cqb_b";
    case "sdr_com_inter_rdoor_tac_ex_cqb_b":
      return "sdr_com_inter_rdoor_tac_ex_cqb_c";
    case "sdr_com_inter_rdoor_tac_ex_cqb_c":
      return scripts\engine\utility::random(level._id_E1D1);
    case "sdr_com_inter_ldoor_wall_shoulder_ex_run_a":
      return "sdr_com_inter_ldoor_wall_shoulder_ex_run_b";
    case "sdr_com_inter_ldoor_wall_shoulder_ex_run_b":
      return "sdr_com_inter_ldoor_wall_shoulder_ex_run_c";
    case "sdr_com_inter_ldoor_wall_shoulder_ex_run_c":
      return scripts\engine\utility::random(level._id_E17E);
    case "sdr_com_inter_ldoor_shoulder_ex_run_a":
      return "sdr_com_inter_ldoor_shoulder_ex_run_b";
    case "sdr_com_inter_ldoor_shoulder_ex_run_b":
      return "sdr_com_inter_ldoor_shoulder_ex_run_c";
    case "sdr_com_inter_ldoor_shoulder_ex_run_c":
      return scripts\engine\utility::random(level._id_E17E);
    case "sdr_com_inter_rdoor_wall_shoulder_ex_run_a":
      return "sdr_com_inter_rdoor_wall_shoulder_ex_run_b";
    case "sdr_com_inter_rdoor_wall_shoulder_ex_run_b":
      return "sdr_com_inter_rdoor_wall_shoulder_ex_run_c";
    case "sdr_com_inter_rdoor_wall_shoulder_ex_run_c":
      return scripts\engine\utility::random(level._id_E1D1);
    case "sdr_com_inter_ldoor_flash_a":
      return "sdr_com_inter_ldoor_flash_grenade";
    case "sdr_com_inter_ldoor_flash_grenade":
      return "sdr_com_inter_ldoor_flash_a";
    case "sdr_com_inter_ldoor_smoke_a":
      return "sdr_com_inter_ldoor_smoke_grenade";
    case "sdr_com_inter_ldoor_smoke_grenade":
      return "sdr_com_inter_ldoor_smoke_a";
    case "sdr_com_inter_rdoor_flash_a":
      return "sdr_com_inter_rdoor_flash_grenade";
    case "sdr_com_inter_rdoor_flash_grenade":
      return "sdr_com_inter_rdoor_flash_a";
    case "sdr_com_inter_rdoor_smoke_a":
      return "sdr_com_inter_rdoor_smoke_grenade";
    case "sdr_com_inter_rdoor_smoke_grenade":
      return "sdr_com_inter_rdoor_smoke_a";
  }
}

_id_6456(var_0) {
  if(!isDefined(var_0)) {
    return "sdr_com_inter_rdoor_wall_kick_ex_run_door";
  }

  switch (var_0) {
    case "sdr_com_inter_ldoor_90_pull_ex_idle_a":
      return "sdr_com_inter_ldoor_90_pull_ex_idle_door";
    case "sdr_com_inter_rdoor_90_pull_ex_idle_a":
      return "sdr_com_inter_rdoor_90_pull_ex_idle_door";
    case "sdr_com_inter_ldoor_kick_ex_run_a_alt":
    case "sdr_com_inter_ldoor_kick_ex_run_a":
      return "sdr_com_inter_ldoor_kick_ex_run_door";
    case "sdr_com_inter_ldoor_kick_ex_cqb_a":
      return "sdr_com_inter_ldoor_kick_ex_cqb_door";
    case "sdr_com_inter_dbldoor_kick_ex_run_a":
      return "sdr_com_inter_dbldoor_kick_ex_run_doorr";
    case "sdr_com_inter_dbldoor_kick_ex_cqb_a":
      return "sdr_com_inter_dbldoor_kick_ex_cqb_doorr";
    case "sdr_com_inter_ldoor_wall_kick_ex_run_a":
      return "sdr_com_inter_ldoor_wall_kick_ex_run_door";
    case "sdr_com_inter_ldoor_wall_kick_ex_cqb_a":
      return "sdr_com_inter_ldoor_wall_kick_ex_cqb_door";
    case "sdr_com_inter_rdoor_wall_kick_ex_run_a":
      return "sdr_com_inter_rdoor_wall_kick_ex_run_door";
    case "sdr_com_inter_rdoor_wall_kick_ex_cqb_a":
      return "sdr_com_inter_rdoor_wall_kick_ex_cqb_door";
    case "sdr_com_inter_ldoor_wall_tac_ex_cqb_a":
      return "sdr_com_inter_ldoor_wall_tac_ex_cqb_door";
    case "sdr_com_inter_ldoor_tac_ex_cqb_a":
      return "sdr_com_inter_ldoor_tac_ex_cqb_door";
    case "sdr_com_inter_rdoor_wall_tac_ex_cqb_a":
      return "sdr_com_inter_rdoor_wall_tac_ex_cqb_door";
    case "sdr_com_inter_rdoor_tac_ex_cqb_a":
      return "sdr_com_inter_rdoor_tac_ex_cqb_door";
    case "sdr_com_inter_ldoor_wall_shoulder_ex_run_a":
      return "sdr_com_inter_ldoor_wall_shoulder_ex_run_door";
    case "sdr_com_inter_ldoor_shoulder_ex_run_a":
      return "sdr_com_inter_ldoor_shoulder_ex_run_door";
    case "sdr_com_inter_rdoor_wall_shoulder_ex_run_a":
      return "sdr_com_inter_rdoor_wall_shoulder_ex_run_door";
    case "sdr_com_inter_ldoor_flash_a":
      return "sdr_com_inter_ldoor_flash_door";
    case "sdr_com_inter_ldoor_flash_grenade":
      return "sdr_com_inter_ldoor_flash_door";
    case "sdr_com_inter_ldoor_smoke_a":
      return "sdr_com_inter_ldoor_smoke_door";
    case "sdr_com_inter_ldoor_smoke_grenade":
      return "sdr_com_inter_ldoor_smoke_door";
    case "sdr_com_inter_rdoor_flash_a":
      return "sdr_com_inter_rdoor_flash_door";
    case "sdr_com_inter_rdoor_flash_grenade":
      return "sdr_com_inter_rdoor_flash_a";
    case "sdr_com_inter_rdoor_smoke_a":
      return "sdr_com_inter_rdoor_smoke_door";
    case "sdr_com_inter_rdoor_smoke_grenade":
      return "sdr_com_inter_rdoor_smoke_a";
  }

  return var_0;
}

_id_0C8A(var_0, var_1) {
  var_0.angles = var_0._id_106A8;

  if(isDefined(var_0._id_9508)) {
    _id_D1E6(var_0, "opening");

    foreach(var_3 in var_0._id_9508) {
      if(isDefined(var_3._id_3A5F)) {
        var_3._id_3A5F _meth_8093();

        if(istrue(var_1)) {
          var_3._id_3A5F delete();
        }
      }

      var_3 rotateto(var_0.angles, 0.75);
    }

    wait 0.75;
  }

  _id_D1E6(var_0, "opened");
  _id_06F4::_id_FBC9();
}

_id_0FDD(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_7038)) {
    level._id_7038 = [];
  }

  if(!isDefined(level._id_7038[var_0])) {
    level._id_7038[var_0] = [];
  }

  var_6 = [];
  var_6["function"] = var_1;
  var_6["param1"] = var_2;
  var_6["param2"] = var_3;
  var_6["param3"] = var_4;
  var_6["param4"] = var_5;
  level._id_7038[var_0][level._id_7038[var_0].size] = var_6;
}

_id_C3E5(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level._id_7038[var_0].size; var_3++) {
    if(level._id_7038[var_0][var_3]["function"] != var_1) {
      var_2[var_2.size] = level._id_7038[var_0][var_3];
    }
  }

  level._id_7038[var_0] = var_2;
}

_id_5731(var_0, var_1) {
  if(!isDefined(level._id_7038)) {
    return 0;
  }

  for(var_2 = 0; var_2 < level._id_7038[var_0].size; var_2++) {
    if(level._id_7038[var_0][var_2]["function"] == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_803B() {
  var_0 = spawnStruct();
  var_0._id_7926 = undefined;
  var_0._id_98B6 = undefined;
  var_0._id_E254 = 5;
  var_0._id_10CAB = 15;
  var_0._id_9E99 = 0;
  var_0._id_9C0E = 48;
  var_0._id_10CB0 = 1;
  var_0._id_4A6A = 0;
  self._id_AEA5 = var_0;
}

_id_AD40(var_0) {
  if(!scripts\engine\utility::array_contains(self._id_10CAC, var_0)) {
    self._id_10CAC[self._id_10CAC.size] = var_0;
  }
}

_id_C42A(var_0) {
  if(scripts\engine\utility::array_contains(self._id_10CAC, var_0)) {
    self._id_10CAC = scripts\engine\utility::array_remove(self._id_10CAC, var_0);
  }
}

_id_1022(var_0) {
  if(!scripts\engine\utility::array_contains(self._id_C56D, var_0)) {
    var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

    if(var_1.size > 0) {
      self._id_C56D[self._id_C56D.size] = var_0;
      scripts\engine\utility::_id_1BE2(var_1, ::_id_E2CD);
    }
  }
}

_id_C44E(var_0) {
  if(scripts\engine\utility::array_contains(self._id_C56D, var_0)) {
    self._id_C56D = scripts\engine\utility::array_remove(self._id_C56D, var_0);
  }
}

_id_106D(var_0) {
  if(!scripts\engine\utility::array_contains(self._id_C570, var_0)) {
    var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

    if(var_1.size > 0) {
      self._id_C570[self._id_C570.size] = var_0;
      scripts\engine\utility::_id_1BE2(var_1, ::_id_E2CD);
    }
  }
}

_id_C459(var_0) {
  if(scripts\engine\utility::array_contains(self._id_C570, var_0)) {
    self._id_C570 = scripts\engine\utility::array_remove(self._id_C570, var_0);
  }
}

_id_D2E1(var_0) {
  if(isDefined(self._id_AEA5)) {
    self._id_AEA5._id_7926 = var_0;
  }
}

_id_101F(var_0, var_1, var_2) {
  var_1 = _id_4633(var_1, 1024);
  var_2 = _id_4633(var_2, 2048);
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = (0, 0, 0);
  var_3._id_0359 = var_1;
  var_3._id_0F08 = var_2 * var_2;
  self._id_E1E3[self._id_E1E3.size] = var_3;
}

_id_C44D(var_0) {
  var_1 = self._id_E1E3;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2].origin == var_0) {
      self._id_E1E3 = scripts\engine\utility::array_remove(var_1, var_1[var_2]);
    }
  }
}

_id_3EC5(var_0, var_1) {
  if(!isDefined(self._id_13F3)) {
    self._id_13F3 = [];
    self._id_13F5 = [];
    self._id_13F4 = 0;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    self._id_13F3[self._id_13F3.size] = var_0[var_2];
    var_3 = _id_4633(var_1[var_2], 10);
    self._id_13F5[self._id_13F5.size] = var_3;
    self._id_13F4 = self._id_13F4 + var_3;
  }
}

_id_C372(var_0) {
  if(isDefined(self._id_13F3)) {
    var_1 = self._id_13F3;
    var_2 = self._id_13F5;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3] == var_0) {
        self._id_13F3 = scripts\engine\utility::array_remove(var_1, var_1[var_3]);
        self._id_13F5 = scripts\engine\utility::array_remove_index(var_2, var_3);
        self._id_13F4 = self._id_13F4 - var_2[var_3];
      }
    }
  }
}

_id_663D(var_0, var_1) {
  if(getdvarint("#x36f754e78b977f4cd", -1) != -1) {
    return getdvarint("#x36f754e78b977f4cd");
  }

  if(isDefined(self._id_AEA5) && isDefined(self._id_AEA5._id_7926)) {
    return self._id_AEA5._id_7926;
  } else {
    if(isDefined(var_1)) {
      return _id_BD55(var_0, var_1);
    }

    return undefined;
  }
}

_id_D2E2(var_0) {
  if(isDefined(self._id_AEA5)) {
    self._id_AEA5._id_98B6 = var_0;
  }
}

_id_663E(var_0, var_1) {
  if(getdvarint("#x3c6c7a78d09f8cf89", -1) != -1) {
    return getdvarint("#x3c6c7a78d09f8cf89");
  }

  if(isDefined(self._id_AEA5) && isDefined(self._id_AEA5._id_98B6)) {
    return self._id_AEA5._id_98B6;
  } else {
    if(isDefined(var_1)) {
      return _id_BD55(var_0, var_1);
    }

    return undefined;
  }
}

_id_D2DF(var_0) {
  if(isDefined(self._id_AEA5)) {
    self._id_AEA5._id_E254 = var_0;
  }
}

_id_663C(var_0) {
  if(getdvarint("#x3dfcac8cc18b7e177", 0) != 0) {
    return getdvarint("#x3dfcac8cc18b7e177");
  }

  if(isDefined(self._id_AEA5) && isDefined(self._id_AEA5._id_E254)) {
    return self._id_AEA5._id_E254;
  } else {
    return 5;
  }
}

_id_D2E3(var_0) {
  if(isDefined(self._id_AEA5)) {
    self._id_AEA5._id_10CAB = var_0;
  }
}

_id_663F(var_0) {
  if(getdvarint("#x3fe5e21af7fa522c8", -1) != -1) {
    return getdvarint("#x3fe5e21af7fa522c8");
  }

  if(isDefined(self._id_F226)) {
    return self._id_F226;
  }

  if(isDefined(self._id_AEA5) && isDefined(self._id_AEA5._id_10CAB)) {
    return self._id_AEA5._id_10CAB;
  } else {
    return 15;
  }
}

_id_D147(var_0) {
  if(isDefined(self._id_AEA5)) {
    self._id_AEA5._id_9E99 = var_0;
  }
}

_id_6347(var_0, var_1) {
  if(getdvarint("#x3c36ed0a3906233db", -1) != -1) {
    return getdvarint("#x3c36ed0a3906233db");
  }

  if(isDefined(self._id_AEA5) && isDefined(self._id_AEA5._id_9E99)) {
    return self._id_AEA5._id_9E99;
  } else {
    return var_1;
  }
}

_id_D146(var_0) {
  if(isDefined(self._id_AEA5)) {
    self._id_AEA5._id_9C0E = var_0;
  }
}

_id_6346(var_0, var_1) {
  if(getdvarint("#x399040ec4278fcaa5", -1) != -1) {
    return getdvarint("#x399040ec4278fcaa5");
  }

  if(isDefined(self._id_AEA5) && isDefined(self._id_AEA5._id_9C0E)) {
    return self._id_AEA5._id_9C0E;
  } else {
    return var_1;
  }
}

_id_6769(var_0, var_1) {
  if(isDefined(self._id_10CB0)) {
    return self._id_10CB0;
  } else {
    return var_1;
  }
}

_id_6832(var_0, var_1) {
  if(isDefined(var_0._id_9E99)) {
    return int(var_0._id_9E99);
  } else {
    return var_1;
  }
}

_id_6831(var_0) {
  if(isDefined(var_0._id_7926)) {
    return int(var_0._id_7926);
  } else {
    return int(var_0._id_E24A);
  }
}

_id_642D() {
  if(isDefined(level._id_5BC1)) {
    var_0 = level._id_5BC1;
    level._id_5BC1 = undefined;
    return var_0;
  } else if(isDefined(self._id_10CA6)) {
    var_0 = self._id_10CA6;
    self._id_10CA6 = undefined;
    return var_0;
  } else if(isDefined(self._id_10CA5))
    return self._id_10CA5;
  else {
    return undefined;
  }
}

_id_D440(var_0) {
  if(_id_8635("wave_spawning")) {
    _id_C9CE("wave_spawning", [::_id_107B, var_0]);
    var_1 = _id_65B4("wave_spawning");

    if(isDefined(var_1) && var_1.size > 0) {
      var_1[0] thread _id_0771::_id_E672();
    }
  } else {
    level._id_5BC1 = var_0;
    var_1 = _id_C9FD("wave_spawning");
  }

  return var_1;
}

_id_107B(var_0, var_1) {
  level notify("timeout_wave");
  var_0 notify("wave_spawn");
  var_0 notify("wave_go_kamikaze");
  _id_F2C1("wave_spawning", undefined, "new_wave_starting");
  _id_F2C1("wave_paratroopers", undefined, "new_wave_starting");
  _id_C9CE("wave_spawning", [::_id_F2C3, undefined]);
  _id_D442("wave_spawning", var_1, var_0._id_10CA5, var_0._id_8F76);
  var_0._id_A48E = var_1;
  var_0._id_10CA6 = var_1;
}

_id_8635(var_0) {
  return isDefined(level._id_0F2F[var_0]);
}

_id_3917() {
  self._id_10CA6 = undefined;
}

_id_6833() {
  if(getdvarint("#x35e52d1abcb1ecaf2", 0) != 0) {
    return getdvarint("#x35e52d1abcb1ecaf2");
  }

  if(isDefined(self._id_10C98)) {
    return self._id_10C98;
  } else {
    return undefined;
  }
}

_id_65B4(var_0, var_1) {
  var_2 = [];

  if(!_func_0107(var_0)) {
    var_0 = [var_0];
  }

  if(istrue(var_1)) {
    var_3 = getarraykeys(level._id_E197);
    var_4 = level._id_E197;
  } else {
    var_3 = getarraykeys(level._id_0F2F);
    var_4 = level._id_0F2F;
  }

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_3[var_5]];

    if(_func_0107(var_6)) {
      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];

        for(var_9 = 0; var_9 < var_0.size; var_9++) {
          if(var_8._id_7218 == var_0[var_9]) {
            var_2[var_2.size] = var_8;
          }
        }
      }

      continue;
    }

    for(var_9 = 0; var_9 < var_0.size; var_9++) {
      if(var_6._id_7218 == var_0[var_9]) {
        var_2[var_2.size] = var_6;
      }
    }
  }

  return var_2;
}

_id_C373() {
  _id_C372("civ");
  _id_C372("suits");
  _id_C372("goliath");
  _id_C372("goliath_bomber");
  _id_C372("goliath_rpg");
  _id_C372("smg");
  _id_C372("hvt");
  _id_C372("ar");
  _id_C372("shotgun");
  _id_C372("juggernaut");
  _id_C372("suicidebomber");
  _id_C372("rpg");
  _id_C372("lmg");
  _id_C372("sniper");
  _id_C372("suicidebomber");
  _id_C372("informant");
}

_id_DC1F() {
  level endon("game_ended");
  self endon("death");
  self endon("show_all_player_wave_started_splash");

  if(_id_871B() || scripts\cp\utility::_id_871A()) {
    level notify("wave_starting");

    if(!isDefined(level._id_4B75)) {
      level._id_4B75 = 1;
    } else {
      level._id_4B75 = level._id_4B75 + 1;
    }

    setomnvar("cp_wave_number", level._id_4B75);

    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      level.players[var_0] thread scripts\cp\cp_hud_message::showsplash("cp_wave_started", level._id_4B75, undefined);
      level.players[var_0] setplayerdata("cp", "alienSession", "waveNum", level._id_4B75);
    }
  }

  wait 2;
}

_id_871B() {
  return !istrue(self._id_4A6A);
}

_id_D441() {
  if(isDefined(level._id_10CAE)) {
    var_0 = level._id_10CAE;
  } else if(getDvar("#x3a30c33efc8281eb1") == "cp_wave_sv") {
    var_0 = "cp/" + getDvar("#x36d16f02578d0ee10") + "_wave_table.csv";
  } else {
    var_0 = "cp/cp_donetsk_wave_table.csv";
  }

  if(getdvarint("#x37313a208b01b2b77", 1) && _func_0221(var_0)) {
    var_1 = var_0;
    var_2 = "wave_spawning";

    if(isDefined(level._id_E197[var_2])) {
      for(var_3 = 0; var_3 < level._id_E197[var_2].size; var_3++) {
        var_4 = level._id_E197[var_2][var_3];
        var_5 = var_4 _id_642D();
        var_4._id_FF34 = [];
        var_4._id_FF34["lbravo_carrier"] = int(_func_0222(var_1, 0, var_5, 15));
        var_4._id_FF34["mindia8"] = int(_func_0222(var_1, 0, var_5, 16));
        var_4._id_FF34["mindia8_jugg"] = int(_func_0222(var_1, 0, var_5, 17));
        var_4._id_FF34["attack_heli"] = int(_func_0222(var_1, 0, var_5, 19));

        if(scripts\engine\utility::_id_1BE1(var_4._id_FF34) > 0) {
          var_4._id_10CB1 = 1;
        }

        var_4._id_E0B6 = [];
        var_4._id_E0B6["ar"] = int(_func_0222(var_1, 0, var_5, 1));
        var_4._id_E0B6["ar_heavy"] = int(_func_0222(var_1, 0, var_5, 2));
        var_4._id_E0B6["ar_heavy_laser"] = int(_func_0222(var_1, 0, var_5, 3));
        var_4._id_E0B6["smg"] = int(_func_0222(var_1, 0, var_5, 4));
        var_4._id_E0B6["smg_heavy"] = int(_func_0222(var_1, 0, var_5, 5));
        var_4._id_E0B6["shotgun"] = int(_func_0222(var_1, 0, var_5, 6));
        var_4._id_E0B6["shotgun_heavy"] = int(_func_0222(var_1, 0, var_5, 7));
        var_4._id_E0B6["rpg"] = int(_func_0222(var_1, 0, var_5, 8));
        var_4._id_E0B6["lmg"] = int(_func_0222(var_1, 0, var_5, 9));
        var_4._id_E0B6["lmg_heavy"] = int(_func_0222(var_1, 0, var_5, 10));
        var_4._id_E0B6["sniper"] = int(_func_0222(var_1, 0, var_5, 11));
        var_4._id_E0B6["goliath"] = int(_func_0222(var_1, 0, var_5, 12));
        var_4._id_E0B6["suicidebomber"] = int(_func_0222(var_1, 0, var_5, 13));
        var_4._id_E0B6["juggernaut"] = int(_func_0222(var_1, 0, var_5, 14));
        var_4._id_E0B6 = var_4 _id_C3F7();
        var_4._id_10C93 = int(_func_0222(var_1, 0, var_5, 22));
        var_4._id_7926 = int(_func_0222(var_1, 0, var_5, 23));
        var_4._id_9E99 = int(_func_0222(var_1, 0, var_5, 24));
        var_4._id_A486 = int(_func_0222(var_1, 0, var_5, 25));
        var_4._id_F226 = int(_func_0222(var_1, 0, var_5, 26));
        var_4._id_A48E = _func_0222(var_1, 0, var_5, 29);
        var_4._id_FDEC = int(_func_0222(var_1, 0, var_5, 32));
        var_4._id_AE51 = int(_func_0222(var_1, 0, var_5, 20));
        var_4._id_10C90 = int(_func_0222(var_1, 0, var_5, 21));
        var_6 = float(_func_0222(var_1, 0, var_5, 30));
        var_4._id_10CB0 = scripts\engine\utility::ter_op(var_6 > 0, var_6, 1);

        if(scripts\cp\utility::_id_871A()) {
          var_4._id_4A6A = int(_func_0222(var_1, 0, var_5, 31));
        } else {
          var_4._id_4A6A = 1;
        }

        var_4._id_E24A = scripts\engine\utility::_id_1BE1(var_4._id_E0B6) + var_4._id_AE51 * 8;
        var_4._id_F364 = 0;
        var_4._id_C56D = [];
        var_7 = strtok(_func_0222(var_1, 0, var_5, 27), ",");

        if(isDefined(var_7) && var_7.size > 0) {
          for(var_8 = 0; var_8 < var_7.size; var_8++) {
            var_4 _id_1022(var_7[var_8]);
          }
        }

        var_4._id_C570 = [];
        var_7 = strtok(_func_0222(var_1, 0, var_5, 28), ",");

        if(isDefined(var_7) && var_7.size > 0) {
          for(var_8 = 0; var_8 < var_7.size; var_8++) {
            var_4 _id_106D(var_7[var_8]);
          }
        }
      }
    }
  }
}

_id_3D5E(var_0, var_1) {
  if(isDefined(level._id_E197[var_1])) {
    var_2 = level._id_E197[var_1][0];
    var_0._id_7926 = var_2._id_7926;
    var_0._id_A486 = var_2._id_A486;
    var_0._id_9E99 = var_2._id_9E99;
    var_0._id_4A6A = var_2._id_4A6A;
  } else
    var_0._id_E24A = var_0._id_F381;
}

_id_6341(var_0) {
  var_1 = [];

  if(isDefined(self._id_CEA3) && isDefined(var_0) && _func_0107(var_0) && var_0.size > 0) {
    if(!_func_0107(self._id_CEA3)) {
      var_2 = strtok(self._id_CEA3, ",");
      self._id_CEA3 = [];

      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        self._id_CEA3[self._id_CEA3.size] = var_2[var_3];
      }
    }

    for(var_3 = 0; var_3 < self._id_CEA3.size; var_3++) {
      if(scripts\engine\utility::array_contains(var_0, self._id_CEA3[var_3])) {
        var_1[var_1.size] = self._id_CEA3[var_3];
      }
    }

    return var_1;
  } else
    return var_0;
}

_id_6342() {
  var_0 = [];
  var_1 = getarraykeys(self._id_FF34);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(self._id_FF34[var_1[var_2]] > 0) {
      var_0[var_0.size] = var_1[var_2];
    }
  }

  if(var_0.size > 0) {
    return var_0;
  } else {
    return undefined;
  }
}

_id_C3F7() {
  var_0 = getarraykeys(self._id_E0B6);

  for(var_1 = 0; var_1 < level._id_E197[self._id_7218].size; var_1++) {
    var_2 = level._id_E197[self._id_7218][var_1];

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(isDefined(var_2._id_E0B6[var_4]) && var_2._id_E0B6[var_4] < 1) {
        var_2._id_E0B6[var_4] = undefined;
      }
    }
  }

  return self._id_E0B6;
}