/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\_prop_controls.gsc
***************************************************/

function ref_13256() {
  if(isbot(self)) {
    return;
  }

  self notifyonplayercommand("lock", "+attack");
  self notifyonplayercommand("lock", "+attack_akimbo_accessible");
  self notifyonplayercommand("changeProp", "+weapnext");
  self notifyonplayercommand("setToSlope", "+usereload");
  self notifyonplayercommand("setToSlope", "+activate");
  self notifyonplayercommand("propAbility", "+smoke");
  self notifyonplayercommand("cloneProp", "+actionslot 2");
  self notifyonplayercommand("zoomin", "+actionslot 3");
  self notifyonplayercommand("zoomout", "+actionslot 4");
  thread has_current_combat_action();
}

function has_current_combat_action() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("cleanupKeyBindings");
  self waittill("death");
  thread has_been_turned_on();
}

function has_been_turned_on() {
  self notify("cleanupKeyBindings");

  if(isbot(self)) {
    return;
  }

  self notifyonplayercommandremove("lock", "+attack");
  self notifyonplayercommandremove("lock", "+attack_akimbo_accessible");
  self notifyonplayercommandremove("changeProp", "+weapnext");
  self notifyonplayercommandremove("setToSlope", "+usereload");
  self notifyonplayercommandremove("setToSlope", "+activate");
  self notifyonplayercommandremove("propAbility", "+smoke");
  self notifyonplayercommandremove("cloneProp", "+actionslot 2");
  self notifyonplayercommandremove("zoomin", "+actionslot 3");
  self notifyonplayercommandremove("zoomout", "+actionslot 4");
}

function bettermissiontierbonuses(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\hud_util::createfontstring("default", 0.9);
  var_4.x = 15;
  var_4.y = self.initturretinteraction;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.horzalign = "left_adjustable";
  var_4.vertalign = "top_adjustable";
  var_4.fontscale = 1;
  var_4.alpha = 1;
  var_4.glowalpha = 0;
  var_4.hidewheninmenu = 0;
  var_4.ref_1384B = var_4.fontscale;

  if(isDefined(var_3) && !scripts\engine\utility::is_player_gamepad_enabled()) {
    var_4.label = var_3;
  } else if(isDefined(var_0)) {
    var_4.label = var_0;
  } else if(isDefined(var_2)) {}

  if(isDefined(var_1)) {
    var_4 setvalue(var_1);
  }

  self.initturretinteraction += 18;
  return var_4;
}

function ref_128E4() {
  self.initturretinteraction = 152;
  self.getbrgametypedata = bettermissiontierbonuses(&"MP_PH/CHANGE", 0);
  self.ref_136F2 = bettermissiontierbonuses(&"MP_PH/SPIN", undefined, undefined, &"MP_PH/SPIN_PC");
  self.ref_119A2 = bettermissiontierbonuses(&"MP_PH/LOCK");
  self.ref_11B3D = bettermissiontierbonuses(&"MP_PH/SLOPE", undefined, undefined, &"MP_PH/SLOPE_PC");
  self.armor_piercing = bettermissiontierbonuses();
  self.heli_boss = bettermissiontierbonuses(&"MP_PH/CLONE");
  ref_13178();
  self.ref_1472B = bettermissiontierbonuses(&"MP_PH/ZOOM");
  thread ref_14027();
}

function has_keycard() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  thread has_been_turned_on();
  thread has_intel();
}

function ref_12E52(var_0) {
  if(isDefined(var_0)) {
    var_0 destroy();
    return;
  }
}

function has_intel() {
  self notify("cleanupPropControlsHUD");
  ref_12E52(self.getbrgametypedata);
  ref_12E52(self.ref_136F2);
  ref_12E52(self.ref_119A2);
  ref_12E52(self.ref_11B3D);
  ref_12E52(self.armor_piercing);
  ref_12E52(self.ref_1472B);
  ref_12E52(self.ref_136DA);
  ref_12E52(self.heli_boss);
}

