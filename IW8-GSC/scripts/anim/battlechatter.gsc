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

  foreach(var_1 in anim.teams) {
    anim.isteamspeaking[var_1] = 0;
    anim.isteamsaying[var_1]["threat"] = 0;
    anim.isteamsaying[var_1]["order"] = 0;
    anim.isteamsaying[var_1]["reaction"] = 0;
    anim.isteamsaying[var_1]["response"] = 0;
    anim.isteamsaying[var_1]["inform"] = 0;
    anim.isteamsaying[var_1]["vehicle"] = 0;
    anim.isteamsaying[var_1]["custom"] = 0;
    anim.isteamsaying[var_1]["stealth"] = 0;
  }

  bcs_setup_chatter_toggle_array();
  bcs_setup_flavorburst_toggle_array();
  anim.lastteamspeaktime = [];
  anim.lastnamesaid = [];
  anim.lastnamesaidtime = [];

  foreach(var_1 in anim.teams) {
    anim.lastteamspokentime[var_1] = gettime();
    anim.lastteamspeaktime[var_1] = -50000;
    anim.lastnamesaid[var_1] = "none";
    anim.lastnamesaidtime[var_1] = -100000;
  }

  anim.lastnamesaidtimeout = 120000;

  for(var_5 = 0; var_5 < anim.squadindex.size; var_5++) {
    if(isDefined(anim.squadindex[var_5].chatinitialized) && anim.squadindex[var_5].chatinitialized) {
      continue;
    }

    init_squadbattlechatter(anim.squadindex[var_5]);
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

  foreach(var_1 in anim.teams) {
    anim.lastteamthreatcallout[var_1] = undefined;
    anim.lastteamthreatcallouttime[var_1] = undefined;
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

function bcs_setup_voice(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  anim.usedids[var_0] = [];

  for(var_4 = 0; var_4 < var_2; var_4++) {
    anim.usedids[var_0][var_4] = spawnStruct();
    anim.usedids[var_0][var_4].count = 0;
    anim.usedids[var_0][var_4].npcid = "" + var_4 + 1;
  }

  anim.countryids[var_0] = var_1;
  anim.flavorburstvoices[var_0] = var_3;
}

function bcs_setup_chatter_toggle_array() {
  bcs_setup_teams_array();

  if(!isDefined(level.battlechatter)) {
    level.battlechatter = [];

    foreach(var_1 in anim.teams) {
      scripts\engine\sp\utility::set_battlechatter_variable(var_1, 0);
    }

    return;
  }
}

function bcs_setup_flavorburst_toggle_array() {
  bcs_setup_teams_array();

  if(!isDefined(level.flavorbursts)) {
    level.flavorbursts = [];

    foreach(var_1 in anim.teams) {
      level.flavorbursts[var_1] = 0;
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

  for(var_0 = 0; var_0 < anim.squadcreatefuncs.size; var_0++) {
    if(anim.squadcreatestrings[var_0] != "::init_squadBattleChatter") {
      continue;
    }

    if(var_0 != anim.squadcreatefuncs.size - 1) {
      anim.squadcreatefuncs[var_0] = anim.squadcreatefuncs[anim.squadcreatefuncs.size - 1];
      anim.squadcreatestrings[var_0] = anim.squadcreatestrings[anim.squadcreatestrings.size - 1];
    }

    anim.squadcreatefuncs[anim.squadcreatefuncs.size - 1] = undefined;
    anim.squadcreatestrings[anim.squadcreatestrings.size - 1] = undefined;
  }

  level notify("battlechatter disabled");
  anim notify("battlechatter disabled");
}

function init_squadbattlechatter() {
  var_0 = self;
  var_0.numspeakers = 0;
  var_0.maxspeakers = 1;
  var_0.nextsaytime = gettime() + 50;
  var_0.nextsaytimes["threat"] = gettime() + 50;
  var_0.nextsaytimes["order"] = gettime() + 50;
  var_0.nextsaytimes["reaction"] = gettime() + 50;
  var_0.nextsaytimes["response"] = gettime() + 50;
  var_0.nextsaytimes["inform"] = gettime() + 50;
  var_0.nextsaytimes["vehicle"] = gettime() + 50;
  var_0.nextsaytimes["custom"] = gettime() + 50;
  var_0.nextsaytimes["stealth"] = gettime() + 50;
  var_0.nexttypesaytimes["threat"] = [];
  var_0.nexttypesaytimes["order"] = [];
  var_0.nexttypesaytimes["reaction"] = [];
  var_0.nexttypesaytimes["response"] = [];
  var_0.nexttypesaytimes["inform"] = [];
  var_0.nexttypesaytimes["vehicle"] = [];
  var_0.nexttypesaytimes["custom"] = [];
  var_0.nexttypesaytimes["stealth"] = [];
  var_0.ismembersaying["threat"] = 0;
  var_0.ismembersaying["order"] = 0;
  var_0.ismembersaying["reaction"] = 0;
  var_0.ismembersaying["response"] = 0;
  var_0.ismembersaying["inform"] = 0;
  var_0.ismembersaying["vehicle"] = 0;
  var_0.ismembersaying["custom"] = 0;
  var_0.ismembersaying["stealth"] = 0;
  var_0.lastdirection = "";
  var_0.memberaddfuncs[var_0.memberaddfuncs.size] = &scripts\anim\battlechatter_ai::addtosystem;
  var_0.memberremovefuncs[var_0.memberremovefuncs.size] = &scripts\anim\battlechatter_ai::removefromsystem;
  var_0.squadupdatefuncs[var_0.squadupdatefuncs.size] = &initcontact;
  var_0.fbt_firstburst = 1;
  var_0.fbt_lastbursterid = undefined;

  for(var_1 = 0; var_1 < anim.squadindex.size; var_1++) {
    thread initcontact(var_0);
  }

  var_0 thread scripts\anim\battlechatter_ai::squadthreatwaiter();
  thread squadflavorbursttransmissions();
  var_0.chatinitialized = 1;
  var_0 notify("squad chat initialized");
}

function shutdown_squadbattlechatter() {
  var_0 = self;
  var_0.numspeakers = undefined;
  var_0.maxspeakers = undefined;
  var_0.nextsaytime = undefined;
  var_0.nextsaytimes = undefined;
  var_0.nexttypesaytimes = undefined;
  var_0.ismembersaying = undefined;
  var_0.fbt_firstburst = undefined;
  var_0.fbt_lastbursterid = undefined;

  for(var_1 = 0; var_1 < var_0.memberaddfuncs.size; var_1++) {
    var_0.memberaddfuncs[var_1] = undefined;
  }

  for(var_1 = 0; var_1 < var_0.memberremovefuncs.size; var_1++) {
    var_0.memberremovestrings[var_1] = undefined;
  }

  for(var_1 = 0; var_1 < var_0.squadupdatefuncs.size; var_1++) {
    var_0.squadupdatefuncs[var_1] = undefined;
  }

  for(var_1 = 0; var_1 < anim.squadindex.size; var_1++) {
    shutdowncontact(var_0, anim.squadindex[var_1].squadname);
  }

  var_0.chatinitialized = 0;
}

function bcsenabled() {
  if(isDefined(anim.chatinitialized)) {
    return anim.chatinitialized;
  }

  return 0;
}

function bcsdebugwaiter() {
  var_0 = getdvarint("bcs_enable");

  for(;;) {
    var_1 = getdvarint("bcs_enable");

    if(var_1 != var_0) {
      switch (var_1) {
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

      var_0 = var_1;
    }

    wait 1;
  }
}

function enablebattlechatter() {
  init_battlechatter();
  anim.player thread scripts\anim\battlechatter_ai::addtosystem();
  var_0 = getaiarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] scripts\anim\battlechatter_ai::addtosystem();
  }
}

function disablebattlechatter() {
  if(!isDefined(anim.chatinitialized)) {
    return;
  }

  shutdown_battlechatter();
  var_0 = getaiarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1].squad) && var_0[var_1].squad.chatinitialized) {
      shutdown_squadbattlechatter(var_0[var_1].squad);
    }

    var_0[var_1] scripts\anim\battlechatter_ai::removefromsystem();
  }
}

function setplayerbcnameid(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    anim.player.bcnameid = var_0;
    anim.player.bccountryid = var_1;
    return;
  }

  while(!isDefined(level.campaign)) {
    wait 0.1;
  }

  var_2 = level.campaign;
  var_3 = anim.playernameids[var_2];
  var_4 = anim.countryids[var_2];

  if(isDefined(var_3)) {
    anim.player.bcnameid = var_3;
  }

  if(isDefined(var_4)) {
    anim.player.bccountryid = var_4;
    return;
  }
}

