/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_code.gsc
************************************************/

_id_8CA5(var_0) {
  self notify("stop_headtrack_when_close");
  self endon("stop_headtrack_when_close");
  var_1 = squared(60);

  for(;;) {
    if(distance2dsquared(self.origin, level.player.origin) <= var_1) {
      thread scripts\sp\utility::_id_7799(level.player, 2, 0.5);
      thread scripts\sp\utility::_id_7792(level.player);
      wait 1;

      while(distance2dsquared(self.origin, level.player.origin) <= var_1) {
        wait 0.05;
      }

      scripts\sp\utility::_id_77B9(0.25);
      wait 3;
    }

    wait 0.1;
  }
}

_id_11003() {
  self notify("stop_headtrack_when_close");
  scripts\sp\utility::_id_77B9(0.25);
}

_id_1939() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0.demeanoroverride) && var_0.demeanoroverride == self._id_ED56) {
      continue;
    }
    var_0 scripts\sp\utility::_id_51E1(self._id_ED56);
    var_0.script_pushable = 0;
  }
}

_id_5195(var_0, var_1) {
  if(isDefined(var_1)) {
    scripts\engine\utility::flag_wait(var_1);
  }

  var_2 = _id_0F27::_id_79F5(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  if(isDefined(var_2) && !var_2.size) {
    return;
  }
  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_F10A) && isalive(var_4._id_F10A)) {
      var_4._id_F10A delete();
    }
  }

  foreach(var_4 in var_2) {
    if(var_4.damageshield) {
      var_4 scripts\sp\utility::_id_1101B();
    }
  }

  scripts\sp\utility::_id_228A(var_2);
}

_id_8DEC(var_0) {
  if(var_0) {
    stopFXOnTag(scripts\engine\utility::getfx("suit_light_ally_helmet"), self, "j_helmet");
  } else {
    stopFXOnTag(scripts\engine\utility::getfx("suit_light_ally_helmet"), self, "j_helmet");
  }
}

_id_10A5C(var_0, var_1) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 70;
  }

  var_2 = abs(self.origin[2] - var_0[2]);

  if(var_2 > var_1) {
    return 1;
  }

  return 0;
}

_id_10FC2() {
  self notify("new_anim_reach");
  self notify("stop_animmode");
  scripts\sp\utility::anim_stopanimScripted();
  self notify("stop_going_to_node");
  scripts\sp\utility::_id_F3DC(self.origin);
}

_id_1958(var_0) {
  var_1 = 0;
  _id_0C4C::_id_1955(var_0);
}

_id_1962(var_0) {
  _id_0C4C::_id_1960(var_0);
}

_id_10733() {
  _id_10758();
  _id_10764();
  level._id_10AC8 = [level._id_C47F, level._id_2429, level._id_B33B, level._id_B33E];
}

_id_10758() {
  level._id_2429 = scripts\sp\utility::_id_107EA("atom", 1);
  level._id_2429.name = "Ethan";
  level._id_2429._id_1FBB = "atom";
  level._id_2429._id_134DB = ::_id_2434;
  level._id_2429 scripts\sp\utility::_id_72EC("iw7_crb+silencersmg", "primary");
  level._id_C47F = scripts\sp\utility::_id_107EA("marine_co", 1);
  level._id_C47F.name = "Omar";
  level._id_C47F._id_1FBB = "omar";
  level._id_C47F._id_134DB = ::_id_C48A;
  level._id_C47F scripts\sp\utility::_id_72EC("iw7_fhr+silencersmg", "primary");
  level._id_8E42 = [level._id_C47F, level._id_2429];
  scripts\engine\utility::array_thread(level._id_8E42, ::_id_8E32);
  scripts\engine\utility::array_thread(level._id_8E42, ::_id_10AD6);

  if(!isDefined(level._id_10AC8)) {
    level._id_10AC8 = [level._id_C47F, level._id_2429];
  } else if(level._id_10AC8.size == 2) {
    level._id_10AC8 = scripts\engine\utility::add_to_array(level._id_10AC8, level._id_2429);
    level._id_10AC8 = scripts\engine\utility::add_to_array(level._id_10AC8, level._id_C47F);
  }
}

_id_BC2A(var_0, var_1) {
  foreach(var_3 in var_1) {
    var_4 = scripts\engine\utility::getStruct(tolower(var_0 + var_3._id_1FBB), "targetname");

    if(isDefined(var_4)) {
      var_3 _meth_80F1(var_4.origin, var_4.angles, 10000);
    }
  }
}

_id_10764() {
  if(isDefined(level._id_B351)) {
    return;
  }
  level._id_B33B = scripts\sp\utility::_id_107EA("marine1");
  level._id_B33B._id_1FBB = "marine1";
  level._id_B33B.name = "Brooks";
  level._id_B33B.headmodel = "base_hero_marine_1";
  level._id_B33B._id_134DB = ::_id_30FC;
  level._id_B33B scripts\sp\utility::_id_72EC("iw7_kbs+kbsscope+silencersniperhide", "primary");
  level._id_B33E = scripts\sp\utility::_id_107EA("marine2");
  level._id_B33E._id_1FBB = "marine2";
  level._id_B33E.name = "Kashima";
  level._id_B33E._id_134DB = ::_id_A556;
  level._id_B33E scripts\sp\utility::_id_72EC("iw7_m8+m8scope_sp+silencersniperhidee", "primary");
  level._id_B351 = [level._id_B33B, level._id_B33E];
  scripts\engine\utility::array_thread(level._id_B351, ::_id_B34F);
  scripts\engine\utility::array_thread(level._id_B351, ::_id_10AD6);

  if(!isDefined(level._id_10AC8)) {
    level._id_10AC8 = [level._id_B33B, level._id_B33E];
  } else if(level._id_10AC8.size == 2) {
    level._id_10AC8 = scripts\engine\utility::add_to_array(level._id_10AC8, level._id_B33B);
    level._id_10AC8 = scripts\engine\utility::add_to_array(level._id_10AC8, level._id_B33E);
  }
}

