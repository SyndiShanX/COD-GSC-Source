/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\mugger.gsc
***********************************************/

function main() {
  if(getDvar("mapname") == "mp_background") {
    return;
  }

  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  GscBinSkip1(0x45, 0, scripts\mp\utility\game::getgametype());
}

function initializematchrules() {
  scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
  setdynamicdvar("scr_mugger_roundswitch", 0);
  scripts\mp\utility\game::registerroundswitchdvar("mugger", 0, 0, 9);
  setdynamicdvar("scr_mugger_roundlimit", 1);
  scripts\mp\utility\game::registerroundlimitdvar("mugger", 1);
  setdynamicdvar("scr_mugger_winlimit", 1);
  scripts\mp\utility\game::registerwinlimitdvar("mugger", 1);
  setdynamicdvar("scr_mugger_halftime", 0);
  scripts\mp\utility\game::registerhalftimedvar("mugger", 0);
  setdynamicdvar("scr_mugger_promode", 0);
  level.mugger_bank_limit = getmatchrulesdata("muggerData", "bankLimit");
  setdynamicdvar("scr_mugger_bank_limit", level.mugger_bank_limit);
  level.mugger_jackpot_limit = getmatchrulesdata("muggerData", "jackpotLimit");
  setdynamicdvar("scr_mugger_jackpot_limit", level.mugger_jackpot_limit);
  level.mugger_throwing_knife_mug_frac = getmatchrulesdata("muggerData", "throwKnifeFrac");
  setdynamicdvar("scr_mugger_throwing_knife_mug_frac", level.mugger_throwing_knife_mug_frac);
}

function onprecachegametype() {
  precachemodel("dogtags_iw7_foe");
  precachemodel("lethal_smoke_grenade_wm");
  precachempanim("mp_dogtag_spin");
  precacheshader("waypoint_dogtags2");
  precacheshader("waypoint_dogtag_pile");
  precacheshader("waypoint_jackpot");
  precacheshader("hud_tagcount");
  precachestring(&"MPUI_MUGGER_JACKPOT");
}

function onstartgametype() {
  setclientnamemode("auto_change");

  foreach(var_1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var_1, &"OBJECTIVES/MUGGER");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/MUGGER");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var_1, &"OBJECTIVES/MUGGER_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var_1, &"OBJECTIVES/MUGGER_HINT");
  }

  scripts\mp\spawnlogic::setactivespawnlogic("FreeForAll", "Crit_Default");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  scripts\mp\spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
  scripts\mp\spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
  scripts\mp\spawnlogic::registerspawnset("normal", "mp_dm_spawn");
  scripts\mp\spawnlogic::registerspawnset("fallback", "mp_dm_spawn_secondary");
  level.mapcenter = scripts\mp\spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  level.dogtags = [];
  level.mugger_timelimit = getdvarint("scr_mugger_timelimit", 7);
  setdynamicdvar("scr_mugger_timeLimit", level.mugger_timelimit);
  scripts\mp\utility\game::registertimelimitdvar("mugger", level.mugger_timelimit);
  level.mugger_scorelimit = getdvarint("scr_mugger_scorelimit", 2500);

  if(level.mugger_scorelimit == 0) {
    level.mugger_scorelimit = 2500;
  }

  setdynamicdvar("scr_mugger_scoreLimit", level.mugger_scorelimit);
  scripts\mp\utility\game::registerscorelimitdvar("mugger", level.mugger_scorelimit);
  level.mugger_bank_limit = getdvarint("scr_mugger_bank_limit", 10);
  level.mugger_muggernaut_window = getdvarint("scr_mugger_muggernaut_window", 3000);
  level.mugger_muggernaut_muggings_needed = getdvarint("scr_mugger_muggernaut_muggings_needed", 3);
  level.mugger_min_spawn_dist_sq = squared(getdvarfloat("mugger_min_spawn_dist", 350));
  level.mugger_jackpot_limit = getdvarint("scr_mugger_jackpot_limit", 0);
  level.mugger_jackpot_wait_sec = getdvarfloat("scr_mugger_jackpot_wait_sec", 10);
  level.mugger_throwing_knife_mug_frac = getdvarfloat("scr_mugger_throwing_knife_mug_frac", 1);
  mugger_init_tags(level);
  thread mugger_monitor_tank_pickups();
  thread mugger_monitor_remote_uav_pickups();
  level.jackpot_zone = spawn("script_model", (0, 0, 0));
  level.jackpot_zone.origin = (0, 0, 0);
  level.jackpot_zone.angles = (90, 0, 0);
  level.jackpot_zone setModel("lethal_smoke_grenade_wm");
  level.jackpot_zone hide();
  level.jackpot_zone.mugger_fx_playing = 0;
  thread mugger_jackpot_watch();
}

