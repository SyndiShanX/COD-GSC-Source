/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\debug.gsc
***********************************************/

function entity_count() {}

function entity_count_hud() {}

function get_total_count_color(var0) {}

function adjust_entcounthud_pos() {}

function set_entity_count_hud(var0, var1, var2) {}

function entity_count_delta(var0, var1) {}

function adjust_entity_count_hud_color(var0) {}

function get_entity_count_list(var0, var1) {
  var2 = getEntArray();
  var3 = [];

  if(!isDefined(var0)) {
    var0 = 0;
  }

  foreach(var8, var5 in var2) {
    if(!isDefined(var5.classname)) {
      var6 = "UNKNOWN?";
    } else {
      var6 = var5.classname;
    }

    if(var0) {
      if(isai(var5)) {
        var6 = "actors";
      } else if(isspawner(var5)) {
        var7 = getsubstr(var6, 0, 5);

        if(var7 == "actor") {
          var6 = "AI_spawners";
        } else {
          var6 = "vehicle_spawners";
        }
      } else if(isDefined(var5.createfx_ent)) {
        var6 = var5.classname + " CREATEFX";
      } else if(!isDefined(var5.code_classname)) {} else if(var5.code_classname == "script_model") {
        if(var5.model == "tag_origin") {
          var6 = "script_model TAG_ORIGIN";
        }
      } else if(var5.code_classname == "trigger_multiple") {
        var7 = getsubstr(var6, 0, 22);

        if(var7 == "trigger_multiple_bcs_") {
          var6 = "trigger_multiple_bcs";
        } else {
          var6 = "trigger_multiple";
        }
      } else {
        var7 = getsubstr(var6.code_classname, 0, 10);

        if(var7 == "weapon_iw8") {
          var8 = "weapons";
        }

        var7 = getsubstr(var6.code_classname, 0, 5);

        if(var7 == "actor") {
          var8 = "drones";
        }
      }
    } else {
      if(isDefined(var6.createfx_ent)) {
        var8 = "CREATEFX " + var6.classname;
      }

      if(var8 == "script_model") {
        var8 += " " + var6.model;
      }
    }

    if(!isDefined(var4[var8])) {
      var4 = 0;
    }

    var4++;
  }

  var5 = undefined;
  var7 = undefined;

  if(!isDefined(var2) || !var2) {
    var4 = sort_by_key(var4);
  }

  return var4;
}

function sort_by_key(var0) {
  var1 = getarraykeys(var0);

  for(var2 = 0; var2 < var1.size - 1; var2++) {
    for(var3 = var2 + 1; var3 < var1.size; var3++) {
      if(stricmp(var1[var2], var1[var3]) > 0) {
        var4 = var1[var3];
        var1 = var1[var2];
        var1 = var4;
      }
    }
  }

  var5 = [];
  var2 = 0;

  if(var2 < var1.size) {
    GscBinSkip0(0x2e, var1[var2], var0[var1[var2]]);
  }

  return var5;
}

function debug_enemypos(var0) {
  var1 = getaiarray();

  for(var2 = 0; var2 < var1.size; var2++) {
    if(var1[var2] getentitynumber() != var0) {
      continue;
    }

    thread debug_enemyposproc();
    break;
  }
}

function debug_stopenemypos(var0) {
  var1 = getaiarray();

  for(var2 = 0; var2 < var1.size; var2++) {
    if(var1[var2] getentitynumber() != var0) {
      continue;
    }

    var1[var2] notify("stop_drawing_enemy_pos");
    break;
  }
}

function debug_enemyposproc() {
  self endon("death");
  self endon("stop_drawing_enemy_pos");

  for(;;) {
    wait 0.05;

    if(isalive(self.enemy)) {}

    if(!scripts\anim\utility::hasenemysightpos()) {
      continue;
    }

    var0 = scripts\anim\utility::getenemysightpos();
  }
}

