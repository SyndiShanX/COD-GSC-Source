/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_infilexfil.gsc
***********************************************/

function infil_ended(var_0) {
  level waittill("infil_started");
  var_1 = 0;

  if(isDefined(level.extra_infil_time)) {
    var_1 = level.extra_infil_time;
  }

  wait var_0 + var_1;
  level notify("prematch_over");

  if(scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_set("infil_complete");
    return;
  }
}

function onplayerspawnedinfil() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("player_spawned", var_0);
    var_0 setclientomnvar("ui_hide_hud", 1);
    var_1 = scripts\cp\infilexfil\infilexfil::get_spot_from_player(var_0);

    if(isDefined(var_1)) {
      cp_player_free_spot(var_0, scripts\cp\utility::getotherteam(var_0.team));
    }

    if(!scripts\engine\utility::flag("infil_started")) {
      cp_player_join_infil_cp(var_0);
    }
  }
}

function cponplayerdisconnectinfil() {
  self endon("prematch_over");
  self waittill("disconnect");
  cp_player_free_spot(self);
}

function infil_is_type(var_0) {
  return self.script_noteworthy == var_0;
}

function infil_is_subtype(var_0) {
  return self.name == var_0;
}

function cp_infil_player_allow(var_0) {
  self allowmovement(var_0);
  scripts\common\utility::allow_prone(var_0);
  scripts\common\utility::allow_crouch(var_0);
  scripts\common\utility::allow_jump(var_0);
  scripts\common\utility::allow_fire(var_0);
  scripts\common\utility::allow_ads(var_0);
  scripts\common\utility::allow_sprint(var_0);
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_reload(var_0);
  scripts\common\utility::allow_lean(var_0);
  scripts\common\utility::allow_slide(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
  scripts\common\utility::allow_weapon_switch(var_0);
  scripts\common\utility::allow_usability(var_0);
}

function teamhasinfil(var_0) {
  if(!isDefined(game["infil"])) {
    return false;
  }

  return isDefined(game["infil"][var_0]["lanes"]);
}

function cp_player_free_spot(var_0, var_1) {
  if(!var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  if(!isDefined(var_1)) {
    var_1 = var_0.team;
  }

  if(isDefined(game["infil"][var_1]["spots"])) {}

  foreach(var_3 in game["infil"][var_1]["spots"]) {
    if(scripts\cp\infilexfil\infilexfil::is_spot_taken(var_1, var_4) && var_3["player"] == var_0) {
      game["infil"][var_1]["spots"][var_4]["player"] = undefined;
      var_0 notify("player_free_spot");
      return;
    }
  }
}

function cp_get_spot_by_priority(var_0) {
  var_1 = [];

  foreach(var_3 in game["infil"][var_0]["spots"]) {
    if(!scripts\cp\infilexfil\infilexfil::is_spot_taken(var_0, var_4)) {
      var_1 = var_4;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = getdvarint("scr_infil_force_seat", -1);

  if(scripts\engine\utility::array_contains(var_1, var_5)) {
    return var_5;
  }

  var_6 = undefined;
  var_7 = -1;

  foreach(var_3 in var_1) {
    var_9 = game["infil"][var_0]["spots"][var_3]["priority"];

    if(!isDefined(var_6) || var_9 < var_7) {
      var_6 = var_3;
      var_7 = var_9;
    }
  }

  return var_6;
}

function cp_player_join_infil_cp() {
  if(game["infil"][self.team].size == 0) {
    return;
  }

  var_0 = 0;
  var_1 = game["infil"][self.team]["spots"][0]["priority"] != -1;

  if(level.gametype == "tac_ops" && isDefined(self.tacopsmapselectedarea.dynamicent)) {
    var_2 = get_random_spot_in_infil(self.team, self.tacopsmapselectedarea.dynamicent);
  } else if(var_1) {
    var_2 = scripts\cp\infilexfil\infilexfil::get_spot_taken_count(self.team);
  } else if(var_2) {
    var_2 = cp_get_spot_by_priority(self.team);
  } else {
    var_2 = scripts\cp\infilexfil\infilexfil::get_random_spot(self.team);
  }

  if(!isDefined(var_2)) {
    return;
  }

  var_3 = scripts\cp\infilexfil\infilexfil::player_on_spot(self, var_2);
  thread infil_player_array_handler(var_3["infil"]);
  self notify("player_added_to_infil");
  self thread[[var_3["callback"]]](var_3["infil"], var_3["seat"]);
  thread cponplayerdisconnectinfil();
}

function get_random_spot_in_infil(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in game["infil"][var_0]["spots"]) {
    if(var_5["infil"] != var_1) {
      continue;
    }

    if(!scripts\cp\infilexfil\infilexfil::is_spot_taken(var_0, var_5)) {
      var_2 = var_5;
    }
  }

  if(var_2.size == 0) {}

  var_4 = scripts\engine\utility::random(var_2);
  return var_4;
}

function infil_player_array_handler(var_0) {
  self endon("death");
  self.players = scripts\engine\utility::array_add(self.players, var_0);
  var_0 scripts\engine\utility::waittill_either("death", "disconnect");
  self.players = scripts\engine\utility::array_remove(self.players, var_0);
}

function alwaysgamemodeclass() {
  var_0 = self getclantag();

  if(var_0 == "AR") {
    var_1 = "default1";
  } else if(var_1 == "SMG") {
    var_1 = "default2";
  } else {
    jumpiffalse(var_1 == "LMG") LOC_00000049;
    var_1 = "default3";
    goto LOC_00000072;
  }

  LOC_00000072:
    self.pers["class"] = var_2;
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  return var_2;
}

#using_animtree("script_model");

function infil_player_rig(var_0, var_1, var_2) {
  self.animname = var_0;
  self predictstreampos(self.origin);
  var_3 = spawn("script_arms", self.origin, 0, 0, self);
  var_3.angles = self.angles;
  var_3.player = self;
  self.player_rig = var_3;
  self.player_rig hide(1);
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self playerlinktodelta(self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);

  if(isDefined(var_2) && var_2) {
    self playersetgroundreferenceent(self.player_rig);
  }

  self notify("rig_created");

  if(!isDefined(level.prematchallowfunc)) {
    level.prematchallowfunc = &cp_infil_player_allow;
  }

  self[[level.prematchallowfunc]](0);
  scripts\engine\utility::ref_143A6("remove_rig", "player_free_spot", "death");
  self[[level.prematchallowfunc]](1);

  if(isDefined(var_2) && var_2) {
    self playersetgroundreferenceent(undefined);
  }

  if(isDefined(self)) {
    self unlink();
  }

  if(isDefined(var_3)) {
    var_3 delete();
    return;
  }
}

function infil_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.players) {
    var_4 playsoundtoplayer(var_0, var_4);
  }
}

function infil_wait_for_players() {
  wait 5;
  scripts\engine\utility::flag_set("infil_started");
}

function infil_scene_fade_in(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!isDefined(var_1)) {
    var_1 = 2;
  }

  if(!isDefined(var_2)) {
    var_2 = "infil_started";
  }

  var_3 = newclienthudelem(self);
  var_3.x = 0;
  var_3.y = 0;
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = 1;
  var_3.foreground = 1;
  var_3 setshader("black", 640, 480);
  var_3 endon("death");
  scripts\engine\utility::ref_143A6(var_2, "player_free_spot", "disconnect");
  wait var_0;
  var_3 fadeovertime(var_1);
  var_3.alpha = 0;
  wait var_1;
  var_3 destroy();
}

