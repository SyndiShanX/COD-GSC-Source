/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\broshot_utilities.gsc
********************************************/

processepictaunt(param_00, param_01, param_02) {
  if(param_01 >= 0 && isDefined(level.camera_bro_shot.char_loc)) {
    var_03 = level.camera_bro_shot.char_loc[param_01].origin;
    var_04 = level.camera_bro_shot.char_loc[param_01].angles;
    if(isDefined(level.overridebroslot)) {
      param_01 = level.overridebroslot - 1;
    }
  } else {
    var_03 = level.charactercac.origin;
    var_04 = level.charactercac.angles;
    param_01 = 0;
  }

  if(tauntinprogress(param_01)) {
    return;
  }

  var_05 = param_00;
  if(var_05 == "IW7_mp_taunt_drone_crush_01") {
    if(param_02 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
      var_05 = "IW7_mp_taunt_drone_crush_01_nohit";
      if(isDefined(level.topplayers[3])) {
        var_05 = "IW7_mp_taunt_drone_crush_01_hit";
      }
    }
  }

  processtauntsound(var_05);
  deleteepictauntprops(param_01);
  var_06 = [];
  var_07 = [];
  var_08 = [];
  var_09 = [];
  var_0A = [];
  var_0B = [];
  var_0C = [];
  var_0D = [];
  var_0E = 0;
  var_0F = 0;
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = [];
  var_14 = [];
  var_15 = 0;
  var_16 = 0;
  var_17 = [];
  var_18 = [];
  var_19 = [];
  var_1A = [];
  var_1B = 0;
  var_1C = [];
  var_1D = 0;
  var_1E = 0;
  var_1F = 0;
  var_20 = [];
  var_21 = 0;
  var_22 = "allies";
  if(param_02 && level.teambased) {
    var_23 = getteamscore("allies");
    var_24 = getteamscore("axis");
    if(var_23 < var_24) {
      var_22 = "axis";
    }
  }

  switch (param_00) {
    case "iw7_mp_taunt_flag_plant":
      if(var_22 == "allies") {
        var_06[0] = "ctf_game_flag_noStand_blue_mp";
      } else {
        var_06[0] = "ctf_game_flag_noStand_red_mp";
      }

      var_07[0] = "iw7_mp_taunt_flag_plant_flag";
      var_08[0] = 21.9;
      break;

    case "IW7_mp_taunt_dance_lean_01":
      if(param_02 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        level.losersinteractable = 0;
        var_1D = 3;
        var_1E = 0.31;
        var_08[0] = 8;
      }
      break;

    case "IW7_mp_taunt_drone_crush_01":
      if(param_02 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        if(isDefined(level.topplayers[3])) {
          level.losersinteractable = 0;
          var_1F = 15;
          var_1D = 1;
          var_06[0] = "care_package_iw7_ca_wm";
          var_07[0] = "IW7_mp_taunt_drone_crush_04_carepackage";
          var_08[0] = 6.6;
          var_20[0] = level.camera_bro_shot.char_loc[3].origin;
          var_1E = 4;
          var_17[0] = 4.4;
          if(isDefined(level.topplayers[4])) {
            var_06[1] = "care_package_iw7_ca_wm";
            var_07[1] = "IW7_mp_taunt_drone_crush_05_carepackage";
            var_08[1] = 6.6;
            var_20[1] = level.camera_bro_shot.char_loc[4].origin;
            if(isDefined(level.topplayers[5])) {
              var_06[2] = "care_package_iw7_ca_wm";
              var_07[2] = "IW7_mp_taunt_drone_crush_06_carepackage";
              var_08[2] = 6.6;
              var_20[2] = level.camera_bro_shot.char_loc[5].origin;
            }
          }
        }
      } else if(!param_02) {
        var_06[0] = "care_package_iw7_ca_wm";
        var_07[0] = "IW7_mp_taunt_drone_crush_07_carepackage";
        var_08[0] = 6.6;
        var_25 = anglesToForward(level.camera_bro_shot.basecam.angles);
        var_26 = vectornormalize((var_25[0], var_25[1], 0));
        var_27 = vectorcross(var_26, (0, 0, 1));
        var_20[0] = level.charactercac.origin + var_26 * 80;
        var_1E = 4;
        var_1F = 8;
        var_19[0] = "vfx_tnt_crate_smk";
        var_1A[0] = (0, 80, 0);
        var_1C[0] = 4.4;
        var_17[0] = 4.4;
      }
      break;

    case "IW7_mp_taunt_crush_the_enemies_01":
      if(param_02 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        var_1D = 2;
        var_08[0] = 6.6;
        var_1E = 5.266;
        var_08[1] = 6.6;
        var_08[2] = 6.6;
        level.losersinteractable = 0;
      }
      break;

    case "IW7_mp_taunt_ftl_1st_kills_456":
      if(param_02 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        var_08[0] = 10;
        var_18[0] = 0.85;
        var_18[1] = 2.05;
        var_18[2] = 1.15;
        level.losersinteractable = 0;
      }
      break;

    case "IW7_mp_taunt_ftl_2nd_kills_456":
      if(param_02 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        var_08[0] = 10;
        var_18[0] = 1.1;
        var_18[1] = 2.7;
        var_18[2] = 1.467;
        level.losersinteractable = 0;
      }
      break;

    case "IW7_mp_taunt_ftl_3rd_kills_456":
      if(param_02 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        var_08[0] = 10;
        var_18[0] = 1.03;
        var_18[1] = 2.76;
        var_18[2] = 1.43;
        level.losersinteractable = 0;
      }
      break;

    case "IW7_mp_taunt_cod_champs":
      var_08[0] = 7.834;
      break;

    case "iw7_mp_taunt_super_blackhole":
      var_08[0] = 7;
      for(var_28 = 0; var_28 < 20; var_28++) {
        var_17[var_28] = 2.6 + var_28 * 0.1;
      }
      break;

    case "iw7_mp_taunt_epic_grenade_toss_back01":
      var_08[0] = 8;
      var_17[0] = 5.7;
      var_17[1] = 6.15;
      var_17[2] = 6.6;
      break;

    case "iw7_mp_taunt_super_warfighter_at_screen":
      var_08[0] = 6.6;
      var_17[0] = 1;
      var_17[1] = 1.2;
      var_17[2] = 1.4;
      var_17[3] = 1.6;
      var_17[4] = 1.8;
      var_17[5] = 2;
      var_17[6] = 2.2;
      var_17[7] = 2.4;
      break;

    case "iw7_mp_taunt_bio_spike":
      var_08[0] = 6.6;
      var_17[0] = 1.65;
      var_17[1] = 2.05;
      break;

    case "iw7_mp_taunt_synaptic_reaper_3rd":
    case "iw7_mp_taunt_synaptic_reaper_2nd":
    case "iw7_mp_taunt_synaptic_reaper":
      var_08[0] = 6.6;
      var_16 = 2;
      break;

    case "iw7_mp_taunt_killstreak_scorcher":
      var_06[0] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_07[0] = "iw7_mp_taunt_killstreak_scorcher_scorcher01";
      var_08[0] = 6.6;
      var_06[1] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_07[1] = "iw7_mp_taunt_killstreak_scorcher_scorcher02";
      var_08[1] = 6.6;
      var_06[2] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_07[2] = "iw7_mp_taunt_killstreak_scorcher_scorcher03";
      var_08[2] = 6.6;
      var_16 = 3;
      var_21 = 1;
      break;

    case "iw7_mp_taunt_killstreak_c8":
      var_06[0] = "mp_robot_c8";
      var_07[0] = "iw7_mp_taunt_killstreak_c8_robot";
      var_08[0] = 5.5;
      var_09[0] = [];
      var_09[0][0] = "weapon_c8_shield_top_mp";
      var_09[0][1] = "weapon_c8_shield_bottom_mp";
      var_0A[0] = [];
      var_0A[0][0] = "j_wristshield";
      var_0A[0][1] = "j_wristbtmshield";
      var_16 = 1.67;
      var_17[0] = 5.15;
      break;

    case "IW7_mp_taunt_killstreak_apex01":
      var_06[0] = "veh_mil_air_ca_oblivion_drone_mp";
      var_07[0] = "IW7_mp_taunt_killstreak_apex01_apex";
      var_08[0] = 5;
      var_17[0] = 2;
      var_17[1] = 2.4;
      var_17[2] = 2.6;
      var_17[3] = 3.2;
      var_17[4] = 3.6;
      var_17[5] = 3.8;
      break;

    case "iw7_mp_taunt_killstreak_thor":
      var_06[0] = "veh_mil_air_thor_wm";
      var_06[1] = "sdf_mp_cruise_missile_01";
      var_06[2] = "un_mp_jackal_exterior_missile";
      var_06[3] = "un_mp_jackal_exterior_missile";
      var_06[4] = "un_mp_jackal_exterior_missile";
      var_06[5] = "un_mp_jackal_exterior_missile";
      var_06[6] = "un_mp_jackal_exterior_missile";
      var_07[0] = "iw7_mp_taunt_killstreak_thor_prop";
      var_07[1] = "iw7_mp_taunt_killstreak_thor_missile01";
      var_07[2] = "iw7_mp_taunt_killstreak_thor_missile02";
      var_07[3] = "iw7_mp_taunt_killstreak_thor_missile03";
      var_07[4] = "iw7_mp_taunt_killstreak_thor_missile04";
      var_07[5] = "iw7_mp_taunt_killstreak_thor_missile05";
      var_07[6] = "iw7_mp_taunt_killstreak_thor_missile05";
      var_08[0] = 7.47;
      var_08[1] = 3.76;
      var_08[2] = 4.7;
      var_08[3] = 4.7;
      var_08[4] = 4.7;
      var_08[5] = 4.7;
      var_08[6] = 4.7;
      var_0E = 1;
      var_0F = 1.5;
      var_16 = 4.5;
      var_21 = 1;
      break;

    case "IW7_mp_taunt_adrenaline":
      var_08[0] = 10;
      break;

    case "iw7_mp_taunt_super_shootdown":
      var_06[0] = "veh_mil_air_un_uav";
      var_07[0] = "iw7_mp_taunt_super_shootdown_uav";
      var_08[0] = 6;
      var_17[0] = 3.75;
      break;

    case "IW7_mp_taunt_phantom_cloak_3rd":
    case "IW7_mp_taunt_phantom_cloak_2nd":
    case "IW7_mp_taunt_phantom_cloak":
      var_0B[0] = "cloak";
      var_0C[0] = "on";
      var_0D[0] = 0.01;
      var_0B[1] = "cloak";
      var_0C[1] = "off";
      var_0D[1] = 1.5;
      var_0B[2] = "cloak";
      var_0C[2] = "on";
      var_0D[2] = 3.2;
      var_0B[3] = "cloak";
      var_0C[3] = "off";
      var_0D[3] = 4.7;
      var_08[0] = 5.1;
      var_0E = 1;
      var_0F = 2;
      break;

    case "iw7_mp_taunt_super_merc_steeldragon":
      var_10[0] = 0.466;
      var_11[0] = 2.85;
      var_12[0] = "tag_accessory_right";
      var_13[0] = "tag_accessory_left";
      var_14[0] = "vfx_taunt_steel_dragon";
      var_08[0] = 4;
      var_17[0] = 0.5;
      var_17[1] = 0.7;
      var_17[2] = 0.9;
      var_17[3] = 1;
      var_17[4] = 1.2;
      var_17[5] = 1.4;
      var_17[6] = 1.6;
      var_17[7] = 1.8;
      var_17[8] = 2;
      var_17[9] = 2.2;
      var_17[10] = 2.4;
      var_17[11] = 2.7;
      var_17[12] = 2.9;
      var_17[13] = 3.1;
      break;

    case "iw7_mp_taunt_killstreak_laser_strike":
      var_08[0] = 12;
      var_19[0] = "vfx_bombard_antigrav_pre_expl";
      var_19[1] = "vfx_bombard_projectile_trail";
      var_19[2] = "vfx_bombardment_strike_explosion";
      var_1B = 0.2;
      var_1A[0] = (0, 80, 0);
      var_1A[1] = (75, 140, 0);
      var_1A[2] = (-165, 250, 0);
      var_1A[3] = (50, 200, 0);
      var_1A[4] = (155, 250, 0);
      var_1A[5] = (-75, 140, 0);
      var_1A[6] = (-50, 200, 0);
      var_1C[0] = 1;
      var_1C[1] = 1;
      var_1C[2] = 3.5;
      var_17[0] = 3.5;
      var_17[1] = 3.7;
      var_17[2] = 3.9;
      var_17[3] = 4.1;
      var_17[4] = 4.3;
      var_17[5] = 4.5;
      var_17[6] = 4.7;
      var_17[7] = 4.9;
      break;

    default:
      break;
  }

  level.broshotepictauntprops[param_01] = [];
  level.broshotepictauntsubprops[param_01] = [];
  if(param_02 && var_0E) {
    if(!isDefined(level.queuedtaunts)) {
      level.queuedtaunts = [];
    }

    if(isDefined(level.queuedtaunts[param_00])) {
      var_29 = gettime() - level.queuedtaunts[param_00];
      if(var_29 < var_0F * 1000) {
        wait(var_0F - var_29 / 1000);
      }
    }

    level.queuedtaunts[param_00] = gettime();
  }

  var_2A = (0, 0, 0);
  if(var_21 && isDefined(level.upsidedowntaunts) && level.upsidedowntaunts == 1) {
    var_2A = (180, 180, 0);
  }

  if(var_1E > 0) {
    thread spawndelayedprop(var_1E, param_01, var_03, var_06, var_04, var_2A, var_07, var_20);
  } else {
    for(var_28 = 0; var_28 < var_06.size; var_28++) {
      if(isDefined(var_20) && isDefined(var_20[var_28])) {
        var_03 = var_20[var_28];
      }

      var_2B = spawn("script_model", var_03);
      var_2B setModel(var_06[var_28]);
      var_2B.angles = var_04 + var_2A;
      var_2B notsolid();
      var_2B dontinterpolate();
      var_2B scriptmodelplayanimdeltamotion(var_07[var_28]);
      if(!isDefined(level.broshotepictauntprops)) {
        level.broshotepictauntprops = [];
      }

      level.broshotepictauntprops[param_01][var_28] = var_2B;
      if(!isDefined(var_09[var_28]) && isarray(var_09[var_28])) {
        continue;
      }

      level.broshotepictauntsubprops[param_01] = [];
      for(var_2C = 0; var_2C < var_09[var_28].size; var_2C++) {
        var_2D = spawn("script_model", var_03);
        var_2D setModel(var_09[var_28][var_2C]);
        var_2D.angles = var_04 + var_2A;
        var_2D notsolid();
        var_2D dontinterpolate();
        var_2D linkto(var_2B, var_0A[var_28][var_2C], (0, 0, 0), (0, 0, 0));
        level.broshotepictauntsubprops[param_01][var_2C] = var_2D;
      }
    }
  }

  var_2E = 0;
  for(var_28 = 0; var_28 < var_08.size; var_28++) {
    var_2E = max(var_2E, var_08[var_28]);
  }

  for(var_28 = 0; var_28 < var_0B.size; var_28++) {
    thread doepictauntscriptablestep(param_02, param_01, var_0B[var_28], var_0C[var_28], var_0D[var_28]);
  }

  if(param_02 == 0) {
    var_2F = getplayercharacter(-1);
  } else {
    var_2F = getplayercharacter(param_02);
  }

  if(param_02 != 0) {
    for(var_28 = 0; var_28 < var_10.size; var_28++) {
      thread playbeamfx(var_10[var_28], var_11[var_28], var_14[var_28], var_12[var_28], var_13[var_28], var_2F);
    }
  }

  if(param_02 != 0) {
    if(var_1D > 0) {
      thread playloseranimation(var_1E, var_1D, var_08[0]);
    }
  }

  if(param_02 != 0 && var_15 > 0) {
    thread doshellshock(var_15);
  }

  if(param_02 != 0 && var_16 > 0) {
    thread doearthquake(var_16, 1);
  }

  for(var_28 = 0; var_28 < var_17.size; var_28++) {
    thread doearthquake(var_17[var_28], 0);
  }

  for(var_28 = 0; var_28 < var_18.size; var_28++) {
    thread dodisintegrate(var_18[var_28], var_28);
  }

  for(var_28 = 0; var_28 < var_1A.size; var_28++) {
    var_25 = anglesToForward(level.camera_bro_shot.basecam.angles);
    var_26 = vectornormalize((var_25[0], var_25[1], 0));
    var_27 = vectorcross(var_26, (0, 0, 1));
    var_30 = var_26 * var_1A[var_28][1];
    var_31 = var_27 * var_1A[var_28][0];
    var_32 = var_30 + var_31;
    if(param_02 != 0) {
      var_33 = level.camera_bro_shot.char_loc[0].origin;
    } else {
      var_33 = var_03;
    }

    for(var_2C = 0; var_2C < var_19.size; var_2C++) {
      thread dospawnvfx(var_19[var_2C], var_1C[var_2C] + var_1B * var_28, var_32, var_33);
    }
  }

  thread cleanupepictauntprops(param_01, var_2E + var_1F, param_00);
}

