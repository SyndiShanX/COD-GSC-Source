/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_flareweapon.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

init() {
  level.flarevisioneffectradius = flare_get_dvar_int("flare_effect_radius", "400");
  level.flareduration = flare_get_dvar_int("flare_duration", "8");
  level.flaredistancescale = flare_get_dvar_int("flare_distance_scale", "16");
  level.flarelookawayfadewait = flare_get_dvar("flareLookAwayFadeWait", "0.45");
  level.flareburnoutfadewait = flare_get_dvar("flareBurnOutFadeWait", "0.65");
}

watchflaredetonation(owner) {
  self waittill("explode", position);
  level.flarevisioneffectradius = flare_get_dvar_int("flare_effect_radius", level.flarevisioneffectradius);
  durationofflare = flare_get_dvar_int("flare_duration", level.flareduration);
  level.flaredistancescale = flare_get_dvar_int("flare_distance_scale", level.flaredistancescale);
  flareeffectarea = spawn("trigger_radius", position, 0, level.flarevisioneffectradius, level.flarevisioneffectradius * 2);

  while(durationofflare > 0) {
    players = get_players();

    for(i = 0; i < players.size; i++) {
      if(!isDefined(players[i].item))
        players[i].item = 0;

      if(!isDefined(players[i].inflarevisionarea) || players[i].inflarevisionarea == 0) {
        if(players[i].sessionstate == "playing") {
          players[i].item = players[i] playersighttrace(position, level.flarevisioneffectradius, players[i].item);

          if(players[i].item == 0) {
            players[i].lastflaredby = owner;
            thread flarevision(players[i], flareeffectarea, position);
          }
        }
      }
    }

    wait 0.5;
    durationofflare = durationofflare - 0.5;
  }

  flareeffectarea delete();
}

flarevision(player, flareeffectarea, position) {
  player endon("disconnect");
  player notify("flareVision");
  player endon("flareVision");
  player.inflarevisionarea = 1;
  count = 0;
  maxdistance = level.flarevisioneffectradius;

  while(isDefined(flareeffectarea) && (player.sessionstate == "playing" && player.item == 0)) {
    wait 0.05;
    ratio = 1 - distance(player.origin, position) / maxdistance;
    player visionsetlerpratio(ratio);

    if(count * 0.05 > 0.3) {
      player.item = player playersighttrace(position, level.flarevisioneffectradius, player.item);
      count = 0;
    }

    count++;
  }

  if(!isDefined(flareeffectarea))
    wait(flare_get_dvar("flareBurnOutFadeWait", level.flareburnoutfadewait));
  else if(distancesquared(position, player.origin) < level.flarevisioneffectradius * level.flarevisioneffectradius)
    wait(flare_get_dvar("flareLookAwayFadeWait", level.flarelookawayfadewait));

  player.inflarevisionarea = 0;
  player visionsetlerpratio(0);
}

flare_get_dvar_int(dvar, def) {
  return int(flare_get_dvar(dvar, def));
}

flare_get_dvar(dvar, def) {
  if(getdvar(dvar) != "")
    return getdvarfloat(dvar);
  else {
    setdvar(dvar, def);
    return def;
  }
}

player_is_driver() {
  if(ismp()) {
    if(!isalive(self))
      return false;

    vehicle = self getvehicleoccupied();

    if(isDefined(vehicle)) {
      seat = vehicle getoccupantseat(self);

      if(isDefined(seat) && seat == 0)
        return true;
    }
  }

  return false;
}