/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\teamrevive.gsc
***********************************************/

function init() {
  level.onteamchangedeath = &onteamchangedeath;
  level.revivetriggers = [];
  level.numlifelimited = scripts\mp\utility\game::getgametypenumlives();
  level.numrevives = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_numRevives", 0);
  level.loadoutdefaultfiresalediscount = 1;
  thread onplayerconnect();
}

function onplayerconnect() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0.numrevives = level.numrevives;
  }
}

function onteamchangedeath(var_0) {
  if(var_0.team != "spectator") {
    thread spawnrevivetrigger(level, var_0, var_0, "new_trigger_spawned");
    return;
  }
}

function updaterevivetriggerspawnposition() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    if(scripts\mp\flags::gameflag("infil_will_run")) {
      level scripts\engine\utility::ref_143a6("prematch_done", "start_mode_setup", "infil_started");
      var_0 = int(max(level.prematchperiodend - 5, 5));
      wait var_0;
    } else {
      level scripts\engine\utility::ref_143a6("prematch_done", "start_mode_setup", "match_start_real_countdown");
    }
  }

  while(scripts\mp\utility\player::isreallyalive(self)) {
    if(isvalidrevivetriggerspawnposition()) {
      ref_13285();
    }

    waitframe();
  }
}

function ref_13285() {
  var_0 = self.origin;

  if(isbot(self)) {
    var_1 = self getnearestnode();

    if(!isDefined(var_1)) {
      var_0 = self.origin;
    } else {
      var_0 = var_1.origin;
    }
  } else {
    var_1 = self getnearestnode();

    if(!isDefined(var_1)) {
      var_1 = self.origin;
    } else {
      var_1 = var_1.origin;
    }
  }

  if(!isDefined(self.revivepos)) {
    self.prevrevivepos = var_1;
  } else {
    self.prevrevivepos = self.revivepos;
  }

  self.revivepos = var_1;
  self.revivetriggerspawnposition = var_1;
  self.nearestrevivenodepos = var_1;
}

function isvalidrevivetriggerspawnposition() {
  var_0 = self.origin + (0, 0, 3);

  if(canspawn(var_0) && self isonground() && !scripts\mp\utility\entity::touchingoobtrigger()) {
    return 1;
  }

  return 0;
}

function spawnrevivetrigger(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_4 = var_0.origin;
  var_0.pers["useNVG"] = 0;

  if(var_0 isnightvisionon()) {
    var_0.pers["useNVG"] = 1;
  }

  var_5 = 1;

  if(istrue(level.numlifelimited)) {
    waitframe();
    var_5 = !scripts\mp\utility\player::isreallyalive(var_0) && !istrue(var_0.inlaststand);

    if(var_5) {
      var_5 = var_5 && !var_0 scripts\mp\playerlogic::mayspawn();
    }
  }

  var_6 = level.laststandtimer;

  if(var_6 != 0) {
    var_0.timeuntilbleedout = var_6;
  }

  if(var_0 scripts\mp\utility\player::isusingremote()) {
    var_0.revivetriggerblockedinremote = 1;
    var_0 waittill("stopped_using_remote");
    var_0.revivetriggeravailable = 1;
  } else {
    var_0.revivetriggeravailable = 1;
    wait 3;
  }

  if(istrue(var_0.timeuntilbleedout)) {
    thread revivetimeoutthink(var_0);
  }

  if(!var_5) {
    return;
  }

  if(isagent(var_0) || !isDefined(var_0)) {
    return;
  } else {
    if(!isDefined(var_0.revive_chosenclass)) {
      var_0.revive_chosenclass = var_0.class;
    }

    var_7 = var_0 scripts\mp\class::loadout_getorbuildclassstruct(var_0.revive_chosenclass);
    var_8 = var_0 scripts\mp\playerlogic::getplayerassets(var_7);
    var_0 scripts\mp\playerlogic::loadplayerassets([var_8], 1);
  }

  if(isDefined(var_1) && isagent(var_1)) {
    var_1 = var_1.owner;
  }

  GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)), var_6);
}

function makereviveteamusable(var_0, var_1) {
  self makeusable();
  thread _updatereviveteamusable(var_0, var_1);
}

