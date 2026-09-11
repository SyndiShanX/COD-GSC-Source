/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gxp_safe_zones.gsc
******************************************************/

function init() {
  if(!getdvarint("scr_br_safe_zones_enabled", 0)) {
    return;
  }

  tank_x1();
  level.ref_12e76 = spawnStruct();
  level.ref_12e76.ref_1472a = [];
  level.ref_12e76.zones = [];
  level.ref_12e76.ref_12e62 = [];
  thread ref_11ff3();
}

function ref_11ff3() {
  level waittill("prematch_done");
  wait 5;
  ref_135c5();
  thread ref_12e78();
}

function truckdoorleft(var0) {
  if(level.disable_super_in_turret.ref_12e6b != 1) {
    return 0;
  }

  if(!isDefined(level.ref_12e76)) {
    return 0;
  }

  if(!isarray(level.ref_12e76.zones)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level.ref_12e76.ref_12e62, var0);
}

function put_players_out_of_black_screen() {
  switch (level.mapname) {
    case "mp_br_mechanics":
      return &ref_131fb;
    case "mp_don4_pm":
    case "mp_don4":
      return &ref_131fc;
  }

  return undefined;
}

function badpathnodes(var0, var1, var2, var3, var4) {
  var3 = ref_140c6(var3);

  if(!var3) {
    return;
  }

  var5 = spawnStruct();
  var5.origin = var0;
  var5.angles = var1;
  var5.radius = var3;
  var5.height = var4;
  var6 = level.ref_12e76.ref_1472a.size;
  var5.id = "safe_zone_" + var2;
  level.ref_12e76.ref_1472a[var6] = var5;
}

function ref_131fb() {
  badpathnodes((-250, -4000, 0), (0, 0, 0), 0, 400, 512);
  badpathnodes((-1500, -4000, 0), (0, 180, 0), 1, 800, 256);
  badpathnodes((-3350, -4000, 0), (0, 210, 0), 2, 1000, 128);
}

function ref_131fc() {
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

function ref_135c5() {
  var0 = put_players_out_of_black_screen();

  if(isDefined(var0)) {
    level thread[[var0]]();
  }

  foreach(var2 in level.ref_12e76.ref_1472a) {
    var3 = ref_135c4(var2.origin, var2.angles, var2.radius, var2.height);
    var3.id = var2.id;
    level.ref_12e76.zones[level.ref_12e76.zones.size] = var3;
  }
}

function tank_x1() {
  level.disable_super_in_turret.ref_12e6d = [400, 500, 600, 700, 750, 800, 900, 1000];
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

function register_module_pause_unpause_funcs(var0, var1) {
  var2 = "gxp_safe_zone_" + var0;

  if(isDefined(var1)) {
    var2 = var2 + "_" + var1;
  }

  return var2;
}

function ref_140c6(var0) {
  if(!scripts\engine\utility::array_contains(level.disable_super_in_turret.ref_12e6d, var0)) {
    var1 = 0;
    var2 = var0;

    foreach(var4 in level.disable_super_in_turret.ref_12e6d) {
      var5 = abs(var0 - var4);

      if(var5 < var2) {
        var2 = var5;
        var1 = var4;
      }
    }

    return var1;
  }

  return var6;
}

function dangercircletick(var0, var1) {
  if(level.disable_super_in_turret.ref_12e6b != 1) {
    return;
  }

  if(level.disable_super_in_turret.ref_12e69 != 1) {
    return;
  }

  if(!isDefined(level.ref_12e76.zones)) {
    return;
  }

  foreach(var3 in level.ref_12e76.zones) {
    if(!isDefined(var3)) {
      continue;
    }

    var4 = var1 - var3.radius + level.disable_super_in_turret.ref_12e6a;
    var5 = var4 * var4;

    if(isDefined(var3) && distance2dsquared(var3.origin, var0) >= var5) {
      lb_impulse_dmg_threshold_mid(var3);
    }
  }
}

function ref_135c4(var0, var1, var2, var3) {
  var4 = spawn("trigger_radius", var0, 0, var2, var3);
  var4.angles = var1;
  var4.radius = var2;
  var4.height = var3;
  var4.health = level.disable_super_in_turret.ref_12e73;
  var5 = register_module_pause_unpause_funcs(var2);
  var4.ref_14725 = spawnfx(scripts\engine\utility::getfx(var5), var0, (1, 0, 0), (0, 0, 1));
  triggerfx(var4.ref_14725);
  var6 = (0, 0, 50);
  var7 = scripts\engine\trace::ray_trace(var0 + var6, var0 - var6);
  var4.cleanupexplosionleftovers = spawn("script_model", var7["position"]);
  var4.cleanupexplosionleftovers setModel("p9_ver_soldier_gear");
  var4.cleanupexplosionleftovers.angles = (var7["normal"][0], var1[1], var7["normal"][2]);
  var4.objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);
  scripts\mp\objidpoolmanager::objective_add_objective(var4.objid, "active", var0);
  getbnetigrbattlepassxpmultiplier(var4.objid, 4500, 5000);
  objective_setbackground(var4.objid, 1);
  objective_icon(var4.objid, "ui_mp_br_mapmenu_legend_sacredground_gxp");
  function_0421(var4.objid, 1);
  scripts\mp\utility\trigger::makeenterexittrigger(var4, &ref_1254c, &ref_12554);

  if(level.disable_super_in_turret.scavengerlootcacheused) {
    thread ref_11ce0();
  }

  return var4;
}

function ref_11ce0() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var0);

    if(var0 scripts\mp\gametypes\br_public::ref_125ec()) {
      ref_13ada(var0);
      sat_play_unfolding_sounds(var0);

      if(self.health <= 0) {
        lb_impulse_dmg_threshold_mid();
      }
    }
  }
}

