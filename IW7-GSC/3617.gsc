/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3617.gsc
**************************************/

_id_9527() {
  precacheitem("antigrav");
  precachemodel("anti_grav_border_wm");
  level._effect["antigrav_detonate_dud"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_detonate_dud.vfx");
  level._effect["antigrav_caltrop_trail"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_trail.vfx");
  level._effect["antigrav_detonate"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_detonate.vfx");
  level._effect["antigrav_detonate_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_detonate_cheap.vfx");
  level._effect["antigrav_caltrop_barrier"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_caltrop_barrier.vfx");
  level._effect["antigrav_caltrop_barrier_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_caltrop_barrier_cheap.vfx");
  level._effect["antigrav_area_small"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_area_small.vfx");
  level._effect["antigrav_area_small_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_area_small_cheap.vfx");
  level._effect["antigrav_detonate_up"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_detonate_upgrade.vfx");
  level._effect["antigrav_detonate_up_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_detonate_upgrade_cheap.vfx");
  level._effect["antigrav_caltrop_barrier_up"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_caltrop_barrier_upgrade.vfx");
  level._effect["antigrav_caltrop_barrier_up_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_caltrop_barrier_upgrade_cheap.vfx");
  level._effect["antigrav_area_small_up"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_area_small_upgrade.vfx");
  level._effect["antigrav_area_small_up_cheap"] = loadfx("vfx/iw7/_requests/equipment/antigrav/antigrav_gren_area_small_upgrade_cheap.vfx");
  scripts\engine\utility::flag_init("antigrav_force_delete");
  level.player._id_D363 = [];
  level.player thread _id_D0EB();
  level thread _id_365A();
  level._id_2006 = spawnStruct();
  level._id_2006._id_A8C6 = undefined;
  level._id_2006._id_522B = [];
}

_id_2013(var_0) {
  var_1 = self;
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0.origin;
  var_2.grenade = var_0;
  var_2 linkTo(var_2.grenade);
  level._id_2006._id_522B[level._id_2006._id_522B.size] = var_2;
  var_3 = var_2.grenade _id_201A();

  if(!isDefined(var_2.grenade)) {
    var_2 thread _id_DFC5();
    return;
  }

  var_2 _id_E057();
  var_2._id_85D2 = var_1 _id_1294();
  var_2._id_5F36 = var_1 _id_1293();
  var_2._id_112DF = var_3;

  if(isDefined(var_1) && isDefined(var_1._id_202A) && var_1._id_202A == 1) {
    var_2._id_5F37 = 1;
  } else {
    var_2._id_5F37 = 0;
  }

  if(isDefined(var_1) && isDefined(level.player) && var_1 == level.player) {
    var_2._id_D43A = 1;
  } else {
    var_2._id_D43A = 0;
  }

  var_2 thread _id_200F();
}

_id_201A() {
  self endon("entitydeleted");
  self endon("death");
  self waittill("missile_stuck", var_0, var_1, var_2);
  return var_2;
}

_id_FF4F(var_0, var_1) {
  if(var_0 scripts\sp\utility::isactorwallrunning()) {
    return 0;
  }

  if(_id_3CB0(var_0, var_1)) {
    if(isDefined(var_0._id_1C78)) {
      return var_0._id_1C78;
    }

    if(var_0 _meth_81A6()) {
      return 0;
    }

    return 1;
  }

  return 0;
}

_id_200B() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = self.origin;
  level._id_2006._id_522B[level._id_2006._id_522B.size] = var_0;
  var_0._id_85D2 = 156;
  var_0._id_5F36 = 7.0;
  var_0 thread _id_200F();
}

_id_2017() {
  self _meth_824E("gravity_explode_default", self._id_112DF);
}

_id_200F() {
  if(!isDefined(self._id_5F37)) {
    self._id_5F37 = 0;
  }

  if(!isDefined(self._id_112DF)) {
    self._id_112DF = "default";
  }

  self.angles = (0, 0, 0);
  self._id_132AA = [];
  thread _id_2017();

  if(!self._id_5F37) {
    if(level._id_2006._id_522B.size > 1) {
      var_0 = "antigrav_detonate_cheap";
    } else {
      var_0 = "antigrav_detonate";
    }
  } else if(level._id_2006._id_522B.size > 1)
    var_0 = "antigrav_detonate_up_cheap";
  else {
    var_0 = "antigrav_detonate_up";
  }

  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_1 = spawnfx(level._effect[var_0], self.origin, (1, 0, 0), (0, 0, 1));
    triggerfx(var_1);
    self._id_132AA[self._id_132AA.size] = var_1;
  } else
    playFX(level._effect[var_0], self.origin, (1, 0, 0), (0, 0, 1));

  _id_36E1();
  _id_1066C();
  _id_0F18::_id_10E8A("broadcast", "attack", self.origin, 1000);
  level scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", 0.55);
  var_2 = [];

  foreach(var_4 in getaiarray()) {
    if(_id_FF4F(var_4, self)) {
      var_2[var_2.size] = var_4;
    }
  }

  thread scripts\engine\utility::play_loop_sound_on_entity("gravity_field_lp");
  self._id_CB13 = _id_4933();
  var_6 = 0;
  var_7 = 0;

  foreach(var_9 in self._id_378E) {
    if(var_9._id_5F15 == 1) {
      continue;
    }
    if(self.origin[2] - var_9.origin[2] > var_6) {
      var_6 = self.origin[2] - var_9.origin[2];
    }

    if(var_9.origin[2] - self.origin[2] > var_7) {
      var_7 = var_9.origin[2] - self.origin[2];
    }
  }

  var_11 = self.origin[2] - var_6 - 24;
  var_12 = self.origin[2] + var_7 + 72;
  var_13 = (var_12 + var_11) * 0.5;

  if(var_13 < self.origin[2]) {
    var_14 = self.origin;
    var_15 = self.origin[2] - var_11;
  } else {
    var_14 = (self.origin[0], self.origin[1], var_13);
    var_15 = (var_12 - var_11) * 0.5;
  }

  _id_4926(var_14, var_15);
  scripts\engine\utility::array_thread(var_2, ::_id_197D, self);
  _id_CF45();
  thread _id_FB3E();
  level scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", self._id_5F36);
  thread _id_DFC5();
}

_id_4926(var_0, var_1) {
  var_2 = ["axis", "allies", "team3", "neutral", "bad_guys"];

  if(!isDefined(level._id_2006._id_5602) || level._id_2006._id_5602.size == 0) {
    self._id_C2CA = _func_315(var_0, (self._id_85D2, self._id_85D2, var_1), (0, 0, 0));
    createnavrepulsor("antigrav" + self getentitynumber(), -1, var_0, self._id_85D2, 1);
  } else if(level._id_2006._id_5602.size > 0) {
    if(level._id_2006._id_5602[0] == "all") {
      return;
    }
    if(scripts\engine\utility::array_contains(level._id_2006._id_5602, "allies") && scripts\engine\utility::array_contains(level._id_2006._id_5602, "axis")) {
      self._id_C2CA = _func_315(var_0, (self._id_85D2, self._id_85D2, var_1), (0, 0, 0), "team3", "neutral", "bad_guys");
      createnavrepulsor("antigrav" + self getentitynumber(), -1, var_0, self._id_85D2, 0, "team3", "neutral", "bad_guys");
    } else if(scripts\engine\utility::array_contains(level._id_2006._id_5602, "allies")) {
      self._id_C2CA = _func_315(var_0, (self._id_85D2, self._id_85D2, var_1), (0, 0, 0), "axis", "team3", "neutral", "bad_guys");
      createnavrepulsor("antigrav" + self getentitynumber(), -1, var_0, self._id_85D2, 0, "team3", "neutral", "bad_guys");
    } else if(scripts\engine\utility::array_contains(level._id_2006._id_5602, "axis")) {
      self._id_C2CA = _func_315(var_0, (self._id_85D2, self._id_85D2, var_1), (0, 0, 0), "allies", "team3", "neutral", "bad_guys");
      createnavrepulsor("antigrav" + self getentitynumber(), -1, var_0, self._id_85D2, 0, "team3", "neutral", "bad_guys");
    } else {}
  }
}

_id_FB3E() {
  level scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", self._id_5F36 - 0.4);

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.grenade)) {
    thread scripts\sp\utility::play_sound_on_entity("gravity_field_off");
  }

  thread scripts\engine\utility::stop_loop_sound_on_entity("gravity_field_lp");
}

_id_DFC5() {
  if(!isDefined(self)) {
    return;
  }
  level notify("antigrav_done");
  thread _id_E057();

  if(scripts\engine\utility::flag("antigrav_force_delete")) {
    scripts\engine\utility::waitframe();
  }

  thread scripts\engine\utility::stop_loop_sound_on_entity("gravity_field_lp");

  if(isDefined(self.new)) {
    _id_D25C();
  }

  if(isDefined(self._id_CB13)) {
    _id_52B3(self._id_CB13);
  }

  if(isDefined(self._id_C2CA)) {
    destroynavobstacle(self._id_C2CA);
    destroynavrepulsor("antigrav" + self getentitynumber());
  }

  if(isDefined(self._id_132AA)) {
    foreach(var_1 in self._id_132AA) {
      var_1 delete();
    }
  }

  if(isDefined(self._id_378D)) {
    var_3 = self._id_378D;

    foreach(var_5 in var_3) {
      _id_DFC4(var_5);
    }
  }

  level._id_2006._id_522B = scripts\engine\utility::array_remove(level._id_2006._id_522B, self);
  self delete();
}

_id_E057() {
  if(isDefined(self.grenade)) {
    level._id_2006._id_A8C6 = self.grenade.origin;
    self unlink();
    self.grenade delete();
  }
}

_id_DFC4(var_0) {
  if(isDefined(var_0._id_132AA)) {
    foreach(var_2 in var_0._id_132AA) {
      var_2 delete();
    }
  }

  killfxontag(level._effect["antigrav_caltrop_trail"], var_0, "tag_origin");
  self._id_378D = scripts\engine\utility::array_remove(self._id_378D, var_0);
  var_0 delete();
}

_id_DFBA() {
  level notify("removing_all_antigravs_instantly");
  level endon("removing_all_antigravs_instantly");
  scripts\engine\utility::flag_set("antigrav_force_delete");

  foreach(var_1 in level._id_2006._id_522B) {
    var_1 thread _id_E057();
  }

  for(;;) {
    if(level._id_2006._id_522B.size > 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_clear("antigrav_force_delete");
}

_id_197D(var_0) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.a) && isDefined(self.a._id_58DA)) {
    self _meth_81D0();
  } else {
    if(self.unittype == "c12") {
      return;
    }
    if(scripts\asm\asm_bb::bb_isanimScripted()) {
      self _meth_83A1();
    }

    if(!isDefined(self._id_2023)) {
      _id_1978(var_0);
      scripts\asm\asm::asm_setstate("antigrav_rise");
    } else if(self._id_2023 == "rise" || self._id_2023 == "float_idle")
      self._id_201D = gettime() + (var_0._id_5F36 + randomfloat(0.25)) * 1000.0;
    else {
      if(self._id_2023 == "fall") {
        self._id_201D = gettime() + (var_0._id_5F36 + randomfloat(0.25)) * 1000.0;
        self._id_2020 = 1;
        return;
      }

      _id_1978(var_0);
      self._id_2020 = 1;
    }
  }
}

_id_1978(var_0) {
  self._id_2022 = gettime();
  self._id_201D = self._id_2022 + (var_0._id_5F36 + randomfloat(0.25)) * 1000.0;
}

_id_CF45() {
  self.new = 1;
  level.player._id_D363[level.player._id_D363.size] = self;
  level.player notify("new_antigrav_gren_active");
  thread _id_CF46();
}

_id_CF46() {
  scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", 0.1);
  self.new = 0;
}

_id_D25C() {
  level.player._id_D363 = scripts\engine\utility::array_remove(level.player._id_D363, self);
  level.player notify("removed_antigrav_gren");
}

_id_365A() {
  for(;;) {
    waittillframeend;
    level.player._id_D363 = scripts\engine\utility::array_removeundefined(level.player._id_D363);
    var_0 = getaiunittypearray("all", "C12");

    foreach(var_2 in var_0) {
      if(!isalive(var_2)) {
        continue;
      }
      if(!isDefined(var_2._id_93B5)) {
        var_2._id_93B5 = 0;
      }

      var_3 = 0;

      foreach(var_5 in level.player._id_D363) {
        if(_id_3CB0(var_2, var_5)) {
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        if(!var_2._id_93B5) {
          var_2._id_2015 = var_2.moveplaybackrate;
          var_2.moveplaybackrate = 0.2;
          var_2._id_93B5 = 1;
        }

        continue;
      }

      if(var_2._id_93B5) {
        var_2.moveplaybackrate = var_2._id_2015;
        var_2._id_2015 = undefined;
        var_2._id_93B5 = 0;
      }
    }

    wait 0.05;
  }
}

_id_D0EB() {
  self endon("death");
  self._id_93B5 = 0;

  for(;;) {
    waittillframeend;
    level.player._id_D363 = scripts\engine\utility::array_removeundefined(level.player._id_D363);

    if(self._id_D363.size == 0) {
      if(self._id_93B5) {
        _id_5567();
        self._id_93B5 = 0;
      }

      self waittill("new_antigrav_gren_active");
    }

    var_0 = 0;
    var_1 = 0;
    self._id_4B16 = undefined;

    if(!level.player scripts\sp\utility::_id_65DF("disable_antigrav_float") || !level.player scripts\sp\utility::_id_65DB("disable_antigrav_float")) {
      foreach(var_3 in self._id_D363) {
        if(_id_3CB0(self, var_3)) {
          var_0 = 1;
          self._id_4B16 = var_3;

          if(var_3.new == 1) {
            var_1 = 1;
          }
        }
      }
    }

    if(!self._id_93B5 && var_0) {
      thread _id_6228();
      self._id_93B5 = 1;
    } else if(self._id_93B5 && !var_0) {
      thread _id_5567();
      self._id_93B5 = 0;
    }

    wait 0.05;
  }
}

_id_6228() {
  level.player notify("enable_player_antigrav_gren");
  level.player endon("disable_player_antigrav_gren");

  if(!isDefined(level.player._id_2028)) {
    _id_0E4F::_id_9755();
    level.player._id_2028 = 1;
    level.player._id_2024 = level.player getstance();

    if(level.player._id_2024 == "crouch") {
      setsaveddvar("player_spaceViewHeight", 40);
      setsaveddvar("player_spaceCapsuleHeight", 50);
    } else if(level.player._id_2024 == "prone") {
      setsaveddvar("player_spaceViewHeight", 11);
      setsaveddvar("player_spaceCapsuleHeight", 30);
    } else {
      setsaveddvar("player_spaceViewHeight", 60);
      setsaveddvar("player_spaceCapsuleHeight", 70);
    }
  }

  level.player scripts\engine\utility::allow_usability(0);
  level.player._id_C37D = getdvarint("player_death_animated", 1);
  setDvar("player_death_animated", 0);

  if(level.player scripts\sp\utility::_id_65DB("player_space_override_off")) {
    return;
  }
  if(level.player scripts\sp\utility::_id_9F59()) {
    level.player notify("cancel_sliding");
    level.player scripts\sp\utility::_id_6389();
  }

  if(level.player isonground()) {
    level.player playgestureviewmodel("ges_antigrav_reaction");
    level.player.playing_terrorist_respawn_music = 1;
    thread _id_CF65();
  } else {
    level.player playgestureviewmodel("ges_antigrav_reaction");
    level.player.playing_terrorist_respawn_music = 1;
    thread _id_CF65();
  }

  level.player.space._id_6F43 = 1;
  level.player scripts\sp\utility::_id_65E1("player_gravity_off");
  level.player thread _id_CF64();
  level.player thread _id_CF67();
}

_id_5567() {
  level.player notify("disable_player_antigrav_gren");

  if(level.player scripts\sp\utility::_id_65DF("player_gravity_off")) {
    level.player scripts\sp\utility::_id_65DD("player_gravity_off");
  }

  level.player.playing_terrorist_respawn_music = undefined;
  level.player scripts\engine\utility::allow_usability(1);
  setDvar("player_death_animated", level.player._id_C37D);
  level.player._id_C37D = undefined;
  thread _id_5568();
}

_id_5568() {
  level.player endon("enable_player_antigrav_gren");

  for(;;) {
    if(getdvarint("player_spaceEnabled") == 0) {
      break;
    }

    wait 0.05;
  }

  for(;;) {
    level.player setstance(level.player._id_2024);

    if(level.player getstance() == level.player._id_2024) {
      break;
    }

    wait 0.05;
  }

  level.player._id_2028 = undefined;
}

_id_CF64() {
  self endon("death");
  self notify("crawlmeleegrab_antigrav");
  waittillframeend;
  self.space._id_6F43 = 1;
  self _meth_80D8(0.8, 0.8);
  _id_0E4F::_id_6251();
  _id_0E4F::_id_621C();

  while(_id_0E4F::_id_9C7B()) {
    if(!isDefined(self._id_4B16)) {
      break;
    }

    if(!level.player.playing_terrorist_respawn_music) {
      level.player playgestureviewmodel("ges_antigrav_idle");
    }

    var_0 = level.player.origin[2] - self._id_4B16.origin[2];
    var_1 = clamp((100 - var_0) / 100, 0.0, 1.0);
    var_2 = 50 * var_1;
    var_3 = self getvelocity();
    var_4 = (0, 0, 1);
    var_5 = var_3 + var_4 * var_2;
    self setvelocity(var_5);
    wait 0.05;
  }

  level.player stopgestureviewmodel("ges_antigrav_reaction");
  level.player stopgestureviewmodel("ges_antigrav_idle");
  _id_0E4F::_id_40A6();

  if(isDefined(level.player._id_9BF5)) {
    while(level.player._id_9BF5 == 1) {
      scripts\engine\utility::waitframe();
    }
  }
}

_id_CF65() {
  thread _id_CF66();
  self endon("antigrav_reaction_think_timeout");
  self endon("death");

  for(;;) {
    level.player waittill("gesture_stopped", var_0);

    if(var_0 == "ges_antigrav_reaction") {
      break;
    }
  }

  if(isDefined(self.playing_terrorist_respawn_music)) {
    self.playing_terrorist_respawn_music = 0;
  }
}

_id_CF66() {
  self endon("death");
  wait 5;
  self notify("antigrav_reaction_think_timeout");

  if(isDefined(self.playing_terrorist_respawn_music)) {
    self.playing_terrorist_respawn_music = 0;
  }
}

_id_CF67() {
  level.player endon("death");
  level.player endon("disable_player_antigrav_gren");

  for(;;) {
    level waittill("ai_killed", var_0, var_1);

    if(isDefined(level.player._id_4B16) && isDefined(level.player._id_4B16._id_D43A) && level.player._id_4B16._id_D43A == 1) {
      if(isDefined(var_0) && isDefined(var_0.team) && var_0.team == "axis") {
        if(isDefined(var_1) && var_1 == level.player) {
          break;
        }
      }
    }
  }

  scripts\sp\utility::_id_834F("ANTI_GRAV_KILL");
}

_id_36E1() {
  var_0 = self.origin;
  self._id_378E = [];

  for(var_1 = 0; var_1 < 12; var_1++) {
    var_2 = 30.0 * var_1;
    var_3 = self._id_85D2;
    var_4 = _id_378C(var_0, var_2, var_3);

    if(isDefined(var_4)) {
      var_5 = spawnStruct();
      var_5.origin = var_4;
      var_5._id_5F15 = 0;

      if(var_4[2] + 256 < var_0[2]) {
        var_5._id_5F15 = 1;
      }

      self._id_378E[self._id_378E.size] = var_5;
    }
  }

  return self._id_378E;
}

_id_1066C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = self.origin;
  var_2 = [];
  self._id_378D = [];

  for(var_3 = 0; var_3 < self._id_378E.size; var_3++) {
    var_4 = 0;
    var_5 = 0;

    if(var_3 > 0) {
      var_5 = var_3 - 1;
    } else {
      var_5 = self._id_378E.size - 1;
    }

    if(var_3 < self._id_378E.size - 1) {
      var_4 = var_3 + 1;
    } else {
      var_4 = 0;
    }

    var_6 = self._id_378E[var_4].origin;
    var_7 = self._id_378E[var_5].origin;
    var_8 = scripts\engine\utility::flatten_vector(vectorNormalize(var_7 - var_6));
    var_9 = rotatevector(var_8, (0, -90, 0));

    if(length(var_9) == 0) {
      var_9 = vectorNormalize(var_1 - self._id_378E[var_3].origin);

      if(length(var_9) == 0) {
        var_9 = (0, 0, 1);
      }
    }

    if(var_0) {
      self._id_378E[var_3]._id_5F15 = 1;
    }

    self._id_378D[self._id_378D.size] = _id_1066B(var_1, self._id_378E[var_3].origin, var_9, self._id_378E[var_3]._id_5F15);
  }

  if(!var_0) {
    if(!self._id_5F37) {
      if(level._id_2006._id_522B.size > 1) {
        var_10 = "antigrav_area_small_cheap";
      } else {
        var_10 = "antigrav_area_small";
      }
    } else if(level._id_2006._id_522B.size > 1)
      var_10 = "antigrav_area_small_up_cheap";
    else {
      var_10 = "antigrav_area_small_up";
    }

    if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
      var_11 = spawnfx(level._effect[var_10], var_1, (1, 0, 0), (0, 0, 1));
      _id_C0A7(0.55, ::triggerfx, var_11);
      self._id_132AA[self._id_132AA.size] = var_11;
    } else
      _id_C0A7(0.55, ::playfx, level._effect[var_10], var_1, (1, 0, 0), (0, 0, 1));

    var_12 = self._id_85D2 * 0.4;
    var_13 = 0;

    for(var_3 = 0; var_3 < self._id_378E.size; var_3++) {
      if(self._id_378E[var_3]._id_5F15) {
        continue;
      }
      var_14 = distance(self._id_378E[var_3].origin, var_1);
      var_15 = vectorNormalize(self._id_378E[var_3].origin - var_1);

      if(self._id_378E[var_3].origin[2] < var_1[2]) {
        var_15 = scripts\engine\utility::flatten_vector(var_15);
      }

      var_16 = anglestoright(vectortoangles(var_15));
      var_17 = var_12;
      var_18 = [];

      for(var_19 = 0; var_17 < var_14; var_17 = var_17 + var_12) {
        if(var_19 == 0 && !var_13) {
          var_20 = 0;
          var_18[var_18.size] = ::scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_15, (0, var_20, 0)) * var_17, 12, -1000);
        } else if(var_19 == 1) {
          var_20 = 0;
          var_18[var_18.size] = ::scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_15, (0, var_20, 0)) * var_17, 12, -1000);
        }

        var_19++;
      }

      foreach(var_22 in var_18) {
        var_23 = [0.0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4];
        var_24 = randomint(8);
        var_25 = 0.35 + var_23[var_24];
        var_26 = rotatevector((1, 0, 0), (0, randomfloat(360), 0));

        if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
          var_11 = spawnfx(level._effect[var_10], var_22 + (0, 0, 6), var_26, (0, 0, 1));
          _id_C0A7(var_25, ::triggerfx, var_11);
          self._id_132AA[self._id_132AA.size] = var_11;
          continue;
        }

        _id_C0A7(var_25, ::playfx, level._effect[var_10], var_22 + (0, 0, 6), var_26, (0, 0, 1));
      }

      var_13 = !var_13;
    }
  }
}

