/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_c4.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\equipment;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment;
#using scripts\engine\utility;
#namespace cp_c4;

function c4_used(grenade) {
  self endon("disconnect");
  grenade endon("death");
  grenade thread c4_deleteonownerdisconnect(self);
  grenade.throwtime = gettime();
  grenade.deletefunc = &c4_delete;
  c4_addtoarray(grenade);
  thread c4_watchfordetonation();
  thread c4_watchforaltdetonation();
  grenade thread minedamagemonitor();
  grenade thread c4_explodeonnotify();
  grenade waittill("missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal);
  onlethalequipmentplanted(grenade, "power_c4");
  thread monitordisownedequipment(self, grenade);
  level notify("c4_planted", stuckto, hitent);

  if(isDefined(grenade.owner) && !istrue(grenade.owner.var_95f9da0e6a58183b)) {
    pickup_str = spawnStruct();
    pickup_str.scriptablename = "brloot_offhand_c4";
    pickup_str.equipname = level.br_pickups.br_equipname[pickup_str.scriptablename];
    pickup_str.maxcount = grenade.owner scripts\cp_mp\equipment::getequipmentmaxammo(pickup_str.equipname);
    pickup_str.count = 1;
    pickup_str.origin = grenade.origin;
    pickup_str.isstuck = 1;
    grenade thread scripts\cp\equipment::makeexplosiveusabletag("tag_use", 1, undefined, pickup_str);
  }

  grenade setscriptablepartstate("effects", "plant", 0);
  grenade.headiconid = grenade scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 0, undefined, undefined, undefined, 0.1, 1);
}

function c4_detonate() {
  self endon("death");
  self.owner endon("disconnect");
  wait 0.1;
  thread c4_explode(self.owner);
}

function c4_explode(attacker) {
  thread c4_delete(5);
  name = "noname";

  if(isDefined(attacker.name)) {
    name = attacker.name;
  }

  level notify("grenade_exploded_during_stealth", self, "c4_mp", name);
  self setentityowner(attacker);
  self setscriptablepartstate("effects", "explode", 0);
}

function c4_destroy(attacker) {
  thread c4_delete(2);
  self setscriptablepartstate("effects", "destroy", 0);
}

function c4_delete(deletiondelay) {
  self notify("death");
  level.mines[self getentitynumber()] = undefined;
  scripts\cp\weapon::makeexplosiveunusuabletag();
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner) && isPlayer(self.owner)) {
    owner.plantedlethalequip = array_remove(owner.plantedlethalequip, self);
    owner notify("c4_update", 0);
  }

  if(isDefined(deletiondelay)) {
    wait deletiondelay;
  }

  self delete();
}

function c4_explodeonnotify() {
  self endon("death");
  self.owner endon("disconnect");
  level endon("game_ended");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);

  if(isDefined(attacker)) {
    thread c4_explode(attacker);
    return;
  }

  thread c4_explode(owner);
}

function c4_destroyonemp() {
  self endon("death");
  self.owner endon("disconnect");
  self waittill("emp_damage", attacker, duration);

  if(isDefined(self.owner) && attacker != self.owner) {
    attacker notify("destroyed_equipment");
  }

  thread c4_destroy();
}

function c4_candetonate(grenade) {
  return (gettime() - self.throwtime) / 1000 > 0.3 && !isDefined(self.detonationtime);
}

function c4_watchfordetonation() {
  self endon("death_or_disconnect");
  self endon("c4_unset");
  level endon("game_ended");
  self notify("watchForDetonation");
  self endon("watchForDetonation");

  while(true) {
    self waittill("detonate");
    heldoffhand = self getheldoffhand();
    weaponrootname = getweaponrootstring(heldoffhand);

    if(heldoffhand.basename == "c4_mp" || heldoffhand.basename == "c4_empty_mp" || heldoffhand.basename == "none" && isDefined(self.isusingcamera) && self.isusingcamera || weaponrootname == "c4") {
      thread c4_detonateall();
    }
  }
}

function c4_watchforaltdetonation() {
  self endon("death");
  self endon("disconnect");
  self endon("c4_unset");
  level endon("game_ended");

  if(!getdvarint(@ "scr_altdetonationenabled", 0)) {
    return;
  }

  self notify("watchForAltDetonation");
  self endon("watchForAltDetonation");
  buttontime = 0;

  while(true) {
    if(self useButtonPressed()) {
      buttontime = 0;

      while(self useButtonPressed()) {
        buttontime += 0.05;
        wait 0.05;
      }

      println("<dev string:x1c>" + buttontime);

      if(buttontime >= 0.5) {
        continue;
      }

      buttontime = 0;

      while(!self useButtonPressed() && buttontime < 0.5) {
        buttontime += 0.05;
        wait 0.05;
      }

      println("<dev string:x29>" + buttontime);

      if(buttontime >= 0.5) {
        continue;
      }

      thread c4_animdetonate();
    }

    wait 0.05;
  }
}

function c4_animdetonate() {
  objweapon = makeweapon("c4_empty_mp");
  self giveandfireoffhand(objweapon);
  thread c4_animdetonatecleanup();
}

function c4_animdetonatecleanup() {
  self endon("death_or_disconnect");
  self notify("c4_animDetonateCleanup()");
  self endon("c4_animDetonateCleanup()");
  objweapon = makeweapon("c4_empty_mp");
  wait 1;

  if(self hasweapon(objweapon)) {
    self takeweapon(objweapon);
  }
}

function c4_detonateall() {
  if(isDefined(self.c4s)) {
    foreach(c4 in self.c4s) {
      if(c4 c4_candetonate()) {
        c4 thread c4_detonate();
      }
    }
  }
}

function c4_addtoarray(grenade) {
  if(!isDefined(self.c4s)) {
    self.c4s = [];
  }

  self.c4s[grenade getentitynumber()] = grenade;
  self function_bcc86382f02470e6(1);
  level notify("c4_used");
  thread c4_removefromarrayondeath(grenade);
}

function c4_removefromarray(entnum) {
  if(!isDefined(self.c4s)) {
    return;
  }

  self.c4s[entnum] = undefined;
  owner = self.owner;

  if(isDefined(owner) && isDefined(owner.c4s)) {
    foreach(c4 in owner.c4s) {
      if(isDefined(c4)) {
        return;
      }
    }

    owner function_bcc86382f02470e6(0);
  }
}

function c4_removefromarrayondeath(grenade) {
  self endon("disconnect");
  entnum = grenade getentitynumber();
  grenade waittill("death");
  c4_removefromarray(entnum);
}

function c4_deleteonownerdisconnect(owner) {
  self endon("death");
  self endon("missile_stuck");
  owner waittill("disconnect");
  self delete();
}