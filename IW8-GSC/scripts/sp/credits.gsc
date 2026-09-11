/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\credits.gsc
***********************************************/

function initcredits() {
  setdvarifuninitialized("scr_logo_offset", 1);
  setdvarifuninitialized("scr_credits_quick", 0);
  setdvarifuninitialized("scr_credits_scrollspeed", 0);
  setdvarifuninitialized("scr_credits_skipto", "");
  initcreditsstruct();
  precacheimages();
}

function createmwlogo() {
  if(!isDefined(level.credits.mwlogo)) {
    level.credits.mwlogo = createcenterimage("logo_mw_2019", int(512), int(256));
    return;
  }
}

function showmwlogo() {
  createmwlogo();
  level.credits.mwlogo.foreground = 1;
  level.credits.mwlogo.sort = 5;
  wait 3;
  level.credits.mwlogo fadeovertime(1);
  level.credits.mwlogo.alpha = 0;
}

function playcredits() {
  setsaveddvar("OMNONNMOTP", "1 5 5 10");
  setomnvar("ui_hide_hud", 1);
  initlocalizedcredits();

  if(!isDefined(level.hud_finale_black)) {
    level.hud_finale_black = createfullscreenimage("black");
  }

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
  scripts\engine\utility::delaythread(0.2, &skip_credits);
  playcreditlines();
  thread audio_credits_done_rolling();
  scripts\sp\utility::userskip_stop();
  level.creditscomplete = 1;

  if(!scripts\engine\utility::flag("credits_skipped")) {
    wait getmovetime();
    var0 = 2;
    level.hud_finale_black fadeovertime(var0);
    level.hud_finale_black.alpha = 1;
  } else {
    setmusicstate("");
    var0 = 5;
    level.hud_finale_black fadeovertime(var0);
    level.hud_finale_black.alpha = 1;
  }

  level.credits.huds = scripts\engine\utility::array_removeundefined(level.credits.huds);

  foreach(var2 in level.credits.huds) {
    var2 fadeovertime(0.25);
    var2.alpha = 0;
  }

  wait var0 + 0.1;
  stopcinematicingame();
  setmusicstate("");
  wait 2.5;
  level.hud_finale_black.alpha = 0;
  wait 2;
  thankyou_photo();
  wait 1;
  scripts\sp\utility::play_skippable_cinematic("cp_opening_cine_intro");
  scripts\sp\utility::play_skippable_cinematic("cp_teaser");
  level.player clearclienttriggeraudiozone(6);
  scripts\engine\sp\utility::nextmission();
}

function audio_credits_start_rolling() {}

function audio_credits_done_rolling() {
  setmusicstate("");
}