_id_378A(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, var_1, 0));
  var_4 = scripts\common\trace::ray_trace_passed(var_0 + (0, 0, 48), var_0 + (0, 0, 48) + var_3 * var_2, undefined, scripts\common\trace::create_world_contents());
  return var_4;
}

_id_378C(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, var_1, 0));
  var_4 = scripts\common\trace::ray_trace(var_0 + (0, 0, 48), var_0 + (0, 0, 48) + var_3 * var_2, undefined, scripts\common\trace::create_world_contents());

  if(var_4["fraction"] > 0.5) {
    var_5 = var_2 * var_4["fraction"] - 12.0;
    var_6 = var_0 + var_3 * var_5;
    var_7 = scripts\engine\utility::drop_to_ground(var_6, 50, -1000);
    return var_7;
  }

  return undefined;
}

#using_animtree("script_model");

_id_1066B(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = vectorNormalize(var_1 - var_0);
  var_5 = var_1;
  var_6 = var_0 + (0, 0, 2);
  var_7 = spawn("script_model", var_6);
  var_7.angles = (0, 0, 0);
  var_7._id_132AA = [];
  var_7 setModel("anti_grav_border_wm");
  var_7 _meth_83D0(#animtree);
  playFXOnTag(level._effect["antigrav_caltrop_trail"], var_7, "tag_origin");
  var_8 = randomfloatrange(0.3, 0.65);
  thread _id_3789(var_7, var_6, var_5, var_8);

  if(!var_3) {
    if(!self._id_5F37) {
      if(level._id_2006._id_522B.size > 1) {
        var_9 = "antigrav_caltrop_barrier_cheap";
      } else {
        var_9 = "antigrav_caltrop_barrier";
      }
    } else if(level._id_2006._id_522B.size > 1)
      var_9 = "antigrav_caltrop_barrier_up_cheap";
    else {
      var_9 = "antigrav_caltrop_barrier_up";
    }

    if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
      var_10 = spawnfx(level._effect[var_9], var_1, var_2, (0, 0, 1));
      _id_C0A7(var_8, ::triggerfx, var_10);
      var_7._id_132AA[var_7._id_132AA.size] = var_10;
    } else
      _id_C0A7(var_8, ::playfx, level._effect[var_9], var_1, var_2, (0, 0, 1));
  } else
    level _id_5128(var_8, ::_id_378B, var_7, var_1, var_2);

  return var_7;
}

