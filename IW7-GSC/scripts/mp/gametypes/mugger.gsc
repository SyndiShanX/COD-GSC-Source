/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\mugger.gsc
*******************************************/

main() {
  if(getdvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.initializematchrules = ::initializematchrules;
    [[level.initializematchrules]]();
    level thread scripts\mp\utility::reinitializematchrulesonmigration();
  } else {
    scripts\mp\utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    scripts\mp\utility::registertimelimitdvar(level.gametype, 7);
    scripts\mp\utility::registerscorelimitdvar(level.gametype, 2500);
    scripts\mp\utility::registerroundlimitdvar(level.gametype, 1);
    scripts\mp\utility::registerwinlimitdvar(level.gametype, 1);
    scripts\mp\utility::registernumlivesdvar(level.gametype, 0);
    scripts\mp\utility::registerhalftimedvar(level.gametype, 0);
    level.matchrules_damagemultiplier = 0;
    level.matchrules_vampirism = 0;
    level.mugger_bank_limit = getdvarint("scr_mugger_bank_limit", 10);
  }

  setteammode("ffa");
  level.onprecachegametype = ::onprecachegametype;
  level.onstartgametype = ::onstartgametype;
  level.onspawnplayer = ::onspawnplayer;
  level.getspawnpoint = ::getspawnpoint;
  level.onnormaldeath = ::onnormaldeath;
  level.onplayerscore = ::onplayerscore;
  level.ontimelimit = ::ontimelimit;
  level.onxpevent = ::onxpevent;
  level.customcratefunc = ::createmuggercrates;
  level.assists_disabled = 1;
  if(level.matchrules_damagemultiplier || level.matchrules_vampirism) {
    level.modifyplayerdamage = ::scripts\mp\damage::gamemodemodifyplayerdamage;
  }

  level.mugger_fx["vanish"] = loadfx("impacts\small_snowhit");
  level.mugger_fx["smoke"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.mugger_targetfxid = loadfx("misc\ui_flagbase_red");
  level thread onplayerconnect();
}

initializematchrules() {
  scripts\mp\utility::setcommonrulesfrommatchdata();
  setdynamicdvar("scr_mugger_roundswitch", 0);
  scripts\mp\utility::registerroundswitchdvar("mugger", 0, 0, 9);
  setdynamicdvar("scr_mugger_roundlimit", 1);
  scripts\mp\utility::registerroundlimitdvar("mugger", 1);
  setdynamicdvar("scr_mugger_winlimit", 1);
  scripts\mp\utility::registerwinlimitdvar("mugger", 1);
  setdynamicdvar("scr_mugger_halftime", 0);
  scripts\mp\utility::registerhalftimedvar("mugger", 0);
  setdynamicdvar("scr_mugger_promode", 0);
  level.mugger_bank_limit = getmatchrulesdata("muggerData", "bankLimit");
  setdynamicdvar("scr_mugger_bank_limit", level.mugger_bank_limit);
  level.mugger_jackpot_limit = getmatchrulesdata("muggerData", "jackpotLimit");
  setdynamicdvar("scr_mugger_jackpot_limit", level.mugger_jackpot_limit);
  level.mugger_throwing_knife_mug_frac = getmatchrulesdata("muggerData", "throwKnifeFrac");
  setdynamicdvar("scr_mugger_throwing_knife_mug_frac", level.mugger_throwing_knife_mug_frac);
}

onprecachegametype() {
  precachemodel("dogtags_iw7_foe");
  precachemodel("lethal_smoke_grenade_wm");
  precachempanim("mp_dogtag_spin");
  precacheshader("waypoint_dogtags2");
  precacheshader("waypoint_dogtag_pile");
  precacheshader("waypoint_jackpot");
  precacheshader("hud_tagcount");
  precachesound("mugger_mugging");
  precachesound("mugger_mega_mugging");
  precachesound("mugger_you_mugged");
  precachesound("mugger_got_mugged");
  precachesound("mugger_mega_drop");
  precachesound("mugger_muggernaut");
  precachesound("mugger_tags_banked");
  precachestring(&"MPUI_MUGGER_JACKPOT");
}

onstartgametype() {
  setclientnamemode("auto_change");
  scripts\mp\utility::setobjectivetext("allies", &"OBJECTIVES_MUGGER");
  scripts\mp\utility::setobjectivetext("axis", &"OBJECTIVES_MUGGER");
  if(level.splitscreen) {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_MUGGER");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_MUGGER");
  } else {
    scripts\mp\utility::setobjectivescoretext("allies", &"OBJECTIVES_MUGGER_SCORE");
    scripts\mp\utility::setobjectivescoretext("axis", &"OBJECTIVES_MUGGER_SCORE");
  }

  scripts\mp\utility::setobjectivehinttext("allies", &"OBJECTIVES_MUGGER_HINT");
  scripts\mp\utility::setobjectivehinttext("axis", &"OBJECTIVES_MUGGER_HINT");
  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.dogtags = [];
  var_00[0] = level.gametype;
  var_00[1] = "dm";
  scripts\mp\gameobjects::main(var_00);
  level.mugger_timelimit = getdvarint("scr_mugger_timelimit", 7);
  setdynamicdvar("scr_mugger_timeLimit", level.mugger_timelimit);
  scripts\mp\utility::registertimelimitdvar("mugger", level.mugger_timelimit);
  level.mugger_scorelimit = getdvarint("scr_mugger_scorelimit", 2500);
  if(level.mugger_scorelimit == 0) {
    level.mugger_scorelimit = 2500;
  }

  setdynamicdvar("scr_mugger_scoreLimit", level.mugger_scorelimit);
  scripts\mp\utility::registerscorelimitdvar("mugger", level.mugger_scorelimit);
  level.mugger_bank_limit = getdvarint("scr_mugger_bank_limit", 10);
  level.mugger_muggernaut_window = getdvarint("scr_mugger_muggernaut_window", 3000);
  level.mugger_muggernaut_muggings_needed = getdvarint("scr_mugger_muggernaut_muggings_needed", 3);
  level.mugger_min_spawn_dist_sq = squared(getdvarfloat("mugger_min_spawn_dist", 350));
  level.mugger_jackpot_limit = getdvarint("scr_mugger_jackpot_limit", 0);
  level.mugger_jackpot_wait_sec = getdvarfloat("scr_mugger_jackpot_wait_sec", 10);
  level.mugger_throwing_knife_mug_frac = getdvarfloat("scr_mugger_throwing_knife_mug_frac", 1);
  level mugger_init_tags();
  level thread mugger_monitor_tank_pickups();
  level thread mugger_monitor_remote_uav_pickups();
  level.jackpot_zone = spawn("script_model", (0, 0, 0));
  level.jackpot_zone.origin = (0, 0, 0);
  level.jackpot_zone.angles = (90, 0, 0);
  level.jackpot_zone setModel("lethal_smoke_grenade_wm");
  level.jackpot_zone hide();
  level.jackpot_zone.mugger_fx_playing = 0;
  level thread mugger_jackpot_watch();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00.tags_carried = 0;
    var_00.total_tags_banked = 0;
    var_00.var_4D = var_00.total_tags_banked;
    var_00.pers["assists"] = var_00.total_tags_banked;
    var_00.objective_additionalentity = var_00.tags_carried;
    var_00.muggings = [];
    if(isplayer(var_00) && !isbot(var_00)) {
      var_00.dogtagsicon = var_00 scripts\mp\hud_util::createicon("hud_tagcount", 48, 48);
      var_00.dogtagsicon scripts\mp\hud_util::setpoint("TOP LEFT", "TOP LEFT", 200, 0);
      var_00.dogtagsicon.alpha = 1;
      var_00.dogtagsicon.hidewheninmenu = 1;
      var_00.dogtagsicon.archived = 1;
      level thread hidehudelementongameend(var_00.dogtagsicon);
      var_00.dogtagstext = var_00 scripts\mp\hud_util::createfontstring("bigfixed", 1);
      var_00.dogtagstext scripts\mp\hud_util::setparent(var_00.dogtagsicon);
      var_00.dogtagstext scripts\mp\hud_util::setpoint("CENTER", "CENTER", -24);
      var_00.dogtagstext setvalue(var_00.tags_carried);
      var_00.dogtagstext.alpha = 1;
      var_00.dogtagstext.color = (1, 1, 0.5);
      var_00.dogtagstext.objective_current_nomessage = 1;
      var_00.dogtagstext.sort = 1;
      var_00.dogtagstext.hidewheninmenu = 1;
      var_00.dogtagstext.archived = 1;
      var_00.dogtagstext scripts\mp\hud::fontpulseinit(3);
      level thread hidehudelementongameend(var_00.dogtagstext);
    }
  }
}