function ref_14027() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isbot(self)) {
    return;
  }

  waittillframeend();
  var_0 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    var_1 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var_1 != var_0) {
      var_0 = var_1;

      if(var_1) {
        if(!istrue(self.ref_13414)) {
          self.ref_11B3D.label = &"MP_PH/SLOPE";
        } else {
          self.ref_11B3D.label = &"MP_PH/SLOPED";
        }
      } else if(!istrue(self.ref_13414)) {
        self.ref_11B3D.label = &"MP_PH/SLOPE_PC";
      } else {
        self.ref_11B3D.label = &"MP_PH/SLOPED_PC";
      }
    }

    waitframe();
  }
}

function ref_128F5() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.lock = 0;
  self.ref_13414 = 0;

  if(isbot(self)) {
    return;
  }

  if(!scripts\mp\gametypes\br_gametype_prop::ref_1408E()) {
    self setclientomnvar("ui_ph_is_locked", 0);
    self setclientomnvar("ui_ph_matching_slope", 0);
  }

  thread ref_12902();
  thread ref_128D9();
  thread ref_12908();
  self.ref_12913 = 0;
  self.needdefaultendgameflowonly = 0;
  self.isteamextracted = 1;

  for(;;) {
    var_0 = scripts\engine\utility::ref_143B0("lock", "changeProp", "setToSlope", "propAbility", "cloneProp");

    if(!isDefined(var_0)) {
      continue;
    }

    if(self.ref_12913) {
      continue;
    }

    if(self.needdefaultendgameflowonly) {
      continue;
    }

    waittillframeend();

    if(var_0 == "lock") {
      ref_128F9();
      continue;
    }

    if(var_0 == "changeProp") {
      ref_128DA();
      continue;
    }

    if(var_0 == "setToSlope") {
      ref_128FA();
      continue;
    }

    if(var_0 == "propAbility") {
      ref_128D3();
      continue;
    }

    if(var_0 == "cloneProp") {
      ref_128E2();
    }
  }
}

function ref_128F9() {
  if(self ismantling()) {
    return;
  }

  if(self.lock) {
    ref_13F1D();
    return;
  }

  ref_119A1();
}

function ref_12B34(var_0) {
  var_1 = 3;

  if(!isDefined(var_0.ref_1406E)) {
    var_0.ref_1406E = 0;
  }

  var_0.ref_1406D[var_0.ref_1406E] = var_0.prop.info;
  var_0.ref_1406E++;

  if(var_0.ref_1406E >= var_1) {
    var_0.ref_1406E = 0;
    return;
  }
}

function ref_128DA(var_0) {
  if(!ref_128EE() && !istrue(var_0)) {
    return;
  }

  if(istrue(level.pc) && !istrue(var_0)) {
    var_1 = 300;

    if(isDefined(self.warningendcallbacks) && gettime() - self.warningendcallbacks < var_1) {
      return;
    }

    self.warningendcallbacks = gettime();
  }

  self notify("changed_prop");
  ref_12B34(self);
  self.prop.info = scripts\mp\gametypes\br_gametype_prop::reset_search_spot_light_nodes(self);
  ref_128DC(self.prop.info);
  self.maxhealth = int(scripts\mp\gametypes\br_gametype_prop::revive_stim(self.prop.info));
  self setnormalhealth(1);
  ref_13177(self.initplayerplunderevents);
  ref_13177("CLONE");

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408E()) {
    self.armor_piercing.alpha = 1;
    self.heli_boss.alpha = 1;
  }

  if(!istrue(var_0)) {
    ref_128E6();
    return;
  }
}

function ref_128EE() {
  return self.getbrplayersnoteliminated > 0;
}

function ref_128E6() {
  ref_1290A(self.getbrplayersnoteliminated - 1);
}

function ref_1290A(var_0) {
  self.getbrplayersnoteliminated = var_0;

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408E()) {
    self.getbrgametypedata setvalue(self.getbrplayersnoteliminated);

    if(self.getbrplayersnoteliminated <= 0) {
      self.getbrgametypedata.alpha = 0.5;
      return;
    }

    if(self.getbrplayersnoteliminated > 0 && self.getbrgametypedata.alpha < 1) {
      self.getbrgametypedata.alpha = 1;
      return;
    }

    return;
  }

  self setclientomnvar("ui_ph_num_changes_left", self.getbrplayersnoteliminated);
}