function sat_play_unfolding_sounds(var0) {
  var1 = gettime();

  if(isDefined(self.ref_11e83) && self.ref_11e83 > var1) {
    return;
  }

  var0 dodamage(level.disable_super_in_turret.ref_12e6e, self.origin, var0);
  self.health -= level.disable_super_in_turret.ref_12e70;
  self.ref_11e83 = gettime() + level.disable_super_in_turret.ref_12e6f * 1000;
  var2 = undefined;

  if(self.health <= level.disable_super_in_turret.ref_12e73 * level.disable_super_in_turret.ref_12e75) {
    var2 = "yellow";
  }

  if(self.health <= level.disable_super_in_turret.ref_12e73 * level.disable_super_in_turret.ref_12e74) {
    var2 = "orange";
  }

  if(isDefined(var2)) {
    if(!isDefined(self.is_station_track_available) || isDefined(self.is_station_track_available) && self.is_station_track_available != var2) {
      if(var2 == "yellow") {
        playsoundatpos(self.origin, "br_gov_safespace_transition_low");
      } else if(var2 == "orange") {
        playsoundatpos(self.origin, "br_gov_safespace_transition_med");
      }

      if(isDefined(self.ref_14725)) {
        self.ref_14725 delete();
        self.ref_14725 = undefined;
      }

      self.is_station_track_available = var2;
      var3 = register_module_pause_unpause_funcs(self.radius, var2);
      self.ref_14725 = spawnfx(scripts\engine\utility::getfx(var3), self.origin, (1, 0, 0), (0, 0, 1));
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

  var0 = getarraykeys(self.triggerenterents);

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = var0[var1];
    var3 = self.triggerenterents[var2];
    ref_12554(var3, self);
  }

  var4 = register_module_pause_unpause_funcs(self.radius, "destroy");
  playFX(scripts\engine\utility::getfx(var4), self.origin, (1, 0, 0), (0, 0, 1));
  playsoundatpos(self.origin, "br_gov_safespace_exp");
  self delete();
}

function ref_13ada(var0) {
  if(level.disable_super_in_turret.scavengerlootcacheused) {
    playsoundatpos(var0.origin, "br_gov_safespace_dmg");
    var1 = var0.origin - self.origin;
    var2 = self.radius + 400 - length2d(var1);
    var1 = vectorNormalize((var1[0], var1[1], 0));
    var3 = var1 * var2;
    var4 = var0 getEye();
    var5 = var4 + var3;
    var6 = var5;
    var7 = var0 scripts\mp\gametypes\br_gametype_gxp_ghost::chase_hvt_vo(var5, var4, var1, undefined, undefined, 1);

    if(isDefined(var7)) {
      var8 = getrandomextractunlockablelootid(var7);

      if(!var8) {
        var7 = undefined;
      }
    }

    if(isDefined(var7)) {
      return;
    }

    var9 = 45;
    var10 = 1;
    var11 = vectortoangles(var1);

    for(var12 = 1; !isDefined(var7) && var12 <= level.disable_super_in_turret.ref_12e68; var12++) {
      var11 = (var11[0], var11[1] + var9 * var10, 0);
      var13 = anglesToForward(var11);
      var5 = var4 + var13 * var2;
      var7 = var0 scripts\mp\gametypes\br_gametype_gxp_ghost::chase_hvt_vo(var5, var4, var13, undefined, undefined, 1);

      if(isDefined(var7)) {
        var8 = getrandomextractunlockablelootid(var7);

        if(!var8) {
          var7 = undefined;
        }
      }

      var9 += 45;
      var10 *= -1;
    }

    if(isDefined(var7)) {
      return;
    }

    var12 = 1;
    var3 = (0, 0, 1000);
    var4 = var0 getEye();

    while(!isDefined(var7) && var12 < level.disable_super_in_turret.ref_12e68) {
      var5 += var3;
      var1 = vectorNormalize(var5 - var4);
      var7 = var0 scripts\mp\gametypes\br_gametype_gxp_ghost::chase_hvt_vo(var5, var4, var1, undefined, undefined, 1);
      var12++;
    }

    return;
  }
}

function getrandomextractunlockablelootid(var0) {
  var1 = 40;
  var2 = length2dsquared(var0 - self.origin);
  var3 = (self.radius + var1) * (self.radius + var1);
  return var2 > var3;
}

function ref_1254c(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  if(!var0 scripts\mp\gametypes\br_public::ref_125ec()) {
    level.ref_12e76.ref_12e62 = scripts\engine\utility::array_add(level.ref_12e76.ref_12e62, var0);
    var0 visionsetnakedforplayer("mp_gxp_safespace", 0.2);
    playfxontagforclients(scripts\engine\utility::getfx("gxp_safe_zone_player_eye"), var0, "tag_eye", var0);
    var0.setcheckliststateforteam = isDefined(level.disable_super_in_turret.ref_12e72) && level.disable_super_in_turret.ref_12e72 <= 0;
    scripts\mp\gametypes\br_gametype_gxp_challenges::ref_11fee(var0, var1);
    var0 playsoundtoplayer("br_gov_safespace_enter", var0);

    if(isDefined(var0.ref_12e66)) {
      var0.ref_12e66 stoploopsound();
      var0.ref_12e66 delete();
    }

    var0.ref_12e66 = spawn("script_origin", self.origin);
    var0.ref_12e66 linkTo(var0);
    var0.ref_12e66 hide();
    var0.ref_12e66 showtoplayer(var0);
    var0.ref_12e66 playLoopSound("br_gov_safespace_lp");
    return;
  }

  var2 = gettime();

  if(!isDefined(var0.ref_12e71) || var0.ref_12e71 < var2) {
    var3 = getdvarint("scr_br_safe_zones_ghost_vo_min", 45);
    var4 = getdvarint("scr_br_safe_zones_ghost_vo_max", 60);
    var5 = var3 * 1000;
    var6 = var4 * 1000;
    scripts\mp\gametypes\br_public::dmztut_endgamewithreward("safe_zone_ghost_vo", var0);
    var0.ref_12e71 = var2 + randomintrange(var5, var6);
    return;
  }
}

function ref_12555(var0) {
  stopfxontagforclients(scripts\engine\utility::getfx("gxp_safe_zone_player_eye"), var0, "tag_eye", var0);
  wait 0.5;

  if(isDefined(var0)) {
    stopfxontagforclients(scripts\engine\utility::getfx("gxp_safe_zone_player_eye"), var0, "tag_eye", var0);
    return;
  }
}

function ref_12554(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  if(!var0 scripts\mp\gametypes\br_public::ref_125ec() || isDefined(var0.ref_12e66)) {
    var0 visionsetnakedforplayer("", 0.2);
    thread ref_12555(var0);
    var0.setcheckliststateforteam = 0;
    level.ref_12e76.ref_12e62 = scripts\engine\utility::array_remove(level.ref_12e76.ref_12e62, var0);
    var0 playsoundtoplayer("br_gov_safespace_exit", var0);

    if(isDefined(var0.ref_12e66)) {
      var0.ref_12e66 stoploopsound();
      var0.ref_12e66 delete();
      var0.ref_12e66 = undefined;
      return;
    }

    return;
  }
}

function ref_12e78() {
  level endon("game_ended");
  var0 = getdvarint("scr_br_safe_zones_human_vo_min", 45);
  var1 = getdvarint("scr_br_safe_zones_human_vo_max", 60);
  var2 = var0 * 1000;
  var3 = var1 * 1000;

  for(;;) {
    var4 = gettime();
    var5 = [];

    foreach(var7 in level.ref_12e76.ref_12e62) {
      if(!isDefined(var7)) {
        continue;
      }

      if(!isalive(var7)) {
        continue;
      }

      if(var7 scripts\mp\gametypes\br_public::ref_125ec()) {
        continue;
      }

      if(!isDefined(var7.ref_12e79) || var7.ref_12e79 < var4) {
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward("safe_zone_human_vo", var7);
        var7.ref_12e79 = var4 + randomintrange(var2, var3);
      }

      var5 = var7;
    }

    level.ref_12e76.ref_12e62 = var5;
    waitframe();
  }
}