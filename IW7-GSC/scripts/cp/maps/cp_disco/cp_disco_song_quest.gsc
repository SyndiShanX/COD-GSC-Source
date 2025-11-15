/************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco_song_quest.gsc
************************************************************/

song_quest_init() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("start_time_quest_logic");
  scripts\engine\utility::flag_init("radios_constructed");
  scripts\engine\utility::flag_init("midnight");
  scripts\engine\utility::flag_init("june6");
  scripts\engine\utility::flag_init("noCheatTimeQuest");
  scripts\engine\utility::flag_init("midnight_dbg");
  scripts\engine\utility::flag_init("june6_dbg");
  scripts\engine\utility::flag_init("savageCipherDebug");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_set("noCheatTimeQuest");
  thread savage_hot_coffee();
  var_00 = scripts\engine\utility::getstructarray("music_quest_struct", "targetname");
  if(!isDefined(var_00) || var_00.size == 0) {
    return;
  }

  var_01 = build_broadcast_aliases();
  level.radios = [];
  var_02 = [];
  var_00 = scripts\engine\utility::array_randomize_objects(var_00);
  var_03 = 0;
  foreach(var_05 in var_01) {
    var_00[var_03].sound_alias = var_01[var_03];
    var_02[var_02.size] = var_00[var_03];
    thread radio_use_logic(var_00[var_03]);
    level.radios[var_03] = var_00[var_03];
    var_03++;
  }

  scripts\engine\utility::flag_set("radios_constructed");
}

song_quest_interactions() {
  level endon("game_ended");
  self endon("disconnect");
  self.radios_heard = 0;
  scripts\engine\utility::flag_wait("radios_constructed");
  while(self.radios_heard < level.radios.size) {
    scripts\engine\utility::waittill_any_timeout_1(10, "radio_heard");
  }

  thread scripts\cp\cp_vo::try_to_play_vo("song_quest_success", "disco_comment_vo");
  scripts\cp\zombies\achievement::update_achievement("BEAT_OF_THE_DRUM", 1);
  level notify("add_hidden_song_to_playlist");
  level thread play_hidden_song((1785, -2077, 211), "mus_pa_disco_hidden_track", self);
  level notify("song_ee_achievement_given");
}

play_hidden_song(param_00, param_01, param_02) {
  level endon("game_ended");
  if(param_01 == "mus_pa_disco_hidden_track") {
    level endon("add_hidden_song_to_playlist");
  }

  if(soundexists(param_01)) {
    wait(2.5);
    if(scripts\engine\utility::istrue(level.onlinegame)) {
      param_02 setplayerdata("cp", "hasSongsUnlocked", "any_song", 1);
      if(param_01 == "mus_pa_disco_hidden_track") {
        param_02 setplayerdata("cp", "hasSongsUnlocked", "song_4", 1);
      }
    }

    var_03 = undefined;
    if(isDefined(var_03)) {
      level thread scripts\cp\cp_vo::try_to_play_vo(var_03, "zmb_dj_vo", "high", 60, 1, 0, 1);
      var_04 = lookupsoundlength(var_03) / 1000;
      wait(var_04);
    }

    scripts\engine\utility::play_sound_in_space("zmb_jukebox_on", param_00);
    var_05 = spawn("script_origin", param_00);
    var_06 = "ee";
    var_07 = 1;
    param_02 scripts\cp\cp_persistence::give_player_xp(500, 1);
    var_05 playLoopSound(param_01);
    var_05 thread scripts\cp\zombies\zombie_jukebox::earlyendon(var_05);
    var_08 = lookupsoundlength(param_01) / 1000;
    level scripts\engine\utility::waittill_any_timeout_1(var_08, "skip_song");
    var_05 stoploopsound();
    var_05 delete();
  } else {
    wait(2);
  }

  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start(param_00, 1);
}

