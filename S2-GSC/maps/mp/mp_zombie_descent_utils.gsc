/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_descent_utils.gsc
***********************************************/

____________________generic_util____________________() {}

complete_quest_on_trigger(param_00, param_01) {
  level endon(lib_0557::func_7838(param_00, param_01));
  self waittill("trigger");
  lib_0557::func_782D(param_00, param_01);
}

earthquake_alive_players(param_00, param_01, param_02) {
  var_03 = [];
  foreach(var_05 in level.var_744A) {
    if(isalive(var_05)) {
      var_03[var_03.size] = var_05;
    }
  }

  earthquake(param_00, param_01, (0, 0, 0), 9999999, var_03);
}

earthquake_alive_players_with_origin(param_00, param_01, param_02, param_03) {
  var_04 = [];
  foreach(var_06 in level.var_744A) {
    if(isalive(var_06) && distance(var_06.var_116, param_03.var_116) <= param_02) {
      var_04[var_04.size] = var_06;
    }
  }

  if(var_04.size > 0) {
    earthquake(param_00, param_01, param_03.var_116, param_02, var_04);
  }
}

flag_try_set(param_00) {
  if(!common_scripts\utility::func_3C83(param_00)) {
    return;
  }

  if(common_scripts\utility::func_3C77(param_00)) {
    return;
  }

  common_scripts\utility::func_3C8F(param_00);
}

lockin_system_monitor_death() {
  self endon("stop_using_station");
  common_scripts\utility::knock_off_battery("death", "enter_last_stand", "begin_last_stand");
  self notify("stop_using_station");
}

lockin_system_monitor_unuse(param_00, param_01, param_02) {
  self endon("stop_using_station");
  wait 0.05;
  if(isDefined(param_01) && param_01) {
    thread lockin_system_monitor_b_button();
  }

  if(common_scripts\utility::func_562E(param_02)) {
    thread lockin_system_monitor_use_button_exit();
  }

  if(!isDefined(param_00)) {
    return;
  }

  for(;;) {
    param_00 waittill("trigger", var_03);
    if(self == var_03) {
      break;
    }
  }

  self notify("stop_using_station");
}

lockin_system_monitor_b_button() {
  self endon("stop_using_station");
  for(;;) {
    if(self method_84F1()) {
      break;
    }

    wait 0.05;
  }

  self setstance("stand");
  self notify("stop_using_station");
}

lockin_system_monitor_use_button_exit() {
  self endon("stop_using_station");
  while(self useButtonPressed()) {
    wait 0.05;
  }

  for(;;) {
    if(self useButtonPressed()) {
      break;
    }

    wait 0.05;
  }

  self notify("stop_using_station");
}

zombies_players_secret_room_handle_ignore(param_00) {
  if(!isPlayer(param_00)) {
    return 0;
  }

  var_01 = agents_are_separated(param_00, self);
  return var_01;
}

agents_are_separated(param_00, param_01) {
  return param_01 agent_is_in_secret_room(1) != agent_is_in_secret_room();
}

agent_is_in_secret_room(param_00) {
  var_01 = undefined;
  if(common_scripts\utility::func_562E(param_00) && !common_scripts\utility::func_562E(self.wasteleported)) {
    var_01 = lib_0547::func_5565(self.var_9024, level.current_secret_room_zone);
  }

  return common_scripts\utility::func_562E(var_01) || lib_055A::func_AC29(self, level.current_secret_room_zone);
}

set_default_spawn_room(param_00, param_01, param_02) {
  level.temp_spawn_locations = param_01;
  level.temp_spawn_location_players = param_00;
  foreach(var_04 in param_00) {
    var_04 thread set_default_room_for_player(param_02);
  }
}

set_default_room_for_player(param_00) {}

_____________________vo___________________________() {}

