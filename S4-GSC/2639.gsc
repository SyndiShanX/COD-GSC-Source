/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2639.gsc
*************************************************/

_id_24AB(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_8B53)) {
    level._id_8B53 = [];
  }

  var_5 = undefined;

  if(isDefined(var_4)) {
    var_5 = var_4._id_9B4D;
    var_6 = 2;

    if(!isDefined(var_5)) {
      var_5 = spawnStruct();

      if(isDefined(var_4._id_96CF)) {
        var_5._id_96CF = var_4._id_96CF;
      } else {
        var_5._id_96CF = var_4.trigger.origin;
      }

      var_5.angles = (0, 0, 0);
      var_5._id_EA52 = "equip_deploy_succeeded";
      var_5._id_04ED = spawn("script_model", var_5._id_96CF);
      var_5._id_04ED setModel("ks_marker_mp");
      var_5._id_04ED setotherent(self);
    }

    if(!isDefined(var_5._id_96CF)) {
      self notify("cancel_jackal");
      return 0;
    } else if(isDefined(level._id_8B46) || level._id_8B53.size >= var_6) {
      if(isDefined(var_5._id_04ED)) {
        var_5._id_04ED delete();
      }

      scripts\mp\hud_message::_id_DCC0("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");

      if(isDefined(var_3.objweapon) && var_3.objweapon.basename != "none") {
        self notify("killstreak_finished_with_weapon_" + var_3._id_04FE);
      }

      self notify("cancel_jackal");
      return 0;
    }
  }

  self notify("called_in_jackal");
  level._id_8B46 = 1;
  var_7 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();

  if(isDefined(var_7)) {
    var_8 = var_7.origin[2] + 500;
  } else {
    var_8 = 1300;
  }

  if(isDefined(var_5) && isDefined(var_5._id_96CF)) {
    var_2 = var_5._id_96CF;
  }

  var_2 = var_2 * (1, 1, 0);
  var_9 = var_2 + (0, 0, var_8);
  var_10 = _id_E316(var_0, self, var_1, var_9, var_3, var_4);
  var_10._id_ED15 = var_4;
  var_11 = var_9;
  var_12 = var_9 + anglestoright(self.angles) * 2000;
  var_13 = var_9 - anglestoright(self.angles) * 2000;
  var_14 = [var_11, var_12, var_13];

  foreach(var_16 in var_14) {
    if(!_id_8B48(var_10, var_16)) {
      continue;
    }
    var_9 = var_16;
    break;
  }

  var_10._id_AEDC = var_9;
  thread _id_461F(var_10, var_5);
  return var_10;
}

_id_E316(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vectortoangles(var_3 - var_2);
  var_7 = 4;
  var_8 = 50;
  var_9 = 175;
  var_10 = 10000;
  var_11 = "veh8_mil_air_lbravo";
  var_12 = "jackal_turret_mp";
  var_13 = "veh_mil_air_ca_dropship_mp_turret";
  var_14 = 1;
  var_15 = "jackal_cannon_mp";
  var_16 = "veh_mil_air_ca_dropship_turret_missile";
  var_17 = 1;
  var_18 = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
  var_19 = "follow_player";

  if(isDefined(var_5)) {
    var_19 = "guard_location";
  }

  var_20 = spawnhelicopter(var_1, var_2, var_6, "veh_airdrop_mp", var_11);

  if(!isDefined(var_20)) {
    return;
  }
  if(isDefined(var_5)) {
    var_20._id_991F = var_5;
  }

  var_20 thread _id_7435();
  var_20._id_42E9 = ::_id_2F40;
  var_20.speed = var_8;
  var_20.accel = var_9;
  var_20.health = var_10;
  var_20.maxhealth = var_20.health;
  var_20.team = var_1.team;
  var_20.owner = var_1;
  var_20 setCanDamage(1);
  var_20._id_461E = var_3;
  var_20._id_936C = var_0;
  var_20._id_8B45 = 1;
  var_20.streakinfo = var_4;
  var_20.streakname = var_4.streakname;
  var_20._id_5688 = 0;
  var_20._id_010D = var_19;
  var_20._id_41F9 = var_18;
  var_20.streakinfo = var_4;
  var_20._id_5C8A = var_7;
  var_20._id_F88D = var_14;
  var_20._id_F89D = var_12;
  var_20._id_319F = var_15;
  var_20._id_319D = var_17;
  var_20 scripts\mp\utility\killstreak::_id_1155(var_4.streakname, "Killstreak_Air", var_1, 0, 1, 100);
  var_20 setmaxpitchroll(0, 90);
  var_20 vehicle_setspeed(var_20.speed, var_20.accel);
  var_20 sethoverparams(50, 100, 50);
  var_20 setturningability(0.05);
  var_20 setyawspeed(45, 25, 25, 0.5);
  var_20 setotherent(var_1);
  var_21 = anglesToForward(var_20.angles);

  if(!isDefined(var_5)) {
    var_20._id_F81F = spawnturret("misc_turret", var_20 gettagorigin("tag_origin"), var_12);
    var_20._id_F81F setModel(var_13);
    var_20._id_F81F.owner = var_1;
    var_20._id_F81F.team = var_1.team;
    var_20._id_F81F.angles = var_20.angles;
    var_20._id_F81F.type = "Machine_Gun";
    var_20._id_F81F.streakinfo = var_4;
    var_20._id_F81F linkto(var_20, "tag_origin", (200, 0, 55), (0, 0, 0));
    var_20._id_F81F _meth_839D(0);
    var_20._id_F81F setmode("manual_target");
    var_20._id_F81F setsentryowner(var_1);
    var_20._id_319B = spawnturret("misc_turret", var_20 gettagorigin("tag_origin"), var_15);
    var_20._id_319B setModel(var_16);
    var_20._id_319B.owner = var_1;
    var_20._id_319B.team = var_1.team;
    var_20._id_319B.angles = var_20.angles;
    var_20._id_319B.type = "Cannon";
    var_20._id_319B.streakinfo = var_4;
    var_20._id_319B linkto(var_20, "tag_origin", (-100, 0, 55), (0, 0, 0));
    var_20._id_319B _meth_839D(0);
    var_20._id_319B setmode("manual_target");
    var_20._id_319B setsentryowner(var_1);
  }

  var_20._id_FE90 = spawn("script_model", var_20 gettagorigin("tag_origin"));
  var_20._id_FE90 linkto(var_20, "tag_origin");
  level._id_8B53[level._id_8B53.size] = var_20;
  level._id_8B53 = scripts\engine\utility::_id_1BD1(level._id_8B53);
  level._id_8B46 = undefined;

  if(isDefined(var_5)) {
    var_20 thread _id_0A44::_id_5C7F(undefined, undefined);
  }

  var_20 thread _id_8B4B();
  var_20 thread _id_46CE(0.05, "dropship_enemy_hover_world_grnd");
  var_20 thread _id_466A();

  if(!isDefined(var_5)) {
    var_20._id_F81F._id_100A9 = var_20;
    var_20._id_319B._id_100A9 = var_20;
    var_20._id_F81F._id_100A9.killcament = spawn("script_model", var_20 gettagorigin("tag_origin"));
    var_20._id_F81F._id_100A9.killcament linkto(var_20, "tag_origin");
    var_20._id_319B._id_100A9.killcament = var_20._id_F81F._id_100A9.killcament;
  }

  var_22 = anglesToForward(var_20.angles);
  return var_20;
}

