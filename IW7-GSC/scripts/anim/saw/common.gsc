/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\saw\common.gsc
***************************************/

main(var_0) {
  self endon("killanimscript");

  if(!isDefined(var_0)) {
    return;
  }
  self.a._id_10930 = "saw";

  if(isDefined(var_0.script_delay_min)) {
    var_1 = var_0.script_delay_min;
  } else {
    var_1 = scripts\sp\mgturret::_id_32B6("delay");
  }

  if(isDefined(var_0.script_delay_max)) {
    var_2 = var_0.script_delay_max - var_1;
  } else {
    var_2 = scripts\sp\mgturret::_id_32B6("delay_range");
  }

  if(isDefined(var_0._id_ED26)) {
    var_3 = var_0._id_ED26;
  } else {
    var_3 = scripts\sp\mgturret::_id_32B6("burst");
  }

  if(isDefined(var_0._id_ED25)) {
    var_4 = var_0._id_ED25 - var_3;
  } else {
    var_4 = scripts\sp\mgturret::_id_32B6("burst_range");
  }

  var_5 = gettime();
  var_6 = "start";
  scripts\anim\shared::placeweaponon(self.weapon, "none");
  var_0 show();

  if(isDefined(var_0._id_1A56)) {
    self.a._id_D707 = ::_id_D707;
    self.a.usingworldspacehitmarkers = var_0;
    var_0 notify("being_used");
    thread _id_1109E();
  } else
    self.a._id_D707 = ::_id_D860;

  var_0._id_5855 = 0;
  thread _id_6D63(var_0);
  self setturretanim(self.primaryturretanim);
  self _meth_82AB(self.primaryturretanim, 1, 0.2, 1);
  self _meth_82AA(self._id_17E3);
  self _meth_82AA(self._id_17E2);
  var_0 _meth_82AA(var_0._id_17E3);
  var_0 _meth_82AA(var_0._id_17E2);
  var_0 endon("death");

  for(;;) {
    if(var_0._id_5855) {
      thread _id_5AAA(var_0);
      _id_13848(randomfloatrange(var_3, var_3 + var_4), var_0);
      var_0 notify("turretstatechange");

      if(var_0._id_5855) {
        thread _id_57DB(var_0);
        wait(randomfloatrange(var_1, var_1 + var_2));
      }

      continue;
    }

    thread _id_57DB(var_0);
    var_0 waittill("turretstatechange");
  }
}

_id_13848(var_0, var_1) {
  var_1 endon("turretstatechange");
  wait(var_0);
}

_id_6D63(var_0) {
  self endon("killanimscript");
  var_1 = cos(15);

  for(;;) {
    while(isDefined(self.enemy)) {
      var_2 = self.enemy.origin;
      var_3 = var_0 gettagangles("tag_aim");

      if(scripts\engine\utility::within_fov(var_0.origin, var_3, var_2, var_1) || distancesquared(var_0.origin, var_2) < 40000) {
        if(!var_0._id_5855) {
          var_0._id_5855 = 1;
          var_0 notify("turretstatechange");
        }
      } else if(var_0._id_5855) {
        var_0._id_5855 = 0;
        var_0 notify("turretstatechange");
      }

      wait 0.05;
    }

    if(var_0._id_5855) {
      var_0._id_5855 = 0;
      var_0 notify("turretstatechange");
    }

    wait 0.05;
  }
}

_id_12A99(var_0, var_1) {
  if(var_0 <= 0) {
    return;
  }
  self endon("killanimscript");
  var_1 endon("turretstatechange");
  wait(var_0);
  var_1 notify("turretstatechange");
}

_id_1109E() {
  self endon("killanimscript");

  for(;;) {
    if(!isDefined(self.node) || distancesquared(self.origin, self.node.origin) > 4096) {
      self _meth_83AF();
    }

    wait 0.25;
  }
}

_id_D707(var_0) {
  if(var_0 == "pain") {
    if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < 4096) {
      self.a.usingworldspacehitmarkers hide();
      scripts\anim\shared::placeweaponon(self.weapon, "right");
      self.a._id_D707 = ::_id_D705;
      return;
    } else
      self _meth_83AF();
  }

  if(var_0 == "saw") {
    var_1 = self _meth_8164();
    return;
  }

  self.a.usingworldspacehitmarkers delete();
  self.a.usingworldspacehitmarkers = undefined;
  scripts\anim\shared::placeweaponon(self.weapon, "right");
}

_id_D705(var_0) {
  if(!isDefined(self.node) || distancesquared(self.origin, self.node.origin) > 4096) {
    self _meth_83AF();
    self.a.usingworldspacehitmarkers delete();
    self.a.usingworldspacehitmarkers = undefined;

    if(isDefined(self.weapon) && self.weapon != "none") {
      scripts\anim\shared::placeweaponon(self.weapon, "right");
    }
  } else if(var_0 != "saw")
    self.a.usingworldspacehitmarkers delete();
}

_id_D860(var_0) {
  scripts\anim\shared::placeweaponon(self.weapon, "right");
}

_id_5AAA(var_0) {}

_id_57DB(var_0) {}

_id_12A63(var_0) {}

_id_12A64() {}

_id_12A62() {}