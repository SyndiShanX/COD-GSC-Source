/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2840.gsc
**************************************/

_id_97F3() {
  _id_97F4();
  _id_9899();
  _id_9883();
}

_id_CF09() {
  setomnvar("ui_hide_hud", 1);
  _id_9893();
  level._id_4A41 = 0;
  thread _id_990A();
  level._id_A9AD = scripts\sp\endmission::_id_6CD9();
  level._id_4A40 = _id_49A0();

  if(!getdvarint("credits_test_fast")) {
    _id_1013C("CREDITS_MEMORY", 5);
  }

  level.memoirplaying = 0;
  thread _id_56DF();
  var_0 = tablelookuprownum("sp/credits.csv", 0, "__END__");

  if(getdvarint("credits_test_fast")) {
    var_0 = 500;
  }

  var_1 = 0;
  var_2 = [];

  if(level._id_A9AD) {
    var_3 = get_pan_time(var_0);
    level notify("start_credits_pan", var_3 + 5);
  }

  var_4 = 0;

  for(var_5 = 1; var_5 < var_0; var_5++) {
    var_6 = tablelookupbyrow("sp/credits.csv", var_5, 0);
    var_7 = tablelookupbyrow("sp/credits.csv", var_5, 1);
    var_8 = tablelookupbyrow("sp/credits.csv", var_5, 2);
    var_7 = tolower(var_7);

    if(var_7 == "") {
      var_7 = undefined;
    }

    var_8 = tolower(var_8);

    if(var_8 == "") {
      var_8 = undefined;
    }

    if(isDefined(var_8)) {
      if(var_8 == "localized") {
        var_6 = _id_7F7D(var_6);
        _id_4A34(var_6, undefined, var_7);
      }

      continue;
    }

    if(isDefined(var_7)) {
      _id_4A34(var_6, undefined, var_7);
      continue;
    }

    if(var_6 == "BLANK") {
      if(var_1) {
        _id_4A37(var_2);
        var_1 = 0;
      }

      _id_2B59();
      continue;
    }

    if(!var_1) {
      var_2 = [];
      var_1 = 1;
    }

    var_2[var_2.size] = var_6;
  }

  wait 11;
  _id_41C7();
  level._id_4A41 = 1;

  if(!level._id_A9AD) {
    return;
  }
  _id_1013C("CREDITS_NOROBOTS", 5);
  _id_1013C("CREDITS_THANKS", 15, -90, 1);
}

get_pan_time(var_0) {
  var_1 = 0;
  var_2 = 0;

  for(var_3 = 1; var_3 < var_0; var_3++) {
    var_4 = tablelookupbyrow("sp/credits.csv", var_3, 0);
    var_5 = tablelookupbyrow("sp/credits.csv", var_3, 1);
    var_6 = tablelookupbyrow("sp/credits.csv", var_3, 2);
    var_5 = tolower(var_5);

    if(var_5 == "") {
      var_5 = undefined;
    }

    if(isDefined(var_5)) {
      if(var_5 == "title") {
        var_1 = var_1 + 0.7;
      } else if(var_5 == "subtitle") {
        var_1 = var_1 + 0.5;
      } else if(var_5 == "image") {
        var_1 = var_1 + 1.0;
      } else if(var_5 == "small_image") {
        var_1 = var_1 + 0.5;
      }

      continue;
    }

    if(var_4 == "BLANK") {
      if(var_2) {
        var_1 = var_1 + 3.0;
        var_2 = 0;
      }

      var_1 = var_1 + 0.34;
      continue;
    }

    var_2 = 1;
    var_1 = var_1 + 0.34;
  }

  return var_1;
}

_id_990A() {
  wait 2;
  var_0 = 0;
  var_1 = 1;

  while(!level._id_4A41) {
    wait 0.05;

    if(gettime() > var_0) {
      if(level.player attackButtonPressed()) {
        var_2 = 3;
      } else {
        var_2 = 1;
      }

      if(var_2 != var_1) {
        setslowmotion(var_1, var_2, 1);
        var_1 = var_2;
        var_0 = gettime() + 300;
      }
    }
  }

  setslowmotion(var_1, 1, 0.5);
}

_id_1013C(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_5 = newhudelem();
  var_5.x = 0;
  var_5.y = 0 + var_2;
  var_5.horzalign = "center";
  var_5.vertalign = "middle";
  var_5.alignx = "center";
  var_5.aligny = "middle";
  var_5.sort = 5;
  var_5.font = "objective";
  var_5.fontscale = 1.25;
  var_5 settext(level._id_4A39._id_1114E[var_0]);
  var_5.alpha = 0;

  if(var_0 == "CREDITS_THANKS") {
    var_5.alignx = "center";
    var_5.horzalign = "fullscreen";
    var_5.x = 320;
  }

  if(isDefined(var_4)) {
    return var_5;
  }

  var_5 hud_fadeovertime(2.0, 1);
  var_6 = undefined;

  if(isDefined(var_3)) {
    var_6 = createiwsignature();
    var_6 fadeovertime(2.0);
    var_6.alpha = 1;
  }

  wait(var_1);

  if(isDefined(var_6)) {
    var_6 fadeovertime(2.0);
    var_6.alpha = 0;
  }

  var_5 hud_fadeovertime(2.0, 0);
  wait 2;
  var_5 _id_913E();

  if(isDefined(var_6)) {
    var_6 destroy();
  }
}

createiwsignature() {
  var_0 = newhudelem();
  var_0.sort = 5;
  var_0.alpha = 0;
  var_0 iwsignatureposition();
  var_1 = _id_7F0F("iw");
  var_2 = var_1._id_9335;
  var_0.vertalign = "middle";
  var_0.horzalign = "center";
  var_3 = int(var_1.width * 0.6);
  var_4 = int(var_1.height * 0.6);
  var_0 setshader(var_2, var_3, var_4);
  return var_0;
}

iwsignatureposition() {
  self.alignx = "left";
  self.y = 85;
  self.x = -210;

  switch (getdvarint("loc_language")) {
    case 1:
    case 0:
      break;
    case 2:
      self.x = self.x - 37;
      self.y = self.y + 15;
      break;
    case 3:
      self.y = self.y + 20;
      break;
    case 4:
      self.x = self.x - 32;
      self.y = self.y + 15;
      break;
    case 5:
      self.x = self.x - 56;
      break;
    case 6:
      self.x = self.x - 48;
      break;
    case 7:
      self.x = self.x - 48;
      break;
    case 8:
      self.x = self.x - 40;
      break;
    case 9:
      self.x = self.x - 40;
      break;
    case 10:
      self.x = self.x + 15;
      break;
    case 11:
      self.x = self.x - 9;
      break;
    case 12:
      self.x = self.x - 9;
      break;
    case 13:
      self.x = self.x - 15;
      break;
    case 14:
      self.x = self.x - 10;
      break;
    case 15:
      self.x = self.x + 55;
      break;
    case 16:
      break;
    case 17:
      self.x = self.x - 68;
      break;
    case 18:
      self.x = self.x - 45;
      break;
    default:
      break;
  }
}

