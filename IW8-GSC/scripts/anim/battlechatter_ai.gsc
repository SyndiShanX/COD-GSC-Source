/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_ai.gsc
***********************************************/

function addtosystem(var0) {
  self endon("death");

  if(!scripts\anim\battlechatter::bcsenabled()) {
    return;
  }

  if(self.chatinitialized) {
    return;
  }

  if(!isDefined(self.squad.chatinitialized) || !self.squad.chatinitialized) {
    self.squad scripts\anim\battlechatter::init_squadbattlechatter();
  }

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

  scripts\anim\battlechatter_gamesku::assign_npcid();
  thread ainameandrankwaiter();
  init_aibattlechatter();
  thread aithreadthreader();
  thread scripts\anim\battlechatter::bcprint_info();
}

function aithreadthreader() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!isDefined(self.team)) {
    return;
  }

  var0 = 0.5;
  wait var0;
  thread aivehiclewaiter();
  thread aifolloworderwaiter();
  thread aiinformweaponwaiter();

  if(self.team == "allies") {
    wait var0;
    thread aidisplacewaiter();
  } else if((self.team == "axis" || self.team == "team3") && !scripts\anim\battlechatter_gamesku::isalliedcountryid(self.battlechatter.countryid)) {
    thread aihostileburstloop();
    var0 = 5;
  }

  if(isDefined(anim.player) && self.team == anim.player.team) {
    thread player_friendlyfire_waiter();
  }

  wait var0;
  thread aibattlechatterloop();
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
  anim.usedids[self.voice][var0].count++;
  scripts\engine\utility::waittill_either("death", "removed from battleChatter");

  if(!scripts\anim\battlechatter::bcsenabled()) {
    return;
  }

  anim.usedids[self.voice][var0].count--;
}

function aihostileburstloop() {
  self endon("death");
  self endon("removed from battleChatter");
  wait 2;

  for(;;) {
    if(!self.ignoreall && isDefined(self.enemy) && scripts\stealth\utility::bcisincombat()) {
      if(distancesquared(self.origin, anim.player.origin) < 1048576) {
        if(isDefined(self.squad.membercount) && self.squad.membercount > 1) {
          addreactionevent("taunt", "hostileburst");
        }
      }
    }

    wait randomfloatrange(2, 5);
  }
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

    scripts\anim\battlechatter::clearisspeaking("stealth");
  }

  for(;;) {
    scripts\anim\battlechatter::playbattlechatter();
    wait 0.3 + randomfloat(0.2);
  }
}

function ainameandrankwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    self.bcname = scripts\anim\battlechatter::getname();
    self.bcrank = scripts\anim\battlechatter::getrank();
    self.bccallsign = scripts\anim\battlechatter::getcallsign();
    self waittill("set name and rank");
  }
}

function removefromsystem(var0) {
  if(scripts\anim\battlechatter::bcsenabled()) {
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
    return;
  }
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
  self.battlechatter.chatqueue["vehicle"] = spawnStruct();
  self.battlechatter.chatqueue["vehicle"].expiretime = 0;
  self.battlechatter.chatqueue["vehicle"].priority = 0;
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
  self.battlechatter.nextsaytimes["vehicle"] = 0;
  self.battlechatter.nextsaytimes["order"] = 0;
  self.battlechatter.nextsaytimes["custom"] = 0;
  self.battlechatter.nextsaytimes["stealth"] = 0;
  self.battlechatter.isspeaking = 0;
  self.battlechatter.minpriority = 0;
  self.allowedcallouts = [];
  scripts\anim\battlechatter::addallowedthreatcallout("exposed");
  scripts\anim\battlechatter::addallowedthreatcallout("generic_location");
  scripts\anim\battlechatter::addallowedthreatcallout("concat_location");
  scripts\anim\battlechatter::addallowedthreatcallout("ai_location");
  scripts\anim\battlechatter::addallowedthreatcallout("player_location");

  if(self.team == "allies") {
    scripts\anim\battlechatter::addallowedthreatcallout("target_compass");
  }

  scripts\anim\battlechatter::addallowedthreatcallout("target_distance");
  scripts\anim\battlechatter::addallowedthreatcallout("target_elev");
  self.battlechatterallowed = 0;

  if(isDefined(self.script_battlechatter) && self.script_battlechatter || anim.bcs_enabled) {
    self.battlechatterallowed = level.battlechatter[self.team];
  }

  self.flavorbursts = 0;

  if(scripts\anim\battlechatter::voicecanburst() && level.flavorbursts[self.team] == 1 && self != anim.player) {
    self.flavorbursts = 1;
  } else {
    self.flavorbursts = 0;
  }

  if(level.friendlyfire_warnings) {
    scripts\engine\sp\utility::set_friendlyfire_warnings(1);
  } else {
    scripts\engine\sp\utility::set_friendlyfire_warnings(0);
  }

  self.chatinitialized = 1;
}

