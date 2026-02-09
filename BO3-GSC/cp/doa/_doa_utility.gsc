/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_utility.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\doa\_doa_arena;
#using scripts\cp\doa\_doa_dev;
#using scripts\cp\doa\_doa_pickups;
#using scripts\cp\doa\_doa_player_utility;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\util_shared;
#namespace doa_utility;

function function_4e9a23a9(array) {
  for(i = 0; i < array.size; i++) {
    j = randomint(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
  return array;
}

function isheadshot(sweapon, shitloc, smeansofdeath) {
  return shitloc == "head" || shitloc == "helmet" && smeansofdeath != "MOD_MELEE" && smeansofdeath != "MOD_BAYONET" && smeansofdeath != "MOD_IMPACT";
}

function isexplosivedamage(damage_mod) {
  if(damage_mod == "MOD_GRENADE" || damage_mod == "MOD_GRENADE_SPLASH" || damage_mod == "MOD_PROJECTILE" || damage_mod == "MOD_PROJECTILE_SPLASH" || damage_mod == "MOD_EXPLOSIVE") {
    return true;
  }
  return false;
}

function function_767f35f5(mod) {
  return isDefined(self.damageweapon) && self.damageweapon == "zombietron_tesla_gun" && (mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH");
}

function stringtofloat(string) {
  floatparts = strtok(string, ".");
  if(floatparts.size == 1) {
    return int(floatparts[0]);
  }
  whole = int(floatparts[0]);
  decimal = 0;
  for(i = floatparts[1].size - 1; i >= 0; i--) {
    decimal = (decimal / 10) + (int(floatparts[1][i]) / 10);
  }
  if(whole >= 0) {
    return whole + decimal;
  }
  return whole - decimal;
}

function function_124b9a08() {
  while(true) {
    if(level flag::get("doa_round_active")) {
      return;
    }
    wait(0.05);
  }
}

function function_c8f4d63a() {
  while(level flag::get("doa_bonusroom_active")) {
    wait(0.05);
  }
}

function function_d0e32ad0(state) {
  if(state == 1) {
    while(!level flag::get("doa_screen_faded_out")) {
      wait(0.05);
    }
  } else if(state == 0) {
    while(level flag::get("doa_screen_faded_out")) {
      wait(0.05);
    }
  }
}

function function_44eb090b(time) {
  function_a5821e05(time);
}

function function_390adefe(unfreeze = 1) {
  function_c85960dd(1.2, unfreeze);
}

function function_a5821e05(time = 1) {
  if(isDefined(level.var_a7749866)) {
    debugmsg("");
    return;
  }
  level.var_a7749866 = gettime();
  debugmsg("" + level.var_a7749866);
  level thread function_1d62c13a();
  foreach(player in getplayers()) {
    player freezecontrols(1);
    player thread namespace_831a4a7c::function_4519b17(1);
  }
  level lui::screen_fade_out(time, "black");
  wait(time);
  debugmsg("" + gettime());
  level notify("fade_out_complete");
  level flag::set("doa_screen_faded_out");
}

function function_c85960dd(hold_black_time = 1.2, unfreeze = 1) {
  debugmsg("");
  wait(hold_black_time);
  foreach(player in getplayers()) {
    player notify("hash_ff28e404");
  }
  level lui::screen_fade_in(1.5);
  if(unfreeze) {
    foreach(player in getplayers()) {
      player freezecontrols(0);
      player thread namespace_831a4a7c::function_4519b17(0);
    }
  }
  level notify("fade_in_complete");
  debugmsg("");
  level flag::clear("doa_screen_faded_out");
  level.var_a7749866 = undefined;
  level lui::screen_close_menu();
}

function function_1d62c13a() {
  level endon("fade_in_complete");
  while(isDefined(level.var_a7749866)) {
    if(level flag::get("doa_game_is_over")) {
      return;
    }
    if(level flag::get("doa_round_spawning")) {
      break;
    }
    wait(0.05);
  }
  debugmsg("");
  level thread function_c85960dd();
}

function function_d0c69425(var_30d383f5) {
  level endon("fade_in_complete");
  while(!(isDefined(level.var_de693c3) && level.var_de693c3)) {
    wait(0.05);
  }
  timeout = gettime() + (var_30d383f5 * 1000);
  while(isDefined(level.var_a7749866) && gettime() < timeout) {
    wait(0.05);
  }
  debugmsg("");
  level thread function_c85960dd();
}

function getclosestto(origin, &entarray, maxdist = 2048) {
  if(!isDefined(entarray)) {
    return;
  }
  if(entarray.size == 0) {
    return;
  }
  if(entarray.size == 1) {
    return entarray[0];
  }
  return arraygetclosest(origin, entarray, maxdist);
}

function getarrayitemswithin(origin, &entarray, minsq) {
  items = [];
  if(isDefined(entarray) && entarray.size) {
    for(i = 0; i < entarray.size; i++) {
      if(!isDefined(entarray[i])) {
        continue;
      }
      distsq = distancesquared(entarray[i].origin, origin);
      if(distsq < minsq) {
        items[items.size] = entarray[i];
      }
    }
  }
  return items;
}

function getclosesttome(&entarray) {
  return getclosestto(self.origin, entarray);
}

function function_999bba85(origin, time) {
  self moveto(origin, time, 0, 0);
  wait(time);
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }
  if(isDefined(self)) {
    self delete();
  }
}

function notify_timeout(note, timeout) {
  self endon("death");
  wait(timeout);
  self notify(note);
}

function clamp(val, min, max) {
  if(isDefined(min)) {
    if(val < min) {
      val = min;
    }
  }
  if(isDefined(max)) {
    if(val > max) {
      val = max;
    }
  }
  return val;
}

function function_75e76155(other, note) {
  if(!isDefined(other)) {
    return;
  }
  killnote = function_2ccf4b82("DeleteNote");
  self thread function_f5db70f1(other, killnote);
  if(isPlayer(other)) {
    if(note == "disconnect") {
      other util::waittill_any(note, killnote);
    } else {
      other util::waittill_any(note, "disconnect", killnote);
    }
  } else {
    other util::waittill_any(note, killnote);
  }
  if(isDefined(self)) {
    self delete();
  }
}

function function_f5db70f1(other, note) {
  self endon(note);
  other endon("death");
  self waittill("death");
  if(isDefined(other)) {
    other notify(note);
  }
}

function function_24245456(other, note) {
  if(!isDefined(other)) {
    return;
  }
  self endon("death");
  killnote = function_2ccf4b82("killNote");
  self thread function_f5db70f1(other, killnote);
  if(isPlayer(other)) {
    if(note == "disconnect") {
      other util::waittill_any(note, killnote);
    } else {
      other util::waittill_any(note, "disconnect", killnote);
    }
  } else {
    other util::waittill_any(note, killnote);
  }
  if(isDefined(self)) {
    self notify(killnote);
    self.aioverridedamage = undefined;
    self.takedamage = 1;
    self.allowdeath = 1;
    self thread function_ba30b321(0);
  }
}

function notifymeinnsec(note, sec, endnote, param1, param2) {
  self endon(endnote);
  self endon("disconnect");
  wait(sec);
  self notify(note, param1, param2);
}

function function_783519c1(note, var_8b804bd9 = 0) {
  self endon("death");
  self endon("abort" + note);
  if(!var_8b804bd9) {
    self waittill(note);
  } else {
    level waittill(note);
  }
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }
  self delete();
}

function function_1bd67aef(time) {
  self endon("death");
  wait(time);
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }
  self delete();
}