spawndelayedprop(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("cancel_taunt_cleanup");
  wait(param_00);
  for(var_08 = 0; var_08 < param_03.size; var_08++) {
    if(isDefined(param_07) && isDefined(param_07[var_08])) {
      param_02 = param_07[var_08];
    }

    var_09 = spawn("script_model", param_02);
    var_09 setModel(param_03[var_08]);
    var_09.angles = param_04 + param_05;
    var_09 notsolid();
    var_09 dontinterpolate();
    var_09 scriptmodelplayanimdeltamotion(param_06[var_08]);
    if(!isDefined(level.broshotepictauntprops)) {
      level.broshotepictauntprops = [];
    }

    level.broshotepictauntprops[param_01][var_08] = var_09;
  }
}

dospawnvfx(param_00, param_01, param_02, param_03) {
  self endon("cancel_taunt_cleanup");
  wait(param_01);
  var_04 = param_03 + param_02;
  var_05 = spawnfx(level._effect[param_00], var_04);
  if(isDefined(var_05)) {
    triggerfx(var_05);
    var_05 thread delayfxdelete(12);
  }
}

delayfxdelete(param_00) {
  self endon("cancel_taunt_cleanup");
  wait(param_00);
  if(isDefined(self)) {
    self delete();
  }
}

playloseranimation(param_00, param_01, param_02) {
  self endon("cancel_taunt_cleanup");
  wait(param_00);
  if(isDefined(level.topplayers[3]) || isDefined(level.topplayers[4]) || isDefined(level.topplayers[5])) {
    sendloseranim(param_01, param_02);
  }
}

