/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\sp\utility.gsc
*****************************************/

#using script_4dac3680f88a01c3;
#using scripts\anim\battlechatter;
#using scripts\anim\battlechatter_ai;
#using scripts\anim\notetracks_sp;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\createfx;
#using scripts\common\exploder;
#using scripts\common\linked_list;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_paths;
#using scripts\engine\math;
#using scripts\engine\sp\utility_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\audio;
#using scripts\sp\autosave;
#using scripts\sp\colors;
#using scripts\sp\endmission;
#using scripts\sp\hud_util;
#using scripts\sp\interaction_manager;
#using scripts\sp\nvg\nvg_player;
#using scripts\sp\outline;
#using scripts\sp\player;
#using scripts\sp\player\gestures;
#using scripts\sp\player\playerchatter;
#using scripts\sp\player_death;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\trigger;
#using scripts\sp\utility;
#using scripts\sp\vehicle;
#namespace utility_sp;

function private autoexec __init__system__() {
  system::register(#"utility_sp", undefined, &pre_main, undefined);
}

function private pre_main() {
  thread function_19747959f88dbd35();
}

function function_99ee256322f70451(anime) {
  assert(isDefined(level.scr_anim), "<dev string:x24>");
  animnames = [];

  foreach(array in level.scr_anim) {
    foreach(xanim in array) {
      if(scene == anime) {
        animnames[animnames.size] = animname;
      }
    }
  }

  return animnames;
}

function get_tag_list(model) {
  array = [];
  numparts = getnumparts(model);

  for(i = 0; i < numparts; i++) {
    array[array.size] = getpartname(model, i);
  }

  return array;
}

function get_all_closest_living(org, ai_array, max_dist, bincludelongdeath) {
  temp_array = [];

  if(ai_array.size < 1) {
    return temp_array;
  }

  if(!isDefined(bincludelongdeath)) {
    bincludelongdeath = 0;
  }

  max_dist = squared(max_dist);

  foreach(guy in ai_array) {
    if(!isalive(guy) || !isDefined(guy) || !bincludelongdeath && guy utility::doinglongdeath()) {
      continue;
    }

    if(distancesquared(guy.origin, org) <= max_dist) {
      temp_array[temp_array.size] = guy;
    }
  }

  return temp_array;
}

function set_hudoutline(stype, depth_enable, fill_enable) {
  num = undefined;
  assert(isDefined(stype) && isstring(stype), "<dev string:x4d>");
  stype = tolower(stype);
  array["\x1df@>\x87t\x93\x05"] = "\xff\xed\xc0\xc6\x9f\x15$\xb2%A\xd7G\xb0\x90I]\xb7\xf6\x06\xab";
  array["\xba8C\xef\xc2"] = "t])#\x0e\x89)\xe2P\xfe\b\xab,\xb9\xd4bK\xe2\x05";
  array["8\xc5\xe5\x91E\x1b\xf9\xb2e"] = "\xf6\xb2EQ\"\xa9\xc8\xd6t\xd6\xa3\x94\xe8\x95lF>\xdd4\xc4\x14\x94";
  array["\xba\xa5\x1f\xc9m\x80i"] = ">\xcdzW\r-\xcd\x1fL\xa0>:\xd2C\x85t\x17\xf03'#";
  assert(isDefined(array[stype]), "<dev string:xa5>");
  num = array[stype];
  hudoutline_enable_new(array[stype]);
}

function convert_to_time_string(timer, var_65ee1454beea6fd4) {
  string = "";

  if(timer < 0) {
    string += "\xcf";
  }

  timer = math::round_float(timer, 1, 0);
  var_25ac3a97c8065ce7 = timer * 100;
  var_25ac3a97c8065ce7 = int(var_25ac3a97c8065ce7);
  var_25ac3a97c8065ce7 = abs(var_25ac3a97c8065ce7);
  minutes = var_25ac3a97c8065ce7 / 6000;
  minutes = int(minutes);
  string += minutes;
  seconds = var_25ac3a97c8065ce7 / 100;
  seconds = int(seconds);
  seconds -= minutes * 60;

  if(seconds < 10) {
    string += "?\xd6" + seconds;
  } else {
    string += "\xb0" + seconds;
  }

  if(isDefined(var_65ee1454beea6fd4) && var_65ee1454beea6fd4) {
    tenths = var_25ac3a97c8065ce7;
    tenths -= minutes * 6000;
    tenths -= seconds * 100;
    tenths = int(tenths / 10);
    string += "\x93" + tenths;
  }

  return string;
}

function sun_light_fade(startsunlight, endsunlight, ftime) {
  ftime = int(ftime * 20);
  increment = [];

  for(i = 0; i < 4; i++) {
    increment[i] = (startsunlight[i] - endsunlight[i]) / ftime;
  }

  newsunlight = [];

  for(i = 0; i < ftime; i++) {
    wait 0.05;

    for(j = 0; j < 4; j++) {
      newsunlight[j] = startsunlight[j] - increment[j] * i;
    }

    setsuncolorandintensity(newsunlight[0], newsunlight[1], newsunlight[2], newsunlight[3]);
  }

  setsuncolorandintensity(endsunlight[0], endsunlight[1], endsunlight[2], endsunlight[3]);
}

function get_closest_to_player_view(array, player, use_eye, min_dot) {
  if(!array.size) {
    return;
  }

  if(!isDefined(player)) {
    player = level.player;
  }

  if(!isDefined(min_dot)) {
    min_dot = -1;
  }

  player_origin = player.origin;

  if(isDefined(use_eye) && use_eye) {
    player_origin = player getEye();
  }

  ent = undefined;
  player_angles = player getplayerangles();
  player_forward = anglesToForward(player_angles);
  dot = -1;

  foreach(array_item in array) {
    angles = vectortoangles(array_item.origin - player_origin);
    forward = anglesToForward(angles);
    newdot = vectordot(player_forward, forward);

    if(newdot < dot) {
      continue;
    }

    if(newdot < min_dot) {
      continue;
    }

    dot = newdot;
    ent = array_item;
  }

  return ent;
}

function get_closest_index_to_player_view(array, player, use_eye) {
  if(!array.size) {
    return;
  }

  if(!isDefined(player)) {
    player = level.player;
  }

  player_origin = player.origin;

  if(isDefined(use_eye) && use_eye) {
    player_origin = player getEye();
  }

  index = undefined;
  player_angles = player getplayerangles();
  player_forward = anglesToForward(player_angles);
  dot = -1;

  for(i = 0; i < array.size; i++) {
    angles = vectortoangles(array[i].origin - player_origin);
    forward = anglesToForward(angles);
    newdot = vectordot(player_forward, forward);

    if(newdot < dot) {
      continue;
    }

    dot = newdot;
    index = i;
  }

  return index;
}

function flag_trigger_init(message, trigger, continuous) {
  utility::flag_init(message);

  if(!isDefined(continuous)) {
    continuous = 0;
  }

  assert(issubstr(trigger.classname, "<dev string:x107>"));
  trigger thread utility_code::_flag_wait_trigger(message, continuous);
  return trigger;
}

function flag_triggers_init(message, triggers, all) {
  utility::flag_init(message);

  if(!isDefined(all)) {
    all = 0;
  }

  for(index = 0; index < triggers.size; index++) {
    assert(issubstr(triggers[index].classname, "<dev string:x107>"));
    triggers[index] thread utility_code::_flag_wait_trigger(message, 0);
  }

  return triggers;
}

function flag_clear_delayed(message, delay) {
  wait delay;
  utility::flag_clear(message);
}

function flag_clear_delayed_endonset(message, delay) {
  level endon(message);
  wait delay;
  utility::flag_clear(message);
}

function level_end_save() {
  if(level.missionfailed) {
    return;
  }

  if(is_trials_level()) {
    return 0;
  }

  if(utility::flag("\xd9\xcb\xad\xc9R\xe39#r\xd4E")) {
    return;
  }

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(!isalive(player)) {
      return;
    }
  }

  utility::flag_set("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
  imagename = "\xfc\x9a\b\t\xac\xda>\xaeO\x95\xe2\x1b0$s\xfcO\b\\\xb1\x80\xec\xdcT\xfd\xdd\fO\xad\xe80\x1f\xae" + level.script + "8\xdb\x90";
  savegame("d.\x177\xc5\xcc(\xac", &"autosave/autosave", imagename, 1);
  utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
}

function add_extra_autosave_check(name, func, msg) {
  level.autosave.extra_autosave_checks[name] = [];
  level.autosave.extra_autosave_checks[name]["\xccu\xcd\xc6"] = func;
  level.autosave.extra_autosave_checks[name]["\xd5\xc0\xe9"] = msg;
}

function remove_extra_autosave_check(name) {
  level.autosave.extra_autosave_checks[name] = undefined;
}

function autosave_silent() {
  thread autosave_by_name_thread("\x1fEwG\x1fu\xd6\x01~RJi\x80\x83\xfe", undefined, undefined, 1);
}

function autosave_stealth(name) {
  thread autosave_by_name_thread(name, 8, 1);
}

function autosave_stealth_silent() {
  thread autosave_by_name_thread("\"7\x88\xde\xd1\xb8x\x85LD\x15a\xac\xb8<l", 8, 1, 1);
}

function autosave_tactical() {
  utility_code::autosave_tactical_setup();
  thread utility_code::autosave_tactical_proc();
}

function autosave_by_name(name) {
  thread autosave_by_name_thread(name);
}

function autosave_by_name_silent(name) {
  thread autosave_by_name_thread(name, undefined, undefined, 1);
}

function autosave_by_name_thread(name, timeout, var_318d7c85ec606d03, suppress_hint, tryonce) {
  if(!isDefined(name)) {
    name = "\xed\x1d\va\x1e\xf6\xe5\x88\x8a";
  }

  imagename = "\xd4\x7fL\n\xbd\xd6\xd0\x85\fU\b?Byy\x9aRu\xc9_<\x05\xde\x85\x8fL\x94>g" + level.script;
  result = level autosave::tryautosave(name, "\x92|l\xde\x81t\xc34", imagename, timeout, var_318d7c85ec606d03, suppress_hint, tryonce);
}

function autosave_or_timeout(name, timeout) {
  thread autosave_by_name_thread(name, timeout);
}

function autosave_try_once(name, suppress_hint) {
  thread autosave_by_name_thread(name, undefined, undefined, suppress_hint, 1);
}

function autosave_or_timeout_silent(name, timeout) {
  thread autosave_by_name_thread(name, timeout, undefined, 1);
}

function debug_message(message, origin, duration, entity) {
  if(!isDefined(duration)) {
    duration = 5;
  }

  if(isDefined(entity)) {
    entity endon("\x1e\xfd\xd1\xa2\a");
    origin = entity.origin;
  }

  for(time = 0; time < duration * 20; time++) {
    if(!isDefined(entity)) {
      print3d(origin + (0, 0, 45), message, (0.48, 9.4, 0.76), 0.85);
    } else {
      print3d(entity.origin, message, (0.48, 9.4, 0.76), 0.85);
    }

    wait 0.05;
  }
}

function debug_message_clear(message, origin, duration, extraendon) {
  if(isDefined(extraendon)) {
    level notify(message + extraendon);
    level endon(message + extraendon);
  } else {
    level notify(message);
    level endon(message);
  }

  if(!isDefined(duration)) {
    duration = 5;
  }

  for(time = 0; time < duration * 20; time++) {
    print3d(origin + (0, 0, 45), message, (0.48, 9.4, 0.76), 0.85);

    wait 0.05;
  }
}

function closerfunc(dist1, dist2) {
  return dist1 >= dist2;
}

function getclosestfx(org, fxarray, dist) {
  return utility_code::comparesizesfx(org, fxarray, dist, &closerfunc);
}

function get_farthest_ent(org, array) {
  if(array.size < 1) {
    return;
  }

  dist = distance(array[0] getorigin(), org);
  ent = array[0];

  for(i = 0; i < array.size; i++) {
    newdist = distance(array[i] getorigin(), org);

    if(newdist < dist) {
      continue;
    }

    dist = newdist;
    ent = array[i];
  }

  return ent;
}

function get_within_range(org, array, dist) {
  guys = [];

  for(i = 0; i < array.size; i++) {
    if(distance(array[i].origin, org) <= dist) {
      guys[guys.size] = array[i];
    }
  }

  return guys;
}

function get_outside_range(org, array, dist) {
  guys = [];

  for(i = 0; i < array.size; i++) {
    if(distance(array[i].origin, org) > dist) {
      guys[guys.size] = array[i];
    }
  }

  return guys;
}

function function_b2b8b8abf81b417e(start, end, array, dot) {
  if(!array.size) {
    return;
  }

  ents = [];
  angles = vectortoangles(end - start);
  dotforward = anglesToForward(angles);

  foreach(member in array) {
    angles = vectortoangles(member.origin - start);
    forward = anglesToForward(angles);
    newdot = vectordot(dotforward, forward);

    if(newdot < dot) {
      continue;
    }

    ents[ents.size] = member;
  }

  return ents;
}

function get_closest_living(org, array, dist) {
  if(!isDefined(dist)) {
    dist = 9999999;
  }

  if(array.size < 1) {
    return;
  }

  ent = undefined;

  for(i = 0; i < array.size; i++) {
    if(!isalive(array[i])) {
      continue;
    }

    newdist = distance(array[i].origin, org);

    if(newdist >= dist) {
      continue;
    }

    dist = newdist;
    ent = array[i];
  }

  return ent;
}

function get_highest_dot(start, end, array) {
  if(!array.size) {
    return;
  }

  ent = undefined;
  angles = vectortoangles(end - start);
  dotforward = anglesToForward(angles);
  dot = -1;

  foreach(member in array) {
    angles = vectortoangles(member.origin - start);
    forward = anglesToForward(angles);
    newdot = vectordot(dotforward, forward);

    if(newdot < dot) {
      continue;
    }

    dot = newdot;
    ent = member;
  }

  return ent;
}

function get_closest_index(org, array, dist) {
  if(!isDefined(dist)) {
    dist = 9999999;
  }

  if(array.size < 1) {
    return;
  }

  index = undefined;

  foreach(ent in array) {
    newdist = distance(ent.origin, org);

    if(newdist >= dist) {
      continue;
    }

    dist = newdist;
    index = i;
  }

  return index;
}

function get_closest_exclude(org, ents, excluders) {
  if(!isarray(ents) || ents.size == 0) {
    return undefined;
  }

  checkents = utility::array_remove_array(ents, excluders);

  if(checkents.size == 0) {
    return undefined;
  } else if(checkents.size > 1) {
    checkents = sortbydistance(checkents, org);
  }

  return checkents[0];
}

function get_closest_ai(org, team, excluders) {
  if(isDefined(team)) {
    ents = getaiarray(team);
  } else {
    ents = getaiarray();
  }

  if(ents.size == 0) {
    return undefined;
  }

  if(isDefined(excluders)) {
    assert(excluders.size > 0);
    ents = utility::array_remove_array(ents, excluders);
  }

  return utility::getclosest(org, ents);
}

function get_closest_ai_exclude(org, team, excluders) {
  if(isDefined(team)) {
    ents = getaiarray(team);
  } else {
    ents = getaiarray();
  }

  if(ents.size == 0) {
    return undefined;
  }

  return get_closest_exclude(org, ents, excluders);
}

function get_progress(start, end, org, dist) {
  if(!isDefined(dist)) {
    dist = distance(start, end);
  }

  dist = max(0.01, dist);
  normal = vectorNormalize(end - start);
  vec = org - start;
  progress = vectordot(vec, normal);
  progress /= dist;
  progress = clamp(progress, 0, 1);
  return progress;
}

function enable_blood_pool() {
  self.skipbloodpool = undefined;
  self setragdollnobloodpoolfx(0);
}

function disable_blood_pool() {
  self.skipbloodpool = 1;
  self setragdollnobloodpoolfx(1);
}

function deletable_magic_bullet_shield() {
  ai::magic_bullet_shield(1);
}

function set_favoriteenemy(enemy) {
  self.favoriteenemy = enemy;
}

function get_pacifist() {
  return self.pacifist;
}

function set_pacifist(val) {
  assert(issentient(self), "<dev string:x112>");
  self.pacifist = val;
}

function set_maxsightdistsquared(value) {
  self.maxsightdistsqrd = value;
}

function set_maxvisibledist(value) {
  self.maxvisibledist = value;
}

function set_maxfaceenemydist(value) {
  self.maxfaceenemydist = value;
}

function set_sprint(value) {
  self.sprint = value;
}

function flood_spawn(spawners) {
  spawner::flood_spawner_scripted(spawners);
}

function force_crawling_death(angle, num_crawls, array, nofallanim) {
  assertmsg("<dev string:x132>");

  if(!isDefined(num_crawls)) {
    num_crawls = 4;
  }

  thread force_crawling_death_proc(angle, num_crawls, array, nofallanim);
}

function override_crawl_death_anims() {
  if(isDefined(self.a.custom_crawling_death_array)) {
    self.a.array["\xc3\x869d\xbb"] = self.a.custom_crawling_death_array["\xc3\x869d\xbb"];
    self.a.array["\x1e\xfd\xd1\xa2\a"] = self.a.custom_crawling_death_array["\x1e\xfd\xd1\xa2\a"];
    self.a.crawl_fx_rate = self.a.custom_crawling_death_array["\xd4\xa3\x1cu8\xe2\x1d\x1d;\xed|7x"];

    if(isDefined(self.a.custom_crawling_death_array["]`\x0f\xc0\xc4P|\x11"])) {
      self.a.crawl_fx = self.a.custom_crawling_death_array["]`\x0f\xc0\xc4P|\x11"];
    }
  }

  self.a.array["\x0f\xbb!\x8a\xd4j\xad\ao\x8a\x88>H"] = [];

  if(isDefined(self.nofallanim)) {
    self.currentpose = "GX\xa9]\x82";
  }

  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.a.force_crawl_angle);
  self.a.force_crawl_angle = undefined;
}

function force_crawling_death_proc(angle, num_crawls, array, nofallanim) {
  self.forcelongdeath = 1;
  self.force_num_crawls = num_crawls;
  self.noragdoll = 1;
  self.nofallanim = nofallanim;
  self.a.custom_crawling_death_array = array;
  self.crawlingpainanimoverridefunc = &override_crawl_death_anims;
  self.maxhealth = 100000;
  self.health = 100000;
  ai::enable_long_death();

  if(!isDefined(nofallanim) || nofallanim == 0) {
    self.a.force_crawl_angle = angle + 181.02;
    return;
  }

  self.a.force_crawl_angle = angle;
  thread notetracks_sp::notetrackposecrawl();
}

function ai_ragdoll_immediate() {
  self.skipdeathanim = 1;
  die();
}

function playerwatch_unresolved_collision(count) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xf7\xc6E\xcb\x90\x95\xf0\xd5V\xfe\xda\x1f\xa9d\xc1a~J\xf8\xa4\x9dUsS\xab\xe8\x94\x8a\x8af\xcct");

  if(!isDefined(count)) {
    count = 20;
  }

  self.unresolved_collision_count = 0;

  while(true) {
    self waittill("2\xfe&\xc10J\xde\xffUxV#\x95\xa4\xf0\xfb\x99\xd0\xebd", mover);
    self.last_unresolved_collision_time = gettime();

    if(isDefined(mover) && (istrue(mover.doorclip) || istrue(mover.allowunresolvedcollision))) {
      continue;
    }

    childthread resetunresolvedcollision();
    self.unresolved_collision_count++;

    if(self.unresolved_collision_count >= count) {
      if(isDefined(mover) && isDefined(mover.unresolved_collision_func)) {
        mover[[mover.unresolved_collision_func]](self);
      }

      if(isDefined(self.handle_unresolved_collision)) {
        self[[self.handle_unresolved_collision]]();
        continue;
      }

      default_unresolved_collision_handler();
    }
  }
}

function function_9763c1b8660451c9(guy, abovehead = 0, hitsmoke = "\r+x5") {
  assert(isai(guy));
  assert(isPlayer(self));

  if(!isDefined(self.var_9763c1b8660451c9)) {
    thread function_180db6fd31431a4d();
  }

  function_77aa9a43f71fc4e6(guy, abovehead, hitsmoke);
  function_f90fd7b168c1b0b7();
  return istrue(guy.var_c691b7469a434e1c);
}

function private function_180db6fd31431a4d(var_37d2f643bb3a6c98 = 3) {
  self notify("\xab\x7fy\x10t\xb2\f\x9b\x80T\xba\x85\xc9\x02\xd9");
  self endon("\xab\x7fy\x10t\xb2\f\x9b\x80T\xba\x85\xc9\x02\xd9");
  assert(isPlayer(self));
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self.var_9763c1b8660451c9 = spawnStruct();
  self.var_9763c1b8660451c9.queue = linked_list::createstruct_linkedlist();
  self.var_9763c1b8660451c9.framecount = 0;
  self.var_9763c1b8660451c9.var_37d2f643bb3a6c98 = var_37d2f643bb3a6c98;
  self.var_9763c1b8660451c9.contents = trace::create_ainosight_contents();

  while(true) {
    while(function_f90fd7b168c1b0b7()) {}

    self.var_9763c1b8660451c9.framecount = 0;
    waitframe();
  }
}

function private function_f90fd7b168c1b0b7() {
  assert(isPlayer(self));
  assert(isDefined(self.var_9763c1b8660451c9.queue));

  if(self.var_9763c1b8660451c9.queue.nodecount == 0) {
    return 0;
  }

  if(self.var_9763c1b8660451c9.framecount >= self.var_9763c1b8660451c9.var_37d2f643bb3a6c98) {
    return 0;
  }

  now = gettime();
  result = 0;
  node = self.var_9763c1b8660451c9.queue linked_list::getstartnode();
  guy = node.guy;

  if(isDefined(guy)) {
    self.var_9763c1b8660451c9.framecount++;
    result = 1;
    guy.var_c691b7469a434e1c = cantracetoai(guy, self getvieworigin(), [self], self.var_9763c1b8660451c9.contents, node.abovehead, node.hitsmoke);
    guy.var_9763c1b8660451c9 = undefined;
  }

  self.var_9763c1b8660451c9.queue linked_list::removestartnode();
  return result;
}

function private function_77aa9a43f71fc4e6(guy, abovehead, hitsmoke) {
  assert(isPlayer(self));
  assert(isDefined(self.var_9763c1b8660451c9));

  if(isDefined(guy.var_9763c1b8660451c9)) {
    assert(guy.var_9763c1b8660451c9.abovehead == abovehead);
    assert(guy.var_9763c1b8660451c9.hitsmoke == hitsmoke);
    return;
  }

  node = spawnStruct();
  node.guy = guy;
  node.abovehead = abovehead;
  node.hitsmoke = hitsmoke;
  self.var_9763c1b8660451c9.queue linked_list::addnode(node);
  guy.var_9763c1b8660451c9 = node;
}

function resetunresolvedcollision() {
  self notify("\xc7\x19\x81\xe5\xe9\xa0\x14\x90\x87\xb0v\x14\xdb\x81\x19[|(\xb1\xa3K\xc0");
  self endon("\xc7\x19\x81\xe5\xe9\xa0\x14\x90\x87\xb0v\x14\xdb\x81\x19[|(\xb1\xa3K\xc0");
  wait 0.05;
  waittillframeend();
  self.unresolved_collision_count = 0;
}

function default_unresolved_collision_handler() {
  index = player_death::function_c5efec7ebf2d47c5(%"hash_771ea1c55b098bbf");
  level.custom_death_quote = index;
  missionfailedwrapper();
}

function stop_playerwatch_unresolved_collision() {
  self notify("\xf7\xc6E\xcb\x90\x95\xf0\xd5V\xfe\xda\x1f\xa9d\xc1a~J\xf8\xa4\x9dUsS\xab\xe8\x94\x8a\x8af\xcct");
}

function play_sound_on_tag_endon_death(alias, tag) {
  play_sound_on_tag(alias, tag, 1);
}

function play_loop_sound_on_entity_with_pitch(alias, offset, pitch_amount, pitch_time) {
  org = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
  org endon("\x1e\xfd\xd1\xa2\a");
  thread utility::delete_on_death(org);

  if(!isDefined(pitch_amount)) {
    pitch_amount = 0;
  }

  if(!isDefined(pitch_time)) {
    pitch_time = 0;
  }

  if(isDefined(offset)) {
    org.origin = self.origin + offset;
  } else {
    org.origin = self.origin;
  }

  org.angles = self.angles;
  org linkTo(self);
  org playLoopSound(alias);
  org scalepitch(pitch_amount, pitch_time);
  self waittill("y\x9cO.4\xf5\xb1\x19\xa8\xe1" + alias);
  org stoploopsound(alias);
  org delete();
}

function play_sound_on_entity(alias, var_e0d135c5a1146a1f) {
  assert(!isspawner(self), "<dev string:x173>");
  play_sound_on_tag(alias, undefined, undefined, var_e0d135c5a1146a1f);
}

function assign_animtree(animname) {
  if(isDefined(animname)) {
    self.animname = animname;
  }

  assert(isDefined(level.scr_animtree[self.animname]), "<dev string:x194>" + self.animname);
  self useanimtree(level.scr_animtree[self.animname]);
}

function assign_model() {
  assert(isDefined(level.scr_model[self.animname]), "<dev string:x1c4>" + self.animname);

  if(isarray(level.scr_model[self.animname])) {
    randindex = randomint(level.scr_model[self.animname].size);
    self setModel(level.scr_model[self.animname][randindex]);
    return;
  }

  self setModel(level.scr_model[self.animname]);
}

function spawn_anim_model(animname, origin, angles) {
  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }

  model = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", origin);
  model.animname = animname;
  model assign_animtree();
  model assign_model();

  if(isDefined(angles)) {
    model.angles = angles;
  }

  return model;
}

function spawn_anim_weapon(animname, origin, angles, viewmodel) {
  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }

  if(!isDefined(viewmodel)) {
    viewmodel = 0;
  }

  model = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", origin);
  model.animname = animname;
  model assign_animtree();
  assert(isDefined(level.scr_weapon[animname]), "<dev string:x1f1>" + model.animname);
  attachments = [];

  if(isDefined(level.scr_weapon[animname][1])) {
    attachments = level.scr_weapon[animname][1];
  }

  model utility::make_weapon_model(level.scr_weapon[animname][0], attachments, viewmodel);

  if(isDefined(angles)) {
    model.angles = angles;
  }

  return model;
}

function trigger_wait(strname, strkey) {
  etrigger = getEnt(strname, strkey);

  if(!isDefined(etrigger)) {
    assertmsg("<dev string:x21f>" + strname + "<dev string:x236>" + strkey);
    return;
  }

  etrigger waittill("\x91`\xb1\xe7T\x97>", eother);
  level notify(strname, eother);
  return eother;
}

