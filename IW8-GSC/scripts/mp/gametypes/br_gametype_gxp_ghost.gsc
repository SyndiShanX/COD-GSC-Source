/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_gxp_ghost.gsc
**********************************************************/

function setchecklistsubversion() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_zxp");
}

function ref_11b16() {
  return false;
}

function ref_11b80(var0, var1) {
  var2 = ref_126d1(var0, var1);

  if(scripts\mp\flags::gameflag("prematch_done") && !var2) {
    scripts\mp\gametypes\br::ref_11b15(var0);
  }

  return !var2;
}

function init_relic_nuketimer() {
  var0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function ref_12bba(var0) {
  if(!isDefined(level.teamdata[var0]["aliveCountHuman"])) {
    return level.teamdata[var0]["aliveCount"];
  }

  return level.teamdata[var0]["aliveCountHuman"];
}

function ref_12536() {
  self endon("disconnect");
  self setscriptablepartstate("ghost", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);

  if(level.disable_super_in_turret.score_accuracy_think) {
    ref_125da();

    if(!level.disable_super_in_turret.score_event_accuracy) {
      self setscriptablepartstate("headVFX", "neutral");
    }

    self visionsetnakedforplayer("", 0);
  }

  if(!getdvarint("scr_br_gxp_disable_ghost_death_loadout_fix", 0)) {
    scripts\mp\class::loadout_emptycacheofloadout("gamemode");
    self.pers["gamemodeLoadout"] = level.br_respawn_loadout;
    self.pers["class"] = "gamemode";
    self.class = "gamemode";
  }

  waittillframeend();
  ref_1267e(0, 1);
  ref_1262b(0);
}

function ref_1262b(var0) {
  scripts\mp\gametypes\br_public::ref_125cf(var0);

  if(var0) {
    if(level.disable_super_in_turret.spawndistancemax) {
      self.spawnboardroom_juggdrop.alpha = 1;
      self.spawnboardroom_loadoutdrop.alpha = 1;
      self.spawn_wheelson_redroom.alpha = 1;
    }

    self disableweaponpickup();
    return;
  }

  ref_12589();
  self enableweaponpickup();
}

function ref_12589() {
  if(isDefined(self.spawnboardroom_juggdrop)) {
    thread kioskfiresaledoneforplayer(self.spawnboardroom_juggdrop, 1.5);
  }

  if(isDefined(self.spawnboardroom_loadoutdrop)) {
    thread kioskfiresaledoneforplayer(self.spawnboardroom_loadoutdrop, 1.5);
  }

  if(isDefined(self.spawn_wheelson_redroom)) {
    self.spawn_wheelson_redroom destroy();
  }

  self.spawnboardroom_juggdrop = undefined;
  self.spawnboardroom_loadoutdrop = undefined;
  self.spawn_wheelson_redroom = undefined;
}

function kioskfiresaledoneforplayer(var0, var1) {
  wait var1;

  if(isDefined(var0)) {
    var0 destroy();
    return;
  }
}

function ref_125da() {
  foreach(var1 in level.players) {
    if(!var1 scripts\mp\gametypes\br_public::ref_125ec()) {
      var1 hudoutlinedisableforclient(self);
    }
  }
}

function ref_12645() {
  self notify("spawnGhost");
  self method_87aa("ghost");
  self setclothtype("cloth");
  scripts\mp\deathicons::spawn_carriables_from_prefabs_all(self);
}

function ref_1269b(var0) {
  return scripts\mp\gametypes\br_public::ref_125ec();
}

function ref_1269c(var0) {
  return scripts\mp\gametypes\br_public::ref_125ec();
}

function ref_126d1(var0) {
  if(!istrue(var0)) {
    if(scripts\mp\gametypes\br_public::ref_125ec()) {
      thread ref_12536();
      return false;
    }
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done") || level.gameended || !level.disable_super_in_turret.scale_off_bravo_audio) {
    return false;
  }

  thread ref_125a9(0);
  return true;
}

function ref_125a9(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("ghost_unset");

  if(level.gameended) {
    return;
  }

  if(!isDefined(level.teamdata[self.team]["lastGhostTime"]) && !isDefined(level.ref_12d05)) {}

  ref_131cc(self.team);
  ref_1267c(1);
  ref_125ae(1);
  waittillframeend();

  if(isDefined(self.body)) {
    self.body delete();
  }

  ref_1267e(1);
  scripts\mp\gametypes\br_gxp_phones::loadout_updateglobalclassgamemode(self);
  self.ref_12ca8 = 1;

  if(isDefined(level.ref_12d05)) {
    ref_12645();
  } else if(var0) {
    ref_126ee();
  } else {
    ref_12645();
  }

  jumpiffalse(scripts\mp\gametypes\br_gametypes::tutorial_showtext("playerGetGhostSpawnLocation")) LOC_000000db;
  var1 = scripts\mp\gametypes\br_gametypes::ref_12e05("playerGetGhostSpawnLocation");
  var2 = var1[0];
  var3 = var1[1];
  var1 = undefined;
  goto LOC_000000f3;
}

function ref_125b4() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  var0 = 0.5;

  for(;;) {
    var1 = self getnodeoffset_code(7);
    var2 = sortbydistance(level.disable_super_in_turret.ref_12cb0, self.origin);
    var3 = 0;

    foreach(var5 in var2) {
      var6 = undefined;

      if(var3 < level.disable_super_in_turret.ref_11b76 && level.disable_super_in_turret.ref_11b75 > 0) {
        var6 = distance2dsquared(self.origin, var5.origin);
      }

      if(var3 < level.disable_super_in_turret.ref_11b76 && (level.disable_super_in_turret.ref_11b75 == 0 || var6 < level.disable_super_in_turret.ref_11b75)) {
        var3++;
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var5.objidnum, self);
        continue;
      }

      var3 = level.disable_super_in_turret.ref_11b76;
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var5.objidnum, self);

      if(var1 != -1 && var1 == var5.objidnum) {
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
      }
    }

    wait var0;
  }
}

function ref_12588() {
  self endon("death_or_disconnect");
  self endon("ghost_unset");

  if(level.disable_super_in_turret.score_accuracy_think) {
    self hudoutlinedisable();

    if(!level.disable_super_in_turret.score_event_accuracy) {
      self setscriptablepartstate("headVFX", "zombieVision");
    }

    self visionsetnakedforplayer("mp_don4_wz_ghost", 0);
    ref_1259b();
  }

  waitframe();

  if(getdvarint("scr_br_gxp_loop_zombie_fx", 0)) {
    self setscriptablepartstate("ghost", "on_loop");
    return;
  }

  self setscriptablepartstate("ghost", "on");
}

function ref_1259b() {
  foreach(var1 in level.players) {
    if(!var1 scripts\mp\gametypes\br_public::ref_125ec()) {
      scripts\mp\utility\outline::outlineenableforplayer(var1, self, "outline_depth_zombievision", "top");
    }
  }
}

function ref_12595() {
  level endon("game_ended");
  self endon("ghost_unset");
  self endon("disconnect");
  self.sat_wait_for_connection_think = undefined;

  for(;;) {
    if(ref_1259c()) {
      if(!isDefined(self.sat_wait_for_connection_think) || !self.sat_wait_for_connection_think) {
        self.sat_wait_for_connection_think = 1;
        ref_1258d();
      }
    } else if(!isDefined(self.sat_wait_for_connection_think) || self.sat_wait_for_connection_think) {
      self.sat_wait_for_connection_think = 0;
      ref_1258e();
    }

    waitframe();
  }
}

function ref_1259c() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return false;
  }

  var0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var1 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  return distance2dsquared(var0, self.origin) > var1 * var1;
}

function ref_1258d() {
  self notify("ghost_enter_gas");
  self unsetperk("specialty_radarblip", 1);
}

function ref_1258e() {
  self notify("ghost_exit_gas");

  if(level.disable_super_in_turret.saw_4_angles >= 0) {
    if(level.disable_super_in_turret.saw_4_angles == 0) {
      self setperk("specialty_radarblip", 1);
      return;
    }

    thread ref_125a6();
    return;
  }
}

function ref_125a6() {
  if(level.disable_super_in_turret.saw_4_angles <= 0) {
    return;
  }

  self endon("ghost_unset");
  self endon("ghost_enter_gas");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self setperk("specialty_radarblip", 1);
    wait level.disable_super_in_turret.saw_4_origin;
    self unsetperk("specialty_radarblip", 1);
    wait level.disable_super_in_turret.saw_4_angles;
  }
}

function ref_125ab() {
  self endon("disconnect");
  self.ref_133e9 = 1;
  self.radarmode = "normal_radar";
  self.hasradar = 1;
  self waittill("ghost_unset");
  self.ref_133e9 = undefined;
  self.hasradar = 0;
}

function ref_125af() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");

  for(;;) {
    if(self issupersprinting()) {
      self refreshsprinttime();
    }

    waitframe();
  }
}

function ref_12599(var0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  wait 1;

  while(!self isonground()) {
    ref_125b8(var0);
    waitframe();
  }

  self setclientomnvar("ui_br_altimeter_state", 0);
  self skydive_interrupt();
  playFXOnTag(level._effect["zombie_splat"], self, "j_mainroot");
  self playsoundtoplayer("br_gov_ghost_infil_land", self, self);
  self playSound("br_gov_ghost_infil_land_npc", self, self);
  self freezecontrols(1);
  var1 = gettime() + 2000;

  while(self getcurrentprimaryweapon().classname == "none" && gettime() < var1) {
    ref_125b8(var0);
    waitframe();
  }

  var2 = propwaitminigameinit(self, 0);

  if(!isDefined(var2)) {
    var2 = (0, 0, 1);
  }

  var3 = anglesToForward(self.angles);
  var4 = vectortoangles(var2);
  var5 = angleclamp180(var4[0] + 90);
  var4 = (0, var4[1], 0);
  var6 = anglesToForward(var4);
  var7 = vectordot(var6, var3);
  var8 = var7 * var5;
  var9 = getdvarint("scr_br_gxp_zombie_splat_down_clamp", 20);
  var10 = getdvarint("scr_br_gxp_zombie_splat_up_clamp", -70);

  if(var8 > 0) {
    var8 = min(var9, var8);
  } else {
    var8 = max(var10, var8);
  }

  self setplayerangles((var8, self.angles[1], 0));

  if(self getcurrentprimaryweapon().classname != "none") {
    self forceplaygestureviewmodel("ges_gxp_splat");
  }

  self playFX(level.disable_super_in_turret.scn_infil_hackney_heli_npc6, self.origin);
  wait 1.5;
  self freezecontrols(0);
  self freezelookcontrols(1);
  self allowsprint(0);
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  wait 1;
  self freezelookcontrols(0);
  wait 1;
  ref_125b8(var0);
  self allowsprint(1);
  thread ref_125a7();
}

function ref_125a7() {
  if(!level.disable_super_in_turret.saw_head_icon) {
    return;
  }

  thread ref_126b4(level.disable_super_in_turret.sat_piece);
}

function ref_126b4(var0) {
  self notifyonplayercommand("ghostAttack", "+attack");
  self notifyonplayercommand("ghostAttack", "+melee_zoom");
  thread ref_12596();
  thread ref_12637(var0);
  thread ref_12634(var0);
  thread ref_12635(var0);

  if(level.disable_super_in_turret.spawndistancemax) {
    thread ref_1263a(var0);
  }

  thread ref_12638(var0);
  thread ref_12630(var0);

  foreach(var2 in var0.powers) {
    if(isDefined(var0.powers[var3].ref_1388f)) {
      ref_13fdd(var0.powers[var3].ref_1388f, 2);
    }
  }
}

