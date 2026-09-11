/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter.gsc
***********************************************/

function init_battlechatter() {
  if(isDefined(anim.chatinitialized) && anim.chatinitialized) {
    return;
  }

  setdvarifuninitialized("bcs_enable", 1);

  if(getdvarint("bcs_enable") == 0) {
    anim.chatinitialized = 0;
    anim.player.chatinitialized = 0;
    return;
  }

  anim.bcs_enabled = 0;
  anim.chatinitialized = 1;
  anim.player.chatinitialized = 0;

  if(!isDefined(level.friendlyfire_warnings)) {
    level.friendlyfire_warnings = 1;
  }

  setdvarifuninitialized("bcs_filterThreat", "off");
  setdvarifuninitialized("bcs_filterInform", "off");
  setdvarifuninitialized("bcs_filterVehicle", "off");
  setdvarifuninitialized("bcs_filterOrder", "off");
  setdvarifuninitialized("bcs_filterReaction", "off");
  setdvarifuninitialized("bcs_filterResponse", "off");
  setdvarifuninitialized("bcs_otnStealth", "off");
  setdvarifuninitialized("bcs_otnCombat", "off");
  setdvarifuninitialized("bcs_forceEnglish", "off");
  setdvarifuninitialized("bcs_allowsamevoiceresponse", "off");
  setdvarifuninitialized("bcs_commander_off", "");
  setdvarifuninitialized("bcs_radioecho_off", "");
  setdvarifuninitialized("debug_bcprint", "off");
  setdvarifuninitialized("debug_bcprintscreen", "off");
  setdvarifuninitialized("debug_bcprintdump", "off");
  setdvarifuninitialized("debug_bcprintdumptype", "csv");
  setdvarifuninitialized("debug_bcshowqueue", "off");
  anim.bcprintfailprefix = "^1***** BCS FAILURE: ";
  anim.bcprintwarnprefix = "^3***** BCS WARNING: ";
  bcs_setup_teams_array();
  scripts\anim\battlechatter_gamesku::bcs_setup_countryids();
  scripts\anim\battlechatter_gamesku::bcs_setup_playernameids();
  thread setplayerbcnameid();
  scripts\anim\battlechatter_gamesku::init_flavorbursts();
  anim.player thread scripts\anim\battlechatter_ai::aiinformweaponwaiter();
  anim.eventtypeminwait = [];
  anim.eventtypeminwait["threat"] = [];
  anim.eventtypeminwait["response"] = [];
  anim.eventtypeminwait["reaction"] = [];
  anim.eventtypeminwait["order"] = [];
  anim.eventtypeminwait["inform"] = [];
  anim.eventtypeminwait["vehicle"] = [];
  anim.eventtypeminwait["custom"] = [];
  anim.eventtypeminwait["direction"] = [];
  anim.eventtypeminwait["stealth"] = [];

  if(isDefined(level._stealth)) {
    anim.eventactionminwait["threat"]["self"] = 20000;
    anim.eventactionminwait["threat"]["squad"] = 30000;
  } else {
    anim.eventactionminwait["threat"]["self"] = 9000;
    anim.eventactionminwait["threat"]["squad"] = 5000;
  }

  anim.eventactionminwait["threat"]["location_repeat"] = 15000;
  anim.eventactionminwait["response"]["self"] = 1400;
  anim.eventactionminwait["response"]["squad"] = 1400;
  anim.eventactionminwait["reaction"]["self"] = 1400;
  anim.eventactionminwait["reaction"]["squad"] = 1400;
  anim.eventactionminwait["order"]["self"] = 7000;
  anim.eventactionminwait["order"]["squad"] = 6000;
  anim.eventactionminwait["inform"]["self"] = 4000;
  anim.eventactionminwait["inform"]["squad"] = 6000;
  anim.eventactionminwait["vehicle"]["self"] = 1000;
  anim.eventactionminwait["vehicle"]["squad"] = 1000;
  anim.eventactionminwait["custom"]["self"] = 0;
  anim.eventactionminwait["custom"]["squad"] = 0;
  anim.eventactionminwait["stealth"]["self"] = 9000;
  anim.eventactionminwait["stealth"]["squad"] = 5000;
  anim.eventactionminwait["stealth"]["location_repeat"] = 45000;
  anim.eventtypeminwait["playername"] = 50000;
  anim.eventtypeminwait["reaction"]["casualty"] = 14000;
  anim.eventtypeminwait["reaction"]["friendlyfire"] = 5000;
  anim.eventtypeminwait["reaction"]["takingfire"] = 35000;
  anim.eventtypeminwait["reaction"]["maneuver"] = 24000;
  anim.eventtypeminwait["reaction"]["movement"] = 24000;
  anim.eventtypeminwait["reaction"]["underfire"] = 24000;
  anim.eventtypeminwait["reaction"]["danger"] = 14000;
  anim.eventtypeminwait["reaction"]["ask_ok"] = 14000;
  anim.eventtypeminwait["reaction"]["taunt"] = 25000;
  anim.eventtypeminwait["inform"]["incoming"] = 25000;
  anim.eventtypeminwait["inform"]["reloading"] = 30000;
  anim.eventtypeminwait["inform"]["killfirm"] = 40000;
  anim.eventtypeminwait["inform"]["attack"] = 9000;
  anim.eventtypeminwait["vehicle"]["incoming"] = 2000;
  anim.eventtypeminwait["vehicle"]["killfirm"] = 2000;
  anim.eventtypeminwait["threat"]["acquired"] = 7000;
  anim.eventtypeminwait["threat"]["sighted"] = 7000;
  anim.eventtypeminwait["reaction"]["maneuver"] = 15000;
  anim.eventtypeminwait["reaction"]["underfire"] = 2000;
  anim.eventtypeminwait["order"]["action"] = 9000;
  anim.eventtypeminwait["response"]["callout"] = 7000;
  anim.eventtypeminwait["response"]["location"] = 7000;
  anim.eventtypeminwait["stealth"]["idle"] = 0;
  anim.eventtypeminwait["stealth"]["idle_alert"] = 0;
  anim.eventtypeminwait["stealth"]["radio"] = 0;
  anim.eventtypeminwait["stealth"]["investigate"] = 12000;
  anim.eventtypeminwait["stealth"]["hunt"] = 500;
  anim.eventtypeminwait["stealth"]["combat"] = 15000;
  anim.eventtypeminwait["stealth"]["announce1"] = 500;
  anim.eventtypeminwait["stealth"]["announce2"] = 3000;
  anim.eventtypeminwait["stealth"]["announce3"] = 10000;
  anim.eventtypeminwait["stealth"]["announce4"] = 3000;
  anim.eventtypeminwait["stealth"]["announce5"] = 3000;
  anim.eventpriority["threat"]["infantry"] = 0.6;
  anim.eventpriority["threat"]["sighted"] = 0.6;
  anim.eventpriority["threat"]["acquired"] = 0.6;
  anim.eventpriority["response"]["ack"] = 0.9;
  anim.eventpriority["response"]["exposed"] = 0.8;
  anim.eventpriority["response"]["callout"] = 0.9;
  anim.eventpriority["response"]["location"] = 0.9;
  anim.eventpriority["response"]["echo"] = 0.9;
  anim.eventpriority["response"]["covering"] = 0.9;
  anim.eventpriority["response"]["im"] = 0.9;
  anim.eventpriority["reaction"]["casualty"] = 0.5;
  anim.eventpriority["reaction"]["friendlyfire"] = 1;
  anim.eventpriority["reaction"]["takingfire"] = 1;
  anim.eventpriority["reaction"]["maneuver"] = 0.8;
  anim.eventpriority["reaction"]["movement"] = 0.8;
  anim.eventpriority["reaction"]["underfire"] = 0.8;
  anim.eventpriority["reaction"]["danger"] = 0.8;
  anim.eventpriority["reaction"]["ask_ok"] = 1;
  anim.eventpriority["reaction"]["taunt"] = 0.9;
  anim.eventpriority["order"]["action"] = 0.3;
  anim.eventpriority["order"]["move"] = 0.3;
  anim.eventpriority["order"]["displace"] = 0.5;
  anim.eventpriority["inform"]["attack"] = 0.9;
  anim.eventpriority["inform"]["incoming"] = 0.9;
  anim.eventpriority["inform"]["reloading"] = 0.2;
  anim.eventpriority["inform"]["suppressed"] = 0.2;
  anim.eventpriority["inform"]["killfirm"] = 0.4;
  anim.eventpriority["vehicle"]["incoming"] = 0.99;
  anim.eventpriority["vehicle"]["killfirm"] = 0.99;
  anim.eventpriority["custom"]["generic"] = 1;
  anim.eventpriority["stealth"]["idle"] = 0.6;
  anim.eventpriority["stealth"]["idle_alert"] = 0.6;
  anim.eventpriority["stealth"]["radio"] = 0.6;
  anim.eventpriority["stealth"]["investigate"] = 0.6;
  anim.eventpriority["stealth"]["hunt"] = 0.9999;
  anim.eventpriority["stealth"]["combat"] = 0.6;
  anim.eventpriority["stealth"]["announce1"] = 0.999999;
  anim.eventpriority["stealth"]["announce2"] = 0.99999;
  anim.eventpriority["stealth"]["announce3"] = 0.9999;
  anim.eventpriority["stealth"]["announce4"] = 0.999;
  anim.eventpriority["stealth"]["announce5"] = 0.99;
  anim.eventduration["threat"]["infantry"] = 1000;
  anim.eventduration["threat"]["sighted"] = 1500;
  anim.eventduration["threat"]["acquired"] = 1500;
  anim.eventduration["response"]["exposed"] = 1000;
  anim.eventduration["response"]["callout"] = 2000;
  anim.eventduration["response"]["location"] = 2000;
  anim.eventduration["response"]["echo"] = 2000;
  anim.eventduration["response"]["ack"] = 1000;
  anim.eventduration["response"]["covering"] = 1500;
  anim.eventduration["response"]["im"] = 1500;
  anim.eventduration["reaction"]["casualty"] = 1000;
  anim.eventduration["reaction"]["friendlyfire"] = 1000;
  anim.eventduration["reaction"]["takingfire"] = 1500;
  anim.eventduration["reaction"]["maneuver"] = 1500;
  anim.eventduration["reaction"]["movement"] = 1500;
  anim.eventduration["reaction"]["underfire"] = 1500;
  anim.eventduration["reaction"]["danger"] = 1500;
  anim.eventduration["reaction"]["ask_ok"] = 1500;
  anim.eventduration["reaction"]["taunt"] = 2000;
  anim.eventduration["order"]["action"] = 3000;
  anim.eventduration["order"]["move"] = 3000;
  anim.eventduration["order"]["displace"] = 3000;
  anim.eventduration["inform"]["attack"] = 1000;
  anim.eventduration["inform"]["incoming"] = 1500;
  anim.eventduration["inform"]["reloading"] = 1000;
  anim.eventduration["inform"]["suppressed"] = 2000;
  anim.eventduration["inform"]["killfirm"] = 2000;
  anim.eventduration["vehicle"]["incoming"] = 3000;
  anim.eventduration["vehicle"]["killfirm"] = 3000;
  anim.eventduration["custom"]["generic"] = 1000;
  anim.eventduration["stealth"]["idle"] = 500;
  anim.eventduration["stealth"]["idle_alert"] = 500;
  anim.eventduration["stealth"]["radio"] = 500;
  anim.eventduration["stealth"]["investigate"] = 1500;
  anim.eventduration["stealth"]["hunt"] = 1500;
  anim.eventduration["stealth"]["combat"] = 1500;
  anim.eventduration["stealth"]["announce1"] = 1500;
  anim.eventduration["stealth"]["announce2"] = 1500;
  anim.eventduration["stealth"]["announce3"] = 1500;
  anim.eventduration["stealth"]["announce4"] = 1500;
  anim.eventduration["stealth"]["announce5"] = 1500;
  anim.eventchance["response"]["exposed"] = 75;
  anim.eventchance["response"]["reload"] = 50;
  anim.eventchance["response"]["location"] = 75;
  anim.eventchance["response"]["callout"] = 75;
  anim.eventchance["response"]["callout_negative"] = 20;
  anim.eventchance["response"]["order"] = 40;
  anim.eventchance["moveEvent"]["coverme"] = 70;
  anim.eventchance["moveEvent"]["ordertoplayer"] = 10;
  anim.fbt_desireddistmax = 620;
  anim.fbt_waitmin = 12;
  anim.fbt_waitmax = 24;
  anim.fbt_linebreakmin = 2;
  anim.fbt_linebreakmax = 5;
  anim.moveorigin = spawn("script_origin", (0, 0, 0));

  if(!isDefined(level.bcs_maxtalkingdistsqrdfromplayer)) {
    level.bcs_maxtalkingdistsqrdfromplayer = squared(3000);
  }

  if(!isDefined(level.bcs_maxthreatdistsqrdfromplayer)) {
    level.bcs_maxthreatdistsqrdfromplayer = squared(5000);
  }

  if(!isDefined(level.bcs_maxstealthdistsqrdfromplayer)) {
    level.bcs_maxstealthdistsqrdfromplayer = squared(1500);
  }

  level.heightforhighcallout = 96;
  level.mindistancecallout = 10;
  level.maxdistancecallout = 45;
  scripts\common\bcs_location_trigs::bcs_location_trigs_init();
  anim.scripteddialoguebuffertime = 4000;
  anim.bcs_threatresettime = 3000;
  anim.bcs_lastcontactdelay = 15000;
  anim.squadcreatefuncs[anim.squadcreatefuncs.size] = &init_squadbattlechatter;
  anim.squadcreatestrings[anim.squadcreatestrings.size] = "::init_squadBattleChatter";

  foreach(var1 in anim.teams) {
    anim.isteamspeaking[var1] = 0;
    anim.isteamsaying[var1]["threat"] = 0;
    anim.isteamsaying[var1]["order"] = 0;
    anim.isteamsaying[var1]["reaction"] = 0;
    anim.isteamsaying[var1]["response"] = 0;
    anim.isteamsaying[var1]["inform"] = 0;
    anim.isteamsaying[var1]["vehicle"] = 0;
    anim.isteamsaying[var1]["custom"] = 0;
    anim.isteamsaying[var1]["stealth"] = 0;
  }

  bcs_setup_chatter_toggle_array();
  bcs_setup_flavorburst_toggle_array();
  anim.lastteamspeaktime = [];
  anim.lastnamesaid = [];
  anim.lastnamesaidtime = [];

  foreach(var1 in anim.teams) {
    anim.lastteamspokentime[var1] = gettime();
    anim.lastteamspeaktime[var1] = -50000;
    anim.lastnamesaid[var1] = "none";
    anim.lastnamesaidtime[var1] = -100000;
  }

  anim.lastnamesaidtimeout = 120000;

  for(var5 = 0; var5 < anim.squadindex.size; var5++) {
    if(isDefined(anim.squadindex[var5].chatinitialized) && anim.squadindex[var5].chatinitialized) {
      continue;
    }

    init_squadbattlechatter(anim.squadindex[var5]);
  }

  anim.threatcallouts = [];
  anim.threatcallouts["exposed"] = 25;
  anim.threatcallouts["sighted"] = 25;
  anim.threatcallouts["acquired"] = 50;
  anim.threatcallouts["target_compass"] = 25;
  anim.threatcallouts["target_distance"] = 25;
  anim.threatcallouts["target_elev"] = 25;
  anim.threatcallouts["concat_location"] = 90;
  anim.threatcallouts["player_location"] = 90;
  anim.threatcallouts["ai_location"] = 100;
  anim.threatcallouts["generic_location"] = 95;
  anim.lastteamthreatcallout = [];
  anim.lastteamthreatcallouttime = [];

  foreach(var1 in anim.teams) {
    anim.lastteamthreatcallout[var1] = undefined;
    anim.lastteamthreatcallouttime[var1] = undefined;
  }

  anim.teamthreatcalloutlimittimeout = 120000;
  level notify("battlechatter initialized");
  anim notify("battlechatter initialized");
}

function bcs_setup_teams_array() {
  if(!isDefined(anim.teams)) {
    anim.teams = [];
    anim.teams[anim.teams.size] = "axis";
    anim.teams[anim.teams.size] = "allies";
    anim.teams[anim.teams.size] = "team3";
    anim.teams[anim.teams.size] = "neutral";
    return;
  }
}

function bcs_setup_voice(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 0;
  }

  anim.usedids[var0] = [];

  for(var4 = 0; var4 < var2; var4++) {
    anim.usedids[var0][var4] = spawnStruct();
    anim.usedids[var0][var4].count = 0;
    anim.usedids[var0][var4].npcid = "" + var4 + 1;
  }

  anim.countryids[var0] = var1;
  anim.flavorburstvoices[var0] = var3;
}

function bcs_setup_chatter_toggle_array() {
  bcs_setup_teams_array();

  if(!isDefined(level.battlechatter)) {
    level.battlechatter = [];

    foreach(var1 in anim.teams) {
      scripts\engine\sp\utility::set_battlechatter_variable(var1, 0);
    }

    return;
  }
}

function bcs_setup_flavorburst_toggle_array() {
  bcs_setup_teams_array();

  if(!isDefined(level.flavorbursts)) {
    level.flavorbursts = [];

    foreach(var1 in anim.teams) {
      level.flavorbursts[var1] = 0;
    }

    return;
  }
}

function shutdown_battlechatter() {
  anim.countryids = undefined;
  anim.eventtypeminwait = undefined;
  anim.eventactionminwait = undefined;
  anim.eventtypeminwait = undefined;
  anim.eventpriority = undefined;
  anim.eventduration = undefined;
  anim.moveorigin = undefined;
  anim.scripteddialoguebuffertime = undefined;
  anim.bcs_threatresettime = undefined;
  anim.locationlastcallouttimes = undefined;
  anim.usedids = undefined;
  anim.flavorburstsused = undefined;
  anim.lastteamthreatcallout = undefined;
  anim.lastteamthreatcallouttime = undefined;
  anim.lastnamesaidtimeout = undefined;
  anim.lastnamesaid = undefined;
  anim.lastnamesaidtime = undefined;
  anim.chatinitialized = 0;
  anim.player.chatinitialized = 0;
  level.battlechatter = undefined;
  anim.bcs_locations = undefined;

  for(var0 = 0; var0 < anim.squadcreatefuncs.size; var0++) {
    if(anim.squadcreatestrings[var0] != "::init_squadBattleChatter") {
      continue;
    }

    if(var0 != anim.squadcreatefuncs.size - 1) {
      anim.squadcreatefuncs[var0] = anim.squadcreatefuncs[anim.squadcreatefuncs.size - 1];
      anim.squadcreatestrings[var0] = anim.squadcreatestrings[anim.squadcreatestrings.size - 1];
    }

    anim.squadcreatefuncs[anim.squadcreatefuncs.size - 1] = undefined;
    anim.squadcreatestrings[anim.squadcreatestrings.size - 1] = undefined;
  }

  level notify("battlechatter disabled");
  anim notify("battlechatter disabled");
}

