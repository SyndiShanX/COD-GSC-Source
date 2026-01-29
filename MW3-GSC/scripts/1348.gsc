/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1348.gsc
**************************************/

main() {
  setsaveddvar("hud_drawhud", 0);
  level.script = tolower(getdvar("mapname"));

  if(!isDefined(level._id_404D)) {
    level._id_404D = [];

  }
  var_0 = getEntArray("player", "classname")[0];
  setsaveddvar("g_speed", 0);
  var_0 setviewmodel("viewmodel_hands_cloth");
  precacheshader("black");
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_404E.size; var_2++) {
    if(isDefined(level._id_404E[var_2]["movie"])) {
      var_1 = 1;
      break;
    }
  }

  if(var_1) {
    wait 0.05;
    var_0 _id_4064(0);
  } else {
    precachestring(&"SCRIPT_PLATFORM_FIRE_TO_SKIP");

    for(var_3 = 0; var_3 < level._id_404E.size; var_3++) {
      if(isDefined(level._id_404E[var_3]["image"])) {
        precacheshader(level._id_404E[var_3]["image"]);
      }
    }

    var_0 thread _id_4063();
    var_0 _id_4062();
    var_0 _id_4064(0);
  }
}

start(var_0) {
  level._id_404F = 1;
  level._id_4050 = 0;
  level._id_4051 = "A";

  if(isDefined(level._id_4052)) {
    level._id_4052 destroy();

  }
  if(isDefined(level._id_4053)) {
    level._id_4053 destroy();

  }
  if(isDefined(level._id_4054)) {
    level._id_4054 destroy();

  }
  if(isDefined(level._id_4055)) {
    level._id_4055 destroy();

  }
  if(!isDefined(var_0) || !var_0) {
    level._id_4056 = 0.5;
    level._id_4057 = 0.5;
  } else {
    level._id_4056 = var_0;
    level._id_4057 = var_0;
  }

  self endon("briefingskip");
  thread _id_405C();
  level._id_4054 = newhudelem();
  level._id_4054.sort = -1;
  level._id_4054.alignx = "left";
  level._id_4054.aligny = "top";
  level._id_4054.x = 0;
  level._id_4054.y = 0;
  level._id_4054.horzalign = "fullscreen";
  level._id_4054.vertalign = "fullscreen";
  level._id_4054.foreground = 1;
  level._id_4054.alpha = 1;
  level._id_4054 setshader("black", 640, 480);
  level._id_4055 = newhudelem();
  level._id_4055.sort = 1;
  level._id_4055.alignx = "center";
  level._id_4055.aligny = "top";
  level._id_4055.fontscale = 2;
  level._id_4055.x = 0;
  level._id_4055.y = 60;
  level._id_4055.horzalign = "center";
  level._id_4055.vertalign = "fullscreen";
  level._id_4055.foreground = 1;
  level._id_4055 settext(&"SCRIPT_PLATFORM_FIRE_TO_SKIP");
  level._id_4055.alpha = 0.0;
  thread _id_4059();
  level._id_4052 = newhudelem();
  level._id_4052.alignx = "center";
  level._id_4052.aligny = "middle";
  level._id_4052.x = 320;
  level._id_4052.y = 240;
  level._id_4052.alpha = 0;
  level._id_4052.horzalign = "fullscreen";
  level._id_4052.vertalign = "fullscreen";
  level._id_4052 setshader("black", 640, 360);
  level._id_4052.foreground = 1;
  level._id_4053 = newhudelem();
  level._id_4053.alignx = "center";
  level._id_4053.aligny = "middle";
  level._id_4053.x = 320;
  level._id_4053.y = 240;
  level._id_4053.horzalign = "fullscreen";
  level._id_4053.vertalign = "fullscreen";
  level._id_4053.alpha = 0;
  level._id_4053 setshader("black", 640, 360);
  level._id_4053.foreground = 1;
  self freezecontrols(1);
  wait 0.5;

  for(var_1 = 0; var_1 < level._id_404E.size; var_1++) {
    var_2 = 0;

    if(isDefined(level._id_404E[var_1]["image"])) {
      if(level.script[0] != "m") {
        _id_4060("slide_advance");

      }
      wait 0.5;
      thread _id_405D(level._id_404E[var_1]["image"]);
    }

    if(isDefined(level._id_404E[var_1]["dialog_wait"]) && self._id_4058[level._id_404E[var_1]["dialog_wait"]]) {
      self waittill(level._id_404E[var_1]["dialog_wait"] + "sounddone");

    }
    if(isDefined(level._id_404E[var_1]["dialog"])) {
      _id_4060(level._id_404E[var_1]["dialog"], level._id_404E[var_1]["dialog"] + "sounddone");
      var_2 = 1;
    }

    if(isDefined(level._id_404E[var_1]["delay"])) {
      wait(level._id_404E[var_1]["delay"]);
      continue;
    }

    if(var_2) {
      self waittill(level._id_404E[var_1]["dialog"] + "sounddone");
    }
  }
}

