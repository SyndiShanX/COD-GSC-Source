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

  foreach(var1 in level.teamnamelist) {
    scripts\mp\utility\game::setobjectivetext(var1, &"OBJECTIVES/MUGGER");

    if(level.splitscreen) {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/MUGGER");
    } else {
      scripts\mp\utility\game::setobjectivescoretext(var1, &"OBJECTIVES/MUGGER_SCORE");
    }

    scripts\mp\utility\game::setobjectivehinttext(var1, &"OBJECTIVES/MUGGER_HINT");
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

function onplayerconnect(var0) {
  var0.tags_carried = 0;
  var0.total_tags_banked = 0;
  var0.assists = var0.total_tags_banked;
  var0.pers["assists"] = var0.total_tags_banked;
  var0.game_extrainfo = var0.tags_carried;
  var0.muggings = [];

  if(isPlayer(var0) && !isbot(var0)) {
    var0.dogtagsicon = var0 scripts\mp\hud_util::createicon("hud_tagcount", 48, 48);
    var0.dogtagsicon scripts\mp\hud_util::setpoint("TOP LEFT", "TOP LEFT", 200, 0);
    var0.dogtagsicon.alpha = 1;
    var0.dogtagsicon.hidewheninmenu = 1;
    var0.dogtagsicon.archived = 1;
    thread hidehudelementongameend(level);
    var0.dogtagstext = var0 scripts\mp\hud_util::createfontstring("bigfixed", 1);
    var0.dogtagstext scripts\mp\hud_util::setparent(var0.dogtagsicon);
    var0.dogtagstext scripts\mp\hud_util::setpoint("CENTER", "CENTER", -24);
    var0.dogtagstext setvalue(var0.tags_carried);
    var0.dogtagstext.alpha = 1;
    var0.dogtagstext.color = (1, 1, 0.5);
    var0.dogtagstext.glowalpha = 1;
    var0.dogtagstext.sort = 1;
    var0.dogtagstext.hidewheninmenu = 1;
    var0.dogtagstext.archived = 1;
    var0.dogtagstext scripts\mp\hud::fontpulseinit(3);
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

function hidehudelementongameend(var0) {
  level waittill("game_ended");

  if(isDefined(var0)) {
    var0.alpha = 0;
    return;
  }
}

function getspawnpoint() {
  var0 = scripts\mp\spawnlogic::getspawnpoint(self, "none", "normal", "fallback");
  return var0;
}

function onxpevent(var0) {}

function onnormaldeath(var0, var1, var2, var3, var4, var5) {
  scripts\mp\gametypes\common::onnormaldeath(var0, var1, var2, var3, var4, var5);
  thread spawndogtags(level, var0);
}

function mugger_init_tags() {
  level.mugger_max_extra_tags = getdvarint("scr_mugger_max_extra_tags", 50);
  level.mugger_extra_tags = [];
}

function spawndogtags(var0, var1) {
  if(isagent(var1)) {
    var1 = var1.owner;
  }

  var2 = 0;
  var3 = 0;

  if(isDefined(var1)) {
    if(var0 == var1) {
      if(var0.tags_carried > 0) {
        var2 = var0.tags_carried;
        var0.tags_carried = 0;
        var0.game_extrainfo = 0;

        if(isPlayer(var0) && !isbot(var0)) {
          var0.dogtagstext setvalue(var0.tags_carried);
          var0.dogtagstext thread scripts\mp\hud::fontpulse(var0);
          var0 thread scripts\mp\hud_message::showsplash("mugger_suicide", var2);
        }
      }
    } else if(isDefined(var0.attackerdata) && var0.attackerdata.size > 0) {
      if(isPlayer(var1) && isDefined(var0.attackerdata) && isDefined(var1.guid) && isDefined(var0.attackerdata[var1.guid])) {
        var4 = var0.attackerdata[var1.guid];

        if(isDefined(var4) && isDefined(var4.attackerent) && var4.attackerent == var1) {
          if(isDefined(var4.smeansofdeath) && (var4.smeansofdeath == "MOD_MELEE" || var4.weapon == "throwingknife_mp" && level.mugger_throwing_knife_mug_frac > 0)) {
            var3 = 1;

            if(var0.tags_carried > 0) {
              var2 = var0.tags_carried;

              if(var4.weapon == "throwingknife_mp" && level.mugger_throwing_knife_mug_frac < 1) {
                var2 = int(ceil(var0.tags_carried * level.mugger_throwing_knife_mug_frac));
              }

              var0.tags_carried -= var2;
              var0.game_extrainfo = var0.tags_carried;

              if(isPlayer(var0) && !isbot(var0)) {
                var0.dogtagstext setvalue(var0.tags_carried);
                var0.dogtagstext thread scripts\mp\hud::fontpulse(var0);
                var0 thread scripts\mp\hud_message::showsplash("callout_mugged", var2);
                var0 playlocalsound("mugger_got_mugged");
              }

              playsoundatpos(var0.origin, "mugger_mugging");
              var1 thread scripts\mp\hud_message::showsplash("callout_mugger", var2);

              if(var4.weapon == "throwingknife_mp") {
                var1 playlocalsound("mugger_you_mugged");
              }
            }

            var1.muggings[var1.muggings.size] = gettime();
            thread mugger_check_muggernaut();
          }
        }
      }
    }
  }

  if(isagent(var0)) {
    var5 = var0.origin + (0, 0, 14);
    playsoundatpos(var5, "mp_killconfirm_tags_drop");
    level notify("mugger_jackpot_increment");
    var6 = mugger_tag_temp_spawn(var0.origin, 40, 160);
    var6.victim = var0.owner;

    if(isDefined(var1) && var0 != var1) {
      var6.attacker = var1;
      return;
    }

    var6.attacker = undefined;
    return;
  } else if(isDefined(level.dogtags[var2.guid])) {
    playFX(level.mugger_fx["vanish"], level.dogtags[var2.guid].curorigin);
    level.dogtags[var2.guid] notify("reset");
  } else {
    GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)), var1);
  }

  var5 = var2.origin + (0, 0, 14);
  level.dogtags[var2.guid].curorigin = var5;
  level.dogtags[var2.guid].trigger.origin = var5;
  level.dogtags[var2.guid].visuals[0].origin = var5;
  level.dogtags[var2.guid] scripts\mp\gameobjects::initializetagpathvariables();
  level.dogtags[var2.guid] scripts\mp\gameobjects::allowuse("any");
  level.dogtags[var2.guid].visuals[0] show();

  if(isDefined(var3) && var2 != var3) {
    level.dogtags[var2.guid].attacker = var3;
  } else {
    level.dogtags[var2.guid].attacker = undefined;
  }

  thread timeout();

  if(var5 < 5) {
    scripts\mp\objidpoolmanager::update_objective_position(level.dogtags[var2.guid].objid, var5);
    scripts\mp\objidpoolmanager::update_objective_state(level.dogtags[var2.guid].objid, "active");
  } else {
    mugger_tag_pile_notify(var5, "mugger_megadrop", var5, var2, var3);
  }

  playsoundatpos(var5, "mp_killconfirm_tags_drop");
  level.dogtags[var2.guid].temp_tag = 0;

  if(var5 == 0) {
    level notify("mugger_jackpot_increment");
  }

  for(var9 = 0; var9 < var5; var9++) {
    var6 = mugger_tag_temp_spawn(var2.origin, 40, 160);
    var6.victim = var2;

    if(isDefined(var3) && var2 != var3) {
      var6.attacker = var3;
      continue;
    }

    var6.attacker = undefined;
  }
}

