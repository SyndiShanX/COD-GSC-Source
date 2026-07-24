/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2590.gsc
**************************************/

_id_234D(var_0, var_1) {
  scripts\asm\asm::_id_234E();

  if(var_1 == "hero_salter" || var_1 == "hero_boats")
    scripts\asm\asm_bb::_id_2984(1);

  self.asm = spawnStruct();
  self.asm.archetype = var_1;
  self.asm.animoverrides = [];
  self.asm._id_7360 = 0;
  self._id_164D = [];
  self.asmname = var_0;
  self._id_718D = ::_id_230D;
  self._id_7195 = ::_id_238D;
  self._id_718E = ::_id_230E;
  self._id_718F = ::_id_230F;
  self._id_7194 = ::_id_2382;
  self._id_7193 = ::_id_235B;
  self._id_7192 = ::_id_2348;
  self._id_7191 = ::asm_getallanimsforstate;
  self._id_7190 = ::asm_getallanimsforalias;
  scripts\asm\asm::_id_2351(var_0, 1);
}

_id_2382(var_0, var_1) {
  if(!isDefined(var_1._id_4E6D))
    return 0;

  return !isalive(self);
}

_id_12EE7(var_0) {
  if(self.damageshield && !isDefined(self._id_55BF)) {
    var_1 = 1500;

    if(!isDefined(self.a._id_A9C8))
      self.a._id_A9C8 = 0;

    if(!isDefined(self.damageshieldcounter) || gettime() - self.a._id_A9C8 > var_1)
      self.damageshieldcounter = randomintrange(2, 3);

    if(isDefined(self.lastattacker) && distancesquared(self.origin, self.lastattacker.origin) < squared(512))
      self.damageshieldcounter = 0;

    if(self.damageshieldcounter > 0)
      self.damageshieldcounter--;
  }

  if(isDefined(var_0))
    self.damagedsubpart = var_0;
  else
    self.damagedsubpart = undefined;
}

_id_1004C() {
  if(isDefined(self._id_71D0))
    return self[[self._id_71D0]]();

  return _id_1004D();
}

_id_1004D() {
  var_0 = 4096;

  if(self.a._id_5605)
    return 0;

  if(isDefined(self.pathgoalpos) && self pathdisttogoal() < var_0)
    return 0;

  return 1;
}

_id_51B8() {
  self endon("terminate_ai_threads");
  self waittill("entitydeleted");

  foreach(var_3, var_1 in self._id_164D) {
    var_2 = var_1._id_4BC0;
    self notify(var_2 + "_finished");
  }

  self notify("terminate_ai_threads");
}

_id_C879() {
  if(1) {
    _id_12EE7();

    if(!_id_1004C()) {
      if(isDefined(self.script) && self.script == "pain")
        self notify("killanimscript");

      return;
    }

    var_0 = 0;

    foreach(var_9, var_2 in self._id_164D) {
      var_3 = var_2._id_4BC0;
      var_4 = anim.asm[var_9].states[var_3];

      if(!isDefined(var_4._id_C87F)) {
        continue;
      }
      var_5 = anim.asm[var_9].states[var_4._id_C87F];
      scripts\asm\asm::_id_2388(var_9, var_3, var_4, var_4._id_116FB);
      var_6 = var_4._id_C87F;

      if(isDefined(var_5._id_C94B) && var_5._id_C94B)
        [var_6, var_8] = scripts\asm\asm::_id_2310(var_9, var_4._id_C87F, 1);

      scripts\asm\asm::_id_238A(var_9, var_6, 0.05, undefined, undefined, var_4._id_C87C);

      if(isDefined(self.unittype) && self.unittype == "c6")
        self playSound("shield_death_c6_1");

      var_0 = 1;
    }

    if(!var_0 && self.script == "pain")
      self notify("killanimscript");
  }

  self endon("killanimscript");
  self waittill("Hellfreezesover");
}

traversehandler() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("traverse_begin", var_0, var_1);

    if(1) {
      var_2 = self.asmname;
      var_3 = anim.asm[var_2];

      if(!_id_234B(self.asm.archetype, var_0))
        var_0 = "traverse_external";

      var_4 = self._id_164D[var_2]._id_4BC0;
      var_5 = var_3.states[var_4];

      if(var_4 == "traversal_orient") {
        continue;
      }
      scripts\asm\asm::_id_2388(var_2, var_4, var_5, var_5._id_116FB);
      scripts\asm\asm::_id_238A(var_2, var_0, 0.2, undefined, undefined, undefined);
    }
  }
}

