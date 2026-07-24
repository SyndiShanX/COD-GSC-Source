/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marsbase\marsbase_killstreak.gsc
************************************************************/

_id_9676() {
  precacheitem("mars_killstreak");
  precacheshader("apache_target_lock");
  precacheshader("veh_hud_diamond");
  precacheshader("veh_hud_missile");
  precacheshader("veh_hud_missile_locked");
  precacheshader("veh_jackal_ally_target");
  level.player notifyonplayercommand("ks_action_2", "+actionslot 2");
  scripts\engine\utility::flag_init("player_in_mars_killstreak");
  scripts\engine\utility::flag_init("mars_killstreak_offline");
  scripts\engine\utility::flag_init("mars_killstreak_missiles_in_progress");
  scripts\engine\utility::flag_init("show_tutorial");
  level._effect["mars_killstreak_missile_streak"] = loadfx("vfx/iw7/_requests/mars/mars_killstreak_missile_streak.vfx");
  level._effect["mars_killstreak_missile_expl"] = loadfx("vfx/iw7/levels/mars/vfx_mars_missile_strike_exp.vfx");
  _id_12EC();
  _id_12EB();
  _id_12EA();
  _id_1334();
  _id_131E();
  level._id_B3B8 = [];

  for(var_0 = 0; var_0 < 24; var_0++)
    level._id_B3B8[var_0] = 0;

  level.player thread _id_133D();
  scripts\sp\utility::_id_9187("mars_killstreak_targeting_outline", 301, ::_id_B392);
}

_id_B392() {
  var_0 = [];
  var_0["r_hudOutlineWidth"] = 1;
  var_0["r_hudoutlineFillColor0"] = "0.9 0.9 0.9 0.5";
  var_0["r_hudoutlineFillColor1"] = "0.3 0.3 0.3 0.5";
  var_0["r_hudoutlineOccludedOutlineColor"] = "1 1 1 1";
  var_0["r_hudoutlineOccludedInlineColor"] = "1 1 1 0.8";
  var_0["r_hudoutlineOccludedInteriorColor"] = "1 1 1 1";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  var_0["r_drawTransEIDListBeforeOpaques"] = 1;
  var_0["cg_hud_outline_colors_4"] = "0.945 0.384 0.247 0.6";
  var_0["cg_hud_outline_colors_5"] = "0.945 0.384 0.247 0.3";
  var_0["cg_hud_outline_colors_6"] = "0.882 0.882 0.882 0.3";
  return var_0;
}

_id_B38F() {
  var_0 = 0;
  var_1 = 0.35;
  var_2 = 0;
  var_3 = 0.8;
  var_4 = [];
  var_4[var_4.size] = "cg_hud_outline_colors_4";
  var_5 = 0;

  while(var_0 != 0 && var_5 <= var_0) {
    foreach(var_7 in var_4) {
      var_8 = getDvar(var_7);
      var_9 = strtok(var_8, " ");
      var_10 = var_2 + var_5 / var_0 * (var_3 - var_2);
      var_11 = "" + var_9[0] + " " + var_9[1] + " " + var_9[2] + " " + var_10;
      setsaveddvar(var_7, var_11);
    }

    var_5 = var_5 + 0.05;
    wait 0.05;
  }

  var_13 = var_1;

  while(var_13 > 0) {
    foreach(var_7 in var_4) {
      var_8 = getDvar(var_7);
      var_9 = strtok(var_8, " ");
      var_10 = var_2 + var_13 / var_1 * (var_3 - var_2);
      var_11 = "" + var_9[0] + " " + var_9[1] + " " + var_9[2] + " " + var_10;
      setsaveddvar(var_7, var_11);
    }

    var_13 = var_13 - 0.05;
    wait 0.05;
  }
}

_id_82E7(var_0) {
  level.player._id_2711 = 1;
  level.player scripts\sp\utility::_id_8294("mars_killstreak");
  _id_131D(var_0);
  level.player thread _id_1329();
}

_id_1143D() {
  thread _id_141D();
}

_id_141D() {
  self endon("death");

  if(!scripts\engine\utility::is_true(self._id_2711)) {
    return;
  }
  while(!isDefined(level.player._id_1586))
    scripts\engine\utility::waitframe();

  self notify("end_mars_killstreak_text");
  scripts\sp\utility::_id_11425();
  self notify("take_mars_killstreak");
  self._id_2711 = 0;
}

_id_1329() {
  self endon("death");
  level.player._id_4C2F = self getcurrentweapon();
  level.player.lastweapon = level.player._id_4C2F;

  for(;;) {
    scripts\engine\utility::waittill_any("weapon_change", "weapon_dropped");
    var_0 = self getcurrentweapon();

    if(issubstr("mars_killstreak", var_0) && !level._id_B3B7)
      self switchtoweapon(level.player._id_4C2F);
    else {
      level.player.lastweapon = level.player._id_4C2F;
      level.player._id_4C2F = var_0;
    }

    wait 0.05;
  }
}

_id_B262(var_0) {
  if(!scripts\engine\utility::flag_exist(var_0 + "_destroyed"))
    scripts\engine\utility::flag_init(var_0 + "_destroyed");

  var_1 = undefined;

  foreach(var_3 in level._id_B3B2) {
    if(var_3.targetname == var_0) {
      var_1 = var_3;
      break;
    }
  }

  if(isDefined(var_1)) {
    var_1._id_11554 = 1;

    if(isDefined(level._id_B3B1))
      level.player thread _id_130E();
  }
}

_id_12EC() {
  var_0 = 3500;
  var_1 = 56;
  var_2 = 50;
  level._id_B3B5 = "orbit_a1";
  var_3 = "orbit_a1";
  level._id_B3B6[var_3] = spawnStruct();
  level._id_B3B6[var_3]._id_C6DF = scripts\engine\utility::getStruct(getEnt(var_3, "targetname").target, "targetname");
  level._id_B3B6[var_3]._id_C6D8 = var_0;
  level._id_B3B6[var_3]._id_C6DE = var_1;
  level._id_B3B6[var_3]._id_C6DA = var_2;
  level._id_B3B6[var_3]._id_C6DD = 135;
  level._id_B3B6[var_3]._id_C6DC = 160;
  level._id_B3B6[var_3]._id_2F06 = "killstreak_area1";
  thread _id_132B(var_3);
  var_3 = "orbit_a2";
  level._id_B3B6[var_3] = spawnStruct();
  level._id_B3B6[var_3]._id_C6DF = scripts\engine\utility::getStruct(getEnt(var_3, "targetname").target, "targetname");
  level._id_B3B6[var_3]._id_C6D8 = var_0 * 0.75;
  level._id_B3B6[var_3]._id_C6DE = var_1;
  level._id_B3B6[var_3]._id_C6DA = var_2;
  level._id_B3B6[var_3]._id_C6DD = 110;
  level._id_B3B6[var_3]._id_C6DC = 140;
  level._id_B3B6[var_3]._id_2F06 = "killstreak_greenhouse";
  thread _id_132B(var_3);
  var_3 = "orbit_canyon1";
  level._id_B3B6[var_3] = spawnStruct();
  level._id_B3B6[var_3]._id_C6DF = scripts\engine\utility::getStruct(getEnt(var_3, "targetname").target, "targetname");
  level._id_B3B6[var_3]._id_C6D8 = var_0 * 0.95;
  level._id_B3B6[var_3]._id_C6DE = var_1;
  level._id_B3B6[var_3]._id_C6DA = var_2;
  level._id_B3B6[var_3]._id_C6DD = 145;
  level._id_B3B6[var_3]._id_C6DC = 190;
  level._id_B3B6[var_3]._id_2F06 = "killstreak_area2";
  thread _id_132B(var_3);
  var_3 = "orbit_hill1";
  level._id_B3B6[var_3] = spawnStruct();
  level._id_B3B6[var_3]._id_C6DF = scripts\engine\utility::getStruct(getEnt(var_3, "targetname").target, "targetname");
  level._id_B3B6[var_3]._id_C6D8 = var_0;
  level._id_B3B6[var_3]._id_C6DE = var_1;
  level._id_B3B6[var_3]._id_C6DA = var_2;
  level._id_B3B6[var_3]._id_C6DD = 135;
  level._id_B3B6[var_3]._id_C6DC = 190;
  level._id_B3B6[var_3]._id_2F06 = "killstreak_area3";
  thread _id_132B(var_3);
  var_3 = "orbit_hill2";
  level._id_B3B6[var_3] = spawnStruct();
  level._id_B3B6[var_3]._id_C6DF = scripts\engine\utility::getStruct(getEnt(var_3, "targetname").target, "targetname");
  level._id_B3B6[var_3]._id_C6D8 = var_0;
  level._id_B3B6[var_3]._id_C6DE = var_1;
  level._id_B3B6[var_3]._id_C6DA = var_2;
  level._id_B3B6[var_3]._id_C6DD = 135;
  level._id_B3B6[var_3]._id_C6DC = 175;
  level._id_B3B6[var_3]._id_2F06 = "killstreak_area3";
  thread _id_132B(var_3);
  var_3 = "orbit_hill3";
  level._id_B3B6[var_3] = spawnStruct();
  level._id_B3B6[var_3]._id_C6DF = scripts\engine\utility::getStruct(getEnt(var_3, "targetname").target, "targetname");
  level._id_B3B6[var_3]._id_C6D8 = var_0;
  level._id_B3B6[var_3]._id_C6DE = var_1;
  level._id_B3B6[var_3]._id_C6DA = var_2;
  level._id_B3B6[var_3]._id_C6DD = 60;
  level._id_B3B6[var_3]._id_C6DC = 150;
  level._id_B3B6[var_3]._id_2F06 = "killstreak_area3";
  thread _id_132B(var_3);
}