_id_4A34(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;

  if(isDefined(var_2)) {
    if(var_2 == "title") {
      var_3[var_3.size] = _id_499F(var_0, var_2);
      var_4 = 0.7;
    } else if(var_2 == "subtitle") {
      var_3[var_3.size] = _id_499F(var_0, var_2);
      var_4 = 0.5;
    } else if(var_2 == "image") {
      var_3[var_3.size] = _id_499F(var_0, var_2);
      var_4 = 1.0;
    } else if(var_2 == "small_image") {
      var_3[var_3.size] = _id_499F(var_0, var_2);
      var_4 = 0.5;
    } else if(var_2 == "music")
      var_3[var_3.size] = _id_499F(var_0, var_2);
    else {
      var_3[var_3.size] = _id_499F(var_0, var_2);
    }
  } else {
    var_3[var_3.size] = _id_499F(var_0, "left");

    if(isDefined(var_1)) {
      var_3[var_3.size] = _id_499F(var_1, "right");
    }
  }

  scripts\engine\utility::array_thread(var_3, ::_id_4A38);
  var_5 = 0.34 + var_4;
  var_5 = max(var_5, 0);
  wait(var_5);
}

_id_4A38() {
  var_0 = 1.0;
  hud_fadeovertime(var_0, 1);
  thread creditsubtitle_think();
  var_1 = 10;
  hud_moveovertime(var_1, undefined, -20);
  wait(var_1 - var_0);
  hud_fadeovertime(var_0, 0);
  wait(var_0);
  _id_913E();
}

hud_fadeovertime(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;

  if(isDefined(self.dropshadow)) {
    self.dropshadow hud_fadeovertime(var_0, var_1 * 0.8);
  }
}

hud_moveovertime(var_0, var_1, var_2) {
  self moveovertime(var_0);

  if(isDefined(var_1)) {
    if(isDefined(self.isdropshadow)) {
      var_1 = var_1 + 1;
    }

    self.x = var_1;
  }

  if(isDefined(var_2)) {
    if(isDefined(self.isdropshadow)) {
      var_2 = var_2 + 1;
    }

    self.y = var_2;
  }

  if(isDefined(self.dropshadow)) {
    self.dropshadow hud_moveovertime(var_0, var_1, var_2);
  }
}

_id_913E(var_0, var_1) {
  if(isDefined(self.dropshadow)) {
    self.dropshadow destroy();
  }

  self destroy();
}

creditsubtitle_think() {
  self endon("death");
  var_0 = 500;
  var_1 = 2500;

  if(!level.console) {
    var_2 = 700;
    var_0 = var_0 + var_2;
    var_1 = var_1 + var_2;
  }

  var_3 = gettime();
  var_4 = var_3 + var_1;
  var_5 = 1;
  var_6 = 0;

  while(gettime() < var_4) {
    var_5 = level.memoirplaying && level.player _meth_8139("subtitles");

    if(var_6 != var_5) {
      if(gettime() - var_3 > var_0) {
        hud_fadeovertime(0.3, 0.08);
        var_6 = var_5;
      }
    }

    wait 0.05;
  }

  hud_fadeovertime(0.3, 1);
}

_id_2B59(var_0) {
  wait 0.34;
}

createdropshadow(var_0, var_1) {
  var_2 = _id_499F(var_0, var_1);
  var_2.x = var_2.x + 1;
  var_2.y = var_2.y + 1;
  var_2.sort = 2;
  var_2.alpha = 0;
  var_2.isdropshadow = 1;
  var_2.color = (0, 0, 0);
  return var_2;
}

_id_499F(var_0, var_1) {
  var_2 = newhudelem();
  var_3 = 0;
  var_4 = "center";
  var_5 = 1.35;
  var_6 = 0;
  var_7 = (1, 1, 1);
  var_8 = "small";
  var_9 = 1.1;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;

  if(var_1 == "title" || var_1 == "subtitle") {
    var_3 = 0;
    var_5 = 1.75;
    var_6 = 1;
    var_7 = (1, 1, 0.003);
    var_8 = "default";
    var_9 = 1.2;
  } else if(var_1 == "image") {
    var_13 = _id_7F0F(var_0);
    var_10 = var_13._id_9335;
    var_11 = var_13.width;
    var_12 = var_13.height;
  } else if(var_1 == "small_image") {
    var_13 = _id_7F0F(var_0);
    var_10 = var_13._id_9335;
    var_11 = int(var_13.width * 0.5);
    var_12 = int(var_13.height * 0.5);
  } else if(var_1 == "center")
    var_3 = 0;
  else if(var_1 == "left") {
    var_3 = -150;
  } else if(var_1 == "right") {
    var_3 = 150;
  }

  var_2.x = var_3;
  var_2.y = 480;
  var_2._id_10D67 = var_2.y;
  var_2.alignx = var_4;
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.alpha = 0;
  var_2.fontscale = var_9;
  var_2.color = var_7;
  var_2.font = var_8;
  var_2.glowcolor = (0.3, 0.6, 0.3);
  var_2.glowalpha = var_6;
  var_2.foreground = 0;
  var_2.sort = 5;

  if(!isDefined(var_10)) {
    var_2 settext(var_0);
  } else {
    var_2 setshader(var_10, var_11, var_12);
  }

  return var_2;
}

_id_49A0() {
  var_0 = newhudelem();
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0.foreground = 0;
  var_0 setshader("black", 640, 480);
  return var_0;
}

_id_4A37(var_0) {
  var_0 = scripts\engine\utility::alphabetize(var_0);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    _id_4A34(var_0[var_1], undefined, "center");
  }

  wait 3.0;
}

_id_411D(var_0) {
  var_1 = strtok(var_0, " ");
  var_2 = var_1[0];

  for(var_3 = 1; var_3 < var_1.size; var_3++) {
    var_2 = var_2 + (" " + var_1[var_3]);
  }

  return var_2;
}

_id_97F4() {
  if(!isDefined(level._id_4A39)) {
    level._id_4A39 = spawnStruct();
  }
}

