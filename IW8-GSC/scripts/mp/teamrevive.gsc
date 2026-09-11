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
    level waittill("connected", var0);
    var0.numrevives = level.numrevives;
  }
}

function onteamchangedeath(var0) {
  if(var0.team != "spectator") {
    thread spawnrevivetrigger(level, var0, var0, "new_trigger_spawned");
    return;
  }
}

function updaterevivetriggerspawnposition() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    if(scripts\mp\flags::gameflag("infil_will_run")) {
      level scripts\engine\utility::ref_143a6("prematch_done", "start_mode_setup", "infil_started");
      var0 = int(max(level.prematchperiodend - 5, 5));
      wait var0;
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
  var0 = self.origin;

  if(isbot(self)) {
    var1 = self getnearestnode();

    if(!isDefined(var1)) {
      var0 = self.origin;
    } else {
      var0 = var1.origin;
    }
  } else {
    var1 = self getnearestnode();

    if(!isDefined(var1)) {
      var1 = self.origin;
    } else {
      var1 = var1.origin;
    }
  }

  if(!isDefined(self.revivepos)) {
    self.prevrevivepos = var1;
  } else {
    self.prevrevivepos = self.revivepos;
  }

  self.revivepos = var1;
  self.revivetriggerspawnposition = var1;
  self.nearestrevivenodepos = var1;
}

function isvalidrevivetriggerspawnposition() {
  var0 = self.origin + (0, 0, 3);

  if(canspawn(var0) && self isonground() && !scripts\mp\utility\entity::touchingoobtrigger()) {
    return 1;
  }

  return 0;
}

function spawnrevivetrigger(var0, var1, var2, var3) {
  level endon("game_ended");
  var0 endon("disconnect");
  var4 = var0.origin;
  var0.pers["useNVG"] = 0;

  if(var0 isnightvisionon()) {
    var0.pers["useNVG"] = 1;
  }

  var5 = 1;

  if(istrue(level.numlifelimited)) {
    waitframe();
    var5 = !scripts\mp\utility\player::isreallyalive(var0) && !istrue(var0.inlaststand);

    if(var5) {
      var5 = var5 && !var0 scripts\mp\playerlogic::mayspawn();
    }
  }

  var6 = level.laststandtimer;

  if(var6 != 0) {
    var0.timeuntilbleedout = var6;
  }

  if(var0 scripts\mp\utility\player::isusingremote()) {
    var0.revivetriggerblockedinremote = 1;
    var0 waittill("stopped_using_remote");
    var0.revivetriggeravailable = 1;
  } else {
    var0.revivetriggeravailable = 1;
    wait 3;
  }

  if(istrue(var0.timeuntilbleedout)) {
    thread revivetimeoutthink(var0);
  }

  if(!var5) {
    return;
  }

  if(isagent(var0) || !isDefined(var0)) {
    return;
  } else {
    if(!isDefined(var0.revive_chosenclass)) {
      var0.revive_chosenclass = var0.class;
    }

    var7 = var0 scripts\mp\class::loadout_getorbuildclassstruct(var0.revive_chosenclass);
    var8 = var0 scripts\mp\playerlogic::getplayerassets(var7);
    var0 scripts\mp\playerlogic::loadplayerassets([var8], 1);
  }

  if(isDefined(var1) && isagent(var1)) {
    var1 = var1.owner;
  }

  GscBinSkip1(0x45, 0, spawn("script_model", (0, 0, 0)), var6);
}

function makereviveteamusable(var0, var1) {
  self makeusable();
  thread _updatereviveteamusable(var0, var1);
}