function _updatereviveteamusable(var_0, var_1) {
  self notify("start_team_trigger");
  self endon("start_team_trigger");
  self endon("death");

  for(;;) {
    foreach(var_3 in level.players) {
      if(!var_1) {
        var_3.numrevives = 1;
      }

      if(var_3.team == var_0 && var_3.numrevives && !istrue(var_3 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon"))) {
        self enableplayeruse(var_3);
      } else {
        self disableplayeruse(var_3);
      }

      if(istrue(var_3 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon"))) {
        var_3.hiddenreviveents[self getentitynumber()] = self;
      }
    }

    level waittill("joined_team");
  }
}

function _updatereviveplayerusable(var_0) {
  self endon("death");

  foreach(var_2 in level.players) {
    if(var_2 != var_0) {
      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }
  }
}

function revivetimeoutthink(var_0) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("trigger_removed");
  level endon("game_ended");
  self endon("team_eliminated");
  var_1 = level.revivetriggers[self.guid];
  level waittill("new_trigger_spawned", var_1);
  var_2 = var_0;

  for(;;) {
    waitframe();
    var_3 = var_0;

    if(!istrue(scripts\mp\utility\player::registerpuzzleinteractions())) {
      var_0 -= level.framedurationseconds;
      self.timelefttospawnaction = var_0;
      self setclientomnvar("ui_securing_progress", min(var_0 / var_3, 0.01));
      self setclientomnvar("ui_securing", 0);
    }

    if(level.teamdata[self.team]["aliveCount"] > 0) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(5, int(gettime() + var_0 * 1000));
    }

    if(istrue(self.eliminated)) {
      thread removetrigger(self.guid, 1);
      self notify("trigger_removed");
      return;
    }

    if(var_0 <= level.framedurationseconds) {
      self notify("last_stand_bleedout");
      thread removetrigger(self.guid, 1, 1);

      if(scripts\mp\utility\game::getgametype() == "arm") {
        scripts\mp\utility\lower_message::setlowermessageomnvar(18);
      } else {
        scripts\mp\utility\lower_message::setlowermessageomnvar(2);
        thread scripts\mp\playerlogic::removespawnmessageshortly(3);
      }

      self notify("trigger_removed");
      break;
    }

    if(istrue(self.beingrallyrespawned)) {
      thread removetrigger(self.guid, 1);
      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      self notify("trigger_removed");
      break;
    }
  }
}

function removetrigger(var_0, var_1, var_2) {
  self.revivetriggeravailable = undefined;

  if(isDefined(level.revivetriggers[var_0])) {
    if(isDefined(level.revivetriggers[var_0].enemytrigger)) {
      removetriggerobject(level.revivetriggers[var_0].enemytrigger, self);
    }

    removetriggerobject(level.revivetriggers[var_0], self);
    waitframe();

    if(isDefined(level.revivetriggers[var_0].enemytrigger)) {
      removeuseobject(level.revivetriggers[var_0].enemytrigger);
      level.revivetriggers[var_0].enemytrigger = undefined;
    }

    if(isDefined(level.revivetriggers[var_0])) {
      removeuseobject(level.revivetriggers[var_0]);
    }

    level.revivetriggers[var_0] = undefined;

    if(isDefined(var_2)) {
      self.forcespawnorigin = undefined;
      self.forcespawnangles = undefined;
      return;
    }

    return;
  }
}

function removetriggerobject(var_0) {
  self notify("disabled");

  if(isDefined(self.deathicon)) {
    if(isDefined(var_0.lastheadicondeathent)) {
      var_0.lastheadicondeathent delete();
    }

    self.deathicon = undefined;
  }

  scripts\mp\gameobjects::allowuse("none");
  self notify("reset");
}

function removeuseobject() {
  self notify("death");

  for(var_0 = 0; var_0 < self.visuals.size; var_0++) {
    if(isDefined(self.visuals[var_0])) {
      self.visuals[var_0] delete();
    }
  }

  if(!isDefined(self.skipminimapids)) {
    thread scripts\mp\gameobjects::deleteuseobject();
    return;
  }
}

function relocatetrigger(var_0) {
  var_1 = var_0 + (0, 0, 5);
  var_2 = level.revivetriggers[self.guid].trigger;
  var_2.destination = var_1;
  var_2.curorigin = var_1;
  var_2.origin = var_1;
  level.revivetriggers[self.guid].visuals[0].origin = var_1;
  self.forcespawnorigin = var_1;
  self.lastheadicondeathent.origin = var_1;
}

function revivetriggerteamupdater(var_0) {
  level endon("game_ended");
  self endon("trigger_removed");
  var_0 endon("death");

  for(;;) {
    scripts\engine\utility::ref_143a5("disconnect", "joined_team");
    thread removetrigger(self.guid, 1, 1);
  }
}

