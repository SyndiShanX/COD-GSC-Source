/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\battlechatter_ai.gsc
***********************************************/

addtosystem(var_0) {
  self endon("death");

  if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
    return;
  }
  if(self.chatinitialized) {
    return;
  }
  if(!isDefined(self.squad.chatinitialized) || !self.squad.chatinitialized)
    self.squad scripts\anim\battlechatter.gsc::init_squadbattlechatter();

  self.battlechatter.enemyclass = "infantry";
  self.battlechatter.calledout = [];
  self.battlechatter.friendlyfire_force = 1;

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
  scripts\anim\battlechatter_gamesku.gsc::assign_npcid();
  thread ainameandrankwaiter();
  init_aibattlechatter();
  thread aithreadthreader();
  thread scripts\anim\battlechatter.gsc::bcprint_info();
}

aithreadthreader() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self.team)) {
    return;
  }
  var_0 = 0.5;
  wait(var_0);
  thread aivehiclewaiter();
  thread aifolloworderwaiter();
  thread aiinformweaponwaiter();

  if(self.team == "allies") {
    wait(var_0);
    thread aidisplacewaiter();
  } else if((self.team == "axis" || self.team == "team3") && !scripts\anim\battlechatter_gamesku.gsc::isalliedcountryid(self.battlechatter.countryid)) {
    thread aihostileburstloop();
    var_0 = 5.0;
  }

  if(isDefined(anim.player) && self.team == anim.player.team)
    thread player_friendlyfire_waiter();

  wait(var_0);
  thread aibattlechatterloop();
}

setnpcid() {
  var_0 = anim.usedids[self.voice];
  var_1 = var_0.size;
  var_2 = randomintrange(0, var_1);
  var_3 = var_2;

  for(var_4 = 0; var_4 <= var_1; var_4++) {
    if(var_0[(var_2 + var_4) % var_1].count < var_0[var_3].count)
      var_3 = (var_2 + var_4) % var_1;
  }

  thread npcidtracker(var_3);
  self.battlechatter.npcid = var_0[var_3].npcid;
}

npcidtracker(var_0) {
  anim.usedids[self.voice][var_0].count++;
  scripts\engine\utility::waittill_either("death", "removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
    return;
  }
  anim.usedids[self.voice][var_0].count--;
}

aihostileburstloop() {
  self endon("death");
  self endon("removed from battleChatter");
  wait 2;

  for(;;) {
    if(!self.ignoreall && isDefined(self.enemy) && scripts\stealth\utility::bcisincombat()) {
      if(distancesquared(self.origin, anim.player.origin) < 1048576) {
        if(isDefined(self.squad.membercount) && self.squad.membercount > 1)
          addreactionevent("taunt", "hostileburst");
      }
    }

    wait(randomfloatrange(2, 5));
  }
}

aibattlechatterloop() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\stealth\utility::bcisincombat()) {
    var_0 = gettime();

    for(var_1 = var_0 + randomintrange(7, 15) * 1000; !scripts\stealth\utility::bcisincombat() && var_0 < var_1; var_0 = gettime())
      waitframe();

    scripts\anim\battlechatter.gsc::clearisspeaking("stealth");
  }

  for(;;) {
    scripts\anim\battlechatter.gsc::playbattlechatter();
    wait(0.3 + randomfloat(0.2));
  }
}

ainameandrankwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self.bcname = scripts\anim\battlechatter.gsc::getname();
    self.bcrank = scripts\anim\battlechatter.gsc::getrank();
    self.bccallsign = scripts\anim\battlechatter.gsc::getcallsign();
    self waittill("set name and rank");
  }
}

