/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\simplecredits.gsc
********************************/

main() {
  thread maps\_credits::initrmcredits();
  thread maps\_credits::playcredits();
  thread maps\simplecredits_code::createblackoverlay();
  thread maps\simplecredits_code::createskipcredits();
  setdvar("credits_load", "0");
  setdvar("credits_active", "1");
  level.credits_active = 1;

  if(getdvar("credits_frommenu") == "1")
    level.credits_frommenu = 1;

  common_scripts\utility::flag_init("credits_ended");
  maps\simplecredits_precache::main();
  maps\createart\simplecredits_art::main();
  maps\_load::main();
  maps\simplecredits_lighting::main();
  maps\simplecredits_aud::main();
  setsaveddvar("sv_saveOnStartMap", 0);
  level.player freezecontrols(1);
  level.player takeallweapons();
  wait 0.05;
  setsaveddvar("g_friendlyfiredist", 0);
  setsaveddvar("g_friendlynamedist", 0);
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("hud_showStance", 0);
  thread skipcreditscheck();
  thread endlevel_transition();
}

skipbuttonpressed() {
  if(level.player usinggamepad()) {
    if(level.ps4) {
      var_0 = getdvarint("loc_language", 0);

      if(var_0 == 15 || var_0 == 11 || var_0 == 10 || var_0 == 9 || var_0 == 8)
        return level.player buttonpressed("BUTTON_B");
    }

    return level.player buttonpressed("BUTTON_A");
  } else
    return level.player buttonpressed("ENTER");
}

showskipbuttonpressed() {
  if(level.player usinggamepad())
    return level.player buttonpressed("BUTTON_Y") || level.player buttonpressed("BUTTON_B") || level.player buttonpressed("BUTTON_A") || level.player buttonpressed("BUTTON_X");
  else
    return level.player buttonpressed("SPACE") || level.player buttonpressed("ESCAPE") || level.player buttonpressed("ENTER") || level.player buttonpressed("MOUSE1");
}

skipcreditscheck() {
  level.pressedtime = 0;
  level.releasedtime = 0;
  level.wanttoskip = 0;
  level.wanttoshowskip = 0;
  level endon("credits_ended");

  for (;;) {
    var_0 = skipbuttonpressed();
    var_1 = showskipbuttonpressed();

    if(var_0 || var_1) {
      if(level.wanttoskip) {
        var_2 = gettime();

        if(var_2 - level.pressedtime >= 1500)
          quitcredits();
      } else if(!level.wanttoshowskip) {
        if(level.console || level.player usinggamepad())
          level.skipcredits settext(&"PLATFORM_HOLD_TO_SKIP");
        else
          level.skipcredits settext(&"PLATFORM_HOLD_TO_SKIP_KEYBOARD");

        level.skipcredits fadeovertime(0.5);
        level.skipcredits.alpha = 1;
        level.wanttoshowskip = 1;
      }

      if(level.wanttoskip != var_0) {
        level.wanttoskip = var_0;
        level.pressedtime = gettime();
      }
    } else if(level.wanttoskip || level.wanttoshowskip) {
      level.wanttoskip = 0;
      level.wanttoshowskip = 0;
      level.releasedtime = gettime();
    } else {
      var_2 = gettime();

      if(var_2 - level.releasedtime >= 5000) {
        level.skipcredits fadeovertime(0.3);
        level.skipcredits.alpha = 0;
      }
    }

    waitframe();
  }
}

endlevel_transition() {
  common_scripts\utility::flag_wait("credits_ended");
  wait 14;
  quitcredits();
}

music() {
  maps\_utility::musicplaywrapper("simplecredits_rocking");
  wait 155;
  musicstop(6);
  wait 6.1;
  maps\_utility::musicplaywrapper("simplecredits_abandoned");
  wait 110;
  musicstop(7);
  wait 7.1;
  maps\_utility::musicplaywrapper("simplecredits_abandoned");
  wait 85;
  musicstop(6);
}

music_original_wrapper() {
  thread music_original();
}

music_original() {
  maps\_utility::musicplaywrapper("simplecredits_Original");
}

music_remastered_wrapper() {
  thread music_remastered();
}

music_remastered() {
  maps\_utility::musicplaywrapper("simplecredits_Remastered");
}

quitcredits() {
  var_0 = 5;
  var_1 = newhudelem();
  var_1.x = 0;
  var_1.y = 0;
  var_1 setshader("black", 640, 480);
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1.alpha = 0;
  var_1.sort = 6;
  var_1.foreground = 1;
  var_1 fadeovertime(var_0);
  var_1.alpha = 1;
  musicstop(var_0);
  wait(var_0);
  setdvar("credits_active", "0");

  if(isdefined(level.credits_frommenu))
    changelevel("");
  else
    maps\_endmission::credits_end();
}