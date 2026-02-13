/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1942.gsc
*************************************************/

_id_D89B(var_0, var_1, var_2, var_3, var_4, var_5) {
  self.owner setclientomnvar("ui_out_of_range", 0);

  if(!isDefined(var_1)) {
    var_1 = var_0.origin;
  }

  if(!isDefined(var_4)) {
    var_4 = 4000000;
  }

  if(!isDefined(var_5)) {
    var_5 = 16000000;
  }

  if(isDefined(var_2)) {
    var_0 thread _id_10ACC(var_2, var_3, var_4, var_5);
  } else {
    var_0 thread _id_10ACD(var_1, var_4, var_5);
  }
}

_id_10ACC(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = "tag_origin";
  }

  for(;;) {
    if(!isDefined(var_0)) {
      self.owner setclientomnvar("ui_out_of_range", 0);
      return;
    }

    var_4 = var_0 gettagorigin(var_1);
    var_5 = distancesquared(self.origin, var_4);

    if(scripts\common\utility::iscp()) {
      var_6 = var_5 / var_3;

      if(var_6 <= 1) {
        self.owner setclientomnvar("ui_out_of_range_meter", _func_0218(var_6));
      }
    }

    if(var_5 >= var_2) {
      _id_10BC1(var_4, var_2, var_3, var_0, var_1);
    }

    waitframe();
  }
}

_id_10ACD(var_0, var_1, var_2) {
  self endon("death");

  for(;;) {
    var_3 = distancesquared(self.origin, var_0);

    if(scripts\common\utility::iscp()) {
      var_4 = var_3 / var_2;

      if(var_4 <= 1) {
        self.owner setclientomnvar("ui_out_of_range_meter", _func_0218(var_4));
      }
    }

    if(var_3 >= var_1) {
      _id_10BC1(var_0, var_1, var_2);
    }

    waitframe();
  }
}

_id_10BC1(var_0, var_1, var_2, var_3, var_4) {
  for(;;) {
    if(isDefined(var_3)) {
      var_0 = var_3 gettagorigin(var_4);
    }

    var_5 = distancesquared(self.origin, var_0);
    var_6 = var_5 / var_2;
    self.owner setclientomnvar("ui_out_of_range", var_6);

    if(scripts\common\utility::iscp()) {
      self.owner setclientomnvar("ui_out_of_range_meter", _func_0218(var_6));
    }

    if(isDefined(self.owner._id_AD12)) {
      self.owner thread[[self.owner._id_AD12]](self.owner);
    }

    if(var_5 >= var_2) {
      var_7 = makeweapon("s4_v2_mp");
      var_8 = "MOD_EXPLOSIVE";
      self.owner setclientomnvar("ui_out_of_range", 0);
      self dodamage(10000, self.origin, self.owner, self.owner, var_8, var_7);
      break;
    } else if(var_5 < var_1) {
      self.owner setclientomnvar("ui_out_of_range", 0);
      break;
    }

    waitframe();
  }
}