removefromsystem(var_0) {
  if(scripts\anim\battlechatter.gsc::bcsenabled()) {
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

  if(isDefined(self)) {
    self.battlechatter.chatqueue = undefined;
    self.battlechatter.nextsaytime = undefined;
    self.battlechatter.nextsaytimes = undefined;
    self.battlechatter.isspeaking = undefined;
    self.battlechatter.enemyclass = undefined;
    self.battlechatter.calledout = undefined;
    self.battlechatter.countryid = undefined;
    self.battlechatter.npcid = undefined;
  }
}

init_aibattlechatter() {
  self.battlechatter.chatqueue = [];
  self.battlechatter.chatqueue["threat"] = spawnStruct();
  self.battlechatter.chatqueue["threat"].expiretime = 0;
  self.battlechatter.chatqueue["threat"].priority = 0.0;
  self.battlechatter.chatqueue["response"] = spawnStruct();
  self.battlechatter.chatqueue["response"].expiretime = 0;
  self.battlechatter.chatqueue["response"].priority = 0.0;
  self.battlechatter.chatqueue["reaction"] = spawnStruct();
  self.battlechatter.chatqueue["reaction"].expiretime = 0;
  self.battlechatter.chatqueue["reaction"].priority = 0.0;
  self.battlechatter.chatqueue["inform"] = spawnStruct();
  self.battlechatter.chatqueue["inform"].expiretime = 0;
  self.battlechatter.chatqueue["inform"].priority = 0.0;
  self.battlechatter.chatqueue["vehicle"] = spawnStruct();
  self.battlechatter.chatqueue["vehicle"].expiretime = 0;
  self.battlechatter.chatqueue["vehicle"].priority = 0.0;
  self.battlechatter.chatqueue["order"] = spawnStruct();
  self.battlechatter.chatqueue["order"].expiretime = 0;
  self.battlechatter.chatqueue["order"].priority = 0.0;
  self.battlechatter.chatqueue["custom"] = spawnStruct();
  self.battlechatter.chatqueue["custom"].expiretime = 0;
  self.battlechatter.chatqueue["custom"].priority = 0.0;
  self.battlechatter.chatqueue["stealth"] = spawnStruct();
  self.battlechatter.chatqueue["stealth"].expiretime = 0;
  self.battlechatter.chatqueue["stealth"].priority = 0.0;
  self.battlechatter.nextsaytime = gettime() + 50;
  self.battlechatter.nextsaytimes["threat"] = 0;
  self.battlechatter.nextsaytimes["reaction"] = 0;
  self.battlechatter.nextsaytimes["response"] = 0;
  self.battlechatter.nextsaytimes["inform"] = 0;
  self.battlechatter.nextsaytimes["vehicle"] = 0;
  self.battlechatter.nextsaytimes["order"] = 0;
  self.battlechatter.nextsaytimes["custom"] = 0;
  self.battlechatter.nextsaytimes["stealth"] = 0;
  self.battlechatter.isspeaking = 0;
  self.battlechatter.minpriority = 0.0;
  self.allowedcallouts = [];
  scripts\anim\battlechatter.gsc::addallowedthreatcallout("exposed");
  scripts\anim\battlechatter.gsc::addallowedthreatcallout("generic_location");
  scripts\anim\battlechatter.gsc::addallowedthreatcallout("concat_location");
  scripts\anim\battlechatter.gsc::addallowedthreatcallout("ai_location");
  scripts\anim\battlechatter.gsc::addallowedthreatcallout("player_location");

  if(self.team == "allies")
    scripts\anim\battlechatter.gsc::addallowedthreatcallout("target_compass");

  scripts\anim\battlechatter.gsc::addallowedthreatcallout("target_distance");
  scripts\anim\battlechatter.gsc::addallowedthreatcallout("target_elev");
  self.battlechatterallowed = 0;

  if(isDefined(self.script_battlechatter) && self.script_battlechatter || anim.bcs_enabled)
    self.battlechatterallowed = level.battlechatter[self.team];

  self.flavorbursts = 0;

  if(scripts\anim\battlechatter.gsc::voicecanburst() && level.flavorbursts[self.team] == 1 && self != anim.player)
    self.flavorbursts = 1;
  else
    self.flavorbursts = 0;

  if(level.friendlyfire_warnings)
    scripts\engine\sp\utility::set_friendlyfire_warnings(1);
  else
    scripts\engine\sp\utility::set_friendlyfire_warnings(0);

  self.chatinitialized = 1;
}

addthreatevent(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::cansay("threat", var_0, var_2)) {
    return;
  }
  if(scripts\anim\battlechatter.gsc::threatwasalreadycalledout(var_1) && !isPlayer(var_1)) {
    return;
  }
  var_3 = scripts\anim\battlechatter.gsc::createchatevent("threat", var_0, var_2);

  switch (var_0) {
    case "acquired":
    case "infantry":
      var_3.threat = var_1;
      break;
  }

  if(isDefined(var_1.squad))
    self.squad scripts\anim\battlechatter.gsc::updatecontact(var_1.squad.squadname, self);

  self.battlechatter.chatqueue["threat"] = undefined;
  self.battlechatter.chatqueue["threat"] = var_3;
}

