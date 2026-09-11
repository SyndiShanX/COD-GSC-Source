/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\intelligence.gsc
***********************************************/

function main() {
  precachestring(&"SCRIPT/INTELLIGENCE_OF_EIGHTEEN");
  precachestring(&"SCRIPT/RORKEFILE_PREV_FOUND");
  precachestring(&"SCRIPT/RORKEFILE_PICKUP");
  precachestring(&"SCRIPT/INTELLIGENCE_PERCENT");
  precachestring(&"SCRIPT/INTELLIGENCE_UPLOADING");
  level.intel_items = create_array_of_intel_items();
  setDvar("ui_level_cheatpoints", level.intel_items.size);
  level.intel_counter = 0;
  setDvar("ui_level_player_cheatpoints", level.intel_counter);
  level.table_origins = create_array_of_origins_from_table();
  initialize_intel();
  intel_think();
}

function remove_all_intel() {
  foreach(var1 in level.intel_items) {
    if(!isDefined(var1.removed)) {
      remove_intel_item(var1);
    }
  }
}

function remove_intel_item() {
  self.removed = 1;
  self.item hide();
  self.item notsolid();
  scripts\engine\utility::trigger_off();
  level.intel_counter++;
  setDvar("ui_level_player_cheatpoints", level.intel_counter);
  self notify("end_trigger_thread");
}

function initialize_intel() {
  foreach(var1 in level.intel_items) {
    var2 = var1.origin;
    var1.num = get_nums_from_origins(var2);
  }
}

function intel_think() {
  foreach(var1 in level.intel_items) {
    if(check_item_found(var1)) {
      remove_intel_item(var1);
      continue;
    }

    thread wait_for_pickup();
    thread poll_for_found();
  }
}

function poll_for_found() {
  self endon("end_loop_thread");

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
  foreach(var1 in level.players) {
    if(!var1 getplayerintelisfound(self.num)) {
      return false;
    }
  }

  return true;
}

function create_array_of_intel_items() {
  var0 = getEntArray("intelligence_item", "targetname");

  for(var1 = 0; var1 < var0.size; var1++) {
    var0[var1].item = getEnt(var0[var1].target, "targetname");
    var0[var1].found = 0;
  }

  return var0;
}

function create_array_of_origins_from_table() {
  var0 = 20;
  var1 = [];

  for(var2 = 1; var2 <= var0; var2++) {
    var3 = tablelookup("sp/intel_items.csv", 0, var2, 4);

    if(isDefined(var3) && var3 != "undefined") {
      var4 = strtok(var3, ",");

      for(var5 = 0; var5 < var4.size; var5++) {
        var4 = int(var4[var5]);
      }

      var1 = (var4[0], var4[1], var4[2]);
      continue;
    }

    var1[var2] = undefined;
  }

  return var1;
}

function award_intel() {
  save_intel_for_all_players();
  updategamerprofileall();
  waittillframeend();
  remove_intel_item();
}

function wait_for_pickup() {
  self endon("end_trigger_thread");

  if(self.classname == "trigger_use") {
    self setHintString(&"SCRIPT/RORKEFILE_PICKUP");
    self useTriggerRequireLookAt(1);
  }

  thread upload_hold();
  self waittill("hold_complete");
  self notify("end_loop_thread");
  intel_feedback(level.player);
  award_intel();
}

function upload_hold() {
  level.player.hold_count = 0;

  while(level.player.hold_count < 30 && isDefined(self)) {
    level.player.hold_count = 0;
    self stoploopsound("intelligence_pickup_loop");
    self waittill("trigger", var0);
    self playLoopSound("intelligence_pickup_loop");
    setDvar("ui_securing", "intel");
    setDvar("ui_securing_progress", 0);
    thread progress_bar();
    hold_count_check();
  }

  self notify("hold_complete");
  self stoploopsound("intelligence_pickup_loop");
  setDvar("ui_securing_progress", 1);
  setDvar("ui_securing", "");
}

function hold_count_check() {
  self endon("stopped_pressing");

  while(isDefined(self) && isDefined(level.player)) {
    if(level.player useButtonPressed() && distance(level.player.origin, self.origin) < 128 && isalive(level.player)) {
      level.player.hold_count++;
    } else {
      setDvar("ui_securing", "");
      self stoploopsound("intelligence_pickup_loop");
      self notify("stopped_pressing");
    }

    if(level.player.hold_count >= 30) {
      setDvar("ui_securing", "");
      self notify("stopped_pressing");
      self stoploopsound("intelligence_pickup_loop");
    }

    waitframe();
  }
}