function revivetriggerspectateteamupdater(var_0) {
  level endon("game_ended");
  self endon("trigger_removed");
  var_0 endon("death");

  for(;;) {
    self waittill("joined_spectators");

    if(self.team == "spectator") {
      thread removetrigger(self.guid, 1, 1);
    }
  }
}

function onrevivepickupevent(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  var_2 = scripts\mp\rank::getscoreinfovalue(var_0);

  if(istrue(var_1.suicidespawndelay)) {
    var_2 = 0;
  }

  thread scripts\mp\utility\points::giveunifiedpoints(var_0, undefined, var_2);
}

function lifelimitedallyonuse(var_0) {
  if(istrue(level.numrevives)) {
    var_0.numrevives--;
  }

  if(isDefined(var_0.pers["rescues"])) {
    var_0.pers["rescues"]++;
    var_0 scripts\mp\persistence::statsetchild("round", "rescues", var_0.pers["rescues"]);

    switch (scripts\mp\utility\game::getgametype()) {
      case "cyber":
      case "siege":
      case "sr":
        var_0 scripts\mp\utility\stats::setextrascore1(var_0.pers["rescues"]);
        break;
    }
  }

  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, self.victim);
}

function lifelimitedenemyonuse(var_0) {
  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("sr_eliminated");
    level notify("sr_player_eliminated", self.victim);
  }

  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, self.victim);
}

function respawn() {
  self.alreadyaddedtoalivecount = 1;
  scripts\mp\playerlogic::incrementalivecount(self.team, 1, "teamrevive");
  thread scripts\mp\playerlogic::waittillcanspawnclient(1);
}

function revivetriggerholdonuse(var_0) {
  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
  }

  if(var_0.pers["team"] == self.victimteam) {
    if(isDefined(self.victim.body)) {
      self.victim.body delete();
    }

    var_0 scripts\mp\utility\stats::incpersstat("denied", 1);
    var_0 scripts\mp\persistence::statsetchild("round", "denied", var_0.pers["denied"]);

    if(istrue(level.numlifelimited)) {
      lifelimitedallyonuse(var_0);
    }
  } else if(level.numlifelimited) {
    lifelimitedenemyonuse(var_0);
    var_0 scripts\mp\utility\lower_message::setlowermessageomnvar(2);
  }

  var_0 setclientomnvar("ui_securing", 0);
  var_0 setclientomnvar("ui_securing_progress", 0.01);
  var_0.ui_securing = undefined;
  self.victim notify("trigger_removed");
  thread removetrigger(self.victim);
}

function revivetriggerholdonusebegin(var_0, var_1) {
  var_2 = self.trigger.owner;
  var_2 scripts\mp\utility\player::ref_1312b(1);

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_medic")) {
    var_3 = level.revivetriggers[var_2.guid].defaultusetime;
    level.revivetriggers[var_2.guid] scripts\mp\gameobjects::setusetime(var_3 * getdvarfloat("perk_medicReviveSpeedRatio"));
  }

  thread _updatereviveplayerusable(self.trigger);
  var_2.reviver = var_0;
  var_2 scripts\mp\utility\player::ref_1312b(1);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var_0, "reviving");

  if(!istrue(var_1)) {
    thread allowedwhilereviving(var_0);
  }

  var_2 scripts\mp\utility\player::ref_12898("teamrevive::reviveTriggerHoldOnUseBegin() Killcam SKIPPED");
  var_2 notify("abort_killcam");
  var_2.cancelkillcam = 1;
  var_2 scripts\mp\utility\player::_freezecontrols(1, undefined, "teamRevive");
  var_4 = var_0 getEye();
  var_5 = getrevivecameradata(var_2, var_0);
  var_6 = var_5.origin;
  var_7 = var_5.angles;
  var_2.forcespawnangles = (0, var_7[1], 0);
  waitframe();
  var_2 scripts\mp\utility\player::updatesessionstate("spectator");
  var_2 scripts\mp\spectating::setdisabled();
  waitframe();

  if(isDefined(level.revivetriggers[var_2.guid].headicondeath)) {
    if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      var_8 = "hud_realism_head_reviving";
    } else {
      var_8 = "hud_icon_cyber_reviving";
    }

    setheadiconenemyimage(level.revivetriggers[var_4.guid].headicondeath, var_8);
  }

  var_9 = spawn("script_model", var_7);
  var_9 setModel("tag_origin");
  var_9.angles = var_8;
  var_4.revivecameraent = var_9;
  var_4 cameralinkTo(var_9, "tag_origin", 1);
  thread revivecamerapullin();

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    thread applynvgforrevive();
  }

  thread runslamzoomonspawn();
}