function bc_prefix(var_0, var_1) {
  if(!isDefined(self.battlechatter.npcid)) {
    self.battlechatter.npcid = "";
  }

  if(self == anim.player) {
    return "UN_plr_";
  }

  if(isDefined(var_0) && var_0 == "stealth") {
    if(getDvar("bcs_otnStealth") != "off") {
      if(istrue(var_1)) {
        return tolower("dx_otn_" + self.battlechatter.countryid + "l1_");
      }

      return tolower("dx_otn_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
    }

    if(istrue(var_1)) {
      return tolower("dx_cst_" + self.battlechatter.countryid + "l1_");
    }

    return tolower("dx_cst_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
  }

  if(isDefined(var_0) && var_0 == "custom") {
    return tolower("dx_vom_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
  }

  if(isDefined(var_0) && var_0 == "custom radio") {
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

function getbattlechatteralias(var_0) {
  var_1 = undefined;
  var_2 = bc_prefix();

  switch (var_0) {
    case "check_fire":
      var_1 = var_2 + "response_check_fire";
      break;
    case "concat_clock":
      var_1 = var_2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_clock_";
      break;
    case "concat_compass":
      var_1 = var_2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_compass_";
      break;
    case "concat_dist":
      var_1 = var_2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_dist_";
      break;
    case "concat_elev":
      var_1 = var_2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_elev_";
      break;
    case "concat_left":
      var_1 = var_2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_left";
      break;
    case "concat_right":
      var_1 = var_2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_right";
      break;
    case "concat_center":
      var_1 = var_2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_center";
      break;
    case "concat_target":
      var_1 = var_2 + scripts\anim\battlechatter_ai::getbcstate() + "_concat_target";
      break;
    case "contact_movement_group":
      var_1 = var_2 + "contact_movement_group";
      break;
    case "exposed_acquired":
      var_1 = var_2 + "exposed_acquired";
      break;
    case "exposed_breaking":
      var_1 = var_2 + "exposed_breaking";
      break;
    case "exposed_movement":
      var_1 = var_2 + "exposed_movement";
      break;
    case "exposed_movement_group":
      var_1 = var_2 + "exposed_movement_group";
      break;
    case "exposed_open":
      var_1 = var_2 + "exposed_open";
      break;
    case "vehicle_incoming_helicopter":
      var_1 = var_2 + "vehicle_incoming_helicopter";
      break;
    case "vehicle_incoming_tank":
      var_1 = var_2 + "vehicle_incoming_tank";
      break;
    case "vehicle_incoming_technical":
      var_1 = var_2 + "vehicle_incoming_technical";
      break;
    case "vehicle_killfirm_helicopter":
      var_1 = var_2 + "vehicle_killfirm_helicopter";
      break;
    case "vehicle_killfirm_tank":
      var_1 = var_2 + "vehicle_killfirm_tank";
      break;
    case "vehicle_killfirm_technical":
      var_1 = var_2 + "vehicle_killfirm_technical";
      break;
    case "inform_molotov":
      var_1 = var_2 + "inform_molotov";
      break;
    case "inform_reloading":
      var_1 = var_2 + "inform_reloading";
      break;
    case "inform_taking_fire":
      var_1 = var_2 + "inform_taking_fire";
      break;
    case "inform_frag":
    case "inform_grenade":
      var_1 = var_2 + "inform_grenade";
      break;
    case "inform_incoming_grenade":
      var_1 = var_2 + "inform_incoming_grenade";
      break;
    case "inform_incoming_rpg":
      var_1 = var_2 + "inform_incoming_rpg";
      break;
    case "inform_incoming_sniper":
      var_1 = var_2 + "inform_incoming_sniper";
      break;
    case "inform_incoming_molotov":
      var_1 = var_2 + "inform_incoming_molotov";
      break;
    case "inform_killfirm_juggernaut":
    case "inform_killfirm_soldier":
      var_1 = var_2 + "inform_killfirm_soldier";
      break;
    case "location_response":
      var_1 = var_2 + scripts\anim\battlechatter_ai::getbcstate() + "_location_resp";
      break;
    case "order_coverme":
      var_1 = var_2 + "order_coverme";
      break;
    case "order_movecombat":
      var_1 = var_2 + "order_move_combat";
      break;
    case "order_movenoncombat":
      var_1 = var_2 + "order_move_noncombat";
      break;
    case "order_suppress":
      var_1 = var_2 + "order_suppress";
      break;
    case "reaction_casualty":
      var_1 = var_2 + "reaction_casualty";
      break;
    case "reaction_hostile_burst":
      var_1 = var_2 + "reaction_hostile_burst";
      break;
    case "response_ack_affirm":
      var_1 = var_2 + "response_ack_affirm";
      break;
    case "response_threat_affirm":
      var_1 = var_2 + "response_threat_affirm";
      break;
    case "response_threat_neg":
      var_1 = var_2 + "response_threat_neg";
      break;
    case "taunt":
      var_1 = var_2 + "taunt";
      break;
    case "threat_callout_acquired":
      var_1 = var_2 + "acquired_";
      break;
    case "threat_callout_sighted":
      var_1 = var_2 + "sighted_";
      break;
    case "threat_callout_contactcompass":
      var_1 = var_2 + "contact_compass_";
      break;
    case "threat_callout_contactdistance":
      var_1 = var_2 + "contact_dist_";
      break;
    case "threat_callout_contactelev":
      var_1 = var_2 + "contact_elev_";
      break;
    case "threat_callout_targetcompass":
      var_1 = var_2 + "target_compass_";
      break;
    case "threat_callout_targetdistance":
      var_1 = var_2 + "target_dist_";
      break;
    case "threat_callout_targetelev":
      var_1 = var_2 + "target_elev_";
      break;
    default:
      break;
  }

  return var_1;
}

function playbattlechatter(var_0) {
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

  if(!isDefined(var_0)) {
    var_0 = gethighestpriorityevent();
  }

  if(isDefined(self.bc_event_override)) {
    var_0 = self.bc_event_override;
  }

  if(!isDefined(var_0)) {
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

  switch (var_0) {
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

function addeventplaybcs(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("cancel speaking");
  self endon("stop event play bcs");

  if(isDefined(var_3)) {
    wait var_3;
  }

  var_6 = undefined;

  switch (var_0) {
    case "stealth":
      var_6 = scripts\anim\battlechatter_ai::addstealthevent(var_1, var_2, undefined, var_4);
      break;
    default:
      break;
  }

  if(!var_6) {
    return;
  }

  self.squad.nexttypesaytimes[var_0][var_1] = gettime() + anim.eventtypeminwait[var_0][var_1];

  if(istrue(var_5)) {
    self.battlechatter.isspeaking = 0;
    anim.isteamspeaking[self.team] = 0;
  }

  if(var_6) {
    thread playbattlechatter(var_0);
    self notify("stop event play bcs");
    return;
  }
}

function playthreatevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("cancel speaking");
  self.curevent = self.battlechatter.chatqueue["threat"];
  var_0 = self.battlechatter.chatqueue["threat"].threat;

  if(!isalive(var_0)) {
    return;
  }

  if(threatwasalreadycalledout(var_0) && !isPlayer(var_0)) {
    return;
  }

  thread lockaction(anim, self);
  var_1 = 0;
  var_2 = self.battlechatter.chatqueue["threat"].eventtype;

  switch (var_2) {
    case "infantry":
      if(isPlayer(var_0) || !isDefined(var_0 getturret())) {
        if(isDefined(self._blackboard)) {
          self._blackboard.battlechatter_target = var_0;
        }

        var_1 = threatinfantry(var_0, undefined);
      }

      break;
    case "vehicle":
      var_1 = threatvehicle(var_0);
      break;
    case "acquired":
      self.callout_type_override = var_2;
      var_1 = threatinfantry(var_0, undefined);
      break;
    case "sighted":
      self.callout_type_override = var_2;
      var_1 = threatinfantry(var_0, undefined);
      break;
  }

  var_3 = self;
  var_3 notify("done speaking");

  if(!var_1) {
    return;
  }

  if(!isalive(var_0)) {
    return;
  }

  var_0.battlechatter.calledout[var_3.squad.squadname] = spawnStruct();
  var_0.battlechatter.calledout[var_3.squad.squadname].spotter = var_3;
  var_0.battlechatter.calledout[var_3.squad.squadname].threattype = var_3.battlechatter.chatqueue["threat"].eventtype;
  var_0.battlechatter.calledout[var_3.squad.squadname].expiretime = gettime() + anim.bcs_threatresettime;

  if(isDefined(var_0.squad)) {
    var_3.squad.squadlist[var_0.squad.squadname].calledout = 1;
    return;
  }
}

function threatwasalreadycalledout(var_0) {
  if(isDefined(var_0.battlechatter.calledout) && isDefined(var_0.battlechatter.calledout[self.squad.squadname])) {
    if(var_0.battlechatter.calledout[self.squad.squadname].expiretime > gettime()) {
      return true;
    }
  }

  return false;
}

function threatinfantry(var_0, var_1) {
  self endon("cancel speaking");
  var_2 = createchatphrase();
  var_2.master = 1;
  var_2.threatent = var_0;
  var_3 = getthreatinfantrycallouttype(var_0);

  if(!isDefined(var_3) || isDefined(var_3) && !isDefined(var_3.type)) {
    return false;
  }

  var_4 = undefined;

  if(isDefined(self.callout_type_override)) {
    var_4 = self.callout_type_override;
  } else {
    var_4 = var_3.type;
  }

  switch (var_4) {
    case "exposed":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_3.responder;
      }

      var_5 = doexposedcalloutresponse(var_3.responder);
      var_6 = self;

      if(var_5 && cansayname(var_6, var_3.responder)) {
        addnamealias(var_2, var_3.responder.bcname);
        var_2.bc_looktarget = var_3.responder;
      }

      threatinfantryexposed(var_2, var_0);

      if(var_5) {
        if(randomint(100) < anim.eventchance["response"]["callout_negative"]) {
          var_3.responder scripts\anim\battlechatter_ai::addresponseevent("callout", "neg", self, 0.9);
        } else {
          var_3.responder scripts\anim\battlechatter_ai::addresponseevent("exposed", "acquired", self, 0.9);
        }
      }

      break;
    case "acquired":
      addplayernamealias(var_2);
      addthreatcalloutalias(var_2, "acquired", var_3.playerclockdirection);
      break;
    case "sighted":
      addplayernamealias(var_2);
      addthreatcalloutalias(var_2, "sighted", var_3.playerclockdirection);
      break;
    case "target_compass":
      var_7 = self;

      if(self.team == "allies") {
        var_7 = anim.player;
      } else if(isDefined(var_3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var_7 = var_3.responder;
      }

      var_8 = getdirectioncompass(var_7.origin, var_0.origin);
      var_9 = normalizecompassdirection(var_8);

      if(var_9 == "impossible") {
        return false;
      }

      addplayernamealias(var_2);

      if(addthreatcalloutalias(var_2, "compass", var_9, 1)) {
        addcalloutresponseevent(var_2, self, var_3, var_0);

        if(isDefined(self._blackboard)) {
          self._blackboard.battlechatter_target = var_0;
        }
      }

      break;
    case "target_distance":
      var_7 = self;

      if(self.team == "allies") {
        var_7 = anim.player;
      } else if(isDefined(var_3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var_7 = var_3.responder;
      }

      var_10 = getdistancemetersnormalized(var_7.origin, var_0.origin);

      if(isDefined(var_10)) {
        addplayernamealias(var_2);

        if(addthreatcalloutalias(var_2, "distance", var_10, 1)) {
          addcalloutresponseevent(var_2, self, var_3, var_0);

          if(isDefined(self._blackboard)) {
            self._blackboard.battlechatter_target = var_0;
          }
        }
      }

      break;
    case "target_elev":
      var_7 = self;

      if(self.team == "allies") {
        var_7 = anim.player;
      } else if(isDefined(var_3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var_7 = var_3.responder;
      }

      var_11 = getdegreeselevation(var_7.origin, var_0.origin);

      if(var_11 >= 20 && var_11 <= 60) {
        addplayernamealias(var_2);

        if(addthreatcalloutalias(var_2, "elev", var_11, 1)) {
          addcalloutresponseevent(var_2, self, var_3, var_0);

          if(isDefined(self._blackboard)) {
            self._blackboard.battlechatter_target = var_0;
          }
        }
      }

      break;
    case "generic_location":
      var_6 = self;
      var_7 = self;

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_0;
      }

      var_12 = threatinfantry_docalloutlocation(var_2, var_3, undefined, var_6);

      if(!var_12) {
        return false;
      }

      if(self.team == "allies") {
        var_7 = anim.player;
      }

      addconcatdirectionalias(var_2, var_7, var_0);
      addcalloutresponseevent(var_2, self, var_3, var_0);
      break;
    case "player_location":
      var_6 = self;
      addplayernamealias(var_2);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = anim.player;
      }

      var_12 = threatinfantry_docalloutlocation(var_2, var_3, undefined, var_6);

      if(!var_12) {
        return false;
      }

      break;
    case "concat_location":
      var_13 = 0;

      if(randomint(3)) {
        var_13 = 1;
        addconcattargetalias(var_2, var_0);
      }

      var_6 = self;
      var_7 = self;

      if(self.team == "allies") {
        var_7 = anim.player;
      }

      var_12 = threatinfantry_docalloutlocation(var_2, var_3, 1, var_6);

      if(!var_12) {
        return false;
      }

      if(!var_13) {
        addconcatdirectionalias(var_2, var_7, var_0);
      } else if(randomint(3)) {
        addconcatdirectionalias(var_2, var_7, var_0);
      }

      addcalloutresponseevent(var_2, self, var_3, var_0);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_0;
      }

      break;
    case "ai_location":
      var_6 = self;

      if(cansayname(var_6, var_3.responder)) {
        addnamealias(var_2, var_3.responder.bcname);
        var_2.bc_looktarget = var_3.responder;
      }

      var_12 = threatinfantry_docalloutlocation(var_2, var_3, undefined, var_6);

      if(!var_12) {
        return false;
      }

      var_14 = var_2.soundaliases.size - 1;
      var_15 = var_2.soundaliases[var_14];

      if(iscallouttypereport(var_15)) {
        var_3.responder scripts\anim\battlechatter_ai::addresponseevent("callout", "echo", self, 0.9, var_15);
      } else if(iscallouttypeqa(var_15, self)) {
        var_3.responder scripts\anim\battlechatter_ai::addresponseevent("callout", "QA", self, 0.9, var_15, var_3.location);
      } else if(randomint(100) < anim.eventchance["response"]["callout_negative"]) {
        var_3.responder scripts\anim\battlechatter_ai::addresponseevent("callout", "neg", self, 0.9);
      } else {
        var_3.responder scripts\anim\battlechatter_ai::addresponseevent("exposed", "acquired", self, 0.9);
      }

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_0;
      }

      break;
  }

  setlastcallouttype(var_3.type);
  var_6 = self;

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_line_ok = 0;
  }

  playphrase(var_6, var_2, self);

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  return true;
}

function threatvehicle(var_0) {
  self endon("cancel speaking");
  var_1 = createchatphrase();
  var_1.master = 1;
  var_1.threatent = var_0;
  iprintln("MAKE SURE THIS DOESN'T GET CALLED");
  addthreatalias(var_1, "vehicle");
  setlastcallouttype("vehicle");
  var_2 = self;

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_line_ok = 0;
  }

  playphrase(var_2, var_1, self);

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  return true;
}

function doexposedcalloutresponse(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!scripts\anim\battlechatter_gamesku::isalliedcountryid(var_0.battlechatter.countryid)) {
    return false;
  }

  if(randomint(100) > anim.eventchance["response"]["exposed"]) {
    return false;
  }

  return true;
}

function threatinfantry_docalloutlocation(var_0, var_1, var_2) {
  var_3 = addthreatcalloutlocationalias(var_0.location, var_1, var_2);
  return var_3;
}

function addcalloutresponseevent(var_0, var_1, var_2) {
  if(!isDefined(var_1.responder)) {
    return;
  }

  if(var_1.responder.team != var_0.team) {
    return;
  }

  if(randomint(100) > anim.eventchance["response"]["callout"]) {
    return;
  }

  var_3 = "neg";
  var_4 = "callout";

  if(!var_1.responder scripts\anim\battlechatter_ai::bccansee(var_2, 1) && randomint(100) < anim.eventchance["response"]["callout_negative"]) {} else {
    var_3 = "affirm";

    if(isDefined(var_1.location)) {
      var_5 = getvalidlocation(var_2, var_1.responder, "response");

      if(isDefined(var_5) && isDefined(var_5.locationaliases[0])) {
        var_3 = var_5.locationaliases[0];
        var_4 = "location";
      }
    }
  }

  var_1.responder scripts\anim\battlechatter_ai::addresponseevent(var_4, var_3, var_0, 0.9);
}

function getthreatinfantrycallouttype(var_0) {
  var_1 = getvalidlocation(var_0, self);
  var_2 = getdirectionfacingclock(self.angles, self.origin, var_0.origin);
  var_3 = getresponder(64, 1024, "response");
  var_4 = undefined;

  if(isDefined(var_3)) {
    var_4 = getdirectionfacingclock(var_3.angles, var_3.origin, var_0.origin);
  }

  var_5 = getdirectionfacingclock(anim.player.angles, anim.player.origin, var_0.origin);

  if(self.team == "allies") {
    var_6 = var_5;
    var_7 = anim.player;
  } else if(isDefined(var_5)) {
    var_6 = var_6;
    var_7 = var_5;
  } else {
    var_6 = var_6;
    var_7 = self;
  }

  var_8 = getdistancemeters(var_7.origin, var_4.origin);
  self.possiblethreatcallouts = [];

  if(!isDefined(var_5) && isexposed(var_4, 0)) {
    addpossiblethreatcallout("exposed");
  }

  if(var_6 == "11" || var_6 == "12" || var_6 == "1") {
    if(var_4.origin[2] - var_7.origin[2] >= level.heightforhighcallout) {
      addpossiblethreatcallout("target_elev");
    }

    if(var_8 > level.mindistancecallout && var_8 < level.maxdistancecallout) {
      addpossiblethreatcallout("target_distance");
    }
  }

  addpossiblethreatcallout("target_compass");

  if(isDefined(var_5)) {
    if(canconcat(var_5) && randomint(3) == 0) {
      addpossiblethreatcallout("concat_location");
    } else if(isDefined(getcannedresponse(var_5, self))) {
      if(isDefined(var_7)) {
        addpossiblethreatcallout("ai_location");
      } else {
        battlechatter_printwarning("Calling out a location at origin " + var_5.origin + " with a canned response, but there are no AIs able to respond.");

        if(cansayplayername()) {
          addpossiblethreatcallout("player_location");
        }

        addpossiblethreatcallout("generic_location");
      }
    } else {
      if(isDefined(var_7)) {
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

  var_9 = getweightedchanceroll(self.possiblethreatcallouts, anim.threatcallouts);
  var_10 = spawnStruct();
  var_10.type = var_9;
  var_10.responder = var_7;
  var_10.responderclockdirection = var_6;
  var_10.playerclockdirection = var_7;

  if(isDefined(var_5)) {
    var_10.location = var_5;
  }

  if(battlechatter_canprint()) {
    var_11 = 60;

    for(var_12 = 0; var_12 < self.possiblethreatcallouts.size; var_12++) {
      var_13 = scripts\engine\utility::ter_op(self.possiblethreatcallouts[var_12] == var_10.type, (0, 1, 0), (1, 1, 1));
      var_11 -= 4;
    }
  }

  return var_10;
}

function cancalloutlocation(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  foreach(var_4 in var_0.locationaliases) {
    var_5 = undefined;

    if(var_1 == "stealth") {
      if(var_2 == "checkin") {
        var_6 = randomintrange_otn(1);
        var_4 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_" + var_2 + "_" + var_4 + "_");
        var_4 = createleaderalias(var_4, var_6);
      } else {
        var_4 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_" + var_2 + "_" + var_4 + "_" + randomintrange_otn(1));
      }

      var_7 = soundexists(var_4);
    } else if(var_1 == "response") {
      var_5 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_resp_" + var_4);
      var_7 = soundexists(var_5);
    } else {
      var_5 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_callout_" + var_4);
      var_8 = getqacalloutalias(var_4, 0);
      var_9 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_concat_" + var_4);
      var_7 = soundexists(var_5) || soundexists(var_8) || soundexists(var_9);
    }

    if(var_7) {
      return var_7;
    }

    if(isDefined(var_5)) {
      var_4 = var_5;
    }

    battlechatter_printwarning("Missing location alias: " + var_4);
  }

  return 0;
}

function canconcat(var_0) {
  var_1 = var_0.locationaliases;

  foreach(var_3 in var_1) {
    if(iscallouttypeconcat(var_3, self)) {
      return true;
    }
  }

  return false;
}

function getcannedresponse(var_0) {
  var_1 = undefined;
  var_2 = self.locationaliases;

  foreach(var_4 in var_2) {
    if(iscallouttypeqa(var_4, var_0) && !isDefined(self.qafinished)) {
      var_1 = var_4;
      break;
    }

    if(iscallouttypereport(var_4)) {
      var_1 = var_4;
    }
  }

  return var_1;
}

function iscallouttypereport(var_0) {
  return issubstr(var_0, "_report");
}

function iscallouttypeconcat(var_0, var_1) {
  var_0 = getloccalloutalias(var_1, scripts\anim\battlechatter_ai::getbcstate() + "_location_concat_" + var_0);

  if(soundexists(var_0)) {
    return true;
  }

  return false;
}

function iscallouttypeqa(var_0, var_1) {
  if(issubstr(var_0, "_qa") && soundexists(var_0)) {
    return true;
  }

  var_2 = getqacalloutalias(var_1, var_0, 0);

  if(soundexists(var_2)) {
    return true;
  }

  return false;
}

function getloccalloutalias(var_0) {
  var_1 = undefined;

  if(self == anim.player) {
    var_1 = "UN_plr_";
    var_1 += var_0;
  } else {
    if(scripts\anim\battlechatter_ai::getbcstate() == "combat") {
      var_1 = bc_prefix();
    } else {
      var_1 = bc_prefix("stealth");
    }

    var_1 += var_0;
  }

  return var_1;
}

function getqacalloutalias(var_0, var_1) {
  var_2 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_callout_" + var_0);
  var_2 += "_qa" + var_1;
  return var_2;
}

function addallowedthreatcallout(var_0) {
  self.allowedcallouts[self.allowedcallouts.size] = var_0;
}

function addpossiblethreatcallout(var_0) {
  var_1 = 0;

  if(isDefined(self.allowedcallouts)) {
    foreach(var_3 in self.allowedcallouts) {
      if(var_3 == var_0) {
        if(!callouttypewillrepeat(var_0)) {
          var_1 = 1;
        }

        break;
      }
    }
  }

  if(!var_1) {
    return var_1;
  }

  self.possiblethreatcallouts[self.possiblethreatcallouts.size] = var_0;
  return var_1;
}

function callouttypewillrepeat(var_0) {
  if(!isDefined(anim.lastteamthreatcallout[self.team])) {
    return false;
  }

  if(!isDefined(anim.lastteamthreatcallouttime[self.team])) {
    return false;
  }

  var_1 = anim.lastteamthreatcallout[self.team];
  var_2 = anim.lastteamthreatcallouttime[self.team];
  var_3 = anim.teamthreatcalloutlimittimeout;

  if(var_0 == var_1 && gettime() - var_2 < var_3) {
    return true;
  }

  return false;
}

function setlastcallouttype(var_0) {
  anim.lastteamthreatcallout[self.team] = var_0;
  anim.lastteamthreatcallouttime[self.team] = gettime();
}

function getweightedchanceroll(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in var_0) {
    if(var_1[var_5] <= 0) {
      continue;
    }

    var_6 = randomint(var_1[var_5]);

    if(isDefined(var_2) && var_1[var_2] >= 100) {
      if(var_1[var_5] < 100) {
        continue;
      }

      continue;
    }

    if(var_1[var_5] >= 100) {
      var_2 = var_5;
      var_3 = var_6;
      continue;
    }

    if(var_6 > var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2;
}

function threatinfantryexposed(var_0) {
  var_1 = [];
  var_1 = scripts\engine\utility::array_add(var_1, "open");
  var_1 = scripts\engine\utility::array_add(var_1, "breaking");

  if(self.owner.team == "allies") {
    var_1 = scripts\engine\utility::array_add(var_1, "movement");
    var_2 = getaicount("axis");

    if(var_2 > 2) {
      var_1 = scripts\engine\utility::array_add(var_1, "group");
    }
  }

  var_3 = var_1[randomint(var_1.size)];
  addthreatexposedalias(var_3);
}

function playreactionevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.battlechatter.chatqueue["reaction"];
  var_0 = self.battlechatter.chatqueue["reaction"].reactto;
  var_1 = self.battlechatter.chatqueue["reaction"].modifier;
  thread lockaction(anim, self);

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
  }

  var_2 = self.battlechatter.chatqueue["reaction"].eventtype;

  switch (var_2) {
    case "casualty":
    case "danger":
    case "underfire":
    case "maneuver":
    case "movement":
      reactioncasualty(var_0, var_1, var_2);
      break;
    case "taunt":
      reactiontaunt(var_0, var_1, var_2);
      break;
    case "friendlyfire":
      reactionfriendlyfire(var_0, var_1, var_2);
      break;
    case "takingfire":
      reactiontakingfire(var_0, var_1, var_2);

      if(scripts\engine\utility::cointoss()) {
        var_3 = getresponder(64, 1024, "response");

        if(isDefined(var_3)) {
          if(scripts\engine\utility::cointoss()) {
            if(cansay(var_3, "reaction", "ask_ok", 1)) {
              var_3 scripts\anim\battlechatter_ai::addreactionevent("ask_ok", undefined, self, 1);
            }
          } else {
            var_3 scripts\anim\battlechatter_ai::addresponseevent("covering", "fire", self, 1);
          }
        }
      }

      break;
    case "ask_ok":
      responsetakingfire(var_0, "ask", "ok");
      var_3 = getresponder(64, 1024, "response");

      if(isDefined(var_3)) {
        var_3 scripts\anim\battlechatter_ai::addresponseevent("im", "ok", self, 1);
      }

      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
  }

  self notify("done speaking");
}

function reactioncasualty(var_0, var_1, var_2) {
  if(isDefined(var_0) && !scripts\engine\trace::can_see_origin(var_0.origin)) {
    return;
  }

  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = createchatphrase(var_3);
  addreactionalias(var_4, "casualty");
  playphrase(var_3, var_4, self);
}

function reactiontaunt(var_0, var_1, var_2) {
  var_3 = self;
  self endon("death");
  self endon("removed from battleChatter");
  var_4 = createchatphrase(var_3);

  if(isDefined(var_1) && var_1 == "hostileburst") {
    addhostileburstalias(var_4);
  } else {
    addtauntalias(var_4, "taunt");
  }

  playphrase(var_3, var_4, self);
}

function reactionfriendlyfire(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = createchatphrase(var_3);
  addcheckfirealias(var_4);
  playphrase(var_3, var_4, self);
}

function reactiontakingfire(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = createchatphrase(var_3);
  addtakingfirealias(var_4);
  playphrase(var_3, var_4, self);
}

function responsetakingfire(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("death");
  var_3 endon("removed from battleChatter");
  var_4 = createchatphrase(var_3);
  addresponsealias(var_4, var_1, var_2);
  playphrase(var_3, var_4, self);
}

function playresponseevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.battlechatter.chatqueue["response"];
  var_0 = self.battlechatter.chatqueue["response"].modifier;
  var_1 = self.battlechatter.chatqueue["response"].respondto;

  if(!isalive(var_1)) {
    return;
  }

  if(self.battlechatter.chatqueue["response"].modifier == "follow" && !scripts\asm\asm_bb::bb_moverequested()) {
    return;
  }

  thread lockaction(anim, self);

  switch (self.battlechatter.chatqueue["response"].eventtype) {
    case "exposed":
      responsethreatexposed(var_1, var_0);
      break;
    case "callout":
      responsethreatcallout(var_1, var_0, self.enemy);
      break;
    case "ack":
      responsegeneric(var_1, var_0);
      break;
    case "location":
      responselocationcallout(var_1, var_0, self.enemy);
      break;
    default:
      responsegeneric(var_1, var_0);
      break;
  }

  self notify("done speaking");
}

function responsethreatexposed(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }

  var_3 = createchatphrase(var_2);
  addthreatexposedalias(var_3, var_1);
  var_3.bc_looktarget = var_0;
  var_3.master = 1;
  playphrase(var_2, var_3, self);
}

function responsethreatcallout(var_0, var_1, var_2) {
  var_3 = self.curevent.reportalias;
  var_4 = self.curevent.location;
  var_5 = self;
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }

  var_6 = createchatphrase(var_5);
  var_7 = 0;

  if(var_1 == "echo") {
    var_7 = addthreatcalloutecho(var_6, var_3, var_0);
  } else if(var_1 == "QA") {
    var_7 = addthreatcalloutqa_nextline(var_6, var_0, var_3, var_4);
  } else {
    var_7 = addthreatcalloutresponsealias(var_6, var_1, var_2);
  }

  if(!var_7) {
    return;
  }

  var_6.bc_looktarget = var_0;
  var_6.master = 1;
  playphrase(var_5, var_6, self);
}

function responsegeneric(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }

  var_2 = self.battlechatter.chatqueue["response"].eventtype;
  var_3 = self;
  var_4 = createchatphrase(var_3);
  addresponsealias(var_4, var_2, var_1);
  var_4.bc_looktarget = var_0;
  var_4.master = 1;
  playphrase(var_3, var_4, self);
}

