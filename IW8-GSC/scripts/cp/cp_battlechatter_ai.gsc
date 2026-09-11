/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_battlechatter_ai.gsc
***********************************************/

function addtosystem(var_0) {
  self endon("death");
  level endon("game_ended");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }

  if(self.chatinitialized) {
    return;
  }

  if(!isDefined(self.squad)) {
    return;
  }

  if(!isDefined(self.squad.chatinitialized) || !self.squad.chatinitialized) {
    self.squad scripts\cp\cp_battlechatter::init_squadbattlechatter();
  }

  self.battlechatter.enemyclass = "infantry";
  self.battlechatter.calledout = [];

  if(isPlayer(self)) {
    self.battlechatterallowed = 0;
    self.flavorbursts = 0;
    self.type = "human";
    return;
  }

  if(self.unittype == "dog") {
    self.battlechatter.enemyclass = undefined;
    self.battlechatterallowed = 0;
    self.flavorbursts = 0;
    return;
  }

  if(self.unittype == "juggernaut") {
    self.battlechatter.enemyclass = undefined;
    self.battlechatterallowed = 0;
    self.flavorbursts = 0;
    return;
  }

  if(self.team == "neutral") {
    self.battlechatter.enemyclass = undefined;
    self.battlechatterallowed = 0;
    self.flavorbursts = 0;
    return;
  }

  self.headknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "head"));
  self.scriptedtalkingknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "scripted_talking"));
  self.defaulttalk = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "default_talking"));

  if(!isDefined(self.voice)) {
    return;
  }

  self.battlechatter.countryid = anim.countryids[self.voice];

  if(!isDefined(self.battlechatter.countryid)) {
    return;
  }

  assign_npcid();
  thread ainameandrankwaiter();
  init_aibattlechatter();
  thread aithreadthreader();
  thread scripts\cp\cp_battlechatter::bcprint_info();
}

