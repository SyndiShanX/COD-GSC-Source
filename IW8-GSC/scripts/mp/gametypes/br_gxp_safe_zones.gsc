/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gxp_safe_zones.gsc
******************************************************/

function init() {
  if(!getdvarint("scr_br_safe_zones_enabled", 0)) {
    return;
  }

  tank_x1();
  level.ref_12E76 = spawnStruct();
  level.ref_12E76.ref_1472A = [];
  level.ref_12E76.zones = [];
  level.ref_12E76.ref_12E62 = [];
  thread ref_11FF3();
}

function ref_11FF3() {
  level waittill("prematch_done");
  wait 5;
  ref_135C5();
  thread ref_12E78();
}

function truckdoorleft(var_0) {
  if(level.disable_super_in_turret.ref_12E6B != 1) {
    return 0;
  }

  if(!isDefined(level.ref_12E76)) {
    return 0;
  }

  if(!isarray(level.ref_12E76.zones)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level.ref_12E76.ref_12E62, var_0);
}

function put_players_out_of_black_screen() {
  switch (level.mapname) {
    case "mp_br_mechanics":
      return &ref_131FB;
    case "mp_don4_pm":
    case "mp_don4":
      return &ref_131FC;
  }

  return undefined;
}

function badpathnodes(var_0, var_1, var_2, var_3, var_4) {
  var_3 = ref_140C6(var_3);

  if(!var_3) {
    return;
  }

  var_5 = spawnStruct();
  var_5.origin = var_0;
  var_5.angles = var_1;
  var_5.radius = var_3;
  var_5.height = var_4;
  var_6 = level.ref_12E76.ref_1472A.size;
  var_5.id = "safe_zone_" + var_2;
  level.ref_12E76.ref_1472A[var_6] = var_5;
}

function ref_131FB() {
  badpathnodes((-250, -4000, 0), (0, 0, 0), 0, 400, 512);
  badpathnodes((-1500, -4000, 0), (0, 180, 0), 1, 800, 256);
  badpathnodes((-3350, -4000, 0), (0, 210, 0), 2, 1000, 128);
}

function ref_131FC() {
  badpathnodes((38394, -26884, -564), (0, 0, 0), 0, 600, 128);
  badpathnodes((22180, -32193, -440), (0, 0, 0), 1, 600, 128);
  badpathnodes((27591, 8805, -475), (0, 0, 0), 2, 400, 200);
  badpathnodes((27915, 37519, 714), (0, 0, 0), 3, 700, 250);
  badpathnodes((4470, 49274, 1036), (0, 0, 0), 4, 700, 128);
  badpathnodes((6754, 17467, -681), (0, 0, 0), 6, 600, 350);
  badpathnodes((30407, -8705, -412), (0, 0, 0), 7, 800, 400);
  badpathnodes((-20524, 22013, -448), (0, 0, 0), 8, 800, 600);
  badpathnodes((-26038, -10377, -38), (0, 0, 0), 11, 800, 250);
  badpathnodes((-7972, -11756, 348), (0, 0, 0), 12, 800, 150);
  badpathnodes((-20746, -28231, -145), (0, 0, 0), 13, 700, 300);
  badpathnodes((9247, -23349, -224), (0, 0, 0), 14, 700, 250);
  badpathnodes((50830, 3161, 31), (0, 0, 0), 15, 700, 128);
  badpathnodes((51432, -17940, -392), (0, 0, 0), 16, 400, 128);
  badpathnodes((-4093, -30507, 318), (0, 0, 0), 17, 1000, 128);
  badpathnodes((-20758, 7765, -226), (0, 0, 0), 18, 600, 250);
}

function ref_135C5() {
  var_0 = put_players_out_of_black_screen();

  if(isDefined(var_0)) {
    level thread[[var_0]]();
  }

  foreach(var_2 in level.ref_12E76.ref_1472A) {
    var_3 = ref_135C4(var_2.origin, var_2.angles, var_2.radius, var_2.height);
    var_3.id = var_2.id;
    level.ref_12E76.zones[level.ref_12E76.zones.size] = var_3;
  }
}