_id_10732() {
  var_0 = scripts\sp\vehicle::_id_1080C("friendly_jackal_spaceship");
  var_0.ignoreme = 1;
  var_0 scripts\sp\vehicle::_id_8441();
  var_0 thread scripts\sp\utility::_id_B14F();
  var_0._id_B00A = spawn("script_origin", (0, 0, 0));
  var_0._id_4074[var_0._id_4074.size] = var_0._id_B00A;
  var_0 scripts\sp\utility::_id_65E0("pause_scripted_behavior");
  var_0 scripts\sp\utility::_id_65E0("pause_scripted_shooting");
  level._id_EAD6 = var_0;
}

_id_D283(var_0) {
  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(!scripts\sp\utility::_id_CFAC(var_2)) {
      return 0;
    }
  }

  return 1;
}

_id_B34F() {
  scripts\sp\utility::_id_F3B5("o");
}

_id_8E32() {
  scripts\sp\utility::_id_F3B5("r");
}

_id_10AD6() {
  thread scripts\sp\utility::_id_5131();
  self._id_1C78 = 0;
  self.dropweapon = 0;
}

_id_BC71(var_0, var_1) {
  if(isstring(var_0)) {
    var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");
  } else {
    var_2 = var_0;
  }

  if(!isDefined(var_1)) {
    var_1 = level._id_10AC8;
  }

  foreach(var_5, var_4 in var_1) {
    if(!isDefined(var_2[var_5].angles)) {
      var_2[var_5].angles = (0, 0, 0);
    }

    var_1[var_5] _meth_80F1(var_2[var_5].origin, var_2[var_5].angles);
  }
}

_id_7988(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = call[[level.getnodefunction]](var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  var_1 = getvehiclenode(var_0, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }
}

_id_BC52(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = var_1.origin;
  level.player dontinterpolate();
  level.player setOrigin(var_2, 1, 1);

  if(isDefined(var_1.angles)) {
    level.player setplayerangles(var_1.angles);
  }
}

_id_7C16(var_0, var_1, var_2) {
  var_3 = anglestoright(self.angles);

  if(isDefined(var_2)) {
    var_3 = var_3 * -1;
  }

  if(!isDefined(var_0)) {
    var_0 = self.origin;
  }

  return var_0 + var_3 * var_1;
}

_id_79D9(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_1);

  if(isDefined(var_2)) {
    var_3 = var_3 * -1;
  }

  var_4 = self.origin;
  return var_4 + var_3 * var_0;
}

_id_13798(var_0) {
  var_1 = "timeout_juke";
  level endon(var_1);
  thread _id_C0B9(var_1, var_0);
  _id_0BDC::_id_13797();
  return 1;
}

_id_C0B9(var_0, var_1) {
  wait(var_1);
  level notify(var_0);
}

_id_26E8(var_0) {
  for(;;) {
    var_1 = 0;

    if(!isDefined(var_0)) {
      var_0 = getaiarray("axis");
    }

    var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

    foreach(var_3 in var_0) {
      if(isDefined(var_3)) {
        if(var_3 istouching(self)) {
          var_1 = var_1 + 1;
        }
      }
    }

    return var_1;
  }
}

_id_22CE(var_0, var_1) {
  if(isstring(var_0)) {
    var_0 = getspawnerarray(var_0);
  }

  var_2 = scripts\sp\utility::_id_22C6(var_0, 1, 1);
  wait 0.05;

  while(var_2.size > var_1) {
    var_2 = scripts\sp\utility::array_removedeadvehicles(var_2);
    wait 1;
  }

  return;
}

_id_D802(var_0) {
  foreach(var_2 in var_0) {
    precachemodel(var_2);
  }
}

_id_D7FF(var_0) {
  foreach(var_2 in var_0) {
    precacheitem(var_2);
  }
}

_id_D801(var_0) {
  foreach(var_2 in var_0) {
    precacheshader(var_2);
  }
}

_id_D809(var_0) {
  foreach(var_2 in var_0) {
    precachestring(var_2);
  }
}

_id_EB25() {
  level endon("kill_sandstorm_trigs");
  self endon("deleted");

  for(;;) {
    self waittill("trigger");

    if(!_id_EB22()) {
      continue;
    }
    var_0 = scripts\engine\utility::get_target_ent();
    var_1 = var_0.origin - self.origin;
    var_2 = vectortoangles(var_1);
    var_3 = self.script_noteworthy;

    if(isDefined(level._id_EB1B)) {
      if(level._id_EB1B._id_FB2A == var_3 && level._id_EB1B.yaw == var_2[1]) {
        continue;
      }
    }

    thread _id_494B(var_3, var_2[1]);
    wait 1;
  }
}

_id_971F() {
  level._id_EB1B = spawnStruct();
  level._id_EB1B.enabled = 0;
  level._id_EB1B._id_FB2A = "";
  level._id_BFEF = getEntArray("no_fx", "targetname");
  level._id_BFDF = getEntArray("storm_audio_off", "targetname");
}

_id_6233() {
  level._id_EB1B.enabled = 1;
}