function debug_enemyposreplay() {
  var0 = getaiarray();
  var1 = undefined;
  var2 = 0;

  while(var2 < var0.size) {
    var1 = var0[var2];

    if(!isalive(var1)) {} else {
      if(isDefined(var1.lastenemysightpos)) {}

      if(isDefined(var1.goodshootpos)) {
        if(var1 isbadguy()) {
          var3 = (1, 0, 0);
        } else {
          var3 = (0, 0, 1);
        }

        var4 = var2.origin + (0, 0, 54);

        if(isDefined(var2.node)) {
          if(var2.node.type == "Cover Left") {
            var5 = 1;
            var4 = anglestoright(var2.node.angles);
            var4 *= -32;
            var4 = (var4[0], var4[1], 64);
            var4 = var2.node.origin + var4;
          } else if(var2.node.type == "Cover Right") {
            var5 = 1;
            var4 = anglestoright(var2.node.angles);
            var4 *= 32;
            var4 = (var4[0], var4[1], 64);
            var4 = var2.node.origin + var4;
          }
        }

        scripts\engine\utility::draw_arrow(var4, var2.goodshootpos, var3);
      }
    }

    var3++;
  }

  if(true) {
    return;
  }

  if(!isalive(var2)) {
    return;
  }

  if(isalive(var2.enemy)) {}

  if(isDefined(var2.lastenemysightpos)) {}

  if(isalive(var2.goodenemy)) {}

  if(!var2 scripts\anim\utility::hasenemysightpos()) {
    return;
  }

  var6 = var2 scripts\anim\utility::getenemysightpos();

  if(isDefined(var2.goodshootpos)) {
    return;
  }
}

function drawenttag(var0) {}

function drawtag(var0, var1, var2) {
  if(isDefined(self.model) && scripts\engine\utility::hastag(self.model, var0)) {
    var3 = self gettagorigin(var0);
    var4 = self gettagangles(var0);
    drawarrow(var3, var4, var1, var2);
    return;
  }
}

function drawarrow(var0, var1, var2, var3) {
  var4 = 10;
  var5 = anglesToForward(var1);
  var6 = var5 * var4;
  var7 = var5 * var4 * 0.8;
  var8 = anglestoright(var1);
  var9 = var8 * var4 * -0.2;
  var10 = var8 * var4 * 0.2;
  var11 = anglestoup(var1);
  var8 *= var4;
  var11 *= var4;
  var12 = (0.9, 0.2, 0.2);
  var13 = (0.2, 0.9, 0.2);
  var14 = (0.2, 0.2, 0.9);

  if(isDefined(var2)) {
    var12 = var2;
    var13 = var2;
    var14 = var2;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }
}

function drawtagforever(var0, var1) {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    drawtag(var0, var1);
    wait 0.05;
  }
}

function dragtaguntildeath(var0, var1) {
  self endon("death");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(self.origin)) {
      break;
    }

    drawtag(var0, var1);
    wait 0.05;
  }
}

function viewtag(var0, var1) {
  if(var0 == "ai") {
    var2 = getaiarray();

    for(var3 = 0; var3 < var2.size; var3++) {
      drawtag(var2[var3], var1);
    }

    return;
  }
}

function debug_corner() {
  level.player.ignoreme = 1;
  var0 = getallnodes();
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    if(var0[var2].type == "Cover Left") {
      var1 = var0[var2];
    }

    if(var0[var2].type == "Cover Right") {
      var1 = var0[var2];
    }
  }

  var3 = getaiarray();

  for(var2 = 0; var2 < var3.size; var2++) {
    var3[var2] delete();
  }

  level.debugspawners = getspawnerarray();
  level.activenodes = [];
  level.completednodes = [];

  for(var2 = 0; var2 < level.debugspawners.size; var2++) {
    level.debugspawners[var2].targetname = "blah";
  }

  var4 = 0;

  for(var2 = 0; var2 < 30; var2++) {
    if(var2 >= var1.size) {
      break;
    }

    thread covertest();
    var4++;
  }

  if(var1.size <= 30) {
    return;
  }

  for(;;) {
    level waittill("debug_next_corner");

    if(var4 >= var1.size) {
      var4 = 0;
    }

    thread covertest();
    var4++;
  }
}

function covertest() {
  coversetupanim();
}

