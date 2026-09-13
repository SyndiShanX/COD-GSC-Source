/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_juggernaut.gsc
***********************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "jugg") {
    return;
  }
  init();
}

init() {
  level thread brjugg_initfeatures();
  level thread brjugg_initpostmain();
  level thread brjugg_initdialog();
  level thread brjugg_initexternalfeatures();
}

brjugg_initfeatures() {
  if(getdvarint("dvar_A780A85E3B40BAF0", 0) == 1) {
    _id_362C58E8BB39BCDA::disablefeature("circle");
    _id_362C58E8BB39BCDA::disablefeature("gulag");
    _id_362C58E8BB39BCDA::disablefeature("dropbag");
    _id_362C58E8BB39BCDA::disablefeature("oneLife");
    _id_362C58E8BB39BCDA::enablefeature("allowLateJoiners");
  }

  _id_362C58E8BB39BCDA::disablefeature("plunderSites");
  _id_362C58E8BB39BCDA::enablefeature("tabletReplace");
}

brjugg_initpostmain() {
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::brjugg_playerwelcomesplashes);
  waittillframeend;
  scripts\mp\flags::gameflaginit("start_jugg_delivery", 0);
  level.ontimelimit = ::brjugg_ontimelimit;
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onJuggCrateActivate", ::brjugg_oncrateactivate);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onJuggCrateUse", ::brjugg_oncrateuse);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onJuggCrateDestroy", ::brjugg_oncratedestroy);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onJuggDropOnDeath", ::brjugg_dropondeath);
  brjugg_cleanupents();
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level.startjuggdelivery = 0;
  level thread brjugg_managedeliveries();
}

brjugg_initdialog() {
  wait 1;
  game["dialog"]["match_start"] = "gametype_juggernautroyale";
}

brjugg_cleanupents() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_prison_cell_metal_mp", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("door_wooden_panel_mp_01", 1);
  scripts\cp_mp\utility\game_utility::removematchingents_bymodel("me_electrical_box_street_01", 1);
}

brjugg_initexternalfeatures() {}

brjugg_playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_juggernaut_prematch_welcome");

  if(!istrue(level.br_infils_disabled)) {
    self waittill("br_jump");

    while(!self isonground())
      waitframe();
  } else
    level waittill("prematch_done");

  _id_715028F54BAD19A1::branalytics_landing(self);
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_juggernaut_welcome");
  _id_2CEDCC356F1B9FC8::brleaderdialogplayer("primary_objective", self, 0);
}

brjugg_ontimelimit() {
  if(isDefined(level.numendgame))
    level thread _id_1E4A61DB11011446::startendgame(1);

  level.numendgame = undefined;
}

brjugg_managedeliveries() {
  level endon("game_ended");

  if(_id_2CEDCC356F1B9FC8::_id_D6AE35E0CE14BBAF()) {
    return;
  }
  level waittill("br_prematchEnded");
  level thread brjugg_watchstartnotify();
  level thread brjugg_watchtimerstart();
  _id_535E20B358BFDD66 = 1;

  for(;;) {
    _id_D3911DB4DA14F641 = getdvarint("dvar_3D449B3CE63E3ACE", 1);

    if(!_id_D3911DB4DA14F641) {
      waitframe();
      continue;
    }

    _id_FDFC755D4AA965C6 = _id_29C32B7117E01180::getnumdrops();

    if(level.numactivejuggdrops > 0)
      _id_FDFC755D4AA965C6 = _id_FDFC755D4AA965C6 - level.numactivejuggdrops;

    level.juggdroplocations = scripts\engine\utility::array_randomize(level.juggdroplocations);
    droplocations = _id_29C32B7117E01180::showdroplocations(_id_FDFC755D4AA965C6, _id_535E20B358BFDD66);

    while(!istrue(level.startjuggdelivery)) {
      waitframe();
      continue;
    }

    _id_535E20B358BFDD66 = 0;
    level thread _id_29C32B7117E01180::startdeliveries(droplocations, "gametype_juggernaut");
    level waittill("continue_jugg_drops");

    if(isDefined(level.gulag) && istrue(level.gulag.shutdown)) {
      break;
    }

    _id_B2AFE11B32A4439C = getdvarint("dvar_6033E70C81D4B924", 20);
    wait(_id_B2AFE11B32A4439C);
  }
}

brjugg_watchstartnotify() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("start_jugg_delivery");
  level.startjuggdelivery = 1;
}

brjugg_watchplayercounttostart(_id_86DA7BB1919B5A1E) {
  level endon("game_ended");

  for(;;) {
    level waittill("br_player_eliminated");
    _id_7F19E0518E7F95BA = _id_1E4A61DB11011446::getbrplayersnoteliminated();

    if(_id_7F19E0518E7F95BA.size <= _id_86DA7BB1919B5A1E) {
      scripts\mp\flags::gameflagset("start_jugg_delivery");
      break;
    }
  }
}

brjugg_watchtimerstart() {
  level endon("game_ended");
  _id_65DE8866109DFCD3 = getdvarint("dvar_305A549345046786", 10);
  wait(_id_65DE8866109DFCD3);
  scripts\mp\flags::gameflagset("start_jugg_delivery");
}

brjugg_oncrateactivate(_id_D9BC1B05D016A86F) {}

brjugg_oncrateuse(player) {}

brjugg_oncratedestroy(immediate) {
  level notify("continue_jugg_drops");
}

brjugg_dropondeath(dropstruct) {
  level notify("continue_jugg_drops");
  _id_6AFF3948CF4CCA03::dropplunderbyrarity(100, dropstruct);
  _id_8B3EBF50F99BDB43 = getdvarint("dvar_53800BC3E7AB723D", 1);

  if(_id_8B3EBF50F99BDB43)
    _id_7E52B56769FA7774::dropbrweapon("brloot_weapon_lm_dblmg_lege", dropstruct);
}