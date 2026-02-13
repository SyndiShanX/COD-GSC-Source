/****************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_patrol.gsc
****************************************************/

main() {
  _id_D795();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::bot_patrol_think;
  level._id_279D["should_start_cautious_approach"] = ::should_start_cautious_approach_patrol;
}

bot_patrol_think() {
  self notify("bot_patrol_think");
  self endon("bot_patrol_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self _meth_8054("separation", 0);
  self _meth_8054("grenade_objectives", 1);
  var_0 = undefined;

  for(;;) {
    if(getdvarint("#x39af27e2257d7e1b3")) {
      wait 0.05;
      continue;
    }

    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level._id_110CF) || !isDefined(level._id_AEE8) || !isDefined(level._id_110CF.trigger) || !isDefined(level._id_AF45)) {
      if(scripts\mp\bots\bots_util::_id_2801()) {
        _id_09F9::_id_2766();
      }

      self._id_41AD = undefined;
      self[[self._id_B025]]();
      continue;
    }

    if(!isDefined(var_0)) {
      var_0 = level._id_110CF.trigger._id_0359;
    }

    var_1 = 0;

    if(!scripts\mp\bots\bots_util::_id_2801()) {
      var_1 = 1;
    } else if(isDefined(self._id_412C) && distance(self._id_412C.origin, level._id_AF45.origin) > var_0) {
      var_1 = 1;
    } else if(isDefined(self._id_412D) && distance(self._id_412D, level._id_AF45.origin) > var_0) {
      var_1 = 1;
    }

    if(var_1) {
      _id_09F9::_id_2729(level._id_AF45.origin, var_0);
    }
  }
}

should_start_cautious_approach_patrol(var_0) {
  return 0;
}