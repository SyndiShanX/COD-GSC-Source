/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\jake_tools.gsc
***************************************/

_id_4840(var_0, var_1) {
  var_2 = newhudelem();
  var_2.x = 0;
  var_2.y = 0;
  var_2 setshader(var_0, 640, 480);
  var_2.alignx = "left";
  var_2.aligny = "top";
  var_2.sort = 1;
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2.alpha = var_1;
  var_2.foreground = 1;
  return var_2;
}

_id_4841() {
  self hide();
  self notsolid();

  if(self.spawnflags & 1) {
    self connectpaths();
  }
}

_id_4842(var_0) {
  if(!isDefined(var_0)) {
    var_0 = getEntArray("hide", "script_noteworthy");

  }
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    switch (var_2.classname) {
      case "script_vehicle":
        var_2 delete();
        break;
      case "script_model":
        var_2 hide();
        break;
      case "script_brushmodel":
        var_2 hide();
        var_2 notsolid();

        if(var_2.spawnflags & 1) {
          var_2 connectpaths();

        }
        break;
      case "trigger_multiple_flag_looking":
      case "trigger_multiple_flag_lookat":
      case "trigger_multiple_breachIcon":
      case "trigger_multiple_flag_set":
      case "trigger_use_touch":
      case "trigger_use":
      case "trigger_multiple":
      case "trigger_radius":
        var_2 common_scripts\utility::trigger_off();
        break;
    }
  }
}

_id_4843(var_0, var_1) {
  self endon("death");
  var_1 = int(var_1 * 1000);
  var_2 = gettime();
  var_3 = gettime();

  while(var_3 < var_2 + var_1) {
    wait 0.05;
    var_3 = gettime();
    self notify(var_0);
  }

  self notify("ai_notify_complete");
}

_id_4844(var_0) {
  var_1 = [];
  var_2 = self;
  var_3 = 0;

  while(isDefined(var_2.target)) {
    wait 0.05;

    if(isDefined(var_2.target)) {
      switch (var_0) {
        case "vehiclenode":
          var_2 = getvehiclenode(var_2.target, "targetname");
          break;
        case "pathnode":
          var_2 = getnode(var_2.target, "targetname");
          break;
        case "ent":
          var_2 = getent(var_2.target, "targetname");
          break;
        default:
      }

      var_1[var_1.size] = var_2;
      continue;
    }

    break;
  }

  if(var_1.size > 0) {
    return var_1;
  } else {
    return undefined;
  }
}

_id_4845(var_0, var_1) {
  level endon(var_0);
  wait(var_1);
}

_id_4846(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = getaiarray(var_2);
  } else {
    var_3 = getaiarray();

  }
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    if(distance(var_1, self.origin) <= var_0) {
      maps\_utility::_id_0BC3(var_4, var_3[var_5]);
    }
  }

  return var_4;
}

_id_4847(var_0) {
  self endon("death");

  if(isDefined(self) && isalive(self) && maps\_utility::_id_27E2()) {
    maps\_utility::_id_23BB(var_0);
  }
}

_id_4848(var_0) {
  self forceteleport(var_0.origin, var_0.angles);
  self setgoalpos(self.origin);
  self setgoalnode(var_0);
}

_id_4357(var_0, var_1) {
  for(;;) {
    if(distance(var_0, level.player.origin) <= var_1) {
      break;
    }

    wait 0.5;
  }
}

_id_4849(var_0, var_1) {
  var_2 = getvehiclenode(var_0, "targetname");
  var_3 = "";

  switch (var_1) {
    case "truck":
      var_3 = "vehicle_pickup_4door";
      break;
    case "bmp":
      var_3 = "vehicle_bmp";
      break;
    default:
  }

  var_4 = spawnvehicle(var_3, "plane", "truck", var_2.origin, var_2.angles);

  if(var_1 == "truck") {
    var_4 _id_484A();

  }
  var_4 attachpath(var_2);
  var_4 startpath();
  var_4 vehicle_setspeed(23, 20);
  var_4 waittill("reached_end_node");
  var_4 delete();
}

_id_484A() {
  playFXOnTag(level._effect["headlight_truck"], self, "tag_headlight_left");
  playFXOnTag(level._effect["headlight_truck"], self, "tag_headlight_right");
}