function addthreatevent(var0, var1, var2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::cansay("threat", var0, var2)) {
    return;
  }

  if(scripts\anim\battlechatter::threatwasalreadycalledout(var1) && !isPlayer(var1)) {
    return;
  }

  var3 = scripts\anim\battlechatter::createchatevent("threat", var0, var2);

  switch (var0) {
    case "acquired":
    case "infantry":
      var3.threat = var1;
      break;
  }

  if(isDefined(var1.squad)) {
    self.squad scripts\anim\battlechatter::updatecontact(var1.squad.squadname, self);
  }

  self.battlechatter.chatqueue["threat"] = undefined;
  self.battlechatter.chatqueue["threat"] = var3;
}

function addresponseevent(var0, var1, var2, var3, var4, var5) {
  thread addresponseevent_internal(var0, var1, var2, var3, var4, var5);
}

function addresponseevent_internal(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  self endon("removed from battleChatter");
  self endon("responseEvent_failsafe");
  thread responseevent_failsafe(var2);
  var6 = var2 scripts\engine\utility::waittill_any_return("death", "done speaking", "cancel speaking");

  if(var6 == "cancel speaking") {
    return;
  }

  if(!isalive(var2)) {
    return;
  }

  if(!scripts\anim\battlechatter::cansay("response", var0, var3)) {
    return;
  }

  if(!isPlayer(var2)) {
    if(scripts\anim\battlechatter::isusingsamevoice(var2)) {
      return;
    }
  }

  var7 = scripts\anim\battlechatter::createchatevent("response", var0, var3);

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

function addvehicleevent(var0, var1, var2) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::cansay("vehicle", var0, var2)) {
    return;
  }

  var3 = scripts\anim\battlechatter::createchatevent("vehicle", var0, var2);
  var3.modifier = var1;
  self.battlechatter.chatqueue["vehicle"] = undefined;
  self.battlechatter.chatqueue["vehicle"] = var3;
}

function addinformevent(var0, var1, var2, var3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::cansay("inform", var0, var2)) {
    return;
  }

  var4 = scripts\anim\battlechatter::createchatevent("inform", var0, var2);

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

  var4 = scripts\anim\battlechatter::createchatevent("reaction", var0, var3);
  var4.reactto = var2;
  var4.modifier = var1;
  self.battlechatter.chatqueue["reaction"] = undefined;
  self.battlechatter.chatqueue["reaction"] = var4;
}

function addorderevent(var0, var1, var2, var3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::cansay("order", var0, var3)) {
    return;
  }

  var4 = scripts\anim\battlechatter::createchatevent("order", var0, var3);
  var4.modifier = var1;
  var4.orderto = var2;
  self.battlechatter.chatqueue["order"] = undefined;
  self.battlechatter.chatqueue["order"] = var4;
}

