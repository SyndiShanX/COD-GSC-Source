/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\debug.gsc
***********************************************/

entity_count() {}

entity_count_hud() {}

get_total_count_color(var_0) {}

adjust_entcounthud_pos() {}

set_entity_count_hud(var_0, var_1, var_2) {}

entity_count_delta(var_0, var_1) {}

adjust_entity_count_hud_color(var_0) {}

get_entity_count_list(var_0, var_1) {
  var_2 = getEntArray();
  var_3 = [];

  if(!isDefined(var_0))
    var_0 = 0;

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.classname))
      var_6 = "UNKNOWN?";
    else
      var_6 = var_5.classname;

    if(var_0) {
      if(isai(var_5))
        var_6 = "actors";
      else if(isspawner(var_5)) {
        var_7 = getsubstr(var_6, 0, 5);

        if(var_7 == "actor")
          var_6 = "AI_spawners";
        else
          var_6 = "vehicle_spawners";
      } else if(isDefined(var_5.createfx_ent))
        var_6 = var_5.classname + " CREATEFX";
      else if(!isDefined(var_5.code_classname)) {} else if(var_5.code_classname == "script_model") {
        if(var_5.model == "tag_origin")
          var_6 = "script_model TAG_ORIGIN";
      } else if(var_5.code_classname == "trigger_multiple") {
        var_7 = getsubstr(var_6, 0, 22);

        if(var_7 == "trigger_multiple_bcs_")
          var_6 = "trigger_multiple_bcs";
        else
          var_6 = "trigger_multiple";
      } else {
        var_7 = getsubstr(var_5.code_classname, 0, 10);

        if(var_7 == "weapon_iw8")
          var_6 = "weapons";

        var_7 = getsubstr(var_5.code_classname, 0, 5);

        if(var_7 == "actor")
          var_6 = "drones";
      }
    } else {
      if(isDefined(var_5.createfx_ent))
        var_6 = "CREATEFX " + var_5.classname;

      if(var_6 == "script_model")
        var_6 = var_6 + (" " + var_5.model);
    }

    if(!isDefined(var_3[var_6]))
      var_3[var_6] = 0;

    var_3[var_6]++;
  }

  if(!isDefined(var_1) || !var_1)
    var_3 = sort_by_key(var_3);

  return var_3;
}

sort_by_key(var_0) {
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
    for(var_3 = var_2 + 1; var_3 < var_1.size; var_3++) {
      if(stricmp(var_1[var_2], var_1[var_3]) > 0) {
        var_4 = var_1[var_3];
        var_1[var_3] = var_1[var_2];
        var_1[var_2] = var_4;
      }
    }
  }

  var_5 = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_5[var_1[var_2]] = var_0[var_1[var_2]];

  return var_5;
}

debug_enemypos(var_0) {
  var_1 = getaiarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2] getentitynumber() != var_0) {
      continue;
    }
    var_1[var_2] thread debug_enemyposproc();
    break;
  }
}

debug_stopenemypos(var_0) {
  var_1 = getaiarray();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
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

  for(;;) {
    wait 0.05;

    if(isalive(self.enemy)) {}

    if(!scripts\anim\utility.gsc::hasenemysightpos()) {
      continue;
    }
    var_0 = scripts\anim\utility.gsc::getenemysightpos();
  }
}

debug_enemyposreplay() {
  var_0 = getaiarray();
  var_1 = undefined;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 = var_0[var_2];

    if(!isalive(var_1)) {
      continue;
    }
    if(isDefined(var_1.lastenemysightpos)) {}

    if(isDefined(var_1.goodshootpos)) {
      if(var_1 isbadguy())
        var_3 = (1, 0, 0);
      else
        var_3 = (0, 0, 1);

      var_4 = var_1.origin + (0, 0, 54);

      if(isDefined(var_1.node)) {
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

      scripts\engine\utility::draw_arrow(var_4, var_1.goodshootpos, var_3);
    }
  }

  if(1) {
    return;
  }
  if(!isalive(var_1)) {
    return;
  }
  if(isalive(var_1.enemy)) {}

  if(isDefined(var_1.lastenemysightpos)) {}

  if(isalive(var_1.goodenemy)) {}

  if(!var_1 scripts\anim\utility.gsc::hasenemysightpos()) {
    return;
  }
  var_6 = var_1 scripts\anim\utility.gsc::getenemysightpos();

  if(isDefined(var_1.goodshootpos))
    return;
}