addresponseevent(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread addresponseevent_internal(var_0, var_1, var_2, var_3, var_4, var_5);
}

addresponseevent_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("responseEvent_failsafe");
  thread responseevent_failsafe(var_2);
  var_6 = var_2 scripts\engine\utility::waittill_any_return("death", "done speaking", "cancel speaking");

  if(var_6 == "cancel speaking") {
    return;
  }
  if(!isalive(var_2)) {
    return;
  }
  if(!scripts\anim\battlechatter.gsc::cansay("response", var_0, var_3)) {
    return;
  }
  if(!isPlayer(var_2)) {
    if(scripts\anim\battlechatter.gsc::isusingsamevoice(var_2))
      return;
  }

  var_7 = scripts\anim\battlechatter.gsc::createchatevent("response", var_0, var_3);

  if(isDefined(var_4))
    var_7.reportalias = var_4;

  if(isDefined(var_5))
    var_7.location = var_5;

  var_7.respondto = var_2;
  var_7.modifier = var_1;
  self.battlechatter.chatqueue["response"] = undefined;
  self.battlechatter.chatqueue["response"] = var_7;
}

responseevent_failsafe(var_0) {
  self endon("death");
  self endon("removed from battleChatter");
  var_0 endon("death");
  var_0 endon("done speaking");
  var_0 endon("cancel speaking");
  wait 25;
  self notify("responseEvent_failsafe");
}

addvehicleevent(var_0, var_1, var_2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::cansay("vehicle", var_0, var_2)) {
    return;
  }
  var_3 = scripts\anim\battlechatter.gsc::createchatevent("vehicle", var_0, var_2);
  var_3.modifier = var_1;
  self.battlechatter.chatqueue["vehicle"] = undefined;
  self.battlechatter.chatqueue["vehicle"] = var_3;
}

addinformevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::cansay("inform", var_0, var_2)) {
    return;
  }
  var_4 = scripts\anim\battlechatter.gsc::createchatevent("inform", var_0, var_2);

  switch (var_0) {
    case "reloading":
      var_4.modifier = var_1;
      break;
    case "killfirm":
      if(isDefined(var_3))
        var_4.threat_type = var_3;
    default:
      var_4.modifier = var_1;
  }

  self.battlechatter.chatqueue["inform"] = undefined;
  self.battlechatter.chatqueue["inform"] = var_4;
}

addreactionevent(var_0, var_1, var_2, var_3) {
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
  var_4 = scripts\anim\battlechatter.gsc::createchatevent("reaction", var_0, var_3);
  var_4.reactto = var_2;
  var_4.modifier = var_1;
  self.battlechatter.chatqueue["reaction"] = undefined;
  self.battlechatter.chatqueue["reaction"] = var_4;
}

addorderevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::cansay("order", var_0, var_3)) {
    return;
  }
  var_4 = scripts\anim\battlechatter.gsc::createchatevent("order", var_0, var_3);
  var_4.modifier = var_1;
  var_4.orderto = var_2;
  self.battlechatter.chatqueue["order"] = undefined;
  self.battlechatter.chatqueue["order"] = var_4;
}

