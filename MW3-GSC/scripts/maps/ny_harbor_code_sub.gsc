/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\ny_harbor_code_sub.gsc
***********************************************/

_id_4AF0() {
  common_scripts\utility::flag_init("barracks_sandman_opening_door");

  if(!common_scripts\utility::flag_exist("barracks_guys_dead")) {
    common_scripts\utility::flag_init("barracks_guys_dead");
  }
  level._id_4AF1 = [];
  maps\_utility::_id_27CB("sub_enemy", ::_id_4B6B);
  thread _id_4B65();
  thread _id_4B63();
  thread _id_4B6C();
  thread _id_4B74();
  thread _id_4B8E();
  thread _id_4B9D();
  thread _id_4BAD();
  thread _id_4B69();
  thread _id_4BED();
  thread _id_4AF6();
  thread _id_4B6A();
  thread _id_4BEE();
  thread _id_4B67();
  thread _id_4B7D();
  thread _id_4B4B();
  thread _id_4B4C();
  thread _id_4AF3();
  thread _id_4BF5();
  thread _id_4AF2();
  _id_4B5A(0);
  maps\_utility::_id_2797(75);
  level.player allowsprint(1);
  maps\_utility::_id_1425("sub_exterior");
}

_id_4AF2() {
  level endon("ladder_done");

  for(;;) {
    if(common_scripts\utility::flag("sub_disable_prone")) {
      level.player allowprone(0);
      level.player allowcrouch(0);
    } else {
      level.player allowprone(1);
      level.player allowcrouch(1);
    }

    wait 0.05;
  }
}

_id_4AF3() {
  common_scripts\utility::flag_wait("player_on_boat");

  foreach(var_1 in level._id_4AF1) {}
  var_1 delete();
}

_id_4AF4(var_0, var_1) {
  while(isDefined(self) && self.health >= 30) {
    wait 0.05;

    if(isDefined(var_1) && common_scripts\utility::flag(var_1)) {
      maps\_utility::_id_1414();
      common_scripts\utility::flag_clear(var_1);
    }
  }

  if(isDefined(self)) {
    maps\_utility::_id_1414();
  }
}

_id_4AF5(var_0, var_1) {}

_id_4AF6() {
  common_scripts\utility::flag_wait("player_surfaces");

  if(isDefined(level._id_4AF7) && level._id_4AF7.size > 0) {
    foreach(var_1 in level._id_4AF7) {}
    var_1 delete();
  }

  if(isDefined(level._id_4AF8)) {
    level._id_4AF8 delete();
  }
  if(isDefined(level._id_4A98)) {
    level._id_4A98 delete();
  }
}

_id_4AF9() {}

_id_4AFA(var_0) {
  var_0.origin = var_0.origin + (0, 0, 96);
  thread _id_4B0B(var_0, 0.0);
  level._id_4A49 setModel("vehicle_russian_oscar2_sub_breached");
}

_id_4AFB(var_0, var_1) {
  self waittillmatch("single anim", "subswap");
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  level._id_4AFC delete();
  level._id_4AFC = undefined;
  level._id_4A49 hide();
  var_2 = getent("burya2", "targetname");
  var_2 show();
}

_id_4AFD() {
  wait 0.05;
  level notify("stop_bob");
}

_id_4AFE() {
  thread _id_4B4D();
  thread _id_4B46();
}

_id_4AFF(var_0, var_1, var_2, var_3) {
  thread maps\_anim::_id_1246(var_0, var_1, var_2);
  var_4 = var_0 maps\_utility::_id_1281(var_1);
  var_5 = getanimlength(var_4);
  var_0 setflaggedanim("single_anim", var_4, 1.0, var_3, 1.0);
  var_0 maps\_utility::_id_11E4("single anim", "end", var_5);
}

_id_4B00(var_0, var_1) {
  wait 0.05;
  var_2 = var_0 gettagangles("body");
  var_3 = var_1 gettagangles("body");
  var_4 = var_1 gettagorigin("body") - var_0 gettagorigin("body");
  var_5 = var_3 - var_2;

  foreach(var_7 in level._id_4B01) {
    if(var_7 == level._id_4970) {
      continue;
    }
    var_8 = var_7.origin + var_4;
    var_9 = var_7.angles + var_5;
    var_10 = anglesToForward(var_9);
    var_7 dontinterpolate();
    var_7 vehicle_teleport(var_8, var_9);
    var_7 vehicledriveto(var_8 + 1200 * var_10, 1.0);
    var_7 vehicle_setspeed(level._id_49C3 vehicle_getspeed(), 10, 10);
  }
}

_id_4B02() {
  level.player lerpviewangleclamp(1.0, 0.3, 0.3, 15, 0, 15, 0);
  level.player enableslowaim();
}

_id_4B03(var_0) {
  level waittill("cleanup_bob");
  var_0._id_4B04 delete();
  var_0 delete();
}

_id_4B05(var_0, var_1) {
  level waittill(var_1);

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_4B06(var_0, var_1) {
  var_2 = var_0._id_4B04;

  if(!isDefined(var_2)) {
    var_2 = common_scripts\utility::spawn_tag_origin();
  }
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_0._id_4B04 = var_2;
  var_0._id_4B07 = var_0.origin;
  level endon("stop_bob");
  var_0 endon("death");
  thread _id_4B03(var_0);
  var_3 = 12.0;
  var_4 = 0;
  var_5 = 12.0;
  var_6 = 0.5;
  var_7 = 1.5;

  for(;;) {
    var_8 = randomfloatrange(0.0, 1.0);
    var_8 = var_8 * 360;
    var_9 = var_1 * randomfloatrange(0.0, var_3);
    var_10 = var_9 * cos(var_8);
    var_11 = var_9 * cos(var_8);
    var_12 = var_1 * randomfloatrange(var_4, var_5);
    var_13 = randomfloatrange(var_6, var_7);
    var_0._id_4B04 moveto(var_0._id_4B07 + (var_10, var_11, var_12), var_13, var_13 / 4.0, var_13 / 4.0);
    wait(var_13);
  }
}

_id_4B08(var_0) {
  var_1 = var_0._id_4B04;

  if(!isDefined(var_1)) {
    var_1 = common_scripts\utility::spawn_tag_origin();
  }
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_0._id_4B04 = var_1;
  var_0._id_4B07 = var_0.origin;
  level endon("stop_bob");
  thread _id_4B03(var_0);
  return;
}

_id_4B09(var_0) {
  level endon("stop_bob");
  var_0 endon("death");
  var_1 = -430;
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = self.origin;
  var_2.angles = (-90, 0, 0);
  thread _id_4B05(var_2, "stop_bob");
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    var_2.origin = (self.origin[0], self.origin[1], var_0._id_4B0A[2] + var_1);

    if(var_3 >= var_4) {
      playFXOnTag(common_scripts\utility::getfx("ocean_ripple"), var_2, "tag_origin");
      var_4 = randomfloatrange(0.25, 0.5);
      var_3 = 0;
    } else {
      var_3 = var_3 + 0.05;
    }
    wait 0.05;
  }
}

_id_4B0B(var_0, var_1) {
  level endon("stop_bob");
  var_0 endon("death");
  var_0._id_4B07 = var_0.origin;
  var_0._id_4B0A = var_0.origin;

  if(var_1 > 0) {
    thread _id_4B06(var_0, var_1);
  } else {
    thread _id_4B08(var_0);
    thread _id_4B09(var_0);
  }

  for(;;) {
    var_2 = self.origin;
    var_3 = maps\_ocean::_id_4A36(level._id_4A30["water_patch"], var_2);
    var_0._id_4B0A = var_0._id_4B07 + (0, 0, var_3);
    var_0.origin = var_0._id_4B0A + (var_0._id_4B04.origin - var_0._id_4B07);
    wait 0.05;
  }
}

_id_4B0C(var_0, var_1) {
  var_2 = getent(var_1, "targetname");
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_2.origin - (0, 0, 48);
  var_3.origin = var_2.origin;
  var_3.angles = var_2.angles;
  var_0 show();
  var_0 forceteleport(var_3.origin, var_3.angles);
  var_0 linkto(var_3, "tag_origin");
  var_0 thread _id_4B0B(var_2, var_3, -6, 0.0);
}

_id_4B0D() {
  common_scripts\utility::flag_wait("player_surfaces");
  thread _id_4B0E();
  common_scripts\utility::flag_wait("done_watching_explosion");
  wait 1;
  common_scripts\utility::flag_wait("sub_breach_finished");
  level.player unlink();
  level notify("stop_bob");
  level._id_49C3 hide();
  level.player enableweapons();
  level.player freezecontrols(0);
  level.player.ignoreme = 0;
  common_scripts\utility::flag_set("get_onto_sub");
}

_id_4B0E() {
  common_scripts\utility::flag_wait("submine_detonated");
  wait 1;
  common_scripts\utility::flag_set("done_watching_explosion");
}

_id_17CC(var_0) {
  if(level._id_16C9) {
    return;
  }
  level notify("now_fade_in");
  var_1 = _id_473C();

  if(var_0) {
    var_1 fadeovertime(var_0);
  }
  var_1.alpha = 0;
  wait(var_0);
}

_id_09FA(var_0) {
  var_1 = _id_473C();

  if(var_0) {
    var_1 fadeovertime(var_0);
  }
  var_1.alpha = 1;
  wait(var_0);
}

_id_473C() {
  if(!isDefined(level._id_473D)) {
    level._id_473D = maps\_hud_util::_id_09A7("black", 0, level.player);
  }
  level._id_473D.sort = -1;
  level._id_473D.foreground = 0;
  return level._id_473D;
}

_id_4B0F(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3 in var_0) {
    if(var_1) {
      var_3 hide();
      var_3.hidden = 1;
      continue;
    }

    var_3 show();
    var_3.hidden = 0;
  }
}

_id_4B10() {
  var_0 = getent("ship2_squeeze", "targetname");
  var_1 = getent("ship_squeeze_ship", "targetname");
  _id_4B3A([var_0], var_1._id_4B13, var_1._id_4B12, var_1._id_4B11);
  var_0 thread _id_4B37(0);
  common_scripts\utility::flag_wait("ladder_done");
  var_0 _id_4B33();
}

_id_4B14(var_0) {
  var_1 = getEntArray("dyn_water", "script_noteworthy");
  var_2 = getEntArray("stat_water", "script_noteworthy");
  var_3 = getEntArray("dyn_water_sub", "script_noteworthy");
  var_4 = getEntArray("stat_water_sub", "script_noteworthy");
  var_5 = getEntArray("dyn_water_breachpatch_high", "script_noteworthy");
  var_6 = getEntArray("dyn_water_breachpatch_low", "script_noteworthy");
  var_7 = getEntArray("water_flyout", "script_noteworthy");
  var_8 = getEntArray("water_flyout_off", "script_noteworthy");

  switch (var_0) {
    case 0:
      _id_4B0F(var_3, 0);
      _id_4B0F(var_4, 1);
      _id_4B0F(var_5, 1);
      _id_4B0F(var_6, 0);
      _id_4B0F(var_1, 1);
      _id_4B0F(var_2, 0);
      _id_4B0F(var_7, 1);
      _id_4B0F(var_8, 0);
      break;
    case 1:
      _id_4B0F(var_3, 0);
      _id_4B0F(var_4, 1);
      _id_4B0F(var_5, 1);
      _id_4B0F(var_6, 0);
      _id_4B0F(var_1, 1);
      _id_4B0F(var_2, 0);
      _id_4B0F(var_7, 1);
      _id_4B0F(var_8, 0);
      break;
    case 2:
      _id_4B0F(var_3, 0);
      _id_4B0F(var_4, 1);
      _id_4B0F(var_5, 1);
      _id_4B0F(var_6, 0);
      _id_4B0F(var_1, 1);
      _id_4B0F(var_2, 0);
      _id_4B0F(var_7, 1);
      _id_4B0F(var_8, 0);
      break;
    case 3:
      _id_4B0F(var_3, 1);
      _id_4B0F(var_4, 1);
      _id_4B0F(var_5, 1);
      _id_4B0F(var_6, 1);
      _id_4B0F(var_1, 1);
      _id_4B0F(var_2, 1);
      _id_4B0F(var_7, 0);
      _id_4B0F(var_8, 1);
      break;
  }
}

_id_4B15(var_0) {
  self endon("stop_bobbing");

  for(;;) {
    if(common_scripts\utility::flag("outside_above_water") || self._id_4B11) {
      var_1 = (self._id_4B16[3], self._id_4B16[4], self._id_4B16[5]);
      var_2 = (self._id_4B16[0], self._id_4B16[1], self._id_4B16[2]);
      self moveto(var_1, 0.1, 0.0, 0.0);

      if(!var_0) {
        self rotateto(var_2, 0.1, 0.0, 0.0);
      }
      wait 0.05;
      continue;
    }

    wait 0.2;
  }
}

