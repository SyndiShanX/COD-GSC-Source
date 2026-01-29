/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\hummer_turret\common.gsc
************************************************/

_id_4885(var_0, var_1) {
  self endon("killanimscript");
  animscripts\utility::_id_0D15(var_1);
  self._id_10EF = 1;
  self._id_2145 = 1;
  self.a._id_0D2B = "stop";
  self.a._id_0D19 = var_1;
  self.a._id_20FA = var_0;
  self.ignoreme = 1;

  if(isDefined(self._id_4886)) {
    self.ignoreme = self._id_4886;

  }
  self._id_4887 = 0;
  self setturretanim(self._id_4888);
  self setanimknobrestart(self._id_4888, 1, 0.2, 1);

  if(isDefined(self.weapon)) {
    animscripts\shared::_id_0C9B(self.weapon, "none");

  }
  self._id_257E = 1;
  self._id_0EED = ::_id_4895;
  self notify("guy_man_turret_stop");
  var_0 notify("stop_burst_fire_unmanned");
  var_0._id_4889 = "start";
  var_0._id_0FA3 = self;
  var_0._id_488A = 0;
  var_0 setmode("sentry");
  var_0 setsentryowner(self);
  var_0 setdefaultdroppitch(0);
  var_0 setturretcanaidetach(0);
  _id_488C();
  level thread _id_488F(self, var_0);
  level thread _id_4893(self, var_0);
  var_0 thread _id_48A0(self);
  var_0._id_488B = 0;
  thread _id_48AE(var_0);
  wait 0.05;

  if(isalive(self)) {
    thread _id_48A3(var_0);
  }
}

_id_488C() {
  self.allowpain = 0;
  maps\_utility::_id_1058(1);
  self._id_488D = self.health;
  self.health = 200;
}

_id_488E() {
  self.allowpain = 1;
  maps\_utility::_id_1058(0);
  self.health = self._id_488D;
}

_id_488F(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  var_0 endon("dismount");
  var_0 endon("jumping_out");

  for(;;) {
    var_2 = "flashbang";
    var_3 = var_0 common_scripts\utility::waittill_any_return("damage", var_2);
    var_4 = common_scripts\utility::random(var_0._id_4890);

    if(var_3 == var_2) {
      var_4 = var_0._id_4891;
      var_0 animscripts\face::_id_0C41("flashbang");
    }

    var_0 _id_48C0(var_1, var_4, 0);
    var_1 notify("pain_done");
  }
}

_id_4892() {
  _id_48C3();
  self waittill("pain_done");
  _id_48C6();
}

_id_4893(var_0, var_1) {
  var_0 endon("dismount");
  var_1 endon("turret_cleanup");
  var_0._id_0D50 = var_0._id_4894;
  var_0._id_0EC6 = 1;
  var_0 waittill("death");
  level thread _id_4897(var_0, var_1);
}

_id_4895() {
  var_0 = self._id_0EF1.mgturret[0];

  if(isalive(self)) {
    self._id_10EF = undefined;
    self._id_2145 = undefined;
    self.ignoreme = 0;
    self.a._id_0D19 = "none";
    self.a._id_20FA = undefined;
    self._id_0D50 = undefined;
    _id_488E();
    self._id_4887 = undefined;
    self._id_4896 = undefined;
    self._id_4890 = undefined;
    self._id_257E = undefined;
    self._id_0EED = undefined;
    self stopuseturret();

    if(isDefined(self.weapon)) {
      animscripts\shared::_id_0C9B(self.weapon, "right");
    }
  }

  level thread _id_4897(self, var_0);
}

_id_4897(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 notify("kill_fireController");
  var_1 notify("turret_cleanup");
  var_1 setmode("manual");
  var_1 cleartargetentity();
  var_1 setdefaultdroppitch(var_1._id_4898);

  if(isDefined(var_0)) {
    var_0 clearanim(var_0._id_4899, 0);
    var_0 clearanim(var_0._id_489A, 0);
    var_0 clearanim(var_0._id_489B, 0);
  }

  var_1._id_489C = undefined;
  var_1._id_489D = undefined;
  var_1._id_489E = undefined;
  var_1._id_4889 = "free";
  var_1._id_0FA3 = undefined;
  var_1._id_488A = undefined;

  if(isDefined(var_1._id_489F)) {
    level[[var_1._id_489F]](var_0, var_1);
  }
}

