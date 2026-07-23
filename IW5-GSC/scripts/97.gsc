/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\97.gsc
**************************************/

init() {
  maps\_hud::init();
  precachestring(&"RANK_PLAYER_WAS_PROMOTED_N");
  precachestring(&"RANK_PLAYER_WAS_PROMOTED");
  precachestring(&"RANK_PROMOTED");
  precachestring(&"RANK_ROMANI");
  precachestring(&"RANK_ROMANII");
  precachestring(&"RANK_ROMANIII");
  precachestring(&"SCRIPT_PLUS");
  precacheshader("line_horizontal");
  precacheshader("line_vertical");
  precacheshader("gradient_fadein");
  precacheshader("white");
  level.maxrank = int(tablelookup("sp/rankTable.csv", 0, "maxrank", 1));
  level.maxxp = int(tablelookup("sp/rankTable.csv", 0, level.maxrank, 7));
  var_0 = 0;

  for(var_0 = 0; var_0 <= level.maxrank; var_0++) {
    precacheshader(tablelookup("sp/rankTable.csv", 0, var_0, 6));
  }
  var_1 = 0;

  for(var_2 = tablelookup("sp/ranktable.csv", 0, var_1, 1); isDefined(var_2) && var_2 != ""; var_2 = tablelookup("sp/ranktable.csv", 0, var_1, 1)) {
    level.ranktable[var_1][1] = tablelookup("sp/ranktable.csv", 0, var_1, 1);
    level.ranktable[var_1][2] = tablelookup("sp/ranktable.csv", 0, var_1, 2);
    level.ranktable[var_1][3] = tablelookup("sp/ranktable.csv", 0, var_1, 3);
    level.ranktable[var_1][7] = tablelookup("sp/ranktable.csv", 0, var_1, 7);
    precachestring(tablelookupistring("sp/ranktable.csv", 0, var_1, 10));
    var_1++;
  }

  maps\_missions::buildchallengeinfo();
}

xp_init() {
  xp_setup();

  foreach(var_1 in level.players) {
    var_1 thread xp_player_init();
    var_1 thread maps\_missions::updatechallenges();
  }
}

xp_player_init() {
  if(!isDefined(self.summary)) {
    self.summary["rankxp"] = self getplayerdata("experience");
    self.summary["rank"] = getrankforxp(self.summary["rankxp"]);
  }

  update_rank_into_profile();
  self.rankupdatetotal = 0;
  self.hud_rankscroreupdate = newclienthudelem(self);
  self.hud_rankscroreupdate.horzalign = "center";
  self.hud_rankscroreupdate.vertalign = "middle";
  self.hud_rankscroreupdate.alignx = "center";
  self.hud_rankscroreupdate.aligny = "middle";
  self.hud_rankscroreupdate.x = 0;
  self.hud_rankscroreupdate.y = -60;
  self.hud_rankscroreupdate.font = "hudbig";
  self.hud_rankscroreupdate.fontscale = 0.75;
  self.hud_rankscroreupdate.archived = 0;
  self.hud_rankscroreupdate.color = (0.75, 1, 0.75);
  self.hud_rankscroreupdate fontpulseinit();
}

update_rank_into_profile() {
  var_0 = self getlocalplayerprofiledata("percentCompleteSO");
  var_1 = int(var_0 / 100);
  var_2 = getrank();
  var_3 = var_2 + var_1 * 100;
  self setlocalplayerprofiledata("percentCompleteSO", var_3);
}

xp_bar_client_elem(var_0) {
  var_1 = newclienthudelem(var_0);
  var_1.x = hud_width_format() / 2 * -1;
  var_1.y = 0;
  var_1.sort = 5;
  var_1.horzalign = "center_adjustable";
  var_1.vertalign = "bottom_adjustable";
  var_1.alignx = "left";
  var_1.aligny = "bottom";
  var_1 setshader("gradient_fadein", get_xpbarwidth(), 4);
  var_1.color = (1, 0.8, 0.4);
  var_1.alpha = 0.65;
  var_1.foreground = 1;
  return var_1;
}

hud_width_format() {
  if(issplitscreen()) {
    return 726;
  } else {
    return 540;
  }
}