function getrevivecameradata(var_0, var_1) {
  var_2 = level.revivetriggers[var_0.guid].curorigin;
  var_3 = var_2;
  var_4 = vectorNormalize(var_1.origin - var_3);
  var_5 = 2;
  var_6 = 30;
  var_7 = 360 / var_6;
  var_8 = 1;
  var_9 = 1;
  var_10 = 100;
  var_11 = generateaxisanglesfromforwardvector(var_4, (0, 0, 1));
  var_12 = 0;
  var_13 = undefined;
  var_14 = 0;
  var_15 = var_3;
  var_16 = var_11;

  while(var_8 < var_7) {
    if(var_12) {
      var_12 = 0;
      var_13 = anglesToForward(var_11);
    } else {
      var_13 = anglesToForward(var_11 + (0, scripts\engine\utility::ter_op(var_9, var_6, var_6 * -1) * var_8, 0));
      var_9 = !var_9;

      if(var_9 == 1) {
        var_8++;
      }
    }

    var_17 = var_3 + (0, 0, 12);
    var_18 = var_3 + var_13 * var_10 + (0, 0, 100);
    var_19 = scripts\engine\trace::sphere_trace(var_17, var_18, var_5, [var_1]);
    var_20 = 30;
    var_21 = var_19["position"];
    var_22 = 0;

    if(var_19["fraction"] < 1) {
      var_21 += var_13 * var_5;
      var_22 = 1;
    }

    if(var_19["fraction"] > 0.99) {
      var_15 = var_21;
      var_16 = vectortoangles(var_13);
      break;
    }
  }

  var_23 = spawnStruct();
  var_23.origin = var_15;
  var_24 = vectorNormalize(var_3 - var_15);
  var_23.angles = vectortoangles(var_24);
  return var_23;
}

function revivecamerapullin(var_0) {
  var_1 = self.revivecameraent.origin + anglesToForward(self.revivecameraent.angles) * 3;
  var_2 = self.revivecameraent.origin + anglesToForward(self.revivecameraent.angles) * 50;
  var_3 = scripts\engine\trace::sphere_trace(var_1, var_2, 2, undefined)["position"];
  var_4 = level.revivetriggers[self.guid].usetime / 1000;
  self.revivecameraent moveTo(var_3, var_4, var_4 * 0.3, var_4 * 0.3);
}

function applynvgforrevive() {
  self notify("stopNVGOnRevive");
  self endon("stopNVGOnRevive");
  wait 1;
  self nightvisionviewon(1);
}

function deleteonspawn(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  var_0 delete();
}

function allowedwhilereviving(var_0) {
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_jump(var_0);
  scripts\mp\utility\player::allow_gesture(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
}

function movecameratorevivepos(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = 1;
  self moveTo(var_0, 1, 0.5, 0.5);
  var_1 = (-9.5111, var_2.angles[1], 0);
  self rotateTo(var_1, 1, 0.5, 0.5);
}

function revivetriggerholdonuseend(var_0, var_1, var_2, var_3) {
  if(isDefined(self.trigger.owner)) {
    var_4 = self.trigger.owner;
    var_5 = level.revivetriggers[var_4.guid].defaultusetime;
    level.revivetriggers[var_4.guid] scripts\mp\gameobjects::setusetime(var_5);
    var_4 scripts\mp\utility\player::ref_1312b(0);

    if(var_2) {
      if(!isDefined(var_4.revivecount)) {
        var_4.revivecount = 1;
      } else {
        var_4.revivecount++;
      }

      var_6 = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveHealth");
      scripts\mp\analyticslog::logevent_playerhealed(var_4, var_6, var_1);
      var_4 setclientomnvar("ui_reviver_id", -1);
      var_4 setclientomnvar("ui_securing", 0);
    } else {
      thread _updatereviveteamusable(self.trigger, var_4.team);

      if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
        var_7 = "hud_realism_head_revive";
      } else {
        var_7 = "hud_icon_cyber_revive";
      }

      if(isDefined(level.revivetriggers[var_5.guid].headicondeath)) {
        setheadiconenemyimage(level.revivetriggers[var_5.guid].headicondeath, var_7);
      }

      var_5 scripts\mp\utility\player::_freezecontrols(0, undefined, "teamRevive");
      var_5 scripts\mp\utility\player::updatesessionstate("spectator");
      var_5 cameraunlink();
      var_5.revivecameraent delete();

      if(isDefined(var_5.team) && var_5.team != "spectator") {
        var_5 allowspectateteam(var_5.team, 1);

        foreach(var_9 in level.teamnamelist) {
          if(var_9 != var_5.team) {
            var_5 allowspectateteam(var_9, 0);
          }
        }

        var_5 spectateclientnum(var_2 getentitynumber());
      }
    }
  }

  if(!istrue(var_4)) {
    thread allowedwhilereviving(var_2);
  }

  if(isPlayer(var_2)) {
    var_2 setclientomnvar("ui_securing", 0);
    var_2 setclientomnvar("ui_securing_progress", 0.01);
    var_2.ui_securing = undefined;
  }

  if(var_3) {
    var_2 scripts\mp\utility\stats::incpersstat("revives", 1);

    if(istrue(var_2.laststanding)) {
      var_2 scripts\mp\utility\stats::incpersstat("clutchRevives", 1);
      return;
    }

    return;
  }
}

