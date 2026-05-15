/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_music_and_dialog_dlc.gsc
***************************************************/

dlc_vo_init_on_player_spawn() {
  if(!isDefined(level.use_dlc_vo)) {
    level.use_dlc_vo = 1;
    level thread vo_listener_init();
    level thread check_for_drill_planted();
    level thread check_for_direction_vo();
  }

  thread vo_listener_player_init();
  thread check_for_reloading();
  thread check_for_last_stand();
  thread check_for_grenade_throw();
}

vo_listener_init() {
  var_0 = [];
  var_0["drill_repair"] = ::playvofordrillrepair;
  var_0["drill_repaired"] = ::playvofordrillrepaircomplete;
  var_0["drill_planted"] = ::playvofordrillonline;
  var_0["inform_explosives"] = ::playvoforexplosives;
  var_0["inform_reloading_generic"] = ::playvoforreloading;
  var_0["inform_shield"] = ::playvoforriotshield;
  var_0["online_mk32"] = ::playvoformk32;
  var_0["online_vulture"] = ::playvoforvulture;
  var_0["ready_incendiaryrounds"] = ::playvoforincendiaryammo;
  var_0["ready_explosiverounds"] = ::playvoforexplosiveammo;
  var_0["inbound_brute"] = ::playvoforbrutespawn;
  var_0["reaction_casualty_generic"] = ::player_casualty_vo;
  var_0["direction_vo"] = ::playdirectionvo;
  var_0["to_gate"] = ::playtogatevo;
  var_0["tesla_generator_basic"] = ::playvofortesla;
  var_0["tesla_generator_med"] = ::playvofortesla;
  var_0["tesla_generator_adv"] = ::playvofortesla;
  var_0["pipe_bomb"] = ::playvoforpipebomb;
  var_0["sticky_flare"] = ::playvoforstickyflare;
  var_0["pet_trap"] = ::playvoforhypnotrap;
  var_0["venom_basic"] = ::playvoforvenom;
  var_0["venom_basic_alt"] = ::playvoforvenom;
  var_0["venom_lightning"] = ::playvoforvenom;
  var_0["venom_fire"] = ::playvoforvenom;
  var_0["venom_turret"] = ::playvoforvenom;

  if(level.script == "mp_alien_armory") {
    var_0["spider_vo"] = ::playspidervo;
    var_0["spider_retreat"] = ::playspiderretreatvo;
  }

  if(level.script == "mp_alien_beacon") {
    var_0["open_door_move"] = ::playvofordooropen;
    var_0["inbound_seeder"] = ::playvoforseederspawn;
  }

  if(level.script == "mp_alien_dlc3") {
    var_0["inbound_mammoth"] = ::playvoformammothspawn;
    var_0["phantom_backup"] = ::playvoformammothpound;
    var_0["warn_dig"] = ::playvoformammothburrow;
    var_0["warn_underground"] = ::playvoformammothunderground;
    var_0["warn_emerge"] = ::playvoformammothemerge;
    var_0["inbound_gargoyle"] = ::playvoforgargoylespawn;
    var_0["inbound_bomber"] = ::playvoforbomberspawn;
    var_0["bomber_attack"] = ::playvoforbomberattack;
  }

  if(level.script == "mp_alien_last") {
    var_0["inbound_mammoth"] = ::playvoformammothspawn;
    var_0["phantom_backup"] = ::playvoformammothpound;
    var_0["warn_dig"] = ::playvoformammothburrow;
    var_0["warn_underground"] = ::playvoformammothunderground;
    var_0["warn_emerge"] = ::playvoformammothemerge;
    var_0["inbound_gargoyle"] = ::playvoforgargoylespawn;
    var_0["inbound_bomber"] = ::playvoforbomberspawn;
    var_0["bomber_attack"] = ::playvoforbomberattack;
  }

  if(isDefined(level.level_specific_vo_callouts)) {
    var_0 = [[level.level_specific_vo_callouts]](var_0);
  }

  for(;;) {
    level waittill("dlc_vo_notify", var_1, var_2);

    if(isDefined(var_0[var_1])) {
      if(isDefined(var_2)) {
        level thread[[var_0[var_1]]](var_2);
        continue;
      }

      level thread[[var_0[var_1]]]();
    }
  }
}

