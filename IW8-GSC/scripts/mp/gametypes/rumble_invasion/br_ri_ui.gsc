/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_ui.gsc
*************************************************************/

function ref_13eee() {
  var0 = "any";
  var1 = level.start_reach_exhaust_waste.ref_12e2c.ground_detection_think + vectorNormalize(level.start_reach_exhaust_waste.ref_12e2c.ref_136a8["axis"]) * level.start_reach_exhaust_waste.ref_12e2c.circle_radius * level.start_reach_exhaust_waste.ref_12e2c.ref_13631;
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  var2.origin = var1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 6);
  objective_state(var2.objidnum, "active");
  var2.lockupdatingicons = 1;
  var2.team = "axis";
  level.spawn_set_jugg_value.choosecrouchorstandtac = var2;
  thread ref_13ef2();
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  var2.origin = var1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 7);
  objective_state(var2.objidnum, "active");
  var2.lockupdatingicons = 1;
  var2.team = "axis";
  level.spawn_set_jugg_value.choosebestpropforkillcam = var2;
  thread ref_13ef2();
  level.spawn_set_jugg_value.choosebestpropforkillcam thread scripts\mp\gametypes\br_gametype_rumble_invasion::ref_11aff("axis");
  var1 = level.start_reach_exhaust_waste.ref_12e2c.ground_detection_think + vectorNormalize(level.start_reach_exhaust_waste.ref_12e2c.ref_136a8["allies"]) * level.start_reach_exhaust_waste.ref_12e2c.circle_radius * level.start_reach_exhaust_waste.ref_12e2c.ref_13631;
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  var2.origin = var1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 6);
  objective_state(var2.objidnum, "active");
  var2.lockupdatingicons = 1;
  var2.team = "allies";
  level.spawn_set_jugg_value.brjugg_cleanupents = var2;
  thread ref_13ef2();
  var2 = scripts\mp\gameobjects::createobjidobject(var1, "neutral", (0, 0, 0), undefined, var0, 0);
  var2.origin = var1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var2.objidnum, 0);
  var2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var2.objidnum, 7);
  objective_state(var2.objidnum, "active");
  var2.lockupdatingicons = 1;
  var2.team = "allies";
  level.spawn_set_jugg_value.briskillstreakallowed = var2;
  thread ref_13ef2();
  level.spawn_set_jugg_value.briskillstreakallowed thread scripts\mp\gametypes\br_gametype_rumble_invasion::ref_11aff("allies");
}

function ref_13ef2() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("rumble_location_selected");
  var0 = scripts\engine\utility::ter_op(self.team == "axis", level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange);

  if(!isDefined(var0)) {
    return;
  }

  self.origin = var0;
  scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, var0);
}

function ref_13ee7() {
  self endon("disconnect");

  if(self.team == "allies") {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.brjugg_cleanupents.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosebestpropforkillcam.objidnum, self);
    return;
  }

  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.briskillstreakallowed.objidnum, self);
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosecrouchorstandtac.objidnum, self);
}

function ref_12425(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var2)) {
    var3 = spawnStruct();
    var3.intvar = var2;
  }

  if(isalive(var0)) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var0, var1, var3);
    return;
  }

  thread ref_12981(var0);
}

function ref_12424(var0, var1) {
  foreach(var3 in level.players) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = undefined;

    if(isalive(var3)) {
      if(isDefined(var1)) {
        var4 = spawnStruct();
        var4.intvar = var1;
      }

      scripts\mp\gametypes\br_quest_util::displayplayersplash(var3, var0, var4);
      continue;
    }

    if(!isDefined(var4)) {
      var4 = spawnStruct();
    }

    var4.intvar = var1;
    var4.ref_136f3 = var0;
    thread ref_12981(var3);
  }
}

function ref_12981(var0) {
  self notify("dead_splash_queue_triggered");
  self endon("dead_splash_queue_triggered");
  level endon("game_ended");
  level endon("disconnect");

  if(!isDefined(self.isflagcarrymode)) {
    self.isflagcarrymode = [];
  }

  self.isflagcarrymode = scripts\engine\utility::array_add(self.isflagcarrymode, var0);

  while(self.isflagcarrymode.size > 0) {
    if(isalive(self)) {
      wait 0.5;

      foreach(var2 in self.isflagcarrymode) {
        scripts\mp\gametypes\br_quest_util::displayplayersplash(self, var2.ref_136f3, var2);
      }

      self.isflagcarrymode = [];
      break;
    }

    wait 1;
  }
}