_id_378B(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_3 = spawnfx(scripts\engine\utility::getfx("antigrav_detonate_dud"), var_1, var_2, (0, 0, 1));
    triggerfx(var_3);
    var_0._id_132AA[var_0._id_132AA.size] = var_3;
  } else
    playFX(scripts\engine\utility::getfx("antigrav_detonate_dud"), var_1, var_2, (0, 0, 1));
}

_id_3789(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_4 = vectorNormalize(var_2 - var_1);
  var_5 = distance(var_2, var_1);
  var_6 = var_1 + var_4 * var_5;
  var_7 = randomfloatrange(30, 70);
  var_8 = var_1 + var_4 * var_5 * 0.15 + (0, 0, var_7 * 0.75);
  var_9 = var_1 + var_4 * var_5 * 0.5 + (0, 0, var_7);
  var_10 = var_1 + var_4 * var_5 * 0.85 + (0, 0, var_7 * 0.75);
  var_11 = var_2;
  var_12 = 0;

  if(var_2[2] < var_1[2] - 50) {
    var_12 = 1;
  }

  var_0 rotateby((randomfloatrange(360, 900), 0, randomfloatrange(360, 900)), var_3 - 0.05);
  var_0 moveTo(var_8, var_3 / 4.0, 0.0, 0.0);
  wait(var_3 / 4.0);
  var_0 moveTo(var_9, var_3 / 4.0, 0.0, 0.0);
  wait(var_3 / 4.0);
  var_0 moveTo(var_10, var_3 / 4.0, 0.0, 0.0);
  wait(var_3 / 4.0);
  var_0 moveTo(var_11, var_3 / 4.0, 0.0, 0.0);
  wait(var_3 / 4.0);
  var_13 = 0.2;
  var_14 = randomfloat(5.0);
  var_0 rotateby((randomfloatrange(-40, 40), 0, randomfloatrange(-40, 40)), var_13 - 0.05);
  var_0 moveTo(var_11 + var_4 * var_14 / 2 + (0, 0, var_14), var_13 / 2, 0.0, var_13 / 2);
  wait(var_13 / 2);
  var_0 moveTo(var_11 + var_4 * var_14, var_13 / 2, var_13 / 2, 0.0);
  wait(var_13 / 2);
  _id_DFC4(var_0);
}