_id_484B(var_0, var_1) {
  self endon("death");

  if(isDefined(var_0)) {
    var_1 = getent(var_0, "targetname");

  }
  var_2 = getnode(var_1.target, "targetname");
  self._id_484C = var_1;
  self setgoalnode(var_2);
  self.goalradius = var_2.radius;
  self setgoalvolume(var_1);
}

_id_484D(var_0) {
  self endon("death");

  while(!self istouching(var_0)) {
    wait 0.05;
  }
}

_id_484E() {
  self endon("death");
  self setgoalpos(self.origin);
  self._id_484C = undefined;
}

_id_484F(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isDefined(var_2)) {
    var_2 = 0.25;

  }
  if(!isDefined(var_3)) {
    var_3 = 0;

  }
  if(!isDefined(var_1)) {
    self notify("stop_3dprint");
    self endon("stop_3dprint");
    self endon("death");

    for(;;) {
      if(isDefined(self)) {}

      wait 0.05;
    }
  } else {
    for(;;) {
      wait 0.05;
    }
  }
}

_id_4850() {
  self endon("smoke_has_been_thrown");
  self._id_4851 = 0;

  while(self._id_4851 == 0) {
    wait 0.05;
    var_0 = getEntArray("grenade", "classname");

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(var_0[var_1].model == "projectile_us_smoke_grenade") {
        if(var_0[var_1] istouching(self)) {
          self._id_4851 = 1;
          self notify("smoke_has_been_thrown");
        }
      }
    }
  }
}

_id_4852(var_0) {
  self endon("death");
  maps\_utility::_id_168C(var_0);
}

_id_4853(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(var_1.size == 1) {
    _id_4855(var_0);
  } else {
    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_1[var_2] thread _id_4854(var_1);

    }
    var_1[0] waittill("trigger");
  }
}

_id_4854(var_0) {
  self waittill("trigger");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] notify("trigger");
    var_0[var_1] common_scripts\utility::trigger_off();
  }
}

_id_4855(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");
  var_1 common_scripts\utility::trigger_off();
}

_id_4856(var_0, var_1, var_2) {
  var_3 = getEntArray(var_0, var_1);

  if(var_2 == 1) {
    common_scripts\utility::array_thread(var_3, common_scripts\utility::trigger_on);
  } else {
    common_scripts\utility::array_thread(var_3, common_scripts\utility::trigger_off);
  }
}

_id_4857(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 notify("trigger", level.player);
  var_1 common_scripts\utility::trigger_off();
}

_id_4858() {}

_id_4859(var_0) {
  var_1 = vectortoangles(self.origin - var_0.origin);
  self setpotentialthreat(var_1[1]);
}

_id_485A(var_0) {
  if(!isDefined(self._id_485B)) {
    self._id_485B = self.threatbias;

  }
  self.threatbias = var_0;
}

_id_485C() {
  if(isDefined(self._id_485B)) {
    self.threatbias = self._id_485B;

  }
  self._id_485B = undefined;
}

_id_485D(var_0) {
  if(!isDefined(self._id_2802)) {
    self._id_2802 = self.walkdist;

  }
  self.walkdist = var_0;
}

_id_485E() {
  if(isDefined(self._id_2802)) {
    self.walkdist = self._id_2802;

  }
  self._id_2802 = undefined;
}

_id_485F(var_0) {
  self._id_4860 = self.health;
  self.health = var_0;
}

_id_4861() {
  if(isDefined(self._id_4860)) {
    self.health = self._id_4860;
  }
}

_id_4862(var_0) {
  if(!isDefined(self._id_404B)) {
    self._id_404B = self._id_1032;

  }
  self._id_1032 = var_0;
}

_id_4863() {
  if(isDefined(self._id_404B)) {
    self._id_1032 = self._id_404B;

  }
  self._id_404B = undefined;
}

_id_4864(var_0) {
  if(!isDefined(self._id_4865)) {
    self._id_4865 = self.maxsightdistsqrd;

  }
  self.maxsightdistsqrd = var_0;
}

_id_4866() {
  if(isDefined(self._id_4865)) {
    self.maxsightdistsqrd = self._id_4865;

  }
  self._id_4865 = undefined;
}

_id_4867(var_0) {
  if(!threatbiasgroupexists(var_0)) {}

  if(!isDefined(self._id_4868)) {
    self._id_4868 = self._id_4869;

  }
  self._id_4869 = var_0;
  self setthreatbiasgroup(var_0);
}

