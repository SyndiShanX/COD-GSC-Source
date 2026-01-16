/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_intelligence.gsc
********************************/

main() {
  if(!maps\_utility::is_h1_level()) {
    return;
  }
  precachestring(&"SCRIPT_INTELLIGENCE_OF_THIRTY");
  precacheshader("h1_hud_ammo_status_glow");
  precacheshader("h1_hud_ammo_status_scanlines");
  level.intel_items_total = 30;
  level.intel_items = create_array_of_intel_items();
  level.table_origins = create_array_of_origins_from_table();
  initialize_intel();
}

initialize_intel() {
  for (var_0 = 0; var_0 < level.intel_items.size; var_0++) {
    var_1 = level.intel_items[var_0];
    var_2 = var_1.origin;
    level.intel_items[var_0].num = get_nums_from_origins(var_2);

    if(level.intel_items[var_0] check_item_found()) {
      var_1.item hide();
      var_1.item notsolid();
      var_1 common_scripts\utility::trigger_off();
      level.intel_items[var_0].found = 1;
      continue;
    }

    level.intel_items[var_0] thread wait_for_pickup();
  }

  remove_found_intel();
}

remove_found_intel() {
  for (;;) {
    for (var_0 = 0; var_0 < level.intel_items.size; var_0++) {
      if(!isdefined(level.intel_items[var_0].removed) && level.intel_items[var_0] check_item_found()) {
        level.intel_items[var_0].removed = 1;
        level.intel_items[var_0].item hide();
        level.intel_items[var_0].item notsolid();
        level.intel_items[var_0] common_scripts\utility::trigger_off();
        level.intel_items[var_0] notify("end_trigger_thread");
      }
    }

    wait 0.1;
  }
}

check_item_found() {
  return level.player getplayerintelisfound(self.num);
}

create_array_of_intel_items() {
  var_0 = getentarray("intelligence_item", "targetname");

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].item = getent(var_0[var_1].target, "targetname");
    var_0[var_1].found = 0;
  }

  return var_0;
}

create_array_of_origins_from_table() {
  var_0 = [];

  for (var_1 = 1; var_1 <= level.intel_items_total; var_1++) {
    var_2 = tablelookup("sp\_intel_items.csv", 0, var_1, 4);

    if(isdefined(var_2) && var_2 != "undefined") {
      var_3 = strtok(var_2, ",");

      for (var_4 = 0; var_4 < var_3.size; var_4++)
        var_3[var_4] = int(var_3[var_4]);

      var_0[var_1] = (var_3[0], var_3[1], var_3[2]);
      continue;
    }

    var_0[var_1] = undefined;
  }

  return var_0;
}

wait_for_pickup() {
  self sethintstring(&"SCRIPT_INTELLIGENCE_PICKUP");
  self usetriggerrequirelookat();
  self endon("end_trigger_thread");
  self waittill("trigger");
  self.found = 1;
  common_scripts\utility::trigger_off();
  save_that_item_is_found();
  updategamerprofile();
  thread intel_feedback();
}

save_that_item_is_found() {
  level.player setplayerintelfound(self.num);
}

get_nums_from_origins(var_0) {
  for (var_1 = 1; var_1 < level.table_origins.size + 1; var_1++) {
    if(!isdefined(level.table_origins[var_1])) {
      continue;
    }
    if(distancesquared(var_0, level.table_origins[var_1]) < 25)
      return var_1;
  }
}

intel_feedback() {
  self.item hide();
  self.item notsolid();
  level thread common_scripts\utility::play_sound_in_space("intelligence_pickup", self.item.origin);
  var_0 = 3000;
  var_1 = 700;
  var_2 = maps\_hud_util::createicon("h1_hud_ammo_status_glow", 400, 75);
  var_2.color = (1, 0.95, 0.4);
  var_2.x = 0;
  var_2.y = -65;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "center";
  var_2.vertalign = "middle";
  var_2.foreground = 1;
  var_2.alpha = 0.0;
  var_3 = maps\_hud_util::createicon("h1_hud_ammo_status_scanlines", 800, 75);
  var_3.color = (1, 0.85, 0);
  var_3.x = 0;
  var_3.y = -65;
  var_3.alignx = "center";
  var_3.aligny = "middle";
  var_3.horzalign = "center";
  var_3.vertalign = "middle";
  var_3.foreground = 1;
  var_3.alpha = 0.0;
  var_4 = maps\_hud_util::createfontstring("objective", 1.5);
  var_4 setup_hud_elem();
  var_4 setpulsefx(19, var_0, var_1);
  var_4 setvalue(intel_found_total());
  var_5 = intel_found_total();

  if(var_5 == 15 || maps\_achievements::platform_tracks_progression())
    maps\_utility::giveachievement_wrapper("LOOK_SHARP");

  if(var_5 == 30 || maps\_achievements::platform_tracks_progression())
    maps\_utility::giveachievement_wrapper("EYES_AND_EARS");

  wait 0.7;
  var_2.alpha = 0.5;
  wait 0.05;
  var_3.alpha = 0.6;
  var_2 fadeovertime(0.035);
  var_2.alpha = 0.0;
  wait 0.05;
  var_3 fadeovertime(1.0);
  var_3.alpha = 0.0;
  wait((var_0 + var_1) / 1000);
  var_4 destroy();
  var_2 destroy();
  var_3 destroy();
}

setup_hud_elem() {
  self.fontscale = 1.2;
  self.glowcolor = (0.96, 0.81, 0);
  self.glowalpha = 0.2;
  self.color = (0.99, 0.97, 0.85);
  self.alpha = 1;
  self.x = 0;
  self.y = -65;
  self.alignx = "center";
  self.aligny = "middle";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.foreground = 1;
  self.label = & "SCRIPT_INTELLIGENCE_OF_THIRTY";
}

intel_found_total() {
  var_0 = 0;

  for (var_1 = 1; var_1 <= level.intel_items_total; var_1++) {
    if(level.player getplayerintelisfound(var_1))
      var_0++;
  }

  return var_0;
}