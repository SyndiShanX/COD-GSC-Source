/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_gxp_ghost.gsc
**********************************************************/

function setchecklistsubversion() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_zxp");
}

function ref_11B16() {
  return false;
}

function ref_11B80(var_0, var_1) {
  var_2 = ref_126D1(var_0, var_1);

  if(scripts\mp\flags::gameflag("prematch_done") && !var_2) {
    scripts\mp\gametypes\br::ref_11B15(var_0);
  }

  return !var_2;
}

function init_relic_nuketimer() {
  var_0 = [];
  GscBinSkip0(0x2e, "loadoutArchetype", "archetype_assault");
}

function ref_12BBA(var_0) {
  if(!isDefined(level.teamdata[var_0]["aliveCountHuman"])) {
    return level.teamdata[var_0]["aliveCount"];
  }

  return level.teamdata[var_0]["aliveCountHuman"];
}

function ref_12536() {
  self endon("disconnect");
  self setscriptablepartstate("ghost", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);

  if(level.disable_super_in_turret.score_accuracy_think) {
    ref_125DA();

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
  ref_1267E(0, 1);
  ref_1262B(0);
}

function ref_1262B(var_0) {
  scripts\mp\gametypes\br_public::ref_125CF(var_0);

  if(var_0) {
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

function kioskfiresaledoneforplayer(var_0, var_1) {
  wait var_1;

  if(isDefined(var_0)) {
    var_0 destroy();
    return;
  }
}

function ref_125DA() {
  foreach(var_1 in level.players) {
    if(!var_1 scripts\mp\gametypes\br_public::ref_125EC()) {
      var_1 hudoutlinedisableforclient(self);
    }
  }
}

function ref_12645() {
  self notify("spawnGhost");
  self method_87aa("ghost");
  self setclothtype("cloth");
  scripts\mp\deathicons::spawn_carriables_from_prefabs_all(self);
}

function ref_1269B(var_0) {
  return scripts\mp\gametypes\br_public::ref_125EC();
}

function ref_1269C(var_0) {
  return scripts\mp\gametypes\br_public::ref_125EC();
}

function ref_126D1(var_0) {
  if(!istrue(var_0)) {
    if(scripts\mp\gametypes\br_public::ref_125EC()) {
      thread ref_12536();
      return false;
    }
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done") || level.gameended || !level.disable_super_in_turret.scale_off_bravo_audio) {
    return false;
  }

  thread ref_125A9(0);
  return true;
}

function ref_125A9(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("ghost_unset");

  if(level.gameended) {
    return;
  }

  if(!isDefined(level.teamdata[self.team]["lastGhostTime"]) && !isDefined(level.ref_12D05)) {}

  ref_131CC(self.team);
  ref_1267C(1);
  ref_125AE(1);
  waittillframeend();

  if(isDefined(self.body)) {
    self.body delete();
  }

  ref_1267E(1);
  scripts\mp\gametypes\br_gxp_phones::loadout_updateglobalclassgamemode(self);
  self.ref_12CA8 = 1;

  if(isDefined(level.ref_12D05)) {
    ref_12645();
  } else if(var_0) {
    ref_126EE();
  } else {
    ref_12645();
  }

  jumpiffalse(scripts\mp\gametypes\br_gametypes::tutorial_showtext("playerGetGhostSpawnLocation")) LOC_000000db;
  var_1 = scripts\mp\gametypes\br_gametypes::ref_12E05("playerGetGhostSpawnLocation");
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_1 = undefined;
  goto LOC_000000f3;
}

function ref_125B4() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  var_0 = 0.5;

  for(;;) {
    var_1 = self getnodeoffset_code(7);
    var_2 = sortbydistance(level.disable_super_in_turret.ref_12CB0, self.origin);
    var_3 = 0;

    foreach(var_5 in var_2) {
      var_6 = undefined;

      if(var_3 < level.disable_super_in_turret.ref_11B76 && level.disable_super_in_turret.ref_11B75 > 0) {
        var_6 = distance2dsquared(self.origin, var_5.origin);
      }

      if(var_3 < level.disable_super_in_turret.ref_11B76 && (level.disable_super_in_turret.ref_11B75 == 0 || var_6 < level.disable_super_in_turret.ref_11B75)) {
        var_3++;
        scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(var_5.objidnum, self);
        continue;
      }

      var_3 = level.disable_super_in_turret.ref_11B76;
      scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_5.objidnum, self);

      if(var_1 != -1 && var_1 == var_5.objidnum) {
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
      }
    }

    wait var_0;
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
    ref_1259B();
  }

  waitframe();

  if(getdvarint("scr_br_gxp_loop_zombie_fx", 0)) {
    self setscriptablepartstate("ghost", "on_loop");
    return;
  }

  self setscriptablepartstate("ghost", "on");
}

function ref_1259B() {
  foreach(var_1 in level.players) {
    if(!var_1 scripts\mp\gametypes\br_public::ref_125EC()) {
      scripts\mp\utility\outline::outlineenableforplayer(var_1, self, "outline_depth_zombievision", "top");
    }
  }
}

function ref_12595() {
  level endon("game_ended");
  self endon("ghost_unset");
  self endon("disconnect");
  self.sat_wait_for_connection_think = undefined;

  for(;;) {
    if(ref_1259C()) {
      if(!isDefined(self.sat_wait_for_connection_think) || !self.sat_wait_for_connection_think) {
        self.sat_wait_for_connection_think = 1;
        ref_1258D();
      }
    } else if(!isDefined(self.sat_wait_for_connection_think) || self.sat_wait_for_connection_think) {
      self.sat_wait_for_connection_think = 0;
      ref_1258E();
    }

    waitframe();
  }
}

function ref_1259C() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return false;
  }

  var_0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_1 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  return distance2dsquared(var_0, self.origin) > var_1 * var_1;
}

function ref_1258D() {
  self notify("ghost_enter_gas");
  self unsetperk("specialty_radarblip", 1);
}

function ref_1258E() {
  self notify("ghost_exit_gas");

  if(level.disable_super_in_turret.saw_4_angles >= 0) {
    if(level.disable_super_in_turret.saw_4_angles == 0) {
      self setperk("specialty_radarblip", 1);
      return;
    }

    thread ref_125A6();
    return;
  }
}

function ref_125A6() {
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

function ref_125AB() {
  self endon("disconnect");
  self.ref_133E9 = 1;
  self.radarmode = "normal_radar";
  self.hasradar = 1;
  self waittill("ghost_unset");
  self.ref_133E9 = undefined;
  self.hasradar = 0;
}

function ref_125AF() {
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

function ref_12599(var_0) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  wait 1;

  while(!self isonground()) {
    ref_125B8(var_0);
    waitframe();
  }

  self setclientomnvar("ui_br_altimeter_state", 0);
  self skydive_interrupt();
  playFXOnTag(level._effect["zombie_splat"], self, "j_mainroot");
  self playsoundtoplayer("br_gov_ghost_infil_land", self, self);
  self playSound("br_gov_ghost_infil_land_npc", self, self);
  self freezecontrols(1);
  var_1 = gettime() + 2000;

  while(self getcurrentprimaryweapon().classname == "none" && gettime() < var_1) {
    ref_125B8(var_0);
    waitframe();
  }

  var_2 = propwaitminigameinit(self, 0);

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 1);
  }

  var_3 = anglesToForward(self.angles);
  var_4 = vectortoangles(var_2);
  var_5 = angleclamp180(var_4[0] + 90);
  var_4 = (0, var_4[1], 0);
  var_6 = anglesToForward(var_4);
  var_7 = vectordot(var_6, var_3);
  var_8 = var_7 * var_5;
  var_9 = getdvarint("scr_br_gxp_zombie_splat_down_clamp", 20);
  var_10 = getdvarint("scr_br_gxp_zombie_splat_up_clamp", -70);

  if(var_8 > 0) {
    var_8 = min(var_9, var_8);
  } else {
    var_8 = max(var_10, var_8);
  }

  self setplayerangles((var_8, self.angles[1], 0));

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
  ref_125B8(var_0);
  self allowsprint(1);
  thread ref_125A7();
}

function ref_125A7() {
  if(!level.disable_super_in_turret.saw_head_icon) {
    return;
  }

  thread ref_126B4(level.disable_super_in_turret.sat_piece);
}

function ref_126B4(var_0) {
  self notifyonplayercommand("ghostAttack", "+attack");
  self notifyonplayercommand("ghostAttack", "+melee_zoom");
  thread ref_12596();
  thread ref_12637(var_0);
  thread ref_12634(var_0);
  thread ref_12635(var_0);

  if(level.disable_super_in_turret.spawndistancemax) {
    thread ref_1263A(var_0);
  }

  thread ref_12638(var_0);
  thread ref_12630(var_0);

  foreach(var_2 in var_0.powers) {
    if(isDefined(var_0.powers[var_3].ref_1388F)) {
      ref_13FDD(var_0.powers[var_3].ref_1388F, 2);
    }
  }
}

function ref_13FDD(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  switch (var_0) {
    case "jumpStatus":
      var_2 = 0;
      var_3 = 2;
      break;
    case "jumpProgress":
      var_2 = 2;
      var_3 = 7;
      break;
    case "spectralBlastStatus":
      var_2 = 9;
      var_3 = 2;
      break;
    case "spectralBlastProgress":
      var_2 = 11;
      var_3 = 7;
      break;
    case "teleportStatus":
      var_2 = 18;
      var_3 = 2;
      break;
    case "teleportProgress":
      var_2 = 20;
      var_3 = 7;
      break;
    case "numVaccine":
      var_2 = 27;
      var_3 = 2;
      break;
    case "inSafeZone":
      var_2 = 29;
      var_3 = 1;
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

  var_4 = int(pow(2, var_3)) - 1;
  var_5 = (int(var_1) &var_4) << var_2;
  var_6 = ~(var_4 << var_2);
  var_7 = self calloutmarkerping_entityzoffset("ui_br_zombie_powers");
  var_8 = var_7 &var_6;
  var_9 = var_8 + var_5;
  level.saw_fallback_positions["ui_br_zombie_powers"] = var_9;
  self setclientomnvar("ui_br_zombie_powers", level.saw_fallback_positions["ui_br_zombie_powers"]);
}

function ref_12630(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::ref_143A6("death", "ghost_unset", "ghost_set");
  self notifyonplayercommandremove("ghostAttack", "+attack");
  self notifyonplayercommandremove("ghostAttack", "+melee_zoom");
  thread ref_1262D(var_0);
  thread ref_12632(var_0);
  thread ref_12633(var_0);
  thread ref_12631(var_0);
}

function ref_12631(var_0) {
  if(!isDefined(self.ref_12821)) {
    return;
  }

  if(level.disable_super_in_turret.spawndistancemax) {
    foreach(var_2 in self.ref_12821) {
      if(isDefined(var_2)) {
        if(isDefined(var_2.choppergunner_refillmissiles)) {
          var_2.choppergunner_refillmissiles scripts\mp\hud_util::destroyelem();
        }

        var_2 destroy();
      }
    }
  }

  self.ref_12821 = undefined;
}

function ref_12632(var_0) {
  if(isbot(self)) {
    return;
  }

  foreach(var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked) {
      self notifyonplayercommandremove(var_6, var_4);
    }
  }
}

function ref_12633(var_0) {
  foreach(var_2 in var_0.powers) {
    if(isDefined(var_2.has_ammo_drain_passive)) {
      self thread[[var_2.has_ammo_drain_passive]](var_0, var_3);
    }
  }
}