initwavestories() {
  maps\mp\zombies\_zombies_audio_dlc2::initwavestories();
  thread vo_radio_convo_boss_start();
  level.descent_wave_stories = [];
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_everybodyokanybodyhurt", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_mari_imokwhatwasthat", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_whateveritwasrippedthroug", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_youdidntseeitthegiantbolt", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_mari_youweretheonlyonewatching", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_yeahwellforsomestrangerea", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_cutthechatterfolkswevegot", 1];
  level.descent_wave_stories["intro"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1, "intro");
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_everybodyokanybodyhurt", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_mari_imokwhatwasthat", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_youdidntseeitthegiantbolt", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_mari_youweretheonlyonewatching", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_yeahwellforsomestrangerea", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_cutthechatterfolkswevegot", 1];
  level.descent_wave_stories["intro_no_oliv"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1, "intro_no_oliv");
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_sowerealljustgoingtoprete", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_isawfireandthenwewerefall", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_wellitmusthavebackfiredto", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_mari_itoldyoutoleavemethereito", 1];
  level.descent_wave_stories["banter_1"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_anybodyelsegetthefeelingt", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_thosemarkingsbackatourlas", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_areyousayingthiswasacity", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_noimsayingitwasanempire", 1];
  level.descent_wave_stories["banter_2"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_thisplaceitdoesntmakeanys", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_thatsnotsostrangeitaughtc", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_noyoudontunderstandtheseb", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_howinthehell", 1];
  level.descent_wave_stories["banter_3"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_soyouretellingmethatthese", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_noimsayingthattheytaughtt", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_gahnowyouregoingtosaythat", 1];
  level.descent_wave_stories["banter_4"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_idontknowyouthinkthesetal", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_notjustonecivilizationsee", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_youlearnedallofthishangin", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_notjustamuseumthelouvreth", 1];
  level.descent_wave_stories["banter_5"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_okaysoourhistorybookswere", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_yourestillnotseeingitprof", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_thisisbakedlimestonefromt", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_dros_bloodyhell", 1];
  level.descent_wave_stories["banter_6"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_igrewuparoundamuseumaswel", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_yesicouldspendanentireday", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_itsoundslikeyoumissit", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_yesimissitdearlybuticanne", 1];
  level.descent_wave_stories["banter_7"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_youcantgobacktothelouvret", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_idonotwishtotalkaboutthis", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_imsorryolivia", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_iappreciateyourconcernbut", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_iunderstandhopeyouknowhow", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_jeff_chucklesyouvesavedmyassmo", 1];
  level.descent_wave_stories["banter_8"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_mari_oliviayoudonthavetotalkif", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_thankyoumariemyfatherwork", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_mari_ohiamsosorryiknowthatdisp", 1];
  level.descent_wave_stories["banter_9"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_ioweyouanapologymarieearl", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_mari_wellideservedthatiputyoua", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_ihavebeenthinkingabouttha", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_anythingallihaveleftismya", 1];
  level.descent_wave_stories["banter_10"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  var_01 = [];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_mari_allofmyangerallofmydesper", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_noyoureffortsbroughtustog", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_mari_iknowthatidontdeservethis", 1];
  var_01[var_01.size] = ["zmb_dlc4_fzn_dwn_oliv_iforgaveyouthemomentyoupu", 1];
  level.descent_wave_stories["banter_11"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_01, 1);
  level thread maps\mp\_utility::func_6F74(::vo_see_feed_listen);
}

vo_intro() {
  while(!level.var_3FA6) {
    wait 0.05;
  }

  lib_0547::func_A78B();
  wait(5);
  var_00 = 0;
  foreach(var_02 in level.var_744A) {
    if(lib_0547::func_5565(lib_0378::func_307B(var_02.var_20D8), "oliv")) {
      var_00 = 1;
      break;
    }
  }

  if(var_00) {
    maps\mp\zombies\_zombies_audio_dlc2::try_run_conversation(level.descent_wave_stories["intro"], 1, 35);
    return;
  }

  maps\mp\zombies\_zombies_audio_dlc2::try_run_conversation(level.descent_wave_stories["intro_no_oliv"], 1, 35);
}

vo_blood_tube_enter(param_00) {
  if(!common_scripts\utility::func_562E(param_00)) {
    if(common_scripts\utility::func_562E(self.var_57DE)) {
      return;
    }

    if(common_scripts\utility::func_562E(level.wavestories.story_playing)) {
      return;
    }

    if(common_scripts\utility::func_562E(self.dlg_playedbloodtubeenterline)) {
      return;
    }
  }

  var_01 = undefined;
  if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "dros")) {
    var_01 = "oohwedidnthaveoneofthesei";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "jeff")) {
    var_01 = "idontlikethisidontlikethi";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "mari")) {
    var_01 = "ivegotabadfeelingaboutthi";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "oliv")) {
    var_01 = "thissmellsofbloodoldblood";
  } else {}

  if(!isDefined(var_01)) {
    return;
  }

  lib_0367::func_8E3D(var_01);
  self.dlg_playedbloodtubeenterline = 1;
}