function init_aibattlechatter() {
  self.battlechatter.chatqueue = [];
  self.battlechatter.chatqueue["threat"] = spawnStruct();
  self.battlechatter.chatqueue["threat"].expiretime = 0;
  self.battlechatter.chatqueue["threat"].priority = 0;
  self.battlechatter.chatqueue["response"] = spawnStruct();
  self.battlechatter.chatqueue["response"].expiretime = 0;
  self.battlechatter.chatqueue["response"].priority = 0;
  self.battlechatter.chatqueue["reaction"] = spawnStruct();
  self.battlechatter.chatqueue["reaction"].expiretime = 0;
  self.battlechatter.chatqueue["reaction"].priority = 0;
  self.battlechatter.chatqueue["inform"] = spawnStruct();
  self.battlechatter.chatqueue["inform"].expiretime = 0;
  self.battlechatter.chatqueue["inform"].priority = 0;
  self.battlechatter.chatqueue["order"] = spawnStruct();
  self.battlechatter.chatqueue["order"].expiretime = 0;
  self.battlechatter.chatqueue["order"].priority = 0;
  self.battlechatter.chatqueue["custom"] = spawnStruct();
  self.battlechatter.chatqueue["custom"].expiretime = 0;
  self.battlechatter.chatqueue["custom"].priority = 0;
  self.battlechatter.chatqueue["stealth"] = spawnStruct();
  self.battlechatter.chatqueue["stealth"].expiretime = 0;
  self.battlechatter.chatqueue["stealth"].priority = 0;
  self.battlechatter.nextsaytime = gettime() + 50;
  self.battlechatter.nextsaytimes["threat"] = 0;
  self.battlechatter.nextsaytimes["reaction"] = 0;
  self.battlechatter.nextsaytimes["response"] = 0;
  self.battlechatter.nextsaytimes["inform"] = 0;
  self.battlechatter.nextsaytimes["order"] = 0;
  self.battlechatter.nextsaytimes["custom"] = 0;
  self.battlechatter.nextsaytimes["stealth"] = 0;
  self.battlechatter.isspeaking = 0;
  self.battlechatter.minpriority = 0;
  self.allowedcallouts = [];
  addallowedthreatcallout("exposed");

  if(self.team == "allies") {
    if(scripts\engine\utility::array_contains(anim.playernameids, self.voice)) {
      addallowedthreatcallout("player_contact_clock");
      addallowedthreatcallout("player_target_clock");
      addallowedthreatcallout("player_cardinal");
      addallowedthreatcallout("player_obvious");
      addallowedthreatcallout("player_object_clock");
      addallowedthreatcallout("player_location");
      addallowedthreatcallout("ai_contact_clock");
      addallowedthreatcallout("ai_target_clock");
    }

    addallowedthreatcallout("generic_location");
    addallowedthreatcallout("ai_obvious");
    addallowedthreatcallout("concat_location");
    addallowedthreatcallout("player_distance");
    addallowedthreatcallout("ai_distance");

    if(self.voice != "fsa" && self.voice != "fsafemale") {
      addallowedthreatcallout("ai_location");
      addallowedthreatcallout("ai_contact_clock");
      addallowedthreatcallout("ai_target_clock");
      addallowedthreatcallout("ai_casual_clock");
      addallowedthreatcallout("player_target_clock_high");
      addallowedthreatcallout("ai_target_clock_high");
    }
  } else {
    addallowedthreatcallout("ai_contact_clock");
    addallowedthreatcallout("ai_target_clock");
  }

  self.battlechatterallowed = 0;

  if(isDefined(self.script_battlechatter) && self.script_battlechatter || anim.bcs_enabled) {
    self.battlechatterallowed = level.battlechatter[self.team];
  }

  self.flavorbursts = 0;

  if(scripts\cp\cp_battlechatter::voicecanburst() && level.flavorbursts[self.team] == 1 && self != anim.player) {
    self.flavorbursts = 1;
  } else {
    self.flavorbursts = 0;
  }

  if(level.friendlyfire_warnings) {
    scripts\cp\utility::set_friendlyfire_warnings(1);
  } else {
    scripts\cp\utility::set_friendlyfire_warnings(0);
  }

  self.chatinitialized = 1;
}

function addallowedthreatcallout(var_0) {
  self.allowedcallouts[self.allowedcallouts.size] = var_0;
}

function ainameandrankwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self.bcname = scripts\cp\cp_battlechatter::getname();
    self.bcrank = scripts\cp\cp_battlechatter::getrank();
    self waittill("set name and rank");
  }
}

function assign_npcid() {
  if(isDefined(self.script_friendname)) {
    var_0 = tolower(self.script_friendname);
    self.battlechatter.npcid = undefined;

    if(issubstr(var_0, "alex")) {
      self.battlechatter.countryid = "alx";
      return;
    }

    if(issubstr(var_0, "farah")) {
      self.battlechatter.countryid = "far";
      return;
    }

    if(issubstr(var_0, "captain price")) {
      self.battlechatter.countryid = "pri";
      return;
    }

    if(issubstr(var_0, "kyle")) {
      self.battlechatter.countryid = "kyle";
      return;
    }

    if(issubstr(var_0, "hadir")) {
      self.battlechatter.countryid = "had";
      return;
    }

    setnpcid();
    return;
  }

  setnpcid();
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

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }

  anim.usedids[var_1][var_0].count--;
}

function aifolloworderwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    level waittill("follow order", var_0);

    if(!scripts\cp\cp_battlechatter::bcsenabled()) {
      return;
    }

    if(!isDefined(self.team)) {
      return;
    }

    if(!isDefined(var_0)) {
      continue;
    }

    if(!isalive(var_0) || var_0.team != self.team) {
      continue;
    }

    if(distancesquared(self.origin, var_0.origin) < 360000) {
      addresponseevent("ack", "affirm", var_0, 0.9);
    }
  }
}

