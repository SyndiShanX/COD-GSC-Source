/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\utility.gsc
**************************************/

#using_animtree("generic_human");

_id_2479(var_0) {
  self clearanim( % body, 0.3);
  self setanim( % body, 1, 0);

  if(var_0 != "pain" && var_0 != "death") {
    self.a._id_0D19 = "none";

  }
  self._id_247A = 0;
  self.a._id_0CC3 = 1.0;
  self.a._id_0CC5 = 1.0;
  self.a._id_0CC6 = 1.0;
  self.a._id_0CC7 = 0;
  self.a._id_0CC8 = 0;
  _id_0A69();
}

_id_247B() {
  if(isDefined(self._id_247C) && self._id_247C != self.a._id_0D26) {
    if(self.a._id_0D26 == "prone") {
      _id_0F7D(0.5);

    }
    if(self._id_247C == "prone") {
      self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
      _id_10E1(0.5);
      self setanimknoball( % prone_aim_5, % body, 1, 0.1, 1);
    }
  }

  self._id_247C = undefined;
}

_id_0D15(var_0) {
  if(isDefined(self._id_0D0F)) {
    if(var_0 != "pain" && var_0 != "death") {
      self kill(self.origin);

    }
    if(var_0 != "pain") {
      self._id_0D0F = undefined;
      self notify("kill_long_death");
    }
  }

  if(isDefined(self.a._id_0D6A) && var_0 != "death") {
    self kill(self.origin);

  }
  if(isDefined(self.a._id_20AD)) {
    var_1 = self.a._id_20AD;
    self.a._id_20AD = undefined;
    [[var_1]](var_0);
  }

  if(var_0 != "combat" && var_0 != "pain" && var_0 != "death" && _id_0C95()) {
    animscripts\combat::_id_1159( % pistol_stand_switch, 1);

  }
  if(var_0 != "combat" && var_0 != "move" && var_0 != "pain") {
    self.a._id_1111 = undefined;

  }
  if(var_0 != "death") {
    self.a._id_0D55 = 0;

  }
  if(isDefined(self._id_23A0) && (var_0 == "pain" || var_0 == "death" || var_0 == "flashed")) {
    animscripts\combat_utility::_id_23AA();

  }
  self._id_23A0 = undefined;
  animscripts\squadmanager::_id_0A96(var_0);
  self._id_0CAF = undefined;
  self._id_0A9D = 0;
  self._id_0F53 = 0;
  self._id_0CDD = 0;
  self.a._id_0F78 = undefined;
  self.a._id_1019 = gettime();
  self.a._id_0CE2 = 0;

  if(isDefined(self.node) && (self.node.type == "Conceal Prone" || self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand")) {
    self.a._id_0CE2 = 1;

  }
  _id_2479(var_0);
  _id_247B();
}

_id_23F1() {
  if(isDefined(self._id_0FFE) && self._id_0FFE) {
    if(_id_0CEA(self.primaryweapon)) {
      return self.primaryweapon;
    } else if(_id_0CEA(self.secondaryweapon)) {
      return self.secondaryweapon;
    }
  }

  return self.primaryweapon;
}

_id_247D(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0 * 20; var_3++) {
    for(var_4 = 0; var_4 < 10; var_4++) {
      var_5 = (0, randomint(360), 0);
      var_6 = anglesToForward(var_5);
      var_7 = var_6 * var_2;
    }

    wait 0.05;
  }
}

_id_247E() {
  self endon("death");
  self notify("displaceprint");
  self endon("displaceprint");

  for(;;) {
    wait 0.05;
  }
}

_id_0A69() {
  if(self.alertlevelint > 1) {
    return 1;

  }
  if(isDefined(self.enemy)) {
    self.a._id_20A9 = gettime() + anim._id_20CA + randomint(anim._id_20CB);
    return 1;
  }

  return self.a._id_20A9 > gettime();
}

_id_0FB8() {
  if(isDefined(self.enemy)) {
    self.a._id_247F = self.enemy getshootatpos();
    self.a._id_20AA = gettime();
    return self.a._id_247F;
  } else if(isDefined(self.a._id_20AA) && isDefined(self.a._id_247F) && self.a._id_20AA + 3000 < gettime()) {
    return self.a._id_247F;
  } else {
    var_0 = self getshootatpos();
    var_0 = var_0 + (196 * self.lookforward[0], 196 * self.lookforward[1], 196 * self.lookforward[2]);
    return var_0;
  }
}

_id_0F41(var_0) {
  if(!isDefined(self._id_0C96)) {
    if(var_0.type == "Cover Left") {
      return var_0.angles[1] + 90;
    } else if(var_0.type == "Cover Right") {
      return var_0.angles[1] - 90;
    }
  }

  return var_0.angles[1];
}

_id_2480(var_0) {
  if(isDefined(self.node)) {
    var_1 = self.node.angles[1] - _id_101A(var_0);
  } else {
    var_1 = self.angles[1] - _id_101A(var_0);

  }
  var_1 = angleclamp180(var_1);
  return var_1;
}