_id_9893() {
  _id_97F4();
  level._id_4A39._id_1114E["CREDITS_INFINITYWARD"] = &"CREDITS_INFINITYWARD";
  level._id_4A39._id_1114E["CREDITS_RAVEN"] = &"CREDITS_RAVEN";
  level._id_4A39._id_1114E["CREDITS_HIGHMOON"] = &"CREDITS_HIGHMOON";
  level._id_4A39._id_1114E["CREDITS_TREYARCH"] = &"CREDITS_TREYARCH";
  level._id_4A39._id_1114E["CREDITS_VICARIOUSVISIONS"] = &"CREDITS_VICARIOUSVISIONS";
  level._id_4A39._id_1114E["CREDITS_FREESTYLEGAMES"] = &"CREDITS_FREESTYLEGAMES";
  level._id_4A39._id_1114E["CREDITS_BEENOX"] = &"CREDITS_BEENOX";
  level._id_4A39._id_1114E["CREDITS_WRITTENBY"] = &"CREDITS_WRITTENBY";
  level._id_4A39._id_1114E["CREDITS_CAST"] = &"CREDITS_CAST";
  level._id_4A39._id_1114E["CREDITS_EARBASH"] = &"CREDITS_EARBASH";
  level._id_4A39._id_1114E["CREDITS_SONYMUSIC"] = &"CREDITS_SONYMUSIC";
  level._id_4A39._id_1114E["CREDITS_HEAVYIRON"] = &"CREDITS_HEAVYIRON";
  level._id_4A39._id_1114E["CREDITS_RYZIN"] = &"CREDITS_RYZIN";
  level._id_4A39._id_1114E["CREDITS_GAMEMECHANIC"] = &"CREDITS_GAMEMECHANIC";
  level._id_4A39._id_1114E["CREDITS_COUNTERPUNCH"] = &"CREDITS_COUNTERPUNCH";
  level._id_4A39._id_1114E["CREDITS_DIGIC"] = &"CREDITS_DIGIC";
  level._id_4A39._id_1114E["CREDITS_BLUR"] = &"CREDITS_BLUR";
  level._id_4A39._id_1114E["CREDITS_UNIT"] = &"CREDITS_UNIT";
  level._id_4A39._id_1114E["CREDITS_THERAPY"] = &"CREDITS_THERAPY";
  level._id_4A39._id_1114E["CREDITS_STUNT"] = &"CREDITS_STUNT";
  level._id_4A39._id_1114E["CREDITS_POWERHOUSE"] = &"CREDITS_POWERHOUSE";
  level._id_4A39._id_1114E["CREDITS_SOURCESOUND"] = &"CREDITS_SOURCESOUND";
  level._id_4A39._id_1114E["CREDITS_FORMOSA"] = &"CREDITS_FORMOSA";
  level._id_4A39._id_1114E["CREDITS_DEVBABIES"] = &"CREDITS_DEVBABIES";
  level._id_4A39._id_1114E["CREDITS_TITLETHEME"] = &"CREDITS_TITLETHEME";
  level._id_4A39._id_1114E["CREDITS_ADDITIONALDEVELOPMENTSUPPORT"] = &"CREDITS_ADDITIONALDEVELOPMENTSUPPORT";
  level._id_4A39._id_1114E["CREDITS_ADDCAST"] = &"CREDITS_ADDCAST";
  level._id_4A39._id_1114E["CREDITS_DOLBY"] = &"CREDITS_DOLBY";
  level._id_4A39._id_1114E["CREDITS_HAVOK"] = &"CREDITS_HAVOK";
  level._id_4A39._id_1114E["CREDITS_HAVOK2"] = &"CREDITS_HAVOK2";
  level._id_4A39._id_1114E["CREDITS_HAVOK3"] = &"CREDITS_HAVOK3";
  level._id_4A39._id_1114E["CREDITS_DEMONWARE"] = &"CREDITS_DEMONWARE";
  level._id_4A39._id_1114E["CREDITS_ACTIVISION"] = &"CREDITS_ACTIVISION";
  level._id_4A39._id_1114E["CREDITS_EXTERNALPARTNERS"] = &"CREDITS_EXTERNALPARTNERS";
  level._id_4A39._id_1114E["CREDITS_NOROBOTS"] = &"CREDITS_NOROBOTS";
  level._id_4A39._id_1114E["CREDITS_SPECIALTHANKS"] = &"CREDITS_SPECIALTHANKS";
  level._id_4A39._id_1114E["CREDITS_MEMORY"] = &"CREDITS_MEMORY";
  level._id_4A39._id_1114E["CREDITS_THANKS"] = &"CREDITS_THANKS";
  level._id_4A39._id_1114E["CREDITS_FOLEY"] = &"CREDITS_FOLEY";
  level._id_4A39._id_1114E["CREDITS_MILITARY"] = &"CREDITS_MILITARY";
  level._id_4A39._id_1114E["CREDITS_OBSESSION1"] = &"CREDITS_OBSESSION1";
  level._id_4A39._id_1114E["CREDITS_OBSESSION2"] = &"CREDITS_OBSESSION2";
  level._id_4A39._id_1114E["CREDITS_OBSESSION3"] = &"CREDITS_OBSESSION3";
  level._id_4A39._id_1114E["CREDITS_OBSESSION4"] = &"CREDITS_OBSESSION4";
  level._id_4A39._id_1114E["CREDITS_OBSESSION5"] = &"CREDITS_OBSESSION5";
  level._id_4A39._id_1114E["CREDITS_OBSESSION6"] = &"CREDITS_OBSESSION6";
  level._id_4A39._id_1114E["CREDITS_OBSESSION7"] = &"CREDITS_OBSESSION7";
  level._id_4A39._id_1114E["CREDITS_SHOOTYOUDOWN1"] = &"CREDITS_SHOOTYOUDOWN1";
  level._id_4A39._id_1114E["CREDITS_SHOOTYOUDOWN2"] = &"CREDITS_SHOOTYOUDOWN2";
  level._id_4A39._id_1114E["CREDITS_SHOOTYOUDOWN3"] = &"CREDITS_SHOOTYOUDOWN3";
  level._id_4A39._id_1114E["CREDITS_SHOOTYOUDOWN4"] = &"CREDITS_SHOOTYOUDOWN4";
  level._id_4A39._id_1114E["CREDITS_SHOOTYOUDOWN5"] = &"CREDITS_SHOOTYOUDOWN5";
  level._id_4A39._id_1114E["CREDITS_SHOOTYOUDOWN6"] = &"CREDITS_SHOOTYOUDOWN6";
  level._id_4A39._id_1114E["CREDITS_THEMETRO1"] = &"CREDITS_THEMETRO1";
  level._id_4A39._id_1114E["CREDITS_THEMETRO2"] = &"CREDITS_THEMETRO2";
  level._id_4A39._id_1114E["CREDITS_THEMETRO3"] = &"CREDITS_THEMETRO3";
  level._id_4A39._id_1114E["CREDITS_THEMETRO4"] = &"CREDITS_THEMETRO4";
  level._id_4A39._id_1114E["CREDITS_THEMETRO5"] = &"CREDITS_THEMETRO5";
  level._id_4A39._id_1114E["CREDITS_THEMETRO6"] = &"CREDITS_THEMETRO6";
  level._id_4A39._id_1114E["CREDITS_RAPTURE1"] = &"CREDITS_RAPTURE1";
  level._id_4A39._id_1114E["CREDITS_RAPTURE2"] = &"CREDITS_RAPTURE2";
  level._id_4A39._id_1114E["CREDITS_RAPTURE3"] = &"CREDITS_RAPTURE3";
  level._id_4A39._id_1114E["CREDITS_RAPTURE4"] = &"CREDITS_RAPTURE4";
  level._id_4A39._id_1114E["CREDITS_RAPTURE5"] = &"CREDITS_RAPTURE5";
  level._id_4A39._id_1114E["CREDITS_RAPTURE6"] = &"CREDITS_RAPTURE6";
  level._id_4A39._id_1114E["CREDITS_SUNGLASSES1"] = &"CREDITS_SUNGLASSES1";
  level._id_4A39._id_1114E["CREDITS_SUNGLASSES2"] = &"CREDITS_SUNGLASSES2";
  level._id_4A39._id_1114E["CREDITS_SUNGLASSES3"] = &"CREDITS_SUNGLASSES3";
  level._id_4A39._id_1114E["CREDITS_SUNGLASSES4"] = &"CREDITS_SUNGLASSES4";
  level._id_4A39._id_1114E["CREDITS_SUNGLASSES5"] = &"CREDITS_SUNGLASSES5";
  level._id_4A39._id_1114E["CREDITS_SUNGLASSES6"] = &"CREDITS_SUNGLASSES6";
  level._id_4A39._id_1114E["CREDITS_WHIP1"] = &"CREDITS_WHIP1";
  level._id_4A39._id_1114E["CREDITS_WHIP2"] = &"CREDITS_WHIP2";
  level._id_4A39._id_1114E["CREDITS_WHIP3"] = &"CREDITS_WHIP3";
  level._id_4A39._id_1114E["CREDITS_WHIP4"] = &"CREDITS_WHIP4";
  level._id_4A39._id_1114E["CREDITS_WHIP5"] = &"CREDITS_WHIP5";
  level._id_4A39._id_1114E["CREDITS_WHIP6"] = &"CREDITS_WHIP6";
  level._id_4A39._id_1114E["CREDITS_HEARMUSIC1"] = &"CREDITS_HEARMUSIC1";
  level._id_4A39._id_1114E["CREDITS_HEARMUSIC2"] = &"CREDITS_HEARMUSIC2";
  level._id_4A39._id_1114E["CREDITS_HEARMUSIC3"] = &"CREDITS_HEARMUSIC3";
  level._id_4A39._id_1114E["CREDITS_HEARMUSIC4"] = &"CREDITS_HEARMUSIC4";
  level._id_4A39._id_1114E["CREDITS_HEARMUSIC5"] = &"CREDITS_HEARMUSIC5";
  level._id_4A39._id_1114E["CREDITS_HEARMUSIC6"] = &"CREDITS_HEARMUSIC6";
  level._id_4A39._id_1114E["CREDITS_COUNTDOWN1"] = &"CREDITS_COUNTDOWN1";
  level._id_4A39._id_1114E["CREDITS_COUNTDOWN2"] = &"CREDITS_COUNTDOWN2";
  level._id_4A39._id_1114E["CREDITS_COUNTDOWN3"] = &"CREDITS_COUNTDOWN3";
  level._id_4A39._id_1114E["CREDITS_COUNTDOWN4"] = &"CREDITS_COUNTDOWN4";
  level._id_4A39._id_1114E["CREDITS_COUNTDOWN5"] = &"CREDITS_COUNTDOWN5";
  level._id_4A39._id_1114E["CREDITS_COUNTDOWN6"] = &"CREDITS_COUNTDOWN6";
  level._id_4A39._id_1114E["CREDITS_COUNTDOWN7"] = &"CREDITS_COUNTDOWN7";
  level._id_4A39._id_1114E["CREDITS_BOMB1"] = &"CREDITS_BOMB1";
  level._id_4A39._id_1114E["CREDITS_BOMB2"] = &"CREDITS_BOMB2";
  level._id_4A39._id_1114E["CREDITS_BOMB3"] = &"CREDITS_BOMB3";
  level._id_4A39._id_1114E["CREDITS_BOMB4"] = &"CREDITS_BOMB4";
  level._id_4A39._id_1114E["CREDITS_BOMB5"] = &"CREDITS_BOMB5";
  level._id_4A39._id_1114E["CREDITS_BOMB6"] = &"CREDITS_BOMB6";
  level._id_4A39._id_1114E["CREDITS_PLANET1"] = &"CREDITS_PLANET1";
  level._id_4A39._id_1114E["CREDITS_PLANET2"] = &"CREDITS_PLANET2";
  level._id_4A39._id_1114E["CREDITS_PLANET3"] = &"CREDITS_PLANET3";
  level._id_4A39._id_1114E["CREDITS_PLANET4"] = &"CREDITS_PLANET4";
  level._id_4A39._id_1114E["CREDITS_PLANET5"] = &"CREDITS_PLANET5";
  level._id_4A39._id_1114E["CREDITS_PLANET6"] = &"CREDITS_PLANET6";
  level._id_4A39._id_1114E["CREDITS_SECONDS1"] = &"CREDITS_SECONDS1";
  level._id_4A39._id_1114E["CREDITS_SECONDS2"] = &"CREDITS_SECONDS2";
  level._id_4A39._id_1114E["CREDITS_SECONDS3"] = &"CREDITS_SECONDS3";
  level._id_4A39._id_1114E["CREDITS_SECONDS4"] = &"CREDITS_SECONDS4";
  level._id_4A39._id_1114E["CREDITS_SECONDS5"] = &"CREDITS_SECONDS5";
  level._id_4A39._id_1114E["CREDITS_SECONDS6"] = &"CREDITS_SECONDS6";
  level._id_4A39._id_1114E["CREDITS_SECONDS7"] = &"CREDITS_SECONDS7";
  level._id_4A39._id_1114E["CREDITS_UNDERPASS1"] = &"CREDITS_UNDERPASS1";
  level._id_4A39._id_1114E["CREDITS_UNDERPASS2"] = &"CREDITS_UNDERPASS2";
  level._id_4A39._id_1114E["CREDITS_UNDERPASS3"] = &"CREDITS_UNDERPASS3";
  level._id_4A39._id_1114E["CREDITS_UNDERPASS4"] = &"CREDITS_UNDERPASS4";
  level._id_4A39._id_1114E["CREDITS_UNDERPASS5"] = &"CREDITS_UNDERPASS5";
  level._id_4A39._id_1114E["CREDITS_UNDERPASS6"] = &"CREDITS_UNDERPASS6";
  level._id_4A39._id_1114E["CREDITS_KNIGHTRIDER1"] = &"CREDITS_KNIGHTRIDER1";
  level._id_4A39._id_1114E["CREDITS_KNIGHTRIDER2"] = &"CREDITS_KNIGHTRIDER2";
  level._id_4A39._id_1114E["CREDITS_KNIGHTRIDER3"] = &"CREDITS_KNIGHTRIDER3";
  level._id_4A39._id_1114E["CREDITS_KNIGHTRIDER4"] = &"CREDITS_KNIGHTRIDER4";
  level._id_4A39._id_1114E["CREDITS_KNIGHTRIDER5"] = &"CREDITS_KNIGHTRIDER5";
  level._id_4A39._id_1114E["CREDITS_KNIGHTRIDER6"] = &"CREDITS_KNIGHTRIDER6";
  level._id_4A39._id_1114E["CREDITS_FREAK1"] = &"CREDITS_FREAK1";
  level._id_4A39._id_1114E["CREDITS_FREAK2"] = &"CREDITS_FREAK2";
  level._id_4A39._id_1114E["CREDITS_FREAK3"] = &"CREDITS_FREAK3";
  level._id_4A39._id_1114E["CREDITS_FREAK4"] = &"CREDITS_FREAK4";
  level._id_4A39._id_1114E["CREDITS_FREAK5"] = &"CREDITS_FREAK5";
  level._id_4A39._id_1114E["CREDITS_FREAK6"] = &"CREDITS_FREAK6";
  level._id_4A39._id_1114E["CREDITS_EFFIGY1"] = &"CREDITS_EFFIGY1";
  level._id_4A39._id_1114E["CREDITS_EFFIGY2"] = &"CREDITS_EFFIGY2";
  level._id_4A39._id_1114E["CREDITS_EFFIGY3"] = &"CREDITS_EFFIGY3";
  level._id_4A39._id_1114E["CREDITS_EFFIGY4"] = &"CREDITS_EFFIGY4";
  level._id_4A39._id_1114E["CREDITS_EFFIGY5"] = &"CREDITS_EFFIGY5";
  level._id_4A39._id_1114E["CREDITS_EFFIGY6"] = &"CREDITS_EFFIGY6";
  level._id_4A39._id_1114E["CREDITS_HALLOWEEN1"] = &"CREDITS_HALLOWEEN1";
  level._id_4A39._id_1114E["CREDITS_HALLOWEEN2"] = &"CREDITS_HALLOWEEN2";
  level._id_4A39._id_1114E["CREDITS_HALLOWEEN3"] = &"CREDITS_HALLOWEEN3";
  level._id_4A39._id_1114E["CREDITS_HALLOWEEN4"] = &"CREDITS_HALLOWEEN4";
  level._id_4A39._id_1114E["CREDITS_HALLOWEEN5"] = &"CREDITS_HALLOWEEN5";
  level._id_4A39._id_1114E["CREDITS_HALLOWEEN6"] = &"CREDITS_HALLOWEEN6";
  level._id_4A39._id_1114E["CREDITS_KINGOFROCK1"] = &"CREDITS_KINGOFROCK1";
  level._id_4A39._id_1114E["CREDITS_KINGOFROCK2"] = &"CREDITS_KINGOFROCK2";
  level._id_4A39._id_1114E["CREDITS_KINGOFROCK3"] = &"CREDITS_KINGOFROCK3";
  level._id_4A39._id_1114E["CREDITS_KINGOFROCK4"] = &"CREDITS_KINGOFROCK4";
  level._id_4A39._id_1114E["CREDITS_KINGOFROCK5"] = &"CREDITS_KINGOFROCK5";
  level._id_4A39._id_1114E["CREDITS_KINGOFROCK6"] = &"CREDITS_KINGOFROCK6";
  level._id_4A39._id_1114E["CREDITS_TAINTEDLOVE1"] = &"CREDITS_TAINTEDLOVE1";
  level._id_4A39._id_1114E["CREDITS_TAINTEDLOVE2"] = &"CREDITS_TAINTEDLOVE2";
  level._id_4A39._id_1114E["CREDITS_TAINTEDLOVE3"] = &"CREDITS_TAINTEDLOVE3";
  level._id_4A39._id_1114E["CREDITS_TAINTEDLOVE4"] = &"CREDITS_TAINTEDLOVE4";
  level._id_4A39._id_1114E["CREDITS_TAINTEDLOVE5"] = &"CREDITS_TAINTEDLOVE5";
  level._id_4A39._id_1114E["CREDITS_TAINTEDLOVE6"] = &"CREDITS_TAINTEDLOVE6";
  level._id_4A39._id_1114E["CREDITS_GHOSTTOWN1"] = &"CREDITS_GHOSTTOWN1";
  level._id_4A39._id_1114E["CREDITS_GHOSTTOWN2"] = &"CREDITS_GHOSTTOWN2";
  level._id_4A39._id_1114E["CREDITS_GHOSTTOWN3"] = &"CREDITS_GHOSTTOWN3";
  level._id_4A39._id_1114E["CREDITS_GHOSTTOWN4"] = &"CREDITS_GHOSTTOWN4";
  level._id_4A39._id_1114E["CREDITS_GHOSTTOWN5"] = &"CREDITS_GHOSTTOWN5";
  level._id_4A39._id_1114E["CREDITS_GHOSTTOWN6"] = &"CREDITS_GHOSTTOWN6";
  level._id_4A39._id_1114E["CREDITS_VIDEO1"] = &"CREDITS_VIDEO1";
  level._id_4A39._id_1114E["CREDITS_VIDEO2"] = &"CREDITS_VIDEO2";
  level._id_4A39._id_1114E["CREDITS_VIDEO3"] = &"CREDITS_VIDEO3";
  level._id_4A39._id_1114E["CREDITS_VIDEO4"] = &"CREDITS_VIDEO4";
  level._id_4A39._id_1114E["CREDITS_VIDEO5"] = &"CREDITS_VIDEO5";
  level._id_4A39._id_1114E["CREDITS_VIDEO6"] = &"CREDITS_VIDEO6";
  level._id_4A39._id_1114E["CREDITS_WANNAROCK1"] = &"CREDITS_WANNAROCK1";
  level._id_4A39._id_1114E["CREDITS_WANNAROCK2"] = &"CREDITS_WANNAROCK2";
  level._id_4A39._id_1114E["CREDITS_WANNAROCK3"] = &"CREDITS_WANNAROCK3";
  level._id_4A39._id_1114E["CREDITS_WANNAROCK4"] = &"CREDITS_WANNAROCK4";
  level._id_4A39._id_1114E["CREDITS_WANNAROCK5"] = &"CREDITS_WANNAROCK5";
  level._id_4A39._id_1114E["CREDITS_WANNAROCK6"] = &"CREDITS_WANNAROCK6";
  level._id_4A39._id_1114E["CREDITS_ADDITUP1"] = &"CREDITS_ADDITUP1";
  level._id_4A39._id_1114E["CREDITS_ADDITUP2"] = &"CREDITS_ADDITUP2";
  level._id_4A39._id_1114E["CREDITS_ADDITUP3"] = &"CREDITS_ADDITUP3";
  level._id_4A39._id_1114E["CREDITS_ADDITUP4"] = &"CREDITS_ADDITUP4";
  level._id_4A39._id_1114E["CREDITS_ADDITUP5"] = &"CREDITS_ADDITUP5";
  level._id_4A39._id_1114E["CREDITS_ADDITUP6"] = &"CREDITS_ADDITUP6";
  level._id_4A39._id_1114E["CREDITS_HOLLYWOOD1"] = &"CREDITS_HOLLYWOOD1";
  level._id_4A39._id_1114E["CREDITS_HOLLYWOOD2"] = &"CREDITS_HOLLYWOOD2";
  level._id_4A39._id_1114E["CREDITS_HOLLYWOOD3"] = &"CREDITS_HOLLYWOOD3";
  level._id_4A39._id_1114E["CREDITS_HOLLYWOOD4"] = &"CREDITS_HOLLYWOOD4";
  level._id_4A39._id_1114E["CREDITS_HOLLYWOOD5"] = &"CREDITS_HOLLYWOOD5";
  level._id_4A39._id_1114E["CREDITS_HOLLYWOOD6"] = &"CREDITS_HOLLYWOOD6";
  level._id_4A39._id_1114E["CREDITS_REM1"] = &"CREDITS_REM1";
  level._id_4A39._id_1114E["CREDITS_REM2"] = &"CREDITS_REM2";
  level._id_4A39._id_1114E["CREDITS_REM3"] = &"CREDITS_REM3";
  level._id_4A39._id_1114E["CREDITS_REM4"] = &"CREDITS_REM4";
  level._id_4A39._id_1114E["CREDITS_REM5"] = &"CREDITS_REM5";
  level._id_4A39._id_1114E["CREDITS_REM6"] = &"CREDITS_REM6";
}