function coversetupanim() {
  var0 = undefined;
  var1 = undefined;

  for(;;) {
    for(var2 = 0; var2 < level.debugspawners.size; var2++) {
      wait 0.05;
      var1 = level.debugspawners[var2];
      var3 = 0;

      for(var4 = 0; var4 < level.activenodes.size; var4++) {
        if(distance(level.activenodes[var4].origin, self.origin) > 250) {
          continue;
        }

        var3 = 1;
        break;
      }

      if(var3) {
        continue;
      }

      var5 = 0;

      for(var4 = 0; var4 < level.completednodes.size; var4++) {
        if(level.completednodes[var4] != self) {
          continue;
        }

        var5 = 1;
        break;
      }

      if(var5) {
        continue;
      }

      level.activenodes[level.activenodes.size] = self;
      var1.origin = self.origin;
      var1.angles = self.angles;
      var1.count = 1;
      var0 = var1 stalingradspawn();

      if(scripts\common\ai::spawn_failed(var0)) {
        removeactivespawner(self);
        continue;
      }

      break;
    }

    if(isalive(var0)) {
      break;
    }
  }

  wait 1;

  if(isalive(var0)) {
    var0.ignoreme = 1;
    var0.team = "neutral";
    var0 setgoalpos(var0.origin);
    thread createline(self.origin);
    var0 thread scripts\engine\sp\utility::debugorigin();
    thread createlineconstantly(var0);
    var0 waittill("death");
  }

  removeactivespawner(self);
  level.completednodes[level.completednodes.size] = self;
}

function removeactivespawner(var0) {
  var1 = [];

  for(var2 = 0; var2 < level.activenodes.size; var2++) {
    if(level.activenodes[var2] == var0) {
      continue;
    }

    var1 = level.activenodes[var2];
  }

  level.activenodes = var1;
}

function createline(var0) {
  for(;;) {
    wait 0.05;
  }
}

function createlineconstantly(var0) {
  var1 = undefined;

  while(isalive(var0)) {
    var1 = var0.origin;
    wait 0.05;
  }

  for(;;) {
    wait 0.05;
  }
}

function debugmisstime() {
  self notify("stopdebugmisstime");
  self endon("stopdebugmisstime");
  self endon("death");

  for(;;) {
    if(self.a.misstime <= 0) {}

    wait 0.05;
  }
}

function debugmisstimeoff() {
  self notify("stopdebugmisstime");
}

function debugjump(var0) {}

function add_debugdvar_func(var0, var1, var2, var3) {
  if(!isDefined(level.debug.dvarfuncs)) {
    level.debug.dvarfuncs = [];
  }

  setdvarifuninitialized(var0, "");
  var4 = spawnStruct();
  var4.func = var1;

  if(isDefined(var2)) {
    var4.threaded = var2;
  }

  if(isDefined(var3)) {
    var4.unarchived = var3;
  }

  level.debug.dvarfuncs[var0] = var4;
}

function debugdvars() {}

function show_arrivalexit_state() {}

function process_dvarfuncs() {}

function remove_fxlighting_object() {}

function create_fxlighting_object() {}

function play_fxlighting_fx() {}

function debug_fxlighting() {}

function debug_fxlighting_buttons() {}

function showdebugtrace() {
  var0 = undefined;
  var1 = undefined;
  var0 = (15.1859, -12.2822, 4.071);
  var1 = (947.2, -10918, 64.9514);

  for(;;) {
    wait 0.05;
    var2 = var0;
    var3 = var1;

    if(!isDefined(var0)) {
      var2 = level.tracestart;
    }

    if(!isDefined(var1)) {
      var3 = level.player getEye();
    }

    var4 = scripts\engine\trace::_bullet_trace(var2, var3, 0, undefined);
  }
}