function init_squadbattlechatter() {
  var0 = self;
  var0.numspeakers = 0;
  var0.maxspeakers = 1;
  var0.nextsaytime = gettime() + 50;
  var0.nextsaytimes["threat"] = gettime() + 50;
  var0.nextsaytimes["order"] = gettime() + 50;
  var0.nextsaytimes["reaction"] = gettime() + 50;
  var0.nextsaytimes["response"] = gettime() + 50;
  var0.nextsaytimes["inform"] = gettime() + 50;
  var0.nextsaytimes["vehicle"] = gettime() + 50;
  var0.nextsaytimes["custom"] = gettime() + 50;
  var0.nextsaytimes["stealth"] = gettime() + 50;
  var0.nexttypesaytimes["threat"] = [];
  var0.nexttypesaytimes["order"] = [];
  var0.nexttypesaytimes["reaction"] = [];
  var0.nexttypesaytimes["response"] = [];
  var0.nexttypesaytimes["inform"] = [];
  var0.nexttypesaytimes["vehicle"] = [];
  var0.nexttypesaytimes["custom"] = [];
  var0.nexttypesaytimes["stealth"] = [];
  var0.ismembersaying["threat"] = 0;
  var0.ismembersaying["order"] = 0;
  var0.ismembersaying["reaction"] = 0;
  var0.ismembersaying["response"] = 0;
  var0.ismembersaying["inform"] = 0;
  var0.ismembersaying["vehicle"] = 0;
  var0.ismembersaying["custom"] = 0;
  var0.ismembersaying["stealth"] = 0;
  var0.lastdirection = "";
  var0.memberaddfuncs[var0.memberaddfuncs.size] = &scripts\anim\battlechatter_ai::addtosystem;
  var0.memberremovefuncs[var0.memberremovefuncs.size] = &scripts\anim\battlechatter_ai::removefromsystem;
  var0.squadupdatefuncs[var0.squadupdatefuncs.size] = &initcontact;
  var0.fbt_firstburst = 1;
  var0.fbt_lastbursterid = undefined;

  for(var1 = 0; var1 < anim.squadindex.size; var1++) {
    thread initcontact(var0);
  }

  var0 thread scripts\anim\battlechatter_ai::squadthreatwaiter();
  thread squadflavorbursttransmissions();
  var0.chatinitialized = 1;
  var0 notify("squad chat initialized");
}

function shutdown_squadbattlechatter() {
  var0 = self;
  var0.numspeakers = undefined;
  var0.maxspeakers = undefined;
  var0.nextsaytime = undefined;
  var0.nextsaytimes = undefined;
  var0.nexttypesaytimes = undefined;
  var0.ismembersaying = undefined;
  var0.fbt_firstburst = undefined;
  var0.fbt_lastbursterid = undefined;

  for(var1 = 0; var1 < var0.memberaddfuncs.size; var1++) {
    var0.memberaddfuncs[var1] = undefined;
  }

  for(var1 = 0; var1 < var0.memberremovefuncs.size; var1++) {
    var0.memberremovestrings[var1] = undefined;
  }

  for(var1 = 0; var1 < var0.squadupdatefuncs.size; var1++) {
    var0.squadupdatefuncs[var1] = undefined;
  }

  for(var1 = 0; var1 < anim.squadindex.size; var1++) {
    shutdowncontact(var0, anim.squadindex[var1].squadname);
  }

  var0.chatinitialized = 0;
}

function bcsenabled() {
  if(isDefined(anim.chatinitialized)) {
    return anim.chatinitialized;
  }

  return 0;
}

function bcsdebugwaiter() {
  var0 = getdvarint("bcs_enable");

  for(;;) {
    var1 = getdvarint("bcs_enable");

    if(var1 != var0) {
      switch (var1) {
        case 1:
          if(!anim.chatinitialized) {
            enablebattlechatter();
          }

          break;
        case 0:
          if(anim.chatinitialized) {
            disablebattlechatter();
          }

          break;
      }

      var0 = var1;
    }

    wait 1;
  }
}

function enablebattlechatter() {
  init_battlechatter();
  anim.player thread scripts\anim\battlechatter_ai::addtosystem();
  var0 = getaiarray();

  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1] scripts\anim\battlechatter_ai::addtosystem();
  }
}

function disablebattlechatter() {
  if(!isDefined(anim.chatinitialized)) {
    return;
  }

  shutdown_battlechatter();
  var0 = getaiarray();

  for(var1 = 0; var1 < var0.size; var1++) {
    if(isDefined(var0[var1].squad) && var0[var1].squad.chatinitialized) {
      shutdown_squadbattlechatter(var0[var1].squad);
    }

    var0[var1] scripts\anim\battlechatter_ai::removefromsystem();
  }
}

function setplayerbcnameid(var0, var1) {
  if(isDefined(var0) && isDefined(var1)) {
    anim.player.bcnameid = var0;
    anim.player.bccountryid = var1;
    return;
  }

  while(!isDefined(level.campaign)) {
    wait 0.1;
  }

  var2 = level.campaign;
  var3 = anim.playernameids[var2];
  var4 = anim.countryids[var2];

  if(isDefined(var3)) {
    anim.player.bcnameid = var3;
  }

  if(isDefined(var4)) {
    anim.player.bccountryid = var4;
    return;
  }
}