_id_12EB() {
  level._id_B3B3 = [];
  var_0 = getEntArray("killstreak_boundary_volume", "script_noteworthy");
  var_1 = scripts\engine\utility::getStructArray("killstreak_boundary_edge", "script_noteworthy");

  foreach(var_3 in var_0) {
    level._id_B3B3[var_3.targetname] = spawnStruct();
    level._id_B3B3[var_3.targetname].volume = var_3;
  }

  foreach(var_6 in var_1) {
    var_7 = [];
    var_8 = var_6;

    for(;;) {
      var_7[var_7.size] = var_8;

      if(!isDefined(var_8.target)) {
        break;
      }

      var_9 = scripts\engine\utility::getStruct(var_8.target, "targetname");
      var_8 = var_9;
    }

    level._id_B3B3[var_6.targetname]._id_132A8 = var_7;
  }
}

_id_132B(var_0) {
  for(;;) {
    scripts\sp\utility::_id_127B3(var_0);
    level._id_B3B5 = var_0;

    if(scripts\engine\utility::string_starts_with(var_0, "orbit_hill")) {
      level.drone_cam_geo_filler show();
      continue;
    }

    level.drone_cam_geo_filler hide();
  }
}

_id_12EA() {
  level._id_B3B2 = [];
  var_0 = scripts\engine\utility::getStructArray("mars_killstreak_aagun", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::spawn_tag_origin();
    var_3.origin = var_2.origin;
    var_3.dead = 0;
    var_3.targetname = var_2.targetname;
    var_3._id_8C33 = 0;
    var_3._id_11554 = 0;
    var_3._id_ABF8 = level.gun[var_2.targetname];
    level._id_B3B2[level._id_B3B2.size] = var_3;
  }
}

_id_133D() {
  self endon("death");

  for(;;) {
    scripts\engine\utility::waittill_any("weapon_change", "weapon_dropped");

    if(issubstr(self getcurrentweapon(), "mars_killstreak") && level._id_B3B7 && !isDefined(self.melee)) {
      self notify("mars_killstreak_start");
      scripts\engine\utility::flag_set("player_in_mars_killstreak");
      level.player playSound("mons_remote_targeting_hud_start_lr");

      if(!isDefined(level.player._id_914E)) {
        level.player._id_914E = scripts\engine\utility::play_loopsound_in_space("mons_remote_targeting_hud_loop_lr", level.player.origin);
        level.player._id_914E linkTo(level.player);
      } else
        level.player._id_914E playLoopSound("mons_remote_targeting_hud_loop_lr");

      level.player setclienttriggeraudiozonepartialwithfade("mons_remote_targeting", 2.0, "mix", "filter");
      thread _id_1340();
      var_0 = getdvarfloat("sm_sunCascadeSizeMultiplier2");
      setsaveddvar("sm_sunCascadeSizeMultiplier2", var_0 * 1.5);
      scripts\engine\utility::waittill_any("mars_killstreak_done");
      setsaveddvar("sm_sunCascadeSizeMultiplier2", var_0);
      level.player clearclienttriggeraudiozone(2);
      scripts\engine\utility::flag_clear("player_in_mars_killstreak");
      continue;
    }

    if(issubstr(self getcurrentweapon(), "mars_killstreak") && !level._id_B3B7)
      level.player thread scripts\sp\utility::_id_56BE("hint_monsweapon_not_ready", 2);
  }
}

_id_1348(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  level._id_B3B1._id_E322 = level._id_B3B1._id_E321.origin;
  var_2 = anglesToForward(level._id_B3B1._id_C6D9.angles);
  var_3 = level._id_B3B1._id_E322 - var_2 * level._id_B3B1._id_C6D8;

  if(var_0) {
    level._id_B3B1._id_E322 = _id_1311(level._id_B3B1._id_E322 + var_1);
    var_3 = level._id_B3B1._id_E322 - var_2 * level._id_B3B1._id_C6D8;
  }

  var_4 = level._id_B3B1._id_C6D8;
  var_5 = scripts\common\trace::ray_trace(var_3, var_3 + var_2 * var_4, [level.player]);
  var_6 = var_5["position"];

  if(isDefined(level._id_B3B1.target))
    var_6 = scripts\sp\math::_id_ACE9(var_3, var_6, level._id_B3B1.target, (0, 0, 1));

  var_7 = level._id_B3B1._id_E320.origin;
  level._id_B3B1._id_E320.origin = var_6;
  level._id_B3B1._id_E323.origin = var_6;

  if(_id_1324()) {
    _id_133F(level._id_B3B1.target, level._id_B3B1._id_E320.origin);

    foreach(var_9 in level._id_B3B1._id_10E4D)
    var_9.angles = level._id_B3B1._id_5B1C[0].angles;
  }
}

_id_1341(var_0) {
  var_1 = level.player getEye();
  var_2 = level._id_B3B1._id_C6D8;
  var_3 = vectorNormalize(var_0 - var_1);
  var_4 = scripts\common\trace::ray_trace(var_1, var_1 + var_3 * var_2, [level.player]);
  var_5 = var_4["position"];
  return var_5;
}

_id_133C() {
  thread _id_130E();
  thread _id_1321();
}

_id_130E() {
  self notify("set_aagun_targets");
  self endon("death");
  self endon("set_aagun_targets");
  var_0 = [];

  foreach(var_2 in level._id_B3B2) {
    if(var_2._id_11554 == 1 && var_2.dead == 0 && var_2._id_8C33 == 0)
      var_0[var_0.size] = var_2;
  }

  foreach(var_2 in var_0) {
    var_5 = _id_1336(var_2, 2);

    if(isDefined(var_2._id_ABF8.turret))
      var_2._id_ABF8.turret scripts\sp\utility::_id_9196(1, 1, 1, "mars_killstreak_targeting_outline");

    if(isDefined(var_2._id_ABF8._id_129CC))
      var_2._id_ABF8._id_129CC scripts\sp\utility::_id_9196(1, 1, 1, "mars_killstreak_targeting_outline");

    if(isDefined(var_2._id_ABF8.turret) && isDefined(var_2._id_ABF8._id_129CC)) {
      var_2 thread _id_130D(var_5);
      var_2._id_8C33 = 1;
    }
  }
}

_id_130C() {
  level.player endon("mars_killstreak_outro_black");
  level.player endon("set_aagun_targets");
  wait 1;

  for(;;) {
    self._id_ABF8.turret scripts\sp\utility::_id_9196(3, 1, 1, "mars_killstreak_targeting_outline");
    self._id_ABF8._id_129CC scripts\sp\utility::_id_9196(3, 1, 1, "mars_killstreak_targeting_outline");
    thread scripts\sp\utility::_id_918D("mars_killstreak_targeting_outline", ::_id_B38F);
    wait 0.35;
    thread scripts\sp\utility::_id_918D("mars_killstreak_targeting_outline", ::_id_B38F);
    wait 0.35;
    thread scripts\sp\utility::_id_918D("mars_killstreak_targeting_outline", ::_id_B38F);
    wait 0.35;
    self._id_ABF8.turret scripts\sp\utility::_id_9193("mars_killstreak_targeting_outline");
    self._id_ABF8._id_129CC scripts\sp\utility::_id_9193("mars_killstreak_targeting_outline");
    wait 5.0;
  }
}