function ref_1262D(var_0) {
  if(!isDefined(var_0) || !isDefined(self.ref_12821)) {
    return;
  }

  self notify("disableCooldown");

  foreach(var_3, var_2 in var_0.powers) {
    if(!isDefined(self.ref_12821[var_3])) {
      continue;
    }

    self.ref_12821[var_3].incooldown = 0;

    if(level.disable_super_in_turret.spawndistancemax) {
      self.ref_12821[var_3].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0, 0);
    } else {
      self.ref_12821[var_3].frac = 0;
    }

    thread ref_12639(var_0, var_3);
  }

  self.laststandattackermodifiers = undefined;
  self.vehicle_occupancy_mp_hidecashbag = undefined;
}

function ref_12639(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("ghost_set");
  self endon("disableCooldown");

  if(!isDefined(self.ref_12821[var_1]) || istrue(self.ref_12821[var_1].incooldown)) {
    return;
  }

  var_2 = self.ref_12821[var_1];

  if(level.disable_super_in_turret.ref_12820 && var_2.frac > 0) {
    self.ref_12821[var_1].incooldown = 1;
    var_3 = var_0.powers[var_1].idmask;
    var_4 = "scr_br_gxp_power_cooldown_" + var_1;

    if(getdvarint(var_4, 0) != 0) {
      var_3 = getdvarint(var_4, 0);
    }

    thread ref_126DE(var_0, var_1, var_3, int(var_2.frac * 100));
    var_5 = var_2.frac;
    var_3 *= var_5;

    if(level.disable_super_in_turret.spawndistancemax) {
      var_2.choppergunner_refillmissiles.bar.color = (1, 0.6, 0);
      var_2.choppergunner_refillmissiles.bar scaleovertime(var_3, 0, var_2.choppergunner_refillmissiles.height);
    }

    wait var_3;

    if(var_1 == "spectralBlast") {
      var_6 = "ui_zxp_restock_emp";
    } else if(var_2 == "teleport") {
      var_6 = "ui_zxp_recharge_tport";
    } else {
      var_6 = "ui_zxp_restock_" + var_3;
    }

    self playlocalsound(var_6);
    self.ref_12821[var_3].incooldown = 0;
  } else {
    if(level.disable_super_in_turret.spawndistancemax) {
      var_4.choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0, 0);
    } else {
      var_4.frac = 0;
    }

    thread ref_126DE(var_2, var_3, 0, 0);
  }

  if(level.disable_super_in_turret.spawndistancemax) {
    var_4.choppergunner_refillmissiles.bar.color = (1, 1, 1);
  }

  if(isDefined(var_2.powers[var_3].ref_127FC)) {
    self[[var_2.powers[var_3].ref_127FC]](var_2, var_3);
    return;
  }
}

function ref_126DE(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("ghost_set");
  self endon("disableCooldown");

  if(!isDefined(var_0.powers[var_1].ref_1388F) || !isDefined(var_0.powers[var_1].ref_128BE)) {
    return;
  }

  ref_13FDD(var_0.powers[var_1].ref_1388F, 1);
  var_4 = var_2 * 1000 * var_3 / 100;
  var_5 = gettime();
  var_6 = var_5 + var_4;

  while(gettime() < var_6) {
    var_7 = gettime();
    var_8 = (var_6 - gettime()) / var_4;
    var_9 = var_8 * var_3;
    ref_13FDD(var_0.powers[var_1].ref_128BE, int(var_9));
    waitframe();
  }

  ref_13FDD(var_0.powers[var_1].ref_128BE, 0);
  ref_13FDD(var_0.powers[var_1].ref_1388F, 2);
}

function ref_12638(var_0) {
  foreach(var_2 in var_0.powers) {
    if(isDefined(var_2.ref_1387B)) {
      self thread[[var_2.ref_1387B]](var_0, var_3);
    }
  }
}

function ref_1263A(var_0) {
  level endon("game_ended");
  self endon("ghost_unset");
  self endon("ghost_set");
  self endon("death_or_disconnect");

  if(isbot(self)) {
    return;
  }

  waittillframeend();
  var_1 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    var_2 = scripts\engine\utility::is_player_gamepad_enabled();

    if(var_2 != var_1) {
      var_1 = var_2;
      jumpiffalse(var_2) LOC_00000091;

      foreach(var_5, var_4 in var_0.powers) {
        if(isDefined(var_4.waitforstreamsynccomplete)) {
          self.ref_12821[var_5].label = var_4.label;
        }
      }

      goto LOC_000000db;
    }

    waitframe();
  }
}

function ref_12635(var_0) {
  foreach(var_2 in var_0.powers) {
    thread ref_12636(var_0, var_3);
  }
}

function ref_12636(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("ghost_set");
  level endon("game_ended");

  for(;;) {
    self waittill(var_1);
    waittillframeend();

    if(isDefined(self.ref_12821[var_1]) && self.ref_12821[var_1].incooldown) {
      ref_12614();
      continue;
    }

    if(self isinexecutionattack()) {
      continue;
    }

    self thread[[var_0.powers[var_1].func]](var_0, var_1);
  }
}

function ref_12614() {
  if(!isDefined(self.laststandattackermodifiers) || gettime() > self.laststandattackermodifiers) {
    self playlocalsound("br_pickup_deny");
    self.laststandattackermodifiers = gettime() + 1000;
    return;
  }
}

function ref_12634(var_0) {
  var_1 = 200;
  var_2 = 18;
  var_3 = var_1;
  self.ref_12821 = [];

  foreach(var_6, var_5 in var_0.powers) {
    if(isDefined(var_5.label)) {
      if(level.disable_super_in_turret.spawndistancemax) {
        self.ref_12821[var_6] = ref_1262F(var_5.label, var_5.waitforstreamsynccomplete, var_3, var_5.ref_13060);
      } else {
        self.ref_12821[var_6] = spawnStruct();
        self.ref_12821[var_6].frac = 0;
      }

      self.ref_12821[var_6].incooldown = 0;
      var_3 += var_2;
    }
  }
}

function ref_1262F(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var_4.x = 15;
  var_4.y = var_2;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.horzalign = "left_adjustable";
  var_4.vertalign = "top_adjustable";
  var_4.alpha = var_3;
  var_4.glowalpha = 0;
  var_4.hidewheninmenu = 1;
  var_4.archived = 0;

  if(isDefined(var_1) && !scripts\engine\utility::is_player_gamepad_enabled()) {
    var_4.label = var_1;
  } else if(isDefined(var_0)) {
    var_4.label = var_0;
  }

  var_5 = scripts\mp\hud_util::createbar((1, 1, 1), 160, 14);
  var_5.x = 13;
  var_5.y = var_2;
  var_5.alignx = "left";
  var_5.aligny = "top";
  var_5.horzalign = "left_adjustable";
  var_5.vertalign = "top_adjustable";
  var_5.alpha = var_3;
  ref_132A8(var_5);
  var_5.archived = 0;
  var_5.hidewheninmenu = 1;
  var_5.bar.archived = 0;
  var_5.bar.hidewheninmenu = 1;
  var_5.bar.alpha = var_3;
  var_4.choppergunner_refillmissiles = var_5;
  return var_4;
}

function ref_132A8(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y + 2;
  self.bar.x = self.x + 2;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

function ref_12637(var_0) {
  if(isbot(self)) {
    return;
  }

  foreach(var_2 in var_0.powers) {
    foreach(var_4 in var_2.clients_hacked) {
      self notifyonplayercommand(var_6, var_4);
    }
  }
}

function propwaitminigameinit(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_2 = self;
  } else {
    var_2 = var_1;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = [var_2];
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

function ref_125B8(var_0) {
  if(!self hasweapon(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  }

  if(self getcurrentprimaryweapon().classname == "none") {
    thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0);
    return;
  }
}

function ref_126BD(var_0, var_1, var_2) {
  scripts\mp\gametypes\br_gulag::ref_126C3(var_2, var_1);
  var_3 = spawn("script_model", var_2);
  var_3 setModel("tag_origin");
  var_3.angles = var_1;
  var_3 hide();
  var_3 showtoplayer(self);
  self playerlinktoabsolute(var_3, "tag_origin");
  self playerhide();
  thread scripts\mp\gametypes\br_gulag::ref_12524(var_3);
  waitframe();
  scripts\mp\gametypes\br_public::ref_126ED();
  scripts\mp\gametypes\br_public::ref_1252B();
  var_3.origin = var_0;
  waitframe();
  self unlink();
  self clearsoundsubmix("deaths_door_mp");
  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  self clearclienttriggeraudiozone(1);
  self playershow();
  var_4 = 0;

  if(isDefined(level.ref_121CC)) {
    var_4 = level.ref_121CC;
  }

  thread scripts\cp_mp\parachute::startfreefall(var_4, 0, undefined, undefined, 1);
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_show_spectateHud", -1);
  scripts\mp\gametypes\br_gulag::ref_12C7A();
  wait 0.5;
  scripts\mp\gametypes\br_gulag::gulagfadefromblack();
  waitframe();
  var_3 delete();
  self notify("can_show_splashes");
}

function ref_125A8(var_0, var_1) {
  var_2 = var_0;

  if(level.disable_super_in_turret.scn_infil_hackney_heli_npc4) {
    var_3 = getdvarint("scr_br_gxp_respawnGhostHeight", 10000);
    var_4 = (0, 0, var_3);
    var_0 = scripts\mp\gametypes\br::getoffsetspawnorigin(var_0, var_4);
    var_5 = spawnStruct();
    var_5.origin = var_0;
    var_5.angles = var_1;
    var_5.height = var_3;
    var_2 = scripts\mp\gametypes\br_gulag::ref_1263E(var_5);
  } else {
    self calloutmarkerping_getinventoryslot(0);
    scripts\mp\gametypes\br_public::ref_126B9(var_2);
  }

  return [var_0, var_2];
}

function ref_12569() {
  var_0 = 50;
  var_1 = 10000;
  var_2 = ref_12597();
  var_3 = var_2[0];
  var_4 = var_2[1];
  var_2 = undefined;

  if(isDefined(var_3)) {
    return [var_3, var_4];
  }

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.disable_super_in_turret.scn_infil_hackney_heli_npc3)) {
    return [self.origin, self getplayerangles()];
  }

  var_5 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_6 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_7 = var_5 + var_0;
  var_8 = (self.origin[0], self.origin[1], 0);
  var_9 = vectorNormalize(var_8 - var_6);
  var_10 = run_track_enemy_patrollers(var_6, var_9, var_7);
  var_11 = var_10[0];
  var_4 = var_10[1];
  var_10 = undefined;

  if(!isDefined(var_11)) {
    var_9 *= -1;
    var_12 = run_track_enemy_patrollers(var_6, var_9, var_7);
    var_11 = var_12[0];
    var_4 = var_12[1];
    var_12 = undefined;
  }

  if(!isDefined(var_11)) {
    var_9 = (1, 0, 0);
    var_13 = run_track_enemy_patrollers(var_6, var_9, var_7);
    var_11 = var_13[0];
    var_4 = var_13[1];
    var_13 = undefined;
  }

  if(!isDefined(var_11)) {
    var_9 = (-1, 0, 0);
    var_14 = run_track_enemy_patrollers(var_6, var_9, var_7);
    var_11 = var_14[0];
    var_4 = var_14[1];
    var_14 = undefined;
  }

  if(!isDefined(var_11)) {
    var_9 = (0, 1, 0);
    var_15 = run_track_enemy_patrollers(var_6, var_9, var_7);
    var_11 = var_15[0];
    var_4 = var_15[1];
    var_15 = undefined;
  }

  if(!isDefined(var_11)) {
    var_9 = (0, -1, 0);
    var_16 = run_track_enemy_patrollers(var_6, var_9, var_7);
    var_11 = var_16[0];
    var_4 = var_16[1];
    var_16 = undefined;
  }

  if(!isDefined(var_11)) {
    var_11 = self.origin;
    var_4 = self.angles;
  }

  var_3 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_11, var_1);
  return [var_3, var_4];
}