drawenttag(var_0) {}

drawtag(var_0, var_1, var_2) {
  if(isDefined(self.model) && scripts\engine\utility::hastag(self.model, var_0)) {
    var_3 = self gettagorigin(var_0);
    var_4 = self gettagangles(var_0);
    drawarrow(var_3, var_4, var_1, var_2);
  }
}

drawarrow(var_0, var_1, var_2, var_3) {
  var_4 = 10;
  var_5 = anglesToForward(var_1);
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

  if(isDefined(var_2)) {
    var_12 = var_2;
    var_13 = var_2;
    var_14 = var_2;
  }

  if(!isDefined(var_3))
    var_3 = 1;
}

drawtagforever(var_0, var_1) {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    drawtag(var_0, var_1);
    wait 0.05;
  }
}

dragtaguntildeath(var_0, var_1) {
  self endon("death");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(self.origin)) {
      break;
    }

    drawtag(var_0, var_1);
    wait 0.05;
  }
}

viewtag(var_0, var_1) {
  if(var_0 == "ai") {
    var_2 = getaiarray();

    for(var_3 = 0; var_3 < var_2.size; var_3++)
      var_2[var_3] drawtag(var_1);
  }
}

debug_corner() {
  level.player.ignoreme = 1;
  var_0 = getallnodes();
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2].type == "Cover Left")
      var_1[var_1.size] = var_0[var_2];

    if(var_0[var_2].type == "Cover Right")
      var_1[var_1.size] = var_0[var_2];
  }

  var_3 = getaiarray();

  for(var_2 = 0; var_2 < var_3.size; var_2++)
    var_3[var_2] delete();

  level.debugspawners = getspawnerarray();
  level.activenodes = [];
  level.completednodes = [];

  for(var_2 = 0; var_2 < level.debugspawners.size; var_2++)
    level.debugspawners[var_2].targetname = "blah";

  var_4 = 0;

  for(var_2 = 0; var_2 < 30; var_2++) {
    if(var_2 >= var_1.size) {
      break;
    }

    var_1[var_2] thread covertest();
    var_4++;
  }

  if(var_1.size <= 30) {
    return;
  }
  for(;;) {
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

  for(;;) {
    for(var_2 = 0; var_2 < level.debugspawners.size; var_2++) {
      wait 0.05;
      var_1 = level.debugspawners[var_2];
      var_3 = 0;

      for(var_4 = 0; var_4 < level.activenodes.size; var_4++) {
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

      for(var_4 = 0; var_4 < level.completednodes.size; var_4++) {
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

      if(scripts\common\ai::spawn_failed(var_0)) {
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
    var_0 thread scripts\engine\sp\utility::debugorigin();
    thread createlineconstantly(var_0);
    var_0 waittill("death");
  }

  removeactivespawner(self);
  level.completednodes[level.completednodes.size] = self;
}

removeactivespawner(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < level.activenodes.size; var_2++) {
    if(level.activenodes[var_2] == var_0) {
      continue;
    }
    var_1[var_1.size] = level.activenodes[var_2];
  }

  level.activenodes = var_1;
}

createline(var_0) {
  for(;;)
    wait 0.05;
}

createlineconstantly(var_0) {
  var_1 = undefined;

  while(isalive(var_0)) {
    var_1 = var_0.origin;
    wait 0.05;
  }

  for(;;)
    wait 0.05;
}

debugmisstime() {
  self notify("stopdebugmisstime");
  self endon("stopdebugmisstime");
  self endon("death");

  for(;;) {
    if(self.a.misstime <= 0) {} else {}

    wait 0.05;
  }
}

debugmisstimeoff() {
  self notify("stopdebugmisstime");
}

debugjump(var_0) {}

add_debugdvar_func(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.debug.dvarfuncs))
    level.debug.dvarfuncs = [];

  setdvarifuninitialized(var_0, "");
  var_4 = spawnStruct();
  var_4.func = var_1;

  if(isDefined(var_2))
    var_4.threaded = var_2;

  if(isDefined(var_3))
    var_4.unarchived = var_3;

  level.debug.dvarfuncs[var_0] = var_4;
}

debugdvars() {}

show_arrivalexit_state() {}

process_dvarfuncs() {}

remove_fxlighting_object() {}

create_fxlighting_object() {}

play_fxlighting_fx() {}

debug_fxlighting() {}

debug_fxlighting_buttons() {}

showdebugtrace() {
  var_0 = undefined;
  var_1 = undefined;
  var_0 = (15.1859, -12.2822, 4.071);
  var_1 = (947.2, -10918, 64.9514);

  for(;;) {
    wait 0.05;
    var_2 = var_0;
    var_3 = var_1;

    if(!isDefined(var_0))
      var_2 = level.tracestart;

    if(!isDefined(var_1))
      var_3 = level.player getEye();

    var_4 = scripts\engine\trace::_bullet_trace(var_2, var_3, 0, undefined);
  }
}

debug_character_count() {
  var_0 = newhudelem();
  var_0.alignx = "left";
  var_0.aligny = "middle";
  var_0.x = 10;
  var_0.y = 100;
  var_0.label = &"DEBUG_DRONES";
  var_0.alpha = 0;
  var_1 = newhudelem();
  var_1.alignx = "left";
  var_1.aligny = "middle";
  var_1.x = 10;
  var_1.y = 115;
  var_1.label = &"DEBUG_ALLIES";
  var_1.alpha = 0;
  var_2 = newhudelem();
  var_2.alignx = "left";
  var_2.aligny = "middle";
  var_2.x = 10;
  var_2.y = 130;
  var_2.label = &"DEBUG_AXIS";
  var_2.alpha = 0;
  var_3 = newhudelem();
  var_3.alignx = "left";
  var_3.aligny = "middle";
  var_3.x = 10;
  var_3.y = 145;
  var_3.label = &"DEBUG_VEHICLES";
  var_3.alpha = 0;
  var_4 = newhudelem();
  var_4.alignx = "left";
  var_4.aligny = "middle";
  var_4.x = 10;
  var_4.y = 160;
  var_4.label = &"DEBUG_TOTAL";
  var_4.alpha = 0;
  var_5 = "off";

  for(;;) {
    var_6 = getDvar("debug_character_count");

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

    var_7 = getEntArray("drone", "targetname").size;
    var_0 setvalue(var_7);
    var_8 = getaiarray("allies").size;
    var_1 setvalue(var_8);
    var_9 = getaiarray("bad_guys").size;
    var_2 setvalue(var_9);
    var_3 setvalue(getEntArray("script_vehicle", "classname").size);
    var_4 setvalue(var_7 + var_8 + var_9);
    wait 0.25;
  }
}

nuke() {
  if(!self.damageshield) {
    if(isDefined(self.unittype) && self.unittype == "c12")
      self kill((0, 0, -500), level.player);
    else
      self kill((0, 0, -500), level.player, level.player);
  }
}

debug_nuke() {}

camera() {
  wait 0.05;
  var_0 = getEntArray("camera", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = getEnt(var_0[var_1].target, "targetname");
    var_0[var_1].origin2 = var_2.origin;
    var_0[var_1].angles = vectortoangles(var_2.origin - var_0[var_1].origin);
  }

  for(;;) {
    var_3 = getaiarray("axis");

    if(!var_3.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    var_4 = [];

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      for(var_5 = 0; var_5 < var_3.size; var_5++) {
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

    for(var_1 = 0; var_1 < var_4.size; var_1++) {
      var_7 = var_4[var_1];
      var_8 = var_7.origin2;
      var_9 = var_7.origin;
      var_10 = vectortoangles((var_9[0], var_9[1], var_9[2]) - (var_8[0], var_8[1], var_8[2]));
      var_11 = (0, var_10[1], 0);
      var_12 = anglesToForward(var_11);
      var_10 = vectorNormalize(var_9 - level.player.origin);
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

    for(var_1 = 1; var_1 < var_6.size; var_1++) {
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
  setDvar("LTNQQOMQSO", "0");
}

setplayertocamera(var_0) {
  setDvar("LTNQQOMQSO", "2");
}

deathspawnerpreview() {
  waittillframeend;

  for(var_0 = 0; var_0 < 50; var_0++) {
    if(!isDefined(level.deathspawnerents[var_0])) {
      continue;
    }
    var_1 = level.deathspawnerents[var_0];

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(isDefined(var_3.truecount))
        continue;
    }
  }
}

lastsightposwatch() {}

watchminimap() {
  for(;;) {
    updateminimapsetting();
    wait 0.25;
  }
}

updateminimapsetting() {
  var_0 = getdvarfloat("scr_requiredMapAspectRatio", 1);

  if(!isDefined(level.minimapcornertargetname)) {
    setDvar("scr_minimap_corner_targetname", "minimap_corner");
    level.minimapcornertargetname = "minimap_corner";
  }

  if(!isDefined(level.minimapheight)) {
    setDvar("scr_minimap_height", "0");
    level.minimapheight = 0;
  }

  var_1 = getdvarfloat("scr_minimap_height");
  var_2 = getDvar("scr_minimap_corner_targetname");

  if(var_1 != level.minimapheight || var_2 != level.minimapcornertargetname) {
    if(isDefined(level.minimaporigin)) {
      level.minimapplayer unlink();
      level.minimaporigin delete();
      level notify("end_draw_map_bounds");
    }

    if(var_1 > 0) {
      level.minimapheight = var_1;
      level.minimapcornertargetname = var_2;
      var_3 = level.player;
      var_4 = getEntArray(var_2, "targetname");

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

        if(isplatformpc()) {
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
        setsaveddvar("QTSPTNLOL", var_20);
        level.minimapplayer = var_3;
        level.minimaporigin = var_9;
        thread drawminimapbounds(var_5, var_7, var_6);
      } else {}
    }
  }
}

getchains() {
  var_0 = [];
  var_0 = getEntArray("minimap_line", "script_noteworthy");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_1[var_2] = var_0[var_2] getchain();

  return var_1;
}

getchain() {
  var_0 = [];
  var_1 = self;

  while(isDefined(var_1)) {
    var_0[var_0.size] = var_1;

    if(!isDefined(var_1) || !isDefined(var_1.target)) {
      break;
    }

    var_1 = getEnt(var_1.target, "targetname");

    if(isDefined(var_1) && var_1 == var_0[0]) {
      var_0[var_0.size] = var_1;
      break;
    }
  }

  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++)
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
  var_5 = vectorNormalize((var_5[0], var_5[1], 0));
  var_1 = var_1 + vecscale(var_5, var_4 * 1 / 800 * 0);
  var_6 = var_2 - var_0;
  var_6 = vectorNormalize((var_6[0], var_6[1], 0));
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

  for(;;) {
    scripts\engine\utility::array_levelthread(var_17, scripts\engine\utility::plot_points);
    wait 0.05;
  }
}

debug_colornodes() {
  wait 0.05;
  var_0 = getaiarray();
  var_1 = [];
  var_1["axis"] = [];
  var_1["allies"] = [];
  var_1["neutral"] = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.currentcolorcode)) {
      continue;
    }
    var_1[var_3.team][var_3.currentcolorcode] = 1;
    var_4 = (1, 1, 1);

    if(isDefined(var_3.script_forcecolor))
      var_4 = level.color_debug[var_3.script_forcecolor];

    if(var_3.team == "axis") {
      continue;
    }
    var_3 try_to_draw_line_to_node();
  }

  draw_colornodes(var_1, "allies");
  draw_colornodes(var_1, "axis");
}

draw_colornodes(var_0, var_1) {
  var_2 = getarraykeys(var_0[var_1]);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = (1, 1, 1);
    var_4 = level.color_debug[getsubstr(var_2[var_3], 0, 1)];

    if(isDefined(level.colornodes_debug_array[var_1][var_2[var_3]])) {
      var_5 = level.colornodes_debug_array[var_1][var_2[var_3]];

      for(var_6 = 0; var_6 < var_5.size; var_6++) {}
    }

    if(isDefined(level.colorvolumes_debug_array[var_1][var_2[var_3]])) {
      var_7 = level.colorvolumes_debug_array[var_1][var_2[var_3]];
      thread scripts\engine\utility::draw_entity_bounds(var_7, 0.05, var_4, 0);
    }
  }
}

