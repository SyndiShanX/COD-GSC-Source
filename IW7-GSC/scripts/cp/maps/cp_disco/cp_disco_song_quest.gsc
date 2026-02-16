/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
  var_0 = scripts\engine\utility::getStructArray("music_quest_struct", "targetname");
  if(!isDefined(var_0) || var_0.size == 0) {
    return;
  }

  var_1 = build_broadcast_aliases();
  level.radios = [];
  var_2 = [];
  var_0 = scripts\engine\utility::array_randomize_objects(var_0);
  var_3 = 0;
  foreach(var_5 in var_1) {
    var_0[var_3].sound_alias = var_1[var_3];
    var_2[var_2.size] = var_0[var_3];
    thread radio_use_logic(var_0[var_3]);
    level.radios[var_3] = var_0[var_3];
    var_3++;
  }

  scripts\engine\utility::flag_set("radios_constructed");
}

song_quest_interactions() {
  level endon("game_ended");
  self endon("disconnect");
  self.radios_heard = 0;
  scripts\engine\utility::flag_wait("radios_constructed");
  while(self.radios_heard < level.radios.size) {
    scripts\engine\utility::waittill_any_timeout(10, "radio_heard");
  }

  thread scripts\cp\cp_vo::try_to_play_vo("song_quest_success", "disco_comment_vo");
  scripts\cp\zombies\achievement::update_achievement("BEAT_OF_THE_DRUM", 1);
  level notify("add_hidden_song_to_playlist");
  level thread play_hidden_song((1785, -2077, 211), "mus_pa_disco_hidden_track", self);
  level notify("song_ee_achievement_given");
}

play_hidden_song(var_0, var_1, var_2) {
  level endon("game_ended");
  if(var_1 == "mus_pa_disco_hidden_track") {
    level endon("add_hidden_song_to_playlist");
  }

  if(soundexists(var_1)) {
    wait(2.5);
    if(scripts\engine\utility::istrue(level.onlinegame)) {
      var_2 setplayerdata("cp", "hasSongsUnlocked", "any_song", 1);
      if(var_1 == "mus_pa_disco_hidden_track") {
        var_2 setplayerdata("cp", "hasSongsUnlocked", "song_4", 1);
      }
    }

    var_3 = undefined;
    if(isDefined(var_3)) {
      level thread scripts\cp\cp_vo::try_to_play_vo(var_3, "zmb_dj_vo", "high", 60, 1, 0, 1);
      var_4 = lookupsoundlength(var_3) / 1000;
      wait(var_4);
    }

    scripts\engine\utility::play_sound_in_space("zmb_jukebox_on", var_0);
    var_5 = spawn("script_origin", var_0);
    var_6 = "ee";
    var_7 = 1;
    var_2 scripts\cp\cp_persistence::give_player_xp(500, 1);
    var_5 playLoopSound(var_1);
    var_5 thread scripts\cp\zombies\zombie_jukebox::earlyendon(var_5);
    var_8 = lookupsoundlength(var_1) / 1000;
    level scripts\engine\utility::waittill_any_timeout(var_8, "skip_song");
    var_5 stoploopsound();
    var_5 delete();
  } else {
    wait(2);
  }

  level thread scripts\cp\zombies\zombie_jukebox::jukebox_start(var_0, 1);
}