function run_track_enemy_patrollers(var_0, var_1, var_2) {
  var_3 = var_0 + var_1 * var_2;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_3, 1)) {
    var_4 = vectortoangles(var_1 * -1);
    return [var_3, var_4];
  }

  return [undefined, undefined];
}

function ref_12597() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = getdvarfloat("scr_br_gxp_respawnTeamOffset", 10000);

  if(var_2 >= 0) {
    var_3 = scripts\mp\gametypes\br_gulag::ref_12568(0);

    if(isDefined(var_3)) {
      var_0 = rocket_fuel_stability(var_3.origin, var_2);
      var_0 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_0);
      var_1 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck(var_0, var_3.origin);
    }
  }

  return [var_0, var_1];
}

function rocket_fuel_stability(var_0, var_1) {
  var_2 = 3.14159;
  var_3 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
  var_4 = vectorNormalize(var_0 - var_3);
  var_5 = vectortoangles(var_4);
  var_6 = randomfloatrange(getdvarfloat("scr_br_respawn_rand_ang_min", 10), getdvarfloat("scr_br_respawn_rand_ang_max", 60));
  var_7 = var_4;
  var_8 = var_0 + var_7 * var_1;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_8, 0)) {
    return var_8;
  }

  var_7 *= -1;
  var_8 = var_0 + var_7 * var_1;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_8, 0)) {
    return var_8;
  }

  var_7 = vectorNormalize(var_3 - var_0);
  var_8 = var_0 + var_7 * var_1;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_8, 0)) {
    return var_8;
  }

  var_9 = var_1;
  var_10 = distance2d(var_0, var_3);
  var_11 = var_9 / var_10;

  if(var_11 > var_2) {
    var_11 = var_2;
  }

  var_12 = var_11 * 180 / var_2;
  var_8 = rotatepointaroundvector((0, 0, 1), var_0 - var_3, var_12) + var_3;

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_8, 0)) {
    return var_8;
  }

  var_8 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_0, var_1);

  if(scripts\mp\gametypes\br_c130::ispointinbounds(var_8, 0)) {
    return var_8;
  }

  return undefined;
}

function ref_126EE() {
  if(scripts\mp\gametypes\br_public::ref_125EC()) {
    self waittill("spawnGhost");
    return;
  }
}

function ref_1267C(var_0) {
  self.tut_loot = var_0;
}

function ref_1267F(var_0) {
  if(istrue(var_0)) {
    self.game_extrainfo |= 4096;
    return;
  }

  self.game_extrainfo &= ~4096;
}

function ref_126E6(var_0) {
  foreach(var_2 in level.disable_super_in_turret.ref_12CB0) {
    if(isDefined(var_2.visuals[0])) {
      ref_12CB2(var_2.visuals[0], self);
    }
  }
}

function ref_12CB2(var_0) {
  if(var_0 scripts\mp\gametypes\br_public::ref_125EC()) {
    self showtoplayer(var_0);

    if(!level.disable_super_in_turret.ref_13A25) {
      self enableplayeruse(var_0);
      return;
    }

    return;
  }

  self hidefromplayer(var_0);

  if(!level.disable_super_in_turret.ref_13A25) {
    self disableplayeruse(var_0);
    return;
  }
}

function ref_125CE() {
  foreach(var_1 in level.disable_super_in_turret.ref_12CB0) {
    scripts\mp\objidpoolmanager::objective_playermask_hidefrom(var_1.objidnum, self);
  }
}

function ref_1267E(var_0, var_1) {
  self.unset_relic_gun_game = var_0;

  if(!isDefined(level.disable_super_in_turret.saw_angles)) {
    level.disable_super_in_turret.saw_angles = [];
  }

  ref_1267F(var_0);

  if(isDefined(level.disable_super_in_turret.ref_11B5B)) {
    ref_126E6(var_0);
  }

  if(var_0) {
    self notify("ghost_set");

    if(level.disable_super_in_turret.spawndistancemax) {
      ref_125AC();
    }

    self.ref_11F39 = 0;
    self.bcdisabled = 1;
    self.plunderlimit = 1;
    ref_1267C(0);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(9);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(10);
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(11);
    level.disable_super_in_turret.saw_angles[level.disable_super_in_turret.saw_angles.size] = self;
    ref_13FDD("numVaccine", self.ref_11F39);
  } else {
    self notify("ghost_unset");
    self.ref_11F39 = undefined;
    self.bcdisabled = undefined;
    self.plunderlimit = undefined;
    scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);

    if(isDefined(level.disable_super_in_turret.ref_11B5B)) {
      ref_125CE();
    }

    level.disable_super_in_turret.saw_angles = scripts\engine\utility::array_remove(level.disable_super_in_turret.saw_angles, self);
  }

  level notify("players_remaining_changed");
  self notify("stop_battlechatter");

  if(istrue(var_1)) {
    self lerpfovbypreset("default");

    if(level.disable_super_in_turret.score_event_accuracy) {
      thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
      return;
    }

    return;
  }
}

function ref_125AC() {
  var_0 = -60;
  var_1 = 120;
  var_2 = 180;
  self.spawnboardroom_juggdrop = ref_12530(var_0, var_1, "right", "middle", "center", "middle", &"MP_ZXP/NUM_CONSUMED", 0);
  self.spawnboardroom_loadoutdrop = ref_12530(var_0, var_1, "left", "middle", "center", "middle", &"MP_ZXP/NUM_TO_CONSUME", level.disable_super_in_turret.saw_3_origin);
  self.spawn_wheelson_redroom = ref_12530(0, var_2, "center", "middle", "center", "middle", &"MP_ZXP/ZOMBIE");
}

function ref_12530(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\mp\hud_util::createfontstring("default", 1.5);
  var_8.x = var_0;
  var_8.y = var_1;
  var_8.alignx = var_2;
  var_8.aligny = var_3;
  var_8.horzalign = var_4;
  var_8.vertalign = var_5;
  var_8.alpha = 0;
  var_8.glowalpha = 0;
  var_8.hidewheninmenu = 1;
  var_8.archived = 0;

  if(isDefined(var_6)) {
    var_8.label = var_6;
  }

  if(isDefined(var_7)) {
    var_8 setvalue(var_7);
  }

  return var_8;
}

function ref_125AE(var_0) {
  var_1 = self.team;
  scripts\mp\utility\teams::ref_140C9("mode", var_1, self);
  ref_126D8();

  if(istrue(var_0)) {
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

  var_0 = 1000;

  if(isDefined(level.disabled_permanently) && level.disabled_permanently + var_0 > gettime()) {
    wait 1;
  }

  var_1 = 0;
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.teamnamelist) {
    var_6 = level.teamdata[var_5]["teamCount"];

    if(var_6 > 0) {
      if(isDefined(level.teamdata[var_5]["aliveCountHuman"]) && level.teamdata[var_5]["aliveCountHuman"] > 0) {
        if((level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto || level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback == 0) && var_3.size > 0) {
          return;
        }

        var_3 = var_5;
        var_1 += level.teamdata[var_5]["aliveCountHuman"];
        continue;
      }

      if(level.teamdata[var_5]["aliveCount"] > 0) {
        var_2 = var_5;
      }
    }
  }

  if(var_3.size > 1) {
    return;
  }

  var_8 = scripts\mp\utility\script::quicksort(var_2, &ref_134D5);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    var_5 = var_8[var_9];
    var_10 = var_9 + 2;
    thread scripts\mp\gametypes\br::ref_1209B(var_5, var_10, 0, 1);
    var_11 = scripts\mp\utility\teams::getfriendlyplayers(var_5);

    foreach(var_13 in var_11) {
      var_13 scripts\cp_mp\utility\game_utility::ref_13168(var_10);

      if(isalive(var_13)) {
        var_13 setscriptablepartstate("ghost", "off");
        var_13 playerhide();
      }
    }
  }

  var_15 = var_3[0];

  foreach(var_13 in level.players) {
    if(var_13 scripts\mp\gametypes\br_public::ref_125EC()) {
      if(var_13.team != var_15) {
        var_13 allowmovement(0);
        var_13 allowmelee(0);
      }

      if(var_13 scripts\mp\utility\perk::_hasperk("specialty_tracker")) {
        var_13 scripts\mp\utility\perk::removeperk("specialty_tracker");
      }
    }

    var_13.setcheckliststateforteam = 1;
  }

  thread scripts\mp\gamelogic::endgame(var_15, game["end_reason"]["enemies_eliminated"]);
}

function ref_12810() {
  thread ref_12811();
}

function ref_131CC(var_0) {
  level.teamdata[var_0]["lastGhostTime"] = gettime();
}

function ref_134D5(var_0, var_1) {
  var_2 = level.teamdata[var_0]["lastGhostTime"];
  var_3 = level.teamdata[var_1]["lastGhostTime"];
  return var_2 >= var_3;
}

function ref_1365D(var_0) {
  if(istrue(var_0.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done") && var_0 scripts\mp\gametypes\br_public::ref_125EC()) {
    ref_12645(var_0);
    return true;
  }

  return false;
}

function addtoteamlives(var_0, var_1) {
  ref_126D8(var_0);
}

function removefromteamlives(var_0, var_1) {
  ref_126D8(var_0);
}

function ref_126D8() {
  var_0 = self.team;
  level.teamdata[var_0]["aliveCountHuman"] = 0;

  foreach(var_2 in level.teamdata[var_0]["alivePlayers"]) {
    if(!var_2 scripts\mp\gametypes\br_public::ref_125EC() && !ref_125E8(var_2)) {
      level.teamdata[var_0]["aliveCountHuman"]++;
    }
  }
}

function ref_125E8() {
  return istrue(self.tut_loot);
}

function ref_13247() {
  if(!level.disable_super_in_turret.saw_head_icon) {
    return;
  }

  level.disable_super_in_turret.sat_piece = spawnStruct();
  level.disable_super_in_turret.sat_piece.powers = [];
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "jump", ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"], &ref_1259E, 0, undefined, &ref_125A0, undefined, &"MP_GXP/CHARGED_JUMP", undefined, 6, "jumpStatus", "jumpProgress");
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "jumpStop", ["-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible"], &ref_125A3, 0);
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "teleport", "+smoke", &ref_125B0, 0, undefined, undefined, undefined, &"MP_GXP/TELEPORT", undefined, 15, "teleportStatus", "teleportProgress");
  battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "spectralBlast", "+frag", &ref_125AD, 0, undefined, undefined, undefined, &"MP_GXP/SCREAM", undefined, 15, "spectralBlastStatus", "spectralBlastProgress");

  if(getdvarint("scr_br_gxp_bumper_ping_support", 1)) {
    battlepassxpmultipliers(level.disable_super_in_turret.sat_piece, "gas_or_emp", ["+equip_toggle_throw"], &ref_125B1, 0, undefined, &ref_125B2);
    return;
  }
}