_id_111A9() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("damage_subpart", var_0);

    foreach(var_2 in var_0) {
      _id_12EE7(var_2.subpartname);

      if(!_id_1004C()) {
        if(isDefined(self.script) && self.script == "pain")
          self notify("killanimscript");

        continue;
      }

      var_3 = 0;

      foreach(var_12, var_5 in self._id_164D) {
        var_6 = var_5._id_4BC0;
        var_7 = anim.asm[var_12].states[var_6];

        if(!isDefined(var_7._id_C87F)) {
          continue;
        }
        var_8 = anim.asm[var_12].states[var_7._id_C87F];
        scripts\asm\asm::_id_2388(var_12, var_6, var_7, var_7._id_116FB);
        var_9 = var_7._id_C87F;

        if(isDefined(var_8._id_C94B) && var_8._id_C94B)
          [var_9, var_11] = scripts\asm\asm::_id_2310(var_12, var_7._id_C87F, 1);

        scripts\asm\asm::_id_238A(var_12, var_9, 0.05, undefined, undefined, var_7._id_C87C);
        var_3 = 1;
      }

      if(!var_3 && self.script == "pain")
        self notify("killanimscript");
    }
  }
}

_id_237F(var_0) {
  switch (var_0) {
    case "face node":
      var_1 = 1024.0;

      if(scripts\engine\utility::actor_is3d()) {
        var_2 = self.angles;

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1)
          var_2 = scripts\asm\shared\utility::getnodeforwardangles(self.node);

        self orientmode("face angle 3d", var_2);
      } else {
        var_3 = self.angles[1];

        if(isDefined(self.node) && distancesquared(self.origin, self.node.origin) < var_1)
          var_3 = scripts\asm\shared\utility::getnodeforwardyaw(self.node);

        self orientmode("face angle", var_3);
      }

      break;
    case "face current":
      self orientmode("face angle 3d", self.angles);
      break;
    default:
      self orientmode(var_0);
      break;
  }
}

_id_237E(var_0) {
  self animmode(var_0, 0);
}

_id_230E(var_0, var_1) {
  if(scripts\asm\asm::_id_231B(var_0, "gesture"))
    _id_2381(var_0, var_1);
}

_id_238D(var_0) {
  if(isDefined(var_0._id_10B53) && var_0._id_10B53 != "") {
    if(var_0._id_10B53 != "prone" && self.a.pose != var_0._id_10B53)
      scripts\anim\utility::exitpronewrapper(1.0);

    self.a.pose = var_0._id_10B53;
    scripts\asm\asm_bb::bb_requestsmartobject(var_0._id_10B53);
  }
}

_id_230D(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::_id_231B(var_0, "aim"))
    _id_2380(var_0, var_2, var_3);
}

_id_2326(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;

  if(isDefined(var_4))
    var_5 = var_4;

  self waittill(var_5, var_6);

  if(!isDefined(var_6))
    var_6 = ["undefined"];

  if(!isarray(var_6))
    var_6 = [var_6];

  var_7 = undefined;

  foreach(var_9 in var_6) {
    scripts\asm\asm::asm_fireevent(var_1, var_9);
    var_10 = scripts\anim\notetracks::handlenotetrack(var_9, var_5, var_2, var_3);

    if(!isDefined(var_10))
      var_10 = _id_2344(var_0, var_9, var_1);

    if(isDefined(var_10))
      var_7 = var_10;
  }

  return var_7;
}

_id_2344(var_0, var_1, var_2) {
  if(_id_238B(var_1)) {
    return;
  }
  switch (var_1) {
    case "start_aim":
      var_3 = anim.asm[var_0].states[var_2];

      if(isDefined(var_3.flags) && scripts\engine\utility::array_contains(var_3.flags, "notetrackAim"))
        _id_2380(var_0, var_2, 0.2);

      break;
  }
}

_id_238B(var_0) {
  if(!scripts\engine\utility::string_starts_with(var_0, "ds "))
    return 0;

  var_1 = 3;
  self.asm._id_4E6E = spawnStruct();
  var_1 = var_1 + 1;

  for(var_2 = ""; var_1 < var_0.size && var_0[var_1] != "]"; var_1 = var_1 + 1)
    var_2 = var_2 + var_0[var_1];

  self.asm._id_4E6E._id_10E2C = var_2;
  var_1 = var_1 + 1;

  if(var_1 < var_0.size) {
    var_1 = var_1 + 2;

    for(var_3 = ""; var_1 < var_0.size && var_0[var_1] != "]"; var_1 = var_1 + 1)
      var_3 = var_3 + var_0[var_1];

    self.asm._id_4E6E.params = var_3;
  }

  return 1;
}

_id_2324(var_0, var_1, var_2) {
  self endon(var_0);
  wait(var_2);
  self notify(var_1);
}

_id_2323(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1 + "_timeout";
  var_6 = var_1 + "_endHelper";
  self endon(var_5);
  thread _id_2324(var_6, var_5, var_2);
  var_7 = _id_231F(var_0, var_1, var_3, var_4);
  self notify(var_6);
  return var_7;
}

_id_231F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5))
    var_5 = 1;

  for(;;) {
    var_6 = _id_2326(var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_6)) {
      if(var_5 && !scripts\asm\asm::_id_232B(var_1, "end"))
        scripts\asm\asm::asm_fireevent(var_1, "end");

      return var_6;
    }
  }
}