addstealthevent(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::cansay("stealth", var_0, var_2))
    return 0;

  if(anim.eventpriority["stealth"][var_0] < self.battlechatter.chatqueue["stealth"].priority)
    return 0;

  var_4 = scripts\anim\battlechatter.gsc::createchatevent("stealth", var_0, var_2);

  if(isDefined(var_3))
    var_4.location = var_3.origin;

  var_4.modifier = var_1;
  self.battlechatter.chatqueue["stealth"] = undefined;
  self.battlechatter.chatqueue["stealth"] = var_4;
  return 1;
}

getthreatsovertime(var_0, var_1) {
  var_2 = var_0.size;

  if(var_2 == 0) {
    wait(var_1);
    return var_0;
  }

  var_3 = var_1 * 20;
  var_4 = var_2 / var_3;
  var_5 = [];

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_0[var_6];

    if(!isDefined(var_7) || isDefined(var_7) && var_7.code_classname != "script_vehicle" && !isDefined(var_7.voice)) {
      continue;
    }
    if(!isDefined(var_7.battlechatter.enemyclass)) {
      continue;
    }
    var_5[var_5.size] = var_0[var_6];
  }

  if(var_5.size == 0) {
    wait(var_1);
    return var_5;
  }

  var_5 = sortbydistance(var_5, anim.player.origin);
  var_8 = [];
  var_9 = [];
  var_10 = 0;

  foreach(var_12 in var_5) {
    if(isDefined(var_12) && threatisviable(var_12)) {
      var_13 = var_12 scripts\anim\battlechatter.gsc::getlocation();

      if(isDefined(var_13) && !scripts\anim\battlechatter.gsc::location_called_out_recently(var_13))
        var_8[var_8.size] = var_12;
      else
        var_9[var_9.size] = var_12;
    }

    var_10++;

    if(var_10 >= var_4) {
      waitframe();
      var_10 = 0;
    }
  }

  var_5 = [];

  foreach(var_16 in var_8)
  var_5[var_5.size] = var_16;

  foreach(var_16 in var_9)
  var_5[var_5.size] = var_16;

  return var_5;
}

threatisviable(var_0) {
  if(distancesquared(anim.player.origin, var_0.origin) > level.bcs_maxthreatdistsqrdfromplayer)
    return 0;

  if(self.team != "allies" && !anim.player scripts\anim\battlechatter.gsc::entinfrontarc(var_0))
    return 0;

  return 1;
}

