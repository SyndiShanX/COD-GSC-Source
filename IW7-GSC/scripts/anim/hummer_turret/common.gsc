/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\hummer_turret\common.gsc
*************************************************/

func_91E0(param_00, param_01) {
  self endon("killanimscript");
  scripts\anim\utility::func_9832(param_01);
  self.var_BFDC = 1;
  self.var_C05C = 1;
  self.a.movement = "stop";
  self.a.var_10930 = param_01;
  self.a.usingworldspacehitmarkers = param_00;
  self.ignoreme = 1;
  if(isDefined(self.var_B79F)) {
    self.ignoreme = self.var_B79F;
  }

  self.var_9DA6 = 0;
  self setturretanim(self.primaryturretanim);
  self _meth_82AB(self.primaryturretanim, 1, 0.2, 1);
  if(isDefined(self.var_394)) {
    scripts\anim\shared::placeweaponon(self.var_394, "none");
  }

  self.var_C584 = 1;
  self.autoboltmissileeffects = ::func_129D3;
  self notify("guy_man_turret_stop");
  param_00 notify("stop_burst_fire_unmanned");
  param_00.var_12A94 = "start";
  param_00.var_1A56 = self;
  param_00.var_6D96 = 0;
  param_00 give_player_session_tokens("sentry");
  param_00 setsentryowner(self);
  param_00 setdefaultdroppitch(0);
  param_00 setturretcanaidetach(0);
  func_8713();
  level thread func_8903(self, param_00);
  level thread func_8902(self, param_00);
  param_00 thread func_12A45(self);
  param_00.var_5855 = 0;
  thread func_6D6A(param_00);
  wait(0.05);
  if(isalive(self)) {
    thread func_8716(param_00);
  }
}

func_8713() {
  self.allowpain = 0;
  scripts\sp\utility::setflashbangimmunity(1);
  self.var_C384 = self.health;
  self.health = 200;
}

func_8714() {
  self.allowpain = 1;
  scripts\sp\utility::setflashbangimmunity(0);
  self.health = self.var_C384;
}

func_8903(param_00, param_01) {
  param_00 endon("death");
  param_01 endon("death");
  param_00 endon("dismount");
  param_00 endon("jumping_out");
  for(;;) {
    var_02 = "flashbang";
    var_03 = param_00 scripts\engine\utility::waittill_any_return("damage", var_02);
    var_04 = scripts\engine\utility::random(param_00.var_12A7F);
    if(var_03 == var_02) {
      var_04 = param_00.var_12A66;
      param_00 scripts\anim\face::saygenericdialogue("flashbang");
    }

    param_00 func_57FB(param_01, var_04, 0);
    param_01 notify("pain_done");
  }
}

func_12A27() {
  func_129BD();
  self waittill("pain_done");
  func_129BC();
}

func_8902(param_00, param_01) {
  param_00 endon("dismount");
  param_01 endon("turret_cleanup");
  param_00.var_4E2A = param_00.var_12A5E;
  param_00.noragdoll = 1;
  param_00 waittill("death");
  level thread func_129D2(param_00, param_01);
}

func_129D3() {
  var_00 = self.var_E500.mgturret[0];
  if(isalive(self)) {
    self.var_BFDC = undefined;
    self.var_C05C = undefined;
    self.ignoreme = 0;
    self.a.var_10930 = "none";
    self.a.usingworldspacehitmarkers = undefined;
    self.var_4E2A = undefined;
    func_8714();
    self.var_9DA6 = undefined;
    self.var_12A92 = undefined;
    self.var_12A7F = undefined;
    self.var_C584 = undefined;
    self.autoboltmissileeffects = undefined;
    self _meth_83AF();
    if(isDefined(self.var_394)) {
      scripts\anim\shared::placeweaponon(self.var_394, "right");
    }
  }

  level thread func_129D2(self, var_00);
}

func_129D2(param_00, param_01) {
  if(!isDefined(param_01)) {
    return;
  }

  param_01 notify("kill_fireController");
  param_01 notify("turret_cleanup");
  param_01 give_player_session_tokens("manual");
  param_01 cleartargetentity();
  param_01 setdefaultdroppitch(param_01.var_4FEA);
  if(isDefined(param_00)) {
    param_00 clearanim(param_00.var_17E6, 0);
    param_00 clearanim(param_00.var_17E0, 0);
    param_00 clearanim(param_00.var_12A93, 0);
  }

  param_01.var_6D6F = undefined;
  param_01.var_4292 = undefined;
  param_01.var_6D65 = undefined;
  param_01.var_12A94 = "free";
  param_01.var_1A56 = undefined;
  param_01.var_6D96 = undefined;
  if(isDefined(param_01.var_10953)) {
    level[[param_01.var_10953]](param_00, param_01);
  }
}

