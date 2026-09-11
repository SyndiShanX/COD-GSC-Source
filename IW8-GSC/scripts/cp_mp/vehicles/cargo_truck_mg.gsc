/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\cargo_truck_mg.gsc
*****************************************************/

function init_battlechatter() {
  level._battlechatter = spawnStruct();
  level._battlechatter.fnevaluatemoveevent = &evaluatemoveevent;
  level._battlechatter.fnevaluatereloadevent = &evaluatereloadevent;
  level._battlechatter.fnaddthreatevent = &addthreatevent;
  level._battlechatter.fnevaluateattackevent = &evaluateattackevent;
  level._battlechatter.fnplaybattlechatter = &playbattlechatter;
  level._battlechatter.players = [];
  level._battlechatter.ai = [];
  level._battlechatter.nextsaytimes = [];
  level.heightforhighcallout = 96;
  level.mindistancecallout = 10;
  level.maxdistancecallout = 45;
  anim.threatcallouts = [];
  anim.eventchance = [];
  anim.eventtypeminwait = [];
  anim.threatcallouts["exposed"] = 25;
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
  anim.eventchance["moveEvent"]["coverme"] = 70;
  anim.eventtypeminwait["moveEvent"] = [];
  anim.eventtypeminwait["threat"] = [];
  anim.eventtypeminwait["inform"] = [];
  anim.eventtypeminwait["order"] = [];
  anim.eventtypeminwait["moveEvent"]["coverme"] = 10000;
  anim.eventtypeminwait["inform"]["reloading"] = 20000;
  anim.eventtypeminwait["inform"]["attack"] = 9000;
  anim.eventtypeminwait["inform"]["incoming"] = 25000;
  anim.eventtypeminwait["threat"]["acquired"] = 7000;
  anim.eventtypeminwait["threat"]["sighted"] = 7000;
  anim.eventtypeminwait["threat"]["infantry"] = 7000;
  anim.eventtypeminwait["order"]["action"] = 9000;
  anim.eventtypeminwait["order"]["move"] = 3000;
  anim.ref_13b42 = 120000;
  bcs_setup_countryids();
  level.dialog_system = 1;
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

function battlechatterenabled() {
  return istrue(level.dialog_system);
}

function autoassignquest(var_0) {
  var_0.battlechatterallowed = 1;
  level._battlechatter.ai[level._battlechatter.ai.size] = var_0;
  var_0.battlechatter = spawnStruct();
  var_0.battlechatter.countryid = anim.countryids[var_0.voice];
  setnpcid(var_0);
  thread ref_12be5(var_0);
  thread ref_11e60();
}

function ref_12bc1(var_0) {
  level._battlechatter.ai = scripts\engine\utility::array_remove(level._battlechatter.ai, var_0);
  var_0 notify("removed from battleChatter");
}

function ref_12be5(var_0) {
  var_0 waittill("death");
  ref_12bc1(var_0);
}

function setnpcid() {
  var_0 = anim.usedids[self.voice];
  var_1 = var_0.size;
  var_2 = randomintrange(0, var_1);
  var_3 = var_2;

  for(var_4 = 0; var_4 <= var_1; var_4++) {
    if(var_0[(var_2 + var_4) % var_1].count < var_0[var_3].count) {
      var_3 = (var_2 + var_4) % var_1;
    }
  }

  thread npcidtracker(var_3);
  self.battlechatter.npcid = var_0[var_3].npcid;
}

function npcidtracker(var_0) {
  var_1 = self.voice;
  anim.usedids[var_1][var_0].count++;
  scripts\engine\utility::waittill_either("death", "removed from battleChatter");

  if(!battlechatterenabled()) {
    return;
  }

  anim.usedids[var_1][var_0].count--;
}

function ref_11e60() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("enemy");

    if(isDefined(self.enemy) && isalive(self.enemy)) {
      scripts\anim\battlechatter_wrapper::addthreatevent("infantry", self.enemy);
    }
  }
}

function evaluatemoveevent(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!battlechatterenabled() || !isDefined(self.goalpos) || !istrue(self.battlechatterallowed)) {
    return;
  }

  if(distancesquared(self.origin, self.goalpos) < 22500) {
    return;
  }

  if(randomint(100) < anim.eventchance["moveEvent"]["coverme"]) {
    playorderevent("action", "coverme", anim.player);
    return;
  }

  playorderevent("move", "movecombat", anim.player);
}

