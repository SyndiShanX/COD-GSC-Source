/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\swim_sp.gsc
**************************************/

#using scripts\common\swim_common;
#using scripts\engine\utility;
#using scripts\sp\player_death;
#using scripts\stealth\manager;
#using scripts\stealth\utility;
#namespace swim_sp;

function main() {
  swim_common::initcommonswim(&getbreathtime, &function_9f17d7d885002765, &function_5956816577b1f3ec, &enterfunc, &exitfunc, &surfacefunc, &descendfunc, &playsoundfunc, &visionsetfunc, &drownfunc, &function_dd44b9ee2a91cdad, &function_4f670d7be85ddac5);
}

function function_62e0856d3e744483() {
  thread swim_common::function_a2cac299a4437dfc();

  if(isDefined(level.swimweaponoverride)) {
    swimweapon = level.swimweaponoverride;
  } else if(isDefined(self.swimweapon)) {
    swimweapon = self.swimweapon;
  } else {
    swimweapon = "\xae\x1e\xfb\x05\xcf\xf2\xb1VDs\xc2\x96I\xfd\xfc\x8dC\x1bF\x05:U \x05r\fP#77$\xff";
  }

  self giveweapon(swimweapon);
}

function getbreathtime() {
  if(self isswimsprinting()) {
    return self.gs.swimsprintbreathtime;
  }

  return self.gs.swimbreathtime;
}

function function_9f17d7d885002765() {
  if(self isswimsprinting()) {
    return self.gs.swimbreathtimecritsprint;
  }

  return self.gs.swimbreathtimecrit;
}

function function_5956816577b1f3ec() {
  return self.gs.swimbreathfilltime;
}

function surfacefunc() {
  if(utility::flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
    function_e999de734b5128f6();
  }

  if(isDefined(level.var_6e3ce34ae24f347b)) {
    thread[[level.var_6e3ce34ae24f347b]]();
  }

  if(isDefined(level.var_23faf68bec2859b4)) {
    foreach(func in level.var_23faf68bec2859b4) {
      thread[[func]]();
    }
  }
}

function function_d52016582dfb963e(callbackfunc) {
  if(!isDefined(level.var_23faf68bec2859b4)) {
    level.var_23faf68bec2859b4 = [];
  }

  level.var_23faf68bec2859b4[level.var_23faf68bec2859b4.size] = callbackfunc;
}

function descendfunc() {
  if(utility::flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
    function_8e941be078bc4c0b();
  }

  if(isDefined(level.var_45f6c952439f519e)) {
    thread[[level.var_45f6c952439f519e]]();
  }

  if(isDefined(level.var_fd7bd4505d1c9c3b)) {
    foreach(func in level.var_fd7bd4505d1c9c3b) {
      thread[[func]]();
    }
  }
}

function function_fda60b40ae0b69a7(callbackfunc) {
  if(!isDefined(level.var_fd7bd4505d1c9c3b)) {
    level.var_fd7bd4505d1c9c3b = [];
  }

  level.var_fd7bd4505d1c9c3b[level.var_fd7bd4505d1c9c3b.size] = callbackfunc;
}

function enterfunc() {
  if(isDefined(level.var_30463196b20b32ff)) {
    thread[[level.var_30463196b20b32ff]]();
  }
}

function exitfunc() {
  if(isDefined(level.var_bfbdd5f1fc27fbdf)) {
    thread[[level.var_bfbdd5f1fc27fbdf]]();
  }
}

function playsoundfunc(firstpersonalias, thirdpersonalias, soundsource) {
  if(soundexists(firstpersonalias)) {
    self playlocalsound(firstpersonalias);
  }
}

function visionsetfunc(visionset, transitiontime) {
  visionsetnaked(visionset, transitiontime);

  if(isDefined(level.var_e2f6732954e5d89b)) {
    thread[[level.var_e2f6732954e5d89b]](visionset, transitiontime);
  }
}

function drownfunc() {
  player_death::set_custom_death_quote(%"hash_6b64ae1633b04d51");
}

function function_dd44b9ee2a91cdad() {
  if(isDefined(level.var_d2fdf5c97cfeb6a8)) {
    return [[level.var_d2fdf5c97cfeb6a8]]();
  }

  return self function_4c7e1ca27f66e544();
}