function onplayerconnect(var_0) {
  var_0.tags_carried = 0;
  var_0.total_tags_banked = 0;
  var_0.assists = var_0.total_tags_banked;
  var_0.pers["assists"] = var_0.total_tags_banked;
  var_0.game_extrainfo = var_0.tags_carried;
  var_0.muggings = [];

  if(isPlayer(var_0) && !isbot(var_0)) {
    var_0.dogtagsicon = var_0 scripts\mp\hud_util::createicon("hud_tagcount", 48, 48);
    var_0.dogtagsicon scripts\mp\hud_util::setpoint("TOP LEFT", "TOP LEFT", 200, 0);
    var_0.dogtagsicon.alpha = 1;
    var_0.dogtagsicon.hidewheninmenu = 1;
    var_0.dogtagsicon.archived = 1;
    thread hidehudelementongameend(level);
    var_0.dogtagstext = var_0 scripts\mp\hud_util::createfontstring("bigfixed", 1);
    var_0.dogtagstext scripts\mp\hud_util::setparent(var_0.dogtagsicon);
    var_0.dogtagstext scripts\mp\hud_util::setpoint("CENTER", "CENTER", -24);
    var_0.dogtagstext setvalue(var_0.tags_carried);
    var_0.dogtagstext.alpha = 1;
    var_0.dogtagstext.color = (1, 1, 0.5);
    var_0.dogtagstext.glowalpha = 1;
    var_0.dogtagstext.sort = 1;
    var_0.dogtagstext.hidewheninmenu = 1;
    var_0.dogtagstext.archived = 1;
    var_0.dogtagstext scripts\mp\hud::fontpulseinit(3);
    thread hidehudelementongameend(level);
    return;
  }
}

function onspawnplayer() {
  self.muggings = [];

  if(!isagent(self)) {
    thread waitreplaysmokefxfornewplayer();
    return;
  }
}

function hidehudelementongameend(var_0) {
  level waittill("game_ended");

  if(isDefined(var_0)) {
    var_0.alpha = 0;
    return;
  }
}

function getspawnpoint() {
  var_0 = scripts\mp\spawnlogic::getspawnpoint(self, "none", "normal", "fallback");
  return var_0;
}

function onxpevent(var_0) {}

function onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::onnormaldeath(var_0, var_1, var_2, var_3, var_4, var_5);
  thread spawndogtags(level, var_0);
}

function mugger_init_tags() {
  level.mugger_max_extra_tags = getdvarint("scr_mugger_max_extra_tags", 50);
  level.mugger_extra_tags = [];
}

