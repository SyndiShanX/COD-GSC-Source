/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\secrethunt.gsc
***********************************************/

secrethunt(targetname) {
  while(!istrue(game["gamestarted"]))
    waitframe();

  _id_C5EEC6817CB3208B = getEntArray(targetname, "targetname");

  foreach(obj in _id_C5EEC6817CB3208B)
  obj thread trackhiddenobj(_id_C5EEC6817CB3208B.size);
}

trackhiddenobj(_id_AA030029A5B16AE5) {
  level endon("game_ended");
  self setCanDamage(1);
  self.found = [];

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(isDefined(objweapon)) {
      if(meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE_SPLASH")
        continue;
    } else if(isDefined(inflictor.streakinfo) && scripts\cp_mp\utility\killstreak_utility::_id_CE1A9C6C9043809F(inflictor.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self.found[attacker.guid])) {
      self.found[attacker.guid] = 1;

      if(!isDefined(attacker.hiddenobjcount))
        attacker.hiddenobjcount = 1;
      else
        attacker.hiddenobjcount++;

      iprintln("Secret objects found: " + attacker.hiddenobjcount + " of " + _id_AA030029A5B16AE5);
    }

    if(self.health <= 0) {
      break;
    }
  }

  self delete();
}

secrethunt_debuglocations() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(getdvarint("scr_debugsecrethunt", 0) == 1) {
      self hudoutlineenable("outlinefill_nodepth_green");
      self.outlined = 1;
    } else if(istrue(self.outlined)) {
      self hudoutlinedisable();
      self.outlined = 0;
    }

    wait 1.0;
  }
}