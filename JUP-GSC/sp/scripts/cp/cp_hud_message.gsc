/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_hud_message.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_hud_util;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_hud_message;

function init_cp_hud_message() {
  level.var_4cd98c0c1064cfc0 = [];
  level thread onplayerconnect_cphudmessage();
  level.showerrormessagefunc = &showerrormessage;
}

function onplayerconnect_cphudmessage() {
  for(;;) {
    level waittill("connected", player);
    player thread hintmessagedeaththink();
    player thread lowermessagethink();
    player thread splashshownthink();
  }
}

function showkillstreaksplash(splashref, streakval, var_38ecfeb60187e7d3) {
  if(!isPlayer(self)) {
    return;
  }

  actiondata = spawnStruct();

  if(isDefined(var_38ecfeb60187e7d3)) {
    splashref += "_" + var_38ecfeb60187e7d3;
  }

  showsplash(splashref, streakval);
}

function showchallengesplash(challengeref, tieroverride) {
  challengestate = undefined;

  if(isDefined(tieroverride)) {
    challengestate = tieroverride;
  } else {
    challengestate = mt_getstate(challengeref) - 1;
  }

  displayparam = level.meritinfo[challengeref]["displayParam"];

  if(!isDefined(displayparam)) {
    displayparam = mt_gettarget(challengeref, challengestate);

    if(displayparam == 0) {
      displayparam = 1;
    }

    paramscale = level.meritinfo[challengeref]["paramScale"];

    if(isDefined(paramscale)) {
      displayparam = int(displayparam / paramscale);
    }
  }

  thread showsplash(challengeref, displayparam);
}

function showsplash(ref, optionalnumber, playerforplayercard, altdisplayindex, var_ef4849b4cb3ac7e2, splashlistoverride) {
  if(isDefined(self.recentsplashcount) && self.recentsplashcount >= 6) {
    queuesplash(ref, optionalnumber, playerforplayercard, splashlistoverride);
    return;
  }

  showsplashinternal(ref, optionalnumber, playerforplayercard, splashlistoverride);
}

function showsplashinternal(ref, optionalnumber, playerforplayercard, splashlistoverride) {
  if(!isPlayer(self)) {
    return;
  }

  isscriptbundlesplash = 0;
  splashid = tablelookuprownum(getsplashtablename(), 0, ref);

  if(!isDefined(splashid) || splashid < 0) {
    splashid = function_73baf095c3b9cce6(ref, splashlistoverride);
    isscriptbundlesplash = 1;
  }

  if(!isDefined(splashid) || splashid < 0) {
    return;
  }

  assertex(splashid < (2047 ^ 4095), "ui_splash_id_X is too small to store all splashes. Increase the size of the omnvar.");

  if(!isDefined(self.nextsplashlistindex)) {
    self.nextsplashlistindex = 0;
  }

  if(!isDefined(self.splashlisttoggle)) {
    self.splashlisttoggle = 1;
  }

  omnvarvalue = splashid;

  if(self.splashlisttoggle) {
    omnvarvalue |= 2047 ^ 4095;
  }

  if(isDefined(optionalnumber)) {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, optionalnumber);
  } else {
    self setclientomnvar("ui_player_splash_param_" + self.nextsplashlistindex, -1);
  }

  if(isDefined(playerforplayercard)) {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, playerforplayercard getentitynumber());
  } else {
    self setclientomnvar("ui_player_splash_cardClientId_" + self.nextsplashlistindex, -1);
  }

  self setclientomnvar("ui_player_splash_scriptBundle_" + self.nextsplashlistindex, isscriptbundlesplash);
  self setclientomnvar("ui_player_splash_id_" + self.nextsplashlistindex, omnvarvalue);

  if(!isDefined(self.recentsplashcount)) {
    self.recentsplashcount = 1;
  } else {
    self.recentsplashcount++;
  }

  thread cleanuplocalplayersplashlist();
  self.nextsplashlistindex++;

  if(self.nextsplashlistindex >= 6) {
    self.nextsplashlistindex = 0;
    self.splashlisttoggle = !self.splashlisttoggle;
  }
}

