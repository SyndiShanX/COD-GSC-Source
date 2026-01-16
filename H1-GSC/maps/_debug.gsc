/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_debug.gsc
********************************/

debugchains() {
  var_0 = getallnodes();
  var_1 = 0;
  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!(var_0[var_3].spawnflags & 2) && (isdefined(var_0[var_3].target) && getnodearray(var_0[var_3].target, "targetname").size > 0 || isdefined(var_0[var_3].targetname) && getnodearray(var_0[var_3].targetname, "target").size > 0)) {
      var_2[var_1] = var_0[var_3];
      var_1++;
    }
  }

  var_4 = 0;

  for (;;) {
    if(getdvar("chain") == "1") {
      for (var_3 = 0; var_3 < var_2.size; var_3++) {
        if(distance(level.player getorigin(), var_2[var_3].origin) < 1500) {

        }
      }

      var_5 = getaiarray("allies");

      for (var_3 = 0; var_3 < var_5.size; var_3++) {
        var_6 = var_5[var_3] animscripts\utility::getclaimednode();

        if(isdefined(var_6)) {

        }
      }
    }

    waitframe();
  }
}

debug_enemypos(var_0) {
  var_1 = getaiarray();

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] getentitynumber() != var_0) {
      continue;
    }
    var_1[var_2] thread debug_enemyposproc();
    break;
  }
}

debug_stopenemypos(var_0) {
  var_1 = getaiarray();

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] getentitynumber() != var_0) {
      continue;
    }
    var_1[var_2] notify("stop_drawing_enemy_pos");
    break;
  }
}

debug_enemyposproc() {
  self endon("death");
  self endon("stop_drawing_enemy_pos");

  for (;;) {
    wait 0.05;

    if(isalive(self.enemy)) {

    }

    if(!animscripts\utility::hasenemysightpos()) {
      continue;
    }
    var_0 = animscripts\utility::getenemysightpos();
  }
}

debug_enemyposreplay() {
  var_0 = getaiarray();
  var_1 = undefined;

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_0[var_2];

    if(!isalive(var_1)) {
      continue;
    }
    if(isdefined(var_1.lastenemysightpos)) {

    }

    if(isdefined(var_1.goodshootpos)) {
      if(var_1 isbadguy())
        var_3 = (1, 0, 0);
      else
        var_3 = (0, 0, 1);

      var_4 = var_1.origin + (0, 0, 54);

      if(isdefined(var_1.node)) {
        if(var_1.node.type == "Cover Left") {
          var_5 = 1;
          var_4 = anglestoright(var_1.node.angles);
          var_4 = var_4 * -32;
          var_4 = (var_4[0], var_4[1], 64);
          var_4 = var_1.node.origin + var_4;
        } else if(var_1.node.type == "Cover Right") {
          var_5 = 1;
          var_4 = anglestoright(var_1.node.angles);
          var_4 = var_4 * 32;
          var_4 = (var_4[0], var_4[1], 64);
          var_4 = var_1.node.origin + var_4;
        }
      }

      common_scripts\utility::draw_arrow(var_4, var_1.goodshootpos, var_3);
    }
  }

  if(1) {
    return;
  }
  if(!isalive(var_1)) {
    return;
  }
  if(isalive(var_1.enemy)) {}

  if(isdefined(var_1.lastenemysightpos)) {}

  if(isalive(var_1.goodenemy)) {}

  if(!var_1 animscripts\utility::hasenemysightpos()) {
    return;
  }
  var_6 = var_1 animscripts\utility::getenemysightpos();

  if(isdefined(var_1.goodshootpos))
    return;
}

drawenttag(var_0) {}

drawtag(var_0, var_1, var_2) {
  var_3 = self gettagorigin(var_0);
  var_4 = self gettagangles(var_0);
  drawarrow(var_3, var_4, var_1, var_2);
}

draworgforever(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  for (;;) {
    if(isdefined(self)) {
      var_1 = self.origin;
      var_2 = self.angles;
      drawarrow(var_1, var_2, var_0);
    }

    wait 0.05;
  }
}

drawarrowforever(var_0, var_1) {
  for (;;) {
    drawarrow(var_0, var_1);
    wait 0.05;
  }
}

draworiginforever() {
  while (isdefined(self)) {
    drawarrow(self.origin, self.angles);
    wait 0.05;
  }
}

drawarrow(var_0, var_1, var_2, var_3) {
  var_4 = 10;
  var_5 = anglestoforward(var_1);
  var_6 = var_5 * var_4;
  var_7 = var_5 * (var_4 * 0.8);
  var_8 = anglestoright(var_1);
  var_9 = var_8 * (var_4 * -0.2);
  var_10 = var_8 * (var_4 * 0.2);
  var_11 = anglestoup(var_1);
  var_8 = var_8 * var_4;
  var_11 = var_11 * var_4;
  var_12 = (0.9, 0.2, 0.2);
  var_13 = (0.2, 0.9, 0.2);
  var_14 = (0.2, 0.2, 0.9);

  if(isdefined(var_2)) {
    var_12 = var_2;
    var_13 = var_2;
    var_14 = var_2;
  }

  if(!isdefined(var_3))
    var_3 = 1;
}

drawforwardforever(var_0, var_1) {
  if(!isdefined(var_0))
    var_0 = 100;

  if(!isdefined(var_1))
    var_1 = (0, 1, 0);

  for (;;) {
    if(!isdefined(self)) {
      return;
    }
    var_2 = anglestoforward(self.angles);
    wait 0.05;
  }
}