squadthreatwaiter() {
  anim endon("battlechatter disabled");
  anim endon("squad deleted " + self.squadname);

  for(;;) {
    while(!isDefined(anim.bcs_enabled) || !anim.bcs_enabled)
      waitframe();

    while(anim.bcs_enabled) {
      if(self.team == "allies") {
        var_0 = getaiarray("axis", "team3");
        var_1 = getthreatsovertime(var_0, 0.5);
      } else if(self.team == "team3") {
        var_0 = getaiarray("allies", "axis");
        var_1 = getthreatsovertime(var_0, 0.5);
      } else {
        waitframe();
        var_0 = getaiarray("allies", "team3");
        var_1 = var_0;
        var_1[var_1.size] = anim.player;
      }

      if(!var_1.size) {
        wait 0.1;
        continue;
      }

      var_2 = [];

      foreach(var_12, var_4 in self.members) {
        if(!isalive(var_4)) {
          continue;
        }
        if(!var_4 scripts\stealth\utility::bcisincombat()) {
          if(var_4.team != "allies" && isDefined(var_4.fnisinstealthinvestigate) && var_4[[var_4.fnisinstealthinvestigate]]())
            var_4 addstealthevent("investigate");
          else if(var_4.team != "allies" && isDefined(var_4.fnisinstealthhunt) && var_4[[var_4.fnisinstealthhunt]]()) {
            if(istrue(self.in_dynolight_trigger) && scripts\engine\utility::ent_flag("in_the_dark") && !scripts\stealth\utility::group_flag("stealth_combat_hunting")) {}
          }

          var_4.laststealthtime = gettime();
          continue;
        }

        while(isalive(var_4) && var_4.team == "axis" && isDefined(var_4.laststealthtime) && gettime() - var_4.laststealthtime < 1000)
          waitframe();

        if(!var_1.size) {
          var_1 = var_2;
          var_2 = [];
        }

        foreach(var_11, var_6 in var_1) {
          if(!isDefined(var_6)) {
            if(var_11 == 0)
              var_1 = [];

            continue;
          }

          if(!isalive(var_6)) {
            continue;
          }
          if(!isDefined(var_6.battlechatter.enemyclass)) {
            continue;
          }
          if(!var_4 bccansee(var_6)) {
            if(isPlayer(var_6)) {
              continue;
            }
            if(!isDefined(var_6.team) || isDefined(var_6.team) && var_6.team == anim.player.team) {
              continue;
            }
            if(!anim.player bccansee(var_6))
              continue;
          }

          if(isDefined(var_4.bt) && isDefined(var_4.bt.pursuer))
            var_4 addreactionevent("danger", undefined, var_4.bt.pursuer);
          else
            var_4 addthreatevent(var_6.battlechatter.enemyclass, var_6);

          var_2[var_2.size] = var_6;
          var_7 = [];

          foreach(var_9 in var_1) {
            if(var_9 != var_6)
              var_7[var_7.size] = var_9;
          }

          var_1 = var_7;
          break;
        }

        waitframe();
      }

      waitframe();
    }
  }
}

bccansee(var_0, var_1) {
  if(!isDefined(self))
    return 0;
  else if(var_0.code_classname == "script_vehicle")
    return 1;
  else if(self == level.player) {
    if(scripts\anim\utility_common.gsc::player_can_see_ai(level.player, var_0))
      return 1;
  } else if(self cansee(var_0))
    return 1;
  else if(!istrue(var_1) && var_0 iscurrentenemyvalid() && gettime() - anim.lastteamspokentime[self.team] > 5000)
    return 1;

  return 0;
}

aideathfriendly() {
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
  scripts\engine\utility::array_thread(self.squad.members, ::aideatheventthread, self);

  if(!isDefined(var_0.battlechatterallowed)) {
    return;
  }
  if(isalive(var_0) && !isPlayer(var_0) && isDefined(var_0.squad) && var_0.battlechatterallowed) {
    if(isDefined(var_0.battlechatter.calledout) && isDefined(var_0.battlechatter.calledout[var_0.squad.squadname]))
      var_0.battlechatter.calledout[var_0.squad.squadname] = undefined;

    if(!isDefined(var_0.battlechatter.enemyclass)) {
      return;
    }
    if(!var_0 scripts\anim\battlechatter.gsc::is_in_callable_location()) {
      return;
    }
    foreach(var_2 in self.squad.members) {
      if(var_2 == anim.player) {
        continue;
      }
      if(gettime() > var_2.lastenemysighttime + 2000) {
        continue;
      }
      var_2 addthreatevent(var_0.battlechatter.enemyclass, var_0);
    }
  }
}

aideatheventthread(var_0) {
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiDeathEventThread");
  self endon("aiDeathEventThread");

  if(self == anim.player) {
    if(isDefined(var_0) && !anim.player bccansee(var_0, 1))
      return;
  }

  wait 1.2;
  addreactionevent("casualty", "generic", var_0, 0.9);
}

aideathenemy() {
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
  if(!scripts\anim\battlechatter_gamesku.gsc::isalliedcountryid(var_0.battlechatter.countryid)) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = self.unittype;

  if(isDefined(var_1))
    var_0 thread aikilleventthread(var_1);
}

aikilleventthread(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(var_0 == "civilian") {
    return;
  }
  wait 1.2;
  addinformevent("killfirm", "generic", undefined, var_0);
}