function aigrenadedangerwaiter() {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 = undefined;

  for(;;) {
    self waittill("grenade danger", var_1);

    if(getdvarint("bcs_enable") == 0) {
      continue;
    }

    if(isDefined(var_1)) {
      var_0 = aigrenadetypecheck(var_1);

      if(!isDefined(var_0)) {
        continue;
      }
    } else {
      continue;
    }

    addinformevent("incoming", var_0);
  }
}

function aigrenadetypecheck(var_0) {
  var_1 = undefined;

  if(var_0.model == "offhand_wm_grenade_mike67") {
    var_1 = "grenade";
  }

  if(var_0.model == "emp_grenade_wm") {
    var_1 = "shock";
  }

  return var_1;
}

function aithreadthreader() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self.team)) {
    return;
  }

  var_0 = 0.5;
  wait var_0;
  thread aigrenadedangerwaiter();
  thread aifolloworderwaiter();

  if(self.team == "allies") {
    wait var_0;
    thread aidisplacewaiter();
  } else if((self.team == "axis" || self.team == "team3") && !isalliedcountryid(self.battlechatter.countryid)) {
    thread aihostileburstloop();
    var_0 = 5;
  }

  if(isDefined(anim.player) && self.team == anim.player.team) {
    thread player_friendlyfire_waiter();
  }

  wait var_0;
  thread aibattlechatterloop();
}

function aidisplacewaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("trigger");

    if(getdvarint("bcs_enable") == 0) {
      continue;
    }

    if(gettime() < self.a.paintime + 4000) {
      continue;
    }

    addresponseevent("ack", "affirm", anim.player, 1);
  }
}

function isalliedcountryid(var_0) {
  switch (var_0) {
    case "FSAW":
    case "SASW":
    case "USMW":
    case "FSA":
    case "USM":
    case "SAS":
      return 1;
    default:
      return 0;
  }
}

function aihostileburstloop() {
  self endon("death");
  self endon("removed from battleChatter");
  wait 2;

  for(;;) {
    if(scripts\stealth\utility::bcisincombat()) {
      if(isDefined(anim.player)) {
        if(distancesquared(self.origin, anim.player.origin) < 1048576) {
          if(isDefined(self.squad.membercount) && self.squad.membercount > 1) {
            addreactionevent("taunt", "hostileburst");
          }
        }
      }
    }

    wait randomfloatrange(2, 5);
  }
}

function player_friendlyfire_waiter() {
  self endon("death");
  self endon("removed from battleChatter");
  thread player_friendlyfire_waiter_damage();

  for(;;) {
    self waittill("bulletwhizby", var_0, var_1);

    if(!scripts\cp\cp_battlechatter::bcsenabled()) {
      continue;
    }

    if(!isPlayer(var_0)) {
      if(anim.countryids[self.voice] == "GM" && scripts\cp\cp_battlechatter::cansay("reaction", "takingfire", 1)) {
        addreactionevent("takingfire", undefined, var_0, 1);
      }
    }
  }
}

function player_friendlyfire_waiter_damage() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("damage", var_0, var_1, var_0, var_0, var_2);

    if(isDefined(var_1) && var_1 == anim.player) {
      if(damage_is_valid_for_friendlyfire_warning(var_2)) {
        player_friendlyfire_addreactionevent();
      }
    }
  }
}

function damage_is_valid_for_friendlyfire_warning(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  switch (var_0) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_CRUSH":
    case "MOD_IMPACT":
    case "MOD_MELEE":
      return false;
  }

  return true;
}

function player_friendlyfire_addreactionevent() {
  addreactionevent("friendlyfire", undefined, anim.player, 1);
}

