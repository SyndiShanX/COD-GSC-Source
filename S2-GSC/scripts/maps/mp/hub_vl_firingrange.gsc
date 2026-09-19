/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\hub_vl_firingrange.gsc
**************************************************/

_id_51D0() {
  var_0 = spawnStruct();
  var_0._id_3E6C = _func_18E("firingrange_start", "targetname");
  var_0._id_0C3A = _id_3C36();
  var_0._id_0BDC = _id_3C30();
  var_0._id_9C7C = [];
  var_0._id_9C7D = [];
  var_0._id_0C3B = _id_3C37();
  var_0._id_0C39 = _id_3C34();
  var_0._id_0C38 = _id_3C33();
  var_0._id_0BDA = _id_3C2F();
  var_0._id_0C37 = _id_3C35();
  var_0._id_0BE1 = _id_3C32();
  var_0._id_0C3C = _id_3C31();
  var_0._id_0BD8 = _id_3C2E();
  var_0._id_1356 = common_scripts\utility::_id_46B5("audio_buzzer_org", "targetname");
  var_0._id_8F41 = [];
  var_0._id_5B57 = undefined;
  var_0._id_9812 = 32;
  var_0._id_981D = 256;
  var_0._id_76AF = 0;
  var_0._id_76AE = 0;
  var_0._id_7F1F = undefined;
  var_0._id_621E = undefined;
  var_0._id_621F = undefined;
  var_0._id_6095 = undefined;
  var_0._id_1DE2 = 0.55;
  var_0._id_1DE1 = 0;
  var_0._id_4839 = 24;
  var_0._id_29BB = 0;
  var_0._id_7A64 = 0;
  var_0._id_8B3B = 0;
  var_0._id_8B3C = 0;
  var_0._id_6F48 = 0;
  var_0._id_8BB1 = 0;
  var_0._id_7F0E = 176;
  var_0.time = 0;
  var_0._id_4895 = 5;
  var_0._id_7F12 = 0;
  var_0._id_57CC = 0;
  var_0._id_A48D = loadfx("vfx/props/holo_target_red_spawn_in");
  var_0._id_A48E = loadfx("vfx/props/holo_target_red_spawn_out");
  var_0._id_A48C = loadfx("vfx/beam/firing_range_edge_glow");
  common_scripts\utility::_id_0FB2(var_0._id_0C3B, ::_id_9DAD);
  level._id_9804 = (1.3, 0, 25);
  level._id_9817 = 12;
  level._id_4DD0 = 18;
  level._id_3C3B = var_0;
}

_id_3C32() {
  var_0 = getEntArray("holo_emitter_floor", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_6A23 = var_2.origin;
    var_2._id_A08D = var_2.origin + (0, 0, 4);
  }

  return var_0;
}

_id_3C2E() {
  var_0 = getEntArray("display_3dui_mesh", "targetname");

  foreach(var_2 in var_0)
  var_2 _meth_805C();

  return var_0;
}

_id_3C34() {
  var_0 = common_scripts\utility::_id_46B7("target_track_min", "targetname");
  return var_0;
}

_id_3C33() {
  var_0 = common_scripts\utility::_id_46B7("target_track_max", "targetname");
  return var_0;
}

_id_3C2F() {
  var_0 = common_scripts\utility::_id_46B7("booth_display_01", "targetname");
  var_1 = common_scripts\utility::_id_46B7("booth_display_02", "targetname");
  var_2 = common_scripts\utility::_id_46B7("booth_display_03", "targetname");
  var_3 = common_scripts\utility::_id_46B7("booth_display_04", "targetname");
  var_4 = common_scripts\utility::_id_46B7("booth_display_05", "targetname");
  var_5 = common_scripts\utility::_id_46B7("booth_display_06", "targetname");
  var_6 = [var_0, var_1, var_2, var_3, var_4, var_5];
  return var_6;
}

_id_9DAD() {
  var_0 = self;
  var_0 thread _id_0478::_id_9DC3(::_id_726D, ::_id_72DD);
}

_id_726D(var_0) {
  level endon("shutdown_hologram");

  while(level._id_3C3B._id_57CC == 1)
    wait 0.1;

  var_1 = self;

  if(!isDefined(var_0._id_81E1)) {
    return;
  }
  var_2 = int(var_0._id_81E1);
  level._id_3C3B._id_7F1F = var_2;

  if(!isDefined(level._id_3C3B._id_0BDC[var_2])) {
    return;
  }
  var_1 thread _id_9301(var_2);
}

_id_72DD(var_0) {
  var_1 = self;

  if(!isDefined(var_0._id_81E1)) {
    return;
  }
  var_2 = int(var_0._id_81E1);
  level._id_3C3B._id_7F1F = var_2;

  if(!isDefined(level._id_3C3B._id_0BDC[var_2])) {
    return;
  }
  var_1 thread _id_72DE(var_2);
}

_id_72DE(var_0) {
  level endon("shutdown_hologram");
  var_1 = _func_18E("firing_range_round_trigger_end", "targetname");
  var_1 waittill("trigger");
  level._id_3C3B._id_54F5 = 0;
  thread _id_8C35(var_0, self);
}

_id_8DA3(var_0, var_1, var_2, var_3) {
  _id_046C::_id_8DA2(var_0, var_1, var_2, var_3);
}

_id_9838(var_0) {
  level endon("shutdown_hologram");
  var_1 = self;
  var_2 = level._id_3C3B._id_0C3A[var_0][0][0];
  var_2._id_0BC0 = 1;
  var_2 _id_90AA();
  var_2 _meth_805B();
  var_2 _meth_82C1();
  var_2 _meth_82C3(1);
  var_2 _meth_849F(1);
  var_2.damagecallback = ::_id_6378;
  var_2.health = 9999;
  var_2.maxhealth = 9999;

  foreach(var_4 in level._id_3C3B._id_0C39) {
    if(var_4._id_81E1 == level._id_3C3B._id_7F1F) {
      level._id_3C3B._id_621E = var_4;
      break;
    }
  }

  foreach(var_4 in level._id_3C3B._id_0C38) {
    if(var_4._id_81E1 == level._id_3C3B._id_7F1F) {
      level._id_3C3B._id_6095 = var_4;
      break;
    }
  }

  if(!isDefined(level._id_3C3B._id_621E) || !isDefined(level._id_3C3B._id_6095)) {
    thread _id_8C35(var_0, var_1);
    return;
  }

  level._id_3C3B._id_621F = level._id_3C3B._id_621E.origin + anglesToForward(level._id_3C3B._id_621E.angles) * -64;
  var_2 thread _id_637F(var_1, var_2, level._id_3C3B._id_621E);
  thread _id_63E2(var_1);
  thread _id_6399(var_1);
  thread _id_639C(var_1);
  thread _id_3004(var_1, var_0);
  var_1 thread _id_6814(var_2);
}

