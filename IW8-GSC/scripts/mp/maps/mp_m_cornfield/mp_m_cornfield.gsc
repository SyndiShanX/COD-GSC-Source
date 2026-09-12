/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_cornfield\mp_m_cornfield.gsc
*************************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  _questtimerwait::keypad_check_levelinput();
  level.ref_13d50 = 1;
  scripts\mp\maps\mp_m_cornfield\mp_m_cornfield_precache::main();
  scripts\mp\maps\mp_m_cornfield\gen\mp_m_cornfield_art::main();
  scripts\mp\maps\mp_m_cornfield\mp_m_cornfield_fx::main();
  scripts\mp\maps\mp_m_cornfield\mp_m_cornfield_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_cornfield", "codcaster_compass_map_mp_m_cornfield");
  scripts\cp_mp\utility\game_utility::ref_12b3b();
  level.requiresminstartspawns = 0;
  setDvar("r_umbraMinObjectContribution", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread clear_player_class_and_super();
  thread monitor();
}

function ref_12d7c(var_0) {
  var_0 setCanDamage(1);

  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    var_0 rotateTo((0, randomint(360), 0), 1, 0, 0.5);
    waitframe();
  }
}

function clear_player_class_and_super() {
  level.isfuelreadingoptimal = 0;
  level.isgroundwarcoremode = 0;
  level.isfriendlyfireprotectedperiod = 0;
  level.isgroundwarinfected = 0;
  level.isfromkillstreak = 0;
  level.isgrenade = 0;
  level.clear_padding_disables = getEntArray("bears", "script_noteworthy");

  foreach(var_1 in level.clear_padding_disables) {
    if(var_1.targetname == "bearRed") {
      var_1 hide();
      continue;
    }

    thread clear_players_from_door_way(var_1);
  }
}

function monitor() {
  var_0 = getEntArray("weatherVane", "targetname");

  foreach(var_2 in var_0) {
    thread ref_12d7c(var_2);
  }

  level.ref_12d40 = scripts\engine\utility::spawn_tag_origin();
  level.ref_12d40.origin = (-472, -584, -1);
  level.ref_12d40.angles = (0, 180, 0);
  level.ref_12d40 show();
  level.ref_12d47 = getEntArray("candleRing", "targetname");

  foreach(var_5 in level.ref_12d47) {
    var_5.fx = scripts\engine\utility::spawn_tag_origin();
    var_5.fx.origin = var_5.origin;
    var_5.fx.angles = var_5.angles;
    var_5.fx show();
    var_5 hide();
  }

  level.gesture_checker = getEntArray("candle", "targetname");
  level.gesture_checker = scripts\engine\utility::array_randomize(level.gesture_checker);

  foreach(var_8 in level.gesture_checker) {
    var_8.fx = scripts\engine\utility::spawn_tag_origin();
    var_8.fx.origin = var_8.origin;
    var_8.fx.angles = var_8.angles;
    var_8.fx show();
    var_8 hide();
  }

  level.mon_clip = getEntArray("egg", "targetname");

  foreach(var_11 in level.mon_clip) {
    var_11.comparescriptindexsmalltolarge = getEntArray(var_11.target, "targetname");

    foreach(var_13 in var_11.comparescriptindexsmalltolarge) {
      var_13 linkTo(var_11);
      var_13 hide();
    }

    var_11.fx = scripts\engine\utility::spawn_tag_origin();
    var_11.fx.origin = var_11.origin;
    var_11.fx.angles = var_11.angles;
    var_11.fx show();
    var_11.fx linkTo(var_11);
    var_11 hide();
  }
}

function clear_players_from_door_way(var_0) {
  var_0 setCanDamage(1);
  var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
  var_0 hide();

  switch (var_0.targetname) {
    case "bearRed":
      level.isgroundwarcoremode++;
      getquestweaponxprewardinstance();
      wait 2;
      level.isgroundwarcoremode--;
      break;
    case "bearBlue":
      level.isfriendlyfireprotectedperiod++;
      getextractionsites();
      wait 2;
      level.isfriendlyfireprotectedperiod--;
      break;
    case "bearGreen":
      level.isfuelreadingoptimal++;
      getjeepspawns();
      wait 2;
      level.isfuelreadingoptimal--;
      break;
    case "bearYellow":
      level.isgroundwarinfected++;
      getrandompointinsafecirclenearby();
      wait 2;
      level.isgroundwarinfected--;
      break;
    case "bearGray":
      level.isfromkillstreak++;
      getitemdropinfo();
      wait 2;
      level.isfromkillstreak--;
      break;
    default:
      break;
  }
}

function getquestweaponxprewardinstance() {
  if(level.isgroundwarcoremode == 2) {
    ref_13dc1();
    return;
  }
}

function getextractionsites() {
  if(level.isfriendlyfireprotectedperiod == 2) {
    level.isgrenade++;
    getlootname();
    return;
  }
}

