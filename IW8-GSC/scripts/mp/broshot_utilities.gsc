/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\broshot_utilities.gsc
***********************************************/

function processepictaunt(var_0, var_1, var_2) {
  if(var_1 >= 0 && isDefined(level.camera_bro_shot.char_loc)) {
    var_3 = level.camera_bro_shot.char_loc[var_1].origin;
    var_4 = level.camera_bro_shot.char_loc[var_1].angles;

    if(isDefined(level.overridebroslot)) {
      var_1 = level.overridebroslot - 1;
    }
  } else {
    var_3 = level.charactercac.origin;
    var_4 = level.charactercac.angles;
    var_3 = 0;
  }

  if(tauntinprogress(var_3)) {
    return;
  }

  processtauntsound(var_2);
  deleteepictauntprops(var_3);
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

  switch (var_2) {
    case "IW7_mp_taunt_ftl_1st_kills_456":
      if(var_4 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var_7 = 10;
        var_23 = 0.85;
        var_23 = 2.05;
        var_23 = 1.15;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_2nd_kills_456":
      if(var_4 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var_7 = 10;
        var_23 = 1.1;
        var_23 = 2.7;
        var_23 = 1.467;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_ftl_3rd_kills_456":
      if(var_4 && (!isDefined(level.losersinteractable) || level.losersinteractable == 1)) {
        var_7 = 10;
        var_23 = 1.03;
        var_23 = 2.76;
        var_23 = 1.43;
        level.losersinteractable = 0;
      }

      break;
    case "IW7_mp_taunt_cod_champs":
      var_7 = 7.834;
      break;
    case "iw7_mp_taunt_super_blackhole":
      var_7 = 7;

      for(var_29 = 0; var_29 < 20; var_29++) {
        var_22 = 2.6 + var_29 * 0.1;
      }

      break;
    case "iw7_mp_taunt_epic_grenade_toss_back01":
      var_7 = 8;
      var_22 = 5.7;
      var_22 = 6.15;
      var_22 = 6.6;
      break;
    case "iw7_mp_taunt_super_warfighter_at_screen":
      var_7 = 6.6;
      var_22 = 1;
      var_22 = 1.2;
      var_22 = 1.4;
      var_22 = 1.6;
      var_22 = 1.8;
      var_22 = 2;
      var_22 = 2.2;
      var_22 = 2.4;
      break;
    case "iw7_mp_taunt_bio_spike":
      var_7 = 6.6;
      var_22 = 1.65;
      var_22 = 2.05;
      break;
    case "iw7_mp_taunt_synaptic_reaper_3rd":
    case "iw7_mp_taunt_synaptic_reaper_2nd":
    case "iw7_mp_taunt_synaptic_reaper":
      var_7 = 6.6;
      var_21 = 2;
      break;
    case "iw7_mp_taunt_killstreak_scorcher":
      var_5 = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_6 = "iw7_mp_taunt_killstreak_scorcher_scorcher01";
      var_7 = 6.6;
      var_5 = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_6 = "iw7_mp_taunt_killstreak_scorcher_scorcher02";
      var_7 = 6.6;
      var_5 = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
      var_6 = "iw7_mp_taunt_killstreak_scorcher_scorcher03";
      var_7 = 6.6;
      var_21 = 3;
      var_28 = 1;
      break;
    case "iw7_mp_taunt_killstreak_c8":
      var_5 = "mp_robot_c8";
      var_6 = "iw7_mp_taunt_killstreak_c8_robot";
      var_7 = 5.5;
      var_8 = [];
      var_8[0] = "weapon_c8_shield_top_mp";
      var_8[1] = "weapon_c8_shield_bottom_mp";
      var_9 = [];
      var_9[0] = "j_wristshield";
      var_9[1] = "j_wristbtmshield";
      var_21 = 1.67;
      var_22 = 5.15;
      break;
    case "IW7_mp_taunt_killstreak_apex01":
      var_5 = "veh_mil_air_ca_oblivion_drone_mp";
      var_6 = "IW7_mp_taunt_killstreak_apex01_apex";
      var_7 = 5;
      var_22 = 2;
      var_22 = 2.4;
      var_22 = 2.6;
      var_22 = 3.2;
      var_22 = 3.6;
      var_22 = 3.8;
      break;
    case "iw7_mp_taunt_killstreak_thor":
      var_5 = "veh_mil_air_thor_wm";
      var_5 = "sdf_mp_cruise_missile_01";
      var_5 = "un_mp_jackal_exterior_missile";
      var_5 = "un_mp_jackal_exterior_missile";
      var_5 = "un_mp_jackal_exterior_missile";
      var_5 = "un_mp_jackal_exterior_missile";
      var_5 = "un_mp_jackal_exterior_missile";
      var_6 = "iw7_mp_taunt_killstreak_thor_prop";
      var_6 = "iw7_mp_taunt_killstreak_thor_missile01";
      var_6 = "iw7_mp_taunt_killstreak_thor_missile02";
      var_6 = "iw7_mp_taunt_killstreak_thor_missile03";
      var_6 = "iw7_mp_taunt_killstreak_thor_missile04";
      var_6 = "iw7_mp_taunt_killstreak_thor_missile05";
      var_6 = "iw7_mp_taunt_killstreak_thor_missile05";
      var_7 = 7.47;
      var_7 = 3.76;
      var_7 = 4.7;
      var_7 = 4.7;
      var_7 = 4.7;
      var_7 = 4.7;
      var_7 = 4.7;
      var_13 = 1;
      var_14 = 1.5;
      var_21 = 4.5;
      var_28 = 1;
      break;
    case "IW7_mp_taunt_adrenaline":
      var_5 = "equipment_mp_nanoshot_wm";
      var_6 = "IW7_mp_taunt_adrenaline_nano";
      var_7 = 10;
      var_22 = 7.5;
      break;
    case "iw7_mp_taunt_super_shootdown":
      var_5 = "veh_mil_air_un_uav";
      var_6 = "iw7_mp_taunt_super_shootdown_uav";
      var_7 = 6;
      var_22 = 3.75;
      break;
    case "IW7_mp_taunt_phantom_cloak_3rd":
    case "IW7_mp_taunt_phantom_cloak_2nd":
    case "IW7_mp_taunt_phantom_cloak":
      var_10 = "cloak";
      var_11 = "on";
      var_12 = 0.01;
      var_10 = "cloak";
      var_11 = "off";
      var_12 = 1.5;
      var_10 = "cloak";
      var_11 = "on";
      var_12 = 3.2;
      var_10 = "cloak";
      var_11 = "off";
      var_12 = 4.7;
      var_7 = 5.1;
      var_13 = 1;
      var_14 = 2;
      break;
    case "iw7_mp_taunt_super_merc_steeldragon":
      var_15 = 0.466;
      var_16 = 2.85;
      var_17 = "tag_accessory_right";
      var_18 = "tag_accessory_left";
      var_19 = "vfx_taunt_steel_dragon";
      var_7 = 4;
      var_22 = 0.5;
      var_22 = 0.7;
      var_22 = 0.9;
      var_22 = 1;
      var_22 = 1.2;
      var_22 = 1.4;
      var_22 = 1.6;
      var_22 = 1.8;
      var_22 = 2;
      var_22 = 2.2;
      var_22 = 2.4;
      var_22 = 2.7;
      var_22 = 2.9;
      var_22 = 3.1;
      break;
    case "iw7_mp_taunt_killstreak_laser_strike":
      var_7 = 12;
      var_24 = "vfx_bombard_antigrav_pre_expl";
      var_24 = "vfx_bombard_projectile_trail";
      var_26 = 0.2;
      var_25 = (0, 80, 0);
      var_25 = (75, 140, 0);
      var_25 = (-165, 250, 0);
      var_25 = (50, 200, 0);
      var_25 = (155, 250, 0);
      var_25 = (-75, 140, 0);
      var_25 = (-50, 200, 0);
      var_27 = 1;
      var_27 = 1;
      var_27 = 3.5;
      var_22 = 3.5;
      var_22 = 3.7;
      var_22 = 3.9;
      var_22 = 4.1;
      var_22 = 4.3;
      var_22 = 4.5;
      var_22 = 4.7;
      var_22 = 4.9;
      break;
    default:
      return;
  }

  level.broshotepictauntprops[var_3] = [];
  level.broshotepictauntsubprops[var_3] = [];

  if(var_4 && var_13) {
    if(!isDefined(level.queuedtaunts)) {
      level.queuedtaunts = [];
    }

    if(isDefined(level.queuedtaunts[var_2])) {
      var_30 = gettime() - level.queuedtaunts[var_2];

      if(var_30 < var_14 * 1000) {
        wait var_14 - var_30 / 1000;
      }
    }

    level.queuedtaunts[var_2] = gettime();
  }

  var_31 = (0, 0, 0);

  if(var_28 && isDefined(level.upsidedowntaunts) && level.upsidedowntaunts == 1) {
    var_31 = (180, 180, 0);
  }

  for(var_29 = 0; var_29 < var_5.size; var_29++) {
    var_32 = spawn("script_model", var_3);
    var_32 setModel(var_5[var_29]);
    var_32.angles = var_4 + var_31;
    var_32 notsolid();
    var_32 dontinterpolate();
    var_32 scriptmodelplayanimdeltamotion(var_6[var_29]);

    if(!isDefined(level.broshotepictauntprops)) {
      level.broshotepictauntprops = [];
    }

    level.broshotepictauntprops[var_3][var_29] = var_32;

    if(!(isDefined(var_8[var_29]) && isarray(var_8[var_29]))) {
      continue;
    }

    level.broshotepictauntsubprops[var_3] = [];

    for(var_33 = 0; var_33 < var_8[var_29].size; var_33++) {
      var_34 = spawn("script_model", var_3);
      var_34 setModel(var_8[var_29][var_33]);
      var_34.angles = var_4 + var_31;
      var_34 notsolid();
      var_34 dontinterpolate();
      var_34 linkTo(var_32, var_9[var_29][var_33], (0, 0, 0), (0, 0, 0));
      level.broshotepictauntsubprops[var_3][var_33] = var_34;
    }
  }

  var_35 = 0;

  for(var_29 = 0; var_29 < var_7.size; var_29++) {
    var_35 = max(var_35, var_7[var_29]);
  }

  for(var_29 = 0; var_29 < var_10.size; var_29++) {
    thread doepictauntscriptablestep(var_4, var_3, var_10[var_29], var_11[var_29], var_12[var_29]);
  }

  if(var_4 == 0) {
    var_36 = getplayercharacter(-1);
  } else {
    var_36 = getplayercharacter(var_4);
  }

  if(var_3 != 0) {
    for(var_32 = 0; var_32 < var_16.size; var_32++) {
      thread playbeamfx(var_16[var_32], var_17[var_32], var_20[var_32], var_18[var_32], var_19[var_32], var_36);
    }
  }

  if(var_3 != 0 && var_21 > 0) {
    thread doshellshock(var_21);
  }

  if(var_3 != 0 && var_22 > 0) {
    thread doearthquake(var_22, 1);
  }

  for(var_32 = 0; var_32 < var_23.size; var_32++) {
    thread doearthquake(var_23[var_32], 0);
  }

  for(var_32 = 0; var_32 < var_24.size; var_32++) {
    thread dodisintegrate(var_24[var_32], var_32);
  }

  for(var_32 = 0; var_32 < var_26.size; var_32++) {
    var_37 = anglesToForward(level.camera_bro_shot.basecam.angles);
    var_38 = vectorNormalize((var_37[0], var_37[1], 0));
    var_39 = vectorcross(var_38, (0, 0, 1));
    var_40 = var_38 * var_26[var_32][1];
    var_41 = var_39 * var_26[var_32][0];
    var_42 = var_40 + var_41;

    if(var_3 != 0) {
      var_43 = level.camera_bro_shot.char_loc[0].origin;
    } else {
      var_43 = var_4;
    }

    for(var_34 = 0; var_34 < var_25.size; var_34++) {
      thread dospawnvfx(var_25[var_34], var_28[var_34] + var_27 * var_32, var_42, var_43);
    }
  }

  thread cleanupepictauntprops(var_4, var_36, var_3);
}

function dospawnvfx(var_0, var_1, var_2, var_3) {
  self endon("cancel_taunt_cleanup");
  wait var_1;
  var_4 = var_3 + var_2;
  var_5 = spawnfx(level._effect[var_0], var_4);

  if(isDefined(var_5)) {
    triggerfx(var_5);
    thread delayfxdelete(var_5);
    return;
  }
}

function delayfxdelete(var_0) {
  self endon("cancel_taunt_cleanup");
  wait var_0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function dodisintegrate(var_0, var_1) {
  self endon("cancel_taunt_cleanup");
  wait var_0;

  if(isDefined(level.topplayers[var_1 + 3])) {
    level.topplayers[var_1 + 3].bro hide(1);
    return;
  }
}

function playbeamfx(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("cancel_taunt_cleanup");
  wait var_0;
  var_6 = playfxontagsbetweenclients(level._effect[var_2], var_5, var_3, var_5, var_4);
  thread cleanupbeamfx(var_6, var_1);
}

function cleanupbeamfx(var_0, var_1) {
  waittill_notify_or_timeout("cancel_taunt_cleanup", var_1);
  var_0 delete();
}

function waittill_notify_or_timeout(var_0, var_1) {
  self endon(var_0);
  wait var_1;
}

function doearthquake(var_0, var_1) {
  self endon("cancel_taunt_cleanup");

  if(!isDefined(level.players)) {
    return;
  }

  wait var_0;

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

function doshellshock(var_0) {
  self endon("cancel_taunt_cleanup");
  wait var_0;

  foreach(var_2 in level.players) {
    if(isbot(var_2)) {}
  }
}

function getplayercharacter(var_0) {
  if(var_0 == -1) {
    var_1 = level.charactercac;
  } else {
    var_1 = level.topplayers[var_1].bro;
  }

  return var_1;
}

function doepictauntscriptablestep(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == 0) {
    var_1 = -1;
  }

  self endon("cancel_taunt_cleanup");
  thread listenepictauntscriptablecancel(var_1, var_2);
  wait var_4;
  var_5 = getplayercharacter(var_1);

  if(!isDefined(var_5)) {
    return;
  }

  var_5 setscriptablepartstate(var_2, var_3, 0);
}

function listenepictauntscriptablecancel(var_0, var_1) {
  self waittill("cancel_taunt_cleanup");
  var_2 = getplayercharacter(var_0);
  var_2 setscriptablepartstate(var_1, "offImmediate", 0);
}

function respawnclientcharacter() {
  var_0 = level.charactercac.angles;
  var_1 = level.charactercac.origin;
  level.charactercac delete();
  level.charactercac = spawn("script_character", var_1, 0, 0, 1, "MPClientCharacter");
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
    return;
  }
}

function tauntinprogress(var_0) {
  return isDefined(level.broshotepictauntprops) && isarray(level.broshotepictauntprops) && isDefined(level.broshotepictauntprops[var_0]) && level.broshotepictauntprops[var_0].size > 0;
}

function cleanupepictauntprops(var_0, var_1, var_2) {
  self endon("cancel_taunt_cleanup");
  wait var_1;
  level.taunts_done = 1;
  deleteepictauntprops(var_0);
}

function deleteepictauntprops(var_0) {
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

function processtauntsound(var_0) {
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

    return;
  }
}

function playepicbroshotsound(var_0) {
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

function array_contains(var_0, var_1) {
  if(var_0.size <= 0) {
    return false;
  }

  foreach(var_3 in var_0) {
    if(var_3 == var_1) {
      return true;
    }
  }

  return false;
}