drawplayerviewforever() {
  for (;;) {
    drawarrow(level.player.origin, level.player getplayerangles(), (1, 1, 1));
    wait 0.05;
  }
}

drawtagforever(var_0, var_1) {
  for (;;) {
    if(!isdefined(self)) {
      return;
    }
    drawtag(var_0, var_1);
    wait 0.05;
  }
}

drawtagtrails(var_0, var_1) {
  for (;;) {
    if(!isdefined(self.origin)) {
      break;
    }

    drawtag(var_0, var_1, 1000);
    wait 0.05;
  }
}

dragtaguntildeath(var_0, var_1) {
  self endon("death");

  for (;;) {
    if(!isdefined(self)) {
      break;
    }

    if(!isdefined(self.origin)) {
      break;
    }

    drawtag(var_0, var_1);
    wait 0.05;
  }
}

viewtag(var_0, var_1) {
  if(var_0 == "ai") {
    var_2 = getaiarray();

    for (var_3 = 0; var_3 < var_2.size; var_3++)
      var_2[var_3] drawtag(var_1);
  }
}

debug_corner() {
  level.player.ignoreme = 1;
  var_0 = getallnodes();
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2].type == "Cover Left")
      var_1[var_1.size] = var_0[var_2];

    if(var_0[var_2].type == "Cover Right")
      var_1[var_1.size] = var_0[var_2];
  }

  var_3 = getaiarray();

  for (var_2 = 0; var_2 < var_3.size; var_2++)
    var_3[var_2] delete();

  level.debugspawners = getspawnerarray();
  level.activenodes = [];
  level.completednodes = [];

  for (var_2 = 0; var_2 < level.debugspawners.size; var_2++)
    level.debugspawners[var_2].targetname = "blah";

  var_4 = 0;

  for (var_2 = 0; var_2 < 30; var_2++) {
    if(var_2 >= var_1.size) {
      break;
    }

    var_1[var_2] thread covertest();
    var_4++;
  }

  if(var_1.size <= 30) {
    return;
  }
  for (;;) {
    level waittill("debug_next_corner");

    if(var_4 >= var_1.size)
      var_4 = 0;

    var_1[var_4] thread covertest();
    var_4++;
  }
}

covertest() {
  coversetupanim();
}

coversetupanim() {
  var_0 = undefined;
  var_1 = undefined;

  for (;;) {
    for (var_2 = 0; var_2 < level.debugspawners.size; var_2++) {
      wait 0.05;
      var_1 = level.debugspawners[var_2];
      var_3 = 0;

      for (var_4 = 0; var_4 < level.activenodes.size; var_4++) {
        if(distance(level.activenodes[var_4].origin, self.origin) > 250) {
          continue;
        }
        var_3 = 1;
        break;
      }

      if(var_3) {
        continue;
      }
      var_5 = 0;

      for (var_4 = 0; var_4 < level.completednodes.size; var_4++) {
        if(level.completednodes[var_4] != self) {
          continue;
        }
        var_5 = 1;
        break;
      }

      if(var_5) {
        continue;
      }
      level.activenodes[level.activenodes.size] = self;
      var_1.origin = self.origin;
      var_1.angles = self.angles;
      var_1.count = 1;
      var_0 = var_1 stalingradspawn();

      if(maps\_utility::spawn_failed(var_0)) {
        removeactivespawner(self);
        continue;
      }

      break;
    }

    if(isalive(var_0)) {
      break;
    }
  }

  wait 1;

  if(isalive(var_0)) {
    var_0.ignoreme = 1;
    var_0.team = "neutral";
    var_0 setgoalpos(var_0.origin);
    thread createline(self.origin);
    var_0 thread maps\_utility::debugorigin();
    thread createlineconstantly(var_0);
    var_0 waittill("death");
  }

  removeactivespawner(self);
  level.completednodes[level.completednodes.size] = self;
}

