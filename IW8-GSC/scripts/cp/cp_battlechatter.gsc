/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_battlechatter.gsc
***********************************************/

function manualinitbattlechatter() {
  if(scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_wait_all("infil_complete", "introscreen_over");
  }

  if(!isDefined(anim.chatinitialized)) {
    anim.player = getEntArray("player", "classname")[0];

    while(!isDefined(anim.player)) {
      anim.player = getEntArray("player", "classname")[0];
      wait 5;
    }
  }

  if(!isDefined(anim.player.team)) {
    anim.player.team = "allies";
  }

  level._battlechatter = spawnStruct();
  level._battlechatter.fnevaluatemoveevent = &scripts\cp\cp_battlechatter_ai::evaluatemoveevent;
  level._battlechatter.fnevaluatereloadevent = &scripts\cp\cp_battlechatter_ai::evaluatereloadevent;
  level._battlechatter.fnaddthreatevent = &scripts\cp\cp_battlechatter_ai::addthreatevent;
  level._battlechatter.fnevaluateattackevent = &scripts\cp\cp_battlechatter_ai::evaluateattackevent;
  level._battlechatter.fnplaybattlechatter = &playbattlechatter;
  scripts\anim\shared::init_squadmanager();
  init_battlechatter();
  scripts\cp\cp_playerchatter::init_playerchatter();
  thread bcsdebugwaiter();
  scripts\cp\utility::battlechatter_on("axis");
}

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
  setdvarifuninitialized("bcs_filterOrder", "off");
  setdvarifuninitialized("bcs_filterReaction", "off");
  setdvarifuninitialized("bcs_filterResponse", "off");
  setdvarifuninitialized("bcs_otnStealth", "all");
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
  bcs_setup_countryids();
  anim.playernameids["unitednations"] = "1";
  anim.playernameids["unitednationshelmet"] = "1";
  anim.playernameids["unitednationsfemale"] = "1";
  anim.playernameids["unitedstates"] = "1";
  anim.playernameids["unitedstatesfemale"] = "1";
  anim.playernameids["alqatala"] = "1";
  anim.playernameids["alqatalafemale"] = "1";
  anim.playernameids["russian"] = "1";
  anim.playernameids["sas"] = "1";
  anim.playernameids["sasfemale"] = "1";
  anim.playernameids["fsa"] = "1";
  anim.playernameids["fsafemale"] = "1";
  thread setplayerbcnameid();
  init_flavorbursts();
  anim.eventtypeminwait = [];
  anim.eventtypeminwait["threat"] = [];
  anim.eventtypeminwait["response"] = [];
  anim.eventtypeminwait["reaction"] = [];
  anim.eventtypeminwait["order"] = [];
  anim.eventtypeminwait["inform"] = [];
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
  anim.eventactionminwait["custom"]["self"] = 0;
  anim.eventactionminwait["custom"]["squad"] = 0;
  anim.eventactionminwait["stealth"]["self"] = 9000;
  anim.eventactionminwait["stealth"]["squad"] = 5000;
  anim.eventactionminwait["stealth"]["location_repeat"] = 45000;
  anim.eventtypeminwait["playername"] = 50000;
  anim.eventtypeminwait["reaction"]["casualty"] = 14000;
  anim.eventtypeminwait["reaction"]["friendlyfire"] = 5000;
  anim.eventtypeminwait["reaction"]["takingfire"] = 5000;
  anim.eventtypeminwait["reaction"]["maneuver"] = 4000;
  anim.eventtypeminwait["reaction"]["movement"] = 4000;
  anim.eventtypeminwait["reaction"]["underfire"] = 4000;
  anim.eventtypeminwait["reaction"]["danger"] = 4000;
  anim.eventtypeminwait["reaction"]["ask_ok"] = 4000;
  anim.eventtypeminwait["reaction"]["taunt"] = 5000;
  anim.eventtypeminwait["inform"]["reloading"] = 5000;
  anim.eventtypeminwait["inform"]["killfirm"] = 4000;
  anim.eventtypeminwait["inform"]["attack"] = 5000;
  anim.eventtypeminwait["threat"]["acquired"] = 7000;
  anim.eventtypeminwait["threat"]["sighted"] = 7000;
  anim.eventtypeminwait["reaction"]["maneuver"] = 5000;
  anim.eventtypeminwait["reaction"]["underfire"] = 2000;
  anim.eventtypeminwait["order"]["action"] = 5000;
  anim.eventtypeminwait["response"]["callout"] = 7000;
  anim.eventtypeminwait["response"]["location"] = 7000;
  anim.eventtypeminwait["stealth"]["idle"] = 27500;
  anim.eventtypeminwait["stealth"]["idle_alert"] = 25000;
  anim.eventtypeminwait["stealth"]["investigate"] = 12000;
  anim.eventtypeminwait["stealth"]["hunt"] = 500;
  anim.eventtypeminwait["stealth"]["combat"] = 15000;
  anim.eventtypeminwait["stealth"]["announce1"] = 500;
  anim.eventtypeminwait["stealth"]["announce2"] = 3000;
  anim.eventtypeminwait["stealth"]["announce3"] = 3000;
  anim.eventtypeminwait["stealth"]["announce4"] = 3000;
  anim.eventtypeminwait["stealth"]["announce5"] = 3000;
  anim.eventpriority["threat"]["infantry"] = 0.6;
  anim.eventpriority["threat"]["vehicle"] = 0.7;
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
  anim.eventpriority["custom"]["generic"] = 1;
  anim.eventpriority["stealth"]["idle"] = 0.6;
  anim.eventpriority["stealth"]["idle_alert"] = 0.6;
  anim.eventpriority["stealth"]["investigate"] = 0.6;
  anim.eventpriority["stealth"]["hunt"] = 0.9999;
  anim.eventpriority["stealth"]["combat"] = 0.6;
  anim.eventpriority["stealth"]["announce1"] = 0.999999;
  anim.eventpriority["stealth"]["announce2"] = 0.99999;
  anim.eventpriority["stealth"]["announce3"] = 0.9999;
  anim.eventpriority["stealth"]["announce4"] = 0.999;
  anim.eventpriority["stealth"]["announce5"] = 0.99;
  anim.eventduration["threat"]["infantry"] = 10000;
  anim.eventduration["threat"]["vehicle"] = 10000;
  anim.eventduration["threat"]["sighted"] = 15000;
  anim.eventduration["threat"]["acquired"] = 15000;
  anim.eventduration["response"]["exposed"] = 10000;
  anim.eventduration["response"]["callout"] = 20000;
  anim.eventduration["response"]["location"] = 20000;
  anim.eventduration["response"]["echo"] = 20000;
  anim.eventduration["response"]["ack"] = 10000;
  anim.eventduration["response"]["covering"] = 15000;
  anim.eventduration["response"]["im"] = 15000;
  anim.eventduration["reaction"]["casualty"] = 10000;
  anim.eventduration["reaction"]["friendlyfire"] = 10000;
  anim.eventduration["reaction"]["takingfire"] = 15000;
  anim.eventduration["reaction"]["maneuver"] = 15000;
  anim.eventduration["reaction"]["movement"] = 15000;
  anim.eventduration["reaction"]["underfire"] = 15000;
  anim.eventduration["reaction"]["danger"] = 15000;
  anim.eventduration["reaction"]["ask_ok"] = 15000;
  anim.eventduration["reaction"]["taunt"] = 20000;
  anim.eventduration["order"]["action"] = 30000;
  anim.eventduration["order"]["move"] = 30000;
  anim.eventduration["order"]["displace"] = 30000;
  anim.eventduration["inform"]["attack"] = 10000;
  anim.eventduration["inform"]["incoming"] = 15000;
  anim.eventduration["inform"]["reloading"] = 10000;
  anim.eventduration["inform"]["suppressed"] = 20000;
  anim.eventduration["inform"]["killfirm"] = 20000;
  anim.eventduration["custom"]["generic"] = 10000;
  anim.eventduration["stealth"]["idle"] = 5000;
  anim.eventduration["stealth"]["idle_alert"] = 5000;
  anim.eventduration["stealth"]["investigate"] = 15000;
  anim.eventduration["stealth"]["hunt"] = 15000;
  anim.eventduration["stealth"]["combat"] = 15000;
  anim.eventduration["stealth"]["announce1"] = 15000;
  anim.eventduration["stealth"]["announce2"] = 15000;
  anim.eventduration["stealth"]["announce3"] = 15000;
  anim.eventduration["stealth"]["announce4"] = 15000;
  anim.eventduration["stealth"]["announce5"] = 15000;
  anim.eventchance["response"]["exposed"] = 85;
  anim.eventchance["response"]["reload"] = 80;
  anim.eventchance["response"]["location"] = 75;
  anim.eventchance["response"]["callout"] = 75;
  anim.eventchance["response"]["callout_negative"] = 60;
  anim.eventchance["response"]["order"] = 80;
  anim.eventchance["moveEvent"]["coverme"] = 70;
  anim.eventchance["moveEvent"]["ordertoplayer"] = 50;
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

  if(!isDefined(anim.bcs_locations)) {
    scripts\common\bcs_location_trigs::bcs_location_trigs_init();
  }

  anim.scripteddialoguebuffertime = 4000;
  anim.bcs_threatresettime = 3000;
  anim.squadcreatefuncs[anim.squadcreatefuncs.size] = &init_squadbattlechatter;
  anim.squadcreatestrings[anim.squadcreatestrings.size] = "::init_squadBattleChatter";

  foreach(var1 in anim.teams) {
    anim.isteamspeaking[var1] = 0;
    anim.isteamsaying[var1]["threat"] = 0;
    anim.isteamsaying[var1]["order"] = 0;
    anim.isteamsaying[var1]["reaction"] = 0;
    anim.isteamsaying[var1]["response"] = 0;
    anim.isteamsaying[var1]["inform"] = 0;
    anim.isteamsaying[var1]["custom"] = 0;
    anim.isteamsaying[var1]["stealth"] = 0;
  }

  bcs_setup_chatter_toggle_array();
  bcs_setup_flavorburst_toggle_array();
  anim.lastteamspeaktime = [];
  anim.lastnamesaid = [];
  anim.lastnamesaidtime = [];

  foreach(var1 in anim.teams) {
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
  anim.threatcallouts["player_distance"] = 20;
  anim.threatcallouts["player_obvious"] = 25;
  anim.threatcallouts["player_contact_clock"] = 25;
  anim.threatcallouts["player_target_clock"] = 25;
  anim.threatcallouts["player_target_clock_high"] = 25;
  anim.threatcallouts["player_cardinal"] = 20;
  anim.threatcallouts["ai_distance"] = 25;
  anim.threatcallouts["ai_obvious"] = 25;
  anim.threatcallouts["ai_contact_clock"] = 20;
  anim.threatcallouts["ai_casual_clock"] = 20;
  anim.threatcallouts["ai_target_clock"] = 20;
  anim.threatcallouts["ai_target_clock_high"] = 25;
  anim.threatcallouts["ai_cardinal"] = 10;
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

function init_flavorbursts() {
  anim.flavorbursts["unitednations"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["unitednations"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["unitednationshelmet"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["unitednationshelmet"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["unitednationsfemale"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["unitednationsfemale"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["unitedstates"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["unitedstates"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["unitedstatesfemale"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["unitedstatesfemale"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["sas"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["sas"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["sasfemale"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["sasfemale"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["fsa"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["fsa"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorbursts["fsafemale"] = [];
  var0 = 41;

  for(var1 = 0; var1 < var0; var1++) {
    anim.flavorbursts["fsafemale"][var1] = scripts\engine\utility::string(var1 + 1);
  }

  anim.flavorburstsused = [];
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
  var0.nextsaytimes["custom"] = gettime() + 50;
  var0.nextsaytimes["stealth"] = gettime() + 50;
  var0.nexttypesaytimes["threat"] = [];
  var0.nexttypesaytimes["order"] = [];
  var0.nexttypesaytimes["reaction"] = [];
  var0.nexttypesaytimes["response"] = [];
  var0.nexttypesaytimes["inform"] = [];
  var0.nexttypesaytimes["custom"] = [];
  var0.nexttypesaytimes["stealth"] = [];
  var0.ismembersaying["threat"] = 0;
  var0.ismembersaying["order"] = 0;
  var0.ismembersaying["reaction"] = 0;
  var0.ismembersaying["response"] = 0;
  var0.ismembersaying["inform"] = 0;
  var0.ismembersaying["custom"] = 0;
  var0.ismembersaying["stealth"] = 0;
  var0.lastdirection = "";
  var0.memberaddfuncs[var0.memberaddfuncs.size] = &scripts\cp\cp_battlechatter_ai::addtosystem;
  var0.memberremovefuncs[var0.memberremovefuncs.size] = &scripts\cp\cp_battlechatter_ai::removefromsystem;
  var0.squadupdatefuncs[var0.squadupdatefuncs.size] = &initcontact;
  var0.fbt_firstburst = 1;
  var0.fbt_lastbursterid = undefined;

  for(var1 = 0; var1 < anim.squadindex.size; var1++) {
    thread initcontact(var0);
  }

  var0 thread scripts\cp\cp_battlechatter_ai::squadthreatwaiter();
  thread squadflavorbursttransmissions();
  var0.chatinitialized = 1;
  var0 notify("squad chat initialized");
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

function entinfrontarc(var0) {
  return scripts\engine\utility::within_fov(self.origin, self.angles, var0.origin, 0);
}

function initcontact(var0) {
  if(!isDefined(self.squadlist[var0].calledout)) {
    self.squadlist[var0].calledout = 0;
  }

  if(!isDefined(self.squadlist[var0].firstcontact)) {
    self.squadlist[var0].firstcontact = 2000000000;
  }

  if(!isDefined(self.squadlist[var0].lastcontact)) {
    self.squadlist[var0].lastcontact = 0;
    return;
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

function voicecanburst() {
  if(isDefined(anim.flavorburstvoices) && isDefined(anim.flavorburstvoices[self.voice]) && anim.flavorburstvoices[self.voice]) {
    return true;
  }

  return false;
}

function candoflavorburst() {
  var0 = 0;

  if(self != anim.player && isalive(self) && level.flavorbursts[self.team] && voicecanburst() && isDefined(self.flavorbursts) && self.flavorbursts) {
    var0 = 1;
  }

  return var0;
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

function flavorburstlinedebug(var0, var1) {
  self endon("burst_line_done");

  for(;;) {
    wait 0.05;
  }
}

function playflavorburstline(var0, var1) {
  anim endon("battlechatter disabled");
  var2 = undefined;
  var2 = spawn("script_origin", var0 gettagorigin("j_head"));
  var2 linkTo(var0);

  if(battlechatter_canprint()) {
    battlechatter_print([var1]);
  }

  var2 playSound(var1);
  wait lookupsoundlength(var1) / 1000;
  var2 delete();

  if(isDefined(self)) {
    self notify("burst_line_done");
    return;
  }
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

  var3.expiretime = gettime() + anim.eventduration[var0][var1];
  return var3;
}

function isspeakingfailsafe(var0) {
  self endon("death");
  self endon("removed from battleChatter");
  wait 25;
  clearisspeaking(var0);
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
  var5 = var0 scripts\engine\utility::ref_143ae("death", "done speaking", "cancel speaking");
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

function clearisspeaking(var0) {
  self.battlechatter.isspeaking = 0;
  self.battlechatter.chatqueue[var0].expiretime = 0;
  self.battlechatter.chatqueue[var0].priority = 0;
  self.battlechatter.nextsaytimes[var0] = gettime() + anim.eventactionminwait[var0]["self"];
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

function stealthdocustombc(var0) {
  if(isDefined(self.battlechatter.custombc_alias2) && self.battlechatter.custombc_alias2 == "") {
    self.battlechatter.custombc_alias2 = undefined;
    return true;
  } else if(var0 && isDefined(self.battlechatter.custombc_alias2)) {
    GscBinSkip4(0x35, self.battlechatter.custombc_alias2);
  }

  return false;
}

function stealthcustombc(var0) {
  wait randomfloatrange(0.3, 0.4);

  if(isradioline(var0)) {
    thread playradioecho(var0, undefined, 1);
    thread playradio(var0);
    return;
  }

  thread playradioecho(var0, 1);
  var1 = spawn("script_origin", self gettagorigin("j_head"));
  var1 linkTo(self);

  if(battlechatter_canprint()) {
    battlechatter_print([var0 + " cusBC"]);
  }

  if(soundexists(var0)) {
    var1 playSound(var0);
    wait lookupsoundlength(var0) / 1000;
  } else {
    battlechatter_printwarning("Tried to play an alias that doesn't exist: '" + var0 + "'.");
  }

  var1 delete();
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

function battlechatter_canprintdump() {
  return false;
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
      continue;
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
      if(isDefined(self.classname) && self.classname == "player") {
        self notify(var0.soundaliases[var5] + "_started");
        var3 = 1;
        var9 playSound(var0.soundaliases[var5]);
      } else {
        self notify(var0.soundaliases[var5] + "_started");
        var3 = 1;
        var9 playSound(var0.soundaliases[var5]);
      }

      wait lookupsoundlength(var0.soundaliases[var5]) / 1000;
      self notify(var0.soundaliases[var5]);
    } else {
      if(isDefined(self.classname) && self.classname == "player") {
        self notify(var0.soundaliases[var5] + "_started");
        var3 = 1;
        var9 playSound(var0.soundaliases[var5]);
      } else {
        self notify(var0.soundaliases[var5] + "_started");
        var3 = 1;
        var9 playSound(var0.soundaliases[var5]);
      }

      wait lookupsoundlength(var0.soundaliases[var5]) / 1000;
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

function is_friendlyfire_event(var0) {
  if(!isDefined(var0.eventaction) || !isDefined(var0.eventtype)) {
    return false;
  }

  if(var0.eventaction == "reaction" && var0.eventtype == "friendlyfire") {
    return true;
  }

  return false;
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

function getcustombcradioprefix(var0) {
  return isradioline(var0, 1);
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

function addcustombcstealthalias(var0) {
  var1 = getcustombc(var0);
  self.battlechatter.custombc_alias2 = "";

  if(isarray(var1)) {
    self.battlechatter.custombc_alias2 = var1[1];
    var1 = var1[0];
  }

  if(isradioline(var1)) {
    thread playradioecho(var1);
  } else {
    var2 = "";
    var3 = strtok(var1, "_");

    for(var4 = 0; var4 < var3.size; var4++) {
      if(var4 == var3.size - 1) {
        var2 = var2 + "r_" + var3[var4];
        continue;
      }

      var2 = var2 + var3[var4] + "_";
    }

    if(soundexists(var2)) {
      thread playradioecho(var1, undefined, undefined, var2);
    } else {
      battlechatter_printwarning("Can't find radio alias '" + var2 + "'.This may be intentional if talking to himself.");
    }
  }

  return var1;
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
        } else if(scripts\engine\utility::cointoss()) {
          if(uselocationbc(self.owner, "checkin")) {
            var4 = getstealthlocationalias(self.owner, "checkin");
            var2 = var4[0];
            var3 = scripts\engine\utility::array_remove_index(var4, 0);
          } else {
            var5 = randomintrange_otn(1);
            var6 = bc_prefix(self.owner, "stealth") + getbcstate(self.owner) + "_checkin";
            var2 = createleaderalias(self.owner, var6, var5);
            var3 = var6 + "_resp_" + var5;
            var3 = createleaderalias(self.owner, var6 + "_resp", var5);
          }

          self.checkin = 1;
          thread playradioecho(self.owner);
        } else {
          if(uselocationbc(self.owner, "callin")) {
            var4 = getstealthlocationalias(self.owner, "callin");
            var2 = var4[0];
            var3 = scripts\engine\utility::array_remove_index(var4, 0);
          } else {
            var5 = randomintrange_otn(1);
            var6 = bc_prefix(self.owner, "stealth") + getbcstate(self.owner) + "_callin_";
            var2 = var6 + var5;
            var3 = createleaderalias(self.owner, var6 + "resp", var5);
          }

          self.callin = 1;
          thread playradioecho(self.owner, var2);
        }

        break;
      case "investigate":
        if(usecustombc(var0)) {
          var2 = addcustombcstealthalias(self.owner, var0);
        } else if(!istrue(self.owner.battlechatter.investigatecallin)) {
          if(uselocationbc(self.owner, "callin")) {
            var4 = getstealthlocationalias(self.owner, "callin");
            var2 = var4[0];
            var3 = scripts\engine\utility::array_remove_index(var4, 0);
          } else {
            var5 = randomintrange_otn(1);
            var6 = bc_prefix(self.owner, "stealth") + getbcstate(self.owner) + "_callin_";
            var2 = var6 + var5;
            var3 = createleaderalias(self.owner, var6 + "resp", var5);
          }

          self.owner.battlechatter.investigatecallin = 1;
          self.callin = 1;
        } else {
          if(uselocationbc(self.owner, "update")) {
            var4 = getstealthlocationalias(self.owner, "update");
            var2 = var4[0];
            var3 = scripts\engine\utility::array_remove_index(var4, 0);
          } else {
            var5 = randomintrange_otn(1);
            var6 = bc_prefix(self.owner, "stealth") + getbcstate(self.owner) + "_update_";
            var2 = var6 + var5;
            var3 = createleaderalias(self.owner, var6 + "resp", var5);
          }

          self.update = 1;
        }

        thread playradioecho(self.owner, var2);
        break;
      case "hunt":
        self.owner.battlechatter.investigatecallin = 0;

        if(usecustombc(var0)) {
          var2 = addcustombcstealthalias(self.owner, var0);
        } else {
          switch (var1) {
            case "teaminquiry":
              var2 = bc_prefix(self.owner, "stealth") + "team_inquiry_" + randomintrange_otn(1);
              thread playradioecho(self.owner, var2);
              break;
            case "first_lost":
              var5 = randomintrange_otn(1);
              var6 = bc_prefix(self.owner, "stealth") + "hunt_firstlost_";
              var2 = var6 + var5;
              thread playradioecho(self.owner, var2);
              var3 = createleaderalias(self.owner, var6 + "resp", var5);
              break;
            case "lost_sight":
              var5 = randomintrange_otn(1);
              var6 = bc_prefix(self.owner, "stealth") + "lost_sight_";
              var2 = var6 + var5;
              thread playradioecho(self.owner, var2);
              var3 = createleaderalias(self.owner, var6 + "resp", var5);
              break;
            default:
              break;
          }
        }

        break;
      case "combat":
        break;
      case "announce":
        switch (var1) {
          case "investigate":
            var2 = bc_prefix(self.owner, "stealth") + "investigate_generic_" + randomintrange_otn(1);
            break;
          case "coverblown":
            var2 = bc_prefix(self.owner, "stealth") + "coverblown_generic_" + randomintrange_otn(1);
            break;
          case "combat":
            var2 = bc_prefix(self.owner, "stealth") + "combat_generic_" + randomintrange_otn(1);
            break;
          case "ally_killed":
            var2 = bc_prefix(self.owner, "stealth") + "ally_killed_" + randomintrange_otn(1);
            break;
          case "damage":
            var2 = bc_prefix(self.owner, "stealth") + "damage_generic_" + randomintrange_otn(1);
            break;
          case "drone_spotted":
            var2 = bc_prefix(self.owner, "stealth") + "drone_spotted_" + randomintrange_otn(1);
            thread playradioecho(self.owner, var2);
            break;
          case "explosion":
            var2 = bc_prefix(self.owner, "stealth") + "explosion_generic_" + randomintrange_otn(1);
            thread playradioecho(self.owner, var2);
            break;
          case "footstep_walk":
          case "footstep":
            var2 = bc_prefix(self.owner, "stealth") + "footstep_generic_" + randomintrange_otn(1);
            break;
          case "footstep_sprint":
            var2 = bc_prefix(self.owner, "stealth") + "footstep_sprint_" + randomintrange_otn(1);
            break;
          case "found_corpse":
            var2 = bc_prefix(self.owner, "stealth") + "found_corpse_" + randomintrange_otn(1);
            thread playradioecho(self.owner, var2);
            break;
          case "glass_destroyed":
            var2 = bc_prefix(self.owner, "stealth") + "glass_destroyed_" + randomintrange_otn(1);
            break;
          case "grenade_danger":
            var2 = bc_prefix(self.owner, "stealth") + "grenade_danger_" + randomintrange_otn(1);
            break;
          case "gunshot":
            var2 = bc_prefix(self.owner, "stealth") + "gunshot_generic_" + randomintrange_otn(1);
            thread playradioecho(self.owner, var2);
            break;
          case "gunshot_teammate":
            var2 = bc_prefix(self.owner, "stealth") + "gunshot_teammate_" + randomintrange_otn(1);
            thread playradioecho(self.owner, var2);
            break;
          case "alertreset":
            var2 = bc_prefix(self.owner, "stealth") + "alert_reset_" + randomintrange_otn(1);
            thread playradioecho(self.owner, var2);
            break;
          case "teaminquiry":
            var2 = bc_prefix(self.owner, "stealth") + "team_inquiry_" + randomintrange_otn(1);
            thread playradioecho(self.owner, var2);
            break;
          case "light_killed":
            var2 = bc_prefix(self.owner, "stealth") + "light_killed_" + randomintrange_otn(1);
            break;
          case "first_lost":
            var5 = randomintrange_otn(1);
            var6 = bc_prefix(self.owner, "stealth") + "hunt_firstlost_";
            var2 = var6 + var5;
            thread playradioecho(self.owner, var2);
            var3 = createleaderalias(self.owner, var6 + "resp", var5);
            break;
          case "lost_sight":
            var5 = randomintrange_otn(1);
            var6 = bc_prefix(self.owner, "stealth") + "lost_sight_";
            var2 = var6 + var5;
            thread playradioecho(self.owner, var2);
            var3 = createleaderalias(self.owner, var6 + "resp", var5);
            break;
          case "proximity":
            var2 = bc_prefix(self.owner, "stealth") + "proximity_generic_" + randomintrange_otn(1);
            break;
          case "saw_corpse":
            var2 = bc_prefix(self.owner, "stealth") + "saw_corpse_" + randomintrange_otn(1);
            break;
          case "seek_backup":
            var2 = bc_prefix(self.owner, "stealth") + "seek_backup_" + randomintrange_otn(1);
            thread playradioecho(self.owner, var2);
            break;
          case "sight":
            var2 = bc_prefix(self.owner, "stealth") + "sight_generic_" + randomintrange_otn(1);
            break;
          case "unresponsive_teammate":
            var2 = bc_prefix(self.owner, "stealth") + "unresponsive_teammate_" + randomintrange_otn(1);
            thread playradioecho(self.owner, var2);
            break;
          case "bulletwhizby":
            var2 = bc_prefix(self.owner, "stealth") + "bulletwhizby_generic_" + randomintrange_otn(1);
          case "silenced_shot":
            var2 = bc_prefix(self.owner, "stealth") + "silenced_shot_" + randomintrange_otn(1);
            break;
          case "window_open":
            var2 = bc_prefix(self.owner, "stealth") + "window_open_" + randomintrange_otn(1);
            break;
        }

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

function getstealthlocationalias(var0) {
  if(!isDefined(var0)) {
    var0 = "";
  }

  var1 = getvalidlocation(self, "stealth", var0);
  location_add_last_callout_time(var1);

  switch (var0) {
    case "callin":
    case "update":
      var2 = randomintrange_otn(1);
      var3 = getloccalloutalias(getbcstate() + "_location_" + var0 + "_" + var1.locationaliases[0] + "_");
      GscBinSkip1(0x45, 0, var3 + var2);

    case "checkin":
      var2 = randomintrange_otn(1);
      var3 = getloccalloutalias(getbcstate() + "_location_" + var2 + "_" + var3.locationaliases[0] + "_");
      GscBinSkip1(0x45, 0, createleaderalias(var3, var2));
  }
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

  if(var3 && isDefined(var2.checkin) && getbcstate(var1) == "idle") {
    foreach(var5 in var2.responsealiases) {
      var2.soundaliases = [];
      var2.soundaliases[0] = var5;

      if(isradioline(var5)) {
        var3 = stealthcommander(var1, var2.soundaliases[0]);
      } else {
        commander_delay(var1);
        GscBinSkip4(0x6e, var1, var2.soundaliases[0], 1, 1);
      }

      if(!var3 || getbcstate(var1) != "idle") {
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

  var8 = scripts\cp\utility::get_within_range(level.players[0].origin, var4, sqrt(level.bcs_maxstealthdistsqrdfromplayer));

  foreach(var6 in var8) {
    thread _playradioecho(var6, var2, var3, self, var4);
  }
}

function uselocationbc(var0) {
  var1 = getvalidlocation(self, "stealth", var0);

  if(isDefined(var1)) {
    return true;
  }

  return false;
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

  if(var3 && isDefined(var2.checkin) && getbcstate(var1) == "alert") {
    foreach(var5 in var2.responsealiases) {
      var2.soundaliases = [];
      var2.soundaliases[0] = var5;

      if(isradioline(var5)) {
        var3 = stealthcommander(var1, var2.soundaliases[0]);
      } else {
        commander_delay(var1);
        GscBinSkip4(0x6e, var1, var2.soundaliases[0], 1, 1);
      }

      if(!var3 || getbcstate(var1) != "alert") {
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

function stealthcommander(var0) {
  if(getDvar("bcs_commander_off") == self.team || getDvar("bcs_commander_off") == "all") {
    return false;
  }

  commander_delay();
  GscBinSkip4(0x35, var0, undefined, 1);
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
    var1 playSound(var1);
    wait lookupsoundlength(var1) / 1000;
  } else {
    battlechatter_printwarning("Tried to play an alias that doesn't exist: '" + var1 + "'.");
  }

  var1 delete();
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

function bcs_setup_countryids() {
  if(!isDefined(anim.usedids)) {
    anim.usedids = [];
    anim.flavorburstvoices = [];
    anim.countryids = [];
    bcs_setup_voice("unitednations", "UN", 6, 1);
    bcs_setup_voice("unitednationshelmet", "UN", 6, 1);
    bcs_setup_voice("unitednationsfemale", "UN", 3, 1);
    bcs_setup_voice("setdef", "SD", 5);
    bcs_setup_voice("unitedstates", "USM", 3, 1);
    bcs_setup_voice("unitedstatesfemale", "USMF", 1, 1);
    bcs_setup_voice("sas", "USM", 3, 1);
    bcs_setup_voice("sasfemale", "USMF", 1, 1);
    bcs_setup_voice("fsa", "FSA", 3, 1);
    bcs_setup_voice("fsafemale", "FSAF", 1, 1);

    switch (getDvar("bcs_forceEnglish")) {
      case "all":
      case "axis":
        bcs_setup_voice("alqatala", "USM", 3);
        bcs_setup_voice("alqatalafemale", "USMF", 1);
        bcs_setup_voice("russian", "USM", 3);
        break;
      default:
        bcs_setup_voice("alqatala", "AQ", 3);
        bcs_setup_voice("alqatalafemale", "AQF", 1);
        bcs_setup_voice("russian", "RU", 3);
        break;
    }

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
      set_battlechatter_variable(var1, 0);
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

function battlechatter_canprint() {
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

function battlechatter_draw_arrow(var0, var1, var2, var3) {
  var4 = var1 + anglesToForward(vectortoangles(var1 - var0)) * -40;
  var4 += anglestoright(vectortoangles(var1 - var0)) * 18;
  var4 = var1 + anglesToForward(vectortoangles(var1 - var0)) * -40;
  var4 += anglestoright(vectortoangles(var1 - var0)) * -18;
}

function battlechatter_canprintscreen() {
  return false;
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

function commander_delay() {
  wait randomfloatrange(0.3, 0.4);
}

function cansay(var0, var1, var2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(anim.player)) {
    return false;
  }

  if(isPlayer(self)) {
    if(!isDefined(anim.player.battlechatterallowed) || isDefined(anim.player.battlechatterallowed) && !anim.player.battlechatterallowed) {
      return false;
    }
  }

  if(var0 == "stealth") {
    if(distancesquared(anim.player.origin, self.origin) > level.bcs_maxstealthdistsqrdfromplayer) {
      return false;
    }
  } else if(distancesquared(anim.player.origin, self.origin) > level.bcs_maxtalkingdistsqrdfromplayer) {
    return false;
  }

  if(!isDefined(self.battlechatterallowed) || !self.battlechatterallowed || !isDefined(self.battlechatter.nextsaytimes)) {
    return false;
  }

  if(isDefined(var2) && var2 >= 1) {
    return true;
  }

  if(gettime() + anim.eventactionminwait[var0]["self"] < self.battlechatter.nextsaytimes[var0]) {
    return false;
  }

  if(gettime() + anim.eventactionminwait[var0]["squad"] < self.squad.nextsaytimes[var0]) {
    return false;
  }

  if(isDefined(var1) && typelimited(var0, var1)) {
    return false;
  }

  if(isDefined(var1) && anim.eventpriority[var0][var1] < self.battlechatter.minpriority) {
    return false;
  }

  if(issentient(self) && self.ignoreall) {
    return false;
  }

  if(isDefined(self.fnisinstealthidlescriptedanim) && self[[self.fnisinstealthidlescriptedanim]]()) {
    return false;
  }

  if(!isPlayer(self) && self isinscriptedstate()) {
    return false;
  }

  return true;
}

function getresponder(var0, var1, var2) {
  var3 = undefined;

  if(!isDefined(var2)) {
    var2 = "response";
  }

  if(!isDefined(self.squad)) {
    return;
  }

  var4 = scripts\engine\utility::array_randomize(self.squad.members);
  var0 *= var0;
  var1 *= var1;

  for(var5 = 0; var5 < var4.size; var5++) {
    if(var4[var5] == self) {
      continue;
    }

    if(!isalive(var4[var5])) {
      continue;
    }

    var6 = distancesquared(self.origin, var4[var5].origin);

    if(var6 < var0) {
      continue;
    }

    if(var6 > var1) {
      continue;
    }

    if(isusingsamevoice(var4[var5])) {
      continue;
    }

    if(!cansay(var4[var5], var2)) {
      continue;
    }

    var3 = var4[var5];

    if(cansayname(var3)) {
      break;
    }
  }

  return var3;
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

function bcsenabled() {
  if(isDefined(anim.chatinitialized)) {
    return anim.chatinitialized;
  }

  return 0;
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

function bc_prefix(var0) {
  if(!isDefined(self.battlechatter.npcid)) {
    self.battlechatter.npcid = "";
  }

  if(self == anim.player) {
    return "UN_plr_";
  }

  if(isDefined(var0) && var0 == "stealth") {
    if(getDvar("bcs_otnStealth") != "off") {
      return tolower("dx_otn_" + self.battlechatter.countryid + self.battlechatter.npcid + "_");
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

function namesaidrecently(var0) {
  if(anim.lastnamesaid[self.team] == var0.bcname || gettime() - anim.lastnamesaidtime[self.team] < anim.lastnamesaidtimeout) {
    return true;
  }

  return false;
}

function enemy_team_name() {
  if(issentient(self) && self isbadguy()) {
    return 1;
  }

  return 0;
}

function isusingsamevoice(var0) {
  if(!isDefined(var0.battlechatter)) {
    return 0;
  }

  if(isstring(self.battlechatter.npcid) && isstring(var0.battlechatter.npcid) && self.battlechatter.npcid == var0.battlechatter.npcid) {
    return 1;
  }

  if(!isstring(self.battlechatter.npcid) && !isstring(var0.battlechatter.npcid) && self.battlechatter.npcid == var0.battlechatter.npcid) {
    return 1;
  }

  return 0;
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

function updatecontact(var0, var1) {
  if(gettime() - self.squadlist[var0].lastcontact > 10000) {
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

function threatwasalreadycalledout(var0) {
  if(isDefined(var0.battlechatter.calledout) && isDefined(var0.battlechatter.calledout[self.squad.squadname])) {
    if(var0.battlechatter.calledout[self.squad.squadname].expiretime > gettime()) {
      return true;
    }
  }

  return false;
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
    return;
  }

  if(isDefined(self._blackboard) && isDefined(self._blackboard.idlenode)) {
    self.battlechatter.stealthidledelay = 5500 + gettime();
    return;
  }

  if(isDefined(self.battlechatter.isspeaking) && self.battlechatter.isspeaking) {
    return;
  }

  if(!isDefined(self.team) || isDefined(self.team) && self.team == "allies" && isDefined(anim.scripteddialoguestarttime)) {
    if(anim.scripteddialoguestarttime + anim.scripteddialoguebuffertime > gettime()) {
      return;
    }
  }

  if(friendlyfire_warning()) {
    return;
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
    case "stealth":
      thread playstealthevent();
      break;
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

function friendlyfire_warning() {
  if(!can_say_friendlyfire()) {
    return false;
  }

  dotypelimit("reaction", "friendlyfire");
  thread playreactionevent();
  return true;
}

function dotypelimit(var0, var1) {
  if(!isDefined(anim.eventtypeminwait[var0][var1])) {
    return;
  }

  self.squad.nexttypesaytimes[var0][var1] = gettime() + anim.eventtypeminwait[var0][var1];
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

function addthreatcalloutecho(var0, var1) {
  var2 = createechoalias(var0, var1);

  if(!soundexists(var2)) {
    battlechatter_printwarning("Can't find echo alias '" + var2 + "'.");
    return false;
  }

  self.soundaliases[self.soundaliases.size] = var2;
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
  var10 = var7 + getbcstate() + "_location_" + var3 + "_qa" + var9;

  if(!soundexists(var10)) {
    if(randomint(100) < anim.eventchance["response"]["callout_negative"]) {
      var0 scripts\cp\cp_battlechatter_ai::addresponseevent("callout", "neg", self.owner, 0.9);
    } else {
      var0 scripts\cp\cp_battlechatter_ai::addresponseevent("exposed", "acquired", self.owner, 0.9);
    }

    var2.qafinished = 1;
    return false;
  }

  var0 scripts\cp\cp_battlechatter_ai::addresponseevent("callout", "QA", self.owner, 0.9, var10, var2);
  self.soundaliases[self.soundaliases.size] = var10;
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
    var1 scripts\cp\cp_battlechatter_ai::addresponseevent("ack", "affirm", self, 0.9);
    return;
  }

  level notify("follow order", self);
}

function orderdisplace(var0) {
  self endon("death");
  self endon("removed from battleChatter");
  var1 = self;
  var2 = createchatphrase(var1);
  addorderalias(var2, "displace", var0);
  playphrase(var1, var2, self, 1);
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
    case "acquired":
    case "vehicle":
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

  if(self.team == "allies") {
    var9 = 0;

    if(var4.origin[2] - var7.origin[2] >= level.heightforhighcallout) {
      if(addpossiblethreatcallout("player_target_clock_high")) {
        var9 = 1;
      }
    }

    if(!var9) {
      if(var6 == "12") {
        addpossiblethreatcallout("player_obvious");

        if(var8 > level.mindistancecallout && var8 < level.maxdistancecallout) {
          addpossiblethreatcallout("player_distance");
        }
      }

      if(cansayplayername() && var6 != "12") {
        addpossiblethreatcallout("player_contact_clock");
        addpossiblethreatcallout("player_target_clock");
        addpossiblethreatcallout("player_cardinal");
      }
    }
  }

  var9 = 0;

  if(var4.origin[2] - var7.origin[2] >= level.heightforhighcallout) {
    if(addpossiblethreatcallout("ai_target_clock_high")) {
      var9 = 1;
    }
  }

  addpossiblethreatcallout("ai_casual_clock");

  if(!var9) {
    if(var6 == "12") {
      addpossiblethreatcallout("ai_distance");

      if(var8 > level.mindistancecallout && var8 < level.maxdistancecallout) {
        addpossiblethreatcallout("ai_obvious");
      }
    }

    addpossiblethreatcallout("ai_contact_clock");
    addpossiblethreatcallout("ai_target_clock");
    addpossiblethreatcallout("ai_cardinal");
  }

  if(isDefined(var5)) {
    if(canconcat(var5) && scripts\engine\utility::cointoss()) {
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

  var10 = getweightedchanceroll(self.possiblethreatcallouts, anim.threatcallouts);
  var11 = spawnStruct();
  var11.type = var10;
  var11.responder = var7;
  var11.responderclockdirection = var6;
  var11.playerclockdirection = var7;

  if(isDefined(var5)) {
    var11.location = var5;
  }

  return var11;
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

function getlocation() {
  var0 = get_all_my_locations();
  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = undefined;

  if(var0.size) {
    var1 = _getlocation(var0);
  }

  return var1;
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

function canconcat(var0) {
  var1 = var0.locationaliases;

  foreach(var3 in var1) {
    if(iscallouttypeconcat(var3, self)) {
      return true;
    }
  }

  return false;
}

function iscallouttypeconcat(var0, var1) {
  var0 = getloccalloutalias(var1, getbcstate() + "_location_concat_" + var0);

  if(soundexists(var0)) {
    return true;
  }

  return false;
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
          var3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("callout", "neg", self, 0.9);
        } else {
          var3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("exposed", "acquired", self, 0.9);
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
    case "player_obvious":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = anim.player;
      }

      addplayernamealias(var2);
      addthreatobviousalias(var2);
      break;
    case "player_distance":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = anim.player;
      }

      var7 = getdistancemetersnormalized(anim.player.origin, var0.origin);
      addplayernamealias(var2);
      addthreatdistancealias(var2, var7);
      break;
    case "player_contact_clock":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      addplayernamealias(var2);
      addthreatcalloutalias(var2, "contactclock", var3.playerclockdirection);
      break;
    case "player_target_clock":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      addplayernamealias(var2);
      addthreatcalloutalias(var2, "targetclock", var3.playerclockdirection);
      break;
    case "player_target_clock_high":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      addplayernamealias(var2);
      var8 = getdegreeselevation(anim.player.origin, var0.origin);

      if(var8 >= 20 && var8 <= 60) {
        addthreatcalloutalias(var2, "targetclock_high", var3.playerclockdirection);
        addthreatelevationalias(var2, var8);
      } else {
        return false;
      }

      break;
    case "player_cardinal":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      addplayernamealias(var2);
      var9 = getdirectioncompass(anim.player.origin, var0.origin);
      var10 = normalizecompassdirection(var9);

      if(var10 == "impossible") {
        return false;
      }

      addthreatcalloutalias(var2, "cardinal", var10);
      break;
    case "ai_obvious":
      if(isDefined(var3.responder) && cansayname(var3.responder)) {
        addnamealias(var2, var3.responder.bcname);
        var2.bc_looktarget = var3.responder;
      }

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      addthreatobviousalias(var2);
      addcalloutresponseevent(var2, self, var3, var0);
      break;
    case "ai_distance":
      var11 = self;

      if(self.team == "allies") {
        var11 = anim.player;
      } else if(isDefined(var3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var11 = var3.responder;
      }

      var7 = getdistancemetersnormalized(var11.origin, var0.origin);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      addthreatdistancealias(var2, var7);
      addcalloutresponseevent(var2, self, var3, var0);
      break;
    case "ai_contact_clock":
      var11 = self;

      if(self.team == "allies") {
        var11 = anim.player;
      } else if(isDefined(var3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var11 = var3.responder;
      }

      var12 = getrelativeangles(var11);
      var13 = getdirectionfacingclock(var12, var11.origin, var0.origin);
      addthreatcalloutalias(var2, "contactclock", var13);
      addcalloutresponseevent(var2, self, var3, var0);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
    case "ai_casual_clock":
      var11 = self;

      if(self.team == "allies") {
        var11 = anim.player;
      } else if(isDefined(var3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var11 = var3.responder;
      }

      var12 = getrelativeangles(var11);
      var13 = getdirectionfacingclock(var12, var11.origin, var0.origin);
      addthreatcalloutalias(var2, "contactclock", var13);
      addcalloutresponseevent(var2, self, var3, var0);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
    case "ai_target_clock":
      var11 = self;

      if(self.team == "allies") {
        var11 = anim.player;
      } else if(isDefined(var3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var11 = var3.responder;
      }

      var12 = getrelativeangles(var11);
      var13 = getdirectionfacingclock(var12, var11.origin, var0.origin);
      addthreatcalloutalias(var2, "targetclock", var13);
      addcalloutresponseevent(var2, self, var3, var0);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
    case "ai_target_clock_high":
      var11 = self;

      if(self.team == "allies") {
        var11 = anim.player;
      } else if(isDefined(var3.responder) && randomint(100) < anim.eventchance["response"]["callout"]) {
        var11 = var3.responder;
      }

      var12 = getrelativeangles(var11);
      var13 = getdirectionfacingclock(var12, var11.origin, var0.origin);
      var8 = getdegreeselevation(var11.origin, var0.origin);

      if(var8 >= 20 && var8 <= 60) {
        addthreatcalloutalias(var2, "targetclock_high", var13);
        addthreatelevationalias(var2, var8);
      } else {
        return false;
      }

      addcalloutresponseevent(var2, self, var3, var0);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
    case "ai_cardinal":
      var11 = self;

      if(self.team == "allies") {
        var11 = anim.player;
      }

      var9 = getdirectioncompass(var11.origin, var0.origin);
      var10 = normalizecompassdirection(var9);

      if(var10 == "impossible") {
        return false;
      }

      addthreatcalloutalias(var2, "cardinal", var10);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
    case "generic_location":
      var6 = self;
      var11 = self;

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      var14 = threatinfantry_docalloutlocation(var2, var3, undefined, var6);

      if(!var14) {
        return false;
      }

      if(self.team == "allies") {
        var11 = anim.player;
      }

      addconcatdirectionalias(var2, var11, var0);
      addcalloutresponseevent(var2, self, var3, var0);
      break;
    case "player_location":
      var6 = self;
      addplayernamealias(var2);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = anim.player;
      }

      var14 = threatinfantry_docalloutlocation(var2, var3, undefined, var6);

      if(!var14) {
        return false;
      }

      break;
    case "concat_location":
      var15 = 0;

      if(randomint(3)) {
        var15 = 1;
        addconcattargetalias(var2, var0);
      }

      var6 = self;
      var11 = self;

      if(self.team == "allies") {
        var11 = anim.player;
      }

      var14 = threatinfantry_docalloutlocation(var2, var3, 1, var6);

      if(!var14) {
        return false;
      }

      if(!var15) {
        addconcatdirectionalias(var2, var11, var0);
      } else if(randomint(3)) {
        addconcatdirectionalias(var2, var11, var0);
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

      var14 = threatinfantry_docalloutlocation(var2, var3, undefined, var6);

      if(!var14) {
        return false;
      }

      var16 = var2.soundaliases.size - 1;
      var17 = var2.soundaliases[var16];

      if(iscallouttypereport(var17)) {
        var3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("callout", "echo", self, 0.9, var17);
      } else if(iscallouttypeqa(var17, self)) {
        var3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("callout", "QA", self, 0.9, var17, var3.location);
      } else if(randomint(100) < anim.eventchance["response"]["callout_negative"]) {
        var3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("callout", "neg", self, 0.9);
      } else {
        var3.responder scripts\cp\cp_battlechatter_ai::addresponseevent("exposed", "acquired", self, 0.9);
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

function addthreatobviousalias() {
  var0 = getbattlechatteralias(self.owner, "order_suppress");
  self.soundaliases[self.soundaliases.size] = var0;
  return true;
}

function addthreatcalloutalias(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  }

  var2 = undefined;

  if(self.owner == anim.player) {
    if(var0 == "acquired" || var0 == "sighted") {
      var2 = self.owner.battlechatter.countryid + "_plr_target_" + var0;
    } else {
      var2 = self.owner.battlechatter.countryid + "_plr_callout_" + var0 + var1;
    }
  } else {
    var2 = getbattlechatteralias(self.owner, "threat_callout_" + var0) + var1;
  }

  self.soundaliases[self.soundaliases.size] = var2;
  return true;
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

function addplayernamealias() {
  if(!cansayplayername(self.owner)) {
    return;
  }

  anim.lastplayernamecalltime = gettime();
  var0 = bc_prefix(self.owner) + "name_player_" + anim.player.bccountryid + "_" + anim.player.bcnameid;
  self.soundaliases[self.soundaliases.size] = var0;
  self.bc_looktarget = anim.player;
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

  return "100";
}

function addthreatdistancealias(var0) {
  var1 = getbattlechatteralias(self.owner, "contact_dist") + var0;
  self.soundaliases[self.soundaliases.size] = var1;
  return true;
}

function addnamealias(var0) {
  if(self.owner == anim.player) {} else {
    self.soundaliases[self.soundaliases.size] = bc_prefix(self.owner) + "name_" + var0;
  }

  anim.lastnamesaid[self.owner.team] = var0;
  anim.lastnamesaidtime[self.owner.team] = gettime();
}

function doexposedcalloutresponse(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  switch (var0.battlechatter.countryid) {
    case "FSAW":
    case "SASW":
    case "USMW":
    case "FSA":
    case "USM":
    case "SAS":
      break;
    default:
      return false;
  }

  if(randomint(100) > anim.eventchance["response"]["exposed"]) {
    return false;
  }

  return true;
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

function addthreatelevationalias(var0) {
  var1 = getbattlechatteralias(self.owner, "contact_elev") + var0;
  self.soundaliases[self.soundaliases.size] = var1;
  return true;
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

  if(!bccansee(var1.responder, var2) && randomint(100) < anim.eventchance["response"]["callout_negative"]) {} else {
    var3 = "affirm";

    if(isDefined(var1.location)) {
      var5 = getvalidlocation(var2, var1.responder, "response");

      if(isDefined(var5) && isDefined(var5.locationaliases[0])) {
        var3 = var5.locationaliases[0];
        var4 = "location";
      }
    }
  }

  var1.responder scripts\cp\cp_battlechatter_ai::addresponseevent(var4, var3, var0, 0.9);
}

function bccansee(var0) {
  if(!isDefined(self)) {
    return false;
  } else if(isPlayer(self)) {
    if(scripts\anim\utility_common::player_can_see_ai(self, var0)) {
      return true;
    }
  } else if(self cansee(var0)) {
    return true;
  }

  return false;
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

function createleaderalias(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  } else {
    var1 = "_" + var1;
  }

  var2 = strtok(var0, "_");
  GscBinSkip0(0x2e, 2, self.battlechatter.countryid + "l1");
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
        var4 = getloccalloutalias(getbcstate() + "_location_" + var2 + "_" + var4 + "_");
        var4 = createleaderalias(var4, var6);
      } else {
        var4 = getloccalloutalias(getbcstate() + "_location_" + var2 + "_" + var4 + "_" + randomintrange_otn(1));
      }

      var7 = soundexists(var4);
    } else if(var1 == "response") {
      var5 = getloccalloutalias(getbcstate() + "_location_resp_" + var4);
      var7 = soundexists(var5);
    } else {
      var5 = getloccalloutalias(getbcstate() + "_location_callout_" + var4);
      var8 = getqacalloutalias(var4, 0);
      var9 = getloccalloutalias(getbcstate() + "_location_concat_" + var4);
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

function randomintrange_otn(var0, var1) {
  if(getDvar("bcs_otnStealth") != "off") {
    return "01";
  }

  if(isDefined(var0)) {
    if(isDefined(var1)) {
      return (randomintrange(var0, var1) * 1);
    }

    return "01";
  }
}

function location_called_out_ever(var0) {
  var1 = location_get_last_callout_time(var0);

  if(!isDefined(var1)) {
    return false;
  }

  return true;
}

function _getlocation(var0, var1) {
  foreach(var3 in var0) {
    if(!location_called_out_ever(var3)) {
      if(isDefined(var3.islandmark)) {
        return var3;
      }
    }
  }

  foreach(var3 in var0) {
    if(!location_called_out_recently(var3, var1) && isDefined(var3.islandmark) && randomint(3) == 0) {
      return var3;
    }

    if(!location_called_out_ever(var3)) {
      return var3;
    }
  }

  foreach(var3 in var0) {
    if(!location_called_out_recently(var3, var1)) {
      return var3;
    }
  }

  return undefined;
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

function addthreatexposedalias(var0) {
  if(var0 == "group") {
    var0 = "movement_group";
  }

  var1 = getbattlechatteralias(self.owner, "exposed_" + var0);
  self.soundaliases[self.soundaliases.size] = var1;
  return true;
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

function bcgetclaimednode() {
  if(isPlayer(self)) {
    return self.node;
  }

  return scripts\anim\utility_common::getclaimednode();
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
      continue;
    }

    wait 0.05;
  }
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

function threatinfantry_docalloutlocation(var0, var1, var2) {
  var3 = addthreatcalloutlocationalias(var0.location, var1, var2);
  return var3;
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
    var7 = getloccalloutalias(self.owner, getbcstate() + "_location_concat_" + var5);
  } else if(!isDefined(var0.qafinished) && iscallouttypeqa(var5, self.owner)) {
    var7 = getqacalloutalias(self.owner, var5, 0);
  } else {
    var7 = getloccalloutalias(self.owner, getbcstate() + "_location_callout_" + var5);
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
        var10 = getdistancemetersnormalized( < error > .origin, < error > .origin); <
        error > = getbattlechatteralias(self.owner, "concat_dist") + var10;
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

function battlechatter_printwarning(var0) {}

function battlechatter_printerror(var0) {}

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

function iscallouttypereport(var0) {
  return issubstr(var0, "_report");
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
    if(getbcstate() == "combat") {
      var1 = bc_prefix();
    } else {
      var1 = bc_prefix("stealth");
    }

    var1 += var0;
  }

  return var1;
}

function getqacalloutalias(var0, var1) {
  var2 = getloccalloutalias(getbcstate() + "_location_callout_" + var0);
  var2 += "_qa" + var1;
  return var2;
}

function setlastcallouttype(var0) {
  anim.lastteamthreatcallout[self.team] = var0;
  anim.lastteamthreatcallouttime[self.team] = gettime();
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

  if(var0 == "grenade" || var0 == "shock" || var0 == "ant" || var0 == "seek") {
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

function getbattlechatteralias(var0) {
  var1 = undefined;
  var2 = bc_prefix();

  switch (var0) {
    case "check_fire":
      var1 = var2 + "response_check_fire";
      break;
    case "concat_clock":
      var1 = var2 + getbcstate() + "_concat_clock_";
      break;
    case "concat_compass":
      var1 = var2 + getbcstate() + "_concat_compass_";
      break;
    case "concat_dist":
      var1 = var2 + getbcstate() + "_concat_dist_";
      break;
    case "concat_elev":
      var1 = var2 + getbcstate() + "_concat_elev_";
      break;
    case "concat_left":
      var1 = var2 + getbcstate() + "_concat_left";
      break;
    case "concat_right":
      var1 = var2 + getbcstate() + "_concat_right";
      break;
    case "concat_center":
      var1 = var2 + getbcstate() + "_concat_center";
      break;
    case "concat_target":
      var1 = var2 + getbcstate() + "_concat_target";
      break;
    case "contact_dist":
      var1 = var2 + "contact_dist_";
      break;
    case "contact_elev":
      var1 = var2 + "contact_elev_";
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
    case "inform_frag":
    case "inform_grenade":
      var1 = var2 + "inform_grenade";
      break;
    case "inform_incoming_grenade":
      var1 = var2 + "inform_incoming_grenade";
      break;
    case "inform_killfirm_juggernaut":
    case "inform_killfirm_soldier":
      var1 = var2 + "inform_killfirm_soldier";
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
    case "location_response":
      var1 = var2 + getbcstate() + "_location_resp";
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
    case "threat_callout_cardinal":
      var1 = var2 + "cardinal_";
      break;
    case "threat_callout_contactclock":
      var1 = var2 + "contact_clock_";
      break;
    case "threat_callout_sighted":
      var1 = var2 + "sighted_";
      break;
    case "threat_callout_targetclock":
      var1 = var2 + "target_clock_";
      break;
    case "threat_callout_targetclock_high":
      var1 = var2 + "target_clock_high_";
      break;
    default:
      break;
  }

  return var1;
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
    case "underfire":
    case "maneuver":
    case "danger":
    case "casualty":
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
              var3 scripts\cp\cp_battlechatter_ai::addreactionevent("ask_ok", undefined, self, 1);
            }
          } else {
            var3 scripts\cp\cp_battlechatter_ai::addresponseevent("covering", "fire", self, 1);
          }
        }
      }

      break;
    case "ask_ok":
      responsetakingfire(var0, "ask", "ok");
      var3 = getresponder(64, 1024, "response");

      if(isDefined(var3)) {
        var3 scripts\cp\cp_battlechatter_ai::addresponseevent("im", "ok", self, 1);
      }

      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
  }

  self notify("done speaking");
}

function responsetakingfire(var0, var1, var2) {
  var3 = self;
  var3 endon("death");
  var3 endon("removed from battleChatter");
  var4 = createchatphrase(var3);
  addresponsealias(var4, var1, var2);
  playphrase(var3, var4, self);
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

function addhostileburstalias() {
  var0 = getbattlechatteralias(self.owner, "reaction_hostile_burst");

  if(soundexists(var0)) {
    self.soundaliases[self.soundaliases.size] = var0;
  }

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

function printqueueevent(var0) {
  var1 = gettime();

  if(self.battlechatter.chatqueue[var0].expiretime > 0 && !isDefined(self.battlechatter.chatqueue[var0].printed)) {
    if(var1 > self.battlechatter.chatqueue[var0].expiretime) {}

    self.battlechatter.chatqueue[var0].printed = 1;
    return;
  }
}

function getbcstate() {
  if(isDefined(self.fnisinstealthidle) && [[self.fnisinstealthidle]]()) {
    if(isDefined(self.demeanoroverride) && self.demeanoroverride == "alert") {
      return "alert";
    }

    return "idle";
  }

  if(isDefined(self.fnisinstealthinvestigate) && [[self.fnisinstealthinvestigate]]()) {
    return "investigate";
  }

  if(isDefined(self.fnisinstealthhunt) && [[self.fnisinstealthhunt]]()) {
    return "hunt";
  }

  if(isDefined(self.fnisinstealthcombat) && [[self.fnisinstealthcombat]]()) {
    return "combat";
  }

  return "combat";
}

function set_battlechatter_variable(var0, var1) {
  level.battlechatter[var0] = var1;
  update_battlechatter_hud();
}

function update_battlechatter_hud() {}

function bcprint_info() {
  self endon("death");
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
  anim.player thread scripts\cp\cp_battlechatter_ai::addtosystem();
  var0 = getaiarray();

  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1] scripts\cp\cp_battlechatter_ai::addtosystem();
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

    var0[var1] scripts\cp\cp_battlechatter_ai::removefromsystem();
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

function shutdowncontact(var0) {
  self.squadlist[var0].calledout = undefined;
  self.squadlist[var0].firstcontact = undefined;
  self.squadlist[var0].lastcontact = undefined;
}

function getrank() {
  return self.airank;
}

function pointinfov(var0) {
  return scripts\engine\utility::within_fov(self.origin, self.angles, var0, 0.766);
}