/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_behavior_tracker.gsc
*************************************************/

#using scripts\shared\math_shared;
#namespace behaviortracker;

function setuptraits() {
  if(isDefined(self.behaviortracker.traits)) {
    return;
  }
  self.behaviortracker.traits = [];
  self.behaviortracker.traits["effectiveCombat"] = 0.5;
  self.behaviortracker.traits["effectiveWallRunCombat"] = 0.5;
  self.behaviortracker.traits["effectiveDoubleJumpCombat"] = 0.5;
  self.behaviortracker.traits["effectiveSlideCombat"] = 0.5;
  if(self.behaviortracker.version != 0) {
    traits = getarraykeys(self.behaviortracker.traits);
    for(i = 0; i < traits.size; i++) {
      trait = traits[i];
      self.behaviortracker.traits[trait] = float(self gettraitstatvalue(trait));
    }
  }
}

function initialize() {
  if(isDefined(self.pers["isBot"])) {
    return;
  }
  if(isDefined(self.behaviortracker)) {
    return;
  }
  if(isDefined(level.disablebehaviortracker) && level.disablebehaviortracker == 1) {
    return;
  }
  self.behaviortracker = spawnStruct();
  self.behaviortracker.version = int(self gettraitstatvalue("version"));
  self.behaviortracker.numrecords = int(self gettraitstatvalue("numRecords")) + 1;
  self setuptraits();
  self.behaviortracker.valid = 1;
}

function finalize() {
  if(!self isallowed()) {
    return;
  }
  self settraitstats();
  self printtrackertoblackbox();
}

function isallowed() {
  if(!isDefined(self)) {
    return false;
  }
  if(!isDefined(self.behaviortracker)) {
    return false;
  }
  if(!self.behaviortracker.valid) {
    return false;
  }
  if(isDefined(level.disablebehaviortracker) && level.disablebehaviortracker == 1) {
    return false;
  }
  return true;
}

function printtrackertoblackbox() {
  bbprint("mpbehaviortracker", "username %s version %d numRecords %d effectiveSlideCombat %f effectiveDoubleJumpCombat %f effectiveWallRunCombat %f effectiveCombat %f", self.name, self.behaviortracker.version, self.behaviortracker.numrecords, self.behaviortracker.traits["effectiveSlideCombat"], self.behaviortracker.traits["effectiveDoubleJumpCombat"], self.behaviortracker.traits["effectiveWallRunCombat"], self.behaviortracker.traits["effectiveCombat"]);
}

function gettraitvalue(trait) {
  return self.behaviortracker.traits[trait];
}

function settraitvalue(trait, value) {
  self.behaviortracker.traits[trait] = value;
}

function updatetrait(trait, percent) {
  if(!self isallowed()) {
    return;
  }
  math::clamp(percent, -1, 1);
  currentvalue = self gettraitvalue(trait);
  if(percent >= 0) {
    delta = (1 - currentvalue) * percent;
  } else {
    delta = (currentvalue - 0) * percent;
  }
  weighteddelta = 0.1 * delta;
  newvalue = currentvalue + weighteddelta;
  newvalue = math::clamp(newvalue, 0, 1);
  self settraitvalue(trait, newvalue);
  bbprint("mpbehaviortraitupdate", "username %s trait %s percent %f", self.name, trait, percent);
}

function updateplayerdamage(attacker, victim, damage) {
  if(isDefined(victim) && victim isallowed()) {
    damageratio = float(damage) / float(victim.maxhealth);
    math::clamp(damageratio, 0, 1);
    damageratio = damageratio * -1;
    victim updatetrait("effectiveCombat", damageratio);
    if(victim iswallrunning()) {
      victim updatetrait("effectiveWallRunCombat", damageratio);
    }
    if(victim issliding()) {
      victim updatetrait("effectiveSlideCombat", damageratio);
    }
    if(victim isdoublejumping()) {
      victim updatetrait("effectiveDoubleJumpCombat", damageratio);
    }
  }
  if(isDefined(attacker) && attacker isallowed() && attacker != victim) {
    damageratio = float(damage) / float(attacker.maxhealth);
    math::clamp(damageratio, 0, 1);
    attacker updatetrait("effectiveCombat", damageratio);
    if(attacker iswallrunning()) {
      attacker updatetrait("effectiveWallRunCombat", damageratio);
    }
    if(attacker issliding()) {
      attacker updatetrait("effectiveSlideCombat", damageratio);
    }
    if(attacker isdoublejumping()) {
      attacker updatetrait("effectiveDoubleJumpCombat", damageratio);
    }
  }
}

function updateplayerkilled(attacker, victim) {
  if(isDefined(victim) && victim isallowed()) {
    victim updatetrait("effectiveCombat", -1);
    if(victim iswallrunning()) {
      victim updatetrait("effectiveWallRunCombat", -1);
    }
    if(victim issliding()) {
      victim updatetrait("effectiveSlideCombat", -1);
    }
    if(victim isdoublejumping()) {
      victim updatetrait("effectiveDoubleJumpCombat", -1);
    }
  }
  if(isDefined(attacker) && attacker isallowed() && attacker != victim) {
    attacker updatetrait("effectiveCombat", 1);
    if(attacker iswallrunning()) {
      attacker updatetrait("effectiveWallRunCombat", 1);
    }
    if(attacker issliding()) {
      attacker updatetrait("effectiveSlideCombat", 1);
    }
    if(attacker isdoublejumping()) {
      attacker updatetrait("effectiveDoubleJumpCombat", 1);
    }
  }
}

function settraitstats() {
  if(self.behaviortracker.version == 0) {
    return;
  }
  self.behaviortracker.numrecords = self.behaviortracker.numrecords + 1;
  self settraitstatvalue("numRecords", self.behaviortracker.numrecords);
  traits = getarraykeys(self.behaviortracker.traits);
  for(i = 0; i < traits.size; i++) {
    trait = traits[i];
    value = self.behaviortracker.traits[trait];
    self settraitstatvalue(trait, value);
  }
}

function gettraitstatvalue(trait) {
  return self getdstat("behaviorTracker", trait);
}

function settraitstatvalue(trait, value) {
  self setdstat("behaviorTracker", trait, value);
}