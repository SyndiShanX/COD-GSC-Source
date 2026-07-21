/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\maps\mp_m_cornfield\mp_m_cornfield.gsc
*****************************************************/

main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  _questtimerwait::keypad_check_levelinput();
  level._id_13D50 = 1;
  _encstr_B6FE3B6ED8C95A831D37CBB6E05EAD16E0B979B5C1F5B6F58DDE393733A5958D23F2AD07AF5BEB8DF69337CC962BD819F5834E95C6588DD0CA17EC6E6C::main();
  _encstr_A7CD3A127E3542A85378564778E07D0AC98E8D0D5FC75AFFD9B02B43202D2DA249086787C87F921866D8A78F501BEECA0BB52D7F380BDB44A0A01F87::main();
  _encstr_A3CB356B3166C77AC89757ED69EAC52F8FAB2632FBA8AFF9588702E66DF08F433DC89A6B6619AF2E60A506F66BC815ABC8594316C9EE07::main();
  _encstr_A36B3BAB669B77D221584E6228FFCD0F73D64F3D07C6AFD137A0E34AA0AB07F3A99085B808281FE6C7602AC2309B3D6B26A919273B530FED8F7AA2AB78::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("_encstr_8A720C48B3AB7729A26778B853CB", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  scripts\mp\compass::setupminimap("_encstr_93BA1B7AA0F9930EC087371DBB83592F9F5E12218940C385339B051459", "_encstr_A2012578927FAF41BF0CCDBECF17486BA2DA40700955E33B370D4F20C5BFB1278AD26038C2AD11");
  scripts\cp_mp\utility\game_utility::_id_12B3B();
  level.requiresminstartspawns = 0;
  setDvar("_encstr_83920A488F414D730D6721C8", 8);
  game["_encstr_991C0AB9ED5B57161FE89B83"] = "_encstr_9A8507BA4040188D08";
  game["_encstr_B6A70A23CA6659DC91CAE4DC"] = "_encstr_8E8405EA382B2A";
  game["_encstr_B89F0E58C61B5A599BEBDBAB3A33A5D1"] = "_encstr_8A65065739262C37";
  game["_encstr_AF030C58B33923F7B2630D1C7C5B"] = "_encstr_924D09EBE0478F23A1B0E4";
  thread clear_player_class_and_super();
  thread monitor();
}

_id_12D7C(var_0) {
  var_0 setCanDamage(1);

  for(;;) {
    var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    var_0 rotateTo((0, randomint(360), 0), 1, 0, 0.5);
    waitframe();
  }
}

clear_player_class_and_super() {
  level.isfuelreadingoptimal = 0;
  level.isgroundwarcoremode = 0;
  level.isfriendlyfireprotectedperiod = 0;
  level.isgroundwarinfected = 0;
  level.isfromkillstreak = 0;
  level.isgrenade = 0;
  level.clear_padding_disables = getEntArray("_encstr_B45E0602AB68FAA7", "_encstr_A6ED12C74382502FC3F9C810B37F64A85ACC796B");

  foreach(var_1 in level.clear_padding_disables) {
    if(var_1.targetname == "_encstr_88360851F9486BB75333") {
      var_1 hide();
      continue;
    }

    thread clear_players_from_door_way(var_1);
  }
}