_id_557D() {
  level._id_EB1B.enabled = 0;
  level notify("stop_current_sandstorm");
  level notify("stop_sandstorm_audio_flyby");

  if(isDefined(level._id_EB1B._id_25A7)) {
    level._id_EB1B._id_25A7 delete();
  }

  if(isDefined(level._id_EB1B._id_25A9)) {
    level._id_EB1B._id_25A9 delete();
  }

  if(isDefined(level._id_EB1B._id_25A8)) {
    level._id_EB1B._id_25A8 delete();
  }

  level._id_B007 = undefined;
  level notify("stop_sandstorm_audio_lookat");

  if(isDefined(level.player._id_7601)) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_dust_wind_visor"), level.player._id_7601, "tag_origin");
    level.player._id_7601 delete();
  }
}

_id_EB22() {
  return level._id_EB1B.enabled == 1;
}

_id_494B(var_0, var_1) {
  if(!_id_EB22()) {
    return;
  }
  level notify("stop_current_sandstorm");
  level endon("stop_current_sandstorm");
  setdvarifuninitialized("sandstorm_debug", 0);
  level._id_EB1B._id_FB2A = var_0;
  var_2 = 1;
  var_3 = 1;
  var_4 = 2.5;
  var_5 = scripts\engine\utility::getfx("sandstorm_single_light");
  var_6 = "titan";
  var_7 = 1;

  if(!isDefined(var_1)) {
    level._id_EB1B.yaw = randomintrange(1, 330);
  } else {
    level._id_EB1B.yaw = var_1;
  }

  var_8 = anglesToForward((0, level._id_EB1B.yaw, 0));

  switch (var_0) {
    case "light":
      var_3 = 1.5;
      var_4 = 2.5;
      var_5 = scripts\engine\utility::getfx("sandstorm_single_light");
      var_2 = 2;
      var_6 = "titan_sandstorm_01";
      var_7 = 0.85;
      setaudiotriggerstate("default", "wind_light", 7);
      setaudiotriggerstate("titan_ext", "wind_light", 3);
      setaudiotriggerstate("indoorrooms", "wind_light", 3);
      break;
    case "medium":
      var_3 = 1;
      var_4 = 2;
      var_5 = scripts\engine\utility::getfx("sandstorm_single_medium");
      var_2 = 3;
      var_6 = "titan_sandstorm_02";
      var_7 = 1.35;
      setaudiotriggerstate("default", "wind_medium", 7);
      setaudiotriggerstate("titan_ext", "wind_medium", 3);
      setaudiotriggerstate("indoorrooms", "wind_medium", 3);
      break;
    case "heavy":
      var_3 = 0.1;
      var_4 = 0.25;
      var_5 = scripts\engine\utility::getfx("sandstorm_single_heavy");
      var_2 = 10;
      var_6 = "titan_sandstorm_03";
      var_7 = 2.35;
      setaudiotriggerstate("default", "wind_heavy", 7);
      setaudiotriggerstate("titan_ext", "wind_heavy", 3);
      setaudiotriggerstate("indoorrooms", "wind_heavy", 3);
      break;
    default:
      break;
  }

  thread _id_EB1D();
  thread _id_EB1F();
  thread _id_13D2E(var_7);

  while(level._id_EB1B.enabled) {
    var_9 = _id_772D(var_2);

    if(!var_9.size) {
      wait 0.05;
      continue;
    }

    foreach(var_11 in var_9) {
      thread _id_CDFE(var_5, var_11, var_8, anglestoup(level.player.angles));
      wait(randomfloatrange(0.05, 0.15));
    }

    if(randomint(100) <= 40) {
      _id_578D();
    }

    wait(randomfloatrange(var_3, var_4));
  }
}

_id_EB1F() {
  if(!_id_EB22()) {
    return;
  }
  if(isDefined(level._id_B007) && level._id_B007 == level._id_EB1B._id_FB2A) {
    return;
  }
  level._id_B007 = level._id_EB1B._id_FB2A;
  level notify("stop_sandstorm_audio_lookat");
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkTo(level.player);
  var_1 = spawn("script_origin", level.player.origin);
  var_1 linkTo(level.player);
  _id_EB20(var_0, var_1);
  var_0 _meth_8278(0.0, 0.5);
  var_1 _meth_8278(0.0, 0.5);
  wait 0.55;
  var_0 delete();
  var_1 delete();
}

_id_EB20(var_0, var_1) {
  level endon("stop_sandstorm_audio_lookat");

  if(level._id_EB1B._id_FB2A == "heavy") {
    var_2 = "emt_titan_wind_plr_facing_hvy";
    var_3 = "emt_titan_wind_plr_non_facing_hvy";
  } else if(level._id_EB1B._id_FB2A == "medium") {
    var_2 = "emt_titan_wind_plr_facing_med";
    var_3 = "emt_titan_wind_plr_non_facing_med";
  } else {
    var_2 = "emt_titan_wind_plr_facing_lt";
    var_3 = "emt_titan_wind_plr_non_facing_lt";
  }

  var_0 _meth_8278(0.0);
  var_1 _meth_8278(0.0);
  wait 0.05;
  var_0 playLoopSound(var_2);
  var_1 playLoopSound(var_3);
  var_4 = -1;
  var_5 = -2;

  for(;;) {
    var_6 = 0;

    foreach(var_8 in level._id_BFDF) {
      if(level.player istouching(var_8)) {
        var_6 = 1;
        break;
      }
    }

    if(var_6) {
      var_0 _meth_8278(0.0, 0.5);
      var_1 _meth_8278(0.0, 0.5);
      wait 0.5;
      continue;
    }

    var_10 = level._id_EB1B.yaw;

    if(var_10 > 180) {
      var_10 = 0 - (360 - var_10);
    }

    var_11 = abs(level.player.angles[1] - var_10);

    if(var_11 > 180) {
      var_11 = 360 - var_11;
    }

    if(var_11 >= 135) {
      var_5 = 1;

      if(var_5 != var_4) {
        var_4 = var_5;
        var_1 _meth_8278(0.0, 0.5);
        var_0 _meth_8278(1.0, 0.5);
      }
    } else if(var_11 > 45 && var_11 < 135) {
      var_5 = 2;

      if(var_5 != var_4) {
        var_4 = var_5;
        var_1 _meth_8278(0.5, 0.5);
        var_0 _meth_8278(0.5, 0.5);
      }
    } else {
      var_5 = 3;

      if(var_5 != var_4) {
        var_4 = var_5;
        var_1 _meth_8278(1.0, 0.5);
        var_0 _meth_8278(0.0, 0.5);
      }
    }

    wait 0.2;
  }
}