_id_637F(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");
  self endon("death");
  var_3 = 0.0254;

  for(;;) {
    if(!isDefined(var_1) || !isDefined(var_2)) {
      level._id_3C3B._id_7A64 = 0;
      var_0 _meth_82FF("ui_vlobby_round_distance", level._id_3C3B._id_7A64);
    } else {
      var_4 = _func_0E1(var_1.origin, var_2.origin);
      var_5 = int(common_scripts\utility::_id_7F03(var_3 * var_4, 0));

      if(var_5 != level._id_3C3B._id_7A64) {
        if(var_5 > 100)
          var_5 = 100;
        else if(var_5 < 0)
          var_5 = 0;

        level._id_3C3B._id_7A64 = var_5;
        var_0 _meth_82FF("ui_vlobby_round_distance", level._id_3C3B._id_7A64);
      }
    }

    waitframe();
  }
}

_id_6814(var_0) {
  self endon("disconnect");
  level endon("shutdown_hologram");
  self _meth_82E1("toggled_up_pressed", "+actionslot 1");
  self _meth_82E1("toggled_up_released", "-actionslot 1");
  self _meth_82E1("toggled_down_pressed", "+actionslot 2");
  self _meth_82E1("toggled_down_released", "-actionslot 2");
  thread _id_63F5(var_0);
  thread _id_63F6(var_0);
  thread _id_6383(var_0);
  thread _id_6384(var_0);
  thread _id_64CF(var_0, self);
}

_id_63F5(var_0) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    self waittill("toggled_up_pressed");
    level._id_3C3B._id_1DE1 = level._id_3C3B._id_1DE2;

    if(level._id_3C3B._id_76AF == 0) {
      level._id_3C3B._id_76AF = 1;
      level._id_3C3B._id_76AE = 0;
      thread _id_64AF(level._id_3C3B._id_6095.origin, var_0, self);
    }
  }
}

_id_63F6(var_0) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    self waittill("toggled_up_released");
    var_1 = _func_0E1(level._id_3C3B._id_6095.origin, var_0.origin);

    if(var_1 <= 1)
      var_0 _meth_82B1(var_0.origin, 0.05);
    else {
      var_2 = var_0.origin + anglesToForward(level._id_3C3B._id_0C38[0].angles) * level._id_3C3B._id_4839 * -1;
      var_1 = _func_0E1(var_2, var_0.origin);
      var_3 = var_1 / level._id_3C3B._id_981D;

      if(var_3 < 0.05)
        var_3 = 0.05;

      level._id_3C3B._id_1DE1 = var_3 + 0.05;
      thread _id_64AF(var_2, var_0, self);
    }

    var_0 waittill("movedone");
    level._id_3C3B._id_76AF = 0;
  }
}

_id_6383(var_0) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    self waittill("toggled_down_pressed");
    level._id_3C3B._id_1DE1 = level._id_3C3B._id_1DE2;

    if(level._id_3C3B._id_76AE == 0) {
      level._id_3C3B._id_76AE = 1;
      level._id_3C3B._id_76AF = 0;
      thread _id_64AF(level._id_3C3B._id_621F, var_0, self);
    }
  }
}

_id_6384(var_0) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    self waittill("toggled_down_released");
    var_1 = _func_0E1(level._id_3C3B._id_621F, var_0.origin);

    if(var_1 <= 1)
      var_0 _meth_82B1(var_0.origin, 0.05);
    else {
      var_2 = var_0.origin + anglesToForward(level._id_3C3B._id_0C38[0].angles) * level._id_3C3B._id_4839;
      var_1 = _func_0E1(var_2, var_0.origin);
      var_3 = var_1 / level._id_3C3B._id_981D;

      if(var_3 < 0.05)
        var_3 = 0.05;

      level._id_3C3B._id_1DE1 = var_3 + 0.05;
      thread _id_64AF(var_2, var_0, self);
    }

    var_0 waittill("movedone");
    level._id_3C3B._id_76AE = 0;
  }
}

_id_64AF(var_0, var_1, var_2) {
  var_3 = _func_0E1(var_0, var_1.origin);

  if(var_3 <= 1) {
    var_1 notify("movedone");
    return;
  } else {
    var_4 = var_3 / level._id_3C3B._id_981D;

    if(var_4 < 0.05)
      var_4 = 0.05;

    var_1 _meth_82B1(var_0, var_4);
  }
}

_id_64CF(var_0, var_1) {
  var_1 endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    waitframe();

    if(level._id_3C3B._id_76AE == 1 || level._id_3C3B._id_76AF == 1) {
      if(level._id_3C3B._id_1DE1 > 0) {
        level._id_3C3B._id_1DE1 = level._id_3C3B._id_1DE1 - 0.05;
        continue;
      }

      var_0 _meth_82B1(var_0.origin, 0.05);
      level._id_3C3B._id_76AE = 0;
      level._id_3C3B._id_76AF = 0;
    }
  }
}

_id_6377(var_0) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");
  var_1 = undefined;
  var_2 = var_0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(level._id_3C3B._id_7F1F == 7)
      self.health = self.maxhealth;

    var_11 = self gettagorigin("tag_chest");
    var_0 playlocalsound("mp_hit_default");
    var_12 = _id_4591(var_10, var_8, var_0);
    var_1 = common_scripts\utility::_id_7F03(_func_0AD(var_1) * var_12, 0);
    var_1 = int(var_1);

    if(var_1 > 999)
      var_1 = 999;

    if(var_1 < 0)
      var_1 = 0;

    level._id_3C3B._id_29BB = var_1;
    var_13 = level._id_3C3B._id_8B3C + 1;

    if(var_13 > 9999)
      level._id_3C3B._id_8B3C = 0;
    else if(var_13 < 0)
      level._id_3C3B._id_8B3C = 0;
    else
      level._id_3C3B._id_8B3C = var_13;

    level._id_3C3B._id_8BB1 = 1;
  }
}

_id_6378(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(self)) {
    return;
  }
  if(level._id_3C3B._id_7F1F == 7)
    self.health = self.maxhealth;

  var_12 = self gettagorigin("tag_chest");
  var_1 playlocalsound("mp_hit_default");
  var_13 = 1;

  if(isDefined(var_1))
    var_13 = _id_4591(var_5, var_11, var_1);

  var_2 = common_scripts\utility::_id_7F03(_func_0AD(var_2) * var_13, 0);
  var_2 = int(var_2);

  if(var_2 > 999)
    var_2 = 999;

  if(var_2 < 0)
    var_2 = 0;

  level._id_3C3B._id_29BB = var_2;

  if(isDefined(var_1)) {
    if(isDefined(var_0) && var_0 != var_1) {
      if(!isDefined(var_0._id_2995)) {
        var_0._id_2995 = 1;
        var_14 = level._id_3C3B._id_8B3C + 1;

        if(var_14 > 9999)
          level._id_3C3B._id_8B3C = 0;
        else if(var_14 < 0)
          level._id_3C3B._id_8B3C = 0;
        else
          level._id_3C3B._id_8B3C = var_14;

        level._id_3C3B._id_8BB1 = 1;
      }
    } else
      var_1 thread _id_268B();
  }

  level._id_3C3B._id_8BB1 = 1;
}

