/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_guide.gsc
**************************************/

#include maps\_utility;

main() {
  thread lastshottime();
  array_thread(getEntArray("showpath", "script_noteworthy"), ::showpath);
  array_thread(getEntArray("brush_guide", "targetname"), ::brush_guide);
}

showpath_trigger(path) {
  while(1) {
    self waittill("trigger");
    path notify("showpath");
  }
}

showpath() {
  array_thread(getEntArray(self.targetname, "target"), ::showpath_trigger, self);
  while(1) {
    self waittill("showpath");
    level notify("newtrigger");
    self thread leadshowstuff();
    level waittill("newtrigger");
  }
}

leadshowstuff() {
  level endon("newtrigger");
  while(1) {
    waitforrecentfire();
    wait .5;
    thread leadshowstuff_path(self, 1);
  }
}

leadshowstuff_path(position, arrowtime) {
  level endon("newtrigger");
  if(isDefined(position.target))
    targ = getent(position.target, "targetname");
  else
    targ = undefined;
  lasttarg = position;
  while(isDefined(targ)) {
    waitforrecentfire();
    if(isDefined(targ.target))
      targ = getent(targ.target, "targetname");
    else
      return;
    if(!isDefined(targ))
      return;
    realarrowtime = distance(lasttarg.origin, targ.origin) / 1000;
    draw_arrow_time(lasttarg.origin, targ.origin, (0, 0, 1), realarrowtime);
    wait realarrowtime;
    lasttarg = targ;
  }
}

waitforrecentfire() {
  while(!level.hasfiredrecently)
    wait .05;
}

lastshottime() {
  level.hasfiredrecently = true;
  lastshottime = 0;
  while(1) {
    players = get_players();
    if(players[0] usebuttonpressed()) {
      lastshottime = 0;
    } else {
      lastshottime += .05;
    }
    if(lastshottime > 4) {
      level.hasfiredrecently = false;
    } else {
      level.hasfiredrecently = true;
    }

    wait .05;
  }
}

brush_guide() {
  while(1) {
    self hide();
    while(!level.hasfiredrecently)
      wait .05;
    self show();
    while(level.hasfiredrecently)
      wait .05;
  }
}