/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_art.gsc
*************************************************/

#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace art;

function autoexec __init__sytem__() {
  system::register("art", & __init__, undefined, undefined);
}

function __init__() {
  if(getdvarstring("") == "" || getdvarstring("") == "") {
    setdvar("", 0);
  }
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  if(getdvarstring("") == "") {
    setdvar("", "");
  }
  if(getdvarstring("") == "" && isdefined(level.script)) {
    setdvar("", level.script);
  }
  if(!isdefined(level.dofdefault)) {
    level.dofdefault["nearStart"] = 0;
    level.dofdefault["nearEnd"] = 1;
    level.dofdefault["farStart"] = 8000;
    level.dofdefault["farEnd"] = 10000;
    level.dofdefault["nearBlur"] = 6;
    level.dofdefault["farBlur"] = 0;
  }
  level.curdof = (level.dofdefault["farStart"] - level.dofdefault["nearEnd"]) / 2;
  thread tweakart();
}

function artfxprintln(file, string) {
  if(file == -1) {
    return;
  }
  fprintln(file, string);
}

function strtok_loc(string, par1) {
  stringlist = [];
  indexstring = "";
  for (i = 0; i < string.size; i++) {
    if(string[i] == " ") {
      stringlist[stringlist.size] = indexstring;
      indexstring = "";
      continue;
    }
    indexstring = indexstring + string[i];
  }
  if(indexstring.size) {
    stringlist[stringlist.size] = indexstring;
  }
  return stringlist;
}

function setfogsliders() {
  fogall = strtok_loc(getdvarstring(""), "");
  red = fogall[0];
  green = fogall[1];
  blue = fogall[2];
  halfplane = getdvarstring("");
  nearplane = getdvarstring("");
  if(!isdefined(red) || !isdefined(green) || !isdefined(blue) || !isdefined(halfplane)) {
    red = 1;
    green = 1;
    blue = 1;
    halfplane = 10000001;
    nearplane = 10000000;
  }
  setdvar("", halfplane);
  setdvar("", nearplane);
  setdvar("", (((red + "") + green) + "") + blue);
}

function tweakart() {
  if(!isdefined(level.tweakfile)) {
    level.tweakfile = 0;
  }
  if(getdvarstring("") == "") {
    setdvar("", "");
    setdvar("", "");
    setdvar("", "");
    setdvar("", "");
  }
  setdvar("", "");
  setdvar("", "");
  setdvar("", "");
  setdvar("", level.dofdefault[""]);
  setdvar("", level.dofdefault[""]);
  setdvar("", level.dofdefault[""]);
  setdvar("", level.dofdefault[""]);
  setdvar("", level.dofdefault[""]);
  setdvar("", level.dofdefault[""]);
  file = undefined;
  filename = undefined;
  tweak_toggle = 1;
  for (;;) {
    while (getdvarint("") == 0) {
      tweak_toggle = 1;
      wait(0.05);
    }
    if(tweak_toggle) {
      tweak_toggle = 0;
      fogsettings = getfogsettings();
      setdvar("", fogsettings[0]);
      setdvar("", fogsettings[1]);
      setdvar("", fogsettings[3]);
      setdvar("", fogsettings[2]);
      setdvar("", (((fogsettings[4] + "") + fogsettings[5]) + "") + fogsettings[6]);
      setdvar("", fogsettings[7]);
      setdvar("", (((fogsettings[8] + "") + fogsettings[9]) + "") + fogsettings[10]);
      level.fogsundir = [];
      level.fogsundir[0] = fogsettings[11];
      level.fogsundir[1] = fogsettings[12];
      level.fogsundir[2] = fogsettings[13];
      setdvar("", fogsettings[14]);
      setdvar("", fogsettings[15]);
      setdvar("", fogsettings[16]);
    }
    level.fogexphalfplane = getdvarfloat("");
    level.fogexphalfheight = getdvarfloat("");
    level.fognearplane = getdvarfloat("");
    level.fogbaseheight = getdvarfloat("");
    colors = strtok(getdvarstring(""), "");
    level.fogcolorred = int(colors[0]);
    level.fogcolorgreen = int(colors[1]);
    level.fogcolorblue = int(colors[2]);
    level.fogcolorscale = getdvarfloat("");
    colors = strtok(getdvarstring(""), "");
    level.sunfogcolorred = int(colors[0]);
    level.sunfogcolorgreen = int(colors[1]);
    level.sunfogcolorblue = int(colors[2]);
    level.sunstartangle = getdvarfloat("");
    level.sunendangle = getdvarfloat("");
    level.fogmaxopacity = getdvarfloat("");
    if(getdvarint("")) {
      setdvar("", "");
      println("");
      players = getplayers();
      dir = vectornormalize(anglestoforward(players[0] getplayerangles()));
      level.fogsundir = [];
      level.fogsundir[0] = dir[0];
      level.fogsundir[1] = dir[1];
      level.fogsundir[2] = dir[2];
    }
    fovslidercheck();
    dumpsettings();
    if(!getdvarint("")) {
      if(!isdefined(level.fogsundir)) {
        level.fogsundir = [];
        level.fogsundir[0] = 1;
        level.fogsundir[1] = 0;
        level.fogsundir[2] = 0;
      }
      setvolfog(level.fognearplane, level.fogexphalfplane, level.fogexphalfheight, level.fogbaseheight, level.fogcolorred, level.fogcolorgreen, level.fogcolorblue, level.fogcolorscale, level.sunfogcolorred, level.sunfogcolorgreen, level.sunfogcolorblue, level.fogsundir[0], level.fogsundir[1], level.fogsundir[2], level.sunstartangle, level.sunendangle, 0, level.fogmaxopacity);
    } else {
      setexpfog(100000000, 100000001, 0, 0, 0, 0);
    }
    wait(0.1);
  }
}

