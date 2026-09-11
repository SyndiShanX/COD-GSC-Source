/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hud_util.gsc
***********************************************/

function mt_getprogress(var0) {
  return self getplayerdata("cp", "meritProgress", var0);
}

function mt_getstate(var0) {
  return self getplayerdata("cp", "meritState", var0);
}

function mt_setprogress(var0, var1) {
  if(var0 == "mt_highest_round") {
    var2 = mt_getstate("mt_highest_round");
    var3 = mt_gettarget("mt_highest_round", var2);

    if(level.wave_num >= var3) {
      return self setplayerdata("cp", "meritProgress", var0, var3);
    }

    return;
  }

  return self setplayerdata("cp", "meritProgress", var2, var3);
}

function mt_setstate(var0, var1) {
  return self setplayerdata("cp", "meritState", var0, var1);
}

function mt_gettarget(var0, var1) {
  return int(tablelookup("cp/allMeritsTable.csv", 0, var0, 10 + var1 * 3));
}

function playpainoverlay(var0, var1, var2) {
  if(scripts\cp\utility::isusingremote() && istrue(self.vanguard_num)) {
    return;
  }

  var3 = get_damage_direction(var2);

  if(is_spitter_spit(var1)) {
    play_spitter_pain_overlay(var3);
    return;
  }

  if(is_spitter_gas(var1)) {
    play_spitter_pain_overlay("center");
    return;
  }

  play_basic_pain_overlay(var3);
}

function get_damage_direction(var0) {
  var1 = 0.965;
  var2 = ["left", "center", "right"];

  if(!isDefined(var0)) {
    return var2[randomint(var2.size)];
  }

  var0 *= -1;
  var3 = anglesToForward(self.angles);
  var4 = vectordot(var0, var3);

  if(var4 > var1) {
    return "center";
  }

  var5 = anglestoright(self.angles);
  var6 = vectordot(var0, var5);

  if(var6 > 0) {
    return "right";
  }

  return "left";
}

function is_spitter_spit(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  return var0 == "alienspit_mp";
}

function is_spitter_gas(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  return var0 == "alienspit_gas_mp";
}

function is_elite_attack(var0) {
  if(!isDefined(var0) || !var0 scripts\cp\cp_agent_utils::is_alien_agent()) {
    return false;
  }

  return scripts\cp\cp_agent_utils::get_agent_type(var0) == "elite";
}

function play_spitter_pain_overlay(var0) {
  if(!scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    return;
  }

  if(var0 == "left") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_left"], self, "tag_eye", self);
    return;
  }

  if(var0 == "center") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_center"], self, "tag_eye", self);
    return;
  }

  if(var0 == "right") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_right"], self, "tag_eye", self);
    return;
  }
}

function play_basic_pain_overlay(var0) {
  var1 = self;

  if(!isDefined(self.model) || self.model == "") {
    return;
  }

  if(!scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    return;
  }
}

function ref_12480() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvar("ui_damage_event", self.damageeventcount);
}

function zom_player_health_overlay_watcher() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  var0 = 0;
  var1 = 1;

  for(;;) {
    if(self.health <= 45 && var0 == 0) {
      if(!self issplitscreenplayer()) {
        self setclienttriggeraudiozonepartialwithfade("painvision", 0.02, "mix", "reverb", "filter");
        self stoplocalsound("deaths_door_out");
        self playlocalsound("deaths_door_in");
      }

      var0 = 1;
    }

    if(var0 && var1) {
      if(scripts\cp\cp_laststand::player_in_laststand(self)) {}

      var1 = 0;
    }

    if(var0 && self.health > 45) {
      self clearclienttriggeraudiozone(0.3);
      self playlocalsound("deaths_door_out");
      self stoplocalsound("deaths_door_in");
      var0 = 0;
      var1 = 1;
    }

    wait 0.05;
  }
}

function introscreen_corner_line(var0, var1) {
  if(!isDefined(level.intro_offset)) {
    level.intro_offset = 0;
  } else {
    level.intro_offset++;
  }

  var2 = cornerline_height();
  var3 = 1.6;

  if(level.splitscreen) {
    var3 = 2;
  }

  var4 = newhudelem();
  var4.x = 20;
  var4.y = var2;
  var4.alignx = "left";
  var4.aligny = "bottom";
  var4.horzalign = "left";
  var4.vertalign = "bottom";
  var4.sort = 3;
  var4.foreground = 1;
  var4 settext(var0);
  var4.alpha = 1;
  var4.hidewheninmenu = 1;
  var4.fontscale = var3;
  var4.color = (0.8, 1, 0.8);
  var4.font = "default";
  var4.glowcolor = (0.3, 0.6, 0.3);
  var4.glowalpha = 1;
  return var4;
}

function cornerline_height() {
  var0 = -92;

  if(level.splitscreen) {
    var0 = -110;
  }

  return level.intro_offset * 20 - 92;
}

function teamplayercardsplash(var0, var1, var2, var3, var4) {
  if(level.hardcoremode) {
    return;
  }

  foreach(var6 in level.players) {
    if(isDefined(var2) && var6.team != var2) {
      continue;
    }

    if(!isPlayer(var6)) {
      continue;
    }

    if(!isDefined(var4)) {
      var6 thread scripts\cp\cp_hud_message::showsplash(var0, var3, var1);
    }
  }
}