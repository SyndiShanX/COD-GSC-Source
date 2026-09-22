/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_descent_utils.gsc
*******************************************************/

____________________generic_util____________________() {}

complete_quest_on_trigger(var_0, var_1) {
  level endon(_id_0557::_id_7838(var_0, var_1));
  self waittill("trigger");
  _id_0557::_id_782D(var_0, var_1);
}

earthquake_alive_players(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    if(isalive(var_5)) {
      var_3[var_3.size] = var_5;
    }
  }

  _earthquake(var_0, var_1, (0, 0, 0), 9999999, var_3);
}

earthquake_alive_players_with_origin(var_0, var_1, var_2, var_3) {
  var_4 = [];

  foreach(var_6 in level.players) {
    if(isalive(var_6) && distance(var_6.origin, var_3.origin) <= var_2) {
      var_4[var_4.size] = var_6;
    }
  }

  if(var_4.size > 0) {
    _earthquake(var_0, var_1, var_3.origin, var_2, var_4);
  }
}

flag_try_set(var_0) {
  if(!common_scripts\utility::_id_3C83(var_0)) {
    return;
  }
  if(common_scripts\utility::_id_3C77(var_0)) {
    return;
  }
  common_scripts\utility::flag_set(var_0);
}

lockin_system_monitor_death() {
  self endon("stop_using_station");
  common_scripts\utility::_id_A70A("death", "enter_last_stand", "begin_last_stand");
  self notify("stop_using_station");
}

lockin_system_monitor_unuse(var_0, var_1, var_2) {
  self endon("stop_using_station");
  waitframe();

  if(isDefined(var_1) && var_1) {
    thread lockin_system_monitor_b_button();
  }

  if(common_scripts\utility::_id_562E(var_2)) {
    thread lockin_system_monitor_use_button_exit();
  }

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    var_0 waittill("trigger", var_3);

    if(self == var_3) {
      break;
    }
  }

  self notify("stop_using_station");
}

lockin_system_monitor_b_button() {
  self endon("stop_using_station");

  for(;;) {
    if(self _meth_84F1()) {
      break;
    }

    waitframe();
  }

  self setstance("stand");
  self notify("stop_using_station");
}

lockin_system_monitor_use_button_exit() {
  self endon("stop_using_station");

  while(self useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(self useButtonPressed()) {
      break;
    }

    waitframe();
  }

  self notify("stop_using_station");
}

zombies_players_secret_room_handle_ignore(var_0) {
  if(!isPlayer(var_0)) {
    return 0;
  }

  var_1 = agents_are_separated(var_0, self);
  return var_1;
}

agents_are_separated(var_0, var_1) {
  return var_1 agent_is_in_secret_room(1) != agent_is_in_secret_room();
}

agent_is_in_secret_room(var_0) {
  var_1 = undefined;

  if(common_scripts\utility::_id_562E(var_0) && !common_scripts\utility::_id_562E(self.wasteleported)) {
    var_1 = _id_0547::_id_5565(self._id_9024, level.current_secret_room_zone);
  }

  return common_scripts\utility::_id_562E(var_1) || _id_055A::_id_AC29(self, level.current_secret_room_zone);
}

set_default_spawn_room(var_0, var_1, var_2) {
  level.temp_spawn_locations = var_1;
  level.temp_spawn_location_players = var_0;

  foreach(var_4 in var_0) {
    var_4 thread set_default_room_for_player(var_2);
  }
}

set_default_room_for_player(var_0) {}

_____________________vo___________________________() {}