_id_268B() {
  level endon("shutdown_hologram");
  self endon("disconnect");

  if(!isDefined(self._id_29E2))
    self._id_29E2 = 1;
  else
    self._id_29E2++;
}

_id_4591(var_0, var_1, var_2) {
  var_3 = "none";
  var_4 = 1;
  var_5 = strtok(var_0, "_");
  var_6 = var_5[0];

  if(var_0 != "specialty_null" && var_0 != "none" && var_0 != "combatknife_mp") {
    if(maps\mp\gametypes\_class::isvalidprimary(var_6) || maps\mp\gametypes\_class::isvalidsecondary(var_6, 0)) {
      if(var_1 == "tag_head")
        var_3 = "head";
      else if(var_1 == "tag_chest")
        var_3 = "torso_upper";
      else if(var_1 == "tag_arms")
        var_3 = "right_arm_upper";
      else if(var_1 == "tag_legs")
        var_3 = "torso_lower";
      else
        var_3 = "none";

      var_4 = var_2 _meth_850B(var_6 + "_mp", var_3);
      return var_4;
    } else
      return var_4;
  } else
    return var_4;
}

_id_A6DE() {
  self endon("disconnect");
  self endon("reload");
  self endon("weapon_change");
  var_0 = 0;
  var_1 = self _meth_82F6("right");
  var_2 = self _meth_82F6("left");
  self waittill("weapon_fired");
  var_0 = 1;
  var_3 = self _meth_82F6("right");
  var_4 = self _meth_82F6("left");
  var_5 = var_1 - var_3 + (var_2 - var_4);

  if(var_5 > 0)
    var_0 = var_5;

  return var_0;
}

_id_63E2(var_0) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    var_0._id_29E2 = 0;
    var_1 = var_0 _id_A6DE();

    if(isDefined(var_1)) {
      var_2 = level._id_3C3B._id_8B3B + var_1;

      if(var_2 > 9999) {
        level._id_3C3B._id_8B3B = 0;
        level._id_3C3B._id_8B3C = 0;
        level._id_3C3B._id_6F48 = 0;
        var_0 _meth_82FF("ui_vlobby_round_hits", level._id_3C3B._id_8B3C);
        var_0 _meth_82FF("ui_vlobby_round_fired", level._id_3C3B._id_8B3B);
        var_0 _meth_82FF("ui_vlobby_round_accuracy", level._id_3C3B._id_6F48);
      } else if(var_2 < 0) {
        level._id_3C3B._id_8B3B = 0;
        level._id_3C3B._id_8B3C = 0;
        level._id_3C3B._id_6F48 = 0;
        var_0 _meth_82FF("ui_vlobby_round_hits", level._id_3C3B._id_8B3C);
        var_0 _meth_82FF("ui_vlobby_round_fired", level._id_3C3B._id_8B3B);
        var_0 _meth_82FF("ui_vlobby_round_accuracy", level._id_3C3B._id_6F48);
      } else {
        level._id_3C3B._id_8BB1 = 1;
        level._id_3C3B._id_8B3B = var_2;
      }

      if(isDefined(var_0._id_29E2)) {
        var_3 = var_0._id_29E2;

        if(var_1 < var_0._id_29E2)
          var_3 = var_1;

        var_4 = level._id_3C3B._id_8B3C + var_3;

        if(var_4 > 9999)
          level._id_3C3B._id_8B3C = 0;
        else if(var_4 < 0)
          level._id_3C3B._id_8B3C = 0;
        else
          level._id_3C3B._id_8B3C = var_4;

        var_0._id_29E2 = 0;
      }
    }
  }
}

_id_6399(var_0) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    var_0 waittill("grenade_fire", var_1);

    if(isDefined(var_1)) {
      waittillframeend;

      if(isDefined(var_1._id_7ACE) && var_1._id_7ACE) {
        continue;
      }
      var_2 = level._id_3C3B._id_8B3B + 1;

      if(var_2 > 9999) {
        level._id_3C3B._id_8B3B = 0;
        level._id_3C3B._id_8B3C = 0;
        level._id_3C3B._id_6F48 = 0;
        var_0 _meth_82FF("ui_vlobby_round_hits", level._id_3C3B._id_8B3C);
        var_0 _meth_82FF("ui_vlobby_round_fired", level._id_3C3B._id_8B3B);
        var_0 _meth_82FF("ui_vlobby_round_accuracy", level._id_3C3B._id_6F48);
      } else if(var_2 < 0) {
        level._id_3C3B._id_8B3B = 0;
        level._id_3C3B._id_8B3C = 0;
        level._id_3C3B._id_6F48 = 0;
        var_0 _meth_82FF("ui_vlobby_round_hits", level._id_3C3B._id_8B3C);
        var_0 _meth_82FF("ui_vlobby_round_fired", level._id_3C3B._id_8B3B);
        var_0 _meth_82FF("ui_vlobby_round_accuracy", level._id_3C3B._id_6F48);
      } else {
        level._id_3C3B._id_8BB1 = 1;
        level._id_3C3B._id_8B3B = var_2;
      }
    }
  }
}

_id_639C(var_0) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");

  for(;;) {
    if(level._id_3C3B._id_8B3B > 0) {
      var_1 = level._id_3C3B._id_8B3C / level._id_3C3B._id_8B3B * 100;
      var_1 = common_scripts\utility::_id_7F03(var_1, 0);

      if(var_1 != level._id_3C3B._id_6F48) {
        if(var_1 > 999)
          var_1 = 999;
        else if(var_1 < 0)
          var_1 = 0;

        level._id_3C3B._id_6F48 = int(var_1);
        level._id_3C3B._id_8BB1 = 1;
      }
    }

    waitframe();
  }
}

_id_3004(var_0, var_1) {
  var_0 endon("disconnect");
  level endon("shutdown_hologram");
  var_2 = _id_3B8B(level._id_3C3B._id_0BD8, var_1);

  if(isDefined(var_2))
    var_2 _meth_805B();

  for(;;) {
    if(level._id_3C3B._id_8BB1 == 1) {
      var_0 _meth_82FF("ui_vlobby_round_damage", level._id_3C3B._id_29BB);
      var_0 _meth_82FF("ui_vlobby_round_hits", level._id_3C3B._id_8B3C);
      var_0 _meth_82FF("ui_vlobby_round_fired", level._id_3C3B._id_8B3B);
      var_0 _meth_82FF("ui_vlobby_round_accuracy", level._id_3C3B._id_6F48);
      level._id_3C3B._id_8BB1 = 0;
    }

    wait 0.2;
  }
}