_id_116D() {
  var_0 = undefined;

  if(isDefined(self.enemy)) {
    var_0 = self.enemy.origin;
  } else {
    if(isDefined(self.node)) {
      var_1 = anglesToForward(self.node.angles);
    } else {
      var_1 = anglesToForward(self.angles);

    }
    var_1 = var_1 * 150;
    var_0 = self.origin + var_1;
  }

  if(isDefined(self.node)) {
    var_2 = self.node.angles[1] - _id_101A(var_0);
  } else {
    var_2 = self.angles[1] - _id_101A(var_0);

  }
  var_2 = angleclamp180(var_2);
  return var_2;
}

_id_113E(var_0) {
  var_1 = self.angles[1] - _id_101A(var_0);
  var_1 = angleclamp180(var_1);
  return var_1;
}

_id_0D5C() {
  var_0 = undefined;

  if(isDefined(self.enemy)) {
    var_0 = self.enemy.origin;
  } else {
    var_1 = anglesToForward(self.angles);
    var_1 = var_1 * 150;
    var_0 = self.origin + var_1;
  }

  var_2 = self.angles[1] - _id_101A(var_0);
  var_2 = angleclamp180(var_2);
  return var_2;
}

_id_101A(var_0) {
  return vectortoyaw(var_0 - self.origin);
}

_id_2481(var_0) {
  var_1 = vectortoangles((var_0[0], var_0[1], 0) - (self.origin[0], self.origin[1], 0));
  return var_1[1];
}

_id_2482() {
  var_0 = self.angles[1] - _id_101A(self.enemy.origin);
  var_0 = angleclamp180(var_0);

  if(var_0 < 0) {
    var_0 = -1 * var_0;

  }
  return var_0;
}

_id_2483() {
  var_0 = self.angles[1] - _id_2481(self.enemy.origin);
  var_0 = angleclamp180(var_0);

  if(var_0 < 0) {
    var_0 = -1 * var_0;

  }
  return var_0;
}

_id_2484(var_0) {
  var_1 = self.angles[1] - _id_101A(var_0);
  var_1 = angleclamp180(var_1);

  if(var_1 < 0) {
    var_1 = -1 * var_1;

  }
  return var_1;
}

_id_2485(var_0) {
  var_1 = self.angles[1] - var_0;
  var_1 = angleclamp180(var_1);

  if(var_1 < 0) {
    var_1 = -1 * var_1;

  }
  return var_1;
}

_id_2486(var_0, var_1) {
  var_2 = vectortoangles(var_0 - var_1);
  return var_2[1];
}

_id_2487(var_0, var_1) {
  var_2 = self gettagangles(var_0)[1] - _id_2486(var_1, self gettagorigin(var_0));
  var_2 = angleclamp180(var_2);
  return var_2;
}

_id_244F(var_0) {
  var_1 = self.angles[1] - _id_101A(var_0);
  var_1 = angleclamp180(var_1);
  return var_1;
}

_id_2488(var_0) {
  var_1 = self gettagangles("TAG_EYE")[1] - _id_101A(var_0);
  var_1 = angleclamp180(var_1);
  return var_1;
}

_id_2489(var_0) {
  if(isDefined(self._id_0CAF)) {
    return self._id_0CAF doesnodeallowstance(var_0);

  }
  return self isstanceallowed(var_0);
}

_id_10AF(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.a._id_0D26;

  }
  switch (var_0) {
    case "stand":
      if(_id_2489("stand")) {
        var_1 = "stand";
      } else if(_id_2489("crouch")) {
        var_1 = "crouch";
      } else if(_id_2489("prone")) {
        var_1 = "prone";
      } else {
        var_1 = "stand";

      }
      break;
    case "crouch":
      if(_id_2489("crouch")) {
        var_1 = "crouch";
      } else if(_id_2489("stand")) {
        var_1 = "stand";
      } else if(_id_2489("prone")) {
        var_1 = "prone";
      } else {
        var_1 = "crouch";

      }
      break;
    case "prone":
      if(_id_2489("prone")) {
        var_1 = "prone";
      } else if(_id_2489("crouch")) {
        var_1 = "crouch";
      } else if(_id_2489("stand")) {
        var_1 = "stand";
      } else {
        var_1 = "prone";

      }
      break;
    default:
      var_1 = "stand";
      break;
  }

  return var_1;
}

_id_0BEE() {
  var_0 = self.node;

  if(isDefined(var_0) && (self nearnode(var_0) || isDefined(self._id_0CAF) && var_0 == self._id_0CAF)) {
    return var_0;

  }
  return undefined;
}

_id_248A() {
  var_0 = _id_0BEE();

  if(isDefined(var_0)) {
    return var_0.type;

  }
  return "none";
}

_id_2472() {
  var_0 = _id_0BEE();

  if(isDefined(var_0)) {
    return var_0.angles[1];

  }
  return self.desiredangle;
}

_id_248B() {
  var_0 = _id_0BEE();

  if(isDefined(var_0)) {
    return anglesToForward(var_0.angles);

  }
  return anglesToForward(self.angles);
}

