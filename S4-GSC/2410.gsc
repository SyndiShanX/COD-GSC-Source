/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2410.gsc
*************************************************/

_id_E5F1(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  _id_8131();
  level._id_7753 = _id_E0F6(var_0, var_1);
  level._id_7753 _id_0927::_id_7062(level._id_7753._id_5716, 1);
  level._id_7753 thread _id_1072E(var_3);
  level._id_7753 scripts\engine\utility::waittill_any_2("all_players_on_board", "heli_trip_timed_out");

  if(isDefined(level._id_7753)) {
    _func_02B1(level._id_7753._id_A3E5);
  }

  level notify("heli_trip_took_off");
  level._id_7753 notify("heli_taking_off");
  level._id_7753 _id_06EB::_id_1022D(var_2);
  level._id_7753 notify("unload");
  level notify("heli_trip_over");
  wait 2;
  level._id_7753 thread _id_5752();
  level._id_77E6 = undefined;
}

#using_animtree("script_model");

_id_B73A(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  var_1 = "tag_seat_2";

  switch (var_0) {
    case "seat1":
      var_1 = "tag_seat_2";
      break;
    case "seat2":
      var_1 = "tag_seat_3";
      break;
    case "seat3":
      var_1 = "tag_seat_4";
      break;
    case "seat4":
      var_1 = "tag_seat_5";
      break;
  }

  self disableusability();
  self allowmelee(0);
  self disableoffhandweapons();
  self._id_86A3 = 1;
  _id_670A();
  thread scripts\cp\cp_outofbounds::enableoobimmunity(self);
  thread _id_3F5D(self, "player");
  _id_06C6::_id_17C2(self._id_B5A4, "blima_getin");
  _id_94F0(self, 0.4);
  self._id_B5A4._id_10D19 = _id_0736::_id_74B5;
  level._id_7753 thread _id_0706::_id_17FD(self, self._id_B5A4, "blima_getin", var_1);
  wait(_func_0079(%sdr_cp_veh_lbravo_seat_2_getin));
  self._id_B5A4 linkto(level._id_7753, "body_animate_jnt", (0, 0, 0), (0, 0, 0));
  self _meth_820B(1, 0.25, 0.25, 60, 60, 30, 30);
  self._id_7D98 = 1;
  level._id_7753 notify("player_boarded_heli");
  thread _id_10B2E();
  thread _id_C82F(var_1);
  level._id_7753 waittill("unload");
  self _meth_820B(1, 0.25, 0.25, 0, 0, 0, 0);
  self _meth_8655();
  self notify("remove_rig");
  self _meth_84AC("normal");
  self _meth_8656();
  self enableusability();
  self allowmelee(1);
  self enableoffhandweapons();
  self._id_86A3 = 0;
  thread scripts\cp\cp_outofbounds::disableoobimmunity(self);
  _id_0736::_id_EDC4();
  self._id_7D98 = undefined;
}

_id_670A() {
  if(scripts\cp\cp_weapon::_id_B4C8(self)) {
    scripts\cp\cp_weapon::_id_4FF4(self);
    var_0 = undefined;
    var_1 = self getweaponslistprimaries();

    foreach(var_3 in var_1) {
      if(isnullweapon(var_3)) {
        continue;
      }
      if(scripts\cp\utility::_id_8A09(var_3)) {
        continue;
      } else if(!isDefined(var_0)) {
        var_4 = var_3 _meth_8628();

        if(var_4._id_0241 != "primary") {
          continue;
        }
        var_0 = var_3;
      }
    }

    if(isDefined(var_0)) {
      childthread scripts\cp_mp\utility\inventory_utility::_id_5ED6(var_0);
    }
  }
}

