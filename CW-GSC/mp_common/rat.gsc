/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\rat.gsc
***********************************************/

#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\dev;
#using scripts\mp_common\util;
#namespace rat;

function private autoexec __init__system__() {
  system::register(#"rat", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init();
  level.rat.common.gethostplayer = &util::gethostplayer;
  level.rat.deathcount = 0;
  addratscriptcmd("<dev string:x38>", &rscaddenemy);
  addratscriptcmd("<dev string:x44>", &function_50634409);
  setDvar(#"rat_death_count", 0);
}

function function_50634409(params) {
  player = util::gethostplayerforbots();
  team = player.team == # "allies" ? # "axis" : # "allies";
  bot = level bot::add_bot(team);

  if(isDefined(bot)) {
    bot.ignoreall = 1;
  }
}

function rscaddenemy(params) {
  player = [[level.rat.common.gethostplayer]]();
  team = # "axis";

  if(isDefined(player.pers[# "team"])) {
    team = util::getotherteam(player.pers[# "team"]);
  }

  bot = dev::getormakebot(team);

  if(!isDefined(bot)) {
    println("<dev string:x55>");
    ratreportcommandresult(params._id, 0, "<dev string:x55>");
    return;
  }

  bot thread testenemy(team);
  bot thread deathcounter();
  wait 2;
  pos = (float(params.x), float(params.y), float(params.z));
  bot setorigin(pos);

  if(isDefined(params.ax)) {
    angles = (float(params.ax), float(params.ay), float(params.az));
    bot setplayerangles(angles);
  }

  ratreportcommandresult(params._id, 1);
}

function testenemy(team) {
  self endon(#"disconnect");

  while(!isDefined(self.pers[# "team"])) {
    waitframe(1);
  }

  if(level.teambased) {
    params = {
      #menu: game.menu[# "menu_team"], #response: level.teams[team], #intpayload: 0
    };
    self notify(#"menuresponse", params);
    self callback::callback(#"menu_response", params);
  }
}

function deathcounter() {
  self waittill(#"death");
  level.rat.deathcount++;
  setDvar(#"rat_death_count", level.rat.deathcount);
}