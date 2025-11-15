/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\zombies\_players.csc
*************************************************/

#include clientscripts\mp\_utility;
#include clientscripts\mp\_filter;
#include clientscripts\mp\_fx;
#include clientscripts\mp\_fxanim;
#include clientscripts\mp\_ambient;
#include clientscripts\mp\_rotating_object;

on_connect(localclientnum) {
  if(!sessionmodeiszombiesgame()) {
  }

  player = getlocalplayer(localclientnum);
  assert(isDefined(player));
  player setalphafadeforname(1.0);

  if(sessionmodeiszombiesgame()) {
    init_filter_hud_outline(player);
    init_filter_zm_turned(player);
    thread clientscripts\mp\_fx::fx_init(localclientnum);
  } else {
    thread clientscripts\mp\_fx::fx_init(localclientnum);
    thread clientscripts\mp\_fxanim::fxanim_init(localclientnum);
    thread clientscripts\mp\_ambient::ceiling_fans_init(localclientnum);
    thread clientscripts\mp\_ambient::clocks_init(localclientnum);
    thread clientscripts\mp\_ambient::spin_anemometers(localclientnum);
    thread clientscripts\mp\_rotating_object::init(localclientnum);
    init_code_filters(player);

    if(isDefined(level.infraredvisionset))
      player setinfraredvisionset(level.infraredvisionset);
  }

  if(isDefined(level.onplayerconnect))
    level thread[[level.onplayerconnect]](localclientnum);

  if(isDefined(level._customplayerconnectfuncs))
    [[level._customplayerconnectfuncs]](player, localclientnum);
}

dtp_effects() {
  self endon("entityshutdown");

  while(true) {
    self waittill("dtp_land", localclientnum);
    localplayer = getlocalplayer(localclientnum);

    if(!issplitscreen() && isDefined(localplayer) && localplayer == self) {
      if(isDefined(level.iswinter) && level.iswinter)
        animateui(localclientnum, "fullscreen_snow", "dirt", "in", 0);
      else
        animateui(localclientnum, "fullscreen_dirt", "dirt", "in", 0);
    }
  }
}