_id_130D(var_0) {
  level.player scripts\engine\utility::waittill_any("mars_killstreak_outro_black", "set_aagun_targets");
  level.player playSound("mons_remote_targeting_hud_end_lr");
  level.player._id_914E stoploopsound();
  level.player clearclienttriggeraudiozone(2.0);
  _id_1331(var_0);
  self._id_ABF8.turret scripts\sp\utility::_id_9193("mars_killstreak_targeting_outline");
  self._id_ABF8._id_129CC scripts\sp\utility::_id_9193("mars_killstreak_targeting_outline");
  self._id_8C33 = 0;
}

_id_1321() {
  self endon("death");
  var_0 = getaiarray("allies");
  var_0 = scripts\engine\utility::array_add(var_0, level._id_6AF9);

  foreach(var_2 in var_0)
  var_2 thread _id_1320(0);

  var_4 = getaiarray("axis");

  foreach(var_2 in var_4) {
    if(!scripts\engine\utility::is_true(var_2._id_2708))
      var_2 thread _id_1320(1);
  }
}

_id_1320(var_0) {
  thread _id_131F();

  if(var_0)
    var_1 = 1;
  else
    var_1 = 0;

  var_2 = _id_1336(self, var_1);

  if(var_2 == -1) {
    return;
  }
  scripts\engine\utility::waittill_any("death", "mars_killstreak_outro_black");
  _id_1331(var_2);

  if(isDefined(self))
    self hudoutlinedisable();
}

_id_1336(var_0, var_1) {
  var_2 = -1;

  for(var_3 = 0; var_3 < 24; var_3++) {
    if(level._id_B3B8[var_3] == 0) {
      var_2 = var_3;
      level._id_B3B8[var_3] = 1;
      break;
    }
  }

  if(var_2 != -1) {
    setomnvar("ui_reticles_" + var_2 + "_target_ent", var_0);
    setomnvar("ui_reticles_" + var_2 + "_lock_state", var_1);

    if(var_1 == 1) {
      if(isDefined(var_0.unittype) && var_0.unittype == "c8")
        var_0 hudoutlineenable(1, 1, 1);
    } else if(var_1 == 0) {
      if(isDefined(level._id_6AF9) && var_0 == level._id_6AF9)
        var_0 hudoutlineenable(2, 0, 1);
    }
  }

  return var_2;
}

_id_1331(var_0) {
  level._id_B3B8[var_0] = 0;
  setomnvar("ui_reticles_" + var_0 + "_target_ent", undefined);
  setomnvar("ui_reticles_" + var_0 + "_lock_state", 0);
}

_id_131F() {
  level.player waittill("mars_killstreak_outro_black");
  self notify("mars_killstreak_outro_black");
}

_id_1315() {
  scripts\sp\utility::_id_9199("mars_killstreak_targeting_outline", 1);
  var_0 = 0;
  var_1 = scripts\sp\utility::_id_10639("reticle", level._id_B3B1._id_E320.origin, level._id_B3B1._id_E320.angles);
  var_1 dontcastshadows();
  var_1 linkTo(level._id_B3B1._id_E320);
  var_1 scripts\sp\utility::_id_9196(0, 0, 1, "mars_killstreak_targeting_outline");
  var_2 = scripts\sp\utility::_id_10639("reticle_bg", level._id_B3B1._id_E320.origin - (0, 0, 4), level._id_B3B1._id_E320.angles);
  var_2 dontcastshadows();
  var_2 linkTo(level._id_B3B1._id_E320);
  var_2 scripts\sp\utility::_id_9196(5, 0, 1, "mars_killstreak_targeting_outline");

  if(var_0) {
    var_3 = scripts\sp\utility::_id_10639("reticle_outer", level._id_B3B1._id_E320.origin, level._id_B3B1._id_E320.angles);
    var_3 dontcastshadows();
    var_3 linkTo(level._id_B3B1._id_E323);
    var_3 scripts\sp\utility::_id_9196(0, 0, 1, "mars_killstreak_targeting_outline");
    level._id_B3B1._id_E31F = [var_1, var_2, var_3];
  } else
    level._id_B3B1._id_E31F = [var_1, var_2];

  if(var_0)
    thread _id_1332();
}

_id_1316() {
  var_0 = 0;
  var_1 = scripts\sp\utility::_id_10639("reticle_arrow2", level._id_B3B1._id_E320.origin, level._id_B3B1._id_E320.angles);
  var_1 dontcastshadows();
  var_1 linkTo(level._id_B3B1._id_E320);
  var_1 scripts\sp\utility::_id_9196(0, 0, 1, "mars_killstreak_targeting_outline");

  if(var_0) {
    var_2 = scripts\sp\utility::_id_10639("reticle_outer", level._id_B3B1._id_E320.origin, level._id_B3B1._id_E320.angles);
    var_2 dontcastshadows();
    var_2 linkTo(level._id_B3B1._id_E323);
    var_2 scripts\sp\utility::_id_9196(0, 0, 1, "mars_killstreak_targeting_outline");
    level._id_B3B1._id_E31F = [var_1, var_2];
  } else
    level._id_B3B1._id_E31F = [var_1];

  if(var_0)
    thread _id_1332();
}

_id_1332() {
  level.player endon("mars_killstreak_reticle_deleted");
  level.player endon("death");

  for(;;) {
    var_0 = 0.1;
    var_1 = -60 * var_0;
    level._id_B3B1._id_E323 rotateby((0, var_1, 0), var_0);
    wait(var_0);
  }
}

_id_1322() {
  foreach(var_1 in level._id_B3B1._id_E31F)
  var_1 hide();
}

_id_1337() {
  foreach(var_1 in level._id_B3B1._id_E31F)
  var_1 show();
}

_id_1314(var_0, var_1) {
  _id_1335(1);
  level._id_B3B1._id_5B1B = [];
  level._id_B3B1._id_5B1A = [];
  level._id_B3B1._id_5B1C = [];

  for(var_2 = 1; var_2 < 4; var_2++) {
    var_3 = scripts\sp\utility::_id_10639("reticle2", var_0, level._id_B3B1._id_E320.angles);
    level._id_B3B1._id_5B1B[var_2] = var_3;
    var_3 dontcastshadows();
    var_3 scripts\sp\utility::_id_9196(0, 0, 1, "mars_killstreak_targeting_outline");
  }

  level._id_B3B1._id_5B1C[0] = scripts\sp\utility::_id_10639("reticle", var_0, level._id_B3B1._id_E320.angles);
  level._id_B3B1._id_5B1C[0] dontcastshadows();
  level._id_B3B1._id_5B1C[0] scripts\sp\utility::_id_9196(0, 0, 1, "mars_killstreak_targeting_outline");
  level._id_B3B1._id_5B1C[1] = scripts\sp\utility::_id_10639("reticle_bg", var_0 - (0, 0, 4), level._id_B3B1._id_E320.angles);
  level._id_B3B1._id_5B1C[1] dontcastshadows();
  level._id_B3B1._id_5B1C[1] scripts\sp\utility::_id_9196(5, 0, 1, "mars_killstreak_targeting_outline");
  _id_133F(var_0, var_1);
}