removeactivespawner(var_0) {
  var_1 = [];

  for (var_2 = 0; var_2 < level.activenodes.size; var_2++) {
    if(level.activenodes[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level.activenodes[var_2];
  }

  level.activenodes = var_1;
}

createline(var_0) {
  for (;;)
    wait 0.05;
}

createlineconstantly(var_0) {
  var_1 = undefined;

  while (isalive(var_0)) {
    var_1 = var_0.origin;
    wait 0.05;
  }

  for (;;)
    wait 0.05;
}

debugmisstime() {
  self notify("stopdebugmisstime");
  self endon("stopdebugmisstime");
  self endon("death");

  for (;;) {
    if(self.a.misstime <= 0) {

    } else {

    }

    wait 0.05;
  }
}

debugmisstimeoff() {
  self notify("stopdebugmisstime");
}

setemptydvar(var_0, var_1) {}

debugjump(var_0) {}

maprange(var_0, var_1, var_2, var_3, var_4) {
  return var_3 + (var_0 - var_1) * (var_4 - var_3) / (var_2 - var_1);
}

movement_velocity_loop() {}

movement_acceleration_loop() {}

stair_state_loop() {}

get_direction() {
  var_0 = anglestoforward(self.angles);
  var_1 = maps\_shg_utility::get_differentiated_velocity();

  if(!isdefined(var_1) || !isdefined(var_0))
    return "none";

  if(length(var_1) == 0)
    var_1 = self.velocity;

  var_2 = vectordot(vectornormalize(var_0), vectornormalize(var_1));
  var_2 = clamp(var_2, -1, 1);
  var_3 = acos(var_2);

  if(var_3 > 135)
    return "back";
  else if(var_3 < 45)
    return "forward";
  else if(var_3 > 45 && var_3 < 135)
    return "left";
  else
    return "right";
}

init_state_list() {
  var_0 = [];
  var_0[0] = "Invalid";
  var_0[1] = "Exposed";
  var_0[2] = "Turret";
  var_0[3] = "Grenade_Response";
  var_0[4] = "Badplace";
  var_0[5] = "Cover_Arrival";
  var_0[6] = "Death";
  var_0[7] = "Pain";
  var_0[8] = "Flashed";
  var_0[9] = "Scripted_Anim";
  var_0[10] = "Custom_Anim";
  var_0[11] = "Negotiation";
  return var_0;
}

state_print_priority(var_0) {
  if(!isdefined(var_0))
    return 99;

  switch (var_0) {
    case "death":
      return 0;
    case "scripted":
      return 1;
    case "traverse":
      return 2;
    case "combat":
      return 3;
    case "patrol":
      return 4;
    case "stealth":
      return 5;
    case "cover_arrival":
      return 6;
    case "cover":
      return 7;
    case "flashed":
      return 8;
    case "reaction":
      return 9;
    case "pain":
      return 10;
    case "init":
      return 11;
    case "move":
      return 12;
    case "stop":
      return 13;
    case "grenade_cower":
      return 14;
    case "grenade_return_throw":
      return 15;
    case "<custom>":
    case "cover_swim_up":
    case "cover_swim_right":
    case "cover_swim_left":
    case "cover_multi":
    case "cover_prone":
    case "cover_right":
    case "cover_left":
    case "cover_stand":
    case "cover_crouch":
      return 16;
    default:
      return 99;
  }
}

script_state_compare(var_0, var_1) {
  return state_print_priority(var_0) < state_print_priority(var_1);
}

script_to_state(var_0) {
  var_1 = [];

  if(!isai(var_0)) {
    var_1 = common_scripts\utility::array_add(var_1, "Undefined");
    return var_1;
  }

  if(!isdefined(var_0.script)) {
    var_1 = common_scripts\utility::array_add(var_1, "Undefined");
    return var_1;
  }

  if(isdefined(self.script_patroller) && self.script_patroller == 1)
    var_1 = common_scripts\utility::array_add(var_1, "patrol");

  if(isdefined(self.istraversing) && self.istraversing)
    var_1 = common_scripts\utility::array_add(var_1, "traverse");

  if(isdefined(self._cloak_enemy_state) && self._cloak_enemy_state != "default_stealth_state")
    var_1 = common_scripts\utility::array_add(var_1, "stealth");

  switch (var_0.script) {
    case "<custom>":
    case "grenade_return_throw":
    case "grenade_cower":
    case "cover_arrival":
    case "scripted":
    case "reaction":
    case "init":
    case "pain":
    case "combat":
    case "death":
    case "flashed":
    case "move":
    case "stop":
      var_1 = common_scripts\utility::array_add(var_1, var_0.script);
      break;
    case "cover_swim_up":
    case "cover_swim_right":
    case "cover_swim_left":
    case "cover_multi":
    case "cover_prone":
    case "cover_right":
    case "cover_left":
    case "cover_stand":
    case "cover_crouch":
      var_1 = common_scripts\utility::array_add(var_1, "cover");
      break;
    default:
      if(common_scripts\utility::string_find(var_0.script, "mantle") != -1) {
        var_1 = common_scripts\utility::array_add(var_1, "mantle");
        break;
      }

      var_1 = common_scripts\utility::array_add(var_1, var_0.script);
      break;
  }

  if(var_1.size > 1)
    var_1 = common_scripts\utility::array_sort_with_func(var_1, ::script_state_compare);

  return var_1;
}

transition_has_inverse(var_0) {
  var_1 = " -> ";
  var_2 = common_scripts\utility::string_find(var_0, var_1);
  var_3 = getsubstr(var_0, 0, var_2);
  var_4 = getsubstr(var_0, var_2 + var_1.size, var_0.size);
  var_5 = var_4 + var_1 + var_3;

  if(isdefined(common_scripts\utility::array_find(level.transitions, var_5))) {
    var_6 = [];
    var_6["reversed"] = var_5;
    var_6["new"] = var_3 + " -- " + var_4;
    return var_6;
  }

  return undefined;
}

output_states_to_file(var_0) {}

state_loop() {}

debugdvars() {}

remove_reflection_objects() {}

create_reflection_objects() {}

create_reflection_object() {}

debug_reflection() {}

debug_reflection_buttons() {}

remove_fxlighting_object() {}

create_fxlighting_object() {}

play_fxlighting_fx() {}

debug_fxlighting() {}

debug_dumplightshadowstates() {}

debug_fxlighting_buttons() {}

showdebugtrace() {
  var_0 = undefined;
  var_1 = undefined;
  var_0 = (15.1859, -12.2822, 4.071);
  var_1 = (947.2, -10918, 64.9514);

  for (;;) {
    wait 0.05;
    var_2 = var_0;
    var_3 = var_1;

    if(!isdefined(var_0))
      var_2 = level.tracestart;

    if(!isdefined(var_1))
      var_3 = level.player geteye();

    var_4 = bullettrace(var_2, var_3, 0, undefined);
  }
}

debug_character_count() {
  var_0 = newhudelem();
  var_0.alignx = "left";
  var_0.aligny = "middle";
  var_0.x = 10;
  var_0.y = 100;
  var_0.label = & "DEBUG_DRONES";
  var_0.alpha = 0;
  var_1 = newhudelem();
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.x = 10;
  var_1.y = 115;
  var_1.label = & "DEBUG_ALLIES";
  var_1.alpha = 0;
  var_2 = newhudelem();
  var_2.alignx = "left";
  var_2.aligny = "middle";
  var_2.x = 10;
  var_2.y = 130;
  var_2.label = & "DEBUG_AXIS";
  var_2.alpha = 0;
  var_3 = newhudelem();
  var_3.alignx = "left";
  var_3.aligny = "middle";
  var_3.x = 10;
  var_3.y = 145;
  var_3.label = & "DEBUG_VEHICLES";
  var_3.alpha = 0;
  var_4 = newhudelem();
  var_4.alignx = "left";
  var_4.aligny = "middle";
  var_4.x = 10;
  var_4.y = 160;
  var_4.label = & "DEBUG_TOTAL";
  var_4.alpha = 0;
  var_5 = "off";

  for (;;) {
    var_6 = getdvar("debug_character_count");

    if(var_6 == "off") {
      if(var_6 != var_5) {
        var_0.alpha = 0;
        var_1.alpha = 0;
        var_2.alpha = 0;
        var_3.alpha = 0;
        var_4.alpha = 0;
        var_5 = var_6;
      }

      wait 0.25;
      continue;
    } else if(var_6 != var_5) {
      var_0.alpha = 1;
      var_1.alpha = 1;
      var_2.alpha = 1;
      var_3.alpha = 1;
      var_4.alpha = 1;
      var_5 = var_6;
    }

    var_7 = getentarray("drone", "targetname").size;
    var_0 setvalue(var_7);
    var_8 = getaiarray("allies").size;
    var_1 setvalue(var_8);
    var_9 = getaiarray("bad_guys").size;
    var_2 setvalue(var_9);
    var_3 setvalue(getentarray("script_vehicle", "classname").size);
    var_4 setvalue(var_7 + var_8 + var_9);
    wait 0.25;
  }
}

nuke() {
  if(!self.damageshield)
    self kill((0, 0, -500), level.player, level.player);
}

debug_nuke() {}

camera() {
  wait 0.05;
  var_0 = getentarray("camera", "targetname");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = getent(var_0[var_1].target, "targetname");
    var_0[var_1].origin2 = var_2.origin;
    var_0[var_1].angles = vectortoangles(var_2.origin - var_0[var_1].origin);
  }

  for (;;) {
    var_3 = getaiarray("axis");

    if(!var_3.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    var_4 = [];

    for (var_1 = 0; var_1 < var_0.size; var_1++) {
      for (var_5 = 0; var_5 < var_3.size; var_5++) {
        if(distance(var_0[var_1].origin, var_3[var_5].origin) > 256) {
          continue;
        }
        var_4[var_4.size] = var_0[var_1];
        break;
      }
    }

    if(!var_4.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    var_6 = [];

    for (var_1 = 0; var_1 < var_4.size; var_1++) {
      var_7 = var_4[var_1];
      var_8 = var_7.origin2;
      var_9 = var_7.origin;
      var_10 = vectortoangles((var_9[0], var_9[1], var_9[2]) - (var_8[0], var_8[1], var_8[2]));
      var_11 = (0, var_10[1], 0);
      var_12 = anglestoforward(var_11);
      var_10 = vectornormalize(var_9 - level.player.origin);
      var_13 = vectordot(var_12, var_10);

      if(var_13 < 0.85) {
        continue;
      }
      var_6[var_6.size] = var_7;
    }

    if(!var_6.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    var_14 = distance(level.player.origin, var_6[0].origin);
    var_15 = var_6[0];

    for (var_1 = 1; var_1 < var_6.size; var_1++) {
      var_16 = distance(level.player.origin, var_6[var_1].origin);

      if(var_16 > var_14) {
        continue;
      }
      var_15 = var_6[var_1];
      var_14 = var_16;
    }

    setplayertocamera(var_15);
    wait 3;
  }
}

freeplayer() {
  setdvar("cl_freemove", "0");
}

setplayertocamera(var_0) {
  setdvar("cl_freemove", "2");
}

anglescheck() {
  for (;;) {
    if(getdvar("angles", "0") == "1")
      setdvar("angles", "0");

    wait 1;
  }
}

deathspawnerpreview() {
  waittillframeend;

  for (var_0 = 0; var_0 < 50; var_0++) {
    if(!isdefined(level.deathspawnerents[var_0])) {
      continue;
    }
    var_1 = level.deathspawnerents[var_0];

    for (var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(isdefined(var_3.truecount))
        continue;
    }
  }
}

lastsightposwatch() {}

watchminimap() {
  precacheitem("defaultweapon");

  for (;;) {
    updateminimapsetting();
    wait 0.25;
  }
}

updateminimapsetting() {
  var_0 = getdvarfloat("scr_requiredMapAspectRatio", 1);

  if(!isdefined(level.minimapcornertargetname)) {
    setdvar("scr_minimap_corner_targetname", "minimap_corner");
    level.minimapcornertargetname = "minimap_corner";
  }

  if(!isdefined(level.minimapheight)) {
    setdvar("scr_minimap_height", "0");
    level.minimapheight = 0;
  }

  var_1 = getdvarfloat("scr_minimap_height");
  var_2 = getdvar("scr_minimap_corner_targetname");

  if(var_1 != level.minimapheight || var_2 != level.minimapcornertargetname) {
    if(isdefined(level.minimaporigin)) {
      level.minimapplayer unlink();
      level.minimaporigin delete();
      level notify("end_draw_map_bounds");
    }

    if(var_1 > 0) {
      level.minimapheight = var_1;
      level.minimapcornertargetname = var_2;
      var_3 = level.player;
      var_4 = getentarray(var_2, "targetname");

      if(var_4.size == 2) {
        var_5 = var_4[0].origin + var_4[1].origin;
        var_5 = (var_5[0] * 0.5, var_5[1] * 0.5, var_5[2] * 0.5);
        var_6 = (var_4[0].origin[0], var_4[0].origin[1], var_5[2]);
        var_7 = (var_4[0].origin[0], var_4[0].origin[1], var_5[2]);

        if(var_4[1].origin[0] > var_4[0].origin[0])
          var_6 = (var_4[1].origin[0], var_6[1], var_6[2]);
        else
          var_7 = (var_4[1].origin[0], var_7[1], var_7[2]);

        if(var_4[1].origin[1] > var_4[0].origin[1])
          var_6 = (var_6[0], var_4[1].origin[1], var_6[2]);
        else
          var_7 = (var_7[0], var_4[1].origin[1], var_7[2]);

        var_8 = var_6 - var_5;
        var_5 = (var_5[0], var_5[1], var_5[2] + var_1);
        var_9 = spawn("script_origin", var_3.origin);
        var_10 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
        var_11 = (var_10[1], 0 - var_10[0], 0);
        var_12 = vectordot(var_10, var_8);

        if(var_12 < 0)
          var_12 = 0 - var_12;

        var_13 = vectordot(var_11, var_8);

        if(var_13 < 0)
          var_13 = 0 - var_13;

        if(var_0 > 0) {
          var_14 = var_13 / var_12;

          if(var_14 < var_0) {
            var_15 = var_0 / var_14;
            var_13 = var_13 * var_15;
            var_16 = vecscale(var_11, vectordot(var_11, var_6 - var_5) * (var_15 - 1));
            var_7 = var_7 - var_16;
            var_6 = var_6 + var_16;
          } else {
            var_15 = var_14 / var_0;
            var_12 = var_12 * var_15;
            var_16 = vecscale(var_10, vectordot(var_10, var_6 - var_5) * (var_15 - 1));
            var_7 = var_7 - var_16;
            var_6 = var_6 + var_16;
          }
        }

        if(level.console) {
          var_17 = 1.77778;
          var_18 = 2 * atan(var_13 * 0.8 / var_1);
          var_19 = 2 * atan(var_12 * var_17 * 0.8 / var_1);
        } else {
          var_17 = 1.33333;
          var_18 = 2 * atan(var_13 * 1.05 / var_1);
          var_19 = 2 * atan(var_12 * var_17 * 1.05 / var_1);
        }

        if(var_18 > var_19)
          var_20 = var_18;
        else
          var_20 = var_19;

        var_21 = var_1 - 1000;

        if(var_21 < 16)
          var_21 = 16;

        if(var_21 > 10000)
          var_21 = 10000;

        var_3 playerlinktoabsolute(var_9);
        var_9.origin = var_5 + (0, 0, -62);
        var_9.angles = (90, getnorthyaw(), 0);
        var_3 giveweapon("defaultweapon");
        setsaveddvar("cg_fov", var_20);
        level.minimapplayer = var_3;
        level.minimaporigin = var_9;
        thread drawminimapbounds(var_5, var_7, var_6);
      } else {

      }
    }
  }
}

getchains() {
  var_0 = [];
  var_0 = getentarray("minimap_line", "script_noteworthy");
  var_1 = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_2] = var_0[var_2] getchain();

  return var_1;
}

getchain() {
  var_0 = [];
  var_1 = self;

  while (isdefined(var_1)) {
    var_0[var_0.size] = var_1;

    if(!isdefined(var_1) || !isdefined(var_1.target)) {
      break;
    }

    var_1 = getent(var_1.target, "targetname");

    if(isdefined(var_1) && var_1 == var_0[0]) {
      var_0[var_0.size] = var_1;
      break;
    }
  }

  var_2 = [];

  for (var_3 = 0; var_3 < var_0.size; var_3++)
    var_2[var_3] = var_0[var_3].origin;

  return var_2;
}

vecscale(var_0, var_1) {
  return (var_0[0] * var_1, var_0[1] * var_1, var_0[2] * var_1);
}

drawminimapbounds(var_0, var_1, var_2) {
  level notify("end_draw_map_bounds");
  level endon("end_draw_map_bounds");
  var_3 = var_0[2] - var_2[2];
  var_4 = length(var_1 - var_2);
  var_5 = var_1 - var_0;
  var_5 = vectornormalize((var_5[0], var_5[1], 0));
  var_1 = var_1 + vecscale(var_5, var_4 * 1 / 800 * 0);
  var_6 = var_2 - var_0;
  var_6 = vectornormalize((var_6[0], var_6[1], 0));
  var_2 = var_2 + vecscale(var_6, var_4 * 1 / 800 * 0);
  var_7 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var_8 = var_2 - var_1;
  var_9 = vecscale(var_7, vectordot(var_8, var_7));
  var_10 = vecscale(var_7, abs(vectordot(var_8, var_7)));
  var_11 = var_1;
  var_12 = var_1 + var_9;
  var_13 = var_2;
  var_14 = var_2 - var_9;
  var_15 = vecscale(var_1 + var_2, 0.5) + vecscale(var_10, 0.51);
  var_16 = var_4 * 0.003;
  var_17 = getchains();

  for (;;) {
    common_scripts\utility::array_levelthread(var_17, common_scripts\utility::plot_points);
    wait 0.05;
  }
}

islookingatorigin(var_0) {
  var_1 = vectornormalize(var_0 - self getshootatpos());
  var_2 = vectornormalize(var_0 - (0, 0, 24) - self getshootatpos());
  var_3 = vectordot(var_1, var_2);
  var_4 = anglestoforward(self getplayerangles());
  var_5 = vectordot(var_4, var_1);

  if(var_5 > var_3)
    return 1;
  else
    return 0;
}

debug_colornodes() {
  wait 0.05;
  var_0 = getaiarray();
  var_1 = [];
  var_1["axis"] = [];
  var_1["allies"] = [];
  var_1["neutral"] = [];

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isdefined(var_3.currentcolorcode)) {
      continue;
    }
    var_1[var_3.team][var_3.currentcolorcode] = 1;
    var_4 = (1, 1, 1);

    if(isdefined(var_3.script_forcecolor))
      var_4 = level.color_debug[var_3.script_forcecolor];

    var_5 = var_3.currentcolorcode;

    if(isdefined(var_3.being_careful) && var_3.being_careful == 1)
      var_5 = var_5 + " (c)";

    var_3 try_to_draw_line_to_node();
  }

  draw_colornodes(var_1, "allies");
  draw_colornodes(var_1, "axis");
}

draw_colornodes(var_0, var_1) {
  var_2 = getarraykeys(var_0[var_1]);

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = (1, 1, 1);
    var_4 = level.color_debug[getsubstr(var_2[var_3], 0, 1)];

    if(isdefined(level.colornodes_debug_array[var_1][var_2[var_3]])) {
      var_5 = level.colornodes_debug_array[var_1][var_2[var_3]];

      for (var_6 = 0; var_6 < var_5.size; var_6++) {
        var_7 = "";

        if(isdefined(var_5[var_6].classname) && var_5[var_6].classname == "info_volume")
          var_7 = "V-" + var_2[var_3];
        else
          var_7 = "N-" + var_2[var_3];

        if(isdefined(var_5[var_6].color_user) && var_5[var_6].color_user == level.player)
          var_7 = var_7 + " (p)";
      }
    }
  }
}

