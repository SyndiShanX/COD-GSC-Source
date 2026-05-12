/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_aachen_aud.gsc
*********************************************/

func_00F9() {
  level thread lib_04F3::func_533A();
  level thread objectivecountdownmusic();
  level.var_777["tank_sherman"] = 7;
  level.var_777["plane_stuka"] = 130;
  level._warvehicledopplerscale["tank_sherman"] = 120;
  level._warvehicledopplerscale["plane_stuka"] = 24;
  level.onhostagedoorbeginuse = ::onhostagedoorbeginuse;
  level.onhostagedoorenduse = ::onhostagedoorenduse;
  level.onhostagebeginuse = ::onhostagebeginuse;
  level.onhostageenduse = ::onhostageenduse;
  level.ondestructionaddobject = ::ondestructionaddobject;
  level.ondestructiondamagecallback = ::ondestructiondamagecallback;
  level.ondestructiblerepairuse = ::ondestructiblerepairuse;
  level thread tankescortsounds();
}

objectivecountdownmusic() {
  level endon("game_ended");
  lib_04F3::func_A785();
  waittillframeend;
  var_00 = lib_02EF::randomarrayelement(["default", "epic", "urban_02a", "urban_02b"]);
  lib_04F3::raidmusicsetcountdown(var_00);
  for(;;) {
    level waittill("objectiveComplete", var_01);
    switch (var_01) {
      default:
        break;

      case "hostage_b":
      case "hostage_a":
        break;

      case "rescue":
      case "tram_fill":
        var_02 = lib_02EF::randomarrayelement(["action_05", "default", "epic", "urban_02a"]);
        lib_04F3::raidmusicsetcountdown(var_02);
        break;

      case "destroy":
        var_02 = lib_02EF::randomarrayelement(["action_05", "default", "urban_02a"]);
        lib_04F3::raidmusicsetcountdown(var_02);
        break;

      case "escort":
        break;
    }
  }
}

footstepnotetrack(param_00) {
  var_01 = self.var_116;
  var_02 = undefined;
  var_03 = 0;
  var_04 = 0;
  if(common_scripts\utility::func_9467(param_00, "footstep_left")) {
    var_02 = function_036D(param_00, "footstep_left_");
    var_01 = self gettagorigin("J_Ankle_LE");
    var_03 = 1;
  } else if(common_scripts\utility::func_9467(param_00, "footstep_right")) {
    var_02 = function_036D(param_00, "footstep_right_");
    var_01 = self gettagorigin("J_Ankle_RI");
    var_03 = 0;
  }

  if(!isDefined(var_02)) {
    return;
  }

  switch (var_02) {
    case "large":
      var_04 = 1;
      break;

    case "step":
    case "small":
      var_04 = 0;
      break;

    default:
      lib_02EF::func_7FF8(var_03, var_04);
      break;

    case "land":
      lib_04F3::func_79CB("step_land_hv_dirt", var_01);
      common_scripts\utility::func_2CB4(0.1, ::lib_04F3::func_79CF, "gear_rattle_crouch_drop", self);
      break;

    case "scuff":
    case "scrape":
      lib_04F3::func_79CB("step_scrape_dirt", var_01);
      break;
  }

  common_scripts\utility::func_2CB4(0.2, ::lib_04F3::func_79CF, "gear_rattle_sprint", self);
}

func_54E4() {
  var_00 = self;
  var_01 = 3;
  var_02 = 6;
  var_03 = 0.2238721;
  var_04 = 1 - var_03;
  var_05 = 14;
  var_06 = 1;
  if(isDefined(level.var_54D0["allies"]) == 1 && isDefined(level.var_54D0["allies"].var_9309) == 1) {}
}

introvignettealliesplayercameramix(param_00) {
  var_01 = self;
  var_02 = 0.2;
  switch (param_00) {
    case 1:
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_01", var_02);
      break;

    case 2:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_01", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_02", var_02);
      break;

    case 3:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_02", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_03", var_02);
      break;

    case 4:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_03", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_04", var_02);
      break;

    case 5:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_04", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_05", var_02);
      break;

    case 6:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_05", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_06", var_02);
      break;

    case 7:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_06", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_07", var_02);
      break;

    case 8:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_07", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_08", var_02);
      level waittill("allies_intro_cleanup");
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_08", 6);
      break;

    default:
      break;
  }
}

