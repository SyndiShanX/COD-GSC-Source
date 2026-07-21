/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\sp\script_funcs.gsc
***********************************************/

forwardpushevent(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_geteventdata(var_0, "player_pushed");
  scripts\asm\asm::asm_fireephemeralevent("player_pushed", "player_pushed", var_4);
}

shouldplaypushedanim(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::asm_eventfired(var_0, "player_pushed")) {
    var_4 = scripts\asm\asm::asm_geteventdata(var_0, "player_pushed");
    var_5 = vectorNormalize(var_4);
    var_6 = navtrace(self.origin, self.origin + 4 * var_4, self, 1);

    if(var_6["fraction"] >= 0.99 || vectordot(var_5, var_6["normal"]) >= -0.866)
      return 1;
  }

  return 0;
}

playanim_pushed(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");

  if(isDefined(var_4)) {
    var_5 = vectortoyaw(-1 * var_4);
    self orientmode("face angle", var_5);
  }

  scripts\asm\shared\utility::playanim(var_0, var_1, var_2);
}

playanim_opendoor(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 1;
  var_4 = 24;
  var_5 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_6 = scripts\asm\asm::asm_getxanim(var_1, var_5);
  self aisetanim(var_1, var_5);
  var_7 = self._blackboard.doortoopen;
  var_8 = getnotetracktimes(var_6, "arrival");
  var_9 = getmovedelta(var_6, 0, var_8[0]);
  var_10 = (var_3 + var_4, 0, 0) + var_9;
  var_11 = anglestoleft(var_7.true_start_angles);

  if(var_7 scripts\sp\door::should_open_left())
    var_11 = var_11 * -1;

  var_12 = getdoorcenter(var_7);
  var_13 = vectortoangles(var_11);
  var_14 = var_12 + rotatevector(var_10, var_13);
  var_15 = (0, angleclamp180(var_13[1] - 180), 0);
  var_16 = 300;
  self startcoverarrival();
  self motionwarp(var_14, var_15, var_16);
  self notify("opening_door");
  scripts\asm\asm::asm_donotetracks(var_0, var_1, ::opendoor_notehandler);
}

opendoor_notehandler(var_0) {
  if(var_0 == "open") {
    if(isDefined(self._blackboard.dooropenfunc) && isDefined(self._blackboard.doortoopen))
      self._blackboard.doortoopen thread[[self._blackboard.dooropenfunc]](self, scripts\asm\shared\utility::calcdooropenspeed());
  }
}

getdoorcenter(var_0) {
  return var_0.origin + rotatevector((var_0.length * 0.5, 0, 0), var_0.true_start_angles);
}

shouldopendoor(var_0, var_1, var_2, var_3) {
  return 0;
}

getstrafeanimweights(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < 9; var_2++)
    var_1[var_2] = 0;

  var_3 = [-180, -135, -90, -45, 0, 45, 90, 135, 180];

  for(var_2 = 0; var_0 >= var_3[var_2]; var_2++) {}

  var_4 = var_2 - 1;
  var_5 = var_2;
  var_6 = (var_0 - var_3[var_4]) / (var_3[var_5] - var_3[var_4]);
  var_7 = 1 - var_6;
  var_1[var_4] = var_7;
  var_1[var_5] = var_6;

  if(var_1[0] > var_1[8])
    var_1[8] = var_1[0];
  else
    var_1[0] = var_1[8];

  return var_1;
}

initmovestrafeloopnew(var_0, var_1, var_2) {
  var_3 = 1.0;

  if(isDefined(var_2))
    var_3 = var_2;
}

movestrafeloopnew(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 0.2;
  var_4 = 1.0;

  if(isDefined(var_2))
    var_4 = var_2;

  var_5 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self.strafeangle = 0;
  var_6 = self getmotionangle();
  var_7 = 0;

  for(;;) {
    if(length(self.velocity) > 1.0)
      var_6 = self getmotionangle();

    wait 0.05;
    self.strafeangle = var_6;
    wait 0.02;
    var_8 = getstrafeanimweights(self.strafeangle);

    if(!var_7) {
      var_9 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "blank");
      self aisetanim(var_1, var_9);
      var_10 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "f_knob");
      self setanim(scripts\asm\asm::asm_getxanim(var_1, var_10), 1, var_3, 1);
      var_7 = 1;
    }

    for(var_11 = 0; var_11 < var_8.size; var_11++) {
      if(isDefined(var_5[var_11]))
        self setanimlimited(scripts\asm\asm::asm_getxanim(var_1, var_5[var_11]), var_8[var_11], 0.1, var_4, 1);
    }

    wait 0.1;
  }
}

playmovestrafeloopnew(var_0, var_1, var_2) {
  initmovestrafeloopnew(var_0, var_1, var_2);
  thread movestrafeloopnew(var_0, var_1, var_2);
}

playmovestrafeloop(var_0, var_1, var_2) {
  initmovestrafeloop(var_0, var_1, var_2);
  thread movestrafeloop(var_0, var_1, var_2);
}

initmovestrafeloop(var_0, var_1, var_2) {
  var_3 = 1.0;

  if(isDefined(var_2) && scripts\asm\asm::asm_getdemeanor() != "frantic")
    var_3 = var_2;

  var_4 = scripts\asm\asm::asm_getxanim(var_1, scripts\asm\asm::asm_lookupanimfromalias(var_1, "f"));
  var_5 = scripts\asm\asm::asm_getxanim(var_1, scripts\asm\asm::asm_lookupanimfromalias(var_1, "l"));
  var_6 = scripts\asm\asm::asm_getxanim(var_1, scripts\asm\asm::asm_lookupanimfromalias(var_1, "r"));
  var_7 = scripts\asm\asm::asm_getxanim(var_1, scripts\asm\asm::asm_lookupanimfromalias(var_1, "b"));
  self aisetanimknoblimited(var_4, 1, 0.1, var_3, 1);
  self aisetanimknoblimited(var_7, 1, 0.1, var_3, 1);
  self aisetanimknoblimited(var_6, 1, 0.1, var_3, 1);
  self aisetanimknoblimited(var_5, 1, 0.1, var_3, 1);
}

movestrafeloop(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = 1.0;

  if(isDefined(var_2))
    var_3 = var_2;

  self codemoveanimrate(var_3);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, scripts\asm\asm::asm_lookupanimfromalias(var_1, "f_knob"));
  var_5 = scripts\asm\asm::asm_getxanim(var_1, scripts\asm\asm::asm_lookupanimfromalias(var_1, "l_knob"));
  var_6 = scripts\asm\asm::asm_getxanim(var_1, scripts\asm\asm::asm_lookupanimfromalias(var_1, "r_knob"));
  var_7 = scripts\asm\asm::asm_getxanim(var_1, scripts\asm\asm::asm_lookupanimfromalias(var_1, "b_knob"));

  for(;;) {
    var_8 = scripts\anim\utility_common.gsc::quadrantanimweights(self getmotionangle());
    self setanim(var_4, var_8["front"], 0.2, 1.0, 1);
    self setanim(var_7, var_8["back"], 0.2, 1.0, 1);
    self setanim(var_5, var_8["left"], 0.2, 1.0, 1);
    self setanim(var_6, var_8["right"], 0.2, 1.0, 1);
    wait 0.05;
    waittillframeend;
  }
}