/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2343.gsc
*************************************************/

_id_B445(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  thread _id_0736::_id_7E51(var_1, "viewhands_base_iw8");
  self._id_B5A4._id_10D19 = _id_0A94::_id_74B4;
  self._id_B5A4 linkto(var_0, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self _meth_8577("80_instant");
  self _meth_84AC("safe", "iw8_ges_demeanor_safe_heli");
  var_0 _id_0706::_id_17FD(self, self._id_B5A4, "exfil", "body_animate_jnt");
  var_0 thread _id_C82F(self);
}

_id_E25B(var_0, var_1, var_2) {
  _id_8131();

  if(!isDefined(self._id_0F7F)) {
    self._id_0F7F = [];
  }

  self._id_0F7F[self._id_0F7F.size] = _id_E0CE("pilot", "body_animate_jnt", "allied_pilot_fullbody_3");
}

_id_E0CE(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_model", (0, 0, 0));
  var_6 setModel(var_2);

  if(isDefined(var_3)) {
    var_7 = spawn("script_model", (0, 0, 0));
    var_7 setModel(var_3);
    var_7 linkto(var_6, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_6._id_75DA = var_7;
    var_6 thread scripts\engine\utility::_id_472E(var_7);
  }

  if(isDefined(var_5)) {
    var_8 = spawn("script_model", (0, 0, 0));
    var_8 setModel(var_5);
    var_8 linkto(var_6._id_75DA, "j_spine4", (0, 0, 0), (0, 0, 0));
    var_6._id_75C5 = var_8;
    var_6 thread scripts\engine\utility::_id_472E(var_8);
  }

  var_6._id_18AF = var_0;
  var_6 _id_06C6::_id_D47B();

  if(isDefined(var_1)) {
    thread scripts\engine\utility::_id_472E(var_6);
    var_6 linkto(self, var_1, (0, 0, 0), (0, 0, 0));
  }

  return var_6;
}

_id_8131(var_0) {
  _id_CDBE();
  _id_FFFF();
}

#using_animtree("script_model");

_id_CDBE() {
  level._id_CC34["pilot"] = #animtree;
  level._id_CC31["pilot"]["exfil"] = % vh_blima_rappel_pilot;
  level._id_CC32["pilot"]["exfil"] = "vh_blima_rappel_pilot";
  level._id_CC34["copilot"] = #animtree;
  level._id_CC31["copilot"]["exfil"] = % vh_blima_rappel_copilot;
  level._id_CC32["copilot"]["exfil"] = "vh_blima_rappel_copilot";
  level._id_CC34["seat1"] = #animtree;
  level._id_CC31["seat1"]["exfil"] = % cp_exfil_blima_plr01_wm;
  level._id_CC32["seat1"]["exfil"] = "cp_exfil_blima_plr01_wm";
  level._id_CC3B["seat1"]["exfil"] = "exfil_blima_exit_1";
  level._id_CC31["seat1"]["exfil_idle"] = % cp_exfil_blima_plr01_idle_wm;
  level._id_CC32["seat1"]["exfil_idle"] = "cp_exfil_blima_plr01_idle_wm";
  level._id_CC3B["seat1"]["exfil_idle"] = "exfil_blima_exit_1_idle";
  level._id_CC34["seat2"] = #animtree;
  level._id_CC31["seat2"]["exfil"] = % cp_exfil_blima_plr02_wm;
  level._id_CC32["seat2"]["exfil"] = "cp_exfil_blima_plr02_wm";
  level._id_CC3B["seat2"]["exfil"] = "exfil_blima_exit_2";
  level._id_CC31["seat2"]["exfil_idle"] = % cp_exfil_blima_plr02_idle_wm;
  level._id_CC32["seat2"]["exfil_idle"] = "cp_exfil_blima_plr02_idle_wm";
  level._id_CC3B["seat2"]["exfil_idle"] = "exfil_blima_exit_2_idle";
  level._id_CC34["seat3"] = #animtree;
  level._id_CC31["seat3"]["exfil"] = % cp_exfil_blima_plr03_wm;
  level._id_CC32["seat3"]["exfil"] = "cp_exfil_blima_plr03_wm";
  level._id_CC3B["seat3"]["exfil"] = "exfil_blima_exit_3";
  level._id_CC31["seat3"]["exfil_idle"] = % cp_exfil_blima_plr03_idle_wm;
  level._id_CC32["seat3"]["exfil_idle"] = "cp_exfil_blima_plr03_idle_wm";
  level._id_CC3B["seat3"]["exfil_idle"] = "exfil_blima_exit_3_idle";
  level._id_CC34["seat4"] = #animtree;
  level._id_CC31["seat4"]["exfil"] = % cp_exfil_blima_plr04_wm;
  level._id_CC32["seat4"]["exfil"] = "cp_exfil_blima_plr04_wm";
  level._id_CC3B["seat4"]["exfil"] = "exfil_blima_exit_4_idle";
  level._id_CC31["seat4"]["exfil_idle"] = % cp_exfil_blima_plr04_idle_wm;
  level._id_CC32["seat4"]["exfil_idle"] = "cp_exfil_blima_plr04_idle_wm";
  level._id_CC3B["seat4"]["exfil_idle"] = "exfil_blima_exit_4_idle";
}

#using_animtree("mp_vehicles_always_loaded");

_id_FFFF() {
  level._id_CC34["exfil_chopper"] = #animtree;
}

_id_5711(var_0, var_1, var_2) {
  _id_096A::_id_8131();
  level._id_7753 = var_0;

  if(isDefined(var_2) && _func_03AC(var_2)) {
    level._id_7753 thread[[var_2]]();
  } else {
    level._id_7753 thread _id_096A::_id_1072E(0);
  }

  _func_0167(var_1, &"COOP_GAME_PLAY/EXFIL");
  level._id_7753 scripts\engine\utility::waittill_any_2("all_players_on_board", "heli_trip_timed_out");
  level notify("ready_to_exfil");
  _func_015C(var_1);
  var_0 thread _id_915A();
}

_id_E237(var_0) {
  var_0._id_18AF = "exfil_chopper";
  var_0 _id_E25B();
  var_0 thread _id_0F7D();
}

_id_915A() {
  wait 1;
  self _meth_807D();
  self vehicle_setspeed(15, 10);
  var_0 = self.origin + (0, 0, 1200);
  self setvehgoalpos(var_0, 1);
  wait 5;

  if(isDefined(self._id_5715)) {
    self vehicle_setspeed(self._id_5715, 20);
  } else {
    self vehicle_setspeed(60, 20);
  }

  if(isDefined(self._id_5716) && isDefined(self._id_5716.target)) {
    var_1 = scripts\engine\utility::getStructArray(self._id_5716.target, "targetname");
    var_2 = var_1[0];
    var_3 = (var_2.origin[0], var_2.origin[1], self.origin[2]);
    var_4 = vectornormalize(var_3 - self.origin);
    var_4 = var_4 * 20000;
    self setvehgoalpos(var_0 + var_4);
  } else
    self setvehgoalpos(var_0 + (0, -20000, 0));

  if(scripts\engine\utility::_id_5C0C("endgame_delay")) {
    scripts\engine\utility::_id_5C24("endgame_delay");
  } else {
    wait 4;
  }

  wait 3;
  level thread[[level._id_52F7]]("allies", level._id_52A0["win"]);
}

_id_1464() {
  var_0 = 0;
  var_1 = 0;
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5.team == "axis") {
      var_2[var_2.size] = var_5;
      continue;
    }

    var_3[var_3.size] = var_5;
  }

  foreach(var_5 in var_3) {
    if(_id_073B::_id_B4EF(var_5) || var_5 _meth_8605()) {
      var_1++;
    }

    if(istrue(var_5._id_7D98)) {
      var_0++;
    }
  }

  return var_0 > 0 && var_3.size == var_0 + var_1;
}