radio_use_logic(var_0) {
  level endon("game_ended");
  var_1 = spawn("script_model", var_0.origin);
  if(!isDefined(var_0.angles)) {
    var_1.angles = (0, 0, 0);
  } else {
    var_1.angles = var_0.angles;
  }

  var_1 setModel("com_transistor_radio");
  var_2 = var_0.sound_alias;
  var_1 makeusable();
  var_1 setuserange(64);
  var_1 setusefov(120);
  var_1.players_used = [];
  for(;;) {
    var_1 waittill("trigger", var_3);
    if(!scripts\engine\utility::array_contains(var_1.players_used, var_3)) {
      if(var_2 == "disco_dj_eligiblebachelor" && !scripts\engine\utility::flag("savage_treasure")) {
        scripts\engine\utility::flag_set("savage_treasure");
      }

      var_3 playsoundtoplayer(var_2, var_3);
      var_1.players_used[var_1.players_used.size] = var_3;
      if(isDefined(var_3.radios_heard)) {
        var_3.radios_heard++;
        if(var_3.radios_heard == 1) {
          var_3 thread scripts\cp\cp_vo::try_to_play_vo("song_quest_start", "disco_comment_vo");
        }
      }

      var_3 notify("radio_heard");
      var_1 thread remove_radio_for_player(var_3);
    }
  }
}

remove_radio_for_player(var_0) {
  level endon("game_ended");
  self hidefromplayer(var_0);
  var_0 playsoundtoplayer("ninja_zombie_poof_in", var_0);
  var_1 = spawnfxforclient(level._effect["rat_cage_poof"], self.origin, var_0, anglesToForward(self.angles), anglestoup(self.angles));
  wait(0.1);
  triggerfx(var_1);
  wait(1);
  var_1 delete();
}

debug_radio_positions(var_0) {
  level endon("game_ended");
  wait(5);
  var_0 = sortbydistance(var_0, level.players[0].origin);
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_1 + 1 != var_0.size) {}
  }
}

build_broadcast_aliases() {
  var_0 = ["disco_dj_oilembargo", "disco_dj_presidentleft", "disco_dj_abyssalesophagus", "disco_dj_ratinfestation", "disco_dj_200thanniversary", "disco_dj_traffic", "disco_dj_eligiblebachelor"];
  return var_0;
}

savage_hot_coffee() {
  level endon("game_ended");
  level.treasure_cans_used = 0;
  scripts\engine\utility::flag_set("noCheatTimeQuest");
  thread setup_working_clocks();
  var_0 = [];
  var_0[0] = spawnStruct();
  var_0[1] = spawnStruct();
  var_0[2] = spawnStruct();
  var_0[3] = spawnStruct();
  var_0[4] = spawnStruct();
  var_0[5] = spawnStruct();
  var_0[6] = spawnStruct();
  var_0[0].stepname = "clock_s_treasure";
  var_0[1].stepname = "dumpster_s_treasure";
  var_0[2].stepname = "stop_s_treasure";
  var_0[3].stepname = "disco_ceil_s_treasure";
  var_0[4].stepname = "sub_wall_s_treasure";
  var_0[5].stepname = "sewer_wall_s_treasure";
  var_0[6].stepname = "kings_lair_s_treasure";
  foreach(var_2 in var_0) {
    var_2 setup_treasure_step();
  }

  level.time_quest_steps = var_0;
  thread flag_set_events();
  scripts\engine\utility::flag_set("start_time_quest_logic");
}

player_set_up_time_quests() {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::flag_wait("start_time_quest_logic");
  var_0 = level.time_quest_steps;
  self.treasure_cans_used = 0;
  var_1 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(!isDefined(var_1)) {
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(0));
    var_1 = 0;
  }

  thread treasure_quest_step_1(var_0[0]);
  thread treasure_quest_step_2(var_0[1]);
  thread treasure_quest_step_3(var_0[2]);
  thread treasure_quest_step_4(var_0[3]);
  thread treasure_quest_step_5(var_0[4]);
  thread treasure_quest_step_6(var_0[5]);
  thread treasure_quest_step_7(var_0[6]);
}

treasure_quest_step_1(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  if(!scripts\engine\utility::flag("savageCipherDebug")) {
    scripts\engine\utility::flag_wait("savage_treasure");
  }

  var_1 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(!isDefined(var_1) || var_1 == 0) {
    var_2 = build_treasure_cipher_word(var_0);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, undefined, undefined, self);
    self.first_cipher_seen = 1;
    var_3 = scripts\engine\utility::getStructArray("trash_cans", "script_noteworthy");
    if(scripts\engine\utility::flag("savageCipherDebug")) {
      thread debug_the_trashcans();
    }

    while(self.treasure_cans_used < var_3.size) {
      self waittill("player_used_trashcan");
    }

    self notify("cipher_1_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(1));
    return;
  }

  var_2 = build_treasure_cipher_word(var_1);
  var_0.loc_struct display_cipher_to_player(var_2, undefined, undefined, undefined, self);
  self.first_cipher_seen = 1;
}