radio_use_logic(param_00) {
  level endon("game_ended");
  var_01 = spawn("script_model", param_00.origin);
  if(!isDefined(param_00.angles)) {
    var_01.angles = (0, 0, 0);
  } else {
    var_01.angles = param_00.angles;
  }

  var_01 setModel("com_transistor_radio");
  var_02 = param_00.sound_alias;
  var_01 makeusable();
  var_01 setuserange(64);
  var_01 setusefov(120);
  var_01.players_used = [];
  for(;;) {
    var_01 waittill("trigger", var_03);
    if(!scripts\engine\utility::array_contains(var_01.players_used, var_03)) {
      if(var_02 == "disco_dj_eligiblebachelor" && !scripts\engine\utility::flag("savage_treasure")) {
        scripts\engine\utility::flag_set("savage_treasure");
      }

      var_03 playsoundtoplayer(var_02, var_03);
      var_01.players_used[var_01.players_used.size] = var_03;
      if(isDefined(var_03.radios_heard)) {
        var_03.radios_heard++;
        if(var_03.radios_heard == 1) {
          var_03 thread scripts\cp\cp_vo::try_to_play_vo("song_quest_start", "disco_comment_vo");
        }
      }

      var_03 notify("radio_heard");
      var_01 thread remove_radio_for_player(var_03);
    }
  }
}

remove_radio_for_player(param_00) {
  level endon("game_ended");
  self hidefromplayer(param_00);
  param_00 playsoundtoplayer("ninja_zombie_poof_in", param_00);
  var_01 = spawnfxforclient(level._effect["rat_cage_poof"], self.origin, param_00, anglesToForward(self.angles), anglestoup(self.angles));
  wait(0.1);
  triggerfx(var_01);
  wait(1);
  var_01 delete();
}

debug_radio_positions(param_00) {
  level endon("game_ended");
  wait(5);
  param_00 = sortbydistance(param_00, level.players[0].origin);
  for(var_01 = 0; var_01 < param_00.size; var_01++) {
    if(var_01 + 1 != param_00.size) {}
  }
}

build_broadcast_aliases() {
  var_00 = ["disco_dj_oilembargo", "disco_dj_presidentleft", "disco_dj_abyssalesophagus", "disco_dj_ratinfestation", "disco_dj_200thanniversary", "disco_dj_traffic", "disco_dj_eligiblebachelor"];
  return var_00;
}

savage_hot_coffee() {
  level endon("game_ended");
  level.treasure_cans_used = 0;
  scripts\engine\utility::flag_set("noCheatTimeQuest");
  thread setup_working_clocks();
  var_00 = [];
  var_00[0] = spawnStruct();
  var_00[1] = spawnStruct();
  var_00[2] = spawnStruct();
  var_00[3] = spawnStruct();
  var_00[4] = spawnStruct();
  var_00[5] = spawnStruct();
  var_00[6] = spawnStruct();
  var_00[0].stepname = "clock_s_treasure";
  var_00[1].stepname = "dumpster_s_treasure";
  var_00[2].stepname = "stop_s_treasure";
  var_00[3].stepname = "disco_ceil_s_treasure";
  var_00[4].stepname = "sub_wall_s_treasure";
  var_00[5].stepname = "sewer_wall_s_treasure";
  var_00[6].stepname = "kings_lair_s_treasure";
  foreach(var_02 in var_00) {
    var_02 setup_treasure_step();
  }

  level.time_quest_steps = var_00;
  thread flag_set_events();
  scripts\engine\utility::flag_set("start_time_quest_logic");
}

player_set_up_time_quests() {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::flag_wait("start_time_quest_logic");
  var_00 = level.time_quest_steps;
  self.treasure_cans_used = 0;
  var_01 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(!isDefined(var_01)) {
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(0));
    var_01 = 0;
  }

  thread treasure_quest_step_1(var_00[0]);
  thread treasure_quest_step_2(var_00[1]);
  thread treasure_quest_step_3(var_00[2]);
  thread treasure_quest_step_4(var_00[3]);
  thread treasure_quest_step_5(var_00[4]);
  thread treasure_quest_step_6(var_00[5]);
  thread treasure_quest_step_7(var_00[6]);
}

treasure_quest_step_1(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  if(!scripts\engine\utility::flag("savageCipherDebug")) {
    scripts\engine\utility::flag_wait("savage_treasure");
  }

  var_01 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(!isDefined(var_01) || var_01 == 0) {
    var_02 = build_treasure_cipher_word(param_00);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, undefined, undefined, self);
    self.first_cipher_seen = 1;
    var_03 = scripts\engine\utility::getstructarray("trash_cans", "script_noteworthy");
    if(scripts\engine\utility::flag("savageCipherDebug")) {
      thread debug_the_trashcans();
    }

    while(self.treasure_cans_used < var_03.size) {
      self waittill("player_used_trashcan");
    }

    self notify("cipher_1_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(1));
    return;
  }

  var_02 = build_treasure_cipher_word(var_01);
  param_00.loc_struct display_cipher_to_player(var_02, undefined, undefined, undefined, self);
  self.first_cipher_seen = 1;
}