xpbar_update() {
  if(!get_xpbarwidth()) {
    self.hud_xpbar.alpha = 0;
  } else {
    self.hud_xpbar.alpha = 0.65;
  }
  self.hud_xpbar setshader("gradient_fadein", get_xpbarwidth(), 4);
}

get_xpbarwidth() {
  var_0 = int(tablelookup("sp/rankTable.csv", 0, self.summary["rank"], 3));
  var_1 = int(self.summary["rankxp"] - int(tablelookup("sp/rankTable.csv", 0, self.summary["rank"], 2)));
  var_2 = hud_width_format();
  var_3 = int(var_2 * (var_1 / var_0));
  return var_3;
}

xp_setup() {
  if(!isDefined(level.scoreinfo) || !isDefined(level.scoreinfo.size)) {
    level.scoreinfo = [];
  }
  level.xpscale = 1;

  if(level.console) {
    level.xpscale = 1;
  }
  registerscoreinfo("kill", 100);
  registerscoreinfo("headshot", 100);
  registerscoreinfo("assist", 20);
  registerscoreinfo("suicide", 0);
  registerscoreinfo("teamkill", 0);
  registerscoreinfo("completion_xp", 5000);
  level notify("rank_score_info_defaults_set");
}

givexp_think() {
  self waittill("death", var_0, var_1, var_2);

  if(isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "worldspawn" && isDefined(self.last_dmg_player)) {
    var_0 = self.last_dmg_player;
  }
  givexp_helper(var_0);
}

givexp_helper(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isai(var_0) && var_0 isbadguy()) {
    return;
  }
  if(is_special_targetname_attacker(var_0)) {
    if(isDefined(var_0.attacker)) {
      thread givexp_helper(var_0.attacker);
      return;
    }

    if(isDefined(var_0.damageowner)) {
      thread givexp_helper(var_0.damageowner);
      return;
    }
  }

  if(isPlayer(var_0)) {
    if(isDefined(level.givexp_kill_func)) {
      var_0 thread[[level.givexp_kill_func]](self);
    } else {
      var_0 thread maps\_utility::givexp("kill");
    }
  }

  if(maps\_utility::is_survival()) {
    if(isai(var_0) && !var_0 isbadguy() && isDefined(var_0.owner) && isPlayer(var_0.owner)) {
      if(isDefined(level.givexp_kill_func)) {
        var_0.owner thread[[level.givexp_kill_func]](self);
      } else {
        var_0.owner thread maps\_utility::givexp("kill");
      }
    }
  }

  if(!isPlayer(var_0) && !isai(var_0)) {
    return;
  }
  if(!var_0 isbadguy() && isDefined(self.attacker_list) && self.attacker_list.size) {
    for(var_1 = 0; var_1 < self.attacker_list.size; var_1++) {
      if(isPlayer(self.attacker_list[var_1]) && self.attacker_list[var_1] != var_0) {
        if(isDefined(self.kill_assist_xp)) {
          self.attacker_list[var_1] thread maps\_utility::givexp("assist", self.kill_assist_xp);
          continue;
        }

        self.attacker_list[var_1] thread maps\_utility::givexp("assist");
      }
    }
  }
}

is_special_targetname_attacker(var_0) {
  if(!isDefined(var_0.targetname)) {
    return 0;
  }
  if(issubstr(var_0.targetname, "destructible")) {
    return 1;
  }
  if(common_scripts\utility::string_starts_with(var_0.targetname, "sentry_")) {
    return 1;
  }
  return 0;
}

ai_xp_init() {
  thread givexp_think();
  self.attacker_list = [];
  self.last_attacked = 0;
  maps\_utility::add_damage_function(::xp_took_damage);
}

xp_took_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  var_7 = gettime();
  var_8 = var_7 - self.last_attacked;

  if(var_8 <= 10000) {
    self.attacker_list = common_scripts\utility::array_remove(self.attacker_list, var_1);
    self.attacker_list[self.attacker_list.size] = var_1;
    self.last_attacked = gettime();
    return;
  }

  self.attacker_list = [];
  self.attacker_list[0] = var_1;
  self.last_attacked = gettime();
}