_id_2322(var_0, var_1, var_2, var_3) {
  for(;;) {
    self waittill(var_1, var_4);

    if(!isDefined(var_4))
      var_4 = ["undefined"];

    if(!isarray(var_4))
      var_4 = [var_4];

    var_5 = undefined;

    foreach(var_7 in var_4) {
      var_8 = [[var_2]](var_1, var_7, var_3);

      if(isDefined(var_8) && var_8) {
        continue;
      }
      scripts\asm\asm::asm_fireevent(var_1, var_7);
      var_9 = scripts\anim\notetracks::handlenotetrack(var_7, var_1, undefined, undefined);

      if(isDefined(var_9))
        var_5 = var_9;
    }

    if(isDefined(var_5))
      return var_5;
  }
}

_id_2320(var_0, var_1, var_2, var_3) {
  var_4 = var_1 + "_note_loop_end";
  self endon(var_4);
  var_5 = getanimlength(var_2);
  thread _id_2321(var_4, var_1 + "_finished", var_5);
  _id_231F(var_0, var_1, var_3);
  self notify(var_4);
}

_id_2321(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_0);
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

_id_2309(var_0) {
  return animhasnotetrack(var_0, "facial_override");
}

_id_2318() {
  if(self._id_6A8B != "filler") {
    var_0 = _id_2356("Knobs", "head");
    self clearanim(var_0, 0.2);
    self.facialidx = undefined;
  }
}

_id_2376() {
  var_0 = self.asmname;
  var_1 = self._id_164D[var_0]._id_4BC0;

  if(var_1 == "AnimScripted") {
    return;
  }
  _id_2369(var_0, var_1, undefined);
}

_id_2369(var_0, var_1, var_2) {
  if(var_0 != self.asmname) {
    return;
  }
  if(isDefined(anim.asm[var_0].states[var_1]._id_6A8B))
    _id_236B(var_2, anim.asm[var_0].states[var_1]._id_6A8B, self.facialidx);
  else {
    _id_2318();
    self.asm._id_6A86 = "";
  }
}

_id_236B(var_0, var_1, var_2) {
  if(!scripts\asm\asm::asm_hasalias("Knobs", "head")) {
    return;
  }
  var_3 = _id_2356("Knobs", "head");

  if(!scripts\sp\utility::isfacialstateallowed("asm")) {
    return;
  }
  if(isDefined(var_0) && _id_2309(var_0)) {
    return;
  }
  if(!isDefined(self.asm._id_6A86))
    self.asm._id_6A86 = "";

  scripts\sp\utility::_id_F6FE("asm");

  if(self.asm._id_6A86 != var_1 || self _meth_8103(var_3) < 1.0) {
    self.asm._id_6A86 = var_1;
    var_4 = "facial_" + var_1;
    var_5 = scripts\asm\asm::asm_lookupanimfromalias("facial_animation", var_4);
    var_3 = _id_2356("Knobs", "head");

    if(isDefined(var_5)) {
      self setanimknob(var_5, 1, 0.1, 1);
      self _meth_82A2(var_3, 5, 0.1);
    }
  }
}

_id_236A(var_0) {
  self endon("death");
  var_1 = "";

  if(isDefined(self.asm))
    var_1 = self.asm.archetype;

  if(isDefined(self._id_1FA8))
    var_1 = self._id_1FA8;

  if(!scripts\sp\utility::isfacialstateallowed("asm") && var_0 != "facial_death") {
    return;
  }
  if(var_1 != "") {
    scripts\sp\utility::_id_F6FE("asm");
    var_2 = _func_2EF(var_1, "facial_animation", var_0, 0);

    if(var_0 == "facial_death") {
      if(isDefined(self._id_6A84)) {
        if(self._id_6A84 == var_0) {
          if(isDefined(self._id_6A83))
            var_2 = self._id_6A83;
        }
      }
    }

    if(isDefined(var_2)) {
      self setanimknob(var_2, 1, 0.267, 1);
      self._id_6A83 = var_2;
      self._id_6A84 = var_0;
    }
  }
}

_id_236C(var_0) {
  var_1 = "soldier";
  var_2 = _func_2EF(var_1, "facial_animation", "facial_death", 0);

  if(isDefined(var_2))
    var_0 setanimknob(var_2, 1, 0, 0);
}

_id_234F() {
  self endon("death");
  var_0 = 0;
  var_1 = 0;
  var_2 = _id_2356("Knobs", "body");
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    var_5 = self _meth_853F(var_2);
    var_6 = var_5[0] - var_0;
    var_7 = (var_6 > 0.001) - (var_6 < -0.001);

    if(var_7 != var_3) {
      if(var_7 > 0) {
        var_0 = var_5[0];
        var_3 = var_7;
        wait 0.1;
        _id_234C("left");
        continue;
      }

      if(var_7 < 0) {
        var_0 = var_5[0];
        var_3 = var_7;
        _id_2319("left");
        continue;
      }
    }

    var_0 = var_5[0];
    var_3 = var_7;
    var_8 = var_5[1] - var_1;
    var_9 = (var_8 > 0.001) - (var_8 < -0.001);

    if(var_9 != var_4) {
      if(var_9 > 0) {
        var_1 = var_5[1];
        var_4 = var_9;
        wait 0.1;
        _id_234C("right");
        continue;
      }

      if(var_9 < 0) {
        var_1 = var_5[1];
        var_4 = var_9;
        _id_2319("right");
        continue;
      }
    }

    var_1 = var_5[1];
    var_4 = var_9;
    wait 0.05;
  }
}