function givegunlesscp() {
  var_0 = getcompleteweaponname("iw8_gunless");
  self.post_infil_weapon = self getcurrentprimaryweapon();
  scripts\cp\utility::_giveweapon(var_0, undefined, undefined, 1);

  if(!scripts\common\utility::is_script_weapon_switch_allowed()) {
    scripts\common\utility::allow_script_weapon_switch(1);
  }

  var_1 = 1;
  self switchtoweapon(var_0);

  if(var_1) {
    self.gunnlessweapon = var_0;
    scripts\common\utility::allow_weapon_switch(0);
  } else {
    self takeweapon(var_0);
  }

  return var_1;
}

function takegunlesscp() {
  if(!isDefined(self.gunnlessweapon) || !self hasweapon(self.gunnlessweapon)) {
    return;
  }

  self notify("get_post_infil_weapon");
  waitframe();
  self.takinggunless = 1;
  scripts\common\utility::allow_weapon_switch(1);
  self takeweapon(self.gunnlessweapon);
  self.takinggunless = 0;
  self.gunnlessweapon = undefined;
  scripts\common\utility::allow_weapon_switch(0);
}

function handleweaponstatenotetrackcp(var_0) {
  switch (var_0) {
    case "drop":
      self.player setdemeanorviewmodel("normal");
      wait 0.1;
      givegunlesscp(self.player);
      break;
    case "raise":
      takegunlesscp(self.player);

      if(isDefined(self.player.post_infil_weapon)) {
        self.player switchtoweapon(self.player.post_infil_weapon);
      }

      self.player.post_infil_weapon = undefined;
      break;
    case "safe":
      self.player setdemeanorviewmodel("safe");
      break;
    case "normal":
      self.player setdemeanorviewmodel("normal");
      break;
    case "free":
      self.player scripts\common\utility::allow_fire(1);
      self.player scripts\common\utility::allow_ads(1);
      self.player scripts\common\utility::allow_reload(1);
      break;
    case "hold":
      self.player scripts\common\utility::allow_fire(0);
      self.player scripts\common\utility::allow_ads(0);
      self.player scripts\common\utility::allow_reload(0);
      break;
  }
}