_id_3B8B(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_81E1) && var_3._id_81E1 == var_1)
      return var_3;
  }
}

_id_9301(var_0) {
  level endon("shutdown_hologram");
  level notify("start_round");
  level._id_3C3B._id_29BB = 0;
  level._id_3C3B._id_7A64 = 0;
  level._id_3C3B.time = 0;
  level._id_3C3B._id_7F12 = 1;
  level._id_3C3B._id_8BB1 = 1;
  self _meth_82FF("ui_vlobby_round_distance", level._id_3C3B._id_7A64);
  self _meth_82FF("ui_vlobby_round_damage", level._id_3C3B._id_29BB);
  self _meth_82FF("ui_vlobby_round_hits", level._id_3C3B._id_8B3C);
  self _meth_82FF("ui_vlobby_round_fired", level._id_3C3B._id_8B3B);
  self _meth_82FF("ui_vlobby_round_accuracy", level._id_3C3B._id_6F48);

  foreach(var_2 in level._id_3C3B._id_0C3A[var_0]) {
    foreach(var_4 in var_2) {
      var_4.origin = var_4._id_6C4F;
      var_4.angles = var_4._id_6C4D;
    }
  }

  if(level._id_010B)
    _id_8C14(var_0);
  else {
    var_7 = _id_8C26(var_0);
    wait 0.1;
    _id_3D67(level._id_3C3B._id_0BDC[var_0]);
    _id_3D67(level._id_3C3B._id_0BDC[var_0]);
    wait 0.1;
    _id_3D67(level._id_3C3B._id_0BDC[var_0]);
    wait 0.1;
    _id_4D1A(var_0, var_7);
    wait 0.1;
    _id_8C14(var_0);
  }

  if(var_0 == 7) {
    self _meth_82FF("ui_vlobby_round_state", 3);
    thread _id_9838(var_0);
  } else {
    self _meth_82FF("ui_vlobby_round_state", 1);
    thread _id_089E(var_0);
  }
}

_id_8C14(var_0) {
  level endon("shutdown_hologram");
  var_1 = common_scripts\utility::_id_7F03(level._id_3C3B._id_0BDC[var_0].size / level._id_3C3B._id_4895, 0, "up");
  var_2 = 0;

  foreach(var_4 in level._id_3C3B._id_0BDC[var_0]) {
    var_4 _meth_805B();
    var_4 _meth_82C1();
  }
}

_id_8C27(var_0) {
  level endon("shutdown_hologram");
  level._id_3C3B._id_9C7D = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !_func_279(var_2) && isDefined(var_2.classname) && var_2.classname == "script_model") {
      if(isDefined(var_2.model) && issubstr(var_2.model, "_trans")) {
        var_3 = var_2.model + "_rev";
        var_4 = spawn("script_model", var_2.origin);
        level._id_3C3B._id_9C7D[level._id_3C3B._id_9C7D.size] = var_4;

        if(isDefined(var_2.angles))
          var_4.angles = var_2.angles;
        else
          var_4.angles = (0, 0, 0);

        var_4 setModel(var_3);
        var_4 _meth_82C2();
      }
    }
  }
}

_id_8C25(var_0) {
  level endon("shutdown_hologram");
  level._id_3C3B._id_9C7C = [];

  foreach(var_2 in level._id_3C3B._id_0BDC[var_0]) {
    if(isDefined(var_2.classname) && var_2.classname == "script_model") {
      if(isDefined(var_2.model) && issubstr(var_2.model, "rec_holo_range")) {
        var_3 = var_2.model + "_trans";
        var_4 = spawn("script_model", var_2.origin);
        level._id_3C3B._id_9C7C[level._id_3C3B._id_9C7C.size] = var_4;

        if(isDefined(var_2.angles))
          var_4.angles = var_2.angles;
        else
          var_4.angles = (0, 0, 0);

        var_4 setModel(var_3);
        var_4 _meth_82C2();
      }
    }
  }
}

_id_3D67(var_0) {
  level endon("shutdown_hologram");

  if(isDefined(var_0) && _func_0C0(var_0)) {
    _id_4D11(var_0);
    waitframe();
    _id_8C0C(var_0);
    waitframe();
  }
}

_id_8C0C(var_0) {
  level endon("shutdown_hologram");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !_func_279(var_2)) {
      var_2 _meth_805B();
      var_2 _meth_82C2();
    }
  }
}

_id_4D11(var_0) {
  level endon("shutdown_hologram");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && !_func_279(var_2)) {
      var_2 _meth_805C();
      var_2 _meth_82C2();
    }
  }
}

_id_4D19() {
  if(_func_0C0(level._id_3C3B._id_9C7C)) {
    level._id_3C3B._id_9C7C = common_scripts\utility::_id_0F97(level._id_3C3B._id_9C7C);

    foreach(var_1 in level._id_3C3B._id_9C7C) {
      if(isDefined(var_1) && !_func_279(var_1)) {
        var_1 _meth_805C();
        var_1 _meth_82C2();
      }
    }
  }
}

_id_2D55() {
  if(_func_0C0(level._id_3C3B._id_9C7D)) {
    level._id_3C3B._id_9C7D = common_scripts\utility::_id_0F97(level._id_3C3B._id_9C7D);

    foreach(var_1 in level._id_3C3B._id_9C7D) {
      if(isDefined(var_1) && !_func_279(var_1))
        var_1 delete();
    }
  }

  level._id_3C3B._id_9C7D = [];
}

_id_7D00() {
  if(_func_0C0(level._id_3C3B._id_9C7C)) {
    var_0 = common_scripts\utility::_id_0F97(level._id_3C3B._id_9C7C);
    _id_3D67(var_0);
    _id_3D67(var_0);
    wait 0.1;
    _id_3D67(var_0);
    wait 0.1;
    _id_3D67(var_0);

    foreach(var_2 in var_0) {
      if(isDefined(var_2) && !_func_279(var_2))
        var_2 delete();
    }
  }
}

_id_7CF7() {
  if(_func_0C0(level._id_3C3B._id_808A)) {
    level._id_3C3B._id_808A = common_scripts\utility::_id_0F97(level._id_3C3B._id_808A);

    foreach(var_1 in level._id_3C3B._id_808A) {
      if(isDefined(var_1) && !_func_279(var_1))
        var_1 delete();
    }
  }
}

_id_64A8() {
  level endon("shutdown_hologram");
  var_0 = _func_0A5(0.0, 1);
  wait(var_0);
  self setModel("rec_holo_emitter_floor_on");
  self _meth_82B1(self._id_A08D, 0.25, 0.1, 0.1);
}

_id_64A7() {
  level endon("start_round");
  self setModel("rec_holo_emitter_floor_off");
  var_0 = _func_0A5(0.0, 1);
  wait(var_0);
  self _meth_82B1(self._id_6A23, 0.25, 0.1, 0.1);
}

