/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1913.gsc
*************************************************/

init() {
  level._effect["candypile_fire"] = loadfx("vfx/iw7/_requests/coop/zmb_candypile_fire.vfx");
  level._effect["candypile_idle"] = loadfx("vfx/iw7/_requests/coop/zmb_candypile_idle.vfx");
  level._id_3E44 = [];
  level._id_3E44["crafted_gascan"] = spawnStruct();
  level._id_3E44["crafted_gascan"]._id_F224 = 180;
  level._id_3E44["crafted_gascan"].modelbase = "zmb_candybox_crafted_lod0";
  level._id_3E44["crafted_gascan"]._id_9FDD = "zmb_candybox_crafted_lod0";
  level._id_3E44["crafted_gascan"]._id_9FDE = "zmb_candybox_crafted_lod0";
  level._id_3E44["crafted_gascan"]._id_B15F = "zmb_candybox_crafted_lod0";
}

_id_6EDB(var_0, var_1) {
  var_1 thread _id_10A2B();
  var_1 notify("new_power", "crafted_gascan");
  var_1 thread scripts\cp\utility::_id_FE75(var_1, "iw7_pickup_zm");
  scripts\cp\utility::_id_D19E("crafted_gascan", ::_id_6EDB, var_1);
}

_id_10A2B() {
  self endon("disconnect");
  self notify("craft_dpad_watcher");
  self endon("craft_dpad_watcher");
  self endon("death");
  self notifyonplayercommand("pullout_gascan", "+actionslot 3");

  for(;;) {
    self waittill("pullout_gascan");

    if(istrue(self._id_87A7)) {
      continue;
    }
    if(istrue(self._id_9500)) {
      continue;
    }
    if(isDefined(self._id_1529) && self._id_1529 == 0) {
      continue;
    }
    if(scripts\cp\utility::_id_8708()) {
      break;
    }
  }

  thread _id_6EEC(1);
}

_id_6EEC(var_0, var_1) {
  self endon("disconnect");
  scripts\cp\utility::_id_3958("msg_power_hint");
  var_2 = _id_3FE7(self);
  self._id_8B3D = var_2.name;
  _id_C4FE();
  self._id_32D2 = var_2;
  var_3 = _id_D4B9(var_2, var_0, var_1);
  self._id_32D2 = undefined;
  thread _id_1085C();
  self._id_87A7 = 0;

  if(isDefined(var_2)) {
    return 1;
  } else {
    return 0;
  }
}

_id_D4B9(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 _id_61C7(self, var_1);
  scripts\common\utility::_id_158D(0);
  self notifyonplayercommand("place_gascan", "+attack");
  self notifyonplayercommand("place_gascan", "+attack_akimbo_accessible");
  self notifyonplayercommand("cancel_gascan", "+actionslot 3");

  if(!self _meth_8684()) {
    self notifyonplayercommand("cancel_gascan", "+actionslot 5");
    self notifyonplayercommand("cancel_gascan", "+actionslot 6");
    self notifyonplayercommand("cancel_gascan", "+actionslot 7");
  }

  for(;;) {
    var_3 = scripts\engine\utility::_id_10898("place_gascan", "cancel_gascan", "force_cancel_placement");

    if(!isDefined(var_0)) {
      scripts\common\utility::_id_158D(1);
      return 1;
    }

    if(!isDefined(var_3)) {
      var_3 = "force_cancel_placement";
    }

    if(var_3 == "cancel_gascan" || var_3 == "force_cancel_placement") {
      if(!var_1 && var_3 == "cancel_gascan") {
        continue;
      }
      scripts\common\utility::_id_158D(1);
      var_0 _id_61C6();

      if(var_3 != "force_cancel_placement") {
        thread _id_10A2B();
      } else if(var_1) {
        scripts\cp\utility::_id_C397(self);
      }

      return 0;
    }

    if(!var_0._id_314C) {
      continue;
    }
    if(var_1) {
      scripts\cp\utility::_id_C397(self);
    }

    var_0 thread _id_61C5(var_2, self);
    self waittill("gas_poured");
    scripts\common\utility::_id_158D(1);
    return 1;
  }
}

_id_C541() {
  if(self._id_75A5) {
    var_0 = scripts\cp\utility::_id_C88A();
    self._id_C713 = var_0;
    self._id_C883 = self _meth_8109(var_0);
    self takeweapon(var_0);
  }
}

_id_C4FE() {
  if(scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    self._id_C70D = "specialty_explosivebullets";
    scripts\cp\utility::_unsetperk("specialty_explosivebullets");
  }
}

_id_C715() {
  if(isDefined(self._id_C713)) {
    scripts\cp\utility::_giveweapon(self._id_C713);

    if(self._id_75A5) {
      var_0 = scripts\cp\utility::_id_C88A();
      self setweaponammoclip(var_0, self._id_C883);
    }
  }

  self._id_C713 = undefined;
}

_id_C70E() {
  if(isDefined(self._id_C70D)) {
    scripts\cp\utility::_id_6FC2(self._id_C70D);
    self._id_C70D = undefined;
  }
}