_id_48A0(var_0) {
  self endon("turret_cleanup");
  self endon("death");
  var_0 endon("death");
  var_0 endon("detach");
  var_1 = "tag_aim";
  var_2 = self gettagangles(var_1);
  _id_48A1("none");

  for(;;) {
    var_3 = self gettagangles(var_1);
    var_4 = anglestoright(var_2);
    var_5 = anglesToForward(var_3);
    var_6 = vectordot(var_4, var_5);

    if(var_6 == 0) {
      _id_48A1("none");
    } else if(var_6 > 0) {
      _id_48A1("right");
    } else {
      _id_48A1("left");

    }
    var_2 = self gettagangles(var_1);
    wait 0.05;
  }
}

_id_48A1(var_0) {
  if(!isDefined(self._id_48A2) || self._id_48A2 != var_0) {
    self._id_48A2 = var_0;
  }
}

_id_48A3(var_0) {
  self endon("death");
  var_0 endon("death");
  self endon("dismount");
  var_0 endon("turret_cleanup");
  var_1 = 0.3;
  var_2 = 0.3;

  for(;;) {
    var_0 waittill("new_fireTarget");
    wait 0.05;

    if(!isDefined(var_0._id_48A4) || self._id_4887) {
      continue;
    }
    var_3 = undefined;

    if(!var_0 _id_48C7(var_0._id_48A4, var_0._id_489D)) {
      if(var_0._id_48A2 == "right") {
        var_3 = self._id_48A5;
      } else if(var_0._id_48A2 == "left") {
        var_3 = self._id_48A6;

      }
      if(isDefined(var_3)) {
        self setanimlimited(self._id_489A, 1, var_1, 1);
        self setanimknoblimited(var_3, 1, 0, 1);

        while(isDefined(var_0._id_48A4) && !var_0 _id_48C7(var_0._id_48A4, var_0._id_489D)) {
          if(self._id_4887) {
            break;
          }

          wait 0.05;
        }

        self clearanim(self._id_489A, var_2);
      }
    }
  }
}

_id_48A7(var_0, var_1, var_2, var_3) {
  var_0._id_24E8[self._id_2252] = 0;
  maps\_vehicle_aianim::_id_25D8();
  _id_48A9(var_0, var_1, var_2, var_3);
}

_id_48A8(var_0, var_1, var_2, var_3) {
  _id_48A9(var_0, var_1, var_2, var_3);
}

#using_animtree("generic_human");

_id_48A9(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_2 endon("death");
  self stopanimscripted();
  self notify("newanim");
  self._id_0EEA = undefined;
  self._id_10EF = 1;
  var_3 = % humvee_passenger_2_turret;

  if(!isDefined(var_3)) {
    var_3 = self._id_48AA;

  }
  var_4 = maps\_vehicle_aianim::_id_2534(var_0, var_1);
  var_5 = var_0 gettagorigin(var_4._id_24F2);
  var_6 = var_0 gettagangles(var_4._id_24F2);
  var_2 setdefaultdroppitch(0);
  var_2 thread _id_48AC(var_2._id_48AB);
  self animscripted("passenger2turret", var_5, var_6, var_3);
  wait(getanimlength(var_3));
  self stopanimscripted();
  var_2 _id_48C6();
  self useturret(var_2);
}

_id_48AC(var_0) {
  if(isDefined(self._id_2018)) {
    self clearanim(self._id_2018, 0);
    self._id_2018 = undefined;
  }

  self setflaggedanimknobrestart("minigun_turret", var_0, 1, 0, 1);
  self waittillmatch("minigun_turret", "end");
  self clearanim(var_0, 0);
}

_id_48AD(var_0) {
  self setanimknobrestart(var_0, 1, 0, 0);
  self._id_2018 = var_0;
}