vo_listener_player_init() {
  self endon("disconnect");
  self endon("death");
  var_0 = [];
  var_0["intel_recovered"] = ::playvoforintelrecovered;
  var_0["elite_killed"] = ::playvoforneutralizedalien;
  var_0["spitter_killed"] = ::playvoforneutralizedalien;
  var_0["locust_killed"] = ::playvoforneutralizedalien;
  var_0["gargoyle_killed"] = ::playvoforkilledgargoyle;
  var_0["pain"] = ::player_dlc_pain_vo;
  var_0["bleeding_out"] = ::playvoforlaststand;
  var_0["weapon"] = ::playvoforweaponcraftingpiece;
  var_0["grenade"] = ::playvoforcraftingpiece;
  var_0["tesla"] = ::playvoforcraftingpiece;
  var_0["trap"] = ::playvoforcraftingpiece;

  for(;;) {
    self waittill("dlc_vo_notify", var_1, var_2);

    if(isDefined(var_0[var_1])) {
      if(isDefined(var_2)) {
        level thread[[var_0[var_1]]](var_2);
        continue;
      }

      level thread[[var_0[var_1]]]();
    }
  }
}

playvofordrillrepair(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  if(!isDefined(var_0) || !isalive(var_0) || var_0 maps\mp\alien\_utility::is_in_laststand()) {
    return;
  }
  if(level.script == "mp_alien_last") {
    level notify("dlc_vo_notify", "last_vo", "conduit_repairing");
    return;
  }

  var_1 = var_0.vo_prefix + "drill_repair";
  var_0 play_vo_on_player(var_1, undefined, 2);
}

playvofordrillrepaircomplete(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  if(!isDefined(var_0) || !isalive(var_0) || var_0 maps\mp\alien\_utility::is_in_laststand()) {
    return;
  }
  if(level.script == "mp_alien_last") {
    level notify("dlc_vo_notify", "last_vo", "conduit_repaired");
    return;
  }

  var_1 = var_0.vo_prefix + "drill_repaired";
  var_0 play_vo_on_player(var_1, undefined, 2);
}

playvofordrillonline(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  if(!isDefined(var_0) || !isalive(var_0) || var_0 maps\mp\alien\_utility::is_in_laststand()) {
    return;
  }
  if(level.script == "mp_alien_last") {
    level notify("dlc_vo_notify", "last_vo", "conduit_start");
    return;
  }

  var_1 = var_0.vo_prefix + "online_drill";
  var_0 play_vo_on_player(var_1, undefined, 5);
}

playvoforexplosives(var_0) {
  var_1 = var_0.vo_prefix + "inform_explosives";

  if(maps\mp\alien\_utility::isplayingsolo()) {
    if(randomint(100) > 50) {
      return;
    }
    var_1 = var_0.vo_prefix + "equip_ammo_solo";
  }

  var_0 thread play_vo_on_player(var_1);
}

playvoforreloading(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  var_1 = 60000;
  var_2 = gettime();

  if(!isDefined(var_0.next_reload_vo_time)) {
    var_0.next_reload_vo_time = var_2 + randomintrange(var_1, var_1 + 2000);
  } else if(var_2 < var_0.next_reload_vo_time) {
    return;
  }
  var_3 = var_0.vo_prefix + "inform_reloading_generic";
  var_0 thread play_vo_on_player(var_3, undefined, 1);
  var_0.next_reload_vo_time = var_2 + randomintrange(var_1, var_1 + 1500);
}

check_for_reloading() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("reload_start");
    var_0 = self getcurrentweapon();
    var_1 = weaponclipsize(var_0);
    var_2 = self getcurrentweaponclipammo();

    if(var_2 < var_1 / 3) {
      level notify("dlc_vo_notify", "inform_reloading_generic", self);
    }
  }
}

check_for_grenade_throw() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "iw6_aliendlc21_mp") {
      level notify("dlc_vo_notify", "sticky_flare", self);
    }

    if(var_1 == "iw6_aliendlc22_mp") {
      level notify("dlc_vo_notify", "pipe_bomb", self);
    }
  }
}