_id_2473() {
  var_0 = _id_0BEE();

  if(isDefined(var_0)) {
    return var_0.origin;

  }
  return self.origin;
}

_id_0D08(var_0, var_1) {
  var_2 = int(var_0) % var_1;
  var_2 = var_2 + var_1;
  return var_2 % var_1;
}

_id_0D61(var_0) {
  return abs(angleclamp180(var_0));
}

_id_0FFC(var_0) {
  var_1 = cos(var_0);
  var_2 = sin(var_0);
  var_3["front"] = 0;
  var_3["right"] = 0;
  var_3["back"] = 0;
  var_3["left"] = 0;

  if(isDefined(self._id_241B)) {
    var_3["front"] = 1;
    return var_3;
  }

  if(var_1 > 0) {
    if(var_2 > var_1) {
      var_3["left"] = 1;
    } else if(var_2 < -1 * var_1) {
      var_3["right"] = 1;
    } else {
      var_3["front"] = 1;
    }
  } else {
    var_4 = -1 * var_1;

    if(var_2 > var_4) {
      var_3["left"] = 1;
    } else if(var_2 < var_1) {
      var_3["right"] = 1;
    } else {
      var_3["back"] = 1;
    }
  }

  return var_3;
}

_id_243A(var_0) {
  var_0 = angleclamp(var_0);

  if(var_0 < 45 || var_0 > 315) {
    var_1 = "front";
  } else if(var_0 < 135) {
    var_1 = "left";
  } else if(var_0 < 225) {
    var_1 = "back";
  } else {
    var_1 = "right";

  }
  return var_1;
}

_id_248C(var_0, var_1) {
  for(var_2 = var_1.size - 1; var_2 >= 0; var_2--) {
    if(var_0 == var_1[var_2]) {
      return 1;
    }
  }

  return 0;
}

_id_248D(var_0) {
  if(isDefined(var_0)) {
    self setflaggedanimknoballrestart("playAnim", var_0, % root, 1, 0.1, 1);
    var_1 = getanimlength(var_0);
    var_1 = 3 * var_1 + 1;
    thread _id_248E("time is up", "time is up", var_1);
    self waittill("time is up");
    self notify("enddrawstring");
  }
}

_id_248E(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_1);
  wait(var_2);
  self notify(var_0);
}

_id_248F(var_0) {
  self endon("killanimscript");
  self endon("enddrawstring");

  for(;;) {
    wait 0.05;
  }
}

_id_2490(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 20;

  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait 0.05;
  }
}

_id_2491(var_0) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");

  if(!isDefined(self.enemy)) {
    return;
  }
  if(self.enemy.team == "allies") {
    var_1 = (0.4, 0.7, 1);
  } else {
    var_1 = (1, 0.7, 0.4);

  }
  for(;;) {
    wait 0.05;

    if(!isDefined(self.lastenemysightpos)) {
      continue;
    }
  }
}

_id_0F8C() {
  if(isDefined(self.node)) {
    return _id_0F4A() || _id_0F39();
  } else {
    return _id_0CE3() || _id_0CF3();
  }
}

_id_0CEE() {
  return self._id_199F;
}

_id_2492() {
  if(!_id_0F8C()) {
    return;
  }
  self._id_2493 = _id_0CEE();
  self._id_2494 = self.origin;
}

_id_2495() {
  if(!_id_0F8C()) {
    return 0;

  }
  var_0 = self getmuzzlepos();
  var_1 = self getshootatpos() - var_0;

  if(isDefined(self._id_2493) && isDefined(self._id_2494)) {
    if(distance(self.origin, self._id_2494) < 25) {
      return 0;
    }
  }

  self._id_2493 = undefined;
  var_2 = self canshoot(_id_0CEE(), var_1);

  if(!var_2) {
    self._id_2493 = _id_0CEE();
    return 0;
  }

  return 1;
}

_id_2496() {
  wait 5;
  self notify("timeout");
}

_id_2497(var_0, var_1, var_2) {
  self endon("death");
  self notify("stop debug " + var_0);
  self endon("stop debug " + var_0);
  var_3 = spawnStruct();
  var_3 thread _id_2496();
  var_3 endon("timeout");

  if(self.enemy.team == "allies") {
    var_4 = (0.4, 0.7, 1);
  } else {
    var_4 = (1, 0.7, 0.4);

  }
  for(;;) {
    wait 0.05;
  }
}

_id_2498(var_0, var_1) {
  thread _id_2497(var_0, var_1, 2.15);
}

_id_2499(var_0, var_1, var_2) {
  thread _id_2497(var_0, var_1, var_2);
}

_id_249A(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_3 = undefined;

  if(var_0 == self._id_0CD1) {
    var_3 = "all rounds";
  } else if(var_2 < 0.25) {
    var_3 = "small burst";
  } else if(var_2 < 0.5) {
    var_3 = "med burst";
  } else {
    var_3 = "long burst";

  }
  thread _id_2499(self.origin + (0, 0, 42), var_3, 1.5);
  thread _id_2498(self.origin + (0, 0, 60), "Suppressing");
}