onspawnplayer() {
  self.muggings = [];
  if(!isagent(self)) {
    thread waitreplaysmokefxfornewplayer();
  }
}

hidehudelementongameend(param_00) {
  level waittill("game_ended");
  if(isDefined(param_00)) {
    param_00.alpha = 0;
  }
}

getspawnpoint() {
  var_00 = scripts\mp\spawnlogic::getteamspawnpoints(self.pers["team"]);
  var_01 = scripts\mp\spawnscoring::getspawnpoint(var_00);
  return var_01;
  return var_01;
}

onxpevent(param_00) {
  if(isDefined(param_00) && param_00 == "suicide") {
    level thread spawndogtags(self, self);
  }
}

onnormaldeath(param_00, param_01, param_02, param_03, param_04) {
  scripts\mp\gametypes\common::onnormaldeath(param_00, param_01, param_02, param_03, param_04);
  level thread spawndogtags(param_00, param_01);
}

mugger_init_tags() {
  level.mugger_max_extra_tags = getdvarint("scr_mugger_max_extra_tags", 50);
  level.mugger_extra_tags = [];
}

spawndogtags(param_00, param_01) {
  if(isagent(param_01)) {
    param_01 = param_01.triggerportableradarping;
  }

  var_02 = 0;
  var_03 = 0;
  if(isDefined(param_01)) {
    if(param_00 == param_01) {
      if(param_00.tags_carried > 0) {
        var_02 = param_00.tags_carried;
        param_00.tags_carried = 0;
        param_00.objective_additionalentity = 0;
        if(isplayer(param_00) && !isbot(param_00)) {
          param_00.dogtagstext setvalue(param_00.tags_carried);
          param_00.dogtagstext thread scripts\mp\hud::fontpulse(param_00);
          param_00 thread scripts\mp\hud_message::showsplash("mugger_suicide", var_02);
        }
      }
    } else if(isDefined(param_00.attackerdata) && param_00.attackerdata.size > 0) {
      if(isplayer(param_01) && isDefined(param_00.attackerdata) && isDefined(param_01.guid) && isDefined(param_00.attackerdata[param_01.guid])) {
        var_04 = param_00.attackerdata[param_01.guid];
        if(isDefined(var_04) && isDefined(var_04.attackerent) && var_04.attackerent == param_01) {
          if(isDefined(var_04.smeansofdeath) && var_04.smeansofdeath == "MOD_MELEE" || (var_04.var_394 == "throwingknife_mp" || var_04.var_394 == "throwingknifejugg_mp") && level.mugger_throwing_knife_mug_frac > 0) {
            var_03 = 1;
            if(param_00.tags_carried > 0) {
              var_02 = param_00.tags_carried;
              if((var_04.var_394 == "throwingknife_mp" || var_04.var_394 == "throwingknifejugg_mp") && level.mugger_throwing_knife_mug_frac < 1) {
                var_02 = int(ceil(param_00.tags_carried * level.mugger_throwing_knife_mug_frac));
              }

              param_00.tags_carried = param_00.tags_carried - var_02;
              param_00.objective_additionalentity = param_00.tags_carried;
              if(isplayer(param_00) && !isbot(param_00)) {
                param_00.dogtagstext setvalue(param_00.tags_carried);
                param_00.dogtagstext thread scripts\mp\hud::fontpulse(param_00);
                param_00 thread scripts\mp\hud_message::showsplash("callout_mugged", var_02);
                param_00 playlocalsound("mugger_got_mugged");
              }

              playsoundatpos(param_00.origin, "mugger_mugging");
              param_01 thread scripts\mp\hud_message::showsplash("callout_mugger", var_02);
              if(var_04.var_394 == "throwingknife_mp" || var_04.var_394 == "throwingknifejugg_mp") {
                param_01 playlocalsound("mugger_you_mugged");
              }
            }

            param_01.muggings[param_01.muggings.size] = gettime();
            param_01 thread mugger_check_muggernaut();
          }
        }
      }
    }
  }

  if(isagent(param_00)) {
    var_05 = param_00.origin + (0, 0, 14);
    playsoundatpos(var_05, "mp_killconfirm_tags_drop");
    level notify("mugger_jackpot_increment");
    var_06 = mugger_tag_temp_spawn(param_00.origin, 40, 160);
    var_06.victim = param_00.triggerportableradarping;
    if(isDefined(param_01) && param_00 != param_01) {
      var_06.var_4F = param_01;
    } else {
      var_06.var_4F = undefined;
    }

    return;
  } else if(isDefined(level.dogtags[var_02.guid])) {
    playFX(level.mugger_fx["vanish"], level.dogtags[var_02.guid].curorigin);
    level.dogtags[var_02.guid] notify("reset");
  } else {
    var_07[0] = spawn("script_model", (0, 0, 0));
    var_07[0] setModel("dogtags_iw7_foe");
    var_08 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var_08.var_336 = "trigger_dogtag";
    var_08 hide();
    level.dogtags[var_02.guid] = ::scripts\mp\gameobjects::createuseobject("any", var_08, var_07, (0, 0, 16));
    scripts\mp\objpoints::deleteobjpoint(level.dogtags[var_02.guid].objpoints["allies"]);
    scripts\mp\objpoints::deleteobjpoint(level.dogtags[var_02.guid].objpoints["axis"]);
    level.dogtags[var_02.guid] scripts\mp\gameobjects::setusetime(0);
    level.dogtags[var_02.guid].onuse = ::onuse;
    var_08.dogtag = level.dogtags[var_02.guid];
    level.dogtags[var_02.guid].victim = var_02;
    level.dogtags[var_02.guid].objid = scripts\mp\objidpoolmanager::requestminimapid(99);
    if(level.dogtags[var_02.guid].objid != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(level.dogtags[var_02.guid].objid, "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_icon(level.dogtags[var_02.guid].objid, "waypoint_dogtags2");
    }

    level.dogtags[var_02.guid].visuals[0] scriptmodelplayanim("mp_dogtag_spin");
    level thread clearonvictimdisconnect(var_02);
  }

  var_05 = var_02.origin + (0, 0, 14);
  level.dogtags[param_01.guid].curorigin = var_06;
  level.dogtags[param_01.guid].trigger.origin = var_06;
  level.dogtags[param_01.guid].visuals[0].origin = var_06;
  level.dogtags[param_01.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.dogtags[param_01.guid] scripts\mp\gameobjects::allowuse("any");
  level.dogtags[param_01.guid].visuals[0] show();
  if(isDefined(var_02) && param_01 != var_02) {
    level.dogtags[param_01.guid].var_4F = var_02;
  } else {
    level.dogtags[param_01.guid].var_4F = undefined;
  }

  level.dogtags[param_01.guid] thread timeout();
  if(var_03 < 5) {
    scripts\mp\objidpoolmanager::minimap_objective_position(level.dogtags[param_01.guid].objid, var_06);
    scripts\mp\objidpoolmanager::minimap_objective_state(level.dogtags[param_01.guid].objid, "active");
  } else {
    mugger_tag_pile_notify(var_06, "mugger_megadrop", var_03, param_01, var_02);
  }

  playsoundatpos(var_06, "mp_killconfirm_tags_drop");
  level.dogtags[param_01.guid].temp_tag = 0;
  if(var_03 == 0) {
    level notify("mugger_jackpot_increment");
  }

  var_09 = 0;
  while(var_06 < var_02) {
    var_09 = mugger_tag_temp_spawn(param_00.origin, 40, 160);
    var_09.victim = param_00;
    if(isDefined(param_01) && param_00 != param_01) {
      var_09.var_4F = param_01;
      continue;
    }

    var_09.var_4F = undefined;
    var_06++;
  }
}

mugger_tag_pickup_wait() {
  level endon("game_ended");
  self endon("reset");
  self endon("reused");
  self endon("deleted");
  for(;;) {
    self.trigger waittill("trigger", var_00);
    if(!scripts\mp\utility::isreallyalive(var_00)) {
      continue;
    }

    if(var_00 scripts\mp\utility::isusingremote() || isDefined(var_00.spawningafterremotedeath)) {
      continue;
    }

    if(isDefined(var_00.classname) && var_00.classname == "script_vehicle") {
      continue;
    }

    thread onuse(var_00);
  }
}

mugger_add_extra_tag(param_00) {
  var_01[0] = spawn("script_model", (0, 0, 0));
  var_01[0] setModel("dogtags_iw7_foe");
  var_02 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
  var_02.var_336 = "trigger_dogtag";
  var_02 hide();
  level.mugger_extra_tags[param_00] = spawnStruct();
  var_03 = level.mugger_extra_tags[param_00];
  var_03.type = "useObject";
  var_03.curorigin = var_02.origin;
  var_03.entnum = var_02 getentitynumber();
  var_03.trigger = var_02;
  var_03.triggertype = "proximity";
  var_03 scripts\mp\gameobjects::allowuse("any");
  var_01[0].baseorigin = var_01[0].origin;
  var_03.visuals = var_01;
  var_03.offset3d = (0, 0, 16);
  var_03.temp_tag = 1;
  var_03.last_used_time = 0;
  var_03.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
  var_03 thread mugger_tag_pickup_wait();
  return var_03;
}

mugger_first_unused_or_oldest_extra_tag() {
  var_00 = undefined;
  var_01 = -1;
  foreach(var_03 in level.mugger_extra_tags) {
    if(var_03.interactteam == "none") {
      var_03.last_used_time = gettime();
      var_03.visuals[0] show();
      return var_03;
    }

    if(!isDefined(var_00) || var_03.last_used_time < var_01) {
      var_01 = var_03.last_used_time;
      var_00 = var_03;
    }
  }

  if(level.mugger_extra_tags.size < level.mugger_max_extra_tags) {
    var_05 = mugger_add_extra_tag(level.mugger_extra_tags.size);
    if(isDefined(var_05)) {
      var_05.last_used_time = gettime();
      return var_05;
    }
  }

  var_00.last_used_time = gettime();
  var_00 notify("reused");
  playFX(level.mugger_fx["vanish"], var_00.curorigin);
  return var_00;
}

mugger_tag_temp_spawn(param_00, param_01, param_02) {
  var_03 = mugger_first_unused_or_oldest_extra_tag();
  var_04 = param_00 + (0, 0, 14);
  var_05 = (0, randomfloat(360), 0);
  var_06 = anglesToForward(var_05);
  var_07 = randomfloatrange(40, 160);
  var_08 = var_04 + var_07 * var_06;
  var_08 = var_08 + (0, 0, 40);
  var_09 = playerphysicstrace(var_04, var_08);
  var_04 = var_09;
  var_08 = var_04 + (0, 0, -100);
  var_09 = playerphysicstrace(var_04, var_08);
  if(var_09[2] != var_08[2]) {
    var_09 = var_09 + (0, 0, 14);
  }

  var_03.curorigin = var_09;
  var_03.trigger.origin = var_09;
  var_03.visuals[0].origin = var_09;
  var_03 scripts\mp\gameobjects::initializetagpathvariables();
  var_03 scripts\mp\gameobjects::allowuse("any");
  var_03 thread mugger_tag_pickup_wait();
  var_03 thread timeout();
  return var_03;
}

mugger_tag_pile_notify(param_00, param_01, param_02, param_03, param_04) {
  level notify("mugger_tag_pile", param_00);
  var_05 = scripts\mp\objidpoolmanager::requestminimapid(99);
  if(var_05 != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_add(var_05, "active", param_00);
    scripts\mp\objidpoolmanager::minimap_objective_icon(var_05, "waypoint_dogtag_pile");
  }

  level scripts\engine\utility::delaythread(5, ::mugger_pile_icon_remove, var_05);
  if(param_02 >= 10) {
    level.mugger_last_mega_drop = gettime();
    level.mugger_jackpot_num_tags = 0;
    foreach(var_07 in level.players) {
      var_07 playsoundtoplayer("mp_defcon_one", var_07);
      if(isDefined(param_03) && var_07 == param_03) {
        continue;
      }

      if(isDefined(param_04) && var_07 == param_04) {
        continue;
      }

      var_07 thread scripts\mp\hud_message::showsplash(param_01, param_02);
    }

    var_09 = newhudelem();
    var_09 setshader("waypoint_dogtag_pile", 10, 10);
    var_09 setwaypoint(0, 1, 0, 0);
    var_09.x = param_00[0];
    var_09.y = param_00[1];
    var_09.var_3A6 = param_00[2] + 32;
    var_09.alpha = 1;
    var_09 fadeovertime(5);
    var_09.alpha = 0;
    var_09 scripts\engine\utility::delaythread(5, ::hudelemdestroy);
  }
}

hudelemdestroy() {
  if(isDefined(self)) {
    self destroy();
  }
}

mugger_monitor_tank_pickups() {
  level endon("game_ended");
  for(;;) {
    var_00 = getEntArray("remote_tank", "targetname");
    var_01 = getEntArray("trigger_dogtag", "targetname");
    foreach(var_03 in level.players) {
      if(isDefined(var_03.using_remote_tank) && var_03.using_remote_tank == 1) {
        foreach(var_05 in var_00) {
          if(isDefined(var_05) && isDefined(var_05.triggerportableradarping) && var_05.triggerportableradarping == var_03) {
            foreach(var_07 in var_01) {
              if(isDefined(var_07) && isDefined(var_07.dogtag)) {
                if(isDefined(var_07.dogtag.interactteam) && var_07.dogtag.interactteam != "none") {
                  if(var_05 istouching(var_07)) {
                    var_07.dogtag onuse(var_05.triggerportableradarping);
                  }
                }
              }
            }
          }
        }
      }
    }

    wait(0.2);
  }
}

mugger_monitor_remote_uav_pickups() {
  level endon("game_ended");
  for(;;) {
    var_00 = getEntArray("trigger_dogtag", "targetname");
    foreach(var_02 in level.players) {
      if(isDefined(var_02) && isDefined(var_02.remoteuav)) {
        foreach(var_04 in var_00) {
          if(isDefined(var_04) && isDefined(var_04.dogtag)) {
            if(isDefined(var_04.dogtag.interactteam) && var_04.dogtag.interactteam != "none") {
              if(var_02.remoteuav istouching(var_04)) {
                var_04.dogtag onuse(var_02);
              }
            }
          }
        }
      }
    }

    wait(0.2);
  }
}

mugger_check_muggernaut() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("checking_muggernaut");
  self endon("checking_muggernaut");
  wait(2);
  if(self.muggings.size < level.mugger_muggernaut_muggings_needed) {
    return;
  }

  var_00 = self.muggings[self.muggings.size - 1];
  var_01 = var_00 - level.mugger_muggernaut_window;
  var_02 = [];
  foreach(var_04 in self.muggings) {
    if(var_04 >= var_01) {
      var_02[var_02.size] = var_04;
    }
  }

  if(var_02.size >= level.mugger_muggernaut_muggings_needed) {
    thread scripts\mp\utility::giveunifiedpoints("muggernaut");
    mugger_bank_tags(1, 1);
    self.muggings = [];
    return;
  }

  self.muggings = var_02;
}

mugger_pile_icon_remove(param_00) {
  scripts\mp\objidpoolmanager::returnminimapid(param_00);
}

_hidefromplayer(param_00) {
  self hide();
  foreach(var_02 in level.players) {
    if(var_02 != param_00) {
      self showtoplayer(var_02);
    }
  }
}

onuse(param_00) {
  if(isDefined(param_00.triggerportableradarping)) {
    param_00 = param_00.triggerportableradarping;
  }

  if(self.temp_tag) {
    self.trigger playSound("mp_killconfirm_tags_deny");
  } else if(isDefined(self.var_4F) && param_00 == self.var_4F) {
    self.trigger playSound("mp_killconfirm_tags_pickup");
    param_00 scripts\mp\utility::incperstat("confirmed", 1);
    param_00 scripts\mp\persistence::statsetchild("round", "confirmed", param_00.pers["confirmed"]);
  } else {
    self.trigger playSound("mp_killconfirm_tags_deny");
    param_00 scripts\mp\utility::incperstat("denied", 1);
    param_00 scripts\mp\persistence::statsetchild("round", "denied", param_00.pers["denied"]);
  }

  param_00 thread onpickup();
  resettags(1);
}

onpickup() {
  level endon("game_ended");
  self endon("disconnect");
  while(!isDefined(self.pers)) {
    wait(0.05);
  }

  thread mugger_delayed_banking();
}

mugger_delayed_banking() {
  self notify("banking");
  self endon("banking");
  level endon("banking_all");
  self.tags_carried++;
  self.objective_additionalentity = self.tags_carried;
  if(isplayer(self) && !isbot(self)) {
    self.dogtagstext setvalue(self.tags_carried);
    self.dogtagstext thread scripts\mp\hud::fontpulse(self);
  }

  wait(1.5);
  var_00 = level.mugger_bank_limit - self.tags_carried;
  if(var_00 > 0 && var_00 <= 5) {
    var_01 = undefined;
    switch (var_00) {
      case 1:
        var_01 = "mugger_1more";
        break;

      case 2:
        var_01 = "mugger_2more";
        break;

      case 3:
        var_01 = "mugger_3more";
        break;

      case 4:
        var_01 = "mugger_4more";
        break;

      case 5:
        var_01 = "mugger_5more";
        break;
    }

    if(isDefined(var_01)) {
      self playsoundtoplayer(var_01, self);
    }
  }

  wait(0.5);
  mugger_bank_tags(0);
}

mugger_bank_tags(param_00, param_01) {
  var_02 = 0;
  if(param_00 == 1) {
    var_02 = self.tags_carried;
  } else {
    var_03 = self.tags_carried % level.mugger_bank_limit;
    var_02 = self.tags_carried - var_03;
  }

  if(var_02 > 0) {
    self.tags_to_bank = var_02;
    if(!isDefined(param_01)) {
      thread scripts\mp\hud_message::showsplash("callout_tags_banked", var_02);
    }

    thread scripts\mp\utility::giveunifiedpoints("tags_banked", undefined, self.tags_to_bank * scripts\mp\rank::getscoreinfovalue("kill_confirmed"));
    self.total_tags_banked = self.total_tags_banked + var_02;
    self.tags_carried = self.tags_carried - var_02;
    self.objective_additionalentity = self.tags_carried;
    if(isplayer(self) && !isbot(self)) {
      self.dogtagstext setvalue(self.tags_carried);
      self.dogtagstext thread scripts\mp\hud::fontpulse(self);
    }

    self.var_4D = self.total_tags_banked;
    self.pers["assists"] = self.total_tags_banked;
  }
}

onplayerscore(param_00, param_01) {
  if(param_00 == "tags_banked" && isDefined(param_01) && isDefined(param_01.tags_to_bank) && param_01.tags_to_bank > 0) {
    var_02 = param_01.tags_to_bank * scripts\mp\rank::getscoreinfovalue("kill_confirmed");
    param_01.tags_to_bank = 0;
    return var_02;
  }

  return 0;
}

resettags(param_00) {
  if(!param_00) {
    level notify("mugger_jackpot_increment");
  }

  self.var_4F = undefined;
  self notify("reset");
  self.visuals[0] hide();
  self.curorigin = (0, 0, 1000);
  self.trigger.origin = (0, 0, 1000);
  self.visuals[0].origin = (0, 0, 1000);
  scripts\mp\gameobjects::allowuse("none");
  if(isDefined(self.jackpot_tag) && self.jackpot_tag == 1) {
    level.mugger_jackpot_tags_spawned--;
  }

  if(!self.temp_tag) {
    scripts\mp\objidpoolmanager::minimap_objective_state(self.objid, "invisible");
  }
}

timeout() {
  level endon("game_ended");
  self endon("death");
  self endon("deleted");
  self endon("reset");
  self endon("reused");
  self notify("timeout_start");
  self endon("timeout_start");
  level scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(27);
  var_00 = 3;
  while(var_00 > 0) {
    self.visuals[0] hide();
    wait(0.25);
    self.visuals[0] show();
    wait(0.25);
    var_00 = var_00 - 0.5;
  }

  playFX(level.mugger_fx["vanish"], self.curorigin);
  thread resettags(0);
}

clearonvictimdisconnect(param_00) {
  level endon("game_ended");
  var_01 = param_00.guid;
  param_00 waittill("disconnect");
  if(isDefined(level.dogtags[var_01])) {
    level.dogtags[var_01] scripts\mp\gameobjects::allowuse("none");
    playFX(level.mugger_fx["vanish"], level.dogtags[var_01].curorigin);
    level.dogtags[var_01] notify("reset");
    wait(0.05);
    if(isDefined(level.dogtags[var_01])) {
      scripts\mp\objidpoolmanager::returnminimapid(level.dogtags[var_01].objid);
      level.dogtags[var_01].trigger delete();
      for(var_02 = 0; var_02 < level.dogtags[var_01].visuals.size; var_02++) {
        level.dogtags[var_01].visuals[var_02] delete();
      }

      level.dogtags[var_01] notify("deleted");
      level.dogtags[var_01] = undefined;
    }
  }
}

ontimelimit() {
  level notify("banking_all");
  foreach(var_01 in level.players) {
    var_01 mugger_bank_tags(1);
  }

  wait(0.1);
  scripts\mp\gamelogic::default_ontimelimit();
}

mugger_jackpot_watch() {
  level endon("game_ended");
  level endon("jackpot_stop");
  if(level.mugger_jackpot_limit <= 0) {
    return;
  }

  level.mugger_jackpot_num_tags = 0;
  level.mugger_jackpot_tags_unspawned = 0;
  level.mugger_jackpot_num_tags = 0;
  level thread mugger_jackpot_timer();
  for(;;) {
    level waittill("mugger_jackpot_increment");
    var_00 = 1;
    if(var_00) {
      level.mugger_jackpot_num_tags++;
      var_01 = clamp(float(level.mugger_jackpot_num_tags / level.mugger_jackpot_limit), 0, 1);
      if(level.mugger_jackpot_num_tags >= level.mugger_jackpot_limit) {
        if(isDefined(level.mugger_jackpot_text)) {
          level.mugger_jackpot_text thread scripts\mp\hud::fontpulse(level.players[0]);
        }

        level.mugger_jackpot_num_tags = 15 + randomintrange(0, 3) * 5;
        level thread mugger_jackpot_drop();
        break;
      }
    }
  }
}

mugger_jackpot_timer() {
  level endon("game_ended");
  level endon("jackpot_stop");
  scripts\mp\utility::gameflagwait("prematch_done");
  for(;;) {
    wait(level.mugger_jackpot_wait_sec);
    level notify("mugger_jackpot_increment");
  }
}

mugger_jackpot_drop() {
  level endon("game_ended");
  level notify("reset_airdrop");
  level endon("reset_airdrop");
  var_00 = level.mugger_dropzones[level.script][randomint(level.mugger_dropzones[level.script].size)];
  var_00 = var_00 + (randomintrange(-50, 50), randomintrange(-50, 50), 0);
  for(;;) {
    var_01 = level.players[0];
    var_02 = 1;
    if(isDefined(var_01) && scripts\mp\utility::currentactivevehiclecount() < scripts\mp\utility::maxvehiclesallowed() && level.fauxvehiclecount + var_02 < scripts\mp\utility::maxvehiclesallowed() && level.numdropcrates < 8) {
      foreach(var_04 in level.players) {
        var_04 thread scripts\mp\hud_message::showsplash("mugger_jackpot_incoming");
      }

      scripts\mp\utility::incrementfauxvehiclecount();
      level thread scripts\mp\killstreaks\_airdrop::doflyby(var_01, var_00, randomfloat(360), "airdrop_mugger", 0, "airdrop_jackpot");
      break;
    } else {
      wait(0.5);
      continue;
    }
  }

  level.mugger_jackpot_tags_unspawned = level.mugger_jackpot_num_tags;
  level thread mugger_jackpot_run(var_00);
}

mugger_jackpot_pile_notify(param_00, param_01, param_02) {
  if(!isDefined(level.jackpotpileobjid)) {
    level.jackpotpileobjid = scripts\mp\objidpoolmanager::requestminimapid(99);
    if(level.jackpotpileobjid != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(level.jackpotpileobjid, "active", param_00);
      scripts\mp\objidpoolmanager::minimap_objective_icon(level.jackpotpileobjid, "waypoint_jackpot");
    }
  } else if(level.jackpotpileobjid != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_position(level.jackpotpileobjid, param_00);
  }

  if(param_02 >= 10) {
    foreach(var_04 in level.players) {
      var_04 playlocalsound(game["music"]["victory_" + var_04.pers["team"]]);
    }

    if(!isDefined(level.jackpotpileicon)) {
      level.jackpotpileicon = newhudelem();
      level.jackpotpileicon setshader("waypoint_jackpot", 64, 64);
      level.jackpotpileicon setwaypoint(0, 1, 0, 0);
    }

    level.jackpotpileicon.x = param_00[0];
    level.jackpotpileicon.y = param_00[1];
    level.jackpotpileicon.var_3A6 = param_00[2] + 12;
    level.jackpotpileicon.alpha = 0.75;
  }
}

mugger_jackpot_pile_notify_cleanup() {
  if(level.jackpotpileobjid != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_state(level.jackpotpileobjid, "invisible");
  }

  level.jackpotpileicon fadeovertime(2);
  level.jackpotpileicon.alpha = 0;
  level.jackpotpileicon scripts\engine\utility::delaythread(2, ::hudelemdestroy);
}

mugger_jackpot_fx(param_00) {
  mugger_jackpot_fx_cleanup();
  var_01 = param_00 + (0, 0, 30);
  var_02 = param_00 + (0, 0, -1000);
  var_03 = bulletTrace(var_01, var_02, 0, undefined);
  level.jackpot_zone.origin = var_03["position"] + (0, 0, 1);
  level.jackpot_zone show();
  var_04 = vectortoangles(var_03["normal"]);
  var_05 = anglesToForward(var_04);
  var_06 = anglestoright(var_04);
  thread spawnfxdelay(var_03["position"], var_05, var_06, 0.5);
  wait(0.1);
  playFXOnTag(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx");
  foreach(var_08 in level.players) {
    var_08.mugger_fx_playing = 1;
  }

  level.jackpot_zone.mugger_fx_playing = 1;
}

mugger_jackpot_fx_cleanup() {
  stopFXOnTag(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx");
  level.jackpot_zone hide();
  if(isDefined(level.jackpot_targetfx)) {
    level.jackpot_targetfx delete();
  }

  if(level.jackpot_zone.mugger_fx_playing) {
    level.jackpot_zone.mugger_fx_playing = 0;
    stopFXOnTag(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx");
    wait(0.05);
  }
}

spawnfxdelay(param_00, param_01, param_02, param_03) {
  if(isDefined(level.jackpot_targetfx)) {
    level.jackpot_targetfx delete();
  }

  wait(param_03);
  level.jackpot_targetfx = spawnfx(level.mugger_targetfxid, param_00, param_01, param_02);
  triggerfx(level.jackpot_targetfx);
}

waitreplaysmokefxfornewplayer() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\utility::gameflagwait("prematch_done");
  wait(0.5);
  if(level.jackpot_zone.mugger_fx_playing == 1 && !isDefined(self.mugger_fx_playing)) {
    playfxontagforclients(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx", self);
    self.mugger_fx_playing = 1;
  }
}

mugger_jackpot_run(param_00) {
  level endon("game_ended");
  level endon("jackpot_timeout");
  level notify("jackpot_stop");
  mugger_jackpot_pile_notify(param_00, "mugger_jackpot", level.mugger_jackpot_tags_unspawned);
  level thread mugger_jackpot_fx(param_00);
  level thread mugger_jackpot_abort_after_time(30);
  level waittill("airdrop_jackpot_landed", param_00);
  if(level.jackpotpileobjid != -1) {
    scripts\mp\objidpoolmanager::minimap_objective_position(level.jackpotpileobjid, param_00);
  }

  level.jackpotpileicon.x = param_00[0];
  level.jackpotpileicon.y = param_00[1];
  level.jackpotpileicon.var_3A6 = param_00[2] + 32;
  foreach(var_02 in level.players) {
    var_02 playsoundtoplayer("mp_defcon_one", var_02);
    var_02 thread scripts\mp\hud_message::showsplash("mugger_jackpot", level.mugger_jackpot_tags_unspawned);
  }

  level.mugger_jackpot_tags_spawned = 0;
  while(level.mugger_jackpot_tags_unspawned > 0) {
    if(level.mugger_jackpot_tags_spawned < 10) {
      level.mugger_jackpot_tags_unspawned--;
      var_04 = mugger_tag_temp_spawn(param_00, 0, 400);
      var_04.jackpot_tag = 1;
      level.mugger_jackpot_tags_spawned++;
      level thread mugger_jackpot_abort_after_time(90);
      wait(0.1);
      continue;
    }

    wait(0.5);
  }

  level.mugger_jackpot_num_tags = 0;
  while(level.mugger_jackpot_tags_spawned > 0) {
    wait(1);
  }

  mugger_jackpot_cleanup();
}

mugger_jackpot_cleanup() {
  level notify("jackpot_cleanup");
  mugger_jackpot_pile_notify_cleanup();
  mugger_jackpot_fx_cleanup();
  level thread mugger_jackpot_watch();
}

mugger_jackpot_abort_after_time(param_00) {
  level endon("jackpot_cleanup");
  level notify("jackpot_abort_after_time");
  level endon("jackpot_abort_after_time");
  wait(param_00);
  level notify("jackpot_timeout");
}

createmuggercrates(param_00, param_01) {
  scripts\mp\killstreaks\_airdrop::addcratetype("airdrop_mugger", "airdrop_jackpot", 1, ::muggercratethink);
}

muggercratethink(param_00) {
  self endon("death");
  level notify("airdrop_jackpot_landed", self.origin);
  wait(0.5);
  scripts\mp\killstreaks\_airdrop::deletecrateold();
}

createdropzones() {
  level.mugger_dropzones = [];
  var_00 = undefined;
  if(isDefined(var_00) && var_00.size) {
    var_01 = 0;
    foreach(var_03 in var_00) {
      level.mugger_dropzones[level.script][var_01] = var_03.origin;
      var_01++;
    }

    return;
  }

  level.mugger_dropzones["mp_seatown"][0] = (-665, -209, 226);
  level.mugger_dropzones["mp_seatown"][1] = (-2225, 1573, 260);
  level.mugger_dropzones["mp_seatown"][2] = (1275, -747, 292);
  level.mugger_dropzones["mp_seatown"][3] = (1210, 963, 225);
  level.mugger_dropzones["mp_seatown"][4] = (-2343, -811, 226);
  level.mugger_dropzones["mp_seatown"][5] = (-1125, -1610, 184);
  level.mugger_dropzones["mp_dome"][0] = (649, 1096, -250);
  level.mugger_dropzones["mp_dome"][1] = (953, -501, -328);
  level.mugger_dropzones["mp_dome"][2] = (-37, 2099, -231);
  level.mugger_dropzones["mp_dome"][3] = (-716, 1100, -296);
  level.mugger_dropzones["mp_dome"][4] = (-683, -51, -352);
  level.mugger_dropzones["mp_plaza2"][0] = (266, -212, 708);
  level.mugger_dropzones["mp_plaza2"][1] = (295, 1842, 668);
  level.mugger_dropzones["mp_plaza2"][2] = (-1449, 1833, 692);
  level.mugger_dropzones["mp_plaza2"][3] = (835, -1815, 668);
  level.mugger_dropzones["mp_plaza2"][4] = (-1116, 76, 729);
  level.mugger_dropzones["mp_plaza2"][5] = (-399, 951, 676);
  level.mugger_dropzones["mp_mogadishu"][0] = (552, 1315, 8);
  level.mugger_dropzones["mp_mogadishu"][1] = (990, 3248, 144);
  level.mugger_dropzones["mp_mogadishu"][2] = (-879, 2643, 135);
  level.mugger_dropzones["mp_mogadishu"][3] = (-68, -995, 16);
  level.mugger_dropzones["mp_mogadishu"][4] = (1499, -1206, 15);
  level.mugger_dropzones["mp_mogadishu"][5] = (2387, 1786, 61);
  level.mugger_dropzones["mp_paris"][0] = (-150, -80, 63);
  level.mugger_dropzones["mp_paris"][1] = (-947, -1088, 107);
  level.mugger_dropzones["mp_paris"][2] = (1052, -614, 50);
  level.mugger_dropzones["mp_paris"][3] = (1886, 648, 24);
  level.mugger_dropzones["mp_paris"][4] = (628, 2096, 30);
  level.mugger_dropzones["mp_paris"][5] = (-2033, 1082, 308);
  level.mugger_dropzones["mp_paris"][6] = (-1230, 1836, 295);
  level.mugger_dropzones["mp_exchange"][0] = (904, 441, -77);
  level.mugger_dropzones["mp_exchange"][1] = (-1056, 1435, 141);
  level.mugger_dropzones["mp_exchange"][2] = (800, 1543, 148);
  level.mugger_dropzones["mp_exchange"][3] = (2423, 1368, 141);
  level.mugger_dropzones["mp_exchange"][4] = (596, -1870, 89);
  level.mugger_dropzones["mp_exchange"][5] = (-1241, -821, 30);
  level.mugger_dropzones["mp_bootleg"][0] = (-444, -114, -8);
  level.mugger_dropzones["mp_bootleg"][1] = (1053, -1051, -13);
  level.mugger_dropzones["mp_bootleg"][2] = (889, 1184, -28);
  level.mugger_dropzones["mp_bootleg"][3] = (-994, 1877, -41);
  level.mugger_dropzones["mp_bootleg"][4] = (-1707, -1333, 63);
  level.mugger_dropzones["mp_bootleg"][5] = (-334, -2155, 61);
  level.mugger_dropzones["mp_carbon"][0] = (-1791, -3892, 3813);
  level.mugger_dropzones["mp_carbon"][1] = (-338, -4978, 3964);
  level.mugger_dropzones["mp_carbon"][2] = (-82, -2941, 3990);
  level.mugger_dropzones["mp_carbon"][3] = (-3198, -2829, 3809);
  level.mugger_dropzones["mp_carbon"][4] = (-3673, -3893, 3610);
  level.mugger_dropzones["mp_carbon"][5] = (-2986, -4863, 3648);
  level.mugger_dropzones["mp_hardhat"][0] = (1187, -322, 238);
  level.mugger_dropzones["mp_hardhat"][1] = (2010, -1379, 357);
  level.mugger_dropzones["mp_hardhat"][2] = (1615, 1245, 366);
  level.mugger_dropzones["mp_hardhat"][3] = (-371, 825, 436);
  level.mugger_dropzones["mp_hardhat"][4] = (-820, -927, 348);
  level.mugger_dropzones["mp_alpha"][0] = (-239, 1315, 52);
  level.mugger_dropzones["mp_alpha"][1] = (-1678, -219, 55);
  level.mugger_dropzones["mp_alpha"][2] = (235, -369, 60);
  level.mugger_dropzones["mp_alpha"][3] = (-201, 2138, 60);
  level.mugger_dropzones["mp_alpha"][4] = (-1903, 2433, 198);
  level.mugger_dropzones["mp_village"][0] = (990, -821, 331);
  level.mugger_dropzones["mp_village"][1] = (658, 2155, 337);
  level.mugger_dropzones["mp_village"][2] = (-559, 1882, 310);
  level.mugger_dropzones["mp_village"][3] = (-1999, 1184, 343);
  level.mugger_dropzones["mp_village"][4] = (215, -2875, 384);
  level.mugger_dropzones["mp_village"][5] = (1731, -483, 290);
  level.mugger_dropzones["mp_lambeth"][0] = (712, 217, -196);
  level.mugger_dropzones["mp_lambeth"][1] = (1719, -1095, -196);
  level.mugger_dropzones["mp_lambeth"][2] = (2843, 1034, -269);
  level.mugger_dropzones["mp_lambeth"][3] = (1251, 2645, -213);
  level.mugger_dropzones["mp_lambeth"][4] = (-1114, 1301, -200);
  level.mugger_dropzones["mp_lambeth"][5] = (-693, -823, -132);
  level.mugger_dropzones["mp_radar"][0] = (-5052, 2371, 1223);
  level.mugger_dropzones["mp_radar"][1] = (-4550, 4199, 1268);
  level.mugger_dropzones["mp_radar"][2] = (-7149, 4449, 1376);
  level.mugger_dropzones["mp_radar"][3] = (-6350, 1528, 1302);
  level.mugger_dropzones["mp_radar"][4] = (-3333, 992, 1222);
  level.mugger_dropzones["mp_radar"][5] = (-4040, -361, 1222);
  level.mugger_dropzones["mp_interchange"][0] = (662, -513, 142);
  level.mugger_dropzones["mp_interchange"][1] = (674, 1724, 112);
  level.mugger_dropzones["mp_interchange"][2] = (-1003, 1103, 30);
  level.mugger_dropzones["mp_interchange"][3] = (385, -2910, 209);
  level.mugger_dropzones["mp_interchange"][4] = (2004, -1760, 144);
  level.mugger_dropzones["mp_interchange"][5] = (2458, -300, 147);
  level.mugger_dropzones["mp_underground"][0] = (31, 1319, -196);
  level.mugger_dropzones["mp_underground"][1] = (165, -940, 60);
  level.mugger_dropzones["mp_underground"][2] = (-747, 143, 4);
  level.mugger_dropzones["mp_underground"][3] = (-1671, 1666, -216);
  level.mugger_dropzones["mp_underground"][4] = (-631, 3158, -68);
  level.mugger_dropzones["mp_underground"][5] = (500, 2865, -89);
  level.mugger_dropzones["mp_bravo"][0] = (-39, -119, 1280);
  level.mugger_dropzones["mp_bravo"][1] = (1861, -563, 1229);
  level.mugger_dropzones["mp_bravo"][2] = (-1548, -366, 1007);
  level.mugger_dropzones["mp_bravo"][3] = (-678, 1272, 1273);
  level.mugger_dropzones["mp_bravo"][4] = (1438, 842, 1272);
}