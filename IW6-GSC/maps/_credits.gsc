/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_credits.gsc
*****************************************************/

initcredits(var_0) {
  common_scripts\utility::flag_init("atvi_credits_go");
  level.linesize = 1.35;
  level.headingsize = 1.75;
  level.linelist = [];
  level.credits_speed = 20.25;
  level.credits_spacing = -120;
  maps\_utility::set_console_status();

  if(!isDefined(var_0))
    var_0 = "all";

  switch (var_0) {
    case "iw":
      maps\_credits_autogen::initiw6credits();
      break;
    case "atvi":
      maps\_credits_autogen::initactivisioncredits();
      break;
    case "all":
      maps\_credits_autogen::initiw6credits();
      maps\_credits_autogen::initactivisioncredits();
      break;
  }
}

addlefttitle(var_0, var_1) {
  precachestring(var_0);

  if(!isDefined(var_1))
    var_1 = level.linesize;

  var_2 = spawnStruct();
  var_2.type = "lefttitle";
  var_2.title = var_0;
  var_2.textscale = var_1;
  level.linelist[level.linelist.size] = var_2;
}

addleftname(var_0, var_1) {
  precachestring(var_0);

  if(!isDefined(var_1))
    var_1 = level.linesize;

  var_2 = spawnStruct();
  var_2.type = "leftname";
  var_2.name = var_0;
  var_2.textscale = var_1;
  level.linelist[level.linelist.size] = var_2;
}

addsublefttitle(var_0, var_1) {
  addleftname(var_0, var_1);
}

addsubleftname(var_0, var_1) {
  precachestring(var_0);

  if(!isDefined(var_1))
    var_1 = level.linesize;

  var_2 = spawnStruct();
  var_2.type = "subleftname";
  var_2.name = var_0;
  var_2.textscale = var_1;
  level.linelist[level.linelist.size] = var_2;
}

addrighttitle(var_0, var_1) {
  precachestring(var_0);

  if(!isDefined(var_1))
    var_1 = level.linesize;

  var_2 = spawnStruct();
  var_2.type = "righttitle";
  var_2.title = var_0;
  var_2.textscale = var_1;
  level.linelist[level.linelist.size] = var_2;
}

addrightname(var_0, var_1) {
  precachestring(var_0);

  if(!isDefined(var_1))
    var_1 = level.linesize;

  var_2 = spawnStruct();
  var_2.type = "rightname";
  var_2.name = var_0;
  var_2.textscale = var_1;
  level.linelist[level.linelist.size] = var_2;
}

addcenterheading(var_0, var_1) {
  precachestring(var_0);

  if(!isDefined(var_1))
    var_1 = level.linesize;

  var_2 = spawnStruct();
  var_2.type = "centerheading";
  var_2.heading = var_0;
  var_2.textscale = var_1;
  level.linelist[level.linelist.size] = var_2;
}

addcentersubtitle(var_0, var_1) {
  precachestring(var_0);

  if(!isDefined(var_1))
    var_1 = level.linesize;

  var_2 = spawnStruct();
  var_2.type = "centersubtitle";
  var_2.heading = var_0;
  var_2.textscale = var_1;
  level.linelist[level.linelist.size] = var_2;
}

addcastname(var_0, var_1, var_2) {
  precachestring(var_1);
  precachestring(var_0);

  if(!isDefined(var_2))
    var_2 = level.linesize;

  var_3 = spawnStruct();
  var_3.type = "castname";
  var_3.title = var_1;
  var_3.name = var_0;
  var_3.textscale = var_2;
  level.linelist[level.linelist.size] = var_3;
}

addcentername(var_0, var_1) {
  precachestring(var_0);

  if(!isDefined(var_1))
    var_1 = level.linesize;

  var_2 = spawnStruct();
  var_2.type = "centername";
  var_2.name = var_0;
  var_2.textscale = var_1;
  level.linelist[level.linelist.size] = var_2;
}