function responselocationcallout(var_0, var_1, var_2) {
  var_3 = self.curevent.reportalias;
  var_4 = self.curevent.location;
  var_5 = self;
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }

  var_6 = createchatphrase(var_5);
  var_7 = addlocationresponsealias(var_6, var_1, var_2);

  if(!var_7) {
    return;
  }

  var_6.bc_looktarget = var_0;
  var_6.master = 1;
  playphrase(var_5, var_6, self);
}

function playorderevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.battlechatter.chatqueue["order"];
  var_0 = self.battlechatter.chatqueue["order"].modifier;
  var_1 = self.battlechatter.chatqueue["order"].orderto;
  thread lockaction(anim, self);

  switch (self.battlechatter.chatqueue["order"].eventtype) {
    case "action":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = anim.player;
      }

      orderaction(var_0, var_1);
      break;
    case "move":
      ordermove(var_0, var_1);
      break;
    case "displace":
      orderdisplace(var_0);
      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  self notify("done speaking");
}

function orderaction(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");
  var_3 = createchatphrase(var_2);
  tryorderto(var_2, var_3, var_1);
  addorderalias(var_3, "action", var_0);
  playphrase(var_2, var_3, self);
}

function ordermove(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");
  var_3 = createchatphrase(var_2);
  tryorderto(var_2, var_3, var_1);
  addorderalias(var_3, "move", var_0);
  playphrase(var_2, var_3, self);
}

function orderdisplace(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = self;
  var_2 = createchatphrase(var_1);
  addorderalias(var_2, "displace", var_0);
  playphrase(var_1, var_2, self, 1);
}

function tryorderto(var_0, var_1) {
  if(randomint(100) > anim.eventchance["response"]["order"]) {
    if(!isDefined(var_1) || isDefined(var_1) && !isPlayer(var_1)) {
      return;
    }
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(anim.player.bcnameid)) {
    addplayernamealias(var_0);
    var_0.bc_looktarget = anim.player;
    return;
  }

  if(isDefined(var_1) && cansayname(var_1)) {
    addnamealias(var_0, var_1.bcname);
    var_0.bc_looktarget = var_1;
    var_1 scripts\anim\battlechatter_ai::addresponseevent("ack", "affirm", self, 0.9);
    return;
  }

  level notify("follow order", self);
}

function playvehicleevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.battlechatter.chatqueue["vehicle"];
  var_0 = self.battlechatter.chatqueue["vehicle"].eventtype;
  var_1 = self.battlechatter.chatqueue["vehicle"].modifier;
  thread lockaction(anim, self);

  if(self != anim.player) {
    self._blackboard.battlechatter_target = anim.player;
  }

  var_2 = self;
  var_3 = createchatphrase(var_2);
  addvehiclealias(var_3, var_0, var_1);
  playphrase(var_2, var_3, self);
  self notify("done speaking");
}

function playinformevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.battlechatter.chatqueue["inform"];
  var_0 = self.battlechatter.chatqueue["inform"].modifier;

  if(var_0 == "generic") {
    var_0 = undefined;
  }

  thread lockaction(anim, self);

  if(self != anim.player) {
    self._blackboard.battlechatter_target = anim.player;
  }

  switch (self.battlechatter.chatqueue["inform"].eventtype) {
    case "incoming":
      informincoming(var_0);
      break;
    case "attack":
      informattacking(var_0);
      break;
    case "reloading":
      informreloading(var_0);
      break;
    case "suppressed":
      informsuppressed(var_0);
      break;
    case "killfirm":
      informkillfirm(var_0);
      break;
  }

  self notify("done speaking");
}

function informreloading(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);
  addinformalias(var_2, "reloading", var_0);
  playphrase(var_1, var_2, self);
}

function informsuppressed(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);
  addinformalias(var_2, "suppressed", var_0);
  playphrase(var_1, var_2, self);
}

function informincoming(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);

  if(var_0 == "grenade" || var_0 == "rpg" || var_0 == "sniper" || var_0 == "molotov") {
    var_2.master = 1;
  }

  addinformalias(var_2, "incoming", var_0);
  playphrase(var_1, var_2, self);
}

function informattacking(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);
  addinformalias(var_2, var_0);
  playphrase(var_1, var_2, self);
}

function informkillfirm(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);
  addinformalias(var_2, "killfirm", var_0, self.curevent.threat_type);
  playphrase(var_1, var_2, self);
}

function playcustomevent() {
  var_0 = self.battlechatter.chatqueue["custom"];
  self.curevent = self.battlechatter.chatqueue["custom"];
  self.curevent.eventaction = "custom";
  self.curevent.eventtype = "generic";
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  thread lockaction(anim, var_1, "custom");
  var_2 = createchatphrase(var_1);
  var_2.soundaliases[0] = var_1.customchatphrase;
  playphrase(var_1, var_2, self);
  var_1 notify("done speaking");
  var_1.customchatevent = undefined;
  var_1.customchatphrase = undefined;
}

function playstealthevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self.battlechatter.chatqueue["stealth"].eventtype)) {
    iprintln("ChatQueue is undefined.What's going on?");
    return;
  }

  self.curevent = self.battlechatter.chatqueue["stealth"];
  var_0 = self.battlechatter.chatqueue["stealth"].modifier;
  thread lockaction(anim, self);

  switch (self.battlechatter.chatqueue["stealth"].eventtype) {
    case "idle":
      stealthidle(var_0);
      break;
    case "idle_alert":
      stealthidlealert(var_0);
      break;
    case "radio":
      stealthradio(var_0);
      break;
    case "investigate":
      stealthinvestigate(var_0);
      break;
    case "hunt":
      stealthhunt(var_0);
      break;
    case "combat":
      break;
    case "announce5":
    case "announce4":
    case "announce3":
    case "announce2":
    case "announce1":
      stealthannounce(var_0);
      break;
  }

  self notify("done speaking");
}

function stealthidle(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");

  if(isDefined(self.battlechatter.stealthidledelay) && self.battlechatter.stealthidledelay > gettime()) {
    return;
  }

  var_2 = createchatphrase(var_1);
  addstealthalias(var_2, "idle", var_0);
  var_3 = playphrase(var_1, var_2, self);

  if(stealthdocustombc(var_3)) {
    return;
  }

  if(var_3 && isDefined(var_2.checkin) && var_1 scripts\anim\battlechatter_ai::getbcstate() == "idle") {
    foreach(var_5 in var_2.responsealiases) {
      var_2.soundaliases = [];
      var_2.soundaliases[0] = var_5;

      if(isradioline(var_5)) {
        var_3 = stealthcommander(var_1, var_2.soundaliases[0]);
      } else {
        commander_delay(var_1);
        GscBinSkip4(0x6e, var_1, var_2.soundaliases[0], 1, 1);
      }

      if(!var_3 || var_1 scripts\anim\battlechatter_ai::getbcstate() != "idle") {
        break;
      }
    }

    return;
  }

  if(var_3 && isDefined(var_2.callin)) {
    if(isDefined(var_2.responsealiases[0]) && randomint(3)) {
      GscBinSkip4(0x6e, var_1, var_2.responsealiases[0]);
    }

    return;
  }

  if(var_3 && randomint(3)) {
    var_7 = ["dx_bcs_rul_contsweep_1", "dx_bcs_rul_contsweep_2", "dx_bcs_rul_contsweep_3", "dx_bcs_rul_contsweep_n_1", "dx_bcs_rul_contsweep_s_1", "dx_bcs_rul_contsweep_e_1", "dx_bcs_rul_contsweep_w_1"];

    if(issubstr(var_2.soundaliases[0], "_n_")) {
      var_7 = scripts\engine\utility::array_remove(var_7, "dx_bcs_rul_contsweep_n_1");
    } else if(issubstr(var_2.soundaliases[0], "_s_")) {
      var_7 = scripts\engine\utility::array_remove(var_7, "dx_bcs_rul_contsweep_s_1");
    } else if(issubstr(var_2.soundaliases[0], "_e_")) {
      var_7 = scripts\engine\utility::array_remove(var_7, "dx_bcs_rul_contsweep_e_1");
    } else if(issubstr(var_2.soundaliases[0], "_w_")) {
      var_7 = scripts\engine\utility::array_remove(var_7, "dx_bcs_rul_contsweep_w_1");
    }

    GscBinSkip4(0x6e, var_1, scripts\engine\utility::random(var_7));
  }
}

function stealthidlealert(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);
  addstealthalias(var_2, "idle_alert", var_0);
  var_3 = playphrase(var_1, var_2, self);

  if(stealthdocustombc(var_3)) {
    return;
  }

  if(var_3 && isDefined(var_2.checkin) && var_1 scripts\anim\battlechatter_ai::getbcstate() == "alert") {
    foreach(var_5 in var_2.responsealiases) {
      var_2.soundaliases = [];
      var_2.soundaliases[0] = var_5;

      if(isradioline(var_5)) {
        var_3 = stealthcommander(var_1, var_2.soundaliases[0]);
      } else {
        commander_delay(var_1);
        GscBinSkip4(0x6e, var_1, var_2.soundaliases[0], 1, 1);
      }

      if(!var_3 || var_1 scripts\anim\battlechatter_ai::getbcstate() != "alert") {
        break;
      }
    }

    return;
  }

  if(var_3 && isDefined(var_2.callin)) {
    if(isDefined(var_2.responsealiases[0]) && randomint(4)) {
      GscBinSkip4(0x6e, var_1, var_2.responsealiases[0]);
    }

    return;
  }
}