function function_8e941be078bc4c0b() {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  level notify("S9\xdd\x90w\x9c\xff\xe1\v\xffH\xc6\xeb\xfc\x8c\x81\xe6u\xc2Vp@\xb4\xb3");
  level endon("S9\xdd\x90w\x9c\xff\xe1\v\xffH\xc6\xeb\xfc\x8c\x81\xe6u\xc2Vp@\xb4\xb3");
  hiddenranges["GX\xa9]\x82"] = 30;
  hiddenranges["1x\xc5\xb4\xabx"] = 50;
  hiddenranges["\x8b\x90\xb5\xc4W"] = 100;
  var_f9a61b13db1e8a45["GX\xa9]\x82"] = 10;
  var_f9a61b13db1e8a45["1x\xc5\xb4\xabx"] = 25;
  var_f9a61b13db1e8a45["\x8b\x90\xb5\xc4W"] = 75;
  hiddenranges["\xb5\"\xd8\x81.b\x91x\\\x83Fv"] = 0.05;
  hiddenranges["\xf1\a\x1e \x9e\x96K\x17\x0e$\xe3\x1el"] = 0.05;
  hiddenranges["\xe6\r\xc2F\xed\xdd\xafnt\xc2n\x19"] = 0.3;
  spottedranges["GX\xa9]\x82"] = 100;
  spottedranges["1x\xc5\xb4\xabx"] = 200;
  spottedranges["\x8b\x90\xb5\xc4W"] = 400;
  var_5a15e626a4acffe8["GX\xa9]\x82"] = 75;
  var_5a15e626a4acffe8["1x\xc5\xb4\xabx"] = 150;
  var_5a15e626a4acffe8["\x8b\x90\xb5\xc4W"] = 350;
  spottedranges["\xb5\"\xd8\x81.b\x91x\\\x83Fv"] = 0.01;
  spottedranges["\xf1\a\x1e \x9e\x96K\x17\x0e$\xe3\x1el"] = 0.02;
  spottedranges["\xe6\r\xc2F\xed\xdd\xafnt\xc2n\x19"] = 0.38;
  var_f97d3de51b453da["GX\xa9]\x82"] = 0;
  var_f97d3de51b453da["1x\xc5\xb4\xabx"] = 0;
  var_f97d3de51b453da["\x8b\x90\xb5\xc4W"] = 0;
  var_a50aa01bbfea17d5["GX\xa9]\x82"] = 0;
  var_a50aa01bbfea17d5["1x\xc5\xb4\xabx"] = 0;
  var_a50aa01bbfea17d5["\x8b\x90\xb5\xc4W"] = 0;
  utility::set_detect_ranges(hiddenranges, spottedranges);
  utility::set_min_detect_range_darkness(var_f9a61b13db1e8a45, var_5a15e626a4acffe8);
  utility::function_45380219f0ec11c0(var_f97d3de51b453da, var_a50aa01bbfea17d5);
}

