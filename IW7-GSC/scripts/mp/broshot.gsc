/**********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\broshot.gsc
**********************************/

initbroshotfx() {
  level._effect["FX_BRO_LIGHT"] = loadfx("vfx\iw7\_requests\mp\broshot\vfx_bs_light_fill.vfx");
  level._effect["vfx_taunt_steel_dragon"] = loadfx("vfx\iw7\_requests\mp\frontend\vfx_taunt_steel_dragon.vfx");
  level._effect["vfx_bombard_antigrav_pre_expl"] = loadfx("vfx\iw7\_requests\mp\vfx_bombard_antigrav_pre_expl.vfx");
  level._effect["vfx_bombard_projectile_trail"] = loadfx("vfx\iw7\_requests\mp\vfx_bombard_projectile_trail.vfx");
  level._effect["vfx_bombardment_strike_explosion"] = loadfx("vfx\iw7\_requests\mp\vfx_bombardment_strike_explosion.vfx");
  level._effect["vfx_tnt_crate_smk"] = loadfx("vfx\iw7\levels\mp_frontend\vfx_tnt_crate_smk.vfx");
}

forceinitbroshot() {
  level.forcebroshot = 1;
  setomnvar("ui_broshot_debug", 1);
  return initbroshot();
}

initbroshot(param_00) {
  level.camera_bro_shot = spawnStruct();
  level.camera_bro_shot.basecam = getent("camera_mp_broshot", "targetname");
  level.camera_bro_shot.char_loc[0] = getent("character_loc_broshot", "targetname");
  level.camera_bro_shot.char_loc[2] = getent("character_loc_broshot_a", "targetname");
  level.camera_bro_shot.char_loc[1] = getent("character_loc_broshot_b", "targetname");
  level.camera_bro_shot.char_loc[3] = getent("character_loc_broshot_c", "targetname");
  level.camera_bro_shot.char_loc[4] = getent("character_loc_broshot_d", "targetname");
  level.camera_bro_shot.char_loc[5] = getent("character_loc_broshot_e", "targetname");
  if((!isDefined(self) || !isDefined(level.camera_bro_shot.basecam) || !isDefined(level.teamlist) || !isDefined(level.teamlist["allies"]) || !isDefined(level.teamlist["axis"]) || level.teamlist["allies"].size == 0 && level.teamlist["axis"].size == 0) && !scripts\mp\utility::istrue(level.forcebroshot)) {
    return 0;
  }

  if(level.teambased && !scripts\mp\utility::istrue(level.forcebroshot)) {
    if(!isDefined(param_00)) {
      var_01 = getteamscore("allies");
      var_02 = getteamscore("axis");
      if(var_01 == var_02) {
        return 0;
      }
    } else if(param_00 == "tie" || param_00 == "none" || param_00 == "draw") {
      return 0;
    }
  } else {
    var_03 = scripts\engine\utility::array_sort_with_func(level.players, ::compare_player_score);
    if(!scripts\mp\utility::istrue(level.forcebroshot) && var_03[0].destroynavrepulsor <= 0) {
      return 0;
    }
  }

  level.camera_bro_shot.myfov = 40;
  level.camera_bro_shot.char_loc[0].origin = level.camera_bro_shot.char_loc[0].origin + anglestoleft(level.camera_bro_shot.char_loc[0].angles) * 6;
  level.camera_bro_shot.char_loc[2].origin = level.camera_bro_shot.char_loc[2].origin + anglestoleft(level.camera_bro_shot.char_loc[2].angles) * 20;
  level.camera_bro_shot.char_loc[1].origin = level.camera_bro_shot.char_loc[1].origin + anglestoleft(level.camera_bro_shot.char_loc[1].angles) * 12;
  level.camera_bro_shot.char_loc[4].origin = level.camera_bro_shot.char_loc[4].origin + anglestoleft(level.camera_bro_shot.char_loc[4].angles) * 6;
  level.camera_bro_shot.char_loc[3].origin = level.camera_bro_shot.char_loc[3].origin + anglestoright(level.camera_bro_shot.char_loc[3].angles) * 0;
  level.camera_bro_shot.char_loc[5].origin = level.camera_bro_shot.char_loc[5].origin + anglestoleft(level.camera_bro_shot.char_loc[5].angles) * 18;
  level.camera_bro_shot.char_loc[4].origin = level.camera_bro_shot.char_loc[4].origin + anglesToForward(level.camera_bro_shot.char_loc[4].angles) * -46;
  level.camera_bro_shot.char_loc[3].origin = level.camera_bro_shot.char_loc[3].origin + anglesToForward(level.camera_bro_shot.char_loc[3].angles) * -46;
  level.camera_bro_shot.char_loc[5].origin = level.camera_bro_shot.char_loc[5].origin + anglesToForward(level.camera_bro_shot.char_loc[5].angles) * -46;
  setomnvar("ui_broshot_upside_down", scripts\mp\utility::istrue(level.upsidedowntaunts));
  for(var_04 = 3; var_04 < 6; var_04++) {
    if(scripts\mp\utility::istrue(level.upsidedowntaunts)) {
      var_05 = level.camera_bro_shot.char_loc[var_04].origin + (0, 0, 25);
      var_06 = (var_05[0], var_05[1], var_05[2] - 100);
    } else {
      var_05 = level.camera_bro_shot.char_loc[var_04].origin;
      var_06 = (var_05[0], var_05[1], var_05[2] + 100);
    }

    var_07 = scripts\common\trace::create_contents(0, 1, 1, 1, 1, 0, 0);
    var_08 = physics_raycast(var_06, var_05, var_07, undefined, 1, "physicsquery_closest");
    var_09 = isDefined(var_08) && var_08.size > 0;
    if(var_09) {
      var_0A = var_08[0]["position"];
      level.camera_bro_shot.char_loc[var_04].origin = var_0A;
    }
  }

  self.mvparray = [];
  return 1;
}