function spawndogtags(var_0, var_1) {
  if(isagent(var_1)) {
    var_1 = var_1.owner;
  }

  var_2 = 0;
  var_3 = 0;

  if(isDefined(var_1)) {
    if(var_0 == var_1) {
      if(var_0.tags_carried > 0) {
        var_2 = var_0.tags_carried;
        var_0.tags_carried = 0;
        var_0.game_extrainfo = 0;

        if(isPlayer(var_0) && !isbot(var_0)) {
          var_0.dogtagstext setvalue(var_0.tags_carried);
          var_0.dogtagstext thread scripts\mp\hud::fontpulse(var_0);
          var_0 thread scripts\mp\hud_message::showsplash("mugger_suicide", var_2);
        }
      }
    } else if(isDefined(var_0.attackerdata) && var_0.attackerdata.size > 0) {
      if(isPlayer(var_1) && isDefined(var_0.attackerdata) && isDefined(var_1.guid) && isDefined(var_0.attackerdata[var_1.guid])) {
        var_4 = var_0.attackerdata[var_1.guid];

        if(isDefined(var_4) && isDefined(var_4.attackerent) && var_4.attackerent == var_1) {
          if(isDefined(var_4.smeansofdeath) && (var_4.smeansofdeath == "MOD_MELEE" || var_4.weapon == "throwingknife_mp" && level.mugger_throwing_knife_mug_frac > 0)) {
            var_3 = 1;

            if(var_0.tags_carried > 0) {
              var_2 = var_0.tags_carried;

              if(var_4.weapon == "throwingknife_mp" && level.mugger_throwing_knife_mug_frac < 1) {
                var_2 = int(ceil(var_0.tags_carried * level.mugger_throwing_knife_mug_frac));
              }

              var_0.tags_carried -= var_2;
              var_0.game_extrainfo = var_0.tags_carried;

              if(isPlayer(var_0) && !isbot(var_0)) {
                var_0.dogtagstext setvalue(var_0.tags_carried);
                var_0.dogtagstext thread scripts\mp\hud::fontpulse(var_0);
                var_0 thread scripts\mp\hud_message::showsplash("callout_mugged", var_2);
                var_0 playlocalsound("mugger_got_mugged");
              }

              playsoundatpos(var_0.origin, "mugger_mugging");
              var_1 thread scripts\mp\hud_message::showsplash("callout_mugger", var_2);

              if(var_4.weapon == "throwingknife_mp") {
                var_1 playlocalsound("mugger_you_mugged");
              }
            }

            var_1.muggings[var_1.muggings.size] = gettime();
            thread mugger_check_muggernaut();
          }
        }
      }
    }
  }

  if(isagent(var_0)) {
    var_5 = var_0.origin + (0, 0, 14);
    playsoundatpos(var_5, "mp_killconfirm_tags_drop");
    level notify("mugger_jackpot_increment");
    var_6 = mugger_tag_temp_spawn(var_0.origin, 40, 160);
    var_6.victim = var_0.owner;

    if(isDefined(var_1) && var_0 != var_1) {
      var_6.attacker = var_1;
      return;
    }

    var_6.attacker = undefined;
    return;
  } else if(isDefined(level.dogtags[var_2.guid])) {
    playFX(level.mugger_fx["vanish"], level.dogtags[var_2.guid].curorigin);
    level.dogtags[var_2.guid] notify("reset");
  } else {
    GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)), var_1);
  }

  var_5 = var_2.origin + (0, 0, 14);
  level.dogtags[var_2.guid].curorigin = var_5;
  level.dogtags[var_2.guid].trigger.origin = var_5;
  level.dogtags[var_2.guid].visuals[0].origin = var_5;
  level.dogtags[var_2.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.dogtags[var_2.guid] scripts\mp\gameobjects::allowuse("any");
  level.dogtags[var_2.guid].visuals[0] show();

  if(isDefined(var_3) && var_2 != var_3) {
    level.dogtags[var_2.guid].attacker = var_3;
  } else {
    level.dogtags[var_2.guid].attacker = undefined;
  }

  thread timeout();

  if(var_5 < 5) {
    scripts\mp\objidpoolmanager::update_objective_position(level.dogtags[var_2.guid].objid, var_5);
    scripts\mp\objidpoolmanager::update_objective_state(level.dogtags[var_2.guid].objid, "active");
  } else {
    mugger_tag_pile_notify(var_5, "mugger_megadrop", var_5, var_2, var_3);
  }

  playsoundatpos(var_5, "mp_killconfirm_tags_drop");
  level.dogtags[var_2.guid].temp_tag = 0;

  if(var_5 == 0) {
    level notify("mugger_jackpot_increment");
  }

  for(var_9 = 0; var_9 < var_5; var_9++) {
    var_6 = mugger_tag_temp_spawn(var_2.origin, 40, 160);
    var_6.victim = var_2;

    if(isDefined(var_3) && var_2 != var_3) {
      var_6.attacker = var_3;
      continue;
    }

    var_6.attacker = undefined;
  }
}