treasure_quest_step_2(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_01 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_01 < 1) {
    self waittill("cipher_1_done");
    var_02 = build_treasure_cipher_word(param_00);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, undefined, undefined, self);
    self notify("cipher_2_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(2));
    return;
  }

  if(var_02 == 1) {
    var_02 = build_treasure_cipher_word(var_01);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, undefined, undefined, self);
    self notify("cipher_2_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(2));
    return;
  }

  var_02 = build_treasure_cipher_word(var_01);
  param_00.loc_struct display_cipher_to_player(var_02, undefined, undefined, undefined, self);
}

treasure_quest_step_3(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  var_01 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_01 < 2) {
    self waittill("cipher_2_done");
    var_02 = build_treasure_cipher_word(param_00);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, 300, undefined, self);
    self notify("cipher_3_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(3));
    return;
  }

  if(var_02 == 2) {
    var_02 = build_treasure_cipher_word(var_01);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, 300, undefined, self);
    self notify("cipher_3_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(3));
    return;
  }

  var_02 = build_treasure_cipher_word(var_01);
  param_00.loc_struct display_cipher_to_player(var_02, undefined, 300, undefined, self);
}

treasure_quest_step_4(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_01 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_01 < 3) {
    self waittill("cipher_3_done");
    var_02 = build_treasure_cipher_word(param_00);
    param_00.loc_struct display_cipher_to_player(var_02, 30, 375, undefined, self);
    self notify("cipher_4_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(4));
    return;
  }

  if(var_02 == 3) {
    var_02 = build_treasure_cipher_word(var_01);
    param_00.loc_struct display_cipher_to_player(var_02, 30, 375, undefined, self);
    self notify("cipher_4_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(4));
    return;
  }

  var_02 = build_treasure_cipher_word(var_01);
  param_00.loc_struct display_cipher_to_player(var_02, 30, 375, undefined, self);
}

treasure_quest_step_5(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_01 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_01 < 4) {
    self waittill("cipher_4_done");
    param_00.loc_struct.origin = (2, 1870.9, 623.2);
    param_00.loc_struct.angles = (0, 90, 0);
    var_02 = build_treasure_cipher_word(param_00);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, 350, undefined, self);
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(5));
    self notify("cipher_5_done");
    return;
  }

  if(var_02 == 4) {
    var_01.loc_struct.origin = (2, 1870.9, 623.2);
    var_01.loc_struct.angles = (0, 90, 0);
    var_02 = build_treasure_cipher_word(var_01);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, 350, undefined, self);
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(5));
    self notify("cipher_5_done");
    return;
  }

  var_01.loc_struct.origin = (2, 1870.9, 623.2);
  var_01.loc_struct.angles = (0, 90, 0);
  var_02 = build_treasure_cipher_word(var_01);
  param_00.loc_struct display_cipher_to_player(var_02, undefined, 350, undefined, self);
}

treasure_quest_step_6(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_01 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_01 < 5) {
    self waittill("cipher_5_done");
    var_02 = build_treasure_cipher_word(param_00);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, 150, "midnight", self);
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(6));
    self notify("cipher_6_done");
    return;
  }

  if(var_02 == 5) {
    var_02 = build_treasure_cipher_word(var_01);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, 150, "midnight", self);
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(6));
    self notify("cipher_6_done");
    return;
  }

  var_02 = build_treasure_cipher_word(var_01);
  param_00.loc_struct display_cipher_to_player(var_02, undefined, 150, "midnight", self);
}