_id_6BB7(var_0) {
  var_1 = 0;

  if(level.teambased) {
    foreach(var_3 in level._id_8B53) {
      if(var_3.team != var_0.team) {
        continue;
      }
      var_1++;
    }
  } else {
    foreach(var_3 in level._id_8B53) {
      if(var_3.owner != var_0) {
        continue;
      }
      var_1++;
    }
  }

  return var_1;
}

_id_466A() {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(6);
}

_id_46CE(var_0, var_1) {
  self endon("death");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self playLoopSound(var_1);
}

_id_461F(var_0, var_1) {
  var_0 endon("death");
  var_0 setvehgoalpos(var_0._id_AEDC, 1);
  var_0 thread _id_39F8(var_0._id_AEDC);
  var_0 thread _id_A12D();

  if(isDefined(var_0._id_502B)) {
    var_0 thread _id_10AD2(var_1);
  }

  var_0 waittill("goal");

  if(isDefined(var_1) && isDefined(var_0._id_991F)) {
    var_0 thread _id_8B54();
    var_0 thread _id_10B65();
    var_0 thread _id_5459();
    var_0.speed = 250;
    var_0 vehicle_setspeed(50, 15);
    var_0 _id_8B52(var_1._id_96CF);
    var_0 waittill("extract_hostages");
    var_0 thread _id_8B50(50, 15);
  } else if(isDefined(var_1) && isDefined(var_0._id_502B)) {
    var_0 thread _id_8B54();
    var_0 thread _id_10B65();
    var_0 thread _id_5459();
    var_0 thread _id_545A();
    var_0 vehicle_setspeed(50, 15);
    var_0 _id_8B52(var_1._id_96CF);
    var_0 thread _id_502B(var_0._id_502B, var_1);
    var_0 thread _id_10B8F();
    var_0 scripts\engine\utility::_id_108A7(10, "all_crates_gone");
    var_0._id_010D = "follow_player";
  } else {
    var_0 thread _id_8B54();
    var_0 thread _id_10B65();
    var_0 thread _id_5459();
    var_0 thread _id_545A();
    var_0 vehicle_setspeed(int(var_0.speed / 14), int(var_0.accel / 16));
  }

  if(!isDefined(var_0._id_991F)) {
    var_0._id_FE90 scripts\mp\utility\killstreak::_id_D5D2(var_0.owner, var_0._id_41F9, 360, 360, 30000, 30000, 2);
    var_0 thread _id_AF46();
    var_0 thread _id_10BAF(_id_6BE1(var_0._id_010D), var_0._id_41F9);
  }
}

_id_5459() {
  self notify("engagePrimary");
  self endon("engagePrimary");
  self endon("leaving");
  self endon("death");
  self._id_8F81 = undefined;

  if(istrue(self._id_F88D)) {
    for(;;) {
      var_0 = _id_8B4F();

      if(isDefined(var_0) && var_0.size > 0) {
        _id_0E81(var_0);
        self._id_F81F waittill("stop_firing");

        if(self._id_010D == "follow_player") {
          thread _id_AF46();
        }
      } else
        self._id_8F81 = "noTargetsFound";

      wait 0.05;
    }
  }
}

_id_545A() {
  self notify("engageSecondary");
  self endon("engageSecondary");
  self endon("leaving");
  self endon("death");
  var_0 = weaponfiretime(self._id_319F);

  if(istrue(self._id_319D)) {
    for(;;) {
      var_1 = _id_8B4F();

      if(!isDefined(var_1) || var_1.size < 2) {
        waitframe();
        continue;
      }

      _id_0E80(var_1);
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
    }
  }
}

