/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\jake_tools.gsc
********************************/

create_overlay_element(var_0, var_1) {
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

hide_geo() {
  self hide();
  self notsolid();

  if(self.spawnflags & 1)
    self connectpaths();
}

hideall(var_0) {
  if(!isdefined(var_0))
    var_0 = getentarray("hide", "script_noteworthy");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
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

        if(var_2.spawnflags & 1)
          var_2 connectpaths();

        break;
      case "trigger_multiple_flag_looking":
      case "trigger_multiple_flag_lookat":
      case "trigger_multiple_breachIcon":
      case "trigger_multiple_flag_set":
      case "trigger_use_touch":
      case "trigger_use":
      case "trigger_radius":
      case "trigger_multiple":
        var_2 common_scripts\utility::trigger_off();
        break;
    }
  }
}

ai_notify(var_0, var_1) {
  self endon("death");
  var_1 = int(var_1 * 1000);
  var_2 = gettime();
  var_3 = gettime();

  while (var_3 < var_2 + var_1) {
    wait 0.05;
    var_3 = gettime();
    self notify(var_0);
  }

  self notify("ai_notify_complete");
}

get_all_ents_in_chain(var_0) {
  var_1 = [];
  var_2 = self;
  var_3 = 0;

  while (isdefined(var_2.target)) {
    wait 0.05;

    if(isdefined(var_2.target)) {
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

  if(var_1.size > 0)
    return var_1;
  else
    return undefined;
}

wait_for_level_notify_or_timeout(var_0, var_1) {
  level endon(var_0);
  wait(var_1);
}

get_ai_within_radius(var_0, var_1, var_2) {
  if(isdefined(var_2))
    var_3 = getaiarray(var_2);
  else
    var_3 = getaiarray();

  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    if(distance(var_1, self.origin) <= var_0)
      common_scripts\utility::array_add(var_4, var_3[var_5]);
  }

  return var_4;
}

ai_stun(var_0) {
  self endon("death");

  if(isdefined(self) && isalive(self) && maps\_utility::flashbangisactive())
    maps\_utility::flashbangstart(var_0);
}

start_teleport(var_0) {
  self forceteleport(var_0.origin, var_0.angles);
  self setgoalpos(self.origin);
  self setgoalnode(var_0);
}

waittill_player_in_range(var_0, var_1) {
  for (;;) {
    if(distance(var_0, level.player.origin) <= var_1) {
      break;
    }

    wait 0.5;
  }
}

vehicle_go_to_end_and_delete(var_0, var_1) {
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

  if(var_1 == "truck")
    var_4 truck_headlights_on();

  var_4 attachpath(var_2);
  var_4 startpath();
  var_4 vehicle_setspeed(23, 20);
  var_4 waittill("reached_end_node");
  var_4 delete();
}

truck_headlights_on() {
  playfxontag(level._effect["headlight_truck"], self, "tag_headlight_left");
  playfxontag(level._effect["headlight_truck"], self, "tag_headlight_right");
}

set_goalvolume(var_0, var_1) {
  self endon("death");

  if(isdefined(var_0))
    var_1 = getent(var_0, "targetname");

  var_2 = getnode(var_1.target, "targetname");
  self.goalvolume = var_1;
  self setgoalnode(var_2);
  self.goalradius = 0;

  if(isdefined(var_2.radius))
    self.goalradius = var_2.radius;

  self setgoalpos(var_1.origin);
  self setgoalvolume(var_1);
}

waittill_touching_entity(var_0) {
  self endon("death");

  while (!self istouching(var_0))
    wait 0.05;
}

reset_goalvolume() {
  self endon("death");
  self setgoalpos(self.origin);
  self.goalvolume = undefined;
}

print3dthread(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!isdefined(var_2))
    var_2 = 0.25;

  if(!isdefined(var_3))
    var_3 = 0;

  if(!isdefined(var_1)) {
    self notify("stop_3dprint");
    self endon("stop_3dprint");
    self endon("death");

    for (;;) {
      if(isdefined(self)) {

      }

      wait 0.05;
    }
  } else {
    for (;;)
      wait 0.05;
  }
}