treasure_quest_step_7(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_01 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_01 < 6) {
    self waittill("cipher_6_done");
    var_02 = build_treasure_cipher_word(param_00);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, undefined, "june6", self);
    if(isDefined(level.time_cheater)) {
      return;
    }

    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(7));
    scripts\cp\cp_merits::processmerit("mt_dlc2_troll");
    var_03 = spawnfxforclient(level._effect["trolltastic"], param_00.loc_struct.origin, self, anglesToForward(param_00.loc_struct.angles), anglestoup(param_00.loc_struct.angles));
    var_04 = spawnfxforclient(level._effect["rat_cage_poof"], param_00.loc_struct.origin, self, anglesToForward(param_00.loc_struct.angles), anglestoup(param_00.loc_struct.angles));
    wait(0.1);
    triggerfx(var_04);
    self playsoundtoplayer("ninja_zombie_poof_in", self);
    wait(0.2);
    triggerfx(var_03);
    wait(2);
    self playsoundtoplayer("troll_quest_cat", self);
    wait(8);
    self playsoundtoplayer("troll_quest_cat", self);
    triggerfx(var_04);
    var_03 delete();
    wait(4);
    var_04 delete();
    return;
  }

  if(var_02 == 6) {
    var_02 = build_treasure_cipher_word(var_01);
    param_00.loc_struct display_cipher_to_player(var_02, undefined, undefined, "june6", self);
    if(isDefined(level.time_cheater)) {
      return;
    }

    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(7));
    scripts\cp\cp_merits::processmerit("mt_dlc2_troll");
    var_03 = spawnfxforclient(level._effect["trolltastic"], param_00.loc_struct.origin, self, anglesToForward(param_00.loc_struct.angles), anglestoup(param_00.loc_struct.angles));
    var_04 = spawnfxforclient(level._effect["rat_cage_poof"], param_00.loc_struct.origin, self, anglesToForward(param_00.loc_struct.angles), anglestoup(param_00.loc_struct.angles));
    wait(0.1);
    triggerfx(var_04);
    self playsoundtoplayer("ninja_zombie_poof_in", self);
    wait(0.2);
    triggerfx(var_03);
    wait(2);
    self playsoundtoplayer("troll_quest_cat", self);
    wait(8);
    self playsoundtoplayer("troll_quest_cat", self);
    triggerfx(var_04);
    var_03 delete();
    wait(4);
    var_04 delete();
    return;
  }

  var_02 = build_treasure_cipher_word(var_01);
  param_00.loc_struct display_cipher_to_player(var_02, undefined, undefined, "june6", self);
}

flag_set_events() {
  level endon("game_ended");
  var_00 = 0;
  for(;;) {
    level waittill("time_check", var_01, var_02, var_03, var_04, var_05, var_06);
    if(var_04 == 0 && !scripts\engine\utility::flag("midnight")) {
      scripts\engine\utility::flag_set("midnight");
    } else if(var_04 != 0 && scripts\engine\utility::flag("midnight")) {
      scripts\engine\utility::flag_clear("midnight");
    }

    if(var_04 == 2 && !var_00) {
      level.isdaylightsavings = undefined;
      var_00 = 1;
    }

    if(var_04 != 2 && var_00) {
      var_00 = 0;
    }

    var_07 = is_after_june_5_2017(var_01, var_02, var_03);
    if(var_07 && !scripts\engine\utility::flag("june6")) {
      if(scripts\engine\utility::flag("noCheatTimeQuest")) {
        scripts\engine\utility::flag_set("june6");
      } else if(!isDefined(level.time_cheater)) {
        level.time_cheater = 1;
        scripts\engine\utility::flag_set("june6");
      }

      continue;
    }

    if(!var_07) {
      scripts\engine\utility::flag_clear("june6");
    }
  }
}

is_after_june_5_2017(param_00, param_01, param_02) {
  level endon("game_ended");
  if(param_00 > 2017) {
    return 1;
  }

  if(param_00 == 2017 && param_01 == "July" || param_01 == "August" || param_01 == "September" || param_01 == "October" || param_01 == "November" || param_01 == "December") {
    return 1;
  }

  if(param_00 == 2017 && param_01 == "June" && param_02 >= 6) {
    return 1;
  }

  return 0;
}