_id_5E2E() {
  self endon("death");
  self endon("leaving");
  self endon("guard_location");
  self endon("priority_target");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self notify("following_player");
  self vehicle_setspeed(50, 15);

  for(;;) {
    var_0 = undefined;

    if(istrue(self._id_5688)) {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_3 = var_1 + randomintrange(-500, 500);
      var_4 = var_2 + randomintrange(-500, 500);
      var_5 = _id_6988(var_3, var_4, 350);
      var_0 = (var_3, var_4, var_5);
    } else {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_5 = _id_6988(var_1, var_2, 20);
      var_0 = (var_1, var_2, var_5);
    }

    self setlookatent(self.owner);
    self setvehgoalpos(var_0, 1);
    self._id_8F81 = "following_player";
    scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");
    self _meth_807E();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

_id_7256(var_0) {
  self endon("death");
  self endon("leaving");
  self endon("follow_player");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_2 = var_0[0];
    var_3 = var_0[1];
    var_4 = _id_6988(var_2, var_3, 20);
    var_1 = (var_2, var_3, var_4);
  } else if(istrue(self._id_5688)) {
    var_2 = self.owner.origin[0];
    var_3 = self.owner.origin[1];
    var_5 = var_2 + randomintrange(-500, 500);
    var_6 = var_3 + randomintrange(-500, 500);
    var_4 = _id_6988(var_5, var_6, 350);
    var_1 = (var_5, var_6, var_4);
  } else {
    var_2 = self.owner.origin[0];
    var_3 = self.owner.origin[1];
    var_4 = _id_6988(var_2, var_3, 20);
    var_1 = (var_2, var_3, var_4);
  }

  self setlookatent(self.owner);
  self setvehgoalpos(var_1, 1);
  self._id_8F81 = "following_player";
  scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");
  self _meth_807E();
}

_id_AF46() {
  self endon("death");
  self endon("leaving");
  self endon("guard_location");
  self endon("priority_target");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));

  for(;;) {
    var_0 = undefined;

    if(isDefined(self._id_AF50) && isalive(self._id_AF50) && isPlayer(self._id_AF50) && !self._id_AF50 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      if(!_id_8B47(self._id_AF50) || distance2dsquared(self.origin, self._id_AF50.origin) > 4194304) {
        _id_8B51(self._id_AF50);
      }
    } else {
      var_1 = _id_8B4D();

      if(isDefined(var_1)) {
        self._id_AF50 = var_1;
        thread _id_10BCB();
        _id_8B51(var_1);
      } else {
        self._id_AF50 = undefined;
        var_2 = _id_8B4E();

        if(isDefined(var_2)) {
          _id_8B52(var_2.origin);
        }
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

_id_8B4E() {
  var_0 = undefined;

  if(isDefined(level._id_326D) && level._id_326D.size > 0) {
    foreach(var_2 in level._id_326D) {
      if(isDefined(var_2._id_01E3) && !var_2._id_01E3) {
        continue;
      }
      if(!_id_8B48(self, var_2.origin)) {
        continue;
      }
      var_2._id_01E3 = 0;
      var_0 = var_2;

      if(!isDefined(self._id_81F2)) {
        self._id_81F2 = var_0;
      }

      break;
    }

    if(!isDefined(var_0)) {
      if(isDefined(self._id_81F2)) {
        foreach(var_2 in level._id_326D) {
          if(var_2 != self._id_81F2) {
            var_2._id_01E3 = undefined;
          }
        }

        var_0 = self._id_81F2;
      }
    }
  }

  return var_0;
}

_id_8B48(var_0, var_1) {
  var_2 = 0;
  var_3 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0);

  if(scripts\engine\trace::ray_trace_passed(var_0.origin, var_1, var_0, var_3)) {
    var_2 = 1;
  }

  return var_2;
}

_id_8B47(var_0) {
  var_1 = 0;
  var_2 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 1, 0);
  var_3 = [var_0 gettagorigin("j_head"), var_0 gettagorigin("j_mainroot"), var_0 gettagorigin("tag_origin")];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(!scripts\engine\trace::ray_trace_passed(self.origin, var_3[var_4], self, var_2)) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

_id_8B51(var_0) {
  if(isDefined(self._id_AF50)) {
    var_0 = self._id_AF50;
  }

  if(_id_8B47(var_0)) {
    self setlookatent(var_0);
  }

  var_1 = undefined;

  if(istrue(self._id_5688)) {
    var_2 = var_0.origin[0];
    var_3 = var_0.origin[1];
    var_4 = var_2 + randomintrange(-500, 500);
    var_5 = var_3 + randomintrange(-500, 500);
    var_6 = _id_6988(var_4, var_5, 350);
    var_1 = (var_4, var_5, var_6);
  } else {
    var_2 = var_0.origin[0];
    var_3 = var_0.origin[1];
    var_6 = _id_6988(var_2, var_3, 20);
    var_1 = (var_2, var_3, var_6);
  }

  var_7 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0);
  var_8 = scripts\engine\trace::ray_trace(self.origin, var_1, level.characters, var_7);

  if(var_8["hittype"] != "hittype_none") {
    var_9 = _id_6988(var_8["position"][0], var_8["position"][1], 20);
    var_1 = (var_8["position"][0], var_8["position"][1], var_9);
  }

  self setvehgoalpos(var_1 + (0, 0, 500), 2);
  self._id_8F81 = "patrol";
  scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");
  self _meth_807E();
}

_id_8B4D() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.ignoreme || isDefined(var_2.owner) && var_2.owner.ignoreme) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(level.teambased) && isDefined(var_2.team) && self.team == var_2.team) {
      continue;
    }
    if(var_2 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
      continue;
    }
    if(var_2 _id_88DC()) {
      continue;
    }
    var_0[var_0.size] = var_2;
    waitframe();
  }

  var_4 = undefined;

  if(var_0.size > 0) {
    var_4 = _func_0204(var_0, self.origin);
  }

  if(isDefined(var_4) && var_4.size > 0) {
    return var_4[0];
  }

  return undefined;
}

