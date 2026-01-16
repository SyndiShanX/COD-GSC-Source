/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\bots\_bot.gsc
*************************************************/

#using scripts\shared\bots\_bot;
#using scripts\shared\bots\_bot_combat;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#namespace bot;

function autoexec __init__sytem__() {
  system::register("bot_cp", & __init__, undefined, undefined);
}

function __init__() {
  level.onbotconnect = & on_bot_connect;
  level.getbotthreats = & bot_combat::get_ai_threats;
  level.botprecombat = & coop_pre_combat;
  level.botpostcombat = & coop_post_combat;
  level.botidle = & follow_coop_players;
  level.botdevguicmd = & coop_bot_devgui_cmd;
}

function on_bot_connect() {
  self endon("disconnect");
  wait(0.25);
  self notify("menuresponse", "", "");
  wait(0.25);
  if(isdefined(self.pers)) {
    self.bcvoicenumber = self.pers[""];
  }
}