get_team_substr() {
  if(self.team == "allies") {
    if(isdefined(self.node) && isdefined(self.node.script_color_allies))
      return self.node.script_color_allies;

    var_0 = self getgoalvolume();

    if(isdefined(var_0) && isdefined(var_0.script_color_allies))
      return var_0.script_color_allies;
  }

  if(self.team == "axis") {
    if(isdefined(self.node) && isdefined(self.node.script_color_axis))
      return self.node.script_color_axis;

    var_0 = self getgoalvolume();

    if(isdefined(var_0) && isdefined(var_0.script_color_axis))
      return var_0.script_color_axis;
  }
}

try_to_draw_line_to_node() {
  var_0 = (0, 0, 0);

  if(isdefined(self.node))
    var_0 = self.node.origin;
  else if(isdefined(self getgoalvolume())) {
    var_1 = self getgoalvolume();
    var_0 = var_1.origin;
  } else
    return;

  if(!isdefined(self.script_forcecolor)) {
    return;
  }
  var_2 = get_team_substr();

  if(!isdefined(var_2)) {
    return;
  }
  if(!issubstr(var_2, self.script_forcecolor))
    return;
}

fogcheck() {
  if(getdvar("depth_close") == "")
    setdvar("depth_close", "0");

  if(getdvar("depth_far") == "")
    setdvar("depth_far", "1500");

  var_0 = getdvarint("depth_close");
  var_1 = getdvarint("depth_far");
  setexpfog(var_0, var_1, 1, 1, 1, 1, 0);
}