function ref_13fdd(var0, var1) {
  var2 = 0;
  var3 = 0;

  switch (var0) {
    case "jumpStatus":
      var2 = 0;
      var3 = 2;
      break;
    case "jumpProgress":
      var2 = 2;
      var3 = 7;
      break;
    case "spectralBlastStatus":
      var2 = 9;
      var3 = 2;
      break;
    case "spectralBlastProgress":
      var2 = 11;
      var3 = 7;
      break;
    case "teleportStatus":
      var2 = 18;
      var3 = 2;
      break;
    case "teleportProgress":
      var2 = 20;
      var3 = 7;
      break;
    case "numVaccine":
      var2 = 27;
      var3 = 2;
      break;
    case "inSafeZone":
      var2 = 29;
      var3 = 1;
      break;
    default:
      break;
  }

  if(!isDefined(level.saw_fallback_positions)) {
    level.saw_fallback_positions = [];
  }

  if(!isDefined(level.saw_fallback_positions["ui_br_zombie_powers"])) {
    level.saw_fallback_positions["ui_br_zombie_powers"] = 0;
  }

  var4 = int(pow(2, var3)) - 1;
  var5 = (int(var1) &var4) << var2;
  var6 = ~(var4 << var2);
  var7 = self calloutmarkerping_entityzoffset("ui_br_zombie_powers");
  var8 = var7 &var6;
  var9 = var8 + var5;
  level.saw_fallback_positions["ui_br_zombie_powers"] = var9;
  self setclientomnvar("ui_br_zombie_powers", level.saw_fallback_positions["ui_br_zombie_powers"]);
}

function ref_12630(var0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::ref_143a6("death", "ghost_unset", "ghost_set");
  self notifyonplayercommandremove("ghostAttack", "+attack");
  self notifyonplayercommandremove("ghostAttack", "+melee_zoom");
  thread ref_1262d(var0);
  thread ref_12632(var0);
  thread ref_12633(var0);
  thread ref_12631(var0);
}

function ref_12631(var0) {
  if(!isDefined(self.ref_12821)) {
    return;
  }

  if(level.disable_super_in_turret.spawndistancemax) {
    foreach(var2 in self.ref_12821) {
      if(isDefined(var2)) {
        if(isDefined(var2.choppergunner_refillmissiles)) {
          var2.choppergunner_refillmissiles scripts\mp\hud_util::destroyelem();
        }

        var2 destroy();
      }
    }
  }

  self.ref_12821 = undefined;
}

function ref_12632(var0) {
  if(isbot(self)) {
    return;
  }

  foreach(var2 in var0.powers) {
    foreach(var4 in var2.clients_hacked) {
      self notifyonplayercommandremove(var6, var4);
    }
  }
}

function ref_12633(var0) {
  foreach(var2 in var0.powers) {
    if(isDefined(var2.has_ammo_drain_passive)) {
      self thread[[var2.has_ammo_drain_passive]](var0, var3);
    }
  }
}

function ref_1262d(var0) {
  if(!isDefined(var0) || !isDefined(self.ref_12821)) {
    return;
  }

  self notify("disableCooldown");

  foreach(var3, var2 in var0.powers) {
    if(!isDefined(self.ref_12821[var3])) {
      continue;
    }

    self.ref_12821[var3].incooldown = 0;

    if(level.disable_super_in_turret.spawndistancemax) {
      self.ref_12821[var3].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0, 0);
    } else {
      self.ref_12821[var3].frac = 0;
    }

    thread ref_12639(var0, var3);
  }

  self.laststandattackermodifiers = undefined;
  self.vehicle_occupancy_mp_hidecashbag = undefined;
}

function ref_12639(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("ghost_set");
  self endon("disableCooldown");

  if(!isDefined(self.ref_12821[var1]) || istrue(self.ref_12821[var1].incooldown)) {
    return;
  }

  var2 = self.ref_12821[var1];

  if(level.disable_super_in_turret.ref_12820 && var2.frac > 0) {
    self.ref_12821[var1].incooldown = 1;
    var3 = var0.powers[var1].idmask;
    var4 = "scr_br_gxp_power_cooldown_" + var1;

    if(getdvarint(var4, 0) != 0) {
      var3 = getdvarint(var4, 0);
    }

    thread ref_126de(var0, var1, var3, int(var2.frac * 100));
    var5 = var2.frac;
    var3 *= var5;

    if(level.disable_super_in_turret.spawndistancemax) {
      var2.choppergunner_refillmissiles.bar.color = (1, 0.6, 0);
      var2.choppergunner_refillmissiles.bar scaleovertime(var3, 0, var2.choppergunner_refillmissiles.height);
    }

    wait var3;

    if(var1 == "spectralBlast") {
      var6 = "ui_zxp_restock_emp";
    } else if(var2 == "teleport") {
      var6 = "ui_zxp_recharge_tport";
    } else {
      var6 = "ui_zxp_restock_" + var3;
    }

    self playlocalsound(var6);
    self.ref_12821[var3].incooldown = 0;
  } else {
    if(level.disable_super_in_turret.spawndistancemax) {
      var4.choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0, 0);
    } else {
      var4.frac = 0;
    }

    thread ref_126de(var2, var3, 0, 0);
  }

  if(level.disable_super_in_turret.spawndistancemax) {
    var4.choppergunner_refillmissiles.bar.color = (1, 1, 1);
  }

  if(isDefined(var2.powers[var3].ref_127fc)) {
    self[[var2.powers[var3].ref_127fc]](var2, var3);
    return;
  }
}

function ref_126de(var0, var1, var2, var3) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("ghost_set");
  self endon("disableCooldown");

  if(!isDefined(var0.powers[var1].ref_1388f) || !isDefined(var0.powers[var1].ref_128be)) {
    return;
  }

  ref_13fdd(var0.powers[var1].ref_1388f, 1);
  var4 = var2 * 1000 * var3 / 100;
  var5 = gettime();
  var6 = var5 + var4;

  while(gettime() < var6) {
    var7 = gettime();
    var8 = (var6 - gettime()) / var4;
    var9 = var8 * var3;
    ref_13fdd(var0.powers[var1].ref_128be, int(var9));
    waitframe();
  }

  ref_13fdd(var0.powers[var1].ref_128be, 0);
  ref_13fdd(var0.powers[var1].ref_1388f, 2);
}

function ref_12638(var0) {
  foreach(var2 in var0.powers) {
    if(isDefined(var2.ref_1387b)) {
      self thread[[var2.ref_1387b]](var0, var3);
    }
  }
}

function ref_1263a(var0) {
  level endon("game_ended");
  self endon("ghost_unset");
  self endon("ghost_set");
  self endon("death_or_disconnect");

  if(isbot(self)) {
    return;
  }

  waittillframeend();
  var1 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    var2 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var2 != var1) {
      var1 = var2;
      jumpiffalse(var2) LOC_00000091;

      foreach(var5, var4 in var0.powers) {
        if(isDefined(var4.waitforstreamsynccomplete)) {
          self.ref_12821[var5].label = var4.label;
        }
      }

      goto LOC_000000db;
    }

    waitframe();
  }
}

function ref_12635(var0) {
  foreach(var2 in var0.powers) {
    thread ref_12636(var0, var3);
  }
}

function ref_12636(var0, var1) {
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("ghost_set");
  level endon("game_ended");

  for(;;) {
    self waittill(var1);
    waittillframeend();

    if(isDefined(self.ref_12821[var1]) && self.ref_12821[var1].incooldown) {
      ref_12614();
      continue;
    }

    if(self isinexecutionattack()) {
      continue;
    }

    self thread[[var0.powers[var1].func]](var0, var1);
  }
}

function ref_12614() {
  if(!isDefined(self.laststandattackermodifiers) || gettime() > self.laststandattackermodifiers) {
    self playlocalsound("br_pickup_deny");
    self.laststandattackermodifiers = gettime() + 1000;
    return;
  }
}

function ref_12634(var0) {
  var1 = 200;
  var2 = 18;
  var3 = var1;
  self.ref_12821 = [];

  foreach(var6, var5 in var0.powers) {
    if(isDefined(var5.label)) {
      if(level.disable_super_in_turret.spawndistancemax) {
        self.ref_12821[var6] = ref_1262f(var5.label, var5.waitforstreamsynccomplete, var3, var5.ref_13060);
      } else {
        self.ref_12821[var6] = spawnStruct();
        self.ref_12821[var6].frac = 0;
      }

      self.ref_12821[var6].incooldown = 0;
      var3 += var2;
    }
  }
}

function ref_1262f(var0, var1, var2, var3) {
  var4 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var4.x = 15;
  var4.y = var2;
  var4.alignx = "left";
  var4.aligny = "top";
  var4.horzalign = "left_adjustable";
  var4.vertalign = "top_adjustable";
  var4.alpha = var3;
  var4.glowalpha = 0;
  var4.hidewheninmenu = 1;
  var4.archived = 0;

  if(isDefined(var1) && !scripts\engine\utility::is_player_gamepad_enabled()) {
    var4.label = var1;
  } else if(isDefined(var0)) {
    var4.label = var0;
  }

  var5 = scripts\mp\hud_util::createbar((1, 1, 1), 160, 14);
  var5.x = 13;
  var5.y = var2;
  var5.alignx = "left";
  var5.aligny = "top";
  var5.horzalign = "left_adjustable";
  var5.vertalign = "top_adjustable";
  var5.alpha = var3;
  ref_132a8(var5);
  var5.archived = 0;
  var5.hidewheninmenu = 1;
  var5.bar.archived = 0;
  var5.bar.hidewheninmenu = 1;
  var5.bar.alpha = var3;
  var4.choppergunner_refillmissiles = var5;
  return var4;
}

