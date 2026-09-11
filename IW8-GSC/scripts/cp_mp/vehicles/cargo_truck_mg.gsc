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

function battlechatterenabled() {
  return istrue(level.dialog_system);
}

function autoassignquest(var0) {
  var0.battlechatterallowed = 1;
  level._battlechatter.ai[level._battlechatter.ai.size] = var0;
  var0.battlechatter = spawnStruct();
  var0.battlechatter.countryid = anim.countryids[var0.voice];
  setnpcid(var0);
  thread ref_12be5(var0);
  thread ref_11e60();
}

function ref_12bc1(var0) {
  level._battlechatter.ai = scripts\engine\utility::array_remove(level._battlechatter.ai, var0);
  var0 notify("removed from battleChatter");
}

function ref_12be5(var0) {
  var0 waittill("death");
  ref_12bc1(var0);
}

function setnpcid() {
  var0 = anim.usedids[self.voice];
  var1 = var0.size;
  var2 = randomintrange(0, var1);
  var3 = var2;

  for(var4 = 0; var4 <= var1; var4++) {
    if(var0[(var2 + var4) % var1].count < var0[var3].count) {
      var3 = (var2 + var4) % var1;
    }
  }

  thread npcidtracker(var3);
  self.battlechatter.npcid = var0[var3].npcid;
}

