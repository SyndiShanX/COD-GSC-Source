/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3617.gsc
************************/

func_9527() {
  precacheitem("antigrav");
  precachemodel("anti_grav_border_wm");
  level._effect["antigrav_detonate_dud"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_detonate_dud.vfx");
  level._effect["antigrav_caltrop_trail"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_trail.vfx");
  level._effect["antigrav_detonate"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_detonate.vfx");
  level._effect["antigrav_detonate_cheap"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_detonate_cheap.vfx");
  level._effect["antigrav_caltrop_barrier"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_caltrop_barrier.vfx");
  level._effect["antigrav_caltrop_barrier_cheap"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_caltrop_barrier_cheap.vfx");
  level._effect["antigrav_area_small"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_area_small.vfx");
  level._effect["antigrav_area_small_cheap"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_area_small_cheap.vfx");
  level._effect["antigrav_detonate_up"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_detonate_upgrade.vfx");
  level._effect["antigrav_detonate_up_cheap"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_detonate_upgrade_cheap.vfx");
  level._effect["antigrav_caltrop_barrier_up"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_caltrop_barrier_upgrade.vfx");
  level._effect["antigrav_caltrop_barrier_up_cheap"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_caltrop_barrier_upgrade_cheap.vfx");
  level._effect["antigrav_area_small_up"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_area_small_upgrade.vfx");
  level._effect["antigrav_area_small_up_cheap"] = loadfx("vfx\iw7\_requests\equipment\antigrav\antigrav_gren_area_small_upgrade_cheap.vfx");
  scripts\engine\utility::flag_init("antigrav_force_delete");
  level.player.var_D363 = [];
  level.player thread func_D0EB();
  level thread func_365A();
  level.var_2006 = spawnStruct();
  level.var_2006.var_A8C6 = undefined;
  level.var_2006.var_522B = [];
}

func_2013(param_00) {
  var_01 = self;
  var_02 = scripts\engine\utility::spawn_tag_origin();
  var_02.origin = param_00.origin;
  var_02.objective_position = param_00;
  var_02 linkto(var_02.objective_position);
  level.var_2006.var_522B[level.var_2006.var_522B.size] = var_02;
  var_03 = var_02.objective_position func_201A();
  if(!isDefined(var_02.objective_position)) {
    var_02 thread func_DFC5();
    return;
  }

  var_02 func_E057();
  var_02.var_85D2 = var_01 func_1294();
  var_02.var_5F36 = var_01 func_1293();
  var_02.var_112DF = var_03;
  if(isDefined(var_01) && isDefined(var_01.var_202A) && var_01.var_202A == 1) {
    var_02.var_5F37 = 1;
  } else {
    var_02.var_5F37 = 0;
  }

  if(isDefined(var_01) && isDefined(level.player) && var_01 == level.player) {
    var_02.var_D43A = 1;
  } else {
    var_02.var_D43A = 0;
  }

  var_02 thread func_200F();
}

func_201A() {
  self endon("entitydeleted");
  self endon("death");
  self waittill("missile_stuck", var_00, var_01, var_02);
  return var_02;
}

func_FF4F(param_00, param_01) {
  if(param_00 scripts\sp\utility::isactorwallrunning()) {
    return 0;
  }

  if(func_3CB0(param_00, param_01)) {
    if(isDefined(param_00.var_1C78)) {
      return param_00.var_1C78;
    }

    if(param_00 _meth_81A6()) {
      return 0;
    }

    return 1;
  }

  return 0;
}

func_200B() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00.origin = self.origin;
  level.var_2006.var_522B[level.var_2006.var_522B.size] = var_00;
  var_00.var_85D2 = 156;
  var_00.var_5F36 = 7;
  var_00 thread func_200F();
}

func_2017() {
  self playsurfacesound("gravity_explode_default", self.var_112DF);
}

func_200F() {
  if(!isDefined(self.var_5F37)) {
    self.var_5F37 = 0;
  }

  if(!isDefined(self.var_112DF)) {
    self.var_112DF = "default";
  }

  self.angles = (0, 0, 0);
  self.var_132AA = [];
  thread func_2017();
  if(!self.var_5F37) {
    if(level.var_2006.var_522B.size > 1) {
      var_00 = "antigrav_detonate_cheap";
    } else {
      var_00 = "antigrav_detonate";
    }
  } else if(level.var_2006.var_522B.size > 1) {
    var_00 = "antigrav_detonate_up_cheap";
  } else {
    var_00 = "antigrav_detonate_up";
  }

  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_01 = spawnfx(level._effect[var_00], self.origin, (1, 0, 0), (0, 0, 1));
    triggerfx(var_01);
    self.var_132AA[self.var_132AA.size] = var_01;
  } else {
    playFX(level._effect[var_00], self.origin, (1, 0, 0), (0, 0, 1));
  }

  func_36E1();
  func_1066C();
  lib_0F18::func_10E8A("broadcast", "attack", self.origin, 1000);
  level scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", 0.55);
  var_02 = [];
  foreach(var_04 in getaiarray()) {
    if(func_FF4F(var_04, self)) {
      var_02[var_02.size] = var_04;
    }
  }

  thread scripts\engine\utility::play_loop_sound_on_entity("gravity_field_lp");
  self.var_CB13 = func_4933();
  var_06 = 0;
  var_07 = 0;
  foreach(var_09 in self.var_378E) {
    if(var_09.var_5F15 == 1) {
      continue;
    }

    if(self.origin[2] - var_09.origin[2] > var_06) {
      var_06 = self.origin[2] - var_09.origin[2];
    }

    if(var_09.origin[2] - self.origin[2] > var_07) {
      var_07 = var_09.origin[2] - self.origin[2];
    }
  }

  var_0B = self.origin[2] - var_06 - 24;
  var_0C = self.origin[2] + var_07 + 72;
  var_0D = var_0C + var_0B * 0.5;
  if(var_0D < self.origin[2]) {
    var_0E = self.origin;
    var_0F = self.origin[2] - var_0B;
  } else {
    var_0E = (self.origin[0], self.origin[1], var_0F);
    var_0F = var_0D - var_0C * 0.5;
  }

  func_4926(var_0E, var_0F);
  scripts\engine\utility::array_thread(var_02, ::func_197D, self);
  func_CF45();
  thread func_FB3E();
  level scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", self.var_5F36);
  thread func_DFC5();
}

func_4926(param_00, param_01) {
  var_02 = ["axis", "allies", "team3", "neutral", "bad_guys"];
  if(!isDefined(level.var_2006.var_5602) || level.var_2006.var_5602.size == 0) {
    self.var_C2CA = _func_315(param_00, (self.var_85D2, self.var_85D2, param_01), (0, 0, 0));
    createnavrepulsor("antigrav" + self getentitynumber(), -1, param_00, self.var_85D2, 1);
    return;
  }

  if(level.var_2006.var_5602.size > 0) {
    if(level.var_2006.var_5602[0] == "all") {
      return;
    }

    if(scripts\engine\utility::array_contains(level.var_2006.var_5602, "allies") && scripts\engine\utility::array_contains(level.var_2006.var_5602, "axis")) {
      self.var_C2CA = _func_315(param_00, (self.var_85D2, self.var_85D2, param_01), (0, 0, 0), "team3", "neutral", "bad_guys");
      createnavrepulsor("antigrav" + self getentitynumber(), -1, param_00, self.var_85D2, 0, "team3", "neutral", "bad_guys");
      return;
    }

    if(scripts\engine\utility::array_contains(level.var_2006.var_5602, "allies")) {
      self.var_C2CA = _func_315(param_00, (self.var_85D2, self.var_85D2, param_01), (0, 0, 0), "axis", "team3", "neutral", "bad_guys");
      createnavrepulsor("antigrav" + self getentitynumber(), -1, param_00, self.var_85D2, 0, "team3", "neutral", "bad_guys");
      return;
    }

    if(scripts\engine\utility::array_contains(level.var_2006.var_5602, "axis")) {
      self.var_C2CA = _func_315(param_00, (self.var_85D2, self.var_85D2, param_01), (0, 0, 0), "allies", "team3", "neutral", "bad_guys");
      createnavrepulsor("antigrav" + self getentitynumber(), -1, param_00, self.var_85D2, 0, "team3", "neutral", "bad_guys");
      return;
    }

    return;
  }
}

func_FB3E() {
  level scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", self.var_5F36 - 0.4);
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.objective_position)) {
    thread scripts\sp\utility::play_sound_on_entity("gravity_field_off");
  }

  thread scripts\engine\utility::stop_loop_sound_on_entity("gravity_field_lp");
}

func_DFC5() {
  if(!isDefined(self)) {
    return;
  }

  level notify("antigrav_done");
  thread func_E057();
  if(scripts\engine\utility::flag("antigrav_force_delete")) {
    scripts\engine\utility::waitframe();
  }

  thread scripts\engine\utility::stop_loop_sound_on_entity("gravity_field_lp");
  if(isDefined(self.new)) {
    func_D25C();
  }

  if(isDefined(self.var_CB13)) {
    func_52B3(self.var_CB13);
  }

  if(isDefined(self.var_C2CA)) {
    destroynavobstacle(self.var_C2CA);
    destroynavrepulsor("antigrav" + self getentitynumber());
  }

  if(isDefined(self.var_132AA)) {
    foreach(var_01 in self.var_132AA) {
      var_01 delete();
    }
  }

  if(isDefined(self.var_378D)) {
    var_03 = self.var_378D;
    foreach(var_05 in var_03) {
      func_DFC4(var_05);
    }
  }

  level.var_2006.var_522B = scripts\engine\utility::array_remove(level.var_2006.var_522B, self);
  self delete();
}

func_E057() {
  if(isDefined(self.objective_position)) {
    level.var_2006.var_A8C6 = self.objective_position.origin;
    self unlink();
    self.objective_position delete();
  }
}

func_DFC4(param_00) {
  if(isDefined(param_00.var_132AA)) {
    foreach(var_02 in param_00.var_132AA) {
      var_02 delete();
    }
  }

  killfxontag(level._effect["antigrav_caltrop_trail"], param_00, "tag_origin");
  self.var_378D = scripts\engine\utility::array_remove(self.var_378D, param_00);
  param_00 delete();
}

func_DFBA() {
  level notify("removing_all_antigravs_instantly");
  level endon("removing_all_antigravs_instantly");
  scripts\engine\utility::flag_set("antigrav_force_delete");
  foreach(var_01 in level.var_2006.var_522B) {
    var_01 thread func_E057();
  }

  for(;;) {
    if(level.var_2006.var_522B.size > 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_clear("antigrav_force_delete");
}

func_197D(param_00) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(isDefined(self.a) && isDefined(self.a.var_58DA)) {
    self _meth_81D0();
    return;
  }

  if(self.unittype == "c12") {
    return;
  }

  if(scripts\asm\asm_bb::bb_isanimscripted()) {
    self givescorefortrophyblocks();
  }

  if(!isDefined(self.var_2023)) {
    func_1978(param_00);
    scripts\asm\asm::asm_setstate("antigrav_rise");
    return;
  }

  if(self.var_2023 == "rise" || self.var_2023 == "float_idle") {
    self.var_201D = gettime() + param_00.var_5F36 + randomfloat(0.25) * 1000;
    return;
  }

  if(self.var_2023 == "fall") {
    self.var_201D = gettime() + param_00.var_5F36 + randomfloat(0.25) * 1000;
    self.var_2020 = 1;
    return;
  }

  func_1978(param_00);
  self.var_2020 = 1;
}

func_1978(param_00) {
  self.var_2022 = gettime();
  self.var_201D = self.var_2022 + param_00.var_5F36 + randomfloat(0.25) * 1000;
}

func_CF45() {
  self.new = 1;
  level.player.var_D363[level.player.var_D363.size] = self;
  level.player notify("new_antigrav_gren_active");
  thread func_CF46();
}

func_CF46() {
  scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", 0.1);
  self.new = 0;
}

func_D25C() {
  level.player.var_D363 = scripts\engine\utility::array_remove(level.player.var_D363, self);
  level.player notify("removed_antigrav_gren");
}

func_365A() {
  for(;;) {
    waittillframeend;
    level.player.var_D363 = scripts\engine\utility::array_removeundefined(level.player.var_D363);
    var_00 = getaiunittypearray("all", "C12");
    foreach(var_02 in var_00) {
      if(!isalive(var_02)) {
        continue;
      }

      if(!isDefined(var_02.var_93B5)) {
        var_02.var_93B5 = 0;
      }

      var_03 = 0;
      foreach(var_05 in level.player.var_D363) {
        if(func_3CB0(var_02, var_05)) {
          var_03 = 1;
          break;
        }
      }

      if(var_03) {
        if(!var_02.var_93B5) {
          var_02.var_2015 = var_02.moveplaybackrate;
          var_02.moveplaybackrate = 0.2;
          var_02.var_93B5 = 1;
        }

        continue;
      }

      if(var_02.var_93B5) {
        var_02.moveplaybackrate = var_02.var_2015;
        var_02.var_2015 = undefined;
        var_02.var_93B5 = 0;
      }
    }

    wait(0.05);
  }
}

func_D0EB() {
  self endon("death");
  self.var_93B5 = 0;
  for(;;) {
    waittillframeend;
    level.player.var_D363 = scripts\engine\utility::array_removeundefined(level.player.var_D363);
    if(self.var_D363.size == 0) {
      if(self.var_93B5) {
        func_5567();
        self.var_93B5 = 0;
      }

      self waittill("new_antigrav_gren_active");
    }

    var_00 = 0;
    var_01 = 0;
    self.var_4B16 = undefined;
    if(!level.player scripts\sp\utility::func_65DF("disable_antigrav_float") || !level.player scripts\sp\utility::func_65DB("disable_antigrav_float")) {
      foreach(var_03 in self.var_D363) {
        if(func_3CB0(self, var_03)) {
          var_00 = 1;
          self.var_4B16 = var_03;
          if(var_03.new == 1) {
            var_01 = 1;
          }
        }
      }
    }

    if(!self.var_93B5 && var_00) {
      thread func_6228();
      self.var_93B5 = 1;
    } else if(self.var_93B5 && !var_00) {
      thread func_5567();
      self.var_93B5 = 0;
    }

    wait(0.05);
  }
}

func_6228() {
  level.player notify("enable_player_antigrav_gren");
  level.player endon("disable_player_antigrav_gren");
  if(!isDefined(level.player.var_2028)) {
    lib_0E4F::func_9755();
    level.player.var_2028 = 1;
    level.player.var_2024 = level.player getstance();
    if(level.player.var_2024 == "crouch") {
      setsaveddvar("player_spaceViewHeight", 40);
      setsaveddvar("player_spaceCapsuleHeight", 50);
    } else if(level.player.var_2024 == "prone") {
      setsaveddvar("player_spaceViewHeight", 11);
      setsaveddvar("player_spaceCapsuleHeight", 30);
    } else {
      setsaveddvar("player_spaceViewHeight", 60);
      setsaveddvar("player_spaceCapsuleHeight", 70);
    }
  }

  level.player scripts\engine\utility::allow_usability(0);
  level.player.var_C37D = getdvarint("player_death_animated", 1);
  setdvar("player_death_animated", 0);
  if(level.player scripts\sp\utility::func_65DB("player_space_override_off")) {
    return;
  }

  if(level.player scripts\sp\utility::func_9F59()) {
    level.player notify("cancel_sliding");
    level.player scripts\sp\utility::func_6389();
  }

  if(level.player isonground()) {
    level.player playgestureviewmodel("ges_antigrav_reaction");
    level.player.playing_terrorist_respawn_music = 1;
    thread func_CF65();
  } else {
    level.player playgestureviewmodel("ges_antigrav_reaction");
    level.player.playing_terrorist_respawn_music = 1;
    thread func_CF65();
  }

  level.player.isent.var_6F43 = 1;
  level.player scripts\sp\utility::func_65E1("player_gravity_off");
  level.player thread func_CF64();
  level.player thread func_CF67();
}

func_5567() {
  level.player notify("disable_player_antigrav_gren");
  if(level.player scripts\sp\utility::func_65DF("player_gravity_off")) {
    level.player scripts\sp\utility::func_65DD("player_gravity_off");
  }

  level.player.playing_terrorist_respawn_music = undefined;
  level.player scripts\engine\utility::allow_usability(1);
  setdvar("player_death_animated", level.player.var_C37D);
  level.player.var_C37D = undefined;
  thread func_5568();
}

func_5568() {
  level.player endon("enable_player_antigrav_gren");
  for(;;) {
    if(getdvarint("player_spaceEnabled") == 0) {
      break;
    }

    wait(0.05);
  }

  for(;;) {
    level.player setstance(level.player.var_2024);
    if(level.player getstance() == level.player.var_2024) {
      break;
    }

    wait(0.05);
  }

  level.player.var_2028 = undefined;
}

func_CF64() {
  self endon("death");
  self notify("crawlmeleegrab_antigrav");
  waittillframeend;
  self.isent.var_6F43 = 1;
  self getrawbaseweaponname(0.8, 0.8);
  lib_0E4F::func_6251();
  lib_0E4F::func_621C();
  while(lib_0E4F::func_9C7B()) {
    if(!isDefined(self.var_4B16)) {
      break;
    }

    if(!level.player.playing_terrorist_respawn_music) {
      level.player playgestureviewmodel("ges_antigrav_idle");
    }

    var_00 = level.player.origin[2] - self.var_4B16.origin[2];
    var_01 = clamp(100 - var_00 / 100, 0, 1);
    var_02 = 50 * var_01;
    var_03 = self getvelocity();
    var_04 = (0, 0, 1);
    var_05 = var_03 + var_04 * var_02;
    self setvelocity(var_05);
    wait(0.05);
  }

  level.player stopgestureviewmodel("ges_antigrav_reaction");
  level.player stopgestureviewmodel("ges_antigrav_idle");
  lib_0E4F::func_40A6();
  if(isDefined(level.player.var_9BF5)) {
    while(level.player.var_9BF5 == 1) {
      scripts\engine\utility::waitframe();
    }
  }
}

func_CF65() {
  thread func_CF66();
  self endon("antigrav_reaction_think_timeout");
  self endon("death");
  for(;;) {
    level.player waittill("gesture_stopped", var_00);
    if(var_00 == "ges_antigrav_reaction") {
      break;
    }
  }

  if(isDefined(self.playing_terrorist_respawn_music)) {
    self.playing_terrorist_respawn_music = 0;
  }
}

func_CF66() {
  self endon("death");
  wait(5);
  self notify("antigrav_reaction_think_timeout");
  if(isDefined(self.playing_terrorist_respawn_music)) {
    self.playing_terrorist_respawn_music = 0;
  }
}

func_CF67() {
  level.player endon("death");
  level.player endon("disable_player_antigrav_gren");
  for(;;) {
    level waittill("ai_killed", var_00, var_01);
    if(isDefined(level.player.var_4B16) && isDefined(level.player.var_4B16.var_D43A) && level.player.var_4B16.var_D43A == 1) {
      if(isDefined(var_00) && isDefined(var_00.team) && var_00.team == "axis") {
        if(isDefined(var_01) && var_01 == level.player) {
          break;
        }
      }
    }
  }

  scripts\sp\utility::settimer("ANTI_GRAV_KILL");
}

func_36E1() {
  var_00 = self.origin;
  self.var_378E = [];
  for(var_01 = 0; var_01 < 12; var_01++) {
    var_02 = 30 * var_01;
    var_03 = self.var_85D2;
    var_04 = func_378C(var_00, var_02, var_03);
    if(isDefined(var_04)) {
      var_05 = spawnStruct();
      var_05.origin = var_04;
      var_05.var_5F15 = 0;
      if(var_04[2] + 256 < var_00[2]) {
        var_05.var_5F15 = 1;
      }

      self.var_378E[self.var_378E.size] = var_05;
    }
  }

  return self.var_378E;
}

func_1066C(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = self.origin;
  var_02 = [];
  self.var_378D = [];
  for(var_03 = 0; var_03 < self.var_378E.size; var_03++) {
    var_04 = 0;
    var_05 = 0;
    if(var_03 > 0) {
      var_05 = var_03 - 1;
    } else {
      var_05 = self.var_378E.size - 1;
    }

    if(var_03 < self.var_378E.size - 1) {
      var_04 = var_03 + 1;
    } else {
      var_04 = 0;
    }

    var_06 = self.var_378E[var_04].origin;
    var_07 = self.var_378E[var_05].origin;
    var_08 = scripts\engine\utility::flatten_vector(vectornormalize(var_07 - var_06));
    var_09 = rotatevector(var_08, (0, -90, 0));
    if(length(var_09) == 0) {
      var_09 = vectornormalize(var_01 - self.var_378E[var_03].origin);
      if(length(var_09) == 0) {
        var_09 = (0, 0, 1);
      }
    }

    if(param_00) {
      self.var_378E[var_03].var_5F15 = 1;
    }

    self.var_378D[self.var_378D.size] = func_1066B(var_01, self.var_378E[var_03].origin, var_09, self.var_378E[var_03].var_5F15);
  }

  if(!param_00) {
    if(!self.var_5F37) {
      if(level.var_2006.var_522B.size > 1) {
        var_0A = "antigrav_area_small_cheap";
      } else {
        var_0A = "antigrav_area_small";
      }
    } else if(level.var_2006.var_522B.size > 1) {
      var_0A = "antigrav_area_small_up_cheap";
    } else {
      var_0A = "antigrav_area_small_up";
    }

    if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
      var_0B = spawnfx(level._effect[var_0A], var_01, (1, 0, 0), (0, 0, 1));
      func_C0A7(0.55, ::triggerfx, var_0B);
      self.var_132AA[self.var_132AA.size] = var_0B;
    } else {
      func_C0A7(0.55, ::playfx, level._effect[var_0A], var_01, (1, 0, 0), (0, 0, 1));
    }

    var_0C = self.var_85D2 * 0.4;
    var_0D = 0;
    for(var_03 = 0; var_03 < self.var_378E.size; var_03++) {
      if(self.var_378E[var_03].var_5F15) {
        continue;
      }

      var_0E = distance(self.var_378E[var_03].origin, var_01);
      var_0F = vectornormalize(self.var_378E[var_03].origin - var_01);
      if(self.var_378E[var_03].origin[2] < var_01[2]) {
        var_0F = scripts\engine\utility::flatten_vector(var_0F);
      }

      var_10 = anglestoright(vectortoangles(var_0F));
      var_11 = var_0C;
      var_12 = [];
      var_13 = 0;
      while(var_11 < var_0E) {
        if(var_13 == 0 && !var_0D) {
          var_14 = 0;
          var_12[var_12.size] = ::scripts\engine\utility::drop_to_ground(var_01 + rotatevector(var_0F, (0, var_14, 0)) * var_11, 12, -1000);
        } else if(var_13 == 1) {
          var_14 = 0;
          var_12[var_12.size] = ::scripts\engine\utility::drop_to_ground(var_01 + rotatevector(var_0F, (0, var_14, 0)) * var_11, 12, -1000);
        }

        var_13++;
        var_11 = var_11 + var_0C;
      }

      foreach(var_16 in var_12) {
        var_17 = [0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4];
        var_18 = randomint(8);
        var_19 = 0.35 + var_17[var_18];
        var_1A = rotatevector((1, 0, 0), (0, randomfloat(360), 0));
        if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
          var_0B = spawnfx(level._effect[var_0A], var_16 + (0, 0, 6), var_1A, (0, 0, 1));
          func_C0A7(var_19, ::triggerfx, var_0B);
          self.var_132AA[self.var_132AA.size] = var_0B;
          continue;
        }

        func_C0A7(var_19, ::playfx, level._effect[var_0A], var_16 + (0, 0, 6), var_1A, (0, 0, 1));
      }

      var_0D = !var_0D;
    }
  }
}

func_378A(param_00, param_01, param_02) {
  var_03 = anglesToForward((0, param_01, 0));
  var_04 = scripts\common\trace::ray_trace_passed(param_00 + (0, 0, 48), param_00 + (0, 0, 48) + var_03 * param_02, undefined, scripts\common\trace::create_world_contents());
  return var_04;
}

func_378C(param_00, param_01, param_02) {
  var_03 = anglesToForward((0, param_01, 0));
  var_04 = scripts\common\trace::ray_trace(param_00 + (0, 0, 48), param_00 + (0, 0, 48) + var_03 * param_02, undefined, scripts\common\trace::create_world_contents());
  if(var_04["fraction"] > 0.5) {
    var_05 = param_02 * var_04["fraction"] - 12;
    var_06 = param_00 + var_03 * var_05;
    var_07 = scripts\engine\utility::drop_to_ground(var_06, 50, -1000);
    return var_07;
  }

  return undefined;
}

func_1066B(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  var_04 = vectornormalize(param_01 - param_00);
  var_05 = param_01;
  var_06 = param_00 + (0, 0, 2);
  var_07 = spawn("script_model", var_06);
  var_07.angles = (0, 0, 0);
  var_07.var_132AA = [];
  var_07 setModel("anti_grav_border_wm");
  var_07 glinton(#animtree);
  playFXOnTag(level._effect["antigrav_caltrop_trail"], var_07, "tag_origin");
  var_08 = randomfloatrange(0.3, 0.65);
  thread func_3789(var_07, var_06, var_05, var_08);
  if(!param_03) {
    if(!self.var_5F37) {
      if(level.var_2006.var_522B.size > 1) {
        var_09 = "antigrav_caltrop_barrier_cheap";
      } else {
        var_09 = "antigrav_caltrop_barrier";
      }
    } else if(level.var_2006.var_522B.size > 1) {
      var_09 = "antigrav_caltrop_barrier_up_cheap";
    } else {
      var_09 = "antigrav_caltrop_barrier_up";
    }

    if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
      var_0A = spawnfx(level._effect[var_09], param_01, param_02, (0, 0, 1));
      func_C0A7(var_08, ::triggerfx, var_0A);
      var_07.var_132AA[var_07.var_132AA.size] = var_0A;
    } else {
      func_C0A7(var_08, ::playfx, level._effect[var_09], param_01, param_02, (0, 0, 1));
    }
  } else {
    level func_5128(var_08, ::func_378B, var_07, param_01, param_02);
  }

  return var_07;
}

func_378B(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    return;
  }

  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_03 = spawnfx(scripts\engine\utility::getfx("antigrav_detonate_dud"), param_01, param_02, (0, 0, 1));
    triggerfx(var_03);
    param_00.var_132AA[param_00.var_132AA.size] = var_03;
    return;
  }

  playFX(scripts\engine\utility::getfx("antigrav_detonate_dud"), param_01, param_02, (0, 0, 1));
}

func_3789(param_00, param_01, param_02, param_03) {
  param_00 endon("death");
  var_04 = vectornormalize(param_02 - param_01);
  var_05 = distance(param_02, param_01);
  var_06 = param_01 + var_04 * var_05;
  var_07 = randomfloatrange(30, 70);
  var_08 = param_01 + var_04 * var_05 * 0.15 + (0, 0, var_07 * 0.75);
  var_09 = param_01 + var_04 * var_05 * 0.5 + (0, 0, var_07);
  var_0A = param_01 + var_04 * var_05 * 0.85 + (0, 0, var_07 * 0.75);
  var_0B = param_02;
  var_0C = 0;
  if(param_02[2] < param_01[2] - 50) {
    var_0C = 1;
  }

  param_00 ghost_killed_update_func((randomfloatrange(360, 900), 0, randomfloatrange(360, 900)), param_03 - 0.05);
  param_00 moveto(var_08, param_03 / 4, 0, 0);
  wait(param_03 / 4);
  param_00 moveto(var_09, param_03 / 4, 0, 0);
  wait(param_03 / 4);
  param_00 moveto(var_0A, param_03 / 4, 0, 0);
  wait(param_03 / 4);
  param_00 moveto(var_0B, param_03 / 4, 0, 0);
  wait(param_03 / 4);
  var_0D = 0.2;
  var_0E = randomfloat(5);
  param_00 ghost_killed_update_func((randomfloatrange(-40, 40), 0, randomfloatrange(-40, 40)), var_0D - 0.05);
  param_00 moveto(var_0B + var_04 * var_0E / 2 + (0, 0, var_0E), var_0D / 2, 0, var_0D / 2);
  wait(var_0D / 2);
  param_00 moveto(var_0B + var_04 * var_0E, var_0D / 2, var_0D / 2, 0);
  wait(var_0D / 2);
  func_DFC4(param_00);
}

func_3CB0(param_00, param_01) {
  if(distance2d(param_00.origin, param_01.origin) <= param_01.var_85D2) {
    if(param_00.origin[2] + 256 > param_01.origin[2] && param_00.origin[2] - param_01.origin[2] <= 180) {
      var_02 = 48;
      var_03 = 24;
      var_04 = scripts\common\trace::ray_trace_passed(param_01.origin + (0, 0, var_02), param_00.origin + (0, 0, var_02), undefined, scripts\common\trace::create_world_contents());
      if(var_04) {
        return 1;
      }

      var_04 = scripts\common\trace::ray_trace_passed(param_01.origin + (0, 0, var_03), param_00.origin + (0, 0, var_03), undefined, scripts\common\trace::create_world_contents());
      if(var_04) {
        return 1;
      }

      var_05 = param_00.origin - param_01.origin;
      var_05 = (var_05[0], var_05[1], 0);
      var_06 = param_01.origin + (0, 0, var_02) + var_05;
      var_04 = scripts\common\trace::ray_trace_passed(param_01.origin + (0, 0, var_02), var_06, undefined, scripts\common\trace::create_world_contents());
      if(var_04) {
        var_04 = scripts\common\trace::ray_trace_passed(var_06, param_00.origin + (0, 0, var_02), undefined, scripts\common\trace::create_world_contents());
        if(var_04) {
          return 1;
        }
      }

      var_05 = param_00.origin - param_01.origin;
      var_05 = (var_05[0], var_05[1], 0);
      var_06 = param_01.origin + (0, 0, var_03) + var_05;
      var_04 = scripts\common\trace::ray_trace_passed(param_01.origin + (0, 0, var_03), var_06, undefined, scripts\common\trace::create_world_contents());
      if(var_04) {
        var_04 = scripts\common\trace::ray_trace_passed(var_06, param_00.origin + (0, 0, var_03), undefined, scripts\common\trace::create_world_contents());
        if(var_04) {
          return 1;
        }
      }
    }
  }

  return 0;
}

func_4933() {
  var_00 = physics_volumecreate(self.origin, self.var_85D2, 180);
  var_00 _meth_8527(0);
  var_00 physics_volumesetactivator(1);
  var_00 physics_volumeenable(1);
  thread func_CB0A(var_00);
  return var_00;
}

func_CB0A(param_00) {
  param_00 endon("destroy_volume");
  var_01 = -0.15;
  param_00 _meth_852A(1, var_01);
  wait(0.2);
  param_00 _meth_852A(1, 0);
}

func_52B3(param_00) {
  param_00 notify("destroy_volume");
  param_00 delete();
}

func_1293() {
  if(isDefined(self) && isDefined(self.var_202A)) {
    return 11;
  }

  return 7;
}

func_1294() {
  if(isDefined(self) && isDefined(self.var_202B)) {
    return 196;
  }

  return 148;
}

func_C0A7(param_00, param_01, param_02, param_03, param_04, param_05) {
  thread func_C0A8(param_01, param_00, param_02, param_03, param_04, param_05);
}

func_C0A8(param_00, param_01, param_02, param_03, param_04, param_05) {
  scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", param_01);
  if(isDefined(param_05)) {
    [[param_00]](param_02, param_03, param_04, param_05);
    return;
  }

  if(isDefined(param_04)) {
    [[param_00]](param_02, param_03, param_04);
    return;
  }

  if(isDefined(param_03)) {
    [[param_00]](param_02, param_03);
    return;
  }

  if(isDefined(param_02)) {
    [[param_00]](param_02);
    return;
  }

  [[param_00]]();
}

func_5128(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  thread scripts\engine\utility::delaythread_proc(param_01, param_00, param_02, param_03, param_04, param_05, param_06, param_07);
}

func_5129(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("death");
  self endon("stop_delay_thread");
  scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", param_01);
  if(isDefined(param_07)) {
    thread[[param_00]](param_02, param_03, param_04, param_05, param_06, param_07);
    return;
  }

  if(isDefined(param_06)) {
    thread[[param_00]](param_02, param_03, param_04, param_05, param_06);
    return;
  }

  if(isDefined(param_05)) {
    thread[[param_00]](param_02, param_03, param_04, param_05);
    return;
  }

  if(isDefined(param_04)) {
    thread[[param_00]](param_02, param_03, param_04);
    return;
  }

  if(isDefined(param_03)) {
    thread[[param_00]](param_02, param_03);
    return;
  }

  if(isDefined(param_02)) {
    thread[[param_00]](param_02);
    return;
  }

  thread[[param_00]]();
}

func_CE2E(param_00) {
  if(scripts\sp\utility::func_9BB2()) {
    return;
  }

  var_01 = spawn("script_origin", self.origin);
  var_01.origin = self.origin;
  var_01.angles = self.angles;
  var_01 linkto(self);
  var_01 playSound(param_00, "sounddone");
  var_01 scripts\engine\utility::waittill_any_3("sounddone", "antigrav_force_delete");
  var_01 delete();
}