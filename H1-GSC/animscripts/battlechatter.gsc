/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\battlechatter.gsc
*****************************************/

init_battlechatter() {
  if(isdefined(anim.chatinitialized) && anim.chatinitialized) {
    return;
  }
  if(getdvar("bcs_enable") == "")
    setdvar("bcs_enable", "on");

  if(getdvar("bcs_enable") == "off") {
    anim.chatinitialized = 0;
    anim.player.chatinitialized = 0;
    return;
  }

  anim.chatinitialized = 1;
  anim.player.chatinitialized = 0;

  if(getdvar("bcs_filterThreat") == "")
    setdvar("bcs_filterThreat", "off");

  if(getdvar("bcs_filterInform") == "")
    setdvar("bcs_filterInform", "off");

  if(getdvar("bcs_filterOrder") == "")
    setdvar("bcs_filterOrder", "off");

  if(getdvar("bcs_filterReaction") == "")
    setdvar("bcs_filterReaction", "off");

  if(getdvar("bcs_filterResponse") == "")
    setdvar("bcs_filterResponse", "off");

  if(getdvar("bcs_threatLimitTargettedBySelf") == "")
    setdvar("bcs_threatLimitTargettedBySelf", "off");

  if(getdvar("bcs_threatLimitTargetingPlayer") == "")
    setdvar("bcs_threatLimitTargetingPlayer", "off");

  if(getdvar("bcs_threatLimitInPlayerFOV") == "")
    setdvar("bcs_threatLimitInPlayerFOV", "on");

  if(getdvar("bcs_threatLimitInLocation") == "")
    setdvar("bcs_threatLimitInLocation", "on");

  if(getdvar("bcs_threatLimitSpeakerDist") == "")
    setdvar("bcs_threatLimitSpeakerDist", "512");

  if(getdvar("bcs_threatLimitThreatDist") == "")
    setdvar("bcs_threatLimitThreatDist", "2048");

  if(getdvar("bcs_threatPlayerRelative") == "")
    setdvar("bcs_threatPlayerRelative", "off");

  if(getdvar("debug_bcprint") == "")
    setdvar("debug_bcprint", "off");

  if(getdvar("debug_bcshowqueue") == "")
    setdvar("debug_bcshowqueue", "off");

  if(getdvar("debug_bcprintdump") == "")
    setdvar("debug_bcprintdump", "off");

  anim.countryids["british"] = "UK";
  anim.countryids["american"] = "US";
  anim.countryids["russian"] = "RU";
  anim.countryids["arab"] = "AB";
  anim.usedids = [];
  anim.usedids["russian"] = [];
  anim.usedids["russian"][0] = spawnstruct();
  anim.usedids["russian"][0].count = 0;
  anim.usedids["russian"][0].npcid = "0";
  anim.usedids["russian"][1] = spawnstruct();
  anim.usedids["russian"][1].count = 0;
  anim.usedids["russian"][1].npcid = "1";
  anim.usedids["russian"][2] = spawnstruct();
  anim.usedids["russian"][2].count = 0;
  anim.usedids["russian"][2].npcid = "3";
  anim.usedids["british"] = [];
  anim.usedids["british"][0] = spawnstruct();
  anim.usedids["british"][0].count = 0;
  anim.usedids["british"][0].npcid = "0";
  anim.usedids["british"][1] = spawnstruct();
  anim.usedids["british"][1].count = 0;
  anim.usedids["british"][1].npcid = "1";
  anim.usedids["british"][2] = spawnstruct();
  anim.usedids["british"][2].count = 0;
  anim.usedids["british"][2].npcid = "2";
  anim.usedids["british"][3] = spawnstruct();
  anim.usedids["british"][3].count = 0;
  anim.usedids["british"][3].npcid = "3";
  anim.usedids["american"] = [];
  anim.usedids["american"][0] = spawnstruct();
  anim.usedids["american"][0].count = 0;
  anim.usedids["american"][0].npcid = "0";
  anim.usedids["american"][1] = spawnstruct();
  anim.usedids["american"][1].count = 0;
  anim.usedids["american"][1].npcid = "1";
  anim.usedids["american"][2] = spawnstruct();
  anim.usedids["american"][2].count = 0;
  anim.usedids["american"][2].npcid = "2";
  anim.usedids["arab"] = [];
  anim.usedids["arab"][0] = spawnstruct();
  anim.usedids["arab"][0].count = 0;
  anim.usedids["arab"][0].npcid = "0";
  anim.usedids["arab"][1] = spawnstruct();
  anim.usedids["arab"][1].count = 0;
  anim.usedids["arab"][1].npcid = "1";
  anim.usedids["arab"][2] = spawnstruct();
  anim.usedids["arab"][2].count = 0;
  anim.usedids["arab"][2].npcid = "2";
  anim.usedids["arab"][3] = spawnstruct();
  anim.usedids["arab"][3].count = 0;
  anim.usedids["arab"][3].npcid = "3";
  anim.eventtypeminwait = [];
  anim.eventtypeminwait["threat"] = [];
  anim.eventtypeminwait["response"] = [];
  anim.eventtypeminwait["reaction"] = [];
  anim.eventtypeminwait["order"] = [];
  anim.eventtypeminwait["inform"] = [];
  anim.eventtypeminwait["custom"] = [];
  anim.eventtypeminwait["direction"] = [];

  if(isdefined(level._stealth)) {
    anim.eventactionminwait["threat"]["self"] = 20000;
    anim.eventactionminwait["threat"]["squad"] = 30000;
  } else {
    anim.eventactionminwait["threat"]["self"] = 12000;
    anim.eventactionminwait["threat"]["squad"] = 8000;
  }

  anim.eventactionminwait["response"]["self"] = 1000;
  anim.eventactionminwait["response"]["squad"] = 1000;
  anim.eventactionminwait["reaction"]["self"] = 1000;
  anim.eventactionminwait["reaction"]["squad"] = 1000;
  anim.eventactionminwait["order"]["self"] = 8000;
  anim.eventactionminwait["order"]["squad"] = 40000;
  anim.eventactionminwait["inform"]["self"] = 6000;
  anim.eventactionminwait["inform"]["squad"] = 8000;
  anim.eventactionminwait["custom"]["self"] = 0;
  anim.eventactionminwait["custom"]["squad"] = 5000;
  anim.eventtypeminwait["reaction"]["casualty"] = 20000;
  anim.eventtypeminwait["reaction"]["taunt"] = 200000;
  anim.eventtypeminwait["inform"]["reloading"] = 20000;
  anim.eventpriority["threat"]["infantry"] = 0.5;
  anim.eventpriority["threat"]["vehicle"] = 0.7;
  anim.eventpriority["response"]["killfirm"] = 0.8;
  anim.eventpriority["response"]["ack"] = 0.9;
  anim.eventpriority["reaction"]["casualty"] = 0.5;
  anim.eventpriority["reaction"]["taunt"] = 0.9;
  anim.eventpriority["order"]["cover"] = 0.9;
  anim.eventpriority["order"]["action"] = 0.5;
  anim.eventpriority["order"]["move"] = 0.9;
  anim.eventpriority["order"]["displace"] = 0.5;
  anim.eventpriority["inform"]["killfirm"] = 0.6;
  anim.eventpriority["inform"]["attack"] = 0.9;
  anim.eventpriority["inform"]["incoming"] = 0.8;
  anim.eventpriority["inform"]["reloading"] = 0.2;
  anim.eventpriority["inform"]["suppressed"] = 0.2;
  anim.eventpriority["custom"]["generic"] = 1.0;
  anim.eventduration["threat"]["infantry"] = 1000;
  anim.eventduration["threat"]["vehicle"] = 1000;
  anim.eventduration["response"]["killfirm"] = 3000;
  anim.eventduration["response"]["ack"] = 2000;
  anim.eventduration["reaction"]["casualty"] = 2000;
  anim.eventduration["reaction"]["taunt"] = 2000;
  anim.eventduration["order"]["cover"] = 3000;
  anim.eventduration["order"]["action"] = 3000;
  anim.eventduration["order"]["move"] = 3000;
  anim.eventduration["order"]["displace"] = 3000;
  anim.eventduration["inform"]["killfirm"] = 1000;
  anim.eventduration["inform"]["attack"] = 1000;
  anim.eventduration["inform"]["incoming"] = 1000;
  anim.eventduration["inform"]["reloading"] = 1000;
  anim.eventduration["inform"]["suppressed"] = 2000;
  anim.eventduration["custom"]["generic"] = 1000;
  anim.chatcount = 0;
  anim.moveorigin = spawn("script_origin", (0, 0, 0));
  anim.areas = getentarray("trigger_location", "targetname");
  anim.locations = getentarray("trigger_location", "targetname");
  anim.landmarks = getentarray("trigger_landmark", "targetname");
  anim.squadcreatefuncs[anim.squadcreatefuncs.size] = ::init_squadbattlechatter;
  anim.squadcreatestrings[anim.squadcreatestrings.size] = "::init_squadBattleChatter";
  anim.isteamspeaking["allies"] = 0;
  anim.isteamsaying["allies"]["threat"] = 0;
  anim.isteamsaying["allies"]["order"] = 0;
  anim.isteamsaying["allies"]["reaction"] = 0;
  anim.isteamsaying["allies"]["response"] = 0;
  anim.isteamsaying["allies"]["inform"] = 0;
  anim.isteamsaying["allies"]["custom"] = 0;
  anim.isteamspeaking["axis"] = 0;
  anim.isteamsaying["axis"]["threat"] = 0;
  anim.isteamsaying["axis"]["order"] = 0;
  anim.isteamsaying["axis"]["reaction"] = 0;
  anim.isteamsaying["axis"]["response"] = 0;
  anim.isteamsaying["axis"]["inform"] = 0;
  anim.isteamsaying["axis"]["custom"] = 0;
  anim.isteamspeaking["neutral"] = 0;
  anim.isteamsaying["neutral"]["threat"] = 0;
  anim.isteamsaying["neutral"]["order"] = 0;
  anim.isteamsaying["neutral"]["reaction"] = 0;
  anim.isteamsaying["neutral"]["response"] = 0;
  anim.isteamsaying["neutral"]["inform"] = 0;
  anim.isteamsaying["neutral"]["custom"] = 0;

  if(!isdefined(level.battlechatter)) {
    level.battlechatter = [];
    level.battlechatter["allies"] = 1;
    level.battlechatter["axis"] = 1;
    level.battlechatter["neutral"] = 1;
  }

  anim.lastteamspeaktime = [];
  anim.lastteamspeaktime["allies"] = -5000;
  anim.lastteamspeaktime["axis"] = -5000;

  for (var_0 = 0; var_0 < anim.squadindex.size; var_0++) {
    if(isdefined(anim.squadindex[var_0].chatinitialized) && anim.squadindex[var_0].chatinitialized) {
      continue;
    }
    anim.squadindex[var_0] init_squadbattlechatter();
  }

  level notify("battlechatter initialized");
  anim notify("battlechatter initialized");
}