_id_249B() {
  self endon("death");
  self notify("stop shoot " + self.export);
  self endon("stop shoot " + self.export);
  var_0 = 0.25;
  var_1 = var_0 * 20;

  for(var_2 = 0; var_2 < var_1; var_2 = var_2 + 1) {
    wait 0.05;
  }
}

_id_249C() {}

_id_249D(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = var_3 * 20;

  for(var_5 = 0; var_5 < var_4; var_5 = var_5 + 1) {
    wait 0.05;
  }
}

_id_249E(var_0, var_1, var_2, var_3) {
  thread _id_249D(var_0, var_1 + (0, 0, -5), var_2, var_3);
}

_id_0D5F() {
  [[anim._id_20D4]]();
}

_id_249F() {
  self.a._id_0AA7 = gettime();
  maps\_gameskill::_id_2310();
  self notify("shooting");
  self shoot();
}

_id_20D3() {
  level notify("an_enemy_shot", self);
  _id_249F();
}

_id_2384(var_0) {
  var_1 = bulletspread(self getmuzzlepos(), var_0, 4);
  self.a._id_0AA7 = gettime();
  self notify("shooting");
  self shoot(1, var_1);
}

_id_24A0() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("temp");
  var_0.origin = self gettagorigin("tag_weapon_right") + (50, 50, 0);
  var_0.angles = self gettagangles("tag_weapon_right");
  var_1 = anglestoright(var_0.angles);
  var_1 = var_1 * 15;
  var_2 = anglesToForward(var_0.angles);
  var_2 = var_2 * 15;
  var_0 movegravity((0, 50, 150), 100);
  var_3 = "weapon_" + self.weapon;
  var_4 = spawn(var_3, var_0.origin);
  var_4.angles = self gettagangles("tag_weapon_right");
  var_4 linkto(var_0);
  var_5 = var_0.origin;

  while(isDefined(var_4) && isDefined(var_4.origin)) {
    var_6 = var_5;
    var_7 = var_0.origin;
    var_8 = vectortoangles(var_7 - var_6);
    var_2 = anglesToForward(var_8);
    var_2 = var_2 * 4;
    var_9 = bulletTrace(var_7, var_7 + var_2, 1, var_4);

    if(isalive(var_9["entity"]) && var_9["entity"] == self) {
      wait 0.05;
      continue;
    }

    if(var_9["fraction"] < 1.0) {
      break;
    }

    var_5 = var_0.origin;
    wait 0.05;
  }

  if(isDefined(var_4) && isDefined(var_4.origin)) {
    var_4 unlink();

  }
  var_0 delete();
}

_id_20CC(var_0) {
  anim._id_10FA["stand"]["in"] = % casual_stand_idle_trans_in;
  anim._id_1100["stand"][0][0] = % casual_stand_idle;
  anim._id_1100["stand"][0][1] = % casual_stand_idle_twitch;
  anim._id_1100["stand"][0][2] = % casual_stand_idle_twitchb;
  anim._id_1101["stand"][0][0] = 2;
  anim._id_1101["stand"][0][1] = 1;
  anim._id_1101["stand"][0][2] = 1;
  anim._id_1100["stand"][1][0] = % casual_stand_v2_idle;
  anim._id_1100["stand"][1][1] = % casual_stand_v2_twitch_radio;
  anim._id_1100["stand"][1][2] = % casual_stand_v2_twitch_shift;
  anim._id_1100["stand"][1][3] = % casual_stand_v2_twitch_talk;
  anim._id_1101["stand"][1][0] = 10;
  anim._id_1101["stand"][1][1] = 4;
  anim._id_1101["stand"][1][2] = 7;
  anim._id_1101["stand"][1][3] = 4;
  anim._id_1100["stand_cqb"][0][0] = % cqb_stand_idle;
  anim._id_1100["stand_cqb"][0][1] = % cqb_stand_twitch;
  anim._id_1101["stand_cqb"][0][0] = 2;
  anim._id_1101["stand_cqb"][0][1] = 1;
  anim._id_10FA["crouch"]["in"] = % casual_crouch_idle_in;
  anim._id_1100["crouch"][0][0] = % casual_crouch_idle;
  anim._id_1101["crouch"][0][0] = 6;
}

_id_24A1() {
  var_0 = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  while(isDefined(self)) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    if(isDefined(self.a._id_0D2B) && self.a._id_0D2B == "stop") {
      if(isDefined(self._id_1097) && self._id_1097 == 1) {
        continue;
      }
      playFXOnTag(level._effect["cold_breath"], self, var_0);
      wait(2.5 + randomfloat(3));
      continue;
    }

    wait 0.5;
  }
}

_id_24A2() {
  self notify("stop personal effect");
}

_id_24A3() {
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  for(;;) {
    self waittill("spawned", var_0);

    if(maps\_utility::_id_13AF(var_0)) {
      continue;
    }
    var_0 thread _id_24A1();
  }
}

_id_0F4C() {
  if(isDefined(self._id_24A4)) {
    return self._id_24A4;

  }
  if(self.suppressionmeter <= self._id_0CFB) {
    return 0;

  }
  return self issuppressed();
}

