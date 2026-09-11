/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_battlechatter_ai.gsc
***********************************************/

function addtosystem(var0) {
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

function addallowedthreatcallout(var0) {
  self.allowedcallouts[self.allowedcallouts.size] = var0;
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
    var0 = tolower(self.script_friendname);
    self.battlechatter.npcid = undefined;

    if(issubstr(var0, "alex")) {
      self.battlechatter.countryid = "alx";
      return;
    }

    if(issubstr(var0, "farah")) {
      self.battlechatter.countryid = "far";
      return;
    }

    if(issubstr(var0, "captain price")) {
      self.battlechatter.countryid = "pri";
      return;
    }

    if(issubstr(var0, "kyle")) {
      self.battlechatter.countryid = "kyle";
      return;
    }

    if(issubstr(var0, "hadir")) {
      self.battlechatter.countryid = "had";
      return;
    }

    setnpcid();
    return;
  }

  setnpcid();
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

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }

  anim.usedids[var1][var0].count--;
}

function aifolloworderwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    level waittill("follow order", var0);

    if(!scripts\cp\cp_battlechatter::bcsenabled()) {
      return;
    }

    if(!isDefined(self.team)) {
      return;
    }

    if(!isDefined(var0)) {
      continue;
    }

    if(!isalive(var0) || var0.team != self.team) {
      continue;
    }

    if(distancesquared(self.origin, var0.origin) < 360000) {
      addresponseevent("ack", "affirm", var0, 0.9);
    }
  }
}

function aigrenadedangerwaiter() {
  self endon("death");
  self endon("removed from battleChatter");
  var0 = undefined;

  for(;;) {
    self waittill("grenade danger", var1);

    if(getdvarint("bcs_enable") == 0) {
      continue;
    }

    if(isDefined(var1)) {
      var0 = aigrenadetypecheck(var1);

      if(!isDefined(var0)) {
        continue;
      }
    } else {
      continue;
    }

    addinformevent("incoming", var0);
  }
}

function aigrenadetypecheck(var0) {
  var1 = undefined;

  if(var0.model == "offhand_wm_grenade_mike67") {
    var1 = "grenade";
  }

  if(var0.model == "emp_grenade_wm") {
    var1 = "shock";
  }

  return var1;
}

function aithreadthreader() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self.team)) {
    return;
  }

  var0 = 0.5;
  wait var0;
  thread aigrenadedangerwaiter();
  thread aifolloworderwaiter();

  if(self.team == "allies") {
    wait var0;
    thread aidisplacewaiter();
  } else if((self.team == "axis" || self.team == "team3") && !isalliedcountryid(self.battlechatter.countryid)) {
    thread aihostileburstloop();
    var0 = 5;
  }

  if(isDefined(anim.player) && self.team == anim.player.team) {
    thread player_friendlyfire_waiter();
  }

  wait var0;
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

function isalliedcountryid(var0) {
  switch (var0) {
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
    self waittill("bulletwhizby", var0, var1);

    if(!scripts\cp\cp_battlechatter::bcsenabled()) {
      continue;
    }

    if(!isPlayer(var0)) {
      if(anim.countryids[self.voice] == "GM" && scripts\cp\cp_battlechatter::cansay("reaction", "takingfire", 1)) {
        addreactionevent("takingfire", undefined, var0, 1);
      }
    }
  }
}

function player_friendlyfire_waiter_damage() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("damage", var0, var1, var0, var0, var2);

    if(isDefined(var1) && var1 == anim.player) {
      if(damage_is_valid_for_friendlyfire_warning(var2)) {
        player_friendlyfire_addreactionevent();
      }
    }
  }
}

function damage_is_valid_for_friendlyfire_warning(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  switch (var0) {
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
    var0 = gettime();
    var1 = var0 + randomintrange(7, 15) * 1000;

    while(!scripts\stealth\utility::bcisincombat() && var0 < var1) {
      waitframe();
      var0 = gettime();
    }

    scripts\cp\cp_battlechatter::clearisspeaking("stealth");
  }

  for(;;) {
    scripts\cp\cp_battlechatter::playbattlechatter();
    wait 0.3 + randomfloat(0.2);
  }
}