function bc_prefix(var0, var1) {
  if(!isDefined(self.battlechatter.npcid)) {
    self.battlechatter.npcid = "";
  }

  if(self == anim.player) {
    return "UN_plr_";
  }

  if(isDefined(var0) && var0 == "stealth") {
    if(getDvar("bcs_otnStealth") != "off") {
      if(istrue(var1)) {
        return tolower("dx_otn_" + self.battlechatter.countryid + "l1_");
      }

      return tolower("dx_otn_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
    }

    if(istrue(var1)) {
      return tolower("dx_cst_" + self.battlechatter.countryid + "l1_");
    }

    return tolower("dx_cst_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
  }

  if(isDefined(var0) && var0 == "custom") {
    return tolower("dx_vom_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
  }

  if(isDefined(var0) && var0 == "custom radio") {
    return tolower("dx_vom");
  }

  if(getDvar("bcs_otnCombat") != "off") {
    if(isarray(getDvar("bcs_otnCombat"))) {
      if(isDefined(self.team) && scripts\engine\utility::array_contains(getDvar("bcs_otnCombat"), self.team)) {
        return tolower("dx_otn_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
      }

      return;
    }

    if(isDefined(self.team) && self.team == getDvar("bcs_otnCombat")) {
      return tolower("dx_otn_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
    }

    return tolower("dx_cbc_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
  }

  return tolower("dx_cbc_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
}

function getbattlechatteralias(var0) {
  var1 = undefined;
  var2 = bc_prefix();

  switch (var0) {
    case "check_fire":
      var1 = var2 + "response_check_fire";
      break;
    case "concat_clock":
      var1 = var2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_clock_";
      break;
    case "concat_compass":
      var1 = var2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_compass_";
      break;
    case "concat_dist":
      var1 = var2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_dist_";
      break;
    case "concat_elev":
      var1 = var2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_elev_";
      break;
    case "concat_left":
      var1 = var2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_left";
      break;
    case "concat_right":
      var1 = var2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_right";
      break;
    case "concat_center":
      var1 = var2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_center";
      break;
    case "concat_target":
      var1 = var2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_target";
      break;
    case "contact_movement_group":
      var1 = var2 + "contact_movement_group";
      break;
    case "exposed_acquired":
      var1 = var2 + "exposed_acquired";
      break;
    case "exposed_breaking":
      var1 = var2 + "exposed_breaking";
      break;
    case "exposed_movement":
      var1 = var2 + "exposed_movement";
      break;
    case "exposed_movement_group":
      var1 = var2 + "exposed_movement_group";
      break;
    case "exposed_open":
      var1 = var2 + "exposed_open";
      break;
    case "vehicle_incoming_helicopter":
      var1 = var2 + "vehicle_incoming_helicopter";
      break;
    case "vehicle_incoming_tank":
      var1 = var2 + "vehicle_incoming_tank";
      break;
    case "vehicle_incoming_technical":
      var1 = var2 + "vehicle_incoming_technical";
      break;
    case "vehicle_killfirm_helicopter":
      var1 = var2 + "vehicle_killfirm_helicopter";
      break;
    case "vehicle_killfirm_tank":
      var1 = var2 + "vehicle_killfirm_tank";
      break;
    case "vehicle_killfirm_technical":
      var1 = var2 + "vehicle_killfirm_technical";
      break;
    case "inform_molotov":
      var1 = var2 + "inform_molotov";
      break;
    case "inform_reloading":
      var1 = var2 + "inform_reloading";
      break;
    case "inform_taking_fire":
      var1 = var2 + "inform_taking_fire";
      break;
    case "inform_frag":
    case "inform_grenade":
      var1 = var2 + "inform_grenade";
      break;
    case "inform_incoming_grenade":
      var1 = var2 + "inform_incoming_grenade";
      break;
    case "inform_incoming_rpg":
      var1 = var2 + "inform_incoming_rpg";
      break;
    case "inform_incoming_sniper":
      var1 = var2 + "inform_incoming_sniper";
      break;
    case "inform_incoming_molotov":
      var1 = var2 + "inform_incoming_molotov";
      break;
    case "inform_killfirm_juggernaut":
    case "inform_killfirm_soldier":
      var1 = var2 + "inform_killfirm_soldier";
      break;
    case "location_response":
      var1 = var2 + scripts\anim\battlechatter_ai::getbcstate() + "_location_resp";
      break;
    case "order_coverme":
      var1 = var2 + "order_coverme";
      break;
    case "order_movecombat":
      var1 = var2 + "order_move_combat";
      break;
    case "order_movenoncombat":
      var1 = var2 + "order_move_noncombat";
      break;
    case "order_suppress":
      var1 = var2 + "order_suppress";
      break;
    case "reaction_casualty":
      var1 = var2 + "reaction_casualty";
      break;
    case "reaction_hostile_burst":
      var1 = var2 + "reaction_hostile_burst";
      break;
    case "response_ack_affirm":
      var1 = var2 + "response_ack_affirm";
      break;
    case "response_threat_affirm":
      var1 = var2 + "response_threat_affirm";
      break;
    case "response_threat_neg":
      var1 = var2 + "response_threat_neg";
      break;
    case "taunt":
      var1 = var2 + "taunt";
      break;
    case "threat_callout_acquired":
      var1 = var2 + "acquired_";
      break;
    case "threat_callout_sighted":
      var1 = var2 + "sighted_";
      break;
    case "threat_callout_contactcompass":
      var1 = var2 + "contact_compass_";
      break;
    case "threat_callout_contactdistance":
      var1 = var2 + "contact_dist_";
      break;
    case "threat_callout_contactelev":
      var1 = var2 + "contact_elev_";
      break;
    case "threat_callout_targetcompass":
      var1 = var2 + "target_compass_";
      break;
    case "threat_callout_targetdistance":
      var1 = var2 + "target_dist_";
      break;
    case "threat_callout_targetelev":
      var1 = var2 + "target_elev_";
      break;
    default:
      break;
  }

  return var1;
}

function playbattlechatter(var0) {
  if(!isalive(self)) {
    return;
  }

  if(!isDefined(self.team)) {
    return;
  }

  if(!bcsenabled()) {
    return;
  }

  if(isDefined(self._animactive) && self._animactive > 0) {
    self.battlechatter.stealthidledelay = 4000 + gettime();

    if(!istrue(self.battlechatter.friendlyfire_force)) {
      return;
    }
  }

  if(isDefined(self._blackboard) && isDefined(self._blackboard.idlenode)) {
    self.battlechatter.stealthidledelay = 5500 + gettime();
    return;
  }

  if(isDefined(self.battlechatter.isspeaking) && self.battlechatter.isspeaking) {
    return;
  }

  if(isDefined(self.scripteddialoguenotify) || isDefined(self.scripteddialoguenonotify)) {
    if(battlechatter_canprint()) {}

    if(can_say_friendlyfire()) {
      thread friendlyfire_warning_team();
    }

    return;
  }

  if(friendlyfire_warning()) {
    return;
  }

  if(istrue(self.battlechatter.onlyfirendlyfire)) {
    return;
  }

  if(!isDefined(self.team) || isDefined(self.team) && self.team == "allies" && isDefined(anim.scripteddialoguestarttime)) {
    if(!istrue(self.battlechatter.friendlyfire_force)) {
      if(anim.scripteddialoguestarttime + anim.scripteddialoguebuffertime > gettime()) {
        return;
      }
    }
  }

  if(!isDefined(self.battlechatterallowed) || !self.battlechatterallowed) {
    return;
  }

  if(anim.isteamspeaking[self.team]) {
    return;
  }

  self endon("death");

  if(!isDefined(var0)) {
    var0 = gethighestpriorityevent();
  }

  if(isDefined(self.bc_event_override)) {
    var0 = self.bc_event_override;
  }

  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(self.melee)) {
    if(isDefined(self.melee.inprogress)) {
      if(self.melee.inprogress) {
        return;
      }
    }
  }

  if(self == anim.player) {
    if(!isDefined(anim.player.battlechatterallowed) || isDefined(anim.player.battlechatterallowed) && !anim.player.battlechatterallowed) {
      return;
    }

    if(!isDefined(anim.player.bcscooldown) || anim.player.bcscooldown != 0) {
      return;
    } else {
      level notify("player_battlechatter_refresh");
    }
  }

  switch (var0) {
    case "custom":
      thread playcustomevent();
      break;
    case "response":
      thread playresponseevent();
      break;
    case "order":
      thread playorderevent();
      break;
    case "threat":
      thread playthreatevent();
      break;
    case "reaction":
      thread playreactionevent();
      break;
    case "inform":
      thread playinformevent();
      break;
    case "vehicle":
      thread playvehicleevent();
      break;
    case "stealth":
      thread playstealthevent();
      break;
  }
}

function addeventplaybcs(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("cancel speaking");
  self endon("stop event play bcs");

  if(isDefined(var3)) {
    wait var3;
  }

  var6 = undefined;

  switch (var0) {
    case "stealth":
      var6 = scripts\anim\battlechatter_ai::addstealthevent(var1, var2, undefined, var4);
      break;
    default:
      break;
  }

  if(!var6) {
    return;
  }

  self.squad.nexttypesaytimes[var0][var1] = gettime() + anim.eventtypeminwait[var0][var1];

  if(istrue(var5)) {
    self.battlechatter.isspeaking = 0;
    anim.isteamspeaking[self.team] = 0;
  }

  if(var6) {
    thread playbattlechatter(var0);
    self notify("stop event play bcs");
    return;
  }
}

function playthreatevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("cancel speaking");
  self.curevent = self.battlechatter.chatqueue["threat"];
  var0 = self.battlechatter.chatqueue["threat"].threat;

  if(!isalive(var0)) {
    return;
  }

  if(threatwasalreadycalledout(var0) && !isPlayer(var0)) {
    return;
  }

  thread lockaction(anim, self);
  var1 = 0;
  var2 = self.battlechatter.chatqueue["threat"].eventtype;

  switch (var2) {
    case "infantry":
      if(isPlayer(var0) || !isDefined(var0 getturret())) {
        if(isDefined(self._blackboard)) {
          self._blackboard.battlechatter_target = var0;
        }

        var1 = threatinfantry(var0, undefined);
      }

      break;
    case "vehicle":
      var1 = threatvehicle(var0);
      break;
    case "acquired":
      self.callout_type_override = var2;
      var1 = threatinfantry(var0, undefined);
      break;
    case "sighted":
      self.callout_type_override = var2;
      var1 = threatinfantry(var0, undefined);
      break;
  }

  var3 = self;
  var3 notify("done speaking");

  if(!var1) {
    return;
  }

  if(!isalive(var0)) {
    return;
  }

  var0.battlechatter.calledout[var3.squad.squadname] = spawnStruct();
  var0.battlechatter.calledout[var3.squad.squadname].spotter = var3;
  var0.battlechatter.calledout[var3.squad.squadname].threattype = var3.battlechatter.chatqueue["threat"].eventtype;
  var0.battlechatter.calledout[var3.squad.squadname].expiretime = gettime() + anim.bcs_threatresettime;

  if(isDefined(var0.squad)) {
    var3.squad.squadlist[var0.squad.squadname].calledout = 1;
    return;
  }
}

function threatwasalreadycalledout(var0) {
  if(isDefined(var0.battlechatter.calledout) && isDefined(var0.battlechatter.calledout[self.squad.squadname])) {
    if(var0.battlechatter.calledout[self.squad.squadname].expiretime > gettime()) {
      return true;
    }
  }

  return false;
}

function threatinfantry(var0, var1) {
  self endon("cancel speaking");
  var2 = createchatphrase();
  var2.master = 1;
  var2.threatent = var0;
  var3 = getthreatinfantrycallouttype(var0);

  if(!isDefined(var3) || isDefined(var3) && !isDefined(var3.type)) {
    return false;
  }

  var4 = undefined;

  if(isDefined(self.callout_type_override)) {
    var4 = self.callout_type_override;
  } else {
    var4 = var3.type;
  }

  switch (var4) {
    case "exposed":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var3.responder;
      }

      var5 = doexposedcalloutresponse(var3.responder);
      var6 = self;

      if(var5 && cansayname(var6, var3.responder)) {
        addnamealias(var2, var3.responder.bcname);
        var2.bc_looktarget = var3.responder;
      }

      threatinfantryexposed(var2, var0);

      if(var5) {
        if(randomint(100) < anim.eventchance["response"]["callout_negative"]) {
          var3.responder scripts\anim\battlechatter_ai::addresponseevent("callout", "neg", self, 0.9);
        } else {
          var3.responder scripts\anim\battlechatter_ai::addresponseevent("exposed", "acquired", self, 0.9);
        }
      }

      break;
    case "acquired":
      addplayernamealias(var2);
      addthreatcalloutalias(var2, "acquired", var3.playerclockdirection);
      break;
    case "sighted":
      addplayernamealias(var2);
      addthreatcalloutalias(var2, "sighted", var3.playerclockdirection);
      break;
    case "target_compass":
      var7 = self;

      if(self.team == "allies") {
        var7 = anim.player;
      } else if(isDefined(var3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var7 = var3.responder;
      }

      var8 = getdirectioncompass(var7.origin, var0.origin);
      var9 = normalizecompassdirection(var8);

      if(var9 == "impossible") {
        return false;
      }

      addplayernamealias(var2);

      if(addthreatcalloutalias(var2, "compass", var9, 1)) {
        addcalloutresponseevent(var2, self, var3, var0);

        if(isDefined(self._blackboard)) {
          self._blackboard.battlechatter_target = var0;
        }
      }

      break;
    case "target_distance":
      var7 = self;

      if(self.team == "allies") {
        var7 = anim.player;
      } else if(isDefined(var3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var7 = var3.responder;
      }

      var10 = getdistancemetersnormalized(var7.origin, var0.origin);

      if(isDefined(var10)) {
        addplayernamealias(var2);

        if(addthreatcalloutalias(var2, "distance", var10, 1)) {
          addcalloutresponseevent(var2, self, var3, var0);

          if(isDefined(self._blackboard)) {
            self._blackboard.battlechatter_target = var0;
          }
        }
      }

      break;
    case "target_elev":
      var7 = self;

      if(self.team == "allies") {
        var7 = anim.player;
      } else if(isDefined(var3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var7 = var3.responder;
      }

      var11 = getdegreeselevation(var7.origin, var0.origin);

      if(var11 >= 20 && var11 <= 60) {
        addplayernamealias(var2);

        if(addthreatcalloutalias(var2, "elev", var11, 1)) {
          addcalloutresponseevent(var2, self, var3, var0);

          if(isDefined(self._blackboard)) {
            self._blackboard.battlechatter_target = var0;
          }
        }
      }

      break;
    case "generic_location":
      var6 = self;
      var7 = self;

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      var12 = threatinfantry_docalloutlocation(var2, var3, undefined, var6);

      if(!var12) {
        return false;
      }

      if(self.team == "allies") {
        var7 = anim.player;
      }

      addconcatdirectionalias(var2, var7, var0);
      addcalloutresponseevent(var2, self, var3, var0);
      break;
    case "player_location":
      var6 = self;
      addplayernamealias(var2);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = anim.player;
      }

      var12 = threatinfantry_docalloutlocation(var2, var3, undefined, var6);

      if(!var12) {
        return false;
      }

      break;
    case "concat_location":
      var13 = 0;

      if(randomint(3)) {
        var13 = 1;
        addconcattargetalias(var2, var0);
      }

      var6 = self;
      var7 = self;

      if(self.team == "allies") {
        var7 = anim.player;
      }

      var12 = threatinfantry_docalloutlocation(var2, var3, 1, var6);

      if(!var12) {
        return false;
      }

      if(!var13) {
        addconcatdirectionalias(var2, var7, var0);
      } else if(randomint(3)) {
        addconcatdirectionalias(var2, var7, var0);
      }

      addcalloutresponseevent(var2, self, var3, var0);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
    case "ai_location":
      var6 = self;

      if(cansayname(var6, var3.responder)) {
        addnamealias(var2, var3.responder.bcname);
        var2.bc_looktarget = var3.responder;
      }

      var12 = threatinfantry_docalloutlocation(var2, var3, undefined, var6);

      if(!var12) {
        return false;
      }

      var14 = var2.soundaliases.size - 1;
      var15 = var2.soundaliases[var14];

      if(iscallouttypereport(var15)) {
        var3.responder scripts\anim\battlechatter_ai::addresponseevent("callout", "echo", self, 0.9, var15);
      } else if(iscallouttypeqa(var15, self)) {
        var3.responder scripts\anim\battlechatter_ai::addresponseevent("callout", "QA", self, 0.9, var15, var3.location);
      } else if(randomint(100) < anim.eventchance["response"]["callout_negative"]) {
        var3.responder scripts\anim\battlechatter_ai::addresponseevent("callout", "neg", self, 0.9);
      } else {
        var3.responder scripts\anim\battlechatter_ai::addresponseevent("exposed", "acquired", self, 0.9);
      }

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
  }

  setlastcallouttype(var3.type);
  var6 = self;

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_line_ok = 0;
  }

  playphrase(var6, var2, self);

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  return true;
}

function threatvehicle(var0) {
  self endon("cancel speaking");
  var1 = createchatphrase();
  var1.master = 1;
  var1.threatent = var0;
  iprintln("MAKE SURE THIS DOESN'T GET CALLED");
  addthreatalias(var1, "vehicle");
  setlastcallouttype("vehicle");
  var2 = self;

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_line_ok = 0;
  }

  playphrase(var2, var1, self);

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  return true;
}

function doexposedcalloutresponse(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!scripts\anim\battlechatter_gamesku::isalliedcountryid(var0.battlechatter.countryid)) {
    return false;
  }

  if(randomint(100) > anim.eventchance["response"]["exposed"]) {
    return false;
  }

  return true;
}

function threatinfantry_docalloutlocation(var0, var1, var2) {
  var3 = addthreatcalloutlocationalias(var0.location, var1, var2);
  return var3;
}

function addcalloutresponseevent(var0, var1, var2) {
  if(!isDefined(var1.responder)) {
    return;
  }

  if(var1.responder.team != var0.team) {
    return;
  }

  if(randomint(100) > anim.eventchance["response"]["callout"]) {
    return;
  }

  var3 = "neg";
  var4 = "callout";

  if(!var1.responder scripts\anim\battlechatter_ai::bccansee(var2, 1) && randomint(100) < anim.eventchance["response"]["callout_negative"]) {} else {
    var3 = "affirm";

    if(isDefined(var1.location)) {
      var5 = getvalidlocation(var2, var1.responder, "response");

      if(isDefined(var5) && isDefined(var5.locationaliases[0])) {
        var3 = var5.locationaliases[0];
        var4 = "location";
      }
    }
  }

  var1.responder scripts\anim\battlechatter_ai::addresponseevent(var4, var3, var0, 0.9);
}

function getthreatinfantrycallouttype(var0) {
  var1 = getvalidlocation(var0, self);
  var2 = getdirectionfacingclock(self.angles, self.origin, var0.origin);
  var3 = getresponder(64, 1024, "response");
  var4 = undefined;

  if(isDefined(var3)) {
    var4 = getdirectionfacingclock(var3.angles, var3.origin, var0.origin);
  }

  var5 = getdirectionfacingclock(anim.player.angles, anim.player.origin, var0.origin);

  if(self.team == "allies") {
    var6 = var5;
    var7 = anim.player;
  } else if(isDefined(var5)) {
    var6 = var6;
    var7 = var5;
  } else {
    var6 = var6;
    var7 = self;
  }

  var8 = getdistancemeters(var7.origin, var4.origin);
  self.possiblethreatcallouts = [];

  if(!isDefined(var5) && isexposed(var4, 0)) {
    addpossiblethreatcallout("exposed");
  }

  if(var6 == "11" || var6 == "12" || var6 == "1") {
    if(var4.origin[2] - var7.origin[2] >= level.heightforhighcallout) {
      addpossiblethreatcallout("target_elev");
    }

    if(var8 > level.mindistancecallout && var8 < level.maxdistancecallout) {
      addpossiblethreatcallout("target_distance");
    }
  }

  addpossiblethreatcallout("target_compass");

  if(isDefined(var5)) {
    if(canconcat(var5) && randomint(3) == 0) {
      addpossiblethreatcallout("concat_location");
    } else if(isDefined(getcannedresponse(var5, self))) {
      if(isDefined(var7)) {
        addpossiblethreatcallout("ai_location");
      } else {
        battlechatter_printwarning("Calling out a location at origin " + var5.origin + " with a canned response, but there are no AIs able to respond.");

        if(cansayplayername()) {
          addpossiblethreatcallout("player_location");
        }

        addpossiblethreatcallout("generic_location");
      }
    } else {
      if(isDefined(var7)) {
        addpossiblethreatcallout("ai_location");
      }

      if(cansayplayername() || isDefined(self.override_bc_playername)) {
        addpossiblethreatcallout("player_location");
      }

      addpossiblethreatcallout("generic_location");
    }
  }

  if(!self.possiblethreatcallouts.size) {
    return undefined;
  }

  var9 = getweightedchanceroll(self.possiblethreatcallouts, anim.threatcallouts);
  var10 = spawnStruct();
  var10.type = var9;
  var10.responder = var7;
  var10.responderclockdirection = var6;
  var10.playerclockdirection = var7;

  if(isDefined(var5)) {
    var10.location = var5;
  }

  if(battlechatter_canprint()) {
    var11 = 60;

    for(var12 = 0; var12 < self.possiblethreatcallouts.size; var12++) {
      var13 = scripts\engine\utility::ter_op(self.possiblethreatcallouts[var12] == var10.type, (0, 1, 0), (1, 1, 1));
      var11 -= 4;
    }
  }

  return var10;
}

function cancalloutlocation(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = "";
  }

  foreach(var4 in var0.locationaliases) {
    var5 = undefined;

    if(var1 == "stealth") {
      if(var2 == "checkin") {
        var6 = randomintrange_otn(1);
        var4 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_" + var2 + "_" + var4 + "_");
        var4 = createleaderalias(var4, var6);
      } else {
        var4 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_" + var2 + "_" + var4 + "_" + randomintrange_otn(1));
      }

      var7 = soundexists(var4);
    } else if(var1 == "response") {
      var5 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_resp_" + var4);
      var7 = soundexists(var5);
    } else {
      var5 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_callout_" + var4);
      var8 = getqacalloutalias(var4, 0);
      var9 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_concat_" + var4);
      var7 = soundexists(var5) || soundexists(var8) || soundexists(var9);
    }

    if(var7) {
      return var7;
    }

    if(isDefined(var5)) {
      var4 = var5;
    }

    battlechatter_printwarning("Missing location alias: " + var4);
  }

  return 0;
}

function canconcat(var0) {
  var1 = var0.locationaliases;

  foreach(var3 in var1) {
    if(iscallouttypeconcat(var3, self)) {
      return true;
    }
  }

  return false;
}

function getcannedresponse(var0) {
  var1 = undefined;
  var2 = self.locationaliases;

  foreach(var4 in var2) {
    if(iscallouttypeqa(var4, var0) && !isDefined(self.qafinished)) {
      var1 = var4;
      break;
    }

    if(iscallouttypereport(var4)) {
      var1 = var4;
    }
  }

  return var1;
}

function iscallouttypereport(var0) {
  return issubstr(var0, "_report");
}

function iscallouttypeconcat(var0, var1) {
  var0 = getloccalloutalias(var1, scripts\anim\battlechatter_ai::getbcstate() + "_location_concat_" + var0);

  if(soundexists(var0)) {
    return true;
  }

  return false;
}

function iscallouttypeqa(var0, var1) {
  if(issubstr(var0, "_qa") && soundexists(var0)) {
    return true;
  }

  var2 = getqacalloutalias(var1, var0, 0);

  if(soundexists(var2)) {
    return true;
  }

  return false;
}

function getloccalloutalias(var0) {
  var1 = undefined;

  if(self == anim.player) {
    var1 = "UN_plr_";
    var1 += var0;
  } else {
    if(scripts\anim\battlechatter_ai::getbcstate() == "combat") {
      var1 = bc_prefix();
    } else {
      var1 = bc_prefix("stealth");
    }

    var1 += var0;
  }

  return var1;
}

function getqacalloutalias(var0, var1) {
  var2 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_callout_" + var0);
  var2 += "_qa" + var1;
  return var2;
}

function addallowedthreatcallout(var0) {
  self.allowedcallouts[self.allowedcallouts.size] = var0;
}

function addpossiblethreatcallout(var0) {
  var1 = 0;

  if(isDefined(self.allowedcallouts)) {
    foreach(var3 in self.allowedcallouts) {
      if(var3 == var0) {
        if(!callouttypewillrepeat(var0)) {
          var1 = 1;
        }

        break;
      }
    }
  }

  if(!var1) {
    return var1;
  }

  self.possiblethreatcallouts[self.possiblethreatcallouts.size] = var0;
  return var1;
}

function callouttypewillrepeat(var0) {
  if(!isDefined(anim.lastteamthreatcallout[self.team])) {
    return false;
  }

  if(!isDefined(anim.lastteamthreatcallouttime[self.team])) {
    return false;
  }

  var1 = anim.lastteamthreatcallout[self.team];
  var2 = anim.lastteamthreatcallouttime[self.team];
  var3 = anim.teamthreatcalloutlimittimeout;

  if(var0 == var1 && gettime() - var2 < var3) {
    return true;
  }

  return false;
}

function setlastcallouttype(var0) {
  anim.lastteamthreatcallout[self.team] = var0;
  anim.lastteamthreatcallouttime[self.team] = gettime();
}

function getweightedchanceroll(var0, var1) {
  var2 = undefined;
  var3 = -1;

  foreach(var5 in var0) {
    if(var1[var5] <= 0) {
      continue;
    }

    var6 = randomint(var1[var5]);

    if(isDefined(var2) && var1[var2] >= 100) {
      if(var1[var5] < 100) {
        continue;
      }

      continue;
    }

    if(var1[var5] >= 100) {
      var2 = var5;
      var3 = var6;
      continue;
    }

    if(var6 > var3) {
      var2 = var5;
      var3 = var6;
    }
  }

  return var2;
}

function threatinfantryexposed(var0) {
  var1 = [];
  var1 = scripts\engine\utility::array_add(var1, "open");
  var1 = scripts\engine\utility::array_add(var1, "breaking");

  if(self.owner.team == "allies") {
    var1 = scripts\engine\utility::array_add(var1, "movement");
    var2 = getaicount("axis");

    if(var2 > 2) {
      var1 = scripts\engine\utility::array_add(var1, "group");
    }
  }

  var3 = var1[randomint(var1.size)];
  addthreatexposedalias(var3);
}

function playreactionevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.battlechatter.chatqueue["reaction"];
  var0 = self.battlechatter.chatqueue["reaction"].reactto;
  var1 = self.battlechatter.chatqueue["reaction"].modifier;
  thread lockaction(anim, self);

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
  }

  var2 = self.battlechatter.chatqueue["reaction"].eventtype;

  switch (var2) {
    case "casualty":
    case "danger":
    case "underfire":
    case "maneuver":
    case "movement":
      reactioncasualty(var0, var1, var2);
      break;
    case "taunt":
      reactiontaunt(var0, var1, var2);
      break;
    case "friendlyfire":
      reactionfriendlyfire(var0, var1, var2);
      break;
    case "takingfire":
      reactiontakingfire(var0, var1, var2);

      if(scripts\engine\utility::cointoss()) {
        var3 = getresponder(64, 1024, "response");

        if(isDefined(var3)) {
          if(scripts\engine\utility::cointoss()) {
            if(cansay(var3, "reaction", "ask_ok", 1)) {
              var3 scripts\anim\battlechatter_ai::addreactionevent("ask_ok", undefined, self, 1);
            }
          } else {
            var3 scripts\anim\battlechatter_ai::addresponseevent("covering", "fire", self, 1);
          }
        }
      }

      break;
    case "ask_ok":
      responsetakingfire(var0, "ask", "ok");
      var3 = getresponder(64, 1024, "response");

      if(isDefined(var3)) {
        var3 scripts\anim\battlechatter_ai::addresponseevent("im", "ok", self, 1);
      }

      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
  }

  self notify("done speaking");
}

function reactioncasualty(var0, var1, var2) {
  if(isDefined(var0) && !scripts\engine\trace::can_see_origin(var0.origin)) {
    return;
  }

  var3 = self;
  var3 endon("death");
  var3 endon("removed from battleChatter");
  var4 = createchatphrase(var3);
  addreactionalias(var4, "casualty");
  playphrase(var3, var4, self);
}

function reactiontaunt(var0, var1, var2) {
  var3 = self;
  self endon("death");
  self endon("removed from battleChatter");
  var4 = createchatphrase(var3);

  if(isDefined(var1) && var1 == "hostileburst") {
    addhostileburstalias(var4);
  } else {
    addtauntalias(var4, "taunt");
  }

  playphrase(var3, var4, self);
}

function reactionfriendlyfire(var0, var1, var2) {
  var3 = self;
  var3 endon("death");
  var3 endon("removed from battleChatter");
  var4 = createchatphrase(var3);
  addcheckfirealias(var4);
  playphrase(var3, var4, self);
}

function reactiontakingfire(var0, var1, var2) {
  var3 = self;
  var3 endon("death");
  var3 endon("removed from battleChatter");
  var4 = createchatphrase(var3);
  addtakingfirealias(var4);
  playphrase(var3, var4, self);
}

function responsetakingfire(var0, var1, var2) {
  var3 = self;
  var3 endon("death");
  var3 endon("removed from battleChatter");
  var4 = createchatphrase(var3);
  addresponsealias(var4, var1, var2);
  playphrase(var3, var4, self);
}

function playresponseevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.battlechatter.chatqueue["response"];
  var0 = self.battlechatter.chatqueue["response"].modifier;
  var1 = self.battlechatter.chatqueue["response"].respondto;

  if(!isalive(var1)) {
    return;
  }

  if(self.battlechatter.chatqueue["response"].modifier == "follow" && !scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }

  thread lockaction(anim, self);

  switch (self.battlechatter.chatqueue["response"].eventtype) {
    case "exposed":
      responsethreatexposed(var1, var0);
      break;
    case "callout":
      responsethreatcallout(var1, var0, self.enemy);
      break;
    case "ack":
      responsegeneric(var1, var0);
      break;
    case "location":
      responselocationcallout(var1, var0, self.enemy);
      break;
    default:
      responsegeneric(var1, var0);
      break;
  }

  self notify("done speaking");
}

function responsethreatexposed(var0, var1) {
  var2 = self;
  var2 endon("death");
  var2 endon("removed from battleChatter");

  if(!isalive(var0)) {
    return;
  }

  var3 = createchatphrase(var2);
  addthreatexposedalias(var3, var1);
  var3.bc_looktarget = var0;
  var3.master = 1;
  playphrase(var2, var3, self);
}

function responsethreatcallout(var0, var1, var2) {
  var3 = self.curevent.reportalias;
  var4 = self.curevent.location;
  var5 = self;
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var0)) {
    return;
  }

  var6 = createchatphrase(var5);
  var7 = 0;

  if(var1 == "echo") {
    var7 = addthreatcalloutecho(var6, var3, var0);
  } else if(var1 == "QA") {
    var7 = addthreatcalloutqa_nextline(var6, var0, var3, var4);
  } else {
    var7 = addthreatcalloutresponsealias(var6, var1, var2);
  }

  if(!var7) {
    return;
  }

  var6.bc_looktarget = var0;
  var6.master = 1;
  playphrase(var5, var6, self);
}

function responsegeneric(var0, var1) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var0)) {
    return;
  }

  var2 = self.battlechatter.chatqueue["response"].eventtype;
  var3 = self;
  var4 = createchatphrase(var3);
  addresponsealias(var4, var2, var1);
  var4.bc_looktarget = var0;
  var4.master = 1;
  playphrase(var3, var4, self);
}