_id_9883() {
  _id_97F4();
  level._id_4A39._id_9339["iw"] = _id_9336("logo_iw", 1053, 274);
  level._id_4A39._id_9339["atvi"] = _id_9336("logo_atvi", 1080, 256);
  level._id_4A39._id_9339["fsg"] = _id_9336("logo_fsg", 784, 256);
  level._id_4A39._id_9339["hms"] = _id_9336("logo_hms", 544, 256);
  level._id_4A39._id_9339["ta"] = _id_9336("logo_ta", 1147, 256);
  level._id_4A39._id_9339["raven"] = _id_9336("logo_raven", 1264, 257);
  level._id_4A39._id_9339["vv"] = _id_9336("logo_vv", 1260, 256);
  level._id_4A39._id_9339["havok"] = _id_9336("logo_havok", 1113, 368);
  level._id_4A39._id_9339["dolby"] = _id_9336("logo_dolby", 260, 66);
  level._id_4A39._id_9339["demon"] = _id_9336("logo_demon", 886, 120);
  level._id_4A39._id_9339["beenox"] = _id_9336("logo_beenox", 784, 374);

  foreach(var_1 in level._id_4A39._id_9339) {
    precacheshader(var_1._id_9335);
  }
}

_id_9336(var_0, var_1, var_2) {
  var_3 = 0.75;
  var_4 = 200;
  var_5 = var_4 / (var_1 * var_3);
  var_6 = var_2 * var_3 * var_5;

  if(var_0 == "logo_iw") {
    var_4 = 250;
    var_5 = var_4 / (var_1 * var_3);
    var_6 = var_2 * var_3 * var_5;
  } else if(var_0 == "logo_atvi") {
    var_4 = 150;
    var_5 = var_4 / (var_1 * var_3);
    var_6 = var_2 * var_3 * var_5;
  }

  var_7 = spawnStruct();
  var_7._id_9335 = var_0;
  var_7.width = int(var_4);
  var_7.height = int(var_6);
  return var_7;
}

