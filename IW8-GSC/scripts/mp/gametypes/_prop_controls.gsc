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

function bettermissiontierbonuses(var0, var1, var2, var3) {
  var4 = scripts\mp\hud_util::createfontstring("default", 0.9);
  var4.x = 15;
  var4.y = self.initturretinteraction;
  var4.alignx = "left";
  var4.aligny = "top";
  var4.horzalign = "left_adjustable";
  var4.vertalign = "top_adjustable";
  var4.fontscale = 1;
  var4.alpha = 1;
  var4.glowalpha = 0;
  var4.hidewheninmenu = 0;
  var4.ref_1384b = var4.fontscale;

  if(isDefined(var3) && !scripts\engine\utility::is_player_gamepad_enabled()) {
    var4.label = var3;
  } else if(isDefined(var0)) {
    var4.label = var0;
  } else if(isDefined(var2)) {}

  if(isDefined(var1)) {
    var4 setvalue(var1);
  }

  self.initturretinteraction += 18;
  return var4;
}

function ref_128e4() {
  self.initturretinteraction = 152;
  self.getbrgametypedata = bettermissiontierbonuses(&"MP_PH/CHANGE", 0);
  self.ref_136f2 = bettermissiontierbonuses(&"MP_PH/SPIN", undefined, undefined, &"MP_PH/SPIN_PC");
  self.ref_119a2 = bettermissiontierbonuses(&"MP_PH/LOCK");
  self.ref_11b3d = bettermissiontierbonuses(&"MP_PH/SLOPE", undefined, undefined, &"MP_PH/SLOPE_PC");
  self.armor_piercing = bettermissiontierbonuses();
  self.heli_boss = bettermissiontierbonuses(&"MP_PH/CLONE");
  ref_13178();
  self.ref_1472b = bettermissiontierbonuses(&"MP_PH/ZOOM");
  thread ref_14027();
}

function has_keycard() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("death");
  thread has_been_turned_on();
  thread has_intel();
}

function ref_12e52(var0) {
  if(isDefined(var0)) {
    var0 destroy();
    return;
  }
}

function has_intel() {
  self notify("cleanupPropControlsHUD");
  ref_12e52(self.getbrgametypedata);
  ref_12e52(self.ref_136f2);
  ref_12e52(self.ref_119a2);
  ref_12e52(self.ref_11b3d);
  ref_12e52(self.armor_piercing);
  ref_12e52(self.ref_1472b);
  ref_12e52(self.ref_136da);
  ref_12e52(self.heli_boss);
}

function ref_14027() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(isbot(self)) {
    return;
  }

  waittillframeend();
  var0 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    var1 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var1 != var0) {
      var0 = var1;

      if(var1) {
        if(!istrue(self.ref_13414)) {
          self.ref_11b3d.label = &"MP_PH/SLOPE";
        } else {
          self.ref_11b3d.label = &"MP_PH/SLOPED";
        }
      } else if(!istrue(self.ref_13414)) {
        self.ref_11b3d.label = &"MP_PH/SLOPE_PC";
      } else {
        self.ref_11b3d.label = &"MP_PH/SLOPED_PC";
      }
    }

    waitframe();
  }
}

function ref_128f5() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  self.lock = 0;
  self.ref_13414 = 0;

  if(isbot(self)) {
    return;
  }

  if(!scripts\mp\gametypes\br_gametype_prop::ref_1408e()) {
    self setclientomnvar("ui_ph_is_locked", 0);
    self setclientomnvar("ui_ph_matching_slope", 0);
  }

  thread ref_12902();
  thread ref_128d9();
  thread ref_12908();
  self.ref_12913 = 0;
  self.needdefaultendgameflowonly = 0;
  self.isteamextracted = 1;

  for(;;) {
    var0 = scripts\engine\utility::ref_143b0("lock", "changeProp", "setToSlope", "propAbility", "cloneProp");

    if(!isDefined(var0)) {
      continue;
    }

    if(self.ref_12913) {
      continue;
    }

    if(self.needdefaultendgameflowonly) {
      continue;
    }

    waittillframeend();

    if(var0 == "lock") {
      ref_128f9();
      continue;
    }

    if(var0 == "changeProp") {
      ref_128da();
      continue;
    }

    if(var0 == "setToSlope") {
      ref_128fa();
      continue;
    }

    if(var0 == "propAbility") {
      ref_128d3();
      continue;
    }

    if(var0 == "cloneProp") {
      ref_128e2();
    }
  }
}