_id_133F(var_0, var_1) {
  var_2 = vectorNormalize(var_1 - var_0);
  var_3 = distance2d(var_1, var_0) / 4;
  var_4 = [var_0];
  var_5 = var_0;

  for(var_6 = 1; var_6 < 5; var_6++) {
    var_7 = var_5 + var_2 * var_3;
    var_4[var_4.size] = var_7;
    var_5 = var_7;
  }

  var_8 = clamp(floor((var_3 - 50) / 50), 0, 3);
  var_9 = var_3 / (var_8 + 1);
  var_10 = [];

  for(var_6 = 0; var_6 < var_4.size; var_6++) {
    if(var_6 == var_4.size - 1) {
      break;
    }

    var_5 = var_4[var_6];

    for(var_11 = 0; var_11 < var_8; var_11++) {
      var_7 = var_5 + var_2 * var_9;
      var_10[var_10.size] = var_7;
      var_5 = var_7;
    }
  }

  var_12 = var_8 * (var_4.size - 1);

  if(var_12 > level._id_B3B1._id_5B1A.size) {
    for(var_6 = 0; var_6 < var_12; var_6++) {
      if(!isDefined(level._id_B3B1._id_5B1A[var_6])) {
        var_13 = scripts\sp\utility::_id_10639("reticle_line_dot", var_0, (0, 0, 0));
        level._id_B3B1._id_5B1A[var_6] = var_13;
        var_13 dontcastshadows();
        var_13 scripts\sp\utility::_id_9196(5, 0, 1, "mars_killstreak_targeting_outline");
      }
    }

    foreach(var_15 in level._id_B3B1._id_5B1A)
    var_15 dontinterpolate();
  } else if(var_12 < level._id_B3B1._id_5B1A.size) {
    var_17 = var_12;
    var_18 = level._id_B3B1._id_5B1A.size - 1;

    for(var_6 = var_18; var_6 >= var_17; var_6--) {
      level._id_B3B1._id_5B1A[var_6] scripts\sp\utility::_id_9193("mars_killstreak_targeting_outline");
      level._id_B3B1._id_5B1A[var_6] delete();
      level._id_B3B1._id_5B1A[var_6] = undefined;
    }

    foreach(var_15 in level._id_B3B1._id_5B1A)
    var_15 dontinterpolate();
  }

  var_21 = scripts\engine\utility::flat_angle(vectortoangles(var_2));

  for(var_6 = 1; var_6 < var_4.size - 1; var_6++) {
    level._id_B3B1._id_5B1B[var_6].origin = var_4[var_6];
    level._id_B3B1._id_5B1B[var_6].angles = var_21;
  }

  foreach(var_6, var_23 in var_10) {
    level._id_B3B1._id_5B1A[var_6].origin = var_23;
    level._id_B3B1._id_5B1A[var_6].angles = var_21;
  }

  foreach(var_15 in level._id_B3B1._id_5B1C) {
    var_15.origin = var_1;
    var_15.angles = var_21;
  }
}

_id_1324() {
  if(!isDefined(level._id_B3B1._id_5B19))
    level._id_B3B1._id_5B19 = 0;

  return level._id_B3B1._id_5B19;
}

_id_1335(var_0) {
  level._id_B3B1._id_5B19 = var_0;
}

_id_1318() {
  if(!isDefined(level._id_B3B1._id_5B1B)) {
    return;
  }
  _id_1335(0);

  foreach(var_1 in level._id_B3B1._id_5B1B) {
    var_1 scripts\sp\utility::_id_9193("mars_killstreak_targeting_outline");
    var_1 delete();
  }

  level._id_B3B1._id_5B1B = undefined;

  foreach(var_1 in level._id_B3B1._id_5B1A) {
    var_1 scripts\sp\utility::_id_9193("mars_killstreak_targeting_outline");
    var_1 delete();
  }

  level._id_B3B1._id_5B1A = undefined;

  if(isDefined(level._id_B3B1._id_5B1C))
    scripts\sp\utility::_id_228A(level._id_B3B1._id_5B1C);

  level._id_B3B1._id_5B1C = undefined;
  level.player notify("mars_killstreak_dragline_reticle_deleted");
}

_id_1317(var_0) {
  var_1 = scripts\sp\utility::_id_10639("reticle", level._id_B3B1._id_E320.origin, level._id_B3B1._id_E320.angles);
  var_2 = scripts\sp\utility::_id_10639("reticle_bg", level._id_B3B1._id_E320.origin - (0, 0, 4), level._id_B3B1._id_E320.angles);
  level._id_B3B1._id_10E4D = [var_1, var_2];
  level._id_B3B1._id_10E4D[0] dontcastshadows();
  level._id_B3B1._id_10E4D[0] scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");
  level._id_B3B1._id_10E4D[1] dontcastshadows();
  level._id_B3B1._id_10E4D[1] scripts\sp\utility::_id_9196(4, 0, 1, "mars_killstreak_targeting_outline");
}

_id_1333() {
  foreach(var_1 in level._id_B3B1._id_E31F)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  wait 0.15;

  foreach(var_1 in level._id_B3B1._id_E31F)
  var_1 scripts\sp\utility::_id_9196(0, 0, 1, "mars_killstreak_targeting_outline");

  wait 0.15;
  level.player notify("mars_killstreak_reticle_animation_done");
}

_id_1319() {
  if(!isDefined(level._id_B3B1._id_E31F)) {
    return;
  }
  foreach(var_1 in level._id_B3B1._id_E31F) {
    var_1 scripts\sp\utility::_id_9193("mars_killstreak_targeting_outline");
    var_1 delete();
  }

  level._id_B3B1._id_E31F = undefined;
  level.player notify("mars_killstreak_reticle_deleted");
}

_id_131A() {
  if(!isDefined(level._id_B3B1._id_10E4D)) {
    return;
  }
  foreach(var_1 in level._id_B3B1._id_10E4D) {
    var_1 scripts\sp\utility::_id_9193("mars_killstreak_targeting_outline");
    var_1 delete();
  }

  level._id_B3B1._id_10E4D = undefined;
  level.player notify("mars_killstreak_reticle_deleted");
}

_id_1340() {
  _id_132F();
  wait 0.5;
  level._id_B3B1 = spawnStruct();
  setomnvar("ui_mars_remote_missile_state", 1);
  wait 0.7;
  level notify("dronestrike_enter");
  visionsetnaked("marsbase_killstreak_vision", 0);
  level.player thread scripts\engine\utility::play_loop_sound_on_entity("ambient_mars_killstreak_drone_int");
  level.player thread scripts\engine\utility::play_loop_sound_on_entity("ambient_mars_killstreak_drone_int1");
  level.player thread scripts\engine\utility::play_loop_sound_on_entity("ambient_mars_killstreak_drone_int1_sur");
  level.player notifyonplayercommand("fire_press", "+attack");
  level.player notifyonplayercommand("fire_press", "+attack_akimbo_accessible");
  level.player notifyonplayercommand("back_press", "+stance");
  level.player notifyonplayercommand("back_press", "+weapnext");
  level.player notifyonplayercommand("back_press", "+gostand");
  level.player notifyonplayercommand("back_press", "+prone");
  level.player notifyonplayercommand("back_press", "+togglecrouch");
  level.player notifyonplayercommand("back_press", "toggleprone");
  level._id_B3B1._id_E320 = scripts\engine\utility::spawn_tag_origin();
  level._id_B3B1._id_E323 = scripts\engine\utility::spawn_tag_origin();
  level._id_B3B1._id_E322 = level._id_B3B1._id_E320.origin;
  level._id_B3B1._id_E321 = scripts\engine\utility::spawn_tag_origin();
  level._id_B3B1.state = "target1";
  level._id_B3B1._id_C1A2 = 0;
  level._id_B3B1._id_C6DF = level._id_B3B6[level._id_B3B5]._id_C6DF;
  level._id_B3B1._id_C6D8 = level._id_B3B6[level._id_B3B5]._id_C6D8;
  level._id_B3B1._id_C6DE = level._id_B3B6[level._id_B3B5]._id_C6DE;
  level._id_B3B1._id_C6DA = level._id_B3B6[level._id_B3B5]._id_C6DA;
  level._id_B3B1._id_C6DD = level._id_B3B6[level._id_B3B5]._id_C6DD;
  level._id_B3B1._id_C6DC = level._id_B3B6[level._id_B3B5]._id_C6DC;
  level._id_B3B1._id_2F06 = level._id_B3B6[level._id_B3B5]._id_2F06;
  level._id_B3B1._id_C6D9 = scripts\engine\utility::spawn_tag_origin();
  level._id_B3B1._id_C6D9.origin = level._id_B3B1._id_C6DF.origin;
  var_0 = randomfloatrange(level._id_B3B1._id_C6DD, level._id_B3B1._id_C6DC);
  level._id_B3B1._id_C6D9.angles = (level._id_B3B1._id_C6DE, var_0, 0);
  level._id_B3B1._id_C6DB = level._id_B3B1._id_C6D9 scripts\engine\utility::spawn_tag_origin();
  level._id_B3B1._id_C6DB.origin = level._id_B3B1._id_C6DB.origin + anglesToForward(level._id_B3B1._id_C6DB.angles) * (0 - level._id_B3B1._id_C6D8);
  level._id_B3B1._id_C6DB linkTo(level._id_B3B1._id_C6D9);
  _id_1342();
  scripts\sp\utility::_id_9199("mars_killstreak_targeting_outline", 1);
  wait 0.15;
  level.player thread _id_1310();

  if(scripts\engine\utility::flag("mars_killstreak_offline")) {
    wait 2;
    level.player notify("back_press");
    return;
  }

  thread _id_131B();
  level.player thread _id_133C();
  level.player thread _id_1343();
  level.player thread _id_133A();

  if(!scripts\engine\utility::flag("show_tutorial") && level.player usinggamepad()) {
    scripts\engine\utility::flag_set("show_tutorial");
    scripts\sp\utility::_id_56BE("hint_use_left_stick", 3.0);
  }
}