display_cipher_to_player(param_00, param_01, param_02, param_03, param_04) {
  level endon("game_ended");
  param_04 endon("disconnect");
  var_05 = 0;
  if(isDefined(param_01)) {
    var_06 = param_01;
  } else {
    var_06 = 60;
  }

  if(isDefined(param_02)) {
    var_07 = param_02 * param_02;
  } else {
    var_07 = 16384;
  }

  while(!var_05) {
    var_08 = distancesquared(param_04.origin, self.origin);
    if(var_08 <= var_07) {
      var_05 = 1;
    } else {
      var_05 = 0;
    }

    if(var_05) {
      var_09 = get_disco_dot(param_04.origin, param_04 getplayerangles(), self.origin);
      if(var_09 >= cos(var_06)) {
        var_05 = 1;
      } else {
        var_05 = 0;
      }
    }

    if(isDefined(param_03) && !scripts\engine\utility::flag(param_03) && !scripts\engine\utility::flag(param_03 + "_dbg")) {
      var_05 = 0;
    }

    wait(1);
  }

  if(isDefined(level.time_cheater)) {
    var_0A = "oyousthoughtnyouncouldnmaniphulateatimetandkgetamyjtreausureiwellrguessdwhatinowiyoullcneverigetoitsyouuareopermlanentlyabannednfromneverdreceiivingtmyifortunedtheredisanorwaydtodgetaitdnowgyoutcheatert";
    param_00 = build_treasure_cipher_word(undefined, var_0A);
    play_cipher_fx(param_00, param_04);
    return;
  }

  play_cipher_fx(param_00, param_04);
}

debug_the_trashcans() {
  level endon("game_ended");
  for(var_00 = scripts\engine\utility::getstructarray("trash_cans", "script_noteworthy"); var_00.size > 0; var_00 = scripts\engine\utility::array_remove(var_00, var_00[0])) {
    var_00 = sortbydistance(var_00, level.players[0].origin);
    level waittill("player_used_trashcan");
  }
}

setup_working_clocks() {
  level endon("game_ended");
  var_00 = getEntArray("working_clock_minute_hand", "targetname");
  var_01 = [];
  foreach(var_03 in var_00) {
    var_04 = getent(var_03.target, "targetname");
    var_01[var_01.size] = var_04;
  }

  foreach(var_03 in var_01) {
    var_03 thread clock_hand_logic(1);
  }

  foreach(var_03 in var_00) {
    var_03 thread clock_hand_logic(0);
  }
}

clock_hand_logic(param_00) {
  level endon("game_ended");
  var_01 = self.angles;
  for(;;) {
    var_02 = get_actual_time_from_civil(5);
    self.angles = var_01;
    if(param_00) {
      if(var_02["hours"] >= 12) {
        var_03 = var_02["hours"] - 12;
      } else {
        var_03 = var_04["hours"];
      }

      var_04 = cp_disco_factor_value(0, 1, cp_disco_normalize_value(0, 60, var_02["minutes"]));
      var_03 = var_03 + var_04;
      var_05 = cp_disco_factor_value(0, 360, cp_disco_normalize_value(0, 12, var_03));
      self.angles = (self.angles[0], self.angles[1], self.angles[2] - var_05);
    } else {
      var_06 = var_02["minutes"];
      var_04 = cp_disco_factor_value(0, 1, cp_disco_normalize_value(0, 60, var_02["seconds"]));
      var_06 = var_06 + var_04;
      var_05 = cp_disco_factor_value(0, 360, cp_disco_normalize_value(0, 60, var_06));
      self.angles = (self.angles[0], self.angles[1], self.angles[2] - var_05);
    }

    for(var_07 = 0; var_07 < 10; var_07++) {
      if(param_00) {
        var_08 = -0.008333334;
        self rotateroll(var_08, 1, 0, 0);
        wait(1);
      } else {
        var_08 = -0.1;
        self rotateroll(var_08, 1, 0, 0);
        wait(1);
      }

      thread get_actual_time_from_civil(5);
    }
  }
}

setup_treasure_step() {
  self.loc_struct = scripts\engine\utility::getstruct(self.stepname, "script_noteworthy");
  switch (self.stepname) {
    case "clock_s_treasure":
      self.words = "mynameisdavidsavageyouseekmytreasuregoodluckfindingitamongstallthegarbageinthiscity";
      break;

    case "dumpster_s_treasure":
      self.words = "icantbelieveyoulookedineverytrashcaninthecitymytreasureisnteventhatgoodjuststopseriouslystop";
      break;

    case "stop_s_treasure":
      self.words = "iguessyouaregoingtocontinuethisinsanequestwellasmyfatheralwayssaidonwardandupward";
      break;

    case "disco_ceil_s_treasure":
      self.words = "ibetyouarewonderingwhyiamgivingawaymyfortunewelltotellyouthatiwouldhavetogobacktowhereitallbegan";
      break;

    case "sub_wall_s_treasure":
      self.words = "wheniwasiyoungiwasmagiftedsingerbutineverdbathetdismelledgawfulbutihadnagreatsetofipipesh";
      break;

    case "sewer_wall_s_treasure":
      self.words = "wellyouhaveudonewellxtomakejitthisfarsthereisnonlyonemoresteptofindakingseransomyoumustfirstfindakingbestoflucki";
      break;

    case "kings_lair_s_treasure":
      self.words = "congratulationsallofyourhardworkhasculminatedinthisgrandacheivementwithoutfurtheradohereismygreatestandmostprecioustreasure";
      break;

    default:
      break;
  }
}

