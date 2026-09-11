/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_infilexfil.gsc
***********************************************/

function infil_ended(var0) {
  level waittill("infil_started");
  var1 = 0;

  if(isDefined(level.extra_infil_time)) {
    var1 = level.extra_infil_time;
  }

  wait var0 + var1;
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
    level waittill("player_spawned", var0);
    var0 setclientomnvar("ui_hide_hud", 1);
    var1 = scripts\cp\infilexfil\infilexfil::get_spot_from_player(var0);

    if(isDefined(var1)) {
      cp_player_free_spot(var0, scripts\cp\utility::getotherteam(var0.team));
    }

    if(!scripts\engine\utility::flag("infil_started")) {
      cp_player_join_infil_cp(var0);
    }
  }
}

function cponplayerdisconnectinfil() {
  self endon("prematch_over");
  self waittill("disconnect");
  cp_player_free_spot(self);
}

function infil_is_type(var0) {
  return self.script_noteworthy == var0;
}

function infil_is_subtype(var0) {
  return self.name == var0;
}

function cp_infil_player_allow(var0) {
  self allowmovement(var0);
  scripts\common\utility::allow_prone(var0);
  scripts\common\utility::allow_crouch(var0);
  scripts\common\utility::allow_jump(var0);
  scripts\common\utility::allow_fire(var0);
  scripts\common\utility::allow_ads(var0);
  scripts\common\utility::allow_sprint(var0);
  scripts\common\utility::allow_melee(var0);
  scripts\common\utility::allow_reload(var0);
  scripts\common\utility::allow_lean(var0);
  scripts\common\utility::allow_slide(var0);
  scripts\common\utility::allow_offhand_weapons(var0);
  scripts\common\utility::allow_weapon_switch(var0);
  scripts\common\utility::allow_usability(var0);
}

function teamhasinfil(var0) {
  if(!isDefined(game["infil"])) {
    return false;
  }

  return isDefined(game["infil"][var0]["lanes"]);
}

function cp_player_free_spot(var0, var1) {
  if(!var0 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = var0.team;
  }

  if(isDefined(game["infil"][var1]["spots"])) {}

  foreach(var3 in game["infil"][var1]["spots"]) {
    if(scripts\cp\infilexfil\infilexfil::is_spot_taken(var1, var4) && var3["player"] == var0) {
      game["infil"][var1]["spots"][var4]["player"] = undefined;
      var0 notify("player_free_spot");
      return;
    }
  }
}

function cp_get_spot_by_priority(var0) {
  var1 = [];

  foreach(var3 in game["infil"][var0]["spots"]) {
    if(!scripts\cp\infilexfil\infilexfil::is_spot_taken(var0, var4)) {
      var1 = var4;
    }
  }

  if(var1.size == 0) {
    return undefined;
  }

  var5 = getdvarint("scr_infil_force_seat", -1);

  if(scripts\engine\utility::array_contains(var1, var5)) {
    return var5;
  }

  var6 = undefined;
  var7 = -1;

  foreach(var3 in var1) {
    var9 = game["infil"][var0]["spots"][var3]["priority"];

    if(!isDefined(var6) || var9 < var7) {
      var6 = var3;
      var7 = var9;
    }
  }

  return var6;
}

function cp_player_join_infil_cp() {
  if(game["infil"][self.team].size == 0) {
    return;
  }

  var0 = 0;
  var1 = game["infil"][self.team]["spots"][0]["priority"] != -1;

  if(level.gametype == "tac_ops" && isDefined(self.tacopsmapselectedarea.dynamicent)) {
    var2 = get_random_spot_in_infil(self.team, self.tacopsmapselectedarea.dynamicent);
  } else if(var1) {
    var2 = scripts\cp\infilexfil\infilexfil::get_spot_taken_count(self.team);
  } else if(var2) {
    var2 = cp_get_spot_by_priority(self.team);
  } else {
    var2 = scripts\cp\infilexfil\infilexfil::get_random_spot(self.team);
  }

  if(!isDefined(var2)) {
    return;
  }

  var3 = scripts\cp\infilexfil\infilexfil::player_on_spot(self, var2);
  thread infil_player_array_handler(var3["infil"]);
  self notify("player_added_to_infil");
  self thread[[var3["callback"]]](var3["infil"], var3["seat"]);
  thread cponplayerdisconnectinfil();
}

