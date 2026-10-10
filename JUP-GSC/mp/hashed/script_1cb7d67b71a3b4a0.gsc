/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1cb7d67b71a3b4a0.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\wm_utility;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\stats;
#namespace namespace_67c9b7e43f686e3;

function setupobjective(trigger) {
  hackzone = undefined;
  label = undefined;
  visual = getEnt(trigger.target, "targetname");
  var_4511b372ffc686e = getentitylessscriptablearray(visual.target, "targetname");
  visuals = [visual];

  if(isDefined(trigger.objectivekey)) {
    objectivekey = trigger.objectivekey;
  } else {
    objectivekey = trigger.script_label;
  }

  contestzone = scripts\mp\gameobjects::createuseobject(game["defenders"], trigger, visuals, (0, 0, 32), 1, 1);
  contestzone scripts\mp\gameobjects::requestid(1, 1);
  contestzone scripts\mp\gameobjects::setownerteam(game["defenders"]);
  contestzone.objectivekey = objectivekey;
  contestzone.iconname = objectivekey;
  contestzone.trigger setusepriority(-1 - 1 - 1 - 1);
  contestzone scripts\mp\gameobjects::setusetime(3);
  scripts\mp\objidpoolmanager::objective_set_show_progress(contestzone.objidnum, 0);
  contestzone.trigger setuseholdduration("duration_none");
  contestzone.trigger setuseprioritymax();
  contestzone.trigger setuserange(256);
  contestzone.onbeginuse = &function_fa7eadcccfd9f8af;
  contestzone.onenduse = &function_8872296c098fd3;
  contestzone.onuse = &function_a0406da3cd07c605;
  contestzone.robbed = 0;
  return contestzone;
}

function function_fa7eadcccfd9f8af(player) {
  player thread function_afb5c8b779cdb290(0);

  if(self.robbed) {
    self.var_9832d5270deb1889 = 1;
  } else {
    self.var_b7c18e4654e6881a = 1;
  }

  if(isDefined(self.var_5d8933c950c9a154)) {
    scripts\mp\gametypes\wm_utility::function_e3cd4f9e858ab6ee(player, self.var_5d8933c950c9a154);
  }

  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, player.team);
  scripts\mp\objidpoolmanager::objective_set_pulsate(self.objidnum, 1);
  thread function_8a671a44c8f902ac();
}

function function_8a671a44c8f902ac() {
  self endon("hack_recovered");
  self notify("end_use");
  self endon("end_use");

  if(!isDefined(self.usetime) || self.usetime <= 0) {
    return;
  }

  while(true) {
    progress = self.curprogress / self.usetime;

    if(progress >= 1) {
      break;
    }

    waitframe();
  }
}

function function_8872296c098fd3(team, player, result) {
  if(isDefined(self.var_5d8933c950c9a154)) {
    scripts\mp\gametypes\wm_utility::function_c470fe81662c7d70(player);
  }

  scripts\mp\objidpoolmanager::objective_set_pulsate(self.objidnum, 0);

  if(istrue(self.var_b7c18e4654e6881a)) {
    self.var_b7c18e4654e6881a = undefined;
  } else if(istrue(self.var_9832d5270deb1889)) {
    self.var_9832d5270deb1889 = undefined;
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  }

  player thread function_afb5c8b779cdb290(1);
  self notify("end_use");
}

function function_a0406da3cd07c605(player) {
  self.curprogress = 0;

  if(!self.robbed) {
    self.robbed = 1;
    scripts\mp\gameobjects::setownerteam(game["attackers"]);
    scripts\mp\gameobjects::allowuse("enemy");

    if(isDefined(self.var_29496385a7b64f4c)) {
      self[[self.var_29496385a7b64f4c]](player);
    }

    player scripts\mp\utility\points::doscoreevent(#"hash_6db5034f05db9ec0");
    thread function_4e824d591dc50cac();
    self notify("contest_robbed");
  } else {
    self.robbed = 0;
    scripts\mp\gameobjects::setownerteam(game["defenders"]);
    scripts\mp\gameobjects::allowuse("enemy");
    scripts\mp\objidpoolmanager::objective_set_show_progress(self.objidnum, 0);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);

    if(isDefined(self.var_229b5586c139bcbf)) {
      self[[self.var_229b5586c139bcbf]](player);
    }

    player scripts\mp\utility\points::doscoreevent(#"hash_4ae9ad522095ee31");
    self notify("contest_recovered");
  }

  foreach(target_player in level.players) {
    scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objidnum, target_player);
  }
}

function function_4e824d591dc50cac() {
  level endon("game_ended");
  self endon("contest_recovered");
  progress = 1;
  totalsec = self.contesttotalseconds;

  if(!isDefined(totalsec)) {
    totalsec = 15;
  }

  totaltime = 1000 * totalsec;
  endtime = gettime() + totaltime;
  level.objectives[self.objectivekey].complete = 0;
  scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, undefined);
  scripts\mp\objidpoolmanager::objective_set_show_progress(self.objidnum, 1);

  while(progress > 0) {
    currenttime = gettime();
    var_c301d652d9a73075 = endtime - currenttime;
    progress = max(0, var_c301d652d9a73075 / totaltime);
    self.var_256648199aa47753 = 1 - progress;
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 1 - progress);
    waitframe();
  }

  scripts\mp\gameobjects::disableobject();
  scripts\mp\gameobjects::allowuse("none");

  if(isDefined(self.var_80eb66118fa863c1)) {
    self[[self.var_80eb66118fa863c1]]();
  }

  self notify("obj_contest_zone_robbed");
  level.objectives[self.objectivekey].complete = 1;
}

function function_afb5c8b779cdb290(isallowed) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!isallowed) {
    val::set("contestzone", "allow_jump", 0);
    val::set("contestzone", "gesture", 0);
    val::set("contestzone", "melee", 0);
    val::set("contestzone", "mantle", 0);
    val::set("contestzone", "offhand_weapons", 0);
    val::set("contestzone", "sprint", 0);
    val::set("contestzone", "slide", 0);
    return;
  }

  val::set("contestzone", "allow_jump", 1);
  val::set("contestzone", "gesture", 1);
  currweap = self getcurrentweapon();

  if(isDefined(currweap) && currweap.basename == "briefcase_bomb_mp") {
    self waittill("bomb_allow_offhands");
  }

  val::reset_all("contestzone");
}