function battlepassxpmultipliers(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = "scr_br_gxp_power_" + var_1;

  if(getdvarint(var_13, 1) == 0) {
    return;
  }

  if(isstring(var_2)) {
    var_2 = [var_2];
  }

  var_0.powers[var_1] = spawnStruct();
  var_0.powers[var_1].clients_hacked = var_2;
  var_0.powers[var_1].func = var_3;
  var_0.powers[var_1].ref_1387B = var_5;
  var_0.powers[var_1].has_ammo_drain_passive = var_6;
  var_0.powers[var_1].ref_127FC = var_7;
  var_0.powers[var_1].label = var_8;
  var_0.powers[var_1].waitforstreamsynccomplete = var_9;
  var_0.powers[var_1].idmask = var_10;
  var_0.powers[var_1].ref_1388F = var_11;
  var_0.powers[var_1].ref_128BE = var_12;
  var_0.powers[var_1].ref_13060 = var_4;
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

function ref_1259E(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("playerGhostJumpStop");
  var_2 = -1;

  if(ref_1259F()) {
    ref_12614();
    return;
  }

  var_3 = getdvarfloat("scr_br_gpx_powers_jump_charge_rate", 1);
  var_4 = getdvarfloat("scr_br_gxp_powers_jump_min_frac", 0.25);
  var_5 = getdvarint("scr_br_gxp_powers_jump_max_hold_time", var_2);
  var_6 = var_3 * level.framedurationseconds;
  self.vehicle_occupancy_monitormovementcontrols = 0;
  self allowmelee(0);
  self disableoffhandweapons();
  self.scn_infil_tango_npc_0_sfx = 1;

  while(self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback()) {
    waitframe();
  }

  thread ref_12598();
  thread ref_13982();
  var_7 = undefined;
  var_8 = 0;

  if(!isDefined(self.vehicle_occupancy_mp_hidecashbag) || gettime() > self.vehicle_occupancy_mp_hidecashbag) {
    self playlocalsound("ui_zxp_charge_jump_start");
    self.vehicle_occupancy_mp_hidecashbag = gettime() + 500;
  }

  jumpiffalse(isDefined(var_0.powers[var_1].ref_1388F)) LOC_00000109;
  ref_13FDD(var_0.powers[var_1].ref_1388F, 0);

  while(!ref_1259F()) {
    if(level.disable_super_in_turret.spawndistancemax) {
      self.ref_12821[var_1].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(self.vehicle_occupancy_monitormovementcontrols, 0);
    } else {
      self.ref_12821[var_1].frac = self.vehicle_occupancy_monitormovementcontrols;
    }

    var_9 = self.vehicle_occupancy_monitormovementcontrols;
    self.vehicle_occupancy_monitormovementcontrols += var_6;

    if(self.vehicle_occupancy_monitormovementcontrols >= 1) {
      self.vehicle_occupancy_monitormovementcontrols = 1;

      if(var_5 >= 0) {
        if(!isDefined(var_7)) {
          var_7 = gettime() + var_5 * 1000;

          if(level.disable_super_in_turret.spawndistancemax) {
            thread ref_125A2(var_1, var_5);
          }
        }

        if(gettime() >= var_7) {
          break;
        }
      }
    }

    if(level.disable_super_in_turret.spawndistancemax && var_9 < var_4 && self.vehicle_occupancy_monitormovementcontrols >= var_4) {
      self.ref_12821[var_1].choppergunner_refillmissiles.bar.color = (0, 1, 0);
    }

    if(var_9 < 1 && self.vehicle_occupancy_monitormovementcontrols >= 1) {
      self playlocalsound("ui_zxp_charge_jump_full");
    }

    if(isDefined(var_0.powers[var_1].ref_128BE)) {
      var_8 = max(int(self.vehicle_occupancy_monitormovementcontrols * 100), 0);
      ref_13FDD(var_0.powers[var_1].ref_128BE, var_8);
    }

    waitframe();
  }

  thread ref_125A1(var_0, var_1);
}

function ref_13982() {
  var_0 = self;
  var_0 endon("death_or_disconnect");
  var_0 notify("applyFOVPresentation");
  var_0 endon("applyFOVPresentation");
  var_0 lerpfovbypreset("zombiearcade");
  var_0 waittill("endSuperJumpFov");
  var_0 lerpfovbypreset("zombiedefault");
}

function ref_1259F() {
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

function ref_125A2(var_0, var_1) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  self endon("playerGhostJumpStop");
  self endon("playerGhostJumpChargeEnd");

  if(var_1 <= 0) {
    return;
  }

  var_2 = scripts\mp\gametypes\br_circle::can_killstreak_be_detected(var_1, int(var_1 * 5), 1);
  var_3 = 1;

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    if(var_3) {
      self.ref_12821[var_0].choppergunner_refillmissiles.bar.color = (1, 0, 0);
    } else {
      self.ref_12821[var_0].choppergunner_refillmissiles.bar.color = (0, 1, 0);
    }

    wait var_2[var_4];
    var_3 = !var_3;
  }
}

function ref_125A1(var_0, var_1) {
  self stopgestureviewmodel("ges_gxp_superjumpcharge");
  self notify("playerGhostJumpChargeEnd");
  self notify("playerGhostJumpStop");
  var_2 = getdvarfloat("scr_br_gxp_powers_jump_min_frac", 0.25);
  var_3 = getdvarint("scr_br_gxp_powers_jump_min_frac_refund", 1);

  if(self.vehicle_occupancy_monitormovementcontrols >= var_2 && !ref_1259F() && ref_125A4() && !self ismantling()) {
    self playsoundtoplayer("br_gov_ghost_jump_plr", self, self);
    self playSound("br_gov_ghost_jump_3p", self, self);
    var_4 = getdvarfloat("scr_br_gxp_powers_jump_velocity", 1300);
    var_5 = self getplayerangles();
    thread ref_1259A();
    ref_1250A(var_5, var_4, self.vehicle_occupancy_monitormovementcontrols);
    thread ref_126D7();
    thread ref_12528();
    self.laststandattackermodifiers = undefined;
    self.vehicle_occupancy_mp_hidecashbag = undefined;
  } else if(var_3) {
    if(level.disable_super_in_turret.spawndistancemax) {
      self.ref_12821[var_1].choppergunner_refillmissiles.bar.frac = 0;
    } else {
      self.ref_12821[var_1].frac = 0;
    }

    ref_13FDD(var_0.powers[var_1].ref_128BE, 0);
    self enableoffhandweapons();
    self allowmelee(1);
    self notify("endSuperJumpFov");
    ref_12614();
  } else {
    ref_12614();
  }

  ref_125A0(var_0, var_1, 1);
}

function ref_1250A(var_0, var_1, var_2, var_3) {
  var_4 = 1;
  var_5 = (0, 0, 20);

  if(!isDefined(var_3)) {
    var_3 = var_5;
  }

  var_6 = var_0;
  var_7 = (0, 0, 1);
  var_8 = (1, 0, 0);

  if(getdvarint("scr_br_gxp_powers_jump_pitch_correction", var_4)) {
    var_7 = propwaitminigameinit();

    if(!isDefined(var_7)) {
      var_7 = (0, 0, 1);
    }

    var_9 = (0, var_6[1], 0);
    var_10 = anglestoright(var_9);
    var_8 = vectorcross(var_7, var_10);
    var_11 = vectortoangles(var_8);
    var_12 = angleclamp180(var_11[0]);
    var_13 = -85;
    var_14 = var_12;
    var_15 = var_6[0];

    if(var_15 > var_12) {
      var_15 = var_12;
    }

    var_16 = getdvarfloat("scr_br_gxp_powers_jump_pitch_correction_at_max", -45);
    var_17 = getdvarfloat("scr_br_gxp_powers_jump_pitch_correction_at_min", 0);
    var_18 = (var_15 - var_13) / (var_14 - var_13);
    var_19 = var_17 + var_18 * (var_16 - var_17);
    var_6 = (var_15 + var_19, var_6[1], var_6[2]);
  }

  var_20 = getdvarfloat("scr_br_gxp_powers_jump_pitch_add", 0);

  if(var_20 != 0) {
    var_6 = (var_6[0] + var_20, var_6[1], var_6[2]);
  }

  var_21 = anglesToForward(var_6);
  var_22 = var_21 * var_2 * var_1;
  var_23 = self.origin + var_3;
  self setOrigin(var_23);
  self setvelocity(var_22);
  glassradiusdamage(self.origin + (0, 0, 30), 30, 50, 51);
  var_24 = anglesToForward(self.angles);
  var_25 = self.origin + (0, 0, 30) + var_24 * 15;
  radiusdamage(var_25, 100, 1, 1);
}

function ref_1259A() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self setscriptablepartstate("skydiveVfx", "enabled_ghost", 0);
  self enableoffhandweapons();
  self giveandfireoffhand("gxp_superjump_mp");
  wait 0.4;
  self notify("endSuperJumpFov");
  self forceplaygestureviewmodel("ges_gxp_superjump");

  while(!ref_1259D()) {
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

function ref_125A4() {
  if(level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols != 0) {
    var_0 = self.origin + (0, 0, level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols);
    var_1 = playerphysicstrace(self.origin, var_0);

    if(var_1 != var_0) {
      return false;
    }
  }

  if(level.disable_super_in_turret.vehicle_occupancy_mp_changedseats != 0) {
    var_2 = self getEye();
    var_0 = var_2 + (0, 0, level.disable_super_in_turret.vehicle_occupancy_mp_changedseats);
    var_3 = 10;
    var_4 = 20;
    var_5 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);
    var_1 = scripts\engine\trace::capsule_trace(var_2, var_0, var_3, var_4, (0, 0, 0), self, var_5);

    if(var_1["fraction"] != 1) {
      return false;
    }
  }

  return true;
}