_id_8C35(var_0, var_1) {
  level notify("shutdown_hologram");
  level._id_3C3B._id_57CC = 1;
  var_1 _meth_82FF("ui_vlobby_round_state", 0);
  var_1 _meth_82FF("ui_vlobby_round_timer", 0);
  var_1 _meth_82FF("ui_vlobby_round_damage", 0);
  var_1 _meth_82FF("ui_vlobby_round_distance", 0);
  var_1 _meth_82FF("ui_vlobby_round_hits", 0);
  var_1 _meth_82FF("ui_vlobby_round_fired", 0);
  var_1 _meth_82FF("ui_vlobby_round_accuracy", 0);
  var_1 thread _id_4864(1);

  foreach(var_3 in level._id_3C3B._id_0BDC[var_0]) {
    var_3 _meth_805C();
    var_3 _meth_82C2();
  }

  if(level._id_010B)
    thread maps\mp\_utility::_id_5C99("lt_shootingrange", 0.25, 6000);

  thread maps\mp\_utility::_id_5C98("lt_shootingrange_bounce", 0.25, 3000);
  thread maps\mp\_utility::_id_5C98("lt_hologram_blue", 0.25, 0.01);

  foreach(var_6 in level._id_3C3B._id_0C3A[var_0]) {
    foreach(var_8 in var_6) {
      if(var_8._id_0BC0 == 1) {
        var_9 = var_8.origin;
        var_10 = var_8.angles;
        thread _id_6E9B(level._id_3C3B._id_A48E, var_9, var_10, 3);
      }

      var_8 _meth_808C();
      var_8._id_0B6E _meth_81D3();
      var_8.origin = var_8._id_6C4F;
      var_8.angles = var_8._id_6C4D;
      var_8._id_0B6E _meth_805C();
      var_8._id_0B6E _meth_82C2();
      var_8 _meth_805C();
      var_8 _meth_82C2();
      var_8._id_A580 _meth_805C();
      var_8._id_A580 _meth_82C2();
      var_8._id_0BC0 = 0;
    }
  }

  foreach(var_14 in level._id_3C3B._id_0BD8)
  var_14 _meth_805C();

  level._id_3C3B._id_621E = undefined;
  level._id_3C3B._id_6095 = undefined;
  level._id_3C3B._id_621F = undefined;
  level._id_3C3B._id_76AE = 0;
  level._id_3C3B._id_76AF = 0;
  level._id_3C3B._id_29BB = 0;
  level._id_3C3B._id_7A64 = 0;
  level._id_3C3B._id_8B3B = 0;
  level._id_3C3B._id_8B3C = 0;
  level._id_3C3B._id_6F48 = 0;
  level._id_3C3B._id_7F12 = 0;
  level._id_3C3B._id_8BB1 = 1;
  var_1 _meth_82FF("ui_vlobby_round_distance", level._id_3C3B._id_7A64);
  var_1 _meth_82FF("ui_vlobby_round_damage", level._id_3C3B._id_29BB);
  var_1 _meth_82FF("ui_vlobby_round_hits", level._id_3C3B._id_8B3C);
  var_1 _meth_82FF("ui_vlobby_round_fired", level._id_3C3B._id_8B3B);
  var_1 _meth_82FF("ui_vlobby_round_accuracy", level._id_3C3B._id_6F48);
  level._id_3C3B._id_57CC = 0;
}

_id_90AA() {
  level endon("shutdown_hologram");
  var_0 = self.origin;
  var_1 = self.angles;
  thread _id_6E9B(level._id_3C3B._id_A48D, var_0, var_1, 3);
  waitframe();
  self _meth_82C1();
  self._id_A580 _meth_805B();
}

_id_8087() {
  level notify("ScaleSoundsOnExit");
  level endon("ScaleSoundsOnExit");

  if(isDefined(self._id_50CA)) {
    for(;;) {
      waitframe();

      if(self._id_50CA == 1 || getdvarint("2454", 0) == 1)
        continue;
      else {
        level._id_3C3B._id_8F41 = common_scripts\utility::_id_0F97(level._id_3C3B._id_8F41);

        foreach(var_1 in level._id_3C3B._id_8F41)
        var_1 _meth_861B(0, 0.5);
      }
    }
  }
}

_id_37B1(var_0) {
  var_0._id_50CA = 1;
  thread _id_A673(0.4, var_0);
}

_id_A673(var_0, var_1) {
  var_1 endon("enter_lobby");

  if(!level._id_A220)
    wait(var_0);

  var_1 _meth_82FF("ui_vlobby_round_state", 0);
  var_1 _meth_82FF("ui_vlobby_round_timer", 0);
  var_1 _meth_82FF("ui_vlobby_round_damage", 0);
  var_1 _meth_82FF("ui_vlobby_round_distance", 0);
  var_1 _meth_82FF("ui_vlobby_round_hits", 0);
  var_1 _meth_82FF("ui_vlobby_round_fired", 0);
  var_1 _meth_82FF("ui_vlobby_round_accuracy", 0);

  if(!level._id_A220) {
    var_1 _meth_8057();
    var_1 _meth_81E3();
  }

  var_2 = _func_082(level._id_3C3B._id_3E6C.origin, 20, 512, 120);
  var_1 _meth_808C();
  var_1 setOrigin(var_2);
  var_1 _meth_833E(level._id_3C3B._id_3E6C.angles);
  var_1 setclientdvar("3078", "1.0");
  level._id_3C3B._id_57CC = 0;
  maps\mp\hub_vl_camera::_id_A558(var_1._id_13B3._id_6DAC, "lobby" + (var_1._id_294D + 1), 1, 1);
  maps\mp\_utility::_id_A165("playing");
  var_1 _meth_82D8("mp_vlobby_room_fr", 0);
  var_1 thread maps\mp\hub_vl_base::_id_3639();
  level._id_3C3B._id_8F41 = [];
  var_1 thread _id_8087();

  if(maps\mp\gametypes\_class::_id_5826(maps\mp\_utility::_id_44CD(var_1._id_5DF5), 0) && !maps\mp\gametypes\_class::_id_5682(var_1._id_5DF5.guid))
    var_1 thread _id_6311(maps\mp\_utility::_id_44CD(var_1._id_5DF5), 0);

  if(maps\mp\gametypes\_class::_id_5826(maps\mp\_utility::_id_44CD(var_1._id_5DF8), 0) && !maps\mp\gametypes\_class::_id_5682(var_1._id_5DF8.guid))
    var_1 thread _id_6311(maps\mp\_utility::_id_44CD(var_1._id_5DF8), 1);

  if(var_1.primaryweapon != "specialty_null" && var_1.primaryweapon != "none" && var_1.primaryweapon != "combatknife_mp" && !issubstr(var_1.primaryweapon, "em1") && !issubstr(var_1.primaryweapon, "epm3") && !issubstr(var_1.primaryweapon, "dlcgun1_mp") && !issubstr(var_1.primaryweapon, "dlcgun1loot")) {
    var_1 thread _id_635E(var_1.primaryweapon);

    if(issubstr(var_1.primaryweapon, "_gl"))
      var_1 thread _id_635E("alt_" + var_1.primaryweapon);
  }

  if(var_1._id_835A != "specialty_null" && var_1._id_835A != "none" && var_1._id_835A != "combatknife_mp" && !issubstr(var_1._id_835A, "em1") && !issubstr(var_1._id_835A, "epm3") && !issubstr(var_1.primaryweapon, "dlcgun1_mp") && !issubstr(var_1.primaryweapon, "dlcgun1loot")) {
    var_1 thread _id_635E(var_1._id_835A);

    if(issubstr(var_1._id_835A, "_gl"))
      var_1 thread _id_635E("alt_" + var_1._id_835A);
  }
}

