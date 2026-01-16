/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\rat.gsc
***********************************************/

#include scripts\core_common\bots\bot;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\rat_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\dev;
#include scripts\mp_common\util;

#namespace rat;

autoexec __init__system__() {
  system::register(#"rat", &__init__, undefined, undefined);
}

__init__() {
  init();
  level.rat.common.gethostplayer = &util::gethostplayer;
  level.rat.deathcount = 0;
  addratscriptcmd("<dev string:x38>", &rscaddenemy);
  addratscriptcmd("<dev string:x43>", &function_50634409);
  setdvar(#"rat_death_count", 0);
}

function_50634409(params) {
  player = util::gethostplayerforbots();
  setdvar(#"bot_allowmovement", 0);
  setdvar(#"bot_pressattackbtn", 0);
  setdvar(#"bot_pressmeleebtn", 0);
  setdvar(#"scr_botsallowkillstreaks", 0);
  setdvar(#"bot_allowgrenades", 0);
  team = bot::devgui_relative_team(player, "<dev string:x53>");
  bot = level bot::add_bot(team);
}

rscaddenemy(params) {
  player = [[level.rat.common.gethostplayer]]();
  team = #"axis";

  if(isDefined(player.pers[#"team"])) {
    team = util::getotherteam(player.pers[#"team"]);
  }

  bot = dev::getormakebot(team);

  if(!isDefined(bot)) {
    println("<dev string:x5b>");
    ratreportcommandresult(params._id, 0, "<dev string:x5b>");
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

testenemy(team) {
  self endon(#"disconnect");

  while(!isDefined(self.pers[#"team"])) {
    waitframe(1);
  }

  if(level.teambased) {
    params = {
      #menu: game.menu[#"menu_team"], 
      #response: level.teams[team], 
      #intpayload: 0
    };
    self notify(#"menuresponse", params);
    self callback::callback(#"menu_response", params);
  }
}

deathcounter() {
  self waittill(#"death");
  level.rat.deathcount++;
  setdvar(#"rat_death_count", level.rat.deathcount);
}