updateplayerscore(var_0, var_1) {
  if(!isDefined(level.xp_enable) || !level.xp_enable) {
    return;
  }
  if(!isDefined(var_1)) {
    if(isDefined(level.scoreinfo[var_0])) {
      var_1 = getscoreinfovalue(var_0);
    } else {
      var_1 = getscoreinfovalue("kill");
    }
  }

  var_1 = int(var_1 * level.xpscale);

  if(var_0 == "assist") {
    if(var_1 > getscoreinfovalue("kill")) {
      var_1 = getscoreinfovalue("kill");
    }
  }

  thread print_score_increment(var_1);
  self.summary["rankxp"] = self.summary["rankxp"] + var_1;

  if(updaterank()) {
    thread updaterankannouncehud();
    update_rank_into_profile();
  }

  if(self.summary["rankxp"] <= level.maxxp) {
    self setplayerdata("experience", self.summary["rankxp"]);
  }
  if(self.summary["rankxp"] > level.maxxp) {
    self setplayerdata("experience", level.maxxp);
  }
  waittillframeend;
  self notify("xp_updated", var_0);
}

print_score_increment(var_0) {
  self notify("update_xp");
  self endon("update_xp");
  self.rankupdatetotal = self.rankupdatetotal + var_0;
  self.hud_rankscroreupdate.label = &"SCRIPT_PLUS";
  self.hud_rankscroreupdate setvalue(self.rankupdatetotal);
  self.hud_rankscroreupdate.alpha = 0.75;
  self.hud_rankscroreupdate thread fontpulse(self);
  self.hud_rankscroreupdate.x = 0;
  self.hud_rankscroreupdate.y = -60;
  wait 1;
  self.hud_rankscroreupdate fadeovertime(0.2);
  self.hud_rankscroreupdate.alpha = 0;
  self.hud_rankscroreupdate moveovertime(0.2);
  self.hud_rankscroreupdate.x = -240;
  self.hud_rankscroreupdate.y = 160;
  wait 0.5;
  self.hud_rankscroreupdate.x = 0;
  self.hud_rankscroreupdate.y = -60;
  self.rankupdatetotal = 0;
}

fontpulseinit() {
  self.basefontscale = self.fontscale;
  self.maxfontscale = self.fontscale * 2;
  self.inframes = 3;
  self.outframes = 5;
}

fontpulse(var_0) {
  self notify("fontPulse");
  self endon("fontPulse");
  var_1 = self.maxfontscale - self.basefontscale;

  while(self.fontscale < self.maxfontscale) {
    self.fontscale = min(self.maxfontscale, self.fontscale + var_1 / self.inframes);
    wait 0.05;
  }

  while(self.fontscale > self.basefontscale) {
    self.fontscale = max(self.basefontscale, self.fontscale - var_1 / self.outframes);
    wait 0.05;
  }
}

updaterank() {
  var_0 = getrank();

  if(var_0 == self.summary["rank"]) {
    return 0;
  }
  var_1 = self.summary["rank"];
  var_2 = self.summary["rank"];

  for(self.summary["rank"] = var_0; var_2 <= var_0; var_2++) {
    self.setpromotion = 1;
  }
  return 1;
}

updaterankannouncehud() {
  self endon("disconnect");
  self notify("update_rank");
  self endon("update_rank");
  self notify("reset_outcome");
  var_0 = getrankinfofull(self.summary["rank"]);
  var_1 = spawnStruct();
  var_1.titletext = &"RANK_PROMOTED";
  var_1.iconname = getrankinfoicon(self.summary["rank"]);
  var_1.sound = "sp_level_up";
  var_1.duration = 4.0;
  var_2 = level.ranktable[self.summary["rank"]][1];
  var_3 = int(var_2[var_2.size - 1]);
  var_1.notifytext = var_0;

  if(common_scripts\utility::flag_exist("special_op_final_xp_given") && common_scripts\utility::flag("special_op_final_xp_given")) {
    level.eog_summary_delay = int(max(0, var_1.duration - 2));
  }
  thread notifymessage(var_1);

  if(var_3 > 1) {
    return;
  }
}

notifymessage(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = 4;

  while(self.doingnotify && var_1 > 0) {
    var_1 = var_1 - 0.5;
    wait 0.5;
  }

  thread shownotifymessage(var_0);
}

stringtofloat(var_0) {
  var_1 = strtok(var_0, ".");
  var_2 = int(var_1[0]);

  if(isDefined(var_1[1])) {
    var_3 = 1;

    for(var_4 = 0; var_4 < var_1[1].size; var_4++) {
      var_3 = var_3 * 0.1;
    }
    var_2 = var_2 + int(var_1[1]) * var_3;
  }

  return var_2;
}