function stealthradio(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);
  addstealthalias(var_2, "radio", var_0);
  var_3 = playphrase(var_1, var_2, self);

  if(stealthdocustombc(var_3)) {
    return;
  }

  if(var_3) {
    foreach(var_5 in var_2.responsealiases) {
      var_2.soundaliases = [];
      var_2.soundaliases[0] = var_5;

      if(isradioline(var_5)) {
        var_3 = stealthcommander(var_1, var_2.soundaliases[0]);
      } else {
        commander_delay(var_1);
        GscBinSkip4(0x6e, var_1, var_2.soundaliases[0], 1, 1);
      }

      if(!var_3) {
        break;
      }
    }

    return;
  }
}

function stealthcommander(var_0) {
  if(getDvar("bcs_commander_off") == self.team || getDvar("bcs_commander_off") == "all") {
    return false;
  }

  commander_delay();
  GscBinSkip4(0x35, var_0, undefined, 1);
}

function commander_delay() {
  wait randomfloatrange(0.3, 0.4);
}

function stealthcustombc(var_0) {
  wait randomfloatrange(0.3, 0.4);

  if(isradioline(var_0)) {
    thread playradio(var_0);
    return;
  }

  var_1 = spawn("script_origin", self gettagorigin("j_head"));
  var_1 linkTo(self);

  if(battlechatter_canprint()) {
    battlechatter_print([var_0 + " cusBC"]);
  }

  if(soundexists(var_0)) {
    var_1 playSound(var_0, var_0, 1);
    var_1 waittill(var_0);
  } else {
    battlechatter_printwarning("Tried to play an alias that doesn't exist: '" + var_0 + "'.");
  }

  var_1 delete();
}

function stealthdocustombc(var_0) {
  if(isDefined(self.battlechatter.custombc_alias2) && self.battlechatter.custombc_alias2 == "") {
    self.battlechatter.custombc_alias2 = undefined;
    return true;
  } else if(var_0 && isDefined(self.battlechatter.custombc_alias2)) {
    GscBinSkip4(0x35, self.battlechatter.custombc_alias2);
  }

  return false;
}

function stealthinvestigate(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);
  addstealthalias(var_2, "investigate", var_0);
  var_3 = playphrase(var_1, var_2, self);

  if(stealthdocustombc(var_3)) {
    return;
  }

  if(var_3 && (isDefined(var_2.callin) || isDefined(var_2.update))) {
    if(isDefined(var_2.responsealiases[0]) && randomint(4)) {
      GscBinSkip4(0x6e, var_1, var_2.responsealiases[0]);
    }

    return;
  }
}

function stealthhunt(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);
  addstealthalias(var_2, "hunt", var_0);
  var_3 = playphrase(var_1, var_2, self);

  if(stealthdocustombc(var_3)) {
    return;
  }

  if(var_3 && isDefined(var_2.responsealiases[0])) {
    if(randomint(4)) {
      GscBinSkip4(0x6e, var_1, var_2.responsealiases[0]);
    }

    return;
  }
}

function stealthcombat(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);
  addstealthalias(var_2, "combat", var_0);
  playphrase(var_1, var_2, self);
}

function stealthannounce(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("removed from battleChatter");
  var_2 = createchatphrase(var_1);
  addstealthalias(var_2, "announce", var_0);
  var_3 = playphrase(var_1, var_2, self);

  if(var_3 && isDefined(var_2.responsealiases[0])) {
    if(randomint(4)) {
      GscBinSkip4(0x6e, var_1, var_2.responsealiases[0]);
    }

    return;
  }
}

function playphrase(var_0, var_1, var_2) {
  anim endon("battlechatter disabled");
  self endon("dog_attacks_ai");
  self endon("death");
  var_3 = 0;

  if(isDefined(var_2)) {
    return var_3;
  }

  if(battlechatter_canprint() || battlechatter_canprintdump()) {
    if(isfiltered(var_1.curevent.eventaction)) {
      if(battlechatter_canprint()) {
        battlechatter_print([var_1.curevent.eventaction + " is filtered"]);
      }
    } else {
      var_4 = [];

      for(var_5 = 0; var_5 < var_0.soundaliases.size; var_5++) {
        var_6 = "";

        if(isDefined(var_0.soundevents[var_5])) {
          var_6 = " " + var_0.soundevents[var_5];
        }

        var_4 = var_0.soundaliases[var_5] + var_6;
      }

      if(battlechatter_canprint()) {
        battlechatter_print(var_4);
      }

      if(battlechatter_canprintdump()) {
        var_7 = self.curevent.eventaction + "_" + self.curevent.eventtype;

        if(isDefined(self.curevent.modifier)) {
          var_7 += "_" + self.curevent.modifier;
        }

        thread battlechatter_printdump(var_4, var_7);
      }
    }
  }

  for(var_5 = 0; var_5 < var_0.soundaliases.size; var_5++) {
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

    if(isfiltered(var_1.curevent.eventaction)) {
      wait 0.85;
      continue;
    }

    if(!soundexists(var_0.soundaliases[var_5])) {
      battlechatter_printwarning("Tried to play an alias that doesn't exist: '" + var_0.soundaliases[var_5] + "'.");
      continue;
    }

    var_8 = gettime();

    if(self == anim.player) {
      var_9 = spawn("script_origin", anim.player getEye());
      var_9 linkTo(self);
    } else if(isradioline(var_0.soundaliases[var_5])) {
      var_9 = spawn("script_origin", self gettagorigin("J_Hip_RI"));
      var_9 linkTo(var_1);
    } else {
      var_9 = spawn("script_origin", self gettagorigin("j_head"));
      var_9 linkTo(var_1);
    }

    thread stop_speaking(var_0.soundaliases[var_5], var_9);
    set_battlechatter_reaction_alias(var_0.soundaliases[var_5]);

    if(var_0.master && self.team == "allies") {
      thread scripts\sp\anim::anim_facialfiller(var_0.soundaliases[var_5], var_0.bc_looktarget);

      if(isDefined(self.classname) && self.classname == "player") {
        if(!scripts\sp\player::belowcriticalhealththreshold()) {
          var_3 = _playSound(var_9, var_0.soundaliases[var_5]);
        }
      } else {
        var_3 = _playSound(var_9, var_0.soundaliases[var_5]);
      }

      var_9 waittill(var_0.soundaliases[var_5]);
      self notify(var_0.soundaliases[var_5]);
    } else {
      thread scripts\sp\anim::anim_facialfiller(var_0.soundaliases[var_5], var_0.bc_looktarget);

      if(isDefined(self.classname) && self.classname == "player") {
        if(!scripts\sp\player::belowcriticalhealththreshold()) {
          var_3 = _playSound(var_9, var_0.soundaliases[var_5]);
        }
      } else {
        var_3 = _playSound(var_9, var_0.soundaliases[var_5]);
      }

      var_9 waittill(var_0.soundaliases[var_5]);
      self notify(var_0.soundaliases[var_5]);
    }

    var_9 delete();

    if(gettime() < var_8 + 250) {}
  }

  self notify("playPhrase_done");

  if(self != anim.player) {
    self._blackboard.battlechatter_target = undefined;
    self._blackboard.battlechatter_alias = undefined;
  }

  dotypelimit(var_1, var_1.curevent.eventaction, var_1.curevent.eventtype);
  return var_3;
}

function _playSound(var_0, var_1) {
  self notify(var_1 + "_started");
  var_2 = 1;
  var_0 playSound(var_1, var_1, 1);

  if(isDefined(self.team)) {
    anim.lastteamspokentime[self.team] = gettime();
  }

  return var_2;
}

function playradioecho(var_0, var_1, var_2, var_3) {
  anim endon("battlechatter disabled");
  self endon("dog_attacks_ai");
  self endon("death");

  if(getDvar("bcs_radioecho_off") == self.team || getDvar("bcs_radioecho_off") == "all") {
    return;
  }

  if(isDefined(self.battlechatter.customgroup)) {
    var_4 = self.battlechatter.customgroup;
    self.battlechatter.customgroup = undefined;
  } else if(isDefined(scripts\stealth\group::getgroup(self.script_stealthgroup))) {
    var_4 = level.stealth.groupdata.groups[self.script_stealthgroup].members;
  } else {
    var_4 = anim.squads[self.team].members;
  }

  var_4 = scripts\engine\utility::array_remove(var_4, self);

  foreach(var_6 in var_4) {
    if(isDefined(var_6.unittype) && var_6.unittype == "dog") {
      var_4 = scripts\engine\utility::array_remove(var_4, var_6);
    }
  }

  var_4 = scripts\engine\utility::array_removeundefined(var_4);

  if(var_4.size == 0) {
    return;
  }

  var_8 = scripts\engine\sp\utility::get_within_range(level.player.origin, var_4, sqrt(level.bcs_maxstealthdistsqrdfromplayer));

  foreach(var_6 in var_8) {
    thread _playradioecho(var_6, var_2, var_3, self, var_4);
  }
}

function _playradioecho(var_0, var_1, var_2, var_3, var_4) {
  anim endon("battlechatter disabled");
  self endon("dog_attacks_ai");
  self endon("death");
  var_2 endon("death");

  if(!istrue(var_3)) {
    var_5 = var_0 + "_started";
    var_6 = var_2 scripts\engine\utility::waittill_notify_or_timeout_return(var_5, 2);

    if(var_6 == var_5) {
      return;
    }
  }

  wait 0.15;

  if(isDefined(var_4)) {
    var_0 = var_4;
  } else if(isDefined(var_1)) {
    var_7 = strtok(var_0, "_");
    var_0 = "";

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_8 == var_7.size - 1) {
        var_0 = var_0 + "r_" + var_7[var_8];
        continue;
      }

      var_0 = var_0 + var_7[var_8] + "_";
    }
  }

  thread playradio(var_0);
}

function playradio(var_0) {
  if(self == anim.player) {
    var_1 = spawn("script_origin", anim.player getEye());
    var_1 linkTo(self);
  } else {
    var_1 = spawn("script_origin", self gettagorigin("J_Hip_RI"));
    var_1 linkTo(self);
  }

  if(battlechatter_canprint()) {
    battlechatter_print([var_1 + " radio"]);
  }

  if(soundexists(var_1)) {
    var_1 playSound(var_1, var_1, 1);
    var_1 waittill(var_1);
  } else {
    battlechatter_printwarning("Tried to play an alias that doesn't exist: '" + var_1 + "'.");
  }

  var_1 delete();
}

function set_battlechatter_reaction_alias(var_0) {
  var_1 = strtok(var_0, "_");

  if(!isDefined(self._blackboard)) {
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "killfirm") || scripts\engine\utility::array_contains(var_1, "coverme") || scripts\engine\utility::array_contains(var_1, "suppress")) {
    self._blackboard.battlechatter_alias = "action";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "attack") && !scripts\engine\utility::array_contains(var_1, "grenade")) {
    self._blackboard.battlechatter_alias = "attacking_action";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "grenade") || scripts\engine\utility::array_contains(var_1, "inform") && !scripts\engine\utility::array_contains(var_1, "taking")) {
    self._blackboard.battlechatter_alias = "defending_action";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "order")) {
    self._blackboard.battlechatter_alias = "order_action";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "location") || scripts\engine\utility::array_contains(var_1, "contact") || scripts\engine\utility::array_contains(var_1, "target") || scripts\engine\utility::array_contains(var_1, "exposed") && !scripts\engine\utility::array_contains(var_1, "acquired")) {
    self._blackboard.battlechatter_alias = "threat_infantry";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "taking")) {
    self._blackboard.battlechatter_alias = "takingfire";
    return;
  }

  if(scripts\engine\utility::array_contains(var_1, "response") || scripts\engine\utility::array_contains(var_1, "affirm") || scripts\engine\utility::array_contains(var_1, "acquired")) {
    self._blackboard.battlechatter_alias = "response";
    return;
  }
}

function stop_speaking(var_0, var_1) {
  var_1 endon("death");
  self waittill("death");

  if(isDefined(var_1)) {
    var_1 stopsounds();
    waitframe();

    if(isDefined(var_1)) {
      var_1 notify(var_0);
      var_1 delete();
      return;
    }

    return;
  }
}

function is_friendlyfire_event(var_0) {
  if(!isDefined(var_0.eventaction) || !isDefined(var_0.eventtype)) {
    return false;
  }

  if(var_0.eventaction == "reaction" && var_0.eventtype == "friendlyfire") {
    return true;
  }

  return false;
}

function isspeakingfailsafe(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  wait 25;
  clearisspeaking(var_0);
}

function clearisspeaking(var_0) {
  self.battlechatter.isspeaking = 0;
  self.battlechatter.chatqueue[var_0].expiretime = 0;
  self.battlechatter.chatqueue[var_0].priority = 0;
  self.battlechatter.nextsaytimes[var_0] = gettime() + anim.eventactionminwait[var_0]["self"];
}

function lockaction(var_0, var_1, var_2) {
  anim endon("battlechatter disabled");
  var_3 = var_0.squad;
  var_4 = var_0.team;
  var_0.battlechatter.isspeaking = 1;
  thread isspeakingfailsafe(var_0);
  var_3.ismembersaying[var_1] = 1;
  var_3.numspeakers++;
  anim.isteamspeaking[var_4] = 1;
  anim.isteamsaying[var_4][var_1] = 1;
  var_5 = var_0 scripts\engine\utility::waittill_any_return("death", "done speaking", "cancel speaking");
  var_3.ismembersaying[var_1] = 0;
  var_3.numspeakers--;
  anim.isteamspeaking[var_4] = 0;
  anim.isteamsaying[var_4][var_1] = 0;

  if(var_5 == "cancel speaking") {
    return;
  }

  anim.lastteamspeaktime[var_4] = gettime();

  if(isalive(var_0)) {
    clearisspeaking(var_0, var_1);
  }

  var_3.nextsaytimes[var_1] = gettime() + anim.eventactionminwait[var_1]["squad"];
}

function updatecontact(var_0, var_1) {
  if(!isDefined(self.squadlist[var_0].firstcontact)) {
    self.squadlist[var_0].firstcontact = gettime();
  }

  if(gettime() - self.squadlist[var_0].lastcontact > anim.bcs_lastcontactdelay) {
    var_2 = 0;

    for(var_3 = 0; var_3 < self.members.size; var_3++) {
      if(self.members[var_3] != var_1 && isalive(self.members[var_3].enemy) && isDefined(self.members[var_3].enemy.squad) && self.members[var_3].enemy.squad.squadname == var_0) {
        var_2 = 1;
      }
    }

    if(!var_2) {
      self.squadlist[var_0].firstcontact = gettime();
      self.squadlist[var_0].calledout = 0;
    }
  }

  self.squadlist[var_0].lastcontact = gettime();
}

function cansaycontact(var_0) {
  if(gettime() - self.squad.squadlist[var_0.squad.squadname].firstcontact < 500 || gettime() - self.squad.squadlist[var_0.squad.squadname].lastcontact > anim.bcs_lastcontactdelay) {
    if(battlechatter_canprint()) {
      iprintln("time: " + gettime());
      iprintln("firstContact: " + self.squad.squadlist[var_0.squad.squadname].firstcontact);
      iprintln("lastContact: " + self.squad.squadlist[var_0.squad.squadname].lastcontact);
    }

    return true;
  }

  return false;
}