addcenternamedouble(var_0, var_1, var_2) {
  precachestring(var_0);
  precachestring(var_1);

  if(!isDefined(var_2))
    var_2 = level.linesize;

  var_3 = spawnStruct();
  var_3.type = "centernamedouble";
  var_3.name1 = var_0;
  var_3.name2 = var_1;
  var_3.textscale = var_2;
  level.linelist[level.linelist.size] = var_3;
}

addcenterdual(var_0, var_1, var_2) {
  precachestring(var_0);
  precachestring(var_1);

  if(!isDefined(var_2))
    var_2 = level.linesize;

  var_3 = spawnStruct();
  var_3.type = "centerdual";
  var_3.title = var_0;
  var_3.name = var_1;
  var_3.textscale = var_2;
  level.linelist[level.linelist.size] = var_3;
}

addcentertriple(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.type = "centertriple";

  if(isDefined(var_0)) {
    precachestring(var_0);
    var_4.name1 = var_0;
  } else
    var_4.name1 = "";

  if(isDefined(var_1)) {
    precachestring(var_1);
    var_4.name2 = var_1;
  } else
    var_4.name2 = "";

  if(isDefined(var_2)) {
    precachestring(var_2);
    var_4.name3 = var_2;
  } else
    var_4.name3 = "";

  if(!isDefined(var_3))
    var_3 = level.linesize;

  var_4.textscale = var_3;
  level.linelist[level.linelist.size] = var_4;
}

addspace() {
  var_0 = spawnStruct();
  var_0.type = "space";
  level.linelist[level.linelist.size] = var_0;
}

addspacesmall() {
  var_0 = spawnStruct();
  var_0.type = "spacesmall";
  level.linelist[level.linelist.size] = var_0;
}