get_team_substr() {
  if(self.team == "allies") {
    if(!isDefined(self.node.script_color_allies)) {
      return;
    }
    return self.node.script_color_allies;
  }

  if(self.team == "axis") {
    if(!isDefined(self.node.script_color_axis)) {
      return;
    }
    return self.node.script_color_axis;
  }
}

try_to_draw_line_to_node() {
  if(!isDefined(self.node)) {
    return;
  }
  if(!isDefined(self.script_forcecolor)) {
    return;
  }
  var_0 = get_team_substr();

  if(!isDefined(var_0)) {
    var_1 = level.arrays_of_colorcoded_volumes[scripts\sp\colors::get_team()][self.currentcolorcode];

    if(isDefined(var_1)) {}

    return;
  }

  if(!issubstr(var_0, self.script_forcecolor))
    return;
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

  if(isDefined(var_1)) {
    var_4 = self getthreatbiasgroup();

    if(isDefined(var_4)) {
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
  var_8 = !isPlayer(self) && self.pacifist;

  for(var_9 = 0; var_9 <= var_5; var_9++) {
    if(isDefined(var_1)) {}

    if(isDefined(var_4)) {}

    if(var_8) {}

    wait 0.05;
  }
}

debugcolorfriendlies() {
  level.debug_color_friendlies = [];
  level.debug_color_huds = [];

  for(;;) {
    level waittill("updated_color_friendlies");
    draw_color_friendlies();
  }
}

get_script_palette() {
  var_0 = [];
  var_0["r"] = (1, 0, 0);
  var_0["o"] = (1, 0.5, 0);
  var_0["y"] = (1, 1, 0);
  var_0["g"] = (0, 1, 0);
  var_0["c"] = (0, 1, 1);
  var_0["b"] = (0, 0, 1);
  var_0["p"] = (1, 0, 1);
  return var_0;
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
  var_3 = get_script_palette();

  for(var_4 = 0; var_4 < var_2.size; var_4++)
    var_1[var_2[var_4]] = 0;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = level.debug_color_friendlies[var_0[var_4]];
    var_1[var_5]++;
  }

  for(var_4 = 0; var_4 < level.debug_color_huds.size; var_4++)
    level.debug_color_huds[var_4] destroy();

  level.debug_color_huds = [];
  var_6 = 15;
  var_7 = 420;
  var_8 = 8;
  var_9 = var_8 + 2;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_1[var_2[var_4]] <= 0) {
      continue;
    }
    for(var_10 = 0; var_10 < var_1[var_2[var_4]]; var_10++) {
      var_11 = newhudelem();
      var_11.x = var_6 + var_9 * var_10;
      var_11.y = var_7;
      var_11 setshader("white", var_8, var_8);
      var_11.horzalign = "left";
      var_11.vertalign = "top";
      var_11.alignx = "left";
      var_11.aligny = "bottom";
      var_11.alpha = 1;
      var_11.color = var_3[var_2[var_4]];
      level.debug_color_huds[level.debug_color_huds.size] = var_11;
    }

    var_7 = var_7 - var_9;
  }
}