_id_4B17(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("stop_bobbing");
  var_7 = randomint(2);
  self._id_4B16[var_0] = var_1;

  for(;;) {
    if(common_scripts\utility::flag("outside_above_water") || self._id_4B11) {
      var_8 = var_1;
      var_9 = var_4;

      switch (var_7) {
        case 0:
          var_8 = var_1 + randomfloat(var_3);
          break;
        case 1:
          if(var_2 < 0) {
            var_8 = var_1 - randomfloat(-1 * var_2);
          } else {
            var_8 = var_1 + randomfloat(var_2);
          }
          break;
      }

      var_9 = randomfloatrange(var_4, var_5);
      var_10 = var_9 / 3.0;
      var_11 = var_9 / 3.0;

      if(var_6) {
        var_12 = 0;

        if(var_0 < 3) {
          var_12 = var_8 - self.angles[var_0];
          var_12 = angleclamp180(var_12);
        }

        switch (var_0) {
          case 0:
            self rotatepitch(var_12, var_9, var_10, var_11);
            break;
          case 1:
            self rotateyaw(var_12, var_9, var_10, var_11);
            break;
          case 2:
            self rotateroll(var_12, var_9, var_10, var_11);
            break;
          case 3:
            self movex(var_8 - self.origin[0], var_9, var_10, var_11);
            break;
          case 4:
            self movey(var_8 - self.origin[1], var_9, var_10, var_11);
            break;
          case 5:
            self movez(var_8 - self.origin[2], var_9, var_10, var_11);
            break;
        }

        wait(var_9);
      } else {
        while(0 < var_9) {
          var_13 = self._id_4B16[var_0];
          var_12 = var_8 - var_13;
          self._id_4B16[var_0] = self._id_4B16[var_0] + 0.05 / var_9 * var_12;
          wait 0.05;
          var_9 = var_9 - 0.05;
        }
      }

      var_7 = 1 - var_7;
      continue;
    }

    wait 0.2;
  }
}

_id_4B18() {
  self endon("stop_bobbing");
  var_0 = 0.3;
  var_1 = 1.5;
  var_2 = 60.0;
  var_3 = 3.0;
  var_4 = 4.0;
  var_5 = var_0 * var_4;
  var_6 = 0;
  self._id_4B19 = self.angles;

  if(self._id_4B19[0] == 0 && self._id_4B19[2] == 0) {
    var_7 = 1;
  } else {
    var_7 = 0;
  }
  var_8 = (0, 0, 0);
  var_9 = 18.0 / var_2;
  var_10 = 0.36 / var_3;

  for(;;) {
    if(common_scripts\utility::flag("outside_above_water") || self._id_4B11) {
      var_11 = calcrockingangles(self._id_4B19, var_6, 4.0, 3.0, 60.0);
      var_12 = var_11["angles"];
      var_6 = var_11["result"];
      self rotateto(var_12, 0.4, 0, 0);
    }

    wait 0.2;
  }
}

_id_4B1A(var_0) {
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = 5;
  var_4 = 3;
  var_5 = 6;
  var_6 = 0;
  var_7 = 3;
  var_8 = 6;
  var_9 = 0;
  var_10 = 3;
  var_11 = 6;
  var_12 = 36;
  var_13 = 24;
  var_14 = 3;
  var_15 = 6;
  var_16 = 0;
  var_17 = 3;
  var_18 = 6;
  var_19 = 0;
  var_20 = 3;
  var_21 = 6;
  var_22 = 1;

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_14C6)) {
      var_3 = var_0._id_14C6;
    }
    if(isDefined(var_0._id_4B1B)) {
      var_4 = var_0._id_4B1B;
    }
    if(isDefined(var_0._id_4B1C)) {
      var_5 = var_0._id_4B1C;
    }
    if(isDefined(var_0._id_4B1D)) {
      var_6 = var_0._id_4B1D;
    }
    if(isDefined(var_0._id_4B1E)) {
      var_7 = var_0._id_4B1E;
    }
    if(isDefined(var_0._id_4B1F)) {
      var_8 = var_0._id_4B1F;
    }
    if(isDefined(var_0._id_4B20)) {
      var_9 = var_0._id_4B20;
    }
    if(isDefined(var_0._id_4B21)) {
      var_10 = var_0._id_4B21;
    }
    if(isDefined(var_0._id_4B22)) {
      var_11 = var_0._id_4B22;
    }
    if(isDefined(var_0._id_4B23)) {
      var_12 = var_0._id_4B23;
    }
    if(isDefined(var_0._id_4B24)) {
      var_13 = var_0._id_4B24;
    }
    if(isDefined(var_0._id_4B25)) {
      var_14 = var_0._id_4B25;
    }
    if(isDefined(var_0._id_4B26)) {
      var_15 = var_0._id_4B26;
    }
    if(isDefined(var_0._id_4B27)) {
      var_16 = var_0._id_4B27;
    }
    if(isDefined(var_0._id_4B28)) {
      var_17 = var_0._id_4B28;
    }
    if(isDefined(var_0._id_4B29)) {
      var_18 = var_0._id_4B29;
    }
    if(isDefined(var_0._id_4B2A)) {
      var_19 = var_0._id_4B2A;
    }
    if(isDefined(var_0._id_4B2B)) {
      var_20 = var_0._id_4B2B;
    }
    if(isDefined(var_0._id_4B2C)) {
      var_21 = var_0._id_4B2C;
    }
    if(isDefined(var_0._id_4B2D)) {
      var_22 = var_0._id_4B2D;
    }
  }

  self._id_4B16[0] = var_2[0];
  self._id_4B16[1] = var_2[1];
  self._id_4B16[2] = var_2[2];
  self._id_4B16[3] = var_1[0];
  self._id_4B16[4] = var_1[1];
  self._id_4B16[5] = var_1[2];

  if(!var_22) {
    thread _id_4B15(isDefined(var_0._id_4B2E));
  }
  if(isDefined(var_0._id_4B2E)) {
    thread _id_4B18();
  } else {
    if(var_3 > 0) {
      thread _id_4B17(0, var_2[0], 0 - var_3, var_3, var_4, var_5, var_22);
    }
    if(var_6 > 0) {
      thread _id_4B17(1, var_2[1], 0 - var_6, var_6, var_7, var_8, var_22);
    }
    if(var_9 > 0) {
      thread _id_4B17(2, var_2[2], 0 - var_9, var_9, var_10, var_11, var_22);
    }
  }

  if(var_16 > 0) {
    thread _id_4B17(3, var_1[0], 0 - var_16, var_16, var_17, var_18, var_22);
  }
  if(var_19 > 0) {
    thread _id_4B17(4, var_1[1], 0 - var_19, var_19, var_20, var_21, var_22);
  }
  if(var_13 > 0) {
    thread _id_4B17(5, var_1[2], 0 - var_12, var_13, var_14, var_15, var_22);
  }
}

_id_4B2F(var_0) {
  if(var_0 == 1) {
    var_1 = 1;
  } else {
    var_2 = var_0 * var_0;
    var_1 = 3 * var_2 - 2 * var_2 * var_0;
  }

  return var_1;
}

_id_4B30(var_0) {
  self endon("stop_bobbing");
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = randomfloatrange(3, 10);
  var_4 = 0;
  var_5 = randomintrange(20, 60);
  var_6 = 0;

  for(;;) {
    var_7 = maps\_ocean::_id_4A36(level._id_4A30["water_patch"], var_1);
    self.origin = (var_1[0], var_1[1], var_1[2] + var_7);
    var_8 = (var_3 - var_4) * _id_4B2F(var_6 / var_5) + var_4;
    self.angles = (var_2[0] + var_8, var_2[1], var_2[2]);
    var_6++;

    if(var_6 > var_5) {
      var_4 = var_3;

      if(var_3 > 0) {
        var_3 = -1 * randomfloatrange(3, 10);
      } else {
        var_3 = randomfloatrange(3, 10);
      }
      var_5 = randomintrange(20, 60);
      var_6 = 1;
    }

    wait 0.05;
  }
}

_id_4B31() {
  var_0 = spawnStruct();
  var_0._id_14C6 = 5;
  var_0._id_4B1B = 3;
  var_0._id_4B1C = 6;
  var_0._id_4B1D = 0;
  var_0._id_4B1E = 3;
  var_0._id_4B1F = 6;
  var_0._id_4B20 = 0;
  var_0._id_4B21 = 3;
  var_0._id_4B22 = 6;
  var_0._id_4B23 = 36;
  var_0._id_4B24 = 24;
  var_0._id_4B25 = 3;
  var_0._id_4B26 = 6;
  return var_0;
}

_id_4B32() {
  var_0 = spawnStruct();
  var_0._id_14C6 = 10;
  var_0._id_4B1B = 1;
  var_0._id_4B1C = 3;
  var_0._id_4B1D = 0;
  var_0._id_4B1E = 3;
  var_0._id_4B1F = 6;
  var_0._id_4B20 = 10;
  var_0._id_4B21 = 1;
  var_0._id_4B22 = 3;
  var_0._id_4B23 = 12;
  var_0._id_4B24 = 12;
  var_0._id_4B25 = 1;
  var_0._id_4B26 = 3;
  var_0._id_4B2E = 1;
  return var_0;
}

_id_4B33() {
  self._id_4B34 = 1;
  self notify("stop_bobbing");
}

_id_4B35() {
  self._id_4B19 = self.angles;
  self._id_4B36 = self.origin;
  self waittill("stop_bobbing");
  waittillframeend;
  self rotateto(self._id_4B19, 1, 0, 0);
  self moveto(self._id_4B36, 1, 0, 0);
}

_id_4B37(var_0) {
  self notify("stop_bobbing");
  self endon("stop_bobbing");
  thread _id_4B35();
  wait(var_0);

  if(isDefined(self._id_4B34) && self._id_4B34) {
    return;
  }
  self[[self._id_4B13]](self._id_4B12);
}

_id_4B38(var_0) {
  var_1 = 1.0;
  var_2 = 0.0;

  foreach(var_4 in var_0) {
    var_4 thread _id_4B37(var_2);
    var_2 = var_2 + 0.05;

    if(var_2 > var_1) {
      var_2 = var_2 - var_1;
    }
  }
}

_id_4B39(var_0) {
  foreach(var_2 in var_0) {}
  var_2 notify("stop_bobbing");
}

_id_4B3A(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_5._id_4B13 = var_1;
    var_5._id_4B12 = var_2;
    var_5._id_4B11 = var_3;
  }
}

_id_4B3B() {
  level._id_4B3C = [];
  var_0 = _id_4B31();
  var_1 = getEntArray("bobbing_ship", "script_noteworthy");
  _id_4B3A(var_1, ::_id_4B1A, var_0, 0);
  level._id_4B3C = maps\_shg_common::_id_1690(level._id_4B3C, var_1);
  var_2 = _id_4B31();
  var_2._id_14C6 = 1.0;
  var_3 = getEntArray("bobbing_ship_big", "script_noteworthy");
  _id_4B3A(var_3, ::_id_4B1A, var_2, 0);
  level._id_4B3C = maps\_shg_common::_id_1690(level._id_4B3C, var_3);
  var_4 = _id_4B31();
  var_4._id_14C6 = 2;
  var_5 = getEntArray("sinking_ship", "script_noteworthy");
  _id_4B3A(var_5, ::_id_4B1A, var_4, 0);
  level._id_4B3C = maps\_shg_common::_id_1690(level._id_4B3C, var_5);
  var_6 = _id_4B32();
  var_7 = getEntArray("bobbing_object", "script_noteworthy");
  _id_4B3A(var_7, ::_id_4B1A, var_6, 0);
  level._id_4B3C = maps\_shg_common::_id_1690(level._id_4B3C, var_7);
  var_8 = _id_4B32();
  var_9 = getEntArray("bobbing_buoy", "script_noteworthy");
  _id_4B3A(var_9, ::_id_4B1A, var_8, 0);
  level._id_4B3C = maps\_shg_common::_id_1690(level._id_4B3C, var_9);
  var_10 = getEntArray("bobbing_expensive", "script_noteworthy");
  _id_4B3A(var_10, ::_id_4B30, undefined, 0);
  level._id_4B3C = maps\_shg_common::_id_1690(level._id_4B3C, var_10);
  var_11 = _id_4B31();
  var_11._id_14C6 = 5;
  var_11._id_4B1B = 3;
  var_11._id_4B1C = 8;
  var_11._id_4B1D = 10;
  var_11._id_4B1E = 3;
  var_11._id_4B1F = 8;
  var_11._id_4B20 = 5;
  var_11._id_4B21 = 3;
  var_11._id_4B22 = 8;
  var_11._id_4B23 = 12;
  var_11._id_4B24 = 12;
  var_11._id_4B25 = 3;
  var_11._id_4B26 = 8;
  var_11._id_4B27 = 12;
  var_11._id_4B28 = 3;
  var_11._id_4B29 = 8;
  var_11._id_4B2A = 12;
  var_11._id_4B2B = 3;
  var_11._id_4B2C = 8;
  var_11._id_4B2D = 0;
  var_12 = getEntArray("underwater_mines", "script_noteworthy");
  _id_4B3A(var_12, ::_id_4B1A, var_11, 1);
  thread _id_4B38(var_12);
}

