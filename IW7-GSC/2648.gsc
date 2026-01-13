/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2648.gsc
***************************************/

mt_getprogress(var_0) {
  return self getrankedplayerdata("cp", "meritProgress", var_0);
}

mt_getstate(var_0) {
  return self getrankedplayerdata("cp", "meritState", var_0);
}

mt_setprogress(var_0, var_1) {
  if(var_0 == "mt_highest_round") {
    var_2 = mt_getstate("mt_highest_round");
    var_3 = mt_gettarget("mt_highest_round", var_2);

    if(level.wave_num >= var_3) {
      return self setrankedplayerdata("cp", "meritProgress", var_0, var_3);
    }
  } else
    return self setrankedplayerdata("cp", "meritProgress", var_0, var_1);
}

mt_setstate(var_0, var_1) {
  return self setrankedplayerdata("cp", "meritState", var_0, var_1);
}

mt_gettarget(var_0, var_1) {
  return int(tablelookup("cp\allMeritsTable.csv", 0, var_0, 10 + var_1 * 3));
}

playpainoverlay(var_0, var_1, var_2) {
  if(scripts\cp\utility::isusingremote() && scripts\engine\utility::is_true(self.vanguard_num)) {
    return;
  }
  var_3 = get_damage_direction(var_2);

  if(is_spitter_spit(var_1)) {
    play_spitter_pain_overlay(var_3);
  } else if(is_spitter_gas(var_1)) {
    play_spitter_pain_overlay("center");
  } else if(is_elite_attack(var_0)) {
    playfxontagforclients(level._effect["vfx_melee_blood_spray"], self, "tag_eye", self);
  } else {
    play_basic_pain_overlay(var_3);
  }
}

get_damage_direction(var_0) {
  var_1 = 0.965;
  var_2 = ["left", "center", "right"];

  if(!isDefined(var_0)) {
    return var_2[randomint(var_2.size)];
  }

  var_0 = var_0 * -1;
  var_3 = anglesToForward(self.angles);
  var_4 = vectordot(var_0, var_3);

  if(var_4 > var_1) {
    return "center";
  }

  var_5 = anglestoright(self.angles);
  var_6 = vectordot(var_0, var_5);

  if(var_6 > 0) {
    return "right";
  } else {
    return "left";
  }
}

is_spitter_spit(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0 == "alienspit_mp";
}

is_spitter_gas(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  return var_0 == "alienspit_gas_mp";
}

is_elite_attack(var_0) {
  if(!isDefined(var_0) || !var_0 scripts\cp\cp_agent_utils::is_alien_agent()) {
    return 0;
  }

  return scripts\cp\cp_agent_utils::get_agent_type(var_0) == "elite";
}

play_spitter_pain_overlay(var_0) {
  if(!scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    return;
  }
  if(var_0 == "left") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_left"], self, "tag_eye", self);
  } else if(var_0 == "center") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_center"], self, "tag_eye", self);
  } else if(var_0 == "right") {
    playfxontagforclients(level._effect["vfx_alien_spitter_hit_right"], self, "tag_eye", self);
  }
}

play_basic_pain_overlay(var_0) {
  var_1 = self;

  if(!isDefined(self.model) || self.model == "") {
    return;
  }
  if(!scripts\cp\utility::has_tag(self.model, "tag_eye")) {
    return;
  }
  if(var_0 == "left") {
    playfxontagforclients(level._effect["vfx_blood_hit_left"], var_1, "tag_eye", self);
  } else if(var_0 == "center") {
    playfxontagforclients(level._effect["vfx_melee_blood_spray"], var_1, "tag_eye", self);
  } else if(var_0 == "right") {
    playfxontagforclients(level._effect["vfx_blood_hit_right"], var_1, "tag_eye", self);
  }
}

zom_player_damage_flash() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvarbit("player_damaged", 1, 1);
  wait 0.05;
  self setclientomnvarbit("player_damaged", 1, 0);
}

zom_player_health_overlay_watcher() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvarbit("player_damaged", 2, 0);
  var_0 = 0;
  var_1 = 1;

  for(;;) {
    if(self.health <= 45 && var_0 == 0) {
      if(!self issplitscreenplayer()) {
        self setclienttriggeraudiozonepartialwithfade("painvision_cp", 0.02, "mix", "reverb", "filter");
      }

      var_0 = 1;
    }

    if(var_0 && var_1) {
      if(!scripts\cp\cp_laststand::player_in_laststand(self)) {
        self setclientomnvarbit("player_damaged", 2, 1);
      }

      var_1 = 0;
    }

    if(var_0 && self.health > 45) {
      self clearclienttriggeraudiozone(0.3);
      var_0 = 0;
      self setclientomnvarbit("player_damaged", 2, 0);
      var_1 = 1;
    }

    wait 0.05;
  }
}

introscreen_corner_line(var_0, var_1) {
  if(!isDefined(level.intro_offset)) {
    level.intro_offset = 0;
  } else {
    level.intro_offset++;
  }

  var_2 = cornerline_height();
  var_3 = 1.6;

  if(level.splitscreen) {
    var_3 = 2;
  }

  var_4 = newhudelem();
  var_4.x = 20;
  var_4.y = var_2;
  var_4.alignx = "left";
  var_4.aligny = "bottom";
  var_4.horzalign = "left";
  var_4.vertalign = "bottom";
  var_4.sort = 3;
  var_4.foreground = 1;
  var_4 give_zap_perk(var_0);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.fontscale = var_3;
  var_4.color = (0.8, 1, 0.8);
  var_4.font = "default";
  var_4.glowcolor = (0.3, 0.6, 0.3);
  var_4.glowalpha = 1;
  return var_4;
}

cornerline_height() {
  var_0 = -92;

  if(level.splitscreen) {
    var_0 = -110;
  }

  return level.intro_offset * 20 - 92;
}