function evaluatemoveevent(var0) {
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

  var1 = scripts\cp\cp_battlechatter::getresponder(24, 1024, "response");

  if(self.team != "axis" && self.team != "team3") {
    if(!isDefined(var1)) {
      var1 = anim.player;
    } else if(randomint(100) < anim.eventchance["moveEvent"]["ordertoplayer"]) {
      var1 = anim.player;
    }
  }

  if(true) {
    if(randomint(100) < anim.eventchance["moveEvent"]["coverme"]) {
      addorderevent("action", "coverme", var1);
      return;
    }

    addorderevent("move", "movecombat", var1);
    return;
  }

  if(nationalityokformoveordernoncombat()) {
    if(gettime() - self.starttime > 3000) {
      addorderevent("move", "movenoncombat", var1);
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

function addorderevent(var0, var1, var2, var3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::cansay("order", var0, var3)) {
    return;
  }

  var4 = scripts\cp\cp_battlechatter::createchatevent("order", var0, var3);
  var4.modifier = var1;
  var4.orderto = var2;
  self.battlechatter.chatqueue["order"] = undefined;
  self.battlechatter.chatqueue["order"] = var4;
}

function evaluatereloadevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }

  addinformevent("reloading", "generic");
}

function addinformevent(var0, var1, var2, var3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::cansay("inform", var0, var2)) {
    return;
  }

  var4 = scripts\cp\cp_battlechatter::createchatevent("inform", var0, var2);

  switch (var0) {
    case "reloading":
      var4.modifier = var1;
      break;
    case "killfirm":
      if(isDefined(var3)) {
        var4.threat_type = var3;
      }
    default:
      var4.modifier = var1;
      break;
  }

  self.battlechatter.chatqueue["inform"] = undefined;
  self.battlechatter.chatqueue["inform"] = var4;
}

function addreactionevent(var0, var1, var2, var3) {
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

  var4 = scripts\cp\cp_battlechatter::createchatevent("reaction", var0, var3);
  var4.reactto = var2;
  var4.modifier = var1;
  self.battlechatter.chatqueue["reaction"] = undefined;
  self.battlechatter.chatqueue["reaction"] = var4;
}

function addthreatevent(var0, var1, var2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::cansay("threat", var0, var2)) {
    return;
  }

  if(scripts\cp\cp_battlechatter::threatwasalreadycalledout(var1) && !isPlayer(var1)) {
    return;
  }

  var3 = scripts\cp\cp_battlechatter::createchatevent("threat", var0, var2);

  switch (var0) {
    case "infantry":
      var3.threat = var1;
      break;
    case "acquired":
      var3.threat = var1;
      break;
  }

  if(isDefined(var1.squad)) {
    self.squad scripts\cp\cp_battlechatter::updatecontact(var1.squad.squadname, self);
  }

  self.battlechatter.chatqueue["threat"] = undefined;
  self.battlechatter.chatqueue["threat"] = var3;
}