_id_EB1D() {
  if(!_id_EB22()) {
    return;
  }
  var_0 = 0;
  var_1 = 200;
  var_2 = -200;

  if(!isDefined(level._id_EB1B._id_25A7)) {
    level._id_EB1B._id_25A7 = spawn("script_origin", (0, 0, 0));
    var_0 = 0;
    level._id_EB1B._id_25A7 thread _id_EB1E(var_0);
  }

  if(!isDefined(level._id_EB1B._id_25A8)) {
    level._id_EB1B._id_25A8 = spawn("script_origin", (0, 0, 0));
    var_1 = 900;
    level._id_EB1B._id_25A8 thread _id_EB1E(var_1);
  }

  if(!isDefined(level._id_EB1B._id_25A9)) {
    level._id_EB1B._id_25A9 = spawn("script_origin", (0, 0, 0));
    var_2 = -900;
    level._id_EB1B._id_25A9 thread _id_EB1E(var_2);
  }
}

_id_EB1E(var_0) {
  level endon("stop_sandstorm_audio_flyby");

  for(;;) {
    var_1 = 0;

    if(!isDefined(level._id_EB1B.yaw) || !isDefined(level._id_EB1B._id_FB2A)) {
      wait 1;
      continue;
    }

    foreach(var_3 in level._id_BFDF) {
      if(level.player istouching(var_3)) {
        var_1 = 1;
        break;
      }
    }

    if(var_1) {
      wait 1;
      continue;
    }

    var_5 = 8;
    var_6 = 18;
    var_7 = 50;
    var_8 = 2000;
    var_9 = "single_windgust";
    var_10 = "emt_titan_wind_bft_mvr_lt";
    var_11 = "emt_titan_wind_debris_mvr_lt";

    switch (level._id_EB1B._id_FB2A) {
      case "light":
        var_5 = 2;
        var_6 = 4;
        var_7 = 10;
        var_8 = 2000;
        level._id_6FFB = "emt_titan_wind_bft_mvr_lt";
        level._id_6FFE = "emt_titan_wind_debris_mvr_lt";
        var_9 = "emt_titan_wind_gust_mvr_lt";
        break;
      case "medium":
        var_5 = 1;
        var_6 = 3;
        var_7 = 40;
        var_8 = 5400;
        level._id_6FFB = "emt_titan_wind_bft_mvr_med";
        level._id_6FFE = "emt_titan_wind_debris_mvr_med";
        var_9 = "emt_titan_wind_gust_mvr_med";
        break;
      case "heavy":
        var_5 = 2;
        var_6 = 4;
        var_7 = 17;
        var_8 = 2700;
        level._id_6FFB = "emt_titan_wind_bft_mvr_hvy";
        level._id_6FFE = "emt_titan_wind_debris_mvr_hvy";
        var_9 = "emt_titan_wind_gust_mvr_hvy";
        break;
      default:
        break;
    }

    var_12 = (0, level._id_EB1B.yaw, 0);
    var_13 = level.player _id_79D9(var_8 * 0.25, var_12, 1);
    var_14 = level.player _id_79D9(var_8 * 0.75, var_12);
    var_15 = scripts\sp\utility::_id_BD6B(var_7, var_8);

    if(_id_EB21()) {
      thread scripts\sp\utility::_id_5B4D(level.player, self, 1, 0, 0, var_15 + 0.1);
      thread _id_D8EA("AUDIO ENT", "movedone");
    }

    var_16 = 80;
    self.origin = var_13 + (0, var_0, var_16);
    thread scripts\sp\utility::play_sound_on_entity(var_9);
    thread scripts\engine\utility::play_loop_sound_on_entity(level._id_6FFB);
    thread scripts\engine\utility::play_loop_sound_on_entity(level._id_6FFE);
    self moveTo(var_14 + (0, var_0, 0), var_15);
    self waittill("movedone");
    self notify("stop sound" + level._id_6FFB);
    self notify("stop sound" + level._id_6FFE);
    wait(randomintrange(var_5, var_6));
  }
}

_id_D8EA(var_0, var_1) {
  self endon(var_1);

  for(;;) {
    wait 0.05;
  }
}

_id_CDFE(var_0, var_1, var_2, var_3) {
  if(!_id_EB22()) {
    return;
  }
  var_4 = spawn("script_origin", var_1);

  foreach(var_6 in level._id_BFEF) {
    if(var_4 istouching(var_6)) {
      if(_id_EB21()) {}

      var_4 delete();
      return;
    }
  }

  var_4 delete();

  if(_id_EB21()) {
    var_8 = var_1;
    var_9 = var_8 + var_2 * 60;
    thread scripts\engine\utility::draw_arrow_time(var_8, var_9, (0, 0, 1), 2);
  }

  if(isDefined(var_3)) {
    playFX(var_0, var_1, var_2, var_3);
  } else {
    playFX(var_0, var_1, var_2);
  }
}

