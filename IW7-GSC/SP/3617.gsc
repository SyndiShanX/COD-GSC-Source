/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3617.gsc
*********************************************/

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

func_2013(var_0) {
  var_1 = self;
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0.origin;
  var_2.objective_position = var_0;
  var_2 linkto(var_2.objective_position);
  level.var_2006.var_522B[level.var_2006.var_522B.size] = var_2;
  var_3 = var_2.objective_position func_201A();
  if(!isDefined(var_2.objective_position)) {
    var_2 thread func_DFC5();
    return;
  }

  var_2 func_E057();
  var_2.var_85D2 = var_1 func_1294();
  var_2.var_5F36 = var_1 func_1293();
  var_2.var_112DF = var_3;
  if(isDefined(var_1) && isDefined(var_1.var_202A) && var_1.var_202A == 1) {
    var_2.var_5F37 = 1;
  } else {
    var_2.var_5F37 = 0;
  }

  if(isDefined(var_1) && isDefined(level.player) && var_1 == level.player) {
    var_2.var_D43A = 1;
  } else {
    var_2.var_D43A = 0;
  }

  var_2 thread func_200F();
}

func_201A() {
  self endon("entitydeleted");
  self endon("death");
  self waittill("missile_stuck", var_0, var_1, var_2);
  return var_2;
}

func_FF4F(var_0, var_1) {
  if(var_0 scripts\sp\utility::isactorwallrunning()) {
    return 0;
  }

  if(func_3CB0(var_0, var_1)) {
    if(isDefined(var_0.var_1C78)) {
      return var_0.var_1C78;
    }

    if(var_0 func_81A6()) {
      return 0;
    }

    return 1;
  }

  return 0;
}