_id_88DC() {
  var_0 = 0;
  var_1 = scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(self.origin, self.origin + (0, 0, 10000), self, var_1)) {
    var_0 = 1;
  }

  return var_0;
}

_id_10BCB() {
  self endon("death");
  self endon("leaving");
  self endon("jackal_crashing");
  self.owner endon("disconnect");
  var_0 = self._id_AF50 scripts\engine\utility::_id_108A7(5, "death_or_disconnect");
  self._id_AF50 = undefined;
}

_id_8B52(var_0) {
  var_1 = undefined;

  if(istrue(self._id_5688)) {
    var_2 = var_0[0];
    var_3 = var_0[1];
    var_4 = var_2 + randomintrange(-500, 500);
    var_5 = var_3 + randomintrange(-500, 500);
    var_6 = _id_6988(var_4, var_5, 350);
    var_1 = (var_4, var_5, var_6);
  } else {
    var_2 = var_0[0];
    var_3 = var_0[1];

    if(!isDefined(self._id_ED15)) {
      var_6 = _id_6988(var_2, var_3, 20);
    } else {
      var_6 = 160;
    }

    var_1 = (var_2, var_3, var_6);
  }

  self _meth_807E();
  self setvehgoalpos(var_1 + (0, 0, 500), 10);
  scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");
}

_id_8B50(var_0, var_1) {
  self endon("death");
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self _meth_807E();
  self._id_F81F setsentryowner(undefined);

  if(isDefined(self._id_F899) && isDefined(self._id_EEF1)) {
    scripts\mp\utility\outline::outlinedisable(self._id_EEF1, self._id_F899);
  }

  var_2 = int(self.speed / 14);
  var_3 = int(self.accel / 16);

  if(isDefined(var_0)) {
    var_2 = var_0;
  }

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  self vehicle_setspeed(var_2, var_3);
  var_4 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
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
  level._id_8B53[level._id_8B53.size - 1] = undefined;
  self notify("jackal_gone");
  thread _id_8B4A();
}

_id_8B4A() {
  scripts\mp\utility\print::_id_BD15("killstreak ended - jackal", self.owner);

  if(isDefined(self._id_F81F)) {
    self._id_F81F delete();
  }

  if(isDefined(self._id_319B)) {
    self._id_319B delete();
  }

  if(isDefined(self._id_FE90)) {
    self._id_FE90 delete();
  }

  foreach(var_1 in level._id_326D) {
    var_1._id_01E3 = undefined;
  }

  self delete();
}

_id_8B54() {
  self endon("death");
  level endon("game_ended");
  var_0 = 9999;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);

  if(isDefined(self.owner)) {
    self.owner _id_0A8D::_id_B86E("jackal_end", undefined, undefined, self.owner.origin);
  }

  thread _id_8B50();
}

_id_10B65() {
  self endon("death");
  self endon("leaving");
  level waittill("game_ended");
  thread _id_8B50();
}

_id_C00E() {
  self notify("randomJackalMovement");
  self endon("randomJackalMovement");
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self._id_8F81 = "randomMovement";
  var_0 = self._id_461E;
  var_1 = _id_6CC5(self.origin);
  self setvehgoalpos(var_1, 1);
  thread scripts\mp\utility\debug::_id_4F43(self.origin, var_1, 5, (1, 0, 1));
  self waittill("goal");
}

_id_6CC5(var_0) {
  self _meth_807E();

  if(distance2dsquared(self.origin, self.owner.origin) > 4194304) {
    var_1 = self.owner.origin[0];
    var_2 = self.owner.origin[1];
    var_3 = _id_6988(var_1, var_2, 20);
    var_4 = (var_1, var_2, var_3);
    self setlookatent(self.owner);
    return var_4;
  } else {
    var_5 = self.angles[1];
    var_6 = int(var_5 - 60);
    var_7 = int(var_5 + 60);
    var_8 = randomintrange(var_6, var_7);
    var_9 = (0, var_8, 0);
    var_10 = self.origin + anglesToForward(var_9) * randomintrange(400, 800);
    var_11 = var_10[0];
    var_12 = var_10[1];
    var_13 = _id_6988(var_11, var_12, 20);
    var_14 = _id_F3CC(var_11, var_12, var_13);

    if(var_14 != 0) {
      return var_14;
    }

    var_11 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
    var_12 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
    var_15 = (var_11, var_12, var_13);
    return var_15;
  }
}

_id_6B78(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = [];

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }
    if(!level.teambased || var_4.team != self.team) {
      var_2[var_2.size] = var_4.origin;
    }
  }

  if(var_2.size > 0) {
    var_6 = _func_0016(var_2);
    var_7 = var_6[0];
    var_8 = var_6[1];
  } else {
    var_9 = level._id_9AAC;
    var_10 = level._id_9AC7 / 4;
    var_7 = randomfloatrange(var_9[0] - var_10, var_9[0] + var_10);
    var_8 = randomfloatrange(var_9[1] - var_10, var_9[1] + var_10);
  }

  var_11 = _id_6988(var_7, var_8, 20);
  var_12 = _id_F3CC(var_7, var_8, var_11);

  if(var_12 != 0) {
    return var_12;
  }

  var_7 = randomfloatrange(var_0[0] - 1200, var_0[0] + 1200);
  var_8 = randomfloatrange(var_0[1] - 1200, var_0[1] + 1200);
  var_11 = _id_6988(var_7, var_8, 20);
  var_13 = (var_7, var_8, var_11);
  return var_13;
}