function evaluateattackevent(var0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::bcsenabled()) {
    return;
  }

  var1 = 0;
  var2 = "frag";

  switch (var0) {
    case "frag":
      var2 = "frag";
      break;
    case "grenade":
      var2 = "grenade";
      break;
    case "emp":
      var2 = "shock";
      break;
    case "offhandshield":
      var2 = "shield";
      break;
    case "guns":
      var2 = "weapon_guns";
      var1 = 1;
      break;
    case "missile":
      var2 = "weapon_missile";
      var1 = 1;
      break;
    case "flare":
      var2 = "weapon_flare";
      break;
    case "molotov":
      var2 = "molotov";
      break;
  }

  addinformevent("attack", var2);

  if(var1) {
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

function addresponseevent(var0, var1, var2, var3, var4, var5) {
  thread addresponseevent_internal(var0, var1, var2, var3, var4, var5);
}

function getthreatsovertime(var0, var1) {
  var2 = var0.size;

  if(var2 == 0) {
    wait var1;
    return var0;
  }

  var3 = var1 * 20;
  var4 = var2 / var3;
  var5 = [];

  for(var6 = 0; var6 < var2; var6++) {
    var7 = var0[var6];

    if(!isDefined(var7) || isDefined(var7) && !isDefined(var7.voice)) {
      continue;
    }

    if(!isDefined(var7.battlechatter.enemyclass)) {
      continue;
    }

    var5 = var0[var6];
  }

  if(var5.size == 0) {
    wait var1;
    return var5;
  }

  var5 = sortbydistance(var5, anim.player.origin);
  var8 = [];
  var9 = [];
  var10 = 0;

  foreach(var12 in var5) {
    if(isDefined(var12) && threatisviable(var12)) {
      var13 = var12 scripts\cp\cp_battlechatter::getlocation();

      if(isDefined(var13) && !scripts\cp\cp_battlechatter::location_called_out_recently(var13)) {
        var8 = var12;
      } else {
        var9 = var12;
      }
    }

    var10++;

    if(var10 >= var4) {
      waitframe();
      var10 = 0;
    }
  }

  var5 = [];

  foreach(var16 in var8) {
    var5 = var16;
  }

  foreach(var16 in var9) {
    var5 = var16;
  }

  return var5;
}

function aideathenemy() {
  var0 = self.attacker;
  var1 = undefined;

  if(!isDefined(var0)) {
    return;
  }

  if(!isalive(var0) || !issentient(var0) && var0 != anim.player || !isDefined(var0.squad)) {
    return;
  }

  if(!isDefined(var0.battlechatter.countryid)) {
    return;
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
      return;
  }

  if(!isDefined(var1)) {
    var1 = self.unittype;
  }

  if(isDefined(var1)) {
    thread aikilleventthread(var0);
    return;
  }
}

function aideathfriendly() {
  var0 = self.attacker;

  if(!isDefined(var0)) {
    return;
  }

  if(isDefined(self.unittype) && self.unittype == "seeker") {
    return;
  }

  if(isDefined(self.squad) && isDefined(var0.squad) && self.squad == var0.squad) {
    return;
  }

  scripts\engine\utility::array_thread(self.squad.members, &aideatheventthread, self);

  if(!isDefined(var0.battlechatterallowed)) {
    return;
  }

  if(isalive(var0) && !isPlayer(var0) && isDefined(var0.squad) && var0.battlechatterallowed) {
    if(isDefined(var0.battlechatter.calledout) && isDefined(var0.battlechatter.calledout[var0.squad.squadname])) {
      var0.battlechatter.calledout[var0.squad.squadname] = undefined;
    }

    if(!isDefined(var0.battlechatter.enemyclass)) {
      return;
    }

    if(!var0 scripts\cp\cp_battlechatter::is_in_callable_location()) {
      return;
    }

    foreach(var2 in self.squad.members) {
      if(var2 == anim.player) {
        continue;
      }

      if(gettime() > var2.lastenemysighttime + 2000) {
        continue;
      }

      addthreatevent(var2, var0.battlechatter.enemyclass, var0);
    }

    return;
  }
}

function aideatheventthread(var0) {
  if(!isalive(self)) {
    return;
  }

  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiDeathEventThread");
  self endon("aiDeathEventThread");

  if(self == anim.player) {
    if(isDefined(var0) && !anim.player scripts\cp\cp_battlechatter::bccansee(var0)) {
      return;
    }
  }

  wait 1.2;
  addreactionevent("casualty", "generic", var0, 0.9);
}

function aikilleventthread(var0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(var0 == "civilian") {
    return;
  }

  wait 1.2;
  addinformevent("killfirm", "generic", undefined, var0);
}

function removefromsystem(var0) {
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

function threatisviable(var0) {
  if(distancesquared(anim.player.origin, var0.origin) > level.bcs_maxthreatdistsqrdfromplayer) {
    return false;
  }

  if(isDefined(self.team)) {
    return true;
  }

  if(self.team != "allies" && !anim.player scripts\cp\cp_battlechatter::entinfrontarc(var0)) {
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
        var0 = getthreatsovertime(getaiarray("axis"), 0.5);
      } else if(self.team == "team3") {
        var0 = getthreatsovertime(getaiarray("allies", "axis"), 0.5);
      } else {
        waitframe();
        var0 = getaiarray("allies");
        var0 = anim.player;
      }

      if(!var0.size) {
        wait 0.1;
        continue;
      }

      var1 = [];

      foreach(var3 in self.members) {
        if(!isalive(var3)) {
          continue;
        }

        if(!var3 scripts\stealth\utility::bcisincombat()) {
          if(var3.team != "allies" && isDefined(var3.fnisinstealthinvestigate) && var3[[var3.fnisinstealthinvestigate]]()) {
            addstealthevent(var3, "investigate");
          } else if(var3.team != "allies" && isDefined(var3.fnisinstealthhunt) && var3[[var3.fnisinstealthhunt]]()) {} else if(var3.team != "allies" && isDefined(var3.fnisinstealthidle) && [[var3.fnisinstealthidle]]() == 0) {
            if(isDefined(var3.demeanoroverride) && var3.demeanoroverride == "alert") {
              addstealthevent(var3, "idle_alert");
            } else {
              addstealthevent(var3, "idle");
            }
          }

          var3.laststealthtime = gettime();
          continue;
        }

        while(isalive(var3) && var3.team == "axis" && isDefined(var3.laststealthtime) && gettime() - var3.laststealthtime < 1000) {
          waitframe();
        }

        if(!var0.size) {
          var0 = var1;
          var1 = [];
        }

        foreach(var5 in var0) {
          if(!isDefined(var5)) {
            if(var10 == 0) {
              var0 = [];
            }

            continue;
          }

          if(!isalive(var5)) {
            continue;
          }

          if(!var3 scripts\cp\cp_battlechatter::bccansee(var5)) {
            if(!anim.player scripts\cp\cp_battlechatter::bccansee(var5)) {
              continue;
            }
          }

          if(isDefined(var3.bt) && isDefined(var3.bt.pursuer)) {
            addreactionevent(var3, "danger", undefined, var3.bt.pursuer);
          } else {
            addthreatevent(var3, "infantry", var5);
          }

          var1 = var5;
          var6 = [];

          foreach(var8 in var0) {
            if(var8 != var5) {
              var6 = var8;
            }
          }

          var0 = var6;
          break;
        }

        waitframe();
      }

      waitframe();
    }
  }
}

