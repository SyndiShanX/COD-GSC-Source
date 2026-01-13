/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\saw\common.gsc
*********************************************/

main(var_0) {
  self endon("killanimscript");
  if(!isDefined(var_0)) {
    return;
  }

  self.a.var_10930 = "saw";
  if(isDefined(var_0.script_delay_min)) {
    var_1 = var_0.script_delay_min;
  } else {
    var_1 = scripts\sp\mgturret::func_32B6("delay");
  }

  if(isDefined(var_0.script_delay_max)) {
    var_2 = var_0.script_delay_max - var_1;
  } else {
    var_2 = scripts\sp\mgturret::func_32B6("delay_range");
  }

  if(isDefined(var_0.var_ED26)) {
    var_3 = var_0.var_ED26;
  } else {
    var_3 = scripts\sp\mgturret::func_32B6("burst");
  }

  if(isDefined(var_0.var_ED25)) {
    var_4 = var_0.var_ED25 - var_3;
  } else {
    var_4 = scripts\sp\mgturret::func_32B6("burst_range");
  }

  var_5 = gettime();
  var_6 = "start";
  scripts\anim\shared::placeweaponon(self.var_394, "none");
  var_0 show();
  if(isDefined(var_0.var_1A56)) {
    self.a.var_D707 = ::func_D707;
    self.a.usingworldspacehitmarkers = var_0;
    var_0 notify("being_used");
    thread func_1109E();
  } else {
    self.a.var_D707 = ::func_D860;
  }

  var_0.var_5855 = 0;
  thread func_6D63(var_0);
  self setturretanim(self.primaryturretanim);
  self func_82AB(self.primaryturretanim, 1, 0.2, 1);
  self func_82AA(self.var_17E3);
  self func_82AA(self.var_17E2);
  var_0 func_82AA(var_0.var_17E3);
  var_0 func_82AA(var_0.var_17E2);
  var_0 endon("death");
  for(;;) {
    if(var_0.var_5855) {
      thread func_5AAA(var_0);
      func_13848(randomfloatrange(var_3, var_3 + var_4), var_0);
      var_0 notify("turretstatechange");
      if(var_0.var_5855) {
        thread func_57DB(var_0);
        wait(randomfloatrange(var_1, var_1 + var_2));
      }

      continue;
    }

    thread func_57DB(var_0);
    var_0 waittill("turretstatechange");
  }
}

func_13848(var_0, var_1) {
  var_1 endon("turretstatechange");
  wait(var_0);
}

func_6D63(var_0) {
  self endon("killanimscript");
  var_1 = cos(15);
  for(;;) {
    while(isDefined(self.isnodeoccupied)) {
      var_2 = self.isnodeoccupied.origin;
      var_3 = var_0 gettagangles("tag_aim");
      if(scripts\engine\utility::within_fov(var_0.origin, var_3, var_2, var_1) || distancesquared(var_0.origin, var_2) < -25536) {
        if(!var_0.var_5855) {
          var_0.var_5855 = 1;
          var_0 notify("turretstatechange");
        }
      } else if(var_0.var_5855) {
        var_0.var_5855 = 0;
        var_0 notify("turretstatechange");
      }

      wait(0.05);
    }

    if(var_0.var_5855) {
      var_0.var_5855 = 0;
      var_0 notify("turretstatechange");
    }

    wait(0.05);
  }
}

func_12A99(var_0, var_1) {
  if(var_0 <= 0) {
    return;
  }

  self endon("killanimscript");
  var_1 endon("turretstatechange");
  wait(var_0);
  var_1 notify("turretstatechange");
}

func_1109E() {
  self endon("killanimscript");
  for(;;) {
    if(!isDefined(self.target_getindexoftarget) || distancesquared(self.origin, self.target_getindexoftarget.origin) > 4096) {
      self func_83AF();
    }

    wait(0.25);
  }
}

func_D707(var_0) {
  if(var_0 == "pain") {
    if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < 4096) {
      self.a.usingworldspacehitmarkers hide();
      scripts\anim\shared::placeweaponon(self.var_394, "right");
      self.a.var_D707 = ::func_D705;
      return;
    } else {
      self func_83AF();
    }
  }

  if(var_0 == "saw") {
    var_1 = self func_8164();
    return;
  }

  self.a.usingworldspacehitmarkers delete();
  self.a.usingworldspacehitmarkers = undefined;
  scripts\anim\shared::placeweaponon(self.var_394, "right");
}

func_D705(var_0) {
  if(!isDefined(self.target_getindexoftarget) || distancesquared(self.origin, self.target_getindexoftarget.origin) > 4096) {
    self func_83AF();
    self.a.usingworldspacehitmarkers delete();
    self.a.usingworldspacehitmarkers = undefined;
    if(isDefined(self.var_394) && self.var_394 != "none") {
      scripts\anim\shared::placeweaponon(self.var_394, "right");
      return;
    }

    return;
  }

  if(var_0 != "saw") {
    self.a.usingworldspacehitmarkers delete();
  }
}

func_D860(var_0) {
  scripts\anim\shared::placeweaponon(self.var_394, "right");
}

func_5AAA(var_0) {}

func_57DB(var_0) {}

func_12A63(var_0) {}

func_12A64() {}

func_12A62() {}