treasure_quest_step_2(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_1 < 1) {
    self waittill("cipher_1_done");
    var_2 = build_treasure_cipher_word(var_0);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, undefined, undefined, self);
    self notify("cipher_2_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(2));
    return;
  }

  if(var_2 == 1) {
    var_2 = build_treasure_cipher_word(var_1);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, undefined, undefined, self);
    self notify("cipher_2_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(2));
    return;
  }

  var_2 = build_treasure_cipher_word(var_1);
  var_0.loc_struct display_cipher_to_player(var_2, undefined, undefined, undefined, self);
}

treasure_quest_step_3(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_1 < 2) {
    self waittill("cipher_2_done");
    var_2 = build_treasure_cipher_word(var_0);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, 300, undefined, self);
    self notify("cipher_3_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(3));
    return;
  }

  if(var_2 == 2) {
    var_2 = build_treasure_cipher_word(var_1);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, 300, undefined, self);
    self notify("cipher_3_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(3));
    return;
  }

  var_2 = build_treasure_cipher_word(var_1);
  var_0.loc_struct display_cipher_to_player(var_2, undefined, 300, undefined, self);
}

treasure_quest_step_4(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_1 < 3) {
    self waittill("cipher_3_done");
    var_2 = build_treasure_cipher_word(var_0);
    var_0.loc_struct display_cipher_to_player(var_2, 30, 375, undefined, self);
    self notify("cipher_4_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(4));
    return;
  }

  if(var_2 == 3) {
    var_2 = build_treasure_cipher_word(var_1);
    var_0.loc_struct display_cipher_to_player(var_2, 30, 375, undefined, self);
    self notify("cipher_4_done");
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(4));
    return;
  }

  var_2 = build_treasure_cipher_word(var_1);
  var_0.loc_struct display_cipher_to_player(var_2, 30, 375, undefined, self);
}

treasure_quest_step_5(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_1 < 4) {
    self waittill("cipher_4_done");
    var_0.loc_struct.origin = (2, 1870.9, 623.2);
    var_0.loc_struct.angles = (0, 90, 0);
    var_2 = build_treasure_cipher_word(var_0);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, 350, undefined, self);
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(5));
    self notify("cipher_5_done");
    return;
  }

  if(var_2 == 4) {
    var_1.loc_struct.origin = (2, 1870.9, 623.2);
    var_1.loc_struct.angles = (0, 90, 0);
    var_2 = build_treasure_cipher_word(var_1);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, 350, undefined, self);
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(5));
    self notify("cipher_5_done");
    return;
  }

  var_1.loc_struct.origin = (2, 1870.9, 623.2);
  var_1.loc_struct.angles = (0, 90, 0);
  var_2 = build_treasure_cipher_word(var_1);
  var_0.loc_struct display_cipher_to_player(var_2, undefined, 350, undefined, self);
}

treasure_quest_step_6(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_1 < 5) {
    self waittill("cipher_5_done");
    var_2 = build_treasure_cipher_word(var_0);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, 150, "midnight", self);
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(6));
    self notify("cipher_6_done");
    return;
  }

  if(var_2 == 5) {
    var_2 = build_treasure_cipher_word(var_1);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, 150, "midnight", self);
    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(6));
    self notify("cipher_6_done");
    return;
  }

  var_2 = build_treasure_cipher_word(var_1);
  var_0.loc_struct display_cipher_to_player(var_2, undefined, 150, "midnight", self);
}