function mugger_tag_pickup_wait() {
  level endon("game_ended");
  self endon("reset");
  self endon("reused");
  self endon("deleted");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }

    if(var_0 scripts\mp\utility\player::isusingremote() || isDefined(var_0.spawningafterremotedeath)) {
      continue;
    }

    if(isDefined(var_0.classname) && var_0.classname == "script_vehicle") {
      continue;
    }

    thread onuse(var_0);
    return;
  }
}

function mugger_add_extra_tag(var_0) {
  GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)));
}

function mugger_first_unused_or_oldest_extra_tag() {
  var_0 = undefined;
  var_1 = -1;

  foreach(var_3 in level.mugger_extra_tags) {
    if(var_3.interactteam == "none") {
      var_3.last_used_time = gettime();
      var_3.visuals[0] show();
      return var_3;
    }

    if(!isDefined(var_0) || var_3.last_used_time < var_1) {
      var_1 = var_3.last_used_time;
      var_0 = var_3;
    }
  }

  if(level.mugger_extra_tags.size < level.mugger_max_extra_tags) {
    var_5 = mugger_add_extra_tag(level.mugger_extra_tags.size);

    if(isDefined(var_5)) {
      var_5.last_used_time = gettime();
      return var_5;
    }
  }

  var_0.last_used_time = gettime();
  var_0 notify("reused");
  playFX(level.mugger_fx["vanish"], var_0.curorigin);
  return var_0;
}

function mugger_tag_temp_spawn(var_0, var_1, var_2) {
  var_3 = mugger_first_unused_or_oldest_extra_tag();
  var_4 = var_0 + (0, 0, 14);
  var_5 = (0, randomfloat(360), 0);
  var_6 = anglesToForward(var_5);
  var_7 = randomfloatrange(40, 160);
  var_8 = var_4 + var_7 * var_6;
  var_8 += (0, 0, 40);
  var_9 = playerphysicstrace(var_4, var_8);
  var_4 = var_9;
  var_8 = var_4 + (0, 0, -100);
  var_9 = playerphysicstrace(var_4, var_8);

  if(var_9[2] != var_8[2]) {
    var_9 += (0, 0, 14);
  }

  var_3.curorigin = var_9;
  var_3.trigger.origin = var_9;
  var_3.visuals[0].origin = var_9;
  var_3 scripts\mp\gameobjects::initializetagpathvariables();
  var_3 scripts\mp\gameobjects::allowuse("any");
  thread mugger_tag_pickup_wait();
  thread timeout();
  return var_3;
}

function mugger_tag_pile_notify(var_0, var_1, var_2, var_3, var_4) {
  level notify("mugger_tag_pile", var_0);
  var_5 = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(var_5 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_5, "active", var_0);
    scripts\mp\objidpoolmanager::update_objective_icon(var_5, "waypoint_dogtag_pile");
  }

  level scripts\engine\utility::delaythread(5, &mugger_pile_icon_remove, var_5);

  if(var_2 >= 10) {
    level.mugger_last_mega_drop = gettime();
    level.mugger_jackpot_num_tags = 0;

    foreach(var_7 in level.players) {
      var_7 playsoundtoplayer("mp_defcon_one", var_7);

      if(isDefined(var_3) && var_7 == var_3) {
        continue;
      }

      if(isDefined(var_4) && var_7 == var_4) {
        continue;
      }

      var_7 thread scripts\mp\hud_message::showsplash(var_1, var_2);
    }

    var_9 = newhudelem();
    var_9 setshader("waypoint_dogtag_pile", 10, 10);
    var_9 setwaypoint(0, 1, 0, 0);
    var_9.x = var_0[0];
    var_9.y = var_0[1];
    var_9.z = var_0[2] + 32;
    var_9.alpha = 1;
    var_9 fadeovertime(5);
    var_9.alpha = 0;
    var_9 scripts\engine\utility::delaythread(5, &hudelemdestroy);
    return;
  }
}

function hudelemdestroy() {
  if(isDefined(self)) {
    self destroy();
    return;
  }
}