function cansay(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");
  var_3 = isPlayer(self);

  if(!isDefined(anim.player)) {
    return false;
  }

  if(!isDefined(anim.player.battlechatterallowed) || !anim.player.battlechatterallowed && var_3) {
    return false;
  }

  if(!istrue(self.battlechatterallowed) || !isDefined(self.battlechatter.nextsaytimes)) {
    return false;
  }

  if(var_0 == "stealth") {
    if(distancesquared(anim.player.origin, self.origin) > level.bcs_maxstealthdistsqrdfromplayer) {
      return false;
    }
  } else if(distancesquared(anim.player.origin, self.origin) > level.bcs_maxtalkingdistsqrdfromplayer) {
    return false;
  }

  if(isDefined(var_2) && var_2 >= 1) {
    return true;
  }

  var_4 = gettime();

  if(issentient(self) && self.ignoreall) {
    return false;
  }

  if(isDefined(self.fnisinstealthidlescriptedanim) && self[[self.fnisinstealthidlescriptedanim]]()) {
    return false;
  }

  if(!var_3 && self isinscriptedstate()) {
    return false;
  }

  if(var_4 + anim.eventactionminwait[var_0]["self"] < self.battlechatter.nextsaytimes[var_0]) {
    return false;
  }

  if(var_4 + anim.eventactionminwait[var_0]["squad"] < self.squad.nextsaytimes[var_0]) {
    return false;
  }

  if(isDefined(var_1) && typelimited(var_0, var_1)) {
    return false;
  }

  if(isDefined(var_1)) {
    if(isDefined(self.battlechatter.overrides) && isDefined(self.battlechatter.overrides.eventpriority) && isDefined(self.battlechatter.overrides.eventpriority[var_0]) && isDefined(self.battlechatter.overrides.eventpriority[var_0][var_1])) {
      if(self.battlechatter.overrides.eventpriority[var_0][var_1] < self.battlechatter.minpriority) {
        return false;
      }
    } else if(anim.eventpriority[var_0][var_1] < self.battlechatter.minpriority) {
      return false;
    }
  }

  return true;
}

function gethighestpriorityevent() {
  var_0 = undefined;
  var_1 = -999999999;

  foreach(var_3 in self.battlechatter.chatqueue) {
    if(isvalidevent(var_4)) {
      if(var_3.priority > var_1) {
        var_0 = var_4;
        var_1 = var_3.priority;
      }
    }
  }

  return var_0;
}

function globalchatqueuecheck(var_0) {
  if(!anim.isteamsaying[anim.teams[0]][var_0] && !anim.isteamsaying[anim.teams[1]][var_0] && !anim.isteamsaying[anim.teams[2]][var_0] && !anim.isteamsaying[anim.teams[3]][var_0]) {
    return true;
  }

  return false;
}

function gettargettingai(var_0) {
  var_1 = self.squad;
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.members.size; var_3++) {
    if(isDefined(var_1.members[var_3].enemy) && var_1.members[var_3].enemy == var_0) {
      var_2 = var_1.members[var_3];
    }
  }

  if(!isDefined(var_2[0])) {
    return undefined;
  }

  var_4 = undefined;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(cansay(var_2[var_3], "response")) {
      return var_4;
    }
  }

  return scripts\engine\utility::getclosest(self.origin, var_2);
}

function getqueueevents() {
  var_0 = [];
  var_1 = [];
  var_0 = "custom";
  var_0 = "response";
  var_0 = "order";
  var_0 = "threat";
  var_0 = "inform";
  var_0 = "stealth";

  for(var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    for(var_3 = 1; var_3 <= var_2; var_3++) {
      if(self.battlechatter.chatqueue[var_0[var_3 - 1]].priority < self.battlechatter.chatqueue[var_0[var_3]].priority) {
        var_4 = var_0[var_3 - 1];
        var_0 = var_0[var_3];
        var_0 = var_4;
      }
    }
  }

  var_5 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_6 = geteventstate(var_0[var_2]);

    if(var_6 == " valid" && !var_5) {
      var_5 = 1;
      var_1 = "g " + var_0[var_2] + var_6 + " " + self.battlechatter.chatqueue[var_0[var_2]].priority;
      continue;
    }

    if(var_6 == " valid") {
      var_1 = "y " + var_0[var_2] + var_6 + " " + self.battlechatter.chatqueue[var_0[var_2]].priority;
      continue;
    }

    if(self.battlechatter.chatqueue[var_0[var_2]].expiretime == 0) {
      var_1 = "b " + var_0[var_2] + var_6 + " " + self.battlechatter.chatqueue[var_0[var_2]].priority;
      continue;
    }

    var_1 = "r " + var_0[var_2] + var_6 + " " + self.battlechatter.chatqueue[var_0[var_2]].priority;
  }

  return var_1;
}

function geteventstate(var_0) {
  var_1 = "";

  if(self.squad.ismembersaying[var_0]) {
    var_1 += " playing";
  }

  if(gettime() > self.battlechatter.chatqueue[var_0].expiretime) {
    var_1 += " expired";
  }

  if(gettime() < self.squad.nextsaytimes[var_0]) {
    var_1 += " cantspeak";
  }

  if(var_1 == "") {
    var_1 = " valid";
  }

  return var_1;
}

function isfiltered(var_0) {
  if(getDvar("bcs_filter" + var_0, "off") == "on" || getDvar("bcs_filter" + var_0, "off") == "1") {
    return true;
  }

  switch (var_0) {
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

function isvalidevent(var_0) {
  var_1 = gettime();

  if(!self.squad.ismembersaying[var_0] && !anim.isteamsaying[anim.teams[0]][var_0] && !anim.isteamsaying[anim.teams[1]][var_0] && !anim.isteamsaying[anim.teams[2]][var_0] && !anim.isteamsaying[anim.teams[3]][var_0] && gettime() < self.battlechatter.chatqueue[var_0].expiretime && gettime() > scaledsaytime(self.squad.nextsaytimes[var_0])) {
    if(!typelimited(var_0, self.battlechatter.chatqueue[var_0].eventtype)) {
      return true;
    }
  }

  return false;
}

function typelimited(var_0, var_1) {
  if(!isDefined(anim.eventtypeminwait[var_0][var_1])) {
    return false;
  }

  if(!isDefined(self.squad.nexttypesaytimes[var_0][var_1])) {
    return false;
  }

  if(gettime() > self.squad.nexttypesaytimes[var_0][var_1]) {
    return false;
  }

  return true;
}

function dotypelimit(var_0, var_1) {
  if(!isDefined(anim.eventtypeminwait[var_0][var_1])) {
    return;
  }

  if(isDefined(self.battlechatter.overrides) && isDefined(self.battlechatter.overrides.eventtypeminwait) && isDefined(self.battlechatter.overrides.eventtypeminwait[var_0]) && isDefined(self.battlechatter.overrides.eventtypeminwait[var_0][var_1])) {
    self.squad.nexttypesaytimes[var_0][var_1] = gettime() + self.battlechatter.overrides.eventtypeminwait[var_0][var_1];
    return;
  }

  self.squad.nexttypesaytimes[var_0][var_1] = gettime() + anim.eventtypeminwait[var_0][var_1];
}

function scaledsaytime(var_0) {
  if(!isDefined(self.battlechatter_saytimescaled)) {
    return var_0;
  }

  var_1 = var_0 - gettime();

  if(var_1 <= 0) {
    return var_0;
  } else {
    var_1 -= var_1 * self.battlechatter_saytimescaled;
    var_1 += gettime();
  }

  return var_1;
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

function isexposed(var_0) {
  if(distancesquared(self.origin, anim.player.origin) > 2250000) {
    return false;
  }

  if(isDefined(var_0) && var_0 && isDefined(getlocation())) {
    return false;
  }

  var_1 = bcgetclaimednode();

  if(!isDefined(var_1)) {
    return true;
  }

  if(!isnodecoverorconceal()) {
    return false;
  }

  return true;
}

function isnodecoverorconceal() {
  var_0 = self.node;

  if(!isDefined(var_0)) {
    return false;
  }

  if(issubstr(var_0.type, "Cover") || issubstr(var_0.type, "Conceal")) {
    return true;
  }

  return false;
}

function squadhasofficer(var_0) {
  if(var_0.officercount > 0) {
    return 1;
  }

  return 0;
}

function isofficer() {
  var_0 = getrank();

  if(!isDefined(var_0)) {
    return false;
  }

  if(var_0 == "sergeant" || var_0 == "lieutenant" || var_0 == "captain" || var_0 == "sergeant") {
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
    var_0 = self.ainame;
  } else if(self.team == "allies") {
    var_0 = self.name;
  } else {
    var_0 = undefined;
  }

  if(!isDefined(var_0)) {
    return undefined;
  }

  var_1 = strtok(var_0, " ");

  if(var_1.size < 2) {
    return var_0;
  }

  return var_1[1];
}

function getrank() {
  return self.airank;
}

function getcallsign() {
  return self.callsign;
}

function getclosestfriendlyspeaker(var_0) {
  var_1 = getspeakers(var_0, self.team);
  var_2 = scripts\engine\utility::getclosest(self.origin, var_1);
  return var_2;
}

function getspeakers(var_0, var_1) {
  var_2 = [];
  var_3 = getaiarray(var_1);

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_3[var_4] == self) {
      continue;
    }

    if(!cansay(var_3[var_4], var_0)) {
      continue;
    }

    var_2 = var_3[var_4];
  }

  return var_2;
}

function getresponder(var_0, var_1, var_2) {
  var_3 = undefined;

  if(!isDefined(var_2)) {
    var_2 = "response";
  }

  var_0 *= var_0;
  var_1 *= var_1;
  var_4 = [];
  var_5 = self.squad.members.size;

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = self.squad.members[var_6];

    if(var_7 == self) {
      continue;
    }

    if(!isalive(var_7)) {
      continue;
    }

    var_8 = distancesquared(self.origin, var_7.origin);

    if(var_8 < var_0) {
      continue;
    }

    if(var_8 > var_1) {
      continue;
    }

    if(isusingsamevoice(var_7)) {
      continue;
    }

    var_4 = var_7;
  }

  var_9 = scripts\engine\utility::array_randomize(var_4);
  var_5 = var_9.size;

  for(var_6 = 0; var_6 < var_5; var_6++) {
    var_7 = var_9[var_6];

    if(!cansay(var_7, var_2)) {
      continue;
    }

    var_3 = var_7;

    if(cansayname(var_3)) {
      break;
    }
  }

  return var_3;
}

function getlocation() {
  var_0 = get_all_my_locations();
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = undefined;

  if(var_0.size) {
    var_1 = _getlocation(var_0);
  }

  return var_1;
}

function getvalidlocation(var_0, var_1, var_2) {
  var_3 = get_all_my_locations();
  var_3 = scripts\engine\utility::array_randomize(var_3);
  var_4 = undefined;

  if(var_3.size) {
    foreach(var_4 in var_3) {
      if(!cancalloutlocation(var_0, var_4, var_1, var_2)) {
        var_3 = scripts\engine\utility::array_remove(var_3, var_4);
      }
    }

    var_4 = _getlocation(var_3, var_1);
  }

  return var_4;
}

function _getlocation(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3.islandmark) && !location_called_out_ever(var_3)) {
      return var_3;
    }

    if(!location_called_out_ever(var_3) && scripts\engine\utility::cointoss()) {
      return var_3;
    }

    if(!location_called_out_recently(var_3, var_1) && isDefined(var_3.islandmark) && randomint(5) == 0) {
      return var_3;
    }

    if(!location_called_out_recently(var_3, var_1)) {
      return var_3;
    }
  }

  return undefined;
}

function get_all_my_locations() {
  var_0 = anim.bcs_locations;
  var_1 = self getistouchingentities(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4.locationaliases)) {
      if(isDefined(var_4.islandmark) && anim.player istouching(var_4)) {
        continue;
      }

      var_2 = var_4;
    }
  }

  return var_2;
}

function update_bcs_locations() {
  if(isDefined(anim.bcs_locations)) {
    anim.bcs_locations = scripts\engine\utility::array_removeundefined(anim.bcs_locations);
    return;
  }
}

function is_in_callable_location() {
  var_0 = get_all_my_locations();

  foreach(var_2 in var_0) {
    if(!location_called_out_recently(var_2)) {
      return true;
    }
  }

  return false;
}

function location_called_out_ever(var_0) {
  var_1 = location_get_last_callout_time(var_0);

  if(!isDefined(var_1)) {
    return false;
  }

  return true;
}

function location_called_out_recently(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = location_get_last_callout_time(var_0);

  if(!isDefined(var_2)) {
    return false;
  }

  if(var_1 == "stealth") {
    var_3 = var_2 + anim.eventactionminwait["stealth"]["location_repeat"];
  } else {
    var_3 += anim.eventactionminwait["threat"]["location_repeat"];
  }

  if(gettime() < var_3) {
    return true;
  }

  return false;
}

function location_add_last_callout_time(var_0) {
  anim.locationlastcallouttimes[var_0.classname] = gettime();
}

function location_get_last_callout_time(var_0) {
  if(isDefined(anim.locationlastcallouttimes[var_0.classname])) {
    return anim.locationlastcallouttimes[var_0.classname];
  }

  return undefined;
}

function getrelativeangles(var_0) {
  var_1 = var_0.angles;

  if(!isPlayer(var_0)) {
    var_2 = bcgetclaimednode(var_0);

    if(isDefined(var_2)) {
      var_1 = var_2.angles;
    }
  }

  return var_1;
}

function sideisleftright(var_0) {
  if(var_0 == "left" || var_0 == "right") {
    return true;
  }

  return false;
}

function getdirectionfacingflank(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2);
  var_4 = vectortoangles(var_1 - var_0);
  var_5 = var_3[1] - var_4[1];
  var_5 += 360;
  var_5 = int(var_5) % 360;

  if(var_5 > 315 || var_5 < 45) {
    var_6 = "front";
  } else if(var_6 < 135) {
    var_6 = "right";
  } else if(var_6 < 225) {
    var_6 = "rear";
  } else {
    var_6 = "left";
  }

  return var_6;
}

function normalizecompassdirection(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "north":
      var_1 = "n";
      break;
    case "northwest":
      var_1 = "nw";
      break;
    case "west":
      var_1 = "w";
      break;
    case "southwest":
      var_1 = "sw";
      break;
    case "south":
      var_1 = "s";
      break;
    case "southeast":
      var_1 = "se";
      break;
    case "east":
      var_1 = "e";
      break;
    case "northeast":
      var_1 = "ne";
      break;
    case "impossible":
      var_1 = "impossible";
      break;
    default:
      return;
  }

  return var_1;
}

function getdirectioncompass(var_0, var_1) {
  var_2 = vectortoangles(var_1 - var_0);
  var_3 = var_2[1];
  var_4 = getnorthyaw();
  var_3 -= var_4;

  if(var_3 < 0) {
    var_3 += 360;
  } else if(var_3 > 360) {
    var_3 -= 360;
  }

  if(var_3 < 22.5 || var_3 > 337.5) {
    var_5 = "north";
  } else if(var_4 < 67.5) {
    var_5 = "northwest";
  } else if(var_5 < 112.5) {
    var_5 = "west";
  } else if(var_5 < 157.5) {
    var_5 = "southwest";
  } else if(var_5 < 202.5) {
    var_5 = "south";
  } else if(var_5 < 247.5) {
    var_5 = "southeast";
  } else if(var_5 < 292.5) {
    var_5 = "east";
  } else if(var_5 < 337.5) {
    var_5 = "northeast";
  } else {
    var_5 = "impossible";
  }

  return var_5;
}

function getdistancemeters(var_0, var_1) {
  var_2 = distance2d(var_0, var_1);
  var_3 = 0.0254 * var_2;
  return var_3;
}

function getdistancemetersnormalized(var_0, var_1) {
  var_2 = getdistancemeters(var_0, var_1);

  if(var_2 < 15) {
    return "10";
  }

  if(var_2 < 25) {
    return "20";
  }

  if(var_2 < 35) {
    return "30";
  }

  if(var_2 < 45) {
    return "40";
  }

  if(var_2 < 55) {
    return "50";
  }

  if(var_2 < 65) {
    return "60";
  }

  if(var_2 < 75) {
    return "70";
  }

  if(var_2 < 85) {
    return "80";
  }

  if(var_2 < 95) {
    return "90";
  }

  if(var_2 < 125) {
    return "100";
  }

  return undefined;
}

function getdistancemiles(var_0, var_1) {
  var_2 = distance2d(var_0, var_1);
  var_3 = 1.57828e-05 * var_2;
  return var_3;
}

function getdistancemilesnormalized(var_0, var_1) {
  var_2 = getdistancemiles(var_0, var_1);

  if(var_2 < 5) {
    return "4";
  }

  if(var_2 < 6) {
    return "5";
  }

  if(var_2 < 7) {
    return "6";
  }

  if(var_2 < 15) {
    return "10";
  }

  return "15";
}