treasure_quest_step_7(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = self getplayerdata("cp", "coopCareerStats", "dlc2_quest");
  if(var_1 < 6) {
    self waittill("cipher_6_done");
    var_2 = build_treasure_cipher_word(var_0);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, undefined, "june6", self);
    if(isDefined(level.time_cheater)) {
      return;
    }

    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(7));
    scripts\cp\cp_merits::processmerit("mt_dlc2_troll");
    var_3 = spawnfxforclient(level._effect["trolltastic"], var_0.loc_struct.origin, self, anglesToForward(var_0.loc_struct.angles), anglestoup(var_0.loc_struct.angles));
    var_4 = spawnfxforclient(level._effect["rat_cage_poof"], var_0.loc_struct.origin, self, anglesToForward(var_0.loc_struct.angles), anglestoup(var_0.loc_struct.angles));
    wait(0.1);
    triggerfx(var_4);
    self playsoundtoplayer("ninja_zombie_poof_in", self);
    wait(0.2);
    triggerfx(var_3);
    wait(2);
    self playsoundtoplayer("troll_quest_cat", self);
    wait(8);
    self playsoundtoplayer("troll_quest_cat", self);
    triggerfx(var_4);
    var_3 delete();
    wait(4);
    var_4 delete();
    return;
  }

  if(var_2 == 6) {
    var_2 = build_treasure_cipher_word(var_1);
    var_0.loc_struct display_cipher_to_player(var_2, undefined, undefined, "june6", self);
    if(isDefined(level.time_cheater)) {
      return;
    }

    self setplayerdata("cp", "coopCareerStats", "dlc2_quest", int(7));
    scripts\cp\cp_merits::processmerit("mt_dlc2_troll");
    var_3 = spawnfxforclient(level._effect["trolltastic"], var_0.loc_struct.origin, self, anglesToForward(var_0.loc_struct.angles), anglestoup(var_0.loc_struct.angles));
    var_4 = spawnfxforclient(level._effect["rat_cage_poof"], var_0.loc_struct.origin, self, anglesToForward(var_0.loc_struct.angles), anglestoup(var_0.loc_struct.angles));
    wait(0.1);
    triggerfx(var_4);
    self playsoundtoplayer("ninja_zombie_poof_in", self);
    wait(0.2);
    triggerfx(var_3);
    wait(2);
    self playsoundtoplayer("troll_quest_cat", self);
    wait(8);
    self playsoundtoplayer("troll_quest_cat", self);
    triggerfx(var_4);
    var_3 delete();
    wait(4);
    var_4 delete();
    return;
  }

  var_2 = build_treasure_cipher_word(var_1);
  var_0.loc_struct display_cipher_to_player(var_2, undefined, undefined, "june6", self);
}

flag_set_events() {
  level endon("game_ended");
  var_0 = 0;
  for(;;) {
    level waittill("time_check", var_1, var_2, var_3, var_4, var_5, var_6);
    if(var_4 == 0 && !scripts\engine\utility::flag("midnight")) {
      scripts\engine\utility::flag_set("midnight");
    } else if(var_4 != 0 && scripts\engine\utility::flag("midnight")) {
      scripts\engine\utility::flag_clear("midnight");
    }

    if(var_4 == 2 && !var_0) {
      level.isdaylightsavings = undefined;
      var_0 = 1;
    }

    if(var_4 != 2 && var_0) {
      var_0 = 0;
    }

    var_7 = is_after_june_5_2017(var_1, var_2, var_3);
    if(var_7 && !scripts\engine\utility::flag("june6")) {
      if(scripts\engine\utility::flag("noCheatTimeQuest")) {
        scripts\engine\utility::flag_set("june6");
      } else if(!isDefined(level.time_cheater)) {
        level.time_cheater = 1;
        scripts\engine\utility::flag_set("june6");
      }

      continue;
    }

    if(!var_7) {
      scripts\engine\utility::flag_clear("june6");
    }
  }
}