_id_578D() {
  var_0 = randomintrange(300, 500);
  var_1 = level.player _id_79D9(var_0, level.player.angles);
  var_2 = bulletTrace(var_1 + (0, 0, 500), var_1, 0, undefined, 0, 0, 0, 0, 0);

  if(_id_EB21()) {}

  thread _id_CDFE(scripts\engine\utility::getfx("ground_gust"), var_2["position"], var_2["normal"], undefined);
}

_id_772D(var_0) {
  var_1 = [];

  if(var_0 > 3) {
    var_2 = -500;
    var_3 = 500;
  } else {
    var_2 = -100;
    var_3 = 100;
  }

  for(var_4 = 0; var_4 < var_0; var_4++) {
    var_5 = [];
    var_6 = randomintrange(100, 600);
    var_7 = randomintrange(250, 500);
    var_5[0] = level.player _id_79D9(var_6, level.player.angles);
    var_5[1] = level.player _id_7C16(var_5[0], var_7);
    var_5[2] = level.player _id_7C16(var_5[0], var_7, 1);
    var_1 = scripts\engine\utility::array_combine(var_1, var_5);
  }

  foreach(var_9 in var_1) {
    var_9 = var_9 + (0, 0, 60);
  }

  return var_1;
}

_id_EB21() {
  return getdvarint("sandstorm_debug") == 1;
}

_id_969D() {
  var_0 = getEntArray("trigger_multiple", "code_classname");
  var_1 = getEntArray("trigger_radius", "classname");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    if(!var_4 _id_9B43() && isDefined(var_4._id_ED9A)) {
      if(isDefined(var_4.targetname) && var_4.targetname == "jackal_landingzone") {
        continue;
      }
      thread scripts\sp\trigger::_id_1273F(var_4);

      if(isDefined(var_4.targetname)) {
        continue;
      }
    }
  }
}

_id_9B43() {
  var_0 = strtok(self.classname, "_");

  if(isDefined(var_0[2])) {
    if(var_0[2] == "flag") {
      return 1;
    }
  }

  return 0;
}

_id_BE42(var_0, var_1, var_2, var_3) {
  level endon(var_0);
  var_4 = scripts\engine\utility::array_randomize(var_3);

  while(!scripts\engine\utility::flag(var_0)) {
    foreach(var_6 in var_4) {
      if(soundexists(var_6)) {
        _id_134B7(var_6);
      }

      wait(randomintrange(var_1, var_2));
    }

    wait 0.15;
  }
}

_id_BE41(var_0, var_1, var_2, var_3) {
  self endon(var_0);
  var_4 = scripts\engine\utility::array_randomize(var_3);

  while(!scripts\sp\utility::_id_65DB(var_0)) {
    foreach(var_6 in var_4) {
      if(soundexists(var_6)) {
        _id_134B7(var_6);
      }

      wait(randomintrange(var_1, var_2));
    }

    wait 0.15;
  }
}

_id_8259() {
  self endon("death");
  self waittill("trigger");
  scripts\sp\utility::_id_EF15();

  if(isDefined(self._id_EDA0)) {
    scripts\engine\utility::flag_wait(self._id_EDA0);
  }

  var_0 = getEntArray(self.target, "targetname");
  var_1 = 1;

  foreach(var_3 in var_0) {
    if(!isspawner(var_3)) {
      continue;
    }
    if(isDefined(var_3.count)) {
      var_1 = var_3.count;
    }

    if(getdvarint("debug_geyser") == 1) {
      thread scripts\sp\utility::_id_5B4C(self.origin, var_3.origin, 0, 1, 0, 2);
    }

    thread _id_8258(var_3, var_1);
    wait 0.1;
  }
}

_id_8258(var_0, var_1) {
  if(isstring(var_0)) {
    var_2 = getEnt(var_0, "targetname");
  } else {
    var_2 = var_0;
  }

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_1) && isDefined(var_2.count)) {
    var_1 = var_2.count;
  }

  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++) {
    if(getdvarint("debug_geyser") == 1) {}

    var_2 scripts\sp\utility::script_delay();

    if(getdvarint("debug_geyser") == 1) {}

    var_5 = var_2 _id_0B77::_id_12799();

    if(!scripts\sp\utility::_id_106ED(var_5)) {
      var_3[var_3.size] = var_5;
    }

    wait 0.05;
  }

  if(var_3.size < var_1) {}

  return var_3;
}

_id_D85C() {
  level.player disableweapons();
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player _meth_84FE();
}

_id_DF3E() {
  level.player unlink();
  level.player scripts\engine\utility::allow_prone(1);

  if(isDefined(level.player.disabledcrouch) && level.player.disabledcrouch != 0) {
    level.player scripts\engine\utility::allow_crouch(1);
  }

  level.player enableweapons();
  level.player _meth_84FD();
}

_id_DF3D(var_0) {
  var_1 = 2;

  for(;;) {
    var_2 = level.player.origin + (0, 0, var_1);
    var_3 = level.player.origin;

    if(level.player scripts\common\trace::player_trace_passed(var_2, var_3, undefined, [level.player, var_0])) {
      break;
    } else
      var_0.origin = var_0.origin + (0, 0, var_1);

    wait 0.05;
  }

  _id_DF3E();
}

_id_58CC() {
  return getdvarint("bink_intro") == 1;
}

_id_C154(var_0, var_1) {
  _id_13784(var_0);
  level notify(var_1);
}