func_12A45(param_00) {
  self endon("turret_cleanup");
  self endon("death");
  param_00 endon("death");
  param_00 endon("detach");
  var_01 = "tag_aim";
  var_02 = self gettagangles(var_01);
  func_12A4C("none");
  for(;;) {
    var_03 = self gettagangles(var_01);
    var_04 = anglestoright(var_02);
    var_05 = anglesToForward(var_03);
    var_06 = vectordot(var_04, var_05);
    if(var_06 == 0) {
      func_12A4C("none");
    } else if(var_06 > 0) {
      func_12A4C("right");
    } else {
      func_12A4C("left");
    }

    var_02 = self gettagangles(var_01);
    wait(0.05);
  }
}

func_12A4C(param_00) {
  if(!isDefined(self.var_E729) || self.var_E729 != param_00) {
    self.var_E729 = param_00;
  }
}

func_8716(param_00) {
  self endon("death");
  param_00 endon("death");
  self endon("dismount");
  param_00 endon("turret_cleanup");
  var_01 = 0.3;
  var_02 = 0.3;
  for(;;) {
    param_00 waittill("new_fireTarget");
    wait(0.05);
    if(!isDefined(param_00.var_6D87) || self.var_9DA6) {
      continue;
    }

    var_03 = undefined;
    if(!param_00 func_129BF(param_00.var_6D87, param_00.var_4292)) {
      if(param_00.var_E729 == "right") {
        var_03 = self.var_17E5;
      } else if(param_00.var_E729 == "left") {
        var_03 = self.var_17E4;
      }

      if(isDefined(var_03)) {
        self _meth_82AC(self.var_17E0, 1, var_01, 1);
        self _meth_82A9(var_03, 1, 0, 1);
        while(isDefined(param_00.var_6D87) && !param_00 func_129BF(param_00.var_6D87, param_00.var_4292)) {
          if(self.var_9DA6) {
            break;
          }

          wait(0.05);
        }

        self clearanim(self.var_17E0, var_02);
      }
    }
  }
}

func_13218(param_00, param_01, param_02, param_03) {
  param_00.var_1307E[self.var_1321D] = 0;
  scripts\sp\vehicle_aianim::func_872E();
  func_873F(param_00, param_01, param_02, param_03);
}

func_8741(param_00, param_01, param_02, param_03) {
  func_873F(param_00, param_01, param_02, param_03);
}

func_873F(param_00, param_01, param_02, param_03) {
  self endon("death");
  param_02 endon("death");
  self givescorefortrophyblocks();
  self notify("newanim");
  self.var_5BD6 = undefined;
  self.var_BFDC = 1;
  param_03 = % humvee_passenger_2_turret;
  if(!isDefined(param_03)) {
    param_03 = self.var_C938;
  }

  var_04 = scripts\sp\vehicle_aianim::func_1F00(param_00, param_01);
  var_05 = param_00 gettagorigin(var_04.var_10220);
  var_06 = param_00 gettagangles(var_04.var_10220);
  param_02 setdefaultdroppitch(0);
  param_02 thread func_129C2(param_02.var_C937);
  self animscripted("passenger2turret", var_05, var_06, param_03);
  wait(getanimlength(param_03));
  self givescorefortrophyblocks();
  param_02 func_129BC();
  self _meth_83D7(param_02);
}

func_129C2(param_00) {
  if(isDefined(self.var_92F3)) {
    self clearanim(self.var_92F3, 0);
    self.var_92F3 = undefined;
  }

  self _meth_82E7("minigun_turret", param_00, 1, 0, 1);
  self waittillmatch("end", "minigun_turret");
  self clearanim(param_00, 0);
}

func_129C3(param_00) {
  self _meth_82AB(param_00, 1, 0, 0);
  self.var_92F3 = param_00;
}

