/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_grnd.gsc
**************************************************/

main() {
  _id_D795();
  _id_D772();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_27E2;
}

_id_D772() {
  scripts\mp\bots\bots_util::_id_291B(1);
  level._id_BDBF = 128;
  level._id_27B0 = 1;
}

_id_27E2() {
  self notify("bot_grnd_think");
  self endon("bot_grnd_think");
  self endon("death_or_disconnect");
  level endon("game_ended");
  self _meth_802B();

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self _meth_8054("separation", 0);
  thread _id_38C6();

  for(;;) {
    wait 0.05;

    if(_id_09F9::_id_27ED()) {
      continue;
    }
    if(!self _meth_8042()) {
      var_0 = _id_6BA0();

      if(isDefined(var_0)) {
        self _meth_8058(var_0.origin, 0, "objective");
      }

      continue;
    }

    if(!scripts\mp\bots\bots_util::_id_2805()) {
      self _meth_802B();
      var_0 = _id_6BA0();

      if(isDefined(var_0)) {
        _id_09F9::_id_2899(var_0.origin, level._id_BDBF);
      }
    }
  }
}

_id_38C6() {
  for(;;) {
    level waittill("zone_reset");

    if(scripts\mp\bots\bots_util::_id_2805()) {
      _id_09F9::_id_2766();
    }
  }
}

_id_6BA0() {
  var_0 = _func_00B6(level._id_110CF.trigger);

  if(var_0.size == 0 || !isDefined(var_0)) {
    return undefined;
  }

  var_1 = randomintrange(0, var_0.size);
  var_2 = var_0[var_1];
  return var_2;
}

_id_F044() {}