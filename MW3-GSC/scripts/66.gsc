/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\66.gsc
**************************************/

_id_226E() {
  level._id_226F["easy"]["convergenceTime"] = 2.5;
  level._id_226F["easy"]["suppressionTime"] = 3.0;
  level._id_226F["easy"]["accuracy"] = 0.38;
  level._id_226F["easy"]["aiSpread"] = 2;
  level._id_226F["easy"]["playerSpread"] = 0.5;
  level._id_226F["medium"]["convergenceTime"] = 1.5;
  level._id_226F["medium"]["suppressionTime"] = 3.0;
  level._id_226F["medium"]["accuracy"] = 0.38;
  level._id_226F["medium"]["aiSpread"] = 2;
  level._id_226F["medium"]["playerSpread"] = 0.5;
  level._id_226F["hard"]["convergenceTime"] = 0.8;
  level._id_226F["hard"]["suppressionTime"] = 3.0;
  level._id_226F["hard"]["accuracy"] = 0.38;
  level._id_226F["hard"]["aiSpread"] = 2;
  level._id_226F["hard"]["playerSpread"] = 0.5;
  level._id_226F["fu"]["convergenceTime"] = 0.4;
  level._id_226F["fu"]["suppressionTime"] = 3.0;
  level._id_226F["fu"]["accuracy"] = 0.38;
  level._id_226F["fu"]["aiSpread"] = 2;
  level._id_226F["fu"]["playerSpread"] = 0.5;
}

main() {
  if(getDvar("mg42") == "") {
    setDvar("mgTurret", "off");
  }
  level._id_2270 = 24;
  var_0 = getEntArray("turretInfo", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] delete();
  }
}

_id_2271() {
  self detach("weapon_mg42_carry", "tag_origin");
  self endon("death");
  self.goalradius = level._id_2070;

  if(isDefined(self.target)) {
    var_0 = getnode(self.target, "targetname");

    if(isDefined(var_0)) {
      if(isDefined(var_0.radius)) {
        self.goalradius = var_0.radius;
      }
      self setgoalnode(var_0);
    }
  }

  while(!isDefined(self.node)) {
    wait 0.05;
  }
  var_1 = undefined;

  if(isDefined(self.target)) {
    var_0 = getnode(self.target, "targetname");
    var_1 = var_0;
  }

  if(!isDefined(var_1)) {
    var_1 = self.node;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(var_1.type != "Turret") {
    return;
  }
  var_2 = _id_22CE();
  var_2[self.node.origin + ""] = undefined;

  if(isDefined(var_2[var_1.origin + ""])) {
    return;
  }
  var_3 = var_1._id_0A50;

  if(isDefined(var_3._id_2272)) {
    return;
  }
  _id_22DA(var_3);

  if(var_3._id_0FA8) {
    _id_22C2(var_3);
  } else {
    _id_22C5(var_3);
  }
  maps\_mg_penetration::_id_0A47(var_1._id_0A50);
}

_id_2273() {
  self waittill("trigger");
  level notify(self.targetname);
  level._id_2273[self.targetname] = 1;
  self delete();
}

_id_1EB2(var_0) {
  var_0 waittill("trigger");
  var_1 = getaiarray("bad_guys");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2]._id_2274) && var_0._id_2274 == var_1[var_2]._id_2274) {
      var_1[var_2] notify("auto_ai");
    }
  }

  var_3 = getspawnerarray();

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    if(isDefined(var_3[var_2]._id_2274) && var_0._id_2274 == var_3[var_2]._id_2274) {
      var_3[var_2]._id_2275 = "auto_ai";
    }
  }

  maps\_spawner::_id_213A(var_0);
}

_id_21BB(var_0) {
  self endon("death");
  self endon("stop_suppressionFire");

  if(!isDefined(self._id_2276)) {
    self._id_2276 = 1;
  }
  for(;;) {
    while(self._id_2276) {
      self settargetentity(var_0[randomint(var_0.size)]);
      wait(2 + randomfloat(2));
    }

    self cleartargetentity();

    while(!self._id_2276) {
      wait 1;
    }
  }
}

_id_21BA(var_0) {
  var_1 = self.origin;
  self waittill("auto_ai");
  var_0 notify("stopfiring");
  var_0 setmode("auto_ai");
  var_0 settargetentity(level.player);
}

_id_2277(var_0) {
  if(var_0 == "delay") {
    return 0.2;
  } else if(var_0 == "delay_range") {
    return 0.5;
  } else if(var_0 == "burst") {
    return 0.5;
  } else {
    return 1.5;
  }
}

_id_2278() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isDefined(self.script_delay_min)) {
    var_0 = self.script_delay_min;
  } else {
    var_0 = _id_2277("delay");
  }
  if(isDefined(self.script_delay_max)) {
    var_1 = self.script_delay_max - var_0;
  } else {
    var_1 = _id_2277("delay_range");
  }
  if(isDefined(self._id_2279)) {
    var_2 = self._id_2279;
  } else {
    var_2 = _id_2277("burst");
  }
  if(isDefined(self._id_227A)) {
    var_3 = self._id_227A - var_2;
  } else {
    var_3 = _id_2277("burst_range");
  }
  var_4 = gettime();
  var_5 = "start";

  if(isDefined(self._id_227B)) {
    thread _id_227D();
  }
  for(;;) {
    var_6 = (var_4 - gettime()) * 0.001;

    if(self isfiringturret() && var_6 <= 0) {
      if(var_5 != "fire") {
        var_5 = "fire";
        thread _id_227C();
      }

      var_6 = var_2 + randomfloat(var_3);
      thread _id_2282(var_6);
      self waittill("turretstatechange");
      var_6 = var_0 + randomfloat(var_1);
      var_4 = gettime() + int(var_6 * 1000);
      continue;
    }

    if(var_5 != "aim") {
      var_5 = "aim";
    }
    thread _id_2282(var_6);
    self waittill("turretstatechange");
  }
}