debugthreat() {
  level.last_threat_debug = gettime();
  thread debugthreatcalc();
}

debugthreatcalc() {}

displaythreat(var_0, var_1) {
  if(self.team == var_0.team) {
    return;
  }
  var_2 = 0;
  var_2 = var_2 + self.threatbias;
  var_3 = 0;
  var_3 = var_3 + var_0.threatbias;
  var_4 = undefined;

  if(isdefined(var_1)) {
    var_4 = self getthreatbiasgroup();

    if(isdefined(var_4)) {
      var_3 = var_3 + getthreatbias(var_1, var_4);
      var_2 = var_2 + getthreatbias(var_4, var_1);
    }
  }

  if(var_0.ignoreme || var_3 < -900000)
    var_3 = "Ignore";

  if(self.ignoreme || var_2 < -900000)
    var_2 = "Ignore";

  var_5 = 20;
  var_6 = (1, 0.5, 0.2);
  var_7 = (0.2, 0.5, 1);
  var_8 = !isplayer(self) && self.pacifist;

  for (var_9 = 0; var_9 <= var_5; var_9++) {
    if(isdefined(var_1)) {

    }

    if(isdefined(var_4)) {

    }

    if(var_8) {

    }

    wait 0.05;
  }
}

debugcolorfriendlies() {
  level.debug_color_friendlies = [];
  level.debug_color_huds = [];

  for (;;) {
    level waittill("updated_color_friendlies");
    draw_color_friendlies();
  }
}