aiinformweaponwaiter() {
  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiInformWeaponWaiter");
  self endon("aiInformWeaponWaiter");
  childthread waittill_missile_fire();
  childthread waittill_grenade_danger();
  childthread waittill_sniper();

  for(;;) {
    level waittill("bc_inform_weapon", var_0, var_1, var_2);

    if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
      return;
    }
    if(var_1 == self.team && var_0 == "grenade") {
      addinformevent("incoming", var_0);
      continue;
    }

    if(var_1 != self.team) {
      if(isDefined(var_2) && var_0 == "sniper" && distance2dsquared(self.origin, var_2.origin) < 1048576) {
        continue;
      }
      addinformevent("incoming", var_0);
    }
  }
}

waittill_missile_fire() {
  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(scripts\anim\battlechatter_gamesku.gsc::bcisrpg(var_1.classname) && isDefined(self.team))
      level notify("bc_inform_weapon", "rpg", self.team);

    waitframe();
  }
}

waittill_grenade_danger() {
  for(;;) {
    self waittill("grenade danger", var_0, var_1);

    if(isDefined(var_0)) {
      if(scripts\anim\battlechatter_gamesku.gsc::bcisgrenade(var_0.model) && isDefined(self.team))
        level notify("bc_inform_weapon", "grenade", self.team);
    }

    waitframe();
  }
}

waittill_sniper() {
  if(!isDefined(self.team)) {
    return;
  }
  var_0 = undefined;

  for(;;) {
    if(!isPlayer(self)) {
      if(scripts\anim\utility_common.gsc::isasniper(1)) {
        self waittill("sniper_weapon_fired");
        var_0 = 1;
      } else
        break;
    } else {
      self waittill("attack_pressed");

      if(level.player playerads() == 1 && isDefined(self.currentweapon) && scripts\anim\utility_common.gsc::issniperrifle(self.currentweapon) && self isfiring())
        var_0 = 1;
    }

    if(istrue(var_0)) {
      wait 1;
      var_0 = undefined;
      level notify("bc_inform_weapon", "sniper", self.team, self);
    }

    wait 10;
  }
}

aidisplacewaiter() {
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
    addresponseevent("ack", "affirm", anim.player, 1.0);
  }
}

evaluatemoveevent(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
    return;
  }
  if(!isDefined(self.node)) {
    return;
  }
  if(distancesquared(self.origin, self.node.origin) < 23040) {
    return;
  }
  if(!scripts\anim\battlechatter.gsc::isnodecoverorconceal()) {
    return;
  }
  if(!nationalityokformoveorder()) {
    return;
  }
  var_1 = scripts\anim\battlechatter.gsc::getresponder(24, 1024, "response");

  if(self.team != "axis" && self.team != "team3") {
    if(!isDefined(var_1))
      var_1 = anim.player;
    else if(randomint(100) < anim.eventchance["moveEvent"]["ordertoplayer"])
      var_1 = anim.player;
  }

  if(self.combattime > 0.0) {
    if(randomint(100) < anim.eventchance["moveEvent"]["coverme"])
      addorderevent("action", "coverme", var_1);
    else
      addorderevent("move", "movecombat", var_1);
  } else if(nationalityokformoveordernoncombat()) {
    if(gettime() - self.starttime > 3000)
      addorderevent("move", "movenoncombat", var_1);
  }
}

nationalityokformoveorder() {
  if(isDefined(self.battlechatter.countryid) && self.battlechatter.countryid == "SS")
    return 0;

  return 1;
}

nationalityokformoveordernoncombat() {
  if(!isDefined(self.battlechatter.countryid))
    return 0;

  if(!scripts\anim\battlechatter_gamesku.gsc::isalliedmilitarycountryid(self.battlechatter.countryid))
    return 0;

  return 1;
}

aifolloworderwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    level waittill("follow order", var_0);

    if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
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
    if(distancesquared(self.origin, var_0.origin) < 360000)
      addresponseevent("ack", "affirm", var_0, 0.9);
  }
}

aivehiclewaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
      return;
    }
    if(!isDefined(self.team)) {
      return;
    }
    var_0 = ["axis", "allies", "team3"];
    var_0 = scripts\engine\utility::array_remove(var_0, self.team);
    var_1 = scripts\engine\sp\utility::getteamvehiclearray(var_0);
    var_1 = sortbydistance(var_1, self.origin);

    foreach(var_3 in var_1) {
      if(isDefined(var_3.battlechatter) && !isDefined(var_3.battlechatter.informed)) {
        if(distancesquared(self.origin, var_3.origin) < 25000000) {
          if(isDefined(var_3.battlechatter.enemyclass)) {
            var_3.battlechatter.informed = 1;
            addvehicleevent("incoming", var_3.battlechatter.enemyclass);
            continue;
          }

          var_3.battlechatter.informed = 1;
        }
      }
    }

    wait 2;
  }
}

aivehiclekillwaiter() {
  var_0 = self.battlechatter.enemyclass;
  self waittill("death", var_1);

  if(isDefined(var_1)) {
    if(!isDefined(self.team)) {
      return;
    }
    var_2 = self.team;
    var_3 = ["axis", "allies"];
    var_3 = scripts\engine\utility::array_remove(var_3, var_2);
    wait 2;
    var_4 = getaiarray(var_3[0]);

    foreach(var_6 in var_4)
    var_6 addvehicleevent("killfirm", var_0);
  }
}

player_friendlyfire_waiter() {
  self endon("death");
  self endon("removed from battleChatter");
  thread player_friendlyfire_waiter_damage();

  for(;;) {
    self waittill("bulletwhizby", var_0, var_1);

    if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
      continue;
    }
    if(!isPlayer(var_0)) {
      if(anim.countryids[self.voice] == "GM" && scripts\anim\battlechatter.gsc::cansay("reaction", "takingfire", 1.0))
        addreactionevent("takingfire", undefined, var_0, 1.0);

      continue;
    }
  }
}

player_friendlyfire_addreactionevent() {
  addreactionevent("friendlyfire", undefined, anim.player, 1.0);
}

player_friendlyfire_waiter_damage() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self waittill("damage", var_0, var_1, var_0, var_0, var_2);

    if(isDefined(var_1) && var_1 == anim.player) {
      if(damage_is_valid_for_friendlyfire_warning(var_2))
        player_friendlyfire_addreactionevent();
    }
  }
}

damage_is_valid_for_friendlyfire_warning(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "MOD_CRUSH":
    case "MOD_IMPACT":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_MELEE":
      return 0;
  }

  return 1;
}

friendlyfire_whizby_distances_valid(var_0, var_1) {
  var_2 = 65536;
  var_3 = 42;

  if(distancesquared(var_0.origin, self.origin) < var_2)
    return 0;

  if(var_1 > var_3)
    return 0;

  return 1;
}

evaluatereloadevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
    return;
  }
  addinformevent("reloading", "generic");
}

evaluatemeleeevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::bcsenabled())
    return 0;

  if(!isDefined(self.enemy))
    return 0;

  return 0;
}

evaluatefiringevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
    return;
  }
  if(!isDefined(self.enemy))
    return;
}

evaluatesuppressionevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
    return;
  }
  addinformevent("suppressed", "generic");
}

evaluateattackevent(var_0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
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
      wait(randomfloatrange(1, 2));

      if(isalive(self))
        thread addreactionevent("movement");
    }
  }
}

custom_battlechatter_init_valid_phrases() {
  var_0 = [];
  var_0[var_0.size] = "order_move_combat";
  var_0[var_0.size] = "order_move_noncombat";
  var_0[var_0.size] = "order_action_coverme";
  var_0[var_0.size] = "inform_reloading";
  level.custombcs_validphrases = var_0;
}