function ref_126D7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("ghost_unset");
  var_0 = getdvarfloat("scr_br_gxp_air_control", 400);

  if(var_0 <= 0) {
    return;
  }

  var_1 = getdvarfloat("scr_br_gxp_air_control_max_speed", 1400);
  var_2 = getdvarfloat("scr_br_gxp_ghost_fall_speed_scale", 0.85);
  wait 0.2;

  while(!ref_1259D()) {
    var_3 = self getnormalizedmovement();

    if(length(var_3) > 0) {
      var_4 = rotatevector((var_3[0], -1 * var_3[1], 0), self.angles);
      var_5 = self getvelocity();
      var_6 = length(var_5);
      var_7 = var_4 * var_0 * level.framedurationseconds;
      var_8 = var_5 + var_7;
      var_9 = length(var_8);

      if(var_9 <= var_1) {
        if(var_8[2] < 0) {
          var_8 = (var_8[0], var_8[1], var_8[2] * var_2);
        }

        self setvelocity(var_8);
      } else if(var_6 < var_1) {
        var_8 = vectorNormalize(var_8) * var_1;

        if(var_8[2] < 0) {
          var_8 = (var_8[0], var_8[1], var_8[2] * var_2);
        }

        self setvelocity(var_8);
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
  var_0 = getdvarfloat("scr_br_gxp_clear_moving_platfrom_time", 0.3);

  if(var_0 < 0) {
    return;
  }

  if(var_0 > 0) {
    wait var_0;
  }

  self method_87b1();
}

function ref_125A0(var_0, var_1, var_2) {
  if(istrue(var_2)) {
    thread ref_12639(var_0, var_1);
  }

  self.vehicle_occupancy_monitormovementcontrols = undefined;
}

function ref_1259D() {
  return self isonground() || self isonladder() || self ismantling();
}

function ref_125A3(var_0, var_1) {
  if(isDefined(self.vehicle_occupancy_monitormovementcontrols)) {
    ref_125A1(var_0, "jump");
    return;
  }

  self notify("playerGhostJumpStop");
}

function ref_125B0(var_0, var_1) {
  var_2 = self;
  var_3 = getdvarfloat("scr_br_gxp_ghost_teleport_distance", 400);
  var_4 = var_2 getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = var_2 getEye();
  var_7 = var_6 + var_5 * var_3;
  var_7 = chase_hvt_vo(var_2, var_7, var_6, var_5);

  if(!isDefined(var_2) || !isDefined(var_2.ref_12821)) {
    return;
  }

  if(isDefined(var_7)) {
    thread ref_1262C(var_2, var_0);
    return;
  }

  ref_12614(var_2);

  if(level.disable_super_in_turret.spawndistancemax) {
    var_2.ref_12821["teleport"].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(0.05, 0);
  } else {
    var_2.ref_12821["teleport"].frac = 0.05;
  }

  thread ref_12639(var_2, var_0);
}

function chase_hvt_vo(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  var_6 = [self];

  if(isDefined(var_4)) {
    GscBinSkip0(0x2e, var_6.size, var_4);
  }

  var_7 = var_0 + var_2 * 10;
  var_8 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 1);
  var_9 = scripts\engine\trace::ray_trace(var_1, var_0, var_6, var_8);
  var_10 = var_9["position"];

  if(var_10 == var_0) {
    var_11 = var_0;
  } else {
    var_11 = var_11 - var_3 * 10 + var_10["normal"] * 10;
  }

  var_12 = var_11 + (0, 0, 72);
  var_13 = scripts\engine\trace::ray_trace(var_11, var_12, var_7, var_9);
  var_14 = var_13["position"];

  if(abs(var_14[2] - var_12[2]) > 1) {
    var_15 = var_14 - (0, 0, 72);
    var_16 = scripts\engine\trace::ray_trace(var_14, var_15, var_7, var_9);
    var_17 = var_16["position"];

    if(abs(var_17[2] - var_15[2]) > 1) {
      var_11 = undefined;
    } else {
      var_11 = var_17;
    }
  }

  if(isDefined(var_11) && positionwouldtelefrag(var_11, self)) {
    var_11 = undefined;
  }

  if(isDefined(var_11)) {
    var_18 = self gettagorigin("j_spineupper");
    var_19 = self gettagangles("j_spineupper");
    playFX(level.disable_super_in_turret.ref_13AEA, var_18, anglesToForward(var_19), anglestoup(var_19));
    self enableoffhandweapons();
    self giveandfireoffhand("gxp_teleport_mp");

    if(var_4) {
      var_20 = getdvarfloat("scr_br_gxp_ghost_teleport_delay", 0.1);
      wait var_20;
    }

    if(!isDefined(self)) {
      return undefined;
    }

    self setOrigin(var_11);
    playFXOnTag(level.disable_super_in_turret.ref_13AEA, self, "j_spineupper");
    playfxontagforclients(level.disable_super_in_turret.ref_13AE9, self, "tag_eye", self);

    if(istrue(var_6)) {
      var_21 = self getvelocity();
      var_22 = length(var_21);
      var_23 = var_3 * var_22 * 0.5;
      self setvelocity(var_23);
      self playsoundtoplayer("br_gov_safespace_repel", self, self);
      self playSound("br_gov_safespace_repel_3p", self, self);
    } else {
      self playsoundtoplayer("br_gov_ghost_teleport_plr", self, self);
      self playSound("br_gov_ghost_teleport_3p", self, self);
    }
  }

  return var_11;
}

function sat_piece_think(var_0) {
  if(isDefined(var_0)) {
    wait var_0;
  }

  self enableplayerbreathsystem(1);
}

function ref_125AD(var_0, var_1) {
  var_2 = 64;
  var_3 = var_2 * var_2;
  var_4 = getdvarfloat("scr_br_gxp_ghost_blast_radius", 768);
  var_5 = var_4 * var_4;
  var_6 = "zxp_emp_fire_plr";
  var_7 = self;
  var_7 enableplayerbreathsystem(0);
  var_7 playsoundonmovingent(var_6);
  var_7 playsoundtoplayer("br_gov_ghost_blast_plr", var_7, var_7);
  var_7 playSound("br_gov_ghost_blast_3p", var_7, var_7);
  thread sat_piece_think(var_7);
  playFXOnTag(level.disable_super_in_turret.ref_136E3, var_7, "j_spineupper");
  playfxontagforclients(level.disable_super_in_turret.ref_136E2, var_7, "tag_eye", var_7);
  self enableoffhandweapons();
  self giveandfireoffhand("gxp_blast_mp");
  var_7 playRumbleOnEntity("defaultweapon_fire");
  var_7 earthquakeforplayer(0.1, 0.3, var_7.origin, 100);
  var_8 = getcompleteweaponname("emp_drone_non_player_mp");
  var_9 = getcompleteweaponname("emp_drone_non_player_direct_mp");
  var_10 = scripts\cp_mp\emp_debuff::get_emp_ents();

  foreach(var_12 in var_10) {
    var_13 = var_12.owner;
    jumpiffalse(isDefined(var_13)) LOC_0000010f;
    var_14 = distancesquared(var_7.origin, var_12.origin);

    if(var_14 > var_5) {
      continue;
    }

    var_15 = scripts\engine\utility::ter_op(var_14 > var_3, var_8, var_9);
    var_12 dodamage(1, var_7.origin, var_7, var_7, "MOD_EXPLOSIVE", var_15);
    var_12 playsoundonmovingent("zxp_emp_impact_ent");
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_7, var_12, 1, var_15, "MOD_EXPLOSIVE", var_7, var_7.origin);
    thread ref_12586(var_16);
    LOC_00000182:
  }

  var_18 = getcompleteweaponname("emp_drone_player_mp");
  var_19 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
    var_19 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](var_7.origin, var_4);
  }

  var_20 = var_7 getEye();
  var_21 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);

  foreach(var_23 in var_19) {
    if(var_23 scripts\mp\gametypes\br_public::ref_125EC()) {
      continue;
    }

    if(var_23 != var_7 && !scripts\cp_mp\utility\player_utility::playersareenemies(var_7, var_23)) {
      continue;
    }

    if(scripts\mp\gametypes\br_gxp_safe_zones::truckdoorleft(var_23)) {
      continue;
    }

    var_24 = scripts\engine\trace::ray_trace_passed(var_20, var_23 gettagorigin("j_head"), self, var_21);

    if(!var_24) {
      continue;
    }

    var_23 dodamage(1, var_7.origin, var_7, var_7, "MOD_EXPLOSIVE", var_18);
    var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_7, var_23, 1, var_18, "MOD_EXPLOSIVE", var_7, var_7.origin);
    thread ref_12586(var_16);
    LOC_00000292:
  }

  thread ref_1262C(var_0, var_1);
}

function ref_1262C(var_0, var_1) {
  if(level.disable_super_in_turret.spawndistancemax) {
    self.ref_12821[var_1].choppergunner_refillmissiles scripts\mp\hud_util::updatebar(1, 0);
  } else {
    self.ref_12821[var_1].frac = 1;
  }

  thread ref_12639(var_0, var_1);
}

function ref_12586(var_0) {
  var_1 = getdvarfloat("scr_br_gxp_ghost_blast_emp_duration", 5);
  var_2 = getdvarfloat("scr_br_gxp_ghost_blast_shellshock_duration", 5);
  var_3 = var_0.victim;

  if(isPlayer(var_3)) {
    var_3 playSound("zxp_emp_impact_plr");
    var_4 = scripts\engine\utility::ter_op(getdvarint("scr_br_gxp_ghost_blast_shellshock_nerf", 0), "gxp_scream_mp_nerfed", "gxp_scream_mp");
    var_3 scripts\cp_mp\utility\shellshock_utility::_shellshock(var_4, "gas", var_2, 1);
    playfxontagforclients(level.disable_super_in_turret.ref_136E4, var_3, "tag_eye", var_3);
    return;
  }

  scripts\cp_mp\emp_debuff::apply_emp_struct(var_0);
  moraleslaptopthink(var_0, var_1);

  if(isDefined(var_3)) {
    var_3 scripts\cp_mp\emp_debuff::remove_emp();
    return;
  }
}

function moraleslaptopthink(var_0, var_1) {
  var_0.victim endon("death_or_disconnect");
  level endon("game_ended");
  var_2 = scripts\engine\utility::waittill_notify_or_timeout_return("emp_cleared", var_1);

  if(var_2 != "emp_cleared") {
    var_0.empremoved = 1;
    return;
  }
}