get_actual_time_from_civil(param_00, param_01, param_02) {
  level endon("game_ended");
  if(isDefined(param_01)) {
    var_03 = param_01;
  } else {
    var_03 = getsystemtime();
    if(isDefined(level.isdaylightsavings) && level.isdaylightsavings) {
      var_03 = var_03 + 3600;
    }
  }

  if(isDefined(param_00)) {
    var_03 = var_03 - 3600 * param_00;
  }

  var_03 = var_03 - 1456790400;
  var_04 = 2016;
  var_05 = floor(var_03 / 31536000);
  if(var_05 != 0) {
    var_06 = floor(var_05 / 4);
  } else {
    var_06 = 0;
  }

  var_03 = var_03 - var_05 * 31536000;
  var_03 = var_03 - var_06 * 86400;
  var_04 = var_04 + var_05;
  if(!is_divisible_by(var_04, 4)) {
    var_07 = floor(var_05 / 4);
    var_08 = var_05 / 4;
    var_09 = var_08 - var_07;
    if(var_09 >= 0.75) {
      var_0A = 1;
    } else {
      var_0A = 0;
    }
  } else {
    var_0A = 0;
  }

  if(var_03 != 0) {
    var_0B = floor(var_03 / 86400);
    var_03 = var_03 - var_0B * 86400;
  } else {
    var_0B = 0;
  }

  if(var_03 != 0) {
    var_0C = floor(var_03 / 3600);
    var_03 = var_03 - var_0C * 3600;
  } else {
    var_0C = 0;
  }

  if(var_03 != 0) {
    var_0D = floor(var_03 / 60);
    var_03 = var_03 - var_0D * 60;
  } else {
    var_0D = 0;
  }

  var_0E = determine_correct_month(var_0B + 1);
  var_0E["year"] = var_04;
  var_0E["hours"] = var_0C;
  var_0E["minutes"] = var_0D;
  var_0E["seconds"] = var_03;
  if(isDefined(param_02)) {
    return var_0E;
  }

  if(isDefined(level.isdaylightsavings)) {
    level notify("time_check", var_04, var_0E["month"], var_0E["days"], var_0C, var_0D, var_03);
    return var_0E;
  }

  var_0E = is_daylight_savings(var_0E, param_00, param_01);
  level notify("time_check", var_04, var_0E["month"], var_0E["days"], var_0C, var_0D, var_03);
  return var_0E;
}

is_daylight_savings(param_00, param_01, param_02) {
  var_03 = 0;
  if(param_00["month"] == "March" && param_00["year"] == 2017) {
    var_03 = 1;
  } else if(param_00["month"] == "December" || param_00["month"] == "January" || param_00["month"] == "February") {
    var_03 = 0;
  } else if(param_00["month"] != "March" && param_00["month"] != "April") {
    var_03 = 1;
  } else if(param_00["month"] == "March" && param_00["days"] >= 14) {
    var_03 = 1;
  } else if(param_00["month"] == "November" && param_00["days"] <= 6) {
    var_03 = 0;
  } else {
    var_03 = 0;
  }

  if(var_03) {
    level.isdaylightsavings = 1;
    param_00 = get_actual_time_from_civil(param_01, param_02, 1);
  } else {
    level.isdaylightsavings = 0;
  }

  return param_00;
}

