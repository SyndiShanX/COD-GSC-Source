/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_rat.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\bots\_bot;
#using scripts\mp\gametypes\_dev;
#using scripts\shared\array_shared;
#using scripts\shared\rat_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace rat;

function autoexec __init__sytem__() {
  system::register("", & __init__, undefined, undefined);
}

function __init__() {
  rat_shared::init();
  level.rat.common.gethostplayer = & util::gethostplayer;
  level.rat.deathcount = 0;
  rat_shared::addratscriptcmd("", & rscaddenemy);
  setdvar("", 0);
}

function rscaddenemy(params) {
  player = [[level.rat.common.gethostplayer]]();
  team = "";
  if(isDefined(player.pers[""])) {
    team = util::getotherteam(player.pers[""]);
  }
  bot = dev::getormakebot(team);
  if(!isDefined(bot)) {
    println("");
    ratreportcommandresult(params._id, 0, "");
    return;
  }
  bot thread testenemy(team);
  bot thread deathcounter();
  wait(2);
  pos = (float(params.x), float(params.y), float(params.z));
  bot setorigin(pos);
  if(isDefined(params.ax)) {
    angles = (float(params.ax), float(params.ay), float(params.az));
    bot setplayerangles(angles);
  }
  ratreportcommandresult(params._id, 1);
}

function testenemy(team) {
  self endon("disconnect");
  while(!isDefined(self.pers[""])) {
    wait(0.05);
  }
  if(level.teambased) {
    self notify("menuresponse", game[""], team);
  }
}

function deathcounter() {
  self waittill("death");
  level.rat.deathcount++;
  setdvar("", level.rat.deathcount);
}