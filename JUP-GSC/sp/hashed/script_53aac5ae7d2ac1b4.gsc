/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_53aac5ae7d2ac1b4.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace namespace_9e85c6b7b4fb5ff9;

function function_c31b39e6bb1bcd42() {
  self endon("death");
  self.ridingplayers = [];
  self.entstouching = [];
  prevonground = !self vehicle_isphysveh() || self vehicle_isonground();

  while(true) {
    validridingplayers = [];

    foreach(player in utility::playersnear(self.origin, 550)) {
      if(isDefined(player) && player _isalive() && isDefined(player.guid) && !player isvehicleactive() && isDefined(player getmovingplatformparent()) && player getmovingplatformparent() == self) {
        validridingplayers[player.guid] = 1;

        if(!isDefined(self.ridingplayers[player.guid])) {
          self.ridingplayers[player.guid] = player;
          function_153a6accf001dff6(player);
        }

        isininterior = function_3d25af3a88ad31c3(player);

        if(!istrue(player.var_54a215ef59a7a0c3) && isininterior) {
          function_3ffe455e5ea6d0f5(player);
        } else if(istrue(player.var_54a215ef59a7a0c3) && !isininterior) {
          function_b2cc563ed7324a8d(player);
        }

        player.var_54a215ef59a7a0c3 = isininterior;
      }
    }

    foreach(guid, player in self.ridingplayers) {
      if(!istrue(validridingplayers[guid])) {
        self.ridingplayers[guid] = undefined;
        function_71adb8f84c3df6bb(player);

        if(istrue(player.var_54a215ef59a7a0c3)) {
          function_b2cc563ed7324a8d(player);
        }

        if(isDefined(player)) {
          player.var_54a215ef59a7a0c3 = undefined;
        }
      }
    }

    onground = function_3a5fc0673be748ae();

    if(onground != prevonground) {
      if(!onground) {
        foreach(player in self.ridingplayers) {
          player vehicle_occupancy_startmovefeedbackforplayer();
        }
      } else {
        foreach(player in self.ridingplayers) {
          player vehicle_occupancy_stopmovefeedbackforplayer();
        }
      }
    }

    prevonground = onground;
    wait 0.25;
  }
}

function private function_3a5fc0673be748ae() {
  return !self vehicle_isphysveh() || self vehicle_isonground();
}

function function_153a6accf001dff6(player) {
  if(!function_3a5fc0673be748ae()) {
    player vehicle_occupancy_startmovefeedbackforplayer();
  }

  if(isDefined(self.onstartriding)) {
    self[[self.onstartriding]](player);
  }

  if(!istrue(self.var_9bd69326cfeb9fe9)) {
    scripts\cp_mp\utility\vehicle_omnvar_utility::function_d2d9c09551d91164(self, player);
  }

  if(!isDefined(level.var_b531611b8d662db7)) {
    level.var_b531611b8d662db7 = getdvarint(@ "hash_dee18061c0d4dfe", ter_op(scripts\cp_mp\utility\game_utility::isbrstylegametype(), 0, 1)) == 1;
  }

  if(!level.var_b531611b8d662db7) {
    return;
  }

  vehicleteam = vehicle_occupancy_getteamfriendlyto(self);

  if(isDefined(vehicleteam) && isDefined(player.team) && vehicleteam != "neutral" && vehicleteam != player.team && issharedfuncdefined("game", "onEnterOOBTrigger")) {
    player.var_1f34845fdd0a6631 = 1;
    self[[getsharedfunc("game", "onEnterOOBTrigger")]](self, player);
  } else {
    player.var_1f34845fdd0a6631 = undefined;
  }

  vehicle_spawn_stopwatchingabandoned();
}

function function_71adb8f84c3df6bb(player) {
  if(isDefined(player)) {
    player vehicle_occupancy_stopmovefeedbackforplayer();

    if(!isDefined(player.vehicle)) {
      scripts\cp_mp\utility\vehicle_omnvar_utility::function_5211953231a09ed5(self, player);
    }

    if(isDefined(self.onendriding)) {
      self[[self.onendriding]](player);
    }

    if(istrue(player.var_1f34845fdd0a6631) && isDefined(player.oob) && player.oob > 0 && issharedfuncdefined("game", "onExitOOBTrigger")) {
      self[[getsharedfunc("game", "onExitOOBTrigger")]](self, player);
    }
  }

  thread vehicle_spawn_watchabandoned();
}

function function_3ffe455e5ea6d0f5(player) {
  player setclienttriggeraudiozonepartial("iw9_palfa_interior", "reverb", "weapon_reflection");
  player notify("entered_vehicle_interior");
}

function function_b2cc563ed7324a8d(player) {
  if(isDefined(player)) {
    player clearclienttriggeraudiozone(0.5);
    player notify("exited_vehicle_interior");
  }
}

function function_3d25af3a88ad31c3(player) {
  if(!isDefined(self) || !isalive(self) || !isDefined(self.origin) || !isDefined(player) || !isDefined(player.origin)) {
    return 0;
  }

  return function_773691f1a617f7d9(player.origin);
}

function function_773691f1a617f7d9(origin) {
  forward = anglesToForward(self.angles);
  up = anglestoup(self.angles);
  toorigin = origin - self.origin;
  transform = coordtransformtranspose(origin, self.origin, self.angles);
  forwarddist = transform[0];
  sidedist = transform[1];
  verticaldist = transform[2];
  withinforward = forwarddist > -225 && forwarddist < 225;
  withinside = sidedist > -60 && sidedist < 60;
  withinvertical = verticaldist > -235 && verticaldist < -115;
  return withinforward && withinside && withinvertical;
}