_id_0F62() {
  if(self.suppressionmeter <= self._id_0CFB * 0.25) {
    return 0;

  }
  return self issuppressed();
}

_id_0F8E(var_0) {
  if(isDefined(var_0.offset)) {
    return var_0.offset;

  }
  var_1 = (-26, 0.4, 36);
  var_2 = (-32, 7, 63);
  var_3 = (43.5, 11, 36);
  var_4 = (36, 8.3, 63);
  var_5 = (3.5, -12.5, 45);
  var_6 = (-3.7, -22, 63);
  var_7 = 0;
  var_8 = (0, 0, 0);
  var_9 = anglestoright(var_0.angles);
  var_10 = anglesToForward(var_0.angles);

  switch (var_0.type) {
    case "Cover Left":
      if(var_0 gethighestnodestance() == "crouch") {
        var_8 = _id_24A5(var_9, var_10, var_1);
      } else {
        var_8 = _id_24A5(var_9, var_10, var_2);

      }
      break;
    case "Cover Right":
      if(var_0 gethighestnodestance() == "crouch") {
        var_8 = _id_24A5(var_9, var_10, var_3);
      } else {
        var_8 = _id_24A5(var_9, var_10, var_4);

      }
      break;
    case "Turret":
    case "Cover Stand":
    case "Conceal Stand":
      var_8 = _id_24A5(var_9, var_10, var_6);
      break;
    case "Cover Crouch Window":
    case "Cover Crouch":
    case "Conceal Crouch":
      var_8 = _id_24A5(var_9, var_10, var_5);
      break;
  }

  var_0.offset = var_8;
  return var_0.offset;
}

_id_24A5(var_0, var_1, var_2) {
  return var_0 * var_2[0] + var_1 * var_2[1] + (0, 0, var_2[2]);
}

_id_0CBC() {
  return isDefined(self.enemy) && self seerecently(self.enemy, 5);
}

_id_0CE3(var_0) {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  if(isDefined(var_0) && self cansee(self.enemy, var_0) || self cansee(self.enemy)) {
    if(!_id_24A6(self getEye(), self.enemy getshootatpos())) {
      return 0;

    }
    self._id_199F = _id_0FB8();
    _id_24A7();
    return 1;
  }

  return 0;
}

_id_0F4A() {
  if(!isDefined(self.enemy)) {
    self._id_199F = undefined;
    return 0;
  }

  var_0 = _id_0FB8();

  if(!isDefined(self.node)) {
    var_1 = self cansee(self.enemy);
  } else {
    var_1 = _id_117A(var_0, self.node);

  }
  if(var_1) {
    self._id_199F = var_0;
    _id_24A7();
  } else {}

  return var_1;
}

_id_117A(var_0, var_1) {
  if(var_1.type == "Cover Left" || var_1.type == "Cover Right") {
    if(!animscripts\corner::_id_244E(var_0, var_1)) {
      return 0;
    }
  }

  var_2 = _id_0F8E(var_1);
  var_3 = var_1.origin + var_2;

  if(!_id_24A6(var_3, var_0, var_1)) {
    return 0;

  }
  if(!sighttracepassed(var_3, var_0, 0, undefined)) {
    if(var_1.type == "Cover Crouch" || var_1.type == "Conceal Crouch") {
      var_3 = (0, 0, 64) + var_1.origin;
      return sighttracepassed(var_3, var_0, 0, undefined);
    }

    return 0;
  }

  return 1;
}

_id_24A6(var_0, var_1, var_2) {
  var_3 = self.downaimlimit - anim._id_20A1;
  var_4 = self.upaimlimit + anim._id_20A1;
  var_5 = angleclamp180(vectortoangles(var_1 - var_0)[0]);

  if(var_5 > var_4) {
    return 0;

  }
  if(var_5 < var_3) {
    if(isDefined(var_2) && var_2.type != "Cover Crouch" && var_2.type != "Conceal Crouch") {
      return 0;

    }
    if(var_5 < anim._id_0CAD + var_3) {
      return 0;
    }
  }

  return 1;
}

_id_24A7() {
  self.a._id_24A8 = 1;
}

_id_24A9() {
  if(!isDefined(self.a._id_24A8)) {
    self.a._id_24A8 = 1;

  }
  if(self.a._id_24A8) {
    self.a._id_24AA = gettime() + randomintrange(15000, 30000);
    self.a._id_24A8 = 0;
  }
}

_id_24AB(var_0, var_1, var_2) {
  for(;;) {
    wait 0.05;
    wait 0.05;
  }
}

_id_24AC() {
  if(!self canattackenemynode()) {
    return 0;

  }
  var_0 = undefined;

  if(isDefined(self.enemy.node)) {
    var_1 = _id_0F8E(self.enemy.node);
    var_0 = self.enemy.node.origin + var_1;
  } else {
    var_0 = self.enemy getshootatpos();

  }
  if(!self canshoot(var_0)) {
    return 0;

  }
  if(self.script == "combat") {
    if(!sighttracepassed(self getEye(), self getmuzzlepos(), 0, undefined)) {
      return 0;
    }
  }

  self._id_199F = var_0;
  return 1;
}