_id_47A5() {
  self endon("enter_lobby");
  wait 2;
  var_0 = getdvarint("2454", 0);

  if(var_0 == 1 && self._id_50CA == 1)
    self _meth_812B(1);
}

_id_089E(var_0) {
  level endon("shutdown_hologram");
  var_1 = self;
  level._id_3C3B._id_5B57 = undefined;
  thread _id_63EE(var_1);
  thread _id_63E2(var_1);
  thread _id_639C(var_1);

  foreach(var_3 in level._id_3C3B._id_0C3A[var_0]) {
    foreach(var_5 in var_3)
    var_5 thread _id_6377(var_1);
  }

  thread _id_3004(var_1, var_0);
  var_8 = level._id_3C3B._id_0C3A[var_0].size;
  var_9 = level._id_3C3B._id_0C3A[var_0];

  for(var_10 = 0; var_10 < var_8; var_10++) {
    thread _id_930C(var_9[var_10], var_1);
    level waittill("wave_done");
    waitframe();
  }

  level notify("round_done");
  level._id_3C3B._id_7F12 = 0;
  var_1 _meth_82FF("ui_vlobby_round_state", 2);
}

_id_63EE(var_0) {
  level endon("shutdown_hologram");
  level endon("round_done");
  var_1 = maps\mp\_utility::gettimepassed();

  for(;;) {
    var_2 = maps\mp\_utility::gettimepassed();
    var_3 = var_2 - var_1;
    var_4 = common_scripts\utility::_id_7F03(var_3 / 1000, 1);

    if(var_4 > 9999.9) {
      level._id_3C3B.time = 0;
      var_0 _meth_82FF("ui_vlobby_round_timer", level._id_3C3B.time);
      var_0 _meth_82FF("ui_vlobby_round_state", 0);
      thread _id_8C35(level._id_3C3B._id_7F1F, var_0);
      return;
    } else if(var_4 < 0) {
      level._id_3C3B.time = 0;
      var_0 _meth_82FF("ui_vlobby_round_timer", level._id_3C3B.time);
      var_0 _meth_82FF("ui_vlobby_round_state", 0);
      thread _id_8C35(level._id_3C3B._id_7F1F, var_0);
      return;
    } else {
      level._id_3C3B.time = var_4;
      var_0 _meth_82FF("ui_vlobby_round_timer", level._id_3C3B.time);
    }

    waitframe();
  }
}

_id_930C(var_0, var_1) {
  level endon("shutdown_hologram");

  if(getdvarint("scr_target_bots", 0) > 0) {
    level._id_8C7A = 1;
    level._id_0A41["player"]["think"] = ::_id_3765;
    level._id_0A41["player"]["on_damaged_finished"] = ::_id_3764;
  }

  var_2 = 0;

  foreach(var_4 in var_0) {
    if(getdvarint("scr_target_bots", 0) > 0) {
      var_4 thread _id_9800(var_1);
      continue;
    }

    var_4 thread _id_980F(var_1);
  }

  for(;;) {
    level waittill("target_died");
    var_2++;

    if(var_2 == var_0.size) {
      level notify("wave_done");
      return;
    }
  }
}

_id_980F(var_0) {
  level endon("shutdown_hologram");
  self._id_6C4F = self.origin;
  self._id_6C4D = self.angles;
  self._id_0BC0 = 1;
  _id_90AA();
  thread _id_980D(var_0);
  thread _id_9810();
  thread _id_980B();
  thread _id_980C();
}

_id_9800(var_0) {
  level endon("shutdown_hologram");
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_2 = _id_9000(var_1.origin, var_1.angles, var_0);

  if(isDefined(var_2)) {
    var_2 thread _id_9801();
    var_2 thread _id_9802();
  }
}

_id_9000(var_0, var_1, var_2) {
  var_3 = maps\mp\agents\_agents::_id_0933("player", game["defenders"], undefined, var_0, var_1, undefined, undefined, 0, undefined, undefined);

  if(isDefined(var_3)) {
    var_4 = 1;
    var_3 _meth_8528(var_4, maps\mp\_utility::getotherteam(var_2.team));
    var_3 _meth_83E1("cloth");
    var_3 _id_861F(var_4, maps\mp\_utility::getotherteam(var_2.team));
  }

  return var_3;
}

_id_861F(var_0, var_1) {
  for(var_2 = 0; var_2 < level._id_2683.size; var_2++) {
    if(var_1 == "allies")
      var_3 = 0;
    else
      var_3 = 6;

    var_4 = _func_1AE("mp/agentcostumetable.csv", var_2 + var_3, var_0);
    self._id_267E[var_2] = int(tablelookup("mp/costumeIdTable.csv", 7, var_4, 4));
  }
}

_id_3765() {
  self endon("death");
  level endon("game_ended");
  self _meth_8353("no_enemy_search", 1);
  self _meth_8353("disable_movement", 1);
  self _meth_8353("disable_rotation", 1);
  self _meth_8353("disable_attack", 1);
}

