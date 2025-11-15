/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\saw\common.gsc
***************************************/

main(param_00) {
  self endon("killanimscript");
  if(!isDefined(param_00)) {
    return;
  }

  self.a.var_10930 = "saw";
  if(isDefined(param_00.script_delay_min)) {
    var_01 = param_00.script_delay_min;
  } else {
    var_01 = scripts\sp\mgturret::func_32B6("delay");
  }

  if(isDefined(param_00.script_delay_max)) {
    var_02 = param_00.script_delay_max - var_01;
  } else {
    var_02 = scripts\sp\mgturret::func_32B6("delay_range");
  }

  if(isDefined(param_00.var_ED26)) {
    var_03 = param_00.var_ED26;
  } else {
    var_03 = scripts\sp\mgturret::func_32B6("burst");
  }

  if(isDefined(param_00.var_ED25)) {
    var_04 = param_00.var_ED25 - var_03;
  } else {
    var_04 = scripts\sp\mgturret::func_32B6("burst_range");
  }

  var_05 = gettime();
  var_06 = "start";
  scripts\anim\shared::placeweaponon(self.var_394, "none");
  param_00 show();
  if(isDefined(param_00.var_1A56)) {
    self.a.var_D707 = ::func_D707;
    self.a.usingworldspacehitmarkers = param_00;
    param_00 notify("being_used");
    thread func_1109E();
  } else {
    self.a.var_D707 = ::func_D860;
  }

  param_00.var_5855 = 0;
  thread func_6D63(param_00);
  self setturretanim(self.primaryturretanim);
  self _meth_82AB(self.primaryturretanim, 1, 0.2, 1);
  self _meth_82AA(self.var_17E3);
  self _meth_82AA(self.var_17E2);
  param_00 _meth_82AA(param_00.var_17E3);
  param_00 _meth_82AA(param_00.var_17E2);
  param_00 endon("death");
  for(;;) {
    if(param_00.var_5855) {
      thread func_5AAA(param_00);
      func_13848(randomfloatrange(var_03, var_03 + var_04), param_00);
      param_00 notify("turretstatechange");
      if(param_00.var_5855) {
        thread func_57DB(param_00);
        wait(randomfloatrange(var_01, var_01 + var_02));
      }

      continue;
    }

    thread func_57DB(param_00);
    param_00 waittill("turretstatechange");
  }
}

func_13848(param_00, param_01) {
  param_01 endon("turretstatechange");
  wait(param_00);
}

func_6D63(param_00) {
  self endon("killanimscript");
  var_01 = cos(15);
  for(;;) {
    while(isDefined(self.isnodeoccupied)) {
      var_02 = self.isnodeoccupied.origin;
      var_03 = param_00 gettagangles("tag_aim");
      if(scripts\engine\utility::within_fov(param_00.origin, var_03, var_02, var_01) || distancesquared(param_00.origin, var_02) < -25536) {
        if(!param_00.var_5855) {
          param_00.var_5855 = 1;
          param_00 notify("turretstatechange");
        }
      } else if(param_00.var_5855) {
        param_00.var_5855 = 0;
        param_00 notify("turretstatechange");
      }

      wait(0.05);
    }

    if(param_00.var_5855) {
      param_00.var_5855 = 0;
      param_00 notify("turretstatechange");
    }

    wait(0.05);
  }
}

func_12A99(param_00, param_01) {
  if(param_00 <= 0) {
    return;
  }

  self endon("killanimscript");
  param_01 endon("turretstatechange");
  wait(param_00);
  param_01 notify("turretstatechange");
}

func_1109E() {
  self endon("killanimscript");
  for(;;) {
    if(!isDefined(self.target_getindexoftarget) || distancesquared(self.origin, self.target_getindexoftarget.origin) > 4096) {
      self _meth_83AF();
    }

    wait(0.25);
  }
}

func_D707(param_00) {
  if(param_00 == "pain") {
    if(isDefined(self.target_getindexoftarget) && distancesquared(self.origin, self.target_getindexoftarget.origin) < 4096) {
      self.a.usingworldspacehitmarkers hide();
      scripts\anim\shared::placeweaponon(self.var_394, "right");
      self.a.var_D707 = ::func_D705;
      return;
    } else {
      self _meth_83AF();
    }
  }

  if(param_00 == "saw") {
    var_01 = self _meth_8164();
    return;
  }

  self.a.usingworldspacehitmarkers delete();
  self.a.usingworldspacehitmarkers = undefined;
  scripts\anim\shared::placeweaponon(self.var_394, "right");
}

func_D705(param_00) {
  if(!isDefined(self.target_getindexoftarget) || distancesquared(self.origin, self.target_getindexoftarget.origin) > 4096) {
    self _meth_83AF();
    self.a.usingworldspacehitmarkers delete();
    self.a.usingworldspacehitmarkers = undefined;
    if(isDefined(self.var_394) && self.var_394 != "none") {
      scripts\anim\shared::placeweaponon(self.var_394, "right");
      return;
    }

    return;
  }

  if(param_00 != "saw") {
    self.a.usingworldspacehitmarkers delete();
  }
}

func_D860(param_00) {
  scripts\anim\shared::placeweaponon(self.var_394, "right");
}

func_5AAA(param_00) {}

func_57DB(param_00) {}

func_12A63(param_00) {}

func_12A64() {}

func_12A62() {}