initwavestories() {
  maps\mp\zombies\_zombies_audio_dlc2::initwavestories();
  thread vo_radio_convo_boss_start();
  level.descent_wave_stories = [];
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_everybodyokanybodyhurt", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_mari_imokwhatwasthat", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_whateveritwasrippedthroug", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_youdidntseeitthegiantbolt", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_mari_youweretheonlyonewatching", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_yeahwellforsomestrangerea", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_cutthechatterfolkswevegot", 1.0];
  level.descent_wave_stories["intro"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1, "intro");
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_everybodyokanybodyhurt", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_mari_imokwhatwasthat", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_youdidntseeitthegiantbolt", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_mari_youweretheonlyonewatching", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_yeahwellforsomestrangerea", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_cutthechatterfolkswevegot", 1.0];
  level.descent_wave_stories["intro_no_oliv"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1, "intro_no_oliv");
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_sowerealljustgoingtoprete", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_isawfireandthenwewerefall", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_wellitmusthavebackfiredto", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_mari_itoldyoutoleavemethereito", 1.0];
  level.descent_wave_stories["banter_1"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_anybodyelsegetthefeelingt", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_thosemarkingsbackatourlas", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_areyousayingthiswasacity", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_noimsayingitwasanempire", 1.0];
  level.descent_wave_stories["banter_2"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_thisplaceitdoesntmakeanys", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_thatsnotsostrangeitaughtc", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_noyoudontunderstandtheseb", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_howinthehell", 1.0];
  level.descent_wave_stories["banter_3"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_soyouretellingmethatthese", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_noimsayingthattheytaughtt", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_gahnowyouregoingtosaythat", 1.0];
  level.descent_wave_stories["banter_4"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_idontknowyouthinkthesetal", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_notjustonecivilizationsee", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_youlearnedallofthishangin", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_notjustamuseumthelouvreth", 1.0];
  level.descent_wave_stories["banter_5"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_okaysoourhistorybookswere", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_yourestillnotseeingitprof", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_thisisbakedlimestonefromt", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_dros_bloodyhell", 1.0];
  level.descent_wave_stories["banter_6"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_igrewuparoundamuseumaswel", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_yesicouldspendanentireday", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_itsoundslikeyoumissit", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_yesimissitdearlybuticanne", 1.0];
  level.descent_wave_stories["banter_7"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_youcantgobacktothelouvret", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_idonotwishtotalkaboutthis", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_imsorryolivia", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_iappreciateyourconcernbut", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_iunderstandhopeyouknowhow", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_jeff_chucklesyouvesavedmyassmo", 1.0];
  level.descent_wave_stories["banter_8"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_mari_oliviayoudonthavetotalkif", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_thankyoumariemyfatherwork", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_mari_ohiamsosorryiknowthatdisp", 1.0];
  level.descent_wave_stories["banter_9"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_ioweyouanapologymarieearl", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_mari_wellideservedthatiputyoua", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_ihavebeenthinkingabouttha", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_anythingallihaveleftismya", 1.0];
  level.descent_wave_stories["banter_10"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  var_1 = [];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_mari_allofmyangerallofmydesper", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_noyoureffortsbroughtustog", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_mari_iknowthatidontdeservethis", 1.0];
  var_1[var_1.size] = ["zmb_dlc4_fzn_dwn_oliv_iforgaveyouthemomentyoupu", 1.0];
  level.descent_wave_stories["banter_11"] = maps\mp\zombies\_zombies_audio_dlc2::addwavestory(var_1, 1);
  level thread maps\mp\_utility::_id_6F74(::vo_see_feed_listen);
}

vo_intro() {
  while(!level.gamehasstarted) {
    waitframe();
  }

  _id_0547::_id_A78B();
  wait 5;
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(_id_0547::_id_5565(_id_0378::_id_307B(var_2._id_20D8), "oliv")) {
      var_0 = 1;
      break;
    }
  }

  if(var_0) {
    maps\mp\zombies\_zombies_audio_dlc2::try_run_conversation(level.descent_wave_stories["intro"], 1, 35);
  } else {
    maps\mp\zombies\_zombies_audio_dlc2::try_run_conversation(level.descent_wave_stories["intro_no_oliv"], 1, 35);
  }
}

vo_blood_tube_enter(var_0) {
  if(!common_scripts\utility::_id_562E(var_0)) {
    if(common_scripts\utility::_id_562E(self._id_57DE)) {
      return;
    }
    if(common_scripts\utility::_id_562E(level.wavestories.story_playing)) {
      return;
    }
    if(common_scripts\utility::_id_562E(self.dlg_playedbloodtubeenterline)) {
      return;
    }
  }

  var_1 = undefined;

  if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "dros")) {
    var_1 = "oohwedidnthaveoneofthesei";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "jeff")) {
    var_1 = "idontlikethisidontlikethi";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "mari")) {
    var_1 = "ivegotabadfeelingaboutthi";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "oliv")) {
    var_1 = "thissmellsofbloodoldblood";
  } else {}

  if(!isDefined(var_1)) {
    return;
  }
  _id_0367::_id_8E3D(var_1);
  self.dlg_playedbloodtubeenterline = 1;
}