outrovignettealliesplayercameramix(param_00) {
  var_01 = self;
  var_02 = 0.2;
  switch (param_00) {
    case 1:
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_outro_allies_01", var_02);
      break;

    case 2:
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_01", var_02);
      break;

    case 3:
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_01", var_02);
      break;

    case 4:
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_01", var_02);
      break;

    default:
      break;
  }
}

func_54E5() {
  var_00 = self;
  var_01 = 3;
  var_02 = 6;
  var_03 = 0.2238721;
  var_04 = 1 - var_03;
  var_05 = 25;
  var_06 = 1;
  if(isDefined(level.var_54D0["allies"]) == 1 && isDefined(level.var_54D0["allies"].var_9309) == 1) {}
}

introvignetteaxisplayercameramix(param_00) {
  var_01 = self;
  var_02 = 0.2;
  switch (param_00) {
    case 1:
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_01", var_02);
      break;

    case 2:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_01", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_02", var_02);
      break;

    case 3:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_02", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_03", var_02);
      break;

    case 4:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_03", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_04", var_02);
      break;

    case 5:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_04", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_05", var_02);
      level waittill("axis_vingnette_end");
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_05", 6);
      break;

    default:
      break;
  }
}

outrovignetteaxisplayercameramix(param_00) {
  var_01 = self;
  var_02 = 0.2;
  switch (param_00) {
    case 1:
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_outro_axis_01", var_02);
      break;

    case 2:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_outro_axis_01", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_outro_axis_02", var_02);
      break;

    case 3:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_outro_axis_02", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_outro_axis_03", var_02);
      break;

    case 4:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_outro_axis_03", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_outro_axis_04", var_02);
      level waittill("axis_outro_cleanup");
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_outro_axis_04", 6);
      break;

    default:
      break;
  }
}

outrovignetteaxisexplos() {
  wait(0.75);
  lib_04F3::func_79CB("stuka_bomb_incoming", (-2645, 3057, 767));
  wait(0.75);
  lib_04F3::func_79CB("axis_win_explo_filler", (-2645, 3057, 767));
  wait(0.75);
  lib_04F3::func_79CB("stuka_bomb_explo", (-2645, 3057, 767));
}

onhostagedoorbeginuse(param_00, param_01) {
  var_02 = param_00.var_982D["visuals"][0];
  if(isDefined(self.var_A238) == 0 && isDefined(var_02) == 1) {
    self.var_A238 = lib_04F3::func_79CF("ob1_allies_lock_pick_lp", var_02, "J_Handle");
  }
}

onhostagedoorenduse(param_00, param_01) {
  if(isDefined(self.var_A238) == 1) {
    lib_04F3::func_79D0(self.var_A238, 0.1);
    self.var_A238 = undefined;
  }

  if(isDefined(self.doorunlocked) == 1 && self.doorunlocked == 1) {
    wait(0.1);
    lib_04F3::raidmusiconteam("attackers", "stinger_pos", "stinger_neg");
  }
}

onhostagebeginuse(param_00) {
  var_01 = self.hostagevisual.bodymodel;
  if(isDefined(self.var_A238) == 0 && isDefined(var_01) == 1) {
    self.var_A238 = lib_04F3::func_79CF("ob1_allies_rope_untie", var_01, "J_MainRoot");
  }
}

onhostageenduse(param_00, param_01) {
  wait 0.05;
  if(isDefined(self.hostageused) && self.hostageused == 1) {
    if(level.raidhostagecount > 0) {
      wait(0.1);
      lib_04F3::raidmusiconteam("attackers", "stinger_pos", "stinger_neg");
    }

    var_02 = self.hostagevisual.bodymodel;
    var_03 = var_02.var_106;
    var_04 = getsubstr(var_02.var_106, 23, 24);
    if(isDefined(var_02) == 1 && isDefined(var_03) == 1) {
      wait(2.9);
      switch (var_04) {
        case "f":
          lib_04F3::func_79CF("ob1_rescue_female", var_02, "j_head");
          break;

        case "m":
          lib_04F3::func_79CF("ob1_rescue_male", var_02, "j_head");
          break;
      }

      return;
    }

    return;
  }

  if(isDefined(self.var_A238) == 1) {
    lib_04F3::func_79D0(self.var_A238, 0.1);
    self.var_A238 = undefined;
  }
}