_id_7F0F(var_0) {
  if(!isDefined(level._id_4A39._id_9339) || !isDefined(level._id_4A39._id_9339[var_0])) {
    return _id_9336("white", 1280, 256);
  }

  return level._id_4A39._id_9339[var_0];
}

_id_7F7D(var_0) {
  if(!isDefined(level._id_4A39._id_1114E) || !isDefined(level._id_4A39._id_1114E[var_0])) {
    return "(NO SCRIPT REF): " + var_0;
  }

  return level._id_4A39._id_1114E[var_0];
}

_id_9899() {
  var_0 = [ &"CREDITS_INFO_OMAR_NAME", &"CREDITS_INFO_OMAR_SERVICE", &"CREDITS_INFO_OMAR_RANK"];
  _id_49E9("credits_portrait_omar", "sc_world_epilogue_omar_ifwhen", var_0, [-60, 0]);
  var_0 = [ &"CREDITS_INFO_ETH3N_NAME", &"CREDITS_INFO_ETH3N_SERVICE", &"CREDITS_INFO_ETH3N_RANK"];
  _id_49E9("credits_portrait_eth3n", "sc_world_epilogue_ethan_ifwhen", var_0, [-40, -50]);
  var_0 = [ &"CREDITS_INFO_GATOR_NAME", &"CREDITS_INFO_GATOR_SERVICE", &"CREDITS_INFO_GATOR_RANK"];
  _id_49E9("credits_portrait_gator", "sc_world_epilogue_gator_ifwhen", var_0);
  var_0 = [ &"CREDITS_INFO_MAC_NAME", &"CREDITS_INFO_MAC_SERVICE", &"CREDITS_INFO_MAC_RANK"];
  _id_49E9("credits_portrait_mac", "sc_world_epilogue_mac_ifwhen", var_0, [-120, 0]);
  var_0 = [ &"CREDITS_INFO_GRIFF_NAME", &"CREDITS_INFO_GRIFF_SERVICE", &"CREDITS_INFO_GRIFF_RANK"];
  _id_49E9("credits_portrait_griff", "sc_world_epilogue_griff_ifwhen", var_0, [-110, 0]);
  var_0 = [ &"CREDITS_INFO_KASH_NAME", &"CREDITS_INFO_KASH_SERVICE", &"CREDITS_INFO_KASH_RANK"];
  _id_49E9("credits_portrait_kash", "sc_world_epilogue_kash_ifwhen", var_0, [0, -40]);
  var_0 = [ &"CREDITS_INFO_DROPS_NAME", &"CREDITS_INFO_DROPS_SERVICE", &"CREDITS_INFO_DROPS_RANK"];
  _id_49E9("credits_portrait_drops", "sc_world_epilogue_yetide_ifwhen", var_0);
  var_0 = [ &"CREDITS_INFO_GIBSON_NAME", &"CREDITS_INFO_GIBSON_SERVICE", &"CREDITS_INFO_GIBSON_RANK"];
  _id_49E9("credits_portrait_gibson", "sc_world_epilogue_gibson_ifwhen", var_0, [-140, 0]);
}