function ref_132a8(var0, var1, var2, var3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y + 2;
  self.bar.x = self.x + 2;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

function ref_12637(var0) {
  if(isbot(self)) {
    return;
  }

  foreach(var2 in var0.powers) {
    foreach(var4 in var2.clients_hacked) {
      self notifyonplayercommand(var6, var4);
    }
  }
}

function propwaitminigameinit(var0, var1) {
  if(!isDefined(var0)) {
    var2 = self;
  } else {
    var2 = var1;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3 = [var2];
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

function ref_125b8(var0) {
  if(!self hasweapon(var0)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var0, undefined, undefined, 1);
  }

  if(self getcurrentprimaryweapon().classname == "none") {
    thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var0);
    return;
  }
}

function ref_126bd(var0, var1, var2) {
  scripts\mp\gametypes\br_gulag::ref_126c3(var2, var1);
  var3 = spawn("script_model", var2);
  var3 setModel("tag_origin");
  var3.angles = var1;
  var3 hide();
  var3 showtoplayer(self);
  self playerlinktoabsolute(var3, "tag_origin");
  self playerhide();
  thread scripts\mp\gametypes\br_gulag::ref_12524(var3);
  waitframe();
  scripts\mp\gametypes\br_public::ref_126ed();
  scripts\mp\gametypes\br_public::ref_1252b();
  var3.origin = var0;
  waitframe();
  self unlink();
  self clearsoundsubmix("deaths_door_mp");
  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  self clearclienttriggeraudiozone(1);
  self playershow();
  var4 = 0;

  if(isDefined(level.ref_121cc)) {
    var4 = level.ref_121cc;
  }

  thread scripts\cp_mp\parachute::startfreefall(var4, 0, undefined, undefined, 1);
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_show_spectateHud", -1);
  scripts\mp\gametypes\br_gulag::ref_12c7a();
  wait 0.5;
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
  waitframe();
  var3 delete();
  self notify("can_show_splashes");
}

function ref_125a8(var0, var1) {
  var2 = var0;

  if(level.disable_super_in_turret.scn_infil_hackney_heli_npc4) {
    var3 = getdvarint("scr_br_gxp_respawnGhostHeight", 10000);
    var4 = (0, 0, var3);
    var0 = scripts\mp\gametypes\br::getoffsetspawnorigin(var0, var4);
    var5 = spawnStruct();
    var5.origin = var0;
    var5.angles = var1;
    var5.height = var3;
    var2 = scripts\mp\gametypes\br_gulag::ref_1263e(var5);
  } else {
    self calloutmarkerping_getinventoryslot(0);
    scripts\mp\gametypes\br_public::ref_126b9(var2);
  }

  return [var0, var2];
}

function ref_12569() {
  var0 = 50;
  var1 = 10000;
  var2 = ref_12597();
  var3 = var2[0];
  var4 = var2[1];
  var2 = undefined;

  if(isDefined(var3)) {
    return [var3, var4];
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.disable_super_in_turret.scn_infil_hackney_heli_npc3)) {
    return [self.origin, self getplayerangles()];
  }

  var5 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var6 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var7 = var5 + var0;
  var8 = (self.origin[0], self.origin[1], 0);
  var9 = vectorNormalize(var8 - var6);
  var10 = run_track_enemy_patrollers(var6, var9, var7);
  var11 = var10[0];
  var4 = var10[1];
  var10 = undefined;

  if(!isDefined(var11)) {
    var9 *= -1;
    var12 = run_track_enemy_patrollers(var6, var9, var7);
    var11 = var12[0];
    var4 = var12[1];
    var12 = undefined;
  }

  if(!isDefined(var11)) {
    var9 = (1, 0, 0);
    var13 = run_track_enemy_patrollers(var6, var9, var7);
    var11 = var13[0];
    var4 = var13[1];
    var13 = undefined;
  }

  if(!isDefined(var11)) {
    var9 = (-1, 0, 0);
    var14 = run_track_enemy_patrollers(var6, var9, var7);
    var11 = var14[0];
    var4 = var14[1];
    var14 = undefined;
  }

  if(!isDefined(var11)) {
    var9 = (0, 1, 0);
    var15 = run_track_enemy_patrollers(var6, var9, var7);
    var11 = var15[0];
    var4 = var15[1];
    var15 = undefined;
  }

  if(!isDefined(var11)) {
    var9 = (0, -1, 0);
    var16 = run_track_enemy_patrollers(var6, var9, var7);
    var11 = var16[0];
    var4 = var16[1];
    var16 = undefined;
  }

  if(!isDefined(var11)) {
    var11 = self.origin;
    var4 = self.angles;
  }

  var3 = scripts\mp\gametypes\br_public::modifyplayer_damage(var11, var1);
  return [var3, var4];
}

function run_track_enemy_patrollers(var0, var1, var2) {
  var3 = var0 + var1 * var2;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var3, 1)) {
    var4 = vectortoangles(var1 * -1);
    return [var3, var4];
  }

  return [undefined, undefined];
}

function ref_12597() {
  var0 = undefined;
  var1 = undefined;
  var2 = getdvarfloat("scr_br_gxp_respawnTeamOffset", 10000);

  if(var2 >= 0) {
    var3 = scripts\mp\gametypes\br_gulag::ref_12568(0);

    if(isDefined(var3)) {
      var0 = rocket_fuel_stability(var3.origin, var2);
      var0 = scripts\mp\gametypes\br_public::modifyplayer_damage(var0);
      var1 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var0, var3.origin);
    }
  }

  return [var0, var1];
}

function rocket_fuel_stability(var0, var1) {
  var2 = 3.14159;
  var3 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var4 = vectorNormalize(var0 - var3);
  var5 = vectortoangles(var4);
  var6 = randomfloatrange(getdvarfloat("scr_br_respawn_rand_ang_min", 10), getdvarfloat("scr_br_respawn_rand_ang_max", 60));
  var7 = var4;
  var8 = var0 + var7 * var1;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var8, 0)) {
    return var8;
  }

  var7 *= -1;
  var8 = var0 + var7 * var1;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var8, 0)) {
    return var8;
  }

  var7 = vectorNormalize(var3 - var0);
  var8 = var0 + var7 * var1;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var8, 0)) {
    return var8;
  }

  var9 = var1;
  var10 = distance2d(var0, var3);
  var11 = var9 / var10;

  if(var11 > var2) {
    var11 = var2;
  }

  var12 = var11 * 180 / var2;
  var8 = rotatepointaroundvector((0, 0, 1), var0 - var3, var12) + var3;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var8, 0)) {
    return var8;
  }

  var8 = scripts\mp\gametypes\br_circle::getrandompointincircle(var0, var1);

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var8, 0)) {
    return var8;
  }

  return undefined;
}

function ref_126ee() {
  if(scripts\mp\gametypes\br_public::ref_125ec()) {
    self waittill("spawnGhost");
    return;
  }
}

function ref_1267c(var0) {
  self.tut_loot = var0;
}

function ref_1267f(var0) {
  if(istrue(var0)) {
    self.game_extrainfo |= 4096;
    return;
  }

  self.game_extrainfo &= ~4096;
}

function ref_126e6(var0) {
  foreach(var2 in level.disable_super_in_turret.ref_12cb0) {
    if(isDefined(var2.visuals[0])) {
      ref_12cb2(var2.visuals[0], self);
    }
  }
}

function ref_12cb2(var0) {
  if(var0 scripts\mp\gametypes\br_public::ref_125ec()) {
    self showtoplayer(var0);

    if(!level.disable_super_in_turret.ref_13a25) {
      self enableplayeruse(var0);
      return;
    }

    return;
  }

  self hidefromplayer(var0);

  if(!level.disable_super_in_turret.ref_13a25) {
    self disableplayeruse(var0);
    return;
  }
}

function ref_125ce() {
  foreach(var1 in level.disable_super_in_turret.ref_12cb0) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var1.objidnum, self);
  }
}

function ref_1267e(var0, var1) {
  self.unset_relic_gun_game = var0;

  if(!isDefined(level.disable_super_in_turret.saw_angles)) {
    level.disable_super_in_turret.saw_angles = [];
  }

  ref_1267f(var0);

  if(isDefined(level.disable_super_in_turret.ref_11b5b)) {
    ref_126e6(var0);
  }

  if(var0) {
    self notify("ghost_set");

    if(level.disable_super_in_turret.spawndistancemax) {
      ref_125ac();
    }

    self.ref_11f39 = 0;
    self.bcdisabled = 1;
    self.plunderlimit = 1;
    ref_1267c(0);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(9);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(10);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(11);
    level.disable_super_in_turret.saw_angles[level.disable_super_in_turret.saw_angles.size] = self;
    ref_13fdd("numVaccine", self.ref_11f39);
  } else {
    self notify("ghost_unset");
    self.ref_11f39 = undefined;
    self.bcdisabled = undefined;
    self.plunderlimit = undefined;
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);

    if(isDefined(level.disable_super_in_turret.ref_11b5b)) {
      ref_125ce();
    }

    level.disable_super_in_turret.saw_angles = scripts\engine\utility::array_remove(level.disable_super_in_turret.saw_angles, self);
  }

  level notify("players_remaining_changed");
  self notify("stop_battlechatter");

  if(istrue(var1)) {
    self lerpfovbypreset("default");

    if(level.disable_super_in_turret.score_event_accuracy) {
      thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
      return;
    }

    return;
  }
}

function ref_125ac() {
  var0 = -60;
  var1 = 120;
  var2 = 180;
  self.spawnboardroom_juggdrop = ref_12530(var0, var1, "right", "middle", "center", "middle", &"MP_ZXP/NUM_CONSUMED", 0);
  self.spawnboardroom_loadoutdrop = ref_12530(var0, var1, "left", "middle", "center", "middle", &"MP_ZXP/NUM_TO_CONSUME", level.disable_super_in_turret.saw_3_origin);
  self.spawn_wheelson_redroom = ref_12530(0, var2, "center", "middle", "center", "middle", &"MP_ZXP/ZOMBIE");
}

function ref_12530(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var8.x = var0;
  var8.y = var1;
  var8.alignx = var2;
  var8.aligny = var3;
  var8.horzalign = var4;
  var8.vertalign = var5;
  var8.alpha = 0;
  var8.glowalpha = 0;
  var8.hidewheninmenu = 1;
  var8.archived = 0;

  if(isDefined(var6)) {
    var8.label = var6;
  }

  if(isDefined(var7)) {
    var8 setvalue(var7);
  }

  return var8;
}

function ref_125ae(var0) {
  var1 = self.team;
  scripts\mp\utility\teams::ref_140c9("mode", var1, self);
  ref_126d8();

  if(istrue(var0)) {
    [[level.updategameevents]]();
    return;
  }
}

function ref_12811() {
  level notify("post_update_game_events_internal");
  level endon("post_update_game_events_internal");

  if(istrue(level.br_debugsolotest) || level.gameended) {
    return;
  }

  var0 = 1000;

  if(isDefined(level.disabled_permanently) && level.disabled_permanently + var0 > gettime()) {
    wait 1;
  }

  var1 = 0;
  var2 = [];
  var3 = [];

  foreach(var5 in level.teamnamelist) {
    var6 = level.teamdata[var5]["teamCount"];

    if(var6 > 0) {
      if(isDefined(level.teamdata[var5]["aliveCountHuman"]) && level.teamdata[var5]["aliveCountHuman"] > 0) {
        if((level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto || level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback == 0) && var3.size > 0) {
          return;
        }

        var3 = var5;
        var1 += level.teamdata[var5]["aliveCountHuman"];
        continue;
      }

      if(level.teamdata[var5]["aliveCount"] > 0) {
        var2 = var5;
      }
    }
  }

  if(var3.size > 1) {
    return;
  }

  var8 = scripts\mp\utility\script::quicksort(var2, &ref_134d5);

  for(var9 = 0; var9 < var8.size; var9++) {
    var5 = var8[var9];
    var10 = var9 + 2;
    thread scripts\mp\gametypes\br::ref_1209b(var5, var10, 0, 1);
    var11 = scripts\mp\utility\teams::getfriendlyplayers(var5);

    foreach(var13 in var11) {
      var13 scripts\cp_mp\utility\game_utility::ref_13168(var10);

      if(isalive(var13)) {
        var13 setscriptablepartstate("ghost", "off");
        var13 playerhide();
      }
    }
  }

  var15 = var3[0];

  foreach(var13 in level.players) {
    if(var13 scripts\mp\gametypes\br_public::ref_125ec()) {
      if(var13.team != var15) {
        var13 allowmovement(0);
        var13 allowmelee(0);
      }

      if(var13 scripts\mp\utility\perk::_hasperk("specialty_tracker")) {
        var13 scripts\mp\utility\perk::removeperk("specialty_tracker");
      }
    }

    var13.setcheckliststateforteam = 1;
  }

  thread scripts\mp\gamelogic::endgame(var15, game["end_reason"]["enemies_eliminated"]);
}

function ref_12810() {
  thread ref_12811();
}

function ref_131cc(var0) {
  level.teamdata[var0]["lastGhostTime"] = gettime();
}

function ref_134d5(var0, var1) {
  var2 = level.teamdata[var0]["lastGhostTime"];
  var3 = level.teamdata[var1]["lastGhostTime"];
  return var2 >= var3;
}

