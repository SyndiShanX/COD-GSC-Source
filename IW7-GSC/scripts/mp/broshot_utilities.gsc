/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\broshot_utilities.gsc
*********************************************/

processepictaunt(var_0, var_1, var_2) {
  if(var_1 >= 0 && isDefined(level.camera_bro_shot.char_loc)) {
    var_3 = level.camera_bro_shot.char_loc[var_1].origin;
    var_4 = level.camera_bro_shot.char_loc[var_1].angles;
    if(isDefined(level.overridebroslot)) {
      var_1 = level.overridebroslot - 1;
    }
  } else {
    var_3 = level.charactercac.origin;
    var_4 = level.charactercac.angles;
    var_1 = 0;
  }

  if(tauntinprogress(var_1)) {
    return;
  }

  var_5 = var_0;
  if(var_5 == "IW7_mp_taunt_drone_crush_01") {
    if(var_2 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
      var_5 = "IW7_mp_taunt_drone_crush_01_nohit";
      if(isDefined(level.topplayers[3])) {
        var_5 = "IW7_mp_taunt_drone_crush_01_hit";
      }
    }
  }

  processtauntsound(var_5);
  deleteepictauntprops(var_1);
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
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
  if(var_2 && level.teambased) {
    var_23 = getteamscore("allies");
    var_24 = getteamscore("axis");
    if(var_23 < var_24) {
      var_22 = "axis";
    }
  }

  switch (var_0) {
    case "iw7_mp_taunt_flag_plant":
      if(var_22 == "allies") {
        var_6[0] = "ctf_game_flag_noStand_blue_mp";
      } else {
        var_6[0] = "ctf_game_flag_noStand_red_mp";
      }

      var_7[0] = "iw7_mp_taunt_flag_plant_flag";
      var_8[0] = 21.9;
      break;

    case "IW7_mp_taunt_dance_lean_01":
      if(var_2 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        level.losersinteractable = 0;
        var_1D = 3;
        var_1E = 0.31;
        var_8[0] = 8;
      }
      break;

    case "IW7_mp_taunt_drone_crush_01":
      if(var_2 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        if(isDefined(level.topplayers[3])) {
          level.losersinteractable = 0;
          var_1F = 15;
          var_1D = 1;
          var_6[0] = "care_package_iw7_ca_wm";
          var_7[0] = "IW7_mp_taunt_drone_crush_04_carepackage";
          var_8[0] = 6.6;
          var_20[0] = level.camera_bro_shot.char_loc[3].origin;
          var_1E = 4;
          var_17[0] = 4.4;
          if(isDefined(level.topplayers[4])) {
            var_6[1] = "care_package_iw7_ca_wm";
            var_7[1] = "IW7_mp_taunt_drone_crush_05_carepackage";
            var_8[1] = 6.6;
            var_20[1] = level.camera_bro_shot.char_loc[4].origin;
            if(isDefined(level.topplayers[5])) {
              var_6[2] = "care_package_iw7_ca_wm";
              var_7[2] = "IW7_mp_taunt_drone_crush_06_carepackage";
              var_8[2] = 6.6;
              var_20[2] = level.camera_bro_shot.char_loc[5].origin;
            }
          }
        }
      } else if(!var_2) {
        var_6[0] = "care_package_iw7_ca_wm";
        var_7[0] = "IW7_mp_taunt_drone_crush_07_carepackage";
        var_8[0] = 6.6;
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
      if(var_2 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        var_1D = 2;
        var_8[0] = 6.6;
        var_1E = 5.266;
        var_8[1] = 6.6;
        var_8[2] = 6.6;
        level.losersinteractable = 0;
      }
      break;

    case "IW7_mp_taunt_ftl_1st_kills_456":
      if(var_2 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        var_8[0] = 10;
        var_18[0] = 0.85;
        var_18[1] = 2.05;
        var_18[2] = 1.15;
        level.losersinteractable = 0;
      }
      break;

    case "IW7_mp_taunt_ftl_2nd_kills_456":
      if(var_2 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        var_8[0] = 10;
        var_18[0] = 1.1;
        var_18[1] = 2.7;
        var_18[2] = 1.467;
        level.losersinteractable = 0;
      }
      break;

    case "IW7_mp_taunt_ftl_3rd_kills_456":
      if(var_2 && !isDefined(level.losersinteractable) || level.losersinteractable == 1) {
        var_8[0] = 10;
        var_18[0] = 1.03;
        var_18[1] = 2.76;
        var_18[2] = 1.43;
        level.losersinteractable = 0;
      }
      break;

    case "IW7_mp_taunt_cod_champs":
      var_8[0] = 7.834;
      break;

    case "iw7_mp_taunt_super_blackhole":
      var_8[0] = 7;
      for(var_28 = 0; var_28 < 20; var_28++) {
        var_17[var_28] = 2.6 + var_28 * 0.1;
      }
      break;

    case "iw7_mp_taunt_epic_grenade_toss_back01":
      var_8[0] = 8;
      var_17[0] = 5.7;
      var_17[1] = 6.15;
      var_17[2] = 6.6;
      break;

    case "iw7_mp_taunt_super_warfighter_at_screen":
      var_8[0] = 6.6;
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
      var_8[0] = 6.6;
      var_17[0] = 1.65;
      var_17[1] = 2.05;
      break;

    case "iw7_mp_taunt_synaptic_reaper_3rd":
    case "iw7_mp_taunt_synaptic_reaper_2nd":
    case "iw7_mp_taunt_synaptic_reaper":
      var_8[0] = 6.6;
      var_16 = 2;
      break;

    case "iw7_mp_taunt_killstreak_scorcher":
      var_6[0] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_7[0] = "iw7_mp_taunt_killstreak_scorcher_scorcher01";
      var_8[0] = 6.6;
      var_6[1] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_7[1] = "iw7_mp_taunt_killstreak_scorcher_scorcher02";
      var_8[1] = 6.6;
      var_6[2] = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_7[2] = "iw7_mp_taunt_killstreak_scorcher_scorcher03";
      var_8[2] = 6.6;
      var_16 = 3;
      var_21 = 1;
      break;

    case "iw7_mp_taunt_killstreak_c8":
      var_6[0] = "mp_robot_c8";
      var_7[0] = "iw7_mp_taunt_killstreak_c8_robot";
      var_8[0] = 5.5;
      var_9[0] = [];
      var_9[0][0] = "weapon_c8_shield_top_mp";
      var_9[0][1] = "weapon_c8_shield_bottom_mp";
      var_0A[0] = [];
      var_0A[0][0] = "j_wristshield";
      var_0A[0][1] = "j_wristbtmshield";
      var_16 = 1.67;
      var_17[0] = 5.15;
      break;

    case "IW7_mp_taunt_killstreak_apex01":
      var_6[0] = "veh_mil_air_ca_oblivion_drone_mp";
      var_7[0] = "IW7_mp_taunt_killstreak_apex01_apex";
      var_8[0] = 5;
      var_17[0] = 2;
      var_17[1] = 2.4;
      var_17[2] = 2.6;
      var_17[3] = 3.2;
      var_17[4] = 3.6;
      var_17[5] = 3.8;
      break;

    case "iw7_mp_taunt_killstreak_thor":
      var_6[0] = "veh_mil_air_thor_wm";
      var_6[1] = "sdf_mp_cruise_missile_01";
      var_6[2] = "un_mp_jackal_exterior_missile";
      var_6[3] = "un_mp_jackal_exterior_missile";
      var_6[4] = "un_mp_jackal_exterior_missile";
      var_6[5] = "un_mp_jackal_exterior_missile";
      var_6[6] = "un_mp_jackal_exterior_missile";
      var_7[0] = "iw7_mp_taunt_killstreak_thor_prop";
      var_7[1] = "iw7_mp_taunt_killstreak_thor_missile01";
      var_7[2] = "iw7_mp_taunt_killstreak_thor_missile02";
      var_7[3] = "iw7_mp_taunt_killstreak_thor_missile03";
      var_7[4] = "iw7_mp_taunt_killstreak_thor_missile04";
      var_7[5] = "iw7_mp_taunt_killstreak_thor_missile05";
      var_7[6] = "iw7_mp_taunt_killstreak_thor_missile05";
      var_8[0] = 7.47;
      var_8[1] = 3.76;
      var_8[2] = 4.7;
      var_8[3] = 4.7;
      var_8[4] = 4.7;
      var_8[5] = 4.7;
      var_8[6] = 4.7;
      var_0E = 1;
      var_0F = 1.5;
      var_16 = 4.5;
      var_21 = 1;
      break;

    case "IW7_mp_taunt_adrenaline":
      var_8[0] = 10;
      break;

    case "iw7_mp_taunt_super_shootdown":
      var_6[0] = "veh_mil_air_un_uav";
      var_7[0] = "iw7_mp_taunt_super_shootdown_uav";
      var_8[0] = 6;
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
      var_8[0] = 5.1;
      var_0E = 1;
      var_0F = 2;
      break;

    case "iw7_mp_taunt_super_merc_steeldragon":
      var_10[0] = 0.466;
      var_11[0] = 2.85;
      var_12[0] = "tag_accessory_right";
      var_13[0] = "tag_accessory_left";
      var_14[0] = "vfx_taunt_steel_dragon";
      var_8[0] = 4;
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
      var_8[0] = 12;
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

  level.broshotepictauntprops[var_1] = [];
  level.broshotepictauntsubprops[var_1] = [];
  if(var_2 && var_0E) {
    if(!isDefined(level.queuedtaunts)) {
      level.queuedtaunts = [];
    }

    if(isDefined(level.queuedtaunts[var_0])) {
      var_29 = gettime() - level.queuedtaunts[var_0];
      if(var_29 < var_0F * 1000) {
        wait(var_0F - var_29 / 1000);
      }
    }

    level.queuedtaunts[var_0] = gettime();
  }

  var_2A = (0, 0, 0);
  if(var_21 && isDefined(level.upsidedowntaunts) && level.upsidedowntaunts == 1) {
    var_2A = (180, 180, 0);
  }

  if(var_1E > 0) {
    thread spawndelayedprop(var_1E, var_1, var_3, var_6, var_4, var_2A, var_7, var_20);
  } else {
    for(var_28 = 0; var_28 < var_6.size; var_28++) {
      if(isDefined(var_20) && isDefined(var_20[var_28])) {
        var_3 = var_20[var_28];
      }

      var_2B = spawn("script_model", var_3);
      var_2B setModel(var_6[var_28]);
      var_2B.angles = var_4 + var_2A;
      var_2B notsolid();
      var_2B dontinterpolate();
      var_2B scriptmodelplayanimdeltamotion(var_7[var_28]);
      if(!isDefined(level.broshotepictauntprops)) {
        level.broshotepictauntprops = [];
      }

      level.broshotepictauntprops[var_1][var_28] = var_2B;
      if(!isDefined(var_9[var_28]) && isarray(var_9[var_28])) {
        continue;
      }

      level.broshotepictauntsubprops[var_1] = [];
      for(var_2C = 0; var_2C < var_9[var_28].size; var_2C++) {
        var_2D = spawn("script_model", var_3);
        var_2D setModel(var_9[var_28][var_2C]);
        var_2D.angles = var_4 + var_2A;
        var_2D notsolid();
        var_2D dontinterpolate();
        var_2D linkto(var_2B, var_0A[var_28][var_2C], (0, 0, 0), (0, 0, 0));
        level.broshotepictauntsubprops[var_1][var_2C] = var_2D;
      }
    }
  }

  var_2E = 0;
  for(var_28 = 0; var_28 < var_8.size; var_28++) {
    var_2E = max(var_2E, var_8[var_28]);
  }

  for(var_28 = 0; var_28 < var_0B.size; var_28++) {
    thread doepictauntscriptablestep(var_2, var_1, var_0B[var_28], var_0C[var_28], var_0D[var_28]);
  }

  if(var_2 == 0) {
    var_2F = getplayercharacter(-1);
  } else {
    var_2F = getplayercharacter(var_2);
  }

  if(var_2 != 0) {
    for(var_28 = 0; var_28 < var_10.size; var_28++) {
      thread playbeamfx(var_10[var_28], var_11[var_28], var_14[var_28], var_12[var_28], var_13[var_28], var_2F);
    }
  }

  if(var_2 != 0) {
    if(var_1D > 0) {
      thread playloseranimation(var_1E, var_1D, var_8[0]);
    }
  }

  if(var_2 != 0 && var_15 > 0) {
    thread doshellshock(var_15);
  }

  if(var_2 != 0 && var_16 > 0) {
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
    if(var_2 != 0) {
      var_33 = level.camera_bro_shot.char_loc[0].origin;
    } else {
      var_33 = var_3;
    }

    for(var_2C = 0; var_2C < var_19.size; var_2C++) {
      thread dospawnvfx(var_19[var_2C], var_1C[var_2C] + var_1B * var_28, var_32, var_33);
    }
  }

  thread cleanupepictauntprops(var_1, var_2E + var_1F, var_0);
}

spawndelayedprop(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("cancel_taunt_cleanup");
  wait(var_0);
  for(var_8 = 0; var_8 < var_3.size; var_8++) {
    if(isDefined(var_7) && isDefined(var_7[var_8])) {
      var_2 = var_7[var_8];
    }

    var_9 = spawn("script_model", var_2);
    var_9 setModel(var_3[var_8]);
    var_9.angles = var_4 + var_5;
    var_9 notsolid();
    var_9 dontinterpolate();
    var_9 scriptmodelplayanimdeltamotion(var_6[var_8]);
    if(!isDefined(level.broshotepictauntprops)) {
      level.broshotepictauntprops = [];
    }

    level.broshotepictauntprops[var_1][var_8] = var_9;
  }
}

dospawnvfx(var_0, var_1, var_2, var_3) {
  self endon("cancel_taunt_cleanup");
  wait(var_1);
  var_4 = var_3 + var_2;
  var_5 = spawnfx(level._effect[var_0], var_4);
  if(isDefined(var_5)) {
    triggerfx(var_5);
    var_5 thread delayfxdelete(12);
  }
}

delayfxdelete(var_0) {
  self endon("cancel_taunt_cleanup");
  wait(var_0);
  if(isDefined(self)) {
    self delete();
  }
}

playloseranimation(var_0, var_1, var_2) {
  self endon("cancel_taunt_cleanup");
  wait(var_0);
  if(isDefined(level.topplayers[3]) || isDefined(level.topplayers[4]) || isDefined(level.topplayers[5])) {
    sendloseranim(var_1, var_2);
  }
}

sendloseranim(var_0, var_1) {
  setomnvar("ui_broshot_anim_0", 20000 + var_0);
  wait(var_1);
}

dodisintegrate(var_0, var_1) {
  self endon("cancel_taunt_cleanup");
  wait(var_0);
  if(isDefined(level.topplayers[var_1 + 3])) {
    level.topplayers[var_1 + 3] scripts\mp\archetypes\archassassin_utility::playbodyfx(undefined, level.camera_bro_shot.char_loc[var_1 + 3].origin - level.topplayers[var_1 + 3].origin);
    level.topplayers[var_1 + 3].bro hide(1);
  }
}

playbeamfx(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("cancel_taunt_cleanup");
  wait(var_0);
  var_6 = playfxontagsbetweenclients(level._effect[var_2], var_5, var_3, var_5, var_4);
  thread cleanupbeamfx(var_6, var_1);
}

cleanupbeamfx(var_0, var_1) {
  waittill_notify_or_timeout("cancel_taunt_cleanup", var_1);
  var_0 delete();
}

waittill_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

doearthquake(var_0, var_1) {
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

doshellshock(var_0) {
  self endon("cancel_taunt_cleanup");
  wait(var_0);
  foreach(var_2 in level.players) {
    if(isbot(var_2)) {
      continue;
    }

    var_2 shellshock("default", var_0);
  }
}

getplayercharacter(var_0) {
  if(var_0 == -1) {
    var_1 = level.charactercac;
  } else {
    var_1 = level.topplayers[var_1].bro;
  }

  return var_1;
}

doepictauntscriptablestep(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == 0) {
    var_1 = -1;
  }

  self endon("cancel_taunt_cleanup");
  thread listenepictauntscriptablecancel(var_1, var_2);
  wait(var_4);
  var_5 = getplayercharacter(var_1);
  if(!isDefined(var_5)) {
    return;
  }

  var_5 setscriptablepartstate(var_2, var_3, 0);
}

listenepictauntscriptablecancel(var_0, var_1) {
  self waittill("cancel_taunt_cleanup");
  var_2 = getplayercharacter(var_0);
  var_2 setscriptablepartstate(var_1, "offImmediate", 0);
}

respawnclientcharacter() {
  var_0 = level.charactercac.angles;
  var_1 = level.charactercac.origin;
  level.charactercac delete();
  level.charactercac = spawn("script_character", var_1, 0, 0, 1);
  level.charactercac.angles = var_0;
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

tauntinprogress(var_0) {
  return isDefined(level.broshotepictauntprops) && isarray(level.broshotepictauntprops) && isDefined(level.broshotepictauntprops[var_0]) && level.broshotepictauntprops[var_0].size > 0;
}

cleanupepictauntprops(var_0, var_1, var_2) {
  self endon("cancel_taunt_cleanup");
  wait(var_1);
  level.taunts_done = 1;
  deleteepictauntprops(var_0);
}

deleteepictauntprops(var_0) {
  if(tauntinprogress(var_0)) {
    for(var_1 = 0; var_1 < level.broshotepictauntprops[var_0].size; var_1++) {
      if(isDefined(level.broshotepictauntprops[var_0][var_1])) {
        level.broshotepictauntprops[var_0][var_1] scriptmodelclearanim();
        level.broshotepictauntprops[var_0][var_1] delete();
      }
    }

    level.broshotepictauntprops[var_0] = [];
    if(isDefined(level.broshotepictauntsubprops[var_0]) && isarray(level.broshotepictauntsubprops[var_0])) {
      for(var_1 = 0; var_1 < level.broshotepictauntsubprops[var_0].size; var_1++) {
        if(isDefined(level.broshotepictauntsubprops[var_0][var_1])) {
          level.broshotepictauntsubprops[var_0][var_1] scriptmodelclearanim();
          level.broshotepictauntsubprops[var_0][var_1] delete();
        }
      }

      level.broshotepictauntsubprops[var_0] = [];
    }
  }

  self notify("cancel_taunt_cleanup");
}

processtauntsound(var_0) {
  if(!soundexists(var_0)) {
    return;
  }

  if(!isDefined(level.taunts_done)) {
    level.taunts_done = 0;
  }

  if(!isDefined(level.taunts_used)) {
    level.taunts_used = [];
  }

  if(soundexists(var_0)) {
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

    playepicbroshotsound(var_0);
    level.taunts_used[level.taunts_used.size] = var_0;
    level.last_taunt_sfx = var_0;
    return;
  }

  if(soundexists(var_0 + "_quiet")) {
    if(!array_contains(level.taunts_used, var_0)) {
      playepicbroshotsound(var_0 + "_quiet");
      level.taunts_used[level.taunts_used.size] = var_0;
      level.last_taunt_sfx = var_0 + "_quiet";
      return;
    }
  }
}

playepicbroshotsound(var_0) {
  if(isDefined(level.players)) {
    foreach(var_2 in level.players) {
      if(!isbot(var_2)) {
        var_2 playlocalsound(var_0);
      }
    }

    return;
  }

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