func_6D6A(param_00) {
  self endon("death");
  param_00 endon("death");
  self endon("dismount");
  param_00 endon("kill_fireController");
  param_00 thread func_12A3C(self);
  wait(0.05);
  self thread[[param_00.var_6D65]](param_00);
  var_01 = undefined;
  for(;;) {
    var_01 = param_00.var_6D87;
    while(param_00 func_114FA(var_01)) {
      if(param_00 func_129BF(var_01, param_00.var_4292)) {
        break;
      }

      wait(0.05);
    }

    if(param_00 func_114FA(var_01) && !self.precacheleaderboards) {
      param_00.var_5855 = 1;
    }

    while(param_00 func_114FA(var_01) && !self.precacheleaderboards && !self.var_9DA6) {
      wait(0.05);
    }

    if(param_00.var_5855 || self.precacheleaderboards) {
      param_00.var_5855 = 0;
    }

    wait(0.05);
  }
}

func_114FA(param_00) {
  if(isDefined(self.var_596A)) {
    return 0;
  }

  if(!isDefined(self.var_6D87)) {
    return 0;
  }

  if(!func_12A3D(param_00)) {
    return 0;
  }

  if(param_00 != self.var_6D87) {
    return 0;
  }

  return 1;
}

func_12A3C(param_00) {
  param_00 endon("death");
  self endon("death");
  param_00 endon("dismount");
  self endon("kill_fireController");
  self.var_6D87 = undefined;
  var_01 = undefined;
  var_02 = undefined;
  for(;;) {
    var_01 = self getturrettarget(0);
    var_03 = 0;
    if(func_12A3D(var_01) || !isDefined(var_01)) {
      if(!isDefined(var_01) && isDefined(var_02)) {
        var_03 = 1;
      } else if(isDefined(var_01) && !isDefined(var_02)) {
        var_03 = 1;
      } else if(isDefined(var_01) && var_01 != var_02) {
        var_03 = 1;
      }

      if(var_03) {
        self.var_6D87 = var_01;
        var_02 = var_01;
        self notify("new_fireTarget");
      }
    }

    wait(0.05);
  }
}

func_12A3D(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(isDefined(param_00.ignoreme) && param_00.ignoreme) {
    return 0;
  }

  if(issubstr(param_00.opcode::OP_GetByte, "actor") && !isalive(param_00)) {
    return 0;
  }

  return 1;
}

func_F479(param_00, param_01, param_02, param_03) {
  self endon("turret_cleanup");
  var_04 = self getspawnpoint_safeguard();
  if(var_04 != "manual") {
    self give_player_session_tokens("manual");
  }

  if(!isDefined(param_01) && !isDefined(param_02)) {
    param_01 = 1.5;
    param_02 = 3;
  }

  func_4C35();
  self settargetentity(param_00);
  self waittill("turret_on_target");
  if(isDefined(param_03)) {
    self waittill(param_03);
  } else if(isDefined(param_02)) {
    wait(randomfloatrange(param_01, param_02));
  } else {
    wait(param_01);
  }

  func_4C35();
  self cleartargetentity(param_00);
  if(isDefined(var_04)) {
    self give_player_session_tokens(var_04);
  }
}

func_5AAA(param_00) {
  self notify("doshoot_starting");
  self _meth_82AC(self.var_17E6, 1, 0.1);
  self _meth_82A9(self.var_17E2, 1, 0.1);
  param_00.var_12A94 = "fire";
  param_00 thread func_6CE6(self);
}

func_6CE6(param_00) {
  param_00 endon("death");
  self endon("death");
  param_00 endon("dismount");
  self endon("kill_fireController");
  self endon("stopfiring");
  self endon("custom_anim");
  for(;;) {
    self shootturret();
    wait(self.var_6D6F);
  }
}

func_57DB(param_00) {
  param_00.var_12A94 = "aim";
  param_00 notify("stopfiring");
  thread func_57DC(param_00);
}

func_57DC(param_00) {
  self notify("doaim_idle_think");
  self endon("doaim_idle_think");
  self endon("custom_anim");
  self endon("doshoot_starting");
  self endon("death");
  param_00 endon("death");
  var_01 = param_00.var_C841;
  var_02 = -1;
  for(;;) {
    if(var_01 vehicle_getspeed() < 1 && var_02) {
      self _meth_82AC(self.var_17E6, 1, 0.1);
      self _meth_82A9(self.var_17E3, 1, 0.1);
      var_02 = 0;
    } else if(var_01 vehicle_getspeed() >= 1 && !var_02) {
      self _meth_82AC(self.var_17E6, 1, 0.1);
      self _meth_82A9(self.var_17E1, 1, 0.1);
      var_02 = 1;
    }

    wait(0.05);
  }
}