_id_4B3D() {
  var_0 = getEntArray("bobbing_volume", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2._id_4B3E = [];

    foreach(var_4 in level._id_4B3C) {
      if(!isDefined(var_4._id_4B3F)) {
        if(var_2 istouching(var_4)) {
          var_4._id_4B3F = var_2;
          var_2._id_4B3E[var_2._id_4B3E.size] = var_4;
        }
      }
    }
  }

  level._id_4B40 = [];

  foreach(var_4 in level._id_4B3C) {
    if(!isDefined(var_4._id_4B3F)) {
      level._id_4B40[level._id_4B40.size] = var_4;
    }
  }
}

_id_4B41() {
  if(isDefined(self._id_4B3E)) {
    thread _id_4B38(self._id_4B3E);
  }
}

_id_4B42() {
  if(isDefined(self._id_4B3E)) {
    thread _id_4B39(self._id_4B3E);
  }
}

_id_4B43() {
  foreach(var_1 in level._id_4B3C) {}
  var_1.origin = var_1.origin + (0, 0, 480);
}

_id_4B44(var_0, var_1) {
  var_2 = getEntArray("bobbing_volume", "script_noteworthy");

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_164F) && var_4._id_164F == var_0) {
      if(var_1) {
        var_4 thread _id_4B41();
        continue;
      }

      var_4 thread _id_4B42();
    }
  }
}