function responselocationcallout(var0, var1, var2) {
  var3 = self.curevent.reportalias;
  var4 = self.curevent.location;
  var5 = self;
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var0)) {
    return;
  }

  var6 = createchatphrase(var5);
  var7 = addlocationresponsealias(var6, var1, var2);

  if(!var7) {
    return;
  }

  var6.bc_looktarget = var0;
  var6.master = 1;
  playphrase(var5, var6, self);
}

function playorderevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.battlechatter.chatqueue["order"];
  var0 = self.battlechatter.chatqueue["order"].modifier;
  var1 = self.battlechatter.chatqueue["order"].orderto;
  thread lockaction(anim, self);

  switch (self.battlechatter.chatqueue["order"].eventtype) {
    case "action":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = anim.player;
      }

      orderaction(var0, var1);
      break;
    case "move":
      ordermove(var0, var1);
      break;
    case "displace":
      orderdisplace(var0);
      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  self notify("done speaking");
}

function orderaction(var0, var1) {
  var2 = self;
  var2 endon("death");
  var2 endon("removed from battleChatter");
  var3 = createchatphrase(var2);
  tryorderto(var2, var3, var1);
  addorderalias(var3, "action", var0);
  playphrase(var2, var3, self);
}

function ordermove(var0, var1) {
  var2 = self;
  var2 endon("death");
  var2 endon("removed from battleChatter");
  var3 = createchatphrase(var2);
  tryorderto(var2, var3, var1);
  addorderalias(var3, "move", var0);
  playphrase(var2, var3, self);
}

function orderdisplace(var0) {
  self endon("death");
  self endon("removed from battleChatter");
  var1 = self;
  var2 = createchatphrase(var1);
  addorderalias(var2, "displace", var0);
  playphrase(var1, var2, self, 1);
}

function tryorderto(var0, var1) {
  if(randomint(100) > anim.eventchance["response"]["order"]) {
    if(!isDefined(var1) || isDefined(var1) && !isPlayer(var1)) {
      return;
    }
  }

  if(isDefined(var1) && isPlayer(var1) && isDefined(anim.player.bcnameid)) {
    addplayernamealias(var0);
    var0.bc_looktarget = anim.player;
    return;
  }

  if(isDefined(var1) && cansayname(var1)) {
    addnamealias(var0, var1.bcname);
    var0.bc_looktarget = var1;
    var1 scripts\anim\battlechatter_ai::addresponseevent("ack", "affirm", self, 0.9);
    return;
  }

  level notify("follow order", self);
}

function playvehicleevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.battlechatter.chatqueue["vehicle"];
  var0 = self.battlechatter.chatqueue["vehicle"].eventtype;
  var1 = self.battlechatter.chatqueue["vehicle"].modifier;
  thread lockaction(anim, self);

  if(self != anim.player) {
    self._blackboard.battlechatter_target = anim.player;
  }

  var2 = self;
  var3 = createchatphrase(var2);
  addvehiclealias(var3, var0, var1);
  playphrase(var2, var3, self);
  self notify("done speaking");
}

function playinformevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.battlechatter.chatqueue["inform"];
  var0 = self.battlechatter.chatqueue["inform"].modifier;

  if(var0 == "generic") {
    var0 = undefined;
  }

  thread lockaction(anim, self);

  if(self != anim.player) {
    self._blackboard.battlechatter_target = anim.player;
  }

  switch (self.battlechatter.chatqueue["inform"].eventtype) {
    case "incoming":
      informincoming(var0);
      break;
    case "attack":
      informattacking(var0);
      break;
    case "reloading":
      informreloading(var0);
      break;
    case "suppressed":
      informsuppressed(var0);
      break;
    case "killfirm":
      informkillfirm(var0);
      break;
  }

  self notify("done speaking");
}

function informreloading(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);
  addinformalias(var2, "reloading", var0);
  playphrase(var1, var2, self);
}

function informsuppressed(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);
  addinformalias(var2, "suppressed", var0);
  playphrase(var1, var2, self);
}

function informincoming(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);

  if(var0 == "grenade" || var0 == "rpg" || var0 == "sniper" || var0 == "molotov") {
    var2.master = 1;
  }

  addinformalias(var2, "incoming", var0);
  playphrase(var1, var2, self);
}

function informattacking(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);
  addinformalias(var2, var0);
  playphrase(var1, var2, self);
}

function informkillfirm(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);
  addinformalias(var2, "killfirm", var0, self.curevent.threat_type);
  playphrase(var1, var2, self);
}

function playcustomevent() {
  var0 = self.battlechatter.chatqueue["custom"];
  self.curevent = self.battlechatter.chatqueue["custom"];
  self.curevent.eventaction = "custom";
  self.curevent.eventtype = "generic";
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  thread lockaction(anim, var1, "custom");
  var2 = createchatphrase(var1);
  var2.soundaliases[0] = var1.customchatphrase;
  playphrase(var1, var2, self);
  var1 notify("done speaking");
  var1.customchatevent = undefined;
  var1.customchatphrase = undefined;
}

function playstealthevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self.battlechatter.chatqueue["stealth"].eventtype)) {
    iprintln("ChatQueue is undefined.What's going on?");
    return;
  }

  self.curevent = self.battlechatter.chatqueue["stealth"];
  var0 = self.battlechatter.chatqueue["stealth"].modifier;
  thread lockaction(anim, self);

  switch (self.battlechatter.chatqueue["stealth"].eventtype) {
    case "idle":
      stealthidle(var0);
      break;
    case "idle_alert":
      stealthidlealert(var0);
      break;
    case "radio":
      stealthradio(var0);
      break;
    case "investigate":
      stealthinvestigate(var0);
      break;
    case "hunt":
      stealthhunt(var0);
      break;
    case "combat":
      break;
    case "announce5":
    case "announce4":
    case "announce3":
    case "announce2":
    case "announce1":
      stealthannounce(var0);
      break;
  }

  self notify("done speaking");
}

function stealthidle(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");

  if(isDefined(self.battlechatter.stealthidledelay) && self.battlechatter.stealthidledelay > gettime()) {
    return;
  }

  var2 = createchatphrase(var1);
  addstealthalias(var2, "idle", var0);
  var3 = playphrase(var1, var2, self);

  if(stealthdocustombc(var3)) {
    return;
  }

  if(var3 && isDefined(var2.checkin) && var1 scripts\anim\battlechatter_ai::getbcstate() == "idle") {
    foreach(var5 in var2.responsealiases) {
      var2.soundaliases = [];
      var2.soundaliases[0] = var5;

      if(isradioline(var5)) {
        var3 = stealthcommander(var1, var2.soundaliases[0]);
      } else {
        commander_delay(var1);
        GscBinSkip4(0x6e, var1, var2.soundaliases[0], 1, 1);
      }

      if(!var3 || var1 scripts\anim\battlechatter_ai::getbcstate() != "idle") {
        break;
      }
    }

    return;
  }

  if(var3 && isDefined(var2.callin)) {
    if(isDefined(var2.responsealiases[0]) && randomint(3)) {
      GscBinSkip4(0x6e, var1, var2.responsealiases[0]);
    }

    return;
  }

  if(var3 && randomint(3)) {
    var7 = ["dx_bcs_rul_contsweep_1", "dx_bcs_rul_contsweep_2", "dx_bcs_rul_contsweep_3", "dx_bcs_rul_contsweep_n_1", "dx_bcs_rul_contsweep_s_1", "dx_bcs_rul_contsweep_e_1", "dx_bcs_rul_contsweep_w_1"];

    if(issubstr(var2.soundaliases[0], "_n_")) {
      var7 = scripts\engine\utility::array_remove(var7, "dx_bcs_rul_contsweep_n_1");
    } else if(issubstr(var2.soundaliases[0], "_s_")) {
      var7 = scripts\engine\utility::array_remove(var7, "dx_bcs_rul_contsweep_s_1");
    } else if(issubstr(var2.soundaliases[0], "_e_")) {
      var7 = scripts\engine\utility::array_remove(var7, "dx_bcs_rul_contsweep_e_1");
    } else if(issubstr(var2.soundaliases[0], "_w_")) {
      var7 = scripts\engine\utility::array_remove(var7, "dx_bcs_rul_contsweep_w_1");
    }

    GscBinSkip4(0x6e, var1, scripts\engine\utility::random(var7));
  }
}

function stealthidlealert(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);
  addstealthalias(var2, "idle_alert", var0);
  var3 = playphrase(var1, var2, self);

  if(stealthdocustombc(var3)) {
    return;
  }

  if(var3 && isDefined(var2.checkin) && var1 scripts\anim\battlechatter_ai::getbcstate() == "alert") {
    foreach(var5 in var2.responsealiases) {
      var2.soundaliases = [];
      var2.soundaliases[0] = var5;

      if(isradioline(var5)) {
        var3 = stealthcommander(var1, var2.soundaliases[0]);
      } else {
        commander_delay(var1);
        GscBinSkip4(0x6e, var1, var2.soundaliases[0], 1, 1);
      }

      if(!var3 || var1 scripts\anim\battlechatter_ai::getbcstate() != "alert") {
        break;
      }
    }

    return;
  }

  if(var3 && isDefined(var2.callin)) {
    if(isDefined(var2.responsealiases[0]) && randomint(4)) {
      GscBinSkip4(0x6e, var1, var2.responsealiases[0]);
    }

    return;
  }
}

function stealthradio(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);
  addstealthalias(var2, "radio", var0);
  var3 = playphrase(var1, var2, self);

  if(stealthdocustombc(var3)) {
    return;
  }

  if(var3) {
    foreach(var5 in var2.responsealiases) {
      var2.soundaliases = [];
      var2.soundaliases[0] = var5;

      if(isradioline(var5)) {
        var3 = stealthcommander(var1, var2.soundaliases[0]);
      } else {
        commander_delay(var1);
        GscBinSkip4(0x6e, var1, var2.soundaliases[0], 1, 1);
      }

      if(!var3) {
        break;
      }
    }

    return;
  }
}

function stealthcommander(var0) {
  if(getDvar("bcs_commander_off") == self.team || getDvar("bcs_commander_off") == "all") {
    return false;
  }

  commander_delay();
  GscBinSkip4(0x35, var0, undefined, 1);
}

function commander_delay() {
  wait randomfloatrange(0.3, 0.4);
}

function stealthcustombc(var0) {
  wait randomfloatrange(0.3, 0.4);

  if(isradioline(var0)) {
    thread playradio(var0);
    return;
  }

  var1 = spawn("script_origin", self gettagorigin("j_head"));
  var1 linkTo(self);

  if(battlechatter_canprint()) {
    battlechatter_print([var0 + " cusBC"]);
  }

  if(soundexists(var0)) {
    var1 playSound(var0, var0, 1);
    var1 waittill(var0);
  } else {
    battlechatter_printwarning("Tried to play an alias that doesn't exist: '" + var0 + "'.");
  }

  var1 delete();
}

function stealthdocustombc(var0) {
  if(isDefined(self.battlechatter.custombc_alias2) && self.battlechatter.custombc_alias2 == "") {
    self.battlechatter.custombc_alias2 = undefined;
    return true;
  } else if(var0 && isDefined(self.battlechatter.custombc_alias2)) {
    GscBinSkip4(0x35, self.battlechatter.custombc_alias2);
  }

  return false;
}

function stealthinvestigate(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);
  addstealthalias(var2, "investigate", var0);
  var3 = playphrase(var1, var2, self);

  if(stealthdocustombc(var3)) {
    return;
  }

  if(var3 && (isDefined(var2.callin) || isDefined(var2.update))) {
    if(isDefined(var2.responsealiases[0]) && randomint(4)) {
      GscBinSkip4(0x6e, var1, var2.responsealiases[0]);
    }

    return;
  }
}

function stealthhunt(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);
  addstealthalias(var2, "hunt", var0);
  var3 = playphrase(var1, var2, self);

  if(stealthdocustombc(var3)) {
    return;
  }

  if(var3 && isDefined(var2.responsealiases[0])) {
    if(randomint(4)) {
      GscBinSkip4(0x6e, var1, var2.responsealiases[0]);
    }

    return;
  }
}

function stealthcombat(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);
  addstealthalias(var2, "combat", var0);
  playphrase(var1, var2, self);
}

function stealthannounce(var0) {
  var1 = self;
  var1 endon("death");
  var1 endon("removed from battleChatter");
  var2 = createchatphrase(var1);
  addstealthalias(var2, "announce", var0);
  var3 = playphrase(var1, var2, self);

  if(var3 && isDefined(var2.responsealiases[0])) {
    if(randomint(4)) {
      GscBinSkip4(0x6e, var1, var2.responsealiases[0]);
    }

    return;
  }
}

function playphrase(var0, var1, var2) {
  anim endon("battlechatter disabled");
  self endon("dog_attacks_ai");
  self endon("death");
  var3 = 0;

  if(isDefined(var2)) {
    return var3;
  }

  if(battlechatter_canprint() || battlechatter_canprintdump()) {
    if(isfiltered(var1.curevent.eventaction)) {
      if(battlechatter_canprint()) {
        battlechatter_print([var1.curevent.eventaction + " is filtered"]);
      }
    } else {
      var4 = [];

      for(var5 = 0; var5 < var0.soundaliases.size; var5++) {
        var6 = "";

        if(isDefined(var0.soundevents[var5])) {
          var6 = " " + var0.soundevents[var5];
        }

        var4 = var0.soundaliases[var5] + var6;
      }

      if(battlechatter_canprint()) {
        battlechatter_print(var4);
      }

      if(battlechatter_canprintdump()) {
        var7 = self.curevent.eventaction + "_" + self.curevent.eventtype;

        if(isDefined(self.curevent.modifier)) {
          var7 += "_" + self.curevent.modifier;
        }

        thread battlechatter_printdump(var4, var7);
      }
    }
  }

  for(var5 = 0; var5 < var0.soundaliases.size; var5++) {
    if(!self.battlechatterallowed) {
      if(!is_friendlyfire_event(self.curevent)) {
        continue;
      } else if(!can_say_friendlyfire(0)) {
        continue;
      }
    }

    if(!isDefined(self._animactive) && self != anim.player || isDefined(self._animactive) && self._animactive > 0) {
      if(!istrue(self.battlechatter.friendlyfire_force)) {
        continue;
      }
    }

    if(isfiltered(var1.curevent.eventaction)) {
      wait 0.85;
      continue;
    }

    if(!soundexists(var0.soundaliases[var5])) {
      battlechatter_printwarning("Tried to play an alias that doesn't exist: '" + var0.soundaliases[var5] + "'.");
      continue;
    }

    var8 = gettime();

    if(self == anim.player) {
      var9 = spawn("script_origin", anim.player getEye());
      var9 linkTo(self);
    } else if(isradioline(var0.soundaliases[var5])) {
      var9 = spawn("script_origin", self gettagorigin("J_Hip_RI"));
      var9 linkTo(var1);
    } else {
      var9 = spawn("script_origin", self gettagorigin("j_head"));
      var9 linkTo(var1);
    }

    thread stop_speaking(var0.soundaliases[var5], var9);
    set_battlechatter_reaction_alias(var0.soundaliases[var5]);

    if(var0.master && self.team == "allies") {
      thread scripts\sp\anim::anim_facialfiller(var0.soundaliases[var5], var0.bc_looktarget);

      if(isDefined(self.classname) && self.classname == "player") {
        if(!scripts\sp\player::belowcriticalhealththreshold()) {
          var3 = _playSound(var9, var0.soundaliases[var5]);
        }
      } else {
        var3 = _playSound(var9, var0.soundaliases[var5]);
      }

      var9 waittill(var0.soundaliases[var5]);
      self notify(var0.soundaliases[var5]);
    } else {
      thread scripts\sp\anim::anim_facialfiller(var0.soundaliases[var5], var0.bc_looktarget);

      if(isDefined(self.classname) && self.classname == "player") {
        if(!scripts\sp\player::belowcriticalhealththreshold()) {
          var3 = _playSound(var9, var0.soundaliases[var5]);
        }
      } else {
        var3 = _playSound(var9, var0.soundaliases[var5]);
      }

      var9 waittill(var0.soundaliases[var5]);
      self notify(var0.soundaliases[var5]);
    }

    var9 delete();

    if(gettime() < var8 + 250) {}
  }

  self notify("playPhrase_done");

  if(self != anim.player) {
    self._blackboard.battlechatter_target = undefined;
    self._blackboard.battlechatter_alias = undefined;
  }

  dotypelimit(var1, var1.curevent.eventaction, var1.curevent.eventtype);
  return var3;
}

function _playSound(var0, var1) {
  self notify(var1 + "_started");
  var2 = 1;
  var0 playSound(var1, var1, 1);

  if(isDefined(self.team)) {
    anim.lastteamspokentime[self.team] = gettime();
  }

  return var2;
}

function playradioecho(var0, var1, var2, var3) {
  anim endon("battlechatter disabled");
  self endon("dog_attacks_ai");
  self endon("death");

  if(getDvar("bcs_radioecho_off") == self.team || getDvar("bcs_radioecho_off") == "all") {
    return;
  }

  if(isDefined(self.battlechatter.customgroup)) {
    var4 = self.battlechatter.customgroup;
    self.battlechatter.customgroup = undefined;
  } else if(isDefined(scripts\stealth\group::getgroup(self.script_stealthgroup))) {
    var4 = level.stealth.groupdata.groups[self.script_stealthgroup].members;
  } else {
    var4 = anim.squads[self.team].members;
  }

  var4 = scripts\engine\utility::array_remove(var4, self);

  foreach(var6 in var4) {
    if(isDefined(var6.unittype) && var6.unittype == "dog") {
      var4 = scripts\engine\utility::array_remove(var4, var6);
    }
  }

  var4 = scripts\engine\utility::array_removeundefined(var4);

  if(var4.size == 0) {
    return;
  }

  var8 = scripts\engine\sp\utility::get_within_range(level.player.origin, var4, sqrt(level.bcs_maxstealthdistsqrdfromplayer));

  foreach(var6 in var8) {
    thread _playradioecho(var6, var2, var3, self, var4);
  }
}

function _playradioecho(var0, var1, var2, var3, var4) {
  anim endon("battlechatter disabled");
  self endon("dog_attacks_ai");
  self endon("death");
  var2 endon("death");

  if(!istrue(var3)) {
    var5 = var0 + "_started";
    var6 = var2 scripts\engine\utility::waittill_notify_or_timeout_return(var5, 2);

    if(var6 == var5) {
      return;
    }
  }

  wait 0.15;

  if(isDefined(var4)) {
    var0 = var4;
  } else if(isDefined(var1)) {
    var7 = strtok(var0, "_");
    var0 = "";

    for(var8 = 0; var8 < var7.size; var8++) {
      if(var8 == var7.size - 1) {
        var0 = var0 + "r_" + var7[var8];
        continue;
      }

      var0 = var0 + var7[var8] + "_";
    }
  }

  thread playradio(var0);
}