_id_3F5D(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0._id_18AF = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0 _meth_8282(var_0.origin);
  var_3 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0._id_B5A4 = var_3;
  var_0._id_B5A4 hide();
  var_0._id_B5A4._id_18AF = var_1;
  var_0._id_B5A4 useanimtree(#animtree);
  var_0._id_B5A4.angles = scripts\engine\utility::ter_op(isDefined(var_0.angles), var_0.angles, (0, 0, 0));
  var_0 _id_10A7E();
  _id_C436(var_0);
}

_id_10A7E(var_0) {
  scripts\engine\utility::waittill_any_3("remove_rig", "death", "disconnect");
}

_id_C436(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0 unlink();
  var_0._id_B5A4 delete();
  var_0._id_B5A4 = undefined;
}

_id_94F0(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(var_0) || !isDefined(var_0._id_B5A4)) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0.2;
  }

  var_0 playerlinktoblend(var_0._id_B5A4, "tag_player", var_1, 0.25, 0.25);
  wait(var_1);
  var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 1, 0, 0, 0, 0, 1, 1, 1);
}

_id_C82F(var_0) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  level._id_7753 endon("unload");

  for(;;) {
    level._id_7753 _id_0706::_id_17FD(self, self._id_B5A4, "blima_idle", var_0);
  }
}

_id_10B2E() {
  self endon("death");
  self endon("disconnect");
  level._id_7753 endon("heli_taking_off");

  for(;;) {
    wait 10;
    level thread _id_0750::_id_F759(self, "obj_exfil_nag");
  }
}

_id_668A() {
  if(!isDefined(level._id_A47B)) {
    level._id_77E6 = 0;
  }

  level._id_77E6++;
  level._id_77E6 = clamp(level._id_77E6, 1, 4);
  return "seat" + level._id_77E6;
}

_id_95C7(var_0) {
  var_1 = self;
  var_1._id_103EE = var_0._id_7A89;

  if(!isDefined(var_1._id_7C18)) {
    var_1._id_7C18 = "left";
  }

  level thread _id_4C1F(var_0);
}

_id_4C1F(var_0) {
  level endon("game_ended");

  while(istrue(level._id_8A9B)) {
    wait 1;
  }

  wait(level thread _id_0750::_id_F759(var_0, "obj_secured"));
  level notify("cp_heli_trip_obj_secured_vo_done");
}

_id_1464() {
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(_id_073B::_id_B4EF(var_3)) {
      var_1++;
    }

    if(istrue(var_3._id_7D98)) {
      var_0++;
    }
  }

  return var_0 > 0 && level.players.size == var_0 + var_1;
}

_id_8AE8(var_0) {
  if(!isPlayer(self)) {
    return 0;
  }

  if(!isDefined(self)) {
    return 0;
  }

  if(!isDefined(var_0) && _id_073B::_id_B4EF(self)) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(self.sessionstate == "spectator") {
    return 0;
  }

  return 1;
}

_id_106F1() {
  level endon("game_ended");
  level._id_7753 endon("all_players_on_board");
  level._id_7753 endon("heli_trip_timed_out");

  for(;;) {
    if(_id_1464()) {
      level._id_7753 notify("all_players_on_board");
      return;
    }

    wait 0.1;
  }
}

_id_E0F6(var_0, var_1) {
  var_2 = scripts\common\vehicle::vehicle_spawn(var_0);
  var_2._id_10263 = 1;
  var_2._id_CD0F = 0;
  var_2._id_43B8 = 1;
  var_2._id_5716 = var_1;
  var_1._id_DE31 = _id_0747::_id_DE33(var_1.origin, 1);
  _id_0927::_id_E237(var_2);
  var_2._id_7095 = 1;
  var_2.health = 10000;
  var_2.maxhealth = 10000;
  var_2.team = "allies";
  var_2._id_CE7D = "allies";
  var_2 _meth_83A6("allies");
  var_2 setCanDamage(0);
  var_2 _id_E2FC();

  if(isDefined(var_2._id_10E83)) {
    if(!isDefined(var_2._id_0F7F)) {
      var_2._id_0F7F = [];
    }

    var_2._id_0F7F[var_2._id_0F7F.size] = var_2._id_10E83;
  }

  var_2._id_75E9 = _func_0353(var_2);
  _func_0355(var_2._id_75E9, "hud_icon_head_equipment_friendly");
  _func_035A(var_2._id_75E9, 12000);
  _func_0359(var_2._id_75E9, 1500);
  _func_035D(var_2._id_75E9, 10);
  _func_035B(var_2._id_75E9, 1);
  return var_2;
}