function aibattlechatterloop() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\stealth\utility::bcisincombat()) {
    var_0 = gettime();
    var_1 = var_0 + randomintrange(7, 15) * 1000;

    while(!scripts\stealth\utility::bcisincombat() && var_0 < var_1) {
      waitframe();
      var_0 = gettime();
    }

    scripts\cp\cp_battlechatter::clearisspeaking("stealth");
  }

  for(;;) {
    scripts\cp\cp_battlechatter::playbattlechatter();
    wait 0.3 + randomfloat(0.2);
  }
}

function evaluatemoveevent(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }

  if(!isDefined(self.node)) {
    return;
  }

  if(distancesquared(self.origin, self.node.origin) < 23040) {
    return;
  }

  if(!scripts\cp\cp_battlechatter::isnodecoverorconceal()) {
    return;
  }

  if(!nationalityokformoveorder()) {
    return;
  }

  var_1 = scripts\cp\cp_battlechatter::getresponder(24, 1024, "response");

  if(self.team != "axis" && self.team != "team3") {
    if(!isDefined(var_1)) {
      var_1 = anim.player;
    } else if(randomint(100) < anim.eventchance["moveEvent"]["ordertoplayer"]) {
      var_1 = anim.player;
    }
  }

  if(true) {
    if(randomint(100) < anim.eventchance["moveEvent"]["coverme"]) {
      addorderevent("action", "coverme", var_1);
      return;
    }

    addorderevent("move", "movecombat", var_1);
    return;
  }

  if(nationalityokformoveordernoncombat()) {
    if(gettime() - self.starttime > 3000) {
      addorderevent("move", "movenoncombat", var_1);
      return;
    }

    return;
  }
}

function nationalityokformoveorder() {
  if(isDefined(self.battlechatter.countryid) && self.battlechatter.countryid == "SS") {
    return false;
  }

  return true;
}

function nationalityokformoveordernoncombat() {
  if(!isDefined(self.battlechatter.countryid)) {
    return 0;
  }

  switch (self.battlechatter.countryid) {
    case "SASW":
    case "USMW":
    case "USM":
    case "SAS":
      return 1;
    default:
      return 0;
  }
}

function addorderevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::cansay("order", var_0, var_3)) {
    return;
  }

  var_4 = scripts\cp\cp_battlechatter::createchatevent("order", var_0, var_3);
  var_4.modifier = var_1;
  var_4.orderto = var_2;
  self.battlechatter.chatqueue["order"] = undefined;
  self.battlechatter.chatqueue["order"] = var_4;
}

function evaluatereloadevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }

  addinformevent("reloading", "generic");
}

function addinformevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::cansay("inform", var_0, var_2)) {
    return;
  }

  var_4 = scripts\cp\cp_battlechatter::createchatevent("inform", var_0, var_2);

  switch (var_0) {
    case "reloading":
      var_4.modifier = var_1;
      break;
    case "killfirm":
      if(isDefined(var_3)) {
        var_4.threat_type = var_3;
      }
    default:
      var_4.modifier = var_1;
      break;
  }

  self.battlechatter.chatqueue["inform"] = undefined;
  self.battlechatter.chatqueue["inform"] = var_4;
}

function addreactionevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self.battlechatter.chatqueue)) {
    return;
  }

  if(!isDefined(anim.eventduration) || !isDefined(anim.eventpriority)) {
    return;
  }

  if(!scripts\stealth\utility::bcisincombat()) {
    return;
  }

  var_4 = scripts\cp\cp_battlechatter::createchatevent("reaction", var_0, var_3);
  var_4.reactto = var_2;
  var_4.modifier = var_1;
  self.battlechatter.chatqueue["reaction"] = undefined;
  self.battlechatter.chatqueue["reaction"] = var_4;
}