function ref_128DC(var_0) {
  self.prop.info = var_0;
  self.ref_128F4 = var_0;
  self.prop setModel(var_0.modelname);
  self.prop.ref_1467E = var_0.ref_1467E;
  self.prop.building_roof_chopper_reenforce = var_0.building_roof_chopper_reenforce;
  self.prop unlink();
  self.ref_128EA unlink();
  self.ref_128EA.origin = self.ref_128D7.origin;
  self.prop.origin = self.ref_128EA.origin;
  self.ref_128EA.angles = (self.angles[0], self.ref_128EA.angles[1], self.angles[2]);
  self.prop.angles = self.ref_128EA.angles;

  if(istrue(self.turret_guncourse_think)) {
    self.prop.angles = self.angles;
    self.turret_guncourse_think = 0;
  }

  scripts\mp\gametypes\br_gametype_prop::calculateobjectivesheld();
  scripts\mp\gametypes\br_gametype_prop::cache1_defender_after_spawn();
  self.prop linkTo(self.ref_128EA, "J_prop_1");

  if(self.ref_13414 && istrue(self.lock)) {
    ref_130A7(self.ref_128EA, self.prop);
  }

  self.ref_128EA linkTo(self.ref_128D7);
  self.ref_13B30 = var_0.ref_12905;
  self.ref_13B2F = var_0.ref_128F1;
  self setcamerathirdperson(1, self.ref_13B30, self.ref_13B2F);
}

function ref_128FA() {
  if(!istrue(self.ref_13414)) {
    self.ref_13414 = 1;

    if(istrue(self.lock)) {
      self.ref_128EA unlink();
      ref_130A7(self.ref_128EA, self.prop);
      self.ref_128EA linkTo(self.ref_128D7);
    }

    if(scripts\mp\gametypes\br_gametype_prop::ref_1408E()) {
      if(scripts\engine\utility::is_player_gamepad_enabled()) {
        self.ref_11B3D.label = &"MP_PH/SLOPED";
        return;
      }

      self.ref_11B3D.label = &"MP_PH/SLOPED_PC";
      return;
    }

    self setclientomnvar("ui_ph_matching_slope", 1);
    return;
  }

  self.ref_13414 = 0;

  if(istrue(self.lock)) {
    self.ref_128EA unlink();
    self.ref_128EA.angles = (self.angles[0], self.ref_128EA.angles[1], self.angles[2]);
    self.ref_128EA.origin = self.ref_128D7.origin;
    self.ref_128EA linkTo(self.ref_128D7);
  }

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408E()) {
    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      self.ref_11B3D.label = &"MP_PH/SLOPE";
      return;
    }

    self.ref_11B3D.label = &"MP_PH/SLOPE_PC";
    return;
  }

  self setclientomnvar("ui_ph_matching_slope", 0);
}

function ref_128D3() {
  if(ref_128F0()) {
    thread player_name_who_broke_stealth();
    ref_128E8();
    return;
  }
}

function ref_128E2() {
  if(ref_128EF()) {
    thread heli_boss_logic();
    thread ref_128E7();
    return;
  }
}

function ref_128EF() {
  return self.heli_boss_shoot > 0;
}

function ref_128E7() {
  ref_1290B(self.heli_boss_shoot - 1);
}

function ref_1290B(var_0) {
  self.heli_boss_shoot = var_0;

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408E()) {
    self.heli_boss setvalue(self.heli_boss_shoot);

    if(self.heli_boss_shoot <= 0) {
      self.heli_boss.alpha = 0.5;
      return;
    }

    if(self.heli_boss_shoot > 0 && self.heli_boss.alpha < 1) {
      self.heli_boss.alpha = 1;
      return;
    }

    return;
  }

  self setclientomnvar("ui_ph_num_clones_left", self.heli_boss_shoot);
}

function ref_128F0() {
  return self.armor_target_vo > 0;
}