_id_133A() {
  self endon("death");
  self endon("mars_killstreak_done");
  self endon("mars_killstreak_back");
  level._id_B3B1.state = "target1";
  level._id_B3B1.target = undefined;
  _id_1315();
  _id_1322();
  scripts\engine\utility::delaythread(0.05, ::_id_1337);
  thread _id_1344();
  wait 0.2;
  self waittill("fire_press");
  thread _id_133B();
}

_id_133B() {
  self endon("death");
  self endon("mars_killstreak_done");
  self endon("mars_killstreak_back");
  level._id_B3B1.state = "target2";
  setomnvar("ui_mars_remote_missile_state", 2);
  self playSound("mars_killstreak_choose_target");
  thread _id_1333();
  level._id_B3B1.target = level._id_B3B1._id_E320.origin;
  level._id_B3B1._id_1157C = level._id_B3B1._id_E322;
  _id_1317(level._id_B3B1.target);
  _id_1314(level._id_B3B1.target, level._id_B3B1._id_E320.origin);
  _id_1319();
  _id_1316();
  thread _id_132A();
  wait 0.6;
  self waittill("fire_press");
  thread _id_1339();
}

_id_1339() {
  self endon("death");
  self endon("mars_killstreak_done");
  level._id_B3B1.state = "outro";
  self playSound("mars_killstreak_finalize_target");
  self notify("mars_killstreak_stop_pan");
  level._id_B3B1._id_114F3 = _id_1341(level._id_B3B1._id_E320.origin);
  self notify("mars_killstreak_fire");

  if(level.player scripts\engine\utility::is_player_gamepad_enabled())
    _id_1345(1.0, 40.0);
  else
    _id_1345(1.0, 55.0);

  foreach(var_1 in level._id_B3B1._id_E31F)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  foreach(var_1 in level._id_B3B1._id_5B1B)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  if(isDefined(level._id_B3B1._id_5B1C)) {
    level._id_B3B1._id_5B1C[0] scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");
    level._id_B3B1._id_5B1C[1] scripts\sp\utility::_id_9196(4, 0, 1, "mars_killstreak_targeting_outline");
  }

  thread _id_1326(level._id_B3B1.target, level._id_B3B1._id_114F3);
  setomnvar("ui_mars_remote_missile_state", 3);
  _id_1338();
  thread _id_133E();
  level notify("dronestrike_exit");
}

_id_1310() {
  self endon("death");
  self endon("mars_killstreak_fire");
  self endon("mars_killstreak_done");
  self endon("stop_back_think");

  for(;;) {
    self waittill("back_press");

    if(level._id_B3B1.state == "target1") {
      self notify("mars_killstreak_back");
      setomnvar("ui_mars_remote_missile_state", 5);
      thread _id_133E();
      self notify("stop_back_think");
      continue;
    }

    if(level._id_B3B1.state == "target2") {
      self notify("mars_killstreak_back");
      self notify("mars_killstreak_stop_pan");
      _id_131A();
      _id_1319();
      _id_1318();
      setomnvar("ui_mars_remote_missile_state", 4);
      thread _id_133A();
    }
  }
}

_id_133E() {
  self endon("death");
  wait 0.25;
  level.player notify("mars_killstreak_outro_black");
  _id_1330();
  thread _id_1347();
  _id_131A();
  _id_1319();
  _id_1318();
  visionsetnaked("", 0);
  level.player scripts\engine\utility::stop_loop_sound_on_entity("ambient_mars_killstreak_drone_int");
  level.player scripts\engine\utility::stop_loop_sound_on_entity("ambient_mars_killstreak_drone_int1");
  level.player scripts\engine\utility::stop_loop_sound_on_entity("ambient_mars_killstreak_drone_int1_sur");
  wait 0.25;
  level.player switchtoweapon(level.player.lastweapon);
  wait 0.6;
  _id_1312();
}

_id_1312() {
  level.player notify("mars_killstreak_done");
  level._id_B3B1 = undefined;
  setomnvar("ui_mars_remote_missile_state", 0);
  scripts\sp\utility::_id_9199("mars_killstreak_targeting_outline", 0);
}

_id_131C() {
  foreach(var_1 in level._id_B3B1._id_E31F)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  foreach(var_1 in level._id_B3B1._id_5B1B)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  wait 0.2;

  foreach(var_1 in level._id_B3B1._id_E31F)
  var_1 scripts\sp\utility::_id_9196(4, 0, 1, "mars_killstreak_targeting_outline");

  foreach(var_1 in level._id_B3B1._id_5B1B)
  var_1 scripts\sp\utility::_id_9196(4, 0, 1, "mars_killstreak_targeting_outline");

  foreach(var_1 in level._id_B3B1._id_10E4D)
  var_1 scripts\sp\utility::_id_9196(4, 0, 1, "mars_killstreak_targeting_outline");

  wait 0.2;

  foreach(var_1 in level._id_B3B1._id_E31F)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  foreach(var_1 in level._id_B3B1._id_5B1B)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  foreach(var_1 in level._id_B3B1._id_10E4D)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  wait 0.2;

  foreach(var_1 in level._id_B3B1._id_E31F)
  var_1 scripts\sp\utility::_id_9196(4, 0, 1, "mars_killstreak_targeting_outline");

  foreach(var_1 in level._id_B3B1._id_5B1B)
  var_1 scripts\sp\utility::_id_9196(4, 0, 1, "mars_killstreak_targeting_outline");

  foreach(var_1 in level._id_B3B1._id_10E4D)
  var_1 scripts\sp\utility::_id_9196(4, 0, 1, "mars_killstreak_targeting_outline");

  wait 0.2;

  foreach(var_1 in level._id_B3B1._id_E31F)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  foreach(var_1 in level._id_B3B1._id_5B1B)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  foreach(var_1 in level._id_B3B1._id_10E4D)
  var_1 scripts\sp\utility::_id_9196(1, 0, 1, "mars_killstreak_targeting_outline");

  wait 0.1;
  _id_131A();
  _id_1319();

  for(var_29 = 0; var_29 < 5; var_29++) {
    level.player waittill("mars_killstreak_missiles_land");
    level._id_B3B1._id_5B1B[var_29] scripts\sp\utility::_id_9193();
    level._id_B3B1._id_5B1B[var_29] delete();
  }

  if(isDefined(level._id_B3B1._id_5B1C))
    scripts\sp\utility::_id_228A(level._id_B3B1._id_5B1C);

  _id_1335(0);
}