_id_486A() {
  if(isDefined(self._id_4868)) {
    self._id_4869 = self._id_4868;
    self setthreatbiasgroup(self._id_4868);

    if(!threatbiasgroupexists(self._id_4868)) {}
  } else {
    self._id_4869 = undefined;
    self setthreatbiasgroup();
  }

  self._id_4868 = undefined;
}

_id_486B(var_0) {
  if(!isDefined(self._id_4048)) {
    self._id_4048 = self.goalradius;

  }
  self.goalradius = var_0;
}

_id_486C() {
  if(isDefined(self._id_4048)) {
    self.goalradius = self._id_4048;

  }
  self._id_4048 = undefined;
}

_id_486D(var_0) {
  if(!isDefined(self._id_2071)) {
    self._id_2071 = self.interval;

  }
  self.interval = var_0;
}

_id_486E() {
  if(isDefined(self._id_2071)) {
    self.interval = self._id_2071;

  }
  self._id_2071 = undefined;
}

_id_486F(var_0) {
  if(!isDefined(self._id_42D0)) {
    self._id_42D0 = self._id_20AF;

  }
  self._id_20AF = var_0;
}

_id_4870() {
  if(isDefined(self._id_42D0)) {
    self._id_20AF = self._id_42D0;

  }
  self._id_42D0 = undefined;
}

_id_4871(var_0) {
  var_1 = undefined;

  if(!isDefined(var_0)) {
    var_2 = level.player getorigin();
  } else {
    var_2 = var_0 getorigin();

  }
  if(isDefined(level._id_4872)) {
    var_1 = maps\_utility::_id_2288(var_2, "allies", level._id_4872);
  } else {
    var_1 = maps\_utility::_id_1EE9(var_2, "allies");

  }
  return var_1;
}

_id_4873() {
  var_0 = maps\_utility::_id_1EE9(level.player getorigin(), "axis");
  return var_0;
}

_id_4874(var_0, var_1) {
  var_2 = getnodearray(var_1, "targetname");

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isDefined(var_2[var_3])) {
      var_0[var_3] teleport(var_2[var_3].origin);
    }
  }
}

_id_4875(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = getent(var_1, "targetname");

  }
  if(var_0 == "all") {
    var_3 = getaiarray();
  } else {
    var_3 = getaiarray(var_0);

  }
  var_4 = [];

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    if(var_3[var_5] istouching(var_2)) {
      var_4[var_4.size] = var_3[var_5];
    }
  }

  return var_4;
}

_id_4876(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = [];
    var_3[0] = level._id_4877;
  }

  var_4 = getent(var_0, "targetname");

  if(!isDefined(var_2)) {
    var_2 = 0;

  }
  var_5 = undefined;

  if(var_1 == "all") {
    var_5 = getaiarray();
  } else {
    var_5 = getaiarray(var_1);

  }
  if(isDefined(var_3)) {
    for(var_6 = 0; var_6 < var_3.size; var_6++) {
      if(maps\_utility::is_in_array(var_5, var_3[var_6])) {
        var_5 = common_scripts\utility::array_remove(var_5, var_3[var_6]);
      }
    }
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(var_5[var_6] istouching(var_4)) {
      var_5[var_6] _id_487F(0);

      if(var_2 == 1) {
        var_5[var_6] kill((0, 0, 0));
        continue;
      }

      var_5[var_6] delete();
    }
  }
}

_id_4878(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isDefined(var_0[var_3].script_noteworthy) && var_0[var_3].script_noteworthy == var_1) {
      var_2 = var_0[var_3];
    }
  }

  return var_2;
}

_id_4879(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_1)) {
    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      if(isDefined(var_0[var_3].script_noteworthy) && var_0[var_3].script_noteworthy == var_1) {
        var_2[var_2.size] = var_0[var_3];
      }
    }
  } else {}

  if(var_2.size > 0) {
    return var_2;
  } else {
    return undefined;
  }
}

_id_487A(var_0) {
  self endon("death");
  var_1 = getnode(var_0, "targetname");
  _id_486B(var_1.radius);
  self setgoalnode(var_1);
  self waittill("goal");
  _id_486C();
}

_id_487B(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  var_1 = getnode(var_0, "targetname");
  self setgoalnode(var_1);
  _id_486B(var_1.radius);
  self waittill("goal");
  self delete();
}

