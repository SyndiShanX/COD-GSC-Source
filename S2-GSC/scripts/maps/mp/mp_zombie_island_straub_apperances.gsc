/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_straub_apperances.gsc
******************************************************************/

#using_animtree("animated_props_zombies");

main() {
  level._id_943B = spawnStruct();
  level._id_943B._id_5049 = [];
  level._id_943B._id_5049["s2_zom_straub_window_gaze_idle"] = % s2_zom_straub_window_gaze_idle;
  level._id_943B._id_5049["s2_zom_straub_radio_idle"] = % s2_zom_straub_radio_idle;
  level._id_943B._id_5049["s2_zom_straub_table_cleaver_idle"] = % s2_zom_straub_table_cleaver_idle;
  level._id_943B._id_5049["s2_zom_straub_table_hacksaw_idle"] = % s2_zom_straub_table_hacksaw_idle;
  level._id_943B._id_38E6 = [];
  level._id_943B._id_38E6["s2_zom_straub_window_gaze_exit_1"] = % s2_zom_straub_window_gaze_exit_1;
  level._id_943B._id_38E6["s2_zom_straub_window_gaze_exit_2"] = % s2_zom_straub_window_gaze_exit_2;
  level._id_943B._id_38E6["s2_zom_straub_window_gaze_exit_3"] = % s2_zom_straub_window_gaze_exit_3;
  level._id_943B._id_38E6["s2_zom_straub_window_gaze_exit_4"] = % s2_zom_straub_window_gaze_exit_4;
  level._id_943B._id_38E6["s2_zom_straub_window_gaze_exit_6"] = % s2_zom_straub_window_gaze_exit_6;
  level._id_943B._id_38E6["s2_zom_straub_table_cleaver_exit_4"] = % s2_zom_straub_table_cleaver_exit_4;
  level._id_943B._id_38E6["s2_zom_straub_table_cleaver_exit_6"] = % s2_zom_straub_table_cleaver_exit_6;
  level._id_943B._id_38E6["s2_zom_straub_table_hacksaw_exit_6"] = % s2_zom_straub_table_hacksaw_exit_6;
  level._id_943B._id_241F = _getEnt("straub_bullet_clip", "targetname");
  level._effect["temp_straub_radius"] = loadfx("vfx/weaponimpact/zmb_straub_impact");
  level._id_943B._id_9097 = _id_9442();

  if(!isDefined(level._id_943B._id_9097) || level._id_943B._id_9097.size <= 0) {
    return;
  }
  level._id_943B._id_5B51 = undefined;
  level._id_943B._id_50D6 = 0;
  thread _id_9447();
  thread _id_9445();
}

_id_9445() {
  level endon("stop_straub");
  level waittill("player_spawned");
  thread _id_943D();

  while(level._id_943B._id_9097.size > 0) {
    var_0 = _id_9446();

    if(!isDefined(var_0)) {
      wait 5;
      continue;
    }

    level._id_943B._id_50D6 = 1;
    level._id_943B._id_2913 = var_0;
    var_0 _id_9448();
    level._id_943B._id_50D6 = 0;
    level._id_943B._id_2913 = undefined;
    var_1 = 3;
    var_2 = 5;
    wait(_randomfloatrange(var_1, var_2));
  }
}

_id_943D(var_0) {
  if(!common_scripts\utility::_id_562E(var_0)) {
    while(!_id_0557::_id_7850("Final Boss Island", "Defeat Wustlings")) {
      waitframe();
    }

    _id_0557::_id_7870("Final Boss Island", "Defeat Wustlings");
  }

  level notify("stop_straub");

  if(isDefined(level._id_943B)) {
    if(isDefined(level._id_943B._id_241F)) {
      level._id_943B._id_241F delete();
    }

    if(isDefined(level._id_943B._id_2913)) {
      if(isDefined(level._id_943B._id_2913._id_00B9)) {
        level._id_943B._id_2913._id_00B9 delete();
      }

      if(isDefined(level._id_943B._id_2913._id_9A8E)) {
        level._id_943B._id_2913._id_9A8E delete();
      }

      if(isDefined(level._id_943B._id_2913._id_18A8)) {
        _killfxontag(common_scripts\utility::_id_44F5("temp_straub_radius"), level._id_943B._id_2913._id_18A8, "J_MainRoot");
        level._id_943B._id_2913._id_18A8 delete();
      }
    }

    level._id_943B._id_50D6 = 0;
  }
}