function addstealthevent(var0, var1, var2, var3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\cp\cp_battlechatter::cansay("stealth", var0, var2)) {
    return false;
  }

  if(anim.eventpriority["stealth"][var0] < self.battlechatter.chatqueue["stealth"].priority) {
    return false;
  }

  var4 = scripts\cp\cp_battlechatter::createchatevent("stealth", var0, var2);

  if(isDefined(var3)) {
    var4.location = var3.origin;
  }

  var4.modifier = var1;
  self.battlechatter.chatqueue["stealth"] = undefined;
  self.battlechatter.chatqueue["stealth"] = var4;
  return true;
}

function addresponseevent_internal(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("responseEvent_failsafe");
  thread responseevent_failsafe(var2);
  var6 = var2 scripts\engine\utility::ref_143ae("death", "done speaking", "cancel speaking");

  if(var6 == "cancel speaking") {
    return;
  }

  if(!isalive(var2)) {
    return;
  }

  if(!scripts\cp\cp_battlechatter::cansay("response", var0, var3)) {
    return;
  }

  if(!isPlayer(var2)) {
    if(scripts\cp\cp_battlechatter::isusingsamevoice(var2)) {
      return;
    }
  }

  var7 = scripts\cp\cp_battlechatter::createchatevent("response", var0, var3);

  if(isDefined(var4)) {
    var7.reportalias = var4;
  }

  if(isDefined(var5)) {
    var7.location = var5;
  }

  var7.respondto = var2;
  var7.modifier = var1;
  self.battlechatter.chatqueue["response"] = undefined;
  self.battlechatter.chatqueue["response"] = var7;
}

function responseevent_failsafe(var0) {
  self endon("death");
  self endon("removed from battleChatter");
  var0 endon("death");
  var0 endon("done speaking");
  var0 endon("cancel speaking");
  wait 25;
  self notify("responseEvent_failsafe");
}