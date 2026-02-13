/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2065.gsc
*************************************************/

_id_CFF4(var_0) {
  while(!istrue(game["gamestarted"])) {
    waitframe();
  }

  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3 thread _id_F406(var_1.size);
  }
}

_id_F406(var_0) {
  level endon("game_ended");
  self setCanDamage(1);
  self._id_5F0F = [];

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isDefined(var_10)) {
      if(var_5 == "MOD_EXPLOSIVE" || var_5 == "MOD_GRENADE_SPLASH") {
        continue;
      }
    } else if(isDefined(var_14.streakinfo) && scripts\mp\utility\killstreak::_id_88E9(var_14.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self._id_5F0F[var_2.guid])) {
      self._id_5F0F[var_2.guid] = 1;

      if(!isDefined(var_2._id_7883)) {
        var_2._id_7883 = 1;
      } else {
        var_2._id_7883++;
      }

      iprintln("Secret objects found: " + var_2._id_7883 + " of " + var_0);
    }

    if(self.health <= 0) {
      break;
    }
  }

  self delete();
}

_id_CFF5() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    if(getdvarint("#x3bab69318fa068951", 0) == 1) {
      self _meth_81B0("outlinefill_nodepth_green");
      self._id_ACC5 = 1;
    } else if(istrue(self._id_ACC5)) {
      self _meth_81AD();
      self._id_ACC5 = 0;
    }

    wait 1.0;
  }
}