_id_13784(var_0) {
  while(var_0.size != 0) {
    foreach(var_2 in var_0) {
      if(scripts\engine\utility::array_contains(var_0, var_2) && isai(var_2) && !var_2 _meth_81A6()) {
        var_0 = scripts\engine\utility::array_remove(var_0, var_2);
      }
    }

    wait 0.05;
  }
}

_id_35D8(var_0) {
  if(!isDefined(level._id_11117)) {
    return;
  }
  if(isDefined(var_0)) {
    var_0 = squared(var_0);

    if(distancesquared(level.player.origin, level._id_11117.origin) > var_0) {
      return 0;
    }
  }

  var_1 = level.player getEye();

  foreach(var_3 in level._id_3508._id_B09D) {
    if(scripts\engine\utility::within_fov(var_1, level.player.angles, var_3.origin, 0.422618)) {
      if(sighttracepassed(var_1, var_3.origin, 1, level.player, level._id_3508._id_4D27)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_3550(var_0, var_1) {
  _id_0A05::_id_3555(var_0, var_1);
}

_id_3558(var_0, var_1) {
  self.goalradius = 750;
  var_2 = scripts\engine\utility::getStruct("c12fight_center", "targetname");
  self setgoalpos(getclosestpointonnavmesh(var_2.origin, self));
  _id_3550("left", 1);
  _id_0A05::_id_3551(1);
  _id_0A05::_id_3552(0);
  self.favoriteenemy = level.player;
}

_id_3633(var_0) {
  if(var_0.size <= 0) {
    return undefined;
  }

  foreach(var_2 in var_0) {
    if(!level.player istouching(var_2)) {
      continue;
    }
    if(!isDefined(var_2.target)) {
      continue;
    }
    var_3 = scripts\engine\utility::getStructArray(var_2.target, "targetname");
    var_4 = scripts\engine\utility::getclosest(level.player.origin, var_3);

    if(isDefined(var_4)) {
      return var_4.origin;
    }
  }

  return undefined;
}

_id_2434(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_2429._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_2429 scripts\sp\utility::_id_10346(var_0);
  } else {
    thread scripts\sp\utility::_id_16C5("Atom", var_0);
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_2429._id_58D2 = undefined;
  }
}

_id_C48A(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_C47F._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_C47F scripts\sp\utility::_id_10346(var_0);
  } else {
    thread scripts\sp\utility::_id_16C5("Omar", var_0);
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_C47F._id_58D2 = undefined;
  }
}

_id_C24D(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_C24B._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_C24B scripts\sp\utility::_id_10346(var_0);
    wait 0.15;
  } else {
    thread scripts\sp\utility::_id_16C5("Nunez", var_0);
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_C24B._id_58D2 = undefined;
  }
}

_id_30FC(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_B33B._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_B33B scripts\sp\utility::_id_10346(var_0);
    wait 0.15;
  } else {
    thread scripts\sp\utility::_id_16C5("Brooks", var_0);
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_B33B._id_58D2 = undefined;
  }
}

_id_A556(var_0, var_1) {
  if(isDefined(var_1)) {
    level._id_B33E._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    level._id_B33E scripts\sp\utility::_id_10346(var_0);
  } else {
    thread scripts\sp\utility::_id_16C5("Kashima", var_0);
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    level._id_B33E._id_58D2 = undefined;
  }
}

_id_EAB8(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(level._id_EA2C)) {
    var_3 = level._id_EA2C;
  } else if(isDefined(level._id_EAD6)) {
    var_3 = level._id_EAD6;
  } else {
    var_3 = level.player;
  }

  if(isDefined(var_1)) {
    var_3._id_58D2 = 1;
    var_1 = 1;
  } else
    var_1 = 0.1;

  if(soundexists(var_0)) {
    if(isDefined(var_3) && isai(var_3)) {
      var_3 scripts\sp\utility::_id_10346(var_0);
    } else if(isDefined(var_3) && var_3 scripts\sp\vehicle::_id_9FEF()) {
      var_3 scripts\sp\utility::_id_10347(var_0);
    } else {
      var_3 scripts\sp\utility::_id_10347(var_0);
    }

    wait 0.15;
  } else if(isDefined(var_2))
    wait(var_2);
  else {
    wait 2;
  }

  if(isDefined(var_1) && var_1 == 1) {
    var_3._id_58D2 = undefined;
  }
}

_id_2081(var_0) {
  if(soundexists(var_0)) {
    while(isDefined(level._id_2066)) {
      wait 0.15;
    }

    level._id_2066 = 1;
    level.player scripts\sp\utility::play_sound_on_entity(var_0);
    wait 0.15;
    level._id_2066 = undefined;
  } else {
    thread scripts\sp\utility::_id_16C5("APC Driver", var_0);
    wait 2;
  }
}

_id_D1D5(var_0, var_1) {
  if(isDefined(var_1)) {
    level.player._id_58D2 = 1;
  }

  if(soundexists(var_0)) {
    if(isDefined(level._id_D127)) {
      level._id_D127 scripts\sp\utility::_id_10347(var_0);
    } else {
      level.player scripts\sp\utility::_id_10347(var_0);
    }

    wait 0.15;
  } else {
    thread scripts\sp\utility::_id_16C5("Reese", var_0);
    wait 2;
  }

  if(isDefined(var_1)) {
    level.player._id_58D2 = undefined;
  }
}

_id_48BD(var_0) {
  foreach(var_3, var_2 in var_0) {
    _id_134B7(var_2);
  }
}

