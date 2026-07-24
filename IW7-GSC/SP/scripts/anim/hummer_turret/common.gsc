/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\hummer_turret\common.gsc
*************************************************/

_id_91E0(var_0, var_1) {
  self endon("killanimscript");
  scripts\anim\utility::_id_9832(var_1);
  self._id_BFDC = 1;
  self._id_C05C = 1;
  self.a.movement = "stop";
  self.a._id_10930 = var_1;
  self.a.usingworldspacehitmarkers = var_0;
  self.ignoreme = 1;

  if(isDefined(self._id_B79F)) {
    self.ignoreme = self._id_B79F;
  }

  self._id_9DA6 = 0;
  self setturretanim(self.primaryturretanim);
  self _meth_82AB(self.primaryturretanim, 1, 0.2, 1);

  if(isDefined(self.weapon)) {
    scripts\anim\shared::placeweaponon(self.weapon, "none");
  }

  self._id_C584 = 1;
  self._id_8020 = ::_id_129D3;
  self notify("guy_man_turret_stop");
  var_0 notify("stop_burst_fire_unmanned");
  var_0._id_12A94 = "start";
  var_0._id_1A56 = self;
  var_0._id_6D96 = 0;
  var_0 setmode("sentry");
  var_0 setsentryowner(self);
  var_0 setdefaultdroppitch(0);
  var_0 setturretcanaidetach(0);
  _id_8713();
  level thread _id_8903(self, var_0);
  level thread _id_8902(self, var_0);
  var_0 thread _id_12A45(self);
  var_0._id_5855 = 0;
  thread _id_6D6A(var_0);
  wait 0.05;

  if(isalive(self)) {
    thread _id_8716(var_0);
  }
}

_id_8713() {
  self.allowpain = 0;
  scripts\sp\utility::setflashbangimmunity(1);
  self._id_C384 = self.health;
  self.health = 200;
}

_id_8714() {
  self.allowpain = 1;
  scripts\sp\utility::setflashbangimmunity(0);
  self.health = self._id_C384;
}

_id_8903(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  var_0 endon("dismount");
  var_0 endon("jumping_out");

  for(;;) {
    var_2 = "flashbang";
    var_3 = var_0 scripts\engine\utility::waittill_any_return("damage", var_2);
    var_4 = scripts\engine\utility::random(var_0._id_12A7F);

    if(var_3 == var_2) {
      var_4 = var_0._id_12A66;
      var_0 scripts\anim\face::saygenericdialogue("flashbang");
    }

    var_0 _id_57FB(var_1, var_4, 0);
    var_1 notify("pain_done");
  }
}

_id_12A27() {
  _id_129BD();
  self waittill("pain_done");
  _id_129BC();
}

_id_8902(var_0, var_1) {
  var_0 endon("dismount");
  var_1 endon("turret_cleanup");
  var_0._id_4E2A = var_0._id_12A5E;
  var_0.noragdoll = 1;
  var_0 waittill("death");
  level thread _id_129D2(var_0, var_1);
}

_id_129D3() {
  var_0 = self._id_E500.mgturret[0];

  if(isalive(self)) {
    self._id_BFDC = undefined;
    self._id_C05C = undefined;
    self.ignoreme = 0;
    self.a._id_10930 = "none";
    self.a.usingworldspacehitmarkers = undefined;
    self._id_4E2A = undefined;
    _id_8714();
    self._id_9DA6 = undefined;
    self._id_12A92 = undefined;
    self._id_12A7F = undefined;
    self._id_C584 = undefined;
    self._id_8020 = undefined;
    self _meth_83AF();

    if(isDefined(self.weapon)) {
      scripts\anim\shared::placeweaponon(self.weapon, "right");
    }
  }

  level thread _id_129D2(self, var_0);
}

_id_129D2(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  var_1 notify("kill_fireController");
  var_1 notify("turret_cleanup");
  var_1 setmode("manual");
  var_1 cleartargetentity();
  var_1 setdefaultdroppitch(var_1._id_4FEA);

  if(isDefined(var_0)) {
    var_0 clearanim(var_0._id_17E6, 0);
    var_0 clearanim(var_0._id_17E0, 0);
    var_0 clearanim(var_0._id_12A93, 0);
  }

  var_1._id_6D6F = undefined;
  var_1._id_4292 = undefined;
  var_1._id_6D65 = undefined;
  var_1._id_12A94 = "free";
  var_1._id_1A56 = undefined;
  var_1._id_6D96 = undefined;

  if(isDefined(var_1._id_10953)) {
    level[[var_1._id_10953]](var_0, var_1);
  }
}

