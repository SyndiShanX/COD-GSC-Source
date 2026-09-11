/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\secrethunt.gsc
***********************************************/

function secrethunt(var0) {
  while(!istrue(game["gamestarted"])) {
    waitframe();
  }

  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    thread trackhiddenobj(var3);
  }
}

function trackhiddenobj(var0) {
  level endon("game_ended");
  self setCanDamage(1);
  self.found = [];

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);

    if(isDefined(var10)) {
      if(var5 == "MOD_EXPLOSIVE" || var5 == "MOD_GRENADE_SPLASH") {
        continue;
      }
    } else if(isDefined(var14.streakinfo) && scripts\mp\utility\killstreak::iskillstreak(var14.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self.found[var2.guid])) {
      self.found[var2.guid] = 1;

      if(!isDefined(var2.hiddenobjcount)) {
        var2.hiddenobjcount = 1;
      } else {
        var2.hiddenobjcount++;
      }

      iprintln("Secret objects found: " + var2.hiddenobjcount + " of " + var0);
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

  for(;;) {
    if(getdvarint("scr_debugSecretHunt", 0) == 1) {
      self hudoutlineenable("outlinefill_nodepth_green");
      self.outlined = 1;
    } else if(istrue(self.outlined)) {
      self hudoutlinedisable();
      self.outlined = 0;
    }

    wait 1;
  }
}