_id_234C(var_0) {
  var_1 = scripts\anim\utility::_id_7DA1();

  if(var_1 == "none")
    _id_2319(var_0);

  _id_236D(var_0);
}

_id_236D(var_0) {
  var_1 = scripts\anim\utility::_id_7DA1();

  if(var_1 == "none") {
    return;
  }
  var_2 = "ik_finger_pose_r";
  var_3 = "ik_fingers_r";
  var_4 = getweaponbasename(var_1);

  if(var_0 == "left") {
    var_2 = "ik_finger_pose_l";
    var_3 = "ik_fingers_l";
    var_5 = getweaponattachments(var_1);

    if(isDefined(var_5)) {
      if(scripts\engine\utility::array_contains(var_5, "foregrip"))
        var_4 = "foregrip";
    }
  }

  if(!_id_234B(self.asm.archetype, var_2)) {
    return;
  }
  if(!isDefined(var_4) || !scripts\asm\asm::asm_hasalias(var_2, var_4)) {
    if(!isDefined(var_4))
      var_4 = "UNDEFINED";

    return;
  }

  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_2, var_4);
  var_7 = _id_2356("Knobs", var_3);
  self _meth_82A2(var_7, 10, 0.3, 1.0);
  self _meth_82A2(var_6, 1, 0.3, 1.0);
}

_id_2319(var_0) {
  var_1 = "ik_fingers_l";

  if(var_0 == "right")
    var_1 = "ik_fingers_r";

  if(!scripts\asm\asm::asm_hasalias("Knobs", var_1)) {
    return;
  }
  var_2 = _id_2356("Knobs", var_1);
  self clearanim(var_2, 0.3, 1.0);
}

_id_2355() {
  var_0 = scripts\anim\utility::_id_7DA1();
  var_1 = getweaponbasename(var_0);
  var_2 = ["iw7_cheytac", "iw7_kbs", "iw7_m1", "iw7_m8", "iw7_mauler", "iw7_sdflmg", "iw7_ameli", "iw7_steeldragon", "iw7_sonic", "iw7_sdfshotty", "iw7_spas"];

  if(isDefined(var_1) && scripts\engine\utility::array_contains(var_2, var_1))
    return 1;

  return 0;
}

_id_236E() {
  _id_231A();
  var_0 = scripts\asm\asm::asm_lookupanimfromalias("Visor", "helmet_visor_up");

  if(self.asm._id_DC48 == 1)
    self _meth_82A2(var_0, 1, 0, 1.0);
  else {
    var_1 = scripts\asm\asm::asm_lookupanimfromalias("Visor", "helmet_visor_down");
    self _meth_82A2(var_1, 1, 0, 1.0);
    wait(getanimlength(var_1) - 0.1);
    _id_231A();
  }
}

_id_231A() {
  var_0 = _id_2356("Knobs", "visor");
  self clearanim(var_0, 0);
}

asm_getaimlimitset(var_0, var_1, var_2) {
  return _func_2F0(var_0, var_1);
}

_id_235E(var_0, var_1, var_2, var_3) {
  var_4 = asm_getaimlimitset(var_0, var_1);
  var_5 = 0.0;
  var_6 = undefined;
  var_7 = -1;

  if(isDefined(var_2))
    var_7 = var_2.size;

  if(!isDefined(var_4))
    return undefined;

  foreach(var_10 in var_4) {
    if(var_7 < 0 || getsubstr(var_10, 0, var_7) == var_2) {
      var_5 = var_5 + 1.0;
      var_11 = 1.0 / var_5;

      if(randomfloat(1.0) <= var_11)
        var_6 = var_10;
    }
  }

  return var_6;
}

_id_235D(var_0, var_1, var_2) {
  return _id_235E(self.asm.archetype, var_0, var_1, var_2);
}

_id_2357(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(self._id_1FA8))
    var_3 = _func_2EE(var_0, var_1, var_2, 0);
  else
    var_3 = _func_2EE(var_0, var_1, var_2, scripts\asm\asm::asm_getdemeanor());

  if(isDefined(var_3))
    return var_3.anims;
  else
    return undefined;
}

_id_2356(var_0, var_1) {
  if(isDefined(self._id_1FA8))
    var_2 = _id_2357(self._id_1FA8, var_0, var_1);
  else
    var_2 = _id_2357(self.asm.archetype, var_0, var_1);

  return var_2;
}

_id_2305(var_0, var_1, var_2) {
  var_3 = _func_2EE(var_0, var_1, var_2, scripts\asm\asm::asm_getdemeanor());

  if(isDefined(var_3))
    return 1;
  else
    return 0;
}

_id_2359(var_0, var_1, var_2) {
  return _func_2EF(var_0, var_1, var_2, scripts\asm\asm::asm_getdemeanor());
}

_id_235B(var_0, var_1) {
  var_2 = _id_2359(self.asm.archetype, var_0, var_1);
  return var_2;
}