_id_106F1() {
  for(;;) {
    if(_id_1464()) {
      level notify("ready_to_exfil");
      return;
    }

    wait 0.1;
  }
}

_id_0F7D() {
  thread _id_0F7C(self._id_0F7F[0], "tag_pilot1");
}

_id_0F7C(var_0, var_1) {
  self endon("unload");
  self endon("death");
  var_0 endon("death");
  _id_06C6::_id_1845(var_0, "exfil", var_1);
}

_id_7FC0() {
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  var_2 = anglestoleft(self.angles);
  var_3 = self.origin + (0, 0, -110);
  var_4 = var_3 + var_0 * 20 + var_2 * 45;
  var_5 = var_3 + var_0 * 20 + var_1 * 45;
  var_6 = var_3 + var_0 * -20 + var_2 * 45;
  var_7 = var_3 + var_0 * -20 + var_1 * 45;
  _id_3F88(var_4, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self);
  _id_3F88(var_5, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self);
  _id_3F88(var_6, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self);
  _id_3F88(var_7, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self);
}

_id_3F88(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_origin");
  var_4 sethintstring(var_1);
  var_4 setcursorhint("HINT_BUTTON");
  var_4 _meth_84D4(200);
  var_4 sethintdisplayfov(90);
  var_4 setuserange(72);
  var_4 setusefov(90);
  var_4 _meth_84D9("hide");
  var_4 setuseholdduration("duration_short");
  var_4 thread _id_FE0F(var_3, var_2);
}

