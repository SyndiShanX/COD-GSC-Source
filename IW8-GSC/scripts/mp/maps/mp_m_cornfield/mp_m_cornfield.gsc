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
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread clear_player_class_and_super();
  thread monitor();
}

function ref_12d7c(var0) {
  var0 setCanDamage(1);

  for(;;) {
    var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);
    var0 rotateTo((0, randomint(360), 0), 1, 0, 0.5);
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

  foreach(var1 in level.clear_padding_disables) {
    if(var1.targetname == "bearRed") {
      var1 hide();
      continue;
    }

    thread clear_players_from_door_way(var1);
  }
}

function monitor() {
  var0 = getEntArray("weatherVane", "targetname");

  foreach(var2 in var0) {
    thread ref_12d7c(var2);
  }

  level.ref_12d40 = scripts\engine\utility::spawn_tag_origin();
  level.ref_12d40.origin = (-472, -584, -1);
  level.ref_12d40.angles = (0, 180, 0);
  level.ref_12d40 show();
  level.ref_12d47 = getEntArray("candleRing", "targetname");

  foreach(var5 in level.ref_12d47) {
    var5.fx = scripts\engine\utility::spawn_tag_origin();
    var5.fx.origin = var5.origin;
    var5.fx.angles = var5.angles;
    var5.fx show();
    var5 hide();
  }

  level.gesture_checker = getEntArray("candle", "targetname");
  level.gesture_checker = scripts\engine\utility::array_randomize(level.gesture_checker);

  foreach(var8 in level.gesture_checker) {
    var8.fx = scripts\engine\utility::spawn_tag_origin();
    var8.fx.origin = var8.origin;
    var8.fx.angles = var8.angles;
    var8.fx show();
    var8 hide();
  }

  level.mon_clip = getEntArray("egg", "targetname");

  foreach(var11 in level.mon_clip) {
    var11.comparescriptindexsmalltolarge = getEntArray(var11.target, "targetname");

    foreach(var13 in var11.comparescriptindexsmalltolarge) {
      var13 linkTo(var11);
      var13 hide();
    }

    var11.fx = scripts\engine\utility::spawn_tag_origin();
    var11.fx.origin = var11.origin;
    var11.fx.angles = var11.angles;
    var11.fx show();
    var11.fx linkTo(var11);
    var11 hide();
  }
}

function clear_players_from_door_way(var0) {
  var0 setCanDamage(1);
  var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);
  var0 hide();

  switch (var0.targetname) {
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

    foreach(var1 in level.clear_players_breadcrumbs_to_safe_house) {
      var1 show();
      thread clear_players_from_door_way(var1);
    }

    return;
  }
}

function molotov_watch_cleanup_pool() {
  wait 5;
  level.clear_players_breadcrumbs_to_safe_house = getEntArray("bearRed", "targetname");

  foreach(var1 in level.clear_players_breadcrumbs_to_safe_house) {
    var1 show();
    thread clear_players_from_door_way(var1);
  }
}

function ref_13dc1() {
  playFXOnTag(scripts\engine\utility::getfx("vfx_goat_circle"), level.ref_12d40, "tag_origin");
  thread scripts\engine\utility::play_sound_in_space("mp_cornfield_goats_lr", (-666, -666, 60));
  thread scripts\engine\utility::play_sound_in_space("mp_cornfield_goats_lsrs", (-300, -666, 60));

  foreach(var1 in level.players) {
    var1 visionsetnakedforplayer("mp_m_cornfield_egg", 15);
    var1 playlocalsound("mp_cornfield_goat_stinger");
  }

  foreach(var4 in level.ref_12d47) {
    var4 show();
    waittillframeend();
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var4.fx, "tag_origin");
    thread scripts\engine\utility::play_sound_in_space("mp_cornfield_goat_candle", var4.origin);
  }

  wait 2;

  foreach(var4 in level.gesture_checker) {
    var4 show();
    waittillframeend();
    playFXOnTag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var4.fx, "tag_origin");
    thread scripts\engine\utility::play_sound_in_space("mp_cornfield_goat_candle", var4.origin);
    wait 0.1;
  }

  wait 1;
  var8 = (0, 0, -386.09);
  var9 = (0, 0, 100);
  physics_setgravity(var9);

  foreach(var11 in level.mon_clip) {
    var11 show();
    playFXOnTag(scripts\engine\utility::getfx("vfx_goat_eyes"), var11.fx, "tag_origin");

    foreach(var13 in var11.comparescriptindexsmalltolarge) {
      var13 show();
    }
  }

  wait 3;

  foreach(var11 in level.mon_clip) {
    var17 = scripts\engine\utility::getStruct(var11.target, "targetname");

    if(isDefined(var17)) {
      var11.origin = var17.origin;
      var11.angles = var17.angles;
      var11.ref_11e73 = var17.target;
    }
  }

  wait 2;

  foreach(var11 in level.mon_clip) {
    var17 = scripts\engine\utility::getStruct(var11.ref_11e73, "targetname");

    if(isDefined(var17)) {
      waittillframeend();
      var11.origin = var17.origin;
      var11.angles = var17.angles;
      var11.ref_11e73 = var17.target;
    }
  }

  wait 2;

  foreach(var11 in level.mon_clip) {
    var17 = scripts\engine\utility::getStruct(var11.ref_11e73, "targetname");

    if(isDefined(var17)) {
      waittillframeend();
      var11.origin = var17.origin;
      var11.angles = var17.angles;
    }
  }

  wait 1.5;

  foreach(var1 in level.players) {
    var1 visionsetnakedforplayer("mp_m_cornfield_egg2", 0.25);
  }

  wait 1;

  foreach(var11 in level.mon_clip) {
    killfxontag(scripts\engine\utility::getfx("vfx_goat_eyes"), var11.fx, "tag_origin");
    killfxontag(scripts\engine\utility::getfx("vfx_goat_eyes"), var11.fx, "tag_origin");
    var11 hide();

    foreach(var13 in var11.comparescriptindexsmalltolarge) {
      var13 hide();
    }
  }

  physics_setgravity(var8);

  foreach(var1 in level.players) {
    thread viewmodel_demeanor();
  }

  foreach(var4 in level.ref_12d47) {
    killfxontag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var4.fx, "tag_origin");
  }

  foreach(var4 in level.gesture_checker) {
    var4 hide();
    killfxontag(scripts\engine\utility::getfx("vfx_garden_candle_poof"), var4.fx, "tag_origin");
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