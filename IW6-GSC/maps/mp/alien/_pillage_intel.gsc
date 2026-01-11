/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_pillage_intel.gsc
********************************************/

create_intel_spots() {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  setdvar("scr_alien_intel_pillage", 1);
  level.intel_outline_func = ::intel_pillage_outline;
  level.intel_pillage_show_func = ::create_intel_from_pillage_spot;
  level.intel_pillage_allowed_func = ::intel_pillage_allowed_func;
  level.outline_intel_watch_list = [];
  level.intel_type_1 = [];
  level.intel_type_2 = [];
  create_intel_by_section("pillage_intel_section_hard");
}

create_intel_by_section(var_0) {
  var_1 = common_scripts\utility::getstructarray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_4 = common_scripts\utility::getstructarray(var_3.target, "targetname");
    var_3 create_intel_section(var_4);
  }
}

create_intel_section(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(isDefined(var_3.script_noteworthy)) {
      var_4 = strtok(var_3.script_noteworthy, " ");

      if(isDefined(var_4) && var_4.size > 1) {
        var_5 = "";

        foreach(var_7 in var_4) {
          var_5 = var_5 + var_7;
        }

        iprintln(var_5);
        var_4 = strtok(var_5, ",");
      } else
        var_4 = strtok(var_3.script_noteworthy, ",");

      var_3.intel_type = var_4[0];

      if(isDefined(var_4[1])) {
        var_3.script_model = var_4[1];
      }

      if(isDefined(var_4[2])) {
        var_3.location = var_4[2];
      }

      var_3.is_intel = 1;

      switch (var_3.intel_type) {
        case "intel_easy":
          var_3.type = 1;
          level.intel_type_1[level.intel_type_1.size] = var_3;
          break;
        case "intel_hard":
          var_3.type = 2;
          level.intel_type_2[level.intel_type_2.size] = var_3;
          break;
      }

      add_to_outline_intel_watch_list(var_3);
      var_3 thread intel_listener();
    }
  }
}

create_intel_from_pillage_spot(var_0) {
  var_1 = self;

  if(isDefined(self.pillageinfo)) {
    self.pillageinfo = undefined;
  }

  var_1.script_model = "cnd_cellphone_01_on";
  var_1.intel_type = "intel_easy";
  var_1.is_intel = 1;
  var_1.type = 1;
  level.intel_type_1[level.intel_type_1.size] = var_1;
  var_1.drop_override_func = ::drop_pillage_intel_on_ground;
  add_to_outline_intel_watch_list(var_1);
  var_1 thread intel_listener();
}

intel_pillage_allowed_func() {
  var_0 = 6;

  switch (level.script) {
    case "mp_alien_armory":
      var_0 = 6;
      break;
    case "mp_alien_beacon":
      var_0 = 4;
      break;
    case "mp_alien_dlc3":
      var_0 = 3;
      break;
    case "mp_alien_last":
      var_0 = 4;
      break;
    default:
      break;
  }

  var_1 = "intel_episode_" + level.extinction_episode + "_sequenced_count";

  if(self getcoopplayerdatareservedint(var_1) < var_0) {
    return 1;
  } else {
    return 0;
  }
}

init_player_intel_total() {
  var_0 = "NO_INTEL_ACHIEVEMENT";
  var_1 = 0;
  var_2 = getdvar("ui_mapname");

  switch (var_2) {
    case "mp_alien_armory":
      var_0 = "FOUND_ALL_INTELS";
      var_1 = 2;
      break;
    case "mp_alien_beacon":
      var_0 = "FOUND_ALL_INTELS_MAYDAY";
      break;
    case "mp_alien_dlc3":
      var_0 = "AWAKENING_ALL_INTEL";
      break;
    case "mp_alien_last":
      var_0 = "LAST_ALL_INTEL";
      break;
    default:
      break;
  }

  var_3 = self.achievement_list[var_0];

  if(isDefined(var_3)) {
    var_3.progress = aliens_get_intel_num_collected(self) - var_1;
    var_4 = self getcoopplayerdatareservedint("intel_episode_4_location_4");

    if(var_4 && var_2 == "mp_alien_last") {
      var_3.progress = var_3.progress - 1;
    }

    maps\mp\alien\_achievement::update_achievement(var_0, 0);
  }
}

intel_on_player_connect() {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  thread init_player_intel_total();
  wait 1.0;

  foreach(var_1 in level.intel_type_2) {
    if(has_player_found(var_1.location)) {
      turn_off_intel_for_player(var_1);
    }
  }
}

