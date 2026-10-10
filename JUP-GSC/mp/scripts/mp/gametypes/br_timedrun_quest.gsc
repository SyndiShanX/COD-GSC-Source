/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_timedrun_quest.gsc
*********************************************************/

#using script_64acb6ce534155b7;
#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_circle;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_util;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace br_timedrun_quest;

function getcontractdata(data) {
  level.trprops = spawnStruct();
  level.trprops.time = getdvarint(@ "hash_71ede8ba370404c2", 120);
  level.trprops.maxrange = getdvarint(@ "hash_b572422cdea70219", 23000);
  level.trprops.minrange = getdvarint(@ "hash_1f550799f4e3bd93", 5000);
  level.trprops.var_8f7c18f3dcce9dff = getdvarint(@ "hash_e1260eee3fc09c9f", 20000);
  level.trprops.var_908d1b90e147e411 = getdvarint(@ "hash_8b3ecaca4442e5cd", 17000);
  level.trprops.radius = getdvarint(@ "hash_e74f977d917a9849", 150);
  assert(isDefined(game["<dev string:x1c>"]));
  game["dialog"]["mission_timedrun_accept"] = "mission_mission_time_accept";
  game["dialog"]["mission_timedrun_fail"] = "mission_mission_time_failed";
  data.funcs["onInit"] = &function_f95df4809dfa1d7f;
  data.funcs["onTeamAssigned"] = &function_fbc4e1bc931264a8;
}

function function_f95df4809dfa1d7f() {
  kiosk = self.tablet function_3948b71d8c04b5b8();

  if(!isDefined(kiosk)) {
    return false;
  }

  self.kiosk = kiosk;
  return true;
}

function function_fbc4e1bc931264a8() {
  if(!isDefined(self.kiosk)) {
    kiosk = self.tablet function_3948b71d8c04b5b8();

    if(!isDefined(kiosk)) {
      return;
    }

    self.kiosk = kiosk;
  }

  uiobjectiveshowtoteam("timedrun", self.teams[0]);
  time = level.trprops.time;
  time = function_9b6275085fbcb8f4(time);
  function_5a15174d34f0670c(time);
  thread function_fe13e6dc6fe958b8(time);
  displayteamsplash(self.teams[0], "br_timedrun_quest_start_team_notify");
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_timedrun_accept", self.teams[0], 1, 1);
  self.curorigin = self.kiosk.origin;
  createquestobjicon("ui_mp_br_mapmenu_icon_timedrun_objective", "current", self.curorigin + (0, 0, 65));
  thread timedrun_finishlinevfx(self.kiosk.origin, self.teams[0]);
  players = getteamdata(self.teams[0], "players");

  foreach(player in players) {
    showquestobjicontoplayer(player);
  }

  thread tr_detectwinners();
}

function function_701b9420ca853766(success) {
  self notify("task_ended");
  deletequestobjicon();
  wait 1;
  endcontract(ter_op(istrue(success), self.teams[0], undefined));
}

function function_fe13e6dc6fe958b8(time) {
  self endon("task_ended");
  level endon("game_ended");
  wait time;
  params = spawnStruct();
  params.intvar = 0;
  displayteamsplash(self.teams[0], "br_timedrun_quest_timer_expired", params);
  level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_timedrun_fail", self.teams[0], 1, 1);
  thread function_701b9420ca853766(0);
}

function function_3948b71d8c04b5b8() {
  allkiosks = scripts\mp\gametypes\br_armory_kiosk::getallspawninstances();
  activekiosks = [];

  foreach(kiosk in level.br_armory_kiosk.scriptables) {
    if(!istrue(kiosk.disabled)) {
      activekiosks[activekiosks.size] = kiosk;
    }
  }

  locations = array_randomize(activekiosks);
  var_fdc6ee1b91ebb7bf = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(self.origin);
  kiosk = undefined;
  bestlocindex = undefined;
  var_be0f4d48fa40793f = level.trprops.maxrange;

  foreach(i, node in locations) {
    dist = distance2d(node.origin, self.origin);

    if(dist > level.trprops.maxrange || dist < level.trprops.minrange) {
      continue;
    }

    if(!level.br_circle_disabled) {
      var_28deb7ff62e281d3 = scripts\mp\gametypes\br_circle::getmintimetillpointindangercircle(node.origin);

      if(var_28deb7ff62e281d3 < var_fdc6ee1b91ebb7bf) {
        continue;
      }

      traveltime = dist / 190;
      var_28deb7ff62e281d3 -= traveltime;

      if(var_28deb7ff62e281d3 < 45) {
        continue;
      }

      var_5435995e95681b89 = 0;

      if(dist < level.trprops.var_8f7c18f3dcce9dff) {
        if(dist < level.trprops.var_908d1b90e147e411) {
          var_5435995e95681b89 = level.trprops.var_908d1b90e147e411 - dist;
        }
      } else {
        var_5435995e95681b89 = dist - level.trprops.var_8f7c18f3dcce9dff;
      }

      if(var_5435995e95681b89 < var_be0f4d48fa40793f) {
        var_be0f4d48fa40793f = var_5435995e95681b89;
        bestlocindex = i;
        kiosk = node;

        if(var_5435995e95681b89 <= 0) {
          break;
        }
      }
    }
  }

  return kiosk;
}

function timedrun_finishlinevfx(spawn_origin, team) {
  finishlinevfx = spawnfx(level._effect["vfx_marker_base_orange_pulse"], spawn_origin + (0, 0, 10));
  finishlinevfx.angles = vectortoangles((0, 0, 1));
  finishlinevfx hide();
  wait 0.5;
  triggerfx(finishlinevfx);

  foreach(player in getteamdata(team, "players")) {
    finishlinevfx showtoplayer(player);
  }

  self.finishlinevfx = finishlinevfx;
}

function tr_detectwinners() {
  self endon("task_ended");
  level endon("game_ended");

  while(true) {
    foreach(player in getteamdata(self.teams[0], "players")) {
      if(distance(player.origin, self.kiosk.origin) < level.trprops.radius) {
        rewards = function_d212a5e7a40d7c8d("timedrun", self.teams[0]);

        if(isDefined(rewards) && isDefined(rewards[0])) {
          function_878ebcc241b54505("br_timedrun_quest_complete", function_3d262d56274bd22e("timedrun"), rewards[0], self.teams[0]);
        }

        level thread scripts\mp\gametypes\br_public::brleaderdialogteam("mission_misc_success", self.teams[0], 1, 1);
        squadmembers = getteamdata(self.teams[0], "players");

        foreach(player in squadmembers) {
          if(isDefined(player) && !istrue(player.br_iseliminated)) {
            scripts\mp\gametypes\br_armory_kiosk::kiosksetupfiresaleforplayer(self.kiosk, player);
          }
        }

        self.rewardmodifier = undefined;
        self.result = "success";
        thread function_701b9420ca853766(1);
        return;
      }
    }

    waitframe();
  }
}

function hidetimedrunhudfromplayer(player) {
  hidequestobjiconfromplayer(player);
  player uiobjectivehide();
}

function deletetimedrunhud() {
  foreach(player in self.playerlist) {
    hidetimedrunhudfromplayer(player);
  }

  deletequestobjicon();
}