shutdown_battlechatter() {
  anim.countryids = undefined;
  anim.eventtypeminwait = undefined;
  anim.eventactionminwait = undefined;
  anim.eventtypeminwait = undefined;
  anim.eventpriority = undefined;
  anim.eventduration = undefined;
  anim.chatcount = undefined;
  anim.moveorigin = undefined;
  anim.areas = undefined;
  anim.locations = undefined;
  anim.landmarks = undefined;
  anim.usedids = undefined;
  anim.chatinitialized = 0;
  anim.player.chatinitialized = 0;
  level.battlechatter = undefined;

  for (var_0 = 0; var_0 < anim.squadcreatefuncs.size; var_0++) {
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

init_squadbattlechatter() {
  var_0 = self;
  var_0.numspeakers = 0;
  var_0.maxspeakers = 1;
  var_0.nextsaytime = gettime() + 50;
  var_0.nextsaytimes["threat"] = gettime() + 50;
  var_0.nextsaytimes["order"] = gettime() + 50;
  var_0.nextsaytimes["reaction"] = gettime() + 50;
  var_0.nextsaytimes["response"] = gettime() + 50;
  var_0.nextsaytimes["inform"] = gettime() + 50;
  var_0.nextsaytimes["custom"] = gettime() + 50;
  var_0.nexttypesaytimes["threat"] = [];
  var_0.nexttypesaytimes["order"] = [];
  var_0.nexttypesaytimes["reaction"] = [];
  var_0.nexttypesaytimes["response"] = [];
  var_0.nexttypesaytimes["inform"] = [];
  var_0.nexttypesaytimes["custom"] = [];
  var_0.ismembersaying["threat"] = 0;
  var_0.ismembersaying["order"] = 0;
  var_0.ismembersaying["reaction"] = 0;
  var_0.ismembersaying["response"] = 0;
  var_0.ismembersaying["inform"] = 0;
  var_0.ismembersaying["custom"] = 0;
  var_0.lastdirection = "";
  var_0.memberaddfuncs[var_0.memberaddfuncs.size] = animscripts\battlechatter_ai::addtosystem;
  var_0.memberaddstrings[var_0.memberaddstrings.size] = "::addToSystem";
  var_0.memberremovefuncs[var_0.memberremovefuncs.size] = animscripts\battlechatter_ai::removefromsystem;
  var_0.memberremovestrings[var_0.memberremovestrings.size] = "::removeFromSystem";
  var_0.squadupdatefuncs[var_0.squadupdatefuncs.size] = ::initcontact;
  var_0.squadupdatestrings[var_0.squadupdatestrings.size] = "::initContact";

  for (var_1 = 0; var_1 < anim.squadindex.size; var_1++)
    var_0 thread initcontact(anim.squadindex[var_1].squadname);

  var_0 thread animscripts\battlechatter_ai::squadthreatwaiter();
  var_0 thread animscripts\battlechatter_ai::squadofficerwaiter();
  var_0.chatinitialized = 1;
  var_0 notify("squad chat initialized");
}

shutdown_squadbattlechatter() {
  var_0 = self;
  var_0.numspeakers = undefined;
  var_0.maxspeakers = undefined;
  var_0.nextsaytime = undefined;
  var_0.nextsaytimes = undefined;
  var_0.nexttypesaytimes = undefined;
  var_0.ismembersaying = undefined;

  for (var_1 = 0; var_1 < var_0.memberaddfuncs.size; var_1++) {
    if(var_0.memberaddstrings[var_1] != "::addToSystem") {
      continue;
    }
    if(var_1 != var_0.memberaddfuncs.size - 1) {
      var_0.memberaddfuncs[var_1] = var_0.memberaddfuncs[var_0.memberaddfuncs.size - 1];
      var_0.memberaddstrings[var_1] = var_0.memberaddstrings[var_0.memberaddstrings.size - 1];
    }

    var_0.memberaddfuncs[var_0.memberaddfuncs.size - 1] = undefined;
    var_0.memberaddstrings[var_0.memberaddstrings.size - 1] = undefined;
  }

  for (var_1 = 0; var_1 < var_0.memberremovefuncs.size; var_1++) {
    if(var_0.memberremovestrings[var_1] != "::removeFromSystem") {
      continue;
    }
    if(var_1 != var_0.memberremovefuncs.size - 1) {
      var_0.memberremovefuncs[var_1] = var_0.memberremovefuncs[var_0.memberremovefuncs.size - 1];
      var_0.memberremovestrings[var_1] = var_0.memberremovestrings[var_0.memberremovestrings.size - 1];
    }

    var_0.memberremovefuncs[var_0.memberremovefuncs.size - 1] = undefined;
    var_0.memberremovestrings[var_0.memberremovestrings.size - 1] = undefined;
  }

  for (var_1 = 0; var_1 < var_0.squadupdatefuncs.size; var_1++) {
    if(var_0.squadupdatestrings[var_1] != "::initContact") {
      continue;
    }
    if(var_1 != var_0.squadupdatefuncs.size - 1) {
      var_0.squadupdatefuncs[var_1] = var_0.squadupdatefuncs[var_0.squadupdatefuncs.size - 1];
      var_0.squadupdatestrings[var_1] = var_0.squadupdatestrings[var_0.squadupdatestrings.size - 1];
    }

    var_0.squadupdatefuncs[var_0.squadupdatefuncs.size - 1] = undefined;
    var_0.squadupdatestrings[var_0.squadupdatestrings.size - 1] = undefined;
  }

  for (var_1 = 0; var_1 < anim.squadindex.size; var_1++)
    var_0 shutdowncontact(anim.squadindex[var_1].squadname);

  var_0.chatinitialized = 0;
}

bcsenabled() {
  return anim.chatinitialized;
}

bcsdebugwaiter() {
  var_0 = getdvar("bcs_enable");

  for (;;) {
    var_1 = getdvar("bcs_enable");

    if(var_1 != var_0) {
      switch (var_1) {
        case "on":
          if(!anim.chatinitialized)
            enablebattlechatter();

          break;
        case "off":
          if(anim.chatinitialized)
            disablebattlechatter();

          break;
      }

      var_0 = var_1;
    }

    wait 1.0;
  }
}

enablebattlechatter() {
  init_battlechatter();
  anim.player thread animscripts\battlechatter_ai::addtosystem();
  var_0 = getaiarray();

  for (var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] animscripts\battlechatter_ai::addtosystem();
}

disablebattlechatter() {
  shutdown_battlechatter();
  var_0 = getaiarray();

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isdefined(var_0[var_1].squad) && var_0[var_1].squad.chatinitialized)
      var_0[var_1].squad shutdown_squadbattlechatter();

    var_0[var_1] animscripts\battlechatter_ai::removefromsystem();
  }
}