function ref_125B1(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("playerGhostTeleportOrSpectralBlast");
  self endon("playerGhostTeleportOrSpectralBlast");
  var_2 = gettime() + getdvarint("scr_br_gxp_teleport_or_spectral_blast_timeout_ms", 500);

  while(var_2 > gettime()) {
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

function ref_125B2(var_0, var_1) {
  self notify("playerGhostTeleportOrSpectralBlast");
}

function nukefridgewatcher() {
  return scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle";
}

function modifyplayerdamage(var_0) {
  var_1 = var_0.damage;
  var_2 = isPlayer(var_0.attacker) && var_0.attacker scripts\mp\gametypes\br_public::ref_125EC();
  var_3 = isDefined(var_0.attacker) && nukefridgewatcher(var_0.attacker);
  var_4 = isPlayer(var_0.victim) && var_0.victim scripts\mp\gametypes\br_public::ref_125EC();
  var_5 = scripts\mp\utility\weapon::getweaponbasenamescript(var_0.objweapon);

  if(var_2 && var_4 && var_0.meansofdeath == "MOD_MELEE") {
    if(!level.disable_super_in_turret.school_guards_behavior) {
      var_1 = 0;
    } else {
      var_1 = level.disable_super_in_turret.school_guards_behavior_internal;
    }
  } else if(var_2 && !var_4 && !var_0.attacker isinexecutionattack() && var_0.victim isinexecutionvictim()) {
    var_1 = 0;
  } else if(isDefined(var_0.attacker) && istrue(var_0.attacker.isjuggernaut) && var_4 && var_0.meansofdeath == "MOD_MELEE") {
    var_1 = var_0.victim.maxhealth / 3;
  } else if(var_4 && var_0.meansofdeath == "MOD_FALLING") {
    var_1 = 0;
  } else if(var_4 && isDefined(var_0.inflictor) && isDefined(var_0.inflictor.streakinfo) && (var_0.inflictor.streakinfo.streakname == "toma_strike" || var_0.inflictor.streakinfo.streakname == "precision_airstrike" || var_0.inflictor.streakinfo.streakname == "manual_turret")) {
    var_6 = var_0.victim.maxhealth;
    var_7 = var_0.attacker.maxhealth;
    var_1 = var_0.damage * int(floor(var_6 / var_7));
  } else if(level.disable_super_in_turret.school_guards_rpg_shoot_into_windows && var_4 && isexplosivedamagemod(var_0.meansofdeath) && isDefined(var_0.inflictor) && var_0.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_1 = 0;
  } else if(var_4 && (var_0.meansofdeath == "MOD_GRENADE_SPLASH" || var_0.meansofdeath == "MOD_EXPLOSIVE" || var_0.meansofdeath == "MOD_FIRE") && (var_5 == "molotov_mp" || var_5 == "thermite_av_mp")) {
    var_1 = var_0.damage * level.disable_super_in_turret.school_guards_rpg_guys;
  } else if(var_2 && !var_4 && var_0.meansofdeath == "MOD_MELEE") {
    var_8 = var_0.victim.maxhealth;
    var_9 = level.disable_super_in_turret.saveweaponstates;

    if(istrue(var_0.victim.isjuggernaut)) {
      var_9 = level.disable_super_in_turret.saw_2_angles;
    }

    if(!level.disable_super_in_turret.sat_wait_for_antenna) {
      var_8 += var_0.victim.br_maxarmorhealth;
    }

    if(istrue(var_0.victim.inlaststand)) {
      var_8 = level.laststandhealth;
      var_9 = level.disable_super_in_turret.saw_2_origin;
    }

    var_1 = int(ceil(var_8 / var_9));
  } else if(var_4 && var_3 && istrue(var_0.victim.ref_1423B)) {
    var_1 = 0;
  } else if(var_4 && var_3 && level.disable_super_in_turret.scn_infil_tango_npc_4_sfx) {
    var_1 = 0;
    ref_1424A(var_0);
  } else if(var_2 && !var_4 && var_0.meansofdeath == "MOD_IMPACT" && var_5 == "rock_mp") {
    var_10 = spawnStruct();
    var_10.origin = var_0.point;
    var_0.victim thread scripts\mp\equipment\concussion_grenade::applyconcussion(var_10, var_0.attacker);
  } else if(var_4) {
    var_11 = 0.7;
    var_12 = scripts\mp\utility\weapon::getweaponrootname(var_0.objweapon);
    var_13 = weaponclass(var_5);
    var_14 = scripts\mp\gametypes\br::tutzonetriggerlogic(var_0.idflags);

    if(!var_14) {
      switch (var_13) {
        case "sniper":
          if(var_0.shitloc == "head" || var_0.shitloc == "helmet") {
            if(scripts\mp\gametypes\br::usefailvehiclemsg(var_12)) {
              var_1 = int(ceil(level.disable_super_in_turret.sat_wait_for_activated_think * var_11));
            } else {
              var_1 = level.disable_super_in_turret.sat_wait_for_activated_think;
            }
          }

          break;
        default:
          if(var_0.shitloc == "head" || var_0.shitloc == "helmet") {
            var_15 = getdvarfloat("scr_player_maxhealth", 100);
            var_16 = var_15;

            if(level.disable_super_in_turret.ref_14061) {
              var_16 += scripts\mp\gametypes\br_armor::getdefaultmaxarmorhealth();
            }

            var_1 = int(ceil(var_1 / var_16 * level.disable_super_in_turret.sat_wait_for_activated_think * level.disable_super_in_turret.sat_wait_for_access_card));
          }

          break;
      }
    }

    var_17 = "scr_br_gxp_scale_" + var_13;
    var_18 = 0;

    if(var_13 == "spread") {
      var_18 = 0.7;
    }

    var_19 = getdvarfloat(var_17, var_18);

    if(var_19 != 0) {
      var_1 = int(ceil(var_1 * var_19));
    }

    var_20 = "scr_br_gxp_scale_" + var_12;
    var_18 = 0;

    if(var_12 == "iw8_sh_charlie725") {
      var_18 = 1.43;
    }

    var_21 = getdvarfloat(var_20, var_18);

    if(var_21 != 0) {
      var_1 = int(ceil(var_1 * var_21));
    }

    if(var_0.meansofdeath == "MOD_RIFLE_BULLET" || var_0.meansofdeath == "MOD_PISTOL_BULLET") {
      var_1 = int(ceil(var_1 * level.disable_super_in_turret.sceneangles));
    } else if(var_0.meansofdeath == "MOD_MELEE") {
      var_1 = int(ceil(var_1 * level.disable_super_in_turret.school_guards_wake_behavior));
    }
  }

  if(var_1 > 0 && var_2 && !var_4 && var_0.attacker isinexecutionattack() && var_0.victim isinexecutionvictim()) {
    level.disabled_permanently = gettime();
  }

  return var_1;
}

function ref_12604() {
  if(scripts\mp\gametypes\br_public::ref_125EC()) {
    return;
  }

  scripts\mp\gametypes\br::ref_11E23();
}

function droponplayerdeath(var_0) {
  if(scripts\mp\gametypes\br_public::ref_125EC()) {
    return true;
  }

  if(level.disable_super_in_turret.spawndomplateflagtestmap) {
    ref_125FC();
  }

  return false;
}

function onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(isDefined(self)) {
    thread ref_131A5();
  }

  if(level.gameended) {
    return;
  }

  var_1 = var_0.victim;
  var_2 = var_0.attacker;

  if(!isDefined(var_2) || !isPlayer(var_2) || !isDefined(var_1)) {
    return;
  }

  if(ref_13302(var_1, var_2, var_0.meansofdeath)) {
    thread ref_13662(var_1, var_1);
  }

  if(istrue(level.disable_super_in_turret.sat_signal_lost_nag) && ref_13300(var_1, var_2)) {
    thread ref_1365A(var_1, var_1);
  }

  if(ref_13326(var_1, var_2)) {
    thread ref_1258B();
  }

  if(ref_13306(var_2, var_0)) {
    thread ref_12587();
  }

  var_3 = var_0.hitloc;

  if(isDefined(var_3) && var_1 scripts\mp\gametypes\br_public::ref_125EC() && (var_3 == "head" || var_3 == "helmet")) {
    var_4 = 0;
    var_2 thread scripts\mp\damagefeedback::updatedamagefeedback("hitzombieheadshot", var_4, 1);
  }

  if(var_1 scripts\mp\gametypes\br_public::ref_125EC()) {
    var_5 = var_1 gettagorigin("j_spineupper");
    var_6 = var_1 gettagangles("j_spineupper");
    playFX(level.disable_super_in_turret.sat_setup_access_card_pickup, var_5, anglesToForward(var_6), anglestoup(var_6));
  }

  var_1 setscriptablepartstate("skydiveVfx", "default", 0);
}

function ref_131A5() {
  self endon("disconnect");

  if(!scripts\mp\gametypes\br_public::ref_125EC()) {
    return;
  }

  self waittill("spawned");
  scripts\mp\utility\player::_setsuit("iw8_defaultsuit_mp");
}

function ref_13302(var_0, var_1) {
  if(!ref_13325(var_0)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125EC()) {
    return false;
  }

  if(var_1 == "MOD_EXECUTION") {
    if(!level.disable_super_in_turret.scavenger_cache_hint && !istrue(self.inlaststand)) {
      return false;
    }
  }

  if(scripts\mp\gametypes\br_gxp_safe_zones::truckdoorleft(self)) {
    return false;
  }

  return true;
}

function ref_13306(var_0) {
  if(!level.disable_super_in_turret.scalesitesbyteams) {
    return false;
  }

  if(var_0.meansofdeath != "MOD_EXECUTION") {
    return false;
  }

  if(var_0.victim scripts\mp\gametypes\br_public::ref_125EC()) {
    return false;
  }

  if(!level.disable_super_in_turret.scavenger_cache_hint && istrue(var_0.victim.inlaststand)) {
    return false;
  }

  if(!var_0.attacker scripts\mp\gametypes\br_public::ref_125EC()) {
    return false;
  }

  return true;
}

function ref_13662(var_0, var_1) {
  var_2 = spawndogtags();
  ref_13238(var_2, var_0.origin);

  if(istrue(var_0.isjuggernaut)) {
    var_3 = 2;
    var_4 = getdvarint("scr_br_gxp_numDropJugg", var_3);
    var_5 = scripts\mp\gametypes\br_pickups::test_ai_anim();

    for(var_6 = 1; var_6 < var_4; var_6++) {
      var_7 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_5, var_0.origin, var_0.angles, var_0, undefined, undefined, 0);

      if(!isDefined(var_7) || var_7.origin == (0, 0, 0)) {
        var_7.origin = var_0.origin;
      }

      var_2 = spawndogtags();
      ref_13238(var_2, var_7.origin);
    }

    return;
  }
}

function ref_13300(var_0) {
  if(!ref_13325(var_0)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125EC()) {
    if(randomintrange(1, 101) <= level.disable_super_in_turret.sat_signal_shift) {
      return true;
    }
  }

  return false;
}

function ref_1365A(var_0, var_1) {
  var_2 = spawndogtags();
  ref_13238(var_2, var_0.origin);
}

function ref_13326(var_0) {
  if(!ref_13325(var_0)) {
    return false;
  }

  if(!scripts\mp\gametypes\br_public::ref_125EC()) {
    return false;
  }

  return true;
}

function ref_1258B() {
  if(!isDefined(level.disable_super_in_turret.sat_wait_for_radar) || level.disable_super_in_turret.sat_wait_for_radar.size <= 0) {
    return;
  }

  self.itemsdropped = 0;
  var_0 = [];

  for(var_1 = 0; var_1 < level.disable_super_in_turret.sat_wait_for_power_think; var_1++) {
    if(randomintrange(1, 101) > level.disable_super_in_turret.sat_wait_for_power) {
      continue;
    }

    var_2 = randomintrange(0, level.disable_super_in_turret.sat_wait_for_radar.size);
    var_3 = level.disable_super_in_turret.sat_wait_for_radar[var_2];
    var_0 = var_3;
  }

  var_4 = scripts\mp\gametypes\br_lootcache::ref_11A42(var_0, 0);
}

function ref_13325(var_0) {
  if(isDefined(var_0) && var_0 == self) {
    return false;
  }

  if(level.teambased && isDefined(var_0) && isDefined(var_0.team) && var_0.team == self.team) {
    return false;
  }

  if(isDefined(var_0) && !isDefined(var_0.team) && (var_0.classname == "trigger_hurt" || var_0.classname == "worldspawn")) {
    return false;
  }

  if(isagent(self) || isagent(var_0)) {
    return false;
  }

  return true;
}

function spawndogtags() {
  var_0 = 16;
  var_1 = undefined;
  var_2 = 0;
  var_3 = undefined;

  if(level.disable_super_in_turret.ref_12CB1.size > 0) {
    var_4 = level.disable_super_in_turret.ref_12CB1.size - 1;
    var_1 = level.disable_super_in_turret.ref_12CB1[var_4];
    level.disable_super_in_turret.ref_12CB1[var_4] = undefined;
    loadoutprimaryaddblueprintattachments(var_1);
    var_2 = 1;
    var_3 = var_1.trigger;
    var_5 = var_1.visuals;
  } else {
    jumpiffalse(level.disable_super_in_turret.ref_12CB0.size >= level.disable_super_in_turret.ref_11B5B) LOC_000000b4;
    var_2 = resetdangercircleorigin();
    loadoutprimaryaddblueprintattachments(var_2);
    var_3 = 1;
    var_5 = var_2.trigger;
    var_5 = var_2.visuals;
    goto LOC_00000164;
  }

  LOC_00000164:
    var_7 = "any";
  var_8 = 0;
  var_3 = scripts\mp\gameobjects::createuseobject(var_7, var_5, var_5, (0, 0, var_2), undefined, var_5);
  var_3.ref_133E5 = 1;
  var_3.onuse = &onuse;
  var_3 scripts\mp\gameobjects::setusetime(var_8);
  var_3 scripts\mp\gametypes\br_public::timeoutonabandonedcallback();
  var_3.inuse = 1;
  var_3.lastusedtime = gettime();
  var_9 = "" + var_3 getentitynumber();
  level.disable_super_in_turret.ref_12CB0[var_9] = var_3;
  return var_3;
}