smoke_detect() {
  self endon("smoke_has_been_thrown");
  self.smokethrown = 0;

  while (self.smokethrown == 0) {
    wait 0.05;
    var_0 = getentarray("grenade", "classname");

    for (var_1 = 0; var_1 < var_0.size; var_1++) {
      if(var_0[var_1].model == "projectile_us_smoke_grenade") {
        if(var_0[var_1] istouching(self)) {
          self.smokethrown = 1;
          self notify("smoke_has_been_thrown");
        }
      }
    }
  }
}

dialogue_execute(var_0) {
  self endon("death");
  maps\_utility::dialogue_queue(var_0);
}

trigarraywait(var_0) {
  var_1 = getentarray(var_0, "targetname");

  if(var_1.size == 1)
    trigwait(var_0);
  else {
    for (var_2 = 0; var_2 < var_1.size; var_2++)
      var_1[var_2] thread trigarraywait2(var_1);

    var_1[0] waittill("trigger");
  }
}

trigarraywait2(var_0) {
  self waittill("trigger");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] notify("trigger");
    var_0[var_1] common_scripts\utility::trigger_off();
  }
}

trigwait(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 waittill("trigger");
  var_1 common_scripts\utility::trigger_off();
}

triggersenable(var_0, var_1, var_2) {
  var_3 = getentarray(var_0, var_1);

  if(var_2 == 1)
    common_scripts\utility::array_thread(var_3, common_scripts\utility::trigger_on);
  else
    common_scripts\utility::array_thread(var_3, common_scripts\utility::trigger_off);
}

triggeractivate(var_0) {
  var_1 = getent(var_0, "targetname");
  var_1 notify("trigger", level.player);
  var_1 common_scripts\utility::trigger_off();
}

aa_ai_functions() {}

look_at_position(var_0) {
  var_1 = vectortoangles(self.origin - var_0.origin);
  self setpotentialthreat(var_1[1]);
}

set_threatbias(var_0) {
  if(!isdefined(self.old_threatbias))
    self.old_threatbias = self.threatbias;

  self.threatbias = var_0;
}

set_walkdist(var_0) {
  if(!isdefined(self.old_walkdist))
    self.old_walkdist = self.walkdist;

  self.walkdist = var_0;
}

reset_walkdist() {
  if(isdefined(self.old_walkdist))
    self.walkdist = self.old_walkdist;

  self.old_walkdist = undefined;
}

set_health(var_0) {
  self.old_health = self.health;
  self.health = var_0;
}

reset_health() {
  if(isdefined(self.old_health))
    self.health = self.old_health;
}

set_animname(var_0) {
  if(!isdefined(self.old_animname))
    self.old_animname = self.animname;

  self.animname = var_0;
}

reset_animname() {
  if(isdefined(self.old_animname))
    self.animname = self.old_animname;

  self.old_animname = undefined;
}

set_maxsightdistsqrd(var_0) {
  if(!isdefined(self.old_maxsightdistsqrd))
    self.old_maxsightdistsqrd = self.maxsightdistsqrd;

  self.maxsightdistsqrd = var_0;
}

reset_maxsightdistsqrd() {
  if(isdefined(self.old_maxsightdistsqrd))
    self.maxsightdistsqrd = self.old_maxsightdistsqrd;

  self.old_maxsightdistsqrd = undefined;
}

set_threatbiasgroup(var_0) {
  if(!threatbiasgroupexists(var_0)) {}

  if(!isdefined(self.old_threatbiasgroupname))
    self.old_threatbiasgroupname = self.threatbiasgroupname;

  self.threatbiasgroupname = var_0;
  self setthreatbiasgroup(var_0);
}

reset_threatbiasgroup() {
  if(isdefined(self.old_threatbiasgroupname)) {
    self.threatbiasgroupname = self.old_threatbiasgroupname;
    self setthreatbiasgroup(self.old_threatbiasgroupname);

    if(!threatbiasgroupexists(self.old_threatbiasgroupname)) {

    }
  } else {
    self.threatbiasgroupname = undefined;
    self setthreatbiasgroup();
  }

  self.old_threatbiasgroupname = undefined;
}

setgoalradius(var_0) {
  if(!isdefined(self.old_goalradius))
    self.old_goalradius = self.goalradius;

  self.goalradius = var_0;
}

resetgoalradius() {
  if(isdefined(self.old_goalradius))
    self.goalradius = self.old_goalradius;

  self.old_goalradius = undefined;
}

setinterval(var_0) {
  if(!isdefined(self.old_interval))
    self.old_interval = self.interval;

  self.interval = var_0;
}

