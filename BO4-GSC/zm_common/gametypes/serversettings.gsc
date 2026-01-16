/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\serversettings.gsc
**************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_customgame;

#namespace serversettings;

autoexec __init__system__() {
  system::register(#"serversettings", &__init__, undefined, undefined);
}

__init__() {
  callback::on_start_gametype(&main);
}

main() {
  level.hostname = getdvarstring(#"sv_hostname");

  if(level.hostname == "") {
    level.hostname = "CoDHost";
  }

  setdvar(#"sv_hostname", level.hostname);
  setdvar(#"ui_hostname", level.hostname);
  level.motd = getdvarstring(#"scr_motd");

  if(level.motd == "") {
    level.motd = "";
  }

  setdvar(#"scr_motd", level.motd);
  setdvar(#"ui_motd", level.motd);
  level.allowvote = getdvarint(#"g_allowvote", 1);
  setdvar(#"g_allowvote", level.allowvote);
  setdvar(#"ui_allowvote", level.allowvote);
  level.allow_teamchange = 0;

  if(sessionmodeisprivate() || !sessionmodeisonlinegame()) {
    level.allow_teamchange = 1;
  }

  setdvar(#"ui_allow_teamchange", level.allow_teamchange);
  level.friendlyfire = getgametypesetting(#"zmfriendlyfiretype");
  setdvar(#"ui_friendlyfire", level.friendlyfire);

  if(!isDefined(getdvar(#"scr_mapsize"))) {
    setdvar(#"scr_mapsize", 64);
  } else if(getdvarfloat(#"scr_mapsize", 0) >= 64) {
    setdvar(#"scr_mapsize", 64);
  } else if(getdvarfloat(#"scr_mapsize", 0) >= 32) {
    setdvar(#"scr_mapsize", 32);
  } else if(getdvarfloat(#"scr_mapsize", 0) >= 16) {
    setdvar(#"scr_mapsize", 16);
  } else {
    setdvar(#"scr_mapsize", 8);
  }

  for(;;) {
    updateserversettings();
    wait 5;
  }
}

updateserversettings() {
  sv_hostname = getdvarstring(#"sv_hostname");

  if(level.hostname != sv_hostname) {
    level.hostname = sv_hostname;
    setdvar(#"ui_hostname", level.hostname);
  }

  scr_motd = getdvarstring(#"scr_motd");

  if(level.motd != scr_motd) {
    level.motd = scr_motd;
    setdvar(#"ui_motd", level.motd);
  }

  g_allowvote = getdvarstring(#"g_allowvote");

  if(level.allowvote != g_allowvote) {
    level.allowvote = g_allowvote;
    setdvar(#"ui_allowvote", level.allowvote);
  }

  scr_friendlyfire = getgametypesetting(#"zmfriendlyfiretype");

  if(level.friendlyfire != scr_friendlyfire) {
    level.friendlyfire = scr_friendlyfire;
    zm_custom::function_928be07c();
    setdvar(#"ui_friendlyfire", level.friendlyfire);
  }
}