get_alias_from_stored(var_0) {
  if(!isDefined(level.animsound_aliases[var_0.animname])) {
    return;
  }
  if(!isDefined(level.animsound_aliases[var_0.animname][var_0.anime])) {
    return;
  }
  if(!isDefined(level.animsound_aliases[var_0.animname][var_0.anime][var_0.notetrack])) {
    return;
  }
  return level.animsound_aliases[var_0.animname][var_0.anime][var_0.notetrack]["soundalias"];
}

is_from_animsound(var_0, var_1, var_2) {
  return isDefined(level.animsound_aliases[var_0][var_1][var_2]["created_by_animSound"]);
}

debug_animsoundtag(var_0) {}

debug_animsoundtagselected() {}

tag_sound(var_0, var_1) {
  if(!isDefined(level.animsound_tagged)) {
    return;
  }
  if(!isDefined(level.animsound_tagged.animsounds[var_1])) {
    return;
  }
  var_2 = level.animsound_tagged.animsounds[var_1];
  var_3 = get_alias_from_stored(var_2);

  if(!isDefined(var_3) || is_from_animsound(var_2.animname, var_2.anime, var_2.notetrack)) {
    level.animsound_aliases[var_2.animname][var_2.anime][var_2.notetrack]["soundalias"] = var_0;
    level.animsound_aliases[var_2.animname][var_2.anime][var_2.notetrack]["created_by_animSound"] = 1;
  }
}