_id_227C() {
  self endon("death");
  self endon("turretstatechange");

  for(;;) {
    self shootturret();
    wait 0.1;
  }
}

_id_227D() {
  self endon("death");
  self endon("stop_burst_fire_unmanned");

  if(isDefined(self._id_227E)) {
    self._id_227F = 1;
  }
  for(;;) {
    self waittill("turret_fire");
    playFXOnTag(self._id_227B, self, "tag_origin");

    if(isDefined(self._id_227F) && self._id_227F) {
      thread _id_2280();
    }
  }
}

_id_2280() {
  self endon("death");
  self._id_227F = 0;
  var_0 = self gettagorigin("tag_origin");
  var_1 = maps\_utility::_id_2281(var_0, -30);
  var_2 = var_0[2] - var_1[2];
  var_3 = var_2 / 300;
  wait(var_3);
  level thread common_scripts\utility::play_sound_in_space(self._id_227E, var_1);
  wait 1;
  self._id_227F = 1;
}

_id_2282(var_0) {
  if(var_0 <= 0) {
    return;
  }
  self endon("turretstatechange");
  wait(var_0);

  if(isDefined(self)) {
    self notify("turretstatechange");
  }
}

_id_2283(var_0) {
  self endon("death");
  self notify("stop random_spread");
  self endon("stop random_spread");
  self endon("stopfiring");
  self settargetentity(var_0);

  for(;;) {
    if(isPlayer(var_0)) {
      var_0.origin = self._id_21B9 getorigin();
    } else {
      var_0.origin = self._id_21B9.origin;
    }
    var_0.origin = var_0.origin + (20 - randomfloat(40), 20 - randomfloat(40), 20 - randomfloat(60));
    wait 0.2;
  }
}

_id_21BC(var_0) {
  self notify("stop_using_built_in_burst_fire");
  self endon("stop_using_built_in_burst_fire");
  var_0 stopfiring();

  for(;;) {
    var_0 waittill("startfiring");
    thread _id_2284(var_0);
    var_0 startfiring();
    var_0 waittill("stopfiring");
    var_0 stopfiring();
  }
}

_id_2284(var_0, var_1) {
  var_0 endon("stopfiring");
  self endon("stop_using_built_in_burst_fire");

  if(isDefined(var_0.script_delay_min)) {
    var_2 = var_0.script_delay_min;
  } else {
    var_2 = _id_2277("delay");
  }
  if(isDefined(var_0.script_delay_max)) {
    var_3 = var_0.script_delay_max - var_2;
  } else {
    var_3 = _id_2277("delay_range");
  }
  if(isDefined(var_0._id_2279)) {
    var_4 = var_0._id_2279;
  } else {
    var_4 = _id_2277("burst");
  }
  if(isDefined(var_0._id_227A)) {
    var_5 = var_0._id_227A - var_4;
  } else {
    var_5 = _id_2277("burst_range");
  }
  for(;;) {
    var_0 startfiring();

    if(isDefined(var_1)) {
      var_0 thread _id_2283(var_1);
    }
    wait(var_4 + randomfloat(var_5));
    var_0 stopfiring();
    wait(var_2 + randomfloat(var_3));
  }
}

_id_2285() {
  if(!isDefined(self._id_219F)) {
    self._id_219F = 0;
  }
  if(!isDefined(self.targetname)) {
    return;
  }
  var_0 = getnode(self.targetname, "target");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_2286)) {
    return;
  }
  if(!isDefined(var_0._id_2287)) {
    var_0._id_2287 = 1;
  }
  self._id_2286 = var_0._id_2286;
  var_1 = 1;

  for(;;) {
    if(var_1) {
      var_1 = 0;

      if(isDefined(var_0.targetname) || self._id_219F) {
        self waittill("get new user");
      }
    }

    if(!var_0._id_2287) {
      var_0 waittill("enable mg42");
      var_0._id_2287 = 1;
    }

    var_2 = [];
    var_3 = getaiarray();

    for(var_4 = 0; var_4 < var_3.size; var_4++) {
      var_5 = 1;

      if(isDefined(var_3[var_4]._id_2286) && var_3[var_4]._id_2286 == self._id_2286) {
        var_5 = 0;
      }
      if(isDefined(var_3[var_4]._id_2196)) {
        var_5 = 1;
      }
      if(var_5) {
        var_2[var_2.size] = var_3[var_4];
      }
    }

    if(var_2.size) {
      var_3 = maps\_utility::_id_2288(var_0.origin, undefined, var_2);
    } else {
      var_3 = maps\_utility::_id_1EE9(var_0.origin, undefined);
    }
    var_2 = undefined;

    if(isDefined(var_3)) {
      var_3 notify("stop_going_to_node");
      var_3 thread maps\_spawner::_id_21A4(var_0);
      var_3 waittill("death");
      continue;
    }

    self waittill("get new user");
  }
}

