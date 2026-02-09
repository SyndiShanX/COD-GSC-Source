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

  setDvar(#"sv_hostname", level.hostname);
  setDvar(#"ui_hostname", level.hostname);
  level.motd = getdvarstring(#"scr_motd");

  if(level.motd == "") {
    level.motd = "";
  }

  setDvar(#"scr_motd", level.motd);
  setDvar(#"ui_motd", level.motd);
  level.allowvote = getdvarint(#"g_allowvote", 1);
  setDvar(#"g_allowvote", level.allowvote);
  setDvar(#"ui_allowvote", level.allowvote);
  level.allow_teamchange = 0;

  if(sessionmodeisprivate() || !sessionmodeisonlinegame()) {
    level.allow_teamchange = 1;
  }

  setDvar(#"ui_allow_teamchange", level.allow_teamchange);
  level.friendlyfire = getgametypesetting(#"zmfriendlyfiretype");
  setDvar(#"ui_friendlyfire", level.friendlyfire);

  if(!isDefined(getDvar(#"scr_mapsize"))) {
    setDvar(#"scr_mapsize", 64);
  } else if(getdvarfloat(#"scr_mapsize", 0) >= 64) {
    setDvar(#"scr_mapsize", 64);
  } else if(getdvarfloat(#"scr_mapsize", 0) >= 32) {
    setDvar(#"scr_mapsize", 32);
  } else if(getdvarfloat(#"scr_mapsize", 0) >= 16) {
    setDvar(#"scr_mapsize", 16);
  } else {
    setDvar(#"scr_mapsize", 8);
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
    setDvar(#"ui_hostname", level.hostname);
  }

  scr_motd = getdvarstring(#"scr_motd");

  if(level.motd != scr_motd) {
    level.motd = scr_motd;
    setDvar(#"ui_motd", level.motd);
  }

  g_allowvote = getdvarstring(#"g_allowvote");

  if(level.allowvote != g_allowvote) {
    level.allowvote = g_allowvote;
    setDvar(#"ui_allowvote", level.allowvote);
  }

  scr_friendlyfire = getgametypesetting(#"zmfriendlyfiretype");

  if(level.friendlyfire != scr_friendlyfire) {
    level.friendlyfire = scr_friendlyfire;
    zm_custom::function_928be07c();
    setDvar(#"ui_friendlyfire", level.friendlyfire);
  }
}