function fovslidercheck() {
  if(level.dofdefault[""] >= level.dofdefault[""]) {
    level.dofdefault[""] = level.dofdefault[""] - 1;
    setdvar("", level.dofdefault[""]);
  }
  if(level.dofdefault[""] <= level.dofdefault[""]) {
    level.dofdefault[""] = level.dofdefault[""] + 1;
    setdvar("", level.dofdefault[""]);
  }
  if(level.dofdefault[""] >= level.dofdefault[""]) {
    level.dofdefault[""] = level.dofdefault[""] - 1;
    setdvar("", level.dofdefault[""]);
  }
  if(level.dofdefault[""] <= level.dofdefault[""]) {
    level.dofdefault[""] = level.dofdefault[""] + 1;
    setdvar("", level.dofdefault[""]);
  }
  if(level.dofdefault[""] >= level.dofdefault[""]) {
    level.dofdefault[""] = level.dofdefault[""] - 0.1;
    setdvar("", level.dofdefault[""]);
  }
  if(level.dofdefault[""] <= level.dofdefault[""]) {
    level.dofdefault[""] = level.dofdefault[""] + 1;
    setdvar("", level.dofdefault[""]);
  }
}

function dumpsettings() {
  if(getdvarstring("") != "") {
    println(("" + level.fognearplane) + "");
    println(("" + level.fogexphalfplane) + "");
    println(("" + level.fogexphalfheight) + "");
    println(("" + level.fogbaseheight) + "");
    println(("" + level.fogcolorred) + "");
    println(("" + level.fogcolorgreen) + "");
    println(("" + level.fogcolorblue) + "");
    println(("" + level.fogcolorscale) + "");
    println(("" + level.sunfogcolorred) + "");
    println(("" + level.sunfogcolorgreen) + "");
    println(("" + level.sunfogcolorblue) + "");
    println(("" + level.fogsundir[0]) + "");
    println(("" + level.fogsundir[1]) + "");
    println(("" + level.fogsundir[2]) + "");
    println(("" + level.sunstartangle) + "");
    println(("" + level.sunendangle) + "");
    println("");
    println(("" + level.fogmaxopacity) + "");
    println("");
    println("");
    println("");
    println("");
    setdvar("", "");
  }
}