function addstealthevent(var0, var1, var2, var3) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::cansay("stealth", var0, var2)) {
    return false;
  }

  if(anim.eventpriority["stealth"][var0] < self.battlechatter.chatqueue["stealth"].priority) {
    return false;
  }

  var4 = scripts\anim\battlechatter::createchatevent("stealth", var0, var2);

  if(isDefined(var3)) {
    var4.location = var3.origin;
  }

  var4.modifier = var1;
  self.battlechatter.chatqueue["stealth"] = undefined;
  self.battlechatter.chatqueue["stealth"] = var4;
  return true;
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

    if(!isDefined(var7) || isDefined(var7) && var7.code_classname != "script_vehicle" && !isDefined(var7.voice)) {
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
      var13 = var12 scripts\anim\battlechatter::getlocation();

      if(isDefined(var13) && !scripts\anim\battlechatter::location_called_out_recently(var13)) {
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

function threatisviable(var0) {
  if(distancesquared(anim.player.origin, var0.origin) > level.bcs_maxthreatdistsqrdfromplayer) {
    return false;
  }

  if(self.team != "allies" && !anim.player scripts\anim\battlechatter::entinfrontarc(var0)) {
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
        var0 = getaiarray("axis", "team3");
        var1 = getthreatsovertime(var0, 0.5);
      } else if(self.team == "team3") {
        var0 = getaiarray("allies", "axis");
        var1 = getthreatsovertime(var0, 0.5);
      } else {
        waitframe();
        var0 = getaiarray("allies", "team3");
        var1 = var0;
        var1 = anim.player;
      }

      if(!var1.size) {
        wait 0.1;
        continue;
      }

      var2 = [];

      foreach(var4 in self.members) {
        if(!isalive(var4)) {
          continue;
        }

        if(!var4 scripts\stealth\utility::bcisincombat()) {
          if(var4.team != "allies" && isDefined(var4.fnisinstealthinvestigate) && var4[[var4.fnisinstealthinvestigate]]()) {
            addstealthevent(var4, "investigate");
          } else if(var4.team != "allies" && isDefined(var4.fnisinstealthhunt) && var4[[var4.fnisinstealthhunt]]()) {
            if(istrue(self.in_dynolight_trigger) && scripts\engine\utility::ent_flag("in_the_dark") && !scripts\stealth\utility::group_flag("stealth_combat_hunting")) {}
          }

          var4.laststealthtime = gettime();
          continue;
        }

        while(isalive(var4) && var4.team == "axis" && isDefined(var4.laststealthtime) && gettime() - var4.laststealthtime < 1000) {
          waitframe();
        }

        if(!var1.size) {
          var1 = var2;
          var2 = [];
        }

        foreach(var6 in var1) {
          if(!isDefined(var6)) {
            if(var11 == 0) {
              var1 = [];
            }

            continue;
          }

          if(!isalive(var6)) {
            continue;
          }

          if(!isDefined(var6.battlechatter.enemyclass)) {
            continue;
          }

          if(!bccansee(var4, var6)) {
            if(isPlayer(var6)) {
              continue;
            }

            if(!isDefined(var6.team) || isDefined(var6.team) && var6.team == anim.player.team) {
              continue;
            }

            if(!bccansee(anim.player, var6)) {
              continue;
            }
          }

          if(isDefined(var4.bt) && isDefined(var4.bt.pursuer)) {
            addreactionevent(var4, "danger", undefined, var4.bt.pursuer);
          } else {
            addthreatevent(var4, var6.battlechatter.enemyclass, var6);
          }

          var2 = var6;
          var7 = [];

          foreach(var9 in var1) {
            if(var9 != var6) {
              var7 = var9;
            }
          }

          var1 = var7;
          break;
        }

        waitframe();
      }

      waitframe();
    }
  }
}