_id_12A45(var_0) {
  self endon("turret_cleanup");
  self endon("death");
  var_0 endon("death");
  var_0 endon("detach");
  var_1 = "tag_aim";
  var_2 = self gettagangles(var_1);
  _id_12A4C("none");

  for(;;) {
    var_3 = self gettagangles(var_1);
    var_4 = anglestoright(var_2);
    var_5 = anglesToForward(var_3);
    var_6 = vectordot(var_4, var_5);

    if(var_6 == 0) {
      _id_12A4C("none");
    } else if(var_6 > 0) {
      _id_12A4C("right");
    } else {
      _id_12A4C("left");
    }

    var_2 = self gettagangles(var_1);
    wait 0.05;
  }
}

_id_12A4C(var_0) {
  if(!isDefined(self._id_E729) || self._id_E729 != var_0) {
    self._id_E729 = var_0;
  }
}

_id_8716(var_0) {
  self endon("death");
  var_0 endon("death");
  self endon("dismount");
  var_0 endon("turret_cleanup");
  var_1 = 0.3;
  var_2 = 0.3;

  for(;;) {
    var_0 waittill("new_fireTarget");
    wait 0.05;

    if(!isDefined(var_0._id_6D87) || self._id_9DA6) {
      continue;
    }
    var_3 = undefined;

    if(!var_0 _id_129BF(var_0._id_6D87, var_0._id_4292)) {
      if(var_0._id_E729 == "right") {
        var_3 = self._id_17E5;
      } else if(var_0._id_E729 == "left") {
        var_3 = self._id_17E4;
      }

      if(isDefined(var_3)) {
        self _meth_82AC(self._id_17E0, 1, var_1, 1);
        self _meth_82A9(var_3, 1, 0, 1);

        while(isDefined(var_0._id_6D87) && !var_0 _id_129BF(var_0._id_6D87, var_0._id_4292)) {
          if(self._id_9DA6) {
            break;
          }

          wait 0.05;
        }

        self clearanim(self._id_17E0, var_2);
      }
    }
  }
}

_id_13218(var_0, var_1, var_2, var_3) {
  var_0._id_1307E[self._id_1321D] = 0;
  scripts\sp\vehicle_aianim::_id_872E();
  _id_873F(var_0, var_1, var_2, var_3);
}

_id_8741(var_0, var_1, var_2, var_3) {
  _id_873F(var_0, var_1, var_2, var_3);
}

#using_animtree("generic_human");

_id_873F(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_2 endon("death");
  self _meth_83A1();
  self notify("newanim");
  self._id_5BD6 = undefined;
  self._id_BFDC = 1;
  var_3 = % humvee_passenger_2_turret;

  if(!isDefined(var_3)) {
    var_3 = self._id_C938;
  }

  var_4 = scripts\sp\vehicle_aianim::_id_1F00(var_0, var_1);
  var_5 = var_0 gettagorigin(var_4._id_10220);
  var_6 = var_0 gettagangles(var_4._id_10220);
  var_2 setdefaultdroppitch(0);
  var_2 thread _id_129C2(var_2._id_C937);
  self animScripted("passenger2turret", var_5, var_6, var_3);
  wait(getanimlength(var_3));
  self _meth_83A1();
  var_2 _id_129BC();
  self _meth_83D7(var_2);
}

_id_129C2(var_0) {
  if(isDefined(self._id_92F3)) {
    self clearanim(self._id_92F3, 0);
    self._id_92F3 = undefined;
  }

  self _meth_82E7("minigun_turret", var_0, 1, 0, 1);
  self waittillmatch("minigun_turret", "end");
  self clearanim(var_0, 0);
}

_id_129C3(var_0) {
  self _meth_82AB(var_0, 1, 0, 0);
  self._id_92F3 = var_0;
}

