/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\credits.gsc
***********************************************/

initcredits() {
  setdvarifuninitialized("scr_logo_offset", 1);
  setdvarifuninitialized("scr_credits_quick", 0);
  setdvarifuninitialized("scr_credits_scrollspeed", 0);
  setdvarifuninitialized("scr_credits_skipto", "");
  initcreditsstruct();
  precacheimages();
}

createmwlogo() {
  if(!isDefined(level.credits.mwlogo))
    level.credits.mwlogo = createcenterimage("logo_mw_2019", int(512.0), int(256.0));
}

showmwlogo() {
  createmwlogo();
  level.credits.mwlogo.foreground = 1;
  level.credits.mwlogo.sort = 5;
  wait 3;
  level.credits.mwlogo fadeovertime(1);
  level.credits.mwlogo.alpha = 0;
}

playcredits() {
  setsaveddvar("OMNONNMOTP", "1 5 5 10");
  setomnvar("ui_hide_hud", 1);
  initlocalizedcredits();

  if(!isDefined(level.hud_finale_black))
    level.hud_finale_black = createfullscreenimage("black");

  level.hud_finale_black.foreground = 1;
  showmwlogo();
  wait 2;
  level.creditsbg = createfullscreenimage("black");
  level.creditsbg.alpha = 1;
  level.creditsbg.foreground = 0;

  if(isDefined(level.hud_finale_black)) {
    level.hud_finale_black fadeovertime(10);
    level.hud_finale_black.alpha = 0.4;
  }

  level.creditscomplete = 0;
  thread inputthread();
  setsaveddvar("MMRNLMPPLT", 1);
  setsaveddvar("RKMNLRNS", 1);
  cinematicingameloop("credits_loop");
  wait 3;
  level notify("allow_fastforward");
  thread audio_credits_start_rolling();
  scripts\engine\utility::flag_init("credits_skipped");
  scripts\engine\utility::delaythread(0.2, ::skip_credits);
  playcreditlines();
  thread audio_credits_done_rolling();
  scripts\sp\utility::userskip_stop();
  level.creditscomplete = 1;

  if(!scripts\engine\utility::flag("credits_skipped")) {
    wait(getmovetime());
    var_0 = 2;
    level.hud_finale_black fadeovertime(var_0);
    level.hud_finale_black.alpha = 1;
  } else {
    setmusicstate("");
    var_0 = 5.0;
    level.hud_finale_black fadeovertime(var_0);
    level.hud_finale_black.alpha = 1;
  }

  level.credits.huds = scripts\engine\utility::array_removeundefined(level.credits.huds);

  foreach(var_2 in level.credits.huds) {
    var_2 fadeovertime(0.25);
    var_2.alpha = 0;
  }

  wait(var_0 + 0.1);
  stopcinematicingame();
  setmusicstate("");
  wait 2.5;
  level.hud_finale_black.alpha = 0;
  wait 2;
  thankyou_photo();
  wait 1;
  scripts\sp\utility::play_skippable_cinematic("cp_opening_cine_intro");
  scripts\sp\utility::play_skippable_cinematic("cp_teaser");
  level.player clearclienttriggeraudiozone(6.0);
  scripts\engine\sp\utility::nextmission();
}

audio_credits_start_rolling() {}

audio_credits_done_rolling() {
  setmusicstate("");
}

thankyou_photo() {
  var_0 = createcenterimage("credits_ending", 480, 280);
  var_0.alpha = 0;
  var_0.foreground = 1;
  var_1 = 3;
  var_0 fadeovertime(var_1);
  var_0.alpha = 1;
  wait(var_1 + 2);
  var_2 = gettime() + 10000;

  while(gettime() < var_2) {
    if(level.player attackButtonPressed()) {
      break;
    }

    if(level.player useButtonPressed()) {
      break;
    }

    if(level.player meleeButtonPressed()) {
      break;
    }

    if(level.player adsButtonPressed()) {
      break;
    }

    if(level.player jumpbuttonPressed()) {
      break;
    }

    waitframe();
  }

  var_0 fadeovertime(var_1);
  var_0.alpha = 0;
  wait(var_1);
  var_0 destroy();
}

