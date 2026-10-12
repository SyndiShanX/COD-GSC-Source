/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\stealth\debug.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#using scripts\stealth\utility;
#namespace debug;

function debug_manager() {
  setdvarifuninitialized(@ "debug_stealth", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_a3c8097b0584ad3c", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_29199fda70b29985", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_e24fb561372dfef1", -1);
  setdvarifuninitialized(@ "hash_d036770ff7a14497", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_f30debd28e3f37e1", "<dev string:x1c>");
  setdvarifuninitialized(@ "hash_99b5f3d24be9d6ca", "<dev string:x21>");
  setdvarifuninitialized(@ "hash_936a3d04dd90f9b7", "<dev string:x1c>");
  thread function_459a4d528437596();
  registersharedfunc("<dev string:x25>", "<dev string:x36>", &function_55f9cd7d60a115bb);

  while(true) {
    waitframe();

    if(!debug_enabled()) {
      continue;
    }

    draw_corpses();
    function_dd7ad6e8da294b01("<dev string:x4c>", "<dev string:x57>");
    function_dd7ad6e8da294b01("<dev string:x4c>", "<dev string:x6c>" + flag("<dev string:x81>"));
    function_dd7ad6e8da294b01("<dev string:x4c>", "<dev string:x94>" + flag("<dev string:xa9>"));
    function_20367cc98c4d2265("<dev string:x4c>");
    function_df6b11367f42a8e1();
    function_47439b5d33f2695a();
    function_477aac1963f8269e();
  }
}

function debug_player() {
  self endon("<dev string:xbc>");
  hudelem = newclienthudelem(self);
  hudelem.x = -50;
  hudelem.y = 450;
  hudelem.color = (0.5, 1, 0.5);
  hudelem.archived = 0;
  hudelem setdevtext("<dev string:xc5>");
  z = 0;
  space = 10;
  tab = "<dev string:xdf>";

  while(true) {
    if(debug_enabled()) {
      if(!isDefined(level.player.stealth) || !level.player flag("<dev string:x81>")) {
        hudelem.alpha = 0;
      } else {
        hudelem.alpha = 1;
      }

      function_dd7ad6e8da294b01("<dev string:xe5>", "<dev string:xef>");
      function_dd7ad6e8da294b01("<dev string:xe5>", "<dev string:xfb>" + self.script_stealthgroup);
      function_dd7ad6e8da294b01("<dev string:xe5>", "<dev string:x10e>" + level.player.maxvisibledist);

      if(level.player ent_flag("<dev string:x122>")) {
        function_dd7ad6e8da294b01("<dev string:xe5>", "<dev string:x137>");
      }
    } else {
      hudelem.alpha = 0;
    }

    function_20367cc98c4d2265("<dev string:xe5>");
    waitframe();
  }
}

function debug_friendly() {
  self endon("<dev string:xbc>");
  setdvarifuninitialized(@ "hash_67d1d2d65d5da2ab", "<dev string:x144>");

  while(true) {
    if(debug_enabled()) {
      space = 10;
      count = 0;

      if(ent_flag("<dev string:x122>")) {
        print3d(self.origin + (0, 0, count * space * -1), "<dev string:x14a>", (0.2, 1, 0.2), 1, 0.5);
      }

      count++;
      draw_enemies("<dev string:x157>");
      waitframe();
      continue;
    }

    wait 1;
  }
}

function debug_enemy() {
  self endon("<dev string:xbc>");
  setdvarifuninitialized(@ "hash_9e5e998ddfcc8447", "<dev string:x144>");
  setdvarifuninitialized(@ "hash_a1d5d00556c4bddd", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_f9e17cb98b253864", 0);

  while(true) {
    if(istrue(self.in_melee_death)) {
      return;
    }

    if(debug_enabled()) {
      if(debug_entindex() == -1 || debug_entindex() == self getentitynumber()) {
        function_499e30b2511f6c94();
      }

      num = function_c1b2391e0af178d();

      if(num == self getentitynumber()) {
        function_a02eac45a40e4217();
      }

      waitframe();
      continue;
    }

    wait 1;
  }
}

function debug_enabled() {
  dvar = getunarchiveddebugdvar(@ "debug_stealth", "<dev string:x1c>");
  return int(dvar);
}

function debug_entindex() {
  return getdvarint(@ "ai_debugentindex");
}

function function_c1b2391e0af178d() {
  dvar = getunarchiveddebugdvar(@ "hash_9e5e998ddfcc8447", "<dev string:x144>");
  return int(dvar);
}

function function_d9143f39f30fecf1() {
  dvar = getunarchiveddebugdvar(@ "hash_67d1d2d65d5da2ab", "<dev string:x144>");
  return int(dvar);
}

function function_ca7435750eb63fe6() {
  dvar = getunarchiveddebugdvar(@ "hash_a1d5d00556c4bddd", "<dev string:x1c>");
  return int(dvar);
}

function function_a8005409dfbcbb79() {
  dvar = getunarchiveddebugdvar(@ "hash_a3c8097b0584ad3c", "<dev string:x1c>");
  return int(dvar);
}

function function_68a6af3bcbe8d474() {
  dvar = getunarchiveddebugdvar(@ "hash_29199fda70b29985", "<dev string:x1c>");
  return int(dvar);
}

function function_4f071e84ae5ccf30() {
  dvar = getunarchiveddebugdvar(@ "hash_d036770ff7a14497", "<dev string:x1c>");
  return int(dvar);
}

function function_79c554909de26a4c() {
  dvar = getunarchiveddebugdvar(@ "hash_f30debd28e3f37e1", "<dev string:x1c>");
  return int(dvar);
}

function function_ff38e8c9a6564c50() {
  dvar = getunarchiveddebugdvar(@ "hash_350b154807f4d745", "<dev string:x1c>");
  return int(dvar);
}

function function_6a4e0953fbd5e6bc() {
  return getunarchiveddebugdvar(@ "hash_99b5f3d24be9d6ca", "<dev string:x1c>");
}

function thick_line(start, end, color) {
  num = 3;

  for(i = 0; i < num; i++) {
    start += (0, 0, num * 0.05);
    end += (0, 0, num * 0.05);
    line(start, end, color);
  }
}

function thick_cylinder(start, end, radius, color) {
  num = 3;

  for(i = 0; i < num; i++) {
    start += (0, 0, num * 0.05);
    end += (0, 0, num * 0.05);
    cylinder(start, end, radius, color);
  }
}

function stealth_debug_print(msg) {
  if(!flag("<dev string:x81>")) {
    return;
  }

  type = undefined;
  name = undefined;

  if(isDefined(self.script_noteworthy)) {
    type = "<dev string:x161>";
    name = self.script_noteworthy;
  } else if(isDefined(self.targetname)) {
    type = "<dev string:x176>";
    name = self.targetname;
  }

  actor = "<dev string:x184>" + self getentitynumber() + "<dev string:x198>" + self.unique_id + "<dev string:x1a1>" + self.export;

  if(isDefined(type)) {
    actor += "<dev string:x1ae>" + type + "<dev string:x1b3>" + name;
  }

  txt = "<dev string:x1b9>" + actor + "<dev string:x1cb>" + msg;
  println(txt);

  if(getdvarint(@ "hash_60656e331eb4e226") == 1) {
    thread debug_message_ai(msg);
  }
}

function function_dd7ad6e8da294b01(type, msg) {
  if(!isDefined(level.stealth.debug.screen[type])) {
    level.stealth.debug.screen[type] = 0;
  }

  x = 10;

  if(type == "<dev string:x4c>") {
    y = 50;
  } else if(type == "<dev string:xe5>") {
    y = 150;
  } else if(type == "<dev string:x1d5>") {
    y = 250;
  } else {
    y = 350;
  }

  y += level.stealth.debug.screen[type] * 15;
  printtoscreen2d(x, y, msg, (1, 1, 1), 1.25);
  level.stealth.debug.screen[type]++;
}

function function_20367cc98c4d2265(type) {
  level.stealth.debug.screen[type] = 0;
}

function debug_points(points, endonevent) {
  if(!debug_enabled()) {
    return;
  }

  self endon("<dev string:xbc>");
  self endon(endonevent);

  while(true) {
    foreach(point in points) {
      if(isDefined(point.used_time)) {
        print3d(point.origin, "<dev string:x21>" + point.used_time);
        line(point.origin, self.origin);
      }
    }

    waitframe();
  }
}

function debug_alert(type) {
  if(!debug_enabled()) {
    return;
  }

  self endon("<dev string:xbc>");
  self notify("<dev string:x1dd>");
  self endon("<dev string:x1dd>");
  color = (0.2, 1, 0.2);
  msg = "<dev string:x1f1>";

  if(type == "<dev string:x1fb>") {
    color = (1, 1, 0);
    msg = "<dev string:x207>";
  } else if(type == "<dev string:x20c>") {
    color = (1, 0.5, 0.25);
    msg = "<dev string:x207>";
  } else if(type == "<dev string:x218>") {
    color = (1, 0, 0);
    msg = "<dev string:x222>";
  } else if(type == "<dev string:x227>") {
    color = (1, 0, 0);
    msg = "<dev string:x236>";
  }

  timer = gettime() + 5000;

  while(gettime() < timer) {
    waitframe();
    print3d(self.origin + (0, 0, 72), msg, color, 1, 3);
  }
}

function function_48c141571ea55421(msg, offset, scale, color) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  function_55f9cd7d60a115bb(msg, color, 1, scale, offset);
}

function function_55f9cd7d60a115bb(text, color, alpha, scale, offset, life) {
  if(!debug_enabled() && !function_ff38e8c9a6564c50()) {
    return;
  }

  if(!isDefined(text) || !isDefined(self.stealth)) {
    return;
  }

  if(!isDefined(offset)) {
    offset = (0, 0, 92);
  }

  if(!isDefined(scale)) {
    scale = 0.5;
  }

  if(!isDefined(life)) {
    life = 3;
  }

  spacing = 10 * scale;
  riserate = 0;
  start = gettime();

  if(!isDefined(self.stealth.debug_rising)) {
    self.stealth.debug_rising = [];
    self.stealth.debug_rising_idx = -1;
  }

  self.stealth.debug_rising_idx++;
  myid = self.stealth.debug_rising_idx;
  self.stealth.debug_rising[myid] = offset;
  previd = myid - 1;

  while(isDefined(self.stealth.debug_rising[previd])) {
    delta = self.stealth.debug_rising[previd][2] - self.stealth.debug_rising[previd + 1][2];

    if(delta >= spacing) {
      break;
    }

    self.stealth.debug_rising[previd] = (self.stealth.debug_rising[previd][0], self.stealth.debug_rising[previd][1], self.stealth.debug_rising[previd + 1][2] + spacing + delta);
    previd -= 1;
  }

  draworigin = self.stealth.debug_rising[myid];

  while(gettime() - start < life * 1000) {
    waitframe();

    if(isDefined(self) && isalive(self) && isDefined(self.stealth) && isDefined(self.stealth.debug_rising) && isDefined(self.stealth.debug_rising[myid])) {
      draworigin = self.origin + self.stealth.debug_rising[myid];
    }

    print3d(draworigin, text, color, alpha, scale, 1);
    draworigin = (draworigin[0], draworigin[1], draworigin[2] + riserate);

    if(isDefined(self) && isalive(self) && isDefined(self.stealth) && isDefined(self.stealth.debug_rising) && isDefined(self.stealth.debug_rising[myid])) {
      self.stealth.debug_rising[myid] = (self.stealth.debug_rising[myid][0], self.stealth.debug_rising[myid][1], self.stealth.debug_rising[myid][2] + riserate);
    }
  }

  if(isDefined(self) && isalive(self) && isDefined(self.stealth) && isDefined(self.stealth.debug_rising) && isDefined(self.stealth.debug_rising[myid])) {
    self.stealth.debug_rising[myid] = undefined;
  }
}

function draw_enemies(team, offset) {
  enemies = getaiarray(team);

  if(team == "<dev string:x157>") {
    enemies[enemies.size] = level.player;
  }

  yellow = (1, 1, 0);
  green = (0, 1, 0);
  red = (1, 0, 0);

  foreach(enemy in enemies) {
    yellow_dist = squared(enemy.maxvisibledist + 200);
    vis_dist = squared(enemy.maxvisibledist);
    distsqrd = distancesquared(enemy.origin, self.origin);

    if(distsqrd < vis_dist) {
      color = red;
    } else if(distsqrd < yellow_dist) {
      color = yellow;
    } else {
      color = green;
    }

    line(self.origin, enemy.origin, color);
  }
}

function function_159af129de631d3e(agent) {
  dvar = getunarchiveddebugdvar(@ "hash_f9e17cb98b253864", "<dev string:x1c>");

  if(isDefined(agent)) {
    switch (dvar) {
      case #"hash_31100fbc01bd387c":
        return 1;
      case #"hash_311012bc01bd3d35":
        if(agent.type != "<dev string:x246>") {
          return 1;
        }

        return 0;
      case #"hash_311011bc01bd3ba2":
        if(agent.type == "<dev string:x246>") {
          return 1;
        }

        return 0;
      default:
        return 0;
    }
  }

  return 0;
}

function function_6ed101071f87cd39() {
  count = 0;
  var_39670b09f106e922 = function_159af129de631d3e(self);

  if(var_39670b09f106e922) {
    space = 20;
    white = (1, 1, 1);
    red = (1, 0, 0);
    yellow = (1, 1, 0);
    green = (0, 1, 0);
    size = 1;
    agenttype = "<dev string:x21>";
    viewpos = level.players[0] getvieworigin();
    scale = utility::function_5a18f19c457e5d1a(self.origin, viewpos, 1200);

    if(scale < 2) {
      size *= scale;
      space *= scale;
    }

    if(isDefined(self.agent_type)) {
      agenttype += "<dev string:x255>" + self.agent_type;
    }

    if(agenttype.size > 0) {
      print3d(self.origin - (0, 0, count * space), agenttype, white, 1, size);
      count++;
    }

    str_spawnfilter = "<dev string:x21>";

    if(isDefined(self.ob) && isDefined(self.ob.spawnfilter)) {
      str_spawnfilter += "<dev string:x25f>" + self.ob.spawnfilter;
    }

    if(str_spawnfilter.size > 0) {
      print3d(self.origin - (0, 0, count * space), str_spawnfilter, white, 1, size);
      count++;
    }

    agentstats = "<dev string:x21>";
    healthcolor = green;

    if(isDefined(self.health)) {
      agentstats += "<dev string:x270>" + self.health + "<dev string:x27d>" + self.maxhealth + "<dev string:x282>";
      healthpct = self.health / self.maxhealth;

      if(healthpct < 0.33) {
        healthcolor = red;
      } else if(healthpct < 0.66) {
        healthcolor = yellow;
      }

      if(isDefined(self.armorhealth)) {
        agentstats += "<dev string:x287>" + self.armorhealth + "<dev string:x294>";
      }
    }

    if(agentstats.size > 0) {
      print3d(self.origin - (0, 0, count * space), agentstats, healthcolor, 1, size);
      count++;
    }

    loadout = "<dev string:x21>";

    if(isDefined(self.primaryweapon)) {
      loadout += "<dev string:x29b>" + getweaponbasename(self.primaryweapon);

      if(isDefined(self.secondaryweapon)) {
        loadout += "<dev string:x2a2>" + function_7b2b4dc5f3dfb2c9(self.secondaryweapon);
      }
    }

    if(loadout.size > 0) {
      print3d(self.origin - (0, 0, count * space), loadout, white, 1, size);
      count++;
    }

    str_accuracy = "<dev string:x21>";

    if(isDefined(self.accuracy)) {
      str_accuracy += "<dev string:x2aa>" + self.accuracy + "<dev string:x2b8>" + self.baseaccuracy;
    }

    if(str_accuracy.size > 0) {
      print3d(self.origin - (0, 0, count * space), str_accuracy, white, 1, size);
      count++;
    }

    var_47a2f514cd9c0063 = "<dev string:x21>";
    var_ce72f9835ebc188e = "<dev string:x21>";

    if(isDefined(self.var_4268b42fc89d0be9)) {
      var_47a2f514cd9c0063 += "<dev string:x2c5>" + self.var_4268b42fc89d0be9 + "<dev string:x2d4>" + round(self.gameskillmisstimedistancefactoroverride * 1000, 0.01);
      playerdistance = distance(self.origin, viewpos);
      var_ce72f9835ebc188e += "<dev string:x2e6>" + round(playerdistance) + "<dev string:x2f2>" + round(playerdistance * self.gameskillmisstimedistancefactoroverride + self.var_4268b42fc89d0be9, 0.01);
    }

    if(var_47a2f514cd9c0063.size > 0) {
      print3d(self.origin - (0, 0, count * space), var_47a2f514cd9c0063, white, 1, size);
      count++;
      print3d(self.origin - (0, 0, count * space), var_ce72f9835ebc188e, white, 1, size);
      count++;
    }

    if(utility::iscp()) {
      goalvolume = self getgoalvolume();
      str_info = "<dev string:x21>";

      if(isDefined(goalvolume) && isDefined(goalvolume.targetname)) {
        str_info += "<dev string:x302>" + goalvolume.targetname + "<dev string:x1ae>";
      }

      ai_group = self.script_aigroup;

      if(isDefined(ai_group)) {
        str_info += "<dev string:x312>" + ai_group + "<dev string:x1ae>";
      }

      if(isDefined(self.goalradius)) {
        str_info += "<dev string:x320>" + self.goalradius + "<dev string:x1ae>";
      }

      if(isDefined(self.fixednode)) {
        str_info += "<dev string:x32c>" + self.fixednode + "<dev string:x1ae>";
      }

      if(istrue(self.ignoreall)) {
        str_info += "<dev string:x33b>";
      } else {
        str_info += "<dev string:x34f>";
      }

      if(istrue(self.ignoreme)) {
        str_info += "<dev string:x364>";
      } else {
        str_info += "<dev string:x377>";
      }

      if(str_info.size > 0) {
        print3d(self.origin - (0, 0, count * space), str_info, white, 1, size);
        count++;
      }
    }
  }

  return count;
}

function function_499e30b2511f6c94() {
  space = 20;
  count = 0;
  size = 2;
  white = (1, 1, 1);
  red = (1, 0, 0);
  yellow = (1, 1, 0);
  green = (0, 1, 0);

  if(function_ca7435750eb63fe6()) {
    draw_fov();
  }

  if(utility::ismp() || utility::iscp()) {
    count = function_6ed101071f87cd39();

    if(count > 0) {
      size = 1;
      viewpos = level.players[0] getvieworigin();
      scale = utility::function_5a18f19c457e5d1a(self.origin, viewpos, 1200);

      if(scale < 2) {
        size *= scale;
        space *= scale;
      }
    }
  }

  animstr = "<dev string:x38b>";
  patrolstyle = scripts\stealth\utility::get_patrol_style();

  if(isDefined(patrolstyle)) {
    animstr = patrolstyle;
  }

  szstate = "<dev string:x395>";
  szsubstate = "<dev string:x21>";
  bounded = 0;
  pod = function_bc5df124338cefea(self);

  if(isDefined(self.stealth_bsmstate)) {
    switch (self.stealth_bsmstate) {
      case 0:
        szstate = "<dev string:x3a0>";
        break;
      case 1:
        szstate = "<dev string:x3a8>";

        if(isDefined(level.stealth.investigate_volumes[self.script_stealthgroup])) {
          bounded = 1;
        }

        break;
      case 2:
        szstate = "<dev string:x3af>";

        if(isDefined(level.stealth.hunt_volumes[self.script_stealthgroup])) {
          bounded = 1;
        }

        szsubstate = "<dev string:x3b7>";
        break;
      case 3:
        szstate = "<dev string:x3c4>";

        if(isDefined(level.stealth.combat_volumes[self.script_stealthgroup])) {
          bounded = 1;
        }

        break;
    }
  }

  print3d(self.origin - (0, 0, count * space), self getentitynumber() + "<dev string:x3ce>" + szstate + szsubstate, white, 1, size);
  count++;
  print3d(self.origin - (0, 0, count * space), "<dev string:x3d9>" + animstr, white, 1, size);
  count++;
  nextline = "<dev string:x21>";

  if(isDefined(self.enemy)) {
    nextline += "<dev string:x3e3>" + self.enemy getentitynumber() + "<dev string:x1ae>";
  }

  if(bounded) {
    nextline += "<dev string:x3ee>";
  }

  if(nextline.size > 0) {
    print3d(self.origin - (0, 0, count * space), nextline, yellow, 1, size);
    count++;
  }

  if(isDefined(self.lightmeter)) {
    print3d(self.origin - (0, 0, count * space), "<dev string:x3f9>" + self.lightmeter, red, 1, size);
    count++;
  }

  group = "<dev string:x21>";

  if(isDefined(self.script_stealthgroup)) {
    group = "<dev string:x409>" + self.script_stealthgroup + "<dev string:x1ae>";
  }

  if(group.size > 0) {
    print3d(self.origin - (0, 0, count * space), group, white, 1, size);
    count++;
  }

  if(!self[[self.fnisinstealthcombat]]()) {
    for(iplayer = 0; iplayer < level.players.size; iplayer++) {
      ts = self getthreatsight(level.players[iplayer]);

      if(ts > 0) {
        txt = iplayer + "<dev string:x1b3>" + ts;

        if(self cansee(level.players[iplayer])) {
          color = red;
        } else {
          color = green;
        }

        print3d(self.origin - (0, 0, count * space), txt, color, 1, size);
        count++;
      }
    }
  }

  if(isDefined(self.shootposoverride)) {
    line(self getEye(), self.shootposoverride, (1, 1, 0));
  }

  facingstart = self.origin + (0, 0, 8);
  facingend = self.origin + (0, 0, 8) + anglesToForward(self.angles) * 36;
  line(facingstart, facingend, (0, 0, 1));
}

function function_886940100cc17179(baseangles, angle, angleidx) {
  if(angleidx == 0) {
    return anglesToForward(baseangles + (angle, 0, 0));
  }

  if(angleidx == 1) {
    return anglesToForward(baseangles + (0, angle, 0));
  }

  if(angleidx == 2) {
    return anglesToForward(baseangles + (0, 0, angle));
  }
}

function draw_arc(origin, startangle, endangle, baseangles, len, angleidx, numarcs, color) {
  assert(startangle < endangle);
  prevpt = origin + len * function_886940100cc17179(baseangles, startangle, angleidx);
  nextpt = prevpt;
  line(origin, prevpt, color);
  angledelta = (endangle - startangle) / numarcs;

  for(i = 1; i < numarcs + 1; i++) {
    angle = startangle + angledelta * i;
    nextpt = origin + len * function_886940100cc17179(baseangles, angle, angleidx);
    line(prevpt, nextpt, color);
    prevpt = nextpt;
  }

  line(origin, nextpt, color);
}

function draw_fov() {
  dot = self.fovcosine;

  if(isDefined(self.enemy)) {
    dot = self.fovcosinebusy;
  }

  color = (1, 0, 0);
  fov_yaw = acos(dot);

  if(isai(self)) {
    eye_yaw = self gettagangles("<dev string:x41b>")[1];
  } else {
    eye_yaw = self gettagangles("<dev string:x426>")[1];
  }

  viewdist = level.player.maxvisibledist;

  if(isai(self)) {
    start = self gettagorigin("<dev string:x41b>");
  } else {
    start = self gettagorigin("<dev string:x426>");
  }

  arc_segs = 10;
  draw_arc(start, -1 * fov_yaw, fov_yaw, (0, eye_yaw, 0), viewdist, 1, arc_segs, color);

  if(self.fovcosinez > dot) {
    color *= 0.5;
    fov_pitch = acos(self.fovcosinez);
    eye_pitch = 0;
    draw_arc(start, -1 * fov_pitch, fov_pitch, (eye_pitch, eye_yaw, 0), viewdist, 0, arc_segs, color);
  }
}

function function_a02eac45a40e4217() {
  tab = "<dev string:xdf>";
  function_dd7ad6e8da294b01("<dev string:x434>", "<dev string:x43d>" + self getentitynumber() + "<dev string:x282>");
  function_dd7ad6e8da294b01("<dev string:x434>", "<dev string:xfb>" + self.script_stealthgroup);
  function_dd7ad6e8da294b01("<dev string:x434>", "<dev string:x454>" + self.alertlevel);

  if(isDefined(self.enemy)) {
    enemy = self.enemy getentitynumber();
  } else {
    enemy = "<dev string:x464>";
  }

  function_dd7ad6e8da294b01("<dev string:x434>", "<dev string:x3e3>" + enemy);
  function_dd7ad6e8da294b01("<dev string:x434>", "<dev string:x471>" + self.stealth.ai_event);

  if(self.team == "<dev string:x157>") {
    team = "<dev string:x484>";
  } else {
    team = "<dev string:x157>";
  }

  enemies = getaiarray(team);

  if(team == "<dev string:x157>") {
    enemies[enemies.size] = level.player;
  }

  function_20367cc98c4d2265("<dev string:x434>");
}

function function_459a4d528437596() {
  cmaxlines = 16;
  cmaxtime = 30000;
  level.stealth.chatbox = [];
  level.stealth.var_78f9cb3724128a61 = 0;
  level.stealth.var_cfee0ec929c863b8 = 0;
  cstartx = 50;
  cstarty = 340;
  clinespacing = 20;
  cscale = 1.5;
  textcolor = (1, 1, 1);
  levelstealth = level.stealth;

  while(true) {
    if(function_a8005409dfbcbb79()) {
      var_3b40392d00a51017 = gettime() - cmaxtime;

      if(levelstealth.var_cfee0ec929c863b8 > 0) {
        cury = cstarty;
        curline = levelstealth.var_78f9cb3724128a61;

        for(iline = 0; iline < levelstealth.var_cfee0ec929c863b8; iline++) {
          if(levelstealth.chatbox[curline].time > var_3b40392d00a51017) {
            text = "<dev string:x21>";

            if(isstring(levelstealth.chatbox[curline].speaker)) {
              text += levelstealth.chatbox[curline].speaker;
            } else {
              foreach(speaker in levelstealth.chatbox[curline].speaker) {
                if(isDefined(speaker)) {
                  text += "<dev string:x1ae>" + speaker getentitynumber();
                }
              }

              levelstealth.chatbox[curline].speaker = text;
            }

            text += "<dev string:x1b3>" + levelstealth.chatbox[curline].text;
            printtoscreen2d(cstartx, cury, text, textcolor, cscale);
            cury += clinespacing;
          }

          curline = (curline + 1) % cmaxlines;
        }
      }
    }

    waitframe();
  }
}

function function_ec780a18fdfb4982(speaker, line) {
  cmaxlines = 16;
  stealth = level.stealth;
  var_91fb44e58e12150c = (stealth.var_78f9cb3724128a61 + stealth.var_cfee0ec929c863b8) % cmaxlines;
  curtime = gettime();
  var_82fe7e64cacf7088 = var_91fb44e58e12150c - 1;

  if(var_82fe7e64cacf7088 < 0) {
    var_82fe7e64cacf7088 = cmaxlines - 1;
  }

  if(isDefined(stealth.chatbox[var_82fe7e64cacf7088]) && stealth.chatbox[var_82fe7e64cacf7088].time == curtime && stealth.chatbox[var_82fe7e64cacf7088].text == line) {
    stealth.chatbox[var_82fe7e64cacf7088].speaker[stealth.chatbox[var_82fe7e64cacf7088].speaker.size] = speaker;
    return;
  }

  s = spawnStruct();
  s.speaker = [speaker];
  s.text = line;
  s.time = curtime;
  stealth.chatbox[var_91fb44e58e12150c] = s;

  if(var_91fb44e58e12150c == stealth.var_78f9cb3724128a61 && stealth.var_cfee0ec929c863b8 > 0) {
    stealth.var_78f9cb3724128a61 = (stealth.var_78f9cb3724128a61 + 1) % cmaxlines;
  } else {
    stealth.var_cfee0ec929c863b8++;
  }

  assert(stealth.var_cfee0ec929c863b8 <= cmaxlines);
}

function draw_corpses() {
  if(!debug_enabled() || !isDefined(level.stealth) || !isDefined(level.stealth.corpse)) {
    return;
  }

  if(!isDefined(level.fngetcorpsearrayfunc)) {
    return;
  }

  color = (1, 1, 0);
  found_color = (0.9, 0, 0);
  corpses = [[level.fngetcorpsearrayfunc]]();
  guys = getaiarray("<dev string:x484>");

  foreach(corpse in corpses) {
    corpseorigin = getcorpseorigin(corpse);

    if(function_3b88420e0790461f(corpse)) {
      continue;
    } else if(function_9d0df1a4b8cf341d(corpse)) {
      print3d(corpseorigin, "<dev string:x48c>");
      continue;
    } else {
      print3d(corpseorigin, "<dev string:x49c>");
    }

    line(corpse.origin, corpseorigin);
    corpsedistances = function_e3f5cef1ceede64a();

    foreach(guy in guys) {
      if(!isDefined(guy.stealth)) {
        continue;
      }

      if(guy[[guy.fnisinstealthcombat]]()) {
        continue;
      }

      dist = distancesquared(corpseorigin, guy.origin);

      if(dist < corpsedistances.detect_distsqrd) {
        line(guy.origin, corpseorigin, found_color);
        continue;
      }

      if(dist < corpsedistances.sight_distsqrd) {
        line(guy.origin, corpseorigin, color);
      }
    }
  }
}

function debug_message_ai(message, duration) {
  self notify("<dev string:x4a6>");
  self endon("<dev string:x4a6>");
  self endon("<dev string:xbc>");

  if(!isDefined(duration)) {
    duration = 5;
  }

  for(time = 0; time < duration * 20; time++) {
    print3d(self.origin + (0, 0, 45), message, (0.48, 9.4, 0.76), 0.85);
    waitframe();
  }
}

function draw_axis(origin, angles, length) {
  axes = anglestoaxis(angles);
  forward = axes["<dev string:x4ba>"] * length;
  right = axes["<dev string:x4c5>"] * length;
  up = axes["<dev string:x4ce>"] * length;
  line(origin - forward, origin + forward, (1, 0, 0), 1);
  line(origin - up, origin + up, (0, 1, 0), 1);
  line(origin - right, origin + right, (0, 0, 1), 1);
}

function function_df6b11367f42a8e1() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }

  debughunt = function_68a6af3bcbe8d474();

  if(debughunt == 0) {
    return;
  }

  colorgray = (0.7, 0.7, 0.7);

  foreach(obj in anim.smartobjectpoints) {
    angles = (0, 0, 0);

    if(isDefined(obj.angles)) {
      angles = obj.angles;
    }

    draw_axis(obj.origin, angles, 12);

    if(debughunt == 2) {
      print3d(obj.origin - (0, 0, 12), obj.script_smartobject, colorgray, 1, 0.3, 1);
      objtype = scripts\smartobjects\utility::getsmartobjecttype(obj.script_smartobject);

      if(isDefined(objtype) && isDefined(objtype.fngetinfo)) {
        info = [[objtype.fngetinfo]]();

        if(isDefined(info.radiussqrd)) {
          r = sqrt(info.radiussqrd);
          draw_arc(obj.origin, 0, 360, angles, r, 1, 8, colorgray);
        }

        if(isDefined(obj.claimer)) {
          print3d(obj.origin - (0, 0, 18), "<dev string:x4d4>" + obj.claimer getentitynumber(), colorgray, 1, 0.3, 1);
        }
      }
    }
  }
}