_id_2289() {
  if(!isDefined(self._id_2275)) {
    self._id_2275 = "manual_ai";
  }
  var_0 = getnode(self.target, "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getent(var_0.target, "targetname");
  var_1._id_1F49 = var_0.origin;

  if(isDefined(var_1.target)) {
    if(!isDefined(level._id_2273) || !isDefined(level._id_2273[var_1.target])) {
      level._id_2273[var_1.target] = 0;
      getent(var_1.target, "targetname") thread _id_2273();
    }

    var_2 = 1;
  } else {
    var_2 = 0;
  }
  for(;;) {
    if(self.count == 0) {
      return;
    }
    var_3 = undefined;

    while(!isDefined(var_3)) {
      var_3 = self dospawn();
      wait 1;
    }

    var_3 thread _id_228B(var_1, var_2, self._id_2275);
    var_3 thread _id_21BC(var_1);
    var_3 waittill("death");

    if(isDefined(self.script_delay)) {
      wait(self.script_delay);
      continue;
    }

    if(isDefined(self.script_delay_min) && isDefined(self.script_delay_max)) {
      wait(self.script_delay_min + randomfloat(self.script_delay_max - self.script_delay_min));
      continue;
    }

    wait 1;
  }
}

_id_228A(var_0, var_1, var_2, var_3) {
  var_0 waittill(var_1);

  if(isDefined(var_2)) {
    var_2 delete();
  }
  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_228B(var_0, var_1, var_2) {
  self endon("death");

  if(var_2 == "manual_ai") {
    for(;;) {
      thread _id_2290(var_0, var_1);
      self waittill("auto_ai");
      _id_2296(var_0, "auto_ai");
      self waittill("manual_ai");
    }
  } else {
    for(;;) {
      _id_2296(var_0, "auto_ai", level.player);
      self waittill("manual_ai");
      thread _id_2290(var_0, var_1);
      self waittill("auto_ai");
    }
  }
}

_id_228C() {
  if(!isDefined(level._id_228D)) {
    return 0;
  }
  if(level.player getstance() == "prone") {
    return 1;
  }
  if(level._id_228E == "cow" && level.player getstance() == "crouch") {
    return 1;
  }
  return 0;
}

_id_228F() {
  if(level.player getstance() == "prone") {
    return (0, 0, 5);
  } else if(level.player getstance() == "crouch") {
    return (0, 0, 25);
  }
  return (0, 0, 50);
}

_id_2290(var_0, var_1) {
  self endon("death");
  self endon("auto_ai");
  self.pacifist = 1;
  self setgoalpos(var_0._id_1F49);
  self.goalradius = level._id_2270;
  self waittill("goal");

  if(var_1) {
    if(!level._id_2273[var_0.target]) {
      level waittill(var_0.target);
    }
  }

  self.pacifist = 0;
  var_0 setmode("auto_ai");
  var_0 cleartargetentity();
  var_2 = spawn("script_origin", (0, 0, 0));
  var_3 = spawn("script_model", (0, 0, 0));
  var_3.scale = 3;

  if(getDvar("mg42") != "off") {
    var_3 setModel("temp");
  }
  var_3 thread _id_2297(var_0, var_2);
  level thread _id_228A(self, "death", var_2, var_3);
  level thread _id_228A(self, "auto_ai", var_2, var_3);
  var_0._id_2291 = 0;
  var_4 = 0;
  var_5 = getEntArray("mg42_target", "targetname");

  if(var_5.size > 0) {
    var_6 = 1;
    var_7 = var_5[randomint(var_5.size)].origin;
    thread _id_2295(var_5);
    _id_2296(var_0);
    self._id_2292 = var_2;
    var_0 setmode("manual_ai");
    var_0 settargetentity(var_2);
    var_0 notify("startfiring");
    var_8 = 15;
    var_9 = 0.08;
    var_10 = 0.05;
    var_2.origin = var_5[randomint(var_5.size)].origin;
    var_11 = 0;

    while(!isDefined(level._id_228D)) {
      var_7 = var_2.origin;

      if(distance(var_7, var_5[self._id_2293].origin) > var_8) {
        var_12 = vectornormalize(var_5[self._id_2293].origin - var_7);
        var_12 = var_12 * var_8;
        var_7 = var_7 + var_12;
      } else {
        self notify("next_target");
      }
      var_2.origin = var_7;
      wait 0.1;
    }

    for(;;) {
      for(var_13 = 0; var_13 < 1; var_13 = var_13 + var_10) {
        var_2.origin = var_7 * (1.0 - var_13) + (level.player getorigin() + _id_228F()) * var_13;

        if(_id_228C()) {
          var_13 = 2;
        }
        wait(var_9);
      }

      var_14 = level.player getorigin();

      while(!_id_228C()) {
        var_2.origin = level.player getorigin();
        var_15 = var_2.origin - var_14;
        var_2.origin = var_2.origin + var_15 + _id_228F();
        var_14 = level.player getorigin();
        wait 0.1;
      }

      if(_id_228C()) {
        var_11 = gettime() + 1500 + randomfloat(4000);

        while(_id_228C() && isDefined(level._id_228D.target) && gettime() < var_11) {
          var_16 = getEntArray(level._id_228D.target, "targetname");
          var_16 = var_16[randomint(var_16.size)];
          var_2.origin = var_16.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          wait 0.1;
        }
      }

      self notify("next_target");

      while(_id_228C()) {
        var_7 = var_2.origin;

        if(distance(var_7, var_5[self._id_2293].origin) > var_8) {
          var_12 = vectornormalize(var_5[self._id_2293].origin - var_7);
          var_12 = var_12 * var_8;
          var_7 = var_7 + var_12;
        } else {
          self notify("next_target");
        }
        var_2.origin = var_7;
        wait 0.1;
      }
    }
  } else {
    for(;;) {
      _id_2296(var_0);

      while(!isDefined(level._id_228D)) {
        if(!var_0._id_2291) {
          var_0 settargetentity(level.player);
          var_0._id_2291 = 1;
          var_3._id_2294 = level.player;
        }

        wait 0.2;
      }

      var_0 setmode("manual_ai");
      _id_2296(var_0);
      var_0 notify("startfiring");
      var_11 = gettime() + 1500 + randomfloat(4000);

      while(var_11 > gettime()) {
        if(isDefined(level._id_228D)) {
          var_16 = getEntArray(level._id_228D.target, "targetname");
          var_16 = var_16[randomint(var_16.size)];
          var_2.origin = var_16.origin + (randomfloat(30) - 15, randomfloat(30) - 15, randomfloat(40) - 60);
          var_0 settargetentity(var_2);
          var_3._id_2294 = var_2;
          wait(randomfloat(1));
          continue;
        }

        break;
      }

      var_0 notify("stopfiring");
      _id_2296(var_0);

      if(var_0._id_2291) {
        var_0 setmode("auto_ai");
        var_0 cleartargetentity();
        var_0._id_2291 = 0;
        var_3._id_2294 = var_3;
        var_3.origin = (0, 0, 0);
      }

      while(isDefined(level._id_228D)) {
        wait 0.2;
      }
      wait(0.75 + randomfloat(0.2));
    }
  }
}

_id_2295(var_0) {
  self endon("death");

  for(;;) {
    var_1 = [];

    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      var_1[var_2] = 0;
    }
    for(var_2 = 0; var_2 < var_0.size; var_2++) {
      self._id_2293 = randomint(var_0.size);
      self waittill("next_target");

      while(var_1[self._id_2293]) {
        self._id_2293++;

        if(self._id_2293 >= var_0.size) {
          self._id_2293 = 0;
        }
      }

      var_1[self._id_2293] = 1;
    }
  }
}

_id_2296(var_0, var_1, var_2) {
  self setgoalpos(var_0._id_1F49);
  self.goalradius = level._id_2270;
  self waittill("goal");

  if(isDefined(var_1) && var_1 == "auto_ai") {
    var_0 setmode("auto_ai");

    if(isDefined(var_2)) {
      var_0 settargetentity(var_2);
    } else {
      var_0 cleartargetentity();
    }
  }

  self useturret(var_0);
}

_id_2297(var_0, var_1) {
  if(getDvar("mg42") == "off") {
    return;
  }
  self._id_2294 = self;

  for(;;) {
    self.origin = var_1.origin;
    wait 0.1;
  }
}

_id_2298(var_0) {
  var_1 = getent(var_0._id_2299, "targetname");
  var_2 = 0.5;

  if(isDefined(var_1._id_229A)) {
    var_2 = var_1._id_229A;
  }
  var_3 = 2;

  if(isDefined(var_1._id_229B)) {
    var_2 = var_1._id_229B;
  }
  for(;;) {
    var_1 waittill("turret_deactivate");
    wait(var_2 + randomfloat(var_3 - var_2));

    while(!isturretactive(var_1)) {
      _id_229C(var_0, var_1);
      wait 1.0;
    }
  }
}

_id_229C(var_0, var_1) {
  var_2 = getaiarray();

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(var_2[var_3] isingoal(var_0.origin) && var_2[var_3] canuseturret(var_1)) {
      var_4 = var_2[var_3].keepclaimednodeifvalid;
      var_2[var_3].keepclaimednodeifvalid = 0;

      if(!var_2[var_3] usecovernode(var_0)) {
        var_2[var_3].keepclaimednodeifvalid = var_4;
      }
    }
  }
}