function function_981c685d(var_627e7613) {
  self endon("death");
  killnote = function_2ccf4b82("deathNote");
  self thread function_f5db70f1(var_627e7613, killnote);
  if(isPlayer(var_627e7613)) {
    var_627e7613 util::waittill_any("death", "disconnect", killnote);
  } else {
    var_627e7613 util::waittill_any("death", killnote);
  }
  if(isDefined(self.anchor)) {
    self.anchor delete();
  }
  self delete();
}

function function_a625b5d3(player) {
  assert(isPlayer(player), "");
  self endon("death");
  player waittill("disconnect");
  self delete();
}

function function_c157030a() {
  while(function_b99d78c7() > 0) {
    wait(1);
  }
}

function function_1ced251e(all = 0) {
  while(function_b99d78c7() > 0) {
    killallenemy(all);
    wait(1);
  }
}

function function_2f0d697f(spawner) {
  count = 0;
  ai = function_fb2ad2fb();
  foreach(guy in ai) {
    if(isDefined(guy.spawner) && guy.spawner == spawner) {
      count++;
    }
  }
  return count;
}

function function_b99d78c7() {
  prospects = arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
  return prospects.size;
}

function function_fb2ad2fb() {
  return arraycombine(getaiteamarray("axis"), getaiteamarray("team3"), 0, 0);
}