function ref_128E8() {
  ref_1290C(self.armor_target_vo - 1);
}

function ref_1290C(var_0) {
  self.armor_target_vo = var_0;

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408E()) {
    self.armor_piercing setvalue(self.armor_target_vo);

    if(self.armor_target_vo <= 0) {
      self.armor_piercing.alpha = 0.5;
      return;
    }

    if(self.armor_target_vo > 0 && self.armor_piercing.alpha < 1) {
      self.armor_piercing.alpha = 1;
      return;
    }

    return;
  }

  self setclientomnvar("ui_ph_num_flashes_left", self.armor_target_vo);
}

function ref_130A7(var_0) {
  var_1 = propwaitminigameinit(var_0, 0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = anglesToForward(self.angles);
  var_3 = anglestoright(self.angles);
  var_4 = vectortoangles(var_1);
  var_5 = angleclamp180(var_4[0] + 90);
  var_4 = (0, var_4[1], 0);
  var_6 = anglesToForward(var_4);
  var_7 = vectordot(var_6, var_3);

  if(var_7 < 0) {
    var_7 = -1;
  } else {
    var_7 = 1;
  }

  var_8 = vectordot(var_6, var_2);
  var_9 = var_8 * var_5;
  var_10 = (1 - abs(var_8)) * var_5 * var_7;
  self.angles = (var_9, self.angles[1], var_10);
}

function remove_marker_when_player_get_close(var_0, var_1) {
  var_2 = 128;
  var_3 = game["defenders"];
  var_4 = level.teamdata[var_3]["alivePlayers"];

  if(var_4.size > var_2) {
    var_4 = scripts\mp\utility\player::getplayersinradius(var_0, 500, var_3);

    if(var_4.size > var_2) {
      var_4 = scripts\mp\utility\player::getplayersinradius(var_0, 50, var_3);

      if(var_4.size > var_2) {
        return var_1;
      }
    }
  }

  var_5 = [];

  foreach(var_7 in var_4) {
    var_5 = var_7.prop;
  }
}

function propwaitminigameinit(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_2 = self;
  } else {
    var_2 = var_1;
  }

  var_3 = remove_marker_when_player_get_close(self.origin, var_2);
  var_4 = [self.origin];
  var_5 = -1;

  while(var_5 <= 1) {
    var_6 = -1;

    while(var_6 <= 1) {
      var_7 = var_2 getpointinbounds(var_5, var_6, 0);
      var_7 = (var_7[0], var_7[1], self.origin[2]);
      var_4 = var_7;
      var_6 += 2;
    }

    var_5 += 2;
  }

  var_8 = (0, 0, 0);
  var_9 = 0;

  foreach(var_11 in var_4) {
    var_12 = scripts\engine\trace::_bullet_trace(var_11 + (0, 0, 4), var_11 + (0, 0, -16), 0, var_3);
    var_13 = var_12["fraction"] > 0 && var_12["fraction"] < 1;

    if(var_13) {
      var_8 += var_12["normal"];
      var_9++;
    }
  }

  if(var_9 > 0) {
    var_8 /= var_9;
    return var_8;
  }

  return undefined;
}

function ref_12902() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    waitframe();
    var_3 = self getnormalizedmovement();
    var_4 = self jumpbuttonPressed();

    if(!isDefined(var_3)) {
      continue;
    }

    if(self.ref_12913) {
      continue;
    }

    var_5 = var_3[0] != 0 || var_3[1] != 0 || var_4;

    if(self.lock && var_2 && !var_5) {
      var_2 = 0;
    } else if(self.lock && !var_0 && var_5) {
      var_2 = 1;
    } else if(self.lock && var_5 && !var_2) {
      ref_13F1D();
    }

    var_0 = self.lock;
    var_1 = var_5;
  }
}