_id_9446() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = level._id_943B._id_9097;

  while(!var_0) {
    var_3 = common_scripts\utility::random(var_2);
    var_4 = _id_943C(var_3);

    if(!var_4) {
      var_1 = var_3;
      level._id_943B._id_9097 = common_scripts\utility::_id_0F93(level._id_943B._id_9097, var_3);
      var_0 = 1;
    } else
      var_2 = common_scripts\utility::_id_0F93(var_2, var_3);

    if(var_2.size <= 0) {
      break;
    }
  }

  return var_1;
}

_id_9442() {
  var_0 = common_scripts\utility::_id_46B7("Straub", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      if(!isDefined(var_5._id_0165)) {
        var_2._id_65F8 = var_5;
        var_2._id_65F8._id_565E = 0;
        continue;
      }

      switch (var_5._id_0165) {
        case "straub_trig":
          var_2._id_65F8 = var_5;
          var_2._id_65F8._id_565E = 0;
          break;
        case "straub_look_origin":
          var_2._id_5EB4 = var_5.origin;
          break;
      }
    }

    var_2._id_4B56 = 0;
    var_2._id_9A8E = undefined;
    var_2._id_5046 = var_2._id_0165;
    var_2._id_38E4 = var_2.animation;
    var_2._id_38E5 = var_2.getnegotiationnextnode;

    if(!isDefined(var_2._id_5EB4)) {
      var_2._id_5EB4 = var_2.origin;
    }
  }

  return var_0;
}

_id_9448() {
  level endon("stop_straub");
  childthread _id_944A();
  self._id_18A8 = spawn("script_model", self.origin);
  self._id_18A8.angles = self.angles;
  self._id_18A8 setModel("zom_straub_wholebody_dlc");
  self._id_00B9 = spawn("script_model", self.origin);
  self._id_00B9 setModel("zom_head_kier_dirt_org1_dlc");
  self._id_00B9 linkTo(self._id_18A8, "j_spineupper", (0, 0, 0), (0, 0, 0));

  if(isDefined(level._id_943B._id_241F)) {
    thread _id_943F();
  }

  var_0 = undefined;
  var_1 = undefined;

  if(self._id_5046 == "s2_zom_straub_table_hacksaw_idle") {
    var_0 = "npc_zom_ger_med_saw_01";
    var_1 = "s2_zom_straub_medical_props_hacksaw_idle";
  } else if(self._id_5046 == "s2_zom_straub_table_cleaver_idle") {
    var_0 = "npc_zom_med_knife_02";
    var_1 = "s2_zom_straub_medical_props_cleaver_idle";
  }

  if(isDefined(var_0)) {
    self._id_9A8E = spawn("script_model", self.origin);
    self._id_9A8E setModel(var_0);
    self._id_9A8E linkTo(self._id_18A8, "TAG_WEAPON_RIGHT", (0, 0, 0), (0, 0, 0));
  }

  while(!self._id_65F8._id_565E) {
    self._id_18A8 scriptmodelplayanimdeltamotion(self._id_5046);
    self._id_00B9 scriptmodelplayanimdeltamotion(self._id_5046);
    wait(_getanimlength(level._id_943B._id_5049[self._id_5046]));
  }

  level._id_943B._id_5B51 = gettime();
  self._id_18A8 scriptmodelplayanimdeltamotion(self._id_38E4);
  self._id_00B9 scriptmodelplayanimdeltamotion(self._id_38E4);
  var_2 = 0;

  if(isDefined(self._id_9A8E)) {
    var_3 = _getnotetracktimes(level._id_943B._id_38E6[self._id_38E4], "drop_tool");
    var_4 = _getanimlength(level._id_943B._id_38E6[self._id_38E4]);
    var_2 = var_3[0] * var_4;
    wait(var_2);
    self._id_9A8E unlink();
  }

  if(isDefined(self._id_38E5)) {
    wait(_id_0547::_id_9470(self._id_38E5) - var_2);

    if(isDefined(level._id_943B._id_241F)) {
      level._id_943B._id_241F unlink();
    }

    _killfxontag(common_scripts\utility::_id_44F5("temp_straub_radius"), self._id_18A8, "J_MainRoot");
    self._id_00B9 delete();

    if(isDefined(self._id_9A8E)) {
      self._id_9A8E delete();
    }

    self._id_18A8 delete();
    self notify("straub_destroyed");
  }
}