func_129F7(param_00, param_01, param_02) {
  self endon("death");
  param_00 endon("death");
  self endon("dismount");
  self endon("jumping_out");
  var_03 = self.var_12A92[param_01];
  func_4C35();
  var_04 = param_00 func_DF51();
  func_57FB(param_00, var_03, param_02);
  if(var_04) {
    param_00 func_DF52();
  }
}

func_DF51() {
  var_00 = 0;
  if(!isDefined(self.var_560F) || !self.var_560F) {
    var_00 = 1;
    self.var_560F = 1;
  }

  return var_00;
}

func_DF52() {
  self.var_560F = 0;
}

func_5A65(param_00) {
  if(isDefined(param_00.var_560F)) {
    return;
  }

  self endon("death");
  param_00 endon("death");
  self endon("dismount");
  self endon("jumping_out");
  if(level.var_3D4B) {
    thread scripts\sp\utility::func_4C39("inform_reloading");
  }

  func_57FB(param_00, self.var_12A81, 1);
}

func_57FB(param_00, param_01, param_02) {
  self notify("do_custom_anim");
  self endon("do_custom_anim");
  self.var_9DA6 = 1;
  self.var_4C7D = param_01;
  param_00.var_12A94 = "customanim";
  param_00 turretfiredisable();
  if(param_00 _meth_810A() > 0) {
    param_00 _meth_83A2();
  }

  param_00 notify("kill_fireController");
  self notify("custom_anim");
  if(isDefined(param_02) && param_02) {
    param_00 func_129BD();
  }

  self _meth_82AA(self.var_12A93, 1, 0.2);
  self _meth_82E7("special_anim", param_01, 1, 0, 1);
  for(;;) {
    self waittill("special_anim", var_03);
    if(var_03 == "end") {
      break;
    }
  }

  self clearanim(self.var_12A93, 0.2);
  self _meth_82AC(self.primaryturretanim, 1);
  self _meth_82AC(self.var_17E6, 1);
  if(isDefined(param_02) && param_02) {
    param_00 func_129BC();
  }

  self.var_4C7D = undefined;
  self.var_9DA6 = 0;
  param_00 turretfireenable();
  thread func_6D6A(param_00);
}

func_4C35() {
  self endon("death");
  if(!isDefined(self.var_9DA6)) {
    return;
  }

  while(self.var_9DA6) {
    wait(0.05);
  }
}

func_129BD(param_00) {
  if(self getspawnpoint_safeguard() == "sentry") {
    return;
  }

  if(!isDefined(param_00)) {
    var_01 = self gettagangles("tag_flash");
    param_00 = (0, var_01[1], var_01[2]);
  }

  self.var_C3F8 = self getspawnpoint_safeguard();
  self give_player_session_tokens("manual");
  var_02 = anglesToForward(param_00);
  var_03 = var_02 * 96;
  var_04 = self gettagorigin("tag_aim") + var_03;
  self.var_116D2 = spawn("script_origin", var_04);
  self.var_116D2.ignoreme = 1;
  self.var_116D2 linkto(self.var_C841);
  self cleartargetentity();
  self settargetentity(self.var_116D2);
  self waittill("turret_on_target");
}

func_129BC() {
  self cleartargetentity();
  if(isDefined(self.var_116D2)) {
    self.var_116D2 unlink();
    self.var_116D2 delete();
  }

  if(isDefined(self.var_C3F8)) {
    self give_player_session_tokens(self.var_C3F8);
    self.var_C3F8 = undefined;
  }
}

func_129BF(param_00, param_01) {
  var_02 = func_129F3(param_00);
  if(var_02 <= param_01) {
    return 1;
  }

  return 0;
}

func_129F3(param_00) {
  var_01 = vectortoyaw(param_00.origin - self.origin);
  var_02 = self gettagangles("tag_flash")[1];
  var_03 = scripts\engine\utility::absangleclamp180(var_02 - var_01);
  return var_03;
}

func_AB8C(param_00) {
  var_01 = scripts\sp\utility::func_48AA(::func_2B6E, 20, 0);
  var_01.time = param_00;
}

func_2B6E(param_00, param_01, param_02) {
  var_03 = param_01 * 1 - param_00 + param_02 * param_00;
  self setdefaultdroppitch(var_03);
}