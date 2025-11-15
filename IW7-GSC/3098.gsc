/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3098.gsc
***************************************/

func_25C5() {
  if(!isDefined(self.audio))
    self.audio = spawnStruct();
}

func_A3B3(var_00) {
  if(!isDefined(var_00))
    var_00 = self.spaceship_mode;

  func_A3B6(var_00, 0);
}

func_A3B6(var_00, var_01) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(isDefined(self.func_615D) && self.func_615D.func_619D) {
    return;
  }
  if(isDefined(self.audio.state) && self.audio.state == var_00) {
    return;
  }
  if(isDefined(self.audio.func_552E))
    self thread[[self.audio.func_552E]]();

  self.audio.func_552E = undefined;

  switch (var_00) {
    case "hover":
      func_2396(var_01);
      break;
    case "fly":
      func_11130(var_01);
      break;
    case "fly_glide":
      func_11134(var_01);
      break;
    case "hover_glide":
      func_11134(var_01);
      break;
    case "reentry":
      func_11134(var_01);
      break;
    case "launch_mode":
      func_AA5D(var_01);
      break;
    case "boost_mode":
      func_2CAB(var_01);
      break;
    case "landed_mode":
      func_A7CA(var_01);
      break;
    default:
  }

  self.audio.state = var_00;
}

func_2396(var_00) {
  if(soundexists("jackal_tread_sfx_lp")) {
    if(!isDefined(self.func_A381))
      thread func_A381();
  }

  if(!isDefined(self.func_23A5)) {
    self.audio.func_23A5 = func_31C0();
    self.audio.func_23A5 thread scripts\sp\utility::func_10461(func_0BDC::func_7A5B("jackal_hover_world"), 1, var_00, 1);
    self.audio.func_552E = ::func_2395;
  }
}

func_2395() {
  var_00 = 1;
  var_01 = self.audio.func_23A5;
  var_01 ghostattack(0, var_00);
  wait(var_00);
  func_DFD8([var_01]);
}

func_11130(var_00) {
  if(!isDefined(self.audio.func_1113C)) {
    self.audio.func_1113C = func_31C0();
    var_01 = self.script_team;

    if(var_01 == "axis")
      self.audio.func_1113C thread scripts\sp\utility::func_10461(func_0BDC::func_7A5B("jackal_sdf_thrust_world"), 1, var_00, 1);
    else
      self.audio.func_1113C thread scripts\sp\utility::func_10461(func_0BDC::func_7A5B("jackal_thrust_world"), 1, var_00, 1);

    self.audio.func_1113C thread scripts\sp\utility::func_10461(func_0BDC::func_7A5B("jackal_thrust_world"), 1, var_00, 1);
    thread func_A1D5("jackal_flyby", undefined, 1);
    self.audio.func_552E = ::func_1112F;
  }
}

func_11134(var_00) {
  self.audio.func_552E = ::func_11133;
}

func_239D(var_00) {
  self.audio.func_552E = ::func_239C;
}

func_11133() {}

func_239C() {}

func_AA5D(var_00) {
  self.audio.func_552E = ::func_AA5C;
}

func_AA5C() {}

func_2CAB(var_00) {
  if(!isDefined(self.audio.func_2CB5)) {
    self.audio.func_2CB5 = func_31C0();
    self.audio.func_2CB5 thread scripts\sp\utility::func_10461(func_0BDC::func_7A5B("jackal_npc_boost_lp"), 1, var_00, 1);
    _playworldsound(func_0BDC::func_7A5B("jackal_npc_boost_init"), self.origin);
    self.audio.func_552E = ::func_2CAA;
  }
}

func_2CAA() {}

func_A7CA(var_00) {
  self.audio.func_552E = ::func_A7C9;
}

func_A7C9() {}

func_1112F() {
  var_00 = 1;
  self notify("notify_stop_thrust_audio");
  var_01 = self.audio.func_1113C;
  var_01 ghostattack(0, var_00);
  wait(var_00);
  func_DFD8([var_01]);
}

func_31C0() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 linkto(self, "j_mainroot_ship", (0, 0, 0), (0, 0, 0));
  self.func_4074[self.func_4074.size] = var_00;
  return var_00;
}