function bccansee(var0, var1) {
  if(!isDefined(self)) {
    return false;
  } else if(var0.code_classname == "script_vehicle") {
    return true;
  } else if(self == level.player) {
    if(scripts\anim\utility_common::player_can_see_ai(level.player, var0)) {
      return true;
    }
  } else if(self cansee(var0)) {
    return true;
  } else if(!istrue(var1) && var0 iscurrentenemyvalid() && gettime() - anim.lastteamspokentime[self.team] > 5000) {
    return true;
  }

  return false;
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

    if(!var0 scripts\anim\battlechatter::is_in_callable_location()) {
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
    if(isDefined(var0) && !bccansee(anim.player, var0, 1)) {
      return;
    }
  }

  wait 1.2;
  addreactionevent("casualty", "generic", var0, 0.9);
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

  if(!scripts\anim\battlechatter_gamesku::isalliedcountryid(var0.battlechatter.countryid)) {
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

function aikilleventthread(var0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(var0 == "civilian") {
    return;
  }

  wait 1.2;
  addinformevent("killfirm", "generic", undefined, var0);
}

function aiinformweaponwaiter() {
  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiInformWeaponWaiter");
  self endon("aiInformWeaponWaiter");
  GscBinSkip4(0x35);
}

function waittill_missile_fire() {
  for(;;) {
    self waittill("missile_fire", var0, var1);

    if(scripts\anim\battlechatter_gamesku::bcisrpg(var1.classname) && isDefined(self.team)) {
      level notify("bc_inform_weapon", "rpg", self.team);
    }

    waitframe();
  }
}

function waittill_grenade_danger() {
  for(;;) {
    self waittill("grenade danger", var0, var1);

    if(isDefined(var0)) {
      if(scripts\anim\battlechatter_gamesku::bcisgrenade(var0.model) && isDefined(self.team)) {
        level notify("bc_inform_weapon", "grenade", self.team);
      }
    }

    waitframe();
  }
}

function waittill_sniper() {
  if(!isDefined(self.team)) {
    return;
  }

  var0 = undefined;

  for(;;) {
    if(!isPlayer(self)) {
      if(scripts\anim\utility_common::isasniper(1)) {
        self waittill("sniper_weapon_fired");
        var0 = 1;
      } else {
        break;
      }
    } else {
      self waittill("attack_pressed");

      if(level.player playerads() == 1 && isDefined(self.currentweapon) && scripts\anim\utility_common::issniperrifle(self.currentweapon) && self isfiring()) {
        var0 = 1;
      }
    }

    if(istrue(var0)) {
      wait 1;
      var0 = undefined;
      level notify("bc_inform_weapon", "sniper", self.team, self);
    }

    wait 10;
  }
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

function evaluatemoveevent(var0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::bcsenabled()) {
    return;
  }

  if(!isDefined(self.node)) {
    return;
  }

  if(distancesquared(self.origin, self.node.origin) < 23040) {
    return;
  }

  if(!scripts\anim\battlechatter::isnodecoverorconceal()) {
    return;
  }

  if(!nationalityokformoveorder()) {
    return;
  }

  var1 = scripts\anim\battlechatter::getresponder(24, 1024, "response");

  if(self.team != "axis" && self.team != "team3") {
    if(!isDefined(var1)) {
      var1 = anim.player;
    } else if(randomint(100) < anim.eventchance["moveEvent"]["ordertoplayer"]) {
      var1 = anim.player;
    }
  }

  if(self.combattime > 0) {
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
    return false;
  }

  if(!scripts\anim\battlechatter_gamesku::isalliedmilitarycountryid(self.battlechatter.countryid)) {
    return false;
  }

  return true;
}

function aifolloworderwaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    level waittill("follow order", var0);

    if(!scripts\anim\battlechatter::bcsenabled()) {
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

function aivehiclewaiter() {
  self endon("death");
  self endon("removed from battleChatter");

  for(;;) {
    if(!scripts\anim\battlechatter::bcsenabled()) {
      return;
    }

    if(!isDefined(self.team)) {
      return;
    }

    var0 = ["axis", "allies", "team3"];
    var0 = scripts\engine\utility::array_remove(var0, self.team);
    var1 = scripts\engine\sp\utility::getteamvehiclearray(var0);
    var1 = sortbydistance(var1, self.origin);

    foreach(var3 in var1) {
      if(isDefined(var3.battlechatter) && !isDefined(var3.battlechatter.informed)) {
        if(distancesquared(self.origin, var3.origin) < 25000000) {
          if(isDefined(var3.battlechatter.enemyclass)) {
            var3.battlechatter.informed = 1;
            addvehicleevent("incoming", var3.battlechatter.enemyclass);
            continue;
          }

          var3.battlechatter.informed = 1;
        }
      }
    }

    wait 2;
  }
}

function aivehiclekillwaiter() {
  var0 = self.battlechatter.enemyclass;
  self waittill("death", var1);

  if(isDefined(var1)) {
    if(!isDefined(self.team)) {
      return;
    }

    var2 = self.team;
    var3 = ["axis", "allies"];
    var3 = scripts\engine\utility::array_remove(var3, var2);
    wait 2;
    var4 = getaiarray(var3[0]);

    foreach(var6 in var4) {
      addvehicleevent(var6, "killfirm", var0);
    }

    return;
  }
}

function player_friendlyfire_waiter() {
  self endon("death");
  self endon("removed from battleChatter");
  thread player_friendlyfire_waiter_damage();

  for(;;) {
    self waittill("bulletwhizby", var0, var1);

    if(!scripts\anim\battlechatter::bcsenabled()) {
      continue;
    }

    if(!isPlayer(var0)) {
      if(anim.countryids[self.voice] == "GM" && scripts\anim\battlechatter::cansay("reaction", "takingfire", 1)) {
        addreactionevent("takingfire", undefined, var0, 1);
      }
    }
  }
}

function player_friendlyfire_addreactionevent() {
  addreactionevent("friendlyfire", undefined, anim.player, 1);
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
    case "MOD_CRUSH":
    case "MOD_IMPACT":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_MELEE":
      return false;
  }

  return true;
}

function friendlyfire_whizby_distances_valid(var0, var1) {
  var2 = 65536;
  var3 = 42;

  if(distancesquared(var0.origin, self.origin) < var2) {
    return false;
  }

  if(var1 > var3) {
    return false;
  }

  return true;
}

function evaluatereloadevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::bcsenabled()) {
    return;
  }

  addinformevent("reloading", "generic");
}

function evaluatemeleeevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::bcsenabled()) {
    return false;
  }

  if(!isDefined(self.enemy)) {
    return false;
  }

  return false;
}

function evaluatefiringevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::bcsenabled()) {
    return;
  }

  if(!isDefined(self.enemy)) {
    return;
  }
}

function evaluatesuppressionevent() {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::bcsenabled()) {
    return;
  }

  addinformevent("suppressed", "generic");
}

function evaluateattackevent(var0) {
  self endon("death");
  self endon("removed from battleChatter");

  if(!scripts\anim\battlechatter::bcsenabled()) {
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

function custom_battlechatter_init_valid_phrases() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "order_move_combat");
}

function custom_battlechatter_validate_phrase(var0) {
  var1 = 0;

  foreach(var3 in level.custombcs_validphrases) {
    if(var3 == var0) {
      var1 = 1;
      break;
    }
  }

  return var1;
}

function get_phraseinvalidstr(var0) {
  return anim.bcprintfailprefix + "custom battlechatter phrase '" + var0 + "' isn't valid.look at _utility::custom_battlechatter_init_valid_phrases(), or the util script documentation for custom_battlechatter(), for a list of valid phrases.";
}

function get_badcountryidstr(var0) {
  return "AI at origin " + self.origin + "wasn't able to play custom battlechatter because his nationality is '" + self.battlechatter.countryid + "'.";
}

function custom_battlechatter_internal(var0) {
  if(!isDefined(level.custombcs_validphrases)) {
    custom_battlechatter_init_valid_phrases();
  }

  var0 = tolower(var0);

  if(!custom_battlechatter_validate_phrase(var0)) {
    var1 = get_phraseinvalidstr(var0);
    return false;
  }

  var2 = scripts\anim\battlechatter::getresponder(24, 512, "response");
  begincustomevent();

  switch (var1) {
    case "order_move_combat":
      if(!nationalityokformoveorder()) {
        scripts\anim\battlechatter::battlechatter_printerror(get_badcountryidstr(var1));
        return false;
      }

      scripts\anim\battlechatter::tryorderto(self.customchatphrase, var2);
      addmovecombataliasex();
      break;
    case "order_move_noncombat":
      if(!nationalityokformoveordernoncombat()) {
        scripts\anim\battlechatter::battlechatter_printerror(get_badcountryidstr(var1));
        return false;
      }

      addmovenoncombataliasex();
      break;
    case "order_action_coverme":
      scripts\anim\battlechatter::tryorderto(self.customchatphrase, var2);
      addactioncovermealiasex();
      break;
    case "inform_reloading":
      addinformreloadingaliasex();
      break;
    default:
      var1 = get_phraseinvalidstr(var1);
      return false;
  }

  endcustomevent(2000);
  return true;
}

function begincustomevent() {
  if(!scripts\anim\battlechatter::bcsenabled()) {
    return;
  }

  self.customchatphrase = scripts\anim\battlechatter::createchatphrase();
}

function addactioncovermealiasex() {
  self.customchatphrase scripts\anim\battlechatter::addorderalias("action", "coverme");
}

function addmovecombataliasex() {
  self.customchatphrase scripts\anim\battlechatter::addorderalias("move", "movecombat");
}

function addmovenoncombataliasex() {
  self.customchatphrase scripts\anim\battlechatter::addorderalias("move", "movenoncombat");
}

function addinformreloadingaliasex() {
  self.customchatphrase scripts\anim\battlechatter::addinformalias("reloading");
}

function addnamealiasex(var0) {
  if(!scripts\anim\battlechatter::bcsenabled()) {
    return;
  }

  self.customchatphrase scripts\anim\battlechatter::addnamealias(var0);
}

function endcustomevent(var0, var1) {
  if(!scripts\anim\battlechatter::bcsenabled()) {
    return;
  }

  var2 = scripts\anim\battlechatter::createchatevent("custom", "generic", 1);

  if(isDefined(var0)) {
    var2.expiretime = gettime() + var0;
  }

  if(isDefined(var1)) {
    var2.type = var1;
  } else {
    var2.type = "custom";
  }

  self.battlechatter.chatqueue["custom"] = undefined;
  self.battlechatter.chatqueue["custom"] = var2;
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