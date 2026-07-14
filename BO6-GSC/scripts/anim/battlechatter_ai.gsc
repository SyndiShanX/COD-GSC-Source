/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\battlechatter_ai.gsc
*********************************************/

#using script_433d8f78f7e5fb;
#using scripts\anim\battlechatter;
#using scripts\anim\battlechatter_events;
#using scripts\asm\asm;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace battlechatter_ai;

function addtosystem() {
  if(!isDefined(level.battlechatter)) {
    return;
  }

  self endon("death");
  assert(isDefined(self.squad));

  if(!isDefined(self.battlechatterallowed)) {
    self.battlechatterallowed = 1;
  }

  if(isPlayer(self)) {
    self.battlechatterallowed = 0;
    self.type = "human";
    return;
  }

  if(self.unittype == "dog" || self.unittype == "zombie" && isbrgamemode() || self.unittype == "juggernaut" && getprojectname() != "T10" || self.team == "neutral") {
    self.battlechatterallowed = 0;
    return;
  }

  if(level.var_7fd9a527113d4767) {
    self.battlechatterallowed = 0;
    return;
  }

  self.battlechatter.friendlyfire_force = 1;
  self.headknob = asm::asm_getxanim("knobs", asm::asm_lookupanimfromalias("knobs", "head"));
  self.scriptedtalkingknob = asm::asm_getxanim("knobs", asm::asm_lookupanimfromalias("knobs", "scripted_talking"));
  self.defaulttalk = asm::asm_getxanim("knobs", asm::asm_lookupanimfromalias("knobs", "default_talking"));
  setvoice();
  thread aiThreadWaiter();
  self.chatinitialized = 1;
}

function setup_mp_hero(var_9582b5184d9de612, combatmapid, stealthmapid) {
  var_3caaf1badd796942 = tolower(var_9582b5184d9de612 ?? self.script_friendname);
  self.battlechatter.countryid = var_3caaf1badd796942;
  self.battlechatter.npcid = undefined;
  self.battlechatter.ishero = 1;
  anim.var_4ef5299ac30c33e6[var_3caaf1badd796942] = combatmapid;
  anim.var_c285202ed79ffced[var_3caaf1badd796942] = stealthmapid;
}

function function_e93e1e260edea53(text, duration) {
  thread function_a7f2420b11f54b4d(text, duration);
}

function private function_a7f2420b11f54b4d(text, duration) {
  self endon("<dev string:x24>");

  if(!isDefined(self.var_6d86abb3f23dafe7)) {
    return;
  }

  self.var_6d86abb3f23dafe7[self.var_6d86abb3f23dafe7.size] = text;

  if(!isDefined(duration)) {
    return;
  }

  wait duration;
  self.var_6d86abb3f23dafe7 = utility::function_d751969553a4bddd(self.var_6d86abb3f23dafe7, text);
}

function private function_9512d99877628e15() {
  self endon("<dev string:x24>");
  self.var_6d86abb3f23dafe7 = [];

  for(;;) {
    height = 30;

    foreach(debugln in self.var_6d86abb3f23dafe7) {
      print3d(self gettagorigin("<dev string:x2d>") + (0, 0, height), debugln, (1, 1, 1), 1, 0.5, 1, 1);
      height += 10;
    }

    waitframe();
  }
}

function clearvoice() {
  if(isDefined(self.battlechatter.npcid) && isDefined(self.voice)) {
    foreach(usedid in anim.usedids[self.voice]) {
      if(usedid.npcid == self.battlechatter.npcid) {
        usedid.count--;
        break;
      }
    }
  }

  self.battlechatter.npcid = undefined;
}

function setvoice(voice) {
  if(isDefined(voice)) {
    self.voice = voice;
  }

  if(!isDefined(self.voice)) {
    return;
  }

  if(isDefined(self.battlechatter) && isDefined(self.battlechatter.npcid)) {
    clearvoice();
  }

  self.battlechatter.countryid = anim.countryids[self.voice];

  if(!isDefined(self.battlechatter.countryid)) {
    return;
  }

  namespace_326cae52b2158981::assign_npcid();
}

function reassignvoiceid() {
  clearvoice();
  namespace_326cae52b2158981::assign_npcid();
}