_id_17D2() {
  _id_226E();
  var_0 = getEntArray("misc_turret", "code_classname");
  var_1 = maps\_utility::_id_229D();

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(isDefined(var_0[var_2]._id_229E)) {
      switch (var_0[var_2]._id_229E) {
        case "easy":
          var_1 = "easy";
          break;
        case "medium":
          var_1 = "medium";
          break;
        case "hard":
          var_1 = "hard";
          break;
        case "fu":
          var_1 = "fu";
          break;
        default:
          continue;
      }
    }

    _id_229F(var_0[var_2], var_1);
  }
}

_id_229F(var_0, var_1) {
  var_0.convergencetime = level._id_226F[var_1]["convergenceTime"];
  var_0._id_22A0 = level._id_226F[var_1]["suppressionTime"];
  var_0.accuracy = level._id_226F[var_1]["accuracy"];
  var_0._id_22A1 = level._id_226F[var_1]["aiSpread"];
  var_0._id_22A2 = level._id_226F[var_1]["playerSpread"];
}

_id_22A3(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0.88;
  }
  self endon("death");
  self notify("stop_mg42_target_drones");
  self endon("stop_mg42_target_drones");
  self._id_22A4 = 0;

  if(!isDefined(self._id_22A5)) {
    self._id_22A5 = 0;
  }
  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  self setmode("manual_ai");
  var_3 = maps\_utility::_id_229D();

  if(!isDefined(level._id_1FFB)) {
    var_4 = 1;
  } else {
    var_4 = 0;
  }
  for(;;) {
    if(var_4) {
      if(isDefined(self._id_22A6)) {
        self setmode(self._id_22A7);
      } else if(var_0) {
        self setmode("auto_nonai");
      } else {
        self setmode("auto_ai");
      }
      level waittill("new_drone");
    }

    if(!isDefined(self._id_22A8)) {
      self._id_22A8 = self.convergencetime;
    }
    self.convergencetime = 2;

    if(!var_0) {
      var_5 = self getturretowner();

      if(!isalive(var_5) || isPlayer(var_5)) {
        wait 0.05;
        continue;
      } else {
        var_1 = var_5.team;
      }
    } else {
      var_5 = undefined;
    }
    if(var_1 == "allies") {
      var_6 = "axis";
    } else {
      var_6 = "allies";
    }
    while(level._id_1FFB[var_6]._id_22A9) {
      common_scripts\utility::lock("mg42_drones");

      if(!level._id_1FFB[var_6]._id_22A9) {
        common_scripts\utility::unlock("mg42_drones");
        break;
      }

      var_7 = _id_22AD(var_6, var_2);
      common_scripts\utility::unlock("mg42_drones");

      if(!isDefined(self._id_22A5) || !self._id_22A5) {
        wait 0.05;
        break;
      }

      if(!isDefined(var_7)) {
        wait 0.05;
        break;
      }

      if(isDefined(self._id_22AA)) {
        [[self._id_22AA]]();
      }
      if(var_0) {
        self setmode("manual");
      } else {
        self setmode("manual_ai");
      }
      self settargetentity(var_7, (0, 0, 32));
      _id_22AB(var_7, 1, var_2);
      self cleartargetentity();
      self stopfiring();

      if(!var_0 && !(isDefined(self getturretowner()) && self getturretowner() == var_5)) {
        break;
      }
    }

    self.convergencetime = self._id_22A8;
    self._id_22A8 = undefined;
    self cleartargetentity();
    self stopfiring();

    if(level._id_1FFB[var_6]._id_22A9) {
      var_4 = 0;
      continue;
    }

    var_4 = 1;
  }
}