_id_3764(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(isDefined(var_1))
    var_11 = length(self.origin - var_1.origin);
  else
    var_11 = 0;

  _func_18B(self.name + " " + var_8 + " has been hit for " + var_2 + " at " + var_11);
  return maps\mp\agents\_agents::_id_0A40(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_6E9B(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  var_5 = _func_14B(var_0, var_1, anglesToForward(var_2), anglestoup(var_2));

  if(isDefined(var_4))
    setfxkillondelete(var_5, var_4);

  _func_14C(var_5);

  if(isDefined(var_3)) {
    wait(var_3);

    if(isDefined(var_5) && !_func_279(var_5))
      var_5 delete();
  } else {
    level waittill("shutdown_hologram");

    if(isDefined(var_5) && !_func_279(var_5))
      var_5 delete();
  }
}

_id_9810() {
  level endon("shutdown_hologram");
  self endon("death");

  if(isDefined(self._id_8260)) {
    var_0 = self._id_8260;
    _id_64D0();

    switch (var_0) {
      case "stand":
        break;
      case "cover":
        thread _id_7574();
        break;
      case "move":
        thread _id_649E();
        break;
    }
  }
}

_id_64D0() {
  level endon("shutdown_hologram");
  self endon("death");

  if(!isDefined(level._id_3C3B._id_7F1F)) {
    return;
  }
  var_0 = level._id_3C3B._id_7F1F;

  if(!isDefined(level._id_3C3B._id_0C37[var_0])) {
    return;
  }
  var_1 = common_scripts\utility::_id_4461(self.origin, level._id_3C3B._id_0C37[var_0]);
  self._id_28F5 = var_1;
  self._id_5B23 = self._id_28F5;

  for(;;) {
    if(isDefined(self)) {
      var_2 = distance(self._id_28F5.origin, self.origin);
      var_3 = var_2 / level._id_3C3B._id_7F0E;

      if(var_3 < 0.5)
        var_3 = 0.5;

      if(isDefined(self._id_28F5._id_0165) && self._id_28F5._id_0165 == "jump")
        self _meth_82B1(self._id_28F5.origin, var_3 * 0.5, 0, 0.1);
      else if(isDefined(self._id_5B23._id_0165) && self._id_5B23._id_0165 == "jump")
        self _meth_82B1(self._id_28F5.origin, var_3 * 0.5, 0.1, 0);
      else
        self _meth_82B1(self._id_28F5.origin, var_3);

      self waittill("movedone");

      if(isDefined(self._id_28F5.target)) {
        var_4 = _func_18E(self._id_28F5.target, "targetname");
        self._id_5B23 = self._id_28F5;
        self._id_28F5 = var_4;
      } else
        return;
    } else
      return;
  }
}

_id_7574() {
  level endon("shutdown_hologram");
  self endon("death");
  var_0 = 4;
  var_1 = 1;
  var_2 = self._id_28F5.origin;
  var_3 = self._id_5B23.origin;

  if(self._id_28F5 == self._id_5B23)
    var_3 = self._id_6C4F;

  wait(var_0);

  for(;;) {
    if(isDefined(self)) {
      var_4 = distance(var_3, var_2);
      var_5 = var_4 / level._id_3C3B._id_7F0E;
      self _meth_82B1(var_3, var_5);
      self waittill("movedone");
      wait(var_1);
      var_4 = distance(var_3, var_2);
      var_5 = var_4 / level._id_3C3B._id_7F0E;
      self _meth_82B1(var_2, var_5);
      self waittill("movedone");
      wait(var_0);
    }
  }
}

_id_649E() {
  level endon("shutdown_hologram");
  self endon("death");
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(self._id_5B23._id_0165) && self._id_5B23._id_0165 == "jump") {
    var_0 = self._id_5B23;
    var_1 = var_0.origin;
    self._id_5B23 = _func_18E(var_0.targetname, "target");
  }

  var_2 = self._id_28F5.origin;
  var_3 = self._id_5B23.origin;

  if(self._id_28F5 == self._id_5B23)
    var_3 = self._id_6C4F;

  for(;;) {
    if(isDefined(self)) {
      if(isDefined(var_1)) {
        wait 2;
        var_4 = distance(var_1, var_2);
        var_5 = var_4 / level._id_3C3B._id_7F0E;
        self _meth_82B1(var_1, var_5 * 0.5, 0, 0.1);
        self waittill("movedone");
        var_4 = distance(var_1, var_3);
        var_5 = var_4 / level._id_3C3B._id_7F0E;
        self _meth_82B1(var_3, var_5 * 0.5, 0.1, 0);
        self waittill("movedone");
        wait 2;
        var_4 = distance(var_1, var_3);
        var_5 = var_4 / level._id_3C3B._id_7F0E;
        self _meth_82B1(var_1, var_5 * 0.5, 0, 0.1);
        self waittill("movedone");
        var_4 = distance(var_1, var_2);
        var_5 = var_4 / level._id_3C3B._id_7F0E;
        self _meth_82B1(var_2, var_5 * 0.5, 0.1, 0);
        self waittill("movedone");
      } else {
        var_4 = distance(var_3, var_2);
        var_5 = var_4 / level._id_3C3B._id_7F0E;
        self _meth_82B1(var_3, var_5);
        self waittill("movedone");
        var_4 = distance(var_2, var_3);
        var_5 = var_4 / level._id_3C3B._id_7F0E;
        self _meth_82B1(var_2, var_5);
        self waittill("movedone");
      }
    }
  }
}

_id_80A5() {
  level endon("shutdown_hologram");

  for(;;) {
    var_0 = [];

    for(var_1 = 0; var_1 < self._id_4DDE.size; var_1++) {
      self._id_4DDE[var_1].time = self._id_4DDE[var_1].time - 1;

      if(self._id_4DDE[var_1].time > 0)
        var_0[var_0.size] = self._id_4DDE[var_1];
    }

    self._id_4DDE = var_0;

    foreach(var_3 in self._id_4DDE) {}

    waitframe();
  }
}

_id_980D(var_0) {
  level endon("shutdown_hologram");
  self._id_4DDE = [];
  self._id_0B6E.health = 9999;
  self._id_0B6E.maxhealth = 9999;
  self.maxhealth = 9999;
  self.health = self.maxhealth;
  self._id_3A09 = 100;
  self _meth_82C3(1);
  self._id_0B6E _meth_805B();
  self._id_0B6E _meth_82C1();
  self._id_0B6E _meth_81B0();
  self._id_A580 _meth_805B();

  while(self.health > 0) {
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_11 = _id_4591(var_10, var_8, var_0);
    var_12 = self gettagorigin("tag_head");
    var_13 = self gettagorigin("tag_chest");
    self.health = self.maxhealth;
    var_14 = self._id_3A09;
    var_14 = _func_0AD(var_14) - _func_0AD(var_1) * var_11;
    var_14 = common_scripts\utility::_id_7F03(var_14, 0);
    self._id_3A09 = int(var_14);

    if(self._id_3A09 <= 0) {
      thread _id_9833(var_13);
      self.health = 0;

      if(isDefined(var_2)) {
        if(isDefined(var_8)) {
          if(var_8 == "tag_head")
            var_2 _id_04C7::_id_A102("killshot_headshot");
          else if(var_8 == "tag_chest")
            var_2 _id_04C7::_id_A102("mp_hit_kill");
        }
      }

      self notify("death");
      continue;
    }

    if(isDefined(var_2)) {
      if(isDefined(var_8) && var_8 == "tag_head") {
        var_2 _id_04C7::_id_A102("headshot");
        continue;
      }

      var_2 _id_04C7::_id_A102("standard");
    }
  }
}

_id_9803() {
  level endon("shutdown_hologram");
  self._id_4DDE = [];

  while(isDefined(self) && self.health > 0)
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_9833(var_0) {
  playFX(level._effect["recovery_scoring_target_shutter_enemy"], var_0);
}

_id_2A72() {
  level notify("shutdown_hologram");
}

_id_3C37() {
  var_0 = getEntArray("firing_range_round_trigger", "targetname");
  return var_0;
}

_id_3C35() {
  var_0 = getEntArray("target_logic_point", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3._id_81E1)) {
      var_4 = int(var_3._id_81E1);

      if(!_func_0C0(var_1[var_4])) {
        var_5 = [var_3];
        var_1[var_4] = var_5;
      } else
        var_1[var_4] = common_scripts\utility::_id_0972(var_1[var_4], var_3);
    }
  }

  return var_1;
}

