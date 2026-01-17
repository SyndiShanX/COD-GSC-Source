/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_shellshock.gsc
********************************************************/

main(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock) {
  level thread internalMain(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock);
}

internalMain(duration, nMaxDamageBase, nRanDamageBase, nMinDamageBase, nExposed, customShellShock) {
  if(!isDefined(duration)) {
    duration = 12;
  } else
  if(duration < 7) {
    duration = 7;
  }

  if(!isDefined(nMaxDamageBase)) {
    nMaxDamageBase = 150;
  }

  if(!isDefined(nRanDamageBase)) {
    nRanDamageBase = 100;
  }

  if(!isDefined(nMinDamageBase)) {
    nMinDamageBase = 100;
  }

  if(!isDefined(customShellShock)) {
    strShocktype = "default";
  } else {
    strShocktype = customShellShock;
  }

  origin = (level.player getorigin() + (0, 8, 2));
  range = 320;
  maxdamage = nMaxDamageBase + randomint(nRanDamageBase);
  mindamage = nMinDamageBase;

  level.player playSound("weapons_rocket_explosion");
  wait 0.25;

  radiusDamage(origin, range, maxdamage, mindamage);
  earthquake(0.75, 2, origin, 2250);

  if(isalive(level.player)) {
    level.player allowStand(false);
    level.player allowCrouch(false);
    level.player allowProne(true);

    wait 0.15;
    level.player viewkick(127, level.player.origin); // Amount should be in the range 0 - 127, and is normalized "damage".No damage is done.
    level.player shellshock(strShocktype, duration);

    if(!isDefined(nExposed)) {
      level.player thread playerHitable(duration);
    }

    wait 1.5;

    level.player allowStand(true);
    level.player allowCrouch(true);
  }
}

playerHitable(duration) {
  assert(isplayer(self));

  self.shellshocked = true;
  self.ignoreme = true;
  self notify("player is shell shocked");
  self endon("player is shell shocked");
  wait(duration - 1);
  self.shellshocked = false;
  self.ignoreme = false;
}