function function_fe180f6f(count = 1) {
  var_54a85fb0 = 4;
  var_76cfbf10 = 0;
  enemies = function_fb2ad2fb();
  foreach(guy in enemies) {
    if(count <= 0) {
      return;
    }
    if(!isDefined(guy)) {
      continue;
    }
    if(isDefined(guy.boss) && guy.boss) {
      continue;
    }
    if(!(isDefined(guy.spawner.var_8d1af144) && guy.spawner.var_8d1af144)) {
      continue;
    }
    guy thread function_ba30b321(0);
    var_76cfbf10++;
    count--;
    if(var_76cfbf10 == var_54a85fb0) {
      util::wait_network_frame();
      var_76cfbf10 = 0;
    }
  }
}

function killallenemy(all = 0) {
  var_54a85fb0 = 4;
  var_76cfbf10 = 0;
  enemies = function_fb2ad2fb();
  foreach(guy in enemies) {
    if(!isDefined(guy)) {
      continue;
    }
    if(!all && (isDefined(guy.boss) && guy.boss)) {
      continue;
    }
    guy.aioverridedamage = undefined;
    guy.takedamage = 1;
    guy.allowdeath = 1;
    guy thread function_ba30b321(0);
    var_76cfbf10++;
    if(var_76cfbf10 == var_54a85fb0) {
      util::wait_network_frame();
      var_76cfbf10 = 0;
    }
  }
}

function function_e3c30240(dir, var_e3e1b987 = 100, var_1f32eac0 = 0.1, attacker) {
  if(!isDefined(self)) {
    return;
  }
  self thread function_ba30b321(var_1f32eac0, attacker);
  if(isDefined(self.no_ragdoll) && self.no_ragdoll) {
    return;
  }
  self endon("death");
  self setplayercollision(0);
  self startragdoll();
  if(isDefined(dir)) {
    dir = vectornormalize(dir);
    self launchragdoll(dir * var_e3e1b987);
  }
}

function function_ba30b321(time, attacker, mod = "MOD_HIT_BY_OBJECT") {
  assert(!isPlayer(self));
  if(isDefined(self.boss) && self.boss) {
    return;
  }
  self endon("death");
  if(time > 0) {
    wait(time);
  }
  self.takedamage = 1;
  self.allowdeath = 1;
  if(isDefined(attacker)) {
    self dodamage(self.health + 187, self.origin, attacker, attacker, "none", mod, 0, getweapon("none"));
  } else {
    self dodamage(self.health + 187, self.origin);
  }
}

function function_308fa126(num = 5) {
  locs = [];
  players = getplayers();
  if(isDefined(level.doa.arenas[level.doa.current_arena].var_1d2ed40)) {
    foreach(spot in level.doa.arenas[level.doa.current_arena].var_1d2ed40) {
      locs[locs.size] = spot.origin;
      num--;
      if(num == 0) {
        return locs;
      }
    }
  }
  if(isDefined(level.doa.var_3361a074)) {
    foreach(spot in level.doa.var_3361a074) {
      locs[locs.size] = spot.origin;
      num--;
      if(num == 0) {
        return locs;
      }
    }
  }
  foreach(player in players) {
    if(isDefined(player.vehicle)) {
      continue;
    }
    locs[locs.size] = player.origin;
    num--;
    if(num == 0) {
      return locs;
    }
  }
  return locs;
}

