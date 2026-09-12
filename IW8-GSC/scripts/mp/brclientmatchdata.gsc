/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\brclientmatchdata.gsc
***********************************************/

function getquestrewardgroupindex() {
  if(isDefined(level.ref_12B1A)) {
    return;
  }

  level.ref_12B1A = [];
  var_0 = [[level.getplunderextractionsites]]();
  var_1 = [[level.getnextpayloadspawnmodule]]();

  if(var_0.size < 1 || var_1.size < 1) {
    return;
  }

  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    if(!isDefined(level.ref_12B1A[var_4.checkpoint])) {
      level.ref_12B1A[var_4.checkpoint] = [];
    }

    level.ref_12B1A[var_4.checkpoint][var_5] = var_4;
  }
}

function getpresettruckspawns(var_0, var_1) {
  if(!isDefined(level.ref_12B19)) {
    level.ref_12B19 = [];
  }

  level.ref_12B19[var_0] = var_1;
}

function getprophealth(var_0) {
  setDvar("restart_checkpoint", var_0);
  setDvar(level.mapname + "_start_obj", "");
  setomnvar("ui_cp_checkpoint", 1);
}

function getoperatorspecificaccessoryweapon(var_0, var_1) {
  var_2 = level.ref_12B1A[var_0];

  foreach(var_4 in var_2) {
    if(var_4.type != var_1) {
      continue;
    }

    if(var_4.checkpoint != var_0) {
      continue;
    }

    if(isDefined(var_4.inuse)) {
      continue;
    }

    switch (var_1) {
      case "player_spawn":
        var_4.inuse = 1;
        return var_4;
      case "carepackage_munitions":
      case "carepackage":
        return var_4;
    }
  }
}

function getpreviousplacement(var_0) {
  var_0 scripts\engine\utility::ref_143A5("spawned_player", "disconnect");

  while(scripts\cp\utility::any_player_nearby(self.origin, 64)) {
    wait 1;
  }

  self.inuse = undefined;
}

function getnextprop(var_0) {
  level endon("game_ended");

  if(!isDefined(level.ref_12B19[var_0])) {
    return;
  }

  var_1 = getoperatorspecificaccessoryweapon(var_0, "carepackage");
  var_2 = spawn("script_model", var_1.origin);
  var_2.angles = var_1.angles;
  var_2 setModel("military_carepackage_01_friendly");
  var_3 = getEnt("care_package_col", "targetname");
  var_4 = spawn("script_model", var_1.origin);
  var_4.angles = var_1.angles;
  var_4 clonebrushmodeltoscriptmodel(var_3);
  var_4 linkTo(var_2);
  var_5 = spawn("script_model", var_1.origin + (0, 0, 35));
  var_5 setModel("tag_origin");
  var_5 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_LOADOUT", 25, "duration_short", "hide", 256, 75, 128, 75);
  var_5.headicon = deleteheadicon(var_2);
  setheadiconfriendlyimage(var_5.headicon, "hud_icon_survival_weapon");
  setheadicondrawthroughgeo(var_5.headicon, 0);
  setheadiconsnaptoedges(var_5.headicon, 1024);
  setheadiconmaxdistance(var_5.headicon, 256);
  addclienttoheadiconmask(var_5.headicon, -5);
  var_2.collision = var_4;
  var_2.interaction = var_5;
  thread getnextcombatareaid(var_5);
  return var_2;
}

function getnextcombatareaid(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    thread getnextsafecircleradius(var_1);
  }
}