playbattlechatter() {
  if(!bcsenabled()) {
    return;
  }
  if(!self.battlechatter) {
    return;
  }
  if(self.isspeaking) {
    return;
  }
  if(self._animactive > 0) {
    return;
  }
  if(self.squad.numspeakers >= self.squad.maxspeakers) {
    return;
  }
  if(anim.isteamspeaking[self.team]) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  var_0 = gethighestpriorityevent();

  if(!isdefined(var_0)) {
    return;
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
  }
}

playthreatevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("cancel speaking");
  self.curevent = self.chatqueue["threat"];
  var_0 = self.chatqueue["threat"].threat;

  if(!isalive(var_0) || isdefined(var_0.calledout) && isdefined(var_0.calledout[self.squad.squadname])) {
    return;
  }
  anim thread lockaction(self, "threat");

  switch (self.chatqueue["threat"].eventtype) {
    case "infantry":
      if(var_0 == level.player || !isdefined(var_0 getturret()))
        threatinfantry(var_0);

      break;
    case "dog":
      threatdog(var_0);
      break;
    case "vehicle":
      break;
  }

  self notify("done speaking");

  if(!isalive(var_0)) {
    return;
  }
  var_0.calledout[self.squad.squadname] = spawnstruct();
  var_0.calledout[self.squad.squadname].spotter = self;
  var_0.calledout[self.squad.squadname].threattype = self.chatqueue["threat"].eventtype;
  var_0.calledout[self.squad.squadname].expiretime = gettime() + 3000;

  if(isdefined(var_0.squad))
    self.squad.squadlist[var_0.squad.squadname].calledout = 1;
}

threatinfantry(var_0, var_1) {
  self endon("cancel speaking");
  var_2 = createchatphrase();
  var_2.master = 1;

  if(!isdefined(var_1))
    var_2.forcedetail = 0;
  else
    var_2.forcedetail = var_1;

  var_2.threatent = var_0;

  if(self.voice == "british") {
    if(var_0 animscripts\pain::weaponanims() == "rocketlauncher")
      var_2 threatinfantryrpg(var_0);
    else {
      var_3 = getdirectioncompass(self.origin, var_0.origin);

      switch (var_3) {
        case "northwest":
          var_3 = "nthwest";

          if(var_3 == self.squad.lastdirection)
            var_3 = "generic";

          break;
        case "northeast":
          var_3 = "ntheast";

          if(var_3 == self.squad.lastdirection)
            var_3 = "generic";

          break;
        case "southwest":
          var_3 = "sthwest";

          if(var_3 == self.squad.lastdirection)
            var_3 = "generic";

          break;
        case "southeast":
          var_3 = "stheast";

          if(var_3 == self.squad.lastdirection)
            var_3 = "generic";

          break;
        case "impossible":
          var_3 = "generic";
      }

      self.squad.lastdirection = var_3;
      var_2 addthreatalias(1.0, "infantry", var_3);
    }
  } else if(var_0 animscripts\pain::weaponanims() == "rocketlauncher")
    var_2 threatinfantryrpg(var_0);
  else if(var_0 animscripts\pain::weaponanims() == "mg")
    var_2 threatinfantrymg(var_0);
  else if(var_0 isexposed() && !isdefined(var_0 getlandmark()))
    var_2 threatinfantryexposed(var_0);
  else if(!isdefined(var_0 getlocation()) && !isdefined(var_0 getlandmark())) {
    var_2 addthreatalias(1.0, "infantry", "generic");
    var_2 adddirectionalias(1.0, "relative", var_0);
    var_2 addareaalias(0.5, var_0);
  } else {
    var_2 addthreatalias(1.0, "infantry", "generic");

    if(var_2 addlocationalias(1.0, var_0)) {
      var_4 = gettargettingai(var_0);

      if(isdefined(var_4)) {
        if(isdefined(var_4.bcname) && cansayname(var_4.bcname)) {
          var_2 addnamealias(var_4.bcname);
          var_2.looktarget = var_4;
        } else if(isdefined(var_4.bcrank)) {
          var_2 addrankalias(var_4.bcrank);
          var_2.looktarget = var_4;
        }

        var_2 addorderalias(1.0, "attack", "infantry");

        if(isofficer())
          var_4 animscripts\battlechatter_ai::addresponseevent("ack", "yes", self, 0.9);
        else
          var_4 animscripts\battlechatter_ai::addresponseevent("ack", "norankyes", self, 0.9);
      } else if(randomfloat(1) > 0.3)
        var_2 adddirectionalias(1.0, "side", var_0, var_2.locationent getorigin());
      else {
        var_2 addareaalias(0.5, var_0);
        var_2 addorderalias(1.0, "attack", "infantry");
      }
    } else if(var_2 addlandmarkalias(1.0, var_0)) {
      var_4 = gettargettingai(var_0);

      if(isdefined(var_4)) {
        if(isdefined(var_4.bcname) && cansayname(var_4.bcname)) {
          var_2 addnamealias(var_4.bcname);
          var_2.looktarget = var_4;
        } else if(isdefined(var_4.bcrank)) {
          var_2 addrankalias(var_4.bcrank);
          var_2.looktarget = var_4;
        }

        var_2 addorderalias(1.0, "attack", "infantry");

        if(isofficer())
          var_4 animscripts\battlechatter_ai::addresponseevent("ack", "yes", self, 0.9);
        else
          var_4 animscripts\battlechatter_ai::addresponseevent("ack", "norankyes", self, 0.9);
      } else if(randomfloat(1) > 0.3)
        var_2 adddirectionalias(1.0, "relative", var_0);
      else {
        var_2 addareaalias(0.5, var_0);
        var_2 addorderalias(1.0, "attack", "infantry");
      }
    }
  }

  playphrase(var_2);
}