function progress_bar() {
  self endon("stopped_pressing");
  var0 = 30;
  var1 = 8;

  for(var2 = 0; var2 < var0; var2++) {
    setDvar("ui_securing_progress", getdvarfloat("ui_securing_progress") + 1 / var0);
    waitframe();
  }
}

function intel_upload_text(var0, var1) {
  self endon("stopped_pressing");
  var2 = 30;
  var3 = 10;
  var4 = 0;

  for(var5 = 0; var5 < var2; var5++) {
    if(var4 > var3) {
      var4 = 0;
    }

    if(var4 < var3 / 2) {
      var0 settext(&"SCRIPT/INTELLIGENCE_UPLOADING");
    } else {
      var0 settext("");
    }

    var1.label = int(var5 / var2 * 100);
    var1 settext(&"SCRIPT/INTELLIGENCE_PERCENT");
    var4++;
    waitframe();
  }

  var0 settext(&"SCRIPT/INTELLIGENCE_UPLOADING");
  var1.label = "100";
  var1 settext(&"SCRIPT/INTELLIGENCE_PERCENT");
}

function save_intel_for_all_players() {
  foreach(var1 in level.players) {
    if(var1 getplayerintelisfound(self.num)) {
      continue;
    }

    var1 setplayerintelfound(self.num);
  }

  logstring("found intel item " + self.num);
}

function give_point() {
  var0 = self getlocalplayerprofiledata("cheatPoints");
  self setlocalplayerprofiledata("cheatPoints", var0 + 1);
}

function intel_feedback(var0) {
  self.item hide();
  self.item notsolid();
  playworldsound("intelligence_pickup", self.item.origin);
  var1 = 3000;
  var2 = 700;
  var3 = var1 + var2 / 1000;

  foreach(var5 in level.players) {
    if(var0 != var5 && var5 getplayerintelisfound(self.num)) {
      continue;
    }

    var6 = var5 scripts\sp\hud_util::createclientfontstring("objective", 1.5);
    var6.glowcolor = (0.7, 0.7, 0.3);
    var6.glowalpha = 1;
    setup_hud_elem(var6);
    var6.y = -50;
    var6 setpulsefx(60, var1, var2);
    var7 = 0;

    if(var0 == var5 && var5 getplayerintelisfound(self.num)) {
      var6.label = &"SCRIPT/RORKEFILE_PREV_FOUND";
    } else {
      var6.label = &"SCRIPT/INTELLIGENCE_OF_EIGHTEEN";
      give_point(var5);
      var7 = var5 getlocalplayerprofiledata("cheatPoints");
      var6 setvalue(var7);
    }

    if(var7 == 18) {
      var5 scripts\sp\utility::player_giveachievement_wrapper("EXT_1");
    }

    var6 scripts\engine\utility::delaycall(var3, &destroy);
  }
}

function setup_hud_elem() {
  self.color = (1, 1, 1);
  self.alpha = 1;
  self.x = 0;
  self.alignx = "center";
  self.aligny = "middle";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.foreground = 1;
}

function assert_if_identical_origins() {
  var0 = [];

  for(var1 = 1; var1 < 65; var1++) {
    var2 = tablelookup("sp/intel_items.csv", 0, var1, 4);
    var3 = strtok(var2, ",");
    var1 = 0;

    if(var1 < var3.size) {
      GscBinSkip0(0x2e, var1, int(var3[var1]));
    }

    var0 = (var3[0], var3[1], var3[2]);
  }

  for(var1 = 0; var1 < var0.size; var1++) {
    if(!isDefined(var0[var1])) {
      continue;
    }

    if(var0[var1] == "undefined") {
      continue;
    }

    for(var4 = 0; var4 < var0.size; var4++) {
      if(!isDefined(var0[var4])) {
        continue;
      }

      if(var0[var4] == "undefined") {
        continue;
      }

      if(var1 == var4) {
        continue;
      }

      if(var0[var1] == var0[var4]) {}
    }
  }
}

function get_nums_from_origins(var0) {
  for(var1 = 1; var1 < level.table_origins.size + 1; var1++) {
    if(!isDefined(level.table_origins[var1])) {
      continue;
    }

    if(distancesquared(var0, level.table_origins[var1]) < squared(75)) {
      return var1;
    }
  }
}