function function_8fc4387a(num = 5) {
  locs = [];
  if(isDefined(level.doa.arenas[level.doa.current_arena].var_1d2ed40)) {
    foreach(spot in level.doa.arenas[level.doa.current_arena].var_1d2ed40) {
      locs[locs.size] = spot;
      num--;
      if(num == 0) {
        return locs;
      }
    }
  }
  if(isDefined(level.doa.var_3361a074)) {
    foreach(spot in level.doa.var_3361a074) {
      locs[locs.size] = spot;
      num--;
      if(num == 0) {
        return locs;
      }
    }
  }
  return locs;
}

function function_812b4715(side) {
  switch (side) {
    case "top": {
      return "bottom";
      break;
    }
    case "bottom": {
      return "top";
      break;
    }
    case "left": {
      return "right";
      break;
    }
    case "right": {
      return "left";
      break;
    }
  }
  assert(0);
}

function function_5b4fbaef() {
  if(getdvarint("", 0)) {
    return "";
  }
  switch (randomint(4)) {
    case 0: {
      return "bottom";
      break;
    }
    case 1: {
      return "top";
      break;
    }
    case 2: {
      return "right";
      break;
    }
    case 3: {
      return "left";
      break;
    }
  }
}

function getyawtoenemy() {
  pos = undefined;
  if(isDefined(self.enemy)) {
    pos = self.enemy.origin;
  } else {
    forward = anglesToForward(self.angles);
    forward = vectorscale(forward, 150);
    pos = self.origin + forward;
  }
  yaw = self.angles[1] - getyaw(pos);
  yaw = angleclamp180(yaw);
  return yaw;
}

function getyaw(org) {
  angles = vectortoangles(org - self.origin);
  return angles[1];
}

function function_cf5857a3(ent, note) {
  if(note != "death") {
    ent endon("death");
  }
  ent waittill(note);
  ent unlink();
}

function function_a98c85b2(location, timesec = 1) {
  self notify("hash_a98c85b2");
  self endon("hash_a98c85b2");
  if(timesec <= 0) {
    timesec = 1;
  }
  increment = (self.origin - location) / (timesec * 20);
  var_afc5c189 = gettime() + (timesec * 1000);
  while(gettime() < var_afc5c189) {
    self.origin = self.origin - increment;
    wait(0.05);
  }
  self notify("movedone");
}

function function_89a258a7() {
  self endon("death");
  self endon("hash_3d81b494");
  while(true) {
    wait(0.5);
    if(isDefined(self.var_111c7bbb)) {
      distsq = distancesquared(self.var_111c7bbb, self.origin);
      if(distsq < (32 * 32)) {
        continue;
      }
    }
    var_111c7bbb = getclosestpointonnavmesh(self.origin, 64, 16);
    if(isDefined(var_111c7bbb)) {
      self.var_111c7bbb = var_111c7bbb;
    }
  }
}

function function_5fd5c3ea(entity) {
  entity thread function_89a258a7();
  level.doa.var_f953d785[level.doa.var_f953d785.size] = entity;
}

function function_3d81b494(entity) {
  arrayremovevalue(level.doa.var_f953d785, entity);
}

function getclosestpoi(origin, radiussq) {
  return getclosestto(origin, level.doa.var_f953d785, radiussq);
}

function clearallcorpses(num = 99) {
  corpse_array = getcorpsearray();
  if(num == 99) {
    total = corpse_array.size;
  } else {
    total = num;
  }
  for(i = 0; i < total; i++) {
    if(isDefined(corpse_array[i])) {
      corpse_array[i] delete();
    }
  }
}

function function_5f54cafa(waittime) {
  level notify("hash_5f54cafa");
  level endon("hash_5f54cafa");
  while(true) {
    clearallcorpses();
    wait(waittime);
  }
}

function function_2ccf4b82(note) {
  if(!isDefined(level.doa.var_24cbf490)) {
    level.doa.var_24cbf490 = 0;
  }
  level.doa.var_24cbf490++;
  return note + level.doa.var_24cbf490;
}