resetinterval() {
  if(isdefined(self.old_interval))
    self.interval = self.old_interval;

  self.old_interval = undefined;
}

set_accuracy(var_0) {
  if(!isdefined(self.old_accuracy))
    self.old_accuracy = self.baseaccuracy;

  self.baseaccuracy = var_0;
}

reset_accuracy() {
  if(isdefined(self.old_accuracy))
    self.baseaccuracy = self.old_accuracy;

  self.old_accuracy = undefined;
}

get_closest_ally(var_0) {
  var_1 = undefined;

  if(!isdefined(var_0))
    var_2 = level.player getorigin();
  else
    var_2 = var_0 getorigin();

  if(isdefined(level.excludedai))
    var_1 = maps\_utility::get_closest_ai_exclude(var_2, "allies", level.excludedai);
  else
    var_1 = maps\_utility::get_closest_ai(var_2, "allies");

  return var_1;
}

get_closest_axis() {
  var_0 = maps\_utility::get_closest_ai(level.player getorigin(), "axis");
  return var_0;
}

groupwarp(var_0, var_1) {
  var_2 = getnodearray(var_1, "targetname");

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isdefined(var_2[var_3]))
      var_0[var_3] teleport(var_2[var_3].origin);
  }
}

getaiarraytouchingvolume(var_0, var_1, var_2) {
  if(!isdefined(var_2))
    var_2 = getent(var_1, "targetname");

  if(var_0 == "all")
    var_3 = getaiarray();
  else
    var_3 = getaiarray(var_0);

  var_4 = [];

  for (var_5 = 0; var_5 < var_3.size; var_5++) {
    if(var_3[var_5] istouching(var_2))
      var_4[var_4.size] = var_3[var_5];
  }

  return var_4;
}

npcdelete(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3)) {
    var_3 = [];
    var_3[0] = level.price;
  }

  var_4 = getent(var_0, "targetname");

  if(!isdefined(var_2))
    var_2 = 0;

  var_5 = undefined;

  if(var_1 == "all")
    var_5 = getaiarray();
  else
    var_5 = getaiarray(var_1);

  if(isdefined(var_3)) {
    for (var_6 = 0; var_6 < var_3.size; var_6++) {
      if(maps\_utility::is_in_array(var_5, var_3[var_6]))
        var_5 = common_scripts\utility::array_remove(var_5, var_3[var_6]);
    }
  }

  for (var_6 = 0; var_6 < var_5.size; var_6++) {
    if(var_5[var_6] istouching(var_4)) {
      var_5[var_6] invulnerable(0);

      if(var_2 == 1) {
        var_5[var_6] kill((0, 0, 0));
        continue;
      }

      var_5[var_6] delete();
    }
  }
}

getdudefromarray(var_0, var_1) {
  var_2 = undefined;

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isdefined(var_0[var_3].script_noteworthy) && var_0[var_3].script_noteworthy == var_1)
      var_2 = var_0[var_3];
  }

  return var_2;
}

getdudesfromarray(var_0, var_1) {
  var_2 = [];

  if(isdefined(var_1)) {
    for (var_3 = 0; var_3 < var_0.size; var_3++) {
      if(isdefined(var_0[var_3].script_noteworthy) && var_0[var_3].script_noteworthy == var_1)
        var_2[var_2.size] = var_0[var_3];
    }
  } else {}

  if(var_2.size > 0)
    return var_2;
  else
    return undefined;
}

gotonode(var_0) {
  self endon("death");
  var_1 = getnode(var_0, "targetname");
  setgoalradius(var_1.radius);
  self setgoalnode(var_1);
  self waittill("goal");
  resetgoalradius();
}