monitor() {
  var_0 = getEntArray("_encstr_AF490CBB2B58E81A56C9CA0BB9B2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_2 in var_0)
  thread _id_12D7C(var_2);

  level._id_12D40 = scripts\engine\utility::spawn_tag_origin();
  level._id_12D40.origin = (-472, -584, -1);
  level._id_12D40.angles = (0, 180, 0);
  level._id_12D40 show();
  level._id_12D47 = getEntArray("_encstr_8CA00B50573D9C68F789984DFF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_5 in level._id_12D47) {
    var_5.fx = scripts\engine\utility::spawn_tag_origin();
    var_5.fx.origin = var_5.origin;
    var_5.fx.angles = var_5.angles;
    var_5.fx show();
    var_5 hide();
  }

  level.gesture_checker = getEntArray("_encstr_ADAA07A701C57861C7", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.gesture_checker = scripts\engine\utility::array_randomize(level.gesture_checker);

  foreach(var_8 in level.gesture_checker) {
    var_8.fx = scripts\engine\utility::spawn_tag_origin();
    var_8.fx.origin = var_8.origin;
    var_8.fx.angles = var_8.angles;
    var_8.fx show();
    var_8 hide();
  }

  level.mon_clip = getEntArray("_encstr_AF1804B7EFAC", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_11 in level.mon_clip) {
    var_11.comparescriptindexsmalltolarge = getEntArray(var_11.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

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

clear_players_from_door_way(var_0) {
  var_0 setCanDamage(1);
  var_0 waittill("_encstr_B2BE0788BAF573592F", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);
  var_0 hide();

  switch (var_0.targetname) {
    case "_encstr_88360851F9486BB75333":
      level.isgroundwarcoremode++;
      getquestweaponxprewardinstance();
      wait 2;
      level.isgroundwarcoremode--;
      break;
    case "_encstr_A2A709663DDF13E57D3B58":
      level.isfriendlyfireprotectedperiod++;
      getextractionsites();
      wait 2;
      level.isfriendlyfireprotectedperiod--;
      break;
    case "_encstr_B8BC0A716ABF0E09B24DEBC5":
      level.isfuelreadingoptimal++;
      getjeepspawns();
      wait 2;
      level.isfuelreadingoptimal--;
      break;
    case "_encstr_A18F0BC4560B9C56958DB1EDBB":
      level.isgroundwarinfected++;
      getrandompointinsafecirclenearby();
      wait 2;
      level.isgroundwarinfected--;
      break;
    case "_encstr_AAC009BE58398AC7FA2953":
      level.isfromkillstreak++;
      getitemdropinfo();
      wait 2;
      level.isfromkillstreak--;
      break;
    default:
      break;
  }
}

getquestweaponxprewardinstance() {
  if(level.isgroundwarcoremode == 2)
    _id_13DC1();
}

getextractionsites() {
  if(level.isfriendlyfireprotectedperiod == 2) {
    level.isgrenade++;
    getlootname();
  }
}

getjeepspawns() {
  if(level.isfuelreadingoptimal == 2) {
    level.isgrenade++;
    getlootname();
  }
}

getrandompointinsafecirclenearby() {
  if(level.isgroundwarinfected == 2) {
    level.isgrenade++;
    getlootname();
  }
}

getitemdropinfo() {
  if(level.isfromkillstreak == 2) {
    level.isgrenade++;
    getlootname();
  }
}

getlootname() {
  if(level.isgrenade == 4) {
    level.clear_players_breadcrumbs_to_safe_house = getEntArray("_encstr_88360851F9486BB75333", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    foreach(var_1 in level.clear_players_breadcrumbs_to_safe_house) {
      var_1 show();
      thread clear_players_from_door_way(var_1);
    }
  }
}

molotov_watch_cleanup_pool() {
  wait 5;
  level.clear_players_breadcrumbs_to_safe_house = getEntArray("_encstr_88360851F9486BB75333", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_1 in level.clear_players_breadcrumbs_to_safe_house) {
    var_1 show();
    thread clear_players_from_door_way(var_1);
  }
}

_id_13DC1() {
  playFXOnTag(scripts\engine\utility::getfx("_encstr_ABB910D4C32B10495F23FB816720E3688AC7"), level._id_12D40, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  thread scripts\engine\utility::play_sound_in_space("_encstr_8C701655704FFF1FCB4B3C3B2BC87BF92087CAD1DE0FA8EB", (-666, -666, 60));
  thread scripts\engine\utility::play_sound_in_space("_encstr_939E182F785F7EBD75B6AD428195934F771FA11BF2EEB1CF12C3", (-300, -666, 60));

  foreach(var_1 in level.players) {
    var_1 visionsetnakedforplayer("_encstr_A1461309A249635ED31730E80BE1D1A92281F584FF", 15);
    var_1 playlocalsound("_encstr_B8191AB60EFA36BD279B992D5936327DECF685E8BEDCD1D2CDD9AC27");
  }

  foreach(var_4 in level._id_12D47) {
    var_4 show();
    waittillframeend;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AC95179B1270516160A60BA7AEE0D879CB148D39804340B50A"), var_4.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    thread scripts\engine\utility::play_sound_in_space("_encstr_83DA1903A801C87803227198FA13A571A71FA3B91FF61030631A69", var_4.origin);
  }

  wait 2;

  foreach(var_4 in level.gesture_checker) {
    var_4 show();
    waittillframeend;
    playFXOnTag(scripts\engine\utility::getfx("_encstr_AC95179B1270516160A60BA7AEE0D879CB148D39804340B50A"), var_4.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    thread scripts\engine\utility::play_sound_in_space("_encstr_83DA1903A801C87803227198FA13A571A71FA3B91FF61030631A69", var_4.origin);
    wait 0.1;
  }

  wait 1;
  var_8 = (0, 0, -386.09);
  var_9 = (0, 0, 100);
  physics_setgravity(var_9);

  foreach(var_11 in level.mon_clip) {
    var_11 show();
    playFXOnTag(scripts\engine\utility::getfx("_encstr_8E330E68D8BBE8B787F895C97F833F1F"), var_11.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

    foreach(var_13 in var_11.comparescriptindexsmalltolarge)
    var_13 show();
  }

  wait 3;

  foreach(var_11 in level.mon_clip) {
    var_17 = scripts\engine\utility::getStruct(var_11.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_17)) {
      var_11.origin = var_17.origin;
      var_11.angles = var_17.angles;
      var_11._id_11E73 = var_17.target;
    }
  }

  wait 2;

  foreach(var_11 in level.mon_clip) {
    var_17 = scripts\engine\utility::getStruct(var_11._id_11E73, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_17)) {
      waittillframeend;
      var_11.origin = var_17.origin;
      var_11.angles = var_17.angles;
      var_11._id_11E73 = var_17.target;
    }
  }

  wait 2;

  foreach(var_11 in level.mon_clip) {
    var_17 = scripts\engine\utility::getStruct(var_11._id_11E73, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_17)) {
      waittillframeend;
      var_11.origin = var_17.origin;
      var_11.angles = var_17.angles;
    }
  }

  wait 1.5;

  foreach(var_1 in level.players)
  var_1 visionsetnakedforplayer("_encstr_A51A1417C3F84DA9ABC73580E75477CCC91778AF30CE", 0.25);

  wait 1;

  foreach(var_11 in level.mon_clip) {
    killfxontag(scripts\engine\utility::getfx("_encstr_8E330E68D8BBE8B787F895C97F833F1F"), var_11.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    killfxontag(scripts\engine\utility::getfx("_encstr_8E330E68D8BBE8B787F895C97F833F1F"), var_11.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    var_11 hide();

    foreach(var_13 in var_11.comparescriptindexsmalltolarge)
    var_13 hide();
  }

  physics_setgravity(var_8);

  foreach(var_1 in level.players)
  var_1 thread viewmodel_demeanor();

  foreach(var_4 in level._id_12D47)
  killfxontag(scripts\engine\utility::getfx("_encstr_AC95179B1270516160A60BA7AEE0D879CB148D39804340B50A"), var_4.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  foreach(var_4 in level.gesture_checker) {
    var_4 hide();
    killfxontag(scripts\engine\utility::getfx("_encstr_AC95179B1270516160A60BA7AEE0D879CB148D39804340B50A"), var_4.fx, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  }
}

viewmodel_demeanor() {
  self kill();
  self visionsetnakedforplayer("_encstr_A51A1417C3F84DA9ABC73580E75477CCC91778AF30CE", 0);
  waitframe();

  while(!scripts\cp_mp\utility\player_utility::_isalive())
    waitframe();

  self visionsetnakedforplayer("_encstr_B40101", 0);
}