_id_132F() {
  level.player scripts\engine\utility::allow_usability(0);
  level.player scripts\engine\utility::allow_weapon_switch(0);
  level.player scripts\engine\utility::allow_jump(0);
  level.player allowdoublejump(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  setDvar("player_death_animated", 0);
}

_id_1330() {
  level.player scripts\engine\utility::allow_usability(1);
  level.player scripts\engine\utility::allow_weapon_switch(1);
  level.player scripts\engine\utility::allow_jump(1);
  level.player allowdoublejump(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  setDvar("player_death_animated", 1);
}

_id_1342() {
  level._id_B3B1.ogorigin = level.player.origin;
  level._id_B3B1._id_C3A0 = level.player.angles;
  level._id_B3B1._id_C3A3 = level.player getstance();
  level._id_B3B1._id_C3A1 = getdvarint("cg_fov");
  level.player _meth_823B(level._id_B3B1._id_C6DB);
  scripts\engine\utility::delaythread(0.05, ::_id_1346);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player _meth_818A();
  level.player _meth_80D8(0.5, 0.5);
  level.player _meth_84FE();
  level.player _meth_81DE(level._id_B3B1._id_C6DA, 0.05);
  level.player scripts\sp\utility::_id_F416(1);
}

_id_1346() {
  if(isalive(level.player)) {
    level.player playerlinktodelta(level._id_B3B1._id_C6DB, "tag_origin", 1, 0, 0, 0, 0, 1);

    if(level.player islinked())
      level.player _meth_8392(0.05, 5, 5);
  }
}

_id_1347() {
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player unlink();
  level.player setOrigin(level._id_B3B1.ogorigin, 1);
  level.player setplayerangles(level._id_B3B1._id_C3A0);
  level.player setstance(level._id_B3B1._id_C3A3);
  level.player showviewmodel();
  level.player _meth_80A6();
  level.player _meth_84FD();
  level.player _meth_81DE(level._id_B3B1._id_C3A1, 0.05);
  level.player scripts\sp\utility::_id_F416(0);
}

_id_1343() {
  level.player endon("death");
  level.player endon("mars_killstreak_done");
  var_0 = 8;
  var_1 = 1;
  var_2 = 1.0;
  var_3 = 2.0;

  for(;;) {
    var_4 = level._id_B3B1._id_C6D9.angles;
    var_5 = var_4[1];
    var_6 = undefined;

    if(var_1) {
      if(var_5 - var_0 <= level._id_B3B1._id_C6DD) {
        var_7 = level._id_B3B1._id_C6DD;
        var_8 = var_5 - var_7;
        var_6 = var_8 / var_2 + var_3;
        level._id_B3B1._id_C6D9 rotateTo((var_4[0], var_7, var_4[2]), var_6, 0.0, var_3);
        var_1 = 0;
      } else if(var_5 + var_0 >= level._id_B3B1._id_C6DC) {
        var_7 = level._id_B3B1._id_C6DD + var_0;
        var_8 = var_5 - var_7;
        var_6 = var_8 / var_2 + var_3;
        level._id_B3B1._id_C6D9 rotateTo((var_4[0], var_7, var_4[2]), var_6, var_3, 0.0);
      } else {
        var_7 = level._id_B3B1._id_C6DD + var_0;
        var_8 = var_5 - var_7;
        var_6 = var_8 / var_2;
        level._id_B3B1._id_C6D9 rotateTo((var_4[0], var_7, var_4[2]), var_6, 0.0, 0.0);
      }
    } else if(var_5 + var_0 >= level._id_B3B1._id_C6DC) {
      var_7 = level._id_B3B1._id_C6DC;
      var_8 = var_7 - var_5;
      var_6 = var_8 / var_2 + var_3;
      level._id_B3B1._id_C6D9 rotateTo((var_4[0], var_7, var_4[2]), var_6, 0.0, var_3);
      var_1 = 1;
    } else if(var_5 - var_0 <= level._id_B3B1._id_C6DD) {
      var_7 = level._id_B3B1._id_C6DC - var_0;
      var_8 = var_7 - var_5;
      var_6 = var_8 / var_2 + var_3;
      level._id_B3B1._id_C6D9 rotateTo((var_4[0], var_7, var_4[2]), var_6, var_3, 0.0);
    } else {
      var_7 = level._id_B3B1._id_C6DC - var_0;
      var_8 = var_7 - var_5;
      var_6 = var_8 / var_2;
      level._id_B3B1._id_C6D9 rotateTo((var_4[0], var_7, var_4[2]), var_6, 0.0, 0.0);
    }

    wait(var_6);
  }
}

_id_1345(var_0, var_1) {
  level._id_B3B1._id_B7C5 = var_0;
  level._id_B3B1._id_B4B7 = var_1;
}

_id_1344() {
  self endon("death");
  self endon("mars_killstreak_stop_pan");
  self endon("mars_killstreak_done");
  level._id_B3B1._id_E321.origin = level._id_B3B1._id_C6D9.origin;
  _id_1345(2, 80);
  _id_1348();
  level._id_B3B1._id_C89B = [];
  var_0 = 0;
  var_1 = 0;
  var_2 = (0, 0, 0);
  var_3 = 0;
  var_4 = (1, 0, 0);
  var_5 = 0;

  for(;;) {
    wait 0.05;
    var_1 = 0;

    if(level.player scripts\engine\utility::is_player_gamepad_enabled()) {
      var_6 = 0;
      var_7 = 80;
      var_8 = 0.2;
      var_9 = 20;
    } else {
      var_6 = 1;
      var_7 = 110;
      var_8 = 0.0;
      var_9 = 30;
    }

    level.player _meth_80D5(var_6);
    _id_1345(2, var_7);
    var_10 = [];
    var_11[0] = level.player getnormalizedmovement();
    var_11[1] = level.player _meth_814B();

    if(!var_6 && scripts\engine\utility::is_true(self _meth_8139("invertedPitch")))
      var_11[1] = (-1 * var_11[1][0], var_11[1][1], var_11[1][2]);

    var_12 = max(length(var_11[0]), length(var_11[1]));
    var_10 = (var_11[0] + var_11[1]) * 0.5;
    var_10 = vectorNormalize(var_10) * var_12;
    var_13 = self getplayerangles(1);
    var_14 = anglesToForward(var_13);
    var_15 = anglestoright(var_13);
    var_16 = 0;
    var_17 = 0;
    var_18 = 0;

    if(!scripts\engine\utility::is_true(var_6))
      var_19 = (var_10[0], 0 - var_10[1], 0);
    else
      var_19 = (var_10[0], var_10[1], 0) * 0.8;

    var_20 = vectorNormalize(var_19);
    var_21 = (distance(var_19, (0, 0, 0)) - var_8) / (1 - var_8);

    if(var_21 < 0)
      var_21 = 0.0;

    if(var_21 > 0.9)
      var_21 = 1.0;

    var_22 = vectortoangles(var_20);

    if(var_21 == 0)
      var_22 = (0, 0, 0);

    var_23 = var_22 + var_13;
    var_24 = level._id_B3B1._id_B4B7 - level._id_B3B1._id_B7C5;
    var_25 = var_21 * var_24 + level._id_B3B1._id_B7C5;

    if(var_21 == 0)
      var_25 = 0;

    var_4 = var_2;
    var_5 = var_3;
    var_2 = anglesToForward(var_23);

    if(vectordot(var_4, var_2) < 0 && !scripts\engine\utility::is_true(var_6)) {
      var_5 = 0;
      level._id_B3B1._id_E321.origin = level._id_B3B1._id_E322;
    }

    var_3 = var_25;

    if(var_25 > var_5)
      var_3 = clamp(var_25, 0, var_5 + var_9);

    var_26 = _id_1311(level._id_B3B1._id_E321.origin + var_2 * var_3);

    if(_id_1324()) {
      if(distance2d(var_26, level._id_B3B1._id_1157C) > 1500) {
        var_27 = vectorNormalize(scripts\engine\utility::flatten_vector(var_26 - level._id_B3B1._id_1157C));
        var_26 = level._id_B3B1._id_1157C + var_27 * 1500;
        var_1 = 1;
      }
    }

    var_28 = var_26;

    if(level._id_B3B1._id_E321.origin != var_28) {
      var_29 = var_28 - level._id_B3B1._id_E321.origin;
      _id_132D(var_29);
      level._id_B3B1._id_E321.origin = var_28;
      level._id_B3B1._id_A9C0 = var_29;
      _id_1348(1, var_29);
      var_0 = 1;
    } else if(level._id_B3B1._id_C1A2) {
      var_30 = distance2d(level._id_B3B1._id_E321.origin, level._id_B3B1._id_1157C);

      if(var_30 <= level._id_B3B1._id_C1A4) {
        if(var_30 == 0)
          var_27 = level._id_B3B1._id_C1A3;
        else
          var_27 = vectorNormalize(level._id_B3B1._id_E321.origin - level._id_B3B1._id_1157C);

        var_31 = var_28 + var_27 * level._id_B3B1._id_C1A5;
        var_29 = var_31 - level._id_B3B1._id_E321.origin;
        _id_132D(var_29);
        level._id_B3B1._id_E321.origin = var_31;
        level._id_B3B1._id_A9C0 = var_29;
        _id_1348(1, var_29);
      }
    } else {
      var_0 = 0;
      level._id_B3B1._id_E321.origin = level._id_B3B1._id_E322;
    }

    var_32 = distance2d(level._id_B3B1._id_E321.origin, level._id_B3B1._id_C6D9.origin);

    if(var_32 > 130) {
      var_27 = vectorNormalize(level._id_B3B1._id_E321.origin - level._id_B3B1._id_C6D9.origin);
      var_33 = clamp((var_32 - 130) / 270, 0.0, 1.0);
      var_34 = var_33 * level._id_B3B1._id_B4B7;
      level._id_B3B1._id_C6D9.origin = level._id_B3B1._id_C6D9.origin + var_27 * var_34;
    }
  }
}

_id_132A() {
  var_0 = self getplayerangles(1);

  if(isDefined(level._id_B3B1._id_A9C0))
    level._id_B3B1._id_C1A3 = vectorNormalize(scripts\engine\utility::flatten_vector(level._id_B3B1._id_A9C0));
  else
    level._id_B3B1._id_C1A3 = anglestoright(var_0);

  level._id_B3B1._id_C1A4 = 270;
  level._id_B3B1._id_C1A5 = 66.6667;
  var_1 = _id_1311(level._id_B3B1._id_E321.origin + level._id_B3B1._id_C1A3 * level._id_B3B1._id_C1A4);
  level._id_B3B1._id_C1A2 = 1;
  wait 1.0;

  if(isDefined(level._id_B3B1))
    level._id_B3B1._id_C1A2 = 0;
}

_id_1311(var_0) {
  var_1 = var_0;

  if(ispointinvolume(var_1, level._id_B3B3[level._id_B3B1._id_2F06].volume))
    return var_1;
  else {
    var_2 = [];

    for(var_3 = 0; var_3 < level._id_B3B3[level._id_B3B1._id_2F06]._id_132A8.size; var_3++) {
      var_4 = level._id_B3B3[level._id_B3B1._id_2F06]._id_132A8[var_3].origin;

      if(var_3 == level._id_B3B3[level._id_B3B1._id_2F06]._id_132A8.size - 1)
        var_5 = level._id_B3B3[level._id_B3B1._id_2F06]._id_132A8[0].origin;
      else
        var_5 = level._id_B3B3[level._id_B3B1._id_2F06]._id_132A8[var_3 + 1].origin;

      var_2[var_2.size] = pointonsegmentnearesttopoint(var_4, var_5, var_1);
    }

    var_6 = undefined;
    var_7 = undefined;

    foreach(var_9 in var_2) {
      var_10 = distance2d(var_9, var_1);

      if(!isDefined(var_6) || var_10 < var_6) {
        var_6 = var_10;
        var_7 = var_9;
      }
    }

    var_12 = (var_7[0], var_7[1], var_1[2]);
    return var_12;
  }
}

_id_132D(var_0) {
  for(var_1 = level._id_B3B1._id_C89B.size; var_1 > 0; var_1--) {
    if(var_1 >= 1) {
      continue;
    }
    level._id_B3B1._id_C89B[var_1] = level._id_B3B1._id_C89B[var_1 - 1];
  }

  level._id_B3B1._id_C89B[0] = var_0;
}

_id_132C() {
  var_0 = (0, 0, 0);
  var_1 = 0;

  foreach(var_3 in level._id_B3B1._id_C89B) {
    var_0 = var_0 + vectorNormalize(var_3);
    var_1 = var_1 + distance(var_3, (0, 0, 0));
  }

  var_0 = var_0 / level._id_B3B1._id_C89B.size;
  var_1 = var_1 / level._id_B3B1._id_C89B.size;
  return var_0 * var_1;
}

_id_1325(var_0, var_1) {
  var_2 = var_0 + var_1 * 880 / 2 * -1.0;
  var_3 = [var_2];
  var_4 = var_2;

  for(var_5 = 1; var_5 < 5; var_5++) {
    var_6 = var_4 + var_1 * 220;
    var_3[var_3.size] = var_6;
    var_4 = var_6;
  }

  foreach(var_5, var_8 in var_3) {
    var_9 = scripts\common\trace::ray_trace(var_8 + (0, 0, 2000), var_8 + (0, 0, -1000), undefined);
    var_3[var_5] = var_9["position"];
  }

  var_10 = scripts\engine\utility::getStruct("mars_killstreak_launch_pos", "targetname");
  playworldsound("mars_killstreak_missile_launch", var_10.origin);
  wait 0.3;
  level.player playSound("mars_killstreak_missile_incoming");
  wait 3.3;

  foreach(var_8 in var_3) {
    playworldsound("mars_killstreak_missile_incoming_swt", var_8);
    playFX(scripts\engine\utility::getfx("mars_killstreak_missile_streak"), var_8, (-1, 0, 0), (0, 0, 1));
    playFX(scripts\engine\utility::getfx("mars_killstreak_missile_expl"), var_8, anglesToForward((0, randomfloat(360), 0)), (0, 0, 1));
    playworldsound("expl_mars_killstreak_missile", var_8);
    scripts\sp\utility::_id_5FC7(level.player.origin);
    radiusdamage(var_8, 450, 400, 50, level.player);
    wait 0.25;
  }
}

_id_1326(var_0, var_1) {
  scripts\engine\utility::flag_set("mars_killstreak_missiles_in_progress");
  var_2 = var_0;
  var_3 = vectorNormalize(var_1 - var_0);
  var_4 = distance2d(var_1, var_0) / 4;
  var_5 = [var_2];
  var_6 = var_2;

  for(var_7 = 1; var_7 < 5; var_7++) {
    var_8 = var_6 + var_3 * var_4;
    var_5[var_5.size] = var_8;
    var_6 = var_8;
  }

  foreach(var_7, var_10 in var_5) {
    var_11 = scripts\common\trace::ray_trace(var_10 + (0, 0, 2000), var_10 + (0, 0, -1000), undefined);
    var_5[var_7] = var_11["position"];

    foreach(var_13 in level._id_B3B2) {
      if(var_13.dead == 0 && var_13._id_11554 == 1 && distance(var_13.origin, var_10) < 450)
        level notify(var_13.targetname + "_targeted");
    }
  }

  var_15 = scripts\engine\utility::getStruct("mars_killstreak_launch_pos", "targetname");
  playworldsound("mars_killstreak_missile_launch", var_15.origin);
  playworldsound("mars_killstreak_missile_incoming", var_5[0]);
  wait 3.3;

  foreach(var_10 in var_5) {
    playworldsound("mars_killstreak_missile_incoming_swt", var_10);
    _id_1327(var_10);
    level.player notify("mars_killstreak_missiles_land");
    wait 0.25;
  }

  level.player notify("mars_killstreak_missiles_done");
  scripts\engine\utility::flag_clear("mars_killstreak_missiles_in_progress");
}

_id_1327(var_0) {
  playFX(scripts\engine\utility::getfx("mars_killstreak_missile_streak"), var_0, (-1, 0, 0), (0, 0, 1));
  playFX(scripts\engine\utility::getfx("mars_killstreak_missile_expl"), var_0, anglesToForward((0, randomfloat(360), 0)), (0, 0, 1));
  playworldsound("expl_mars_killstreak_missile", var_0);
  scripts\sp\utility::_id_5FC7(level.player.origin);
  var_1 = scripts\sp\utility::_id_77FF(var_0, getaiarray(), 450, 1);

  foreach(var_3 in var_1) {
    if(var_3.team == "allies") {
      if(!scripts\engine\utility::is_true(level._id_2705)) {
        var_3 thread _id_E1ED(var_3._id_BFED);
        var_3._id_BFED = undefined;
        var_3 dodamage(400, var_0, level.player, level.player);
      }

      continue;
    }

    var_3 thread _id_6F2A(var_0, 0.5);
  }

  var_5 = scripts\sp\utility::_id_81FF();

  foreach(var_7 in var_5) {
    if(distance(var_7.origin, var_0) < 450 && !scripts\engine\utility::is_true(var_7._id_270C))
      var_7 thread _id_1328(400, var_0, level.player, level.player, "MOD_EXPLOSIVE");
  }

  foreach(var_10 in level._id_B3B2) {
    if(var_10.dead == 0 && var_10._id_11554 == 1 && distance(var_10.origin, var_0) < 450) {
      level notify(var_10.targetname + "_targeted");
      level notify("aagun_destroyed", var_10.targetname);
      scripts\engine\utility::flag_set(var_10.targetname + "_destroyed");
      var_10.dead = 1;
    }
  }

  if(distance2d(level.player.origin, var_0) < 450)
    level.player dodamage(level.player.health + 10000, var_0, level.player, level.player, "MOD_EXPLOSIVE");

  foreach(var_13 in level._id_CAF7) {
    if(distance(var_13.origin, var_0) < 450)
      var_13 thread _id_1328(400, var_0, level.player, undefined, "MOD_EXPLOSIVE");
  }
}

_id_1328(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self._id_9395)) {
    return;
  }
  self._id_9395 = 1;
  wait(randomfloat(1.0));
  self dodamage(var_0, var_1, var_2, var_3, var_4);
}