threatdog(var_0, var_1) {
  self endon("cancel speaking");
  var_2 = createchatphrase();
  var_2.master = 1;

  if(!isdefined(var_1))
    var_2.forcedetail = 0;
  else
    var_2.forcedetail = var_1;

  var_2.threatent = var_0;

  if(self.voice == "british") {
    var_3 = getdirectioncompass(self.origin, var_0.origin);

    switch (var_3) {
      case "northwest":
        var_3 = "nthwest";
        break;
      case "northeast":
        var_3 = "ntheast";
        break;
      case "southwest":
        var_3 = "sthwest";
        break;
      case "southeast":
        var_3 = "stheast";
        break;
      case "impossible":
        var_3 = "generic";
    }

    var_2 addthreatalias(1.0, "dog", var_3);
  } else {
    var_2 addthreatalias(1.0, "dog", "generic");
    var_2 adddirectionalias(1.0, "relative", var_0);
  }

  playphrase(var_2);
}

threatinfantryexposed(var_0) {
  if(!isdefined(var_0 getlandmark()))
    addthreatalias(1.0, "infantry", "exposed");
  else
    addthreatalias(1.0, "infantry", "generic");

  if(addlandmarkalias(1.0, var_0))
    adddirectionalias(0.5, "relative", var_0);
  else
    adddirectionalias(1.0, "relative", var_0);
}

threatinfantryrpg(var_0) {
  addthreatalias(1.0, "rpg", "generic");

  if(addareaalias(0.5, var_0) && self.areadetail) {
    return;
  }
  if(addlocationalias(0.5, var_0))
    adddirectionalias(0.5, "side", var_0, self.locationent getorigin());
  else if(addlandmarkalias(0.5, var_0))
    adddirectionalias(0.5, "relative", var_0);
}

threatinfantrymg(var_0) {
  addthreatalias(1.0, "mg", "generic");

  if(addareaalias(0.5, var_0) && self.areadetail) {
    return;
  }
  if(addlocationalias(0.5, var_0))
    adddirectionalias(0.5, "side", var_0, self.locationent getorigin());
  else if(addlandmarkalias(0.5, var_0))
    adddirectionalias(0.5, "relative", var_0);
}

playreactionevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.chatqueue["reaction"];
  var_0 = self.chatqueue["reaction"].reactto;
  anim thread lockaction(self, "reaction");

  switch (self.chatqueue["reaction"].eventtype) {
    case "casualty":
      reactioncasualty(var_0, self.chatqueue["reaction"].modifier);
      break;
    case "taunt":
      reactiontaunt(var_0, self.chatqueue["reaction"].modifier);
      break;
  }

  self notify("done speaking");
}

reactioncasualty(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = createchatphrase();
  var_2 addreactionalias(1.0, "casualty", "generic");
  playphrase(var_2);
}

reactiontaunt(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = createchatphrase();
  var_2 addtauntalias(1.0, "taunt", "generic");
  playphrase(var_2);
}

playresponseevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.chatqueue["response"];
  var_0 = self.chatqueue["response"].respondto;

  if(!isalive(var_0)) {
    return;
  }
  if(self.chatqueue["response"].modifier == "follow" && self.a.state != "move") {
    return;
  }
  anim thread lockaction(self, "response");

  switch (self.chatqueue["response"].eventtype) {
    case "killfirm":
      responsekillconfirm(var_0, self.chatqueue["response"].modifier);
      break;
    case "ack":
      responseacknowledge(var_0, self.chatqueue["response"].modifier);
      break;
  }

  self notify("done speaking");
}

responseacknowledge(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isalive(var_0)) {
    return;
  }
  var_2 = createchatphrase();
  var_2 addresponsealias(1.0, "ack", var_1);
  var_2.looktarget = var_0;
  playphrase(var_2);
}

responsekillconfirm(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = createchatphrase();
  var_2 addresponsealias(1.0, "killfirm", "infantry");
  var_2.looktarget = var_0;
  playphrase(var_2);
}

playorderevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.chatqueue["order"];
  anim thread lockaction(self, "order");

  switch (self.chatqueue["order"].eventtype) {
    case "action":
      orderaction(self.chatqueue["order"].modifier);
      break;
    case "move":
      ordermove(self.chatqueue["order"].modifier, self.chatqueue["order"].orderto);
      break;
    case "displace":
      orderdisplace(self.chatqueue["order"].modifier);
      break;
    case "cover":
      ordercover(self.chatqueue["order"].modifier, self.chatqueue["order"].orderto);
      break;
  }

  self notify("done speaking");
}

ordermove(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = createchatphrase();

  if(var_0 == "follow") {
    var_3 = getaiarray(self.team);
    var_1 = undefined;

    for (var_4 = 0; var_4 < var_3.size; var_4++) {
      if(var_3[var_4] == self) {
        continue;
      }
      if(distance(self.origin, var_3[var_4].origin) > 500 && var_3[var_4].a.state == "move" && var_3[var_4] cansay("response"))
        var_1 = var_3[var_4];
    }

    if(isdefined(var_1) && isdefined(var_1.bcname) && cansayname(var_1.bcname)) {
      var_2 addnamealias(var_1.bcname);
      var_2.looktarget = var_1;
      var_1 animscripts\battlechatter_ai::addresponseevent("ack", "follow", self, 1.0);
    } else if(isdefined(var_1) && isdefined(var_1.bcrank)) {
      var_2 addrankalias(var_1.bcrank);
      var_2.looktarget = var_1;
      var_1 animscripts\battlechatter_ai::addresponseevent("ack", "follow", self, 1.0);
    } else
      level notify("follow order", self);

    var_2 addorderalias(1.0, "move", var_0);
  } else
    var_2 addorderalias(1.0, "move", var_0);

  playphrase(var_2);
}

orderdisplace(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = createchatphrase();
  var_1 addorderalias(1.0, "displace", var_0);
  playphrase(var_1, 1);
}

orderaction(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = createchatphrase();
  var_1 addorderalias(1.0, "action", var_0);
  playphrase(var_1);
}

ordercover(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = createchatphrase();

  if(randomfloat(1) < 0.5 && isofficer()) {
    if(isdefined(var_1) && isdefined(var_1.bcrank)) {
      var_2 addrankalias(var_1.bcrank);
      var_2.looktarget = var_1;
    }
  } else if(isdefined(var_1) && isdefined(var_1.bcname) && cansayname(var_1.bcname)) {
    var_2 addnamealias(var_1.bcname);
    var_2.looktarget = var_1;
  } else if(isdefined(var_1) && isdefined(var_1.bcrank)) {
    var_2 addrankalias(var_1.bcrank);
    var_2.looktarget = var_1;
  }

  var_2 addorderalias(1.0, "cover", var_0);
  playphrase(var_2);
}

playinformevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.chatqueue["inform"];
  anim thread lockaction(self, "inform");

  switch (self.chatqueue["inform"].eventtype) {
    case "killfirm":
      informkillconfirm(self.chatqueue["inform"].modifier);
      break;
    case "incoming":
      informincoming(self.chatqueue["inform"].modifier);
      break;
    case "attack":
      informattacking(self.chatqueue["inform"].modifier);
      break;
    case "reloading":
      informreloading(self.chatqueue["inform"].informto, self.chatqueue["inform"].modifier);
      break;
    case "suppressed":
      informsupressed(self.chatqueue["inform"].modifier);
      break;
  }

  self notify("done speaking");
}

informreloading(var_0, var_1) {
  self endon("death");
  self endon("removed from battleChatter");
  var_2 = createchatphrase();

  if(var_1 == "coverme" && isalive(var_0) && isdefined(var_0.bcname) && cansayname(var_0.bcname)) {
    if(var_0 == level.player || self.countryid != "US")
      var_1 = "generic";
    else {
      var_1 = var_0.bcname;
      var_0 animscripts\battlechatter_ai::addresponseevent("ack", "covering", self, 0.9);
      var_2.looktarget = var_0;
    }
  } else
    var_1 = "generic";

  var_2 addinformalias(1.0, "reloading", var_1);
  playphrase(var_2);
}

informsupressed(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = createchatphrase();
  var_1 addinformalias(1.0, "suppressed", var_0);
  playphrase(var_1);
}

informincoming(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = createchatphrase();

  if(var_0 == "grenade")
    var_1.master = 1;

  var_1 addinformalias(1.0, "incoming", var_0);
  playphrase(var_1);
}

