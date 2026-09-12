/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_ui.gsc
*************************************************************/

function ref_13EEE() {
  var_0 = "any";
  var_1 = level.start_reach_exhaust_waste.ref_12E2C.ground_detection_think + vectorNormalize(level.start_reach_exhaust_waste.ref_12E2C.ref_136A8["axis"]) * level.start_reach_exhaust_waste.ref_12E2C.circle_radius * level.start_reach_exhaust_waste.ref_12E2C.ref_13631;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "active");
  var_2.lockupdatingicons = 1;
  var_2.team = "axis";
  level.spawn_set_jugg_value.choosecrouchorstandtac = var_2;
  thread ref_13EF2();
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 7);
  objective_state(var_2.objidnum, "active");
  var_2.lockupdatingicons = 1;
  var_2.team = "axis";
  level.spawn_set_jugg_value.choosebestpropforkillcam = var_2;
  thread ref_13EF2();
  level.spawn_set_jugg_value.choosebestpropforkillcam thread scripts\mp\gametypes\br_gametype_rumble_invasion::ref_11AFF("axis");
  var_1 = level.start_reach_exhaust_waste.ref_12E2C.ground_detection_think + vectorNormalize(level.start_reach_exhaust_waste.ref_12E2C.ref_136A8["allies"]) * level.start_reach_exhaust_waste.ref_12E2C.circle_radius * level.start_reach_exhaust_waste.ref_12E2C.ref_13631;
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_friendly");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 6);
  objective_state(var_2.objidnum, "active");
  var_2.lockupdatingicons = 1;
  var_2.team = "allies";
  level.spawn_set_jugg_value.brjugg_cleanupents = var_2;
  thread ref_13EF2();
  var_2 = scripts\mp\gameobjects::createobjidobject(var_1, "neutral", (0, 0, 0), undefined, var_0, 0);
  var_2.origin = var_1;
  scripts\mp\objidpoolmanager::update_objective_ownerteam(var_2.objidnum, "allies");
  scripts\mp\objidpoolmanager::objective_teammask_addtomask(var_2.objidnum, "axis");
  scripts\mp\objidpoolmanager::objective_set_play_intro(var_2.objidnum, 0);
  var_2.lockupdatingicons = 0;
  scripts\mp\objidpoolmanager::objective_pin_global(var_2.objidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_icon(var_2.objidnum, "icon_waypoint_hq_enemy");
  scripts\mp\objidpoolmanager::update_objective_setbackground(var_2.objidnum, 7);
  objective_state(var_2.objidnum, "active");
  var_2.lockupdatingicons = 1;
  var_2.team = "allies";
  level.spawn_set_jugg_value.briskillstreakallowed = var_2;
  thread ref_13EF2();
  level.spawn_set_jugg_value.briskillstreakallowed thread scripts\mp\gametypes\br_gametype_rumble_invasion::ref_11AFF("allies");
}

function ref_13EF2() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("rumble_location_selected");
  var_0 = scripts\engine\utility::ter_op(self.team == "axis", level.spawn_set_jugg_value.chosen, level.spawn_set_jugg_value.choppersupport_watchtargetrange);

  if(!isDefined(var_0)) {
    return;
  }

  self.origin = var_0;
  scripts\mp\objidpoolmanager::update_objective_position(self.objidnum, var_0);
}

function ref_13EE7() {
  self endon("disconnect");

  if(self.team == "allies") {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.brjugg_cleanupents.objidnum, self);
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosebestpropforkillcam.objidnum, self);
    return;
  }

  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.briskillstreakallowed.objidnum, self);
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(level.spawn_set_jugg_value.choosecrouchorstandtac.objidnum, self);
}

function ref_12425(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.intvar = var_2;
  }

  if(isalive(var_0)) {
    scripts\mp\gametypes\br_quest_util::displayplayersplash(var_0, var_1, var_3);
    return;
  }

  thread ref_12981(var_0);
}

function ref_12424(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = undefined;

    if(isalive(var_3)) {
      if(isDefined(var_1)) {
        var_4 = spawnStruct();
        var_4.intvar = var_1;
      }

      scripts\mp\gametypes\br_quest_util::displayplayersplash(var_3, var_0, var_4);
      continue;
    }

    if(!isDefined(var_4)) {
      var_4 = spawnStruct();
    }

    var_4.intvar = var_1;
    var_4.ref_136F3 = var_0;
    thread ref_12981(var_3);
  }
}

function ref_12981(var_0) {
  self notify("dead_splash_queue_triggered");
  self endon("dead_splash_queue_triggered");
  level endon("game_ended");
  level endon("disconnect");

  if(!isDefined(self.isflagcarrymode)) {
    self.isflagcarrymode = [];
  }

  self.isflagcarrymode = scripts\engine\utility::array_add(self.isflagcarrymode, var_0);

  while(self.isflagcarrymode.size > 0) {
    if(isalive(self)) {
      wait 0.5;

      foreach(var_2 in self.isflagcarrymode) {
        scripts\mp\gametypes\br_quest_util::displayplayersplash(self, var_2.ref_136F3, var_2);
      }

      self.isflagcarrymode = [];
      break;
    }

    wait 1;
  }
}