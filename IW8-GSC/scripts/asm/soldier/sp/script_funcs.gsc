/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\sp\script_funcs.gsc
***************************************************/

function forwardpushevent(var0, var1, var2, var3) {
  var4 = scripts\asm\asm::asm_geteventdata(var0, "player_pushed");
  scripts\asm\asm::asm_fireephemeralevent("player_pushed", "player_pushed", var4);
}

function shouldplaypushedanim(var0, var1, var2, var3) {
  if(scripts\asm\asm::asm_eventfired(var0, "player_pushed")) {
    var4 = scripts\asm\asm::asm_geteventdata(var0, "player_pushed");
    var5 = vectorNormalize(var4);
    var6 = navtrace(self.origin, self.origin + 4 * var4, self, 1);

    if(var6["fraction"] >= 0.99 || vectordot(var5, var6["normal"]) >= -0.866) {
      return true;
    }
  }

  return false;
}

function playanim_pushed(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");

  if(isDefined(var4)) {
    var5 = vectortoyaw(-1 * var4);
    self orientmode("face angle", var5);
  }

  scripts\asm\shared\utility::playanim(var0, var1, var2);
}

function playanim_opendoor(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = 1;
  var4 = 24;
  var5 = scripts\asm\asm::asm_getanim(var0, var1);
  var6 = scripts\asm\asm::asm_getxanim(var1, var5);
  self aisetanim(var1, var5);
  var7 = self._blackboard.doortoopen;
  var8 = getnotetracktimes(var6, "arrival");
  var9 = getmovedelta(var6, 0, var8[0]);
  var10 = (var3 + var4, 0, 0) + var9;
  var11 = anglestoleft(var7.true_start_angles);

  if(var7 scripts\sp\door::should_open_left()) {
    var11 *= -1;
  }

  var12 = getdoorcenter(var7);
  var13 = vectortoangles(var11);
  var14 = var12 + rotatevector(var10, var13);
  var15 = (0, angleclamp180(var13[1] - 180), 0);
  var16 = 300;
  self startcoverarrival();
  self motionwarp(var14, var15, var16);
  self notify("opening_door");
  scripts\asm\asm::asm_donotetracks(var0, var1, &opendoor_notehandler);
}

function opendoor_notehandler(var0) {
  if(var0 == "open") {
    if(isDefined(self._blackboard.dooropenfunc) && isDefined(self._blackboard.doortoopen)) {
      self._blackboard.doortoopen thread[[self._blackboard.dooropenfunc]](self, scripts\asm\shared\utility::calcdooropenspeed());
      return;
    }

    return;
  }
}

function getdoorcenter(var0) {
  return var0.origin + rotatevector((var0.length * 0.5, 0, 0), var0.true_start_angles);
}

function shouldopendoor(var0, var1, var2, var3) {
  return false;
}

function getstrafeanimweights(var0) {
  var1 = [];

  for(var2 = 0; var2 < 9; var2++) {
    var1 = 0;
  }

  var3 = [-180, -135, -90, -45, 0, 45, 90, 135, 180];

  for(var2 = 0; var0 >= var3[var2]; var2++) {}

  var4 = var2 - 1;
  var5 = var2;
  var6 = (var0 - var3[var4]) / (var3[var5] - var3[var4]);
  var7 = 1 - var6;
  var1 = var7;
  var1 = var6;

  if(var1[0] > var1[8]) {
    var1 = var1[0];
  } else {
    var1 = var1[8];
  }

  return var1;
}

function initmovestrafeloopnew(var0, var1, var2) {
  var3 = 1;

  if(isDefined(var2)) {
    var3 = var2;
    return;
  }
}

function movestrafeloopnew(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = 0.2;
  var4 = 1;

  if(isDefined(var2)) {
    var4 = var2;
  }

  var5 = scripts\asm\asm::asm_getanim(var0, var1);
  self.strafeangle = 0;
  var6 = self getmotionangle();
  var7 = 0;

  for(;;) {
    if(length(self.velocity) > 1) {
      var6 = self getmotionangle();
    }

    wait 0.05;
    self.strafeangle = var6;
    wait 0.02;
    var8 = getstrafeanimweights(self.strafeangle);

    if(!var7) {
      var9 = scripts\asm\asm::asm_lookupanimfromalias(var1, "blank");
      self aisetanim(var1, var9);
      var10 = scripts\asm\asm::asm_lookupanimfromalias(var1, "f_knob");
      self setanim(scripts\asm\asm::asm_getxanim(var1, var10), 1, var3, 1);
      var7 = 1;
    }

    for(var11 = 0; var11 < var8.size; var11++) {
      if(isDefined(var5[var11])) {
        self setanimlimited(scripts\asm\asm::asm_getxanim(var1, var5[var11]), var8[var11], 0.1, var4, 1);
      }
    }

    wait 0.1;
  }
}

function playmovestrafeloopnew(var0, var1, var2) {
  initmovestrafeloopnew(var0, var1, var2);
  thread movestrafeloopnew(var0, var1, var2);
}

function playmovestrafeloop(var0, var1, var2) {
  initmovestrafeloop(var0, var1, var2);
  thread movestrafeloop(var0, var1, var2);
}

function initmovestrafeloop(var0, var1, var2) {
  var3 = 1;

  if(isDefined(var2) && scripts\asm\asm::asm_getdemeanor() != "frantic") {
    var3 = var2;
  }

  var4 = scripts\asm\asm::asm_getxanim(var1, scripts\asm\asm::asm_lookupanimfromalias(var1, "f"));
  var5 = scripts\asm\asm::asm_getxanim(var1, scripts\asm\asm::asm_lookupanimfromalias(var1, "l"));
  var6 = scripts\asm\asm::asm_getxanim(var1, scripts\asm\asm::asm_lookupanimfromalias(var1, "r"));
  var7 = scripts\asm\asm::asm_getxanim(var1, scripts\asm\asm::asm_lookupanimfromalias(var1, "b"));
  self aisetanimknoblimited(var4, 1, 0.1, var3, 1);
  self aisetanimknoblimited(var7, 1, 0.1, var3, 1);
  self aisetanimknoblimited(var6, 1, 0.1, var3, 1);
  self aisetanimknoblimited(var5, 1, 0.1, var3, 1);
}

function movestrafeloop(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = 1;

  if(isDefined(var2)) {
    var3 = var2;
  }

  self codemoveanimrate(var3);
  var4 = scripts\asm\asm::asm_getxanim(var1, scripts\asm\asm::asm_lookupanimfromalias(var1, "f_knob"));
  var5 = scripts\asm\asm::asm_getxanim(var1, scripts\asm\asm::asm_lookupanimfromalias(var1, "l_knob"));
  var6 = scripts\asm\asm::asm_getxanim(var1, scripts\asm\asm::asm_lookupanimfromalias(var1, "r_knob"));
  var7 = scripts\asm\asm::asm_getxanim(var1, scripts\asm\asm::asm_lookupanimfromalias(var1, "b_knob"));

  for(;;) {
    var8 = scripts\anim\utility_common::quadrantanimweights(self getmotionangle());
    self setanim(var4, var8["front"], 0.2, 1, 1);
    self setanim(var7, var8["back"], 0.2, 1, 1);
    self setanim(var5, var8["left"], 0.2, 1, 1);
    self setanim(var6, var8["right"], 0.2, 1, 1);
    wait 0.05;
    waittillframeend();
  }
}