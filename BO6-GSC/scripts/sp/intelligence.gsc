/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\intelligence.gsc
***************************************/

#using scripts\engine\utility;
#using scripts\sp\hud_util;
#using scripts\sp\utility;
#namespace intelligence;

function main() {
  precachestring(&"script/intelligence_of_eighteen");
  precachestring(&"script/rorkefile_prev_found");
  precachestring(&"script/rorkefile_pickup");
  precachestring(&"script/intelligence_percent");
  precachestring(&"script/intelligence_uploading");

  setdevdvarifuninitialized(@ "hash_69724876b38df066", 0);

  level.intel_items = create_array_of_intel_items();
  println("<dev string:x24>", level.intel_items.size);
  setDvar(@ "hash_6ca72b22ba2fd9ea", level.intel_items.size);
  level.intel_counter = 0;
  setDvar(@ "hash_b80696ed82642848", level.intel_counter);
  level.table_origins = create_array_of_origins_from_table();
  initialize_intel();
  intel_think();
}

function remove_all_intel() {
  foreach(trigger in level.intel_items) {
    if(!isDefined(trigger.removed)) {
      trigger remove_intel_item();
    }
  }
}

function remove_intel_item() {
  self.removed = 1;
  self.item hide();
  self.item notsolid();
  utility::trigger_off();
  level.intel_counter++;
  setDvar(@ "hash_b80696ed82642848", level.intel_counter);
  println("<dev string:x59>" + self.num);
  self notify("s\x87\xba{\a\x92\x86I\xc6\x1c\xbe\xee\x13\r5\xc3%\xa3");
}

function initialize_intel() {
  foreach(trigger in level.intel_items) {
    origin = trigger.origin;
    trigger.num = get_nums_from_origins(origin);
  }
}

function intel_think() {
  foreach(trigger in level.intel_items) {
    if(trigger check_item_found()) {
      trigger remove_intel_item();
      continue;
    }

    trigger thread wait_for_pickup();
    trigger thread poll_for_found();
  }
}

function poll_for_found() {
  self endon("E2\xbc\xa1V\xb0w\xb7\xccs\\n\x18[\xe9");

  if(isDefined(self)) {
    if(check_item_found()) {
      remove_intel_item();
    }
  } else {
    return;
  }

  while(!check_item_found()) {
    wait 0.05;
  }

  remove_intel_item();
}

function check_item_found() {
  foreach(player in level.players) {
    if(!player getplayerintelisfound(self.num)) {
      return false;
    }
  }

  return true;
}