_id_6F2A(var_0, var_1) {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  if(isDefined(self._id_9395)) {
    return;
  }
  self._id_9395 = 1;

  if(isDefined(var_1))
    wait(randomfloat(var_1));

  if(!self _meth_81B7()) {
    self._id_DC1A = 1;
    self._id_DC1D = (randomintrange(-5, 5), randomintrange(-5, 5), 150);
    self._id_DC14 = "right_leg_lower";
  }

  wait(randomfloatrange(0, 0.15));
  self dodamage(400, var_0, level.player, level.player, "MOD_EXPLOSIVE");
}

_id_E1ED(var_0) {
  scripts\engine\utility::waitframe();

  if(isalive(self))
    self._id_BFED = var_0;
}

#using_animtree("generic_human");

_id_131B() {
  var_0 = getEnt("mars_killstreak_fake_player_spawn", "targetname");
  var_0.origin = level._id_B3B1.ogorigin;
  var_0.angles = level._id_B3B1._id_C3A0;
  level._id_6AF9 = var_0 spawndrone();
  var_1 = level.player getmovingplatformparent();

  if(isDefined(var_1))
    level._id_6AF9 linkTo(var_1);

  level._id_6AF9 _meth_83D0(#animtree);
  level._id_6AF9 makeentitysentient("allies");
  level._id_6AF9._id_1FBB = "fake_player";
  level._id_6AF9 setCanDamage(1);
  level._id_6AF9.health = 999;
  level._id_6AF9 thread _id_132E();
  level._id_6AF9 thread scripts\sp\anim::_id_1EEA(level._id_6AF9, "use_device_idle", "stop_loop");
  level.player waittill("mars_killstreak_outro_black");
  level._id_6AF9 hudoutlinedisable();
  level._id_6AF9 hide();
  level.player waittill("mars_killstreak_done");
  level._id_6AF9 _meth_83A1();
  level._id_6AF9 _meth_81D0();
  wait 0.05;
  level._id_6AF9 delete();
}

_id_132E() {
  self endon("death");
  level.player endon("mars_killstreak_done");
  var_0 = 0;
  thread _id_130F();

  for(;;) {
    self waittill("damage", var_1);

    if(!level.player _meth_8525()) {
      var_0 = var_0 + var_1;

      if(var_0 > 100) {
        level.player notify("back_press");
        wait 0.5;
        level.player notify("back_press");
      }
    }
  }
}

_id_130F() {
  self endon("death");
  level.player endon("mars_killstreak_done");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    if(var_1 == 0)
      wait 5;
    else if(var_1 == 1)
      wait(randomfloatrange(1, 3));
    else if(var_1 > 1)
      wait 0.5;

    var_0 = 0;
    var_2 = getaiarray("axis");

    foreach(var_4 in var_2) {
      if(isalive(var_4) && var_4 cansee(self)) {
        var_0 = var_0 + 10;
        self dodamage(var_0, var_4.origin, var_4, var_4);
        level.player thread scripts\sp\maps\marsbase\marsbase_util::_id_C862(0.5, 1);
        wait 0.5;
      }
    }

    var_1++;
  }
}