playvoforriotshield(var_0) {
  var_1 = var_0.vo_prefix + "inform_shield";

  if(maps\mp\alien\_utility::isplayingsolo()) {
    if(randomint(100) > 50) {
      return;
    }
    var_1 = var_0.vo_prefix + "equip_ammo_solo";
  }

  var_0 thread play_vo_on_player(var_1);
}

playvofortesla(var_0) {
  var_1 = var_0.vo_prefix + "tesla_live";
  var_0 thread play_vo_on_player(var_1);
}

playvoforpipebomb(var_0) {
  var_1 = var_0.vo_prefix + "pipebomb_live";

  if(randomint(100) > 20) {
    return;
  }
  var_0 thread play_vo_on_player(var_1);
}

playvoforstickyflare(var_0) {
  var_1 = var_0.vo_prefix + "sticky_live";

  if(maps\mp\alien\_utility::isplayingsolo()) {
    if(randomint(100) > 50) {
      return;
    }
  }

  var_0 thread play_vo_on_player(var_1);
}

playvoforhypnotrap(var_0) {
  var_1 = var_0.vo_prefix + "hypno_live";
  var_0 thread play_vo_on_player(var_1);
}

playvoforvenom(var_0) {
  var_1 = var_0.vo_prefix + "venom_live";

  if(maps\mp\alien\_utility::isplayingsolo()) {
    if(randomint(100) > 50) {
      return;
    }
  }

  var_0 thread play_vo_on_player(var_1);
}

playvoforcraftingpiece(var_0) {
  var_1 = var_0.vo_prefix + "pickup_crafting";
  var_2 = 30000;
  var_3 = gettime();

  if(!isDefined(var_0.next_crafting_vo_time)) {
    var_0.next_crafting_vo_time = var_3 + randomintrange(var_2, var_2 + 2000);
  } else if(var_3 < var_0.next_crafting_vo_time) {
    return;
  }
  var_0 play_vo_on_player(var_1, undefined, undefined, undefined, undefined, 1);
  var_0.next_crafting_vo_time = var_3 + randomintrange(var_2, var_2 + 1500);
}

playvoforweaponcraftingpiece(var_0) {
  var_1 = var_0.vo_prefix + "pickup_weapon";
  var_2 = 30000;
  var_3 = gettime();

  if(!isDefined(var_0.next_crafting_vo_time)) {
    var_0.next_crafting_vo_time = var_3 + randomintrange(var_2, var_2 + 2000);
  } else if(var_3 < var_0.next_crafting_vo_time) {
    return;
  }
  var_0 play_vo_on_player(var_1, undefined, undefined, undefined, undefined, 1);
  var_0.next_crafting_vo_time = var_3 + randomintrange(var_2, var_2 + 1500);
}

playvoforintelrecovered(var_0) {
  wait 0.25;

  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  if(!isDefined(var_0) || !isalive(var_0)) {
    return;
  }
  var_1 = var_0.vo_prefix + "intel_recovered";
  var_0 play_vo_on_player(var_1);
}

playvoformk32(var_0) {
  var_1 = var_0.vo_prefix + "online_mk32";
  var_0 play_vo_on_player(var_1);
}

playvoforvulture(var_0) {
  var_1 = var_0.vo_prefix + "online_vulture";
  var_0 play_vo_on_player(var_1);
}

playvoforincendiaryammo(var_0) {
  var_1 = var_0.vo_prefix + "ready_incendiaryrounds";

  if(maps\mp\alien\_utility::isplayingsolo()) {
    if(randomint(100) > 50) {
      return;
    }
    var_1 = var_0.vo_prefix + "equip_ammo_solo";
  }

  var_0 thread play_vo_on_player(var_1);
}

playvoforexplosiveammo(var_0) {
  var_1 = var_0.vo_prefix + "ready_explosiverounds";

  if(maps\mp\alien\_utility::isplayingsolo()) {
    if(randomint(100) > 50) {
      return;
    }
    var_1 = var_0.vo_prefix + "equip_ammo_solo";
  }

  var_0 thread play_vo_on_player(var_1);
}

playvoforbrutespawn(var_0) {
  wait 3;

  if(!isDefined(var_0)) {
    return;
  }
  if(randomint(100) > 10) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players(1, var_0.origin);

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];
  var_3 = var_2.vo_prefix + "inbound_brute";
  var_2 play_vo_on_player(var_3);
}