startbroshot(param_00) {
  if(!isDefined(param_00)) {
    param_00 = self;
  }

  level.broshotrunning = 1;
  cleanupequipment();
  cleanupgamemodes();
  var_01 = spawnStruct();
  if(scripts\mp\utility::istrue(level.upsidedowntaunts)) {
    var_01.origin = level.camera_bro_shot.char_loc[0].origin + (30, -15, -95);
    var_01.angles = level.camera_bro_shot.basecam.angles + (162, 180, 0);
  } else {
    var_01.origin = level.camera_bro_shot.char_loc[0].origin;
    var_01.angles = level.camera_bro_shot.basecam.angles;
  }

  foreach(var_03 in level.players) {
    var_03 scripts\mp\playerlogic::respawn_asspectator(var_01.origin, var_01.angles);
    var_03 scripts\mp\gamelogic::freezeplayerforroundend();
    var_03 getweaponrankxpmultiplier();
  }

  removeallcorpses();
  level.active_camera = var_01;
  level.camera_anchor = spawn("script_model", var_01.origin);
  level.camera_anchor setModel("tag_origin");
  level.camera_anchor.angles = var_01.angles;
  thread spawnfilllight();
  if(scripts\mp\utility::istrue(level.forcebroshot)) {
    if(level.teamlist["allies"].size > 1) {
      level.topplayers = scripts\engine\utility::array_sort_with_func(level.teamlist["allies"], ::compare_player_score);
    } else {
      level.topplayers = [];
      level.topplayers[0] = self;
    }
  } else if(level.teambased) {
    if(!isDefined(param_00)) {
      var_05 = getteamscore("allies");
      var_06 = getteamscore("axis");
      var_07 = scripts\engine\utility::ter_op(var_05 >= var_06, "allies", "axis");
    } else {
      var_07 = var_01;
    }

    level.topplayers = scripts\engine\utility::array_sort_with_func(level.teamlist[var_07], ::compare_player_score);
  } else {
    level.topplayers = level.placement["all"];
  }

  level.supergunout = [];
  level.interruptabletaunts = [];
  level.firsttaunttracker = [];
  foreach(var_03 in level.players) {
    var_03 hideeffectsforbroshot();
  }

  for(var_0A = 0; var_0A < 6; var_0A++) {
    if(!isDefined(level.topplayers[var_0A])) {
      break;
    }

    if(!isDefined(level.topplayers[var_0A].loadoutarchetype)) {
      continue;
    }

    self.mvparray[var_0A] = spawnStruct();
    if(level.gametype == "infect") {
      if(isbot(level.topplayers[var_0A])) {
        var_0B = level.topplayers[var_0A].loadoutarchetype;
      } else {
        var_0B = level.topplayers[var_0A] scripts\mp\class::cac_getcharacterarchetype();
      }
    } else {
      var_0B = level.topplayers[var_0A].loadoutarchetype;
    }

    var_0C = tablelookuprownum("mp\battleRigTable.csv", 1, var_0B);
    if(isbot(level.topplayers[var_0A]) || isDefined(level.topplayers[var_0A].lastarchetypeinfo)) {
      var_0D = level.topplayers[var_0A] getcustomizationbody();
      var_0E = level.topplayers[var_0A] getcustomizationhead();
      var_0F = tablelookuprownum("mp\cac\heads.csv", 1, var_0E);
      var_10 = tablelookuprownum("mp\cac\bodies.csv", 1, var_0D);
      if(isDefined(level.topplayers[var_0A].lastarchetypeinfo)) {
        var_0C = tablelookuprownum("mp\battleRigTable.csv", 1, level.topplayers[var_0A].lastarchetypeinfo.archetype);
      }
    } else {
      var_10 = level.topplayers[var_0A] scripts\mp\teams::getplayermodelindex();
      var_0F = level.topplayers[var_0A] scripts\mp\teams::getplayerheadmodel();
    }

    self.mvparray[var_0A].setprintchannel = var_0C;
    self.mvparray[var_0A].var_6A = var_10;
    self.mvparray[var_0A].playfxontag = var_0F;
    self.mvparray[var_0A].var_39C = getdisplayweapon(level.topplayers[var_0A]);
    self.mvparray[var_0A].var_9C = level.topplayers[var_0A] getclantag();
    self.mvparray[var_0A].name = level.topplayers[var_0A].name;
    self.mvparray[var_0A].var_3A3 = level.topplayers[var_0A] getxuid();
    self.mvparray[var_0A].podiumindex = var_0A;
    self.mvparray[var_0A].clientnum = level.topplayers[var_0A] getentitynumber();
    level.topplayers[var_0A] setguntypeforui(var_0A);
    level.topplayers[var_0A].bro = makebrowinner(var_0A, level.camera_bro_shot.char_loc[var_0A]);
  }

  foreach(var_03 in level.players) {
    var_03 setsoundsubmix("mp_broshot");
    var_03 setsolid(0);
    var_03 dontinterpolate();
    if(isbot(var_03)) {
      continue;
    }

    var_03 cameralinkto(level.camera_anchor, "tag_origin", 1);
    var_03 thread scripts\mp\utility::setuipostgamefade(0);
    scripts\mp\utility::_visionsetnaked("", 0);
    if(!scripts\mp\utility::istrue(level.forcebroshot)) {
      var_03 thread fadetoblack(1.5);
    }
  }

  level.camera_anchor scriptmodelplayanimdeltamotion("iw7_mp_brodium_cam");
  thread tauntinputlisten(level.topplayers);
  level thread onplayerconnect();
  startpodium(-1, self.mvparray);
  return 13.5;
}

