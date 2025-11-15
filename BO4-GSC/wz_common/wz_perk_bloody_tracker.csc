/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_perk_bloody_tracker.csc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;

#namespace wz_perk_bloody_tracker;

autoexec __init__system__() {
  system::register(#"wz_perk_bloody_tracker", &__init__, undefined, undefined);
}

__init__() {
  if(!(isDefined(getgametypesetting(#"hash_1d02e28ba907a343")) && getgametypesetting(#"hash_1d02e28ba907a343"))) {
    return;
  }

  callback::on_localclient_connect(&on_player_connect);
}

on_player_connect(localclientnum) {
  level thread bloody_tracker(localclientnum);
}

bloody_tracker(localclientnum) {
  while(true) {
    wait 0.2;

    if(!function_5778f82(localclientnum, #"specialty_tracker")) {
      continue;
    }

    origin = getlocalclientpos(localclientnum);
    players = getplayers(localclientnum);
    players = arraysortclosest(players, origin, undefined, 1, 6000);
    tracked = 0;

    foreach(player in players) {
      if(tracked >= 10 || !isalive(player) || player function_83973173() || isDefined(getplayervehicle(player))) {
        player.tracker_last_pos = undefined;
        continue;
      }

      tracked++;

      if(!isDefined(player.tracker_last_pos)) {
        player.tracker_last_pos = player.origin;
      }

      positionandrotationstruct = player gettrackerfxposition(localclientnum);

      if(isDefined(positionandrotationstruct)) {
        player tracker_playFX(localclientnum, positionandrotationstruct);
      }
    }

    players = undefined;
  }
}

gettrackerfxposition(localclientnum) {
  positionandrotation = undefined;
  player = self;
  offset = (0, 0, 1);
  dist2 = 1024;

  if(isDefined(self.trailrightfoot) && self.trailrightfoot) {
    fx = "player/fx8_plyr_footstep_tracker_blood_r";
  } else {
    fx = "player/fx8_plyr_footstep_tracker_blood_l";
  }

  pos = self.origin + offset;

  if(distancesquared(self.tracker_last_pos, pos) > dist2) {
    trace = physicstraceex(pos, pos + (0, 0, -10), (0, 0, 0), (0, 0, 0), self, 1);

    if(trace[#"fraction"] < 1) {
      up = trace[#"normal"];
      up = (0, 0, 0) - up;

      if(lengthsquared(up) <= 0) {
        return undefined;
      }

      fwd = anglesToForward(self.angles);
      vel = self getvelocity();

      if(lengthsquared(vel) > 1) {
        fwd = vel;
      }

      right = vectorcross(fwd, up);

      if(lengthsquared(right) <= 0) {
        return undefined;
      }

      fwd = vectorcross(up, right);
      pos = trace[#"position"] + trace[#"normal"];
      positionandrotation = spawnStruct();
      positionandrotation.fx = fx;
      positionandrotation.pos = pos;
      positionandrotation.fwd = fwd;
      positionandrotation.up = up;
      self.tracker_last_pos = self.origin;

      if(isDefined(self.trailrightfoot) && self.trailrightfoot) {
        self.trailrightfoot = 0;
      } else {
        self.trailrightfoot = 1;
      }
    }
  }

  return positionandrotation;
}

tracker_playFX(localclientnum, positionandrotationstruct) {
  handle = playFX(localclientnum, positionandrotationstruct.fx, positionandrotationstruct.pos, positionandrotationstruct.fwd, positionandrotationstruct.up);
}