_id_4B45(var_0) {
  common_scripts\utility::flag_wait("obj_capturesub_complete");
  level notify("stop_rocking");
  level.player playersetgroundreferenceent(undefined);
  self delete();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_4B46() {
  level._id_4B47[0] = 0.5;
  level._id_4B47[1] = 1.5;
  common_scripts\utility::flag_set("outside_above_water");
}

_id_4B48() {
  level._id_4B47[0] = 1.0;
  level._id_4B47[1] = 2.5;
  common_scripts\utility::flag_clear("outside_above_water");
}

_id_4B49() {
  var_0 = getEntArray("rocking_water", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();
}

_id_4B4A() {
  var_0 = getEntArray("rocking_water", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();
}

_id_4B4B() {
  level endon("player_on_boat");

  for(;;) {
    maps\_utility::_id_262C("trig_water_on");
    thread _id_4B4A();
    wait 0.05;
  }
}

_id_4B4C() {
  level endon("player_on_boat");

  for(;;) {
    maps\_utility::_id_262C("trig_water_off");
    thread _id_4B49();
    wait 0.05;
  }
}

_id_4B4D() {
  level endon("stop_rocking");
  var_0 = getent("rocking_reference", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = undefined;

  if(!isDefined(var_0)) {
    var_1.angles = (0, 0, 0);
  } else {
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
  }

  var_1 thread _id_4B45(var_2);
  var_3 = 1;
  level._id_4B47[0] = 1.0;
  level._id_4B47[1] = 2.5;
  var_4 = getEntArray("rocking_water", "targetname");
  var_5 = getEntArray("bobbing_small", "script_noteworthy");

  foreach(var_7 in var_5) {
    var_7._id_4B07 = var_7.origin;
    var_7._id_4B4E = var_7.angles;
    var_8 = cos(var_7.angles[1]);
    var_9 = sin(var_7.angles[1]);
    var_7._id_4B4F = (var_8, 0, var_9);
  }

  if(isDefined(var_2)) {
    foreach(var_7 in var_4) {}
    var_7 linkto(var_2, "tag_origin");
  }

  thread _id_4B54();
  level.player playersetgroundreferenceent(var_1);
  thread _id_4B52(var_1);

  for(;;) {
    var_13 = randomfloatrange(2.0, 3.0);
    var_14 = var_3 * randomfloatrange(level._id_4B47[0], level._id_4B47[1]);
    var_3 = -1 * var_3;
    var_15 = (0, 0, var_14);
    var_1._id_4B50 = var_15;
    var_1._id_4B51 = gettime() + 1000 * var_13;
    maps\_audio::aud_send_msg("if_the_sub_is_a_rocking_dont_come_a_knocking");
    var_1 rotateto(var_15, var_13, var_13 / 3, var_13 / 3);
    thread _id_4B58(var_3, var_13, var_13 / 3, var_13 / 3);
    thread _id_4B59(var_5, var_15, var_13, var_13 / 3, var_13 / 3);

    if(isDefined(var_2)) {
      var_15 = (0, 0, 0.5 * var_14);
      var_2 rotateto(var_15, var_13, var_13 / 3, var_13 / 3);
    }

    wait(var_13);
  }
}

_id_4B52(var_0) {
  level endon("stop_rocking");
  thread _id_4B53();
  var_1 = 0;
  var_2 = common_scripts\utility::getstruct("jolter", "targetname");
  common_scripts\utility::flag_wait("hatch_player_using_ladder");

  for(;;) {
    var_3 = anglestoup(var_0.angles);
    var_4 = -1 * var_3;
    var_5 = var_4 * (1, 10, 0.75);
    var_6 = vectornormalize(var_5);
    setphysicsgravitydir(var_6);
    var_1++;

    if(var_1 > 10) {
      physicsjitter(var_2.origin, 1000, 800, 0.01, 0.1);
      var_1 = 0;
    }

    wait 0.05;
  }
}

_id_4B53() {
  level waittill("stop_rocking");
  wait 0.05;
  setphysicsgravitydir((0, 0, -1));
}

_id_4B54() {
  level._id_4B55 = [];
  level._id_4B56 = [];
  level._id_4B57 = [];
  var_0 = getEntArray("sub_pressuredoor_rocker", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    var_2 linkto(var_3);
    level._id_4B55[level._id_4B55.size] = var_3;
  }

  var_0 = getEntArray("sub_pressuredoor_rocker_opposite", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    var_2 linkto(var_3);
    level._id_4B56[level._id_4B56.size] = var_3;
  }

  var_7 = getEntArray("dyn_hanger", "targetname");

  foreach(var_9 in var_7) {
    var_3 = getent(var_9.target, "targetname");
    var_9 linkto(var_3);
    level._id_4B57[level._id_4B57.size] = var_3;
  }
}

_id_4B58(var_0, var_1, var_2, var_3) {
  var_4 = 3 * (level._id_4B47[1] * var_0);

  foreach(var_6 in level._id_4B55) {}
  var_6 rotateto((var_6.angles[0], var_6.angles[1] + var_4, var_6.angles[0]), var_1, var_2, var_3);

  foreach(var_6 in level._id_4B56) {}
  var_6 rotateto((var_6.angles[0], var_6.angles[1] + -1 * var_4, var_6.angles[0]), var_1, var_2, var_3);

  foreach(var_6 in level._id_4B57) {
    switch (var_6.script_noteworthy) {
      case "x":
        var_6 rotateto((var_6.angles[0] + var_4, var_6.angles[1], var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "x_neg":
        var_6 rotateto((var_6.angles[0] + -1 * var_4, var_6.angles[1], var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "y":
        var_6 rotateto((var_6.angles[0], var_6.angles[1] + var_4, var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "y_neg":
        var_6 rotateto((var_6.angles[0], var_6.angles[1] + -1 * var_4, var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "z":
        var_6 rotateto((var_6.angles[0], var_6.angles[1], var_6.angles[0] + var_4), var_1, var_2, var_3);
        break;
      case "z_neg":
        var_6 rotateto((var_6.angles[0], var_6.angles[1], var_6.angles[0] + -1 * var_4), var_1, var_2, var_3);
        break;
      default:
        break;
    }
  }
}

_id_4B59(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, 1, 0);
  var_6 = var_1[2];
  var_7 = var_6 / 2.5;

  foreach(var_9 in var_0) {
    var_10 = randomfloatrange(4, 12);
    var_11 = var_9._id_4B07 + var_10 * var_7 * var_5;
    var_9 moveto(var_11, var_2, var_3, var_4);
    var_12 = randomfloatrange(3 * level._id_4B47[0], 3 * level._id_4B47[1]);
    var_13 = var_12 * var_7;
    var_14 = (var_9._id_4B4F[0] * var_13, var_9._id_4B4F[1] * var_13, var_9._id_4B4F[2] * var_13);
    var_1 = var_9._id_4B4E + var_14;
    var_9 rotateto(var_1, var_2, var_3, var_4);
  }
}

_id_4B5A(var_0) {
  var_1 = getEntArray("missle_silo_pocket", "target");

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3 show();
      continue;
    }

    var_3 hide();
  }
}

_id_4B5B(var_0, var_1) {
  var_2 = "missile_hatch_" + var_0 + "_" + var_1;
  var_3 = getEntArray(var_2, "script_noteworthy");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(!isDefined(var_6.targetname)) {
      continue;
    }
    if(var_6.targetname == "missile_hatch") {
      var_4 = var_6;
      break;
    }
  }

  var_4._id_1032 = "missile_hatch";
  var_4 maps\_anim::_id_1244();
  var_8 = common_scripts\utility::spawn_tag_origin();
  var_8.origin = var_4.origin;
  var_8.angles = (270, 0, 0);
  playFXOnTag(common_scripts\utility::getfx("steam_missile_tube"), var_8, "tag_origin");
  var_4 maps\_anim::_id_1246(var_4, "open");
  var_9 = randomfloat(3) + 2;
  wait(var_9);
  stopFXOnTag(common_scripts\utility::getfx("steam_missile_tube"), var_8, "tag_origin");
  var_8 delete();
}

_id_4B5C(var_0, var_1) {
  var_2 = "missle_silo_" + var_0 + "_" + var_1;
  var_3 = getEntArray(var_2, "script_noteworthy");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(!isDefined(var_6.targetname)) {
      continue;
    }
    if(var_6.targetname == "missile_silo_door") {
      var_4 = var_6;
      break;
    }
  }

  var_8 = undefined;

  foreach(var_6 in var_3) {
    if(!isDefined(var_6.targetname)) {
      continue;
    }
    if(var_6.targetname == var_4.target) {
      var_8 = var_6;
      break;
    }
  }

  var_4._id_1032 = "missile_door";
  var_4 maps\_anim::_id_1244();
  var_8 linkto(var_4, "door");
  maps\_audio::aud_send_msg("sub_missile_door_open", var_8);

  if(var_0 == "l") {
    common_scripts\utility::exploder(500 + var_1);
  }
  var_4 maps\_anim::_id_1246(var_4, "open");
}

_id_4B5D() {
  common_scripts\utility::flag_wait("start_opening_missile_doors");
  _id_4B5A(1);

  for(var_0 = 0; var_0 < 6; var_0++) {
    var_1 = (5 - var_0) * 0.5 + randomfloatrange(0.0, 0.4);
    maps\_utility::delaythread(0.1 + var_1, ::_id_4B5C, "l", var_0);
    maps\_utility::delaythread(0.3 + var_1, ::_id_4B5C, "r", var_0);
  }

  for(var_0 = 0; var_0 < 9; var_0++) {
    var_1 = (8 - var_0) * 0.5 + randomfloatrange(0.0, 0.4);
    maps\_utility::delaythread(0.7 + var_1, ::_id_4B5B, "l", var_0);
    maps\_utility::delaythread(1.0 + var_1, ::_id_4B5B, "r", var_0);
  }

  maps\_utility::delaythread(2.5, ::_id_4B61, "l", 9);
  maps\_utility::delaythread(3.5, ::_id_4B61, "l", 7);
  level._id_00AC maps\_utility::delaythread(2.8, maps\_utility::_id_27AF, 0.2, 0.1);
  level._id_00AC maps\_utility::delaythread(4.2, maps\_utility::_id_27AF, 0, 1);
}

_id_4B5E(var_0) {
  wait 0.95;
  playFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke12"), self, "tag_tail");
  wait 0.5;
  maps\_utility::_id_13DB("contrails");
  stopFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke12"), self, "tag_tail");
}

_id_4B5F(var_0) {
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke"), self, "tag_tail");
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("ssn12_init"), self, "tag_tail");
}

_id_4B60() {
  self endon("death");
  wait 0.5;
  self setanim(level._id_0C59["ss_n_12_missile"]["open"], 1, 0);
}

_id_4B61(var_0, var_1) {
  var_2 = "ssn19_" + var_0 + "_" + var_1;
  var_3 = maps\_vehicle::_id_2A99(var_2);
  var_3._id_1032 = "ss_n_12_missile";
  var_3 maps\_anim::_id_1244();
  var_3 setanim(var_3 maps\_utility::_id_1281("close_idle"), 1, 0);
  var_3._id_2950 = 1;
  var_3 thread _id_4B5E(var_2);
  maps\_audio::aud_send_msg("sub_missile_launch", var_3);
  wait 0.75;
  var_3 thread _id_4B60();
  thread maps\_vehicle::_id_1FA6(var_3);
}

_id_4B62() {
  level.player enableweapons();
}

_id_4B63() {
  level._id_45C0.ignoreall = 0;
  level._id_45C0._id_4B64 = 1;
  level._id_45C0 maps\_utility::_id_2686();
  level._id_45C0 maps\_utility::_id_0EEC();
}

_id_4B65() {
  thread _id_4B66();
  common_scripts\utility::flag_wait("ladder_done");
  maps\_audio::aud_send_msg("mus_enter_sub");
  common_scripts\utility::flag_wait("barracks_sandman_opening_door");
  maps\_audio::aud_send_msg("mus_sub_combat_begin");
  common_scripts\utility::flag_wait("reactor_room_announcement");
  maps\_audio::aud_send_msg("mus_sub_scuttle_announcement");
  wait 3;
  maps\_audio::aud_send_msg("aud_scuttle_alarms_start");
}

_id_4B66() {
  common_scripts\utility::flag_wait("door_blown");
  maps\_audio::aud_send_msg("mus_sub_door_breach");
  common_scripts\utility::flag_wait("breach_done");
  maps\_audio::aud_send_msg("mus_sub_combat_end");
  common_scripts\utility::flag_wait("vo_sandman_checkpointneptune");
  maps\_audio::aud_send_msg("mus_program_launch");
}

_id_4B67() {
  thread maps\ny_harbor_code_vo::_id_4ADE();
  thread maps\ny_harbor_code_vo::_id_4ADF();
  thread maps\ny_harbor_code_vo::_id_4AE2();
  thread maps\ny_harbor_code_vo::_id_00AA();
  thread maps\ny_harbor_code_vo::_id_4AE4();
  thread maps\ny_harbor_code_vo::_id_4AE6();
  thread maps\ny_harbor_code_vo::_id_4AE7();
}

_id_4B68() {
  var_0 = getEntArray("missile_hatch", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("missile_silo", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("missle_silo_pocket_middle", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("missile_silo_door", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("missle_silo_pocket", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("missle_silo_pocket_rear", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();
}

_id_4B69() {
  common_scripts\utility::flag_wait("vo_bridge_is_done");
  var_0 = getEntArray("missile_hatch", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("missile_silo", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("missle_silo_pocket_middle", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("missile_silo_door", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("missle_silo_pocket", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("missle_silo_pocket_rear", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();
}

_id_4B6A() {
  common_scripts\utility::flag_wait("sub_entering");
  var_0 = getent("sub_spawner_for_dead1", "targetname");
  var_1 = getEntArray("sub_dead_and_dying_loops", "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_0 maps\_utility::_id_166F(1);
    wait 0.05;
    var_4 maps\_utility::_id_24F5();
    var_4 _id_4BF0(var_3, var_3.animation);
  }
}

_id_4B6B() {
  maps\_utility::_id_260D();
  maps\_utility::_id_0EEC();
  self.grenadeammo = 0;

  if(isDefined(self._id_164F)) {
    thread _id_00AD();
  }
}

_id_00AD() {
  var_0 = "";
  var_1 = "";

  switch (self._id_164F) {
    case "extinguisher":
      self._id_1032 = "extinguisher";
      var_0 = "nyharbor_ru1_extinguisher";
      var_1 = "vo_extinguisher";
      break;
    case "reactor":
      self._id_1032 = "reactor";
      var_0 = "nyharbor_ru2_reactorroom";
      var_1 = "vo_reactor";
      break;
    case "stairs":
      self._id_1032 = "stairs";
      var_0 = "nyharbor_ru3_rushthem";
      var_1 = "vo_stairs";
      break;
    case "missile_1":
      self._id_1032 = "missile_1";
      var_0 = "nyharbor_ru3_intruders";
      var_1 = "missile_room_1_vo";
      break;
    case "missile_2":
      self._id_1032 = "missile_2";
      var_0 = "nyharbor_ru3_fireyourweapon";
      var_1 = "vo_missile_room_2";
      break;
    case "missile_3":
      self._id_1032 = "missile_3";
      var_0 = "nyharbor_ru3_outofammo";
      var_1 = "vo_missile_room_3";
      break;
  }

  thread _id_00AE(var_1, var_0);
}

_id_00AE(var_0, var_1) {
  self endon("death");
  common_scripts\utility::flag_wait(var_0);
  maps\_utility::_id_168C(var_1);
}

_id_4B6C() {
  thread _id_4B6D();
}

_id_4B6D() {
  level._id_4B6E = [];
  common_scripts\utility::flag_wait("ready_for_player_slide");
  wait 15;
  var_0 = 0;

  if(!common_scripts\utility::flag("hatch_player_using_ladder")) {
    var_1 = getent("sub_exterior_hind_kill_player", "targetname");
    var_2 = var_1 maps\_vehicle::_id_1F9E();
    maps\_audio::aud_send_msg("hind_player_killer", var_2);
    var_2 setmaxpitchroll(10, 50);
    level notify("sub_exterior_chopper_spawned", var_2);
    common_scripts\utility::flag_wait("sub_exterior_hind_kill_player_fire");

    while(!common_scripts\utility::flag("hatch_player_using_ladder")) {
      if(var_0 > 2) {
        level.player kill();
      }
      var_2 _id_4B73(level.player, 50, 0.05);
      var_0++;
      wait 5;
    }

    var_2 delete();
  }
}

_id_4B6F() {
  common_scripts\utility::flag_wait("sub_exterior_hind_1_fire");
  var_0 = common_scripts\utility::getstructarray("sub_exterior_fire_at_hind", "targetname");
  var_1 = gettime() + 10000;

  while(var_1 > gettime()) {
    if(level._id_4B6E.size < 1) {
      break;
    }

    var_2 = common_scripts\utility::random(var_0);
    var_3 = common_scripts\utility::random(level._id_4B6E);
    magicbullet("rpg", var_2.origin, var_3.origin);
    wait(randomfloatrange(1, 2));
  }
}

_id_4B70() {
  self endon("death");
  maps\_audio::aud_send_msg("chinook_spawned", self);
  self._id_1032 = "ch46e";
  maps\_anim::_id_1244();
  var_0 = maps\_utility::_id_1281("rotors");
  var_1 = getanimlength(var_0);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    self setanim(var_0);
    wait(var_1);
  }
}

_id_4B71() {
  level._id_4B6E[level._id_4B6E.size] = self;
  self waittill("death");
  level._id_4B6E = common_scripts\utility::array_remove(level._id_4B6E, self);
}

_id_4B72() {
  maps\_audio::aud_send_msg("hind_spawned", self);
  var_0 = self.script_noteworthy;
  self endon("death");
  common_scripts\utility::flag_wait(var_0 + "_fire");
  var_1 = common_scripts\utility::getstruct(var_0 + "_target", "targetname");
  _id_4B73(var_1, 75, 0.1);
}

_id_4B73(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(self._id_28E3)) {
    var_3 = self._id_28E3;
  } else {
    var_3 = "hind_turret";
  }
  var_4 = "hind_turret";
  var_5 = undefined;
  var_6 = [];
  self setvehweapon(var_3);

  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  if(!isDefined(var_2)) {
    var_2 = 1;
  }
  var_7 = var_0;
  var_8 = undefined;
  var_9 = undefined;

  if(!isDefined(var_0.classname)) {
    var_10 = spawn("script_origin", var_0.origin);
    thread common_scripts\utility::delete_on_death(var_10);
    var_10.targetname = var_0.targetname;
    var_10.origin = var_0.origin;
    var_7 = var_10;
  }

  if(isDefined(var_0.target)) {
    if(!isDefined(var_0.classname)) {
      var_11 = common_scripts\utility::getstruct(var_0.target, "targetname");
      var_12 = distance(var_0.origin, var_11.origin);
      var_13 = vectortoangles(var_11.origin - var_0.origin);
      var_9 = anglesToForward(var_13);
      var_8 = var_12 / var_1;
    }
  }

  self setturrettargetent(var_7);

  for(var_14 = 0; var_14 < var_1; var_14++) {
    self fireweapon("tag_flash", var_7);
    wait(var_2);

    if(isDefined(var_8) && isDefined(var_9)) {
      var_7.origin = var_7.origin + var_9 * var_8;
    }
  }

  self setvehweapon(var_3);
}

_id_4B74() {
  thread _id_4B7E();
  thread _id_4B85();
  common_scripts\utility::flag_wait("sub_entrance_gameplay");
  thread _id_4B7C();
  thread _id_4B75();
  thread _id_03C3::_id_4A4D();
}

_id_4B75() {
  level._id_4B76 = 0;
  var_0 = getEntArray("hatch_enemy", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, ::_id_4B77);
  maps\_utility::_id_272B(var_0, 1);
}

_id_4B77() {
  self endon("death");
  thread _id_4B7B();
  self.goalradius = 8;
  self._id_0EC6 = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self waittill("goal");
  wait 1;
  self.ignoreme = 0;
  self.ignoreall = 0;
}

_id_4B78(var_0) {
  playFXOnTag(common_scripts\utility::getfx("flesh_hit"), var_0, "j_head");
}

_id_4B79(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_1, "targetname");
  var_5 = var_4 maps\_utility::_id_166F(1);
  maps\_utility::_id_13AF();

  if(isDefined(var_3) && var_3) {
    var_5 maps\_utility::_id_0D04();
    var_5 thread _id_4B7A(var_0, var_2);
    var_5 thread _id_4B7B();
    var_5.allowdeath = 1;
    var_5._id_0EC6 = 1;
    var_0 maps\_anim::_id_11C1(var_5, var_2);

    if(isDefined(var_5) && isalive(var_5)) {
      var_5 maps\_utility::_id_1902();
      var_5 _id_4BF3();
    }
  } else {
    var_5.goalradius = 8;
    var_5 maps\_utility::_id_0D04();
    var_5 thread _id_4B7B();
    var_5.allowdeath = 1;
    var_5._id_0EC6 = 1;
    var_5 maps\_utility::delaythread(3.5, maps\_utility::_id_1902);
    var_0 maps\_anim::_id_11C1(var_5, var_2);
  }
}

_id_4B7A(var_0, var_1) {
  self.ignoreme = 1;
  self endon("death");
  var_0 waittill(var_1);
  wait 1;
  self.ignoreme = 0;
}

_id_4B7B() {
  self waittill("death");
  level._id_4B76++;

  if(level._id_4B76 > 1) {
    common_scripts\utility::flag_set("hatch_enemies_dead");
  }
}

_id_4B7C() {
  var_0 = getent("hatch_component1", "targetname");
  var_1 = getent("hatch_component2", "targetname");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = getent("hatch_org", "targetname");
  var_2.origin = var_3.origin;
  var_2.angles = var_3.angles;

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 linkto(var_2, "tag_origin");
  }

  var_1 linkto(var_2, "tag_origin");
  common_scripts\utility::flag_set("vo_hatch_open");
  var_2 rotateto((154, 0, 180), 0.05);
}

_id_4B7D() {
  var_0 = getent("rear_hatch_col", "targetname");
  var_0 notsolid();
  common_scripts\utility::flag_wait("sub_control_room_sandman_exit");
  var_1 = getent("rear_hatch_component1", "targetname");
  var_2 = getent("rear_hatch_component2", "targetname");
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_4 = getent("rear_hatch_org", "targetname");
  var_3.origin = var_4.origin;
  var_3.angles = var_4.angles;

  if(isDefined(var_1)) {
    var_1 hide();
    var_1 linkto(var_3, "tag_origin");
  }

  var_2 linkto(var_3, "tag_origin");
  var_3 rotateto((150, var_3.angles[1], var_3.angles[2]), 0.05);
  var_0 solid();
  var_5 = getent("rear_hatch_col_interior", "targetname");
  var_5 notsolid();
  var_6 = getent("rear_hatch_col_top", "targetname");
  var_6 notsolid();
}

_id_4B7E() {
  thread _id_4B83();
  maps\_anim::_id_1264(level._id_45C0._id_1032, "show", ::_id_4B84, "ny_harbor_sandman_drops_frag_inhatch");

  if(!common_scripts\utility::flag_exist("hatch_enemies_dead")) {
    common_scripts\utility::flag_init("hatch_enemies_dead");
  }
  common_scripts\utility::flag_wait("hatch_enemies_dead");
  maps\_audio::aud_send_msg("aud_prime_sandman_grenade_anim");
  level._id_45C0 maps\_utility::_id_27B8();
  var_0 = common_scripts\utility::getstruct("hatch_sandman_drop_frag_anim_ent", "targetname");
  level._id_45C0 maps\_utility::_id_123B();
  var_0 maps\_anim::_id_124A(level._id_45C0, "ny_harbor_sandman_drops_frag_inhatch");
  maps\_audio::aud_send_msg("aud_start_sandman_grenade_anim");
  thread _id_4B87();
  maps\_utility::delaythread(11, ::_id_4B82, "ready_for_player_slide");
  maps\_utility::delaythread(3, ::_id_4B80);
  var_0 maps\_anim::_id_1246(level._id_45C0, "ny_harbor_sandman_drops_frag_inhatch");
  level._id_45C0 maps\_utility::_id_2688();
}

_id_4B7F() {
  self endon("disable_smart_laser");

  for(;;) {
    if(self._id_0F53 || self.a._id_0A98 == "cover" && (self.a._id_0D19 == "cover_left" || self.a._id_0D19 == "cover_right")) {
      self laserforceoff();
    } else {
      self laserforceon();
    }
    wait 0.05;
  }
}

_id_4B80() {
  level._id_4B81 delete();
}

_id_4B82(var_0) {
  common_scripts\utility::flag_set(var_0);
}

_id_4B83() {
  level._id_4B81 = getent("frag_grenade", "targetname");
  level._id_4B81 hide();
  var_0 = level._id_45C0 gettagorigin("tag_inhand");
  var_1 = level._id_45C0 gettagangles("tag_inhand");
  level._id_4B81.origin = var_0;
  level._id_4B81.angles = var_1;
  level._id_4B81 linkto(level._id_45C0, "tag_inhand");
}

_id_4B84(var_0) {
  level._id_4B81 show();
}

_id_4B85() {
  maps\_audio::aud_send_msg("aud_prime_player_downladder");
  var_0 = getent("hatch_player_slide", "targetname");
  var_0 sethintstring(&"NY_HARBOR_HINT_USE_TO_ENTER");
  var_0 usetriggerrequirelookat();
  var_0 waittill("trigger");
  var_0 common_scripts\utility::trigger_off();
  level.player disableweapons();
  level.player freezecontrols(1);
  maps\_shg_common::_id_1670();
  level._id_49C1 hide();
  common_scripts\utility::flag_set("hatch_player_using_ladder");
  maps\_audio::aud_send_msg("aud_player_downladder");
  var_1 = common_scripts\utility::getstruct("hatch_player_slide_anim_pos", "targetname");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  level.player playerlinktoblend(level._id_49C1, "tag_player", 0.2);
  level._id_49C1 dontcastshadows();
  level._id_49C1 common_scripts\utility::delaycall(0.3, ::show);
  level maps\_utility::delaythread(3.6, ::_id_4B86);
  var_2 maps\_anim::_id_1246(level._id_49C1, "player_ladder_slide");
  level._id_49C1 hide();
  level.player freezecontrols(0);
  level.player unlink();
  level.player enableweapons();
  maps\_shg_common::_id_1671();
  common_scripts\utility::flag_set("ladder_done");
  thread _id_4B48();
}

_id_4B86() {
  clearallcorpses();
}

_id_4B87() {
  wait 2;
  common_scripts\utility::flag_set("vo_frag_out");
  wait 5;
  common_scripts\utility::flag_set("vo_frag_out_clear");
}

_id_4B88(var_0) {
  if(!isDefined(var_0)) {
    common_scripts\utility::flag_wait("sub_breach_finished");
  }
  maps\_utility::_id_27CA("submarine_extra_friends", ::_id_4B89);
  maps\_utility::_id_27CA("submarine_extra_enemy", ::_id_4B8B);
  maps\_utility::_id_272C("submarine_extra_friends");
  maps\_utility::_id_272C("submarine_extra_enemy");
}

_id_4B89() {
  self endon("death");
  self._id_238A = 1;
  self._id_0EC6 = 1;
  self.grenadeammo = 0;
  maps\_utility::_id_0D04();
  maps\_utility::_id_0EEC();
  maps\_utility::_id_2714();
  self._id_1106 = 1;
  self._id_20AF = 10;
  self.accuracy = 1;

  if(isDefined(self._id_0AB5) && self._id_0AB5 == "Grinch") {
    level._id_4AE1 = self;
    level._id_4AE1._id_1032 = "sub_grinch";
  }

  if(isDefined(self._id_0AB5) && self._id_0AB5 == "Truck") {
    level._id_4AE0 = self;
    level._id_4AE0._id_1032 = "sub_truck";
  }

  thread _id_4B8A();

  if(isDefined(self._id_2982)) {
    self setCanDamage(0);
  }
  if(!common_scripts\utility::flag_exist("hatch_enemies_dead")) {
    common_scripts\utility::flag_init("hatch_enemies_dead");
  }
  common_scripts\utility::flag_wait("hatch_enemies_dead");
  self.ignoresuppression = 1;

  while(self._id_20AF < 50) {
    if(common_scripts\utility::flag("ladder_done")) {
      break;
    }

    self._id_20AF = self._id_20AF + 1;
    wait 0.5;
  }

  common_scripts\utility::flag_wait("ladder_done");

  if(isDefined(self._id_0D04)) {
    maps\_utility::_id_1902();
  }
  self delete();
}

_id_4B8A() {
  self endon("death");
  level waittill("sub_exterior_chopper_spawned", var_0);
  wait 8;
  maps\_utility::_id_1902();
  self setentitytarget(var_0);
}

_id_4B8B() {
  self endon("death");
  self.script_noteworthy = undefined;
  self.health = 3;
  maps\_utility::_id_2714();
  var_0 = ["body_russian_naval_assault_g", "body_russian_naval_assault_gg", "body_russian_naval_assault_h"];
  self setModel(var_0[randomint(var_0.size)]);
  self._id_0EC6 = 1;
  common_scripts\utility::flag_wait("ladder_done");
  self delete();
}

_id_4B8C() {
  thread _id_4B8D();
  return 0;
}

_id_4B8D() {
  var_0 = 10;
  var_1 = (0, -90, 0);
  var_2 = 0.25;

  if(self._id_164F == "exposed_crouch_death_twist") {
    self orientmode("face angle", self.angles[1] - 90);
    var_1 = (0, 90, 0);
    var_0 = 30;
    var_2 = 0.15;
  }

  var_3 = getanimlength(self._id_0D50);
  wait(var_3 * var_2);
  var_4 = anglesToForward(self.angles + var_1);
  var_4 = var_4 * var_0;
  self startragdollfromimpact(self gettagorigin("j_spine4"), var_4);
  wait 0.05;
}

_id_4B8E() {
  thread _id_4B8F();
  thread _id_4B93();
  thread _id_4B9A();
  common_scripts\utility::flag_wait("trigger_barracks_entrance");
  thread _id_4B92();
}

_id_4B8F() {
  var_0 = getent("barracks_door_open_anim_ent", "targetname");
  var_1 = maps\_utility::_id_1287("door", var_0.origin);
  level._id_4AF1[level._id_4AF1.size] = var_1;
  var_2 = "open_with_wheel";
  var_0 maps\_anim::_id_11CF(var_1, var_2);
  common_scripts\utility::flag_wait("trigger_barracks_entrance");
  level._id_45C0 maps\_utility::_id_123B();
  level._id_45C0 _id_460E();
  level._id_45C0 notify("disable_smart_laser");
  level._id_45C0 laserforceoff();
  var_0 maps\_anim::_id_124A(level._id_45C0, var_2);
  var_3 = maps\_utility::_id_2766(level._id_45C0, var_1);
  maps\_audio::aud_send_msg("aud_open_bulkhead_door");
  common_scripts\utility::flag_set("barracks_sandman_opening_door");
  maps\_utility::delaythread(5, ::_id_4B91);
  var_0 maps\_anim::_id_11DD(var_3, var_2);
  level._id_45C0 maps\_utility::_id_2686();
  var_4 = getent("barracks_sandman_after_door_open", "targetname");
  var_4 notify("trigger");
  level._id_45C0 thread _id_4B90();
  maps\_utility::_id_265B("allies");
  maps\_utility::_id_265B("axis");
  wait 2;
  level._id_45C0 _id_460C();
}

_id_4B90() {
  var_0 = 0;

  for(var_1 = common_scripts\utility::getstruct("org_sandman_target", "targetname"); var_0 < 6; var_0++) {
    magicbullet("mp5_silencer_reflex_harbor", self getmuzzlepos(), var_1.origin);
    wait 0.05;
  }
}

_id_4B91() {
  var_0 = getent("barracks_open_door_col", "targetname");
  var_0 connectpaths();
  var_0 delete();
}

_id_4B92() {
  common_scripts\utility::flag_set("vo_sub_interior_1");
  wait 5;
  common_scripts\utility::flag_set("vo_go_downstairs");
}

_id_4B93() {
  thread _id_4B95();
  thread _id_4B97();
  thread _id_4B98();
}

_id_4B94() {
  common_scripts\utility::flag_wait("trigger_barracks_entrance");
  wait 12;
  var_0 = getent("barracks_spawn1", "targetname");
  var_1 = var_0 maps\_utility::_id_166F(1);
  var_1 _id_4BAB();
}

_id_4B95() {
  thread _id_4B96();
  common_scripts\utility::flag_wait("trigger_barracks_entrance");
  var_0 = getent("barracks_slam_door", "targetname");
  var_1 = var_0 maps\_utility::_id_166F(1);
  maps\_utility::_id_13AF();
  var_1._id_1032 = "barracks_2";
  var_1 thread maps\_utility::_id_0D04();
  var_1._id_4B64 = 1;
  var_1 _id_460E();
  var_2 = common_scripts\utility::getstruct("barracks_slam_door_anim_pos", "targetname");
  var_3 = maps\_utility::_id_1287("door", var_2.origin);
  level._id_4AF1[level._id_4AF1.size] = var_3;
  var_4 = "slam_door";
  var_5 = maps\_utility::_id_2766(var_1, var_3);
  var_2 maps\_anim::_id_11BF(var_5, var_4);
  common_scripts\utility::flag_wait_or_timeout("barracks_slam_door", 20);
  common_scripts\utility::flag_set("barracks_slam_door");
  var_1 thread maps\_utility::_id_168C("nyharbor_ru2_behinddoor");
  maps\_utility::delaythread(0.05, maps\_anim::_id_127C, var_5, var_4, 1.5);
  var_2 maps\_anim::_id_11DD(var_5, var_4);
  var_1 maps\_utility::_id_1902();
  var_1 delete();
}

_id_4B96() {
  var_0 = getent("barracks_slam_door_col", "targetname");
  var_0 connectpaths();
  var_0 notsolid();
  common_scripts\utility::flag_wait("barracks_slam_door");
  var_0 disconnectpaths();
  var_0 solid();
}

_id_4B97() {
  common_scripts\utility::flag_wait("trigger_barracks_entrance");
  var_0 = getent("barracks_waver", "targetname");
  var_1 = var_0 maps\_utility::_id_166F(1);
  var_1.ignoreall = 1;
  var_1 thread maps\_utility::_id_0D04();
  var_2 = common_scripts\utility::getstruct("barracks_waver_anim_pos", "targetname");
  var_2 maps\_anim::_id_11C0(var_1, "launchfacility_b_blast_door_seq_waveidle");
  common_scripts\utility::flag_wait("barracks_sandman_opening_door");
  wait 4;
  var_1.allowdeath = 1;
  var_1 maps\_utility::_id_1902();
  var_1.ignoreall = 0;
  var_2 maps\_anim::_id_11C1(var_1, "launchfacility_b_blast_door_seq_waveidle");
  var_1 _id_4BF2();
  var_1 thread _id_4B9C();
}

_id_4B98() {
  common_scripts\utility::flag_wait("barracks_sandman_opening_door");
  thread _id_03C3::_id_4AA7();
  wait 7.5;
  var_0 = getent("barracks_run_and_stumble", "targetname");
  var_1 = var_0 maps\_utility::_id_166F(1);
  maps\_utility::_id_13AF();
  var_1._id_1032 = "barracks_1";
  var_1 thread maps\_utility::_id_168C("nyharbor_ru1_americans");
  var_1 thread _id_4B99();
  var_1 thread _id_4B9C();
}

_id_4B99() {
  self endon("death");
  self.ignoreall = 1;
  self waittill("goal");
  self.ignoreall = 0;
}

_id_4B9A() {
  level endon("sandman_paired_kill");
  var_0 = common_scripts\utility::getstruct("barracks_sandman_exit_anim_pos", "targetname");
  var_1 = common_scripts\utility::getstruct("barracks_sandman_exit_anim_pos_guy", "targetname");
  var_2 = maps\_utility::_id_1287("door", var_0.origin);
  level._id_4AF1[level._id_4AF1.size] = var_2;
  var_3 = "barracks_sandman_exit";
  var_0 maps\_anim::_id_11CF(var_2, var_3);
  common_scripts\utility::flag_wait("barracks_sandman_opening_door");
  wait 20;
  level._id_45C0 maps\_utility::_id_123B();
  var_0 maps\_anim::_id_124A(level._id_45C0, var_3);
  var_4 = maps\_utility::_id_2766(level._id_45C0, var_2);
  var_0 thread maps\_anim::_id_1246(var_2, "barracks_sandman_exit");
  var_1 maps\_anim::_id_1246(level._id_45C0, "barracks_sandman_exit");
  thread _id_4B9B(var_1);
}

_id_4B9B(var_0) {
  var_0 thread maps\_anim::_id_124E(level._id_45C0, "barracks_sandman_exit_idle", "end_loop");
  common_scripts\utility::flag_set("barracks_exit_nag_vo");
  common_scripts\utility::flag_wait_either("sandman_paired_kill", "barracks_move_sandman");
  var_0 notify("end_loop");

  if(common_scripts\utility::flag("barracks_move_sandman")) {
    level._id_45C0 maps\_utility::_id_1414();
    var_1 = getent("sandman_barracks_teleport", "targetname");
    level._id_45C0 maps\_utility::_id_279F(var_1);
    level._id_45C0 maps\_utility::_id_1237(level._id_45C0.origin);
  }
}

_id_4B9C() {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.target)) {
    var_0 = getnode(self.target, "targetname");
    self setgoalpos(var_0.origin);
    waittillframeend;
    self.goalradius = 64;
  }
}

_id_4B9D() {
  maps\_utility::_id_27CB("reactor_room_runner", ::_id_4BAB);
  thread _id_4BA0();
  thread _id_4B9E();
  thread _id_4B9F();
  thread _id_4BAC();
}

_id_4B9E() {
  common_scripts\utility::flag_wait("reactor_room_vfx_steam_start");
  common_scripts\utility::exploder(258);
  earthquake(0.3, 1.7, level.player.origin, 1024);
}

_id_4B9F() {
  common_scripts\utility::flag_wait("ladder_done");
  var_0 = getEntArray("sub_water_sheeting_vol", "targetname");
  var_1 = 0;

  while(!common_scripts\utility::flag("start_zodiac")) {
    if(_id_4BEF(var_0)) {
      if(var_1 == 0) {
        level.player setwatersheeting(1);
        var_1 = 1;
      }

      wait 0.05;
      continue;
    }

    if(var_1 == 1) {
      level.player setwatersheeting(1, 0.5);
      var_1 = 0;
      wait 0.05;
      continue;
    }

    wait 0.05;
  }
}

_id_4BA0() {
  level endon("sandman_paired_kill_interrupted");
  maps\_anim::_id_1264(level._id_45C0._id_1032, "HEADSMASH", ::_id_4BAA, "ny_harbor_doorway_headsmash");
  common_scripts\utility::flag_wait("sandman_paired_kill");
  thread _id_4B4A();
  var_0 = common_scripts\utility::getstruct("reactor_room_sandman_paired_kill_anim_pos", "targetname");
  var_1 = getent("reactor_room_sandman_paired_killed_enemy", "targetname");
  var_2 = var_1 maps\_utility::_id_166F(1);
  maps\_utility::_id_13AF();
  var_2._id_1032 = "generic";
  var_2.ignoreall = 1;
  var_2.ignoreme = 1;
  var_2.allowdeath = 1;
  var_2.health = 999999;
  var_2 thread _id_4BA1();
  var_3 = maps\_utility::_id_2766(var_2, level._id_45C0);
  level._id_45C0 notify("disable_smart_laser");
  level._id_45C0 laserforceoff();
  maps\_audio::aud_send_msg("aud_sub_sandman_pairedkill_headsmash");
  var_0 thread maps\_anim::_id_11DD(var_3, "ny_harbor_doorway_headsmash");
  wait 5.5;
  var_2 thread _id_4BF0(var_0, "ny_harbor_doorway_headsmash_enemy_deadpose");
  level._id_45C0 maps\_utility::_id_2686();
  var_4 = getent("reactor_room_sandman_color_after_paired", "targetname");
  var_4 notify("trigger");
  common_scripts\utility::flag_set("sandman_paired_kill_complete");
  level notify("sandman_paired_kill_finished");
  thread _id_4BA6(5);
  level._id_45C0 waittillmatch("single anim", "end");
  var_0 maps\_anim::_id_1246(level._id_45C0, "ny_harbor_doorway_headsmash_no_gun_flip");
  level._id_45C0 setanim(level._id_0C59[level._id_45C0._id_1032]["ny_harbor_doorway_headsmash"], 0, 0);
  level._id_45C0 setanim(level._id_0C59[level._id_45C0._id_1032]["ny_harbor_doorway_headsmash_no_gun_flip"], 1, 0);

  if(getdvarint("demo_itiot") == 1) {
    thread _id_4BA4();
  }
}

_id_4BA1() {
  while(!common_scripts\utility::flag("sandman_paired_kill_complete")) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_3) && isDefined(var_4)) {
      if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET") {
        playFX(common_scripts\utility::getfx("flesh_hit"), var_3);
      }
    }

    wait 0.5;
  }
}

_id_4BA2() {
  level endon("sandman_paired_kill_finished");
  self waittill("damage");
  maps\_utility::_id_1414();
  self kill();
  level notify("sandman_paired_kill_interrupted");
}

_id_4BA3() {
  level endon("sandman_paired_kill_finished");
  level waittill("sandman_paired_kill_interrupted");
  maps\_utility::_id_1414();
  level._id_45C0 maps\_utility::_id_2686();
  var_0 = getent("reactor_room_sandman_color_after_paired", "targetname");
  var_0 notify("trigger");
  common_scripts\utility::flag_set("sandman_paired_kill_complete");
  level thread _id_4BA6(7);

  if(getdvarint("demo_itiot") == 1) {
    thread _id_4BA4();
  }
}

_id_4BA4() {
  common_scripts\utility::flag_wait("e3_guy_killed");
  wait 1;
  level.player freezecontrols(1);
  thread maps\_utility::_id_265A("allies");
  thread maps\_utility::_id_265A("axis");
  maps\_audio::aud_send_msg("e3_demo_fade_out", 1);
  thread _id_46B8("black", 5, 1, 1);
  var_0 = [];
  var_0[0] = &"NY_HARBOR_DEMO_1";
  thread _id_46B9(var_0, 1);
  maps\_utility::delaythread(1, ::_id_4BA9);
  wait 3;
  _id_4BA5();
}

_id_4BA5() {
  level.player freezecontrols(0);
  level.player setstance("stand");
  thread _id_4B49();
  maps\_audio::aud_send_msg("e3_demo_fade_in", 1);
  maps\_audio::aud_send_msg("start_bridge_breach");
  thread _id_4B68();
  thread _id_4B69();
  thread _id_4B7D();
  var_0 = common_scripts\utility::getstruct("start_breach_player_loc", "targetname");
  level.player maps\_utility::_id_1FDF(var_0);
  thread _id_4BED();
  common_scripts\utility::flag_set("obj_plantmine_given");
  common_scripts\utility::flag_set("obj_plantmine_complete");
  common_scripts\utility::flag_set("obj_capturesub_given");
  common_scripts\utility::flag_set("player_surfaces");
  common_scripts\utility::flag_set("ready_for_player_slide");
  common_scripts\utility::flag_set("hatch_player_using_ladder");
  common_scripts\utility::flag_set("sub_objective_breach");
  maps\_utility::_id_2797(75);
  _id_4B63();
  var_1 = common_scripts\utility::getstruct("start_breach_sandman_loc", "targetname");
  level._id_45C0 forceteleport(var_1.origin, var_1.angles);
  thread _id_4B4D();
  maps\_utility::vision_set_fog_changes("ny_harbor_sub_4", 0);
  setsaveddvar("sm_sunenable", 0);
  setsaveddvar("sm_spotlimit", 2);
  thread _id_4B66();
}

_id_4BA6(var_0) {
  common_scripts\utility::flag_init("vo_extinguisher");
  var_1 = getent("extinguisher_guy", "targetname");
  var_2 = common_scripts\utility::getstruct("org_fire_extinguisher", "targetname");
  var_3 = var_1 maps\_utility::_id_166F();

  if(isDefined(var_3)) {
    var_3._id_1032 = "guy";
    var_3.allowdeath = 1;
    var_3 maps\_utility::_id_24F5();
    var_3 thread _id_4BA8(var_0);
    var_4 = maps\_utility::_id_1287("extinguisher");
    var_4._id_1032 = "extinguisher";
    var_5 = [];
    var_5[0] = var_3;
    var_5[1] = var_4;
    var_3 thread _id_4BA7(var_2, var_4);
    var_3 thread _id_03C3::_id_4A3F(var_4);
    common_scripts\utility::flag_set("vo_extinguisher");
    var_2 maps\_anim::_id_11D6(var_5, "extinguisher_loop", "stop_loop");
  }
}

_id_4BA7(var_0, var_1) {
  self waittill("death");
  var_0 notify("stop_loop");
  var_1 maps\_utility::_id_1414();
  var_1 physicslaunchclient(var_1.origin, (0, 0, 0));
}

_id_4BA8(var_0) {
  self endon("death");
  self.ignoreme = 1;
  wait(var_0);
  self.ignoreme = 0;
  level._id_45C0.favoriteenemy = self;
}

_id_4BA9() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {}
  var_2 delete();
}

_id_4BAA(var_0) {
  thread _id_03C3::_id_4AA8();
}

_id_4BAB() {
  self endon("death");
  maps\_utility::_id_260D();
  self._id_4B64 = 1;
  _id_460E();
  maps\_utility::_id_109E();
  self.grenadeammo = 0;
  self notify("retreat");

  if(isDefined(self._id_164F)) {
    thread _id_00AD();
  }
  common_scripts\utility::waittill_either("goal", "damage");
  _id_460C();
  maps\_utility::_id_109B();
}

_id_4BAC() {
  common_scripts\utility::flag_wait("reactor_room_announcement");
  wait 1.0;
  wait 0.3;
  common_scripts\utility::exploder(259);
  maps\_audio::aud_send_msg("aud_premissileroom_pipeburst");
  var_0 = getent("pipe_valve", "script_noteworthy");
  var_0 hide();
}

_id_4BAD() {
  maps\_utility::_id_27CB("missile_room_runner", ::_id_4BAB);
}

_id_4BAE() {
  thread maps\ny_harbor_code_vo::_id_4AEC();
}

_id_4BAF() {
  common_scripts\utility::flag_init("breaching_on");
  thread _id_4613();
  thread _id_4BAE();
  level._id_4BB0 = [];
  level._id_4BB1 = 0;
  level._id_4BB2 = 0;
  var_0 = getent("mil_frame_charge", "targetname");
  var_0 hide();
  var_1 = getent("bridge_breach_loc", "targetname");
  level._id_4BB3 = maps\_utility::_id_1287("breach_door", var_1.origin);
  level._id_4BB3._id_1032 = "breach_door";
  level._id_4BB3 maps\_anim::_id_1244();
  var_1 maps\_anim::_id_11CF(level._id_4BB3, "ny_harbor_door_breach");
  var_2 = getent("detonator_1", "targetname");
  var_2 hide();
  var_3 = getent("detonator_2", "targetname");
  var_3 hide();
  var_4 = getent("spawner_ambient_mis2_group2", "targetname");
  common_scripts\utility::flag_wait("sub_breach_sandman_to_postion");
  var_5 = getaiarray("axis");
  var_6 = getdvarint("cg_fov");
  var_7 = cos(var_6);
  common_scripts\utility::array_thread(var_5, ::_id_4BB6, var_7);
  maps\_audio::aud_send_msg("bridge_breach_setup");
  common_scripts\utility::flag_set("vo_wait_at_door");
  level._id_45C0 maps\_utility::_id_109E();
  level._id_45C0 notify("disable_smart_laser");
  level._id_45C0 laserforceoff();
  level._id_45C0 maps\_utility::_id_123B();
  var_8 = common_scripts\utility::getstruct("bridge_breach_sandman_idle", "targetname");
  var_1 maps\_anim::_id_124A(level._id_45C0, "ny_harbor_door_breach_idle_trans");
  var_1 maps\_anim::_id_1246(level._id_45C0, "ny_harbor_door_breach_idle_trans");
  var_1 thread maps\_anim::_id_124E(level._id_45C0, "ny_harbor_door_breach_idle", "end_idle");
  level._id_45C0 setlookatentity(level.player);
  common_scripts\utility::flag_wait("ready_for_breach");
  common_scripts\utility::flag_set("vo_breach");
  var_9 = getent("bridge_breach_trigger", "targetname");
  var_9 usetriggerrequirelookat();
  var_9 sethintstring(&"NY_HARBOR_HINT_USE_TO_BREACH");
  var_9 waittill("trigger");
  maps\_audio::aud_send_msg("player_trigger_sub_door_breach");
  var_9 delete();
  level._id_49C1 hide();
  common_scripts\utility::flag_set("breach_started");
  var_10 = getent("breach_door_col", "targetname");
  level._id_4BB4 = maps\_utility::_id_1287("breach_charge1", var_1.origin);
  level._id_4BB4._id_1032 = "breach_charge1";
  level._id_4BB4 hide();
  level._id_4BB5 = maps\_utility::_id_1287("breach_charge2", var_1.origin);
  level._id_4BB5._id_1032 = "breach_charge2";
  level._id_4BB5 hide();
  level.player disableoffhandweapons();
  level.player freezecontrols(1);
  maps\_shg_common::_id_1670();
  thread maps\_utility::_id_265A("allies");
  thread maps\_utility::_id_265A("axis");
  level.player disableweapons();
  level.player waittill("weapon_change");
  thread _id_4BB8();
  var_10 connectpaths();
  var_10 delete();
  var_1 maps\_anim::_id_11CF(level._id_49C1, "ny_harbor_door_breach");
  level.player playerlinktoblend(level._id_49C1, "tag_player", 0.2);
  wait 0.2;
  var_0 show();
  var_2 show();
  var_3 show();
  var_0._id_1032 = "door_charge";
  var_0 maps\_anim::_id_1244();
  var_2._id_1032 = "breach_detonator1";
  var_2 maps\_anim::_id_1244();
  var_3._id_1032 = "breach_detonator2";
  var_3 maps\_anim::_id_1244();
  var_11 = getent("bridge_breach_guy1", "targetname");
  var_12 = var_11 maps\_utility::_id_166F(1);
  var_12 maps\_utility::_id_24F5();
  var_12 = maps\_vehicle_aianim::_id_25C1(var_12);
  var_12 notsolid();
  var_12._id_1032 = "generic";
  common_scripts\utility::flag_set("start_bridge_breach");
  var_1 notify("end_idle");
  var_5 = [level._id_45C0, var_0, level._id_4BB3, var_2, var_3, level._id_49C1, var_12, level._id_4BB4, level._id_4BB5];
  level._id_49C1 common_scripts\utility::delaycall(0.1, ::show);
  var_1 maps\_anim::_id_11DD(var_5, "ny_harbor_door_breach");
  level.player thread _id_4BBD();
  common_scripts\utility::flag_wait("door_blown");
  maps\_audio::aud_send_msg("bridge_breach");
  level._id_49C1 hide();
  level.player enableweapons();
  level.player freezecontrols(0);
  wait 1;
  level.player unlink();
  thread _id_4BB7();
  common_scripts\utility::flag_wait("breach_done");
  thread _id_4BB9();
}

_id_4BB6(var_0) {
  self endon("death");
  var_1 = getent("vol_breach_enemies_retreat", "targetname");
  self._id_4B64 = 1;
  maps\_utility::_id_109E();
  self setgoalvolumeauto(var_1);

  while(maps\_utility::_id_26AD(self.origin, var_0)) {
    wait(randomfloatrange(0.05, 0.3));
  }
  self delete();
}

_id_4BB7() {
  level._id_45C0 maps\_utility::_id_2686();
  var_0 = getent("breach_sandman_enter_room", "targetname");
  var_0 notify("trigger");
}

_id_4BB8() {
  level.player enableinvulnerability();
  level.player disableweaponswitch();
  level.player disableoffhandweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  _id_03C3::_id_4AA9();
  _id_03C3::_id_4AAB();
  _id_03C3::_id_4AAA();
}

_id_4BB9() {
  level.player disableinvulnerability();
  level.player enableweaponswitch();
  level.player enableoffhandweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player allowjump(1);
}

_id_4BBA(var_0) {
  common_scripts\utility::flag_set("door_blown");
  level._id_4BB3 setModel("ny_harbor_sub_pressuredoor_bridge_destroyed");
  var_1 = level._id_4BB3 gettagorigin("hinge");
  var_2 = level._id_4BB3 gettagangles("hinge");
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);
  var_5 = anglestoup(var_2);
  var_6 = (-28, -8, -12);
  var_1 = var_1 + var_3 * var_6[0] + var_4 * var_6[1] + var_5 * var_6[2];
  level._id_4BBB = spawn("script_model", var_1);
  level._id_4BBB setModel("ny_harbor_sub_pressuredoor_bridge_destroyed_door");
  level._id_4BBB.angles = var_2;
  level._id_4BBB linkto(level._id_4BB3, "hinge");
  level._id_4BB3 hidepart("hinge");
  level._id_4BB3 hidepart("handle");
  var_7 = getent("detonator_1", "targetname");
  var_7 delete();
  var_8 = getent("detonator_2", "targetname");
  var_8 delete();
  var_9 = getent("mil_frame_charge", "targetname");
  var_9 delete();
  level._id_4BB4 delete();
  level._id_4BB5 delete();
  thread _id_03C3::_id_4AAC();
  thread _id_4BDE();
  thread _id_4BE0();
  thread _id_4BE2();
  thread _id_4BE3();
}

_id_4BBC(var_0) {
  thread _id_4BC3();
}

_id_4BBD(var_0) {
  var_0 = self getcurrentweapon();

  if(_id_4BBE()) {
    var_1 = weaponclipsize(var_0);

    if(self getweaponammoclip(var_0) < var_1) {
      self setweaponammoclip(var_0, var_1);
    }
  }
}

_id_4BBE() {
  if(level.gameskill > 1) {
    return 0;
  }
  return 1;
}

_id_4BBF(var_0) {
  level._id_4BB4 show();
}

_id_4BC0(var_0) {}

_id_4BC1(var_0) {
  level._id_4BB5 show();
}

_id_4BC2(var_0) {}

_id_4BC3(var_0) {
  maps\_audio::aud_send_msg("door_breach_slowmo_start");
  level._id_4BC4 = 3.5;
  var_1 = 0.5;
  var_2 = 0.75;
  var_3 = 0.2;

  if(isDefined(level._id_402B) && level._id_402B == 1) {
    return;
  }
  level._id_402B = 1;
  common_scripts\utility::flag_set("breaching_on");
  level notify("slowmo_go");
  level endon("slowmo_go");

  if(isDefined(level._id_4BC5)) {
    var_3 = level._id_4BC5;
  }
  var_4 = level.player;
  var_4 thread maps\_utility::play_sound_on_entity("slomo_whoosh");
  var_4 thread _id_4BCB();
  common_scripts\utility::flag_clear("can_save");
  var_4 allowmelee(0);
  maps\_utility::_id_2772(0.25);
  maps\_utility::_id_2774(var_1);
  maps\_utility::_id_2775();
  var_4 setmovespeedscale(var_3);
  var_5 = gettime();
  var_6 = var_5 + level._id_4BC4 * 1000;
  var_4 thread _id_4BCC();
  var_4 thread _id_4BCD();
  var_7 = 500;
  var_8 = 1000;

  for(;;) {
    if(isDefined(level._id_4BC6)) {
      if(!level._id_4BC6) {
        if(isDefined(level._id_4BC7)) {
          var_2 = level._id_4BC7;
        }
        break;
      }

      wait 0.05;
      continue;
    }

    if(gettime() >= var_6) {
      break;
    }

    if(level._id_4BB1 <= 0) {
      var_2 = 1.15;
      break;
    }

    if(!maps\_utility::_id_12C1()) {
      if(var_4._id_23B4 >= var_5 + var_7) {
        break;
      }

      if(var_4._id_4BC8 && gettime() - var_5 > var_8) {
        break;
      }
    }

    if(maps\_utility::_id_0A36() && common_scripts\utility::flag("special_op_terminated")) {
      break;
    }

    if(var_4._id_4BC9) {
      var_2 = 0.5;
      break;
    }

    wait 0.05;
  }

  level notify("slowmo_breach_ending", var_2);
  level notify("stop_player_heartbeat");
  var_4 thread maps\_utility::play_sound_on_entity("slomo_whoosh");
  maps\_utility::_id_0A16(var_2);
  maps\_utility::_id_0A17();
  var_4 allowmelee(1);
  maps\_utility::_id_0A18();
  maps\_audio::aud_send_msg("door_breach_slowmo_end");
  common_scripts\utility::flag_set("can_save");
  level._id_4BCA = undefined;
  var_4 _id_4BCE();
  level notify("slomo_breach_over");
  level._id_402B = 0;
  common_scripts\utility::flag_clear("breaching_on");
  common_scripts\utility::flag_set("breach_done");
  setsaveddvar("objectiveHide", 0);
}

_id_4BCB() {
  level endon("stop_player_heartbeat");

  for(;;) {
    self playlocalsound("breathing_heartbeat");
    wait 0.5;
  }
}

_id_4BCC() {
  level endon("slowmo_breach_ending");
  self._id_4BC8 = 0;
  common_scripts\utility::waittill_any("weapon_switch_started", "night_vision_on", "night_vision_off");
  self._id_4BC8 = 1;
}

_id_4BCD() {
  level endon("slowmo_breach_ending");
  self._id_4BC9 = 0;
  level waittill("mission failed");
  self._id_4BC9 = 1;
}

_id_4BCE() {
  if(isDefined(level._id_4BCF)) {
    self setmovespeedscale(level._id_4BCF);
  } else {
    self setmovespeedscale(1);
  }
}

_id_4BD0(var_0, var_1) {
  level._id_4BB1++;
  var_2 = spawnStruct();
  var_2.enemy = var_0;
  var_2 thread _id_4BD2(var_0);
  var_2 thread _id_4BD3(var_0);
  var_2 thread _id_4BD4(var_0);
  var_2 thread _id_4BD5();

  if(isDefined(var_1)) {
    var_2 thread _id_4BD1(var_0);
  }
  var_2 waittill("breach_status_change", var_3);
  level._id_4BB1--;
  var_2 = undefined;
}

_id_4BD1(var_0) {
  self endon("breach_status_change");
  var_0 waittill("damage");
  self notify("breach_status_change", "death");
}

_id_4BD2(var_0) {
  self endon("breach_status_change");
  var_0 waittill("death");
  self notify("breach_status_change", "death");
}

_id_4BD3(var_0) {
  level._id_4BB2++;
  var_0 waittill("death");
  level._id_4BB2--;

  if(level._id_4BB2 <= 0) {
    common_scripts\utility::flag_set("bridge_breach_all_enemies_dead");
  }
  level notify("breach_all_enemies_dead");
}

_id_4BD4(var_0) {
  self endon("breach_status_change");

  while(isalive(var_0)) {
    wait 0.05;
  }
  self notify("breach_status_change", "exception");
}

_id_4BD5() {
  self endon("breach_status_change");
  level waittill("slowmo_breach_ending");
  self notify("breach_status_change", "breach_ending");
}

_id_4BD6() {
  while(!common_scripts\utility::flag("bridge_breach_all_enemies_dead")) {
    wait 0.05;
  }
}

_id_4BD7() {
  common_scripts\utility::flag_wait("bridge_breach_all_enemies_dead");
  common_scripts\utility::flag_wait("start_end_scene");
  var_0 = getent("bridge_breach_loc", "targetname");
  var_0 maps\_anim::_id_11C4(level._id_45C0, "ny_harbor_paried_takedown_sandman_start");
  common_scripts\utility::flag_set("vo_sub_interior_6");
  var_0 maps\_anim::_id_11C1(level._id_45C0, "ny_harbor_paried_takedown_sandman_start");
  maps\_audio::aud_send_msg("aud_start_sandman_takes_key");
  level._id_4BD8._id_1032 = "generic";
  var_1 = [level._id_45C0, level._id_4BD8];
  var_0 thread maps\_anim::_id_1246(level._id_4BD8, "ny_harbor_captain_search_flip_over");
  var_0 maps\_anim::_id_1246(level._id_45C0, "ny_harbor_captain_search_flip_over");
  var_0 maps\_anim::_id_1246(level._id_45C0, "ny_harbor_captain_search_flip_over_b");
  level notify("start_missilekey");
  var_0 maps\_anim::_id_1246(level._id_45C0, "ny_harbor_captain_search_flip_over_c");
  level._id_4BD8 = undefined;
  common_scripts\utility::flag_set("sub_control_room_key_scene_ready");
}

_id_4BD9() {
  level.player endon("death");
  var_0 = getent("bridge_breach_loc", "targetname");
  var_1 = maps\_utility::_id_1287("missile_key_panel");
  level._id_4AB3 = var_1;
  var_0 maps\_anim::_id_11CF(level._id_4AB3, "sub_turn_key");
  level._id_4AB3 showpart("tag_lighton");
  var_2 = maps\_utility::_id_1287("missile_key_panel_box");
  level._id_4AB1 = var_2;
  var_0 maps\_anim::_id_11CF(level._id_4AB1, "sub_turn_key");
  level._id_4AB1 hidepart("tag_lighton");
  common_scripts\utility::flag_wait("sub_control_room_key_scene_ready");
  var_0 thread maps\_anim::_id_11C8(level._id_45C0, "sub_turn_key_idle", "stop_loop");
  maps\_audio::aud_send_msg("aud_prime_missilekeytoss");
  common_scripts\utility::flag_wait("sub_control_room_player_to_controls");
  var_3 = getent("sub_control_key_panel_main", "targetname");
  var_3 maps\_utility::_id_27B0();
  var_1 maps\_utility::_id_27B0();
  var_2 _id_4BDB();
  var_4 = getent("sub_control_room_player_use", "targetname");
  var_4 usetriggerrequirelookat();
  var_4 sethintstring(&"NY_HARBOR_HINT_USE");
  var_4 waittill("trigger");
  var_4 delete();
  thread _id_4BDA();
  var_3 maps\_utility::_id_27B2();
  var_1 maps\_utility::_id_27B2();
  var_2 _id_4BDC();
  common_scripts\utility::flag_set("player_at_controls");
  common_scripts\utility::flag_set("vo_overlord_dialogue");
  level.player disableoffhandweapons();
  level.player freezecontrols(1);
  maps\_shg_common::_id_1670();
  level.player disableweapons();
  var_0 maps\_anim::_id_11CF(level._id_49C1, "sub_turn_key");
  var_5 = 0.3;
  level.player playerlinktoblend(level._id_49C1, "tag_player", var_5);
  wait(var_5);
  level._id_49C1 show();
  var_6 = maps\_utility::_id_1287("missile_key_player", var_0.origin);
  var_7 = maps\_utility::_id_1287("missile_key_sandman", var_0.origin);
  var_0 notify("stop_loop");
  var_8 = [level._id_49C1, level._id_45C0, var_7, var_6, var_2, var_1];
  thread maps\ny_harbor_code_vo::_id_4AEB(level._id_45C0);
  var_0 maps\_anim::_id_11DD(var_8, "sub_turn_key");
  var_0 thread maps\_anim::_id_1246(level._id_45C0, "sub_turn_key2");
  wait 3.83333;
  level._id_49C1 hide();
  maps\_shg_common::_id_1671();
  level.player enableweapons();
  level.player freezecontrols(0);
  level.player unlink();
  var_7 delete();
  var_6 delete();
  wait 1.73333;
  common_scripts\utility::flag_set("sub_control_room_sandman_exit");
  common_scripts\utility::flag_wait("vo_bridge_is_done");
  maps\_utility::_id_1425("control_room");
  common_scripts\utility::flag_wait("start_zodiac");
  level._id_4AB3 delete();
  level._id_4AB1 delete();
}

_id_4BDA() {
  level.player waittill("death");
  level._id_49C1 hide();
  maps\_shg_common::_id_1671();
  level.player enableweapons();
  level.player freezecontrols(0);
  level.player unlink();
}

_id_4BDB(var_0) {
  if(isDefined(self._id_27B1)) {
    return;
  }
  self._id_27B1 = self.model;

  if(!isDefined(var_0)) {
    var_0 = self.model + "_obj";
  }
  self setModel(var_0);
  self hidepart("tag_lighton");
}

_id_4BDC(var_0) {
  if(!isDefined(self._id_27B1)) {
    return;
  }
  self setModel(self._id_27B1);
  self hidepart("tag_lighton");
  self._id_27B1 = undefined;
}

_id_4BDD() {
  self notify("death_anim_complete");
}

_id_4BDE() {
  var_0 = getent("spawn_sub_captain", "targetname");
  level._id_4BD8 = var_0 maps\_utility::_id_166F(1);
  level._id_4BD8 maps\_utility::_id_24F5();
  thread _id_4BD0(level._id_4BD8, 1);
  level._id_4BD8.ignoreall = 1;
  level._id_4BD8 thread maps\_utility::_id_0D04();
  level._id_4BD8 thread _id_4BDF();
  var_1 = getent("bridge_breach_loc", "targetname");
  var_1 thread maps\_anim::_id_11C1(level._id_4BD8, "ny_harbor_paried_takedown_captain_start");
  level._id_4BD8 waittill("damage", var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_5) && isDefined(var_6)) {
    if(var_6 == "MOD_PISTOL_BULLET" || var_6 == "MOD_RIFLE_BULLET" || var_6 == "MOD_EXPLOSIVE_BULLET") {
      playFX(common_scripts\utility::getfx("headshot"), var_5);
    }
  }

  var_1 maps\_anim::_id_11C1(level._id_4BD8, "ny_harbor_paried_takedown_captain_die");
  level._id_4BD8 maps\_utility::_id_1902();
  level._id_4BD8 = level._id_4BD8 _id_4BF0(var_1, "ny_harbor_paried_takedown_captain_dead_1");
  maps\_audio::aud_send_msg("aud_prime_sandman_takes_key");
  common_scripts\utility::flag_set("start_end_scene");
}

_id_4BDF() {
  self endon("damage");
  wait 3;
  var_0 = level._id_45C0 gettagorigin("tag_inhand");
  magicbullet("mp5_silencer_reflex_harbor", var_0, self.origin + (0, 0, 32), level.player);
  wait 0.05;
  self dodamage(10, level._id_45C0.origin, level._id_45C0);
}

_id_4BE0() {
  var_0 = getent("breach_enemy_1", "targetname");
  var_1 = var_0 maps\_utility::_id_166F(1);
  var_1 thread _id_4BE7();
  var_2 = common_scripts\utility::getstruct("breach_enemy_loc1", "targetname");
  var_2 maps\_anim::_id_11C1(var_1, "breach_enemy_1");
}

_id_4BE1(var_0) {
  thread maps\_utility::_id_0D04();
  wait(var_0);
  thread maps\_utility::_id_1902();
}

_id_4BE2() {
  var_0 = getent("breach_enemy_2_1", "targetname");
  var_1 = var_0 maps\_utility::_id_166F(1);
  var_1 thread _id_4BE7();
  var_1._id_1032 = "breacher1";
  var_0 = getent("breach_enemy_2_2", "targetname");
  var_2 = var_0 maps\_utility::_id_166F(1);
  var_2 thread _id_4BE7();
  var_2._id_1032 = "breacher2";
  var_3 = maps\_utility::_id_2766(var_1, var_2);
  var_4 = common_scripts\utility::getstruct("breach_enemy_loc2", "targetname");
  var_4 maps\_anim::_id_11DD(var_3, "breach_enemy_2");
}

_id_4BE3() {
  var_0 = getent("breach_enemy_3", "targetname");
  var_1 = var_0 maps\_utility::_id_166F(1);
  var_1 thread _id_4BE4();
  var_1._id_1032 = "knife_guy";
  var_1 _id_4BE6();
  var_1 thread _id_4BE8();
  var_2 = [];
  var_2[0] = var_1;
  var_3 = common_scripts\utility::getstruct("breach_enemy_loc3", "targetname");
  maps\_utility::delaythread(0.05, maps\_anim::_id_127F, var_2, "breach_react_knife_charge", 0.12);
  var_3 maps\_anim::_id_1246(var_1, "breach_react_knife_charge");
}

_id_4BE4() {
  level.player endon("death");
  level._id_4BE5 = getent("weapon_knife", "targetname");
  var_0 = self gettagorigin("tag_inhand");
  var_1 = self gettagangles("tag_inhand");
  level._id_4BE5.origin = var_0;
  level._id_4BE5.angles = var_1;
  level._id_4BE5 linkto(self, "tag_inhand");
  self waittill("death");
  level._id_4BE5 unlink();
  level._id_4BE5 physicslaunchclient(level._id_4BE5.origin, (0, 0, 0));
}

_id_4BE6() {
  level thread _id_4BD0(self, 0);
  thread _id_4BEB();
  self.grenadeammo = 0;
  self.allowdeath = 1;
  self.health = 10;
  self._id_20AF = 5000;
}

_id_4BE7() {
  level thread _id_4BD0(self, 0);
  self.grenadeammo = 0;
  self.allowdeath = 1;
  self.health = 10;
  self._id_20AF = 5000;
}

_id_4BE8() {
  self endon("death");
  _id_4BEC();
  thread _id_4BE9();
  maps\_utility::_id_128B("breach_react_knife_charge_death");
  self waittillmatch("single anim", "stab");
  wait 0.1;
  thread _id_4BEA();
  self waittill("finished_breach_start_anim");
}

_id_4BE9() {
  self waittill("death");
  var_0 = self getattachsize();

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(self getattachmodelname(var_1) == "weapon_parabolic_knife") {
      self detach("weapon_parabolic_knife", "TAG_INHAND");
      break;
    }
  }
}

_id_4BEA() {
  var_0 = level.player;
  var_1 = distance(var_0.origin, self.origin);

  if(var_1 <= 50) {
    var_0 playrumbleonentity("grenade_rumble");
    var_0 thread maps\_utility::play_sound_on_entity("melee_knife_hit_body");
    var_0 disableinvulnerability();
    waittillframeend;
    var_0 dodamage(var_0.health + 50000, self gettagorigin("tag_weapon_right"), self);
    var_0._id_4BC9 = 1;
  }
}

_id_4BEB() {
  self endon("breach_enemy_cancel_ragdoll_death");
  self._id_0EC0 = 1;
  var_0 = common_scripts\utility::waittill_any_return("death", "finished_breach_start_anim");

  if(var_0 == "finished_breach_start_anim") {
    self._id_0EC0 = undefined;
  }
}

_id_4BEC() {
  self notify("breach_enemy_cancel_ragdoll_death");
  self._id_0EC0 = undefined;
}

_id_4BED() {
  common_scripts\utility::flag_wait("sub_control_room_sandman_exit");
  var_0 = common_scripts\utility::getstruct("sub_sandman_exit_jump", "targetname");
  var_0 maps\_anim::_id_11CF(level._id_45C0, "sub_exit_jump");
  level.player disableoffhandweapons();
  common_scripts\utility::flag_wait("sub_exit_player_going_out_hatch");
  var_0 maps\_anim::_id_1246(level._id_45C0, "sub_exit_jump");
  common_scripts\utility::flag_set("start_zodiac");
  clearallcorpses();
}

_id_4BEE() {
  common_scripts\utility::flag_wait("ladder_done");
  var_0 = getEntArray("sub_player_slow_vol", "targetname");
  var_1 = 0;

  while(!common_scripts\utility::flag("start_zodiac")) {
    if(_id_4BEF(var_0)) {
      if(var_1 == 0) {
        maps\_utility::_id_2797(50);
        level.player allowsprint(0);
        var_1 = 1;
      }

      wait 0.05;
      continue;
    }

    if(var_1 == 1) {
      maps\_utility::_id_2797(75);
      level.player allowsprint(1);
      var_1 = 0;
      wait 0.05;
      continue;
    }

    wait 0.05;
  }
}

_id_4BEF(var_0) {
  foreach(var_2 in var_0) {
    if(level.player istouching(var_2)) {
      return 1;
    }
    wait 0.05;
  }

  return 0;
}

_id_4BF0(var_0, var_1) {
  var_2 = maps\_vehicle_aianim::_id_25C1(self);
  var_2 startusingheroonlylighting();

  if(isarray(maps\_utility::_id_270F(var_1))) {
    var_1 = var_1 + "_nl";
  }
  var_0 maps\_anim::_id_11C0(var_2, var_1);
  var_2 notsolid();
  return var_2;
}

_id_4BF1() {
  self.allowdeath = 1;
  self._id_0EC0 = 1;
}

_id_4BF2() {
  if(isalive(self)) {
    self.allowdeath = 0;
    self._id_0EC0 = undefined;
  }
}

_id_4BF3() {
  if(!isalive(self)) {
    return;
  }
  self.allowdeath = 1;
  self.a._id_0D55 = 1;
  maps\_utility::_id_0D72(0);
  self kill();
}

_id_460E() {
  self._id_4B64 = 0;
  self.ignoreall = 1;
  self._id_100A = 1;
  self.ignoresuppression = 1;
  self._id_460D = self.suppressionwait;
  self.suppressionwait = 0;
  maps\_utility::_id_0EEC();
  self.ignorerandombulletdamage = 1;
  maps\_utility::_id_2714();
  maps\_utility::_id_1057();
  maps\_utility::_id_280D();
  self.grenadeawareness = 0;
  self.ignoreme = 1;
  maps\_utility::_id_27CC();
  self._id_1106 = 1;
}

_id_4BF4() {
  return self._id_4B64;
}

_id_460C() {
  self._id_4B64 = 1;
  self.ignoreall = 0;
  self._id_100A = undefined;
  self.ignoresuppression = 0;
  self.suppressionwait = self._id_460D;
  self._id_460D = undefined;
  maps\_utility::_id_27B8();
  self.ignorerandombulletdamage = 0;
  maps\_utility::_id_2715();
  maps\_utility::_id_1071();
  maps\_utility::_id_2178(3);
  self.grenadeawareness = 1;
  self.ignoreme = 0;
  maps\_utility::_id_27CD();
  self._id_1106 = undefined;
}

_id_4BF5() {
  var_0 = getEntArray("dyn_water_sub", "script_noteworthy");
  var_1 = getEntArray("dyn_water_breachpatch_low", "script_noteworthy");
  var_2 = getEntArray("water_flyout_off", "script_noteworthy");
  common_scripts\utility::flag_wait("ladder_done");
  _id_4B0F(var_0, 1);
  _id_4B0F(var_1, 1);
  _id_4B0F(var_2, 1);
  common_scripts\utility::flag_wait("sub_exit_player_going_out_hatch");
  _id_4B0F(var_0, 0);
  _id_4B0F(var_1, 0);
  _id_4B0F(var_2, 0);
}

_id_4613() {
  level endon("get_on_zodiac");
  common_scripts\utility::flag_wait("player_sub_backtrack");
  setDvar("ui_deadquote", "@NY_HARBOR_FAIL_SUB_DECK_ZODIAC");
  maps\_utility::_id_1826();
}

_id_46B8(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1.5;
  }
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 0;
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.foreground = 1;
  var_4 setshader(var_0, 640, 480);

  if(isDefined(var_3) && var_3 > 0) {
    var_4.alpha = 0;
    var_4 fadeovertime(var_3);
    var_4.alpha = 1;
    wait(var_3);
  }

  wait(var_1);

  if(isDefined(var_2) && var_2 > 0) {
    var_4.alpha = 1;
    var_4 fadeovertime(var_2);
    var_4.alpha = 0;
    wait(var_2);
  }

  var_4 destroy();
}

_id_46B9(var_0, var_1) {
  var_2 = getarraykeys(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    var_5 = var_3 * var_1 + 1;
    maps\_utility::delaythread(var_5, ::_id_46BA, var_0[var_4], var_0.size - var_3 - 1, var_1, var_4);
  }
}

_id_46BA(var_0, var_1, var_2, var_3) {
  level notify("new_introscreen_element");
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 0;
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "center";
  var_4.vertalign = "middle_adjustable";
  var_4.sort = 1;
  var_4.foreground = 1;
  var_4 settext(var_0);
  var_4.alpha = 0;
  var_4 fadeovertime(0.2);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.fontscale = 2.4;
  var_4.color = (0.8, 1, 0.8);
  var_4.font = "objective";
  var_4.glowcolor = (0.3, 0.6, 0.3);
  var_4.glowalpha = 1;
  var_5 = int(var_2 * 1000 + 4000);
  var_4 setpulsefx(30, var_5, 700);
  thread maps\_introscreen::_id_1DA3(var_4);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isstring(var_3)) {
    return;
  }
  if(var_3 != "date") {
    return;
  }
}