_id_22AB(var_0, var_1, var_2) {
  self endon("death");
  var_0 endon("death");
  var_3 = gettime() + var_1 * 1000;
  var_4 = 0;

  while(var_3 > gettime() || var_4) {
    common_scripts\utility::lock("mg42_drones_target_trace");
    var_5 = self getturrettarget(1);

    if(!bullettracepassed(self gettagorigin("tag_flash"), var_0.origin + (0, 0, 40), 0, var_0)) {
      common_scripts\utility::unlock("mg42_drones_target_trace");
      break;
    } else if(isDefined(var_5) && distance(var_5.origin, self.origin) < distance(self.origin, var_0.origin)) {
      common_scripts\utility::unlock("mg42_drones_target_trace");
      break;
    }

    if(!var_4) {
      self startfiring();
      var_4 = 1;
    }

    common_scripts\utility::unlock_wait("mg42_drones_target_trace");
  }

  self stopfiring();
  maps\_utility::_id_22AC(level._id_1FFB[var_0.team], 1);
}

_id_22AD(var_0, var_1) {
  if(level._id_1FFB[var_0]._id_22A9 < 1) {
    return;
  }
  var_2 = undefined;
  var_3 = anglesToForward(self.angles);

  for(var_4 = 0; var_4 < level._id_1FFB[var_0]._id_22A9; var_4++) {
    if(!isDefined(level._id_1FFB[var_0]._id_0C6D[var_4])) {
      continue;
    }
    var_5 = vectortoangles(level._id_1FFB[var_0]._id_0C6D[var_4].origin - self.origin);
    var_6 = anglesToForward(var_5);

    if(vectordot(var_3, var_6) < var_1) {
      continue;
    }
    var_2 = level._id_1FFB[var_0]._id_0C6D[var_4];

    if(!bullettracepassed(self gettagorigin("tag_flash"), var_2 getcentroid(), 0, var_2)) {
      var_2 = undefined;
      continue;
    }

    break;
  }

  var_7 = self getturrettarget(1);

  if(!isDefined(self._id_22AE)) {
    if(isDefined(var_2) && isDefined(var_7) && distancesquared(self.origin, var_7.origin) < distancesquared(self.origin, var_2.origin)) {
      var_2 = undefined;
    }
  }

  return var_2;
}