function ref_1365d(var0) {
  if(istrue(var0.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done") && var0 scripts\mp\gametypes\br_public::ref_125ec()) {
    ref_12645(var0);
    return true;
  }

  return false;
}

function addtoteamlives(var0, var1) {
  ref_126d8(var0);
}

function removefromteamlives(var0, var1) {
  ref_126d8(var0);
}

function ref_126d8() {
  var0 = self.team;
  level.teamdata[var0]["aliveCountHuman"] = 0;

  foreach(var2 in level.teamdata[var0]["alivePlayers"]) {
    if(!var2 scripts\mp\gametypes\br_public::ref_125ec() && !ref_125e8(var2)) {
      level.teamdata[var0]["aliveCountHuman"]++;
    }
  }
}

function ref_125e8() {
  return istrue(self.tut_loot);
}

function ref_13247() {
  if(!level.disable_super_in_turret.saw_head_icon) {
    return;
  }

  level.disable_super_in_turret.sat_piece = spawnStruct();
  level.disable_super_in_turret.sat_piece.powers = [];
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "jump", ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"], &ref_1259e, 0, undefined, &ref_125a0, undefined, &"MP_GXP/CHARGED_JUMP", undefined, 6, "jumpStatus", "jumpProgress");
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "jumpStop", ["-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible"], &ref_125a3, 0);
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "teleport", "+smoke", &ref_125b0, 0, undefined, undefined, undefined, &"MP_GXP/TELEPORT", undefined, 15, "teleportStatus", "teleportProgress");
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "spectralBlast", "+frag", &ref_125ad, 0, undefined, undefined, undefined, &"MP_GXP/SCREAM", undefined, 15, "spectralBlastStatus", "spectralBlastProgress");

  if(getdvarint("scr_br_gxp_bumper_ping_support", 1)) {
    battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "gas_or_emp", ["+equip_toggle_throw"], &ref_125b1, 0, undefined, &ref_125b2);
    return;
  }
}

function battlepassxpmultipliers(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12) {
  var13 = "scr_br_gxp_power_" + var1;

  if(getdvarint(var13, 1) == 0) {
    return;
  }

  if(isstring(var2)) {
    var2 = [var2];
  }

  var0.powers[var1] = spawnStruct();
  var0.powers[var1].clients_hacked = var2;
  var0.powers[var1].func = var3;
  var0.powers[var1].ref_1387b = var5;
  var0.powers[var1].has_ammo_drain_passive = var6;
  var0.powers[var1].ref_127fc = var7;
  var0.powers[var1].label = var8;
  var0.powers[var1].waitforstreamsynccomplete = var9;
  var0.powers[var1].idmask = var10;
  var0.powers[var1].ref_1388f = var11;
  var0.powers[var1].ref_128be = var12;
  var0.powers[var1].ref_13060 = var4;
}

function ref_12596() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");

  for(;;) {
    self waittill("ghostAttack");

    if(self isgestureplaying() && !istrue(self.scn_infil_tango_npc_0_sfx)) {
      self stopgestureviewmodel("ges_gxp_superjump", 0, 1);
      self stopgestureviewmodel("ges_gxp_scream");
      self stopgestureviewmodel("ges_gxp_teleport");
    }
  }
}

function ref_1259e(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("playerGhostJumpStop");
  var2 = -1;

  if(ref_1259f()) {
    ref_12614();
    return;
  }

  var3 = getdvarfloat("scr_br_gpx_powers_jump_charge_rate", 1);
  var4 = getdvarfloat("scr_br_gxp_powers_jump_min_frac", 0.25);
  var5 = getdvarint("scr_br_gxp_powers_jump_max_hold_time", var2);
  var6 = var3 * level.framedurationseconds;
  self.vehicle_occupancy_monitormovementcontrols = 0;
  self allowmelee(0);
  self disableoffhandweapons();
  self.scn_infil_tango_npc_0_sfx = 1;

  while(self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback()) {
    waitframe();
  }

  thread ref_12598();
  thread ref_13982();
  var7 = undefined;
  var8 = 0;

  if(!isDefined(self.vehicle_occupancy_mp_hidecashbag) || gettime() > self.vehicle_occupancy_mp_hidecashbag) {
    self playlocalsound("ui_zxp_charge_jump_start");
    self.vehicle_occupancy_mp_hidecashbag = gettime() + 500;
  }

  jumpiffalse(isDefined(var0.powers[var1].ref_1388f)) LOC_00000109;
  ref_13fdd(var0.powers[var1].ref_1388f, 0);

  while(!ref_1259f()) {
    if(level.disable_super_in_turret.spawndistancemax) {
      self.ref_12821[var1].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(self.vehicle_occupancy_monitormovementcontrols, 0);
    } else {
      self.ref_12821[var1].frac = self.vehicle_occupancy_monitormovementcontrols;
    }

    var9 = self.vehicle_occupancy_monitormovementcontrols;
    self.vehicle_occupancy_monitormovementcontrols += var6;

    if(self.vehicle_occupancy_monitormovementcontrols >= 1) {
      self.vehicle_occupancy_monitormovementcontrols = 1;

      if(var5 >= 0) {
        if(!isDefined(var7)) {
          var7 = gettime() + var5 * 1000;

          if(level.disable_super_in_turret.spawndistancemax) {
            thread ref_125a2(var1, var5);
          }
        }

        if(gettime() >= var7) {
          break;
        }
      }
    }

    if(level.disable_super_in_turret.spawndistancemax && var9 < var4 && self.vehicle_occupancy_monitormovementcontrols >= var4) {
      self.ref_12821[var1].choppergunner_refillmissiles.bar.color = (0, 1, 0);
    }

    if(var9 < 1 && self.vehicle_occupancy_monitormovementcontrols >= 1) {
      self playlocalsound("ui_zxp_charge_jump_full");
    }

    if(isDefined(var0.powers[var1].ref_128be)) {
      var8 = max(int(self.vehicle_occupancy_monitormovementcontrols * 100), 0);
      ref_13fdd(var0.powers[var1].ref_128be, var8);
    }

    waitframe();
  }

  thread ref_125a1(var0, var1);
}

function ref_13982() {
  var0 = self;
  var0 endon("death_or_disconnect");
  var0 notify("applyFOVPresentation");
  var0 endon("applyFOVPresentation");
  var0 lerpfovbypreset("zombiearcade");
  var0 waittill("endSuperJumpFov");
  var0 lerpfovbypreset("zombiedefault");
}

function ref_1259f() {
  return self getstance() == "prone" || istrue(self.usingascender);
}

function ref_12598() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("playerGhostJumpStop");

  if(self isgestureplaying("ges_gxp_superjumpcharge")) {
    return;
  }

  while(self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback()) {
    waitframe();
  }

  self forceplaygestureviewmodel("ges_gxp_superjumpcharge");

  while(self isgestureplaying("ges_gxp_superjumpcharge")) {
    if(self isonladder()) {
      self stopgestureviewmodel("ges_gxp_superjumpcharge");
      break;
    }

    waitframe();
  }
}

function ref_125a2(var0, var1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("playerGhostJumpStop");
  self endon("playerGhostJumpChargeEnd");

  if(var1 <= 0) {
    return;
  }

  var2 = scripts\mp\gametypes\br_circle::can_killstreak_be_detected(var1, int(var1 * 5), 1);
  var3 = 1;

  for(var4 = 0; var4 < var2.size; var4++) {
    if(var3) {
      self.ref_12821[var0].choppergunner_refillmissiles.bar.color = (1, 0, 0);
    } else {
      self.ref_12821[var0].choppergunner_refillmissiles.bar.color = (0, 1, 0);
    }

    wait var2[var4];
    var3 = !var3;
  }
}

function ref_125a1(var0, var1) {
  self stopgestureviewmodel("ges_gxp_superjumpcharge");
  self notify("playerGhostJumpChargeEnd");
  self notify("playerGhostJumpStop");
  var2 = getdvarfloat("scr_br_gxp_powers_jump_min_frac", 0.25);
  var3 = getdvarint("scr_br_gxp_powers_jump_min_frac_refund", 1);

  if(self.vehicle_occupancy_monitormovementcontrols >= var2 && !ref_1259f() && ref_125a4() && !self ismantling()) {
    self playsoundtoplayer("br_gov_ghost_jump_plr", self, self);
    self playSound("br_gov_ghost_jump_3p", self, self);
    var4 = getdvarfloat("scr_br_gxp_powers_jump_velocity", 1300);
    var5 = self getplayerangles();
    thread ref_1259a();
    ref_1250a(var5, var4, self.vehicle_occupancy_monitormovementcontrols);
    thread ref_126d7();
    thread ref_12528();
    self.laststandattackermodifiers = undefined;
    self.vehicle_occupancy_mp_hidecashbag = undefined;
  } else if(var3) {
    if(level.disable_super_in_turret.spawndistancemax) {
      self.ref_12821[var1].choppergunner_refillmissiles.bar.frac = 0;
    } else {
      self.ref_12821[var1].frac = 0;
    }

    ref_13fdd(var0.powers[var1].ref_128be, 0);
    self enableoffhandweapons();
    self allowmelee(1);
    self notify("endSuperJumpFov");
    ref_12614();
  } else {
    ref_12614();
  }

  ref_125a0(var0, var1, 1);
}

function ref_1250a(var0, var1, var2, var3) {
  var4 = 1;
  var5 = (0, 0, 20);

  if(!isDefined(var3)) {
    var3 = var5;
  }

  var6 = var0;
  var7 = (0, 0, 1);
  var8 = (1, 0, 0);

  if(getdvarint("scr_br_gxp_powers_jump_pitch_correction", var4)) {
    var7 = propwaitminigameinit();

    if(!isDefined(var7)) {
      var7 = (0, 0, 1);
    }

    var9 = (0, var6[1], 0);
    var10 = anglestoright(var9);
    var8 = vectorcross(var7, var10);
    var11 = vectortoangles(var8);
    var12 = angleclamp180(var11[0]);
    var13 = -85;
    var14 = var12;
    var15 = var6[0];

    if(var15 > var12) {
      var15 = var12;
    }

    var16 = getdvarfloat("scr_br_gxp_powers_jump_pitch_correction_at_max", -45);
    var17 = getdvarfloat("scr_br_gxp_powers_jump_pitch_correction_at_min", 0);
    var18 = (var15 - var13) / (var14 - var13);
    var19 = var17 + var18 * (var16 - var17);
    var6 = (var15 + var19, var6[1], var6[2]);
  }

  var20 = getdvarfloat("scr_br_gxp_powers_jump_pitch_add", 0);

  if(var20 != 0) {
    var6 = (var6[0] + var20, var6[1], var6[2]);
  }

  var21 = anglesToForward(var6);
  var22 = var21 * var2 * var1;
  var23 = self.origin + var3;
  self setOrigin(var23);
  self setvelocity(var22);
  glassradiusdamage(self.origin + (0, 0, 30), 30, 50, 51);
  var24 = anglesToForward(self.angles);
  var25 = self.origin + (0, 0, 30) + var24 * 15;
  radiusdamage(var25, 100, 1, 1);
}

function ref_1259a() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self setscriptablepartstate("skydiveVfx", "enabled_ghost", 0);
  self enableoffhandweapons();
  self giveandfireoffhand("gxp_superjump_mp");
  wait 0.4;
  self notify("endSuperJumpFov");
  self forceplaygestureviewmodel("ges_gxp_superjump");

  while(!ref_1259d()) {
    waitframe();
  }

  self notify("ghost_jump_complete");
  self stopgestureviewmodel("ges_gxp_superjump");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  self playsoundtoplayer("zxp_splat_plr", self, self);
  self playSound("zmb_npc_breath_land_hi", self, self);
  self playSound("zxp_splat_npc", self, self);
  self enableoffhandweapons();
  self allowmelee(1);
  self.scn_infil_tango_npc_0_sfx = undefined;
}

