/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2340.gsc
*************************************************/

main() {
  _id_C1E4();
  _id_CDBF();
  level._id_1F9C = 0;
  level._id_5827 = ::_id_253B;
  level._id_582F = 0;
  level._id_5822 = 30 + 10 * level._id_582F;
  level._id_F1FD = level._id_5822;

  if(!isDefined(level._id_5831)) {
    level._id_5831 = [];
  }
}

_id_253B() {}

#using_animtree("script_model");

_id_CDBF() {
  level._id_CC34["pilot"] = #animtree;
  level._id_CC31["pilot"]["lbravo_exfil"] = % mp_infil_lbravo_a_pilot;
  level._id_CC32["pilot"]["lbravo_exfil"] = "mp_infil_lbravo_a_pilot";
  level._id_CC34["pilot"] = #animtree;
  level._id_CC31["pilot"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_pilot_loop;
  level._id_CC32["pilot"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_pilot_loop";
  level._id_CC34["pilot"] = #animtree;
  level._id_CC31["pilot"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_pilot_loop_exit;
  level._id_CC32["pilot"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_pilot_loop_exit";
  level._id_CC34["copilot"] = #animtree;
  level._id_CC31["copilot"]["lbravo_exfil"] = % mp_infil_lbravo_a_copilot;
  level._id_CC32["copilot"]["lbravo_exfil"] = "mp_infil_lbravo_a_copilot";
  level._id_CC34["copilot"] = #animtree;
  level._id_CC31["copilot"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_copilot_loop;
  level._id_CC32["copilot"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_copilot_loop";
  level._id_CC34["copilot"] = #animtree;
  level._id_CC31["copilot"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_copilot_loop_exit;
  level._id_CC32["copilot"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_copilot_loop_exit";
  level._id_CC34["slot_0"] = #animtree;
  level._id_CC31["slot_0"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy1_wm;
  level._id_CC32["slot_0"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy1_wm";
  level._id_CC3B["slot_0"]["lbravo_exfil"] = "infil_lbravo_a_1";
  level._id_CC31["slot_0"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy1_exit_wm;
  level._id_CC32["slot_0"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy1_exit_wm";
  level._id_CC3B["slot_0"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_1";
  level._id_CC31["slot_0"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy1_loop_wm;
  level._id_CC32["slot_0"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy1_loop_wm";
  level._id_CC3B["slot_0"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_1";
  level._id_CC31["slot_0"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy1_loop_exit_wm;
  level._id_CC32["slot_0"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy1_loop_exit_wm";
  level._id_CC3B["slot_0"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_1";
  level._id_CC34["slot_1"] = #animtree;
  level._id_CC31["slot_1"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy2_wm;
  level._id_CC32["slot_1"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy2_wm";
  level._id_CC3B["slot_1"]["lbravo_exfil"] = "infil_lbravo_a_2";
  level._id_CC31["slot_1"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy2_exit_wm;
  level._id_CC32["slot_1"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy2_exit_wm";
  level._id_CC3B["slot_1"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_2";
  level._id_CC31["slot_1"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy2_loop_wm;
  level._id_CC32["slot_1"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy2_loop_wm";
  level._id_CC3B["slot_1"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_2";
  level._id_CC31["slot_1"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy2_loop_exit_wm;
  level._id_CC32["slot_1"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy2_loop_exit_wm";
  level._id_CC3B["slot_1"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_2";
  level._id_CC34["slot_2"] = #animtree;
  level._id_CC31["slot_2"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy3_wm;
  level._id_CC32["slot_2"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy3_wm";
  level._id_CC3B["slot_2"]["lbravo_exfil"] = "infil_lbravo_a_3";
  level._id_CC31["slot_2"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy3_exit_wm;
  level._id_CC32["slot_2"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy3_exit_wm";
  level._id_CC3B["slot_2"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_3";
  level._id_CC31["slot_2"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy3_loop_wm;
  level._id_CC32["slot_2"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy3_loop_wm";
  level._id_CC3B["slot_2"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_3";
  level._id_CC31["slot_2"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy3_loop_exit_wm;
  level._id_CC32["slot_2"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy3_loop_exit_wm";
  level._id_CC3B["slot_2"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_3";
  level._id_CC34["slot_3"] = #animtree;
  level._id_CC31["slot_3"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy4_wm;
  level._id_CC32["slot_3"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy4_wm";
  level._id_CC3B["slot_3"]["lbravo_exfil"] = "infil_lbravo_a_4";
  level._id_CC31["slot_3"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy4_exit_wm;
  level._id_CC32["slot_3"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy4_exit_wm";
  level._id_CC3B["slot_3"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_4";
  level._id_CC31["slot_3"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy4_loop_wm;
  level._id_CC32["slot_3"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy4_loop_wm";
  level._id_CC3B["slot_3"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_4";
  level._id_CC31["slot_3"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy4_loop_exit_wm;
  level._id_CC32["slot_3"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy4_loop_exit_wm";
  level._id_CC3B["slot_3"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_4";
  level._id_CC34["slot_4"] = #animtree;
  level._id_CC31["slot_4"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy5_wm;
  level._id_CC32["slot_4"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy5_wm";
  level._id_CC3B["slot_4"]["lbravo_exfil"] = "infil_lbravo_a_5";
  level._id_CC31["slot_4"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy5_exit_wm;
  level._id_CC32["slot_4"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy5_exit_wm";
  level._id_CC3B["slot_4"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_5";
  level._id_CC31["slot_4"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy5_loop_wm;
  level._id_CC32["slot_4"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy5_loop_wm";
  level._id_CC3B["slot_4"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_5";
  level._id_CC31["slot_4"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy5_loop_exit_wm;
  level._id_CC32["slot_4"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy5_loop_exit_wm";
  level._id_CC3B["slot_4"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_5";
  level._id_CC34["slot_5"] = #animtree;
  level._id_CC31["slot_5"]["lbravo_exfil"] = % mp_infil_lbravo_a_guy6_wm;
  level._id_CC32["slot_5"]["lbravo_exfil"] = "mp_infil_lbravo_a_guy6_wm";
  level._id_CC3B["slot_5"]["lbravo_exfil"] = "infil_lbravo_a_6";
  level._id_CC31["slot_5"]["lbravo_exfil_exit"] = % mp_infil_lbravo_a_guy6_exit_wm;
  level._id_CC32["slot_5"]["lbravo_exfil_exit"] = "mp_infil_lbravo_a_guy6_exit_wm";
  level._id_CC3B["slot_5"]["lbravo_exfil_exit"] = "infil_lbravo_a_exit_6";
  level._id_CC31["slot_5"]["lbravo_exfil_loop"] = % mp_infil_lbravo_a_guy6_loop_wm;
  level._id_CC32["slot_5"]["lbravo_exfil_loop"] = "mp_infil_lbravo_a_guy6_loop_wm";
  level._id_CC3B["slot_5"]["lbravo_exfil_loop"] = "infil_lbravo_a_loop_6";
  level._id_CC31["slot_5"]["lbravo_exfil_loop_exit"] = % mp_infil_lbravo_a_guy6_loop_exit_wm;
  level._id_CC32["slot_5"]["lbravo_exfil_loop_exit"] = "mp_infil_lbravo_a_guy6_loop_exit_wm";
  level._id_CC3B["slot_5"]["lbravo_exfil_loop_exit"] = "infil_lbravo_a_loop_exit_6";
}

_id_0EB0() {
  if(istrue(self._id_24F1)) {
    return;
  }
  if(istrue(self._id_EC7E)) {
    return;
  }
  if(istrue(self._id_10841)) {
    return;
  }
  if(self isskydiving()) {
    return;
  }
  if(istrue(self._id_E3E5)) {
    return;
  }
  if(istrue(self._id_8A07)) {
    return;
  }
  if(istrue(self.inlaststand)) {
    return;
  }
  if(!istrue(self._id_581C)) {
    self iprintln("^3 Extraction on Cooldown for the next ^1" + level._id_F1FD + " ^3 Seconds");
    return;
  }

  if(isDefined(level._id_5830)) {
    self iprintln("^3 Extraction Vehicle already present in the map at ^1" + level._id_5830.origin);
    return;
  }

  level._id_582F++;
  level._id_582B = 1;

  foreach(var_1 in level.players) {
    var_1 notify("toggle_extraction_function", 0, self);
  }

  level._id_582B = undefined;
}

_id_6498() {
  level._id_5822 = 30 + 10 * level._id_582F;
  return level._id_5822;
}

_id_F2BE(var_0, var_1) {
  level._id_582B = 1;
  self notify("toggle_extraction_function", 0, var_1);
  level._id_F1FD = level._id_5822;
  level thread _id_F1FE();
  var_2 = gettime() + var_0 * 1000;

  for(var_3 = var_0; var_3 >= 0; var_3--) {
    wait 1;
  }

  self notify("toggle_extraction_function", 1, var_1);
  level._id_582B = undefined;
}

_id_F7FE(var_0, var_1) {
  level._id_F1FD = level._id_5822;
  level thread _id_F1FE();
  var_2 = gettime() + var_0 * 1000;

  for(var_3 = var_0; var_3 >= 0; var_3--) {
    wait 1;
  }

  self notify("toggle_extraction_function", 1, var_1);
}

_id_F1FE() {
  for(;;) {
    if(level._id_F1FD <= 0) {
      break;
    }

    level._id_F1FD--;
    wait 1;
  }
}

_id_5828() {
  self notify("extraction_function_toggle");
  self endon("extraction_function_toggle");

  for(;;) {
    self waittill("toggle_extraction_function", var_0, var_1);

    if(istrue(var_0)) {
      if(!istrue(self._id_581C)) {
        foreach(var_3 in level.players) {
          var_3._id_581C = 1;
        }
      }

      continue;
    }

    if(self == var_1) {
      if(!isDefined(self._id_5834)) {
        var_5 = spawnStruct();
        var_5.owner = self;
        var_5.streakname = "extraction";
        var_5._id_47EE = makeweapon("deploy_airdrop_mp");
        self._id_5834 = var_5;
      }

      var_6 = _id_09B9::_id_EA03(self._id_5834, self._id_5834._id_47EE, "grenade_fire", undefined, scripts\cp_mp\killstreaks\airdrop::_id_13A8, ::_id_13A7, undefined, scripts\cp_mp\killstreaks\airdrop::_id_13A9);

      if(!istrue(var_6)) {
        continue;
      }
    }

    level._id_582F++;
    level._id_582B = 1;
    level._id_582B = undefined;
    self iprintln(" Extraction FUNCTION ON COOLDOWN ");

    foreach(var_3 in level.players) {
      var_3 thread _id_F7FE(_id_6498(), var_1);
    }
  }
}

_id_13A7(var_0, var_1, var_2) {
  var_0._id_13AA = var_0.streakname;
  var_2.owner = self;
  var_2 thread _id_13A6(var_0._id_13AA);
  var_0._id_13A7 = 1;
  return "success";
}

_id_13A6(var_0, var_1) {
  level endon("game_ended");
  self notify("airDropMarkerActivate");
  self endon("airDropMarkerActivate");
  var_2 = self.owner.angles;
  self waittill("explode", var_3);
  var_4 = self.owner;

  if(!isDefined(var_4)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    return;
  }

  if(var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isKillStreakDenied")]]()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    return;
  }

  waitframe();
  _id_10D71(var_4._id_5834, var_3, var_4);
}

_id_10D71(var_0, var_1, var_2) {
  level._id_582E = scripts\engine\utility::_id_6369(var_1, scripts\engine\utility::getStructArray("cp_donetsk_heli_spawns", "targetname"), undefined, 1, 6669);
  var_3 = (var_1[0], var_1[1], 5000);

  if(level.script == "cp_donetsk") {
    if(level._id_582E.size > 0) {
      var_3 = (level._id_582E[0].origin[0], level._id_582E[0].origin[1], 5000);
    }
  }

  var_4 = (0, randomfloat(360), 0);
  var_5 = var_3 + -1 * anglesToForward(var_4) * 30000;
  var_3 = var_3 * (1, 1, 0);
  var_6 = var_3 + (0, 0, 5000);
  var_7 = 5000;
  level._id_5830 = _id_E319(0, var_2, var_5, var_6, var_2._id_5834, var_3);
  var_8 = vectortoangles(var_6 - var_5);
  level._id_5830._id_1031E = "little_bird";
  level._id_5830.speed = 50;
  level._id_5830.accel = 125;
  level._id_5830._id_8895 = 1;
  level._id_5830._id_04DE = "apache";
  level._id_5830 vehicle_setspeed(level._id_5830.speed, level._id_5830.accel);
  level._id_5830 sethoverparams(50, 100, 50);
  level._id_5830 setturningability(0.05);
  level._id_5830 setotherent(var_2);
  level._id_5830._id_AEDC = var_6;
  var_9 = randomint(10);
  var_10 = 10 + var_9;
  var_2 thread _id_A0F3(level._id_5830, var_1, "allies", var_10);
  level notify("extraction_called");
}

_id_E319(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_3 - var_2);
  var_7 = 99;
  var_8 = 99999;
  var_9 = spawnhelicopter(var_1, var_2, var_6, "lbravo_infil_mp", "veh8_mil_air_lbravo");

  if(!isDefined(var_9)) {
    return;
  }
  if(isDefined(var_5)) {
    var_9._id_991F = scripts\engine\utility::_id_5000(var_5) + (0, 0, 150);
  }

  var_9._id_42E9 = ::_id_2F40;
  var_10 = 1;
  var_9.speed = 50;
  var_9.accel = 125;
  var_9.health = var_8;
  var_9.maxhealth = var_9.health;
  var_9.team = var_1.team;
  var_9.owner = var_1;
  var_9 setCanDamage(var_10);
  var_9._id_461E = var_3;
  var_9._id_936C = var_0;
  var_9._id_8B45 = 1;
  var_9.streakinfo = var_4;
  var_9.streakname = var_4.streakname;
  var_9.streakinfo = var_4;
  var_9._id_5C8A = var_7;
  var_9 setmaxpitchroll(0, 90);
  var_9 vehicle_setspeed(var_9.speed, var_9.accel);
  var_9 sethoverparams(50, 100, 50);
  var_9 setturningability(0.05);
  var_9 setyawspeed(45, 25, 25, 0.5);
  var_9 setotherent(var_1);
  var_9._id_572A = level.players.size;
  var_11 = _id_0748::_id_C583("exfil_loc", 10);
  _func_016B(var_11, "current");
  _func_0163(var_11, var_9._id_991F + (0, 0, 20));
  _func_015D(var_11, "icon_waypoint_extract");
  _func_0179(var_11, "icon_regular");
  _func_0176(var_11, 1);
  _func_0172(var_11, 1);
  level thread _id_DC3A(var_11, var_2, var_3, var_9);
  var_9 thread _id_0927::_id_8CB7();
  var_9._id_A911 = var_11;
  _id_0927::_id_E237(var_9);
  var_9._id_A923 = [];
  var_9._id_AE9D[0] = self;
  var_9._id_AE9D[1] = self;
  var_9._id_AE9D[2] = self;
  var_9._id_AE9D[3] = self;
  var_9._id_AE9D[4] = self;
  var_9._id_AE9D[5] = self;
  var_9 _id_80EF();
  level._id_5831[level._id_5831.size] = var_9;
  level._id_5831 = scripts\engine\utility::_id_1BD1(level._id_5831);
  var_9 thread _id_072B::_id_5C7F(undefined, undefined);
  var_9 thread _id_958F();
  return var_9;
}

_id_DC3A(var_0, var_1, var_2, var_3) {
  var_3 endon("death");
  var_3 endon("goal");
  level endon("vehicle_descent");
  _func_0167(var_0, &"CP_BR_SYRK_OBJECTIVES/EXFIL_ENROUTE");
  _func_017B(var_0, 1);
  _func_0180(var_0, 0);
  _func_017A(var_0, 1);
  var_4 = distance(var_1, var_2) / 50;

  for(;;) {
    wait 1;
    var_5 = distance(var_3.origin, var_2) / 50;
    _func_0180(var_0, var_5 / var_4);

    if(var_5 <= 0) {
      return;
    }
  }
}

_id_80EF(var_0) {
  self._id_8396 = [];
  var_1 = self gettagorigin("tag_passenger1");
  var_2 = self gettagorigin("tag_passenger2");
  var_3 = self gettagorigin("tag_passenger3");
  var_4 = self gettagorigin("tag_passenger4");
  var_5 = self gettagorigin("tag_passenger5");
  var_6 = self gettagorigin("tag_passenger6");
  _id_3F09(var_2, &"MP/HOLD_TO_GET_ON_CHOPPER", 2, var_0);
  _id_3F09(var_3, &"MP/HOLD_TO_GET_ON_CHOPPER", 4, var_0);
  _id_3F09(var_5, &"MP/HOLD_TO_GET_ON_CHOPPER", 3, var_0);
  _id_3F09(var_6, &"MP/HOLD_TO_GET_ON_CHOPPER", 5, var_0);
}

_id_3F09(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0);
  var_4 setModel("tag_origin");
  var_4 linkto(self);
  var_4 sethintstring(var_1);
  var_4 setcursorhint("HINT_BUTTON");
  var_4 _meth_84D4(200);
  var_4 sethintdisplayfov(90);
  var_4 setuserange(72);
  var_4 setusefov(90);
  var_4 _meth_84D9("hide");
  var_4 setuseholdduration("duration_short");
  var_4 thread _id_5717(self, var_2, var_3);
  self._id_8396[self._id_8396.size] = var_4;
}

_id_5717(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    _id_99E0(var_2);
  } else {
    _id_99E1(var_0.team);
  }

  for(;;) {
    self waittill("trigger", var_3);
    self makeunusable();
    var_0 _id_572E(var_3, var_1, self);
  }
}

_id_99E1(var_0) {
  self makeuseable();
  thread _id_0DA7(var_0);
}

_id_99E0(var_0) {
  self makeuseable();
  thread _id_0DA6(var_0);
}

_id_0DA7(var_0) {
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        self showtoplayer(var_2);
        self _meth_80E0(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("joined_team");
  }
}

_id_0DA6(var_0) {
  self endon("death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2 == var_0) {
        self showtoplayer(var_2);
        self _meth_80E0(var_2);
        continue;
      }

      self disableplayeruse(var_2);
      self hidefromplayer(var_2);
    }

    level waittill("joined_team");
  }
}

_id_572E(var_0, var_1, var_2) {
  if(!isDefined(self._id_572A)) {
    self._id_572A = level.players.size;
  }

  if(self._id_572A > 0) {
    var_0 thread _id_B659(self, var_1);
    self._id_A923 = scripts\engine\utility::array_add(self._id_A923, var_0);
    var_2._id_A926 = var_0;

    foreach(var_4 in self._id_8396) {
      if(var_4 != var_2) {
        var_4 thread _id_99E1(self.team);
      }
    }

    thread _id_4AD7(var_0, var_1, var_2);
    self._id_572A--;

    if(self._id_572A <= 0) {
      self notify("exfil_leave");
      return;
    }
  } else
    self notify("exfil_leave");
}

_id_4AD7(var_0, var_1, var_2) {
  foreach(var_4 in self._id_8396) {
    var_4 disableplayeruse(var_0);
  }

  if(isDefined(var_2)) {
    var_0 thread _id_5252(var_1, self, var_2);
  }
}

_id_5252(var_0, var_1, var_2) {
  var_3 = spawn("script_model", self.origin);
  var_3 setModel("tag_origin");
  var_3 linkto(self);
  var_3 sethintstring(&"MP/HOLD_TO_GET_OFF_CHOPPER");
  var_3 setcursorhint("HINT_NOICON");
  var_3 _meth_84D4(200);
  var_3 sethintdisplayfov(90);
  var_3 setuserange(200);
  var_3 setusefov(360);
  var_3 _meth_84D9("hide");
  var_3 setuseholdduration("duration_short");
  var_3 thread _id_570C(var_1, self, var_0, var_2);
  var_1._id_5786 = var_3;
}

_id_570C(var_0, var_1, var_2, var_3) {
  _id_99E0(var_1);

  for(;;) {
    self waittill("trigger", var_1);
    self makeunusable();
    var_1 _meth_820B(1, 0.25, 0.25, 0, 0, 0, 0);
    var_0._id_572A++;
    var_1 _meth_8655();
    var_0 _id_0706::_id_17FD(var_1, var_1._id_B5A4, "lbravo_exfil_loop_exit", "origin_animate_jnt");
    var_1._id_B5A4 unlink();
    var_1 unlink();
    var_3 _id_99E1(var_0.team);
    var_0._id_A923 = scripts\engine\utility::array_remove(var_0._id_A923, var_1);
    var_3._id_A926 = undefined;

    foreach(var_5 in level.players) {
      if(scripts\engine\utility::array_contains(var_0._id_A923, var_5)) {
        var_3 hidefromplayer(var_5);
        var_3 disableplayeruse(var_5);
      }
    }

    foreach(var_8 in var_0._id_8396) {
      if(!isDefined(var_8._id_A926)) {
        var_8 showtoplayer(var_1);
        var_8 _meth_80E0(var_1);
        continue;
      }

      var_8 hidefromplayer(var_8._id_A926);
      var_8 disableplayeruse(var_8._id_A926);
    }

    var_1 notify("remove_rig");
    var_1._id_B5A4 delete();
    var_0 notify("unloaded");
    self delete();
  }
}

_id_B70F(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0._id_5817 = 1;
  var_0._id_E355 = 1;

  while(!var_0 isonground()) {
    waitframe();
  }

  var_0 allowmovement(0);
  var_0 playerlinkto(var_1, "tag_passenger" + var_2, 1.0, 180, -180, 180, 180, 0);
}

_id_B659(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(!isDefined(var_1)) {
    for(var_2 = 0; var_2 < var_0._id_AE9D.size; var_2++) {
      if(var_0._id_AE9D[var_2] == var_0._id_5849) {
        var_0._id_AE9D[var_2] = self;
        var_1 = var_2;
      }
    }

    var_0 thread _id_4AD7(self);
  }

  thread _id_582C("slot_" + var_1, "viewhands_base_iw8");
  self._id_B5A4 linkto(var_0, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));

  switch (var_1) {
    case 0:
      self _meth_820B(1, 0.25, 0.25, 35, 180, 90, 45);
      break;
    case 1:
      self _meth_820B(1, 0.25, 0.25, 180, 35, 90, 45);
      break;
    case 4:
    case 2:
      self _meth_820B(1, 0.25, 0.25, 75, 135, 90, 45);
      break;
    case 5:
    case 3:
      self _meth_820B(1, 0.25, 0.25, 135, 45, 90, 45);
      break;
    default:
      self _meth_820B(1, 0.25, 0.25, 45, 45, 45, 45);
      break;
  }

  level endon("game_ended");
  self._id_5817 = 1;
  _id_C82F(var_0);
}

_id_582C(var_0, var_1, var_2) {
  self._id_18AF = var_0;
  self _meth_8282(self.origin);
  var_3 = spawn("script_arms", self.origin, 0, 0, self);
  var_3.angles = self.angles;
  var_3.player = self;
  self._id_B5A4 = var_3;
  self._id_B5A4 hide(1);
  self._id_B5A4._id_18AF = var_0;
  self._id_B5A4 useanimtree(#animtree);
  self._id_B5A4._id_FC55 = 1;
  self._id_B5A4._id_3717 = _id_0A94::_id_7427;
  self playerlinktodelta(self._id_B5A4, "tag_player", 1.0, 0, 0, 0, 0, 1);

  if(isDefined(var_2) && var_2) {
    self _meth_8272(self._id_B5A4);
  }

  self notify("rig_created");
  scripts\engine\utility::waittill_any_2("remove_rig", "player_free_spot");

  if(isDefined(var_2) && var_2) {
    self _meth_8272(undefined);
  }

  if(isDefined(self)) {
    self unlink();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_C82F(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  var_0 endon("unload");
  var_0 endon("unloaded");

  while(isDefined(var_0)) {
    var_0 _id_0706::_id_17FD(self, self._id_B5A4, "lbravo_exfil_loop", "origin_animate_jnt");
  }
}

_id_C1E4() {
  _id_0737::_id_C266("extraction", ::_id_7963, ::_id_0EAF, ::_id_7F7F, 0, "duration_long");
}

_id_7F7F(var_0) {
  if(var_0.size > 0) {
    foreach(var_2 in var_0) {}
  }
}

_id_7963(var_0, var_1) {
  return &"";
}

_id_0EAF(var_0, var_1) {}

_id_46CE(var_0, var_1) {
  self endon("death");
  _id_0733::waitlongdurationwithhostmigrationpause(var_0);
  self playLoopSound(var_1);
}

_id_958F() {
  self endon("jackal_gone");
  var_0 = self.owner;
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_8EE2)) {
    self vehicle_setspeed(25, 5);
    thread _id_958C(75);
    _id_0733::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self._id_991F)) {
    self._id_991F notify("extraction_destroyed");
  }

  _id_9591();
}

_id_9591() {
  self playSound("dropship_explode_mp");
  level._id_5831[level._id_5831.size - 1] = undefined;
  self notify("explode");
  wait 0.35;
  thread _id_958D();
}

_id_958D() {
  if(isDefined(self._id_F81F)) {
    self._id_F81F delete();
  }

  if(isDefined(self._id_319B)) {
    self._id_319B delete();
  }

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  foreach(var_1 in self._id_8396) {
    var_1 delete();
  }

  self delete();
}

_id_958C(var_0) {
  self endon("explode");
  self _meth_807E();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  _id_0733::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self _meth_838A(self.angles[1] + var_0 * 2.5);
}

_id_2F40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(isDefined(var_1)) {
    if(isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }
  }

  if((var_1 == self || isDefined(var_1.pers) && var_1.pers["team"] == self.team && !level._id_5FA5 && level.teambased) && var_1 != self.owner) {
    return;
  }
  if(self.health <= 0) {
    return;
  }
  if(self.health <= var_2) {
    if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {}
  }

  if(self.health - var_2 <= 900 && (!isDefined(self._id_DE57) || !self._id_DE57)) {
    self._id_DE57 = 1;
  }

  self _meth_842C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_A0F3(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("leaving");
  var_0 setvehgoalpos(var_0._id_AEDC, 1);
  var_0 thread _id_33E0(var_0._id_AEDC);
  var_0 waittill("goal");
  level notify("vehicle_descent");

  if(isDefined(var_0._id_A911)) {
    _func_015C(var_0._id_A911);
  }

  var_0 thread _id_10B65();

  if(isDefined(var_3)) {
    var_4 = var_0.speed;
    var_5 = var_0.accel;
  } else {
    var_4 = var_0.speed / 4;
    var_5 = var_0.accel / 6;
  }

  var_0 vehicle_setspeed(var_4, var_5);
  var_0 _id_958E(var_1, var_0._id_110CF, var_2);
}

_id_9592() {
  self endon("death");
  var_0 = self.speed;
  var_1 = self.accel;
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self._id_916C = 1;
  self _meth_807E();
  var_2 = int(self.speed / 14);
  var_3 = int(self.accel / 16);

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  self vehicle_setspeed(var_2, var_3);
  var_4 = self.origin + (0, 0, 5000);
  self setvehgoalpos(var_4, 1);

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  self waittill("goal");
  var_4 = self.origin + anglesToForward((0, randomint(360), 0)) * 5000;
  var_4 = var_4 + (0, 0, 1000);
  self setvehgoalpos(var_4, 1);

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  self waittill("goal");
  var_5 = _id_6C1C();
  self vehicle_setspeed(250, 75);
  self setvehgoalpos(var_5, 1);
  self waittill("goal");
  self stoploopsound();
  level._id_5831[level._id_5831.size - 1] = undefined;
  self notify("jackal_gone");

  if(self._id_A923.size == level.players.size) {
    level thread[[level._id_52F7]]("allies", level._id_52A0["win"]);
  } else {
    foreach(var_7 in self._id_A923) {
      var_7 iprintln(" GAME OVER OVER OVER OVER!! ");
      kick(var_7 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
    }
  }

  _id_958D();
}

_id_6C1C() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

_id_958E(var_0, var_1, var_2) {
  _id_4809(var_0, var_1);
  scripts\engine\utility::_id_108A7(60, "infinite");
  thread _id_9592();
}

_id_4809(var_0, var_1) {
  self endon("bugOut");
  var_2 = undefined;
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = _id_F3C9(var_3, var_4, 0);
  var_2 = (var_3, var_4, var_5);
  var_2 = self._id_991F;
  self _meth_807E();
  self setvehgoalpos(var_2, 1);
  self waittill("goal");
  self sethoverparams(0, 0, 0);
  self _meth_8438(0);
}

_id_F3C9(var_0, var_1, var_2, var_3) {
  var_4 = 30;
  var_5 = _id_F3CB(var_0, var_1, var_3);
  var_6 = var_5 + var_4;
  return var_6;
}

_id_F3CB(var_0, var_1, var_2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_3 = -99999;
  var_4 = self.origin[2] + 2000;
  var_5 = level._id_1F9C;
  var_6 = [self];

  if(isDefined(self._id_502B)) {
    foreach(var_8 in self._id_502B) {
      var_6[var_6.size] = var_8;
    }
  }

  var_10 = 256;

  if(isDefined(var_2)) {
    var_11 = scripts\engine\trace::ray_trace((var_0, var_1, var_4), (var_0, var_1, var_3), var_6, undefined, undefined, 1);
  } else {
    var_11 = scripts\engine\trace::_id_E409((var_0, var_1, var_4), (var_0, var_1, var_3), 256, var_6, undefined, 1);
  }

  if(var_11["position"][2] < var_5) {
    var_12 = var_5;
  } else {
    var_12 = var_11["position"][2];
  }

  return var_12;
}

_id_10B65() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread _id_9592();
}

_id_33E0(var_0) {
  self endon("goal");
  self endon("death");
  self endon("leaving");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

_id_0E0A() {
  thread _id_9592();
}