function playradio(var0) {
  if(self == anim.player) {
    var1 = spawn("script_origin", anim.player getEye());
    var1 linkTo(self);
  } else {
    var1 = spawn("script_origin", self gettagorigin("J_Hip_RI"));
    var1 linkTo(self);
  }

  if(battlechatter_canprint()) {
    battlechatter_print([var1 + " radio"]);
  }

  if(soundexists(var1)) {
    var1 playSound(var1, var1, 1);
    var1 waittill(var1);
  } else {
    battlechatter_printwarning("Tried to play an alias that doesn't exist: '" + var1 + "'.");
  }

  var1 delete();
}

function set_battlechatter_reaction_alias(var0) {
  var1 = strtok(var0, "_");

  if(!isDefined(self._blackboard)) {
    return;
  }

  if(scripts\engine\utility::array_contains(var1, "killfirm") || scripts\engine\utility::array_contains(var1, "coverme") || scripts\engine\utility::array_contains(var1, "suppress")) {
    self._blackboard.battlechatter_alias = "action";
    return;
  }

  if(scripts\engine\utility::array_contains(var1, "attack") && !scripts\engine\utility::array_contains(var1, "grenade")) {
    self._blackboard.battlechatter_alias = "attacking_action";
    return;
  }

  if(scripts\engine\utility::array_contains(var1, "grenade") || scripts\engine\utility::array_contains(var1, "inform") && !scripts\engine\utility::array_contains(var1, "taking")) {
    self._blackboard.battlechatter_alias = "defending_action";
    return;
  }

  if(scripts\engine\utility::array_contains(var1, "order")) {
    self._blackboard.battlechatter_alias = "order_action";
    return;
  }

  if(scripts\engine\utility::array_contains(var1, "location") || scripts\engine\utility::array_contains(var1, "contact") || scripts\engine\utility::array_contains(var1, "target") || scripts\engine\utility::array_contains(var1, "exposed") && !scripts\engine\utility::array_contains(var1, "acquired")) {
    self._blackboard.battlechatter_alias = "threat_infantry";
    return;
  }

  if(scripts\engine\utility::array_contains(var1, "taking")) {
    self._blackboard.battlechatter_alias = "takingfire";
    return;
  }

  if(scripts\engine\utility::array_contains(var1, "response") || scripts\engine\utility::array_contains(var1, "affirm") || scripts\engine\utility::array_contains(var1, "acquired")) {
    self._blackboard.battlechatter_alias = "response";
    return;
  }
}

function stop_speaking(var0, var1) {
  var1 endon("death");
  self waittill("death");

  if(isDefined(var1)) {
    var1 stopsounds();
    waitframe();

    if(isDefined(var1)) {
      var1 notify(var0);
      var1 delete();
      return;
    }

    return;
  }
}

function is_friendlyfire_event(var0) {
  if(!isDefined(var0.eventaction) || !isDefined(var0.eventtype)) {
    return false;
  }

  if(var0.eventaction == "reaction" && var0.eventtype == "friendlyfire") {
    return true;
  }

  return false;
}

function isspeakingfailsafe(var0) {
  self endon("death");
  self endon("removed from battleChatter");
  wait 25;
  clearisspeaking(var0);
}

function clearisspeaking(var0) {
  self.battlechatter.isspeaking = 0;
  self.battlechatter.chatqueue[var0].expiretime = 0;
  self.battlechatter.chatqueue[var0].priority = 0;
  self.battlechatter.nextsaytimes[var0] = gettime() + anim.eventactionminwait[var0]["self"];
}

function lockaction(var0, var1, var2) {
  anim endon("battlechatter disabled");
  var3 = var0.squad;
  var4 = var0.team;
  var0.battlechatter.isspeaking = 1;
  thread isspeakingfailsafe(var0);
  var3.ismembersaying[var1] = 1;
  var3.numspeakers++;
  anim.isteamspeaking[var4] = 1;
  anim.isteamsaying[var4][var1] = 1;
  var5 = var0 scripts\engine\utility::waittill_any_return("death", "done speaking", "cancel speaking");
  var3.ismembersaying[var1] = 0;
  var3.numspeakers--;
  anim.isteamspeaking[var4] = 0;
  anim.isteamsaying[var4][var1] = 0;

  if(var5 == "cancel speaking") {
    return;
  }

  anim.lastteamspeaktime[var4] = gettime();

  if(isalive(var0)) {
    clearisspeaking(var0, var1);
  }

  var3.nextsaytimes[var1] = gettime() + anim.eventactionminwait[var1]["squad"];
}

function updatecontact(var0, var1) {
  if(!isDefined(self.squadlist[var0].firstcontact)) {
    self.squadlist[var0].firstcontact = gettime();
  }

  if(gettime() - self.squadlist[var0].lastcontact > anim.bcs_lastcontactdelay) {
    var2 = 0;

    for(var3 = 0; var3 < self.members.size; var3++) {
      if(self.members[var3] != var1 && isalive(self.members[var3].enemy) && isDefined(self.members[var3].enemy.squad) && self.members[var3].enemy.squad.squadname == var0) {
        var2 = 1;
      }
    }

    if(!var2) {
      self.squadlist[var0].firstcontact = gettime();
      self.squadlist[var0].calledout = 0;
    }
  }

  self.squadlist[var0].lastcontact = gettime();
}

function cansaycontact(var0) {
  if(gettime() - self.squad.squadlist[var0.squad.squadname].firstcontact < 500 || gettime() - self.squad.squadlist[var0.squad.squadname].lastcontact > anim.bcs_lastcontactdelay) {
    if(battlechatter_canprint()) {
      iprintln("time: " + gettime());
      iprintln("firstContact: " + self.squad.squadlist[var0.squad.squadname].firstcontact);
      iprintln("lastContact: " + self.squad.squadlist[var0.squad.squadname].lastcontact);
    }

    return true;
  }

  return false;
}

function cansay(var0, var1, var2) {
  self endon("death");
  self endon("removed from battleChatter");
  var3 = isPlayer(self);

  if(!isDefined(anim.player)) {
    return false;
  }

  if(!isDefined(anim.player.battlechatterallowed) || !anim.player.battlechatterallowed && var3) {
    return false;
  }

  if(!istrue(self.battlechatterallowed) || !isDefined(self.battlechatter.nextsaytimes)) {
    return false;
  }

  if(var0 == "stealth") {
    if(distancesquared(anim.player.origin, self.origin) > level.bcs_maxstealthdistsqrdfromplayer) {
      return false;
    }
  } else if(distancesquared(anim.player.origin, self.origin) > level.bcs_maxtalkingdistsqrdfromplayer) {
    return false;
  }

  if(isDefined(var2) && var2 >= 1) {
    return true;
  }

  var4 = gettime();

  if(issentient(self) && self.ignoreall) {
    return false;
  }

  if(isDefined(self.fnisinstealthidlescriptedanim) && self[[self.fnisinstealthidlescriptedanim]]()) {
    return false;
  }

  if(!var3 && self isinscriptedstate()) {
    return false;
  }

  if(var4 + anim.eventactionminwait[var0]["self"] < self.battlechatter.nextsaytimes[var0]) {
    return false;
  }

  if(var4 + anim.eventactionminwait[var0]["squad"] < self.squad.nextsaytimes[var0]) {
    return false;
  }

  if(isDefined(var1) && typelimited(var0, var1)) {
    return false;
  }

  if(isDefined(var1)) {
    if(isDefined(self.battlechatter.overrides) && isDefined(self.battlechatter.overrides.eventpriority) && isDefined(self.battlechatter.overrides.eventpriority[var0]) && isDefined(self.battlechatter.overrides.eventpriority[var0][var1])) {
      if(self.battlechatter.overrides.eventpriority[var0][var1] < self.battlechatter.minpriority) {
        return false;
      }
    } else if(anim.eventpriority[var0][var1] < self.battlechatter.minpriority) {
      return false;
    }
  }

  return true;
}

function gethighestpriorityevent() {
  var0 = undefined;
  var1 = -999999999;

  foreach(var3 in self.battlechatter.chatqueue) {
    if(isvalidevent(var4)) {
      if(var3.priority > var1) {
        var0 = var4;
        var1 = var3.priority;
      }
    }
  }

  return var0;
}

function globalchatqueuecheck(var0) {
  if(!anim.isteamsaying[anim.teams[0]][var0] && !anim.isteamsaying[anim.teams[1]][var0] && !anim.isteamsaying[anim.teams[2]][var0] && !anim.isteamsaying[anim.teams[3]][var0]) {
    return true;
  }

  return false;
}

function gettargettingai(var0) {
  var1 = self.squad;
  var2 = [];

  for(var3 = 0; var3 < var1.members.size; var3++) {
    if(isDefined(var1.members[var3].enemy) && var1.members[var3].enemy == var0) {
      var2 = var1.members[var3];
    }
  }

  if(!isDefined(var2[0])) {
    return undefined;
  }

  var4 = undefined;

  for(var3 = 0; var3 < var2.size; var3++) {
    if(cansay(var2[var3], "response")) {
      return var4;
    }
  }

  return scripts\engine\utility::getclosest(self.origin, var2);
}

function getqueueevents() {
  var0 = [];
  var1 = [];
  var0 = "custom";
  var0 = "response";
  var0 = "order";
  var0 = "threat";
  var0 = "inform";
  var0 = "stealth";

  for(var2 = var0.size - 1; var2 >= 0; var2--) {
    for(var3 = 1; var3 <= var2; var3++) {
      if(self.battlechatter.chatqueue[var0[var3 - 1]].priority < self.battlechatter.chatqueue[var0[var3]].priority) {
        var4 = var0[var3 - 1];
        var0 = var0[var3];
        var0 = var4;
      }
    }
  }

  var5 = 0;

  for(var2 = 0; var2 < var0.size; var2++) {
    var6 = geteventstate(var0[var2]);

    if(var6 == " valid" && !var5) {
      var5 = 1;
      var1 = "g " + var0[var2] + var6 + " " + self.battlechatter.chatqueue[var0[var2]].priority;
      continue;
    }

    if(var6 == " valid") {
      var1 = "y " + var0[var2] + var6 + " " + self.battlechatter.chatqueue[var0[var2]].priority;
      continue;
    }

    if(self.battlechatter.chatqueue[var0[var2]].expiretime == 0) {
      var1 = "b " + var0[var2] + var6 + " " + self.battlechatter.chatqueue[var0[var2]].priority;
      continue;
    }

    var1 = "r " + var0[var2] + var6 + " " + self.battlechatter.chatqueue[var0[var2]].priority;
  }

  return var1;
}

function geteventstate(var0) {
  var1 = "";

  if(self.squad.ismembersaying[var0]) {
    var1 += " playing";
  }

  if(gettime() > self.battlechatter.chatqueue[var0].expiretime) {
    var1 += " expired";
  }

  if(gettime() < self.squad.nextsaytimes[var0]) {
    var1 += " cantspeak";
  }

  if(var1 == "") {
    var1 = " valid";
  }

  return var1;
}

function isfiltered(var0) {
  if(getDvar("bcs_filter" + var0, "off") == "on" || getDvar("bcs_filter" + var0, "off") == "1") {
    return true;
  }

  switch (var0) {
    case "threat":
      if(istrue(self.battlechatter.filterthreat)) {
        return true;
      }

      break;
    case "inform":
      if(istrue(self.battlechatter.filterinform)) {
        return true;
      }

      break;
    case "vehicle":
      if(istrue(self.battlechatter.filtervehicle)) {
        return true;
      }

      break;
    case "order":
      if(istrue(self.battlechatter.filterorder)) {
        return true;
      }

      break;
    case "reaction":
      if(istrue(self.battlechatter.filterreaction)) {
        return true;
      }

      break;
    case "response":
      if(istrue(self.battlechatter.filterresponse)) {
        return true;
      }

      break;
    case "stealth":
      if(istrue(self.battlechatter.filterstealth)) {
        return true;
      }

      break;
  }

  return false;
}

function isvalidevent(var0) {
  var1 = gettime();

  if(!self.squad.ismembersaying[var0] && !anim.isteamsaying[anim.teams[0]][var0] && !anim.isteamsaying[anim.teams[1]][var0] && !anim.isteamsaying[anim.teams[2]][var0] && !anim.isteamsaying[anim.teams[3]][var0] && gettime() < self.battlechatter.chatqueue[var0].expiretime && gettime() > scaledsaytime(self.squad.nextsaytimes[var0])) {
    if(!typelimited(var0, self.battlechatter.chatqueue[var0].eventtype)) {
      return true;
    }
  }

  return false;
}

function typelimited(var0, var1) {
  if(!isDefined(anim.eventtypeminwait[var0][var1])) {
    return false;
  }

  if(!isDefined(self.squad.nexttypesaytimes[var0][var1])) {
    return false;
  }

  if(gettime() > self.squad.nexttypesaytimes[var0][var1]) {
    return false;
  }

  return true;
}

function dotypelimit(var0, var1) {
  if(!isDefined(anim.eventtypeminwait[var0][var1])) {
    return;
  }

  if(isDefined(self.battlechatter.overrides) && isDefined(self.battlechatter.overrides.eventtypeminwait) && isDefined(self.battlechatter.overrides.eventtypeminwait[var0]) && isDefined(self.battlechatter.overrides.eventtypeminwait[var0][var1])) {
    self.squad.nexttypesaytimes[var0][var1] = gettime() + self.battlechatter.overrides.eventtypeminwait[var0][var1];
    return;
  }

  self.squad.nexttypesaytimes[var0][var1] = gettime() + anim.eventtypeminwait[var0][var1];
}

function scaledsaytime(var0) {
  if(!isDefined(self.battlechatter_saytimescaled)) {
    return var0;
  }

  var1 = var0 - gettime();

  if(var1 <= 0) {
    return var0;
  } else {
    var1 -= var1 * self.battlechatter_saytimescaled;
    var1 += gettime();
  }

  return var1;
}

function bcissniper() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isalive(self)) {
    return 0;
  }

  if(isPlayer(self)) {
    return 0;
  }

  if(!isDefined(self.weapon)) {
    return 0;
  }

  return scripts\anim\utility_common::issniperrifle(self.weapon);
}

function isexposed(var0) {
  if(distancesquared(self.origin, anim.player.origin) > 2250000) {
    return false;
  }

  if(isDefined(var0) && var0 && isDefined(getlocation())) {
    return false;
  }

  var1 = bcgetclaimednode();

  if(!isDefined(var1)) {
    return true;
  }

  if(!isnodecoverorconceal()) {
    return false;
  }

  return true;
}

function isnodecoverorconceal() {
  var0 = self.node;

  if(!isDefined(var0)) {
    return false;
  }

  if(issubstr(var0.type, "Cover") || issubstr(var0.type, "Conceal")) {
    return true;
  }

  return false;
}

function squadhasofficer(var0) {
  if(var0.officercount > 0) {
    return 1;
  }

  return 0;
}

function isofficer() {
  var0 = getrank();

  if(!isDefined(var0)) {
    return false;
  }

  if(var0 == "sergeant" || var0 == "lieutenant" || var0 == "captain" || var0 == "sergeant") {
    return true;
  }

  return false;
}

function bcgetclaimednode() {
  if(isPlayer(self)) {
    return self.node;
  }

  return scripts\anim\utility_common::getclaimednode();
}

function enemy_team_name() {
  if(issentient(self) && self isbadguy()) {
    return 1;
  }

  return 0;
}

function getname() {
  if(enemy_team_name()) {
    var0 = self.ainame;
  } else if(self.team == "allies") {
    var0 = self.name;
  } else {
    var0 = undefined;
  }

  if(!isDefined(var0)) {
    return undefined;
  }

  var1 = strtok(var0, " ");

  if(var1.size < 2) {
    return var0;
  }

  return var1[1];
}

function getrank() {
  return self.airank;
}

function getcallsign() {
  return self.callsign;
}

function getclosestfriendlyspeaker(var0) {
  var1 = getspeakers(var0, self.team);
  var2 = scripts\engine\utility::getclosest(self.origin, var1);
  return var2;
}

function getspeakers(var0, var1) {
  var2 = [];
  var3 = getaiarray(var1);

  for(var4 = 0; var4 < var3.size; var4++) {
    if(var3[var4] == self) {
      continue;
    }

    if(!cansay(var3[var4], var0)) {
      continue;
    }

    var2 = var3[var4];
  }

  return var2;
}

function getresponder(var0, var1, var2) {
  var3 = undefined;

  if(!isDefined(var2)) {
    var2 = "response";
  }

  var0 *= var0;
  var1 *= var1;
  var4 = [];
  var5 = self.squad.members.size;

  for(var6 = 0; var6 < var5; var6++) {
    var7 = self.squad.members[var6];

    if(var7 == self) {
      continue;
    }

    if(!isalive(var7)) {
      continue;
    }

    var8 = distancesquared(self.origin, var7.origin);

    if(var8 < var0) {
      continue;
    }

    if(var8 > var1) {
      continue;
    }

    if(isusingsamevoice(var7)) {
      continue;
    }

    var4 = var7;
  }

  var9 = scripts\engine\utility::array_randomize(var4);
  var5 = var9.size;

  for(var6 = 0; var6 < var5; var6++) {
    var7 = var9[var6];

    if(!cansay(var7, var2)) {
      continue;
    }

    var3 = var7;

    if(cansayname(var3)) {
      break;
    }
  }

  return var3;
}

function getlocation() {
  var0 = get_all_my_locations();
  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = undefined;

  if(var0.size) {
    var1 = _getlocation(var0);
  }

  return var1;
}

function getvalidlocation(var0, var1, var2) {
  var3 = get_all_my_locations();
  var3 = scripts\engine\utility::array_randomize(var3);
  var4 = undefined;

  if(var3.size) {
    foreach(var4 in var3) {
      if(!cancalloutlocation(var0, var4, var1, var2)) {
        var3 = scripts\engine\utility::array_remove(var3, var4);
      }
    }

    var4 = _getlocation(var3, var1);
  }

  return var4;
}

function _getlocation(var0, var1) {
  foreach(var3 in var0) {
    if(isDefined(var3.islandmark) && !location_called_out_ever(var3)) {
      return var3;
    }

    if(!location_called_out_ever(var3) && scripts\engine\utility::cointoss()) {
      return var3;
    }

    if(!location_called_out_recently(var3, var1) && isDefined(var3.islandmark) && randomint(5) == 0) {
      return var3;
    }

    if(!location_called_out_recently(var3, var1)) {
      return var3;
    }
  }

  return undefined;
}

function get_all_my_locations() {
  var0 = anim.bcs_locations;
  var1 = self getistouchingentities(var0);
  var2 = [];

  foreach(var4 in var1) {
    if(isDefined(var4.locationaliases)) {
      if(isDefined(var4.islandmark) && anim.player istouching(var4)) {
        continue;
      }

      var2 = var4;
    }
  }

  return var2;
}