function getfrontarcclockdirection(var_0) {
  var_1 = "undefined";

  if(var_0 == "10" || var_0 == "11") {
    var_1 = "10";
  } else if(var_0 == "12") {
    var_1 = var_0;
  } else if(var_0 == "1" || var_0 == "2") {
    var_1 = "2";
  }

  return var_1;
}

function getdirectionfacingclock(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0);
  var_4 = vectorNormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = vectortoangles(var_2 - var_1);
  var_7 = var_5[1] - var_6[1];
  var_7 += 360;
  var_7 = int(var_7) % 360;

  if(var_7 > 345 || var_7 < 15) {
    var_8 = "12";
  } else if(var_8 < 45) {
    var_8 = "1";
  } else if(var_8 < 75) {
    var_8 = "2";
  } else if(var_8 < 105) {
    var_8 = "3";
  } else if(var_8 < 135) {
    var_8 = "4";
  } else if(var_8 < 165) {
    var_8 = "5";
  } else if(var_8 < 195) {
    var_8 = "6";
  } else if(var_8 < 225) {
    var_8 = "7";
  } else if(var_8 < 255) {
    var_8 = "8";
  } else if(var_8 < 285) {
    var_8 = "9";
  } else if(var_8 < 315) {
    var_8 = "10";
  } else {
    var_8 = "11";
  }

  return var_8;
}

function getdegreeselevation(var_0, var_1) {
  var_2 = var_1[2] - var_0[2];
  var_3 = distance2d(var_0, var_1);
  var_4 = atan(var_2 / var_3);

  if(var_4 < 15 || var_4 > 65) {
    return var_4;
  }

  if(var_4 < 25) {
    return 20;
  }

  if(var_4 < 35) {
    return 30;
  }

  if(var_4 < 45) {
    return 40;
  }

  if(var_4 < 55) {
    return 50;
  }

  if(var_4 < 65) {
    return 60;
  }
}

function getvectorrightangle(var_0) {
  return (var_0[1], 0 - var_0[0], var_0[2]);
}