func_DFD8(var_00) {
  foreach(var_02 in var_00) {
    if(isDefined(var_02)) {
      self.func_4074 = scripts\engine\utility::array_remove(self.func_4074, var_02);
      var_02 delete();
    }
  }
}

func_A1D5(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  self endon("death");
  self endon("deathspin");
  self endon("entitydeleted");
  self endon("notify_stop_thrust_audio");
  self endon("terminate_ai_threads");
  var_08 = [];
  var_8[0] = 3000;
  var_8[1] = 6000;
  var_8[2] = 10000;
  var_09 = [];
  var_9[0] = 320;
  var_9[1] = 230;
  self _meth_83E8();
  self.audio.func_D889 = func_A16A(var_02);
  self.audio.func_7008 = 0;
  self.audio.func_7007 = 0;
  self.audio.func_4E1F = 0;
  self.audio.func_20EF = 1;

  if(isDefined(var_03))
    thread func_A13F(var_03);

  if(isDefined(var_04)) {
    var_10 = spawn("script_origin", self.origin);
    var_10 linkto(self);
    self.func_4074[self.func_4074.size] = var_10;
    thread func_A1D3(var_10, var_04);
  }

  self.audio.func_B746 = 2;

  if(isDefined(var_05))
    self.audio.func_B746 = var_05;

  self.audio.func_B745 = 2;

  if(isDefined(var_06))
    self.audio.func_B745 = var_06;

  var_11 = 0.05;

  if(isDefined(var_07))
    var_11 = var_07;

  if(isarray(var_01)) {
    foreach(var_14, var_13 in var_01)
    thread func_A1D7(var_14, var_13);
  }

  if(isarray(var_08)) {
    while(isDefined(self)) {
      var_15 = func_A16A(var_02);

      for(var_16 = 0; var_16 < var_8.size; var_16++) {
        if(var_15 < var_8[var_16]) {
          if(var_16 == 0) {
            if(self.audio.func_20EF && self.audio.func_7008 == 0 && self.audio.func_4E1F == 0) {
              var_17 = func_A1D1(var_00, var_16, var_09);

              if(isDefined(var_17))
                thread func_A1D4(var_17, var_16);
            } else if(var_15 < self.audio.func_D889)
              self.audio.func_20EF = 1;
            else
              self.audio.func_20EF = 0;
          } else if(var_15 > self.audio.func_D889) {
            if(self.audio.func_20EF && self.audio.func_7008 == 0 && self.audio.func_7007 == 0 && self.audio.func_4E1F == 0) {
              self.audio.func_20EF = 0;
              var_17 = func_A1D1(var_00, var_16, var_09);

              if(isDefined(var_17))
                thread func_A1D4(var_17, var_16);
            }
          } else if(var_15 < 3500) {
            if(self.audio.func_7008 == 0 && self.audio.func_7007 == 0 && self.audio.func_4E1F == 0) {
              var_17 = func_A1D1(var_00, var_16, var_09);

              if(isDefined(var_17))
                thread func_A1D4(var_17, var_16);
            }
          } else
            self.audio.func_20EF = 1;

          break;
        }
      }

      self.audio.func_D889 = var_15;
      wait(var_11);
    }
  }
}

func_A1D7(var_00, var_01) {
  self endon("death");
  self endon("deathspin");
  self endon("entitydeleted");
  wait(var_01);
  thread func_A1D4(var_00);
}

func_A16A(var_00) {
  var_01 = func_7BA7();
  var_02 = 0;

  if(isDefined(var_00))
    var_02 = var_00;

  if(var_02)
    var_03 = distance(self.origin, var_01);
  else
    var_03 = distance2d(self.origin, var_01);

  return var_03;
}