_id_6C1E(var_0) {
  var_1 = 100;
  var_2 = 15000;
  var_3 = randomfloat(360);
  var_4 = (0, var_3, 0);
  var_5 = var_0 + anglesToForward(var_4) * (-1 * var_2);
  var_5 = var_5 + ((randomfloat(2) - 1) * var_1, (randomfloat(2) - 1) * var_1, 0);
  return var_5;
}

_id_6C1C() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

_id_5B85(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_timeout");

  if(istrue(var_0) && scripts\mp\utility\player::isreallyalive(self.owner) && (!isDefined(self._id_8FD6) || self._id_8FD6 + 10000 <= gettime())) {
    self.owner _id_09C1::_id_AC3E("jackal_fire");
    self._id_8FD6 = gettime();
  }

  var_1 = scripts\mp\utility\outline::outlineenableforplayer(self._id_F899, self.owner, "outline_depth_orange", "killstreak_personal");
  self._id_EEF1 = var_1;
  var_2 = 3;
  thread _id_10B23(self._id_F81F, self._id_F899, "target_timeout", var_2);
  self._id_F81F waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::_id_CB70(self._id_F899, "plr_killstreak_target");
  self._id_F81F notify("start_firing");
  var_3 = weaponfiretime(self._id_F89D);

  while(isDefined(self._id_F899) && scripts\mp\utility\player::isreallyalive(self._id_F899) && isDefined(self._id_F81F _meth_8184(1)) && self._id_F81F _meth_8184(1) == self._id_F899) {
    self._id_F81F _meth_83C1();
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_3);
  }
}

_id_5B83(var_0) {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  var_1 = 3;
  thread _id_10B23(self._id_319B, self._id_319E, "target_cannon_timeout", var_1);
  self._id_319B waittill("turret_on_target");
  level thread scripts\mp\battlechatter_mp::_id_CB70(self._id_319E, "plr_killstreak_target");
  self._id_319B notify("start_firing");
  var_2 = weaponfiretime(self._id_319F);

  if(isDefined(self._id_319E) && scripts\mp\utility\player::isreallyalive(self._id_319E) && isDefined(self._id_319B _meth_8184(1)) && self._id_319B _meth_8184(1) == self._id_319E) {
    self._id_319B thread _id_10BAD();
    self._id_319B _meth_83C1();
  }
}

_id_10BAD() {
  self endon("death");
  self waittill("missile_fire", var_0);
  var_0.streakinfo = self.streakinfo;
}

_id_D5F9() {
  self endon("leaving");
  self endon("explode");
  self endon("death");
  self endon("target_cannon_timeout");
  self._id_319B waittill("missile_fire", var_0);
  var_0._id_100A9 = self;
  var_0._id_100A9.killcament = self._id_319B._id_100A9.killcament;
}

_id_10B23(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("leaving");
  var_0 endon("stop_firing");
  var_4 = self._id_EEF1;
  var_5 = var_1 scripts\engine\utility::_id_108A7(var_3, "death_or_disconnect");

  if(var_5 == "timeout") {
    self notify(var_2);
  }

  if(var_0.type == "Machine_Gun") {
    if(isDefined(var_4) && isDefined(var_1)) {
      scripts\mp\utility\outline::outlinedisable(var_4, var_1);
    }

    self _meth_807E();
  }

  var_0 _meth_8086();
  var_0 notify("stop_firing");
}

_id_89EA(var_0) {
  self endon("death");
  self endon("leaving");

  if(!isDefined(var_0)) {
    var_0 = 10;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = self._id_F899.origin - self.origin;
  var_1 = var_1 * (1, 1, 0);
  var_2 = var_2 * (1, 1, 0);
  var_2 = vectornormalize(var_2);
  var_1 = vectornormalize(var_1);
  var_3 = vectordot(var_2, var_1);
  var_4 = cos(var_0);

  if(var_3 >= var_4) {
    return 1;
  } else {
    return 0;
  }
}

_id_0E81(var_0) {
  self endon("death");
  self endon("leaving");
  self notify("priority_target");

  if(isDefined(self._id_ACC7) && isDefined(self._id_F899)) {
    scripts\mp\utility\outline::outlinedisable(self._id_ACC7, self._id_F899);
  }

  if(var_0.size == 1) {
    self._id_F899 = var_0[0];
  } else {
    self._id_F899 = _id_691C(var_0);
  }

  if(isDefined(self._id_F899)) {
    self _meth_807E();
    self setlookatent(self._id_F899);
    self._id_F81F _meth_8389(self._id_F899);
    self._id_8F81 = "attackTarget";
    thread _id_5B85(1);
  }
}

_id_0E80(var_0) {
  self endon("death");
  self endon("leaving");
  self._id_319E = _id_691C(var_0);

  if(isDefined(self._id_319E)) {
    self._id_319B _meth_8389(self._id_319E);
    thread _id_5B83(0);
  }
}

_id_8B4F() {
  self endon("death");
  self endon("leaving");
  var_0 = [];
  var_1 = level.players;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(_id_8A8D(var_3)) {
      if(isDefined(var_1[var_2])) {
        var_0[var_0.size] = var_1[var_2];
      }
    } else
      continue;

    wait 0.05;
  }

  return var_0;
}