function debug_character_count() {
  var0 = newhudelem();
  var0.alignx = "left";
  var0.aligny = "middle";
  var0.x = 10;
  var0.y = 100;
  var0.label = &"DEBUG_DRONES";
  var0.alpha = 0;
  var1 = newhudelem();
  var1.alignx = "left";
  var1.aligny = "middle";
  var1.x = 10;
  var1.y = 115;
  var1.label = &"DEBUG_ALLIES";
  var1.alpha = 0;
  var2 = newhudelem();
  var2.alignx = "left";
  var2.aligny = "middle";
  var2.x = 10;
  var2.y = 130;
  var2.label = &"DEBUG_AXIS";
  var2.alpha = 0;
  var3 = newhudelem();
  var3.alignx = "left";
  var3.aligny = "middle";
  var3.x = 10;
  var3.y = 145;
  var3.label = &"DEBUG_VEHICLES";
  var3.alpha = 0;
  var4 = newhudelem();
  var4.alignx = "left";
  var4.aligny = "middle";
  var4.x = 10;
  var4.y = 160;
  var4.label = &"DEBUG_TOTAL";
  var4.alpha = 0;
  var5 = "off";

  for(;;) {
    var6 = getDvar("debug_character_count");

    if(var6 == "off") {
      if(var6 != var5) {
        var0.alpha = 0;
        var1.alpha = 0;
        var2.alpha = 0;
        var3.alpha = 0;
        var4.alpha = 0;
        var5 = var6;
      }

      wait 0.25;
      continue;
    } else if(var6 != var5) {
      var0.alpha = 1;
      var1.alpha = 1;
      var2.alpha = 1;
      var3.alpha = 1;
      var4.alpha = 1;
      var5 = var6;
    }

    var7 = getEntArray("drone", "targetname").size;
    var0 setvalue(var7);
    var8 = getaiarray("allies").size;
    var1 setvalue(var8);
    var9 = getaiarray("bad_guys").size;
    var2 setvalue(var9);
    var3 setvalue(getEntArray("script_vehicle", "classname").size);
    var4 setvalue(var7 + var8 + var9);
    wait 0.25;
  }
}

function nuke() {
  if(!self.damageshield) {
    if(isDefined(self.unittype) && self.unittype == "c12") {
      self kill((0, 0, -500), level.player);
      return;
    }

    self kill((0, 0, -500), level.player, level.player);
    return;
  }
}

function debug_nuke() {}