playvoforseederspawn(var_0) {
  wait 3;

  if(!isDefined(var_0)) {
    return;
  }
  if(randomint(100) > 50) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players(1, var_0.origin);

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];
  var_3 = var_2.vo_prefix + "warn_seeder";
  var_2 play_vo_on_player(var_3);
}

playvoformammothspawn(var_0) {
  wait 3;

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players(1, var_0.origin);

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];
  var_3 = var_2.vo_prefix + "warn_mammoth";
  var_2 play_vo_on_player(var_3, undefined, 5);
}

playvoformammothpound(var_0) {
  playvoformammoth("phantom_backup", var_0);
}

playvoformammothburrow(var_0) {
  playvoformammoth("warn_dig", var_0);
}

playvoformammothunderground(var_0) {
  playvoformammoth("warn_underground", var_0);
}

playvoformammothemerge(var_0) {
  playvoformammoth("warn_emerge", var_0);
}

playvoformammoth(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = 15000;
  var_3 = gettime();

  if(!isDefined(level.next_mammoth_vo_time)) {
    level.next_mammoth_vo_time = var_3 + randomintrange(var_2, var_2 + 2000);
  } else if(var_3 < level.next_mammoth_vo_time) {
    return;
  }
  if(var_0 == "warn_dig" && randomint(2) == 0) {
    return;
  }
  var_4 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_4.size < 1) {
    return;
  }
  var_5 = var_4[0];

  if(!soundexists(var_5.vo_prefix + var_0)) {
    iprintln("mammoth vo: " + var_5.vo_prefix + var_0);
    return;
  }

  var_6 = var_5.vo_prefix + var_0;
  level.next_mammoth_vo_time = var_3 + randomintrange(var_2, var_2 + 1500);
  var_5 play_vo_on_player(var_6, undefined, 3);
}

playvoforgargoylespawn(var_0) {
  wait 3;

  if(!isDefined(var_0)) {
    return;
  }
  if(randomint(100) > 50) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players(1, var_0.origin);

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];
  var_3 = var_2.vo_prefix + "spawn_gargoyle";
  var_2 play_vo_on_player(var_3);
}

playvoforbomberspawn(var_0) {
  wait 3;

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 5000;
  var_2 = gettime();

  if(!isDefined(level.next_bomber_spawn_vo_time)) {
    level.next_bomber_spawn_vo_time = var_2 + randomintrange(var_1, var_1 + 2000);
  } else if(var_2 < level.next_bomber_spawn_vo_time) {
    return;
  }
  var_3 = maps\mp\alien\_utility::get_array_of_valid_players(1, var_0.origin);

  if(var_3.size < 1) {
    return;
  }
  var_4 = var_3[0];
  var_5 = ["spotted_bats", "spawn_bats"];
  var_6 = var_4.vo_prefix + common_scripts\utility::random(var_5);
  level.next_bomber_spawn_vo_time = var_2 + randomintrange(var_1, var_1 + 1500);
  var_4 play_vo_on_player(var_6);
}

playvoforbomberattack(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 15000;
  var_2 = gettime();

  if(!isDefined(level.next_bomber_vo_time)) {
    level.next_bomber_vo_time = var_2 + randomintrange(var_1, var_1 + 2000);
  } else if(var_2 < level.next_bomber_vo_time) {
    return;
  }
  if(randomint(100) > 50) {
    return;
  }
  var_3 = maps\mp\alien\_utility::get_array_of_valid_players(1, var_0.origin);

  if(var_3.size < 1) {
    return;
  }
  var_4 = var_3[0];
  var_5 = var_4.vo_prefix + "warn_bats";
  level.next_bomber_vo_time = var_2 + randomintrange(var_1, var_1 + 1500);
  var_4 play_vo_on_player(var_5, undefined, 1);
}

playvoforneutralizedalien(var_0) {
  var_1 = var_0.vo_prefix + "neutralized_alien";

  if(maps\mp\alien\_utility::isplayingsolo()) {
    if(randomint(100) > 50) {
      return;
    }
  }

  var_0 thread play_vo_on_player(var_1, undefined, 3);
}