_id_234B(var_0, var_1) {
  if(_func_2ED(var_0))
    return _func_2F1(var_0, var_1);
  else
    return 0;
}

_id_2348(var_0, var_1) {
  var_2 = _id_2357(self.asm.archetype, var_0, var_1);
  return isDefined(var_2);
}

asm_getallanimsforalias(var_0, var_1, var_2) {
  var_3 = _func_2EE(var_0, var_1, var_2, 1);

  if(!isDefined(var_3))
    return undefined;

  var_4 = var_3.anims;

  if(!isarray(var_4))
    var_4 = [var_4];

  var_5 = _func_2EE(var_0, var_1, var_2, 0);
  var_6 = var_5.anims;

  if(!isarray(var_6))
    var_6 = [var_6];

  foreach(var_8 in var_6) {
    if(!scripts\engine\utility::array_contains(var_4, var_8))
      var_4[var_4.size] = var_8;
  }

  return var_4;
}

asm_getallanimsforstate(var_0, var_1) {
  var_2 = anim.asm[var_0].states[var_1]._id_71A5;
  var_3 = anim.asm[var_0].states[var_1]._id_7DC8;
  var_4 = self[[var_2]](var_0, var_1, var_3);
  return var_4;
}

_id_2342() {
  return _id_2356("Knobs", "root");
}

asm_getbodyknob() {
  return _id_2356("Knobs", "body");
}

_id_235F(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = asm_getbodyknob();
  self clearanim(var_5, var_2);

  if(isDefined(var_4) && var_4) {
    if(scripts\asm\asm::asm_hasalias("Knobs", "move")) {
      var_6 = _id_2356("Knobs", "move");
      self _meth_84F2(var_6);
    }
  }

  var_7 = undefined;
  var_8 = scripts\asm\asm::_id_2341(var_0, var_1);
  var_9 = 0.2;
  var_10 = isDefined(var_4) && var_4;

  for(;;) {
    var_11 = asm_getallanimsforstate(var_0, var_1);

    if(isDefined(var_4) && var_4) {
      var_3 = scripts\asm\asm::asm_getmoveplaybackrate();
      self _meth_84F1(var_3);
    }

    if(isDefined(var_7) && var_7 != var_11)
      self clearanim(var_7, var_2);

    if(self _meth_8103(var_11) > 0)
      self _meth_82E1(var_1, var_11, 1, var_2, var_3);
    else
      self _meth_82EA(var_1, var_11, 1.0, var_2, var_3);

    _id_2369(var_0, var_1, var_11);
    var_12 = getanimlength(var_11);

    if(var_12 <= 0.05) {
      return;
    }
    var_13 = undefined;
    var_14 = var_3;

    while(!isDefined(var_13)) {
      var_13 = _id_2323(var_0, var_1, var_9, var_8);

      if(!isDefined(var_13) && var_10) {
        var_3 = scripts\asm\asm::asm_getmoveplaybackrate();

        if(var_3 != var_14) {
          self _meth_84F1(var_3);
          self _meth_82B1(var_11, var_3);
        }
      }
    }

    var_7 = var_11;
  }
}

_id_2368(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = asm_getallanimsforstate(var_0, var_1);
  self clearanim(asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_5, 1.0, var_2, 1.0);
  _id_2369(var_0, var_1, var_5);
  var_6 = _id_2322(var_0, var_1, var_3, var_4);

  if(var_6 == "end") {
    if(!scripts\asm\asm::_id_232B(var_1, "end"))
      scripts\asm\asm::asm_fireevent(var_1, "end");

    thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
  }
}

_id_2366(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = asm_getallanimsforstate(var_0, var_1);
  self clearanim(asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_3, 1.0, var_2, 1.0);
  _id_2369(var_0, var_1, var_3);
  var_4 = _id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_2364(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = asm_getallanimsforstate(var_0, var_1);
  self clearanim(asm_getbodyknob(), var_2);
  self _meth_82E7(var_1, var_3, 1.0, var_2, 1.0);
  _id_2369(var_0, var_1, var_3);
  var_4 = _id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));

  if(var_4 == "code_move")
    var_4 = _id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));

  if(var_4 == "end")
    thread scripts\asm\asm::_id_2310(var_0, var_1, 0);
}

_id_2363(var_0, var_1, var_2, var_3) {
  var_4 = asm_getallanimsforstate(var_0, var_1);
  var_5 = isDefined(var_3) && var_3 == "limited";

  if(var_5)
    self _meth_82E6(var_1, var_4, 1.0, var_2, 1.0);
  else
    self _meth_82E7(var_1, var_4, 1.0, var_2, 1.0);

  _id_2369(var_0, var_1, var_4);
  _id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
}

_id_2361(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = asm_getbodyknob();
  var_5 = isDefined(var_3) && var_3 == "limited";

  for(;;) {
    var_6 = asm_getallanimsforstate(var_0, var_1);

    if(var_4 != var_6) {
      if(var_5)
        self _meth_82E6(var_1, var_6, 1.0, var_2, 1.0);
      else
        self _meth_82E7(var_1, var_6, 1.0, var_2, 1.0);

      var_4 = var_6;
    }

    thread _id_2362(var_1, var_6, var_5);
    _id_2369(var_0, var_1, var_6);
    _id_231F(var_0, var_1, scripts\asm\asm::_id_2341(var_0, var_1));
    self notify(var_1 + "additive_cancel");
  }
}

