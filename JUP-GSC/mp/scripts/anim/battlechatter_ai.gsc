/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\anim\battlechatter_ai.gsc
************************************************/

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

  self.battlechatter.friendlyfire_force = 1;

  if(isPlayer(self)) {
    self.battlechatterallowed = 0;
    self.type = "human";
    return;
  }

  if(self.unittype == "dog" || self.unittype == "juggernaut" || self.team == "neutral") {
    self.battlechatterallowed = 0;
    return;
  }

  self.headknob = asm_getxanim("knobs", asm_lookupanimfromalias("knobs", "head"));
  self.scriptedtalkingknob = asm_getxanim("knobs", asm_lookupanimfromalias("knobs", "scripted_talking"));
  self.defaulttalk = asm_getxanim("knobs", asm_lookupanimfromalias("knobs", "default_talking"));
  setvoice();
  thread aithreadwaiter();
  self.chatinitialized = 1;
}

function setup_mp_hero(var_c6910a7018189965, var_4189af81d34b8804, var_10e927a072c477b) {
  var_e530e91be23a6bc9 = tolower(default_to(var_c6910a7018189965, self.script_friendname));
  self.battlechatter.countryid = var_e530e91be23a6bc9;
  self.battlechatter.npcid = undefined;
  self.battlechatter.ishero = 1;
  anim.var_6d557183af1d1db5[var_e530e91be23a6bc9] = var_4189af81d34b8804;
  anim.var_7f532a5dc6603698[var_e530e91be23a6bc9] = var_10e927a072c477b;
}

function function_ffd2cfb5b8a113ac(text, duration) {
  thread function_c3cc4c3fb0ac344c(text, duration);
}

function private function_c3cc4c3fb0ac344c(text, duration) {
  self endon("<dev string:x1c>");

  if(!isDefined(self.var_446bf46cbf43cf30)) {
    return;
  }

  self.var_446bf46cbf43cf30[self.var_446bf46cbf43cf30.size] = text;

  if(!isDefined(duration)) {
    return;
  }

  wait duration;
  self.var_446bf46cbf43cf30 = function_57091b2d67654a14(self.var_446bf46cbf43cf30, text);
}

function private function_c911f04ca7e627e8() {
  self endon("<dev string:x1c>");
  self.var_446bf46cbf43cf30 = [];

  for(;;) {
    height = 30;

    foreach(debugln in self.var_446bf46cbf43cf30) {
      print3d(self gettagorigin("<dev string:x25>") + (0, 0, height), debugln, (1, 1, 1), 1, 0.5, 1, 1);
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

  assign_npcid();
}

function function_da324cd732971e8c() {
  clearvoice();
  assign_npcid();
}

function removefromsystem(squad) {
  if(!isDefined(level.battlechatter) || !isDefined(self)) {
    return;
  }

  if(!isalive(self) && isDefined(self.attacker) && !is_equal(squad.team, self.attacker.team) && squad.team != "neutral") {
    self.attacker thread function_453b3867c6ec0ceb(self, self.attacker.team);
    thread function_f649c4ef3acdec1d(squad.team);
  }

  if(isDefined(self.battlechatter) && isDefined(self.battlechatter.npcid) && isDefined(self.voice)) {
    clearvoice();

    if(isDefined(level.stealth) && isDefined(level.var_621af16ef0684a11)) {
      thread function_bd6944098e09347f(squad.team, self.battlechatter.countryid, self.battlechatter.npcid, self.battlechatter.name);
    }
  } else if(isDefined(self.var_4413114d1d17278b)) {
    self.var_4413114d1d17278b notify("death");
    self.var_4413114d1d17278b delete();
  }

  self notify("removed from battleChatter");
}

function function_bd6944098e09347f(team, countryid, npcid, name) {
  if(istrue(level.var_ecafb96516684c19)) {
    return;
  }

  origin = self.origin;
  voice = self.voice;

  if(!issp()) {
    function_3e6d99e336341602();
    return;
  }

  entnum = self getentitynumber();
  corpse = undefined;

  while(!isDefined(corpse)) {
    array = [[level.var_621af16ef0684a11]](level.var_798aa343368f724e);

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

function function_3e6d99e336341602() {}

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
  useevent(weapon);
}

function aithreadwaiter() {
  self endon("death");
  self endon("removed from battleChatter");
  self notify("aiThreadWaiter");
  self endon("aiThreadWaiter");
  childthread waittill_missile_fire();
  childthread waittill_grenade_fire();
  childthread function_ad344a5a58977b39();
  childthread waittill_move();
  childthread function_69110de99255d852();
}

function waittill_missile_fire() {
  while(true) {
    self waittill("missile_fire", missile, objweapon);
    var_fc3f189c0832aec2 = function_c666e714b2411844(objweapon);

    if(isDefined(var_fc3f189c0832aec2)) {
      function_216c67ab6749137a(self, undefined, "use", var_fc3f189c0832aec2);
    }
  }
}

function waittill_grenade_fire() {
  while(true) {
    self waittill("grenade_fire", grenade);

    if(isDefined(grenade) && isDefined(grenade.weapon_object)) {
      var_fc3f189c0832aec2 = function_c666e714b2411844(grenade.weapon_object);

      if(function_8f8de1d6f307f960(var_fc3f189c0832aec2)) {
        function_216c67ab6749137a(self, grenade, "grenade_danger", var_fc3f189c0832aec2);
      }
    }
  }
}

function function_ad344a5a58977b39() {
  while(true) {
    self waittill("weapon_fired");
    function_216c67ab6749137a(self, undefined, "attack");
  }
}

function waittill_move() {
  while(true) {
    self waittill("goal_changed");

    if(distance2dsquared(self.origin, self.goalpos) > 10000) {
      function_216c67ab6749137a(self, undefined, "move");
    }
  }
}

function function_69110de99255d852() {
  var_5fedaa69e3ddfd3 = 0;

  while(true) {
    if(var_5fedaa69e3ddfd3 != function_3f51c5f6398bff45()) {
      var_5fedaa69e3ddfd3 = !var_5fedaa69e3ddfd3;

      if(var_5fedaa69e3ddfd3) {
        function_216c67ab6749137a(self, undefined, "red_alert");
      }
    }

    waitframe();
  }
}

function aivehiclekillwaiter() {}

function custom_battlechatter_internal(phrase, sequence, priority, timeout, cooldown, endons) {
  function_d54e84a9513b0e45(phrase, phrase, priority, timeout, cooldown, endons);
}