function camera() {
  wait 0.05;
  var0 = getEntArray("camera", "targetname");

  for(var1 = 0;; var1++) {
    jumpiffalse(var1 < var0.size) LOC_0000006a;
    var2 = getEnt(var0[var1].target, "targetname");
    var0[var1].origin2 = var2.origin;
    var0[var1].angles = vectortoangles(var2.origin - var0[var1].origin);
  }

  for(;;) {
    var3 = getaiarray("axis");

    if(!var3.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    var4 = [];

    for(var1 = 0; var1 < var0.size; var1++) {
      for(var5 = 0; var5 < var3.size; var5++) {
        if(distance(var0[var1].origin, var3[var5].origin) > 256) {
          continue;
        }

        var4 = var0[var1];
        break;
      }
    }

    if(!var4.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    var6 = [];

    for(var1 = 0; var1 < var4.size; var1++) {
      var7 = var4[var1];
      var8 = var7.origin2;
      var9 = var7.origin;
      var10 = vectortoangles((var9[0], var9[1], var9[2]) - (var8[0], var8[1], var8[2]));
      var11 = (0, var10[1], 0);
      var12 = anglesToForward(var11);
      var10 = vectorNormalize(var9 - level.player.origin);
      var13 = vectordot(var12, var10);

      if(var13 < 0.85) {
        continue;
      }

      var6 = var7;
    }

    if(!var6.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    var14 = distance(level.player.origin, var6[0].origin);
    var15 = var6[0];

    for(var1 = 1; var1 < var6.size; var1++) {
      var16 = distance(level.player.origin, var6[var1].origin);

      if(var16 > var14) {
        continue;
      }

      var15 = var6[var1];
      var14 = var16;
    }

    setplayertocamera(var15);
    wait 3;
  }
}

function freeplayer() {
  setDvar("LTNQQOMQSO", "0");
}

function setplayertocamera(var0) {
  setDvar("LTNQQOMQSO", "2");
}

function deathspawnerpreview() {
  waittillframeend();

  for(var0 = 0; var0 < 50; var0++) {
    if(!isDefined(level.deathspawnerents[var0])) {
      continue;
    }

    var1 = level.deathspawnerents[var0];

    for(var2 = 0; var2 < var1.size; var2++) {
      var3 = var1[var2];

      if(isDefined(var3.truecount)) {}
    }
  }
}

function lastsightposwatch() {}

function watchminimap() {
  for(;;) {
    updateminimapsetting();
    wait 0.25;
  }
}

function updateminimapsetting() {
  var0 = getdvarfloat("scr_requiredMapAspectRatio", 1);

  if(!isDefined(level.minimapcornertargetname)) {
    setDvar("scr_minimap_corner_targetname", "minimap_corner");
    level.minimapcornertargetname = "minimap_corner";
  }

  if(!isDefined(level.minimapheight)) {
    setDvar("scr_minimap_height", "0");
    level.minimapheight = 0;
  }

  var1 = getdvarfloat("scr_minimap_height");
  var2 = getDvar("scr_minimap_corner_targetname");

  if(var1 != level.minimapheight || var2 != level.minimapcornertargetname) {
    if(isDefined(level.minimaporigin)) {
      level.minimapplayer unlink();
      level.minimaporigin delete();
      level notify("end_draw_map_bounds");
    }

    if(var1 > 0) {
      level.minimapheight = var1;
      level.minimapcornertargetname = var2;
      var3 = level.player;
      var4 = getEntArray(var2, "targetname");

      if(var4.size == 2) {
        var5 = var4[0].origin + var4[1].origin;
        var5 = (var5[0] * 0.5, var5[1] * 0.5, var5[2] * 0.5);
        var6 = (var4[0].origin[0], var4[0].origin[1], var5[2]);
        var7 = (var4[0].origin[0], var4[0].origin[1], var5[2]);

        if(var4[1].origin[0] > var4[0].origin[0]) {
          var6 = (var4[1].origin[0], var6[1], var6[2]);
        } else {
          var7 = (var4[1].origin[0], var7[1], var7[2]);
        }

        if(var4[1].origin[1] > var4[0].origin[1]) {
          var6 = (var6[0], var4[1].origin[1], var6[2]);
        } else {
          var7 = (var7[0], var4[1].origin[1], var7[2]);
        }

        var8 = var6 - var5;
        var5 = (var5[0], var5[1], var5[2] + var1);
        var9 = spawn("script_origin", var3.origin);
        var10 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
        var11 = (var10[1], 0 - var10[0], 0);
        var12 = vectordot(var10, var8);

        if(var12 < 0) {
          var12 = 0 - var12;
        }

        var13 = vectordot(var11, var8);

        if(var13 < 0) {
          var13 = 0 - var13;
        }

        if(var0 > 0) {
          var14 = var13 / var12;

          if(var14 < var0) {
            var15 = var0 / var14;
            var13 *= var15;
            var16 = vecscale(var11, vectordot(var11, var6 - var5) * (var15 - 1));
            var7 -= var16;
            var6 += var16;
          } else {
            var15 = var16 / var2;
            var14 *= var15;
            var16 = vecscale(var12, vectordot(var12, var8 - var7) * (var15 - 1));
            var9 -= var16;
            var8 += var16;
          }
        }

        if(isplatformpc()) {
          var17 = 1.77778;
          var18 = 2 * atan(var15 * 0.8 / var3);
          var19 = 2 * atan(var14 * var17 * 0.8 / var3);
        } else {
          var17 = 1.33333;
          var18 = 2 * atan(var19 * 1.05 / var6);
          var19 = 2 * atan(var18 * var17 * 1.05 / var6);
        }

        if(var18 > var19) {
          var20 = var18;
        } else {
          var20 = var20;
        }

        var21 = var7 - 1000;

        if(var21 < 16) {
          var21 = 16;
        }

        if(var21 > 10000) {
          var21 = 10000;
        }

        var9 playerlinktoabsolute(var15);
        var15.origin = var11 + (0, 0, -62);
        var15.angles = (90, getnorthyaw(), 0);
        var9 giveweapon("defaultweapon");
        setsaveddvar("QTSPTNLOL", var20);
        level.minimapplayer = var9;
        level.minimaporigin = var15;
        thread drawminimapbounds(var11, var13, var12);
        return;
      }

      return;
    }

    return;
  }
}

function getchains() {
  var0 = [];
  var0 = getEntArray("minimap_line", "script_noteworthy");
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    var1 = getchain(var0[var2]);
  }

  return var1;
}

function getchain() {
  var0 = [];
  var1 = self;

  while(isDefined(var1)) {
    var0 = var1;

    if(!isDefined(var1) || !isDefined(var1.target)) {
      break;
    }

    var1 = getEnt(var1.target, "targetname");

    if(isDefined(var1) && var1 == var0[0]) {
      var0 = var1;
      break;
    }
  }

  var2 = [];

  for(var3 = 0; var3 < var0.size; var3++) {
    var2 = var0[var3].origin;
  }

  return var2;
}

function vecscale(var0, var1) {
  return (var0[0] * var1, var0[1] * var1, var0[2] * var1);
}

function drawminimapbounds(var0, var1, var2) {
  level notify("end_draw_map_bounds");
  level endon("end_draw_map_bounds");
  var3 = var0[2] - var2[2];
  var4 = length(var1 - var2);
  var5 = var1 - var0;
  var5 = vectorNormalize((var5[0], var5[1], 0));
  var1 += vecscale(var5, var4 * 1 / 800 * 0);
  var6 = var2 - var0;
  var6 = vectorNormalize((var6[0], var6[1], 0));
  var2 += vecscale(var6, var4 * 1 / 800 * 0);
  var7 = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  var8 = var2 - var1;
  var9 = vecscale(var7, vectordot(var8, var7));
  var10 = vecscale(var7, abs(vectordot(var8, var7)));
  var11 = var1;
  var12 = var1 + var9;
  var13 = var2;
  var14 = var2 - var9;
  var15 = vecscale(var1 + var2, 0.5) + vecscale(var10, 0.51);
  var16 = var4 * 0.003;
  var17 = getchains();

  for(;;) {
    scripts\engine\utility::array_levelthread(var17, &scripts\engine\utility::plot_points);
    wait 0.05;
  }
}

function debug_colornodes() {
  wait 0.05;
  var0 = getaiarray();
  var1 = [];
  GscBinSkip0(0x2e, "axis", []);
}

function draw_colornodes(var0, var1) {
  var2 = getarraykeys(var0[var1]);

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = (1, 1, 1);
    var4 = level.color_debug[getsubstr(var2[var3], 0, 1)];

    if(isDefined(level.colornodes_debug_array[var1][var2[var3]])) {
      var5 = level.colornodes_debug_array[var1][var2[var3]];

      for(var6 = 0; var6 < var5.size; var6++) {}
    }

    if(isDefined(level.colorvolumes_debug_array[var1][var2[var3]])) {
      var7 = level.colorvolumes_debug_array[var1][var2[var3]];
      thread scripts\engine\utility::draw_entity_bounds(var7, 0.05, var4, 0);
    }
  }
}

function get_team_substr() {
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

function try_to_draw_line_to_node() {
  if(!isDefined(self.node)) {
    return;
  }

  if(!isDefined(self.script_forcecolor)) {
    return;
  }

  var0 = get_team_substr();

  if(!isDefined(var0)) {
    var1 = level.arrays_of_colorcoded_volumes[scripts\sp\colors::get_team()][self.currentcolorcode];

    if(isDefined(var1)) {}

    return;
  }

  if(!issubstr(var1, self.script_forcecolor)) {
    return;
  }
}

function debugthreat() {
  level.last_threat_debug = gettime();
  thread debugthreatcalc();
}

function debugthreatcalc() {}

function displaythreat(var0, var1) {
  if(self.team == var0.team) {
    return;
  }

  var2 = 0;
  var2 += self.threatbias;
  var3 = 0;
  var3 += var0.threatbias;
  var4 = undefined;

  if(isDefined(var1)) {
    var4 = self getthreatbiasgroup();

    if(isDefined(var4)) {
      var3 += getthreatbias(var1, var4);
      var2 += getthreatbias(var4, var1);
    }
  }

  if(var0.ignoreme || var3 < -900000) {
    var3 = "Ignore";
  }

  if(self.ignoreme || var2 < -900000) {
    var2 = "Ignore";
  }

  var5 = 20;
  var6 = (1, 0.5, 0.2);
  var7 = (0.2, 0.5, 1);
  var8 = !isPlayer(self) && self.pacifist;

  for(var9 = 0; var9 <= var5; var9++) {
    if(isDefined(var1)) {}

    if(isDefined(var4)) {}

    if(var8) {}

    wait 0.05;
  }
}

function debugcolorfriendlies() {
  level.debug_color_friendlies = [];
  level.debug_color_huds = [];

  for(;;) {
    level waittill("updated_color_friendlies");
    draw_color_friendlies();
  }
}

function get_script_palette() {
  var0 = [];
  GscBinSkip0(0x2e, "r", (1, 0, 0));
}

function draw_color_friendlies() {
  level endon("updated_color_friendlies");
  var0 = getarraykeys(level.debug_color_friendlies);
  var1 = [];
  var2 = [];
  GscBinSkip0(0x2e, var2.size, "r");
}

function get_alias_from_stored(var0) {
  if(!isDefined(level.animsound_aliases[var0.animname])) {
    return;
  }

  if(!isDefined(level.animsound_aliases[var0.animname][var0.anime])) {
    return;
  }

  if(!isDefined(level.animsound_aliases[var0.animname][var0.anime][var0.notetrack])) {
    return;
  }

  return level.animsound_aliases[var0.animname][var0.anime][var0.notetrack]["soundalias"];
}

function is_from_animsound(var0, var1, var2) {
  return isDefined(level.animsound_aliases[var0][var1][var2]["created_by_animSound"]);
}

function debug_animsoundtag(var0) {}

function debug_animsoundtagselected() {}

function tag_sound(var0, var1) {
  if(!isDefined(level.animsound_tagged)) {
    return;
  }

  if(!isDefined(level.animsound_tagged.animsounds[var1])) {
    return;
  }

  var2 = level.animsound_tagged.animsounds[var1];
  var3 = get_alias_from_stored(var2);

  if(!isDefined(var3) || is_from_animsound(var2.animname, var2.anime, var2.notetrack)) {
    level.animsound_aliases[var2.animname][var2.anime][var2.notetrack]["soundalias"] = var0;
    level.animsound_aliases[var2.animname][var2.anime][var2.notetrack]["created_by_animSound"] = 1;
    return;
  }
}

function find_new_chase_target(var0) {}

function chasecam(var0) {
  if(!isDefined(level.chase_cam_last_num)) {
    level.chase_cam_last_num = -1;
  }

  if(level.chase_cam_last_num == var0) {
    return;
  }

  find_new_chase_target(var0);

  if(!isDefined(level.chase_cam_target)) {
    return;
  }

  level.chase_cam_last_num = var0;

  if(!isDefined(level.chase_cam_ent)) {
    level.chase_cam_ent = level.chase_cam_target scripts\engine\utility::spawn_tag_origin();
  }

  thread chasecam_onent(level.chase_cam_target);
}

function chasecam_onent(var0) {
  level notify("new_chasecam");
  level endon("new_chasecam");
  var0 endon("death");
  level.player unlink();
  level.player playerlinktoblend(level.chase_cam_ent, "tag_origin", 2, 0.5, 0.5);
  wait 2;
  level.player playerlinktodelta(level.chase_cam_ent, "tag_origin", 1, 180, 180, 180, 180);

  for(;;) {
    wait 0.2;

    if(!isDefined(level.chase_cam_target)) {
      return;
    }

    var1 = level.chase_cam_target.origin;
    var2 = level.chase_cam_target.angles;
    var3 = anglesToForward(var2);
    var3 *= 200;
    var1 += var3;
    var2 = level.player getplayerangles();
    var3 = anglesToForward(var2);
    var3 *= -200;
    level.chase_cam_ent moveTo(var1 + var3, 0.2);
  }
}

function viewfx() {
  foreach(var1 in level.createfxent) {
    if(isDefined(var1.looper)) {}
  }
}

function add_key(var0, var1) {}

function print_vehicle_info(var0) {
  if(!isDefined(level.vnum)) {
    level.vnum = 9500;
  }

  level.vnum++;
  var1 = "bridge_helpers";
  add_key("origin", self.origin[0] + " " + self.origin[1] + " " + self.origin[2]);
  add_key("angles", self.angles[0] + " " + self.angles[1] + " " + self.angles[2]);
  add_key("targetname", "helper_model");
  add_key("model", self.model);
  add_key("classname", "script_model");
  add_key("spawnflags", "4");
  add_key("_color", "0.443137 0.443137 1.000000");

  if(isDefined(var0)) {
    add_key("script_noteworthy", var0);
  }
}

function draw_dot_for_ent(var0) {}

function draw_dot_for_guy() {
  var0 = level.player getplayerangles();
  var1 = anglesToForward(var0);
  var2 = level.player getEye();
  var3 = self getEye();
  var4 = vectortoangles(var3 - var2);
  var5 = anglesToForward(var4);
  var6 = vectordot(var5, var1);
}

function measure() {}

function take_weapons_away() {
  var0 = spawnStruct();
  var0.weapons = level.player getweaponslistall();
  var0.clip_ammo = [];
  var0.stock_ammo = [];

  foreach(var2 in var0.weapons) {
    var0.clip_ammo[var3] = level.player getweaponammoclip(var2);
    var0.stock_ammo[var3] = level.player getweaponammostock(var2);
  }

  level.player takeallweapons();
  return var0;
}

function give_weapons_back(var0) {
  var1 = -1;

  foreach(var4, var3 in var0.weapons) {
    level.player giveweapon(var3);

    if(var3.ismelee) {
      level.player assignweaponmeleeslot(var3);
      continue;
    }

    if(var1 < 0) {
      var1 = var4;
    }

    if(isDefined(var0.clip_ammo[var4])) {
      level.player setweaponammoclip(var3, var0.clip_ammo[var4]);
    }

    if(isDefined(var0.stock_ammo[var4])) {
      level.player setweaponammostock(var3, var0.stock_ammo[var4]);
    }
  }

  level.player switchtoweapon(var0.weapons[var1]);
}

function debug_cursor(var0) {
  level.debug.cursor_pos = (0, 0, 0);
  level notify("stop_debug_cursor");
  level endon("stop_debug_cursor");
  jumpiftrue(isDefined(var0)) LOC_00000032;
  var0 = 0;

  for(;;) {
    var1 = level.player getEye();
    var2 = anglesToForward(level.player getplayerangles());

    if(var0) {
      var3 = var1 + var2 * 1000;
    } else {
      var3 = var1 + var2 * 10000;
    }

    var4 = scripts\engine\trace::_bullet_trace(var1, var3, 0);

    if(var0) {
      level.debug.cursor_pos = getclosestpointonnavmesh(var4["position"]) + (0, 0, -2);
    } else {
      level.debug.cursor_pos = var4["position"];
    }

    waitframe();
  }
}

function draw_debug_cross(var0) {
  level endon("stop_debug_cursor");
  var1 = 4;
  var2 = (1, 1, 1);
  var3 = 1;
  var4 = 1;
}

function draw_spawner(var0, var1, var2, var3, var4) {
  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  var5 = anglestoup(var1);
  var6 = anglesToForward(var1);
  var7 = var0 + var5 * 72 * 0.5;
  var8 = var7 + var6 * 32;
  draw_small_arrow(var7, var8, var2, var3, var4);
  draw_box(var0, var2, var1, [32, 72], var3, var4);
}

function draw_node(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  if(!isDefined(var3)) {
    var3 = 32;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  var6 = anglestoup(var1);
  var7 = anglesToForward(var1);
  var8 = var0 + var6 * var3 * 0.5;
  var9 = var8 + var7 * var3;
  draw_small_arrow(var8, var9, var2, var4, var5);
  draw_box(var0, var2, var1, var3, var4, var5);
}

function draw_small_arrow(var0, var1, var2, var3, var4) {
  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var4)) {
    var4 = 0;
  }

  var5 = vectortoangles(var1 - var0);
  var6 = length(var1 - var0);
  var7 = anglesToForward(var5);
  var8 = var7 * var6;
  var9 = 5;
  var10 = var7 * (var6 - var9);
  var11 = anglestoright(var5);
  var12 = var11 * var9 * -1;
  var13 = var11 * var9;
}

function draw_box(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var3)) {
    var6 = 32;
    var7 = 32;
  } else if(!isarray(var5)) {
    var6 = var5;
    var7 = var5;
  } else {
    var6 = var7[0];
    var7 = var7[1];
  }

  if(!isDefined(var6)) {
    var6 = (0, 0, 0);
  }

  if(!isDefined(var6)) {
    var6 = 1;
  }

  if(!isDefined(var7)) {
    var7 = 0;
  }

  var8 = anglesToForward(var6);
  var9 = anglestoright(var6);
  var10 = anglestoup(var6);
  var11 = var4 + var8 * var6 * 0.5;
  var11 += var9 * var6 * 0.5;
  var12 = [];
  GscBinSkip0(0x2e, var12.size, var11);
}

function print_timer() {}

function display_ai_group_info() {
  if(!isDefined(level._ai_group)) {
    return;
  }

  foreach(var1 in level._ai_group) {
    foreach(var3 in var1.ai) {
      if(isalive(var3)) {
        if(var3.team == "axis") {
          var4 = (1, 0, 0);
        } else {
          var4 = (0, 1, 0);
        }
      }
    }

    var3 = undefined;
    var6 = undefined;
  }

  var1 = undefined;
}

function show_animnames() {}