function queuesplash(ref, optionalnumber, playerforplayercard, splashlistoverride) {
  struct = spawnStruct();
  struct.ref = ref;
  struct.optionalnumber = optionalnumber;
  struct.playerforplayercard = playerforplayercard;
  struct.splashlistoverride = splashlistoverride;

  if(!isDefined(self.splashqueuehead)) {
    self.splashqueuehead = struct;
    self.splashqueuetail = struct;
    thread handlesplashqueue();
    return;
  }

  oldtail = self.splashqueuetail;
  oldtail.nextsplash = struct;
  self.splashqueuetail = struct;
}

function handlesplashqueue() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(isDefined(self.splashqueuehead)) {
    self waittill("splash_list_cleared");

    for(queueindex = 0; queueindex < 6; queueindex++) {
      struct = self.splashqueuehead;
      showsplashinternal(struct.ref, struct.optionalnumber, struct.playerforplayercard, struct.splashlistoverride);
      self.splashqueuehead = struct.nextsplash;

      if(!isDefined(self.splashqueuehead)) {
        break;
      }
    }
  }

  self.splashqueuetail = undefined;
}

function function_73baf095c3b9cce6(splashref, splashlistoverride) {
  id = level.var_4cd98c0c1064cfc0[splashref];

  if(isDefined(id)) {
    return id;
  }

  var_c1c3e6a4f162ab45 = undefined;

  if(isDefined(splashlistoverride)) {
    var_c1c3e6a4f162ab45 = splashlistoverride;
  }

  if(!isDefined(var_c1c3e6a4f162ab45) && isDefined(level.gametypebundle)) {
    var_c1c3e6a4f162ab45 = level.gametypebundle.splashlist;
  }

  if(!isDefined(var_c1c3e6a4f162ab45)) {
    var_c1c3e6a4f162ab45 = level.gamemodebundle.splashlist;
  }

  if(!isDefined(var_c1c3e6a4f162ab45)) {
    return undefined;
  }

  if(isxhashasset(var_c1c3e6a4f162ab45)) {
    splashlist = getscriptbundle(var_c1c3e6a4f162ab45);
  } else {
    splashlist = getscriptbundle(hashcat(%"hash_7ac5a0b15c7d50e5", var_c1c3e6a4f162ab45));
  }

  if(!isDefined(splashlist) || !isDefined(splashlist.splash_list)) {
    return undefined;
  }

  foreach(var_68cc4b3bf54adcfe in splashlist.splash_list) {
    if(var_68cc4b3bf54adcfe.ref != splashref) {
      continue;
    }

    id = function_2336488258354fbc(#"scriptbundle_splash", hashcat(%"hash_39857ea6520cf871", var_68cc4b3bf54adcfe.splashbundle));

    if(!isDefined(id)) {
      break;
    }

    level.var_4cd98c0c1064cfc0[splashref] = id;
    return id;
  }

  id = scripts\cp\rank::function_1e00d01d19fde519(splashref);

  if(isDefined(id)) {
    level.var_4cd98c0c1064cfc0[splashref] = id;
    return id;
  }

  return undefined;
}

function lowermessagethink() {
  self endon("disconnect");
  self.lowermessages = [];
  lowermessagefont = "default";

  if(isDefined(level.lowermessagefont)) {
    lowermessagefont = level.lowermessagefont;
  }

  messagey = level.lowertexty;
  var_4c254f3e1813b5ac = level.lowertextfontsize;
  timerfontsize = 1.25;

  if(level.splitscreen || self issplitscreenplayer() && !isai(self)) {
    messagey -= 40;
    var_4c254f3e1813b5ac = level.lowertextfontsize * 1.3;
    timerfontsize *= 1.5;
  }

  self.lowermessage = createfontstring(lowermessagefont, var_4c254f3e1813b5ac);
  self.lowermessage settext("");
  self.lowermessage.archived = 0;
  self.lowermessage.sort = 10;
  self.lowermessage.showinkillcam = 0;
  self.lowermessage setpoint("CENTER", level.lowertextyalign, 0, messagey);
  self.lowertimer = createfontstring("default", timerfontsize);
  self.lowertimer setparent(self.lowermessage);
  self.lowertimer setpoint("TOP", "BOTTOM", 0, 0);
  self.lowertimer settext("");
  self.lowertimer.archived = 0;
  self.lowertimer.sort = 10;
  self.lowertimer.showinkillcam = 0;
}

function isdoingsplash() {
  return false;
}

function getsplashtablename() {
  return "mp/splashtable.csv";
}

function cleanuplocalplayersplashlist() {
  self endon("disconnect");
  self notify("cleanupLocalPlayerSplashList()");
  self endon("cleanupLocalPlayerSplashList()");
  waittill_notify_or_timeout("death", 0.5);
  self.recentsplashcount = undefined;
  self notify("splash_list_cleared");
}

function splashshownthink() {
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, splashindex);

    if(channel != "splash_shown") {
      continue;
    }

    splashref = tablelookupbyrow(getsplashtablename(), splashindex, 0);
    type = tablelookupbyrow(getsplashtablename(), splashindex, 5);

    switch (type) {
      case #"hash_fb8615ef44a4f5d7":
        break;
    }
  }
}