function npcidtracker(var0) {
  var1 = self.voice;
  anim.usedids[var1][var0].count++;
  scripts\engine\utility::waittill_either("death", "removed from battleChatter");

  if(!battlechatterenabled()) {
    return;
  }

  anim.usedids[var1][var0].count--;
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

function evaluatemoveevent(var0) {
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

function addthreatevent(var0, var1, var2) {
  if(isPlayer(var1) || isDefined(var1.aitype)) {
    if(isDefined(self._blackboard)) {
      self._blackboard.battlechatter_target = var1;
    }

    var3 = threatinfantry(var1, undefined);
    return;
  }
}

function getthreatinfantrycallouttype(var0) {
  var1 = getdirectionfacingclock(self.angles, self.origin, var0.origin);
  var2 = var1;
  var3 = self;
  var4 = getdistancemeters(var3.origin, var0.origin);
  self.possiblethreatcallouts = [];

  if(isexposed(var0)) {
    addpossiblethreatcallout("exposed");
  }

  var5 = 0;

  if(var0.origin[2] - var3.origin[2] >= level.heightforhighcallout) {
    if(addpossiblethreatcallout("ai_target_clock_high")) {
      var5 = 1;
    }
  }

  addpossiblethreatcallout("ai_casual_clock");

  if(!var5) {
    if(var2 == "12") {
      addpossiblethreatcallout("ai_distance");

      if(var4 > level.mindistancecallout && var4 < level.maxdistancecallout) {
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

  var6 = getweightedchanceroll(self.possiblethreatcallouts, anim.threatcallouts);
  var7 = spawnStruct();
  var7.type = var6;
  return var7;
}

function addpossiblethreatcallout(var0) {
  var1 = 0;

  if(!callouttypewillrepeat(var0)) {
    var1 = 1;
  }

  if(!var1) {
    return var1;
  }

  self.possiblethreatcallouts[self.possiblethreatcallouts.size] = var0;
  return var1;
}

function setlastcallouttype(var0) {
  level._battlechatter.watch_for_player_going_belowmap_or_oob = var0;
  level._battlechatter.watch_for_player_in_gulag = gettime();
}

function callouttypewillrepeat(var0) {
  if(!isDefined(level._battlechatter.watch_for_player_going_belowmap_or_oob)) {
    return false;
  }

  if(!isDefined(level._battlechatter.watch_for_player_in_gulag)) {
    return false;
  }

  var1 = level._battlechatter.watch_for_player_going_belowmap_or_oob;
  var2 = level._battlechatter.watch_for_player_in_gulag;
  var3 = anim.ref_13b42;

  if(var0 == var1 && gettime() - var2 < var3) {
    return true;
  }

  return false;
}

function isexposed(var0) {
  if(distancesquared(self.origin, var0.origin) > 2250000) {
    return false;
  }

  var1 = bcgetclaimednode(var0);

  if(!isDefined(var1)) {
    return true;
  }

  if(!isnodecoverorconceal(var0)) {
    return false;
  }

  return true;
}

function threatinfantryexposed(var0) {
  var1 = [];
  var1 = scripts\engine\utility::array_add(var1, "open");
  var1 = scripts\engine\utility::array_add(var1, "breaking");
  var2 = var1[randomint(var1.size)];
  addthreatexposedalias(var2);
}

function addthreatexposedalias(var0) {
  if(var0 == "group") {
    var0 = "movement_group";
  }

  var1 = getbattlechatteralias(self.owner, "exposed_" + var0);
  self.soundaliases[self.soundaliases.size] = var1;
  return true;
}

function addthreatobviousalias() {
  var0 = getbattlechatteralias(self.owner, "order_suppress");
  self.soundaliases[self.soundaliases.size] = var0;
  return true;
}

function addthreatdistancealias(var0) {
  var1 = getbattlechatteralias(self.owner, "contact_dist") + var0;
  self.soundaliases[self.soundaliases.size] = var1;
  return true;
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

function addthreatcalloutalias(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "";
  }

  var2 = getbattlechatteralias(self.owner, "threat_callout_" + var0) + var1;
  self.soundaliases[self.soundaliases.size] = var2;
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

function addthreatelevationalias(var0) {
  var1 = getbattlechatteralias(self.owner, "contact_elev") + var0;
  self.soundaliases[self.soundaliases.size] = var1;
  return true;
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
      var5 = self;
      threatinfantryexposed(var2, var0);
      break;
    case "ai_obvious":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      addthreatobviousalias(var2);
      break;
    case "ai_distance":
      var6 = self;
      var7 = getdistancemetersnormalized(var6.origin, var0.origin);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      addthreatdistancealias(var2, var7);
      break;
    case "ai_contact_clock":
      var6 = self;
      var8 = getrelativeangles(var6);
      var9 = getdirectionfacingclock(var8, var6.origin, var0.origin);
      addthreatcalloutalias(var2, "contactclock", var9);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
    case "ai_casual_clock":
      var6 = self;
      var8 = getrelativeangles(var6);
      var9 = getdirectionfacingclock(var8, var6.origin, var0.origin);
      addthreatcalloutalias(var2, "contactclock", var9);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
    case "ai_target_clock":
      var6 = self;
      var8 = getrelativeangles(var6);
      var9 = getdirectionfacingclock(var8, var6.origin, var0.origin);
      addthreatcalloutalias(var2, "targetclock", var9);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
    case "ai_target_clock_high":
      var6 = self;
      var8 = getrelativeangles(var6);
      var9 = getdirectionfacingclock(var8, var6.origin, var0.origin);
      var10 = getdegreeselevation(var6.origin, var0.origin);

      if(var10 >= 20 && var10 <= 60) {
        addthreatcalloutalias(var2, "targetclock_high", var9);
        addthreatelevationalias(var2, var10);
      } else {
        return false;
      }

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
    case "ai_cardinal":
      var6 = self;
      var11 = getdirectioncompass(var6.origin, var0.origin);
      var12 = normalizecompassdirection(var11);

      if(var12 == "impossible") {
        return false;
      }

      addthreatcalloutalias(var2, "cardinal", var12);

      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = var0;
      }

      break;
  }

  setlastcallouttype(var3.type);
  var5 = self;
  var5.curevent = spawnStruct();
  var5.curevent.eventaction = "threat";
  var5.curevent.eventtype = "infantry";

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_line_ok = 0;
  }

  playphrase(var5, var2, self);

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  return true;
}

function playbattlechatter(var0) {}

function evaluatereloadevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!battlechatterenabled() || !istrue(self.battlechatterallowed)) {
    return;
  }

  thread playinformevent("reloading", "generic");
}

function evaluateattackevent(var0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!battlechatterenabled() || !istrue(self.battlechatterallowed)) {
    return;
  }

  var1 = "frag";

  switch (var0) {
    case "frag":
      var1 = "frag";
      break;
    case "grenade":
      var1 = "grenade";
      break;
    case "emp":
      var1 = "shock";
      break;
    case "offhandshield":
      var1 = "shield";
      break;
    case "guns":
      var1 = "weapon_guns";
      break;
    case "missile":
      var1 = "weapon_missile";
      break;
    case "flare":
      var1 = "weapon_flare";
      break;
    case "molotov":
      var1 = "molotov";
      break;
  }

  thread playinformevent(var1, "attack");
}