function ref_13F1D() {
  self unlink();

  if(self.ref_13414) {
    self.ref_128EA unlink();
    self.ref_128EA.angles = (self.angles[0], self.ref_128EA.angles[1], self.angles[2]);
    self.ref_128EA.origin = self.ref_128D7.origin;
    self.ref_128EA linkTo(self.ref_128D7);
  }

  self.ref_128D7 linkTo(self);
  self.lock = 0;

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408E()) {
    self.ref_119A2.label = &"MP_PH/LOCK";
    thread player_origin_inside_subway_car();
    return;
  }

  self setclientomnvar("ui_ph_is_locked", 0);
}

function ref_119A1() {
  if(!get_alive_bots()) {
    return;
  }

  self.ref_128D7 unlink();
  self.ref_128D7.origin = self.origin;
  var_0 = self getgroundentity();

  if(isDefined(var_0) && nuke_vault_suicidebomber_internal(var_0)) {
    self.ref_128D7 linkTo(var_0);
  }

  self playerlinkTo(self.ref_128D7);

  if(self.ref_13414) {
    self.ref_128EA unlink();
    ref_130A7(self.ref_128EA, self.prop);
    self.ref_128EA.origin = self.origin;
    self.ref_128EA linkTo(self.ref_128D7);
  }

  self.lock = 1;
  self notify("locked");

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408E()) {
    self.ref_119A2.label = &"MP_PH/LOCKED";
    thread player_origin_inside_subway_car();
    return;
  }

  self setclientomnvar("ui_ph_is_locked", 1);
}

function nuke_vault_suicidebomber_internal() {
  return isalive(self) && (scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle");
}

function player_origin_inside_subway_car() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self notify("flashLockPropKey");
  self endon("flashLockPropKey");
  var_0 = self.ref_119A2.ref_1384B + 0.75;
  self.ref_119A2 changefontscaleovertime(0.1);
  self.ref_119A2.fontscale = var_0;
  wait 0.1;

  if(isDefined(self.ref_119A2)) {
    self.ref_119A2 changefontscaleovertime(0.1);
    self.ref_119A2.fontscale = self.ref_119A2.ref_1384B;
    return;
  }
}

function get_alive_bots() {
  if(!self isonground()) {
    var_0 = getgroundposition(self.origin, 15, 30000, 0);
    var_1 = getEntArray("trigger_hurt", "classname");

    foreach(var_3 in var_1) {
      if(ispointinvolume(var_0, var_3)) {
        return false;
      }
    }
  }

  return true;
}

function ref_12910() {
  level endon("noPropsToSpectate");
  self.ref_12913 = 0;
  self.needdefaultendgameflowonly = 0;
  jumpiftrue(isDefined(self.ref_136DB)) LOC_00000023;
  self.ref_136DB = 0;

  for(;;) {
    var_0 = scripts\engine\utility::ref_143AC("spectate");

    if(self.needdefaultendgameflowonly) {
      continue;
    }

    if(var_0 == "spectate") {
      if(self.ref_12913) {
        self notify("endPropSpectate");
        continue;
      }

      scripts\mp\gametypes\br_gametype_prop::init_swivelroom_variables();

      if(self.ref_136D7.size <= 1) {
        continue;
      }

      self.ref_12913 = 1;
      ref_128D4(0);
      thread ref_12911();
      GscBinSkip4(0x35);
    }
  }
}

function ref_12912() {
  self endon("endPropSpectate");

  if(getkeypadomnvarbitpackinginfo()) {
    ref_136DD();
    goto LOC_00000026;
  }

  play_travel_vo(1);
  ref_136DD();

  for(;;) {
    var_0 = scripts\engine\utility::ref_143AD("zoomin", "zoomout");

    if(self.needdefaultendgameflowonly) {
      continue;
    }

    if(var_0 == "zoomin") {
      play_travel_vo(1);
      getkeypadomnvarbitpackinginfo();
      ref_11DBA();
    }

    if(var_0 == "zoomout") {
      play_travel_vo(0);
      getkeypadomnvarbitpackinginfo();
      ref_11DBA();
    }
  }
}

function getkeypadomnvarbitpackinginfo() {
  var_0 = self.ref_136D7[self.ref_136DB];

  if(!isDefined(var_0)) {
    return false;
  }

  if(var_0 == self) {
    return false;
  }

  if(scripts\mp\utility\player::isreallyalive(var_0)) {
    return true;
  }

  return false;
}