function _updatereviveteamusable(var0, var1) {
  self notify("start_team_trigger");
  self endon("start_team_trigger");
  self endon("death");

  for(;;) {
    foreach(var3 in level.players) {
      if(!var1) {
        var3.numrevives = 1;
      }

      if(var3.team == var0 && var3.numrevives && !istrue(var3 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon"))) {
        self enableplayeruse(var3);
      } else {
        self disableplayeruse(var3);
      }

      if(istrue(var3 scripts\mp\utility\perk::_hasperk("specialty_revive_use_weapon"))) {
        var3.hiddenreviveents[self getentitynumber()] = self;
      }
    }

    level waittill("joined_team");
  }
}

function _updatereviveplayerusable(var0) {
  self endon("death");

  foreach(var2 in level.players) {
    if(var2 != var0) {
      self disableplayeruse(var2);
      self hidefromplayer(var2);
    }
  }
}

function revivetimeoutthink(var0) {
  self endon("death_or_disconnect");
  self endon("last_stand_finished");
  self endon("trigger_removed");
  level endon("game_ended");
  self endon("team_eliminated");
  var1 = level.revivetriggers[self.guid];
  level waittill("new_trigger_spawned", var1);
  var2 = var0;

  for(;;) {
    waitframe();
    var3 = var0;

    if(!istrue(scripts\mp\utility\player::registerpuzzleinteractions())) {
      var0 -= level.framedurationseconds;
      self.timelefttospawnaction = var0;
      self setclientomnvar("ui_securing_progress", min(var0 / var3, 0.01));
      self setclientomnvar("ui_securing", 0);
    }

    if(level.teamdata[self.team]["aliveCount"] > 0) {
      scripts\mp\utility\lower_message::setlowermessageomnvar(5, int(gettime() + var0 * 1000));
    }

    if(istrue(self.eliminated)) {
      thread removetrigger(self.guid, 1);
      self notify("trigger_removed");
      return;
    }

    if(var0 <= level.framedurationseconds) {
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

function removetrigger(var0, var1, var2) {
  self.revivetriggeravailable = undefined;

  if(isDefined(level.revivetriggers[var0])) {
    if(isDefined(level.revivetriggers[var0].enemytrigger)) {
      removetriggerobject(level.revivetriggers[var0].enemytrigger, self);
    }

    removetriggerobject(level.revivetriggers[var0], self);
    waitframe();

    if(isDefined(level.revivetriggers[var0].enemytrigger)) {
      removeuseobject(level.revivetriggers[var0].enemytrigger);
      level.revivetriggers[var0].enemytrigger = undefined;
    }

    if(isDefined(level.revivetriggers[var0])) {
      removeuseobject(level.revivetriggers[var0]);
    }

    level.revivetriggers[var0] = undefined;

    if(isDefined(var2)) {
      self.forcespawnorigin = undefined;
      self.forcespawnangles = undefined;
      return;
    }

    return;
  }
}

function removetriggerobject(var0) {
  self notify("disabled");

  if(isDefined(self.deathicon)) {
    if(isDefined(var0.lastheadicondeathent)) {
      var0.lastheadicondeathent delete();
    }

    self.deathicon = undefined;
  }

  scripts\mp\gameobjects::allowuse("none");
  self notify("reset");
}

function removeuseobject() {
  self notify("death");

  for(var0 = 0; var0 < self.visuals.size; var0++) {
    if(isDefined(self.visuals[var0])) {
      self.visuals[var0] delete();
    }
  }

  if(!isDefined(self.skipminimapids)) {
    thread scripts\mp\gameobjects::deleteuseobject();
    return;
  }
}

function relocatetrigger(var0) {
  var1 = var0 + (0, 0, 5);
  var2 = level.revivetriggers[self.guid].trigger;
  var2.destination = var1;
  var2.curorigin = var1;
  var2.origin = var1;
  level.revivetriggers[self.guid].visuals[0].origin = var1;
  self.forcespawnorigin = var1;
  self.lastheadicondeathent.origin = var1;
}

function revivetriggerteamupdater(var0) {
  level endon("game_ended");
  self endon("trigger_removed");
  var0 endon("death");

  for(;;) {
    scripts\engine\utility::ref_143a5("disconnect", "joined_team");
    thread removetrigger(self.guid, 1, 1);
  }
}

function revivetriggerspectateteamupdater(var0) {
  level endon("game_ended");
  self endon("trigger_removed");
  var0 endon("death");

  for(;;) {
    self waittill("joined_spectators");

    if(self.team == "spectator") {
      thread removetrigger(self.guid, 1, 1);
    }
  }
}

function onrevivepickupevent(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  var2 = scripts\mp\rank::getscoreinfovalue(var0);

  if(istrue(var1.suicidespawndelay)) {
    var2 = 0;
  }

  thread scripts\mp\utility\points::giveunifiedpoints(var0, undefined, var2);
}

function lifelimitedallyonuse(var0) {
  if(istrue(level.numrevives)) {
    var0.numrevives--;
  }

  if(isDefined(var0.pers["rescues"])) {
    var0.pers["rescues"]++;
    var0 scripts\mp\persistence::statsetchild("round", "rescues", var0.pers["rescues"]);

    switch (scripts\mp\utility\game::getgametype()) {
      case "cyber":
      case "siege":
      case "sr":
        var0 scripts\mp\utility\stats::setextrascore1(var0.pers["rescues"]);
        break;
    }
  }

  var1 = [];
  GscBinSkip0(0x2e, var1.size, self.victim);
}

function lifelimitedenemyonuse(var0) {
  if(isDefined(self.victim)) {
    self.victim thread scripts\mp\hud_message::showsplash("sr_eliminated");
    level notify("sr_player_eliminated", self.victim);
  }

  var1 = [];
  GscBinSkip0(0x2e, var1.size, self.victim);
}

function respawn() {
  self.alreadyaddedtoalivecount = 1;
  scripts\mp\playerlogic::incrementalivecount(self.team, 1, "teamrevive");
  thread scripts\mp\playerlogic::waittillcanspawnclient(1);
}

function revivetriggerholdonuse(var0) {
  if(isDefined(var0.owner)) {
    var0 = var0.owner;
  }

  if(var0.pers["team"] == self.victimteam) {
    if(isDefined(self.victim.body)) {
      self.victim.body delete();
    }

    var0 scripts\mp\utility\stats::incpersstat("denied", 1);
    var0 scripts\mp\persistence::statsetchild("round", "denied", var0.pers["denied"]);

    if(istrue(level.numlifelimited)) {
      lifelimitedallyonuse(var0);
    }
  } else if(level.numlifelimited) {
    lifelimitedenemyonuse(var0);
    var0 scripts\mp\utility\lower_message::setlowermessageomnvar(2);
  }

  var0 setclientomnvar("ui_securing", 0);
  var0 setclientomnvar("ui_securing_progress", 0.01);
  var0.ui_securing = undefined;
  self.victim notify("trigger_removed");
  thread removetrigger(self.victim);
}

function revivetriggerholdonusebegin(var0, var1) {
  var2 = self.trigger.owner;
  var2 scripts\mp\utility\player::ref_1312b(1);

  if(var0 scripts\mp\utility\perk::_hasperk("specialty_medic")) {
    var3 = level.revivetriggers[var2.guid].defaultusetime;
    level.revivetriggers[var2.guid] scripts\mp\gameobjects::setusetime(var3 * getdvarfloat("perk_medicReviveSpeedRatio"));
  }

  thread _updatereviveplayerusable(self.trigger);
  var2.reviver = var0;
  var2 scripts\mp\utility\player::ref_1312b(1);
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(var0, "reviving");

  if(!istrue(var1)) {
    thread allowedwhilereviving(var0);
  }

  var2 scripts\mp\utility\player::ref_12898("teamrevive::reviveTriggerHoldOnUseBegin() Killcam SKIPPED");
  var2 notify("abort_killcam");
  var2.cancelkillcam = 1;
  var2 scripts\mp\utility\player::_freezecontrols(1, undefined, "teamRevive");
  var4 = var0 getEye();
  var5 = getrevivecameradata(var2, var0);
  var6 = var5.origin;
  var7 = var5.angles;
  var2.forcespawnangles = (0, var7[1], 0);
  waitframe();
  var2 scripts\mp\utility\player::updatesessionstate("spectator");
  var2 scripts\mp\spectating::setdisabled();
  waitframe();

  if(isDefined(level.revivetriggers[var2.guid].headicondeath)) {
    if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
      var8 = "hud_realism_head_reviving";
    } else {
      var8 = "hud_icon_cyber_reviving";
    }

    setheadiconenemyimage(level.revivetriggers[var4.guid].headicondeath, var8);
  }

  var9 = spawn("script_model", var7);
  var9 setModel("tag_origin");
  var9.angles = var8;
  var4.revivecameraent = var9;
  var4 cameralinkTo(var9, "tag_origin", 1);
  thread revivecamerapullin();

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    thread applynvgforrevive();
  }

  thread runslamzoomonspawn();
}

function getrevivecameradata(var0, var1) {
  var2 = level.revivetriggers[var0.guid].curorigin;
  var3 = var2;
  var4 = vectorNormalize(var1.origin - var3);
  var5 = 2;
  var6 = 30;
  var7 = 360 / var6;
  var8 = 1;
  var9 = 1;
  var10 = 100;
  var11 = generateaxisanglesfromforwardvector(var4, (0, 0, 1));
  var12 = 0;
  var13 = undefined;
  var14 = 0;
  var15 = var3;
  var16 = var11;

  while(var8 < var7) {
    if(var12) {
      var12 = 0;
      var13 = anglesToForward(var11);
    } else {
      var13 = anglesToForward(var11 + (0, scripts\engine\utility::ter_op(var9, var6, var6 * -1) * var8, 0));
      var9 = !var9;

      if(var9 == 1) {
        var8++;
      }
    }

    var17 = var3 + (0, 0, 12);
    var18 = var3 + var13 * var10 + (0, 0, 100);
    var19 = scripts\engine\trace::sphere_trace(var17, var18, var5, [var1]);
    var20 = 30;
    var21 = var19["position"];
    var22 = 0;

    if(var19["fraction"] < 1) {
      var21 += var13 * var5;
      var22 = 1;
    }

    if(var19["fraction"] > 0.99) {
      var15 = var21;
      var16 = vectortoangles(var13);
      break;
    }
  }

  var23 = spawnStruct();
  var23.origin = var15;
  var24 = vectorNormalize(var3 - var15);
  var23.angles = vectortoangles(var24);
  return var23;
}

function revivecamerapullin(var0) {
  var1 = self.revivecameraent.origin + anglesToForward(self.revivecameraent.angles) * 3;
  var2 = self.revivecameraent.origin + anglesToForward(self.revivecameraent.angles) * 50;
  var3 = scripts\engine\trace::sphere_trace(var1, var2, 2, undefined)["position"];
  var4 = level.revivetriggers[self.guid].usetime / 1000;
  self.revivecameraent moveTo(var3, var4, var4 * 0.3, var4 * 0.3);
}

function applynvgforrevive() {
  self notify("stopNVGOnRevive");
  self endon("stopNVGOnRevive");
  wait 1;
  self nightvisionviewon(1);
}

function deleteonspawn(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("spawned_player");
  var0 delete();
}

function allowedwhilereviving(var0) {
  scripts\common\utility::allow_melee(var0);
  scripts\common\utility::allow_jump(var0);
  scripts\mp\utility\player::allow_gesture(var0);
  scripts\common\utility::allow_offhand_weapons(var0);
}

function movecameratorevivepos(var0, var1, var2) {
  var3 = 1;
  var4 = 1;
  self moveTo(var0, 1, 0.5, 0.5);
  var1 = (-9.5111, var2.angles[1], 0);
  self rotateTo(var1, 1, 0.5, 0.5);
}

function revivetriggerholdonuseend(var0, var1, var2, var3) {
  if(isDefined(self.trigger.owner)) {
    var4 = self.trigger.owner;
    var5 = level.revivetriggers[var4.guid].defaultusetime;
    level.revivetriggers[var4.guid] scripts\mp\gameobjects::setusetime(var5);
    var4 scripts\mp\utility\player::ref_1312b(0);

    if(var2) {
      if(!isDefined(var4.revivecount)) {
        var4.revivecount = 1;
      } else {
        var4.revivecount++;
      }

      var6 = scripts\mp\utility\dvars::getwatcheddvar("lastStandReviveHealth");
      scripts\mp\analyticslog::logevent_playerhealed(var4, var6, var1);
      var4 setclientomnvar("ui_reviver_id", -1);
      var4 setclientomnvar("ui_securing", 0);
    } else {
      thread _updatereviveteamusable(self.trigger, var4.team);

      if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
        var7 = "hud_realism_head_revive";
      } else {
        var7 = "hud_icon_cyber_revive";
      }

      if(isDefined(level.revivetriggers[var5.guid].headicondeath)) {
        setheadiconenemyimage(level.revivetriggers[var5.guid].headicondeath, var7);
      }

      var5 scripts\mp\utility\player::_freezecontrols(0, undefined, "teamRevive");
      var5 scripts\mp\utility\player::updatesessionstate("spectator");
      var5 cameraunlink();
      var5.revivecameraent delete();

      if(isDefined(var5.team) && var5.team != "spectator") {
        var5 allowspectateteam(var5.team, 1);

        foreach(var9 in level.teamnamelist) {
          if(var9 != var5.team) {
            var5 allowspectateteam(var9, 0);
          }
        }

        var5 spectateclientnum(var2 getentitynumber());
      }
    }
  }

  if(!istrue(var4)) {
    thread allowedwhilereviving(var2);
  }

  if(isPlayer(var2)) {
    var2 setclientomnvar("ui_securing", 0);
    var2 setclientomnvar("ui_securing_progress", 0.01);
    var2.ui_securing = undefined;
  }

  if(var3) {
    var2 scripts\mp\utility\stats::incpersstat("revives", 1);

    if(istrue(var2.laststanding)) {
      var2 scripts\mp\utility\stats::incpersstat("clutchRevives", 1);
      return;
    }

    return;
  }
}

function revivetriggeroncantuse(var0) {
  var0 scripts\mp\hud_message::showerrormessage("MP/PLAYER_ALREADY_BEING_REVIVED");
}

function addtriggerdeathicon(var0, var1, var2) {
  if(!level.teambased) {
    return;
  }

  var3 = var0.visuals[0].origin;
  var1 endon("spawned_player");
  var1 endon("disconnect");
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

  if(!isDefined(var2) || var2 == "spectator") {
    return;
  }

  self.lastheadicondeathent = spawn("script_model", var3);
  self.lastheadicondeathent setModel("tag_origin");
  self.lastheadicondeathent.team = var2;

  if(scripts\cp_mp\utility\game_utility::isrealismenabled() || level.hardcoremode) {
    var4 = 0;
    var5 = 500;
    var6 = 100;
    var7 = "hud_realism_head_revive";
  } else {
    var4 = 1;
    var5 = 8000;
    var6 = 100;
    var7 = "hud_icon_cyber_revive";
  }

  var4.headicondeath = self.lastheadicondeathent thread scripts\cp_mp\entityheadicons::setheadicon_multiimage(var6, var7, undefined, undefined, 0, var4, var5, var6);

  if(level.showenemydeathloc) {
    setheadiconneutralimage(var4.headicondeath, "hud_icon_death_hunter_spawn");

    foreach(var9 in level.teamnamelist) {
      removeclientfromheadiconmask(var4.headicondeath, var9);
    }

    return;
  }
}

function runslamzoomonspawn() {
  self notify("end_spawn_zoom");
  self endon("end_spawn_zoom");
  level endon("game_ended");
  self waittill("spawned_player");
  var0 = self getEye();
  var1 = self.angles;
  self cameralinkTo(self.revivecameraent, "tag_origin", 1);
  self.revivecameraent moveTo(var0, 0.25, 0.1, 0.1);
  self.revivecameraent rotateTo(var1, 0.25, 0.1, 0.1);
  wait 0.25;
  self visionsetnakedforplayer("", 0.1);
  self cameraunlink();
  self.revivecameraent delete();
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "revived");
}