function function_47439b5d33f2695a() {
  var_60d789eee36da978 = function_4f071e84ae5ccf30();

  if(var_60d789eee36da978 == 0) {
    return;
  }

  if(!isDefined(level.stealth.hunt_stealth_group_region_sets)) {
    return;
  }

  debuggroup = function_6a4e0953fbd5e6bc();

  foreach(group, group_data in level.stealth.hunt_stealth_group_region_sets) {
    if(debuggroup != group && debuggroup != "<dev string:x21>") {
      continue;
    }

    foreach(region in group_data.hunt_regions) {
      for(i = 1; i < region.route_points.size; i++) {
        p0 = region.route_points[i - 1];
        p1 = region.route_points[i];
        line(p0.origin, p1.origin, (0, 0.7, 0), 1, 0, 1);
      }

      if(isDefined(region.smart_objects)) {
        foreach(smart_object in region.smart_objects) {
          draw_arc(smart_object.origin, 0, 360, smart_object.angles, 10, 1, 3, (0.7, 0, 0));
        }
      }

      if(isDefined(region.region_links)) {
        foreach(link in region.region_links) {
          line(link.transition_point.origin, link.transition_to_point.origin, (0.7, 0.7, 0), 1, 0, 1);
        }
      }
    }
  }
}

function function_477aac1963f8269e() {
  var_4dea17d260740969 = function_79c554909de26a4c();

  if(var_4dea17d260740969 == 0) {
    return;
  }

  if(!isDefined(level.stealth.hunt_stealth_group_region_sets)) {
    return;
  }

  debuggroup = function_6a4e0953fbd5e6bc();

  foreach(group, group_data in level.stealth.hunt_stealth_group_region_sets) {
    if(debuggroup != group && debuggroup != "<dev string:x21>") {
      continue;
    }

    regionlocationlist = [];

    foreach(region in group_data.hunt_regions) {
      assert(isDefined(region.approx_location));
      space = 10;
      count = 0;
      size = 0.5;
      white = (1, 1, 1);
      print3d(region.approx_location - (0, 0, count * space), "<dev string:x4dc>" + region.index, white, 1, size);
      count++;
      print3d(region.approx_location - (0, 0, count * space), "<dev string:x4e7>" + region.bfs_score, white, 1, size);
      count++;
      print3d(region.approx_location - (0, 0, count * space), "<dev string:x4f6>" + region.shared_data.bfs_assigned, white, 1, size);
      count++;
      print3d(region.approx_location - (0, 0, count * space), "<dev string:x504>" + region.shared_data.in_region, white, 1, size);
      count++;
      print3d(region.approx_location - (0, 0, count * space), "<dev string:x513>" + region.stealth_group, white, 1, size);
      cooldowndiff = region.shared_data.bfs_cooldown - gettime();

      if(cooldowndiff > 0) {
        count++;
        print3d(region.approx_location - (0, 0, count * space), "<dev string:x51e>" + cooldowndiff, white, 1, size);
      }
    }

    foreach(region in group_data.hunt_regions) {
      foreach(link in region.region_links) {
        toregion = link.region;
        line(region.approx_location, toregion.approx_location, (0, 0, 0.7), 1, 0, 1);
      }
    }
  }
}

# /