function getvectorarrayaverage(var_0) {
  var_1 = (0, 0, 0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 += var_0[var_2];
  }

  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

function addconcattargetalias(var_0) {
  var_1 = "";
  var_2 = undefined;

  if(var_0 scripts\anim\utility_common::usingrocketlauncher()) {
    var_1 = "_rpg";
  }

  if(bcissniper(var_0)) {
    var_1 = "_sniper";
  }

  var_2 = getbattlechatteralias(self.owner, "concat_target") + var_1;
  self.soundaliases[self.soundaliases.size] = var_2;
}

function addconcatdirectionalias() {
  var_2 = undefined;
  var_3 = "undefined";
  var_4 = scripts\engine\utility::random(["relative", "absolute"]);

  switch (var_4) {
    case "absolute":
      var_5 = getdirectioncompass(anim.player.origin, var_1.origin);
      var_6 = normalizecompassdirection(var_5);

      if(var_6 != "impossible" && var_6.size != 2) {
        var_2 = getbattlechatteralias(self.owner, "concat_compass") + var_6;
        break;
      }

      var_1 = "absolute";
    case "relative":
      var_7 = getrelativeangles( < error > );
      var_8 = getdirectionfacingclock(var_7, < error > .origin, < error > .origin);
      var_9 = int(var_8);

      if(scripts\engine\utility::cointoss()) {
        if(var_9 >= 2 && var_9 < 5) {
          var_0 = getbattlechatteralias(self.owner, "concat_right");
          break;
        } else if(var_2 >= 8 && var_2 < 11) {
          <
          error > = getbattlechatteralias(self.owner, "concat_left");
          break;
        }
      } else if(randomint(3) == 1) {
        var_10 = getdistancemetersnormalized( < error > .origin, < error > .origin);

        if(isDefined(var_10)) {
          <
          error > = getbattlechatteralias(self.owner, "concat_dist") + var_10;
        }

        break;
      } else if(randomint(3) == 1) {
        var_11 = getdegreeselevation(anim.player.origin, < error > .origin);

        if(var_11 >= 20 && var_11 <= 60) {
          <
          error > = getbattlechatteralias(self.owner, "concat_elev") + var_11;
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

function addnamealias(var_0) {
  if(self.owner == anim.player) {} else {
    self.soundaliases[self.soundaliases.size] = bc_prefix(self.owner) + "name_" + var_0;
  }

  anim.lastnamesaid[self.owner.team] = var_0;
  anim.lastnamesaidtime[self.owner.team] = gettime();
}

function addplayernamealias() {
  if(!cansayplayername(self.owner)) {
    return;
  }

  anim.lastplayernamecalltime = gettime();
  var_0 = bc_prefix(self.owner) + "name_player_" + anim.player.bccountryid + "_" + anim.player.bcnameid;
  self.soundaliases[self.soundaliases.size] = var_0;
  self.bc_looktarget = anim.player;
}

function addrankalias(var_0) {
  self.soundaliases[self.soundaliases.size] = bc_prefix(self.owner) + "rank_" + var_0;
}

function cansayname(var_0) {
  if(enemy_team_name()) {
    return false;
  }

  if(!isDefined(var_0.bcname)) {
    return false;
  }

  if(var_0.battlechatterallowed == 0) {
    return false;
  }

  if(!isDefined(var_0.battlechatter.countryid)) {
    return false;
  }

  if(!isDefined(self.battlechatter.countryid)) {
    return false;
  }

  if(self.battlechatter.countryid != var_0.battlechatter.countryid) {
    return false;
  }

  if(namesaidrecently(var_0)) {
    return false;
  }

  var_1 = undefined;

  if(isPlayer(self)) {
    var_1 = "UN_plr_name_" + var_0.bcname;
  } else {
    var_1 = bc_prefix() + "name_" + var_0.bcname;
  }

  if(soundexists(var_1)) {
    return true;
  }

  return false;
}

function namesaidrecently(var_0) {
  if(anim.lastnamesaid[self.team] == var_0.bcname || gettime() - anim.lastnamesaidtime[self.team] < anim.lastnamesaidtimeout) {
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

  var_0 = bc_prefix() + "name_player_" + anim.player.bccountryid + "_" + anim.player.bcnameid;

  if(soundexists(var_0)) {
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

function isusingsamevoice(var_0) {
  if(isstring(self.battlechatter.npcid) == isstring(var_0.battlechatter.npcid) && self.battlechatter.npcid == var_0.battlechatter.npcid) {
    return 1;
  }

  return 0;
}

function addthreatalias(var_0, var_1) {
  var_2 = getbattlechatteralias(self.owner, "threat_" + var_0);

  if(isDefined(var_1) && var_1 != "generic") {
    var_2 += "_" + var_1;
  }

  self.soundaliases = scripts\engine\utility::array_add(self.soundaliases, var_2);
  return true;
}

function addthreatexposedalias(var_0) {
  if(var_0 == "group") {
    var_0 = "movement_group";
  }

  var_1 = getbattlechatteralias(self.owner, "exposed_" + var_0);
  self.soundaliases[self.soundaliases.size] = var_1;
  return true;
}

function addthreatcalloutecho(var_0, var_1) {
  var_2 = createechoalias(var_0, var_1);

  if(!soundexists(var_2)) {
    battlechatter_printwarning("Can't find echo alias '" + var_2 + "'.");
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var_2;
  return true;
}

function addthreatcalloutresponsealias(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0)) {
    var_0 = "";
  } else {
    var_0 = "_" + var_0;
  }

  var_2 = getbattlechatteralias(self.owner, "response_threat" + var_0);

  if(!soundexists(var_2)) {
    battlechatter_printwarning("Can't find callout response alias '" + var_2 + "'.");
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var_2;
  return true;
}

function addthreatcalloutqa_nextline(var_0, var_1, var_2) {
  var_3 = undefined;

  foreach(var_5 in var_2.locationaliases) {
    if(issubstr(var_1, var_5)) {
      var_3 = var_5;
      break;
    }
  }

  var_7 = bc_prefix(self.owner) + "";
  var_8 = getsubstr(var_1, var_1.size - 1, var_1.size);
  var_9 = int(var_8) + 1;
  var_10 = var_7 + scripts\anim\battlechatter_ai::getbcstate() + "_location_" + var_3 + "_qa" + var_9;

  if(!soundexists(var_10)) {
    if(randomint(100) < anim.eventchance["response"]["callout_negative"]) {
      var_0 scripts\anim\battlechatter_ai::addresponseevent("callout", "neg", self.owner, 0.9);
    } else {
      var_0 scripts\anim\battlechatter_ai::addresponseevent("exposed", "acquired", self.owner, 0.9);
    }

    var_2.qafinished = 1;
    return false;
  }

  var_0 scripts\anim\battlechatter_ai::addresponseevent("callout", "QA", self.owner, 0.9, var_10, var_2);
  self.soundaliases[self.soundaliases.size] = var_10;
  return true;
}

function createechoalias(var_0, var_1) {
  var_2 = "_report";
  var_3 = "_echo";
  var_4 = undefined;

  if(var_1 == anim.player) {
    var_5 = "plr";
  } else {
    var_5 = var_2.battlechatter.npcid;
  }

  if(self.owner == anim.player) {
    var_5 = self.owner.battlechatter.countryid + "_plr_";
  } else {
    var_5 = bc_prefix(self.owner) + "";
  }

  var_6 = var_1.size - var_3.size;

  if(self.owner == anim.player) {
    var_7 = self.owner.battlechatter.countryid + "_plr_";
    var_8 = var_7.size;
  } else {
    var_7 = self.owner.battlechatter.countryid + "_" + var_7 + "_";
    var_8 = var_7.size;
  }

  var_9 = getsubstr(var_3, var_8, var_8);
  var_10 = var_6 + var_9 + var_5;
  return var_10;
}

function addthreatcalloutalias(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_3 = undefined;

  if(self.owner == anim.player) {
    if(var_0 == "acquired" || var_0 == "sighted") {
      var_3 = self.owner.battlechatter.countryid + "_plr_target_" + var_0;
    } else {
      var_3 = self.owner.battlechatter.countryid + "_plr_callout_" + var_0 + var_1;
    }
  } else if(istrue(var_2)) {
    if(cansaycontact(self.owner, self.threatent)) {
      var_3 = getbattlechatteralias(self.owner, "threat_callout_contact" + var_0) + var_1;
    } else {
      var_3 = getbattlechatteralias(self.owner, "threat_callout_target" + var_0) + var_1;
    }
  } else {
    var_3 = getbattlechatteralias(self.owner, "threat_callout_" + var_0) + var_1;
  }

  self.soundaliases[self.soundaliases.size] = var_3;

  if(soundexists(var_3)) {
    return 1;
  }

  return 0;
}

function addthreatcalloutlandmarkalias(var_0, var_1, var_2) {
  var_3 = var_0.script_landmark;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = bc_prefix(self.owner) + "callout_obj_" + var_3;

  if(var_2) {
    var_4 += "_y";
  }

  var_4 += "_" + var_1;

  if(!soundexists(var_4)) {
    battlechatter_printwarning("Can't find sound alias '" + var_4 + "'. Does landmark '" + var_3 + "' have callout references in the battlechatter csv for nationality '" + self.owner.battlechatter.countryid + "'?");
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var_4;
  return true;
}

function addthreatcalloutlocationalias(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = var_0.locationaliases;
  var_5 = var_4[0];

  if(var_4.size > 1) {
    var_6 = undefined;
    var_6 = getcannedresponse(var_0, var_2);

    if(isDefined(var_6)) {
      var_5 = var_6;
    } else {
      var_5 = scripts\engine\utility::random(var_4);
    }
  }

  var_7 = undefined;

  if(isDefined(var_1) && var_1) {
    var_7 = getloccalloutalias(self.owner, scripts\anim\battlechatter_ai::getbcstate() + "_location_concat_" + var_5);
  } else if(!isDefined(var_0.qafinished) && iscallouttypeqa(var_5, self.owner)) {
    var_7 = getqacalloutalias(self.owner, var_5, 0);
  } else {
    var_7 = getloccalloutalias(self.owner, scripts\anim\battlechatter_ai::getbcstate() + "_location_callout_" + var_5);
  }

  if(soundexists(var_7)) {
    var_3 = var_7;
  }

  if(!isDefined(var_3)) {
    return false;
  }

  location_add_last_callout_time(var_0);
  self.soundaliases[self.soundaliases.size] = var_3;
  return true;
}

function addlocationresponsealias(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_0)) {
    var_0 = "";
  } else {
    var_0 = "_" + var_0;
  }

  var_2 = getbattlechatteralias(self.owner, "location_response") + var_0;

  if(!soundexists(var_2)) {
    battlechatter_printwarning("Can't find location response alias '" + var_2 + "'.");
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var_2;
  return true;
}

function addvehiclealias(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_0 = "vehicle_" + var_0;
  var_2 = getbattlechatteralias(self.owner, var_0 + var_1);
  self.soundaliases[self.soundaliases.size] = var_2;
}

function addinformalias(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  if(!isDefined(var_2)) {
    var_2 = "";
  } else {
    var_2 = "_" + var_2;
  }

  if(!issubstr(var_1, "weapon")) {
    var_0 = "inform_" + var_0;
  } else {
    var_0 = "";
  }

  var_3 = getbattlechatteralias(self.owner, var_0 + var_1 + var_2);
  self.soundaliases[self.soundaliases.size] = var_3;
}

function addresponsealias(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_2 = getbattlechatteralias(self.owner, "response_" + var_0 + var_1);
  self.soundaliases[self.soundaliases.size] = var_2;
  return true;
}

function addreactionalias(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_2 = getbattlechatteralias(self.owner, "reaction_" + var_0 + var_1);
  self.soundaliases[self.soundaliases.size] = var_2;
  return true;
}

function addcheckfirealias() {
  var_0 = getbattlechatteralias(self.owner, "check_fire");
  self.soundaliases[self.soundaliases.size] = var_0;
  return true;
}

function addtakingfirealias() {
  var_0 = getbattlechatteralias(self.owner, "inform_taking_fire");
  self.soundaliases[self.soundaliases.size] = var_0;
  return true;
}

function addtauntalias(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_2 = getbattlechatteralias(self.owner, "taunt");
  self.soundaliases[self.soundaliases.size] = var_2;
  return true;
}

function addhostileburstalias() {
  var_0 = getbattlechatteralias(self.owner, "reaction_hostile_burst");

  if(soundexists(var_0)) {
    self.soundaliases[self.soundaliases.size] = var_0;
  }

  return true;
}

function addorderalias(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_2 = getbattlechatteralias(self.owner, "order" + var_1);

  if(!isDefined(var_2)) {
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var_2;
  return true;
}

function addstealthalias(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(self.owner == anim.player) {} else {
    switch (var_0) {
      case "idle_alert":
      case "idle":
        self.owner.battlechatter.investigatecallin = 0;

        if(usecustombc(var_0)) {
          var_2 = addcustombcstealthalias(self.owner, var_0);
        } else {
          var_1 = "callin";

          if(scripts\engine\utility::cointoss()) {
            var_1 = "checkin";
          }

          var_4 = scripts\anim\battlechatter_table::bctable_pickaliasset("stealth", var_0, var_1);

          if(!isDefined(var_4)) {
            return false;
          }

          if(uselocationbc(self.owner, var_1)) {
            var_5 = getstealthlocationalias(self.owner, var_1);
            var_2 = var_5[0];
            var_3 = scripts\engine\utility::array_remove_index(var_5, 0);
          } else if(var_1 == "checkin") {
            var_2 = bc_prefix(self.owner, "stealth", 1) + var_4[0];

            if(isDefined(var_4[1]) && var_4[1] != "") {
              thread playradioecho(self.owner);
            }

            if(isDefined(var_4[2]) && var_4[2] != "") {
              var_3 = bc_prefix(self.owner, "stealth") + var_4[2];
            }

            if(isDefined(var_4[3]) && var_4[3] != "") {
              var_3 = bc_prefix(self.owner, "stealth", 1) + var_4[3];
            }

            self.checkin = 1;
          } else {
            var_2 = bc_prefix(self.owner, "stealth") + var_4[0];

            if(isDefined(var_4[1]) && var_4[1] != "") {
              thread playradioecho(self.owner);
            }

            if(isDefined(var_4[2]) && var_4[2] != "") {
              var_3 = bc_prefix(self.owner, "stealth", 1) + var_4[2];
            }

            self.callin = 1;
          }
        }

        break;
      case "radio":
        var_4 = scripts\anim\battlechatter_table::bctable_pickaliasset("stealth", var_0, var_1);

        if(!isDefined(var_4)) {
          return false;
        }

        var_2 = bc_prefix(self.owner, "stealth") + var_4[0];

        for(var_6 = 1; var_6 < var_4.size; var_6++) {
          if(!isDefined(var_3)) {
            var_3 = [];
          }

          var_3 = bc_prefix(self.owner, "stealth") + var_4[var_6];
        }

        break;
      case "investigate":
        if(usecustombc(var_0)) {
          var_2 = addcustombcstealthalias(self.owner, var_0);
        } else {
          var_1 = "update";

          if(!istrue(self.owner.battlechatter.investigatecallin)) {
            var_7 = "callin";
            self.callin = 1;
            self.owner.battlechatter.investigatecallin = 1;
          } else {
            self.update = 1;
          }

          var_4 = scripts\anim\battlechatter_table::bctable_pickaliasset("stealth", var_0, var_1);

          if(!isDefined(var_4)) {
            return false;
          }

          if(uselocationbc(self.owner, var_1)) {
            var_5 = getstealthlocationalias(self.owner, var_1);
            var_2 = var_5[0];
            var_3 = scripts\engine\utility::array_remove_index(var_5, 0);
          } else {
            var_2 = bc_prefix(self.owner, "stealth") + var_4[0];

            if(isDefined(var_4[1]) && var_4[1] != "") {
              thread playradioecho(self.owner);
            }

            if(isDefined(var_4[2]) && var_4[2] != "") {
              var_3 = bc_prefix(self.owner, "stealth", 1) + var_4[2];
            }
          }
        }

        break;
      case "announce":
      case "hunt":
        var_4 = scripts\anim\battlechatter_table::bctable_pickaliasset("stealth", var_0, var_1);

        if(!isDefined(var_4)) {
          return false;
        }

        if(var_0 == "hunt") {
          self.owner.battlechatter.investigatecallin = 0;
        }

        if(usecustombc(var_0)) {
          var_2 = addcustombcstealthalias(self.owner, var_0);
        } else {
          var_2 = bc_prefix(self.owner, "stealth") + var_4[0];

          if(isDefined(var_4[1]) && var_4[1] != "") {
            thread playradioecho(self.owner);
          }

          if(isDefined(var_4[2]) && var_4[2] != "") {
            var_3 = bc_prefix(self.owner, "stealth", 1) + var_4[2];
          }
        }

        break;
      case "combat":
        break;
    }
  }

  if(!isDefined(var_2)) {
    return false;
  }

  self.soundevents[self.soundaliases.size] = var_0;

  if(isDefined(var_1)) {
    self.soundevents[self.soundaliases.size] = var_0 + " " + var_1;
  }

  self.soundaliases[self.soundaliases.size] = var_2;

  if(isDefined(var_3)) {
    self.responsealiases = var_3;
  }

  return true;
}

function addcustombcstealthalias(var_0) {
  if(tolower(self.battlechatter.countryid + self.battlechatter.npcid) == "aq4") {
    return undefined;
  }

  var_1 = getcustombc(var_0);
  self.battlechatter.custombc_alias2 = "";

  if(isarray(var_1)) {
    self.battlechatter.custombc_alias2 = var_1[1];
    var_1 = var_1[0];
  }

  if(isradioline(var_1)) {} else {
    var_2 = "";
    var_3 = strtok(var_1, "_");

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_4 == var_3.size - 1) {
        var_2 = var_2 + "r_" + var_3[var_4];
        continue;
      }

      var_2 = var_2 + var_3[var_4] + "_";
    }

    if(soundexists(var_2)) {} else {
      battlechatter_printwarning("Can't find radio alias '" + var_2 + "'.This may be intentional if talking to himself.");
    }
  }

  return var_1;
}

function try_cardinal_patrol_update() {
  var_0 = getdirectioncompass(self.origin, (0, 0, 0));

  if(isDefined(var_0) && var_0 == "impossible") {
    return undefined;
  }

  var_1 = randomintrange_otn(1);

  switch (var_0) {
    case "north":
      var_2 = "areasecure_n" + var_1;
      break;
    case "northwest":
      var_2 = "areasecure_w" + var_2;

      if(scripts\engine\utility::cointoss()) {
        var_2 = "areasecure_n" + var_2;
      }

      break;
    case "northeast":
      var_2 = "areasecure_e" + var_2;

      if(scripts\engine\utility::cointoss()) {
        var_2 = "areasecure_n" + var_2;
      }

      break;
    case "south":
      var_2 = "areasecure_s" + var_2;
      break;
    case "southwest":
      var_2 = "areasecure_w" + var_2;

      if(scripts\engine\utility::cointoss()) {
        var_2 = "areasecure_s" + var_2;
      }

      break;
    case "southeast":
      var_2 = "areasecure_e" + var_2;

      if(scripts\engine\utility::cointoss()) {
        var_2 = "areasecure_s" + var_2;
      }

      break;
    case "east":
      var_2 = "areasecure_e" + var_2;
      break;
    case "west":
      var_2 = "areasecure_w" + var_2;
      break;
    default:
      iprintln("No cardinal direction returned");
      var_2 = undefined;
      break;
  }

  return var_2;
}

function try_cardinal_gunshot(var_0) {
  var_1 = getdirectioncompass(self.origin, var_0);

  if(isDefined(var_1) && var_1 == "impossible") {
    return;
  }

  var_2 = randomintrange_otn(1);

  switch (var_1) {
    case "north":
      var_3 = "gunshot_n_" + var_2;
      break;
    case "northwest":
      var_3 = "gunshot_w_" + var_3;

      if(scripts\engine\utility::cointoss()) {
        var_3 = "gunshot_n_" + var_3;
      }

      break;
    case "northeast":
      var_3 = "gunshot_e_" + var_3;

      if(scripts\engine\utility::cointoss()) {
        var_3 = "gunshot_n_" + var_3;
      }

      break;
    case "south":
      var_3 = "gunshot_s_" + var_3;
      break;
    case "southwest":
      var_3 = "gunshot_w_" + var_3;

      if(scripts\engine\utility::cointoss()) {
        var_3 = "gunshot_s_" + var_3;
      }

      break;
    case "southeast":
      var_3 = "gunshot_e_" + var_3;

      if(scripts\engine\utility::cointoss()) {
        var_3 = "gunshot_s_" + var_3;
      }

      break;
    case "east":
      var_3 = "gunshot_e_" + var_3;
      break;
    case "west":
      var_3 = "gunshot_w_" + var_3;
      break;
    default:
      iprintln("No cardinal direction returned");
      var_3 = undefined;
      break;
  }

  return var_3;
}

function randomintrange_otn(var_0, var_1) {
  if(getDvar("bcs_otnStealth") != "off") {
    return "10";
  }

  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      return (randomintrange(var_0, var_1) * 10);
    }

    return "10";
  }
}

function initcontact(var_0) {
  if(!isDefined(self.squadlist[var_0].calledout)) {
    self.squadlist[var_0].calledout = 0;
  }

  if(!isDefined(self.squadlist[var_0].firstcontact)) {
    self.squadlist[var_0].firstcontact = undefined;
  }

  if(!isDefined(self.squadlist[var_0].lastcontact)) {
    self.squadlist[var_0].lastcontact = 0;
    return;
  }
}

function shutdowncontact(var_0) {
  self.squadlist[var_0].calledout = undefined;
  self.squadlist[var_0].firstcontact = undefined;
  self.squadlist[var_0].lastcontact = undefined;
}

function createchatevent(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.owner = self;
  var_3.eventtype = var_1;
  var_3.eventaction = var_0;

  if(isDefined(var_2)) {
    var_3.priority = var_2;
  } else {
    var_3.priority = anim.eventpriority[var_0][var_1];
  }

  if(isDefined(self.battlechatter.overrides) && isDefined(self.battlechatter.overrides.eventduration) && isDefined(self.battlechatter.overrides.eventduration[var_0]) && isDefined(self.battlechatter.overrides.eventduration[var_0][var_1])) {
    var_3.expiretime = gettime() + self.battlechatter.overrides.eventduration[var_0][var_1];
  } else {
    var_3.expiretime = gettime() + anim.eventduration[var_0][var_1];
  }

  return var_3;
}

function createchatphrase() {
  var_0 = spawnStruct();
  var_0.owner = self;
  var_0.soundevents = [];
  var_0.soundaliases = [];
  var_0.responsealiases = [];
  var_0.master = 0;
  return var_0;
}

function pointinfov(var_0) {
  return scripts\engine\utility::within_fov(self.origin, self.angles, var_0, 0.766);
}

function entinfrontarc(var_0) {
  return scripts\engine\utility::within_fov(self.origin, self.angles, var_0.origin, 0);
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
  var_0 = 0;

  while(isDefined(self)) {
    if(!squadcanburst(self)) {
      var_0 = 1;
      wait 1;
      continue;
    } else if(self.fbt_firstburst) {
      if(!var_0) {
        wait randomfloat(anim.fbt_waitmin);
      }

      if(var_0) {
        var_0 = 0;
      }

      self.fbt_firstburst = 0;
    } else {
      if(!var_0) {
        wait randomfloatrange(anim.fbt_waitmin, anim.fbt_waitmax);
      }

      if(var_0) {
        var_0 = 0;
      }
    }

    var_1 = getburster(self);

    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = var_1.voice;
    var_3 = getflavorburstid(self, var_2);
    var_4 = getflavorburstaliases(var_2, var_3);

    foreach(var_6 in var_4) {
      if(!candoflavorburst(var_1) || distance(anim.player.origin, var_1.origin) > anim.fbt_desireddistmax && !isDefined(var_1.bcs_jackal)) {
        for(var_7 = 0; var_7 < self.members.size; var_7++) {
          var_1 = getburster(self);

          if(!isDefined(var_1)) {
            continue;
          }

          if(var_1.voice == var_2) {
            break;
          }
        }

        if(!isDefined(var_1) || var_1.voice != var_2) {
          break;
        }
      }

      thread playflavorburstline(var_0, var_5);
      self waittill("burst_line_done");

      if(var_6 != var_3.size - 1) {
        wait randomfloatrange(anim.fbt_linebreakmin, anim.fbt_linebreakmax);
      }
    }

    var_4 = undefined;
  }
}

function squadcanburst(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0.members) {
    if(var_3 == anim.player) {
      continue;
    }

    if(!isDefined(var_3.team)) {
      return var_1;
    }

    if(candoflavorburst(var_3)) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

function candoflavorburst() {
  var_0 = 0;

  if(self != anim.player && isalive(self) && level.flavorbursts[self.team] && voicecanburst() && isDefined(self.flavorbursts) && self.flavorbursts) {
    var_0 = 1;
  }

  return var_0;
}

function voicecanburst() {
  if(isDefined(anim.flavorburstvoices) && isDefined(anim.flavorburstvoices[self.voice]) && anim.flavorburstvoices[self.voice]) {
    return true;
  }

  return false;
}

function getburster(var_0) {
  var_1 = undefined;
  var_2 = scripts\engine\utility::get_array_of_farthest(anim.player.origin, var_0.members);

  foreach(var_4 in var_2) {
    if(candoflavorburst(var_4)) {
      var_1 = var_4;

      if(!isDefined(var_0.fbt_lastbursterid)) {
        break;
      }

      if(isDefined(var_0.fbt_lastbursterid) && var_0.fbt_lastbursterid == var_1.unique_id) {}
    }
  }

  if(isDefined(var_1)) {
    var_0.fbt_lastbursterid = var_1.unique_id;
  }

  return var_1;
}

function getflavorburstid(var_0, var_1) {
  var_2 = scripts\engine\utility::array_randomize(anim.flavorbursts[var_1]);

  if(anim.flavorburstsused.size >= var_2.size) {
    anim.flavorburstsused = [];
  }

  var_3 = undefined;

  foreach(var_5 in var_2) {
    var_3 = var_5;

    if(!flavorburstwouldrepeat(var_3)) {
      break;
    }
  }

  anim.flavorburstsused[anim.flavorburstsused.size] = var_3;
  return var_3;
}

function flavorburstwouldrepeat(var_0) {
  if(!anim.flavorburstsused.size) {
    return 0;
  }

  var_1 = 0;

  foreach(var_3 in anim.flavorburstsused) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

function getflavorburstaliases(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = var_2;
  var_4 = [];

  for(;;) {
    var_5 = var_3;
    var_6 = "FB_" + anim.countryids[var_0] + "_" + var_1 + "_" + var_5;
    var_3++;

    if(soundexists(var_6)) {
      var_4 = var_6;
      continue;
    }

    break;
  }

  return var_4;
}

function playflavorburstline(var_0, var_1) {
  anim endon("battlechatter disabled");
  var_2 = undefined;
  var_2 = spawn("script_origin", var_0 gettagorigin("j_head"));
  var_2 linkTo(var_0);

  if(battlechatter_canprint()) {
    battlechatter_print([var_1]);
  }

  var_2 playSound(var_1, var_1, 1);
  var_2 waittill(var_1);
  var_2 delete();

  if(isDefined(self)) {
    self notify("burst_line_done");
    return;
  }
}

function flavorburstlinedebug(var_0, var_1) {
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
  var_0 = getqueueevents();
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

function printabovehead(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  for(var_3 = 0; var_3 < var_1 * 2; var_3++) {
    if(!isalive(self)) {
      return;
    }

    var_4 = self getshootatpos() + (0, 0, 10) + var_2;
    wait 0.05;
  }
}

function printqueueevent(var_0) {
  var_1 = gettime();

  if(self.battlechatter.chatqueue[var_0].expiretime > 0 && !isDefined(self.battlechatter.chatqueue[var_0].printed)) {
    if(var_1 > self.battlechatter.chatqueue[var_0].expiretime) {}

    self.battlechatter.chatqueue[var_0].printed = 1;
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

function battlechatter_print(var_0) {
  if(var_0.size <= 0) {
    return;
  }

  if(!battlechatter_canprint()) {
    return;
  }

  var_1 = "^5 ";

  if(enemy_team_name()) {
    var_1 = "^6 ";
  }

  var_2 = (0, 0, -7);

  foreach(var_4 in var_0) {}
}

function battlechatter_printscreenadd(var_0, var_1) {
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

  var_2 = level.battlechatter["printscreen"][self.team].size;

  if(var_2 > 40) {
    level.battlechatter["printscreen"][self.team] = scripts\engine\utility::array_remove_index(level.battlechatter["printscreen"][self.team], 0);
    var_2 = level.battlechatter["printscreen"][self.team].size;
  }

  level.battlechatter["printscreen"][self.team][var_2]["alias"] = var_0;
  level.battlechatter["printscreen"][self.team][var_2]["color"] = var_1;
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

  var_0 = 220;
  var_1 = 30;
  var_2 = 600;
  var_3 = 1170;

  for(;;) {
    var_4 = var_0;

    for(var_5 = 0; var_5 < level.battlechatter["printscreen"]["axis"].size; var_5++) {
      var_4 += 18;
    }

    var_4 = var_0;

    for(var_5 = 0; var_5 < level.battlechatter["printscreen"]["allies"].size; var_5++) {
      var_4 += 18;
    }

    var_4 = var_0;

    for(var_5 = 0; var_5 < level.battlechatter["printscreen"]["team3"].size; var_5++) {
      var_4 += 18;
    }

    waitframe();
  }
}

function battlechatter_printwarning(var_0) {}

function battlechatter_printerror(var_0) {}

function battlechatter_draw_arrow(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + anglesToForward(vectortoangles(var_1 - var_0)) * -40;
  var_4 += anglestoright(vectortoangles(var_1 - var_0)) * 18;
  var_4 = var_1 + anglesToForward(vectortoangles(var_1 - var_0)) * -40;
  var_4 += anglestoright(vectortoangles(var_1 - var_0)) * -18;
}

function battlechatter_printdump(var_0, var_1) {}

function getaliastypefromsoundalias(var_0) {
  if(getsubstr(var_0, 0, 6) == "dx_vom") {
    var_1 = getsubstr(var_0, 7, var_0.size);
  } else {
    if(self == anim.player) {
      var_2 = self.battlechatter.countryid + "_";
    } else {
      jumpiffalse(getsubstr(var_2, 0, 6) == "dx_sbc") LOC_00000069;
      var_2 = bc_prefix("stealth");
      goto LOC_00000071;
    }

    LOC_00000071:
      var_1 = getsubstr(var_2, var_2.size, var_2.size);
  }

  return var_1;
}

function battlechatter_printdumpline(var_0, var_1, var_2) {
  if(scripts\engine\utility::flag(var_2)) {
    scripts\engine\utility::flag_wait(var_2);
  }

  scripts\engine\utility::flag_set(var_2);
  scripts\engine\utility::flag_clear(var_2);
}

function bcdrawobjects() {
  for(var_0 = 0; var_0 < anim.bcs_locations.size; var_0++) {
    var_1 = anim.bcs_locations[var_0].locationaliases;

    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = "";

    foreach(var_4 in var_1) {
      var_2 += var_4;
    }

    thread drawbcobject("Location: " + var_2, anim.bcs_locations[var_0] getorigin(), (0, 0, 8), (1, 1, 1));
  }
}

function drawbcobject(var_0, var_1, var_2, var_3) {
  for(;;) {
    if(distancesquared(anim.player.origin, var_1) > 4194304) {
      wait 0.1;
    }

    waitframe();
  }
}

function drawbcdirections(var_0, var_1, var_2) {
  var_3 = var_0 getorigin();

  for(;;) {
    if(distancesquared(anim.player.origin, var_3) > 4194304) {
      wait 0.1;
      continue;
    }

    var_4 = getdirectioncompass(anim.player.origin, var_3);
    var_4 = normalizecompassdirection(var_4);
    var_5 = getdirectionfacingclock(anim.player.angles, anim.player.origin, var_3);
    var_6 = var_4 + ", " + var_5 + ":00";
    wait 0.05;
  }
}

function resetnextsaytimes(var_0, var_1) {
  var_2 = getaiarray(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_4)) {
      continue;
    }

    if(!isDefined(var_4.battlechatterallowed)) {
      continue;
    }

    var_4.battlechatter.nextsaytimes[var_1] = gettime() + 350;
    var_4.squad.nextsaytimes[var_1] = gettime() + 350;
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
    var_0 = self.squad.members;
    var_0 = scripts\engine\utility::array_remove(var_0, self);
    var_0 = scripts\engine\utility::array_remove(var_0, anim.player);

    if(var_0.size > 0) {
      var_0 = sortbydistance(var_0, self.origin);

      foreach(var_2 in var_0) {
        if(!isDefined(var_2.scripteddialoguenotify) && !isDefined(var_2.scripteddialoguenonotify)) {
          var_2 scripts\anim\battlechatter_ai::addreactionevent("friendlyfire", undefined, anim.player, 1);
          break;
        }
      }

      return;
    }

    return;
  }
}

function can_say_friendlyfire(var_0) {
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

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(var_0) {
    if(isDefined(self.squad.nexttypesaytimes["reaction"]["friendlyfire"])) {
      if(gettime() < self.squad.nexttypesaytimes["reaction"]["friendlyfire"]) {
        return false;
      }
    }
  }

  return true;
}

function bccustomconvo(var_0, var_1, var_2, var_3) {
  level.player endon("death");

  if(!isDefined(level.battlechattercustom)) {
    level.battlechattercustom = [];
  }

  if(!isDefined(var_2)) {
    var_2 = "idle";
  }

  if(isstring(var_0)) {
    while(!isDefined(level.stealth)) {
      waitframe();
    }

    level.battlechattercustom[var_0] = spawnStruct();
  }

  var_4 = scripts\stealth\group::getgroup(var_0).members;

  if(isnumber(var_3)) {
    var_5 = squared(var_3);

    for(var_6 = scripts\engine\utility::getclosest(level.player.origin, var_4); distancesquared(level.player.origin, var_6.origin) > var_5; var_6 = scripts\engine\utility::getclosest(level.player.origin, var_4)) {
      waitframe();
      var_4 = scripts\stealth\group::getgroup(var_0).members;
    }

    if(isDefined(var_6.battlechatter.isspeaking) && var_6.battlechatter.isspeaking) {}

    var_7 = getarraykeys(var_1);
    var_8 = 0;

    foreach(var_10 in var_7) {
      if(isDefined(var_1[var_10]["commander"])) {
        var_11 = bccreatemouth(level.player);
      } else {
        if(!isDefined(var_4[var_8])) {
          break;
        }

        var_11 = bccreatemouth(var_4[var_8]);
        var_8++;
      }

      var_4[var_8].battlechatter.isspeaking = 1;
      var_11 playSound(var_1[var_10]["line"], var_1[var_10]["line"], 1);
      var_11 waittill(var_1[var_10]["line"]);
      var_11 delete();
      var_4[var_8].battlechatter.isspeaking = undefined;

      if(isDefined(var_1[var_10]["delay"])) {
        wait var_1[var_10]["delay"];
      }
    }

    return;
  }
}

function bccreatemouth() {
  if(self == anim.player) {
    var_0 = spawn("script_origin", anim.player getEye());
    var_0 linkTo(self);
  } else {
    var_0 = spawn("script_origin", self gettagorigin("j_head"));
    var_0 linkTo(self);
  }

  return var_0;
}

function usecustombc(var_0) {
  if(!isDefined(level.battlechattercustom) || !isDefined(level.battlechattercustom[var_0])) {
    return 0;
  }

  var_1 = getarraykeys(level.battlechattercustom[var_0]);

  if(var_1.size > 0 && isDefined(level.battlechattercustom[var_0]["curEvent"]) && scripts\engine\utility::array_contains(var_1, level.battlechattercustom[var_0]["curEvent"])) {
    return 1;
  }

  return 0;
}

function getcustombc(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = bc_prefix("custom");
  var_6 = bc_prefix("custom radio");
  var_7 = var_5;
  var_8 = getarraykeys(level.battlechattercustom[var_0]);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    if(!isDefined(level.battlechattercustom[var_0]["curEvent"]) || !scripts\engine\utility::array_contains(var_8, level.battlechattercustom[var_0]["curEvent"]) || var_8[var_9] != level.battlechattercustom[var_0]["curEvent"]) {
      continue;
    }

    if(isarray(level.battlechattercustom[var_0][var_8[var_9]])) {
      for(var_10 = 0; var_10 < level.battlechattercustom[var_0][var_8[var_9]].size; var_10++) {
        if(isarray(level.battlechattercustom[var_0][var_8[var_9]][var_10])) {
          for(var_11 = 0; var_11 < level.battlechattercustom[var_0][var_8[var_9]][var_10].size; var_11++) {
            if(isradioline(level.battlechattercustom[var_0][var_8[var_9]][var_10][var_11])) {
              var_7 = var_6 + getcustombcradioprefix(level.battlechattercustom[var_0][var_8[var_9]][var_10][var_11]);
            } else {
              var_7 = var_5;
            }

            if(!isDefined(var_1)) {
              var_1 = var_7 + level.battlechattercustom[var_0][var_8[var_9]][var_10][var_11];
              var_3 = var_11;
              continue;
            }

            var_4 = 1;
            var_2 = var_7 + level.battlechattercustom[var_0][var_8[var_9]][var_10][var_11];
          }

          if(isDefined(var_2)) {
            cleancustombc(var_8[var_9], var_0, var_10, var_3, 0);
            cleancustombc(var_8[var_9], var_0, var_10, var_3);
          } else {
            cleancustombc(var_8[var_9], var_0, var_10, var_3);
          }

          break;
        }

        var_7 = scripts\engine\utility::ter_op(isradioline(level.battlechattercustom[var_0][var_8[var_9]][var_10]), var_6, var_5);
        var_1 = var_7 + level.battlechattercustom[var_0][var_8[var_9]][var_10];
        cleancustombc(var_8[var_9], var_0, var_10, var_3);
        break;
      }

      break;
    }

    var_7 = scripts\engine\utility::ter_op(isradioline(level.battlechattercustom[var_0][var_8[var_9]]), var_6, var_5);
    var_1 = var_7 + level.battlechattercustom[var_0][var_8[var_9]];
    break;
  }

  if(isDefined(var_4)) {
    return [var_1, var_2];
  }

  return var_1;
}

function cleancustombc(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(istrue(level.battlechattercustom[var_1][var_0]["looping"])) {
    if(var_4) {
      level.battlechattercustom[var_1][var_0] = custombcshiftarray(level.battlechattercustom[var_1][var_0]);
    }
  } else {
    level.battlechattercustom[var_1][var_0][var_2] = scripts\engine\utility::array_remove_index(level.battlechattercustom[var_1][var_0][var_2], var_3);

    if(level.battlechattercustom[var_1][var_0][var_2].size < 1) {
      level.battlechattercustom[var_1][var_0] = scripts\engine\utility::array_remove_index(level.battlechattercustom[var_1][var_0], var_2);
    }
  }

  if(level.battlechattercustom[var_1][var_0].size < 1) {
    level.battlechattercustom[var_1] = scripts\engine\utility::array_remove_key(level.battlechattercustom[var_1], var_0);
    return;
  }
}

function custombcshiftarray(var_0) {
  if(!isDefined(var_0["count"])) {
    GscBinSkip0(0x2e, "count", 1);
  }

  var_1 = [];
  var_2 = [];
  var_3 = getarraykeys(var_0);

  foreach(var_5 in var_3) {
    if(isnumber(var_5)) {
      if(var_5 != 0) {
        var_1 = var_0[var_5];
      }

      continue;
    }

    var_2 = var_0[var_5];
  }

  var_1 = var_0[0];

  if(var_0["count"] == var_1.size) {
    for(var_1 = scripts\engine\utility::array_randomize(var_1); var_1[0][0] == var_0[0][0]; var_1 = scripts\engine\utility::array_randomize(var_1)) {}

    var_0 = 1;
  } else {
    var_0 = var_0["count"] + 1;
  }

  var_3 = getarraykeys(var_2);

  foreach(var_5 in var_3) {
    var_1 = var_2[var_5];
  }

  var_1 = var_0["count"];
  return var_1;
}

function addcustombc(var_0, var_1, var_2) {
  if(!isDefined(level.battlechattercustom)) {
    level.battlechattercustom = [];
  }

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_4 in var_1) {
    if(!isDefined(level.battlechattercustom[var_4])) {
      level.battlechattercustom[var_4] = [];
    }
  }

  var_6 = getarraykeys(var_0);

  for(var_7 = 0; var_7 < var_6.size; var_7++) {
    for(var_8 = 0; var_8 < var_0[var_6[var_7]].size; var_8++) {
      foreach(var_4 in var_1) {
        level.battlechattercustom[var_4][var_6[var_7]][var_8] = var_0[var_6[var_7]][var_8];
      }
    }
  }

  if(isDefined(var_2)) {
    foreach(var_12 in var_6) {
      foreach(var_4 in var_1) {
        level.battlechattercustom[var_4][var_12] = scripts\engine\utility::array_randomize(level.battlechattercustom[var_4][var_12]);
      }
    }

    return;
  }
}

function setcurrentcustombcevent(var_0, var_1, var_2) {
  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_4 in var_1) {
    level.battlechattercustom[var_4]["curEvent"] = var_0;
    level.battlechattercustom[var_4][var_0]["looping"] = var_2;

    if(scripts\engine\utility::array_contains(getarraykeys(level.battlechattercustom[var_4]), var_0)) {}
  }
}

function clearcurrentcustombcevent(var_0) {
  level.battlechattercustom[var_0]["curEvent"] = undefined;
}

function removecustombcevent(var_0, var_1) {
  var_2 = getarraykeys(level.battlechattercustom[var_1]);
  level.battlechattercustom[var_1] = scripts\engine\utility::array_remove_key(level.battlechattercustom[var_1], var_0);
}

function uselocationbc(var_0) {
  var_1 = getvalidlocation(self, "stealth", var_0);

  if(isDefined(var_1)) {
    return true;
  }

  return false;
}

function getstealthlocationalias(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "";
  }

  var_1 = getvalidlocation(self, "stealth", var_0);
  location_add_last_callout_time(var_1);

  switch (var_0) {
    case "update":
    case "callin":
      var_2 = randomintrange_otn(1);
      var_3 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_" + var_0 + "_" + var_1.locationaliases[0] + "_");
      GscBinSkip1(0x45, 0, var_3 + var_2);

    case "checkin":
      var_2 = randomintrange_otn(1);
      var_3 = getloccalloutalias(scripts\anim\battlechatter_ai::getbcstate() + "_location_" + var_2 + "_" + var_3.locationaliases[0] + "_");
      GscBinSkip1(0x45, 0, createleaderalias(var_3, var_2));
  }
}

function isradioline(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(getsubstr(var_0, var_0.size - 2, var_0.size) == "_r") {
    return 1;
  }

  if(issubstr(var_0, "_r_")) {
    return 1;
  }

  if(issubstr(var_0, "_aql1r_")) {
    return scripts\engine\utility::ter_op(var_1, "_aql1_", 1);
  }

  if(issubstr(var_0, "_aql2r_")) {
    return scripts\engine\utility::ter_op(var_1, "_aql2_", 1);
  }

  if(issubstr(var_0, "_rul1r_")) {
    return scripts\engine\utility::ter_op(var_1, "_rul1_", 1);
  }

  if(issubstr(var_0, "_rul2r_")) {
    return scripts\engine\utility::ter_op(var_1, "_rul2_", 1);
  }

  return 0;
}

function getcustombcradioprefix(var_0) {
  return isradioline(var_0, 1);
}

function createleaderalias(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  } else {
    var_1 = "_" + var_1;
  }

  var_2 = strtok(var_0, "_");
  GscBinSkip0(0x2e, 2, self.battlechatter.countryid + "l1");
}

function scalebattlechatterfrequency(var_0) {
  if(!isDefined(level.bcs_frequencyscalar)) {
    level.bcs_frequencyscalar = var_0;
  }

  var_1 = 1 / level.bcs_frequencyscalar;
  var_0 = var_1 * var_0;
  level.bcs_frequencyscalar = var_0;

  while(!isDefined(anim.eventactionminwait)) {
    waitframe();
  }

  var_2 = getarraykeys(anim.eventactionminwait);

  foreach(var_4 in var_2) {
    var_5 = getarraykeys(anim.eventactionminwait[var_4]);

    foreach(var_7 in var_5) {
      anim.eventactionminwait[var_4][var_7] = var_0 * anim.eventactionminwait[var_4][var_7];
    }
  }

  var_2 = getarraykeys(anim.eventtypeminwait);

  foreach(var_4 in var_2) {
    if(isarray(anim.eventtypeminwait[var_4])) {
      var_5 = getarraykeys(anim.eventtypeminwait[var_4]);

      foreach(var_7 in var_5) {
        anim.eventtypeminwait[var_4][var_7] = var_0 * anim.eventtypeminwait[var_4][var_7];
      }
    }
  }

  var_2 = getarraykeys(anim.eventduration);

  foreach(var_4 in var_2) {
    var_5 = getarraykeys(anim.eventduration[var_4]);

    foreach(var_7 in var_5) {
      anim.eventduration[var_4][var_7] = var_0 * anim.eventduration[var_4][var_7];
    }
  }
}