function tank_x1() {
  level.disable_super_in_turret.ref_12E6D = [400, 500, 600, 700, 750, 800, 900, 1000];
  level._effect["gxp_safe_zone_400"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_1000");
  level._effect["gxp_safe_zone_400_destroy"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1000_destroy");
  level._effect["gxp_safe_zone_400_orange"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1000_orange");
  level._effect["gxp_safe_zone_400_yellow"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1000_yellow");
  level._effect["gxp_safe_zone_500"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_1000");
  level._effect["gxp_safe_zone_500_destroy"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1000_destroy");
  level._effect["gxp_safe_zone_500_orange"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1000_orange");
  level._effect["gxp_safe_zone_500_yellow"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1000_yellow");
  level._effect["gxp_safe_zone_600"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_1200");
  level._effect["gxp_safe_zone_600_destroy"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1200_destroy");
  level._effect["gxp_safe_zone_600_orange"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1200_orange");
  level._effect["gxp_safe_zone_600_yellow"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1200_yellow");
  level._effect["gxp_safe_zone_700"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_1400");
  level._effect["gxp_safe_zone_700_destroy"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1400_destroy");
  level._effect["gxp_safe_zone_700_orange"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1400_orange");
  level._effect["gxp_safe_zone_700_yellow"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1400_yellow");
  level._effect["gxp_safe_zone_750"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_1500");
  level._effect["gxp_safe_zone_750_destroy"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_1500");
  level._effect["gxp_safe_zone_750_orange"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_1500");
  level._effect["gxp_safe_zone_750_yellow"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_1500");
  level._effect["gxp_safe_zone_800"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_1600");
  level._effect["gxp_safe_zone_800_destroy"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1600_destroy");
  level._effect["gxp_safe_zone_800_orange"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1600_orange");
  level._effect["gxp_safe_zone_800_yellow"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1600_yellow");
  level._effect["gxp_safe_zone_900"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_1800");
  level._effect["gxp_safe_zone_900_destroy"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1800_destroy");
  level._effect["gxp_safe_zone_900_orange"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1800_orange");
  level._effect["gxp_safe_zone_900_yellow"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_1800_yellow");
  level._effect["gxp_safe_zone_1000"] = loadfx("vfx/iw8_br/gameplay/vfx_safe_zone_verdansk_circle_2000");
  level._effect["gxp_safe_zone_1000_destroy"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_2000_destroy");
  level._effect["gxp_safe_zone_1000_orange"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_2000_orange");
  level._effect["gxp_safe_zone_1000_yellow"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_safe_zone_verdansk_circle_2000_yellow");
  level._effect["gxp_safe_zone_player_eye"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_safespace_01.vfx");
}

function register_module_pause_unpause_funcs(var_0, var_1) {
  var_2 = "gxp_safe_zone_" + var_0;

  if(isDefined(var_1)) {
    var_2 = var_2 + "_" + var_1;
  }

  return var_2;
}

function ref_140C6(var_0) {
  if(!scripts\engine\utility::array_contains(level.disable_super_in_turret.ref_12E6D, var_0)) {
    var_1 = 0;
    var_2 = var_0;

    foreach(var_4 in level.disable_super_in_turret.ref_12E6D) {
      var_5 = abs(var_0 - var_4);

      if(var_5 < var_2) {
        var_2 = var_5;
        var_1 = var_4;
      }
    }

    return var_1;
  }

  return var_6;
}

function dangercircletick(var_0, var_1) {
  if(level.disable_super_in_turret.ref_12E6B != 1) {
    return;
  }

  if(level.disable_super_in_turret.ref_12E69 != 1) {
    return;
  }

  if(!isDefined(level.ref_12E76.zones)) {
    return;
  }

  foreach(var_3 in level.ref_12E76.zones) {
    if(!isDefined(var_3)) {
      continue;
    }

    var_4 = var_1 - var_3.radius + level.disable_super_in_turret.ref_12E6A;
    var_5 = var_4 * var_4;

    if(isDefined(var_3) && distance2dsquared(var_3.origin, var_0) >= var_5) {
      lb_impulse_dmg_threshold_mid(var_3);
    }
  }
}

function ref_135C4(var_0, var_1, var_2, var_3) {
  var_4 = spawn("trigger_radius", var_0, 0, var_2, var_3);
  var_4.angles = var_1;
  var_4.radius = var_2;
  var_4.height = var_3;
  var_4.health = level.disable_super_in_turret.ref_12E73;
  var_5 = register_module_pause_unpause_funcs(var_2);
  var_4.ref_14725 = spawnfx(scripts\engine\utility::getfx(var_5), var_0, (1, 0, 0), (0, 0, 1));
  triggerfx(var_4.ref_14725);
  var_6 = (0, 0, 50);
  var_7 = scripts\engine\trace::ray_trace(var_0 + var_6, var_0 - var_6);
  var_4.cleanupexplosionleftovers = spawn("script_model", var_7["position"]);
  var_4.cleanupexplosionleftovers setModel("p9_ver_soldier_gear");
  var_4.cleanupexplosionleftovers.angles = (var_7["normal"][0], var_1[1], var_7["normal"][2]);
  var_4.objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  scripts\mp\objidpoolmanager::objective_add_objective(var_4.objid, "active", var_0);
  getbnetigrbattlepassxpmultiplier(var_4.objid, 4500, 5000);
  objective_setbackground(var_4.objid, 1);
  objective_icon(var_4.objid, "ui_mp_br_mapmenu_legend_sacredground_gxp");
  function_0421(var_4.objid, 1);
  scripts\mp\utility\trigger::makeenterexittrigger(var_4, &ref_1254C, &ref_12554);

  if(level.disable_super_in_turret.scavengerlootcacheused) {
    thread ref_11CE0();
  }

  return var_4;
}

function ref_11CE0() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 scripts\mp\gametypes\br_public::ref_125EC()) {
      ref_13ADA(var_0);
      sat_play_unfolding_sounds(var_0);

      if(self.health <= 0) {
        lb_impulse_dmg_threshold_mid();
      }
    }
  }
}

function sat_play_unfolding_sounds(var_0) {
  var_1 = gettime();

  if(isDefined(self.ref_11E83) && self.ref_11E83 > var_1) {
    return;
  }

  var_0 dodamage(level.disable_super_in_turret.ref_12E6E, self.origin, var_0);
  self.health -= level.disable_super_in_turret.ref_12E70;
  self.ref_11E83 = gettime() + level.disable_super_in_turret.ref_12E6F * 1000;
  var_2 = undefined;

  if(self.health <= level.disable_super_in_turret.ref_12E73 * level.disable_super_in_turret.ref_12E75) {
    var_2 = "yellow";
  }

  if(self.health <= level.disable_super_in_turret.ref_12E73 * level.disable_super_in_turret.ref_12E74) {
    var_2 = "orange";
  }

  if(isDefined(var_2)) {
    if(!isDefined(self.is_station_track_available) || isDefined(self.is_station_track_available) && self.is_station_track_available != var_2) {
      if(var_2 == "yellow") {
        playsoundatpos(self.origin, "br_gov_safespace_transition_low");
      } else if(var_2 == "orange") {
        playsoundatpos(self.origin, "br_gov_safespace_transition_med");
      }

      if(isDefined(self.ref_14725)) {
        self.ref_14725 delete();
        self.ref_14725 = undefined;
      }

      self.is_station_track_available = var_2;
      var_3 = register_module_pause_unpause_funcs(self.radius, var_2);
      self.ref_14725 = spawnfx(scripts\engine\utility::getfx(var_3), self.origin, (1, 0, 0), (0, 0, 1));
      triggerfx(self.ref_14725);
      return;
    }

    return;
  }
}

function lb_impulse_dmg_threshold_mid() {
  if(isDefined(self.ref_14725)) {
    self.ref_14725 delete();
    self.ref_14725 = undefined;
  }

  objective_delete(self.objid);

  if(isDefined(self.cleanupexplosionleftovers)) {
    self.cleanupexplosionleftovers delete();
  }

  var_0 = getarraykeys(self.triggerenterents);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    var_3 = self.triggerenterents[var_2];
    ref_12554(var_3, self);
  }

  var_4 = register_module_pause_unpause_funcs(self.radius, "destroy");
  playFX(scripts\engine\utility::getfx(var_4), self.origin, (1, 0, 0), (0, 0, 1));
  playsoundatpos(self.origin, "br_gov_safespace_exp");
  self delete();
}

function ref_13ADA(var_0) {
  if(level.disable_super_in_turret.scavengerlootcacheused) {
    playsoundatpos(var_0.origin, "br_gov_safespace_dmg");
    var_1 = var_0.origin - self.origin;
    var_2 = self.radius + 400 - length2d(var_1);
    var_1 = vectorNormalize((var_1[0], var_1[1], 0));
    var_3 = var_1 * var_2;
    var_4 = var_0 getEye();
    var_5 = var_4 + var_3;
    var_6 = var_5;
    var_7 = var_0 scripts\mp\gametypes\br_gametype_gxp_ghost::chase_hvt_vo(var_5, var_4, var_1, undefined, undefined, 1);

    if(isDefined(var_7)) {
      var_8 = getrandomextractunlockablelootid(var_7);

      if(!var_8) {
        var_7 = undefined;
      }
    }

    if(isDefined(var_7)) {
      return;
    }

    var_9 = 45;
    var_10 = 1;
    var_11 = vectortoangles(var_1);

    for(var_12 = 1; !isDefined(var_7) && var_12 <= level.disable_super_in_turret.ref_12E68; var_12++) {
      var_11 = (var_11[0], var_11[1] + var_9 * var_10, 0);
      var_13 = anglesToForward(var_11);
      var_5 = var_4 + var_13 * var_2;
      var_7 = var_0 scripts\mp\gametypes\br_gametype_gxp_ghost::chase_hvt_vo(var_5, var_4, var_13, undefined, undefined, 1);

      if(isDefined(var_7)) {
        var_8 = getrandomextractunlockablelootid(var_7);

        if(!var_8) {
          var_7 = undefined;
        }
      }

      var_9 += 45;
      var_10 *= -1;
    }

    if(isDefined(var_7)) {
      return;
    }

    var_12 = 1;
    var_3 = (0, 0, 1000);
    var_4 = var_0 getEye();

    while(!isDefined(var_7) && var_12 < level.disable_super_in_turret.ref_12E68) {
      var_5 += var_3;
      var_1 = vectorNormalize(var_5 - var_4);
      var_7 = var_0 scripts\mp\gametypes\br_gametype_gxp_ghost::chase_hvt_vo(var_5, var_4, var_1, undefined, undefined, 1);
      var_12++;
    }

    return;
  }
}

function getrandomextractunlockablelootid(var_0) {
  var_1 = 40;
  var_2 = length2dsquared(var_0 - self.origin);
  var_3 = (self.radius + var_1) * (self.radius + var_1);
  return var_2 > var_3;
}

function ref_1254C(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  if(!var_0 scripts\mp\gametypes\br_public::ref_125EC()) {
    level.ref_12E76.ref_12E62 = scripts\engine\utility::array_add(level.ref_12E76.ref_12E62, var_0);
    var_0 visionsetnakedforplayer("mp_gxp_safespace", 0.2);
    playfxontagforclients(scripts\engine\utility::getfx("gxp_safe_zone_player_eye"), var_0, "tag_eye", var_0);
    var_0.setcheckliststateforteam = isDefined(level.disable_super_in_turret.ref_12E72) && level.disable_super_in_turret.ref_12E72 <= 0;
    scripts\mp\gametypes\br_gametype_gxp_challenges::ref_11FEE(var_0, var_1);
    var_0 playsoundtoplayer("br_gov_safespace_enter", var_0);

    if(isDefined(var_0.ref_12E66)) {
      var_0.ref_12E66 stoploopsound();
      var_0.ref_12E66 delete();
    }

    var_0.ref_12E66 = spawn("script_origin", self.origin);
    var_0.ref_12E66 linkTo(var_0);
    var_0.ref_12E66 hide();
    var_0.ref_12E66 showtoplayer(var_0);
    var_0.ref_12E66 playLoopSound("br_gov_safespace_lp");
    return;
  }

  var_2 = gettime();

  if(!isDefined(var_0.ref_12E71) || var_0.ref_12E71 < var_2) {
    var_3 = getdvarint("scr_br_safe_zones_ghost_vo_min", 45);
    var_4 = getdvarint("scr_br_safe_zones_ghost_vo_max", 60);
    var_5 = var_3 * 1000;
    var_6 = var_4 * 1000;
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward("safe_zone_ghost_vo", var_0);
    var_0.ref_12E71 = var_2 + randomintrange(var_5, var_6);
    return;
  }
}

function ref_12555(var_0) {
  stopfxontagforclients(scripts\engine\utility::getfx("gxp_safe_zone_player_eye"), var_0, "tag_eye", var_0);
  wait 0.5;

  if(isDefined(var_0)) {
    stopfxontagforclients(scripts\engine\utility::getfx("gxp_safe_zone_player_eye"), var_0, "tag_eye", var_0);
    return;
  }
}

function ref_12554(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  if(!var_0 scripts\mp\gametypes\br_public::ref_125EC() || isDefined(var_0.ref_12E66)) {
    var_0 visionsetnakedforplayer("", 0.2);
    thread ref_12555(var_0);
    var_0.setcheckliststateforteam = 0;
    level.ref_12E76.ref_12E62 = scripts\engine\utility::array_remove(level.ref_12E76.ref_12E62, var_0);
    var_0 playsoundtoplayer("br_gov_safespace_exit", var_0);

    if(isDefined(var_0.ref_12E66)) {
      var_0.ref_12E66 stoploopsound();
      var_0.ref_12E66 delete();
      var_0.ref_12E66 = undefined;
      return;
    }

    return;
  }
}

function ref_12E78() {
  level endon("game_ended");
  var_0 = getdvarint("scr_br_safe_zones_human_vo_min", 45);
  var_1 = getdvarint("scr_br_safe_zones_human_vo_max", 60);
  var_2 = var_0 * 1000;
  var_3 = var_1 * 1000;

  for(;;) {
    var_4 = gettime();
    var_5 = [];

    foreach(var_7 in level.ref_12E76.ref_12E62) {
      if(!isDefined(var_7)) {
        continue;
      }

      if(!isalive(var_7)) {
        continue;
      }

      if(var_7 scripts\mp\gametypes\br_public::ref_125EC()) {
        continue;
      }

      if(!isDefined(var_7.ref_12E79) || var_7.ref_12E79 < var_4) {
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward("safe_zone_human_vo", var_7);
        var_7.ref_12E79 = var_4 + randomintrange(var_2, var_3);
      }

      var_5 = var_7;
    }

    level.ref_12E76.ref_12E62 = var_5;
    waitframe();
  }
}