function addthreatevent(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::cansay("threat", var_0, var_2)) {
    return;
  }

  if(scripts\cp\cp_battlechatter::threatwasalreadycalledout(var_1) && !isPlayer(var_1)) {
    return;
  }

  var_3 = scripts\cp\cp_battlechatter::createchatevent("threat", var_0, var_2);

  switch (var_0) {
    case "infantry":
      var_3.threat = var_1;
      break;
    case "acquired":
      var_3.threat = var_1;
      break;
  }

  if(isDefined(var_1.squad)) {
    self.squad scripts\cp\cp_battlechatter::updatecontact(var_1.squad.squadname, self);
  }

  self.battlechatter.chatqueue["threat"] = undefined;
  self.battlechatter.chatqueue["threat"] = var_3;
}

function evaluateattackevent(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }

  var_1 = 0;
  var_2 = "frag";

  switch (var_0) {
    case "frag":
      var_2 = "frag";
      break;
    case "grenade":
      var_2 = "grenade";
      break;
    case "emp":
      var_2 = "shock";
      break;
    case "offhandshield":
      var_2 = "shield";
      break;
    case "guns":
      var_2 = "weapon_guns";
      var_1 = 1;
      break;
    case "missile":
      var_2 = "weapon_missile";
      var_1 = 1;
      break;
    case "flare":
      var_2 = "weapon_flare";
      break;
    case "molotov":
      var_2 = "molotov";
      break;
  }

  addinformevent("attack", var_2);

  if(var_1) {
    if(randomint(100) < 25) {
      wait randomfloatrange(1, 2);

      if(isalive(self)) {
        thread addreactionevent("movement");
        return;
      }

      return;
    }

    return;
  }
}

function addresponseevent(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread addresponseevent_internal(var_0, var_1, var_2, var_3, var_4, var_5);
}

function getthreatsovertime(var_0, var_1) {
  var_2 = var_0.size;

  if(var_2 == 0) {
    wait var_1;
    return var_0;
  }

  var_3 = var_1 * 20;
  var_4 = var_2 / var_3;
  var_5 = [];

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_0[var_6];

    if(!isDefined(var_7) || isDefined(var_7) && !isDefined(var_7.voice)) {
      continue;
    }

    if(!isDefined(var_7.battlechatter.enemyclass)) {
      continue;
    }

    var_5 = var_0[var_6];
  }

  if(var_5.size == 0) {
    wait var_1;
    return var_5;
  }

  var_5 = sortbydistance(var_5, anim.player.origin);
  var_8 = [];
  var_9 = [];
  var_10 = 0;

  foreach(var_12 in var_5) {
    if(isDefined(var_12) && threatisviable(var_12)) {
      var_13 = var_12 scripts\cp\cp_battlechatter::getlocation();

      if(isDefined(var_13) && !scripts\cp\cp_battlechatter::location_called_out_recently(var_13)) {
        var_8 = var_12;
      } else {
        var_9 = var_12;
      }
    }

    var_10++;

    if(var_10 >= var_4) {
      waitframe();
      var_10 = 0;
    }
  }

  var_5 = [];

  foreach(var_16 in var_8) {
    var_5 = var_16;
  }

  foreach(var_16 in var_9) {
    var_5 = var_16;
  }

  return var_5;
}

function aideathenemy() {
  var_0 = self.attacker;
  var_1 = undefined;

  if(!isDefined(var_0)) {
    return;
  }

  if(!isalive(var_0) || !issentient(var_0) && var_0 != anim.player || !isDefined(var_0.squad)) {
    return;
  }

  if(!isDefined(var_0.battlechatter.countryid)) {
    return;
  }

  switch (var_0.battlechatter.countryid) {
    case "FSAW":
    case "SASW":
    case "USMW":
    case "FSA":
    case "USM":
    case "SAS":
      break;
    default:
      return;
  }

  if(!isDefined(var_1)) {
    var_1 = self.unittype;
  }

  if(isDefined(var_1)) {
    thread aikilleventthread(var_0);
    return;
  }
}