find_new_chase_target(var_0) {}

chasecam(var_0) {
  if(!isDefined(level.chase_cam_last_num))
    level.chase_cam_last_num = -1;

  if(level.chase_cam_last_num == var_0) {
    return;
  }
  find_new_chase_target(var_0);

  if(!isDefined(level.chase_cam_target)) {
    return;
  }
  level.chase_cam_last_num = var_0;

  if(!isDefined(level.chase_cam_ent))
    level.chase_cam_ent = level.chase_cam_target scripts\engine\utility::spawn_tag_origin();

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

  for(;;) {
    wait 0.2;

    if(!isDefined(level.chase_cam_target)) {
      return;
    }
    var_1 = level.chase_cam_target.origin;
    var_2 = level.chase_cam_target.angles;
    var_3 = anglesToForward(var_2);
    var_3 = var_3 * 200;
    var_1 = var_1 + var_3;
    var_2 = level.player getplayerangles();
    var_3 = anglesToForward(var_2);
    var_3 = var_3 * -200;
    level.chase_cam_ent moveTo(var_1 + var_3, 0.2);
  }
}

viewfx() {
  foreach(var_1 in level.createfxent) {
    if(isDefined(var_1.looper)) {}
  }
}

add_key(var_0, var_1) {}

print_vehicle_info(var_0) {
  if(!isDefined(level.vnum))
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

  if(isDefined(var_0))
    add_key("script_noteworthy", var_0);
}