vo_blood_tube_exit(var_0) {
  if(!common_scripts\utility::_id_562E(var_0)) {
    if(common_scripts\utility::_id_562E(self._id_57DE)) {
      return;
    }
    if(common_scripts\utility::_id_562E(level.wavestories.story_playing)) {
      return;
    }
    if(common_scripts\utility::_id_562E(self.dlg_playedbloodtubeexitline)) {
      return;
    }
  }

  var_1 = undefined;

  if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "dros")) {
    var_1 = "sothatswhatitfeelsliketob";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "jeff")) {
    var_1 = "tellmeidonthavetodothatag";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "mari")) {
    var_1 = "deargoddidtheytravelthisw";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "oliv")) {
    var_1 = "nosanemindwouldcreatesuch";
  } else {}

  if(!isDefined(var_1)) {
    return;
  }
  _id_0367::_id_8E3D(var_1);
  self.dlg_playedbloodtubeexitline = 1;
}

vo_hear_klaus(var_0) {
  if(!common_scripts\utility::_id_562E(var_0)) {
    if(common_scripts\utility::_id_562E(self._id_57DE)) {
      return;
    }
    if(common_scripts\utility::_id_562E(level.wavestories.story_playing)) {
      return;
    }
  }

  var_1 = undefined;

  if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "dros")) {
    var_1 = "wheredoiknowthatvoicefrom";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "jeff")) {
    var_1 = "ohhellisthatwhoithinkitis";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "oliv")) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(_id_0547::_id_5565(_id_0378::_id_307B(var_4._id_20D8), "mari")) {
        var_2 = 1;
      }
    }

    if(var_2 || common_scripts\utility::_id_562E(var_0)) {
      var_1 = "mariemarieyousaidthatyouh";
    } else {
      var_1 = undefined;
    }
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "mari"))
    var_1 = "cryingiknewitklausklausme";
  else {}

  if(!isDefined(var_1)) {
    return;
  }
  _id_0367::_id_8E3D(var_1);
}

vo_see_corpse_eater(var_0) {
  if(!common_scripts\utility::_id_562E(var_0)) {
    if(common_scripts\utility::_id_562E(self._id_57DE)) {
      return;
    }
    if(common_scripts\utility::_id_562E(level.wavestories.story_playing)) {
      return;
    }
    if(common_scripts\utility::_id_562E(self.dlg_playedseecorpseeaterline)) {
      return;
    }
  }

  var_1 = undefined;

  if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "dros")) {
    var_1 = "ohhellaretheyallthisbigju";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "jeff")) {
    var_1 = "lookslikewevefoundtheorig";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "mari")) {
    var_1 = "mytheoryageneticanomalyth";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "oliv")) {
    var_1 = "thisiswherehorrorwasbornt";
  } else {}

  if(!isDefined(var_1)) {
    return;
  }
  _id_0367::_id_8E3D(var_1);

  foreach(var_3 in level.players) {
    var_3.dlg_playedseecorpseeaterline = 1;
  }
}

vo_see_feed_listen() {
  self endon("disconnect");

  for(;;) {
    level waittill("corpse_eater_start_feed", var_0);

    if(isDefined(var_0) && distancesquared(var_0.origin, self.origin) < 40000 && !common_scripts\utility::_id_562E(self.dlg_playedseecorpseeaterfeedline)) {
      vo_see_corpse_eater_feed();

      if(common_scripts\utility::_id_562E(self.dlg_playedseecorpseeaterfeedline)) {
        break;
      }
    }
  }
}