function mugger_tag_pickup_wait() {
  level endon("game_ended");
  self endon("reset");
  self endon("reused");
  self endon("deleted");

  for(;;) {
    self.trigger waittill("trigger", var0);

    if(!scripts\mp\utility\player::isreallyalive(var0)) {
      continue;
    }

    if(var0 scripts\mp\utility\player::isusingremote() || isDefined(var0.spawningafterremotedeath)) {
      continue;
    }

    if(isDefined(var0.classname) && var0.classname == "script_vehicle") {
      continue;
    }

    thread onuse(var0);
    return;
  }
}

function mugger_add_extra_tag(var0) {
  GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)));
}

function mugger_first_unused_or_oldest_extra_tag() {
  var0 = undefined;
  var1 = -1;

  foreach(var3 in level.mugger_extra_tags) {
    if(var3.interactteam == "none") {
      var3.last_used_time = gettime();
      var3.visuals[0] show();
      return var3;
    }

    if(!isDefined(var0) || var3.last_used_time < var1) {
      var1 = var3.last_used_time;
      var0 = var3;
    }
  }

  if(level.mugger_extra_tags.size < level.mugger_max_extra_tags) {
    var5 = mugger_add_extra_tag(level.mugger_extra_tags.size);

    if(isDefined(var5)) {
      var5.last_used_time = gettime();
      return var5;
    }
  }

  var0.last_used_time = gettime();
  var0 notify("reused");
  playFX(level.mugger_fx["vanish"], var0.curorigin);
  return var0;
}