draw_dot_for_ent(var_0) {}

draw_dot_for_guy() {
  var_0 = level.player getplayerangles();
  var_1 = anglesToForward(var_0);
  var_2 = level.player getEye();
  var_3 = self getEye();
  var_4 = vectortoangles(var_3 - var_2);
  var_5 = anglesToForward(var_4);
  var_6 = vectordot(var_5, var_1);
}

measure() {}

take_weapons_away() {
  var_0 = spawnStruct();
  var_0.weapons = level.player getweaponslistall();
  var_0.clip_ammo = [];
  var_0.stock_ammo = [];

  foreach(var_3, var_2 in var_0.weapons) {
    var_0.clip_ammo[var_3] = level.player getweaponammoclip(var_2);
    var_0.stock_ammo[var_3] = level.player getweaponammostock(var_2);
  }

  level.player takeallweapons();
  return var_0;
}

give_weapons_back(var_0) {
  var_1 = -1;

  foreach(var_4, var_3 in var_0.weapons) {
    level.player giveweapon(var_3);

    if(var_3.ismelee) {
      level.player assignweaponmeleeslot(var_3);
      continue;
    }

    if(var_1 < 0)
      var_1 = var_4;

    if(isDefined(var_0.clip_ammo[var_4]))
      level.player setweaponammoclip(var_3, var_0.clip_ammo[var_4]);

    if(isDefined(var_0.stock_ammo[var_4]))
      level.player setweaponammostock(var_3, var_0.stock_ammo[var_4]);
  }

  level.player switchtoweapon(var_0.weapons[var_1]);
}