function aideathfriendly() {
  var_0 = self.attacker;

  if(!isDefined(var_0)) {
    return;
  }

  if(isDefined(self.unittype) && self.unittype == "seeker") {
    return;
  }

  if(isDefined(self.squad) && isDefined(var_0.squad) && self.squad == var_0.squad) {
    return;
  }

  scripts\engine\utility::array_thread(self.squad.members, &aideatheventthread, self);

  if(!isDefined(var_0.battlechatterallowed)) {
    return;
  }

  if(isalive(var_0) && !isPlayer(var_0) && isDefined(var_0.squad) && var_0.battlechatterallowed) {
    if(isDefined(var_0.battlechatter.calledout) && isDefined(var_0.battlechatter.calledout[var_0.squad.squadname])) {
      var_0.battlechatter.calledout[var_0.squad.squadname] = undefined;
    }

    if(!isDefined(var_0.battlechatter.enemyclass)) {
      return;
    }

    if(!var_0 scripts\cp\cp_battlechatter::is_in_callable_location()) {
      return;
    }

    foreach(var_2 in self.squad.members) {
      if(var_2 == anim.player) {
        continue;
      }

      if(gettime() > var_2.lastenemysighttime + 2000) {
        continue;
      }

      addthreatevent(var_2, var_0.battlechatter.enemyclass, var_0);
    }

    return;
  }
}

function aideatheventthread(var_0) {
  if(!isalive(self)) {
    return;
  }

  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiDeathEventThread");
  self endon("aiDeathEventThread");

  if(self == anim.player) {
    if(isDefined(var_0) && !anim.player scripts\cp\cp_battlechatter::bccansee(var_0)) {
      return;
    }
  }

  wait 1.2;
  addreactionevent("casualty", "generic", var_0, 0.9);
}

function aikilleventthread(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(var_0 == "civilian") {
    return;
  }

  wait 1.2;
  addinformevent("killfirm", "generic", undefined, var_0);
}

function removefromsystem(var_0) {
  if(scripts\cp\cp_battlechatter::bcsenabled()) {
    if(!isalive(self)) {
      if(isDefined(self)) {
        aideathfriendly();
        aideathenemy();
      }
    }
  }

  if(isDefined(self)) {
    self.battlechatterallowed = 0;
    self.chatinitialized = 0;
    self.battlechatter_removed = 1;
  }

  self notify("removed from battleChatter");

  if(isDefined(self) && isDefined(self.battlechatter)) {
    self.battlechatter.chatqueue = undefined;
    self.battlechatter.nextsaytime = undefined;
    self.battlechatter.nextsaytimes = undefined;
    self.battlechatter.isspeaking = undefined;
    self.battlechatter.enemyclass = undefined;
    self.battlechatter.calledout = undefined;
    self.battlechatter.countryid = undefined;
    self.battlechatter.npcid = undefined;
    return;
  }
}

function threatisviable(var_0) {
  if(distancesquared(anim.player.origin, var_0.origin) > level.bcs_maxthreatdistsqrdfromplayer) {
    return false;
  }

  if(isDefined(self.team)) {
    return true;
  }

  if(self.team != "allies" && !anim.player scripts\cp\cp_battlechatter::entinfrontarc(var_0)) {
    return false;
  }

  return true;
}

