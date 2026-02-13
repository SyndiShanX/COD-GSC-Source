/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1976.gsc
*************************************************/

_id_BD6B(var_0, var_1, var_2) {
  if(var_1 >= 0 && isDefined(level._id_2FFD._id_33F6)) {
    var_3 = level._id_2FFD._id_33F6[var_1].origin;
    var_4 = level._id_2FFD._id_33F6[var_1].angles;

    if(isDefined(level._id_AD48)) {
      var_1 = level._id_AD48 - 1;
    }
  } else {
    var_3 = level._id_33FC.origin;
    var_4 = level._id_33FC.angles;
    var_1 = 0;
  }

  if(_id_EF2D(var_1)) {
    return;
  }
  _id_BD81(var_0);
  _id_476B(var_1);
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = 0;
  var_14 = 0;
  var_15 = [];
  var_16 = [];
  var_17 = [];
  var_18 = [];
  var_19 = [];
  var_20 = 0;
  var_21 = 0;
  var_22 = [];
  var_23 = [];
  var_24 = [];
  var_25 = [];
  var_26 = 0;
  var_27 = [];
  var_28 = 0;

  switch (var_0) {
    case "IW7_mp_taunt_ftl_1st_kills_456":
      if(var_2 && (!isDefined(level._id_98A1) || level._id_98A1 == 1)) {
        var_7[0] = 10.0;
        var_23[0] = 0.85;
        var_23[1] = 2.05;
        var_23[2] = 1.15;
        level._id_98A1 = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_2nd_kills_456":
      if(var_2 && (!isDefined(level._id_98A1) || level._id_98A1 == 1)) {
        var_7[0] = 10.0;
        var_23[0] = 1.1;
        var_23[1] = 2.7;
        var_23[2] = 1.467;
        level._id_98A1 = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_3rd_kills_456":
      if(var_2 && (!isDefined(level._id_98A1) || level._id_98A1 == 1)) {
        var_7[0] = 10.0;
        var_23[0] = 1.03;
        var_23[1] = 2.76;
        var_23[2] = 1.43;
        level._id_98A1 = 0;
      }

      break;
    case "IW7_mp_taunt_cod_champs":
      var_7[0] = 7.834;
      break;
    case "iw7_mp_taunt_super_blackhole":
      var_7[0] = 7.0;

      for(var_29 = 0; var_29 < 20; var_29++) {
        var_22[var_29] = 2.6 + var_29 * 0.1;
      }

      break;
    case "iw7_mp_taunt_epic_grenade_toss_back01":
      var_7[0] = 8.0;
      var_22[0] = 5.7;
      var_22[1] = 6.15;
      var_22[2] = 6.6;
      break;
    case "iw7_mp_taunt_super_warfighter_at_screen":
      var_7[0] = 6.6;
      var_22[0] = 1.0;
      var_22[1] = 1.2;
      var_22[2] = 1.4;
      var_22[3] = 1.6;
      var_22[4] = 1.8;
      var_22[5] = 2.0;
      var_22[6] = 2.2;
      var_22[7] = 2.4;
      break;
    case "iw7_mp_taunt_bio_spike":
      var_7[0] = 6.6;
      var_22[0] = 1.65;
      var_22[1] = 2.05;
      break;
    case "iw7_mp_taunt_synaptic_reaper_2nd":
    case "iw7_mp_taunt_synaptic_reaper":
    case "iw7_mp_taunt_synaptic_reaper_3rd":
      var_7[0] = 6.6;
      var_21 = 2.0;
      break;
    case "iw7_mp_taunt_killstreak_scorcher":
      var_5[0] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_6[0] = "iw7_mp_taunt_killstreak_scorcher_scorcher01";
      var_7[0] = 6.6;
      var_5[1] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_6[1] = "iw7_mp_taunt_killstreak_scorcher_scorcher02";
      var_7[1] = 6.6;
      var_5[2] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_6[2] = "iw7_mp_taunt_killstreak_scorcher_scorcher03";
      var_7[2] = 6.6;
      var_21 = 3.0;
      var_28 = 1;
      break;
    case "iw7_mp_taunt_killstreak_c8":
      var_5[0] = "mp_robot_c8";
      var_6[0] = "iw7_mp_taunt_killstreak_c8_robot";
      var_7[0] = 5.5;
      var_8[0] = [];
      var_8[0][0] = "weapon_c8_shield_top_mp";
      var_8[0][1] = "weapon_c8_shield_bottom_mp";
      var_9[0] = [];
      var_9[0][0] = "j_wristshield";
      var_9[0][1] = "j_wristbtmshield";
      var_21 = 1.67;
      var_22[0] = 5.15;
      break;
    case "IW7_mp_taunt_killstreak_apex01":
      var_5[0] = "veh_mil_air_ca_oblivion_drone_mp";
      var_6[0] = "IW7_mp_taunt_killstreak_apex01_apex";
      var_7[0] = 5.0;
      var_22[0] = 2.0;
      var_22[1] = 2.4;
      var_22[2] = 2.6;
      var_22[3] = 3.2;
      var_22[4] = 3.6;
      var_22[5] = 3.8;
      break;
    case "iw7_mp_taunt_killstreak_thor":
      var_5[0] = "veh_mil_air_thor_wm";
      var_5[1] = "sdf_mp_cruise_missile_01";
      var_5[2] = "un_mp_jackal_exterior_missile";
      var_5[3] = "un_mp_jackal_exterior_missile";
      var_5[4] = "un_mp_jackal_exterior_missile";
      var_5[5] = "un_mp_jackal_exterior_missile";
      var_5[6] = "un_mp_jackal_exterior_missile";
      var_6[0] = "iw7_mp_taunt_killstreak_thor_prop";
      var_6[1] = "iw7_mp_taunt_killstreak_thor_missile01";
      var_6[2] = "iw7_mp_taunt_killstreak_thor_missile02";
      var_6[3] = "iw7_mp_taunt_killstreak_thor_missile03";
      var_6[4] = "iw7_mp_taunt_killstreak_thor_missile04";
      var_6[5] = "iw7_mp_taunt_killstreak_thor_missile05";
      var_6[6] = "iw7_mp_taunt_killstreak_thor_missile05";
      var_7[0] = 7.47;
      var_7[1] = 3.76;
      var_7[2] = 4.7;
      var_7[3] = 4.7;
      var_7[4] = 4.7;
      var_7[5] = 4.7;
      var_7[6] = 4.7;
      var_13 = 1;
      var_14 = 1.5;
      var_21 = 4.5;
      var_28 = 1;
      break;
    case "IW7_mp_taunt_adrenaline":
      var_5[0] = "equipment_mp_nanoshot_wm";
      var_6[0] = "IW7_mp_taunt_adrenaline_nano";
      var_7[0] = 10.0;
      var_22[0] = 7.5;
      break;
    case "iw7_mp_taunt_super_shootdown":
      var_5[0] = "veh_mil_air_un_uav";
      var_6[0] = "iw7_mp_taunt_super_shootdown_uav";
      var_7[0] = 6.0;
      var_22[0] = 3.75;
      break;
    case "IW7_mp_taunt_phantom_cloak_2nd":
    case "IW7_mp_taunt_phantom_cloak_3rd":
    case "IW7_mp_taunt_phantom_cloak":
      var_10[0] = "cloak";
      var_11[0] = "on";
      var_12[0] = 0.01;
      var_10[1] = "cloak";
      var_11[1] = "off";
      var_12[1] = 1.5;
      var_10[2] = "cloak";
      var_11[2] = "on";
      var_12[2] = 3.2;
      var_10[3] = "cloak";
      var_11[3] = "off";
      var_12[3] = 4.7;
      var_7[0] = 5.1;
      var_13 = 1;
      var_14 = 2.0;
      break;
    case "iw7_mp_taunt_super_merc_steeldragon":
      var_15[0] = 0.466;
      var_16[0] = 2.85;
      var_17[0] = "tag_accessory_right";
      var_18[0] = "tag_accessory_left";
      var_19[0] = "vfx_taunt_steel_dragon";
      var_7[0] = 4.0;
      var_22[0] = 0.5;
      var_22[1] = 0.7;
      var_22[2] = 0.9;
      var_22[3] = 1.0;
      var_22[4] = 1.2;
      var_22[5] = 1.4;
      var_22[6] = 1.6;
      var_22[7] = 1.8;
      var_22[8] = 2.0;
      var_22[9] = 2.2;
      var_22[10] = 2.4;
      var_22[11] = 2.7;
      var_22[12] = 2.9;
      var_22[13] = 3.1;
      break;
    case "iw7_mp_taunt_killstreak_laser_strike":
      var_7[0] = 12.0;
      var_24[0] = "vfx_bombard_antigrav_pre_expl";
      var_24[1] = "vfx_bombard_projectile_trail";
      var_26 = 0.2;
      var_25[0] = (0, 80, 0);
      var_25[1] = (75, 140, 0);
      var_25[2] = (-165, 250, 0);
      var_25[3] = (50, 200, 0);
      var_25[4] = (155, 250, 0);
      var_25[5] = (-75, 140, 0);
      var_25[6] = (-50, 200, 0);
      var_27[0] = 1.0;
      var_27[1] = 1.0;
      var_27[2] = 3.5;
      var_22[0] = 3.5;
      var_22[1] = 3.7;
      var_22[2] = 3.9;
      var_22[3] = 4.1;
      var_22[4] = 4.3;
      var_22[5] = 4.5;
      var_22[6] = 4.7;
      var_22[7] = 4.9;
      break;
    default:
      return;
  }

  level._id_2C24[var_1] = [];
  level._id_2C25[var_1] = [];

  if(var_2 && var_13) {
    if(!isDefined(level._id_BED1)) {
      level._id_BED1 = [];
    }

    if(isDefined(level._id_BED1[var_0])) {
      var_30 = gettime() - level._id_BED1[var_0];

      if(var_30 < var_14 * 1000) {
        wait(var_14 - var_30 / 1000);
      }
    }

    level._id_BED1[var_0] = gettime();
  }

  var_31 = (0, 0, 0);

  if(var_28 && isDefined(level._id_FDA9) && level._id_FDA9 == 1) {
    var_31 = (180, 180, 0);
  }

  for(var_29 = 0; var_29 < var_5.size; var_29++) {
    var_32 = spawn("script_model", var_3);
    var_32 setModel(var_5[var_29]);
    var_32.angles = var_4 + var_31;
    var_32 notsolid();
    var_32 dontinterpolate();
    var_32 _meth_82CC(var_6[var_29]);

    if(!isDefined(level._id_2C24)) {
      level._id_2C24 = [];
    }

    level._id_2C24[var_1][var_29] = var_32;

    if(!(isDefined(var_8[var_29]) && _func_0107(var_8[var_29]))) {
      continue;
    }
    level._id_2C25[var_1] = [];

    for(var_33 = 0; var_33 < var_8[var_29].size; var_33++) {
      var_34 = spawn("script_model", var_3);
      var_34 setModel(var_8[var_29][var_33]);
      var_34.angles = var_4 + var_31;
      var_34 notsolid();
      var_34 dontinterpolate();
      var_34 linkto(var_32, var_9[var_29][var_33], (0, 0, 0), (0, 0, 0));
      level._id_2C25[var_1][var_33] = var_34;
    }
  }

  var_35 = 0;

  for(var_29 = 0; var_29 < var_7.size; var_29++) {
    var_35 = max(var_35, var_7[var_29]);
  }

  for(var_29 = 0; var_29 < var_10.size; var_29++) {
    thread _id_4C70(var_2, var_1, var_10[var_29], var_11[var_29], var_12[var_29]);
  }

  if(var_2 == 0) {
    var_36 = _id_6C46(-1);
  } else {
    var_36 = _id_6C46(var_1);
  }

  if(var_2 != 0) {
    for(var_29 = 0; var_29 < var_15.size; var_29++) {
      thread _id_B36C(var_15[var_29], var_16[var_29], var_19[var_29], var_17[var_29], var_18[var_29], var_36);
    }
  }

  if(var_2 != 0 && var_20 > 0) {
    thread _id_4E70(var_20);
  }

  if(var_2 != 0 && var_21 > 0) {
    thread _id_4C6C(var_21, 1);
  }

  for(var_29 = 0; var_29 < var_22.size; var_29++) {
    thread _id_4C6C(var_22[var_29], 0);
  }

  for(var_29 = 0; var_29 < var_23.size; var_29++) {
    thread _id_4C68(var_23[var_29], var_29);
  }

  for(var_29 = 0; var_29 < var_25.size; var_29++) {
    var_37 = anglesToForward(level._id_2FFD._id_22B1.angles);
    var_38 = vectornormalize((var_37[0], var_37[1], 0));
    var_39 = _func_025B(var_38, (0, 0, 1));
    var_40 = var_38 * var_25[var_29][1];
    var_41 = var_39 * var_25[var_29][0];
    var_42 = var_40 + var_41;

    if(var_2 != 0) {
      var_43 = level._id_2FFD._id_33F6[0].origin;
    } else {
      var_43 = var_3;
    }

    for(var_33 = 0; var_33 < var_24.size; var_33++) {
      thread _id_4E7D(var_24[var_33], var_27[var_33] + var_26 * var_29, var_42, var_43);
    }
  }

  thread _id_3881(var_1, var_35, var_0);
}

_id_4E7D(var_0, var_1, var_2, var_3) {
  self endon("cancel_taunt_cleanup");
  wait(var_1);
  var_4 = var_3 + var_2;
  var_5 = spawnfx(level._effect[var_0], var_4);

  if(isDefined(var_5)) {
    triggerfx(var_5);
    var_5 thread _id_46CB(12.0);
  }
}

_id_46CB(var_0) {
  self endon("cancel_taunt_cleanup");
  wait(var_0);

  if(isDefined(self)) {
    self delete();
  }
}

_id_4C68(var_0, var_1) {
  self endon("cancel_taunt_cleanup");
  wait(var_0);

  if(isDefined(level._id_F348[var_1 + 3])) {
    level._id_F348[var_1 + 3]._id_2BF3 hide(1);
  }
}

_id_B36C(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("cancel_taunt_cleanup");
  wait(var_0);
  var_6 = _func_0312(level._effect[var_2], var_5, var_3, var_5, var_4);
  thread _id_3873(var_6, var_1);
}

_id_3873(var_0, var_1) {
  _id_108F5("cancel_taunt_cleanup", var_1);
  var_0 delete();
}

_id_108F5(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

_id_4C6C(var_0, var_1) {
  self endon("cancel_taunt_cleanup");

  if(!isDefined(level.players)) {
    return;
  }
  wait(var_0);

  foreach(var_3 in level.players) {
    if(isbot(var_3)) {
      continue;
    }
    if(var_1) {
      var_3 earthquakeforplayer(0.5, 0.65, var_3.origin, 1000);
      continue;
    }

    var_3 earthquakeforplayer(0.15, 0.25, var_3.origin, 1000);
  }
}

_id_4E70(var_0) {
  self endon("cancel_taunt_cleanup");
  wait(var_0);

  foreach(var_2 in level.players) {
    if(isbot(var_2)) {
      continue;
    }
  }
}

_id_6C46(var_0) {
  if(var_0 == -1) {
    var_1 = level._id_33FC;
  } else {
    var_1 = level._id_F348[var_0]._id_2BF3;
  }

  return var_1;
}

_id_4C70(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == 0) {
    var_1 = -1;
  }

  self endon("cancel_taunt_cleanup");
  thread _id_9543(var_1, var_2);
  wait(var_4);
  var_5 = _id_6C46(var_1);

  if(!isDefined(var_5)) {
    return;
  }
  var_5 setscriptablepartstate(var_2, var_3, 0);
}

_id_9543(var_0, var_1) {
  self waittill("cancel_taunt_cleanup");
  var_2 = _id_6C46(var_0);
  var_2 setscriptablepartstate(var_1, "offImmediate", 0);
}

_id_C69C() {
  var_0 = level._id_33FC.angles;
  var_1 = level._id_33FC.origin;
  level._id_33FC delete();
  level._id_33FC = spawn("script_character", var_1, 0, 0, 1, "MPClientCharacter");
  level._id_33FC.angles = var_0;
  _id_476B(0);

  if(isDefined(level._id_8F6C)) {
    self _meth_83EF(level._id_8F6C);

    if(_func_0205(level._id_8F6C + "_lsrs")) {
      self _meth_83EF(level._id_8F6C + "_lsrs");
    }

    if(_func_0205(level._id_8F6C + "_lfe")) {
      self _meth_83EF(level._id_8F6C + "_lfe");
    }

    level._id_8F6C = undefined;
  }
}

_id_EF2D(var_0) {
  return isDefined(level._id_2C24) && _func_0107(level._id_2C24) && isDefined(level._id_2C24[var_0]) && level._id_2C24[var_0].size > 0;
}

_id_3881(var_0, var_1, var_2) {
  self endon("cancel_taunt_cleanup");
  wait(var_1);
  level._id_EF2F = 1;
  _id_476B(var_0);
}

_id_476B(var_0) {
  if(_id_EF2D(var_0)) {
    for(var_1 = 0; var_1 < level._id_2C24[var_0].size; var_1++) {
      if(isDefined(level._id_2C24[var_0][var_1])) {
        level._id_2C24[var_0][var_1] _meth_82CA();
        level._id_2C24[var_0][var_1] delete();
      }
    }

    level._id_2C24[var_0] = [];

    if(isDefined(level._id_2C25[var_0]) && _func_0107(level._id_2C25[var_0])) {
      for(var_1 = 0; var_1 < level._id_2C25[var_0].size; var_1++) {
        if(isDefined(level._id_2C25[var_0][var_1])) {
          level._id_2C25[var_0][var_1] _meth_82CA();
          level._id_2C25[var_0][var_1] delete();
        }
      }

      level._id_2C25[var_0] = [];
    }
  }

  self notify("cancel_taunt_cleanup");
}

_id_BD81(var_0) {
  if(!_func_0205(var_0)) {
    return;
  }
  if(!isDefined(level._id_EF2F)) {
    level._id_EF2F = 0;
  }

  if(!isDefined(level._id_EF30)) {
    level._id_EF30 = [];
  }

  if(_func_0205(var_0)) {
    if(isDefined(level._id_8F6C)) {
      self _meth_83EF(level._id_8F6C);

      if(_func_0205(level._id_8F6C + "_lsrs")) {
        self _meth_83EF(level._id_8F6C + "_lsrs");
      }

      if(_func_0205(level._id_8F6C + "_lfe")) {
        self _meth_83EF(level._id_8F6C + "_lfe");
      }

      level._id_8F6C = undefined;
    }

    _id_B39C(var_0);
    level._id_EF30[level._id_EF30.size] = var_0;
    level._id_8F6C = var_0;
  } else if(_func_0205(var_0 + "_quiet")) {
    if(!array_contains(level._id_EF30, var_0)) {
      _id_B39C(var_0 + "_quiet");
      level._id_EF30[level._id_EF30.size] = var_0;
      level._id_8F6C = var_0 + "_quiet";
    }
  }
}

_id_B39C(var_0) {
  if(isDefined(level.players)) {
    foreach(var_2 in level.players) {
      if(!isbot(var_2)) {
        var_2 playlocalsound(var_0);
      }
    }
  } else
    self playlocalsound(var_0);
}

array_contains(var_0, var_1) {
  if(var_0.size <= 0) {
    return 0;
  }

  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return 1;
    }
  }

  return 0;
}