function play_travel_vo(var_0) {
  var_1 = self.ref_136DB;

  for(;;) {
    if(istrue(var_0)) {
      self.ref_136DB++;
    } else {
      self.ref_136DB--;
    }

    if(var_0 && self.ref_136D7.size <= self.ref_136DB) {
      self.ref_136DB = 0;
    } else if(self.ref_136DB < 0) {
      self.ref_136DB = self.ref_136D7.size - 1;
    }

    if(self.ref_136DB == var_1) {
      break;
    }

    if(getkeypadomnvarbitpackinginfo()) {
      break;
    }
  }
}

function ref_12911() {
  self endon("death_or_disconnect");
  init_swivelroom_obj();
  scripts\engine\utility::waittill_any_ents(self, "endPropSpectate", level, "noPropsToSpectate");

  if(istrue(self.needdefaultendgameflowonly)) {
    return;
  }

  self.needdefaultendgameflowonly = 1;
  lb_mg_impulse_dmg_factor_low();
  ref_12CE7();
  waittillframeend();
  ref_128D4(1);
  self.ref_12913 = 0;
  self.needdefaultendgameflowonly = 0;
}

function init_swivelroom_obj() {
  self.ref_136D9 = scripts\mp\hud_util::createfontstring("default", 1);
  self.ref_136D9.label = &"MP_PH/SPECCOMMANDS";
  self.ref_136D9.x = 20;
  self.ref_136D9.y = -80;
  self.ref_136D9.alignx = "center";
  self.ref_136D9.aligny = "middle";
  self.ref_136D9.horzalign = "center_adjustable";
  self.ref_136D9.vertalign = "bottom_adjustable";
  self.ref_136D9.archived = 1;
  self.ref_136D9.fontscale = 1;
  self.ref_136D9.alpha = 1;
  self.ref_136D9.glowalpha = 0.5;
  self.ref_136D9.hidewheninmenu = 0;
}

function lb_mg_impulse_dmg_factor_low() {
  if(isDefined(self.ref_136D9)) {
    self.ref_136D9 destroy();
    return;
  }
}

function ref_136DD() {
  var_0 = self.ref_136D7[self.ref_136DB];
  self.ref_136DF = var_0;
  self.ref_128D7 unlink();
  self.ref_128D7.origin = self.origin;
  self setOrigin(var_0.origin);
  self.angles = var_0.angles;
  self playerlinkTo(var_0.ref_128D7);
}

function ref_11DBA() {
  var_0 = self.ref_136D7[self.ref_136DB];
  self unlink();
  self.origin = var_0.origin;
  self.angles = var_0.angles;
  self playerlinkTo(var_0.ref_128D7);
}

function ref_12CE7() {
  self unlink();
  self setOrigin(self.ref_128D7.origin);

  if(self.lock) {
    self playerlinkTo(self.ref_128D7);
    return;
  }

  self.ref_128D7 linkTo(self);
  self.ref_128D7.origin = self.origin;
}

function ref_11EBC() {
  level endon("game_ended");
  level waittill("noPropsToSpectate");
  ref_12E52(self.ref_136DA);
}

function ref_128D9() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_0 = 10;
  self.ref_13B30 = self.prop.info.ref_12905;

  for(;;) {
    var_1 = scripts\engine\utility::ref_143AD("zoomin", "zoomout");

    if(istrue(self.needdefaultendgameflowonly)) {
      continue;
    }

    if(!isDefined(var_1)) {
      continue;
    }

    if(istrue(self.ref_12913)) {
      continue;
    }

    if(var_1 == "zoomin") {
      if(self.ref_13B30 - var_0 < 50) {
        continue;
      }

      self.ref_13B30 -= var_0;
      self setcamerathirdperson(1, self.ref_13B30, self.ref_13B2F);
      continue;
    }

    if(var_1 == "zoomout") {
      var_2 = clamp(self.prop.info.ref_12905 + 50, 50, 360);

      if(self.ref_13B30 + var_0 > var_2) {
        continue;
      }

      self.ref_13B30 += var_0;
      self setcamerathirdperson(1, self.ref_13B30, self.ref_13B2F);
    }
  }
}