_id_943F() {
  self endon("straub_destroyed");
  level._id_943B._id_241F.origin = self._id_18A8.origin;
  level._id_943B._id_241F linkTo(self._id_18A8, "tag_origin", (0, 0, 32), (0, 0, 0));
  level._id_943B._id_241F setCanDamage(1);
  level._id_943B._id_241F thread maps\mp\gametypes\_damage::_id_8676(1, undefined, ::_id_9440, ::_id_943E);
}

_id_943E(var_0, var_1, var_2, var_3) {
  thread _id_9449();

  if(isDefined(var_0) && isPlayer(var_0)) {
    if(!isDefined(var_0.straub_shots)) {
      var_0.straub_shots = 0;
    }

    var_0.straub_shots++;

    if(var_0.straub_shots == 1 && maps\mp\_utility::_id_4571() == "mp_zombie_island") {
      var_0 maps\mp\gametypes\zombies::_id_47C8("DLC1_ZM_LURKING");
    }
  }

  return 0;
}

_id_9449() {
  if(!common_scripts\utility::_id_562E(self._id_299E)) {
    playFX(common_scripts\utility::_id_44F5("temp_straub_radius"), self.origin + (0, 0, 32));
    self._id_299E = 1;
    wait 0.25;
    self._id_299E = 0;
  }
}

_id_9440(var_0, var_1, var_2, var_3) {
  playFX(common_scripts\utility::_id_44F5("temp_straub_radius"), self.origin + (0, 0, 48));
}

_id_944A() {
  for(;;) {
    self._id_65F8 waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(_id_9444(var_0)) {
      self._id_65F8._id_565E = 1;
      self._id_4B56 = 1;
      break;
    }
  }
}

_id_9444(var_0) {
  var_1 = _id_9441(var_0);
  var_2 = _id_9443(var_1);

  if(var_2) {
    var_2 = _bullettracepassed(self._id_5EB4, var_0 getEye(), 0, self._id_18A8);
  }

  return var_2;
}

_id_9441(var_0) {
  var_1 = self._id_5EB4 - var_0 getEye();
  var_2 = vectorNormalize((var_1[0], var_1[1], 0));
  var_3 = anglesToForward(var_0.angles);
  var_4 = vectorNormalize((var_3[0], var_3[1], 0));
  var_5 = vectordot(var_2, var_4);
  var_5 = clamp(var_5, -1, 1);
  var_6 = _acos(var_5);
  return var_6;
}

_id_9443(var_0) {
  var_1 = var_0 < 40;
  return var_1;
}

_id_943C(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  foreach(var_2 in level.players) {
    if(var_0 _id_9444(var_2)) {
      return 1;
    }
  }

  return 0;
}