vo_blood_tube_exit(param_00) {
  if(!common_scripts\utility::func_562E(param_00)) {
    if(common_scripts\utility::func_562E(self.var_57DE)) {
      return;
    }

    if(common_scripts\utility::func_562E(level.wavestories.story_playing)) {
      return;
    }

    if(common_scripts\utility::func_562E(self.dlg_playedbloodtubeexitline)) {
      return;
    }
  }

  var_01 = undefined;
  if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "dros")) {
    var_01 = "sothatswhatitfeelsliketob";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "jeff")) {
    var_01 = "tellmeidonthavetodothatag";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "mari")) {
    var_01 = "deargoddidtheytravelthisw";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "oliv")) {
    var_01 = "nosanemindwouldcreatesuch";
  } else {}

  if(!isDefined(var_01)) {
    return;
  }

  lib_0367::func_8E3D(var_01);
  self.dlg_playedbloodtubeexitline = 1;
}

vo_hear_klaus(param_00) {
  if(!common_scripts\utility::func_562E(param_00)) {
    if(common_scripts\utility::func_562E(self.var_57DE)) {
      return;
    }

    if(common_scripts\utility::func_562E(level.wavestories.story_playing)) {
      return;
    }
  }

  var_01 = undefined;
  if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "dros")) {
    var_01 = "wheredoiknowthatvoicefrom";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "jeff")) {
    var_01 = "ohhellisthatwhoithinkitis";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "oliv")) {
    var_02 = 0;
    foreach(var_04 in level.var_744A) {
      if(lib_0547::func_5565(lib_0378::func_307B(var_04.var_20D8), "mari")) {
        var_02 = 1;
      }
    }

    if(var_02 || common_scripts\utility::func_562E(param_00)) {
      var_01 = "mariemarieyousaidthatyouh";
    } else {
      var_01 = undefined;
    }
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "mari")) {
    var_01 = "cryingiknewitklausklausme";
  } else {}

  if(!isDefined(var_01)) {
    return;
  }

  lib_0367::func_8E3D(var_01);
}

vo_see_corpse_eater(param_00) {
  if(!common_scripts\utility::func_562E(param_00)) {
    if(common_scripts\utility::func_562E(self.var_57DE)) {
      return;
    }

    if(common_scripts\utility::func_562E(level.wavestories.story_playing)) {
      return;
    }

    if(common_scripts\utility::func_562E(self.dlg_playedseecorpseeaterline)) {
      return;
    }
  }

  var_01 = undefined;
  if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "dros")) {
    var_01 = "ohhellaretheyallthisbigju";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "jeff")) {
    var_01 = "lookslikewevefoundtheorig";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "mari")) {
    var_01 = "mytheoryageneticanomalyth";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "oliv")) {
    var_01 = "thisiswherehorrorwasbornt";
  } else {}

  if(!isDefined(var_01)) {
    return;
  }

  lib_0367::func_8E3D(var_01);
  foreach(var_03 in level.var_744A) {
    var_03.dlg_playedseecorpseeaterline = 1;
  }
}