function revivetriggeroncantuse(var_0) {
  var_0 scripts\mp\hud_message::showerrormessage("MP/PLAYER_ALREADY_BEING_REVIVED");
}

function addtriggerdeathicon(var_0, var_1, var_2) {
  if(!level.teambased) {
    return;
  }

  var_3 = var_0.visuals[0].origin;
  var_1 endon("spawned_player");
  var_1 endon("disconnect");
  wait 0.05;
  scripts\mp\utility\script::waittillslowprocessallowed();

  if(getDvar("ui_hud_showdeathicons") == "0") {
    return;
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.lastheadicondeath);

  if(isDefined(self.lastheadicondeathent)) {
    self.lastheadicondeathent delete();
  }

  self notify("revived_death_icon");

  if(!isDefined(var_2) || var_2 == "spectator") {
    return;
  }

  self.lastheadicondeathent = spawn("script_model", var_3);
  self.lastheadicondeathent setModel("tag_origin");
  self.lastheadicondeathent.team = var_2;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled() || level.hardcoremode) {
    var_4 = 0;
    var_5 = 500;
    var_6 = 100;
    var_7 = "hud_realism_head_revive";
  } else {
    var_4 = 1;
    var_5 = 8000;
    var_6 = 100;
    var_7 = "hud_icon_cyber_revive";
  }

  var_4.headicondeath = self.lastheadicondeathent thread scripts\cp_mp\entityheadicons::setheadicon_multiimage(var_6, var_7, undefined, undefined, 0, var_4, var_5, var_6);

  if(level.showenemydeathloc) {
    setheadiconneutralimage(var_4.headicondeath, "hud_icon_death_hunter_spawn");

    foreach(var_9 in level.teamnamelist) {
      removeclientfromheadiconmask(var_4.headicondeath, var_9);
    }

    return;
  }
}

function runslamzoomonspawn() {
  self notify("end_spawn_zoom");
  self endon("end_spawn_zoom");
  level endon("game_ended");
  self waittill("spawned_player");
  var_0 = self getEye();
  var_1 = self.angles;
  self cameralinkTo(self.revivecameraent, "tag_origin", 1);
  self.revivecameraent moveTo(var_0, 0.25, 0.1, 0.1);
  self.revivecameraent rotateTo(var_1, 0.25, 0.1, 0.1);
  wait 0.25;
  self visionsetnakedforplayer("", 0.1);
  self cameraunlink();
  self.revivecameraent delete();
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "revived");
}

function playslamzoomflash() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0.foreground = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0;
  wait 0.4;
  var_0 destroy();
}

function cleanuprevivetriggericons() {
  foreach(var_1 in level.revivetriggers) {
    var_1 scripts\mp\gameobjects::allowuse("none");
    var_1 notify("reset");
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_1.lastheadicondeath);

    if(isDefined(var_1.lastheadicondeathent)) {
      var_1.lastheadicondeathent delete();
    }
  }
}

function updatetimerwaitforjoined() {}

function assigntimervisibleteam(var_0) {
  self.interactteams = var_0;

  foreach(var_2 in level.players) {
    applytimervisibleteam(var_2);
  }
}

function applytimervisibleteam(var_0) {
  if(var_0.team == self.ownerteam) {
    self.visuals[0] showtoplayer(var_0);
    return;
  }

  self.visuals[0] hidefromplayer(var_0);
}

function waitrespawnbutton() {
  self endon("disconnect");
  self endon("started_spawnPlayer");
  self endon("team_eliminated");
  var_0 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      while(self useButtonPressed()) {
        var_0 += 0.05;

        if(var_0 >= 1) {
          break;
        }

        wait 0.05;
      }

      if(var_0 >= 0.5) {
        var_0 += 0.05;
      }
    }

    var_0 = 0;
    wait 0.05;
  }
}