hideeffectsforbroshot() {
  if(self.sessionteam == "spectator") {
    return;
  }

  if(!isDefined(self.loadoutarchetype)) {
    return;
  }

  self setscriptablepartstate("cloak", "offImmediate", 1);
  self setscriptablepartstate("jet_pack", "off", 1);
  self setscriptablepartstate("teamColorPins", "off", 1);
  self setscriptablepartstate("armorUpMaterial", "offImmediate", 1);
  self setscriptablepartstate("armorUp", "neutral", 1);
  self setscriptablepartstate("light_armor", "neutral", 1);
  self setscriptablepartstate("adrenaline", "neutral", 1);
  self setscriptablepartstate("adrenalineHeal", "neutral", 1);
  self setscriptablepartstate("pts_drone", "off", 1);
}

spawnfilllight() {
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("FX_BRO_LIGHT"), level.camera_anchor, "tag_origin");
}

fadetoblack(param_00) {
  wait(12);
  scripts\mp\utility::_visionsetnaked("", 0);
  foreach(var_02 in level.players) {
    if(isbot(var_02)) {
      continue;
    }

    var_02 visionsetfadetoblackforplayer("bw", param_00);
  }
}

cleanupequipment() {
  self notify("bro_shot_start");
  scripts\mp\weapons::deleteallgrenades();
  var_00 = getweaponarray();
  if(isDefined(var_00)) {
    foreach(var_02 in var_00) {
      var_02 delete();
    }
  }
}