function mugger_monitor_tank_pickups() {
  level endon("game_ended");

  for(;;) {
    var_0 = getEntArray("remote_tank", "targetname");
    var_1 = getEntArray("trigger_dogtag", "targetname");

    foreach(var_3 in level.players) {
      if(isDefined(var_3.using_remote_tank) && var_3.using_remote_tank == 1) {
        foreach(var_5 in var_0) {
          if(isDefined(var_5) && isDefined(var_5.owner) && var_5.owner == var_3) {
            foreach(var_7 in var_1) {
              if(isDefined(var_7) && isDefined(var_7.dogtag)) {
                if(isDefined(var_7.dogtag.interactteam) && var_7.dogtag.interactteam != "none") {
                  if(var_5 istouching(var_7)) {
                    onuse(var_7.dogtag, var_5.owner);
                  }
                }
              }
            }
          }
        }
      }
    }

    wait 0.2;
  }
}

function mugger_monitor_remote_uav_pickups() {
  level endon("game_ended");

  for(;;) {
    var_0 = getEntArray("trigger_dogtag", "targetname");

    foreach(var_2 in level.players) {
      if(isDefined(var_2) && isDefined(var_2.remoteuav)) {
        foreach(var_4 in var_0) {
          if(isDefined(var_4) && isDefined(var_4.dogtag)) {
            if(isDefined(var_4.dogtag.interactteam) && var_4.dogtag.interactteam != "none") {
              if(var_2.remoteuav istouching(var_4)) {
                onuse(var_4.dogtag, var_2);
              }
            }
          }
        }
      }
    }

    wait 0.2;
  }
}

function mugger_check_muggernaut() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("checking_muggernaut");
  self endon("checking_muggernaut");
  wait 2;

  if(self.muggings.size < level.mugger_muggernaut_muggings_needed) {
    return;
  }

  var_0 = self.muggings[self.muggings.size - 1];
  var_1 = var_0 - level.mugger_muggernaut_window;
  var_2 = [];

  foreach(var_4 in self.muggings) {
    if(var_4 >= var_1) {
      var_2 = var_4;
    }
  }

  if(var_2.size >= level.mugger_muggernaut_muggings_needed) {
    thread scripts\mp\utility\points::giveunifiedpoints("muggernaut");
    mugger_bank_tags(1, 1);
    self.muggings = [];
    return;
  }

  self.muggings = var_2;
}

function mugger_pile_icon_remove(var_0) {
  scripts\mp\objidpoolmanager::returnobjectiveid(var_0);
}

function _hidefromplayer(var_0) {
  self hide();

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self showtoplayer(var_2);
    }
  }
}

function onuse(var_0) {
  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
  }

  if(self.temp_tag) {
    self.trigger playSound("mp_killconfirm_tags_deny");
  } else if(isDefined(self.attacker) && var_0 == self.attacker) {
    self.trigger playSound("mp_killconfirm_tags_pickup");
    var_0 scripts\mp\utility\stats::incpersstat("confirmed", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "confirmed", var_0.pers["confirmed"]);
  } else {
    self.trigger playSound("mp_killconfirm_tags_deny");
    var_0 scripts\mp\utility\stats::incpersstat("denied", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "denied", var_0.pers["denied"]);
  }

  thread onpickup();
  resettags(1);
}

function onpickup(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  thread mugger_delayed_banking();
}

function mugger_delayed_banking() {
  self notify("banking");
  self endon("banking");
  level endon("banking_all");
  self.tags_carried++;
  self.game_extrainfo = self.tags_carried;

  if(isPlayer(self) && !isbot(self)) {
    self.dogtagstext setvalue(self.tags_carried);
    self.dogtagstext thread scripts\mp\hud::fontpulse(self);
  }

  wait 1.5;
  var_0 = level.mugger_bank_limit - self.tags_carried;

  if(var_0 > 0 && var_0 <= 5) {
    var_1 = undefined;

    switch (var_0) {
      case 1:
        var_1 = "mugger_1more";
        break;
      case 2:
        var_1 = "mugger_2more";
        break;
      case 3:
        var_1 = "mugger_3more";
        break;
      case 4:
        var_1 = "mugger_4more";
        break;
      case 5:
        var_1 = "mugger_5more";
        break;
    }

    if(isDefined(var_1)) {
      self playsoundtoplayer(var_1, self);
    }
  }

  wait 0.5;
  mugger_bank_tags(0);
}