build_intel_pillageitem_arrays(var_0) {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  while(!isDefined(level.pillageinfo)) {
    wait 0.1;
  }

  switch (var_0) {
    case "easy":
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "intel", level.pillageinfo.easy_intel);
      break;
    case "medium":
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "intel", level.pillageinfo.medium_intel);
      break;
    case "hard":
      maps\mp\alien\_pillage::build_pillageitem_array(var_0, "intel", level.pillageinfo.hard_intel);
      break;
  }
}

has_player_found(var_0) {
  if(isDefined(var_0)) {
    var_1 = "intel_episode_" + level.extinction_episode + "_location_" + var_0;

    if(self getcoopplayerdatareservedint(var_1)) {
      return 1;
    }
  }

  return 0;
}

turn_off_intel_for_player(var_0) {
  var_0.pillage_trigger disableplayeruse(self);

  if(var_0.type == 2) {
    if(!isDefined(self.outline_player_intel_found_list)) {
      self.outline_player_intel_found_list = [];
    }

    if(!common_scripts\utility::array_contains(self.outline_player_intel_found_list, var_0)) {
      self.outline_player_intel_found_list[self.outline_player_intel_found_list.size] = var_0;
      var_0 thread wait_then_add_player_to_intel_array(self, 3.0);
    }
  }

  remove_from_outline_intel_watch_list(var_0);
}

wait_then_add_player_to_intel_array(var_0, var_1) {
  var_2 = var_0.name;
  wait(var_1);

  if(!isDefined(self.player_has_found_me)) {
    self.player_has_found_me = [];
  }

  self.player_has_found_me[var_2] = 1;
}

intel_listener() {
  self.pillage_trigger = spawn("script_model", self.origin);

  if(isDefined(self.script_model)) {
    self.pillage_trigger setModel(self.script_model);

    if(isDefined(self.angles)) {
      self.pillage_trigger.angles = self.angles;
    }
  } else
    self.pillage_trigger setModel("tag_origin");

  thread toggle_usablity_on_distance();
  self.pillage_trigger setcursorhint("HINT_NOICON");
  self.pillage_trigger makeusable();

  if(self.type == 1) {
    self.pillage_trigger sethintstring(&"ALIEN_PILLAGE_INTEL_PICKUP_INTEL");
  } else {
    self.pillage_trigger sethintstring(&"ALIEN_PILLAGE_INTEL_PICKUP_INTEL");
  }

  for(;;) {
    self.pillage_trigger waittill("trigger", var_0);

    if(self.type == 1 && var_0 intel_pillage_allowed_func()) {
      give_player_intel(var_0);
    }

    if(self.type == 2 && !var_0 has_player_found(self.location)) {
      give_player_intel(var_0);
    }
  }
}

aliens_get_intel_num_possible() {
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = getdvar("ui_mapname");

  switch (var_3) {
    case "mp_alien_armory":
      var_0 = 2;
      var_1 = 6;
      var_2 = 5;
      break;
    case "mp_alien_beacon":
      var_0 = 0;
      var_1 = 4;
      var_2 = 5;
      break;
    case "mp_alien_dlc3":
      var_0 = 0;
      var_1 = 3;
      var_2 = 3;
      break;
    case "mp_alien_last":
      var_0 = 0;
      var_1 = 4;
      var_2 = 4;
      break;
  }

  return var_0 + var_1 + var_2;
}

aliens_get_intel_num_collected(var_0) {
  var_1 = 0;
  var_2 = 5;
  var_3 = getdvar("ui_mapname");

  switch (var_3) {
    case "mp_alien_armory":
      var_1 = 2;
      var_2 = 5;
      break;
    case "mp_alien_beacon":
      var_1 = 0;
      var_2 = 5;
      break;
    case "mp_alien_dlc3":
      var_1 = 0;
      var_2 = 3;
      break;
    case "mp_alien_last":
      var_1 = 0;
      var_2 = 4;
      break;
  }

  var_4 = "intel_episode_" + level.extinction_episode + "_sequenced_count";
  var_5 = var_0 getcoopplayerdatareservedint(var_4);
  var_6 = 0;

  for(var_7 = 0; var_7 < var_2; var_7++) {
    var_8 = "intel_episode_" + level.extinction_episode + "_location_" + (var_7 + 1);

    if(var_0 getcoopplayerdatareservedint(var_8)) {
      var_6++;
    }
  }

  return var_1 + var_5 + var_6;
}