function ref_12908() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    if(self adsButtonPressed(1) && !istrue(self.ref_128EA.ref_136F1)) {
      self.ref_128EA scriptmodelpauseanim(0);
      self.ref_128EA.ref_136F1 = 1;
    } else if(!self adsButtonPressed(1) && istrue(self.ref_128EA.ref_136F1)) {
      self.ref_128EA scriptmodelpauseanim(1);
      self.ref_128EA.ref_136F1 = 0;
    }

    wait 0.05;
  }
}

function ref_13178() {
  switch (self.initplayerplunderevents) {
    case "FLASH":
      self.armor_piercing.label = &"MP_PH/FLASH";
      break;
    default:
      break;
  }
}

function ref_13177(var_0, var_1) {
  switch (var_0) {
    case "FLASH":
      if(!isDefined(var_1)) {
        var_1 = level.ref_12315.settings.ref_12904;
      }

      ref_1290C(var_1);
      break;
    case "CLONE":
      if(!isDefined(var_1)) {
        var_1 = level.ref_12315.settings.ref_12903;
      }

      ref_1290B(var_1);
      break;
    default:
      break;
  }
}

function player_pined_danger_feedback(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  thread scripts\mp\shellshock::endondeath();
  self endon("end_explode");
  self waittill("explode", var_1);

  if(!isDefined(var_0)) {
    return;
  }

  player_name_who_broke_stealth(var_0, var_1);
}

function player_name_who_broke_stealth(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  if(!isDefined(var_1)) {
    var_1 = self.origin;
  }

  playFX(scripts\engine\utility::getfx("propFlash"), var_1 + (0, 0, 4));
  playsoundatpos(var_1, "prop_flashbang");

  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }

    if(istrue(var_3.player_on_helipad)) {
      continue;
    }

    if(!isDefined(var_3) || !isalive(var_3) || !isDefined(var_3.team) || var_3 scripts\mp\gametypes\br_gametype_prop::ref_125F0()) {
      continue;
    }

    var_4 = var_1 + (0, 0, 4) - var_3 getEye();
    var_5 = length(var_4);
    var_6 = 500;
    var_7 = 150;

    if(var_5 <= var_6) {
      if(var_5 <= var_7) {
        var_8 = 1;
      } else {
        var_8 = 1 - (var_6 - var_12) / (var_7 - var_12);
      }

      var_9 = vectorNormalize(var_5);
      var_10 = anglesToForward(var_4 getplayerangles());
      var_11 = vectordot(var_10, var_9);
      applyflash(var_4, var_2 + (0, 0, 4), var_8, var_11, var_1, var_1.team, 2);
    }
  }

  var_3 = undefined;
  var_8 = undefined;
}

function applyflash(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 2.5;

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(var_2 < 0.25) {
    var_2 = 0.25;
  } else if(var_2 > 0.8) {
    var_2 = 1;
  }

  var_7 = var_1 * var_2 * var_6;
  var_7 += var_5;

  if(var_7 < 0.25) {
    return;
  }

  var_3 thread scripts\mp\damagefeedback::updatedamagefeedback("standard");
  thread scripts\mp\equipment\flash_grenade::applyflash(var_3, var_7);
}

function lastdirty() {
  var_0 = 9;

  if(self.ref_128E3.size + 1 <= var_0) {
    return;
  }

  var_1 = 0;

  foreach(var_3 in self.ref_128E3) {
    if(isDefined(var_3)) {
      var_1++;
    }
  }

  if(var_1 + 1 <= var_0) {
    return;
  }

  var_5 = [];
  var_6 = undefined;

  for(var_7 = 0; var_7 < self.ref_128E3.size; var_7++) {
    var_3 = self.ref_128E3[var_7];

    if(!isDefined(var_3)) {
      continue;
    }

    if(!isDefined(var_6)) {
      var_6 = var_3;
      continue;
    }

    var_5 = var_3;
  }

  var_6 notify("maxDelete");
  var_6 delete();
  self.ref_128E3 = var_5;
}