_id_48AE(var_0) {
  self endon("death");
  var_0 endon("death");
  self endon("dismount");
  var_0 endon("kill_fireController");
  var_0 thread _id_48B1(self);
  wait 0.05;
  self thread[[var_0._id_489E]](var_0);
  var_1 = undefined;

  for(;;) {
    var_1 = var_0._id_48A4;

    while(var_0 _id_48AF(var_1)) {
      if(var_0 _id_48C7(var_1, var_0._id_489D)) {
        break;
      }

      wait 0.05;
    }

    if(var_0 _id_48AF(var_1) && !self.ignoreall) {
      var_0._id_488B = 1;

    }
    while(var_0 _id_48AF(var_1) && !self.ignoreall && !self._id_4887) {
      wait 0.05;

    }
    if(var_0._id_488B || self.ignoreall) {
      var_0._id_488B = 0;

    }
    wait 0.05;
  }
}

_id_48AF(var_0) {
  if(isDefined(self._id_48B0)) {
    return 0;

  }
  if(!isDefined(self._id_48A4)) {
    return 0;

  }
  if(!_id_48B2(var_0)) {
    return 0;

  }
  if(var_0 != self._id_48A4) {
    return 0;

  }
  return 1;
}

_id_48B1(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 endon("dismount");
  self endon("kill_fireController");
  self._id_48A4 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  for(;;) {
    var_1 = self getturrettarget(0);
    var_3 = 0;

    if(_id_48B2(var_1) || !isDefined(var_1)) {
      if(!isDefined(var_1) && isDefined(var_2)) {
        var_3 = 1;
      } else if(isDefined(var_1) && !isDefined(var_2)) {
        var_3 = 1;
      } else if(isDefined(var_1) && var_1 != var_2) {
        var_3 = 1;

      }
      if(var_3) {
        self._id_48A4 = var_1;
        var_2 = var_1;
        self notify("new_fireTarget");
      }
    }

    wait 0.05;
  }
}

_id_48B2(var_0) {
  if(!isDefined(var_0)) {
    return 0;

  }
  if(isDefined(var_0.ignoreme) && var_0.ignoreme) {
    return 0;

  }
  if(issubstr(var_0.code_classname, "actor") && !isalive(var_0)) {
    return 0;

  }
  return 1;
}

_id_48B3(var_0, var_1, var_2, var_3) {
  self endon("turret_cleanup");
  var_4 = self getmode();

  if(var_4 != "manual") {
    self setmode("manual");

  }
  if(!isDefined(var_1) && !isDefined(var_2)) {
    var_1 = 1.5;
    var_2 = 3;
  }

  _id_48C2();
  self settargetentity(var_0);
  self waittill("turret_on_target");

  if(isDefined(var_3)) {
    self waittill(var_3);
  } else if(isDefined(var_2)) {
    wait(randomfloatrange(var_1, var_2));
  } else {
    wait(var_1);

  }
  _id_48C2();
  self cleartargetentity(var_0);

  if(isDefined(var_4)) {
    self setmode(var_4);
  }
}

_id_227C(var_0) {
  self notify("doshoot_starting");
  self setanimlimited(self._id_4899, 1, 0.1);
  self setanimknoblimited(self._id_48B4, 1, 0.1);
  var_0._id_4889 = "fire";
  var_0 thread _id_48B5(self);
}

_id_48B5(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 endon("dismount");
  self endon("kill_fireController");
  self endon("stopfiring");
  self endon("custom_anim");

  for(;;) {
    self shootturret();
    wait(self._id_489C);
  }
}

_id_48B6(var_0) {
  var_0._id_4889 = "aim";
  var_0 notify("stopfiring");
  thread _id_48B7(var_0);
}

_id_48B7(var_0) {
  self notify("doaim_idle_think");
  self endon("doaim_idle_think");
  self endon("custom_anim");
  self endon("doshoot_starting");
  self endon("death");
  var_0 endon("death");
  var_1 = var_0._id_2A38;
  var_2 = -1;

  for(;;) {
    if(var_1 vehicle_getspeed() < 1 && var_2) {
      self setanimlimited(self._id_4899, 1, 0.1);
      self setanimknoblimited(self._id_48B8, 1, 0.1);
      var_2 = 0;
    } else if(var_1 vehicle_getspeed() >= 1 && !var_2) {
      self setanimlimited(self._id_4899, 1, 0.1);
      self setanimknoblimited(self._id_48B9, 1, 0.1);
      var_2 = 1;
    }

    wait 0.05;
  }
}