_id_1F07(var_0) {
  var_1 = getEntArray("misc_turret", "code_classname");
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(isDefined(var_1[var_3].targetname)) {
      continue;
    }
    if(isDefined(var_1[var_3]._id_22AF)) {
      continue;
    }
    var_2[var_1[var_3].origin + ""] = var_1[var_3];
  }

  if(!var_2.size) {
    return;
  }
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_5.type == "Path") {
      continue;
    }
    if(var_5.type == "Begin") {
      continue;
    }
    if(var_5.type == "End") {
      continue;
    }
    var_6 = anglesToForward((0, var_5.angles[1], 0));

    foreach(var_11, var_8 in var_2) {
      if(distance(var_5.origin, var_8.origin) > 50) {
        continue;
      }
      var_9 = anglesToForward((0, var_8.angles[1], 0));
      var_10 = vectordot(var_6, var_9);

      if(var_10 < 0.9) {
        continue;
      }
      var_5._id_0F7A = spawn("script_origin", var_8.origin);
      var_5._id_0F7A.angles = var_8.angles;
      var_5._id_0F7A.node = var_5;
      var_5._id_0F7A.leftarc = 45;
      var_5._id_0F7A.rightarc = 45;
      var_5._id_0F7A.toparc = 15;
      var_5._id_0F7A.bottomarc = 15;

      if(isDefined(var_8.leftarc)) {
        var_5._id_0F7A.leftarc = min(var_8.leftarc, 45);
      }
      if(isDefined(var_8.rightarc)) {
        var_5._id_0F7A.rightarc = min(var_8.rightarc, 45);
      }
      if(isDefined(var_8.toparc)) {
        var_5._id_0F7A.toparc = min(var_8.toparc, 15);
      }
      if(isDefined(var_8.bottomarc)) {
        var_5._id_0F7A.bottomarc = min(var_8.bottomarc, 15);
      }
      var_2[var_11] = undefined;
      var_8 delete();
    }
  }
}

_id_1F06(var_0) {
  var_1 = getEntArray("misc_turret", "code_classname");
  var_2 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    if(!isDefined(var_1[var_3].targetname) || tolower(var_1[var_3].targetname) != "auto_mgturret") {
      continue;
    }
    if(!isDefined(var_1[var_3].export)) {
      continue;
    }
    if(!isDefined(var_1[var_3]._id_22B0)) {
      var_2[var_1[var_3].origin + ""] = var_1[var_3];
    }
  }

  if(!var_2.size) {
    return;
  }
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = var_0[var_4];

    if(var_5.type == "Path") {
      continue;
    }
    if(var_5.type == "Begin") {
      continue;
    }
    if(var_5.type == "End") {
      continue;
    }
    var_6 = anglesToForward((0, var_5.angles[1], 0));
    var_7 = getarraykeys(var_2);

    for(var_3 = 0; var_3 < var_7.size; var_3++) {
      var_8 = var_2[var_7[var_3]];

      if(distance(var_5.origin, var_8.origin) > 70) {
        continue;
      }
      var_9 = anglesToForward((0, var_8.angles[1], 0));
      var_10 = vectordot(var_6, var_9);

      if(var_10 < 0.9) {
        continue;
      }
      var_5._id_0A50 = var_8;
      var_8.node = var_5;
      var_8._id_0FA8 = 1;
      var_2[var_7[var_3]] = undefined;
    }
  }

  var_0 = undefined;
}

_id_22B1() {
  self._id_22B2 = [];
  self._id_22B2["connected"] = [];
  self._id_22B2["ambush"] = [];

  if(!isDefined(self.export)) {
    return;
  }
  level._id_1E9F[self.export] = self;

  if(isDefined(self._id_22B3)) {
    var_0 = strtok(self._id_22B3, " ");

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      self._id_22B2["connected"][var_0[var_1]] = 1;
    }
  }

  if(isDefined(self._id_22B4)) {
    var_0 = strtok(self._id_22B4, " ");

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      self._id_22B2["ambush"][var_0[var_1]] = 1;
    }
  }
}

_id_22B5() {
  self notify("gun_placed_again");
  self endon("gun_placed_again");
  self waittill("restore_default_drop_pitch");
  wait 1;
  self restoredefaultdroppitch();
}

_id_114C() {
  thread _id_22B6();
}

_id_22B6() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0.origin = self gettagorigin(level._id_210B);
  var_0.angles = self gettagangles(level._id_210B);
  var_0 setModel(self._id_22B7);
  var_1 = anglesToForward(self.angles);
  var_1 = var_1 * 100;
  var_0 movegravity(var_1, 0.5);
  self detach(self._id_22B7, level._id_210B);
  self._id_22B7 = undefined;
  wait 0.7;
  var_0 delete();
}

_id_22B8() {
  self endon("kill_turret_detach_thread");
  self endon("dropped_gun");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  _id_114C();
}

_id_22B9() {
  self endon("death");
  self endon("kill_turret_detach_thread");
  self waittill("dropped_gun");
  self detach(self._id_22B7, level._id_210B);
}

_id_114E() {
  self._id_0FBC = undefined;
  common_scripts\utility::set_all_exceptions(animscripts\init::_id_20C0);
}

_id_22BA() {
  self waittill("turret_deactivate");
  self restoredefaultdroppitch();
}

_id_22BB(var_0) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");

  for(;;) {
    self waittill("saw_enemy");
    var_0.origin = self._id_0A4B;
  }
}