sendloseranim(param_00, param_01) {
  setomnvar("ui_broshot_anim_0", 20000 + param_00);
  wait(param_01);
}

dodisintegrate(param_00, param_01) {
  self endon("cancel_taunt_cleanup");
  wait(param_00);
  if(isDefined(level.topplayers[param_01 + 3])) {
    level.topplayers[param_01 + 3] scripts\mp\archetypes\archassassin_utility::playbodyfx(undefined, level.camera_bro_shot.char_loc[param_01 + 3].origin - level.topplayers[param_01 + 3].origin);
    level.topplayers[param_01 + 3].bro hide(1);
  }
}

playbeamfx(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("cancel_taunt_cleanup");
  wait(param_00);
  var_06 = playfxontagsbetweenclients(level._effect[param_02], param_05, param_03, param_05, param_04);
  thread cleanupbeamfx(var_06, param_01);
}

cleanupbeamfx(param_00, param_01) {
  waittill_notify_or_timeout("cancel_taunt_cleanup", param_01);
  param_00 delete();
}

waittill_notify_or_timeout(param_00, param_01) {
  self endon(param_00);
  wait(param_01);
}

doearthquake(param_00, param_01) {
  self endon("cancel_taunt_cleanup");
  if(!isDefined(level.players)) {
    return;
  }

  wait(param_00);
  foreach(var_03 in level.players) {
    if(isbot(var_03)) {
      continue;
    }

    if(param_01) {
      var_03 earthquakeforplayer(0.5, 0.65, var_03.origin, 1000);
      continue;
    }

    var_03 earthquakeforplayer(0.15, 0.25, var_03.origin, 1000);
  }
}

