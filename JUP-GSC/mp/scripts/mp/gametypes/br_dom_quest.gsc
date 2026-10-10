/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_dom_quest.gsc
****************************************************/

#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_dom_quest;

function getcontractdata(data) {
  level.domprops = spawnStruct();
  level.domprops.capturetime = getdvarint(@ "hash_d1ba52fb82cf7653", 30);
  level.domprops.time = getdvarint(@ "hash_be42880c860992ec", 240);
  level.domprops.captureradius = getdvarint(@ "hash_51711b96c9b3eec0", 128);
  assert(isDefined(game["<dev string:x1c>"]));
  game["dialog"]["mission_dom_accept"] = "mission_mission_dom_accept_secure";
  game["dialog"]["mission_dom_success"] = "mission_mission_dom_success";
  data.funcs["onInit"] = &function_9088ffe8cb64311f;
  data.funcs["onTeamAssigned"] = &function_e387efb61ad86b48;
  setupdom();
}

function function_9088ffe8cb64311f() {
  placement = self.tablet function_8baad4bd99e782a3();

  if(!isDefined(placement)) {
    return false;
  }

  self.reservedplacement = placement;
  return true;
}

function function_e387efb61ad86b48() {
  uiobjectiveshowtoteam("domination", self.teams[0]);
  time = level.domprops.time;
  time = function_9b6275085fbcb8f4(time);
  function_5a15174d34f0670c(time);
  thread function_a859560671de3158(time);

  if(!isDefined(self.reservedplacement)) {
    placement = self.tablet function_8baad4bd99e782a3();

    if(!isDefined(placement)) {
      return;
    }

    self.reservedplacement = placement;
  }

  function_a5ecbc99b54d31da(self.reservedplacement);
  domflagupdateicons();
  uiobjectiveshowtoteam("domination", self.teams[0]);

  foreach(player in getteamdata(self.teams[0], "players")) {
    player thread scripts\mp\hud_message::showsplash("br_domination_quest_start_team");
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_dom_accept", self.teams[0], 1);

  print("<dev string:x26>");
}

function function_34a295960f3d086(success) {
  self notify("task_ended");
  self.ended = 1;
  self.domflag scripts\mp\gameobjects::releaseid();
  wait 1;
  endcontract(ter_op(istrue(success), self.teams[0], undefined));
}

function function_a859560671de3158(time) {
  self endon("task_ended");
  level endon("game_ended");
  wait time;
  params = spawnStruct();
  params.intvar = 0;
  displayteamsplash(self.teams[0], "br_domination_quest_timer_expired", params);
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_gen_fail", self.teams[0], 1);
  thread function_34a295960f3d086(0);
}

function function_8baad4bd99e782a3() {
  locations = array_randomize(getStructArray("dmz_dom_tower", "script_noteworthy"));
  var_fdc6ee1b91ebb7bf = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(self.origin);
  placement = undefined;
  bestlocindex = undefined;
  var_be0f4d48fa40793f = 12000;

  foreach(i, node in locations) {
    dist = distance2d(node.origin, self.origin);

    if(dist > var_be0f4d48fa40793f) {
      continue;
    }

    if(!level.br_circle_disabled) {
      var_28deb7ff62e281d3 = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(node.origin);

      if(var_28deb7ff62e281d3 < var_fdc6ee1b91ebb7bf) {
        continue;
      }

      traveltime = dist / 190;
      var_28deb7ff62e281d3 -= traveltime;

      if(var_28deb7ff62e281d3 < 30) {
        continue;
      }

      var_5435995e95681b89 = 0;

      if(dist < 8000) {
        if(dist < 6000) {
          var_5435995e95681b89 = 6000 - dist;
        }
      } else {
        var_5435995e95681b89 = dist - 8000;
      }

      if(var_5435995e95681b89 < var_be0f4d48fa40793f) {
        var_be0f4d48fa40793f = var_5435995e95681b89;
        bestlocindex = i;
        placement = node;

        if(var_5435995e95681b89 <= 0) {
          break;
        }
      }
    }
  }

  return placement;
}

function function_a5ecbc99b54d31da(placement) {
  domflagorigin = placement.origin;
  radius = level.domprops.captureradius;
  trigger = spawn("trigger_radius", domflagorigin, 0, int(radius), int(level.br_domheight));
  trigger.angles = placement.angles;
  trigger.script_label = "_a";
  level.setdomscriptablepartstatefunc = &domflag_setdomscriptablepartstate;
  domflag = scripts\mp\gametypes\obj_dom::setupobjective(trigger);
  domflag.flagmodel setModel("lm_domination_point_01");

  domflag.debugtype = "<dev string:x3e>";

  domflag.onuse = &domflag_onuse;
  domflag.onbeginuse = &domflag_onbeginuse;
  domflag.onuseupdate = &domflag_onuseupdate;
  domflag.onenduse = &domflag_onenduse;
  domflag.usecondition = &domflag_usecondition;
  domflag.lockupdatingicons = 1;
  domflag.checkuseconditioninthink = 1;
  scripts\mp\objidpoolmanager::update_objective_position(domflag.objidnum, domflag.curorigin + (0, 0, 60));
  level.flagcapturetime = level.domprops.capturetime;
  domflag scripts\mp\gameobjects::setusetime(level.flagcapturetime);
  self.lastcircletick = -1;
  self.domflag = domflag;
  self.curorigin = domflag.curorigin;
  domflag.task = self;
  self.radius = radius;
}

function domflagupdateicons() {
  objective_showtoplayersinmask(self.domflag.objidnum);
  objective_removeallfrommask(self.domflag.objidnum);

  foreach(player in getteamdata(self.teams[0], "players")) {
    if(!player scripts\mp\gametypes\br_public::isplayeringulag()) {
      objective_addclienttomask(self.domflag.objidnum, player);
    }
  }
}

function domflag_hideiconfromplayer(player) {
  objective_removeclientfrommask(self.domflag.objidnum, player);
}

function domflag_showicontoplayer(player) {
  objective_addclienttomask(self.domflag.objidnum, player);
}

function domflagupdateiconsframeend() {
  self endon("removed");
  waittillframeend();
  domflagupdateicons();
}

function deletedomflaggameobject() {
  foreach(vis in self.domflag.visuals) {
    vis delete();
  }

  if(isDefined(self.domflag.flagmodel)) {
    self.domflag.flagmodel delete();
  }

  if(isDefined(self.domflag.scriptable)) {
    self.domflag.scriptable delete();
  }

  if(isDefined(self.domflag.trigger)) {
    self.domflag.trigger delete();
    self.domflag.trigger = undefined;
  }

  self.domflag thread gameobjectreleaseid_delayed();
  self.domflag notify("deleted");
}

function gameobjectreleaseid_delayed() {
  wait 0.1;
  scripts\mp\gameobjects::releaseid();
}

function setupdom() {
  if(isDefined(level.br_domheight)) {
    return;
  }

  level.disableinitplayergameobjects = 0;
  level.br_domheight = 120;
  level.iconneutral = "waypoint_captureneutral_br";
  level.iconcapture = "waypoint_capture_br";
  level.icondefend = "waypoint_defend_br";
  level.icondefending = "waypoint_defending_br";
  level.iconcontested = "waypoint_contested_br";
  level.icontaking = "waypoint_taking_br";
  level.iconlosing = "waypoint_losing_br";
  level.iconovertime = "icon_waypoint_ot";
  _setdomflagiconinfo("icon_waypoint_dom_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _setdomflagiconinfo("waypoint_capture_br", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _setdomflagiconinfo("waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _setdomflagiconinfo("waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0);
  _setdomflagiconinfo("waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0);
  _setdomflagiconinfo("waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  _setdomflagiconinfo("waypoint_captureneutral_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _setdomflagiconinfo("waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _setdomflagiconinfo("waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _setdomflagiconinfo("icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _setdomflagiconinfo("icon_waypoint_ot", "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", 0);
}

function _setdomflagiconinfo(name, colors, string, pulses) {
  level.waypointcolors[name] = colors;
  level.waypointbgtype[name] = 1;
  level.waypointstring[name] = string;
  level.waypointshader[name] = "ui_mp_br_mapmenu_icon_dom_objective";
  level.waypointpulses[name] = pulses;
}

function domflag_onuseupdate(team, progress, change, capplayer) {
  if(progress < 1 && !level.gameended) {
    play_spotrep_capture_sfx(progress, team);
  }

  if(progress > 0.05 && change && !istrue(self.didstatusnotify)) {
    self.didstatusnotify = 1;
  }
}

function domflag_onbeginuse(credit_player) {
  if(!isDefined(self.obj_icon_revealed) || !self.obj_icon_revealed) {
    self.obj_icon_revealed = 1;
    level thread utilflare_shootflare(self.curorigin, "dom");
    playerteam = getteamarray(credit_player.team);
    playersinrange = scripts\mp\utility\player::getplayersinradius(self.curorigin, 7800, undefined, playerteam);

    foreach(player in playersinrange) {
      if(isDefined(player) && isalive(player)) {
        player thread scripts\mp\hud_message::showsplash("br_domination_quest_alert");
      }
    }

    playersquad = scripts\mp\utility\teams::getfriendlyplayers(credit_player.team, 0);

    foreach(teammate in playersquad) {
      teammate notify("calloutmarkerping_warzoneKillQuestIcon");
    }
  }
}

function domflag_onuse(credit_player) {
  if(self.task.teams[0] == credit_player.team) {
    missionid = getquestindex("domination");
    questrewardcirclepeek(self.task.teams[0]);
    rewards = function_d212a5e7a40d7c8d("dom", self.task.teams[0]);

    if(rewards && rewards[0]) {
      function_878ebcc241b54505("br_domination_quest_complete", function_3d262d56274bd22e("dom"), rewards[0], self.task.teams[0]);
    }

    displaysquadmessagetoteam(self.task.teams[0], credit_player, 8, missionid);
    level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_dom_success", self.task.teams[0], 1, 1);
    self.task.rewardorigin = self.flagmodel.origin;
    self.task.rewardangles = self.flagmodel.angles;
    self.task.result = "success";
    self.task thread function_34a295960f3d086(1);
    return;
  }

  displayteamsplash(self.task.teams[0], "br_domination_quest_failure");
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_gen_fail", self.task.teams[0], 1);
  self.task.result = "fail";
}

function domflag_onenduse(team, player, success) {
  scripts\mp\gametypes\obj_dom::dompoint_onuseend(team, player, success);
}

function play_spotrep_capture_sfx(progress, team) {
  if(!isDefined(self.lastsfxplayedtime)) {
    self.lastsfxplayedtime = gettime();
  }

  if(self.lastsfxplayedtime + 995 < gettime()) {
    self.lastsfxplayedtime = gettime();
    var_c3ddfb0eaa8f761c = "";
    progress = int(floor(progress * 10));
    var_c3ddfb0eaa8f761c = "mp_dom_capturing_tick_0" + progress;
    self.visuals[0] playsoundtoteam(var_c3ddfb0eaa8f761c, team);
  }
}

function domflag_setdomscriptablepartstate(part, state, statemod) {
  switch (state) {
    case #"hash_1c39674e5b0de0f3":
    case #"hash_3699ac6c262c25ea":
    case #"hash_86bf1a776a7c4cbe":
      return 0;
    default:
      state = "using";

      if(isDefined(statemod)) {
        state += statemod;
      }

      self.scriptable setscriptablepartstate(part, state);

      if(part == "pulse") {
        self.scriptable setscriptablepartstate("flag", state);
      }

      return 1;
  }
}

function domflag_usecondition(player) {
  return self.task.teams[0] == player.team && !istrue(self.task.ended);
}