function create_array_of_intel_items() {
  intelligence_items = getEntArray("\xb1\x93\x8b5@\xc4\x0ep\x14\xba\xa3\x97\xbe\xd2\xee\x01\x0e", #targetname);

  for(i = 0; i < intelligence_items.size; i++) {
    println(intelligence_items[i].origin);
    intelligence_items[i].item = getEnt(intelligence_items[i].target, #targetname);
    intelligence_items[i].found = 0;
  }

  return intelligence_items;
}

function create_array_of_origins_from_table() {
  table_size = 20;
  origins = [];

  for(num = 1; num <= table_size; num++) {
    location = tablelookup("\xb9\x0e^\xd2s\x8e\xb2l\xd7\xd2:e\xb5nq\xb1\xcd\xce", 0, num, 4);

    if(isDefined(location) && location != "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") {
      locarray = strtok(location, "\x16");
      assert(locarray.size == 3);

      for(i = 0; i < locarray.size; i++) {
        locarray[i] = int(locarray[i]);
      }

      origins[num] = (locarray[0], locarray[1], locarray[2]);
      continue;
    }

    origins[num] = undefined;
  }

  return origins;
}

function award_intel() {
  save_intel_for_all_players();
  updategamerprofileall();
  waittillframeend();
  remove_intel_item();
}

function wait_for_pickup() {
  self endon("s\x87\xba{\a\x92\x86I\xc6\x1c\xbe\xee\x13\r5\xc3%\xa3");

  thread function_cf81502391131166();

  if(self.classname == "0\x85\x9f\xfa\xcb\x0f\xdb\xfct^(") {
    self setHintString(&"script/rorkefile_pickup");
    self useTriggerRequireLookAt(1);
  }

  thread upload_hold();
  self waittill("\x1a\xc8|>\x87Pk-Y\xe0^\xbb3");
  self notify("E2\xbc\xa1V\xb0w\xb7\xccs\\n\x18[\xe9");
  intel_feedback(level.player);
  award_intel();
}

function upload_hold() {
  level.player.hold_count = 0;

  while(level.player.hold_count < 30 && isDefined(self)) {
    level.player.hold_count = 0;
    self stoploopsound("\xc0\xae$\x87\x85\xa6>\x9e\xee\x0fY\xd3\xc2c\xb3M\x17\xdd\"\xf8\xa4\x85\xfd\x06");
    self waittill("\x91`\xb1\xe7T\x97>", player);
    self playLoopSound("\xc0\xae$\x87\x85\xa6>\x9e\xee\x0fY\xd3\xc2c\xb3M\x17\xdd\"\xf8\xa4\x85\xfd\x06");
    setDvar(@ "ui_securing", "\xbeH\xb4\x14\x01");
    setDvar(@ "ui_securing_progress", 0);
    thread progress_bar();
    hold_count_check();
  }

  self notify("\x1a\xc8|>\x87Pk-Y\xe0^\xbb3");
  self stoploopsound("\xc0\xae$\x87\x85\xa6>\x9e\xee\x0fY\xd3\xc2c\xb3M\x17\xdd\"\xf8\xa4\x85\xfd\x06");
  setDvar(@ "ui_securing_progress", 1);
  setDvar(@ "ui_securing", "");
}

function hold_count_check() {
  self endon("0\xd5\a}\x80\xe2zkDt\xe4#tA\xce\xa7");

  while(isDefined(self) && isDefined(level.player)) {
    if(level.player useButtonPressed() && distance(level.player.origin, self.origin) < 128 && isalive(level.player)) {
      level.player.hold_count++;
    } else {
      setDvar(@ "ui_securing", "");
      self stoploopsound("\xc0\xae$\x87\x85\xa6>\x9e\xee\x0fY\xd3\xc2c\xb3M\x17\xdd\"\xf8\xa4\x85\xfd\x06");
      self notify("0\xd5\a}\x80\xe2zkDt\xe4#tA\xce\xa7");
    }

    if(level.player.hold_count >= 30) {
      setDvar(@ "ui_securing", "");
      self notify("0\xd5\a}\x80\xe2zkDt\xe4#tA\xce\xa7");
      self stoploopsound("\xc0\xae$\x87\x85\xa6>\x9e\xee\x0fY\xd3\xc2c\xb3M\x17\xdd\"\xf8\xa4\x85\xfd\x06");
    }

    waitframe();
  }
}

function progress_bar() {
  self endon("0\xd5\a}\x80\xe2zkDt\xe4#tA\xce\xa7");
  num_ticks = 30;
  move_offset = 8;

  for(i = 0; i < num_ticks; i++) {
    setDvar(@ "ui_securing_progress", getdvarfloat(@ "ui_securing_progress") + 1 / num_ticks);
    waitframe();
  }
}

function intel_upload_text(text, text2) {
  self endon("0\xd5\a}\x80\xe2zkDt\xe4#tA\xce\xa7");
  num_ticks = 30;
  cycle_time = 10;
  current_time = 0;

  for(i = 0; i < num_ticks; i++) {
    if(current_time > cycle_time) {
      current_time = 0;
    }

    if(current_time < cycle_time / 2) {
      text settext(&"script/intelligence_uploading");
    } else {
      text settext("");
    }

    text2.label = int(i / num_ticks * 100);
    text2 settext(&"script/intelligence_percent");
    current_time++;
    waitframe();
  }

  text settext(&"script/intelligence_uploading");
  text2.label = "\xc4\xc00";
  text2 settext(&"script/intelligence_percent");
}

function save_intel_for_all_players() {
  assert(!check_item_found());

  foreach(player in level.players) {
    if(player getplayerintelisfound(self.num)) {
      continue;
    }

    player setplayerintelfound(self.num);
  }

  logstring("\xa7sc\xecI{\x96\xe2RR\xbf\xfa\x97\xd4\xcb*\x90" + self.num);
  println("<dev string:x6e>");
}

function give_point() {
  curvalue = self getplayerprogression("\xc6\xf5\x01\xd7eXh\xbat\xbaf");
  self setplayerprogression("\xc6\xf5\x01\xd7eXh\xbat\xbaf", curvalue + 1);
}

function intel_feedback(var_ec5371a089d02ad6) {
  self.item hide();
  self.item notsolid();
  playsoundatpos(self.item.origin, "\x1c\xa5\xb6\x11m}G+-N\xa17\xe1J\xfb\b\x18\xc3\xaa");
  display_time = 3000;
  fade_time = 700;
  delete_time = display_time + fade_time / 1000;

  foreach(player in level.players) {
    if(var_ec5371a089d02ad6 != player && player getplayerintelisfound(self.num)) {
      continue;
    }

    remaining_print = player hud_util::createclientfontstring("8\xc5\xe5\x91E\x1b\xf9\xb2e", 1.5);
    remaining_print.glowcolor = (0.7, 0.7, 0.3);
    remaining_print.glowalpha = 1;
    remaining_print setup_hud_elem();
    remaining_print.y = -50;
    remaining_print setpulsefx(60, display_time, fade_time);
    intel_found = 0;

    if(var_ec5371a089d02ad6 == player && player getplayerintelisfound(self.num)) {
      remaining_print.label = &"script/rorkefile_prev_found";
    } else {
      remaining_print.label = &"script/intelligence_of_eighteen";
      player give_point();
      intel_found = player getplayerprogression("\xc6\xf5\x01\xd7eXh\xbat\xbaf");
      remaining_print setvalue(intel_found);
    }

    if(intel_found == 18) {
      player utility_sp::player_giveachievement_wrapper("\x9bsQ\xb8\x92");
    }

    remaining_print utility::delaycall(delete_time, &destroy);
  }
}

function setup_hud_elem() {
  self.color = (1, 1, 1);
  self.alpha = 1;
  self.x = 0;
  self.alignx = "O\xd5!\xe8\xd4\x9d";
  self.aligny = "#\xb8\xfd\xf5\x1a@";
  self.horzalign = "O\xd5!\xe8\xd4\x9d";
  self.vertalign = "#\xb8\xfd\xf5\x1a@";
  self.foreground = 1;
}

function assert_if_identical_origins() {
  origins = [];

  for(i = 1; i < 65; i++) {
    location = tablelookup("\xb9\x0e^\xd2s\x8e\xb2l\xd7\xd2:e\xb5nq\xb1\xcd\xce", 0, i, 4);
    locarray = strtok(location, "\x16");

    for(i = 0; i < locarray.size; i++) {
      locarray[i] = int(locarray[i]);
    }

    origins[i] = (locarray[0], locarray[1], locarray[2]);
  }

  for(i = 0; i < origins.size; i++) {
    if(!isDefined(origins[i])) {
      continue;
    }

    if(origins[i] == "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") {
      continue;
    }

    for(j = 0; j < origins.size; j++) {
      if(!isDefined(origins[j])) {
        continue;
      }

      if(origins[j] == "\xed\x1d\va\x1e\xf6\xe5\x88\x8a") {
        continue;
      }

      if(i == j) {
        continue;
      }

      if(origins[i] == origins[j]) {
        assertmsg("<dev string:xa5>" + origins[i] + "<dev string:xe3>");
      }
    }
  }
}

function get_nums_from_origins(origin) {
  for(i = 1; i < level.table_origins.size + 1; i++) {
    if(!isDefined(level.table_origins[i])) {
      continue;
    }

    if(distancesquared(origin, level.table_origins[i]) < squared(75)) {
      return i;
    }
  }

  assertmsg("<dev string:xe9>" + origin + "<dev string:x111>");
}

function function_cf81502391131166() {
  while(true) {
    if(getdvarint(@ "hash_69724876b38df066")) {
      award_intel();
      self notify("<dev string:x132>");
      return;
    }

    wait 0.05;
  }
}

# /