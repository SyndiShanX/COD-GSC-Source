/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1348.gsc
**************************************/

main() {
  setsaveddvar("hud_drawhud", 0);
  level.script = tolower(getDvar("mapname"));

  if(!isDefined(level.tmpmsg)) {
    level.tmpmsg = [];
  }
  var_0 = getEntArray("player", "classname")[0];
  setsaveddvar("g_speed", 0);
  var_0 setviewmodel("viewmodel_hands_cloth");
  precacheshader("black");
  var_1 = 0;

  for(var_2 = 0; var_2 < level.slide.size; var_2++) {
    if(isDefined(level.slide[var_2]["movie"])) {
      var_1 = 1;
      break;
    }
  }

  if(var_1) {
    wait 0.05;
    var_0 gotothelevel(0);
  } else {
    precachestring(&"SCRIPT_PLATFORM_FIRE_TO_SKIP");

    for(var_3 = 0; var_3 < level.slide.size; var_3++) {
      if(isDefined(level.slide[var_3]["image"])) {
        precacheshader(level.slide[var_3]["image"]);
      }
    }

    var_0 thread skipthebriefing();
    var_0 dothebriefing();
    var_0 gotothelevel(0);
  }
}

start(var_0) {
  level.briefing_running = 1;
  level.briefing_ending = 0;
  level.placenextimage = "A";

  if(isDefined(level.imagea)) {
    level.imagea destroy();
  }
  if(isDefined(level.imageb)) {
    level.imageb destroy();
  }
  if(isDefined(level.blackscreen)) {
    level.blackscreen destroy();
  }
  if(isDefined(level.firetoskip)) {
    level.firetoskip destroy();
  }
  if(!isDefined(var_0) || !var_0) {
    level.briefing_fadeintime = 0.5;
    level.briefing_fadeouttime = 0.5;
  } else {
    level.briefing_fadeintime = var_0;
    level.briefing_fadeouttime = var_0;
  }

  self endon("briefingskip");
  thread skipcheck();
  level.blackscreen = newhudelem();
  level.blackscreen.sort = -1;
  level.blackscreen.alignx = "left";
  level.blackscreen.aligny = "top";
  level.blackscreen.x = 0;
  level.blackscreen.y = 0;
  level.blackscreen.horzalign = "fullscreen";
  level.blackscreen.vertalign = "fullscreen";
  level.blackscreen.foreground = 1;
  level.blackscreen.alpha = 1;
  level.blackscreen setshader("black", 640, 480);
  level.firetoskip = newhudelem();
  level.firetoskip.sort = 1;
  level.firetoskip.alignx = "center";
  level.firetoskip.aligny = "top";
  level.firetoskip.fontscale = 2;
  level.firetoskip.x = 0;
  level.firetoskip.y = 60;
  level.firetoskip.horzalign = "center";
  level.firetoskip.vertalign = "fullscreen";
  level.firetoskip.foreground = 1;
  level.firetoskip settext(&"SCRIPT_PLATFORM_FIRE_TO_SKIP");
  level.firetoskip.alpha = 0.0;
  thread fadeinfiretoskip();
  level.imagea = newhudelem();
  level.imagea.alignx = "center";
  level.imagea.aligny = "middle";
  level.imagea.x = 320;
  level.imagea.y = 240;
  level.imagea.alpha = 0;
  level.imagea.horzalign = "fullscreen";
  level.imagea.vertalign = "fullscreen";
  level.imagea setshader("black", 640, 360);
  level.imagea.foreground = 1;
  level.imageb = newhudelem();
  level.imageb.alignx = "center";
  level.imageb.aligny = "middle";
  level.imageb.x = 320;
  level.imageb.y = 240;
  level.imageb.horzalign = "fullscreen";
  level.imageb.vertalign = "fullscreen";
  level.imageb.alpha = 0;
  level.imageb setshader("black", 640, 360);
  level.imageb.foreground = 1;
  self freezecontrols(1);
  wait 0.5;

  for(var_1 = 0; var_1 < level.slide.size; var_1++) {
    var_2 = 0;

    if(isDefined(level.slide[var_1]["image"])) {
      if(level.script[0] != "m") {
        soundplay("slide_advance");
      }
      wait 0.5;
      thread image(level.slide[var_1]["image"]);
    }

    if(isDefined(level.slide[var_1]["dialog_wait"]) && self.dialogplaying[level.slide[var_1]["dialog_wait"]]) {
      self waittill(level.slide[var_1]["dialog_wait"] + "sounddone");
    }
    if(isDefined(level.slide[var_1]["dialog"])) {
      soundplay(level.slide[var_1]["dialog"], level.slide[var_1]["dialog"] + "sounddone");
      var_2 = 1;
    }

    if(isDefined(level.slide[var_1]["delay"])) {
      wait(level.slide[var_1]["delay"]);
      continue;
    }

    if(var_2) {
      self waittill(level.slide[var_1]["dialog"] + "sounddone");
    }
  }
}