is_after_june_5_2017(var_0, var_1, var_2) {
  level endon("game_ended");
  if(var_0 > 2017) {
    return 1;
  }

  if(var_0 == 2017 && var_1 == "July" || var_1 == "August" || var_1 == "September" || var_1 == "October" || var_1 == "November" || var_1 == "December") {
    return 1;
  }

  if(var_0 == 2017 && var_1 == "June" && var_2 >= 6) {
    return 1;
  }

  return 0;
}

display_cipher_to_player(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_4 endon("disconnect");
  var_5 = 0;
  if(isDefined(var_1)) {
    var_6 = var_1;
  } else {
    var_6 = 60;
  }

  if(isDefined(var_2)) {
    var_7 = var_2 * var_2;
  } else {
    var_7 = 16384;
  }

  while(!var_5) {
    var_8 = distancesquared(var_4.origin, self.origin);
    if(var_8 <= var_7) {
      var_5 = 1;
    } else {
      var_5 = 0;
    }

    if(var_5) {
      var_9 = get_disco_dot(var_4.origin, var_4 getplayerangles(), self.origin);
      if(var_9 >= cos(var_6)) {
        var_5 = 1;
      } else {
        var_5 = 0;
      }
    }

    if(isDefined(var_3) && !scripts\engine\utility::flag(var_3) && !scripts\engine\utility::flag(var_3 + "_dbg")) {
      var_5 = 0;
    }

    wait(1);
  }

  if(isDefined(level.time_cheater)) {
    var_10 = "oyousthoughtnyouncouldnmaniphulateatimetandkgetamyjtreausureiwellrguessdwhatinowiyoullcneverigetoitsyouuareopermlanentlyabannednfromneverdreceiivingtmyifortunedtheredisanorwaydtodgetaitdnowgyoutcheatert";
    var_0 = build_treasure_cipher_word(undefined, var_10);
    play_cipher_fx(var_0, var_4);
    return;
  }

  play_cipher_fx(var_0, var_4);
}

debug_the_trashcans() {
  level endon("game_ended");
  for(var_0 = scripts\engine\utility::getStructArray("trash_cans", "script_noteworthy"); var_0.size > 0; var_0 = scripts\engine\utility::array_remove(var_0, var_0[0])) {
    var_0 = sortbydistance(var_0, level.players[0].origin);
    level waittill("player_used_trashcan");
  }
}

setup_working_clocks() {
  level endon("game_ended");
  var_0 = getEntArray("working_clock_minute_hand", "targetname");
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = getent(var_3.target, "targetname");
    var_1[var_1.size] = var_4;
  }

  foreach(var_3 in var_1) {
    var_3 thread clock_hand_logic(1);
  }

  foreach(var_3 in var_0) {
    var_3 thread clock_hand_logic(0);
  }
}

