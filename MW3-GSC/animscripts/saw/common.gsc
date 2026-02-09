/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\saw\common.gsc
**************************************/

main(var_0) {
  self endon("killanimscript");
  animscripts\utility::_id_0D15("saw");

  if(!isDefined(var_0)) {
    return;
  }
  self.a._id_0D19 = "saw";

  if(isDefined(var_0.script_delay_min)) {
    var_1 = var_0.script_delay_min;
  } else {
    var_1 = maps\_mgturret::_id_2277("delay");
  }
  if(isDefined(var_0.script_delay_max)) {
    var_2 = var_0.script_delay_max - var_1;
  } else {
    var_2 = maps\_mgturret::_id_2277("delay_range");
  }
  if(isDefined(var_0._id_2279)) {
    var_3 = var_0._id_2279;
  } else {
    var_3 = maps\_mgturret::_id_2277("burst");
  }
  if(isDefined(var_0._id_227A)) {
    var_4 = var_0._id_227A - var_3;
  } else {
    var_4 = maps\_mgturret::_id_2277("burst_range");
  }
  var_5 = gettime();
  var_6 = "start";
  animscripts\shared::_id_0C9B(self.weapon, "none");
  var_0 show();

  if(isDefined(var_0._id_0FA3)) {
    self.a._id_20AD = ::_id_20AD;
    self.a._id_20FA = var_0;
    var_0 notify("being_used");
    thread _id_6477();
  } else {
    self.a._id_20AD = ::_id_6479;
  }
  var_0._id_488B = 0;
  thread _id_6476(var_0);
  self setturretanim(self._id_4888);
  self setanimknobrestart(self._id_4888, 1, 0.2, 1);
  self setanimknoblimitedrestart(self._id_48B8);
  self setanimknoblimitedrestart(self._id_48B4);
  var_0 setanimknoblimitedrestart(var_0._id_48B8);
  var_0 setanimknoblimitedrestart(var_0._id_48B4);
  var_0 endon("death");

  for(;;) {
    if(var_0._id_488B) {
      thread _id_227C(var_0);
      _id_6475(randomfloatrange(var_3, var_3 + var_4), var_0);
      var_0 notify("turretstatechange");

      if(var_0._id_488B) {
        thread _id_48B6(var_0);
        wait(randomfloatrange(var_1, var_1 + var_2));
      }

      continue;
    }

    thread _id_48B6(var_0);
    var_0 waittill("turretstatechange");
  }
}

_id_6475(var_0, var_1) {
  var_1 endon("turretstatechange");
  wait(var_0);
}

_id_6476(var_0) {
  self endon("killanimscript");
  var_1 = cos(15);

  for(;;) {
    while(isDefined(self.enemy)) {
      var_2 = self.enemy.origin;
      var_3 = var_0 gettagangles("tag_aim");

      if(within_fov(var_0.origin, var_3, var_2, var_1) || distancesquared(var_0.origin, var_2) < 40000) {
        if(!var_0._id_488B) {
          var_0._id_488B = 1;
          var_0 notify("turretstatechange");
        }
      } else if(var_0._id_488B) {
        var_0._id_488B = 0;
        var_0 notify("turretstatechange");
      }

      wait 0.05;
    }

    if(var_0._id_488B) {
      var_0._id_488B = 0;
      var_0 notify("turretstatechange");
    }

    wait 0.05;
  }
}

_id_2282(var_0, var_1) {
  if(var_0 <= 0) {
    return;
  }
  self endon("killanimscript");
  var_1 endon("turretstatechange");
  wait(var_0);
  var_1 notify("turretstatechange");
}

_id_6477() {
  self endon("killanimscript");

  for(;;) {
    if(!isDefined(self.node) || distancesquared(self.origin, self.node.origin) > 4096) {
      self stopuseturret();
    }
    wait 0.25;
  }
}

_id_20AD(var_0) {
  if(var_0 == "pain") {
    if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096) {
      self.a._id_20FA hide();
      animscripts\shared::_id_0C9B(self.weapon, "right");
      self.a._id_20AD = ::_id_6478;
      return;
    } else {
      self stopuseturret();
    }
  }

  if(var_0 == "saw") {
    var_1 = self getturret();
    return;
  }

  self.a._id_20FA delete();
  self.a._id_20FA = undefined;
  animscripts\shared::_id_0C9B(self.weapon, "right");
}

_id_6478(var_0) {
  if(!isDefined(self.node) || distancesquared(self.origin, self.node.origin) > 4096) {
    self stopuseturret();
    self.a._id_20FA delete();
    self.a._id_20FA = undefined;

    if(isDefined(self.weapon) && self.weapon != "none") {
      animscripts\shared::_id_0C9B(self.weapon, "right");
    }
  } else if(var_0 != "saw") {
    self.a._id_20FA delete();
  }
}

_id_6479(var_0) {
  animscripts\shared::_id_0C9B(self.weapon, "right");
}

within_fov(var_0, var_1, var_2, var_3) {
  var_4 = vectornormalize(var_2 - var_0);
  var_5 = anglesToForward(var_1);
  var_6 = vectordot(var_5, var_4);
  return var_6 >= var_3;
}

#using_animtree("generic_human");

_id_227C(var_0) {
  self setanim(%additive_saw_idle, 0, 0.1);
  self setanim(%additive_saw_fire, 1, 0.1);
  var_0 _id_647B();
  _id_647A(var_0);
}

_id_48B6(var_0) {
  self setanim(%additive_saw_idle, 1, 0.1);
  self setanim(%additive_saw_fire, 0, 0.1);
  var_0 _id_647C();
}

_id_647A(var_0) {
  self endon("killanimscript");
  var_0 endon("turretstatechange");

  for(;;) {
    var_0 shootturret();
    wait 0.1;
  }
}

#using_animtree("mg42");

_id_647B() {
  self setanim(%additive_saw_idle, 0, 0.1);
  self setanim(%additive_saw_fire, 1, 0.1);
}

_id_647C() {
  self setanim(%additive_saw_idle, 1, 0.1);
  self setanim(%additive_saw_fire, 0, 0.1);
}