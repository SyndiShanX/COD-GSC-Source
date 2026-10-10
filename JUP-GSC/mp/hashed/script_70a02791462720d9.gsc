/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_70a02791462720d9.gsc
*************************************************/

#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\game;
#using scripts\mp\utility\teams;
#namespace warrior_tag;

function function_517a40967304ed3b() {
  thread onplayerspawned();
  scripts\mp\gamelogic::setwaypointiconinfo("bounty_enemy", 0, "enemy", "JUP_WARRIOR/TAG_LABEL", "icon_waypoint_hvt_enemy", 0, undefined);
  scripts\mp\gamelogic::setwaypointiconinfo("bounty_friendly", 0, "friendly", "JUP_WARRIOR/TAG_LABEL", "icon_waypoint_hvt_friendly", 0, 12);
  thread function_fad59c0a1e620c0a();
  thread function_492b4dec632917ec("warrior_tag");
}

function function_1de44abc82eabffb() {
  foreach(player in level.players) {
    if(isDefined(player.trackedobject)) {
      player.trackedobject scripts\mp\gameobjects::deletetrackedobject();
    }
  }
}

function onplayerspawned() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    level waittill("player_spawned", player);
    player takeallweapons();
    fistsweapon = scripts\cp_mp\utility\weapon_utility::function_eeaa22f0cd1ff845("iw9_me_fists_mp");
    player giveweapon(fistsweapon);
    player setspawnweapon(fistsweapon);
  }
}

function function_fad59c0a1e620c0a() {
  level endon("game_ended");
  level endon("round_end_finished");
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  randomnum = randomint(3);
  var_8ae7877c2831d687 = level.teamnamelist[randomnum];
  players = scripts\mp\utility\teams::getteamdata(var_8ae7877c2831d687, "players");

  foreach(player in players) {
    player function_6415f0285a74c676();
  }
}

function function_6415f0285a74c676() {
  trackedobject = scripts\mp\gameobjects::createtrackedobject(self, (0, 0, 70));
  scripts\mp\objidpoolmanager::objective_set_play_intro(trackedobject.objidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(trackedobject.objidnum, 0);
  trackedobject.objidpingfriendly = 1;
  trackedobject.objidpingenemy = 0;
  trackedobject.objpingdelay = 5;
  trackedobject scripts\mp\gameobjects::setobjectivestatusicons("bounty_friendly");
  trackedobject scripts\mp\gameobjects::setvisibleteam("friendly");
  self.trackedobject = trackedobject;
  trackedobject.pingobjidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  scripts\mp\objidpoolmanager::objective_add_objective(trackedobject.pingobjidnum, "current", self.origin);
  scripts\mp\objidpoolmanager::objective_set_play_intro(trackedobject.pingobjidnum, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(trackedobject.pingobjidnum, 0);
  scripts\mp\objidpoolmanager::update_objective_ownerteam(trackedobject.pingobjidnum, self.team);
  trackedobject scripts\mp\gameobjects::updatecompassicon("enemy", trackedobject.pingobjidnum);
  scripts\mp\objidpoolmanager::update_objective_icon(trackedobject.pingobjidnum, level.waypointshader["bounty_enemy"]);
  scripts\mp\objidpoolmanager::update_objective_setenemylabel(trackedobject.pingobjidnum, level.waypointstring["bounty_enemy"]);
  scripts\mp\objidpoolmanager::update_objective_state(trackedobject.pingobjidnum, "current");
  scripts\mp\objidpoolmanager::function_79a1a16de6b22b2d(trackedobject.pingobjidnum, 0);
  thread scripts\mp\hud_message::showsplash("warrior_tag_notify");
}

function function_37ed5e5b9ae057e0(attacker, victim) {
  if(isDefined(attacker) && isDefined(attacker.trackedobject)) {
    players = scripts\mp\utility\teams::getteamdata(attacker.team, "players");

    foreach(player in players) {
      if(isDefined(player.trackedobject.pingobjidnum)) {
        scripts\mp\objidpoolmanager::returnobjectiveid(player.trackedobject.pingobjidnum);
        player.trackedobject.pingobjidnum = undefined;
      }

      player.trackedobject scripts\mp\gameobjects::deletetrackedobject();
      player.trackedobject = undefined;
    }

    players = scripts\mp\utility\teams::getteamdata(victim.team, "players");

    foreach(player in players) {
      player function_6415f0285a74c676();
    }
  }
}

function function_a3c9522a7535384a(winner, endreasontext, nukedetonated) {
  foreach(player in level.players) {
    if(isDefined(player.trackedobject)) {
      losingteam = player.team;
      break;
    }
  }

  var_d1128867a788e1cf = getenemyteams(losingteam);

  foreach(team in var_d1128867a788e1cf) {
    scripts\mp\gamescore::giveteamscoreforobjective(team, 1, 1);
  }

  return true;
}