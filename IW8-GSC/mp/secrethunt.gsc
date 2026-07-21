/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\secrethunt.gsc
***********************************************/

secrethunt(var_0) {
  while(!istrue(game["_encstr_A9310C0449DDA97F583FADB0FD01"]))
    waitframe();

  var_1 = getEntArray(var_0, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_3 in var_1)
  var_3 thread trackhiddenobj(var_1.size);
}

trackhiddenobj(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setCanDamage(1);
  self.found = [];

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(isDefined(var_10)) {
      if(var_5 == "_encstr_B45C0E2DFF41B17F437FB870E733FBFF" || var_5 == "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421")
        continue;
    } else if(isDefined(var_14.streakinfo) && scripts\mp\utility\killstreak::iskillstreak(var_14.streakinfo.streakname)) {
      self.health = 5;
      continue;
    }

    if(!isDefined(self.found[var_2.guid])) {
      self.found[var_2.guid] = 1;

      if(!isDefined(var_2.hiddenobjcount))
        var_2.hiddenobjcount = 1;
      else
        var_2.hiddenobjcount++;

      iprintln("_encstr_8BFF1751C9D6A337D039EFEA45B07E6306C9BA1A5338B3B84A" + var_2.hiddenobjcount + "_encstr_997205D1353511" + var_0);
    }

    if(self.health <= 0) {
      break;
    }
  }

  self delete();
}

secrethunt_debuglocations() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    if(getdvarint("_encstr_92B0146A264B09A945122737794338A381D0B465A02C", 0) == 1) {
      self hudoutlineenable("_encstr_810A1ACA3DEBD0CB5857E97411DC16A69FEFE779E4E0E942D35F90BA");
      self.outlined = 1;
    } else if(istrue(self.outlined)) {
      self hudoutlinedisable();
      self.outlined = 0;
    }

    wait 1.0;
  }
}