function ref_128f9() {
  if(self ismantling()) {
    return;
  }

  if(self.lock) {
    ref_13f1d();
    return;
  }

  ref_119a1();
}

function ref_12b34(var0) {
  var1 = 3;

  if(!isDefined(var0.ref_1406e)) {
    var0.ref_1406e = 0;
  }

  var0.ref_1406d[var0.ref_1406e] = var0.prop.info;
  var0.ref_1406e++;

  if(var0.ref_1406e >= var1) {
    var0.ref_1406e = 0;
    return;
  }
}

function ref_128da(var0) {
  if(!ref_128ee() && !istrue(var0)) {
    return;
  }

  if(istrue(level.pc) && !istrue(var0)) {
    var1 = 300;

    if(isDefined(self.warningendcallbacks) && gettime() - self.warningendcallbacks < var1) {
      return;
    }

    self.warningendcallbacks = gettime();
  }

  self notify("changed_prop");
  ref_12b34(self);
  self.prop.info = scripts\mp\gametypes\br_gametype_prop::reset_search_spot_light_nodes(self);
  ref_128dc(self.prop.info);
  self.maxhealth = int(scripts\mp\gametypes\br_gametype_prop::revive_stim(self.prop.info));
  self setnormalhealth(1);
  ref_13177(self.initplayerplunderevents);
  ref_13177("CLONE");

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408e()) {
    self.armor_piercing.alpha = 1;
    self.heli_boss.alpha = 1;
  }

  if(!istrue(var0)) {
    ref_128e6();
    return;
  }
}

function ref_128ee() {
  return self.getbrplayersnoteliminated > 0;
}

function ref_128e6() {
  ref_1290a(self.getbrplayersnoteliminated - 1);
}

function ref_1290a(var0) {
  self.getbrplayersnoteliminated = var0;

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408e()) {
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

function ref_128dc(var0) {
  self.prop.info = var0;
  self.ref_128f4 = var0;
  self.prop setModel(var0.modelname);
  self.prop.ref_1467e = var0.ref_1467e;
  self.prop.building_roof_chopper_reenforce = var0.building_roof_chopper_reenforce;
  self.prop unlink();
  self.ref_128ea unlink();
  self.ref_128ea.origin = self.ref_128d7.origin;
  self.prop.origin = self.ref_128ea.origin;
  self.ref_128ea.angles = (self.angles[0], self.ref_128ea.angles[1], self.angles[2]);
  self.prop.angles = self.ref_128ea.angles;

  if(istrue(self.turret_guncourse_think)) {
    self.prop.angles = self.angles;
    self.turret_guncourse_think = 0;
  }

  scripts\mp\gametypes\br_gametype_prop::calculateobjectivesheld();
  scripts\mp\gametypes\br_gametype_prop::cache1_defender_after_spawn();
  self.prop linkTo(self.ref_128ea, "J_prop_1");

  if(self.ref_13414 && istrue(self.lock)) {
    ref_130a7(self.ref_128ea, self.prop);
  }

  self.ref_128ea linkTo(self.ref_128d7);
  self.ref_13b30 = var0.ref_12905;
  self.ref_13b2f = var0.ref_128f1;
  self setcamerathirdperson(1, self.ref_13b30, self.ref_13b2f);
}

function ref_128fa() {
  if(!istrue(self.ref_13414)) {
    self.ref_13414 = 1;

    if(istrue(self.lock)) {
      self.ref_128ea unlink();
      ref_130a7(self.ref_128ea, self.prop);
      self.ref_128ea linkTo(self.ref_128d7);
    }

    if(scripts\mp\gametypes\br_gametype_prop::ref_1408e()) {
      if(scripts\engine\utility::is_player_gamepad_enabled()) {
        self.ref_11b3d.label = &"MP_PH/SLOPED";
        return;
      }

      self.ref_11b3d.label = &"MP_PH/SLOPED_PC";
      return;
    }

    self setclientomnvar("ui_ph_matching_slope", 1);
    return;
  }

  self.ref_13414 = 0;

  if(istrue(self.lock)) {
    self.ref_128ea unlink();
    self.ref_128ea.angles = (self.angles[0], self.ref_128ea.angles[1], self.angles[2]);
    self.ref_128ea.origin = self.ref_128d7.origin;
    self.ref_128ea linkTo(self.ref_128d7);
  }

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408e()) {
    if(scripts\engine\utility::is_player_gamepad_enabled()) {
      self.ref_11b3d.label = &"MP_PH/SLOPE";
      return;
    }

    self.ref_11b3d.label = &"MP_PH/SLOPE_PC";
    return;
  }

  self setclientomnvar("ui_ph_matching_slope", 0);
}