vo_see_feed_listen() {
  self endon("disconnect");
  for(;;) {
    level waittill("corpse_eater_start_feed", var_00);
    if(isDefined(var_00) && distancesquared(var_00.var_116, self.var_116) < -25536 && !common_scripts\utility::func_562E(self.dlg_playedseecorpseeaterfeedline)) {
      vo_see_corpse_eater_feed();
      if(common_scripts\utility::func_562E(self.dlg_playedseecorpseeaterfeedline)) {
        break;
      }
    }
  }
}

vo_see_corpse_eater_feed(param_00) {
  if(!common_scripts\utility::func_562E(param_00)) {
    if(common_scripts\utility::func_562E(self.var_57DE)) {
      return;
    }

    if(common_scripts\utility::func_562E(level.wavestories.story_playing)) {
      return;
    }

    if(common_scripts\utility::func_562E(self.dlg_playedseecorpseeaterfeedline)) {
      return;
    }

    if(!common_scripts\utility::func_562E(self.dlg_playedseecorpseeaterline)) {
      return;
    }
  }

  var_01 = undefined;
  if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "dros")) {
    var_01 = "gahonlythingworsethanthew";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "jeff")) {
    var_01 = "whyaretheyattackingthenaz";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "mari")) {
    var_01 = "theyarentfeedingonthefles";
  } else if(lib_0547::func_5565(lib_0378::func_307B(self.var_20D8), "oliv")) {
    var_01 = "thisiswherethelegendsofth";
  } else {}

  if(!isDefined(var_01)) {
    return;
  }

  lib_0367::func_8E3D(var_01);
  self.dlg_playedseecorpseeaterfeedline = 1;
}

vo_can_play_radio_convo() {
  var_00 = 0;
  if(common_scripts\utility::func_562E(level.wavestories.story_playing)) {
    return 0;
  }

  if(common_scripts\utility::func_562E(level.radio_convo_playing)) {
    return 0;
  }

  return 1;
}

vo_queue_play_radio_convo() {
  var_00 = 0;
  while(common_scripts\utility::func_562E(level.wavestories.story_playing) || common_scripts\utility::func_562E(level.radio_convo_playing)) {
    wait 0.05;
  }

  wait(0.65);
  return 1;
}

vo_radio_convo_map_start(param_00) {
  if(!common_scripts\utility::func_562E(param_00)) {
    vo_queue_play_radio_convo();
  }

  level.radio_convo_playing = 1;
  level.wavestories.story_playing = 1;
  vo_play_radio_convo_on_all_players(["zmb_dlc4_fzn_dwn_ride_coloneljeffersondoyouread", "zmb_dlc4_fzn_dwn_vivi_generalthisisagentharrisw", "zmb_dlc4_fzn_dwn_ride_ohthankgodagentharrisinee", "zmb_dlc4_fzn_dwn_vivi_negativesirjustspokewiths", "zmb_dlc4_fzn_dwn_ride_goddamnitharrisweneedthat", "zmb_dlc4_fzn_dwn_vivi_imsorrysirjeffersonandhis", "zmb_dlc4_fzn_dwn_ride_harrisyouhavenoideawhatyo"], "vo_radio_convo_1_line_done");
  level waittill("vo_radio_convo_1_line_done");
  level.radio_convo_playing = 0;
  level.wavestories.story_playing = 0;
  level.has_played_radio_convo_1 = 1;
}