function addthreatevent(var_0, var_1, var_2) {
  if(isPlayer(var_1) || isDefined(var_1.aitype)) {
    if(isDefined(self._blackboard)) {
      self._blackboard.battlechatter_target = var_1;
    }

    var_3 = threatinfantry(var_1, undefined);
    return;
  }
}

function getthreatinfantrycallouttype(var_0) {
  var_1 = getdirectionfacingclock(self.angles, self.origin, var_0.origin);
  var_2 = var_1;
  var_3 = self;
  var_4 = getdistancemeters(var_3.origin, var_0.origin);
  self.possiblethreatcallouts = [];

  if(isexposed(var_0)) {
    addpossiblethreatcallout("exposed");
  }

  var_5 = 0;

  if(var_0.origin[2] - var_3.origin[2] >= level.heightforhighcallout) {
    if(addpossiblethreatcallout("ai_target_clock_high")) {
      var_5 = 1;
    }
  }

  addpossiblethreatcallout("ai_casual_clock");

  if(!var_5) {
    if(var_2 == "12") {
      addpossiblethreatcallout("ai_distance");

      if(var_4 > level.mindistancecallout && var_4 < level.maxdistancecallout) {
        addpossiblethreatcallout("ai_obvious");
      }
    }

    addpossiblethreatcallout("ai_contact_clock");
    addpossiblethreatcallout("ai_target_clock");
    addpossiblethreatcallout("ai_cardinal");
  }

  if(!self.possiblethreatcallouts.size) {
    return undefined;
  }

  var_6 = getweightedchanceroll(self.possiblethreatcallouts, anim.threatcallouts);
  var_7 = spawnStruct();
  var_7.type = var_6;
  return var_7;
}

function addpossiblethreatcallout(var_0) {
  var_1 = 0;

  if(!callouttypewillrepeat(var_0)) {
    var_1 = 1;
  }

  if(!var_1) {
    return var_1;
  }

  self.possiblethreatcallouts[self.possiblethreatcallouts.size] = var_0;
  return var_1;
}

function setlastcallouttype(var_0) {
  level._battlechatter.watch_for_player_going_belowmap_or_oob = var_0;
  level._battlechatter.watch_for_player_in_gulag = gettime();
}

function callouttypewillrepeat(var_0) {
  if(!isDefined(level._battlechatter.watch_for_player_going_belowmap_or_oob)) {
    return false;
  }

  if(!isDefined(level._battlechatter.watch_for_player_in_gulag)) {
    return false;
  }

  var_1 = level._battlechatter.watch_for_player_going_belowmap_or_oob;
  var_2 = level._battlechatter.watch_for_player_in_gulag;
  var_3 = anim.ref_13b42;

  if(var_0 == var_1 && gettime() - var_2 < var_3) {
    return true;
  }

  return false;
}

function isexposed(var_0) {
  if(distancesquared(self.origin, var_0.origin) > 2250000) {
    return false;
  }

  var_1 = bcgetclaimednode(var_0);

  if(!isDefined(var_1)) {
    return true;
  }

  if(!isnodecoverorconceal(var_0)) {
    return false;
  }

  return true;
}

function threatinfantryexposed(var_0) {
  var_1 = [];
  var_1 = scripts\engine\utility::array_add(var_1, "open");
  var_1 = scripts\engine\utility::array_add(var_1, "breaking");
  var_2 = var_1[randomint(var_1.size)];
  addthreatexposedalias(var_2);
}

function addthreatexposedalias(var_0) {
  if(var_0 == "group") {
    var_0 = "movement_group";
  }

  var_1 = getbattlechatteralias(self.owner, "exposed_" + var_0);
  self.soundaliases[self.soundaliases.size] = var_1;
  return true;
}

function addthreatobviousalias() {
  var_0 = getbattlechatteralias(self.owner, "order_suppress");
  self.soundaliases[self.soundaliases.size] = var_0;
  return true;
}