playvoforkilledgargoyle(var_0) {
  var_1 = var_0.vo_prefix + "defeat_gargoyle";

  if(maps\mp\alien\_utility::isplayingsolo()) {
    if(randomint(100) > 50) {
      return;
    }
  }

  var_0 thread play_vo_on_player(var_1, undefined, 3);
}

playvofordooropen(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  if(randomint(100) > 50) {
    return;
  }
  var_1 = 0;
  var_2 = 10;

  while(maps\mp\agents\_agent_utility::getactiveagentsoftype("alien").size > 0) {
    wait 1;
    var_1++;

    if(var_1 > var_2) {
      return;
    }
  }

  var_3 = maps\mp\alien\_utility::get_array_of_valid_players(1, var_0.origin);

  if(var_3.size < 1) {
    return;
  }
  var_4 = var_3[0];
  var_5 = var_4.vo_prefix + "open_door_move";
  var_4 play_vo_on_player(var_5, undefined, 5);
}

player_dlc_pain_vo(var_0) {
  var_1 = 1500;
  var_2 = gettime();

  if(level.script == "mp_alien_last" && maps\mp\alien\_utility::is_true(var_0.vo_system_playing_vo)) {
    return;
  }
  if(!isDefined(var_0.next_pain_vo_time)) {
    var_0.next_pain_vo_time = var_2 + randomintrange(var_1, var_1 + 2000);
  } else if(var_2 < var_0.next_pain_vo_time) {
    return;
  }
  var_3 = var_0.vo_prefix + "pain";

  if(soundexists(var_0.vo_prefix + "plr_" + "pain")) {
    var_0 playlocalsound(var_0.vo_prefix + "plr_" + "pain");
  } else {
    var_0 playlocalsound(var_3);
  }

  var_0.next_pain_vo_time = var_2 + randomintrange(var_1, var_1 + 1500);
}

is_vo_system_playing() {
  foreach(var_1 in level.players) {
    if(maps\mp\alien\_utility::is_true(var_1.vo_system_playing_vo)) {
      return 1;
    }
  }

  return 0;
}

remove_drill_vo_once_repaired() {
  for(;;) {
    while(!isDefined(level.drill)) {
      wait 0.1;
    }

    level.drill waittill("drill_repaired");

    foreach(var_1 in level.players) {
      var_1 thread remove_drill_vo_on_player("drill_hot");
      var_1 thread remove_drill_vo_on_player("drill_repair");
    }
  }
}

remove_drill_vo_once_complete() {
  for(;;) {
    level waittill("drill_planted");
    level.drill waittill("drill_complete");

    foreach(var_1 in level.players) {
      var_1 thread remove_drill_vo_on_player("drill_attacked");
      var_1 thread remove_drill_vo_on_player("drill_repaired");
      var_1 thread remove_drill_vo_on_player("drill_halfway");
    }
  }
}

remove_drill_vo_on_player(var_0) {
  foreach(var_3, var_2 in level.alien_vo_priority_level) {
    maps\mp\alien\_music_and_dialog::remove_vo_data(var_0, var_2);
  }
}

player_casualty_vo(var_0) {
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players();
  var_1 = common_scripts\utility::array_remove(var_1, var_0);

  if(var_1.size < 1) {
    return;
  }
  var_0 = var_1[0];
  var_2 = var_0.vo_prefix + "reaction_casualty_generic";
  var_0 play_vo_on_player(var_2, undefined, 1);
}

playtogatevo() {
  level endon("stop_dlc_vo_notify_to_gate");
  wait 20;
  var_0 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_0.size < 1) {
    return;
  }
  var_1 = var_0[0];
  var_2 = var_1.vo_prefix + "to_gate";
  var_1 play_vo_on_player(var_2);
}

playvoforlaststand(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  var_1 = var_0.vo_prefix + "last_stand";
  var_0 thread play_vo_on_player(var_1, undefined, 1);
}

play_vo_on_player(var_0, var_1, var_2, var_3, var_4, var_5) {
  maps\mp\alien\_music_and_dialog::play_vo_on_player(var_0, var_1, var_2, var_3, var_4, var_5);
}

check_for_last_stand() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    self waittill("last_stand");
    downed_sequence_vo_handler();
  }
}

check_for_drill_planted() {
  for(;;) {
    level waittill("drill_planted", var_0);
    level notify("dlc_vo_notify", "drill_planted", var_0);
  }
}

