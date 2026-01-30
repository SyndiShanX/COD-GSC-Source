/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_tubes.gsc
**************************************/

init() {
  var_0 = common_scripts\utility::getstructarray("zombie_tube", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");
    var_4 = common_scripts\utility::getstructarray(var_2.target, "targetname");
    var_5 = common_scripts\utility::array_combine(var_3, var_4);

    foreach(var_7 in var_5) {
      var_8 = var_7.script_noteworthy;

      if(!isDefined(var_8)) {
        continue;
      }
      switch (var_8) {
        case "door_rotate":
          var_2.door = var_7;
          var_2.door linktargets();
          var_2.door.closeangles = var_7.angles;
          var_2.door.openangles = var_7.angles + (0, 180, 0);
          break;
        case "trigger":
          var_2.trigger = var_7;
          break;
        case "start":
          var_2.start = var_7;
          var_2.startend = common_scripts\utility::getstruct(var_2.start.target, "targetname");
          var_2.endstart = common_scripts\utility::getstruct(var_2.startend.target, "targetname");
          var_2.end = common_scripts\utility::getstruct(var_2.endstart.target, "targetname");
          break;
        default:
          break;
      }
    }

    var_2 thread runtube();
  }
}

linktargets() {
  if(!isDefined(self.target)) {
    return;
  }
  var_0 = getEntArray(self.target, "targetname");

  foreach(var_2 in var_0) {
    var_2 linkto(self);
  }
}

runtube() {
  var_0 = 0.3;
  var_1 = 200;

  if(isDefined(self.script_flag_true)) {
    common_scripts\utility::flag_wait(self.script_flag_true);
  }

  if(isDefined(self.door)) {
    var_2 = 0.5;
    self.door rotateto(self.door.openangles, var_2);
    wait(var_2);
  }

  for(;;) {
    self.trigger sethintstring(&"ZOMBIE_H2O_USE_TUBE");
    self.trigger setcursorhint("HINT_NOICON");
    self.trigger waittill("trigger", var_3);
    self.trigger sethintstring("");
    var_3 setstance("stand");
    var_3.inteleport = 1;

    if(isDefined(self.door)) {
      self.door rotateto(self.door.closeangles, var_0);
    }

    var_4 = spawn("script_model", var_3.origin);
    var_4.angles = (0, var_3.angles[1], 0);
    var_4 setModel("tag_origin");
    var_3 playerlinkto(var_4, "tag_origin", var_0);
    thread maps\mp\mp_zombie_h2o_aud::sndtubestart(var_4, var_3);
    var_4 moveto(self.start.origin, var_0);
    wait(var_0);
    var_5 = distance(var_4.origin, self.startend.origin) / var_1;
    var_4 moveto(self.startend.origin, var_5, var_5, 0);
    var_6 = anglesdelta(var_4.angles, self.startend.angles);

    if(var_6 > 0) {
      var_4 rotateto(self.startend.angles, var_5);
    }

    var_3 thread playertubevo();
    wait(var_5);

    if(isDefined(self.door)) {
      self.door rotateto(self.door.openangles, var_0);
    }

    thread endtube(var_4, var_3, var_1);
  }
}

endtube(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_1 dontinterpolate();
  }

  var_0 dontinterpolate();
  var_0.origin = self.endstart.origin;
  var_0.angles = self.endstart.angles;
  var_3 = distance(var_0.origin, self.end.origin) / var_2;
  var_0 moveto(self.end.origin, var_3, var_3, 0);
  thread maps\mp\mp_zombie_h2o_aud::sndtubeend(self.end.origin, var_1);
  var_4 = anglesdelta(var_0.angles, self.end.angles);

  if(var_4 > 0) {
    var_0 rotateto(self.end.angles, var_3);
  }

  wait(var_3);

  if(isDefined(var_1)) {
    var_1 unlink();
    var_1.inteleport = 0;
  }

  var_0 delete();
}

playertubevo() {
  thread maps\mp\zombies\_zombies_audio::create_and_play_dialog_delay("monologue", "tube", undefined, undefined, undefined, 0.5);
}