/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\321.gsc
**************************************/

main() {
  if(maps\_utility::is_iw4_map_sp()) {
    return;
  }
  precachestring(&"SCRIPT_INTELLIGENCE_OF_FOURTYSIX");
  precachestring(&"SCRIPT_INTELLIGENCE_PREV_FOUND");
  level.intel_items = create_array_of_intel_items();
  setDvar("ui_level_cheatpoints", level.intel_items.size);
  level.intel_counter = 0;
  setDvar("ui_level_player_cheatpoints", level.intel_counter);
  level.table_origins = create_array_of_origins_from_table();
  initialize_intel();

  if(maps\_utility::is_specialop()) {
    remove_all_intel();
    return;
  }

  intel_think();
  wait 0.05;
}

remove_all_intel() {
  foreach(var_2, var_1 in level.intel_items) {
    if(!isDefined(var_1.removed)) {
      var_1 remove_intel_item();
    }
  }
}

remove_intel_item() {
  self.removed = 1;
  self.item hide();
  self.item notsolid();
  common_scripts\utility::trigger_off();
  level.intel_counter++;
  setDvar("ui_level_player_cheatpoints", level.intel_counter);
  self notify("end_trigger_thread");
}

initialize_intel() {
  foreach(var_3, var_1 in level.intel_items) {
    var_2 = var_1.origin;
    var_1.num = get_nums_from_origins(var_2);
  }
}

intel_think() {
  foreach(var_2, var_1 in level.intel_items) {
    if(var_1 check_item_found()) {
      var_1 remove_intel_item();
      continue;
    }

    var_1 thread wait_for_pickup();
    var_1 thread poll_for_found();
  }
}

poll_for_found() {
  self endon("end_loop_thread");

  while(!check_item_found()) {
    wait 0.1;
  }
  remove_intel_item();
}

check_item_found() {
  foreach(var_1 in level.players) {
    if(!var_1 getplayerintelisfound(self.num)) {
      return 0;
    }
  }

  return 1;
}

create_array_of_intel_items() {
  var_0 = getEntArray("intelligence_item", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].item = getEnt(var_0[var_1].target, "targetname");
    var_0[var_1].found = 0;
  }

  return var_0;
}

create_array_of_origins_from_table() {
  var_0 = [];

  for(var_1 = 1; var_1 <= 64; var_1++) {
    var_2 = tablelookup("maps/_intel_items.csv", 0, var_1, 4);

    if(isDefined(var_2) && var_2 != "undefined") {
      var_3 = strtok(var_2, ",");

      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_3[var_4] = int(var_3[var_4]);
      }
      var_0[var_1] = (var_3[0], var_3[1], var_3[2]);
      continue;
    }

    var_0[var_1] = undefined;
  }

  return var_0;
}

wait_for_pickup() {
  self endon("end_trigger_thread");

  if(self.classname == "trigger_use") {
    self setHintString(&"SCRIPT_INTELLIGENCE_PICKUP");
    self useTriggerRequireLookAt();
  }

  self waittill("trigger", var_0);
  self notify("end_loop_thread");
  intel_feedback(var_0);
  save_intel_for_all_players();
  updategamerprofileall();
  waittillframeend;
  remove_intel_item();
}

save_intel_for_all_players() {
  foreach(var_1 in level.players) {
    if(var_1 getplayerintelisfound(self.num)) {
      continue;
    }
    var_1 setplayerintelfound(self.num);
  }

  logstring("found intel item " + self.num);
  maps\_endmission::updatesppercent();
}

give_point() {
  var_0 = self getlocalplayerprofiledata("cheatPoints");
  self setlocalplayerprofiledata("cheatPoints", var_0 + 1);
}

intel_feedback(var_0) {
  self.item hide();
  self.item notsolid();
  level thread common_scripts\utility::play_sound_in_space("intelligence_pickup", self.item.origin);
  var_1 = 3000;
  var_2 = 700;
  var_3 = var_1 + var_2 / 1000;

  foreach(var_5 in level.players) {
    if(var_0 != var_5 && var_5 getplayerintelisfound(self.num)) {
      continue;
    }
    var_6 = var_5 maps\_hud_util::createserverclientfontstring("objective", 1.5);
    var_6.glowcolor = (0.7, 0.7, 0.3);
    var_6.glowalpha = 1;
    var_6 setup_hud_elem();
    var_6.y = -60;
    var_6 setpulsefx(60, var_1, var_2);
    var_7 = 0;

    if(var_0 == var_5 && var_5 getplayerintelisfound(self.num)) {
      var_6.label = &"SCRIPT_INTELLIGENCE_PREV_FOUND";
    } else {
      var_6.label = &"SCRIPT_INTELLIGENCE_OF_FOURTYSIX";
      var_5 give_point();
      var_7 = var_5 getlocalplayerprofiledata("cheatPoints");
      var_6 setvalue(var_7);
    }

    if(var_7 >= 22) {
      var_5 maps\_utility::player_giveachievement_wrapper("INFORMANT");
    }
    if(var_7 == 46) {
      var_5 maps\_utility::player_giveachievement_wrapper("SCOUT_LEADER");
    }
    var_6 common_scripts\utility::delaycall(var_3, ::destroy);
  }
}

setup_hud_elem() {
  self.color = (1, 1, 1);
  self.alpha = 1;
  self.x = 0;
  self.alignx = "center";
  self.aligny = "middle";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.foreground = 1;
}

assert_if_identical_origins() {
  var_0 = [];

  for(var_1 = 1; var_1 < 65; var_1++) {
    var_2 = tablelookup("maps/_intel_items.csv", 0, var_1, 4);
    var_3 = strtok(var_2, ",");

    for(var_1 = 0; var_1 < var_3.size; var_1++) {
      var_3[var_1] = int(var_3[var_1]);
    }
    var_0[var_1] = (var_3[0], var_3[1], var_3[2]);
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(var_0[var_1])) {
      continue;
    }
    if(var_0[var_1] == "undefined") {
      continue;
    }
    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      if(!isDefined(var_0[var_4])) {
        continue;
      }
      if(var_0[var_4] == "undefined") {
        continue;
      }
      if(var_1 == var_4) {
        continue;
      }
      if(var_0[var_1] == var_0[var_4]) {}
    }
  }
}

get_nums_from_origins(var_0) {
  for(var_1 = 1; var_1 < level.table_origins.size + 1; var_1++) {
    if(!isDefined(level.table_origins[var_1])) {
      continue;
    }
    if(distancesquared(var_0, level.table_origins[var_1]) < squared(75)) {
      return var_1;
    }
  }
}