vo_radio_convo_boss_start(param_00) {
  level endon("flag_entered_boss_arena");
  if(!common_scripts\utility::func_562E(param_00)) {
    level waittill("vo_vivian_entranced");
    if(common_scripts\utility::func_562E(level.wavestories.story_playing)) {
      level.wavestories.story_playing = 0;
      level notify("story_interrupt");
    }

    while(common_scripts\utility::func_562E(level.radio_convo_playing)) {
      wait 0.05;
    }
  }

  level.radio_convo_playing = 1;
  level.wavestories.story_playing = 1;
  vo_play_radio_convo_on_all_players(["zmb_dlc4_fzn_dwn_ride_colonelifyoucanreadmekeep", "zmb_dlc4_fzn_dwn_vivi_hewantedtoleaveyouhewante", "zmb_dlc4_fzn_dwn_vivi_hemusthavethesworditishis"], "vo_radio_convo_2_line_done");
  level waittill("vo_radio_convo_2_line_done");
  level.radio_convo_playing = 0;
  level.wavestories.story_playing = 0;
  level.has_played_radio_convo_2 = 1;
}

vo_radio_convo_boss_end(param_00) {
  if(!common_scripts\utility::func_562E(param_00)) {
    vo_queue_play_radio_convo();
    wait(10);
  }

  level.radio_convo_playing = 1;
  level.wavestories.story_playing = 1;
  lib_0378::func_8D74("aud_outro_vo_submix_start");
  vo_play_radio_convo_on_all_players(["zmb_dlc4_fzn_dwn_ride_colonelweverecoveredcapta", "zmb_dlc4_fzn_dwn_ride_thisisasecurechannelcolje", "zmb_dlc4_fzn_dwn_ride_iamheretoguideyouasihavef"], "vo_radio_convo_3_line_done");
  level waittill("vo_radio_convo_3_line_done");
  lib_0378::func_8D74("aud_outro_vo_submix_end");
  level.radio_convo_playing = 0;
  level.wavestories.story_playing = 0;
}

vo_play_radio_convo_on_all_players(param_00, param_01) {
  foreach(var_03 in level.var_744A) {
    var_03 thread vo_play_radio_convo_on_player(param_00, param_01);
  }
}

vo_play_radio_convo_on_player(param_00, param_01) {
  foreach(var_03 in param_00) {
    wait(1);
    vo_play_radio_line_on_player(var_03);
  }

  level notify(param_01, self);
}

vo_play_radio_line_on_player(param_00) {
  var_01 = self;
  if(!isDefined(level.radio_speaker)) {
    level.radio_speaker = spawn("script_origin", (0, 0, -10000));
  }

  if(var_01 issplitscreenplayer()) {
    if(var_01 method_82ED()) {
      var_01.var_71D.pa_vo_on_player = lib_0380::func_288B(param_00, var_01, level.radio_speaker, 0, 1);
    } else {}
  } else {
    var_01.var_71D.pa_vo_on_player = lib_0380::func_288B(param_00, var_01, level.radio_speaker, 0, 1);
  }

  var_02 = lookupsoundlength(param_00);
  if(isDefined(var_01.var_71D.pa_vo_on_player)) {
    wait(var_02);
    var_01.var_71D.pa_vo_on_player = undefined;
  }
}

vo_play_klaus_line_on_player(param_00) {
  var_01 = self;
  var_01.ishearingwhisper = 1;
  var_01.var_71D.pa_vo_on_player = lib_0380::func_288B(param_00, var_01, var_01, 0, 1);
  var_02 = lookupsoundlength(param_00);
  if(isDefined(var_01.var_71D.pa_vo_on_player)) {
    wait(var_02);
    var_01.var_71D.pa_vo_on_player = undefined;
  }

  var_01.ishearingwhisper = 0;
}

vo_init_weapon_whispers() {
  level.ravenweaponmanager["spike"].on_gained_func = ::spike_post_give;
  level.ravenweaponmanager["scythe"].on_gained_func = ::scythe_post_give;
  level.ravenweaponmanager["hammer"].on_gained_func = ::hammer_post_give;
  level.ravenweaponmanager["shield"].on_gained_func = ::shield_post_give;
}

vo_can_hear_whisper(param_00) {
  if(common_scripts\utility::func_562E(self.var_57DE)) {
    return 0;
  }

  if(common_scripts\utility::func_562E(level.wavestories.story_playing)) {
    return 0;
  }

  if(common_scripts\utility::func_562E(self.ishearingwhisper)) {
    return 0;
  }

  var_01 = self getcurrentprimaryweapon();
  if(!issubstr(var_01, level.ravenweaponmanager[param_00].var_1D0)) {
    return 0;
  }

  return 1;
}