playcreditlines() {
  level endon("credits_skipped");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;
  level.movetime = 7;
  var_7 = 4;
  level.superwide = 0;
  level.credits.skiptofound = 0;
  var_8 = [];

  for(;;) {
    var_2++;
    var_9 = tablelookupbyrow("sp/credits.csv", var_2, 0);
    var_10 = tablelookupbyrow("sp/credits.csv", var_2, 1);
    var_11 = tablelookupbyrow("sp/credits.csv", var_2, 2);
    var_12 = int(tablelookupbyrow("sp/credits.csv", var_2, 3));
    var_13 = int(tablelookupbyrow("sp/credits.csv", var_2, 4));

    if(var_9 == "") {
      var_1 = var_2 - 1;
      break;
    }

    var_10 = tolower(var_10);

    if(var_10 == "")
      var_10 = undefined;

    if(var_9 == "superwide") {
      level.superwide = 1;
      continue;
    }

    if(var_9 == "superwide_stop") {
      level.superwide = 0;
      continue;
    }

    if(var_9 == "BLANK") {
      if(var_8.size > 0)
        playnamelist(var_8);

      var_8 = [];
      var_6 = 0;
      var_3 = 0;
      var_5 = undefined;
      blankline();
      continue;
    }

    if(var_9 == "BLANKLONG") {
      if(var_8.size > 0)
        playnamelist(var_8);

      var_8 = [];
      var_6 = 0;
      var_3 = 0;
      var_5 = undefined;
      blankline(3);
      continue;
    }

    if(isDefined(var_10) && !var_6) {
      if(level.player isconsoleplayer()) {
        if(var_9 == "NVIDIA" || var_9 == "AMD" || var_9 == "INTEL") {
          var_6 = 1;
          continue;
        }
      }

      if(var_10 == "string") {
        var_8[var_8.size] = [var_9, var_10];
        continue;
      }

      if(var_8.size > 0) {
        playnamelist(var_8);
        var_8 = [];
      }

      if(getdvarint("scr_logo_offset") == 0 && var_10 == "logo") {
        var_10 = "image";
        var_12 = var_12;
        var_13 = var_13;
      }

      if(var_10 == "logo" || var_10 == "logotext") {
        var_4 = creditlogo(var_9, var_10, var_12, var_13);
        continue;
      }

      var_14 = creditline(var_9, var_10, var_11, var_12, var_13);

      if(var_10 == "dept") {
        var_3 = 0;
        var_5 = var_14;
      } else if(isDefined(var_5))
        var_3++;
    }
  }
}

skip_credits() {
  var_0 = scripts\sp\utility::userskip_wait();

  if(!var_0) {
    return;
  }
  scripts\engine\utility::flag_set("credits_skipped");
}

playnamelist(var_0, var_1) {
  var_2 = 1;
  var_3 = var_0.size;

  if(var_3 > 40)
    var_2 = 3;
  else if(var_3 > 4)
    var_2 = 2;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(var_2 == 3) {
      if(var_4 % 3 == 2)
        creditline(var_0[var_4][0], "rightname_wide", undefined, undefined, undefined);
      else if(var_4 % 3 == 1) {
        if(var_4 == var_3 - 1)
          creditline(var_0[var_4][0], "center", undefined, undefined, undefined);
        else
          thread creditline(var_0[var_4][0], "center", undefined, undefined, undefined);
      } else if(var_4 == var_3 - 1)
        creditline(var_0[var_4][0], "center", undefined, undefined, undefined);
      else
        thread creditline(var_0[var_4][0], "leftname_wide", undefined, undefined, undefined);

      continue;
    }

    if(var_2 == 2) {
      if(var_4 % 2 == 1)
        creditline(var_0[var_4][0], "rightname", undefined, undefined, undefined);
      else if(var_4 == var_3 - 1)
        creditline(var_0[var_4][0], "leftname", undefined, undefined, undefined);
      else
        thread creditline(var_0[var_4][0], "leftname", undefined, undefined, undefined);

      continue;
    }

    creditline(var_0[var_4][0], var_0[var_4][1], undefined, undefined, undefined);
  }
}