function function_e999de734b5128f6() {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  level notify("S9\xdd\x90w\x9c\xff\xe1\v\xffH\xc6\xeb\xfc\x8c\x81\xe6u\xc2Vp@\xb4\xb3");
  level endon("S9\xdd\x90w\x9c\xff\xe1\v\xffH\xc6\xeb\xfc\x8c\x81\xe6u\xc2Vp@\xb4\xb3");
  hiddenranges["GX\xa9]\x82"] = 400;
  hiddenranges["1x\xc5\xb4\xabx"] = 700;
  hiddenranges["\x8b\x90\xb5\xc4W"] = 950;
  var_f9a61b13db1e8a45["GX\xa9]\x82"] = 150;
  var_f9a61b13db1e8a45["1x\xc5\xb4\xabx"] = 350;
  var_f9a61b13db1e8a45["\x8b\x90\xb5\xc4W"] = 600;
  hiddenranges["\xb5\"\xd8\x81.b\x91x\\\x83Fv"] = 0.05;
  hiddenranges["\xf1\a\x1e \x9e\x96K\x17\x0e$\xe3\x1el"] = 0.05;
  hiddenranges["\xe6\r\xc2F\xed\xdd\xafnt\xc2n\x19"] = 0.3;
  spottedranges["GX\xa9]\x82"] = 500;
  spottedranges["1x\xc5\xb4\xabx"] = 1600;
  spottedranges["\x8b\x90\xb5\xc4W"] = 2150;
  var_5a15e626a4acffe8["GX\xa9]\x82"] = 250;
  var_5a15e626a4acffe8["1x\xc5\xb4\xabx"] = 1000;
  var_5a15e626a4acffe8["\x8b\x90\xb5\xc4W"] = 1800;
  spottedranges["\xb5\"\xd8\x81.b\x91x\\\x83Fv"] = 0.01;
  spottedranges["\xf1\a\x1e \x9e\x96K\x17\x0e$\xe3\x1el"] = 0.02;
  spottedranges["\xe6\r\xc2F\xed\xdd\xafnt\xc2n\x19"] = 0.38;
  var_f97d3de51b453da["GX\xa9]\x82"] = 0;
  var_f97d3de51b453da["1x\xc5\xb4\xabx"] = 0;
  var_f97d3de51b453da["\x8b\x90\xb5\xc4W"] = 0;
  var_a50aa01bbfea17d5["GX\xa9]\x82"] = 0;
  var_a50aa01bbfea17d5["1x\xc5\xb4\xabx"] = 0;
  var_a50aa01bbfea17d5["\x8b\x90\xb5\xc4W"] = 0;
  utility::set_detect_ranges(hiddenranges, spottedranges);
  utility::set_min_detect_range_darkness(var_f9a61b13db1e8a45, var_5a15e626a4acffe8);
  utility::function_45380219f0ec11c0(var_f97d3de51b453da, var_a50aa01bbfea17d5);
  event_distances["\x1f\x93?pK+\x9c"]["+\x1e\x1c\xd8\xbds\xd2{\xb9"] = 2500;
  event_distances["\xf8VZW\xd3\xad"]["+\x1e\x1c\xd8\xbds\xd2{\xb9"] = 2500;
  event_distances["\x1f\x93?pK+\x9c"]["\xa3^6\xd74#\xbd"] = 2500;
  event_distances["\xf8VZW\xd3\xad"]["\xa3^6\xd74#\xbd"] = 2500;
  event_distances["\x1f\x93?pK+\x9c"]["3\xdb\xb7tn:\x95\xe0"] = 200;
  event_distances["\xf8VZW\xd3\xad"]["3\xdb\xb7tn:\x95\xe0"] = 200;
  event_distances["\x1f\x93?pK+\x9c"]["]\xa0\xfb\x14$N\xda\xdb\x06\x0e\x1a\x99\x01"] = 100;
  event_distances["\xf8VZW\xd3\xad"]["]\xa0\xfb\x14$N\xda\xdb\x06\x0e\x1a\x99\x01"] = 100;
  event_distances["\x1f\x93?pK+\x9c"]["\x82\xe4/D\x10Z\x7f\x11\x031\x94:\xddY>"] = 500;
  event_distances["\xf8VZW\xd3\xad"]["\x82\xe4/D\x10Z\x7f\x11\x031\x94:\xddY>"] = 500;
  stealth_manager::set_event_distances(event_distances);
}

function function_4f670d7be85ddac5(vfx, notify_kill, timeout) {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  view_model = self getviewmodel();

  if(!isDefined(view_model) || view_model == "") {
    iprintlnbold("<dev string:x24>" + self getentitynumber() + "<dev string:x4b>");

    return;
  }

  if(!utility::hastag(view_model, "\xf0p\x16\xfaR\xa4T\xcd")) {
    iprintlnbold("<dev string:x66>" + view_model + "<dev string:x8c>");

    return;
  }

  var_96cf6ab84a52912 = utility::spawn_tag_origin();
  var_96cf6ab84a52912 linktoplayerview(self, "\xf0p\x16\xfaR\xa4T\xcd");
  playfxontagforclients(level._effect[vfx], var_96cf6ab84a52912, "\xec\xbfK|\au\xcd\xc2\x19<", self);

  if(isDefined(notify_kill)) {
    swim_common::function_274c13c5762302f0(notify_kill, "\x1e\xfd\xd1\xa2\a", timeout);
    killfxontag(level._effect[vfx], var_96cf6ab84a52912, "\xec\xbfK|\au\xcd\xc2\x19<");
    var_96cf6ab84a52912 delete();
  }
}