doshellshock(param_00) {
  self endon("cancel_taunt_cleanup");
  wait(param_00);
  foreach(var_02 in level.players) {
    if(isbot(var_02)) {
      continue;
    }

    var_02 shellshock("default", param_00);
  }
}

getplayercharacter(param_00) {
  if(param_00 == -1) {
    var_01 = level.charactercac;
  } else {
    var_01 = level.topplayers[var_01].bro;
  }

  return var_01;
}

doepictauntscriptablestep(param_00, param_01, param_02, param_03, param_04) {
  if(param_00 == 0) {
    param_01 = -1;
  }

  self endon("cancel_taunt_cleanup");
  thread listenepictauntscriptablecancel(param_01, param_02);
  wait(param_04);
  var_05 = getplayercharacter(param_01);
  if(!isDefined(var_05)) {
    return;
  }

  var_05 setscriptablepartstate(param_02, param_03, 0);
}

listenepictauntscriptablecancel(param_00, param_01) {
  self waittill("cancel_taunt_cleanup");
  var_02 = getplayercharacter(param_00);
  var_02 setscriptablepartstate(param_01, "offImmediate", 0);
}

respawnclientcharacter() {
  var_00 = level.charactercac.angles;
  var_01 = level.charactercac.origin;
  level.charactercac delete();
  level.charactercac = spawn("script_character", var_01, 0, 0, 1);
  level.charactercac.angles = var_00;
  deleteepictauntprops(0);
  if(isDefined(level.last_taunt_sfx)) {
    self stoplocalsound(level.last_taunt_sfx);
    if(soundexists(level.last_taunt_sfx + "_lsrs")) {
      self stoplocalsound(level.last_taunt_sfx + "_lsrs");
    }

    if(soundexists(level.last_taunt_sfx + "_lfe")) {
      self stoplocalsound(level.last_taunt_sfx + "_lfe");
    }

    level.last_taunt_sfx = undefined;
  }
}