function ref_13238(var_0, var_1) {
  var_2 = 36;
  var_3 = (0, 0, 36);
  var_4 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_1, 30);
  var_5 = var_4 + (0, 0, var_2);
  var_0.curorigin = var_5;

  if(level.disable_super_in_turret.ref_13A25) {
    var_0.trigger.origin = var_5;
  }

  var_0.visuals[0].origin = var_5;
  var_0 scripts\mp\gameobjects::initializetagpathvariables();
  var_0.interactteam = "any";
  ref_13378(var_0.visuals[0]);
  var_0.ownerteam = "neutral";
  var_0.trigger triggerenable();

  if(isDefined(var_0.objidnum)) {
    if(var_0.objidnum != -1) {
      var_6 = var_0.objidnum;
      scripts\mp\objidpoolmanager::update_objective_state(var_6, "active");
      scripts\mp\objidpoolmanager::update_objective_position(var_6, var_4 + var_3);
      scripts\mp\objidpoolmanager::update_objective_setbackground(var_6, 1);
      scripts\mp\objidpoolmanager::objective_set_play_intro(var_0.objidnum, 0);
      scripts\mp\objidpoolmanager::objective_set_play_outro(var_0.objidnum, 0);
      var_0 scripts\mp\gameobjects::setobjectivestatusicons("waypoint_dogtags_friendly", "waypoint_dogtags");
      var_0 scripts\mp\gameobjects::setvisibleteam("any");
      objective_icon(var_0.objidnum, "icon_minimap_soul");
      scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0.objidnum);
    }
  }

  playsoundatpos(var_5, "mp_killconfirm_tags_drop");
  var_0.visuals[0] scriptmodelplayanim("mp_dogtag_spin");
}

function loadoutprimaryaddblueprintattachments(var_0) {
  var_0.visuals[0] dontinterpolate();
  var_0.visuals[0] hide();
  var_0.trigger triggerdisable();
  var_0.trigger notify("deleted");
  var_0 scripts\mp\gameobjects::allowuse("none");
  var_0.inuse = 0;
  var_0.visuals[0].origin = (0, 0, 0);
  var_0.trigger.origin = (0, 0, 0);
  headlessinfilplayers(var_0);
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(var_0.objidnum);
}

function resetdangercircleorigin() {
  var_0 = undefined;

  foreach(var_2 in level.disable_super_in_turret.ref_12CB0) {
    if(!isDefined(var_0) || var_2.lastusedtime < var_0.lastusedtime) {
      var_0 = var_2;
    }
  }

  return var_0;
}

function onuse(var_0) {
  thread ref_120A7(var_0);
}

function ref_120A7(var_0) {
  if(!isDefined(var_0)) {
    thread removetags(self);
    return;
  }

  if(!playercanusetags(var_0)) {
    return;
  }

  thread removetags(self);
  var_0.ref_11F39++;

  if(level.disable_super_in_turret.spawndistancemax) {
    ref_125D4(var_0);
  }

  ref_13FDD(var_0, "numVaccine", var_0.ref_11F39);

  if(isDefined(level.disable_super_in_turret.ref_11B5B) && var_0.ref_11F39 >= level.disable_super_in_turret.saw_3_origin) {
    thread ref_12587();
    return;
  }
}

function ref_13378() {
  self hide();

  if(!level.disable_super_in_turret.ref_13A25) {
    self makeusable();
    self setCursorHint("HINT_NOICON");
    self setHintString(&"MP_ZXP/PICKUP");
    self setuseprioritymax();
  }

  foreach(var_1 in level.players) {
    ref_12CB2(var_1);
  }
}

function headlessinfilplayers(var_0) {
  foreach(var_2 in level.players) {
    if(!var_2 scripts\mp\gametypes\br_public::ref_125EC()) {
      continue;
    }

    var_3 = var_2 getnodeoffset_code(7);

    if(var_3 != -1 && var_3 == var_0.objidnum) {
      var_2 scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout(7);
    }
  }
}

function removetags(var_0) {
  loadoutprimaryaddblueprintattachments(var_0);
  var_1 = "" + var_0 getentitynumber();
  level.disable_super_in_turret.ref_12CB0[var_1] = undefined;
  level.disable_super_in_turret.ref_12CB1[level.disable_super_in_turret.ref_12CB1.size] = var_0;
  playFX(level._effect["ghost_soul_pickup"], var_0.curorigin);
  playsoundatpos(var_0.curorigin, "br_gov_soul_pickup");
}

function playercanusetags(var_0) {
  return var_0 scripts\mp\gametypes\br_public::ref_125EC();
}

function ref_125D4() {
  var_0 = (0, 1, 0);
  self.spawnboardroom_juggdrop setvalue(self.ref_11F39);
  thread spawn_vindia_assault3(self.spawnboardroom_juggdrop);
  thread spawn_vindia_assault3(self.spawnboardroom_loadoutdrop);
}

function ref_12587(var_0) {
  if(!istrue(var_0) && !scripts\mp\gametypes\br_public::ref_125EC()) {
    return;
  }

  var_1 = scripts\mp\gametypes\br_public::ref_125EC() || istrue(self.ref_14438);

  if(var_1) {
    scripts\mp\gametypes\br_gametype_gxp_challenges::ref_11FEF(self);
    self.scn_infil_tango_npc_2_sfx = 1;
  }

  ref_1267E(0);
  ref_125AE(0);
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
  self.ref_12CA8 = 1;
  var_2 = self.origin;
  var_3 = self.origin;
  var_4 = self getplayerangles();
  var_5 = 0;

  if(level.disable_super_in_turret.spawndragonsbreathstruct) {
    var_6 = ref_125DD();
    var_3 = var_6[0];
    var_4 = var_6[1];
    var_2 = var_6[2];
    var_6 = undefined;
  } else {
    var_7 = ref_125DE();
    var_3 = var_7[0];
    var_4 = var_7[1];
    var_5 = var_7[2];
    var_7 = undefined;
    var_2 = var_3;
  }

  self.plotarmor = 1;
  self setscriptablepartstate("ghost", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  ref_125AA();

  if(!var_5) {
    scripts\mp\gametypes\br_gulag::gulagfadetoblack();
    wait 1;
  } else {
    waitframe();
  }

  scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  self.pers["gamemodeLoadout"] = level.br_respawn_loadout;
  self.pers["class"] = "gamemode";
  self.class = "gamemode";
  self.forcespawnangles = var_4;
  self.forcespawnorigin = var_2;
  scripts\mp\utility\player::_setsuit("iw8_defaultsuit_mp");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self skydive_deployparachute();
  thread scripts\mp\gametypes\br::defend_wave_2();
  ref_125B3(1);
  self enableexecutionvictim();
  self method_87b2();
  self lerpfovbypreset("default_2seconds");

  if(level.disable_super_in_turret.score_event_accuracy) {
    thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
  }

  if(level.disable_super_in_turret.score_accuracy_think) {
    ref_125DA();

    if(!level.disable_super_in_turret.score_event_accuracy) {
      self setscriptablepartstate("headVFX", "neutral");
    }

    self visionsetnakedforplayer("", 0);
  }

  if(level.disable_super_in_turret.spawndragonsbreathstruct) {
    self.plotarmor = undefined;
    ref_126BD(var_3, var_4, var_2);
  } else {
    if(!var_5) {
      scripts\mp\gametypes\br_public::ref_126ED();
      scripts\mp\gametypes\br_public::ref_1252B();
      playFX(scripts\engine\utility::getfx("ghost_trans"), self.origin);
      playfxontagforclients(level.disable_super_in_turret.scn_infil_tango_npc_1_sfx, self, "tag_eye", self);
    }

    if(!var_5) {
      scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    }

    thread ref_1252C();
  }

  if(istrue(level.disable_super_in_turret.spawndomplateflagtestmap) && ref_125FA()) {
    ref_125FB();
  } else {
    var_8 = scripts\mp\gametypes\br::disablealltablets();
    scripts\mp\gametypes\br::searchcircleorigin(var_8, 0);
  }

  scripts\mp\gametypes\br_armor::searchcirclesize();
  thread scripts\mp\gametypes\br::defend_wave_2();

  if(level.disable_super_in_turret.score_accuracy_think) {
    move_objective_icon();
  }

  ref_1262B(0);

  if(var_1) {
    scripts\mp\hud_message::showsplash("br_gametype_gxp_change_human");
  }

  self.plotarmor = undefined;
  thread ref_125D9();
  self.ref_12CA8 = undefined;

  if(var_1) {
    foreach(var_10 in level.teamdata[self.team]["players"]) {
      if(self == var_10) {
        scripts\mp\gametypes\br_public::dmztut_endgamewithreward("player_into_human", var_10);
        continue;
      }

      scripts\mp\gametypes\br_public::dmztut_endgamewithreward("teammate_back_human", var_10);
    }
  }

  self.scn_infil_tango_npc_2_sfx = undefined;
}

function move_objective_icon() {
  if(!isDefined(level.disable_super_in_turret.saw_angles)) {
    return;
  }

  level.disable_super_in_turret.saw_angles = scripts\engine\utility::array_removeundefined(level.disable_super_in_turret.saw_angles);

  foreach(var_1 in level.disable_super_in_turret.saw_angles) {
    scripts\mp\utility\outline::outlineenableforplayer(self, var_1, "outline_depth_zombievision", "top");
  }
}

function spawn_vindia_assault3(var_0) {
  self endon("death");

  if(istrue(self.ref_1293B)) {
    return;
  }

  var_1 = 0.5;
  var_2 = 4;
  self.ref_1293B = 1;
  var_3 = self.fontscale;
  var_4 = self.color;

  if(isDefined(var_0)) {
    self.color = var_0;
  }

  self changefontscaleovertime(var_1);
  self.fontscale = var_2;
  wait var_1;
  self changefontscaleovertime(var_1);
  self.fontscale = var_3;
  wait var_1;
  self.color = var_4;
  self.ref_1293B = undefined;
}

function ref_125DD() {
  var_0 = getdvarint("scr_br_gxp_spawnheightoffset", 3000);
  var_1 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;
  var_2 = scripts\mp\gametypes\br_gulag::ref_125BE(0, var_1, var_0);
  var_3 = scripts\mp\gametypes\br_gulag::ref_1263E(var_2);
  return [var_2.origin, var_2.angles, var_3];
}

function ref_125DE() {
  var_0 = ref_125D8();
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = var_0[2];
  var_0 = undefined;

  if(!var_3) {
    scripts\mp\gametypes\br_public::ref_126B9(var_1);
  }

  return [var_1, var_2, var_3];
}

function ref_125AA() {
  ref_125B3(0);
  var_0 = gettime() + 3000;

  while(self isgestureplaying() && var_0 > gettime()) {
    self stopgestureviewmodel();
    waitframe();
  }

  while(var_0 > gettime() && (self isinexecutionattack() || self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]())) {
    waitframe();
  }

  playFX(scripts\engine\utility::getfx("ghost_trans"), self.origin);
  playfxontagforclients(level.disable_super_in_turret.scn_infil_tango_npc_1_sfx, self, "tag_eye", self);
  self notify("endSuperJumpFov");
  self enableoffhandweapons();
  self giveandfireoffhand("gxp_revive_mp");
  wait 1.25;
}

function ref_125B3(var_0) {
  self allowfire(var_0);
  self allowmovement(var_0);
  self allowmelee(var_0);

  if(var_0) {
    self playershow();
    self enableoffhandweapons();
    return;
  }

  self playerhide();
  self disableoffhandweapons();
}

function ref_1252C() {
  if(!getdvarint("scr_br_gxp_human_spawn_concuss", 0)) {
    return;
  }

  var_0 = 650;
  var_1 = getdvarint("scr_br_gxp_push_radius", var_0);
  var_2 = incrementpersistentstat(level.players, self.origin, var_1);

  foreach(var_4 in var_2) {
    if(var_4 scripts\mp\gametypes\br_public::ref_125F3() && var_4.team != self.team && isalive(var_4)) {
      ref_125D7(var_4, var_1);
    }
  }

  var_6 = anglesToForward(self.angles);
  playFX(level.disable_super_in_turret.start_coop_defuse_infiltrate, self.origin, var_6);
  playsoundatpos(self.origin, "sentry_explode_smoke");
  playrumbleonposition("grenade_rumble", self.origin);
  earthquake(0.5, 1.5, self.origin, var_1);
}