give_player_easter_egg_intel(var_0) {
  var_1 = "intel_episode_" + level.extinction_episode + "_location_4";

  if(var_0 getcoopplayerdatareservedint(var_1)) {
    return;
  }
  var_0 setclientomnvar("ui_alien_intel_num_collected", aliens_get_intel_num_collected(var_0) + 1);
  wait 0.5;
  var_0 notify("dlc_vo_notify", "intel_recovered", var_0);
  var_2 = 8;
  var_3 = get_vo_to_play(var_2);
  var_0 thread play_intel_pickup_vo(var_3);
  var_0 setclientomnvar("ui_alien_intercept_pickup", var_2);
  var_0 setcoopplayerdatareservedint(var_1, 1);
}

give_player_intel(var_0) {
  var_0 setclientomnvar("ui_alien_intel_num_collected", aliens_get_intel_num_collected(var_0) + 1);
  wait 0.5;
  var_1 = getdvar("ui_mapname");
  var_0 notify("dlc_vo_notify", "intel_recovered", var_0);

  if(isDefined(self.location) && self.type == 2) {
    var_2 = 0;

    switch (var_1) {
      case "mp_alien_armory":
        var_2 = 8;
        break;
      case "mp_alien_beacon":
        var_2 = 4;
        break;
      case "mp_alien_dlc3":
        var_2 = 3;
        break;
      case "mp_alien_last":
        var_2 = 4;
        break;
    }

    var_3 = int(self.location) + var_2;
    var_4 = get_vo_to_play(var_3);
    var_0 thread play_intel_pickup_vo(var_4);
    var_0 setclientomnvar("ui_alien_intercept_pickup", var_3);
    var_5 = "intel_episode_" + level.extinction_episode + "_location_" + self.location;
    var_0 setcoopplayerdatareservedint(var_5, 1);
    var_0 turn_off_intel_for_player(self);
    var_0 maps\mp\alien\_persistence::give_player_currency(500);
    var_0 maps\mp\alien\_persistence::give_player_xp(2500);
    var_0 maps\mp\alien\_achievement::update_intel_achievement();
  } else if(self.type == 1) {
    var_6 = 0;

    switch (var_1) {
      case "mp_alien_armory":
        var_6 = 3;
        break;
      case "mp_alien_beacon":
        var_6 = 1;
        break;
      case "mp_alien_dlc3":
        var_6 = 1;
        break;
      case "mp_alien_last":
        var_6 = 1;
        break;
    }

    var_7 = "intel_episode_" + level.extinction_episode + "_sequenced_count";
    var_8 = var_0 getcoopplayerdatareservedint(var_7);
    var_9 = var_8 + var_6;
    var_4 = get_vo_to_play(var_9);
    var_0 thread play_intel_pickup_vo(var_4);
    var_0 setclientomnvar("ui_alien_nightfall_pickup", var_9);
    var_0 setcoopplayerdatareservedint(var_7, var_8 + 1);
    var_0 maps\mp\alien\_achievement::update_intel_achievement();
    maps\mp\alien\_outline_proto::remove_outline(self.pillage_trigger);
    self.pillageinfo = spawnStruct();
    self.pillageinfo.type = undefined;
    maps\mp\alien\_pillage::delete_pillage_trigger();
    var_0 maps\mp\alien\_persistence::give_player_currency(500);
    var_0 maps\mp\alien\_persistence::give_player_xp(2500);
  }
}

play_intel_pickup_vo(var_0) {
  wait 1.0;

  if(soundexists(var_0)) {
    self playsoundtoplayer(var_0, self);
  }
}

get_vo_to_play(var_0) {
  if(!isDefined(level.intel_table)) {
    var_1 = getdvar("ui_mapname");

    switch (var_1) {
      case "mp_alien_armory":
        level.intel_table = "mp/alien/alien_armory_intel.csv";
        break;
      case "mp_alien_beacon":
        level.intel_table = "mp/alien/alien_beacon_intel.csv";
        break;
      case "mp_alien_dlc3":
        level.intel_table = "mp/alien/alien_dlc3_intel.csv";
        break;
      case "mp_alien_last":
        level.intel_table = "mp/alien/alien_last_intel.csv";
        break;
    }
  }

  var_2 = tablelookup(level.intel_table, 0, var_0, 15);
  return var_2;
}

drop_pillage_intel_on_ground(var_0) {
  if(self.pillage_trigger.model != "tag_origin") {
    var_1 = (0, 0, 20);
    var_2 = (0, 0, 1);
    var_3 = (0, 0, 0);
    var_4 = (0, 0, 6);
    var_5 = (0, 0, 0);
    var_6 = getgroundposition(self.pillage_trigger.origin + var_1, 2);

    switch (self.pillage_trigger.model) {
      case "cnd_cellphone_01_on":
        var_4 = var_2;
        var_5 = (0, 0, -90);
        break;
    }

    self.pillage_trigger.origin = var_6 + var_4;
    self.pillage_trigger.angles = var_5;
  }

  thread turn_off_pillage_intel_for_players();
}