_id_2362(var_0, var_1, var_2) {
  self endon(var_0 + "_finished");
  self endon(var_0 + "additive_cancel");

  while(isDefined(var_1)) {
    wait 0.2;

    if(var_2) {
      self _meth_82E8(var_0, var_1, 1.0, 0, 1.0);
      continue;
    }

    self _meth_82E1(var_0, var_1, 1.0, 0, 1.0);
  }
}

_id_2377(var_0) {
  if(isDefined(var_0["left"]))
    self.leftaimlimit = var_0["left"];
  else if(scripts\engine\utility::actor_is3d())
    self.leftaimlimit = 56;
  else
    self.leftaimlimit = 45;

  if(isDefined(var_0["right"]))
    self.rightaimlimit = var_0["right"];
  else if(scripts\engine\utility::actor_is3d())
    self.rightaimlimit = -56;
  else
    self.rightaimlimit = -45;

  if(isDefined(var_0["up"]))
    self.upaimlimit = var_0["up"];
  else if(scripts\engine\utility::actor_is3d())
    self.upaimlimit = -65;
  else
    self.upaimlimit = -45;

  if(isDefined(var_0["down"]))
    self.downaimlimit = var_0["down"];
  else if(scripts\engine\utility::actor_is3d())
    self.downaimlimit = 65;
  else
    self.downaimlimit = 45;
}

asm_generichandler(var_0, var_1) {
  if(!isDefined(level._id_1A43[var_0]))
    return "default";

  if(!isDefined(level._id_1A43[var_0][var_1]))
    return "default";

  return level._id_1A43[var_0][var_1];
}

_id_237D(var_0, var_1) {
  if(isDefined(self._id_9322) && self._id_9322) {
    return;
  }
  var_2 = asm_generichandler(var_0, var_1);

  if(!isDefined(level._id_43FE[var_0])) {
    _id_2377([]);
    return;
  }

  var_3 = scripts\asm\asm::asm_getdemeanor();

  if(var_3 && isDefined(level._id_7361[var_0][var_2])) {
    _id_2377(level._id_7361[var_0][var_2]);
    return;
  } else if(isDefined(level._id_43FE[var_0][var_2])) {
    _id_2377(level._id_43FE[var_0][var_2]);
    return;
  }

  _id_2377([]);
}

_id_2380(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::weaponclass(self.weapon);

  if(var_5 == "none") {
    return;
  }
  if(scripts\asm\asm::asm_hasalias(var_1, "aim_1")) {
    return;
  }
  if(!scripts\asm\asm::asm_hasalias(var_1, var_5 + "_aim_8"))
    var_5 = "rifle";

  _id_237D(var_0, var_1);
  var_6 = var_5 + "_aim_5";
  var_7 = undefined;

  if((!isDefined(var_3) || var_3) && scripts\asm\asm::asm_hasalias(var_1, var_6))
    var_7 = _id_235B(var_1, var_5 + "_aim_5");

  self _meth_82A9(_id_235B(var_1, var_5 + "_aim_8"), 1, var_2);
  self _meth_82A9(_id_235B(var_1, var_5 + "_aim_2"), 1, var_2);
  self _meth_82A9(_id_235B(var_1, var_5 + "_aim_4"), 1, var_2);
  self _meth_82A9(_id_235B(var_1, var_5 + "_aim_6"), 1, var_2);

  if(isDefined(var_7))
    self _meth_82AC(var_7, 1, var_2);

  if(scripts\asm\asm::asm_hasalias(var_1, "aim_root"))
    self _meth_82A2(_id_235B(var_1, "aim_root"), 1, var_2);
  else if(scripts\asm\asm::asm_hasalias("Knobs", "aim_root"))
    self _meth_82A2(_id_235B("Knobs", "aim_root"), 1, var_2);

  var_8 = _id_2348(var_1, "aim_knob_2");

  if(var_8) {
    self notify("StopCleanupAimKnobs");
    self.asm._id_11A90._id_1A1D = _id_235B(var_1, "aim_knob_2");
    self.asm._id_11A90._id_1A1F = _id_235B(var_1, "aim_knob_4");
    self.asm._id_11A90._id_1A22 = _id_235B(var_1, "aim_knob_6");
    self.asm._id_11A90._id_1A24 = _id_235B(var_1, "aim_knob_8");

    if(isDefined(var_7))
      self.asm._id_11A90._id_1A21 = _id_235B(var_1, "aim_knob_5");

    thread _id_2312(var_1);
  }

  _id_0A2B::_id_11AFD();
}