_id_0F39() {
  if(!_id_24AD()) {
    self._id_199F = undefined;
    return 0;
  }

  if(!isplayer(self.enemy)) {
    return _id_24AC();

  }
  if(isDefined(self.node)) {
    if(self.node.type == "Cover Left" || self.node.type == "Cover Right") {
      if(!animscripts\corner::_id_244E(_id_0FB8(), self.node)) {
        return 0;
      }
    }

    var_0 = _id_0F8E(self.node);
    var_1 = self.node.origin + var_0;
  } else {
    var_1 = self getmuzzlepos();

  }
  if(!_id_24A6(var_1, self.lastenemysightpos)) {
    return 0;

  }
  return _id_24B2(var_1);
}

_id_0CF3() {
  if(!_id_24AD()) {
    self._id_199F = undefined;
    return 0;
  }

  if(!isplayer(self.enemy)) {
    return _id_24AC();

  }
  var_0 = self getmuzzlepos();

  if(!_id_24A6(var_0, self.lastenemysightpos)) {
    return 0;

  }
  return _id_24B2(var_0);
}

_id_24AD() {
  if(!isDefined(self.enemy)) {
    return 0;

  }
  if(!isDefined(self.lastenemysightpos)) {
    return 0;

  }
  _id_24A9();

  if(gettime() > self.a._id_24AA) {
    return 0;

  }
  if(!_id_24AF()) {
    return isDefined(self._id_199F);

  }
  return 1;
}

_id_24AE(var_0) {
  if(!sighttracepassed(self getshootatpos(), var_0, 0, undefined)) {
    return 0;

  }
  if(self.a._id_0EE4["right"] == "none") {
    return 0;

  }
  var_1 = self getmuzzlepos();
  return sighttracepassed(var_1, var_0, 0, undefined);
}

_id_24AF() {
  if(isDefined(self._id_199F) && !_id_24AE(self._id_199F)) {
    return 1;

  }
  return !isDefined(self._id_24B0) || self._id_24B0 != self.lastenemysightpos || distancesquared(self._id_24B1, self.origin) > 1024;
}

_id_24B2(var_0) {
  if(!_id_24AF()) {
    return isDefined(self._id_199F);

  }
  if(isDefined(self.enemy) && distancesquared(self.origin, self.enemy.origin) > squared(self.enemy.maxvisibledist)) {
    self._id_199F = undefined;
    return 0;
  }

  if(!sighttracepassed(self getshootatpos(), var_0, 0, undefined)) {
    self._id_199F = undefined;
    return 0;
  }

  self._id_24B1 = self.origin;
  self._id_24B0 = self.lastenemysightpos;
  var_1 = _id_0FB8();
  var_2 = bulletTrace(self.lastenemysightpos, var_1, 0, undefined);
  var_3 = var_2["position"];
  var_4 = self.lastenemysightpos - var_3;
  var_5 = vectornormalize(self.lastenemysightpos - var_0);
  var_4 = var_4 - var_5 * vectordot(var_4, var_5);
  var_6 = 20.0;
  var_7 = int(length(var_4) / var_6 + 0.5);

  if(var_7 < 1) {
    var_7 = 1;

  }
  if(var_7 > 20) {
    var_7 = 20;

  }
  var_8 = self.lastenemysightpos - var_3;
  var_8 = (var_8[0] / var_7, var_8[1] / var_7, var_8[2] / var_7);
  var_7++;
  var_9 = var_3;
  self._id_199F = undefined;
  var_10 = 0;
  var_11 = 2;

  for(var_12 = 0; var_12 < var_7 + var_11; var_12++) {
    var_13 = sighttracepassed(var_0, var_9, 0, undefined);
    var_14 = var_9;

    if(var_12 == var_7 - 1) {
      var_8 = var_8 - var_5 * vectordot(var_8, var_5);

    }
    var_9 = var_9 + var_8;

    if(var_13) {
      var_10++;
      self._id_199F = var_14;

      if(var_12 > 0 && var_10 < var_11 && var_12 < var_7 + var_11 - 1) {
        continue;
      }
      return 1;
    } else {
      var_10 = 0;
    }
  }

  return isDefined(self._id_199F);
}

_id_10FF(var_0, var_1) {
  var_2 = var_0.size;
  var_3 = randomint(var_2);

  if(var_2 == 1) {
    return var_0[0];

  }
  var_4 = 0;
  var_5 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_5 = var_5 + var_1[var_6];

  }
  var_7 = randomfloat(var_5);
  var_8 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_8 = var_8 + var_1[var_6];

    if(var_7 >= var_8) {
      continue;
    }
    var_3 = var_6;
    break;
  }

  return var_0[var_3];
}

_id_24B3(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_0 / 0.05;

  for(var_7 = 0; var_7 < var_6; var_7++) {
    wait 0.05;
  }
}