vo_see_corpse_eater_feed(var_0) {
  if(!common_scripts\utility::_id_562E(var_0)) {
    if(common_scripts\utility::_id_562E(self._id_57DE)) {
      return;
    }
    if(common_scripts\utility::_id_562E(level.wavestories.story_playing)) {
      return;
    }
    if(common_scripts\utility::_id_562E(self.dlg_playedseecorpseeaterfeedline)) {
      return;
    }
    if(!common_scripts\utility::_id_562E(self.dlg_playedseecorpseeaterline)) {
      return;
    }
  }

  var_1 = undefined;

  if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "dros")) {
    var_1 = "gahonlythingworsethanthew";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "jeff")) {
    var_1 = "whyaretheyattackingthenaz";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "mari")) {
    var_1 = "theyarentfeedingonthefles";
  } else if(_id_0547::_id_5565(_id_0378::_id_307B(self._id_20D8), "oliv")) {
    var_1 = "thisiswherethelegendsofth";
  } else {}

  if(!isDefined(var_1)) {
    return;
  }
  _id_0367::_id_8E3D(var_1);
  self.dlg_playedseecorpseeaterfeedline = 1;
}

vo_can_play_radio_convo() {
  var_0 = 0;

  if(common_scripts\utility::_id_562E(level.wavestories.story_playing)) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(level.radio_convo_playing)) {
    return 0;
  }

  return 1;
}

vo_queue_play_radio_convo() {
  var_0 = 0;

  while(common_scripts\utility::_id_562E(level.wavestories.story_playing) || common_scripts\utility::_id_562E(level.radio_convo_playing)) {
    waitframe();
  }

  wait 0.65;
  return 1;
}