function addthreatdistancealias(var_0) {
  var_1 = getbattlechatteralias(self.owner, "contact_dist") + var_0;
  self.soundaliases[self.soundaliases.size] = var_1;
  return true;
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

  return "100";
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

function bcgetclaimednode() {
  if(isPlayer(self)) {
    return self.node;
  }

  return scripts\anim\utility_common::getclaimednode();
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

function addthreatcalloutalias(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = getbattlechatteralias(self.owner, "threat_callout_" + var_0) + var_1;
  self.soundaliases[self.soundaliases.size] = var_2;
  return true;
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

function addthreatelevationalias(var_0) {
  var_1 = getbattlechatteralias(self.owner, "contact_elev") + var_0;
  self.soundaliases[self.soundaliases.size] = var_1;
  return true;
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
      var_5 = self;
      threatinfantryexposed(var_2, var_0);
      break;
    case "ai_obvious":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_0;
      }

      addthreatobviousalias(var_2);
      break;
    case "ai_distance":
      var_6 = self;
      var_7 = getdistancemetersnormalized(var_6.origin, var_0.origin);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_0;
      }

      addthreatdistancealias(var_2, var_7);
      break;
    case "ai_contact_clock":
      var_6 = self;
      var_8 = getrelativeangles(var_6);
      var_9 = getdirectionfacingclock(var_8, var_6.origin, var_0.origin);
      addthreatcalloutalias(var_2, "contactclock", var_9);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_0;
      }

      break;
    case "ai_casual_clock":
      var_6 = self;
      var_8 = getrelativeangles(var_6);
      var_9 = getdirectionfacingclock(var_8, var_6.origin, var_0.origin);
      addthreatcalloutalias(var_2, "contactclock", var_9);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_0;
      }

      break;
    case "ai_target_clock":
      var_6 = self;
      var_8 = getrelativeangles(var_6);
      var_9 = getdirectionfacingclock(var_8, var_6.origin, var_0.origin);
      addthreatcalloutalias(var_2, "targetclock", var_9);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_0;
      }

      break;
    case "ai_target_clock_high":
      var_6 = self;
      var_8 = getrelativeangles(var_6);
      var_9 = getdirectionfacingclock(var_8, var_6.origin, var_0.origin);
      var_10 = getdegreeselevation(var_6.origin, var_0.origin);

      if(var_10 >= 20 && var_10 <= 60) {
        addthreatcalloutalias(var_2, "targetclock_high", var_9);
        addthreatelevationalias(var_2, var_10);
      } else {
        return false;
      }

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_0;
      }

      break;
    case "ai_cardinal":
      var_6 = self;
      var_11 = getdirectioncompass(var_6.origin, var_0.origin);
      var_12 = normalizecompassdirection(var_11);

      if(var_12 == "impossible") {
        return false;
      }

      addthreatcalloutalias(var_2, "cardinal", var_12);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var_0;
      }

      break;
  }

  setlastcallouttype(var_3.type);
  var_5 = self;
  var_5.curevent = spawnStruct();
  var_5.curevent.eventaction = "threat";
  var_5.curevent.eventtype = "infantry";

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_line_ok = 0;
  }

  playphrase(var_5, var_2, self);

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  return true;
}

function playbattlechatter(var_0) {}

function evaluatereloadevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!battlechatterenabled() || !istrue(self.battlechatterallowed)) {
    return;
  }

  thread playinformevent("reloading", "generic");
}

function evaluateattackevent(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!battlechatterenabled() || !istrue(self.battlechatterallowed)) {
    return;
  }

  var_1 = "frag";

  switch (var_0) {
    case "frag":
      var_1 = "frag";
      break;
    case "grenade":
      var_1 = "grenade";
      break;
    case "emp":
      var_1 = "shock";
      break;
    case "offhandshield":
      var_1 = "shield";
      break;
    case "guns":
      var_1 = "weapon_guns";
      break;
    case "missile":
      var_1 = "weapon_missile";
      break;
    case "flare":
      var_1 = "weapon_flare";
      break;
    case "molotov":
      var_1 = "molotov";
      break;
  }

  thread playinformevent(var_1, "attack");
}

function playinformevent(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");
  var_3 = createchatphrase(var_2);
  addinformalias(var_3, var_0);
  var_2.curevent = spawnStruct();
  var_2.curevent.eventaction = "inform";
  var_2.curevent.eventtype = var_1;
  playphrase(var_2, var_3, self);
}

function playorderevent(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");
  var_3 = self;
  var_3.curevent = spawnStruct();
  var_3.curevent.eventaction = "order";
  var_3.curevent.eventtype = var_0;

  switch (var_0) {
    case "action":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = anim.player;
      }

      ref_1213b(var_1, var_2);
      break;
    case "move":
      ref_1213b(var_1, var_2);
      break;
    case "displace":
      ref_1213b(var_1);
      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  self notify("done speaking");
}