tauntinprogress(param_00) {
  return isDefined(level.broshotepictauntprops) && isarray(level.broshotepictauntprops) && isDefined(level.broshotepictauntprops[param_00]) && level.broshotepictauntprops[param_00].size > 0;
}

cleanupepictauntprops(param_00, param_01, param_02) {
  self endon("cancel_taunt_cleanup");
  wait(param_01);
  level.taunts_done = 1;
  deleteepictauntprops(param_00);
}

deleteepictauntprops(param_00) {
  if(tauntinprogress(param_00)) {
    for(var_01 = 0; var_01 < level.broshotepictauntprops[param_00].size; var_01++) {
      if(isDefined(level.broshotepictauntprops[param_00][var_01])) {
        level.broshotepictauntprops[param_00][var_01] scriptmodelclearanim();
        level.broshotepictauntprops[param_00][var_01] delete();
      }
    }

    level.broshotepictauntprops[param_00] = [];
    if(isDefined(level.broshotepictauntsubprops[param_00]) && isarray(level.broshotepictauntsubprops[param_00])) {
      for(var_01 = 0; var_01 < level.broshotepictauntsubprops[param_00].size; var_01++) {
        if(isDefined(level.broshotepictauntsubprops[param_00][var_01])) {
          level.broshotepictauntsubprops[param_00][var_01] scriptmodelclearanim();
          level.broshotepictauntsubprops[param_00][var_01] delete();
        }
      }

      level.broshotepictauntsubprops[param_00] = [];
    }
  }

  self notify("cancel_taunt_cleanup");
}