informattacking(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = createchatphrase();
  var_1 addinformalias(1.0, "attack", var_0);
  playphrase(var_1);
}

informkillconfirm(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_1 = createchatphrase();
  var_1 addinformalias(1.0, "killfirm", "infantry");
  playphrase(var_1);
}

playcustomevent() {
  self endon("death");
  self endon("removed from battleChatter");
  self.curevent = self.chatqueue["custom"];
  anim thread lockaction(self, self.curevent.type, 1);
  playphrase(self.customchatphrase);
  self notify("done speaking");
  self.customchatevent = undefined;
  self.customchatphrase = undefined;
}

playphrase(var_0, var_1) {
  anim endon("battlechatter disabled");
  self endon("death");

  if(isdefined(var_1)) {
    return;
  }
  if(isdefined(level._stealth) && self.voice == "british") {
    for (var_2 = 0; var_2 < var_0.soundaliases.size; var_2++)
      var_0.soundaliases[var_2] = var_0.soundaliases[var_2] + "_s";
  }

  if(battlechatter_canprint()) {
    for (var_2 = 0; var_2 < var_0.soundaliases.size; var_2++)
      battlechatter_print(var_0.soundaliases[var_2]);

    battlechatter_println("");
  }

  thread battlechatter_printdump(var_0.soundaliases);

  for (var_2 = 0; var_2 < var_0.soundaliases.size; var_2++) {
    if(!self.battlechatter) {
      continue;
    }
    if(self._animactive > 0) {
      continue;
    }
    if(isfiltered(self.curevent.eventaction)) {
      wait 0.85;
      continue;
    }

    var_3 = gettime();

    if(var_0.master && self.team == "allies") {
      if(getdvar("bcs_threatPlayerRelative") == "on") {
        if(strfind(var_0.soundaliases[var_2], "_direction_")) {
          if(isdefined(var_0.threatent))
            var_0.soundaliases[var_2] = var_0 getdirectionaliasplayerrelative(var_0.threatent);
        }
      }

      self playsoundasmaster(var_0.soundaliases[var_2], var_0.soundaliases[var_2], 1);
      thread maps\_anim::anim_facialfiller(var_0.soundaliases[var_2], var_0.looktarget);
      self waittill(var_0.soundaliases[var_2]);
      continue;
    }

    self playsound(var_0.soundaliases[var_2], var_0.soundaliases[var_2], 1);
    thread maps\_anim::anim_facialfiller(var_0.soundaliases[var_2], var_0.looktarget);
    self waittill(var_0.soundaliases[var_2]);
  }

  dotypelimit(self.curevent.eventaction, self.curevent.eventtype);
}

isspeakingfailsafe(var_0) {
  self endon("death");
  wait 45;
  clearisspeaking(var_0);
}

clearisspeaking(var_0) {
  self.isspeaking = 0;
  self.chatqueue[var_0].expiretime = 0;
  self.chatqueue[var_0].priority = 0.0;
  self.nextsaytimes[var_0] = gettime() + anim.eventactionminwait[var_0]["self"];
}

lockaction(var_0, var_1, var_2) {
  anim endon("battlechatter disabled");
  var_3 = var_0.squad;
  var_4 = var_0.team;
  var_0.isspeaking = 1;
  var_0 thread isspeakingfailsafe(var_1);
  var_3.ismembersaying[var_1] = 1;
  var_3.numspeakers++;
  anim.isteamspeaking[var_4] = 1;
  anim.isteamsaying[var_4][var_1] = 1;
  var_5 = var_0 common_scripts\utility::waittill_any_return("death", "done speaking", "cancel speaking");
  var_3.ismembersaying[var_1] = 0;
  var_3.numspeakers--;
  anim.isteamspeaking[var_4] = 0;
  anim.isteamsaying[var_4][var_1] = 0;
  anim.lastteamspeaktime[var_4] = gettime();

  if(var_5 == "cancel speaking") {
    return;
  }
  if(isalive(var_0))
    var_0 clearisspeaking(var_1);

  var_3.nextsaytimes[var_1] = gettime() + anim.eventactionminwait[var_1]["squad"];
}

updatecontact(var_0, var_1) {
  if(gettime() - self.squadlist[var_0].lastcontact > 10000) {
    var_2 = 0;

    for (var_3 = 0; var_3 < self.members.size; var_3++) {
      if(self.members[var_3] != var_1 && isalive(self.members[var_3].enemy) && isdefined(self.members[var_3].enemy.squad) && self.members[var_3].enemy.squad.squadname == var_0)
        var_2 = 1;
    }

    if(!var_2) {
      self.squadlist[var_0].firstcontact = gettime();
      self.squadlist[var_0].calledout = 0;
    }
  }

  self.squadlist[var_0].lastcontact = gettime();
}

cansay(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(self == level.player)
    return 0;

  if(!isdefined(self.battlechatter) || !self.battlechatter)
    return 0;

  if(isdefined(var_2) && var_2 >= 1)
    return 1;

  if(gettime() + anim.eventactionminwait[var_0]["self"] < self.nextsaytimes[var_0])
    return 0;

  if(gettime() + anim.eventactionminwait[var_0]["squad"] < self.squad.nextsaytimes[var_0])
    return 0;

  if(isdefined(var_1) && typelimited(var_0, var_1))
    return 0;

  if(isdefined(var_1) && anim.eventpriority[var_0][var_1] < self.bcs_minpriority)
    return 0;

  if(self.voice == "british")
    return britfilter(var_0, var_1, var_3);

  return 1;
}

britfilter(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = "";

  if(!isdefined(var_1))
    return 0;

  switch (var_0) {
    case "order":
      if(var_1 == "action" && var_2 == "coverme")
        return 1;

      break;
    case "threat":
      if(var_1 == "infantry" || var_1 == "dog" || var_1 == "rpg")
        return 1;

      break;
    case "inform":
      if(var_1 == "attack" && var_2 == "grenade")
        return 1;
      else if(var_1 == "incoming" && var_2 == "grenade")
        return 1;
      else if(var_1 == "killfirm" && var_2 == "infantry")
        return 1;
      else if(var_1 == "reloading" && var_2 == "generic")
        return 1;

      break;
    case "reaction":
      if(var_1 == "casualty" && var_2 == "generic")
        return 1;

      break;
    default:
      return 0;
  }

  return 0;
}

gethighestpriorityevent() {
  var_0 = undefined;
  var_1 = -999999999;

  if(isvalidevent("custom")) {
    var_0 = "custom";
    var_1 = self.chatqueue["custom"].priority;
  }

  if(isvalidevent("response")) {
    if(self.chatqueue["response"].priority > var_1) {
      var_0 = "response";
      var_1 = self.chatqueue["response"].priority;
    }
  }

  if(isvalidevent("order")) {
    if(self.chatqueue["order"].priority > var_1) {
      var_0 = "order";
      var_1 = self.chatqueue["order"].priority;
    }
  }

  if(isvalidevent("threat")) {
    if(self.chatqueue["threat"].priority > var_1) {
      var_0 = "threat";
      var_1 = self.chatqueue["threat"].priority;
    }
  }

  if(isvalidevent("inform")) {
    if(self.chatqueue["inform"].priority > var_1) {
      var_0 = "inform";
      var_1 = self.chatqueue["inform"].priority;
    }
  }

  if(isvalidevent("reaction")) {
    if(self.chatqueue["reaction"].priority > var_1) {
      var_0 = "reaction";
      var_1 = self.chatqueue["reaction"].priority;
    }
  }

  return var_0;
}

gettargettingai(var_0) {
  var_1 = self.squad;
  var_2 = [];

  for (var_3 = 0; var_3 < var_1.members.size; var_3++) {
    if(isdefined(var_1.members[var_3].enemy) && var_1.members[var_3].enemy == var_0)
      var_2[var_2.size] = var_1.members[var_3];
  }

  if(!isdefined(var_2[0]))
    return undefined;

  var_4 = undefined;

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] cansay("response"))
      return var_4;
  }

  return common_scripts\utility::getclosest(self.origin, var_2);
}