custom_battlechatter_validate_phrase(var_0) {
  var_1 = 0;

  foreach(var_3 in level.custombcs_validphrases) {
    if(var_3 == var_0) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

get_phraseinvalidstr(var_0) {
  return anim.bcprintfailprefix + "custom battlechatter phrase '" + var_0 + "' isn't valid.look at _utility::custom_battlechatter_init_valid_phrases(), or the util script documentation for custom_battlechatter(), for a list of valid phrases.";
}

get_badcountryidstr(var_0) {
  return "AI at origin " + self.origin + "wasn't able to play custom battlechatter because his nationality is '" + self.battlechatter.countryid + "'.";
}

custom_battlechatter_internal(var_0) {
  if(!isDefined(level.custombcs_validphrases))
    custom_battlechatter_init_valid_phrases();

  var_0 = tolower(var_0);

  if(!custom_battlechatter_validate_phrase(var_0)) {
    var_1 = get_phraseinvalidstr(var_0);
    return 0;
  }

  var_2 = scripts\anim\battlechatter.gsc::getresponder(24, 512, "response");
  begincustomevent();

  switch (var_0) {
    case "order_move_combat":
      if(!nationalityokformoveorder()) {
        scripts\anim\battlechatter.gsc::battlechatter_printerror(get_badcountryidstr(var_0));
        return 0;
      }

      scripts\anim\battlechatter.gsc::tryorderto(self.customchatphrase, var_2);
      addmovecombataliasex();
      break;
    case "order_move_noncombat":
      if(!nationalityokformoveordernoncombat()) {
        scripts\anim\battlechatter.gsc::battlechatter_printerror(get_badcountryidstr(var_0));
        return 0;
      }

      addmovenoncombataliasex();
      break;
    case "order_action_coverme":
      scripts\anim\battlechatter.gsc::tryorderto(self.customchatphrase, var_2);
      addactioncovermealiasex();
      break;
    case "inform_reloading":
      addinformreloadingaliasex();
      break;
    default:
      var_1 = get_phraseinvalidstr(var_0);
      return 0;
  }

  endcustomevent(2000);
  return 1;
}

begincustomevent() {
  if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
    return;
  }
  self.customchatphrase = scripts\anim\battlechatter.gsc::createchatphrase();
}

addactioncovermealiasex() {
  self.customchatphrase scripts\anim\battlechatter.gsc::addorderalias("action", "coverme");
}

addmovecombataliasex() {
  self.customchatphrase scripts\anim\battlechatter.gsc::addorderalias("move", "movecombat");
}

addmovenoncombataliasex() {
  self.customchatphrase scripts\anim\battlechatter.gsc::addorderalias("move", "movenoncombat");
}

addinformreloadingaliasex() {
  self.customchatphrase scripts\anim\battlechatter.gsc::addinformalias("reloading");
}

addnamealiasex(var_0) {
  if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
    return;
  }
  self.customchatphrase scripts\anim\battlechatter.gsc::addnamealias(var_0);
}

endcustomevent(var_0, var_1) {
  if(!scripts\anim\battlechatter.gsc::bcsenabled()) {
    return;
  }
  var_2 = scripts\anim\battlechatter.gsc::createchatevent("custom", "generic", 1.0);

  if(isDefined(var_0))
    var_2.expiretime = gettime() + var_0;

  if(isDefined(var_1))
    var_2.type = var_1;
  else
    var_2.type = "custom";

  self.battlechatter.chatqueue["custom"] = undefined;
  self.battlechatter.chatqueue["custom"] = var_2;
}

getbcstate() {
  if(isDefined(self.fnisinstealthidle) && [[self.fnisinstealthidle]]()) {
    if(isDefined(self.demeanoroverride) && self.demeanoroverride == "alert")
      return "alert";
    else
      return "idle";
  } else if(isDefined(self.fnisinstealthinvestigate) && [[self.fnisinstealthinvestigate]]())
    return "investigate";
  else if(isDefined(self.fnisinstealthhunt) && [[self.fnisinstealthhunt]]())
    return "hunt";
  else if(isDefined(self.fnisinstealthcombat) && [[self.fnisinstealthcombat]]())
    return "combat";
  else
    return "combat";
}