func_A1D1(var_00, var_01, var_02) {
  var_03 = 0;
  var_04 = self vehicle_getvelocity();
  var_05 = length(var_04) * 0.0568182;

  if(var_05 > 125) {
    if(isarray(var_02)) {
      if(scripts\engine\utility::player_is_in_jackal())
        var_06 = level.func_D127.spaceship_vel * 17.6;
      else
        var_06 = level.player getvelocity();

      var_07 = var_04 - var_06;
      var_08 = length(var_07) * 0.0568182;

      if(var_08 < 125)
        return undefined;

      for(var_09 = 0; var_09 < var_2.size; var_9++) {
        var_03 = var_09 + 1;

        if(var_08 > var_2[var_09]) {
          var_03 = var_09;
          break;
        }
      }
    }

    if(var_03 == 0)
      var_10 = "fast";
    else if(var_03 == 1)
      var_10 = "med";
    else
      var_10 = "slow";

    if(var_01 == 0)
      var_11 = "close";
    else if(var_01 == 1)
      var_11 = "mid";
    else if(var_01 == 2)
      var_11 = "far";
    else
      return undefined;

    var_12 = self.script_team;

    if(var_12 == "axis")
      var_00 = var_00 + "_sdf";

    if(scripts\engine\utility::player_is_in_jackal())
      var_13 = var_00 + "_" + var_10 + "_" + var_11;
    else
      var_13 = var_00 + "_" + var_10 + "_" + var_11 + "_grnd";

    if(var_01 == 0)
      self.audio.func_7008 = 1;
    else
      self.audio.func_7007 = 1;

    return var_13;
  } else
    return undefined;
}

func_A1D4(var_00, var_01) {
  self endon("death");
  self endon("deathspin");
  self endon("entitydeleted");
  thread func_A331(var_01);
  self.audio.func_1113C ghostattack(0.4, 1);
  self playSound(var_00);
  wait 1;

  if(isDefined(self.audio.func_1113C))
    self.audio.func_1113C ghostattack(1, 5);
}

func_A13F(var_00) {
  self endon("crash_done");
  self waittill("deathspin");
  self playSound(var_00);
}

func_A1D3(var_00, var_01) {
  self waittill("crash_done");
  var_00 playSound(var_01, "sounddone");
  var_00 waittill("sounddone");
  var_00 delete();
}

func_A331(var_00) {
  self endon("death");
  self endon("deathspin");
  self endon("entitydeleted");
  self endon("notify_stop_thrust_audio");

  if(isDefined(var_00)) {
    if(var_00 == 0) {
      wait(self.audio.func_B746);

      if(isDefined(self))
        self.audio.func_7008 = 0;
    } else {
      wait(self.audio.func_B745);

      if(isDefined(self))
        self.audio.func_7007 = 0;
    }
  }
}

func_A381() {
  self endon("death");
  self endon("entitydeleted");
  thread func_A380();
  var_00 = 0.3;
  var_01 = 0.3;
  var_02 = 500;

  for(;;) {
    var_03 = (0, 0, -100000);
    var_04 = scripts\sp\utility::func_864C(self.origin);
    var_05 = distance(self.origin, var_04);

    if(var_05 < var_02) {
      if(isDefined(self) && !isDefined(self.func_A381)) {
        self.func_A381 = spawn("script_origin", var_04);
        wait 0.05;

        if(isDefined(self) && isDefined(self.func_A381))
          self.func_A381 scripts\sp\utility::func_10461("jackal_tread_sfx_lp", var_00, 1, 1);

        wait 1;
      }

      if(isDefined(self) && isDefined(self.func_A381)) {
        var_04 = scripts\sp\utility::func_864C(self.origin);
        var_05 = distance(self.origin, var_04);
        var_01 = (var_05 - var_02) / (0 - var_02);

        if(var_01 < var_00)
          var_01 = var_00;

        self.func_A381 ghostattack(var_01, 0.1);
        self.func_A381 moveto(var_04, 0.1);
        wait 0.2;
      }
    } else if(var_05 > var_02) {
      if(isDefined(self) && isDefined(self.func_A381)) {
        self.func_A381 ghostattack(0, 2);
        wait 2;

        if(isDefined(self) && isDefined(self.func_A381))
          self.func_A381 delete();
      }
    }

    wait 0.2;
  }
}

func_A380() {
  self waittill("death");

  if(isDefined(self.func_A381))
    self.func_A381 delete();
}

func_A1D0(var_00, var_01, var_02) {
  self waittill(var_01);

  if(isDefined(var_00)) {
    var_03 = 0.3;

    if(isDefined(var_02))
      var_03 = var_02;

    var_00 ghostattack(0.0, var_03);
    wait(var_03);

    if(isDefined(var_00)) {
      var_00 stopsounds();
      wait 0.1;

      if(isDefined(var_00))
        var_00 delete();
    }
  }
}

func_7BA7() {
  if(scripts\engine\utility::player_is_in_jackal())
    return level.func_D127.origin;
  else
    return level.player.origin;
}