_id_48BA(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  self endon("dismount");
  self endon("jumping_out");
  var_3 = self._id_4896[var_1];
  _id_48C2();
  var_4 = var_0 _id_48BB();
  _id_48C0(var_0, var_3, var_2);

  if(var_4) {
    var_0 _id_48BD();
  }
}

_id_48BB() {
  var_0 = 0;

  if(!isDefined(self._id_48BC) || !self._id_48BC) {
    var_0 = 1;
    self._id_48BC = 1;
  }

  return var_0;
}

_id_48BD() {
  self._id_48BC = 0;
}

_id_48BE(var_0) {
  if(isDefined(var_0._id_48BC)) {
    return;
  }
  self endon("death");
  var_0 endon("death");
  self endon("dismount");
  self endon("jumping_out");
  thread maps\_utility::_id_1EFE("inform_reloading");
  _id_48C0(var_0, self._id_48BF, 1);
}

_id_48C0(var_0, var_1, var_2) {
  self notify("do_custom_anim");
  self endon("do_custom_anim");
  self._id_4887 = 1;
  self._id_48C1 = var_1;
  var_0._id_4889 = "customanim";
  var_0 turretfiredisable();

  if(var_0 getbarrelspinrate() > 0) {
    var_0 stopbarrelspin();

  }
  var_0 notify("kill_fireController");
  self notify("custom_anim");

  if(isDefined(var_2) && var_2) {
    var_0 _id_48C3();

  }
  self setanimknoblimitedrestart(self._id_489B, 1, 0.2);
  self setflaggedanimknobrestart("special_anim", var_1, 1, 0, 1);

  for(;;) {
    self waittill("special_anim", var_3);

    if(var_3 == "end") {
      break;
    }
  }

  self clearanim(self._id_489B, 0.2);
  self setanimlimited(self._id_4888, 1);
  self setanimlimited(self._id_4899, 1);

  if(isDefined(var_2) && var_2) {
    var_0 _id_48C6();

  }
  self._id_48C1 = undefined;
  self._id_4887 = 0;
  var_0 turretfireenable();
  thread _id_48AE(var_0);
}

_id_48C2() {
  self endon("death");

  if(!isDefined(self._id_4887)) {
    return;
  }
  while(self._id_4887) {
    wait 0.05;
  }
}

_id_48C3(var_0) {
  if(self getmode() == "sentry") {
    return;
  }
  if(!isDefined(var_0)) {
    var_1 = self gettagangles("tag_flash");
    var_0 = (0, var_1[1], var_1[2]);
  }

  self._id_48C4 = self getmode();
  self setmode("manual");
  var_2 = anglesToForward(var_0);
  var_3 = var_2 * 96;
  var_4 = self gettagorigin("tag_aim") + var_3;
  self._id_48C5 = spawn("script_origin", var_4);
  self._id_48C5.ignoreme = 1;
  self._id_48C5 linkto(self._id_2A38);
  self cleartargetentity();
  self settargetentity(self._id_48C5);
  self waittill("turret_on_target");
}

_id_48C6() {
  self cleartargetentity();

  if(isDefined(self._id_48C5)) {
    self._id_48C5 unlink();
    self._id_48C5 delete();
  }

  if(isDefined(self._id_48C4)) {
    self setmode(self._id_48C4);
    self._id_48C4 = undefined;
  }
}

_id_48C7(var_0, var_1) {
  var_2 = _id_48C8(var_0);

  if(var_2 <= var_1) {
    return 1;

  }
  return 0;
}

_id_48C8(var_0) {
  var_1 = vectortoyaw(var_0.origin - self.origin);
  var_2 = self gettagangles("tag_flash")[1];
  var_3 = animscripts\utility::_id_0D61(var_2 - var_1);
  return var_3;
}

_id_48C9(var_0) {
  var_1 = maps\_utility::_id_27C1(::_id_48CA, 20, 0);
  var_1.time = var_0;
}

_id_48CA(var_0, var_1, var_2) {
  var_3 = var_1 * (1 - var_0) + var_2 * var_0;
  self setdefaultdroppitch(var_3);
}