_id_49E9(var_0, var_1, var_2, var_3) {
  precacheshader(var_0);
  var_4 = spawnStruct();
  var_4._id_9335 = var_0;
  var_4._id_2AD3 = var_1;
  var_4.info = var_2;

  if(isDefined(var_3)) {
    var_4._id_BCD0 = var_3;
  }

  if(!isDefined(level._id_4A39._id_B662)) {
    level._id_4A39._id_B662 = [];
  }

  level._id_4A39._id_B662[level._id_4A39._id_B662.size] = var_4;
}

_id_56DF() {
  if(!level._id_A9AD) {
    return;
  }
  wait 21;
  level.memoircount = level._id_4A39._id_B662.size;
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  var_0 = [];
  var_0[var_0.size] = _id_17B1(["+actionslot 1"], &"CREDITS_BUTTONPRESS_DPADUP");
  var_0[var_0.size] = _id_17B1(["+actionslot 2"], &"CREDITS_BUTTONPRESS_DPADDOWN");
  var_0[var_0.size] = _id_17B1(["+actionslot 3"], &"CREDITS_BUTTONPRESS_DPADLEFT");
  var_0[var_0.size] = _id_17B1(["+actionslot 4"], &"CREDITS_BUTTONPRESS_DPADRIGHT");
  var_0[var_0.size] = _id_17B1(["+weapnext"], &"CREDITS_BUTTONPRESS_WEAPNEXT");
  var_0[var_0.size] = _id_17B1(["+gostand"], &"CREDITS_BUTTONPRESS_GOSTAND");
  var_0[var_0.size] = _id_17B1(["+usereload", "+activate"], &"CREDITS_BUTTONPRESS_USERELOAD");
  var_0[var_0.size] = _id_17B1(["+stance", "+togglecrouch"], &"CREDITS_BUTTONPRESS_STANCE");
  var_1 = 270;
  var_2 = 1;
  var_3 = 30;
  var_4[0] = [0, var_3 * -1];
  var_4[1] = [0, var_3];
  var_4[2] = [var_3 * -1, 0];
  var_4[3] = [var_3, 0];

  foreach(var_10, var_6 in level._id_4A39._id_B662) {
    if(var_10 < 4) {
      var_2 = -1;
      var_7 = 10;
    } else {
      var_2 = 1;
      var_7 = -10;
    }

    var_8 = var_1 * var_2;
    var_9 = var_10 % 4;
    var_8 = var_8 + var_4[var_9][0];
    var_7 = var_7 + var_4[var_9][1];
    var_6._id_313E = var_0[var_10];
    var_6._id_912F = var_6 _id_49EA(var_8, var_7, var_9);
    var_6 thread updatebtn_text();
    var_6 thread _id_B664(var_10);
  }
}