_id_E2FC(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "body_mp_western_fireteam_west_ar_1_1_lod1";
  }

  if(!isDefined(var_1)) {
    var_1 = "head_sas_urban_ar_rain";
  }

  var_2 = self;
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("allied_pilot_fullbody_3");
  var_3 useanimtree(level._id_CC34["exfil_ally"]);
  var_3._id_18AF = "exfil_ally";
  var_4 = getstartorigin(var_2.origin, var_2.angles, level._id_CC31["exfil_ally"]["blima_drop_l_idle_in"]);
  var_5 = _func_00D2(var_2.origin, var_2.angles, level._id_CC31["exfil_ally"]["blima_drop_l_idle_in"]);
  var_3.origin = var_4;
  var_3.angles = var_5;
  var_3 linkto(var_2);
  var_2._id_10E83 = var_3;
  var_2 thread _id_7CB5(var_3);
}

_id_7CB5(var_0) {
  self endon("death");
  var_0 endon("stop_idle_anim");

  for(;;) {
    _id_06C6::_id_1845(var_0, "blima_drop_l_idle_in", "tag_origin");
  }
}

_id_1072E(var_0) {
  level endon("game_ended");
  self solid();
  self._id_A3E5 = _func_02AF(self.origin, (350, 350, 350), (0, 0, 0), "axis");

  if(istrue(var_0)) {
    _id_39E0(self);
    _id_10808();
    level._id_7753 _id_AC34(level._id_7753);
  }

  _id_E70C();
}

_id_F2DE(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_AED6)) {
    var_1._id_AED6 = spawn("script_model", var_1.origin - (0, 0, 100));
    var_1._id_AED6.angles = scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0));
    var_1._id_AED6 hide();
    var_1._id_AED6 setModel(var_1.model);
  }

  if(var_0) {
    var_1._id_AED6 _meth_8093();
    var_1._id_AED6 delete();
    var_1._id_AED6 = undefined;
  } else
    var_1._id_AED6 _meth_80B5();
}

_id_7FC0(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoleft(self.angles);
  var_4 = self.origin + (0, 0, -110);
  var_5 = var_4 + var_1 * 20 + var_3 * 45;
  var_6 = var_4 + var_1 * 20 + var_2 * 45;
  var_7 = var_4 + var_1 * -20 + var_3 * 45;
  var_8 = var_4 + var_1 * -20 + var_2 * 45;
  _id_3F88(var_8, &"CP_VEHICLE_TRAVEL/ENTER", "seat4", self, var_0);
  _id_3F88(var_6, &"CP_VEHICLE_TRAVEL/ENTER", "seat3", self, var_0);
  _id_3F88(var_7, &"CP_VEHICLE_TRAVEL/ENTER", "seat2", self, var_0);
  _id_3F88(var_5, &"CP_VEHICLE_TRAVEL/ENTER", "seat1", self, var_0);
}

_id_3F88(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawn("script_model", var_0);
  var_5 setModel("tag_origin");
  var_5 sethintstring(var_1);
  var_5 setcursorhint("HINT_BUTTON");
  var_5 _meth_84D4(200);
  var_5 sethintdisplayfov(90);
  var_5 setuserange(72);
  var_5 setusefov(90);
  var_5 _meth_84D9("hide");
  var_5 setuseholdduration("duration_short");

  if(isDefined(var_4) && _func_03AC(var_4)) {
    var_5 thread[[var_4]](var_3, var_2);
  } else {
    var_5 thread _id_838D(var_3, var_2);
  }

  var_5 thread _id_8357(var_3);
}

_id_838D(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("heli_taking_off");
  self makeuseable();

  for(;;) {
    self waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::_id_8708()) {
      continue;
    }
    self makeunusable();
    var_2 thread _id_B73A(var_1);
    break;
  }
}

_id_8357(var_0) {
  level endon("game_ended");
  var_0 waittill("heli_taking_off");
  self makeunusable();
}