_id_2381(var_0, var_1) {
  var_2 = scripts\asm\asm::asm_getdemeanor();
  self.asm._id_77C1._id_77A6 = _id_235B("gesture", "gesture_move_up");
  self.asm._id_77C1._id_778C = _id_235B("gesture", "gesture_armup");
  self.asm._id_77C1._id_77A8 = _id_235B("gesture", "gesture_on_me");
  self.asm._id_77C1._id_77A0 = _id_235B("gesture", "gesture_hold");
  self.asm._id_77C1._id_7795 = _id_235B("gesture", "gesture_fallback_up");
  self.asm._id_77C1._id_7794 = _id_235B("gesture", "gesture_fallback_down");

  if(var_2 == "casual") {
    self.asm._id_77C1._id_77AA = _id_235B("gesture_point", "gesture_point_center");
    self.asm._id_77C1._id_77AC = _id_235B("gesture_point", "gesture_point_left");
    self.asm._id_77C1._id_77AE = _id_235B("gesture_point", "gesture_point_right");
    self.asm._id_77C1._id_77AF = _id_235B("gesture_point", "gesture_point_up");
    self.asm._id_77C1._id_77AB = _id_235B("gesture_point", "gesture_point_down");
    self.asm._id_77C1._id_77B6 = _id_235B("gesture", "gesture_shrug_anim");
    self.asm._id_77C1._id_778F = _id_235B("gesture", "gesture_cross_anim");
    self.asm._id_77C1._id_77A7 = _id_235B("gesture", "gesture_nod_anim");
    self.asm._id_77C1._id_77B5 = _id_235B("gesture", "gesture_shake_head_anim");
    self.asm._id_77C1._id_77B4 = _id_235B("gesture", "gesture_salute_anim");
    self.asm._id_77C1._id_77BF = _id_235B("gesture", "gesture_wave_anim");
    self.asm._id_77C1._id_77BE = _id_235B("gesture", "gesture_wait_anim");
  } else if(var_2 == "casual_gun") {
    self.asm._id_77C1._id_77AA = _id_235B("gesture_point", "gesture_casual_gun_point_center");
    self.asm._id_77C1._id_77AC = _id_235B("gesture_point", "gesture_casual_gun_point_left");
    self.asm._id_77C1._id_77AE = _id_235B("gesture_point", "gesture_casual_gun_point_right");
    self.asm._id_77C1._id_77AF = _id_235B("gesture_point", "gesture_casual_gun_point_up");
    self.asm._id_77C1._id_77AB = _id_235B("gesture_point", "gesture_casual_gun_point_down");
    self.asm._id_77C1._id_77B6 = _id_235B("gesture", "gesture_gun_shrug_anim");
    self.asm._id_77C1._id_778F = _id_235B("gesture", "gesture_gun_cross_anim");
    self.asm._id_77C1._id_77A7 = _id_235B("gesture", "gesture_gun_nod_anim");
    self.asm._id_77C1._id_77B5 = _id_235B("gesture", "gesture_gun_shake_head_anim");
    self.asm._id_77C1._id_77B4 = _id_235B("gesture", "gesture_gun_salute_anim");
    self.asm._id_77C1._id_77BF = _id_235B("gesture", "gesture_gun_wave_anim");
    self.asm._id_77C1._id_77BE = _id_235B("gesture", "gesture_gun_wait_anim");
  } else {
    self.asm._id_77C1._id_77AA = _id_235B("gesture_point", "gesture_gun_point_center");
    self.asm._id_77C1._id_77AC = _id_235B("gesture_point", "gesture_gun_point_left");
    self.asm._id_77C1._id_77AE = _id_235B("gesture_point", "gesture_gun_point_right");
    self.asm._id_77C1._id_77AF = _id_235B("gesture_point", "gesture_gun_point_up");
    self.asm._id_77C1._id_77AB = _id_235B("gesture_point", "gesture_gun_point_down");
    self.asm._id_77C1._id_77B6 = _id_235B("gesture", "gesture_gun_shrug_anim");
    self.asm._id_77C1._id_778F = _id_235B("gesture", "gesture_gun_cross_anim");
    self.asm._id_77C1._id_77A7 = _id_235B("gesture", "gesture_gun_nod_anim");
    self.asm._id_77C1._id_77B5 = _id_235B("gesture", "gesture_gun_shake_head_anim");
    self.asm._id_77C1._id_77B4 = _id_235B("gesture", "gesture_gun_salute_anim");
    self.asm._id_77C1._id_77BF = _id_235B("gesture", "gesture_gun_wave_anim");
    self.asm._id_77C1._id_77BE = _id_235B("gesture", "gesture_gun_wait_anim");
  }
}

_id_2313(var_0, var_1) {
  self endon("death");
  self endon("StopCleanupAimKnobs");
  scripts\engine\utility::waittill_any_timeout(var_1, var_0 + "_finished");
  _id_2311();
}

_id_2312(var_0) {
  self endon("death");
  self endon("StopCleanupAimKnobs");
  self waittill(var_0 + "_finished");
  _id_2311();
}

_id_2311() {
  if(!isDefined(self.asm._id_11A90)) {
    return;
  }
  self.asm._id_11A90._id_1A1D = undefined;
  self.asm._id_11A90._id_1A1F = undefined;
  self.asm._id_11A90._id_1A22 = undefined;
  self.asm._id_11A90._id_1A24 = undefined;
  self.asm._id_11A90._id_1A21 = undefined;
}