function trigger_wait_targetname(strname) {
  return trigger_wait(strname, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
}

function set_flag_on_dead(spawners, strflag) {
  thread set_flag_on_func_wait_proc(spawners, strflag, &waittill_dead, "`K\xe9\x94\xbf\xb5%\xfa}{\xfe_J\xe6\x8a\x10");
}

function set_flag_on_dead_or_dying(spawners, strflag) {
  thread set_flag_on_func_wait_proc(spawners, strflag, &waittill_dead_or_dying, "\xcd\xf0\xa8\xbf5\xd6\x98'e\x8c9t\xe9\xb9OO\xf4\xeebd\xdbc\x19\xa8W");
}

function set_flag_on_spawned_ai_proc(system, internal_flag) {
  self waittill("\xcb!f\x94\xa0@\xc1", guy);

  if(ai::spawn_failed(guy)) {
    return;
  }

  system.ai[system.ai.size] = guy;
  utility::ent_flag_set(internal_flag);
}

function set_flag_on_func_wait_proc(spawners, strflag, waitfunc, internal_flag) {
  system = spawnStruct();
  system.ai = [];
  assert(spawners.size, "<dev string:x240>");

  foreach(key, spawn in spawners) {
    spawn utility::ent_flag_init(internal_flag);
  }

  utility::array_thread(spawners, &set_flag_on_spawned_ai_proc, system, internal_flag);

  foreach(spawn in spawners) {
    spawn utility::ent_flag_wait(internal_flag);
  }

  [[waitfunc]](system.ai);
  utility::flag_set(strflag);
}

function set_flag_on_trigger(etrigger, strflag) {
  if(!utility::flag(strflag)) {
    etrigger waittill("\x91`\xb1\xe7T\x97>", eother);
    utility::flag_set(strflag);
    return eother;
  }
}

function set_flag_on_targetname_trigger(msg) {
  if(utility::flag(msg)) {
    return;
  }

  trigger = getEnt(msg, #targetname);
  trigger waittill("\x91`\xb1\xe7T\x97>");
  utility::flag_set(msg);
}

function waittill_dead(guys, num, timeoutlength) {
  allalive = 1;

  foreach(member in guys) {
    if(isalive(member)) {
      continue;
    }

    allalive = 0;
    break;
  }

  assert(allalive, "<dev string:x255>");

  if(!allalive) {
    newarray = [];

    foreach(member in guys) {
      if(isalive(member)) {
        newarray[newarray.size] = member;
      }
    }

    guys = newarray;
  }

  ent = spawnStruct();

  if(isDefined(timeoutlength)) {
    ent endon("X\xb0nG\xc1]\xc3\x15\xfdR\x15\x99\x16\x968\xb8");
    ent thread utility_code::waittill_dead_timeout(timeoutlength);
  }

  ent.count = guys.size;

  if(isDefined(num) && num < ent.count) {
    ent.count = num;
  }

  utility::array_thread(guys, &utility_code::waittill_dead_thread, ent);

  while(ent.count > 0) {
    ent waittill("N\xe85\xf06l}\xcbz\x98\xa3\r\xf6\x88\xf4\xc5\xfd\xe4\x89\x9e\x1d>");
  }
}

function waittill_dead_or_dying(guys, num, timeoutlength) {
  newarray = [];

  foreach(member in guys) {
    if(isalive(member) && !member.ignoreforfixednodesafecheck) {
      newarray[newarray.size] = member;
    }
  }

  guys = newarray;
  ent = spawnStruct();

  if(isDefined(timeoutlength)) {
    ent endon("X\xb0nG\xc1]\xc3\x15\xfdR\x15\x99\x16\x968\xb8");
    ent thread utility_code::waittill_dead_timeout(timeoutlength);
  }

  ent.count = guys.size;

  if(isDefined(num) && num < ent.count) {
    ent.count = num;
  }

  utility::array_thread(guys, &utility_code::waittill_dead_or_dying_thread, ent);

  while(ent.count > 0) {
    ent waittill("\xc0\x95!B\xb6=\xc9\x0e\n\xb1<b\x0f\xe12\x8fQ0\xe7\xa9`S\x87a\xe3\xfd\xd5z\x8e\x8a\xd6");
  }
}

function waittill_notetrack_or_damage(notetrack) {
  self endon("\fU`\xc0y\x95");
  self endon("\x1e\xfd\xd1\xa2\a");
  self waittillmatch("\xb3\\\x97b@19[\x9e\xc1\xd7", notetrack);
}

function get_living_ai(name, type) {
  array = get_living_ai_array(name, type);

  if(array.size > 1) {
    assertmsg("<dev string:x2b3>" + type + "<dev string:x2ee>" + name + "<dev string:x2fa>");
    return undefined;
  }

  return array[0];
}

function get_living_ai_array(name, type) {
  ai = getaispeciesarray("\xc0\xc6J", "\xc0\xc6J");
  array = [];

  foreach(actor in ai) {
    if(!isalive(actor)) {
      continue;
    }

    switch (type) {
      case #"hash_5a532485943b3d4b":
        if(isDefined(actor.targetname) && actor.targetname == name) {
          array[array.size] = actor;
        }

        break;
      case #"hash_6d8a4db48060bf8":
        if(isDefined(actor.script_noteworthy) && actor.script_noteworthy == name) {
          array[array.size] = actor;
        }

        break;
      case #"hash_a9ba80180b5bb733":
        if(isDefined(actor.animname) && actor.animname == name) {
          array[array.size] = actor;
        }

        break;
    }
  }

  return array;
}

function get_vehicle(name, type) {
  assert(isDefined(name));
  assert(isDefined(type));
  array = get_vehicle_array(name, type);

  if(!array.size) {
    return undefined;
  }

  assert(array.size == 1, "<dev string:x2ff>" + name + "<dev string:x335>" + type);
  return array[0];
}

function get_vehicle_array(name, type) {
  array = getEntArray(name, type);
  vehicle = [];
  merge_array = [];

  foreach(object in array) {
    if(object.code_classname != "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
      continue;
    }

    merge_array[0] = object;

    if(isspawner(object)) {
      if(isDefined(object.last_spawned_vehicle)) {
        merge_array[0] = object.last_spawned_vehicle;
        vehicle = array_merge(vehicle, merge_array);
      }

      continue;
    }

    vehicle = array_merge(vehicle, merge_array);
  }

  return vehicle;
}

function get_living_aispecies(name, type, breed) {
  array = get_living_aispecies_array(name, type, breed);

  if(array.size > 1) {
    assertmsg("<dev string:x33a>" + type + "<dev string:x2ee>" + name + "<dev string:x2fa>");
    return undefined;
  }

  return array[0];
}

function get_living_aispecies_array(name, type, breed) {
  if(!isDefined(breed)) {
    breed = "\xc0\xc6J";
  }

  ai = getaispeciesarray("O\x15\x1b\xad\x9ff", breed);
  ai = utility::array_combine(ai, getaispeciesarray("?\xb1\xc0\x9a", breed));
  array = [];

  for(i = 0; i < ai.size; i++) {
    switch (type) {
      case #"hash_5a532485943b3d4b":
        if(isDefined(ai[i].targetname) && ai[i].targetname == name) {
          array[array.size] = ai[i];
        }

        break;
      case #"hash_6d8a4db48060bf8":
        if(isDefined(ai[i].script_noteworthy) && ai[i].script_noteworthy == name) {
          array[array.size] = ai[i];
        }

        break;
    }
  }

  return array;
}

function gather_delay_proc(msg, delay) {
  if(isDefined(level.gather_delay[msg])) {
    if(level.gather_delay[msg]) {
      wait 0.05;

      if(isalive(self)) {
        self notify("\x16\xb8Rhdr900\xd5>h~\"\xb6\x81\xf62\x12Dy" + msg + delay);
      }

      return;
    }

    level waittill(msg);

    if(isalive(self)) {
      self notify("\x16\xb8Rhdr900\xd5>h~\"\xb6\x81\xf62\x12Dy" + msg + delay);
    }

    return;
  }

  level.gather_delay[msg] = 0;
  wait delay;
  level.gather_delay[msg] = 1;
  level notify(msg);

  if(isalive(self)) {
    self notify("\xfe\xac\x95.\xce\x88@\x02]78\xf8\xbfa^y\xf2\xe0\xbc\n7\x06\x1f\x1e*" + msg + delay);
  }
}

function gather_delay(msg, delay) {
  thread gather_delay_proc(msg, delay);
  self waittill("\x16\xb8Rhdr900\xd5>h~\"\xb6\x81\xf62\x12Dy" + msg + delay);
}

function getlinks_array(array, linkmap) {
  ents = [];

  for(j = 0; j < array.size; j++) {
    node = array[j];
    script_linkname = node.script_linkname;

    if(!isDefined(script_linkname)) {
      continue;
    }

    if(!isDefined(linkmap[script_linkname])) {
      continue;
    }

    ents[ents.size] = node;
  }

  return ents;
}

function array_merge(array1, array2) {
  if(array1.size == 0) {
    return array2;
  }

  if(array2.size == 0) {
    return array1;
  }

  newarray = array1;

  foreach(array2_ent in array2) {
    foundmatch = 0;

    foreach(array1_ent in array1) {
      if(array1_ent == array2_ent) {
        foundmatch = 1;
        break;
      }
    }

    if(foundmatch) {
      continue;
    }

    newarray[newarray.size] = array2_ent;
  }

  return newarray;
}

function array_compare(array1, array2) {
  if(array1.size != array2.size) {
    return false;
  }

  foreach(key, member in array1) {
    if(!isDefined(array2[key])) {
      return false;
    }

    member2 = array2[key];

    if(member2 != member) {
      return false;
    }
  }

  return true;
}

function deck_draw_specific(item, var_fdf5ecc44f4e88be) {
  assert(isstruct(self) && isDefined(self.items) && isDefined(self.index), "<dev string:x37c>");
  deck = self;

  if(deck.items.size == 0) {
    return undefined;
  }

  if(deck.index >= deck.items.size) {
    if(deck.autoshuffle) {
      deck utility::deck_shuffle();
    } else {
      deck.index = 0;
    }
  }

  foreach(item_index, deck_item in deck.items) {
    if(deck_item != item || !istrue(var_fdf5ecc44f4e88be) && item_index < deck.index) {
      continue;
    }

    deck.last_drawn = deck.items[item_index];

    if(deck.autoshuffle) {
      deck.items[item_index] = deck.items[deck.index];
      deck.items[deck.index] = deck.last_drawn;
      deck.index++;
    } else {
      deck.index = item_index + 1;
    }

    return deck.last_drawn;
  }
}

function refill_if_empty() {
  assert(is_deck(self), "<dev string:x3c6>");
  deck = self;

  if(deck deck_is_empty()) {
    if(deck.autoshuffle) {
      deck utility::deck_shuffle();
      return;
    }

    deck.index = 0;
  }
}

function deck_is_empty() {
  assert(is_deck(self), "<dev string:x408>");
  return self.index >= self.items.size;
}

function is_deck(object) {
  return isstruct(object) && isDefined(object.items) && isDefined(object.index);
}

function getlinkedvehiclenodes() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = utility::get_links();

    foreach(name in linknames) {
      entities = getvehiclenodearray(name, #script_linkname);
      array = utility::array_combine(array, entities);
    }
  }

  return array;
}

function draw_line(org1, org2, r, g, b) {
  while(true) {
    line(org1, org2, (r, g, b), 1);
    wait 0.05;
  }
}

function draw_line_to_ent_for_time(org1, ent, r, g, b, timer) {
  timer = gettime() + timer * 1000;

  while(gettime() < timer) {
    line(org1, ent.origin, (r, g, b), 1);

    wait 0.05;

    if(!(isDefined(ent) && isDefined(ent.origin))) {
      return;
    }
  }
}

function draw_line_from_ent_for_time(ent, org, r, g, b, timer) {
  draw_line_to_ent_for_time(org, ent, r, g, b, timer);
}

function draw_line_from_ent_to_ent_for_time(ent1, ent2, r, g, b, timer) {
  ent1 endon("\x1e\xfd\xd1\xa2\a");
  ent2 endon("\x1e\xfd\xd1\xa2\a");
  timer = gettime() + timer * 1000;

  while(gettime() < timer) {
    line(ent1.origin, ent2.origin, (r, g, b), 1);

    wait 0.05;
  }
}

function draw_line_from_ent_to_ent_until_notify(ent1, ent2, r, g, b, notifyent, notifystring) {
  assert(isDefined(notifyent));
  assert(isDefined(notifystring));
  ent1 endon("\x1e\xfd\xd1\xa2\a");
  ent2 endon("\x1e\xfd\xd1\xa2\a");
  notifyent endon(notifystring);

  while(true) {
    line(ent1.origin, ent2.origin, (r, g, b), 0.05);
    wait 0.05;
  }
}

function draw_line_until_notify(org1, org2, r, g, b, notifyent, notifystring) {
  assert(isDefined(notifyent));
  assert(isDefined(notifystring));
  notifyent endon(notifystring);

  while(true) {
    utility::draw_line_for_time(org1, org2, r, g, b, 0.05);
  }
}

function draw_line_from_ent_to_vec_for_time(ent, vec, length, r, g, b, timer) {
  timer = gettime() + timer * 1000;
  vec *= length;

  while(gettime() < timer) {
    line(ent.origin, ent.origin + vec, (r, g, b), 1);

    wait 0.05;

    if(!(isDefined(ent) && isDefined(ent.origin))) {
      return;
    }
  }
}

function draw_circle_until_notify(center, radius, r, g, b, notifyent, notifystring) {
  circle_sides = 16;
  anglefrac = 360 / circle_sides;
  circlepoints = [];

  for(i = 0; i < circle_sides; i++) {
    angle = anglefrac * i;
    xadd = cos(angle) * radius;
    yadd = sin(angle) * radius;
    x = center[0] + xadd;
    y = center[1] + yadd;
    z = center[2];
    circlepoints[circlepoints.size] = (x, y, z);
  }

  thread draw_circle_lines_until_notify(circlepoints, r, g, b, notifyent, notifystring);
}

function draw_circle_lines_until_notify(circlepoints, r, g, b, notifyent, notifystring) {
  for(i = 0; i < circlepoints.size; i++) {
    start = circlepoints[i];

    if(i + 1 >= circlepoints.size) {
      end = circlepoints[0];
    } else {
      end = circlepoints[i + 1];
    }

    thread draw_line_until_notify(start, end, r, g, b, notifyent, notifystring);
  }
}

function battlechatter_off(team) {
  if(!isDefined(team)) {
    level.battlechatterdisabled = 1;
    return;
  }

  if(!isDefined(level.battlechatterdisabledteams)) {
    level.battlechatterdisabledteams = [];
  }

  level.battlechatterdisabledteams[team] = 1;
}

function battlechatter_on(team) {
  if(!isDefined(level.battlechatter)) {
    battlechatter::init_battlechatter();
  }

  if(!isDefined(team)) {
    level.battlechatterdisabled = undefined;
    return;
  }

  if(isDefined(level.battlechatterdisabledteams)) {
    level.battlechatterdisabledteams[team] = undefined;
  }
}

function battlechatter_commander_off(team) {
  if(team == "\xc0\xc6J") {
    setDvar(@ "hash_702217ae066916b9", "\xc0\xc6J");
    return;
  }

  switch (getDvar(@ "hash_702217ae066916b9")) {
    case #"":
      setDvar(@ "hash_702217ae066916b9", team);
      break;
    case #"hash_7c2d091e6337bf54":
      if(team == "O\x15\x1b\xad\x9ff") {
        setDvar(@ "hash_702217ae066916b9", "\xc0\xc6J");
      }

      break;
    case #"hash_5f54b9bf7583687f":
      if(team == "?\xb1\xc0\x9a") {
        setDvar(@ "hash_702217ae066916b9", "\xc0\xc6J");
      }

      break;
  }
}

function battlechatter_commander_on(team) {
  if(team == "\xc0\xc6J") {
    setDvar(@ "hash_702217ae066916b9", "");
    return;
  }

  switch (getDvar(@ "hash_702217ae066916b9")) {
    case #"hash_7c2d091e6337bf54":
      if(team == "?\xb1\xc0\x9a") {
        setDvar(@ "hash_702217ae066916b9", "");
      }

      break;
    case #"hash_5f54b9bf7583687f":
      if(team == "O\x15\x1b\xad\x9ff") {
        setDvar(@ "hash_702217ae066916b9", "");
      }

      break;
    case #"hash_c482c6c109150a4":
      if(team == "?\xb1\xc0\x9a") {
        setDvar(@ "hash_702217ae066916b9", "O\x15\x1b\xad\x9ff");
      } else if(team == "O\x15\x1b\xad\x9ff") {
        setDvar(@ "hash_702217ae066916b9", "O\x15\x1b\xad\x9ff");
      }

      break;
  }
}

function battlechatter_radioecho_off(team) {
  if(team == "\xc0\xc6J") {
    setDvar(@ "hash_21778f568437cd09", "\xc0\xc6J");
    return;
  }

  switch (getDvar(@ "hash_21778f568437cd09")) {
    case #"":
      setDvar(@ "hash_21778f568437cd09", team);
      break;
    case #"hash_7c2d091e6337bf54":
      if(team == "O\x15\x1b\xad\x9ff") {
        setDvar(@ "hash_21778f568437cd09", "\xc0\xc6J");
      }

      break;
    case #"hash_5f54b9bf7583687f":
      if(team == "?\xb1\xc0\x9a") {
        setDvar(@ "hash_21778f568437cd09", "\xc0\xc6J");
      }

      break;
  }
}

function battlechatter_radioecho_on(team) {
  if(team == "\xc0\xc6J") {
    setDvar(@ "hash_21778f568437cd09", "");
    return;
  }

  switch (getDvar(@ "hash_21778f568437cd09")) {
    case #"hash_7c2d091e6337bf54":
      if(team == "?\xb1\xc0\x9a") {
        setDvar(@ "hash_21778f568437cd09", "");
      }

      break;
    case #"hash_5f54b9bf7583687f":
      if(team == "O\x15\x1b\xad\x9ff") {
        setDvar(@ "hash_21778f568437cd09", "");
      }

      break;
    case #"hash_c482c6c109150a4":
      if(team == "?\xb1\xc0\x9a") {
        setDvar(@ "hash_21778f568437cd09", "O\x15\x1b\xad\x9ff");
      } else if(team == "O\x15\x1b\xad\x9ff") {
        setDvar(@ "hash_21778f568437cd09", "?\xb1\xc0\x9a");
      }

      break;
  }
}

function battlechatter_otn_on(type, team) {
  assert(isDefined(type), "<dev string:x448>");
  assert(isDefined(team), "<dev string:x47e>");
  type = tolower(type);
  team = tolower(team);
  dvar = undefined;

  switch (type) {
    case #"hash_3d5f49f17b95335c":
      dvar = @ "hash_495535a4877b324d";
      break;
    case #"hash_9e02cd4a0f3ca981":
      dvar = @ "hash_87dca5163728ce02";
      break;
    default:
      assertmsg("<dev string:x4b8>" + type);
      break;
  }

  setDvar(dvar, team);
}

function battlechatter_otn_off(type) {
  assert(isDefined(type), "<dev string:x448>");
  type = tolower(type);
  dvar = undefined;

  switch (type) {
    case #"hash_3d5f49f17b95335c":
      dvar = @ "hash_495535a4877b324d";
      break;
    case #"hash_9e02cd4a0f3ca981":
      dvar = @ "hash_87dca5163728ce02";
      break;
    default:
      assertmsg("<dev string:x4b8>" + type);
      break;
  }

  setDvar(dvar, "\xf8\x88m");
}

function battlechatter_probability(probability) {
  assert(isDefined(self), "<dev string:x4d6>");
  assert(isai(self), "<dev string:x4d6>");
  self.battlechatter_saytimescaled = probability;
}

function battlechatter_filter_on(type) {
  assert(isDefined(self), "<dev string:x4f7>");

  if(!isarray(type)) {
    type = [type];
  }

  foreach(t in type) {
    battlechatter_filter_internal(t, 1);
  }
}

function battlechatter_filter_off(type) {
  assert(isDefined(self), "<dev string:x4f7>");

  if(!isarray(type)) {
    type = [type];
  }

  foreach(t in type) {
    battlechatter_filter_internal(t, undefined);
  }
}

function battlechatter_filter_internal(type, toggle) {
  switch (type) {
    case #"hash_53dc45bfe25bbb01":
      self.battlechatter.filterthreat = toggle;
      break;
    case #"hash_8c231c599933fd88":
      self.battlechatter.filterinform = toggle;
      break;
    case #"hash_b9c0ff6cd406fe0f":
      self.battlechatter.filtervehicle = toggle;
      break;
    case #"hash_92e2b89a2c37e077":
      self.battlechatter.filterorder = toggle;
      break;
    case #"hash_19b7f63b88b6888a":
      self.battlechatter.filterreaction = toggle;
      break;
    case #"hash_7f07e54152a6ce3e":
      self.battlechatter.filterresponse = toggle;
      break;
    case #"hash_3d5f49f17b95335c":
      self.battlechatter.filterstealth = toggle;
      break;
  }
}

function battlechatter_friendlyfire_force(bool) {
  if(istrue(bool)) {
    self.battlechatter.friendlyfire_force = 1;
    return;
  }

  self.battlechatter.friendlyfire_force = undefined;
}

function battlechatter_addvehicle(class) {
  assert(isDefined(class), "<dev string:x515>");

  if(!isDefined(self.battlechatter)) {
    self.battlechatter = spawnStruct();
  }

  self.battlechatter.enemyclass = class;
  thread battlechatter_ai::aivehiclekillwaiter();
}

function set_team_bcvoice(team, newvoice) {
  if(!anim.chatinitialized) {
    return;
  }

  var_9c77a6607b84a940 = getarraykeys(anim.countryids);
  var_68f18d62e1a714de = arraycontains(var_9c77a6607b84a940, newvoice);
  assert(var_68f18d62e1a714de, "<dev string:x560>" + newvoice + "<dev string:x582>");

  if(!var_68f18d62e1a714de) {
    return;
  }

  allies = getaiarray(team);

  foreach(ai in allies) {
    ai set_ai_bcvoice(newvoice);
    waitframe();
  }
}

function set_ai_bcvoice(newvoice) {
  var_9c77a6607b84a940 = getarraykeys(anim.countryids);
  var_68f18d62e1a714de = arraycontains(var_9c77a6607b84a940, newvoice);
  assert(var_68f18d62e1a714de, "<dev string:x560>" + newvoice + "<dev string:x582>");

  if(!var_68f18d62e1a714de) {
    return;
  }

  if(self.type == "\xde\x9d\xa5") {
    return;
  }

  if(isDefined(self.battlechatter) && istrue(self.battlechatter.isspeaking)) {
    self waittill("2uCRC\xaf\xb2}wd\"\xba.");
    wait 0.1;
  }

  battlechatter_ai::setvoice(newvoice);
}

function flavorbursts_on(team) {
  thread set_flavorbursts_team_state(1, team);
}

function flavorbursts_off(team) {
  thread set_flavorbursts_team_state(0, team);
}

function set_flavorbursts_team_state(state, team) {
  if(!isDefined(team)) {
    team = "O\x15\x1b\xad\x9ff";
  }

  while(!isDefined(anim.chatinitialized)) {
    wait 0.05;
  }

  if(!anim.chatinitialized) {
    return;
  }

  wait 1.5;
  level.flavorbursts[team] = state;
  guys = [];
  guys = getaiarray(team);
  utility::array_thread(guys, &set_flavorbursts, state);
}

function set_flavorbursts(state) {
  self.flavorbursts = state;
}

function friendlyfire_warnings_off() {
  ais = getaiarray("O\x15\x1b\xad\x9ff");

  foreach(guy in ais) {
    if(isalive(guy)) {
      guy set_friendlyfire_warnings(0);
    }
  }

  level.friendlyfire_warnings = 0;
}

function friendlyfire_warnings_on() {
  ais = getaiarray("O\x15\x1b\xad\x9ff");

  foreach(guy in ais) {
    if(isalive(guy)) {
      guy set_friendlyfire_warnings(1);
    }
  }

  level.friendlyfire_warnings = 1;
}

function set_friendlyfire_warnings(state) {
  if(state) {
    self.friendlyfire_warnings_disable = undefined;
    return;
  }

  self.friendlyfire_warnings_disable = 1;
}

function player_battlechatter_on() {
  thread playerchatter::player_battlechatter_on_thread();
}

function player_battlechatter_off() {
  thread playerchatter::player_battlechatter_off_thread();
}

function set_name(name) {
  self.name = name;
  self.ainame = name;
}

function set_rank(rank) {
  self.rank = rank;
  self.airank = rank;
}

function set_callsign(callsign) {
  self.callsign = callsign;
}

function debugorigin() {
  self notify("<dev string:x5ab>");
  self endon("<dev string:x5ab>");
  self endon("<dev string:x5bb>");

  for(;;) {
    forward = anglesToForward(self.angles);
    forwardfar = forward * 30;
    forwardclose = forward * 20;
    right = anglestoright(self.angles);
    left = right * -10;
    right *= 10;
    line(self.origin, self.origin + forwardfar, (0.9, 0.7, 0.6), 0.9);
    line(self.origin + forwardfar, self.origin + forwardclose + right, (0.9, 0.7, 0.6), 0.9);
    line(self.origin + forwardfar, self.origin + forwardclose + left, (0.9, 0.7, 0.6), 0.9);
    wait 0.05;
  }
}

function get_linked_struct() {
  array = utility::get_linked_structs();

  if(!array.size) {
    return undefined;
  }

  assert(array.size == 1);
  assert(isDefined(array[0]));
  return array[0];
}

function get_last_ent_in_chain(sentitytype) {
  epathpoint = self;
  cycles = 0;

  while(isDefined(epathpoint.target)) {
    if(isDefined(epathpoint.target)) {
      epathpoint = get_next_point_in_chain(sentitytype, epathpoint.target);
      cycles++;

      if(cycles == 10) {
        waitframe();
        cycles = 0;
      }

      continue;
    }

    break;
  }

  epathend = epathpoint;
  return epathend;
}

function get_next_point_in_chain(sentitytype, tname) {
  epathpoint = undefined;

  if(isDefined(sentitytype)) {
    switch (sentitytype) {
      case #"hash_73214da7c956e2af":
        epathpoint = getvehiclenode(tname, #targetname);
        break;
      case #"hash_d2886253a54aa2e2":
        epathpoint = getnode(tname, #targetname);
        break;
      case #"hash_ed49a46bfff900ba":
        epathpoint = getEnt(tname, #targetname);
        break;
      case #"hash_961a09cded5ffc80":
        epathpoint = utility::getStruct(tname, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
        break;
      default:
        assertmsg("<dev string:x5c4>");
        break;
    }

    return epathpoint;
  } else {
    epathpoint = utility::getStruct(tname, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

    if(isDefined(epathpoint)) {
      return epathpoint;
    }

    epathpoint = getnode(tname, #targetname);

    if(isDefined(epathpoint)) {
      return epathpoint;
    }

    epathpoint = getEnt(tname, #targetname);

    if(isDefined(epathpoint)) {
      return epathpoint;
    }

    epathpoint = getvehiclenode(tname, #targetname);

    if(isDefined(epathpoint)) {
      return epathpoint;
    }
  }

  return undefined;
}

function timeout(timeout) {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait timeout;
  self notify("\xb5B\xd7\x904}\x11");
}

function array_removedead_keepkeys(array) {
  newarray = [];
  keys = getarraykeys(array);

  for(i = 0; i < keys.size; i++) {
    key = keys[i];

    if(!isalive(array[key])) {
      continue;
    }

    newarray[key] = array[key];
  }

  return newarray;
}

function array_remove_nokeys(ents, remover) {
  newents = [];

  for(i = 0; i < ents.size; i++) {
    if(ents[i] != remover) {
      newents[newents.size] = ents[i];
    }
  }

  return newents;
}

function array_remove_key_array(array, var_3f2b564f0884c21d) {
  if(var_3f2b564f0884c21d.size == 0) {
    return array;
  }

  newarray = [];

  foreach(key, item in array) {
    found = 0;

    foreach(var_36fa003aa568fa8 in var_3f2b564f0884c21d) {
      if(var_36fa003aa568fa8 == key) {
        found = 1;
        break;
      }
    }

    if(found) {
      continue;
    }

    newarray[key] = item;
  }

  return newarray;
}

function array_notify(ents, notifier, match) {
  foreach(value in ents) {
    value notify(notifier, match);
  }
}

function struct_arrayspawn() {
  struct = spawnStruct();
  struct.array = [];
  struct.lastindex = 0;
  return struct;
}

function structarray_add(struct, object) {
  assert(!isDefined(object.struct_array_index));
  struct.array[struct.lastindex] = object;
  object.struct_array_index = struct.lastindex;
  struct.lastindex++;
}

function structarray_remove(struct, object) {
  structarray_swaptolast(struct, object);
  struct.array[struct.lastindex - 1] = undefined;
  struct.lastindex--;
}

function structarray_remove_index(struct, index) {
  if(isDefined(struct.array[struct.lastindex - 1])) {
    struct.array[index] = struct.array[struct.lastindex - 1];
    struct.array[index].struct_array_index = index;
    struct.array[struct.lastindex - 1] = undefined;
    struct.lastindex = struct.array.size;
    return;
  }

  struct.array[index] = undefined;
  structarray_remove_undefined(struct);
}

function structarray_remove_undefined(struct) {
  newarray = [];

  foreach(object in struct.array) {
    if(!isDefined(object)) {
      continue;
    }

    newarray[newarray.size] = object;
  }

  struct.array = newarray;

  foreach(object in struct.array) {
    object.struct_array_index = i;
  }

  struct.lastindex = struct.array.size;
}

function structarray_swaptolast(struct, object) {
  struct utility_code::structarray_swap(struct.array[struct.lastindex - 1], object);
}

function structarray_shuffle(struct, shuffle) {
  for(i = 0; i < shuffle; i++) {
    struct utility_code::structarray_swap(struct.array[i], struct.array[randomint(struct.lastindex)]);
  }
}

function custom_battlechatter(phrase) {
  return battlechatter_ai::custom_battlechatter_internal(phrase);
}

function get_stop_watch(time, othertime) {
  watch = newhudelem();

  if(isplatformconsole()) {
    watch.x = 68;
    watch.y = 35;
  } else {
    watch.x = 58;
    watch.y = 95;
  }

  watch.alignx = "O\xd5!\xe8\xd4\x9d";
  watch.aligny = "#\xb8\xfd\xf5\x1a@";
  watch.horzalign = "=\xff0b";
  watch.vertalign = "#\xb8\xfd\xf5\x1a@";

  if(isDefined(othertime)) {
    timer = othertime;
  } else {
    timer = level.explosiveplanttime;
  }

  watch setclock(timer, time, "`\x9a\xe9\xd4\xc74\x85\xee\x9d\xc9\xeb\xce", 64, 64);
  return watch;
}

function set_mission_failed_override(func) {
  assert(isDefined(func), "<dev string:x60c>");
  assert(!isDefined(level.mission_fail_func), "<dev string:x655>");
  level.mission_fail_func = func;
}

function get_force_color_guys(team, color) {
  ai = getaiarray(team);
  guys = [];

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(!isDefined(guy.script_forcecolor)) {
      continue;
    }

    if(guy.script_forcecolor != color) {
      continue;
    }

    guys[guys.size] = guy;
  }

  return guys;
}

function get_all_force_color_friendlies() {
  ai = getaiarray("O\x15\x1b\xad\x9ff");
  guys = [];

  for(i = 0; i < ai.size; i++) {
    guy = ai[i];

    if(!isDefined(guy.script_forcecolor)) {
      continue;
    }

    guys[guys.size] = guy;
  }

  return guys;
}

function enable_ai_color() {
  if(isDefined(self.script_forcecolor)) {
    return;
  }

  if(!isDefined(self.old_forcecolor)) {
    return;
  }

  set_force_color(self.old_forcecolor);
  self.old_forcecolor = undefined;
}

function enable_ai_color_dontmove() {
  self.dontcolormove = 1;
  enable_ai_color();
}

function disable_ai_color() {
  if(isDefined(self.new_force_color_being_set)) {
    self endon("\x1e\xfd\xd1\xa2\a");
    self waittill("\xfd&mB\xe6K[\x11\x17\x9fVl\x84f\xc4Q1&m8n\xca");
  }

  self clearfixednodesafevolume();

  if(!isDefined(self.script_forcecolor)) {
    return;
  }

  assert(!isDefined(self.old_forcecolor), "<dev string:x680>");
  self.old_forcecolor = self.script_forcecolor;
  level.arrays_of_colorforced_ai[colors::get_team()][self.script_forcecolor] = arrayremove(level.arrays_of_colorforced_ai[colors::get_team()][self.script_forcecolor], self);
  colors::left_color_node();
  self.script_forcecolor = undefined;
  self.currentcolorcode = undefined;

  utility_code::update_debug_friendlycolor(self.unique_id);
}

function clear_force_color() {
  disable_ai_color();
}

function get_force_color() {
  color = self.script_forcecolor;
  return color;
}

function shortencolor(color) {
  assert(isDefined(level.colorchecklist[tolower(color)]), "<dev string:x6e2>" + color);
  return level.colorchecklist[tolower(color)];
}

function set_force_color(_color) {
  color = shortencolor(_color);
  assert(colors::colorislegit(color), "<dev string:x6e2>" + color);

  if(!isai(self)) {
    set_force_color_spawner(color);
    return;
  }

  assert(isalive(self), "<dev string:x716>");

  if(self.team == "O\x15\x1b\xad\x9ff") {
    self.fixednode = 1;
    self.fixednodesaferadius = 64;
    self.pathenemyfightdist = 0;
    self.pathenemylookahead = 0;
  }

  self.script_color_axis = undefined;
  self.script_color_allies = undefined;
  self.old_forcecolor = undefined;
  team = colors::get_team();

  if(isDefined(self.script_forcecolor)) {
    level.arrays_of_colorforced_ai[team][self.script_forcecolor] = arrayremove(level.arrays_of_colorforced_ai[team][self.script_forcecolor], self);
  }

  self.script_forcecolor = color;
  level.arrays_of_colorforced_ai[team][color] = utility::array_removedead(level.arrays_of_colorforced_ai[team][color]);
  level.arrays_of_colorforced_ai[team][self.script_forcecolor][level.arrays_of_colorforced_ai[team][self.script_forcecolor].size] = self;
  thread utility_code::new_color_being_set(color);
}

function set_force_color_spawner(color) {
  self.script_forcecolor = color;
  self.old_forcecolor = undefined;
}

function restarteffect() {
  createfx::restart_fx_looper();
}

function pauseexploder(num) {
  num += "";
  exploders = level.createfxexploders[num];

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      ent utility::pauseeffect();
    }
  }
}

function restartexploder(num) {
  num += "";
  exploders = level.createfxexploders[num];

  if(isDefined(exploders)) {
    foreach(ent in exploders) {
      ent restarteffect();
    }
  }
}

function ignoreallenemies(qtrue) {
  self notify("\xef\x1f-/\x12\x9b_\xe0\x147\xd0K\xd9\xe4%bG\xdcx\xb3\x9aPJ\x95C");
  self endon("\xef\x1f-/\x12\x9b_\xe0\x147\xd0K\xd9\xe4%bG\xdcx\xb3\x9aPJ\x95C");

  if(qtrue) {
    self.old_threat_bias_group = self getthreatbiasgroup();
    num = undefined;

    num = self getentnum();
    println("<dev string:x750>" + num + "<dev string:x75c>");
    println("<dev string:x750>" + num + "<dev string:x775>" + self.old_threat_bias_group);

    createthreatbiasgroup("\x16Q\xca\x7fK\xf3=Z\x90\xa9\x7f\x12\xd8\xc6D\xe2");

    println("<dev string:x750>" + num + "<dev string:x75c>");
    println("<dev string:x750>" + num + "<dev string:x78d>");

    self setthreatbiasgroup("\x16Q\xca\x7fK\xf3=Z\x90\xa9\x7f\x12\xd8\xc6D\xe2");
    teams = [];
    teams["?\xb1\xc0\x9a"] = "O\x15\x1b\xad\x9ff";
    teams["O\x15\x1b\xad\x9ff"] = "?\xb1\xc0\x9a";
    assert(self.team != "<dev string:x7b8>", "<dev string:x7c3>");
    ai = getaiarray(teams[self.team]);
    groups = [];

    for(i = 0; i < ai.size; i++) {
      groups[ai[i] getthreatbiasgroup()] = 1;
    }

    keys = getarraykeys(groups);

    for(i = 0; i < keys.size; i++) {
      println("<dev string:x750>" + num + "<dev string:x75c>");
      println("<dev string:x750>" + num + "<dev string:x818>" + keys[i] + "<dev string:x82c>");

      setthreatbias(keys[i], "\x16Q\xca\x7fK\xf3=Z\x90\xa9\x7f\x12\xd8\xc6D\xe2", 0);
    }

    return;
  }

  num = undefined;
  assert(isDefined(self.old_threat_bias_group), "<dev string:x847>");

  num = self getentnum();
  println("<dev string:x750>" + num + "<dev string:x8a7>");
  println("<dev string:x750>" + num + "<dev string:x8c1>" + self.old_threat_bias_group);

  if(self.old_threat_bias_group != "") {
    println("<dev string:x750>" + num + "<dev string:x8a7>");
    println("<dev string:x750>" + num + "<dev string:x8e4>" + self.old_threat_bias_group + "<dev string:x8fd>");

    self setthreatbiasgroup(self.old_threat_bias_group);
  }

  self.old_threat_bias_group = undefined;
}

function add_start(msg, setup_func, main_func, transient, catchup_function) {
  starts::add_start_assert();
  msg = tolower(msg);
  assert(!isstring(main_func), "<dev string:x903>");
  array = starts::add_start_construct(msg, setup_func, main_func, transient, catchup_function);
  assert(isDefined(setup_func), "<dev string:x96e>");
  level.start_functions[level.start_functions.size] = array;
  level.start_arrays[msg] = array;
}

function set_default_start(start) {
  level.default_start_override = tolower(start);
}

function set_default_start_alt(start) {
  level.default_start_override_alt = tolower(start);
}

function within_fov_of_players(end_origin, fov) {
  var_9d3491be371b0aa4 = undefined;

  for(i = 0; i < level.players.size; i++) {
    playereye = level.players[i] getEye();
    var_9d3491be371b0aa4 = utility::within_fov(playereye, level.players[i] getplayerangles(), end_origin, fov);

    if(!var_9d3491be371b0aa4) {
      return false;
    }
  }

  return true;
}

function wait_for_buffer_time_to_pass(last_queue_time, buffer_time) {
  timer = buffer_time * 1000 - gettime() - last_queue_time;
  timer *= 0.001;

  if(timer > 0) {
    wait timer;
  }
}

function bcs_scripted_dialogue_start() {
  anim.scripteddialoguestarttime = gettime();
}

function dialogue_queue(msg) {
  bcs_scripted_dialogue_start();
  anim_sp::anim_single_queue(self, msg);
}

function generic_dialogue_queue(msg, timeout) {
  bcs_scripted_dialogue_start();
  anim_sp::anim_generic_queue(self, msg, undefined, undefined, timeout);
}

function radio_dialogue(msg, timeout) {
  assert(isDefined(level.scr_radio[msg]), "<dev string:x9b5>" + msg + "<dev string:x9d6>");
  assert(!issound3d(level.scr_radio[msg]), "<dev string:xa08>" + msg + "<dev string:xa25>");

  if(!isDefined(level.player_radio_emitter)) {
    ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
    ent linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = ent;
  }

  bcs_scripted_dialogue_start();
  success = 0;

  if(!isDefined(timeout)) {
    success = level.player_radio_emitter function_stack(&utility::playsoundontag, level.scr_radio[msg], undefined, 1);
  } else {
    success = level.player_radio_emitter function_stack_timeout(timeout, &utility::playsoundontag, level.scr_radio[msg], undefined, 1);
  }

  return success;
}

function radio_dialogue_overlap(msg) {
  assert(isDefined(level.scr_radio[msg]), "<dev string:x9b5>" + msg + "<dev string:x9d6>");
  assert(isDefined(level.player_radio_emitter), "<dev string:xa3b>");
  level.player_radio_emitter play_sound_on_tag(level.scr_radio[msg], undefined, 1);
}

function radio_dialogue_stop() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }

  level.player_radio_emitter delete();
}

function radio_dialogue_clear_stack() {
  if(!isDefined(level.player_radio_emitter)) {
    return;
  }

  level.player_radio_emitter function_stack_clear();
}

function radio_dialogue_interupt(msg) {
  assert(isDefined(level.scr_radio[msg]), "<dev string:x9b5>" + msg + "<dev string:x9d6>");

  if(!isDefined(level.player_radio_emitter)) {
    ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
    ent linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_radio_emitter = ent;
  }

  level.player_radio_emitter play_sound_on_tag(level.scr_radio[msg], undefined, 1);
}

function radio_dialogue_safe(msg) {
  return radio_dialogue(msg, 0.05);
}

function smart_radio_dialogue(dialogue, timeout) {
  utility_code::add_to_radio(dialogue);
  radio_dialogue(dialogue, timeout);
}

function smart_radio_dialogue_interrupt(dialogue) {
  utility_code::add_to_radio(dialogue);
  radio_dialogue_stop();
  radio_dialogue_interupt(dialogue);
}

function smart_radio_dialogue_overlap(dialogue) {
  utility_code::add_to_radio(dialogue);
  radio_dialogue_overlap(dialogue);
}

function player_dialogue(msg, timeout) {
  return player_dialogue_gesture(msg, 0, undefined, undefined, undefined, timeout);
}

function _play_player_dialogue(alias, sounddelay, gestures, gesturedelays, gesturetargets) {
  if(utility::is_dead_sentient()) {
    return;
  }

  org = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
  org endon("\x1e\xfd\xd1\xa2\a");
  org.origin = self.origin;
  org.angles = self.angles;
  org linkTo(self);

  if(isDefined(level.player_dialogue_emitter) && self == level.player_dialogue_emitter) {
    println("<dev string:xa8f>" + alias);
  }

  if(sounddelay > 0) {
    org utility::delaycall(sounddelay, &playsound, alias, "\xdc\xf6\xba\xdcFF\xdb\xe6e");
  } else {
    org playSound(alias, "\xdc\xf6\xba\xdcFF\xdb\xe6e");
  }

  if(isDefined(gestures)) {
    assert(isDefined(gesturedelays), "<dev string:xab2>");

    if(isarray(gestures)) {
      assert(gestures.size == gesturedelays.size, "<dev string:xb05>");

      for(i = 0; i < gestures.size; i++) {
        if(isDefined(gesturetargets) && isDefined(gesturetargets[i])) {
          level.player utility::delaythread(gesturedelays[i], &player_gesture_force, gestures[i], gesturetargets[i]);
          continue;
        }

        level.player utility::delaythread(gesturedelays[i], &player_gesture_force, gestures[i]);
      }
    } else if(isDefined(gesturetargets)) {
      level.player utility::delaythread(gesturedelays, &player_gesture_force, gestures, gesturetargets);
    } else {
      level.player utility::delaythread(gesturedelays, &player_gesture_force, gestures);
    }
  }

  if(sounddelay > 0) {
    wait sounddelay;
  }

  if(!isDefined(wait_for_sounddone_or_death(org, level.player))) {
    org stopsounds();
  }

  wait 0.05;
  org delete();
}

function player_dialogue_gesture(msg, sounddelay, gestures, gesturedelays, targetents, timeout) {
  assert(isDefined(level.scr_plrdialogue[msg]), "<dev string:xb65>" + msg + "<dev string:xb87>");

  if(!isDefined(level.player_dialogue_emitter)) {
    ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
    ent linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_dialogue_emitter = ent;
  }

  bcs_scripted_dialogue_start();
  success = 0;

  if(!isDefined(timeout)) {
    success = level.player_dialogue_emitter function_stack(&_play_player_dialogue, level.scr_plrdialogue[msg], sounddelay, gestures, gesturedelays, targetents);
  } else {
    success = level.player_dialogue_emitter function_stack_timeout(timeout, &_play_player_dialogue, level.scr_plrdialogue[msg], sounddelay, gestures, gesturedelays, targetents);
  }

  return success;
}

function player_dialogue_stop() {
  if(!isDefined(level.player_dialogue_emitter)) {
    return;
  }

  level.player_dialogue_emitter delete();
}

function player_dialogue_clear_stack() {
  if(!isDefined(level.player_dialogue_emitter)) {
    return;
  }

  level.player_dialogue_emitter function_stack_clear();
}

function player_dialogue_interrupt(msg) {
  assert(isDefined(level.scr_plrdialogue[msg]), "<dev string:xb65>" + msg + "<dev string:xb87>");
  player_dialogue_stop();

  if(!isDefined(level.player_dialogue_emitter)) {
    ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
    ent linkTo(level.player, "", (0, 0, 0), (0, 0, 0));
    level.player_dialogue_emitter = ent;
  }

  level.player_dialogue_emitter _play_player_dialogue(level.scr_plrdialogue[msg], 0);
}

function smart_player_dialogue(dialogue, timeout) {
  utility_code::add_to_player_dialogue(dialogue);
  player_dialogue(dialogue, timeout);
}

function smart_player_dialogue_interrupt(dialogue) {
  utility_code::add_to_player_dialogue(dialogue);
  player_dialogue_interrupt(dialogue);
}

function smart_player_dialogue_gesture(dialogue, sounddelay, gestures, gesturedelays, targetents, timeout) {
  utility_code::add_to_player_dialogue(dialogue);
  player_dialogue_gesture(dialogue, sounddelay, gestures, gesturedelays, targetents, timeout);
}

function smart_dialogue(dialogue) {
  utility_code::add_to_dialogue(dialogue);
  dialogue_queue(dialogue);
}

function smart_dialogue_generic(dialogue) {
  utility_code::add_to_dialogue_generic(dialogue);
  generic_dialogue_queue(dialogue);
}

function dialogue_print(dialogue, overradio, clearcurrent, maxlines) {
  if(!isDefined(maxlines) && isDefined(level.var_609abf3c34b656ad)) {
    maxlines = level.var_609abf3c34b656ad;
  }

  assert(!isDefined(maxlines) || maxlines >= 1, "<dev string:xbbf>");

  if(istrue(clearcurrent) && isDefined(level.dialoguehud) || isDefined(maxlines) && isDefined(level.dialoguehud) && level.dialoguehud.size >= maxlines) {
    dialogue_print_clear(1, maxlines - 1);
  }

  if(isPlayer(self)) {
    color = ";\xb9";
  } else if(isDefined(self.team)) {
    switch (self.team) {
      case #"hash_7c2d091e6337bf54":
        color = "#\xd2";
        break;
      case #"hash_5f54b9bf7583687f":
        color = "\x06G";
        break;
      case #"hash_24b14065e10b1f8d":
        color = "=\xc3";
        break;
      default:
        color = "\x91\x9f";
        break;
    }
  } else {
    color = "\x91\x9f";
  }

  print_str = "";

  if(isDefined(self.name)) {
    print_str += self.name;
  } else if(isPlayer(self)) {
    print_str += "I_p\x84a\x01";
  } else if(isDefined(self.team)) {
    if(isDefined(level.var_a7c65d25a08d98ae) && isDefined(level.var_a7c65d25a08d98ae[self.team])) {
      print_str += level.var_a7c65d25a08d98ae[self.team];
    } else {
      switch (self.team) {
        case #"hash_7c2d091e6337bf54":
          print_str += "\xaa8C\xef\xc2";
          break;
        case #"hash_24b14065e10b1f8d":
          print_str += "\xac\x1b\xab)\xd1";
          break;
        case #"hash_5f54b9bf7583687f":
          print_str += "\x1cf@>\x87t\x93\x05";
          break;
        default:
          print_str += "\x9b{\xfb";
          break;
      }
    }
  }

  if(istrue(overradio)) {
    print_str += ".\xe2;\x03\x11[\x03c\xa1\xf5\xb3";
  }

  if(print_str != "") {
    print_str = color + print_str + "\xd5\xef\x11\xf3";
  }

  print_str += dialogue;
  thread function_c2ae81cb172e0cd(print_str);
}

function function_c2ae81cb172e0cd(string) {
  var_d621f0b0778275a1 = int(5.9);
  lineheight = int(10);
  var_42a84195d95796ce = int(4);

  if(isDefined(level.var_e91ff5d7be7284b0)) {
    endy = level.var_e91ff5d7be7284b0;
  } else {
    endy = 425;
  }

  width = int(clamp(string.size * var_d621f0b0778275a1, 350, 630));
  string_array = utility::wrap_text(string, int(630 / var_d621f0b0778275a1));
  height = lineheight * string_array.size + var_42a84195d95796ce * 2;
  text_array = [];

  foreach(i, string in string_array) {
    text = newhudelem();
    text.alpha = 0;
    text settext(string);
    text.fontscale = 1;
    text.row = i;
    text.y = 425;
    text_array[text_array.size] = text;
  }

  bg = newhudelem();
  bg.alpha = 0;
  bg setshader("\x8a-\v\xa1\xbd", width, height);
  bg.y = 425;

  if(isDefined(level.dialoguehud)) {
    foreach(dialogueline in level.dialoguehud) {
      foreach(hud in dialogueline) {
        hud moveovertime(0.1);
        hud.y -= height + 5;
      }
    }
  } else {
    level.dialoguehud = [];
  }

  array = utility::array_add(text_array, bg);
  array[0] endon("2\xa5\v\xc6\xf6gu\xac_\xc19\x96\xb9\x1d\xeb\x1b\xd8+,r");
  level.dialoguehud[level.dialoguehud.size] = array;

  foreach(hud in array) {
    hud.alignx = "O\xd5!\xe8\xd4\x9d";
    hud.aligny = "\x1d Q";
    hud.x = 320;
    hud.y = 425;
    hud.sort = 5;

    if(isDefined(hud.row)) {
      hud.y += hud.row * lineheight + var_42a84195d95796ce;
    }
  }

  endy -= height;

  foreach(hud in array) {
    hud fadeovertime(0.1);

    if(isDefined(hud.row)) {
      hud.alpha = 1;
    } else {
      hud.alpha = 0.5;
    }

    hud moveovertime(0.1);

    if(isDefined(hud.row)) {
      hud.y = endy + hud.row * lineheight + var_42a84195d95796ce;
      continue;
    }

    hud.y = endy;
  }

  wait 2.1;

  foreach(hud in array) {
    hud fadeovertime(1);
    hud.alpha = 0;
  }

  wait 1;

  foreach(dialogueline in level.dialoguehud) {
    if(dialogueline[0] == array[0]) {
      level.dialoguehud = utility::array_remove_index(level.dialoguehud, i, 0);
      break;
    }
  }

  if(!level.dialoguehud.size) {
    level.dialoguehud = undefined;
  }

  foreach(hud in array) {
    hud destroy();
  }
}

function dialogue_print_clear(immediate, maxlines) {
  if(!isDefined(level.dialoguehud)) {
    return;
  }

  thread function_c512b9e497cc6fd7(immediate, maxlines);
}

function function_c512b9e497cc6fd7(immediate, maxlines) {
  if(!isDefined(maxlines)) {
    maxlines = 0;
  }

  linestoclear = [];
  currentlines = level.dialoguehud.size;

  for(i = 0; i < currentlines && currentlines - linestoclear.size > maxlines; i++) {
    level.dialoguehud[i][0] notify("2\xa5\v\xc6\xf6gu\xac_\xc19\x96\xb9\x1d\xeb\x1b\xd8+,r");
    linestoclear[linestoclear.size] = level.dialoguehud[i];
    level.dialoguehud = utility::array_remove_index(level.dialoguehud, i, 1);
  }

  level.dialoguehud = utility::array_combine(level.dialoguehud);

  if(!istrue(immediate)) {
    foreach(dialogueline in linestoclear) {
      foreach(hud in dialogueline) {
        if(hud.alpha > 0) {
          hud fadeovertime(1);
          hud.alpha = 0;
        }
      }
    }

    wait 1;
  }

  if(isDefined(level.dialoguehud) && !level.dialoguehud.size) {
    level.dialoguehud = undefined;
  }

  foreach(dialogueline in linestoclear) {
    foreach(hud in dialogueline) {
      if(isDefined(hud)) {
        hud destroy();
      }
    }
  }
}

function function_5dd105d1ad21ff47(y) {
  if(!isDefined(y)) {
    y = 425;
  }

  if(isDefined(level.dialoguehud)) {
    if(isDefined(level.var_e91ff5d7be7284b0)) {
      prevy = level.var_e91ff5d7be7284b0;
    } else {
      prevy = 425;
    }

    offset = y - prevy;

    foreach(dialogueline in level.dialoguehud) {
      foreach(hud in dialogueline) {
        hud.y += offset;
      }
    }
  }

  level.var_e91ff5d7be7284b0 = y;
}

function function_3de3797a7abbe724(guy) {
  if(isDefined(level.battlechatter[guy.team]) && !istrue(level.battlechatter[guy.team])) {
    return;
  }

  level notify("\x95@G\x1b\x94\xacv@\x91\xda\xb6v\x16\xac\x86\xb5\xbd\x03\xad\x1b\xb0\x9c\xdbg\xc9X\x90\x9b");
  team = guy.team;
  waitframe();
  waittime = 3.1;

  if(isDefined(team)) {
    level battlechatter_off(team);
    level utility::waittill_any_timeout(waittime, "2\xa5\v\xc6\xf6gu\xac_\xc19\x96\xb9\x1d\xeb\x1b\xd8+,r", "\x95@G\x1b\x94\xacv@\x91\xda\xb6v\x16\xac\x86\xb5\xbd\x03\xad\x1b\xb0\x9c\xdbg\xc9X\x90\x9b");
    level battlechatter_on(team);
    return;
  }

  if(isDefined(guy)) {
    guy endon("\x1e\xfd\xd1\xa2\a");
    guy endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
    guy utility::set_battlechatter(0);
    level utility::waittill_any_timeout(waittime, "2\xa5\v\xc6\xf6gu\xac_\xc19\x96\xb9\x1d\xeb\x1b\xd8+,r", "\x95@G\x1b\x94\xacv@\x91\xda\xb6v\x16\xac\x86\xb5\xbd\x03\xad\x1b\xb0\x9c\xdbg\xc9X\x90\x9b");
    guy utility::set_battlechatter(1);
  }
}

function radio_dialogue_queue(msg) {
  radio_dialogue(msg);
}

function ignoreeachother(group1, group2) {
  assert(threatbiasgroupexists(group1), "<dev string:xbef>" + group1 + "<dev string:xc12>" + group2 + "<dev string:xc1e>" + group1 + "<dev string:xc27>");
  assert(threatbiasgroupexists(group2), "<dev string:xbef>" + group2 + "<dev string:xc12>" + group1 + "<dev string:xc1e>" + group2 + "<dev string:xc27>");
  setignoremegroup(group1, group2);
  setignoremegroup(group2, group1);
}

function add_global_spawn_function(team, function, ...) {
  if(!isDefined(level.spawn_funcs)) {
    spawner::main();
  }

  assert(isDefined(level.spawn_funcs), "<dev string:xc3b>");
  func = [];
  func["\xbc\xb1\xf1\xdff\xf7,\xd7"] = function;
  func["\x1dGU]\xc5\x1a"] = vararg;
  func["wZ-\x10\"['OZ-9"] = varargcount;
  level.spawn_funcs[team][level.spawn_funcs[team].size] = func;
}

function remove_global_spawn_function(team, function) {
  assert(isDefined(level.spawn_funcs), "<dev string:xc76>");
  array = [];

  for(i = 0; i < level.spawn_funcs[team].size; i++) {
    if(level.spawn_funcs[team][i]["\xbc\xb1\xf1\xdff\xf7,\xd7"] != function) {
      array[array.size] = level.spawn_funcs[team][i];
    }
  }

  level.spawn_funcs[team] = array;
}

function exists_global_spawn_function(team, function) {
  if(!isDefined(level.spawn_funcs)) {
    return false;
  }

  for(i = 0; i < level.spawn_funcs[team].size; i++) {
    if(level.spawn_funcs[team][i]["\xbc\xb1\xf1\xdff\xf7,\xd7"] == function) {
      return true;
    }
  }

  return false;
}

function remove_spawn_function(function) {
  assert(!isalive(self), "<dev string:xcb4>");
  assert(isspawner(self), "<dev string:xce7>");
  assert(isDefined(self.spawn_functions), "<dev string:xd2c>");
  var_b0cef08d33e1d0ae = [];

  foreach(func_array in self.spawn_functions) {
    if(func_array["\xbc\xb1\xf1\xdff\xf7,\xd7"] == function) {
      continue;
    }

    var_b0cef08d33e1d0ae[var_b0cef08d33e1d0ae.size] = func_array;
  }

  self.spawn_functions = var_b0cef08d33e1d0ae;
}

function add_spawn_function(function, ...) {
  assert(!isalive(self), "<dev string:xd63>");
  assert(isspawner(self), "<dev string:xd93>");
  assert(isDefined(self.spawn_functions), "<dev string:xdd5>");

  foreach(func_array in self.spawn_functions) {
    if(func_array["\xbc\xb1\xf1\xdff\xf7,\xd7"] == function) {
      return;
    }
  }

  func = [];
  func["\xbc\xb1\xf1\xdff\xf7,\xd7"] = function;
  func["\x1dGU]\xc5\x1a"] = vararg;
  func["wZ-\x10\"['OZ-9"] = varargcount;
  self.spawn_functions[self.spawn_functions.size] = func;
}

function array_kill(array) {
  for(i = 0; i < array.size; i++) {
    array[i] kill();
  }
}

function ignore_triggers(timer) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self.ignoretriggers = 1;

  if(isDefined(timer)) {
    wait timer;
  } else {
    wait 0.5;
  }

  self.ignoretriggers = 0;
}

function activate_trigger_with_targetname(msg) {
  trigger = getEnt(msg, #targetname);
  trigger activate_trigger();
}

function activate_trigger_with_noteworthy(msg) {
  trigger = getEnt(msg, #script_noteworthy);
  trigger activate_trigger();
}

function disable_trigger_with_targetname(msg) {
  trigger = getEnt(msg, #targetname);
  trigger utility::trigger_off();
}

function disable_trigger_with_noteworthy(msg) {
  trigger = getEnt(msg, #script_noteworthy);
  trigger utility::trigger_off();
}

function enable_trigger_with_targetname(msg) {
  trigger = getEnt(msg, #targetname);
  trigger utility::trigger_on();
}

function enable_trigger_with_noteworthy(msg) {
  trigger = getEnt(msg, #script_noteworthy);
  trigger utility::trigger_on();
}

function set_team_pacifist(team, val) {
  ai = getaiarray(team);

  for(i = 0; i < ai.size; i++) {
    ai[i].pacifist = val;
  }
}

function replace_on_death() {
  colors::colornode_replace_on_death();
}

function spawn_reinforcement(classname, color) {
  colors::colornode_spawn_reinforcement(classname, color);
}

function set_promotion_order(deadguy, replacer) {
  if(!isDefined(level.current_color_order)) {
    level.current_color_order = [];
  }

  deadguy = shortencolor(deadguy);
  replacer = shortencolor(replacer);
  level.current_color_order[deadguy] = replacer;

  if(!isDefined(level.current_color_order[replacer])) {
    set_empty_promotion_order(replacer);
  }
}

function set_empty_promotion_order(deadguy) {
  if(!isDefined(level.current_color_order)) {
    level.current_color_order = [];
  }

  level.current_color_order[deadguy] = "\r+x5";
}

function remove_color_from_array(array, color) {
  newarray = [];

  for(i = 0; i < array.size; i++) {
    guy = array[i];

    if(!isDefined(guy.script_forcecolor)) {
      continue;
    }

    if(guy.script_forcecolor == color) {
      continue;
    }

    newarray[newarray.size] = guy;
  }

  return newarray;
}

function remove_noteworthy_from_array(array, noteworthy) {
  newarray = [];

  for(i = 0; i < array.size; i++) {
    guy = array[i];

    if(!isDefined(guy.script_noteworthy)) {
      continue;
    }

    if(guy.script_noteworthy == noteworthy) {
      continue;
    }

    newarray[newarray.size] = guy;
  }

  return newarray;
}

function get_closest_colored_friendly(color, origin) {
  allies = get_force_color_guys("O\x15\x1b\xad\x9ff", color);

  if(!isDefined(origin)) {
    friendly_origin = level.player.origin;
  } else {
    friendly_origin = origin;
  }

  return utility::getclosest(friendly_origin, allies);
}

function remove_without_classname(array, classname) {
  newarray = [];

  for(i = 0; i < array.size; i++) {
    if(!issubstr(array[i].classname, classname)) {
      continue;
    }

    newarray[newarray.size] = array[i];
  }

  return newarray;
}

function remove_without_model(array, model) {
  newarray = [];

  for(i = 0; i < array.size; i++) {
    if(!issubstr(array[i].model, model)) {
      continue;
    }

    newarray[newarray.size] = array[i];
  }

  return newarray;
}

function get_closest_colored_friendly_with_classname(color, classname, origin) {
  allies = get_force_color_guys("O\x15\x1b\xad\x9ff", color);

  if(!isDefined(origin)) {
    friendly_origin = level.player.origin;
  } else {
    friendly_origin = origin;
  }

  allies = remove_without_classname(allies, classname);
  return utility::getclosest(friendly_origin, allies);
}

function promote_nearest_friendly(colorfrom, colorto) {
  for(;;) {
    friendly = get_closest_colored_friendly(colorfrom);

    if(!isalive(friendly)) {
      wait 1;
      continue;
    }

    friendly set_force_color(colorto);
    return;
  }
}

function instantly_promote_nearest_friendly(colorfrom, colorto) {
  friendly = get_closest_colored_friendly(colorfrom);

  if(!isalive(friendly)) {
    assert(0, "<dev string:xe09>" + colorfrom + "<dev string:xe24>" + colorto + "<dev string:xe2c>");
    return;
  }

  friendly set_force_color(colorto);
}

function instantly_promote_nearest_friendly_with_classname(colorfrom, colorto, classname) {
  friendly = get_closest_colored_friendly_with_classname(colorfrom, classname);

  if(!isalive(friendly)) {
    assert(0, "<dev string:xe09>" + colorfrom + "<dev string:xe24>" + colorto + "<dev string:xe2c>");
    return;
  }

  friendly set_force_color(colorto);
}

function promote_nearest_friendly_with_classname(colorfrom, colorto, classname) {
  for(;;) {
    friendly = get_closest_colored_friendly_with_classname(colorfrom, classname);

    if(!isalive(friendly)) {
      wait 1;
      continue;
    }

    friendly set_force_color(colorto);
    return;
  }
}

function instantly_set_color_from_array_with_classname(array, color, classname) {
  foundguy = 0;
  newarray = [];

  for(i = 0; i < array.size; i++) {
    guy = array[i];

    if(foundguy || !issubstr(guy.classname, classname)) {
      newarray[newarray.size] = guy;
      continue;
    }

    foundguy = 1;
    guy set_force_color(color);
  }

  return newarray;
}

function instantly_set_color_from_array(array, color) {
  foundguy = 0;
  newarray = [];

  for(i = 0; i < array.size; i++) {
    guy = array[i];

    if(foundguy) {
      newarray[newarray.size] = guy;
      continue;
    }

    foundguy = 1;
    guy set_force_color(color);
  }

  return newarray;
}

function wait_for_script_noteworthy_trigger(msg) {
  utility_code::wait_for_trigger(msg, "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");
}

function wait_for_targetname_trigger(msg) {
  utility_code::wait_for_trigger(msg, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
}

function wait_for_flag_or_timeout(msg, timer) {
  if(utility::flag(msg)) {
    return;
  }

  level endon(msg);
  wait timer;
}

function wait_for_notify_or_timeout(msg, timer) {
  self endon(msg);
  wait timer;
}

function wait_for_trigger_or_timeout(timer) {
  self endon("\x91`\xb1\xe7T\x97>");
  wait timer;
}

function wait_for_either_trigger(msg1, msg2) {
  ent = spawnStruct();
  array = [];
  array = utility::array_combine(array, getEntArray(msg1, #targetname));
  array = utility::array_combine(array, getEntArray(msg2, #targetname));

  for(i = 0; i < array.size; i++) {
    ent thread utility_code::ent_waits_for_trigger(array[i]);
  }

  ent waittill("\x7f5dI");
}

function dronespawn_bodyonly(spawner) {
  drone = spawner::spawner_dronespawn(spawner);
  assert(isDefined(drone));
  return drone;
}

function fakeactorspawn(spawner) {
  if(!isDefined(spawner)) {
    spawner = self;
  }

  fakeactor = spawner::spawner_dronespawn(spawner);
  assert(isDefined(fakeactor));
  fakeactor.spawn_funcs = spawner.spawn_functions;
  fakeactor.spawner = spawner;

  if(isDefined(spawner.script_nodrop)) {
    fakeactor.nodrop = spawner.script_nodrop;
  }

  if(isDefined(spawner.script_noragdoll)) {
    fakeactor.noragdoll = spawner.script_noragdoll;
  }

  fakeactor fakeactorspawn_setup();
  return fakeactor;
}

function fakeactorspawn_setup(expendable) {
  assert(isDefined(level.fakeactor_spawn_func), "<dev string:xe38>");
  self[[level.fakeactor_spawn_func]](expendable);
  self.spawn_functions = undefined;
  thread spawner::run_spawn_functions();
  self.script_fakeactor = 1;
}

function bodyonlyspawn(spawner) {
  bodyonly = spawner::spawner_dronespawn(spawner);
  assert(isDefined(bodyonly));
  bodyonly.spawn_funcs = spawner.spawn_functions;
  bodyonly.spawn_functions = undefined;
  bodyonly thread spawner::run_spawn_functions();
  return bodyonly;
}

function dronespawn(spawner) {
  if(!isDefined(spawner)) {
    spawner = self;
  }

  drone = spawner::spawner_dronespawn(spawner);
  assert(isDefined(drone));
  assert(isDefined(level.drone_spawn_func), "<dev string:xe74>");
  drone[[level.drone_spawn_func]]();
  drone.spawn_funcs = spawner.spawn_functions;
  drone.spawn_functions = undefined;
  drone thread spawner::run_spawn_functions();
  return drone;
}

function create_corpses() {
  corpses = getEntArray("\xf8\x06g,\x12\x7f", #script_noteworthy);

  if(corpses.size) {
    array_spawn_function(corpses, &init_corpse);
  }

  corpses = getEntArray("\xca\x16\xf7\xe2a\xfe\xfb\xb8\xf3\xa7\xa6\x91\xea\xec\x05\x03", #script_noteworthy);

  if(corpses.size) {
    array_spawn_function(corpses, &init_corpse);
  }

  corpses = get_spawner_array("\xf8\x06g,\x12\x7f", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");

  if(corpses.size) {
    array_spawn_function(corpses, &init_corpse);
  }
}

function init_corpse() {
  if(!isDefined(self.script_animation)) {
    assertmsg("<dev string:xf42>");
    self delete();
    return;
  }

  self.animname = "\xf8\x06g,\x12\x7f";
  self startusingheroonlylighting();

  if(isai(self)) {
    self.ignoreall = 1;
  } else {
    self notsolid();
  }

  if(isDefined(self.target)) {
    corpse_target = utility::get_target_ent(self.target);
    self dontinterpolate();

    if(isai(self)) {
      self forceteleport(corpse_target.origin, corpse_target.angles);
    } else {
      self.origin = corpse_target.origin;
      self.angles = corpse_target.angles;
    }
  }

  weapon_model = getweaponmodel(self.weapon);

  if(isDefined(weapon_model) && weapon_model != "") {
    if(isai(self)) {
      ai::gun_remove();
    }

    if(!isDefined(self.script_nodrop)) {
      gun = spawn("r\x15U\xae\x95\xae\xc3" + getcompleteweaponname(self.weapon), self gettagorigin("\n\xa2iWa\xf6d\xab$x\xb8\x11b\xd9l\f"));
      gun.angles = self gettagangles("\n\xa2iWa\xf6d\xab$x\xb8\x11b\xd9l\f");
    }
  }

  if(isai(self)) {
    if(self.script_noteworthy == "\xca\x16\xf7\xe2a\xfe\xfb\xb8\xf3\xa7\xa6\x91\xea\xec\x05\x03") {
      self.noragdoll = 1;
    }

    ai::set_deathanim(self.script_animation);
    self kill();
    return;
  }

  self animScripted("\xd8o9\x0es\x95\xbe,n\xa5\xd6", self.origin, self.angles, utility::getanim(self.script_animation), "\x12\x9cG\x91\xbct\x16N\x8bn", undefined, 0);

  if(self.script_noteworthy != "\xca\x16\xf7\xe2a\xfe\xfb\xb8\xf3\xa7\xa6\x91\xea\xec\x05\x03") {
    death_length = getanimlength(utility::getanim(self.script_animation));

    if(death_length > 0) {
      wait death_length * 0.35;
    }

    if(isDefined(self.fnpreragdoll)) {
      self[[self.fnpreragdoll]]();
    }

    self startragdoll();
  }
}

function get_trigger_flag() {
  if(isDefined(self.script_flag)) {
    return self.script_flag;
  }

  if(isDefined(self.script_noteworthy)) {
    return self.script_noteworthy;
  }

  assert(0, "<dev string:xf7e>" + self.origin + "<dev string:xf92>");
}

function set_default_pathenemy_settings() {
  self.pathenemylookahead = 50;
  self.pathenemyfightdist = 192;
}

function walk_and_talk(var_87ce5ebbac3505ab, target, var_2e85eeef206ff9f8) {
  if(var_87ce5ebbac3505ab == "\xb8\"") {
    self._blackboard.walk_and_talk_requested = 1;

    if(isDefined(var_2e85eeef206ff9f8)) {
      if(var_2e85eeef206ff9f8 == "o0\xee\xc1\x8c") {
        self.walk_and_talk_hemisphere = "o0\xee\xc1\x8c";
      } else {
        assert(var_2e85eeef206ff9f8 == "<dev string:xfae>");
        self.walk_and_talk_hemisphere = "=\xff0b";
      }
    }

    if(!isDefined(target)) {
      self.walk_and_talk_target = level.player;
    } else {
      self.walk_and_talk_target = target;

      if(!isDefined(target.origin)) {
        assertmsg("<dev string:xfb6>");
      }
    }

    return;
  }

  assert(var_87ce5ebbac3505ab == "<dev string:xff6>");
  self._blackboard.walk_and_talk_requested = 0;
}

function enable_eight_point_strafe(isenabled) {
  if(self.type == "\xde\x9d\xa5") {
    return;
  }

  if(isenabled) {
    self._blackboard.eight_point_strafe_requested = 1;
    return;
  }

  assert(isenabled == 0);
  self._blackboard.eight_point_strafe_requested = 0;
}

function enable_readystand() {
  self.busereadyidle = 1;
}

function disable_readystand() {
  self.busereadyidle = undefined;
}

function cqb_aim(the_target) {
  if(!isDefined(the_target)) {
    self.var_f4063498b8306248 = undefined;
    return;
  }

  self.var_f4063498b8306248 = the_target;

  if(!isDefined(the_target.origin)) {
    assertmsg("<dev string:xffd>");
  }
}

function set_force_cover(val) {
  assert(!isDefined(val) || val == 0 || val == 1, "<dev string:x1034>");
  assert(isalive(self), "<dev string:x1056>");

  if(isDefined(val) && val) {
    self.forcesuppression = 1;
    return;
  }

  self.forcesuppression = 0;
}

function first_touch(ent) {
  if(!isDefined(self.touched)) {
    self.touched = [];
  }

  assert(isDefined(ent), "<dev string:x1080>");
  assert(isDefined(ent.unique_id), "<dev string:x1097>");

  if(isDefined(self.touched[ent.unique_id])) {
    return false;
  }

  self.touched[ent.unique_id] = 1;
  return true;
}

function add_hint_string(name, string, optionalfunc, altstate) {
  if(!isDefined(level.trigger_hint_string)) {
    level.trigger_hint_string = [];
    level.trigger_hint_func = [];
    level.var_5b55b010c13afe0a = [];
  }

  assert(isDefined(name), "<dev string:x10af>");
  assert(isDefined(string), "<dev string:x1112>");
  assert(!isDefined(level.trigger_hint_string[name]), "<dev string:x1176>" + name);
  level.trigger_hint_string[name] = string;
  precachestring(string);

  if(isDefined(optionalfunc)) {
    level.trigger_hint_func[name] = optionalfunc;
  }

  if(isDefined(altstate)) {
    level.var_5b55b010c13afe0a[name] = altstate;
  }
}

function function_ab6fdce45f15cb5c(name) {
  if(!isDefined(level.trigger_hint_string)) {
    return false;
  }

  return isDefined(level.trigger_hint_string[name]);
}

function function_9c11ecd37d7f2e81(name, string) {
  if(!isDefined(level.trigger_hint_string)) {
    return 0;
  }

  level.trigger_hint_string[name] = string;
}

function clearthreatbias(group1, group2) {
  setthreatbias(group1, group2, 0);
  setthreatbias(group2, group1, 0);
}

function set_ignoresuppression(val) {
  self.ignoresuppression = val;
}

function set_goalRadius(radius) {
  self.goalradius = radius;
}

function function_38d499ec347c485b(boolean) {
  self.var_4579c2b9c07e3118 = boolean;
}

function set_allowdeath(val) {
  self.allowdeath = val;
}

function set_run_anim(anime, alwaysrunforward) {
  assert(isDefined(anime), "<dev string:x1191>");
  assert(isDefined(self.animname), "<dev string:x11d4>");
  assert(isDefined(level.scr_anim[self.animname][anime]), "<dev string:x120c>");
  demeanor = "\xe3\xd0\xc3e\x85h";
  set_move_anim(demeanor, anime);
  self.run_overrideanim = level.scr_anim[self.animname][anime];
}

function set_move_anim(demeanor, anime) {
  assert(isDefined(anime), "<dev string:x1259>");
  assert(isDefined(self.animname), "<dev string:x129d>");
  assert(isDefined(level.scr_anim[self.animname][anime]), "<dev string:x12d6>");
  asm::asm_setdemeanoranimoverride(demeanor, "\x80[\xb3\x9d", level.scr_anim[self.animname][anime]);
}

function clear_move_anim(demeanor) {
  asm::asm_cleardemeanoranimoverride(demeanor, "\x80[\xb3\x9d");
}

function set_idle_anim(demeanor, anime) {
  assert(isDefined(anime), "<dev string:x1324>");
  assert(isDefined(self.animname), "<dev string:x1368>");
  assert(isDefined(level.scr_anim[self.animname][anime]), "<dev string:x13a1>");
  asm::asm_setdemeanoranimoverride(demeanor, "\x91\x88\xc2*", level.scr_anim[self.animname][anime]);
}

function clear_idle_anim(demeanor) {
  asm::asm_cleardemeanoranimoverride(demeanor, "\x91\x88\xc2*");
}

function set_dog_walk_anim() {
  assert(self.type == "<dev string:x13ef>");
  self.a.movement = "\x82}\xeb\x93";
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.script_nobark = 1;
}

function set_arrival_speed(factor) {
  if(!isDefined(factor)) {
    factor = 1;
  }

  if(isDefined(self.asm.arrivalspeed)) {
    self.asm.arrivalspeed = factor;
    return;
  }

  assertmsg("<dev string:x13f6>");
  return;
}

function clear_arrival_speed() {
  if(isDefined(self.asm.arrivalspeed)) {
    self.asm.arrivalspeed = 1;
  }
}

function override_move_with_purpose(demeanor) {
  assert(isai(self));
  override_anim = asm::asm_lookupanimfromalias("\xca\xaf.\xd5\xf6\xb2\x13\x17S{H\xefl\xe0", "8\x1d)\x8e&\xf0\xb4\xc3\x91\b\xc9\a\x0f(");
  asm::asm_setdemeanoranimoverride(demeanor, "\x80[\xb3\x9d", override_anim);

  if(demeanor == "#yDV,\xd6") {
    thread set_arrival_speed(1.15);
  }
}

function clear_move_with_purpose() {
  thread clear_move_anim(asm::asm_getdemeanor());
  thread clear_arrival_speed();
}

function set_generic_idle_anim(anime) {
  assertmsg("<dev string:x1434>");
}

function clear_generic_idle_anim() {
  self.specialidleanim = undefined;
  self notify("`\xce\x9ewY\x1d\xec\xd6\x061L\xc9M\xacb\xf5");
}

function set_generic_run_anim(anime, alwaysrunforward) {
  set_generic_run_anim_array(anime, undefined, alwaysrunforward);
}

function clear_generic_run_anim() {
  self notify("\xec\xafFgMh`}");
  ai::enable_turnanims();
  self.run_overrideanim = undefined;
  self.walk_overrideanim = undefined;
}

function set_generic_run_anim_array(anime, weights, alwaysrunforward) {
  assert(isDefined(anime), "<dev string:x1478>");
  assert(isDefined(level.scr_anim["<dev string:x14c3>"][anime]), "<dev string:x14ce>");
  assert(!isDefined(weights) || isDefined(level.scr_anim["<dev string:x14c3>"][weights]), "<dev string:x1523>");
  assert(!isDefined(weights) || isarray(level.scr_anim["<dev string:x14c3>"][weights]), "<dev string:x155a>");
  assert(isarray(level.scr_anim["<dev string:x14c3>"][anime]) || !isDefined(weights), "<dev string:x15a1>");
  assert(!isDefined(weights) || level.scr_anim["<dev string:x14c3>"][weights].size == level.scr_anim["<dev string:x14c3>"][anime].size, "<dev string:x15ee>");
  self notify("\xec\xafFgMh`}");

  if(!isDefined(alwaysrunforward) || alwaysrunforward) {
    self.alwaysrunforward = 1;
  } else {
    self.alwaysrunforward = undefined;
  }

  ai::disable_turnanims();
  self.run_overrideanim = level.scr_anim["RF\x9e\xe1\xc4\x1f\xe7"][anime];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(weights)) {
    self.run_override_weights = level.scr_anim["RF\x9e\xe1\xc4\x1f\xe7"][weights];
    self.walk_override_weights = self.run_override_weights;
    return;
  }

  self.run_override_weights = undefined;
  self.walk_override_weights = undefined;
}

function set_run_anim_array(anime, weights, alwaysrunforward) {
  assert(isDefined(anime), "<dev string:x1478>");
  assert(isDefined(self.animname), "<dev string:x11d4>");
  assert(isDefined(level.scr_anim[self.animname][anime]), "<dev string:x120c>");
  self notify("\xec\xafFgMh`}");

  if(!isDefined(alwaysrunforward) || alwaysrunforward) {
    self.alwaysrunforward = 1;
  } else {
    self.alwaysrunforward = undefined;
  }

  ai::disable_turnanims();
  self.run_overrideanim = level.scr_anim[self.animname][anime];
  self.walk_overrideanim = self.run_overrideanim;

  if(isDefined(weights)) {
    self.run_override_weights = level.scr_anim[self.animname][weights];
    self.walk_override_weights = self.run_override_weights;
    return;
  }

  self.run_override_weights = undefined;
  self.walk_override_weights = undefined;
}

function clear_run_anim() {
  self notify("\xefD\x7f(&g3\xa3\xc8\tw\xd0\x90\x95");
  self notify("\xec\xafFgMh`}");

  if(self.type == "\xde\x9d\xa5") {
    self.a.movement = "\x14+`";
    self.disablearrivals = 0;
    self.disableexits = 0;
    self.script_nobark = undefined;
    return;
  }

  demeanor = "\xe3\xd0\xc3e\x85h";
  self.allowstrafe = 1;
  clear_move_anim(demeanor);
  self.run_overrideanim = undefined;
}

function physicsjolt_proximity(outer_radius, inner_radius, force) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd8[.\x1f\xa1\aYl\xdfp\x9a\x1cH\xf7\xe26");

  if(!(isDefined(inner_radius) && isDefined(outer_radius) && isDefined(force))) {
    outer_radius = 400;
    inner_radius = 256;
    force = (0, 0, 0.075);
  }

  fade_distance = outer_radius * outer_radius;
  fade_speed = 3;
  base_force = force;

  while(true) {
    wait 0.1;
    force = base_force;

    if(self.code_classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
      speed = self vehicle_getspeed();

      if(speed < fade_speed) {
        scale = speed / fade_speed;
        force = base_force * scale;
      }
    }

    dist = distancesquared(self.origin, level.player.origin);
    scale = fade_distance / dist;

    if(scale > 1) {
      scale = 1;
    }

    force *= scale;
    total_force = force[0] + force[1] + force[2];

    if(total_force > 0.025) {
      physicsjitter(self.origin, outer_radius, inner_radius, force[2], force[2] * 2);
    }
  }
}

function set_goal_entity(ent) {
  self setgoalentity(ent);
}

function activate_trigger(name, type, triggeringent) {
  if(!isDefined(name)) {
    activate_trigger_process(triggeringent);
    return;
  }

  trigs = getEntArray(name, type);
  assert(trigs.size, "<dev string:x162a>" + type + "<dev string:x1646>" + name);
  utility::array_thread(trigs, &activate_trigger_process, triggeringent);
}

function activate_trigger_process(triggeringent) {
  assert(!isDefined(self.trigger_off), "<dev string:x164c>");
  assert(isent(self), "<dev string:x16bd>");

  if(isDefined(self.script_color_allies)) {
    self.activated_color_trigger = 1;
    colors::activate_color_trigger("O\x15\x1b\xad\x9ff");
  }

  if(isDefined(self.script_color_axis)) {
    self.activated_color_trigger = 1;
    colors::activate_color_trigger("?\xb1\xc0\x9a");
  }

  self notify("\x91`\xb1\xe7T\x97>", triggeringent);
}

function self_delete() {
  self delete();
}

function has_color() {
  if(colors::get_team() == "?\xb1\xc0\x9a") {
    return (isDefined(self.script_color_axis) || isDefined(self.script_forcecolor));
  }

  return isDefined(self.script_color_allies) || isDefined(self.script_forcecolor);
}

function clear_colors() {
  clear_team_colors("?\xb1\xc0\x9a");
  clear_team_colors("O\x15\x1b\xad\x9ff");
}

function clear_team_colors(team) {
  level.currentcolorforced[team]["4"] = undefined;
  level.currentcolorforced[team]["\xde"] = undefined;
  level.currentcolorforced[team]["\xcc"] = undefined;
  level.currentcolorforced[team]["m"] = undefined;
  level.currentcolorforced[team]["N"] = undefined;
  level.currentcolorforced[team]["W"] = undefined;
  level.currentcolorforced[team]["\x97"] = undefined;
}

function notify_delay(snotifystring, fdelay) {
  assert(isDefined(self));
  assert(isDefined(snotifystring));
  assert(isDefined(fdelay));
  self endon("\x1e\xfd\xd1\xa2\a");

  if(fdelay > 0) {
    wait fdelay;
  }

  if(!isDefined(self)) {
    return;
  }

  self notify(snotifystring);
}

function name_hide() {
  assert(isai(self), "<dev string:x16d7>");

  if(!isDefined(self.name)) {
    return;
  }

  self.og_name = self.name;
  self.name = undefined;

  if(isDefined(self.callsign)) {
    self.og_callsign = self.callsign;
    self.callsign = "";
  }
}

function name_show() {
  assert(isai(self), "<dev string:x16d7>");
  assert(isDefined(self.og_name), "<dev string:x16ec>");
  self.name = self.og_name;

  if(isDefined(self.og_callsign)) {
    self.callsign = self.og_callsign;
  }
}

function place_weapon_on(objweapon, location) {
  assert(isai(self));
  assert(isweapon(objweapon));

  if(!utility::aihasweapon(objweapon)) {
    utility::initweapon(objweapon);
  }

  shared::placeweaponon(objweapon, location);
}

function player_moves(dist) {
  org = level.player.origin;

  for(;;) {
    if(distance(org, level.player.origin) > dist) {
      break;
    }

    wait 0.05;
  }
}

function waittill_either_function(func1, parm1, func2, parm2) {
  ent = spawnStruct();
  thread utility_code::waittill_either_function_internal(ent, func1, parm1);
  thread utility_code::waittill_either_function_internal(ent, func2, parm2);
  ent waittill("\x7f5dI");
}

function waittill_msg(msg) {
  self waittill(msg);
}

function in_realism_mode() {
  return isDefined(level.gameskill) && level.gameskill == 4;
}

function display_hint(hint, timeout, delay, endonentities, endonmessages) {
  if(in_realism_mode() || function_2a49223eac045b61()) {
    return;
  }

  assert(isDefined(level.trigger_hint_string), "<dev string:x1734>");
  thread display_hint_proc(hint, timeout, delay, endonentities, endonmessages);
}

function display_hint_forced(hint, timeout, delay, endonentities, endonmessages) {
  assert(isDefined(level.trigger_hint_string), "<dev string:x1734>");
  thread display_hint_proc(hint, timeout, delay, endonentities, endonmessages);
}

function display_hint_proc(hint, timeout, delay, endonentities, endonmessages) {
  if(isDefined(endonentities) && isDefined(endonmessages)) {
    if(!isarray(endonentities)) {
      endonentities = [endonentities];
    }

    if(!isarray(endonmessages)) {
      endonmessages = [endonmessages];
    }

    foreach(entity in endonentities) {
      foreach(message in endonmessages) {
        entity endon(message);
      }
    }
  }

  player = get_player_from_self();
  player endon("\x9e\vH\xbePGv[");

  if(isDefined(level.trigger_hint_func[hint])) {
    player endon("uyEi\xfd\x04\x15m\xa0\x16L\x9e\xb53_\x11\n@f\xcc");
    player childthread display_hint_function_cancel_logic(level.trigger_hint_func[hint]);
  }

  if(istrue(delay)) {
    wait delay;
  }

  if(isDefined(level.trigger_hint_func[hint])) {
    if(player[[level.trigger_hint_func[hint]]]()) {
      return;
    }

    player thread utility_code::hintprint(level.trigger_hint_string[hint], level.trigger_hint_func[hint], timeout, undefined, level.var_5b55b010c13afe0a[hint], endonentities, endonmessages);
    return;
  }

  player thread utility_code::hintprint(level.trigger_hint_string[hint], undefined, timeout, undefined, level.var_5b55b010c13afe0a[hint], endonentities, endonmessages);
}

function display_hint_function_cancel_logic(function) {
  while(true) {
    if([[function]]()) {
      self notify("uyEi\xfd\x04\x15m\xa0\x16L\x9e\xb53_\x11\n@f\xcc");
    }

    waitframe();
  }
}

function getgenericanim(anime) {
  assert(isDefined(level.scr_anim["<dev string:x14c3>"][anime]), "<dev string:x1763>" + anime + "<dev string:x1774>");
  return level.scr_anim["RF\x9e\xe1\xc4\x1f\xe7"][anime];
}

function enable_careful() {
  assert(isai(self), "<dev string:x179c>");
  self.script_careful = 1;
}

function disable_careful() {
  assert(isai(self), "<dev string:x17d9>");
  self.script_careful = 0;
  self notify("\xe6UP\xe4\xccE\x81 \xe0\xfb|h\xde\xea7\xdaXi");
}

function enable_sprint() {
  assert(isai(self), "<dev string:x1818>");
  self.sprint = 1;
  utility::demeanor_override("\x05\xb1\x1c\x86\x11\xc7");
}

function disable_sprint() {
  assert(isai(self), "<dev string:x1854>");
  self.sprint = undefined;
  utility::clear_demeanor_override();
}

function disable_bulletwhizbyreaction() {
  self.disablebulletwhizbyreaction = 1;
}

function enable_bulletwhizbyreaction() {
  self.disablebulletwhizbyreaction = 0;
}

function set_fixednode_true() {
  self.fixednode = 1;
}

function set_fixednode_false() {
  self.fixednode = 0;
}

function spawn_aitype(aitype, origin, angles, forcespawn, perfectenemyinfo, var_beb63ce310f641de, targetname, characterlistname) {
  if(!isDefined(forcespawn)) {
    forcespawn = 0;
  }

  if(!isDefined(perfectenemyinfo)) {
    perfectenemyinfo = 0;
  }

  if(!isDefined(var_beb63ce310f641de)) {
    var_beb63ce310f641de = 1;
  }

  spawned = dospawnaitype(aitype, origin, angles, forcespawn, perfectenemyinfo, var_beb63ce310f641de, undefined, undefined, characterlistname);

  if(isalive(spawned)) {
    if(isDefined(targetname)) {
      spawned.targetname = targetname;
    }

    if(function_7381d086b5710ae7()) {
      spawned.spawner_object = self;
    }

    spawned thread spawner::spawn_think();

    if(!ai::spawn_failed(spawned)) {
      return spawned;
    }
  }

  return undefined;
}

function function_7381d086b5710ae7() {
  if(isstruct(self) && self != level) {
    return true;
  }

  if(isspawner(self)) {
    return true;
  }

  if(self.code_classname == "\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc") {
    return true;
  }

  return false;
}

function spawn_ai(forcespawn, magicbulletshield) {
  if(isDefined(self.script_delay_spawn)) {
    self endon("\x1e\xfd\xd1\xa2\a");
    wait self.script_delay_spawn;
  }

  spawnedguy = undefined;
  var_beb63ce310f641de = isDefined(self.script_stealthgroup) && utility::flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3") && !utility::flag("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
  var_aa058c80e08b7127 = 0;

  if(isDefined(self.script_suspend)) {
    var_aa058c80e08b7127 = spawner::prespawn_suspended_ai();

    if(self.count == 0 && !var_aa058c80e08b7127) {
      return undefined;
    }
  }

  isaispawner = 0;
  forcedspawn = 0;

  if(isDefined(self.script_drone)) {
    spawned = dronespawn(self);
  } else if(istrue(self.script_fakeactor)) {
    spawned = fakeactorspawn(self);
  } else if(isDefined(self.script_bodyonly)) {
    spawned = bodyonlyspawn(self);
  } else {
    isaispawner = 1;

    if(isDefined(self.script_forcespawn) || istrue(forcespawn)) {
      if(isDefined(self.script_char_name)) {
        spawned = self stalingradspawn(var_beb63ce310f641de, "", 0, self.script_char_name);
      } else {
        spawned = self stalingradspawn(var_beb63ce310f641de);
      }

      forcedspawn = 1;
    } else if(isDefined(self.script_forcespawndist) && distancesquared(self.origin, level.player.origin) > squared(self.script_forcespawndist)) {
      if(isDefined(self.script_char_name)) {
        spawned = self stalingradspawn(var_beb63ce310f641de, "", 0, self.script_char_name);
      } else {
        spawned = self stalingradspawn(var_beb63ce310f641de);
      }

      forcedspawn = 1;
    } else if(isDefined(self.script_char_name)) {
      spawned = self dospawn(var_beb63ce310f641de, "", 0, self.script_char_name);
    } else {
      spawned = self dospawn(var_beb63ce310f641de);
    }
  }

  if(isaispawner) {
    if(isDefined(magicbulletshield) && magicbulletshield && isalive(spawned)) {
      spawned ai::magic_bullet_shield();
    }

    if(ai::spawn_failed(spawned)) {
      assert(!(var_aa058c80e08b7127 && isDefined(self.script_aigroup)), "<dev string:x1892>" + self.origin + "<dev string:x18a0>");

      if(!var_aa058c80e08b7127 && isDefined(self.script_aigroup)) {
        spawner::aigroup_decrement(level._ai_group[self.script_aigroup]);
      }

      if(var_aa058c80e08b7127) {
        self.count--;

        if(!isDefined(self.try_og_origin)) {
          if(getunarchiveddebugdvar(@ "hash_38a088b03f78dca1") == "<dev string:x18d3>") {
            print3d(self.origin, "<dev string:x18d8>", (0.8, 0.8, 0.2), 1, 0.5, 200);
            line(level.player.origin, self.origin, (0.8, 0.8, 0.2), 1, 0, 200);
          }

          self.try_og_origin = 1;
          spawned = spawn_ai();
          return spawned;
        } else {
          self.try_og_origin = undefined;
        }
      }

      if(getunarchiveddebugdvar(@ "hash_38a088b03f78dca1") == "<dev string:x18d3>") {
        aiarray = getaispeciesarray("<dev string:x18fd>", "<dev string:x18fd>");
        print3d(self.origin, "<dev string:x1904>" + aiarray.size + "<dev string:x1916>", (0.8, 0.2, 0.2), 1, 0.8, 200);
        line(level.player.origin, self.origin, (0.8, 0.2, 0.2), 1, 0, 200);
      }
    } else if(forcedspawn) {
      if(getunarchiveddebugdvar(@ "hash_38a088b03f78dca1") == "<dev string:x18d3>") {
        origins = [spawned.origin, spawned getEye(), (spawned.origin + spawned getEye()) / 2];
        trace_passed = 0;

        foreach(origin in origins) {
          trace_passed = sighttracepassed(level.player getEye(), origin, 0, [level.player, spawned], 0);

          if(trace_passed) {
            break;
          }
        }

        if(trace_passed) {
          if(isDefined(self.targetname)) {
            println("<dev string:x1921>" + level.player getEye() + "<dev string:x1937>" + self.targetname + "<dev string:x195c>" + self.origin);
          } else if(isDefined(self.script_noteworthy)) {
            println("<dev string:x1921>" + level.player getEye() + "<dev string:x1964>" + self.script_noteworthy + "<dev string:x195c>" + self.origin);
          } else {
            println("<dev string:x1921>" + level.player getEye() + "<dev string:x1990>" + self.origin);
          }

          print3d(self.origin, "<dev string:x19a8>", (0.8, 0.4, 0.2), 1, 0.8, 200);
          line(level.player.origin, self.origin, (0.8, 0.4, 0.2), 1, 0, 200);
        }
      }

    }
  }

  if(isDefined(self.script_spawn_once)) {
    self delete();
  }

  return spawned;
}

function function_stack(func, ...) {
  localentity = spawnStruct();
  localentity thread utility_code::function_stack_proc(self, func, varargcount, vararg);
  return utility_code::function_stack_wait_finish(localentity);
}

function function_stack_timeout(timeout, func, ...) {
  localentity = spawnStruct();
  localentity thread utility_code::function_stack_proc(self, func, varargcount, vararg);

  if(isDefined(localentity.function_stack_func_begun) || localentity utility::waittill_any_timeout(timeout, "tGC|T\r\x7fa_\x13`\x8b|\x8c\x0f\xf7\xc4\xa1#\xef.Sk\x98{") != "\xb5B\xd7\x904}\x11") {
    return utility_code::function_stack_wait_finish(localentity);
  }

  localentity notify("\x1e\xfd\xd1\xa2\a");
  return 0;
}

function function_stack_clear() {
  newstack = [];

  if(isDefined(self.function_stack[0]) && isDefined(self.function_stack[0].function_stack_func_begun)) {
    newstack[0] = self.function_stack[0];
  }

  self.function_stack = undefined;
  self notify("~%\xe2g\xa9\x06\xa5\xf7%G\xf7wA1:\xed\xc6\xfa\x04)");
  waittillframeend();

  if(!newstack.size) {
    return;
  }

  if(!newstack[0].function_stack_func_begun) {
    return;
  }

  self.function_stack = newstack;
}

function set_blur(magnitude, time) {
  setblur(magnitude, time);
}

function set_goal_radius(radius) {
  self.goalradius = radius;
}

function set_goal_height(height) {
  self.goalheight = height;
}

function set_goal_node(node) {
  self.last_set_goalnode = node;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(node);
}

function set_goal_node_targetname(targetname) {
  assert(isDefined(targetname));
  node = getnode(targetname, #targetname);
  assert(isDefined(node));
  set_goal_node(node);
}

function set_goal_pos(origin) {
  self.last_set_goalnode = undefined;
  self.last_set_goalpos = origin;
  self.last_set_goalent = undefined;
  self setgoalpos(origin);
}

function set_goal_ent(target) {
  set_goal_pos(target.origin);
  self.last_set_goalent = target;

  if(isstruct(target) && !isDefined(target.type)) {
    target.type = "\xf7\x9dP\x19 \x9a";
  }
}

function get_spawner_array(name, key) {
  all_spawners = getspawnerarray();
  spawner_array = [];

  if(key == "{no\xb5S.L\xc7\xff\xbe\xc3\x9e\xe2\xf9") {
    foreach(spawner in all_spawners) {
      if(isDefined(spawner.code_classname) && spawner.code_classname == name) {
        spawner_array[spawner_array.size] = spawner;
      }
    }
  } else if(key == "\"\v\xb2aQU6h`") {
    foreach(spawner in all_spawners) {
      if(isDefined(spawner.classname) && spawner.classname == name) {
        spawner_array[spawner_array.size] = spawner;
      }
    }
  } else if(key == "\x7fw*%A\xff") {
    foreach(spawner in all_spawners) {
      if(isDefined(spawner.target) && spawner.target == name) {
        spawner_array[spawner_array.size] = spawner;
      }
    }
  } else if(key == "F\x83\x1c\x9d\x19\xc5\xd7\x13;\xb3\x14n\x18\xf5\x13") {
    foreach(spawner in all_spawners) {
      if(isDefined(spawner.script_linkname) && spawner.script_linkname == name) {
        spawner_array[spawner_array.size] = spawner;
      }
    }
  } else if(key == "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*") {
    foreach(spawner in all_spawners) {
      if(isDefined(spawner.script_noteworthy) && spawner.script_noteworthy == name) {
        spawner_array[spawner_array.size] = spawner;
      }
    }
  } else if(key == "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc") {
    assertmsg("<dev string:x19c0>");
  } else {
    assertmsg("<dev string:x1a1d>", key);
  }

  return spawner_array;
}

function array_spawn(spawners, bforcespawn, var_b1d86b97033a333f, var_94e38bc6d3027ed1) {
  if(!isDefined(var_b1d86b97033a333f)) {
    var_b1d86b97033a333f = 0;
  }

  guys = [];

  foreach(spawner in spawners) {
    spawner.count = 1;

    if(getsubstr(spawner.classname, 7, 10) == "\xbe\x8ec") {
      guy = spawner vehicle::spawn_vehicle();

      if(isDefined(spawner.export)) {
        assert(isalive(guy), "<dev string:x1a50>" + spawner.export+"<dev string:x1a68>");
      } else {
        assert(isalive(guy), "<dev string:x1a7d>" + spawner.origin + "<dev string:x1a68>");
      }

      if(isDefined(guy.target) && !isDefined(guy.script_moveoverride)) {
        guy thread vehicle_paths::gopath();
      }

      guys[guys.size] = guy;
    } else {
      guy = spawner spawn_ai(bforcespawn);

      if(!var_b1d86b97033a333f) {
        assert(isalive(guy), "<dev string:x1a8c>" + spawner.export+"<dev string:x1a68>");
      }

      guys[guys.size] = guy;
    }

    if(istrue(var_94e38bc6d3027ed1)) {
      waitframe();
    }
  }

  if(!var_b1d86b97033a333f) {
    assert(guys.size == spawners.size, "<dev string:x1aa0>");
  }

  return guys;
}

function array_spawn_targetname(targetname, forcespawn, var_b1d86b97033a333f, var_760d8d8a7712386f, var_94e38bc6d3027ed1) {
  spawners = getspawnerarray(targetname);
  spawners = array_merge(spawners, getEntArray(targetname, #targetname));
  assert(spawners.size, "<dev string:x1ac6>" + targetname + "<dev string:x1af2>");
  return array_spawn(spawners, forcespawn, var_b1d86b97033a333f, var_94e38bc6d3027ed1);
}

function array_spawn_noteworthy(noteworthy, forcespawn, var_b1d86b97033a333f, var_760d8d8a7712386f) {
  spawners = get_spawner_array(noteworthy, "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");
  spawners = array_merge(spawners, getEntArray(noteworthy, #script_noteworthy));
  assert(spawners.size, "<dev string:x1b10>" + noteworthy + "<dev string:x1af2>");
  return array_spawn(spawners, forcespawn, var_b1d86b97033a333f);
}

function spawn_script_noteworthy(script_noteworthy, bforcespawn) {
  spawner = getspawner(script_noteworthy, #script_noteworthy);
  assert(isDefined(spawner), "<dev string:x1b43>" + script_noteworthy + "<dev string:x1b66>");
  guy = spawner spawn_ai(bforcespawn);
  return guy;
}

function spawn_targetname(targetname, bforcespawn) {
  spawner = getspawner(targetname, #targetname);
  assert(isDefined(spawner), "<dev string:x1b7a>" + targetname + "<dev string:x1b66>");
  guy = spawner spawn_ai(bforcespawn);
  return guy;
}

function set_grenadeammo(count) {
  self.grenadeammo = count;
}

function get_player_feet_from_view() {
  assert(isPlayer(self));
  tagorigin = self.origin;
  upvec = anglestoup(self getplayerangles());
  height = self getplayerviewheight();
  player_eye = tagorigin + (0, 0, height);
  var_d735fb1fa1c33f8b = tagorigin + upvec * height;
  diff_vec = player_eye - var_d735fb1fa1c33f8b;
  fake_origin = tagorigin + diff_vec;
  return fake_origin;
}

function set_baseaccuracy(val) {
  self.baseaccuracy = val;
}

function get_baseaccuracy() {
  return self.baseaccuracy;
}

function set_attackeraccuracy(val) {
  if(utility::issp() && isPlayer(self)) {
    set_player_attacker_accuracy(val);
    return;
  }

  self.attackeraccuracy = val;
}

function autosave_now(suppress_print) {
  return autosave::_autosave_game_now(suppress_print);
}

function autosave_now_silent() {
  return autosave::_autosave_game_now(1);
}

function function_ac7c6f8b484b5439(suppress_print) {
  self notify("\x15\x1f\xa0S\x10\xabC\x02\x96\xd1*\xfbi\xbe\xe9\b");
  self endon("\x15\x1f\xa0S\x10\xabC\x02\x96\xd1*\xfbi\xbe\xe9\b");
  assert(self == level, "<dev string:x1b96>");
  level.var_39850f92b12d70e0 = 1;
  result = autosave::_autosave_game_now(suppress_print, 0, 1);
  level.var_39850f92b12d70e0 = undefined;
  return result;
}

function set_generic_deathanim(deathanim) {
  self.deathanim = getgenericanim(deathanim);
  self.isdeathanimdefined = 1;
}

function set_dontmelee(bool) {
  self.dontmelee = bool;
}

function putgunaway() {
  shared::placeweaponon(self.weapon, "\r+x5");
  self.weapon = nullweapon();
}

function anim_stopanimScripted() {
  self stopanimScripted();
  self notify("b\xf6+H\xa9\xcc\x10\x940");
  self notify("\xc3\xeeI\xa0;?\xac\x81\x8e?|\xe9\xe4");
}

function antigrav_float_ai_override(bool) {
  assert(isai(self), "<dev string:x1bbf>");
  self.allowantigrav = bool;
}

function antigrav_clear_float_ai_override() {
  assert(isai(self), "<dev string:x1bf2>");
  self.allowantigrav = undefined;
}

function antigrav_disable_nav_obstacle_for_team(team, bool) {
  assert(isDefined(level.antigrav), "<dev string:x1c2b>");

  if(bool) {
    if(!isDefined(level.antigrav.disablenavobstacleteams) || level.antigrav.disablenavobstacleteams.size == 0 || team == "\xc0\xc6J") {
      level.antigrav.disablenavobstacleteams = [];
      level.antigrav.disablenavobstacleteams[0] = team;
    } else if(level.antigrav.disablenavobstacleteams[0] != "\xc0\xc6J") {
      level.antigrav.disablenavobstacleteams = utility::array_combine_unique(level.antigrav.disablenavobstacleteams, [team]);
    }

    return;
  }

  if(!isDefined(level.antigrav.disablenavobstacleteams) || level.antigrav.disablenavobstacleteams.size == 0) {
    return;
  }

  if(team == "\xc0\xc6J") {
    level.antigrav.disablenavobstacleteams = undefined;
    return;
  }

  if(level.antigrav.disablenavobstacleteams[0] == "\xc0\xc6J") {
    level.antigrav.disablenavobstacleteams = [];

    if(team == "O\x15\x1b\xad\x9ff") {
      level.antigrav.disablenavobstacleteams[0] = "?\xb1\xc0\x9a";
    } else {
      level.antigrav.disablenavobstacleteams[0] = "O\x15\x1b\xad\x9ff";
    }

    return;
  }

  level.antigrav.disablenavobstacleteams = utility::array_remove_array(level.antigrav.disablenavobstacleteams, [team]);
}

function kill_wrapper() {
  self enabledeathshield(0);
  self kill();
  return true;
}

function array_wait_match(array, match, message) {
  notifystruct = spawnStruct();

  foreach(element in array) {
    thread array_wait_match_proc(notifystruct, element, match, message);
  }

  for(i = 0; i < array.size; i++) {
    notifystruct waittill("\xf4d\xca\xfb\x14\x06\xb7\xf4\xfc.\xb2\xbe\xcf\xf7s\xc4@aqy\xb9");
  }
}

function array_wait_match_proc(notifystruct, element, match, message) {
  notifystruct endon("\xcaW\x14\x0e\x87\xe2\xbaj\xd27Y\x1c4v\x03\x14N\xb4");
  element waittillmatch(match, message);
  notifystruct notify("\xf4d\xca\xfb\x14\x06\xb7\xf4\xfc.\xb2\xbe\xcf\xf7s\xc4@aqy\xb9");
}

function array_any_wait_match(array, match, message) {
  notifystruct = spawnStruct();

  foreach(element in array) {
    thread array_any_wait_match_proc(notifystruct, element, match, message);
  }

  notifystruct waittill("\xc3\xa2\b>\xe6\xc7=\xfc\xfc\xc1P\x06\xd9/\xa7");
}

function array_any_wait_match_proc(notifystruct, element, match, message) {
  element waittillmatch(match, message);
  notifystruct notify("\xc3\xa2\b>\xe6\xc7=\xfc\xfc\xc1P\x06\xd9/\xa7");
}

function die() {
  self kill((0, 0, 0));
}

function getmodel(str) {
  assert(isDefined(level.scr_model[str]), "<dev string:x1c88>" + str + "<dev string:x1ca7>" + str + "<dev string:x1cc1>");
  return level.scr_model[str];
}

function isads() {
  assert(isPlayer(self));
  return self playerads() > 0.5;
}

function disable_replace_on_death() {
  self.replace_on_death = undefined;
  self notify("\xe7\x9c\x11z\xf9\xad{G\xe0\r\xe9ql\xba\x11ud9He6\xaf");
}

function waittill_player_lookat(dot, timer, dot_only, timeout, ignore_ent, player) {
  if(!isDefined(player)) {
    player = level.player;
  }

  timeoutent = spawnStruct();

  if(isDefined(timeout)) {
    timeoutent thread notify_delay("\xb5B\xd7\x904}\x11", timeout);
  }

  timeoutent endon("\xb5B\xd7\x904}\x11");

  if(!isDefined(dot)) {
    dot = 0.92;
  }

  if(!isDefined(timer)) {
    timer = 0;
  }

  base_time = int(timer * 20);
  count = base_time;
  self endon("\x1e\xfd\xd1\xa2\a");
  ai_guy = isai(self);
  org = undefined;

  for(;;) {
    if(ai_guy) {
      org = self getEye();
    } else {
      org = self.origin;
    }

    if(player player_looking_at(org, dot, dot_only, ignore_ent)) {
      count--;

      if(count <= 0) {
        return 1;
      }
    } else {
      count = base_time;
    }

    wait 0.05;
  }
}

function waittill_player_lookat_for_time(timer, dot, dot_only, ignore_ent) {
  assert(isDefined(timer), "<dev string:x1cd6>");
  waittill_player_lookat(dot, timer, dot_only, undefined, ignore_ent);
}

function player_looking_at(start, dot, dot_only, ignore_ent) {
  if(!isDefined(dot)) {
    dot = 0.8;
  }

  player = get_player_from_self();
  end = player getEye();
  angles = vectortoangles(start - end);
  forward = anglesToForward(angles);
  player_angles = player getplayerangles();
  player_forward = anglesToForward(player_angles);
  new_dot = vectordot(forward, player_forward);

  if(new_dot < dot) {
    return false;
  }

  if(isDefined(dot_only)) {
    assert(dot_only, "<dev string:x1d18>");
    return true;
  }

  return trace::ray_trace_detail_passed(start, end, ignore_ent, trace::create_default_contents(1));
}

function either_player_looking_at(org, dot, dot_only, ignore_ent) {
  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] player_looking_at(org, dot, dot_only, ignore_ent)) {
      return true;
    }
  }

  return false;
}

function point_orientation_relative_to_player(point) {
  player = get_player_from_self();
  angles = vectortoangles(point - player getEye());
  forward = anglesToForward(angles);
  player_angles = player getplayerangles();
  player_forward = anglesToForward(player_angles);
  cross = vectorcross(forward, player_forward);

  if(cross[2] < 0) {
    return "=\xff0b";
  }

  return "o0\xee\xc1\x8c";
}

function players_within_distance(fdist, org) {
  fdistsquared = fdist * fdist;

  for(i = 0; i < level.players.size; i++) {
    if(distancesquared(org, level.players[i].origin) < fdistsquared) {
      return true;
    }
  }

  return false;
}

function ai_delete_when_out_of_sight(ai_array, fdist) {
  if(!isDefined(ai_array)) {
    return;
  }

  var_25a9c3dc51476a9a = 0.75;

  while(ai_array.size > 0) {
    wait 1;

    for(i = 0; i < ai_array.size; i++) {
      if(!isalive(ai_array[i])) {
        ai_array = arrayremove(ai_array, ai_array[i]);
        continue;
      }

      if(players_within_distance(fdist, ai_array[i].origin)) {
        continue;
      }

      if(either_player_looking_at(ai_array[i].origin + (0, 0, 48), var_25a9c3dc51476a9a, 1)) {
        continue;
      }

      if(isDefined(ai_array[i].magic_bullet_shield)) {
        ai_array[i] ai::stop_magic_bullet_shield();
      }

      ai_array[i] delete();
      ai_array = arrayremove(ai_array, ai_array[i]);
    }
  }
}

function add_wait(func, ...) {
  init_waits();

  thread utility_code::add_wait_asserter();

  ent = spawnStruct();
  ent.caller = self;
  ent.func = func;
  ent.parms = vararg;
  ent.parmscount = varargcount;

  if(!isDefined(level.waits.wait_any_func_array)) {
    level.waits.wait_any_func_array = [ent];
    return;
  }

  level.waits.wait_any_func_array[level.waits.wait_any_func_array.size] = ent;
}

function add_abort(func, ...) {
  init_waits();

  thread utility_code::add_wait_asserter();

  ent = spawnStruct();
  ent.caller = self;
  ent.func = func;
  ent.parms = vararg;
  ent.parmscount = varargcount;
  level.waits.abort_wait_any_func_array[level.waits.abort_wait_any_func_array.size] = ent;
}

function add_func(func, ...) {
  init_waits();

  thread utility_code::add_wait_asserter();

  ent = spawnStruct();
  ent.caller = self;
  ent.func = func;
  ent.parms = vararg;
  ent.parmscount = varargcount;
  level.waits.run_func_after_wait_array[level.waits.run_func_after_wait_array.size] = ent;
}

function add_call(func, ...) {
  init_waits();

  thread utility_code::add_wait_asserter();

  ent = spawnStruct();
  ent.caller = self;
  ent.func = func;
  ent.parms = vararg;
  ent.parmscount = varargcount;
  level.waits.run_call_after_wait_array[level.waits.run_call_after_wait_array.size] = ent;
}

function add_noself_call(func, ...) {
  init_waits();

  thread utility_code::add_wait_asserter();

  ent = spawnStruct();
  ent.func = func;
  ent.parms = vararg;
  ent.parmscount = varargcount;
  level.waits.run_noself_call_after_wait_array[level.waits.run_noself_call_after_wait_array.size] = ent;
}

function add_endon(name) {
  init_waits();

  thread utility_code::add_wait_asserter();

  ent = spawnStruct();
  ent.caller = self;
  ent.ender = name;
  level.waits.do_wait_endons_array[level.waits.do_wait_endons_array.size] = ent;
}

function do_wait_any() {
  init_waits();
  assert(isDefined(level.waits.wait_any_func_array), "<dev string:x1d3e>");
  assert(level.waits.wait_any_func_array.size > 0, "<dev string:x1d3e>");
  do_wait(level.waits.wait_any_func_array.size - 1);
}

function do_wait(var_8330474cba580c21) {
  init_waits();

  if(!isDefined(var_8330474cba580c21)) {
    var_8330474cba580c21 = 0;
  }

  level notify("<dev string:x1d73>");

  assert(isDefined(level.waits.wait_any_func_array), "<dev string:x1d3e>");
  ent = spawnStruct();
  array = level.waits.wait_any_func_array;
  endons = level.waits.do_wait_endons_array;
  after_array = level.waits.run_func_after_wait_array;
  call_array = level.waits.run_call_after_wait_array;
  var_344492a0b727e585 = level.waits.run_noself_call_after_wait_array;
  abort_array = level.waits.abort_wait_any_func_array;
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  ent.count = array.size;
  ent utility::array_levelthread(array, &utility_code::waittill_func_ends, endons);
  ent thread utility_code::do_abort(abort_array);
  ent endon("\x95*m(mje|\x1e,\x9c\\\x0f\xac\xd8LU");

  for(;;) {
    if(ent.count <= var_8330474cba580c21) {
      break;
    }

    ent waittill("\xcc\xd57\xc6\xd7\xac\xb9F\xca2");
  }

  ent notify("\x17\xf7\xa28\x06\xb4\\H`\x86/\xf1-\xf2#");
  utility::array_levelthread(after_array, &utility_code::exec_func, []);
  utility::array_levelthread(call_array, &utility_code::exec_call);
  utility::array_levelthread(var_344492a0b727e585, &utility_code::exec_call_noself);
}

function do_funcs() {
  level notify("<dev string:x1d73>");

  assert(isDefined(level.waits.wait_any_func_array), "<dev string:x1d3e>");
  ent = spawnStruct();
  assert(!level.waits.wait_any_func_array.size, "<dev string:x1d8d>");
  assert(!level.waits.do_wait_endons_array.size, "<dev string:x1dba>");
  assert(!level.waits.run_call_after_wait_array.size, "<dev string:x1de8>");
  assert(!level.waits.run_noself_call_after_wait_array.size, "<dev string:x1de8>");
  assert(!level.waits.abort_wait_any_func_array.size, "<dev string:x1e15>");
  after_array = level.waits.run_func_after_wait_array;
  level.waits.run_func_after_wait_array = [];

  foreach(func_struct in after_array) {
    level utility_code::exec_func(func_struct, []);
  }

  ent notify("\x17\xf7\xa28\x06\xb4\\H`\x86/\xf1-\xf2#");
}

function is_default_start() {
  if(isDefined(level.forced_start_catchup) && level.forced_start_catchup == 1) {
    return false;
  }

  if(isDefined(level.default_start_override_alt) && level.default_start_override_alt == level.start_point) {
    return true;
  }

  if(isDefined(level.default_start_override)) {
    if(level.default_start_override == level.start_point) {
      return true;
    }
  } else if(starts::level_has_start_points()) {
    return (level.start_point == level.start_functions[0]["\xf4\x1f\x13\xee"]);
  }

  return level.start_point == "\x91\xca\xcc\v\xab\xd8:";
}

function manual_linkTo(entity, offset) {
  entity endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  for(;;) {
    self.origin = entity.origin + offset;
    self.angles = entity.angles;
    wait 0.05;
  }
}

function nextmission(var_382282fcd89214ce) {
  endmission::nextmission_internal(var_382282fcd89214ce);
}

function nextmission_preload(type, var_e2c8bbdadab97cd4, var_382282fcd89214ce) {
  endmission::nextmission_preload_internal(type, var_e2c8bbdadab97cd4, var_382282fcd89214ce);
}

function nextmission_primeloadbink(var_382282fcd89214ce) {
  endmission::nextmission_primeloadbink_internal(var_382282fcd89214ce);
}

function make_array(index1, index2, index3, index4, index5) {
  assert(isDefined(index1), "<dev string:x1e3c>");
  array = [];
  array[array.size] = index1;

  if(isDefined(index2)) {
    array[array.size] = index2;
  }

  if(isDefined(index3)) {
    array[array.size] = index3;
  }

  if(isDefined(index4)) {
    array[array.size] = index4;
  }

  if(isDefined(index5)) {
    array[array.size] = index5;
  }

  return array;
}

function fail_on_friendly_fire() {
  level.failonfriendlyfire = 1;
}

function normal_friendly_fire_penalty() {
  level.failonfriendlyfire = 0;
}

function getplayerclaymores() {
  assert(isPlayer(self));
  claymorecount = 0;
  heldweapons = self.equippedweapons;

  for(i = 0; i < heldweapons.size; i++) {
    weapon = heldweapons[i];

    if(weapon.basename == "\xb3\xcb\xf0\xc8\xea\x86|>") {
      claymorecount += self getweaponammoclip(weapon);
    }
  }

  return claymorecount;
}

function lerp_saveddvar(name, value, time) {
  curr = getdvarfloat(name);
  level notify(getxhashhexname(name) + "\xfd\xa3\xfcG>\x97\xdf\xc4w\x17CGd\xd4*");
  level endon(getxhashhexname(name) + "\xfd\xa3\xfcG>\x97\xdf\xc4w\x17CGd\xd4*");
  range = value - curr;
  interval = 0.05;
  count = int(time / interval);

  if(count > 0) {
    delta = range / count;

    while(count) {
      curr += delta;
      setsaveddvar(name, curr);
      wait interval;
      count--;
    }
  }

  setsaveddvar(name, value);
}

function lerp_omnvar(name, value, time, round_float) {
  curr = getomnvar(name);
  level notify(getxhashhexname(name) + "\xfd\xa3\xfcG>\x97\xdf\xc4w\x17CGd\xd4*");
  level endon(getxhashhexname(name) + "\xfd\xa3\xfcG>\x97\xdf\xc4w\x17CGd\xd4*");
  range = value - curr;
  interval = 0.05;
  count = int(time / interval);
  delta = range / count;

  while(count) {
    curr += delta;

    if(isDefined(round_float)) {
      round = math::round_float(curr, round_float);
      setomnvar(name, round);
    } else {
      setomnvar(name, curr);
    }

    wait interval;
    count--;
  }

  if(isDefined(round_float)) {
    round = math::round_float(value, round_float);
    setomnvar(name, round);
    return;
  }

  setomnvar(name, value);
}

function lerp_omnvarint(name, value, time) {
  curr = getomnvar(name);
  level notify(getxhashhexname(name) + "\xfd\xa3\xfcG>\x97\xdf\xc4w\x17CGd\xd4*");
  level endon(getxhashhexname(name) + "\xfd\xa3\xfcG>\x97\xdf\xc4w\x17CGd\xd4*");
  range = value - curr;
  interval = 0.05;
  count = int(time / interval);
  delta = range / count;

  while(count) {
    curr += delta;
    setomnvar(name, int(curr));
    wait interval;
    count--;
  }

  setomnvar(name, int(value));
}

function slowmo_setspeed_slow(speed) {
  level.slowmo.speed_slow = speed;
}

function slowmo_setspeed_norm(speed) {
  level.slowmo.speed_norm = speed;
}

function slowmo_setlerptime_in(time) {
  level.slowmo.lerp_time_in = time;
}

function slowmo_setlerptime_out(time) {
  level.slowmo.lerp_time_out = time;
}

function slowmo_lerp_in() {
  if(istrue(level.no_slowmo)) {
    return;
  }

  audio::set_slowmo_dialogue_start();
  function_d3cf69b558d0b04c();
  setslowmotion(level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in);
}

function slowmo_lerp_out() {
  if(istrue(level.no_slowmo)) {
    return;
  }

  function_d3cf69b558d0b04c();
  setslowmotion(level.slowmo.speed_slow, level.slowmo.speed_norm, level.slowmo.lerp_time_out);
  audio::set_slowmo_dialogue_end();
}

function function_712369ee845f814c(slowmoid, targettimescale, transitionseconds) {
  if(!isDefined(level.var_ee7292545ab70ad4)) {
    level.var_ee7292545ab70ad4 = [];
  }

  slowmodata = spawnStruct();
  slowmodata.slowmoid = slowmoid;
  slowmodata.starttimems = gettime();
  slowmodata.targettimescale = targettimescale;
  slowmodata.transitionseconds = transitionseconds;
  var_45bc2bce08995ff = 0;
  startingimmediately = 0;

  for(slowmostackindex = 0; slowmostackindex < level.var_ee7292545ab70ad4.size; slowmostackindex++) {
    if(level.var_ee7292545ab70ad4[slowmostackindex].slowmoid == slowmoid) {
      var_45bc2bce08995ff = 1;
      level.var_ee7292545ab70ad4[slowmostackindex] = slowmodata;

      if(slowmostackindex == level.var_ee7292545ab70ad4.size - 1) {
        setslowmotion(gettimescale(), slowmodata.targettimescale, slowmodata.transitionseconds);
        startingimmediately = 1;
      }

      break;
    }
  }

  if(!var_45bc2bce08995ff) {
    level.var_ee7292545ab70ad4[level.var_ee7292545ab70ad4.size] = slowmodata;
    setslowmotion(gettimescale(), slowmodata.targettimescale, slowmodata.transitionseconds);
    startingimmediately = 1;
  }

  return startingimmediately;
}

function function_2853d8d2bf2b2f5(slowmoid, transitionseconds, var_34db260d98ed9503 = 0.1, var_1c18f79787b56c8 = 1) {
  if(!isDefined(level.var_ee7292545ab70ad4)) {
    level.var_ee7292545ab70ad4 = [];
  }

  var_15ef44aee9721a51 = [];
  var_dbe0e953720710b6 = 0;
  endingimmediately = 0;

  for(slowmostackindex = level.var_ee7292545ab70ad4.size - 1; slowmostackindex >= 0; slowmostackindex--) {
    if(level.var_ee7292545ab70ad4[slowmostackindex].slowmoid == slowmoid) {
      var_dbe0e953720710b6 = 1;

      if(slowmostackindex == level.var_ee7292545ab70ad4.size - 1) {
        var_50e924ec06dd51a0 = slowmostackindex - 1;

        if(var_50e924ec06dd51a0 >= 0) {
          var_c468ec37d977a24c = level.var_ee7292545ab70ad4[var_50e924ec06dd51a0];
          elapsedtimeseconds = (gettime() - var_c468ec37d977a24c.starttimems) * 0.001;
          remainingtransitionseconds = var_c468ec37d977a24c.transitionseconds - elapsedtimeseconds;
          var_55fcaa9a83756595 = max(remainingtransitionseconds, var_34db260d98ed9503);
          setslowmotion(gettimescale(), var_c468ec37d977a24c.targettimescale, var_55fcaa9a83756595);
        } else {
          setslowmotion(gettimescale(), 1, transitionseconds);
          endingimmediately = 1;
        }
      }

      continue;
    }

    var_15ef44aee9721a51[var_15ef44aee9721a51.size] = level.var_ee7292545ab70ad4[slowmostackindex];
  }

  if(var_1c18f79787b56c8) {
    assert(var_dbe0e953720710b6 >= 0, "<dev string:x1e5f>" + slowmoid + "<dev string:x1e8d>");
  }

  level.var_ee7292545ab70ad4 = var_15ef44aee9721a51;
  return endingimmediately;
}

function private function_d3cf69b558d0b04c() {
  if(isDefined(level.var_ee7292545ab70ad4) && level.var_ee7292545ab70ad4.size > 0) {
    existingids = "<dev string:x1ea5>";

    foreach(var_70d621a51e876ec9 in level.var_ee7292545ab70ad4) {
      existingids += "<dev string:x1ea9>" + var_70d621a51e876ec9.slowmoid + "<dev string:x1eae>";
    }

    assertmsg("<dev string:x1eb3>" + level.var_ee7292545ab70ad4.size + "<dev string:x1eee>" + existingids);
  }
}

function add_earthquake(name, mag, duration, radius) {
  level.earthquake[name]["\xa0\x97r\xf8\b\x03\xe0\x14\x1d"] = mag;
  level.earthquake[name]["Xk7\x97O\x91\xb6\xc6"] = duration;
  level.earthquake[name]["\x04\x1f\xf9.\xdbw"] = radius;
}

function get_average_origin(array) {
  origin = (0, 0, 0);

  foreach(member in array) {
    origin += member.origin;
  }

  return origin * 1 / array.size;
}

function function_cd1737ff0205b6f5(array) {
  angles = (0, 0, 0);

  foreach(member in array) {
    angles += member.angles;
  }

  return angles * 1 / array.size;
}

function generic_damage_think() {
  if(!isDefined(self.damage_functions)) {
    self.damage_functions = [];
  }

  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\x169\x95\x1f<\xadN\xee\xe8\xb6\xe2\xd6%>\x81@\xea\xb17\x8b\x15Z\xca;\t");

  for(;;) {
    self waittill("\fU`\xc0y\x95", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon);

    foreach(func in self.damage_functions) {
      thread[[func]](damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon);
    }
  }
}

function add_damage_function(func) {
  if(!isDefined(self.damage_functions)) {
    self.damage_functions = [];
  }

  self.damage_functions[self.damage_functions.size] = func;
}

function function_940ea80ad54d7dc4(func) {
  if(!isDefined(self.damage_functions)) {
    self.damage_functions = [];
  }

  self.damage_functions = utility::function_f2d532fb3f4b0273(self.damage_functions, func);
}

function remove_damage_function(damage_func) {
  new_array = [];

  foreach(func in self.damage_functions) {
    if(func == damage_func) {
      continue;
    }

    new_array[new_array.size] = func;
  }

  self.damage_functions = new_array;
}

function playlocalsoundwrapper(alias) {
  assert(isDefined(alias));
  self playlocalsound(alias);
}

function teleport_player(object) {
  level.player setOrigin(object.origin);

  if(isDefined(object.angles)) {
    level.player setplayerangles(object.angles);
  }
}

function translate_local() {
  entities = [];

  if(isDefined(self.entities)) {
    entities = self.entities;
  }

  if(isDefined(self.entity)) {
    entities[entities.size] = self.entity;
  }

  assert(entities.size > 0, "<dev string:x1f06>");
  utility::array_levelthread(entities, &utility_code::translate_local_on_ent);
}

function open_up_fov(time, player_rig, tag, arcright, arcleft, arctop, arcbottom) {
  level.player endon("\x9b:\xde\x83\xf5{\x0e\xca\xdcK\xe6g\xfa\xcc\xf6\xd9");
  wait time;
  level.player playerlinktodelta(player_rig, tag, 1, arcright, arcleft, arctop, arcbottom, 1);
}

function get_ai_touching_volume(steam, species, var_999d7757ddcdc239) {
  if(!isDefined(steam)) {
    steam = "\xc0\xc6J";
  }

  if(!isDefined(species)) {
    species = "\xc0\xc6J";
  }

  ateam = getaispeciesarray(steam, species);
  var_eb32c6dffcc10fca = [];

  foreach(guy in ateam) {
    assert(isalive(guy), "<dev string:x1f3a>");

    if(guy istouching(self)) {
      var_eb32c6dffcc10fca[var_eb32c6dffcc10fca.size] = guy;
    }
  }

  return var_eb32c6dffcc10fca;
}

function get_drones_touching_volume(steam) {
  if(!isDefined(steam)) {
    steam = "\xc0\xc6J";
  }

  adrones = [];

  if(steam == "\xc0\xc6J") {
    adrones = array_merge(level.drones["O\x15\x1b\xad\x9ff"].array, level.drones["?\xb1\xc0\x9a"].array);
    adrones = array_merge(adrones, level.drones["\xba\xa5\x1f\xc9m\x80i"].array);
  } else {
    adrones = level.drones[steam].array;
  }

  var_959fcf83e23afb29 = [];

  foreach(drone in adrones) {
    if(!isDefined(drone)) {
      continue;
    }

    if(drone istouching(self)) {
      var_959fcf83e23afb29[var_959fcf83e23afb29.size] = drone;
    }
  }

  return var_959fcf83e23afb29;
}

function get_drones_with_targetname(stargetname) {
  adrones = array_merge(level.drones["O\x15\x1b\xad\x9ff"].array, level.drones["?\xb1\xc0\x9a"].array);
  adrones = array_merge(adrones, level.drones["\xba\xa5\x1f\xc9m\x80i"].array);
  var_959fcf83e23afb29 = [];

  foreach(drone in adrones) {
    if(!isDefined(drone)) {
      continue;
    }

    if(isDefined(drone.targetname) && drone.targetname == stargetname) {
      var_959fcf83e23afb29[var_959fcf83e23afb29.size] = drone;
    }
  }

  return var_959fcf83e23afb29;
}

function set_count(count) {
  assert(isDefined(self), "<dev string:x1f5e>");
  assert(!isalive(self), "<dev string:x1f79>");

  self.count = count;
}

function follow_path(node, arrived_at_node_func, var_c5db161e30500c74) {
  self notify("M'Q\x04\b\xb5\xb1\xf4-\xca\xbd%\ans!\xab\xd6zk2");
  self endon("M'Q\x04\b\xb5\xb1\xf4-\xca\xbd%\ans!\xab\xd6zk2");
  self endon("\x1e\xfd\xd1\xa2\a");
  assertmsg("<dev string:x1f8f>");
  oldforcegoal = self.script_forcegoal;
  self.script_forcegoal = 1;
  spawner::go_to_node(node, arrived_at_node_func, var_c5db161e30500c74);
  self.script_forcegoal = oldforcegoal;

  if(!isDefined(self.script_forcegoal) || !self.script_forcegoal) {
    self.goalradius = level.default_goalradius;
  }
}

function enable_dynamic_run_speed(followent, minspeed, midspeed, maxspeed, frontdist, middist, backdist) {
  setdvarifuninitialized(@ "hash_c459efa5216607ee", 0);
  disable_dynamic_run_speed(0);

  if(!isDefined(minspeed)) {
    minspeed = 0;
  }

  if(!isDefined(midspeed)) {
    midspeed = 205;
  }

  if(!isDefined(maxspeed)) {
    maxspeed = 250;
  }

  if(!isDefined(frontdist)) {
    frontdist = 100;
  }

  if(!isDefined(middist)) {
    middist = -100;
  }

  if(!isDefined(backdist)) {
    backdist = -200;
  }

  assert(frontdist > middist, "<dev string:x1fd6>");
  assert(frontdist > backdist, "<dev string:x1fd6>");
  assert(middist > backdist, "<dev string:x1fd6>");
  thread utility_code::dynamic_run_speed_thread(followent, minspeed, midspeed, maxspeed, frontdist, middist, backdist);
}

function disable_dynamic_run_speed(speed) {
  if(getdvarint(@ "hash_c459efa5216607ee")) {
    iprintln("<dev string:x1fff>");
  }

  if(!isDefined(speed)) {
    speed = 165;
  }

  self notify("E\xb1em\\W\xc4zQ\x1f\x8cY\x9f07\xbb\as4r\xe8\xbb");

  if(istrue(speed)) {
    utility::set_movement_speed(speed);
  }
}

function waittill_entity_in_range_or_timeout(entity, range, timeout) {
  self endon("\x1e\xfd\xd1\xa2\a");
  entity endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(timeout)) {
    timeout = 5;
  }

  timeout_time = gettime() + timeout * 1000;

  while(isDefined(entity)) {
    if(distancesquared(entity.origin, self.origin) <= range * range) {
      break;
    }

    if(gettime() > timeout_time) {
      break;
    }

    wait 0.1;
  }
}

function waittill_entity_in_range(entity, range) {
  self endon("\x1e\xfd\xd1\xa2\a");
  entity endon("\x1e\xfd\xd1\xa2\a");

  while(isDefined(entity)) {
    if(distancesquared(entity.origin, self.origin) <= range * range) {
      break;
    }

    wait 0.1;
  }
}

function waittill_entity_out_of_range(entity, range) {
  self endon("\x1e\xfd\xd1\xa2\a");
  entity endon("\x1e\xfd\xd1\xa2\a");

  while(isDefined(entity)) {
    if(distancesquared(entity.origin, self.origin) > range * range) {
      break;
    }

    wait 0.1;
  }
}

function player_speed_percent(percent, time) {
  currspeed = int(getDvar(@ "g_speed"));

  if(!isDefined(level.player.g_speed)) {
    level.player.g_speed = currspeed;
  }

  goalspeed = int(level.player.g_speed * percent * 0.01);
  level.player player_speed_set(goalspeed, time);
}

function player_speed_set(speed, time) {
  currspeed = int(getDvar(@ "g_speed"));

  if(!isDefined(level.player.g_speed)) {
    level.player.g_speed = currspeed;
  }

  get_func = &utility_code::g_speed_get_func;
  set_func = &utility_code::g_speed_set_func;
  level.player thread player_speed_proc(speed, time, get_func, set_func, "\x14!G\xca\xe2\xac\xedV\xcfe\xf9\xcc\xf3\xcb\xd4\x8e");
}

function player_bob_scale_set(scale, time) {
  get_func = &utility_code::g_bob_scale_get_func;
  set_func = &utility_code::g_bob_scale_set_func;
  level.player thread player_speed_proc(scale, time, get_func, set_func, "\x9c\x04\xe6\x0eTua\x9bN8\xc0@g\xac\xf1\xefDX\x06\xbd");
}

function blend_movespeedscale(scale, time, channel) {
  player = self;

  if(!isPlayer(player)) {
    player = level.player;
  }

  if(!isDefined(player.movespeedscale)) {
    player.movespeedscale = 1;
  }

  get_func = &utility_code::movespeed_get_func;
  set_func = &utility_code::movespeed_set_func;
  player thread player_speed_proc(scale, time, get_func, set_func, "`\x11Q\f4A\xdb\x99\xb1\x02\xda\xd6Xi\xd1\x84\xbc\"\x949", channel);
}

function blend_movespeedscale_percent(percent, time, channel) {
  player = self;

  if(!isPlayer(player)) {
    player = level.player;
  }

  if(!isDefined(player.movespeedscale)) {
    player.movespeedscale = 1;
  }

  goalscale = percent * 0.01;
  player blend_movespeedscale(goalscale, time, channel);
}

function player_speed_proc(speed, time, get_func, set_func, ender, channel) {
  self notify(ender);
  self endon(ender);
  currspeed = [[get_func]](channel);
  goalspeed = speed;

  if(isDefined(time) && time > 0) {
    range = goalspeed - currspeed;
    interval = 0.05;
    numcycles = time / interval;
    fraction = range / numcycles;

    while(abs(goalspeed - currspeed) > abs(fraction * 1.1)) {
      currspeed += fraction;
      [[set_func]](currspeed, channel);
      wait interval;
    }
  }

  [[set_func]](goalspeed, channel);
}

function player_speed_default(time) {
  if(!isDefined(level.player.g_speed)) {
    return;
  }

  level.player player_speed_set(level.player.g_speed, time);
  waittillframeend();
  level.player.g_speed = undefined;
}

function blend_movespeedscale_default(time, channel) {
  player = self;

  if(!isPlayer(player)) {
    player = level.player;
  }

  if(!isDefined(player.movespeedscale)) {
    return;
  }

  player blend_movespeedscale(1, time, channel);
  player.movespeedscale = undefined;
}

function teleport_ent(ent) {
  if(isPlayer(self)) {
    self setOrigin(ent.origin);
    self setplayerangles(ent.angles);
    return;
  }

  if(isai(self)) {
    self forceteleport(ent.origin, ent.angles);
    return;
  }

  self.origin = ent.origin;
  self.angles = ent.angles;
}

function teleport_to_ent_tag(ent, tag) {
  position = ent gettagorigin(tag);
  angles = ent gettagangles(tag);
  self dontinterpolate();

  if(isPlayer(self)) {
    self setOrigin(position);
    self setplayerangles(angles);
    return;
  }

  if(isai(self)) {
    self forceteleport(position, angles);
    return;
  }

  self.origin = position;
  self.angles = angles;
}

function teleport_ai(enode) {
  assert(isai(self), "<dev string:x2019>");
  assert(isDefined(enode), "<dev string:x2054>");
  self forceteleport(enode.origin, enode.angles);
  self setgoalpos(self.origin);
  self setgoalnode(enode);
}

function move_all_fx(vec) {
  foreach(fx in level.createfxent) {
    fx.v["\xb0$R\x8b\xc9\x17"] = fx.v["\xb0$R\x8b\xc9\x17"] + vec;
  }
}

function getentwithflag(flag) {
  trigger_classes = trigger::get_load_trigger_classes();
  triggers = [];

  foreach(class, _ in trigger_classes) {
    if(!issubstr(class, "9\x7f\xbb\xbd")) {
      continue;
    }

    other_triggers = getEntArray(class, #classname);
    triggers = utility::array_combine(triggers, other_triggers);
  }

  trigger_funcs = trigger::get_load_trigger_funcs();

  foreach(func, _ in trigger_funcs) {
    if(!issubstr(func, "9\x7f\xbb\xbd")) {
      continue;
    }

    other_triggers = getEntArray(func, #targetname);
    triggers = utility::array_combine(triggers, other_triggers);
  }

  found_trigger = undefined;

  foreach(trigger in triggers) {
    assert(isDefined(trigger.script_flag), "<dev string:xf7e>" + trigger.origin + "<dev string:x208a>");

    if(trigger.script_flag == flag) {
      assert(!isDefined(found_trigger), "<dev string:x20a1>" + flag + "<dev string:x20c0>");
      found_trigger = trigger;
    }
  }

  foreach(trigger in triggers) {
    if(trigger.script_flag == flag) {
      return trigger;
    }
  }
}

function getentarraywithflag(flag) {
  trigger_classes = trigger::get_load_trigger_classes();
  triggers = [];

  foreach(class, _ in trigger_classes) {
    if(!issubstr(class, "9\x7f\xbb\xbd")) {
      continue;
    }

    other_triggers = getEntArray(class, #classname);
    triggers = utility::array_combine(triggers, other_triggers);
  }

  trigger_funcs = trigger::get_load_trigger_funcs();

  foreach(func, _ in trigger_funcs) {
    if(!issubstr(func, "9\x7f\xbb\xbd")) {
      continue;
    }

    other_triggers = getEntArray(func, #targetname);
    triggers = utility::array_combine(triggers, other_triggers);
  }

  found_triggers = [];

  foreach(trigger in triggers) {
    assert(isDefined(trigger.script_flag), "<dev string:xf7e>" + trigger.origin + "<dev string:x208a>");

    if(trigger.script_flag == flag) {
      found_triggers[found_triggers.size] = trigger;
    }
  }

  assert(found_triggers.size, "<dev string:x20ef>" + flag + "<dev string:x2112>");

  if(true) {
    return found_triggers;
  }

  foreach(trigger in triggers) {
    if(trigger.script_flag == flag) {
      found_triggers[found_triggers.size] = trigger;
    }
  }

  return found_triggers;
}

function set_z(vec, z) {
  return (vec[0], vec[1], z);
}

function set_y(vec, y) {
  return (vec[0], y, vec[2]);
}

function set_x(vec, x) {
  return (x, vec[1], vec[2]);
}

function get_rumble_ent(rumble) {
  player = get_player_from_self();

  if(!isDefined(rumble)) {
    rumble = "\x8e\xc3\"\xb2\x80\xe5x\x18\xb1\x96\xebC\xff";
  }

  ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", player getEye());
  ent.intensity = 1;
  ent thread utility_code::update_rumble_intensity(player, rumble);
  return ent;
}

function set_rumble_intensity(intensity) {
  assert(intensity >= 0 && intensity <= 1, "<dev string:x2125>");
  self.intensity = intensity;
}

function rumble_ramp_on(time) {
  thread rumble_ramp_to(1, time);
}

function rumble_ramp_off(time) {
  thread rumble_ramp_to(0, time);
}

function rumble_ramp_to(dest, time) {
  self notify("!\xda4\xc1^K\xb4R");
  self endon("!\xda4\xc1^K\xb4R");
  self endon("\x1e\xfd\xd1\xa2\a");
  frames = time * 20;
  dif = dest - self.intensity;
  slice = dif / frames;

  for(i = 0; i < frames; i++) {
    self.intensity += slice;
    wait 0.05;
  }

  self.intensity = dest;
}

function get_player_from_self() {
  if(isDefined(self)) {
    if(!arraycontains(level.players, self)) {
      return level.player;
    } else {
      return self;
    }

    return;
  }

  return level.player;
}

function get_player_gameskill() {
  assert(isPlayer(self), "<dev string:x214a>");
  return int(self getplayersetting("\x0fh\xd5\f\x13\x04T?\xaf"));
}

function array_delete_evenly(array, delete_size, set_size) {
  assert(delete_size > 0, "<dev string:x2184>");
  assert(set_size > 0, "<dev string:x21a4>");
  assert(delete_size < set_size, "<dev string:x21c7>");
  removal = [];
  delete_size = set_size - delete_size;

  foreach(entry in array) {
    removal[removal.size] = entry;

    if(removal.size == set_size) {
      removal = utility::array_randomize(removal);

      for(i = delete_size; i < removal.size; i++) {
        removal[i] delete();
      }

      removal = [];
    }
  }

  new_array = [];

  foreach(entry in array) {
    if(!isDefined(entry)) {
      continue;
    }

    new_array[new_array.size] = entry;
  }

  return new_array;
}

function waittill_in_range(origin, range, resolution) {
  if(!isDefined(resolution)) {
    resolution = 0.5;
  }

  self endon("\x1e\xfd\xd1\xa2\a");

  while(isDefined(self)) {
    if(distancesquared(origin, self.origin) <= range * range) {
      break;
    }

    wait resolution;
  }
}

function waittill_out_of_range(origin, range, resolution) {
  if(!isDefined(resolution)) {
    resolution = 0.5;
  }

  self endon("\x1e\xfd\xd1\xa2\a");

  while(isDefined(self)) {
    if(distancesquared(origin, self.origin) > range * range) {
      break;
    }

    wait resolution;
  }
}

function enable_surprise() {
  self.newenemyreactiondistsq = squared(512);
}

function getvehiclearray() {
  return vehicle_getarray();
}

function getteamvehiclearray(teams) {
  if(!isarray(teams)) {
    teams[0] = teams;
  }

  vehicles = vehicle_getarray();

  foreach(vehicle in vehicles) {
    if(isDefined(vehicle.team) && arraycontains(teams, vehicle.team)) {
      continue;
    }

    vehicles = arrayremove(vehicles, vehicle);
  }

  return vehicles;
}

function getvehiclearray_in_radius(pos, dist, team) {
  vehicles = utility::get_array_of_closest(pos, vehicle_getarray(), undefined, undefined, dist);

  if(isDefined(team)) {
    temp_array = [];

    foreach(vehicle in vehicles) {
      if(isarray(team)) {
        if(isDefined(vehicle.team) && arraycontains(team, vehicle.team)) {
          temp_array[temp_array.size] = vehicle;
        }

        continue;
      }

      if(vehicle.script_team == team) {
        temp_array[temp_array.size] = vehicle;
      }
    }

    vehicles = temp_array;
  }

  return vehicles;
}

function hint(string, timeout, zoffset) {
  if(!isDefined(zoffset)) {
    zoffset = 0;
  }

  hintfade = 0.5;
  level endon("\xf1\x82\xf0L\xe6.\x1a\xbf\xb9C55\x9d/");

  if(isDefined(level.hintelement)) {
    level.hintelement hud_util::destroyelem();
  }

  level.hintelement = hud_util::createfontstring("\x91\xca\xcc\v\xab\xd8:", 1.5);
  level.hintelement hud_util::setpoint("c\xb9\xed\xf1\x1eP", undefined, 0, 30 + zoffset);
  level.hintelement.color = (1, 1, 1);
  level.hintelement settext(string);
  level.hintelement.alpha = 0;
  level.hintelement fadeovertime(0.5);
  level.hintelement.alpha = 1;
  wait 0.5;
  level.hintelement endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(timeout)) {
    wait timeout;
  } else {
    return;
  }

  level.hintelement fadeovertime(hintfade);
  level.hintelement.alpha = 0;
  wait hintfade;
  level.hintelement hud_util::destroyelem();
}

function hint_fade() {
  hintfade = 1;

  if(isDefined(level.hintelement)) {
    level notify("\xf1\x82\xf0L\xe6.\x1a\xbf\xb9C55\x9d/");
    level.hintelement fadeovertime(hintfade);
    level.hintelement.alpha = 0;
    wait hintfade;
  }
}

function kill_deathflag(theflag, time) {
  if(!isDefined(level.flag[theflag])) {
    return;
  }

  if(!isDefined(time)) {
    time = 0;
  }

  foreach(deathtypes in level.deathflags[theflag]) {
    foreach(element in deathtypes) {
      if(isalive(element)) {
        element thread utility_code::kill_deathflag_proc(time);
        continue;
      }

      element delete();
    }
  }
}

function get_player_view_controller(model, tag, originoffset, turret) {
  if(!isDefined(turret)) {
    turret = "\x18\xd5\x81\x81\xff\xbb]\xe8&W\xddG\x80\xe1`\x0f,\xf7\x82\x95\xfa\xbe";
  }

  if(!isDefined(originoffset)) {
    originoffset = (0, 0, 0);
  }

  origin = model gettagorigin(tag);
  player_view_controller = spawnturret("?\x96%o2\x88V\xd4\x98\a\xdc", origin, turret);
  player_view_controller.angles = model gettagangles(tag);
  player_view_controller setModel("\x8cd\xdc\x11\xbbs\xfen\xc28");
  player_view_controller linkTo(model, tag, originoffset, (0, 0, 0));
  player_view_controller makeunusable();
  player_view_controller hide();
  player_view_controller setmode("\x80Gk\xed2\x17");
  return player_view_controller;
}

function create_blend(func, var1, var2, var3) {
  ent = spawnStruct();
  ent childthread utility_code::process_blend(func, self, var1, var2, var3);
  return ent;
}

function store_players_weapons(scene) {
  if(!isDefined(self.stored_weapons)) {
    self.stored_weapons = [];
  }

  array = [];
  weapons = self getweaponslistall();

  foreach(weapon in weapons) {
    weaponname = getcompleteweaponname(weapon);
    array[weaponname] = [];
    array[weaponname]["\xd8\xa8\xb2\xbdm/B\x16e"] = self getweaponammoclip(weapon, "=\xff0b");
    array[weaponname]["\x0e\\\xba%\x0e\f\x12-\xcd\xe5"] = self getweaponammoclip(weapon, "o0\xee\xc1\x8c");
    array[weaponname]["\xb6|\x1b\xffV"] = self getweaponammostock(weapon);
  }

  if(!isDefined(scene)) {
    scene = "\x91\xca\xcc\v\xab\xd8:";
  }

  self.stored_weapons[scene] = [];
  self.stored_weapons[scene]["\x12\xcfjl\xb4\xf5l\x97\r,7`s]"] = self getcurrentweapon();
  self.stored_weapons[scene]["h#\xddNj\x97]#\xf2"] = array;
}

function restore_players_weapons(scene, immediate) {
  if(!isDefined(scene)) {
    scene = "\x91\xca\xcc\v\xab\xd8:";
  }

  if(!(isDefined(self.stored_weapons) && isDefined(self.stored_weapons[scene]))) {
    println("<dev string:x21f3>" + scene + "<dev string:x2225>");
    return;
  }

  self takeallweapons();

  foreach(weapon, array in self.stored_weapons[scene]["h#\xddNj\x97]#\xf2"]) {
    if(weaponinventorytype(weapon) != "\xf0\n\x7fXb{\xcf") {
      self giveweapon(weapon);
    }

    self setweaponammoclip(weapon, array["\xd8\xa8\xb2\xbdm/B\x16e"], "=\xff0b");
    self setweaponammoclip(weapon, array["\x0e\\\xba%\x0e\f\x12-\xcd\xe5"], "o0\xee\xc1\x8c");
    self setweaponammostock(weapon, array["\xb6|\x1b\xffV"]);
  }

  current_weapon = self.stored_weapons[scene]["\x12\xcfjl\xb4\xf5l\x97\r,7`s]"];

  if(!isnullweapon(current_weapon)) {
    if(istrue(immediate)) {
      self switchtoweaponimmediate(current_weapon);
      return;
    }

    self switchtoweapon(current_weapon);
  }
}

function hide_entity() {
  switch (self.code_classname) {
    case #"hash_3872eb7d97592cac":
    case #"hash_3e0cb1082de9d2a8":
    case #"hash_4af55147c6098215":
      self hide();
      break;
    case #"hash_6318af6067faf262":
      self hide();
      self notsolid();

      if(self.spawnflags & 1) {
        self connectpaths();
      }

      break;
    case #"hash_1b79c5d9e0f9886a":
    case #"hash_56b6f012db0ab679":
    case #"hash_5bb64935d67fde88":
    case #"hash_5e80cefd309127e7":
    case #"hash_747275424b5fb89f":
    case #"hash_8040aa10d9cac1e8":
    case #"hash_8c50f3158618de8d":
    case #"hash_b19df071202be3de":
      utility::trigger_off();
      break;
    default:
      assertmsg("<dev string:x2241>" + self.origin + "<dev string:x225e>" + self.code_classname);
      break;
  }
}

function show_entity() {
  switch (self.code_classname) {
    case #"hash_3872eb7d97592cac":
    case #"hash_3e0cb1082de9d2a8":
    case #"hash_4af55147c6098215":
      self show();
      break;
    case #"hash_6318af6067faf262":
      self show();
      self solid();

      if(self.spawnflags & 1) {
        self disconnectPaths();
      }

      break;
    case #"hash_1b79c5d9e0f9886a":
    case #"hash_56b6f012db0ab679":
    case #"hash_5bb64935d67fde88":
    case #"hash_5e80cefd309127e7":
    case #"hash_747275424b5fb89f":
    case #"hash_8040aa10d9cac1e8":
    case #"hash_8c50f3158618de8d":
    case #"hash_b19df071202be3de":
      utility::trigger_on();
      break;
    default:
      assertmsg("<dev string:x229f>" + self.origin + "<dev string:x225e>" + self.code_classname);
      break;
  }
}

function set_moveplaybackrate(rate, time) {
  self notify("hmL\x83\xd8\xed\xce\xc0:\xac\x19\xfb\xaf-7\x02\xa0\xf5\x06\x80");
  self endon("hmL\x83\xd8\xed\xce\xc0:\xac\x19\xfb\xaf-7\x02\xa0\xf5\x06\x80");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(time)) {
    current_rate = asm::asm_getmoveplaybackrate();
    range = rate - current_rate;
    interval = 0.05;
    numcycles = time / interval;
    fraction = range / numcycles;

    while(abs(rate - current_rate) > abs(fraction * 1.1)) {
      asm::asm_setmoveplaybackrate(current_rate + fraction);
      wait interval;
      current_rate = asm::asm_getmoveplaybackrate();
    }
  }

  asm::asm_setmoveplaybackrate(rate);
}

function array_spawn_function(array, func, ...) {
  assert(isDefined(array), "<dev string:x22bc>");
  assert(isarray(array), "<dev string:x22bc>");
  assert(array.size, "<dev string:x22d4>");

  foreach(spawner in array) {
    assert(isspawner(spawner), "<dev string:x22ec>");
    spawner thread add_spawn_function(func, flat_args(vararg, varargcount));
  }
}

function array_spawn_function_targetname(key, func, ...) {
  array = getspawnerarray(key);
  array = array_merge(array, getEntArray(key, #targetname));
  array_spawn_function(array, func, flat_args(vararg, varargcount));
}

function array_spawn_function_noteworthy(key, func, ...) {
  array = get_spawner_array(key, "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");
  array = array_merge(array, getEntArray(key, #script_noteworthy));
  array_spawn_function(array, func, flat_args(vararg, varargcount));
}

function array_spawn_function_aigroup(key, func, ...) {
  array = get_ai_group_spawners(key);
  array_spawn_function(array, func, flat_args(vararg, varargcount));
}

function enable_dontevershoot() {
  self.dontevershoot = 1;
}

function disable_dontevershoot() {
  self.dontevershoot = 0;
}

function mask_exploders_in_volume(volumes) {
  if(getDvar(@ "createfx") != "") {
    return;
  }

  ents = getEntArray("\x98R*{\x04\xf0G?a\x8d\x94a)T\v\xa8\xac", #classname);
  smodels = getEntArray("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", #classname);

  for(i = 0; i < smodels.size; i++) {
    ents[ents.size] = smodels[i];
  }

  foreach(volume in volumes) {
    foreach(ent in ents) {
      if(isDefined(ent.script_prefab_exploder)) {
        ent.script_exploder = ent.script_prefab_exploder;
      }

      if(!isDefined(ent.script_exploder)) {
        continue;
      }

      if(!isDefined(ent.model)) {
        continue;
      }

      if(ent.code_classname != "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
        continue;
      }

      if(!ent istouching(volume)) {
        continue;
      }

      ent.masked_exploder = 1;
    }
  }
}

function activate_exploders_in_volume() {
  test_org = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));

  foreach(entfx in level.createfxent) {
    if(!isDefined(entfx.v["\x11\xc9g\xc0{\xafI\xe8\b\xd3\xc57y\x97b"])) {
      continue;
    }

    test_org.origin = entfx.v["\xb0$R\x8b\xc9\x17"];
    test_org.angles = entfx.v["\xc5\x94\x82H\x9a`"];

    if(!test_org istouching(self)) {
      continue;
    }

    model_name = entfx.v["\x11\xc9g\xc0{\xafI\xe8\b\xd3\xc57y\x97b"];
    spawnflags = entfx.v["\xcfTs\xe32W\xd4W\xc9\xce\xb0cZ\xb2\xb2\xfc4{1w\xbfT\x90\xb2\x05o"];
    disconnect_paths = entfx.v["-\xa7p\x94\xfc\xb7\x98\xd5Q\x1a\x03\xd1\r\x1c\xcc3\xbe`\xaf\x7f\xcfq{e\x8e\x9b\xba\x87\fK\x9c\xd5\x9e\xd2\xac\x904["];
    new_ent = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", (0, 0, 0), spawnflags);
    new_ent setModel(model_name);
    new_ent.origin = entfx.v["\xb0$R\x8b\xc9\x17"];
    new_ent.angles = entfx.v["\xc5\x94\x82H\x9a`"];
    entfx.v["\x11\xc9g\xc0{\xafI\xe8\b\xd3\xc57y\x97b"] = undefined;
    entfx.v["\xcfTs\xe32W\xd4W\xc9\xce\xb0cZ\xb2\xb2\xfc4{1w\xbfT\x90\xb2\x05o"] = undefined;
    entfx.v["-\xa7p\x94\xfc\xb7\x98\xd5Q\x1a\x03\xd1\r\x1c\xcc3\xbe`\xaf\x7f\xcfq{e\x8e\x9b\xba\x87\fK\x9c\xd5\x9e\xd2\xac\x904["] = undefined;
    new_ent.disconnect_paths = disconnect_paths;
    new_ent.script_exploder = entfx.v["\xac\xe18\xd8\xdb\x8c\x95'"];
    exploder::setup_individual_exploder(new_ent);
    entfx.model = new_ent;
  }

  test_org delete();
}

function delete_destructibles_in_volumes(volumes, dodelayed) {
  foreach(volume in volumes) {
    volume.destructibles = [];
  }

  names = ["*\xe0/~3\b[I=\xd8z\xff\xdb\x9d\xa0R", "\xd9R\xd8\xac\xa0\x04\x7f\xf9\xc3]>\x8e\xc2\xf2R\xc3\xc3]\xc6\x8e"];
  incs = 0;

  if(!isDefined(dodelayed)) {
    dodelayed = 0;
  }

  foreach(name in names) {
    destructible_toy = getEntArray(name, #targetname);

    foreach(toy in destructible_toy) {
      foreach(volume in volumes) {
        if(dodelayed) {
          incs++;
          incs %= 5;

          if(incs == 1) {
            wait 0.05;
          }
        }

        if(!volume istouching(toy)) {
          continue;
        }

        toy delete();
        break;
      }
    }
  }
}

function delete_exploders_in_volumes(volumes, dodelayed) {
  ents = getEntArray("\x98R*{\x04\xf0G?a\x8d\x94a)T\v\xa8\xac", #classname);
  smodels = getEntArray("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", #classname);

  for(i = 0; i < smodels.size; i++) {
    ents[ents.size] = smodels[i];
  }

  delete_ents = [];
  test_org = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
  incs = 0;

  if(!isDefined(dodelayed)) {
    dodelayed = 0;
  }

  foreach(volume in volumes) {
    foreach(ent in ents) {
      if(!isDefined(ent.script_exploder)) {
        continue;
      }

      test_org.origin = ent getorigin();

      if(!volume istouching(test_org)) {
        continue;
      }

      delete_ents[delete_ents.size] = ent;
    }
  }

  utility::array_delete(delete_ents);
  test_org delete();
}

function waittill_volume_dead() {
  for(;;) {
    ai = getaispeciesarray("?\xb1\xc0\x9a", "\xc0\xc6J");
    found_guy = 0;

    foreach(guy in ai) {
      if(!isalive(guy)) {
        continue;
      }

      if(guy istouching(self)) {
        found_guy = 1;
        break;
      }

      wait 0.0125;
    }

    if(!found_guy) {
      ahostiles = get_ai_touching_volume("?\xb1\xc0\x9a");

      if(!ahostiles.size) {
        break;
      }
    }

    wait 0.05;
  }
}

function waittill_volume_dead_or_dying() {
  var_a4a316f60a3e9ff7 = 0;

  for(;;) {
    ai = getaispeciesarray("?\xb1\xc0\x9a", "\xc0\xc6J");
    found_guy = 0;

    foreach(guy in ai) {
      if(!isalive(guy)) {
        continue;
      }

      if(guy istouching(self)) {
        if(guy utility::doinglongdeath()) {
          continue;
        }

        found_guy = 1;
        var_a4a316f60a3e9ff7 = 1;
        break;
      }

      wait 0.0125;
    }

    if(!found_guy) {
      ahostiles = get_ai_touching_volume("?\xb1\xc0\x9a");

      if(!ahostiles.size) {
        break;
      } else {
        var_a4a316f60a3e9ff7 = 1;
      }
    }

    wait 0.05;
  }

  return var_a4a316f60a3e9ff7;
}

function waittill_volume_dead_then_set_flag(sflag) {
  waittill_volume_dead();
  utility::flag_set(sflag);
}

function waittill_targetname_volume_dead_then_set_flag(targetname, msg) {
  volume = getEnt(targetname, #targetname);
  assert(isDefined(volume), "<dev string:x2305>" + targetname);
  volume waittill_volume_dead_then_set_flag(msg);
}

function array_index_by_parameters(old_array) {
  array = [];

  foreach(item in old_array) {
    array[item.script_parameters] = item;
  }

  return array;
}

function array_index_by_classname(old_array) {
  array = [];

  foreach(item in old_array) {
    array[item.classname] = item;
  }

  return array;
}

function array_index_by_script_index(array) {
  newarray = [];

  foreach(ent in array) {
    if(isDefined(ent.script_index)) {
      assert(!isDefined(newarray[ent.script_index]), "<dev string:x2322>" + ent.script_index);
      newarray[ent.script_index] = ent;
    }
  }

  return newarray;
}

function get_color_volume_from_trigger() {
  info = utility_code::get_color_info_from_trigger();
  team = info["\x03\x94=b"];

  foreach(code in info["l\xbdFVs"]) {
    volume = level.arrays_of_colorcoded_volumes[team][code];

    if(isDefined(volume)) {
      return volume;
    }
  }

  return undefined;
}

function get_color_nodes_from_trigger() {
  info = utility_code::get_color_info_from_trigger();
  team = info["\x03\x94=b"];

  foreach(code in info["l\xbdFVs"]) {
    nodes = level.arrays_of_colorcoded_nodes[team][code];

    if(isDefined(nodes)) {
      return nodes;
    }
  }

  return undefined;
}

function get_splineid(targetname) {
  return getcsplineid(targetname);
}

function get_splineidarray(targetname) {
  return getcsplineidarray(targetname);
}

function earthquake_and_rumble(position) {
  playrumbleonposition("R\xd3\xafp\xb0w(\x97]l4rp\x9f", position);
  earthquake(0.4, 0.5, position, 400);
}

function pathrandompercent_set(value) {
  if(!isDefined(self.old_pathrandompercent)) {
    self.old_pathrandompercent = self.pathrandompercent;
  }

  self.pathrandompercent = value;
}

function pathrandompercent_zero() {
  if(isDefined(self.old_pathrandompercent)) {
    return;
  }

  self.old_pathrandompercent = self.pathrandompercent;
  self.pathrandompercent = 0;
}

function pathrandompercent_reset() {
  self.pathrandompercent = self.old_pathrandompercent;
  self.old_pathrandompercent = undefined;
}

function walkdist_zero() {
  if(isDefined(self.old_walkdistfacingmotion)) {
    return;
  }

  self.old_walkdist = self.walkdist;
  self.old_walkdistfacingmotion = self.walkdistfacingmotion;
  self.walkdist = 0;
  self.walkdistfacingmotion = 0;
}

function walkdist_reset() {
  assert(isDefined(self.old_walkdist));
  assert(isDefined(self.old_walkdistfacingmotion));
  self.walkdist = self.old_walkdist;
  self.walkdistfacingmotion = self.old_walkdistfacingmotion;
  self.old_walkdist = undefined;
  self.old_walkdistfacingmotion = undefined;
}

function enable_ignorerandombulletdamage_drone() {
  thread ignorerandombulletdamage_drone_proc();
}

function ignorerandombulletdamage_drone_proc() {
  assert(!issentient(self), "<dev string:x2351>");
  self endon("\xbe\x86\x80\x18\x05\x1d,\xc3\xd1\x8e\x96\xea\xaa([\xf2\x15\xb6\x8e\x8e<\x99\xac\x93\xf9D\x17\xf0t\x12\xd5\xf68{\xd9\xe9gb");
  self endon("\x1e\xfd\xd1\xa2\a");
  self.ignorerandombulletdamage = 1;
  self.fakehealth = self.health;
  self.health = 1000000;

  while(true) {
    self waittill("\fU`\xc0y\x95", damage, attacker);

    if(!isPlayer(attacker) && issentient(attacker)) {
      if(isDefined(attacker.enemy) && attacker.enemy != self) {
        continue;
      }
    }

    self.fakehealth -= damage;

    if(self.fakehealth <= 0) {
      break;
    }
  }

  self kill();
}

function hide_notsolid() {
  if(!isai(self)) {
    self notsolid();
  }

  self hide();
}

function show_solid() {
  if(!isai(self)) {
    self solid();
  }

  self show();
}

function set_brakes(num) {
  self.veh_brake = num;
}

function disable_ignorerandombulletdamage_drone() {
  if(!isalive(self)) {
    return;
  }

  if(!isDefined(self.ignorerandombulletdamage)) {
    return;
  }

  self notify("\xbe\x86\x80\x18\x05\x1d,\xc3\xd1\x8e\x96\xea\xaa([\xf2\x15\xb6\x8e\x8e<\x99\xac\x93\xf9D\x17\xf0t\x12\xd5\xf68{\xd9\xe9gb");
  self.ignorerandombulletdamage = undefined;
  self.health = self.fakehealth;
}

function timeoutent(timeout) {
  ent = spawnStruct();
  ent utility::delaythread(timeout, &utility::send_notify, "\xb5B\xd7\x904}\x11");
  return ent;
}

function delaychildthread(timer, func, ...) {
  childthread utility_code::delaychildthread_proc(func, timer, varargcount, vararg);
}

function flagwaitthread(flag, func, ...) {
  if(!isarray(flag)) {
    flag = [flag, 0];
  }

  thread utility_code::flagwaitthread_proc(func, flag, varargcount, vararg);
}

function waittillthread(note, func, ...) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isarray(note)) {
    note = [note, 0];
  }

  thread utility_code::waittillthread_proc(func, note, varargcount, vararg);
}

function set_group_advance_to_enemy_parameters(interval, group_size) {
  function_a7db65bfca2f2b16(interval);
  function_331f3dbbb69ec67c(group_size);
}

function set_battlechatter_variable(team, val) {
  level.battlechatter[team] = val;
  utility_code::update_battlechatter_hud();
}

function get_minutes_and_seconds(milliseconds) {
  time = [];
  time["\xdfI\xd5vLMi"] = 0;
  time["nV\x1bo\xdcFs"] = int(milliseconds / 1000);

  while(time["nV\x1bo\xdcFs"] >= 60) {
    time["\xdfI\xd5vLMi"]++;
    time["nV\x1bo\xdcFs"] = time["nV\x1bo\xdcFs"] - 60;
  }

  if(time["nV\x1bo\xdcFs"] < 10) {
    time["nV\x1bo\xdcFs"] = "\xfe" + time["nV\x1bo\xdcFs"];
  }

  return time;
}

function player_has_weapon(weap) {
  objweapon = utility::function_3aac010105913843(weap);
  weaponlist = level.player.primaryinventory;

  foreach(weapon in weaponlist) {
    if(issameweapon(weapon, objweapon, 1)) {
      return true;
    }
  }

  return false;
}

function player_has_base_weapon(weap) {
  objweapon = utility::function_3aac010105913843(weap);

  if(!isDefined(objweapon)) {
    return false;
  }

  weaponlist = level.player.primaryinventory;

  foreach(weapon in weaponlist) {
    if(weapon.basenamehash == objweapon.basenamehash) {
      return true;
    }
  }

  return false;
}

function player_has_equipment(weap, includestored) {
  objweapon = utility::function_3aac010105913843(weap);

  if(!isDefined(objweapon)) {
    return false;
  }

  equiplist = level.player.offhandinventory;

  foreach(weapon in equiplist) {
    if(weapon.basename == objweapon.basename) {
      return true;
    }
  }

  return false;
}

function graph_position(v, min_x, min_y, max_x, max_y) {
  rise = max_y - min_y;
  run = max_x - min_x;
  assert(run != 0, "<dev string:x238a>");
  slope = rise / run;
  v -= max_x;
  v = slope * v;
  v += max_y;
  return v;
}

function musiclength(alias) {
  time = lookupsoundlength(alias);
  assert(time > 0, "<dev string:x23d5>" + alias + "<dev string:x23e5>");
  time *= 0.001;
  return time;
}

function is_command_bound(cmd) {
  binding = getkeybinding(cmd);
  return binding[":\xc9\xf3\xb9\x0f"];
}

function template_level(levelname) {
  iprintlnbold("'_C\x8e\x8a\xf4\xa9\xb7n\x89>\x1e\x06w\xb0\n\x13+\xcb\xa6\xd2I\x81(" + levelname + "q\xecEWH\xc3\xf4}ye" + levelname + "\xcf\xc1\xe1\xb6\xb0\xc7.\xaaq\x85V\x8d\x8bh\xd0\x16\xfb\x9d\xdb\f\xee\x1c y\xb7\xcaU\xe2}\x80WI\xdf");
}

function fx_volume_pause_noteworthy(noteworthy, dodelayed) {
  thread fx_volume_pause_noteworthy_thread(noteworthy, dodelayed);
}

function fx_volume_pause_noteworthy_thread(noteworthy, dodelayed) {
  volume = getEnt(noteworthy, #script_noteworthy);
  volume notify("\xe9\xa5\xa6\x80\xa2\xc2#\xa6\xc7?\x9f\xae\x81)\x85\xb6\xd5\xe2");
  volume endon("\xe9\xa5\xa6\x80\xa2\xc2#\xa6\xc7?\x9f\xae\x81)\x85\xb6\xd5\xe2");
  wait 0.05;
  utility_code::fx_volume_pause(volume, dodelayed);
}

function fx_volume_restart_noteworthy(noteworthy) {
  thread fx_volume_restart_noteworthy_thread(noteworthy);
}

function fx_volume_restart_noteworthy_thread(noteworthy) {
  volume = getEnt(noteworthy, #script_noteworthy);
  volume notify("\xe9\xa5\xa6\x80\xa2\xc2#\xa6\xc7?\x9f\xae\x81)\x85\xb6\xd5\xe2");
  volume endon("\xe9\xa5\xa6\x80\xa2\xc2#\xa6\xc7?\x9f\xae\x81)\x85\xb6\xd5\xe2");
  wait 0.05;

  if(!isDefined(volume.fx_paused)) {
    return;
  }

  volume.fx_paused = undefined;
  fx_volume_restart(volume);
}

function fx_volume_restart(volume) {
  assert(isDefined(volume));
  utility::array_thread(volume.fx, &restarteffect);
}

function add_cleanup_ent(ent, groupname) {
  assert(isDefined(ent));
  assert(isDefined(groupname));

  if(!isDefined(level.cleanup_ents)) {
    level.cleanup_ents = [];
  }

  if(!isDefined(level.cleanup_ents[groupname])) {
    level.cleanup_ents[groupname] = [];
  }

  if(arraycontains(level.cleanup_ents[groupname], ent)) {
    assertmsg("<dev string:x23f8>");
  }

  level.cleanup_ents[groupname][level.cleanup_ents[groupname].size] = ent;
}

function cleanup_ents(groupname) {
  assert(isDefined(level.cleanup_ents));
  assert(isDefined(level.cleanup_ents[groupname]));
  array = level.cleanup_ents[groupname];
  array = utility::array_removeundefined(array);
  utility::array_delete(array);
  level.cleanup_ents[groupname] = undefined;
}

function cleanup_ents_removing_bullet_shield(groupname) {
  if(!isDefined(level.cleanup_ents)) {
    return;
  }

  if(!isDefined(level.cleanup_ents[groupname])) {
    return;
  }

  array = level.cleanup_ents[groupname];
  array = utility::array_removeundefined(array);

  foreach(obj in array) {
    if(!isai(obj)) {
      continue;
    }

    if(!isalive(obj)) {
      continue;
    }

    if(!isDefined(obj.magic_bullet_shield)) {
      continue;
    }

    if(!obj.magic_bullet_shield) {
      continue;
    }

    obj ai::stop_magic_bullet_shield();
  }

  utility::array_delete(array);
  level.cleanup_ents[groupname] = undefined;
}

function add_trigger_function(function) {
  if(!isDefined(self.trigger_functions)) {
    thread utility_code::add_trigger_func_thread();
  }

  self.trigger_functions[self.trigger_functions.size] = function;
}

function function_4e44d05215b3ae6c(function) {
  if(!isDefined(self.var_e291e4ca3d7215ab)) {
    thread utility_code::function_61b57876517c1c55();
  }

  self.var_e291e4ca3d7215ab[self.var_e291e4ca3d7215ab.size] = function;
}

function getallweapons() {
  array = [];
  entities = getEntArray();

  foreach(ent in entities) {
    if(!isDefined(ent.classname)) {
      continue;
    }

    if(utility::string_starts_with(ent.classname, "r\x15U\xae\x95\xae\xc3")) {
      array[array.size] = ent;
    }
  }

  return array;
}

function move_with_rate(origin, angles, moverate) {
  assert(isDefined(origin));
  assert(isDefined(angles));
  assert(isDefined(moverate));
  self notify("\x83J\xd4\f,C-");
  self endon("\x83J\xd4\f,C-");

  if(!isDefined(moverate)) {
    moverate = 200;
  }

  dist = distance(self.origin, origin);
  movetime = dist / moverate;
  movevec = vectorNormalize(origin - self.origin);
  self moveTo(origin, movetime, 0, 0);
  self rotateTo(angles, movetime, 0, 0);
  wait movetime;

  if(!isDefined(self)) {
    return;
  }

  self.velocity = movevec * dist / movetime;
}

function flag_on_death(msg) {
  level endon(msg);
  self waittill("\x1e\xfd\xd1\xa2\a");
  utility::flag_set(msg);
}

function enable_damagefeedback() {
  level.damagefeedback = 1;
}

function disable_damagefeedback() {
  level.damagefeedback = 0;
}

function is_damagefeedback_enabled() {
  return isDefined(level.damagefeedback) && level.damagefeedback;
}

function worldtolocalcoords(world_vec) {
  var_316bca081bc941b4 = world_vec - self.origin;
  return (vectordot(var_316bca081bc941b4, anglesToForward(self.angles)), -1 * vectordot(var_316bca081bc941b4, anglestoright(self.angles)), vectordot(var_316bca081bc941b4, anglestoup(self.angles)));
}

function sound_fade_and_delete(fade, is_loop) {
  self scalevolume(0, fade);

  if(istrue(is_loop)) {
    utility::delaycall(fade + 0.05, &stoploopsound);
  } else {
    utility::delaycall(fade + 0.05, &stopsounds);
  }

  utility::delaycall(fade + 0.1, &delete);
}

function sound_fade_in(alias, volume, fade, is_loop) {
  self endon("\x1e\xfd\xd1\xa2\a");
  volume = clamp(volume, 0, 1);
  fade = max(0.05, fade);
  self scalevolume(0);
  wait 0.05;

  if(isDefined(is_loop)) {
    self playLoopSound(alias);
  } else {
    self playSound(alias);
  }

  wait 0.05;
  utility::delaycall(0.05, &scalevolume, volume, fade);
}

function function_445de050d60ca15d(alias, offset, fadein, fadeout) {
  org = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", (0, 0, 0));
  org endon("\x1e\xfd\xd1\xa2\a");
  thread utility::delete_on_death(org);

  if(isDefined(offset)) {
    org.origin = self.origin + offset;
    org.angles = self.angles;
    org linkTo(self);
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linkTo(self);
  }

  if(isDefined(fadein) && fadein > 0) {
    org scalevolume(0);
  }

  org playLoopSound(alias);

  if(isDefined(fadein) && fadein > 0) {
    org scalevolume(1, fadein);
  }

  self waittill("y\x9cO.4\xf5\xb1\x19\xa8\xe1" + alias);

  if(isDefined(fadeout) && fadeout > 0) {
    org scalevolume(0, fadeout);
    wait fadeout;
  }

  org stoploopsound(alias);
  org delete();
}

function intro_screen_create(string1, string2, string3, string4, string5) {
  if(!isDefined(level.introscreen)) {
    level.introscreen = spawnStruct();
  }

  level.introscreen.completed_delay = 3;
  level.introscreen.fade_out_time = 1.5;
  level.introscreen.fade_in_time = undefined;
  level.introscreen.lines = [string1, string2, string3, string4, string5];
  utility::noself_array_call(level.introscreen.lines, &precachestring);
}

function intro_screen_custom_func(function) {
  if(!isDefined(level.introscreen)) {
    level.introscreen = spawnStruct();
  }

  level.introscreen.customfunc = function;
}

function function_a19a0688f9a78a96(var_7738e953ecf649fc) {
  function_fa82d4da898eb6cb(var_7738e953ecf649fc);

  if(!isDefined(level.transient_sets)) {
    level.transient_sets = [];
  } else if(isDefined(level.transient_sets[var_7738e953ecf649fc]) && level.transient_sets[var_7738e953ecf649fc] == 1) {
    return;
  }

  switchtransientset(var_7738e953ecf649fc);
  transient_names = gettransientsinset(var_7738e953ecf649fc);

  foreach(transient in transient_names) {
    while(!istransientloaded(transient)) {
      waitframe();
    }
  }

  foreach(index, item in level.transient_sets) {
    if(index != var_7738e953ecf649fc) {
      level.transient_sets[index] = 0;
    }
  }

  level.transient_sets[var_7738e953ecf649fc] = 1;
}

function function_5303ca0a52637b18(var_7738e953ecf649fc) {
  function_fa82d4da898eb6cb(var_7738e953ecf649fc);

  if(isDefined(level.transient_sets)) {
    if(isDefined(level.transient_sets[var_7738e953ecf649fc])) {
      return level.transient_sets[var_7738e953ecf649fc];
    }
  }

  return 0;
}

function function_44d2074ad687f79a() {
  if(isDefined(level.transient_sets)) {
    foreach(index, item in level.transient_sets) {
      if(level.transient_sets[index] == 1) {
        return index;
      }
    }
  }

  return undefined;
}

function private function_fa82d4da898eb6cb(var_7738e953ecf649fc) {
  names = gettransientsetnames();

  foreach(name in names) {
    if(name == var_7738e953ecf649fc) {
      return 1;
    }
  }

  assertmsg(var_7738e953ecf649fc + "<dev string:x2424>");
}

function transient_load(name) {
  if(istransientloaded(name)) {
    return;
  }

  if(!utility::flag_exist(name + "y\xdc\xd6\xf3\x01\xab\xc9")) {
    utility::flag_init(name + "y\xdc\xd6\xf3\x01\xab\xc9");
  }

  loadtransient(name);

  while(!istransientloaded(name)) {
    waitframe();
  }

  utility::flag_set(name + "y\xdc\xd6\xf3\x01\xab\xc9");
  level notify("\xfb\vn\xf5LoI\xd2\xb7N\xda\xd4\xd7\xb8\xe7\x9b\xe4\xf0,\xa2");
}

function transient_unload(name) {
  if(!istransientloaded(name)) {
    return;
  }

  unloadtransient(name);

  while(istransientloaded(name)) {
    waitframe();
  }

  utility::flag_clear(name + "y\xdc\xd6\xf3\x01\xab\xc9");
}

function transient_load_array(name_array) {
  foreach(name in name_array) {
    thread transient_load(name);
  }

  while(true) {
    alldone = 1;

    foreach(name in name_array) {
      if(!istransientloaded(name)) {
        alldone = 0;
        break;
      }
    }

    if(alldone) {
      break;
    }

    waitframe();
  }

  level notify("\xfb\vn\xf5LoI\xd2\xb7N\xda\xd4\xd7\xb8\xe7\x9b\xe4\xf0,\xa2");
}

function transient_unload_array(name_array) {
  foreach(name in name_array) {
    thread transient_unload(name);
  }

  while(true) {
    alldone = 1;

    foreach(name in name_array) {
      if(istransientloaded(name)) {
        alldone = 0;
        break;
      }
    }

    if(alldone) {
      break;
    }

    waitframe();
  }
}

function function_1ed713c8f3632197(name_array) {
  foreach(name in name_array) {
    settransientvisibility(name, 1);
  }
}

function function_2fe3ca3a7904f6e6(name_array) {
  foreach(name in name_array) {
    settransientvisibility(name, 0);
  }
}

function transient_init(name) {
  assert(!isDefined(level.script), "<dev string:x2445>");
  utility::flag_init(name + "y\xdc\xd6\xf3\x01\xab\xc9");
}

function transient_switch(prev, next) {
  if(utility::flag(prev + "y\xdc\xd6\xf3\x01\xab\xc9")) {
    transient_unload(prev);
  }

  if(!utility::flag(next + "y\xdc\xd6\xf3\x01\xab\xc9")) {
    transient_load(next);
  }
}

function transient_unloadall_and_load(name) {
  unloadalltransients();
  transient_load(name);
}

function follow_path_and_animate(start_node, require_player_dist) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("6\x99\xfcu\x8cz\x04\xc6\f");
  self notify("\x83\xcb\xd4\xd6XoZ\xca)\xadaz\x95\x9e\xcf\xa6\xe2\xf1");
  self notify("\x99\xdbl\xd8\xb7\xdd\xfa\xc1\x16:h");
  self endon("\x99\xdbl\xd8\xb7\xdd\xfa\xc1\x16:h");
  wait 0.1;
  node = start_node;
  getfunc = undefined;
  gotofunc = undefined;

  if(!isDefined(require_player_dist)) {
    require_player_dist = 300;
  }

  self.current_follow_path = node;
  node utility::script_delay();

  while(isDefined(node)) {
    self.current_follow_path = node;

    if(isDefined(node.lookahead)) {
      break;
    }

    if(isDefined(level.struct_class_names["\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc"][node.targetname])) {
      gotofunc = &follow_path_animate_set_struct;
    } else if(isDefined(node.classname)) {
      gotofunc = &follow_path_animate_set_ent;
    } else {
      gotofunc = &follow_path_animate_set_node;
    }

    if(isDefined(node.radius) && node.radius != 0) {
      self.goalradius = node.radius;
    }

    if(self.goalradius < 16) {
      self.goalradius = 16;
    }

    if(isDefined(node.height) && node.height != 0) {
      self.goalheight = node.height;
    }

    original_goalradius = self.goalradius;
    self childthread[[gotofunc]](node);

    if(isDefined(node.animation)) {
      node waittill(node.animation);
    } else {
      while(true) {
        self waittill("\x83\xd6\xaf\x11");

        if(distance(node.origin, self.origin) < original_goalradius + 10 || self.team != "O\x15\x1b\xad\x9ff") {
          break;
        }
      }
    }

    node notify("\x91`\xb1\xe7T\x97>", self);

    if(isDefined(node.script_flag_set)) {
      utility::flag_set(node.script_flag_set);
    }

    if(isDefined(node.script_parameters)) {
      words = strtok(node.script_parameters, "\xda");

      for(i = 0; i < words.size; i++) {
        if(isDefined(level.custom_followpath_parameter_func)) {
          self[[level.custom_followpath_parameter_func]](words[i], node);
        }

        if(self.type == "\xde\x9d\xa5") {
          continue;
        }

        switch (words[i]) {
          case #"hash_493b8f0ecdefe593":
            utility::enable_cqbwalk();
            break;
          case #"hash_4a90998c82aa254a":
            utility::disable_cqbwalk();
            break;
          case #"hash_9843391b4c654860":
            self delete();
            return;
        }
      }
    }

    if(!isDefined(node.script_requires_player) && require_player_dist > 0 && self.team == "O\x15\x1b\xad\x9ff") {
      while(isalive(level.player)) {
        if(follow_path_wait_for_player(node, require_player_dist)) {
          break;
        }

        if(isDefined(node.animation)) {
          self.goalradius = original_goalradius;
          self setgoalpos(self.origin);
        }

        wait 0.05;
      }
    }

    if(!isDefined(node.target)) {
      break;
    }

    if(isDefined(node.script_flag_wait)) {
      utility::flag_wait(node.script_flag_wait);
    }

    if(isDefined(node.script_flag_waitopen)) {
      utility::flag_waitopen(node.script_flag_waitopen);
    }

    node utility::script_delay();
    node = node utility::get_target_ent();
  }

  self notify("\x16\x80!\xb78Wa\xfb7r\b\x85\xc20\xc8\xe5");
}

function follow_path_wait_for_player(node, dist) {
  if(distance(level.player.origin, node.origin) < distance(self.origin, node.origin)) {
    return true;
  }

  vec = undefined;
  vec = anglesToForward(self.angles);
  vec2 = vectorNormalize(level.player.origin - self.origin);

  if(isDefined(node.target)) {
    temp = utility::get_target_ent(node.target);
    vec = vectorNormalize(temp.origin - node.origin);
  } else if(isDefined(node.angles)) {
    vec = anglesToForward(node.angles);
  } else {
    vec = anglesToForward(self.angles);
  }

  if(vectordot(vec, vec2) > 0) {
    return true;
  }

  if(distance(level.player.origin, self.origin) < dist) {
    return true;
  }

  return false;
}

function follow_path_animate_set_node(node) {
  self notify("_\xef!\xc0Uc\x1b+\x99\x90\xcb3\xde*\xfc\x80\x1c7\xc8\x1c");

  if(isDefined(node.animation)) {
    node anim_sp::anim_generic_reach(self, node.animation);
    self notify("\xbao\x9f\xb1\x9e\xc6X+\xa0\x82_3\x9f", node.animation);

    if(isDefined(node.script_parameters) && issubstr(node.script_parameters, "\x1b\x9e\x86\xecr\x97\xa2")) {
      node anim_sp::anim_generic_gravity(self, node.animation);
    } else {
      node animation::anim_generic_run(self, node.animation);
    }

    self setgoalpos(self.origin);
    return;
  }

  set_goal_node(node);
}

function follow_path_animate_set_ent(ent) {
  self notify("_\xef!\xc0Uc\x1b+\x99\x90\xcb3\xde*\xfc\x80\x1c7\xc8\x1c");

  if(isDefined(ent.animation)) {
    ent anim_sp::anim_generic_reach(self, ent.animation);
    self notify("\xbao\x9f\xb1\x9e\xc6X+\xa0\x82_3\x9f", ent.animation);

    if(isDefined(ent.script_parameters) && issubstr(ent.script_parameters, "\x1b\x9e\x86\xecr\x97\xa2")) {
      ent anim_sp::anim_generic_gravity(self, ent.animation);
    } else {
      ent animation::anim_generic_run(self, ent.animation);
    }

    self setgoalpos(self.origin);
    return;
  }

  set_goal_ent(ent);
}

function follow_path_animate_set_struct(struct) {
  self notify("_\xef!\xc0Uc\x1b+\x99\x90\xcb3\xde*\xfc\x80\x1c7\xc8\x1c");

  if(isDefined(struct.animation)) {
    struct anim_sp::anim_generic_reach(self, struct.animation);
    self notify("\xbao\x9f\xb1\x9e\xc6X+\xa0\x82_3\x9f", struct.animation);
    ai::disable_exits();

    if(isDefined(struct.script_parameters) && issubstr(struct.script_parameters, "\x1b\x9e\x86\xecr\x97\xa2")) {
      struct anim_sp::anim_generic_gravity(self, struct.animation);
    } else {
      struct animation::anim_generic_run(self, struct.animation);
    }

    utility::delaythread(0.05, &ai::enable_exits);
    self setgoalpos(self.origin);
    return;
  }

  set_goal_pos(struct.origin);
}

function post_load_precache(function) {
  if(!isDefined(level.post_load_funcs)) {
    level.post_load_funcs = [];
  }

  level.post_load_funcs[level.post_load_funcs.size] = function;
}

function ui_action_slot_force_active_on(slot) {
  dvarname = hashcat(@ "hash_d0d5f7f6113a71e8", slot, "TV]U\xce\x97`;}\x8dv(");
  setDvar(dvarname, "\xb8\"");
}

function ui_action_slot_force_active_off(slot) {
  dvarname = hashcat(@ "hash_d0d5f7f6113a71e8", slot, "TV]U\xce\x97`;}\x8dv(");
  setDvar(dvarname, "t\xea\x9cn\xd7\xf63\x99");
}

function ui_action_slot_force_active_one_time(slot) {
  dvarname = hashcat(@ "hash_d0d5f7f6113a71e8", slot, "TV]U\xce\x97`;}\x8dv(");
  setDvar(dvarname, "\xc02\x17>\x92\x16D");
}

function init_waits() {
  if(!utility::add_init_script("V\xce=\x8c\xda", &init_waits)) {
    return;
  }

  level.waits = spawnStruct();
  level.waits.wait_any_func_array = [];
  level.waits.run_func_after_wait_array = [];
  level.waits.run_call_after_wait_array = [];
  level.waits.run_noself_call_after_wait_array = [];
  level.waits.do_wait_endons_array = [];
  level.waits.abort_wait_any_func_array = [];
}

function set_start_location(val, guys) {
  nodes = [];

  if(isstring(val)) {
    nodes = utility::get_target_array(val);
  } else if(isarray(val)) {
    nodes = val;
  }

  if(nodes.size == 0) {
    return;
  }

  if(!isarray(guys)) {
    guys = [guys];
  }

  foreach(guy in guys) {
    start_node = undefined;

    foreach(node in nodes) {
      if(!isDefined(node.angles)) {
        node.angles = (0, 0, 0);
      }

      if(!isDefined(node.script_noteworthy)) {
        continue;
      }

      if(isDefined(node.taken)) {
        continue;
      }

      if(isPlayer(guy)) {
        if(node.script_noteworthy == "K_p\x84a\x01") {
          start_node = node;
          break;
        }

        continue;
      }

      if(isDefined(guy.script_noteworthy) && guy.script_noteworthy == node.script_noteworthy) {
        start_node = node;
        break;
      }
    }

    if(isDefined(start_node)) {
      start_node.taken = 1;
      guy.start_node = start_node;

      if(isai(guy)) {
        guy setgoalpos(start_node.origin);
      }

      guy teleport_ent(start_node);
    }
  }

  foreach(guy in guys) {
    if(isDefined(guy.start_node)) {
      continue;
    }

    foreach(node in nodes) {
      if(!isDefined(node.taken)) {
        node.taken = 1;
        guy.start_node = node;

        if(isai(guy)) {
          guy setgoalpos(node.origin);
        }

        guy teleport_ent(node);
        break;
      }
    }
  }

  foreach(guy in guys) {
    if(isDefined(guy.start_node)) {
      guy.start_node = undefined;
    }
  }

  foreach(node in nodes) {
    if(isDefined(node.taken)) {
      node.taken = undefined;
    }
  }
}

function kleenex_popup(autosave) {
  println("<dev string:x2473>");
}

function set_nvg_vision(vision, blendtime) {
  level.player nvg_player::set_nvg_vision_proc(vision, blendtime);
}

function set_nvg_light(light) {
  level.player nvg_player::set_nvg_light_proc(light);
}

function set_nvg_flir(enable) {
  level.player nvg_player::set_nvg_flir_proc(enable);
}

function is_flir_vision_on() {
  assert(isPlayer(self), "<dev string:x24ac>");

  if(isDefined(self.nvg) && self.nvg.flir) {
    return 1;
  }

  return 0;
}

function player_gesture_combat(gesturename, lookatent) {
  assert(self == level.player, "<dev string:x24d3>");
  self endon("\x1e\xfd\xd1\xa2\a");
  gestureplayed = 0;
  blendtime = undefined;
  canceltransition = 0;

  if(level.player get_player_demeanor() == " w%\xe0") {
    blendtime = 1;
    canceltransition = 1;
  }

  var_e2f4aeb8ac603f2d = 0;

  if(isDefined(lookatent)) {
    gestureplayed = self playgestureviewmodel(gesturename, lookatent, var_e2f4aeb8ac603f2d, blendtime, undefined);
  } else {
    gestureplayed = self playgestureviewmodel(gesturename, undefined, var_e2f4aeb8ac603f2d, blendtime, undefined);
  }

  return gestureplayed;
}

function player_gesture_noncombat(gesturename, lookatent) {
  assert(self == level.player, "<dev string:x24d3>");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(self isfiring()) {
    return 0;
  }

  if(self isreloading()) {
    return 0;
  }

  return player_gesture_force(gesturename, lookatent);
}

function player_gesture_force(gesturename, lookatent) {
  assert(self == level.player, "<dev string:x24d3>");
  self endon("\x1e\xfd\xd1\xa2\a");
  gestureplayed = 0;
  blendtime = undefined;
  canceltransition = 0;

  if(level.player get_player_demeanor() == " w%\xe0") {
    blendtime = 0.2;
    canceltransition = 1;
  }

  if(isDefined(lookatent) && isent(lookatent)) {
    gestureplayed = self forceplaygestureviewmodel(gesturename, lookatent, blendtime, undefined, undefined);
  } else {
    gestureplayed = self forceplaygestureviewmodel(gesturename, undefined, blendtime, undefined, undefined);
  }

  if(gestureplayed) {
    thread gestures::player_gestures_input_disable(gesturename, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, undefined, "\xd7\xd8\xae\xb6\x0ea\xab");
  }

  return gestureplayed;
}

function get_ai_group_count(aigroup) {
  return level._ai_group[aigroup].spawnercount + level._ai_group[aigroup].aicount;
}

function get_ai_group_sentient_count(aigroup) {
  level._ai_group[aigroup].ai = utility::array_removedead_or_dying(level._ai_group[aigroup].ai);
  level._ai_group[aigroup].ai = utility::array_removeundefined(level._ai_group[aigroup].ai);
  return level._ai_group[aigroup].aicount;
}

function get_ai_group_spawner_count(aigroup) {
  return level._ai_group[aigroup].spawnercount;
}

function get_ai_group_death_count(aigroup) {
  return level._ai_group[aigroup].aideaths;
}

function get_ai_group_spawners(aigroup) {
  return level._ai_group[aigroup].spawners;
}

function get_ai_group_ai(aigroup) {
  level._ai_group[aigroup].ai = utility::array_removedead_or_dying(level._ai_group[aigroup].ai);
  level._ai_group[aigroup].ai = utility::array_removeundefined(level._ai_group[aigroup].ai);
  return level._ai_group[aigroup].ai;
}

function waittill_ai_group_dead(aigroup) {
  while(level._ai_group[aigroup].aicount || level._ai_group[aigroup].spawnercount) {
    wait 0.05;
  }
}

function fx_playontag_safe(fx, tag, delay, end_note, var_e73e272983b63b82) {
  if(!isDefined(self.fx_ticket_queue)) {
    fx_regulate_init();
  }

  thread fx_playontag_safe_internal(fx, tag, delay, end_note, var_e73e272983b63b82);
}

function fx_playontag_safe_internal(fx, tag, delay, end_note, var_e73e272983b63b82) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(isDefined(end_note)) {
    self endon(end_note);
  }

  if(isDefined(delay)) {
    wait delay;
  }

  fx_regulate();

  if(getdvarint(@ "hash_4c2f239edafa91c9")) {
    print3d(self gettagorigin(tag), "<dev string:x250b>" + tag + "<dev string:x2514>" + fx, (0, 1, 0), 1, 0.7, 20);
  }

  if(!isDefined(var_e73e272983b63b82) || !var_e73e272983b63b82) {
    test_tag(tag, fx);
  }

  playFXOnTag(utility::getfx(fx), self, tag);
}

function fx_stopontag_safe(fx, tag, delay, end_note, var_e73e272983b63b82) {
  if(!isDefined(self.fx_ticket_queue)) {
    fx_regulate_init();
  }

  thread fx_stopontag_safe_internal(fx, tag, delay, end_note, var_e73e272983b63b82);
}

function test_tag(tag, fx) {
  if(self.model == "") {
    assertmsg("<dev string:x251d>" + fx + "<dev string:x2538>" + tag + "<dev string:x2546>");
  }

  if(isai(self)) {
    success = 0;
    models = [];

    if(isDefined(self.headmodel) && self.headmodel != "") {
      models[models.size] = self.headmodel;
    }

    if(isDefined(self.hatmodel) && self.hatmodel != "") {
      models[models.size] = self.hatmodel;
    }

    if(!isnullweapon(self.weapon)) {
      models[models.size] = getweaponmodel(self.weapon);
    }

    models[models.size] = self.model;

    foreach(model in models) {
      if(utility::hastag(model, tag)) {
        success = 1;
        break;
      }
    }

    if(!success) {
      assertmsg("<dev string:x251d>" + fx + "<dev string:x2538>" + tag + "<dev string:x256c>" + tag + "<dev string:x257c>" + self.model + "<dev string:x2598>");
    }

    return;
  }

  if(!utility::hastag(self.model, tag)) {
    assertmsg("<dev string:x251d>" + fx + "<dev string:x2538>" + tag + "<dev string:x256c>" + tag + "<dev string:x259d>" + self + "<dev string:x2598>");
  }
}

function fx_stopontag_safe_internal(fx, tag, delay, end_note, var_e73e272983b63b82) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(isDefined(end_note)) {
    self endon(end_note);
  }

  if(isDefined(delay)) {
    wait delay;
  }

  fx_regulate();

  if(!isDefined(var_e73e272983b63b82) || !var_e73e272983b63b82) {
    test_tag(tag, fx);
  }

  stopFXOnTag(utility::getfx(fx), self, tag);
}

function fx_killontag_safe(fx, tag, delay, end_note, var_e73e272983b63b82) {
  if(!isDefined(self.fx_ticket_queue)) {
    fx_regulate_init();
  }

  thread fx_killontag_safe_internal(fx, tag, delay, end_note, var_e73e272983b63b82);
}

function fx_killontag_safe_internal(fx, tag, delay, end_note, var_e73e272983b63b82) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  if(isDefined(end_note)) {
    self endon(end_note);
  }

  if(isDefined(delay)) {
    wait delay;
  }

  fx_regulate();

  if(!isDefined(var_e73e272983b63b82) || !var_e73e272983b63b82) {
    test_tag(tag, fx);
  }

  if(tag == "\xfd\xef\xc3\r\xb4\xad\x84p\x84" && isnullweapon(self.weapon)) {
    println("<dev string:x25bc>");
    return;
  }

  killfxontag(utility::getfx(fx), self, tag);
}

function get_fx_ticket() {
  self.fx_ticket++;
  return utility::string(self.fx_ticket);
}

function fx_regulate_init() {
  if(isDefined(self.fx_ticket_queue)) {
    return;
  }

  self.fx_ticket_queue = [];
  self.fx_ticket = 0;
  thread fx_regulator();
}

function fx_regulator() {
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  i = 0;

  while(true) {
    self waittill("\xab\xac1\xec\\r\x9b/V\x19\xe9");

    while(self.fx_ticket_queue.size > 0) {
      ticket = self.fx_ticket_queue[0];
      self.fx_ticket_queue = arrayremove(self.fx_ticket_queue, ticket);
      self notify(ticket);
      i++;

      if(i == 3) {
        wait 0.05;
        i = 0;
      }
    }
  }
}

function fx_regulate() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  ticket = get_fx_ticket();
  self.fx_ticket_queue[self.fx_ticket_queue.size] = ticket;
  self notify("\xab\xac1\xec\\r\x9b/V\x19\xe9");
  self waittill(ticket);
}

function stop_player_gesture(gesture) {
  assert(self == level.player, "<dev string:x2606>");

  if(isDefined(gesture)) {
    self stopgestureviewmodel(gesture);
  } else {
    self stopgestureviewmodel();
  }

  self notify("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
}

function private function_19747959f88dbd35() {
  if(isDefined(level.demeanors)) {
    return;
  }

  level.demeanors = [];

  if(!isDefined(level.gamemodebundle.campaignsettings)) {
    return;
  }

  campaignsettings = getscriptbundle(level.gamemodebundle.campaignsettings);

  if(isDefined(campaignsettings.demeanors)) {
    foreach(demeanor in campaignsettings.demeanors) {
      assert(!isDefined(level.demeanors[demeanor.name]));
      level.demeanors[demeanor.name] = {
        #supersprint: demeanor.supersprint, #aimassist: demeanor.aimassist, #gesture: demeanor.gesture, #demeanor: demeanor.demeanor ?? "+0a<s,"};
    }
  }
}

function set_player_demeanor(demeanorname) {
  val::set("\x1e&L\x97\xda\x7f\xa0\xce;\x9e\x06\x84\x803\x1e\xf2+un", "(\x15\xda\x106\xed_\x1a", demeanorname);
}

function get_player_demeanor() {
  return level.player getdemeanorviewmodel();
}

function set_player_demeanor_val(demeanorname) {
  thread function_3e96ce7a4449db77(demeanorname);
}

function private function_3e96ce7a4449db77(demeanorname) {
  self notify("e\x1bl1\xd3\xd7\x858\xaa\b\xfd\xc4\xe5\xc0\xb2X");
  self endon("e\x1bl1\xd3\xd7\x858\xaa\b\xfd\xc4\xe5\xc0\xb2X");
  assert(self == level.player, "<dev string:x263d>");
  self notify("I\x023mH\x8c\xbe\a\x7f\xd6\xf7\x188\x1b*\xc0\xf1Z\x83\x90\x80");

  if(!isDefined(self.gestures)) {
    self.gestures = spawnStruct();
  }

  waittillframeend();
  val::reset_all("\xd0\xef$\x7f\xad\x1bL\xb7\x87\xeb\xdd\b\x06\xf1. \t\x90HS\xd3\t\x90");
  demeanor = level.demeanors[demeanorname];

  if(!isDefined(demeanor)) {
    assertmsg("<dev string:x2678>" + demeanorname + "<dev string:x26b6>");
    return;
  }

  gestures::enter_demeanor(demeanor);

  if(!istrue(demeanor.aimassist)) {
    val::set("\xd0\xef$\x7f\xad\x1bL\xb7\x87\xeb\xdd\b\x06\xf1. \t\x90HS\xd3\t\x90", "`2\x15\x97a5\xbc\xe9\f\xc7\xb0qR\x14Fu", 0);
  }

  if(!istrue(demeanor.supersprint)) {
    val::set("\xd0\xef$\x7f\xad\x1bL\xb7\x87\xeb\xdd\b\x06\xf1. \t\x90HS\xd3\t\x90", "\xe7\x1aM\x85+z\x1b\x89\x0fU9", 0);
  }
}

function offhand_demeanor_monitor(demeanor = "+0a<s,", delayafter = 0.5) {
  self notify("\x89A>\x1dm\x89\x92\x03\xcc1]\x81\xe8\xfa\x91");
  self endon("\x89A>\x1dm\x89\x92\x03\xcc1]\x81\xe8\xfa\x91");
  assert(isPlayer(self));
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    if(player isthrowinggrenade()) {
      player val::set("voy\x0f|b.\x9d\xc8\xad\xdc\x8b\f.\xf3Z\xf8\x9a\xba\x11\xa9\x06I}", "(\x15\xda\x106\xed_\x1a", demeanor);

      while(player isthrowinggrenade()) {
        waitframe();
      }

      if(delayafter > 0) {
        wait delayafter;

        if(player isthrowinggrenade()) {
          continue;
        }
      }

      player val::reset_all("voy\x0f|b.\x9d\xc8\xad\xdc\x8b\f.\xf3Z\xf8\x9a\xba\x11\xa9\x06I}");
    }

    waitframe();
  }
}

function init_gravity() {
  if(!isDefined(level.gravity_gameplay)) {
    level.gravity_gameplay = getdvarfloat(@ "bg_gravity");
    level.gravity_physics = getomnvar("j\xd7\x92\x8e\xd7\xb7\x88$\xe5\x8a\xf7\xb8\x93\xb36\x13>");
  }
}

function scale_gravity(gameplay_scale, physics_scale) {
  init_gravity();

  if(isDefined(gameplay_scale)) {
    setsaveddvar(@ "bg_gravity", level.gravity_gameplay * gameplay_scale);
  }

  if(isDefined(physics_scale)) {
    physics_setgravity((0, 0, level.gravity_physics * physics_scale));
  }
}

function atmosphere_enable(enable) {
  if(!isDefined(enable)) {
    enable = 1;
  }

  if(enable && !level.atmosphere) {
    level.atmosphere = enable;
    return;
  }

  if(!enable && level.atmosphere) {
    level.atmosphere = enable;
  }
}

function set_gravity(gameplay_gravity, physics_gravity) {
  init_gravity();

  if(isDefined(gameplay_gravity)) {
    setsaveddvar(@ "bg_gravity", gameplay_gravity);
  }

  if(isDefined(physics_gravity)) {
    physics_setgravity((0, 0, physics_gravity));
  }
}

function reset_gravity() {
  setsaveddvar(@ "bg_gravity", level.gravity_gameplay);
  physics_setgravity((0, 0, level.gravity_physics));
}

function gesture_stop(blendout_time) {
  thread namespace_6ecc19f3ac5deab::ai_gesture_eyes_stop(blendout_time * 0.1);
  thread namespace_6ecc19f3ac5deab::ai_gesture_stop(blendout_time);
  self notify("H\x11\xa6\x1fx\x977\aTQ\t");
  self notify("C\x98\xb4\x13\xbb\x91\xe1\xa5N@\xca\xfc}\xaeu[5\tz\xc1");
  self.playing_gesture = undefined;
}

function gesture_torso_stop(blendout_time) {
  thread namespace_6ecc19f3ac5deab::ai_gesture_torso_stop(blendout_time);
}

function gesture_eyes_stop(blendout_time) {
  thread namespace_6ecc19f3ac5deab::ai_gesture_eyes_stop(blendout_time);
}

function gesture_head_stop(blendout_time) {
  namespace_6ecc19f3ac5deab::ai_gesture_stop(blendout_time);
  self notify("H\x11\xa6\x1fx\x977\aTQ\t");
}

function gesture_follow_lookat(lookat_target, catchup_speed, blend_in_time) {
  self endon("\x1e\xfd\xd1\xa2\a");
  thread namespace_6ecc19f3ac5deab::ai_gesture_lookat(lookat_target, catchup_speed, blend_in_time);
}

function gesture_follow_lookat_natural(lookat_target, catchup_speed, blend_in_time, check_range) {
  thread namespace_6ecc19f3ac5deab::ai_gesture_lookat_natural(lookat_target, catchup_speed, blend_in_time, check_range);
}

function gesture_follow_eyes(lookat_target, catchup_speed, blend_in_time) {
  thread namespace_6ecc19f3ac5deab::ai_gesture_eyes_lookat(lookat_target, catchup_speed, blend_in_time);
}

function gesture_follow_torso(lookat_target, blend_in_time) {
  thread namespace_6ecc19f3ac5deab::ai_gesture_lookat_torso(lookat_target, blend_in_time);
}

function gesture_follow_lookat_update(new_lookat, var_87f6e5f50a805ecd) {
  namespace_6ecc19f3ac5deab::ai_gesture_update_lookat(new_lookat, var_87f6e5f50a805ecd);
}

function gesture_follow_eye_update(new_lookat, var_87f6e5f50a805ecd) {
  namespace_6ecc19f3ac5deab::ai_gesture_update_eyes_lookat(new_lookat, var_87f6e5f50a805ecd);
}

function gesture_point(pointat) {
  namespace_6ecc19f3ac5deab::ai_gesture_point(pointat);
}

function gesture_simple(var_c69880d3de32c7a1) {
  namespace_6ecc19f3ac5deab::ai_gesture_simple(var_c69880d3de32c7a1);
}

function gesture_directional_custom(target, anim_array, partial_bool) {
  namespace_6ecc19f3ac5deab::ai_gesture_directional_custom(target, anim_array, partial_bool);
}

function gesture_custom(gesture_anim, partial_bool) {
  namespace_6ecc19f3ac5deab::ai_custom_gesture(gesture_anim, partial_bool);
}

function gesture_eye_dart_loop(var_111dfb2d5470a12b, use_head) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("H\x11\xa6\x1fx\x977\aTQ\t");
  self endon("c\x96\xa2v?s\xea\xfc\x96\xd8B\xa8\x7f\xeby\xcc");

  if(!isDefined(self.is_eye_tracking)) {
    thread gesture_follow_eyes(var_111dfb2d5470a12b, 4, 0.1);
  }

  if(isDefined(use_head) && use_head) {
    thread gesture_follow_lookat(var_111dfb2d5470a12b, 0.15, 0.7);
  }

  wait 0.7;

  while(true) {
    thread gesture_follow_eye_update(var_111dfb2d5470a12b, 2);
    wait randomfloatrange(3, 5);
    random_target = var_111dfb2d5470a12b getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
    thread gesture_follow_eye_update(random_target, 2);
    wait randomfloatrange(0.25, 0.5);

    if(utility::cointoss()) {
      random_target = var_111dfb2d5470a12b getEye() + (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-2, 2));
      thread gesture_follow_eye_update(random_target, 2);
      wait randomfloatrange(0.25, 0.5);
    }
  }
}

function gesture_simple_when_close(var_c69880d3de32c7a1, dist, dist_target, optional_func) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("oDs\xfc:\x0f\xc9#\x91\xcc\xd0\xa4");
  dist_to = squared(dist);
  interaction_manager::add_actor_to_manager();
  dist_from = distance2dsquared(self.origin, dist_target.origin);

  while(true) {
    if(dist_from < dist_to && interaction_manager::can_play_nearby_gesture(dist * 3)) {
      break;
    }

    dist_from = distance2dsquared(self.origin, dist_target.origin);
    waitframe();
  }

  self.playing_gesture = 1;

  if(isDefined(optional_func)) {
    thread gesture_simple(var_c69880d3de32c7a1);
    self[[optional_func]]();
  } else {
    gesture_simple(var_c69880d3de32c7a1);
  }

  wait 2;
  interaction_manager::remove_actor_from_manager();
  self.playing_gesture = 0;
}

function get_direction_value(viewerangles, viewerorigin, targetorigin) {
  anglestopoint = vectortoangles(targetorigin - viewerorigin);
  angle = viewerangles[1] - anglestopoint[1];
  angle += 360;
  angle = int(angle) % 360;

  if(angle > 350 || angle < 10) {
    direction = "\f";
  } else if(angle < 60) {
    direction = "i";
  } else if(angle < 120) {
    direction = "\xbb";
  } else if(angle < 150) {
    direction = "?";
  } else if(angle < 210) {
    direction = "\x19";
  } else if(angle < 240) {
    direction = "\x87";
  } else if(angle < 300) {
    direction = "P";
  } else {
    direction = "{";
  }

  return direction;
}

function give_melee_weapon(weapon) {
  take_melee_weapon();
  self giveweapon(weapon);
  self assignweaponmeleeslot(weapon);
}

function take_melee_weapon() {
  meleeweapons = self.meleeweapons;

  foreach(meleeweapon in meleeweapons) {
    self takeweapon(meleeweapon);
  }
}

function give_offhand(weapon, var_b35b4d8a1ef2ed84, additional_attachments) {
  if(isPlayer(self)) {
    player_sp::offhandswap(weapon, var_b35b4d8a1ef2ed84, additional_attachments);
    return;
  }

  assertmsg("<dev string:x26bc>");
}

function take_offhand(weapon) {
  if(isPlayer(self)) {
    player_sp::offhandremove(weapon);
    return;
  }

  assertmsg("<dev string:x26bc>");
}

function get_melee_weapon() {
  meleeweapons = self.meleeweapons;

  foreach(meleeweapon in meleeweapons) {
    if(!isnullweapon(meleeweapon)) {
      return meleeweapon;
    }
  }

  return undefined;
}

function give_action_slot_weapon(objweapon) {
  assert(isweapon(objweapon));
  self.actionslotweapon = objweapon;
  self giveweapon(objweapon);

  if(val::get("\xc2\xb4B\x81\a\xba|>M\xf8\x87\x04@n\xddy\a_")) {
    self setactionslot(1, "\xe5\x06\xb0\bE\x16", objweapon);
  }
}

function take_action_slot_weapon() {
  self setactionslot(1, "");
  self takeweapon(self.actionslotweapon);
  self.actionslotweapon = undefined;
}

function get_action_slot_weapon() {
  if(isDefined(self.actionslotweapon)) {
    return self.actionslotweapon;
  }

  return "";
}

function get_weapons_list_primaries(var_ae7f9048dc90a69f, includemeleeweapon) {
  primaryweapons = level.player.primaryweapons;

  if(isDefined(var_ae7f9048dc90a69f) && var_ae7f9048dc90a69f == 1) {
    primaryweapons = utility::array_combine(primaryweapons, level.player.alternateweapons);
  }

  filteredweapons = [];
  meleeweapon = level.player get_melee_weapon();

  if(isDefined(meleeweapon) && (!isDefined(includemeleeweapon) || includemeleeweapon == 0)) {
    foreach(weapon in primaryweapons) {
      if(weapon != meleeweapon) {
        filteredweapons[filteredweapons.size] = weapon;
      }
    }
  } else {
    filteredweapons = primaryweapons;
  }

  return filteredweapons;
}

function is_primary_equipment_button_down() {
  return utility::flag("\xe3\x98\xd4dv\xa0\xf0\x91\x1e\xb8\xb7\x84EN\x9fa\xa9cX\xceF\xd6OD\x0f8\xeb\t");
}

function wait_primary_equipment_button_up() {
  utility::flag_waitopen("\xe3\x98\xd4dv\xa0\xf0\x91\x1e\xb8\xb7\x84EN\x9fa\xa9cX\xceF\xd6OD\x0f8\xeb\t");
}

function wait_primary_equipment_button_down() {
  utility::flag_wait("\xe3\x98\xd4dv\xa0\xf0\x91\x1e\xb8\xb7\x84EN\x9fa\xa9cX\xceF\xd6OD\x0f8\xeb\t");
}

function wait_primary_equipment_button_pressed() {
  self waittill("\xd2\xd7\xcd\x8e~\xb3\x8f\x1aNi\x0f~q\xab\xa8\xb9=\xebX\v(o\xbbgt");
  utility::flag_wait("\xe3\x98\xd4dv\xa0\xf0\x91\x1e\xb8\xb7\x84EN\x9fa\xa9cX\xceF\xd6OD\x0f8\xeb\t");
}

function is_primary_equipment_in_use() {
  return utility::flag("lkl\x82\xd8\x8b\x9e\x98H3\xe59ZB\xf5g\xe3{\xe3\x9a\x99\x91\xf68");
}

function is_secondary_equipment_button_down() {
  return utility::flag("P\x8e2@\xc0\xb5A\fT1\xa59\x80`,\xac\xe4\xd0\x8c\xd1\xf9\xcd\xc97<\xb0\x95\xca\xa0\\");
}

function wait_secondary_equipment_button_up() {
  utility::flag_waitopen("P\x8e2@\xc0\xb5A\fT1\xa59\x80`,\xac\xe4\xd0\x8c\xd1\xf9\xcd\xc97<\xb0\x95\xca\xa0\\");
}

function wait_secondary_equipment_button_down() {
  utility::flag_wait("P\x8e2@\xc0\xb5A\fT1\xa59\x80`,\xac\xe4\xd0\x8c\xd1\xf9\xcd\xc97<\xb0\x95\xca\xa0\\");
}

function wait_secondary_equipment_button_pressed() {
  self waittill("\xfe\x13\xb3\xeb\xb4\x12\xbb\x92\x11\xe0\x19\x1f\xba\x101\xf9}8\x9e\xbc\xc1\xaft4\x80E\xce");
  utility::flag_wait("P\x8e2@\xc0\xb5A\fT1\xa59\x80`,\xac\xe4\xd0\x8c\xd1\xf9\xcd\xc97<\xb0\x95\xca\xa0\\");
}

function is_secondary_equipment_in_use() {
  return utility::flag("\xb9Y\x8d\xde7#\x85N/\xaf\xb2\xe2\xd5K\x83k\xca\xcd\x8e\xbeK7_\xea\xb9\xac");
}

function get_primary_equipment() {
  return undefined;
}

function get_primary_equipment_ammo() {
  return false;
}

function get_secondary_equipment() {
  return undefined;
}

function get_secondary_equipment_ammo() {
  return false;
}

function get_stored_primary_equipment() {
  return undefined;
}

function get_stored_primary_equipment_ammo() {
  return true;
}

function get_stored_secondary_equipment() {
  return undefined;
}

function get_stored_secondary_equipment_ammo() {
  return true;
}

function get_equipment_ammo(checkedequipment) {
  equipmentfuncs = [ &get_primary_equipment, &get_stored_primary_equipment, &get_secondary_equipment, &get_stored_secondary_equipment];
  ammofuncs = [ &get_primary_equipment_ammo, &get_stored_primary_equipment_ammo, &get_secondary_equipment_ammo, &get_stored_secondary_equipment_ammo];

  for(x = 0; x < equipmentfuncs.size; x++) {
    equipment = [[equipmentfuncs[x]]]();
    ammo = [[ammofuncs[x]]]();

    if(isDefined(equipment) && equipment == checkedequipment) {
      return ammo;
    }
  }
}

function get_corpse_origin() {
  if(getdvarint(@ "ai_corpsesynch") && isactorcorpse(self)) {
    return self getcorpsephysicsorigin();
  }

  return self.origin;
}

function hudoutline_add_channel(channelname, priority, hudoutlinesettings) {
  outline::hudoutline_add_channel_internal(channelname, priority, hudoutlinesettings);
}

function hudoutline_add_child_channel(channelname, priority, parentchannelname) {
  outline::hudoutline_add_child_channel_internal(channelname, priority, parentchannelname);
}

function hudoutline_force_channel(channelname, shouldforce) {
  outline::hudoutline_force_channel_internal(channelname, shouldforce);
}

function hudoutline_enable_new(hudoutlineasset, channelname) {
  outline::hudoutline_enable_internal(channelname, hudoutlineasset);
}

function hudoutline_enable(color_index, depth_enable, fill_enable, channelname) {
  outline::hudoutline_enable_internal(channelname, "\x83i\xec\xf4\xe9\xdc}7\xee\xd4/!Jk\xe4!\xa5");
}

function hudoutline_disable(channelname) {
  outline::hudoutline_disable_internal(channelname);
}

function hudoutline_channel_animation(channelname, animationfunc) {
  outline::play_animation_on_channel(channelname, animationfunc);
  level notify("\xea\x10\x0e\xc6Tm\xedI^\b\xa2=\xd4\rl\xdd\xe3x<\xb5\xe5/\x8dU");
  level notify("\xea\x10\x0e\xc6Tm\xedI^\b\xa2=\xd4\rl\xdd\xe3x<\xb5\xe5/\x8dU" + channelname);
}

function hudoutline_channel_animation_loop(channelname, animationfunc) {
  thread outline::play_animation_on_channel_loop(channelname, animationfunc);
}

function hudoutline_vis_enemy_settings(var_fd27187ddb508547) {
  if(!isDefined(var_fd27187ddb508547)) {
    var_fd27187ddb508547 = 1;
  }

  setsaveddvar(@ "r_hudoutlineenable", 1);
  fillcolor0 = ".\xf8\r\x05\x8fW\xbe\xe3\xbe\x188";
  fillcolor1 = "\\\xa7v'\x8b";

  if(var_fd27187ddb508547) {
    fillcolor0 = "\x82f4\xba\xe32[\xc0\x84\x8ai\xaa~";
    fillcolor1 = "\x03\xe2S\b\xc0\x17\xd4 \x06\xb8\xd4\x80\x06.d";
    occludedoutline = "\x82f4\xba\xe32[\xc0\x84\x8ai\xaa~";
    occludedgraph = "\xe2\x1a\x19j\x12J\x1d\x01 \xa3^^j";
    occludedfill = "\x82f4\xba\xe32[\xc0\x84\x8ai\xaa~";
  } else {
    fillcolor0 = "`\x06?a\x1cO\xb0-=\xa9\xd4\x14\xf2";
    fillcolor1 = "`\x06?a\x1cO\xb0-=\xa9\xd4\x14\xf2";
    occludedoutline = "\x82f4\xba\xe32[\xc0\x84\x8ai\xaa~";
    occludedgraph = "`2\x1e\x92\x9a\xe7\x98\xebTy\xfc\xba\xb7Q-";
    occludedfill = "`2\x1e\x92\x9a\xe7\x98\xebTy\xfc\xba\xb7Q-";
  }

  setsaveddvar(@ "r_hudoutlinefillcolor0", fillcolor0);
  setsaveddvar(@ "r_hudoutlinefillcolor1", fillcolor1);
  setsaveddvar(@ "r_hudoutlineoccludedoutlinecolor", occludedoutline);
  setsaveddvar(@ "r_hudoutlineoccludedinlinecolor", occludedgraph);
  setsaveddvar(@ "r_hudoutlineoccludedinteriorcolor", occludedfill);
  setsaveddvar(@ "r_hudoutlineoccludedcolorfromfill", 1);
}

function hudoutline_vis_enemy(enabled, forcedteam) {
  team_type["O\x15\x1b\xad\x9ff"] = "\x1df@>\x87t\x93\x05";
  team_type["?\xb1\xc0\x9a"] = "\xba8C\xef\xc2";
  team_type["\x8c\x1b\xab)\xd1"] = "\xba\xa5\x1f\xc9m\x80i";
  team_type["_Dz\xec"] = "\xba\xa5\x1f\xc9m\x80i";

  if(isDefined(forcedteam)) {
    team = forcedteam;
  } else if(isDefined(self.team)) {
    team = self.team;
  } else {
    team = "_Dz\xec";
  }

  if(enabled && isDefined(team_type[team])) {
    set_hudoutline(team_type[team], 0);
    return;
  }

  self hudoutlinedisable();
}

function hudoutline_activate_best_channel() {
  outline::hudoutline_activate_best_channel();
}

function hud_bink(bink_name) {
  setomnvar("z\xec\xbc\xd1x\x0e`\xaf\xb3\xc3 \xbb", 1);
  setsaveddvar(@ "bg_cinematicfullscreen", "\xfe");
  setsaveddvar(@ "hash_b9ff37d084074df3", "\x87");
  cinematicingame(bink_name);

  while(!iscinematicplaying()) {
    waitframe();
  }

  while(iscinematicplaying()) {
    waitframe();
  }

  stopcinematicingame();
  setomnvar("z\xec\xbc\xd1x\x0e`\xaf\xb3\xc3 \xbb", 0);
  setsaveddvar(@ "bg_cinematicfullscreen", "\x87");
  setsaveddvar(@ "hash_b9ff37d084074df3", "\x87");
}

function hud_fluff_text_message(display_text, context) {
  if(!isDefined(display_text)) {
    display_text = "\xb1\x99\x8a3\x17\xf9\x1ab\xb4E\x03\x97\xa7-\x92\n\xc5}\xde\t\xb5\xd5";
  }

  if(!isDefined(context)) {
    context = 1;
  }

  setomnvar(";\xb6=\x87\"X\x06\xee\x8f\n\xf4\xed\xd5\awu\x8bh-\x94\xf4", display_text);
  setomnvar("\xebx\xd1l\x1b\xafrp1`te8\xf7\xe2z\xde674\x05\x97u\xb1\xf8tL;x", context);
}

function _intel_waypoint_button_listener() {
  level notify("\a\xd8\xd0\xa9\xf5\xfc\xedS\x01\x1eBv\xce{\xc1\xd5U\xab=\x94\xa5\xcf\x15_\xee\x80\xd0");
  level endon("\xe4`\xb3\xa8\x9f\xc2\x0f\x01E\f\x91\x97\xec\xd1P\x8c\x84v\a");
  self.intel_waypoint_request = undefined;
  self notifyonplayercommand("\x17\"a\xdf\xc6\x06\x91\x15\xc7\xb3 |", "cc'\x93{\x1d.X\xdf");
  self waittill("\x17\"a\xdf\xc6\x06\x91\x15\xc7\xb3 |");
  self.intel_waypoint_request = 1;
}

function _intel_dismiss_button_listener() {
  self endon("4\avC\x8f|e\x1a6\t\xd6_\x86\xf1\xa3");
  self notifyonplayercommand("\x96\x9b\xa3\xb2\x8d\xbe\x19-n\xd6K\xcdn", "\x1d\x93\x85]\b\x86\xbb5");
  self notifyonplayercommand("\x96\x9b\xa3\xb2\x8d\xbe\x19-n\xd6K\xcdn", "\x9cK\xa0pRY\xa6C$");
  self notifyonplayercommand("\x96\x9b\xa3\xb2\x8d\xbe\x19-n\xd6K\xcdn", "\x1b\xe8=\xd7,d\x1b\xef\x9e<");
  self waittill("\x96\x9b\xa3\xb2\x8d\xbe\x19-n\xd6K\xcdn");
  self.intel_dismiss_request = 1;
}

function init_manipulate_ent() {
  rotate_ents = getEntArray("\xb5a\x9bi\x83]c\x16te\xbeVsG", #script_noteworthy);
  utility::array_thread(rotate_ents, &manipulate_ent_setup);
}

function manipulate_ent_setup() {
  if(isDefined(self.script_flag_wait)) {
    utility::flag_init(self.script_flag_wait);
  }

  if(isDefined(self.script_flag_waitopen)) {
    utility::flag_init(self.script_flag_waitopen);
  }

  if(isDefined(self.script_deathflag)) {
    utility::flag_init(self.script_deathflag);
  }

  if(isDefined(self.script_rotation_speed)) {
    self.start_angles = self.angles;

    if(!isDefined(self.script_rotation_max)) {
      self.script_rotation_max = (0, 0, 0);
    }

    self.rotation_spring_index = [];

    for(i = 0; i < 3; i++) {
      if(self.script_rotation_max[i] != 0) {
        if(self.script_rotation_speed[i] > 0) {
          self.rotation_spring_index[i] = math::spring_make_under_damped(self.script_rotation_speed[i] * 10, 0, self.start_angles[i] + self.script_rotation_max[i], 0);
          continue;
        }

        assertmsg("<dev string:x26ee>");
      }
    }

    thread rotate_ent_think();
  }

  if(isDefined(self.script_translate_speed)) {
    self.start_origin = self.origin;

    if(!isDefined(self.script_translate_max)) {
      self.script_translate_max = (0, 0, 0);
    }

    self.translate_spring_index = [];

    for(i = 0; i < 3; i++) {
      if(self.script_translate_max[i] != 0) {
        if(self.script_translate_speed[i] > 0) {
          self.translate_spring_index[i] = math::spring_make_under_damped(self.script_translate_speed[i] * 10, 0, self.start_origin[i] + self.script_translate_max[i], 0);
          continue;
        }

        assertmsg("<dev string:x2757>");
      }
    }

    thread translate_ent_think();
  }

  thread manipulate_ent_death_think();
  thread manipulate_ent_cleanup();
}

function translate_ent_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xaf\xf4\xe7Y\xb5/\x82\xaej\x02\x98\xf8\x1a\xfa\xc1\xcc\xd3\xa5\xb8");

  if(isDefined(self.script_flag_wait)) {
    utility::flag_wait(self.script_flag_wait);
  }

  if(isDefined(self.script_flag_waitopen)) {
    utility::flag_waitopen(self.script_flag_waitopen);
  }

  while(true) {
    new_origin = [];

    for(i = 0; i < 3; i++) {
      if(self.script_translate_speed[i] == 0) {
        new_origin[i] = self.start_origin[i];
        continue;
      }

      if(self.script_translate_speed[i] != 0 && self.script_translate_max[i] == 0) {
        new_origin[i] = self.origin[i] + self.script_translate_speed[i] / 20;
        continue;
      }

      if(self.script_translate_speed[i] > 0 && self.script_translate_max[i] != 0) {
        new_origin[i] = math::spring_update(self.translate_spring_index[i], self.start_origin[i]);
      }
    }

    self.origin = (new_origin[0], new_origin[1], new_origin[2]);
    waitframe();
  }
}

function rotate_ent_think() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xaf\xf4\xe7Y\xb5/\x82\xaej\x02\x98\xf8\x1a\xfa\xc1\xcc\xd3\xa5\xb8");

  if(isDefined(self.script_flag_wait)) {
    utility::flag_wait(self.script_flag_wait);
  }

  if(isDefined(self.script_flag_waitopen)) {
    utility::flag_waitopen(self.script_flag_waitopen);
  }

  while(true) {
    new_angle = [];

    for(i = 0; i < 3; i++) {
      if(self.script_rotation_speed[i] == 0) {
        new_angle[i] = self.start_angles[i];
        continue;
      }

      if(self.script_rotation_speed[i] != 0 && self.script_rotation_max[i] == 0) {
        new_angle[i] = self.angles[i] + self.script_rotation_speed[i] / 20;
        continue;
      }

      if(self.script_rotation_speed[i] > 0 && self.script_rotation_max[i] != 0) {
        new_angle[i] = math::spring_update(self.rotation_spring_index[i], self.start_angles[i]);
      }
    }

    new_angle = (angleclamp(new_angle[0]), angleclamp(new_angle[1]), angleclamp(new_angle[2]));
    self.angles = new_angle;
    waitframe();
  }
}

function manipulate_ent_death_think() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(isDefined(self.script_deathflag)) {
    utility::flag_wait(self.script_deathflag);

    if(isDefined(self.script_delete) && self.script_delete) {
      self delete();
      return;
    }

    self notify("\xaf\xf4\xe7Y\xb5/\x82\xaej\x02\x98\xf8\x1a\xfa\xc1\xcc\xd3\xa5\xb8");
  }
}

function manipulate_ent_cleanup() {
  utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\xaf\xf4\xe7Y\xb5/\x82\xaej\x02\x98\xf8\x1a\xfa\xc1\xcc\xd3\xa5\xb8");

  if(isDefined(self.rotation_spring_index)) {
    foreach(spring_index in self.rotation_spring_index) {
      math::spring_delete(spring_index);
    }
  }

  if(isDefined(self.translate_spring_index)) {
    foreach(spring_index in self.translate_spring_index) {
      math::spring_delete(spring_index);
    }
  }
}

function strip_suffix(lookupstring, stripstring) {
  if(lookupstring.size <= stripstring.size) {
    return lookupstring;
  }

  if(getsubstr(lookupstring, lookupstring.size - stripstring.size, lookupstring.size) == stripstring) {
    return getsubstr(lookupstring, 0, lookupstring.size - stripstring.size);
  }

  return lookupstring;
}

function set_exception(type, func) {
  assert(isDefined(self.exception[type]));
  self.exception[type] = func;
}

function set_all_exceptions(exceptionfunc) {
  keys = getarraykeys(self.exception);

  for(i = 0; i < keys.size; i++) {
    self.exception[keys[i]] = exceptionfunc;
  }
}

function waittill_multiple_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4) {
  self endon("\x1e\xfd\xd1\xa2\a");
  ent = spawnStruct();
  ent.threads = 0;

  if(isDefined(ent1)) {
    assert(isDefined(string1));
    ent1 childthread utility::waittill_string(string1, ent);
    ent.threads++;
  }

  if(isDefined(ent2)) {
    assert(isDefined(string2));
    ent2 childthread utility::waittill_string(string2, ent);
    ent.threads++;
  }

  if(isDefined(ent3)) {
    assert(isDefined(string3));
    ent3 childthread utility::waittill_string(string3, ent);
    ent.threads++;
  }

  if(isDefined(ent4)) {
    assert(isDefined(string4));
    ent4 childthread utility::waittill_string(string4, ent);
    ent.threads++;
  }

  while(ent.threads) {
    ent waittill("s>H\xe6\xfb\xe6Gn");
    ent.threads--;
  }

  ent notify("&\xc7\xee");
}

function get_linked_scriptables() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = utility::get_links();

    if(linknames.size == 1) {
      return getscriptablearray(linknames[0], #script_linkname);
    } else if(linknames.size > 1) {
      return function_b3283c7f703b02da(linknames, #script_linkname);
    }
  }

  if(!array.size && gettime() <= 300) {
    assertmsg("<dev string:x27c2>");
  }

  return array;
}

function get_linked_vehicles() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = utility::get_links();
    allvehicles = vehicle_getarray();

    foreach(vehicle in allvehicles) {
      foreach(name in linknames) {
        if(vehicle.script_linkname == name) {
          array[array.size] = vehicle;
        }
      }
    }
  }

  return array;
}

function get_linked_vehicle_spawners() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = utility::get_links();
    spawners = vehicle_getspawnerarray();

    foreach(spawner in spawners) {
      foreach(name in linknames) {
        if(spawner.script_linkname == name) {
          array[array.size] = spawner;
        }
      }
    }
  }

  return array;
}

function get_linked_spawners() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = utility::get_links();
    allspawners = getspawnerarray();

    foreach(spawner in allspawners) {
      foreach(name in linknames) {
        if(spawner.script_linkname == name) {
          array[array.size] = spawner;
        }
      }
    }
  }

  return array;
}

function get_linked_vehicle_nodes() {
  array = [];

  if(isDefined(self.script_linkto)) {
    linknames = utility::get_links();

    if(linknames.size == 1) {
      return getvehiclenodearray(linknames[0], #script_linkname);
    } else if(linknames.size > 1) {
      return function_c192aea38fea1915(linknames, #script_linkname);
    }
  }

  return array;
}

function run_thread_on_targetname(msg, func, ...) {
  array = getEntArray(msg, #targetname);
  utility::array_thread(array, func, flat_args(vararg, varargcount));

  if(isDefined(level.getspawnerarrayfunction)) {
    all = builtin[[level.getspawnerarrayfunction]](msg);

    foreach(s in all) {
      if(isnonentspawner(s)) {
        utility::array_thread([s], func, flat_args(vararg, varargcount));
      }
    }
  }

  array = utility::getStructArray(msg, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  utility::array_thread(array, func, flat_args(vararg, varargcount));
  array = builtin[[level.getnodearrayfunction]](msg, #targetname);
  utility::array_thread(array, func, flat_args(vararg, varargcount));
  array = getvehiclenodearray(msg, #targetname);
  utility::array_thread(array, func, flat_args(vararg, varargcount));
}

function run_thread_on_noteworthy(msg, func, ...) {
  array = getEntArray(msg, #script_noteworthy);
  utility::array_thread(array, func, flat_args(vararg, varargcount));

  if(isDefined(level.getspawnerarrayfunction)) {
    all = builtin[[level.getspawnerarrayfunction]]();

    foreach(s in all) {
      if(isDefined(s.script_noteworthy) && s.script_noteworthy == msg && isnonentspawner(s)) {
        utility::array_thread([s], func, flat_args(vararg, varargcount));
      }
    }
  }

  array = utility::getStructArray(msg, "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");
  utility::array_thread(array, func, flat_args(vararg, varargcount));
  array = builtin[[level.getnodearrayfunction]](msg, #script_noteworthy);
  utility::array_thread(array, func, flat_args(vararg, varargcount));
  array = getvehiclenodearray(msg, #script_noteworthy);
  utility::array_thread(array, func, flat_args(vararg, varargcount));
}

function get_noteworthy_ent(noteworthy) {
  assert(isDefined(noteworthy), "<dev string:x2822>");
  ent = getEnt(noteworthy, #script_noteworthy);

  if(isDefined(ent)) {
    return ent;
  }

  if(utility::issp()) {
    ent = builtin[[level.getnodefunction]](noteworthy, "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");

    if(isDefined(ent)) {
      return ent;
    }
  }

  ent = utility::getStruct(noteworthy, "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");

  if(isDefined(ent)) {
    return ent;
  }

  ent = getvehiclenode(noteworthy, #script_noteworthy);

  if(isDefined(ent)) {
    return ent;
  }

  assert("<dev string:x2844>" + noteworthy + "<dev string:x286a>");
}

function is_locked(msg) {
  assert(isDefined(level.lock));
  assert(isDefined(level.lock[msg]));
  lock = level.lock[msg];
  return lock.count > lock.max_count;
}

function getfarthest(org, array, maxdist) {
  if(!isDefined(maxdist)) {
    maxdist = 500000;
  }

  dist = 0;
  ent = undefined;

  foreach(item in array) {
    newdist = distance(item.origin, org);

    if(newdist <= dist || newdist >= maxdist) {
      continue;
    }

    dist = newdist;
    ent = item;
  }

  return ent;
}

function array_sort_by_handler(array, compare_func) {
  assert(isDefined(array), "<dev string:x2884>");
  assert(isDefined(compare_func), "<dev string:x289a>");

  for(i = 0; i < array.size - 1; i++) {
    for(j = i + 1; j < array.size; j++) {
      if(array[j][[compare_func]]() < array[i][[compare_func]]()) {
        ref = array[j];
        array[j] = array[i];
        array[i] = ref;
      }
    }
  }

  return array;
}

function monitor_interact_delay(interact, forcedstance) {
  interact waittill("\x91`\xb1\xe7T\x97>", who);
  level.player enableslowaim(0.1, 0.1);
  level.player val::set("\xee.\x8ei\x89\xa2\x14 D\xb3\xd3v\x88}\xe8\x9cC\xde\xe4\xd4*\xd6", "\xe4\xf1G", 0);

  while(!level.player isonground()) {
    wait 0.05;
  }

  currentstance = level.player getstance();

  if(currentstance != forcedstance) {
    level.player setstance(forcedstance);

    if(currentstance == "GX\xa9]\x82") {
      wait 0.2;
    }
  }

  level.player disableslowaim();
  level.player val::reset_all("\xee.\x8ei\x89\xa2\x14 D\xb3\xd3v\x88}\xe8\x9cC\xde\xe4\xd4*\xd6");
  return who;
}

function ai_create_weapon_stow(weapon) {
  self.weapon_stow = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self gettagorigin("\xff,w\xfb\xb2r@_{w!\xb8\x85\x1f<"));
  self.weapon_stow setModel(getweaponmodel(weapon));
  self.weapon_stow notsolid();
  self.weapon_stow.angles = self gettagangles("\xff,w\xfb\xb2r@_{w!\xb8\x85\x1f<");
  self.weapon_stow linkTo(self, "\xff,w\xfb\xb2r@_{w!\xb8\x85\x1f<");
}

function countdown_start(time, message) {
  level notify("\xb0\x9e\x83$\x80\x1c\x04\xd7\x10\xfe\x8bg\x9b\x90C");
  level endon("\xb0\x9e\x83$\x80\x1c\x04\xd7\x10\xfe\x8bg\x9b\x90C");
  level endon("$\xacz\xed\xfc.\x17\xc1\x06am\xa0\xfd");
  setomnvar("|\xa4\x8d\xdb\x9f\f?\x89\xc9j\x1e52\xa5y\xb6W\x8a\xee\x1bou\xd1Z7", message);
  setomnvar("\xa9\xcc!\x19O\xb3\xa8\f\xe2\xcct\x1b\x8d}\xae\xb3~\x0f", gettime() + time * 1000 * 60);
}

function countdown_end() {
  level notify("$\xacz\xed\xfc.\x17\xc1\x06am\xa0\xfd");
  setomnvar("\xa9\xcc!\x19O\xb3\xa8\f\xe2\xcct\x1b\x8d}\xae\xb3~\x0f", 0);
}

function setfirstsavetime(time) {
  time = max(time, 2);
  level.beginningoflevelsavedelay = time;
}

function motion_blur_disable(time) {
  if(!isDefined(time)) {
    time = 0;
  }

  thread lerp_saveddvar(@ "r_mbvelocityscale", 0, time);
  thread lerp_saveddvar(@ "r_mbvelocityscaleviewmodel", 0, time);
}

function motion_blur_enable(velocityscale, velocityscaleviewmodel, time) {
  if(!isDefined(velocityscale)) {
    velocityscale = isDefined(level.motionblur) ? level.motionblur["eK\xe5\x98=\x15\x8d}\xbd}=l\n\xc7\nXm\xd66\x81"] : getdvarfloat(@ "r_mbvelocityscale");
  }

  if(!isDefined(velocityscaleviewmodel)) {
    velocityscaleviewmodel = isDefined(level.motionblur) ? level.motionblur["v\xcac\xb7\x8dZ\xe8/\xa9\x8d\xb0c\xca\xb2\x96V\xddS\xf6\x19\x95\xc6\x11\xb23\x16u\x1b:"] : getdvarfloat(@ "r_mbvelocityscaleviewmodel");
  }

  if(!isDefined(time)) {
    time = 0;
  }

  thread lerp_saveddvar(@ "r_mbvelocityscale", velocityscale, time);
  thread lerp_saveddvar(@ "r_mbvelocityscaleviewmodel", velocityscaleviewmodel, time);
}

function create_motion_blur_defaults(velocityscale, velocityscaleviewmodel) {
  if(!isDefined(velocityscale)) {
    velocityscale = getdvarfloat(@ "r_mbvelocityscale");
  }

  if(!isDefined(velocityscaleviewmodel)) {
    velocityscaleviewmodel = getdvarfloat(@ "r_mbvelocityscaleviewmodel");
  }

  level.motionblur = [];
  level.motionblur["eK\xe5\x98=\x15\x8d}\xbd}=l\n\xc7\nXm\xd66\x81"] = velocityscale;
  level.motionblur["v\xcac\xb7\x8dZ\xe8/\xa9\x8d\xb0c\xca\xb2\x96V\xddS\xf6\x19\x95\xc6\x11\xb23\x16u\x1b:"] = velocityscaleviewmodel;
}

function actionslotoverride(actionslot, material, ammocount, function, var_2d4042fdb2cfe549) {
  self setweaponhudiconoverride("X\x8d\xa3K\xdb\xe67l\xdb\xd1" + actionslot, material);

  if(isDefined(ammocount)) {
    setactionslotoverrideammo(actionslot, ammocount);
  }

  if(isDefined(function)) {
    thread actionslotoverridecallback(actionslot, function, var_2d4042fdb2cfe549);
  }

  level.player thread player_sp::allow_player_weapon_info(1);
}

function actionslotoverridecallback(actionslot, function, var_2d4042fdb2cfe549) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xb5}9]L\x9f\x8a\xfd\xdd\x83\x12\xcdt\x97`t" + actionslot);
  self notifyonplayercommand("X\x8d\xa3K\xdb\xe67l\xdb\xd1" + actionslot, "H" + "<\xbd\x1am~\x89\x06z\xbe\r/" + actionslot);

  while(true) {
    self waittill("X\x8d\xa3K\xdb\xe67l\xdb\xd1" + actionslot);

    if(!isDefined(var_2d4042fdb2cfe549) || !var_2d4042fdb2cfe549 || var_2d4042fdb2cfe549 && level.player usinggamepad()) {
      level.player thread player_sp::allow_player_weapon_info(1);
      self thread[[function]]();
    }
  }
}

function actionslotoverrideremove(actionslot) {
  self notify("\xb5}9]L\x9f\x8a\xfd\xdd\x83\x12\xcdt\x97`t" + actionslot);
  self setweaponhudiconoverrideammo("X\x8d\xa3K\xdb\xe67l\xdb\xd1" + actionslot, -1);
  self setweaponhudiconoverride("X\x8d\xa3K\xdb\xe67l\xdb\xd1" + actionslot, "\r+x5");
  level.player thread player_sp::allow_player_weapon_info(1);
}

function setactionslotoverrideammo(actionslot, ammocount) {
  assert(self getweaponhudiconoverride("<dev string:x28bb>" + actionslot) != "<dev string:x28c9>", "<dev string:x28d1>");
  self setweaponhudiconoverrideammo("X\x8d\xa3K\xdb\xe67l\xdb\xd1" + actionslot, ammocount);
  level.player thread player_sp::allow_player_weapon_info(1);
}

function function_83c3c8eaf11e5ad(excludemelee = 0, var_9706455ec32d92c9 = 0) {
  self takeallweapons(excludemelee, var_9706455ec32d92c9);

  if(isDefined(self.climbfists)) {
    give_weapon(self.climbfists);
  }
}

function giveweaponmaxammo(weapon) {
  self givemaxammo(weapon);
}

function isweaponmaxammo(weapon) {
  if(istrue(weapon.ismelee)) {
    return true;
  }

  ammostock = self getweaponammostock(weapon);
  ammomax = weaponmaxammo(weapon);
  return ammostock >= ammomax;
}

function can_trace_to_player(start, ignorearray, contentoverride) {
  if(!isDefined(ignorearray)) {
    ignorearray = [];
  }

  if(!isarray(ignorearray)) {
    ignorearray = [ignorearray];
  }

  ignorearray[ignorearray.size] = level.player;

  if(isent(self) || isai(self)) {
    ignorearray[ignorearray.size] = self;
  }

  if(trace::ray_trace_passed(start, level.player.origin, ignorearray, contentoverride)) {
    return true;
  }

  if(trace::ray_trace_passed(start, level.player.origin + (0, 0, 30), ignorearray, contentoverride)) {
    return true;
  }

  if(trace::ray_trace_passed(start, level.player getEye(), ignorearray, contentoverride)) {
    return true;
  }

  return false;
}

function function_29f2a13ad5e570b0(surface, actiontype, movetype) {
  if(utility::is_dead_sentient()) {
    return;
  }

  if(!isDefined(surface)) {
    surface = "Ee\x12\x18";
  }

  if(!isDefined(actiontype)) {
    actiontype = "\xc5q\x85\xc5";
  }

  if(!isDefined(movetype)) {
    movetype = "\x14+`";
  }

  self function_c87999e1d11d2771(surface, actiontype, movetype);
}

function play_footstep_sound(alias, surface) {
  println("<dev string:x2938>");
}

function wait_for_sounddone_or_death(org, other) {
  if(isDefined(other)) {
    other endon("\x1e\xfd\xd1\xa2\a");
  }

  self endon("\x1e\xfd\xd1\xa2\a");
  org waittill("\xdc\xf6\xba\xdcFF\xdb\xe6e");
  return true;
}

function delete_on_death_wait_sound(ent, sounddone) {
  ent endon("\x1e\xfd\xd1\xa2\a");
  self waittill("\x1e\xfd\xd1\xa2\a");

  if(isDefined(ent)) {
    if(ent iswaitingonsound()) {
      ent waittill(sounddone);
    }

    ent delete();
  }
}

function is_touching_any(array) {
  foreach(item in array) {
    if(self istouching(item)) {
      return true;
    }
  }

  return false;
}

function scripter_note(str, duration) {
  thread utility_code::scripter_note_proc(str, duration);
}

function play_sound_on_tag(alias, tag, ends_on_death, var_e0d135c5a1146a1f, radio_dialog) {
  if(utility::is_dead_sentient()) {
    return;
  }

  org = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);
  org endon("\x1e\xfd\xd1\xa2\a");
  thread delete_on_death_wait_sound(org, "\xdc\xf6\xba\xdcFF\xdb\xe6e");

  if(isDefined(tag) && self tagexists(tag)) {
    org linkTo(self, tag, (0, 0, 0), (0, 0, 0));
  } else {
    if(isDefined(tag)) {
      iprintln("<dev string:x29ac>" + tag + "<dev string:x29cd>" + int(org.origin[0]) + "<dev string:x1646>" + int(org.origin[1]) + "<dev string:x1646>" + int(org.origin[2]) + "<dev string:x29d5>");
    }

    org.origin = self.origin;
    org.angles = self.angles;
    org linkTo(self);
  }

  if(isDefined(level.player_radio_emitter) && self == level.player_radio_emitter) {
    println("<dev string:x29db>" + alias);
  }

  if(getdvarint(@ "hash_b95e70dfa43a9845") && !soundexists(alias)) {
    println("<dev string:x29fd>" + alias + "<dev string:x2a19>");
    org delete();
    return;
  }

  org playSound(alias, "\xdc\xf6\xba\xdcFF\xdb\xe6e");

  if(isDefined(ends_on_death)) {
    assert(ends_on_death, "<dev string:x2a1f>");

    if(!isDefined(wait_for_sounddone_or_death(org))) {
      org stopsounds();
    }

    wait 0.05;
  } else {
    org waittill("\xdc\xf6\xba\xdcFF\xdb\xe6e");
  }

  if(isDefined(var_e0d135c5a1146a1f)) {
    self notify(var_e0d135c5a1146a1f);
  }

  org delete();
}

function setupglobalcallbackfunctions_sp() {
  if(!utility::add_init_script("\x8c\x9c\x16\n\xf7\x9d\x9c\xd7\xf4m^&\x9a)\xb8\t\x1f\v", &setupglobalcallbackfunctions_sp)) {
    return;
  }

  level.fnplaysoundonentity = &play_sound_on_entity;
  level.fnplaysoundontag = &play_sound_on_tag;
}

function function_3f95243bde9e0d3d(bool) {
  setomnvar("\xc8\x16\xc1\xc4\x02MA\xf8\xa9\xbbEAr7\x15d\xcd\x15", bool);
}

function function_2a49223eac045b61() {
  return getomnvar("\xc8\x16\xc1\xc4\x02MA\xf8\xa9\xbbEAr7\x15d\xcd\x15") > 0;
}

function fake_bullet(endpoint, weaponname, muzzleflash, muzzleflashtag) {
  bullettracer(self.origin, endpoint, weaponname, 0);
  self function_bc7d71d1b2d21a0f(weaponname);

  if(isDefined(muzzleflash)) {
    tagname = isDefined(muzzleflashtag) ? muzzleflashtag : "\xec\xbfK|\au\xcd\xc2\x19<";
    playFXOnTag(utility::getfx(muzzleflash), self, tagname);
  }
}