func_200B() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = self.origin;
  level.var_2006.var_522B[level.var_2006.var_522B.size] = var_0;
  var_0.var_85D2 = 156;
  var_0.var_5F36 = 7;
  var_0 thread func_200F();
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
      var_0 = "antigrav_detonate_cheap";
    } else {
      var_0 = "antigrav_detonate";
    }
  } else if(level.var_2006.var_522B.size > 1) {
    var_0 = "antigrav_detonate_up_cheap";
  } else {
    var_0 = "antigrav_detonate_up";
  }

  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_1 = spawnfx(level._effect[var_0], self.origin, (1, 0, 0), (0, 0, 1));
    triggerfx(var_1);
    self.var_132AA[self.var_132AA.size] = var_1;
  } else {
    playFX(level._effect[var_0], self.origin, (1, 0, 0), (0, 0, 1));
  }

  func_36E1();
  func_1066C();
  lib_0F18::func_10E8A("broadcast", "attack", self.origin, 1000);
  level scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", 0.55);
  var_2 = [];
  foreach(var_4 in getaiarray()) {
    if(func_FF4F(var_4, self)) {
      var_2[var_2.size] = var_4;
    }
  }

  thread scripts\engine\utility::play_loop_sound_on_entity("gravity_field_lp");
  self.var_CB13 = func_4933();
  var_6 = 0;
  var_7 = 0;
  foreach(var_9 in self.var_378E) {
    if(var_9.var_5F15 == 1) {
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
  var_13 = var_12 + var_11 * 0.5;
  if(var_13 < self.origin[2]) {
    var_14 = self.origin;
    var_15 = self.origin[2] - var_11;
  } else {
    var_14 = (self.origin[0], self.origin[1], var_15);
    var_15 = var_13 - var_12 * 0.5;
  }

  func_4926(var_14, var_15);
  scripts\engine\utility::array_thread(var_2, ::func_197D, self);
  func_CF45();
  thread func_FB3E();
  level scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", self.var_5F36);
  thread func_DFC5();
}

func_4926(var_0, var_1) {
  var_2 = ["axis", "allies", "team3", "neutral", "bad_guys"];
  if(!isDefined(level.var_2006.var_5602) || level.var_2006.var_5602.size == 0) {
    self.var_C2CA = func_315(var_0, (self.var_85D2, self.var_85D2, var_1), (0, 0, 0));
    createnavrepulsor("antigrav" + self getentitynumber(), -1, var_0, self.var_85D2, 1);
    return;
  }

  if(level.var_2006.var_5602.size > 0) {
    if(level.var_2006.var_5602[0] == "all") {
      return;
    }

    if(scripts\engine\utility::array_contains(level.var_2006.var_5602, "allies") && scripts\engine\utility::array_contains(level.var_2006.var_5602, "axis")) {
      self.var_C2CA = func_315(var_0, (self.var_85D2, self.var_85D2, var_1), (0, 0, 0), "team3", "neutral", "bad_guys");
      createnavrepulsor("antigrav" + self getentitynumber(), -1, var_0, self.var_85D2, 0, "team3", "neutral", "bad_guys");
      return;
    }

    if(scripts\engine\utility::array_contains(level.var_2006.var_5602, "allies")) {
      self.var_C2CA = func_315(var_0, (self.var_85D2, self.var_85D2, var_1), (0, 0, 0), "axis", "team3", "neutral", "bad_guys");
      createnavrepulsor("antigrav" + self getentitynumber(), -1, var_0, self.var_85D2, 0, "team3", "neutral", "bad_guys");
      return;
    }

    if(scripts\engine\utility::array_contains(level.var_2006.var_5602, "axis")) {
      self.var_C2CA = func_315(var_0, (self.var_85D2, self.var_85D2, var_1), (0, 0, 0), "allies", "team3", "neutral", "bad_guys");
      createnavrepulsor("antigrav" + self getentitynumber(), -1, var_0, self.var_85D2, 0, "team3", "neutral", "bad_guys");
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
    foreach(var_1 in self.var_132AA) {
      var_1 delete();
    }
  }

  if(isDefined(self.var_378D)) {
    var_3 = self.var_378D;
    foreach(var_5 in var_3) {
      func_DFC4(var_5);
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

func_DFC4(var_0) {
  if(isDefined(var_0.var_132AA)) {
    foreach(var_2 in var_0.var_132AA) {
      var_2 delete();
    }
  }

  killfxontag(level._effect["antigrav_caltrop_trail"], var_0, "tag_origin");
  self.var_378D = scripts\engine\utility::array_remove(self.var_378D, var_0);
  var_0 delete();
}

func_DFBA() {
  level notify("removing_all_antigravs_instantly");
  level endon("removing_all_antigravs_instantly");
  scripts\engine\utility::flag_set("antigrav_force_delete");
  foreach(var_1 in level.var_2006.var_522B) {
    var_1 thread func_E057();
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

func_197D(var_0) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(isDefined(self.a) && isDefined(self.a.var_58DA)) {
    self func_81D0();
    return;
  }

  if(self.unittype == "c12") {
    return;
  }

  if(scripts\asm\asm_bb::bb_isanimscripted()) {
    self givescorefortrophyblocks();
  }

  if(!isDefined(self.var_2023)) {
    func_1978(var_0);
    scripts\asm\asm::asm_setstate("antigrav_rise");
    return;
  }

  if(self.var_2023 == "rise" || self.var_2023 == "float_idle") {
    self.var_201D = gettime() + var_0.var_5F36 + randomfloat(0.25) * 1000;
    return;
  }

  if(self.var_2023 == "fall") {
    self.var_201D = gettime() + var_0.var_5F36 + randomfloat(0.25) * 1000;
    self.var_2020 = 1;
    return;
  }

  func_1978(var_0);
  self.var_2020 = 1;
}

func_1978(var_0) {
  self.var_2022 = gettime();
  self.var_201D = self.var_2022 + var_0.var_5F36 + randomfloat(0.25) * 1000;
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
    var_0 = getaiunittypearray("all", "C12");
    foreach(var_2 in var_0) {
      if(!isalive(var_2)) {
        continue;
      }

      if(!isDefined(var_2.var_93B5)) {
        var_2.var_93B5 = 0;
      }

      var_3 = 0;
      foreach(var_5 in level.player.var_D363) {
        if(func_3CB0(var_2, var_5)) {
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        if(!var_2.var_93B5) {
          var_2.var_2015 = var_2.moveplaybackrate;
          var_2.moveplaybackrate = 0.2;
          var_2.var_93B5 = 1;
        }

        continue;
      }

      if(var_2.var_93B5) {
        var_2.moveplaybackrate = var_2.var_2015;
        var_2.var_2015 = undefined;
        var_2.var_93B5 = 0;
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

    var_0 = 0;
    var_1 = 0;
    self.var_4B16 = undefined;
    if(!level.player scripts\sp\utility::func_65DF("disable_antigrav_float") || !level.player scripts\sp\utility::func_65DB("disable_antigrav_float")) {
      foreach(var_3 in self.var_D363) {
        if(func_3CB0(self, var_3)) {
          var_0 = 1;
          self.var_4B16 = var_3;
          if(var_3.new == 1) {
            var_1 = 1;
          }
        }
      }
    }

    if(!self.var_93B5 && var_0) {
      thread func_6228();
      self.var_93B5 = 1;
    } else if(self.var_93B5 && !var_0) {
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

    var_0 = level.player.origin[2] - self.var_4B16.origin[2];
    var_1 = clamp(100 - var_0 / 100, 0, 1);
    var_2 = 50 * var_1;
    var_3 = self getvelocity();
    var_4 = (0, 0, 1);
    var_5 = var_3 + var_4 * var_2;
    self setvelocity(var_5);
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
    level.player waittill("gesture_stopped", var_0);
    if(var_0 == "ges_antigrav_reaction") {
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
    level waittill("ai_killed", var_0, var_1);
    if(isDefined(level.player.var_4B16) && isDefined(level.player.var_4B16.var_D43A) && level.player.var_4B16.var_D43A == 1) {
      if(isDefined(var_0) && isDefined(var_0.team) && var_0.team == "axis") {
        if(isDefined(var_1) && var_1 == level.player) {
          break;
        }
      }
    }
  }

  scripts\sp\utility::settimer("ANTI_GRAV_KILL");
}

func_36E1() {
  var_0 = self.origin;
  self.var_378E = [];
  for(var_1 = 0; var_1 < 12; var_1++) {
    var_2 = 30 * var_1;
    var_3 = self.var_85D2;
    var_4 = func_378C(var_0, var_2, var_3);
    if(isDefined(var_4)) {
      var_5 = spawnStruct();
      var_5.origin = var_4;
      var_5.var_5F15 = 0;
      if(var_4[2] + 256 < var_0[2]) {
        var_5.var_5F15 = 1;
      }

      self.var_378E[self.var_378E.size] = var_5;
    }
  }

  return self.var_378E;
}

func_1066C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = self.origin;
  var_2 = [];
  self.var_378D = [];
  for(var_3 = 0; var_3 < self.var_378E.size; var_3++) {
    var_4 = 0;
    var_5 = 0;
    if(var_3 > 0) {
      var_5 = var_3 - 1;
    } else {
      var_5 = self.var_378E.size - 1;
    }

    if(var_3 < self.var_378E.size - 1) {
      var_4 = var_3 + 1;
    } else {
      var_4 = 0;
    }

    var_6 = self.var_378E[var_4].origin;
    var_7 = self.var_378E[var_5].origin;
    var_8 = scripts\engine\utility::flatten_vector(vectornormalize(var_7 - var_6));
    var_9 = rotatevector(var_8, (0, -90, 0));
    if(length(var_9) == 0) {
      var_9 = vectornormalize(var_1 - self.var_378E[var_3].origin);
      if(length(var_9) == 0) {
        var_9 = (0, 0, 1);
      }
    }

    if(var_0) {
      self.var_378E[var_3].var_5F15 = 1;
    }

    self.var_378D[self.var_378D.size] = func_1066B(var_1, self.var_378E[var_3].origin, var_9, self.var_378E[var_3].var_5F15);
  }

  if(!var_0) {
    if(!self.var_5F37) {
      if(level.var_2006.var_522B.size > 1) {
        var_10 = "antigrav_area_small_cheap";
      } else {
        var_10 = "antigrav_area_small";
      }
    } else if(level.var_2006.var_522B.size > 1) {
      var_10 = "antigrav_area_small_up_cheap";
    } else {
      var_10 = "antigrav_area_small_up";
    }

    if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
      var_11 = spawnfx(level._effect[var_10], var_1, (1, 0, 0), (0, 0, 1));
      func_C0A7(0.55, ::triggerfx, var_11);
      self.var_132AA[self.var_132AA.size] = var_11;
    } else {
      func_C0A7(0.55, ::playfx, level._effect[var_10], var_1, (1, 0, 0), (0, 0, 1));
    }

    var_12 = self.var_85D2 * 0.4;
    var_13 = 0;
    for(var_3 = 0; var_3 < self.var_378E.size; var_3++) {
      if(self.var_378E[var_3].var_5F15) {
        continue;
      }

      var_14 = distance(self.var_378E[var_3].origin, var_1);
      var_15 = vectornormalize(self.var_378E[var_3].origin - var_1);
      if(self.var_378E[var_3].origin[2] < var_1[2]) {
        var_15 = scripts\engine\utility::flatten_vector(var_15);
      }

      var_10 = anglestoright(vectortoangles(var_15));
      var_11 = var_12;
      var_12 = [];
      var_13 = 0;
      while(var_11 < var_14) {
        if(var_13 == 0 && !var_13) {
          var_14 = 0;
          var_12[var_12.size] = ::scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_15, (0, var_14, 0)) * var_11, 12, -1000);
        } else if(var_13 == 1) {
          var_14 = 0;
          var_12[var_12.size] = ::scripts\engine\utility::drop_to_ground(var_1 + rotatevector(var_15, (0, var_14, 0)) * var_11, 12, -1000);
        }

        var_13++;
        var_11 = var_11 + var_12;
      }

      foreach(var_16 in var_12) {
        var_17 = [0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4];
        var_18 = randomint(8);
        var_19 = 0.35 + var_17[var_18];
        var_1A = rotatevector((1, 0, 0), (0, randomfloat(360), 0));
        if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
          var_11 = spawnfx(level._effect[var_10], var_16 + (0, 0, 6), var_1A, (0, 0, 1));
          func_C0A7(var_19, ::triggerfx, var_11);
          self.var_132AA[self.var_132AA.size] = var_11;
          continue;
        }

        func_C0A7(var_19, ::playfx, level._effect[var_10], var_16 + (0, 0, 6), var_1A, (0, 0, 1));
      }

      var_13 = !var_13;
    }
  }
}

func_378A(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, var_1, 0));
  var_4 = scripts\common\trace::ray_trace_passed(var_0 + (0, 0, 48), var_0 + (0, 0, 48) + var_3 * var_2, undefined, scripts\common\trace::create_world_contents());
  return var_4;
}

func_378C(var_0, var_1, var_2) {
  var_3 = anglesToForward((0, var_1, 0));
  var_4 = scripts\common\trace::ray_trace(var_0 + (0, 0, 48), var_0 + (0, 0, 48) + var_3 * var_2, undefined, scripts\common\trace::create_world_contents());
  if(var_4["fraction"] > 0.5) {
    var_5 = var_2 * var_4["fraction"] - 12;
    var_6 = var_0 + var_3 * var_5;
    var_7 = scripts\engine\utility::drop_to_ground(var_6, 50, -1000);
    return var_7;
  }

  return undefined;
}

func_1066B(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  var_4 = vectornormalize(var_1 - var_0);
  var_5 = var_1;
  var_6 = var_0 + (0, 0, 2);
  var_7 = spawn("script_model", var_6);
  var_7.angles = (0, 0, 0);
  var_7.var_132AA = [];
  var_7 setModel("anti_grav_border_wm");
  var_7 glinton(#animtree);
  playFXOnTag(level._effect["antigrav_caltrop_trail"], var_7, "tag_origin");
  var_8 = randomfloatrange(0.3, 0.65);
  thread func_3789(var_7, var_6, var_5, var_8);
  if(!var_3) {
    if(!self.var_5F37) {
      if(level.var_2006.var_522B.size > 1) {
        var_9 = "antigrav_caltrop_barrier_cheap";
      } else {
        var_9 = "antigrav_caltrop_barrier";
      }
    } else if(level.var_2006.var_522B.size > 1) {
      var_9 = "antigrav_caltrop_barrier_up_cheap";
    } else {
      var_9 = "antigrav_caltrop_barrier_up";
    }

    if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
      var_10 = spawnfx(level._effect[var_9], var_1, var_2, (0, 0, 1));
      func_C0A7(var_8, ::triggerfx, var_10);
      var_7.var_132AA[var_7.var_132AA.size] = var_10;
    } else {
      func_C0A7(var_8, ::playfx, level._effect[var_9], var_1, var_2, (0, 0, 1));
    }
  } else {
    level func_5128(var_8, ::func_378B, var_7, var_1, var_2);
  }

  return var_7;
}

func_378B(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    return;
  }

  if(scripts\engine\utility::flag_exist("in_vr_mode") && scripts\engine\utility::flag("in_vr_mode")) {
    var_3 = spawnfx(scripts\engine\utility::getfx("antigrav_detonate_dud"), var_1, var_2, (0, 0, 1));
    triggerfx(var_3);
    var_0.var_132AA[var_0.var_132AA.size] = var_3;
    return;
  }

  playFX(scripts\engine\utility::getfx("antigrav_detonate_dud"), var_1, var_2, (0, 0, 1));
}

func_3789(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_4 = vectornormalize(var_2 - var_1);
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

  var_0 ghost_killed_update_func((randomfloatrange(360, 900), 0, randomfloatrange(360, 900)), var_3 - 0.05);
  var_0 moveto(var_8, var_3 / 4, 0, 0);
  wait(var_3 / 4);
  var_0 moveto(var_9, var_3 / 4, 0, 0);
  wait(var_3 / 4);
  var_0 moveto(var_10, var_3 / 4, 0, 0);
  wait(var_3 / 4);
  var_0 moveto(var_11, var_3 / 4, 0, 0);
  wait(var_3 / 4);
  var_13 = 0.2;
  var_14 = randomfloat(5);
  var_0 ghost_killed_update_func((randomfloatrange(-40, 40), 0, randomfloatrange(-40, 40)), var_13 - 0.05);
  var_0 moveto(var_11 + var_4 * var_14 / 2 + (0, 0, var_14), var_13 / 2, 0, var_13 / 2);
  wait(var_13 / 2);
  var_0 moveto(var_11 + var_4 * var_14, var_13 / 2, var_13 / 2, 0);
  wait(var_13 / 2);
  func_DFC4(var_0);
}

func_3CB0(var_0, var_1) {
  if(distance2d(var_0.origin, var_1.origin) <= var_1.var_85D2) {
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

func_4933() {
  var_0 = physics_volumecreate(self.origin, self.var_85D2, 180);
  var_0 func_8527(0);
  var_0 physics_volumesetactivator(1);
  var_0 physics_volumeenable(1);
  thread func_CB0A(var_0);
  return var_0;
}

func_CB0A(var_0) {
  var_0 endon("destroy_volume");
  var_1 = -0.15;
  var_0 func_852A(1, var_1);
  wait(0.2);
  var_0 func_852A(1, 0);
}

func_52B3(var_0) {
  var_0 notify("destroy_volume");
  var_0 delete();
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

func_C0A7(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread func_C0A8(var_1, var_0, var_2, var_3, var_4, var_5);
}

func_C0A8(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", var_1);
  if(isDefined(var_5)) {
    [[var_0]](var_2, var_3, var_4, var_5);
    return;
  }

  if(isDefined(var_4)) {
    [[var_0]](var_2, var_3, var_4);
    return;
  }

  if(isDefined(var_3)) {
    [[var_0]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    [[var_0]](var_2);
    return;
  }

  [[var_0]]();
}

func_5128(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  thread scripts\engine\utility::delaythread_proc(var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

func_5129(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  self endon("stop_delay_thread");
  scripts\engine\utility::flag_wait_or_timeout("antigrav_force_delete", var_1);
  if(isDefined(var_7)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6, var_7);
    return;
  }

  if(isDefined(var_6)) {
    thread[[var_0]](var_2, var_3, var_4, var_5, var_6);
    return;
  }

  if(isDefined(var_5)) {
    thread[[var_0]](var_2, var_3, var_4, var_5);
    return;
  }

  if(isDefined(var_4)) {
    thread[[var_0]](var_2, var_3, var_4);
    return;
  }

  if(isDefined(var_3)) {
    thread[[var_0]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    thread[[var_0]](var_2);
    return;
  }

  thread[[var_0]]();
}

func_CE2E(var_0) {
  if(scripts\sp\utility::func_9BB2()) {
    return;
  }

  var_1 = spawn("script_origin", self.origin);
  var_1.origin = self.origin;
  var_1.angles = self.angles;
  var_1 linkto(self);
  var_1 playSound(var_0, "sounddone");
  var_1 scripts\engine\utility::waittill_any("sounddone", "antigrav_force_delete");
  var_1 delete();
}