draw_color_friendlies() {
  level endon("updated_color_friendlies");
  var_0 = getarraykeys(level.debug_color_friendlies);
  var_1 = [];
  var_2 = [];
  var_2[var_2.size] = "r";
  var_2[var_2.size] = "o";
  var_2[var_2.size] = "y";
  var_2[var_2.size] = "g";
  var_2[var_2.size] = "c";
  var_2[var_2.size] = "b";
  var_2[var_2.size] = "p";
  var_2[var_2.size] = "w";
  var_2[var_2.size] = "a";
  var_2[var_2.size] = "l";
  var_3 = maps\_utility::get_script_palette();

  for (var_4 = 0; var_4 < var_2.size; var_4++)
    var_1[var_2[var_4]] = 0;

  for (var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = level.debug_color_friendlies[var_0[var_4]];
    var_1[var_5]++;
  }

  for (var_4 = 0; var_4 < level.debug_color_huds.size; var_4++)
    level.debug_color_huds[var_4] destroy();

  level.debug_color_huds = [];
  var_6 = 15;
  var_7 = 365;
  var_8 = 25;
  var_9 = 25;

  for (var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_1[var_2[var_4]] <= 0) {
      continue;
    }
    for (var_10 = 0; var_10 < var_1[var_2[var_4]]; var_10++) {
      var_11 = newhudelem();
      var_11.x = var_6 + 25 * var_10;
      var_11.y = var_7;
      var_11 setshader("white", 16, 16);
      var_11.alignx = "left";
      var_11.aligny = "bottom";
      var_11.alpha = 1;
      var_11.color = var_3[var_2[var_4]];
      level.debug_color_huds[level.debug_color_huds.size] = var_11;
    }

    var_7 = var_7 + var_9;
  }
}