vo_waittill_next_whisper_time() {
  wait(randomintrange(120, 160));
}

vo_play_klaus_weapon_intro(param_00, param_01) {
  self endon("disconnect");
  self endon(level.ravenweaponmanager[param_01].wep_loss_notify);
  vo_play_klaus_line_on_player(param_00);
  if(!common_scripts\utility::func_562E(self.dlg_reacted_to_hearing_klaus)) {
    wait(0.5);
    self.dlg_reacted_to_hearing_klaus = 1;
    vo_hear_klaus();
  }
}

vo_whisper_think(param_00, param_01) {
  self endon(level.ravenweaponmanager[param_00].wep_loss_notify);
  self endon("disconnect");
  var_02 = param_01;
  for(;;) {
    vo_waittill_next_whisper_time();
    if(!vo_can_hear_whisper(param_00)) {
      continue;
    }

    if(var_02.size > 0) {
      var_03 = common_scripts\utility::func_7A33(var_02);
      var_02 = common_scripts\utility::func_F93(var_02, var_03);
      vo_play_klaus_line_on_player(var_03);
      if(var_02.size <= 0) {
        break;
      }
    }
  }
}

spike_post_give() {
  self endon(level.ravenweaponmanager["spike"].wep_loss_notify);
  self endon("disconnect");
  var_00 = ["zmb_dlc4_fzn_dwn_klau_looktothestarstheydrawbot", "zmb_dlc4_fzn_dwn_klau_seektheskyforsalvationdes", "zmb_dlc4_fzn_dwn_klau_thecloudsareveilstoourete", "zmb_dlc4_fzn_dwn_klau_asonearthasitisintheheave", "zmb_dlc4_fzn_dwn_klau_findthelordsintheskytheyk", "zmb_dlc4_fzn_dwn_klau_bethereachthatspansthehea", "zmb_dlc4_fzn_dwn_klau_endthereignofundeathwield"];
  thread vo_whisper_think("spike", var_00);
  if(!common_scripts\utility::func_562E(self.dlg_heard_spike_intro)) {
    self.dlg_heard_spike_intro = 1;
    thread vo_play_klaus_weapon_intro("zmb_dlc4_fzn_dwn_klau_ispeakforlurothfirstofthe", "spike");
  }
}

scythe_post_give() {
  self endon(level.ravenweaponmanager["scythe"].wep_loss_notify);
  self endon("disconnect");
  var_00 = ["zmb_dlc4_fzn_dwn_klau_maketheofferingdeathawait", "zmb_dlc4_fzn_dwn_klau_killthechosendeathabides", "zmb_dlc4_fzn_dwn_klau_releasesurrenderanddiedea", "zmb_dlc4_fzn_dwn_klau_killthemkillthemall", "zmb_dlc4_fzn_dwn_klau_walklikedeathcloakedinfin", "zmb_dlc4_fzn_dwn_klau_yourpalehorseawaitsbringp"];
  thread vo_whisper_think("scythe", var_00);
  if(!common_scripts\utility::func_562E(self.dlg_heard_scythe_intro)) {
    self.dlg_heard_scythe_intro = 1;
    thread vo_play_klaus_weapon_intro("zmb_dlc4_fzn_dwn_klau_ispeakforanhiestfirstofth", "scythe");
  }
}