function mugger_bank_tags(var_0, var_1) {
  var_2 = 0;

  if(var_0 == 1) {
    var_2 = self.tags_carried;
  } else {
    var_3 = self.tags_carried % level.mugger_bank_limit;
    var_2 = self.tags_carried - var_3;
  }

  if(var_2 > 0) {
    self.tags_to_bank = var_2;

    if(!isDefined(var_1)) {
      thread scripts\mp\hud_message::showsplash("callout_tags_banked", var_2);
    }

    thread scripts\mp\utility\points::giveunifiedpoints("tags_banked", undefined, self.tags_to_bank * scripts\mp\rank::getscoreinfovalue("kill_confirmed"));
    self.total_tags_banked += var_2;
    self.tags_carried -= var_2;
    self.game_extrainfo = self.tags_carried;

    if(isPlayer(self) && !isbot(self)) {
      self.dogtagstext setvalue(self.tags_carried);
      self.dogtagstext thread scripts\mp\hud::fontpulse(self);
    }

    self.assists = self.total_tags_banked;
    self.pers["assists"] = self.total_tags_banked;
    return;
  }
}

function onplayerscore(var_0, var_1) {
  if(var_0 == "tags_banked" && isDefined(var_1) && isDefined(var_1.tags_to_bank) && var_1.tags_to_bank > 0) {
    var_2 = var_1.tags_to_bank * scripts\mp\rank::getscoreinfovalue("kill_confirmed");
    var_1.tags_to_bank = 0;
    return var_2;
  }

  return 0;
}

function resettags(var_0) {
  if(!var_0) {
    level notify("mugger_jackpot_increment");
  }

  self.attacker = undefined;
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
    scripts\mp\objidpoolmanager::update_objective_state(self.objid, "invisible");
    return;
  }
}

function timeout() {
  level endon("game_ended");
  self endon("death");
  self endon("deleted");
  self endon("reset");
  self endon("reused");
  self notify("timeout_start");
  self endon("timeout_start");
  level scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(27);
  var_0 = 3;

  while(var_0 > 0) {
    self.visuals[0] hide();
    wait 0.25;
    self.visuals[0] show();
    wait 0.25;
    var_0 -= 0.5;
  }

  playFX(level.mugger_fx["vanish"], self.curorigin);
  thread resettags(0);
}

function clearonvictimdisconnect(var_0) {
  level endon("game_ended");
  var_1 = var_0.guid;
  var_0 waittill("disconnect");

  if(isDefined(level.dogtags[var_1])) {
    level.dogtags[var_1] scripts\mp\gameobjects::allowuse("none");
    playFX(level.mugger_fx["vanish"], level.dogtags[var_1].curorigin);
    level.dogtags[var_1] notify("reset");
    waitframe();

    if(isDefined(level.dogtags[var_1])) {
      scripts\mp\objidpoolmanager::returnobjectiveid(level.dogtags[var_1].objid);
      level.dogtags[var_1].trigger delete();

      for(var_2 = 0; var_2 < level.dogtags[var_1].visuals.size; var_2++) {
        level.dogtags[var_1].visuals[var_2] delete();
      }

      level.dogtags[var_1] notify("deleted");
      level.dogtags[var_1] = undefined;
      return;
    }

    return;
  }
}

function ontimelimit() {
  level notify("banking_all");

  foreach(var_1 in level.players) {
    mugger_bank_tags(var_1, 1);
  }

  wait 0.1;
  scripts\mp\gamelogic::default_ontimelimit();
}