_id_1085C() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  wait 0.05;
  _id_C70E();
}

_id_3FE7(var_0) {
  var_1 = spawnturret("misc_turret", var_0.origin + (0, 0, 25), "sentry_minigun_mp");
  var_1.angles = var_0.angles;
  var_1.owner = var_0;
  var_1.name = "crafted_gascan";
  var_1._id_32CB = spawn("script_model", var_1.origin);
  var_1._id_32CB.angles = var_0.angles;
  var_1 _meth_8224();
  var_1 _meth_839D(1);
  var_1 setmode("sentry_offline");
  var_1 makeunusable();
  var_1 setsentryowner(var_0);
  var_1 _id_61C4(var_0);
  var_1 notsolid();
  var_1._id_32CB notsolid();
  return var_1;
}

_id_61C4(var_0) {
  self._id_314C = 1;
}

_id_61C5(var_0, var_1) {
  var_1 endon("disconnect");
  self._id_89C1 = 1;

  if(!isDefined(level._id_3182)) {
    level._id_3182 = [];
  }

  var_2 = 0;

  for(;;) {
    while(var_1 attackbuttonpressed() && var_2 <= 4) {
      if(!self._id_314C) {
        wait 0.05;
        continue;
      }

      if(!isDefined(self._id_759B)) {
        self._id_759B = 0;
      }

      var_1 playSound("trap_kindle_pops_pour");
      self._id_89C1 = 1;
      _id_E14A(var_1, self);
      self._id_759B++;
      self._id_A416 = 1;
      wait 0.35;
      var_2++;
    }

    if(var_2 > 4) {
      break;
    }

    self._id_89C1 = undefined;
    wait 0.05;
  }

  self._id_89C1 = undefined;
  var_1 notify("gas_poured");
  var_3 = spawn("script_model", self._id_32CB.origin);
  var_3.angles = self._id_32CB.angles;
  var_3 setModel(level._id_3E44["crafted_gascan"]._id_B15F);
  var_3 physicslaunchserver(var_3.origin + (randomfloatrange(-20, 20), randomfloatrange(-20, 20), 0), (randomfloatrange(-20, 20), randomfloatrange(-20, 20), 10));
  var_3 playSound("trap_kindle_pops_can_drop");
  self._id_32CA _meth_80FC();
  self._id_32CA = undefined;
  var_1._id_87A7 = 0;
  self notify("placed");
  self._id_32CB delete();
  self delete();
  wait 1;
  var_1 scripts\cp\utility::_id_D5E9("candy_hint", &"ZOMBIE_CRAFTING_SOUVENIRS/SHOOT_TO_IGNITE", 4);
  wait 15;
  var_3 delete();
}

_id_106F9(var_0) {
  thread _id_7CB8();
  thread _id_619C();
  thread _id_619D(level._id_3E44["crafted_gascan"]._id_F224);
  self waittill("gas_spot_damaged");
  self playSound("trap_kindle_pops_ignite");
  var_1 = gettime() + 40000;
  self notify("damage_monitor");
  thread _id_619A(var_1, var_0);
}

_id_7CB8() {
  self endon("gas_spot_damaged");
  self._id_605B = spawnfx(level._effect["candypile_idle"], self.origin);
  waitframe();
  triggerfx(self._id_605B);
}

_id_619D(var_0) {
  self endon("gas_spot_damaged");
  wait(var_0);
  self notify("damage_monitor");
  level._id_3182 = scripts\engine\utility::array_remove(level._id_3182, self);
  self._id_605B delete();
  scripts\cp\utility::_id_C4BF();
  self delete();
}

_id_619C() {
  self endon("damage_monitor");
  var_0 = 9216;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isPlayer(var_2) && isDefined(var_10) && var_5 != "MOD_MELEE") {
      self notify("gas_spot_damaged");

      foreach(var_12 in level._id_3182) {
        if(var_12 == self) {
          continue;
        }
        if(distancesquared(var_12.origin, self.origin) > var_0) {
          continue;
        } else {
          var_12 notify("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
        }
      }

      return;
    }
  }
}

_id_619A(var_0, var_1) {
  self._id_605B delete();
  waitframe();
  self playLoopSound("trap_kindle_pops_fire_lp");
  self._id_605B = spawnfx(level._effect["candypile_fire"], self.origin);
  waitframe();
  triggerfx(self._id_605B);
  self._id_42DD = spawn("trigger_radius", self.origin, 1, 64, 32);
  self._id_42DD._id_0481 = "kindlepops_trig";
  self._id_42DD.owner = var_1;
  thread _id_619B();

  while(gettime() < var_0) {
    wait 0.1;
  }

  playsoundatpos(self.origin, "trap_kindle_pops_fire_end");
  self stoploopsound();
  self._id_42DD delete();
  self._id_605B delete();
  level._id_3182 = scripts\engine\utility::array_remove(level._id_3182, self);
  self delete();
}