function onkillstreaksplashshown(splashref) {}

function showerrormessage(var_1797174f9e968e96, optionalparam) {
  rownum = tablelookuprownum("mp/errorMessages.csv", 0, var_1797174f9e968e96);
  assertex(isDefined(rownum) && rownum >= 0, "Unable to find \"" + var_1797174f9e968e96 + "\" in errorMessage.csv");

  if(isDefined(optionalparam)) {
    self setclientomnvar("ui_mp_error_message_param", optionalparam);
  } else {
    self setclientomnvar("ui_mp_error_message_param", -1);
  }

  self setclientomnvar("ui_mp_error_message_id", rownum);

  if(!isDefined(self.errormessagebitflipper)) {
    self.errormessagebitflipper = 0;
  }

  self.errormessagebitflipper = !self.errormessagebitflipper;
  self setclientomnvar("ui_mp_error_trigger", ter_op(self.errormessagebitflipper, 2, 1));
}

function showerrormessagetoallplayers(var_1797174f9e968e96, optionalparam) {
  foreach(player in level.players) {
    player showerrormessage(var_1797174f9e968e96, optionalparam);
  }
}

function showmiscmessage(messageref) {
  rownum = tablelookuprownum("mp/miscMessages.csv", 0, messageref);
  assertex(isDefined(rownum) && rownum >= 0, "Unable to find \"" + messageref + "\" in miscMessages.csv");
  sound = tablelookupbyrow("mp/miscMessages.csv", rownum, 3);

  if(isDefined(sound) && sound != "") {
    self playlocalsound(sound);
  }

  self setclientomnvar("ui_misc_message_id", rownum);

  if(!isDefined(self.miscmessagebitflipper)) {
    self.miscmessagebitflipper = 0;
  }

  self.miscmessagebitflipper = !self.miscmessagebitflipper;
  self setclientomnvar("ui_misc_message_trigger", ter_op(self.miscmessagebitflipper, 1, 0));
}

function teamhudtutorialmessage(msg, team, time) {
  if(!isDefined(team)) {
    team = "allies";
  }

  if(!isDefined(time)) {
    time = 5;
  }

  foreach(player in level.players) {
    player thread tutorialprint(msg, time);
  }
}

function tutorialprint(msg, time) {
  level endon("game_ended");
  self endon("clear_tutorial_messages");
  self endon("disconnect");

  if(!isDefined(time)) {
    time = 5;
  }

  self sethudtutorialmessage(msg, 1);
  wait time;
  self clearhudtutorialmessage();
}

function hintmessagedeaththink() {
  self endon("disconnect");

  for(;;) {
    self waittill("death");

    if(isDefined(self.hintmessage)) {
      self.hintmessage destroyelem();
    }
  }
}