function squadthreatwaiter() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self.squadname);

  for(;;) {
    while(!isDefined(anim.bcs_enabled) || !anim.bcs_enabled) {
      waitframe();
    }

    while(anim.bcs_enabled) {
      if(self.team == "allies") {
        var_0 = getthreatsovertime(getaiarray("axis"), 0.5);
      } else if(self.team == "team3") {
        var_0 = getthreatsovertime(getaiarray("allies", "axis"), 0.5);
      } else {
        waitframe();
        var_0 = getaiarray("allies");
        var_0 = anim.player;
      }

      if(!var_0.size) {
        wait 0.1;
        continue;
      }

      var_1 = [];

      foreach(var_3 in self.members) {
        if(!isalive(var_3)) {
          continue;
        }

        if(!var_3 scripts\stealth\utility::bcisincombat()) {
          if(var_3.team != "allies" && isDefined(var_3.fnisinstealthinvestigate) && var_3[[var_3.fnisinstealthinvestigate]]()) {
            addstealthevent(var_3, "investigate");
          } else if(var_3.team != "allies" && isDefined(var_3.fnisinstealthhunt) && var_3[[var_3.fnisinstealthhunt]]()) {} else if(var_3.team != "allies" && isDefined(var_3.fnisinstealthidle) && [[var_3.fnisinstealthidle]]() == 0) {
            if(isDefined(var_3.demeanoroverride) && var_3.demeanoroverride == "alert") {
              addstealthevent(var_3, "idle_alert");
            } else {
              addstealthevent(var_3, "idle");
            }
          }

          var_3.laststealthtime = gettime();
          continue;
        }

        while(isalive(var_3) && var_3.team == "axis" && isDefined(var_3.laststealthtime) && gettime() - var_3.laststealthtime < 1000) {
          waitframe();
        }

        if(!var_0.size) {
          var_0 = var_1;
          var_1 = [];
        }

        foreach(var_5 in var_0) {
          if(!isDefined(var_5)) {
            if(var_10 == 0) {
              var_0 = [];
            }

            continue;
          }

          if(!isalive(var_5)) {
            continue;
          }

          if(!var_3 scripts\cp\cp_battlechatter::bccansee(var_5)) {
            if(!anim.player scripts\cp\cp_battlechatter::bccansee(var_5)) {
              continue;
            }
          }

          if(isDefined(var_3.bt) && isDefined(var_3.bt.pursuer)) {
            addreactionevent(var_3, "danger", undefined, var_3.bt.pursuer);
          } else {
            addthreatevent(var_3, "infantry", var_5);
          }

          var_1 = var_5;
          var_6 = [];

          foreach(var_8 in var_0) {
            if(var_8 != var_5) {
              var_6 = var_8;
            }
          }

          var_0 = var_6;
          break;
        }

        waitframe();
      }

      waitframe();
    }
  }
}

function addstealthevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::cansay("stealth", var_0, var_2)) {
    return false;
  }

  if(anim.eventpriority["stealth"][var_0] < self.battlechatter.chatqueue["stealth"].priority) {
    return false;
  }

  var_4 = scripts\cp\cp_battlechatter::createchatevent("stealth", var_0, var_2);

  if(isDefined(var_3)) {
    var_4.location = var_3.origin;
  }

  var_4.modifier = var_1;
  self.battlechatter.chatqueue["stealth"] = undefined;
  self.battlechatter.chatqueue["stealth"] = var_4;
  return true;
}

function addresponseevent_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("responseEvent_failsafe");
  thread responseevent_failsafe(var_2);
  var_6 = var_2 scripts\engine\utility::ref_143ae("death", "done speaking", "cancel speaking");

  if(var_6 == "cancel speaking") {
    return;
  }

  if(!isalive(var_2)) {
    return;
  }

  if(!scripts\cp\cp_battlechatter::cansay("response", var_0, var_3)) {
    return;
  }

  if(!isPlayer(var_2)) {
    if(scripts\cp\cp_battlechatter::isusingsamevoice(var_2)) {
      return;
    }
  }

  var_7 = scripts\cp\cp_battlechatter::createchatevent("response", var_0, var_3);

  if(isDefined(var_4)) {
    var_7.reportalias = var_4;
  }

  if(isDefined(var_5)) {
    var_7.location = var_5;
  }

  var_7.respondto = var_2;
  var_7.modifier = var_1;
  self.battlechatter.chatqueue["response"] = undefined;
  self.battlechatter.chatqueue["response"] = var_7;
}

function responseevent_failsafe(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 endon("death");
  var_0 endon("done speaking");
  var_0 endon("cancel speaking");
  wait 25;
  self notify("responseEvent_failsafe");
}