function update_bcs_locations() {
  if(isDefined(anim.bcs_locations)) {
    anim.bcs_locations = scripts\engine\utility::array_removeundefined(anim.bcs_locations);
    return;
  }
}

function is_in_callable_location() {
  var0 = get_all_my_locations();

  foreach(var2 in var0) {
    if(!location_called_out_recently(var2)) {
      return true;
    }
  }

  return false;
}

function location_called_out_ever(var0) {
  var1 = location_get_last_callout_time(var0);

  if(!isDefined(var1)) {
    return false;
  }

  return true;
}

function location_called_out_recently(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  }

  var2 = location_get_last_callout_time(var0);

  if(!isDefined(var2)) {
    return false;
  }

  if(var1 == "stealth") {
    var3 = var2 + anim.eventactionminwait["stealth"]["location_repeat"];
  } else {
    var3 += anim.eventactionminwait["threat"]["location_repeat"];
  }

  if(gettime() < var3) {
    return true;
  }

  return false;
}

function location_add_last_callout_time(var0) {
  anim.locationlastcallouttimes[var0.classname] = gettime();
}

function location_get_last_callout_time(var0) {
  if(isDefined(anim.locationlastcallouttimes[var0.classname])) {
    return anim.locationlastcallouttimes[var0.classname];
  }

  return undefined;
}

function getrelativeangles(var0) {
  var1 = var0.angles;

  if(!isPlayer(var0)) {
    var2 = bcgetclaimednode(var0);

    if(isDefined(var2)) {
      var1 = var2.angles;
    }
  }

  return var1;
}

function sideisleftright(var0) {
  if(var0 == "left" || var0 == "right") {
    return true;
  }

  return false;
}

function getdirectionfacingflank(var0, var1, var2) {
  var3 = vectortoangles(var2);
  var4 = vectortoangles(var1 - var0);
  var5 = var3[1] - var4[1];
  var5 += 360;
  var5 = int(var5) % 360;

  if(var5 > 315 || var5 < 45) {
    var6 = "front";
  } else if(var6 < 135) {
    var6 = "right";
  } else if(var6 < 225) {
    var6 = "rear";
  } else {
    var6 = "left";
  }

  return var6;
}

function normalizecompassdirection(var0) {
  var1 = undefined;

  switch (var0) {
    case "north":
      var1 = "n";
      break;
    case "northwest":
      var1 = "nw";
      break;
    case "west":
      var1 = "w";
      break;
    case "southwest":
      var1 = "sw";
      break;
    case "south":
      var1 = "s";
      break;
    case "southeast":
      var1 = "se";
      break;
    case "east":
      var1 = "e";
      break;
    case "northeast":
      var1 = "ne";
      break;
    case "impossible":
      var1 = "impossible";
      break;
    default:
      return;
  }

  return var1;
}

function getdirectioncompass(var0, var1) {
  var2 = vectortoangles(var1 - var0);
  var3 = var2[1];
  var4 = getnorthyaw();
  var3 -= var4;

  if(var3 < 0) {
    var3 += 360;
  } else if(var3 > 360) {
    var3 -= 360;
  }

  if(var3 < 22.5 || var3 > 337.5) {
    var5 = "north";
  } else if(var4 < 67.5) {
    var5 = "northwest";
  } else if(var5 < 112.5) {
    var5 = "west";
  } else if(var5 < 157.5) {
    var5 = "southwest";
  } else if(var5 < 202.5) {
    var5 = "south";
  } else if(var5 < 247.5) {
    var5 = "southeast";
  } else if(var5 < 292.5) {
    var5 = "east";
  } else if(var5 < 337.5) {
    var5 = "northeast";
  } else {
    var5 = "impossible";
  }

  return var5;
}

function getdistancemeters(var0, var1) {
  var2 = distance2d(var0, var1);
  var3 = 0.0254 * var2;
  return var3;
}

function getdistancemetersnormalized(var0, var1) {
  var2 = getdistancemeters(var0, var1);

  if(var2 < 15) {
    return "10";
  }

  if(var2 < 25) {
    return "20";
  }

  if(var2 < 35) {
    return "30";
  }

  if(var2 < 45) {
    return "40";
  }

  if(var2 < 55) {
    return "50";
  }

  if(var2 < 65) {
    return "60";
  }

  if(var2 < 75) {
    return "70";
  }

  if(var2 < 85) {
    return "80";
  }

  if(var2 < 95) {
    return "90";
  }

  if(var2 < 125) {
    return "100";
  }

  return undefined;
}

function getdistancemiles(var0, var1) {
  var2 = distance2d(var0, var1);
  var3 = 1.57828e-05 * var2;
  return var3;
}

function getdistancemilesnormalized(var0, var1) {
  var2 = getdistancemiles(var0, var1);

  if(var2 < 5) {
    return "4";
  }

  if(var2 < 6) {
    return "5";
  }

  if(var2 < 7) {
    return "6";
  }

  if(var2 < 15) {
    return "10";
  }

  return "15";
}

function getfrontarcclockdirection(var0) {
  var1 = "undefined";

  if(var0 == "10" || var0 == "11") {
    var1 = "10";
  } else if(var0 == "12") {
    var1 = var0;
  } else if(var0 == "1" || var0 == "2") {
    var1 = "2";
  }

  return var1;
}

function getdirectionfacingclock(var0, var1, var2) {
  var3 = anglesToForward(var0);
  var4 = vectorNormalize(var3);
  var5 = vectortoangles(var4);
  var6 = vectortoangles(var2 - var1);
  var7 = var5[1] - var6[1];
  var7 += 360;
  var7 = int(var7) % 360;

  if(var7 > 345 || var7 < 15) {
    var8 = "12";
  } else if(var8 < 45) {
    var8 = "1";
  } else if(var8 < 75) {
    var8 = "2";
  } else if(var8 < 105) {
    var8 = "3";
  } else if(var8 < 135) {
    var8 = "4";
  } else if(var8 < 165) {
    var8 = "5";
  } else if(var8 < 195) {
    var8 = "6";
  } else if(var8 < 225) {
    var8 = "7";
  } else if(var8 < 255) {
    var8 = "8";
  } else if(var8 < 285) {
    var8 = "9";
  } else if(var8 < 315) {
    var8 = "10";
  } else {
    var8 = "11";
  }

  return var8;
}

function getdegreeselevation(var0, var1) {
  var2 = var1[2] - var0[2];
  var3 = distance2d(var0, var1);
  var4 = atan(var2 / var3);

  if(var4 < 15 || var4 > 65) {
    return var4;
  }

  if(var4 < 25) {
    return 20;
  }

  if(var4 < 35) {
    return 30;
  }

  if(var4 < 45) {
    return 40;
  }

  if(var4 < 55) {
    return 50;
  }

  if(var4 < 65) {
    return 60;
  }
}

function getvectorrightangle(var0) {
  return (var0[1], 0 - var0[0], var0[2]);
}

function getvectorarrayaverage(var0) {
  var1 = (0, 0, 0);

  for(var2 = 0; var2 < var0.size; var2++) {
    var1 += var0[var2];
  }

  return (var1[0] / var0.size, var1[1] / var0.size, var1[2] / var0.size);
}

function addconcattargetalias(var0) {
  var1 = "";
  var2 = undefined;

  if(var0 scripts\anim\utility_common::usingrocketlauncher()) {
    var1 = "_rpg";
  }

  if(bcissniper(var0)) {
    var1 = "_sniper";
  }

  var2 = getbattlechatteralias(self.owner, "concat_target") + var1;
  self.soundaliases[self.soundaliases.size] = var2;
}

function addconcatdirectionalias() {
  var2 = undefined;
  var3 = "undefined";
  var4 = scripts\engine\utility::random(["relative", "absolute"]);

  switch (var4) {
    case "absolute":
      var5 = getdirectioncompass(anim.player.origin, var1.origin);
      var6 = normalizecompassdirection(var5);

      if(var6 != "impossible" && var6.size != 2) {
        var2 = getbattlechatteralias(self.owner, "concat_compass") + var6;
        break;
      }

      var1 = "absolute";
    case "relative":
      var7 = getrelativeangles( < error > );
      var8 = getdirectionfacingclock(var7, < error > .origin, < error > .origin);
      var9 = int(var8);

      if(scripts\engine\utility::cointoss()) {
        if(var9 >= 2 && var9 < 5) {
          var0 = getbattlechatteralias(self.owner, "concat_right");
          break;
        } else if(var2 >= 8 && var2 < 11) {
          <
          error > = getbattlechatteralias(self.owner, "concat_left");
          break;
        }
      } else if(randomint(3) == 1) {
        var10 = getdistancemetersnormalized( < error > .origin, < error > .origin);

        if(isDefined(var10)) {
          <
          error > = getbattlechatteralias(self.owner, "concat_dist") + var10;
        }

        break;
      } else if(randomint(3) == 1) {
        var11 = getdegreeselevation(anim.player.origin, < error > .origin);

        if(var11 >= 20 && var11 <= 60) {
          <
          error > = getbattlechatteralias(self.owner, "concat_elev") + var11;
          break;
        }

        <
        error > = "elevation";
      } else if(self.owner.voice != "fsa" && self.owner.voice != "fsafemale") {
        <
        error > = getbattlechatteralias(self.owner, "concat_clock") + < error > ;
        break;
      }

      break;
  }

  if(isDefined( < error > )) {
    self.soundaliases[self.soundaliases.size] = < error > ;
    return;
  }

  battlechatter_printwarning("Missing concat direction: " + < error > );
}

function addnamealias(var0) {
  if(self.owner == anim.player) {} else {
    self.soundaliases[self.soundaliases.size] = bc_prefix(self.owner) + "name_" + var0;
  }

  anim.lastnamesaid[self.owner.team] = var0;
  anim.lastnamesaidtime[self.owner.team] = gettime();
}

function addplayernamealias() {
  if(!cansayplayername(self.owner)) {
    return;
  }

  anim.lastplayernamecalltime = gettime();
  var0 = bc_prefix(self.owner) + "name_player_" + anim.player.bccountryid + "_" + anim.player.bcnameid;
  self.soundaliases[self.soundaliases.size] = var0;
  self.bc_looktarget = anim.player;
}

function addrankalias(var0) {
  self.soundaliases[self.soundaliases.size] = bc_prefix(self.owner) + "rank_" + var0;
}

function cansayname(var0) {
  if(enemy_team_name()) {
    return false;
  }

  if(!isDefined(var0.bcname)) {
    return false;
  }

  if(var0.battlechatterallowed == 0) {
    return false;
  }

  if(!isDefined(var0.battlechatter.countryid)) {
    return false;
  }

  if(!isDefined(self.battlechatter.countryid)) {
    return false;
  }

  if(self.battlechatter.countryid != var0.battlechatter.countryid) {
    return false;
  }

  if(namesaidrecently(var0)) {
    return false;
  }

  var1 = undefined;

  if(isPlayer(self)) {
    var1 = "UN_plr_name_" + var0.bcname;
  } else {
    var1 = bc_prefix() + "name_" + var0.bcname;
  }

  if(soundexists(var1)) {
    return true;
  }

  return false;
}

function namesaidrecently(var0) {
  if(anim.lastnamesaid[self.team] == var0.bcname || gettime() - anim.lastnamesaidtime[self.team] < anim.lastnamesaidtimeout) {
    return true;
  }

  return false;
}

function cansayplayername() {
  if(enemy_team_name()) {
    return false;
  }

  if(self == anim.player) {
    return false;
  }

  if(!isDefined(anim.player.bcnameid) || !isDefined(anim.player.bccountryid)) {
    return false;
  }

  if(player_name_called_recently()) {
    return false;
  }

  var0 = bc_prefix() + "name_player_" + anim.player.bccountryid + "_" + anim.player.bcnameid;

  if(soundexists(var0)) {
    return true;
  }

  return false;
}

function player_name_called_recently() {
  if(!isDefined(anim.lastplayernamecalltime)) {
    return false;
  }

  if(gettime() - anim.lastplayernamecalltime >= anim.eventtypeminwait["playername"]) {
    return false;
  }

  return true;
}

function isusingsamevoice(var0) {
  if(isstring(self.battlechatter.npcid) == isstring(var0.battlechatter.npcid) && self.battlechatter.npcid == var0.battlechatter.npcid) {
    return 1;
  }

  return 0;
}

function addthreatalias(var0, var1) {
  var2 = getbattlechatteralias(self.owner, "threat_" + var0);

  if(isDefined(var1) && var1 != "generic") {
    var2 += "_" + var1;
  }

  self.soundaliases = scripts\engine\utility::array_add(self.soundaliases, var2);
  return true;
}

function addthreatexposedalias(var0) {
  if(var0 == "group") {
    var0 = "movement_group";
  }

  var1 = getbattlechatteralias(self.owner, "exposed_" + var0);
  self.soundaliases[self.soundaliases.size] = var1;
  return true;
}

function addthreatcalloutecho(var0, var1) {
  var2 = createechoalias(var0, var1);

  if(!soundexists(var2)) {
    battlechatter_printwarning("Can't find echo alias '" + var2 + "'.");
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var2;
  return true;
}

function addthreatcalloutresponsealias(var0, var1) {
  var2 = undefined;

  if(!isDefined(var0)) {
    var0 = "";
  } else {
    var0 = "_" + var0;
  }

  var2 = getbattlechatteralias(self.owner, "response_threat" + var0);

  if(!soundexists(var2)) {
    battlechatter_printwarning("Can't find callout response alias '" + var2 + "'.");
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var2;
  return true;
}

function addthreatcalloutqa_nextline(var0, var1, var2) {
  var3 = undefined;

  foreach(var5 in var2.locationaliases) {
    if(issubstr(var1, var5)) {
      var3 = var5;
      break;
    }
  }

  var7 = bc_prefix(self.owner) + "";
  var8 = getsubstr(var1, var1.size - 1, var1.size);
  var9 = int(var8) + 1;
  var10 = var7 + scripts\anim\battlechatter_ai::getbcstate() + "_location_" + var3 + "_qa" + var9;

  if(!soundexists(var10)) {
    if(randomint(100) < anim.eventchance["response"]["callout_negative"]) {
      var0 scripts\anim\battlechatter_ai::addresponseevent("callout", "neg", self.owner, 0.9);
    } else {
      var0 scripts\anim\battlechatter_ai::addresponseevent("exposed", "acquired", self.owner, 0.9);
    }

    var2.qafinished = 1;
    return false;
  }

  var0 scripts\anim\battlechatter_ai::addresponseevent("callout", "QA", self.owner, 0.9, var10, var2);
  self.soundaliases[self.soundaliases.size] = var10;
  return true;
}

function createechoalias(var0, var1) {
  var2 = "_report";
  var3 = "_echo";
  var4 = undefined;

  if(var1 == anim.player) {
    var5 = "plr";
  } else {
    var5 = var2.battlechatter.npcid;
  }

  if(self.owner == anim.player) {
    var5 = self.owner.battlechatter.countryid + "_plr_";
  } else {
    var5 = bc_prefix(self.owner) + "";
  }

  var6 = var1.size - var3.size;

  if(self.owner == anim.player) {
    var7 = self.owner.battlechatter.countryid + "_plr_";
    var8 = var7.size;
  } else {
    var7 = self.owner.battlechatter.countryid + "_" + var7 + "_";
    var8 = var7.size;
  }

  var9 = getsubstr(var3, var8, var8);
  var10 = var6 + var9 + var5;
  return var10;
}

function addthreatcalloutalias(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = "";
  }

  var3 = undefined;

  if(self.owner == anim.player) {
    if(var0 == "acquired" || var0 == "sighted") {
      var3 = self.owner.battlechatter.countryid + "_plr_target_" + var0;
    } else {
      var3 = self.owner.battlechatter.countryid + "_plr_callout_" + var0 + var1;
    }
  } else if(istrue(var2)) {
    if(cansaycontact(self.owner, self.threatent)) {
      var3 = getbattlechatteralias(self.owner, "threat_callout_contact" + var0) + var1;
    } else {
      var3 = getbattlechatteralias(self.owner, "threat_callout_target" + var0) + var1;
    }
  } else {
    var3 = getbattlechatteralias(self.owner, "threat_callout_" + var0) + var1;
  }

  self.soundaliases[self.soundaliases.size] = var3;

  if(soundexists(var3)) {
    return 1;
  }

  return 0;
}

function addthreatcalloutlandmarkalias(var0, var1, var2) {
  var3 = var0.script_landmark;

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var4 = bc_prefix(self.owner) + "callout_obj_" + var3;

  if(var2) {
    var4 += "_y";
  }

  var4 += "_" + var1;

  if(!soundexists(var4)) {
    battlechatter_printwarning("Can't find sound alias '" + var4 + "'. Does landmark '" + var3 + "' have callout references in the battlechatter csv for nationality '" + self.owner.battlechatter.countryid + "'?");
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var4;
  return true;
}

function addthreatcalloutlocationalias(var0, var1, var2) {
  var3 = undefined;
  var4 = var0.locationaliases;
  var5 = var4[0];

  if(var4.size > 1) {
    var6 = undefined;
    var6 = getcannedresponse(var0, var2);

    if(isDefined(var6)) {
      var5 = var6;
    } else {
      var5 = scripts\engine\utility::random(var4);
    }
  }

  var7 = undefined;

  if(isDefined(var1) && var1) {
    var7 = getloccalloutalias(self.owner, scripts\anim\battlechatter_ai::getbcstate() + "_location_concat_" + var5);
  } else if(!isDefined(var0.qafinished) && iscallouttypeqa(var5, self.owner)) {
    var7 = getqacalloutalias(self.owner, var5, 0);
  } else {
    var7 = getloccalloutalias(self.owner, scripts\anim\battlechatter_ai::getbcstate() + "_location_callout_" + var5);
  }

  if(soundexists(var7)) {
    var3 = var7;
  }

  if(!isDefined(var3)) {
    return false;
  }

  location_add_last_callout_time(var0);
  self.soundaliases[self.soundaliases.size] = var3;
  return true;
}

function addlocationresponsealias(var0, var1) {
  var2 = undefined;

  if(!isDefined(var0)) {
    var0 = "";
  } else {
    var0 = "_" + var0;
  }

  var2 = getbattlechatteralias(self.owner, "location_response") + var0;

  if(!soundexists(var2)) {
    battlechatter_printwarning("Can't find location response alias '" + var2 + "'.");
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var2;
  return true;
}

function addvehiclealias(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  } else {
    var1 = "_" + var1;
  }

  var0 = "vehicle_" + var0;
  var2 = getbattlechatteralias(self.owner, var0 + var1);
  self.soundaliases[self.soundaliases.size] = var2;
}

function addinformalias(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = "";
  } else {
    var1 = "_" + var1;
  }

  if(!isDefined(var2)) {
    var2 = "";
  } else {
    var2 = "_" + var2;
  }

  if(!issubstr(var1, "weapon")) {
    var0 = "inform_" + var0;
  } else {
    var0 = "";
  }

  var3 = getbattlechatteralias(self.owner, var0 + var1 + var2);
  self.soundaliases[self.soundaliases.size] = var3;
}

function addresponsealias(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  } else {
    var1 = "_" + var1;
  }

  var2 = getbattlechatteralias(self.owner, "response_" + var0 + var1);
  self.soundaliases[self.soundaliases.size] = var2;
  return true;
}