_id_8A8D(var_0) {
  self endon("death");

  if(!isalive(var_0) || var_0.sessionstate != "playing") {
    return 0;
  }

  if(isDefined(self.owner) && var_0 == self.owner) {
    return 0;
  }

  if(!isDefined(var_0.pers["team"])) {
    return 0;
  }

  if(level.teambased && var_0.pers["team"] == self.team) {
    return 0;
  }

  if(var_0.pers["team"] == "spectator") {
    return 0;
  }

  if(isDefined(var_0._id_E393) && (gettime() - var_0._id_E393) / 1000 <= 5) {
    return 0;
  }

  if(var_0 scripts\mp\utility\perk::_hasperk("specialty_blindeye")) {
    return 0;
  }

  if(distance2dsquared(self.origin, var_0.origin) > 4194304) {
    return 0;
  }

  var_1 = (0, 0, 35);
  var_2 = var_0.origin + rotatevector(var_1, var_0 _meth_8541());
  var_3 = [self];
  var_4 = scripts\engine\trace::ray_trace(self.origin, var_2, var_3, undefined, 1);

  if(!isDefined(var_4["entity"])) {
    return 0;
  }

  return 1;
}

_id_691C(var_0) {
  self endon("death");
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(isDefined(self._id_F899) && self._id_F899 == var_4) {
      continue;
    }
    var_5 = abs(vectortoangles(var_4.origin - self.origin)[1]);
    var_6 = abs(self gettagangles("tag_origin")[1]);
    var_5 = abs(var_5 - var_6);
    var_7 = var_4 _meth_8194();

    foreach(var_9 in var_7) {
      var_10 = var_9.basename;

      if(issubstr(var_10, "chargeshot") || issubstr(var_10, "lockon")) {
        var_5 = var_5 - 40;
      }
    }

    if(distance(self.origin, var_4.origin) > 4000) {
      var_5 = var_5 + 40;
    }

    if(!isDefined(var_1)) {
      var_1 = var_5;
      var_2 = var_4;
      continue;
    }

    if(var_1 > var_5) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return var_2;
}

_id_7435() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::_id_9ACB(var_9, var_13);

    if((var_9.basename == "aamissile_projectile_mp" || var_9.basename == "s4_v2_mp") && var_4 == "MOD_EXPLOSIVE" && var_0 >= self.health) {
      _id_2F40(var_1, var_1, 9001, 0, var_4, var_9, var_3, var_2, var_3, 0, 0, var_7);
    }
  }
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
  var_2 = scripts\mp\utility\killstreak::_id_6B66(var_1, var_5, var_4, var_2, self.maxhealth, 3, 4, 5);
  scripts\mp\killstreaks\killstreaks::_id_8DD6(var_1, var_5, self, var_4, var_2);
  var_1 _id_07C4::_id_FC47("");
  _id_07C3::_id_9757(self, var_2, var_1, var_7, var_6, var_4, var_10, undefined, var_11, var_3, getcompleteweaponname(var_5));

  if(self.health <= var_2) {
    if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
      _id_07C3::_id_AB18("jackal", var_1, var_5, var_4, var_2, "destroyed_jackal", "jackal_destroyed", "callout_destroyed_harrier");
    }
  }

  if(self.health - var_2 <= 900 && (!isDefined(self._id_DE57) || !self._id_DE57)) {
    self._id_DE57 = 1;
  }

  self _meth_842C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

_id_6988(var_0, var_1, var_2) {
  var_3 = 600;
  var_4 = _id_F3CB(var_0, var_1);
  var_5 = var_4 + var_3;
  var_5 = var_5 + randomint(var_2);
  return var_5;
}

_id_B382() {
  self endon("death");
  stopFXOnTag(level._id_74CD, self, "tag_engine_left");
  playFXOnTag(level._id_74CE, self, "tag_engine_left");
  stopFXOnTag(level._id_74CD, self, "tag_engine_right");
  playFXOnTag(level._id_74CE, self, "tag_engine_right");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.15);
  stopFXOnTag(level._id_74CD, self, "tag_engine_left2");
  playFXOnTag(level._id_74CE, self, "tag_engine_left2");
  stopFXOnTag(level._id_74CD, self, "tag_engine_right2");
  playFXOnTag(level._id_74CE, self, "tag_engine_right2");
  playFXOnTag(level.chopper_fx["damage"]["heavy_smoke"], self, "tag_engine_left");
}

_id_8B4B() {
  self endon("jackal_gone");
  var_0 = self.owner;
  self waittill("death");

  if(isDefined(self._id_F899) && isDefined(self._id_EEF1)) {
    scripts\mp\utility\outline::outlinedisable(self._id_EEF1, self._id_F899);
  }

  if(!isDefined(self)) {
    return;
  }
  self.owner _id_0A99::_id_3958(_id_6BE1(self._id_010D));

  if(!isDefined(self._id_8EE2)) {
    self vehicle_setspeed(25, 5);
    thread _id_8B49(75);
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2.7);
  }

  if(isDefined(self._id_991F)) {
    self._id_991F notify("extraction_destroyed");
  }

  _id_8B4C();
}

_id_8B4C() {
  self playSound("dropship_explode_mp");
  level._id_8B53[level._id_8B53.size - 1] = undefined;
  self notify("explode");

  if(isDefined(self._id_991F)) {
    playFXOnTag(scripts\engine\utility::getfx("jackal_explosion"), self, "tag_origin");
  }

  wait 0.35;
  thread _id_8B4A();
}