function getjeepspawns() {
  if(level.isfuelreadingoptimal == 2) {
    level.isgrenade++;
    getlootname();
    return;
  }
}

function getrandompointinsafecirclenearby() {
  if(level.isgroundwarinfected == 2) {
    level.isgrenade++;
    getlootname();
    return;
  }
}

function getitemdropinfo() {
  if(level.isfromkillstreak == 2) {
    level.isgrenade++;
    getlootname();
    return;
  }
}

function getlootname() {
  if(level.isgrenade == 4) {
    level.clear_players_breadcrumbs_to_safe_house = getEntArray("bearRed", "targetname");

    foreach(var_1 in level.clear_players_breadcrumbs_to_safe_house) {
      var_1 show();
      thread clear_players_from_door_way(var_1);
    }

    return;
  }
}

function molotov_watch_cleanup_pool() {
  wait 5;
  level.clear_players_breadcrumbs_to_safe_house = getEntArray("bearRed", "targetname");

  foreach(var_1 in level.clear_players_breadcrumbs_to_safe_house) {
    var_1 show();
    thread clear_players_from_door_way(var_1);
  }
}

function ref_13dc1() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_goat_circle"), level.ref_12d40, "tag_origin");
  thread scripts\engine\utility::play_sound_in_space("mp_cornfield_goats_lr", (-666, -666, 60));
  thread scripts\engine\utility::play_sound_in_space("mp_cornfield_goats_lsrs", (-300, -666, 60));

  foreach(var_1 in level.players) {
    var_1 visionsetnakedforplayer("mp_m_cornfield_egg", 15);
    var_1 playlocalsound("mp_cornfield_goat_stinger");
  }

  foreach(var_4 in level.ref_12d47) {
    var_4 show();
    waittillframeend();
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var_4.fx, "tag_origin");
    thread scripts\engine\utility::play_sound_in_space("mp_cornfield_goat_candle", var_4.origin);
  }

  wait 2;

  foreach(var_4 in level.gesture_checker) {
    var_4 show();
    waittillframeend();
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var_4.fx, "tag_origin");
    thread scripts\engine\utility::play_sound_in_space("mp_cornfield_goat_candle", var_4.origin);
    wait 0.1;
  }

  wait 1;
  var_8 = (0, 0, -386.09);
  var_9 = (0, 0, 100);
  physics_setgravity(var_9);

  foreach(var_11 in level.mon_clip) {
    var_11 show();
    playFXOnTag(scripts\engine\utility::getfx("vfx_goat_eyes"), var_11.fx, "tag_origin");

    foreach(var_13 in var_11.comparescriptindexsmalltolarge) {
      var_13 show();
    }
  }

  wait 3;

  foreach(var_11 in level.mon_clip) {
    var_17 = scripts\engine\utility::getStruct(var_11.target, "targetname");

    if(isDefined(var_17)) {
      var_11.origin = var_17.origin;
      var_11.angles = var_17.angles;
      var_11.ref_11e73 = var_17.target;
    }
  }

  wait 2;

  foreach(var_11 in level.mon_clip) {
    var_17 = scripts\engine\utility::getStruct(var_11.ref_11e73, "targetname");

    if(isDefined(var_17)) {
      waittillframeend();
      var_11.origin = var_17.origin;
      var_11.angles = var_17.angles;
      var_11.ref_11e73 = var_17.target;
    }
  }

  wait 2;

  foreach(var_11 in level.mon_clip) {
    var_17 = scripts\engine\utility::getStruct(var_11.ref_11e73, "targetname");

    if(isDefined(var_17)) {
      waittillframeend();
      var_11.origin = var_17.origin;
      var_11.angles = var_17.angles;
    }
  }

  wait 1.5;

  foreach(var_1 in level.players) {
    var_1 visionsetnakedforplayer("mp_m_cornfield_egg2", 0.25);
  }

  wait 1;

  foreach(var_11 in level.mon_clip) {
    killfxontag(scripts\engine\utility::getfx("vfx_goat_eyes"), var_11.fx, "tag_origin");
    killfxontag(scripts\engine\utility::getfx("vfx_goat_eyes"), var_11.fx, "tag_origin");
    var_11 hide();

    foreach(var_13 in var_11.comparescriptindexsmalltolarge) {
      var_13 hide();
    }
  }

  physics_setgravity(var_8);

  foreach(var_1 in level.players) {
    thread viewmodel_demeanor();
  }

  foreach(var_4 in level.ref_12d47) {
    killfxontag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var_4.fx, "tag_origin");
  }

  foreach(var_4 in level.gesture_checker) {
    var_4 hide();
    killfxontag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var_4.fx, "tag_origin");
  }
}

function viewmodel_demeanor() {
  self kill();
  self visionsetnakedforplayer("mp_m_cornfield_egg2", 0);
  waitframe();

  while(!scripts\cp_mp\utility\player_utility::_isalive()) {
    waitframe();
  }

  self visionsetnakedforplayer("", 0);
}