downed_sequence_vo_handler() {
  self endon("disconnect");
  self endon("death");
  self endon("revive");
  wait 4.0;
  level notify("dlc_vo_notify", "reaction_casualty_generic", self);
  wait 10.0;

  while(self.being_revived) {
    wait 0.1;
  }

  self notify("dlc_vo_notify", "bleeding_out", self);
  wait 8.0;

  while(self.being_revived) {
    wait 0.1;
  }

  self notify("dlc_vo_notify", "bleeding_out", self);
}

playdirectionvo(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];
  var_3 = 10000;
  var_4 = gettime();
  var_5 = 0;

  if(!isDefined(level.next_direction_vo_time)) {
    level.next_direction_vo_time = var_4 + randomintrange(var_3, var_3 + 2000);
  } else if(var_4 < level.next_direction_vo_time) {
    return;
  }
  if(!isDefined(level.last_direction_vo) || level.last_direction_vo != var_0) {
    level.last_direction_vo = var_0;
    var_5 = 0;
  } else if(level.last_direction_vo == var_0) {
    level.next_direction_vo_time = var_4 + randomintrange(var_3, var_3 + 1500);
    var_5++;

    if(var_5 > 5) {
      level.last_direction_vo = undefined;
    }

    return;
  }

  level.next_direction_vo_time = var_4 + randomintrange(var_3, var_3 + 1500);

  if(var_0 == "rooftop") {
    var_0 = "roof";
  }

  if(var_0 == "security_gate") {
    var_0 = "gate";
  }

  var_6 = var_2.vo_prefix + "from_" + var_0;

  if(var_0 == "spawn_vent" || var_0 == "spawn_grate") {
    var_6 = var_2.vo_prefix + var_0;
  }

  if(var_0 == "above" || var_0 == "walls" || var_0 == "spores") {
    var_6 = var_2.vo_prefix + "spawn_" + var_0;
  }

  var_2 play_vo_on_player(var_6, undefined, 1);
}

check_for_direction_vo() {
  var_0 = getEntArray("vo_direction_trigger", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread notify_when_triggered(var_2.script_noteworthy);
  }
}

notify_when_triggered(var_0) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(isagent(var_1) && isDefined(var_1.team) && var_1.team == "axis" && isDefined(var_1.alien_type) && var_1.alien_type != "spider") {
      if(isDefined(level.current_direction_triggers)) {
        if(!is_in_array(level.current_direction_triggers, var_0)) {
          continue;
        }
      }

      level notify("dlc_vo_notify", "direction_vo", var_0);
    }

    wait 0.25;
  }
}

playspidervo(var_0) {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_1.size < 1) {
    return;
  }
  var_2 = var_1[0];

  if(!soundexists(var_2.vo_prefix + var_0)) {
    return;
  }
  var_3 = 10000;
  var_4 = gettime();
  var_5 = 0;

  if(!isDefined(level.next_spider_vo_time)) {
    level.next_spider_vo_time = var_4 + randomintrange(var_3, var_3 + 2000);
  } else if(var_4 < level.next_spider_vo_time) {
    return;
  }
  if(!isDefined(level.last_spider_vo) || level.last_spider_vo != var_0) {
    level.last_spider_vo = var_0;
    var_5 = 0;
  } else if(level.last_spider_vo == var_0) {
    level.next_spider_vo_time = var_4 + randomintrange(var_3, var_3 + 1500);
    var_5++;

    if(var_5 > 5) {
      level.last_spider_vo = undefined;
    }

    return;
  }

  level.next_direction_vo_time = var_4 + randomintrange(var_3, var_3 + 1500);
  var_6 = var_2.vo_prefix + var_0;
  var_2 play_vo_on_player(var_6);
}

playspiderretreatvo() {
  if(maps\mp\alien\_utility::isplayingsolo()) {
    return;
  }
  var_0 = maps\mp\alien\_utility::get_array_of_valid_players();

  if(var_0.size < 1) {
    return;
  }
  var_1 = var_0[0];
  var_2 = var_1.vo_prefix + "spider_retreat";
  var_1 play_vo_on_player(var_2);
}

is_in_array(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] == var_1) {
      return 1;
    }
  }

  return 0;
}