function ref_125FC() {
  var_0 = spawnStruct();
  var_0.ref_12889 = [];
  var_0.brtdm_config = [];
  var_0.brtruck_cleanupents = [];
  var_0.brtruck_ontimelimit = [];
  var_0.offhands = [];
  var_0.nvidiaansel_overridecollisionradius = [];
  var_1 = [];
  var_2 = self getweaponslistprimaries();

  foreach(var_4 in var_2) {
    if(!scripts\mp\utility\weapon::update_health_bar_to_player(var_4) && !issubstr(var_4.basename, "iw8_fists_mp") && !scripts\mp\utility\weapon::unset_relic_mythic(var_4.basename)) {
      var_1 = var_4;
    }
  }

  foreach(var_7 in var_1) {
    var_8 = createheadicon(var_7);
    var_0.brtdm_config[var_8] = weaponclipsize(var_7);
    var_0.brtruck_ontimelimit[var_8] = self getweaponammostock(var_7);

    if(scripts\mp\utility\weapon::turnexfiltoside(var_7)) {
      var_0.brtruck_cleanupents[var_8] = self getweaponammoclip(var_7, "left");
    }

    if(getsubstr(var_8, 0, 4) == "alt_") {
      continue;
    }

    var_0.ref_12889[var_0.ref_12889.size] = var_7;
  }

  if(self.lastcacweaponobj != getcompleteweaponname("none")) {
    foreach(var_4 in var_0.ref_12889) {
      if(self.lastcacweaponobj == var_4) {
        var_0.current = self.lastcacweaponobj;
        break;
      }
    }
  }

  var_12 = self getweaponslistoffhands();

  foreach(var_14 in var_12) {
    if(var_14.basename == "bandage_br") {
      continue;
    }

    var_15 = self getweaponammoclip(var_14);

    if(var_15 <= 0) {
      continue;
    }

    var_0.offhands[var_0.offhands.size] = var_14;
    var_16 = createheadicon(var_14);
    var_0.brtdm_config[var_16] = var_15;
  }

  foreach(var_19 in self.equipment) {
    var_0.nvidiaansel_overridecollisionradius[var_19] = var_20;
  }

  var_0.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent) {
    var_0.super = self.equipment["super"];
  }

  self.setdeleteable = var_0;
}

function ref_125FB() {
  self takeallweapons(0, 1);
  scripts\mp\gametypes\br_weapons::br_ammo_player_clear();
  self.equipment["primary"] = undefined;
  self.equipment["secondary"] = undefined;
  self.equipment["health"] = undefined;
  self.equipment["super"] = undefined;
  var_0 = getcompleteweaponname("iw8_fists_mp");

  if(self.setdeleteable.ref_12889.size < 2) {
    self giveweapon(var_0);
  }

  var_1 = 0;

  foreach(var_3 in self.setdeleteable.ref_12889) {
    var_4 = createheadicon(var_3);
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_3);

    if(!var_1) {
      self assignweaponprimaryslot(var_4);
      scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_3);
      var_1 = 1;
    }

    scripts\mp\weapons::fixupplayerweapons(self, var_4);
  }

  foreach(var_7 in self.setdeleteable.offhands) {
    var_8 = scripts\mp\equipment::getequipmentreffromweapon(var_7);

    if(!isDefined(var_8)) {
      continue;
    }

    var_9 = self.setdeleteable.nvidiaansel_overridecollisionradius[var_8];

    if(!isDefined(var_9)) {
      continue;
    }

    scripts\mp\equipment::giveequipment(var_8, var_9);
  }

  foreach(var_4, var_12 in self.setdeleteable.brtruck_ontimelimit) {
    self setweaponammostock(var_4, var_12);
    var_3 = getcompleteweaponname(getweaponbasename(var_4));
    var_13 = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(var_3);

    if(isDefined(var_13)) {
      self.br_ammo[var_13] = var_12;
      scripts\mp\gametypes\br_weapons::br_ammo_player_hud_update_ammotype(var_13);
    }
  }

  foreach(var_4, var_12 in self.setdeleteable.brtdm_config) {
    self setweaponammoclip(var_4, var_12);
  }

  foreach(var_4, var_12 in self.setdeleteable.brtruck_cleanupents) {
    self setweaponammoclip(var_4, var_12, "left");
  }

  waitframe();
  var_16 = var_0;

  if(isDefined(self.setdeleteable.current)) {
    var_16 = self.setdeleteable.current;
  } else if(isDefined(self.setdeleteable.ref_12889[0])) {
    var_16 = self.setdeleteable.ref_12889[0];
  }

  self switchtoweaponimmediate(var_16);

  if(isDefined(self.setdeleteable.super)) {
    var_17 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[self.setdeleteable.super]];
    scripts\mp\gametypes\br_pickups::forcegivesuper(var_17, 0);
  }

  thread scripts\cp_mp\gestures::ref_13E1A();
  self.setdeleteable = undefined;
}

function ref_125D9() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_set");

  while(!self isonground()) {
    waitframe();
  }

  thread ref_125DB();
}

function ref_125D8() {
  var_0 = 500;
  var_1 = 10000;
  var_2 = 5;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent)) {
    return [self.origin, self getplayerangles(), 1];
  }

  var_3 = scripts\mp\gametypes\br_circle::getdangercircleradius();
  var_4 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
  var_5 = distance2dsquared(self.origin, var_4);

  if(var_5 <= var_3 * var_3) {
    return [self.origin, self getplayerangles(), 1];
  }

  var_6 = undefined;
  var_7 = undefined;
  var_8 = (self.origin[0], self.origin[1], 0);
  var_9 = vectorNormalize(var_8 - var_4);

  for(var_10 = 1; var_10 <= var_2; var_10++) {
    var_11 = var_3 - var_0 * var_10;

    if(var_11 < 0) {
      break;
    }

    var_12 = remove_marker_when_player_disconnects(var_4, var_9, var_11);
    var_6 = var_12[0];
    var_7 = var_12[1];
    var_12 = undefined;

    if(isDefined(var_6)) {
      break;
    }
  }

  if(!isDefined(var_6)) {
    var_6 = var_4;
    var_7 = self getplayerangles();
  }

  var_13 = scripts\mp\gametypes\br_public::modifyplayer_damage(var_6, var_1);
  return [var_13, var_7, 0];
}

function ref_125DB() {
  if(!istrue(level.disable_super_in_turret.spawndomplates)) {
    return;
  }

  thread ref_126B4(level.disable_super_in_turret.human);
}

function remove_marker_when_player_disconnects(var_0, var_1, var_2) {
  var_3 = var_0 + var_1 * var_2;
  var_4 = scripts\mp\gametypes\br_public::relic_nuketimer_gettimeformission() / 1000;

  if(scripts\mp\gametypes\br_gulag::set_relic_rocket_kill_ammo(var_3, var_4)) {
    var_5 = vectortoangles(var_1 * -1);
    return [var_3, var_5];
  }

  return [undefined, undefined];
}

function ref_125FA() {
  return isDefined(self.setdeleteable);
}

function ref_125D7(var_0, var_1) {
  var_2 = 1800;
  var_3 = spawnStruct();
  var_3.origin = self.origin;
  var_0 thread scripts\mp\equipment\concussion_grenade::applyconcussion(var_3, self);
  thread ref_1262E(var_0);
  var_4 = var_0.origin - self.origin;
  var_5 = vectortoangles(var_4);
  var_6 = distance(var_0.origin, self.origin);
  var_7 = 1 - var_6 / var_1;
  ref_1250A(var_0, var_5, var_2, var_7);
}

function ref_1262E(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  self notify("disableCooldown");

  foreach(var_3, var_2 in var_0.powers) {
    if(!isDefined(self.ref_12821[var_3])) {
      continue;
    }

    self.ref_12821[var_3].incooldown = 0;
    thread ref_1262C(var_0, var_3);
  }
}

function watch_flight_collision(var_0) {
  if(scripts\mp\gametypes\br_public::ref_125EC()) {
    var_1 = isDefined(var_0.attacker) && nukefridgewatcher(var_0.attacker);

    if(!var_1 || !level.disable_super_in_turret.scn_infil_tango_npc_5_sfx || level.disable_super_in_turret.scn_infil_tango_npc_4_sfx) {
      return false;
    }

    thread ref_1262E(level.disable_super_in_turret.sat_piece);
    thread ref_125A5();
    thread ref_125B5(var_0);
    thread ref_1258A();
  }

  return true;
}

function ref_125A5() {
  level endon("game_ended");
  self endon("last_stand_finished");
  self endon("death_or_disconnect");
  self waittill("last_stand_transition_done");
  waittillframeend();
  self setlaststandenabled(1);
  self.usedprops = 1;
  self.laststandreviveent makeunusable();
  var_0 = self.laststandreviveent;
  var_0.usetime = getdvarfloat("scr_br_gxp_vehicle_getup", 3) * 1000;

  if(!isDefined(var_0.curprogress)) {
    var_0.curprogress = 0;
  }

  while(scripts\mp\utility\player::isreallyalive(self) && var_0.curprogress < var_0.usetime) {
    if(self isinexecutionvictim()) {
      waitframe();
      continue;
    }

    if(!isDefined(var_0.userate)) {
      var_0.userate = 0;
    }

    var_0.curprogress += level.frameduration * var_0.userate;
    var_0.userate = 1;
    scripts\mp\gameobjects::updateuiprogress(var_0, 1);

    if(var_0.curprogress >= var_0.usetime) {
      break;
    }

    waitframe();
  }

  var_0.usetime = undefined;
  var_0.curprogress = undefined;
  var_0.userate = undefined;
  scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", self);
  self playsoundtoplayer("zmb_breath_land_dropin", self, self);
  self playSound("zmb_npc_breath_land_dropin");
  self setlaststandenabled(0);
}

function ref_125B5(var_0) {
  var_1 = 500;
  var_2 = 90;
  var_3 = 60;
  var_4 = 30;
  var_5 = var_0.direction_vec;
  var_6 = vectortoyaw(var_5);
  var_7 = var_2;
  var_8 = var_3;

  if(scripts\engine\utility::cointoss()) {
    var_8 *= -1;
  }

  var_8 += var_6;
  var_9 = (var_7, var_8, 0);
  var_10 = vectorNormalize((var_5[0], var_5[1], 0));
  var_11 = var_10 * var_4 + (0, 0, var_4);
  ref_1250A(var_9, var_1, 1, var_11);
}

function ref_1258A() {
  self endon("disconnect");
  self.ref_1423B = 1;
  var_0 = getdvarfloat("scr_br_gxp_vehicle_immunity", 1.5);
  wait var_0;
  self.ref_1423B = undefined;
}

function ref_1424A(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.victim;
  var_3 = var_0.direction_vec;
  var_3 = -1 * vectorNormalize((var_3[0], var_3[1], min(var_3[2], 0)));
  var_4 = var_2 getEye();
  var_5 = var_4 + var_3 * 400;
  var_5 = chase_hvt_vo(var_2, var_5, var_4, var_3, 0, var_1);
}

function dangercircletick(var_0, var_1) {
  if(level.disable_super_in_turret.scn_infil_hackney_heli_npc1 != 1) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.ref_12CB0)) {
    return;
  }

  var_2 = var_1 + level.disable_super_in_turret.scn_infil_hackney_heli_npc2;
  var_3 = var_2 * var_2;

  foreach(var_5 in level.disable_super_in_turret.ref_12CB0) {
    if(isDefined(var_5.visuals) && distance2dsquared(var_5.origin, var_0) >= var_3) {
      thread removetags(var_5);
    }
  }
}