playernode() {
  for (;;) {
    if(isdefined(level.player.node)) {

    }

    wait 0.05;
  }
}

drawusers() {
  if(isalive(self.color_user))
    return;
}

debuggoalpos() {
  for (;;) {
    var_0 = getaiarray();
    common_scripts\utility::array_thread(var_0, ::view_goal_pos);
    wait 0.05;
  }
}

view_goal_pos() {
  if(!isdefined(self.goalpos))
    return;
}

colordebug() {
  wait 0.5;
  var_0 = [];
  var_0[var_0.size] = "r";
  var_0[var_0.size] = "g";
  var_0[var_0.size] = "b";
  var_0[var_0.size] = "y";
  var_0[var_0.size] = "o";
  var_0[var_0.size] = "p";
  var_0[var_0.size] = "c";
  var_0[var_0.size] = "w";
  var_0[var_0.size] = "a";
  var_0[var_0.size] = "l";

  for (;;) {
    for (var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = level.currentcolorforced["allies"][var_0[var_1]];

      if(isdefined(var_2))
        draw_colored_nodes(var_2);
    }

    wait 0.05;
  }
}

draw_colored_nodes(var_0) {
  var_1 = level.arrays_of_colorcoded_nodes["allies"][var_0];
  common_scripts\utility::array_thread(var_1, ::drawusers);
}

add_hud_line(var_0, var_1, var_2) {
  var_3 = newhudelem();
  var_3.alignx = "left";
  var_3.aligny = "middle";
  var_3.x = var_0;
  var_3.y = var_1;
  var_3.alpha = 1;
  var_3.fontscale = 1;
  var_3.label = var_2;
  level.animsound_hud_extralines[level.animsound_hud_extralines.size] = var_3;
  return var_3;
}

get_alias_from_stored(var_0) {
  if(!isdefined(level.animsound_aliases[var_0.animname])) {
    return;
  }
  if(!isdefined(level.animsound_aliases[var_0.animname][var_0.anime])) {
    return;
  }
  if(!isdefined(level.animsound_aliases[var_0.animname][var_0.anime][var_0.notetrack])) {
    return;
  }
  return level.animsound_aliases[var_0.animname][var_0.anime][var_0.notetrack]["soundalias"];
}

is_from_animsound(var_0, var_1, var_2) {
  return isdefined(level.animsound_aliases[var_0][var_1][var_2]["created_by_animSound"]);
}

display_animsound() {
  if(distance(level.player.origin, self.origin) > 1500) {
    return;
  }
  level.animsounds_thisframe[level.animsounds_thisframe.size] = self;
}

debug_animsoundtag(var_0) {}

debug_animsoundtagselected() {}