_id_487C(var_0) {
  if(!isDefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  var_1 = getnode(var_0, "targetname");
  self setgoalnode(var_1);
  _id_486B(var_1.radius);
  self waittill("goal");
  _id_4862("guy");
  self waittill("stop_waiting_at_node");
  _id_486C();
}

_id_487D(var_0) {
  self endon("death");
  var_1 = getnode(var_0, "targetname");
  self pushplayer(1);
  self setgoalnode(var_1);
  self waittill("goal");
  self pushplayer(0);
  _id_486C();
}

_id_487E(var_0) {
  if(var_0 == "all") {
    self allowedstances("stand", "crouch", "prone");
  } else {
    self allowedstances(var_0);
  }
}

_id_487F(var_0) {
  if(var_0 == 0) {
    if(isDefined(self._id_0D04)) {
      maps\_utility::_id_1902();
    }
  } else if(!isDefined(self._id_0D04)) {
    thread maps\_utility::_id_0D04();

  }
  self.a._id_0D11 = var_0;
}

_id_4880() {
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self.allowdeath = 1;
  _id_487F(0);
  self kill();
}

_id_4881(var_0) {
  self endon("death");
  var_1 = getent(var_0, "targetname");
  var_2 = getnode(var_1.target, "targetname");
  self setgoalnode(var_2);
  self setgoalvolume(var_1);
  self.goalradius = var_2.radius;
}

_id_4882() {}

_id_4883() {}

_id_4042(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 1;

  }
  if(!isDefined(var_2)) {
    var_2 = 1;

  }
  if(var_1 == 1) {
    self playSound(level.scr_sound["snd_wood_door_kick"]);

  }
  if(self.classname == "script_brushmodel") {
    var_3 = getent(self.target, "targetname");
  } else {
    var_4 = getent(self.target, "targetname");
    var_3 = getent(var_4.script_linkto, "script_linkname");
  }

  switch (var_0) {
    case "explosive":
      thread _id_4046();
      _id_4045(var_2);
      self playSound(level.scr_sound["snd_breach_wooden_door"]);
      earthquake(0.4, 1, self.origin, 1000);
      radiusdamage(self.origin, 56, level._id_4044, level._id_4043);
      break;
    case "kicked":
      self rotateyaw(-175, 0.5);
      _id_4045(var_2);
      break;
    case "kicked_down":
      thread _id_4046();
      _id_4045(var_2);
      break;
    default:
      self rotateyaw(-175, 0.5);
      _id_4045();
      break;
  }

  var_5 = var_3.script_exploder;
  common_scripts\utility::exploder(var_5);
}

_id_4045(var_0) {
  if(self.classname == "script_brushmodel") {
    self connectpaths();
  } else {
    var_1 = getent(self.target, "targetname");
    var_1 hide();
    var_1 notsolid();
    var_1 connectpaths();
  }
}

_id_4046() {
  var_0 = anglesToForward(self.angles);
  var_1 = (var_0[0] * 20, var_0[1] * 20, var_0[2] * 20);
  self moveto(self.origin + var_1, 0.5, 0, 0.5);
  self rotatepitch(90, 0.45, 0.4);
  wait 0.449;
  self rotatepitch(-4, 0.2, 0, 0.2);
  wait 0.2;
  self rotatepitch(4, 0.15, 0.15);
}

debug_circle(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 16;
  var_7 = 360 / var_6;
  var_8 = [];

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_7 * var_9;
    var_11 = cos(var_10) * var_1;
    var_12 = sin(var_10) * var_1;
    var_13 = var_0[0] + var_11;
    var_14 = var_0[1] + var_12;
    var_15 = var_0[2];
    var_8[var_8.size] = (var_13, var_14, var_15);
  }

  if(isDefined(var_4)) {
    wait(var_4);

  }
  thread debug_circle_drawlines(var_8, var_2, var_3, var_5, var_0);
}

debug_circle_drawlines(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 0;

  }
  if(!isDefined(var_4)) {
    var_3 = 0;

  }
  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_5 + 1 >= var_0.size) {
      var_7 = var_0[0];
    } else {
      var_7 = var_0[var_5 + 1];

    }
    thread debug_line(var_6, var_7, var_1, var_2);

    if(var_3) {
      thread debug_line(var_4, var_6, var_1, var_2);
    }
  }
}

debug_line(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = (1, 1, 1);

  }
  for(var_4 = 0; var_4 < var_2 * 20; var_4++) {
    wait 0.05;
  }
}