getqueueevents() {
  var_0 = [];
  var_1 = [];
  var_0[0] = "custom";
  var_0[1] = "response";
  var_0[2] = "order";
  var_0[3] = "threat";
  var_0[4] = "inform";

  for (var_2 = var_0.size - 1; var_2 >= 0; var_2--) {
    for (var_3 = 1; var_3 <= var_2; var_3++) {
      if(self.chatqueue[var_0[var_3 - 1]].priority < self.chatqueue[var_0[var_3]].priority) {
        var_4 = var_0[var_3 - 1];
        var_0[var_3 - 1] = var_0[var_3];
        var_0[var_3] = var_4;
      }
    }
  }

  var_5 = 0;

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_6 = geteventstate(var_0[var_2]);

    if(var_6 == " valid" && !var_5) {
      var_5 = 1;
      var_1[var_2] = "g " + var_0[var_2] + var_6 + " " + self.chatqueue[var_0[var_2]].priority;
      continue;
    }

    if(var_6 == " valid") {
      var_1[var_2] = "y " + var_0[var_2] + var_6 + " " + self.chatqueue[var_0[var_2]].priority;
      continue;
    }

    if(self.chatqueue[var_0[var_2]].expiretime == 0) {
      var_1[var_2] = "b " + var_0[var_2] + var_6 + " " + self.chatqueue[var_0[var_2]].priority;
      continue;
    }

    var_1[var_2] = "r " + var_0[var_2] + var_6 + " " + self.chatqueue[var_0[var_2]].priority;
  }

  return var_1;
}

geteventstate(var_0) {
  var_1 = "";

  if(self.squad.ismembersaying[var_0])
    var_1 = var_1 + " playing";

  if(gettime() > self.chatqueue[var_0].expiretime)
    var_1 = var_1 + " expired";

  if(gettime() < self.squad.nextsaytimes[var_0])
    var_1 = var_1 + " cantspeak";

  if(var_1 == "")
    var_1 = " valid";

  return var_1;
}

isfiltered(var_0) {
  if(getdvar("bcs_filter" + var_0) == "on" || getdvar("bcs_filter" + var_0) == "1")
    return 1;

  return 0;
}

isvalidevent(var_0) {
  if(!self.squad.ismembersaying[var_0] && !anim.isteamsaying[self.team][var_0] && gettime() < self.chatqueue[var_0].expiretime && gettime() > self.squad.nextsaytimes[var_0]) {
    if(!typelimited(var_0, self.chatqueue[var_0].eventtype))
      return 1;
  }

  return 0;
}

typelimited(var_0, var_1) {
  if(!isdefined(anim.eventtypeminwait[var_0][var_1]))
    return 0;

  if(!isdefined(self.squad.nexttypesaytimes[var_0][var_1]))
    return 0;

  if(gettime() > self.squad.nexttypesaytimes[var_0][var_1])
    return 0;

  return 1;
}

dotypelimit(var_0, var_1) {
  if(!isdefined(anim.eventtypeminwait[var_0][var_1])) {
    return;
  }
  self.squad.nexttypesaytimes[var_0][var_1] = gettime() + anim.eventtypeminwait[var_0][var_1];
}

bcissniper() {
  if(isplayer(self))
    return 0;

  if(isexposed())
    return 0;

  return animscripts\utility::issniperrifle(self.weapon);
}

isexposed() {
  if(isdefined(getlocation()))
    return 0;

  var_0 = bcgetclaimednode();

  if(!isdefined(var_0))
    return 1;

  if(var_0.type[0] == "C" && var_0.type[1] == "o" && var_0.type[2] == "v")
    return 0;

  return 1;
}

isclaimednodecover() {
  var_0 = bcgetclaimednode();

  if(!isdefined(var_0))
    return 0;

  if(var_0.type[0] == "C" && var_0.type[1] == "o" && var_0.type[2] == "v")
    return 1;

  return 0;
}

isclaimednodewindow() {
  var_0 = bcgetclaimednode();

  if(!isdefined(var_0))
    return 0;

  if(!isdefined(var_0.script_location))
    return 0;

  if(var_0.script_location == "window")
    return 1;

  return 0;
}

isnodecover() {
  var_0 = self.node;

  if(!isdefined(var_0))
    return 0;

  if(var_0.type[0] == "C" && var_0.type[1] == "o" && var_0.type[2] == "v")
    return 1;

  return 0;
}

isofficer() {
  var_0 = getrank();

  if(var_0 == "sergeant" || var_0 == "lieutenant" || var_0 == "captain" || var_0 == "sergeant")
    return 1;

  return 0;
}

bcgetclaimednode() {
  if(isplayer(self))
    var_0 = self.node;
  else
    var_0 = animscripts\utility::getclaimednode();
}

getname() {
  if(self.team == "axis")
    var_0 = self.ainame;
  else if(self.team == "allies")
    var_0 = self.name;
  else
    var_0 = undefined;

  if(!isdefined(var_0) || self.voice == "british")
    return undefined;

  var_1 = strtok(var_0, " ");

  if(var_1.size < 2)
    return undefined;

  return var_1[1];
}

getrank() {
  return self.airank;
}

getclosestspeaker(var_0, var_1) {
  var_2 = getspeakers(var_0, var_1);
  var_3 = common_scripts\utility::getclosest(self.origin, var_2);
  return var_3;
}

getspeakers(var_0, var_1) {
  var_2 = [];
  var_3 = getaiarray(self.team);

  if(isdefined(var_1) && var_1) {
    var_4 = [];

    for (var_5 = 0; var_5 < var_3.size; var_5++) {
      if(var_3[var_5] isofficer())
        var_4[var_4.size] = var_3[var_5];
    }

    var_3 = var_4;
  }

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    if(var_3[var_5] == self) {
      continue;
    }
    if(!var_3[var_5] cansay(var_0)) {
      continue;
    }
    var_2[var_2.size] = var_3[var_5];
  }

  return var_2;
}

getarea() {
  var_0 = anim.areas;

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(self istouching(var_0[var_1]) && isdefined(var_0[var_1].script_area))
      return var_0[var_1];
  }

  return undefined;
}

getlocation() {
  var_0 = anim.locations;

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(self istouching(var_0[var_1]) && isdefined(var_0[var_1].script_location))
      return var_0[var_1];
  }

  return undefined;
}

getlandmark() {
  var_0 = anim.landmarks;

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(self istouching(var_0[var_1]) && isdefined(var_0[var_1].script_landmark))
      return var_0[var_1];
  }

  return undefined;
}

getdirectioncompass(var_0, var_1) {
  var_2 = vectortoangles(var_1 - var_0);
  var_3 = var_2[1];
  var_4 = getnorthyaw();
  var_3 = var_3 - var_4;

  if(var_3 < 0)
    var_3 = var_3 + 360;
  else if(var_3 > 360)
    var_3 = var_3 - 360;

  if(var_3 < 22.5 || var_3 > 337.5)
    var_5 = "north";
  else if(var_3 < 67.5)
    var_5 = "northwest";
  else if(var_3 < 112.5)
    var_5 = "west";
  else if(var_3 < 157.5)
    var_5 = "southwest";
  else if(var_3 < 202.5)
    var_5 = "south";
  else if(var_3 < 247.5)
    var_5 = "southeast";
  else if(var_3 < 292.5)
    var_5 = "east";
  else if(var_3 < 337.5)
    var_5 = "northeast";
  else
    var_5 = "impossible";

  return var_5;
}

getdirectionreferenceside(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2 - var_0);
  var_4 = vectortoangles(var_1 - var_0);
  var_5 = var_3[1] - var_4[1];
  var_5 = var_5 + 360;
  var_5 = int(var_5) % 360;

  if(var_5 > 180)
    var_5 = var_5 - 360;

  if(var_5 > 2 && var_5 < 45)
    var_6 = "right";
  else if(var_5 < -2 && var_5 > -45)
    var_6 = "left";
  else if(distance(var_0, var_1) < distance(var_0, var_2))
    var_6 = "front";
  else
    var_6 = "rear";

  return var_6;
}