_id_10B11() {
  level endon("game_ended");
  self endon("death");
  self endon("load_hvt_started");
  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles);
  var_2 = anglestoleft(self.angles);
  var_3 = self.origin + (0, 0, -110);
  var_4 = var_3 + var_0 * 20 + var_2 * 45;
  var_5 = var_3 + var_0 * 20 + var_1 * 45;
  var_6 = self._id_10E83;

  if(!isDefined(var_6)) {
    return;
  }
  var_7 = undefined;

  foreach(var_9 in level.players) {
    if(isDefined(var_9._id_7A89)) {
      var_7 = var_9._id_7A89;
      break;
    }
  }

  if(!isDefined(var_7)) {
    level waittill("player_picked_up_hostage", var_9);
    var_7 = var_9._id_7A89;
  }

  var_11 = "left";
  var_12 = "left";

  for(;;) {
    var_13 = distance2dsquared(var_7.origin, var_5);
    var_14 = distance2dsquared(var_7.origin, var_4);

    if(var_13 > var_14) {
      var_12 = "left";
    } else {
      var_12 = "right";
    }

    if(var_11 != var_12) {
      self._id_571E = 1;
      var_11 = var_12;
      var_6 _id_F812(self, var_11);
      self._id_7C18 = var_11;
      self._id_571E = 0;
    }

    wait 0.5;
  }
}

_id_F812(var_0, var_1) {
  self notify("stop_idle_anim");
  var_2 = scripts\engine\utility::ter_op(var_1 == "left", "turn_left", "turn_right");
  var_3 = scripts\engine\utility::ter_op(var_1 == "left", "blima_drop_l_idle_in", "blima_drop_r_idle_in");
  var_0 _id_06C6::_id_1845(self, var_2, "tag_origin");
  var_0 thread _id_4C81(self, var_3);
}

_id_4C81(var_0, var_1) {
  self endon("death");
  var_0 endon("stop_idle_anim");

  for(;;) {
    _id_06C6::_id_1845(var_0, var_1, "tag_origin");
  }
}

_id_10808() {
  level endon("game_ended");
  var_0 = self;
  var_0._id_18AF = "exfil_chopper";
  var_1 = anglesToForward(var_0.angles);
  var_2 = anglestoleft(var_0.angles);
  var_3 = anglestoright(var_0.angles);
  var_4 = var_0.origin + var_1 * 10 + var_2 * 64 + (0, 0, -110);
  var_5 = spawn("trigger_radius", var_4 + (0, 0, -200), 0, 64, 500);
  var_0._id_7C18 = "left";
  var_0 thread _id_1080A(var_5, "left", "hvt_triggered_right");
  var_0 waittill("load_hvt_started");
  var_5 delete();
}

_id_1080A(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon(var_2);
  var_3 = 0;

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(!var_4 _id_8AE8() && isDefined(var_4._id_7D98)) {
      continue;
    }
    if(isDefined(var_4._id_7A89) && !istrue(var_4._id_85AE) && !istrue(var_3) && !isDefined(self._id_103EE) && !istrue(self._id_571E)) {
      self notify("load_hvt_started");
      level notify("hvt_triggered_" + var_1);
      _id_95C7(var_4);
      var_3 = 1;
      level notify("hvt_loaded_on_heli");
      break;
    }

    wait 0.2;
  }
}

_id_E70C() {
  level endon("game_ended");

  if(!isDefined(level._id_7753)) {
    return;
  }
  level._id_7753 notify("started_boarding");
  level thread _id_106F1();
  thread _id_10B16();
  var_0 = self;
  var_0._id_18AF = "exfil_chopper";
  var_0 _id_7FC0();
}

_id_10B16() {
  level endon("game_ended");
  self endon("all_players_on_board");
  self waittill("player_boarded_heli");
  var_0 = gettime() + 45000;

  while(gettime() <= var_0) {
    wait 3;
  }

  self notify("heli_trip_timed_out");
}