function function_c5f3ece8(text, param, holdtime = 5, color = vectorscale((1, 1, 0), 0.9), note = "title1Fade") {
  self notify("hash_c5f3ece8");
  self endon("hash_c5f3ece8");
  level.doa.title1.color = color;
  level.doa.title1.alpha = 0;
  if(isDefined(param)) {
    level.doa.title1 settext(text, param);
  } else {
    level.doa.title1 settext(text);
  }
  level.doa.title1 fadeovertime(1);
  level.doa.title1.alpha = 1;
  if(holdtime == -1) {
    level waittill(note);
  } else {
    level util::waittill_any_timeout(holdtime, note);
  }
  level.doa.title1 fadeovertime(1);
  level.doa.title1.alpha = 0;
  level notify("hash_b96c96ac");
}

function function_37fb5c23(text, param, holdtime = 5, color = (1, 1, 0), note = "title2Fade") {
  self notify("hash_37fb5c23");
  self endon("hash_37fb5c23");
  level.doa.title2.color = color;
  level.doa.title2.alpha = 0;
  if(isDefined(param)) {
    level.doa.title2 settext(text, param);
  } else {
    level.doa.title2 settext(text);
  }
  level.doa.title2 fadeovertime(1);
  level.doa.title2.alpha = 1;
  level util::waittill_any_timeout(holdtime, note);
  level.doa.title2 fadeovertime(1);
  level.doa.title2.alpha = 0;
  level notify("hash_97276c43");
}

function function_13fbad22() {
  if(isDefined(world.var_c642e28c)) {
    for(i = 0; i < world.var_c642e28c; i++) {
      function_11f3f381(i, 1);
      util::wait_network_frame();
    }
  }
  world.var_c642e28c = 0;
}

function function_c9fb43e9(text, position) {
  index = world.var_c642e28c;
  world.var_c642e28c++;
  luinotifyevent(&"doa_bubble", 6, -1, index, text, int(position[0]), int(position[1]), int(position[2]));
  return index;
}

function function_11f3f381(index, fadetime) {
  luinotifyevent(&"doa_bubble", 2, (isDefined(fadetime) ? fadetime : 0), index);
}

function function_dbcf48a0(delay = 0, width = 40, height = 40) {
  if(delay) {
    wait(delay);
  }
  if(!isDefined(self)) {
    return;
  }
  trigger = spawn("trigger_radius", self.origin, 1, width, height);
  trigger.targetname = "touchmeTrigger";
  trigger enablelinkto();
  trigger linkto(self);
  trigger thread function_981c685d(self);
  trigger endon("death");
  while(isDefined(self)) {
    trigger waittill("trigger", guy);
    if(isDefined(guy)) {
      if(isDefined(guy.untouchable) && guy.untouchable) {
        continue;
      }
      if(isDefined(guy.boss) && guy.boss) {
        continue;
      }
      if(isDefined(guy.doa) && isDefined(guy.doa.vehicle)) {
        continue;
      }
      guy dodamage(guy.health + 1, guy.origin);
    }
  }
  if(isDefined(trigger)) {
    trigger delete();
  }
}

function function_1ded48e6(time, var_f88fd757) {
  if(!isDefined(self)) {
    return 0;
  }
  if(isDefined(var_f88fd757)) {
    return time * var_f88fd757;
  }
  if(self.doa.fate == 2) {
    time = time * level.doa.rules.var_f2d5f54d;
  } else if(self.doa.fate == 11) {
    time = time * level.doa.rules.var_b3d39edc;
  }
  return time;
}

function function_a4d1f25e(note, time) {
  self endon("death");
  wait(time);
  self notify(note);
}

function function_1c0abd70(var_8e25979b, var_5e50267c, ignore) {
  start = var_8e25979b + (0, 0, var_5e50267c);
  end = var_8e25979b - vectorscale((0, 0, 1), 1024);
  a_trace = groundtrace(start, end, 0, ignore, 1);
  return a_trace["position"];
}

function addoffsetontopoint(point, angles, offset) {
  offset_world = rotatepoint(offset, angles);
  return point + offset_world;
}

function getyawtospot(spot) {
  yaw = self.angles[1] - getyaw(spot);
  yaw = angleclamp180(yaw);
  return yaw;
}