function ref_125a4() {
  if(level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols != 0) {
    var0 = self.origin + (0, 0, level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols);
    var1 = playerphysicstrace(self.origin, var0);

    if(var1 != var0) {
      return false;
    }
  }

  if(level.disable_super_in_turret.vehicle_occupancy_mp_changedseats != 0) {
    var2 = self getEye();
    var0 = var2 + (0, 0, level.disable_super_in_turret.vehicle_occupancy_mp_changedseats);
    var3 = 10;
    var4 = 20;
    var5 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);
    var1 = scripts\engine\trace::capsule_trace(var2, var0, var3, var4, (0, 0, 0), self, var5);

    if(var1["fraction"] != 1) {
      return false;
    }
  }

  return true;
}

function ref_126d7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  var0 = getdvarfloat("scr_br_gxp_air_control", 400);

  if(var0 <= 0) {
    return;
  }

  var1 = getdvarfloat("scr_br_gxp_air_control_max_speed", 1400);
  var2 = getdvarfloat("scr_br_gxp_ghost_fall_speed_scale", 0.85);
  wait 0.2;

  while(!ref_1259d()) {
    var3 = self getnormalizedmovement();

    if(length(var3) > 0) {
      var4 = rotatevector((var3[0], -1 * var3[1], 0), self.angles);
      var5 = self getvelocity();
      var6 = length(var5);
      var7 = var4 * var0 * level.framedurationseconds;
      var8 = var5 + var7;
      var9 = length(var8);

      if(var9 <= var1) {
        if(var8[2] < 0) {
          var8 = (var8[0], var8[1], var8[2] * var2);
        }

        self setvelocity(var8);
      } else if(var6 < var1) {
        var8 = vectorNormalize(var8) * var1;

        if(var8[2] < 0) {
          var8 = (var8[0], var8[1], var8[2] * var2);
        }

        self setvelocity(var8);
      }
    }

    waitframe();
  }
}

function ref_12528() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("ghost_jump_complete");
  var0 = getdvarfloat("scr_br_gxp_clear_moving_platfrom_time", 0.3);

  if(var0 < 0) {
    return;
  }

  if(var0 > 0) {
    wait var0;
  }

  self method_87b1();
}

function ref_125a0(var0, var1, var2) {
  if(istrue(var2)) {
    thread ref_12639(var0, var1);
  }

  self.vehicle_occupancy_monitormovementcontrols = undefined;
}

function ref_1259d() {
  return self isonground() || self isonladder() || self ismantling();
}

function ref_125a3(var0, var1) {
  if(isDefined(self.vehicle_occupancy_monitormovementcontrols)) {
    ref_125a1(var0, "jump");
    return;
  }

  self notify("playerGhostJumpStop");
}

function ref_125b0(var0, var1) {
  var2 = self;
  var3 = getdvarfloat("scr_br_gxp_ghost_teleport_distance", 400);
  var4 = var2 getplayerangles();
  var5 = anglesToForward(var4);
  var6 = var2 getEye();
  var7 = var6 + var5 * var3;
  var7 = chase_hvt_vo(var2, var7, var6, var5);

  if(!isDefined(var2) || !isDefined(var2.ref_12821)) {
    return;
  }

  if(isDefined(var7)) {
    thread ref_1262c(var2, var0);
    return;
  }

  ref_12614(var2);

  if(level.disable_super_in_turret.spawndistancemax) {
    var2.ref_12821["teleport"].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0.05, 0);
  } else {
    var2.ref_12821["teleport"].frac = 0.05;
  }

  thread ref_12639(var2, var0);
}

function chase_hvt_vo(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var3)) {
    var3 = 1;
  }

  var6 = [self];

  if(isDefined(var4)) {
    GscBinSkip0(0x2e, var6.size, var4);
  }

  var7 = var0 + var2 * 10;
  var8 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 1);
  var9 = scripts\engine\trace::ray_trace(var1, var0, var6, var8);
  var10 = var9["position"];

  if(var10 == var0) {
    var11 = var0;
  } else {
    var11 = var11 - var3 * 10 + var10["normal"] * 10;
  }

  var12 = var11 + (0, 0, 72);
  var13 = scripts\engine\trace::ray_trace(var11, var12, var7, var9);
  var14 = var13["position"];

  if(abs(var14[2] - var12[2]) > 1) {
    var15 = var14 - (0, 0, 72);
    var16 = scripts\engine\trace::ray_trace(var14, var15, var7, var9);
    var17 = var16["position"];

    if(abs(var17[2] - var15[2]) > 1) {
      var11 = undefined;
    } else {
      var11 = var17;
    }
  }

  if(isDefined(var11) && positionwouldtelefrag(var11, self)) {
    var11 = undefined;
  }

  if(isDefined(var11)) {
    var18 = self gettagorigin("j_spineupper");
    var19 = self gettagangles("j_spineupper");
    playFX(level.disable_super_in_turret.ref_13aea, var18, anglesToForward(var19), anglestoup(var19));
    self enableoffhandweapons();
    self giveandfireoffhand("gxp_teleport_mp");

    if(var4) {
      var20 = getdvarfloat("scr_br_gxp_ghost_teleport_delay", 0.1);
      wait var20;
    }

    if(!isDefined(self)) {
      return undefined;
    }

    self setOrigin(var11);
    playFXOnTag(level.disable_super_in_turret.ref_13aea, self, "j_spineupper");
    playfxontagforclients(level.disable_super_in_turret.ref_13ae9, self, "tag_eye", self);

    if(istrue(var6)) {
      var21 = self getvelocity();
      var22 = length(var21);
      var23 = var3 * var22 * 0.5;
      self setvelocity(var23);
      self playsoundtoplayer("br_gov_safespace_repel", self, self);
      self playSound("br_gov_safespace_repel_3p", self, self);
    } else {
      self playsoundtoplayer("br_gov_ghost_teleport_plr", self, self);
      self playSound("br_gov_ghost_teleport_3p", self, self);
    }
  }

  return var11;
}

function sat_piece_think(var0) {
  if(isDefined(var0)) {
    wait var0;
  }

  self enableplayerbreathsystem(1);
}

function ref_125ad(var0, var1) {
  var2 = 64;
  var3 = var2 * var2;
  var4 = getdvarfloat("scr_br_gxp_ghost_blast_radius", 768);
  var5 = var4 * var4;
  var6 = "zxp_emp_fire_plr";
  var7 = self;
  var7 enableplayerbreathsystem(0);
  var7 playsoundonmovingent(var6);
  var7 playsoundtoplayer("br_gov_ghost_blast_plr", var7, var7);
  var7 playSound("br_gov_ghost_blast_3p", var7, var7);
  thread sat_piece_think(var7);
  playFXOnTag(level.disable_super_in_turret.ref_136e3, var7, "j_spineupper");
  playfxontagforclients(level.disable_super_in_turret.ref_136e2, var7, "tag_eye", var7);
  self enableoffhandweapons();
  self giveandfireoffhand("gxp_blast_mp");
  var7 playRumbleOnEntity("defaultweapon_fire");
  var7 earthquakeforplayer(0.1, 0.3, var7.origin, 100);
  var8 = getcompleteweaponname("emp_drone_non_player_mp");
  var9 = getcompleteweaponname("emp_drone_non_player_direct_mp");
  var10 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var12 in var10) {
    var13 = var12.owner;
    jumpiffalse(isDefined(var13)) LOC_0000010f;
    var14 = distancesquared(var7.origin, var12.origin);

    if(var14 > var5) {
      continue;
    }

    var15 = scripts\engine\utility::ter_op(var14 > var3, var8, var9);
    var12 dodamage(1, var7.origin, var7, var7, "MOD_EXPLOSIVE", var15);
    var12 playsoundonmovingent("zxp_emp_impact_ent");
    var16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var7, var12, 1, var15, "MOD_EXPLOSIVE", var7, var7.origin);
    thread ref_12586(var16);
    LOC_00000182:
  }

  var18 = getcompleteweaponname("emp_drone_player_mp");
  var19 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
    var19 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](var7.origin, var4);
  }

  var20 = var7 getEye();
  var21 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);

  foreach(var23 in var19) {
    if(var23 scripts\mp\gametypes\br_public::ref_125ec()) {
      continue;
    }

    if(var23 != var7 && !scripts\cp_mp\utility\player_utility::playersareenemies(var7, var23)) {
      continue;
    }

    if(scripts\mp\gametypes\br_gxp_safe_zones::truckdoorleft(var23)) {
      continue;
    }

    var24 = scripts\engine\trace::ray_trace_passed(var20, var23 gettagorigin("j_head"), self, var21);

    if(!var24) {
      continue;
    }

    var23 dodamage(1, var7.origin, var7, var7, "MOD_EXPLOSIVE", var18);
    var16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var7, var23, 1, var18, "MOD_EXPLOSIVE", var7, var7.origin);
    thread ref_12586(var16);
    LOC_00000292:
  }

  thread ref_1262c(var0, var1);
}

function ref_1262c(var0, var1) {
  if(level.disable_super_in_turret.spawndistancemax) {
    self.ref_12821[var1].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(1, 0);
  } else {
    self.ref_12821[var1].frac = 1;
  }

  thread ref_12639(var0, var1);
}