function mugger_tag_temp_spawn(var0, var1, var2) {
  var3 = mugger_first_unused_or_oldest_extra_tag();
  var4 = var0 + (0, 0, 14);
  var5 = (0, randomfloat(360), 0);
  var6 = anglesToForward(var5);
  var7 = randomfloatrange(40, 160);
  var8 = var4 + var7 * var6;
  var8 += (0, 0, 40);
  var9 = playerphysicstrace(var4, var8);
  var4 = var9;
  var8 = var4 + (0, 0, -100);
  var9 = playerphysicstrace(var4, var8);

  if(var9[2] != var8[2]) {
    var9 += (0, 0, 14);
  }

  var3.curorigin = var9;
  var3.trigger.origin = var9;
  var3.visuals[0].origin = var9;
  var3 scripts\mp\gameobjects::initializetagpathvariables();
  var3 scripts\mp\gameobjects::allowuse("any");
  thread mugger_tag_pickup_wait();
  thread timeout();
  return var3;
}

function mugger_tag_pile_notify(var0, var1, var2, var3, var4) {
  level notify("mugger_tag_pile", var0);
  var5 = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(var5 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var5, "active", var0);
    scripts\mp\objidpoolmanager::update_objective_icon(var5, "waypoint_dogtag_pile");
  }

  level scripts\engine\utility::delaythread(5, &mugger_pile_icon_remove, var5);

  if(var2 >= 10) {
    level.mugger_last_mega_drop = gettime();
    level.mugger_jackpot_num_tags = 0;

    foreach(var7 in level.players) {
      var7 playsoundtoplayer("mp_defcon_one", var7);

      if(isDefined(var3) && var7 == var3) {
        continue;
      }

      if(isDefined(var4) && var7 == var4) {
        continue;
      }

      var7 thread scripts\mp\hud_message::showsplash(var1, var2);
    }

    var9 = newhudelem();
    var9 setshader("waypoint_dogtag_pile", 10, 10);
    var9 setwaypoint(0, 1, 0, 0);
    var9.x = var0[0];
    var9.y = var0[1];
    var9.z = var0[2] + 32;
    var9.alpha = 1;
    var9 fadeovertime(5);
    var9.alpha = 0;
    var9 scripts\engine\utility::delaythread(5, &hudelemdestroy);
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
    var0 = getEntArray("remote_tank", "targetname");
    var1 = getEntArray("trigger_dogtag", "targetname");

    foreach(var3 in level.players) {
      if(isDefined(var3.using_remote_tank) && var3.using_remote_tank == 1) {
        foreach(var5 in var0) {
          if(isDefined(var5) && isDefined(var5.owner) && var5.owner == var3) {
            foreach(var7 in var1) {
              if(isDefined(var7) && isDefined(var7.dogtag)) {
                if(isDefined(var7.dogtag.interactteam) && var7.dogtag.interactteam != "none") {
                  if(var5 istouching(var7)) {
                    onuse(var7.dogtag, var5.owner);
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
    var0 = getEntArray("trigger_dogtag", "targetname");

    foreach(var2 in level.players) {
      if(isDefined(var2) && isDefined(var2.remoteuav)) {
        foreach(var4 in var0) {
          if(isDefined(var4) && isDefined(var4.dogtag)) {
            if(isDefined(var4.dogtag.interactteam) && var4.dogtag.interactteam != "none") {
              if(var2.remoteuav istouching(var4)) {
                onuse(var4.dogtag, var2);
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

  var0 = self.muggings[self.muggings.size - 1];
  var1 = var0 - level.mugger_muggernaut_window;
  var2 = [];

  foreach(var4 in self.muggings) {
    if(var4 >= var1) {
      var2 = var4;
    }
  }

  if(var2.size >= level.mugger_muggernaut_muggings_needed) {
    thread scripts\mp\utility\points::giveunifiedpoints("muggernaut");
    mugger_bank_tags(1, 1);
    self.muggings = [];
    return;
  }

  self.muggings = var2;
}

function mugger_pile_icon_remove(var0) {
  scripts\mp\objidpoolmanager::returnobjectiveid(var0);
}

function _hidefromplayer(var0) {
  self hide();

  foreach(var2 in level.players) {
    if(var2 != var0) {
      self showtoplayer(var2);
    }
  }
}

function onuse(var0) {
  if(isDefined(var0.owner)) {
    var0 = var0.owner;
  }

  if(self.temp_tag) {
    self.trigger playSound("mp_killconfirm_tags_deny");
  } else if(isDefined(self.attacker) && var0 == self.attacker) {
    self.trigger playSound("mp_killconfirm_tags_pickup");
    var0 scripts\mp\utility\stats::incpersstat("confirmed", 1);
    var0 scripts\mp\persistence::statsetchild("round", "confirmed", var0.pers["confirmed"]);
  } else {
    self.trigger playSound("mp_killconfirm_tags_deny");
    var0 scripts\mp\utility\stats::incpersstat("denied", 1);
    var0 scripts\mp\persistence::statsetchild("round", "denied", var0.pers["denied"]);
  }

  thread onpickup();
  resettags(1);
}

function onpickup(var0, var1, var2) {
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
  var0 = level.mugger_bank_limit - self.tags_carried;

  if(var0 > 0 && var0 <= 5) {
    var1 = undefined;

    switch (var0) {
      case 1:
        var1 = "mugger_1more";
        break;
      case 2:
        var1 = "mugger_2more";
        break;
      case 3:
        var1 = "mugger_3more";
        break;
      case 4:
        var1 = "mugger_4more";
        break;
      case 5:
        var1 = "mugger_5more";
        break;
    }

    if(isDefined(var1)) {
      self playsoundtoplayer(var1, self);
    }
  }

  wait 0.5;
  mugger_bank_tags(0);
}

function mugger_bank_tags(var0, var1) {
  var2 = 0;

  if(var0 == 1) {
    var2 = self.tags_carried;
  } else {
    var3 = self.tags_carried % level.mugger_bank_limit;
    var2 = self.tags_carried - var3;
  }

  if(var2 > 0) {
    self.tags_to_bank = var2;

    if(!isDefined(var1)) {
      thread scripts\mp\hud_message::showsplash("callout_tags_banked", var2);
    }

    thread scripts\mp\utility\points::giveunifiedpoints("tags_banked", undefined, self.tags_to_bank * scripts\mp\rank::getscoreinfovalue("kill_confirmed"));
    self.total_tags_banked += var2;
    self.tags_carried -= var2;
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

function onplayerscore(var0, var1) {
  if(var0 == "tags_banked" && isDefined(var1) && isDefined(var1.tags_to_bank) && var1.tags_to_bank > 0) {
    var2 = var1.tags_to_bank * scripts\mp\rank::getscoreinfovalue("kill_confirmed");
    var1.tags_to_bank = 0;
    return var2;
  }

  return 0;
}

function resettags(var0) {
  if(!var0) {
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
  var0 = 3;

  while(var0 > 0) {
    self.visuals[0] hide();
    wait 0.25;
    self.visuals[0] show();
    wait 0.25;
    var0 -= 0.5;
  }

  playFX(level.mugger_fx["vanish"], self.curorigin);
  thread resettags(0);
}

function clearonvictimdisconnect(var0) {
  level endon("game_ended");
  var1 = var0.guid;
  var0 waittill("disconnect");

  if(isDefined(level.dogtags[var1])) {
    level.dogtags[var1] scripts\mp\gameobjects::allowuse("none");
    playFX(level.mugger_fx["vanish"], level.dogtags[var1].curorigin);
    level.dogtags[var1] notify("reset");
    waitframe();

    if(isDefined(level.dogtags[var1])) {
      scripts\mp\objidpoolmanager::returnobjectiveid(level.dogtags[var1].objid);
      level.dogtags[var1].trigger delete();

      for(var2 = 0; var2 < level.dogtags[var1].visuals.size; var2++) {
        level.dogtags[var1].visuals[var2] delete();
      }

      level.dogtags[var1] notify("deleted");
      level.dogtags[var1] = undefined;
      return;
    }

    return;
  }
}

function ontimelimit() {
  level notify("banking_all");

  foreach(var1 in level.players) {
    mugger_bank_tags(var1, 1);
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
    var0 = 1;

    if(var0) {
      level.mugger_jackpot_num_tags++;
      var1 = clamp(float(level.mugger_jackpot_num_tags / level.mugger_jackpot_limit), 0, 1);

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
  var0 = level.mugger_dropzones[level.script][randomint(level.mugger_dropzones[level.script].size)];
  var0 += (randomintrange(-50, 50), randomintrange(-50, 50), 0);

  for(;;) {
    var1 = level.players[0];
    var2 = 1;

    if(isDefined(var1) && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level.fauxvehiclecount + var2 < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::getnumdroppedcrates() < 8) {
      foreach(var4 in level.players) {
        var4 thread scripts\mp\hud_message::showsplash("mugger_jackpot_incoming");
      }

      break;
    }

    wait 0.5;
  }

  level.mugger_jackpot_tags_unspawned = level.mugger_jackpot_num_tags;
  thread mugger_jackpot_run(level);
}

function mugger_jackpot_pile_notify(var0, var1, var2) {
  if(!isDefined(level.jackpotpileobjid)) {
    level.jackpotpileobjid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

    if(level.jackpotpileobjid != -1) {
      scripts\mp\objidpoolmanager::objective_add_objective(level.jackpotpileobjid, "active", var0);
      scripts\mp\objidpoolmanager::update_objective_icon(level.jackpotpileobjid, "waypoint_jackpot");
    }
  } else if(level.jackpotpileobjid != -1) {
    scripts\mp\objidpoolmanager::update_objective_position(level.jackpotpileobjid, var0);
  }

  if(var2 >= 10) {
    foreach(var4 in level.players) {
      var4 playlocalsound(game["music"]["victory_" + var4.pers["team"]]);
    }

    if(!isDefined(level.jackpotpileicon)) {
      level.jackpotpileicon = newhudelem();
      level.jackpotpileicon setshader("waypoint_jackpot", 64, 64);
      level.jackpotpileicon setwaypoint(0, 1, 0, 0);
    }

    level.jackpotpileicon.x = var0[0];
    level.jackpotpileicon.y = var0[1];
    level.jackpotpileicon.z = var0[2] + 12;
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

function mugger_jackpot_fx(var0) {
  mugger_jackpot_fx_cleanup();
  var1 = var0 + (0, 0, 30);
  var2 = var0 + (0, 0, -1000);
  var3 = scripts\engine\trace::ray_trace(var1, var2, undefined, scripts\engine\trace::create_default_contents(1));
  level.jackpot_zone.origin = var3["position"] + (0, 0, 1);
  level.jackpot_zone show();
  var4 = vectortoangles(var3["normal"]);
  var5 = anglesToForward(var4);
  var6 = anglestoright(var4);
  thread spawnfxdelay(var3["position"], var5, var6, 0.5);
  wait 0.1;
  playFXOnTag(level.mugger_fx["smoke"], level.jackpot_zone, "tag_fx");

  foreach(var8 in level.players) {
    var8.mugger_fx_playing = 1;
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

function spawnfxdelay(var0, var1, var2, var3) {
  if(isDefined(level.jackpot_targetfx)) {
    level.jackpot_targetfx delete();
  }

  wait var3;
  level.jackpot_targetfx = spawnfx(level.mugger_targetfxid, var0, var1, var2);
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

function mugger_jackpot_run(var0) {
  level endon("game_ended");
  level endon("jackpot_timeout");
  level notify("jackpot_stop");
  mugger_jackpot_pile_notify(var0, "mugger_jackpot", level.mugger_jackpot_tags_unspawned);
  thread mugger_jackpot_fx(level);
  thread mugger_jackpot_abort_after_time(level);
  level waittill("airdrop_jackpot_landed", var0);

  if(level.jackpotpileobjid != -1) {
    scripts\mp\objidpoolmanager::update_objective_position(level.jackpotpileobjid, var0);
  }

  level.jackpotpileicon.x = var0[0];
  level.jackpotpileicon.y = var0[1];
  level.jackpotpileicon.z = var0[2] + 32;

  foreach(var2 in level.players) {
    var2 playsoundtoplayer("mp_defcon_one", var2);
    var2 thread scripts\mp\hud_message::showsplash("mugger_jackpot", level.mugger_jackpot_tags_unspawned);
  }

  level.mugger_jackpot_tags_spawned = 0;

  while(level.mugger_jackpot_tags_unspawned > 0) {
    if(level.mugger_jackpot_tags_spawned < 10) {
      level.mugger_jackpot_tags_unspawned--;
      var4 = mugger_tag_temp_spawn(var0, 0, 400);
      var4.jackpot_tag = 1;
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

function mugger_jackpot_abort_after_time(var0) {
  level endon("jackpot_cleanup");
  level notify("jackpot_abort_after_time");
  level endon("jackpot_abort_after_time");
  wait var0;
  level notify("jackpot_timeout");
}

function muggercratethink(var0) {
  self endon("death");
  level notify("airdrop_jackpot_landed", self.origin);
  wait 0.5;
  scripts\cp_mp\killstreaks\airdrop::deletecrateold();
}

function createdropzones() {
  level.mugger_dropzones = [];
  var0 = undefined;

  if(isDefined(var0) && var0.size) {
    var1 = 0;

    foreach(var3 in var0) {
      level.mugger_dropzones[level.script][var1] = var3.origin;
      var1++;
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

function onsuicidedeath(var0) {
  thread spawndogtags(level, var0);
  scripts\mp\gametypes\common::oncommonsuicidedeath(var0);
}