_id_FE0F(var_0, var_1) {
  self makeuseable();

  for(;;) {
    self waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::_id_8708()) {
      continue;
    }
    if(isDefined(level._id_A6DE)) {
      if(!isDefined(level._id_A6DF)) {
        iprintln(" PICK THE CORE UP BEFORE LEAVING! ");
        continue;
      }
    }

    self makeunusable();
    var_2 _id_0929::_id_7E4F(0);
    waitframe();
    var_2 thread _id_096A::_id_B73A();
    var_2._id_7D98 = 1;
  }
}

_id_4BF8() {
  self._id_52FC = newclienthudelem(self);
  self._id_52FC.x = 0;
  self._id_52FC.y = 0;
  self._id_52FC setshader("black", 640, 480);
  self._id_52FC.alignx = "left";
  self._id_52FC.aligny = "top";
  self._id_52FC.sort = 1;
  self._id_52FC.horzalign = "fullscreen";
  self._id_52FC.vertalign = "fullscreen";
  self._id_52FC.alpha = 0;
  self._id_52FC._id_01D6 = 1;
  self._id_52FC fadeovertime(3);
  self._id_52FC.alpha = 1;
}

_id_156E() {
  foreach(var_1 in level.players) {
    var_1 notify("allow_exfil");
  }
}

_id_B53C() {
  self endon("disconnect");
  self waittill("allow_exfil");

  for(;;) {
    if(self useButtonPressed() && self getcurrentweapon().basename == "ks_remote_map_cp") {
      self iprintlnbold("EXFIL CALLED");
      level notify("call_exfil", self.origin);
      return;
    }

    if(self meleeButtonPressed()) {
      var_0 = 0;

      while(self meleeButtonPressed()) {
        var_0++;
        wait 0.05;

        if(var_0 >= 60) {
          break;
        }
      }

      if(var_0 >= 60) {
        self iprintlnbold("EXFIL CALLED");
        level notify("call_exfil", self.origin);
        return;
      }
    }

    wait 0.1;
  }
}

_id_953C(var_0, var_1, var_2) {
  self notify("listen_for_exfil");
  self endon("listen_for_exfil");

  if(!isDefined(var_0)) {
    var_0 = "exfil_location";
  }

  level waittill("call_exfil", var_3, var_4);
  var_5 = scripts\engine\utility::getstruct("player_exfil", "targetname");

  if(isDefined(level._id_B444)) {
    var_5 = level._id_B444;
  }

  var_6 = scripts\common\vehicle::vehicle_spawn(var_5);
  var_6 thread _id_42D7();
  var_6._id_7095 = 1;
  var_6.health = 100000;
  var_6.maxhealth = 100000;
  var_6.team = "allies";
  var_6._id_CE7D = "allies";
  var_6 _meth_83A6("allies");
  var_6 setCanDamage(0);

  if(istrue(var_4)) {
    level._id_5709 = var_6;
  }

  var_7 = scripts\engine\utility::_id_6969(var_3, scripts\engine\utility::getStructArray(var_0, "targetname"));

  if(isDefined(level._id_FDBA)) {
    magicgrenademanual("deploy_airdrop_mp", getgroundposition(var_7.origin, 16), (0, 90, 0), 0.01);
  } else {
    var_7._id_DE31 = _id_0747::_id_DE33(var_7.origin, 1);
  }

  var_6._id_5716 = var_7;
  var_8 = _id_0748::_id_C583("exfil_loc", 10);
  _func_016B(var_8, "current");
  _func_0163(var_8, var_7.origin - (0, 0, 100));
  _func_015D(var_8, "icon_waypoint_objective_general");
  _func_0179(var_8, "icon_regular");
  _func_0176(var_8, 1);
  _func_0172(var_8, 1);
  var_6._id_75E9 = _func_0353(var_6);
  _func_0355(var_6._id_75E9, "hud_icon_head_equipment_friendly");
  _func_035A(var_6._id_75E9, 12000);
  _func_0359(var_6._id_75E9, 1500);
  _func_035D(var_6._id_75E9, 10);
  _func_035B(var_6._id_75E9, 1);
  var_6._id_A911 = var_8;
  _id_E237(var_6);
  var_6 thread _id_C997();
  var_6 thread _id_107D3(var_8);
  var_6 waittill("wait_done");

  if(isDefined(var_1)) {
    var_6 _id_7062(var_7, var_1);
  } else {
    var_6 _id_7062(var_7, 1);
  }

  var_6 _id_5711(var_6, var_8, var_2);
}