ondestructionaddobject(param_00) {
  var_01 = [];
  var_01["small"] = (0, 0, 8);
  var_01["medium"] = (0, 0, 48);
  var_01["large"] = (0, 0, 64);
  ondestructionaddobjectwait();
  if(isDefined(param_00) == 1 && function_0279(param_00) == 0 && isDefined(param_00.ambientsoundlp) == 0) {
    var_02 = param_00.var_6E56["size"];
    var_03 = "ob2_comm_amb_sml_lp";
    var_04 = param_00.var_116;
    var_05 = isDefined(param_00.var_6E56["sndcluster"]);
    var_06 = var_04[2] > 512;
    switch (var_02) {
      case "small":
      default:
        var_03 = "ob2_comm_amb_sml_lp";
        var_04 = var_04 + var_01["small"];
        break;

      case "medium":
        var_03 = "ob2_comm_amb_med_lp";
        var_04 = var_04 + var_01["medium"];
        break;

      case "large":
        var_03 = "ob2_comm_amb_lrg_lp";
        var_04 = var_04 + var_01["large"];
        break;
    }

    param_00.ambientsoundlp = lib_02F0::func_8012("clientsnd", var_03, var_04);
    param_00.ambientsoundstage = param_00.var_3F7C;
    if(isDefined(param_00.ambientsoundlp) == 1 && var_05 == 1) {
      var_07 = 0.7079458;
      param_00.ambientsoundlp lib_02EF::func_8AAF(var_07, 0);
    }
  }
}

ondestructionaddobjectwait() {
  if(!isDefined(level.ondestructionaddobjectplays)) {
    level.ondestructionaddobjectplays = 0;
  }

  for(;;) {
    level thread ondestructionaddobjectclearcount();
    if(level.ondestructionaddobjectplays < 3) {
      level.ondestructionaddobjectplays++;
      return;
    }

    wait 0.05;
  }
}

ondestructionaddobjectclearcount() {
  level notify("onDestructionAddObjectClearCount");
  level endon("onDestructionAddObjectClearCount");
  waittillframeend;
  level.ondestructionaddobjectplays = 0;
}

ondestructiondamagecallback(param_00, param_01, param_02, param_03, param_04, param_05) {
  lib_04F3::func_79CB("ob2_comm_bullet_hit", param_03);
  if(isPlayer(param_05) == 1) {
    lib_04F3::func_79CD("mp_war_hit_destructible", param_05);
  }

  wait 0.05;
  var_06 = param_00.var_29DD.size - 1;
  var_07 = param_00.var_3F7C;
  if(isDefined(param_00) == 1 && function_0279(param_00) == 0 && var_07 == var_06 && isDefined(param_00.ambientsoundlp) == 1) {
    param_00.ambientsoundlp lib_02EF::func_8AAC(0.5, 0.25);
    lib_04F3::func_79D0(param_00.ambientsoundlp, 0.25);
    param_00.ambientsoundlp = undefined;
    return;
  }

  if(isDefined(param_00.ambientsoundlp) == 1 && param_00.ambientsoundstage != var_07) {
    if(var_07 >= 0) {
      var_08 = 1 + var_07;
      var_09 = 0.9438743 / var_08;
      param_00.ambientsoundlp lib_02EF::func_8AAC(var_09, 0.5);
    } else {
      param_00.ambientsoundlp lib_02EF::func_8AAC(1, 0.5);
    }

    param_00.ambientsoundstage = param_00.var_3F7C;
  }
}

ondestructiblerepairuse(param_00) {
  if(isDefined(param_00) == 1 && param_00 == 1) {
    ondestructionaddobject(self);
  }
}

tankescortsounds() {
  var_00 = (-1104, 3232, 864);
  level waittill("runEscortObjective");
  wait(13);
  lib_04F3::func_79CB("aachen_train_whistle_end_1", var_00);
  level waittill("escortVehicleReachedCheckpoint");
  wait(2);
  lib_04F3::func_79CB("aachen_train_whistle_end_2", var_00);
  level waittill("escortVehicleReachedCheckpoint");
  wait(2);
  lib_04F3::func_79CB("aachen_train_whistle_end_3", var_00);
}