_id_4059() {
  wait 1;
  thread _id_405A();
  level._id_4055 fadeovertime(level._id_4057);
  level._id_4055.alpha = 1.0;
}

_id_405A() {
  wait 7;
  level._id_4055 fadeovertime(level._id_4057);
  level._id_4055.alpha = 0.0;
}

_id_405B() {
  self waittill("briefingend");
}

_id_405C() {
  self endon("briefingend");
  var_0 = getEntArray("player", "classname")[0];
  wait 0.05;
  maps\_utility::_id_1DE7();

  for(;;) {
    if(level.console) {
      if(var_0 buttonpressed("BUTTON_A")) {
        self notify("briefingskip");
        end();
        return;
      }

      wait 0.05;
      continue;
    }

    if(var_0 attackbuttonpressed()) {
      self notify("briefingskip");
      end();
      return;
    }

    wait 0.05;
  }
}

_id_405D(var_0) {
  self endon("briefingskip");

  if(level._id_4051 == "A") {
    level._id_4051 = "B";
    level._id_4052 setshader(var_0, 640, 360);
    thread _id_405E("B");
    level._id_4052 fadeovertime(level._id_4056);
    level._id_4052.alpha = 1;
  } else if(level._id_4051 == "B") {
    level._id_4051 = "A";
    level._id_4053 setshader(var_0, 640, 360);
    thread _id_405E("A");
    level._id_4053 fadeovertime(level._id_4056);
    level._id_4053.alpha = 1;
  }
}

_id_405E(var_0) {
  if(var_0 == "A") {
    level._id_4052 fadeovertime(level._id_4057);
    level._id_4052.alpha = 0;
  } else if(var_0 == "B") {
    level._id_4053 fadeovertime(level._id_4057);
    level._id_4053.alpha = 0;
  }
}

_id_405F() {
  if(!level._id_404F) {
    return;
  }
  if(level._id_4050) {
    return;
  }
  self notify("briefingend");
  level._id_4050 = 1;

  if(level.script[0] != "m") {
    self playSound("stop_voice");

  }
  thread _id_405E("A");
  thread _id_405E("B");
  wait 1.5;
  level._id_4050 = 0;
}

end() {
  thread _id_405F();
}

_id_4060(var_0, var_1) {
  if(isDefined(level._id_404D[var_0])) {
    iprintlnbold(level._id_404D[var_0]);

  }
  if(isDefined(var_1)) {
    thread _id_4061(var_0, var_1);
    self playSound(var_0, var_1);
  } else {
    self playSound(var_0);
  }
}

_id_4061(var_0, var_1) {
  self._id_4058[var_0] = 1;
  self waittill(var_1);
  self._id_4058[var_0] = 0;
}

_id_4062() {
  start(0.5);

  if(level.script[0] != "m") {
    _id_4060("slide_advance");

  }
  wait 0.5;
  end();
}

_id_4063() {
  self waittill("briefingskip");
  _id_4064(1);
}

_id_4064(var_0) {
  if(!var_0) {
    for(var_1 = 0; var_1 < level._id_404E.size; var_1++) {
      if(isDefined(level._id_404E[var_1]["movie"])) {
        cinematic(level._id_404E[var_1]["movie"]);
      }
    }
  }

  changelevel(level._id_4065, 0);
}