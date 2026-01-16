/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_perk_paranoia.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace wz_perk_paranoia;

autoexec __init__system__() {
  system::register(#"wz_perk_paranoia", &__init__, undefined, undefined);
}

__init__() {
  callback::function_930e5d42(&function_930e5d42);
}

function_930e5d42(localclientnum) {
  if(self function_da43934d()) {
    var_369be743 = self hasperk(localclientnum, #"specialty_paranoia");
    var_7c49d38b = self.var_369be743 !== var_369be743;

    if(var_7c49d38b) {
      self thread function_3e9077b(localclientnum);
    }

    self.var_369be743 = var_369be743;
  }
}

private function_dbd63244() {
  assert(isplayer(self));

  if(self function_da43934d()) {
    return self getEye();
  }

  stance = self getstance();

  switch (stance) {
    case #"prone":
      return (self.origin + (0, 0, 11));
    case #"crouch":
      return (self.origin + (0, 0, 40));
    case #"stand":
      return (self.origin + (0, 0, 60));
    default:
      return (self.origin + (0, 0, 60));
  }
}

private function_c9d3a835() {
  return self.origin + (0, 0, 36);
}

private function_3e9077b(localclientnum) {
  level endon(#"game_ended");
  self endon(#"disconnect", #"shutdown", #"death");
  self notify("1cd9d4f64a9f9459");
  self endon("1cd9d4f64a9f9459");

  if(!self hasperk(localclientnum, #"specialty_paranoia")) {
    return;
  }

  var_81f254ba = cos(10);

  while(true) {
    var_7cefa3dc = undefined;
    players = getplayers(localclientnum);

    foreach(player in players) {
      if(!isDefined(player)) {
        continue;
      }

      if(player == self) {
        continue;
      }

      if(!isalive(player)) {
        continue;
      }

      if(!player util::isenemyteam(self.team)) {
        continue;
      }

      if(isDefined(player function_bee2bbc7()) && player function_bee2bbc7()) {
        continue;
      }

      if(!(isDefined(player isplayerads()) && player isplayerads())) {
        continue;
      }

      player_eye_pos = player function_dbd63244();
      var_2cb75b52 = self function_c9d3a835();
      to_self = var_2cb75b52 - player_eye_pos;

      if(lengthsquared(to_self) > 21600 * 21600) {
        continue;
      }

      player_angles = player getplayerangles();
      player_forward = anglesToForward(player_angles);
      var_e1a2a16a = vectornormalize(to_self);

      if(vectordot(player_forward, var_e1a2a16a) < var_81f254ba) {
        continue;
      }

      test_points = [];

      if(!isDefined(test_points)) {
        test_points = [];
      } else if(!isarray(test_points)) {
        test_points = array(test_points);
      }

      test_points[test_points.size] = self.origin + (0, 0, 11);

      if(!isDefined(test_points)) {
        test_points = [];
      } else if(!isarray(test_points)) {
        test_points = array(test_points);
      }

      test_points[test_points.size] = self.origin + (0, 0, 40);

      if(!isDefined(test_points)) {
        test_points = [];
      } else if(!isarray(test_points)) {
        test_points = array(test_points);
      }

      test_points[test_points.size] = self.origin + (0, 0, 60);
      los = 0;

      foreach(test_point in test_points) {
        trace_dist = length(to_self) + 100;
        trace_end = test_point + vectorscale(player_forward, trace_dist * -1);
        trace = bulletTrace(test_point, trace_end, 1, self);

        if(trace[#"fraction"] < 1 && trace[#"entity"] === player) {
          los = 1;
          break;
        }
      }

      if(los) {
        var_7cefa3dc = #"hash_56f62705c6a2bcb6";
        break;
      }

      waitframe(1);
    }

    if(isDefined(var_7cefa3dc) && isDefined(player)) {
      var_2b836fea = player playSound(localclientnum, var_7cefa3dc);

      while(soundplaying(var_2b836fea)) {
        waitframe(1);
      }

      wait randomfloat(1);
    }

    waitframe(1);
  }
}