_id_7062(var_0, var_1, var_2) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  self._id_7099 = 1;

  if(!isDefined(var_2) || !istrue(var_2)) {
    self _meth_8620(%est_blima_doors_open);
  }

  self vehicle_setspeed(90, 30);
  self setvehgoalpos(var_0.origin + (0, 0, 1200), 1);
  self waittill("goal");
  self vehicle_setspeed(15, 10);
  _id_1C17(self);
}

_id_107D3(var_0) {
  _func_0167(var_0, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  level thread scripts\cp\utility::_id_A8D1("exfil_enroute");
  _func_017B(var_0, 1);
  _func_0180(var_0, 0);
  _func_017A(var_0, 1);
  var_1 = 10;
  var_2 = 10;

  for(;;) {
    wait 1;
    var_2--;
    _func_0180(var_0, var_2 / var_1);

    if(var_2 <= 15) {
      self notify("wait_done");
    }

    if(var_2 <= 0) {
      return;
    }
  }
}

_id_7685(var_0) {
  var_0 endon("death");
  level notify("starting_cleanup");
  var_0._id_9F00 _meth_83A0("allies");
  var_0._id_9F00 setmode("manual");
  var_1 = gettime();
  var_2 = 0;

  for(;;) {
    var_3 = var_0 _id_65C8(var_0._id_5716.origin + (0, 0, -150));

    if(!isDefined(var_3)) {
      var_0._id_9F00 _meth_8086();
      wait 1;
      var_2++;

      if(var_2 >= 3) {
        return;
      }
    } else {
      var_2 = 0;
      var_4 = var_3.origin + (0, 0, 1100);
      var_0._id_9F00 _meth_8389(var_3);

      if(distance(var_4, var_0.origin) > 500) {
        var_0 setvehgoalpos(var_4, 1);
      }

      var_5 = var_0._id_9F00 scripts\engine\utility::_id_108F7("turret_on_target", 3);

      if(var_5 == "timeout") {
        var_0._id_9F00 _meth_8086();
        continue;
      } else if(gettime() > var_1) {
        for(var_6 = 0; var_6 < 35; var_6++) {
          var_0._id_9F00 _meth_83C1();
          wait 0.1;
        }

        var_1 = gettime() + 1000;
      }
    }
  }
}

_id_1C17(var_0) {
  var_0 setvehgoalpos(var_0._id_5716.origin + (0, 0, 1200), 1);
  var_0 waittill("goal");
  var_0 _meth_838A(var_0._id_5716.angles[1]);
  var_0 setyawspeed(50, 25, 25, 0);
  wait 3;
  level notify("arrive_at_exfil_location", var_0.origin);
  level._id_570A = var_0;
  var_0 thread _id_8CB7();
  var_0 thread _id_483D();
  var_0._id_0201 = 4;
  var_0 setvehgoalpos(var_0._id_5716.origin, 1);
  var_0 waittill("goal");
  var_0 _meth_8438(0);
  var_0 _meth_85C1();
  level notify("arrived_at_exfil_location");
  level._id_570A = undefined;
}

_id_483D() {
  self endon("goal");
  wait 4;

  if(!isDefined(level.vehicle)) {
    return;
  }
  if(!isDefined(level.vehicle._id_8300)) {
    return;
  }
  foreach(var_1 in level.vehicle._id_8300) {
    foreach(var_3 in var_1) {
      if(!isDefined(var_3) || !isDefined(var_3.origin)) {
        continue;
      }
      if(var_3 == self) {
        continue;
      }
      if(distance2d(var_3.origin, self.origin) < 512) {
        var_3 dodamage(var_3.health + 1000, self.origin);
      }
    }
  }
}

_id_8CB7() {
  self endon("goal");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self)) {
        thread _id_A1F1(var_1);
      }

      thread _id_8D4C(var_1);
      thread _id_8D4F(var_1);
    }

    if(isDefined(level._id_7C23)) {
      foreach(var_4 in level._id_7C23) {
        if(isDefined(var_4) && !istrue(var_4._id_32B9) && distance2d(self.origin, var_4.origin) <= 200) {
          thread _id_A1DD(var_4);
        }
      }
    }

    waitframe();
  }
}