getdirectionfacingflank(var_0, var_1, var_2) {
  var_3 = vectortoangles(var_2);
  var_4 = vectortoangles(var_1 - var_0);
  var_5 = var_3[1] - var_4[1];
  var_5 = var_5 + 360;
  var_5 = int(var_5) % 360;

  if(var_5 > 315 || var_5 < 45)
    var_6 = "front";
  else if(var_5 < 135)
    var_6 = "right";
  else if(var_5 < 225)
    var_6 = "rear";
  else
    var_6 = "left";

  return var_6;
}

getvectorrightangle(var_0) {
  return (var_0[1], 0 - var_0[0], var_0[2]);
}

getvectorarrayaverage(var_0) {
  var_1 = (0, 0, 0);

  for (var_2 = 0; var_2 < var_0.size; var_2++)
    var_1 = var_1 + var_0[var_2];

  return (var_1[0] / var_0.size, var_1[1] / var_0.size, var_1[2] / var_0.size);
}

addnamealias(var_0) {
  self.soundaliases[self.soundaliases.size] = self.owner.countryid + "_" + self.owner.npcid + "_name_" + var_0;
}

addrankalias(var_0) {
  self.soundaliases[self.soundaliases.size] = self.owner.countryid + "_" + self.owner.npcid + "_rank_" + var_0;
}

cansayname(var_0) {
  var_1 = self.countryid + "_" + self.npcid + "_name_" + var_0;

  if(soundexists(var_1))
    return 1;
  else
    return 0;
}

addareaalias(var_0, var_1) {
  if(randomfloat(1) > var_0)
    return 0;

  self.areaent = var_1 getarea();

  if(!isdefined(self.areaent))
    return 0;

  if(self.areaent.script_area == "window" || self.areaent.script_area == "doorway") {}

  var_2 = self.areaent.script_area;
  var_3 = var_1 bcgetclaimednode();

  if(isdefined(var_3) && isdefined(var_3.script_area)) {
    var_2 = var_2 + var_3.script_area;
    self.areadetail = 1;
  } else {
    self.areadetail = 0;
    var_2 = var_2 + "_generic";
  }

  self.area = self.owner.countryid + "_" + self.owner.npcid + "_area_" + var_2;
  self.soundaliases[self.soundaliases.size] = self.area;
  return 1;
}

addlocationalias(var_0, var_1) {
  if(randomfloat(1) > var_0)
    return 0;

  self.locationent = var_1 getlocation();

  if(!isdefined(self.locationent))
    return 0;

  var_2 = self.locationent.script_location;
  var_3 = var_1 bcgetclaimednode();

  if(isdefined(var_3) && isdefined(var_3.script_location))
    var_2 = var_2 + ("_" + var_3.script_location);
  else
    var_2 = var_2 + "_generic";

  self.location = self.owner.countryid + "_" + self.owner.npcid + "_location_" + var_2;
  self.soundaliases[self.soundaliases.size] = self.location;
  return 1;
}

addlandmarkalias(var_0, var_1) {
  if(randomfloat(1) > var_0)
    return 0;

  self.landmarkent = var_1 getlandmark();

  if(!isdefined(self.landmarkent))
    return 0;

  var_2 = self.landmarkent.script_landmark;
  var_3 = getdirectionreferenceside(self.owner.origin, var_1.origin, self.landmarkent.origin);

  if(var_3 == "rear" && soundexists(self.owner.countryid + "_" + self.owner.npcid + "_landmark_behind_" + var_2))
    var_2 = "behind_" + var_2;
  else if(soundexists(self.owner.countryid + "_" + self.owner.npcid + "_landmark_near_" + var_2))
    var_2 = "near_" + var_2;
  else
    return 0;

  self.landmark = self.owner.countryid + "_" + self.owner.npcid + "_landmark_" + var_2;
  self.soundaliases[self.soundaliases.size] = self.landmark;
  return 1;
}

addgenericalias(var_0, var_1, var_2, var_3) {
  self.soundaliases[self.soundaliases.size] = self.owner.countryid + "_" + self.owner.npcid + "_" + var_1 + "_" + var_2 + "_" + var_3;
  dotypelimit(var_1, var_2);
}

adddirectionalias(var_0, var_1, var_2, var_3, var_4) {
  if(randomfloat(1) > var_0)
    return 0;

  switch (var_1) {
    case "side":
      var_5 = getdirectionreferenceside(self.owner.origin, var_2.origin, var_3);

      if(1)
        return 0;

      var_5 = var_1 + "_" + var_5;
      break;
    case "relative":
      if(isdefined(var_4)) {
        if(var_4 == "clock")
          var_6 = 0;
        else if(var_4 == "flank")
          var_6 = 1;
        else if(var_4 == "compass")
          var_6 = 2;
        else
          var_6 = randomintrange(0, 3) - 1;
      } else if(distance(self.owner.origin, var_2.origin) > 2048)
        var_6 = 2;
      else if(distance(self.owner.origin, var_2.origin) > 800)
        var_6 = 0;
      else
        var_6 = 1;

      if(var_6 == 0)
        var_5 = getdirectioncompass(self.owner.origin, var_2.origin);
      else if(var_6 == 1)
        return 0;
      else
        var_5 = getdirectioncompass(self.owner.origin, var_2.origin);

      var_5 = var_1 + "_" + var_5;
      break;
    default:
      return 0;
  }

  self.direction = self.owner.countryid + "_" + self.owner.npcid + "_direction_" + var_5;
  self.soundaliases[self.soundaliases.size] = self.direction;
  return 1;
}

getdirectionaliasplayerrelative(var_0) {
  var_1 = getdirectionreferenceside(level.player.origin, var_0.origin, anglestoforward(level.player.angles));
  var_1 = "relative_" + var_1;
  self.direction = self.owner.countryid + "_" + self.owner.npcid + "_direction_" + var_1;
  return self.direction;
}

addthreatalias(var_0, var_1, var_2) {
  self.threat = self.owner.countryid + "_" + self.owner.npcid + "_threat_" + var_1 + "_" + var_2;
  self.soundaliases[self.soundaliases.size] = self.threat;
  return 1;
}

addinformalias(var_0, var_1, var_2) {
  self.inform = self.owner.countryid + "_" + self.owner.npcid + "_inform_" + var_1 + "_" + var_2;
  self.soundaliases[self.soundaliases.size] = self.inform;
  return 1;
}

addresponsealias(var_0, var_1, var_2) {
  self.response = self.owner.countryid + "_" + self.owner.npcid + "_response_" + var_1 + "_" + var_2;
  self.soundaliases[self.soundaliases.size] = self.response;
  return 1;
}

addreactionalias(var_0, var_1, var_2) {
  self.reaction = self.owner.countryid + "_" + self.owner.npcid + "_reaction_" + var_1 + "_" + var_2;
  self.soundaliases[self.soundaliases.size] = self.reaction;
  return 1;
}

addtauntalias(var_0, var_1, var_2) {
  self.reaction = self.owner.countryid + "_" + self.owner.npcid + "_taunt";
  self.soundaliases[self.soundaliases.size] = self.reaction;
  return 1;
}

addorderalias(var_0, var_1, var_2) {
  self.order = self.owner.countryid + "_" + self.owner.npcid + "_order_" + var_1 + "_" + var_2;
  self.soundaliases[self.soundaliases.size] = self.order;
  return 1;
}

initcontact(var_0) {
  if(!isdefined(self.squadlist[var_0].calledout))
    self.squadlist[var_0].calledout = 0;

  if(!isdefined(self.squadlist[var_0].firstcontact))
    self.squadlist[var_0].firstcontact = 2000000000;

  if(!isdefined(self.squadlist[var_0].lastcontact))
    self.squadlist[var_0].lastcontact = 0;
}

shutdowncontact(var_0) {
  self.squadlist[var_0].calledout = undefined;
  self.squadlist[var_0].firstcontact = undefined;
  self.squadlist[var_0].lastcontact = undefined;
}