shield_post_give() {
  self endon(level.ravenweaponmanager["shield"].wep_loss_notify);
  self endon("disconnect");
  var_00 = ["zmb_dlc4_fzn_dwn_klau_bloodholdsoursecretsbotha", "zmb_dlc4_fzn_dwn_klau_spiltbloodisadivinegiftso", "zmb_dlc4_fzn_dwn_klau_bloodittiesalllivingthing", "zmb_dlc4_fzn_dwn_klau_seethroughtheeyesofthedea", "zmb_dlc4_fzn_dwn_klau_bornfrombloodendwithblood", "zmb_dlc4_fzn_dwn_klau_bloodislifebloodsignalsde", "zmb_dlc4_fzn_dwn_klau_peacetravelleryoufollowth", "zmb_dlc4_fzn_dwn_klau_bleedfortheinnocent", "zmb_dlc4_fzn_dwn_klau_bybloodbyragebytheragingt"];
  thread vo_whisper_think("shield", var_00);
  if(!common_scripts\utility::func_562E(self.dlg_heard_shield_intro)) {
    self.dlg_heard_shield_intro = 1;
    thread vo_play_klaus_weapon_intro("zmb_dlc4_fzn_dwn_klau_ispeakforsangketfirstofth", "shield");
  }
}

hammer_post_give() {
  self endon(level.ravenweaponmanager["hammer"].wep_loss_notify);
  self endon("disconnect");
  var_00 = ["zmb_dlc4_fzn_dwn_klau_chaosbringsfreedomfreedom", "zmb_dlc4_fzn_dwn_klau_listenforthethunderinsile", "zmb_dlc4_fzn_dwn_klau_harkenthelightandthenthes", "zmb_dlc4_fzn_dwn_klau_patternsdissolveintochaos", "zmb_dlc4_fzn_dwn_klau_theeternalwarbetweenchaos", "zmb_dlc4_fzn_dwn_klau_moveintothelightningthest", "zmb_dlc4_fzn_dwn_klau_weareentropyendthesicklyo"];
  thread vo_whisper_think("hammer", var_00);
  if(!common_scripts\utility::func_562E(self.dlg_heard_hammer_intro)) {
    self.dlg_heard_hammer_intro = 1;
    thread vo_play_klaus_weapon_intro("zmb_dlc4_fzn_dwn_klau_ispeakfortalrekfirstofthe", "hammer");
  }
}

func_902A(param_00) {
  if(isDefined(param_00.var_82EC)) {
    switch (param_00.var_82EC) {
      case "spawn_dirt":
        return::dirtspawnnotetrackhandler;

      case "spawn_concrete":
        return::concretespawnnotetrackhandler;

      case "spawn_mud":
        return::mudspawnnotetrackhandler;

      case "spawn_sand":
        return::sandspawnnotetrackhandler;

      case "spawn_water":
        return::waterspawnnotetrackhandler;

      case "spawn_blood":
        return::bloodspawnnotetrackhandler;

      case "spawn_snow":
        return::snowspawnnotetrackhandler;

      case "spawn_fire":
        thread try_catch_on_fire();
        return undefined;
    }
  }
}

dirtspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_dirt");
  }
}

mudspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_mud");
  }
}

concretespawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_concrete");
  }
}

sandspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_sand");
  }
}

waterspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_water");
    thread zombiedripfx("zmb_spawn_water");
  }
}

bloodspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_blood");
    thread zombiedripfx("zmb_spawn_blood");
  }
}

snowspawnnotetrackhandler(param_00, param_01, param_02, param_03) {
  if(param_00 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_snow");
  }
}

zombiedripfx(param_00) {
  if(level.var_A980 >= 20) {
    return;
  }

  var_01 = "spawn_water_drip";
  if(isDefined(param_00)) {
    var_01 = param_00 + "_drip";
  }

  var_02 = ["J_Spine4"];
  foreach(var_05 in var_02) {
    if(isDefined(self gettagorigin(var_05))) {
      lib_0547::func_74A5(common_scripts\utility::func_44F5(var_01), self, var_05);
    }
  }

  zombiedripfxcleanup(var_02, var_01);
}

zombiedripfxcleanup(param_00, param_01) {
  self endon("death");
  while(isDefined(self) && isalive(self)) {
    wait(0.1);
    if(!isDefined(self.var_53D9) || !self.var_53D9) {
      break;
    }
  }

  wait(randomfloatrange(5, 15));
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  foreach(var_03 in param_00) {
    if(isDefined(self gettagorigin(var_03))) {
      lib_0547::func_9406(common_scripts\utility::func_44F5(param_01), self, var_03);
    }
  }
}