_id_8B49(var_0) {
  self endon("explode");
  self _meth_807E();
  self notify("jackal_crashing");
  self setvehgoalpos(self.origin + (0, 0, 100), 1);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.5);
  self setyawspeed(var_0, var_0, var_0);
  self _meth_838A(self.angles[1] + var_0 * 2.5);
}

_id_F3CC(var_0, var_1, var_2) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  self endon("randMove");
  var_3 = scripts\engine\trace::_id_E409(self.origin, (var_0, var_1, var_2), 256, self, undefined, 1);

  if(var_3["surfacetype"] != "surftype_none") {
    return 0;
  }

  var_4 = (var_0, var_1, var_2);
  return var_4;
}

_id_F3CB(var_0, var_1) {
  self endon("death");
  self endon("acquiringTarget");
  self endon("leaving");
  var_2 = -99999;
  var_3 = self.origin[2] + 2000;
  var_4 = level._id_1F9C;
  var_5 = [self];

  if(isDefined(self._id_502B)) {
    foreach(var_7 in self._id_502B) {
      var_5[var_5.size] = var_7;
    }
  }

  var_9 = scripts\engine\trace::_id_E409((var_0, var_1, var_3), (var_0, var_1, var_2), 256, var_5, undefined, 1);

  if(var_9["position"][2] < var_4) {
    var_10 = var_4;
  } else {
    var_10 = var_9["position"][2];
  }

  return var_10;
}

_id_39F8(var_0) {
  self endon("goal");
  self endon("death");

  for(;;) {
    if(distance2d(self.origin, var_0) < 768) {
      self setmaxpitchroll(10, 25);
      break;
    }

    wait 0.05;
  }
}

_id_A12D() {
  self endon("death");
  self endon("leaving");

  if(!isDefined(self.owner) || self.owner.team != self.team) {
    thread _id_8B4C();
    return;
  }

  self.owner scripts\engine\utility::waittill_any_2("joined_team", "disconnect");
  _id_8B4C();
}

_id_10BAF(var_0, var_1) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("leaving");
  level endon("game_ended");
  var_2 = level._id_5F3A;

  for(;;) {
    self._id_FE90 waittill("trigger", var_3);

    if(var_3 != self.owner) {
      continue;
    }
    if(self.owner scripts\mp\utility\player::_id_8ACE()) {
      continue;
    }
    if(!self.owner scripts\common\utility::_id_86F9()) {
      continue;
    }
    if(scripts\mp\utility\entity::_id_8AA9(self.owner)) {
      continue;
    }
    var_4 = 0;

    while(self.owner useButtonPressed()) {
      var_4 = var_4 + var_2;

      if(var_4 > 0.1) {
        var_5 = _id_6BE1(self._id_010D);

        if(var_5 == "guard_location") {
          var_6 = self.owner.origin[0];
          var_7 = self.owner.origin[1];
          var_8 = self.origin[2];
          var_9 = (var_6, var_7, var_8);
          var_10 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 1, 1, 0);

          if(!scripts\engine\trace::ray_trace_passed(self.origin, var_9, self, var_10)) {
            self.owner scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/CANNOT_BE_CALLED");
            break;
          }
        }

        self._id_010D = var_5;
        self notify(self._id_010D);

        if(self._id_010D == "guard_location") {
          var_0 = "follow_player";
          var_1 = &"KILLSTREAKS_HINTS_JACKAL_FOLLOW";
          self.owner _id_09C1::_id_AC3E("jackal_guard");
          thread _id_505A();
          thread _id_7256();
        } else {
          var_0 = "guard_location";
          var_1 = &"KILLSTREAKS_HINTS_JACKAL_GUARD";
          thread _id_AF46();
          thread _id_505A();
        }

        self._id_FE90 makeunusable();
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
        self._id_41F9 = var_1;
        self._id_FE90 scripts\mp\utility\killstreak::_id_D5D2(self.owner, self._id_41F9, 360, 360, 30000, 30000, 2);
        break;
      }

      wait(var_2);
    }

    wait(var_2);
  }
}

_id_505A() {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.3);
  self _meth_827E("dropship_killstreak_thrust_change");
}

_id_6BE1(var_0) {
  if(var_0 == "follow_player") {
    var_0 = "guard_location";
  } else {
    var_0 = "follow_player";
  }

  return var_0;
}