_id_6D6A(var_0) {
  self endon("death");
  var_0 endon("death");
  self endon("dismount");
  var_0 endon("kill_fireController");
  var_0 thread _id_12A3C(self);
  wait 0.05;
  self thread[[var_0._id_6D65]](var_0);
  var_1 = undefined;

  for(;;) {
    var_1 = var_0._id_6D87;

    while(var_0 _id_114FA(var_1)) {
      if(var_0 _id_129BF(var_1, var_0._id_4292)) {
        break;
      }

      wait 0.05;
    }

    if(var_0 _id_114FA(var_1) && !self.ignoreall) {
      var_0._id_5855 = 1;
    }

    while(var_0 _id_114FA(var_1) && !self.ignoreall && !self._id_9DA6) {
      wait 0.05;
    }

    if(var_0._id_5855 || self.ignoreall) {
      var_0._id_5855 = 0;
    }

    wait 0.05;
  }
}

_id_114FA(var_0) {
  if(isDefined(self._id_596A)) {
    return 0;
  }

  if(!isDefined(self._id_6D87)) {
    return 0;
  }

  if(!_id_12A3D(var_0)) {
    return 0;
  }

  if(var_0 != self._id_6D87) {
    return 0;
  }

  return 1;
}

_id_12A3C(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 endon("dismount");
  self endon("kill_fireController");
  self._id_6D87 = undefined;
  var_1 = undefined;
  var_2 = undefined;

  for(;;) {
    var_1 = self getturrettarget(0);
    var_3 = 0;

    if(_id_12A3D(var_1) || !isDefined(var_1)) {
      if(!isDefined(var_1) && isDefined(var_2)) {
        var_3 = 1;
      } else if(isDefined(var_1) && !isDefined(var_2)) {
        var_3 = 1;
      } else if(isDefined(var_1) && var_1 != var_2) {
        var_3 = 1;
      }

      if(var_3) {
        self._id_6D87 = var_1;
        var_2 = var_1;
        self notify("new_fireTarget");
      }
    }

    wait 0.05;
  }
}