debug_cursor(var_0) {
  level.debug.cursor_pos = (0, 0, 0);
  level notify("stop_debug_cursor");
  level endon("stop_debug_cursor");

  if(!isDefined(var_0))
    var_0 = 0;

  for(;;) {
    var_1 = level.player getEye();
    var_2 = anglesToForward(level.player getplayerangles());

    if(var_0)
      var_3 = var_1 + var_2 * 1000;
    else
      var_3 = var_1 + var_2 * 10000;

    var_4 = scripts\engine\trace::_bullet_trace(var_1, var_3, 0);

    if(var_0)
      level.debug.cursor_pos = getclosestpointonnavmesh(var_4["position"]) + (0, 0, -2);
    else
      level.debug.cursor_pos = var_4["position"];

    waitframe();
  }
}

draw_debug_cross(var_0) {
  level endon("stop_debug_cursor");
  var_1 = 4;
  var_2 = (1, 1, 1);
  var_3 = 1;
  var_4 = 1;
}

draw_spawner(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 0;

  var_5 = anglestoup(var_1);
  var_6 = anglesToForward(var_1);
  var_7 = var_0 + var_5 * 72 * 0.5;
  var_8 = var_7 + var_6 * 32;
  draw_small_arrow(var_7, var_8, var_2, var_3, var_4);
  draw_box(var_0, var_2, var_1, [32, 72], var_3, var_4);
}

draw_node(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_3))
    var_3 = 32;

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_5))
    var_5 = 0;

  var_6 = anglestoup(var_1);
  var_7 = anglesToForward(var_1);
  var_8 = var_0 + var_6 * var_3 * 0.5;
  var_9 = var_8 + var_7 * var_3;
  draw_small_arrow(var_8, var_9, var_2, var_4, var_5);
  draw_box(var_0, var_2, var_1, var_3, var_4, var_5);
}

draw_small_arrow(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 0;

  var_5 = vectortoangles(var_1 - var_0);
  var_6 = length(var_1 - var_0);
  var_7 = anglesToForward(var_5);
  var_8 = var_7 * var_6;
  var_9 = 5;
  var_10 = var_7 * (var_6 - var_9);
  var_11 = anglestoright(var_5);
  var_12 = var_11 * (var_9 * -1);
  var_13 = var_11 * var_9;
}

draw_box(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    var_6 = 32;
    var_7 = 32;
  } else if(!isarray(var_3)) {
    var_6 = var_3;
    var_7 = var_3;
  } else {
    var_6 = var_3[0];
    var_7 = var_3[1];
  }

  if(!isDefined(var_2))
    var_2 = (0, 0, 0);

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_5))
    var_5 = 0;

  var_8 = anglesToForward(var_2);
  var_9 = anglestoright(var_2);
  var_10 = anglestoup(var_2);
  var_11 = var_0 + var_8 * var_6 * 0.5;
  var_11 = var_11 + var_9 * var_6 * 0.5;
  var_12 = [];
  var_12[var_12.size] = var_11;
  var_12[var_12.size] = var_12[var_12.size - 1] + var_8 * var_6 * -1;
  var_12[var_12.size] = var_12[var_12.size - 1] + var_9 * var_6 * -1;
  var_12[var_12.size] = var_12[var_12.size - 1] + var_8 * var_6;
  var_13 = var_7 * var_10;

  for(var_14 = 0; var_14 < var_12.size; var_14++) {
    if(var_14 == var_12.size - 1)
      continue;
  }
}

print_timer() {}

display_ai_group_info() {
  if(!isDefined(level._ai_group)) {
    return;
  }
  foreach(var_6, var_1 in level._ai_group) {
    foreach(var_3 in var_1.ai) {
      if(isalive(var_3)) {
        if(var_3.team == "axis")
          var_4 = (1, 0, 0);
        else
          var_4 = (0, 1, 0);
      }
    }
  }
}

show_animnames() {}