_id_7064(var_0) {
  level endon("game_ended");
  var_1 = [];
  var_1[0] = var_0.origin;

  for(var_2 = var_0; isDefined(var_2.target); var_2 = var_3) {
    var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_1[var_1.size] = var_3.origin;
  }

  var_4 = var_1.size;
  self notify("heli_taking_off");
  var_5 = self;
  var_5 _meth_80B5();
  var_5 vehicle_setspeed(5, 10);
  var_5 _meth_8087();
  var_5 setvehgoalpos(var_5.origin + (0, 0, 1200), 1);
  wait 2;
  level notify("heli_trip_took_off");
  var_5 vehicle_setspeed(90, 10);
  var_5 waittill("goal");

  if(var_4 > 1) {
    var_5 vehicle_setspeed(80, 250, 250);

    for(var_6 = 0; var_6 < var_4 - 1; var_6++) {
      var_5 setvehgoalpos(var_1[var_6], 0);
      var_5 setneargoalnotifydist(200);
      var_5 waittill("near_goal");
    }
  }

  var_5 vehicle_setspeed(90, 10);
  var_5 setvehgoalpos(var_1[var_1.size - 1] + (0, 0, 1200), 1);
  var_5 waittill("goal");
  var_5 _meth_838A(var_5._id_5716.angles[1]);
  var_5 setyawspeed(50, 25, 25, 0);
  wait 3;
  var_5._id_0201 = 4;
  var_5 setvehgoalpos(var_1[var_1.size - 1], 1);
  var_5 waittill("goal");
  var_5 _meth_8438(0);
  var_5 _meth_85C1();
}

_id_5752() {
  level endon("game_ended");
  var_0 = self;
  var_0 vehicle_setspeed(5, 10);
  var_0 _meth_8087();
  var_0 setvehgoalpos(var_0.origin + (0, 0, 1200), 1);
  wait 2;
  var_0 vehicle_setspeed(90, 10);
  var_0 waittill("goal");
  var_0 setvehgoalpos(var_0.origin + (10000, 10000, 500));
  wait 15;

  if(isDefined(var_0._id_103EE)) {}

  if(isDefined(var_0._id_9F00)) {
    var_0._id_9F00 delete();
  }

  foreach(var_2 in var_0._id_0F7F) {
    if(isDefined(var_2._id_75DA)) {
      var_2._id_75DA delete();
    }

    var_2 delete();
  }

  if(isDefined(var_0._id_75E9)) {
    _func_0354(var_0._id_75E9);
  }

  var_0 delete();
  level._id_7753 = undefined;
  level notify("heli_trip_deleted");
}

#using_animtree("mp_vehicles_always_loaded");

_id_AC34(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 notify("opening_right_door");
  var_0 _meth_8620(%sdr_cp_hostage_dropoff_blima_r_door_open_blima);
}

_id_8CCA(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("opening_right_door");
  var_0 endon("closing_right_door");

  for(;;) {
    var_0 _meth_8620(%sdr_cp_hostage_dropoff_blima_r_door_close_idle_blima);
    wait(_func_0079(%sdr_cp_hostage_dropoff_blima_r_door_close_idle_blima));
  }
}

_id_39E0(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 notify("closing_right_door");
  var_0 _meth_8620(%sdr_cp_hostage_dropoff_blima_r_door_close_blima);
}

_id_8131(var_0) {
  _id_CDBD();
  _id_1032C();
}

#using_animtree("script_model");

_id_CDBD() {
  level._id_CC34["hvt"] = #animtree;
  level._id_CC31["hvt"]["helidown_exfil"] = % cp_exfil_blima_hvt_lf_hvt;
  level._id_CC32["hvt"]["helidown_exfil"] = "cp_exfil_blima_hvt_lf_hvt";
  level._id_CC31["hvt"]["helidown_exfil_idle"] = % cp_exfil_blima_hvt_lf_hvt_idle;
  level._id_CC32["hvt"]["helidown_exfil_idle"] = "cp_exfil_blima_hvt_lf_hvt_idle";
  level._id_CC34["player"] = #animtree;
  level._id_CC31["player"]["blima_getin"] = % sdr_cp_veh_lbravo_seat_2_getin;
  level._id_CC32["player"]["blima_getin"] = "sdr_cp_veh_lbravo_seat_2_getin";
  level._id_CC3B["player"]["blima_getin"] = "cp_blima_getin";
  level._id_CC31["player"]["blima_idle"] = % sdr_cp_veh_lbravo_seat_2_idle;
  level._id_CC32["player"]["blima_idle"] = "sdr_cp_veh_lbravo_seat_2_idle";
  level._id_CC3B["player"]["blima_idle"] = "cp_blima_idle";
}

#using_animtree("mp_vehicles_always_loaded");

_id_1032C() {
  level._id_CC34["exfil_chopper"] = #animtree;
}