_id_3C30() {
  var_0 = getEntArray("round_environment", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3 _meth_805C();
    var_3 _meth_82C2();
    var_4 = undefined;

    if(isDefined(var_3._id_81E1))
      var_4 = int(var_3._id_81E1);

    if(isDefined(var_4)) {
      if(!_func_0C0(var_1[var_4])) {
        var_5 = [var_3];
        var_1[var_4] = var_5;
        continue;
      }

      var_1[var_4] = common_scripts\utility::_id_0972(var_1[var_4], var_3);
    }
  }

  return var_1;
}

_id_3C31() {
  var_0 = common_scripts\utility::_id_46B7("round_environment", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = undefined;

    if(isDefined(var_3._id_81E1))
      var_4 = int(var_3._id_81E1);

    if(isDefined(var_4)) {
      if(!_func_0C0(var_1[var_4])) {
        var_5 = [var_3];
        var_1[var_4] = var_5;
        continue;
      }

      var_1[var_4] = common_scripts\utility::_id_0972(var_1[var_4], var_3);
    }
  }

  return var_1;
}

_id_3C36() {
  var_0 = getEntArray("target_enemy", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_3._id_0BC0 = 0;
    var_3.pers["team"] = "axis";
    var_3.team = "axis";
    var_3._id_6C3E = _func_18E(var_3.target, "targetname");
    var_3._id_0B6E = _func_18E(var_3._id_6C3E.target, "targetname");
    var_3._id_0B6E linktosynchronizedparent(var_3);
    var_3._id_0B6E.pers["team"] = "axis";
    var_3._id_0B6E.team = "axis";

    if(isDefined(var_3._id_0B6E.target)) {
      var_3._id_A580 = _func_18E(var_3._id_0B6E.target, "targetname");
      var_3._id_A580 linktosynchronizedparent(var_3);
    } else
      var_3._id_A580 = var_3;

    var_3._id_6C4F = var_3.origin;
    var_3._id_6C4D = var_3.angles;
    var_3._id_0B6E _meth_805C();
    var_3._id_0B6E _meth_82C2();
    var_3 _meth_805C();
    var_3 _meth_82C2();
    var_3._id_A580 _meth_805C();
    var_3._id_A580 _meth_82C2();

    if(isDefined(var_3._id_81E1)) {
      var_4 = int(var_3._id_81E1);

      if(!_func_0C0(var_1[var_4])) {
        var_5 = [];
        var_1[var_4] = var_5;
      }

      if(isDefined(var_3._id_81D2)) {
        var_6 = int(var_3._id_81D2);

        if(!_func_0C0(var_1[var_4][var_6])) {
          var_7 = [var_3];
          var_1[var_4][var_6] = var_7;
        } else
          var_1[var_4][var_6] = common_scripts\utility::_id_0972(var_1[var_4][var_6], var_3);
      }
    }
  }

  return var_1;
}

_id_980B() {
  level endon("shutdown_hologram");
  self waittill("death");
  level notify("target_died");
  _id_9819();
}

_id_9801() {
  level endon("shutdown_hologram");
  self waittill("death");
  level notify("target_died");
}

_id_980C() {
  self endon("death");
  level waittill("shutdown_hologram");
  _id_9819();
}

_id_9802() {
  self endon("death");
  level waittill("shutdown_hologram");
  maps\mp\agents\_agent_utility::_id_5A28(self);
}

_id_9819() {
  self _meth_82C3(0);
  self _meth_805C();
  self _meth_82C2();
  self._id_0BC0 = 0;

  if(isDefined(self._id_0B6E))
    self._id_0B6E _meth_81D3();

  if(isDefined(self._id_A580))
    self._id_A580 _meth_805C();
}

_id_635E(var_0) {
  self endon("enter_lobby");

  while(self._id_50CA == 1) {
    var_1 = self _meth_8338(var_0);

    if(var_1 <= 0.25) {
      self givemaxammo(var_0);
      continue;
    }

    wait 0.5;
  }
}

_id_4864(var_0) {
  if(isDefined(level._id_486C) && _func_0C0(level._id_486C)) {
    foreach(var_2 in level._id_486C) {
      if(isDefined(var_2) && !_func_279(var_2)) {
        if(!isDefined(self) || !isDefined(var_2._id_0117) || _func_279(var_2._id_0117)) {
          if(!isDefined(var_2._id_A9E0))
            continue;
          else {
            var_2 notify("death");
            var_2 thread _id_2CC3();
          }

          continue;
        }

        if(var_2._id_0117 == self) {
          if(!isDefined(var_2._id_A9E0))
            continue;
          else {
            var_2 notify("death");
            var_2 thread _id_2CC3();
          }
        }
      }
    }
  }
}

_id_2CC3() {
  waitframe();

  if(isDefined(self) && !_func_279(self))
    self delete();
}

_id_6311(var_0, var_1) {
  self endon("enter_lobby");

  while(level._id_50CA == 1) {
    wait 1.5;
    var_2 = self getammocount(var_0);

    if(var_2 == 0) {
      maps\mp\gametypes\_class::_id_479F(var_0);
      continue;
    }

    wait 0.5;
  }
}

_id_8C26(var_0) {
  level endon("shutdown_hologram");
  var_1 = 0;
  var_2 = [];

  foreach(var_4 in level._id_3C3B._id_0BDC[var_0]) {
    if(isDefined(var_4.classname) && var_4.classname == "script_model") {
      if(isDefined(var_4.model) && issubstr(var_4.model, "rec_holo_range")) {
        var_2[var_1] = var_4.model;

        if(!issubstr(var_4.model, "trans")) {
          var_5 = var_4.model + "_trans";
          var_4 setModel(var_5);
        }

        var_4 _meth_805B();
      } else
        var_2[var_1] = undefined;
    }

    var_1++;
  }

  return var_2;
}

_id_4D1A(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in level._id_3C3B._id_0BDC[var_0]) {
    if(isDefined(var_4.classname) && var_4.classname == "script_model") {
      if(isDefined(var_4.model) && issubstr(var_4.model, "rec_holo_range")) {
        if(_func_031(var_1[var_2])) {
          var_4 _meth_805C();
          var_4 setModel(var_1[var_2]);
        }
      }
    }

    var_2++;
  }
}