actionnotifymessage(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = var_0.slot;

  if(tablelookup("sp/splashTable.csv", 0, var_0.name, 0) != "") {
    if(isDefined(var_0.optionalnumber)) {
      self showhudsplash(var_0.name, var_0.slot, var_0.optionalnumber);
    } else {
      self showhudsplash(var_0.name, var_0.slot);
    }
    self.doingsplash[var_1] = var_0;
    var_2 = stringtofloat(tablelookup("sp/splashTable.csv", 0, var_0.name, 4));

    if(isDefined(var_0.sound)) {
      self playlocalsound(var_0.sound);
    }
    self notify("actionNotifyMessage" + var_1);
    self endon("actionNotifyMessage" + var_1);
    wait(var_2 - 0.05);
    self.doingsplash[var_1] = undefined;
  }

  if(self.splashqueue[var_1].size) {
    thread dispatchnotify(var_1);
  }
}

removetypefromqueue(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < self.splashqueue[var_1].size; var_3++) {
    if(self.splashqueue[var_1][var_3].type != "killstreak") {
      var_2[var_2.size] = self.splashqueue[var_1][var_3];
    }
  }

  self.splashqueue[var_1] = var_2;
}

actionnotify(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = var_0.slot;

  if(!isDefined(var_0.type)) {
    var_0.type = "";
  }
  if(!isDefined(self.doingsplash[var_1])) {
    thread actionnotifymessage(var_0);
    return;
  } else if(var_0.type == "killstreak" && self.doingsplash[var_1].type != "challenge" && self.doingsplash[var_1].type != "rank") {
    self.notifytext.alpha = 0;
    self.notifytext2.alpha = 0;
    self.notifyicon.alpha = 0;
    thread actionnotifymessage(var_0);
    return;
  } else if(var_0.type == "challenge" && self.doingsplash[var_1].type != "killstreak" && self.doingsplash[var_1].type != "challenge" && self.doingsplash[var_1].type != "rank") {
    self.notifytext.alpha = 0;
    self.notifytext2.alpha = 0;
    self.notifyicon.alpha = 0;
    thread actionnotifymessage(var_0);
    return;
  }

  if(var_0.type == "challenge" || var_0.type == "killstreak") {
    if(var_0.type == "killstreak") {
      removetypefromqueue("killstreak", var_1);
    }
    for(var_2 = self.splashqueue[var_1].size; var_2 > 0; var_2--) {
      self.splashqueue[var_1][var_2] = self.splashqueue[var_1][var_2 - 1];
    }
    self.splashqueue[var_1][0] = var_0;
  } else {
    self.splashqueue[var_1][self.splashqueue[var_1].size] = var_0;
  }
}

shownotifymessage(var_0) {
  self endon("disconnect");
  self.doingnotify = 1;
  waitrequirevisibility(0);

  if(isDefined(var_0.duration)) {
    var_1 = var_0.duration;
  } else {
    var_1 = 4.0;
  }
  thread resetoncancel();

  if(isDefined(var_0.sound)) {
    self playlocalsound(var_0.sound);
  }
  if(isDefined(var_0.glowcolor)) {
    var_2 = var_0.glowcolor;
  } else {
    var_2 = (0.3, 0.6, 0.3);
  }
  var_3 = self.notifytitle;

  if(isDefined(var_0.titletext)) {
    if(isDefined(var_0.titlelabel)) {
      self.notifytitle.label = var_0.titlelabel;
    } else {
      self.notifytitle.label = &"";
    }
    if(isDefined(var_0.titlelabel) && !isDefined(var_0.titleisstring)) {
      self.notifytitle setvalue(var_0.titletext);
    } else {
      self.notifytitle settext(var_0.titletext);
    }
    self.notifytitle setpulsefx(100, int(var_1 * 1000), 1000);
    self.notifytitle.glowcolor = var_2;
    self.notifytitle.alpha = 1;
  }

  if(isDefined(var_0.notifytext)) {
    if(isDefined(var_0.textlabel)) {
      self.notifytext.label = var_0.textlabel;
    } else {
      self.notifytext.label = &"";
    }
    if(isDefined(var_0.textlabel) && !isDefined(var_0.textisstring)) {
      self.notifytext setvalue(var_0.notifytext);
    } else {
      self.notifytext settext(var_0.notifytext);
    }
    self.notifytext setpulsefx(100, int(var_1 * 1000), 1000);
    self.notifytext.glowcolor = var_2;
    self.notifytext.alpha = 1;
    var_3 = self.notifytext;
  }

  if(isDefined(var_0.notifytext2)) {
    self.notifytext2 maps\_hud_util::setparent(var_3);

    if(isDefined(var_0.text2label)) {
      self.notifytext2.label = var_0.text2label;
    } else {
      self.notifytext2.label = &"";
    }
    self.notifytext2 settext(var_0.notifytext2);
    self.notifytext2 setpulsefx(100, int(var_1 * 1000), 1000);
    self.notifytext2.glowcolor = var_2;
    self.notifytext2.alpha = 1;
    var_3 = self.notifytext2;
  }

  if(isDefined(var_0.iconname)) {
    self.notifyicon maps\_hud_util::setparent(var_3);
    self.notifyicon setshader(var_0.iconname, 60, 60);
    self.notifyicon.alpha = 0;
    self.notifyicon fadeovertime(1.0);
    self.notifyicon.alpha = 1;
    waitrequirevisibility(var_1);
    self.notifyicon fadeovertime(0.75);
    self.notifyicon.alpha = 0;
  } else {
    waitrequirevisibility(var_1);
  }
  self notify("notifyMessageDone");
  self.doingnotify = 0;
}