_id_24B4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 100.0;
  var_6 = 0;
  var_0 = var_0 + common_scripts\utility::randomvector(30);

  for(var_7 = 0; var_7 < var_5; var_7++) {
    var_6 = var_6 + 0.5;
    wait 0.05;
  }
}

_id_24B5(var_0, var_1) {
  return var_0[0] * var_1[1] - var_0[1] * var_1[0] > 0;
}

_id_239F() {
  return getweaponmodel(self.grenadeweapon);
}

_id_24B6(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 500;

  }
  return gettime() - self._id_24B7 < var_0;
}

_id_24B8() {
  if(!self.grenadeammo) {
    return 0;

  }
  if(self._id_20B5) {
    return 1;

  }
  return isplayer(self.enemy);
}

_id_24B9() {
  return weaponisboltaction(self.weapon);
}

_id_24BA(var_0) {
  var_1 = randomint(var_0.size);

  if(var_0.size > 1) {
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 = var_2 + var_0[var_3];

    }
    var_4 = randomfloat(var_2);
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 = var_2 + var_0[var_3];

      if(var_4 < var_2) {
        var_1 = var_3;
        break;
      }
    }
  }

  return var_1;
}

_id_24BB(var_0, var_1) {
  if(!isDefined(anim._id_20D1)) {
    anim._id_20D1 = [];

  }
  anim._id_20D1[anim._id_20D1.size] = var_0;
  level._effect["step_" + var_0] = var_1;
}

_id_24BC(var_0, var_1) {
  if(!isDefined(anim._id_20D2)) {
    anim._id_20D2 = [];

  }
  anim._id_20D2[anim._id_20D2.size] = var_0;
  level._effect["step_small_" + var_0] = var_1;
}

_id_24BD(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = "all";

  }
  if(!isDefined(level._id_1E89)) {
    level._id_1E89 = [];

  }
  level._id_1E89[var_0][var_2] = spawnStruct();
  level._id_1E89[var_0][var_2].tag = var_1;
  level._id_1E89[var_0][var_2].fx = var_3;

  if(isDefined(var_4)) {
    level._id_1E89[var_0][var_2]._id_23FC = var_4;

  }
  if(isDefined(var_5)) {
    level._id_1E89[var_0][var_2]._id_23FD = var_5;
  }
}

_id_24BE(var_0, var_1) {
  self endon("death");
  level notify("newdebugline");
  level endon("newdebugline");

  for(;;) {
    wait 0.05;
  }
}

_id_10E1(var_0) {
  thread _id_24BF(var_0);
}

_id_24BF(var_0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self enterprone(var_0, isDefined(self.a._id_0D29));
  self waittill("killanimscript");

  if(self.a._id_0D26 != "prone" && !isDefined(self.a._id_0D29)) {
    self.a._id_0D26 = "prone";
  }
}

_id_0F7D(var_0) {
  thread _id_24C0(var_0);
}

_id_24C0(var_0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self exitprone(var_0);
  self waittill("killanimscript");

  if(self.a._id_0D26 == "prone") {
    self.a._id_0D26 = "crouch";
  }
}

_id_0F65() {
  if(self.a._id_0CE2) {
    return 0;

  }
  if(!animscripts\weaponlist::_id_0CCA()) {
    return 0;

  }
  if(weaponclass(self.weapon) == "mg") {
    return 0;

  }
  if(isDefined(self._id_24C1) && self._id_24C1 == 1) {
    return 0;

  }
  return 1;
}

_id_24C2() {
  if(!_id_0F8C()) {
    return 0;

  }
  var_0 = self getmuzzlepos();
  return sighttracepassed(var_0, _id_0CEE(), 0, undefined);
}

_id_0FC3(var_0) {
  return self.a._id_0CA6[var_0];
}

_id_0F26(var_0, var_1) {
  if(randomint(2)) {
    return var_0;
  } else {
    return var_1;
  }
}

_id_0D4D(var_0) {
  return self.a._id_0C6D[var_0];
}

_id_0F8D(var_0) {
  return self.a._id_0C6D[var_0].size > 0;
}

_id_0CA8(var_0) {
  var_1 = randomint(self.a._id_0C6D[var_0].size);
  return self.a._id_0C6D[var_0][var_1];
}

_id_0C6D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = [];

  if(isDefined(var_0)) {
    var_14[0] = var_0;
  } else {
    return var_14;

  }
  if(isDefined(var_1)) {
    var_14[1] = var_1;
  } else {
    return var_14;

  }
  if(isDefined(var_2)) {
    var_14[2] = var_2;
  } else {
    return var_14;

  }
  if(isDefined(var_3)) {
    var_14[3] = var_3;
  } else {
    return var_14;

  }
  if(isDefined(var_4)) {
    var_14[4] = var_4;
  } else {
    return var_14;

  }
  if(isDefined(var_5)) {
    var_14[5] = var_5;
  } else {
    return var_14;

  }
  if(isDefined(var_6)) {
    var_14[6] = var_6;
  } else {
    return var_14;

  }
  if(isDefined(var_7)) {
    var_14[7] = var_7;
  } else {
    return var_14;

  }
  if(isDefined(var_8)) {
    var_14[8] = var_8;
  } else {
    return var_14;

  }
  if(isDefined(var_9)) {
    var_14[9] = var_9;
  } else {
    return var_14;

  }
  if(isDefined(var_10)) {
    var_14[10] = var_10;
  } else {
    return var_14;

  }
  if(isDefined(var_11)) {
    var_14[11] = var_11;
  } else {
    return var_14;

  }
  if(isDefined(var_12)) {
    var_14[12] = var_12;
  } else {
    return var_14;

  }
  if(isDefined(var_13)) {
    var_14[13] = var_13;

  }
  return var_14;
}