function ref_1213b(var_0, var_1) {
  var_2 = self;
  var_2 endon("death");
  var_2 endon("removed from battleChatter");
  var_3 = createchatphrase(var_2);
  addorderalias(var_3, "action", var_0);
  playphrase(var_2, var_3, self);
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

function dotypelimit(var_0, var_1) {
  if(!isDefined(level._battlechatter.nextsaytimes[var_0])) {
    level._battlechatter.nextsaytimes[var_0] = [];
  }

  level._battlechatter.nextsaytimes[var_0][var_1] = gettime() + anim.eventtypeminwait[var_0][var_1];
}

function cansay(var_0, var_1, var_2) {
  if(!istrue(self.battlechatterallowed)) {
    return false;
  }

  if(isDefined(level._battlechatter.nextsaytimes[var_0]) && isDefined(level._battlechatter.nextsaytimes[var_0][var_1]) && gettime() < level._battlechatter.nextsaytimes[var_0][var_1]) {
    return false;
  }

  if(issentient(self) && self.ignoreall) {
    return false;
  }

  if(self isinscriptedstate()) {
    return false;
  }

  return true;
}

function playphrase(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 0;

  if(isDefined(var_2)) {
    return var_3;
  }

  if(isDefined(self.battlechatter.isspeaking) && self.battlechatter.isspeaking) {
    return var_3;
  }

  if(!cansay(var_1, var_1.curevent.eventaction, var_1.curevent.eventtype)) {
    return var_3;
  }

  thread ref_13164(var_1, var_1.curevent.eventaction);

  for(var_4 = 0; var_4 < var_0.soundaliases.size; var_4++) {
    if(!isDefined(self._animactive) || isDefined(self._animactive) && self._animactive > 0) {
      continue;
    }

    if(!soundexists(var_0.soundaliases[var_4])) {
      continue;
    }

    var_5 = gettime();

    if(isradioline(var_0.soundaliases[var_4])) {
      var_6 = spawn("script_origin", self gettagorigin("J_Hip_RI"));
      var_6 linkTo(var_1);
    } else {
      var_6 = spawn("script_origin", self gettagorigin("j_head"));
      var_6 linkTo(var_1);
    }

    thread stop_speaking(var_0.soundaliases[var_4], var_6);
    self notify(var_0.soundaliases[var_4] + "_started");
    var_3 = 1;
    var_6 playSound(var_0.soundaliases[var_4]);
    wait lookupsoundlength(var_0.soundaliases[var_4]) / 1000;
    self notify(var_0.soundaliases[var_4]);
    var_6 delete();
    LOC_00000174:
  }

  self notify("playPhrase_done");
  return var_3;
}

function ref_13164(var_0, var_1) {
  self.battlechatter.isspeaking = 1;
  scripts\engine\utility::ref_143a5("playPhrase_done", "death");

  if(isDefined(self.battlechatter)) {
    self.battlechatter.isspeaking = 0;
  }

  dotypelimit(var_0, var_1);
}

function getbcstate() {
  return "combat";
}

function bc_prefix(var_0) {
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
      var_1 = var_2 + getbcstate() + "_concat_clock_";
      break;
    case "concat_compass":
      var_1 = var_2 + getbcstate() + "_concat_compass_";
      break;
    case "concat_dist":
      var_1 = var_2 + getbcstate() + "_concat_dist_";
      break;
    case "concat_elev":
      var_1 = var_2 + getbcstate() + "_concat_elev_";
      break;
    case "concat_left":
      var_1 = var_2 + getbcstate() + "_concat_left";
      break;
    case "concat_right":
      var_1 = var_2 + getbcstate() + "_concat_right";
      break;
    case "concat_center":
      var_1 = var_2 + getbcstate() + "_concat_center";
      break;
    case "concat_target":
      var_1 = var_2 + getbcstate() + "_concat_target";
      break;
    case "contact_dist":
      var_1 = var_2 + "contact_dist_";
      break;
    case "contact_elev":
      var_1 = var_2 + "contact_elev_";
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
    case "inform_grenade":
    case "inform_frag":
      var_1 = var_2 + "inform_grenade";
      break;
    case "inform_incoming_grenade":
      var_1 = var_2 + "inform_incoming_grenade";
      break;
    case "inform_killfirm_juggernaut":
    case "inform_killfirm_soldier":
      var_1 = var_2 + "inform_killfirm_soldier";
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
    case "location_response":
      var_1 = var_2 + getbcstate() + "_location_resp";
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
    case "threat_callout_cardinal":
      var_1 = var_2 + "cardinal_";
      break;
    case "threat_callout_contactclock":
      var_1 = var_2 + "contact_clock_";
      break;
    case "threat_callout_sighted":
      var_1 = var_2 + "sighted_";
      break;
    case "threat_callout_targetclock":
      var_1 = var_2 + "target_clock_";
      break;
    case "threat_callout_targetclock_high":
      var_1 = var_2 + "target_clock_high_";
      break;
    default:
      break;
  }

  return var_1;
}