playcredits() {
  visionsetnaked("", 0);
  var_0 = getDvar("ui_char_museum_mode");

  for(var_1 = 0; var_1 < level.linelist.size; var_1++) {
    var_2 = 0.5;
    var_3 = level.linelist[var_1].type;

    if(var_3 == "lefttitle") {
      var_4 = level.linelist[var_1].title;
      var_5 = level.linelist[var_1].textscale;
      var_6 = newhudelem();
      var_6 settext(var_4);
      var_6.alignx = "left";
      var_6.horzalign = "left";
      var_6.x = 28;
      var_6.y = 480;

      if(!level.console)
        var_6.font = "default";
      else
        var_6.font = "small";

      var_6.fontscale = var_5;
      var_6.sort = 2;
      var_6.glowcolor = (0.3, 0.6, 0.3);
      var_6.glowalpha = 1;
      var_6 thread delaydestroy(level.credits_speed);
      var_6 moveovertime(level.credits_speed);
      var_6.y = level.credits_spacing;
      var_6 thread pulse_fx();
    } else if(var_3 == "leftname") {
      var_7 = level.linelist[var_1].name;
      var_5 = level.linelist[var_1].textscale;
      var_6 = newhudelem();
      var_6 settext(var_7);
      var_6.alignx = "left";
      var_6.horzalign = "left";
      var_6.x = 60;
      var_6.y = 480;

      if(!level.console)
        var_6.font = "default";
      else
        var_6.font = "small";

      var_6.fontscale = var_5;
      var_6.sort = 2;
      var_6.glowcolor = (0.3, 0.6, 0.3);
      var_6.glowalpha = 1;
      var_6 thread delaydestroy(level.credits_speed);
      var_6 moveovertime(level.credits_speed);
      var_6.y = level.credits_spacing;
      var_6 thread pulse_fx();
    } else if(var_3 == "castname") {
      var_4 = level.linelist[var_1].title;
      var_7 = level.linelist[var_1].name;
      var_5 = level.linelist[var_1].textscale;
      var_8 = newhudelem();
      var_8 settext(var_4);
      var_8.alignx = "left";
      var_8.horzalign = "left";
      var_8.x = 60;
      var_8.y = 480;

      if(!level.console)
        var_8.font = "default";
      else
        var_8.font = "small";

      var_8.fontscale = var_5;
      var_8.sort = 2;
      var_8.glowcolor = (0.3, 0.6, 0.3);
      var_8.glowalpha = 1;
      var_9 = newhudelem();
      var_9 settext(var_7);
      var_9.alignx = "right";
      var_9.horzalign = "left";
      var_9.x = 275;
      var_9.y = 480;

      if(!level.console)
        var_9.font = "default";
      else
        var_9.font = "small";

      var_9.fontscale = var_5;
      var_9.sort = 2;
      var_9.glowcolor = (0.3, 0.6, 0.3);
      var_9.glowalpha = 1;
      var_8 thread delaydestroy(level.credits_speed);
      var_8 moveovertime(level.credits_speed);
      var_8.y = level.credits_spacing;
      var_9 thread delaydestroy(level.credits_speed);
      var_9 moveovertime(level.credits_speed);
      var_9.y = level.credits_spacing;
      var_8 thread pulse_fx();
      var_9 thread pulse_fx();
    } else if(var_3 == "subleftname") {
      var_7 = level.linelist[var_1].name;
      var_5 = level.linelist[var_1].textscale;
      var_6 = newhudelem();
      var_6 settext(var_7);
      var_6.alignx = "left";
      var_6.horzalign = "left";
      var_6.x = 92;
      var_6.y = 480;

      if(!level.console)
        var_6.font = "default";
      else
        var_6.font = "small";

      var_6.fontscale = var_5;
      var_6.sort = 2;
      var_6.glowcolor = (0.3, 0.6, 0.3);
      var_6.glowalpha = 1;
      var_6 thread delaydestroy(level.credits_speed);
      var_6 moveovertime(level.credits_speed);
      var_6.y = level.credits_spacing;
      var_6 thread pulse_fx();
    } else if(var_3 == "righttitle") {
      var_4 = level.linelist[var_1].title;
      var_5 = level.linelist[var_1].textscale;
      var_6 = newhudelem();
      var_6 settext(var_4);
      var_6.alignx = "left";
      var_6.horzalign = "right";
      var_6.x = -132;
      var_6.y = 480;

      if(!level.console)
        var_6.font = "default";
      else
        var_6.font = "small";

      var_6.fontscale = var_5;
      var_6.sort = 2;
      var_6.glowcolor = (0.3, 0.6, 0.3);
      var_6.glowalpha = 1;
      var_6 thread delaydestroy(level.credits_speed);
      var_6 moveovertime(level.credits_speed);
      var_6.y = level.credits_spacing;
    } else if(var_3 == "rightname") {
      var_7 = level.linelist[var_1].name;
      var_5 = level.linelist[var_1].textscale;
      var_6 = newhudelem();
      var_6 settext(var_7);
      var_6.alignx = "left";
      var_6.horzalign = "right";
      var_6.x = -100;
      var_6.y = 480;

      if(!level.console)
        var_6.font = "default";
      else
        var_6.font = "small";

      var_6.fontscale = var_5;
      var_6.sort = 2;
      var_6.glowcolor = (0.3, 0.6, 0.3);
      var_6.glowalpha = 1;
      var_6 thread delaydestroy(level.credits_speed);
      var_6 moveovertime(level.credits_speed);
      var_6.y = level.credits_spacing;
    } else if(var_3 == "centerheading") {
      var_10 = level.linelist[var_1].heading;
      var_5 = level.linelist[var_1].textscale * 1.2;
      var_6 = newhudelem();
      var_6 settext(var_10);
      var_6.alignx = "center";
      var_6.horzalign = "center";
      var_6.x = 0;
      var_6.y = 480;

      if(!level.console)
        var_6.font = "objective";
      else
        var_6.font = "objective";

      var_6.fontscale = var_5;
      var_6.sort = 2;
      var_6.glowcolor = (0.1, 0.6, 0.7);
      var_6.glowalpha = 0.5;
      var_6 thread delaydestroy(level.credits_speed);
      var_6 moveovertime(level.credits_speed);
      var_6 thread delayfade(level.credits_speed);
      var_6.y = level.credits_spacing;
      var_2 = var_2 * 1.2;
    } else if(var_3 == "centersubtitle") {
      var_10 = level.linelist[var_1].heading;
      var_5 = level.linelist[var_1].textscale;
      var_6 = newhudelem();
      var_6 settext(var_10);
      var_6.alignx = "center";
      var_6.horzalign = "center";
      var_6.x = 0;
      var_6.y = 480;

      if(!level.console)
        var_6.font = "big";
      else
        var_6.font = "big";

      var_6.fontscale = var_5;
      var_6.sort = 2;
      var_6.glowcolor = (0.1, 0.6, 0.7);
      var_6.glowalpha = 0.5;
      var_6 thread delaydestroy(level.credits_speed);
      var_6 moveovertime(level.credits_speed);
      var_6 thread delayfade(level.credits_speed);
      var_6.y = level.credits_spacing;
      var_2 = var_2 * 1.1;
    } else if(var_3 == "centerdual") {
      var_4 = level.linelist[var_1].title;
      var_7 = level.linelist[var_1].name;
      var_5 = level.linelist[var_1].textscale;
      var_8 = newhudelem();
      var_8 settext(var_4);
      var_8.alignx = "right";
      var_8.horzalign = "center";
      var_8.x = -4;
      var_8.y = 480;

      if(!level.console)
        var_8.font = "small";
      else
        var_8.font = "small";

      var_8.fontscale = var_5;
      var_8.sort = 2;
      var_8.glowcolor = (0.6, 0.6, 0.6);
      var_8.glowalpha = 0;
      var_9 = newhudelem();
      var_9 settext(var_7);
      var_9.alignx = "left";
      var_9.horzalign = "center";
      var_9.x = 4;
      var_9.y = 480;

      if(!level.console)
        var_9.font = "small";
      else
        var_9.font = "small";

      var_9.fontscale = var_5;
      var_9.sort = 2;
      var_9.glowcolor = (0.6, 0.6, 0.6);
      var_9.glowalpha = 0;
      var_8 thread delaydestroy(level.credits_speed);
      var_8 moveovertime(level.credits_speed);
      var_8 thread delayfade(level.credits_speed - 0.3);
      var_8.y = level.credits_spacing;
      var_9 thread delaydestroy(level.credits_speed);
      var_9 moveovertime(level.credits_speed);
      var_9 thread delayfade(level.credits_speed);
      var_9.y = level.credits_spacing;
    } else if(var_3 == "centertriple") {
      var_11 = level.linelist[var_1].name1;
      var_12 = level.linelist[var_1].name2;
      var_13 = level.linelist[var_1].name3;
      var_5 = level.linelist[var_1].textscale;
      var_8 = newhudelem();
      var_8 settext(var_11);
      var_8.alignx = "left";
      var_8.horzalign = "center";
      var_8.x = -220;
      var_8.y = 480;

      if(!level.console)
        var_8.font = "small";
      else
        var_8.font = "small";

      var_8.fontscale = var_5;
      var_8.sort = 2;
      var_8.glowcolor = (0.6, 0.6, 0.6);
      var_8.glowalpha = 0;
      var_9 = newhudelem();
      var_9 settext(var_12);
      var_9.alignx = "center";
      var_9.horzalign = "center";
      var_9.x = 0;
      var_9.y = 480;

      if(!level.console)
        var_9.font = "small";
      else
        var_9.font = "small";

      var_9.fontscale = var_5;
      var_9.sort = 2;
      var_9.glowcolor = (0.6, 0.6, 0.6);
      var_9.glowalpha = 0;
      var_14 = newhudelem();
      var_14 settext(var_13);
      var_14.alignx = "right";
      var_14.horzalign = "center";
      var_14.x = 220;
      var_14.y = 480;

      if(!level.console)
        var_14.font = "small";
      else
        var_14.font = "small";

      var_14.fontscale = var_5;
      var_14.sort = 2;
      var_14.glowcolor = (0.6, 0.6, 0.6);
      var_14.glowalpha = 0;
      var_8 thread delaydestroy(level.credits_speed);
      var_8 moveovertime(level.credits_speed);
      var_8 thread delayfade(level.credits_speed - 0.4);
      var_8.y = level.credits_spacing;
      var_9 thread delaydestroy(level.credits_speed);
      var_9 moveovertime(level.credits_speed);
      var_9 thread delayfade(level.credits_speed - 0.2);
      var_9.y = level.credits_spacing;
      var_14 thread delaydestroy(level.credits_speed);
      var_14 moveovertime(level.credits_speed);
      var_14 thread delayfade(level.credits_speed);
      var_14.y = level.credits_spacing;
    } else if(var_3 == "centername") {
      var_7 = level.linelist[var_1].name;
      var_5 = level.linelist[var_1].textscale;
      var_6 = newhudelem();
      var_6 settext(var_7);
      var_6.alignx = "left";
      var_6.horzalign = "center";
      var_6.x = 8;
      var_6.y = 480;

      if(!level.console)
        var_6.font = "default";
      else
        var_6.font = "small";

      var_6.fontscale = var_5;
      var_6.sort = 2;
      var_6.glowcolor = (0.3, 0.6, 0.3);
      var_6.glowalpha = 1;
      var_6 thread delaydestroy(level.credits_speed);
      var_6 moveovertime(level.credits_speed);
      var_6.y = level.credits_spacing;
    } else if(var_3 == "centernamedouble") {
      var_11 = level.linelist[var_1].name1;
      var_12 = level.linelist[var_1].name2;
      var_5 = level.linelist[var_1].textscale;
      var_8 = newhudelem();
      var_8 settext(var_11);
      var_8.alignx = "center";
      var_8.horzalign = "center";
      var_8.x = -80;
      var_8.y = 480;

      if(!level.console)
        var_8.font = "default";
      else
        var_8.font = "small";

      var_8.fontscale = var_5;
      var_8.sort = 2;
      var_8.glowcolor = (0.3, 0.6, 0.3);
      var_8.glowalpha = 1;
      var_9 = newhudelem();
      var_9 settext(var_12);
      var_9.alignx = "center";
      var_9.horzalign = "center";
      var_9.x = 80;
      var_9.y = 480;

      if(!level.console)
        var_9.font = "default";
      else
        var_9.font = "small";

      var_9.fontscale = var_5;
      var_9.sort = 2;
      var_9.glowcolor = (0.3, 0.6, 0.3);
      var_9.glowalpha = 1;
      var_8 thread delaydestroy(level.credits_speed);
      var_8 moveovertime(level.credits_speed);
      var_8.y = level.credits_spacing;
      var_9 thread delaydestroy(level.credits_speed);
      var_9 moveovertime(level.credits_speed);
      var_9.y = level.credits_spacing;
    } else if(var_3 == "spacesmall")
      var_2 = 0.25;
    else {}

    wait(var_2 * (level.credits_speed / 22.5));
  }
}

delayfade(var_0) {
  wait(var_0 - 7);
  self fadeovertime(1.5);
  self.alpha = 0;
}

delaydestroy(var_0) {
  wait(var_0 - 2);
  self destroy();
}

pulse_fx() {
  self.alpha = 0;
  wait(level.credits_speed * 0.08);
  self fadeovertime(0.2);
  self.alpha = 1;
  self setpulsefx(50, int(level.credits_speed * 0.6 * 1000), 500);
}

addgap() {
  addspace();
  addspace();
}

readncolumns(var_0, var_1, var_2, var_3) {
  var_4 = [];

  for(var_5 = 0; var_5 < var_3; var_5++)
    var_4[var_5] = tablelookupbyrow(var_0, var_1, var_2 + var_5);

  return var_4;
}

readtriple(var_0, var_1, var_2) {
  var_3[0] = tablelookupbyrow(var_0, var_1, var_2);
  var_3[1] = tablelookupbyrow(var_0, var_1, var_2 + 1);
  var_3[2] = tablelookupbyrow(var_0, var_1, var_2 + 2);
  return var_3;
}