_id_115A() {
  return self.primaryweapon;
}

_id_24C3() {
  return self.secondaryweapon;
}

_id_24C4() {
  return self.sidearm;
}

_id_24C5() {
  return self.weapon;
}

_id_1118() {
  return self.weapon == self.primaryweapon && self.weapon != "none";
}

_id_24C6() {
  return self.weapon == self.secondaryweapon && self.weapon != "none";
}

_id_0C95() {
  return self.weapon == self.sidearm && self.weapon != "none";
}

_id_24C7() {
  if(self.weapon == self.primaryweapon) {
    return "primary";
  } else if(self.weapon == self.secondaryweapon) {
    return "secondary";
  } else if(self.weapon == self.sidearm) {
    return "sidearm";
  } else {}
}

_id_24C8(var_0) {
  if(isDefined(self.weaponinfo[var_0])) {
    return 1;

  }
  return 0;
}

_id_0F99(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  return self localtoworldcoords(var_1);
}

_id_0D2F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_0)) {
    return 0;

  }
  if(self.damagelocation == var_0) {
    return 1;

  }
  if(!isDefined(var_1)) {
    return 0;

  }
  if(self.damagelocation == var_1) {
    return 1;

  }
  if(!isDefined(var_2)) {
    return 0;

  }
  if(self.damagelocation == var_2) {
    return 1;

  }
  if(!isDefined(var_3)) {
    return 0;

  }
  if(self.damagelocation == var_3) {
    return 1;

  }
  if(!isDefined(var_4)) {
    return 0;

  }
  if(self.damagelocation == var_4) {
    return 1;

  }
  if(!isDefined(var_5)) {
    return 0;

  }
  if(self.damagelocation == var_5) {
    return 1;

  }
  if(!isDefined(var_6)) {
    return 0;

  }
  if(self.damagelocation == var_6) {
    return 1;

  }
  if(!isDefined(var_7)) {
    return 0;

  }
  if(self.damagelocation == var_7) {
    return 1;

  }
  if(!isDefined(var_8)) {
    return 0;

  }
  if(self.damagelocation == var_8) {
    return 1;

  }
  if(!isDefined(var_9)) {
    return 0;

  }
  if(self.damagelocation == var_9) {
    return 1;

  }
  if(!isDefined(var_10)) {
    return 0;

  }
  if(self.damagelocation == var_10) {
    return 1;

  }
  return 0;
}

_id_24C9() {
  return weaponclass(self.weapon) == "pistol";
}

_id_0BB6() {
  return weaponclass(self.weapon) == "rocketlauncher";
}

_id_0F79() {
  return weaponclass(self.weapon) == "mg";
}

_id_2380() {
  return weaponclass(self.weapon) == "spread";
}

_id_0EE3() {
  var_0 = weaponclass(self.weapon);

  switch (var_0) {
    case "rifle":
    case "sniper":
    case "smg":
    case "spread":
    case "mg":
      return 1;
  }

  return 0;
}

_id_24CA(var_0) {
  self endon("killanimscript");
  var_1 = self.origin;
  var_2 = (0, 0, 0);

  for(;;) {
    wait 0.05;
    var_3 = distance(self.origin, var_1);
    var_1 = self.origin;

    if(self.health == 1) {
      self.a._id_0D55 = 1;
      self startragdoll();
      self clearanim(var_0, 0.1);
      wait 0.05;
      physicsexplosionsphere(var_1, 600, 0, var_3 * 0.1);
      self notify("killanimscript");
      return;
    }
  }
}

_id_0CB2() {
  return isDefined(self._id_109A) && !isDefined(self.grenade);
}

_id_0C98() {
  return isDefined(self._id_109A);
}

_id_10B9() {
  return !self.facemotion || isDefined(self._id_109A);
}

_id_10F0() {
  self.a._id_10F2 = randomint(2);
}

_id_0CEA(var_0) {
  return weaponclass(var_0) == "spread";
}

_id_0BEB(var_0) {
  return weaponclass(var_0) == "sniper";
}

_id_0C97() {
  return self.weapon != "none" && weaponisboltaction(self.weapon) && weaponclass(self.weapon) == "spread";
}

_id_1078(var_0, var_1) {
  var_2 = var_0 % anim._id_20F6;
  return anim._id_20F7[var_2] % var_1;
}

_id_104B() {
  if(_id_24C6()) {
    return "secondary";

  }
  if(_id_0C95()) {
    return "sidearm";

  }
  return "primary";
}