function ref_128d3() {
  if(ref_128f0()) {
    thread player_name_who_broke_stealth();
    ref_128e8();
    return;
  }
}

function ref_128e2() {
  if(ref_128ef()) {
    thread heli_boss_logic();
    thread ref_128e7();
    return;
  }
}

function ref_128ef() {
  return self.heli_boss_shoot > 0;
}

function ref_128e7() {
  ref_1290b(self.heli_boss_shoot - 1);
}

function ref_1290b(var0) {
  self.heli_boss_shoot = var0;

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408e()) {
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

function ref_128f0() {
  return self.armor_target_vo > 0;
}

function ref_128e8() {
  ref_1290c(self.armor_target_vo - 1);
}

function ref_1290c(var0) {
  self.armor_target_vo = var0;

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408e()) {
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

function ref_130a7(var0) {
  var1 = propwaitminigameinit(var0, 0);

  if(!isDefined(var1)) {
    return;
  }

  var2 = anglesToForward(self.angles);
  var3 = anglestoright(self.angles);
  var4 = vectortoangles(var1);
  var5 = angleclamp180(var4[0] + 90);
  var4 = (0, var4[1], 0);
  var6 = anglesToForward(var4);
  var7 = vectordot(var6, var3);

  if(var7 < 0) {
    var7 = -1;
  } else {
    var7 = 1;
  }

  var8 = vectordot(var6, var2);
  var9 = var8 * var5;
  var10 = (1 - abs(var8)) * var5 * var7;
  self.angles = (var9, self.angles[1], var10);
}

function remove_marker_when_player_get_close(var0, var1) {
  var2 = 128;
  var3 = game["defenders"];
  var4 = level.teamdata[var3]["alivePlayers"];

  if(var4.size > var2) {
    var4 = scripts\mp\utility\player::getplayersinradius(var0, 500, var3);

    if(var4.size > var2) {
      var4 = scripts\mp\utility\player::getplayersinradius(var0, 50, var3);

      if(var4.size > var2) {
        return var1;
      }
    }
  }

  var5 = [];

  foreach(var7 in var4) {
    var5 = var7.prop;
  }
}

function propwaitminigameinit(var0, var1) {
  if(!isDefined(var0)) {
    var2 = self;
  } else {
    var2 = var1;
  }

  var3 = remove_marker_when_player_get_close(self.origin, var2);
  var4 = [self.origin];
  var5 = -1;

  while(var5 <= 1) {
    var6 = -1;

    while(var6 <= 1) {
      var7 = var2 getpointinbounds(var5, var6, 0);
      var7 = (var7[0], var7[1], self.origin[2]);
      var4 = var7;
      var6 += 2;
    }

    var5 += 2;
  }

  var8 = (0, 0, 0);
  var9 = 0;

  foreach(var11 in var4) {
    var12 = scripts\engine\trace::_bullet_trace(var11 + (0, 0, 4), var11 + (0, 0, -16), 0, var3);
    var13 = var12["fraction"] > 0 && var12["fraction"] < 1;

    if(var13) {
      var8 += var12["normal"];
      var9++;
    }
  }

  if(var9 > 0) {
    var8 /= var9;
    return var8;
  }

  return undefined;
}

function ref_12902() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var0 = 0;
  var1 = 0;
  var2 = 0;

  for(;;) {
    waitframe();
    var3 = self getnormalizedmovement();
    var4 = self jumpbuttonPressed();

    if(!isDefined(var3)) {
      continue;
    }

    if(self.ref_12913) {
      continue;
    }

    var5 = var3[0] != 0 || var3[1] != 0 || var4;

    if(self.lock && var2 && !var5) {
      var2 = 0;
    } else if(self.lock && !var0 && var5) {
      var2 = 1;
    } else if(self.lock && var5 && !var2) {
      ref_13f1d();
    }

    var0 = self.lock;
    var1 = var5;
  }
}

function ref_13f1d() {
  self unlink();

  if(self.ref_13414) {
    self.ref_128ea unlink();
    self.ref_128ea.angles = (self.angles[0], self.ref_128ea.angles[1], self.angles[2]);
    self.ref_128ea.origin = self.ref_128d7.origin;
    self.ref_128ea linkTo(self.ref_128d7);
  }

  self.ref_128d7 linkTo(self);
  self.lock = 0;

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408e()) {
    self.ref_119a2.label = &"MP_PH/LOCK";
    thread player_origin_inside_subway_car();
    return;
  }

  self setclientomnvar("ui_ph_is_locked", 0);
}