_id_9447() {
  level._id_6DD4 = common_scripts\utility::_id_46B7("pa_loudspeaker", "targetname");
  level._id_6DD5 = [];
  level._id_6DD7 = [];
  level._id_6DD6 = [];

  foreach(var_1 in level._id_6DD4) {
    if(!isDefined(var_1._id_0165)) {
      continue;
    }
    var_2 = var_1._id_0165;

    switch (var_2) {
      case "bunker_speaker":
        level._id_6DD5[level._id_6DD5.size] = var_1;

        if(_id_0547::_id_5565(var_1.setlookatent, "straub_office_speaker")) {
          level._id_6DD6[level._id_6DD6.size] = var_1;
        }

        break;
      case "village_speaker":
        level._id_6DD7[level._id_6DD7.size] = var_1;
        break;
    }
  }

  level._id_943B._id_90C2 = 0;
  level._id_943B._id_3C54 = 0;
  level._id_943B._id_7F00 = 0;
  level._id_943B._id_5D99 = [];
  level._id_943B._id_13B1 = [];
  level._id_943B _id_09EF("intro", "zmb_nst01_stra_youmustbeklausfriendsthea", 14, undefined);
  level._id_943B _id_09EF("breached", "zmb_nst01_stra_theyvealreadybreachedthel", 9, undefined);
  level._id_943B _id_09EF("idiot", "zmb_nst01_stra_thatidiotrichterisstillbu", 10, undefined);
  level._id_943B _id_09EF("attuned", "zmb_nst01_stra_iveattunedourelektroschna", 19, undefined);
  level._id_943B _id_09EF("magnet", "zmb_nst01_vlogs_stra_log02_01", 15, undefined);
  level._id_943B _id_09EF("untota_1", "zmb_nst01_vlogs_stra_log02_16", 31, "untota_2");
  level._id_943B _id_09EF("untota_2", "zmb_nst01_vlogs_stra_log02_17", 26, undefined);
  level._id_943B _id_09EF("dead_1", "zmb_nst01_vlogs_stra_log03_10", 29, undefined);
  level._id_943B _id_09EF("foul_1", "zmb_nst01_vlogs_stra_log03_11", 18, "foul_2");
  level._id_943B _id_09EF("foul_2", "zmb_nst01_vlogs_stra_log03_12", 11, undefined);
  level._id_943B _id_09EF("protection_1", "zmb_nst01_vlogs_stra_log04_04", 12, "protection_2");
  level._id_943B _id_09EF("protection_2", "zmb_nst01_vlogs_stra_log04_05", 14, undefined);
  level._id_943B _id_09EF("sword_1", "zmb_nst01_vlogs_stra_log04_07", 26, "sword_2");
  level._id_943B _id_09EF("sword_2", "zmb_nst01_vlogs_stra_log04_08", 29, undefined);
  level._id_943B _id_09EF("mastery_1", "zmb_nst01_vlogs_stra_log04_10", 30, undefined);
}

_id_09EF(var_0, var_1, var_2, var_3) {
  self._id_5D99[var_0] = spawnStruct();
  self._id_5D99[var_0]._id_0BB4 = var_1;
  self._id_5D99[var_0].duration = var_2;
  self._id_5D99[var_0]._id_3DD3 = var_3;

  if(!issubstr(var_0, "_2") && !issubstr(var_0, "_3") && !issubstr(var_0, "_4")) {
    self._id_13B1[self._id_13B1.size] = var_0;
  }
}

_id_7CFC(var_0) {
  if(!issubstr(var_0, "_2") && !issubstr(var_0, "_3") && !issubstr(var_0, "_4")) {
    level._id_943B._id_13B1 = common_scripts\utility::_id_0F93(level._id_943B._id_13B1, var_0);
  }
}

_id_46B3(var_0) {
  var_1 = level._id_943B._id_5D99[var_0]._id_0BB4;
  var_2 = level._id_943B._id_5D99[var_0].duration;
  var_3 = undefined;

  if(isDefined(level._id_943B._id_5D99[var_0]._id_3DD3)) {
    var_3 = level._id_943B._id_5D99[var_0]._id_3DD3;
  }

  return [var_1, var_2, var_3];
}