function removefromsystem(squad) {
  if(!(isDefined(level.battlechatter) && isDefined(self))) {
    return;
  }

  if(!isalive(self) && isDefined(self.attacker) && squad.team != self.attacker.team && squad.team != "neutral") {
    if(isscriptedai(self.attacker)) {
      self.attacker setbattlechatterflag("KilledTarget", 1);
    }

    self.attacker thread battlechatter_events::killfirmevent(self, self.attacker.team);
    thread battlechatter_events::casualtyevent(squad.team);
  }

  if(isDefined(self.battlechatter.npcid) && isDefined(self.battlechatter) && isDefined(self.voice)) {
    clearvoice();

    if(isDefined(level.stealth) && isDefined(level.var_ed9f17bb0f80706e)) {
      thread function_ad67c3e8d22e9eda(squad.team, self.battlechatter.countryid, self.battlechatter.npcid, self.battlechatter.name);
    }
  } else if(isDefined(self.var_8d4f5e01dc1af2e8)) {
    self.var_8d4f5e01dc1af2e8 notify("death");
    self.var_8d4f5e01dc1af2e8 delete();
  }

  self notify("removed from battleChatter");
}

function function_ad67c3e8d22e9eda(team, countryid, npcid, name) {
  if(level.var_c500168c9dd66126) {
    return;
  }

  origin = self.origin;
  voice = self.voice;

  if(!utility::issp()) {
    function_72df09bab3ab3355();
    return;
  }

  entnum = self getentitynumber();
  corpse = undefined;

  while(!isDefined(corpse)) {
    array = [[level.var_ed9f17bb0f80706e]](level.bcs_neardist);

    foreach(corpseent in array) {
      if(corpseent getentitynumber() == entnum) {
        corpse = corpseent;
      }
    }

    waitframe();
  }

  corpse.team = team;
  corpse.voice = voice;
  corpse.battlechatter = spawnStruct();
  corpse.battlechatter.countryid = countryid;
  corpse.battlechatter.npcid = npcid;
  corpse.battlechatter.name = name;
  corpse.battlechatterallowed = 1;

  if(isDefined(level.stealth)) {
    corpse thread corpseloop();
  }
}

function function_72df09bab3ab3355() {}

function corpseloop() {}

function setnpcid() {
  assert(!isDefined(self.battlechatter.npcid));
  usedids = anim.usedids[self.voice];
  numids = usedids.size;
  startindex = randomint(numids);
  lowestid = startindex;

  for(index = 0; index <= numids; index++) {
    if(usedids[(startindex + index) % numids].count < usedids[lowestid].count) {
      lowestid = (startindex + index) % numids;
    }
  }

  anim.usedids[self.voice][lowestid].count++;
  self.battlechatter.npcid = usedids[lowestid].npcid;
}

function evaluateattackevent(weapon) {
  battlechatter_events::useevent(weapon);
}

function aiThreadWaiter() {
  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiThreadWaiter");
  self endon("aiThreadWaiter");
  childthread waittill_missile_fire();
  childthread waittill_grenade_fire();
  childthread waittill_weapon_fire();
  childthread waittill_move();
  childthread waittill_red_alert();
}

function waittill_missile_fire() {
  while(true) {
    self waittill("missile_fire", missile, objweapon);
    bcs_subcategory = battlechatter_events::function_e08b029c30762ab3(objweapon);

    if(isDefined(bcs_subcategory)) {
      addbattlechatternotify(self, undefined, "use", bcs_subcategory);
    }
  }
}

function waittill_grenade_fire() {
  while(true) {
    self waittill("grenade_fire", grenade);

    if(isDefined(grenade) && isDefined(grenade.weapon_object)) {
      bcs_subcategory = battlechatter_events::function_e08b029c30762ab3(grenade.weapon_object);

      if(battlechatter::function_1d3591529c0364a9(bcs_subcategory)) {
        addbattlechatternotify(self, grenade, "grenade_danger", bcs_subcategory);
      }
    }
  }
}

function waittill_weapon_fire() {
  while(true) {
    self waittill("weapon_fired");
    addbattlechatternotify(self, undefined, "attack");
  }
}

function waittill_move() {
  while(true) {
    self waittill("goal_changed");

    if(distance2dsquared(self.origin, self.goalpos) > 10000) {
      addbattlechatternotify(self, undefined, "move");
    }
  }
}

function waittill_red_alert() {
  var_c17f4750045f3e9e = 0;

  while(true) {
    if(var_c17f4750045f3e9e != getglobalescalation()) {
      var_c17f4750045f3e9e = !var_c17f4750045f3e9e;

      if(var_c17f4750045f3e9e) {
        addbattlechatternotify(self, undefined, "red_alert");
      }
    }

    waitframe();
  }
}

function aivehiclekillwaiter() {}

function custom_battlechatter_internal(phrase, sequence, priority, timeout, cooldown, endons) {
  battlechatter::function_b63bed8df8e4202a(phrase, phrase, priority, timeout, cooldown, endons);
}