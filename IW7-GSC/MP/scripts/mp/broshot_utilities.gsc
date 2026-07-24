/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\broshot_utilities.gsc
********************************************/

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
    if(var_2 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
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
  var_10 = [];
  var_11 = [];
  var_12 = [];
  var_13 = [];
  var_14 = 0;
  var_15 = 0;
  var_16 = [];
  var_17 = [];
  var_18 = [];
  var_19 = [];
  var_20 = [];
  var_21 = 0;
  var_22 = 0;
  var_23 = [];
  var_24 = [];
  var_25 = [];
  var_26 = [];
  var_27 = 0;
  var_28 = [];
  var_29 = 0;
  var_30 = 0;
  var_31 = 0;
  var_32 = [];
  var_33 = 0;
  var_34 = "allies";

  if(var_2 && level.teambased) {
    var_35 = getteamscore("allies");
    var_36 = getteamscore("axis");

    if(var_35 < var_36) {
      var_34 = "axis";
    }
  }

  switch (var_0) {
    case "iw7_mp_taunt_flag_plant":
      if(var_34 == "allies") {
        var_6[0] = "ctf_game_flag_noStand_blue_mp";
      } else {
        var_6[0] = "ctf_game_flag_noStand_red_mp";
      }

      var_7[0] = "iw7_mp_taunt_flag_plant_flag";
      var_8[0] = 21.9;
      break;
    case "IW7_mp_taunt_dance_lean_01":
      if(var_2 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        level.losersinteractable = 0;
        var_29 = 3;
        var_30 = 0.31;
        var_8[0] = 8;
      }

      break;
    case "IW7_mp_taunt_drone_crush_01":
      if(var_2 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        if(isDefined(level.topplayers[3])) {
          level.losersinteractable = 0;
          var_31 = 15.0;
          var_29 = 1;
          var_6[0] = "care_package_iw7_ca_wm";
          var_7[0] = "IW7_mp_taunt_drone_crush_04_carepackage";
          var_8[0] = 6.6;
          var_32[0] = level.camera_bro_shot.char_loc[3].origin;
          var_30 = 4.0;
          var_23[0] = 4.4;

          if(isDefined(level.topplayers[4])) {
            var_6[1] = "care_package_iw7_ca_wm";
            var_7[1] = "IW7_mp_taunt_drone_crush_05_carepackage";
            var_8[1] = 6.6;
            var_32[1] = level.camera_bro_shot.char_loc[4].origin;

            if(isDefined(level.topplayers[5])) {
              var_6[2] = "care_package_iw7_ca_wm";
              var_7[2] = "IW7_mp_taunt_drone_crush_06_carepackage";
              var_8[2] = 6.6;
              var_32[2] = level.camera_bro_shot.char_loc[5].origin;
            }
          }
        }
      } else if(!var_2) {
        var_6[0] = "care_package_iw7_ca_wm";
        var_7[0] = "IW7_mp_taunt_drone_crush_07_carepackage";
        var_8[0] = 6.6;
        var_37 = anglesToForward(level.camera_bro_shot.basecam.angles);
        var_38 = vectorNormalize((var_37[0], var_37[1], 0));
        var_39 = vectorcross(var_38, (0, 0, 1));
        var_32[0] = level.charactercac.origin + var_38 * 80;
        var_30 = 4.0;
        var_31 = 8.0;
        var_25[0] = "vfx_tnt_crate_smk";
        var_26[0] = (0, 80, 0);
        var_28[0] = 4.4;
        var_23[0] = 4.4;
      }

      break;
    case "IW7_mp_taunt_crush_the_enemies_01":
      if(var_2 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var_29 = 2;
        var_8[0] = 6.6;
        var_30 = 5.266;
        var_8[1] = 6.6;
        var_8[2] = 6.6;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_1st_kills_456":
      if(var_2 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var_8[0] = 10.0;
        var_24[0] = 0.85;
        var_24[1] = 2.05;
        var_24[2] = 1.15;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_2nd_kills_456":
      if(var_2 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var_8[0] = 10.0;
        var_24[0] = 1.1;
        var_24[1] = 2.7;
        var_24[2] = 1.467;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_3rd_kills_456":
      if(var_2 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var_8[0] = 10.0;
        var_24[0] = 1.03;
        var_24[1] = 2.76;
        var_24[2] = 1.43;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_cod_champs":
      var_8[0] = 7.834;
      break;
    case "iw7_mp_taunt_super_blackhole":
      var_8[0] = 7.0;

      for(var_40 = 0; var_40 < 20; var_40++) {
        var_23[var_40] = 2.6 + var_40 * 0.1;
      }

      break;
    case "iw7_mp_taunt_epic_grenade_toss_back01":
      var_8[0] = 8.0;
      var_23[0] = 5.7;
      var_23[1] = 6.15;
      var_23[2] = 6.6;
      break;
    case "iw7_mp_taunt_super_warfighter_at_screen":
      var_8[0] = 6.6;
      var_23[0] = 1.0;
      var_23[1] = 1.2;
      var_23[2] = 1.4;
      var_23[3] = 1.6;
      var_23[4] = 1.8;
      var_23[5] = 2.0;
      var_23[6] = 2.2;
      var_23[7] = 2.4;
      break;
    case "iw7_mp_taunt_bio_spike":
      var_8[0] = 6.6;
      var_23[0] = 1.65;
      var_23[1] = 2.05;
      break;
    case "iw7_mp_taunt_synaptic_reaper_3rd":
    case "iw7_mp_taunt_synaptic_reaper_2nd":
    case "iw7_mp_taunt_synaptic_reaper":
      var_8[0] = 6.6;
      var_22 = 2.0;
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
      var_22 = 3.0;
      var_33 = 1;
      break;
    case "iw7_mp_taunt_killstreak_c8":
      var_6[0] = "mp_robot_c8";
      var_7[0] = "iw7_mp_taunt_killstreak_c8_robot";
      var_8[0] = 5.5;
      var_9[0] = [];
      var_9[0][0] = "weapon_c8_shield_top_mp";
      var_9[0][1] = "weapon_c8_shield_bottom_mp";
      var_10[0] = [];
      var_10[0][0] = "j_wristshield";
      var_10[0][1] = "j_wristbtmshield";
      var_22 = 1.67;
      var_23[0] = 5.15;
      break;
    case "IW7_mp_taunt_killstreak_apex01":
      var_6[0] = "veh_mil_air_ca_oblivion_drone_mp";
      var_7[0] = "IW7_mp_taunt_killstreak_apex01_apex";
      var_8[0] = 5.0;
      var_23[0] = 2.0;
      var_23[1] = 2.4;
      var_23[2] = 2.6;
      var_23[3] = 3.2;
      var_23[4] = 3.6;
      var_23[5] = 3.8;
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
      var_14 = 1;
      var_15 = 1.5;
      var_22 = 4.5;
      var_33 = 1;
      break;
    case "IW7_mp_taunt_adrenaline":
      var_8[0] = 10.0;
      break;
    case "iw7_mp_taunt_super_shootdown":
      var_6[0] = "veh_mil_air_un_uav";
      var_7[0] = "iw7_mp_taunt_super_shootdown_uav";
      var_8[0] = 6.0;
      var_23[0] = 3.75;
      break;
    case "IW7_mp_taunt_phantom_cloak_3rd":
    case "IW7_mp_taunt_phantom_cloak_2nd":
    case "IW7_mp_taunt_phantom_cloak":
      var_11[0] = "cloak";
      var_12[0] = "on";
      var_13[0] = 0.01;
      var_11[1] = "cloak";
      var_12[1] = "off";
      var_13[1] = 1.5;
      var_11[2] = "cloak";
      var_12[2] = "on";
      var_13[2] = 3.2;
      var_11[3] = "cloak";
      var_12[3] = "off";
      var_13[3] = 4.7;
      var_8[0] = 5.1;
      var_14 = 1;
      var_15 = 2.0;
      break;
    case "iw7_mp_taunt_super_merc_steeldragon":
      var_16[0] = 0.466;
      var_17[0] = 2.85;
      var_18[0] = "tag_accessory_right";
      var_19[0] = "tag_accessory_left";
      var_20[0] = "vfx_taunt_steel_dragon";
      var_8[0] = 4.0;
      var_23[0] = 0.5;
      var_23[1] = 0.7;
      var_23[2] = 0.9;
      var_23[3] = 1.0;
      var_23[4] = 1.2;
      var_23[5] = 1.4;
      var_23[6] = 1.6;
      var_23[7] = 1.8;
      var_23[8] = 2.0;
      var_23[9] = 2.2;
      var_23[10] = 2.4;
      var_23[11] = 2.7;
      var_23[12] = 2.9;
      var_23[13] = 3.1;
      break;
    case "iw7_mp_taunt_killstreak_laser_strike":
      var_8[0] = 12.0;
      var_25[0] = "vfx_bombard_antigrav_pre_expl";
      var_25[1] = "vfx_bombard_projectile_trail";
      var_25[2] = "vfx_bombardment_strike_explosion";
      var_27 = 0.2;
      var_26[0] = (0, 80, 0);
      var_26[1] = (75, 140, 0);
      var_26[2] = (-165, 250, 0);
      var_26[3] = (50, 200, 0);
      var_26[4] = (155, 250, 0);
      var_26[5] = (-75, 140, 0);
      var_26[6] = (-50, 200, 0);
      var_28[0] = 1.0;
      var_28[1] = 1.0;
      var_28[2] = 3.5;
      var_23[0] = 3.5;
      var_23[1] = 3.7;
      var_23[2] = 3.9;
      var_23[3] = 4.1;
      var_23[4] = 4.3;
      var_23[5] = 4.5;
      var_23[6] = 4.7;
      var_23[7] = 4.9;
      break;
    default:
      return;
  }

  level.broshotepictauntprops[var_1] = [];
  level.broshotepictauntsubprops[var_1] = [];

  if(var_2 && var_14) {
    if(!isDefined(level.queuedtaunts)) {
      level.queuedtaunts = [];
    }

    if(isDefined(level.queuedtaunts[var_0])) {
      var_41 = gettime() - level.queuedtaunts[var_0];

      if(var_41 < var_15 * 1000) {
        wait(var_15 - var_41 / 1000);
      }
    }

    level.queuedtaunts[var_0] = gettime();
  }

  var_42 = (0, 0, 0);

  if(var_33 && isDefined(level.upsidedowntaunts) && level.upsidedowntaunts == 1) {
    var_42 = (180, 180, 0);
  }

  if(var_30 > 0) {
    thread spawndelayedprop(var_30, var_1, var_3, var_6, var_4, var_42, var_7, var_32);
  } else {
    for(var_40 = 0; var_40 < var_6.size; var_40++) {
      if(isDefined(var_32) && isDefined(var_32[var_40])) {
        var_3 = var_32[var_40];
      }

      var_43 = spawn("script_model", var_3);
      var_43 setModel(var_6[var_40]);
      var_43.angles = var_4 + var_42;
      var_43 notsolid();
      var_43 dontinterpolate();
      var_43 scriptmodelplayanimdeltamotion(var_7[var_40]);

      if(!isDefined(level.broshotepictauntprops)) {
        level.broshotepictauntprops = [];
      }

      level.broshotepictauntprops[var_1][var_40] = var_43;

      if(!(isDefined(var_9[var_40]) && isarray(var_9[var_40]))) {
        continue;
      }
      level.broshotepictauntsubprops[var_1] = [];

      for(var_44 = 0; var_44 < var_9[var_40].size; var_44++) {
        var_45 = spawn("script_model", var_3);
        var_45 setModel(var_9[var_40][var_44]);
        var_45.angles = var_4 + var_42;
        var_45 notsolid();
        var_45 dontinterpolate();
        var_45 linkTo(var_43, var_10[var_40][var_44], (0, 0, 0), (0, 0, 0));
        level.broshotepictauntsubprops[var_1][var_44] = var_45;
      }
    }
  }

  var_46 = 0;

  for(var_40 = 0; var_40 < var_8.size; var_40++) {
    var_46 = max(var_46, var_8[var_40]);
  }

  for(var_40 = 0; var_40 < var_11.size; var_40++) {
    thread doepictauntscriptablestep(var_2, var_1, var_11[var_40], var_12[var_40], var_13[var_40]);
  }

  if(var_2 == 0) {
    var_47 = getplayercharacter(-1);
  } else {
    var_47 = getplayercharacter(var_1);
  }

  if(var_2 != 0) {
    for(var_40 = 0; var_40 < var_16.size; var_40++) {
      thread playbeamfx(var_16[var_40], var_17[var_40], var_20[var_40], var_18[var_40], var_19[var_40], var_47);
    }
  }

  if(var_2 != 0) {
    if(var_29 > 0) {
      thread playloseranimation(var_30, var_29, var_8[0]);
    }
  }

  if(var_2 != 0 && var_21 > 0) {
    thread doshellshock(var_21);
  }

  if(var_2 != 0 && var_22 > 0) {
    thread doearthquake(var_22, 1);
  }

  for(var_40 = 0; var_40 < var_23.size; var_40++) {
    thread doearthquake(var_23[var_40], 0);
  }

  for(var_40 = 0; var_40 < var_24.size; var_40++) {
    thread dodisintegrate(var_24[var_40], var_40);
  }

  for(var_40 = 0; var_40 < var_26.size; var_40++) {
    var_37 = anglesToForward(level.camera_bro_shot.basecam.angles);
    var_38 = vectorNormalize((var_37[0], var_37[1], 0));
    var_39 = vectorcross(var_38, (0, 0, 1));
    var_48 = var_38 * var_26[var_40][1];
    var_49 = var_39 * var_26[var_40][0];
    var_50 = var_48 + var_49;

    if(var_2 != 0) {
      var_51 = level.camera_bro_shot.char_loc[0].origin;
    } else {
      var_51 = var_3;
    }

    for(var_44 = 0; var_44 < var_25.size; var_44++) {
      thread dospawnvfx(var_25[var_44], var_28[var_44] + var_27 * var_40, var_50, var_51);
    }
  }

  thread cleanupepictauntprops(var_1, var_46 + var_31, var_0);
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
    var_5 thread delayfxdelete(12.0);
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
    var_1 = level.topplayers[var_0].bro;
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
  } else if(soundexists(var_0 + "_quiet")) {
    if(!array_contains(level.taunts_used, var_0)) {
      playepicbroshotsound(var_0 + "_quiet");
      level.taunts_used[level.taunts_used.size] = var_0;
      level.last_taunt_sfx = var_0 + "_quiet";
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