vo_radio_convo_map_start(var_0) {
  if(!common_scripts\utility::_id_562E(var_0)) {
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

vo_radio_convo_boss_start(var_0) {
  level endon("flag_entered_boss_arena");

  if(!common_scripts\utility::_id_562E(var_0)) {
    level waittill("vo_vivian_entranced");

    if(common_scripts\utility::_id_562E(level.wavestories.story_playing)) {
      level.wavestories.story_playing = 0;
      level notify("story_interrupt");
    }

    while(common_scripts\utility::_id_562E(level.radio_convo_playing)) {
      waitframe();
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

vo_radio_convo_boss_end(var_0) {
  if(!common_scripts\utility::_id_562E(var_0)) {
    vo_queue_play_radio_convo();
    wait 10;
  }

  level.radio_convo_playing = 1;
  level.wavestories.story_playing = 1;
  _id_0378::_id_8D74("aud_outro_vo_submix_start");
  vo_play_radio_convo_on_all_players(["zmb_dlc4_fzn_dwn_ride_colonelweverecoveredcapta", "zmb_dlc4_fzn_dwn_ride_thisisasecurechannelcolje", "zmb_dlc4_fzn_dwn_ride_iamheretoguideyouasihavef"], "vo_radio_convo_3_line_done");
  level waittill("vo_radio_convo_3_line_done");
  _id_0378::_id_8D74("aud_outro_vo_submix_end");
  level.radio_convo_playing = 0;
  level.wavestories.story_playing = 0;
}

vo_play_radio_convo_on_all_players(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 thread vo_play_radio_convo_on_player(var_0, var_1);
  }
}

vo_play_radio_convo_on_player(var_0, var_1) {
  foreach(var_3 in var_0) {
    wait 1;
    vo_play_radio_line_on_player(var_3);
  }

  level notify(var_1, self);
}

vo_play_radio_line_on_player(var_0) {
  var_1 = self;

  if(!isDefined(level.radio_speaker)) {
    level.radio_speaker = spawn("script_origin", (0, 0, -10000));
  }

  if(var_1 issplitscreenplayer()) {
    if(var_1 issplitscreenplayerprimary()) {
      var_1._id_071D.pa_vo_on_player = _id_0380::_id_288B(var_0, var_1, level.radio_speaker, 0, 1);
    } else {}
  } else
    var_1._id_071D.pa_vo_on_player = _id_0380::_id_288B(var_0, var_1, level.radio_speaker, 0, 1);

  var_2 = _lookupsoundlength(var_0);

  if(isDefined(var_1._id_071D.pa_vo_on_player)) {
    wait(var_2);
    var_1._id_071D.pa_vo_on_player = undefined;
  }
}

vo_play_klaus_line_on_player(var_0) {
  var_1 = self;
  var_1.ishearingwhisper = 1;
  var_1._id_071D.pa_vo_on_player = _id_0380::_id_288B(var_0, var_1, var_1, 0, 1);
  var_2 = _lookupsoundlength(var_0);

  if(isDefined(var_1._id_071D.pa_vo_on_player)) {
    wait(var_2);
    var_1._id_071D.pa_vo_on_player = undefined;
  }

  var_1.ishearingwhisper = 0;
}

vo_init_weapon_whispers() {
  level.ravenweaponmanager["spike"].on_gained_func = ::spike_post_give;
  level.ravenweaponmanager["scythe"].on_gained_func = ::scythe_post_give;
  level.ravenweaponmanager["hammer"].on_gained_func = ::hammer_post_give;
  level.ravenweaponmanager["shield"].on_gained_func = ::shield_post_give;
}

vo_can_hear_whisper(var_0) {
  if(common_scripts\utility::_id_562E(self._id_57DE)) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(level.wavestories.story_playing)) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(self.ishearingwhisper)) {
    return 0;
  }

  var_1 = self getcurrentprimaryweapon();

  if(!issubstr(var_1, level.ravenweaponmanager[var_0]._id_01D0)) {
    return 0;
  }

  return 1;
}

vo_waittill_next_whisper_time() {
  wait(_randomintrange(120, 160));
}

vo_play_klaus_weapon_intro(var_0, var_1) {
  self endon("disconnect");
  self endon(level.ravenweaponmanager[var_1].wep_loss_notify);
  vo_play_klaus_line_on_player(var_0);

  if(!common_scripts\utility::_id_562E(self.dlg_reacted_to_hearing_klaus)) {
    wait 0.5;
    self.dlg_reacted_to_hearing_klaus = 1;
    vo_hear_klaus();
  }
}

vo_whisper_think(var_0, var_1) {
  self endon(level.ravenweaponmanager[var_0].wep_loss_notify);
  self endon("disconnect");
  var_2 = var_1;

  for(;;) {
    vo_waittill_next_whisper_time();

    if(!vo_can_hear_whisper(var_0)) {
      continue;
    }
    if(var_2.size > 0) {
      var_3 = common_scripts\utility::random(var_2);
      var_2 = common_scripts\utility::_id_0F93(var_2, var_3);
      vo_play_klaus_line_on_player(var_3);

      if(var_2.size <= 0) {
        break;
      }
    }
  }
}

spike_post_give() {
  self endon(level.ravenweaponmanager["spike"].wep_loss_notify);
  self endon("disconnect");
  var_0 = ["zmb_dlc4_fzn_dwn_klau_looktothestarstheydrawbot", "zmb_dlc4_fzn_dwn_klau_seektheskyforsalvationdes", "zmb_dlc4_fzn_dwn_klau_thecloudsareveilstoourete", "zmb_dlc4_fzn_dwn_klau_asonearthasitisintheheave", "zmb_dlc4_fzn_dwn_klau_findthelordsintheskytheyk", "zmb_dlc4_fzn_dwn_klau_bethereachthatspansthehea", "zmb_dlc4_fzn_dwn_klau_endthereignofundeathwield"];
  thread vo_whisper_think("spike", var_0);

  if(!common_scripts\utility::_id_562E(self.dlg_heard_spike_intro)) {
    self.dlg_heard_spike_intro = 1;
    thread vo_play_klaus_weapon_intro("zmb_dlc4_fzn_dwn_klau_ispeakforlurothfirstofthe", "spike");
  }
}

scythe_post_give() {
  self endon(level.ravenweaponmanager["scythe"].wep_loss_notify);
  self endon("disconnect");
  var_0 = ["zmb_dlc4_fzn_dwn_klau_maketheofferingdeathawait", "zmb_dlc4_fzn_dwn_klau_killthechosendeathabides", "zmb_dlc4_fzn_dwn_klau_releasesurrenderanddiedea", "zmb_dlc4_fzn_dwn_klau_killthemkillthemall", "zmb_dlc4_fzn_dwn_klau_walklikedeathcloakedinfin", "zmb_dlc4_fzn_dwn_klau_yourpalehorseawaitsbringp"];
  thread vo_whisper_think("scythe", var_0);

  if(!common_scripts\utility::_id_562E(self.dlg_heard_scythe_intro)) {
    self.dlg_heard_scythe_intro = 1;
    thread vo_play_klaus_weapon_intro("zmb_dlc4_fzn_dwn_klau_ispeakforanhiestfirstofth", "scythe");
  }
}

shield_post_give() {
  self endon(level.ravenweaponmanager["shield"].wep_loss_notify);
  self endon("disconnect");
  var_0 = ["zmb_dlc4_fzn_dwn_klau_bloodholdsoursecretsbotha", "zmb_dlc4_fzn_dwn_klau_spiltbloodisadivinegiftso", "zmb_dlc4_fzn_dwn_klau_bloodittiesalllivingthing", "zmb_dlc4_fzn_dwn_klau_seethroughtheeyesofthedea", "zmb_dlc4_fzn_dwn_klau_bornfrombloodendwithblood", "zmb_dlc4_fzn_dwn_klau_bloodislifebloodsignalsde", "zmb_dlc4_fzn_dwn_klau_peacetravelleryoufollowth", "zmb_dlc4_fzn_dwn_klau_bleedfortheinnocent", "zmb_dlc4_fzn_dwn_klau_bybloodbyragebytheragingt"];
  thread vo_whisper_think("shield", var_0);

  if(!common_scripts\utility::_id_562E(self.dlg_heard_shield_intro)) {
    self.dlg_heard_shield_intro = 1;
    thread vo_play_klaus_weapon_intro("zmb_dlc4_fzn_dwn_klau_ispeakforsangketfirstofth", "shield");
  }
}

hammer_post_give() {
  self endon(level.ravenweaponmanager["hammer"].wep_loss_notify);
  self endon("disconnect");
  var_0 = ["zmb_dlc4_fzn_dwn_klau_chaosbringsfreedomfreedom", "zmb_dlc4_fzn_dwn_klau_listenforthethunderinsile", "zmb_dlc4_fzn_dwn_klau_harkenthelightandthenthes", "zmb_dlc4_fzn_dwn_klau_patternsdissolveintochaos", "zmb_dlc4_fzn_dwn_klau_theeternalwarbetweenchaos", "zmb_dlc4_fzn_dwn_klau_moveintothelightningthest", "zmb_dlc4_fzn_dwn_klau_weareentropyendthesicklyo"];
  thread vo_whisper_think("hammer", var_0);

  if(!common_scripts\utility::_id_562E(self.dlg_heard_hammer_intro)) {
    self.dlg_heard_hammer_intro = 1;
    thread vo_play_klaus_weapon_intro("zmb_dlc4_fzn_dwn_klau_ispeakfortalrekfirstofthe", "hammer");
  }
}

_id_902A(var_0) {
  if(isDefined(var_0.weaponlocktargettooclose)) {
    switch (var_0.weaponlocktargettooclose) {
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

dirtspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_dirt");
  }
}

mudspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_mud");
  }
}

concretespawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_concrete");
  }
}

sandspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_sand");
  }
}

waterspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_water");
    thread zombiedripfx("zmb_spawn_water");
  }
}

bloodspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_blood");
    thread zombiedripfx("zmb_spawn_blood");
  }
}

snowspawnnotetrackhandler(var_0, var_1, var_2, var_3) {
  if(var_0 == "zom_spawn_event") {
    thread zombiespawnfx("zmb_spawn_snow");
  }
}

zombiedripfx(var_0) {
  if(level._id_A980 >= 20) {
    return;
  }
  var_1 = "spawn_water_drip";

  if(isDefined(var_0)) {
    var_1 = var_0 + "_drip";
  }

  var_2 = ["J_Spine4"];

  foreach(var_5 in var_2) {
    if(isDefined(self gettagorigin(var_5))) {
      _id_0547::_id_74A5(common_scripts\utility::_id_44F5(var_1), self, var_5);
    }
  }

  zombiedripfxcleanup(var_2, var_1);
}

zombiedripfxcleanup(var_0, var_1) {
  self endon("death");

  while(isDefined(self) && isalive(self)) {
    wait 0.1;

    if(!isDefined(self._id_53D9) || !self._id_53D9) {
      break;
    }
  }

  wait(_randomfloatrange(5.0, 15.0));

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  foreach(var_3 in var_0) {
    if(isDefined(self gettagorigin(var_3))) {
      _id_0547::_id_9406(common_scripts\utility::_id_44F5(var_1), self, var_3);
    }
  }
}