function ref_12586(var0) {
  var1 = getdvarfloat("scr_br_gxp_ghost_blast_emp_duration", 5);
  var2 = getdvarfloat("scr_br_gxp_ghost_blast_shellshock_duration", 5);
  var3 = var0.victim;

  if(isPlayer(var3)) {
    var3 playSound("zxp_emp_impact_plr");
    var4 = scripts\engine\utility::ter_op(getdvarint("scr_br_gxp_ghost_blast_shellshock_nerf", 0), "gxp_scream_mp_nerfed", "gxp_scream_mp");
    var3 scripts\cp_mp\utility\shellshock_utility::_shellshock(var4, "gas", var2, 1);
    playfxontagforclients(level.disable_super_in_turret.ref_136e4, var3, "tag_eye", var3);
    return;
  }

  scripts\cp_mp\emp_debuff::apply_emp_struct(var0);
  moraleslaptopthink(var0, var1);

  if(isDefined(var3)) {
    var3 scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function moraleslaptopthink(var0, var1) {
  var0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var1);

  if(var2 != "emp_cleared") {
    var0.empremoved = 1;
    return;
  }
}

function ref_125b1(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("playerGhostTeleportOrSpectralBlast");
  self endon("playerGhostTeleportOrSpectralBlast");
  var2 = gettime() + getdvarint("scr_br_gxp_teleport_or_spectral_blast_timeout_ms", 500);

  while(var2 > gettime()) {
    if(self secondaryoffhandbuttonPressed()) {
      self notify("teleport");
      break;
    } else if(self fragButtonPressed()) {
      self notify("spectralBlast");
      break;
    }

    waitframe();
  }
}

function ref_125b2(var0, var1) {
  self notify("playerGhostTeleportOrSpectralBlast");
}

function nukefridgewatcher() {
  return scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle";
}

function modifyplayerdamage(var0) {
  var1 = var0.damage;
  var2 = isPlayer(var0.attacker) && var0.attacker scripts\mp\gametypes\br_public::ref_125ec();
  var3 = isDefined(var0.attacker) && nukefridgewatcher(var0.attacker);
  var4 = isPlayer(var0.victim) && var0.victim scripts\mp\gametypes\br_public::ref_125ec();
  var5 = scripts\mp\utility\weapon::getweaponbasenamescript(var0.objweapon);

  if(var2 && var4 && var0.meansofdeath == "MOD_MELEE") {
    if(!level.disable_super_in_turret.school_guards_behavior) {
      var1 = 0;
    } else {
      var1 = level.disable_super_in_turret.school_guards_behavior_internal;
    }
  } else if(var2 && !var4 && !var0.attacker isinexecutionattack() && var0.victim isinexecutionvictim()) {
    var1 = 0;
  } else if(isDefined(var0.attacker) && istrue(var0.attacker.isjuggernaut) && var4 && var0.meansofdeath == "MOD_MELEE") {
    var1 = var0.victim.maxhealth / 3;
  } else if(var4 && var0.meansofdeath == "MOD_FALLING") {
    var1 = 0;
  } else if(var4 && isDefined(var0.inflictor) && isDefined(var0.inflictor.streakinfo) && (var0.inflictor.streakinfo.streakname == "toma_strike" || var0.inflictor.streakinfo.streakname == "precision_airstrike" || var0.inflictor.streakinfo.streakname == "manual_turret")) {
    var6 = var0.victim.maxhealth;
    var7 = var0.attacker.maxhealth;
    var1 = var0.damage * int(floor(var6 / var7));
  } else if(level.disable_super_in_turret.school_guards_rpg_shoot_into_windows && var4 && isexplosivedamagemod(var0.meansofdeath) && isDefined(var0.inflictor) && var0.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var1 = 0;
  } else if(var4 && (var0.meansofdeath == "MOD_GRENADE_SPLASH" || var0.meansofdeath == "MOD_EXPLOSIVE" || var0.meansofdeath == "MOD_FIRE") && (var5 == "molotov_mp" || var5 == "thermite_av_mp")) {
    var1 = var0.damage * level.disable_super_in_turret.school_guards_rpg_guys;
  } else if(var2 && !var4 && var0.meansofdeath == "MOD_MELEE") {
    var8 = var0.victim.maxhealth;
    var9 = level.disable_super_in_turret.saveweaponstates;

    if(istrue(var0.victim.isjuggernaut)) {
      var9 = level.disable_super_in_turret.saw_2_angles;
    }

    if(!level.disable_super_in_turret.sat_wait_for_antenna) {
      var8 += var0.victim.br_maxarmorhealth;
    }

    if(istrue(var0.victim.inlaststand)) {
      var8 = level.laststandhealth;
      var9 = level.disable_super_in_turret.saw_2_origin;
    }

    var1 = int(ceil(var8 / var9));
  } else if(var4 && var3 && istrue(var0.victim.ref_1423b)) {
    var1 = 0;
  } else if(var4 && var3 && level.disable_super_in_turret.scn_infil_tango_npc_4_sfx) {
    var1 = 0;
    ref_1424a(var0);
  } else if(var2 && !var4 && var0.meansofdeath == "MOD_IMPACT" && var5 == "rock_mp") {
    var10 = spawnStruct();
    var10.origin = var0.point;
    var0.victim thread scripts\mp\equipment\concussion_grenade::applyconcussion(var10, var0.attacker);
  } else if(var4) {
    var11 = 0.7;
    var12 = scripts\mp\utility\weapon::getweaponrootname(var0.objweapon);
    var13 = weaponclass(var5);
    var14 = scripts\mp\gametypes\br::tutzonetriggerlogic(var0.idflags);

    if(!var14) {
      switch (var13) {
        case "sniper":
          if(var0.shitloc == "head" || var0.shitloc == "helmet") {
            if(scripts\mp\gametypes\br::usefailvehiclemsg(var12)) {
              var1 = int(ceil(level.disable_super_in_turret.sat_wait_for_activated_think * var11));
            } else {
              var1 = level.disable_super_in_turret.sat_wait_for_activated_think;
            }
          }

          break;
        default:
          if(var0.shitloc == "head" || var0.shitloc == "helmet") {
            var15 = getdvarfloat("scr_player_maxhealth", 100);
            var16 = var15;

            if(level.disable_super_in_turret.ref_14061) {
              var16 += scripts\mp\gametypes\br_armor::getdefaultmaxarmorhealth();
            }

            var1 = int(ceil(var1 / var16 * level.disable_super_in_turret.sat_wait_for_activated_think * level.disable_super_in_turret.sat_wait_for_access_card));
          }

          break;
      }
    }

    var17 = "scr_br_gxp_scale_" + var13;
    var18 = 0;

    if(var13 == "spread") {
      var18 = 0.7;
    }

    var19 = getdvarfloat(var17, var18);

    if(var19 != 0) {
      var1 = int(ceil(var1 * var19));
    }

    var20 = "scr_br_gxp_scale_" + var12;
    var18 = 0;

    if(var12 == "iw8_sh_charlie725") {
      var18 = 1.43;
    }

    var21 = getdvarfloat(var20, var18);

    if(var21 != 0) {
      var1 = int(ceil(var1 * var21));
    }

    if(var0.meansofdeath == "MOD_RIFLE_BULLET" || var0.meansofdeath == "MOD_PISTOL_BULLET") {
      var1 = int(ceil(var1 * level.disable_super_in_turret.sceneangles));
    } else if(var0.meansofdeath == "MOD_MELEE") {
      var1 = int(ceil(var1 * level.disable_super_in_turret.school_guards_wake_behavior));
    }
  }

  if(var1 > 0 && var2 && !var4 && var0.attacker isinexecutionattack() && var0.victim isinexecutionvictim()) {
    level.disabled_permanently = gettime();
  }

  return var1;
}

function ref_12604() {
  if(scripts\mp\gametypes\br_public::ref_125ec()) {
    return;
  }

  scripts\mp\gametypes\br::ref_11e23();
}

function droponplayerdeath(var0) {
  if(scripts\mp\gametypes\br_public::ref_125ec()) {
    return true;
  }

  if(level.disable_super_in_turret.spawndomplateflagtestmap) {
    ref_125fc();
  }

  return false;
}

function onplayerkilled(var0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(isDefined(self)) {
    thread ref_131a5();
  }

  if(level.gameended) {
    return;
  }

  var1 = var0.victim;
  var2 = var0.attacker;

  if(!isDefined(var2) || !isPlayer(var2) || !isDefined(var1)) {
    return;
  }

  if(ref_13302(var1, var2, var0.meansofdeath)) {
    thread ref_13662(var1, var1);
  }

  if(istrue(level.disable_super_in_turret.sat_signal_lost_nag) && ref_13300(var1, var2)) {
    thread ref_1365a(var1, var1);
  }

  if(ref_13326(var1, var2)) {
    thread ref_1258b();
  }

  if(ref_13306(var2, var0)) {
    thread ref_12587();
  }

  var3 = var0.hitloc;

  if(isDefined(var3) && var1 scripts\mp\gametypes\br_public::ref_125ec() && (var3 == "head" || var3 == "helmet")) {
    var4 = 0;
    var2 thread scripts\mp\damagefeedback::updatedamagefeedback("hitzombieheadshot", var4, 1);
  }

  if(var1 scripts\mp\gametypes\br_public::ref_125ec()) {
    var5 = var1 gettagorigin("j_spineupper");
    var6 = var1 gettagangles("j_spineupper");
    playFX(level.disable_super_in_turret.sat_setup_access_card_pickup, var5, anglesToForward(var6), anglestoup(var6));
  }

  var1 setscriptablepartstate("skydiveVfx", "default", 0);
}

function ref_131a5() {
  self endon("disconnect");

  if(!scripts\mp\gametypes\br_public::ref_125ec()) {
    return;
  }

  self waittill("spawned");
  scripts\mp\utility\player::_setsuit("iw8_defaultsuit_mp");
}

function ref_13302(var0, var1) {
  if(!ref_13325(var0)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125ec()) {
    return false;
  }

  if(var1 == "MOD_EXECUTION") {
    if(!level.disable_super_in_turret.scavenger_cache_hint && !istrue(self.inlaststand)) {
      return false;
    }
  }

  if(scripts\mp\gametypes\br_gxp_safe_zones::truckdoorleft(self)) {
    return false;
  }

  return true;
}

function ref_13306(var0) {
  if(!level.disable_super_in_turret.scalesitesbyteams) {
    return false;
  }

  if(var0.meansofdeath != "MOD_EXECUTION") {
    return false;
  }

  if(var0.victim scripts\mp\gametypes\br_public::ref_125ec()) {
    return false;
  }

  if(!level.disable_super_in_turret.scavenger_cache_hint && istrue(var0.victim.inlaststand)) {
    return false;
  }

  if(!var0.attacker scripts\mp\gametypes\br_public::ref_125ec()) {
    return false;
  }

  return true;
}

function ref_13662(var0, var1) {
  var2 = spawndogtags();
  ref_13238(var2, var0.origin);

  if(istrue(var0.isjuggernaut)) {
    var3 = 2;
    var4 = getdvarint("scr_br_gxp_numDropJugg", var3);
    var5 = scripts\mp\gametypes\br_pickups::test_ai_anim();

    for(var6 = 1; var6 < var4; var6++) {
      var7 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var5, var0.origin, var0.angles, var0, undefined, undefined, 0);

      if(!isDefined(var7) || var7.origin == (0, 0, 0)) {
        var7.origin = var0.origin;
      }

      var2 = spawndogtags();
      ref_13238(var2, var7.origin);
    }

    return;
  }
}

function ref_13300(var0) {
  if(!ref_13325(var0)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125ec()) {
    if(randomintrange(1, 101) <= level.disable_super_in_turret.sat_signal_shift) {
      return true;
    }
  }

  return false;
}

function ref_1365a(var0, var1) {
  var2 = spawndogtags();
  ref_13238(var2, var0.origin);
}

function ref_13326(var0) {
  if(!ref_13325(var0)) {
    return false;
  }

  if(!scripts\mp\gametypes\br_public::ref_125ec()) {
    return false;
  }

  return true;
}

function ref_1258b() {
  if(!isDefined(level.disable_super_in_turret.sat_wait_for_radar) || level.disable_super_in_turret.sat_wait_for_radar.size <= 0) {
    return;
  }

  self.itemsdropped = 0;
  var0 = [];

  for(var1 = 0; var1 < level.disable_super_in_turret.sat_wait_for_power_think; var1++) {
    if(randomintrange(1, 101) > level.disable_super_in_turret.sat_wait_for_power) {
      continue;
    }

    var2 = randomintrange(0, level.disable_super_in_turret.sat_wait_for_radar.size);
    var3 = level.disable_super_in_turret.sat_wait_for_radar[var2];
    var0 = var3;
  }

  var4 = scripts\mp\gametypes\br_lootcache::ref_11a42(var0, 0);
}

function ref_13325(var0) {
  if(isDefined(var0) && var0 == self) {
    return false;
  }

  if(level.teambased && isDefined(var0) && isDefined(var0.team) && var0.team == self.team) {
    return false;
  }

  if(isDefined(var0) && !isDefined(var0.team) && (var0.classname == "trigger_hurt" || var0.classname == "worldspawn")) {
    return false;
  }

  if(isagent(self) || isagent(var0)) {
    return false;
  }

  return true;
}