function playinformevent(var0, var1) {
  var2 = self;
  var2 endon("death");
  var2 endon("removed from battleChatter");
  var3 = createchatphrase(var2);
  addinformalias(var3, var0);
  var2.curevent = spawnStruct();
  var2.curevent.eventaction = "inform";
  var2.curevent.eventtype = var1;
  playphrase(var2, var3, self);
}

function playorderevent(var0, var1, var2) {
  self endon("death");
  self endon("removed from battleChatter");
  var3 = self;
  var3.curevent = spawnStruct();
  var3.curevent.eventaction = "order";
  var3.curevent.eventtype = var0;

  switch (var0) {
    case "action":
      if(isDefined(self._blackboard)) {
        self._blackboard.battlechatter_target = anim.player;
      }

      ref_1213b(var1, var2);
      break;
    case "move":
      ref_1213b(var1, var2);
      break;
    case "displace":
      ref_1213b(var1);
      break;
  }

  if(isDefined(self._blackboard)) {
    self._blackboard.battlechatter_alias = undefined;
    self._blackboard.battlechatter_target = undefined;
  }

  self notify("done speaking");
}

function ref_1213b(var0, var1) {
  var2 = self;
  var2 endon("death");
  var2 endon("removed from battleChatter");
  var3 = createchatphrase(var2);
  addorderalias(var3, "action", var0);
  playphrase(var2, var3, self);
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

function dotypelimit(var0, var1) {
  if(!isDefined(level._battlechatter.nextsaytimes[var0])) {
    level._battlechatter.nextsaytimes[var0] = [];
  }

  level._battlechatter.nextsaytimes[var0][var1] = gettime() + anim.eventtypeminwait[var0][var1];
}

function cansay(var0, var1, var2) {
  if(!istrue(self.battlechatterallowed)) {
    return false;
  }

  if(isDefined(level._battlechatter.nextsaytimes[var0]) && isDefined(level._battlechatter.nextsaytimes[var0][var1]) && gettime() < level._battlechatter.nextsaytimes[var0][var1]) {
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

function playphrase(var0, var1, var2) {
  self endon("death");
  var3 = 0;

  if(isDefined(var2)) {
    return var3;
  }

  if(isDefined(self.battlechatter.isspeaking) && self.battlechatter.isspeaking) {
    return var3;
  }

  if(!cansay(var1, var1.curevent.eventaction, var1.curevent.eventtype)) {
    return var3;
  }

  thread ref_13164(var1, var1.curevent.eventaction);

  for(var4 = 0; var4 < var0.soundaliases.size; var4++) {
    if(!isDefined(self._animactive) || isDefined(self._animactive) && self._animactive > 0) {
      continue;
    }

    if(!soundexists(var0.soundaliases[var4])) {
      continue;
    }

    var5 = gettime();

    if(isradioline(var0.soundaliases[var4])) {
      var6 = spawn("script_origin", self gettagorigin("J_Hip_RI"));
      var6 linkTo(var1);
    } else {
      var6 = spawn("script_origin", self gettagorigin("j_head"));
      var6 linkTo(var1);
    }

    thread stop_speaking(var0.soundaliases[var4], var6);
    self notify(var0.soundaliases[var4] + "_started");
    var3 = 1;
    var6 playSound(var0.soundaliases[var4]);
    wait lookupsoundlength(var0.soundaliases[var4]) / 1000;
    self notify(var0.soundaliases[var4]);
    var6 delete();
    LOC_00000174:
  }

  self notify("playPhrase_done");
  return var3;
}

function ref_13164(var0, var1) {
  self.battlechatter.isspeaking = 1;
  scripts\engine\utility::ref_143a5("playPhrase_done", "death");

  if(isDefined(self.battlechatter)) {
    self.battlechatter.isspeaking = 0;
  }

  dotypelimit(var0, var1);
}

function getbcstate() {
  return "combat";
}

function bc_prefix(var0) {
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
    case "inform_grenade":
    case "inform_frag":
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