resetoncancel() {
  self notify("resetOnCancel");
  self endon("resetOnCancel");
  self endon("notifyMessageDone");
  self endon("disconnect");
  level waittill("cancel_notify");
  self.notifytitle.alpha = 0;
  self.notifytext.alpha = 0;
  self.notifyicon.alpha = 0;
  self.doingnotify = 0;
}

waitrequirevisibility(var_0) {
  var_1 = 0.05;

  while(!canreadtext()) {
    wait(var_1);
  }
  while(var_0 > 0) {
    wait(var_1);

    if(canreadtext()) {
      var_0 = var_0 - var_1;
    }
  }
}

canreadtext() {
  if(isflashbanged()) {
    return 0;
  }
  return 1;
}

isflashbanged() {
  return isDefined(self.flashendtime) && gettime() < self.flashendtime;
}

dispatchnotify(var_0) {
  var_1 = self.splashqueue[var_0][0];

  for(var_2 = 1; var_2 < self.splashqueue[var_0].size; var_2++) {
    self.splashqueue[var_0][var_2 - 1] = self.splashqueue[var_0][var_2];
  }
  self.splashqueue[var_0][var_2 - 1] = undefined;

  if(isDefined(var_1.name)) {
    actionnotify(var_1);
  } else {
    shownotifymessage(var_1);
  }
}

registerscoreinfo(var_0, var_1) {
  level.scoreinfo[var_0]["value"] = var_1;
}

getscoreinfovalue(var_0) {
  return level.scoreinfo[var_0]["value"];
}

getrankinfominxp(var_0) {
  return int(level.ranktable[var_0][2]);
}

getrankinfoxpamt(var_0) {
  return int(level.ranktable[var_0][3]);
}

getrankinfomaxxp(var_0) {
  return int(level.ranktable[var_0][7]);
}

getrankinfofull(var_0) {
  return tablelookupistring("sp/ranktable.csv", 0, var_0, 5);
}

getrankinfoicon(var_0) {
  return tablelookup("sp/rankTable.csv", 0, var_0, 6);
}

getrank() {
  var_0 = self.summary["rankxp"];
  var_1 = self.summary["rank"];

  if(var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1)) {
    return var_1;
  } else {
    return getrankforxp(var_0);
  }
}

getrankforxp(var_0) {
  var_1 = 0;
  var_2 = level.ranktable[var_1][1];

  while(isDefined(var_2) && var_2 != "") {
    if(var_0 < getrankinfominxp(var_1) + getrankinfoxpamt(var_1)) {
      return var_1;
    }
    var_1++;

    if(isDefined(level.ranktable[var_1])) {
      var_2 = level.ranktable[var_1][1];
      continue;
    }

    var_2 = undefined;
  }

  var_1--;
  return var_1;
}

getrankxp() {
  return self getplayerdata("experience");
}