_id_22BC(var_0, var_1) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var_2 = self._id_0A50.origin + (0, 0, 16);
  var_3 = var_1.origin + (0, 0, 16);

  for(;;) {
    wait 0.05;

    if(sighttracepassed(var_0.origin, var_3, 0, undefined)) {
      continue;
    }
    var_4 = vectortoangles(var_2 - var_0.origin);
    var_5 = anglesToForward(var_4);
    var_5 = var_5 * 8;
    var_0.origin = var_0.origin + var_5;
  }
}

_id_22BD(var_0) {
  self endon("death");
  self endon("end_mg_behavior");
  self endon("stop_updating_enemy_target_pos");
  var_0._id_22BE = [];

  for(;;) {
    var_0._id_22BE[var_0._id_22BE.size] = self.origin + (0, 0, 50);
    wait 0.35;
  }
}

_id_22BF(var_0, var_1) {
  if(!isalive(self._id_0A4C) && self cansee(self._id_0A4C)) {
    var_1.origin = self._id_0A4B;
    return;
  }

  var_2 = anglesToForward(var_0.angles);

  for(var_3 = var_1._id_22BE.size - 3; var_3 >= 0; var_3--) {
    var_4 = var_1._id_22BE[var_3];
    var_5 = vectornormalize(var_4 - var_0.origin);
    var_6 = vectordot(var_2, var_5);

    if(var_6 < 0.75) {
      continue;
    }
    var_1.origin = var_4;

    if(sighttracepassed(var_0.origin, var_4, 0, undefined)) {
      continue;
    }
    break;
  }
}

_id_22C0(var_0) {
  var_1 = _id_22CD(var_0);
  var_2 = var_1["spot"];
  var_3 = var_1["type"];

  if(!isDefined(var_2)) {
    return;
  }
  _id_22DA(var_2);
  thread _id_22BB(var_0);
  thread _id_22BC(var_0, var_2);

  if(var_3 == "ambush") {
    thread _id_22BD(var_0);
  }
  if(var_2._id_0FA8) {
    _id_22C2(var_2);
  } else {
    _id_22C3(var_2);
    _id_22C5(var_2);
  }

  self notify("stop_updating_enemy_target_pos");

  if(var_3 == "ambush") {
    _id_22BF(var_2, var_0);
  }
  var_2 settargetentity(var_0);
}

_id_22C1(var_0) {
  var_0 setmode("manual");
  wait 0.5;
  var_0 setmode("manual_ai");
}

_id_22C2(var_0) {
  self stopuseturret();
  animscripts\shared::_id_0C9B(self.primaryweapon, "none");
  var_1 = _id_22C4(var_0);
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1);
  self setruntopos(var_2);
  self waittill("runto_arrived");
  _id_0A4A(var_0);
}

_id_22C3(var_0) {
  self stopuseturret();
  self._id_0A50 _id_22D3();
}

_id_22C4(var_0) {
  var_1 = [];
  var_1["saw_bipod_stand"] = level._id_0D3D["bipod_stand_setup"];
  var_1["saw_bipod_crouch"] = level._id_0D3D["bipod_crouch_setup"];
  var_1["saw_bipod_prone"] = level._id_0D3D["bipod_prone_setup"];
  return var_1[var_0.weaponinfo];
}

#using_animtree("generic_human");

_id_22C5(var_0) {
  var_1 = self.health;
  var_0 endon("turret_deactivate");
  self._id_22C6 = var_0;
  self endon("death");
  self endon("dropped_gun");
  var_2 = _id_22C4(var_0);
  self._id_22B7 = "weapon_mg42_carry";
  self notify("kill_get_gun_back_on_killanimscript_thread");
  animscripts\shared::_id_0C9B(self.weapon, "none");

  if(self isbadguy()) {
    self.health = 1;
  }
  self._id_0FBC = % saw_gunner_run_fast;
  self._id_0FC0 = % saw_gunner_run_fast;
  self attach(self._id_22B7, level._id_210B);
  thread _id_22B8();
  var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
  self setruntopos(var_3);
  wait 0.05;
  common_scripts\utility::set_all_exceptions(animscripts\combat::_id_114F);
  common_scripts\utility::clear_exception("move");
  common_scripts\utility::set_exception("cover_crouch", ::_id_22C9);

  while(distance(self.origin, var_3) > 16) {
    self setruntopos(var_3);
    wait 0.05;
  }

  self notify("kill_turret_detach_thread");

  if(self isbadguy()) {
    self.health = var_1;
  }
  if(soundexists("weapon_setup")) {
    thread common_scripts\utility::play_sound_in_space("weapon_setup");
  }
  self animscripted("setup_done", var_0.origin, var_0.angles, var_2);
  _id_114E();
  self waittillmatch("setup_done", "end");
  var_0 notify("restore_default_drop_pitch");
  var_0 _id_22D5();
  animscripts\shared::_id_0C9B(self.primaryweapon, "right");
  _id_0A4A(var_0);
  self detach(self._id_22B7, level._id_210B);
  common_scripts\utility::set_all_exceptions(animscripts\init::_id_20C0);
  self notify("bcs_portable_turret_setup");
}

_id_22C7() {
  self setruntopos(self._id_22C8);
}

_id_22C9() {
  self endon("killanimscript");
  self waittill("death");
}