_id_238E(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 0;

  while(!var_3) {
    self waittill(var_1, var_4);

    if(!isarray(var_4))
      var_4 = [var_4];

    foreach(var_6 in var_4) {
      if(var_6 == "start_aim") {
        _id_2380(var_0, var_1, var_2);
        var_3 = 1;
        break;
      }
    }
  }
}

_id_230A(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self.asmname;
  var_8 = self._id_164D[var_7]._id_4BC0;
  var_9 = anim.asm[var_7].states[var_8];
  scripts\asm\asm::_id_2388(var_7, var_8, var_9, var_9._id_116FB);
  scripts\asm\asm::_id_238A(var_7, "AnimScripted", 0.2);
}

_id_2386() {
  self _meth_83A1();
}

_id_2307(var_0, var_1) {
  if(getdvarint("ai_iw7", 0) == 0) {
    if(!isDefined(var_1))
      self animcustom(var_0);
    else
      self animcustom(var_0, var_1);

    return;
  }

  scripts\asm\asm_bb::bb_setanimScripted();
  self.asm._id_1FAC = var_1;
  self animcustom(var_0, ::_id_2308);
  var_2 = self.asmname;
  var_3 = self._id_164D[var_2]._id_4BC0;
  var_4 = anim.asm[var_2].states[var_3];
  scripts\asm\asm::_id_2388(var_2, var_3, var_4, var_4._id_116FB);
  scripts\asm\asm::_id_238A(var_2, "AnimScripted", 0.2);
}

_id_2308() {
  scripts\asm\asm_bb::bb_clearanimScripted();

  if(!isDefined(self.asm._id_1FAC)) {
    return;
  }
  self[[self.asm._id_1FAC]]();
  self.asm._id_1FAC = undefined;
}

_id_2385() {
  self notify("killanimscript");
}

_id_230F(var_0) {
  if(isDefined(var_0._id_C704))
    _id_237F(var_0._id_C704);

  if(isDefined(var_0._id_1FBA))
    _id_237E(var_0._id_1FBA);
}

_id_9F70(var_0, var_1, var_2, var_3) {
  if(isDefined(self.damageweapon)) {
    if(self.damageweapon == "none")
      return 0;

    if(scripts\sp\utility::_id_9DB4("emp"))
      return 1;

    if(scripts\sp\utility::_id_9DB4("iw7_sonic"))
      return 1;

    if(_id_FFBD())
      return 1;
  }

  return 0;
}

_id_9F4C(var_0, var_1, var_2, var_3) {
  if(isDefined(self.damagemod) && self.damagemod == "MOD_IMPACT")
    return 0;

  if(scripts\sp\utility::_id_9DB4("emp"))
    return 1;

  if(self.unittype == "c6" || self.unittype == "c8") {
    if(scripts\sp\utility::_id_9DB4("iw7_sonic") && scripts\sp\utility::_id_9FFE(self.damageweapon))
      return 1;
  }

  if(scripts\sp\utility::_id_9DB4("iw7_atomizer") && self.damagemod != "MOD_MELEE" && self.health <= 0)
    return 1;

  return 0;
}

_id_D521() {
  if(scripts\sp\utility::_id_9DB4("iw7_sonic") && scripts\sp\utility::_id_9FFE(self.damageweapon)) {
    playFXOnTag(level._id_7649["soldier_shock"], self, "j_knee_ri");
    playFXOnTag(level._id_7649["soldier_shock"], self, "j_shoulder_ri");
  }
}

_id_9DB5(var_0, var_1, var_2, var_3) {
  var_4 = self.damagetaken;

  if(isDefined(self._id_C873))
    var_4 = self._id_C873;

  if(scripts\sp\utility::_id_9DB4("iw7_sonic") && self.damagemod != "MOD_MELEE" && var_4 >= 75)
    return 1;

  return 0;
}

_id_FFBD() {
  if(self.damagemod == "MOD_MELEE")
    return 0;

  if(!isDefined(self.damageweapon))
    return 0;

  if(self.damageweapon == "none")
    return 0;

  var_0 = getweaponbasename(self.damageweapon);

  if(!isDefined(var_0))
    return 0;

  if(isDefined(self.lastattacker) && isDefined(self.lastattacker.team) && isDefined(self.team) && self.lastattacker.team == self.team)
    return 0;

  return var_0 == "iw7_atomizer";
}

_id_7E5A() {
  var_0 = -1 * self.damagedir;
  var_1 = anglesToForward(self.angles);
  var_2 = vectordot(var_1, var_0);

  if(var_2 > 0.707)
    return "front";
  else if(var_2 < -0.707)
    return "back";
  else {
    var_3 = vectorcross(var_1, var_0);

    if(var_3[2] > 0)
      return "left";
    else
      return "right";
  }
}

_id_7F08() {
  var_0 = -1 * self.damagedir;
  var_1 = anglesToForward(self.angles);
  var_2 = vectordot(var_1, var_0);

  if(var_2 < -0.5)
    return 1;

  return 0;
}