does_day_fit_in_current_month(param_00, param_01, param_02) {
  var_03 = 30;
  switch (param_01) {
    case "January":
      var_03 = 31;
      break;

    case "February":
      if(param_02) {
        var_03 = 29;
      } else {
        var_03 = 28;
      }
      break;

    case "March":
      var_03 = 31;
      break;

    case "April":
      var_03 = 30;
      break;

    case "May":
      var_03 = 31;
      break;

    case "June":
      var_03 = 30;
      break;

    case "July":
      var_03 = 31;
      break;

    case "August":
      var_03 = 31;
      break;

    case "September":
      var_03 = 30;
      break;

    case "October":
      var_03 = 31;
      break;

    case "November":
      var_03 = 30;
      break;

    case "December":
      var_03 = 31;
      break;

    default:
      break;
  }

  if(param_00 > var_03) {
    return 1;
  }

  return 0;
}

determine_correct_month(param_00) {
  var_01 = [];
  var_01["month"] = undefined;
  var_01["days"] = undefined;
  if(param_00 <= 31) {
    var_01["month"] = "March";
    var_01["days"] = param_00;
    return var_01;
  }

  if(param_00 <= 61) {
    var_01["month"] = "April";
    var_01["days"] = param_00 - 31;
    return var_01;
  }

  if(param_00 <= 92) {
    var_01["month"] = "May";
    var_01["days"] = param_00 - 61;
    return var_01;
  }

  if(param_00 <= 122) {
    var_01["month"] = "June";
    var_01["days"] = param_00 - 92;
    return var_01;
  }

  if(param_00 <= 153) {
    var_01["month"] = "July";
    var_01["days"] = param_00 - 122;
    return var_01;
  }

  if(param_00 <= 184) {
    var_01["month"] = "August";
    var_01["days"] = param_00 - 153;
    return var_01;
  }

  if(param_00 <= 214) {
    var_01["month"] = "September";
    var_01["days"] = param_00 - 184;
    return var_01;
  }

  if(param_00 <= 245) {
    var_01["month"] = "October";
    var_01["days"] = param_00 - 214;
    return var_01;
  }

  if(param_00 <= 275) {
    var_01["month"] = "November";
    var_01["days"] = param_00 - 245;
    return var_01;
  }

  if(param_00 <= 306) {
    var_01["month"] = "December";
    var_01["days"] = param_00 - 275;
    return var_01;
  }

  if(param_00 <= 337) {
    var_01["month"] = "January";
    var_01["days"] = param_00 - 306;
    return var_01;
  }

  var_01["month"] = "February";
  var_01["days"] = param_00 - 337;
  return var_01;
}

is_divisible_by(param_00, param_01) {
  if(floor(param_00 / param_01) > param_00 / param_01) {
    return 1;
  }

  return 0;
}

build_treasure_cipher_word(param_00, param_01) {
  level endon("game_ended");
  if(isDefined(param_01)) {
    var_02 = param_01;
  } else {
    var_02 = param_01.words;
  }

  var_03 = [];
  var_04 = 0;
  for(;;) {
    var_05 = getsubstr(var_02, var_04, var_04 + 1);
    if(!isDefined(var_05) || var_05 == "") {
      var_06 = 1;
      break;
    } else {
      var_04++;
      var_03[var_03.size] = var_05;
    }

    wait(0.05);
  }

  return var_03;
}

play_cipher_fx(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("disconnect");
  var_02 = self;
  foreach(var_04 in param_00) {
    var_05 = spawnfxforclient(level._effect["cipher_alphabet_" + var_04], var_02.origin + anglesToForward(var_02.angles + (0, 90, 0)) * -1, param_01, anglesToForward(var_02.angles), anglestoup(var_02.angles));
    wait(0.1);
    triggerfx(var_05);
    wait(0.1);
    var_05 delete();
  }
}

cp_disco_normalize_value(param_00, param_01, param_02) {
  if(param_00 > param_01) {
    var_03 = param_00;
    param_00 = param_01;
    param_01 = var_03;
  }

  if(param_02 > param_01) {
    return 1;
  } else if(param_02 < param_00) {
    return 0;
  } else if(param_00 == param_01) {}

  return param_02 - param_00 / param_01 - param_00;
}

cp_disco_factor_value(param_00, param_01, param_02) {
  return param_01 * param_02 + param_00 * 1 - param_02;
}

get_disco_dot(param_00, param_01, param_02) {
  var_03 = vectornormalize(param_02 - param_00);
  var_04 = anglesToForward(param_01);
  var_05 = vectordot(var_04, var_03);
  return var_05;
}