function spawndogtags() {
  var0 = 16;
  var1 = undefined;
  var2 = 0;
  var3 = undefined;

  if(level.disable_super_in_turret.ref_12cb1.size > 0) {
    var4 = level.disable_super_in_turret.ref_12cb1.size - 1;
    var1 = level.disable_super_in_turret.ref_12cb1[var4];
    level.disable_super_in_turret.ref_12cb1[var4] = undefined;
    loadoutprimaryaddblueprintattachments(var1);
    var2 = 1;
    var3 = var1.trigger;
    var5 = var1.visuals;
  } else {
    jumpiffalse(level.disable_super_in_turret.ref_12cb0.size >= level.disable_super_in_turret.ref_11b5b) LOC_000000b4;
    var2 = resetdangercircleorigin();
    loadoutprimaryaddblueprintattachments(var2);
    var3 = 1;
    var5 = var2.trigger;
    var5 = var2.visuals;
    goto LOC_00000164;
  }

  LOC_00000164:
    var7 = "any";
  var8 = 0;
  var3 = scripts\mp\gameobjects::createuseobject(var7, var5, var5, (0, 0, var2), undefined, var5);
  var3.ref_133e5 = 1;
  var3.onuse = &onuse;
  var3 scripts\mp\gameobjects::setusetime(var8);
  var3 scripts\mp\gametypes\br_public::timeoutonabandonedcallback();
  var3.inuse = 1;
  var3.lastusedtime = gettime();
  var9 = "" + var3 getentitynumber();
  level.disable_super_in_turret.ref_12cb0[var9] = var3;
  return var3;
}

function ref_13238(var0, var1) {
  var2 = 36;
  var3 = (0, 0, 36);
  var4 = scripts\mp\gametypes\br_public::modifyplayer_damage(var1, 30);
  var5 = var4 + (0, 0, var2);
  var0.curorigin = var5;

  if(level.disable_super_in_turret.ref_13a25) {
    var0.trigger.origin = var5;
  }

  var0.visuals[0].origin = var5;
  var0 scripts\mp\gameobjects::initializetagpathvariables();
  var0.interactteam = "any";
  ref_13378(var0.visuals[0]);
  var0.ownerteam = "neutral";
  var0.trigger triggerenable();

  if(isDefined(var0.objidnum)) {
    if(var0.objidnum != -1) {
      var6 = var0.objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var6, "active");
      scripts\mp\objidpoolmanager::update_objective_position(var6, var4 + var3);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var6, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(var0.objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var0.objidnum, 0);
      var0 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_friendly", "waypoint_dogtags");
      var0 scripts\mp\gameobjects::setvisibleteam("any");
      objective_icon(var0.objidnum, "icon_minimap_soul");
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var0.objidnum);
    }
  }

  playsoundatpos(var5, "mp_killconfirm_tags_drop");
  var0.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
}

function loadoutprimaryaddblueprintattachments(var0) {
  var0.visuals[0] dontinterpolate();
  var0.visuals[0] hide();
  var0.trigger triggerdisable();
  var0.trigger notify("deleted");
  var0 scripts\mp\gameobjects::allowuse("none");
  var0.inuse = 0;
  var0.visuals[0].origin = (0, 0, 0);
  var0.trigger.origin = (0, 0, 0);
  headlessinfilplayers(var0);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var0.objidnum);
}

function resetdangercircleorigin() {
  var0 = undefined;

  foreach(var2 in level.disable_super_in_turret.ref_12cb0) {
    if(!isDefined(var0) || var2.lastusedtime < var0.lastusedtime) {
      var0 = var2;
    }
  }

  return var0;
}

function onuse(var0) {
  thread ref_120a7(var0);
}

function ref_120a7(var0) {
  if(!isDefined(var0)) {
    thread removetags(self);
    return;
  }

  if(!playercanusetags(var0)) {
    return;
  }

  thread removetags(self);
  var0.ref_11f39++;

  if(level.disable_super_in_turret.spawndistancemax) {
    ref_125d4(var0);
  }

  ref_13fdd(var0, "numVaccine", var0.ref_11f39);

  if(isDefined(level.disable_super_in_turret.ref_11b5b) && var0.ref_11f39 >= level.disable_super_in_turret.saw_3_origin) {
    thread ref_12587();
    return;
  }
}

function ref_13378() {
  self hide();

  if(!level.disable_super_in_turret.ref_13a25) {
    self makeusable();
    self setCursorHint("HINT_NOICON");
    self setHintString(&"MP_ZXP/PICKUP");
    self setuseprioritymax();
  }

  foreach(var1 in level.players) {
    ref_12cb2(var1);
  }
}

function headlessinfilplayers(var0) {
  foreach(var2 in level.players) {
    if(!var2 scripts\mp\gametypes\br_public::ref_125ec()) {
      continue;
    }

    var3 = var2 getnodeoffset_code(7);

    if(var3 != -1 && var3 == var0.objidnum) {
      var2 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    }
  }
}

function removetags(var0) {
  loadoutprimaryaddblueprintattachments(var0);
  var1 = "" + var0 getentitynumber();
  level.disable_super_in_turret.ref_12cb0[var1] = undefined;
  level.disable_super_in_turret.ref_12cb1[level.disable_super_in_turret.ref_12cb1.size] = var0;
  playFX(level._effect["ghost_soul_pickup"], var0.curorigin);
  playsoundatpos(var0.curorigin, "br_gov_soul_pickup");
}

function playercanusetags(var0) {
  return var0 scripts\mp\gametypes\br_public::ref_125ec();
}

function ref_125d4() {
  var0 = (0, 1, 0);
  self.spawnboardroom_juggdrop setvalue(self.ref_11f39);
  thread spawn_vindia_assault3(self.spawnboardroom_juggdrop);
  thread spawn_vindia_assault3(self.spawnboardroom_loadoutdrop);
}

function ref_12587(var0) {
  if(!istrue(var0) && !scripts\mp\gametypes\br_public::ref_125ec()) {
    return;
  }

  var1 = scripts\mp\gametypes\br_public::ref_125ec() || istrue(self.ref_14438);

  if(var1) {
    scripts\mp\gametypes\br_gametype_gxp_challenges::ref_11fef(self);
    self.scn_infil_tango_npc_2_sfx = 1;
  }

  ref_1267e(0);
  ref_125ae(0);
  scripts\mp\gametypes\br_gxp_phones::move_to_new_node(self);

  if(isDefined(self.operatorcustomization.gender) && self.operatorcustomization.gender == "female") {
    self method_87aa("female");
  } else {
    self method_87aa("");
  }

  if(isDefined(self.operatorcustomization.clothtype) && self.operatorcustomization.clothtype != "") {
    self setclothtype(self.operatorcustomization.clothtype);
  } else {
    self setclothtype("vestlight");
  }

  self.operatorcustomization = undefined;
  scripts\cp_mp\execution::_clearexecution();
  self.ref_12ca8 = 1;
  var2 = self.origin;
  var3 = self.origin;
  var4 = self getplayerangles();
  var5 = 0;

  if(level.disable_super_in_turret.spawndragonsbreathstruct) {
    var6 = ref_125dd();
    var3 = var6[0];
    var4 = var6[1];
    var2 = var6[2];
    var6 = undefined;
  } else {
    var7 = ref_125de();
    var3 = var7[0];
    var4 = var7[1];
    var5 = var7[2];
    var7 = undefined;
    var2 = var3;
  }

  self.plotarmor = 1;
  self setscriptablepartstate("ghost", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  ref_125aa();

  if(!var5) {
    scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    wait 1;
  } else {
    waitframe();
  }

  scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  self.pers["gamemodeLoadout"] = level.br_respawn_loadout;
  self.pers["class"] = "gamemode";
  self.class = "gamemode";
  self.forcespawnangles = var4;
  self.forcespawnorigin = var2;
  scripts\mp\utility\player::_setsuit("iw8_defaultsuit_mp");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self skydive_deployparachute();
  thread scripts\mp\gametypes\br::defend_wave_2();
  ref_125b3(1);
  self enableexecutionvictim();
  self method_87b2();
  self lerpfovbypreset("default_2seconds");

  if(level.disable_super_in_turret.score_event_accuracy) {
    thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
  }

  if(level.disable_super_in_turret.score_accuracy_think) {
    ref_125da();

    if(!level.disable_super_in_turret.score_event_accuracy) {
      self setscriptablepartstate("headVFX", "neutral");
    }

    self visionsetnakedforplayer("", 0);
  }

  if(level.disable_super_in_turret.spawndragonsbreathstruct) {
    self.plotarmor = undefined;
    ref_126bd(var3, var4, var2);
  } else {
    if(!var5) {
      scripts\mp\gametypes\br_public::ref_126ed();
      scripts\mp\gametypes\br_public::ref_1252b();
      playFX(scripts\engine\utility::getfx("ghost_trans"), self.origin);
      playfxontagforclients(level.disable_super_in_turret.scn_infil_tango_npc_1_sfx, self, "tag_eye", self);
    }

    if(!var5) {
      scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    }

    thread ref_1252c();
  }

  if(istrue(level.disable_super_in_turret.spawndomplateflagtestmap) && ref_125fa()) {
    ref_125fb();
  } else {
    var8 = scripts\mp\gametypes\br::disablealltablets();
    scripts\mp\gametypes\br::searchcircleorigin(var8, 0);
  }

  scripts\mp\gametypes\br_armor::searchcirclesize();
  thread scripts\mp\gametypes\br::defend_wave_2();

  if(level.disable_super_in_turret.score_accuracy_think) {
    move_objective_icon();
  }

  ref_1262b(0);

  if(var1) {
    scripts\mp\hud_message::showsplash("br_gametype_gxp_change_human");
  }

  self.plotarmor = undefined;
  thread ref_125d9();
  self.ref_12ca8 = undefined;

  if(var1) {
    foreach(var10 in level.teamdata[self.team]["players"]) {
      if(self == var10) {
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward("player_into_human", var10);
        continue;
      }

      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("teammate_back_human", var10);
    }
  }

  self.scn_infil_tango_npc_2_sfx = undefined;
}

function move_objective_icon() {
  if(!isDefined(level.disable_super_in_turret.saw_angles)) {
    return;
  }

  level.disable_super_in_turret.saw_angles = scripts\engine\utility::array_removeundefined(level.disable_super_in_turret.saw_angles);

  foreach(var1 in level.disable_super_in_turret.saw_angles) {
    scripts\mp\utility\outline::outlineenableforplayer(self, var1, "outline_depth_zombievision", "top");
  }
}

function spawn_vindia_assault3(var0) {
  self endon("death");

  if(istrue(self.ref_1293b)) {
    return;
  }

  var1 = 0.5;
  var2 = 4;
  self.ref_1293b = 1;
  var3 = self.fontscale;
  var4 = self.color;

  if(isDefined(var0)) {
    self.color = var0;
  }

  self changefontscaleovertime(var1);
  self.fontscale = var2;
  wait var1;
  self changefontscaleovertime(var1);
  self.fontscale = var3;
  wait var1;
  self.color = var4;
  self.ref_1293b = undefined;
}

function ref_125dd() {
  var0 = getdvarint("scr_br_gxp_spawnheightoffset", 3000);
  var1 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
  var2 = scripts\mp\gametypes\br_gulag::ref_125be(0, var1, var0);
  var3 = scripts\mp\gametypes\br_gulag::ref_1263e(var2);
  return [var2.origin, var2.angles, var3];
}

function ref_125de() {
  var0 = ref_125d8();
  var1 = var0[0];
  var2 = var0[1];
  var3 = var0[2];
  var0 = undefined;

  if(!var3) {
    scripts\mp\gametypes\br_public::ref_126b9(var1);
  }

  return [var1, var2, var3];
}

function ref_125aa() {
  ref_125b3(0);
  var0 = gettime() + 3000;

  while(self isgestureplaying() && var0 > gettime()) {
    self stopgestureviewmodel();
    waitframe();
  }

  while(var0 > gettime() && (self isinexecutionattack() || self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]())) {
    waitframe();
  }

  playFX(scripts\engine\utility::getfx("ghost_trans"), self.origin);
  playfxontagforclients(level.disable_super_in_turret.scn_infil_tango_npc_1_sfx, self, "tag_eye", self);
  self notify("endSuperJumpFov");
  self enableoffhandweapons();
  self giveandfireoffhand("gxp_revive_mp");
  wait 1.25;
}