turn_off_pillage_intel_for_players() {
  foreach(var_1 in level.players) {
    if(!var_1 intel_pillage_allowed_func()) {
      var_1 thread turn_off_intel_for_player(self);
    }
  }
}

toggle_usablity_on_distance() {
  self endon("death");
  self.pillage_trigger endon("death");
  var_0 = 1;
  var_1 = 2;
  var_2 = 1024;
  var_3 = 4900;

  if(self.type == var_0) {
    var_3 = 27225;
  }

  while(!isDefined(level.players)) {
    wait 0.1;
  }

  for(;;) {
    foreach(var_5 in level.players) {
      if(!isDefined(var_5) || !isalive(var_5)) {
        continue;
      }
      var_6 = 1;

      if(distancesquared(var_5.origin, self.pillage_trigger.origin) > var_3) {
        var_6 = 0;
      }

      if(distancesquared(var_5.origin, self.pillage_trigger.origin) < var_2 && should_display_already_found_message(var_5)) {
        var_5 maps\mp\_utility::setlowermessage("already_have_intel", &"ALIEN_PILLAGE_INTEL_ALREADY_HAVE_INTEL", 2);
        common_scripts\utility::waitframe();
        continue;
      }

      if(self.type == var_1 && var_5 has_player_found(self.location)) {
        var_5 turn_off_intel_for_player(self);
        var_6 = 0;
      } else if(self.type == var_0 && !var_5 intel_pillage_allowed_func()) {
        var_5 turn_off_intel_for_player(self);
        var_6 = 0;
      }

      if(isDefined(var_5.outline_player_intel_found_list) && common_scripts\utility::array_contains(var_5.outline_player_intel_found_list, self)) {
        var_6 = 0;
      }

      if(var_6) {
        enable_usability(var_5);
      } else {
        disable_usability(var_5);
      }

      common_scripts\utility::waitframe();
    }

    wait 0.1;
  }
}

should_display_already_found_message(var_0) {
  if(isDefined(self.player_has_found_me) && isDefined(self.player_has_found_me[var_0.name]) && self.player_has_found_me[var_0.name]) {
    return 1;
  }

  return 0;
}

enable_usability(var_0) {
  self.pillage_trigger enableplayeruse(var_0);
}

disable_usability(var_0) {
  self.pillage_trigger disableplayeruse(var_0);
}

intel_pillage_outline() {
  self endon("refresh_outline");

  foreach(var_3, var_1 in level.outline_intel_watch_list) {
    if(!isDefined(var_1) || !isDefined(var_1.pillage_trigger)) {
      continue;
    }
    var_2 = get_intel_item_outline_color(var_1);

    if(var_2 == 3) {
      maps\mp\alien\_outline_proto::enable_outline_for_player(var_1.pillage_trigger, self, 3, 0, "high");
    } else if(var_2 == 4) {
      maps\mp\alien\_outline_proto::enable_outline_for_player(var_1.pillage_trigger, self, 1, 0, "high");
    } else {
      maps\mp\alien\_outline_proto::disable_outline_for_player(var_1.pillage_trigger, self);
    }

    if(var_3 % 10 == 0) {
      common_scripts\utility::waitframe();
    }
  }
}

get_intel_item_outline_color(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0.pillage_trigger)) {
    return 0;
  }

  if(isDefined(self.outline_player_intel_found_list) && common_scripts\utility::array_contains(self.outline_player_intel_found_list, var_0)) {
    return 0;
  }

  if(var_0.type == 1) {
    var_1 = 27225;
  } else {
    var_1 = 4900;
  }

  var_2 = distancesquared(self.origin, var_0.origin) < var_1;

  if(!var_2) {
    return 0;
  }

  if(maps\mp\alien\_utility::is_holding_deployable() || maps\mp\alien\_utility::has_special_weapon()) {
    return 4;
  }

  return 3;
}

add_to_outline_intel_watch_list(var_0) {
  if(!common_scripts\utility::array_contains(level.outline_intel_watch_list, var_0)) {
    level.outline_intel_watch_list[level.outline_intel_watch_list.size] = var_0;
  }
}

remove_from_outline_intel_watch_list(var_0) {
  remove_outline_for_player(self, var_0.pillage_trigger);
}

remove_outline_for_player(var_0, var_1) {
  if(!isDefined(var_1) || !isDefined(var_0)) {
    return;
  }
  maps\mp\alien\_outline_proto::disable_outline_for_player(var_1, var_0);
}