function getnextsafecircleradius(var_0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  var_0 disableplayeruse(self);
  level thread scripts\mp\vehicles\vehicle_damage_mp::ref_11952(self, var_0);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  scripts\engine\utility::ref_143A5("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  var_0 enableplayeruse(self);
}

function getnextrpgspawnmodule(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_4 = 0;

  if(istrue(level.little_bird_mg_cp_spawncallback)) {
    switch (var_0) {
      case "convoy4_secure_tower":
      case "tmtyl_p1":
      case "arms_race_p1":
      case "apce_p1":
      case "ml_p3":
      case "ml_p2":
      case "ml_p1":
      case "tow_p1":
        var_4 = 1;
        break;
    }

    if(var_4) {
      return;
    }
  }

  var_5 = getoperatorspecificaccessoryweapon(var_0, "carepackage_munitions");

  if(!isDefined(var_5) || !isDefined(var_5.origin)) {
    return;
  }

  var_6 = spawn("script_model", var_5.origin);
  var_6.angles = var_5.angles;
  var_7 = (0, 0, 35);
  var_8 = "show";
  var_9 = undefined;
  var_10 = undefined;

  if(!istrue(var_3)) {
    var_6 setModel("military_carepackage_01_uk");
    var_11 = getEnt("care_package_col", "targetname");
    var_12 = spawn("script_model", var_5.origin);
    var_12.angles = var_5.angles;
    var_12 clonebrushmodeltoscriptmodel(var_11);
    var_12 linkTo(var_6);
    var_6.collision = var_12;

    if(isDefined(var_0) && var_0 == "strongbox") {
      level.checkpoint = "strongbox";
      var_7 += (-10, 25, 0);
      var_9 = (10, -25, 35);
    }
  } else {
    var_6 setModel("military_hq_crate_01_proxy_cp_spawnable");
    var_6 setscriptablepartstate("main", "on");
    var_6.ref_14057 = 1;
    var_7 += rotatevector((18.5, 16.6, 2), var_6.angles);
    var_8 = "hide";
    var_9 = (0, 0, 35) + rotatevector((18.5, -14.6, 2), var_6.angles);
  }

  thread getnearestbombsiteteam(level, var_9, var_5, var_6, var_1, var_2, var_3);
  var_13 = spawn("script_model", var_5.origin + var_7);
  var_13 setModel("tag_origin");
  var_13 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_MUNITIONS", 1, "duration_short", var_8, 256, 75, 128, 75);
  var_6.interaction = var_13;
  var_13.get_distance_to_closest_teammate = var_6;
  var_13.ref_11E0E = var_1;
  var_13.ref_11E0D = var_2;
  var_13.ref_14057 = var_3;
  thread getnextcircleindex(var_13);
  return var_6;
}

function getnearestbombsiteteam(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");

  if(isDefined(var_0)) {
    var_7 = spawn("script_model", var_1.origin + var_0);
    var_7 setModel("tag_origin");

    if(!isDefined(var_6)) {
      var_6 = "hide";
    }

    var_7 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_ROLE", 1, "duration_short", var_6, 256, 75, 128, 75);
    var_2.ref_12D7E = var_7;
    var_7.get_distance_to_closest_teammate = var_2;
    var_7.ref_11E0E = var_3;
    var_7.ref_11E0D = var_4;
    var_7.ref_14057 = var_5;
    thread getnemesis(var_7);
    return;
  }
}

function getnextcircleindex(var_0) {
  self endon("death");
  var_0 endon("death");
  thread getnumbersspawnpoint();
  thread getnumbersspawnpoint_late();

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(istrue(var_1.little_bird_mg_enterendinternal)) {
      continue;
    }

    thread getnextspectatecandidatefromchain(var_1);
  }
}

function getnemesis(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  thread getoffsetspawnoriginmultitrace();

  for(;;) {
    self waittill("trigger", var_2);

    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(istrue(var_2.little_bird_mg_enterendinternal)) {
      continue;
    }

    thread getobjectiveflag(var_2);
  }
}

function getoffsetspawnoriginmultitrace() {
  level endon("game_ended");
  level waittill("close_munitions_store");
  self makeunusable();
}

function getnumbersspawnpoint_late() {
  level endon("game_ended");
  level endon("close_munitions_store");

  for(;;) {
    level waittill("player_spawned", var_0);
    thread getnumdrops(level, var_0);
  }
}