function ref_119a1() {
  if(!get_alive_bots()) {
    return;
  }

  self.ref_128d7 unlink();
  self.ref_128d7.origin = self.origin;
  var0 = self getgroundentity();

  if(isDefined(var0) && nuke_vault_suicidebomber_internal(var0)) {
    self.ref_128d7 linkTo(var0);
  }

  self playerlinkTo(self.ref_128d7);

  if(self.ref_13414) {
    self.ref_128ea unlink();
    ref_130a7(self.ref_128ea, self.prop);
    self.ref_128ea.origin = self.origin;
    self.ref_128ea linkTo(self.ref_128d7);
  }

  self.lock = 1;
  self notify("locked");

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408e()) {
    self.ref_119a2.label = &"MP_PH/LOCKED";
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
  var0 = self.ref_119a2.ref_1384b + 0.75;
  self.ref_119a2 changefontscaleovertime(0.1);
  self.ref_119a2.fontscale = var0;
  wait 0.1;

  if(isDefined(self.ref_119a2)) {
    self.ref_119a2 changefontscaleovertime(0.1);
    self.ref_119a2.fontscale = self.ref_119a2.ref_1384b;
    return;
  }
}

function get_alive_bots() {
  if(!self isonground()) {
    var0 = getgroundposition(self.origin, 15, 30000, 0);
    var1 = getEntArray("trigger_hurt", "classname");

    foreach(var3 in var1) {
      if(ispointinvolume(var0, var3)) {
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
  jumpiftrue(isDefined(self.ref_136db)) LOC_00000023;
  self.ref_136db = 0;

  for(;;) {
    var0 = scripts\engine\utility::ref_143ac("spectate");

    if(self.needdefaultendgameflowonly) {
      continue;
    }

    if(var0 == "spectate") {
      if(self.ref_12913) {
        self notify("endPropSpectate");
        continue;
      }

      scripts\mp\gametypes\br_gametype_prop::init_swivelroom_variables();

      if(self.ref_136d7.size <= 1) {
        continue;
      }

      self.ref_12913 = 1;
      ref_128d4(0);
      thread ref_12911();
      GscBinSkip4(0x35);
    }
  }
}

function ref_12912() {
  self endon("endPropSpectate");

  if(getkeypadomnvarbitpackinginfo()) {
    ref_136dd();
    goto LOC_00000026;
  }

  play_travel_vo(1);
  ref_136dd();

  for(;;) {
    var0 = scripts\engine\utility::ref_143ad("zoomin", "zoomout");

    if(self.needdefaultendgameflowonly) {
      continue;
    }

    if(var0 == "zoomin") {
      play_travel_vo(1);
      getkeypadomnvarbitpackinginfo();
      ref_11dba();
    }

    if(var0 == "zoomout") {
      play_travel_vo(0);
      getkeypadomnvarbitpackinginfo();
      ref_11dba();
    }
  }
}

function getkeypadomnvarbitpackinginfo() {
  var0 = self.ref_136d7[self.ref_136db];

  if(!isDefined(var0)) {
    return false;
  }

  if(var0 == self) {
    return false;
  }

  if(scripts\mp\utility\player::isreallyalive(var0)) {
    return true;
  }

  return false;
}

function play_travel_vo(var0) {
  var1 = self.ref_136db;

  for(;;) {
    if(istrue(var0)) {
      self.ref_136db++;
    } else {
      self.ref_136db--;
    }

    if(var0 && self.ref_136d7.size <= self.ref_136db) {
      self.ref_136db = 0;
    } else if(self.ref_136db < 0) {
      self.ref_136db = self.ref_136d7.size - 1;
    }

    if(self.ref_136db == var1) {
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
  ref_12ce7();
  waittillframeend();
  ref_128d4(1);
  self.ref_12913 = 0;
  self.needdefaultendgameflowonly = 0;
}

function init_swivelroom_obj() {
  self.ref_136d9 = scripts\mp\hud_util::createfontstring("default", 1);
  self.ref_136d9.label = &"MP_PH/SPECCOMMANDS";
  self.ref_136d9.x = 20;
  self.ref_136d9.y = -80;
  self.ref_136d9.alignx = "center";
  self.ref_136d9.aligny = "middle";
  self.ref_136d9.horzalign = "center_adjustable";
  self.ref_136d9.vertalign = "bottom_adjustable";
  self.ref_136d9.archived = 1;
  self.ref_136d9.fontscale = 1;
  self.ref_136d9.alpha = 1;
  self.ref_136d9.glowalpha = 0.5;
  self.ref_136d9.hidewheninmenu = 0;
}

function lb_mg_impulse_dmg_factor_low() {
  if(isDefined(self.ref_136d9)) {
    self.ref_136d9 destroy();
    return;
  }
}

function ref_136dd() {
  var0 = self.ref_136d7[self.ref_136db];
  self.ref_136df = var0;
  self.ref_128d7 unlink();
  self.ref_128d7.origin = self.origin;
  self setOrigin(var0.origin);
  self.angles = var0.angles;
  self playerlinkTo(var0.ref_128d7);
}

function ref_11dba() {
  var0 = self.ref_136d7[self.ref_136db];
  self unlink();
  self.origin = var0.origin;
  self.angles = var0.angles;
  self playerlinkTo(var0.ref_128d7);
}

function ref_12ce7() {
  self unlink();
  self setOrigin(self.ref_128d7.origin);

  if(self.lock) {
    self playerlinkTo(self.ref_128d7);
    return;
  }

  self.ref_128d7 linkTo(self);
  self.ref_128d7.origin = self.origin;
}

function ref_11ebc() {
  level endon("game_ended");
  level waittill("noPropsToSpectate");
  ref_12e52(self.ref_136da);
}

function ref_128d9() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var0 = 10;
  self.ref_13b30 = self.prop.info.ref_12905;

  for(;;) {
    var1 = scripts\engine\utility::ref_143ad("zoomin", "zoomout");

    if(istrue(self.needdefaultendgameflowonly)) {
      continue;
    }

    if(!isDefined(var1)) {
      continue;
    }

    if(istrue(self.ref_12913)) {
      continue;
    }

    if(var1 == "zoomin") {
      if(self.ref_13b30 - var0 < 50) {
        continue;
      }

      self.ref_13b30 -= var0;
      self setcamerathirdperson(1, self.ref_13b30, self.ref_13b2f);
      continue;
    }

    if(var1 == "zoomout") {
      var2 = clamp(self.prop.info.ref_12905 + 50, 50, 360);

      if(self.ref_13b30 + var0 > var2) {
        continue;
      }

      self.ref_13b30 += var0;
      self setcamerathirdperson(1, self.ref_13b30, self.ref_13b2f);
    }
  }
}

function ref_12908() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    if(self adsButtonPressed(1) && !istrue(self.ref_128ea.ref_136f1)) {
      self.ref_128ea scriptmodelpauseanim(0);
      self.ref_128ea.ref_136f1 = 1;
    } else if(!self adsButtonPressed(1) && istrue(self.ref_128ea.ref_136f1)) {
      self.ref_128ea scriptmodelpauseanim(1);
      self.ref_128ea.ref_136f1 = 0;
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

function ref_13177(var0, var1) {
  switch (var0) {
    case "FLASH":
      if(!isDefined(var1)) {
        var1 = level.ref_12315.settings.ref_12904;
      }

      ref_1290c(var1);
      break;
    case "CLONE":
      if(!isDefined(var1)) {
        var1 = level.ref_12315.settings.ref_12903;
      }

      ref_1290b(var1);
      break;
    default:
      break;
  }
}

function player_pined_danger_feedback(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  thread scripts\mp\shellshock::endondeath();
  self endon("end_explode");
  self waittill("explode", var1);

  if(!isDefined(var0)) {
    return;
  }

  player_name_who_broke_stealth(var0, var1);
}

function player_name_who_broke_stealth(var0, var1) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  if(!isDefined(var1)) {
    var1 = self.origin;
  }

  playFX(scripts\engine\utility::getfx("propFlash"), var1 + (0, 0, 4));
  playsoundatpos(var1, "prop_flashbang");

  foreach(var3 in level.players) {
    if(var3 == var0) {
      continue;
    }

    if(istrue(var3.player_on_helipad)) {
      continue;
    }

    if(!isDefined(var3) || !isalive(var3) || !isDefined(var3.team) || var3 scripts\mp\gametypes\br_gametype_prop::ref_125f0()) {
      continue;
    }

    var4 = var1 + (0, 0, 4) - var3 getEye();
    var5 = length(var4);
    var6 = 500;
    var7 = 150;

    if(var5 <= var6) {
      if(var5 <= var7) {
        var8 = 1;
      } else {
        var8 = 1 - (var6 - var12) / (var7 - var12);
      }

      var9 = vectorNormalize(var5);
      var10 = anglesToForward(var4 getplayerangles());
      var11 = vectordot(var10, var9);
      applyflash(var4, var2 + (0, 0, 4), var8, var11, var1, var1.team, 2);
    }
  }

  var3 = undefined;
  var8 = undefined;
}

function applyflash(var0, var1, var2, var3, var4, var5) {
  var6 = 2.5;

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(var2 < 0.25) {
    var2 = 0.25;
  } else if(var2 > 0.8) {
    var2 = 1;
  }

  var7 = var1 * var2 * var6;
  var7 += var5;

  if(var7 < 0.25) {
    return;
  }

  var3 thread scripts\mp\damagefeedback::updatedamagefeedback("standard");
  thread scripts\mp\equipment\flash_grenade::applyflash(var3, var7);
}

function lastdirty() {
  var0 = 9;

  if(self.ref_128e3.size + 1 <= var0) {
    return;
  }

  var1 = 0;

  foreach(var3 in self.ref_128e3) {
    if(isDefined(var3)) {
      var1++;
    }
  }

  if(var1 + 1 <= var0) {
    return;
  }

  var5 = [];
  var6 = undefined;

  for(var7 = 0; var7 < self.ref_128e3.size; var7++) {
    var3 = self.ref_128e3[var7];

    if(!isDefined(var3)) {
      continue;
    }

    if(!isDefined(var6)) {
      var6 = var3;
      continue;
    }

    var5 = var3;
  }

  var6 notify("maxDelete");
  var6 delete();
  self.ref_128e3 = var5;
}

function heli_boss_logic() {
  if(!isDefined(self.ref_128e3)) {
    self.ref_128e3 = [];
  } else {
    lastdirty();
  }

  var0 = spawn("script_model", self.prop.origin);
  var0.targetname = "propClone";
  var0 setModel(self.prop.model);
  var0.angles = self.prop.angles;
  var0.health = 50;
  var0.playerowner = self;
  var0 setCanDamage(1);
  var0 thread scripts\mp\damage::monitordamage(var0.health, "hitequip", &heli_audio, &is_station_active);
  var0 thread scripts\mp\gametypes\br_gametype_prop::spawn_exfil_techo(game["defenders"], "outline_nodepth_orange");
  var0 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static", self.team);
  self.ref_128e3[self.ref_128e3.size] = var0;
}

function is_station_active(var0) {
  if(!isDefined(var0.attacker)) {
    return 0;
  }

  if(isPlayer(var0.attacker)) {
    if(istrue(self.unlockprop)) {
      return 0;
    }

    var0.attacker thread scripts\mp\damagefeedback::updatedamagefeedback("hitequip");
    self.lastattacker = var0.inflictor;
  }

  return var0.damage;
}

function heli_audio(var0) {
  if(!isDefined(self.unlockprop)) {
    self.unlockprop = 1;
  }

  if(isDefined(self.lastattacker)) {
    self.lastattacker thread scripts\mp\gametypes\br_gametype_prop::scriptablesmax("clone_destroyed");

    if(isDefined(self.playerowner)) {
      self.playerowner thread scripts\mp\gametypes\br_gametype_prop::scriptablesmax("clone_was_destroyed");
    }
  }

  var1 = "prop_death";
  var2 = "propDeathFX";
  playsoundatpos(self.origin + (0, 0, 4), var1);
  playFX(scripts\engine\utility::getfx(var2), self.origin + (0, 0, 4));

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function patched_collision(var0, var1, var2) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var0)) {
    var0 = 5;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  var3 = newclienthudelem(self);
  var3.foreground = 0;
  var3.x = 0;
  var3.y = 0;
  var3 setshader("black", 640, 480);
  var3.alignx = "left";
  var3.aligny = "top";
  var3.horzalign = "fullscreen";
  var3.vertalign = "fullscreen";
  var3.alpha = 0;
  waitframe();

  if(var1 > 0) {
    var3 fadeovertime(var1);
  }

  var3.alpha = 1;
  wait var0 - var2;

  if(var2 > 0) {
    var3 fadeovertime(var2);
  }

  var3.alpha = 0;
  wait var2;
  waitframe();
  ref_12e52(var3);
}

function ref_144f6() {
  self endon("death_or_disconnect");
  self notifyonplayercommand("specialGrenade", "+smoke");

  for(;;) {
    self waittill("specialGrenade");
    self.ref_13b5e += 1;
  }
}

function spawn_carried_punchcard_if_player_down() {
  level waittill("game_ended");

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408e()) {
    level.monitor_player_plundercount.alpha = 0;
    level.ref_12315.ref_145bb.alpha = 0;
    level.ref_145bc.alpha = 0;
  }

  foreach(var1 in level.players) {
    ref_128d4(var1, 0);
  }
}

function ref_12e64(var0, var1) {
  if(isDefined(var0)) {
    var0.alpha = var1;
    return;
  }
}

function ref_128d4(var0, var1) {
  if(istrue(var0)) {
    var2 = 1;
  } else {
    var2 = 0;
  }

  if(scripts\mp\gametypes\br_gametype_prop::ref_1408e() || istrue(var2)) {
    ref_12e64(self.getbrgametypedata, var2);
    ref_12e64(self.ref_136f2, var2);
    ref_12e64(self.ref_119a2, var2);
    ref_12e64(self.ref_11b3d, var2);
    ref_12e64(self.armor_piercing, var2);
    ref_12e64(self.heli_boss, var2);
    ref_12e64(self.ref_1472b, var2);

    if(!istrue(level.ref_11eb9)) {
      ref_12e64(self.ref_136da, var2);
      return;
    }

    return;
  }
}