_id_4601() {
  for(;;) {
    self waittill("trigger", var_0);

    if(distance(self.origin, level.player.origin) > 4000) {
      wait 1;
      continue;
    }

    if(isDefined(self.spawnflags)) {
      if(self.spawnflags == 2 && var_0 == level.player) {
        wait 1;
        continue;
      }
    }

    switch (self.script_noteworthy) {
      case "1_7":
        _id_134B7("titan_ksh_commsignals");
        _id_134B7("titan_brk_lookslikehome");
        level._id_B33B thread _id_1958(level._id_C47F);
        level._id_C47F thread _id_1958(level._id_B33B);
        wait 0.1;
        level._id_C47F thread _id_0C4C::_id_1964(0.5);
        level._id_B33B _id_0C4C::_id_1964(0.5);
        _id_134B7("titan_atm_wasnthalfbad");
        _id_134B7("titan_usf_tookaboatride");
        _id_134B7("titan_brk_seenbetterdays");
        _id_134B7("titan_atm_whydidyourdad");
        _id_134B7("titan_usf_makeabetterlife");
        _id_134B7("titan_atm_didhefight");
        _id_134B7("titan_plr_leavethesergeant");
        _id_134B7("titan_usf_idontmind");
        _id_134B7("titan_usf_32ndarmored");
        _id_134B7("titan_ksh_victoryordeath");
        _id_134B7("titan_usf_survivedtwo");
        _id_134B7("titan_plr_appledidntfall");
        _id_134B7("titan_brk_32ndwasarmy");
        _id_134B7("titan_usf_fellfarenough");
        return;
      case "1_11":
        if(_id_9BF6()) {
          return;
        }
        return;
      case "18_28":
        _id_134B7("titan_slt_headright");
        return;
      default:
        return;
    }
  }
}

_id_134B7(var_0, var_1) {
  if(!soundexists(var_0)) {
    wait 1.5;
    return;
  }

  var_2 = strtok(var_0, "_");

  switch (var_2[1]) {
    case "usf":
    case "omr":
      if(!isDefined(level._id_C47F)) {
        break;
      }

      if(scripts\engine\utility::flag("stealth_spotted")) {
        return;
      }
      _id_C48A(var_0, var_1);
      return;
    case "ksh":
      if(!isDefined(level._id_B33E)) {
        break;
      }

      _id_A556(var_0, var_1);
      return;
    case "atm":
    case "eth":
      if(!isDefined(level._id_2429)) {
        break;
      }

      if(scripts\engine\utility::flag("stealth_spotted")) {
        return;
      }
      _id_2434(var_0, var_1);
      return;
    case "plr":
      _id_D1D5(var_0, var_1);
      return;
    case "brks":
    case "brk":
      if(!isDefined(level._id_B33B)) {
        break;
      }

      _id_30FC(var_0, var_1);
      return;
    case "slt":
      if(!isDefined(level._id_EAD6)) {
        if(!isDefined(level._id_EA2C)) {
          break;
        }
      }

      _id_EAB8(var_0, var_1);
      return;
    default:
      level.player _id_D1D5(var_0, var_1);
      return;
  }

  level.player _id_D1D5(var_0, var_1);
}

_id_D250(var_0) {
  level.player notify("stop_player_rain");
  level.player endon("stop_player_rain");

  if(!level.player scripts\sp\utility::_id_65DF("player_rain")) {
    level.player scripts\sp\utility::_id_65E0("player_rain");
  }

  level.player scripts\sp\utility::_id_65E1("player_rain");
  level.player._id_DC2E = undefined;
  var_1 = undefined;

  if(var_0 == 1) {
    level.player._id_DC2E = "vfx_rain_player_attached_light";
    setglobalsoundcontext("rain", "light", 7.0);
    var_1 = 0.75;
  }

  if(var_0 == 2) {
    level.player._id_DC2E = "vfx_rain_player_attached_medium";
    setglobalsoundcontext("rain", "medium", 3.0);
    var_1 = 0.5;
  }

  if(var_0 == 3) {
    level.player._id_DC2E = "vfx_rain_player_attached_heavy";
    setglobalsoundcontext("rain", "heavy", 3.0);
    var_1 = 0.45;
  }

  if(var_0 == 4) {
    level.player._id_DC2E = "vfx_rain_player_attached_torrential";
    setglobalsoundcontext("rain", "heavy", 3.0);
    var_1 = 0.45;
  }

  for(;;) {
    playFX(scripts\engine\utility::getfx(level.player._id_DC2E), level.player.origin);
    wait 0.35;
  }
}

_id_D24F() {
  level.player notify("stop_player_rain");
  level.player scripts\sp\utility::_id_65DD("player_rain");
  setglobalsoundcontext("rain", "", 3.0);
}

_id_10169(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_0; var_3++) {
    var_1 = scripts\engine\utility::array_randomize(var_1);
  }

  return scripts\engine\utility::random(var_1);
}

_id_11619(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = 200;
  }

  var_4 = anglesToForward(var_1.angles);
  var_4 = var_4 * -1;
  var_5 = var_1.origin + var_4 * var_3;
  var_0 _meth_80F1(var_5, var_1.angles, 10000);
}

_id_12D90(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "titan":
      var_2 = 0;
      break;
    case "titan_medium_fog":
      var_2 = 1;
      break;
    case "titan_heavy_fog":
      var_2 = 2;
      break;
    case "titan_stealth2":
      var_2 = 3;
      break;
    case "titan_chasm":
      var_2 = 4;
      break;
    case "titan_jackal":
      var_2 = 5;
      break;
  }

  if(!isDefined(var_1)) {
    var_1 = 3;
  }

  visionsetalternate(var_2, var_1);
  level._id_4BCF = "" + var_2 + " : " + var_0;
  wait(var_1);
}

#using_animtree("destructibles");