_id_9849(var_0, var_1) {
  level endon("game_ended");

  for(;;) {
    triggerfx(var_0);
    wait 0.05;

    if(!isDefined(var_1) || !isDefined(var_0)) {
      break;
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_1DF3(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 6000;
  var_5 = (0, 0, var_4);
  var_6 = 3000;
  var_7 = anglesToForward(self.angles);
  var_8 = self.origin;
  var_9 = var_8 + var_5 + var_7 * var_6 * -1;
  var_10 = [self];
  var_11 = 0;
  var_12 = scripts\engine\trace::ray_trace(var_0 + (0, 0, var_4), var_0);

  if(var_12["fraction"] > 0.99) {
    var_11 = 1;
    var_9 = var_0 + (0, 0, var_4);
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, 0, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, 0, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (0, 300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (0, 300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (0, -300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (0, -300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, 300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, 300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (-300, 0, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (-300, 0, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (-300, -300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (-300, -300, var_4);
    }
  }

  if(!var_11) {
    var_12 = scripts\engine\trace::ray_trace(var_0 + (300, -300, var_4), var_0);

    if(var_12["fraction"] > 0.99) {
      var_11 = 1;
      var_9 = var_0 + (300, -300, var_4);
    }
  }

  if(!var_11) {
    for(var_13 = 0; var_13 < 5; var_13++) {
      var_4 = var_4 / 2;
      var_5 = (0, 0, var_4);
      var_9 = var_8 + var_5 + var_7 * var_6 * -1;
      var_14 = scripts\engine\trace::ray_trace(var_0, var_9, var_10);

      if(var_14["fraction"] > 0.99) {
        var_11 = 1;
        break;
      }

      wait 0.05;
    }
  }

  if(!var_11) {
    for(var_13 = 0; var_13 < 5; var_13++) {
      var_4 = var_4 * 2.5;
      var_5 = (0, 0, var_4);
      var_9 = var_8 + var_5 + var_7 * var_6 * -1;
      var_14 = scripts\engine\trace::ray_trace(var_0, var_9, var_10);

      if(var_14["fraction"] > 0.99) {
        var_11 = 1;
        break;
      }

      wait 0.05;
    }
  }
}

_id_B87A() {
  if(isDefined(self._id_B864) && self._id_B864) {
    return;
  }
  scripts\engine\utility::_id_B27F("javelin_clu_lock", self.origin);
  self._id_B864 = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.75);
  self stoploopsound("javelin_clu_lock");
  self._id_B864 = 0;
}

_id_B879() {
  if(isDefined(self._id_B864) && self._id_B864) {
    return;
  }
  self playlocalsound("javelin_clu_aquiring_lock");
  self._id_B864 = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.75);
  self _meth_83EF("javelin_clu_aquiring_lock");
  self._id_B864 = 0;
}

_id_24A9() {
  self endon("death");
  self notify("begin_evasive_maneuvers");
  self endon("begin_evasive_maneuvers");
  self._id_5688 = 1;
  var_0 = scripts\engine\utility::_id_108A7(3.0, "death");

  if(var_0 == "timeout") {
    self._id_5688 = 0;
  }
}

_id_10B76() {
  self endon("death");
  self endon("leaving");
  self endon("following_player");

  for(;;) {
    var_0 = undefined;

    if(istrue(self._id_5688)) {
      var_1 = self.owner.origin[0];
      var_2 = self.owner.origin[1];
      var_3 = var_1 + randomintrange(-500, 500);
      var_4 = var_2 + randomintrange(-500, 500);
      var_5 = _id_6988(var_3, var_4, 350);
      var_0 = (var_3, var_4, var_5);
    }

    if(isDefined(var_0)) {
      self setvehgoalpos(var_0, 1);
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.1);
  }
}

_id_10AD2(var_0) {
  self endon("dropped_crates");
  var_1 = self._id_502B;
  self waittill("death");
  thread _id_502B(var_1, var_0);
}

_id_502B(var_0, var_1) {
  self notify("dropped_crates");
}

_id_10AFB(var_0, var_1) {
  scripts\engine\utility::waittill_any_2("captured", "death");
  var_0 notify("crate_captured_" + var_1);
}

_id_10B8F() {
  self endon("death");
  self endon("leaving");
  var_0 = 0;

  for(;;) {
    scripts\engine\utility::waittill_any_3("crate_captured_0", "crate_captured_1", "crate_captured_2");
    var_0++;

    if(var_0 == self._id_502B.size) {
      self notify("all_crates_gone");
      break;
    }
  }
}

_id_24AC(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_8B53)) {
    level._id_8B53 = [];
  }

  var_6 = undefined;
  self notify("called_in_jackal");
  var_7 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_2 = var_2 * (1, 1, 0);
  var_8 = 1000;
  var_9 = var_2 + (0, 0, var_8);
  var_10 = _id_E316(var_0, self, var_1, var_9, var_3, var_4);
  var_10._id_AEDC = var_9;
  thread _id_4620(var_10, var_6);
  return var_10;
}

_id_4620(var_0, var_1) {
  var_0 endon("death");
  var_0 setvehgoalpos(var_0._id_AEDC, 1);
  var_0 _meth_827E("dropship_killstreak_thrust_change");
  var_0 thread _id_39F8(var_0._id_AEDC);
  var_0 thread _id_A12D();
  var_0 waittill("goal");
  var_0 thread _id_10B65();
  var_0 thread _id_5459();
  var_0 thread _id_545A();
  var_0 vehicle_setspeed(int(var_0.speed / 14), int(var_0.accel / 16));
}

_id_7257(var_0, var_1, var_2) {
  self endon("death");
  self endon("leaving");
  self endon("follow_player");
  self endon("jackal_crashing");

  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  self vehicle_setspeed(int(self.speed / 14), int(self.accel / 16));

  if(isDefined(var_1)) {
    self setlookatent(var_1);
  }

  if(isDefined(var_0)) {
    var_3 = undefined;
    var_4 = var_0[0];
    var_5 = var_0[1];

    if(istrue(self._id_5688)) {
      var_6 = var_4 + randomintrange(-500, 500);
      var_7 = var_5 + randomintrange(-500, 500);
      var_8 = _id_6989(var_6, var_7, 350, var_2);
      var_3 = (var_6, var_7, var_8);
    } else {
      var_8 = _id_6989(var_4, var_5, 20, var_2);
      var_3 = (var_4, var_5, var_8);
    }

    self setvehgoalpos(var_3, 1);
    self._id_8F81 = "following_player";
    scripts\engine\utility::waittill_any_2("goal", "begin_evasive_maneuvers");
    self _meth_807E();
  }
}

_id_6989(var_0, var_1, var_2, var_3) {
  var_4 = 200;

  if(isDefined(var_3)) {
    var_4 = var_3;
  }

  var_5 = _id_F3CB(var_0, var_1);
  var_6 = var_5 + var_4;
  var_6 = var_6 + randomint(var_2);
  return var_6;
}