_id_17B1(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.actions = var_0;
  var_2._id_AF54 = var_1;
  return var_2;
}

_id_49EA(var_0, var_1, var_2) {
  var_3 = newhudelem();
  var_3.x = var_0;
  var_3.y = var_1;
  var_4 = 10;

  switch (var_2) {
    case 0:
      var_3.y = var_3.y - var_4;
      var_3.x = var_3.x - var_4;
      var_3._id_101AD = "top";
      break;
    case 1:
      var_3.y = var_3.y + var_4;
      var_3.x = var_3.x + var_4;
      var_3._id_101AD = "bottom";
      break;
    case 2:
      var_3.y = var_3.y + var_4;
      var_3.x = var_3.x - var_4;
      var_3._id_101AD = "left";
      break;
    case 3:
      var_3.y = var_3.y - var_4;
      var_3.x = var_3.x + var_4;
      var_3._id_101AD = "right";
      break;
  }

  var_3.horzalign = "center";
  var_3.vertalign = "middle";
  [var_6, var_7] = _id_7DAE(var_2);
  var_3.alignx = var_6;
  var_3.aligny = var_7;
  var_3.foreground = 1;
  var_3.sort = 15;
  var_3 setshader(self._id_9335, 50, 50);
  var_3.alpha = 0;
  var_3 thread _id_5109(var_2 * 0.25, 0.5, 0.9);
  self._id_313F = _id_498D(var_0, var_1, var_2);
  self._id_313F thread _id_5109(1, 0.5, 1);
  return var_3;
}

_id_5109(var_0, var_1, var_2) {
  wait(var_0);
  hud_fadeovertime(var_1, var_2);
}

_id_498D(var_0, var_1, var_2, var_3) {
  var_4 = newhudelem();
  var_4.x = var_0;
  var_4.y = var_1;
  var_4.horzalign = "center";
  var_4.vertalign = "middle";
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.sort = 5;
  var_4.fontscale = 1.5;
  var_4 settext(self._id_313E._id_AF54);
  var_4.alpha = 0;
  return var_4;
}

_id_7DAE(var_0) {
  switch (var_0) {
    case 0:
      return ["left", "bottom"];
    case 1:
      return ["right", "top"];
    case 2:
      return ["right", "bottom"];
    case 3:
      return ["left", "top"];
  }

  return undefined;
}

_id_B664(var_0) {
  level endon("clearing_memoirs");
  wait 2;
  level notify("memoirs_active");
  var_1 = "buttonPress" + var_0;

  foreach(var_3 in self._id_313E.actions) {
    notifyoncommand(var_1, var_3);
  }

  for(;;) {
    level.player waittill(var_1);

    if(level.memoirplaying) {
      wait 0.2;
      continue;
    }

    level.memoirplaying = 1;

    if(iscinematicplaying()) {
      wait 0.5;
      continue;
    } else
      break;
  }

  self notify("btn_pressed");
  level.player setclienttriggeraudiozonepartialwithfade("shipcrib_epilogue_bridge_credits_duck_music", 1, "mix");
  _id_54D9(self);
  cinematicingame(self._id_2AD3);
  self._id_313F waittill("flicker_done");
  thread _id_B663();
  wait 0.1;
  var_5 = 0;

  while(iscinematicplaying() && var_5 != 100) {
    if(level.player useButtonPressed()) {
      var_5++;
    } else {
      var_5 = 0;
    }

    wait 0.05;
  }

  if(var_5 > 0) {
    stopcinematicingame();
  } else {
    level.memoircount--;

    if(level.memoircount == 0) {
      scripts\sp\utility::_id_834F("FIND_MP_GUN", 1);
    }
  }

  level.player clearclienttriggeraudiozone(3.0);
  var_6 = 2;
  self._id_912F._id_6ABE = 1;
  self._id_912F hud_fadeovertime(var_6, 0);

  foreach(var_8 in self._id_94BC) {
    var_8 notify("stop_pulse");
    var_8 hud_fadeovertime(var_6, 0);
    var_8 scripts\engine\utility::delaythread(var_6, ::_id_913E);
  }

  wait(var_6);
  self._id_912F _id_913E();
  _id_30D2(self);
  level.memoirplaying = 0;
}