function mugger_jackpot_watch() {
  level endon("game_ended");
  level endon("jackpot_stop");

  if(level.mugger_jackpot_limit <= 0) {
    return;
  }

  level.mugger_jackpot_num_tags = 0;
  level.mugger_jackpot_tags_unspawned = 0;
  level.mugger_jackpot_num_tags = 0;
  thread mugger_jackpot_timer();

  for(;;) {
    level waittill("mugger_jackpot_increment");
    var_0 = 1;

    if(var_0) {
      level.mugger_jackpot_num_tags++;
      var_1 = clamp(float(level.mugger_jackpot_num_tags / level.mugger_jackpot_limit), 0, 1);

      if(level.mugger_jackpot_num_tags >= level.mugger_jackpot_limit) {
        if(isDefined(level.mugger_jackpot_text)) {
          level.mugger_jackpot_text thread scripts\mp\hud::fontpulse(level.players[0]);
        }

        level.mugger_jackpot_num_tags = 15 + randomintrange(0, 3) * 5;
        thread mugger_jackpot_drop();
        break;
      }
    }
  }
}

function mugger_jackpot_timer() {
  level endon("game_ended");
  level endon("jackpot_stop");
  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    wait level.mugger_jackpot_wait_sec;
    level notify("mugger_jackpot_increment");
  }
}

function mugger_jackpot_drop() {
  level endon("game_ended");
  level notify("reset_airdrop");
  level endon("reset_airdrop");
  var_0 = level.mugger_dropzones[level.script][randomint(level.mugger_dropzones[level.script].size)];
  var_0 += (randomintrange(-50, 50), randomintrange(-50, 50), 0);

  for(;;) {
    var_1 = level.players[0];
    var_2 = 1;

    if(isDefined(var_1) && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + var_2 < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      foreach(var_4 in level.players) {
        var_4 thread scripts\mp\hud_message::showsplash("mugger_jackpot_incoming");
      }

      break;
    }

    wait 0.5;
  }

  level.mugger_jackpot_tags_unspawned = level.mugger_jackpot_num_tags;
  thread mugger_jackpot_run(level);
}

function mugger_jackpot_pile_notify(var_0, var_1, var_2) {
  if(!isDefined(level.jackpotpileobjid)) {
    level.jackpotpileobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(level.jackpotpileobjid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(level.jackpotpileobjid, "active", var_0);
      scripts\mp\objidpoolmanager::update_objective_icon(level.jackpotpileobjid, "waypoint_jackpot");
    }
  } else if(level.jackpotpileobjid != -1) {
    scripts\mp\objidpoolmanager::update_objective_position(level.jackpotpileobjid, var_0);
  }

  if(var_2 >= 10) {
    foreach(var_4 in level.players) {
      var_4 playlocalsound(game["music"]["victory_" + var_4.pers["team"]]);
    }

    if(!isDefined(level.jackpotpileicon)) {
      level.jackpotpileicon = newhudelem();
      level.jackpotpileicon setshader("waypoint_jackpot", 64, 64);
      level.jackpotpileicon setwaypoint(0, 1, 0, 0);
    }

    level.jackpotpileicon.x = var_0[0];
    level.jackpotpileicon.y = var_0[1];
    level.jackpotpileicon.z = var_0[2] + 12;
    level.jackpotpileicon.alpha = 0.75;
    return;
  }
}

function mugger_jackpot_pile_notify_cleanup() {
  if(level.jackpotpileobjid != -1) {
    scripts\mp\objidpoolmanager::update_objective_state(level.jackpotpileobjid, "invisible");
  }

  level.jackpotpileicon fadeovertime(2);
  level.jackpotpileicon.alpha = 0;
  level.jackpotpileicon scripts\engine\utility::delaythread(2, &hudelemdestroy);
}