function function_fa8a86e8(ent, target) {
  v_diff = target.origin - ent.origin;
  x = v_diff[0];
  y = v_diff[1];
  if(x != 0) {
    n_slope = y / x;
    yaw = atan(n_slope);
    if(x < 0) {
      yaw = yaw + 180;
    }
  }
  return yaw;
}

function debug_circle(origin, radius, seconds, color) {
  if(!isDefined(seconds)) {
    seconds = 1;
  }
  if(!isDefined(color)) {
    color = (1, 0, 0);
  }
  frames = int(20 * seconds);
  circle(origin, radius, color, 0, 1, frames);
}

function debug_line(p1, p2, seconds, color) {
  line(p1, p2, color, 1, 0, int(seconds * 20));
}

function function_a0e51d80(point, timesec, size, color) {
  self endon("hash_b67acf30");
  end = gettime() + (timesec * 1000);
  halfwidth = int(size / 2);
  l1 = point + (halfwidth * -1, 0, 0);
  l2 = point + (halfwidth, 0, 0);
  var_5e2b69e1 = point + (0, halfwidth * -1, 0);
  var_842de44a = point + (0, halfwidth, 0);
  h1 = point + (0, 0, halfwidth * -1);
  h2 = point + (0, 0, halfwidth);
  while(end > gettime()) {
    line(l1, l2, color, 1, 0, 1);
    line(var_5e2b69e1, var_842de44a, color, 1, 0, 1);
    line(h1, h2, color, 1, 0, 1);
    wait(0.05);
  }
}

function debugorigin(timesec, size, color) {
  self endon("hash_c32e3b78");
  end = gettime() + (timesec * 1000);
  halfwidth = int(size / 2);
  while(end > gettime()) {
    point = self.origin;
    l1 = point + (halfwidth * -1, 0, 0);
    l2 = point + (halfwidth, 0, 0);
    var_5e2b69e1 = point + (0, halfwidth * -1, 0);
    var_842de44a = point + (0, halfwidth, 0);
    h1 = point + (0, 0, halfwidth * -1);
    h2 = point + (0, 0, halfwidth);
    line(l1, l2, color, 1, 0, 1);
    line(var_5e2b69e1, var_842de44a, color, 1, 0, 1);
    line(h1, h2, color, 1, 0, 1);
    wait(0.05);
  }
}

function debugmsg(txt) {
  println("" + txt);
}

function set_lighting_state(state) {
  level.lighting_state = state;
  setlightingstate(state);
}

function function_5233dbc0() {
  foreach(player in getplayers()) {
    if(isDefined(player.doa) && isDefined(player.doa.vehicle)) {
      return true;
    }
  }
  return false;
}

function function_5bca1086() {
  if(!isDefined(self)) {
    return namespace_3ca3c537::function_61d60e0b();
  }
  if(isDefined(level.doa.arenas[level.doa.current_arena].var_1d2ed40) && level.doa.arenas[level.doa.current_arena].var_1d2ed40.size) {
    spot = getclosestto(self.origin, level.doa.arenas[level.doa.current_arena].var_1d2ed40);
    if(!isDefined(spot)) {
      spot = self.origin;
    } else {
      spot = spot.origin;
    }
  } else {
    spot = self.origin;
  }
  return spot;
}

function function_14a10231(origin) {
  if(isDefined(level.doa.arenas[level.doa.current_arena].var_1d2ed40) && level.doa.arenas[level.doa.current_arena].var_1d2ed40.size) {
    spot = level.doa.arenas[level.doa.current_arena].var_1d2ed40[randomint(level.doa.arenas[level.doa.current_arena].var_1d2ed40.size)].origin;
  } else {
    spot = origin;
  }
  return spot;
}

function function_ada6d90() {
  if(isDefined(level.doa.arenas[level.doa.current_arena].var_1d2ed40) && level.doa.arenas[level.doa.current_arena].var_1d2ed40.size) {
    return level.doa.arenas[level.doa.current_arena].var_1d2ed40[randomint(level.doa.arenas[level.doa.current_arena].var_1d2ed40.size)];
  }
}