tag_sound(var_0, var_1) {
  if(!isdefined(level.animsound_tagged)) {
    return;
  }
  if(!isdefined(level.animsound_tagged.animsounds[var_1])) {
    return;
  }
  var_2 = level.animsound_tagged.animsounds[var_1];
  var_3 = get_alias_from_stored(var_2);

  if(!isdefined(var_3) || is_from_animsound(var_2.animname, var_2.anime, var_2.notetrack)) {
    level.animsound_aliases[var_2.animname][var_2.anime][var_2.notetrack]["soundalias"] = var_0;
    level.animsound_aliases[var_2.animname][var_2.anime][var_2.notetrack]["created_by_animSound"] = 1;
  }
}

tostr(var_0) {
  var_1 = "\"";

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == "\"") {
      var_1 = var_1 + "\\";
      var_1 = var_1 + "\"";
      continue;
    }

    var_1 = var_1 + var_0[var_2];
  }

  var_1 = var_1 + "\"";
  return var_1;
}

linedraw(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_2))
    var_2 = (1, 1, 1);

  if(isdefined(var_5)) {
    var_5 = var_5 * 20;

    for (var_6 = 0; var_6 < var_5; var_6++)
      wait 0.05;
  } else {
    for (;;)
      wait 0.05;
  }
}

print3ddraw(var_0, var_1, var_2, var_3, var_4) {
  self endon("stop_print3ddraw");

  if(!isdefined(var_3))
    var_3 = 1;

  if(!isdefined(var_4))
    var_4 = 1;

  for (;;)
    wait 0.05;
}

complete_me() {
  if(getdvar("credits_active") == "1") {
    wait 7;
    setdvar("credits_active", "0");
    maps\_endmission::credits_end();
    return;
  }

  wait 7;
  maps\_utility::nextmission();
}

find_new_chase_target(var_0) {}

chasecam(var_0) {
  if(!isdefined(level.chase_cam_last_num))
    level.chase_cam_last_num = -1;

  if(level.chase_cam_last_num == var_0) {
    return;
  }
  find_new_chase_target(var_0);

  if(!isdefined(level.chase_cam_target)) {
    return;
  }
  level.chase_cam_last_num = var_0;

  if(!isdefined(level.chase_cam_ent))
    level.chase_cam_ent = level.chase_cam_target common_scripts\utility::spawn_tag_origin();

  thread chasecam_onent(level.chase_cam_target);
}

chasecam_onent(var_0) {
  level notify("new_chasecam");
  level endon("new_chasecam");
  var_0 endon("death");
  level.player unlink();
  level.player playerlinktoblend(level.chase_cam_ent, "tag_origin", 2, 0.5, 0.5);
  wait 2;
  level.player playerlinktodelta(level.chase_cam_ent, "tag_origin", 1, 180, 180, 180, 180);

  for (;;) {
    wait 0.2;

    if(!isdefined(level.chase_cam_target)) {
      return;
    }
    var_1 = level.chase_cam_target.origin;
    var_2 = level.chase_cam_target.angles;
    var_3 = anglestoforward(var_2);
    var_3 = var_3 * 200;
    var_1 = var_1 + var_3;
    var_2 = level.player getplayerangles();
    var_3 = anglestoforward(var_2);
    var_3 = var_3 * -200;
    level.chase_cam_ent moveto(var_1 + var_3, 0.2);
  }
}

viewfx() {
  foreach(var_1 in level.createfxent) {
    if(isdefined(var_1.looper)) {

    }
  }
}

add_key(var_0, var_1) {}

print_vehicle_info(var_0) {
  if(!isdefined(level.vnum))
    level.vnum = 9500;

  level.vnum++;
  var_1 = "bridge_helpers";
  add_key("origin", self.origin[0] + " " + self.origin[1] + " " + self.origin[2]);
  add_key("angles", self.angles[0] + " " + self.angles[1] + " " + self.angles[2]);
  add_key("targetname", "helper_model");
  add_key("model", self.model);
  add_key("classname", "script_model");
  add_key("spawnflags", "4");
  add_key("_color", "0.443137 0.443137 1.000000");

  if(isdefined(var_0))
    add_key("script_noteworthy", var_0);
}

draw_dot_for_ent(var_0) {}

draw_dot_for_guy() {
  var_0 = level.player getplayerangles();
  var_1 = anglestoforward(var_0);
  var_2 = level.player geteye();
  var_3 = self geteye();
  var_4 = vectortoangles(var_3 - var_2);
  var_5 = anglestoforward(var_4);
  var_6 = vectordot(var_5, var_1);
}

interactive_warnings() {
  var_0 = getentarray("explodable_barrel", "targetname");
  var_0 = common_scripts\utility::array_combine(var_0, getentarray("explodable_barrel", "script_noteworthy"));

  if(!var_0.size) {
    return;
  }
  foreach(var_2 in var_0) {
    var_2.destructible_type = "explodable_barrel";
    var_3 = var_2.model + "2";
    precachemodel(var_3);
    var_2 setmodel(var_3);

    if(isdefined(var_2.target)) {
      var_4 = getent(var_2.target, "targetname");

      if(isdefined(var_4))
        var_4.script_destruct_collision = "pre";

      var_2.targetname = "destructible_toy";
    }
  }
}

getspherebounds(var_0) {
  common_scripts\utility::draw_entity_bounds(var_0, 1);
}

trackobject(var_0) {
  var_1 = getspherebounds(var_0);
}

debug_draw_anim_path(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {}

draw_code_move_info(var_0, var_1, var_2, var_3) {}

track_bone_origins(var_0) {}

debug_foot_passing() {}