gotonodeanddelete(var_0) {
  if(!isdefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  var_1 = getnode(var_0, "targetname");
  self setgoalnode(var_1);
  setgoalradius(var_1.radius);
  self waittill("goal");
  self delete();
}

gotonodeandwait(var_0) {
  if(!isdefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self endon("death");
  var_1 = getnode(var_0, "targetname");
  self setgoalnode(var_1);
  setgoalradius(var_1.radius);
  self waittill("goal");
  set_animname("guy");
  self waittill("stop_waiting_at_node");
  resetgoalradius();
}

forcetonode(var_0) {
  self endon("death");
  var_1 = getnode(var_0, "targetname");
  self pushplayer(1);
  self setgoalnode(var_1);
  self waittill("goal");
  self pushplayer(0);
  resetgoalradius();
}

setposture(var_0) {
  if(var_0 == "all")
    self allowedstances("stand", "crouch", "prone");
  else
    self allowedstances(var_0);
}

invulnerable(var_0) {
  if(var_0 == 0) {
    if(isdefined(self.magic_bullet_shield))
      maps\_utility::stop_magic_bullet_shield();
  } else if(!isdefined(self.magic_bullet_shield))
    thread maps\_utility::magic_bullet_shield();

  self.a.disablepain = var_0;
}

killentity() {
  self endon("death");

  if(!isdefined(self)) {
    return;
  }
  if(!isalive(self)) {
    return;
  }
  self.allowdeath = 1;
  invulnerable(0);
  self kill();
}

gotovolume(var_0) {
  self endon("death");
  var_1 = getent(var_0, "targetname");
  var_2 = getnode(var_1.target, "targetname");
  self setgoalnode(var_2);
  self setgoalvolume(var_1);
  self.goalradius = var_2.radius;
}

aa_spawning_functions() {}

spawndude(var_0, var_1) {
  if(isdefined(var_1))
    var_2 = var_0 stalingradspawn();
  else
    var_2 = var_0 dospawn();

  maps\_utility::spawn_failed(var_2);
  return var_2;
}

aa_door_functions() {}

door_open(var_0, var_1, var_2) {
  if(!isdefined(var_1))
    var_1 = 1;

  if(!isdefined(var_2))
    var_2 = 1;

  if(var_1 == 1)
    self playsound(level.scr_sound["snd_wood_door_kick"]);

  if(self.classname == "script_brushmodel")
    var_3 = getent(self.target, "targetname");
  else {
    var_4 = getent(self.target, "targetname");
    var_3 = getent(var_4.script_linkto, "script_linkname");
  }

  switch (var_0) {
    case "explosive":
      thread door_fall_over();
      door_connectpaths(var_2);
      self playsound(level.scr_sound["snd_breach_wooden_door"]);
      earthquake(0.4, 1, self.origin, 1000);
      radiusdamage(self.origin, 56, level.maxdetpackdamage, level.mindetpackdamage);
      break;
    case "kicked":
      self rotateyaw(-175, 0.5);
      door_connectpaths(var_2);
      break;
    case "kicked_down":
      thread door_fall_over();
      door_connectpaths(var_2);
      break;
    default:
      self rotateyaw(-175, 0.5);
      door_connectpaths();
      break;
  }

  var_5 = var_3.script_exploder;
  common_scripts\_exploder::exploder(var_5);
}

door_connectpaths(var_0) {
  if(self.classname == "script_brushmodel")
    self connectpaths();
  else {
    var_1 = getent(self.target, "targetname");
    var_1 hide();
    var_1 notsolid();
    var_1 connectpaths();
  }
}

door_fall_over() {
  var_0 = anglestoforward(self.angles);
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

  for (var_9 = 0; var_9 < var_6; var_9++) {
    var_10 = var_7 * var_9;
    var_11 = cos(var_10) * var_1;
    var_12 = sin(var_10) * var_1;
    var_13 = var_0[0] + var_11;
    var_14 = var_0[1] + var_12;
    var_15 = var_0[2];
    var_8[var_8.size] = (var_13, var_14, var_15);
  }

  if(isdefined(var_4))
    wait(var_4);

  thread debug_circle_drawlines(var_8, var_2, var_3, var_5, var_0);
}

debug_circle_drawlines(var_0, var_1, var_2, var_3, var_4) {
  if(!isdefined(var_3))
    var_3 = 0;

  if(!isdefined(var_4))
    var_3 = 0;

  for (var_5 = 0; var_5 < var_0.size; var_5++) {
    var_6 = var_0[var_5];

    if(var_5 + 1 >= var_0.size)
      var_7 = var_0[0];
    else
      var_7 = var_0[var_5 + 1];

    thread debug_line(var_6, var_7, var_1, var_2);

    if(var_3)
      thread debug_line(var_4, var_6, var_1, var_2);
  }
}

debug_line(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_3))
    var_3 = (1, 1, 1);

  for (var_4 = 0; var_4 < var_2 * 20; var_4++)
    wait 0.05;
}