function heli_boss_logic() {
  if(!isDefined(self.ref_128E3)) {
    self.ref_128E3 = [];
  } else {
    lastdirty();
  }

  var_0 = spawn("script_model", self.prop.origin);
  var_0.targetname = "propClone";
  var_0 setModel(self.prop.model);
  var_0.angles = self.prop.angles;
  var_0.health = 50;
  var_0.playerowner = self;
  var_0 setCanDamage(1);
  var_0 thread scripts\mp\damage::monitordamage(var_0.health, "hitequip", &heli_audio, &is_station_active);
  var_0 thread scripts\mp\gametypes\br_gametype_prop::spawn_exfil_techo(game["defenders"], "outline_nodepth_orange");
  var_0 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self.team);
  self.ref_128E3[self.ref_128E3.size] = var_0;
}

function is_station_active(var_0) {
  if(!isDefined(var_0.attacker)) {
    return 0;
  }

  if(isPlayer(var_0.attacker)) {
    if(istrue(self.unlockprop)) {
      return 0;
    }

    var_0.attacker thread scripts\mp\damagefeedback::updatedamagefeedback("hitequip");
    self.lastattacker = var_0.inflictor;
  }

  return var_0.damage;
}

function heli_audio(var_0) {
  if(!isDefined(self.unlockprop)) {
    self.unlockprop = 1;
  }

  if(isDefined(self.lastattacker)) {
    self.lastattacker thread scripts\mp\gametypes\br_gametype_prop::scriptablesmax("clone_destroyed");

    if(isDefined(self.playerowner)) {
      self.playerowner thread scripts\mp\gametypes\br_gametype_prop::scriptablesmax("clone_was_destroyed");
    }
  }

  var_1 = "prop_death";
  var_2 = "propDeathFX";
  playsoundatpos(self.origin + (0, 0, 4), var_1);
  playFX(scripts\engine\utility::getfx(var_2), self.origin + (0, 0, 4));

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function patched_collision(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var_0)) {
    var_0 = 5;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = newclienthudelem(self);
  var_3.foreground = 0;
  var_3.x = 0;
  var_3.y = 0;
  var_3 setshader("black", 640, 480);
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = 0;
  waitframe();

  if(var_1 > 0) {
    var_3 fadeovertime(var_1);
  }

  var_3.alpha = 1;
  wait var_0 - var_2;

  if(var_2 > 0) {
    var_3 fadeovertime(var_2);
  }

  var_3.alpha = 0;
  wait var_2;
  waitframe();
  ref_12E52(var_3);
}

function ref_144F6() {
  self endon("death_or_disconnect");
  self notifyonplayercommand("specialGrenade", "+smoke");

  for(;;) {
    self waittill("specialGrenade");
    self.ref_13B5E += 1;
  }
}

function spawn_carried_punchcard_if_player_down() {
  level waittill("game_ended");

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408E()) {
    level.monitor_player_plundercount.alpha = 0;
    level.ref_12315.ref_145BB.alpha = 0;
    level.ref_145BC.alpha = 0;
  }

  foreach(var_1 in level.players) {
    ref_128D4(var_1, 0);
  }
}

function ref_12E64(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0.alpha = var_1;
    return;
  }
}

function ref_128D4(var_0, var_1) {
  if(istrue(var_0)) {
    var_2 = 1;
  } else {
    var_2 = 0;
  }

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408E() || istrue(var_2)) {
    ref_12E64(self.getbrgametypedata, var_2);
    ref_12E64(self.ref_136F2, var_2);
    ref_12E64(self.ref_119A2, var_2);
    ref_12E64(self.ref_11B3D, var_2);
    ref_12E64(self.armor_piercing, var_2);
    ref_12E64(self.heli_boss, var_2);
    ref_12E64(self.ref_1472B, var_2);

    if(!istrue(level.ref_11EB9)) {
      ref_12E64(self.ref_136DA, var_2);
      return;
    }

    return;
  }
}