function thankyou_photo() {
  var0 = createcenterimage("credits_ending", 480, 280);
  var0.alpha = 0;
  var0.foreground = 1;
  var1 = 3;
  var0 fadeovertime(var1);
  var0.alpha = 1;
  wait var1 + 2;
  var2 = gettime() + 10000;

  while(gettime() < var2) {
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

  var0 fadeovertime(var1);
  var0.alpha = 0;
  wait var1;
  var0 destroy();
}

function playcreditlines() {
  level endon("credits_skipped");
  var0 = 0;
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = undefined;
  var5 = undefined;
  var6 = 0;
  level.movetime = 7;
  var7 = 4;
  level.superwide = 0;
  level.credits.skiptofound = 0;
  var8 = [];

  for(;;) {
    var2++;
    var9 = tablelookupbyrow("sp/credits.csv", var2, 0);
    var10 = tablelookupbyrow("sp/credits.csv", var2, 1);
    var11 = tablelookupbyrow("sp/credits.csv", var2, 2);
    var12 = int(tablelookupbyrow("sp/credits.csv", var2, 3));
    var13 = int(tablelookupbyrow("sp/credits.csv", var2, 4));

    if(var9 == "") {
      var1 = var2 - 1;
      break;
    }

    var10 = tolower(var10);

    if(var10 == "") {
      var10 = undefined;
    }

    if(var9 == "superwide") {
      level.superwide = 1;
      continue;
    }

    if(var9 == "superwide_stop") {
      level.superwide = 0;
      continue;
    }

    if(var9 == "BLANK") {
      if(var8.size > 0) {
        playnamelist(var8);
      }

      var8 = [];
      var6 = 0;
      var3 = 0;
      var5 = undefined;
      blankline();
      continue;
    }

    if(var9 == "BLANKLONG") {
      if(var8.size > 0) {
        playnamelist(var8);
      }

      var8 = [];
      var6 = 0;
      var3 = 0;
      var5 = undefined;
      blankline(3);
      continue;
    }

    if(isDefined(var10) && !var6) {
      if(level.player isconsoleplayer()) {
        if(var9 == "NVIDIA" || var9 == "AMD" || var9 == "INTEL") {
          var6 = 1;
          continue;
        }
      }

      if(var10 == "string") {
        var8 = [var9, var10];
        continue;
      }

      if(var8.size > 0) {
        playnamelist(var8);
        var8 = [];
      }

      if(getdvarint("scr_logo_offset") == 0 && var10 == "logo") {
        var10 = "image";
        var12 = var12;
        var13 = var13;
      }

      if(var10 == "logo" || var10 == "logotext") {
        var4 = creditlogo(var9, var10, var12, var13);
        continue;
      }

      var14 = creditline(var9, var10, var11, var12, var13);

      if(var10 == "dept") {
        var3 = 0;
        var5 = var14;
      } else if(isDefined(var5)) {
        var3++;
      }
    }
  }
}

function skip_credits() {
  var0 = scripts\sp\utility::userskip_wait();

  if(!var0) {
    return;
  }

  scripts\engine\utility::flag_set("credits_skipped");
}

function playnamelist(var0, var1) {
  var2 = 1;
  var3 = var0.size;

  if(var3 > 40) {
    var2 = 3;
  } else if(var3 > 4) {
    var2 = 2;
  }

  for(var4 = 0; var4 < var3; var4++) {
    if(var2 == 3) {
      if(var4 % 3 == 2) {
        creditline(var0[var4][0], "rightname_wide", undefined, undefined, undefined);
      } else if(var4 % 3 == 1) {
        if(var4 == var3 - 1) {
          creditline(var0[var4][0], "center", undefined, undefined, undefined);
        } else {
          thread creditline(var0[var4][0], "center", undefined, undefined, undefined);
        }
      } else if(var4 == var3 - 1) {
        creditline(var0[var4][0], "center", undefined, undefined, undefined);
      } else {
        thread creditline(var0[var4][0], "leftname_wide", undefined, undefined, undefined);
      }

      continue;
    }

    if(var2 == 2) {
      if(var4 % 2 == 1) {
        creditline(var0[var4][0], "rightname", undefined, undefined, undefined);
      } else if(var4 == var3 - 1) {
        creditline(var0[var4][0], "leftname", undefined, undefined, undefined);
      } else {
        thread creditline(var0[var4][0], "leftname", undefined, undefined, undefined);
      }

      continue;
    }

    creditline(var0[var4][0], var0[var4][1], undefined, undefined, undefined);
  }
}

function inputthread() {
  level.player takeallweapons();
  level.player allowstand(1);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowfire(1);
  level.player allowads(1);
  level waittill("allow_fastforward");
  var0 = 0;
  var1 = 1;

  while(!level.creditscomplete) {
    waitframe();

    if(gettime() > var0) {
      if(level.player attackButtonPressed()) {
        var2 = 7;
      } else if(level.player playerads() > 0.1 || level.player adsButtonPressed(1)) {
        var2 = 0.5;
      } else {
        var2 = 1;
      }

      if(var2 != var2) {
        setslowmotion(var2, var2, 0.5);
        var2 = var2;
        var2 = gettime() + 600;
      }
    }
  }

  setslowmotion(var2, 1, 0.5);
}

function credits_showmessage(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  var4 = newhudelem();
  var4.x = 0;
  var4.y = 0 + var2;
  var4.horzalign = "center";
  var4.vertalign = "middle";
  var4.alignx = "center";
  var4.aligny = "middle";
  var4.sort = 5;
  var4.font = "objective";
  var4.fontscale = 1.25;
  var4 settext(level.credits.strings[var0]);
  var4.alpha = 0;

  if(var0 == "CREDITS/THANKS") {
    var4.alignx = "center";
    var4.horzalign = "fullscreen";
    var4.x = 320;
  }

  hud_fadeovertime(var4, 2 * getmovetimescale(), 1);
  wait var1;
  hud_fadeovertime(var4, 2 * getmovetimescale(), 0);
  wait 2;
  hud_destroy(var4);
}

function getmovetime() {
  if(getdvarfloat("scr_credits_scrollspeed", 1) > 0) {
    return (level.movetime * getdvarfloat("scr_credits_scrollspeed"));
  }

  return level.movetime;
}

function getmovetimescale() {
  return getmovetime() / 10;
}

function getlinespacetime() {
  return 0.85 * getmovetime() / 25;
}

function creditlogo(var0, var1, var2, var3) {
  level endon("credits_skipped");
  var4 = createcreditelem(var0, var1, var2, var3);
  level.credits.huds[level.credits.huds.size] = var4;
  var5 = 0;
  var6 = -135;

  if(var1 == "logotext") {
    var4.textlogo = 1;
  }

  thread creditlogo_move(var4);
  wait 0.5;
  return var4;
}

function creditlogo_move(var0, var1) {
  self endon("death");
  self endon("stop_move");
  var2 = 1 * getmovetimescale();

  if(self.type == "logotext") {
    hud_fadeovertime(var2, 0.8);
  } else if(self.type == "dept") {
    hud_fadeovertime(var2, 0.8);
  } else {
    hud_fadeovertime(var2, 1);
  }

  var3 = (self.y - var0) / 61.4286;
  hud_moveovertime(var3, undefined, var0);
  wait var3 - var2;
  hud_fadeovertime(var2, 0);
  wait var2;
  hud_destroy();
}

function creditlogo_fadeout() {
  wait getmovetime() * 0.7;
  self fadeovertime(getmovetime() * 0.25);
  self.alpha = 0;
  wait getmovetime() * 0.25;
  self destroy();
}

function creditdept_moveside_flag_thread() {
  level waittill("dept_gone");
  self.go_away = 1;
}

function creditdept_fadeoutin(var0, var1) {
  self fadeovertime(var0 * 0.5);
  self.alpha = var1;
  wait var0 * 0.5;
  self fadeovertime(var0 * 0.5);
  self.alpha = 0.8;
}

function creditlogo_fadein() {
  wait getmovetime() * 0.25;
  self fadeovertime(getmovetime() * 0.5);
  self.alpha = 1;
}

function creditline(var0, var1, var2, var3, var4) {
  level endon("credits_skipped");
  var5 = [];
  var6 = 0;

  if(isDefined(var1)) {
    if(var1 == "title") {
      var5 = createcreditelem(var0, var1);
      var6 = 0.25 * getmovetimescale();
    } else if(var1 == "dept") {
      wait 0.5 * getmovetimescale();
      var5 = createcreditelem(var0, var1);
      var6 = 0.2 * getmovetimescale();
    } else if(var1 == "subtitle") {
      var5 = createcreditelem(var0, var1);
      var6 = 0.5 * getmovetimescale();
    } else if(var0 == "logo_dolby_2019" || var0 == "logo_havok_2019") {
      level.superwide = 1;
      var5 = createcreditelem(var0, var1, var3, var4);
    } else if(var1 == "image") {
      var5 = createcreditelem(var0, var1, var3, var4);
      var6 = 1 * getmovetimescale();
    } else if(var1 == "small_image") {
      var5 = createcreditelem(var0, var1);
      var6 = 0.5 * getmovetimescale();
    } else if(var1 == "music") {
      var5 = createcreditelem(var0, var1);
    } else if(var1 == "cast") {
      var5 = createcreditelem(var2, "castleft", undefined, undefined);
      var5 = createcreditelem(var0, "castright", undefined, undefined);
    } else {
      var5 = createcreditelem(var0, var1, undefined, undefined);
    }
  }

  var7 = 0;

  if(var1 == "leftname_thread" || var1 == "rightname_thread" || var0 == "logo_havok_2019") {
    var7 = 1;
  }

  scripts\engine\utility::array_thread(var5, &credit_move);

  if(!var7) {
    var8 = getlinespacetime() + var6;
    var8 = max(var8, 0);
    wait var8;
  }

  return var5[var5.size - 1];
}

function credit_move(var0) {
  level endon("credits_skipped");
  self endon("stop_move");
  var1 = 1 * getmovetimescale();

  if(self.type == "logotext") {
    hud_fadeovertime(var1, 0.8);
  } else if(self.type == "dept") {
    hud_fadeovertime(var1, 0.8);
  } else {
    hud_fadeovertime(var1, 1);
  }

  var2 = getmovetime();
  hud_moveovertime(var2, undefined, -215);
  var3 = 0;

  if(istrue(var0)) {
    var3 = 1.2;
  }

  wait var2 - var1 - var3;
  hud_fadeovertime(var1, 0);
  wait var1;
  hud_destroy();
}

function hud_fadeovertime(var0, var1) {
  self fadeovertime(var0);
  self.alpha = var1;
}

function hud_moveovertime(var0, var1, var2) {
  level endon("credits_skipped");
  self.startmovetime = gettime();
  self.startmovey = self.y;
  self moveovertime(var0);

  if(isDefined(var1)) {
    self.x = var1;
  }

  if(isDefined(var2)) {
    self.y = var2;
    return;
  }
}

function hud_destroy(var0, var1) {
  self destroy();
}

function blankline(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  wait getlinespacetime() + var0;
}

function createcreditelem(var0, var1, var2, var3, var4) {
  var5 = newhudelem();
  level.credits.huds[level.credits.huds.size] = var5;
  var6 = 0;
  var7 = 1.35;
  var8 = 0;
  var9 = (1, 1, 1);
  var10 = "small";
  var11 = 1.1;
  var12 = "center";
  var13 = "middle";
  var14 = "center";
  var15 = "middle";
  var16 = 20;
  var17 = 215;
  var18 = undefined;

  if(var1 == "rightname" || var1 == "rightname_thread" || var0 == "logo_dolby_2019") {
    var6 = 100;

    if(level.superwide) {
      var6 += 50;
    }

    if(var0 == "logo_dolby_2019") {
      var18 = var0;
      var13 = "bottom";
    }
  } else if(var1 == "leftname" || var1 == "leftname_thread" || var0 == "logo_havok_2019") {
    var6 = -100;

    if(level.superwide) {
      var6 -= 50;
    }

    if(var0 == "logo_havok_2019") {
      var18 = var0;
      var13 = "bottom";
    }
  } else if(var1 == "rightname_wide") {
    var6 = 200;
  } else if(var1 == "leftname_wide") {
    var6 = -200;
  } else if(var1 == "castleft") {
    var6 = -5;
    var12 = "right";
  } else if(var1 == "castright") {
    var6 = 5;
    var12 = "left";
  }

  if(var1 == "dept") {
    var6 = 0;
    var7 = 1.75;
    var10 = "BIGFIXED";
    var12 = "center";
    var11 = 0.8;
  } else if(var1 == "image") {
    var18 = var0;
  } else if(var1 == "logo") {
    var18 = var0;
    var6 = 0;
    var12 = "center";
    var13 = "middle";
    var16 = 21;
  } else if(var1 == "logotext") {
    var6 = 0;
    var12 = "center";
    var13 = "bottom";
    var10 = "BIGFIXED";
    var11 = 1.3;
  } else if(var1 == "small_image") {
    var18 = var0;
    var2 *= 0.5;
    var3 *= 0.5;
  } else if(var1 == "center") {
    var6 = 0;
  }

  var5.x = var6;
  var5.y = var17;
  var5.start_y = var5.y;
  var5.alignx = var12;
  var5.aligny = var13;
  var5.horzalign = var14;
  var5.vertalign = var15;
  var5.alpha = 0;
  var5.fontscale = var11;
  var5.color = var9;
  var5.font = var10;
  var5.glowcolor = (0.3, 0.6, 0.3);
  var5.glowalpha = var8;
  var5.foreground = 1;
  var5.sort = var16;
  var5.starttime = gettime();
  var5.type = var1;

  if(!isDefined(var18)) {
    var5 settext(try_getlocalizedtext(var0));
  } else {
    var5 setshader(var18, int(var2), int(var3));
  }

  return var5;
}

function newhudimage(var0, var1, var2) {
  var3 = newhudelem();
  var3.x = 0;
  var3.y = 0;
  var3.sort = 1;
  var3.alpha = 1;
  var3.foreground = 0;
  var3 setshader(var0, var1, var2);
  return var3;
}

function createfullscreenimage(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = 640;
  }

  if(!isDefined(var2)) {
    var2 = 480;
  }

  var3 = newhudimage(var0, var1, var2);
  var3.alignx = "left";
  var3.aligny = "top";
  var3.horzalign = "fullscreen";
  var3.vertalign = "fullscreen";
  return var3;
}

function createcenterimage(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = 640;
  }

  if(!isDefined(var2)) {
    var2 = 480;
  }

  var3 = newhudimage(var0, var1, var2);
  var3.alignx = "center";
  var3.aligny = "middle";
  var3.horzalign = "center";
  var3.vertalign = "middle";
  var3.sort = 2;
  return var3;
}

function creditlinearray(var0) {
  var0 = scripts\engine\utility::alphabetize(var0);

  for(var1 = 0; var1 < var0.size; var1++) {
    creditline(var0[var1], undefined, "center");
  }

  wait 3 * getmovetimescale();
}

function initcreditsstruct() {
  if(!isDefined(level.credits)) {
    level.credits = spawnStruct();
  }

  level.credits.huds = [];
}

function precacheimages() {
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

function initlocalizedcredits() {
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

function try_getlocalizedtext(var0) {
  var1 = getsubstr(var0, 0, 8);

  if(var1 != "CREDITS/") {
    return var0;
  }

  if(!isDefined(level.credits.strings[var0])) {
    return ("(not str ref) " + var0);
  }

  return level.credits.strings[var0];
}