_id_3CB0(var_0, var_1) {
  if(distance2d(var_0.origin, var_1.origin) <= var_1._id_85D2) {
    if(var_0.origin[2] + 256 > var_1.origin[2] && var_0.origin[2] - var_1.origin[2] <= 180) {
      var_2 = 48;
      var_3 = 24;
      var_4 = scripts\common\trace::ray_trace_passed(var_1.origin + (0, 0, var_2), var_0.origin + (0, 0, var_2), undefined, scripts\common\trace::create_world_contents());

      if(var_4) {
        return 1;
      }

      var_4 = scripts\common\trace::ray_trace_passed(var_1.origin + (0, 0, var_3), var_0.origin + (0, 0, var_3), undefined, scripts\common\trace::create_world_contents());

      if(var_4) {
        return 1;
      }

      var_5 = var_0.origin - var_1.origin;
      var_5 = (var_5[0], var_5[1], 0);
      var_6 = var_1.origin + (0, 0, var_2) + var_5;
      var_4 = scripts\common\trace::ray_trace_passed(var_1.origin + (0, 0, var_2), var_6, undefined, scripts\common\trace::create_world_contents());

      if(var_4) {
        var_4 = scripts\common\trace::ray_trace_passed(var_6, var_0.origin + (0, 0, var_2), undefined, scripts\common\trace::create_world_contents());

        if(var_4) {
          return 1;
        }
      }

      var_5 = var_0.origin - var_1.origin;
      var_5 = (var_5[0], var_5[1], 0);
      var_6 = var_1.origin + (0, 0, var_3) + var_5;
      var_4 = scripts\common\trace::ray_trace_passed(var_1.origin + (0, 0, var_3), var_6, undefined, scripts\common\trace::create_world_contents());

      if(var_4) {
        var_4 = scripts\common\trace::ray_trace_passed(var_6, var_0.origin + (0, 0, var_3), undefined, scripts\common\trace::create_world_contents());

        if(var_4) {
          return 1;
        }
      }
    }
  }

  return 0;
}

