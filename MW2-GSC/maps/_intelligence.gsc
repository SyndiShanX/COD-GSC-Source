/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_intelligence.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;

main() {
  precachestring(&"SCRIPT_INTELLIGENCE_OF_FOURTYFIVE");
  precachestring(&"SCRIPT_INTELLIGENCE_PREV_FOUND");
  level.intel_items = create_array_of_intel_items();
  println("intelligence.gsc: intelligence items:", level.intel_items.size);

  setDvar("ui_level_cheatpoints", level.intel_items.size);
  level.intel_counter = 0;
  setDvar("ui_level_player_cheatpoints", level.intel_counter);

  level.table_origins = create_array_of_origins_from_table();
  initialize_intel();

  if(is_specialop()) {
    remove_all_intel();
    return;
  }

  intel_think();

  wait .05;
}

remove_all_intel() {
  foreach(index, trigger in level.intel_items) {
    if(!isDefined(trigger.removed))
      trigger remove_intel_item();
  }
}

remove_intel_item() {
  self.removed = true;
  self.item hide();
  self.item notsolid();
  self trigger_off();

  level.intel_counter++;
  setDvar("ui_level_player_cheatpoints", level.intel_counter);

  self notify("end_trigger_thread");

  println("^3Removed Intel: " + self.num);
}

initialize_intel() {
  foreach(index, trigger in level.intel_items) {
    origin = trigger.origin;
    trigger.num = get_nums_from_origins(origin);
  }
}

intel_think() {
  foreach(index, trigger in level.intel_items) {
    if(trigger check_item_found()) {
      trigger remove_intel_item();
    } else {
      trigger thread wait_for_pickup();
      trigger thread poll_for_found();
    }
  }
}
poll_for_found() {
  self endon("end_loop_thread");

  while(!self check_item_found())
    wait .1;

  self remove_intel_item();
}

check_item_found() {
  foreach(player in level.players) {
    if(!player GetPlayerIntelIsFound(self.num))
      return false;
  }
  return true;
}

create_array_of_intel_items() {
  intelligence_items = getEntArray("intelligence_item", "targetname");
  for(i = 0; i < intelligence_items.size; i++) {
    println(intelligence_items[i].origin);
    intelligence_items[i].item = getent(intelligence_items[i].target, "targetname");
    intelligence_items[i].found = false;
  }
  return intelligence_items;
}

create_array_of_origins_from_table() {
  origins = [];
  for(num = 1; num <= 64; num++) {
    location = tablelookup("maps/_intel_items.csv", 0, num, 4);
    if(isDefined(location) && (location != "undefined")) {
      locArray = strTok(location, ",");
      assert(locArray.size == 3);
      for(i = 0; i < locArray.size; i++)
        locArray[i] = int(locArray[i]);
      origins[num] = (locArray[0], locArray[1], locArray[2]);
    } else {
      origins[num] = undefined;
    }
  }
  return origins;
}

wait_for_pickup() {
  self endon("end_trigger_thread");

  if(self.classname == "trigger_use") {
    self setHintString(&"SCRIPT_INTELLIGENCE_PICKUP");
    self usetriggerrequirelookat();
  }

  self waittill("trigger", player);
  self notify("end_loop_thread");

  self intel_feedback(player);
  self save_intel_for_all_players();
  UpdateGamerProfileAll();

  waittillframeend;

  self remove_intel_item();
}

save_intel_for_all_players() {
  assert(!self check_item_found());

  foreach(player in level.players) {
    if(player GetPlayerIntelIsFound(self.num)) {
      continue;
    }
    player SetPlayerIntelFound(self.num);
  }
  logString("found intel item " + self.num);

  PrintLn(">> SP PERCENT UPDATE - save_intel_for_all_players()");

  maps\_endmission::updateSpPercent();
}

give_point() {
  curValue = (self GetLocalPlayerProfileData("cheatPoints"));
  self SetLocalPlayerProfileData("cheatPoints", curValue + 1);
}

intel_feedback(found_by_player) {
  self.item hide();
  self.item notsolid();
  level thread play_sound_in_space("intelligence_pickup", self.item.origin);

  display_time = 3000;
  fade_time = 700;
  delete_time = display_time + fade_time / 1000;

  foreach(player in level.players) {
    if(found_by_player != player && player GetPlayerIntelIsFound(self.num)) {
      continue;
    }
    remaining_print = player createClientFontString("objective", 1.5);
    remaining_print.glowColor = (0.7, 0.7, 0.3);
    remaining_print.glowAlpha = 1;
    remaining_print setup_hud_elem();
    remaining_print.y = -60;
    remaining_print SetPulseFX(60, display_time, fade_time);

    intel_found = 0;

    if(found_by_player == player && player GetPlayerIntelIsFound(self.num))
      remaining_print.label = &"SCRIPT_INTELLIGENCE_PREV_FOUND";
    else {
      remaining_print.label = &"SCRIPT_INTELLIGENCE_OF_FOURTYFIVE";
      player give_point();
      intel_found = (player GetLocalPlayerProfileData("cheatPoints"));
      remaining_print setValue(intel_found);
    }

    if(intel_found == 22)
      player maps\_utility::player_giveachievement_wrapper("THE_ROAD_LESS_TRAVELED");

    if(intel_found == 45)
      player maps\_utility::player_giveachievement_wrapper("LEAVE_NO_STONE_UNTURNED");

    remaining_print delaycall(delete_time, ::Destroy);
  }
}

setup_hud_elem() {
  self.color = (1, 1, 1);
  self.alpha = 1;
  self.x = 0;
  self.alignx = "center";
  self.aligny = "middle";
  self.horzAlign = "center";
  self.vertAlign = "middle";
  self.foreground = true;
}

assert_if_identical_origins() {
  origins = [];
  for(i = 1; i < 65; i++) {
    location = tablelookup("maps/_intel_items.csv", 0, i, 4);
    locArray = strTok(location, ",");

    for(i = 0; i < locArray.size; i++)
      locArray[i] = int(locArray[i]);
    origins[i] = (locArray[0], locArray[1], locArray[2]);
  }

  for(i = 0; i < origins.size; i++) {
    if(!isDefined(origins[i]))
      continue;
    if(origins[i] == "undefined")
      continue;
    for(j = 0; j < origins.size; j++) {
      if(!isDefined(origins[j]))
        continue;
      if(origins[j] == "undefined")
        continue;
      if(i == j)
        continue;
      if(origins[i] == origins[j])
        assertmsg("intel items in maps/_intel_items.csv with identical origins (" + origins[i] + ") ");
    }
  }
}

get_nums_from_origins(origin) {
  for(i = 1; i < level.table_origins.size + 1; i++) {
    if(!isDefined(level.table_origins[i]))
      continue;
    if(distancesquared(origin, level.table_origins[i]) < squared(75))
      return i;
  }

  assertmsg("Add the origin of this intel item ( " + origin + " ) to maps/_intel_items.csv file");
}