_id_12A3D(var_0) {
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

_id_F479(var_0, var_1, var_2, var_3) {
  self endon("turret_cleanup");
  var_4 = self _meth_813D();

  if(var_4 != "manual") {
    self setmode("manual");
  }

  if(!isDefined(var_1) && !isDefined(var_2)) {
    var_1 = 1.5;
    var_2 = 3;
  }

  _id_4C35();
  self settargetentity(var_0);
  self waittill("turret_on_target");

  if(isDefined(var_3)) {
    self waittill(var_3);
  } else if(isDefined(var_2)) {
    wait(randomfloatrange(var_1, var_2));
  } else {
    wait(var_1);
  }

  _id_4C35();
  self cleartargetentity(var_0);

  if(isDefined(var_4)) {
    self setmode(var_4);
  }
}

_id_5AAA(var_0) {
  self notify("doshoot_starting");
  self _meth_82AC(self._id_17E6, 1, 0.1);
  self _meth_82A9(self._id_17E2, 1, 0.1);
  var_0._id_12A94 = "fire";
  var_0 thread _id_6CE6(self);
}

_id_6CE6(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 endon("dismount");
  self endon("kill_fireController");
  self endon("stopfiring");
  self endon("custom_anim");

  for(;;) {
    self shootturret();
    wait(self._id_6D6F);
  }
}

_id_57DB(var_0) {
  var_0._id_12A94 = "aim";
  var_0 notify("stopfiring");
  thread _id_57DC(var_0);
}

_id_57DC(var_0) {
  self notify("doaim_idle_think");
  self endon("doaim_idle_think");
  self endon("custom_anim");
  self endon("doshoot_starting");
  self endon("death");
  var_0 endon("death");
  var_1 = var_0._id_C841;
  var_2 = -1;

  for(;;) {
    if(var_1 vehicle_getspeed() < 1 && var_2) {
      self _meth_82AC(self._id_17E6, 1, 0.1);
      self _meth_82A9(self._id_17E3, 1, 0.1);
      var_2 = 0;
    } else if(var_1 vehicle_getspeed() >= 1 && !var_2) {
      self _meth_82AC(self._id_17E6, 1, 0.1);
      self _meth_82A9(self._id_17E1, 1, 0.1);
      var_2 = 1;
    }

    wait 0.05;
  }
}

_id_129F7(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  self endon("dismount");
  self endon("jumping_out");
  var_3 = self._id_12A92[var_1];
  _id_4C35();
  var_4 = var_0 _id_DF51();
  _id_57FB(var_0, var_3, var_2);

  if(var_4) {
    var_0 _id_DF52();
  }
}

_id_DF51() {
  var_0 = 0;

  if(!isDefined(self._id_560F) || !self._id_560F) {
    var_0 = 1;
    self._id_560F = 1;
  }

  return var_0;
}

_id_DF52() {
  self._id_560F = 0;
}

_id_5A65(var_0) {
  if(isDefined(var_0._id_560F)) {
    return;
  }
  self endon("death");
  var_0 endon("death");
  self endon("dismount");
  self endon("jumping_out");

  if(anim._id_3D4B) {
    thread scripts\sp\utility::_id_4C39("inform_reloading");
  }

  _id_57FB(var_0, self._id_12A81, 1);
}

_id_57FB(var_0, var_1, var_2) {
  self notify("do_custom_anim");
  self endon("do_custom_anim");
  self._id_9DA6 = 1;
  self._id_4C7D = var_1;
  var_0._id_12A94 = "customanim";
  var_0 turretfiredisable();

  if(var_0 _meth_810A() > 0) {
    var_0 _meth_83A2();
  }

  var_0 notify("kill_fireController");
  self notify("custom_anim");

  if(isDefined(var_2) && var_2) {
    var_0 _id_129BD();
  }

  self _meth_82AA(self._id_12A93, 1, 0.2);
  self _meth_82E7("special_anim", var_1, 1, 0, 1);

  for(;;) {
    self waittill("special_anim", var_3);

    if(var_3 == "end") {
      break;
    }
  }

  self clearanim(self._id_12A93, 0.2);
  self _meth_82AC(self.primaryturretanim, 1);
  self _meth_82AC(self._id_17E6, 1);

  if(isDefined(var_2) && var_2) {
    var_0 _id_129BC();
  }

  self._id_4C7D = undefined;
  self._id_9DA6 = 0;
  var_0 turretfireenable();
  thread _id_6D6A(var_0);
}

_id_4C35() {
  self endon("death");

  if(!isDefined(self._id_9DA6)) {
    return;
  }
  while(self._id_9DA6) {
    wait 0.05;
  }
}

_id_129BD(var_0) {
  if(self _meth_813D() == "sentry") {
    return;
  }
  if(!isDefined(var_0)) {
    var_1 = self gettagangles("tag_flash");
    var_0 = (0, var_1[1], var_1[2]);
  }

  self._id_C3F8 = self _meth_813D();
  self setmode("manual");
  var_2 = anglesToForward(var_0);
  var_3 = var_2 * 96;
  var_4 = self gettagorigin("tag_aim") + var_3;
  self._id_116D2 = spawn("script_origin", var_4);
  self._id_116D2.ignoreme = 1;
  self._id_116D2 linkTo(self._id_C841);
  self cleartargetentity();
  self settargetentity(self._id_116D2);
  self waittill("turret_on_target");
}

_id_129BC() {
  self cleartargetentity();

  if(isDefined(self._id_116D2)) {
    self._id_116D2 unlink();
    self._id_116D2 delete();
  }

  if(isDefined(self._id_C3F8)) {
    self setmode(self._id_C3F8);
    self._id_C3F8 = undefined;
  }
}

_id_129BF(var_0, var_1) {
  var_2 = _id_129F3(var_0);

  if(var_2 <= var_1) {
    return 1;
  }

  return 0;
}

_id_129F3(var_0) {
  var_1 = vectortoyaw(var_0.origin - self.origin);
  var_2 = self gettagangles("tag_flash")[1];
  var_3 = scripts\engine\utility::absangleclamp180(var_2 - var_1);
  return var_3;
}

_id_AB8C(var_0) {
  var_1 = scripts\sp\utility::_id_48AA(::_id_2B6E, 20, 0);
  var_1.time = var_0;
}

_id_2B6E(var_0, var_1, var_2) {
  var_3 = var_1 * (1 - var_0) + var_2 * var_0;
  self setdefaultdroppitch(var_3);
}