function addreactionalias(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  } else {
    var1 = "_" + var1;
  }

  var2 = getbattlechatteralias(self.owner, "reaction_" + var0 + var1);
  self.soundaliases[self.soundaliases.size] = var2;
  return true;
}

function addcheckfirealias() {
  var0 = getbattlechatteralias(self.owner, "check_fire");
  self.soundaliases[self.soundaliases.size] = var0;
  return true;
}

function addtakingfirealias() {
  var0 = getbattlechatteralias(self.owner, "inform_taking_fire");
  self.soundaliases[self.soundaliases.size] = var0;
  return true;
}

function addtauntalias(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  } else {
    var1 = "_" + var1;
  }

  var2 = getbattlechatteralias(self.owner, "taunt");
  self.soundaliases[self.soundaliases.size] = var2;
  return true;
}

function addhostileburstalias() {
  var0 = getbattlechatteralias(self.owner, "reaction_hostile_burst");

  if(soundexists(var0)) {
    self.soundaliases[self.soundaliases.size] = var0;
  }

  return true;
}

function addorderalias(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  } else {
    var1 = "_" + var1;
  }

  var2 = getbattlechatteralias(self.owner, "order" + var1);

  if(!isDefined(var2)) {
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var2;
  return true;
}

function addstealthalias(var0, var1) {
  var2 = undefined;
  var3 = undefined;

  if(self.owner == anim.player) {} else {
    switch (var0) {
      case "idle_alert":
      case "idle":
        self.owner.battlechatter.investigatecallin = 0;

        if(usecustombc(var0)) {
          var2 = addcustombcstealthalias(self.owner, var0);
        } else {
          var1 = "callin";

          if(scripts\engine\utility::cointoss()) {
            var1 = "checkin";
          }

          var4 = scripts\anim\battlechatter_table::bctable_pickaliasset("stealth", var0, var1);

          if(!isDefined(var4)) {
            return false;
          }

          if(uselocationbc(self.owner, var1)) {
            var5 = getstealthlocationalias(self.owner, var1);
            var2 = var5[0];
            var3 = scripts\engine\utility::array_remove_index(var5, 0);
          } else if(var1 == "checkin") {
            var2 = bc_prefix(self.owner, "stealth", 1) + var4[0];

            if(isDefined(var4[1]) && var4[1] != "") {
              thread playradioecho(self.owner);
            }

            if(isDefined(var4[2]) && var4[2] != "") {
              var3 = bc_prefix(self.owner, "stealth") + var4[2];
            }

            if(isDefined(var4[3]) && var4[3] != "") {
              var3 = bc_prefix(self.owner, "stealth", 1) + var4[3];
            }

            self.checkin = 1;
          } else {
            var2 = bc_prefix(self.owner, "stealth") + var4[0];

            if(isDefined(var4[1]) && var4[1] != "") {
              thread playradioecho(self.owner);
            }

            if(isDefined(var4[2]) && var4[2] != "") {
              var3 = bc_prefix(self.owner, "stealth", 1) + var4[2];
            }

            self.callin = 1;
          }
        }

        break;
      case "radio":
        var4 = scripts\anim\battlechatter_table::bctable_pickaliasset("stealth", var0, var1);

        if(!isDefined(var4)) {
          return false;
        }

        var2 = bc_prefix(self.owner, "stealth") + var4[0];

        for(var6 = 1; var6 < var4.size; var6++) {
          if(!isDefined(var3)) {
            var3 = [];
          }

          var3 = bc_prefix(self.owner, "stealth") + var4[var6];
        }

        break;
      case "investigate":
        if(usecustombc(var0)) {
          var2 = addcustombcstealthalias(self.owner, var0);
        } else {
          var1 = "update";

          if(!istrue(self.owner.battlechatter.investigatecallin)) {
            var7 = "callin";
            self.callin = 1;
            self.owner.battlechatter.investigatecallin = 1;
          } else {
            self.update = 1;
          }

          var4 = scripts\anim\battlechatter_table::bctable_pickaliasset("stealth", var0, var1);

          if(!isDefined(var4)) {
            return false;
          }

          if(uselocationbc(self.owner, var1)) {
            var5 = getstealthlocationalias(self.owner, var1);
            var2 = var5[0];
            var3 = scripts\engine\utility::array_remove_index(var5, 0);
          } else {
            var2 = bc_prefix(self.owner, "stealth") + var4[0];

            if(isDefined(var4[1]) && var4[1] != "") {
              thread playradioecho(self.owner);
            }

            if(isDefined(var4[2]) && var4[2] != "") {
              var3 = bc_prefix(self.owner, "stealth", 1) + var4[2];
            }
          }
        }

        break;
      case "announce":
      case "hunt":
        var4 = scripts\anim\battlechatter_table::bctable_pickaliasset("stealth", var0, var1);

        if(!isDefined(var4)) {
          return false;
        }

        if(var0 == "hunt") {
          self.owner.battlechatter.investigatecallin = 0;
        }

        if(usecustombc(var0)) {
          var2 = addcustombcstealthalias(self.owner, var0);
        } else {
          var2 = bc_prefix(self.owner, "stealth") + var4[0];

          if(isDefined(var4[1]) && var4[1] != "") {
            thread playradioecho(self.owner);
          }

          if(isDefined(var4[2]) && var4[2] != "") {
            var3 = bc_prefix(self.owner, "stealth", 1) + var4[2];
          }
        }

        break;
      case "combat":
        break;
    }
  }

  if(!isDefined(var2)) {
    return false;
  }

  self.soundevents[self.soundaliases.size] = var0;

  if(isDefined(var1)) {
    self.soundevents[self.soundaliases.size] = var0 + " " + var1;
  }

  self.soundaliases[self.soundaliases.size] = var2;

  if(isDefined(var3)) {
    self.responsealiases = var3;
  }

  return true;
}

function addcustombcstealthalias(var0) {
  if(tolower(self.battlechatter.countryid + self.battlechatter.npcid) == "aq4") {
    return undefined;
  }

  var1 = getcustombc(var0);
  self.battlechatter.custombc_alias2 = "";

  if(isarray(var1)) {
    self.battlechatter.custombc_alias2 = var1[1];
    var1 = var1[0];
  }

  if(isradioline(var1)) {} else {
    var2 = "";
    var3 = strtok(var1, "_");

    for(var4 = 0; var4 < var3.size; var4++) {
      if(var4 == var3.size - 1) {
        var2 = var2 + "r_" + var3[var4];
        continue;
      }

      var2 = var2 + var3[var4] + "_";
    }

    if(soundexists(var2)) {} else {
      battlechatter_printwarning("Can't find radio alias '" + var2 + "'.This may be intentional if talking to himself.");
    }
  }

  return var1;
}

function try_cardinal_patrol_update() {
  var0 = getdirectioncompass(self.origin, (0, 0, 0));

  if(isDefined(var0) && var0 == "impossible") {
    return undefined;
  }

  var1 = randomintrange_otn(1);

  switch (var0) {
    case "north":
      var2 = "areasecure_n" + var1;
      break;
    case "northwest":
      var2 = "areasecure_w" + var2;

      if(scripts\engine\utility::cointoss()) {
        var2 = "areasecure_n" + var2;
      }

      break;
    case "northeast":
      var2 = "areasecure_e" + var2;

      if(scripts\engine\utility::cointoss()) {
        var2 = "areasecure_n" + var2;
      }

      break;
    case "south":
      var2 = "areasecure_s" + var2;
      break;
    case "southwest":
      var2 = "areasecure_w" + var2;

      if(scripts\engine\utility::cointoss()) {
        var2 = "areasecure_s" + var2;
      }

      break;
    case "southeast":
      var2 = "areasecure_e" + var2;

      if(scripts\engine\utility::cointoss()) {
        var2 = "areasecure_s" + var2;
      }

      break;
    case "east":
      var2 = "areasecure_e" + var2;
      break;
    case "west":
      var2 = "areasecure_w" + var2;
      break;
    default:
      iprintln("No cardinal direction returned");
      var2 = undefined;
      break;
  }

  return var2;
}

function try_cardinal_gunshot(var0) {
  var1 = getdirectioncompass(self.origin, var0);

  if(isDefined(var1) && var1 == "impossible") {
    return;
  }

  var2 = randomintrange_otn(1);

  switch (var1) {
    case "north":
      var3 = "gunshot_n_" + var2;
      break;
    case "northwest":
      var3 = "gunshot_w_" + var3;

      if(scripts\engine\utility::cointoss()) {
        var3 = "gunshot_n_" + var3;
      }

      break;
    case "northeast":
      var3 = "gunshot_e_" + var3;

      if(scripts\engine\utility::cointoss()) {
        var3 = "gunshot_n_" + var3;
      }

      break;
    case "south":
      var3 = "gunshot_s_" + var3;
      break;
    case "southwest":
      var3 = "gunshot_w_" + var3;

      if(scripts\engine\utility::cointoss()) {
        var3 = "gunshot_s_" + var3;
      }

      break;
    case "southeast":
      var3 = "gunshot_e_" + var3;

      if(scripts\engine\utility::cointoss()) {
        var3 = "gunshot_s_" + var3;
      }

      break;
    case "east":
      var3 = "gunshot_e_" + var3;
      break;
    case "west":
      var3 = "gunshot_w_" + var3;
      break;
    default:
      iprintln("No cardinal direction returned");
      var3 = undefined;
      break;
  }

  return var3;
}

function randomintrange_otn(var0, var1) {
  if(getDvar("bcs_otnStealth") != "off") {
    return "10";
  }

  if(isDefined(var0)) {
    if(isDefined(var1)) {
      return (randomintrange(var0, var1) * 10);
    }

    return "10";
  }
}

function initcontact(var0) {
  if(!isDefined(self.squadlist[var0].calledout)) {
    self.squadlist[var0].calledout = 0;
  }

  if(!isDefined(self.squadlist[var0].firstcontact)) {
    self.squadlist[var0].firstcontact = undefined;
  }

  if(!isDefined(self.squadlist[var0].lastcontact)) {
    self.squadlist[var0].lastcontact = 0;
    return;
  }
}

function shutdowncontact(var0) {
  self.squadlist[var0].calledout = undefined;
  self.squadlist[var0].firstcontact = undefined;
  self.squadlist[var0].lastcontact = undefined;
}

function createchatevent(var0, var1, var2) {
  var3 = spawnStruct();
  var3.owner = self;
  var3.eventtype = var1;
  var3.eventaction = var0;

  if(isDefined(var2)) {
    var3.priority = var2;
  } else {
    var3.priority = anim.eventpriority[var0][var1];
  }

  if(isDefined(self.battlechatter.overrides) && isDefined(self.battlechatter.overrides.eventduration) && isDefined(self.battlechatter.overrides.eventduration[var0]) && isDefined(self.battlechatter.overrides.eventduration[var0][var1])) {
    var3.expiretime = gettime() + self.battlechatter.overrides.eventduration[var0][var1];
  } else {
    var3.expiretime = gettime() + anim.eventduration[var0][var1];
  }

  return var3;
}

function createchatphrase() {
  var0 = spawnStruct();
  var0.owner = self;
  var0.soundevents = [];
  var0.soundaliases = [];
  var0.responsealiases = [];
  var0.master = 0;
  return var0;
}

function pointinfov(var0) {
  return scripts\engine\utility::within_fov(self.origin, self.angles, var0, 0.766);
}

function entinfrontarc(var0) {
  return scripts\engine\utility::within_fov(self.origin, self.angles, var0.origin, 0);
}

function squadflavorbursttransmissions() {
  anim endon("battlechatter disabled");
  self endon("squad_deleting");

  if(self.squadname != "jackal_allies") {
    return;
  }

  while(self.membercount <= 0) {
    wait 0.5;
  }

  wait 0.5;
  var0 = 0;

  while(isDefined(self)) {
    if(!squadcanburst(self)) {
      var0 = 1;
      wait 1;
      continue;
    } else if(self.fbt_firstburst) {
      if(!var0) {
        wait randomfloat(anim.fbt_waitmin);
      }

      if(var0) {
        var0 = 0;
      }

      self.fbt_firstburst = 0;
    } else {
      if(!var0) {
        wait randomfloatrange(anim.fbt_waitmin, anim.fbt_waitmax);
      }

      if(var0) {
        var0 = 0;
      }
    }

    var1 = getburster(self);

    if(!isDefined(var1)) {
      continue;
    }

    var2 = var1.voice;
    var3 = getflavorburstid(self, var2);
    var4 = getflavorburstaliases(var2, var3);

    foreach(var6 in var4) {
      if(!candoflavorburst(var1) || distance(anim.player.origin, var1.origin) > anim.fbt_desireddistmax && !isDefined(var1.bcs_jackal)) {
        for(var7 = 0; var7 < self.members.size; var7++) {
          var1 = getburster(self);

          if(!isDefined(var1)) {
            continue;
          }

          if(var1.voice == var2) {
            break;
          }
        }

        if(!isDefined(var1) || var1.voice != var2) {
          break;
        }
      }

      thread playflavorburstline(var0, var5);
      self waittill("burst_line_done");

      if(var6 != var3.size - 1) {
        wait randomfloatrange(anim.fbt_linebreakmin, anim.fbt_linebreakmax);
      }
    }

    var4 = undefined;
  }
}

function squadcanburst(var0) {
  var1 = 0;

  foreach(var3 in var0.members) {
    if(var3 == anim.player) {
      continue;
    }

    if(!isDefined(var3.team)) {
      return var1;
    }

    if(candoflavorburst(var3)) {
      var1 = 1;
      break;
    }
  }

  return var1;
}

function candoflavorburst() {
  var0 = 0;

  if(self != anim.player && isalive(self) && level.flavorbursts[self.team] && voicecanburst() && isDefined(self.flavorbursts) && self.flavorbursts) {
    var0 = 1;
  }

  return var0;
}

function voicecanburst() {
  if(isDefined(anim.flavorburstvoices) && isDefined(anim.flavorburstvoices[self.voice]) && anim.flavorburstvoices[self.voice]) {
    return true;
  }

  return false;
}

function getburster(var0) {
  var1 = undefined;
  var2 = scripts\engine\utility::get_array_of_farthest(anim.player.origin, var0.members);

  foreach(var4 in var2) {
    if(candoflavorburst(var4)) {
      var1 = var4;

      if(!isDefined(var0.fbt_lastbursterid)) {
        break;
      }

      if(isDefined(var0.fbt_lastbursterid) && var0.fbt_lastbursterid == var1.unique_id) {}
    }
  }

  if(isDefined(var1)) {
    var0.fbt_lastbursterid = var1.unique_id;
  }

  return var1;
}

function getflavorburstid(var0, var1) {
  var2 = scripts\engine\utility::array_randomize(anim.flavorbursts[var1]);

  if(anim.flavorburstsused.size >= var2.size) {
    anim.flavorburstsused = [];
  }

  var3 = undefined;

  foreach(var5 in var2) {
    var3 = var5;

    if(!flavorburstwouldrepeat(var3)) {
      break;
    }
  }

  anim.flavorburstsused[anim.flavorburstsused.size] = var3;
  return var3;
}

function flavorburstwouldrepeat(var0) {
  if(!anim.flavorburstsused.size) {
    return 0;
  }

  var1 = 0;

  foreach(var3 in anim.flavorburstsused) {
    if(var3 == var0) {
      var1 = 1;
      break;
    }
  }

  return var1;
}

function getflavorburstaliases(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = var2;
  var4 = [];

  for(;;) {
    var5 = var3;
    var6 = "FB_" + anim.countryids[var0] + "_" + var1 + "_" + var5;
    var3++;

    if(soundexists(var6)) {
      var4 = var6;
      continue;
    }

    break;
  }

  return var4;
}

function playflavorburstline(var0, var1) {
  anim endon("battlechatter disabled");
  var2 = undefined;
  var2 = spawn("script_origin", var0 gettagorigin("j_head"));
  var2 linkTo(var0);

  if(battlechatter_canprint()) {
    battlechatter_print([var1]);
  }

  var2 playSound(var1, var1, 1);
  var2 waittill(var1);
  var2 delete();

  if(isDefined(self)) {
    self notify("burst_line_done");
    return;
  }
}

function flavorburstlinedebug(var0, var1) {
  self endon("burst_line_done");

  for(;;) {
    wait 0.05;
  }
}

function debugprintevents() {
  if(!isalive(self)) {
    return;
  }

  if(getDvar("debug_bcshowqueue") != self.team && getDvar("debug_bcshowqueue") != "all") {
    return;
  }

  self endon("death");
  self notify("debugPrintEvents");
  self endon("debugPrintEvents");
  var0 = getqueueevents();
  GscBinSkip1(0x45, "g", (0, 1, 0));
}

function debugqueueevents() {
  if(getDvar("debug_bcresponse") == "on") {
    thread printqueueevent("response");
  }

  if(getDvar("debug_bcthreat") == "on") {
    thread printqueueevent("threat");
  }

  if(getDvar("debug_bcinform") == "on") {
    thread printqueueevent("inform");
  }

  if(getDvar("debug_bcorder") == "on") {
    thread printqueueevent("order");
  }

  if(getDvar("debug_bcstealth") == "on") {
    thread printqueueevent("stealth");
    return;
  }
}

function printabovehead(var0, var1, var2) {
  self endon("death");

  if(!isDefined(var2)) {
    var2 = (0, 0, 0);
  }

  for(var3 = 0; var3 < var1 * 2; var3++) {
    if(!isalive(self)) {
      return;
    }

    var4 = self getshootatpos() + (0, 0, 10) + var2;
    wait 0.05;
  }
}

function printqueueevent(var0) {
  var1 = gettime();

  if(self.battlechatter.chatqueue[var0].expiretime > 0 && !isDefined(self.battlechatter.chatqueue[var0].printed)) {
    if(var1 > self.battlechatter.chatqueue[var0].expiretime) {}

    self.battlechatter.chatqueue[var0].printed = 1;
    return;
  }
}

function bcprint_info() {
  self endon("death");
}

function battlechatter_canprint() {
  return false;
}

function battlechatter_canprintdump() {
  return false;
}

function battlechatter_canprintscreen() {
  return false;
}