function mugger_jackpot_fx(var_0) {
  mugger_jackpot_fx_cleanup();
  var_1 = var_0 + (0, 0, 30);
  var_2 = var_0 + (0, 0, -1000);
  var_3 = scripts\engine\trace::ray_trace(var_1, var_2, undefined, scripts\engine\trace::create_default_contents(1));
  level.jackpot_zone.origin = var_3["position"] + (0, 0, 1);
  level.jackpot_zone show();
  var_4 = vectortoangles(var_3["normal"]);
  var_5 = anglesToForward(var_4);
  var_6 = anglestoright(var_4);
  thread spawnfxdelay(var_3["position"], var_5, var_6, 0.5);
  wait 0.1;
  playFXOnTag(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx");

  foreach(var_8 in level.players) {
    var_8.mugger_fx_playing = 1;
  }

  level.jackpot_zone.mugger_fx_playing = 1;
}

function mugger_jackpot_fx_cleanup() {
  stopFXOnTag(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx");
  level.jackpot_zone hide();

  if(isDefined(level.jackpot_targetfx)) {
    level.jackpot_targetfx delete();
  }

  if(level.jackpot_zone.mugger_fx_playing) {
    level.jackpot_zone.mugger_fx_playing = 0;
    stopFXOnTag(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx");
    waitframe();
    return;
  }
}

function spawnfxdelay(var_0, var_1, var_2, var_3) {
  if(isDefined(level.jackpot_targetfx)) {
    level.jackpot_targetfx delete();
  }

  wait var_3;
  level.jackpot_targetfx = spawnfx(level.mugger_targetfxid, var_0, var_1, var_2);
  triggerfx(level.jackpot_targetfx);
}

function waitreplaysmokefxfornewplayer() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("prematch_done");
  wait 0.5;

  if(level.jackpot_zone.mugger_fx_playing == 1 && !isDefined(self.mugger_fx_playing)) {
    playfxontagforclients(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx", self);
    self.mugger_fx_playing = 1;
    return;
  }
}

function mugger_jackpot_run(var_0) {
  level endon("game_ended");
  level endon("jackpot_timeout");
  level notify("jackpot_stop");
  mugger_jackpot_pile_notify(var_0, "mugger_jackpot", level.mugger_jackpot_tags_unspawned);
  thread mugger_jackpot_fx(level);
  thread mugger_jackpot_abort_after_time(level);
  level waittill("airdrop_jackpot_landed", var_0);

  if(level.jackpotpileobjid != -1) {
    scripts\mp\objidpoolmanager::update_objective_position(level.jackpotpileobjid, var_0);
  }

  level.jackpotpileicon.x = var_0[0];
  level.jackpotpileicon.y = var_0[1];
  level.jackpotpileicon.z = var_0[2] + 32;

  foreach(var_2 in level.players) {
    var_2 playsoundtoplayer("mp_defcon_one", var_2);
    var_2 thread scripts\mp\hud_message::showsplash("mugger_jackpot", level.mugger_jackpot_tags_unspawned);
  }

  level.mugger_jackpot_tags_spawned = 0;

  while(level.mugger_jackpot_tags_unspawned > 0) {
    if(level.mugger_jackpot_tags_spawned < 10) {
      level.mugger_jackpot_tags_unspawned--;
      var_4 = mugger_tag_temp_spawn(var_0, 0, 400);
      var_4.jackpot_tag = 1;
      level.mugger_jackpot_tags_spawned++;
      thread mugger_jackpot_abort_after_time(level);
      wait 0.1;
      continue;
    }

    wait 0.5;
  }

  level.mugger_jackpot_num_tags = 0;

  while(level.mugger_jackpot_tags_spawned > 0) {
    wait 1;
  }

  mugger_jackpot_cleanup();
}

function mugger_jackpot_cleanup() {
  level notify("jackpot_cleanup");
  mugger_jackpot_pile_notify_cleanup();
  mugger_jackpot_fx_cleanup();
  thread mugger_jackpot_watch();
}

function mugger_jackpot_abort_after_time(var_0) {
  level endon("jackpot_cleanup");
  level notify("jackpot_abort_after_time");
  level endon("jackpot_abort_after_time");
  wait var_0;
  level notify("jackpot_timeout");
}

function muggercratethink(var_0) {
  self endon("death");
  level notify("airdrop_jackpot_landed", self.origin);
  wait 0.5;
  scripts\cp_mp\killstreaks\airdrop::deletecrateold();
}

function createdropzones() {
  level.mugger_dropzones = [];
  var_0 = undefined;

  if(isDefined(var_0) && var_0.size) {
    var_1 = 0;

    foreach(var_3 in var_0) {
      level.mugger_dropzones[level.script][var_1] = var_3.origin;
      var_1++;
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

function onsuicidedeath(var_0) {
  thread spawndogtags(level, var_0);
  scripts\mp\gametypes\common::oncommonsuicidedeath(var_0);
}