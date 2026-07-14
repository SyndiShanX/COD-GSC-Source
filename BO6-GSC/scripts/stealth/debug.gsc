/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\debug.gsc
**************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#using scripts\stealth\utility;
#namespace debug;

function debug_manager() {
  if(getdvarint(@ "nodebug", 0) >= 1) {
    return;
  }

  setdvarifuninitialized(@ "debug_stealth", "<dev string:x24>");
  setdvarifuninitialized(@ "debug_stealth_chat", "<dev string:x24>");
  setdvarifuninitialized(@ "debug_stealth_smartobjects", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_e24fb561372dfef1", -1);
  setdvarifuninitialized(@ "debug_stealth_regions", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_f30debd28e3f37e1", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_99b5f3d24be9d6ca", "<dev string:x29>");
  setdvarifuninitialized(@ "debug_stealth_doors", "<dev string:x24>");
  thread function_7017f61606a94413();
  utility::registersharedfunc(#"stealth_debug", #"hash_443faf8f48737297", &function_3e870c8e5a0ad5e2);

  while(true) {
    waitframe();

    if(!debug_enabled()) {
      continue;
    }

    draw_corpses();
    function_9b63e77b8977b710("<dev string:x2d>", "<dev string:x38>");
    function_9b63e77b8977b710("<dev string:x2d>", "<dev string:x4d>" + utility::flag("<dev string:x62>"));
    function_9b63e77b8977b710("<dev string:x2d>", "<dev string:x75>" + utility::flag("<dev string:x8a>"));
    function_931a5977a63802c("<dev string:x2d>");
    function_5bafec0d2258d020();
    function_9c422be805fc783f();
    function_c3a7cf722f85807f();
  }
}

function debug_player() {
  if(getdvarint(@ "nodebug", 0) >= 1) {
    return;
  }

  self endon("<dev string:x9d>");
  z = 0;
  space = 10;
  tab = "<dev string:xa6>";

  while(true) {
    if(debug_enabled()) {
      if(isDefined(level.player.stealth) && level.player utility::flag("<dev string:x62>")) {
        function_9b63e77b8977b710("<dev string:xac>", "<dev string:xb6>");
      }

      function_9b63e77b8977b710("<dev string:xac>", "<dev string:xd0>");
      function_9b63e77b8977b710("<dev string:xac>", "<dev string:xdc>" + self.script_stealthgroup);
      function_9b63e77b8977b710("<dev string:xac>", "<dev string:xef>" + level.player.maxvisibledist);

      if(level.player utility::ent_flag("<dev string:x103>")) {
        function_9b63e77b8977b710("<dev string:xac>", "<dev string:x118>");
      }
    }

    function_931a5977a63802c("<dev string:xac>");
    waitframe();
  }
}

function debug_friendly() {
  self endon("<dev string:x9d>");
  setdvarifuninitialized(@ "debug_stealthally", "<dev string:x125>");

  while(true) {
    if(debug_enabled()) {
      space = 10;
      count = 0;

      if(utility::ent_flag("<dev string:x103>")) {
        print3d(self.origin + (0, 0, count * space * -1), "<dev string:x12b>", (0.2, 1, 0.2), 1, 0.5);
      }

      count++;
      draw_enemies("<dev string:x138>");
      waitframe();
      continue;
    }

    wait 1;
  }
}

function debug_enemy() {
  self endon("<dev string:x9d>");
  setdvarifuninitialized(@ "debug_stealthenemy", "<dev string:x125>");
  setdvarifuninitialized(@ "debug_stealth_fov", "<dev string:x24>");
  setdevdvarifuninitialized(@ "hash_f9e17cb98b253864", 0);

  while(true) {
    if(istrue(self.in_melee_death)) {
      return;
    }

    if(debug_enabled()) {
      if(debug_entindex() == -1 || debug_entindex() == self getentitynumber()) {
        function_e18b4eb22ab843a5();
      }

      num = function_590d8989a5e79c30();

      if(num == self getentitynumber()) {
        function_9c2cfdebad55c282();
      }

      waitframe();
      continue;
    }

    wait 1;
  }
}

function debug_enabled() {
  dvar = getunarchiveddebugdvar(@ "debug_stealth", "<dev string:x24>");
  return int(dvar);
}

function debug_entindex() {
  return getdvarint(@ "ai_debugentindex");
}

function function_590d8989a5e79c30() {
  dvar = getunarchiveddebugdvar(@ "debug_stealthenemy", "<dev string:x125>");
  return int(dvar);
}

function function_83fd9c4bf5237fc4() {
  dvar = getunarchiveddebugdvar(@ "debug_stealthally", "<dev string:x125>");
  return int(dvar);
}

function function_89e8f82cfb5074cf() {
  dvar = getunarchiveddebugdvar(@ "debug_stealth_fov", "<dev string:x24>");
  return int(dvar);
}

function function_c70212de8a927af4() {
  dvar = getunarchiveddebugdvar(@ "debug_stealth_chat", "<dev string:x24>");
  return int(dvar);
}

function function_f807f007db0bdee5() {
  dvar = getunarchiveddebugdvar(@ "debug_stealth_smartobjects", "<dev string:x24>");
  return int(dvar);
}

function function_6f6fd4017a14a975() {
  dvar = getunarchiveddebugdvar(@ "debug_stealth_regions", "<dev string:x24>");
  return int(dvar);
}

function function_957db696ee14497d() {
  dvar = getunarchiveddebugdvar(@ "hash_f30debd28e3f37e1", "<dev string:x24>");
  return int(dvar);
}

function function_eb38f1f2549b201() {
  dvar = getunarchiveddebugdvar(@ "hash_350b154807f4d745", "<dev string:x24>");
  return int(dvar);
}

function function_f3ce8abd9002d3bd() {
  return getunarchiveddebugdvar(@ "hash_99b5f3d24be9d6ca", "<dev string:x24>");
}

function function_75ea304c489bd09a() {
  dvar = getunarchiveddebugdvar(@ "hash_2c56d0045f1cd82e", "<dev string:x24>");
  return int(dvar);
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

function function_e54d39468efc431d(msg) {
  if(!utility::flag("<dev string:x62>")) {
    return;
  }

  type = undefined;
  name = undefined;

  if(isDefined(self.script_noteworthy)) {
    type = "<dev string:x142>";
    name = self.script_noteworthy;
  } else if(isDefined(self.targetname)) {
    type = "<dev string:x157>";
    name = self.targetname;
  }

  actor = "<dev string:x165>" + self getentitynumber() + "<dev string:x179>" + self.unique_id + "<dev string:x182>" + self.export;

  if(isDefined(type)) {
    actor += "<dev string:x18f>" + type + "<dev string:x194>" + name;
  }

  txt = "<dev string:x19a>" + actor + "<dev string:x1ac>" + msg;
  println(txt);

  if(getdvarint(@ "hash_60656e331eb4e226") == 1) {
    thread function_651728dd01ebed6(msg);
  }
}

function function_9b63e77b8977b710(type, msg) {
  if(!isDefined(level.stealth.debug.screen[type])) {
    level.stealth.debug.screen[type] = 0;
  }

  x = 10;

  if(type == "<dev string:x2d>") {
    y = 50;
  } else if(type == "<dev string:xac>") {
    y = 150;
  } else if(type == "<dev string:x1b6>") {
    y = 250;
  } else {
    y = 350;
  }

  y += level.stealth.debug.screen[type] * 10;
  printtoscreen2d(x, y, msg, (1, 1, 1), 0.75);
  level.stealth.debug.screen[type]++;
}

function function_931a5977a63802c(type) {
  level.stealth.debug.screen[type] = 0;
}

function debug_points(points, endonevent) {
  if(!debug_enabled()) {
    return;
  }

  self endon("<dev string:x9d>");
  self endon(endonevent);

  while(true) {
    foreach(point in points) {
      if(isDefined(point.used_time)) {
        print3d(point.origin, "<dev string:x29>" + point.used_time);
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

  self endon("<dev string:x9d>");
  self notify("<dev string:x1be>");
  self endon("<dev string:x1be>");
  color = (0.2, 1, 0.2);
  msg = "<dev string:x1d2>";

  if(type == "<dev string:x1dc>") {
    color = (1, 1, 0);
    msg = "<dev string:x1e8>";
  } else if(type == "<dev string:x1ed>") {
    color = (1, 0.5, 0.25);
    msg = "<dev string:x1e8>";
  } else if(type == "<dev string:x1f9>") {
    color = (1, 0, 0);
    msg = "<dev string:x203>";
  } else if(type == "<dev string:x208>") {
    color = (1, 0, 0);
    msg = "<dev string:x217>";
  }

  timer = gettime() + 5000;

  while(gettime() < timer) {
    waitframe();
    print3d(self.origin + (0, 0, 72), msg, color, 1, 3);
  }
}

function function_20171bc84e77dfa0(msg, offset, scale, color) {
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  function_3e870c8e5a0ad5e2(msg, color, 1, scale, offset);
}

function function_3e870c8e5a0ad5e2(text, color, alpha, scale, offset, life) {
  if(!debug_enabled() && !function_eb38f1f2549b201()) {
    return;
  }

  if(!(isDefined(text) && isDefined(self.stealth))) {
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
    self.stealth.var_c7d637979b159b6a = -1;
  }

  self.stealth.var_c7d637979b159b6a++;
  myid = self.stealth.var_c7d637979b159b6a;
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

    if(isDefined(self) && isalive(self) && isDefined(self.stealth.debug_rising) && isDefined(self.stealth) && isDefined(self.stealth.debug_rising[myid])) {
      draworigin = self.origin + self.stealth.debug_rising[myid];
    }

    print3d(draworigin, text, color, alpha, scale, 1);
    draworigin = (draworigin[0], draworigin[1], draworigin[2] + riserate);

    if(isDefined(self) && isalive(self) && isDefined(self.stealth.debug_rising) && isDefined(self.stealth) && isDefined(self.stealth.debug_rising[myid])) {
      self.stealth.debug_rising[myid] = (self.stealth.debug_rising[myid][0], self.stealth.debug_rising[myid][1], self.stealth.debug_rising[myid][2] + riserate);
    }
  }

  if(isDefined(self) && isalive(self) && isDefined(self.stealth.debug_rising) && isDefined(self.stealth) && isDefined(self.stealth.debug_rising[myid])) {
    self.stealth.debug_rising[myid] = undefined;
  }
}

function draw_enemies(team, offset) {
  enemies = getaiarray(team);

  if(team == "<dev string:x138>") {
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

    if(function_75ea304c489bd09a() > 0) {
      sphere(self.origin, enemy.maxvisibledist, (0.88, 0.44, 0.88), 1, 1);
    }
  }
}

function function_39ee125a6bdb7df3(agent) {
  dvar = getunarchiveddebugdvar(@ "hash_f9e17cb98b253864", "<dev string:x24>");

  if(isDefined(agent)) {
    switch (dvar) {
      case #"hash_31100fbc01bd387c":
        return 1;
      case #"hash_311012bc01bd3d35":
        if(agent.type != "<dev string:x227>") {
          return 1;
        }

        return 0;
      case #"hash_311011bc01bd3ba2":
        if(agent.type == "<dev string:x227>") {
          return 1;
        }

        return 0;
      default:
        return 0;
    }
  }

  return 0;
}

function function_b6c776fba0bab898() {
  count = 0;
  var_a933e8ea500a2e9b = function_39ee125a6bdb7df3(self);

  if(var_a933e8ea500a2e9b) {
    space = 20;
    white = (1, 1, 1);
    red = (1, 0, 0);
    yellow = (1, 1, 0);
    green = (0, 1, 0);
    size = 1;
    agenttype = "<dev string:x29>";
    viewpos = level.players[0] getvieworigin();
    scale = utility::function_406be370d5457cc3(self.origin, viewpos, 1200);

    if(scale < 2) {
      size *= scale;
      space *= scale;
    }

    if(isDefined(self.agent_type)) {
      agenttype += "<dev string:x236>" + self.agent_type;
    }

    if(agenttype.size > 0) {
      print3d(self.origin - (0, 0, count * space), agenttype, white, 1, size);
      count++;
    }

    str_spawnfilter = "<dev string:x29>";

    if(isDefined(self.ob) && isDefined(self.ob.spawnfilter)) {
      str_spawnfilter += "<dev string:x240>" + self.ob.spawnfilter;
    }

    if(str_spawnfilter.size > 0) {
      print3d(self.origin - (0, 0, count * space), str_spawnfilter, white, 1, size);
      count++;
    }

    agentstats = "<dev string:x29>";
    healthcolor = green;

    if(isDefined(self.health)) {
      agentstats += "<dev string:x251>" + self.health + "<dev string:x25e>" + self.maxhealth + "<dev string:x263>";
      healthpct = self.health / self.maxhealth;

      if(healthpct < 0.33) {
        healthcolor = red;
      } else if(healthpct < 0.66) {
        healthcolor = yellow;
      }

      if(isDefined(self.armorhealth)) {
        agentstats += "<dev string:x268>" + self.armorhealth + "<dev string:x275>";
      }
    }

    if(agentstats.size > 0) {
      print3d(self.origin - (0, 0, count * space), agentstats, healthcolor, 1, size);
      count++;
    }

    loadout = "<dev string:x29>";

    if(isDefined(self.primaryweapon)) {
      loadout += "<dev string:x27c>" + getweaponbasename(self.primaryweapon);

      if(isDefined(self.secondaryweapon)) {
        loadout += "<dev string:x283>" + function_1b3dd67e3f1d03dc(self.secondaryweapon);
      }
    }

    if(loadout.size > 0) {
      print3d(self.origin - (0, 0, count * space), loadout, white, 1, size);
      count++;
    }

    str_accuracy = "<dev string:x29>";

    if(isDefined(self.accuracy)) {
      str_accuracy += "<dev string:x28b>" + self.accuracy + "<dev string:x299>" + self.baseaccuracy;
    }

    if(str_accuracy.size > 0) {
      print3d(self.origin - (0, 0, count * space), str_accuracy, white, 1, size);
      count++;
    }

    var_9b47c32ff58635fe = "<dev string:x29>";
    var_d53e4785f31339ab = "<dev string:x29>";

    if(isDefined(self.var_3710bb64f75c0730)) {
      var_9b47c32ff58635fe += "<dev string:x2a6>" + self.var_3710bb64f75c0730 + "<dev string:x2b5>" + round(self.gameskillmisstimedistancefactoroverride * 1000, 0.01);
      playerdistance = distance(self.origin, viewpos);
      var_d53e4785f31339ab += "<dev string:x2c7>" + round(playerdistance) + "<dev string:x2d3>" + round(playerdistance * self.gameskillmisstimedistancefactoroverride + self.var_3710bb64f75c0730, 0.01);
    }

    if(var_9b47c32ff58635fe.size > 0) {
      print3d(self.origin - (0, 0, count * space), var_9b47c32ff58635fe, white, 1, size);
      count++;
      print3d(self.origin - (0, 0, count * space), var_d53e4785f31339ab, white, 1, size);
      count++;
    }
  }

  return count;
}

function function_e18b4eb22ab843a5() {
  space = 20;
  count = 0;
  size = 2;
  white = (1, 1, 1);
  red = (1, 0, 0);
  yellow = (1, 1, 0);
  green = (0, 1, 0);

  if(function_89e8f82cfb5074cf()) {
    draw_fov();
  }

  if(utility::ismp()) {
    count = function_b6c776fba0bab898();

    if(count > 0) {
      size = 1;
      viewpos = level.players[0] getvieworigin();
      scale = utility::function_406be370d5457cc3(self.origin, viewpos, 1200);

      if(scale < 2) {
        size *= scale;
        space *= scale;
      }
    }
  }

  animstr = "<dev string:x2e3>";
  patrolstyle = utility::get_patrol_style();

  if(isDefined(patrolstyle)) {
    animstr = patrolstyle;
  }

  szstate = "<dev string:x2ed>";
  szsubstate = "<dev string:x29>";
  bounded = 0;

  if(isDefined(self.stealth_bsmstate)) {
    switch (self.stealth_bsmstate) {
      case 0:
        szstate = "<dev string:x2f8>";
        break;
      case 1:
        szstate = "<dev string:x300>";

        if(isDefined(level.stealth.investigate_volumes[self.script_stealthgroup])) {
          bounded = 1;
        }

        break;
      case 2:
        szstate = "<dev string:x307>";

        if(isDefined(level.stealth.hunt_volumes[self.script_stealthgroup])) {
          bounded = 1;
        }

        szsubstate = "<dev string:x30f>";
        break;
      case 3:
        szstate = "<dev string:x31c>";

        if(isDefined(level.stealth.combat_volumes[self.script_stealthgroup])) {
          bounded = 1;
        }

        break;
    }
  }

  print3d(self.origin - (0, 0, count * space), self getentitynumber() + "<dev string:x326>" + szstate + szsubstate, white, 1, size);
  count++;
  print3d(self.origin - (0, 0, count * space), "<dev string:x331>" + animstr, white, 1, size);
  count++;
  nextline = "<dev string:x29>";

  if(isDefined(self.enemy)) {
    nextline += "<dev string:x33b>" + self.enemy getentitynumber() + "<dev string:x18f>";
  }

  if(bounded) {
    nextline += "<dev string:x346>";
  }

  if(nextline.size > 0) {
    print3d(self.origin - (0, 0, count * space), nextline, yellow, 1, size);
    count++;
  }

  if(isDefined(self.lightmeter)) {
    print3d(self.origin - (0, 0, count * space), "<dev string:x351>" + self.lightmeter, red, 1, size);
    count++;
  }

  group = "<dev string:x29>";

  if(isDefined(self.script_stealthgroup)) {
    group = "<dev string:x361>" + self.script_stealthgroup + "<dev string:x18f>";
  }

  if(group.size > 0) {
    print3d(self.origin - (0, 0, count * space), group, white, 1, size);
    count++;
  }

  if(!self[[self.fnisinstealthcombat]]()) {
    for(iplayer = 0; iplayer < level.players.size; iplayer++) {
      ts = self getthreatsight(level.players[iplayer]);

      if(ts > 0) {
        txt = iplayer + "<dev string:x194>" + ts;

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

  if(function_75ea304c489bd09a() > 0) {
    draw_enemies("<dev string:x138>");
  }
}

function function_5e46fa654bb04b74(baseangles, angle, angleidx) {
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
  prevpt = origin + len * function_5e46fa654bb04b74(baseangles, startangle, angleidx);
  nextpt = prevpt;
  line(origin, prevpt, color);
  angledelta = (endangle - startangle) / numarcs;

  for(i = 1; i < numarcs + 1; i++) {
    angle = startangle + angledelta * i;
    nextpt = origin + len * function_5e46fa654bb04b74(baseangles, angle, angleidx);
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
    eye_yaw = self gettagangles("<dev string:x373>")[1];
  } else {
    eye_yaw = self gettagangles("<dev string:x37e>")[1];
  }

  viewdist = level.player.maxvisibledist;

  if(isai(self)) {
    start = self gettagorigin("<dev string:x373>");
  } else {
    start = self gettagorigin("<dev string:x37e>");
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

function function_9c2cfdebad55c282() {
  tab = "<dev string:xa6>";
  function_9b63e77b8977b710("<dev string:x38c>", "<dev string:x395>" + self getentitynumber() + "<dev string:x263>");
  function_9b63e77b8977b710("<dev string:x38c>", "<dev string:xdc>" + self.script_stealthgroup);
  function_9b63e77b8977b710("<dev string:x38c>", "<dev string:x3ac>" + self.alertlevel);

  if(isDefined(self.enemy)) {
    enemy = self.enemy getentitynumber();
  } else {
    enemy = "<dev string:x3bc>";
  }

  function_9b63e77b8977b710("<dev string:x38c>", "<dev string:x33b>" + enemy);
  function_9b63e77b8977b710("<dev string:x38c>", "<dev string:x3c9>" + self.stealth.ai_event);

  if(self.team == "<dev string:x138>") {
    team = "<dev string:x3dc>";
  } else {
    team = "<dev string:x138>";
  }

  enemies = getaiarray(team);

  if(team == "<dev string:x138>") {
    enemies[enemies.size] = level.player;
  }

  function_931a5977a63802c("<dev string:x38c>");
}

function function_7017f61606a94413() {
  cmaxlines = 16;
  cmaxtime = 30000;
  level.stealth.chatbox = [];
  level.stealth.var_a360694dd542678 = 0;
  level.stealth.var_a6330f9950a81a35 = 0;
  cstartx = 50;
  cstarty = 340;
  clinespacing = 20;
  cscale = 1.5;
  textcolor = (1, 1, 1);
  levelstealth = level.stealth;

  while(true) {
    if(function_c70212de8a927af4()) {
      var_285a1a197d0d6536 = gettime() - cmaxtime;

      if(levelstealth.var_a6330f9950a81a35 > 0) {
        cury = cstarty;
        curline = levelstealth.var_a360694dd542678;

        for(iline = 0; iline < levelstealth.var_a6330f9950a81a35; iline++) {
          if(levelstealth.chatbox[curline].time > var_285a1a197d0d6536) {
            text = "<dev string:x29>";

            if(isstring(levelstealth.chatbox[curline].speaker)) {
              text += levelstealth.chatbox[curline].speaker;
            } else {
              foreach(speaker in levelstealth.chatbox[curline].speaker) {
                if(isDefined(speaker)) {
                  text += "<dev string:x18f>" + speaker getentitynumber();
                }
              }

              levelstealth.chatbox[curline].speaker = text;
            }

            text += "<dev string:x194>" + levelstealth.chatbox[curline].text;
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

function function_f8d23469e4a91a5f(speaker, line) {
  cmaxlines = 16;
  stealth = level.stealth;
  var_78628e8945dc4f75 = (stealth.var_a360694dd542678 + stealth.var_a6330f9950a81a35) % cmaxlines;
  curtime = gettime();
  var_1472f4f56d0c1aed = var_78628e8945dc4f75 - 1;

  if(var_1472f4f56d0c1aed < 0) {
    var_1472f4f56d0c1aed = cmaxlines - 1;
  }

  if(isDefined(stealth.chatbox[var_1472f4f56d0c1aed]) && stealth.chatbox[var_1472f4f56d0c1aed].time == curtime && stealth.chatbox[var_1472f4f56d0c1aed].text == line) {
    stealth.chatbox[var_1472f4f56d0c1aed].speaker[stealth.chatbox[var_1472f4f56d0c1aed].speaker.size] = speaker;
    return;
  }

  s = spawnStruct();
  s.speaker = [speaker];
  s.text = line;
  s.time = curtime;
  stealth.chatbox[var_78628e8945dc4f75] = s;

  if(var_78628e8945dc4f75 == stealth.var_a360694dd542678 && stealth.var_a6330f9950a81a35 > 0) {
    stealth.var_a360694dd542678 = (stealth.var_a360694dd542678 + 1) % cmaxlines;
  } else {
    stealth.var_a6330f9950a81a35++;
  }

  assert(stealth.var_a6330f9950a81a35 <= cmaxlines);
}

function draw_corpses() {
  if(!debug_enabled() || !(isDefined(level.stealth) && isDefined(level.stealth.corpse))) {
    return;
  }

  if(!isDefined(level.fngetcorpsearrayfunc)) {
    return;
  }

  color = (1, 1, 0);
  found_color = (0.9, 0, 0);
  corpses = [[level.fngetcorpsearrayfunc]]();
  guys = getaiarray("<dev string:x3dc>");

  foreach(corpse in corpses) {
    corpseorigin = getcorpseorigin(corpse);

    if(function_59ac3fae0622799e(corpse)) {
      continue;
    } else if(function_ae91cd4ffec7321c(corpse)) {
      print3d(corpseorigin, "<dev string:x3e4>");
      continue;
    } else {
      print3d(corpseorigin, "<dev string:x3f4>");
    }

    line(corpse.origin, corpseorigin);
    corpsedistances = function_9fb687892a1167cf();

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

function function_651728dd01ebed6(message, duration) {
  self notify("<dev string:x3fe>");
  self endon("<dev string:x3fe>");
  self endon("<dev string:x9d>");

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
  forward = axes["<dev string:x412>"] * length;
  right = axes["<dev string:x41d>"] * length;
  up = axes["<dev string:x426>"] * length;
  line(origin - forward, origin + forward, (1, 0, 0), 1);
  line(origin - up, origin + up, (0, 1, 0), 1);
  line(origin - right, origin + right, (0, 0, 1), 1);
}

function function_5bafec0d2258d020() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }

  debughunt = function_f807f007db0bdee5();

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
      objtype = utility::getsmartobjecttype(obj.script_smartobject);

      if(isDefined(objtype) && isDefined(objtype.fngetinfo)) {
        info = [[objtype.fngetinfo]]();

        if(isDefined(info.radiussqrd)) {
          r = sqrt(info.radiussqrd);
          draw_arc(obj.origin, 0, 360, angles, r, 1, 8, colorgray);
        }

        if(isDefined(obj.claimer)) {
          print3d(obj.origin - (0, 0, 18), "<dev string:x42c>" + obj.claimer getentitynumber(), colorgray, 1, 0.3, 1);
        }
      }
    }
  }
}

function function_9c422be805fc783f() {
  var_c0c70dc3fec45609 = function_6f6fd4017a14a975();

  if(var_c0c70dc3fec45609 == 0) {
    return;
  }

  if(!isDefined(level.stealth.hunt_stealth_group_region_sets)) {
    return;
  }

  debuggroup = function_f3ce8abd9002d3bd();

  foreach(group_data in level.stealth.hunt_stealth_group_region_sets) {
    if(debuggroup != group && debuggroup != "<dev string:x29>") {
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

function function_c3a7cf722f85807f() {
  var_a3712599885a01f8 = function_957db696ee14497d();

  if(var_a3712599885a01f8 == 0) {
    return;
  }

  if(!isDefined(level.stealth.hunt_stealth_group_region_sets)) {
    return;
  }

  debuggroup = function_f3ce8abd9002d3bd();

  foreach(group_data in level.stealth.hunt_stealth_group_region_sets) {
    if(debuggroup != group && debuggroup != "<dev string:x29>") {
      continue;
    }

    regionlocationlist = [];

    foreach(region in group_data.hunt_regions) {
      assert(isDefined(region.approx_location));
      space = 10;
      count = 0;
      size = 0.5;
      white = (1, 1, 1);
      print3d(region.approx_location - (0, 0, count * space), "<dev string:x434>" + region.index, white, 1, size);
      count++;
      print3d(region.approx_location - (0, 0, count * space), "<dev string:x43f>" + region.bfs_score, white, 1, size);
      count++;
      print3d(region.approx_location - (0, 0, count * space), "<dev string:x44e>" + region.shared_data.bfs_assigned, white, 1, size);
      count++;
      print3d(region.approx_location - (0, 0, count * space), "<dev string:x45c>" + region.shared_data.in_region, white, 1, size);
      count++;
      print3d(region.approx_location - (0, 0, count * space), "<dev string:x46b>" + region.stealth_group, white, 1, size);
      cooldowndiff = region.shared_data.bfs_cooldown - gettime();

      if(cooldowndiff > 0) {
        count++;
        print3d(region.approx_location - (0, 0, count * space), "<dev string:x476>" + cooldowndiff, white, 1, size);
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