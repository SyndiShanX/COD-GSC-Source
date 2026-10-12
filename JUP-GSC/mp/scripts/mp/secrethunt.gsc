/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\secrethunt.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#using scripts\mp\utility\debug;
#namespace secrethunt;

function secrethunt(targetname) {
  while(!istrue(game["gamestarted"])) {
    waitframe();
  }

  hiddenobjs = getEntArray(targetname, "targetname");

  foreach(obj in hiddenobjs) {
    obj thread trackhiddenobj(hiddenobjs.size);
  }
}

function trackhiddenobj(numobjs) {
  level endon("game_ended");
  self setCanDamage(1);
  self.found = [];

  thread secrethunt_debuglocations();

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isDefined(objweapon)) {
      if(meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE_SPLASH") {
        continue;
      }
    } else if(isDefined(inflictor.streakinfo) && scripts\cp_mp\utility\killstreak_utility::isvalidkillstreak(inflictor.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self.found[attacker.guid])) {
      self.found[attacker.guid] = 1;

      if(!isDefined(attacker.hiddenobjcount)) {
        attacker.hiddenobjcount = 1;
      } else {
        attacker.hiddenobjcount++;
      }

      iprintln("Secret objects found: " + attacker.hiddenobjcount + " of " + numobjs);
    }

    if(self.health <= 0) {
      break;
    }
  }

  self delete();
}

function secrethunt_debuglocations() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    if(getdvarint(@ "hash_7a5a40586350d163", 0) == 1) {
      self hudoutlineenable("outlinefill_nodepth_green");
      self.outlined = 1;
    } else if(istrue(self.outlined)) {
      self hudoutlinedisable();
      self.outlined = 0;
    }

    wait 1;
  }
}