function get_random_spot_in_infil(var0, var1) {
  var2 = [];

  foreach(var5, var4 in game["infil"][var0]["spots"]) {
    if(var5["infil"] != var1) {
      continue;
    }

    if(!scripts\cp\infilexfil\infilexfil::is_spot_taken(var0, var5)) {
      var2 = var5;
    }
  }

  if(var2.size == 0) {}

  var4 = scripts\engine\utility::random(var2);
  return var4;
}

function infil_player_array_handler(var0) {
  self endon("death");
  self.players = scripts\engine\utility::array_add(self.players, var0);
  var0 scripts\engine\utility::waittill_either("death", "disconnect");
  self.players = scripts\engine\utility::array_remove(self.players, var0);
}

function alwaysgamemodeclass() {
  var0 = self getclantag();

  if(var0 == "AR") {
    var1 = "default1";
  } else if(var1 == "SMG") {
    var1 = "default2";
  } else {
    jumpiffalse(var1 == "LMG") LOC_00000049;
    var1 = "default3";
    goto LOC_00000072;
  }

  LOC_00000072:
    self.pers["class"] = var2;
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  return var2;
}

#using_animtree("script_model");

function infil_player_rig(var0, var1, var2) {
  self.animname = var0;
  self predictstreampos(self.origin);
  var3 = spawn("script_arms", self.origin, 0, 0, self);
  var3.angles = self.angles;
  var3.player = self;
  self.player_rig = var3;
  self.player_rig hide(1);
  self.player_rig.animname = var0;
  self.player_rig useanimtree(#animtree);
  self playerlinktodelta(self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);

  if(isDefined(var2) && var2) {
    self playersetgroundreferenceent(self.player_rig);
  }

  self notify("rig_created");

  if(!isDefined(level.prematchallowfunc)) {
    level.prematchallowfunc = &cp_infil_player_allow;
  }

  self[[level.prematchallowfunc]](0);
  scripts\engine\utility::ref_143a6("remove_rig", "player_free_spot", "death");
  self[[level.prematchallowfunc]](1);

  if(isDefined(var2) && var2) {
    self playersetgroundreferenceent(undefined);
  }

  if(isDefined(self)) {
    self unlink();
  }

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function infil_play_sound_func(var0, var1, var2) {
  foreach(var4 in self.players) {
    var4 playsoundtoplayer(var0, var4);
  }
}

function infil_wait_for_players() {
  wait 5;
  scripts\engine\utility::flag_set("infil_started");
}

function infil_scene_fade_in(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(!isDefined(var1)) {
    var1 = 2;
  }

  if(!isDefined(var2)) {
    var2 = "infil_started";
  }

  var3 = newclienthudelem(self);
  var3.x = 0;
  var3.y = 0;
  var3.alignx = "left";
  var3.aligny = "top";
  var3.sort = 1;
  var3.horzalign = "fullscreen";
  var3.vertalign = "fullscreen";
  var3.alpha = 1;
  var3.foreground = 1;
  var3 setshader("black", 640, 480);
  var3 endon("death");
  scripts\engine\utility::ref_143a6(var2, "player_free_spot", "disconnect");
  wait var0;
  var3 fadeovertime(var1);
  var3.alpha = 0;
  wait var1;
  var3 destroy();
}

function givegunlesscp() {
  var0 = getcompleteweaponname("iw8_gunless");
  self.post_infil_weapon = self getcurrentprimaryweapon();
  scripts\cp\utility::_giveweapon(var0, undefined, undefined, 1);

  if(!scripts\common\utility::is_script_weapon_switch_allowed()) {
    scripts\common\utility::allow_script_weapon_switch(1);
  }

  var1 = 1;
  self switchtoweapon(var0);

  if(var1) {
    self.gunnlessweapon = var0;
    scripts\common\utility::allow_weapon_switch(0);
  } else {
    self takeweapon(var0);
  }

  return var1;
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

function handleweaponstatenotetrackcp(var0) {
  switch (var0) {
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