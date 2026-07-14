/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\debug.gsc
**************************************/

#using scripts\anim\init;
#using scripts\anim\utility;
#using scripts\common\ai;
#using scripts\common\debug_graycard;
#using scripts\common\debug_reflection;
#using scripts\common\dof;
#using scripts\engine\sp\utility;
#using scripts\engine\sp\utility_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\colors;
#using scripts\sp\debug_spawnai;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\utility;
#namespace debug;

function maindebug() {
  setdvarifuninitialized(@ "scr_debug", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_e88f0c15c278fb42", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_8496c6305e4b772", "<dev string:x29>");
  setdvarifuninitialized(@ "hash_bdb86700db7d369e", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_c5a7cfaf6b0c9ac0", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_8beca11d7b55550e", 0);

  if(getdvarint(@ "hash_a838875af4383ca1", 0) != 0) {
    thread function_367cab287db94201();
  }

  if(!isDefined(level.debug)) {
    level.debug = spawnStruct();
  }

  utility::create_func_ref("<dev string:x2e>", &draw_spawner);
  level.animsound_hudlimit = 14;
  thread lastsightposwatch();
  thread camera();
  setdvarifuninitialized(@ "debug_corner", "<dev string:x3e>");

  if(getDvar(@ "debug_corner") == "<dev string:x45>") {
    debug_corner();
  }

  thread debugdvars();
  thread debugcolorfriendlies();
  thread dof::function_6cff72afa3e89aeb();
  thread debugentityarray();
}

function maindebugpostload() {
  thread debug_magic();
}

function debugentityarray() {
  wait 2;

  if(getdvarint(@ "hash_687bd77ca12d535c") != 0) {
    entarray = getEntArray();
    level.debug.script_origins = [];
    level.debug.script_models = [];
    level.debug.script_brushmodels = [];
    level.debug.trigger_multiple = [];

    foreach(ent in entarray) {
      waitframe();

      if(!(isDefined(ent) && isDefined(ent.classname))) {
        continue;
      }

      if(ent.classname == "<dev string:x4b>") {
        level.debug.script_origins[level.debug.script_origins.size] = ent;
        continue;
      }

      if(ent.classname == "<dev string:x5c>") {
        level.debug.script_models[level.debug.script_models.size] = ent;
        continue;
      }

      if(ent.classname == "<dev string:x6c>") {
        level.debug.script_brushmodels[level.debug.script_brushmodels.size] = ent;
        continue;
      }
    }
  }
}

function function_6b6a82d0a6baf64a() {
  while(true) {
    if(!getdvarint(@ "hash_5bed111185579616")) {
      return;
    }

    num = 0;

    foreach(m in getEntArray("<dev string:x5c>", #classname)) {
      if(m.model == "<dev string:x81>") {
        num++;
      }
    }

    iprintln(num + "<dev string:x8f>");
    wait 1;
  }
}

function function_e0cd932f1f25631d() {
  array = [];

  foreach(ent in getEntArray("<dev string:x5c>", #classname)) {
    if(ent.model == "<dev string:x81>") {
      array[array.size] = ent;
    }
  }

  return array;
}

function function_a1fa8fe76e66c54d() {
  array = function_e0cd932f1f25631d();
  println("<dev string:xa5>");
  println("<dev string:xba>");
  filtered_array = [];

  foreach(ent in array) {
    if(isDefined(ent.debugstring)) {
      if(!isDefined(filtered_array[ent.debugstring])) {
        filtered_array[ent.debugstring] = 1;
      } else {
        filtered_array[ent.debugstring]++;
      }

      continue;
    }

    if(!isDefined(filtered_array["<dev string:xe3>"])) {
      filtered_array["<dev string:xe3>"] = 1;
      continue;
    }

    filtered_array["<dev string:xe3>"]++;
  }

  foreach(count in filtered_array) {
    println(key + "<dev string:xee>" + count);
  }

  println("<dev string:xf4>" + array.size);
  println("<dev string:xba>");
  array = undefined;
  setDvar(@ "hash_1427b6dfc4e0eaad", "<dev string:x24>");
}

function entity_count() {
  setDvar(@ "hash_bc81c5010a46eadf", "<dev string:x24>");
  array = get_entity_count_list();
  println("<dev string:xff>");
  println("<dev string:x10f>");
  total = 0;

  foreach(item in array) {
    println(i + "<dev string:xee>" + item);
    total += item;
  }

  println("<dev string:xf4>" + total);
  println("<dev string:x10f>");
  array = undefined;
  setDvar(@ "hash_bc81c5010a46eadf", "<dev string:x24>");
}

function entity_count_hud() {
  if(isDefined(level.debug.var_5091493e54f43862)) {
    return;
  }

  level.debug.var_5091493e54f43862 = [];
  level.debug.var_4fa50df18df7517b = 20;
  hudcount = level.debug.var_5091493e54f43862.size;
  totalhud = newhudelem();
  totalhud.x = 20;
  totalhud.fontscale = 0.4;
  totalhud.foreground = 1;
  totalhud.sort = 5;
  totalhud.label = "<dev string:x136>";
  totalhud.font = "<dev string:x142>";
  totalhud.horzalign = "<dev string:x14e>";
  dobjhud = newhudelem();
  dobjhud.x = 20;
  dobjhud.fontscale = 0.4;
  dobjhud.foreground = 1;
  dobjhud.sort = 5;
  dobjhud.label = "<dev string:x156>";
  dobjhud.horzalign = "<dev string:x14e>";
  dobjhud.font = "<dev string:x142>";

  while(getunarchiveddebugdvar(@ "hash_e88f0c15c278fb42") != "<dev string:x24>") {
    array = get_entity_count_list(1, 1);

    if(level.debug.var_5091493e54f43862.size > hudcount) {
      adjust_entcounthud_pos();
      hudcount = level.debug.var_5091493e54f43862.size;
    }

    remaining = getarraykeys(level.debug.var_5091493e54f43862);
    num = 0;
    total = 0;

    foreach(key, item in array) {
      foreach(k in remaining) {
        if(k == key) {
          remaining = arrayremove(remaining, k);
        }
      }

      set_entity_count_hud(num, key, item);
      total += item;
      num++;
    }

    foreach(key in remaining) {
      hud = level.debug.var_5091493e54f43862[key];
      hud adjust_entity_count_hud_color(0);
      hud setvalue(0);
      hud.prevvalue = 0;

      if(getunarchiveddebugdvar(@ "hash_e88f0c15c278fb42") == "<dev string:x162>") {
        entity_count_delta(hud, 0);
      }
    }

    totalhud.y = level.debug.var_4fa50df18df7517b + 7;
    totalhud.color = get_total_count_color(total);
    totalhud setvalue(total);
    dobjhud.y = totalhud.y + 7;
    dobjhud.color = get_total_count_color(getdobjcount());
    dobjhud setvalue(getdobjcount());
    wait 0.05;
  }

  foreach(hud in level.debug.var_5091493e54f43862) {
    if(isDefined(hud.avghud)) {
      hud.avghud destroy();
    }

    hud destroy();
  }

  level.debug.var_5091493e54f43862 = undefined;
  level.debug.var_4fa50df18df7517b = undefined;
  totalhud destroy();
}

function get_total_count_color(total) {
  if(total <= 1500) {
    color = (0, 0.8, 0);
  } else if(total <= 1700) {
    color = (0, 0.8, 0) + ((0.8, 0.8, 0) - (0, 0.8, 0)) * (total - 1500) / 200;
  } else {
    color = (0.8, 0.8, 0) + ((0.8, 0, 0) - (0.8, 0.8, 0)) * (total - 1700) / 348;
  }

  return color;
}

function adjust_entcounthud_pos() {
  level.debug.var_5091493e54f43862 = sort_by_key(level.debug.var_5091493e54f43862);
  num = 1;

  foreach(hud in level.debug.var_5091493e54f43862) {
    hud.y = 20 + num * 7;
    num++;

    if(isDefined(hud.avghud)) {
      hud.avghud.y = hud.y;
    }
  }
}

function set_entity_count_hud(num, key, val) {
  if(!isDefined(level.debug.var_5091493e54f43862[key])) {
    hud = newhudelem();
    hud.x = 20;
    hud.y = level.debug.var_4fa50df18df7517b + 7;
    level.debug.var_4fa50df18df7517b = hud.y;
    hud.fontscale = 0.4;
    hud.foreground = 1;
    hud.sort = 5;
    hud.label = key + "<dev string:x167>";
    hud.labeltext = key;
    hud.font = "<dev string:x142>";
    hud.prevvalue = 0;
    hud.horzalign = "<dev string:x14e>";
    level.debug.var_5091493e54f43862[key] = hud;
  } else {
    hud = level.debug.var_5091493e54f43862[key];
  }

  if(getunarchiveddebugdvar(@ "hash_e88f0c15c278fb42") == "<dev string:x162>") {
    entity_count_delta(hud, val);
  } else if(isDefined(hud.avghud)) {
    hud.avghud destroy();
  }

  hud adjust_entity_count_hud_color(val);
  hud setvalue(val);
  hud.prevvalue = val;
}

function entity_count_delta(parenthud, val) {
  if(!isDefined(parenthud.avghud)) {
    parenthud.avghud = newhudelem();
    parenthud.avghud.x = parenthud.x + -2;
    parenthud.avghud.y = parenthud.y;
    parenthud.avghud.fontscale = 0.4;
    parenthud.avghud.foreground = 1;
    parenthud.avghud.alignx = "<dev string:x16e>";
    parenthud.avghud.sort = 5;
    parenthud.avghud.font = "<dev string:x142>";
    parenthud.avghud.time = gettime();
    parenthud.avghud.prevvalue = val;
  }

  parenthud.avghud.time = gettime();
  parenthud.avghud setvalue(val - parenthud.avghud.prevvalue);
}

function adjust_entity_count_hud_color(val) {
  if(val > self.prevvalue) {
    self.color = (0.8, 0, 0);
    return;
  }

  if(val < self.prevvalue) {
    self.color = (0, 0.8, 0);
    return;
  }

  color_diff = (1, 1, 1) - self.color;

  if(length(color_diff) > 0.346) {
    self.color += color_diff * 0.05;
    return;
  }

  self.color = (1, 1, 1);
}

function get_entity_count_list(dogrouping, skipsort) {
  ents = getEntArray();
  array = [];

  if(!isDefined(dogrouping)) {
    dogrouping = 0;
  }

  foreach(ent in ents) {
    if(!isDefined(ent.classname)) {
      classname = "[Y4\xad\x9f\x951\xf9";
    } else {
      classname = ent.classname;
    }

    if(dogrouping) {
      if(isai(ent)) {
        classname = "\x8a1\x8f\x89\xbc\xa2";
      } else if(isspawner(ent)) {
        prefix = getsubstr(classname, 0, 5);

        if(prefix == "\x06`\xb6y[") {
          classname = "\x14I}\xb9\x83\xb0\xdd\xdcV'\xe6";
        } else {
          classname = "\xde\x9f\xfa\xf3m\xf2\xd6\xd8lY\xa3\xb0\xb2~\xd1\xc5";
        }
      } else if(isDefined(ent.createfx_ent)) {
        classname = ent.classname + "}\x15\xbfW\xd3V\xdf_}";
      } else if(!isDefined(ent.code_classname)) {} else if(ent.code_classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
        if(ent.model == "\xec\xbfK|\au\xcd\xc2\x19<") {
          classname = "\x10\x15\x14-9\xdc\x7f#\xdb\x94\xaf,\xd0\xdf\x8eL\x0f\xb1\xaa\x87\xb1\xafo";
        }
      } else if(ent.code_classname == "E\x03\xae\xad\x7f\xcc\xa9\x17\xda\xb0K\xa4s\xeb\xfb\xf7") {
        prefix = getsubstr(classname, 0, 22);

        if(prefix == "Zi!\xa1\v\xafA\xce\x01?\xa6\f\xdb\xbdm3{\x9c\x86\xd0S") {
          classname = ".\x93%OJ\xf2\xa5\x96\xd2l\x1eq0\x15^\xc5\xf5\\\x9c\x83";
        } else {
          classname = "E\x03\xae\xad\x7f\xcc\xa9\x17\xda\xb0K\xa4s\xeb\xfb\xf7";
        }
      } else {
        prefix = getsubstr(ent.code_classname, 0, 10);

        if(prefix == "\xd9\x03\xdf!V\x87\x93\x05y\xa5") {
          classname = "\xf7\xd8\x8a\xbe:Y\x87";
        }

        prefix = getsubstr(ent.code_classname, 0, 5);

        if(prefix == "\x06`\xb6y[") {
          classname = "F\xe5j\x96e\xb9";
        }
      }
    } else {
      if(isDefined(ent.createfx_ent)) {
        classname = "g\"\xceW\x8e^\xe0\xa4\xa4" + ent.classname;
      }

      if(classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
        classname += "\xda" + ent.model;
      }
    }

    if(!isDefined(array[classname])) {
      array[classname] = 0;
    }

    array[classname]++;
  }

  if(!isDefined(skipsort) || !skipsort) {
    array = sort_by_key(array);
  }

  return array;
}

function sort_by_key(array) {
  keys = getarraykeys(array);

  for(i = 0; i < keys.size - 1; i++) {
    for(j = i + 1; j < keys.size; j++) {
      if(stricmp(keys[i], keys[j]) > 0) {
        ref = keys[j];
        keys[j] = keys[i];
        keys[i] = ref;
      }
    }
  }

  new_array = [];

  for(i = 0; i < keys.size; i++) {
    new_array[keys[i]] = array[keys[i]];
  }

  return new_array;
}

function debug_enemypos(num) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentitynumber() != num) {
      continue;
    }

    ai[i] thread debug_enemyposproc();
    break;
  }
}

function debug_stopenemypos(num) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentitynumber() != num) {
      continue;
    }

    ai[i] notify("\x1b\xc6\x15\xccOAGC\a\xbf1:\xf1\x9c\xd8\xb6(\x8b\x90\x12\x10\xd7");
    break;
  }
}