zombiespawnfx(var_0) {
  if(level.zombiespawnfxcount >= 12) {
    return;
  }
  var_1 = _spawnfx(common_scripts\utility::_id_44F5(var_0), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
  _triggerfx(var_1);
  level.zombiespawnfxcount++;
  common_scripts\utility::waittill_notify_or_timeout("death", 2.0);
  level.zombiespawnfxcount--;
  var_1 delete();
}

try_catch_on_fire() {
  self endon("death");
  var_0 = 0;

  foreach(var_2 in _id_0547::_id_408F()) {
    if(common_scripts\utility::_id_562E(var_2.isonfire)) {
      var_0++;
    }
  }

  if(var_0 < 4) {
    self.isonfire = 1;
    _id_0547::_id_A6F6();
    self _meth_8682(0, 100, 1, "none", 1);
  }
}

start_screenshake(var_0) {
  var_1 = self;

  while(var_0 > 0) {
    var_2 = 0.55 + _randomfloat(0.55);
    var_0 = var_0 - var_2;
    var_1 playRumbleOnEntity("damage_heavy");
    _earthquake(0.4, var_2, self.origin, 96);
    wait(var_2);
  }
}

reveal_first_room_door() {
  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1.getnegotiationnextnode) && var_1.getnegotiationnextnode == "flag_limbo_to_cave_intro" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1)) {
      var_1 notify("open", undefined);
    }
  }
}

spine_pickup_anim(var_0) {
  var_1 = self;

  while(var_1 isswitchingweapon()) {
    waitframe();
  }

  var_2 = var_1 getcurrentweapon();
  var_1 common_scripts\utility::_id_0603();
  var_1 common_scripts\utility::_disableoffhandweapons();
  var_1 _id_0586::_id_078C(var_0);
  var_1 _id_0586::_id_078E(var_0, 1);
  var_1 allowjump(0);
  var_1 allowsprint(0);
  wait 0.1;
  var_1 setstance("stand");
  var_1 allowcrouch(0);
  var_1 allowprone(0);
  var_1 thread _id_0378::_id_8D74("ripsaw_spine_cut");
  var_1 wait_for_weapon_change(var_0);
  wait 3;

  if(!_id_0547::_id_73F9(self, var_2)) {
    var_2 = var_1 _id_0547::_id_AB2B();
  }

  var_1 _id_0586::_id_078E(var_2);
  var_1 common_scripts\utility::_id_0617();
  var_1 common_scripts\utility::_id_0614();

  if(var_1 hasweapon(var_0)) {
    var_1 _id_0586::_id_0790(var_0);
  }

  var_1 _meth_8546(1);
  var_1 allowlean(1);
  var_1 allowsprint(1);
  var_1 allowcrouch(1);
  var_1 allowprone(1);
  var_1 allowjump(1);
}

wait_for_weapon_change(var_0) {
  self endon("weapon_change");

  for(;;) {
    var_1 = self getcurrentweapon();

    if(var_1 == var_0) {
      break;
    }

    waitframe();
  }
}

set_fx(var_0, var_1) {
  if(isDefined(self.fx)) {
    self.fx delete();
  }

  if(!isDefined(var_1)) {
    var_1 = "tag_fx";
  }

  self._id_3F74 = var_0;
  self.fx = _spawnlinkedfx(common_scripts\utility::_id_44F5(var_0), self, var_1);
  _triggerfx(self.fx);

  if(_isagent(self)) {
    maps\mp\agents\_agent_utility::deleteentonagentdeath(self.fx);
  } else {
    self.fx thread _id_0547::_id_2D19(self);
  }
}

wait_for_player_close(var_0) {
  for(;;) {
    foreach(var_2 in level.players) {
      if(distance(var_2.origin, self.origin) < var_0) {
        return var_2;
      }
    }

    waitframe();
  }
}