createchatevent(var_0, var_1, var_2) {
  var_3 = spawnstruct();
  var_3.owner = self;
  var_3.eventtype = var_1;
  var_3.eventaction = var_0;

  if(isdefined(var_2))
    var_3.priority = var_2;
  else
    var_3.priority = anim.eventpriority[var_0][var_1];

  var_3.expiretime = gettime() + anim.eventduration[var_0][var_1];
  return var_3;
}

createchatphrase() {
  var_0 = spawnstruct();
  var_0.owner = self;
  var_0.soundaliases = [];
  var_0.master = 0;
  return var_0;
}

canseepoint(var_0) {
  var_1 = anglestoforward(self.angles);
  return vectordot(var_1, var_0 - self.origin) > 0.766;
}

pointinfov(var_0) {
  var_1 = anglestoforward(self.angles);
  return vectordot(var_1, var_0 - self.origin) > 0.766;
}

battlechatter_canprint() {
  if(getdvar("debug_bcprint") == self.team || getdvar("debug_bcprint") == "all")
    return 1;

  return 0;
}

battlechatter_print(var_0) {}

battlechatter_println(var_0) {}

battlechatter_print_internal(var_0, var_1) {
  if(!battlechatter_canprint()) {
    return;
  }
  var_2 = "";

  if(var_0 != "")
    var_2 = common_scripts\utility::ter_op(self.team == "allies", "^5", "^6") + "BC: ";

  [[var_1]](var_2 + var_0);
}

battlechatter_canprintdump() {
  return getdvar("debug_bcprintdump") == "on";
}

battlechatter_printdump(var_0) {}

battlechatter_printdumpline(var_0, var_1, var_2) {}

strfind(var_0, var_1) {
  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] != var_1[0]) {
      continue;
    }
    if(var_1.size > var_0.size - var_2)
      return 0;

    for (var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_0[var_2 + var_3] != var_1[var_3]) {
        break;
      }

      if(var_3 == var_1.size - 1)
        return 1;
    }
  }
}

threattracker() {
  for (;;) {
    var_0 = getaiarray("axis");
    var_1 = getaiarray("allies");
    var_2 = [];

    for (var_3 = 0; var_3 < var_0.size; var_3++) {
      if(!level.player pointinfov(var_0[var_3].origin)) {
        continue;
      }
      if(distance(level.player.origin, var_0[var_3].origin) > 2048) {
        continue;
      }
      var_4 = "";
      var_5 = var_0[var_3] getlocation();

      if(!isdefined(var_5)) {
        var_5 = var_0[var_3] getlandmark();

        if(!isdefined(var_5)) {
          continue;
        }
        var_4 = var_5.script_landmark;
      } else
        var_4 = var_5.script_location;

      var_6 = 0;

      for (var_7 = 0; var_7 < var_1.size; var_7++) {
        if(isdefined(var_1[var_7].enemy) && var_1[var_7].enemy == var_0[var_3])
          var_6 = 1;
      }

      if(var_6) {
        var_2[var_2.size] = "^2" + var_4;
        continue;
      }

      var_2[var_2.size] = "^1" + var_4;
    }

    for (var_3 = 0; var_3 < var_2.size; var_3++) {

    }

    wait 0.5;
  }
}

bcdrawobjects() {
  for (var_0 = 0; var_0 < anim.areas.size; var_0++) {
    if(!isdefined(anim.areas[var_0].script_area)) {
      continue;
    }
    thread drawbcobject("Area: " + anim.areas[var_0].script_area, anim.areas[var_0] getorigin(), (0, 0, 16), (1, 1, 1));
  }

  for (var_0 = 0; var_0 < anim.locations.size; var_0++) {
    if(!isdefined(anim.locations[var_0].script_location)) {
      continue;
    }
    thread drawbcobject("Location: " + anim.locations[var_0].script_location, anim.locations[var_0] getorigin(), (0, 0, 8), (1, 1, 1));
  }

  for (var_0 = 0; var_0 < anim.landmarks.size; var_0++) {
    if(!isdefined(anim.landmarks[var_0].script_landmark)) {
      continue;
    }
    thread drawbcobject("Landmark: " + anim.landmarks[var_0].script_landmark, anim.landmarks[var_0] getorigin(), (0, 0, 0), (1, 1, 1));
    thread drawbcdirections(anim.landmarks[var_0] getorigin(), (0, 0, 8), (1, 1, 0));
  }

  var_1 = getallnodes();

  for (var_0 = 0; var_0 < var_1.size; var_0++) {
    if(!isdefined(var_1[var_0].script_location)) {
      continue;
    }
    anim.moveorigin.origin = var_1[var_0].origin;
    anim.moveorigin.origin = anim.moveorigin.origin + (0, 0, 10);
    var_2 = anim.moveorigin getlocation();

    if(isdefined(var_2)) {
      thread drawbcobject(var_1[var_0].script_location + " @ " + var_2.script_location, var_1[var_0].origin, (0, 0, 0), (0, 1, 0));
      continue;
    }

    thread drawbcobject(var_1[var_0].script_location + " @ undefined", var_1[var_0].origin, (0, 0, 0), (1, 0, 0));
  }

  var_1 = undefined;
}

drawbcobject(var_0, var_1, var_2, var_3) {
  for (;;) {
    if(distance(level.player.origin, var_1) > 2048) {
      wait 0.1;
      continue;
    }

    wait 0.05;
  }
}

drawbcdirections(var_0, var_1, var_2) {
  for (;;) {
    if(distance(level.player.origin, var_0) > 2048) {
      wait 0.1;
      continue;
    }

    var_3 = getdirectioncompass(level.player.origin, var_0);
    wait 0.05;
  }
}

resetnextsaytimes(var_0, var_1) {
  var_2 = getaiarray(var_0);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(!isalive(var_4)) {
      continue;
    }
    if(!isdefined(var_4.battlechatter)) {
      continue;
    }
    var_4.nextsaytimes[var_1] = gettime() + 350;
    var_4.squad.nextsaytimes[var_1] = gettime() + 350;
  }
}

getdirectionfacingclockgivenangle(var_0) {
  var_1 = undefined;

  if(var_0 > 345 || var_0 < 15)
    var_1 = "12";
  else if(var_0 < 45)
    var_1 = "1";
  else if(var_0 < 75)
    var_1 = "2";
  else if(var_0 < 105)
    var_1 = "3";
  else if(var_0 < 135)
    var_1 = "4";
  else if(var_0 < 165)
    var_1 = "5";
  else if(var_0 < 195)
    var_1 = "6";
  else if(var_0 < 225)
    var_1 = "7";
  else if(var_0 < 255)
    var_1 = "8";
  else if(var_0 < 285)
    var_1 = "9";
  else if(var_0 < 315)
    var_1 = "10";
  else
    var_1 = "11";

  return var_1;
}

getdirectionfacingangle(var_0, var_1, var_2) {
  var_3 = anglestoforward(var_0);
  var_4 = vectornormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = vectortoangles(var_2 - var_1);
  var_7 = var_5[1] - var_6[1];
  var_7 = var_7 + 360;
  var_7 = int(var_7) % 360;
  return var_7;
}

getrelativeangles(var_0) {
  var_1 = var_0.angles;

  if(!isplayer(var_0)) {
    var_2 = var_0 bcgetclaimednode();

    if(isdefined(var_2))
      var_1 = var_2.angles;
  }

  return var_1;
}

get_all_my_locations() {
  var_0 = [];

  if(!isdefined(self))
    return var_0;

  var_1 = anim.bcs_locations;
  var_2 = self getistouchingentities(var_1);

  if(!isdefined(var_2))
    return var_0;

  foreach(var_4 in var_2) {
    if(isdefined(var_4.locationaliases))
      var_0[var_0.size] = var_4;
  }

  return var_0;
}

getclosestfriendlyspeaker(var_0) {
  var_1 = getspeakers(var_0, 0);
  var_2 = common_scripts\utility::getclosest(self.origin, var_1);
  return var_2;
}