function ref_125b3(var0) {
  self allowfire(var0);
  self allowmovement(var0);
  self allowmelee(var0);

  if(var0) {
    self playershow();
    self enableoffhandweapons();
    return;
  }

  self playerhide();
  self disableoffhandweapons();
}

function ref_1252c() {
  if(!getdvarint("scr_br_gxp_human_spawn_concuss", 0)) {
    return;
  }

  var0 = 650;
  var1 = getdvarint("scr_br_gxp_push_radius", var0);
  var2 = incrementpersistentstat(level.players, self.origin, var1);

  foreach(var4 in var2) {
    if(var4 scripts\mp\gametypes\br_public::ref_125f3() && var4.team != self.team && isalive(var4)) {
      ref_125d7(var4, var1);
    }
  }

  var6 = anglesToForward(self.angles);
  playFX(level.disable_super_in_turret.start_coop_defuse_infiltrate, self.origin, var6);
  playsoundatpos(self.origin, "sentry_explode_smoke");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.5, 1.5, self.origin, var1);
}

function ref_125fc() {
  var0 = spawnStruct();
  var0.ref_12889 = [];
  var0.brtdm_config = [];
  var0.brtruck_cleanupents = [];
  var0.brtruck_ontimelimit = [];
  var0.offhands = [];
  var0.nvidiaansel_overridecollisionradius = [];
  var1 = [];
  var2 = self getweaponslistprimaries();

  foreach(var4 in var2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var4) && !issubstr(var4.basename, "iw8_fists_mp") && !scripts\mp\utility\weapon::unset_relic_mythic(var4.basename)) {
      var1 = var4;
    }
  }

  foreach(var7 in var1) {
    var8 = createheadicon(var7);
    var0.brtdm_config[var8] = weaponclipsize(var7);
    var0.brtruck_ontimelimit[var8] = self getweaponammostock(var7);

    if(scripts\mp\utility\weapon::turnexfiltoside(var7)) {
      var0.brtruck_cleanupents[var8] = self getweaponammoclip(var7, "left");
    }

    if(getsubstr(var8, 0, 4) == "alt_") {
      continue;
    }

    var0.ref_12889[var0.ref_12889.size] = var7;
  }

  if(self.lastcacweaponobj != getcompleteweaponname("none")) {
    foreach(var4 in var0.ref_12889) {
      if(self.lastcacweaponobj == var4) {
        var0.current = self.lastcacweaponobj;
        break;
      }
    }
  }

  var12 = self getweaponslistoffhands();

  foreach(var14 in var12) {
    if(var14.basename == "bandage_br") {
      continue;
    }

    var15 = self getweaponammoclip(var14);

    if(var15 <= 0) {
      continue;
    }

    var0.offhands[var0.offhands.size] = var14;
    var16 = createheadicon(var14);
    var0.brtdm_config[var16] = var15;
  }

  foreach(var19 in self.equipment) {
    var0.nvidiaansel_overridecollisionradius[var19] = var20;
  }

  var0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent) {
    var0.super = self.equipment["super"];
  }

  self.setdeleteable = var0;
}

function ref_125fb() {
  self takeallweapons(0, 1);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  self.equipment["primary"] = undefined;
  self.equipment["secondary"] = undefined;
  self.equipment["health"] = undefined;
  self.equipment["super"] = undefined;
  var0 = getcompleteweaponname("iw8_fists_mp");

  if(self.setdeleteable.ref_12889.size < 2) {
    self giveweapon(var0);
  }

  var1 = 0;

  foreach(var3 in self.setdeleteable.ref_12889) {
    var4 = createheadicon(var3);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var3);

    if(!var1) {
      self assignweaponprimaryslot(var4);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var3);
      var1 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, var4);
  }

  foreach(var7 in self.setdeleteable.offhands) {
    var8 = scripts\mp\equipment::getequipmentreffromweapon(var7);

    if(!isDefined(var8)) {
      continue;
    }

    var9 = self.setdeleteable.nvidiaansel_overridecollisionradius[var8];

    if(!isDefined(var9)) {
      continue;
    }

    scripts\mp\equipment::giveequipment(var8, var9);
  }

  foreach(var4, var12 in self.setdeleteable.brtruck_ontimelimit) {
    self setweaponammostock(var4, var12);
    var3 = getcompleteweaponname(getweaponbasename(var4));
    var13 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var3);

    if(isDefined(var13)) {
      self.br_ammo[var13] = var12;
      scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype(var13);
    }
  }

  foreach(var4, var12 in self.setdeleteable.brtdm_config) {
    self setweaponammoclip(var4, var12);
  }

  foreach(var4, var12 in self.setdeleteable.brtruck_cleanupents) {
    self setweaponammoclip(var4, var12, "left");
  }

  waitframe();
  var16 = var0;

  if(isDefined(self.setdeleteable.current)) {
    var16 = self.setdeleteable.current;
  } else if(isDefined(self.setdeleteable.ref_12889[0])) {
    var16 = self.setdeleteable.ref_12889[0];
  }

  self switchtoweaponimmediate(var16);

  if(isDefined(self.setdeleteable.super)) {
    var17 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self.setdeleteable.super]];
    scripts\mp\gametypes\br_pickups::forcegivesuper(var17, 0);
  }

  thread scripts\cp_mp\gestures::ref_13e1a();
  self.setdeleteable = undefined;
}

function ref_125d9() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_set");

  while(!self isonground()) {
    waitframe();
  }

  thread ref_125db();
}

function ref_125d8() {
  var0 = 500;
  var1 = 10000;
  var2 = 5;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return [self.origin, self getplayerangles(), 1];
  }

  var3 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var4 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var5 = distance2dsquared(self.origin, var4);

  if(var5 <= var3 * var3) {
    return [self.origin, self getplayerangles(), 1];
  }

  var6 = undefined;
  var7 = undefined;
  var8 = (self.origin[0], self.origin[1], 0);
  var9 = vectorNormalize(var8 - var4);

  for(var10 = 1; var10 <= var2; var10++) {
    var11 = var3 - var0 * var10;

    if(var11 < 0) {
      break;
    }

    var12 = remove_marker_when_player_disconnects(var4, var9, var11);
    var6 = var12[0];
    var7 = var12[1];
    var12 = undefined;

    if(isDefined(var6)) {
      break;
    }
  }

  if(!isDefined(var6)) {
    var6 = var4;
    var7 = self getplayerangles();
  }

  var13 = scripts\mp\gametypes\br_public::modifyplayer_damage(var6, var1);
  return [var13, var7, 0];
}

function ref_125db() {
  if(!istrue(level.disable_super_in_turret.spawndomplates)) {
    return;
  }

  thread ref_126b4(level.disable_super_in_turret.human);
}

function remove_marker_when_player_disconnects(var0, var1, var2) {
  var3 = var0 + var1 * var2;
  var4 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;

  if(scripts\mp\gametypes\br_gulag::set_relic_rocket_kill_ammo(var3, var4)) {
    var5 = vectortoangles(var1 * -1);
    return [var3, var5];
  }

  return [undefined, undefined];
}

function ref_125fa() {
  return isDefined(self.setdeleteable);
}

function ref_125d7(var0, var1) {
  var2 = 1800;
  var3 = spawnStruct();
  var3.origin = self.origin;
  var0 thread scripts\mp\equipment\concussion_grenade::applyconcussion(var3, self);
  thread ref_1262e(var0);
  var4 = var0.origin - self.origin;
  var5 = vectortoangles(var4);
  var6 = distance(var0.origin, self.origin);
  var7 = 1 - var6 / var1;
  ref_1250a(var0, var5, var2, var7);
}

function ref_1262e(var0) {
  if(!isDefined(var0)) {
    return;
  }

  self notify("disableCooldown");

  foreach(var3, var2 in var0.powers) {
    if(!isDefined(self.ref_12821[var3])) {
      continue;
    }

    self.ref_12821[var3].incooldown = 0;
    thread ref_1262c(var0, var3);
  }
}

function watch_flight_collision(var0) {
  if(scripts\mp\gametypes\br_public::ref_125ec()) {
    var1 = isDefined(var0.attacker) && nukefridgewatcher(var0.attacker);

    if(!var1 || !level.disable_super_in_turret.scn_infil_tango_npc_5_sfx || level.disable_super_in_turret.scn_infil_tango_npc_4_sfx) {
      return false;
    }

    thread ref_1262e(level.disable_super_in_turret.sat_piece);
    thread ref_125a5();
    thread ref_125b5(var0);
    thread ref_1258a();
  }

  return true;
}

function ref_125a5() {
  level endon("game_ended");
  self endon("last_stand_finished");
  self endon("death_or_disconnect");
  self waittill("last_stand_transition_done");
  waittillframeend();
  self setlaststandenabled(1);
  self.usedprops = 1;
  self.laststandreviveent makeunusable();
  var0 = self.laststandreviveent;
  var0.usetime = getdvarfloat("scr_br_gxp_vehicle_getup", 3) * 1000;

  if(!isDefined(var0.curprogress)) {
    var0.curprogress = 0;
  }

  while(scripts\mp\utility\player::isreallyalive(self) && var0.curprogress < var0.usetime) {
    if(self isinexecutionvictim()) {
      waitframe();
      continue;
    }

    if(!isDefined(var0.userate)) {
      var0.userate = 0;
    }

    var0.curprogress += level.frameduration * var0.userate;
    var0.userate = 1;
    scripts\mp\gameobjects::updateuiprogress(var0, 1);

    if(var0.curprogress >= var0.usetime) {
      break;
    }

    waitframe();
  }

  var0.usetime = undefined;
  var0.curprogress = undefined;
  var0.userate = undefined;
  scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", self);
  self playsoundtoplayer("zmb_breath_land_dropin", self, self);
  self playSound("zmb_npc_breath_land_dropin");
  self setlaststandenabled(0);
}

function ref_125b5(var0) {
  var1 = 500;
  var2 = 90;
  var3 = 60;
  var4 = 30;
  var5 = var0.direction_vec;
  var6 = vectortoyaw(var5);
  var7 = var2;
  var8 = var3;

  if(scripts\engine\utility::cointoss()) {
    var8 *= -1;
  }

  var8 += var6;
  var9 = (var7, var8, 0);
  var10 = vectorNormalize((var5[0], var5[1], 0));
  var11 = var10 * var4 + (0, 0, var4);
  ref_1250a(var9, var1, 1, var11);
}

function ref_1258a() {
  self endon("disconnect");
  self.ref_1423b = 1;
  var0 = getdvarfloat("scr_br_gxp_vehicle_immunity", 1.5);
  wait var0;
  self.ref_1423b = undefined;
}

function ref_1424a(var0) {
  var1 = var0.attacker;
  var2 = var0.victim;
  var3 = var0.direction_vec;
  var3 = -1 * vectorNormalize((var3[0], var3[1], min(var3[2], 0)));
  var4 = var2 getEye();
  var5 = var4 + var3 * 400;
  var5 = chase_hvt_vo(var2, var5, var4, var3, 0, var1);
}

function dangercircletick(var0, var1) {
  if(level.disable_super_in_turret.scn_infil_hackney_heli_npc1 != 1) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.ref_12cb0)) {
    return;
  }

  var2 = var1 + level.disable_super_in_turret.scn_infil_hackney_heli_npc2;
  var3 = var2 * var2;

  foreach(var5 in level.disable_super_in_turret.ref_12cb0) {
    if(isDefined(var5.visuals) && distance2dsquared(var5.origin, var0) >= var3) {
      thread removetags(var5);
    }
  }
}