updatebtn_text() {
  level endon("clearing_memoirs");
  self endon("btn_pressed");

  if(!level.player scripts\engine\utility::is_player_gamepad_enabled()) {
    self._id_313F.fontscale = 1;

    if(self._id_912F._id_101AD == "left") {
      self._id_313F.alignx = "left";
    } else if(self._id_912F._id_101AD == "right") {
      self._id_313F.alignx = "right";
    }
  }

  level waittill("memoirs_active");
  var_0 = 1;

  for(;;) {
    var_1 = level.player scripts\engine\utility::is_player_gamepad_enabled();

    if(var_1 != var_0) {
      var_0 = var_1;

      if(!var_1) {
        self._id_313F.fontscale = 1;

        if(self._id_912F._id_101AD == "left") {
          self._id_313F.alignx = "left";
        } else if(self._id_912F._id_101AD == "right") {
          self._id_313F.alignx = "right";
        }
      } else {
        self._id_313F.fontscale = 1.5;
        self._id_313F.alignx = "center";
      }
    }

    wait 0.05;
  }
}

_id_41C7() {
  if(!isDefined(level._id_4A39._id_B662)) {
    return;
  }
  level notify("clearing_memoirs");

  foreach(var_1 in level._id_4A39._id_B662) {
    if(isDefined(var_1._id_94BC)) {
      foreach(var_3 in var_1._id_94BC) {
        if(isDefined(var_3)) {
          var_3 thread _id_6AB4();
        }
      }
    }

    if(isDefined(var_1._id_313F)) {
      var_1._id_313F thread _id_6AB4();
    }

    if(isDefined(var_1._id_912F)) {
      var_1._id_912F thread _id_6AB4();
    }
  }

  if(iscinematicplaying()) {
    stopcinematicingame();
  }

  wait 3;
}

_id_6AB4() {
  var_0 = 1;
  hud_fadeovertime(var_0, 0);
  wait(var_0 + 0.1);

  if(isDefined(self)) {
    _id_913E();
  }
}

_id_B663() {
  var_0 = 1;
  self._id_912F scaleovertime(var_0, 100, 100);
  self._id_912F fadeovertime(var_0);
  self._id_912F.alpha = 1;

  if(isDefined(self._id_BCD0)) {
    self._id_912F moveovertime(var_0);
    self._id_912F.x = self._id_912F.x + self._id_BCD0[0];
    self._id_912F.y = self._id_912F.y + self._id_BCD0[1];
  }

  wait(var_0);
  _id_1013B();
}

_id_1013B() {
  level endon("clearing_memoirs");
  self._id_94BC = [];

  if(self._id_912F.alignx == "left") {
    var_0 = self._id_912F.x + 100 + 10;
  } else {
    var_0 = self._id_912F.x + 10;
  }

  if(self._id_912F.aligny == "top") {
    var_1 = self._id_912F.y + 10;
  } else {
    var_1 = self._id_912F.y - 100 + 10;
  }

  var_2 = 0;

  foreach(var_6, var_4 in self.info) {
    var_5 = 0;

    if(var_6 == 0) {
      var_5 = 1;
    }

    if(var_2) {
      var_1 = var_1 + var_6 * 20;
    } else {
      var_1 = var_1 + var_6 * 6;
    }

    self._id_94BC[self._id_94BC.size] = _id_49EB(var_4, var_0, var_1, var_5);
    var_2 = var_5;
    wait 0.3;
  }

  var_1 = var_1 + 16;
  self._id_94BC[self._id_94BC.size] = _id_49EB(&"CREDITS_KIA", var_0, var_1, 1, 1);
}

_id_49EB(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = newhudelem();
  var_6.x = var_1;
  var_6.y = var_2;
  var_6.horzalign = "center";
  var_6.vertalign = "middle";
  var_6.alignx = "left";
  var_6.aligny = "top";
  var_6.font = "small";
  var_6.sort = 5;

  if(isDefined(var_4) && !isDefined(var_5)) {
    var_6.color = (0.9, 0, 0);
    var_6 thread _id_DAF6();
  }

  var_7 = 1;

  if(var_3) {
    var_7 = 1.35;
  }

  var_6.fontscale = var_7;
  var_6.alpha = 0;
  var_6 settext(var_0);
  var_6 hud_fadeovertime(0.4, 1);
  return var_6;
}

_id_DAF6() {
  level endon("clearing_memoirs");
  self endon("stop_pulse");
  self endon("death");
  wait 0.5;
  var_0 = 1;

  for(;;) {
    hud_fadeovertime(var_0, 0.4);
    wait(var_0);
    hud_fadeovertime(var_0, 1);
    wait(var_0);
  }
}

_id_54D9(var_0) {
  level endon("clearing_memoirs");

  foreach(var_2 in level._id_4A39._id_B662) {
    if(!isDefined(var_2._id_912F)) {
      continue;
    }
    if(var_0 == var_2) {
      var_3 = 1;
      var_0._id_313F thread _id_6F16(0, 3);
      continue;
    }

    if(isDefined(var_2._id_912F._id_6ABE)) {
      return;
    }
    var_4 = randomintrange(2, 3);
    var_2._id_912F thread _id_6F16(0.05, var_4);
    var_2._id_313F thread _id_6F16(0.05, var_4);
  }
}

_id_6F16(var_0, var_1) {
  level endon("clearing_memoirs");
  var_1 = 3;
  var_2 = 0;
  var_3 = 0.1;
  var_4 = randomfloatrange(0, 0.3);
  var_5 = randomfloatrange(0.7, 0.9);
  self._id_6F17 = 1;

  for(var_6 = 0; var_6 < 3; var_6++) {
    var_7 = randomfloatrange(var_2, var_3);
    hud_fadeovertime(var_7, var_4);
    wait(var_7);
    var_7 = randomfloatrange(var_2, var_3);
    hud_fadeovertime(var_7, var_5);
    wait(var_7);
  }

  var_7 = randomfloatrange(var_2, var_3);

  if(isDefined(var_0)) {
    hud_fadeovertime(var_7, var_0);
  } else {
    hud_fadeovertime(var_7, 1);
  }

  self notify("flicker_done");
}

_id_30D2(var_0) {
  level endon("clearing_memoirs");

  foreach(var_2 in level._id_4A39._id_B662) {
    if(!isDefined(var_2._id_912F)) {
      continue;
    }
    if(var_0 == var_2) {
      continue;
    }
    var_2._id_912F hud_fadeovertime(2, 0.9);
    var_2._id_313F hud_fadeovertime(2, 0.9);
  }
}