function debug_enemyposproc() {
  self endon("<dev string:x177>");
  self endon("<dev string:x180>");

  for(;;) {
    wait 0.05;

    if(isalive(self.enemy)) {
      line(self.origin + (0, 0, 70), self.enemy.origin + (0, 0, 70), (0.8, 0.2, 0), 0.5);
    }

    if(!utility::hasenemysightpos()) {
      continue;
    }

    pos = utility::getenemysightpos();
    line(self.origin + (0, 0, 70), pos, (0.9, 0.5, 0.3), 0.5);
  }
}

function debug_enemyposreplay() {
  ai = getaiarray();
  guy = undefined;

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(!isalive(guy)) {
      continue;
    }

    if(isDefined(guy.lastenemysightpos)) {
      line(guy.origin + (0, 0, 65), guy.lastenemysightpos, (1, 0, 1), 0.5);
    }

    if(isDefined(guy.goodshootpos)) {
      if(guy isbadguy()) {
        color = (1, 0, 0);
      } else {
        color = (0, 0, 1);
      }

      nodeoffset = guy.origin + (0, 0, 54);

      if(isDefined(guy.node)) {
        if(guy.node.type == "<dev string:x19a>") {
          cornernode = 1;
          nodeoffset = anglestoright(guy.node.angles);
          nodeoffset *= -32;
          nodeoffset = (nodeoffset[0], nodeoffset[1], 64);
          nodeoffset = guy.node.origin + nodeoffset;
        } else if(guy.node.type == "<dev string:x1a8>") {
          cornernode = 1;
          nodeoffset = anglestoright(guy.node.angles);
          nodeoffset *= 32;
          nodeoffset = (nodeoffset[0], nodeoffset[1], 64);
          nodeoffset = guy.node.origin + nodeoffset;
        }
      }

      utility::draw_arrow(nodeoffset, guy.goodshootpos, color);
    }
  }

  if(true) {
    return;
  }

  if(!isalive(guy)) {
    return;
  }

  if(isalive(guy.enemy)) {
    line(guy.origin + (0, 0, 70), guy.enemy.origin + (0, 0, 70), (0.6, 0.2, 0.2), 0.5);
  }

  if(isDefined(guy.lastenemysightpos)) {
    line(guy.origin + (0, 0, 65), guy.lastenemysightpos, (0, 0, 1), 0.5);
  }

  if(isalive(guy.goodenemy)) {
    line(guy.origin + (0, 0, 50), guy.goodenemy.origin, (1, 0, 0), 0.5);
  }

  if(!guy utility::hasenemysightpos()) {
    return;
  }

  pos = guy utility::getenemysightpos();
  line(guy.origin + (0, 0, 55), pos, (0.2, 0.2, 0.6), 0.5);

  if(isDefined(guy.goodshootpos)) {
    line(guy.origin + (0, 0, 45), guy.goodshootpos, (0.2, 0.6, 0.2), 0.5);
  }
}

function drawenttag(num) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentnum() != num) {
      continue;
    }

    ai[i] thread dragtaguntildeath(getDvar(@ "debug_tag"));
  }

  setDvar(@ "hash_b41009d51346ca25", "<dev string:x1b7>");
}

function drawtag(tag, opcolor, drawtime) {
  if(isDefined(self.model) && utility::hastag(self.model, tag)) {
    org = self gettagorigin(tag);
    ang = self gettagangles(tag);
    drawarrow(org, ang, opcolor, drawtime);
  }
}

function drawarrow(org, ang, opcolor, drawtime) {
  scale = 10;
  forward = anglesToForward(ang);
  forwardfar = forward * scale;
  forwardclose = forward * scale * 0.8;
  right = anglestoright(ang);
  leftdraw = right * scale * -0.2;
  rightdraw = right * scale * 0.2;
  up = anglestoup(ang);
  right *= scale;
  up *= scale;
  red = (0.9, 0.2, 0.2);
  green = (0.2, 0.9, 0.2);
  blue = (0.2, 0.2, 0.9);

  if(isDefined(opcolor)) {
    red = opcolor;
    green = opcolor;
    blue = opcolor;
  }

  if(!isDefined(drawtime)) {
    drawtime = 1;
  }

  line(org, org + forwardfar, red, 0.9, 0, drawtime);
  line(org + forwardfar, org + forwardclose + rightdraw, red, 0.9, 0, drawtime);
  line(org + forwardfar, org + forwardclose + leftdraw, red, 0.9, 0, drawtime);
  line(org, org + right, blue, 0.9, 0, drawtime);
  line(org, org + up, green, 0.9, 0, drawtime);
}

function drawtagforever(tag, opcolor) {
  for(;;) {
    if(!isDefined(self)) {
      return;
    }

    drawtag(tag, opcolor);
    wait 0.05;
  }
}

function dragtaguntildeath(tag, opcolor) {
  self endon("<dev string:x177>");

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(self.origin)) {
      break;
    }

    drawtag(tag, opcolor);
    wait 0.05;
  }
}

function viewtag(type, tag) {
  if(type == "\xe0\xda") {
    ai = getaiarray();

    for(i = 0; i < ai.size; i++) {
      ai[i] drawtag(tag);
    }
  }
}

function debug_corner() {
  level.player.ignoreme = 1;
  nodes = getallnodes();
  corners = [];

  for(i = 0; i < nodes.size; i++) {
    if(nodes[i].type == "g\x1fWv\xec\xec@P(o") {
      corners[corners.size] = nodes[i];
    }

    if(nodes[i].type == "c\xb0\x14\xd5\xd9\xe4\xaf\x8d\x91}\xc2") {
      corners[corners.size] = nodes[i];
    }
  }

  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    ai[i] delete();
  }

  level.debugspawners = getspawnerarray();
  level.activenodes = [];
  level.completednodes = [];

  for(i = 0; i < level.debugspawners.size; i++) {
    level.debugspawners[i].targetname = "\x8a1\xe0\xf4";
  }

  covered = 0;

  for(i = 0; i < 30; i++) {
    if(i >= corners.size) {
      break;
    }

    corners[i] thread covertest();
    covered++;
  }

  if(corners.size <= 30) {
    return;
  }

  for(;;) {
    level waittill("\x1dU\xbb\x9b\xf7\xe9\xa2`\x90\x1b\xb1\xb7\x90C\xf6\x15\x8e");

    if(covered >= corners.size) {
      covered = 0;
    }

    corners[covered] thread covertest();
    covered++;
  }
}

function covertest() {
  coversetupanim();
}

function coversetupanim() {
  spawn = undefined;
  spawner = undefined;

  for(;;) {
    for(i = 0; i < level.debugspawners.size; i++) {
      wait 0.05;
      spawner = level.debugspawners[i];
      nearactive = 0;

      for(p = 0; p < level.activenodes.size; p++) {
        if(distance(level.activenodes[p].origin, self.origin) > 250) {
          continue;
        }

        nearactive = 1;
        break;
      }

      if(nearactive) {
        continue;
      }

      completed = 0;

      for(p = 0; p < level.completednodes.size; p++) {
        if(level.completednodes[p] != self) {
          continue;
        }

        completed = 1;
        break;
      }

      if(completed) {
        continue;
      }

      level.activenodes[level.activenodes.size] = self;
      spawner.origin = self.origin;
      spawner.angles = self.angles;
      spawner.count = 1;
      spawn = spawner stalingradspawn();

      if(ai::spawn_failed(spawn)) {
        removeactivespawner(self);
        continue;
      }

      break;
    }

    if(isalive(spawn)) {
      break;
    }
  }

  wait 1;

  if(isalive(spawn)) {
    spawn.ignoreme = 1;
    spawn.team = "\xba\xa5\x1f\xc9m\x80i";
    spawn setgoalpos(spawn.origin);
    thread createline(self.origin);
    spawn thread utility_sp::debugorigin();
    thread createlineconstantly(spawn);
    spawn waittill("\x1e\xfd\xd1\xa2\a");
  }

  removeactivespawner(self);
  level.completednodes[level.completednodes.size] = self;
}

function removeactivespawner(spawner) {
  newspawners = [];

  for(p = 0; p < level.activenodes.size; p++) {
    if(level.activenodes[p] == spawner) {
      continue;
    }

    newspawners[newspawners.size] = level.activenodes[p];
  }

  level.activenodes = newspawners;
}

function createline(org) {
  for(;;) {
    line(org + (0, 0, 35), org, (0.2, 0.5, 0.8), 0.5);
    wait 0.05;
  }
}

function createlineconstantly(ent) {
  org = undefined;

  while(isalive(ent)) {
    org = ent.origin;
    wait 0.05;
  }

  for(;;) {
    line(org + (0, 0, 35), org, (1, 0.2, 0.1), 0.5);
    wait 0.05;
  }
}

function debugmisstime() {
  self notify("\xd6\x04\xa3o\xec\xdc\x02\xa1}(\xfe\xd6\x93m\x1e8\xef");
  self endon("\xd6\x04\xa3o\xec\xdc\x02\xa1}(\xfe\xd6\x93m\x1e8\xef");
  self endon("\x1e\xfd\xd1\xa2\a");

  for(;;) {
    if(self.misstime <= 0) {
      print3d(self gettagorigin("<dev string:x1bb>") + (0, 0, 15), "<dev string:x1c6>", (0.3, 1, 1), 1);
    } else {
      print3d(self gettagorigin("<dev string:x1bb>") + (0, 0, 15), self.misstime / 20, (0.3, 1, 1), 1);
    }

    wait 0.05;
  }
}

function debugmisstimeoff() {
  self notify("\xd6\x04\xa3o\xec\xdc\x02\xa1}(\xfe\xd6\x93m\x1e8\xef");
}

function debugjump(num) {
  ai = getaiarray();

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentnum() != num) {
      continue;
    }

    line(level.player.origin, ai[i].origin, (0.2, 0.3, 1));
    return;
  }
}

function add_debugdvar_func(dvar, func, isthreaded, unarchived) {
  if(!isDefined(level.debug.dvarfuncs)) {
    level.debug.dvarfuncs = [];
  }

  setdvarifuninitialized(dvar, "");
  struct = spawnStruct();
  struct.func = func;

  if(isDefined(isthreaded)) {
    struct.threaded = isthreaded;
  }

  if(isDefined(unarchived)) {
    struct.unarchived = unarchived;
  }

  level.debug.dvarfuncs[dvar] = struct;
}

function function_f6053de404268a55(dvar, func, isthreaded, unarchived) {
  if(!isDefined(level.debug.dvarfuncs)) {
    level.debug.dvarfuncs = [];
  }

  setsaveddvar(dvar, "");
  struct = spawnStruct();
  struct.func = func;

  if(isDefined(isthreaded)) {
    struct.threaded = isthreaded;
  }

  if(isDefined(unarchived)) {
    struct.unarchived = unarchived;
  }

  level.debug.dvarfuncs[dvar] = struct;
}