fadeinfiretoskip() {
  wait 1;
  thread fadefiretoskip();
  level.firetoskip fadeovertime(level.briefing_fadeouttime);
  level.firetoskip.alpha = 1.0;
}

fadefiretoskip() {
  wait 7;
  level.firetoskip fadeovertime(level.briefing_fadeouttime);
  level.firetoskip.alpha = 0.0;
}

waittillbriefingdone() {
  self waittill("briefingend");
}

skipcheck() {
  self endon("briefingend");
  var_0 = getEntArray("player", "classname")[0];
  wait 0.05;
  maps\_utility::set_console_status();

  for(;;) {
    if(level.console) {
      if(var_0 buttonPressed("BUTTON_A")) {
        self notify("briefingskip");
        end();
        return;
      }

      wait 0.05;
      continue;
    }

    if(var_0 attackButtonPressed()) {
      self notify("briefingskip");
      end();
      return;
    }

    wait 0.05;
  }
}

image(var_0) {
  self endon("briefingskip");

  if(level.placenextimage == "A") {
    level.placenextimage = "B";
    level.imagea setshader(var_0, 640, 360);
    thread imagefadeout("B");
    level.imagea fadeovertime(level.briefing_fadeintime);
    level.imagea.alpha = 1;
  } else if(level.placenextimage == "B") {
    level.placenextimage = "A";
    level.imageb setshader(var_0, 640, 360);
    thread imagefadeout("A");
    level.imageb fadeovertime(level.briefing_fadeintime);
    level.imageb.alpha = 1;
  }
}

imagefadeout(var_0) {
  if(var_0 == "A") {
    level.imagea fadeovertime(level.briefing_fadeouttime);
    level.imagea.alpha = 0;
  } else if(var_0 == "B") {
    level.imageb fadeovertime(level.briefing_fadeouttime);
    level.imageb.alpha = 0;
  }
}

endthread() {
  if(!level.briefing_running) {
    return;
  }
  if(level.briefing_ending) {
    return;
  }
  self notify("briefingend");
  level.briefing_ending = 1;

  if(level.script[0] != "m") {
    self playSound("stop_voice");
  }
  thread imagefadeout("A");
  thread imagefadeout("B");
  wait 1.5;
  level.briefing_ending = 0;
}

end() {
  thread endthread();
}

soundplay(var_0, var_1) {
  if(isDefined(level.tmpmsg[var_0])) {
    iprintlnbold(level.tmpmsg[var_0]);
  }
  if(isDefined(var_1)) {
    thread soundplay_flag(var_0, var_1);
    self playSound(var_0, var_1);
  } else {
    self playSound(var_0);
  }
}

soundplay_flag(var_0, var_1) {
  self.dialogplaying[var_0] = 1;
  self waittill(var_1);
  self.dialogplaying[var_0] = 0;
}

dothebriefing() {
  start(0.5);

  if(level.script[0] != "m") {
    soundplay("slide_advance");
  }
  wait 0.5;
  end();
}

skipthebriefing() {
  self waittill("briefingskip");
  gotothelevel(1);
}

gotothelevel(var_0) {
  if(!var_0) {
    for(var_1 = 0; var_1 < level.slide.size; var_1++) {
      if(isDefined(level.slide[var_1]["movie"])) {
        cinematic(level.slide[var_1]["movie"]);
      }
    }
  }

  changelevel(level.leveltoload, 0);
}