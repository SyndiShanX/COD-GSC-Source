/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2f382e6c1908fbd4.gsc
*************************************************/

#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\warrior;
#using scripts\mp\hud_message;
#using scripts\mp\utility\game;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\teams;
#namespace warrior_hunt;

function function_32ab7b20f72916ba() {
  level.onplayerkilled = &onplayerkilled;
  thread onplayerspawned();
  function_93753111ae4c3c24();
}

function function_a4018333bf6dabce() {
  level.onplayerkilled = &warrior::onplayerkilled;
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
    player thread function_e03e8cb5b6e2a744();
  }
}

function function_93753111ae4c3c24() {
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");

  foreach(team in level.teamnamelist) {
    players = getteamdata(team, "players");

    if(players.size <= 0) {
      randomnum = randomint(2);
      break;
    }
  }

  if(!isDefined(randomnum)) {
    randomnum = randomint(3);
  }

  var_8ae7877c2831d687 = level.teamnamelist[randomnum];
  level.var_6298f362ec23d83.hunterteam = var_8ae7877c2831d687;
  level notify("warrior_hunt_teams_assigned");
}

function function_e03e8cb5b6e2a744() {
  level waittill("warrior_hunt_teams_assigned");

  if(isDefined(self.team) && self.team == level.var_6298f362ec23d83.hunterteam) {
    self setscriptablepartstate("slam_aura", "on", 0);
    scripts\cp_mp\equipment::giveequipment("equip_throwing_knife", "primary");
    thread waittill_grenade_fire();
    thread scripts\mp\hud_message::showsplash("warrior_hunt_hunter");
    return;
  }

  thread scripts\mp\hud_message::showsplash("warrior_hunt_runner");
}

function waittill_grenade_fire() {
  level endon("game_ended");
  level endon("round_end_finished");

  while(true) {
    self waittill("grenade_fire");
    scripts\cp_mp\equipment::giveequipment("equip_throwing_knife", "primary");
  }
}

function function_317ba71811b1e7a6(winner, endreasontext, nukedetonated) {
  var_3108b9677a26de05 = getteamdata(level.var_6298f362ec23d83.hunterteam, "aliveCount");
  var_bb4049867767c45f = getenemyteams(level.var_6298f362ec23d83.hunterteam);
  var_d09e9151997640d = getteamdata(var_bb4049867767c45f[0], "aliveCount") + getteamdata(var_bb4049867767c45f[0], "aliveCount");

  if(var_d09e9151997640d > 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(var_bb4049867767c45f[0], 1, 1);
    scripts\mp\gamescore::giveteamscoreforobjective(var_bb4049867767c45f[1], 1, 1);
    setscore = 1;
  } else if(var_3108b9677a26de05 > 0 && var_d09e9151997640d <= 0) {
    scripts\mp\gamescore::giveteamscoreforobjective(level.var_6298f362ec23d83.hunterteam, 1, 1);
    setscore = 1;
  } else {
    setscore = 0;
  }

  return setscore;
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  warrior::onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid);
  var_3108b9677a26de05 = getteamdata(level.var_6298f362ec23d83.hunterteam, "aliveCount");

  if(var_3108b9677a26de05 <= 0) {
    scripts\mp\gamelogic::endgame("tie", game["end_reason"]["enemies_eliminated"]);
  }
}

function teamoutcomenotify(winner, isround, endreasontext, endreasontextloss, roundendextramessage) {
  assertex(winner == "<dev string:x1c>", "<dev string:x23>");

  if(self.team == level.var_6298f362ec23d83.hunterteam) {
    self setclientomnvar("ui_round_end_title", game["round_end"]["round_loss"]);
    return;
  }

  self setclientomnvar("ui_round_end_title", game["round_end"]["round_win"]);
}