inputthread() {
  level.player takeallweapons();
  level.player allowstand(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowfire(1);
  level.player allowads(1);
  level waittill("allow_fastforward");
  var_0 = 0;
  var_1 = 1;

  while(!level.creditscomplete) {
    waitframe();

    if(gettime() > var_0) {
      if(level.player attackButtonPressed())
        var_2 = 7;
      else if(level.player playerads() > 0.1 || level.player adsButtonPressed(1))
        var_2 = 0.5;
      else
        var_2 = 1;

      if(var_2 != var_1) {
        setslowmotion(var_1, var_2, 0.5);
        var_1 = var_2;
        var_0 = gettime() + 600;
      }
    }
  }

  setslowmotion(var_1, 1, 0.5);
}

credits_showmessage(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 0 + var_2;
  var_4.horzalign = "center";
  var_4.vertalign = "middle";
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.sort = 5;
  var_4.font = "objective";
  var_4.fontscale = 1.25;
  var_4 settext(level.credits.strings[var_0]);
  var_4.alpha = 0;

  if(var_0 == "CREDITS/THANKS") {
    var_4.alignx = "center";
    var_4.horzalign = "fullscreen";
    var_4.x = 320;
  }

  var_4 hud_fadeovertime(2 * getmovetimescale(), 1);
  wait(var_1);
  var_4 hud_fadeovertime(2 * getmovetimescale(), 0);
  wait 2;
  var_4 hud_destroy();
}

getmovetime() {
  if(getdvarfloat("scr_credits_scrollspeed", 1) > 0)
    return level.movetime * getdvarfloat("scr_credits_scrollspeed");

  return level.movetime;
}

getmovetimescale() {
  return getmovetime() / 10;
}

getlinespacetime() {
  return 0.85 * (getmovetime() / 25);
}

creditlogo(var_0, var_1, var_2, var_3) {
  level endon("credits_skipped");
  var_4 = createcreditelem(var_0, var_1, var_2, var_3);
  level.credits.huds[level.credits.huds.size] = var_4;
  var_5 = 0;
  var_6 = -135;

  if(var_1 == "logotext")
    var_4.textlogo = 1;

  var_4 thread creditlogo_move(-215);
  wait 0.5;
  return var_4;
}

creditlogo_move(var_0, var_1) {
  self endon("death");
  self endon("stop_move");
  var_2 = 1 * getmovetimescale();

  if(self.type == "logotext")
    hud_fadeovertime(var_2, 0.8);
  else if(self.type == "dept")
    hud_fadeovertime(var_2, 0.8);
  else
    hud_fadeovertime(var_2, 1);

  var_3 = (self.y - var_0) / 61.4286;
  hud_moveovertime(var_3, undefined, var_0);
  wait(var_3 - var_2);
  hud_fadeovertime(var_2, 0);
  wait(var_2);
  hud_destroy();
}

creditlogo_fadeout() {
  wait(getmovetime() * 0.7);
  self fadeovertime(getmovetime() * 0.25);
  self.alpha = 0;
  wait(getmovetime() * 0.25);
  self destroy();
}

creditdept_moveside_flag_thread() {
  level waittill("dept_gone");
  self.go_away = 1;
}

creditdept_fadeoutin(var_0, var_1) {
  self fadeovertime(var_0 * 0.5);
  self.alpha = var_1;
  wait(var_0 * 0.5);
  self fadeovertime(var_0 * 0.5);
  self.alpha = 0.8;
}

creditlogo_fadein() {
  wait(getmovetime() * 0.25);
  self fadeovertime(getmovetime() * 0.5);
  self.alpha = 1;
}

creditline(var_0, var_1, var_2, var_3, var_4) {
  level endon("credits_skipped");
  var_5 = [];
  var_6 = 0;

  if(isDefined(var_1)) {
    if(var_1 == "title") {
      var_5[var_5.size] = createcreditelem(var_0, var_1);
      var_6 = 0.25 * getmovetimescale();
    } else if(var_1 == "dept") {
      wait(0.5 * getmovetimescale());
      var_5[var_5.size] = createcreditelem(var_0, var_1);
      var_6 = 0.2 * getmovetimescale();
    } else if(var_1 == "subtitle") {
      var_5[var_5.size] = createcreditelem(var_0, var_1);
      var_6 = 0.5 * getmovetimescale();
    } else if(var_0 == "logo_dolby_2019" || var_0 == "logo_havok_2019") {
      level.superwide = 1;
      var_5[var_5.size] = createcreditelem(var_0, var_1, var_3, var_4);
    } else if(var_1 == "image") {
      var_5[var_5.size] = createcreditelem(var_0, var_1, var_3, var_4);
      var_6 = 1 * getmovetimescale();
    } else if(var_1 == "small_image") {
      var_5[var_5.size] = createcreditelem(var_0, var_1);
      var_6 = 0.5 * getmovetimescale();
    } else if(var_1 == "music")
      var_5[var_5.size] = createcreditelem(var_0, var_1);
    else if(var_1 == "cast") {
      var_5[var_5.size] = createcreditelem(var_2, "castleft", undefined, undefined);
      var_5[var_5.size] = createcreditelem(var_0, "castright", undefined, undefined);
    } else
      var_5[var_5.size] = createcreditelem(var_0, var_1, undefined, undefined);
  } else {}

  var_7 = 0;

  if(var_1 == "leftname_thread" || var_1 == "rightname_thread" || var_0 == "logo_havok_2019")
    var_7 = 1;

  scripts\engine\utility::array_thread(var_5, ::credit_move);

  if(!var_7) {
    var_8 = getlinespacetime() + var_6;
    var_8 = max(var_8, 0);
    wait(var_8);
  }

  return var_5[var_5.size - 1];
}

credit_move(var_0) {
  level endon("credits_skipped");
  self endon("stop_move");
  var_1 = 1 * getmovetimescale();

  if(self.type == "logotext")
    hud_fadeovertime(var_1, 0.8);
  else if(self.type == "dept")
    hud_fadeovertime(var_1, 0.8);
  else
    hud_fadeovertime(var_1, 1);

  var_2 = getmovetime();
  hud_moveovertime(var_2, undefined, -215);
  var_3 = 0;

  if(istrue(var_0))
    var_3 = 1.2;

  wait(var_2 - var_1 - var_3);
  hud_fadeovertime(var_1, 0);
  wait(var_1);
  hud_destroy();
}

hud_fadeovertime(var_0, var_1) {
  self fadeovertime(var_0);
  self.alpha = var_1;
}

hud_moveovertime(var_0, var_1, var_2) {
  level endon("credits_skipped");
  self.startmovetime = gettime();
  self.startmovey = self.y;
  self moveovertime(var_0);

  if(isDefined(var_1))
    self.x = var_1;

  if(isDefined(var_2))
    self.y = var_2;
}

hud_destroy(var_0, var_1) {
  self destroy();
}

blankline(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  wait(getlinespacetime() + var_0);
}

createcreditelem(var_0, var_1, var_2, var_3, var_4) {
  var_5 = newhudelem();
  level.credits.huds[level.credits.huds.size] = var_5;
  var_6 = 0;
  var_7 = 1.35;
  var_8 = 0;
  var_9 = (1, 1, 1);
  var_10 = "small";
  var_11 = 1.1;
  var_12 = "center";
  var_13 = "middle";
  var_14 = "center";
  var_15 = "middle";
  var_16 = 20;
  var_17 = 215;
  var_18 = undefined;

  if(var_1 == "rightname" || var_1 == "rightname_thread" || var_0 == "logo_dolby_2019") {
    var_6 = 100;

    if(level.superwide)
      var_6 = var_6 + 50;

    if(var_0 == "logo_dolby_2019") {
      var_18 = var_0;
      var_13 = "bottom";
    }
  } else if(var_1 == "leftname" || var_1 == "leftname_thread" || var_0 == "logo_havok_2019") {
    var_6 = -100;

    if(level.superwide)
      var_6 = var_6 - 50;

    if(var_0 == "logo_havok_2019") {
      var_18 = var_0;
      var_13 = "bottom";
    }
  } else if(var_1 == "rightname_wide")
    var_6 = 200;
  else if(var_1 == "leftname_wide")
    var_6 = -200;
  else if(var_1 == "castleft") {
    var_6 = -5;
    var_12 = "right";
  } else if(var_1 == "castright") {
    var_6 = 5;
    var_12 = "left";
  }

  if(var_1 == "dept") {
    var_6 = 0;
    var_7 = 1.75;
    var_10 = "BIGFIXED";
    var_12 = "center";
    var_11 = 0.8;
  } else if(var_1 == "image")
    var_18 = var_0;
  else if(var_1 == "logo") {
    var_18 = var_0;
    var_6 = 0;
    var_12 = "center";
    var_13 = "middle";
    var_16 = 21;
  } else if(var_1 == "logotext") {
    var_6 = 0;
    var_12 = "center";
    var_13 = "bottom";
    var_10 = "BIGFIXED";
    var_11 = 1.3;
  } else if(var_1 == "small_image") {
    var_18 = var_0;
    var_2 = var_2 * 0.5;
    var_3 = var_3 * 0.5;
  } else if(var_1 == "center")
    var_6 = 0;

  var_5.x = var_6;
  var_5.y = var_17;
  var_5.start_y = var_5.y;
  var_5.alignx = var_12;
  var_5.aligny = var_13;
  var_5.horzalign = var_14;
  var_5.vertalign = var_15;
  var_5.alpha = 0;
  var_5.fontscale = var_11;
  var_5.color = var_9;
  var_5.font = var_10;
  var_5.glowcolor = (0.3, 0.6, 0.3);
  var_5.glowalpha = var_8;
  var_5.foreground = 1;
  var_5.sort = var_16;
  var_5.starttime = gettime();
  var_5.type = var_1;

  if(!isDefined(var_18))
    var_5 settext(try_getlocalizedtext(var_0));
  else
    var_5 setshader(var_18, int(var_2), int(var_3));

  return var_5;
}

newhudimage(var_0, var_1, var_2) {
  var_3 = newhudelem();
  var_3.x = 0;
  var_3.y = 0;
  var_3.sort = 1;
  var_3.alpha = 1;
  var_3.foreground = 0;
  var_3 setshader(var_0, var_1, var_2);
  return var_3;
}

createfullscreenimage(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 640;

  if(!isDefined(var_2))
    var_2 = 480;

  var_3 = newhudimage(var_0, var_1, var_2);
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  return var_3;
}

createcenterimage(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 640;

  if(!isDefined(var_2))
    var_2 = 480;

  var_3 = newhudimage(var_0, var_1, var_2);
  var_3.alignx = "center";
  var_3.aligny = "middle";
  var_3.horzalign = "center";
  var_3.vertalign = "middle";
  var_3.sort = 2;
  return var_3;
}

creditlinearray(var_0) {
  var_0 = scripts\engine\utility::alphabetize(var_0);

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    creditline(var_0[var_1], undefined, "center");

  wait(3 * getmovetimescale());
}

initcreditsstruct() {
  if(!isDefined(level.credits))
    level.credits = spawnStruct();

  level.credits.huds = [];
}

precacheimages() {
  precacheshader("logo_iw_2019");
  precacheshader("logo_hms_2019");
  precacheshader("logo_atvi_2019");
  precacheshader("logo_beenox_2019");
  precacheshader("logo_demonware_2019");
  precacheshader("logo_raven_2019");
  precacheshader("logo_dolby_2019");
  precacheshader("logo_mw_2019");
  precacheshader("logo_shg_2019");
  precacheshader("logo_havok_2019");
  precacheshader("credits_ending");
  precachemodel("tag_origin_only_collision");
}

initlocalizedcredits() {
  initcreditsstruct();
  level.credits.strings["CREDITS/ATVI_COPYRIGHT1"] = &"CREDITS/ATVI_COPYRIGHT1";
  level.credits.strings["CREDITS/ATVI_COPYRIGHT2"] = &"CREDITS/ATVI_COPYRIGHT2";
  level.credits.strings["CREDITS/ATVI_COPYRIGHT3"] = &"CREDITS/ATVI_COPYRIGHT3";
  level.credits.strings["CREDITS/ATVI_COPYRIGHT4"] = &"CREDITS/ATVI_COPYRIGHT4";
  level.credits.strings["CREDITS/DEPT_ADDSUPPORT"] = &"CREDITS/DEPT_ADDSUPPORT";
  level.credits.strings["CREDITS/DEPT_ADDVOICE"] = &"CREDITS/DEPT_ADDVOICE";
  level.credits.strings["CREDITS/DEPT_ADMIN"] = &"CREDITS/DEPT_ADMIN";
  level.credits.strings["CREDITS/DEPT_ANIMATION"] = &"CREDITS/DEPT_ANIMATION";
  level.credits.strings["CREDITS/DEPT_ART"] = &"CREDITS/DEPT_ART";
  level.credits.strings["CREDITS/DEPT_AUDIO"] = &"CREDITS/DEPT_AUDIO";
  level.credits.strings["CREDITS/DEPT_BIZDEV"] = &"CREDITS/DEPT_BIZDEV";
  level.credits.strings["CREDITS/DEPT_CAST"] = &"CREDITS/DEPT_CAST";
  level.credits.strings["CREDITS/DEPT_CASTING"] = &"CREDITS/DEPT_CASTING";
  level.credits.strings["CREDITS/DEPT_CODBUSINESS"] = &"CREDITS/DEPT_CODBUSINESS";
  level.credits.strings["CREDITS/DEPT_CODPRODMAN"] = &"CREDITS/DEPT_CODPRODMAN";
  level.credits.strings["CREDITS/DEPT_COMMUNITY"] = &"CREDITS/DEPT_COMMUNITY";
  level.credits.strings["CREDITS/DEPT_CONMARKETING"] = &"CREDITS/DEPT_CONMARKETING";
  level.credits.strings["CREDITS/DEPT_CONPRODUCTS"] = &"CREDITS/DEPT_CONPRODUCTS";
  level.credits.strings["CREDITS/DEPT_CONTECH"] = &"CREDITS/DEPT_CONTECH";
  level.credits.strings["CREDITS/DEPT_CONSULTANTS"] = &"CREDITS/DEPT_CONSULTANTS";
  level.credits.strings["CREDITS/DEPT_CREATIVE"] = &"CREDITS/DEPT_CREATIVE";
  level.credits.strings["CREDITS/DEPT_CREWSERVICES"] = &"CREDITS/DEPT_CREWSERVICES";
  level.credits.strings["CREDITS/DEPT_CRMMARKETING"] = &"CREDITS/DEPT_CRMMARKETING";
  level.credits.strings["CREDITS/DEPT_CSTUDIO"] = &"CREDITS/DEPT_CSTUDIO";
  level.credits.strings["CREDITS/DEPT_CT"] = &"CREDITS/DEPT_CT";
  level.credits.strings["CREDITS/DEPT_DESIGN"] = &"CREDITS/DEPT_DESIGN";
  level.credits.strings["CREDITS/DEPT_DEVSUPPORT"] = &"CREDITS/DEPT_DEVSUPPORT";
  level.credits.strings["CREDITS/DEPT_DIGITALMARKETING"] = &"CREDITS/DEPT_DIGITALMARKETING";
  level.credits.strings["CREDITS/DEPT_ENGINEERING"] = &"CREDITS/DEPT_ENGINEERING";
  level.credits.strings["CREDITS/DEPT_EXEC"] = &"CREDITS/DEPT_EXEC";
  level.credits.strings["CREDITS/DEPT_FACIALSTUDIOS"] = &"CREDITS/DEPT_FACIALSTUDIOS";
  level.credits.strings["CREDITS/DEPT_FINANCEOP"] = &"CREDITS/DEPT_FINANCEOP";
  level.credits.strings["CREDITS/DEPT_GANALYTICS"] = &"CREDITS/DEPT_GANALYTICS";
  level.credits.strings["CREDITS/DEPT_GEMARKETING"] = &"CREDITS/DEPT_GEMARKETING";
  level.credits.strings["CREDITS/DEPT_GIT"] = &"CREDITS/DEPT_GIT";
  level.credits.strings["CREDITS/DEPT_GLOBALDIGITAL"] = &"CREDITS/DEPT_GLOBALDIGITAL";
  level.credits.strings["CREDITS/DEPT_GPLAYERINSIGHTS"] = &"CREDITS/DEPT_GPLAYERINSIGHTS";
  level.credits.strings["CREDITS/DEPT_GSUPPLY"] = &"CREDITS/DEPT_GSUPPLY";
  level.credits.strings["CREDITS/DEPT_HR"] = &"CREDITS/DEPT_HR";
  level.credits.strings["CREDITS/DEPT_INTCOMMS"] = &"CREDITS/DEPT_INTCOMMS";
  level.credits.strings["CREDITS/DEPT_INTEGRATION"] = &"CREDITS/DEPT_INTEGRATION";
  level.credits.strings["CREDITS/DEPT_INTPR"] = &"CREDITS/DEPT_INTPR";
  level.credits.strings["CREDITS/DEPT_IT"] = &"CREDITS/DEPT_IT";
  level.credits.strings["CREDITS/DEPT_LEGAL"] = &"CREDITS/DEPT_LEGAL";
  level.credits.strings["CREDITS/DEPT_MEDIAMARKETING"] = &"CREDITS/DEPT_MEDIAMARKETING";
  level.credits.strings["CREDITS/DEPT_MOCAP"] = &"CREDITS/DEPT_MOCAP";
  level.credits.strings["CREDITS/DEPT_MOTIONGRAPHICS"] = &"CREDITS/DEPT_MOTIONGRAPHICS";
  level.credits.strings["CREDITS/DEPT_MUSIC"] = &"CREDITS/DEPT_MUSIC";
  level.credits.strings["CREDITS/DEPT_NARRATIVE"] = &"CREDITS/DEPT_NARRATIVE";
  level.credits.strings["CREDITS/DEPT_PLATSTRAT"] = &"CREDITS/DEPT_PLATSTRAT";
  level.credits.strings["CREDITS/DEPT_PLAYERSUPPORT"] = &"CREDITS/DEPT_PLAYERSUPPORT";
  level.credits.strings["CREDITS/DEPT_PMG"] = &"CREDITS/DEPT_PMG";
  level.credits.strings["CREDITS/DEPT_PRODBABIES"] = &"CREDITS/DEPT_PRODBABIES";
  level.credits.strings["CREDITS/DEPT_PRODLIVESERVICES"] = &"CREDITS/DEPT_PRODLIVESERVICES";
  level.credits.strings["CREDITS/DEPT_PRODSERVICES"] = &"CREDITS/DEPT_PRODSERVICES";
  level.credits.strings["CREDITS/DEPT_PRODSERVICES_LOCS"] = &"CREDITS/DEPT_PRODSERVICES_LOCS";
  level.credits.strings["CREDITS/DEPT_PRODUCTION"] = &"CREDITS/DEPT_PRODUCTION";
  level.credits.strings["CREDITS/DEPT_QA"] = &"CREDITS/DEPT_QA";
  level.credits.strings["CREDITS/DEPT_RECORDINGSTUDIO"] = &"CREDITS/DEPT_RECORDINGSTUDIO";
  level.credits.strings["CREDITS/DEPT_SPECIALTHANKS_USCUSTOMS"] = &"CREDITS/DEPT_SPECIALTHANKS_USCUSTOMS";
  level.credits.strings["CREDITS/DEPT_STUDIOHEADS"] = &"CREDITS/DEPT_STUDIOHEADS";
  level.credits.strings["CREDITS/DEPT_STUDIOOP"] = &"CREDITS/DEPT_STUDIOOP";
  level.credits.strings["CREDITS/DEPT_TALENTACQ"] = &"CREDITS/DEPT_TALENTACQ";
  level.credits.strings["CREDITS/DEPT_TRANSLATION"] = &"CREDITS/DEPT_TRANSLATION";
  level.credits.strings["CREDITS/DEPT_UI"] = &"CREDITS/DEPT_UI";
  level.credits.strings["CREDITS/DOLBY1"] = &"CREDITS/DOLBY1";
  level.credits.strings["CREDITS/DOLBY2"] = &"CREDITS/DOLBY2";
  level.credits.strings["CREDITS/EXTERNAL_VENDORS"] = &"CREDITS/EXTERNAL_VENDORS";
  level.credits.strings["CREDITS/HAVOK1"] = &"CREDITS/HAVOK1";
  level.credits.strings["CREDITS/HAVOK2"] = &"CREDITS/HAVOK2";
  level.credits.strings["CREDITS/HAVOK3"] = &"CREDITS/HAVOK3";
  level.credits.strings["CREDITS/HAVOK4"] = &"CREDITS/HAVOK4";
  level.credits.strings["CREDITS/IW_SPECIALTHANKS_AIRWING"] = &"CREDITS/IW_SPECIALTHANKS_AIRWING";
  level.credits.strings["CREDITS/IW_SPECIALTHANKS_USMC1"] = &"CREDITS/IW_SPECIALTHANKS_USMC1";
  level.credits.strings["CREDITS/IW_SPECIALTHANKS_USMC2"] = &"CREDITS/IW_SPECIALTHANKS_USMC2";
  level.credits.strings["CREDITS/RAD_GAME1"] = &"CREDITS/RAD_GAME1";
  level.credits.strings["CREDITS/RAD_GAME2"] = &"CREDITS/RAD_GAME2";
  level.credits.strings["CREDITS/RAD_GAME3"] = &"CREDITS/RAD_GAME3";
  level.credits.strings["CREDITS/RAD_GAME4"] = &"CREDITS/RAD_GAME4";
  level.credits.strings["CREDITS/SPECIALTHANKS"] = &"CREDITS/SPECIALTHANKS";
  level.credits.strings["CREDITS/SPECIALTHANKS_ENGINEERING"] = &"CREDITS/SPECIALTHANKS_ENGINEERING";
  level.credits.strings["CREDITS/UMBRA1"] = &"CREDITS/UMBRA1";
  level.credits.strings["CREDITS/UMBRA2"] = &"CREDITS/UMBRA2";
  level.credits.strings["CREDITS/WRITTENBY"] = &"CREDITS/WRITTENBY";
  level.credits.strings["CREDITS/SHANGHAI"] = &"CREDITS/SHANGHAI";
  level.credits.strings["CREDITS/OUTSOURCEPARTNERS"] = &"CREDITS/OUTSOURCEPARTNERS";
  level.credits.strings["CREDITS/EXTERNALPARTNERS"] = &"CREDITS/EXTERNALPARTNERS";
  level.credits.strings["CREDITS/DEPT_EXTERNALSUPPORT"] = &"CREDITS/DEPT_EXTERNALSUPPORT";
  level.credits.strings["CREDITS/DEPT_VOCALPERFORMED"] = &"CREDITS/DEPT_VOCALPERFORMED";
}

try_getlocalizedtext(var_0) {
  var_1 = getsubstr(var_0, 0, 8);

  if(var_1 != "CREDITS/")
    return var_0;

  if(!isDefined(level.credits.strings[var_0]))
    return "(not str ref) " + var_0;

  return level.credits.strings[var_0];
}