function playslamzoomflash() {
  var0 = newclienthudelem(self);
  var0.x = 0;
  var0.y = 0;
  var0.alignx = "left";
  var0.aligny = "top";
  var0.sort = 1;
  var0.horzalign = "fullscreen";
  var0.vertalign = "fullscreen";
  var0.alpha = 1;
  var0.foreground = 1;
  var0 setshader("white", 640, 480);
  var0 fadeovertime(0.4);
  var0.alpha = 0;
  wait 0.4;
  var0 destroy();
}

function cleanuprevivetriggericons() {
  foreach(var1 in level.revivetriggers) {
    var1 scripts\mp\gameobjects::allowuse("none");
    var1 notify("reset");
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var1.lastheadicondeath);

    if(isDefined(var1.lastheadicondeathent)) {
      var1.lastheadicondeathent delete();
    }
  }
}

function updatetimerwaitforjoined() {}

function assigntimervisibleteam(var0) {
  self.interactteams = var0;

  foreach(var2 in level.players) {
    applytimervisibleteam(var2);
  }
}

function applytimervisibleteam(var0) {
  if(var0.team == self.ownerteam) {
    self.visuals[0] showtoplayer(var0);
    return;
  }

  self.visuals[0] hidefromplayer(var0);
}

function waitrespawnbutton() {
  self endon("disconnect");
  self endon("started_spawnPlayer");
  self endon("team_eliminated");
  var0 = 0;

  for(;;) {
    if(self useButtonPressed()) {
      while(self useButtonPressed()) {
        var0 += 0.05;

        if(var0 >= 1) {
          break;
        }

        wait 0.05;
      }

      if(var0 >= 0.5) {
        var0 += 0.05;
      }
    }

    var0 = 0;
    wait 0.05;
  }
}