processtauntsound(param_00) {
  if(!soundexists(param_00)) {
    return;
  }

  if(!isDefined(level.taunts_done)) {
    level.taunts_done = 0;
  }

  if(!isDefined(level.taunts_used)) {
    level.taunts_used = [];
  }

  if(soundexists(param_00)) {
    if(isDefined(level.last_taunt_sfx)) {
      self stoplocalsound(level.last_taunt_sfx);
      if(soundexists(level.last_taunt_sfx + "_lsrs")) {
        self stoplocalsound(level.last_taunt_sfx + "_lsrs");
      }

      if(soundexists(level.last_taunt_sfx + "_lfe")) {
        self stoplocalsound(level.last_taunt_sfx + "_lfe");
      }

      level.last_taunt_sfx = undefined;
    }

    playepicbroshotsound(param_00);
    level.taunts_used[level.taunts_used.size] = param_00;
    level.last_taunt_sfx = param_00;
    return;
  }

  if(soundexists(param_00 + "_quiet")) {
    if(!array_contains(level.taunts_used, param_00)) {
      playepicbroshotsound(param_00 + "_quiet");
      level.taunts_used[level.taunts_used.size] = param_00;
      level.last_taunt_sfx = param_00 + "_quiet";
      return;
    }
  }
}

playepicbroshotsound(param_00) {
  if(isDefined(level.players)) {
    foreach(var_02 in level.players) {
      if(!isbot(var_02)) {
        var_02 playlocalsound(param_00);
      }
    }

    return;
  }

  self playlocalsound(param_00);
}

array_contains(param_00, param_01) {
  if(param_00.size <= 0) {
    return 0;
  }

  foreach(var_03 in param_00) {
    if(var_03 == param_01) {
      return 1;
    }
  }

  return 0;
}