_id_74E1(var_0, var_1) {
  level endon("straub_taunt_force_stop");
  _id_0378::_id_8D74("play_pa_dialog", var_0, level._id_6DD7, level._id_6DD5);
  wait(var_1);
}

_id_93F6() {
  level notify("straub_taunt_force_stop");
  _id_0378::_id_8D74("stop_pa_dialog");
}

_id_74E2(var_0, var_1) {
  if(level._id_7F24 == 0) {
    return;
  }
  if(common_scripts\utility::_id_562E(level._id_22F0)) {
    return;
  }
  if(common_scripts\utility::_id_562E(level.blimpvoplaying)) {
    return;
  }
  if(level._id_943B._id_50D6) {
    if(isDefined(level._id_943B._id_2913)) {
      if(_id_943C(level._id_943B._id_2913)) {
        return;
      } else if(isDefined(level._id_943B._id_2913._id_18A8)) {
        level._id_943B._id_2913._id_18A8 hide();
        level._id_943B._id_2913._id_00B9 hide();

        if(isDefined(level._id_943B._id_2913._id_9A8E)) {
          level._id_943B._id_2913._id_9A8E hide();
        }
      }
    }
  }

  var_2 = undefined;
  var_3 = undefined;
  var_4 = 0;
  var_5 = undefined;

  if(!level._id_943B._id_3C54) {
    var_2 = "intro";
    [var_3, var_4, var_5] = _id_46B3(var_2);
    level._id_943B._id_90C2 = 1;
    _id_0378::_id_8D74("snd_zmb_mus_stop_all_players", 4);
    wait 2;
    thread _id_74E1(var_3, var_4);
    level._id_943B._id_3C54 = 1;
    wait(var_4);
    level._id_943B._id_90C2 = 0;
    _id_7CFC(var_2);
  } else {
    if(level._id_943B._id_90C2) {
      return;
    }
    if(level._id_943B._id_13B1.size == 0) {
      return;
    }
    if(level._id_943B._id_7F00 < 3 && !common_scripts\utility::_id_562E(var_0) && !common_scripts\utility::_id_562E(var_1)) {
      level._id_943B._id_7F00++;
      return;
    }

    if((common_scripts\utility::_id_24A6() || common_scripts\utility::_id_562E(var_0)) && !common_scripts\utility::_id_562E(var_1)) {
      level._id_943B._id_90C2 = 1;
      _id_0378::_id_8D74("snd_zmb_mus_stop_all_players", 4);
      wait 2;
      var_2 = common_scripts\utility::random(level._id_943B._id_13B1);
      [var_3, var_4, var_5] = _id_46B3(var_2);

      if(!isDefined(var_3)) {
        return;
      }
      if(!isDefined(var_5)) {
        _id_74E1(var_3, var_4);
        _id_7CFC(var_2);
      } else {
        for(;;) {
          _id_74E1(var_3, var_4);
          _id_7CFC(var_2);

          if(isDefined(var_5)) {
            var_2 = var_5;
            [var_3, var_4, var_5] = _id_46B3(var_2);
            continue;
          }

          break;
        }
      }

      level._id_943B._id_90C2 = 0;
      level._id_943B._id_7F00 = 0;
    } else {
      _id_0378::_id_8D74("snd_zmb_mus_stop_all_players", 4);
      _id_0378::_id_8D74("play_pa_music", level._id_6DD6);
    }
  }

  if(level._id_943B._id_50D6) {
    if(isDefined(level._id_943B._id_2913) && isDefined(level._id_943B._id_2913._id_18A8)) {
      level._id_943B._id_2913._id_18A8 show();
      level._id_943B._id_2913._id_00B9 show();

      if(isDefined(level._id_943B._id_2913._id_9A8E)) {
        level._id_943B._id_2913._id_9A8E show();
      }
    }
  }
}