_id_8D4F(var_0) {
  if(isDefined(var_0._id_ECEA) && _func_0107(var_0._id_ECEA) && var_0._id_ECEA.size > 0) {
    foreach(var_2 in var_0._id_ECEA) {
      if(isDefined(var_2) && isDefined(var_2._id_3A5F)) {
        if(var_2 istouching(self) || var_2._id_3A5F istouching(self)) {
          var_2 _id_094E::_id_EC99(0.05);
        }
      }
    }
  }
}

_id_8D4C(var_0) {
  if(isDefined(var_0._id_B161)) {
    if(isDefined(var_0._id_B161["sentry_turret"]) && _func_0107(var_0._id_B161["sentry_turret"]) && var_0._id_B161["sentry_turret"].size > 0) {
      foreach(var_2 in var_0._id_B161["sentry_turret"]) {
        if(isDefined(var_2)) {
          if(var_2 istouching(self)) {
            var_2 notify("kill_turret", 1, 0);
          }
        }
      }
    }

    if(isDefined(var_0._id_B161["manual_turret"]) && _func_0107(var_0._id_B161["manual_turret"]) && var_0._id_B161["manual_turret"].size > 0) {
      foreach(var_2 in var_0._id_B161["manual_turret"]) {
        if(isDefined(var_2)) {
          if(var_2 istouching(self)) {
            var_2 notify("kill_turret", 1, 0);
          }
        }
      }
    }
  }
}

_id_A1F1(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectornormalize(var_1);
  var_1 = var_1 * 200;
  var_1 = (var_1[0], var_1[1], 0);
  var_0 setorigin(var_0.origin + var_1, 1);
}

_id_A1DD(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectornormalize(var_1);
  var_1 = var_1 * 200;
  var_1 = (var_1[0], var_1[1], 0);
  var_0.origin = var_0.origin + var_1;
  var_0 notify("displaced");
}

_id_65C8(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 2250000;
  }

  var_2 = _id_06FE::_id_68A1("axis");
  var_2 = _func_0204(var_2, self.origin);

  foreach(var_4 in var_2) {
    if(!isalive(var_4)) {
      continue;
    }
    if(distancesquared(var_4.origin, var_0) < var_1 && scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, -250), var_4.origin + (0, 0, 100), var_2)) {
      return var_4;
    }
  }

  return undefined;
}

_id_76EF(var_0, var_1) {
  var_2 = "tag_flash";
  var_3 = (-64, 0, 0);
  var_4 = self gettagorigin(var_2);

  if(!isDefined(var_1)) {
    var_1 = "sentry_minigun_mp";
  }

  self._id_9F00 = spawnturret("misc_turret", var_4, var_1);
  self._id_9F00.angles = self gettagangles(var_2);

  if(isDefined(var_0)) {
    self._id_9F00 setModel(var_0);
  } else {
    self._id_9F00 setModel("veh8_mil_air_ahotel64_turret_wm");
  }

  self._id_9F00 linkto(self, var_2, var_3, (0, 0, 0));
  self._id_9F00 _meth_83A0("axis");
  self._id_9F00 setmode("auto_nonai");
  self._id_9F00 setdefaultdroppitch(0);
  self._id_9F00 _meth_8331(360);
  self._id_9F00 _meth_8372(360);
  self._id_9F00 _meth_8395(180);
  self._id_9F00 _meth_82F0(180);
  self._id_9F00 _meth_8302(0.05, "yaw");
  self._id_9F00 _meth_8302(0.05, "pitch");
}

_id_C997() {
  self endon("death");

  for(;;) {
    playrumbleonposition("cp_chopper_rumble", self.origin);
    wait 0.2;
  }
}

_id_C82F(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("disconnect");

  for(;;) {
    _id_0706::_id_17FD(var_0, var_0._id_B5A4, "exfil_idle", "body_animate_jnt");
  }
}

_id_42D7() {
  self endon("death");
  var_0 = spawn("trigger_radius", self.origin, 0, 350, 64);
  var_0 _meth_80DB();
  var_0 linkto(self, "tag_origin");
  var_1 = spawn("trigger_radius", self gettagorigin("tail_rotor_jnt"), 0, 64, 64);
  var_1 _meth_80DB();
  var_1 linkto(self, "tail_rotor_jnt");
  var_0 thread _id_253A(self);
  var_1 thread _id_253A(self);
}

_id_253A(var_0) {
  var_0 endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(istrue(var_1.inlaststand)) {
      var_1 notify("force_bleed_out");
      continue;
    }

    if(istrue(var_1._id_88DF)) {
      var_1 _id_0738::_id_8C13();
    }

    var_1 setvelocity((-500, 0, 500));
    var_1._id_DBD8 = 1;
    var_1 dodamage(var_1.health + 1000, self.origin);
  }
}