/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\brclientmatchdata.gsc
***********************************************/

function getquestrewardgroupindex() {
  if(isDefined(level.ref_12b1a)) {
    return;
  }

  level.ref_12b1a = [];
  var0 = [[level.getplunderextractionsites]]();
  var1 = [[level.getnextpayloadspawnmodule]]();

  if(var0.size < 1 || var1.size < 1) {
    return;
  }

  var2 = scripts\engine\utility::array_combine(var0, var1);

  foreach(var4 in var2) {
    if(!isDefined(level.ref_12b1a[var4.checkpoint])) {
      level.ref_12b1a[var4.checkpoint] = [];
    }

    level.ref_12b1a[var4.checkpoint][var5] = var4;
  }
}

function getpresettruckspawns(var0, var1) {
  if(!isDefined(level.ref_12b19)) {
    level.ref_12b19 = [];
  }

  level.ref_12b19[var0] = var1;
}

function getprophealth(var0) {
  setDvar("restart_checkpoint", var0);
  setDvar(level.mapname + "_start_obj", "");
  setomnvar("ui_cp_checkpoint", 1);
}

function getoperatorspecificaccessoryweapon(var0, var1) {
  var2 = level.ref_12b1a[var0];

  foreach(var4 in var2) {
    if(var4.type != var1) {
      continue;
    }

    if(var4.checkpoint != var0) {
      continue;
    }

    if(isDefined(var4.inuse)) {
      continue;
    }

    switch (var1) {
      case "player_spawn":
        var4.inuse = 1;
        return var4;
      case "carepackage_munitions":
      case "carepackage":
        return var4;
    }
  }
}

function getpreviousplacement(var0) {
  var0 scripts\engine\utility::ref_143a5("spawned_player", "disconnect");

  while(scripts\cp\utility::any_player_nearby(self.origin, 64)) {
    wait 1;
  }

  self.inuse = undefined;
}

function getnextprop(var0) {
  level endon("game_ended");

  if(!isDefined(level.ref_12b19[var0])) {
    return;
  }

  var1 = getoperatorspecificaccessoryweapon(var0, "carepackage");
  var2 = spawn("script_model", var1.origin);
  var2.angles = var1.angles;
  var2 setModel("military_carepackage_01_friendly");
  var3 = getEnt("care_package_col", "targetname");
  var4 = spawn("script_model", var1.origin);
  var4.angles = var1.angles;
  var4 clonebrushmodeltoscriptmodel(var3);
  var4 linkTo(var2);
  var5 = spawn("script_model", var1.origin + (0, 0, 35));
  var5 setModel("tag_origin");
  var5 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_LOADOUT", 25, "duration_short", "hide", 256, 75, 128, 75);
  var5.headicon = deleteheadicon(var2);
  setheadiconfriendlyimage(var5.headicon, "hud_icon_survival_weapon");
  setheadicondrawthroughgeo(var5.headicon, 0);
  setheadiconsnaptoedges(var5.headicon, 1024);
  setheadiconmaxdistance(var5.headicon, 256);
  addclienttoheadiconmask(var5.headicon, -5);
  var2.collision = var4;
  var2.interaction = var5;
  thread getnextcombatareaid(var5);
  return var2;
}

function getnextcombatareaid(var0) {
  self endon("death");
  var0 endon("death");

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    thread getnextsafecircleradius(var1);
  }
}

function getnextsafecircleradius(var0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  var0 disableplayeruse(self);
  level thread scripts\mp\vehicles\vehicle_damage_mp::ref_11952(self, var0);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  scripts\engine\utility::ref_143a5("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  var0 enableplayeruse(self);
}

function getnextrpgspawnmodule(var0, var1, var2, var3) {
  level endon("game_ended");
  var4 = 0;

  if(istrue(level.little_bird_mg_cp_spawncallback)) {
    switch (var0) {
      case "convoy4_secure_tower":
      case "tmtyl_p1":
      case "arms_race_p1":
      case "apce_p1":
      case "ml_p3":
      case "ml_p2":
      case "ml_p1":
      case "tow_p1":
        var4 = 1;
        break;
    }

    if(var4) {
      return;
    }
  }

  var5 = getoperatorspecificaccessoryweapon(var0, "carepackage_munitions");

  if(!isDefined(var5) || !isDefined(var5.origin)) {
    return;
  }

  var6 = spawn("script_model", var5.origin);
  var6.angles = var5.angles;
  var7 = (0, 0, 35);
  var8 = "show";
  var9 = undefined;
  var10 = undefined;

  if(!istrue(var3)) {
    var6 setModel("military_carepackage_01_uk");
    var11 = getEnt("care_package_col", "targetname");
    var12 = spawn("script_model", var5.origin);
    var12.angles = var5.angles;
    var12 clonebrushmodeltoscriptmodel(var11);
    var12 linkTo(var6);
    var6.collision = var12;

    if(isDefined(var0) && var0 == "strongbox") {
      level.checkpoint = "strongbox";
      var7 += (-10, 25, 0);
      var9 = (10, -25, 35);
    }
  } else {
    var6 setModel("military_hq_crate_01_proxy_cp_spawnable");
    var6 setscriptablepartstate("main", "on");
    var6.ref_14057 = 1;
    var7 += rotatevector((18.5, 16.6, 2), var6.angles);
    var8 = "hide";
    var9 = (0, 0, 35) + rotatevector((18.5, -14.6, 2), var6.angles);
  }

  thread getnearestbombsiteteam(level, var9, var5, var6, var1, var2, var3);
  var13 = spawn("script_model", var5.origin + var7);
  var13 setModel("tag_origin");
  var13 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_MUNITIONS", 1, "duration_short", var8, 256, 75, 128, 75);
  var6.interaction = var13;
  var13.get_distance_to_closest_teammate = var6;
  var13.ref_11e0e = var1;
  var13.ref_11e0d = var2;
  var13.ref_14057 = var3;
  thread getnextcircleindex(var13);
  return var6;
}

function getnearestbombsiteteam(var0, var1, var2, var3, var4, var5, var6) {
  level endon("game_ended");

  if(isDefined(var0)) {
    var7 = spawn("script_model", var1.origin + var0);
    var7 setModel("tag_origin");

    if(!isDefined(var6)) {
      var6 = "hide";
    }

    var7 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_ROLE", 1, "duration_short", var6, 256, 75, 128, 75);
    var2.ref_12d7e = var7;
    var7.get_distance_to_closest_teammate = var2;
    var7.ref_11e0e = var3;
    var7.ref_11e0d = var4;
    var7.ref_14057 = var5;
    thread getnemesis(var7);
    return;
  }
}

function getnextcircleindex(var0) {
  self endon("death");
  var0 endon("death");
  thread getnumbersspawnpoint();
  thread getnumbersspawnpoint_late();

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(istrue(var1.little_bird_mg_enterendinternal)) {
      continue;
    }

    thread getnextspectatecandidatefromchain(var1);
  }
}