_id_4933() {
  var_0 = physics_volumecreate(self.origin, self._id_85D2, 180);
  var_0 _meth_8527(0);
  var_0 physics_volumesetactivator(1);
  var_0 physics_volumeenable(1);
  thread _id_CB0A(var_0);
  return var_0;
}

_id_CB0A(var_0) {
  var_0 endon("destroy_volume");
  var_1 = -0.15;
  var_0 _meth_852A(1, var_1);
  wait 0.2;
  var_0 _meth_852A(1, 0.0);
}

_id_52B3(var_0) {
  var_0 notify("destroy_volume");
  var_0 delete();
}

_id_1293() {
  if(isDefined(self) && isDefined(self._id_202A)) {
    return 11.0;
  } else {
    return 7.0;
  }
}

_id_1294() {
  if(isDefined(self) && isDefined(self._id_202B)) {
    return 196;
  } else {
    return 148;
  }
}

_id_C0A7(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread _id_C0A8(var_1, var_0, var_2, var_3, var_4, var_5);
}

_id_C0A8(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", var_1);

  if(isDefined(var_5)) {
    call[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    call[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    call[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    call[[var_0]](var_2);
  } else {
    call[[var_0]]();
  }
}

_id_5128(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread scripts\engine\utility::delaythread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_5129(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_delay_thread");
  scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", var_1);

  if(isDefined(var_7)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
  } else if(isDefined(var_6)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
  } else if(isDefined(var_5)) {
    thread[[var_0]](var_2, var_3, var_4, var_5);
  } else if(isDefined(var_4)) {
    thread[[var_0]](var_2, var_3, var_4);
  } else if(isDefined(var_3)) {
    thread[[var_0]](var_2, var_3);
  } else if(isDefined(var_2)) {
    thread[[var_0]](var_2);
  } else {
    thread[[var_0]]();
  }
}

_id_CE2E(var_0) {
  if(scripts\sp\utility::_id_9BB2()) {
    return;
  }
  var_1 = spawn("script_origin", self.origin);
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1 linkTo(self);
  var_1 playSound(var_0, "sounddone");
  var_1 scripts\engine\utility::waittill_any("sounddone", "antigrav_force_delete");
  var_1 delete();
}