_id_1338() {
  setomnvar("ui_jackal_cooldown_done", 0);
  level._id_B3B4 = 0.0;
  level.player setweaponammostock("mars_killstreak", 0);
  level._id_B3B7 = 0;
  thread _id_1313();
}

_id_1313(var_0) {
  level.player endon("death");
  level.player endon("reset_killstreak_cooldown");
  level.player endon("take_mars_killstreak");

  if(isDefined(var_0))
    var_1 = 0.05 / var_0;
  else
    var_1 = 0.000416667;

  while(level._id_B3B4 < 1.0) {
    level._id_B3B4 = level._id_B3B4 + var_1;
    setomnvar("ui_jackal_meter", level._id_B3B4);
    wait 0.05;
  }

  level._id_B3B4 = 1.0;
  _id_131D();
}

_id_131D(var_0) {
  while(scripts\engine\utility::flag("gator_death_start"))
    wait 0.1;

  setomnvar("ui_jackal_cooldown_done", 1);
  setomnvar("ui_jackal_meter", 1.0);
  level.player setweaponammostock("mars_killstreak", 1);
  level._id_B3B7 = 1;
  level.player playSound("marsbase_missile_ready_ui");
  thread _id_1323(var_0);
}

_id_1323(var_0) {
  level.player endon("death");
  level.player endon("take_mars_killstreak");
  level._id_A68E = 0;

  while(scripts\engine\utility::is_true(level._id_B3B7) && scripts\engine\utility::is_true(level.player._id_2711)) {
    var_1 = 0;

    while(_id_0E29::_id_87A7() != "none") {
      level._id_A68E = 0;
      var_1 = 1;
      wait 0.25;
    }

    if(var_1)
      wait 3.0;

    if(isDefined(var_0) && var_0) {
      if(!level._id_A68E) {
        level._id_A68E = 1;
        scripts\sp\utility::_id_56BA("hint_use_monsweapon");
      }

      wait 0.05;
      continue;
    }

    while(isDefined(level._id_8569) && level._id_8569 scripts\sp\utility::_id_65DB("player_at_door") && !scripts\engine\utility::flag("flag_greenhouse_exit_end"))
      wait 1.0;

    scripts\sp\utility::_id_56BE("hint_use_monsweapon", 3);
    wait 15;
  }
}

_id_B391(var_0) {
  level.player notify("reset_killstreak_cooldown");
  level._id_B3B4 = 0.0;
  level._id_B3B7 = 0;
  thread _id_1313(var_0);
}

_id_B393(var_0, var_1) {
  self notify("end_mars_killstreak_text");

  if(!isDefined(var_1))
    var_1 = 3;

  var_2 = newhudelem();
  var_2.alignx = "left";
  var_2.location = 0;
  var_2.foreground = 1;
  var_2.fontscale = 2;
  var_2.sort = 20;
  var_2.color = (1, 1, 1);
  var_2.x = 315;
  var_2.y = 200;
  var_2.alignx = "center";
  var_2.aligny = "middle";
  var_2.horzalign = "fullscreen";
  var_2.vertalign = "fullscreen";
  var_2 settext(var_0);
  scripts\engine\utility::waittill_notify_or_timeout("end_mars_killstreak_text", var_1);
  var_2 destroy();
}

#using_animtree("script_model");

_id_1334() {
  level._id_EC87["reticle"] = #animtree;
  level._id_EC8C["reticle"] = "vfx_remote_missile_reticle_04";
  level._id_EC87["reticle_bg"] = #animtree;
  level._id_EC8C["reticle_bg"] = "vfx_remote_missile_reticle_04_bg";
  level._id_EC87["reticle_outer"] = #animtree;
  level._id_EC8C["reticle_outer"] = "vfx_remote_missile_reticle_01_outer";
  level._id_EC87["reticle2"] = #animtree;
  level._id_EC8C["reticle2"] = "vfx_remote_missile_reticle_03";
  level._id_EC87["reticle_arrow2"] = #animtree;
  level._id_EC8C["reticle_arrow2"] = "vfx_remote_missile_reticle_06";
  level._id_EC87["reticle_line_dot"] = #animtree;
  level._id_EC8C["reticle_line_dot"] = "vfx_remote_missile_reticle_05";
}

#using_animtree("generic_human");

_id_131E() {
  level._id_EC85["fake_player"]["use_device_idle"][0] = % shipcrib_crouch_point_idle_01;
}