zombiespawnfx(param_00) {
  if(level.zombiespawnfxcount >= 12) {
    return;
  }

  var_01 = spawnfx(common_scripts\utility::func_44F5(param_00), self.var_116, anglesToForward(self.var_1D), anglestoup(self.var_1D));
  triggerfx(var_01);
  level.zombiespawnfxcount++;
  common_scripts\utility::func_A74B("death", 2);
  level.zombiespawnfxcount--;
  var_01 delete();
}

try_catch_on_fire() {
  self endon("death");
  var_00 = 0;
  foreach(var_02 in lib_0547::func_408F()) {
    if(common_scripts\utility::func_562E(var_02.isonfire)) {
      var_00++;
    }
  }

  if(var_00 < 4) {
    self.isonfire = 1;
    lib_0547::func_A6F6();
    self setonfire(0, 100, 1, "none", 1);
  }
}

start_screenshake(param_00) {
  var_01 = self;
  while(param_00 > 0) {
    var_02 = 0.55 + randomfloat(0.55);
    param_00 = param_00 - var_02;
    var_01 playrumbleonentity("damage_heavy");
    earthquake(0.4, var_02, self.var_116, 96);
    wait(var_02);
  }
}

reveal_first_room_door() {
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "flag_limbo_to_cave_intro" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

spine_pickup_anim(param_00) {
  var_01 = self;
  while(var_01 method_833B()) {
    wait 0.05;
  }

  var_02 = var_01 getcurrentweapon();
  var_01 common_scripts\utility::func_603();
  var_01 common_scripts\utility::func_600();
  var_01 lib_0586::func_78C(param_00);
  var_01 lib_0586::func_78E(param_00, 1);
  var_01 allowjump(0);
  var_01 method_8308(0);
  wait(0.1);
  var_01 setstance("stand");
  var_01 method_8113(0);
  var_01 method_8114(0);
  var_01 thread lib_0378::func_8D74("ripsaw_spine_cut");
  var_01 wait_for_weapon_change(param_00);
  wait(3);
  if(!lib_0547::func_73F9(self, var_02)) {
    var_02 = var_01 lib_0547::func_AB2B();
  }

  var_01 lib_0586::func_78E(var_02);
  var_01 common_scripts\utility::func_617();
  var_01 common_scripts\utility::func_614();
  if(var_01 hasweapon(param_00)) {
    var_01 lib_0586::func_790(param_00);
  }

  var_01 allowmovement(1);
  var_01 allowlook(1);
  var_01 method_8308(1);
  var_01 method_8113(1);
  var_01 method_8114(1);
  var_01 allowjump(1);
}

wait_for_weapon_change(param_00) {
  self endon("weapon_change");
  for(;;) {
    var_01 = self getcurrentweapon();
    if(var_01 == param_00) {
      break;
    }

    wait 0.05;
  }
}

set_fx(param_00, param_01) {
  if(isDefined(self.var_3F2F)) {
    self.var_3F2F delete();
  }

  if(!isDefined(param_01)) {
    param_01 = "tag_fx";
  }

  self.var_3F74 = param_00;
  self.var_3F2F = spawnlinkedfx(common_scripts\utility::func_44F5(param_00), self, param_01);
  triggerfx(self.var_3F2F);
  if(function_01EF(self)) {
    maps\mp\agents\_agent_utility::deleteentonagentdeath(self.var_3F2F);
    return;
  }

  self.var_3F2F thread lib_0547::func_2D19(self);
}

wait_for_player_close(param_00) {
  for(;;) {
    foreach(var_02 in level.var_744A) {
      if(distance(var_02.var_116, self.var_116) < param_00) {
        return var_02;
      }
    }

    wait 0.05;
  }
}