_id_619B() {
  self._id_42DD endon("death");

  for(;;) {
    self._id_42DD waittill("trigger", var_0);

    if(isPlayer(var_0) && isalive(var_0) && !_id_073B::_id_B4EF(var_0) && !isDefined(var_0._id_ADD5)) {
      var_0._id_ADD5 = 1;
      var_0 dodamage(15, var_0.origin);
      var_0 thread _id_C429();
    }

    if(!scripts\cp\utility::_id_DA7B(var_0)) {
      continue;
    }
    var_0 _id_332A(2, var_0.health + 5, self._id_42DD);
  }
}

_id_C429() {
  self endon("disconnect");
  wait 0.5;
  self._id_ADD5 = undefined;
}

_id_332A(var_0, var_1, var_2) {
  if(isalive(self) && !istrue(self._id_9B33) && !istrue(self._id_856F)) {
    thread scripts\cp\utility::_id_42D4(self, var_2, var_0, var_1, undefined, "iw7_kindlepops_zm", undefined, "chemBurn");
  }
}

_id_E14A(var_0, var_1) {
  var_2 = ["zmb_candy_pile_01", "zmb_candy_pile_02"];
  var_3 = spawn("script_model", var_1.origin + (0, 0, 5));
  var_3.angles = self.angles;
  var_3 setModel(scripts\engine\utility::random(var_2));
  var_4 = 100;
  var_5 = getgroundposition(var_1.origin, 4);
  var_3 moveto(var_5 + (0, 0, 1), 0.25);

  foreach(var_7 in level._id_3182) {
    if(distancesquared(var_7.origin, var_3.origin) < 100) {
      var_3 delete();
      break;
    }
  }

  if(!isDefined(var_3)) {
    return;
  }
  var_3 setCanDamage(1);
  var_3.health = 10000;
  var_3.owner = var_0;
  var_3.name = "crafted_gascan";
  var_0._id_8B3D = var_3.name;
  level._id_3182[level._id_3182.size] = var_3;
  var_3 scripts\cp\utility::_id_1179();
  var_3 thread _id_106F9(var_0);
}

_id_61C6() {
  self._id_32CA _meth_80FC();

  if(isDefined(self.owner)) {
    self.owner._id_87A7 = 0;
  }

  self._id_32CB delete();
  self delete();
}

_id_61C7(var_0, var_1) {
  if(isDefined(self._id_AC8F)) {} else {}

  self setModel(level._id_3E44["crafted_gascan"]._id_9FDD);
  self hide();
  self _meth_8376(var_0);
  self setCanDamage(0);
  self._id_32CA = var_0;
  var_0._id_87A7 = 1;
  var_0 thread _id_FC7E(self, var_1);
  thread scripts\cp\utility::_id_8B26(var_0);
  thread scripts\cp\utility::_id_8B27(var_0);
  thread scripts\cp\utility::_id_8B28(var_0);
  self notify("carried");
}

_id_FC7E(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("placed");
  var_0 endon("death");
  var_0._id_314C = 1;
  var_2 = -1;
  var_0._id_A416 = 0;

  for(;;) {
    var_0._id_314C = _id_30DD(var_0);

    if(var_0._id_314C != var_2 || var_0._id_A416) {
      var_0._id_A416 = 0;

      if(var_0._id_314C) {
        var_0._id_32CB setModel(level._id_3E44["crafted_gascan"]._id_9FDD);

        if(!isDefined(var_0._id_759B)) {
          self _meth_80FD(&"ZOMBIE_CRAFTING_SOUVENIRS/POUR_CANCELABLE");
        } else if(var_0._id_759B == 1) {
          self _meth_80FD(&"ZOMBIE_CRAFTING_SOUVENIRS/POUR_80");
        } else if(var_0._id_759B == 2) {
          self _meth_80FD(&"ZOMBIE_CRAFTING_SOUVENIRS/POUR_60");
        } else if(var_0._id_759B == 3) {
          self _meth_80FD(&"ZOMBIE_CRAFTING_SOUVENIRS/POUR_40");
        } else if(var_0._id_759B == 4) {
          self _meth_80FD(&"ZOMBIE_CRAFTING_SOUVENIRS/POUR_20");
        }
      } else {
        var_0._id_32CB setModel(level._id_3E44["crafted_gascan"]._id_9FDE);
        self _meth_80FD(&"COOP_CRAFTABLES/CANNOT_PLACE");
      }
    }

    var_2 = var_0._id_314C;
    wait 0.05;
  }
}

_id_30DD(var_0) {
  var_1 = self _meth_8065();
  var_0.origin = var_1["origin"];
  var_0.angles = var_1["angles"];
  var_0._id_32CB.origin = var_1["origin"] + (0, 0, 35);
  var_0.name = "crafted_gascan";
  var_0._id_32CB.name = "crafted_gascan";

  if(isDefined(var_0._id_89C1)) {
    var_0._id_32CB.angles = var_1["angles"] + (35, 0, 0);
  } else {
    var_0._id_32CB.angles = var_1["angles"];
  }

  return self isonground() && var_1["result"] && abs(var_1["origin"][2] - self.origin[2]) < 30;
}