function debugdvars() {
  setdvarifuninitialized(@ "chasecam", "<dev string:x24>");
  setdvarifuninitialized(@ "viewfx", "<dev string:x1b7>");
  setdvarifuninitialized(@ "hash_37d76fdaaaf3cdc2", 5000);
  setdvarifuninitialized(@ "hash_2f6380dc3031a0fc", "<dev string:x1b7>");
  setdvarifuninitialized(@ "vehicle_info", 0);
  setdvarifuninitialized(@ "getdot", 0);
  setdvarifuninitialized(@ "hash_72b0388125bf2dc7", "<dev string:x3e>");
  setdvarifuninitialized(@ "hash_699fc1c7391fd205", "<dev string:x3e>");
  setdvarifuninitialized(@ "hash_5b7d7e85c162b396", "<dev string:x3e>");
  waittillframeend();
  setdvarifuninitialized(@ "hash_a97a14e158de2f29", "<dev string:x3e>");
  setdvarifuninitialized(@ "debug_lookangle", "<dev string:x3e>");
  setdvarifuninitialized(@ "hash_4f3a4c91fee3cc20", "<dev string:x3e>");
  setdvarifuninitialized(@ "debug_enemypos", "<dev string:x1cd>");
  setdvarifuninitialized(@ "hash_693e9933a3c8a920", "<dev string:x1cd>");
  setdvarifuninitialized(@ "debug_stopenemypos", "<dev string:x1cd>");
  setdvarifuninitialized(@ "hash_1ff4a87138925423", "<dev string:x1cd>");
  setdvarifuninitialized(@ "debug_tag", "<dev string:x1b7>");
  setdvarifuninitialized(@ "hash_59086e72bc73e827", "<dev string:x1b7>");
  setdvarifuninitialized(@ "debug_vehicletag", "<dev string:x1b7>");
  setdvarifuninitialized(@ "hash_10b43cfca1168946", 0);
  setdvarifuninitialized(@ "hash_34dab4f8f3a04f4a", "<dev string:x3e>");
  setdvarifuninitialized(@ "debug_hatmodel", "<dev string:x45>");
  setdvarifuninitialized(@ "debug_trace", "<dev string:x3e>");
  setdvarifuninitialized(@ "hash_4c2f239edafa91c9", 0);
  level.debug_badpath = 0;
  setdvarifuninitialized(@ "debug_badpath", "<dev string:x3e>");
  setdvarifuninitialized(@ "hash_1ce84125965029f3", "<dev string:x3e>");
  setdvarifuninitialized(@ "hash_6a1fee590f7dbc5c", "<dev string:x1b7>");
  setdvarifuninitialized(@ "debug_nuke", "<dev string:x3e>");
  setdvarifuninitialized(@ "hash_144cc37890335117", -1);
  setdvarifuninitialized(@ "debug_deathents", "<dev string:x3e>");
  setdvarifuninitialized(@ "debug_jump", "<dev string:x1b7>");
  setdvarifuninitialized(@ "debug_hurt", "<dev string:x1b7>");
  setdvarifuninitialized(@ "animsound", "<dev string:x3e>");
  setdvarifuninitialized(@ "tag", "<dev string:x1b7>");
  setdvarifuninitialized(@ "hash_4589562a903db3e0", 1);

  for(i = 1; i <= level.animsound_hudlimit; i++) {
    setdvarifuninitialized(hashcat(@ "tag", i), "<dev string:x1b7>");
  }

  setdvarifuninitialized(@ "animsound_save", "<dev string:x1b7>");
  setdvarifuninitialized(@ "debug_depth", "<dev string:x1b7>");
  setdvarifuninitialized(@ "debug_colornodes", 0);
  setdvarifuninitialized(@ "debug_fxlighting", "<dev string:x24>");
  debug_reflection::init_reflection_probe();
  debug_graycard::init_graycard();
  level.last_threat_debug = -23430;
  setdvarifuninitialized(@ "debug_threat", "<dev string:x1cd>");
  level._effect["<dev string:x1d3>"] = loadfxasset("<dev string:x1e8>");
  setdvarifuninitialized(@ "debug_battlechatter", "<dev string:x3e>");
  add_debugdvar_func(@ "hash_c6a78f9ed07155ad", &measure, 1, 1);
  add_debugdvar_func(@ "hash_e3cff398a5a53a72", &display_ai_group_info, 0, 1);
  add_debugdvar_func(@ "hash_90c35ec29eb76f0", &function_994ee67d4cc39b40, 1);
  add_debugdvar_func(@ "hash_9948014b33a0e323", &function_8beef9c8b27394ab, 1);
  add_debugdvar_func(@ "hash_c5fc60671c328201", &function_ed8007b1db3a4f33, 1);
  add_debugdvar_func(@ "hash_965c4785698b6c50", &function_76e110b1a4613b00, 1);
  function_f6053de404268a55(@ "scr_giveweapon", &gui_giveweapon, 1);
  add_debugdvar_func(@ "scr_giveattachment", &gui_giveattachment, 1);
  add_debugdvar_func(@ "hash_3336a486aff69f38", &devlistinventory, 1);
  add_debugdvar_func(@ "hash_985a6eb7146ff86e", &function_d0d653b1b75bd38a, 0);
  setdvarifuninitialized(@ "hash_c6a78f9ed07155ad", 0);
  setdvarifuninitialized(@ "hash_bc81c5010a46eadf", 0);
  setdvarifuninitialized(@ "hash_5bed111185579616", 0);
  setdvarifuninitialized(@ "hash_1427b6dfc4e0eaad", 0);
  setdvarifuninitialized(@ "hash_6efeeea168f0a561", 0);
  setdvarifuninitialized(@ "hash_f0511426fbbb4ffe", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_5d83147342337f0b", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_ffb81124aa15605e", "<dev string:x1b7>");
  setdvarifuninitialized(@ "hash_bfa85251279c2497", "<dev string:x1b7>");
  thread function_4cbd27c8fc2c4d01();
  red = (1, 0, 0);
  blue = (0, 0, 1);
  yellow = (1, 1, 0);
  cyan = (0, 1, 1);
  green = (0, 1, 0);
  purple = (1, 0, 1);
  orange = (1, 0.5, 0);
  level.color_debug["<dev string:x206>"] = red;
  level.color_debug["<dev string:x20b>"] = blue;
  level.color_debug["<dev string:x210>"] = yellow;
  level.color_debug["<dev string:x215>"] = cyan;
  level.color_debug["<dev string:x21a>"] = green;
  level.color_debug["<dev string:x21f>"] = purple;
  level.color_debug["<dev string:x224>"] = orange;
  level.debug_fxlighting = 0;
  noanimscripts = getDvar(@ "hash_993202a1929383dc") == "<dev string:x45>";

  for(;;) {
    if(getdvarint(@ "getdot") > 0) {
      draw_dot_for_ent(getdvarint(@ "getdot"));
    }

    if(getdvarint(@ "viewfx")) {
      viewfx();
      setDvar(@ "viewfx", "<dev string:x1b7>");
    }

    if(getDvar(@ "hash_2f6380dc3031a0fc") != "<dev string:x1b7>") {
      if(isDefined(level.bcs_hud)) {
        level.bcs_hud destroy();
        level.bcs_hud = undefined;
      }
    }

    utility_code::update_battlechatter_hud();

    if(getDvar(@ "debug_jump") != "<dev string:x1b7>") {
      debugjump(getdvarint(@ "debug_jump"));
    }

    if(getdvarint(@ "chasecam")) {
      chasecam(getdvarint(@ "chasecam"));
    }

    if(getDvar(@ "debug_tag") != "<dev string:x1b7>") {
      thread viewtag("<dev string:x229>", getDvar(@ "debug_tag"));

      if(getdvarint(@ "hash_b41009d51346ca25") > 0) {
        thread drawenttag(getdvarint(@ "hash_b41009d51346ca25"));
      }
    }

    if(getdvarint(@ "debug_colornodes")) {
      thread debug_colornodes();
    }

    if(getDvar(@ "hash_1ff4a87138925423") == "<dev string:x45>") {
      thread debug_enemyposreplay();
    }

    if(getDvar(@ "tag") != "<dev string:x1b7>") {
      thread debug_animsoundtagselected();
    }

    for(i = 1; i <= level.animsound_hudlimit; i++) {
      if(getDvar(hashcat(@ "tag", i)) != "<dev string:x1b7>") {
        thread debug_animsoundtag(i);
      }
    }

    if(getDvar(@ "debug_nuke") != "<dev string:x3e>") {
      thread debug_nuke();
    }

    var_f0faac7e40e0964b = getdvarint(@ "hash_144cc37890335117", -1);

    if(var_f0faac7e40e0964b >= 0) {
      thread function_73a25bc60b70fc49(var_f0faac7e40e0964b);
      setDvar(@ "hash_144cc37890335117", -1);
    }

    if(getDvar(@ "debug_misstime") == "<dev string:x45>") {
      setDvar(@ "debug_misstime", "<dev string:x22f>");
      utility::array_thread(getaiarray(), &debugmisstime);
    } else if(getDvar(@ "debug_misstime") == "<dev string:x3e>") {
      setDvar(@ "debug_misstime", "<dev string:x22f>");
      utility::array_thread(getaiarray(), &debugmisstimeoff);
    }

    if(getDvar(@ "debug_deathents") == "<dev string:x45>") {
      thread deathspawnerpreview();
    }

    if(getDvar(@ "debug_hurt") == "<dev string:x45>") {
      setDvar(@ "debug_hurt", "<dev string:x3e>");
      level.player utility_sp::do_damage(50, (324234, 3.42342e+06, 2323));
    }

    if(getDvar(@ "debug_hurt") == "<dev string:x45>") {
      setDvar(@ "debug_hurt", "<dev string:x3e>");
      level.player utility_sp::do_damage(50, (324234, 3.42342e+06, 2323));
    }

    if(getdvarint(@ "vehicle_info")) {
      random_noteworthy = randomint(34234) + "<dev string:x238>" + randomint(23423);
      setDvar(@ "vehicle_info", 0);
      vehicles = getEntArray("<dev string:x23d>", #code_classname);

      foreach(vehicle in vehicles) {
        if(!isDefined(vehicle)) {
          continue;
        }

        if(isspawner(vehicle)) {
          continue;
        }

        vehicle print_vehicle_info(random_noteworthy);
      }
    }

    if(getDvar(@ "debug_threat") != "<dev string:x1cd>") {
      debugthreat();
    }

    level.debug_badpath = getDvar(@ "debug_badpath") == "<dev string:x45>";

    if(getdvarint(@ "debug_enemypos") != -1) {
      thread debug_enemypos(getdvarint(@ "debug_enemypos"));
      setDvar(@ "debug_enemypos", "<dev string:x1cd>");
    }

    if(getdvarint(@ "debug_stopenemypos") != -1) {
      thread debug_stopenemypos(getdvarint(@ "debug_stopenemypos"));
      setDvar(@ "debug_stopenemypos", "<dev string:x1cd>");
    }

    if(!noanimscripts && getDvar(@ "hash_993202a1929383dc") == "<dev string:x45>") {
      anim.defaultexception = &init::infiniteloop;
      noanimscripts = 1;
    }

    if(noanimscripts && getDvar(@ "hash_993202a1929383dc") == "<dev string:x3e>") {
      anim.defaultexception = &init::empty;
      anim notify("<dev string:x24f>");
      noanimscripts = 0;
    }

    if(getDvar(@ "debug_trace") == "<dev string:x45>") {
      if(!isDefined(level.tracestart)) {
        thread showdebugtrace();
      }

      level.tracestart = level.player getEye();
      setDvar(@ "debug_trace", "<dev string:x3e>");
    }

    debug_fxlighting();

    if(getunarchiveddebugdvar(@ "hash_bc81c5010a46eadf") == "<dev string:x29>") {
      entity_count();
    }

    if(getunarchiveddebugdvar(@ "hash_e88f0c15c278fb42") != "<dev string:x24>") {
      thread entity_count_hud();
    }

    if(getunarchiveddebugdvar(@ "hash_1427b6dfc4e0eaad") == "<dev string:x29>") {
      function_a1fa8fe76e66c54d();
    }

    if(getunarchiveddebugdvar(@ "hash_5bed111185579616") == "<dev string:x29>") {
      thread function_6b6a82d0a6baf64a();
    }

    if(getunarchiveddebugdvar(@ "hash_f0511426fbbb4ffe") == "<dev string:x29>") {
      thread show_animnames();
    }

    var_9111716360e72c91 = 0;

    if(getdvarint(@ "hash_6014f2652bf27fbd", 0) > 0) {
      var_9111716360e72c91 = 1;
      setdevdvar(@ "hash_6014f2652bf27fbd", 0);
    }

    var_503477c854eb1ec4 = int(clamp(getdvarint(@ "hash_a93048b4cc8944c6", 0), 0, 1));
    var_57484d6b3cb0bba9 = int(clamp(getdvarint(@ "hash_da232dc1e09b442f", 0), 0, 1));
    var_295e9da422fdfad8 = int(clamp(getdvarint(@ "hash_64a0e98780e8314c", 0), 0, 1));

    if(var_503477c854eb1ec4 + var_57484d6b3cb0bba9 + var_295e9da422fdfad8 > 1 || var_9111716360e72c91) {
      if(!var_9111716360e72c91) {
        assertmsg("<dev string:x261>");
      }

      var_503477c854eb1ec4 = 0;
      var_57484d6b3cb0bba9 = 0;
      var_295e9da422fdfad8 = 0;
      setdevdvar(@ "hash_a93048b4cc8944c6", 0);
      setdevdvar(@ "hash_da232dc1e09b442f", 0);
      setdevdvar(@ "hash_64a0e98780e8314c", 0);
    }

    level.var_503477c854eb1ec4 = var_503477c854eb1ec4 > 0;
    level.var_57484d6b3cb0bba9 = var_57484d6b3cb0bba9 > 0;
    level.var_295e9da422fdfad8 = var_295e9da422fdfad8 > 0;
    dbgmoloflareuponly = int(clamp(getdvarint(@ "hash_dd7a5bb1a9c26a79", 0), 0, 1));
    dbgmoloburnlooponly = int(clamp(getdvarint(@ "hash_6c48e28c41d5b37b", 0), 0, 1));
    dbgmolodiedownonly = int(clamp(getdvarint(@ "hash_817c6525fd061802", 0), 0, 1));

    if(dbgmoloflareuponly + dbgmoloburnlooponly + dbgmolodiedownonly > 1 || var_9111716360e72c91) {
      if(!var_9111716360e72c91) {
        assertmsg("<dev string:x2da>");
      }

      dbgmoloflareuponly = 0;
      dbgmoloburnlooponly = 0;
      dbgmolodiedownonly = 0;
      setdevdvar(@ "hash_dd7a5bb1a9c26a79", 0);
      setdevdvar(@ "hash_6c48e28c41d5b37b", 0);
      setdevdvar(@ "hash_817c6525fd061802", 0);
    }

    level.dbgmoloflareuponly = dbgmoloflareuponly > 0;
    level.dbgmoloburnlooponly = dbgmoloburnlooponly > 0;
    level.dbgmolodiedownonly = dbgmolodiedownonly > 0;

    if(!var_9111716360e72c91) {
      level.dbgmolodrawhits = getdvarint(@ "hash_bdb86700db7d369e", 0) > 0;
      level.var_888b1740fec4762 = getdvarint(@ "hash_c5a7cfaf6b0c9ac0", 0) > 0;
    } else {
      setdevdvar(@ "hash_bdb86700db7d369e", 0);
      level.dbgmolodrawhits = 0;
      setdevdvar(@ "hash_c5a7cfaf6b0c9ac0", 0);
      level.var_888b1740fec4762 = 0;
    }

    if(getdvarint(@ "hash_5d83147342337f0b") > 0 && getdvarint(@ "hash_f6ac786807a5e9cb") < 1) {
      thread debug_spawnai::spawn_ai_mode();
    }

    if(getdvarint(@ "hash_b8b13c8ec5d6a4e4") > 0) {
      show_arrivalexit_state();
    }

    if(getDvar(@ "hash_ffb81124aa15605e") != "<dev string:x1b7>") {
      utility::flag_set(getDvar(@ "hash_ffb81124aa15605e"));
      setDvar(@ "hash_ffb81124aa15605e", "<dev string:x1b7>");
    }

    if(getDvar(@ "hash_bfa85251279c2497") != "<dev string:x1b7>") {
      utility::flag_clear(getDvar(@ "hash_bfa85251279c2497"));
      setDvar(@ "hash_bfa85251279c2497", "<dev string:x1b7>");
    }

    process_dvarfuncs();
    waitframe();
  }
}

function show_arrivalexit_state() {
  bg_entinfo = getDvar(@ "bg_entinfo");
  array = [];

  if(bg_entinfo == "<dev string:x354>") {
    array = getaiarray();
  } else if(bg_entinfo == "<dev string:x379>" && getdvarint(@ "ai_debugentindex") != -1) {
    array[0] = getentbynum(getdvarint(@ "ai_debugentindex"));
  } else {
    return;
  }

  foreach(ai in array) {
    if(isalive(ai)) {
      if(istrue(ai.disableexits)) {
        text_pos = ai.origin + (0, 0, 16);
        print3d(text_pos, "<dev string:x3a2>", (1, 0.2, 0.2), 1, 0.5, 1);
      }

      if(istrue(ai.disablearrivals)) {
        text_pos = ai.origin + (0, 0, 8);
        print3d(text_pos, "<dev string:x3b4>", (1, 0.2, 0.2), 1, 0.5, 1);
      }
    }
  }
}

function process_dvarfuncs() {
  foreach(dvarstr, data in level.debug.dvarfuncs) {
    dvarval = undefined;

    if(isDefined(data.unarchived)) {
      dvarval = getunarchiveddebugdvar(dvarstr);
    } else {
      dvarval = getDvar(dvarstr);
    }

    if(!isDefined(dvarval)) {
      continue;
    }

    if(dvarval == "<dev string:x24>" || dvarval == "<dev string:x1b7>") {
      continue;
    }

    if(isDefined(data.threaded)) {
      thread[[data.func]]();
      continue;
    }

    [[data.func]]();
  }
}

function remove_fxlighting_object() {
  if(level.debug_fxlighting == 1) {
    level.var_b0a0c4883311addd delete();
  }
}

function create_fxlighting_object() {
  level.var_b0a0c4883311addd = spawn("<dev string:x5c>", level.player getEye() + anglesToForward(level.player.angles) * 100);
  level.var_b0a0c4883311addd setModel("<dev string:x81>");
  level.var_b0a0c4883311addd.origin = level.player getEye() + anglesToForward(level.player getplayerangles()) * 100;
  level.var_b0a0c4883311addd linkTo(level.player);
  level.var_b0a0c4883311addd thread play_fxlighting_fx();
  thread debug_fxlighting_buttons();
}

function play_fxlighting_fx() {
  self endon("<dev string:x177>");

  while(true) {
    playFXOnTag(utility::getfx("<dev string:x1d3>"), self, "<dev string:x81>");
    wait 0.1;
  }
}

function debug_fxlighting() {
  if(getDvar(@ "debug_fxlighting") == "<dev string:x29>" && level.debug_fxlighting != 1) {
    create_fxlighting_object();
    level.debug_fxlighting = 1;
    return;
  }

  if(getDvar(@ "debug_fxlighting") == "<dev string:x24>" && level.debug_fxlighting != 0) {
    remove_fxlighting_object();
    level.debug_fxlighting = 0;
  }
}

function debug_fxlighting_buttons() {
  offset = 100;
  lastoffset = offset;
  offsetinc = 50;

  while(getDvar(@ "debug_fxlighting") == "<dev string:x29>" || getDvar(@ "debug_fxlighting") == "<dev string:x3c9>") {
    if(level.player buttonPressed("<dev string:x3ce>")) {
      offset += offsetinc;
    }

    if(level.player buttonPressed("<dev string:x3da>")) {
      offset -= offsetinc;
    }

    if(offset > 1000) {
      offset = 1000;
    }

    if(offset < 64) {
      offset = 64;
    }

    level.var_b0a0c4883311addd unlink();
    level.var_b0a0c4883311addd.origin = level.player getEye() + anglesToForward(level.player getplayerangles()) * offset;
    lastoffset = offset;
    level.var_b0a0c4883311addd linkTo(level.player);
    wait 0.05;
  }
}

function showdebugtrace() {
  startoverride = undefined;
  endoverride = undefined;
  startoverride = (15.1859, -12.2822, 4.071);
  endoverride = (947.2, -10918, 64.9514);
  assert(!isDefined(level.traceend));

  for(;;) {
    wait 0.05;
    start = startoverride;
    end = endoverride;

    if(!isDefined(startoverride)) {
      start = level.tracestart;
    }

    if(!isDefined(endoverride)) {
      end = level.player getEye();
    }

    trace = trace::_bullet_trace(start, end, 0, undefined);
    line(start, trace["<dev string:x3e6>"], (0.9, 0.5, 0.8), 0.5);
  }
}

function debug_character_count() {
  drones = newhudelem();
  drones.alignx = "=\xff0b";
  drones.aligny = "#\xb8\xfd\xf5\x1a@";
  drones.x = 10;
  drones.y = 100;
  drones.label = &"debug_drones";
  drones.alpha = 0;
  allies = newhudelem();
  allies.alignx = "=\xff0b";
  allies.aligny = "#\xb8\xfd\xf5\x1a@";
  allies.x = 10;
  allies.y = 115;
  allies.label = &"debug_allies";
  allies.alpha = 0;
  axis = newhudelem();
  axis.alignx = "=\xff0b";
  axis.aligny = "#\xb8\xfd\xf5\x1a@";
  axis.x = 10;
  axis.y = 130;
  axis.label = &"debug_axis";
  axis.alpha = 0;
  vehicles = newhudelem();
  vehicles.alignx = "=\xff0b";
  vehicles.aligny = "#\xb8\xfd\xf5\x1a@";
  vehicles.x = 10;
  vehicles.y = 145;
  vehicles.label = &"debug_vehicles";
  vehicles.alpha = 0;
  total = newhudelem();
  total.alignx = "=\xff0b";
  total.aligny = "#\xb8\xfd\xf5\x1a@";
  total.x = 10;
  total.y = 160;
  total.label = &"debug_total";
  total.alpha = 0;
  var_e8505e0ac57cdda8 = "\xf8\x88m";

  for(;;) {
    dvar = getDvar(@ "debug_character_count");

    if(dvar == "\xf8\x88m") {
      if(dvar != var_e8505e0ac57cdda8) {
        drones.alpha = 0;
        allies.alpha = 0;
        axis.alpha = 0;
        vehicles.alpha = 0;
        total.alpha = 0;
        var_e8505e0ac57cdda8 = dvar;
      }

      wait 0.25;
      continue;
    } else if(dvar != var_e8505e0ac57cdda8) {
      drones.alpha = 1;
      allies.alpha = 1;
      axis.alpha = 1;
      vehicles.alpha = 1;
      total.alpha = 1;
      var_e8505e0ac57cdda8 = dvar;
    }

    count_drones = getEntArray("\x01\x1b\x99\xd5e", #targetname).size;
    drones setvalue(count_drones);
    count_allies = getaiarray("O\x15\x1b\xad\x9ff").size;
    allies setvalue(count_allies);
    count_axis = getaiarray("\x9a\x1f\x83\x1bs=\x13\xf8").size;
    axis setvalue(count_axis);
    vehicles setvalue(getEntArray("\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e", #classname).size);
    total setvalue(count_drones + count_allies + count_axis);
    wait 0.25;
  }
}

function nuke() {
  if(!self.damageshield) {
    if(isDefined(self.unittype) && self.unittype == "\x11\xabV") {
      self kill((0, 0, -500), level.player);
      return;
    }

    self kill((0, 0, -500), level.player, level.player);
  }
}

function function_73a25bc60b70fc49(entnum) {
  ai = getaispeciesarray("<dev string:x3f2>", "<dev string:x3fe>");

  for(i = 0; i < ai.size; i++) {
    if(ai[i] getentitynumber() != entnum) {
      ai[i] nuke();
    }
  }
}

function debug_nuke() {
  dvar = getDvar(@ "debug_nuke");

  if(dvar == "<dev string:x45>") {
    ai = getaispeciesarray("<dev string:x3f2>", "<dev string:x3fe>");

    for(i = 0; i < ai.size; i++) {
      ai[i] nuke();
    }

    if(isDefined(level.bosses)) {
      foreach(boss in level.bosses) {
        if(!isDefined(boss.damageshield) || !boss.damageshield) {
          boss kill((0, 0, -500), level.player, level.player);
        }
      }
    }
  } else if(dvar == "<dev string:x229>") {
    ai = getaiarray("<dev string:x3f2>");

    for(i = 0; i < ai.size; i++) {
      ai[i] nuke();
    }
  } else if(dvar == "<dev string:x405>") {
    ai = getaispeciesarray("<dev string:x3f2>", "<dev string:x40d>");

    for(i = 0; i < ai.size; i++) {
      ai[i] nuke();
    }
  } else if(dvar == "<dev string:x414>") {
    vehicles = vehicle_getarray();

    foreach(vehicle in vehicles) {
      if(vehicle.script_team == "<dev string:x420>" && !isDefined(vehicle.godmode)) {
        vehicle kill();
      }
    }
  }

  setDvar(@ "debug_nuke", "<dev string:x3e>");
}

function camera() {
  wait 0.05;
  cameras = getEntArray("}
  }\
  xd9\xc9\xe83 ", #targetname);

  for(i = 0; i < cameras.size; i++) {
    ent = getEnt(cameras[i].target, #targetname);
    cameras[i].origin2 = ent.origin;
    cameras[i].angles = vectortoangles(ent.origin - cameras[i].origin);
  }

  for(;;) {
    if(getDvar(@ "camera") != "<dev string:x45>") {
      if(getDvar(@ "camera") != "<dev string:x3e>") {
        setDvar(@ "camera", "<dev string:x3e>");
      }

      wait 1;
      continue;
    }

    ai = getaiarray("?\xb1\xc0\x9a");

    if(!ai.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    var_899b435e3de88887 = [];

    for(i = 0; i < cameras.size; i++) {
      for(p = 0; p < ai.size; p++) {
        if(distance(cameras[i].origin, ai[p].origin) > 256) {
          continue;
        }

        var_899b435e3de88887[var_899b435e3de88887.size] = cameras[i];
        break;
      }
    }

    if(!var_899b435e3de88887.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    var_bb6d697edfc649ba = [];

    for(i = 0; i < var_899b435e3de88887.size; i++) {
      camera = var_899b435e3de88887[i];
      start = camera.origin2;
      end = camera.origin;
      difference = vectortoangles((end[0], end[1], end[2]) - (start[0], start[1], start[2]));
      angles = (0, difference[1], 0);
      forward = anglesToForward(angles);
      difference = vectorNormalize(end - level.player.origin);
      dot = vectordot(forward, difference);

      if(dot < 0.85) {
        continue;
      }

      var_bb6d697edfc649ba[var_bb6d697edfc649ba.size] = camera;
    }

    if(!var_bb6d697edfc649ba.size) {
      freeplayer();
      wait 0.5;
      continue;
    }

    dist = distance(level.player.origin, var_bb6d697edfc649ba[0].origin);
    newcam = var_bb6d697edfc649ba[0];

    for(i = 1; i < var_bb6d697edfc649ba.size; i++) {
      newdist = distance(level.player.origin, var_bb6d697edfc649ba[i].origin);

      if(newdist > dist) {
        continue;
      }

      newcam = var_bb6d697edfc649ba[i];
      dist = newdist;
    }

    setplayertocamera(newcam);
    wait 3;
  }
}

function freeplayer() {
  setDvar(@ "hash_f94addedc8e87b69", "\xfe");
}

function setplayertocamera(camera) {
  setDvar(@ "hash_f94addedc8e87b69", "\x19");

  setdebugangles(camera.angles);

  setdebugorigin(camera.origin + (0, 0, -60));
}

function deathspawnerpreview() {
  waittillframeend();

  for(i = 0; i < 50; i++) {
    if(!isDefined(level.deathspawnerents[i])) {
      continue;
    }

    array = level.deathspawnerents[i];

    for(p = 0; p < array.size; p++) {
      ent = array[p];

      if(isDefined(ent.truecount)) {
        print3d(ent.origin, i + "<dev string:xee>" + ent.truecount, (0, 0.8, 0.6), 5);

        continue;
      }

      print3d(ent.origin, i + "<dev string:xee>" + "<dev string:x428>", (0, 0.8, 0.6), 5);
    }
  }
}

function lastsightposwatch() {
  for(;;) {
    wait 0.05;
    num = getdvarint(@ "lastsightpos");

    if(!num) {
      continue;
    }

    guy = undefined;
    ai = getaiarray();

    for(i = 0; i < ai.size; i++) {
      if(ai[i] getentnum() != num) {
        continue;
      }

      guy = ai[i];
      break;
    }

    if(!isalive(guy)) {
      continue;
    }

    if(guy utility::hasenemysightpos()) {
      org = guy utility::getenemysightpos();
    } else {
      org = undefined;
    }

    for(;;) {
      newnum = getdvarint(@ "lastsightpos");

      if(num != newnum) {
        break;
      }

      if(isalive(guy) && guy utility::hasenemysightpos()) {
        org = guy utility::getenemysightpos();
      }

      if(!isDefined(org)) {
        wait 0.05;
        continue;
      }

      range = 10;
      color = (0.2, 0.9, 0.8);
      line(org + (0, 0, range), org + (0, 0, range * -1), color, 1);
      line(org + (range, 0, 0), org + (range * -1, 0, 0), color, 1);
      line(org + (0, range, 0), org + (0, range * -1, 0), color, 1);
      wait 0.05;
    }
  }
}

function watchminimap() {
  while(true) {
    updateminimapsetting();
    wait 0.25;
  }
}

function updateminimapsetting() {
  requiredmapaspectratio = getdvarfloat(@ "scr_requiredmapaspectratio", 1);

  if(!isDefined(level.minimapcornertargetname)) {
    setDvar(@ "hash_4ce073db68d6da5d", "-!\x168\xc7\xd3\x01\xdd@\xf3pv\xb1u");
    level.minimapcornertargetname = "-!\x168\xc7\xd3\x01\xdd@\xf3pv\xb1u";
  }

  if(!isDefined(level.minimapheight)) {
    setDvar(@ "scr_minimap_height", "\xfe");
    level.minimapheight = 0;
  }

  minimapheight = getdvarfloat(@ "scr_minimap_height");
  minimapcornertargetname = getDvar(@ "hash_4ce073db68d6da5d");

  if(minimapheight != level.minimapheight || minimapcornertargetname != level.minimapcornertargetname) {
    if(isDefined(level.minimaporigin)) {
      level.minimapplayer unlink();
      level.minimaporigin delete();
      level notify("\x195\xe0\fv-\xd8-=\xdd\x84zav\xf1\xa5$\xd8x");
    }

    if(minimapheight > 0) {
      level.minimapheight = minimapheight;
      level.minimapcornertargetname = minimapcornertargetname;
      player = level.player;
      corners = getEntArray(minimapcornertargetname, #targetname);

      if(corners.size == 2) {
        viewpos = corners[0].origin + corners[1].origin;
        viewpos = (viewpos[0] * 0.5, viewpos[1] * 0.5, viewpos[2] * 0.5);
        maxcorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);
        mincorner = (corners[0].origin[0], corners[0].origin[1], viewpos[2]);

        if(corners[1].origin[0] > corners[0].origin[0]) {
          maxcorner = (corners[1].origin[0], maxcorner[1], maxcorner[2]);
        } else {
          mincorner = (corners[1].origin[0], mincorner[1], mincorner[2]);
        }

        if(corners[1].origin[1] > corners[0].origin[1]) {
          maxcorner = (maxcorner[0], corners[1].origin[1], maxcorner[2]);
        } else {
          mincorner = (mincorner[0], corners[1].origin[1], mincorner[2]);
        }

        viewpostocorner = maxcorner - viewpos;
        viewpos = (viewpos[0], viewpos[1], viewpos[2] + minimapheight);
        origin = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", player.origin);
        northvector = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
        eastvector = (northvector[1], 0 - northvector[0], 0);
        disttotop = vectordot(northvector, viewpostocorner);

        if(disttotop < 0) {
          disttotop = 0 - disttotop;
        }

        disttoside = vectordot(eastvector, viewpostocorner);

        if(disttoside < 0) {
          disttoside = 0 - disttoside;
        }

        if(requiredmapaspectratio > 0) {
          mapaspectratio = disttoside / disttotop;

          if(mapaspectratio < requiredmapaspectratio) {
            incr = requiredmapaspectratio / mapaspectratio;
            disttoside *= incr;
            addvec = vecscale(eastvector, vectordot(eastvector, maxcorner - viewpos) * (incr - 1));
            mincorner -= addvec;
            maxcorner += addvec;
          } else {
            incr = mapaspectratio / requiredmapaspectratio;
            disttotop *= incr;
            addvec = vecscale(northvector, vectordot(northvector, maxcorner - viewpos) * (incr - 1));
            mincorner -= addvec;
            maxcorner += addvec;
          }
        }

        if(isplatformconsole()) {
          aspectratioguess = 1.77778;
          angleside = 2 * atan(disttoside * 0.8 / minimapheight);
          angletop = 2 * atan(disttotop * aspectratioguess * 0.8 / minimapheight);
        } else {
          aspectratioguess = 1.33333;
          angleside = 2 * atan(disttoside * 1.05 / minimapheight);
          angletop = 2 * atan(disttotop * aspectratioguess * 1.05 / minimapheight);
        }

        if(angleside > angletop) {
          angle = angleside;
        } else {
          angle = angletop;
        }

        znear = minimapheight - 1000;

        if(znear < 16) {
          znear = 16;
        }

        if(znear > 10000) {
          znear = 10000;
        }

        player playerlinktoabsolute(origin);
        origin.origin = viewpos + (0, 0, -62);
        origin.angles = (90, getnorthyaw(), 0);
        player giveweapon("2\xa1\xf6\\ozq\xcc\xb8\xf2*\x02\x85");
        setsaveddvar(@ "cg_fov", angle);
        level.minimapplayer = player;
        level.minimaporigin = origin;
        thread drawminimapbounds(viewpos, mincorner, maxcorner);
        return;
      }

      println("<dev string:x42d>");
    }
  }
}

function getchains() {
  chainarray = [];
  chainarray = getEntArray("\xad\xb4\xb9K\xb5\x16p_\x1bK\xb9\xac", #script_noteworthy);
  array = [];

  for(i = 0; i < chainarray.size; i++) {
    array[i] = chainarray[i] getchain();
  }

  return array;
}

function getchain() {
  array = [];
  ent = self;

  while(isDefined(ent)) {
    array[array.size] = ent;

    if(!(isDefined(ent) && isDefined(ent.target))) {
      break;
    }

    ent = getEnt(ent.target, #targetname);

    if(isDefined(ent) && ent == array[0]) {
      array[array.size] = ent;
      break;
    }
  }

  originarray = [];

  for(i = 0; i < array.size; i++) {
    originarray[i] = array[i].origin;
  }

  return originarray;
}

function vecscale(vec, scalar) {
  return (vec[0] * scalar, vec[1] * scalar, vec[2] * scalar);
}

function drawminimapbounds(viewpos, mincorner, maxcorner) {
  level notify("\x195\xe0\fv-\xd8-=\xdd\x84zav\xf1\xa5$\xd8x");
  level endon("\x195\xe0\fv-\xd8-=\xdd\x84zav\xf1\xa5$\xd8x");
  viewheight = viewpos[2] - maxcorner[2];
  diaglen = length(mincorner - maxcorner);
  mincorneroffset = mincorner - viewpos;
  mincorneroffset = vectorNormalize((mincorneroffset[0], mincorneroffset[1], 0));
  mincorner += vecscale(mincorneroffset, diaglen * 1 / 800 * 0);
  maxcorneroffset = maxcorner - viewpos;
  maxcorneroffset = vectorNormalize((maxcorneroffset[0], maxcorneroffset[1], 0));
  maxcorner += vecscale(maxcorneroffset, diaglen * 1 / 800 * 0);
  north = (cos(getnorthyaw()), sin(getnorthyaw()), 0);
  diagonal = maxcorner - mincorner;
  side = vecscale(north, vectordot(diagonal, north));
  sidenorth = vecscale(north, abs(vectordot(diagonal, north)));
  corner0 = mincorner;
  corner1 = mincorner + side;
  corner2 = maxcorner;
  corner3 = maxcorner - side;
  toppos = vecscale(mincorner + maxcorner, 0.5) + vecscale(sidenorth, 0.51);
  textscale = diaglen * 0.003;
  chains = getchains();

  while(true) {
    line(corner0, corner1);
    line(corner1, corner2);
    line(corner2, corner3);
    line(corner3, corner0);

    utility::array_levelthread(chains, &utility::plot_points);

    print3d(toppos, "<dev string:x479>", (1, 1, 1), 1, textscale);

    wait 0.05;
  }
}

function debug_colornodes() {
  ai = getaiarray();
  dvar = getdvarint(@ "debug_colornodes");
  array = [];
  array["?\xb1\xc0\x9a"] = [];
  array["O\x15\x1b\xad\x9ff"] = [];
  array["\xba\xa5\x1f\xc9m\x80i"] = [];

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(!isDefined(guy.currentcolorcode)) {
      continue;
    }

    array[guy.team][guy.currentcolorcode] = 1;
    color = (1, 1, 1);

    if(isDefined(guy.script_forcecolor)) {
      color = level.color_debug[guy.script_forcecolor];
    }

    colorcode = undefined;

    if(dvar == 1) {
      var_73f549885ed2f0ba = strtok(guy.currentcolorcode, "w");

      if(var_73f549885ed2f0ba.size > 1) {
        colorcode = var_73f549885ed2f0ba[0] + "w";
      }
    }

    if(!isDefined(colorcode)) {
      colorcode = guy.currentcolorcode;
    }

    print3d(guy.origin + (0, 0, 50), colorcode, color, 1, 1);

    guy try_to_draw_line_to_node();
  }

  draw_colornodes(array, "O\x15\x1b\xad\x9ff", dvar);
  draw_colornodes(array, "?\xb1\xc0\x9a", dvar);
}

function draw_colornodes(array, team, dvar) {
  keys = getarraykeys(array[team]);

  for(i = 0; i < keys.size; i++) {
    color = (1, 1, 1);
    color = level.color_debug[getsubstr(keys[i], 0, 1)];
    colorcode = undefined;

    if(dvar == 1) {
      var_cbe75b7165f5251d = strtok(keys[i], "w");

      if(var_cbe75b7165f5251d.size > 1) {
        colorcode = var_cbe75b7165f5251d[0] + "w";
      }
    }

    if(!isDefined(colorcode)) {
      colorcode = keys[i];
    }

    if(isDefined(level.colornodes_debug_array[team][keys[i]])) {
      teamarray = level.colornodes_debug_array[team][keys[i]];

      for(p = 0; p < teamarray.size; p++) {
        print3d(teamarray[p].origin, "<dev string:x489>" + colorcode, color, 1, 1);
      }
    }

    if(isDefined(level.colorvolumes_debug_array[team][keys[i]])) {
      teamvolume = level.colorvolumes_debug_array[team][keys[i]];

      print3d(teamvolume.origin, "<dev string:x48f>" + colorcode, color, 1, 1);

      thread utility::draw_entity_bounds(teamvolume, 0.05, color, 0);
    }
  }
}

function get_team_substr() {
  if(self.team == "O\x15\x1b\xad\x9ff") {
    if(!isDefined(self.node.script_color_allies)) {
      return;
    }

    return self.node.script_color_allies;
  }

  if(self.team == "?\xb1\xc0\x9a") {
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

  substr = get_team_substr();

  if(!isDefined(substr)) {
    volume = level.arrays_of_colorcoded_volumes[colors::get_team()][self.currentcolorcode];

    if(isDefined(volume)) {
      line(self.origin + (0, 0, 64), volume.origin, level.color_debug[self.script_forcecolor], 0.5);
    }

    return;
  }

  if(!issubstr(substr, self.script_forcecolor)) {
    return;
  }

  line(self.origin + (0, 0, 64), self.node.origin, level.color_debug[self.script_forcecolor]);
}

function debugthreat() {
  level.last_threat_debug = gettime();
  thread debugthreatcalc();
}

function debugthreatcalc() {
  ai = getaiarray();
  entnum = getdvarint(@ "debug_threat");
  entity = undefined;

  if(entnum == 0) {
    entity = level.player;
  } else {
    for(i = 0; i < ai.size; i++) {
      if(entnum != ai[i] getentnum()) {
        continue;
      }

      entity = ai[i];
      break;
    }
  }

  if(!isalive(entity)) {
    return;
  }

  entitygroup = entity getthreatbiasgroup();
  utility::array_thread(ai, &displaythreat, entity, entitygroup);
  level.player thread displaythreat(entity, entitygroup);
}

function displaythreat(entity, entitygroup) {
  if(self.team == entity.team) {
    return;
  }

  selfthreat = 0;
  selfthreat += self.threatbias;
  threat = 0;
  threat += entity.threatbias;
  mygroup = undefined;

  if(isDefined(entitygroup)) {
    mygroup = self getthreatbiasgroup();

    if(isDefined(mygroup)) {
      threat += getthreatbias(entitygroup, mygroup);
      selfthreat += getthreatbias(mygroup, entitygroup);
    }
  }

  if(entity.ignoreme || threat < -900000) {
    threat = "\xa3\b\x98\x15\xc8\xe5";
  }

  if(self.ignoreme || selfthreat < -900000) {
    selfthreat = "\xa3\b\x98\x15\xc8\xe5";
  }

  timer = 20;
  col = (1, 0.5, 0.2);
  col2 = (0.2, 0.5, 1);
  pacifist = !isPlayer(self) && self.pacifist;

  for(i = 0; i <= timer; i++) {
    print3d(self.origin + (0, 0, 65), "<dev string:x495>", col, 3);
    print3d(self.origin + (0, 0, 50), threat, col, 5);

    if(isDefined(entitygroup)) {
      print3d(self.origin + (0, 0, 35), entitygroup, col, 2);
    }

    print3d(self.origin + (0, 0, 15), "<dev string:x4a3>", col2, 3);
    print3d(self.origin + (0, 0, 0), selfthreat, col2, 5);

    if(isDefined(mygroup)) {
      print3d(self.origin + (0, 0, -15), mygroup, col2, 2);
    }

    if(pacifist) {
      print3d(self.origin + (0, 0, 25), "<dev string:x4b1>", col2, 5);
    }

    waitframe();
  }
}

function debugcolorfriendlies() {
  level.debug_color_friendlies = [];
  level.debug_color_huds = [];

  for(;;) {
    level waittill("\x9cm\x91\xf1S\x89\xcd9\x80\x97\x050\x93l\xbd\xa2\xa4\xc54QP\x97\xc5\xa1");
    draw_color_friendlies();
  }
}

function get_script_palette() {
  rgb = [];
  rgb["4"] = (1, 0, 0);
  rgb["W"] = (1, 0.5, 0);
  rgb["m"] = (1, 1, 0);
  rgb["\x97"] = (0, 1, 0);
  rgb["\xcc"] = (0, 1, 1);
  rgb["\xde"] = (0, 0, 1);
  rgb["N"] = (1, 0, 1);
  return rgb;
}

function draw_color_friendlies() {
  level endon("\x9cm\x91\xf1S\x89\xcd9\x80\x97\x050\x93l\xbd\xa2\xa4\xc54QP\x97\xc5\xa1");
  keys = getarraykeys(level.debug_color_friendlies);
  colored_friendlies = [];
  colors = [];
  colors[colors.size] = "4";
  colors[colors.size] = "W";
  colors[colors.size] = "m";
  colors[colors.size] = "\x97";
  colors[colors.size] = "\xcc";
  colors[colors.size] = "\xde";
  colors[colors.size] = "N";
  rgb = get_script_palette();

  for(i = 0; i < colors.size; i++) {
    colored_friendlies[colors[i]] = 0;
  }

  for(i = 0; i < keys.size; i++) {
    color = level.debug_color_friendlies[keys[i]];
    colored_friendlies[color]++;
  }

  for(i = 0; i < level.debug_color_huds.size; i++) {
    level.debug_color_huds[i] destroy();
  }

  level.debug_color_huds = [];

  if(!getdvarint(@ "hash_10b43cfca1168946")) {
    return;
  }

  x = 15;
  y = 420;
  size = 8;
  buffer = size + 2;

  for(i = 0; i < colors.size; i++) {
    if(colored_friendlies[colors[i]] <= 0) {
      continue;
    }

    for(p = 0; p < colored_friendlies[colors[i]]; p++) {
      overlay = newhudelem();
      overlay.x = x + buffer * p;
      overlay.y = y;
      overlay setshader("e\xac\x11}\xfd", size, size);
      overlay.horzalign = "=\xff0b";
      overlay.vertalign = "\x1d Q";
      overlay.alignx = "=\xff0b";
      overlay.aligny = "\x14#\x01\x89\f\x81";
      overlay.alpha = 1;
      overlay.color = rgb[colors[i]];
      level.debug_color_huds[level.debug_color_huds.size] = overlay;
    }

    y -= buffer;
  }
}

function get_alias_from_stored(animsound) {
  if(!isDefined(level.animsound_aliases[animsound.animname])) {
    return;
  }

  if(!isDefined(level.animsound_aliases[animsound.animname][animsound.anime])) {
    return;
  }

  if(!isDefined(level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack])) {
    return;
  }

  return level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack]["\x05\xcc,L$\xab\xe9\xc0bw"];
}

function is_from_animsound(animname, anime, notetrack) {
  return isDefined(level.animsound_aliases[animname][anime][notetrack]["\x18\xf7\xe1\x91\xb5\xefJ\x85g\xc5\xed&\xd7\xd8\x94\x9c\x06\xc8\x8e\x8a"]);
}

function debug_animsoundtag(tagnum) {
  tag = getDvar(hashcat(@ "tag", tagnum));

  if(tag == "<dev string:x1b7>") {
    iprintlnbold("<dev string:x4c1>");
    return;
  }

  tag_sound(tag, tagnum - 1);
  setDvar(hashcat(@ "tag", tagnum), "<dev string:x1b7>");
}

function debug_animsoundtagselected() {
  tag = getDvar(@ "tag");

  if(tag == "<dev string:x1b7>") {
    iprintlnbold("<dev string:x4ee>");
    return;
  }

  tag_sound(tag, level.animsound_selected);
  setDvar(@ "tag", "<dev string:x1b7>");
}

function tag_sound(tag, tagnum) {
  if(!isDefined(level.animsound_tagged)) {
    return;
  }

  if(!isDefined(level.animsound_tagged.animsounds[tagnum])) {
    return;
  }

  animsound = level.animsound_tagged.animsounds[tagnum];
  soundalias = get_alias_from_stored(animsound);

  if(!isDefined(soundalias) || is_from_animsound(animsound.animname, animsound.anime, animsound.notetrack)) {
    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack]["\x05\xcc,L$\xab\xe9\xc0bw"] = tag;
    level.animsound_aliases[animsound.animname][animsound.anime][animsound.notetrack]["\x18\xf7\xe1\x91\xb5\xefJ\x85g\xc5\xed&\xd7\xd8\x94\x9c\x06\xc8\x8e\x8a"] = 1;
  }
}

function find_new_chase_target(ent_num) {
  ai = getaiarray();

  foreach(guy in ai) {
    if(guy getentnum() == ent_num) {
      level.chase_cam_target = guy;
      return;
    }
  }

  vehicles = getEntArray("<dev string:x23d>", #code_classname);

  foreach(vehicle in vehicles) {
    if(vehicle getentnum() == ent_num) {
      level.chase_cam_target = vehicle;
      return;
    }
  }

}

function chasecam(ent_num) {
  if(!isDefined(level.chase_cam_last_num)) {
    level.chase_cam_last_num = -1;
  }

  if(level.chase_cam_last_num == ent_num) {
    return;
  }

  find_new_chase_target(ent_num);

  if(!isDefined(level.chase_cam_target)) {
    return;
  }

  level.chase_cam_last_num = ent_num;

  if(!isDefined(level.chase_cam_ent)) {
    level.chase_cam_ent = level.chase_cam_target utility::spawn_tag_origin();
  }

  thread chasecam_onent(level.chase_cam_target);
}

function chasecam_onent(ent) {
  level notify("\xc2\xef~\xf9D@\xbfx\x84}L\xa3");
  level endon("\xc2\xef~\xf9D@\xbfx\x84}L\xa3");
  ent endon("\x1e\xfd\xd1\xa2\a");
  level.player unlink();
  level.player playerlinktoblend(level.chase_cam_ent, "\xec\xbfK|\au\xcd\xc2\x19<", 2, 0.5, 0.5);
  wait 2;
  level.player playerlinktodelta(level.chase_cam_ent, "\xec\xbfK|\au\xcd\xc2\x19<", 1, 180, 180, 180, 180);

  for(;;) {
    wait 0.2;

    if(!isDefined(level.chase_cam_target)) {
      return;
    }

    start = level.chase_cam_target.origin;
    angles = level.chase_cam_target.angles;
    forward = anglesToForward(angles);
    forward *= 200;
    start += forward;
    angles = level.player getplayerangles();
    forward = anglesToForward(angles);
    forward *= -200;
    level.chase_cam_ent moveTo(start + forward, 0.2);
  }
}

function viewfx() {
  foreach(fx in level.createfxent) {
    if(isDefined(fx.looper)) {
      print3d(fx.v["<dev string:x51a>"], "<dev string:x428>", (1, 1, 0), 1, 1.5, 200);
    }
  }
}

function add_key(key, val) {
  println("<dev string:x524>" + key + "<dev string:x52a>" + val + "<dev string:x531>");
}

function print_vehicle_info(noteworthy) {
  if(!isDefined(level.vnum)) {
    level.vnum = 9500;
  }

  level.vnum++;
  layer = "\xc7$\x97\x1f\xbe[!J\xa6\xfd\xa4\xd9(p";
  println("<dev string:x536>" + level.vnum);
  println("<dev string:x541>");
  add_key("\xb0$R\x8b\xc9\x17", self.origin[0] + "\xda" + self.origin[1] + "\xda" + self.origin[2]);
  add_key("\xc5\x94\x82H\x9a`", self.angles[0] + "\xda" + self.angles[1] + "\xda" + self.angles[2]);
  add_key("\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc", "x\x14\xdc\x9c^\x17O\xe2Y\x82\x8e\x86");
  add_key("\xff\xb2\x0e\xc5\xc8", self.model);
  add_key("\"\v\xb2aQU6h`", "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6");
  add_key("\xd8\xf3B\xf7\xf5M\x80\xabz\xe7", "P");
  add_key(";7U~u\xd9", "kf-\xe0\xfd.\x83#\xd8\xbeO^Z\x83\xb9\xd7\xcalh\xb2\xeb\\\xb3\x16\xe5\x9b");
  println("<dev string:x546>" + layer + "<dev string:x531>");

  if(isDefined(noteworthy)) {
    add_key("\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*", noteworthy);
  }

  println("<dev string:x552>");
}

function draw_dot_for_ent(entnum) {
  ai = getaiarray();

  foreach(guy in ai) {
    if(guy getentnum() != entnum) {
      continue;
    }

    guy draw_dot_for_guy();
  }
}

function draw_dot_for_guy() {
  player_angles = level.player getplayerangles();
  player_forward = anglesToForward(player_angles);
  end = level.player getEye();
  start = self getEye();
  angles = vectortoangles(start - end);
  forward = anglesToForward(angles);
  dot = vectordot(forward, player_forward);

  print3d(start, dot, (1, 0.5, 0));
}

function function_45363b6414f41e5b() {
  setdvarifuninitialized(@ "weaponlist", "<dev string:x24>");

  if(!getdvarint(@ "weaponlist")) {
    return;
  }

  ents = getEntArray();
  list = [];

  foreach(ent in ents) {
    if(!isDefined(ent.code_classname)) {
      continue;
    }

    if(issubstr(ent.code_classname, "<dev string:x557>")) {
      list[ent.classname] = 1;
    }
  }

  println("<dev string:x561>");

  foreach(_ in list) {
    println(weapon);
  }

  spawners = getspawnerarray();
  classes = [];

  foreach(spawner in spawners) {
    classes[spawner.code_classname] = 1;
  }

  println("<dev string:x1b7>");
  println("<dev string:x57a>");

  foreach(_ in classes) {
    println(class);
  }
}

function measure() {
  dvar = @ "hash_c6a78f9ed07155ad";

  if(getdvarint(dvar) == 2) {
    return;
  }

  thread debug_cursor();
  setDvar(dvar, 2);
  points = [];
  next_press = 0;

  while(getdvarint(dvar)) {
    if(level.player useButtonPressed() && gettime() > next_press) {
      if(points.size == 2) {
        points = [];
      } else {
        point = level.debug.cursor_pos;
        points[points.size] = point;
      }

      next_press = gettime() + 500;
    }

    foreach(i, point in points) {
      draw_debug_cross(point);

      if(i > 0) {
        dist = distance(point, points[i - 1]);
        forward = vectorNormalize(points[i - 1] - point);
        half = point + forward * dist * 0.5;
        print3d(half, dist, (1, 1, 1), 1, 0.5);
        line(point, points[i - 1], (1, 1, 1));
      }
    }

    if(points.size == 2) {
      color = (1, 0, 0);
      color = (0, 1, 0);
      color = (0.2, 0.2, 1);
      sorted = points;

      if(points[1][2] > sorted[0][2]) {
        sorted = [points[1], points[0]];
      }

      higher = sorted[0];
      lower = (higher[0], higher[1], sorted[1][2]);
      dist = distance(higher, lower);
      forward = vectorNormalize(lower - higher);
      printpos = higher + forward * dist * 0.6;
      print3d(printpos, dist, color, 1, 0.5);
      line(higher, lower, color);
    }

    waitframe();
  }

  level notify("<dev string:x592>");
}

function function_682bdd169d8e1269(number) {
  nodes = getallnodes();

  foreach(current_node in nodes) {
    this_number = current_node getnodenumber();

    if(this_number == number) {
      return current_node;
    }
  }

  return undefined;
}

function function_4cbd27c8fc2c4d01() {
  while(true) {
    if(getdvarint(@ "hash_42baf942957e2497", -1) != -1) {
      node = function_682bdd169d8e1269(getdvarint(@ "hash_42baf942957e2497", 0));
      setDvar(@ "hash_42baf942957e2497", -1);

      if(isDefined(node)) {
        debug_traversal(node);
      }
    }

    wait 0.5;
  }
}

function debug_traversal(begin_node) {
  spawners = getspawnerarray();
  assert(spawners.size > 0);
  chosen_spawner = undefined;

  foreach(spawner in spawners) {
    if(issubstr(spawner.classname, "<dev string:x5a7>")) {
      chosen_spawner = spawner;
      break;
    }
  }

  old_count = chosen_spawner.count;
  chosen_spawner.count = 1;
  old_stealthgroup = chosen_spawner.script_stealthgroup;
  chosen_spawner.script_stealthgroup = undefined;
  var_4b3e687bafef3f17 = chosen_spawner.spawn_functions;
  chosen_spawner.spawn_functions = [];
  ai = chosen_spawner utility_sp::spawn_ai(1);
  ai.ignoreall = 1;
  chosen_spawner.count = old_count;
  chosen_spawner.script_stealthgroup = old_stealthgroup;
  chosen_spawner.spawn_functions = var_4b3e687bafef3f17;
  forward = anglesToForward(begin_node.angles);
  trace_results = navtrace(begin_node.origin, begin_node.origin + forward * -128, ai, 1);
  startpos = trace_results["<dev string:x3e6>"];
  ai forceteleport(startpos);
  end_node = getnode(begin_node.target, #targetname);
  ai.goalradius = 32;
  ai.goalheight = 50;
  trace_results = navtrace(end_node.origin, end_node.origin + forward * 128, ai, 1);
  endpos = trace_results["<dev string:x3e6>"];
  ai setgoalpos(endpos);
  ai waittill("<dev string:x5b1>");
  wait 2;
  ai utility_sp::die();
}

function take_weapons_away() {
  storedweapons = spawnStruct();
  storedweapons.weapons = level.player getweaponslistall();
  storedweapons.clip_ammo = [];
  storedweapons.stock_ammo = [];

  foreach(index, weapon in storedweapons.weapons) {
    storedweapons.clip_ammo[index] = level.player getweaponammoclip(weapon);
    storedweapons.stock_ammo[index] = level.player getweaponammostock(weapon);
  }

  level.player takeallweapons();
  return storedweapons;
}

function give_weapons_back(storedweapons) {
  switchweaponindex = -1;

  foreach(index, weapon in storedweapons.weapons) {
    level.player giveweapon(weapon);

    if(weapon.ismelee) {
      level.player assignweaponmeleeslot(weapon);
      continue;
    }

    if(switchweaponindex < 0) {
      switchweaponindex = index;
    }

    if(isDefined(storedweapons.clip_ammo[index])) {
      level.player setweaponammoclip(weapon, storedweapons.clip_ammo[index]);
    }

    if(isDefined(storedweapons.stock_ammo[index])) {
      level.player setweaponammostock(weapon, storedweapons.stock_ammo[index]);
    }
  }

  level.player switchtoweapon(storedweapons.weapons[switchweaponindex]);
}

function debug_cursor(usenavmesh) {
  level.debug.cursor_pos = (0, 0, 0);
  level notify("\t\xe6\xedX\xa1\xe3\xaf\x05z\x17\xfd\xcf\x83\xcbE\x16\xe5");
  level endon("\t\xe6\xedX\xa1\xe3\xaf\x05z\x17\xfd\xcf\x83\xcbE\x16\xe5");

  if(!isDefined(usenavmesh)) {
    usenavmesh = 0;
  }

  while(true) {
    start = level.player getEye();
    forward = anglesToForward(level.player getplayerangles());

    if(usenavmesh) {
      end = start + forward * 1000;
    } else {
      end = start + forward * 10000;
    }

    trace = trace::_bullet_trace(start, end, 0);

    if(usenavmesh) {
      level.debug.cursor_pos = getclosestpointonnavmesh(trace["\xc1\xbd\xdci\xe8i{7"]) + (0, 0, -2);
    } else {
      level.debug.cursor_pos = trace["\xc1\xbd\xdci\xe8i{7"];
    }

    debugaxis(level.debug.cursor_pos, (0, 0, 0), 4, 1);

    waitframe();
  }
}

function draw_debug_cross(pos) {
  range = 4;
  color = (1, 1, 1);
  alpha = 1;
  depth = 1;
  duration = 1;
  line(pos - (0, 0, range), pos + (0, 0, range), color, alpha, depth, duration);
  line(pos - (0, range, 0), pos + (0, range, 0), color, alpha, depth, duration);
  line(pos - (range, 0, 0), pos + (range, 0, 0), color, alpha, depth, duration);
}

function draw_spawner(pos, angles, color, alpha, depthtest) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  up = anglestoup(angles);
  fwd = anglesToForward(angles);
  start = pos + up * 72 * 0.5;
  end = start + fwd * 32;
  draw_small_arrow(start, end, color, alpha, depthtest);
  draw_box(pos, color, angles, [32, 72], alpha, depthtest);
}

function draw_node(pos, angles, color, size, alpha, depthtest) {
  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(size)) {
    size = 32;
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  up = anglestoup(angles);
  fwd = anglesToForward(angles);
  start = pos + up * size * 0.5;
  end = start + fwd * size;
  draw_small_arrow(start, end, color, alpha, depthtest);
  draw_box(pos, color, angles, size, alpha, depthtest);
}

function draw_small_arrow(start, end, color, alpha, depthtest) {
  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  angle = vectortoangles(end - start);
  dist = length(end - start);
  forward = anglesToForward(angle);
  forwardfar = forward * dist;
  arrow_size = 5;
  forwardclose = forward * (dist - arrow_size);
  right = anglestoright(angle);
  leftdraw = right * arrow_size * -1;
  rightdraw = right * arrow_size;
  line(start, end, color, alpha, depthtest, 1);
  line(start, start + forwardfar, color, alpha, depthtest, 1);
  line(start + forwardfar, start + forwardclose + rightdraw, color, alpha, depthtest, 1);
  line(start + forwardfar, start + forwardclose + leftdraw, color, alpha, depthtest, 1);
}

function draw_box(pos, color, angles, size, alpha, depthtest) {
  if(!isDefined(size)) {
    width = 32;
    height = 32;
  } else if(!isarray(size)) {
    width = size;
    height = size;
  } else {
    width = size[0];
    height = size[1];
  }

  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  if(!isDefined(alpha)) {
    alpha = 1;
  }

  if(!isDefined(depthtest)) {
    depthtest = 0;
  }

  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);
  start = pos + forward * width * 0.5;
  start += right * width * 0.5;
  points = [];
  points[points.size] = start;
  points[points.size] = points[points.size - 1] + forward * width * -1;
  points[points.size] = points[points.size - 1] + right * width * -1;
  points[points.size] = points[points.size - 1] + forward * width;
  offset = height * up;

  for(i = 0; i < points.size; i++) {
    line(points[i], points[i] + offset, color, alpha, depthtest);

    if(i == points.size - 1) {
      line(points[i], points[0], color, alpha, depthtest);
      line(points[i] + offset, points[0] + offset, color, alpha, depthtest);
      continue;
    }

    line(points[i], points[i + 1], color, alpha, depthtest);
    line(points[i] + offset, points[i + 1] + offset, color, alpha, depthtest);
  }
}

function gui_giveweapon() {
  weapnew = getDvar(@ "scr_giveweapon");

  if(isDefined(weapnew)) {
    weapnewbase = getweaponbasename(weapnew);
    utility_sp::transient_load("<dev string:x5b9>" + weapnewbase + "<dev string:x5c4>");
    weap = level.player getcurrentweapon();
    level.player takeweapon(weap);
    level.player giveweapon(weapnew);
    level.player setweaponammoclip(weapnew, weaponclipsize(weapnew));
    level.player setweaponammostock(weapnew, weaponmaxammo(weapnew));
    level.player switchtoweaponimmediate(weapnew);
  }

  setsaveddvar(@ "scr_giveweapon", "<dev string:x1b7>");
}

function gui_giveattachment() {
  attachment = getDvar(@ "scr_giveattachment");

  if(isDefined(attachment)) {
    weap = level.player getcurrentweapon();
    weapbase = getweaponbasename(weap);

    if(weapbase == "<dev string:x5cb>") {
      if(attachment == "<dev string:x5d5>") {
        attachment = "<dev string:x5dd>";
      } else if(attachment == "<dev string:x5e7>") {
        attachment = "<dev string:x5f2>";
      } else if(attachment == "<dev string:x5ff>") {
        attachment = "<dev string:x606>";
      }
    } else if(weapbase == "<dev string:x60f>") {
      if(attachment == "<dev string:x5d5>") {
        attachment = "<dev string:x61a>";
      } else if(attachment == "<dev string:x5e7>") {
        attachment = "<dev string:x625>";
      } else if(attachment == "<dev string:x5ff>") {
        attachment = "<dev string:x633>";
      }
    } else if(weapbase == "<dev string:x63d>") {
      if(attachment == "<dev string:x648>") {
        attachment = "<dev string:x654>";
      }
    } else if(weapbase == "<dev string:x660>") {
      if(attachment == "<dev string:x66c>") {
        attachment = "<dev string:x677>";
      } else if(attachment == "<dev string:x689>" && weap hasattachment("<dev string:x66c>")) {
        attachment = "<dev string:x694>";
      } else if(attachment == "<dev string:x6a4>" && weap hasattachment("<dev string:x66c>")) {
        attachment = "<dev string:x6b1>";
      }
    } else if(weapbase == "<dev string:x6c3>") {
      if(attachment == "<dev string:x6d5>") {
        attachment = "<dev string:x6dd>";
      }
    } else if(weapbase == "<dev string:x6ef>") {
      if(attachment == "<dev string:x6d5>") {
        attachment = "<dev string:x700>";
      }
    }

    if(attachment != "<dev string:x711>") {
      weapnew = weapbase;
      attachments = weap.attachments;
      attachments[attachments.size] = attachment;
      attachments = utility::alphabetize(attachments);

      foreach(attachment in attachments) {
        weapnew += "<dev string:x71a>" + attachment;
      }
    } else {
      weapnew = weapbase;
    }

    level.player takeweapon(weap);
    level.player giveweapon(weapnew);
    level.player setweaponammoclip(weapnew, weaponclipsize(weapnew));
    level.player setweaponammostock(weapnew, weaponmaxammo(weapnew));
    level.player switchtoweaponimmediate(weapnew);
  }

  setdevdvar(@ "scr_giveattachment", "<dev string:x1b7>");
}

function drawdoublejumpbox(pos, color, angles, size, alpha, depthtest) {
  pos = (pos[0], pos[1], pos[2] - size / 2);
  draw_box(pos, color, angles, size, alpha, depthtest);
}

function drawdoublejumpbasics() {
  print3d(self.origin + (0, 0, 32), self.animscript, (1, 1, 1), 1);
  drawdoublejumpbox(self.origin, (0, 1, 0), (0, 0, 0), 32, 1, 0);

  if(isDefined(self.var_9d816e76337a6c04)) {
    line(self.origin, self.var_9d816e76337a6c04, (0, 1, 0), 1, 0);
    drawdoublejumpbox(self.var_9d816e76337a6c04, (0.5, 0.5, 0.5), (0, 0, 0), 32, 1, 1);
  }
}

function function_49b33b660df8608d() {
  drawdoublejumpbasics();

  if(!isDefined(self.doublejumpmantlepos)) {
    println("<dev string:x71f>" + self.origin);
    return;
  }

  line(self.origin, self.doublejumpmantlepos, (0, 1, 0), 1, 0);
  drawdoublejumpbox(self.doublejumpmantlepos, (0, 0, 1), (0, 0, 0), 16, 1, 1);
}

function drawdoublejump() {
  drawdoublejumpbasics();

  if(isDefined(self.jump_over_ent_origin)) {
    level.var_e8ea27fcedd34c62++;
    line(self.origin, self.jump_over_ent_origin, (0, 1, 0), 1, 0);
    drawdoublejumpbox(self.jump_over_ent_origin, (0, 0, 1), (0, 0, 0), 16, 1, 1);
    return;
  }

  level.var_adad9f1b06cb2546++;
}

function function_e3ce7d58eecea85e() {
  drawdoublejumpbasics();

  if(isDefined(self.var_77f860ce21581e8)) {
    line(self.origin, self.var_77f860ce21581e8, (0, 1, 0), 1, 0);
    drawdoublejumpbox(self.var_77f860ce21581e8, (0, 0, 1), (0, 0, 0), 16, 1, 1);
  }
}

function function_72adb7c7c2d7078b(origin) {
  var_5f1998ce9067c6c0 = getdvarint(@ "hash_a838875af4383ca1");

  foreach(t in getnodearray("<dev string:x75d>", #targetname)) {
    if(var_5f1998ce9067c6c0 != 1) {
      dist = distance(t.origin, origin);

      if(dist > var_5f1998ce9067c6c0) {
        continue;
      }
    }

    switch (t.animscript) {
      case #"hash_6fc6878fd3fd1e7a":
        level.drawnvault++;
        t function_49b33b660df8608d();
        break;
      case #"hash_d14662a6eb371af5":
        t function_49b33b660df8608d();
        level.drawnmantle++;
        break;
      case #"hash_5f054fa72e77b8dd":
        t drawdoublejump();
        break;
      case #"hash_3083e73248cdb399":
        t function_e3ce7d58eecea85e();
        level.var_b4b78483b9478917++;
        break;
    }
  }
}

function function_367cab287db94201() {
  while(true) {
    if(isDefined(level.player) && isDefined(level.getnodefunction)) {
      level.drawnvault = 0;
      level.drawnmantle = 0;
      level.var_b4b78483b9478917 = 0;
      level.var_e8ea27fcedd34c62 = 0;
      level.var_adad9f1b06cb2546 = 0;
      function_72adb7c7c2d7078b(level.player.origin);
      printtoscreen2d(50, 50, "<dev string:x7c0>" + level.var_e8ea27fcedd34c62, (1, 1, 1), 1);
      printtoscreen2d(50, 75, "<dev string:x7df>" + level.var_adad9f1b06cb2546, (1, 1, 1), 1);
      printtoscreen2d(50, 100, "<dev string:x801>" + level.var_b4b78483b9478917, (1, 1, 1), 1);
      printtoscreen2d(50, 125, "<dev string:x811>" + level.drawnvault, (1, 1, 1), 1);
      printtoscreen2d(50, 150, "<dev string:x81b>" + level.drawnmantle, (1, 1, 1), 1);
    }

    wait 0.05;
  }
}

function devlistinventory() {
  dvarvalue = getDvar(@ "hash_3336a486aff69f38", "<dev string:x1b7>");

  if(dvarvalue != "<dev string:x1b7>") {
    list = undefined;
    msg = undefined;
    bold = 0;

    if(dvarvalue == "<dev string:x3fe>") {
      msg = "<dev string:x826>";
      list = level.player getweaponslistall();
    } else if(dvarvalue == "<dev string:x835>") {
      msg = "<dev string:x847>";
      bold = 1;
      list = [level.player getcurrentweapon()];
    } else {
      msg = dvarvalue + "<dev string:x859>";
      list = level.player getweaponslist(dvarvalue);
    }

    level.player devprintweaponlist(list, msg, bold);
    setdevdvar(@ "hash_3336a486aff69f38", "<dev string:x1b7>");
  }
}

function devprintweaponlist(list, msg, printbold) {
  println("<dev string:x867>");
  println("<dev string:x894>" + msg);
  println("<dev string:x867>");

  if(isDefined(list) && list.size > 0) {
    foreach(weapon in list) {
      clipammo = self getweaponammoclip(weapon);
      stockammo = self getweaponammostock(weapon);
      weapmsg = "<dev string:x8a8>" + getcompleteweaponname(weapon) + "<dev string:x8ae>" + clipammo + "<dev string:x8b3>" + stockammo;

      if(printbold) {
        iprintlnbold(weapmsg);
        continue;
      }

      println(weapmsg);
    }
  } else {
    println("<dev string:x8b8>");
  }

  println("<dev string:x867>");
}

function function_994ee67d4cc39b40() {
  if(!isDefined(level.placedweapons)) {
    return;
  }

  if(!getdvarint(@ "hash_90c35ec29eb76f0", 0)) {
    return;
  }

  weapons = utility::array_removeundefined(level.placedweapons);

  foreach(weapon in weapons) {
    line(level.player.origin, weapon.origin, (0, 1, 0), 1, 0);
    weapon thread debug_printweaponname("<dev string:x8c4>", weapon, undefined, 2, (0, 1, 0));
  }
}

function function_8beef9c8b27394ab() {
  if(!getdvarint(@ "hash_9948014b33a0e323", 0)) {
    return;
  }

  ais = getaiarray();
  ais = utility::array_removeundefined(ais);
  ais = utility::array_removedead_or_dying(ais, 1);

  foreach(ai in ais) {
    if(istrue(ai.usescriptedweapon)) {
      ai thread debug_printweaponname("<dev string:x8d0>" + ai.weapon getentnum(), ai.weapon, undefined, 68, (1, 0, 0));
      continue;
    }

    ai thread debug_printweaponname("<dev string:x8db>" + ai.weapon getentnum(), ai.weapon, undefined, 68, (1, 0, 0));
  }
}

function function_ed8007b1db3a4f33() {
  if(!getdvarint(@ "hash_c5fc60671c328201", 0)) {
    return;
  }

  weapons = getweaponarray();

  foreach(weapon in weapons) {
    line(level.player.origin, weapon.origin, (0.25, 0.25, 1), 1, 0);
    weapon thread debug_printweaponname("<dev string:x8e1>", weapon, undefined, 2, (0.25, 0.25, 1));
  }
}

function function_76e110b1a4613b00() {
  if(!getdvarint(@ "hash_965c4785698b6c50", 0)) {
    return;
  }

  weapons = level.player getweaponslistall();
  x_offset = 120;

  foreach(weapon in weapons) {
    level.player thread debug_printweaponname("<dev string:x1b7>", weapon, x_offset, 120, (0, 1, 1));
    x_offset += 300;
  }
}

function debug_printweaponname(prefix, weapon, x_offset, z_offset, color) {
  anchor = undefined;

  if(isDefined(self) && level != self) {
    anchor = self.origin;

    if(isai(self) && isDefined(self.classname)) {
      print3d(self.origin + (0, 0, 0), self.classname, (1, 1, 1), 1, 0.1, 1, 1);
    }
  } else {
    anchor = weapon.origin;
  }

  if(isweapon(weapon)) {
    complete_name = getcompleteweaponname(weapon);
  } else {
    complete_name = weapon.classname;
  }

  toks = strtok(complete_name, "<dev string:x71a>");
  attach_height = z_offset;

  if(isDefined(toks[0])) {
    if(isPlayer(self)) {
      printtoscreen2d(x_offset, attach_height, toks[0], color, 1.5);
    }

    if(toks.size > 1) {
      for(i = toks.size - 1; i > 0; i--) {
        if(isPlayer(self)) {
          attach_height += 20;
          printtoscreen2d(x_offset, attach_height, "<dev string:x8a8>" + toks[i], (1, 1, 1), 1.5);
          continue;
        }

        print3d(anchor + (0, 0, attach_height), "<dev string:x8a8>" + toks[i], (1, 1, 1), 1, 0.1, 1);
        attach_height += 1.4;
      }
    }

    if(isPlayer(self)) {
      return;
    }

    if(!isai(self)) {
      print3d(anchor + (0, 0, attach_height + 0.1), "<dev string:x8ee>" + weapon.origin, (1, 1, 1), 1, 0.125, 1);
      print3d(anchor + (0, 0, attach_height + 1.9), prefix + "<dev string:x8fa>" + weapon getentnum() + "<dev string:x8ae>" + toks[0], color, 1, 0.15, 1);
      return;
    }

    print3d(anchor + (0, 0, attach_height + 0.1), prefix + "<dev string:x8ae>" + toks[0], color, 1, 0.15, 1);
    print3d(anchor + (0, 0, attach_height + 1.9), "<dev string:x900>" + self getentnum(), color, 1, 0.15, 1);
  }
}

function print_timer(label) {
  level notify("<dev string:x90d>");
  level endon("<dev string:x90d>");

  if(isDefined(level.print_timer)) {
    if(isDefined(level.print_timer.labelhud)) {
      level.print_timer.labelhud destroy();
    }

    level.print_timer destroy();
  }

  hud = newhudelem();
  hud.x = 320;
  hud.y = 350;

  if(isDefined(label)) {
    hud.label = label + "<dev string:x8ae>";
  }

  level.print_timer = hud;
  start_time = gettime();

  while(true) {
    wait 0.05;
    time = (gettime() - start_time) * 0.001;
    hud setvalue(time);
  }
}

function display_ai_group_info() {
  if(!isDefined(level._ai_group)) {
    return;
  }

  foreach(struct in level._ai_group) {
    foreach(guy in struct.ai) {
      if(isalive(guy)) {
        if(guy.team == "?\xb1\xc0\x9a") {
          color = (1, 0, 0);
        } else {
          color = (0, 1, 0);
        }

        print3d(guy.origin + (0, 0, 50), groupname, color, 1, 1.2, 1);
      }
    }
  }
}

function show_animnames() {
  ais = getaiarray();

  foreach(guy in ais) {
    if(isDefined(guy.animname)) {
      print3d(guy.origin, guy.animname, (1, 1, 1), 1, 0.75);
    }
  }
}

function function_7d08b29d5c99f310(msg, offset, scale, color) {
  self endon("<dev string:x177>");

  if(!isDefined(color)) {
    color = (1, 1, 1);
  }

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  if(!isDefined(scale)) {
    scale = 0.25;
  }

  steps = 3 * scale * 20;
  alpha = 1;
  alpha_lerp = 1 / steps;

  for(i = 0; i < steps; i++) {
    wait 0.05;
    alpha -= alpha_lerp;
    alpha = min(alpha, 1);
    print3d(self.origin + offset, msg, color, alpha, scale);
    offset += (0, 0, 1);
  }
}

function function_d0d653b1b75bd38a() {
  if(!isDefined(level.var_231a2d9be2a0eff4)) {
    level thread printtoscreen2d_aspectratio();
  }

  teams = ["<dev string:x420>", "<dev string:x921>", "<dev string:x92b>", "<dev string:x934>", "<dev string:x93f>", "<dev string:x948>", "<dev string:x957>"];
  y = 70;
  x = 1000;
  scale = 1.2;

  foreach(team in teams) {
    if(team == "<dev string:x948>") {
      count = getaicount("<dev string:x3fe>", "<dev string:x3fe>", "<dev string:x948>");
      color = function_37a7ecb4e676c7e8(count, 8, 12);
    } else {
      ai_array = getaiarray();

      if(getdvarint(@ "hash_8beca11d7b55550e")) {
        line_colors["<dev string:x921>"] = (0, 1, 0);
        line_colors["<dev string:x420>"] = (1, 0, 0);
        line_colors["<dev string:x960>"] = (0, 1, 1);

        foreach(guy in ai_array) {
          line_color = line_colors[guy.team] ?? line_colors["<dev string:x960>"];
          line(guy.origin, level.player.origin, line_color, 1, 0, 1);
        }
      }

      if(team == "<dev string:x957>") {
        count = ai_array.size;
        color = function_37a7ecb4e676c7e8(count, 15, 25);
      } else if(team == "<dev string:x93f>") {
        alive = utility::array_removedead_or_dying(ai_array);
        count = ai_array.size - alive.size;
        color = function_37a7ecb4e676c7e8(count, 5, 10);
      } else {
        ai_array = getaiarray(team);
        ai_array = utility::array_removedead_or_dying(ai_array);
        count = ai_array.size;
        color = function_37a7ecb4e676c7e8(count, 15, 25);
      }
    }

    final_x = level.var_231a2d9be2a0eff4 * x;
    final_y = level.var_18df60e85c395de9 * y;
    final_scale = scale * level.var_231a2d9be2a0eff4;
    printtoscreen2d(final_x, final_y, count + "<dev string:x8ae>" + team, color, final_scale);
    y += 13;
  }
}

function function_37a7ecb4e676c7e8(count, green_count, yellow_count) {
  if(count <= green_count) {
    color = (0, 1, 0);
  } else if(count <= yellow_count) {
    color = (1, 1, 0);
  } else {
    color = (1, 0, 0);
  }

  return color;
}

function printtoscreen2d_aspectratio() {
  self notify(".R9\x1a\x92WZ\xb1ek\xc83x>lM");
  self endon(".R9\x1a\x92WZ\xb1ek\xc83x>lM");
  level.var_231a2d9be2a0eff4 = 1920;
  level.var_18df60e85c395de9 = 1080;
  was_maximized = 0;
  curr_maximized = 0;
  can_window = 1;

  while(true) {
    curr_maximized = getdvarint(@ "hash_8488fe3c45241d55");
    window_width = getdvarint(@ "vid_width");
    window_height = getdvarint(@ "vid_height");

    if(!curr_maximized && window_width == 0 && window_height == 0) {
      curr_maximized = 1;
      can_window = 0;
    }

    if(curr_maximized) {
      if(!was_maximized) {
        was_maximized = can_window;
        res = getDvar(@ "r_mode");
        toks = strtok(res, "<");

        if(toks.size == 2) {
          window_width = int(toks[0]);
          window_height = int(toks[1]);
        } else {
          window_width = 1920;
          window_height = 1080;
        }
      }
    } else {
      was_maximized = 0;
    }

    vid_width = window_width;
    vid_height = window_height;
    aspectratio = getdvarfloat(@ "cg_aspectratio");
    windowratio = window_width / window_height;

    if(windowratio != aspectratio) {
      if(windowratio < aspectratio) {
        vid_height = int(window_width / aspectratio);
      } else {
        vid_width = int(window_height * aspectratio);
        vid_height = int(vid_width / aspectratio);
      }
    }

    level.var_231a2d9be2a0eff4 = vid_width / 1920;
    level.var_18df60e85c395de9 = vid_height / 1080;
    wait 1;
  }
}

function debug_magic() {
  dvar_name = @ "debug_magic";
  var_d2b772fc6b6606cb = @ "hash_1fc275563e007fbb";
  setdvarifuninitialized(dvar_name, "\xfe");
  setdvarifuninitialized(var_d2b772fc6b6606cb, "\xfe");
  thread function_13c6adf85e5dbeb5();

  foreach(spawner in getspawnerarray()) {
    spawner.spawner_targetname = spawner.targetname;
    spawner.orig_count = spawner.count;
    spawner utility_sp::add_spawn_function(&function_d73e62f1f95b6396);
  }

  var_8b2ba86621356ae = 0;

  for(;;) {
    if(getDvar(dvar_name) != "\xfe") {
      allies = getaiarray("O\x15\x1b\xad\x9ff", "?\xb1\xc0\x9a");

      foreach(ally in allies) {
        str = "";

        if(isDefined(ally.script_noteworthy)) {
          str += "\xa4E\xdb]" + ally.script_noteworthy + "x";
        }

        if(isDefined(ally.spawner_targetname)) {
          str += "n\xe8n\xa3\x04" + ally.spawner_targetname + "x";
        }

        color = (1, 1, 1);

        if(isDefined(ally.script_forcecolor)) {
          color = get_script_palette()[ally.script_forcecolor];
        }

        if(isDefined(ally.magic_bullet_shield)) {
          str += "\xb0\xf3\xbf\xc6X\x84";
        }

        if(isDefined(ally.orig_count) && isDefined(ally.var_8bc44439db1b4a06) && isDefined(ally.spawn_number) && ally.orig_count > 1) {
          str += ally.spawn_number + "R\xd6\xb3s" + ally.orig_count;
        }

        if(isDefined(ally.script_parameters)) {
          str += "A[\xcb\x12\xd0\xfb\xf9\xcd" + ally.script_parameters + "x";
        }

        goalvolume = ally getgoalvolume();

        if(isDefined(goalvolume.targetname)) {
          str += "\x8c\x90f\x89O\x85W\xff\xb4I\x062" + goalvolume.targetname + "x";
        }

        ai_group = ally.script_aigroup;

        if(isDefined(ai_group)) {
          str += "\x10\xdd\xe6\xf9\xd9\xa5\xcf\xaci>" + ai_group + "x";
        }

        if(isDefined(ally.goalradius)) {
          str += "\x92\x8b\xcd0\x7f\x15\x02\x04" + ally.goalradius + "x";
        }

        if(isDefined(ally.fixednode)) {
          str += "\tp\x97\xd9\f\x98\xe8\xee\x80\x920" + ally.fixednode + "x";
        }

        if(istrue(ally.ignoreall)) {
          str += "=\"\xcd\xd77\xeb\x8f=Hb\x03D\x8d\xf3\xc0\x83";
        } else {
          str += "\xfd\x81Y\x9a\x1a\xa8\xf4\b\b\x93\x12\xf1\x91\x9c\x03\x8d\xe6";
        }

        if(istrue(ally.ignoreme)) {
          str += "\xcb\xbf\xb0\xc9\x15\x87\b\xab\x0e\x1aL\xa3;\x1f\xac";
        } else {
          str += "+]\xb4AfY\xf6V0L\x84r\xa3\x83\xe0\xe7";
        }

        if(isDefined(ally.health)) {
          str += "\xbb)D\xf48\xd0\"H" + ally.health + "x";
        }

        if(ally nvg_ai::can_use_flashlight()) {
          flashlight_str = "";

          if(ally.asmflashlight == 1) {
            flashlight_str += "\xfa\xb1\x7f\xd2";
          }

          if(isDefined(ally._blackboard) && istrue(ally._blackboard.bflashlight)) {
            flashlight_str += "U\xf4\x83";
          }

          if(ally.flashlight == 1) {
            flashlight_str += ")\xdd@\xfe";
          }

          if(isDefined(ally.flashlightmodel)) {
            flashlight_str += "\xb6\xf3\x18g\x93\xf9";
          }

          if(isDefined(ally.flashlightfx)) {
            flashlight_str += "5\xc8\x92";
          }

          if(isDefined(ally.var_f58ae199c99693fc)) {
            flashlight_str += "\xe7\xb1C89" + ally.var_f58ae199c99693fc;
          }

          if(flashlight_str != "") {
            str += "\xa5\x867'X(\xac\xff\xc7\xb7t^" + flashlight_str + "x";
          }
        }

        lines = strtok(str, "x");
        line_height = 5;
        offset = 80 + line_height * lines.size;

        foreach(threat_line in lines) {
          print3d(ally.origin + (0, 0, offset), threat_line, color, 1, 0.25);
          offset -= line_height;
        }
      }
    } else {
      wait 1;
    }

    waitframe();
  }
}

function function_d73e62f1f95b6396() {
  if(isDefined(self.spawner.count) && isDefined(self.spawner.orig_count)) {
    self.spawn_number = self.spawner.orig_count - self.spawner.count;
  }
}

function function_13c6adf85e5dbeb5() {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  dvar_name = @ "debug_magic";
  var_d2b772fc6b6606cb = @ "hash_1fc275563e007fbb";
  var_c17a59ea017cbf87 = 25;
  var_4791f1f7fe8464f8 = 50;
  color_off = (1, 0, 0);
  color_on = (0, 1, 0);
  dt = 0.1;
  dt_frames = int(dt * 20);

  while(true) {
    if(getDvar(dvar_name) != "\xfe" || getDvar(var_d2b772fc6b6606cb) != "\xfe") {
      if(level.player.ignoreme) {
        text = "\xf7-X\xaa&\xbb6\x15\xf1\x02b7\xcbM\xef[\xd8\xe8\xb0\xe0\xb4";
        color = color_on;
      } else {
        text = "\x81\xd92\x13\x01\xf0\xb0b\xfe%\xb6K$N\x7f\xe4\t0m\xc8=]";
        color = color_off;
      }

      printtoscreen2d(var_c17a59ea017cbf87, var_4791f1f7fe8464f8, text, color, 2);

      if(level.player.notarget) {
        text = "\xc6\xab\xf4G\xe1\xf3|\xd3\x10\xaa\f\xf1*\f\xe1\r\xd8U\xf3BA";
        color = color_on;
      } else {
        text = "in\x15\xea\x14\xe1\xf4\xday\xba*\r\xae+\xf5\xe5hb\x98\x8d\x91\xb6";
        color = color_off;
      }

      printtoscreen2d(var_c17a59ea017cbf87, var_4791f1f7fe8464f8 + 25, text, color, 2);

      if(level.player isinvulnerable() || isgodmode(level.player)) {
        text = "_'\x1b\xbd\x81\x90\xd4=\x1fkE\xb1\xcc";
        color = color_on;
      } else {
        text = "\xf7\x88\xf26A\xbf5\xab\x87\bK\f\x06\x85";
        color = color_off;
      }

      printtoscreen2d(var_c17a59ea017cbf87, var_4791f1f7fe8464f8 + 50, text, color, 2);

      text = "b1\xc3\xd4\xe2\xc2@%z" + level.player.health;
      color = color_on;

      printtoscreen2d(var_c17a59ea017cbf87, var_4791f1f7fe8464f8 + 75, text, color, 2);
    }

    waitframe();
  }
}