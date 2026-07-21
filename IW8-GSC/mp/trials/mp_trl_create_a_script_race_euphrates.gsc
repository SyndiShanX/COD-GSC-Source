/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_trl_create_a_script_race_euphrates.gsc
***************************************************************/

_id_134AC(var_0, var_1, var_2) {
  var_3 = self._blackboard.throwdata;
  self.ispreppinggrenade = 1;
  var_4 = _id_134C2(var_0, var_1, var_3);

  if(!var_4) {
    self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
    wait 0.2;
    scripts\asm\asm::asm_fireevent(var_0, "_encstr_961804BD954A");
  }
}

_id_134C2(var_0, var_1, var_2, var_3) {
  var_4 = var_2.destination;
  var_5 = var_2.target;
  var_6 = var_2.withbounce;

  if(!isDefined(var_6))
    var_6 = 1;

  if(isDefined(var_4)) {
    var_7 = scripts\asm\soldier\throwgrenade::getgrenadethrowoffset(var_1, var_2.xanim);

    if(!isDefined(var_2.fastthrow))
      var_8 = self checkgrenadethrowpos(var_7, var_4, var_6, "_encstr_A9230BE827EE79B392375EEC08", "_encstr_8EFC096DD3700EDBBBB84A", "_encstr_88E209ABB792BA5BA83D2D");
    else
      var_8 = self checkgrenadethrowpos(var_7, var_4, var_6, "_encstr_8EFC096DD3700EDBBBB84A", "_encstr_A9230BE827EE79B392375EEC08");
  } else
    var_8 = var_2.vel;

  var_5 = var_2.target;

  if(isDefined(var_8)) {
    if(!isDefined(self.oldgrenawareness))
      self.oldgrenawareness = self.grenadeawareness;

    self.grenadeawareness = 0;
    var_9 = reset_progress();
    scripts\asm\soldier\throwgrenade::setgrenadetimer(self.activegrenadetimer, min(gettime() + 3000, var_9));
    var_10 = 0;

    if(scripts\asm\soldier\throwgrenade::usingplayergrenadetimer()) {
      var_5.numgrenadesinprogresstowardsplayer++;
      thread scripts\asm\soldier\throwgrenade::reducegiptponkillanimscript(var_1, var_5);

      if(var_5.numgrenadesinprogresstowardsplayer > 1)
        var_10 = 1;

      if(self.activegrenadetimer.timername == "_encstr_95810C99C9C2ECCEC9B2DCC246CA") {
        if(var_5.numgrenadesinprogresstowardsplayer <= 1)
          var_5.lastfraggrenadetoplayerstart = gettime();
      }
    }

    if(isDefined(var_3))
      thread scripts\asm\soldier\throwgrenade::dogrenadethrow(var_0, var_1, var_2.xanim, var_8, var_9, var_10);
    else
      scripts\asm\soldier\throwgrenade::dogrenadethrow(var_0, var_1, var_2.xanim, var_8, var_9, var_10);

    return 1;
  } else {}

  return 0;
}

reset_progress() {
  var_0 = undefined;

  if(scripts\asm\soldier\throwgrenade::usingplayergrenadetimer()) {
    var_1 = self.activegrenadetimer.player;
    var_0 = gettime() + var_1.gs.playergrenadebasetime + randomint(var_1.gs.playergrenaderangetime);
  } else if(isDefined(self.set_disable_leave_truck) && isDefined(self.set_disable_leave_truck[self.activegrenadetimer.timername]))
    var_0 = gettime() + 3000 + self.set_disable_leave_truck[self.activegrenadetimer.timername];
  else
    var_0 = gettime() + 30000 + randomint(30000);

  return var_0;
}