clock_hand_logic(var_0) {
  level endon("game_ended");
  var_1 = self.angles;
  for(;;) {
    var_2 = get_actual_time_from_civil(5);
    self.angles = var_1;
    if(var_0) {
      if(var_2["hours"] >= 12) {
        var_3 = var_2["hours"] - 12;
      } else {
        var_3 = var_4["hours"];
      }

      var_4 = cp_disco_factor_value(0, 1, cp_disco_normalize_value(0, 60, var_2["minutes"]));
      var_3 = var_3 + var_4;
      var_5 = cp_disco_factor_value(0, 360, cp_disco_normalize_value(0, 12, var_3));
      self.angles = (self.angles[0], self.angles[1], self.angles[2] - var_5);
    } else {
      var_6 = var_2["minutes"];
      var_4 = cp_disco_factor_value(0, 1, cp_disco_normalize_value(0, 60, var_2["seconds"]));
      var_6 = var_6 + var_4;
      var_5 = cp_disco_factor_value(0, 360, cp_disco_normalize_value(0, 60, var_6));
      self.angles = (self.angles[0], self.angles[1], self.angles[2] - var_5);
    }

    for(var_7 = 0; var_7 < 10; var_7++) {
      if(var_0) {
        var_8 = -0.008333334;
        self rotateroll(var_8, 1, 0, 0);
        wait(1);
      } else {
        var_8 = -0.1;
        self rotateroll(var_8, 1, 0, 0);
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

get_actual_time_from_civil(var_0, var_1, var_2) {
  level endon("game_ended");
  if(isDefined(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = getsystemtime();
    if(isDefined(level.isdaylightsavings) && level.isdaylightsavings) {
      var_3 = var_3 + 3600;
    }
  }

  if(isDefined(var_0)) {
    var_3 = var_3 - 3600 * var_0;
  }

  var_3 = var_3 - 1456790400;
  var_4 = 2016;
  var_5 = floor(var_3 / 31536000);
  if(var_5 != 0) {
    var_6 = floor(var_5 / 4);
  } else {
    var_6 = 0;
  }

  var_3 = var_3 - var_5 * 31536000;
  var_3 = var_3 - var_6 * 86400;
  var_4 = var_4 + var_5;
  if(!is_divisible_by(var_4, 4)) {
    var_7 = floor(var_5 / 4);
    var_8 = var_5 / 4;
    var_9 = var_8 - var_7;
    if(var_9 >= 0.75) {
      var_10 = 1;
    } else {
      var_10 = 0;
    }
  } else {
    var_10 = 0;
  }

  if(var_3 != 0) {
    var_11 = floor(var_3 / 86400);
    var_3 = var_3 - var_11 * 86400;
  } else {
    var_11 = 0;
  }

  if(var_3 != 0) {
    var_12 = floor(var_3 / 3600);
    var_3 = var_3 - var_12 * 3600;
  } else {
    var_12 = 0;
  }

  if(var_3 != 0) {
    var_13 = floor(var_3 / 60);
    var_3 = var_3 - var_13 * 60;
  } else {
    var_13 = 0;
  }

  var_14 = determine_correct_month(var_11 + 1);
  var_14["year"] = var_4;
  var_14["hours"] = var_12;
  var_14["minutes"] = var_13;
  var_14["seconds"] = var_3;
  if(isDefined(var_2)) {
    return var_14;
  }

  if(isDefined(level.isdaylightsavings)) {
    level notify("time_check", var_4, var_14["month"], var_14["days"], var_12, var_13, var_3);
    return var_14;
  }

  var_14 = is_daylight_savings(var_14, var_0, var_1);
  level notify("time_check", var_4, var_14["month"], var_14["days"], var_12, var_13, var_3);
  return var_14;
}

is_daylight_savings(var_0, var_1, var_2) {
  var_3 = 0;
  if(var_0["month"] == "March" && var_0["year"] == 2017) {
    var_3 = 1;
  } else if(var_0["month"] == "December" || var_0["month"] == "January" || var_0["month"] == "February") {
    var_3 = 0;
  } else if(var_0["month"] != "March" && var_0["month"] != "April") {
    var_3 = 1;
  } else if(var_0["month"] == "March" && var_0["days"] >= 14) {
    var_3 = 1;
  } else if(var_0["month"] == "November" && var_0["days"] <= 6) {
    var_3 = 0;
  } else {
    var_3 = 0;
  }

  if(var_3) {
    level.isdaylightsavings = 1;
    var_0 = get_actual_time_from_civil(var_1, var_2, 1);
  } else {
    level.isdaylightsavings = 0;
  }

  return var_0;
}

does_day_fit_in_current_month(var_0, var_1, var_2) {
  var_3 = 30;
  switch (var_1) {
    case "January":
      var_3 = 31;
      break;

    case "February":
      if(var_2) {
        var_3 = 29;
      } else {
        var_3 = 28;
      }
      break;

    case "March":
      var_3 = 31;
      break;

    case "April":
      var_3 = 30;
      break;

    case "May":
      var_3 = 31;
      break;

    case "June":
      var_3 = 30;
      break;

    case "July":
      var_3 = 31;
      break;

    case "August":
      var_3 = 31;
      break;

    case "September":
      var_3 = 30;
      break;

    case "October":
      var_3 = 31;
      break;

    case "November":
      var_3 = 30;
      break;

    case "December":
      var_3 = 31;
      break;

    default:
      break;
  }

  if(var_0 > var_3) {
    return 1;
  }

  return 0;
}

determine_correct_month(var_0) {
  var_1 = [];
  var_1["month"] = undefined;
  var_1["days"] = undefined;
  if(var_0 <= 31) {
    var_1["month"] = "March";
    var_1["days"] = var_0;
    return var_1;
  }

  if(var_0 <= 61) {
    var_1["month"] = "April";
    var_1["days"] = var_0 - 31;
    return var_1;
  }

  if(var_0 <= 92) {
    var_1["month"] = "May";
    var_1["days"] = var_0 - 61;
    return var_1;
  }

  if(var_0 <= 122) {
    var_1["month"] = "June";
    var_1["days"] = var_0 - 92;
    return var_1;
  }

  if(var_0 <= 153) {
    var_1["month"] = "July";
    var_1["days"] = var_0 - 122;
    return var_1;
  }

  if(var_0 <= 184) {
    var_1["month"] = "August";
    var_1["days"] = var_0 - 153;
    return var_1;
  }

  if(var_0 <= 214) {
    var_1["month"] = "September";
    var_1["days"] = var_0 - 184;
    return var_1;
  }

  if(var_0 <= 245) {
    var_1["month"] = "October";
    var_1["days"] = var_0 - 214;
    return var_1;
  }

  if(var_0 <= 275) {
    var_1["month"] = "November";
    var_1["days"] = var_0 - 245;
    return var_1;
  }

  if(var_0 <= 306) {
    var_1["month"] = "December";
    var_1["days"] = var_0 - 275;
    return var_1;
  }

  if(var_0 <= 337) {
    var_1["month"] = "January";
    var_1["days"] = var_0 - 306;
    return var_1;
  }

  var_1["month"] = "February";
  var_1["days"] = var_0 - 337;
  return var_1;
}

is_divisible_by(var_0, var_1) {
  if(floor(var_0 / var_1) > var_0 / var_1) {
    return 1;
  }

  return 0;
}

build_treasure_cipher_word(var_0, var_1) {
  level endon("game_ended");
  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = var_1.words;
  }

  var_3 = [];
  var_4 = 0;
  for(;;) {
    var_5 = getsubstr(var_2, var_4, var_4 + 1);
    if(!isDefined(var_5) || var_5 == "") {
      var_6 = 1;
      break;
    } else {
      var_4++;
      var_3[var_3.size] = var_5;
    }

    wait(0.05);
  }

  return var_3;
}

play_cipher_fx(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_2 = self;
  foreach(var_4 in var_0) {
    var_5 = spawnfxforclient(level._effect["cipher_alphabet_" + var_4], var_2.origin + anglesToForward(var_2.angles + (0, 90, 0)) * -1, var_1, anglesToForward(var_2.angles), anglestoup(var_2.angles));
    wait(0.1);
    triggerfx(var_5);
    wait(0.1);
    var_5 delete();
  }
}

cp_disco_normalize_value(var_0, var_1, var_2) {
  if(var_0 > var_1) {
    var_3 = var_0;
    var_0 = var_1;
    var_1 = var_3;
  }

  if(var_2 > var_1) {
    return 1;
  } else if(var_2 < var_0) {
    return 0;
  } else if(var_0 == var_1) {}

  return var_2 - var_0 / var_1 - var_0;
}

cp_disco_factor_value(var_0, var_1, var_2) {
  return var_1 * var_2 + var_0 * 1 - var_2;
}

get_disco_dot(var_0, var_1, var_2) {
  var_3 = vectornormalize(var_2 - var_0);
  var_4 = anglesToForward(var_1);
  var_5 = vectordot(var_4, var_3);
  return var_5;
}