cleanupgamemodes() {
  if(isDefined(level.teamflags)) {
    if(isDefined(level.teamflags[game["attackers"]]) && isDefined(level.teamflags[game["attackers"]].visuals)) {
      for(var_00 = 0; var_00 < level.teamflags[game["attackers"]].visuals.size; var_00++) {
        level.teamflags[game["attackers"]].visuals[var_00] hide();
      }
    }

    if(isDefined(level.teamflags[game["defenders"]]) && isDefined(level.teamflags[game["defenders"]].visuals)) {
      for(var_00 = 0; var_00 < level.teamflags[game["defenders"]].visuals.size; var_00++) {
        level.teamflags[game["defenders"]].visuals[var_00] hide();
      }
    }
  }

  if((level.gametype == "dom" || level.gametype == "siege") && isDefined(level.domflags)) {
    foreach(var_02 in level.domflags) {
      if(isDefined(var_02)) {
        var_02.physics_capsulecast setscriptablepartstate("flag", "off");
        var_02.physics_capsulecast setscriptablepartstate("pulse", "off");
      }
    }
  }

  if(level.gametype == "grind" && isDefined(level.var_13FC1)) {
    foreach(var_05 in level.var_13FC1) {
      if(isDefined(var_05) && isDefined(var_05.physics_capsulecast)) {
        var_05.physics_capsulecast setscriptablepartstate("flag", "off");
        var_05.physics_capsulecast setscriptablepartstate("pulse", "off");
      }
    }
  }

  if((level.gametype == "sr" || level.gametype == "dd" | level.gametype == "sd") && isDefined(level.bombzones)) {
    foreach(var_08 in level.bombzones) {
      if(isDefined(var_08) && isDefined(var_08.visuals)) {
        for(var_09 = 0; var_09 < var_08.visuals.size; var_09++) {
          if(isDefined(var_08.visuals[var_09])) {
            var_08.visuals[var_09] hide();
          }
        }
      }
    }
  }

  if(level.gametype == "front" && isDefined(level.zones)) {
    foreach(var_05 in level.zones) {
      if(isDefined(var_05) && isDefined(var_05.visuals)) {
        for(var_09 = 0; var_09 < var_05.visuals.size; var_09++) {
          var_05.visuals[var_09] hide();
        }
      }
    }
  }

  if(scripts\mp\utility::istrue(level.dogtagsenabled)) {
    if(isDefined(level.dogtags)) {
      foreach(var_0E in level.dogtags) {
        if(isDefined(var_0E) && isDefined(var_0E.visuals)) {
          for(var_09 = 0; var_09 < var_0E.visuals.size; var_09++) {
            var_0E.visuals[var_09] hide();
          }
        }
      }
    }
  }

  if(isDefined(level.balls)) {
    foreach(var_11 in level.balls) {
      var_11.visuals[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
    }
  }

  if((level.gametype == "koth" || level.gametype == "grnd") && isDefined(level.zones)) {
    foreach(var_05 in level.zones) {
      if(isDefined(var_05) && isDefined(var_05.useobj) && isDefined(var_05.useobj.chevrons)) {
        foreach(var_15 in var_05.useobj.chevrons) {
          for(var_09 = 0; var_09 < var_15.numchevrons; var_09++) {
            var_15 setscriptablepartstate("chevron_" + var_09, "off");
          }
        }
      }
    }
  }
}

tauntinputlisten(param_00) {
  wait(3);
  for(var_01 = 0; var_01 < 3; var_01++) {
    if(!isDefined(param_00[var_01]) || isbot(param_00[var_01])) {
      continue;
    }

    param_00[var_01] thread listenfortauntinput(var_01);
  }
}

getdisplayweapon(param_00) {
  var_01 = param_00.lastdroppableweaponobj;
  if(!issubstr(var_01, param_00.pers["primaryWeapon"]) && !issubstr(var_01, param_00.pers["secondaryWeapon"])) {
    var_01 = param_00.spawnweaponobj;
  }

  if(issubstr(var_01, "iw7_fists_mp") || issubstr(var_01, "iw7_knife") || issubstr(var_01, "iw7_axe")) {
    var_01 = param_00.pers["secondaryWeapon"];
  }

  if(issubstr(var_01, "nunchucks") || issubstr(var_01, "katana")) {
    var_01 = "iw7_fists_mp";
  }

  return var_01;
}

camera_move_helper(param_00, param_01, param_02, param_03) {
  self predictstreampos(param_00.origin);
  wait(param_02);
  level.camera_anchor scriptmodelclearanim();
  var_04 = distance(level.camera_anchor.origin, param_00.origin);
  var_05 = var_04 / param_01;
  if(var_05 < 0.05) {
    var_05 = 0.05;
  }

  level.camera_anchor.move_target = param_00;
  level.camera_anchor moveto(param_00.origin, var_05);
  level.camera_anchor rotateto(param_00.angles, var_05);
  if(isDefined(param_03)) {
    wait(var_05 - param_03);
    thread scripts\mp\utility::setuipostgamefade(param_03);
  }
}

endbroshot() {
  level.broshotrunning = undefined;
  self notify("broshot_done");
  foreach(var_01 in level.players) {
    var_01 clearsoundsubmix();
  }
}

makebrowinner(param_00, param_01) {
  var_02 = spawn("script_character", param_01.origin, 0, 0, param_00);
  var_02.angles = param_01.angles;
  if(scripts\mp\utility::istrue(level.nukegameover) && param_00 == 0) {
    playFX(scripts\engine\utility::getfx("mons_screen_ash"), param_01.origin);
  }

  return var_02;
}

listenfortauntinput(param_00) {
  if(!isai(self) && scripts\engine\utility::is_player_gamepad_enabled()) {
    self notifyonplayercommand("bro_action_1", "+actionslot 1");
    self notifyonplayercommand("bro_action_2", "+actionslot 2");
    self notifyonplayercommand("bro_action_3", "+actionslot 3");
    self notifyonplayercommand("bro_action_4", "+actionslot 4");
  } else {
    self notifyonplayercommand("bro_action_1", "+actionslot 3");
    self notifyonplayercommand("bro_action_2", "+actionslot 4");
    self notifyonplayercommand("bro_action_3", "+actionslot 5");
    self notifyonplayercommand("bro_action_4", "+actionslot 6");
  }

  for(;;) {
    thread listenfortaunt(param_00, 1);
    thread listenfortaunt(param_00, 2);
    thread listenfortaunt(param_00, 3);
    thread listenfortaunt(param_00, 4);
    self waittill("taunt_end");
  }
}

listenfortaunt(param_00, param_01) {
  self endon("taunt_start");
  self endon("broshot_done");
  for(;;) {
    self waittill("bro_action_" + param_01);
    thread dotaunt(param_00, param_01);
    wait(0.05);
  }
}

dotaunt(param_00, param_01) {
  self notify("taunt_start");
  self endon("broshot_done");
  if(isDefined(self.changedarchetypeinfo)) {
    var_02 = level.archetypeids[self.changedarchetypeinfo.archetype];
    if(level.rankedmatch) {
      var_03 = self getplayerdata("rankedloadouts", "squadMembers", "archetypePreferences", var_02, "taunts", param_01 - 1);
    } else {
      var_03 = self getplayerdata("privateloadouts", "squadMembers", "archetypePreferences", var_02, "taunts", param_01 - 1);
    }
  } else if(level.rankedmatch) {
    var_03 = self getplayerdata("rankedloadouts", "squadMembers", "taunts", var_03 - 1);
  } else {
    var_03 = self getplayerdata("privateloadouts", "squadMembers", "taunts", var_03 - 1);
  }

  if(isDefined(level.overridebroslot)) {
    param_00 = level.overridebroslot - 1;
  }

  if(isDefined(level.overridetaunt)) {
    var_03 = tablelookup("mp\cac\taunts.csv", 0, level.overridetaunt, 1);
  }

  var_04 = tablelookuprownum("mp\cac\taunts.csv", 1, var_03);
  var_05 = tablelookup("mp\cac\taunts.csv", 0, var_04, 5);
  if(var_05 == "") {
    return;
  }

  var_06 = tablelookup("mp\cac\taunts.csv", 0, var_04, 19);
  var_07 = tablelookup("mp\cac\taunts.csv", 0, var_04, 20);
  var_08 = tablelookup("mp\cac\taunts.csv", 0, var_04, 21);
  var_09 = tablelookup("mp\cac\taunts.csv", 0, var_04, 12) == "Y";
  var_0A = tablelookup("mp\cac\taunts.csv", 0, var_04, 9);
  var_0B = "ui_broshot_anim_" + param_00;
  if(isDefined(level.interruptabletaunts[param_00]) && level.interruptabletaunts[param_00] == var_0A) {
    self notify("taunt_end");
    return;
  }

  var_0C = getdisplayweapon(self) == "none" || getdisplayweapon(self) == "iw7_fists_mp";
  if(!isDefined(level.firsttaunttracker[var_0B]) && !var_0C) {
    if(!var_09 && isDefined(level.supergunout[var_0B])) {
      level.firsttaunttracker[var_0B] = 1;
      putgunaway(var_0B);
    }

    if(!var_09) {
      level.supergunout[var_0B] = undefined;
    }
  }

  if(var_09 && !isDefined(level.supergunout[var_0B])) {
    level.firsttaunttracker[var_0B] = undefined;
    takesupergunout(var_0B, var_05);
    level.supergunout[var_0B] = 1;
  }

  var_0D = tablelookup("mp\cac\taunts.csv", 0, var_04, 17);
  var_0E = tablelookup("mp\cac\taunts.csv", 0, var_04, 18);
  if(param_00 > 0 && var_0D != "" && var_0E != "") {
    if(param_00 == 1) {
      var_0A = var_0D;
    } else if(param_00 == 2) {
      var_0A = var_0E;
    }
  }

  scripts\mp\broshot_utilities::processepictaunt(var_0A, param_00, 1);
  var_0F = "ui_broshot_anim_" + param_00;
  setomnvar(var_0F, var_04);
  var_10 = float(var_08) / 30;
  var_11 = var_10;
  if(var_06 != "") {
    var_11 = var_11 * float(var_06);
  }

  level.interruptabletaunts[param_00] = var_0A;
  thread interruptblocker(param_00, var_10);
  wait(var_11);
  level.taunts_done = 1;
  self notify("taunt_end");
}

interruptblocker(param_00, param_01) {
  self notify("combo_started_" + param_00);
  self endon("combo_started_" + param_00);
  wait(param_01);
  level.interruptabletaunts[param_00] = undefined;
}

getaltgunanimstring() {
  var_00 = getdisplayweapon(self);
  if(issubstr(var_00, "iw7_nrg") || issubstr(var_00, "iw7_udm45") || issubstr(var_00, "iw7_ump45_mpr_akimbo")) {
    return "_alt";
  }

  return "";
}

getgunanimstring() {
  var_00 = getdisplayweapon(self);
  if(issubstr(var_00, "minilmg_mpl") && !issubstr(var_00, "spooled")) {
    return "augfury";
  }

  if(issubstr(var_00, "akimbo")) {
    return "akimbo";
  }

  if(issubstr(var_00, "mp28")) {
    return "mp28";
  }

  if(issubstr(var_00, "chargeshot") || issubstr(var_00, "glprox") || issubstr(var_00, "venom")) {
    return "assault_rifle";
  }

  if(issubstr(var_00, "knife")) {
    return "knife";
  }

  if(issubstr(var_00, "axe")) {
    return "axe";
  }

  var_01 = scripts\mp\utility::getweapongroup(var_00);
  switch (var_01) {
    case "weapon_melee":
      return "melee";

    case "weapon_pistol":
      return "pistol";

    case "weapon_beam":
    case "weapon_smg":
      return "smg";

    case "weapon_assault":
      return "assault_rifle";

    case "weapon_lmg":
      return "lmg";

    case "weapon_rail":
    case "weapon_sniper":
    case "weapon_dmr":
      return "sniper";

    case "weapon_shotgun":
      return "shotgun";

    case "weapon_projectile":
      return "launcher";

    default:
      return "akimbo";
  }
}

getgunanimindex() {
  var_00 = getdisplayweapon(self);
  var_01 = scripts\mp\utility::getweapongroup(var_00);
  if(issubstr(var_00, "minilmg_mpl") && !issubstr(var_00, "spooled")) {
    return 11;
  }

  if(issubstr(var_00, "mp28")) {
    return 12;
  }

  if(issubstr(var_00, "akimbo") && !issubstr(var_00, "akimbofmg") && !issubstr(var_00, "mod_akimboshotgun")) {
    if(issubstr(var_00, "iw7_nrg") || issubstr(var_00, "iw7_udm45") || issubstr(var_00, "iw7_ump45_mpr_akimbo")) {
      return 13;
    }

    return 8;
  }

  if(issubstr(var_00, "chargeshot") || issubstr(var_00, "glprox") || issubstr(var_00, "venom")) {
    return 2;
  }

  if(issubstr(var_00, "knife")) {
    return 9;
  }

  if(issubstr(var_00, "axe")) {
    return 10;
  }

  if(issubstr(var_00, "nunchuk") || issubstr(var_00, "katana")) {
    return 7;
  }

  switch (var_01) {
    case "weapon_pistol":
      return 0;

    case "weapon_beam":
    case "weapon_smg":
      return 1;

    case "weapon_assault":
      return 2;

    case "weapon_lmg":
      return 3;

    case "weapon_rail":
    case "weapon_sniper":
    case "weapon_dmr":
      return 4;

    case "weapon_shotgun":
      return 5;

    case "weapon_projectile":
      return 6;

    case "weapon_melee":
    default:
      return 7;
  }
}

setguntypeforui(param_00) {
  var_01 = "ui_broshot_weapon_type_" + param_00;
  setomnvar(var_01, getgunanimindex());
}

putgunaway(param_00) {
  var_01 = getgunanimstring();
  var_02 = var_01 + "_put_away" + getaltgunanimstring();
  var_03 = tablelookuprownum("mp\cac\taunts.csv", 1, var_02);
  setomnvar(param_00, -1);
  var_04 = getgunputawayduration(var_01);
  wait(var_04);
}

takesupergunout(param_00, param_01) {
  var_02 = getrigtransstringfromref(param_01) + "transout_0";
  var_03 = tablelookuprownum("mp\cac\taunts.csv", 1, var_02);
  setomnvar(param_00, var_03 + 30000);
  var_04 = getrigsupertakeoutdurationfromref(param_01);
  wait(var_04);
}

getrigtransstringfromref(param_00) {
  var_01 = "";
  switch (param_00) {
    case "archetype_assault":
    default:
      var_01 = "war_";
      break;

    case "archetype_heavy":
      var_01 = "heavy_";
      break;

    case "archetype_scout":
      var_01 = "c6_";
      break;

    case "archetype_assassin":
      var_01 = "ftl_";
      break;

    case "archetype_engineer":
      var_01 = "stryker_";
      break;

    case "archetype_sniper":
      var_01 = "ghost_";
      break;
  }

  return var_01;
}

getgunputawayduration(param_00) {
  var_01 = 0;
  switch (param_00) {
    case "akimbo":
    default:
      var_01 = 1.067;
      break;

    case "launcher":
      var_01 = 1.567;
      break;

    case "lmg":
      var_01 = 1.333;
      break;

    case "pistol":
      var_01 = 2.233;
      break;

    case "shotgun":
      var_01 = 1.233;
      break;

    case "smg":
    case "mp28":
      var_01 = 1.2;
      break;

    case "sniper":
      var_01 = 1.367;
      break;

    case "assault_rifle":
      var_01 = 1.233;
      break;

    case "melee":
      var_01 = 1.233;
      break;
  }

  return var_01 - 0.2;
}

getrigsupertakeoutdurationfromref(param_00) {
  var_01 = 0;
  switch (param_00) {
    case "archetype_assault":
    default:
      var_01 = 1.733;
      break;

    case "archetype_heavy":
      var_01 = 1.4;
      break;

    case "archetype_scout":
      var_01 = 0.67;
      break;

    case "archetype_assassin":
      var_01 = 1.133;
      break;

    case "archetype_engineer":
      var_01 = 1.733;
      break;

    case "archetype_sniper":
      var_01 = 1.3;
      break;
  }

  return var_01 - 0.2;
}

getrigsuperputawaydurationfromref(param_00) {
  var_01 = 0;
  switch (param_00) {
    case "archetype_assault":
    default:
      var_01 = 1.267;
      break;

    case "archetype_heavy":
      var_01 = 1.5;
      break;

    case "archetype_scout":
      var_01 = 0.67;
      break;

    case "archetype_assassin":
      var_01 = 1;
      break;

    case "archetype_engineer":
      var_01 = 1.3;
      break;

    case "archetype_sniper":
      var_01 = 1.167;
      break;
  }

  return var_01 - 0.2;
}

compare_player_score(param_00, param_01) {
  return param_00.destroynavrepulsor >= param_01.destroynavrepulsor;
}

onplayerconnect() {
  self endon("broshot_done");
  for(;;) {
    level waittill("connected", var_00);
    if(!isai(var_00)) {
      thread startlatejoinpodium(var_00);
    }
  }
}

startlatejoinpodium(param_00) {
  param_00 endon("disconnect");
  wait(0.25);
  param_00 cameralinkto(level.camera_anchor, "tag_origin", 1);
  var_01 = param_00 getentitynumber();
  startpodium(var_01, self.mvparray);
}

changetestrig(param_00, param_01) {
  level.overriderig = param_00;
  var_02 = param_01 - 1;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  switch (param_00) {
    case 1:
    default:
      var_03 = 4;
      var_04 = 18;
      var_05 = 6;
      break;

    case 2:
      var_03 = 12;
      var_04 = 5;
      var_05 = 1;
      break;

    case 3:
      var_03 = 28;
      var_04 = 1;
      var_05 = 2;
      break;

    case 4:
      var_03 = 57;
      var_04 = 28;
      var_05 = 3;
      break;

    case 5:
      var_03 = 45;
      var_04 = 39;
      var_05 = 4;
      break;

    case 6:
      var_03 = 27;
      var_04 = 31;
      var_05 = 5;
      break;
  }

  self.mvparray = [];
  var_06 = max(param_01, level.topplayers.size);
  for(var_07 = 0; var_07 < var_06; var_07++) {
    self.mvparray[var_07] = spawnStruct();
    self.mvparray[var_07].setprintchannel = var_05;
    self.mvparray[var_07].var_6A = var_04;
    self.mvparray[var_07].playfxontag = var_03;
    self.mvparray[var_07].var_39C = getdisplayweapon(level.players[0]);
    self.mvparray[var_07].var_9C = level.players[0] getclantag();
    self.mvparray[var_07].name = level.players[0].name;
    self.mvparray[var_07].var_3A3 = level.players[0] getxuid();
    self.mvparray[var_07].podiumindex = param_01;
    self.mvparray[var_07].clientnum = level.players[0] getentitynumber();
    if(!isDefined(level.topplayers[var_07])) {
      self.topplayers[var_07] = spawnStruct();
      level.topplayers[var_07].bro = makebrowinner(var_07, level.camera_bro_shot.char_loc[var_07]);
    }
  }

  for(var_07 = 0; var_07 < var_06; var_07++) {
    level.topplayers[var_07] setguntypeforui(var_07);
  }

  wait(0.05);
  startpodium(-1, self.mvparray);
}

changetesttaunt(param_00) {
  level.overridetaunt = param_00;
}

changetestslot(param_00) {
  level.overridebroslot = param_00;
  if(!isDefined(level.topplayers[param_00 - 1])) {
    var_01 = 0;
    if(isDefined(level.overriderig)) {
      var_01 = level.overriderig;
    }

    changetestrig(var_01, param_00);
  }
}