function getnumbersspawnpoint() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_wait("strike_init_done");
  var_0 = 38;

  if(istrue(self.ref_14057)) {
    var_0 = 22;
  }

  self.objicon = scripts\cp\cp_objectives::requestworldid("munitions_purchase", 25);
  objective_setplayintro(self.objicon, 0);
  objective_setbackground(self.objicon, 1);
  objective_state(self.objicon, "invisible");
  objective_icon(self.objicon, "hud_icon_survival_killstreak_small");
  var_1 = self.origin;

  if(isDefined(level.checkpoint) && level.checkpoint == "strongbox") {
    var_0 = 75;
    var_1 = self.get_distance_to_closest_teammate.origin;
  }

  objective_position(self.objicon, var_1 + (0, 0, var_0));
  objective_setshowdistance(self.objicon, 0);
  objective_sethot(self.objicon, 0);
  objective_setpinned(self.objicon, 0);
  objective_hidefromplayersinmask(self.objicon);
  objective_removeallfrommask(self.objicon);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 2.5;
  var_2 = 1;
  var_3 = 60;
  var_4 = 0.1;

  if(isDefined(self.ref_11E0D)) {
    var_3 = self.ref_11E0D;
  }

  var_5 = var_4 / var_3;

  if(isDefined(self.ref_11E0E)) {
    level waittill(self.ref_11E0E);
  }

  objective_showprogressforteam(self.objicon, "allies");

  while(var_2 > 0) {
    objective_setprogress(self.objicon, var_2);
    wait var_4;
    var_2 -= var_5;

    if(var_2 < 0) {
      var_2 = 0;
    }
  }

  level notify("close_munitions_store");
  self makeunusable();

  foreach(var_7 in level.players) {
    if(var_7 calloutmarkerping_entityzoffset("cp_open_cac") == 3) {
      var_7 setclientomnvar("cp_open_cac", -2);
    }
  }

  if(istrue(self.ref_14057)) {
    self.get_distance_to_closest_teammate setscriptablepartstate("main", "off");
  } else {
    self.get_distance_to_closest_teammate setscriptablepartstate("anims", "capture", 0);
    self.get_distance_to_closest_teammate setscriptablepartstate("capture", "start", 0);
    self.get_distance_to_closest_teammate.collision delete();
  }

  scripts\cp\cp_objectives::freeworldid("munitions_purchase");
}

function getnumdrops(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death_or_disconnect");
  level endon("close_munitions_store");

  if(istrue(var_0.ref_13C50)) {
    return;
  }

  var_0.ref_13C50 = 1;
  wait 3;

  for(;;) {
    var_2 = distance2dsquared(var_0.origin, var_1.origin);

    if(isDefined(var_2) && var_2 > 262144) {
      if(!istrue(var_0.spawn_enemy_drone_turret)) {
        objective_addclienttomask(var_1.objicon, var_0);
        var_0.spawn_enemy_drone_turret = 1;
      }
    } else if(isDefined(var_2) && var_2 <= 262144) {
      if(isDefined(var_0.spawn_enemy_drone_turret)) {
        objective_removeclientfrommask(var_1.objicon, var_0);
        var_0.spawn_enemy_drone_turret = undefined;
      }
    }

    wait 0.5;
  }
}

function getnextspectatecandidatefromchain(var_0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  level endon("close_munitions_store");
  var_0 disableplayeruse(self);
  self setclientomnvar("cp_open_cac", 3);
  wait 1;
  var_0 enableplayeruse(self);
}

function getobjectiveflag(var_0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  level endon("close_munitions_store");
  var_0 disableplayeruse(self);
  self.ref_12D7D = 1;
  self setclientomnvar("cp_open_cac", 5);
  wait 1;
  var_0 enableplayeruse(self);
}

function getnearbyaliveplayer(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_3.type = "player_spawn";
  var_3.checkpoint = var_0;
  return var_3;
}

function getmaxoutofboundsbrtime(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_3.type = "carepackage";
  var_3.checkpoint = var_0;
  return var_3;
}

function getminigundamagescale(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = var_1;
  var_3.angles = var_2;
  var_3.type = "carepackage_munitions";
  var_3.checkpoint = var_0;
  return var_3;
}