_id_13D2D() {
  if(!isDefined(level._id_13D2C)) {
    level._id_13D2C = getEntArray("wind_turbine", "targetname");
  }

  var_0 = 1;

  foreach(var_2 in level._id_13D2C) {
    var_2._id_1FBB = "wind_turbine";
    var_2 scripts\sp\utility::_id_23B7();
    var_2 _meth_82A2(%tag_rotate_z, 1, 0.02, var_0);
    var_2._id_1F09 = var_0;
    var_2 playLoopSound("emt_titan_turbine");
  }
}

_id_13D2E(var_0) {
  scripts\engine\utility::array_thread(level._id_13D2C, ::_id_13D2F, var_0);
}

_id_13D2F(var_0) {
  while(isDefined(self._id_9C35)) {
    wait 0.05;
  }

  self._id_65F6 = self getentitynumber();
  self._id_9C35 = 1;
  self notify("new_rate");
  var_1 = _id_77EF(var_0);
  self _meth_8460("turbine", var_1, 3);
  var_2 = randomfloatrange(0.75, 1.15);
  var_0 = var_0 * var_2;
  _id_13D2B(var_0);
  self._id_1F09 = var_0;
  self._id_9C35 = undefined;
}

_id_77EF(var_0) {
  var_1 = undefined;

  if(var_0 == 0.85) {
    var_1 = "slow";
  } else if(var_0 == 1.35) {
    var_1 = "medium";
  } else if(var_0 == 2.35) {
    var_1 = "fast";
  }

  return var_1;
}

_id_13D2B(var_0) {
  if(self._id_1F09 == var_0) {
    return;
  }
  wait(randomfloatrange(0.1, 0.6));
  var_1 = 60;
  var_2 = var_0 / var_1;
  var_3 = self._id_1F09;
  var_4 = var_3;

  for(var_5 = 0; var_5 < var_1; var_5++) {
    if(var_3 > var_0) {
      var_4 = var_4 - var_2;
    } else if(var_3 < var_0) {
      var_4 = var_4 + var_2;
    } else if(var_3 == var_0) {
      break;
    }

    self _meth_82B1(%tag_rotate_z, var_4);
    var_3 = var_4;
    wait 0.05;
  }
}

_id_65EC(var_0, var_1, var_2) {
  if(distance2dsquared(var_0.origin, var_1.origin) <= var_2 * var_2) {
    return 1;
  }

  return 0;
}

_id_F40C(var_0, var_1) {
  scripts\sp\utility::_id_F40A(var_0, var_1, 0);
  self waittill("death");

  if(isDefined(self)) {
    self hudoutlinedisable();
  }
}

_id_DEE4(var_0, var_1, var_2) {
  if(!isDefined(level._id_157F[var_0])) {
    level._id_157F[var_0] = [];
  }

  var_3 = spawnStruct();
  var_3._id_2AD1 = var_1;
  var_3._id_8FE1 = var_2;
  var_3._id_A5A1 = undefined;
  var_3._id_9028 = undefined;
  precachestring(var_2);
  level._id_157F[var_0][level._id_157F[var_0].size] = var_3;
}

_id_7D93(var_0) {
  for(var_1 = 0; var_1 < level._id_157F[var_0].size; var_1++) {
    var_2 = level._id_157F[var_0][var_1];
    var_3 = getkeybinding(var_2._id_2AD1);

    if(!var_3["count"]) {
      continue;
    }
    return level._id_157F[var_0][var_1];
  }

  return level._id_157F[var_0][0];
}

_id_9BF6() {
  if(getdvarint("greenlight") == 1) {
    return 1;
  } else {
    return 0;
  }
}

_id_4EF9() {}

_id_B69F() {
  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0._id_CD96)) {
      continue;
    }
    var_0._id_CD96 = 1;
    var_0 thread _id_B69E();
    scripts\engine\utility::waitframe();
  }
}

_id_B69E() {
  self endon("death");
  self waittill("double_jump_finished");
  self._id_CD96 = undefined;
  var_0 = playFXOnTag(scripts\engine\utility::getfx("vfx_methane_pool_splash"), self, "tag_origin");
}

_id_10F25(var_0) {
  var_1 = _id_0F27::_id_79F5(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  if(isDefined(var_1) && !var_1.size) {
    return;
  }
  foreach(var_3 in var_1) {
    var_3 thread _id_10F30();
  }
}

_id_10F31(var_0) {
  var_0.count = 1;
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1 thread _id_10F30();
}

_id_10F30() {
  self endon("death");
  scripts\sp\utility::_id_D282();

  for(;;) {
    wait(randomfloatrange(3, 6));

    if(scripts\engine\utility::cointoss() && level._id_F10A._id_1633.size <= 1) {
      scripts\sp\maps\titan\titan_stealth_street::_id_107D3();
    }
  }
}

_id_119A0() {
  self waittill("trigger", var_0);

  if(scripts\engine\utility::flag("stealth_spotted")) {
    return;
  }
  var_1 = [];
  var_2 = 500;
  var_3 = getaiarray("axis");

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_1B44) && var_5 _id_9B55()) {
      var_1 = scripts\engine\utility::array_add(var_1, var_5);
    }
  }

  foreach(var_5 in var_1) {
    if(distance(var_5.origin, level.player.origin) > var_2) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_5);
    }
  }

  if(var_1.size > 0) {
    thread scripts\sp\utility::_id_2679();
  } else {
    thread scripts\sp\utility::_id_266F();
  }
}

_id_9B55() {
  if(self._id_1B44 == "warning1" || self._id_1B44 == "warning2") {
    return 1;
  } else {
    return 0;
  }
}