function getnemesis(var0, var1) {
  self endon("death");
  var0 endon("death");
  thread getoffsetspawnoriginmultitrace();

  for(;;) {
    self waittill("trigger", var2);

    if(!var2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(istrue(var2.little_bird_mg_enterendinternal)) {
      continue;
    }

    thread getobjectiveflag(var2);
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
    level waittill("player_spawned", var0);
    thread getnumdrops(level, var0);
  }
}

function getnumbersspawnpoint() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_wait("strike_init_done");
  var0 = 38;

  if(istrue(self.ref_14057)) {
    var0 = 22;
  }

  self.objicon = scripts\cp\cp_objectives::requestworldid("munitions_purchase", 25);
  objective_setplayintro(self.objicon, 0);
  objective_setbackground(self.objicon, 1);
  objective_state(self.objicon, "invisible");
  objective_icon(self.objicon, "hud_icon_survival_killstreak_small");
  var1 = self.origin;

  if(isDefined(level.checkpoint) && level.checkpoint == "strongbox") {
    var0 = 75;
    var1 = self.get_distance_to_closest_teammate.origin;
  }

  objective_position(self.objicon, var1 + (0, 0, var0));
  objective_setshowdistance(self.objicon, 0);
  objective_sethot(self.objicon, 0);
  objective_setpinned(self.objicon, 0);
  objective_hidefromplayersinmask(self.objicon);
  objective_removeallfrommask(self.objicon);
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  wait 2.5;
  var2 = 1;
  var3 = 60;
  var4 = 0.1;

  if(isDefined(self.ref_11e0d)) {
    var3 = self.ref_11e0d;
  }

  var5 = var4 / var3;

  if(isDefined(self.ref_11e0e)) {
    level waittill(self.ref_11e0e);
  }

  objective_showprogressforteam(self.objicon, "allies");

  while(var2 > 0) {
    objective_setprogress(self.objicon, var2);
    wait var4;
    var2 -= var5;

    if(var2 < 0) {
      var2 = 0;
    }
  }

  level notify("close_munitions_store");
  self makeunusable();

  foreach(var7 in level.players) {
    if(var7 calloutmarkerping_entityzoffset("cp_open_cac") == 3) {
      var7 setclientomnvar("cp_open_cac", -2);
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

function getnumdrops(var0, var1) {
  level endon("game_ended");
  var0 endon("death_or_disconnect");
  level endon("close_munitions_store");

  if(istrue(var0.ref_13c50)) {
    return;
  }

  var0.ref_13c50 = 1;
  wait 3;

  for(;;) {
    var2 = distance2dsquared(var0.origin, var1.origin);

    if(isDefined(var2) && var2 > 262144) {
      if(!istrue(var0.spawn_enemy_drone_turret)) {
        objective_addclienttomask(var1.objicon, var0);
        var0.spawn_enemy_drone_turret = 1;
      }
    } else if(isDefined(var2) && var2 <= 262144) {
      if(isDefined(var0.spawn_enemy_drone_turret)) {
        objective_removeclientfrommask(var1.objicon, var0);
        var0.spawn_enemy_drone_turret = undefined;
      }
    }

    wait 0.5;
  }
}

function getnextspectatecandidatefromchain(var0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  level endon("close_munitions_store");
  var0 disableplayeruse(self);
  self setclientomnvar("cp_open_cac", 3);
  wait 1;
  var0 enableplayeruse(self);
}

function getobjectiveflag(var0) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  level endon("close_munitions_store");
  var0 disableplayeruse(self);
  self.ref_12d7d = 1;
  self setclientomnvar("cp_open_cac", 5);
  wait 1;
  var0 enableplayeruse(self);
}

function getnearbyaliveplayer(var0, var1, var2) {
  var3 = spawnStruct();
  var3.origin = var1;
  var3.angles = var2;
  var3.type = "player_spawn";
  var3.checkpoint = var0;
  return var3;
}

function getmaxoutofboundsbrtime(var0, var1, var2) {
  var3 = spawnStruct();
  var3.origin = var1;
  var3.angles = var2;
  var3.type = "carepackage";
  var3.checkpoint = var0;
  return var3;
}

function getminigundamagescale(var0, var1, var2) {
  var3 = spawnStruct();
  var3.origin = var1;
  var3.angles = var2;
  var3.type = "carepackage_munitions";
  var3.checkpoint = var0;
  return var3;
}