function battlechatter_print(var0) {
  if(var0.size <= 0) {
    return;
  }

  if(!battlechatter_canprint()) {
    return;
  }

  var1 = "^5 ";

  if(enemy_team_name()) {
    var1 = "^6 ";
  }

  var2 = (0, 0, -7);

  foreach(var4 in var0) {}
}

function battlechatter_printscreenadd(var0, var1) {
  if(!isDefined(level.battlechatter)) {
    level.battlechatter = [];
  }

  if(!isDefined(level.battlechatter["printscreen"])) {
    level.battlechatter["printscreen"] = [];
  }

  if(!isDefined(level.battlechatter["printscreen"]["axis"])) {
    level.battlechatter["printscreen"]["axis"] = [];
  }

  if(!isDefined(level.battlechatter["printscreen"]["allies"])) {
    level.battlechatter["printscreen"]["allies"] = [];
  }

  if(!isDefined(level.battlechatter["printscreen"]["team3"])) {
    level.battlechatter["printscreen"]["team3"] = [];
  }

  var2 = level.battlechatter["printscreen"][self.team].size;

  if(var2 > 40) {
    level.battlechatter["printscreen"][self.team] = scripts\engine\utility::array_remove_index(level.battlechatter["printscreen"][self.team], 0);
    var2 = level.battlechatter["printscreen"][self.team].size;
  }

  level.battlechatter["printscreen"][self.team][var2]["alias"] = var0;
  level.battlechatter["printscreen"][self.team][var2]["color"] = var1;
  thread battlechatter_printscreen();
}

function battlechatter_printscreen() {
  self notify("printscreen_stop");
  self endon("printscreen_stop");

  if(!isDefined(level.battlechatter)) {
    level.battlechatter = [];
  }

  if(!isDefined(level.battlechatter["printscreen"])) {
    level.battlechatter["printscreen"] = [];
  }

  var0 = 220;
  var1 = 30;
  var2 = 600;
  var3 = 1170;

  for(;;) {
    var4 = var0;

    for(var5 = 0; var5 < level.battlechatter["printscreen"]["axis"].size; var5++) {
      var4 += 18;
    }

    var4 = var0;

    for(var5 = 0; var5 < level.battlechatter["printscreen"]["allies"].size; var5++) {
      var4 += 18;
    }

    var4 = var0;

    for(var5 = 0; var5 < level.battlechatter["printscreen"]["team3"].size; var5++) {
      var4 += 18;
    }

    waitframe();
  }
}

function battlechatter_printwarning(var0) {}

function battlechatter_printerror(var0) {}

function battlechatter_draw_arrow(var0, var1, var2, var3) {
  var4 = var1 + anglesToForward(vectortoangles(var1 - var0)) * -40;
  var4 += anglestoright(vectortoangles(var1 - var0)) * 18;
  var4 = var1 + anglesToForward(vectortoangles(var1 - var0)) * -40;
  var4 += anglestoright(vectortoangles(var1 - var0)) * -18;
}

function battlechatter_printdump(var0, var1) {}

function getaliastypefromsoundalias(var0) {
  if(getsubstr(var0, 0, 6) == "dx_vom") {
    var1 = getsubstr(var0, 7, var0.size);
  } else {
    if(self == anim.player) {
      var2 = self.battlechatter.countryid + "_";
    } else {
      jumpiffalse(getsubstr(var2, 0, 6) == "dx_sbc") LOC_00000069;
      var2 = bc_prefix("stealth");
      goto LOC_00000071;
    }

    LOC_00000071:
      var1 = getsubstr(var2, var2.size, var2.size);
  }

  return var1;
}

function battlechatter_printdumpline(var0, var1, var2) {
  if(scripts\engine\utility::flag(var2)) {
    scripts\engine\utility::flag_wait(var2);
  }

  scripts\engine\utility::flag_set(var2);
  scripts\engine\utility::flag_clear(var2);
}

function bcdrawobjects() {
  for(var0 = 0; var0 < anim.bcs_locations.size; var0++) {
    var1 = anim.bcs_locations[var0].locationaliases;

    if(!isDefined(var1)) {
      continue;
    }

    var2 = "";

    foreach(var4 in var1) {
      var2 += var4;
    }

    thread drawbcobject("Location: " + var2, anim.bcs_locations[var0] getorigin(), (0, 0, 8), (1, 1, 1));
  }
}

function drawbcobject(var0, var1, var2, var3) {
  for(;;) {
    if(distancesquared(anim.player.origin, var1) > 4194304) {
      wait 0.1;
    }

    waitframe();
  }
}

function drawbcdirections(var0, var1, var2) {
  var3 = var0 getorigin();

  for(;;) {
    if(distancesquared(anim.player.origin, var3) > 4194304) {
      wait 0.1;
      continue;
    }

    var4 = getdirectioncompass(anim.player.origin, var3);
    var4 = normalizecompassdirection(var4);
    var5 = getdirectionfacingclock(anim.player.angles, anim.player.origin, var3);
    var6 = var4 + ", " + var5 + ":00";
    wait 0.05;
  }
}

function resetnextsaytimes(var0, var1) {
  var2 = getaiarray(var0);

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = var2[var3];

    if(!isalive(var4)) {
      continue;
    }

    if(!isDefined(var4.battlechatterallowed)) {
      continue;
    }

    var4.battlechatter.nextsaytimes[var1] = gettime() + 350;
    var4.squad.nextsaytimes[var1] = gettime() + 350;
  }
}

function voice_is_british_based() {
  self endon("death");

  if(self.voice == "british") {
    return 1;
  }

  return 0;
}

function friendlyfire_warning() {
  if(!can_say_friendlyfire()) {
    return false;
  }

  dotypelimit("reaction", "friendlyfire");
  level notify("friendly fire team");
  thread playreactionevent();
  return true;
}

function friendlyfire_warning_team() {
  level notify("friendly fire team");
  level endon("friendly fire team");
  wait 0.25;

  if(battlechatter_canprint()) {}

  if(isDefined(self.squad) && isDefined(self.squad.members)) {
    var0 = self.squad.members;
    var0 = scripts\engine\utility::array_remove(var0, self);
    var0 = scripts\engine\utility::array_remove(var0, anim.player);

    if(var0.size > 0) {
      var0 = sortbydistance(var0, self.origin);

      foreach(var2 in var0) {
        if(!isDefined(var2.scripteddialoguenotify) && !isDefined(var2.scripteddialoguenonotify)) {
          var2 scripts\anim\battlechatter_ai::addreactionevent("friendlyfire", undefined, anim.player, 1);
          break;
        }
      }

      return;
    }

    return;
  }
}

function can_say_friendlyfire(var0) {
  if(isDefined(self.friendlyfire_warnings_disable)) {
    return false;
  }

  if(isDefined(self.melee)) {
    if(isDefined(self.melee.inprogress)) {
      if(self.melee.inprogress) {
        return false;
      }
    }
  }

  if(!isDefined(self.battlechatter.chatqueue)) {
    return false;
  }

  if(!isDefined(self.battlechatter.chatqueue["reaction"]) || !isDefined(self.battlechatter.chatqueue["reaction"].eventtype)) {
    return false;
  }

  if(self.battlechatter.chatqueue["reaction"].eventtype != "friendlyfire") {
    return false;
  }

  if(gettime() > self.battlechatter.chatqueue["reaction"].expiretime) {
    return false;
  }

  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(var0) {
    if(isDefined(self.squad.nexttypesaytimes["reaction"]["friendlyfire"])) {
      if(gettime() < self.squad.nexttypesaytimes["reaction"]["friendlyfire"]) {
        return false;
      }
    }
  }

  return true;
}

function bccustomconvo(var0, var1, var2, var3) {
  level.player endon("death");

  if(!isDefined(level.battlechattercustom)) {
    level.battlechattercustom = [];
  }

  if(!isDefined(var2)) {
    var2 = "idle";
  }

  if(isstring(var0)) {
    while(!isDefined(level.stealth)) {
      waitframe();
    }

    level.battlechattercustom[var0] = spawnStruct();
  }

  var4 = scripts\stealth\group::getgroup(var0).members;

  if(isnumber(var3)) {
    var5 = squared(var3);

    for(var6 = scripts\engine\utility::getclosest(level.player.origin, var4); distancesquared(level.player.origin, var6.origin) > var5; var6 = scripts\engine\utility::getclosest(level.player.origin, var4)) {
      waitframe();
      var4 = scripts\stealth\group::getgroup(var0).members;
    }

    if(isDefined(var6.battlechatter.isspeaking) && var6.battlechatter.isspeaking) {}

    var7 = getarraykeys(var1);
    var8 = 0;

    foreach(var10 in var7) {
      if(isDefined(var1[var10]["commander"])) {
        var11 = bccreatemouth(level.player);
      } else {
        if(!isDefined(var4[var8])) {
          break;
        }

        var11 = bccreatemouth(var4[var8]);
        var8++;
      }

      var4[var8].battlechatter.isspeaking = 1;
      var11 playSound(var1[var10]["line"], var1[var10]["line"], 1);
      var11 waittill(var1[var10]["line"]);
      var11 delete();
      var4[var8].battlechatter.isspeaking = undefined;

      if(isDefined(var1[var10]["delay"])) {
        wait var1[var10]["delay"];
      }
    }

    return;
  }
}

function bccreatemouth() {
  if(self == anim.player) {
    var0 = spawn("script_origin", anim.player getEye());
    var0 linkTo(self);
  } else {
    var0 = spawn("script_origin", self gettagorigin("j_head"));
    var0 linkTo(self);
  }

  return var0;
}

function usecustombc(var0) {
  if(!isDefined(level.battlechattercustom) || !isDefined(level.battlechattercustom[var0])) {
    return 0;
  }

  var1 = getarraykeys(level.battlechattercustom[var0]);

  if(var1.size > 0 && isDefined(level.battlechattercustom[var0]["curEvent"]) && scripts\engine\utility::array_contains(var1, level.battlechattercustom[var0]["curEvent"])) {
    return 1;
  }

  return 0;
}

function getcustombc(var0) {
  var1 = undefined;
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = bc_prefix("custom");
  var6 = bc_prefix("custom radio");
  var7 = var5;
  var8 = getarraykeys(level.battlechattercustom[var0]);

  for(var9 = 0; var9 < var8.size; var9++) {
    if(!isDefined(level.battlechattercustom[var0]["curEvent"]) || !scripts\engine\utility::array_contains(var8, level.battlechattercustom[var0]["curEvent"]) || var8[var9] != level.battlechattercustom[var0]["curEvent"]) {
      continue;
    }

    if(isarray(level.battlechattercustom[var0][var8[var9]])) {
      for(var10 = 0; var10 < level.battlechattercustom[var0][var8[var9]].size; var10++) {
        if(isarray(level.battlechattercustom[var0][var8[var9]][var10])) {
          for(var11 = 0; var11 < level.battlechattercustom[var0][var8[var9]][var10].size; var11++) {
            if(isradioline(level.battlechattercustom[var0][var8[var9]][var10][var11])) {
              var7 = var6 + getcustombcradioprefix(level.battlechattercustom[var0][var8[var9]][var10][var11]);
            } else {
              var7 = var5;
            }

            if(!isDefined(var1)) {
              var1 = var7 + level.battlechattercustom[var0][var8[var9]][var10][var11];
              var3 = var11;
              continue;
            }

            var4 = 1;
            var2 = var7 + level.battlechattercustom[var0][var8[var9]][var10][var11];
          }

          if(isDefined(var2)) {
            cleancustombc(var8[var9], var0, var10, var3, 0);
            cleancustombc(var8[var9], var0, var10, var3);
          } else {
            cleancustombc(var8[var9], var0, var10, var3);
          }

          break;
        }

        var7 = scripts\engine\utility::ter_op(isradioline(level.battlechattercustom[var0][var8[var9]][var10]), var6, var5);
        var1 = var7 + level.battlechattercustom[var0][var8[var9]][var10];
        cleancustombc(var8[var9], var0, var10, var3);
        break;
      }

      break;
    }

    var7 = scripts\engine\utility::ter_op(isradioline(level.battlechattercustom[var0][var8[var9]]), var6, var5);
    var1 = var7 + level.battlechattercustom[var0][var8[var9]];
    break;
  }

  if(isDefined(var4)) {
    return [var1, var2];
  }

  return var1;
}

function cleancustombc(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(istrue(level.battlechattercustom[var1][var0]["looping"])) {
    if(var4) {
      level.battlechattercustom[var1][var0] = custombcshiftarray(level.battlechattercustom[var1][var0]);
    }
  } else {
    level.battlechattercustom[var1][var0][var2] = scripts\engine\utility::array_remove_index(level.battlechattercustom[var1][var0][var2], var3);

    if(level.battlechattercustom[var1][var0][var2].size < 1) {
      level.battlechattercustom[var1][var0] = scripts\engine\utility::array_remove_index(level.battlechattercustom[var1][var0], var2);
    }
  }

  if(level.battlechattercustom[var1][var0].size < 1) {
    level.battlechattercustom[var1] = scripts\engine\utility::array_remove_key(level.battlechattercustom[var1], var0);
    return;
  }
}

function custombcshiftarray(var0) {
  if(!isDefined(var0["count"])) {
    GscBinSkip0(0x2e, "count", 1);
  }

  var1 = [];
  var2 = [];
  var3 = getarraykeys(var0);

  foreach(var5 in var3) {
    if(isnumber(var5)) {
      if(var5 != 0) {
        var1 = var0[var5];
      }

      continue;
    }

    var2 = var0[var5];
  }

  var1 = var0[0];

  if(var0["count"] == var1.size) {
    for(var1 = scripts\engine\utility::array_randomize(var1); var1[0][0] == var0[0][0]; var1 = scripts\engine\utility::array_randomize(var1)) {}

    var0 = 1;
  } else {
    var0 = var0["count"] + 1;
  }

  var3 = getarraykeys(var2);

  foreach(var5 in var3) {
    var1 = var2[var5];
  }

  var1 = var0["count"];
  return var1;
}

function addcustombc(var0, var1, var2) {
  if(!isDefined(level.battlechattercustom)) {
    level.battlechattercustom = [];
  }

  if(!isarray(var1)) {
    var1 = [var1];
  }

  foreach(var4 in var1) {
    if(!isDefined(level.battlechattercustom[var4])) {
      level.battlechattercustom[var4] = [];
    }
  }

  var6 = getarraykeys(var0);

  for(var7 = 0; var7 < var6.size; var7++) {
    for(var8 = 0; var8 < var0[var6[var7]].size; var8++) {
      foreach(var4 in var1) {
        level.battlechattercustom[var4][var6[var7]][var8] = var0[var6[var7]][var8];
      }
    }
  }

  if(isDefined(var2)) {
    foreach(var12 in var6) {
      foreach(var4 in var1) {
        level.battlechattercustom[var4][var12] = scripts\engine\utility::array_randomize(level.battlechattercustom[var4][var12]);
      }
    }

    return;
  }
}

function setcurrentcustombcevent(var0, var1, var2) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  foreach(var4 in var1) {
    level.battlechattercustom[var4]["curEvent"] = var0;
    level.battlechattercustom[var4][var0]["looping"] = var2;

    if(scripts\engine\utility::array_contains(getarraykeys(level.battlechattercustom[var4]), var0)) {}
  }
}

function clearcurrentcustombcevent(var0) {
  level.battlechattercustom[var0]["curEvent"] = undefined;
}

function removecustombcevent(var0, var1) {
  var2 = getarraykeys(level.battlechattercustom[var1]);
  level.battlechattercustom[var1] = scripts\engine\utility::array_remove_key(level.battlechattercustom[var1], var0);
}

function uselocationbc(var0) {
  var1 = getvalidlocation(self, "stealth", var0);

  if(isDefined(var1)) {
    return true;
  }

  return false;
}

function getstealthlocationalias(var0) {
  if(!isDefined(var0)) {
    var0 = "";
  }

  var1 = getvalidlocation(self, "stealth", var0);
  location_add_last_callout_time(var1);

  switch (var0) {
    case "update":
    case "callin":
      var2 = randomintrange_otn(1);
      var3 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_" + var0 + "_" + var1.locationaliases[0] + "_");
      GscBinSkip1(0x45, 0, var3 + var2);

    case "checkin":
      var2 = randomintrange_otn(1);
      var3 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_" + var2 + "_" + var3.locationaliases[0] + "_");
      GscBinSkip1(0x45, 0, createleaderalias(var3, var2));
  }
}

function isradioline(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(getsubstr(var0, var0.size - 2, var0.size) == "_r") {
    return 1;
  }

  if(issubstr(var0, "_r_")) {
    return 1;
  }

  if(issubstr(var0, "_aql1r_")) {
    return scripts\engine\utility::ter_op(var1, "_aql1_", 1);
  }

  if(issubstr(var0, "_aql2r_")) {
    return scripts\engine\utility::ter_op(var1, "_aql2_", 1);
  }

  if(issubstr(var0, "_rul1r_")) {
    return scripts\engine\utility::ter_op(var1, "_rul1_", 1);
  }

  if(issubstr(var0, "_rul2r_")) {
    return scripts\engine\utility::ter_op(var1, "_rul2_", 1);
  }

  return 0;
}

function getcustombcradioprefix(var0) {
  return isradioline(var0, 1);
}

function createleaderalias(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  } else {
    var1 = "_" + var1;
  }

  var2 = strtok(var0, "_");
  GscBinSkip0(0x2e, 2, self.battlechatter.countryid + "l1");
}

function scalebattlechatterfrequency(var0) {
  if(!isDefined(level.bcs_frequencyscalar)) {
    level.bcs_frequencyscalar = var0;
  }

  var1 = 1 / level.bcs_frequencyscalar;
  var0 = var1 * var0;
  level.bcs_frequencyscalar = var0;

  while(!isDefined(anim.eventactionminwait)) {
    waitframe();
  }

  var2 = getarraykeys(anim.eventactionminwait);

  foreach(var4 in var2) {
    var5 = getarraykeys(anim.eventactionminwait[var4]);

    foreach(var7 in var5) {
      anim.eventactionminwait[var4][var7] = var0 * anim.eventactionminwait[var4][var7];
    }
  }

  var2 = getarraykeys(anim.eventtypeminwait);

  foreach(var4 in var2) {
    if(isarray(anim.eventtypeminwait[var4])) {
      var5 = getarraykeys(anim.eventtypeminwait[var4]);

      foreach(var7 in var5) {
        anim.eventtypeminwait[var4][var7] = var0 * anim.eventtypeminwait[var4][var7];
      }
    }
  }

  var2 = getarraykeys(anim.eventduration);

  foreach(var4 in var2) {
    var5 = getarraykeys(anim.eventduration[var4]);

    foreach(var7 in var5) {
      anim.eventduration[var4][var7] = var0 * anim.eventduration[var4][var7];
    }
  }
}