_id_22CA() {
  if(!isDefined(self._id_0A50)) {
    return 0;
  }
  return self._id_0A50.owner == self;
}

_id_22CB() {
  if(!_id_22CA()) {
    common_scripts\utility::clear_exception("move");
    return;
  }

  var_0 = _id_22CF("connected");
  var_1 = var_0["spots"];

  if(!var_1.size) {
    common_scripts\utility::clear_exception("move");
    return;
  }

  var_2 = self.node;

  if(!isDefined(var_2) || !maps\_utility::is_in_array(var_1, var_2)) {
    var_3 = _id_22CE();

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_2 = common_scripts\utility::random(var_1);

      if(isDefined(var_3[var_2.origin + ""])) {
        return;
      }
    }
  }

  var_5 = var_2._id_0A50;

  if(isDefined(var_5._id_2272)) {
    return;
  }
  _id_22DA(var_5);

  if(var_5._id_0FA8) {
    _id_22C2(var_5);
  } else {
    _id_22C5(var_5);
  }
  maps\_mg_penetration::_id_0A47(var_2._id_0A50);
}

_id_0A4A(var_0) {
  var_1 = self useturret(var_0);

  if(var_1) {
    common_scripts\utility::set_exception("move", ::_id_22CB);
    self._id_0A50 = var_0;
    thread _id_21BC(var_0);
    var_0 setmode("manual_ai");
    var_0 thread _id_22BA();
    self._id_0A50 = var_0;
    var_0.owner = self;
    return 1;
  } else {
    var_0 restoredefaultdroppitch();
    return 0;
  }
}

_id_22CD(var_0) {
  var_1 = [];
  var_1[var_1.size] = ::_id_22D1;
  var_1[var_1.size] = ::_id_22D0;
  var_1 = maps\_utility::_id_0B53(var_1);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = [[var_1[var_2]]](var_0);

    if(!isDefined(var_3["spots"])) {
      continue;
    }
    var_3["spot"] = common_scripts\utility::random(var_3["spots"]);
    return var_3;
  }
}

_id_22CE() {
  var_0 = [];
  var_1 = getaiarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(!isDefined(var_1[var_2].node)) {
      continue;
    }
    var_0[var_1[var_2].node.origin + ""] = 1;
  }

  return var_0;
}

_id_22CF(var_0) {
  var_1 = level._id_1E9F;
  var_2 = [];
  var_3 = getarraykeys(var_1);
  var_4 = _id_22CE();
  var_4[self.node.origin + ""] = undefined;

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    var_6 = var_3[var_5];

    if(var_1[var_6] == self._id_0A50) {
      continue;
    }
    var_7 = getarraykeys(self._id_0A50._id_22B2[var_0]);

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_1[var_6].export+"" != var_7[var_8]) {
        continue;
      }
      if(isDefined(var_1[var_6]._id_2272)) {
        continue;
      }
      if(isDefined(var_4[var_1[var_6].node.origin + ""])) {
        continue;
      }
      if(distance(self.goalpos, var_1[var_6].origin) > self.goalradius) {
        continue;
      }
      var_2[var_2.size] = var_1[var_6];
    }
  }

  var_9 = [];
  var_9["type"] = var_0;
  var_9["spots"] = var_2;
  return var_9;
}

_id_22D0(var_0) {
  return _id_22CF("ambush");
}

_id_22D1(var_0) {
  var_1 = _id_22CF("connected");
  var_2 = var_1["spots"];

  if(!var_2.size) {
    return;
  }
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(!maps\_utility::within_fov(var_2[var_4].origin, var_2[var_4].angles, var_0.origin, 0.75)) {
      continue;
    }
    if(!sighttracepassed(var_0.origin, var_2[var_4].origin + (0, 0, 16), 0, undefined)) {
      continue;
    }
    var_3[var_3.size] = var_2[var_4];
  }

  var_1["spots"] = var_3;
  return var_1;
}

_id_22D2() {
  _id_22B1();
  var_0 = 1;
  self._id_0FA8 = 1;
  self._id_2272 = undefined;

  if(isDefined(self._id_22AF)) {
    return;
  }
  if(self.spawnflags &var_0) {
    return;
  }
  _id_22D3();
}

_id_22D3() {
  self notify("stop_checking_for_flanking");
  self._id_0FA8 = 0;
  self hide();
  self._id_22D4 = 0;
  self makeunusable();
  self setdefaultdroppitch(0);
  thread _id_22B5();
}

_id_22D5() {
  self show();
  self._id_22D4 = 1;
  self makeusable();
  self._id_0FA8 = 1;
  thread _id_22D6();
}

_id_22D6() {
  self endon("stop_checking_for_flanking");
  self waittill("turret_deactivate");

  if(isalive(self.owner)) {
    self.owner notify("end_mg_behavior");
  }
}

_id_22D7(var_0) {
  var_1 = var_0 getturretowner();

  if(!isDefined(var_1)) {
    return 0;
  }
  return var_1 == self;
}

_id_22D8(var_0) {
  _id_22D9(var_0);
  var_0._id_2272 = undefined;
}

_id_22D9(var_0) {
  var_0 endon("turret_deactivate");
  self endon("death");
  self waittill("end_mg_behavior");
}

_id_22DA(var_0) {
  var_0._id_2272 = self;
  thread _id_22D8(var_0);
}